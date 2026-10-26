import http.server
from http.server import ThreadingHTTPServer, SimpleHTTPRequestHandler
import socketserver
import json
import random
import time
import datetime
import os
import sys
import urllib.request
import threading
import pymysql

try:
    sys.stdout.reconfigure(encoding='utf-8', line_buffering=True)
    sys.stderr.reconfigure(encoding='utf-8', line_buffering=True)
except Exception:
    pass

SHOP_PORT = int(os.environ.get("SHOP_PORT", 8082))
MAIN_SERVER_URL = os.environ.get("MAIN_SERVER_URL", "http://127.0.0.1:8080")
CHAT_SERVER_URL = os.environ.get("CHAT_SERVER_URL", "http://127.0.0.1:8084")

DB_CONFIG = {
    'host': '127.0.0.1',
    'user': 'root',
    'password': '',
    'database': 'yugioh_game',
    'charset': 'utf8mb4',
    'autocommit': True
}

def get_db():
    conn = pymysql.connect(**DB_CONFIG, cursorclass=pymysql.cursors.DictCursor)
    conn.autocommit(True)
    return conn

# Thematic GR cards for Liya packages
LIYA_PACKAGE_GR = {
    1: [11166, 11463],  # Dịch chuyển cực đại, Gangjiaxia
    2: [20512, 11280],  # Gagaga Điện Kích, Gagaga Em Gái
    3: [30259, 20142],  # Vô hiệu, Rũ bỏ
    4: [11354, 20551],  # Harpie Điều Chế, Dung Hợp Mắt Đỏ
    5: [11387, 20552],  # Gishki Tà Ác Bốn Tay Ăn Thịt, Nghi Thức Mắt Đỏ
    6: [11424, 40265],  # Người Cầm Trượng Song Xà Nhập Ma, Nhập Ma Long Tổ·Ophion
    7: [40336, 11463],  # Tinh Vân Xinyuxia, Anh Hùng Nguyên Tố·Gangjiaxia
    8: [11513, 20640],  # Đọa Thiên Sứ Ixchel, Đao Xoáy Quán Tính Harpie
    9: [11559, 11560],  # Pháp Sư Giác Ngộ, Tinh Thể Phong Tấn·Synchro
    10: [11603, 11602], # Hấp Huyết Quỷ Hoàng·Bram, Lãnh Chúa Hấp Huyết Quỷ
    11: [11648, 11647], # Nguyệt Quang Vũ Báo Cơ, Nguyệt Quang Báo Cơ
    12: [11690, 11691], # Mắt Đỏ Bất Tử Long, Chiêu Hồn Thi Ma
    13: [11746, 11747], # Kỵ Sĩ Huyễn Ảnh·Gãy Kiếm, Kỵ Sĩ Huyễn Ảnh·Kiếm Bụi Gai
    14: [12003, 12004], # Thần Cơ Ma Vương Thần Giáng Lâm, Thần Cơ Ma Long
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
SERVER_EXTRA_CARDS_MAP = {}
SERVER_EXPANSION_CARDS_MAP = {}
SERVER_FAIRY_HERO_CARDS_MAP = {}
PACK_QUALITY_DISTRIBUTION = {}
ANCIENT_CARD_IDS = set()
FIXED_DEPOT_PRICES = {}

def load_pack_mappings():
    global SERVER_LIYA_CARDS_MAP, SERVER_CHAR_CARDS_MAP, SERVER_EXTRA_CARDS_MAP, SERVER_EXPANSION_CARDS_MAP, SERVER_FAIRY_HERO_CARDS_MAP, PACK_QUALITY_DISTRIBUTION, ANCIENT_CARD_IDS, FIXED_DEPOT_PRICES
    base_dir = os.path.dirname(os.path.abspath(__file__))
    liya_path = os.path.join(base_dir, 'liya_cards_map.json')
    char_path = os.path.join(base_dir, 'char_cards_map.json')
    extra_path = os.path.join(base_dir, 'extra_cards_map.json')
    expansion_path = os.path.join(base_dir, 'expansion_cards_map.json')
    pack_dist_path = os.path.join(base_dir, 'pack_quality_distribution.json')
    prices_path = os.path.join(base_dir, 'fixed_depot_prices.json')
    ancient_path = os.path.join(base_dir, 'web', 'data', 'ancient_products.lua')

    try:
        if os.path.isfile(ancient_path):
            with open(ancient_path, 'r', encoding='utf-8') as f:
                _at = f.read()
            import re
            ANCIENT_CARD_IDS = set(int(m.group(1)) for m in re.finditer(r'\[\"_cardId\"\]=(\d+)', _at))
            print(f"[SHOP SERVER] Loaded {len(ANCIENT_CARD_IDS)} Ancient Card IDs.")
    except Exception as e:
        print(f"[SHOP SERVER] Error loading ancient_products.lua: {e}")

    try:
        if os.path.isfile(liya_path):
            with open(liya_path, 'r', encoding='utf-8') as f:
                _lm = json.load(f)
                SERVER_LIYA_CARDS_MAP = {int(k): [int(x) for x in v] for k, v in _lm.items()}
            print(f"[SHOP SERVER] Loaded {len(SERVER_LIYA_CARDS_MAP)} Liya pack mappings.")
    except Exception as e:
        print(f"[SHOP SERVER] Error loading liya_cards_map.json: {e}")

    try:
        if os.path.isfile(char_path):
            with open(char_path, 'r', encoding='utf-8') as f:
                _cm = json.load(f)
                SERVER_CHAR_CARDS_MAP = {int(k): [int(x) for x in v] for k, v in _cm.items()}
            print(f"[SHOP SERVER] Loaded {len(SERVER_CHAR_CARDS_MAP)} Character pack mappings.")
    except Exception as e:
        print(f"[SHOP SERVER] Error loading char_cards_map.json: {e}")

    try:
        if os.path.isfile(extra_path):
            with open(extra_path, 'r', encoding='utf-8') as f:
                _em = json.load(f)
                SERVER_EXTRA_CARDS_MAP = {int(k): [int(x) for x in v] for k, v in _em.items()}
            print(f"[SHOP SERVER] Loaded {len(SERVER_EXTRA_CARDS_MAP)} Extra pack mappings.")
    except Exception as e:
        print(f"[SHOP SERVER] Error loading extra_cards_map.json: {e}")

    try:
        if os.path.isfile(expansion_path):
            with open(expansion_path, 'r', encoding='utf-8') as f:
                _exm = json.load(f)
                SERVER_EXPANSION_CARDS_MAP = {int(k): [int(x) for x in v] for k, v in _exm.items()}
            print(f"[SHOP SERVER] Loaded {len(SERVER_EXPANSION_CARDS_MAP)} Expansion pack mappings.")
    except Exception as e:
        print(f"[SHOP SERVER] Error loading expansion_cards_map.json: {e}")

    try:
        fairy_hero_path = os.path.join(base_dir, 'fairy_hero_cards_map.json')
        if os.path.isfile(fairy_hero_path):
            with open(fairy_hero_path, 'r', encoding='utf-8') as f:
                _fhm = json.load(f)
                SERVER_FAIRY_HERO_CARDS_MAP = {int(k): [int(x) for x in v] for k, v in _fhm.items()}
            print(f"[SHOP SERVER] Loaded {len(SERVER_FAIRY_HERO_CARDS_MAP)} Fairy Hero pack mappings.")
    except Exception as e:
        print(f"[SHOP SERVER] Error loading fairy_hero_cards_map.json: {e}")

    try:
        if os.path.isfile(pack_dist_path):
            with open(pack_dist_path, 'r', encoding='utf-8') as f:
                _pdm = json.load(f)
                PACK_QUALITY_DISTRIBUTION = {int(k): v for k, v in _pdm.items()}
            print(f"[SHOP SERVER] Loaded {len(PACK_QUALITY_DISTRIBUTION)} Pack Quality Distributions.")
    except Exception as e:
        print(f"[SHOP SERVER] Error loading pack_quality_distribution.json: {e}")

    try:
        if os.path.isfile(prices_path):
            with open(prices_path, 'r', encoding='utf-8') as f:
                _pm = json.load(f)
                FIXED_DEPOT_PRICES = {int(k): int(v) for k, v in _pm.items()}
            print(f"[SHOP SERVER] Loaded {len(FIXED_DEPOT_PRICES)} Fixed Depot prices.")
    except Exception as e:
        print(f"[SHOP SERVER] Error loading fixed_depot_prices.json: {e}")

ALL_CARDS_MAP = {}
ALL_CARDS_BY_QUALITY = {'GR': [], 'UR': [], 'SR': [], 'R': [], 'N': []}
ALL_SR_AND_BELOW_CARDS = []
ALL_CARD_MAX_COUNTS = {}
ALL_SHOP_PRODUCTS = {
    'depot': {},
    'rare': {},
    'diamond': {},
    'union': {},
    'collect': {},
    'ancient': {},
    'vote': {},
    'goods': {},
    'privilege': {}
}

def parse_lua_products(fp):
    items = {}
    if not os.path.exists(fp):
        return items
    try:
        with open(fp, 'r', encoding='utf-8', errors='ignore') as f:
            txt = f.read()
        import re
        for m in re.finditer(r'\[(\d+)\]\s*=\s*\{([^}]+)\}', txt):
            pid = int(m.group(1))
            d = {}
            for p in re.finditer(r'\[\"_(\w+)\"\]\s*=\s*([^,]+)', m.group(2)):
                val = p.group(2).strip().strip('"')
                try:
                    if '.' in val: val = float(val)
                    else: val = int(val)
                except: pass
                d[p.group(1)] = val
            items[pid] = d
    except Exception as e:
        print(f"[SHOP LOAD ERROR] {fp}: {e}")
    return items

def load_all_shop_data():
    global ALL_SHOP_PRODUCTS
    web_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "web")
    data_dir = os.path.join(web_dir, "data")
    file_map = {
        'depot': 'products_ex.lua',
        'rare': 'rare_products.lua',
        'diamond': 'diamond_products.lua',
        'union': 'union_products_ex.lua',
        'collect': 'collection_products.lua',
        'ancient': 'ancient_products.lua',
        'vote': 'vote_products.lua',
        'goods': 'products.lua',
        'privilege': 'privilege_products.lua'
    }
    for stype, fname in file_map.items():
        fp = os.path.join(data_dir, fname)
        ALL_SHOP_PRODUCTS[stype] = parse_lua_products(fp)
    print(f"[SHOP SERVER] Loaded products: {', '.join(f'{k}:{len(v)}' for k, v in ALL_SHOP_PRODUCTS.items())}")

