import sys
sys.stdout.reconfigure(encoding='utf-8')

STRINGS = [
    (58168, "SID_MONSTER_NAME_12377", "ARIAS THE LABRYNTH BUTLER"),
    (58169, "SID_MONSTER_DESC_12377", "[Quỷ / Hiệu Ứng / UR]"),
    (58170, "SID_MONSTER_BRIEFNAME_12377", "ARIAS THE LABRYNTH BUTLER"),
    (58171, "SID_SKILL_NAME_20155", "Quản Gia Tiếp Đón"),
    (58172, "SID_SKILL_DESC_20155", "Kỹ năng tay chủ động: mỗi lượt chỉ 1 lần. Hi sinh bản thân lá này; chọn và Triệu Hồi Đặc Biệt 1 lá quái vật có từ khóa “Labrynth” từ tay/bộ bài phe ta."),
    (58173, "SID_SKILL_NAME_20156", "Chuẩn Bị Cạm Bẫy"),
    (58174, "SID_SKILL_DESC_20156", "Chủ động: mỗi lượt chỉ 1 lần. Hi sinh bản thân lá này; lấy 1 lá bài Phép/Bẫy có từ khóa “Labrynth” từ bộ bài phe ta vào tay ."),
    (58175, "SID_SKILL_NAME_20157", "Quản Gia Tái Xuất"),
    (58176, "SID_SKILL_DESC_20157", "Khi lá này nằm trong mộ. Mỗi lượt chỉ 1 lần. Khi phe ta hoặc đối thủ kích hoạt hiệu ứng Quái hoặc bài Bẫy; triệu hồi đặc biệt bản thân lá này lên sân phe ta."),
    (58177, "SID_SKILL_NAME_20158", "Thu Thập Mộ Phần"),
    (58178, "SID_SKILL_DESC_20158", "Kỹ năng mộ chủ động:Mỗi lượt chỉ 1 lần. Hi sinh bản thân lá này. Chọn 1 lá trong mộ đối thủ đưa về mộ phe ta."),

    (58179, "SID_MONSTER_NAME_12378", "LABRYNTH ARCHFIEND"),
    (58180, "SID_MONSTER_DESC_12378", "[Quỷ / Hiệu Ứng / UR]"),
    (58181, "SID_MONSTER_BRIEFNAME_12378", "LABRYNTH ARCHFIEND"),
    (58182, "SID_SKILL_NAME_20159", "Giáp Quỷ Bất Hoại"),
    (58183, "SID_SKILL_DESC_20159", "Khi lên sân, nhận được \"Khiên Chắn Phá Hủy”."),
    (58184, "SID_SKILL_NAME_20160", "Tượng Đài Canh Gác"),
    (58185, "SID_SKILL_DESC_20160", "Khi trên sân, lá bài này không thể tấn công."),
    (58186, "SID_SKILL_NAME_20161", "Tấm Khiên Mê Cung"),
    (58187, "SID_SKILL_DESC_20161", "Khi có mặt, nếu trên sân phe ta có quái khác có từ khóa \"Labrynth\"; đối thủ chỉ có thể chọn lá bài này làm mục tiêu tấn công."),
    (58188, "SID_SKILL_NAME_20162", "Uy Lực Bẫy Ngầm"),
    (58189, "SID_SKILL_DESC_20162", "Khi lá này nằm trên sân. Tăng tấn công và phòng thủ bằng tổng số lá Bẫy trong mộ/mộ bài loại bỏ phe ta×400."),
    (58190, "SID_SKILL_NAME_20163", "Ác Quỷ Phục Kích"),
    (58191, "SID_SKILL_DESC_20163", "Kỹ năng tay chủ động: Khi lá này ở trên tay, khi phe ta kích hoạt bài Bẫy. Mỗi lượt chỉ 1 lần. Triệu hồi đặc biệt bản thân bài này từ trên tay."),
    (58192, "SID_SKILL_NAME_20164", "Truy Tìm Bẫy Mê Cung"),
    (58193, "SID_SKILL_DESC_20164", "Chủ động: Mỗi lượt chỉ 1 lần. Chọn và lấy 1 lá bài Bẫy từ khóa “Labrynth” từ bộ bài phe ta vào tay."),
    (58194, "SID_SKILL_NAME_20165", "Hộ Mệnh Vực Thẳm"),
    (58195, "SID_SKILL_DESC_20165", "Khi bài này nằm trong mộ, phe ta bị mất LP từ chiến đấu trực tiếp sẽ có thể dùng. Loại bỏ bản thân bài này, bỏ qua lần sát thương đó."),

    (58196, "SID_MONSTER_NAME_12379", "LADY LABRYNTH OF THE SILVER CASTLE"),
    (58197, "SID_MONSTER_DESC_12379", "[Quỷ / Hiệu Ứng / UR]"),
    (58198, "SID_MONSTER_BRIEFNAME_12379", "LADY LABRYNTH OF THE SILVER CASTLE"),
    (58199, "SID_SKILL_NAME_20166", "Quý Cô Giá Lâm"),
    (58200, "SID_SKILL_DESC_20166", "Kỹ năng tay chủ động: mỗi lượt chỉ 1 lần. Nếu một lá bài có từ khóa \"Labrynth\" hoặc một Lá bài Bẫy Thường được kích hoạt trong lượt này, ngoại trừ \"Lady Labrynth of the Silver Castle\" có thể kích hoạt; Triệu hồi Đặc biệt lá bài này từ trên tay."),
    (58201, "SID_SKILL_NAME_20167", "Quyền Uy Lâu Đài Bạc"),
    (58202, "SID_SKILL_DESC_20167", "Khi bài này được Triệu Hồi Đặc Biệt, khi lên sân, bài này tăng tấn công bằng tổng số Bẫy có từ khóa “Labrynth” đang có mặt trong mộ mộ bài loại bỏ phe ta x300 (bỏ qua \"Tường Chắn Quái\")."),
    (58203, "SID_SKILL_NAME_20168", "Hộ Giáp Bạch Ngân"),
    (58204, "SID_SKILL_DESC_20168", "khi bài này lên sân, sẽ nhận được \"Tường Chắn Quái\"."),
    (58205, "SID_SKILL_NAME_20169", "Bảo Hộ Cạm Bẫy"),
    (58206, "SID_SKILL_DESC_20169", "Khi bài này trên sân, Khi bài Bẫy phe ta điều khiển bị ảnh hưởng bởi bài đối thủ, hiệu ứng sẽ bị bỏ qua."),
    (58207, "SID_SKILL_NAME_20170", "Phán Quyết Bạch Ngân"),
    (58208, "SID_SKILL_DESC_20170", "Chủ động. Mỗi lượt chỉ 1 lần. Chọn tối đa 1 lá bài trên sân đối thủ và đưa vào mộ (bỏ qua \"Tường Chắn Quái\")."),
    (58209, "SID_SKILL_NAME_20171", "Thiết Lập Mê Cung"),
    (58210, "SID_SKILL_DESC_20171", "Chủ động: Mỗi lượt chỉ 1 lần. Chọn và lấy 1 lá Bẫy từ bộ bài phe ta vào tay."),
    (58211, "SID_SKILL_NAME_20172", "Hoàng Tộc Tương Trợ"),
    (58212, "SID_SKILL_DESC_20172", "1 lần trong một vòng. Khi ở trên sân, khi phe của bạn triệu hồi một Quái Vật 8 sao có từ khóa “Labrynth” ngoại trừ “Lady Labrynth of the Silver Castle”, hãy rút một lá bài."),
    (58213, "SID_SKILL_NAME_20173", "Phong Ấn Ngoại Điện"),
    (58214, "SID_SKILL_DESC_20173", "Kỹ năng kích hoạt: Chỉ một lần mỗi vòng, Khi phe ta kích hoạt bài Bẫy có thể kích hoạt. Chọn tối đa 2 quái vật từ bộ bài phụ của đối thủ và tạm thời trục xuất chúng cho đến hết lượt tiếp theo của đối thủ."),
    (58215, "SID_SKILL_NAME_20174", "Trừng Phạt Kẻ Xâm Nhập"),
    (58216, "SID_SKILL_DESC_20174", "Mỗi lượt chỉ 1 lần. Khi đối thủ Triệu Hồi Đặc Biệt quái vật, phá hủy quái đối thủ vừa triệu hồi (bỏ qua \"Khiên Chắn Quái\")."),
    (58217, "SID_SKILL_NAME_20175", "Di Sản Bạch Ngân"),
    (58218, "SID_SKILL_DESC_20175", "Kỹ năng mộ loại bỏ chủ động: Mỗi lượt chỉ 1 lần. Chọn và lấy 1 lá Bẫy, có từ khóa “Labrynth” từ mộ/mộ bài loại bỏ phe ta vào tay. Kỹ năng chỉ kích hoạt 1 lần."),

    (58219, "SID_MONSTER_NAME_12380", "LOVELY LABRYNTH OF THE SILVER CASTLE"),
    (58220, "SID_MONSTER_DESC_12380", "[Quỷ / Hiệu Ứng / UR]"),
    (58221, "SID_MONSTER_BRIEFNAME_12380", "LOVELY LABRYNTH OF THE SILVER CASTLE"),
    (58222, "SID_SKILL_NAME_20176", "Lời Mời Vào Mê Cung"),
    (58223, "SID_SKILL_DESC_20176", "Kỹ năng tay chủ động: Mỗi lượt chỉ 1 lần. Chọn 1 bài quái trên sân đối thủ và 1 lá bẫy trên tay phe ta đưa vào mộ loại bỏ (bỏ qua “Tường Chắn Quái”). Sau đó triệu hồi Đặc biệt bài này lên sân."),
    (58224, "SID_SKILL_NAME_20177", "Quyền Uy Lâu Đài Bạc"),
    (58225, "SID_SKILL_DESC_20177", "Khi bài này được Triệu Hồi Đặc Biệt, khi lên sân, bài này tăng tấn công bằng tổng số Bẫy có từ khóa “Labrynth” đang có mặt trong mộ mộ bài loại bỏ phe ta x300 (bỏ qua \"Tường Chắn Quái\")."),
    (58226, "SID_SKILL_NAME_20178", "Hộ Giáp Bạch Ngân"),
    (58227, "SID_SKILL_DESC_20178", "khi bài này lên sân, sẽ nhận được \"Tường Chắn Quái\"."),
    (58228, "SID_SKILL_NAME_20179", "Bảo Hộ Cạm Bẫy"),
    (58229, "SID_SKILL_DESC_20179", "Khi bài này trên sân, Khi bài Bẫy phe ta điều khiển bị ảnh hưởng bởi bài đối thủ, hiệu ứng sẽ bị bỏ qua."),
    (58230, "SID_SKILL_NAME_20180", "Chiếm Đoạt Linh Hồn"),
    (58231, "SID_SKILL_DESC_20180", "Mỗi lượt chỉ 1 lần. Khi đối thủ Triệu Hồi Đặc Biệt quái vật, đưa quái đối thủ vừa triệu hồi vào mộ phe ta. (bỏ qua \"Khiên Chắn Quái\")"),
    (58232, "SID_SKILL_NAME_20181", "Trục Xuất Bất Ngờ"),
    (58233, "SID_SKILL_DESC_20181", "Mỗi lượt chỉ 1 lần. Khi Phe ta hoặc đối thủ dùng bài Bẫy sẽ kích hoạt. Trục xuất ngẫu nhiên 1 lá trên tay đối thủ."),
    (58234, "SID_SKILL_NAME_20182", "Tái Thiết Cạm Bẫy"),
    (58235, "SID_SKILL_DESC_20182", "Chủ động: Mỗi lượt chỉ 1 lần. Chọn và lấy tối đa 2 lá Bẫy trong mộ phe ta vào tay."),
    (58236, "SID_SKILL_NAME_20183", "Thu Hồi Phép Bẫy"),
    (58237, "SID_SKILL_DESC_20183", "Chủ động: mỗi lượt chỉ 1 lần. Chọn và lấy 1 lá Phép/Bẫy trong mộ loại bỏ phe ta vào tay."),
    (58238, "SID_SKILL_NAME_20184", "Triệu Tập Gia Nhân"),
    (58239, "SID_SKILL_DESC_20184", "Kỹ năng mộ loại bỏ chủ động: Mỗi lượt chỉ 1 lần. Chọn và lấy 1 quái 4 sao trở xuống, có từ khóa “Labrynth” từ bộ bài vào tay. Kỹ năng chỉ kích hoạt 1 lần."),

    (58240, "SID_MONSTER_NAME_12381", "PRINCESS LABRYNTH OF THE SILVER CASTLE"),
    (58241, "SID_MONSTER_DESC_12381", "[Quỷ / Hiệu Ứng / GR]"),
    (58242, "SID_MONSTER_BRIEFNAME_12381", "PRINCESS LABRYNTH OF THE SILVER CASTLE"),
    (58243, "SID_SKILL_NAME_20185", "Công Chúa Giá Lâm"),
    (58244, "SID_SKILL_DESC_20185", "Kỹ năng tay chủ động: Mỗi lượt chỉ 1 lần. Triệu Hồi Đặc Biệt bài này từ bài trên tay."),
    (58245, "SID_SKILL_NAME_20186", "Quyền Uy Lâu Đài Bạc"),
    (58246, "SID_SKILL_DESC_20186", "Khi bài này được Triệu Hồi Đặc Biệt, khi lên sân, bài này tăng tấn công bằng tổng số Bẫy có từ khóa “Labrynth” đang có mặt trong mộ mộ bài loại bỏ phe ta x300 (bỏ qua \"Tường Chắn Quái\")."),
    (58247, "SID_SKILL_NAME_20187", "Bảo Hộ Cạm Bẫy"),
    (58248, "SID_SKILL_DESC_20187", "Khi bài này trên sân, Khi bài Bẫy phe ta điều khiển bị ảnh hưởng bởi bài đối thủ, hiệu ứng sẽ bị bỏ qua."),
    (58249, "SID_SKILL_NAME_20188", "Bất Khả Xâm Phạm"),
    (58250, "SID_SKILL_DESC_20188", "Khi vào: Nhận được \"Quái vật, Phép thuật, Bẫy Rào chắn”."),
    (58251, "SID_SKILL_NAME_20189", "Kho Tàng Cạm Bẫy"),
    (58252, "SID_SKILL_DESC_20189", "Chủ động: Mỗi lượt chỉ 1 lần. Chọn và lấy 2 lá Bẫy từ bộ bài/mộ/mộ loại bỏ phe ta vào tay."),
    (58253, "SID_SKILL_NAME_20190", "Lệnh Triệu Tập Hoàng Gia"),
    (58254, "SID_SKILL_DESC_20190", "Chủ động: Mỗi lượt chỉ 1 lần. Chọn và lấy 1 lá quái vật có từ khóa “Labrynth” từ bộ bài phe ta vào tay."),
    (58255, "SID_SKILL_NAME_20191", "Hủy Diệt Triệu Hồi Phụ"),
    (58256, "SID_SKILL_DESC_20191", "Mỗi lượt chỉ 1 lần. Khi đối thủ Triệu Hồi Đặc Biệt Quái từ bộ bài phụ: phá hủy quái đối thủ vừa triệu hồi (bỏ qua \"Khiên Chắn Quái\")."),
    (58257, "SID_SKILL_NAME_20192", "Lời Nguyền Bạch Ngân"),
    (58258, "SID_SKILL_DESC_20192", "Khi rời sân trong lượt của đối thủ. Tất cả Quái Vật của đối thủ không thể tấn công và không thể sử dụng bài trên tay."),
    (58259, "SID_SKILL_NAME_20193", "Hồi Sinh Từ Vực Thẳm"),
    (58260, "SID_SKILL_DESC_20193", "Kỹ năng mộ chủ động: Mỗi lượt chỉ 1 lần. Chọn và loại bỏ 2 lá trong mộ của đối thủ. Triệu hồi đặc biệt bản thân lá này lên sân. Nếu triệu hồi bằng cách lên sân chỉ nhận được “Tường Chắn Quái”."),
]

