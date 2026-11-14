import sys
sys.stdout.reconfigure(encoding='utf-8')

STRINGS = [
    (58110, "SID_MONSTER_NAME_12371", "LABRYNTH COOCLOCK"),
    (58111, "SID_MONSTER_DESC_12371", "[Quỷ / Hiệu Ứng / Điều Chỉnh / UR]"),
    (58112, "SID_MONSTER_BRIEFNAME_12371", "LABRYNTH COOCLOCK"),
    (58113, "SID_SKILL_NAME_20135", "Báo Thức Mê Cung"),
    (58114, "SID_SKILL_DESC_20135", "Kỹ năng tay chủ động. Mỗi lượt chỉ 1 lần. Khi trên sân phe ta có quái vật có từ khóa “Labrynth” Hi sinh bản thân bài này; lấy 1 bài Phép/Bẫy trên tay đối thủ vào bài trên tay phe ta."),
    (58115, "SID_SKILL_NAME_20136", "Đồng Hồ Hồi Quy"),
    (58116, "SID_SKILL_DESC_20136", "Khi lá này nằm trong mộ: Mỗi lượt chỉ 1 lần. Khi phe ta kích hoạt hiệu ứng bài có từ khóa “Labrynth” sẽ kích hoạt; đưa bản thân lá này vào tay."),

    (58117, "SID_MONSTER_NAME_12372", "LABRYNTH STOVIE TORBIE"),
    (58118, "SID_MONSTER_DESC_12372", "[Quỷ / Hiệu Ứng / UR]"),
    (58119, "SID_MONSTER_BRIEFNAME_12372", "LABRYNTH STOVIE TORBIE"),
    (58120, "SID_SKILL_NAME_20137", "Lò Sưởi Mê Cung"),
    (58121, "SID_SKILL_DESC_20137", "Kỹ năng tay/sân chủ động. Mỗi lượt chỉ 1 lần. Hi sinh bản thân bài này;Chọn 1 lá bài trên tay phe ta đưa vào mộ. Sau đó lấy 1 lá bài Phép/Bẫy có từ khóa “Labrynth” từ bộ bài phe ta vào tay."),
    (58122, "SID_SKILL_NAME_20138", "Thiêu Rụi Chiến Lợi"),
    (58123, "SID_SKILL_DESC_20138", "Mỗi lượt chỉ 1 lần. Khi bài này nằm trong mộ, khi đối thủ lấy bài vào tay, sẽ loại bỏ bản thân bài này và bài đối thủ vừa lấy được."),
    (58124, "SID_SKILL_NAME_20139", "Tro Tàn Trỗi Dậy"),
    (58125, "SID_SKILL_DESC_20139", "Khi lá này nằm trong mộ: Mỗi lượt chỉ 1 lần. Khi phe ta kích hoạt hiệu ứng bài có từ khóa “Labrynth” sẽ kích hoạt; Triệu hồi đặc biệt lá này lên sân phe ta."),

    (58126, "SID_MONSTER_NAME_12373", "LABRYNTH CHANDRAGLIER"),
    (58127, "SID_MONSTER_DESC_12373", "[Quỷ / Hiệu Ứng / UR]"),
    (58128, "SID_MONSTER_BRIEFNAME_12373", "LABRYNTH CHANDRAGLIER"),
    (58129, "SID_SKILL_NAME_20140", "Đèn Chùm Mê Cung"),
    (58130, "SID_SKILL_DESC_20140", "Kỹ năng tay/sân chủ động. Mỗi lượt chỉ 1 lần. Hi sinh bản thân bài này;Chọn 1 lá bài trên tay phe ta đưa vào mộ. Sau đó lấy 1 lá bài Bẫy từ bộ bài phe ta vào tay."),
    (58131, "SID_SKILL_NAME_20141", "Ánh Nến Phản Phép"),
    (58132, "SID_SKILL_DESC_20141", "Mỗi lượt chỉ 1 lần. Khi bài này nằm trong mộ, khi trong mộ phe ta có lá Bẫy từ khóa “Labrynth”, khi đối thủ dùng bài Phép sẽ kích hoạt. Loại bỏ bản thân bài này, vô hiệu hóa và phá hủy bài của đối thủ."),
    (58133, "SID_SKILL_NAME_20142", "Thắp Lại Ánh Đèn"),
    (58134, "SID_SKILL_DESC_20142", "Khi lá này nằm trong mộ: Mỗi lượt chỉ 1 lần. Khi phe ta kích hoạt hiệu ứng bài có từ khóa “Labrynth” sẽ kích hoạt; đưa bản thân lá này vào tay."),

    (58135, "SID_MONSTER_NAME_12374", "ARIANNA THE LABRYNTH SERVANT"),
    (58136, "SID_MONSTER_DESC_12374", "[Quỷ / Hiệu Ứng / UR]"),
    (58137, "SID_MONSTER_BRIEFNAME_12374", "ARIANNA THE LABRYNTH SERVANT"),
    (58138, "SID_SKILL_NAME_20143", "Hầu Gái Dẫn Lối"),
    (58139, "SID_SKILL_DESC_20143", "Kỹ năng tay chủ động: Mỗi lượt chỉ 1 lần. Hi sinh bản thân lá này lấy 1 lá quái “Labrynth” 4 sao trở xuống từ bộ bài phe ta vào tay"),
    (58140, "SID_SKILL_NAME_20144", "Tiếp Đón Mê Cung"),
    (58141, "SID_SKILL_DESC_20144", "Chủ động: Mỗi lượt chỉ 1 lần. Lấy 1 bài có từ khóa \"Labrynth” từ bộ bài phe ta vào tay."),
    (58142, "SID_SKILL_NAME_20145", "Triệu Tập Hầu Gái"),
    (58143, "SID_SKILL_DESC_20145", "Kỹ năng mộ chủ động: Mỗi lượt chỉ 1 lần. Chọn và Triệu Hồi Đặc Biệt 1 quái 4 sao trở xuống, có từ khóa \"Labrynth” từ mộ phe ta."),

    (58144, "SID_MONSTER_NAME_12375", "ARIANE THE LABRYNTH SERVANT"),
    (58145, "SID_MONSTER_DESC_12375", "[Quỷ / Hiệu Ứng / UR]"),
    (58146, "SID_MONSTER_BRIEFNAME_12375", "ARIANE THE LABRYNTH SERVANT"),
    (58147, "SID_SKILL_NAME_20146", "Bẫy Ngầm Hiện Thân"),
    (58148, "SID_SKILL_DESC_20146", "Kỹ năng tay chủ động: mỗi lượt chỉ 1 lần. Hi sinh 1 lá bẫy trên tay phe ta; Triệu Hồi Đặc Biệt bản thân bài này từ trên tay."),
    (58149, "SID_SKILL_NAME_20147", "Phân Thân Ariane"),
    (58150, "SID_SKILL_DESC_20147", "Chủ động: Mỗi lượt chỉ 1 lần. Chọn và triệu hồi lá bài “ARIANE THE LABRYNTH SERVANT” từ mộ hoặc bộ bài phe ta."),
    (58151, "SID_SKILL_NAME_20148", "Thu Hồi Mê Cung"),
    (58152, "SID_SKILL_DESC_20148", "Kỹ năng mộ chủ động: Mỗi lượt chỉ 1 lần. Loại bỏ 1 lá bài trong mộ phe ta, chọn và lấy 1 quái có từ khóa “Labrynth” trong mộ bài loại bỏ phe ta về bộ bài."),

    (58153, "SID_MONSTER_NAME_12376", "LABRYNTH KNIGHT"),
    (58154, "SID_MONSTER_DESC_12376", "[Chiến Binh / Hiệu Ứng / UR]"),
    (58155, "SID_MONSTER_BRIEFNAME_12376", "LABRYNTH KNIGHT"),
    (58156, "SID_SKILL_NAME_20149", "Kỵ Sĩ Hộ Vệ"),
    (58157, "SID_SKILL_DESC_20149", "Kỹ năng tay chủ động: Mỗi lượt chỉ 1 lần. Khi trên sân phe ta có quái 8 sao có từ khóa “Labrynth”; Triệu Hồi Đặc Biệt bản thân bài này từ trên tay."),
    (58158, "SID_SKILL_NAME_20150", "Khiên Chắn Mê Cung"),
    (58159, "SID_SKILL_DESC_20150", "Khi có mặt; quái 8 sao có từ khóa “Labrynth” phe ta khi lên sân sẽ không bị ảnh hưởng bởi hiệu ứng bài Phép/Bẫy của đối thủ"),
    (58160, "SID_SKILL_NAME_20151", "Chiến Ý Mê Cung"),
    (58161, "SID_SKILL_DESC_20151", "Khi lên sân, bài này tăng tấn công bằng tổng số quái có từ khóa \"Labrynth” đang có mặt trong mộ mộ bài loại bỏ phe ta x300 (bỏ qua \"Tường Chấn Quái\")."),
    (58162, "SID_SKILL_NAME_20152", "Song Kiếm Liên Trảm"),
    (58163, "SID_SKILL_DESC_20152", "Chủ động: Bản thân chưa hành động có thể dùng. Chỉ lượt này; nhận được \"Liên Trảm\", sau khi kích hoạt, các quái vật khác ở phe ta không thể tấn công ngoại trừ Quái Vật 8 sao có từ khoá “Labrynth”."),
    (58164, "SID_SKILL_NAME_20153", "Uy Áp Kỵ Sĩ"),
    (58165, "SID_SKILL_DESC_20153", "Khi tấn công, Quái Vật trên sân; tay hoặc mộ của đối thủ không thể kích hoạt hiệu ứng quái vật và đối thủ không thể kích hoạt hiệu ứng phép thuật hoặc bẫy trên sân."),
    (58166, "SID_SKILL_NAME_20154", "Thệ Ước Trung Thành"),
    (58167, "SID_SKILL_DESC_20154", "Kỹ năng mộ chủ động: Mỗi lượt chỉ 1 lần. Loại bỏ bản thân lá này, chọn và triệu hồi 1 Quái Vật 8 sao có từ khóa “Labrynth” trong mộ phe ta."),
]

