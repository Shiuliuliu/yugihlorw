import http.server
from http.server import ThreadingHTTPServer, SimpleHTTPRequestHandler
import socketserver
import socket
import threading
import json
import hashlib
import time
import datetime
import os
import sys
import pymysql
import mimetypes
import asyncio
import websockets
import random
import struct
import gzip

try:
    sys.stdout.reconfigure(encoding='utf-8', line_buffering=True)
    sys.stderr.reconfigure(encoding='utf-8', line_buffering=True)
except Exception:
    pass

mimetypes.add_type('font/ttf', '.ttf')
mimetypes.add_type('font/woff2', '.woff2')

HTTP_PORT = 8080
WS_PORT = 9192
WEB_DIR = r"D:\yugitauapk\web"

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

WS_CONNECTED_CLIENTS = set()

def get_online_player_count():
    ws_count = len(WS_CONNECTED_CLIENTS)
    db_active = 0
    try:
        with get_db() as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT COUNT(*) FROM accounts WHERE last_login >= NOW() - INTERVAL 15 MINUTE")
                row = cur.fetchone()
                if row:
                    db_active = row[0] if isinstance(row, (list, tuple)) else row.get('COUNT(*)', 0)
    except Exception:
        pass
    return max(ws_count, db_active, 1)


CANONICAL_LEVELS = [
    # Difficulty 1 (40 levels, 10 chapters x 4)
    10101, 10102, 10103, 10104,
    10201, 10202, 10203, 10204,
    10301, 10302, 10303, 10304,
    10401, 10402, 10403, 10404,
    10501, 10502, 10503, 10504,
    10601, 10602, 10603, 10604,
    10701, 10702, 10703, 10704,
    10801, 10802, 10803, 10804,
    10901, 10902, 10903, 10904,
    11001, 11002, 11003, 11004,
    # Difficulty 2 (40 levels)
    20101, 20102, 20103, 20104,
    20201, 20202, 20203, 20204,
    20301, 20302, 20303, 20304,
    20401, 20402, 20403, 20404,
    20501, 20502, 20503, 20504,
    20601, 20602, 20603, 20604,
    20701, 20702, 20703, 20704,
    20801, 20802, 20803, 20804,
    20901, 20902, 20903, 20904,
    21001, 21002, 21003, 21004,
    # Difficulty 3 (40 levels)
    30101, 30102, 30103, 30104,
    30201, 30202, 30203, 30204,
    30301, 30302, 30303, 30304,
    30401, 30402, 30403, 30404,
    30501, 30502, 30503, 30504,
    30601, 30602, 30603, 30604,
    30701, 30702, 30703, 30704,
    30801, 30802, 30803, 30804,
    30901, 30902, 30903, 30904,
    31001, 31002, 31003, 31004,
]

def get_next_level(level_id):
    if level_id in CANONICAL_LEVELS:
        idx = CANONICAL_LEVELS.index(level_id)
        if idx + 1 < len(CANONICAL_LEVELS):
            return CANONICAL_LEVELS[idx + 1]
    return level_id + 1


def sanitize_replay_data(raw_data):
    if not isinstance(raw_data, dict):
        return raw_data

    def _clean_seq(item):
        if not item:
            return []
        if isinstance(item, list):
            return [_clean_seq(x) if isinstance(x, (dict, list)) else x for x in item]
        if isinstance(item, dict):
            items = []
            for k, v in item.items():
                try:
                    idx = int(k)
                    items.append((idx, _clean_seq(v) if isinstance(v, (dict, list)) else v))
                except (ValueError, TypeError):
                    pass
            if items:
                items.sort(key=lambda x: x[0])
                return [v for _, v in items]
            return item
        return item

    for side in ['player', 'opponent']:
        side_obj = raw_data.get(side)
        if isinstance(side_obj, dict):
            for field in ['_usedCards', '_cards', '_initCards']:
                if field in side_obj:
                    side_obj[field] = _clean_seq(side_obj[field])
    return raw_data


CHAR_PACKAGE_KEYWORDS = {
    # Mutoh Yugi (ID 3)
    3: ['Phù Thủy Áo Đen', 'Kuriboh', 'Hiệp Sĩ'],
    10301: ['Phù Thủy Áo Đen', 'Kuriboh', 'Hiệp Sĩ'],
    10302: ['Phù Thủy Áo Đen', 'Kuriboh', 'Hiệp Sĩ'],
    10303: ['Phù Thủy Áo Đen', 'Kuriboh', 'Hiệp Sĩ'],
    # Seto Kaiba (ID 2)
    2: ['Mắt Xanh', 'Rồng Khổng Lồ Felgrand', 'Ác Ma'],
    10201: ['Mắt Xanh', 'Rồng Khổng Lồ Felgrand', 'Ác Ma'],
    10202: ['Mắt Xanh', 'Rồng Khổng Lồ Felgrand', 'Ác Ma'],
    10203: ['Mắt Xanh', 'Rồng Khổng Lồ Felgrand', 'Ác Ma'],
    # Joey Wheeler (ID 5)
    5: ['Mắt Đỏ', 'Chiến Thần Bujin'],
    10501: ['Mắt Đỏ', 'Chiến Thần Bujin'],
    10502: ['Mắt Đỏ', 'Chiến Thần Bujin'],
    10503: ['Mắt Đỏ', 'Chiến Thần Bujin'],
    # Mai Valentine (ID 4)
    4: ['Amazoness', 'Gió Lốc Windwitch'],
    10401: ['Amazoness', 'Gió Lốc Windwitch'],
    10402: ['Amazoness', 'Gió Lốc Windwitch'],
    10403: ['Amazoness', 'Gió Lốc Windwitch'],
    # Jaden Yuki (ID 15)
    15: ['Anh Hùng Nguyên Tố'],
    11501: ['Anh Hùng Nguyên Tố'],
    11502: ['Anh Hùng Nguyên Tố'],
    11503: ['Anh Hùng Nguyên Tố'],
    # Yusei Fudo (ID 16)
    16: ['Phế Liệu Sắt', 'Công Nghệ TG'],
    11601: ['Phế Liệu Sắt', 'Công Nghệ TG'],
    11602: ['Phế Liệu Sắt', 'Công Nghệ TG'],
    11603: ['Phế Liệu Sắt', 'Công Nghệ TG'],
    # Weevil Haga (ID 7)
    7: ['Bọ Cánh Cứng Inzektor'],
    10701: ['Bọ Cánh Cứng Inzektor'],
    # Rex Raptor (ID 10)
    10: ['Khủng Long Cơ Xảo'],
    11001: ['Khủng Long Cơ Xảo'],
    # Bonz (ID 8)
    8: ['Vampire', 'Ghostrick', 'Búp Bê Bóng Đêm Shaddoll'],
    10801: ['Vampire', 'Ghostrick', 'Búp Bê Bóng Đêm Shaddoll'],
    # Mako Tsunami (ID 9)
    9: ['Công Chúa Biển Marincess', 'Công Chúa Biển', 'Kết Giới Băng'],
    10901: ['Công Chúa Biển Marincess', 'Công Chúa Biển', 'Kết Giới Băng'],
    # Marik Ishtar (ID 18)
    18: ['Lửa Vĩnh Cửu Infernity', 'Thiên Thần Sa Ngã'],
    11801: ['Lửa Vĩnh Cửu Infernity', 'Thiên Thần Sa Ngã'],
    # Alexis Rhodes (ID 17)
    17: ['Bánh Ngọt Madolche'],
    11701: ['Bánh Ngọt Madolche'],
    # Pegasus (ID 11)
    11: ['No.', 'Bất Tri Hỏa Shiranui'],
    11101: ['No.', 'Bất Tri Hỏa Shiranui'],
    # Bandit Keith (ID 14)
    14: ['Siêu Trọng Kiếm Sĩ', 'Quái Thú Huy Hiệu'],
    11401: ['Siêu Trọng Kiếm Sĩ', 'Quái Thú Huy Hiệu'],
    # Akiza Izinski (ID 19)
    19: ['Hoa Trát Flower Cardian'],
    11901: ['Hoa Trát Flower Cardian']
}

LIYA_PACKAGE_KEYWORDS = {
    1: ['Địa Đáy Subterror', 'Khủng Long Cơ Xảo', 'Jurrac'],
    2: ['Chim Săn Mồi Raidraptor', 'Lông Đen Blackwing'],
    3: ['Xúc Xắc Speedroid', 'Phù Thủy Gió', 'Gusto'],
    4: ['Rồng Điện Tử', 'Điện Tử Cyber', 'Thiên Thần Điện Tử', 'Điện Tử Bóng Tối'],
    5: ['Toon', 'Rối Cơ Khí Gimmick', 'Con Rối Puppet', 'Ojama'],
    6: ['Chiến Thần Bujin', 'Tam Quốc', 'Quyền Thủ Lửa'],
    7: ['Đế Vương', 'Cơ Khí Cổ Đại', 'Barbaros'],
    8: ['Hỏa Thú Luân Hồi', 'Luyện Ngục Void', 'Vua Lửa', 'Thú Vua Lửa'],
    9: ['Hiệp Sĩ', 'Kiếm Sĩ X', 'Chiến Binh Hỗn Độn'],
    10: ['Ngân Hà Galaxy', 'Photon', 'Quang Ba Cipher'],
    11: ['Di Sản Tinh Tú', 'Triệu Hồi Thú Invoked', 'Orcus'],
    12: ['Lục Vũ Chúng', 'Lửa Tím Shien'],
    13: ['Búp Bê Bóng Đêm Shaddoll', 'Ghostrick', 'Vampire'],
    14: ['DDD', 'Dị Thứ Nguyên DD', 'DD', 'Khế Ước Tối'],
    15: ['Cơ Giáp Machina', 'Cơ Xảo Karakuri', 'Đoàn Tàu', 'Biến Hình Morphtronic'],
    16: ['Hoa Tuyết Rikka', 'Hương Thơm', 'Hoa Hồng', 'Hài Cốt'],
    17: ['Áo Giáp Bóng Đêm Nekroz', 'Kết Giới Băng', 'Ác Quỷ Nghi Thức'],
    18: ['hầu gái nửa rồng', 'Nòng Súng Borrel', 'Rồng Sấm Sét', 'Rồng Lửa Đỏ'],
    19: ['Ngôi sao lừa đảo', 'Công Chúa Cổ Tích', 'Cô Gái Vận Mệnh'],
    20: ['Bụi Sao', 'Rồng Bụi Sao', 'Cực Tinh Nordic', 'Cực Thần Aesir', 'Cộng Hưởng Resonator'],
    21: ['Jura', 'Jurrac', 'Chiến Binh Road', 'Kiếm sĩ X'],
    22: ['Kỵ Sĩ Bóng Đêm', 'Ngục Tối', 'Quốc Vương Hủy Diệt', 'Kiếm sĩ XX'],
    23: ['Synchron', 'Garuda', 'Hoa Hồng', 'Titania'],
    24: ['Psychic', 'Niệm Lực', 'Thông Linh'],
    25: ['Ảo Ảnh', 'Thalia', 'Jura-Giganoto', 'Master Gig'],
    26: ['Junk', 'Sắt Vụn', 'Biến Hình', 'Dịch Chuyển'],
    27: ['Gishki', 'Lắc Thăm', 'Vô Hiệu'],
    28: ['Gagaga', 'Cao Bồi', 'Cơ Hội Nhân Đôi'],
    29: ['Harpie', 'Mắt Đỏ', 'Kết Giới Băng'],
    30: ['Ma Cà Rồng', 'Vampire', 'Gishki', 'Mắt Đỏ'],
    31: ['Nhập Ma', 'Ophion', 'Coppelia'],
    32: ['HERO', 'Neos', 'Anh hùng', 'Cú Đấm Thần Thánh']
}

# 2 distinct GR/UR cards per Liya pack, distributed across all 32 packs
LIYA_PACKAGE_GR = {
    1: [10270, 10293], # Osiris, Người lính Titan
    2: [10304, 10305], # ảo tưởng sai lầm, Mã thông báo ảo ảnh
    3: [10306, 10307], # Con rối ảo ảnh, lời tiên tri sai
    4: [10308, 10407], # Tinh thần nguyền rủa, Tà Thần Thần Hóa Thân
    5: [10446, 10639], # ông già satan, Ma Vương Rabiel
    6: [10763, 10790], # Dực Thần Long Ra, Harmon Hoàng đế sấm sét
    7: [10895, 10896], # Harakti Thần sáng tạo ánh sáng, Rồng hình cầu
    8: [10902, 10967], # Uriah ngọn lửa thần thánh, Triệu hồi thần bóng tối
    9: [10969, 11083], # Sức mạnh bí ẩn EX Ánh Sáng, Sức mạnh bí ẩn EX Bóng Tối
    10: [11145, 11225], # Đọa Thiên Sứ Athena, Phù Thủy bóng tối Mahad
    11: [11308, 11338], # Phù Thủy tập sự tưởng tượng, Nữ Phù Thủy Mana
    12: [11365, 11513], # Vua Mắt Đỏ, Đọa Thiên Sứ Ixchel
    13: [11662, 11695], # Phá Hoại Long Thần Gandora, Bất Tử Điểu Ra
    14: [11853, 11934], # Thiên Long của Osiris, Lời Tiên Tri Hư Ảo
    15: [12006, 12142], # Thần Viêm Ma Hoàng Uria, Hiện thân của ác thần
    16: [12181, 20142], # Kuriboh Tái Sinh, rũ bỏ
    17: [20233, 20352], # Cú đấm thần thánh, Ngôi mộ vị thần ràng buộc
    18: [20549, 20551], # Nghi thức kết hợp mắt đỏ, Sự kết hợp mắt đỏ thực sự
    19: [20552, 20566], # Nghi lễ mắt đỏ thực sự, Excalibur Thánh Kiếm
    20: [20641, 20711], # Cánh đồng Xunfeng, quạt lông vũ Harpy
    21: [20324, 11011], # Lãnh Địa Gây Rối, Jura-Herra
    22: [11042, 11040], # Kỵ Sĩ Bóng Đêm, Hoàng Hậu Ngục Tối
    23: [11069, 20398], # Thần Gió·Garuda, Sóng Synchron Tinh Thần
    24: [11102, 40121], # Thú Niệm Động Lực, Y Sĩ Thông Linh Niệm Lực
    25: [30242, 30243], # Hình Bóng Quá Khứ, Ảo Ảnh Đại Dương
    26: [11166, 20442], # Dịch Chuyển Cực Đại, Sao Biến Hình
    27: [20142, 30259], # Lắc Thăm, Vô Hiệu
    28: [20512, 11280], # Gagaga Điện Kích, Gagaga Em Gái
    29: [20551, 11354], # Dung Hợp Mắt Đỏ, Harpie Điều Chế
    30: [20552, 11387], # Nghi Thức Mắt Đỏ, Gishki Tà Ác Bốn Tay Ăn Thịt
    31: [40265, 11424], # Nhập Ma Long Tổ·Ophion, Người Cầm Trượng Song Xà Nhập Ma
    32: [20233, 11463]  # Cú Đấm Thần Thánh, Anh hùng nguyên tố · Gangjiaxia
}

# Thematic GR cards for character packs
CHAR_PACKAGE_GR = {
    3: [30383, 20742], # Yugi: linh hồn vĩnh cửu, Tủ vàng kín
    2: [40250, 20779], # Kaiba: Rồng bạc mắt xanh, khổng lồ
    5: [20551, 11365], # Joey: Sự kết hợp mắt đỏ, Vua Mắt Đỏ
    15: [40336, 21046], # Jaden: Tinh Vân Xinyuxia, kết hợp anh hùng
    18: [11513, 21100], # Marik: Đọa Thiên Sứ Ixchel, Sự bố thí thiên thần
    16: [20778],        # Yusei: Người thu giữ linh hồn
    8: [10407],         # Bonz: Tà Thần Thần Hóa Thân
    11: [10763]         # Pegasus: Dực Thần Long Ra
}

SERVER_LIYA_CARDS_MAP = {}
SERVER_CHAR_CARDS_MAP = {}
try:
    with open('scratch_liya_cards_map.json', 'r', encoding='utf-8') as f:
        _lm = json.load(f)
        SERVER_LIYA_CARDS_MAP = {int(k): [int(x) for x in v] for k, v in _lm.items()}
    print(f"[SERVER] Loaded {len(SERVER_LIYA_CARDS_MAP)} Liya pack mappings.")
except Exception as e:
    print(f"[SERVER] Error loading scratch_liya_cards_map.json: {e}")

try:
    with open('scratch_char_cards_map.json', 'r', encoding='utf-8') as f:
        _cm = json.load(f)
        SERVER_CHAR_CARDS_MAP = {int(k): [int(x) for x in v] for k, v in _cm.items()}
    print(f"[SERVER] Loaded {len(SERVER_CHAR_CARDS_MAP)} Character pack mappings.")
except Exception as e:
    print(f"[SERVER] Error loading scratch_char_cards_map.json: {e}")

ALL_CARDS_MAP = {}
ALL_CARDS_BY_QUALITY = {'GR': [], 'UR': [], 'SR': [], 'R': [], 'N': []}
ALL_SR_AND_BELOW_CARDS = []