# 1. Update web/res/lan.lcres/extend.lan
lan_path = r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
with open(lan_path, "r", encoding="utf-8") as f:
    lines = f.read().splitlines()

while len(lines) < 58260:
    lines.append("")
for sid, _, text in STRINGS:
    lines[sid - 1] = text

with open(lan_path, "w", encoding="utf-8") as f:
    f.write("\n".join(lines) + "\n")
print(f"[OK] Updated extend.lan (total lines: {len(lines)})")

# 2. Update web/src/StringEnums.lua
se_path = r"D:\yugitauapk\web\src\StringEnums.lua"
with open(se_path, "r", encoding="utf-8") as f:
    se_text = f.read()

if "SID_MONSTER_NAME_12377" not in se_text:
    enum_add = ""
    for sid, ename, _ in STRINGS:
        enum_add += f"\t{ename} = {sid},\n"
    se_text = se_text.replace("\tSID_SKILL_DESC_20154 = 58167,\n}", "\tSID_SKILL_DESC_20154 = 58167,\n" + enum_add + "}")
    with open(se_path, "w", encoding="utf-8") as f:
        f.write(se_text)
    print("[OK] Updated StringEnums.lua")

# 3. Update web/data/monster.lua
m_path = r"D:\yugitauapk\web\data\monster.lua"
with open(m_path, "r", encoding="utf-8") as f:
    m_text = f.read()

