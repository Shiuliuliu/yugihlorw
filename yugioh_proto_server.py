import socket
import threading
import struct
import sys
import time
import os
import json
import pymysql

sys.stdout.reconfigure(encoding='utf-8')
sys.stderr.reconfigure(encoding='utf-8')

HOST = '0.0.0.0'
PORT = 9191

FIB = [1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,584,4181,6765,10946,17711,28657,46368,75025,121393,196418,317811,514229,832040,1346269,2178309,3524578,5702887,9227465,14930352,24157817,39088169,63245986,102334155,165580141,267914296,433494437,701408733,1134903170,1836311903]

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

def get_local_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(('8.8.8.8', 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except Exception:
        return '192.168.1.2'

def calc_crc16(data):
    crc = 0
    for b in data:
        crc ^= b
        for _ in range(8):
            if crc & 1:
                crc = (crc >> 1) ^ 0xa001
            else:
                crc >>= 1
    return crc & 0xFFFF

def encrypt_data(data, key):
    mod_key = abs(key) % 46
    fib = FIB[mod_key]
    shift = fib & 7
    out = bytearray(len(data))
    for i in range(len(data)):
        b = data[i]
        r2 = (-shift) & 7
        b = ((b << shift) | (b >> r2)) & 0xFF
        b ^= mod_key
        out[i] = b
        shift = (shift + 1) & 7
    return bytes(out)

def decrypt_data(data, key):
    mod_key = abs(key) % 46
    fib = FIB[mod_key]
    shift = fib & 7
    out = bytearray(len(data))
    for i in range(len(data)):
        b = data[i]
        r5 = (-shift) & 7
        b ^= mod_key
        r7 = (b >> shift) & 0xFF
        b = ((b << r5) | r7) & 0xFF
        out[i] = b
        shift = (shift + 1) & 7
    return bytes(out)

def encode_varint(val):
    val = int(val)
    if val < 0:
        val = (1 << 64) + val
    res = bytearray()
    while val > 0x7f:
        res.append((val & 0x7f) | 0x80)
        val >>= 7
    res.append(val & 0x7f)
    return bytes(res)

def decode_varint(buf, offset=0):
    res = 0
    shift = 0
    idx = offset
    while idx < len(buf):
        b = buf[idx]
        res |= (b & 0x7f) << shift
        idx += 1
        if not (b & 0x80):
            break
        shift += 7
    return res, idx

def encode_field(fn, wt, data):
    tag = encode_varint((fn << 3) | wt)
    if wt == 0:
        return tag + encode_varint(data)
    elif wt == 2:
        if isinstance(data, str):
            data = data.encode('utf-8')
        return tag + encode_varint(len(data)) + data
    raise ValueError(f"Unsupported wt {wt}")

def build_region_list_resp(client_ip="192.168.1.2"):
    local_ip = get_local_ip()
    target_host = f"{local_ip}:{PORT}"
    
    # Region 1
    r1 = bytearray()
    r1 += encode_field(1, 0, 1) # id = 1
    r1 += encode_field(2, 2, target_host) # host
    r1 += encode_field(3, 2, "S1 - Quyết Chiến Chi Thành") # name
    r1 += encode_field(4, 0, 1) # status = 1 (IDLE)
    r1 += encode_field(5, 0, 1) # is_new = 1
    r1 += encode_field(6, 0, 1) # is_recommend = 1
    r1 += encode_field(7, 0, int(time.time() * 1000))
    
    # Region 2
    r2 = bytearray()
    r2 += encode_field(1, 0, 2) # id = 2
    r2 += encode_field(2, 2, target_host)
    r2 += encode_field(3, 2, "S2 - Đấu Trường Hải Mã")
    r2 += encode_field(4, 0, 1)
    r2 += encode_field(5, 0, 1)
    r2 += encode_field(6, 0, 0)
    r2 += encode_field(7, 0, int(time.time() * 1000))

    # RegionListResp
    rl_resp = bytearray()
    rl_resp += encode_field(1, 2, bytes(r1))
    rl_resp += encode_field(1, 2, bytes(r2))

    # SglRespMsg
    sgl_resp = bytearray()
    sgl_resp += encode_field(1, 0, 1900) # type = 1900 (PB_TYPE_REGION_LIST)
    sgl_resp += encode_field(2, 0, 0)    # status = 0 (PB_STATUS_OK)
    sgl_resp += encode_field(1900, 2, bytes(rl_resp)) # extension 1900 = region_list_resp

    return bytes(sgl_resp)

def build_auth_resp():
    sgl_resp = bytearray()
    sgl_resp += encode_field(1, 0, 101) # type = 101 (PB_TYPE_AUTHENTICATION)
    sgl_resp += encode_field(2, 0, 0)   # status = 0 (PB_STATUS_OK)
    return bytes(sgl_resp)

def build_generic_resp(req_type, status=0):
    sgl_resp = bytearray()
    sgl_resp += encode_field(1, 0, req_type)
    sgl_resp += encode_field(2, 0, status)
    return bytes(sgl_resp)

# Protobuf Builders for Full User Login
def build_resource(info_id, num):
    b = bytearray()
    b += encode_field(1, 0, info_id)
    b += encode_field(2, 0, num)
    return bytes(b)

def build_card_level(info_id, level):
    b = bytearray()
    b += encode_field(1, 0, info_id)
    b += encode_field(2, 0, level)
    return bytes(b)

def build_troop(cards_list, name="Deck"):
    b = bytearray()
    for cid, cnt in cards_list:
        b += encode_field(1, 2, build_resource(cid, cnt))
    if name:
        b += encode_field(2, 2, name)
    return bytes(b)

def build_player_card(cards, decks):
    b = bytearray()
    for c in cards:
        cid = c['card_id']
        cnt = c['count']
        b += encode_field(1, 2, build_resource(cid, cnt))
        b += encode_field(3, 2, build_card_level(cid, 1))
        b += encode_field(4, 0, cid)
        b += encode_field(11, 0, cid)
    
    for d in decks:
        c_list = d.get('cards', [])
        if isinstance(c_list, str):
            try: c_list = json.loads(c_list)
            except: c_list = []
        counts = {}
        for cid in c_list:
            cid = int(cid)
            counts[cid] = counts.get(cid, 0) + 1
        items = list(counts.items())
        b += encode_field(2, 2, build_troop(items, d.get('deck_name', 'Deck')))
    
    b += encode_field(10, 0, 5) # extra_troop_count = 5
    return bytes(b)

def build_user_info(acc):
    now_ms = int(time.time() * 1000)
    b = bytearray()
    b += encode_field(1, 0, acc.get('id', 1))
    b += encode_field(2, 2, acc.get('character_name', 'Duelist'))
    b += encode_field(3, 0, acc.get('gold', 99999999))
    b += encode_field(4, 0, 99999999) # grain
    b += encode_field(5, 0, acc.get('gem', 999999)) # ingot
    b += encode_field(6, 0, acc.get('level', 50))
    b += encode_field(7, 0, acc.get('exp', 0))
    b += encode_field(8, 0, acc.get('trophy', 800))
    b += encode_field(9, 0, acc.get('vip_level', 15))
    b += encode_field(10, 0, acc.get('avatar', 301))
    b += encode_field(11, 0, 20000) # guide = 20000 (skip tutorial)
    b += encode_field(18, 0, now_ms) # last_login
    b += encode_field(19, 0, 0) # vip_exp
    b += encode_field(20, 0, 1) # def_troop
    b += encode_field(21, 0, 7600) # card_back
    b += encode_field(22, 0, 0) # avatar_frame
    b += encode_field(23, 0, now_ms) # reg_date
    b += encode_field(24, 0, 0) # config
    b += encode_field(25, 0, 0) # privilege
    b += encode_field(27, 0, 1) # rid = 1
    b += encode_field(28, 0, 20000) # guide1
    b += encode_field(29, 0, 20000) # guide2
    return bytes(b)

def build_user_battle():
    b = bytearray()
    for fn in range(1, 18):
        b += encode_field(fn, 0, 0)
    return bytes(b)

def build_user_lottery():
    b = bytearray()
    b += encode_field(2, 0, 1) # next_quality = 1
    b += encode_field(4, 0, 0) # nchest = 0
    b += encode_field(5, 0, 0) # nchest_ex = 0
    b += encode_field(6, 0, 0) # point = 0
    return bytes(b)

def build_user_count():
    b = bytearray()
    for fn in range(1, 55):
        b += encode_field(fn, 0, 0)
    return bytes(b)

def build_player_world(cur_levels):
    b = bytearray()
    for lvl in cur_levels:
        b += encode_field(1, 0, lvl)
    return bytes(b)

def build_player_city():
    b = bytearray()
    now_ms = int(time.time() * 1000)
    b += encode_field(4, 0, now_ms) # last_visit
    b += encode_field(5, 0, now_ms) # last_collect_gold
    b += encode_field(6, 0, now_ms) # last_collect_grain
    return bytes(b)

def build_attach_data():
    b = bytearray()
    # 1: prop
    prop = bytearray()
    for mark in ["Deck 1", "Deck 2", "Deck 3", "Deck 4", "Deck 5"]:
        prop += encode_field(1, 2, mark)
    b += encode_field(1, 2, bytes(prop))
    
    # 2: shop
    shop = bytearray()
    b += encode_field(2, 2, bytes(shop))
    
    # 3: bonus
    bonus = bytearray()
    bonus += encode_field(8, 0, 1) # login_days
    bonus += encode_field(9, 0, 1) # sign_in_days
    b += encode_field(3, 2, bytes(bonus))
    
    # 4: copy
    copy = bytearray()
    b += encode_field(4, 2, bytes(copy))
    
    # 5: activity
    act = bytearray()
    now_ms = int(time.time() * 1000)
    act += encode_field(14, 0, 1) # badge_season
    act += encode_field(15, 0, 1) # badge_level
    act += encode_field(18, 0, now_ms + 2592000000) # badge_end_timestamp
    b += encode_field(5, 2, bytes(act))
    
    # 6: character
    char_b = bytearray()
    char_b += encode_field(1, 0, 0)
    for cid in range(1, 9):
        single_char = bytearray()
        single_char += encode_field(1, 0, cid)
        single_char += encode_field(2, 0, 50)
        single_char += encode_field(3, 0, 0)
        single_char += encode_field(4, 0, 0)
        single_char += encode_field(5, 0, cid * 100 + 1)
        char_b += encode_field(2, 2, bytes(single_char))
    b += encode_field(6, 2, bytes(char_b))
    
    # 7: ladder
    ladder = bytearray()
    b += encode_field(7, 2, bytes(ladder))
    
    # 8: dark
    dark = bytearray()
    b += encode_field(8, 2, bytes(dark))
    
    # 9: survival
    surv = bytearray()
    b += encode_field(9, 2, bytes(surv))
    
    # 10: survival_ex
    surv_ex = bytearray()
    b += encode_field(10, 2, bytes(surv_ex))
    
    return bytes(b)

def build_user_in_resp(acc, cards, decks, cur_levels):
    b = bytearray()
    now_ms = int(time.time() * 1000)
    b += encode_field(1, 2, build_user_info(acc))
    b += encode_field(2, 2, build_player_card(cards, decks))
    b += encode_field(3, 2, build_attach_data())
    b += encode_field(4, 2, build_player_city())
    b += encode_field(5, 2, build_player_world(cur_levels))
    b += encode_field(6, 2, build_user_battle())
    b += encode_field(7, 2, build_user_lottery())
    b += encode_field(8, 2, build_user_count())
    b += encode_field(9, 2, "Chào mừng đến với Yu-Gi-Oh Online!")
    b += encode_field(10, 0, 0)
    b += encode_field(11, 0, now_ms)
    b += encode_field(12, 0, 0)
    b += encode_field(14, 0, now_ms)
    b += encode_field(16, 0, 0)
    b += encode_field(18, 0, 0)
    b += encode_field(20, 0, 0)
    b += encode_field(21, 0, now_ms)
    b += encode_field(22, 2, "1.0.7")
    return bytes(b)

def build_sgl_login_resp(acc, cards, decks, cur_levels):
    user_in_resp = build_user_in_resp(acc, cards, decks, cur_levels)
    sgl_resp = bytearray()
    sgl_resp += encode_field(1, 0, 300) # type = PB_TYPE_USER_LOGIN
    sgl_resp += encode_field(2, 0, 0)   # status = PB_STATUS_OK
    sgl_resp += encode_field(300, 2, user_in_resp) # extension 300 = user_in_resp
    return bytes(sgl_resp)

def load_or_create_account(cid=None, user_id=None):
    try:
        with get_db() as conn:
            with conn.cursor() as cur:
                acc = None
                if user_id and user_id > 0:
                    cur.execute("SELECT * FROM accounts WHERE id = %s", (user_id,))
                    acc = cur.fetchone()
                
                if not acc and cid:
                    cur.execute("SELECT * FROM accounts WHERE username = %s", (str(cid),))
                    acc = cur.fetchone()
                
                if not acc:
                    cur.execute("SELECT * FROM accounts WHERE username = 'admin'")
                    acc = cur.fetchone()
                
                if not acc:
                    # Create default admin account
                    cur.execute("""
                        INSERT INTO accounts (username, password, character_name, server, gold, gem, level, exp, vip_level, trophy, avatar)
                        VALUES ('admin', 'admin', 'Vua_Tro_Choi_2026', 'S1 - Quyết Chiến Chi Thành', 99999999, 999999, 50, 0, 15, 800, 301)
                    """)
                    acc_id = cur.lastrowid
                    cur.execute("SELECT * FROM accounts WHERE id = %s", (acc_id,))
                    acc = cur.fetchone()
                
                acc_id = acc['id']
                
                # Fetch cards
                cur.execute("SELECT card_id, count FROM user_cards WHERE account_id = %s", (acc_id,))
                cards = cur.fetchall()
                if not cards:
                    # Grant starter cards
                    cur.execute("SELECT id FROM card_monsters WHERE quality != 'GR' LIMIT 20")
                    m_ids = [r['id'] for r in cur.fetchall()]
                    cur.execute("SELECT id FROM card_spells WHERE quality != 'GR' LIMIT 10")
                    s_ids = [r['id'] for r in cur.fetchall()]
                    cur.execute("SELECT id FROM card_traps WHERE quality != 'GR' LIMIT 10")
                    t_ids = [r['id'] for r in cur.fetchall()]
                    cur.execute("SELECT id FROM card_extra WHERE quality != 'GR' LIMIT 20")
                    e_ids = [r['id'] for r in cur.fetchall()]
                    
                    starter_cards = [(acc_id, cid, 3) for cid in (m_ids + s_ids + t_ids + e_ids)]
                    if starter_cards:
                        cur.executemany("INSERT IGNORE INTO user_cards (account_id, card_id, count) VALUES (%s, %s, %s)", starter_cards)
                        cur.execute("SELECT card_id, count FROM user_cards WHERE account_id = %s", (acc_id,))
                        cards = cur.fetchall()

                # Fetch decks
                cur.execute("SELECT deck_slot, deck_name, cards, extra_cards, is_active FROM user_decks WHERE account_id = %s ORDER BY deck_slot", (acc_id,))
                decks = cur.fetchall()
                if not decks and cards:
                    sample_cards = [c['card_id'] for c in cards[:40]]
                    sample_json = json.dumps(sample_cards)
                    cur.execute("INSERT INTO user_decks (account_id, deck_slot, deck_name, cards, extra_cards, is_active) VALUES (%s, 1, 'Bộ Bài S1', %s, '[]', 1)", (acc_id, sample_json))
                    decks = [{'deck_slot': 1, 'deck_name': 'Bộ Bài S1', 'cards': sample_cards, 'extra_cards': [], 'is_active': 1}]
                
                # Fetch levels
                cur.execute("SELECT cur_level FROM user_levels WHERE account_id = %s ORDER BY difficulty", (acc_id,))
                levels_rows = cur.fetchall()
                if levels_rows:
                    cur_levels = [r['cur_level'] for r in levels_rows]
                else:
                    cur_levels = [10101, 20101, 30101, 40101]

                return acc, cards, decks, cur_levels

    except Exception as e:
        print(f"[DB ERROR] load_or_create_account: {e}")
        # Return fallback mock data
        mock_acc = {'id': 1, 'character_name': 'Vua_Tro_Choi_2026', 'gold': 99999999, 'gem': 999999, 'level': 50, 'vip_level': 15, 'avatar': 301}
        mock_cards = [{'card_id': 10001, 'count': 3}, {'card_id': 10002, 'count': 3}]
        mock_decks = [{'deck_slot': 1, 'deck_name': 'Bộ Bài Tân Thủ', 'cards': [10001, 10002], 'extra_cards': [], 'is_active': 1}]
        mock_levels = [10101, 20101, 30101, 40101]
        return mock_acc, mock_cards, mock_decks, mock_levels

class ClientSession:
    def __init__(self, sock, addr):
        self.sock = sock
        self.addr = addr
        self.s_serial = -324539134
        self.s_step = 34843
        self.c_serial = 15444876
        self.c_step = 30433
        self.authenticated = False
        self.is_encrypted = False

    def send_raw_frame(self, data):
        frame = struct.pack('>I', len(data)) + data
        self.sock.sendall(frame)

    def send_proto_msg(self, body):
        if not self.is_encrypted:
            self.send_raw_frame(body)
            return

        self.s_serial = (self.s_serial + self.s_step) & 0xFFFFFFFF
        crc = calc_crc16(body)
        raw_payload = body + struct.pack('>H', crc)
        enc_payload = encrypt_data(raw_payload, self.s_serial)
        self.send_raw_frame(enc_payload)

    def decrypt_frame(self, frame_data):
        if not self.is_encrypted:
            return frame_data

        # Client increments c_serial before encrypting
        self.c_serial = (self.c_serial + self.c_step) & 0xFFFFFFFF
        dec = decrypt_data(frame_data, self.c_serial)
        if len(dec) < 2:
            return None
        body = dec[:-2]
        crc_rx = struct.unpack('>H', dec[-2:])[0]
        crc_calc = calc_crc16(body)
        if crc_rx != crc_calc:
            print(f"[TCP CRC MISMATCH] rx={crc_rx} calc={crc_calc}, trying step fallback")
            # Fallback search
            for s in range(46):
                test_dec = decrypt_data(frame_data, s)
                if len(test_dec) >= 2 and calc_crc16(test_dec[:-2]) == struct.unpack('>H', test_dec[-2:])[0]:
                    print(f"  [+] Recovered with step {s}")
                    return test_dec[:-2]
            return None
        return body

def handle_client(sock, addr):
    print(f"\n[TCP] Connection accepted from {addr}")
    sock.settimeout(60)
    session = ClientSession(sock, addr)
    
    # 1. Send Challenge Frame immediately on connect
    # SglRespMsg(type=100 PB_TYPE_CHALLENGE, status=0, challenge string of 36 bytes)
    challenge_frame = bytes.fromhex("0000002b08641000a206240102030452934c32eca7ed0296d67b750000881bfbdd333800ebab8cdbec54dd000076e1")
    try:
        sock.sendall(challenge_frame)
        print(f"[TCP] Sent challenge frame ({len(challenge_frame)} bytes) to {addr}")
        sys.stdout.flush()
    except Exception as e:
        print(f"[TCP ERROR] Send challenge failed: {e}")
        sock.close()
        return

    recv_count = 0
    buf = bytearray()
    try:
        while True:
            chunk = sock.recv(4096)
            if not chunk:
                print(f"[TCP] Client {addr} disconnected normally")
                break
            buf.extend(chunk)
            
            while len(buf) >= 4:
                frame_len = struct.unpack('>I', buf[:4])[0]
                if len(buf) < 4 + frame_len:
                    break
                
                frame_data = bytes(buf[4:4+frame_len])
                del buf[:4+frame_len]
                recv_count += 1
                
                # First packet after challenge is encrypted authentication from client
                session.is_encrypted = True
                body = session.decrypt_frame(frame_data)
                if not body:
                    print(f"[TCP RECV #{recv_count}] Failed to decrypt frame ({len(frame_data)} bytes)")
                    continue
                
                # Parse protobuf SglReqMsg: field 1 is type (varint)
                req_type, next_off = decode_varint(body[1:]) # skip tag 0x08
                print(f"[TCP RECV #{recv_count}] Request type: {req_type} ({len(body)} bytes decrypted)")
                sys.stdout.flush()
                
                if req_type == 101 or req_type == 388 or req_type == 386 or req_type == 385:
                    print("  [+] Got AUTHENTICATION request. Sending Auth OK + Region List...")
                    auth_resp = build_auth_resp()
                    session.send_proto_msg(auth_resp)
                    
                    rl_resp = build_region_list_resp(addr[0])
                    session.send_proto_msg(rl_resp)
                    print("  [+] Sent Auth OK and Region List responses!")
                    sys.stdout.flush()

                elif req_type == 1900 or req_type == 58:
                    print("  [+] Got REGION_LIST request. Sending Region List...")
                    rl_resp = build_region_list_resp(addr[0])
                    session.send_proto_msg(rl_resp)
                    print("  [+] Sent Region List response!")
                    sys.stdout.flush()

                elif req_type == 300: # PB_TYPE_USER_LOGIN
                    print("  [+] Got USER_LOGIN request! Loading player data from MySQL...")
                    # Extract username/cid from user_login_req if present
                    acc, cards, decks, cur_levels = load_or_create_account()
                    login_resp = build_sgl_login_resp(acc, cards, decks, cur_levels)
                    session.send_proto_msg(login_resp)
                    print(f"  [+] Sent USER_LOGIN response ({len(login_resp)} bytes) for {acc['character_name']} (Lv.{acc['level']})!")
                    sys.stdout.flush()

                elif req_type == 200: # PB_TYPE_HEART_BEAT
                    resp = build_generic_resp(200, 0)
                    session.send_proto_msg(resp)

                elif req_type == 307: # PB_TYPE_USER_LOADING_DONE
                    print("  [+] Client finished loading scene! Player is IN CITY.")
                    resp = build_generic_resp(307, 0)
                    session.send_proto_msg(resp)
                    sys.stdout.flush()

                else:
                    print(f"  [*] Handled request {req_type} -> replying PB_STATUS_OK")
                    resp = build_generic_resp(req_type, 0)
                    session.send_proto_msg(resp)
                    sys.stdout.flush()

    except Exception as e:
        print(f"[TCP ERROR] {addr}: {e}")
    finally:
        sock.close()
        print(f"[TCP] Connection closed for {addr}")
        sys.stdout.flush()

def main():
    local_ip = get_local_ip()
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind((HOST, PORT))
    s.listen(10)
    print("===================================================================")
    print(f"   YU-GI-OH APK / ANDROID PROTOBUF SERVER (TCP {PORT}) READY")
    print(f"   Listening on: 0.0.0.0:{PORT} (Local LAN: {local_ip}:{PORT})")
    print("   Database    : MySQL yugioh_game @ 127.0.0.1:3306")
    print("===================================================================")
    sys.stdout.flush()
    while True:
        try:
            client_sock, client_addr = s.accept()
            t = threading.Thread(target=handle_client, args=(client_sock, client_addr), daemon=True)
            t.start()
        except KeyboardInterrupt:
            break
        except Exception as e:
            print(f"[ACCEPT ERROR] {e}")

if __name__ == '__main__':
    main()
