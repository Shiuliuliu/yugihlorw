import struct, os, sys, json, re
from datetime import datetime

sys.stdout.reconfigure(encoding='utf-8')

print("Starting MySQL Database Generator for Yu-Gi-Oh / Quyết Chiến Chi Thành...")

FIB = [
    1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 584, 4181, 6765, 
    10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 
    2178309, 3524578, 5702887, 9227465, 14930352, 24157817, 39088169, 63245986, 102334155, 
    165580141, 267914296, 433494437, 701408733, 1134903170, 1836311903
]

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

def decrypt_file(raw_data, key):
    enc_len = min(len(raw_data), 4096)
    return decrypt_data(raw_data[:enc_len], key) + raw_data[enc_len:]

# 1. Read lan strings
print("Reading language strings...")
with open(r"D:\yugitauapk\extend_lan.txt", "r", encoding="utf-8", errors="ignore") as f:
    lan = [l.rstrip('\r\n') for l in f]

def get_text(sid):
    if not sid: return ""
    idx = sid - 1
    if 0 <= idx < len(lan):
        return lan[idx]
    return ""

def escape_sql(val):
    if val is None:
        return "NULL"
    if isinstance(val, (int, float)):
        return str(val)
    if isinstance(val, (list, dict)):
        val = json.dumps(val, ensure_ascii=False)
    s = str(val)
    s = s.replace("\\", "\\\\").replace("'", "\\'").replace("\r", "").replace("\n", "\\n")
    return f"'{s}'"

# Dictionaries
NATURE_NAMES = {
    0: "Không có",
    1: "Quang",
    2: "Ám",
    3: "Địa",
    4: "Thủy",
    5: "Hỏa",
    6: "Phong",
    7: "Thần",
}

QUALITY_NAMES = {
    1: "N",
    2: "R",
    3: "SR",
    4: "UR",
    5: "UR",
}

SPELL_TYPE_NAMES = {
    11: "Thông Thường",
    12: "Tốc Công",
    13: "Vĩnh Cửu",
    14: "Trang Bị",
    15: "Môi Trường",
    16: "Nghi Thức",
}

TRAP_TYPE_NAMES = {
    21: "Thông Thường",
    22: "Vĩnh Cửu",
    23: "Phản Đòn",
}

def get_category_name(cat_id):
    if not cat_id: return "Không có"
    idx = 1902 + cat_id
    if 0 <= idx < len(lan):
        return lan[idx]
    return "Khác"

def get_keyword_name(kw_id):
    if not kw_id: return "Không có"
    idx = 1930 + kw_id
    if 0 <= idx < len(lan):
        return lan[idx]
    return "Khác"


# 2. Extract bin files sequentially
print("Unpacking game bin resources from data.lcres...")
with open(r"D:\yugitauapk\extracted\1.0.7\res\data.lcres", "rb") as f:
    res_data = f.read()

cur_key = struct.unpack('<I', res_data[4:8])[0]
delta_key = struct.unpack('<I', res_data[8:12])[0]
off = 44
bins = {}
while off < len(res_data):
    if off + 7 > len(res_data): break
    fn_len = res_data[off+6]
    off += 7
    enc_fn = res_data[off:off+fn_len]
    off += fn_len
    dec_fn = decrypt_data(enc_fn, cur_key)
    cur_key = (cur_key + delta_key) & 0xFFFFFFFF
    data_len = struct.unpack('<I', res_data[off:off+4])[0]
    off += 4
    enc_file = res_data[off:off+data_len]
    dec_file = decrypt_file(enc_file, cur_key)
    cur_key = (cur_key + delta_key) & 0xFFFFFFFF
    off += data_len
    name = dec_fn.decode('utf-8', errors='ignore')
    bins[name] = dec_file

print(f"Extracted {len(bins)} bin files successfully!")