def init_global_cards(cur=None):
    global ALL_CARDS_MAP, ALL_CARDS_BY_QUALITY, ALL_SR_AND_BELOW_CARDS
    def _do(cursor):
        global ALL_CARDS_MAP, ALL_CARDS_BY_QUALITY, ALL_SR_AND_BELOW_CARDS
        cursor.execute("""
            SELECT id, name, quality FROM (
                SELECT id, name, quality FROM card_monsters
                UNION ALL SELECT id, name, quality FROM card_spells
                UNION ALL SELECT id, name, quality FROM card_traps
                UNION ALL SELECT id, name, quality FROM card_extra
            ) AS all_cards
        """)
        rows = cursor.fetchall()
        ALL_CARDS_MAP.clear()
        for q in ALL_CARDS_BY_QUALITY:
            ALL_CARDS_BY_QUALITY[q].clear()
        ALL_SR_AND_BELOW_CARDS.clear()
        for r in rows:
            cid = int(r['id'])
            cname = r['name']
            cq = (r['quality'] or 'N').upper()
            cobj = {'id': cid, 'name': cname, 'quality': cq}
            ALL_CARDS_MAP[cid] = cobj
            if cq in ALL_CARDS_BY_QUALITY:
                ALL_CARDS_BY_QUALITY[cq].append(cobj)
            else:
                ALL_CARDS_BY_QUALITY['N'].append(cobj)
            if cq in ('SR', 'R', 'N'):
                ALL_SR_AND_BELOW_CARDS.append(cobj)
        print(f"[SERVER] Loaded {len(ALL_CARDS_MAP)} total cards into memory cache (GR: {len(ALL_CARDS_BY_QUALITY['GR'])}, UR: {len(ALL_CARDS_BY_QUALITY['UR'])}, SR: {len(ALL_CARDS_BY_QUALITY['SR'])}, R: {len(ALL_CARDS_BY_QUALITY['R'])}, N: {len(ALL_CARDS_BY_QUALITY['N'])}).")

    try:
        if cur:
            _do(cur)
        else:
            with get_db() as conn:
                with conn.cursor() as c:
                    _do(c)
    except Exception as e:
        print(f"[SERVER] Error loading global cards into memory: {e}")

try:
    init_global_cards()
except Exception as e:
    print(f"[SERVER] init_global_cards at startup failed: {e}")



SERVERS = [
    {
        "id": 1,
        "name": 'S1 - Yugihlor - trading "Nạp" game',
        "host": "127.0.0.1:9191",
        "status": 1,
        "is_new": 1,
        "is_recommend": 1
    },
    {
        "id": 2,
        "name": "S2 - Đấu Trường Hải Mã",
        "host": "127.0.0.1:9191",
        "status": 1,
        "is_new": 1,
        "is_recommend": 0
    }
]

