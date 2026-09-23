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
PACK_QUALITY_DISTRIBUTION = {}
ANCIENT_CARD_IDS = set()
FIXED_DEPOT_PRICES = {}

def load_pack_mappings():
    global SERVER_LIYA_CARDS_MAP, SERVER_CHAR_CARDS_MAP, SERVER_EXTRA_CARDS_MAP, SERVER_EXPANSION_CARDS_MAP, PACK_QUALITY_DISTRIBUTION, ANCIENT_CARD_IDS, FIXED_DEPOT_PRICES
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
    elif 10201 <= pkg_num <= 12150:
        base_val = ((pkg_num - 10000) // 100) * 100 + 1
        cards = SERVER_CHAR_CARDS_MAP.get(pkg_num) or SERVER_CHAR_CARDS_MAP.get(base_val) or []
    elif 101001 <= pkg_num <= 120050:
        prefix = (pkg_num // 1000) * 1000
        base_val = prefix + 10
        cards = SERVER_LIYA_CARDS_MAP.get(pkg_num) or SERVER_LIYA_CARDS_MAP.get(base_val) or []
    elif 121001 <= pkg_num <= 145050:
        prefix = (pkg_num // 1000) * 1000
        base_val = prefix + 10
        cards = SERVER_EXTRA_CARDS_MAP.get(pkg_num) or SERVER_EXTRA_CARDS_MAP.get(base_val) or []
    elif 151001 <= pkg_num <= 155050:
        prefix = (pkg_num // 1000) * 1000
        base_val = prefix + 10
        cards = SERVER_EXPANSION_CARDS_MAP.get(pkg_num) or SERVER_EXPANSION_CARDS_MAP.get(base_val) or []

    # 2. Fallback to client req_pool if no server mapping found
    if not cards and req_pool and len(req_pool) > 0:
        cards = req_pool

    return [int(x) for x in cards if int(x) in ALL_CARDS_MAP]

def execute_pack_lottery(pkg_num, total_cards, user_pity, req_pool, user_acc, broadcast_fn=None):
    # Determine base package ID for quality pools
    base_pkg_val = None
    if pkg_num in PACK_QUALITY_DISTRIBUTION:
        base_pkg_val = pkg_num
    elif 10201 <= pkg_num <= 12150:
        c_base = ((pkg_num - 10000) // 100) * 100 + 1
        if c_base in PACK_QUALITY_DISTRIBUTION: base_pkg_val = c_base
    elif 101001 <= pkg_num <= 155050:
        prefix = (pkg_num // 1000) * 1000
        l_base = prefix + 10
        if l_base in PACK_QUALITY_DISTRIBUTION: base_pkg_val = l_base
    elif 1 <= pkg_num <= 25:
        c_val = 10000 + pkg_num * 100 + 1
        l_val = 100000 + pkg_num * 1000 + 10
        e_val = 120000 + pkg_num * 1000 + 10
        ex_val = 150000 + pkg_num * 1000 + 10
        if c_val in PACK_QUALITY_DISTRIBUTION: base_pkg_val = c_val
        elif l_val in PACK_QUALITY_DISTRIBUTION: base_pkg_val = l_val
        elif e_val in PACK_QUALITY_DISTRIBUTION: base_pkg_val = e_val
        elif ex_val in PACK_QUALITY_DISTRIBUTION: base_pkg_val = ex_val

    q_pools = None
    if base_pkg_val and base_pkg_val in PACK_QUALITY_DISTRIBUTION:
        q_pools = PACK_QUALITY_DISTRIBUTION[base_pkg_val]

    # If quality pools not found, build dynamically from pack cards
    if not q_pools:
        pack_cids = resolve_pack_cards(pkg_num, req_pool)
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

    # Collect all valid card IDs in this pack for ultimate fallback
    all_pack_cids = []
    for qk in ['GR', 'UR_ANCIENT', 'UR', 'SR', 'R', 'N']:
        for cid in q_pools.get(qk, []):
            if cid in ALL_CARDS_MAP and cid not in all_pack_cids:
                all_pack_cids.append(cid)

    cards_won = []
    has_ur = False
    for card_idx in range(total_cards):
        user_pity += (1.0 / 3.0)
        force_ur = (user_pity >= 50.0) and (not has_ur)
        
        roll = random.random()
        # Exact drop rates:
        # GR: 0.0005% (0.000005)
        # UR Di tích cổ: 0.5% (0.005000)
        # UR thường: 2% (0.020000)
        # SR: 5% (0.050000)
        # R: 40% (0.400000)
        # N: 50% + remainder (~0.524995)
        if force_ur:
            target_quality = 'UR'
        elif roll < 0.000005:
            target_quality = 'GR'
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
            pool = q_pools.get('GR') or q_pools.get('UR_ANCIENT') or q_pools.get('UR')
            picked_cid = random.choice(pool) if pool else None
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
                announcement = f"[THÔNG BÁO] Chúc mừng bài thủ [{char_name}] vừa rút được lá bài cấp GR thần thánh [{cname}]!"
            elif is_ancient_ur and random.random() < 0.3:
                announcement = f"[THÔNG BÁO] Chúc mừng bài thủ [{char_name}] vừa khai quật được bảo vật di tích cổ [{cname}]!"

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

    return cards_won, user_pity, has_ur



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

        resp = {"code": 404, "msg": "Unknown shop endpoint"}

        # -------------------------------------------------------------
        # 1. Rút Gói Bài / Mua Bài (Tavern / Gacha / Lottery)
        # -------------------------------------------------------------
        if self.path == '/api/buy_package':
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
            if total_cards <= 0:
                total_cards = 3

            is_rare_or_extra = (101001 <= pkg_num <= 155050) or (pkg_num in SERVER_LIYA_CARDS_MAP) or (pkg_num in SERVER_EXTRA_CARDS_MAP) or (pkg_num in SERVER_EXPANSION_CARDS_MAP)
            cost_val = int(req.get('cost_val', 0))
            if is_rare_or_extra:
                expected_gold_cost = (28500 if packs >= 50 else (6000 if packs >= 10 else 600 * packs))
            else:
                expected_gold_cost = (22500 if packs >= 50 else (4500 if packs >= 10 else 500 * packs))

            if cost_type == 'gold' or cost_val <= 0:
                cost_val = expected_gold_cost

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

                            raw_card_pool = req.get('card_pool') or []
                            req_pool = [int(x) for x in raw_card_pool if str(x).isdigit()]

                            user_pity = user_acc.get('pity_count', 0) or 0
                            cards_won, user_pity, has_ur = execute_pack_lottery(
                                pkg_num=pkg_num,
                                total_cards=total_cards,
                                user_pity=user_pity,
                                req_pool=req_pool,
                                user_acc=user_acc,
                                broadcast_fn=notify_main_server_broadcast
                            )

                            # Batch save cards won
                            card_counts = {}
                            for c in cards_won:
                                ci = c['info_id']
                                card_counts[ci] = card_counts.get(ci, 0) + 1
                            for ci, cnt in card_counts.items():
                                cur.execute("INSERT INTO user_cards (account_id, card_id, count) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE count = count + %s", (acc_id, ci, cnt, cnt))

                            cur.execute("UPDATE accounts SET pity_count = %s WHERE id = %s", (int(user_pity), acc_id))
                            conn.commit()
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
                            print(f"[SHOP BUY PACKAGE] Account {acc_id} ({user_acc['character_name']}) drew {total_cards} cards. Pity: {int(user_pity)}/50. Won {len(cards_won)} cards.")

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
                59: (40209, 200000, 1),
                60: (20005, 5000, 1),
                61: (20051, 100000, 1),
                62: (20030, 100000, 1),
                63: (40713, 500000, 1),
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
            is_gr = (card_info and card_info.get('quality') == 'GR')

            if not acc_id or card_id <= 0:
                resp = {"code": 400, "msg": "Thông tin thẻ bài hoặc tài khoản không hợp lệ!"}
            elif not is_legit_item or server_cost <= 0:
                resp = {"code": 400, "msg": "Thẻ bài này không được bán trong Shop!"}
                print(f"[SECURITY BLOCKED] Account {acc_id} tried to buy unlisted card {card_id} (cost={server_cost})")
            elif is_gr:
                resp = {"code": 403, "msg": "Thẻ bài cấp GR không thể mua trực tiếp từ Shop!"}
                print(f"[SECURITY BLOCKED] Account {acc_id} tried to buy GR card {card_id}!")
            else:
                total_cost = server_cost * count
                is_gold = (server_cost_type in (1, '1', 'gold'))
                is_gem = (server_cost_type in (3, '3', 'gem', 'diamond', 'ingot', 7339, '7339', 7114, '7114'))

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
                            if cur_owned >= max_allowed:
                                resp = {"code": 400, "msg": f"Bạn đã sở hữu tối đa {max_allowed} bản sao của thẻ bài này!"}
                            elif cur_owned + count > max_allowed:
                                resp = {"code": 400, "msg": f"Chỉ có thể mua thêm {max_allowed - cur_owned} bản sao nữa!"}
                            elif is_gold and acc['gold'] < total_cost:
                                resp = {"code": 400, "msg": f"Không đủ Vàng / Linh Thạch! (Cần {total_cost:,}, có {acc['gold']:,})"}
                            elif is_gem and acc['gem'] < total_cost:
                                resp = {"code": 400, "msg": f"Không đủ Gem / Kim Cương! (Cần {total_cost:,}, có {acc['gem']:,})"}
                            else:
                                if is_gold and total_cost > 0:
                                    cur.execute("UPDATE accounts SET gold = gold - %s WHERE id = %s", (total_cost, acc_id))
                                elif is_gem and total_cost > 0:
                                    cur.execute("UPDATE accounts SET gem = gem - %s WHERE id = %s", (total_cost, acc_id))

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
                                    "gem": updated_acc.get('gem', 0)
                                }
                                print(f"[SHOP BUY CARD SUCCESS] Account {acc_id} ({acc['character_name']}) bought {count}x card {card_id} for {total_cost} ({'Gold' if is_gold else 'Gem'}). Total owned: {final_count}.")

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

                                        if reward_gold > 0 and reward_gem > 0:
                                            reward_msg = f"Đổi quà thành công! Nhận {reward_gold:,} Linh Thạch và {reward_gem:,} Gem!"
                                        elif reward_gold > 0:
                                            reward_msg = f"Đổi quà thành công! Nhận {reward_gold:,} Linh Thạch!"
                                        elif reward_gem > 0:
                                            reward_msg = f"Đổi quà thành công! Nhận {reward_gem:,} Gem!"
                                        else:
                                            reward_msg = "Đổi quà thành công!"

                                        print(f"[SHOP GIFT CODE] Account {acc_id} redeemed '{gcode['code']}': +{reward_gem} gem, +{reward_gold} gold")
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
            with get_db() as conn:
                with conn.cursor() as cur:
                    cur.execute("""
                        INSERT IGNORE INTO user_checkin (account_id, checkin_type, day_index, claim_date)
                        VALUES (%s, %s, %s, CURDATE())
                    """, (acc_id, checkin_type, day_index))
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

def main():
    print("================================================================")
    print(f"   YUGIOH DEDICATED SHOP SERVER (Quầy Thẻ Bài & Kinh Tế)      ")
    print(f"   HTTP Server running on 0.0.0.0:{SHOP_PORT}                 ")
    print(f"   Database: {DB_CONFIG['database']} @ {DB_CONFIG['host']}    ")
    print("================================================================")
    server = ThreadingHTTPServer(('0.0.0.0', SHOP_PORT), ShopHTTPHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("[SHOP SERVER] Stopping...")
        server.server_close()

if __name__ == '__main__':
    main()
