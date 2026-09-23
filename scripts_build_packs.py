import sys
sys.stdout.reconfigure(encoding='utf-8')
import pymysql
import json
import re
from collections import defaultdict

conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4')
cursor = conn.cursor(pymysql.cursors.DictCursor)

cursor.execute("""
    SELECT id, name, keyword, quality FROM (
        SELECT id, name, keyword, quality FROM card_monsters
        UNION ALL SELECT id, name, keyword, quality FROM card_spells
        UNION ALL SELECT id, name, keyword, quality FROM card_traps
        UNION ALL SELECT id, name, '' AS keyword, quality FROM card_extra
    ) AS all_cards
""")
all_cards = {r['id']: r for r in cursor.fetchall()}

with open('web/data/ancient_products.lua', 'r', encoding='utf-8') as f:
    anc_text = f.read()
ancient_cids = set(int(m.group(1)) for m in re.finditer(r'\[\"_cardId\"\]=(\d+)', anc_text))

forbidden_cids = {20804, 20805, 20806, 20807, 20808, 20809, 20810, 30439, 11309}

def is_excluded(c):
    name = c['name'].lower()
    if 'token' in name or 'mã thông báo' in name or 'diễn sinh' in name:
        return True
    if 'thay thế' in name:
        return True
    if c['id'] in forbidden_cids:
        return True
    return False

valid_cards = {cid: c for cid, c in all_cards.items() if not is_excluded(c)}

