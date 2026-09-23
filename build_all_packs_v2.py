import sys
sys.stdout.reconfigure(encoding='utf-8')
import pymysql
import json
import re
import hashlib
from collections import defaultdict

conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4')
cursor = conn.cursor(pymysql.cursors.DictCursor)

cursor.execute("""
    SELECT id, name, keyword, quality, 'monster' as tbl FROM card_monsters
    UNION ALL SELECT id, name, keyword, quality, 'spell' as tbl FROM card_spells
    UNION ALL SELECT id, name, keyword, quality, 'trap' as tbl FROM card_traps
    UNION ALL SELECT id, name, '' AS keyword, quality, 'extra' as tbl FROM card_extra
""")
all_cards = {r['id']: r for r in cursor.fetchall()}

with open('web/data/ancient_products.lua', 'r', encoding='utf-8') as f:
    anc_text = f.read()
ancient_cids = set(int(m.group(1)) for m in re.finditer(r'\[\"_cardId\"\]=(\d+)', anc_text))

# Comprehensive forbidden list:
# 1. Temporary equip spells (Chiến Đao I..V, Lưỡi Thần Nộ I..V, Kiếm Diệt Chủng I..V, Quyền Trượng II, etc.)
# 2. Previous substitute cards (20804..20810, 30439, 11309)
# 3. Unobtainable cards requested by user (20233 Cú Đấm Thần Thánh, 20236 Trao Đổi Linh Hồn)
# 4. Dev / dummy / test cards
forbidden_cids = {
    20841, 20842, 20843, 20844, 20845, # Mắt Đỏ-Chiến Đao I..V
    20961, 20962, 20963, 20964, 20965, # Lưỡi Thần Nộ I..V
    20981, 20982, 20983, 20984, 20985, # Kiếm Diệt Chủng I..V
    20525,                              # Kỵ Binh·Kỵ Sĩ Rồng Quyền Trượng II
    20804, 20805, 20806, 20807, 20808, 20809, 20810, # Substitute Crystal Beast spells
    30439, 11309,
    20233,                              # Cú Đấm Thần Thánh
    20236,                              # Trao Đổi Linh Hồn
    11753,                              # Token Link
}

def is_excluded(c):
    cid = c['id']
    if cid in forbidden_cids:
        return True
    name = (c['name'] or '').lower()
    if any(k in name for k in ['token', 'mã thông báo', 'diễn sinh', 'thay thế', 'tạm thời', 'chiến đao']):
        return True
    return False

valid_cards = {cid: c for cid, c in all_cards.items() if not is_excluded(c)}
print(f"Total cards: {len(all_cards)}, Valid non-excluded: {len(valid_cards)}")

# Target size formula:
# if k <= 13: 25
# if k > 13: round(2*k / 5) * 5 (closest multiple of 5 to 2*k; if tie, lower)
def calc_target_size(k):
    if k <= 13:
        return 25
    double_k = 2 * k
    lower_5 = (double_k // 5) * 5
    upper_5 = lower_5 + 5
    diff_lower = double_k - lower_5
    diff_upper = upper_5 - double_k
    if diff_lower <= diff_upper:
        return lower_5
    else:
        return upper_5

# Character 20 Specs
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

# Liya 20 Specs
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

# Extra 22 Specs (20 existing + ES/CS + TrickStar)
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
    (20, 140010, "Gói Bài Gishki", ["Gishki", "Di Sản Tinh Tú", "Nghi Thủy Kính", "Tinh Nghĩa"], 104001),
    (21, 141010, "Gói Bài ES/CS", ["ES-", "CS-", "Exosister", "Khủng Long Cơ Xảo"], 101001),
    (22, 142010, "Gói Bài TrickStar", ["TrickStar", "Ngôi sao lừa đảo"], 102001)
]