if "[12377]=" not in m_text:
    new_monsters_lua = """  [12377]={["_atk"]={[1]=1500,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58170,["_category"]=4,["_cost"]=0,["_descSid"]=58169,["_guideSid"]=0,["_hp"]={[1]=2500,},["_id"]=12377,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58168,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="ariasthelabrynthbutler",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20155,[2]=20156,[3]=20157,[4]=20158,},["_skin"]={[1]=0,},["_star"]=6,},
  [12378]={["_atk"]={[1]=2000,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58181,["_category"]=4,["_cost"]=0,["_descSid"]=58180,["_guideSid"]=0,["_hp"]={[1]=2800,},["_id"]=12378,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58179,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="labryntharchfiend",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20159,[2]=20160,[3]=20161,[4]=20162,[5]=20163,[6]=20164,[7]=20165,},["_skin"]={[1]=0,},["_star"]=7,},
  [12379]={["_atk"]={[1]=3000,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58198,["_category"]=4,["_cost"]=0,["_descSid"]=58197,["_guideSid"]=0,["_hp"]={[1]=2900,},["_id"]=12379,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58196,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="ladylabrynthofthesilvercastle",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20166,[2]=20167,[3]=20168,[4]=20169,[5]=20170,[6]=20171,[7]=20172,[8]=20173,[9]=20174,[10]=20175,},["_skin"]={[1]=0,},["_star"]=8,},
  [12380]={["_atk"]={[1]=2900,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58221,["_category"]=4,["_cost"]=0,["_descSid"]=58220,["_guideSid"]=0,["_hp"]={[1]=1900,},["_id"]=12380,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58219,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="lovelylabrynthofthesilvercastle",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20176,[2]=20177,[3]=20178,[4]=20179,[5]=20180,[6]=20181,[7]=20182,[8]=20183,[9]=20184,},["_skin"]={[1]=0,},["_star"]=8,},
  [12381]={["_atk"]={[1]=3500,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58242,["_category"]=4,["_cost"]=0,["_descSid"]=58241,["_guideSid"]=0,["_hp"]={[1]=3000,},["_id"]=12381,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58240,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="princesslabrynthofthesilvercastle",["_quality"]=5,["_recruitable"]=1,["_skillId"]={[1]=20185,[2]=20186,[3]=20187,[4]=20188,[5]=20189,[6]=20190,[7]=20191,[8]=20192,[9]=20193,},["_skin"]={[1]=0,},["_star"]=8,},
}"""
    idx = m_text.rfind("}")
    m_text = m_text[:idx] + new_monsters_lua + "\n"
    with open(m_path, "w", encoding="utf-8") as f:
        f.write(m_text)
    print("[OK] Updated web/data/monster.lua")

