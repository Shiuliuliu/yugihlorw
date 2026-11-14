import sys, pymysql, re

sys.stdout.reconfigure(encoding='utf-8')

print("[*] Adding batch 3 Labrynth data (30602..30605, 21172..21173, Skills 20194..20218)...")

# Strings table
STRINGS = [
    (58261, "FAREWELCOME LABRYNTH"),
    (58262, "[Bẫy Thường / UR]\nTừ khóa: \"Labrynth\"\nKhi bài này nằm trên tay: khi trên sân phe ta có quái vật có từ khóa “Labrynth”, quái vật đối thủ tấn công sẽ kích hoạt. Đưa lá bài này vào mộ; vô hiệu hóa đòn tấn công và đưa quái đó của đối thủ vào mộ (xuyên thủng “tường chắn bẫy”).\n\nKỹ năng mộ chủ động: Mỗi lượt 1 lần, loại bỏ bản thân lá này, lấy 1 lá bài Phép/Bẫy \"Labrynth\" từ bộ bài phe ta vào tay.\n\nKhi bài này nằm trong mộ, khi đối thủ tấn công sẽ kích hoạt. Loại bỏ bản thân bài này: tất cả quái vật có từ khóa “Labrynth” trên sân phe ta tăng tấn công bằng tổng số lá Phép/Bẫy có từ khóa “Labrynth” trong mộ/mộ bài loại bỏ phe ta×200 (bỏ qua “Tường Chắn Bẫy”). Nếu trên sân phe ta không có quái “Labrynth” để tăng tấn công, mà mộ phe ta có quái “Labrynth”, tất cả quái vật của đối phương không thể tấn công trong lượt này (xuyên thủng “tường chắn bẫy”)."),
    (58263, "FAREWELCOME LABRYNTH"),
    (58264, "Phản Kích Tạm Biệt"),
    (58265, "Khi trên tay, quái Labrynth trên sân và đối thủ tấn công: Đưa lá này vào mộ, hủy đòn đánh và gửi quái tấn công vào mộ."),
    (58266, "Truy Tìm Phép Bẫy"),
    (58267, "Kỹ năng mộ chủ động: 1 lượt 1 lần, loại bỏ lá này để lấy 1 Phép/Bẫy Labrynth từ bộ bài vào tay."),
    (58268, "Mê Cung Tương Trợ / Trấn Áp"),
    (58269, "Khi trong mộ, đối thủ tấn công: Loại bỏ lá này. Quái Labrynth tăng công = số Phép/Bẫy Labrynth trong mộ/loại bỏ x 200, hoặc khóa toàn bộ tấn công đối thủ."),

    (58270, "LABRYNTH BARRAGE"),
    (58271, "[Bẫy Vĩnh Cửu / UR]\nTừ khóa: \"Labrynth\"\nKích hoạt bài này và đưa vào khu Bẫy Phép.\n\nChủ động Ⅰ: Mỗi lượt 1 lần. Chọn và triệu hồi đặc biệt 1 lá quái 5 sao hoặc 7 sao “Labrynth” trong bộ bài phe ta lên sân trong thế thủ; không thể đổi thế công chỉ trong lượt này.\n\nChủ động Ⅱ: Mỗi lượt 1 lần. Đặt bài phép môi trường có từ khóa “Labrynth” trong bộ bài phe ta vào Khu Bẫy Phép phe ta.\n\nMỗi lượt chỉ 1 lần. Khi lá này nằm trên sân, khi phe ta kích hoạt hiệu ứng Bẫy có thể kích hoạt. Hi sinh bản thân lá này. Lấy 1 lá quái 8 sao “Labrynth” trong mộ/mộ loại bỏ phe ta đưa vào tay.\n\nKhi bài này nằm trong mộ, khi đối thủ tấn công sẽ kích hoạt. Loại bỏ bản thân bài này: tất cả quái vật có từ khóa “Labrynth” trên sân phe ta tăng tấn công bằng tổng số lá Phép/Bẫy có từ khóa “Labrynth” trong mộ/mộ bài loại bỏ phe ta×200 (bỏ qua “Tường Chắn Bẫy”). Nếu trên sân phe ta không có quái “Labrynth” để tăng tấn công, mà mộ phe ta có quái “Labrynth”, tất cả quái vật của đối phương không thể tấn công trong lượt này (xuyên thủng “tường chắn bẫy”)."),
    (58272, "LABRYNTH BARRAGE"),
    (58273, "Liên Hoàn Cạm Bẫy"),
    (58274, "Kích hoạt bài này và đưa vào khu Bẫy Phép."),
    (58275, "Triệu Tập Thủ Hộ"),
    (58276, "Chủ động Ⅰ: 1 lượt 1 lần, triệu hồi đặc biệt 1 quái Labrynth 5 hoặc 7 sao từ bộ bài lên sân ở thế thủ (không đổi thế công lượt này)."),
    (58277, "Bố Trí Mê Cung"),
    (58278, "Chủ động Ⅱ: 1 lượt 1 lần, đặt bài phép môi trường Labrynth từ bộ bài vào khu Bẫy Phép."),
    (58279, "Hiến Tế Cầu Viện"),
    (58280, "Khi trên sân, phe ta kích hoạt Bẫy: 1 lượt 1 lần, hi sinh lá này lấy 1 quái 8 sao Labrynth từ mộ/loại bỏ vào tay."),
    (58281, "Mê Cung Tương Trợ / Trấn Áp"),
    (58282, "Khi trong mộ, đối thủ tấn công: Loại bỏ lá này. Quái Labrynth tăng công = số Phép/Bẫy Labrynth trong mộ/loại bỏ x 200, hoặc khóa toàn bộ tấn công đối thủ."),

    (58283, "WELCOME LABRYNTH"),
    (58284, "[Bẫy Thường / UR]\nTừ khóa: \"Labrynth\"\nMỗi lượt chỉ được dùng 1 lá. Chọn và triệu hồi đặc biệt 1 lá quái có từ khóa “Labrynth” trên tay/trong bộ bài phe ta. Sau đó trong lượt này, chỉ có thể Triệu Hồi Đặc Biệt quái có từ khóa “Labrynth”.\n\n1 lần trong một vòng. Khi nằm trong mộ, khi phe của bạn triệu hồi một Quái Vật có từ khóa “Labrynth”, hãy rút một lá bài.\n\nMỗi lượt chỉ 1 lần. Khi lá này nằm trong mộ/mộ loại bỏ, khi lá quái “Labrynth” rời khỏi sân bởi hiệu ứng lá bẫy của phe ta: Đưa bản thân lá này quay trở lại tay.\n\nKhi bài này nằm trong mộ, khi đối thủ tấn công sẽ kích hoạt. Loại bỏ bản thân bài này: tất cả quái vật có từ khóa “Labrynth” trên sân phe ta tăng tấn công bằng tổng số lá Phép/Bẫy có từ khóa “Labrynth” trong mộ/mộ bài loại bỏ phe ta×200 (bỏ qua “Tường Chắn Bẫy”). Nếu trên sân phe ta không có quái “Labrynth” để tăng tấn công, mà mộ phe ta có quái “Labrynth”, tất cả quái vật của đối phương không thể tấn công trong lượt này (xuyên thủng “tường chắn bẫy”)."),
    (58285, "WELCOME LABRYNTH"),
    (58286, "Nghênh Đón Mê Cung"),
    (58287, "1 lượt 1 lá: Triệu hồi đặc biệt 1 quái Labrynth từ tay/bộ bài; sau đó trong lượt này chỉ có thể Triệu Hồi Đặc Biệt quái Labrynth."),
    (58288, "Gia Tăng Tiếp Tế"),
    (58289, "Khi trong mộ, khi triệu hồi quái Labrynth: Rút 1 lá bài (1 lần/vòng)."),
    (58290, "Thu Hồi Cạm Bẫy"),
    (58291, "Khi trong mộ/loại bỏ, khi quái Labrynth rời sân bởi bẫy phe ta: Đưa lá này trở lại tay (1 lượt 1 lần)."),
    (58292, "Mê Cung Tương Trợ / Trấn Áp"),
    (58293, "Khi trong mộ, đối thủ tấn công: Loại bỏ lá này. Quái Labrynth tăng công = số Phép/Bẫy Labrynth trong mộ/loại bỏ x 200, hoặc khóa toàn bộ tấn công đối thủ."),

    (58294, "BIG WELCOME LABRYNTH"),
    (58295, "[Bẫy Thường / UR]\nTừ khóa: \"Labrynth\"\nMỗi lượt chỉ được dùng 1 lá. Chọn và triệu hồi đặc biệt 1 lá quái “Labrynth” từ tay/bộ bài/mộ/mộ loại bỏ phe ta lên sân. Sau đó đưa 1 quái trên sân phe ta về tay.\n\nKỹ năng mộ chủ động: mỗi lượt 1 lần; Khi trên sân phe ta có quái “Labrynth”. Loại bỏ bản thân lá này. Chọn 1 lá bài trên sân đối thủ đưa về tay (xuyên thủng “Khiên Chắn Bẫy” “Tường Chắn Bẫy” “Bẫy Rào Chắn”).\n\nKỹ năng mộ loại bỏ chủ động: mỗi lượt chỉ 1 lần. Thêm 1 lá bài từ khóa “Labrynth” từ mộ phe ta vào tay.\n\nKhi bài này nằm trong mộ, khi đối thủ tấn công sẽ kích hoạt. Loại bỏ bản thân bài này: tất cả quái vật có từ khóa “Labrynth” trên sân phe ta tăng tấn công bằng tổng số lá Phép/Bẫy có từ khóa “Labrynth” trong mộ/mộ bài loại bỏ phe ta×200 (bỏ qua “Tường Chắn Bẫy”). Nếu trên sân phe ta không có quái “Labrynth” để tăng tấn công, mà mộ phe ta có quái “Labrynth”, tất cả quái vật của đối phương không thể tấn công trong lượt này (xuyên thủng “tường chắn bẫy”)."),
    (58296, "BIG WELCOME LABRYNTH"),
    (58297, "Đại Nghênh Đón"),
    (58298, "1 lượt 1 lá: Triệu hồi đặc biệt 1 quái Labrynth từ tay/bộ bài/mộ/loại bỏ lên sân; sau đó đưa 1 quái trên sân về tay."),
    (58299, "Đẩy Lùi Xâm Phạm"),
    (58300, "Kỹ năng mộ chủ động: Khi có quái Labrynth trên sân, loại bỏ lá này để trả 1 lá trên sân đối thủ về tay (xuyên khiên/tường/rào chắn)."),
    (58301, "Thu Hồi Tàn Tích"),
    (58302, "Kỹ năng loại bỏ chủ động: 1 lượt 1 lần, thêm 1 lá Labrynth từ mộ vào tay."),
    (58303, "Mê Cung Tương Trợ / Trấn Áp"),
    (58304, "Khi trong mộ, đối thủ tấn công: Loại bỏ lá này. Quái Labrynth tăng công = số Phép/Bẫy Labrynth trong mộ/loại bỏ x 200, hoặc khóa toàn bộ tấn công đối thủ."),

    (58305, "LABRYNTH SET-UP"),
    (58306, "[Phép Thường / UR]\nTừ khóa: \"Labrynth\"\nMỗi lượt chỉ được dùng 1 lá. Chọn tối đa 2 lá bài Phép/Bẫy \"Labrynth\" trong mộ/mộ loại bỏ phe ta, ngoại trừ \"Labrynth Set-Up\"; trộn chúng vào Bộ bài, sau đó nếu bạn điều khiển một quái “Labrynth”, lấy lá Bẫy không phải \"Labrynth\" có tên khác nhau từ Bộ bài phe ta vào tay với số lượng bằng số lá bài đã trộn vào bộ bài.\n\nKỹ năng mộ chủ động: mỗi lượt chỉ 1 lần. Loại bỏ bản thân lá này. Lấy 1 lá quái “Labrynth” 4 sao trở xuống từ bộ bài vào tay.\n\nKỹ năng mộ bài Loại Bỏ chủ động: mỗi lượt chỉ 1 lần. Chọn và đưa 2 lá trong mộ đối thủ đưa vào bộ bài."),
    (58307, "LABRYNTH SET-UP"),
    (58308, "Thiết Lập Trận Đồ"),
    (58309, "1 lượt 1 lá: Trộn tối đa 2 Phép/Bẫy Labrynth từ mộ/loại bỏ vào bộ bài; nếu có quái Labrynth, lấy bấy nhiêu Bẫy không phải Labrynth khác tên từ bộ bài lên tay."),
    (58310, "Tìm Kiếm Thuộc Hạ"),
    (58311, "Kỹ năng mộ chủ động: 1 lượt 1 lần, loại bỏ lá này để lấy 1 quái Labrynth <= 4 sao từ bộ bài lên tay."),
    (58312, "Xáo Trộn Mộ Phần"),
    (58313, "Kỹ năng loại bỏ chủ động: 1 lượt 1 lần, chọn 2 lá trong mộ đối thủ trộn vào bộ bài đối thủ."),

    (58314, "LABRYNTH LABYRINTH"),
    (58315, "[Phép Môi Trường / UR]\nTừ khóa: \"Labrynth\"\nKhi kích hoạt; lá Phép này đặt vào khu Phép/Bẫy.\n\nKhi có mặt: quái có từ khóa “Labrynth” phe ta khi lên sân sẽ nhận được “Khiên Chắn Quái/Phép/Bẫy” và tăng 300 tấn công.\n\nChủ động: mỗi lượt chỉ 1 lần; khi phe ta kích hoạt lá Bẫy thành công có thể kích hoạt; chọn và triệu hồi 1 quái vật có từ khóa “Labrynth” trên tay phe ta.\n\nChủ động: mỗi lượt chỉ 1 lần. Chọn 1 lá bài trên sân đối thủ và đưa vào mộ (bỏ qua “Tường Chắn Phép”).\n\nChủ động: mỗi lượt 1 lần. Chọn và lấy 1 lá Phép/Bẫy có từ khóa “Labrynth” trong mộ/mộ bài Loại Bỏ phe ta vào tay.\n\nKỹ năng mộ loại bỏ chủ động: mỗi lượt chỉ 1 lần. Chọn và triệu hồi đặc biệt 1 quái không phải Quái dung hợp trong mộ/mộ loại bỏ của đối thủ về sân của phe ta."),
    (58316, "LABRYNTH LABYRINTH"),
    (58317, "Lãnh Địa Mê Cung"),
    (58318, "Kích hoạt và đặt vào khu Phép/Bẫy."),
    (58319, "Hộ Thần Mê Cung"),
    (58320, "Khi có mặt: Quái Labrynth lên sân nhận Khiên Chắn Quái/Phép/Bẫy và tăng 300 tấn công."),
    (58321, "Hiệu Triệu Cạm Bẫy"),
    (58322, "Chủ động: 1 lượt 1 lần khi kích hoạt bẫy thành công: Triệu hồi đặc biệt 1 quái Labrynth từ tay lên sân."),
    (58323, "Tiêu Diệt Xâm Lược"),
    (58324, "Chủ động: 1 lượt 1 lần, chọn 1 lá trên sân đối thủ đưa vào mộ (bỏ qua Tường Chắn Phép)."),
    (58325, "Thu Hồi Tàn Tích"),
    (58326, "Chủ động: 1 lượt 1 lần, lấy 1 lá Phép/Bẫy Labrynth từ mộ/loại bỏ lên tay."),
    (58327, "Thao Túng Linh Hồn"),
    (58328, "Kỹ năng loại bỏ chủ động: 1 lượt 1 lần, triệu hồi đặc biệt 1 quái (không phải Dung hợp) từ mộ/loại bỏ đối thủ về sân phe ta.")
]

