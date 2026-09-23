import sys
import json
import pymysql
import re
import os
from collections import defaultdict, Counter

sys.stdout.reconfigure(encoding='utf-8')

print("==================================================")
print("BUILDING 100% COMPLETE PACK DISTRIBUTION (124 PACKS)")
print("==================================================")

conn = pymysql.connect(
    host='127.0.0.1', user='root', password='', database='yugioh_game',
    charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor
)
cur = conn.cursor()

# 1. Fetch all cards
cur.execute("""
    SELECT id, name, keyword, quality, 'monster' as tbl FROM card_monsters
    UNION ALL SELECT id, name, keyword, quality, 'spell' as tbl FROM card_spells
    UNION ALL SELECT id, name, keyword, quality, 'trap' as tbl FROM card_traps
    UNION ALL SELECT id, name, keyword, quality, 'extra' as tbl FROM card_extra
""")
all_cards = {r['id']: r for r in cur.fetchall()}

# Forbidden cards
forbidden_cids = {
    20804, 20805, 20806, 20807, 20808, 20809, 20810, 30439, 11309, 20525,
    20841, 20842, 20843, 20844, 20845,
    20961, 20962, 20963, 20964, 20965,
    20981, 20982, 20983, 20984, 20985,
    20233, 20236, 11753
}

def is_excluded(c):
    cid = c['id']
    if cid in forbidden_cids: return True
    name = (c['name'] or '').lower()
    if any(k in name for k in ['token', 'mã thông báo', 'diễn sinh', 'thay thế', 'tạm thời', 'chiến đao']): return True
    return False

valid_cards = {cid: c for cid, c in all_cards.items() if not is_excluded(c)}
print(f"Total valid cards in DB: {len(valid_cards)}")

# Ancient card IDs
with open('web/data/ancient_products.lua', 'r', encoding='utf-8') as f:
    anc_text = f.read()
ancient_cids = set(int(m.group(1)) for m in re.finditer(r'\[\"_cardId\"\]=(\d+)', anc_text))

# Base maps
with open('char_cards_map.json', 'r', encoding='utf-8') as f:
    orig_char = {int(k): list(v) for k, v in json.load(f).items()}
with open('liya_cards_map.json', 'r', encoding='utf-8') as f:
    orig_liya = {int(k): list(v) for k, v in json.load(f).items()}
with open('extra_cards_map.json', 'r', encoding='utf-8') as f:
    orig_extra = {int(k): list(v) for k, v in json.load(f).items()}

all_placed_cards = set()

char_packs = defaultdict(list)
for p in range(1, 21):
    for cid in orig_char.get(p, []):
        if cid in valid_cards:
            char_packs[p].append(cid)
            all_placed_cards.add(cid)

liya_packs = defaultdict(list)
for p in range(1, 21):
    for cid in orig_liya.get(p, []):
        if cid in valid_cards:
            liya_packs[p].append(cid)
            all_placed_cards.add(cid)

extra_packs = defaultdict(list)
for p in range(1, 23):
    for cid in orig_extra.get(p, []):
        if cid in valid_cards:
            extra_packs[p].append(cid)
            all_placed_cards.add(cid)

# Absorb remaining archetype cards into existing packs
def absorb(target_map, pack_key, cond_fn):
    for cid, c in valid_cards.items():
        if cid not in all_placed_cards and cond_fn(c):
            target_map[pack_key].append(cid)
            all_placed_cards.add(cid)