# 4. Update web/data/skill.lua
s_path = r"D:\yugitauapk\web\data\skill.lua"
with open(s_path, "r", encoding="utf-8") as f:
    s_text = f.read()

SKILLS_SPEC = [
    # 12377 ARIAS
    (20155, 58171, 58172, 155, "{[1]=34,}", "{[1]=12377,}", "{[1]=0,}", 0, 4),
    (20156, 58173, 58174, 156, "{[1]=31,}", "{[1]=12377,}", "{[1]=0,}", 0, 4),
    (20157, 58175, 58176, 157, "{[1]=91,}", "{[1]=12377,}", "{[1]=0,}", 0, 4),
    (20158, 58177, 58178, 158, "{[1]=32,}", "{[1]=12377,}", "{[1]=0,}", 0, 4),
    # 12378 LABRYNTH ARCHFIEND
    (20159, 58182, 58183, 159, "{[1]=2,}", "{[1]=12378,}", "{[1]=12006,}", 0, 4),
    (20160, 58184, 58185, 160, "{[1]=1,}", "{[1]=12378,}", "{[1]=0,}", 0, 4),
    (20161, 58186, 58187, 161, "{[1]=1,}", "{[1]=12378,}", "{[1]=2794,}", 0, 4),
    (20162, 58188, 58189, 162, "{[1]=1,}", "{[1]=12378,}", "{[1]=0,}", 0, 4),
    (20163, 58190, 58191, 163, "{[1]=34,}", "{[1]=12378,}", "{[1]=0,}", 0, 4),
    (20164, 58192, 58193, 164, "{[1]=31,}", "{[1]=12378,}", "{[1]=0,}", 0, 4),
    (20165, 58194, 58195, 165, "{[1]=91,}", "{[1]=12378,}", "{[1]=0,}", 0, 4),
    # 12379 LADY LABRYNTH
    (20166, 58199, 58200, 166, "{[1]=34,}", "{[1]=12379,}", "{[1]=0,}", 0, 4),
    (20167, 58201, 58202, 167, "{[1]=2,}", "{[1]=12379,}", "{[1]=0,}", 1, 4),
    (20168, 58203, 58204, 168, "{[1]=2,}", "{[1]=12379,}", "{[1]=12008,}", 0, 4),
    (20169, 58205, 58206, 169, "{[1]=1,}", "{[1]=12379,}", "{[1]=0,}", 0, 4),
    (20170, 58207, 58208, 170, "{[1]=31,}", "{[1]=12379,}", "{[1]=0,}", 1, 4),
    (20171, 58209, 58210, 171, "{[1]=31,}", "{[1]=12379,}", "{[1]=0,}", 0, 4),
    (20172, 58211, 58212, 172, "{[1]=1,}", "{[1]=12379,}", "{[1]=0,}", 0, 4),
    (20173, 58213, 58214, 173, "{[1]=31,}", "{[1]=12379,}", "{[1]=0,}", 0, 4),
    (20174, 58215, 58216, 174, "{[1]=1,}", "{[1]=12379,}", "{[1]=0,}", 1, 4),
    (20175, 58217, 58218, 175, "{[1]=35,}", "{[1]=12379,}", "{[1]=0,}", 0, 4),
    # 12380 LOVELY LABRYNTH
    (20176, 58222, 58223, 176, "{[1]=34,}", "{[1]=12380,}", "{[1]=0,}", 1, 4),
    (20177, 58224, 58225, 177, "{[1]=2,}", "{[1]=12380,}", "{[1]=0,}", 1, 4),
    (20178, 58226, 58227, 178, "{[1]=2,}", "{[1]=12380,}", "{[1]=12008,}", 0, 4),
    (20179, 58228, 58229, 179, "{[1]=1,}", "{[1]=12380,}", "{[1]=0,}", 0, 4),
    (20180, 58230, 58231, 180, "{[1]=1,}", "{[1]=12380,}", "{[1]=0,}", 1, 4),
    (20181, 58232, 58233, 181, "{[1]=1,}", "{[1]=12380,}", "{[1]=0,}", 0, 4),
    (20182, 58234, 58235, 182, "{[1]=31,}", "{[1]=12380,}", "{[1]=0,}", 0, 4),
    (20183, 58236, 58237, 183, "{[1]=31,}", "{[1]=12380,}", "{[1]=0,}", 0, 4),
    (20184, 58238, 58239, 184, "{[1]=35,}", "{[1]=12380,}", "{[1]=0,}", 0, 4),
    # 12381 PRINCESS LABRYNTH
    (20185, 58243, 58244, 185, "{[1]=34,}", "{[1]=12381,}", "{[1]=0,}", 0, 5),
    (20186, 58245, 58246, 186, "{[1]=2,}", "{[1]=12381,}", "{[1]=0,}", 1, 5),
    (20187, 58247, 58248, 187, "{[1]=1,}", "{[1]=12381,}", "{[1]=0,}", 0, 5),
    (20188, 58249, 58250, 188, "{[1]=2,}", "{[1]=12381,}", "{[1]=12008,[2]=12009,[3]=12010,}", 0, 5),
    (20189, 58251, 58252, 189, "{[1]=31,}", "{[1]=12381,}", "{[1]=0,}", 0, 5),
    (20190, 58253, 58254, 190, "{[1]=31,}", "{[1]=12381,}", "{[1]=0,}", 0, 5),
    (20191, 58255, 58256, 191, "{[1]=1,}", "{[1]=12381,}", "{[1]=0,}", 1, 5),
    (20192, 58257, 58258, 192, "{[1]=3,}", "{[1]=12381,}", "{[1]=0,}", 0, 5),
    (20193, 58259, 58260, 193, "{[1]=32,}", "{[1]=12381,}", "{[1]=12008,}", 0, 5),
]