def init_global_cards(cur=None):
    global ALL_CARDS_MAP, ALL_CARDS_BY_QUALITY, ALL_SR_AND_BELOW_CARDS, ALL_CARD_MAX_COUNTS
    def _do(cursor):
        global ALL_CARDS_MAP, ALL_CARDS_BY_QUALITY, ALL_SR_AND_BELOW_CARDS, ALL_CARD_MAX_COUNTS
        cursor.execute("""
            SELECT id, name, quality, max_count FROM (
                SELECT id, name, quality, max_count FROM card_monsters
                UNION ALL SELECT id, name, quality, max_count FROM card_spells
                UNION ALL SELECT id, name, quality, max_count FROM card_traps
                UNION ALL SELECT id, name, quality, 3 AS max_count FROM card_extra
            ) AS all_cards
        """)
        rows = cursor.fetchall()
        ALL_CARDS_MAP.clear()
        ALL_CARD_MAX_COUNTS.clear()
        for q in ALL_CARDS_BY_QUALITY:
            ALL_CARDS_BY_QUALITY[q].clear()
        ALL_SR_AND_BELOW_CARDS.clear()
        for r in rows:
            cid = int(r['id'])
            cname = r['name']
            cq = (r['quality'] or 'N').upper()
            m_cnt = r.get('max_count')
            ALL_CARD_MAX_COUNTS[cid] = int(m_cnt) if m_cnt is not None else 3
            cobj = {'id': cid, 'name': cname, 'quality': cq}
            ALL_CARDS_MAP[cid] = cobj
            if cq in ALL_CARDS_BY_QUALITY:
                ALL_CARDS_BY_QUALITY[cq].append(cobj)
            else:
                ALL_CARDS_BY_QUALITY['N'].append(cobj)
            if cq in ('SR', 'R', 'N'):
                ALL_SR_AND_BELOW_CARDS.append(cobj)
        ALL_CARD_MAX_COUNTS[12171] = 1
        ALL_CARD_MAX_COUNTS[12172] = 1
        ALL_CARD_MAX_COUNTS[40686] = 2
        print(f"[SHOP SERVER] Loaded {len(ALL_CARDS_MAP)} total cards into memory cache (GR: {len(ALL_CARDS_BY_QUALITY['GR'])}, UR: {len(ALL_CARDS_BY_QUALITY['UR'])}, SR: {len(ALL_CARDS_BY_QUALITY['SR'])}, R: {len(ALL_CARDS_BY_QUALITY['R'])}, N: {len(ALL_CARDS_BY_QUALITY['N'])}).")

    try:
        if cur:
            _do(cur)
        else:
            with get_db() as conn:
                with conn.cursor() as c:
                    _do(c)
    except Exception as e:
        print(f"[SHOP SERVER] Error loading global cards into memory: {e}")

load_pack_mappings()
load_all_shop_data()
try:
    init_global_cards()
except Exception as e:
    print(f"[SHOP SERVER] init_global_cards at startup failed: {e}")

LIYA_PACKAGE_GR = {
    1: [10270, 10293],
    2: [10304, 10305],
    3: [10306, 10307],
    4: [10308, 10407],
    5: [10446, 10639],
    6: [10763, 10790],
    7: [10895, 10896],
    8: [10902, 10967],
    9: [10969, 11083],
    10: [11145, 11225],
    11: [11308, 11338],
    12: [11365, 11513],
    13: [11662, 11695],
    14: [11853, 11934],
    15: [12006, 12142],
    16: [12181, 20142],
    17: [20233, 20352],
    18: [20549, 20551],
    19: [20552, 20566],
    20: [20641, 20711]
}

CHAR_PACKAGE_GR = {
    3: [30383, 20742],
    2: [40250, 20779],
    5: [20551, 11365],
    15: [40336, 21046],
    11201: [40336, 21046],
    11210: [40336, 21046],
    11250: [40336, 21046],
    12: [40336, 21046],
    18: [11513, 21100],
    16: [20778],
    8: [10407],
    11: [10763]
}