absorb(char_packs, 1, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Mắt Xanh', 'Blue-Eyes']))
absorb(char_packs, 2, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Mắt Đỏ', 'Red-Eyes']))
absorb(char_packs, 3, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Phù Thủy Áo Đen', 'Dark Magician', 'Kuriboh', 'Nữ Phù Thủy']))
absorb(char_packs, 4, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Thánh Kỵ', 'Noble Knight', 'Hiệp Sĩ']))
absorb(char_packs, 5, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Anh Hùng Nguyên Tố', 'Elemental HERO', 'Tân Không Gian', 'Neos', 'Dung Hợp']))
absorb(char_packs, 6, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Anh Hùng Định Mệnh', 'Destiny HERO']))
absorb(char_packs, 7, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Đồng Bộ', 'Synchron', 'Bụi Sao', 'Stardust', 'Tuner', 'Chiến Sĩ']))
absorb(char_packs, 8, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Cánh Đen', 'Blackwing', 'Lông Đen']))
absorb(char_packs, 9, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Ngân Hà', 'Galaxy-Eyes', 'Photon']))
absorb(char_packs, 10, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Utopia', 'Hy Vọng Hoàng', 'Zexal', 'ZW']))
absorb(char_packs, 11, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Rồng Điện Tử', 'Cyber Dragon', 'Cyberdark']))
absorb(char_packs, 12, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Ojama']))
absorb(char_packs, 13, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Khủng Long', 'Jurrac', 'Dinosaur']))
absorb(char_packs, 14, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Harpie', 'Nữ Quái Harpie', 'Hài Cốt']))
absorb(char_packs, 15, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Toon', 'Thế Giới Toon']))
absorb(char_packs, 16, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Thế Giới Bóng Tối', 'Dark World']))
absorb(char_packs, 17, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Lục Vũ Chúng', 'Six Samurai']))
absorb(char_packs, 18, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Thiên Thần Sa Ngã', 'Darklord']))
absorb(char_packs, 19, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Cơ Khí Cổ Đại', 'Ancient Gear']))
absorb(char_packs, 20, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Amazoness']))

absorb(liya_packs, 1, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Kết Giới Băng', 'Ice Barrier']))
absorb(liya_packs, 2, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Lửa Vĩnh Cửu', 'Infernity']))
absorb(liya_packs, 3, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Chiến Thần Bujin', 'Bujin']))
absorb(liya_packs, 4, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Vampire', 'Ma Cà Rồng']))
absorb(liya_packs, 5, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Rồng Khổng Lồ Felgrand', 'Felgrand']))
absorb(liya_packs, 6, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Công Nghệ TG', 'T.G.']))
absorb(liya_packs, 7, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Tuyên Cáo Herald', 'Herald']))
absorb(liya_packs, 8, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Mermail', 'Thủy Tinh Linh']))
absorb(liya_packs, 9, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Nắm Đấm Lửa', 'Fire Fist']))
absorb(liya_packs, 10, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Constellar', 'Tinh Túc']))
absorb(liya_packs, 11, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Evilswarm', 'Nhập Ma']))
absorb(liya_packs, 12, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Thánh Kỵ', 'Noble Knight']))
absorb(liya_packs, 13, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Ghostrick', 'Halloween', 'Cương Thi Goblin']))
absorb(liya_packs, 14, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Bánh Ngọt Madolche', 'Madolche']))
absorb(liya_packs, 15, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Chronomaly', 'Di Sản Tiền Sử']))
absorb(liya_packs, 16, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Huyễn Thú Cơ', 'Mecha Phantom']))
absorb(liya_packs, 17, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Traptrix', 'Quỷ Côn Trùng']))
absorb(liya_packs, 18, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Sylvan', 'Lâm Tinh']))
absorb(liya_packs, 19, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Artifact', 'Thần Trí Chi Khí']))
absorb(liya_packs, 20, lambda c: any(k in (c['keyword'] or '') or k in c['name'] for k in ['Búp Bê Bóng Đêm Shaddoll', 'Shaddoll']))

# Tab 3: 32 New Archetype Packs (Packs 23..54)
ARCHETYPE_PACKS = [
    (23, "Gói Bài Quyền Thủ Lửa", ['Quyền Thủ Lửa', 'Thú Sĩ Nhiệt Huyết', 'Tay Đấm'], 102001),
    (24, "Gói Bài Kiếm Sĩ X", ['Kiếm Sĩ X', 'X-Saber'], 103001),
    (25, "Gói Bài Số Hiệu No.", ['No.', 'CNo.', 'Số Hiệu', 'Xyz', 'Nâng Cấp Phép Thuật'], 104001),
    (26, "Gói Bài Rồng Hoa Hồng", ['Hoa Hồng', 'Rồng Hoa Hồng'], 105001),
    (27, "Gói Bài Huyễn Thú Cơ", ['Huyễn Thú Cơ', 'Robot Ảo Thú'], 106001),
    (28, "Gói Bài Tam Quốc Diễn Nghĩa", ['Tam Quốc'], 107001),
    (29, "Gói Bài Linh Hồn Nhập & Quỷ Xâm Lược", ['Linh Hồn Nhập', 'Quỷ Xâm Lược', 'Steelswarm'], 108001),
    (30, "Gói Bài Hương Thơm Aromage", ['Hương Thơm', 'Aroma'], 109001),
    (31, "Gói Bài Tam Ma Thần & Ác Ma", ['Ma Thuật', 'Uriah', 'Hammon', 'Raviel', 'Ác Ma'], 110001),
    (32, "Gói Bài Rồng Lửa Đỏ & Cộng Hưởng", ['Cộng Hưởng Resonator', 'Rồng Lửa Đỏ'], 111001),
    (33, "Gói Bài Đạn Pháo & Nòng Súng Borrel", ['Đạn Pháo', 'Nòng Súng Borrel', 'Rokket', 'Borrel'], 112001),
    (34, "Gói Bài Cơ Xảo Karakuri", ['Cơ Xảo Karakuri', 'Karakuri', 'Biến Hình Morphtronic', 'Rối Cơ Khí Gimmick'], 113001),
    (35, "Gói Bài D/D/D & Khế Ước Tối", ['DD', 'DDD', 'Khế Ước Tối', 'Dị Thứ Nguyên DD'], 114001),
    (36, "Gói Bài Quái Thú Bò Sát", ['Bò Sát', 'Rắn'], 115001),
    (37, "Gói Bài Sức Mạnh Bí Thuật", ['Sức Mạnh Thần Bí', 'Arcana Force'], 116001),
    (38, "Gói Bài Anh Hùng Bóng Đêm", ['Anh Hùng Tà Ác', 'Anh Hùng Mặt Nạ', 'Anh Hùng Ảo Ảnh', 'Dung Hợp Bóng Tối'], 117001),
    (39, "Gói Bài Kiếm Diệt Rồng", ['Kiếm Diệt Rồng', 'Kiếm Sĩ Diệt Rồng'], 118001),
    (40, "Gói Bài Trẻ Nghịch Ngợm P.U.N.K.", ['Trẻ Nghịch Ngợm', 'P.U.N.K.', 'Tâm Linh Psychic', 'Khung Xương PSY'], 119001),
    (41, "Gói Bài Chim Săn Mồi Raidraptor", ['Chim Săn Mồi Raidraptor', 'Raidraptor'], 120001),
    (42, "Gói Bài Công Chúa Biển Marincess", ['Công Chúa Biển Marincess', 'Marincess'], 101001),
    (43, "Gói Bài Triệu Hồi Thú & Ảo Thú", ['Triệu Hồi Thú Invoked', 'Ma Thú'], 102001),
    (44, "Gói Bài Thiên Thần & Nghi Thức", ['Thiên Thần Điện Tử', 'Ác Quỷ Nghi Thức', 'Thiên Không Thánh Vực', 'Perseus', 'Thủ Mộ', 'Lôi Tinh Spright'], 103001),
    (45, "Gói Bài Đoàn Tàu Chiến Hạng Nặng", ['Đoàn Tàu'], 104001),
    (46, "Gói Bài Hoa Tuyết Rikka", ['Hoa Tuyết Rikka', 'Thánh Hoa'], 105001),
    (47, "Gói Bài Vua Lửa Fire King", ['Vua Lửa', 'Thú Vua Lửa'], 106001),
    (48, "Gói Bài Thánh Nhạc Tự Đàn Orcust", ['Orcus', 'Thánh Nhạc Tự Đàn'], 107001),
    (49, "Gói Bài Gusto & Phù Thủy Gió", ['Gusto', 'Phù Thủy Gió', 'Gió Lốc Windwitch'], 108001),
    (50, "Gói Bài Chiến Hạm Không Gian B.E.S.", ['Chiến Hạm Khổng Lồ', 'Chiến Hạm'], 109001),
    (51, "Gói Bài Cổ Điển: Exodia & Hỗn Độn", ['Phong Ấn Exodia', 'Chiến Binh Hỗn Độn', 'Kỵ Sĩ Gaia', 'Chiến Binh Nam Châm', 'Gandora', 'Người Nhân Tạo Jinzo', 'Hỗn Độn Chaos', 'Barbaros'], 110001),
    (52, "Gói Bài Quái Vật Nâng Cấp LV", ['LV'], 111001),
    (53, "Gói Bài Thú Hóa Học & Tiến Hóa", ['Thú Hóa Học', 'Rồng Tiến Hóa', 'Côn Trùng Tiến Hóa'], 112001),
    (54, "Gói Bài Xứ Sở Cổ Tích & Yêu Tinh", ['Công Chúa Cổ Tích', 'Người Bảo Hộ', 'Chim Cánh Cụt', 'Ếch', 'Bộ Xương', 'Không Nha Đoàn', 'Hoa Trát Flower Cardian'], 113001)
]

for pnum, pname, keywords, fallback_img in ARCHETYPE_PACKS:
    p_cards = []
    for cid, c in valid_cards.items():
        if cid not in all_placed_cards:
            ckw = (c['keyword'] or '').lower()
            cname = (c['name'] or '').lower()
            if any(k.lower() in ckw or k.lower() in cname for k in keywords):
                p_cards.append(cid)
                all_placed_cards.add(cid)
    extra_packs[pnum] = p_cards

# Tab 4: 30 Expansion Packs
unplaced_cids = sorted(list(set(valid_cards.keys()) - all_placed_cards))
print(f"Cards placed before expansion packs: {len(all_placed_cards)}")
print(f"Remaining generic cards for Tab 4: {len(unplaced_cids)}")

expansion_packs = defaultdict(list)
num_exp_packs = 30

q_order = {'GR': 0, 'UR': 1, 'SR': 2, 'R': 3, 'N': 4}
sorted_unplaced = sorted(unplaced_cids, key=lambda cid: (q_order.get(valid_cards[cid]['quality'], 5), valid_cards[cid]['tbl']))

for idx, cid in enumerate(sorted_unplaced):
    p_idx = (idx % num_exp_packs) + 1
    expansion_packs[p_idx].append(cid)
    all_placed_cards.add(cid)

print(f"Cards placed after Tab 4 expansion packs: {len(all_placed_cards)} / {len(valid_cards)}")
assert len(all_placed_cards) == len(valid_cards), "Mismatch in total card placement!"

# Complete quality ladders for every pack
all_ur_cards = [cid for cid, c in valid_cards.items() if c['quality'] == 'UR']
all_sr_cards = [cid for cid, c in valid_cards.items() if c['quality'] == 'SR']
all_r_cards = [cid for cid, c in valid_cards.items() if c['quality'] == 'R']
all_n_cards = [cid for cid, c in valid_cards.items() if c['quality'] == 'N']

for t_name, p_map, max_p in [("Tab 1 Char", char_packs, 20), ("Tab 2 Liya", liya_packs, 20), ("Tab 3 Extra", extra_packs, 54), ("Tab 4 Expansion", expansion_packs, 30)]:
    for p in range(1, max_p + 1):
        q_cnt = Counter(valid_cards[c]['quality'] for c in p_map[p])
        if q_cnt['UR'] == 0 and q_cnt['GR'] == 0:
            for i in range(3):
                ur_cid = all_ur_cards[(p * 3 + i) % len(all_ur_cards)]
                if ur_cid not in p_map[p]: p_map[p].append(ur_cid)
        if q_cnt['SR'] < 3:
            for i in range(3):
                sr_cid = all_sr_cards[(p * 3 + i) % len(all_sr_cards)]
                if sr_cid not in p_map[p]: p_map[p].append(sr_cid)
        if q_cnt['R'] < 5:
            for i in range(5):
                r_cid = all_r_cards[(p * 5 + i) % len(all_r_cards)]
                if r_cid not in p_map[p]: p_map[p].append(r_cid)
        if q_cnt['N'] < 5:
            for i in range(5):
                n_cid = all_n_cards[(p * 5 + i) % len(all_n_cards)]
                if n_cid not in p_map[p]: p_map[p].append(n_cid)

# Sync variations
for p in range(1, 21):
    val = 10100 + p * 100 + 1
    cards = char_packs[p]
    char_packs[val] = cards
    char_packs[val + 9] = cards
    char_packs[val + 49] = cards

for p in range(1, 21):
    val = 100000 + p * 1000
    cards = liya_packs[p]
    liya_packs[val + 1] = cards
    liya_packs[val + 10] = cards
    liya_packs[val + 50] = cards

for p in range(1, 55):
    val = 120000 + p * 1000
    cards = extra_packs[p]
    extra_packs[val + 1] = cards
    extra_packs[val + 10] = cards
    extra_packs[val + 50] = cards

for p in range(1, 31):
    val = 180000 + p * 1000
    cards = expansion_packs[p]
    expansion_packs[val + 1] = cards
    expansion_packs[val + 10] = cards
    expansion_packs[val + 50] = cards

# Save JSON maps
with open('char_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in char_packs.items()}, f, indent=2, ensure_ascii=False)
with open('liya_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in liya_packs.items()}, f, indent=2, ensure_ascii=False)
with open('extra_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in extra_packs.items()}, f, indent=2, ensure_ascii=False)
with open('expansion_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in expansion_packs.items()}, f, indent=2, ensure_ascii=False)

# Build PACK_QUALITY_DISTRIBUTION
pack_quality_distribution = {}
for p_map, max_p, base_fn in [
    (char_packs, 20, lambda p: 10100 + p * 100 + 1),
    (liya_packs, 20, lambda p: 100000 + p * 1000 + 10),
    (extra_packs, 54, lambda p: 120000 + p * 1000 + 10),
    (expansion_packs, 30, lambda p: 180000 + p * 1000 + 10)
]:
    for p in range(1, max_p + 1):
        cids = p_map[p]
        base_id = base_fn(p)
        q_pools = {'GR': [], 'UR_ANCIENT': [], 'UR': [], 'SR': [], 'R': [], 'N': []}
        for cid in cids:
            c = valid_cards.get(cid)
            if c:
                cq = (c.get('quality') or 'N').upper()
                if cq == 'GR': q_pools['GR'].append(cid)
                elif cid in ancient_cids: q_pools['UR_ANCIENT'].append(cid)
                elif cq == 'UR': q_pools['UR'].append(cid)
                elif cq == 'SR': q_pools['SR'].append(cid)
                elif cq == 'R': q_pools['R'].append(cid)
                else: q_pools['N'].append(cid)
        pack_quality_distribution[base_id] = q_pools

with open('pack_quality_distribution.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in pack_quality_distribution.items()}, f, indent=2, ensure_ascii=False)

# Build all_60_packs_summary.json (now all_packs_summary.json with all 124 packs)
with open('all_60_packs_summary.json', 'r', encoding='utf-8') as f:
    old_summary = json.load(f)

summary = {
    'char_packs': [],
    'liya_packs': [],
    'extra_packs': [],
    'expansion_packs': []
}

for p in old_summary['char_packs']:
    num = p['num']
    summary['char_packs'].append({
        'num': num,
        'value': p['value'],
        'name': p['name'],
        'fallback_img': p['fallback_img'],
        'cards': char_packs[num]
    })

for p in old_summary['liya_packs']:
    num = p['num']
    summary['liya_packs'].append({
        'num': num,
        'value': p['value'],
        'name': p['name'],
        'fallback_img': p['fallback_img'],
        'cards': liya_packs[num]
    })

for p in old_summary['extra_packs'][:22]:
    num = p['num']
    summary['extra_packs'].append({
        'num': num,
        'value': p['value'],
        'name': p['name'],
        'fallback_img': p['fallback_img'],
        'cards': extra_packs[num]
    })

for pnum, pname, _, fallback_img in ARCHETYPE_PACKS:
    summary['extra_packs'].append({
        'num': pnum,
        'value': 120000 + pnum * 1000 + 10,
        'name': pname,
        'fallback_img': fallback_img,
        'cards': extra_packs[pnum]
    })

EXPANSION_NAMES = [
    (1, "Gói Mở Rộng: Quái Thú Tiêu Chuẩn I"),
    (2, "Gói Mở Rộng: Quái Thú Tiêu Chuẩn II"),
    (3, "Gói Mở Rộng: Quái Thú Tiêu Chuẩn III"),
    (4, "Gói Mở Rộng: Quái Thú Tiêu Chuẩn IV"),
    (5, "Gói Mở Rộng: Quái Thú Tiêu Chuẩn V"),
    (6, "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VI"),
    (7, "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VII"),
    (8, "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VIII"),
    (9, "Gói Mở Rộng: Quái Thú Tiêu Chuẩn IX"),
    (10, "Gói Mở Rộng: Quái Thú Tiêu Chuẩn X"),
    (11, "Gói Mở Rộng: Ma Pháp Toàn Năng I"),
    (12, "Gói Mở Rộng: Ma Pháp Toàn Năng II"),
    (13, "Gói Mở Rộng: Ma Pháp Toàn Năng III"),
    (14, "Gói Mở Rộng: Ma Pháp Toàn Năng IV"),
    (15, "Gói Mở Rộng: Ma Pháp Toàn Năng V"),
    (16, "Gói Mở Rộng: Ma Pháp Toàn Năng VI"),
    (17, "Gói Mở Rộng: Ma Pháp Toàn Năng VII"),
    (18, "Gói Mở Rộng: Ma Pháp Toàn Năng VIII"),
    (19, "Gói Mở Rộng: Ma Pháp Toàn Năng IX"),
    (20, "Gói Mở Rộng: Ma Pháp Toàn Năng X"),
    (21, "Gói Mở Rộng: Cạm Bẫy Chiến Lược I"),
    (22, "Gói Mở Rộng: Cạm Bẫy Chiến Lược II"),
    (23, "Gói Mở Rộng: Cạm Bẫy Chiến Lược III"),
    (24, "Gói Mở Rộng: Cạm Bẫy Chiến Lược IV"),
    (25, "Gói Mở Rộng: Cạm Bẫy Chiến Lược V"),
    (26, "Gói Mở Rộng: Extra Deck Tổng Hợp I"),
    (27, "Gói Mở Rộng: Extra Deck Tổng Hợp II"),
    (28, "Gói Mở Rộng: Extra Deck Tổng Hợp III"),
    (29, "Gói Mở Rộng: Extra Deck Tổng Hợp IV"),
    (30, "Gói Mở Rộng: Extra Deck Tổng Hợp V")
]

for pnum, pname in EXPANSION_NAMES:
    summary['expansion_packs'].append({
        'num': pnum,
        'value': 180000 + pnum * 1000 + 10,
        'name': pname,
        'fallback_img': 101001 + (pnum % 10) * 1000,
        'cards': expansion_packs[pnum]
    })

with open('all_60_packs_summary.json', 'w', encoding='utf-8') as f:
    json.dump(summary, f, indent=2, ensure_ascii=False)

print("\nSaved all mapping JSON files successfully!")
print(f"Summary total packs: {len(summary['char_packs'])} Char + {len(summary['liya_packs'])} Liya + {len(summary['extra_packs'])} Extra + {len(summary['expansion_packs'])} Expansion = {len(summary['char_packs']) + len(summary['liya_packs']) + len(summary['extra_packs']) + len(summary['expansion_packs'])} total packs!")