if "[20155]=" not in s_text:
    new_skills_lua = ""
    for skid, nsid, dsid, eval_id, modes_str, refc_str, refs_str, ign_def, qual in SKILLS_SPEC:
        new_skills_lua += f'[{skid}]={{["_against"]={{[1]=0,}},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={{[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,}},["_descSid"]={dsid},["_effectVal"]={{[1]={eval_id},}},["_id"]={skid},["_isIgnoreDefend"]={ign_def},["_modes"]={modes_str},["_nameSid"]={nsid},["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={{[1]=0,}},["_priority"]=0,["_quality"]={qual},["_refCards"]={refc_str},["_refSkills"]={refs_str},["_removeMode"]={{[1]=0,}},["_targetType"]=0,["_val"]={{[1]=0,}},}},'
    idx = s_text.rfind("}")
    s_text = s_text[:idx] + new_skills_lua + "\n}\n"
    with open(s_path, "w", encoding="utf-8") as f:
        f.write(s_text)
    print("[OK] Updated web/data/skill.lua")

# 5. Update web/src/h5_patch.lua
hp_path = r"D:\yugitauapk\web\src\h5_patch.lua"
with open(hp_path, "r", encoding="utf-8") as f:
    hp_text = f.read()

if "Data._monsterInfo[12377]" not in hp_text:
    target_m = """				Data._monsterInfo[12376] = {
					_atk = { 2300 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58155, _category = 6, _cost = 0, _descSid = 58154, _guideSid = 0, _hp = { 1500 }, _id = 12376, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58153, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "labrynthknight", _quality = 4, _recruitable = 1, _skillId = { 20149, 20150, 20151, 20152, 20153, 20154 }, _skin = { 0 }, _star = 5
				}"""
    add_m = target_m + """
				Data._monsterInfo[12377] = {
					_atk = { 1500 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58170, _category = 4, _cost = 0, _descSid = 58169, _guideSid = 0, _hp = { 2500 }, _id = 12377, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58168, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "ariasthelabrynthbutler", _quality = 4, _recruitable = 1, _skillId = { 20155, 20156, 20157, 20158 }, _skin = { 0 }, _star = 6
				}
				Data._monsterInfo[12378] = {
					_atk = { 2000 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58181, _category = 4, _cost = 0, _descSid = 58180, _guideSid = 0, _hp = { 2800 }, _id = 12378, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58179, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "labryntharchfiend", _quality = 4, _recruitable = 1, _skillId = { 20159, 20160, 20161, 20162, 20163, 20164, 20165 }, _skin = { 0 }, _star = 7
				}
				Data._monsterInfo[12379] = {
					_atk = { 3000 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58198, _category = 4, _cost = 0, _descSid = 58197, _guideSid = 0, _hp = { 2900 }, _id = 12379, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58196, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "ladylabrynthofthesilvercastle", _quality = 4, _recruitable = 1, _skillId = { 20166, 20167, 20168, 20169, 20170, 20171, 20172, 20173, 20174, 20175 }, _skin = { 0 }, _star = 8
				}
				Data._monsterInfo[12380] = {
					_atk = { 2900 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58221, _category = 4, _cost = 0, _descSid = 58220, _guideSid = 0, _hp = { 1900 }, _id = 12380, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58219, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "lovelylabrynthofthesilvercastle", _quality = 4, _recruitable = 1, _skillId = { 20176, 20177, 20178, 20179, 20180, 20181, 20182, 20183, 20184 }, _skin = { 0 }, _star = 8
				}
				Data._monsterInfo[12381] = {
					_atk = { 3500 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58242, _category = 4, _cost = 0, _descSid = 58241, _guideSid = 0, _hp = { 3000 }, _id = 12381, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58240, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "princesslabrynthofthesilvercastle", _quality = 5, _recruitable = 1, _skillId = { 20185, 20186, 20187, 20188, 20189, 20190, 20191, 20192, 20193 }, _skin = { 0 }, _star = 8
				}"""
    assert target_m in hp_text, "target_m not found in h5_patch.lua"
    hp_text = hp_text.replace(target_m, add_m, 1)