# 1. Update MySQL
conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4', autocommit=True)
with conn.cursor() as cur:
    traps_data = [
        (30602, "FAREWELCOME LABRYNTH", "Thông Thường", "Labrynth", "UR", 3, "farewelcomelabrynth", STRINGS[1][1], ""),
        (30603, "LABRYNTH BARRAGE", "Vĩnh Cửu", "Labrynth", "UR", 3, "labrynthbarrage", STRINGS[10][1], ""),
        (30604, "WELCOME LABRYNTH", "Thông Thường", "Labrynth", "UR", 3, "welcomelabrynth", STRINGS[23][1], ""),
        (30605, "BIG WELCOME LABRYNTH", "Thông Thường", "Labrynth", "UR", 3, "bigwelcomelabrynth", STRINGS[36][1], ""),
    ]
    cur.executemany("""
        INSERT INTO card_traps (id, name, type, keyword, quality, max_count, pinyin, description, guide)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE name=VALUES(name), type=VALUES(type), keyword=VALUES(keyword),
                                quality=VALUES(quality), max_count=VALUES(max_count),
                                pinyin=VALUES(pinyin), description=VALUES(description)
    """, traps_data)
    print(f"[OK] Inserted/Updated {len(traps_data)} traps in MySQL card_traps")

    spells_data = [
        (21172, "LABRYNTH SET-UP", "Thông Thường", "Labrynth", "UR", 3, "labrynthsetup", STRINGS[49][1], ""),
        (21173, "LABRYNTH LABYRINTH", "Môi Trường", "Labrynth", "UR", 3, "labrynthlabyrinth", STRINGS[60][1], "")
    ]
    cur.executemany("""
        INSERT INTO card_spells (id, name, type, keyword, quality, max_count, pinyin, description, guide)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE name=VALUES(name), type=VALUES(type), keyword=VALUES(keyword),
                                quality=VALUES(quality), max_count=VALUES(max_count),
                                pinyin=VALUES(pinyin), description=VALUES(description)
    """, spells_data)
    print(f"[OK] Inserted/Updated {len(spells_data)} spells in MySQL card_spells")

