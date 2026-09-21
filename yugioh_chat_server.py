"""
YU-GI-OH STANDALONE CHAT SERVER
HTTP Port: 8084
WebSocket Port: 9193
Database: MySQL yugioh_game @ 127.0.0.1:3306
"""

import sys
import os
import time
import json
import asyncio
import struct
from http.server import ThreadingHTTPServer, BaseHTTPRequestHandler
import threading
import websockets
import pymysql
from pymysql.cursors import DictCursor

try:
    sys.stdout.reconfigure(encoding='utf-8', line_buffering=True)
    sys.stderr.reconfigure(encoding='utf-8', line_buffering=True)
except Exception:
    pass

DB_HOST = '127.0.0.1'
DB_PORT = 3306
DB_USER = 'root'
DB_PASS = ''
DB_NAME = 'yugioh_game'

CHAT_HTTP_PORT = 8084
CHAT_WS_PORT = 9193

def get_db():
    return pymysql.connect(
        host=DB_HOST,
        port=DB_PORT,
        user=DB_USER,
        password=DB_PASS,
        database=DB_NAME,
        cursorclass=DictCursor,
        autocommit=True
    )

def ensure_chat_db():
    try:
        with get_db() as conn:
            with conn.cursor() as cur:
                cur.execute("""
                    CREATE TABLE IF NOT EXISTS chat_messages (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        client_msg_id VARCHAR(64),
                        account_id INT NOT NULL,
                        sender_name VARCHAR(64) NOT NULL,
                        level INT DEFAULT 1,
                        avatar INT DEFAULT 201,
                        msg_type INT DEFAULT 1,
                        card_id INT DEFAULT 0,
                        content TEXT NOT NULL,
                        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                        timestamp_ms BIGINT NOT NULL,
                        gold_cup INT NOT NULL DEFAULT 0,
                        silver_cup INT NOT NULL DEFAULT 0,
                        bronze_cup INT NOT NULL DEFAULT 0,
                        trophy INT NOT NULL DEFAULT 800,
                        INDEX (account_id),
                        INDEX (created_at),
                        INDEX (client_msg_id)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
                """)
    except Exception as e:
        print("[CHAT DB ERR] ensure_chat_db:", e)

def db_get_today_chat_history():
    ensure_chat_db()
    try:
        with get_db() as conn:
            with conn.cursor() as cur:
                cur.execute("""
                    SELECT id, client_msg_id, account_id, sender_name AS name, level, avatar,
                           msg_type AS type, card_id, content, content AS msg, timestamp_ms AS timestamp, created_at,
                           gold_cup, silver_cup, bronze_cup, trophy
                    FROM (
                        SELECT * FROM chat_messages
                        WHERE DATE(created_at) = CURDATE()
                        ORDER BY id DESC
                        LIMIT 50
                    ) t
                    ORDER BY id ASC
                """)
                rows = cur.fetchall()
                messages = []
                for r in rows:
                    m = {
                        "id": r['id'],
                        "client_msg_id": r['client_msg_id'] or '',
                        "timestamp": r['timestamp'],
                        "account_id": r['account_id'],
                        "name": r['name'],
                        "level": r['level'],
                        "avatar": r['avatar'],
                        "content": r['content'],
                        "msg": r['msg'],
                        "type": r['type'],
                        "card_id": r['card_id'],
                        "gold_cup": r.get('gold_cup', 0),
                        "silver_cup": r.get('silver_cup', 0),
                        "bronze_cup": r.get('bronze_cup', 0),
                        "trophy": r.get('trophy', 800)
                    }
                    gc = r.get('gold_cup', 0)
                    sc = r.get('silver_cup', 0)
                    bc = r.get('bronze_cup', 0)
                    if gc > 0:
                        m['crown_id'] = 7204
                        m['crown_num'] = gc
                    elif sc > 0:
                        m['crown_id'] = 7205
                        m['crown_num'] = sc
                    elif bc > 0:
                        m['crown_id'] = 7206
                        m['crown_num'] = bc

                    if r['card_id'] > 0:
                        m['items'] = [{'info_id': r['card_id'], '_infoId': r['card_id'], 'num': 1, '_num': 1}]
                    if r['type'] == 3 and r['content'] and (r['content'].startswith('{') or '"replay_id"' in r['content']):
                        try:
                            m['battle_data'] = json.loads(r['content'])
                        except Exception:
                            pass
                    messages.append(m)
                return messages
    except Exception as e:
        print("[CHAT DB ERR] get history error:", e)
        return []