# Identify all archetype cards across all packs first
archetype_cids = set()
for specs in [CHAR_SPECS, LIYA_SPECS, EXTRA_SPECS]:
    for num, val, name, keywords, _ in specs:
        for cid, c in valid_cards.items():
            cname = c['name']
            ckw = c['keyword'] or ''
            if name != "Gói Bài Toon" and "toon" in cname.lower(): continue
            if name != "Gói Bài Anh Hùng Định Mệnh" and "dutopia" in cname.lower(): continue
            if name != "Gói Bài Quang Ba" and ("cipher" in cname.lower() or "sóng ánh sáng" in cname.lower()): continue
            if name != "Gói Bài Phế Liệu" and ("sắt vụn" in cname.lower() or "sắt rỉ" in cname.lower()): continue
            if name == "Gói Bài Đồng Bộ" and cid == 20596: continue
            if name == "Gói Bài Chiến Thần Bujin" and ("vương quốc bóng tối" in cname.lower() or "hắc ám giới" in cname.lower()): continue
            if name == "Gói Bài Siêu Trọng Kiếm Sĩ" and cid == 40210: continue
            if name == "Gói Bài Đế Vương" and "gagaga" in cname.lower(): continue
            if name == "Gói Bài ES/CS" and "sordes" in cname.lower(): continue
            if any(k.lower() in cname.lower() or k.lower() in ckw.lower() for k in keywords):
                archetype_cids.add(cid)

print(f"Total archetype cards matched: {len(archetype_cids)}")

# Build pool of clean generic filler cards (N and R only, non-extra, non-archetype)
generic_n_pool = [c for c in valid_cards.values() if c['id'] not in archetype_cids and c['tbl'] != 'extra' and (c['quality'] or 'N') == 'N']
generic_r_pool = [c for c in valid_cards.values() if c['id'] not in archetype_cids and c['tbl'] != 'extra' and c['quality'] == 'R']

print(f"Clean Generic N filler pool: {len(generic_n_pool)}")
print(f"Clean Generic R filler pool: {len(generic_r_pool)}")

# Sort pools by ID for deterministic selection
generic_n_pool.sort(key=lambda x: x['id'])
generic_r_pool.sort(key=lambda x: x['id'])

def get_pack_fillers(pack_val, count_needed):
    # Deterministic filler selection using pack_val hash offset
    n_needed = count_needed // 2
    r_needed = count_needed - n_needed
    
    n_offset = (pack_val * 7) % len(generic_n_pool)
    r_offset = (pack_val * 13) % len(generic_r_pool)
    
    fillers = []
    for i in range(n_needed):
        fillers.append(generic_n_pool[(n_offset + i) % len(generic_n_pool)])
    for i in range(r_needed):
        fillers.append(generic_r_pool[(r_offset + i) % len(generic_r_pool)])
    return fillers