conn.close()

# 2. Update web/data/skill.lua
skill_path = r"D:\yugitauapk\web\data\skill.lua"
with open(skill_path, 'r', encoding='utf-8') as f:
    skill_content = f.read()

skills_lua = ""
# skill mapping: (sid, name_sid, desc_sid, modes, effect_val, quality)
skill_defs = [
    (20194, 58264, 58265, [34, 32], 194, 4),
    (20195, 58266, 58267, [91], 195, 4),
    (20196, 58268, 58269, [91, 32], 196, 4),
    (20197, 58273, 58274, [32], 197, 4),
    (20198, 58275, 58276, [31], 198, 4),
    (20199, 58277, 58278, [31], 199, 4),
    (20200, 58279, 58280, [32], 200, 4),
    (20201, 58281, 58282, [91, 32], 201, 4),
    (20202, 58286, 58287, [32], 202, 4),
    (20203, 58288, 58289, [91], 203, 4),
    (20204, 58290, 58291, [91, 92], 204, 4),
    (20205, 58292, 58293, [91, 32], 205, 4),
    (20206, 58297, 58298, [32], 206, 4),
    (20207, 58299, 58300, [91], 207, 4),
    (20208, 58301, 58302, [92], 208, 4),
    (20209, 58303, 58304, [91, 32], 209, 4),
    (20210, 58308, 58309, [32, 1], 210, 4),
    (20211, 58310, 58311, [91], 211, 4),
    (20212, 58312, 58313, [92], 212, 4),
    (20213, 58317, 58318, [32, 1], 213, 4),
    (20214, 58319, 58320, [1], 214, 4),
    (20215, 58321, 58322, [31], 215, 4),
    (20216, 58323, 58324, [31], 216, 4),
    (20217, 58325, 58326, [31], 217, 4),
    (20218, 58327, 58328, [92], 218, 4),
]