# 20 Character Deck Specs
# ID range: 10201..12101 (pack numbers 1..20)
CHAR_SPECS = [
    (1, 10201, "Gói Bài Rồng Trắng", ["Mắt Xanh", "Blue-Eyes", "Kaibaman", "Đá Trắng", "Rồng Trắng Hút Hồn", "Rồng Bạc Mắt Xanh", "Rồng Lai Mắt Xanh", "Thiếu Nữ Mắt Xanh", "Hiền Giả Mắt Xanh", "Tế Tự Mắt Xanh", "Song Hồn Mắt Xanh", "Chân Nhãn", "Uy Áp Của Rồng", "Tiếng Gầm Của Uy Áp"], 10201),
    (2, 10301, "Gói Bài Rồng Đen", ["Mắt Đỏ", "Red-Eyes", "Hắc Long", "Đá Đen", "Rồng Con Mắt Đỏ", "Rồng Thép Mắt Đỏ", "Rồng Chém Gió", "Rồng Pháo Kim Loại", "Dung Hợp Mắt Đỏ", "Hắc Viêm Đạn", "Chiến Sĩ Rồng Đen", "Nanh Xích Mắt Đỏ", "Nghi Thức Mắt Đỏ", "Linh Hồn Mắt Đỏ"], 10501),
    (3, 10401, "Gói Bài Phù Thủy Áo Đen", ["Phù Thủy Áo Đen", "Dark Magician", "Ma Đạo Sĩ", "Nữ Phù Thủy Áo Đen", "Học Trò Phù Thủy", "Hắc Ma Thuật", "Hắc Ma Đạo", "Quan Tài Kín", "Ma Thuật Bí Mật", "Rèm Ma Thuật", "Bậc Thầy Ma Thuật", "Pháp sư bóng tối Mahad"], 10301),
    (4, 10501, "Gói Bài Thánh Kỵ", ["Thánh Kỵ", "Thánh Kiếm", "Noble Knight", "Guinevere", "Charlie", "Roland", "Astolfo", "Ogier", "Rinaldo", "Mogis", "Turpin", "Isolde", "Excalibur"], 10401),
    (5, 10601, "Gói Bài Anh Hùng Nguyên Tố", ["Anh Hùng Nguyên Tố", "Elemental HERO", "Neos", "Xinyuxia", "Bong Bóng Lấp Lánh", "Cánh Lửa", "Dung Hợp Anh Hùng", "E·HERO"], 11201),
    (6, 10701, "Gói Bài Anh Hùng Định Mệnh", ["Anh Hùng Định Mệnh", "Destiny HERO", "Plasma", "Dreadmaster", "Bloo-D", "Diamond Dude", "Malicious", "D-Hero", "Dutopia"], 11201),
    (7, 10801, "Gói Bài Đồng Bộ", ["Synchron", "Đồng Bộ", "Bụi Sao", "Stardust", "Tăng Tốc Đồng Bộ", "Chiến Binh Đồng Bộ", "Rồng Bụi Sao", "Junk", "Phế Liệu Đồng Bộ"], 11301),
    (8, 10901, "Gói Bài Cánh Đen", ["Blackwing", "Cánh Đen", "Lông Đen", "Aurora", "Gale", "Bora", "Sirocco", "Armor Master", "Cơn Lốc Đen"], 10601),
    (9, 11001, "Gói Bài Ngân Hà", ["Mắt Ngân Hà", "Ngân Hà", "Photon", "Galaxy-Eyes", "Rồng Ánh Sáng Tinh Vân", "Afterglow", "Số 62", "Số 107", "Kaito"], 10701),
    (10, 11101, "Gói Bài Utopia", ["Số 39", "Hy Vọng Hoàng", "Zexal", "Vũ Khí Zexal", "ZW", "Utopia", "Gagaga", "Zubaba", "Dododo", "Gogogo"], 10801),
    (11, 11201, "Gói Bài Rồng Điện Tử", ["Điện Tử Cyber", "Cyber Dragon", "Rồng Điện Tử", "Cyberdark", "Cyber", "Nguyên Mẫu Điện Tử", "Hạt Nhân Điện Tử", "Quang Học Điện Tử", "Công Nghệ Điện Tử"], 11101),
    (12, 11301, "Gói Bài Ojama", ["Ojama", "Vua Ojama", "Hiệp Sĩ Ojama", "Ojamagic", "Ojama Delta", "Bộ Ba Ojama", "Ojama Đỏ", "Ojama Xanh", "Ojama Vàng", "Ojama Đen", "Lãnh Địa Gây Rối", "Rối loạn·Vàng", "Quấy rối·Đen", "Xáo trộn·Xanh", "Làm phiền màu xanh"], 10901),
    (13, 11401, "Gói Bài Khủng Long", ["Khủng Long", "Jurrac", "Dinosaur", "Bạo Long", "Tyranno", "Jura-Herra", "Tuyệt Chủng", "Hóa Thạch", "Tiến Hóa Khủng Long", "Jura-"], 10801),
    (14, 11501, "Gói Bài Thú Có Cánh", ["Harpie", "Thú Có Cánh", "Nữ Quái Harpie", "Quạt Lông Vũ Harpy", "Chị Em Harpie", "Săn Harpie", "Vuốt Harpie", "Trại Huấn Luyện Harpie"], 10601),
    (15, 11601, "Gói Bài Toon", ["Toon", "Hoạt Hình", "Thế Giới Toon", "Mục Lục Toon", "Toon Rồng Trắng", "Toon Phù Thủy", "Toon Quái Thú", "Mặt Nạ Toon"], 10301),
    (16, 11701, "Gói Bài Thế Giới Bóng Tối", ["Thế Giới Bóng Tối", "Dark World", "Grapha", "Snoww", "Broww", "Ceruli", "Sấm Sét Thế Giới Hắc Ám", "Hắc Ám Giới", "Vương quốc bóng tối"], 10701),
    (17, 11801, "Gói Bài Lục Vũ Chúng", ["Lục Vũ Chúng", "Six Samurai", "Shien", "Kizan", "Enishi", "Kageki", "Cổng Lục Vũ Chúng", "Đạo Quân Lục Vũ Chúng", "Lửa Tím", "Sáu Chiến Binh"], 10401),
    (18, 11901, "Gói Bài Thiên Thần Sa Ngã", ["Thiên Thần Sa Ngã", "Darklord", "Lucifer", "Ixchel", "Tezcatlipoca", "Nasten", "Ishtab", "Thiên Sứ Sa Ngã"], 10501),
    (19, 12001, "Gói Bài Cơ Khí Cổ Đại", ["Cơ Khí Cổ Đại", "Ancient Gear", "Khổng Lồ Cơ Khí", "Pháo Đài Cơ Khí", "Xưởng Cơ Khí", "Rồng Cơ Khí Cổ Đại", "Cơ Giáp Cổ Đại", "Người Máy Cổ Đại"], 11101),
    (20, 12101, "Gói Bài Amazoness", ["Amazoness", "Amazon"], 10601)
]

