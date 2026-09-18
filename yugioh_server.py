import socket
import threading
import struct
import sys
import json
import hashlib
import time
import pymysql

sys.stdout.reconfigure(encoding='utf-8')

HOST = '0.0.0.0'
PORT = 9191
DB_CONFIG = {
    'host': '127.0.0.1',
    'user': 'root',
    'password': '',
    'database': 'yugioh_game',
    'charset': 'utf8mb4',
    'autocommit': True
}

def get_db():
    return pymysql.connect(**DB_CONFIG, cursorclass=pymysql.cursors.DictCursor)

print("===========================================================")
print("   YUGIOH ONLINE MASTER SERVER (Quyết Chiến Chi Thành)     ")
print(f"   TCP Socket Server on {HOST}:{PORT}                      ")
print(f"   Connected to MySQL: {DB_CONFIG['database']}             ")
print("===========================================================")

SERVERS = [
    {
        "id": 1,
        "name": "S1 - Quyết Chiến Chi Thành",
        "host": "10.0.2.2:9191",
        "status": 1,
        "is_new": 1,
        "is_recommend": 1
    },
    {
        "id": 2,
        "name": "S2 - Đấu Trường Hải Mã",
        "host": "10.0.2.2:9191",
        "status": 1,
        "is_new": 1,
        "is_recommend": 0
    }
]

def authenticate_account(username, password):
    with get_db() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM accounts WHERE username = %s", (username,))
            acc = cur.fetchone()
            if not acc:
                return None, "Tài khoản không tồn tại!"
            
            hashed = hashlib.sha256(password.encode('utf-8')).hexdigest()
            if acc['password'] == password or acc['password'] == hashed:
                cur.execute("UPDATE accounts SET last_login = NOW() WHERE id = %s", (acc['id'],))
                acc_clean = dict(acc)
                acc_clean.pop('password', None)
                if acc_clean.get('last_login'):
                    acc_clean['last_login'] = str(acc_clean['last_login'])
                if acc_clean.get('created_at'):
                    acc_clean['created_at'] = str(acc_clean['created_at'])
                return acc_clean, "Đăng nhập thành công!"
            else:
                return None, "Mật khẩu không chính xác!"

def register_account(username, password, character_name=None):
    with get_db() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT id FROM accounts WHERE username = %s", (username,))
            if cur.fetchone():
                return None, "Tên tài khoản đã tồn tại!"
            
            if not character_name or character_name.strip() == "":
                character_name = f"Duelist_{username}"
            
            hashed = hashlib.sha256(password.encode('utf-8')).hexdigest()
            cur.execute("""
                INSERT INTO accounts (username, password, character_name, server, gold, gem, void_stone, purple_ticket, leya_ticket, level, exp, vip_level)
                VALUES (%s, %s, %s, 'S1 - Quyết Chiến Chi Thành', 500000, 50000, 1000, 50, 50, 1, 0, 1)
            """, (username, hashed, character_name))
            acc_id = cur.lastrowid
            
            cur.execute("SELECT id FROM card_monsters WHERE quality != 'GR' ORDER BY RAND() LIMIT 20")
            monster_ids = [r['id'] if isinstance(r, dict) else r[0] for r in cur.fetchall()]
            cur.execute("SELECT id FROM card_spells WHERE quality != 'GR' ORDER BY RAND() LIMIT 10")
            spell_ids = [r['id'] if isinstance(r, dict) else r[0] for r in cur.fetchall()]
            cur.execute("SELECT id FROM card_traps WHERE quality != 'GR' ORDER BY RAND() LIMIT 10")
            trap_ids = [r['id'] if isinstance(r, dict) else r[0] for r in cur.fetchall()]
            cur.execute("SELECT id FROM card_extra WHERE quality != 'GR' ORDER BY RAND() LIMIT 15")
            extra_ids = [r['id'] if isinstance(r, dict) else r[0] for r in cur.fetchall()]

            main_deck = monster_ids + spell_ids + trap_ids
            for cid in main_deck + extra_ids:
                cur.execute("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, %s, 1)", (acc_id, cid))
            
            main_json = json.dumps(main_deck)
            extra_json = json.dumps(extra_ids)
            starter_decks = [
                (acc_id, 1, 'Bộ Bài Tân Thủ', main_json, extra_json, 1),
                (acc_id, 2, 'Bộ Bài 2', main_json, extra_json, 0),
                (acc_id, 3, 'Bộ Bài 3', main_json, extra_json, 0)
            ]
            for d in starter_decks:
                cur.execute("INSERT INTO user_decks (account_id, deck_slot, deck_name, cards, extra_cards, is_active) VALUES (%s, %s, %s, %s, %s, %s)", d)
            
            cur.execute("SELECT * FROM accounts WHERE id = %s", (acc_id,))
            acc = cur.fetchone()
            acc_clean = dict(acc)
            acc_clean.pop('password', None)
            if acc_clean.get('last_login'):
                acc_clean['last_login'] = str(acc_clean['last_login'])
            if acc_clean.get('created_at'):
                acc_clean['created_at'] = str(acc_clean['created_at'])
            return acc_clean, "Đăng ký thành công!"