for sid, nsid, dsid, modes, eval, q in skill_defs:
    modes_str = ",".join([f"[{i+1}]={m}" for i, m in enumerate(modes)]) + ","
    line = f'  [{sid}]={{["_against"]={{[1]=0,}},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={{[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,}},["_descSid"]={dsid},["_effectVal"]={{[1]={eval},}},["_id"]={sid},["_isIgnoreDefend"]=0,["_modes"]={{{modes_str}}},["_nameSid"]={nsid},["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={{[1]=1,}},["_priority"]=0,["_quality"]={q},["_refCards"]={{[1]=0,}},["_refSkills"]={{[1]=0,}},["_sourceStatus"]=0,["_target"]=1,["_val"]={{[1]=0,}},}},\n'
    if f"[{sid}]=" not in skill_content:
        skills_lua += line

if skills_lua:
    idx = skill_content.rfind("}")
    if idx != -1:
        skill_content = skill_content[:idx] + skills_lua + skill_content[idx:]
        with open(skill_path, 'w', encoding='utf-8') as f:
            f.write(skill_content)
        print(f"[OK] Added {len(skill_defs)} skills to web/data/skill.lua")
else:
    print("[SKIP] Skills already in web/data/skill.lua")

# 3. Update web/data/trap.lua
trap_path = r"D:\yugitauapk\web\data\trap.lua"
with open(trap_path, 'r', encoding='utf-8') as f:
    trap_content = f.read()