# 1. Update web/res/lan.lcres/extend.lan
lan_path = r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
with open(lan_path, "r", encoding="utf-8") as f:
    lines = f.read().splitlines()

if len(lines) == 58109:
    for sid, _, text in STRINGS:
        lines.append(text)
    with open(lan_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    print(f"[OK] Appended {len(STRINGS)} strings to extend.lan (total lines: {len(lines)})")
else:
    print(f"[INFO] extend.lan has {len(lines)} lines, updating 58110..58167 in place if needed")
    while len(lines) < 58167:
        lines.append("")
    for sid, _, text in STRINGS:
        lines[sid - 1] = text
    with open(lan_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")

# 2. Update web/src/StringEnums.lua
se_path = r"D:\yugitauapk\web\src\StringEnums.lua"
with open(se_path, "r", encoding="utf-8") as f:
    se_text = f.read()

if "SID_MONSTER_NAME_12371" not in se_text:
    enum_add = "\n"
    for sid, ename, _ in STRINGS:
        enum_add += f"\t{ename} = {sid},\n"
    se_text = se_text.replace("\tSID_SKILL_DESC_20134 = 58109,\n}", "\tSID_SKILL_DESC_20134 = 58109,\n" + enum_add + "}")
    with open(se_path, "w", encoding="utf-8") as f:
        f.write(se_text)
    print("[OK] Updated StringEnums.lua")

# 3. Update web/data/monster.lua
m_path = r"D:\yugitauapk\web\data\monster.lua"
with open(m_path, "r", encoding="utf-8") as f:
    m_text = f.read()

if "[12371]=" not in m_text:
    new_monsters_lua = """  [12371]={["_atk"]={[1]=0,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58112,["_category"]=4,["_cost"]=0,["_descSid"]=58111,["_guideSid"]=0,["_hp"]={[1]=0,},["_id"]=12371,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58110,["_nature"]=2,["_option"]=130,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="labrynthcooclock",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20135,[2]=20136,},["_skin"]={[1]=0,},["_star"]=1,["_syncComponent"]={[1]={[1]=0,},},},
  [12372]={["_atk"]={[1]=0,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58119,["_category"]=4,["_cost"]=0,["_descSid"]=58118,["_guideSid"]=0,["_hp"]={[1]=2000,},["_id"]=12372,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58117,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="labrynthstovietorbie",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20137,[2]=20138,[3]=20139,},["_skin"]={[1]=0,},["_star"]=2,},
  [12373]={["_atk"]={[1]=1500,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58128,["_category"]=4,["_cost"]=0,["_descSid"]=58127,["_guideSid"]=0,["_hp"]={[1]=0,},["_id"]=12373,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58126,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="labrynthchandraglier",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20140,[2]=20141,[3]=20142,},["_skin"]={[1]=0,},["_star"]=3,},
  [12374]={["_atk"]={[1]=1600,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58137,["_category"]=4,["_cost"]=0,["_descSid"]=58136,["_guideSid"]=0,["_hp"]={[1]=2100,},["_id"]=12374,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58135,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="ariannathelabrynthservant",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20143,[2]=20144,[3]=20145,},["_skin"]={[1]=0,},["_star"]=4,},
  [12375]={["_atk"]={[1]=1800,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58146,["_category"]=4,["_cost"]=0,["_descSid"]=58145,["_guideSid"]=0,["_hp"]={[1]=1100,},["_id"]=12375,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58144,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="arianethelabrynthservant",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20146,[2]=20147,[3]=20148,},["_skin"]={[1]=0,},["_star"]=4,},
  [12376]={["_atk"]={[1]=2300,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58155,["_category"]=6,["_cost"]=0,["_descSid"]=58154,["_guideSid"]=0,["_hp"]={[1]=1500,},["_id"]=12376,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=308,["_maxCount"]=3,["_nameSid"]=58153,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="labrynthknight",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20149,[2]=20150,[3]=20151,[4]=20152,[5]=20153,[6]=20154,},["_skin"]={[1]=0,},["_star"]=5,},
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
    (20135, 58113, 58114, 135, "{[1]=34,}", "{[1]=12371,}", "{[1]=0,}", 0),
    (20136, 58115, 58116, 136, "{[1]=91,}", "{[1]=12371,}", "{[1]=0,}", 0),
    (20137, 58120, 58121, 137, "{[1]=34,[2]=31,}", "{[1]=12372,}", "{[1]=0,}", 0),
    (20138, 58122, 58123, 138, "{[1]=91,}", "{[1]=12372,}", "{[1]=0,}", 0),
    (20139, 58124, 58125, 139, "{[1]=91,}", "{[1]=12372,}", "{[1]=0,}", 0),
    (20140, 58129, 58130, 140, "{[1]=34,[2]=31,}", "{[1]=12373,}", "{[1]=0,}", 0),
    (20141, 58131, 58132, 141, "{[1]=91,}", "{[1]=12373,}", "{[1]=0,}", 0),
    (20142, 58133, 58134, 142, "{[1]=91,}", "{[1]=12373,}", "{[1]=0,}", 0),
    (20143, 58138, 58139, 143, "{[1]=34,}", "{[1]=12374,}", "{[1]=0,}", 0),
    (20144, 58140, 58141, 144, "{[1]=31,}", "{[1]=12374,}", "{[1]=0,}", 0),
    (20145, 58142, 58143, 145, "{[1]=32,}", "{[1]=12374,}", "{[1]=0,}", 0),
    (20146, 58147, 58148, 146, "{[1]=34,}", "{[1]=12375,}", "{[1]=0,}", 0),
    (20147, 58149, 58150, 147, "{[1]=31,}", "{[1]=12375,}", "{[1]=0,}", 0),
    (20148, 58151, 58152, 148, "{[1]=32,}", "{[1]=12375,}", "{[1]=0,}", 0),
    (20149, 58156, 58157, 149, "{[1]=34,}", "{[1]=12376,}", "{[1]=0,}", 0),
    (20150, 58158, 58159, 150, "{[1]=1,}", "{[1]=12376,}", "{[1]=12009,[2]=12010,}", 0),
    (20151, 58160, 58161, 151, "{[1]=2,}", "{[1]=12376,}", "{[1]=0,}", 1),
    (20152, 58162, 58163, 152, "{[1]=31,}", "{[1]=12376,}", "{[1]=2001,}", 0),
    (20153, 58164, 58165, 153, "{[1]=11,}", "{[1]=12376,}", "{[1]=1056,}", 0),
    (20154, 58166, 58167, 154, "{[1]=32,}", "{[1]=12376,}", "{[1]=0,}", 0),
]

if "[20135]=" not in s_text:
    new_skills_lua = ""
    for skid, nsid, dsid, eval_id, modes_str, refc_str, refs_str, ign_def in SKILLS_SPEC:
        new_skills_lua += f'[{skid}]={{["_against"]={{[1]=0,}},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={{[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,}},["_descSid"]={dsid},["_effectVal"]={{[1]={eval_id},}},["_id"]={skid},["_isIgnoreDefend"]={ign_def},["_modes"]={modes_str},["_nameSid"]={nsid},["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={{[1]=0,}},["_priority"]=0,["_quality"]=4,["_refCards"]={refc_str},["_refSkills"]={refs_str},["_removeMode"]={{[1]=0,}},["_targetType"]=0,["_val"]={{[1]=0,}},}},'
    idx = s_text.rfind("}")
    s_text = s_text[:idx] + new_skills_lua + "\n}\n"
    with open(s_path, "w", encoding="utf-8") as f:
        f.write(s_text)
    print("[OK] Updated web/data/skill.lua")

# 5. Update web/src/h5_patch.lua
hp_path = r"D:\yugitauapk\web\src\h5_patch.lua"
with open(hp_path, "r", encoding="utf-8") as f:
    hp_text = f.read()

if "Data._monsterInfo[12371]" not in hp_text:
    target_m = """				Data._monsterInfo[12370] = {
					_atk = { 0 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58101, _category = 6, _cost = 0, _descSid = 58100, _guideSid = 0, _hp = { 500 }, _id = 12370, _isHide = 0, _joinResult = { 0 }, _keyword = 307, _maxCount = 3, _nameSid = 58099, _nature = 3, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "shinanva", _quality = 4, _recruitable = 1, _skillId = { 20131, 20132, 20133, 20134 }, _skin = { 0 }, _star = 2
				}"""
    add_m = target_m + """
				Data._monsterInfo[12371] = {
					_atk = { 0 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58112, _category = 4, _cost = 0, _descSid = 58111, _guideSid = 0, _hp = { 0 }, _id = 12371, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58110, _nature = 2, _option = 130, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "labrynthcooclock", _quality = 4, _recruitable = 1, _skillId = { 20135, 20136 }, _skin = { 0 }, _star = 1, _syncComponent = { { 0 } }
				}
				Data._monsterInfo[12372] = {
					_atk = { 0 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58119, _category = 4, _cost = 0, _descSid = 58118, _guideSid = 0, _hp = { 2000 }, _id = 12372, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58117, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "labrynthstovietorbie", _quality = 4, _recruitable = 1, _skillId = { 20137, 20138, 20139 }, _skin = { 0 }, _star = 2
				}
				Data._monsterInfo[12373] = {
					_atk = { 1500 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58128, _category = 4, _cost = 0, _descSid = 58127, _guideSid = 0, _hp = { 0 }, _id = 12373, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58126, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "labrynthchandraglier", _quality = 4, _recruitable = 1, _skillId = { 20140, 20141, 20142 }, _skin = { 0 }, _star = 3
				}
				Data._monsterInfo[12374] = {
					_atk = { 1600 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58137, _category = 4, _cost = 0, _descSid = 58136, _guideSid = 0, _hp = { 2100 }, _id = 12374, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58135, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "ariannathelabrynthservant", _quality = 4, _recruitable = 1, _skillId = { 20143, 20144, 20145 }, _skin = { 0 }, _star = 4
				}
				Data._monsterInfo[12375] = {
					_atk = { 1800 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58146, _category = 4, _cost = 0, _descSid = 58145, _guideSid = 0, _hp = { 1100 }, _id = 12375, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58144, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "arianethelabrynthservant", _quality = 4, _recruitable = 1, _skillId = { 20146, 20147, 20148 }, _skin = { 0 }, _star = 4
				}
				Data._monsterInfo[12376] = {
					_atk = { 2300 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58155, _category = 6, _cost = 0, _descSid = 58154, _guideSid = 0, _hp = { 1500 }, _id = 12376, _isHide = 0, _joinResult = { 0 }, _keyword = 308, _maxCount = 3, _nameSid = 58153, _nature = 2, _option = 2, _originId = 0, _packageId = { 0 }, _picId = 0, _py = "labrynthknight", _quality = 4, _recruitable = 1, _skillId = { 20149, 20150, 20151, 20152, 20153, 20154 }, _skin = { 0 }, _star = 5
				}"""
    assert target_m in hp_text, "target_m not found in h5_patch.lua"
    hp_text = hp_text.replace(target_m, add_m, 1)

if "Data._skillInfo[20135]" not in hp_text:
    target_s = 'Data._skillInfo[20134] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 58109, _effectVal = { 134 }, _id = 20134, _isIgnoreDefend = 0, _modes = { 32 }, _nameSid = 58108, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 4, _refCards = { 12370 }, _refSkills = { 12005 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }'
    add_s = target_s + "\n"
    for skid, nsid, dsid, eval_id, modes_str, refc_str, refs_str, ign_def in SKILLS_SPEC:
        modes_clean = modes_str.replace("[1]=", "").replace("[2]=", " ").replace(",}", " }").replace("{", "{ ")
        refc_clean = refc_str.replace("[1]=", "").replace(",}", " }").replace("{", "{ ")
        refs_clean = refs_str.replace("[1]=", "").replace("[2]=", " ").replace(",}", " }").replace("{", "{ ")
        add_s += f'\t\t\t\tData._skillInfo[{skid}] = {{ _against = {{ 0 }}, _avoidP2B = 0, _count = 1, _decrease = {{ 0, 0, 0, 0, 0 }}, _descSid = {dsid}, _effectVal = {{ {eval_id} }}, _id = {skid}, _isIgnoreDefend = {ign_def}, _modes = {modes_clean}, _nameSid = {nsid}, _needExtraGem = 0, _needNoGem = 0, _option = {{ 0 }}, _priority = 0, _quality = 4, _refCards = {refc_clean}, _refSkills = {refs_clean}, _removeMode = {{ 0 }}, _targetType = 0, _val = {{ 0 }} }}\n'
    add_s = add_s.rstrip("\n")
    assert target_s in hp_text, "target_s not found in h5_patch.lua"
    hp_text = hp_text.replace(target_s, add_s, 1)

if "[58110]" not in hp_text:
    target_str = '\t\t[58076] = "Kĩ năng chủ động: 1 lượt 1 lần, bỏ tất cả bài trên Tay về Bộ Bài; xáo trộn và rút lại lượng bài tương ứng về Tay.",'
    add_str = target_str + '\n\t\t[2239] = "Labrynth",\n'
    for sid, _, text in STRINGS:
        escaped = text.replace('\\', '\\\\').replace('"', '\\"')
        add_str += f'\t\t[{sid}] = "{escaped}",\n'
    add_str = add_str.rstrip("\n")
    assert target_str in hp_text, "target_str not found in h5_patch.lua"
    hp_text = hp_text.replace(target_str, add_str, 1)

with open(hp_path, "w", encoding="utf-8") as f:
    f.write(hp_text)
print("[OK] Updated web/src/h5_patch.lua")