def get_player_full_data(account_id):
    with get_db() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM accounts WHERE id = %s", (account_id,))
            acc = cur.fetchone()
            if not acc: return None
            
            acc_clean = dict(acc)
            acc_clean.pop('password', None)
            if acc_clean.get('last_login'):
                acc_clean['last_login'] = str(acc_clean['last_login'])
            if acc_clean.get('created_at'):
                acc_clean['created_at'] = str(acc_clean['created_at'])
            
            cur.execute("SELECT card_id, count FROM user_cards WHERE account_id = %s", (account_id,))
            cards = cur.fetchall()
            
            cur.execute("SELECT deck_slot, deck_name, cards, extra_cards, is_active FROM user_decks WHERE account_id = %s ORDER BY deck_slot", (account_id,))
            decks_raw = cur.fetchall()
            decks = []
            for d in decks_raw:
                c_list = d['cards']
                if isinstance(c_list, str):
                    try: c_list = json.loads(c_list)
                    except: c_list = []
                extra_c = d['extra_cards']
                if isinstance(extra_c, str):
                    try: extra_c = json.loads(extra_c)
                    except: extra_c = []
                decks.append({
                    "deck_slot": d['deck_slot'],
                    "deck_name": d['deck_name'],
                    "cards": c_list,
                    "extra_cards": extra_c,
                    "is_active": d['is_active']
                })
            
            return {
                "account": acc_clean,
                "cards": cards,
                "decks": decks
            }

def save_player_deck(account_id, deck_slot, deck_name, cards, extra_cards, is_active=1):
    with get_db() as conn:
        with conn.cursor() as cur:
            cur.execute("""
                INSERT INTO user_decks (account_id, deck_slot, deck_name, cards, extra_cards, is_active)
                VALUES (%s, %s, %s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE deck_name = VALUES(deck_name), cards = VALUES(cards), extra_cards = VALUES(extra_cards), is_active = VALUES(is_active)
            """, (account_id, deck_slot, deck_name, json.dumps(cards), json.dumps(extra_cards), is_active))
            return True

def handle_client(client_socket, client_address):
    print(f"[TCP] New client connected: {client_address}")
    buffer = ""
    try:
        while True:
            chunk = client_socket.recv(4096)
            if not chunk:
                break
            buffer += chunk.decode('utf-8', errors='ignore')
            while '\n' in buffer:
                line, buffer = buffer.split('\n', 1)
                line = line.strip()
                if not line:
                    continue
                try:
                    req = json.loads(line)
                    action = req.get('action', '')
                    resp = {}
                    
                    if action == 'login':
                        username = req.get('username', '')
                        password = req.get('password', '')
                        acc, msg = authenticate_account(username, password)
                        if acc:
                            resp = {
                                "code": 200,
                                "msg": msg,
                                "account": acc,
                                "servers": SERVERS
                            }
                            print(f"[LOGIN SUCCESS] Account: {acc['username']} ({acc['character_name']}) - Lv {acc['level']}")
                        else:
                            resp = {"code": 401, "msg": msg}
                            print(f"[LOGIN FAIL] User '{username}': {msg}")
                    
                    elif action == 'register':
                        username = req.get('username', '')
                        password = req.get('password', '')
                        cname = req.get('character_name', '')
                        acc, msg = register_account(username, password, cname)
                        if acc:
                            resp = {
                                "code": 200,
                                "msg": msg,
                                "account": acc,
                                "servers": SERVERS
                            }
                            print(f"[REGISTER SUCCESS] New account: {acc['username']} ({acc['character_name']})")
                        else:
                            resp = {"code": 400, "msg": msg}
                            print(f"[REGISTER FAIL] User '{username}': {msg}")
                    
                    elif action == 'get_servers':
                        resp = {"code": 200, "servers": SERVERS}
                    
                    elif action == 'enter_game':
                        account_id = req.get('account_id')
                        server_id = req.get('server_id', 1)
                        data = get_player_full_data(account_id)
                        if data:
                            resp = {"code": 200, "msg": "OK", "data": data}
                            acc = data['account']
                            print(f"[ENTER GAME] {acc['character_name']} entered Server {server_id}. Loaded {len(data['cards'])} cards, {len(data['decks'])} decks.")
                        else:
                            resp = {"code": 404, "msg": "Không tìm thấy dữ liệu người chơi!"}
                    
                    elif action == 'save_deck':
                        acc_id = req.get('account_id')
                        d_slot = req.get('deck_slot', 1)
                        d_name = req.get('deck_name', 'Deck')
                        cards = req.get('cards', [])
                        extra_cards = req.get('extra_cards', [])
                        save_player_deck(acc_id, d_slot, d_name, cards, extra_cards)
                        resp = {"code": 200, "msg": "Lưu deck thành công!"}
                        print(f"[SAVE DECK] Saved deck '{d_name}' for account {acc_id} ({len(cards)} cards).")
                    
                    elif action == 'ping' or action == 'heartbeat':
                        resp = {"code": 200, "msg": "pong", "time": int(time.time())}
                    
                    else:
                        resp = {"code": 400, "msg": f"Unknown action: {action}"}
                    
                    out_bytes = (json.dumps(resp, ensure_ascii=False) + '\n').encode('utf-8')
                    client_socket.sendall(out_bytes)
                except Exception as e:
                    print(f"[TCP ERROR] Processing error: {e}")
                    err_resp = {"code": 500, "msg": str(e)}
                    client_socket.sendall((json.dumps(err_resp) + '\n').encode('utf-8'))
    except ConnectionResetError:
        pass
    except Exception as e:
        print(f"[TCP Connection Error] {e}")
    finally:
        client_socket.close()
        print(f"[TCP] Client disconnected: {client_address}")

def start_server():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind((HOST, PORT))
    server.listen(10)
    print(f"[Server] Listening on {HOST}:{PORT}...")
    while True:
        client_sock, client_addr = server.accept()
        thread = threading.Thread(target=handle_client, args=(client_sock, client_addr), daemon=True)
        thread.start()

if __name__ == '__main__':
    start_server()