# 20 Liya Deck Specs
# ID range: 101010..120010 (pack numbers 1..20)
LIYA_SPECS = [
    (1, 101010, "Gói Bài Kết Giới Băng", ["Kết Giới Băng", "Ice Barrier", "Trishula", "Brionac", "Thần Long Băng", "Tướng Quân Kết Giới Băng", "Rồng Kết Giới Băng"], 101001),
    (2, 102010, "Gói Bài Lửa Vĩnh Cửu", ["Lửa Vĩnh Cửu", "Infernity", "Lửa Vĩnh Hằng", "Pháo Lửa Vĩnh Cửu", "Ác Ma Lửa Vĩnh Cửu"], 102001),
    (3, 103010, "Gói Bài Chiến Thần Bujin", ["Chiến Thần Bujin", "Bujin", "Bujingi", "Torifune", "Kagutsuchi", "Tsukuyomi", "Thần Kiếm Bujin", "Võ Thần"], 103001),
    (4, 104010, "Gói Bài Vampire", ["Vampire", "Ma Cà Rồng", "Hấp Huyết", "Bram", "Bá Tước Ma Cà Rồng", "Lãnh Chúa Hấp Huyết Quỷ", "Vương Quốc Vampire"], 104001),
    (5, 105010, "Gói Bài Rồng Khổng Lồ", ["Rồng Khổng Lồ Felgrand", "Felgrand", "Rồng Khổng Lồ", "Hộ Vệ Rồng Khổng Lồ", "Kỵ Sĩ Rồng Khổng Lồ", "Tái Sinh Rồng Khổng Lồ", "Dragoon"], 105001),
    (6, 106010, "Gói Bài Công Nghệ TG", ["Công Nghệ TG", "Tech Genus", "T.G.", "Halberd Cannon", "Blade Blaster", "Công Nghệ·", "Công nghệ·"], 106001),
    (7, 107010, "Gói Bài Búp Bê Bóng Đêm", ["Búp Bê Bóng Đêm", "Shaddoll", "El Shaddoll", "Construct", "Winda", "Nhập Hồn", "Ảnh Kiếp", "Ảnh Quang", "Ảnh Ngục"], 107001),
    (8, 108010, "Gói Bài Áo Giáp Bóng Đêm", ["Áo Giáp Bóng Đêm", "Nekroz", "Clausolas", "Brionac Nekroz", "Trishula Nekroz", "Valkyrus", "Gương Thần Nekroz"], 108001),
    (9, 109010, "Gói Bài Bánh Ngọt", ["Bánh Ngọt Madolche", "Madolche"], 109001),
    (10, 110010, "Gói Bài Chim Săn Mồi", ["Chim Săn Mồi Raidraptor", "Raidraptor", "Ultimate Falcon", "Revolution Falcon", "Vanishing Lanius", "Lực Lượng Xếp Hạng RR", "Chim Dữ"], 110001),
    (11, 111010, "Gói Bài Hoa Trát", ["Hoa Trát", "Flower Cardian", "Lightflare", "Boardefly", "Pine", "Zebra Grass", "Moonflower", "Hanafuda"], 111001),
    (12, 112010, "Gói Bài Đế Vương", ["Đế Vương", "Monarch", "Erebus", "Ether", "Hoàng Đế Liên Kích", "Thánh Vực Hoàng Đế", "Cơn Lốc Hoàng Đế", "Rồng Đế Vương"], 112001),
    (13, 113010, "Gói Bài Vylon", ["Vylon", "Địa Đáy Subterror"], 113001),
    (14, 114010, "Gói Bài Hỏa Thú Luân Hồi", ["Hỏa Thú Luân Hồi", "Salamangreat", "Heatleo", "Miragestallio", "Viêm Thú Chuyển Sinh", "Chuyển Sinh-"], 114001),
    (15, 115010, "Gói Bài Công Chúa Biển", ["Công Chúa Biển", "Marincess", "Hải Nữ", "Crystal Heart", "Marbled Rock"], 115001),
    (16, 116010, "Gói Bài Cực Tinh", ["Cực Tinh", "Nordic", "Aesir", "Odin", "Thor", "Loki", "Thần Cực Tinh"], 116001),
    (17, 117010, "Gói Bài Quái Thú Huy Hiệu", ["Quái Thú Huy Hiệu", "Heraldic", "Heraldry", "Huy Hiệu", "Vua Huy Hiệu"], 117001),
    (18, 118010, "Gói Bài Xúc Xắc", ["Xúc Xắc Speedroid", "Speedroid", "Hi-Speedroid", "Clear Wing", "Terrortop", "Taketomborg", "Xúc Xắc"], 118001),
    (19, 119010, "Gói Bài Bất Tri Hỏa", ["Bất Tri Hỏa", "Shiranui", "Yêu Đao Shiranui", "Võ Thần Shiranui", "Thần lửa·Shiranui"], 119001),
    (20, 120010, "Gói Bài Siêu Trọng Kiếm Sĩ", ["Siêu Trọng Kiếm Sĩ", "Superheavy Samurai", "Siêu Nặng", "Big Benkei"], 120001)
]