traps_to_add = [
    (30602, 58263, 58262, 58261, "farewelcomelabrynth", 4, [20194, 20195, 20196], 12, 1),
    (30603, 58272, 58271, 58270, "labrynthbarrage", 4, [20197, 20198, 20199, 20200, 20201], 13, 2),
    (30604, 58285, 58284, 58283, "welcomelabrynth", 4, [20202, 20203, 20204, 20205], 12, 1),
    (30605, 58296, 58295, 58294, "bigwelcomelabrynth", 4, [20206, 20207, 20208, 20209], 12, 1),
]

traps_lua = ""
for cid, bsid, dsid, nsid, py, q, sids, tp, opt in traps_to_add:
    sids_str = ",".join([f"[{i+1}]={s}" for i, s in enumerate(sids)]) + ","
    line = f'  [{cid}]={{["_available"]=1,["_briefNameSid"]={bsid},["_descSid"]={dsid},["_guideSid"]=0,["_id"]={cid},["_isHide"]=0,["_isSummon"]=0,["_keyword"]=308,["_maxCount"]=3,["_nameSid"]={nsid},["_option"]={opt},["_originId"]=0,["_packageId"]={{[1]=0,}},["_picId"]=0,["_py"]="{py}",["_quality"]={q},["_recruitable"]=1,["_skillId"]={{{sids_str}}},["_targetType"]=0,["_type"]={tp},}},\n'
    if f"[{cid}]=" not in trap_content:
        traps_lua += line