def db_save_chat_message(msg_obj):
    ensure_chat_db()
    try:
        with get_db() as conn:
            with conn.cursor() as cur:
                cur.execute("""
                    INSERT INTO chat_messages 
                    (client_msg_id, account_id, sender_name, level, avatar, msg_type, card_id, content, created_at, timestamp_ms, gold_cup, silver_cup, bronze_cup, trophy)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, NOW(), %s, %s, %s, %s, %s)
                """, (
                    msg_obj.get('client_msg_id'),
                    msg_obj.get('account_id', 1),
                    msg_obj.get('name', 'Duelist'),
                    msg_obj.get('level', 1),
                    msg_obj.get('avatar', 201),
                    msg_obj.get('type', 1),
                    msg_obj.get('card_id', 0),
                    msg_obj.get('content', ''),
                    msg_obj.get('timestamp', int(time.time() * 1000)),
                    msg_obj.get('gold_cup', 0),
                    msg_obj.get('silver_cup', 0),
                    msg_obj.get('bronze_cup', 0),
                    msg_obj.get('trophy', 800)
                ))
                inserted_id = cur.lastrowid
                msg_obj['id'] = inserted_id
                return inserted_id
    except Exception as e:
        print("[CHAT DB ERR] save message error:", e)
        return msg_obj.get('id', int(time.time() * 1000))

# ----------------- WebSocket Server -----------------
CONNECTED_CHAT_CLIENTS = set()
WS_CHAT_LOOP = None

def make_chat_frame(payload_dict):
    body = json.dumps(payload_dict, ensure_ascii=False).encode('utf-8')
    return struct.pack(">I", len(body)) + body

def broadcast_chat_sync(payload_dict):
    global WS_CHAT_LOOP
    frame = make_chat_frame(payload_dict)
    dead = set()
    for ws in list(CONNECTED_CHAT_CLIENTS):
        try:
            if WS_CHAT_LOOP and WS_CHAT_LOOP.is_running():
                asyncio.run_coroutine_threadsafe(ws.send(frame), WS_CHAT_LOOP)
            else:
                dead.add(ws)
        except Exception:
            dead.add(ws)
    for ws in dead:
        CONNECTED_CHAT_CLIENTS.discard(ws)

async def chat_ws_handler(websocket):
    CONNECTED_CHAT_CLIENTS.add(websocket)
    client_ip = websocket.remote_address
    print(f"[CHAT WS] Client connected: {client_ip} (Total: {len(CONNECTED_CHAT_CLIENTS)})")
    try:
        async for message in websocket:
            text = ""
            if isinstance(message, str):
                text = message
            elif isinstance(message, bytes):
                if len(message) >= 4:
                    length = struct.unpack(">I", message[:4])[0]
                    text = message[4:4+length].decode('utf-8', errors='ignore')
                else:
                    text = message.decode('utf-8', errors='ignore')
            if text:
                try:
                    pkt = json.loads(text)
                    t = pkt.get("t")
                    if t == "ping":
                        await websocket.send(make_chat_frame({"t": "pong"}))
                    elif t == "chat":
                        msg_obj = pkt.get("msg")
                        if msg_obj:
                            db_id = db_save_chat_message(msg_obj)
                            msg_obj['id'] = db_id
                            broadcast_chat_sync({"t": "chat_broadcast", "msg": msg_obj})
                except Exception as e:
                    print("[CHAT WS ERR]", e)
    except Exception:
        pass
    finally:
        CONNECTED_CHAT_CLIENTS.discard(websocket)
        print(f"[CHAT WS] Client disconnected: {client_ip} (Remaining: {len(CONNECTED_CHAT_CLIENTS)})")

def run_ws_server():
    global WS_CHAT_LOOP
    WS_CHAT_LOOP = asyncio.new_event_loop()
    asyncio.set_event_loop(WS_CHAT_LOOP)
    
    async def main():
        server = await websockets.serve(chat_ws_handler, "0.0.0.0", CHAT_WS_PORT, max_size=10*1024*1024)
        print(f"[CHAT WS SERVER] Listening on ws://0.0.0.0:{CHAT_WS_PORT}")
        await asyncio.Future()

    WS_CHAT_LOOP.run_until_complete(main())