# 20 Extra Deck Specs
# ID range: 121010..140010 (pack numbers 1..20)
EXTRA_SPECS = [
    (1, 121010, "Gói Bài Rồng Sấm Sét", ["Rồng Sấm Sét", "Thunder Dragon", "Rồng Sấm", "Lôi Điểu Long", "Lôi Thú Long", "Lôi Kiếp Long", "Lôi Nguyên Long", "Lôi Điện Long", "Hàng Xóm Sấm Sét", "Colossus"], 121001),
    (2, 122010, "Gói Bài Hầu Gái Nửa Rồng", ["hầu gái nửa rồng", "Dragonmaid", "Long Nữ-", "Hầu Gái Bán Rồng", "Sheou"], 122001),
    (3, 123010, "Gói Bài Hoa Tuyết", ["Hoa Tuyết Rikka", "Rikka", "Teardrop", "Snowdrop", "Mưa Hoa"], 123001),
    (4, 124010, "Gói Bài Bọ Cánh Cứng", ["Bọ Cánh Cứng", "Inzektor", "Lắp đặt bọ cánh cứng", "Cài đặt bọ cánh cứng", "Châu Báu Người Bọ"], 124001),
    (5, 125010, "Gói Bài Cơ Giáp", ["Cơ Giáp Machina", "Machina", "Đội Robot", "Robot-", "Robot Tiền Tuyến"], 125001),
    (6, 126010, "Gói Bài Dị Thứ Nguyên", ["Dị Thứ Nguyên DD", "DD ", "D/D", "DDD", "Kali Yuga", "Hỏa Ngục"], 126001),
    (7, 127010, "Gói Bài Con Rối", ["Rối Cơ Khí", "Con Rối", "Gimmick Puppet", "Cơ chế rối", "Con rối cơ khí"], 127001),
    (8, 128010, "Gói Bài Phế Liệu", ["Scrap", "Sắt Vụn", "Sắt Rỉ"], 128001),
    (9, 129010, "Gói Bài Bảo Ngọc", ["Bảo Ngọc", "Thú Bảo Ngọc", "Crystal Beast", "Rồng Cầu Vồng"], 129001),
    (10, 130010, "Gói Bài Tự Nhiên", ["Tự Nhiên", "Naturia"], 130001),
    (11, 131010, "Gói Bài Cơ Xảo", ["Cơ Xảo Karakuri", "Karakuri", "Giả vờ ăn mặc", "Giả vờ ăn diện"], 131001),
    (12, 132010, "Gói Bài Khung Xương", ["Khung Xương PSY", "PSY-Frame", "PSY-Framegear", "PSY-Bộ Tăng Tốc", "Thiết bị bộ xương PSY", "PSY Quá Tải"], 132001),
    (13, 133010, "Gói Bài Kẻ Trộm Thời Gian", ["Kẻ Trộm Thời Gian", "Time Thief", "Redoer", "Perpetua"], 133001),
    (14, 134010, "Gói Bài Quang Ba", ["Quang Ba Cipher", "Cipher", "Sóng Ánh Sáng"], 134001),
    (15, 135010, "Gói Bài Hải Hoàng", ["Hải Hoàng", "Atlantean", "Vua Biển Gào Thét", "Cận Vệ Giáp Nặng"], 135001),
    (16, 136010, "Gói Bài Nòng Súng", ["Nòng Súng Borrel", "Borrel", "Rokket", "Borreload", "Borrelsword", "Tháp Tử Thần", "Giao Thức Tử Thần"], 136001),
    (17, 137010, "Gói Bài Cô Gái Vận Mệnh", ["Cô Gái Vận Mệnh", "Fortune Lady", "Cô Gái Định Mệnh", "Cô gái định mệnh", "Tiểu thư định mệnh"], 101001),
    (18, 138010, "Gói Bài Trùng Tộc", ["Trùng Tộc", "Traptrix", "Hố Sụt", "Hố Bẫy", "Hầm Chông", "Bẫy Keo Dính"], 102001),
    (19, 139010, "Gói Bài Đoàn Tàu", ["Đoàn Tàu", "Train", "Superdreadnought", "Lịch Trình Xe", "Chỉnh Xe Quay Về"], 103001),
    (20, 140010, "Gói Bài Gishki", ["Gishki", "Di Sản Tinh Tú", "Nghi Thủy Kính", "Tinh Nghĩa"], 104001)
]