if traps_lua:
    idx = trap_content.rfind("}")
    if idx != -1:
        trap_content = trap_content[:idx] + traps_lua + trap_content[idx:]
        with open(trap_path, 'w', encoding='utf-8') as f:
            f.write(trap_content)
        print(f"[OK] Added {len(traps_to_add)} traps to web/data/trap.lua")
else:
    print("[SKIP] Traps already in web/data/trap.lua")

# 4. Update web/data/magic.lua
magic_path = r"D:\yugitauapk\web\data\magic.lua"
with open(magic_path, 'r', encoding='utf-8') as f:
    magic_content = f.read()

spells_to_add = [
    (21172, 58307, 58306, 58305, "labrynthsetup", 4, [20210, 20211, 20212], 11, 1),
    (21173, 58316, 58315, 58314, "labrynthlabyrinth", 4, [20213, 20214, 20215, 20216, 20217, 20218], 13, 4),
]

spells_lua = ""
for cid, bsid, dsid, nsid, py, q, sids, tp, opt in spells_to_add:
    sids_str = ",".join([f"[{i+1}]={s}" for i, s in enumerate(sids)]) + ","
    line = f'  [{cid}]={{["_available"]=1,["_briefNameSid"]={bsid},["_descSid"]={dsid},["_guideSid"]=0,["_id"]={cid},["_isHide"]=0,["_isSummon"]=0,["_keyword"]=308,["_maxCount"]=3,["_nameSid"]={nsid},["_option"]={opt},["_originId"]=0,["_packageId"]={{[1]=0,}},["_picId"]=0,["_py"]="{py}",["_quality"]={q},["_recruitable"]=1,["_skillId"]={{{sids_str}}},["_targetType"]=0,["_type"]={tp},}},\n'
    if f"[{cid}]=" not in magic_content:
        spells_lua += line