def build_map(specs, is_char=False):
    res_map = {}
    pack_list = []
    quality_map = {}
    
    for num, val, name, keywords, fallback_img in specs:
        theme_matched = []
        for cid, c in valid_cards.items():
            cname = c['name']
            ckw = c['keyword'] or ''
            if name != "Gói Bài Toon" and "toon" in cname.lower(): continue
            if name != "Gói Bài Anh Hùng Định Mệnh" and "dutopia" in cname.lower(): continue
            if name != "Gói Bài Quang Ba" and ("cipher" in cname.lower() or "sóng ánh sáng" in cname.lower()): continue
            if name != "Gói Bài Phế Liệu" and ("sắt vụn" in cname.lower() or "sắt rỉ" in cname.lower()): continue
            if name == "Gói Bài Đồng Bộ" and cid == 20596: continue
            if name == "Gói Bài Chiến Thần Bujin" and ("vương quốc bóng tối" in cname.lower() or "hắc ám giới" in cname.lower()): continue
            if name == "Gói Bài Siêu Trọng Kiếm Sĩ" and cid == 40210: continue
            if name == "Gói Bài Đế Vương" and "gagaga" in cname.lower(): continue
            if name == "Gói Bài ES/CS" and "sordes" in cname.lower(): continue
            if any(k.lower() in cname.lower() or k.lower() in ckw.lower() for k in keywords):
                theme_matched.append(c)
                
        k_orig = len(theme_matched)
        target_size = calc_target_size(k_orig)
        fillers_needed = max(0, target_size - k_orig)
        filler_cards = get_pack_fillers(val, fillers_needed)
        
        # Partition theme cards into qualities
        gr_list = []
        ur_anc_list = []
        theme_norm_pool = []
        
        for c in theme_matched:
            q = (c.get('quality') or 'N').upper()
            if q == 'GR':
                gr_list.append(c['id'])
            elif c['id'] in ancient_cids:
                ur_anc_list.append(c['id'])
            else:
                theme_norm_pool.append(c)
                
        # If no ancient card, promote 1-2 top theme cards
        if len(ur_anc_list) == 0 and len(theme_norm_pool) > 0:
            ur_anc_list.append(theme_norm_pool.pop(-1)['id'])
            if len(theme_norm_pool) > 10:
                ur_anc_list.append(theme_norm_pool.pop(-1)['id'])
                
        # Distribute remaining theme normal pool
        tot_theme = len(theme_norm_pool)
        if tot_theme == 0:
            ur_theme = ur_anc_list[:]
            sr_theme = ur_anc_list[:]
            r_theme = ur_anc_list[:]
            n_theme = ur_anc_list[:]
        else:
            n_cnt = max(1, round(tot_theme * 0.30))
            r_cnt = max(1, round(tot_theme * 0.35))
            sr_cnt = max(1, round(tot_theme * 0.20))
            ur_cnt = tot_theme - (n_cnt + r_cnt + sr_cnt)
            if ur_cnt < 1:
                ur_cnt = 1
                if n_cnt > 1: n_cnt -= 1
                elif r_cnt > 1: r_cnt -= 1
            n_theme = [c['id'] for c in theme_norm_pool[:n_cnt]]
            r_theme = [c['id'] for c in theme_norm_pool[n_cnt:n_cnt + r_cnt]]
            sr_theme = [c['id'] for c in theme_norm_pool[n_cnt + r_cnt:n_cnt + r_cnt + sr_cnt]]
            ur_theme = [c['id'] for c in theme_norm_pool[n_cnt + r_cnt + sr_cnt:]]
            
        # Add filler cards directly to R and N pools
        filler_n = [c['id'] for c in filler_cards if (c.get('quality') or 'N') == 'N']
        filler_r = [c['id'] for c in filler_cards if c.get('quality') == 'R']
        
        final_n = n_theme + filler_n
        final_r = r_theme + filler_r
        
        # Combine all cards in pack: GR, UR_ANCIENT, UR, SR, R, N
        all_pack_cids = []
        for sub in [gr_list, ur_anc_list, ur_theme, sr_theme, final_r, final_n]:
            for cid in sub:
                if cid not in all_pack_cids:
                    all_pack_cids.append(cid)
                    
        quality_map[val] = {
            'name': name,
            'GR': gr_list,
            'UR_ANCIENT': ur_anc_list,
            'UR': ur_theme,
            'SR': sr_theme,
            'R': final_r,
            'N': final_n
        }
        
        # Mappings
        res_map[num] = all_pack_cids
        res_map[val] = all_pack_cids
        if is_char:
            res_map[val + 9] = all_pack_cids
            res_map[val + 49] = all_pack_cids
        else:
            prefix = (val // 1000) * 1000
            res_map[prefix + 1] = all_pack_cids
            res_map[prefix + 10] = all_pack_cids
            res_map[prefix + 50] = all_pack_cids
            
        pack_list.append({
            'num': num,
            'value': val,
            'name': name,
            'orig_count': k_orig,
            'card_count': len(all_pack_cids),
            'filler_count': len(filler_cards),
            'cards': all_pack_cids,
            'fallback_img': fallback_img
        })
    return res_map, pack_list, quality_map

char_map, char_packs, char_qmap = build_map(CHAR_SPECS, is_char=True)
liya_map, liya_packs, liya_qmap = build_map(LIYA_SPECS, is_char=False)
extra_map, extra_packs, extra_qmap = build_map(EXTRA_SPECS, is_char=False)

print("\n--- SAMPLE DILUTED PACK SIZES ---")
for p in (char_packs[:3] + liya_packs[:2] + extra_packs[-2:]):
    print(f"Pack {p['num']}: {p['name']} | Orig: {p['orig_count']} -> Total: {p['card_count']} (+{p['filler_count']} fillers)")

# =========================================================================
# TAB 4: EXPANSION PACKS (GÓI BÀI MỞ RỘNG) - 5 PACKS x 40 CARDS
# =========================================================================
# Must be generic support cards (non-archetype), N to UR/GR
# No dev cards, no unobtainable cards
all_staple_spells = [c for c in valid_cards.values() if c['tbl'] == 'spell' and (c['keyword'] in ('Không có', '', None))]
all_staple_traps = [c for c in valid_cards.values() if c['tbl'] == 'trap' and (c['keyword'] in ('Không có', '', None))]
all_staple_monsters = [c for c in valid_cards.values() if c['tbl'] == 'monster' and (c['keyword'] in ('Không có', '', None))]

# Sort by quality: GR, UR, SR, R, N
def staple_sort(cards):
    q_rank = {'GR': 0, 'UR': 1, 'SR': 2, 'R': 3, 'N': 4}
    return sorted(cards, key=lambda c: (q_rank.get(c['quality'] or 'N', 5), c['id']))

all_staple_spells = staple_sort(all_staple_spells)
all_staple_traps = staple_sort(all_staple_traps)
all_staple_monsters = staple_sort(all_staple_monsters)

print(f"\nStaple pool: Spells={len(all_staple_spells)}, Traps={len(all_staple_traps)}, Monsters={len(all_staple_monsters)}")

# Build exactly 5 packs of 40 cards each:
# Pack 1 (151010): Gói Mở Rộng: Phép Thuật Kinh Điển (40 classic spells including Trọc Phú Goblin 20226)
# Pack 2 (152010): Gói Mở Rộng: Cạm Bẫy Phản Kích (40 traps including Pháp Trận Ma Thuật 30032, Bẫy Quấy Nhiễu 30029)
# Pack 3 (153010): Gói Mở Rộng: Quái Thú Toàn Năng (40 generic support monsters)
# Pack 4 (154010): Gói Mở Rộng: Phép Thuật Chiến Lược (40 tactical spells)
# Pack 5 (155010): Gói Mở Rộng: Cạm Bẫy Chiến Trường (40 tactical traps)

def select_40(pool, priority_ids=None):
    selected = []
    if priority_ids:
        for pid in priority_ids:
            if pid in valid_cards:
                selected.append(valid_cards[pid])
    
    # We want balanced quality: 1-2 GR, 8-10 UR, 8-10 SR, 10-12 R, 8-10 N
    by_q = defaultdict(list)
    for c in pool:
        if c['id'] not in [s['id'] for s in selected]:
            by_q[c['quality'] or 'N'].append(c)
            
    # Add from each quality
    for q, count in [('GR', 1), ('UR', 8), ('SR', 10), ('R', 12), ('N', 9)]:
        selected.extend(by_q[q][:count])
        
    # Fill remaining up to 40
    curr_ids = set(s['id'] for s in selected)
    for c in pool:
        if len(selected) >= 40: break
        if c['id'] not in curr_ids:
            selected.append(c)
            curr_ids.add(c['id'])
    return selected[:40]

exp1_cards = select_40(all_staple_spells, priority_ids=[20226]) # Trọc phú goblin
exp2_cards = select_40(all_staple_traps, priority_ids=[30032, 30029]) # Pháp trận ma thuật, Bẫy quấy nhiễu
exp3_cards = select_40(all_staple_monsters, priority_ids=[10008, 10012, 10024, 10830])
# Pack 4: next slice of staple spells
exp4_cards = select_40(all_staple_spells[40:])
# Pack 5: next slice of staple traps
exp5_cards = select_40(all_staple_traps[40:])

EXPANSION_SPECS = [
    (1, 151010, "Gói Mở Rộng: Phép Thuật Kinh Điển", exp1_cards, 101001),
    (2, 152010, "Gói Mở Rộng: Cạm Bẫy Phản Kích", exp2_cards, 102001),
    (3, 153010, "Gói Mở Rộng: Quái Thú Toàn Năng", exp3_cards, 103001),
    (4, 154010, "Gói Mở Rộng: Phép Thuật Chiến Lược", exp4_cards, 104001),
    (5, 155010, "Gói Mở Rộng: Cạm Bẫy Chiến Trường", exp5_cards, 105001)
]

expansion_map = {}
expansion_packs = []
expansion_qmap = {}

for num, val, name, clist, fallback_img in EXPANSION_SPECS:
    cids = [c['id'] for c in clist]
    expansion_map[num] = cids
    expansion_map[val] = cids
    prefix = (val // 1000) * 1000
    expansion_map[prefix + 1] = cids
    expansion_map[prefix + 10] = cids
    expansion_map[prefix + 50] = cids
    
    gr_list = [c['id'] for c in clist if (c.get('quality') or 'N') == 'GR']
    ur_anc_list = [c['id'] for c in clist if c['id'] in ancient_cids]
    ur_list = [c['id'] for c in clist if (c.get('quality') or 'N') == 'UR' and c['id'] not in ancient_cids]
    sr_list = [c['id'] for c in clist if (c.get('quality') or 'N') == 'SR']
    r_list = [c['id'] for c in clist if (c.get('quality') or 'N') == 'R']
    n_list = [c['id'] for c in clist if (c.get('quality') or 'N') == 'N']
    
    if len(ur_anc_list) == 0 and len(ur_list) > 0:
        ur_anc_list.append(ur_list.pop(0))
        
    expansion_qmap[val] = {
        'name': name,
        'GR': gr_list,
        'UR_ANCIENT': ur_anc_list,
        'UR': ur_list,
        'SR': sr_list,
        'R': r_list,
        'N': n_list
    }
    
    expansion_packs.append({
        'num': num,
        'value': val,
        'name': name,
        'card_count': len(cids),
        'cards': cids,
        'fallback_img': fallback_img
    })

print("\n--- EXPANSION PACKS (TAB 4) ---")
for p in expansion_packs:
    qm = expansion_qmap[p['value']]
    print(f"Pack {p['num']}: {p['name']} | Cards: {p['card_count']} (GR:{len(qm['GR'])}, UR_Anc:{len(qm['UR_ANCIENT'])}, UR:{len(qm['UR'])}, SR:{len(qm['SR'])}, R:{len(qm['R'])}, N:{len(qm['N'])})")

# Write out JSON maps
with open('char_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in char_map.items()}, f, indent=2, ensure_ascii=False)
with open('liya_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in liya_map.items()}, f, indent=2, ensure_ascii=False)
with open('extra_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in extra_map.items()}, f, indent=2, ensure_ascii=False)
with open('expansion_cards_map.json', 'w', encoding='utf-8') as f:
    json.dump({str(k): v for k, v in expansion_map.items()}, f, indent=2, ensure_ascii=False)

# Master quality distribution
full_qmap = {}
full_qmap.update(char_qmap)
full_qmap.update(liya_qmap)
full_qmap.update(extra_qmap)
full_qmap.update(expansion_qmap)
with open('pack_quality_distribution.json', 'w', encoding='utf-8') as f:
    json.dump(full_qmap, f, indent=2, ensure_ascii=False)

summary = {
    'char_packs': char_packs,
    'liya_packs': liya_packs,
    'extra_packs': extra_packs,
    'expansion_packs': expansion_packs
}
with open('all_60_packs_summary.json', 'w', encoding='utf-8') as f:
    json.dump(summary, f, indent=2, ensure_ascii=False)

print("\nAll JSON maps generated successfully!")