def resolve_pack_cards(pkg_num, req_pool=None):
    cards = []
    # 1. Custom 60+ pack mappings always take precedence
    if pkg_num in SERVER_CHAR_CARDS_MAP:
        cards = SERVER_CHAR_CARDS_MAP[pkg_num]
    elif pkg_num in SERVER_LIYA_CARDS_MAP:
        cards = SERVER_LIYA_CARDS_MAP[pkg_num]
    elif pkg_num in SERVER_EXTRA_CARDS_MAP:
        cards = SERVER_EXTRA_CARDS_MAP[pkg_num]
    elif pkg_num in SERVER_EXPANSION_CARDS_MAP:
        cards = SERVER_EXPANSION_CARDS_MAP[pkg_num]
    elif pkg_num in SERVER_FAIRY_HERO_CARDS_MAP:
        cards = SERVER_FAIRY_HERO_CARDS_MAP[pkg_num]
    elif 10201 <= pkg_num <= 12150:
        base_val = ((pkg_num - 10000) // 100) * 100 + 10001
        cards = SERVER_CHAR_CARDS_MAP.get(pkg_num) or SERVER_CHAR_CARDS_MAP.get(base_val) or []
    elif 101001 <= pkg_num <= 120050:
        prefix = (pkg_num // 1000) * 1000
        base_val = prefix + 10
        cards = SERVER_LIYA_CARDS_MAP.get(pkg_num) or SERVER_LIYA_CARDS_MAP.get(base_val) or []
    elif 121001 <= pkg_num <= 174050:
        prefix = (pkg_num // 1000) * 1000
        base_val = prefix + 10
        cards = SERVER_EXTRA_CARDS_MAP.get(pkg_num) or SERVER_EXTRA_CARDS_MAP.get(base_val) or []
    elif 181001 <= pkg_num <= 210050:
        prefix = (pkg_num // 1000) * 1000
        base_val = prefix + 10
        cards = SERVER_EXPANSION_CARDS_MAP.get(pkg_num) or SERVER_EXPANSION_CARDS_MAP.get(base_val) or []
    elif 221001 <= pkg_num <= 230050:
        prefix = (pkg_num // 1000) * 1000
        base_val = prefix + 10
        cards = SERVER_FAIRY_HERO_CARDS_MAP.get(pkg_num) or SERVER_FAIRY_HERO_CARDS_MAP.get(base_val) or []

    # 2. Fallback to client req_pool if no server mapping found
    if not cards and req_pool and len(req_pool) > 0:
        cards = req_pool

    return [int(x) for x in cards if int(x) in ALL_CARDS_MAP]

def execute_pack_lottery(pkg_num, total_cards, user_pity, req_pool, user_acc, broadcast_fn=None, user_tru_tien_pity=0, user_gr_pity=None):
    curr_gr_pity = int(user_gr_pity if user_gr_pity is not None else (user_tru_tien_pity or 0))
    is_tru_tien = (221001 <= pkg_num <= 221050) or (pkg_num == 1)
    is_tien_nghich = (222001 <= pkg_num <= 222050) or (pkg_num == 2)
    is_kmr = (223001 <= pkg_num <= 223050) or (pkg_num == 3)
    is_minecraft = (224001 <= pkg_num <= 224050) or (pkg_num == 4)
    is_fairy_hero = is_tru_tien or is_tien_nghich or is_kmr or is_minecraft or (pkg_num in SERVER_FAIRY_HERO_CARDS_MAP)
    if is_fairy_hero:
        if is_minecraft or (pkg_num in (4, 224001, 224010, 224050)):
            series_name = "Minecraft"
            gr_pool = [12339, 40753]
            ur_pool = [12337, 12338, 12340, 12341, 12342, 12343, 12344, 12345, 12346, 12347, 21148, 21149, 21150, 30596, 30597, 40747, 40748, 40749, 40750, 40751, 40752, 40754]
        elif is_kmr or (pkg_num in (3, 223001, 223010, 223050)):
            series_name = "Hiệp sĩ mặt nạ"
            gr_pool = [40739]
            ur_pool = [12331, 12332, 12333, 12334, 12335, 21143, 21144, 40734, 40735, 40737, 40738, 40740, 40741]
        elif is_tien_nghich or (pkg_num in (2, 222001, 222010, 222050)):
            series_name = "Tiên Nghịch"
            gr_pool = [40730]
            ur_pool = [12322, 12323, 12324, 12325, 12326, 12327, 12328, 12329, 21141, 21134, 40732, 21142, 40733]
        else:
            series_name = "Tru Tiên"
            gr_pool = [12316, 12320, 21139]
            ur_pool = [12314, 12315, 12317, 12318, 12319, 21135, 21136, 21137, 21138, 30244, 12321, 30593, 40728]
        r_pool = [10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004]
        n_pool = [10001, 10004, 10006, 10018, 10020]

        cards_won = []
        has_ur = False
        packs = max(1, (total_cards + 2) // 3)

        if total_cards >= 150:
            target_ur_count = random.choice([1, 2])
            all_indices = list(range(total_cards))
            random.shuffle(all_indices)
            ur_indices = set(all_indices[:target_ur_count])

            for p_idx in range(packs):
                curr_gr_pity += 1
                force_gr_in_pack = (curr_gr_pity >= 1500)
                card_base_idx = p_idx * 3
                gr_offset = random.randint(0, 2) if force_gr_in_pack else -1

                for offset in range(3):
                    card_idx = card_base_idx + offset
                    if card_idx >= total_cards:
                        break

                    roll = random.random()
                    if (force_gr_in_pack and offset == gr_offset) or (roll < 0.000005):
                        target_quality = 'GR'
                        picked_cid = random.choice(gr_pool)
                        curr_gr_pity = 0
                        force_gr_in_pack = False
                    elif card_idx in ur_indices:
                        target_quality = 'UR'
                        picked_cid = random.choice(ur_pool)
                        has_ur = True
                    else:
                        if random.random() < 0.60:
                            target_quality = 'R'
                            picked_cid = random.choice(r_pool)
                        else:
                            target_quality = 'N'
                            picked_cid = random.choice(n_pool)

                    picked = ALL_CARDS_MAP.get(picked_cid) or ALL_CARDS_MAP[10001]
                    cid = picked['id']
                    cname = picked['name']
                    cquality = picked['quality']

                    if cquality == 'GR':
                        curr_gr_pity = 0
                        char_name = user_acc.get('character_name', '') if user_acc else ''
                        if series_name in ("Hiệp sĩ mặt nạ", "Minecraft"):
                            announcement = f"[THÔNG BÁO] Chúc mừng bài thủ [{char_name}] vừa khai mở được {series_name} cấp GR [{cname}]!"
                        else:
                            announcement = f"[THÔNG BÁO] Chúc mừng bài thủ [{char_name}] vừa khai mở được Thần Khí {series_name} cấp GR [{cname}]!"
                        if broadcast_fn:
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
                            try:
                                broadcast_fn(broadcast_msg)
                            except Exception:
                                pass
                    cards_won.append({"info_id": cid, "num": 1, "name": cname, "quality": cquality})
            user_pity = 0.0
            return cards_won, user_pity, curr_gr_pity, has_ur
        else:
            ur_count_this_batch = 0
            for p_idx in range(packs):
                curr_gr_pity += 1
                force_gr_in_pack = (curr_gr_pity >= 1500)
                card_base_idx = p_idx * 3
                gr_offset = random.randint(0, 2) if force_gr_in_pack else -1

                for offset in range(3):
                    card_idx = card_base_idx + offset
                    if card_idx >= total_cards:
                        break

                    user_pity += (1.0 / 3.0)
                    force_ur = (user_pity >= 50.0) and (not has_ur)
                    roll = random.random()

                    if (force_gr_in_pack and offset == gr_offset) or (roll < 0.000005):
                        target_quality = 'GR'
                        picked_cid = random.choice(gr_pool)
                        curr_gr_pity = 0
                        force_gr_in_pack = False
                    elif force_ur or (roll < 0.010 and ur_count_this_batch < 2):
                        target_quality = 'UR'
                        picked_cid = random.choice(ur_pool)
                        has_ur = True
                        ur_count_this_batch += 1
                        user_pity = 0.0
                    else:
                        if random.random() < 0.60:
                            target_quality = 'R'
                            picked_cid = random.choice(r_pool)
                        else:
                            target_quality = 'N'
                            picked_cid = random.choice(n_pool)

                    if user_pity >= 50.0:
                        user_pity = 0.0

                    picked = ALL_CARDS_MAP.get(picked_cid) or ALL_CARDS_MAP[10001]
                    cid = picked['id']
                    cname = picked['name']
                    cquality = picked['quality']

                    if cquality == 'GR':
                        curr_gr_pity = 0
                        char_name = user_acc.get('character_name', '') if user_acc else ''
                        if series_name in ("Hiệp sĩ mặt nạ", "Minecraft"):
                            announcement = f"[THÔNG BÁO] Chúc mừng bài thủ [{char_name}] vừa khai mở được {series_name} cấp GR [{cname}]!"
                        else:
                            announcement = f"[THÔNG BÁO] Chúc mừng bài thủ [{char_name}] vừa khai mở được Thần Khí {series_name} cấp GR [{cname}]!"
                        if broadcast_fn:
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
                            try:
                                broadcast_fn(broadcast_msg)
                            except Exception:
                                pass
                    cards_won.append({"info_id": cid, "num": 1, "name": cname, "quality": cquality})
            return cards_won, user_pity, curr_gr_pity, has_ur

    # Determine base package ID for quality pools
    base_pkg_val = None
    if pkg_num in PACK_QUALITY_DISTRIBUTION:
        base_pkg_val = pkg_num
    elif 10201 <= pkg_num <= 12150:
        c_base = ((pkg_num - 10000) // 100) * 100 + 10001
        if c_base in PACK_QUALITY_DISTRIBUTION: base_pkg_val = c_base
    elif 101001 <= pkg_num <= 210050:
        prefix = (pkg_num // 1000) * 1000
        l_base = prefix + 10
        if l_base in PACK_QUALITY_DISTRIBUTION: base_pkg_val = l_base
    elif 1 <= pkg_num <= 54:
        c_val = 10100 + pkg_num * 100 + 1
        l_val = 100000 + pkg_num * 1000 + 10
        e_val = 120000 + pkg_num * 1000 + 10
        ex_val = 180000 + pkg_num * 1000 + 10
        if c_val in PACK_QUALITY_DISTRIBUTION: base_pkg_val = c_val
        elif l_val in PACK_QUALITY_DISTRIBUTION: base_pkg_val = l_val
        elif e_val in PACK_QUALITY_DISTRIBUTION: base_pkg_val = e_val
        elif ex_val in PACK_QUALITY_DISTRIBUTION: base_pkg_val = ex_val

    q_pools = None
    if base_pkg_val and base_pkg_val in PACK_QUALITY_DISTRIBUTION:
        q_pools = {k: list(v) for k, v in PACK_QUALITY_DISTRIBUTION[base_pkg_val].items()}

    pack_cids = resolve_pack_cards(pkg_num, req_pool)
    if not q_pools:
        q_pools = {'GR': [], 'UR_ANCIENT': [], 'UR': [], 'SR': [], 'R': [], 'N': []}
        for cid in pack_cids:
            c = ALL_CARDS_MAP.get(cid)
            if c:
                cq = (c.get('quality') or 'N').upper()
                if cq == 'GR': q_pools['GR'].append(cid)
                elif cid in ANCIENT_CARD_IDS: q_pools['UR_ANCIENT'].append(cid)
                elif cq == 'UR': q_pools['UR'].append(cid)
                elif cq == 'SR': q_pools['SR'].append(cid)
                elif cq == 'R': q_pools['R'].append(cid)
                else: q_pools['N'].append(cid)
    else:
        # Sync any newly mapped cards into q_pools so they are never missed
        existing_cids = set()
        for qk, qv in q_pools.items():
            existing_cids.update(qv)
        for cid in pack_cids:
            if cid not in existing_cids and cid in ALL_CARDS_MAP:
                c = ALL_CARDS_MAP[cid]
                cq = (c.get('quality') or 'N').upper()
                if cq == 'GR': q_pools.setdefault('GR', []).append(cid)
                elif cid in ANCIENT_CARD_IDS: q_pools.setdefault('UR_ANCIENT', []).append(cid)
                elif cq in ('UR', 'SR', 'R', 'N'): q_pools.setdefault(cq, []).append(cid)
                else: q_pools.setdefault('N', []).append(cid)
                existing_cids.add(cid)

    # Collect all valid card IDs in this pack for ultimate fallback
    all_pack_cids = []
    for qk in ['GR', 'UR_ANCIENT', 'UR', 'SR', 'R', 'N']:
        for cid in q_pools.get(qk, []):
            if cid in ALL_CARDS_MAP and cid not in all_pack_cids:
                all_pack_cids.append(cid)

    # Chỉ rút thẻ GR từ bể thẻ riêng của gói đó (Đã loại bỏ Ưu tiên 2 - Fallback toàn cục)
    pack_gr_pool = [cid for cid in q_pools.get('GR', []) if cid in ALL_CARDS_MAP]
    has_gr = bool(pack_gr_pool)

    cards_won = []
    has_ur = False
    packs = max(1, (total_cards + 2) // 3)

    for p_idx in range(packs):
        curr_gr_pity += 1
        force_gr_in_pack = (curr_gr_pity >= 1500) and has_gr
        gr_offset = random.randint(0, 2) if force_gr_in_pack else -1
        card_base_idx = p_idx * 3

        for offset in range(3):
            card_idx = card_base_idx + offset
            if card_idx >= total_cards:
                break

            user_pity += (1.0 / 3.0)
            force_ur = (user_pity >= 50.0) and (not has_ur)
            
            roll = random.random()
            # Drop rates:
            # GR: force pity >= 1000 OR natural 0.000005 (0.0005%)
            # UR Di tích cổ: 0.5% (0.005000)
            # UR thường: 2% (0.020000)
            # SR: 5% (0.050000)
            # R: 40% (0.400000)
            # N: 50% + remainder (~0.524995)
            if (force_gr_in_pack and offset == gr_offset) or (has_gr and roll < 0.000005):
                target_quality = 'GR'
                curr_gr_pity = 0
                force_gr_in_pack = False
            elif force_ur:
                target_quality = 'UR'
            elif roll < 0.005005:
                target_quality = 'UR_ANCIENT'
            elif roll < 0.025005:
                target_quality = 'UR'
            elif roll < 0.075005:
                target_quality = 'SR'
            elif roll < 0.475005:
                target_quality = 'R'
            else:
                target_quality = 'N'

            picked_cid = None
            if target_quality == 'GR':
                picked_cid = random.choice(pack_gr_pool) if pack_gr_pool else None
            elif target_quality == 'UR_ANCIENT':
                pool = q_pools.get('UR_ANCIENT') or q_pools.get('UR')
                picked_cid = random.choice(pool) if pool else None
            elif target_quality == 'UR':
                pool = q_pools.get('UR') or q_pools.get('UR_ANCIENT')
                picked_cid = random.choice(pool) if pool else None
            elif target_quality == 'SR':
                pool = q_pools.get('SR') or q_pools.get('R') or q_pools.get('N') or q_pools.get('UR')
                picked_cid = random.choice(pool) if pool else None
            elif target_quality == 'R':
                pool = q_pools.get('R') or q_pools.get('N') or q_pools.get('SR') or q_pools.get('UR')
                picked_cid = random.choice(pool) if pool else None
            else: # N
                pool = q_pools.get('N') or q_pools.get('R') or q_pools.get('SR') or q_pools.get('UR')
                picked_cid = random.choice(pool) if pool else None

            if not picked_cid and all_pack_cids:
                picked_cid = random.choice(all_pack_cids)

            picked = ALL_CARDS_MAP.get(picked_cid) if picked_cid else random.choice(list(ALL_CARDS_MAP.values()))
            cid = picked['id']
            cname = picked['name']
            cquality = picked['quality']

            # Check for ancient UR or GR announcement
            is_ancient_ur = (target_quality == 'UR_ANCIENT' or cid in ANCIENT_CARD_IDS)
            if cquality == 'GR' or is_ancient_ur or cquality == 'UR':
                user_pity = 0.0
                if cquality == 'UR':
                    has_ur = True

                char_name = user_acc.get('character_name', '') if user_acc else ''
                announcement = None
                if cquality == 'GR':
                    curr_gr_pity = 0
                    if is_ancient_ur:
                        announcement = f"[THÔNG BÁO] Chúc mừng bài thủ [{char_name}] vừa khai quật được bảo vật di tích cổ [{cname}]!"
                    else:
                        announcement = f"[THÔNG BÁO] Chúc mừng bài thủ [{char_name}] vừa rút được lá bài cấp GR thần thánh [{cname}]!"

                if announcement and broadcast_fn:
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
                    try:
                        broadcast_fn(broadcast_msg)
                    except Exception as b_ex:
                        print(f"[SHOP BROADCAST ERROR] {b_ex}")

            cards_won.append({"info_id": cid, "num": 1, "name": cname, "quality": cquality})

    return cards_won, user_pity, curr_gr_pity, has_ur



def notify_main_server_broadcast(broadcast_msg):
    """Gửi thông báo thẻ hiếm (GR/UR) sang Chat Server độc lập để lưu DB và phát WebSocket cho toàn bộ người chơi."""
    def _send():
        try:
            url = f"{CHAT_SERVER_URL}/api/chat_send"
            data = json.dumps(broadcast_msg, ensure_ascii=False).encode('utf-8')
            req = urllib.request.Request(url, data=data, headers={'Content-Type': 'application/json'}, method='POST')
            with urllib.request.urlopen(req, timeout=3) as resp:
                pass
        except Exception as e:
            print(f"[SHOP BROADCAST WARN] Cannot forward GR broadcast to chat server: {e}")
    threading.Thread(target=_send, daemon=True).start()


class ShopHTTPHandler(SimpleHTTPRequestHandler):
    def send_cors_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With')

    def do_OPTIONS(self):
        self.send_response(200)
        self.send_cors_headers()
        self.send_header('Content-Length', '0')
        self.end_headers()

    def do_GET(self):
        if self.path in ('/api/health', '/api/health/', '/health'):
            resp = {
                "status": "OK",
                "server": "yugioh_shop_server",
                "port": SHOP_PORT,
                "loaded_cards": len(ALL_CARDS_MAP),
                "timestamp": int(time.time())
            }
            body = json.dumps(resp).encode('utf-8')
            self.send_response(200)
            self.send_header('Content-Type', 'application/json; charset=utf-8')
            self.send_header('Content-Length', str(len(body)))
            self.send_cors_headers()
            self.end_headers()
            self.wfile.write(body)
            return

        if self.path in ('/api/reload_cache', '/api/reload', '/reload'):
            try:
                load_pack_mappings()
                load_all_shop_data()
                init_global_cards()
                resp = {
                    "code": 200,
                    "msg": "Shop server cache reloaded successfully",
                    "loaded_cards": len(ALL_CARDS_MAP),
                    "privilege_products": len(ALL_SHOP_PRODUCTS.get('privilege', {}))
                }
            except Exception as e:
                resp = {"code": 500, "msg": str(e)}
            body = json.dumps(resp, ensure_ascii=False).encode('utf-8')
            self.send_response(200)
            self.send_header('Content-Type', 'application/json; charset=utf-8')
            self.send_header('Content-Length', str(len(body)))
            self.send_cors_headers()
            self.end_headers()
            self.wfile.write(body)
            return
        
        if self.path.startswith('/api/online_count'):
            try:
                req_obj = urllib.request.Request(f"{MAIN_SERVER_URL}/api/online_count", headers={'User-Agent': 'ShopServer'})
                with urllib.request.urlopen(req_obj, timeout=1.5) as response:
                    body = response.read()
            except Exception:
                body = json.dumps({"code": 200, "count": 1}).encode('utf-8')
            self.send_response(200)
            self.send_header('Content-Type', 'application/json; charset=utf-8')
            self.send_header('Content-Length', str(len(body)))
            self.send_cors_headers()
            self.end_headers()
            self.wfile.write(body)
            return

        self.send_response(404)
        self.send_cors_headers()
        self.end_headers()
        self.wfile.write(b'{"code": 404, "msg": "Shop Server Endpoint Not Found"}')

    def do_POST(self):
        content_len = int(self.headers.get('Content-Length', 0))
        body = self.rfile.read(content_len).decode('utf-8') if content_len > 0 else "{}"
        try:
            req = json.loads(body) if body else {}
        except Exception:
            req = {}

        if self.path.startswith('/api/online_count'):
            try:
                req_obj = urllib.request.Request(f"{MAIN_SERVER_URL}/api/online_count", headers={'User-Agent': 'ShopServer'})
                with urllib.request.urlopen(req_obj, timeout=1.5) as response:
                    body = response.read()
            except Exception:
                body = json.dumps({"code": 200, "count": 1}).encode('utf-8')
            self.send_response(200)
            self.send_header('Content-Type', 'application/json; charset=utf-8')
            self.send_header('Content-Length', str(len(body)))
            self.send_cors_headers()
            self.end_headers()
            self.wfile.write(body)
            return

        resp = {"code": 404, "msg": "Unknown shop endpoint"}

        # -------------------------------------------------------------
        # 1. Rút Gói Bài / Mua Bài (Tavern / Gacha / Lottery)
        # -------------------------------------------------------------
        if self.path == '/api/shop_exchange_prop':
            acc_id = req.get('account_id') or req.get('user_id') or req.get('id')
            exchange_id = int(req.get('exchange_id') or req.get('id') or 1)
            count = int(req.get('count', 1))

            EXCHANGE_CONFIGS = {
                1: {
                    'name': 'Trò Chơi Ngàn Năm Đổi Slifer',
                    'req': {7031: 1, 7032: 1, 7033: 1, 7034: 1, 7035: 1, 7036: 1, 7037: 1},
                    'reward_type': 'card', 'reward_id': 10436, 'reward_count': 1
                },
                2: {
                    'name': 'Đổi 10 Gói Thẻ Bài',
                    'req': {7032: 1, 7034: 1, 7035: 1, 7036: 1, 7037: 1},
                    'reward_type': 'prop', 'reward_id': 7110, 'reward_count': 10
                },
                3: {
                    'name': 'Đổi Thẻ Bài Hiếm',
                    'req': {7033: 1, 7035: 1, 7036: 1, 7037: 1},
                    'reward_type': 'card', 'reward_id': 10430, 'reward_count': 1
                },
                4: {
                    'name': 'Đổi 100 Mảnh Ghép Thẻ',
                    'req': {7034: 1, 7036: 1, 7037: 1},
                    'reward_type': 'prop', 'reward_id': 7112, 'reward_count': 100
                },
                5: {
                    'name': 'Đổi 300 Kim Cương',
                    'req': {7035: 1, 7036: 1, 7037: 1},
                    'reward_type': 'ingot', 'reward_id': 1, 'reward_count': 300
                }
            }

            if not acc_id:
                resp = {"code": 400, "msg": "Missing account_id"}
            elif exchange_id not in EXCHANGE_CONFIGS:
                resp = {"code": 400, "msg": f"Invalid exchange_id {exchange_id}"}
            else:
                cfg = EXCHANGE_CONFIGS[exchange_id]
                with get_db() as conn:
                    with conn.cursor() as cur:
                        enough = True
                        for prop_id, need_qty in cfg['req'].items():
                            total_need = need_qty * count
                            cur.execute("SELECT count FROM user_props WHERE account_id = %s AND prop_id = %s", (acc_id, prop_id))
                            r = cur.fetchone()
                            cur_have = r['count'] if r else 0
                            if cur_have < total_need:
                                enough = False
                                break

                        if not enough:
                            resp = {"code": 400, "msg": "Không đủ bảo vật để đổi thưởng!"}
                        else:
                            for prop_id, need_qty in cfg['req'].items():
                                total_need = need_qty * count
                                cur.execute("UPDATE user_props SET count = count - %s WHERE account_id = %s AND prop_id = %s", (total_need, acc_id, prop_id))
                                cur.execute("DELETE FROM user_props WHERE account_id = %s AND prop_id = %s AND count <= 0", (acc_id, prop_id))

                            total_reward = cfg['reward_count'] * count
                            if cfg['reward_type'] == 'card':
                                cur.execute("""
                                    INSERT INTO user_cards (account_id, card_id, count)
                                    VALUES (%s, %s, %s)
                                    ON DUPLICATE KEY UPDATE count = count + %s
                                """, (acc_id, cfg['reward_id'], total_reward, total_reward))
                            elif cfg['reward_type'] == 'prop':
                                cur.execute("""
                                    INSERT INTO user_props (account_id, prop_id, count)
                                    VALUES (%s, %s, %s)
                                    ON DUPLICATE KEY UPDATE count = count + %s
                                """, (acc_id, cfg['reward_id'], total_reward, total_reward))
                            elif cfg['reward_type'] == 'ingot':
                                cur.execute("UPDATE accounts SET gem = gem + %s WHERE id = %s", (total_reward, acc_id))

                            cur.execute("SELECT prop_id, count FROM user_props WHERE account_id = %s", (acc_id,))
                            updated_props = {int(r['prop_id']): int(r['count']) for r in cur.fetchall()}

                            cur.execute("SELECT gem, gold FROM accounts WHERE id = %s", (acc_id,))
                            row = cur.fetchone()
                            if isinstance(row, dict):
                                acc_info = row
                            elif row:
                                acc_info = {'gem': row[0], 'gold': row[1]}
                            else:
                                acc_info = {}

                            resp = {
                                "code": 200,
                                "msg": f"Đổi {cfg['name']} thành công!",
                                "exchange_id": exchange_id,
                                "reward_type": cfg['reward_type'],
                                'reward_id': cfg['reward_id'],
                                'reward_count': total_reward,
                                'props': updated_props,
                                'ingot': acc_info.get('ingot', 0),
                                'gold': acc_info.get('gold', 0)
                            }
                            print(f"[BAOVAT EXCHANGE (SHOP)] Acc {acc_id} exchanged {cfg['name']} (x{count}) -> {cfg['reward_type']} {cfg['reward_id']} x{total_reward}")


        elif self.path == '/api/buy_package':
            acc_id = req.get('account_id')
            cost_type = req.get('cost_type', 'gold')
            raw_count = int(req.get('count', 1))
            package_id = req.get('package_id', 1)
            pkg_num = int(package_id) if str(package_id).isdigit() else 0

            if raw_count >= 10000:
                packs = raw_count % 100
                total_cards = packs * 3
            elif raw_count in (1, 10, 50):
                packs = raw_count
                total_cards = raw_count * 3
            else:
                total_cards = raw_count
                packs = max(1, total_cards // 3)
            if total_cards <= 0:
                total_cards = 3

            is_rare_or_extra = (101001 <= pkg_num <= 230050) or (pkg_num in SERVER_LIYA_CARDS_MAP) or (pkg_num in SERVER_EXTRA_CARDS_MAP) or (pkg_num in SERVER_EXPANSION_CARDS_MAP) or (pkg_num in SERVER_FAIRY_HERO_CARDS_MAP)
            cost_val = int(req.get('cost_val', 0))
            if is_rare_or_extra:
                expected_gold_cost = (28500 if packs >= 50 else (6000 if packs >= 10 else 600 * packs))
            else:
                expected_gold_cost = (22500 if packs >= 50 else (4500 if packs >= 10 else 500 * packs))

            if cost_type == 'gold' or cost_val <= 0:
                cost_val = expected_gold_cost

            with get_db() as conn:
                with conn.cursor() as cur:
                    cur.execute("SELECT gold, gem, pity_count, tru_tien_pity, gr_pity, character_name FROM accounts WHERE id = %s", (acc_id,))
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

                            raw_card_pool = req.get('card_pool') or []
                            req_pool = [int(x) for x in raw_card_pool if str(x).isdigit()]

                            user_pity = user_acc.get('pity_count', 0) or 0
                            user_gr_pity = user_acc.get('gr_pity', 0) or user_acc.get('tru_tien_pity', 0) or 0
                            cards_won, user_pity, user_gr_pity, has_ur = execute_pack_lottery(
                                pkg_num=pkg_num,
                                total_cards=total_cards,
                                user_pity=user_pity,
                                req_pool=req_pool,
                                user_acc=user_acc,
                                broadcast_fn=notify_main_server_broadcast,
                                user_tru_tien_pity=user_gr_pity,
                                user_gr_pity=user_gr_pity
                            )

                            # Batch save cards won
                            card_counts = {}
                            for c in cards_won:
                                ci = c['info_id']
                                card_counts[ci] = card_counts.get(ci, 0) + 1
                            for ci, cnt in card_counts.items():
                                cur.execute("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE count = count + %s", (acc_id, ci, cnt, cnt))

                            cur.execute("UPDATE accounts SET pity_count = %s, gr_pity = %s, tru_tien_pity = %s WHERE id = %s", (int(user_pity), int(user_gr_pity), int(user_gr_pity), acc_id))
                            conn.commit()
                            cur.execute("SELECT gold, gem, pity_count, gr_pity, tru_tien_pity FROM accounts WHERE id = %s", (acc_id,))
                            updated_acc = cur.fetchone()
                            resp = {
                                "code": 200,
                                "msg": "Mua thành công!",
                                "cards": cards_won,
                                "gold": updated_acc['gold'],
                                "gem": updated_acc['gem'],
                                "pity_count": updated_acc['pity_count'],
                                "tru_tien_pity": updated_acc.get('gr_pity', 0),
                                "gr_pity": updated_acc.get('gr_pity', 0)
                            }
                            print(f"[SHOP BUY PACKAGE] Account {acc_id} ({user_acc['character_name']}) drew {total_cards} cards. Pity UR: {int(user_pity)}/50, Pity GR: {int(user_gr_pity)}/1500. Won {len(cards_won)} cards.")

        # -------------------------------------------------------------
        # 2. Đổi Vàng Bằng Gem (/api/buy_gold)
        # -------------------------------------------------------------
        elif self.path == '/api/buy_gold':
            acc_id = req.get('account_id')
            tier = int(req.get('tier', 1))
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
                            resp = {"code": 400, "msg": "Không đủ Linh Thạch Cao Cấp để đổi Linh Thạch!"}
                        else:
                            new_gem = acc['gem'] - gem_cost
                            new_gold = acc['gold'] + gold_gain
                            cur.execute("UPDATE accounts SET gem = %s, gold = %s WHERE id = %s", (new_gem, new_gold, acc_id))
                            conn.commit()
                            resp = {
                                "code": 200,
                                "msg": f"Đổi thành công {gold_gain:,} Linh Thạch!",
                                "gold": new_gold,
                                "gem": new_gem
                            }
                            print(f"[SHOP BUY GOLD] Account {acc_id}: -{gem_cost} Gem, +{gold_gain} Gold -> new: {new_gold} Gold, {new_gem} Gem")
            else:
                resp = {"code": 400, "msg": "Missing account_id"}

        # -------------------------------------------------------------
        # 3. Mua Kho Chứa / Thẻ Kho (/api/buy_depot)
        # -------------------------------------------------------------
        elif self.path in ('/api/buy_depot', '/api/buy_card'):
            acc_id = req.get('account_id')
            card_id = int(req.get('card_id', 0))
            prod_id = int(req.get('product_id') or req.get('depot_id') or 0)
            count = max(1, min(3, int(req.get('count', 1))))
            shop_type = str(req.get('shop_type', 'depot')).lower()

            # Authoritative price resolution from server catalogs
            server_cost = 0
            server_cost_type = 1  # 1: gold, 3: gem
            is_legit_item = False

            special_fixed = {
                15: (12330, 7000, 3),
                16: (12336, 50000, 3),
                17: (40745, 20000, 3),
                59: (40209, 200000, 1),
                60: (20005, 5000, 1),
                61: (20051, 100000, 1),
                62: (20030, 100000, 1),
                63: (40713, 500000, 1),
                546: (12330, 7000, 3),
                547: (12336, 50000, 3),
                548: (40745, 20000, 3),
                583: (12330, 7000, 3),
            }
            if prod_id in special_fixed:
                card_id, server_cost, server_cost_type = special_fixed[prod_id]
                is_legit_item = True
            elif card_id == 40209:
                server_cost, server_cost_type, is_legit_item = 200000, 1, True
            elif card_id == 20005:
                server_cost, server_cost_type, is_legit_item = 5000, 1, True
            elif card_id == 20051:
                server_cost, server_cost_type, is_legit_item = 100000, 1, True
            elif card_id == 20030:
                server_cost, server_cost_type, is_legit_item = 100000, 1, True
            elif card_id == 40713:
                server_cost, server_cost_type, is_legit_item = 500000, 1, True
            elif card_id == 12248:
                server_cost, server_cost_type, is_legit_item = 500000, 1, True
            elif card_id == 12330:
                server_cost, server_cost_type, is_legit_item = 7000, 3, True
            elif card_id == 12336:
                server_cost, server_cost_type, is_legit_item = 50000, 3, True
            elif card_id == 40745:
                server_cost, server_cost_type, is_legit_item = 20000, 3, True
            elif card_id == 30592:
                server_cost, server_cost_type, is_legit_item = 50000, 3, True
            elif card_id == 40731:
                server_cost, server_cost_type, is_legit_item = 5000, 3, True
            elif card_id == 40732:
                server_cost, server_cost_type, is_legit_item = 5000, 3, True
            elif prod_id > 0:
                pool = ALL_SHOP_PRODUCTS.get(shop_type, {})
                pinfo = pool.get(prod_id)
                if not pinfo:
                    for st, sp in ALL_SHOP_PRODUCTS.items():
                        if prod_id in sp:
                            pinfo = sp[prod_id]
                            break
                if pinfo:
                    cid = int(pinfo.get('cardId', 0) or pinfo.get('infoId', 0))
                    c_cost = int(pinfo.get('cost', 0) or pinfo.get('price', 0))
                    c_type = pinfo.get('resType', 1)
                    if cid > 0 and c_cost > 0:
                        card_id = cid
                        server_cost = c_cost
                        server_cost_type = c_type
                        is_legit_item = True

            if not is_legit_item and card_id in FIXED_DEPOT_PRICES:
                f_cost = FIXED_DEPOT_PRICES[card_id]
                if f_cost > 0:
                    server_cost = f_cost
                    server_cost_type = 1
                    is_legit_item = True

            card_info = ALL_CARDS_MAP.get(card_id)
            is_gr = (card_info and card_info.get('quality') == 'GR' and card_id != 12336)

            if not acc_id or card_id <= 0:
                resp = {"code": 400, "msg": "Thông tin thẻ bài hoặc tài khoản không hợp lệ!"}
            elif not is_legit_item or server_cost <= 0:
                resp = {"code": 400, "msg": "Thẻ bài này không được bán trong Shop!"}
                print(f"[SECURITY BLOCKED] Account {acc_id} tried to buy unlisted card {card_id} (cost={server_cost})")
            elif is_gr:
                resp = {"code": 403, "msg": "Thẻ bài cấp GR không thể mua trực tiếp từ Shop!"}
                print(f"[SECURITY BLOCKED] Account {acc_id} tried to buy GR card {card_id}!")
            elif card_id in (12333, 20230, 12334, 21144) and int(acc_id) not in (6, 640, 1454, 10002550):
                resp = {"code": 403, "msg": "Thẻ bài độc quyền này chỉ dành riêng cho Shiuliuliu!"}
                print(f"[SECURITY BLOCKED] Account {acc_id} tried to buy exclusive card {card_id}!")
            else:
                total_cost = server_cost * count
                is_gold = (server_cost_type in (1, '1', 'gold'))
                is_gem = (server_cost_type in (3, '3', 'gem', 'diamond', 'ingot', 7339, '7339', 7114, '7114'))
                is_yubi = (server_cost_type in (7024, '7024', 'yubi', 'union_crystal'))

                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("SELECT status, gold, gem, character_name FROM accounts WHERE id = %s", (acc_id,))
                        acc = cur.fetchone()
                        if not acc or acc.get('status', 1) == 0:
                            resp = {"code": 403, "msg": "Tài khoản không tồn tại hoặc đã bị khóa!"}
                        else:
                            cur.execute("SELECT count FROM user_cards WHERE account_id = %s AND card_id = %s", (acc_id, card_id))
                            card_row = cur.fetchone() or {}
                            cur_owned = card_row.get('count', 0)
                            max_allowed = ALL_CARD_MAX_COUNTS.get(card_id, 3)

                            cur_yubi = 0
                            if is_yubi:
                                cur.execute("SELECT count FROM user_props WHERE account_id = %s AND prop_id = 7024", (acc_id,))
                                yrow = cur.fetchone()
                                cur_yubi = yrow['count'] if yrow else 0

                            union_level = 0
                            if shop_type == 'union' or is_yubi:
                                cur.execute("""
                                    SELECT u.level 
                                    FROM union_members um 
                                    JOIN unions u ON um.union_id = u.id 
                                    WHERE um.account_id = %s
                                """, (acc_id,))
                                urow = cur.fetchone()
                                union_level = urow['level'] if urow else 0

                            if shop_type == 'union' and union_level < 5:
                                resp = {"code": 403, "msg": "Guild cần đạt cấp 5 trở lên để mở khóa Shop Bài Guild 1!"}
                            elif cur_owned >= max_allowed:
                                resp = {"code": 400, "msg": f"Bạn đã sở hữu tối đa {max_allowed} bản sao của thẻ bài này!"}
                            elif cur_owned + count > max_allowed:
                                resp = {"code": 400, "msg": f"Chỉ có thể mua thêm {max_allowed - cur_owned} bản sao nữa!"}
                            elif is_gold and acc['gold'] < total_cost:
                                resp = {"code": 400, "msg": f"Không đủ Vàng / Linh Thạch! (Cần {total_cost:,}, có {acc['gold']:,})"}
                            elif is_gem and acc['gem'] < total_cost:
                                resp = {"code": 400, "msg": f"Không đủ Gem / Kim Cương! (Cần {total_cost:,}, có {acc['gem']:,})"}
                            elif is_yubi and cur_yubi < total_cost:
                                resp = {"code": 400, "msg": f"Không đủ Ma Tinh Công Hội! (Cần {total_cost:,}, hiện có {cur_yubi:,})"}
                            else:
                                if is_gold and total_cost > 0:
                                    cur.execute("UPDATE accounts SET gold = gold - %s WHERE id = %s", (total_cost, acc_id))
                                elif is_gem and total_cost > 0:
                                    cur.execute("UPDATE accounts SET gem = gem - %s WHERE id = %s", (total_cost, acc_id))
                                elif is_yubi and total_cost > 0:
                                    cur.execute("UPDATE user_props SET count = count - %s WHERE account_id = %s AND prop_id = 7024", (total_cost, acc_id))
                                    cur.execute("SELECT count FROM user_props WHERE account_id = %s AND prop_id = 7024", (acc_id,))
                                    yrow = cur.fetchone()
                                    cur_yubi = yrow['count'] if yrow else 0

                                cur.execute("""
                                    INSERT INTO user_cards (account_id, card_id, count)
                                    VALUES (%s, %s, %s)
                                    ON DUPLICATE KEY UPDATE count = count + %s
                                """, (acc_id, card_id, count, count))
                                conn.commit()

                                cur.execute("SELECT gold, gem FROM accounts WHERE id = %s", (acc_id,))
                                updated_acc = cur.fetchone() or {}
                                final_count = cur_owned + count

                                resp = {
                                    "code": 200,
                                    "msg": "Mua thẻ bài thành công!",
                                    "card_id": card_id,
                                    "count": final_count,
                                    "bought_count": count,
                                    "gold": updated_acc.get('gold', 0),
                                    "gem": updated_acc.get('gem', 0),
                                    "yubi": cur_yubi
                                }
                                cost_desc = f"{total_cost} Ma Tinh" if is_yubi else (f"{total_cost} Gold" if is_gold else f"{total_cost} Gem")
                                print(f"[SHOP BUY CARD SUCCESS] Account {acc_id} ({acc['character_name']}) bought {count}x card {card_id} for {cost_desc}. Total owned: {final_count}, remaining yubi: {cur_yubi}.")

        # -------------------------------------------------------------
        # 4. Nhận Mã Quà Tặng Giftcode
        # -------------------------------------------------------------
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
                            cur.execute("SELECT id, username, character_name, gem, gold FROM accounts WHERE id = %s", (acc_id,))
                            acc = cur.fetchone()
                            if not acc:
                                resp = {"code": 404, "msg": "Tài khoản không tồn tại!"}
                            else:
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

                                        # Parse and grant cards if present
                                        card_items = []
                                        if reward_cards:
                                            try:
                                                parsed = json.loads(reward_cards)
                                                if isinstance(parsed, list):
                                                    for item in parsed:
                                                        if isinstance(item, dict):
                                                            cid = int(item.get('card_id') or item.get('id') or item.get('info_id') or 0)
                                                            cnt = int(item.get('count') or item.get('num') or 1)
                                                            if cid > 0:
                                                                card_items.append((cid, cnt))
                                                        elif isinstance(item, (int, str)):
                                                            cid = int(item)
                                                            if cid > 0:
                                                                card_items.append((cid, 1))
                                            except Exception:
                                                for part in str(reward_cards).split(','):
                                                    part = part.strip()
                                                    if not part: continue
                                                    if ':' in part:
                                                        p_cid, p_cnt = part.split(':', 1)
                                                        card_items.append((int(p_cid.strip()), int(p_cnt.strip())))
                                                    else:
                                                        card_items.append((int(part), 1))

                                        for cid, cnt in card_items:
                                            cur.execute("""
                                                INSERT INTO user_cards (account_id, card_id, count)
                                                VALUES (%s, %s, %s)
                                                ON DUPLICATE KEY UPDATE count = count + %s
                                            """, (acc_id, cid, cnt, cnt))

                                        cur.execute("""
                                            UPDATE accounts
                                            SET gem = gem + %s, gold = gold + %s
                                            WHERE id = %s
                                        """, (reward_gem, reward_gold, acc_id))

                                        cur.execute("""
                                            INSERT INTO gift_code_redemptions
                                            (code_id, code, account_id, reward_gem, reward_gold, reward_cards)
                                            VALUES (%s, %s, %s, %s, %s, %s)
                                        """, (gcode['id'], gcode['code'], acc_id, reward_gem, reward_gold, reward_cards))

                                        cur.execute("""
                                            UPDATE gift_codes
                                            SET current_uses = current_uses + 1
                                            WHERE id = %s
                                        """, (gcode['id'],))
                                        conn.commit()

                                        cur.execute("SELECT gem, gold FROM accounts WHERE id = %s", (acc_id,))
                                        updated_acc = cur.fetchone()
                                        new_gem = updated_acc['gem'] if updated_acc else acc['gem'] + reward_gem
                                        new_gold = updated_acc['gold'] if updated_acc else acc['gold'] + reward_gold

                                        rewards = []
                                        if reward_gem > 0:
                                            rewards.append({"info_id": 3, "num": reward_gem, "is_fragment": False, "level": 1})
                                        if reward_gold > 0:
                                            rewards.append({"info_id": 1, "num": reward_gold, "is_fragment": False, "level": 1})
                                        for cid, cnt in card_items:
                                            rewards.append({
                                                "info_id": cid,
                                                "num": cnt,
                                                "is_fragment": False,
                                                "level": 1
                                            })

                                        msg_parts = []
                                        if reward_gold > 0:
                                            msg_parts.append(f"{reward_gold:,} Linh Thạch")
                                        if reward_gem > 0:
                                            msg_parts.append(f"{reward_gem:,} Gem")
                                        for cid, cnt in card_items:
                                            cname = ALL_CARDS_MAP.get(cid, {}).get('name', f'Thẻ bài {cid}')
                                            msg_parts.append(f"x{cnt} lá [{cname}]")

                                        if msg_parts:
                                            reward_msg = "Đổi quà thành công! Nhận " + ", ".join(msg_parts) + "!"
                                        else:
                                            reward_msg = "Đổi quà thành công!"

                                        print(f"[SHOP GIFT CODE] Account {acc_id} redeemed '{gcode['code']}': +{reward_gem} gem, +{reward_gold} gold, +{len(card_items)} card types")
                                        resp = {
                                            "code": 200,
                                            "msg": reward_msg,
                                            "rewards": rewards,
                                            "new_gem": new_gem,
                                            "new_gold": new_gold
                                        }

        # -------------------------------------------------------------
        # 5. Điểm Danh Hàng Ngày (/api/checkin)
        # -------------------------------------------------------------
        elif self.path == '/api/checkin':
            acc_id = req.get('account_id')
            checkin_type = int(req.get('checkin_type', 1))
            day_index = int(req.get('day_index', 1))
            day_val = int(req.get('day_val', 0))

            if (3001 <= day_index <= 3007) or checkin_type == 2:
                checkin_type = 2
            else:
                checkin_type = 1

            with get_db() as conn:
                with conn.cursor() as cur:
                    if checkin_type == 2:
                        cur.execute("""
                            SELECT day_index FROM user_checkin
                            WHERE account_id = %s AND checkin_type = 2 AND claim_date = CURDATE()
                            LIMIT 1
                        """, (acc_id,))
                        if cur.fetchone():
                            resp = {"code": 400, "msg": "Hôm nay bạn đã điểm danh 7 ngày rồi! Hãy quay lại vào ngày mai."}
                            body = json.dumps(resp, ensure_ascii=False).encode('utf-8')
                            self.send_response(400)
                            self.send_header('Content-Type', 'application/json; charset=utf-8')
                            self.send_header('Content-Length', str(len(body)))
                            self.send_cors_headers()
                            self.end_headers()
                            self.wfile.write(body)
                            return
                    else:
                        cur.execute("""
                            SELECT day_index FROM user_checkin
                            WHERE account_id = %s AND checkin_type = 1 AND claim_date = CURDATE()
                            LIMIT 1
                        """, (acc_id,))
                        if cur.fetchone():
                            resp = {"code": 400, "msg": "Hôm nay bạn đã điểm danh tháng rồi! Hãy quay lại vào ngày mai."}
                            body = json.dumps(resp, ensure_ascii=False).encode('utf-8')
                            self.send_response(400)
                            self.send_header('Content-Type', 'application/json; charset=utf-8')
                            self.send_header('Content-Length', str(len(body)))
                            self.send_cors_headers()
                            self.end_headers()
                            self.wfile.write(body)
                            return

                    cur.execute("""
                        INSERT IGNORE INTO user_checkin (account_id, checkin_type, day_index, claim_date)
                        VALUES (%s, %s, %s, CURDATE())
                    """, (acc_id, checkin_type, day_index))

                    if checkin_type == 2:
                        if 3001 <= day_index <= 3007:
                            cur.execute("""
                                INSERT IGNORE INTO user_checkin (account_id, checkin_type, day_index, claim_date)
                                VALUES (%s, 2, %s, CURDATE())
                            """, (acc_id, day_index - 3000))
                        elif 1 <= day_index <= 7:
                            cur.execute("""
                                INSERT IGNORE INTO user_checkin (account_id, checkin_type, day_index, claim_date)
                                VALUES (%s, 2, %s, CURDATE())
                            """, (acc_id, 3000 + day_index))
                    elif checkin_type == 1 and day_val > 0 and day_val != day_index:
                        cur.execute("""
                            INSERT IGNORE INTO user_checkin (account_id, checkin_type, day_index, claim_date)
                            VALUES (%s, 1, %s, CURDATE())
                        """, (acc_id, day_val))

                    conn.commit()

            resp = {"code": 200, "msg": "Điểm danh thành công!", "checkin_type": checkin_type, "day_index": day_index}
            print(f"[SHOP CHECKIN] Account {acc_id} checked in: type={checkin_type}, day={day_index}.")

        # -------------------------------------------------------------
        # 6. Đồng Bộ Tiền Tệ (/api/sync_currency)
        # -------------------------------------------------------------
        elif self.path == '/api/sync_currency':
            # SECURITY LOCK: Chặn tuyệt đối người chơi tự ý bơm tiền, chỉ cho phép server nội bộ
            internal_secret = req.get('internal_secret')
            if internal_secret != 'YGO_INTERNAL_SECRET_SECURE_KEY_2026':
                acc_id = req.get('account_id')
                print(f"[SHOP SECURITY ALERT] Blocked unauthorized /api/sync_currency attempt for account {acc_id}!")
                resp = {"code": 403, "msg": "Truy cập bị từ chối: Chỉ server nội bộ mới có quyền cập nhật tài nguyên!"}
            else:
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
                        conn.commit()
                        cur.execute("SELECT gold, gem FROM accounts WHERE id = %s", (acc_id,))
                        row = cur.fetchone() or {'gold': 0, 'gem': 0}
                resp = {"code": 200, "msg": "OK", "gold": row['gold'], "gem": row['gem']}
                print(f"[SHOP CURRENCY SYNC] Account {acc_id}: {currency} delta {delta} -> gold={row['gold']}, gem={row['gem']} ({action})")

        # -------------------------------------------------------------
        # 7. Phân Tách Thẻ Bài Đơn (/api/decompose_card)
        # -------------------------------------------------------------
        elif self.path == '/api/decompose_card':
            acc_id = req.get('account_id')
            card_id = int(req.get('card_id', 0))
            count = int(req.get('count', 1))
            if not acc_id or card_id <= 0 or count <= 0:
                resp = {"code": 400, "msg": "Tham số không hợp lệ!"}
            else:
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("SELECT gold FROM accounts WHERE id = %s", (acc_id,))
                        acc_row = cur.fetchone()
                        if not acc_row:
                            resp = {"code": 404, "msg": "Tài khoản không tồn tại!"}
                        else:
                            cur.execute("SELECT count FROM user_cards WHERE account_id = %s AND card_id = %s", (acc_id, card_id))
                            row = cur.fetchone()
                            owned = row['count'] if row else 0
                            if owned < count:
                                resp = {"code": 400, "msg": f"Không đủ số lượng bài để phân tách (Hiện có: {owned}, cần: {count})!"}
                            else:
                                card_info = ALL_CARDS_MAP.get(card_id, {})
                                q = card_info.get('quality', 'R')
                                gold_per_card = 100 if q == 'UR' else (50 if q == 'SR' else (10 if q == 'R' else 5))
                                total_gold = gold_per_card * count

                                cur.execute("UPDATE user_cards SET count = count - %s WHERE account_id = %s AND card_id = %s", (count, acc_id, card_id))
                                cur.execute("DELETE FROM user_cards WHERE account_id = %s AND card_id = %s AND count <= 0", (acc_id, card_id))
                                cur.execute("UPDATE accounts SET gold = gold + %s WHERE id = %s", (total_gold, acc_id))
                                conn.commit()

                                cur.execute("SELECT gold FROM accounts WHERE id = %s", (acc_id,))
                                gold_row = cur.fetchone()
                                new_gold = gold_row['gold'] if gold_row else (acc_row['gold'] + total_gold)

                                resp = {
                                    "code": 200,
                                    "msg": f"Phân tách thành công {count} lá bài, nhận {total_gold} Vàng!",
                                    "gold_reward": total_gold,
                                    "gold": new_gold,
                                    "remaining_count": owned - count
                                }
                                print(f"[SHOP DECOMPOSE] Acc {acc_id} decomposed {count}x card {card_id} ({card_info.get('name', '')}) -> +{total_gold} gold (New: {new_gold})")

        # -------------------------------------------------------------
        # 8. Phân Tách Tất Cả Thẻ Thừa (/api/decompose_all)
        # -------------------------------------------------------------
        elif self.path == '/api/decompose_all':
            acc_id = req.get('account_id')
            if not acc_id:
                resp = {"code": 400, "msg": "Thiếu account_id!"}
            else:
                with get_db() as conn:
                    with conn.cursor() as cur:
                        cur.execute("SELECT gold FROM accounts WHERE id = %s", (acc_id,))
                        acc_row = cur.fetchone()
                        if not acc_row:
                            resp = {"code": 404, "msg": "Tài khoản không tồn tại!"}
                        else:
                            cur.execute("SELECT card_id, count FROM user_cards WHERE account_id = %s AND count > 3", (acc_id,))
                            excess_rows = cur.fetchall()
                            total_cards = 0
                            total_gold = 0
                            breakdown = {'N': 0, 'R': 0, 'SR': 0, 'UR': 0}

                            for r in excess_rows:
                                cid = r['card_id']
                                cnt = r['count']
                                card_info = ALL_CARDS_MAP.get(cid, {})
                                q = card_info.get('quality', 'R')

                                if q in ('N', 'R', 'SR', 'UR'):
                                    excess = cnt - 3
                                    gold_val = 100 if q == 'UR' else (50 if q == 'SR' else (10 if q == 'R' else 5))
                                    total_gold += excess * gold_val
                                    total_cards += excess
                                    breakdown[q] += excess
                                    cur.execute("UPDATE user_cards SET count = 3 WHERE account_id = %s AND card_id = %s", (acc_id, cid))

                            if total_gold > 0:
                                cur.execute("UPDATE accounts SET gold = gold + %s WHERE id = %s", (total_gold, acc_id))
                            conn.commit()

                            cur.execute("SELECT gold FROM accounts WHERE id = %s", (acc_id,))
                            gold_row = cur.fetchone()
                            new_gold = gold_row['gold'] if gold_row else (acc_row['gold'] + total_gold)

                            resp = {
                                "code": 200,
                                "msg": f"Phân tách tất cả thành công {total_cards} lá bài thừa, nhận {total_gold} Vàng!",
                                "decomposed_count": total_cards,
                                "gold_reward": total_gold,
                                "gold": new_gold,
                                "breakdown": breakdown
                            }
                            print(f"[SHOP DECOMPOSE ALL] Acc {acc_id} decomposed {total_cards} excess cards ({breakdown}) -> +{total_gold} gold (New: {new_gold})")

        resp_data = json.dumps(resp, ensure_ascii=False).encode('utf-8')
        status_code = resp.get('code', 200)
        if not (100 <= status_code <= 599):
            status_code = 200
        self.send_response(status_code)
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.send_header('Content-Length', str(len(resp_data)))
        self.send_cors_headers()
        self.end_headers()
        self.wfile.write(resp_data)

    def log_message(self, format, *args):
        # Clean logging
        pass

def console_cleaner_loop():
    while True:
        time.sleep(1800)
        try:
            os.system('cls' if os.name == 'nt' else 'clear')
            print(f"[SYSTEM] Đã dọn dẹp console log định kỳ (mỗi 30 phút). Shop server hoạt động bình thường lúc {time.strftime('%Y-%m-%d %H:%M:%S')}")
        except Exception:
            pass

def main():
    print("================================================================")
    print(f"   YUGIOH DEDICATED SHOP SERVER (Quầy Thẻ Bài & Kinh Tế)      ")
    print(f"   HTTP Server running on 0.0.0.0:{SHOP_PORT}                 ")
    print(f"   Database: {DB_CONFIG['database']} @ {DB_CONFIG['host']}    ")
    print("================================================================")
    cleaner_thread = threading.Thread(target=console_cleaner_loop, daemon=True)
    cleaner_thread.start()
    server = ThreadingHTTPServer(('0.0.0.0', SHOP_PORT), ShopHTTPHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("[SHOP SERVER] Stopping...")
        server.server_close()

if __name__ == '__main__':
    main()