if spells_lua:
    idx = magic_content.rfind("}")
    if idx != -1:
        magic_content = magic_content[:idx] + spells_lua + magic_content[idx:]
        with open(magic_path, 'w', encoding='utf-8') as f:
            f.write(magic_content)
        print(f"[OK] Added {len(spells_to_add)} spells to web/data/magic.lua")
else:
    print("[SKIP] Spells already in web/data/magic.lua")

# 5. Update web/src/h5_patch.lua:
# Add Strings, Data._trapInfo, Data._magicInfo, Data._skillInfo
patch_path = r"D:\yugitauapk\web\src\h5_patch.lua"
with open(patch_path, 'r', encoding='utf-8') as f:
    patch_content = f.read()

# Generate patch code for h5_patch.lua
patch_trap_code = """
			-- 4 Labrynth Traps: 30602..30605
			if Data._trapInfo then
				Data._trapInfo[30602] = {
					_available = 1, _briefNameSid = 58263, _descSid = 58262, _guideSid = 0,
					_id = 30602, _isHide = 0, _isSummon = 0, _keyword = 308, _maxCount = 3,
					_nameSid = 58261, _option = 1, _originId = 0, _packageId = { 0 },
					_picId = 0, _py = "farewelcomelabrynth", _quality = 4, _recruitable = 1,
					_skillId = { 20194, 20195, 20196 }, _targetType = 0, _type = 12
				}
				Data._trapInfo[30603] = {
					_available = 1, _briefNameSid = 58272, _descSid = 58271, _guideSid = 0,
					_id = 30603, _isHide = 0, _isSummon = 0, _keyword = 308, _maxCount = 3,
					_nameSid = 58270, _option = 4, _originId = 0, _packageId = { 0 },
					_picId = 0, _py = "labrynthbarrage", _quality = 4, _recruitable = 1,
					_skillId = { 20197, 20198, 20199, 20200, 20201 }, _targetType = 0, _type = 13
				}
				Data._trapInfo[30604] = {
					_available = 1, _briefNameSid = 58285, _descSid = 58284, _guideSid = 0,
					_id = 30604, _isHide = 0, _isSummon = 0, _keyword = 308, _maxCount = 3,
					_nameSid = 58283, _option = 1, _originId = 0, _packageId = { 0 },
					_picId = 0, _py = "welcomelabrynth", _quality = 4, _recruitable = 1,
					_skillId = { 20202, 20203, 20204, 20205 }, _targetType = 0, _type = 12
				}
				Data._trapInfo[30605] = {
					_available = 1, _briefNameSid = 58296, _descSid = 58295, _guideSid = 0,
					_id = 30605, _isHide = 0, _isSummon = 0, _keyword = 308, _maxCount = 3,
					_nameSid = 58294, _option = 1, _originId = 0, _packageId = { 0 },
					_picId = 0, _py = "bigwelcomelabrynth", _quality = 4, _recruitable = 1,
					_skillId = { 20206, 20207, 20208, 20209 }, _targetType = 0, _type = 12
				}
			end
			-- 2 Labrynth Spells: 21172..21173
			if Data._magicInfo then
				Data._magicInfo[21172] = {
					_available = 1, _briefNameSid = 58307, _descSid = 58306, _guideSid = 0,
					_id = 21172, _isHide = 0, _isSummon = 0, _keyword = 308, _maxCount = 3,
					_nameSid = 58305, _option = 1, _originId = 0, _packageId = { 0 },
					_picId = 0, _py = "labrynthsetup", _quality = 4, _recruitable = 1,
					_skillId = { 20210, 20211, 20212 }, _targetType = 0, _type = 11
				}
				Data._magicInfo[21173] = {
					_available = 1, _briefNameSid = 58316, _descSid = 58315, _guideSid = 0,
					_id = 21173, _isHide = 0, _isSummon = 0, _keyword = 308, _maxCount = 3,
					_nameSid = 58314, _option = 4, _originId = 0, _packageId = { 0 },
					_picId = 0, _py = "labrynthlabyrinth", _quality = 4, _recruitable = 1,
					_skillId = { 20213, 20214, 20215, 20216, 20217, 20218 }, _targetType = 0, _type = 13
				}
			end
"""

