#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Yu-Gi-Oh Online - Dedicated Survival Mode (Sinh Tử Chiến) Server
Port: 8085 (HTTP)
Features:
- ThreadingHTTPServer for fast concurrent requests (eliminates proxy deadlock)
- Real-time waiting room: reflects accurate duelist count (1/25 -> 2/25)
- Fast-start match timer: when 2 or more duelists join, starts countdown to pair them
- Guaranteed AI bot fallback if solo after timeout
- Persistent ROOMS dictionary to prevent dropped polling rooms
- AI bots use character-specific card decks from char_cards_map.json
"""

import sys
import os
import json
import time
import random
import threading
import socketserver
from http.server import HTTPServer, BaseHTTPRequestHandler
import urllib.parse

if sys.platform == 'win32':
    try:
        sys.stdout.reconfigure(encoding='utf-8')
        sys.stderr.reconfigure(encoding='utf-8')
    except Exception:
        pass

PORT = 8085
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
CHAR_CARDS_MAP_PATH = os.path.join(BASE_DIR, "char_cards_map.json")

# Load character cards map
CHAR_CARDS = {}
if os.path.exists(CHAR_CARDS_MAP_PATH):
    try:
        with open(CHAR_CARDS_MAP_PATH, "r", encoding="utf-8") as f:
            CHAR_CARDS = json.load(f)
        print(f"[SURVIVAL SERVER] Loaded {len(CHAR_CARDS)} characters from char_cards_map.json")
    except Exception as e:
        print(f"[SURVIVAL SERVER] Error loading char_cards_map.json: {e}")

AI_THEMES = [
    {"char_id": "2", "name": "Kaiba Seto (AI)", "avatar": 201},
    {"char_id": "3", "name": "Yugi Muto (AI)", "avatar": 301},
    {"char_id": "4", "name": "Mai Kujaku (AI)", "avatar": 401},
    {"char_id": "5", "name": "Jonouchi (AI)", "avatar": 501},
    {"char_id": "6", "name": "Bakura (AI)", "avatar": 601},
    {"char_id": "7", "name": "Bandit Keith (AI)", "avatar": 701},
    {"char_id": "8", "name": "Pegasus (AI)", "avatar": 801},
    {"char_id": "9", "name": "Ishizu Ishtar (AI)", "avatar": 901},
    {"char_id": "10", "name": "Yami Marik (AI)", "avatar": 1001},
    {"char_id": "18", "name": "Mokuba (AI)", "avatar": 1801},
]

FALLBACK_CARDS = [
    10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010,
    20001, 20002, 20003, 20004, 20005, 30001, 30002, 30003
]

def generate_ai_deck(char_id):
    c_list = CHAR_CARDS.get(str(char_id), [])
    if not c_list:
        c_list = FALLBACK_CARDS
    deck = list(c_list)
    random.shuffle(deck)
    while len(deck) < 40:
        deck.extend(c_list)
    return deck[:40]

def create_10_ai_bots():
    bots = []
    for idx, theme in enumerate(AI_THEMES):
        bot_cards = generate_ai_deck(theme["char_id"])
        bots.append({
            "id": f"ai_bot_{idx+1}",
            "account_id": -(idx + 1),
            "name": theme["name"],
            "character_id": int(theme["char_id"]),
            "avatar": theme["avatar"],
            "level": random.randint(45, 55),
            "cards": bot_cards,
            "extra_cards": [],
            "gold_cup": 1 if idx == 0 else 0,
            "silver_cup": 1 if idx == 1 else 0,
            "bronze_cup": 1 if idx == 2 else 0,
            "is_real_player": False,
            "is_alive": True,
            "wins": 0,
            "losses": 0
        })
    return bots

# State lock, active room, and room dictionary
STATE_LOCK = threading.Lock()
ACTIVE_ROOM = None
ROOMS = {}

def get_or_create_room():
    global ACTIVE_ROOM
    now = time.time()
    if ACTIVE_ROOM is not None:
        if ACTIVE_ROOM["status"] == "waiting":
            if now < ACTIVE_ROOM["expires_at"] and len(ACTIVE_ROOM["players"]) < 15:
                return ACTIVE_ROOM
            else:
                trigger_room_ready(ACTIVE_ROOM)
                ACTIVE_ROOM = None

    room_id = f"sroom_{int(now*1000)}"
    ACTIVE_ROOM = {
        "id": room_id,
        "created_at": now,
        "expires_at": now + 60,  # 60s max wait for solo
        "status": "waiting",
        "players": {},            # int(account_id) -> player_dict
        "ais": create_10_ai_bots(),
        "matches": {},            # int(account_id) -> match_dict
        "ready_timestamp": 0
    }
    ROOMS[room_id] = ACTIVE_ROOM
    print(f"[SURVIVAL ROOM] Created new room {room_id} with 10 AI bots.")
    return ACTIVE_ROOM

def trigger_room_ready(room):
    global ACTIVE_ROOM
    if room["status"] in ("ready", "running"):
        return
    room["status"] = "ready"
    room["ready_timestamp"] = time.time()
    now = time.time()

    real_pids = list(room["players"].keys())
    random.shuffle(real_pids)
    print(f"[SURVIVAL ROOM {room['id']}] Triggering READY! Real players count: {len(real_pids)}, AI bots: {len(room['ais'])}")

    available_ais = list(room["ais"])
    random.shuffle(available_ais)

    # Pair real players together
    i = 0
    while i < len(real_pids) - 1:
        p1_id = real_pids[i]
        p2_id = real_pids[i+1]
        p1 = room["players"][p1_id]
        p2 = room["players"][p2_id]

        match_id = f"sm_{int(now*1000)}_{p1_id}_{p2_id}"
        seed = random.randint(1, 65535)

        # Player 1 match info (Attacker)
        room["matches"][p1_id] = {
            "code": 200,
            "status": "matched",
            "room_id": room["id"],
            "match_id": match_id,
            "seed": seed,
            "is_attacker": True,
            "first": True,
            "is_real_player": True,
            "oppo_online": True,
            "oppo": {
                "name": p2["name"],
                "level": p2["level"],
                "avatar": p2["avatar"],
                "cards": p2["cards"],
                "extra_cards": p2.get("extra_cards", []),
                "gold_cup": p2.get("gold_cup", 0),
                "silver_cup": p2.get("silver_cup", 0),
                "bronze_cup": p2.get("bronze_cup", 0),
                "is_real_player": True
            }
        }

        # Player 2 match info (Defender)
        room["matches"][p2_id] = {
            "code": 200,
            "status": "matched",
            "room_id": room["id"],
            "match_id": match_id,
            "seed": seed,
            "is_attacker": False,
            "first": False,
            "is_real_player": True,
            "oppo_online": True,
            "oppo": {
                "name": p1["name"],
                "level": p1["level"],
                "avatar": p1["avatar"],
                "cards": p1["cards"],
                "extra_cards": p1.get("extra_cards", []),
                "gold_cup": p1.get("gold_cup", 0),
                "silver_cup": p1.get("silver_cup", 0),
                "bronze_cup": p1.get("bronze_cup", 0),
                "is_real_player": True
            }
        }
        print(f"[SURVIVAL MATCH] Real vs Real: {p1['name']} (ID {p1_id}) vs {p2['name']} (ID {p2_id}) in Room {room['id']}")
        i += 2

    # If odd number of real players, pair last player with AI bot
    if i < len(real_pids):
        last_pid = real_pids[i]
        p = room["players"][last_pid]
        bot = available_ais.pop(0) if available_ais else room["ais"][0]
        match_id = f"sm_{int(now*1000)}_{last_pid}_ai"
        seed = random.randint(1, 65535)

        room["matches"][last_pid] = {
            "code": 200,
            "status": "matched",
            "room_id": room["id"],
            "match_id": match_id,
            "seed": seed,
            "is_attacker": True,
            "first": True,
            "is_real_player": False,
            "oppo_online": False,
            "oppo": {
                "name": bot["name"],
                "level": bot["level"],
                "avatar": bot["avatar"],
                "cards": bot["cards"],
                "extra_cards": [],
                "gold_cup": bot.get("gold_cup", 0),
                "silver_cup": bot.get("silver_cup", 0),
                "bronze_cup": bot.get("bronze_cup", 0),
                "is_real_player": False
            }
        }
        print(f"[SURVIVAL MATCH] Real vs AI: {p['name']} (ID {last_pid}) vs {bot['name']} in Room {room['id']}")

    if ACTIVE_ROOM and ACTIVE_ROOM["id"] == room["id"]:
        ACTIVE_ROOM = None


class SurvivalHandler(BaseHTTPRequestHandler):
    def _send_json(self, data, code=200):
        body = json.dumps(data, ensure_ascii=False).encode('utf-8')
        self.send_response(code)
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.send_header('Content-Length', str(len(body)))
        self.send_header('Connection', 'close')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.end_headers()
        self.wfile.write(body)

    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.send_header('Connection', 'close')
        self.end_headers()

    def do_GET(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path
        query = urllib.parse.parse_qs(parsed.query)
        req = {k: v[0] if isinstance(v, list) and len(v) == 1 else v for k, v in query.items()}
        self._handle_api(path, req)

    def do_POST(self):
        content_len = int(self.headers.get('Content-Length', 0))
        post_body = self.rfile.read(content_len) if content_len > 0 else b'{}'
        try:
            req = json.loads(post_body.decode('utf-8'))
        except Exception:
            req = {}

        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path
        self._handle_api(path, req)

    def _handle_api(self, path, req):
        if path in ('/api/survival/status', '/status'):
            with STATE_LOCK:
                room = get_or_create_room()
                now = time.time()
                rem = max(0, int(room["expires_at"] - now))
                real_cnt = len(room["players"])
                resp = {
                    "code": 200,
                    "room_id": room["id"],
                    "status": room["status"],
                    "remaining": rem,
                    "player_count": real_cnt,
                    "players": real_cnt,
                    "real_players": real_cnt,
                    "ais": len(room["ais"]),
                    "total_count": real_cnt + len(room["ais"]),
                    "max_players": 25
                }
            self._send_json(resp)
            return

        elif path in ('/api/survival/join', '/join'):
            raw_acc_id = req.get("account_id")
            if raw_acc_id is None:
                self._send_json({"code": 400, "msg": "Missing account_id"}, 400)
                return
            try:
                acc_id = int(raw_acc_id)
            except (TypeError, ValueError):
                self._send_json({"code": 400, "msg": "Invalid account_id"}, 400)
                return

            with STATE_LOCK:
                room = get_or_create_room()
                now = time.time()
                room["players"][acc_id] = {
                    "account_id": acc_id,
                    "name": req.get("name", f"Duelist_{acc_id}"),
                    "level": req.get("level", 50),
                    "avatar": req.get("avatar", 201),
                    "cards": req.get("cards", []),
                    "extra_cards": req.get("extra_cards", []),
                    "character_id": req.get("character_id", 2),
                    "gold_cup": req.get("gold_cup", 0),
                    "silver_cup": req.get("silver_cup", 0),
                    "bronze_cup": req.get("bronze_cup", 0),
                    "joined_at": now
                }

                real_cnt = len(room["players"])

                # If 2 or more real players in room, fast-start countdown (5s) so players see 2/25 then match starts
                if real_cnt >= 2:
                    room["expires_at"] = min(room["expires_at"], now + 5)

                rem = max(0, int(room["expires_at"] - now))
                print(f"[SURVIVAL JOIN] Player {req.get('name')} (ID {acc_id}) joined Room {room['id']}. Real: {real_cnt}/25, Time left: {rem}s")

                resp = {
                    "code": 200,
                    "status": room["status"],
                    "room_id": room["id"],
                    "countdown": rem,
                    "player_count": real_cnt,
                    "real_players": real_cnt,
                    "total_count": real_cnt + len(room["ais"]),
                    "max_players": 25
                }
            self._send_json(resp)
            return

        elif path in ('/api/survival/poll', '/poll'):
            raw_acc_id = req.get("account_id")
            room_id = req.get("room_id")
            if raw_acc_id is None:
                self._send_json({"code": 400, "msg": "Missing account_id"}, 400)
                return
            try:
                acc_id = int(raw_acc_id)
            except (TypeError, ValueError):
                self._send_json({"code": 400, "msg": "Invalid account_id"}, 400)
                return

            with STATE_LOCK:
                # Find room by room_id in ROOMS dictionary or ACTIVE_ROOM
                target_room = ROOMS.get(room_id) if room_id else None
                if not target_room and ACTIVE_ROOM:
                    target_room = ACTIVE_ROOM

                if not target_room:
                    self._send_json({"code": 404, "status": "cancelled", "msg": "Room not found"}, 404)
                    return

                now = time.time()
                # Check timeout or full
                if target_room["status"] == "waiting":
                    if now >= target_room["expires_at"] or (len(target_room["players"]) >= 15):
                        trigger_room_ready(target_room)

                if target_room["status"] in ("ready", "running"):
                    match_info = target_room["matches"].get(acc_id)
                    if match_info:
                        self._send_json(match_info)
                        return

                rem = max(0, int(target_room["expires_at"] - now))
                real_cnt = len(target_room["players"])
                resp = {
                    "code": 200,
                    "status": "waiting",
                    "room_id": target_room["id"],
                    "countdown": rem,
                    "player_count": real_cnt,
                    "real_players": real_cnt,
                    "total_count": real_cnt + len(target_room["ais"]),
                    "max_players": 25
                }
            self._send_json(resp)
            return

        elif path in ('/api/survival/cancel', '/cancel'):
            raw_acc_id = req.get("account_id")
            room_id = req.get("room_id")
            try:
                acc_id = int(raw_acc_id) if raw_acc_id is not None else None
            except (TypeError, ValueError):
                acc_id = None

            with STATE_LOCK:
                if acc_id:
                    if ACTIVE_ROOM and acc_id in ACTIVE_ROOM["players"]:
                        ACTIVE_ROOM["players"].pop(acc_id, None)
                        print(f"[SURVIVAL CANCEL] Player ID {acc_id} cancelled from Active Room {ACTIVE_ROOM['id']}")
                    if room_id and room_id in ROOMS and acc_id in ROOMS[room_id]["players"]:
                        ROOMS[room_id]["players"].pop(acc_id, None)
                        print(f"[SURVIVAL CANCEL] Player ID {acc_id} cancelled from Room {room_id}")
            self._send_json({"code": 200, "status": "cancelled"})
            return

        elif path in ('/api/survival/explore', '/explore'):
            raw_acc_id = req.get("account_id")
            room_id = req.get("room_id")
            try:
                acc_id = int(raw_acc_id) if raw_acc_id is not None else 1
            except (TypeError, ValueError):
                acc_id = 1

            with STATE_LOCK:
                target_room = ROOMS.get(room_id) or ACTIVE_ROOM
                oppo_data = None
                is_real = False
                if target_room:
                    candidates = [p for p in target_room["players"].values() if p["account_id"] != acc_id]
                    if candidates:
                        cand = random.choice(candidates)
                        oppo_data = cand
                        is_real = True
                    else:
                        cand = random.choice(target_room["ais"])
                        oppo_data = cand
                        is_real = False
                if not oppo_data:
                    bot = random.choice(create_10_ai_bots())
                    oppo_data = bot
                    is_real = False

                seed = random.randint(1, 65535)
                match_id = f"sm_{int(time.time()*1000)}_{acc_id}_{random.randint(100,999)}"
                resp = {
                    "code": 200,
                    "status": "matched",
                    "match_id": match_id,
                    "seed": seed,
                    "is_attacker": True,
                    "first": True,
                    "is_real_player": is_real,
                    "oppo_online": is_real,
                    "oppo": {
                        "name": oppo_data["name"],
                        "level": oppo_data["level"],
                        "avatar": oppo_data["avatar"],
                        "cards": oppo_data["cards"],
                        "extra_cards": oppo_data.get("extra_cards", []),
                        "gold_cup": oppo_data.get("gold_cup", 0),
                        "silver_cup": oppo_data.get("silver_cup", 0),
                        "bronze_cup": oppo_data.get("bronze_cup", 0),
                        "is_real_player": is_real
                    }
                }
            self._send_json(resp)
            return

        self._send_json({"code": 404, "msg": "Endpoint not found"}, 404)


class ThreadingHTTPServer(socketserver.ThreadingMixIn, HTTPServer):
    daemon_threads = True


def room_monitor_loop():
    """Periodically check active room countdown and clean stale rooms"""
    while True:
        try:
            with STATE_LOCK:
                now = time.time()
                if ACTIVE_ROOM and ACTIVE_ROOM["status"] == "waiting":
                    if now >= ACTIVE_ROOM["expires_at"]:
                        trigger_room_ready(ACTIVE_ROOM)

                # Clean rooms older than 15 minutes
                stale_keys = [rid for rid, r in ROOMS.items() if (now - r.get("created_at", now)) > 900]
                for rid in stale_keys:
                    ROOMS.pop(rid, None)
        except Exception as e:
            print(f"[ROOM MONITOR ERR] {e}")
        time.sleep(1)


def main():
    monitor_thread = threading.Thread(target=room_monitor_loop, daemon=True)
    monitor_thread.start()

    server = ThreadingHTTPServer(('0.0.0.0', PORT), SurvivalHandler)
    server.daemon_threads = True
    print(f"============================================================")
    print(f" Yu-Gi-Oh Survival Server (Sinh Tử Chiến) listening on port {PORT}")
    print(f" Multi-threaded: ThreadingHTTPServer enabled")
    print(f" Room Capacity: 25 (Guaranteed 10 AI bots + 15 Real Players)")
    print(f" Real Duelist Synchronization & Fast-Start Timer enabled")
    print(f" Character Decks: Active from char_cards_map.json")
    print(f"============================================================")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n[SURVIVAL SERVER] Stopping...")
        server.server_close()


if __name__ == '__main__':
    main()