# Database functions
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
                acc_clean['character_id'] = acc_clean.get('character_id', 3) or 3
                acc_clean['avatar'] = acc_clean.get('avatar', 301) or 301
                acc_clean['gold_cup'] = acc_clean.get('gold_cup', 0) or 0
                acc_clean['silver_cup'] = acc_clean.get('silver_cup', 0) or 0
                acc_clean['bronze_cup'] = acc_clean.get('bronze_cup', 0) or 0
                if acc_clean.get('last_login'): acc_clean['last_login'] = str(acc_clean['last_login'])
                if acc_clean.get('created_at'): acc_clean['created_at'] = str(acc_clean['created_at'])
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
                INSERT INTO accounts (username, password, character_name, server, gold, gem, void_stone, purple_ticket, leya_ticket, level, exp, vip_level, trophy, character_id, avatar, gold_cup, silver_cup, bronze_cup)
                VALUES (%s, %s, %s, 'S1 - Quyết Chiến Chi Thành', 500000, 50000, 1000, 50, 50, 1, 0, 1, 800, 3, 301, 0, 0, 0)
            """, (username, hashed, character_name))
            acc_id = cur.lastrowid
            
            # Grant starter package: 20 monsters, 10 spells, 10 traps, 15 extra deck cards (non-GR)
            cur.execute("SELECT id FROM card_monsters WHERE quality != 'GR' ORDER BY RAND() LIMIT 20")
            monster_ids = [r['id'] if isinstance(r, dict) else r[0] for r in cur.fetchall()]

            cur.execute("SELECT id FROM card_spells WHERE quality != 'GR' ORDER BY RAND() LIMIT 10")
            spell_ids = [r['id'] if isinstance(r, dict) else r[0] for r in cur.fetchall()]

            cur.execute("SELECT id FROM card_traps WHERE quality != 'GR' ORDER BY RAND() LIMIT 10")
            trap_ids = [r['id'] if isinstance(r, dict) else r[0] for r in cur.fetchall()]

            cur.execute("SELECT id FROM card_extra WHERE quality != 'GR' ORDER BY RAND() LIMIT 15")
            extra_ids = [r['id'] if isinstance(r, dict) else r[0] for r in cur.fetchall()]

            main_deck = monster_ids + spell_ids + trap_ids
            starter_cards = [(acc_id, cid, 1) for cid in (main_deck + extra_ids)]
            cur.executemany("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, %s, %s)", starter_cards)

            # Grant starter decks 1, 2, 3 so player can immediately duel and dark troop check passes
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
            if acc_clean.get('last_login'): acc_clean['last_login'] = str(acc_clean['last_login'])
            if acc_clean.get('created_at'): acc_clean['created_at'] = str(acc_clean['created_at'])
            return acc_clean, "Đăng ký thành công!"

_playerLevelupExp = [
    0, 100, 250, 450, 700, 1000, 1350, 1750, 2200, 2700,
    3250, 3900, 4650, 5500, 6450, 7500, 9060, 10820, 12770, 14920,
    17290, 19900, 22760, 25880, 29280, 33000, 37060, 41480, 46280, 51480,
    57100, 63160, 69680, 76680, 84180, 92200, 100760, 109880, 119580, 129880,
    140800, 152360, 164580, 177480, 191080, 205400, 220460, 236280, 252880, 270280
]

def calc_level(exp):
    lvl = 1
    for i, req in enumerate(_playerLevelupExp):
        if exp >= req:
            lvl = i + 1
        else:
            break
    return max(1, min(lvl, len(_playerLevelupExp)))

def get_player_full_data(account_id):
    with get_db() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM accounts WHERE id = %s", (account_id,))
            acc = cur.fetchone()
            if not acc: return None
            
            acc_clean = dict(acc)
            acc_clean.pop('password', None)
            acc_clean['trophy'] = acc['trophy'] if acc.get('trophy') is not None else 800
            if acc_clean.get('last_login'): acc_clean['last_login'] = str(acc_clean['last_login'])
            if acc_clean.get('created_at'): acc_clean['created_at'] = str(acc_clean['created_at'])
            
            # Check / seed user_levels (difficulties 1..4)
            cur.execute("SELECT difficulty, cur_level, max_level FROM user_levels WHERE account_id = %s ORDER BY difficulty", (account_id,))
            levels_raw = cur.fetchall()
            if not levels_raw:
                default_levels = [(1, 10101, 10101), (2, 20101, 20101), (3, 30101, 30101), (4, 40101, 40101)]
                for diff, cur_lvl, max_lvl in default_levels:
                    cur.execute("INSERT IGNORE INTO user_levels (account_id, difficulty, cur_level, max_level) VALUES (%s, %s, %s, %s)",
                                (account_id, diff, cur_lvl, max_lvl))
                levels_raw = [{'difficulty': d[0], 'cur_level': d[1], 'max_level': d[2]} for d in default_levels]
            cur_levels = [d['cur_level'] for d in levels_raw]

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
            
            cur.execute("SELECT checkin_type, day_index, claim_date FROM user_checkin WHERE account_id = %s", (account_id,))
            checkins = [{"checkin_type": r['checkin_type'], "day_index": r['day_index'], "claim_date": str(r['claim_date'])} for r in cur.fetchall()]
            cur.execute("SELECT achieve_id, progress, is_claimed FROM user_achievements WHERE account_id = %s", (account_id,))
            achievements = [{"id": r['achieve_id'], "progress": r['progress'], "is_claimed": r['is_claimed']} for r in cur.fetchall()]
            cur.execute("SELECT id, character_name, level, trophy, vip_level, character_id, avatar, gold_cup, silver_cup, bronze_cup FROM accounts ORDER BY trophy DESC, level DESC, id ASC LIMIT 10")
            top_rows = cur.fetchall()
            leaderboard = [
                {
                    "rank": idx + 1,
                    "id": r['id'],
                    "name": r['character_name'] or f"Duelist_{r['id']}",
                    "avatar": r.get('avatar', 301) or 301,
                    "character_id": r.get('character_id', 3) or 3,
                    "level": r.get('level', 1) or 1,
                    "trophy": r.get('trophy', 800) if r.get('trophy') is not None else 800,
                    "vip": r.get('vip_level', 0) or 0,
                    "gold_cup": r.get('gold_cup', 0) or 0,
                    "silver_cup": r.get('silver_cup', 0) or 0,
                    "bronze_cup": r.get('bronze_cup', 0) or 0
                }
                for idx, r in enumerate(top_rows)
            ]
            sign_in_days = max(1, len(checkins))
            return {
                "account": acc_clean,
                "cards": cards,
                "decks": decks,
                "cur_levels": cur_levels,
                "checkins": checkins,
                "achievements": achievements,
                "sign_in_days": sign_in_days,
                "leaderboard": leaderboard
            }

def ensure_deck_cards(acc_id, raw_cards=None, raw_extra=None):
    cards = []
    extra = []
    if isinstance(raw_cards, dict):
        try:
            cards = [int(v) for k, v in sorted(raw_cards.items(), key=lambda x: int(x[0])) if int(v) > 0]
        except:
            cards = [int(v) for v in raw_cards.values() if int(v) > 0]
    elif isinstance(raw_cards, list):
        for c in raw_cards:
            try:
                cid = int(c.get('info_id') if isinstance(c, dict) else c)
                if cid > 0:
                    cards.append(cid)
            except:
                pass

    if isinstance(raw_extra, dict):
        try:
            extra = [int(v) for k, v in sorted(raw_extra.items(), key=lambda x: int(x[0])) if int(v) > 0]
        except:
            extra = [int(v) for v in raw_extra.values() if int(v) > 0]
    elif isinstance(raw_extra, list):
        for c in raw_extra:
            try:
                cid = int(c.get('info_id') if isinstance(c, dict) else c)
                if cid > 0:
                    extra.append(cid)
            except:
                pass

    if len(cards) < 40 and acc_id:
        try:
            with get_db() as conn:
                with conn.cursor() as cur:
                    cur.execute("SELECT cards, extra_cards FROM user_decks WHERE account_id = %s ORDER BY is_active DESC, deck_slot ASC LIMIT 1", (acc_id,))
                    drow = cur.fetchone()
                    if drow and drow.get('cards'):
                        db_cards = json.loads(drow['cards'])
                        if db_cards and len(db_cards) >= 40:
                            cards = [int(c) for c in db_cards]
                        elif db_cards and len(db_cards) > len(cards):
                            cards = [int(c) for c in db_cards]
                        if not extra and drow.get('extra_cards'):
                            extra = [int(c) for c in json.loads(drow['extra_cards'])]
        except Exception as e:
            print(f"[ENSURE DECK DB ERR] {e}")

    starter_pool = [
        10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010,
        10011, 10012, 10013, 10014, 10015, 10016, 10017, 10018, 10019, 10020,
        20001, 20002, 20003, 20004, 20005, 20006, 20007, 20008, 30001, 30002,
        30003, 30004, 30005, 10130, 10549, 10513, 11015, 11189, 11781, 12184
    ]
    idx = 0
    while len(cards) < 40:
        cards.append(starter_pool[idx % len(starter_pool)])
        idx += 1

    return cards, extra

# Custom MIME types
mimetypes.add_type('application/wasm', '.wasm')
mimetypes.add_type('application/json', '.json')
mimetypes.add_type('text/plain', '.lan')
mimetypes.add_type('text/xml', '.plist')
mimetypes.add_type('text/plain', '.fnt')
mimetypes.add_type('application/octet-stream', '.sfb')
mimetypes.add_type('application/octet-stream', '.jpm')
mimetypes.add_type('application/octet-stream', '.ccz')


COMPRESSIBLE_EXTS = {'.json', '.js', '.css', '.html', '.svg', '.txt', '.fnt', '.atlas'}
IMMUTABLE_STATIC_EXTS = {
    '.png', '.jpg', '.jpeg', '.pvr', '.ccz', '.sfb', '.lcres',
    '.mp3', '.ogg', '.wav', '.zip', '.gz', '.woff', '.woff2', '.ttf',
    '.jpm', '.bin', '.plist', '.fsh', '.wasm'
}

GZIP_CACHE = {} # path -> (mtime, compressed_bytes)

def get_gzipped_file(full_path):
    try:
        st = os.stat(full_path)
        mtime = st.st_mtime
        if full_path in GZIP_CACHE:
            cached_mtime, cached_bytes = GZIP_CACHE[full_path]
            if cached_mtime == mtime:
                return cached_bytes
        with open(full_path, 'rb') as f:
            raw = f.read()
        if len(raw) > 256:
            compressed = gzip.compress(raw, compresslevel=6)
        else:
            compressed = None
        GZIP_CACHE[full_path] = (mtime, compressed)
        return compressed
    except Exception as e:
        return None

def preload_static_cache():
    preload_list = ['lua_src.json', 'res_manifest.json', 'data_dumps.json']
    for rel in preload_list:
        p = os.path.join(WEB_DIR, rel)
        if os.path.isfile(p):
            t0 = time.time()
            gz = get_gzipped_file(p)
            dt = time.time() - t0
            raw_sz = os.path.getsize(p)
            gz_sz = len(gz) if gz else 0
            print(f"[CACHE PRELOAD] {rel}: {raw_sz//1024}KB -> {gz_sz//1024}KB (gzip) in {dt:.2f}s")


class WebAppHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=WEB_DIR, **kwargs)
    
    def log_message(self, format, *args):
        msg = format % args
        if '/api/' in msg:
            print(f"[API] {msg}")

    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type, Range')
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()

    def _send_json(self, data, code=200):
        out = json.dumps(data, ensure_ascii=False).encode('utf-8')
        self.send_response(code)
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.send_header('Content-Length', str(len(out)))
        self.end_headers()
        self.wfile.write(out)

    def _proxy_websocket(self):
        try:
            backend = socket.create_connection(('127.0.0.1', WS_PORT), timeout=5)
        except Exception as e:
            print(f"[WS PROXY ERR] Failed to connect to backend WS port {WS_PORT}: {e}")
            self.send_error(502, f"WebSocket backend unavailable: {e}")
            return

        try:
            req_line = f"{self.command} {self.path} {self.request_version}\r\n"
            backend.sendall(req_line.encode('latin1'))
            for k, v in self.headers.items():
                backend.sendall(f"{k}: {v}\r\n".encode('latin1'))
            backend.sendall(b"\r\n")

            try:
                buf = getattr(self.rfile, '_rbuf', None)
                if buf:
                    backend.sendall(buf.getvalue() if hasattr(buf, 'getvalue') else bytes(buf))
            except:
                pass

            client_sock = self.connection
            backend.settimeout(None)
            client_sock.settimeout(None)

            def pipe(src, dst):
                try:
                    while True:
                        data = src.recv(65536)
                        if not data:
                            break
                        dst.sendall(data)
                except:
                    pass
                finally:
                    try:
                        dst.shutdown(socket.SHUT_WR)
                    except:
                        pass

            t1 = threading.Thread(target=pipe, args=(client_sock, backend), daemon=True)
            t2 = threading.Thread(target=pipe, args=(backend, client_sock), daemon=True)
            t1.start()
            t2.start()
            t1.join()
            t2.join()
        except Exception as e:
            print(f"[WS PROXY PIPE ERR] {e}")
        finally:
            try:
                backend.close()
            except:
                pass
            self.close_connection = True

    def do_GET(self):
        if not (self.path.startswith('/res/') or self.path.startswith('/src/') or self.path.endswith('.png') or self.path.endswith('.jpg') or self.path.endswith('.js')):
            print(f"[HTTP GET REQUEST] {self.path}")

        if self.path.startswith('/ws') or self.headers.get('Upgrade', '').lower() == 'websocket':
            self._proxy_websocket()
            return
        if self.path.startswith('/api/chat_history'):
            today_msgs = db_get_today_chat_history()
            self._send_json({"code": 200, "messages": today_msgs})
            return

        if self.path.startswith('/init.php'):
            init_payload = b"/+ef/oBxDaXQ7xa3bMZHL3d/VgUdFDABLkH8XWTfCxTjvTwSNfH+3Plqk6V/XdRSYix69rxuq7JlWUgDW7jOtgWTiVN6dHMTWFlK0VHREmXdHRtUD1M7XGhGHy0zzXxikkil+vqQoe+XqQqf+eMjx6i9/a5Ul0APesLjxBkZQl3aDIIueB6L7ez9rLtnWaHI2pA4rM52gck6Q62iqDQR2boUMdJxnDPQ3SWdtbosId1hre9uwC5y1vnnKVJ5Fr2D7hW4Mygswocxj1iIk38ndhcB2eW7tOtVgZ1aFBprSN9Qq5hJO5OXqypHkzkFEd9Jqpj4SJDw+eP+ZqTwCnrdQKB14xTTD5ar6vx5hqK3mhU7RQ8Jyy6vrVEwP1gF+HgsGYT+BaVLGYNLfSo03UpckdqQOKzOdoHJOkOtoqg0Edm6FDHScZwz0N0lnbW6LCHdklT90TaN5OEAOzVmLhgoeGikNtyTTADwg2rL1kmHrnCDgTgkoppHfUjQ9/QqEIWQrI4PTGD0Vs4O0tkatOu3wKqY+EiQ8Pnj/mak8Ap63UCgdeMU0w+Wq+r8eYait5oVBG/St9JIlOJd01Oc2a+vcjman7tiZhmFiW153Bv6Jk9dhrty7Q93boHPyCd/yYVMFFSlkUIsLT1C+zhxRudL43LrNKG6ixCBkYKamf4ZM+JujOZi3F0ceCH6Fa2cySjJKD4MeS/bvzrbg+sb67i7/ifnxlvrBNyaslHiMaUc9tpujOZi3F0ceCH6Fa2cySjJwMIRYwlJNs2SmofTqZ0xO4nusWZJl+1nUcF5tN6BtoFuAzVrDRBpV40JEkNcyjr"
            self.send_response(200)
            self.send_header('Content-Type', 'text/html; charset=utf-8')
            self.send_header('Content-Length', str(len(init_payload)))
            self.end_headers()
            self.wfile.write(init_payload)
            return

        if self.path.startswith('/verify_sid') or self.path.startswith('/auth'):
            sid_payload = b"0,2,local_token_dev,0,https://yugihlor.online/verify_sid,0"
            self.send_response(200)
            self.send_header('Content-Type', 'text/plain; charset=utf-8')
            self.send_header('Content-Length', str(len(sid_payload)))
            self.end_headers()
            self.wfile.write(sid_payload)
            return

        if self.path.startswith('/upd'):
            if self.path.endswith('assets/md5') or 'md5' in self.path:
                md5_path = r"D:\yugitauapk\extracted\1.0.7\md5" if os.path.exists(r"D:\yugitauapk\extracted\1.0.7\md5") else None
                # or read from QuyetChienChiThanh_base_sign_1.apk
                if not md5_path or not os.path.exists(md5_path):
                    import zipfile
                    with zipfile.ZipFile(r"D:\yugitauapk\QuyetChienChiThanh_base_sign_1.apk") as z:
                        md5_bytes = z.read("assets/md5")
                else:
                    with open(md5_path, 'rb') as f:
                        md5_bytes = f.read()
                self.send_response(200)
                self.send_header('Content-Type', 'application/octet-stream')
                self.send_header('Content-Length', str(len(md5_bytes)))
                self.end_headers()
                self.wfile.write(md5_bytes)
                print(f"[UPD SERVER] Served assets/md5 ({len(md5_bytes)} bytes)")
                return

            upd_payload = b"1.0.0.446,http://10.0.2.2:8080/upd/,0,0,http://10.0.2.2:8080/upd/,0,0,0,0"
            self.send_response(200)
            self.send_header('Content-Type', 'text/plain; charset=utf-8')
            self.send_header('Content-Length', str(len(upd_payload)))
            self.end_headers()
            self.wfile.write(upd_payload)
            print(f"[UPD SERVER] Responded to {self.path} with {upd_payload.decode()}")
            return

        clean_path = self.path.split('?')[0].split('#')[0]
        if clean_path == '/' or clean_path == '':
            clean_path = '/index.html'
        rel_path = clean_path.lstrip('/')
        full_path = os.path.normpath(os.path.join(WEB_DIR, rel_path))

        if full_path.startswith(WEB_DIR) and os.path.isfile(full_path):
            try:
                st = os.stat(full_path)
                mtime = int(st.st_mtime)
                size = st.st_size
                etag = f'"{mtime}-{size}"'
                _, ext = os.path.splitext(clean_path)
                ext_lower = ext.lower()

                # Determine caching policy
                is_immutable = ext_lower in IMMUTABLE_STATIC_EXTS
                is_versioned = ('?v=' in self.path or '&v=' in self.path)
                is_nocache = (clean_path == '/index.html' or clean_path.endswith('.html'))

                # ETag / 304 conditional request check
                if_none_match = self.headers.get('If-None-Match')
                if if_none_match and if_none_match == etag:
                    self.send_response(304)
                    if is_immutable:
                        self.send_header('Cache-Control', 'public, max-age=31536000, immutable')
                    elif is_versioned:
                        self.send_header('Cache-Control', 'public, max-age=86400, stale-while-revalidate=3600')
                    elif is_nocache:
                        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
                    self.send_header('ETag', etag)
                    self.end_headers()
                    return

                accept_enc = self.headers.get('Accept-Encoding', '')
                can_gzip = ('gzip' in accept_enc.lower()) and (ext_lower in COMPRESSIBLE_EXTS)

                ctype = mimetypes.guess_type(full_path)[0] or 'application/octet-stream'
                if ext_lower in ('.lcres', '.pvr', '.sfb'):
                    ctype = 'application/octet-stream'

                if can_gzip:
                    gz_data = get_gzipped_file(full_path)
                    if gz_data is not None:
                        self.send_response(200)
                        self.send_header('Content-Type', ctype)
                        self.send_header('Content-Encoding', 'gzip')
                        self.send_header('Content-Length', str(len(gz_data)))
                        self.send_header('ETag', etag)
                        if is_immutable:
                            self.send_header('Cache-Control', 'public, max-age=31536000, immutable')
                        elif is_versioned:
                            self.send_header('Cache-Control', 'public, max-age=86400, stale-while-revalidate=3600')
                        elif is_nocache:
                            self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
                            self.send_header('Pragma', 'no-cache')
                            self.send_header('Expires', '0')
                        self.end_headers()
                        self.wfile.write(gz_data)
                        return

                # Send raw uncompressed file (images, sounds, pre-packed assets)
                self.send_response(200)
                self.send_header('Content-Type', ctype)
                self.send_header('Content-Length', str(size))
                self.send_header('ETag', etag)
                if is_immutable:
                    self.send_header('Cache-Control', 'public, max-age=31536000, immutable')
                elif is_versioned:
                    self.send_header('Cache-Control', 'public, max-age=86400, stale-while-revalidate=3600')
                elif is_nocache:
                    self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
                    self.send_header('Pragma', 'no-cache')
                    self.send_header('Expires', '0')
                self.end_headers()

                with open(full_path, 'rb') as f:
                    while True:
                        buf = f.read(65536)
                        if not buf:
                            break
                        self.wfile.write(buf)
                return
            except Exception as e:
                pass

        if self.path in ('/api/online_count', '/api/online_count/'):
            resp = json.dumps({"code": 200, "count": get_online_player_count()}).encode('utf-8')
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Content-Length', str(len(resp)))
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(resp)
            return

        super().do_GET()

    def do_POST(self):
        if self.path.startswith('/api/'):
            content_len = int(self.headers.get('Content-Length', 0))
            body = self.rfile.read(content_len).decode('utf-8')
            try:
                req = json.loads(body) if body else {}
            except:
                req = {}
            
            resp = {}
            if self.path == '/api/auth/login':
                u = req.get('username', '')
                p = req.get('password', '')
                acc, msg = authenticate_account(u, p)
                if acc:
                    resp = {"code": 0, "msg": "Đăng nhập thành công!", "accountid": str(acc['id']), "sessionid": f"sess_{acc['id']}"}
                    print(f"[AUTH LOGIN OK] Account: {acc['username']} ({acc['character_name']})")
                else:
                    resp = {"code": 1, "msg": msg}
                    print(f"[AUTH LOGIN FAIL] User '{u}': {msg}")

            elif self.path == '/api/auth/register':
                u = req.get('username', '')
                p = req.get('password', '')
                acc, msg = register_account(u, p)
                if acc:
                    resp = {"code": 0, "msg": "Đăng ký thành công!", "accountid": str(acc['id']), "sessionid": f"sess_{acc['id']}"}
                    print(f"[AUTH REGISTER OK] New user: {acc['username']}")
                else:
                    resp = {"code": 1, "msg": msg}
                    print(f"[AUTH REGISTER FAIL] User '{u}': {msg}")

            elif self.path == '/api/login':
                u = req.get('username', '')
                p = req.get('password', '')
                acc, msg = authenticate_account(u, p)
                if acc:
                    resp = {"code": 200, "msg": msg, "account": acc, "servers": SERVERS}
                    print(f"[LOGIN OK] Account: {acc['username']} ({acc['character_name']}) - Lv {acc['level']}")
                else:
                    resp = {"code": 401, "msg": msg}
                    print(f"[LOGIN FAIL] User '{u}': {msg}")

            elif self.path == '/api/register':
                u = req.get('username', '')
                p = req.get('password', '')
                c = req.get('character_name', '')
                acc, msg = register_account(u, p, c)
                if acc:
                    resp = {"code": 200, "msg": msg, "account": acc, "servers": SERVERS}
                    print(f"[REGISTER OK] New user: {acc['username']} ({acc['character_name']})")
                else:
                    resp = {"code": 400, "msg": msg}
                    print(f"[REGISTER FAIL] User '{u}': {msg}")

            elif self.path in ('/api/online_count', '/api/online_count/'):
                resp = {"code": 200, "count": get_online_player_count()}

            elif self.path == '/api/get_servers':
                resp = {"code": 200, "servers": SERVERS}

            elif self.path in ('/api/admin/distribute_daily_rewards', '/api/trigger_daily_rewards'):
                try:
                    now = datetime.datetime.now()
                    today_str = now.strftime('%Y-%m-%d')
                    set_last_awarded_date(today_str)
                    distribute_daily_leaderboard_rewards()
                    resp = {"code": 200, "msg": "Đã phát thưởng Cup Top 1,2,3, tặng vàng Rank x 100 và reset rank về 800 thành công!"}
                except Exception as ex:
                    resp = {"code": 500, "msg": str(ex)}

            elif self.path == '/api/enter_game':
                acc_id = req.get('account_id')
                srv_id = req.get('server_id', 1)
                data = get_player_full_data(acc_id)
                if data:
                    resp = {"code": 200, "msg": "OK", "data": data}
                    acc = data['account']
                    print(f"[ENTER GAME] {acc['character_name']} entered S{srv_id}. Loaded {len(data['cards'])} cards, {len(data['decks'])} decks.")
                else:
                    resp = {"code": 404, "msg": "Không tìm thấy dữ liệu người chơi!"}

            elif self.path == '/api/save_deck':
                acc_id = req.get('account_id')
                d_slot = req.get('deck_slot', 1)
                d_name = req.get('deck_name', 'Deck')
                raw_cards = req.get('cards', [])
                raw_extra = req.get('extra_cards', [])
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("SELECT card_id, count FROM user_cards WHERE account_id = %s", (acc_id,))
                        owned_counts = {r['card_id']: r['count'] for r in cur.fetchall()}

                        clean_cards = []
                        clean_extra = []
                        remaining_counts = dict(owned_counts)

                        for c in (raw_cards or []):
                            try: cid = int(c)
                            except: continue
                            if cid in remaining_counts and remaining_counts[cid] > 0:
                                clean_cards.append(cid)
                                remaining_counts[cid] -= 1

                        for c in (raw_extra or []):
                            try: cid = int(c)
                            except: continue
                            if cid in remaining_counts and remaining_counts[cid] > 0:
                                clean_extra.append(cid)
                                remaining_counts[cid] -= 1

                        cur.execute("""
                            INSERT INTO user_decks (account_id, deck_slot, deck_name, cards, extra_cards, is_active)
                            VALUES (%s, %s, %s, %s, %s, 1)
                            ON DUPLICATE KEY UPDATE deck_name = VALUES(deck_name), cards = VALUES(cards), extra_cards = VALUES(extra_cards)
                        """, (acc_id, d_slot, d_name, json.dumps(clean_cards), json.dumps(clean_extra)))
                resp = {"code": 200, "msg": "Lưu deck thành công!"}
                print(f"[SAVE DECK] Saved deck '{d_name}' for account {acc_id} ({len(clean_cards)} cards, {len(clean_extra)} extra).")

            elif self.path == '/api/sync_currency':
                acc_id = req.get('account_id')
                currency = req.get('currency_type', 'gold')
                delta = int(req.get('delta', 0))
                action = req.get('action', 'sync')
                with get_db() as conn:
                    with conn.cursor() as cur:
                        if currency == 'gem':
                            cur.execute("UPDATE accounts SET gem = GREATEST(0, gem + %s) WHERE id = %s", (delta, acc_id))
                        else:
                            cur.execute("UPDATE accounts SET gold = GREATEST(0, gold + %s) WHERE id = %s", (delta, acc_id))
                        cur.execute("SELECT gold, gem FROM accounts WHERE id = %s", (acc_id,))
                        row = cur.fetchone() or {'gold': 0, 'gem': 0}
                resp = {"code": 200, "msg": "OK", "gold": row['gold'], "gem": row['gem']}
                print(f"[CURRENCY SYNC] Account {acc_id}: {currency} delta {delta} -> gold={row['gold']}, gem={row['gem']} ({action})")

            elif self.path == '/api/buy_package':
                acc_id = req.get('account_id')
                cost_type = req.get('cost_type', 'gold')
                raw_count = int(req.get('count', 1))
                package_id = req.get('package_id', 1)
                pkg_num = int(package_id) if str(package_id).isdigit() else 0
                if raw_count > 1000:
                    packs = raw_count % 100
                    total_cards = packs * 3
                elif raw_count in (1, 10, 50):
                    packs = raw_count
                    total_cards = raw_count * 3
                else:
                    total_cards = raw_count
                    packs = max(1, total_cards // 3)
                if total_cards <= 0: total_cards = 3
                
                is_liya_pkg = (101001 <= pkg_num <= 135050) or (1 <= pkg_num <= 32 and pkg_num in SERVER_LIYA_CARDS_MAP)
                cost_val = int(req.get('cost_val', 0))
                if cost_val <= 0:
                    if is_liya_pkg:
                        cost_val = (28500 if packs >= 50 else (6000 if packs >= 10 else 600 * packs))
                    else:
                        cost_val = (22500 if packs >= 50 else (4500 if packs >= 10 else 500 * packs))
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("SELECT gold, gem, pity_count, character_name FROM accounts WHERE id = %s", (acc_id,))
                        user_acc = cur.fetchone()
                        if not user_acc:
                            resp = {"code": 404, "msg": "Account not found"}
                        else:
                            current_val = user_acc['gem'] if cost_type == 'gem' else user_acc['gold']
                            if current_val < cost_val:
                                resp = {"code": 400, "msg": "Không đủ tiền!"}
                            else:
                                if cost_type == 'gem':
                                    cur.execute("UPDATE accounts SET gem = gem - %s WHERE id = %s", (cost_val, acc_id))
                                else:
                                    cur.execute("UPDATE accounts SET gold = gold - %s WHERE id = %s", (cost_val, acc_id))
                                
                                user_pity = user_acc.get('pity_count', 0) or 0
                                cards_won = []
                                has_ur = False
                                raw_card_pool = req.get('card_pool') or []
                                req_pool = [int(x) for x in raw_card_pool if str(x).isdigit()]
                                
                                if not ALL_CARDS_MAP:
                                    init_global_cards(cur)
                                
                                # Resolve pack pool from server maps if not provided
                                if not req_pool:
                                    if 101001 <= pkg_num <= 135050:
                                        liya_idx = (pkg_num - 100000) // 1000
                                        req_pool = SERVER_LIYA_CARDS_MAP.get(liya_idx, [])
                                    elif 1 <= pkg_num <= 32 and pkg_num in SERVER_LIYA_CARDS_MAP:
                                        req_pool = SERVER_LIYA_CARDS_MAP.get(pkg_num, [])
                                    elif 10000 <= pkg_num < 20000:
                                        cid = (pkg_num - 10000) // 100
                                        req_pool = SERVER_CHAR_CARDS_MAP.get(cid, [])
                                    elif pkg_num in SERVER_CHAR_CARDS_MAP:
                                        req_pool = SERVER_CHAR_CARDS_MAP.get(pkg_num, [])
                                
                                # Featured URs and GRs of this specific pack
                                pack_ur_cards = []
                                pack_gr_cards = []
                                for cid in req_pool:
                                    c_info = ALL_CARDS_MAP.get(cid)
                                    if c_info:
                                        if c_info['quality'] == 'UR':
                                            pack_ur_cards.append(c_info)
                                        elif c_info['quality'] == 'GR':
                                            pack_gr_cards.append(c_info)
                                
                                # Fallback if pack has no URs
                                if not pack_ur_cards:
                                    pack_ur_cards = ALL_CARDS_BY_QUALITY.get('UR', [])
                                
                                # Resolve pack GR cards if not directly in req_pool
                                if not pack_gr_cards:
                                    gr_cids = []
                                    if 101001 <= pkg_num <= 135050:
                                        liya_idx = (pkg_num - 100000) // 1000
                                        gr_cids = LIYA_PACKAGE_GR.get(liya_idx, [])
                                    elif 1 <= pkg_num <= 32 and pkg_num in LIYA_PACKAGE_GR:
                                        gr_cids = LIYA_PACKAGE_GR.get(pkg_num, [])
                                    else:
                                        cid = pkg_num
                                        if 10000 <= cid < 20000:
                                            cid = (cid - 10000) // 100
                                        elif cid > 100:
                                            cid = cid % 100
                                        gr_cids = CHAR_PACKAGE_GR.get(cid, [])
                                    for gid in gr_cids:
                                        if gid in ALL_CARDS_MAP:
                                            pack_gr_cards.append(ALL_CARDS_MAP[gid])
                                    if not pack_gr_cards:
                                        pack_gr_cards = ALL_CARDS_BY_QUALITY.get('GR', [])
                                
                                for card_idx in range(total_cards):
                                    user_pity += (1.0 / 3.0)
                                    force_ur = (user_pity >= 50.0) and (not has_ur)
                                    
                                    roll = random.random()
                                    if force_ur:
                                        picked = random.choice(pack_ur_cards) if pack_ur_cards else random.choice(ALL_CARDS_BY_QUALITY['UR'])
                                    elif roll < 0.000001:  # GR: 0.0001%
                                        picked = random.choice(pack_gr_cards) if pack_gr_cards else random.choice(ALL_CARDS_BY_QUALITY['GR'])
                                    elif roll < 0.020001:  # UR: 2% from pack featured URs
                                        picked = random.choice(pack_ur_cards) if pack_ur_cards else random.choice(ALL_CARDS_BY_QUALITY['UR'])
                                    elif roll < 0.120001:  # SR: 10% from all cards in database
                                        pool_sr = ALL_CARDS_BY_QUALITY.get('SR') or ALL_SR_AND_BELOW_CARDS
                                        picked = random.choice(pool_sr)
                                    elif roll < 0.520001:  # R: 40% from all cards in database
                                        pool_r = ALL_CARDS_BY_QUALITY.get('R') or ALL_SR_AND_BELOW_CARDS
                                        picked = random.choice(pool_r)
                                    else:                  # N: remainder (~48%) from all cards in database
                                        pool_n = ALL_CARDS_BY_QUALITY.get('N') or ALL_SR_AND_BELOW_CARDS
                                        picked = random.choice(pool_n)
                                    
                                    cid = picked['id']
                                    cname = picked['name']
                                    cquality = picked['quality']
                                    
                                    if cquality in ['UR', 'GR']:
                                        user_pity = 0.0
                                        if cquality == 'UR':
                                            has_ur = True
                                        else:
                                            announcement = f"[THÔNG BÁO] Chúc mừng bài thủ [{user_acc['character_name']}] vừa rút được lá bài cấp GR thần thánh [{cname}]!"
                                            broadcast_msg = {
                                                "id": int(time.time()*1000) + card_idx,
                                                "timestamp": int(time.time()*1000),
                                                "account_id": 0,
                                                "name": "Hệ Thống",
                                                "level": 99,
                                                "avatar": 101,
                                                "content": announcement,
                                                "msg": announcement,
                                                "type": 2,
                                                "card_id": cid,
                                                "items": [{"info_id": cid, "num": 1}]
                                            }
                                            CHAT_MESSAGES.append(broadcast_msg)
                                            if len(CHAT_MESSAGES) > 100: CHAT_MESSAGES.pop(0)
                                            save_chat_history()
                                            broadcast_ws_sync({"t": "chat_broadcast", "msg": broadcast_msg})
                                            print(f"[GR DROP!] {announcement}")
                                    
                                    cards_won.append({"info_id": cid, "num": 1, "name": cname, "quality": cquality})
                                
                                # Batch save cards won
                                card_counts = {}
                                for c in cards_won:
                                    ci = c['info_id']
                                    card_counts[ci] = card_counts.get(ci, 0) + 1
                                for ci, cnt in card_counts.items():
                                    cur.execute("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE count = count + %s", (acc_id, ci, cnt, cnt))

                                
                                cur.execute("UPDATE accounts SET pity_count = %s WHERE id = %s", (int(user_pity), acc_id))
                                cur.execute("SELECT gold, gem, pity_count FROM accounts WHERE id = %s", (acc_id,))
                                updated_acc = cur.fetchone()
                                resp = {
                                    "code": 200,
                                    "msg": "Mua thành công!",
                                    "cards": cards_won,
                                    "gold": updated_acc['gold'],
                                    "gem": updated_acc['gem'],
                                    "pity_count": updated_acc['pity_count']
                                }
                                print(f"[BUY PACKAGE] Account {acc_id} ({user_acc['character_name']}) drew {total_cards} cards. Pity: {int(user_pity)}/50. Won: {[c['name'] + '(' + c['quality'] + ')' for c in cards_won]}")

            elif self.path == '/api/chat_send':
                acc_id = req.get('account_id') or req.get('sender_id') or 1
                try: acc_id = int(acc_id)
                except Exception: acc_id = 1
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
                    msg_type = int(req.get('type', 1)) # 1: world, 2: bulletin
                except Exception:
                    msg_type = 1
                card_id = int(req.get('card_id', 0))
                client_msg_id = req.get('client_msg_id')
                if content:
                    gc = int(req.get('gold_cup') or 0)
                    sc = int(req.get('silver_cup') or 0)
                    bc = int(req.get('bronze_cup') or 0)
                    if acc_id > 0 and (gc == 0 and sc == 0 and bc == 0):
                        try:
                            with get_db() as conn:
                                with conn.cursor() as cur:
                                    cur.execute("SELECT gold_cup, silver_cup, bronze_cup FROM accounts WHERE id = %s", (acc_id,))
                                    arow = cur.fetchone()
                                    if arow:
                                        gc = int(arow.get('gold_cup') or 0)
                                        sc = int(arow.get('silver_cup') or 0)
                                        bc = int(arow.get('bronze_cup') or 0)
                        except Exception:
                            pass
                    cid = int(req.get('crown_id') or (7204 if gc > 0 else (7205 if sc > 0 else (7206 if bc > 0 else 0))))
                    cnum = int(req.get('crown_num') or (gc if gc > 0 else (sc if sc > 0 else (bc if bc > 0 else 0))))
                    now_ts = int(time.time() * 1000)
                    msg_obj = {
                        "client_msg_id": client_msg_id,
                        "timestamp": now_ts,
                        "account_id": acc_id,
                        "name": name,
                        "level": level,
                        "avatar": avatar,
                        "gold_cup": gc,
                        "silver_cup": sc,
                        "bronze_cup": bc,
                        "crown_id": cid,
                        "crown_num": cnum,
                        "content": content,
                        "msg": content,
                        "type": msg_type,
                        "card_id": card_id
                    }
                    if cid > 0:
                        msg_obj['crown'] = {'info_id': cid, 'num': cnum}
                    if card_id > 0:
                        msg_obj['items'] = [{'info_id': card_id, '_infoId': card_id, 'num': 1, '_num': 1}]
                    db_id = db_save_chat_message(msg_obj)
                    msg_obj['id'] = db_id
                    broadcast_ws_sync({"t": "chat_broadcast", "msg": msg_obj})
                    resp = {"code": 200, "msg": "Sent", "data": msg_obj}
                    print(f"[CHAT DB] {name} (Lv.{level}): {content} [DB ID: {db_id}]")
                else:
                    resp = {"code": 400, "msg": "Nội dung trống!"}

            elif self.path == '/api/chat_history':
                today_msgs = db_get_today_chat_history()
                resp = {"code": 200, "messages": today_msgs}

            elif self.path == '/api/complete_level':
                acc_id = req.get('account_id')
                level_id = int(req.get('level_id', 0))
                result = int(req.get('result', 1))
                stars = int(req.get('stars', 3))
                if result == 1 and level_id > 0:
                    difficulty = max(1, min(4, level_id // 10000))
                    with get_db() as conn:
                        with conn.cursor() as cur:
                            cur.execute("SELECT cur_level, max_level FROM user_levels WHERE account_id = %s AND difficulty = %s", (acc_id, difficulty))
                            row = cur.fetchone()
                            next_lvl = get_next_level(level_id)
                            if row:
                                can_advance = False
                                cur_lvl_db = row['cur_level']
                                if cur_lvl_db not in CANONICAL_LEVELS:
                                    can_advance = True
                                elif level_id in CANONICAL_LEVELS and next_lvl in CANONICAL_LEVELS:
                                    curr_idx = CANONICAL_LEVELS.index(cur_lvl_db)
                                    next_idx = CANONICAL_LEVELS.index(next_lvl)
                                    if next_idx > curr_idx:
                                        can_advance = True
                                elif level_id >= cur_lvl_db:
                                    can_advance = True

                                if can_advance:
                                    cur.execute("UPDATE user_levels SET cur_level = %s, max_level = GREATEST(max_level, %s) WHERE account_id = %s AND difficulty = %s",
                                                (next_lvl, next_lvl, acc_id, difficulty))
                            else:
                                cur.execute("INSERT INTO user_levels (account_id, difficulty, cur_level, max_level) VALUES (%s, %s, %s, %s)",
                                            (acc_id, difficulty, next_lvl, next_lvl))
                            reward_gold = 1000
                            reward_exp = 200
                            cur.execute("UPDATE accounts SET gold = gold + %s, exp = exp + %s WHERE id = %s", (reward_gold, reward_exp, acc_id))
                            cur.execute("SELECT gold, exp, level FROM accounts WHERE id = %s", (acc_id,))
                            acc_stats = cur.fetchone()
                            new_level = calc_level(acc_stats['exp'])
                            if new_level != acc_stats['level']:
                                cur.execute("UPDATE accounts SET level = %s WHERE id = %s", (new_level, acc_id))
                    resp = {"code": 200, "msg": "Qua ải thành công!", "next_level": next_lvl, "gold": acc_stats['gold'], "exp": acc_stats['exp'], "level": new_level}
                    print(f"[COMPLETE LEVEL] Account {acc_id} won level {level_id} (Diff {difficulty}) -> unlocked level {next_lvl}, +{reward_gold} gold, +{reward_exp} exp.")
                else:
                    resp = {"code": 200, "msg": "Trận đấu kết thúc", "result": result}

            elif self.path == '/api/buy_gold':
                acc_id = req.get('account_id')
                tier = int(req.get('tier', 1))
                # Tỉ lệ đổi: 100 gem = 1000 gold (x10)
                tier_rates = {
                    1: (100, 1000),      # 100 Gem -> 1,000 Gold
                    2: (1000, 10000),    # 1,000 Gem -> 10,000 Gold
                    3: (5000, 50000)     # 5,000 Gem -> 50,000 Gold
                }
                def_gem, def_gold = tier_rates.get(tier, (100, 1000))
                gem_cost = int(req.get('gem_cost', def_gem))
                gold_gain = gem_cost * 10
                if acc_id:
                    with get_db() as conn:
                        with conn.cursor() as cur:
                            cur.execute("SELECT gold, gem FROM accounts WHERE id = %s", (acc_id,))
                            acc = cur.fetchone()
                            if not acc:
                                resp = {"code": 404, "msg": "Account not found"}
                            elif acc['gem'] < gem_cost:
                                resp = {"code": 400, "msg": "Không đủ Gem để đổi vàng!"}
                            else:
                                new_gem = acc['gem'] - gem_cost
                                new_gold = acc['gold'] + gold_gain
                                cur.execute("UPDATE accounts SET gem = %s, gold = %s WHERE id = %s", (new_gem, new_gold, acc_id))
                                resp = {
                                    "code": 200,
                                    "msg": f"Đổi thành công {gold_gain:,} Vàng!",
                                    "gold": new_gold,
                                    "gem": new_gem
                                }
                                print(f"[BUY GOLD] Account {acc_id}: -{gem_cost} Gem, +{gold_gain} Gold -> new: {new_gold} Gold, {new_gem} Gem")
                else:
                    resp = {"code": 400, "msg": "Missing account_id"}

            elif self.path == '/api/buy_depot':
                acc_id = req.get('account_id')
                card_id = int(req.get('card_id', 0))
                cost = int(req.get('cost', 0))
                depot_id = req.get('depot_id')
                if (card_id == 0 or cost == 0) and depot_id == 59:
                    card_id = 40209
                    cost = 100000
                elif card_id == 40209:
                    cost = 100000

                if not acc_id or card_id <= 0:
                    resp = {"code": 400, "msg": "Thông tin không hợp lệ!"}
                else:
                    with get_db() as conn:
                        with conn.cursor() as cur:
                            cur.execute("SELECT gold, character_name FROM accounts WHERE id = %s", (acc_id,))
                            acc = cur.fetchone()
                            if not acc:
                                resp = {"code": 404, "msg": "Account not found"}
                            elif acc['gold'] < cost:
                                resp = {"code": 400, "msg": "Không đủ vàng!"}
                            else:
                                cur.execute("UPDATE accounts SET gold = gold - %s WHERE id = %s", (cost, acc_id))
                                cur.execute("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, %s, 1) ON DUPLICATE KEY UPDATE count = count + 1", (acc_id, card_id))
                                cur.execute("SELECT gold FROM accounts WHERE id = %s", (acc_id,))
                                updated_gold = cur.fetchone()['gold']
                                resp = {
                                    "code": 200,
                                    "msg": "Mua thẻ bài thành công!",
                                    "gold": updated_gold,
                                    "card_id": card_id
                                }
                                print(f"[BUY DEPOT] Account {acc_id} ({acc['character_name']}) bought card {card_id} for {cost} gold. Remaining gold: {updated_gold}")

            elif self.path == '/api/pvp_reward':
                acc_id = req.get('account_id')
                result = int(req.get('result', 1)) # 1 = win, 2 = loss
                battle_type = req.get('battle_type', 'clash')
                is_bot_raw = req.get('is_bot', False)
                is_bot = (is_bot_raw in [True, 1, '1', 'true', 'True'])
                oppo_trophy = int(req.get('oppo_trophy', 800))
                if acc_id:
                    with get_db() as conn:
                        with conn.cursor() as cur:
                            cur.execute("SELECT gold, exp, level, trophy FROM accounts WHERE id = %s", (acc_id,))
                            acc = cur.fetchone()
                            if acc:
                                player_trophy = acc['trophy'] if acc.get('trophy') is not None else 800
                                diff = oppo_trophy - player_trophy
                                diff_step = diff // 10
                                
                                if result == 1: # Win
                                    # Real player win: 10,000 gold; Bot win: 5,000 gold
                                    delta_gold = 5000 if is_bot else 10000
                                    delta_exp = 300
                                    # Points swing between 5 and 45
                                    delta_trophy = max(5, min(45, 25 + diff_step))
                                else: # Loss
                                    delta_gold = 500
                                    delta_exp = 100
                                    delta_trophy = -max(5, min(45, 25 - diff_step))
                                
                                new_gold = acc['gold'] + delta_gold
                                new_exp = acc['exp'] + delta_exp
                                new_trophy = max(0, player_trophy + delta_trophy)
                                new_level = calc_level(new_exp)
                                
                                cur.execute("""
                                    UPDATE accounts
                                    SET gold = %s, exp = %s, level = %s, trophy = %s
                                    WHERE id = %s
                                """, (new_gold, new_exp, new_level, new_trophy, acc_id))
                                
                                resp = {
                                    "code": 200,
                                    "msg": "Cập nhật phần thưởng PvP thành công!",
                                    "gold": new_gold,
                                    "exp": new_exp,
                                    "level": new_level,
                                    "trophy": new_trophy,
                                    "delta_gold": delta_gold,
                                    "delta_trophy": delta_trophy,
                                    "is_bot": is_bot
                                }
                                print(f"[PVP REWARD] Account {acc_id} ({'BOT' if is_bot else 'PVP'}) {'WIN' if result==1 else 'LOSS'}: +{delta_gold} gold, {delta_trophy:+d} trophy (diff {diff:+d}) -> total: {new_trophy} trophy, {new_gold} gold.")
                            else:
                                resp = {"code": 404, "msg": "Account not found"}
                else:
                    resp = {"code": 400, "msg": "Missing account_id"}

            elif self.path == '/api/leaderboard':
                rank_type = int(req.get('type', 1708) or 1708)
                sub_type = int(req.get('subType', 0) or 0)
                req_acc_id = req.get('account_id') or req.get('user_id') or req.get('id')
                try:
                    if req_acc_id is not None:
                        req_acc_id = int(req_acc_id)
                except (ValueError, TypeError):
                    req_acc_id = None

                with get_db() as conn:
                    with conn.cursor() as cur:
                        if rank_type == 1714:  # PB_TYPE_RANK_CHAR_LEVEL
                            rows = []
                            if sub_type > 0:
                                cur.execute("""
                                    SELECT id, character_name, level, trophy, server, vip_level, character_id, avatar, gold_cup, silver_cup, bronze_cup, exp
                                    FROM accounts
                                    WHERE character_id = %s
                                    ORDER BY level DESC, exp DESC, id ASC
                                    LIMIT 50
                                """, (sub_type,))
                                rows = cur.fetchall()
                            if not rows:
                                cur.execute("""
                                    SELECT id, character_name, level, trophy, server, vip_level, character_id, avatar, gold_cup, silver_cup, bronze_cup, exp
                                    FROM accounts
                                    ORDER BY level DESC, exp DESC, id ASC
                                    LIMIT 50
                                """)
                                rows = cur.fetchall()
                        elif rank_type == 1723:  # PB_TYPE_RANK_DARK
                            cur.execute("""
                                SELECT id, character_name, level, trophy, server, vip_level, character_id, avatar, gold_cup, silver_cup, bronze_cup, exp
                                FROM accounts
                                ORDER BY level DESC, id ASC
                                LIMIT 50
                            """)
                            rows = cur.fetchall()
                        else:  # PB_TYPE_RANK_LADDER (1708), PB_TYPE_RANK_TROPHY (1700), PB_TYPE_RANK_LADDER_EX (1712), PB_TYPE_RANK_LEGEND (1730), etc.
                            cur.execute("""
                                SELECT id, character_name, level, trophy, server, vip_level, character_id, avatar, gold_cup, silver_cup, bronze_cup, exp
                                FROM accounts
                                ORDER BY trophy DESC, level DESC, id ASC
                                LIMIT 50
                            """)
                            rows = cur.fetchall()

                        ranks = []
                        for idx, r in enumerate(rows):
                            char_av = r.get('avatar')
                            if not char_av or char_av < 100:
                                cid = r.get('character_id') or 3
                                char_av = cid * 100 + 1
                            val = (r.get('level') or 1) if rank_type in (1714, 1723) else (r['trophy'] if r.get('trophy') is not None else 800)
                            ranks.append({
                                "rank": idx + 1,
                                "id": r['id'],
                                "name": r['character_name'] or f"Duelist_{r['id']}",
                                "level": r['level'] or 1,
                                "avatar": char_av,
                                "value": val,
                                "trophy": r['trophy'] if r.get('trophy') is not None else 800,
                                "server": r['server'] or 'S1',
                                "vip": r.get('vip_level', 0) or 0,
                                "gold_cup": r.get('gold_cup', 0) or 0,
                                "silver_cup": r.get('silver_cup', 0) or 0,
                                "bronze_cup": r.get('bronze_cup', 0) or 0
                            })

                        self_rank = None
                        if req_acc_id:
                            for r in ranks:
                                if r['id'] == req_acc_id:
                                    self_rank = dict(r)
                                    break
                            if not self_rank:
                                cur.execute("""
                                    SELECT id, character_name, level, trophy, server, vip_level, character_id, avatar, gold_cup, silver_cup, bronze_cup, exp
                                    FROM accounts WHERE id = %s
                                """, (req_acc_id,))
                                self_acc = cur.fetchone()
                                if self_acc:
                                    if rank_type in (1714, 1723):
                                        my_lvl = self_acc.get('level') or 1
                                        my_exp = self_acc.get('exp') or 0
                                        cur.execute("""
                                            SELECT COUNT(*) as higher FROM accounts
                                            WHERE level > %s OR (level = %s AND (exp > %s OR (exp = %s AND id < %s)))
                                        """, (my_lvl, my_lvl, my_exp, my_exp, self_acc['id']))
                                        my_rank = cur.fetchone()['higher'] + 1
                                        my_val = my_lvl
                                    else:
                                        my_trophy = self_acc['trophy'] if self_acc.get('trophy') is not None else 800
                                        my_lvl = self_acc.get('level') or 1
                                        cur.execute("""
                                            SELECT COUNT(*) as higher FROM accounts
                                            WHERE trophy > %s OR (trophy = %s AND (level > %s OR (level = %s AND id < %s)))
                                        """, (my_trophy, my_trophy, my_lvl, my_lvl, self_acc['id']))
                                        my_rank = cur.fetchone()['higher'] + 1
                                        my_val = my_trophy

                                    char_av = self_acc.get('avatar')
                                    if not char_av or char_av < 100:
                                        cid = self_acc.get('character_id') or 3
                                        char_av = cid * 100 + 1

                                    self_rank = {
                                        "rank": my_rank,
                                        "id": self_acc['id'],
                                        "name": self_acc['character_name'] or f"Duelist_{self_acc['id']}",
                                        "level": self_acc['level'] or 1,
                                        "avatar": char_av,
                                        "value": my_val,
                                        "trophy": self_acc['trophy'] if self_acc.get('trophy') is not None else 800,
                                        "server": self_acc.get('server') or 'S1',
                                        "vip": self_acc.get('vip_level', 0) or 0,
                                        "gold_cup": self_acc.get('gold_cup', 0) or 0,
                                        "silver_cup": self_acc.get('silver_cup', 0) or 0,
                                        "bronze_cup": self_acc.get('bronze_cup', 0) or 0
                                    }

                        resp = {"code": 200, "ranks": ranks, "self_rank": self_rank}

            elif self.path == '/api/user_visit':
                uid = req.get('user_id') or req.get('id') or 1
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("""
                            SELECT id, character_name, level, trophy, server, vip_level, character_id, avatar, gold_cup, silver_cup, bronze_cup
                            FROM accounts WHERE id = %s
                        """, (uid,))
                        user = cur.fetchone()
                        if user:
                            u_trophy = user.get('trophy', 0) or 0
                            cur.execute("SELECT COUNT(*) as higher FROM accounts WHERE trophy > %s", (u_trophy,))
                            rank = cur.fetchone()['higher'] + 1
                        else:
                            rank = 1
                if not user:
                    user = {'id': uid, 'character_name': f'Duelist_{uid}', 'level': 1, 'trophy': 800, 'character_id': 3, 'avatar': 301}
                char_av = user.get('avatar')
                if not char_av or char_av < 100:
                    cid = user.get('character_id') or 3
                    char_av = cid * 100 + 1
                # Fetch active deck cards for VisitForm inspection
                deck_cards, deck_extra = ensure_deck_cards(uid)
                from collections import Counter
                counts = Counter([int(c) for c in (deck_cards + deck_extra) if str(c).isdigit() and int(c) > 0])
                troop = [{"info_id": cid, "num": cnt} for cid, cnt in counts.items()]

                resp = {
                    "code": 200,
                    "visit": {
                        "user_info": {
                            "id": user['id'],
                            "name": user['character_name'] or f"Duelist_{user['id']}",
                            "level": user.get('level') or 1,
                            "trophy": user.get('trophy') if user.get('trophy') is not None else 800,
                            "avatar": char_av,
                            "gold": 0, "grain": 0, "ingot": 0, "exp": 0, "vip": user.get('vip_level', 0) or 0, "shield": 0,
                            "union_id": 0, "union_name": "", "union_title": 0, "union_avatar": 0, "union_tag": "",
                            "last_login": int(time.time() * 1000),
                            "rid": 10001, "privilege": 0, "month_card": 0
                        },
                        "troop": troop,
                        "pre_rank": rank,
                        "best_rank": rank,
                        "legend_trophy": user.get('trophy', 0) or 0,
                        "pre_legend_rank": rank if rank <= 100 else 0,
                        "best_legend_rank": rank if rank <= 100 else 0
                    }
                }

            elif self.path == '/api/change_nickname':
                acc_id = req.get('account_id')
                name = str(req.get('name', '')).strip()
                if not acc_id or not name:
                    resp = {"code": 400, "msg": "Tên không hợp lệ!"}
                else:
                    with get_db() as conn:
                        with conn.cursor() as cur:
                            cur.execute("UPDATE accounts SET character_name = %s WHERE id = %s", (name, acc_id))
                    resp = {"code": 200, "msg": "Đổi biệt hiệu thành công!", "character_name": name}
                    print(f"[NICKNAME] Account {acc_id} changed nickname to '{name}'.")

            elif self.path in ('/api/redeem_gift_code', '/api/gift_code', '/api/claim_gift'):
                acc_id = req.get('account_id') or req.get('user_id') or req.get('id')
                raw_code = str(req.get('code', '')).strip()
                if not acc_id or not raw_code:
                    resp = {"code": 400, "msg": "Vui lòng nhập mã quà tặng!"}
                else:
                    try:
                        acc_id = int(acc_id)
                    except (ValueError, TypeError):
                        acc_id = 0

                    if acc_id <= 0:
                        resp = {"code": 400, "msg": "Tài khoản không hợp lệ!"}
                    else:
                        with get_db() as conn:
                            with conn.cursor() as cur:
                                # 1. Check account exists
                                cur.execute("SELECT id, username, character_name, gem, gold FROM accounts WHERE id = %s", (acc_id,))
                                acc = cur.fetchone()
                                if not acc:
                                    resp = {"code": 404, "msg": "Tài khoản không tồn tại!"}
                                else:
                                    # 2. Check gift code (case-insensitive)
                                    cur.execute("""
                                        SELECT id, code, gem, gold, cards, max_uses, current_uses, per_account_limit, expires_at, is_active
                                        FROM gift_codes
                                        WHERE LOWER(code) = LOWER(%s)
                                    """, (raw_code,))
                                    gcode = cur.fetchone()
                                    if not gcode or not gcode['is_active']:
                                        resp = {"code": 404, "msg": "Mã quà tặng không tồn tại hoặc đã hết hiệu lực!"}
                                    elif gcode['expires_at'] and gcode['expires_at'] < datetime.datetime.now():
                                        resp = {"code": 400, "msg": "Mã quà tặng đã hết hạn sử dụng!"}
                                    elif gcode['max_uses'] > 0 and gcode['current_uses'] >= gcode['max_uses']:
                                        resp = {"code": 400, "msg": "Mã quà tặng đã hết số lượt nhập!"}
                                    else:
                                        # 3. Check per-account redemption limit
                                        cur.execute("""
                                            SELECT COUNT(*) as times
                                            FROM gift_code_redemptions
                                            WHERE account_id = %s AND code_id = %s
                                        """, (acc_id, gcode['id']))
                                        red_count = cur.fetchone()['times']
                                        per_limit = gcode['per_account_limit'] or 1
                                        if red_count >= per_limit:
                                            resp = {"code": 400, "msg": "Bạn đã sử dụng mã quà tặng này rồi!"}
                                        else:
                                            reward_gem = int(gcode['gem'] or 0)
                                            reward_gold = int(gcode['gold'] or 0)
                                            reward_cards = gcode.get('cards')

                                            # Update account balance
                                            cur.execute("""
                                                UPDATE accounts
                                                SET gem = gem + %s, gold = gold + %s
                                                WHERE id = %s
                                            """, (reward_gem, reward_gold, acc_id))

                                            # Record redemption
                                            cur.execute("""
                                                INSERT INTO gift_code_redemptions
                                                (code_id, code, account_id, reward_gem, reward_gold, reward_cards)
                                                VALUES (%s, %s, %s, %s, %s, %s)
                                            """, (gcode['id'], gcode['code'], acc_id, reward_gem, reward_gold, reward_cards))

                                            # Increment code uses
                                            cur.execute("""
                                                UPDATE gift_codes
                                                SET current_uses = current_uses + 1
                                                WHERE id = %s
                                            """, (gcode['id'],))
                                            conn.commit()

                                            # Fetch updated balances
                                            cur.execute("SELECT gem, gold FROM accounts WHERE id = %s", (acc_id,))
                                            updated_acc = cur.fetchone()
                                            new_gem = updated_acc['gem'] if updated_acc else acc['gem'] + reward_gem
                                            new_gold = updated_acc['gold'] if updated_acc else acc['gold'] + reward_gold

                                            # Build reward items list for client RewardPanel
                                            rewards = []
                                            if reward_gem > 0:
                                                rewards.append({
                                                    "info_id": 3,  # Data.ResType.ingot (Gem)
                                                    "num": reward_gem,
                                                    "is_fragment": False,
                                                    "level": 1
                                                })
                                            if reward_gold > 0:
                                                rewards.append({
                                                    "info_id": 1,  # Data.ResType.gold
                                                    "num": reward_gold,
                                                    "is_fragment": False,
                                                    "level": 1
                                                })

                                            if reward_gold > 0 and reward_gem > 0:
                                                reward_msg = f"Đổi quà thành công! Nhận {reward_gold:,} Vàng và {reward_gem:,} Gem!"
                                            elif reward_gold > 0:
                                                reward_msg = f"Đổi quà thành công! Nhận {reward_gold:,} Vàng!"
                                            elif reward_gem > 0:
                                                reward_msg = f"Đổi quà thành công! Nhận {reward_gem:,} Gem!"
                                            else:
                                                reward_msg = "Đổi quà thành công!"

                                            print(f"[GIFT CODE] Account {acc_id} ({acc.get('character_name')}) redeemed '{gcode['code']}': +{reward_gem} gem, +{reward_gold} gold -> new gem: {new_gem}, new gold: {new_gold}")
                                            resp = {
                                                "code": 200,
                                                "msg": reward_msg,
                                                "rewards": rewards,
                                                "new_gem": new_gem,
                                                "new_gold": new_gold
                                            }

            elif self.path == '/api/checkin':
                acc_id = req.get('account_id')
                checkin_type = int(req.get('checkin_type', 1))
                day_index = int(req.get('day_index', 1))
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("""
                            INSERT IGNORE INTO user_checkin (account_id, checkin_type, day_index, claim_date)
                            VALUES (%s, %s, %s, CURDATE())
                        """, (acc_id, checkin_type, day_index))
                        # For month checkin, ensure both normalized day (1..31) and info ID (6001..6031) exist
                        if 6001 <= day_index <= 6031:
                            cur.execute("""
                                INSERT IGNORE INTO user_checkin (account_id, checkin_type, day_index, claim_date)
                                VALUES (%s, %s, %s, CURDATE())
                            """, (acc_id, checkin_type, day_index - 6000))
                        elif 1 <= day_index <= 31:
                            cur.execute("""
                                INSERT IGNORE INTO user_checkin (account_id, checkin_type, day_index, claim_date)
                                VALUES (%s, %s, %s, CURDATE())
                            """, (acc_id, checkin_type, 6000 + day_index))
                        # For week checkin (3001..3007)
                        if 3001 <= day_index <= 3007:
                            cur.execute("""
                                INSERT IGNORE INTO user_checkin (account_id, checkin_type, day_index, claim_date)
                                VALUES (%s, %s, %s, CURDATE())
                            """, (acc_id, checkin_type, day_index - 3000))
                        elif 1 <= day_index <= 7:
                            cur.execute("""
                                INSERT IGNORE INTO user_checkin (account_id, checkin_type, day_index, claim_date)
                                VALUES (%s, %s, %s, CURDATE())
                            """, (acc_id, checkin_type, 3000 + day_index))
                resp = {"code": 200, "msg": "Điểm danh thành công!", "checkin_type": checkin_type, "day_index": day_index}
                print(f"[CHECKIN] Account {acc_id} checked in: type={checkin_type}, day={day_index}.")

            elif self.path == '/api/set_character':
                acc_id = req.get('account_id')
                char_id = int(req.get('character_id', 3))
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("UPDATE accounts SET character_id = %s WHERE id = %s", (char_id, acc_id))
                        cur.execute("SELECT id, character_name, character_id, avatar, gold_cup, silver_cup, bronze_cup, trophy FROM accounts WHERE id = %s", (acc_id,))
                        updated = cur.fetchone()
                resp = {"code": 200, "msg": "Đổi nhân vật thành công!", "character_id": char_id, "account": updated}
                print(f"[ACCOUNT] Account {acc_id} changed character to {char_id}")

            elif self.path == '/api/set_avatar':
                acc_id = req.get('account_id')
                avatar_id = int(req.get('avatar', 301))
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("UPDATE accounts SET avatar = %s WHERE id = %s", (avatar_id, acc_id))
                        cur.execute("SELECT id, character_name, character_id, avatar, gold_cup, silver_cup, bronze_cup, trophy FROM accounts WHERE id = %s", (acc_id,))
                        updated = cur.fetchone()
                resp = {"code": 200, "msg": "Đổi avatar thành công!", "avatar": avatar_id, "account": updated}
                print(f"[ACCOUNT] Account {acc_id} changed avatar to {avatar_id}")

            elif self.path == '/api/claim_achievement':
                acc_id = req.get('account_id')
                aid = int(req.get('achieve_id', 0))
                gold_reward = int(req.get('gold', 0))
                gem_reward = int(req.get('gem', 0))
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("""
                            INSERT INTO user_achievements (account_id, achieve_id, progress, is_claimed)
                            VALUES (%s, %s, 1, 1)
                            ON DUPLICATE KEY UPDATE is_claimed = 1
                        """, (acc_id, aid))
                        if gold_reward > 0 or gem_reward > 0:
                            cur.execute("UPDATE accounts SET gold = gold + %s, gem = gem + %s WHERE id = %s", (gold_reward, gem_reward, acc_id))
                        cur.execute("SELECT gold, gem FROM accounts WHERE id = %s", (acc_id,))
                        acc_data = cur.fetchone() or {'gold': 0, 'gem': 0}
                resp = {"code": 200, "msg": "Nhận thưởng thành tựu thành công!", "gold": acc_data['gold'], "gem": acc_data['gem']}
                print(f"[ACHIEVE] Account {acc_id} claimed achievement {aid}: +{gold_reward} gold, +{gem_reward} gem.")

            elif self.path == '/api/trigger_daily_rewards':
                distribute_daily_leaderboard_rewards()
                resp = {"code": 200, "msg": "Đã phát thưởng Top bảng xếp hạng ngày thành công!"}

            elif self.path == '/api/sync_achievements':
                acc_id = req.get('account_id')
                achieves = req.get('achievements', [])
                with get_db() as conn:
                    with conn.cursor() as cur:
                        for a in achieves:
                            aid = int(a.get('id', 0))
                            prog = int(a.get('progress', 0))
                            claimed = int(a.get('is_claimed', 0))
                            if aid > 0:
                                cur.execute("""
                                    INSERT INTO user_achievements (account_id, achieve_id, progress, is_claimed)
                                    VALUES (%s, %s, %s, %s)
                                    ON DUPLICATE KEY UPDATE progress = GREATEST(progress, VALUES(progress)), is_claimed = VALUES(is_claimed)
                                """, (acc_id, aid, prog, claimed))
                resp = {"code": 200, "msg": "Đồng bộ thành tựu thành công!"}
                print(f"[ACHIEVE] Synced {len(achieves)} achievements for account {acc_id}.")
            elif self.path == '/api/cancel_pvp_match':
                acc_id = req.get('account_id')
                if acc_id:
                    PVP_HTTP_WAITING.pop(acc_id, None)
                    PVP_HTTP_CANCELLED.add(acc_id)
                    PVP_HTTP_MATCHED.pop(acc_id, None)
                    print(f"[PVP MATCH] Matchmaking cancelled for account {acc_id}")
                self._send_json({"code": 200, "msg": "Matchmaking cancelled"})
                return

            elif self.path == '/api/pvp_match':
                acc_id = req.get('account_id')
                my_name = req.get('name', 'Duelist')
                my_level = int(req.get('level', 50))
                my_cards, my_extra = ensure_deck_cards(acc_id, req.get('cards', []), req.get('extra_cards', []))
                my_avatar = int(req.get('avatar', 201))

                my_trophy = 800
                my_gc, my_sc, my_bc = 0, 0, 0
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("SELECT trophy, gold_cup, silver_cup, bronze_cup FROM accounts WHERE id = %s", (acc_id,))
                        t_row = cur.fetchone()
                        if t_row:
                            if t_row.get('trophy') is not None:
                                my_trophy = int(t_row['trophy'])
                            my_gc = int(t_row.get('gold_cup', 0) or 0)
                            my_sc = int(t_row.get('silver_cup', 0) or 0)
                            my_bc = int(t_row.get('bronze_cup', 0) or 0)

                now = time.time()
                # Clean expired (> 45s)
                for k, v in list(PVP_HTTP_WAITING.items()):
                    if now - v['time'] > 45:
                        PVP_HTTP_WAITING.pop(k, None)

                if acc_id in PVP_HTTP_MATCHED:
                    resp = PVP_HTTP_MATCHED.pop(acc_id)
                else:
                    matched_oppo = None
                    candidates = []
                    for other_id, other_data in list(PVP_HTTP_WAITING.items()):
                        if other_id != acc_id and (now - other_data['time'] < 30):
                            diff = abs(my_trophy - other_data.get('trophy', 800))
                            candidates.append((diff, other_id, other_data))

                    if candidates:
                        candidates.sort(key=lambda x: x[0])
                        best_diff, other_id, other_data = candidates[0]
                        PVP_HTTP_WAITING.pop(other_id, None)
                        seed = random.randint(1, 65535)
                        match_id = f"m_{int(time.time()*1000)}_{random.randint(100, 999)}"
                        matched_oppo = {
                            "name": other_data['name'],
                            "level": other_data['level'],
                            "cards": other_data['cards'],
                            "extra_cards": other_data['extra_cards'],
                            "avatar": other_data['avatar'],
                            "gold_cup": other_data.get('gold_cup', 0),
                            "silver_cup": other_data.get('silver_cup', 0),
                            "bronze_cup": other_data.get('bronze_cup', 0),
                            "is_real_player": True
                        }
                        PVP_HTTP_MATCHED[other_id] = {
                            "code": 200,
                            "status": "matched",
                            "match_id": match_id,
                            "seed": seed,
                            "is_attacker": True,
                            "first": True,
                            "is_real_player": True,
                            "oppo_online": True,
                            "oppo": {
                                "name": my_name,
                                "level": my_level,
                                "cards": my_cards,
                                "extra_cards": my_extra,
                                "avatar": my_avatar,
                                "gold_cup": my_gc,
                                "silver_cup": my_sc,
                                "bronze_cup": my_bc,
                                "is_real_player": True
                            }
                        }
                        resp = {
                            "code": 200,
                            "status": "matched",
                            "match_id": match_id,
                            "seed": seed,
                            "is_attacker": False,
                            "first": False,
                            "is_real_player": True,
                            "oppo_online": True,
                            "oppo": matched_oppo
                        }
                        print(f"[PVP MATCH] Paired {my_name} ({my_trophy} pts) with {matched_oppo['name']} ({other_data.get('trophy', 800)} pts, rank diff: {best_diff})!")

                    if not matched_oppo:
                        # Add self to queue with trophy and cups
                        PVP_HTTP_WAITING[acc_id] = {
                            "time": now,
                            "name": my_name,
                            "level": my_level,
                            "cards": my_cards,
                            "extra_cards": my_extra,
                            "avatar": my_avatar,
                            "trophy": my_trophy,
                            "gold_cup": my_gc,
                            "silver_cup": my_sc,
                            "bronze_cup": my_bc
                        }
                        # Wait up to 45s for human
                        matched_during_wait = False
                        for _ in range(90):
                            time.sleep(0.5)
                            if acc_id in PVP_HTTP_CANCELLED:
                                PVP_HTTP_CANCELLED.discard(acc_id)
                                PVP_HTTP_WAITING.pop(acc_id, None)
                                resp = {"code": 499, "status": "cancelled", "msg": "Matchmaking cancelled by player"}
                                self._send_json(resp)
                                print(f"[PVP MATCH] Aborted wait loop for cancelled account {acc_id}")
                                return
                            if acc_id in PVP_HTTP_MATCHED:
                                resp = PVP_HTTP_MATCHED.pop(acc_id)
                                matched_during_wait = True
                                break
                        
                        if not matched_during_wait:
                            PVP_HTTP_WAITING.pop(acc_id, None)
                            with get_db() as conn:
                                with conn.cursor() as cur:
                                    cur.execute("""
                                        SELECT a.id, a.character_name, a.level, a.trophy, a.gold_cup, a.silver_cup, a.bronze_cup, ud.cards, ud.extra_cards
                                        FROM accounts a
                                        JOIN user_decks ud ON a.id = ud.account_id
                                        WHERE a.id != %s AND ud.is_active = 1
                                        ORDER BY ABS(a.trophy - %s) ASC, RAND() LIMIT 1
                                    """, (acc_id, my_trophy))
                                    real_row = cur.fetchone()
                            if real_row:
                                c_list = real_row['cards']
                                if isinstance(c_list, str):
                                    try: c_list = json.loads(c_list)
                                    except: c_list = []
                                ec_list = real_row['extra_cards']
                                if isinstance(ec_list, str):
                                    try: ec_list = json.loads(ec_list)
                                    except: ec_list = []
                                oppo_data = {
                                    "name": real_row['character_name'],
                                    "level": real_row['level'],
                                    "cards": c_list,
                                    "extra_cards": ec_list,
                                    "avatar": random.choice([101, 102, 103, 104, 105, 201, 202, 301, 302]),
                                    "gold_cup": int(real_row.get('gold_cup', 0) or 0),
                                    "silver_cup": int(real_row.get('silver_cup', 0) or 0),
                                    "bronze_cup": int(real_row.get('bronze_cup', 0) or 0),
                                    "is_real_player": True
                                }
                            else:
                                oppo_data = {
                                    "name": "Duelist_Kaiba",
                                    "level": 50,
                                    "cards": [10001]*3 + [10002]*3,
                                    "extra_cards": [40001],
                                    "avatar": 102,
                                    "is_real_player": False
                                }
                            resp = {
                                "code": 200,
                                "status": "matched",
                                "match_id": f"bot_{int(time.time()*1000)}",
                                "seed": random.randint(1, 65535),
                                "is_attacker": True,
                                "first": True,
                                "is_real_player": False,
                                "oppo_online": False,
                                "oppo": oppo_data
                            }
                            print(f"[PVP MATCH] Matched {my_name} ({my_trophy} pts) with closest deck from DB: {oppo_data['name']} (Lv.{oppo_data['level']})")



            elif self.path == '/api/create_room':
                acc_id = req.get('account_id')
                my_name = req.get('name', 'Duelist')
                my_level = int(req.get('level', 50))
                my_avatar = int(req.get('avatar', 201))
                my_cards, my_extra = ensure_deck_cards(acc_id, req.get('cards', []), req.get('extra_cards', []))
                room_type = int(req.get('room_type', 1))
                match_hp = int(req.get('hp', 8000))

                now = time.time()
                for c, r in list(CUSTOM_PVP_ROOMS.items()):
                    if now - r.get('last_activity', r.get('created_at', now)) > 1800:
                        CUSTOM_PVP_ROOMS.pop(c, None)

                for _ in range(100):
                    code = str(random.randint(100000, 499999))
                    if code not in CUSTOM_PVP_ROOMS:
                        break

                acc_gc, acc_sc, acc_bc, acc_trophy = 0, 0, 0, 800
                try:
                    with get_db() as conn:
                        with conn.cursor() as cur:
                            cur.execute("SELECT gold_cup, silver_cup, bronze_cup, trophy FROM accounts WHERE id = %s", (acc_id,))
                            row = cur.fetchone()
                            if row:
                                acc_gc = int(row.get('gold_cup', 0) or 0)
                                acc_sc = int(row.get('silver_cup', 0) or 0)
                                acc_bc = int(row.get('bronze_cup', 0) or 0)
                                acc_trophy = int(row.get('trophy', 800) or 800)
                except Exception as e:
                    print(f"[ROOM DB ERR] {e}")

                creator_user = {
                    "id": acc_id,
                    "name": my_name,
                    "level": my_level,
                    "avatar": my_avatar,
                    "gold": 100000,
                    "ingot": 10000,
                    "trophy": acc_trophy,
                    "win": 0,
                    "is_online": True,
                    "gold_cup": acc_gc,
                    "silver_cup": acc_sc,
                    "bronze_cup": acc_bc,
                    "cards": my_cards,
                    "extra_cards": my_extra
                }

                CUSTOM_PVP_ROOMS[code] = {
                    "id": int(code),
                    "code": code,
                    "type": room_type,
                    "match_hp": match_hp,
                    "creator_id": acc_id,
                    "creator": creator_user,
                    "status": "waiting",
                    "created_at": time.time(),
                    "last_activity": time.time(),
                    "slot_host": 1,
                    "playerO": creator_user,
                    "playerA": None,
                    "playerB": None,
                    "match_id": None,
                    "seed": None
                }
                print(f"[CUSTOM ROOM] Created room {code} by {my_name} (acc {acc_id})")
                resp = {"code": 200, "room": CUSTOM_PVP_ROOMS[code]}

            elif self.path == '/api/toggle_room_slot':
                code = str(req.get('room_id', ''))
                acc_id = req.get('account_id')
                room = CUSTOM_PVP_ROOMS.get(code)
                if not room:
                    resp = {"code": 404, "msg": "Phòng không tồn tại!"}
                else:
                    room['last_activity'] = time.time()
                    if room['creator_id'] == acc_id:
                        if room.get('slot_host') == 1:
                            if room['playerA'] is None or room['playerA']['id'] == acc_id:
                                room['slot_host'] = 2
                                room['playerA'] = room['creator']
                                room['playerO'] = None
                                print(f"[CUSTOM ROOM] Host {room['creator']['name']} moved to Player A (Duelist)")
                        else:
                            room['slot_host'] = 1
                            room['playerO'] = room['creator']
                            room['playerA'] = None
                            print(f"[CUSTOM ROOM] Host {room['creator']['name']} moved to Player O (Observer)")
                    resp = {"code": 200, "room": room}

            elif self.path == '/api/query_room':
                raw_code = str(req.get('room_id', '')).strip()
                acc_id = req.get('account_id')
                my_name = req.get('name', 'Duelist')
                my_level = int(req.get('level', 50))
                my_avatar = int(req.get('avatar', 201))
                my_cards, my_extra = ensure_deck_cards(acc_id, req.get('cards', []), req.get('extra_cards', []))

                room = CUSTOM_PVP_ROOMS.get(raw_code)
                if not room and raw_code.isdigit():
                    room = CUSTOM_PVP_ROOMS.get(int(raw_code))
                if not room:
                    for k, v in list(CUSTOM_PVP_ROOMS.items()):
                        if str(k).strip() == raw_code:
                            room = v
                            break

                if not room:
                    resp = {"code": 404, "msg": "Phòng không tồn tại hoặc đã đóng!"}
                else:
                    room['last_activity'] = time.time()
                    guest_gc, guest_sc, guest_bc, guest_trophy = 0, 0, 0, 800
                    try:
                        with get_db() as conn:
                            with conn.cursor() as cur:
                                cur.execute("SELECT gold_cup, silver_cup, bronze_cup, trophy FROM accounts WHERE id = %s", (acc_id,))
                                row = cur.fetchone()
                                if row:
                                    guest_gc = int(row.get('gold_cup', 0) or 0)
                                    guest_sc = int(row.get('silver_cup', 0) or 0)
                                    guest_bc = int(row.get('bronze_cup', 0) or 0)
                                    guest_trophy = int(row.get('trophy', 800) or 800)
                    except Exception as e:
                        print(f"[ROOM DB ERR] {e}")

                    guest_user = {
                        "id": acc_id,
                        "name": my_name,
                        "level": my_level,
                        "avatar": my_avatar,
                        "gold": 100000,
                        "ingot": 10000,
                        "trophy": guest_trophy,
                        "win": 0,
                        "is_online": True,
                        "gold_cup": guest_gc,
                        "silver_cup": guest_sc,
                        "bronze_cup": guest_bc,
                        "cards": my_cards,
                        "extra_cards": my_extra
                    }
                    if room['creator_id'] != acc_id:
                        if room['playerB'] is None or (isinstance(room['playerB'], dict) and room['playerB'].get('id') == acc_id):
                            room['playerB'] = guest_user
                            print(f"[CUSTOM ROOM] {my_name} joined room {raw_code} as Player B")
                        elif room['playerA'] is None:
                            room['playerA'] = guest_user
                            print(f"[CUSTOM ROOM] {my_name} joined room {raw_code} as Player A")
                        else:
                            room['playerB'] = guest_user
                    resp = {"code": 200, "room": room}

            elif self.path == '/api/get_room_status':
                code = str(req.get('room_id', ''))
                room = CUSTOM_PVP_ROOMS.get(code)
                if not room:
                    resp = {"code": 404, "msg": "Phòng đã đóng!"}
                else:
                    room['last_activity'] = time.time()
                    resp = {"code": 200, "room": room}

            elif self.path == '/api/start_room_battle':
                code = str(req.get('room_id', ''))
                acc_id = req.get('account_id')
                room = CUSTOM_PVP_ROOMS.get(code)
                if not room:
                    resp = {"code": 404, "msg": "Phòng không tồn tại!"}
                else:
                    pA = room.get('playerA')
                    pB = room.get('playerB')
                    if not pA or not pB:
                        resp = {"code": 400, "msg": "Chưa đủ 2 người chơi tham chiến!"}
                    else:
                        pA['cards'], pA['extra_cards'] = ensure_deck_cards(pA.get('id'), pA.get('cards'), pA.get('extra_cards'))
                        pB['cards'], pB['extra_cards'] = ensure_deck_cards(pB.get('id'), pB.get('cards'), pB.get('extra_cards'))
                        match_id = f"m_room_{code}_{int(time.time()*1000)}"
                        seed = random.randint(1, 65535)
                        room['status'] = "battle"
                        room['match_id'] = match_id
                        room['seed'] = seed
                        print(f"[CUSTOM ROOM] Room {code} starting battle! Match ID: {match_id}")
                        resp = {"code": 200, "room": room, "match_id": match_id, "seed": seed}

            elif self.path == '/api/leave_room':
                code = str(req.get('room_id', ''))
                acc_id = req.get('account_id')
                room = CUSTOM_PVP_ROOMS.get(code)
                if room:
                    if room['creator_id'] == acc_id:
                        CUSTOM_PVP_ROOMS.pop(code, None)
                        print(f"[CUSTOM ROOM] Host left, closed room {code}")
                    else:
                        if room.get('playerB') and room['playerB']['id'] == acc_id:
                            room['playerB'] = None
                        elif room.get('playerA') and room['playerA']['id'] == acc_id:
                            room['playerA'] = None
                resp = {"code": 200, "msg": "OK"}

            elif self.path == '/api/save_replay':
                acc_id = req.get('account_id')
                rep_id = req.get('replay_id') or f"rep_{int(time.time()*1000)}_{random.randint(100, 999)}"
                oppo_name = str(req.get('opponent_name', 'Opponent'))[:64]
                oppo_level = int(req.get('opponent_level', 1))
                oppo_avatar = int(req.get('opponent_avatar', 201))
                result = int(req.get('result', 1))
                btype = int(req.get('battle_type', 17))
                trophy_chg = int(req.get('trophy_change', 0))
                clean_rep = sanitize_replay_data(req.get('replay_data', {}))
                rep_data = json.dumps(clean_rep, ensure_ascii=False)
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("""
                            INSERT INTO match_replays 
                            (replay_id, account_id, opponent_name, opponent_level, opponent_avatar, result, battle_type, trophy_change, replay_data)
                            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                            ON DUPLICATE KEY UPDATE trophy_change = VALUES(trophy_change), replay_data = VALUES(replay_data)
                        """, (rep_id, acc_id, oppo_name, oppo_level, oppo_avatar, result, btype, trophy_chg, rep_data))
                resp = {"code": 200, "msg": "Lưu trận đấu thành công!", "replay_id": rep_id}
                print(f"[REPLAY] Saved match replay {rep_id} for account {acc_id}")

            elif self.path == '/api/get_replays':
                acc_id = req.get('account_id')
                btype = req.get('battle_type')
                with get_db() as conn:
                    with conn.cursor() as cur:
                        query = """
                            SELECT r.replay_id, r.opponent_name, r.opponent_level, r.opponent_avatar,
                                   r.result, r.battle_type, r.trophy_change, UNIX_TIMESTAMP(r.created_at) as ts,
                                   COALESCE(a.gold_cup, 0) as opponent_gold_cup,
                                   COALESCE(a.silver_cup, 0) as opponent_silver_cup,
                                   COALESCE(a.bronze_cup, 0) as opponent_bronze_cup
                            FROM match_replays r
                            LEFT JOIN accounts a ON (r.opponent_name COLLATE utf8mb4_unicode_ci = a.character_name OR r.opponent_name COLLATE utf8mb4_unicode_ci = a.username)
                            WHERE r.account_id = %s
                        """
                        params = [acc_id]
                        if btype and int(btype) not in [0, 17, 211, 241]:
                            query += " AND r.battle_type = %s"
                            params.append(btype)
                        query += " ORDER BY r.id DESC LIMIT 20"
                        cur.execute(query, tuple(params))
                        rows = cur.fetchall()
                replays = []
                for r in rows:
                    replays.append({
                        "replay_id": r['replay_id'],
                        "opponent_name": r['opponent_name'],
                        "opponent_level": r['opponent_level'],
                        "opponent_avatar": r['opponent_avatar'],
                        "opponent_gold_cup": int(r.get('opponent_gold_cup') or 0),
                        "opponent_silver_cup": int(r.get('opponent_silver_cup') or 0),
                        "opponent_bronze_cup": int(r.get('opponent_bronze_cup') or 0),
                        "result": r['result'],
                        "battle_type": r['battle_type'],
                        "trophy_change": r['trophy_change'],
                        "timestamp": r['ts']
                    })
                resp = {"code": 200, "replays": replays}

            elif self.path == '/api/get_replay_detail':
                rep_id = req.get('replay_id')
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("SELECT replay_data, UNIX_TIMESTAMP(created_at) as ts FROM match_replays WHERE replay_id = %s", (rep_id,))
                        row = cur.fetchone()
                if row:
                    rep_data = json.loads(row['replay_data']) if isinstance(row['replay_data'], str) else row['replay_data']
                    if isinstance(rep_data, dict):
                        rep_data = sanitize_replay_data(rep_data)
                        if not rep_data.get('timestamp') and row.get('ts'):
                            rep_data['timestamp'] = int(row['ts'] * 1000)
                        if not rep_data.get('ts') and row.get('ts'):
                            rep_data['ts'] = row['ts']
                    resp = {"code": 200, "replay_data": rep_data}
                else:
                    resp = {"code": 404, "msg": "Replay not found"}

            elif self.path == '/api/share_replay':
                acc_id = int(req.get('account_id', 1))
                rep_id = str(req.get('replay_id', '')).strip()
                share_text = str(req.get('text', '')).strip()

                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("""
                            SELECT r.replay_id, r.account_id, r.opponent_name, r.opponent_level, r.opponent_avatar,
                                   r.result, r.battle_type, r.trophy_change, r.replay_data, UNIX_TIMESTAMP(r.created_at) as ts,
                                   COALESCE(a.gold_cup, 0) as opp_gold_cup,
                                   COALESCE(a.silver_cup, 0) as opp_silver_cup,
                                   COALESCE(a.bronze_cup, 0) as opp_bronze_cup
                            FROM match_replays r
                            LEFT JOIN accounts a ON (r.opponent_name COLLATE utf8mb4_unicode_ci = a.character_name OR r.opponent_name COLLATE utf8mb4_unicode_ci = a.username)
                            WHERE r.replay_id = %s
                        """, (rep_id,))
                        rep_row = cur.fetchone()

                        cur.execute("SELECT id, username, character_name, avatar, trophy, gold_cup, silver_cup, bronze_cup, level FROM accounts WHERE id = %s", (acc_id,))
                        acc_row = cur.fetchone()

                if not rep_row:
                    resp = {"code": 404, "msg": "Không tìm thấy dữ liệu trận đấu để chia sẻ!"}
                else:
                    sender_name = (acc_row.get('character_name') or acc_row['username']) if acc_row else "Duelist"
                    sender_level = acc_row.get('level', 50) if acc_row else 50
                    sender_avatar = acc_row.get('avatar', 201) if (acc_row and acc_row.get('avatar')) else 201
                    gc = int(acc_row.get('gold_cup') or 0) if acc_row else 0
                    sc = int(acc_row.get('silver_cup') or 0) if acc_row else 0
                    bc = int(acc_row.get('bronze_cup') or 0) if acc_row else 0
                    cid = 7204 if gc > 0 else (7205 if sc > 0 else (7206 if bc > 0 else 0))
                    cnum = gc if gc > 0 else (sc if sc > 0 else (bc if bc > 0 else 0))

                    rd = {}
                    try:
                        rd = json.loads(rep_row['replay_data']) if isinstance(rep_row['replay_data'], str) else rep_row['replay_data']
                    except Exception:
                        pass
                    round_cnt = rd.get('round', 5) if isinstance(rd, dict) else 5

                    now_ms = int(time.time() * 1000)
                    battle_payload = {
                        "replay_id": rep_id,
                        "text": share_text if share_text else "Đã chia sẻ một trận chiến kịch tính!",
                        "opponent_name": rep_row['opponent_name'],
                        "opponent_level": rep_row['opponent_level'],
                        "opponent_avatar": rep_row['opponent_avatar'],
                        "opponent_gold_cup": int(rep_row.get('opp_gold_cup') or 0),
                        "opponent_silver_cup": int(rep_row.get('opp_silver_cup') or 0),
                        "opponent_bronze_cup": int(rep_row.get('opp_bronze_cup') or 0),
                        "result": rep_row['result'],
                        "battle_type": rep_row['battle_type'],
                        "trophy_change": rep_row['trophy_change'],
                        "round": round_cnt,
                        "timestamp": int(rep_row['ts'] * 1000) if rep_row.get('ts') else now_ms
                    }
                    content_str = json.dumps(battle_payload, ensure_ascii=False)
                    client_msg_id = f"share_{rep_id}_{now_ms}"
                    msg_obj = {
                        "client_msg_id": client_msg_id,
                        "account_id": acc_id,
                        "name": sender_name,
                        "level": sender_level,
                        "avatar": sender_avatar,
                        "gold_cup": gc,
                        "silver_cup": sc,
                        "bronze_cup": bc,
                        "crown_id": cid,
                        "crown_num": cnum,
                        "type": 3,
                        "card_id": 0,
                        "content": content_str,
                        "msg": content_str,
                        "timestamp": now_ms,
                        "battle_data": battle_payload
                    }
                    if cid > 0:
                        msg_obj['crown'] = {'info_id': cid, 'num': cnum}
                    db_id = db_save_chat_message(msg_obj)
                    msg_obj['id'] = db_id

                    # Keep in-memory cache synchronized
                    CHAT_MESSAGES.append(msg_obj)

                    broadcast_ws_sync({"t": "chat_broadcast", "msg": msg_obj})
                    print(f"[REPLAY SHARE] {sender_name} shared replay {rep_id} to combat chat [DB ID: {db_id}]")
                    resp = {"code": 200, "msg": "Chia sẻ chiến tích thành công!", "replay_id": rep_id, "chat_id": db_id}
            else:
                resp = {"code": 404, "msg": "Endpoint not found"}

            out = json.dumps(resp, ensure_ascii=False).encode('utf-8')
            self.send_response(200)
            self.send_header('Content-Type', 'application/json; charset=utf-8')
            self.send_header('Content-Length', str(len(out)))
            self.end_headers()
            self.wfile.write(out)
        else:
            self.send_error(404, "Not Found")

class ThreadingHTTPServer(socketserver.ThreadingMixIn, http.server.HTTPServer):
    daemon_threads = True

PVP_ROOMS = {}
CUSTOM_PVP_ROOMS = {}
LEADERBOARD_CACHE = {"data": None, "time": 0}
PVP_HTTP_WAITING = {}
PVP_HTTP_MATCHED = {}
PVP_HTTP_CANCELLED = set()
PVP_QUEUE = []
ACTIVE_MATCHES = {}
WS_CLIENT_META = {}
WS_CONNECTED_CLIENTS = set()
CHAT_MESSAGES = []

def ensure_chat_db():
    try:
        with get_db() as conn:
            with conn.cursor() as cur:
                cur.execute("""
                    CREATE TABLE IF NOT EXISTS chat_messages (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        client_msg_id VARCHAR(64) DEFAULT NULL,
                        account_id INT NOT NULL,
                        sender_name VARCHAR(64) NOT NULL,
                        level INT DEFAULT 1,
                        avatar INT DEFAULT 201,
                        trophy INT DEFAULT 800,
                        msg_type INT DEFAULT 1,
                        card_id INT DEFAULT 0,
                        content TEXT NOT NULL,
                        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                        timestamp_ms BIGINT NOT NULL,
                        INDEX idx_created (created_at),
                        INDEX idx_client_msg (client_msg_id),
                        INDEX idx_account (account_id)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
                """)
                # Migration: add trophy and cup columns if missing
                cur.execute("""
                    SELECT count(*) as cnt FROM information_schema.columns
                    WHERE table_schema = DATABASE() AND table_name = 'chat_messages' AND column_name = 'trophy'
                """)
                if cur.fetchone()['cnt'] == 0:
                    cur.execute("ALTER TABLE `chat_messages` ADD COLUMN `trophy` INT NOT NULL DEFAULT 800")
                cur.execute("""
                    SELECT count(*) as cnt FROM information_schema.columns
                    WHERE table_schema = DATABASE() AND table_name = 'chat_messages' AND column_name = 'gold_cup'
                """)
                if cur.fetchone()['cnt'] == 0:
                    cur.execute("ALTER TABLE `chat_messages` ADD COLUMN `gold_cup` INT NOT NULL DEFAULT 0, ADD COLUMN `silver_cup` INT NOT NULL DEFAULT 0, ADD COLUMN `bronze_cup` INT NOT NULL DEFAULT 0")
                cur.execute("SELECT COUNT(*) AS cnt FROM chat_messages WHERE created_at >= CURDATE()")
                cnt = cur.fetchone()['cnt']
                if cnt == 0:
                    now_ms = int(time.time() * 1000)
                    cur.execute("""
                        INSERT INTO chat_messages (client_msg_id, account_id, sender_name, level, avatar, msg_type, card_id, content, created_at, timestamp_ms)
                        VALUES
                        (%s, %s, %s, %s, %s, %s, %s, %s, NOW(), %s),
                        (%s, %s, %s, %s, %s, %s, %s, %s, NOW(), %s)
                    """, (
                        'sys_welcome_1', 0, 'Hệ Thống', 99, 101, 1, 0,
                        '[THÔNG BÁO] Chào mừng các bài thủ đến với thế giới Yu-Gi-Oh! Chúc các bài thủ thi đấu vui vẻ và đạt thứ hạng cao!',
                        now_ms - 60000,
                        'sys_bulletin_1', 0, 'Hệ Thống', 99, 101, 2, 10001,
                        '[THÔNG BÁO] Chúc mừng bài thủ [Yugi Muto] vừa rút được lá bài cấp GR thần thánh [Rồng Trắng Mắt Xanh]!',
                        now_ms - 30000
                    ))
                    print("[CHAT DB] Initialized today's system messages.")
    except Exception as e:
        print("[CHAT DB] ensure_chat_db error:", e)

def db_save_chat_message(msg_obj):
    ensure_chat_db()
    try:
        with get_db() as conn:
            with conn.cursor() as cur:
                acc_id = msg_obj.get('account_id', 1)
                gc = int(msg_obj.get('gold_cup') or 0)
                sc = int(msg_obj.get('silver_cup') or 0)
                bc = int(msg_obj.get('bronze_cup') or 0)
                if acc_id and acc_id > 0 and (gc == 0 and sc == 0 and bc == 0):
                    try:
                        cur.execute("SELECT gold_cup, silver_cup, bronze_cup FROM accounts WHERE id = %s", (acc_id,))
                        arow = cur.fetchone()
                        if arow:
                            gc = int(arow.get('gold_cup') or 0)
                            sc = int(arow.get('silver_cup') or 0)
                            bc = int(arow.get('bronze_cup') or 0)
                    except Exception:
                        pass
                cid = int(msg_obj.get('crown_id') or (7204 if gc > 0 else (7205 if sc > 0 else (7206 if bc > 0 else 0))))
                cnum = int(msg_obj.get('crown_num') or (gc if gc > 0 else (sc if sc > 0 else (bc if bc > 0 else 0))))
                msg_obj['gold_cup'] = gc
                msg_obj['silver_cup'] = sc
                msg_obj['bronze_cup'] = bc
                msg_obj['crown_id'] = cid
                msg_obj['crown_num'] = cnum
                if cid > 0:
                    msg_obj['crown'] = {'info_id': cid, 'num': cnum}

                cur.execute("""
                    INSERT INTO chat_messages 
                    (client_msg_id, account_id, sender_name, level, avatar, trophy, gold_cup, silver_cup, bronze_cup, msg_type, card_id, content, created_at, timestamp_ms)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, NOW(), %s)
                """, (
                    msg_obj.get('client_msg_id'),
                    acc_id,
                    msg_obj.get('name', 'Duelist'),
                    msg_obj.get('level', 1),
                    msg_obj.get('avatar', 201),
                    msg_obj.get('trophy', 800),
                    gc, sc, bc,
                    msg_obj.get('type', 1),
                    msg_obj.get('card_id', 0),
                    msg_obj.get('content', ''),
                    msg_obj.get('timestamp', int(time.time() * 1000))
                ))
                inserted_id = cur.lastrowid
                msg_obj['id'] = inserted_id
                return inserted_id
    except Exception as e:
        print("[CHAT DB] save message error:", e)
        return msg_obj.get('id', int(time.time() * 1000))

def db_get_today_chat_history():
    ensure_chat_db()
    try:
        with get_db() as conn:
            with conn.cursor() as cur:
                cur.execute("""
                    SELECT c.id, c.client_msg_id, c.account_id, c.sender_name AS name, c.level, c.avatar, c.trophy,
                           COALESCE(NULLIF(c.gold_cup, 0), a.gold_cup, 0) AS gold_cup,
                           COALESCE(NULLIF(c.silver_cup, 0), a.silver_cup, 0) AS silver_cup,
                           COALESCE(NULLIF(c.bronze_cup, 0), a.bronze_cup, 0) AS bronze_cup,
                           c.msg_type AS type, c.card_id, c.content, c.content AS msg, c.timestamp_ms AS timestamp, c.created_at
                    FROM chat_messages c
                    LEFT JOIN accounts a ON c.account_id = a.id
                    WHERE c.created_at >= CURDATE()
                    ORDER BY c.id ASC
                """)
                rows = cur.fetchall()
                messages = []
                for r in rows:
                    gc = int(r.get('gold_cup') or 0)
                    sc = int(r.get('silver_cup') or 0)
                    bc = int(r.get('bronze_cup') or 0)
                    cid = 7204 if gc > 0 else (7205 if sc > 0 else (7206 if bc > 0 else 0))
                    cnum = gc if gc > 0 else (sc if sc > 0 else (bc if bc > 0 else 0))
                    m = {
                        "id": r['id'],
                        "client_msg_id": r['client_msg_id'] or '',
                        "timestamp": r['timestamp'],
                        "account_id": r['account_id'],
                        "name": r['name'],
                        "level": r['level'],
                        "avatar": r['avatar'],
                        "gold_cup": gc,
                        "silver_cup": sc,
                        "bronze_cup": bc,
                        "crown_id": cid,
                        "crown_num": cnum,
                        "content": r['content'],
                        "msg": r['msg'],
                        "type": r['type'],
                        "card_id": r['card_id']
                    }
                    if cid > 0:
                        m['crown'] = {'info_id': cid, 'num': cnum}
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
        print("[CHAT DB] get history error:", e)
        return []

def save_chat_history():
    pass

def load_chat_history():
    global CHAT_MESSAGES
    CHAT_MESSAGES = db_get_today_chat_history()
    print(f"[CHAT DB] Loaded {len(CHAT_MESSAGES)} messages for today from MySQL.")


def make_pvp_frame(payload_dict):
    body = json.dumps(payload_dict, ensure_ascii=False).encode('utf-8')
    return struct.pack(">I", len(body)) + body

def broadcast_ws_sync(payload_dict):
    global WS_LOOP
    frame = make_pvp_frame(payload_dict)
    dead = set()
    for ws in list(WS_CONNECTED_CLIENTS):
        try:
            if WS_LOOP and WS_LOOP.is_running():
                asyncio.run_coroutine_threadsafe(ws.send(frame), WS_LOOP)
        except Exception:
            dead.add(ws)
    for ws in dead:
        WS_CONNECTED_CLIENTS.discard(ws)

def decode_pvp_payload(msg):
    if isinstance(msg, str):
        try:
            return json.loads(msg)
        except:
            return None
    if isinstance(msg, (bytes, bytearray)):
        if len(msg) >= 4:
            length = struct.unpack(">I", msg[:4])[0]
            if len(msg) >= 4 + length:
                try:
                    return json.loads(msg[4:4+length].decode('utf-8', errors='ignore'))
                except:
                    pass
        try:
            return json.loads(msg.decode('utf-8', errors='ignore'))
        except:
            return None
    return None

async def ws_handler(websocket):
    client_ip = websocket.remote_address
    print(f"[WS] Client connected: {client_ip}")
    WS_CONNECTED_CLIENTS.add(websocket)
    challenge_frame = bytes.fromhex("0000002b08641000a206240102030452934c32eca7ed0296d67b750000881bfbdd333800ebab8cdbec54dd000076e1")
    try:
        await websocket.send(challenge_frame)
        async for raw_msg in websocket:
            pkt = decode_pvp_payload(raw_msg)
            if not pkt or not isinstance(pkt, dict):
                continue
            
            t = pkt.get("t")
            if t == "chat":
                match_id = pkt.get("match_id") or WS_CLIENT_META.get(websocket, {}).get("match_id")
                if match_id:
                    if match_id in ACTIVE_MATCHES:
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
                                print(f"[PVP CHAT] Match {match_id}: relayed quick chat: {safe_preview}")
                            except Exception as e:
                                print(f"[PVP CHAT ERR] Relay failed: {type(e).__name__}")
                else:
                    msg_data = pkt.get("msg")
                    if isinstance(msg_data, dict):
                        try:
                            acc_id = msg_data.get('account_id')
                            if acc_id and ('gold_cup' not in msg_data or 'crown_id' not in msg_data):
                                try:
                                    with get_db() as conn:
                                        with conn.cursor() as cur:
                                            cur.execute("SELECT gold_cup, silver_cup, bronze_cup FROM accounts WHERE id = %s", (acc_id,))
                                            arow = cur.fetchone()
                                            if arow:
                                                gc = int(arow.get('gold_cup') or 0)
                                                sc = int(arow.get('silver_cup') or 0)
                                                bc = int(arow.get('bronze_cup') or 0)
                                                msg_data['gold_cup'] = gc
                                                msg_data['silver_cup'] = sc
                                                msg_data['bronze_cup'] = bc
                                                cid = 7204 if gc > 0 else (7205 if sc > 0 else (7206 if bc > 0 else 0))
                                                cnum = gc if gc > 0 else (sc if sc > 0 else (bc if bc > 0 else 0))
                                                msg_data['crown_id'] = cid
                                                msg_data['crown_num'] = cnum
                                                if cid > 0:
                                                    msg_data['crown'] = {'info_id': cid, 'num': cnum}
                                except Exception:
                                    pass
                            CHAT_MESSAGES.append(msg_data)
                            if len(CHAT_MESSAGES) > 50: CHAT_MESSAGES.pop(0)
                            broadcast_ws_sync({"t": "chat_broadcast", "msg": msg_data})
                            print(f"[WS LOBBY CHAT] {msg_data.get('name')}: {msg_data.get('content')}")
                        except Exception as e:
                            print(f"[WS LOBBY CHAT ERR] {e}")
            elif t == "bind_match":
                match_id = str(pkt.get("match_id", ""))
                user_id = pkt.get("user_id", "")
                if match_id:
                    WS_CLIENT_META[websocket] = {"match_id": match_id, "user_id": user_id}
                    if match_id not in ACTIVE_MATCHES:
                        ACTIVE_MATCHES[match_id] = {"p1": websocket, "p2": None}
                        print(f"[PVP WS] Match {match_id}: p1 bound (user {user_id})")
                    else:
                        match = ACTIVE_MATCHES[match_id]
                        if match.get("p1") == websocket:
                            print(f"[PVP WS] Match {match_id}: p1 confirmed (user {user_id})")
                        elif match.get("p2") == websocket:
                            print(f"[PVP WS] Match {match_id}: p2 confirmed (user {user_id})")
                        elif match.get("p1") is None:
                            match["p1"] = websocket
                            print(f"[PVP WS] Match {match_id}: p1 bound (user {user_id})")
                        else:
                            match["p2"] = websocket
                            print(f"[PVP WS] Match {match_id}: p2 bound (user {user_id})")
                        p1 = match.get("p1")
                        p2 = match.get("p2")
                        if p1 and p2 and not match.get("ready_sent"):
                            match["ready_sent"] = True
                            ready_msg = make_pvp_frame({"t": "peer_ready"})
                            try: asyncio.create_task(p1.send(ready_msg))
                            except: pass
                            try: asyncio.create_task(p2.send(ready_msg))
                            except: pass
                    await websocket.send(make_pvp_frame({"t": "bind_ok", "match_id": match_id}))

            elif t == "create":
                code = str(pkt.get("code") or random.randint(1000, 9999))
                PVP_ROOMS[code] = {
                    "host": websocket,
                    "host_deck": pkt.get("deck"),
                    "host_info": pkt.get("info"),
                    "hp": pkt.get("hp", 8000)
                }
                WS_CLIENT_META[websocket] = {"room_code": code}
                print(f"[PVP] Room created: {code} by {pkt.get('info', {}).get('name', 'Host')}")
                await websocket.send(make_pvp_frame({"t": "room_created", "code": code}))

            elif t == "join":
                code = str(pkt.get("code", ""))
                room = PVP_ROOMS.get(code)
                if room and room["host"] != websocket:
                    match_id = f"m_{int(time.time()*1000)}"
                    seed = random.randint(1, 65535)
                    host_ws = room["host"]
                    guest_ws = websocket
                    
                    ACTIVE_MATCHES[match_id] = {"p1": host_ws, "p2": guest_ws}
                    WS_CLIENT_META[host_ws] = {"match_id": match_id}
                    WS_CLIENT_META[guest_ws] = {"match_id": match_id}
                    
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
                    print(f"[PVP] Room {code} matched! Match ID {match_id}")
                else:
                    await websocket.send(make_pvp_frame({"t": "error", "msg": "Phòng không tồn tại hoặc đã đầy!"}))

            elif t == "match":
                matched = False
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
                        ACTIVE_MATCHES[match_id] = {"p1": websocket, "p2": other_ws}
                        WS_CLIENT_META[websocket] = {"match_id": match_id}
                        WS_CLIENT_META[other_ws] = {"match_id": match_id}
                        
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
                            "peer": pkt.get("info")
                        }))
                        print(f"[PVP] Matched 2 players in matchmaking! Match ID {match_id} (trophy diff: {best_diff})")
                        matched = True
                    except Exception as e:
                        print(f"[PVP WS MATCH ERR] {e}")

                if not matched:
                    entry = (websocket, pkt.get("deck"), pkt.get("info"))
                    PVP_QUEUE.append(entry)
                    print(f"[PVP] Player queued for quick match ({my_trophy} pts). Queue size: {len(PVP_QUEUE)}")
                    
                    async def auto_ai_match(target_entry):
                        await asyncio.sleep(45)
                        if target_entry in PVP_QUEUE:
                            PVP_QUEUE.remove(target_entry)
                            ws, my_deck, my_info = target_entry
                            match_id = f"m_ai_{int(time.time()*1000)}"
                            seed = random.randint(1, 65535)
                            first = random.choice([True, False])
                            bot_deck = {
                                "name": "Duelist_Kaiba",
                                "avatar": random.choice([101, 102, 103, 104, 105]),
                                "cards": [10001, 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 10011, 10012, 10013, 10014, 10015, 10016, 10017, 10018, 10019, 10020, 20001, 20002, 20003, 20004, 20005, 20006, 20007, 20008, 30001, 30002, 30003, 30004, 30005],
                                "levels": [1]*34,
                                "skins": {}
                            }
                            try:
                                await ws.send(make_pvp_frame({
                                    "t": "matched",
                                    "match_id": match_id,
                                    "seed": seed,
                                    "first": first,
                                    "peer_deck": bot_deck,
                                    "peer": {"name": "Duelist_Kaiba", "avatar": 102}
                                }))
                                print(f"[PVP] Auto matched with AI for player. Match ID {match_id}")
                            except:
                                pass
                    asyncio.create_task(auto_ai_match(entry))

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
                            await peer_ws.send(make_pvp_frame(pkt))
                            ints = pkt.get("ints", [])
                            print(f"[PVP ACTION] Match {match_id}: relayed ints len={len(ints)} {ints[:4] if len(ints)>=4 else ints} seq={pkt.get('seq')}")
                        except Exception as e:
                            print(f"[PVP ACTION ERR] {e}")
                    else:
                        print(f"[PVP ACTION WARN] Match {match_id}: peer not connected yet")


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
                            # If sender won ('1' or 'win'): peer lost ('2' / '-1')
                            # If sender lost / surrendered ('-1', '2', 'lose'): peer won ('1')
                            sender_won = (raw_res == "1" or raw_res == "win")
                            peer_res = "2" if sender_won else "1"
                            peer_pkt = dict(pkt)
                            peer_pkt["result"] = peer_res
                            peer_pkt["sender_won"] = sender_won
                            peer_pkt["peer_won"] = not sender_won
                            await peer_ws.send(make_pvp_frame(peer_pkt))
                            print(f"[PVP END] Match {match_id}: sender_res={raw_res} (sender_won={sender_won}) -> peer_res={peer_res} (peer_won={not sender_won})")
                        except Exception as e:
                            print(f"[PVP END ERR] {e}")

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
                        except:
                            pass
                    if match.get("p1") is None and match.get("p2") is None:
                        ACTIVE_MATCHES.pop(match_id, None)

    except Exception as e:
        pass
    finally:
        for code, room in list(PVP_ROOMS.items()):
            if room.get("host") == websocket:
                del PVP_ROOMS[code]
        for item in list(PVP_QUEUE):
            if item[0] == websocket:
                PVP_QUEUE.remove(item)
        match_id = WS_CLIENT_META.get(websocket, {}).get("match_id")
        if match_id and match_id in ACTIVE_MATCHES:
            match = ACTIVE_MATCHES[match_id]
            peer_ws = None
            if match.get("p1") == websocket:
                peer_ws = match.get("p2")
                match["p1"] = None
            elif match.get("p2") == websocket:
                peer_ws = match.get("p1")
                match["p2"] = None
            if peer_ws:
                try:
                    asyncio.create_task(peer_ws.send(make_pvp_frame({"t": "peer_left"})))
                except:
                    pass
            if match.get("p1") is None and match.get("p2") is None:
                ACTIVE_MATCHES.pop(match_id, None)
        WS_CLIENT_META.pop(websocket, None)
        WS_CONNECTED_CLIENTS.discard(websocket)
        print(f"[WS] Client disconnected: {client_ip}")


DAILY_REWARDS_STATE_FILE = os.path.join(os.path.dirname(__file__), "daily_rewards_state.json")

def get_last_awarded_date():
    try:
        if os.path.exists(DAILY_REWARDS_STATE_FILE):
            with open(DAILY_REWARDS_STATE_FILE, "r", encoding="utf-8") as f:
                data = json.load(f)
                return data.get("last_awarded_date")
    except Exception:
        pass
    return None

def set_last_awarded_date(date_str):
    try:
        with open(DAILY_REWARDS_STATE_FILE, "w", encoding="utf-8") as f:
            json.dump({"last_awarded_date": date_str, "timestamp": time.time()}, f, ensure_ascii=False, indent=2)
    except Exception as e:
        print(f"[DAILY REWARDS STATE ERR] {e}")


def distribute_daily_leaderboard_rewards():
    try:
        now = datetime.datetime.now()
        today_str = now.strftime('%Y-%m-%d')
        print(f"[DAILY LEADERBOARD] Running daily rewards distribution for {today_str}...")
        with get_db() as conn:
            with conn.cursor() as cur:
                # ---------------------------------------------------------
                # BƯỚC 1: PHÁT THƯỞNG CUP CHO TOP 1, 2, 3 (VÀ TOP 10)
                # ---------------------------------------------------------
                cur.execute("""
                    SELECT id, character_name, trophy, level 
                    FROM accounts 
                    ORDER BY trophy DESC, level DESC, id ASC 
                    LIMIT 10
                """)
                top_players = cur.fetchall()
                if not top_players:
                    print("[DAILY LEADERBOARD] No players found.")
                    return

                for idx, p in enumerate(top_players):
                    rank = idx + 1
                    pid = p['id']
                    pname = p['character_name'] or f"Duelist_{pid}"
                    if rank == 1:
                        cur.execute("UPDATE accounts SET gold_cup = gold_cup + 1, gold = gold + 4800, leya_ticket = leya_ticket + 1, daily_rank = 1 WHERE id = %s", (pid,))
                        cup_icon = "🥇 Cúp Vàng (Bonus 10749)"
                    elif rank == 2:
                        cur.execute("UPDATE accounts SET silver_cup = silver_cup + 1, gold = gold + 3600, gem = gem + 40, daily_rank = 2 WHERE id = %s", (pid,))
                        cup_icon = "🥈 Cúp Bạc (Bonus 10750)"
                    elif rank == 3:
                        cur.execute("UPDATE accounts SET bronze_cup = bronze_cup + 1, gold = gold + 3000, gem = gem + 40, daily_rank = 3 WHERE id = %s", (pid,))
                        cup_icon = "🥉 Cúp Đồng (Bonus 10751)"
                    elif rank <= 5:
                        cur.execute("UPDATE accounts SET gold = gold + 2400, gem = gem + 500, daily_rank = %s WHERE id = %s", (rank, pid))
                        cup_icon = f"Hạng {rank} (Bonus 10752)"
                    else:
                        cur.execute("UPDATE accounts SET gold = gold + 1800, gem = gem + 400, daily_rank = %s WHERE id = %s", (rank, pid))
                        cup_icon = f"Hạng {rank} (Bonus 10753)"
                    print(f"[DAILY REWARD] Rank {rank}: {pname} awarded {cup_icon}")

                # ---------------------------------------------------------
                # BƯỚC 2: TẶNG VÀNG CHO TẤT CẢ NGƯỜI CHƠI RANK != 800 (VÀNG = RANKPOINT x 100)
                # SAU ĐÓ RESET TẤT CẢ MỨC RANK CỦA NGƯỜI CHƠI CÓ RANK != 800 VỀ = 800
                # ---------------------------------------------------------
                cur.execute("""
                    SELECT id, character_name, trophy, gold 
                    FROM accounts 
                    WHERE trophy IS NOT NULL AND trophy != 800
                """)
                rank_players = cur.fetchall()
                rewarded_count = 0
                total_gold_distributed = 0

                for rp in rank_players:
                    pid = rp['id']
                    pname = rp['character_name'] or f"Duelist_{pid}"
                    p_trophy = int(rp['trophy']) if rp.get('trophy') is not None else 800
                    if p_trophy != 800:
                        gold_bonus = max(0, p_trophy) * 100
                        cur.execute("""
                            UPDATE accounts 
                            SET gold = gold + %s, trophy = 800 
                            WHERE id = %s
                        """, (gold_bonus, pid))
                        rewarded_count += 1
                        total_gold_distributed += gold_bonus
                        print(f"[RANK REWARD & RESET] Player {pid} ({pname}): Rank {p_trophy} -> +{gold_bonus:,} Vàng | Trophy reset về 800")

                # Đồng thời phòng ngừa trường hợp trophy bị NULL, đưa về 800
                cur.execute("UPDATE accounts SET trophy = 800 WHERE trophy IS NULL")
                conn.commit()

                print(f"[DAILY LEADERBOARD COMPLETE] Đã trao Cúp Top 1,2,3; tặng tổng cộng {total_gold_distributed:,} Vàng cho {rewarded_count} người chơi có rank != 800 và reset toàn bộ rank về 800.")

                # ---------------------------------------------------------
                # BƯỚC 3: THÔNG BÁO HỆ THỐNG TRÊN KÊNH CHAT TOÀN SERVER
                # ---------------------------------------------------------
                top1 = top_players[0]
                broadcast_text = (
                    f"🏆 [KẾT TOÁN MÙA ĐẤU 12H ĐÊM - {today_str}]\n"
                    f"🥇 Chúc mừng Tân Vương [{top1['character_name']}] đã xuất sắc đoạt Cúp Vàng!\n"
                    f"💰 Đã phát thưởng vàng (Rank x 100) cho {rewarded_count} bài thủ (tổng: {total_gold_distributed:,} Vàng) "
                    f"và reset toàn bộ mức Rank về 800 chuẩn bị cho mùa giải mới!"
                )
                broadcast_msg = {
                    "id": int(time.time()*1000),
                    "timestamp": int(time.time()*1000),
                    "account_id": 0,
                    "name": "Hệ Thống",
                    "level": 99,
                    "avatar": 101,
                    "content": broadcast_text,
                    "msg": broadcast_text,
                    "type": 2
                }
                CHAT_MESSAGES.append(broadcast_msg)
                if len(CHAT_MESSAGES) > 100: CHAT_MESSAGES.pop(0)
                save_chat_history()
                broadcast_ws_sync({"t": "chat_broadcast", "msg": broadcast_msg})

    except Exception as e:
        print(f"[DAILY LEADERBOARD ERROR] {e}")


def daily_scheduler_loop():
    while True:
        try:
            now = datetime.datetime.now()
            today_str = now.strftime('%Y-%m-%d')
            last_awarded = get_last_awarded_date()
            if last_awarded != today_str and now.hour == 0 and now.minute == 0:
                set_last_awarded_date(today_str)
                distribute_daily_leaderboard_rewards()
        except Exception as e:
            print(f"[SCHEDULER LOOP ERROR] {e}")
        time.sleep(10)

def start_ws():
    async def run_server():
        global WS_LOOP
        WS_LOOP = asyncio.get_running_loop()
        async with websockets.serve(ws_handler, "0.0.0.0", WS_PORT):
            print(f"[WS Server] Listening on ws://0.0.0.0:{WS_PORT}")
            await asyncio.Future()
    try:
        asyncio.run(run_server())
    except Exception as e:
        print(f"[WS Error] {e}")

def main():
    print("==================================================================")
    print("      YU-GI-OH ONLINE WEB H5 (Yugihlor - trading \"Nạp\" game)      ")
    print(f"      Web Client URL : http://localhost:{HTTP_PORT}                ")
    print(f"      WebSocket Port : ws://localhost:{WS_PORT}                    ")
    print(f"      MySQL Database : {DB_CONFIG['database']} @ 127.0.0.1:3306   ")
    print("==================================================================")
    
    try:
        with get_db() as conn:
            with conn.cursor() as cur:
                cur.execute("""
                    CREATE TABLE IF NOT EXISTS `user_levels` (
                        `account_id` INT NOT NULL,
                        `difficulty` INT NOT NULL,
                        `cur_level` INT NOT NULL DEFAULT 10101,
                        `max_level` INT NOT NULL DEFAULT 10101,
                        PRIMARY KEY (`account_id`, `difficulty`),
                        FOREIGN KEY (`account_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
                """)
                cur.execute("""
                    CREATE TABLE IF NOT EXISTS `user_checkin` (
                        `account_id` INT NOT NULL,
                        `checkin_type` INT NOT NULL DEFAULT 1,
                        `day_index` INT NOT NULL DEFAULT 1,
                        `claim_date` DATE NOT NULL,
                        PRIMARY KEY (`account_id`, `checkin_type`, `day_index`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
                """)
                cur.execute("""
                    CREATE TABLE IF NOT EXISTS `user_achievements` (
                        `account_id` INT NOT NULL,
                        `achieve_id` INT NOT NULL,
                        `progress` INT NOT NULL DEFAULT 0,
                        `is_claimed` TINYINT NOT NULL DEFAULT 0,
                        `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        PRIMARY KEY (`account_id`, `achieve_id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
                """)
                cur.execute("""
                    CREATE TABLE IF NOT EXISTS `match_replays` (
                        `id` INT NOT NULL AUTO_INCREMENT,
                        `replay_id` VARCHAR(64) NOT NULL UNIQUE,
                        `account_id` INT NOT NULL,
                        `opponent_name` VARCHAR(64) NOT NULL DEFAULT '',
                        `opponent_level` INT NOT NULL DEFAULT 1,
                        `opponent_avatar` INT NOT NULL DEFAULT 201,
                        `result` TINYINT NOT NULL DEFAULT 1,
                        `battle_type` INT NOT NULL DEFAULT 17,
                        `trophy_change` INT NOT NULL DEFAULT 0,
                        `replay_data` LONGTEXT NOT NULL,
                        `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`),
                        KEY `acc_idx` (`account_id`),
                        KEY `rep_idx` (`replay_id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
                """)
                # Trophy column migration
                cur.execute("""
                    SELECT count(*) as cnt FROM information_schema.columns
                    WHERE table_schema = %s AND table_name = 'accounts' AND column_name = 'trophy'
                """, (DB_CONFIG['database'],))
                if cur.fetchone()['cnt'] == 0:
                    cur.execute("ALTER TABLE `accounts` ADD COLUMN `trophy` INT NOT NULL DEFAULT 800")
                # Pity count column migration
                cur.execute("""
                    SELECT count(*) as cnt FROM information_schema.columns
                    WHERE table_schema = %s AND table_name = 'accounts' AND column_name = 'pity_count'
                """, (DB_CONFIG['database'],))
                if cur.fetchone()['cnt'] == 0:
                    cur.execute("ALTER TABLE `accounts` ADD COLUMN `pity_count` INT NOT NULL DEFAULT 0")
                
                for col_name, col_def in [
                    ('character_id', 'INT NOT NULL DEFAULT 3'),
                    ('avatar', 'INT NOT NULL DEFAULT 301'),
                    ('gold_cup', 'INT NOT NULL DEFAULT 0'),
                    ('silver_cup', 'INT NOT NULL DEFAULT 0'),
                    ('bronze_cup', 'INT NOT NULL DEFAULT 0'),
                    ('daily_rank', 'INT NOT NULL DEFAULT 0')
                ]:
                    cur.execute("""
                        SELECT count(*) as cnt FROM information_schema.columns
                        WHERE table_schema = %s AND table_name = 'accounts' AND column_name = %s
                    """, (DB_CONFIG['database'], col_name))
                    if cur.fetchone()['cnt'] == 0:
                        cur.execute(f"ALTER TABLE `accounts` ADD COLUMN `{col_name}` {col_def}")
                        print(f"[DB MIGRATION] Added column accounts.{col_name}")
                # Fix level 10105 bug in DB
                cur.execute("UPDATE `user_levels` SET cur_level = 10201 WHERE cur_level = 10105")
                cur.execute("UPDATE `user_levels` SET max_level = 10201 WHERE max_level = 10105")
                # Rebrand server name in DB
                cur.execute("UPDATE `accounts` SET server = 'S1 - Yugihlor - trading \"Nạp\" game' WHERE server LIKE '%Quyết Chiến%'")
                cur.execute("SELECT count(*) as cnt FROM accounts")
                print(f"[DB] Connected successfully! Found {cur.fetchone()['cnt']} accounts in MySQL.")
    except Exception as e:
        print(f"[DB ERROR] Cannot connect to MySQL: {e}")
        return

    class FastThreadingHTTPServer(ThreadingHTTPServer):
        request_queue_size = 256
        daemon_threads = True

    ws_thread = threading.Thread(target=start_ws, daemon=True)
    ws_thread.start()
    scheduler_thread = threading.Thread(target=daily_scheduler_loop, daemon=True)
    scheduler_thread.start()
    print("[SCHEDULER] Daily leaderboard 0h midnight reward scheduler started.")


    try:
        preload_static_cache()
    except Exception as e:
        print(f"[CACHE PRELOAD WARN] {e}")

    httpd = FastThreadingHTTPServer(("0.0.0.0", HTTP_PORT), WebAppHandler)
    print(f"[HTTP Server] Serving {WEB_DIR} on port {HTTP_PORT}...")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nShutting down server...")
        httpd.shutdown()

if __name__ == '__main__':
    main()