# ----------------- HTTP Server -----------------
class ChatHTTPHandler(BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        pass

    def _send_cors_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With')

    def do_OPTIONS(self):
        self.send_response(200)
        self._send_cors_headers()
        self.end_headers()

    def _send_json(self, data, status=200):
        body = json.dumps(data, ensure_ascii=False).encode('utf-8')
        self.send_response(status)
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self._send_cors_headers()
        self.send_header('Content-Length', str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        if self.path.startswith('/api/chat_history'):
            today_msgs = db_get_today_chat_history()
            self._send_json({"code": 200, "messages": today_msgs})
        elif self.path == '/api/health':
            self._send_json({"status": "ok", "service": "yugioh_chat_server", "clients": len(CONNECTED_CHAT_CLIENTS)})
        else:
            self._send_json({"code": 404, "msg": "Not found"}, 404)

    def do_POST(self):
        content_len = int(self.headers.get('Content-Length', 0))
        raw_body = self.rfile.read(content_len) if content_len > 0 else b'{}'
        try:
            req = json.loads(raw_body.decode('utf-8'))
        except Exception:
            req = {}

        if self.path == '/api/chat_history':
            today_msgs = db_get_today_chat_history()
            self._send_json({"code": 200, "messages": today_msgs})

        elif self.path == '/api/chat_send':
            acc_id = req.get('account_id') or req.get('sender_id') or 1
            name = req.get('name') or req.get('sender_name') or 'Duelist'
            try:
                level = int(req.get('level', 1))
            except Exception:
                level = 1
            try:
                avatar = int(req.get('avatar', 201))
            except Exception:
                avatar = 201
            content = str(req.get('content') or req.get('msg') or '').strip()
            try:
                msg_type = int(req.get('type', 1))
            except Exception:
                msg_type = 1
            card_id = int(req.get('card_id', 0))
            client_msg_id = req.get('client_msg_id')
            gold_cup = int(req.get('gold_cup', 0))
            silver_cup = int(req.get('silver_cup', 0))
            bronze_cup = int(req.get('bronze_cup', 0))
            trophy = int(req.get('trophy', 800))

            if content:
                now_ts = int(time.time() * 1000)
                msg_obj = {
                    "client_msg_id": client_msg_id,
                    "timestamp": now_ts,
                    "account_id": acc_id,
                    "name": name,
                    "level": level,
                    "avatar": avatar,
                    "content": content,
                    "msg": content,
                    "type": msg_type,
                    "card_id": card_id,
                    "gold_cup": gold_cup,
                    "silver_cup": silver_cup,
                    "bronze_cup": bronze_cup,
                    "trophy": trophy
                }
                if gold_cup > 0:
                    msg_obj['crown_id'] = 7204
                    msg_obj['crown_num'] = gold_cup
                elif silver_cup > 0:
                    msg_obj['crown_id'] = 7205
                    msg_obj['crown_num'] = silver_cup
                elif bronze_cup > 0:
                    msg_obj['crown_id'] = 7206
                    msg_obj['crown_num'] = bronze_cup

                if card_id > 0:
                    msg_obj['items'] = [{'info_id': card_id, '_infoId': card_id, 'num': 1, '_num': 1}]
                if msg_type == 3 and (content.startswith('{') or '"replay_id"' in content):
                    try:
                        msg_obj['battle_data'] = json.loads(content)
                    except Exception:
                        pass

                db_id = db_save_chat_message(msg_obj)
                msg_obj['id'] = db_id
                broadcast_chat_sync({"t": "chat_broadcast", "msg": msg_obj})
                print(f"[CHAT MSG] {name} (Lv.{level}): {content[:60]}... [DB ID: {db_id}]")
                self._send_json({"code": 200, "msg": "Sent", "data": msg_obj})
            else:
                self._send_json({"code": 400, "msg": "Nội dung trống!"}, 400)
        else:
            self._send_json({"code": 404, "msg": "Not found"}, 404)

def run_http_server():
    server = ThreadingHTTPServer(('0.0.0.0', CHAT_HTTP_PORT), ChatHTTPHandler)
    print(f"[CHAT HTTP SERVER] Listening on http://0.0.0.0:{CHAT_HTTP_PORT}")
    server.serve_forever()

if __name__ == '__main__':
    print("=" * 60)
    print("      YU-GI-OH STANDALONE CHAT SERVER")
    print(f"      HTTP API Port   : {CHAT_HTTP_PORT}")
    print(f"      WebSocket Port  : {CHAT_WS_PORT}")
    print("=" * 60)
    ensure_chat_db()
    
    ws_thread = threading.Thread(target=run_ws_server, daemon=True)
    ws_thread.start()
    
    run_http_server()