patch_skill_code = """
			-- Skills 20194..20218
			if Data._skillInfo then
"""
for sid, nsid, dsid, modes, eval, q in skill_defs:
    modes_str = "{" + ", ".join(map(str, modes)) + "}"
    patch_skill_code += f"""				Data._skillInfo[{sid}] = {{
					_against = {{ 0 }}, _avoidP2B = 0, _count = 1, _decrease = {{ 0, 0, 0, 0, 0 }},
					_descSid = {dsid}, _effectVal = {{ {eval} }}, _id = {sid}, _isIgnoreDefend = 0,
					_modes = {modes_str}, _nameSid = {nsid}, _needExtraGem = 0, _needNoGem = 0,
					_option = {{ 1 }}, _priority = 0, _quality = {q}, _refCards = {{ 0 }},
					_refSkills = {{ 0 }}, _sourceStatus = 0, _target = 1, _val = {{ 0 }}
				}}\n"""
patch_skill_code += "			end\n"

if "Data._trapInfo[30602]" not in patch_content:
    target_str = "if not Data._trapInfo[30598] then"
    if target_str in patch_content:
        patch_content = patch_content.replace(target_str, patch_trap_code + "\n\t\t\t" + target_str, 1)
        print("[OK] Added 30602..30605 & 21172..21173 to h5_patch.lua")

if "Data._skillInfo[20194]" not in patch_content:
    target_skill_str = "Data._skillInfo[20117] = {"
    if target_skill_str in patch_content:
        patch_content = patch_content.replace(target_skill_str, patch_skill_code + "\n\t\t\t\t" + target_skill_str, 1)
        print("[OK] Added 20194..20218 to h5_patch.lua")

# Strings in h5_patch.lua
strings_lua = "\n\t\t-- Labrynth Batch 3 (58261 - 58328)\n"
for sid, text in STRINGS:
    clean_txt = text.replace('"', '\\"').replace('\n', '\\n')
    strings_lua += f'\t\t[{sid}] = "{clean_txt}",\n'

if "[58261]" not in patch_content:
    target_str_anchor = '\t\t[58050] = "Dimensional Barrier",'
    if target_str_anchor in patch_content:
        patch_content = patch_content.replace(target_str_anchor, strings_lua + target_str_anchor, 1)
        print("[OK] Added strings 58261..58328 to h5_patch.lua")

with open(patch_path, 'w', encoding='utf-8') as f:
    f.write(patch_content)

# 6. Update ClientView.lua customCards
cv_path = r"D:\yugitauapk\web\src\ClientView.lua"
with open(cv_path, 'r', encoding='utf-8') as f:
    cv_content = f.read()

target_cv = "[12381] = true"
repl_cv = "[12381] = true, [30602] = true, [30603] = true, [30604] = true, [30605] = true, [21172] = true, [21173] = true"
if "[30602]" not in cv_content:
    if target_cv in cv_content:
        cv_content = cv_content.replace(target_cv, repl_cv, 1)
        with open(cv_path, 'w', encoding='utf-8') as f:
            f.write(cv_content)
        print("[OK] Updated ClientView.lua with 30602..30605 and 21172..21173")
    else:
        print("[WARN] Target [12381] = true not found in ClientView.lua")
else:
    print("[SKIP] Cards already in ClientView.lua")

print("[*] Batch 3 data applied successfully!")