if "Data._skillInfo[20155]" not in hp_text:
    target_s = "Data._skillInfo[20154] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 58167, _effectVal = { 154 }, _id = 20154, _isIgnoreDefend = 0, _modes = { 32 }, _nameSid = 58166, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 4, _refCards = { 12376 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }"
    add_s = target_s + "\n"
    for skid, nsid, dsid, eval_id, modes_str, refc_str, refs_str, ign_def, qual in SKILLS_SPEC:
        modes_clean = modes_str.replace("[1]=", "").replace("[2]=", " ").replace("[3]=", " ").replace(",}", " }").replace("{", "{ ")
        refc_clean = refc_str.replace("[1]=", "").replace(",}", " }").replace("{", "{ ")
        refs_clean = refs_str.replace("[1]=", "").replace("[2]=", " ").replace("[3]=", " ").replace(",}", " }").replace("{", "{ ")
        add_s += f'\t\t\t\tData._skillInfo[{skid}] = {{ _against = {{ 0 }}, _avoidP2B = 0, _count = 1, _decrease = {{ 0, 0, 0, 0, 0 }}, _descSid = {dsid}, _effectVal = {{ {eval_id} }}, _id = {skid}, _isIgnoreDefend = {ign_def}, _modes = {modes_clean}, _nameSid = {nsid}, _needExtraGem = 0, _needNoGem = 0, _option = {{ 0 }}, _priority = 0, _quality = {qual}, _refCards = {refc_clean}, _refSkills = {refs_clean}, _removeMode = {{ 0 }}, _targetType = 0, _val = {{ 0 }} }}\n'
    add_s = add_s.rstrip("\n")
    assert target_s in hp_text, "target_s not found in h5_patch.lua"
    hp_text = hp_text.replace(target_s, add_s, 1)

if "[58168]" not in hp_text:
    target_str = '\t\t[58167] = "Kỹ năng mộ chủ động: Mỗi lượt chỉ 1 lần. Loại bỏ bản thân lá này, chọn và triệu hồi 1 Quái Vật 8 sao có từ khóa “Labrynth” trong mộ phe ta.",'
    add_str = target_str + "\n"
    for sid, _, text in STRINGS:
        escaped = text.replace('\\', '\\\\').replace('"', '\\"')
        add_str += f'\t\t[{sid}] = "{escaped}",\n'
    add_str = add_str.rstrip("\n")
    assert target_str in hp_text, "target_str not found in h5_patch.lua"
    hp_text = hp_text.replace(target_str, add_str, 1)

with open(hp_path, "w", encoding="utf-8") as f:
    f.write(hp_text)
print("[OK] Updated web/src/h5_patch.lua")
