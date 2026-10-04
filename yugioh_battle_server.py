#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Yu-Gi-Oh Online - Dedicated Battle Server (Server Trận Đấu Chính)
Port: 9192 (WebSocket)

KIẾN TRÚC ĐỘC LẬP:
- Chỉ chạy DUY NHẤT logic trận đấu (PVP duel runtime):
  * Ghép trận / Bind match
  * Đồng bộ frame thao tác (action, ints, card play, skill trigger)
  * Quản lý lượt đi (turn), đếm giờ & cộng dồn thời gian (+4s per action)
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
                reconnected = False

                if match_id:
                    WS_CLIENT_META[websocket] = {"match_id": match_id, "user_id": user_id}
                    if match_id not in ACTIVE_MATCHES:
                        ACTIVE_MATCHES[match_id] = {
                            "p1": websocket, "p2": None,
                            "p1_user": user_id, "p2_user": None,
                            "p1_reconnect_token": 0, "p2_reconnect_token": 0,
                            "turn_ws": websocket,
                            "last_action_time": time.time()
                        }
                        print(f"[BATTLE WS] Match {match_id}: p1 bound (user {user_id})")
                    else:
                        match = ACTIVE_MATCHES[match_id]
                        slot = None
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
                            print(f"[BATTLE WS] Match {match_id}: {slot} bound (user {user_id})")

                        p1 = match.get("p1")
                        p2 = match.get("p2")
                        if p1 and p2 and not match.get("ready_sent"):
                            match["ready_sent"] = True
                            ready_msg = make_pvp_frame({"t": "peer_ready"})
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
                    if match.get("p1") == websocket:
                        peer_ws = match.get("p2")
                    elif match.get("p2") == websocket:
                        peer_ws = match.get("p1")
                    else:
                        peer_ws = None

                    if peer_ws:
                        try:
                            match["last_action_time"] = time.time()
                            ints = pkt.get("ints", [])
                            card_id = ints[0] if len(ints) > 0 else 0

                            # Kết thúc lượt
                            if card_id == 1:
                                match["turn_ws"] = peer_ws
                                print(f"[BATTLE TURN] Match {match_id}: round ended, turn switched to peer")
                            elif card_id not in (1, 2) and card_id != 0:
                                match["turn_ws"] = websocket
                                pkt["add_time"] = 4
                                pkt["max_time"] = 120
                                if "time_left" in pkt:
                                    try:
                                        pkt["time_left"] = min(120.0, float(pkt["time_left"]) + 4.0)
                                    except Exception:
                                        pass
                                print(f"[BATTLE TIME] Match {match_id}: +4s round time added for card {card_id}")

                            await peer_ws.send(make_pvp_frame(pkt))
                            print(f"[BATTLE ACTION] Match {match_id}: relayed ints len={len(ints)}")
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
                    elif match.get("p2") == websocket:
                        peer_ws = match.get("p1")
                    else:
                        peer_ws = None

                    if peer_ws:
                        try:
                            chat_msg = str(pkt.get("msg", ""))
                            await peer_ws.send(make_pvp_frame({
                                "t": "chat",
                                "match_id": match_id,
                                "msg": chat_msg
                            }))
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
                    if match.get("p1") == websocket:
                        peer_ws = match.get("p2")
                    elif match.get("p2") == websocket:
                        peer_ws = match.get("p1")
                    else:
                        peer_ws = None

                    if peer_ws:
                        try:
                            raw_res = str(pkt.get("result", "1")).lower()
                            sender_won = (raw_res == "1" or raw_res == "win")

                            # Chống gian lận: Nếu claim timeout nhưng đối thủ chưa hề hết thời gian
                            turn_ws = match.get("turn_ws")
                            last_action = match.get("last_action_time", 0)
                            reason = str(pkt.get("reason", "")).lower()
                            if sender_won and turn_ws and websocket != turn_ws and reason == "timeout" and (time.time() - last_action < 120):
                                print(f"[BATTLE END BLOCKED] Match {match_id}: non-turn player claimed victory while turn player active")
                                continue

                            peer_res = "2" if sender_won else "1"
                            peer_pkt = dict(pkt)
                            peer_pkt["result"] = peer_res
                            peer_pkt["sender_won"] = sender_won
                            peer_pkt["peer_won"] = not sender_won
                            await safe_send(peer_ws, make_pvp_frame(peer_pkt))
                            print(f"[BATTLE END] Match {match_id}: sender_res={raw_res} (sender_won={sender_won}) -> peer_res={peer_res}")
                        except Exception as e:
                            print(f"[BATTLE END ERR] {e}")

            # -------------------------------------------------------------
            # 5. LEAVE: Người chơi rời trận / đầu hàng
            # -------------------------------------------------------------
            elif t == "leave":
                match_id = WS_CLIENT_META.get(websocket, {}).get("match_id")
                if match_id and match_id in ACTIVE_MATCHES:
                    match = ACTIVE_MATCHES[match_id]
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
                            await peer_ws.send(make_pvp_frame({"t": "peer_left"}))
                        except Exception:
                            pass
                    if match.get("p1") is None and match.get("p2") is None:
                        ACTIVE_MATCHES.pop(match_id, None)

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

                    host_user = str(WS_CLIENT_META.get(host_ws, {}).get("user_id") or "")
                    guest_user = str(pkt.get("info", {}).get("id") or pkt.get("user_id") or "")
                    ACTIVE_MATCHES[match_id] = {
                        "p1": host_ws, "p2": guest_ws,
                        "p1_user": host_user, "p2_user": guest_user,
                        "p1_reconnect_token": 0, "p2_reconnect_token": 0,
                        "turn_ws": host_ws,
                        "last_action_time": time.time()
                    }
                    WS_CLIENT_META[host_ws] = {"match_id": match_id, "user_id": host_user}
                    WS_CLIENT_META[guest_ws] = {"match_id": match_id, "user_id": guest_user}

                    host_deck = room["host_deck"]
                    guest_deck = pkt.get("deck")

                    await host_ws.send(make_pvp_frame({
                        "t": "matched",
                        "match_id": match_id,
                        "seed": seed,
                        "first": True,
                        "peer_deck": guest_deck,
                        "peer": pkt.get("info")
                    }))
                    await guest_ws.send(make_pvp_frame({
                        "t": "matched",
                        "match_id": match_id,
                        "seed": seed,
                        "first": False,
                        "peer_deck": host_deck,
                        "peer": room["host_info"]
                    }))
                    del PVP_ROOMS[code]
                    print(f"[BATTLE ROOM] Room {code} matched! Match ID {match_id}")
                else:
                    await websocket.send(make_pvp_frame({"t": "error", "msg": "Phòng không tồn tại hoặc đã đầy!"}))

            elif t == "match":
                info = pkt.get("info") or {}
                my_trophy = int(info.get("trophy", 800))
                valid_candidates = []
                for idx, item in enumerate(PVP_QUEUE):
                    other_ws, other_deck, other_info = item
                    if other_ws != websocket:
                        other_trophy = int((other_info or {}).get("trophy", 800))
                        diff = abs(my_trophy - other_trophy)
                        valid_candidates.append((diff, item))

                if valid_candidates:
                    valid_candidates.sort(key=lambda x: x[0])
                    best_diff, best_item = valid_candidates[0]
                    PVP_QUEUE.remove(best_item)
                    other_ws, other_deck, other_info = best_item
                    try:
                        match_id = f"m_{int(time.time()*1000)}"
                        seed = random.randint(1, 65535)
                        first = random.choice([True, False])
                        p1_user = str(WS_CLIENT_META.get(websocket, {}).get("user_id") or (pkt.get("info") or {}).get("id") or "")
                        p2_user = str(WS_CLIENT_META.get(other_ws, {}).get("user_id") or (other_info or {}).get("id") or "")
                        turn_ws = websocket if first else other_ws
                        ACTIVE_MATCHES[match_id] = {
                            "p1": websocket, "p2": other_ws,
                            "p1_user": p1_user, "p2_user": p2_user,
                            "p1_reconnect_token": 0, "p2_reconnect_token": 0,
                            "turn_ws": turn_ws,
                            "last_action_time": time.time()
                        }
                        WS_CLIENT_META[websocket] = {"match_id": match_id, "user_id": p1_user}
                        WS_CLIENT_META[other_ws] = {"match_id": match_id, "user_id": p2_user}

                        await websocket.send(make_pvp_frame({
                            "t": "matched",
                            "match_id": match_id,
                            "seed": seed,
                            "first": first,
                            "peer_deck": other_deck,
                            "peer": other_info
                        }))
                        await other_ws.send(make_pvp_frame({
                            "t": "matched",
                            "match_id": match_id,
                            "seed": seed,
                            "first": not first,
                            "peer_deck": pkt.get("deck"),
                            "peer": info
                        }))
                        print(f"[BATTLE QUEUE] Paired players! Match ID {match_id}")
                    except Exception as e:
                        print(f"[BATTLE QUEUE ERR] {e}")
                else:
                    entry = (websocket, pkt.get("deck"), info)
                    PVP_QUEUE.append(entry)
                    print(f"[BATTLE QUEUE] Player queued ({my_trophy} pts). Queue size: {len(PVP_QUEUE)}")

                    async def auto_ai_match(target_entry):
                        await asyncio.sleep(1.5)
                        if target_entry in PVP_QUEUE:
                            PVP_QUEUE.remove(target_entry)
                            try:
                                match_id = f"m_bot_{int(time.time()*1000)}"
                                seed = random.randint(1, 65535)
                                first = True
                                bot_deck = [10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010] * 4
                                ACTIVE_MATCHES[match_id] = {
                                    "p1": websocket, "p2": None,
                                    "p1_user": str(info.get("id", "")), "p2_user": "ai_bot",
                                    "p1_reconnect_token": 0, "p2_reconnect_token": 0,
                                    "turn_ws": websocket,
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
                                print(f"[BATTLE QUEUE] Auto matched with AI. Match ID {match_id}")
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
            is_p1 = (match.get("p1") == websocket)
            is_p2 = (match.get("p2") == websocket)
            slot_key = "p1" if is_p1 else ("p2" if is_p2 else None)
            if slot_key:
                match[slot_key] = None
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
                    # 60 giây chờ đối thủ kết nối lại
                    await asyncio.sleep(60.0)
                    m = ACTIVE_MATCHES.get(m_id)
                    if m and m.get(s_key) is None and m.get(f"{s_key}_reconnect_token") == expected_token:
                        try:
                            p_ws = m.get("p2" if s_key == "p1" else "p1")
                            if p_ws:
                                await safe_send(p_ws, make_pvp_frame({"t": "peer_left", "match_id": m_id}))
                                print(f"[BATTLE TIMEOUT] Match {m_id}: {s_key} failed to reconnect after 60s, declared peer_left")
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

async def main():
    print("==================================================================")
    print("      YU-GI-OH DEDICATED MAIN BATTLE SERVER (PORT 9192)          ")
    print("==================================================================")
    print(f"      - Service       : Chuyen trach chay logic tran dau (PVP)")
    print(f"      - Protocol      : WebSocket @ ws://0.0.0.0:{WS_PORT}        ")
    print(f"      - Isolation     : Zero lag tu Mo Pack / Bang Xep Hang / Nhiem Vu")
    print(f"      - Survival Mode : Doc lap (Chay tai Survival Server 8085)  ")
    print("==================================================================")

    async with websockets.serve(
        battle_ws_handler,
        "0.0.0.0",
        WS_PORT,
        ping_interval=30,
        ping_timeout=60,
        max_size=20 * 1024 * 1024
    ):
        print(f"[BATTLE SERVER READY] Listening on ws://0.0.0.0:{WS_PORT}")
        await asyncio.Future()

if __name__ == '__main__':
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\n[BATTLE SERVER] Shutting down...")
