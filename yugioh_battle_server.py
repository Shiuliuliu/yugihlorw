#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Yu-Gi-Oh Online - Dedicated Battle Server (Server Trận Đấu Chính)
Port: 9192 (WebSocket)

KIẾN TRÚC ĐỘC LẬP:
- Chỉ chạy DUY NHẤT logic trận đấu (PVP duel runtime):
  * Ghép trận / Bind match
  * Đồng bộ frame thao tác (action, ints, card play, skill trigger)
  * Quản lý lượt đi (turn), đếm giờ & cộng dồn thời gian (+6s per action)
  * Xử lý kết thúc trận đấu (win, loss, surrender) & chống gian lận
  * Hỗ trợ kết nối lại (reconnect) khi đứt mạng giữa trận (60s grace period)
  * Quick chat nội bộ trong trận đấu
- TÁCH BIỆT HOÀN TOÀN với Gateway / API / Lobby:
  * Không mở pack, không query bảng xếp hạng, không tính nhiệm vụ
  * Zero DB blocking queries trong vòng lặp duel -> Đảm bảo 0% giật lag cho trận đấu
"""

import sys
import os
import json
import struct
import time
import random
import asyncio
import urllib.request
import websockets

if sys.platform == 'win32':
    try:
        sys.stdout.reconfigure(encoding='utf-8')
        sys.stderr.reconfigure(encoding='utf-8')
    except Exception:
        pass

WS_PORT = int(os.environ.get("BATTLE_WS_PORT", 9192))
CHAT_HTTP_PORT = int(os.environ.get("CHAT_HTTP_PORT", 8084))

# State trận đấu trong RAM
ACTIVE_MATCHES = {}
WS_CLIENT_META = {}
WS_CONNECTED_CLIENTS = set()
PVP_ROOMS = {}
PVP_QUEUE = []

CHALLENGE_FRAME = bytes.fromhex(
    "0000002b08641000a206240102030452934c32eca7ed0296d67b750000881bfbdd333800ebab8cdbec5001"
)

def make_pvp_frame(payload_dict):
    """Đóng gói frame nhị phân chuẩn Yu-Gi-Oh (>I length prefix + JSON UTF-8)"""
    body = json.dumps(payload_dict, ensure_ascii=False).encode('utf-8')
    return struct.pack(">I", len(body)) + body

def decode_pvp_payload(msg):
    """Giải mã payload từ chuỗi hoặc mảng byte"""
    if isinstance(msg, str):
        try:
            return json.loads(msg)
        except Exception:
            return None
    if isinstance(msg, (bytes, bytearray)):
        if len(msg) >= 4:
            length = struct.unpack(">I", msg[:4])[0]
            if len(msg) >= 4 + length:
                try:
                    return json.loads(msg[4:4+length].decode('utf-8', errors='ignore'))
                except Exception:
                    pass
        try:
            return json.loads(msg.decode('utf-8', errors='ignore'))
        except Exception:
            return None
    return None

def send_chat_broadcast_to_server(msg_obj):
    """Chuyển tiếp tin nhắn chat sảnh về Chat Server (8084) nếu có"""
    try:
        data = json.dumps(msg_obj, ensure_ascii=False).encode('utf-8')
        req = urllib.request.Request(
            f"http://127.0.0.1:{CHAT_HTTP_PORT}/api/chat_send",
            data=data,
            headers={"Content-Type": "application/json; charset=utf-8"},
            method="POST"
        )
        with urllib.request.urlopen(req, timeout=1.5) as resp:
            pass
    except Exception:
        pass

async def safe_send(ws, frame):
    """Gửi an toàn, nuốt ConnectionClosedError nếu client đã ngắt kết nối"""
    if ws is not None:
        try:
            await ws.send(frame)
        except Exception:
            pass

async def battle_ws_handler(websocket):
    client_ip = websocket.remote_address
    print(f"[BATTLE WS] Client connected: {client_ip}")
    WS_CONNECTED_CLIENTS.add(websocket)

    try:
        # Gửi challenge frame chào đón kết nối
        await websocket.send(CHALLENGE_FRAME)

        async for raw_msg in websocket:
            pkt = decode_pvp_payload(raw_msg)
            if not pkt or not isinstance(pkt, dict):
                continue

            t = pkt.get("t")

            # -------------------------------------------------------------
            # 1. BIND MATCH: Kết nối đấu thủ vào trận đấu (Hỗ trợ Reconnect)
            # -------------------------------------------------------------
            if t == "bind_match":
                match_id = str(pkt.get("match_id", ""))
                user_id = str(pkt.get("user_id", ""))
                is_first = pkt.get("first")
                if is_first is None:
                    is_first = pkt.get("is_attacker")
                if is_first is not None:
                    is_first = bool(is_first)
                is_watcher = bool(pkt.get("is_watcher") or pkt.get("is_spectator"))
                reconnected = False

                if match_id:
                    if is_watcher:
                        WS_CLIENT_META[websocket] = {"match_id": match_id, "user_id": user_id, "first": is_first, "is_spectator": True}
                        if match_id not in ACTIVE_MATCHES:
                            ACTIVE_MATCHES[match_id] = {
                                "p1": None, "p2": None,
                                "p1_user": None, "p2_user": None,
                                "p1_reconnect_token": 0, "p2_reconnect_token": 0,
                                "turn_slot": "p1",
                                "turn_ws": None,
                                "turn_start_time": time.time(),
                                "turn_duration": 90,
                                "last_action_time": time.time(),
                                "spectators": {websocket}
                            }
                        else:
                            ACTIVE_MATCHES[match_id].setdefault("spectators", set()).add(websocket)
                        print(f"[BATTLE WS] Match {match_id}: Spectator bound (user {user_id})")
                        await websocket.send(make_pvp_frame({
                            "t": "bind_ok",
                            "match_id": match_id,
                            "is_spectator": True,
                            "reconnected": False
                        }))

                        # Gửi ngay time_sync cho spectator nếu trận đấu đang chạy
                        cur_m = ACTIVE_MATCHES.get(match_id)
                        if cur_m and cur_m.get("turn_ws"):
                            cur_tl = max(0, cur_m.get("turn_duration", 90) - (time.time() - cur_m.get("turn_start_time", time.time())))
                            await safe_send(websocket, make_pvp_frame({
                                "t": "time_sync",
                                "match_id": match_id,
                                "time_left": int(cur_tl),
                                "turn_slot": cur_m.get("turn_slot", "p1")
                            }))
                        continue

                    # Tự động nhận diện spectator nếu cả 2 slot p1, p2 đều đã có user khác
                    if match_id in ACTIVE_MATCHES:
                        m_exist = ACTIVE_MATCHES[match_id]
                        p1_u = str(m_exist.get("p1_user") or "")
                        p2_u = str(m_exist.get("p2_user") or "")
                        if p1_u and p2_u and user_id and user_id != p1_u and user_id != p2_u:
                            WS_CLIENT_META[websocket] = {"match_id": match_id, "user_id": user_id, "first": is_first, "is_spectator": True}
                            m_exist.setdefault("spectators", set()).add(websocket)
                            print(f"[BATTLE WS] Match {match_id}: Auto-detected spectator bound (user {user_id}, p1={p1_u}, p2={p2_u})")
                            await websocket.send(make_pvp_frame({
                                "t": "bind_ok",
                                "match_id": match_id,
                                "is_spectator": True,
                                "reconnected": False
                            }))
                            continue

                    WS_CLIENT_META[websocket] = {"match_id": match_id, "user_id": user_id, "first": is_first}
                    if match_id not in ACTIVE_MATCHES:
                        # Khởi tạo match mới; gán slot dựa vào vai trò đi trước / đi sau
                        slot = "p1" if is_first is not False else "p2"
                        ACTIVE_MATCHES[match_id] = {
                            "p1": websocket if slot == "p1" else None,
                            "p2": websocket if slot == "p2" else None,
                            "p1_user": user_id if slot == "p1" else None,
                            "p2_user": user_id if slot == "p2" else None,
                            "p1_reconnect_token": 0, "p2_reconnect_token": 0,
                            "turn_slot": "p1",
                            "turn_ws": websocket if slot == "p1" else None,
                            "turn_start_time": time.time(),
                            "turn_duration": 90,
                            "last_action_time": time.time(),
                            "spectators": set()
                        }
                        print(f"[BATTLE WS] Match {match_id}: {slot} bound (user {user_id}, first={is_first})")
                    else:
                        match = ACTIVE_MATCHES[match_id]
                        slot = None
                        is_reconnect = False
                        if match.get("p1_user") == user_id and user_id != "":
                            slot = "p1"
                            is_reconnect = True
                        elif match.get("p2_user") == user_id and user_id != "":
                            slot = "p2"
                            is_reconnect = True
                        elif match.get("p1") == websocket:
                            slot = "p1"
                        elif match.get("p2") == websocket:
                            slot = "p2"
                        elif is_first is True and match.get("p1") is None:
                            slot = "p1"
                        elif is_first is False and match.get("p2") is None:
                            slot = "p2"
                        elif match.get("p1") is None:
                            slot = "p1"
                        elif match.get("p2") is None:
                            slot = "p2"
                        else:
                            slot = "p1"

                        peer_slot = "p2" if slot == "p1" else "p1"
                        peer_ws = match.get(peer_slot)
                        old_ws = match.get(slot)
                        if is_reconnect or (old_ws is not None and old_ws != websocket):
                            reconnected = True
                            match[slot] = websocket
                            if match.get("turn_ws") == old_ws or match.get("turn_ws") is None or match.get("turn_ws") != peer_ws:
                                match["turn_ws"] = websocket
                            if user_id:
                                match[f"{slot}_user"] = user_id
                            token_key = f"{slot}_reconnect_token"
                            match[token_key] = match.get(token_key, 0) + 1
                            print(f"[BATTLE WS] Match {match_id}: {slot} reconnected (user {user_id}, token={match[token_key]})")

                            peer_ws = match.get("p2" if slot == "p1" else "p1")
                            if peer_ws:
                                asyncio.create_task(safe_send(peer_ws, make_pvp_frame({
                                    "t": "peer_resumed",
                                    "match_id": match_id,
                                    "msg": "Đối thủ đã kết nối lại trận đấu!"
                                })))
                        else:
                            match[slot] = websocket
                            if user_id:
                                match[f"{slot}_user"] = user_id
                            if slot == "p1" and match.get("turn_ws") is None:
                                match["turn_slot"] = "p1"
                                match["turn_ws"] = websocket
                                match["turn_start_time"] = time.time()
                                match["turn_duration"] = 90
                                match["last_action_time"] = time.time()
                            print(f"[BATTLE WS] Match {match_id}: {slot} bound (user {user_id}, first={is_first})")

                        p1 = match.get("p1")
                        p2 = match.get("p2")
                        if p1 and p2 and not match.get("ready_sent"):
                            match["ready_sent"] = True
                            if match.get("turn_ws") is None:
                                match["turn_slot"] = "p1"
                                match["turn_ws"] = p1
                                match["turn_start_time"] = time.time()
                                match["turn_duration"] = 90
                                match["last_action_time"] = time.time()
                            ready_msg = make_pvp_frame({"t": "peer_ready", "turn_duration": 90, "time_left": 60})
                            asyncio.create_task(safe_send(p1, ready_msg))
                            asyncio.create_task(safe_send(p2, ready_msg))

                    await websocket.send(make_pvp_frame({
                        "t": "bind_ok",
                        "match_id": match_id,
                        "reconnected": reconnected
                    }))

            # -------------------------------------------------------------
            # 2. ACTION: Chuyển tiếp frame thao tác thẻ bài, quản lý giờ & turn
            # -------------------------------------------------------------
            elif t == "action":
                match_id = pkt.get("match_id") or WS_CLIENT_META.get(websocket, {}).get("match_id")
                if match_id and match_id in ACTIVE_MATCHES:
                    match = ACTIVE_MATCHES[match_id]
                    # Khán giả xem đấu không được gửi frame thao tác đánh bài
                    if WS_CLIENT_META.get(websocket, {}).get("is_spectator"):
                        continue

                    if match.get("p1") == websocket:
                        peer_ws = match.get("p2")
                        sender_slot = "p1"
                    elif match.get("p2") == websocket:
                        peer_ws = match.get("p1")
                        sender_slot = "p2"
                    else:
                        peer_ws = None
                        sender_slot = None

                    if peer_ws:
                        try:
                            now_ts = time.time()
                            match["last_action_time"] = now_ts
                            ints = pkt.get("ints", [])
                            card_id = ints[0] if len(ints) > 0 else 0

                            # Reset consecutive timeout count for sender on any card play or voluntary end-round
                            if sender_slot:
                                match[f"{sender_slot}_timeouts"] = 0

                            # Kết thúc lượt
                            if card_id == 1:
                                # Validation: Chỉ người đang cầm lượt mới được gửi kết thúc lượt
                                curr_turn_slot = match.get("turn_slot", "p1")
                                if sender_slot and sender_slot != curr_turn_slot:
                                    print(f"[BATTLE ACTION BLOCKED] Match {match_id}: non-turn player {sender_slot} sent end turn (curr={curr_turn_slot}); dropped to prevent desync")
                                    continue

                                next_slot = "p2" if sender_slot == "p1" else "p1"
                                match["turn_slot"] = next_slot
                                match["turn_ws"] = peer_ws
                                match["turn_start_time"] = now_ts
                                match["turn_duration"] = 90
                                match["turn_bonus"] = 0.0
                                match["round"] = match.get("round", 1) + 1
                                pkt["time_left"] = 90
                                pkt["turn_duration"] = 90
                                print(f"[BATTLE TURN] Match {match_id}: round ended, turn switched to {next_slot}")
                            elif card_id == 999998:
                                continue
                            elif card_id not in (1, 2) and card_id != 0:
                                cur_bonus = float(match.get("turn_bonus", 0.0))
                                rem_bonus = max(0.0, 150.0 - cur_bonus)
                                add_sec = min(6.0, rem_bonus)
                                match["turn_bonus"] = cur_bonus + add_sec

                                pkt["add_time"] = add_sec
                                pkt["max_time"] = 240

                                client_time_left = None
                                if "time_left" in pkt:
                                    try:
                                        client_time_left = float(pkt["time_left"])
                                    except (ValueError, TypeError):
                                        pass

                                elapsed = now_ts - match.get("turn_start_time", now_ts)
                                current_server_left = max(0.0, match.get("turn_duration", 90) - elapsed)
                                # Base = 90s, +6s per action up to 150s max bonus (240s / 4 minutes total cap)
                                new_time_left = min(240.0, current_server_left + add_sec)
                                if client_time_left is not None and client_time_left > 0 and abs(client_time_left - current_server_left) <= 15.0:
                                    new_time_left = min(240.0, max(new_time_left, client_time_left))

                                pkt["time_left"] = new_time_left
                                match["turn_duration"] = new_time_left
                                match["turn_start_time"] = now_ts
                                print(f"[BATTLE TIME] Match {match_id}: round time +{add_sec:.0f}s -> {new_time_left:.1f}s (bonus={match['turn_bonus']:.0f}/150s, max 240s) for card {card_id}")

                            pkt["from"] = sender_slot
                            relayed_frame = make_pvp_frame(pkt)
                            await peer_ws.send(relayed_frame)

                            # Chuyển tiếp tới tất cả khán giả đang theo dõi trận đấu
                            for spec_ws in list(match.get("spectators", set())):
                                if spec_ws != websocket:
                                    asyncio.create_task(safe_send(spec_ws, relayed_frame))

                            print(f"[BATTLE ACTION] Match {match_id}: relayed ints len={len(ints)} from {sender_slot} to peer & {len(match.get('spectators', set()))} spectators")
                        except Exception as e:
                            print(f"[BATTLE ACTION ERR] {e}")
                    else:
                        print(f"[BATTLE ACTION WARN] Match {match_id}: peer not connected yet")

            # -------------------------------------------------------------
            # 3. CHAT: Quick chat trong trận đấu hoặc gửi sảnh
            # -------------------------------------------------------------
            elif t == "chat":
                match_id = pkt.get("match_id") or WS_CLIENT_META.get(websocket, {}).get("match_id")
                if match_id and match_id in ACTIVE_MATCHES:
                    match = ACTIVE_MATCHES[match_id]
                    if match.get("p1") == websocket:
                        peer_ws = match.get("p2")
                        sender_slot = "p1"
                    elif match.get("p2") == websocket:
                        peer_ws = match.get("p1")
                        sender_slot = "p2"
                    else:
                        peer_ws = None
                        sender_slot = "spectator" if WS_CLIENT_META.get(websocket, {}).get("is_spectator") else None

                    try:
                        chat_msg = str(pkt.get("msg", ""))
                        chat_frame = make_pvp_frame({
                            "t": "chat",
                            "match_id": match_id,
                            "msg": chat_msg,
                            "from": sender_slot
                        })
                        if peer_ws:
                            await peer_ws.send(chat_frame)
                        for spec_ws in list(match.get("spectators", set())):
                            if spec_ws != websocket:
                                asyncio.create_task(safe_send(spec_ws, chat_frame))
                        safe_preview = chat_msg.encode('ascii', errors='replace').decode('ascii')
                        print(f"[BATTLE CHAT] Match {match_id}: relayed quick chat: {safe_preview}")
                    except Exception as e:
                        print(f"[BATTLE CHAT ERR] Relay failed: {type(e).__name__}")
                else:
                    msg_data = pkt.get("msg")
                    if isinstance(msg_data, dict):
                        try:
                            send_chat_broadcast_to_server(msg_data)
                        except Exception as e:
                            print(f"[BATTLE LOBBY CHAT ERR] {e}")

            # -------------------------------------------------------------
            # 4. END: Kết thúc trận đấu, xác thực kết quả & chống gian lận
            # -------------------------------------------------------------
            elif t == "end":
                match_id = pkt.get("match_id") or WS_CLIENT_META.get(websocket, {}).get("match_id")
                if match_id and match_id in ACTIVE_MATCHES:
                    match = ACTIVE_MATCHES[match_id]
                    # Khán giả không được gửi frame kết thúc trận
                    if WS_CLIENT_META.get(websocket, {}).get("is_spectator"):
                        continue

                    if match.get("p1") == websocket:
                        peer_ws = match.get("p2")
                        sender_slot = "p1"
                    elif match.get("p2") == websocket:
                        peer_ws = match.get("p1")
                        sender_slot = "p2"
                    else:
                        peer_ws = None
                        sender_slot = None

                    if peer_ws:
                        try:
                            raw_res = str(pkt.get("result", "1")).lower()
                            sender_won = (raw_res == "1" or raw_res == "win")

                            # Chống gian lận / tự thua: Không cho phép xử thắng bằng timeout khi đối thủ vẫn đang kết nối
                            turn_ws = match.get("turn_ws")
                            last_action = match.get("last_action_time", 0)
                            reason = str(pkt.get("reason", "")).lower()
                            if sender_won and reason == "timeout":
                                print(f"[BATTLE END BLOCKED] Match {match_id}: claim victory via timeout blocked (both players connected)")
                                continue

                            peer_res = "2" if sender_won else "1"
                            peer_pkt = dict(pkt)
                            peer_pkt["result"] = peer_res
                            peer_pkt["sender_won"] = sender_won
                            peer_pkt["peer_won"] = not sender_won
                            await safe_send(peer_ws, make_pvp_frame(peer_pkt))

                            # Thông báo kết thúc trận đấu tới toàn bộ khán giả
                            winner_slot = sender_slot if sender_won else ("p2" if sender_slot == "p1" else "p1")
                            spec_result = "1" if winner_slot == "p1" else "2"
                            spec_frame = make_pvp_frame({
                                "t": "end",
                                "match_id": match_id,
                                "result": spec_result,
                                "winner": winner_slot,
                                "reason": pkt.get("reason", ""),
                                "msg": f"Trận đấu đã kết thúc! {'Người chơi 1' if winner_slot == 'p1' else 'Người chơi 2'} giành chiến thắng!"
                            })
                            for spec_ws in list(match.get("spectators", set())):
                                asyncio.create_task(safe_send(spec_ws, spec_frame))

                            print(f"[BATTLE END] Match {match_id}: sender_res={raw_res} (sender_won={sender_won}) -> peer_res={peer_res}, notified {len(match.get('spectators', set()))} spectators")
                        except Exception as e:
                            print(f"[BATTLE END ERR] {e}")

                    # Đã phân thắng bại: HỦY PHÒNG VÀ DỌN DẸP SẠCH SẼ TRẬN ĐẤU NGAY LẬP TỨC
                    match["ended"] = True
                    for spec_ws in list(match.get("spectators", set())):
                        if spec_ws in WS_CLIENT_META:
                            WS_CLIENT_META[spec_ws].pop("match_id", None)
                    ACTIVE_MATCHES.pop(match_id, None)

                    # Dọn dẹp phòng PVP tương ứng nếu có
                    for r_code, r_data in list(PVP_ROOMS.items()):
                        if r_data.get("match_id") == match_id:
                            PVP_ROOMS.pop(r_code, None)

                    # Xóa match_id khỏi metadata cả 2 người chơi để khi ngắt kết nối không bị gửi peer_dropped nhầm
                    if websocket in WS_CLIENT_META:
                        WS_CLIENT_META[websocket].pop("match_id", None)
                    if peer_ws and peer_ws in WS_CLIENT_META:
                        WS_CLIENT_META[peer_ws].pop("match_id", None)
                    print(f"[BATTLE END CLEANUP] Match {match_id} & room destroyed cleanly after duel finished.")

            # -------------------------------------------------------------
            # 5. LEAVE: Người chơi rời trận / đầu hàng
            # -------------------------------------------------------------
            elif t == "leave":
                match_id = WS_CLIENT_META.get(websocket, {}).get("match_id")
                if match_id and match_id in ACTIVE_MATCHES:
                    match = ACTIVE_MATCHES[match_id]
                    # Khán giả rời trận: không hủy trận đấu của 2 người chơi!
                    if WS_CLIENT_META.get(websocket, {}).get("is_spectator") or websocket in match.get("spectators", set()):
                        match.get("spectators", set()).discard(websocket)
                        if websocket in WS_CLIENT_META:
                            WS_CLIENT_META[websocket].pop("match_id", None)
                        print(f"[BATTLE LEAVE] Spectator left match {match_id} (match unaffected)")
                        continue

                    if match.get("p1") == websocket:
                        peer_ws = match.get("p2")
                        match["p1"] = None
                    elif match.get("p2") == websocket:
                        peer_ws = match.get("p1")
                        match["p2"] = None
                    else:
                        peer_ws = None

                    if peer_ws:
                        try:
                            left_frame = make_pvp_frame({"t": "peer_left", "match_id": match_id})
                            await peer_ws.send(left_frame)
                            for spec_ws in list(match.get("spectators", set())):
                                asyncio.create_task(safe_send(spec_ws, left_frame))
                        except Exception:
                            pass
                    match["ended"] = True
                    for spec_ws in list(match.get("spectators", set())):
                        if spec_ws in WS_CLIENT_META:
                            WS_CLIENT_META[spec_ws].pop("match_id", None)
                    ACTIVE_MATCHES.pop(match_id, None)
                    for r_code, r_data in list(PVP_ROOMS.items()):
                        if r_data.get("match_id") == match_id:
                            PVP_ROOMS.pop(r_code, None)
                if websocket in WS_CLIENT_META:
                    WS_CLIENT_META[websocket].pop("match_id", None)

            # -------------------------------------------------------------
            # 6. WS MATCHMAKING & CUSTOM ROOM (Nếu client gọi trực tiếp qua WS)
            # -------------------------------------------------------------
            elif t == "create":
                code = str(pkt.get("code") or random.randint(1000, 9999))
                PVP_ROOMS[code] = {
                    "host": websocket,
                    "host_deck": pkt.get("deck"),
                    "host_info": pkt.get("info"),
                    "hp": pkt.get("hp", 8000)
                }
                WS_CLIENT_META[websocket] = {"room_code": code}
                print(f"[BATTLE ROOM] Room created: {code} by {pkt.get('info', {}).get('name', 'Host')}")
                await websocket.send(make_pvp_frame({"t": "room_created", "code": code}))

            elif t == "join":
                code = str(pkt.get("code", ""))
                room = PVP_ROOMS.get(code)
                if room and room["host"] != websocket:
                    match_id = f"m_{int(time.time()*1000)}"
                    seed = random.randint(1, 65535)
                    host_ws = room["host"]
                    guest_ws = websocket
                    host_first = random.choice([True, False])

                    host_user = str(WS_CLIENT_META.get(host_ws, {}).get("user_id") or "")
                    guest_user = str(pkt.get("info", {}).get("id") or pkt.get("user_id") or "")
                    p1_ws = host_ws if host_first else guest_ws
                    p2_ws = guest_ws if host_first else host_ws
                    p1_user = host_user if host_first else guest_user
                    p2_user = guest_user if host_first else host_user
                    p1_deck = room["host_deck"] if host_first else pkt.get("deck")
                    p2_deck = pkt.get("deck") if host_first else room["host_deck"]
                    p1_info = room["host_info"] if host_first else pkt.get("info")
                    p2_info = pkt.get("info") if host_first else room["host_info"]

                    ACTIVE_MATCHES[match_id] = {
                        "p1": p1_ws, "p2": p2_ws,
                        "p1_user": p1_user, "p2_user": p2_user,
                        "p1_reconnect_token": 0, "p2_reconnect_token": 0,
                        "turn_slot": "p1",
                        "turn_ws": p1_ws,
                        "turn_start_time": time.time(),
                        "turn_duration": 90,
                        "last_action_time": time.time(),
                        "spectators": set()
                    }
                    WS_CLIENT_META[p1_ws] = {"match_id": match_id, "user_id": p1_user, "slot": "p1"}
                    WS_CLIENT_META[p2_ws] = {"match_id": match_id, "user_id": p2_user, "slot": "p2"}

                    await p1_ws.send(make_pvp_frame({
                        "t": "matched",
                        "match_id": match_id,
                        "seed": seed,
                        "first": True,
                        "slot": "p1",
                        "turn_duration": 90,
                        "time_left": 90,
                        "peer_deck": p2_deck,
                        "peer": p2_info
                    }))
                    await p2_ws.send(make_pvp_frame({
                        "t": "matched",
                        "match_id": match_id,
                        "seed": seed,
                        "first": False,
                        "slot": "p2",
                        "turn_duration": 90,
                        "time_left": 90,
                        "peer_deck": p1_deck,
                        "peer": p1_info
                    }))
                    del PVP_ROOMS[code]
                    print(f"[BATTLE ROOM] Room {code} matched! Match ID {match_id} (host_first={host_first})")
                else:
                    await websocket.send(make_pvp_frame({"t": "error", "msg": "Phòng không tồn tại hoặc đã đầy!"}))

            elif t == "match":
                info = pkt.get("info") or {}
                my_trophy = int(info.get("trophy", 800))
                my_find_strong = bool(info.get("find_strong", False))
                valid_candidates = []
                for idx, item in enumerate(PVP_QUEUE):
                    other_ws, other_deck, other_info = item
                    if other_ws != websocket:
                        other_trophy = int((other_info or {}).get("trophy", 800))
                        other_find_strong = bool((other_info or {}).get("find_strong", False))
                        diff = abs(my_trophy - other_trophy)
                        # KHONG GHEP DAU NEU LECH TREN 1000 RANKPOINT (TRU KHI NGUOI CO RANK THAP HON BAT 'TIM DOI THU MANH')
                        if diff > 1000:
                            can_match = (other_trophy > my_trophy and my_find_strong) or (my_trophy > other_trophy and other_find_strong)
                            if not can_match:
                                continue
                        # ƯU TIÊN CÁC TÀI KHOẢN TỪ 1000 TRỞ XUỐNG BẮT CẶP VỚI NHAU
                        if my_trophy <= 1000:
                            tier = 0 if other_trophy <= 1000 else 1
                        else:
                            tier = 0 if other_trophy > 1000 else 1
                        valid_candidates.append((tier, diff, item))

                if valid_candidates:
                    valid_candidates.sort(key=lambda x: (x[0], x[1]))
                    best_tier, best_diff, best_item = valid_candidates[0]
                    PVP_QUEUE.remove(best_item)
                    other_ws, other_deck, other_info = best_item
                    try:
                        match_id = f"m_{int(time.time()*1000)}"
                        seed = random.randint(1, 65535)
                        first = random.choice([True, False])
                        p1_user = str(WS_CLIENT_META.get(websocket, {}).get("user_id") or (pkt.get("info") or {}).get("id") or "")
                        p2_user = str(WS_CLIENT_META.get(other_ws, {}).get("user_id") or (other_info or {}).get("id") or "")
                        p1_ws = websocket if first else other_ws
                        p2_ws = other_ws if first else websocket
                        p1_u = p1_user if first else p2_user
                        p2_u = p2_user if first else p1_user
                        p1_deck = pkt.get("deck") if first else other_deck
                        p2_deck = other_deck if first else pkt.get("deck")
                        p1_info = info if first else other_info
                        p2_info = other_info if first else info

                        ACTIVE_MATCHES[match_id] = {
                            "p1": p1_ws, "p2": p2_ws,
                            "p1_user": p1_u, "p2_user": p2_u,
                            "p1_reconnect_token": 0, "p2_reconnect_token": 0,
                            "turn_slot": "p1",
                            "turn_ws": p1_ws,
                            "turn_start_time": time.time(),
                            "turn_duration": 90,
                            "last_action_time": time.time(),
                            "spectators": set()
                        }
                        WS_CLIENT_META[p1_ws] = {"match_id": match_id, "user_id": p1_u, "slot": "p1"}
                        WS_CLIENT_META[p2_ws] = {"match_id": match_id, "user_id": p2_u, "slot": "p2"}

                        await p1_ws.send(make_pvp_frame({
                            "t": "matched",
                            "match_id": match_id,
                            "seed": seed,
                            "first": True,
                            "slot": "p1",
                            "turn_duration": 90,
                            "time_left": 90,
                            "peer_deck": p2_deck,
                            "peer": p2_info
                        }))
                        await p2_ws.send(make_pvp_frame({
                            "t": "matched",
                            "match_id": match_id,
                            "seed": seed,
                            "first": False,
                            "slot": "p2",
                            "turn_duration": 90,
                            "time_left": 90,
                            "peer_deck": p1_deck,
                            "peer": p1_info
                        }))
                        print(f"[BATTLE QUEUE] Paired players! Match ID {match_id}")
                    except Exception as e:
                        print(f"[BATTLE QUEUE ERR] {e}")
                else:
                    entry = (websocket, pkt.get("deck"), info)
                    PVP_QUEUE.append(entry)
                    print(f"[BATTLE QUEUE] Player queued ({my_trophy} pts). Queue size: {len(PVP_QUEUE)}")

                    async def auto_ai_match(target_entry):
                        await asyncio.sleep(20.0)
                        if target_entry in PVP_QUEUE:
                            PVP_QUEUE.remove(target_entry)
                            try:
                                match_id = f"m_bot_{int(time.time()*1000)}"
                                seed = random.randint(1, 65535)
                                first = random.choice([True, False])
                                bot_deck = [10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010] * 4
                                ACTIVE_MATCHES[match_id] = {
                                    "p1": websocket, "p2": None,
                                    "p1_user": str(info.get("id", "")), "p2_user": "ai_bot",
                                    "p1_reconnect_token": 0, "p2_reconnect_token": 0,
                                    "turn_ws": websocket,
                                    "turn_start_time": time.time(),
                                    "turn_duration": 90,
                                    "last_action_time": time.time()
                                }
                                WS_CLIENT_META[websocket] = {"match_id": match_id, "user_id": str(info.get("id", ""))}
                                await websocket.send(make_pvp_frame({
                                    "t": "matched",
                                    "match_id": match_id,
                                    "seed": seed,
                                    "first": first,
                                    "peer_deck": bot_deck,
                                    "peer": {"name": "Duelist_Kaiba", "avatar": 102}
                                }))
                                print(f"[BATTLE QUEUE] Auto matched with AI (first={first}). Match ID {match_id}")
                            except Exception:
                                pass
                    asyncio.create_task(auto_ai_match(entry))

    except Exception as e:
        pass
    finally:
        # Dọn dẹp phòng và hàng chờ
        for code, room in list(PVP_ROOMS.items()):
            if room.get("host") == websocket:
                del PVP_ROOMS[code]
        for item in list(PVP_QUEUE):
            if item[0] == websocket:
                PVP_QUEUE.remove(item)

        # Xử lý mất kết nối trong trận đấu
        match_id = WS_CLIENT_META.get(websocket, {}).get("match_id")
        if match_id and match_id in ACTIVE_MATCHES:
            match = ACTIVE_MATCHES[match_id]
            # Nếu là khán giả ngắt kết nối: chỉ xóa khỏi spectators, tuyệt đối không ảnh hưởng đến trận đấu!
            if WS_CLIENT_META.get(websocket, {}).get("is_spectator") or websocket in match.get("spectators", set()):
                match.get("spectators", set()).discard(websocket)
                print(f"[BATTLE WS] Spectator disconnected from match {match_id} (match unaffected)")
            elif match.get("ended"):
                ACTIVE_MATCHES.pop(match_id, None)
            else:
                is_p1 = (match.get("p1") == websocket)
                is_p2 = (match.get("p2") == websocket)
                slot_key = "p1" if is_p1 else ("p2" if is_p2 else None)
                if slot_key:
                    match[slot_key] = None
                    match[f"{slot_key}_dc_time"] = time.time()
                    peer_key = "p2" if slot_key == "p1" else "p1"
                    token_key = f"{slot_key}_reconnect_token"
                    current_token = match.get(token_key, 0) + 1
                    match[token_key] = current_token

                    peer_ws = match.get(peer_key)
                    if peer_ws:
                        try:
                            asyncio.create_task(safe_send(peer_ws, make_pvp_frame({
                                "t": "peer_dropped",
                                "match_id": match_id,
                                "msg": "Đối thủ mất kết nối, đang chờ kết nối lại..."
                            })))
                        except Exception:
                            pass

                    async def delayed_peer_left(m_id, s_key, expected_token):
                        # 90 giây chờ đối thủ kết nối lại
                        await asyncio.sleep(90.0)
                        m = ACTIVE_MATCHES.get(m_id)
                        if m and m.get(s_key) is None and m.get(f"{s_key}_reconnect_token") == expected_token:
                            try:
                                p_ws = m.get("p2" if s_key == "p1" else "p1")
                                if p_ws:
                                    await safe_send(p_ws, make_pvp_frame({
                                        "t": "end",
                                        "match_id": m_id,
                                        "result": "1",
                                        "reason": "peer_left",
                                        "msg": "Đối thủ đã rời trận đấu! Bạn giành chiến thắng!"
                                    }))
                                    await safe_send(p_ws, make_pvp_frame({"t": "peer_left", "match_id": m_id}))
                                    print(f"[BATTLE TIMEOUT] Match {m_id}: {s_key} failed to reconnect after 90s, declared victory for remaining player")
                                for spec_ws in list(m.get("spectators", set())):
                                    winner_slot = "p2" if s_key == "p1" else "p1"
                                    asyncio.create_task(safe_send(spec_ws, make_pvp_frame({
                                        "t": "end",
                                        "match_id": m_id,
                                        "result": "1" if winner_slot == "p1" else "2",
                                        "winner": winner_slot,
                                        "reason": "peer_left",
                                        "msg": "Một đấu thủ đã rời trận đấu!"
                                    })))
                            except Exception:
                                pass
                            if m.get("p1") is None or m.get("p2") is None:
                                ACTIVE_MATCHES.pop(m_id, None)

                    if peer_ws:
                        asyncio.create_task(delayed_peer_left(match_id, slot_key, current_token))
                    elif match.get("p1") is None and match.get("p2") is None:
                        ACTIVE_MATCHES.pop(match_id, None)

        WS_CLIENT_META.pop(websocket, None)
        WS_CONNECTED_CLIENTS.discard(websocket)
        print(f"[BATTLE WS] Client disconnected: {client_ip}")

async def server_timeout_monitor():
    """Tự động kiểm tra thời gian lượt đi của mọi trận đấu; nếu hết giờ mà người chơi không thao tác hoặc mất kết nối, tự động chuyển lượt hoặc xử thua AFK."""
    while True:
        try:
            await asyncio.sleep(1.0)
            now = time.time()
            for match_id, match in list(ACTIVE_MATCHES.items()):
                if match.get("ended"):
                    continue
                p1 = match.get("p1")
                p2 = match.get("p2")
                # Bỏ qua chỉ khi CẢ HAI đều không kết nối
                if not p1 and not p2:
                    continue

                curr_slot = match.get("turn_slot", "p1")
                next_slot = "p2" if curr_slot == "p1" else "p1"
                curr_turn_ws = match.get(curr_slot)
                next_turn_ws = match.get(next_slot)

                turn_start = match.get("turn_start_time", now)
                turn_dur = match.get("turn_duration", 90)
                time_left = max(0, turn_dur - (now - turn_start))

                # Broadcast time_sync định kỳ mỗi 2 giây tới các client đang kết nối (bao gồm cả khán giả)
                if now - match.get("last_sync_time", 0) >= 2.0:
                    match["last_sync_time"] = now
                    sync_pkt = {
                        "t": "time_sync",
                        "match_id": match_id,
                        "time_left": int(time_left),
                        "turn_slot": curr_slot
                    }
                    sync_frame = make_pvp_frame(sync_pkt)
                    if p1:
                        asyncio.create_task(safe_send(p1, sync_frame))
                    if p2:
                        asyncio.create_task(safe_send(p2, sync_frame))
                    for spec_ws in list(match.get("spectators", set())):
                        asyncio.create_task(safe_send(spec_ws, sync_frame))

                # 1. Trường hợp người đang đi lượt bị MẤT KẾT NỐI (curr_turn_ws is None):
                if curr_turn_ws is None:
                    dc_time = match.get(f"{curr_slot}_dc_time", turn_start)
                    # Chờ hết giờ lượt đi hoặc tối đa 45s kể từ khi ngắt kết nối
                    if (now - turn_start) >= turn_dur or (now - dc_time) >= 45.0:
                        timeouts_key = f"{curr_slot}_timeouts"
                        match[timeouts_key] = match.get(timeouts_key, 0) + 1
                        print(f"[BATTLE TIMEOUT DC] Match {match_id}: {curr_slot} disconnected, auto-switching turn to {next_slot} (timeouts={match[timeouts_key]})")

                        # Chuyển lượt sang cho người chơi còn kết nối (để delayed_peer_left 90s xử lý nếu thực sự bỏ cuộc)
                        match["turn_slot"] = next_slot
                        match["turn_ws"] = next_turn_ws
                        match["turn_start_time"] = now
                        match["turn_duration"] = 90
                        cur_r = match.get("round", 1) + 1
                        match["round"] = cur_r
                        match["last_action_time"] = now

                        oppo_end_pkt = {
                            "t": "force_oppo_turn_end",
                            "match_id": match_id,
                            "round": cur_r,
                            "reason": "timeout"
                        }
                        oppo_action_pkt = {
                            "t": "action",
                            "match_id": match_id,
                            "ints": [1, cur_r, -1, int(now), 0, 0, 0],
                            "auto_timeout": True,
                            "from": curr_slot
                        }
                        if next_turn_ws:
                            asyncio.create_task(safe_send(next_turn_ws, make_pvp_frame(oppo_end_pkt)))
                            asyncio.create_task(safe_send(next_turn_ws, make_pvp_frame(oppo_action_pkt)))
                        for spec_ws in list(match.get("spectators", set())):
                            asyncio.create_task(safe_send(spec_ws, make_pvp_frame(oppo_action_pkt)))
                    continue

                # 2. Trường hợp người chơi còn kết nối nhưng HẾT THỜI GIAN LƯỢT ĐI:
                if (now - turn_start) >= turn_dur:
                    timeouts_key = f"{curr_slot}_timeouts"
                    match[timeouts_key] = match.get(timeouts_key, 0) + 1
                    print(f"[BATTLE TIMEOUT] Match {match_id}: {curr_slot} timed out, auto-passing turn to {next_slot}")

                    # TUYỆT ĐỐI KHÔNG XỬ THUA KHI NGƯỜI CHƠI ĐANG KẾT NỐI!
                    # Hết thời gian chỉ tự động kết thúc lượt (force turn end) để chuyển lượt sang đối thủ,
                    # trận đấu tiếp tục bình thường không làm người chơi bị tự thua bất ngờ.
                    match["turn_slot"] = next_slot
                    match["turn_ws"] = next_turn_ws
                    match["turn_start_time"] = now
                    match["turn_duration"] = 90
                    cur_r = match.get("round", 1) + 1
                    match["round"] = cur_r
                    match["last_action_time"] = now

                    # 1. To curr_turn_ws (timed-out player): Send force_turn_end so their client ends turn locally
                    if curr_turn_ws:
                        force_pkt = {
                            "t": "force_turn_end",
                            "match_id": match_id,
                            "round": cur_r,
                            "reason": "timeout"
                        }
                        asyncio.create_task(safe_send(curr_turn_ws, make_pvp_frame(force_pkt)))

                    # 2. To next_turn_ws (waiting opponent): Send force_oppo_turn_end and oppo_action_pkt so their client starts turn
                    oppo_end_pkt = {
                        "t": "force_oppo_turn_end",
                        "match_id": match_id,
                        "round": cur_r,
                        "reason": "timeout"
                    }
                    oppo_action_pkt = {
                        "t": "action",
                        "match_id": match_id,
                        "ints": [1, cur_r, -1, int(now), 0, 0, 0],
                        "auto_timeout": True,
                        "from": curr_slot
                    }
                    if next_turn_ws:
                        asyncio.create_task(safe_send(next_turn_ws, make_pvp_frame(oppo_end_pkt)))
                        asyncio.create_task(safe_send(next_turn_ws, make_pvp_frame(oppo_action_pkt)))
                    for spec_ws in list(match.get("spectators", set())):
                        asyncio.create_task(safe_send(spec_ws, make_pvp_frame(oppo_action_pkt)))
                    print(f"[BATTLE TIMEOUT MONITOR] Match {match_id}: round auto-switched cleanly ({curr_slot} -> {next_slot})")
                    continue
        except Exception as e:
            await asyncio.sleep(2.0)

async def main():
    print("==================================================================")
    print("      YU-GI-OH DEDICATED MAIN BATTLE SERVER (PORT 9192)          ")
    print("==================================================================")
    print(f"      - Service       : Chuyen trach chay logic tran dau (PVP)")
    print(f"      - Protocol      : WebSocket @ ws://0.0.0.0:{WS_PORT}        ")
    print(f"      - Isolation     : Zero lag tu Mo Pack / Bang Xep Hang / Nhiem Vu")
    print(f"      - Survival Mode : Doc lap (Chay tai Survival Server 8085)  ")
    print("==================================================================")

    asyncio.create_task(server_timeout_monitor())

    async with websockets.serve(
        battle_ws_handler,
        "0.0.0.0",
        WS_PORT,
        ping_interval=30,
        ping_timeout=60,
        max_size=20 * 1024 * 1024
    ):
        print(f"[BATTLE SERVER READY] Listening on ws://0.0.0.0:{WS_PORT}")
        asyncio.create_task(console_cleaner_task())
        await asyncio.Future()

async def console_cleaner_task():
    while True:
        await asyncio.sleep(1800)
        try:
            os.system('cls' if os.name == 'nt' else 'clear')
            print(f"[SYSTEM] Đã dọn dẹp console log định kỳ (mỗi 30 phút). Battle server hoạt động bình thường lúc {time.strftime('%Y-%m-%d %H:%M:%S')}")
        except Exception:
            pass

if __name__ == '__main__':
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\n[BATTLE SERVER] Shutting down...")