def parse_val(raw, t, ptr):
    if ptr >= len(raw): return None, ptr
    if t == 'B': return raw[ptr], ptr + 1
    elif t == 'b': return struct.unpack('b', raw[ptr:ptr+1])[0], ptr + 1
    elif t == 'H' or t == 'D': return struct.unpack('<H', raw[ptr:ptr+2])[0], ptr + 2
    elif t == 'I': return struct.unpack('<I', raw[ptr:ptr+4])[0], ptr + 4
    elif t == 'S':
        slen = struct.unpack('<H', raw[ptr:ptr+2])[0]; ptr += 2
        s = raw[ptr:ptr+slen].decode('utf-8', errors='ignore'); return s, ptr + slen
    elif t == '[H':
        cnt = raw[ptr]; ptr += 1
        arr = [struct.unpack('<H', raw[ptr+i*2:ptr+i*2+2])[0] for i in range(cnt)]
        return arr, ptr + cnt*2
    elif t == '[I':
        cnt = raw[ptr]; ptr += 1
        arr = [struct.unpack('<I', raw[ptr+i*4:ptr+i*4+4])[0] for i in range(cnt)]
        return arr, ptr + cnt*4
    elif t == '[[H':
        outer_cnt = raw[ptr]; ptr += 1
        outer_arr = []
        for _ in range(outer_cnt):
            inner_cnt = raw[ptr]; ptr += 1
            inner_arr = [struct.unpack('<H', raw[ptr+i*2:ptr+i*2+2])[0] for i in range(inner_cnt)]
            ptr += inner_cnt*2
            outer_arr.append(inner_arr)
        return outer_arr, ptr
    else: raise ValueError(f"Unknown type {t}")

def parse_bin_rows(raw):
    num_cols = struct.unpack('<H', raw[0:2])[0]
    ptr = 2
    cols = []
    for i in range(num_cols):
        namelen = raw[ptr]; ptr += 1
        colname = raw[ptr:ptr+namelen].decode('ascii'); ptr += namelen
        typelen = raw[ptr]; ptr += 1
        coltype = raw[ptr:ptr+typelen].decode('ascii'); ptr += typelen
        cols.append((colname, coltype))
    rows = []
    while ptr < len(raw):
        row = {}
        err = False
        for cname, ctype in cols:
            val, ptr = parse_val(raw, ctype, ptr)
            if val is None: err = True; break
            row[cname] = val
        if err: break
        rows.append(row)
    return rows

print("Parsing cards and deck tables...")
raw_monsters = parse_bin_rows(bins['monster.bin'])
raw_spells = parse_bin_rows(bins['magic.bin'])
raw_traps = parse_bin_rows(bins['trap.bin'])
raw_extra = parse_bin_rows(bins['rare.bin'])
raw_troops = parse_bin_rows(bins['troop.bin'])

print(f"Loaded: {len(raw_monsters)} Monsters, {len(raw_spells)} Spells, {len(raw_traps)} Traps, {len(raw_extra)} Extra Cards, {len(raw_troops)} Decks.")