def build_map(specs, is_char=False):
    res_map = {}
    pack_list = []
    for num, val, name, keywords, fallback_img in specs:
        matched = []
        for cid, c in valid_cards.items():
            cname = c['name']
            ckw = c['keyword'] or ''
            
            # Specific cleanups to guarantee 100% theme purity
            if name != "Gói Bài Toon" and "toon" in cname.lower():
                continue
            if name != "Gói Bài Anh Hùng Định Mệnh" and "dutopia" in cname.lower():
                continue
            if name != "Gói Bài Quang Ba" and ("cipher" in cname.lower() or "sóng ánh sáng" in cname.lower()):
                continue
            if name != "Gói Bài Phế Liệu" and ("sắt vụn" in cname.lower() or "sắt rỉ" in cname.lower()):
                continue
            if name == "Gói Bài Đồng Bộ" and cid == 20596:
                continue
            if name == "Gói Bài Chiến Thần Bujin" and ("vương quốc bóng tối" in cname.lower() or "hắc ám giới" in cname.lower()):
                continue
            if name == "Gói Bài Siêu Trọng Kiếm Sĩ" and cid == 40210:
                continue
            if name == "Gói Bài Đế Vương" and "gagaga" in cname.lower():
                continue

            if any(k.lower() in cname.lower() or k.lower() in ckw.lower() for k in keywords):
                matched.append(c)
        cids = [c['id'] for c in matched]
        # Sort cids: GR first, Ancient UR, UR, SR, R, N
        def sort_key(c):
            q_order = {'GR': 0, 'UR': 1, 'SR': 2, 'R': 3, 'N': 4}
            anc = 0 if c['id'] in ancient_cids else 1
            return (q_order.get(c['quality'] or 'N', 5), anc, c['id'])
        sorted_matched = sorted(matched, key=sort_key)
        sorted_cids = [c['id'] for c in sorted_matched]
        
        # map key by pack number and full value
        res_map[num] = sorted_cids
        res_map[val] = sorted_cids
        if is_char:
            res_map[val + 9] = sorted_cids
            res_map[val + 49] = sorted_cids
        else:
            prefix = (val // 1000) * 1000
            res_map[prefix + 1] = sorted_cids
            res_map[prefix + 10] = sorted_cids
            res_map[prefix + 50] = sorted_cids
            
        pack_list.append({
            'num': num,
            'value': val,
            'name': name,
            'card_count': len(sorted_cids),
            'cards': sorted_cids,
            'fallback_img': fallback_img
        })
    return res_map, pack_list

char_map, char_packs = build_map(CHAR_SPECS, is_char=True)
liya_map, liya_packs = build_map(LIYA_SPECS, is_char=False)
extra_map, extra_packs = build_map(EXTRA_SPECS, is_char=False)

with open('char_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in char_map.items()}, f, indent=2, ensure_ascii=False)
with open('liya_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in liya_map.items()}, f, indent=2, ensure_ascii=False)
with open('extra_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in extra_map.items()}, f, indent=2, ensure_ascii=False)

all_packs_summary = {
    'char_packs': char_packs,
    'liya_packs': liya_packs,
    'extra_packs': extra_packs
}
with open('all_60_packs_summary.json', 'w', encoding='utf-8') as f:
    json.dump(all_packs_summary, f, indent=2, ensure_ascii=False)

# Check overlaps
card_to_packs = defaultdict(list)
for cat, plist in [('char', char_packs), ('liya', liya_packs), ('extra', extra_packs)]:
    for p in plist:
        for cid in p['cards']:
            card_to_packs[cid].append(f"{cat}:{p['num']}-{p['name']}")

dups = {cid: p for cid, p in card_to_packs.items() if len(p) > 1}
if dups:
    print(f"Warning: {len(dups)} cards appear in multiple packs")
else:
    print("SUCCESS: EXACTLY ZERO DUPLICATES ACROSS ALL 60 PACKS!")

print(f"Generated successfully:")
print(f"  char_cards_map.json: {len(char_packs)} packs")
print(f"  liya_cards_map.json: {len(liya_packs)} packs")
print(f"  extra_cards_map.json: {len(extra_packs)} packs")