# Build SQL Script
sql_lines = []
sql_lines.append("-- ====================================================================")
sql_lines.append("-- DATABASE SQL: QUYET CHIEN CHI THANH (YU-GI-OH)")
sql_lines.append("-- Generated automatically with full cards, accounts and JSON decks")
sql_lines.append(f"-- Timestamp: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
sql_lines.append("-- ====================================================================\n")
sql_lines.append("CREATE DATABASE IF NOT EXISTS `yugioh_game` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;")
sql_lines.append("USE `yugioh_game`;\n")

# Drop tables if exist
sql_lines.append("SET FOREIGN_KEY_CHECKS = 0;")
sql_lines.append("DROP TABLE IF EXISTS `user_decks`;")
sql_lines.append("DROP TABLE IF EXISTS `system_decks`;")
sql_lines.append("DROP TABLE IF EXISTS `card_monsters`;")
sql_lines.append("DROP TABLE IF EXISTS `card_spells`;")
sql_lines.append("DROP TABLE IF EXISTS `card_traps`;")
sql_lines.append("DROP TABLE IF EXISTS `card_extra`;")
sql_lines.append("DROP TABLE IF EXISTS `accounts`;")
sql_lines.append("SET FOREIGN_KEY_CHECKS = 1;\n")

# 1. Accounts Table
print("Creating accounts table schema and seed data...")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append("-- Table structure for `accounts`")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append("""CREATE TABLE `accounts` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(50) NOT NULL UNIQUE COMMENT 'Tài khoản đăng nhập',
  `password` VARCHAR(255) NOT NULL COMMENT 'Mật khẩu',
  `character_name` VARCHAR(50) NOT NULL COMMENT 'Tên nhân vật ingame',
  `server` VARCHAR(50) NOT NULL DEFAULT 'S1 - Quyết Chiến Chi Thành' COMMENT 'Máy chủ',
  `gold` BIGINT NOT NULL DEFAULT 99999999 COMMENT 'Tiền vàng',
  `gem` INT NOT NULL DEFAULT 999999 COMMENT 'Kim cương / Gem',
  `void_stone` INT NOT NULL DEFAULT 99999 COMMENT 'Đá Hư Vô',
  `purple_ticket` INT NOT NULL DEFAULT 999 COMMENT 'Thẻ Tím (Vé Chiêu Mộ Tím)',
  `leya_ticket` INT NOT NULL DEFAULT 999 COMMENT 'Thẻ Lỗi Nhã / Lôi Nhã (Vé Leya)',
  `level` INT NOT NULL DEFAULT 1 COMMENT 'Cấp độ nhân vật',
  `exp` BIGINT NOT NULL DEFAULT 0 COMMENT 'Điểm kinh nghiệm',
  `vip_level` INT NOT NULL DEFAULT 0 COMMENT 'Cấp VIP',
  `stamina` INT NOT NULL DEFAULT 120 COMMENT 'Thể lực',
  `cur_troop` INT NOT NULL DEFAULT 1 COMMENT 'Bộ bài đang kích hoạt',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` DATETIME DEFAULT NULL,
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '1 = Hoạt động, 0 = Bị khóa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n""")

# Seed Accounts
sql_lines.append("-- Seed default accounts")
accounts_seed = [
    ("admin", "admin123", "Yugi Muto", "S1 - Quyết Chiến Chi Thành", 999999999, 999999, 99999, 999, 999, 100, 10000000, 15, 999, 1),
    ("kaiba", "kaiba123", "Seto Kaiba", "S1 - Quyết Chiến Chi Thành", 999999999, 999999, 99999, 999, 999, 100, 10000000, 15, 999, 1),
    ("joey", "joey123", "Katsuya Jonouchi", "S1 - Quyết Chiến Chi Thành", 50000000, 50000, 5000, 100, 100, 50, 500000, 8, 200, 1),
    ("player1", "player123", "Đấu Sĩ Tập Sự", "S1 - Quyết Chiến Chi Thành", 1000000, 1000, 100, 10, 10, 1, 0, 0, 120, 1),
]

for acc in accounts_seed:
    sql_lines.append(
        f"INSERT INTO `accounts` (`username`, `password`, `character_name`, `server`, `gold`, `gem`, `void_stone`, `purple_ticket`, `leya_ticket`, `level`, `exp`, `vip_level`, `stamina`, `cur_troop`, `created_at`, `last_login`) VALUES "
        f"('{acc[0]}', '{acc[1]}', '{acc[2]}', '{acc[3]}', {acc[4]}, {acc[5]}, {acc[6]}, {acc[7]}, {acc[8]}, {acc[9]}, {acc[10]}, {acc[11]}, {acc[12]}, {acc[13]}, NOW(), NOW());"
    )
sql_lines.append("")

# 2. Table `card_monsters`
print("Generating card_monsters SQL...")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append(f"-- Table structure and data for `card_monsters` ({len(raw_monsters)} records)")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append("""CREATE TABLE `card_monsters` (
  `id` INT PRIMARY KEY COMMENT 'Mã ID thẻ bài',
  `name` VARCHAR(100) NOT NULL COMMENT 'Tên quái thú tiếng Việt chuẩn',
  `category` VARCHAR(50) DEFAULT 'Khác' COMMENT 'Chủng tộc (Rồng, Pháp Sư, Chiến Sĩ...)',
  `attribute` VARCHAR(20) DEFAULT 'Không có' COMMENT 'Thuộc tính (Quang, Ám, Địa, Thủy, Hỏa, Phong, Thần)',
  `keyword` VARCHAR(50) DEFAULT 'Không có' COMMENT 'Từ khóa / Archetype (Mắt Xanh, Mắt Đỏ...)',
  `stars` TINYINT NOT NULL DEFAULT 1 COMMENT 'Cấp sao',
  `atk` INT NOT NULL DEFAULT 0 COMMENT 'Sức tấn công ATK',
  `def` INT NOT NULL DEFAULT 0 COMMENT 'Sức phòng thủ DEF (HP)',
  `quality` VARCHAR(10) NOT NULL DEFAULT 'N' COMMENT 'Phẩm chất (UR, SR, R, N)',
  `cost` TINYINT NOT NULL DEFAULT 0 COMMENT 'Cost',
  `max_count` TINYINT NOT NULL DEFAULT 3 COMMENT 'Giới hạn tối đa trong bộ bài',
  `pinyin` VARCHAR(20) DEFAULT NULL COMMENT 'Mã viết tắt Pinyin',
  `description` TEXT DEFAULT NULL COMMENT 'Tiểu sử / Hiệu ứng thẻ bài',
  `guide` TEXT DEFAULT NULL COMMENT 'Combo / Hướng dẫn kết hợp',
  KEY `idx_cat` (`category`),
  KEY `idx_attr` (`attribute`),
  KEY `idx_kw` (`keyword`),
  KEY `idx_star` (`stars`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n""")

m_values = []
for m in raw_monsters:
    cid = m['_id']
    name = get_text(m['_nameSid'])
    cat = get_category_name(m['_category'])
    attr = NATURE_NAMES.get(m['_nature'], "Khác")
    kw = get_keyword_name(m['_keyword'])
    star = m['_star']
    atk = m['_atk'][0] if m['_atk'] else 0
    df = m['_hp'][0] if m['_hp'] else 0
    q = QUALITY_NAMES.get(m['_quality'], "N")
    cost = m['_cost']
    max_cnt = m['_maxCount']
    py = m['_py']
    desc = get_text(m['_descSid'])
    guide = get_text(m['_guideSid'])
    m_values.append(f"({cid}, {escape_sql(name)}, {escape_sql(cat)}, {escape_sql(attr)}, {escape_sql(kw)}, {star}, {atk}, {df}, {escape_sql(q)}, {cost}, {max_cnt}, {escape_sql(py)}, {escape_sql(desc)}, {escape_sql(guide)})")

# Batch inserts
BATCH_SIZE = 100
for i in range(0, len(m_values), BATCH_SIZE):
    batch = m_values[i:i+BATCH_SIZE]
    sql_lines.append(f"INSERT INTO `card_monsters` (`id`, `name`, `category`, `attribute`, `keyword`, `stars`, `atk`, `def`, `quality`, `cost`, `max_count`, `pinyin`, `description`, `guide`) VALUES\n" + ",\n".join(batch) + ";")
sql_lines.append("")

# 3. Table `card_spells`
print("Generating card_spells SQL...")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append(f"-- Table structure and data for `card_spells` ({len(raw_spells)} records)")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append("""CREATE TABLE `card_spells` (
  `id` INT PRIMARY KEY COMMENT 'Mã ID thẻ bài',
  `name` VARCHAR(100) NOT NULL COMMENT 'Tên phép thuật tiếng Việt chuẩn',
  `type` VARCHAR(30) NOT NULL DEFAULT 'Thông Thường' COMMENT 'Phân loại phép (Thông Thường, Tốc Công, Trang Bị...)',
  `keyword` VARCHAR(50) DEFAULT 'Không có' COMMENT 'Từ khóa liên quan',
  `quality` VARCHAR(10) NOT NULL DEFAULT 'N' COMMENT 'Độ hiếm (UR, SR, R, N)',
  `max_count` TINYINT NOT NULL DEFAULT 3 COMMENT 'Giới hạn tối đa trong bộ bài',
  `pinyin` VARCHAR(20) DEFAULT NULL COMMENT 'Mã viết tắt Pinyin',
  `description` TEXT DEFAULT NULL COMMENT 'Mô tả / Hiệu ứng phép thuật',
  `guide` TEXT DEFAULT NULL COMMENT 'Hướng dẫn sử dụng',
  KEY `idx_type` (`type`),
  KEY `idx_kw` (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n""")

s_values = []
for s in raw_spells:
    cid = s['_id']
    name = get_text(s['_nameSid'])
    opt = s.get('_option', 0)
    if opt & 8:
        stype = "Nghi Thức"
    elif opt & 4:
        stype = "Môi Trường"
    elif opt & 2:
        stype = "Trang Bị"
    elif opt & 16:
        stype = "Vĩnh Cửu"
    elif opt & 32:
        stype = "Tốc Công"
    else:
        stype = "Thông Thường"
    kw = get_keyword_name(s['_keyword'])
    q = QUALITY_NAMES.get(s['_quality'], "N")
    max_cnt = s['_maxCount']
    py = s['_py']
    desc = get_text(s['_descSid'])
    guide = get_text(s['_guideSid'])
    s_values.append(f"({cid}, {escape_sql(name)}, {escape_sql(stype)}, {escape_sql(kw)}, {escape_sql(q)}, {max_cnt}, {escape_sql(py)}, {escape_sql(desc)}, {escape_sql(guide)})")

for i in range(0, len(s_values), BATCH_SIZE):
    batch = s_values[i:i+BATCH_SIZE]
    sql_lines.append(f"INSERT INTO `card_spells` (`id`, `name`, `type`, `keyword`, `quality`, `max_count`, `pinyin`, `description`, `guide`) VALUES\n" + ",\n".join(batch) + ";")
sql_lines.append("")

# 4. Table `card_traps`
print("Generating card_traps SQL...")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append(f"-- Table structure and data for `card_traps` ({len(raw_traps)} records)")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append("""CREATE TABLE `card_traps` (
  `id` INT PRIMARY KEY COMMENT 'Mã ID thẻ bài',
  `name` VARCHAR(100) NOT NULL COMMENT 'Tên cạm bẫy tiếng Việt chuẩn',
  `type` VARCHAR(30) NOT NULL DEFAULT 'Thông Thường' COMMENT 'Phân loại bẫy (Thông Thường, Vĩnh Cửu, Phản Đòn, Trang Bị)',
  `keyword` VARCHAR(50) DEFAULT 'Không có' COMMENT 'Từ khóa liên quan',
  `quality` VARCHAR(10) NOT NULL DEFAULT 'N' COMMENT 'Độ hiếm (UR, SR, R, N)',
  `max_count` TINYINT NOT NULL DEFAULT 3 COMMENT 'Giới hạn tối đa trong bộ bài',
  `pinyin` VARCHAR(20) DEFAULT NULL COMMENT 'Mã viết tắt Pinyin',
  `description` TEXT DEFAULT NULL COMMENT 'Mô tả / Hiệu ứng cạm bẫy',
  `guide` TEXT DEFAULT NULL COMMENT 'Hướng dẫn sử dụng',
  KEY `idx_type` (`type`),
  KEY `idx_kw` (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n""")

t_values = []
for t in raw_traps:
    cid = t['_id']
    name = get_text(t['_nameSid'])
    opt = t.get('_option', 0)
    if opt & 8:
        ttype = "Trang Bị"
    elif opt & 4:
        ttype = "Phản Đòn"
    elif opt & 2:
        ttype = "Vĩnh Cửu"
    else:
        ttype = "Thông Thường"
    kw = get_keyword_name(t['_keyword'])
    q = QUALITY_NAMES.get(t['_quality'], "N")
    max_cnt = t['_maxCount']
    py = t['_py']
    desc = get_text(t['_descSid'])
    guide = get_text(t['_guideSid'])
    t_values.append(f"({cid}, {escape_sql(name)}, {escape_sql(ttype)}, {escape_sql(kw)}, {escape_sql(q)}, {max_cnt}, {escape_sql(py)}, {escape_sql(desc)}, {escape_sql(guide)})")

for i in range(0, len(t_values), BATCH_SIZE):
    batch = t_values[i:i+BATCH_SIZE]
    sql_lines.append(f"INSERT INTO `card_traps` (`id`, `name`, `type`, `keyword`, `quality`, `max_count`, `pinyin`, `description`, `guide`) VALUES\n" + ",\n".join(batch) + ";")
sql_lines.append("")

# 5. Table `card_extra` (Fusion, Synchro, Xyz, Link)
print("Generating card_extra SQL...")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append(f"-- Table structure and data for `card_extra` ({len(raw_extra)} records)")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append("""CREATE TABLE `card_extra` (
  `id` INT PRIMARY KEY COMMENT 'Mã ID thẻ bài Extra Deck',
  `name` VARCHAR(100) NOT NULL COMMENT 'Tên quái thú Extra Deck',
  `summon_type` VARCHAR(30) NOT NULL DEFAULT 'Dung Hợp' COMMENT 'Phương thức triệu hồi (Dung Hợp, Synchro, Xyz, Link)',
  `category` VARCHAR(50) DEFAULT 'Khác' COMMENT 'Chủng tộc',
  `attribute` VARCHAR(20) DEFAULT 'Không có' COMMENT 'Thuộc tính',
  `keyword` VARCHAR(50) DEFAULT 'Không có' COMMENT 'Từ khóa / Archetype',
  `stars` TINYINT NOT NULL DEFAULT 1 COMMENT 'Cấp sao / Rank / Link Rating',
  `atk` INT NOT NULL DEFAULT 0 COMMENT 'Sức tấn công ATK',
  `def` INT NOT NULL DEFAULT 0 COMMENT 'Sức phòng thủ DEF (HP)',
  `quality` VARCHAR(10) NOT NULL DEFAULT 'UR' COMMENT 'Độ hiếm',
  `materials` JSON DEFAULT NULL COMMENT 'Mảng ID nguyên liệu triệu hồi (JSON)',
  `link_arrows` JSON DEFAULT NULL COMMENT 'Mảng hướng mũi tên Link (JSON)',
  `pinyin` VARCHAR(20) DEFAULT NULL COMMENT 'Mã viết tắt Pinyin',
  `description` TEXT DEFAULT NULL COMMENT 'Mô tả / Hiệu ứng',
  `guide` TEXT DEFAULT NULL COMMENT 'Hướng dẫn / combo',
  KEY `idx_stype` (`summon_type`),
  KEY `idx_cat` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n""")

e_values = []
for e in raw_extra:
    cid = e['_id']
    name = get_text(e['_nameSid'])
    cat = get_category_name(e['_category'])
    attr = NATURE_NAMES.get(e['_nature'], "Khác")
    kw = get_keyword_name(e['_keyword'])
    star = e['_star']
    atk = e['_atk'][0] if e['_atk'] else 0
    df = e['_hp'][0] if e['_hp'] else 0
    q = QUALITY_NAMES.get(e['_quality'], "UR")
    py = e['_py']
    desc = get_text(e['_descSid'])
    guide = get_text(e['_guideSid'])
    
    # Determine summon type
    opt = e.get('_option', 0)
    if opt & 0x2000:
        stype = "Link"
    elif opt & 0x400:
        stype = "Xyz"
    elif opt & 0x200:
        stype = "Synchro"
    elif opt & 0x4 or (e.get('_joinComponent') and any(x > 0 for x in e.get('_joinComponent'))):
        stype = "Dung Hợp"
    else:
        stype = "Dung Hợp"
    
    mats = e.get('_joinComponent', [])
    links = e.get('_link', [])
    
    e_values.append(f"({cid}, {escape_sql(name)}, {escape_sql(stype)}, {escape_sql(cat)}, {escape_sql(attr)}, {escape_sql(kw)}, {star}, {atk}, {df}, {escape_sql(q)}, {escape_sql(mats)}, {escape_sql(links)}, {escape_sql(py)}, {escape_sql(desc)}, {escape_sql(guide)})")

for i in range(0, len(e_values), BATCH_SIZE):
    batch = e_values[i:i+BATCH_SIZE]
    sql_lines.append(f"INSERT INTO `card_extra` (`id`, `name`, `summon_type`, `category`, `attribute`, `keyword`, `stars`, `atk`, `def`, `quality`, `materials`, `link_arrows`, `pinyin`, `description`, `guide`) VALUES\n" + ",\n".join(batch) + ";")
sql_lines.append("")

# 6. Table `system_decks` (125 Pre-built Decks from troop.bin)
print("Generating system_decks SQL...")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append(f"-- Table structure and data for `system_decks` ({len(raw_troops)} pre-built campaign decks)")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append("""CREATE TABLE `system_decks` (
  `id` INT PRIMARY KEY COMMENT 'Mã ID bộ bài',
  `deck_name` VARCHAR(100) NOT NULL COMMENT 'Tên bộ bài / Chủ đề',
  `fortress_hp` INT NOT NULL DEFAULT 8000 COMMENT 'Điểm gốc LP nhân vật',
  `cards` JSON NOT NULL COMMENT 'Danh sách ID toàn bộ các lá bài trong bộ bài (JSON Array)',
  `card_counts` JSON NOT NULL COMMENT 'Chi tiết ID và số lượng từng lá (JSON Object)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n""")

troop_values = []
for t in raw_troops:
    did = t['_id']
    dname = get_text(t['_nameSid'])
    if not dname or dname == "0":
        dname = f"Bộ Bài #{did}"
    hp = t['_fortressHp']
    deck_list = []
    card_map = {}
    for cid, cnt in zip(t['_infoId'], t['_num']):
        deck_list.extend([cid] * cnt)
        card_map[str(cid)] = cnt
    troop_values.append(f"({did}, {escape_sql(dname)}, {hp}, {escape_sql(deck_list)}, {escape_sql(card_map)})")

for i in range(0, len(troop_values), BATCH_SIZE):
    batch = troop_values[i:i+BATCH_SIZE]
    sql_lines.append(f"INSERT INTO `system_decks` (`id`, `deck_name`, `fortress_hp`, `cards`, `card_counts`) VALUES\n" + ",\n".join(batch) + ";")
sql_lines.append("")

# 7. Table `user_decks`
print("Generating user_decks SQL...")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append("-- Table structure and data for `user_decks` (Player Decks stored in JSON format)")
sql_lines.append("-- --------------------------------------------------------------------")
sql_lines.append("""CREATE TABLE `user_decks` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `account_id` INT NOT NULL COMMENT 'Khóa ngoại trỏ đến accounts.id',
  `deck_slot` INT NOT NULL DEFAULT 1 COMMENT 'Vị trí bộ bài (1-15)',
  `deck_name` VARCHAR(100) NOT NULL DEFAULT 'Bộ Bài Mới' COMMENT 'Tên bộ bài',
  `cards` JSON NOT NULL COMMENT 'Mảng JSON danh sách ID các lá bài Main Deck',
  `extra_cards` JSON DEFAULT NULL COMMENT 'Mảng JSON danh sách ID các lá bài Extra Deck',
  `is_active` TINYINT NOT NULL DEFAULT 0 COMMENT '1 = Đang kích hoạt sử dụng',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`account_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE,
  KEY `idx_acc` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n""")

# Sample Decks for Admin (Account 1):
# Deck 1: Rồng Trắng Mắt Xanh (Pure Blue-Eyes deck)
blue_eyes_main = [
    10001, 10001, 10001, # 3x Rồng Trắng Mắt Xanh
    10002, 10002, 10002, # 3x Phù Thủy Trắng
    10003, 10003, 10003, # 3x Phù Thủy Thời Gian
    10004, 10004, 10004, # 3x Phù Thủy Bóng Đêm
    10005, 10005, 10005, # 3x Phù Thủy Áo Đen
    10006, 10006, 10006, # 3x Nữ Phù Thủy Áo Đen
    10007, 10007,        # 2x Baby Dragon
    20001, 20001, 20001, # 3x Sách Phép Thuật
    20002, 20002, 20002, # 3x Ngàn Dao
    20005, 20005, 20005, # 3x Dung Hợp
    20007, 20007, 20007, # 3x Rồng trắng giáng xuống
    20030, 20030,        # 2x Hồi Sinh Tử Giả
    30001, 30001, 30001, # 3x Holy Shield
    30002, 30002, 30002, # 3x Cạm Bẫy
]
blue_eyes_extra = [40001, 40001, 40001, 40148, 40301]

# Deck 2: Rồng Đen Mắt Đỏ (Pure Red-Eyes deck)
red_eyes_main = [
    10055, 10055, 10055,
    10056, 10056, 10056,
    10018, 10018, 10018,
    10019, 10019, 10019,
    10020, 10020, 10020,
    10048, 10048, 10048,
    20051, 20051, 20051,
    20060, 20060, 20060,
    20030, 20030, 20030,
    30001, 30001, 30001,
    30018, 30018, 30018,
    30025, 30025, 30025,
    30027, 30027, 30027,
    30028, 30028
]
red_eyes_extra = [40039, 40040, 40041]

# Deck 3: Phù Thủy Áo Đen (Dark Magician deck)
dark_magician_main = [
    10004, 10004, 10004,
    10005, 10005, 10005,
    10006, 10006, 10006,
    10012, 10012, 10012,
    10035, 10035, 10035,
    20001, 20001, 20001,
    20002, 20002, 20002,
    20006, 20006, 20006,
    20009, 20009, 20009,
    20010, 20010, 20010,
    20013, 20013, 20013,
    20014, 20014, 20014,
    30001, 30001, 30001,
    30006, 30006
]
dark_magician_extra = [40006, 40007, 40008]

sample_user_decks = [
    (1, 1, "Bộ Bài Mắt Xanh Siêu Cấp", blue_eyes_main, blue_eyes_extra, 1),
    (1, 2, "Bộ Bài Mắt Đỏ Tối Thượng", red_eyes_main, red_eyes_extra, 0),
    (1, 3, "Bộ Bài Phù Thủy Áo Đen", dark_magician_main, dark_magician_extra, 0),
    (2, 1, "Bộ Bài Seto Kaiba Mắt Xanh", blue_eyes_main, blue_eyes_extra, 1),
    (3, 1, "Bộ Bài Joey Wheeler Mắt Đỏ", red_eyes_main, red_eyes_extra, 1),
]

for d in sample_user_decks:
    sql_lines.append(
        f"INSERT INTO `user_decks` (`account_id`, `deck_slot`, `deck_name`, `cards`, `extra_cards`, `is_active`) VALUES "
        f"({d[0]}, {d[1]}, {escape_sql(d[2])}, {escape_sql(d[3])}, {escape_sql(d[4])}, {d[5]});"
    )
sql_lines.append("")

# Write output SQL file
target_sql = r"D:\yugitauapk\yugioh_game.sql"
print(f"Writing complete SQL dump to {target_sql}...")
with open(target_sql, "w", encoding="utf-8") as f:
    f.write("\n".join(sql_lines))

print(f"SUCCESS! Wrote {len(sql_lines)} lines to {target_sql} (size: {os.path.getsize(target_sql)} bytes)")

# Also write JSON export for backend APIs
json_export = {
    "generated_at": datetime.now().isoformat(),
    "database": "yugioh_game",
    "stats": {
        "monsters": len(raw_monsters),
        "spells": len(raw_spells),
        "traps": len(raw_traps),
        "extra_cards": len(raw_extra),
        "total_cards": len(raw_monsters) + len(raw_spells) + len(raw_traps) + len(raw_extra),
        "system_decks": len(raw_troops)
    },
    "sample_accounts": accounts_seed,
    "sample_decks": [
        {"deck_name": d[2], "account_id": d[0], "cards": d[3], "extra_cards": d[4]} for d in sample_user_decks
    ]
}

target_json = r"D:\yugitauapk\yugioh_database_summary.json"
with open(target_json, "w", encoding="utf-8") as f:
    json.dump(json_export, f, indent=2, ensure_ascii=False)

print(f"Summary JSON saved to {target_json}!")
