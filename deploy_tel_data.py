import os, sys, pymysql

sys.stdout.reconfigure(encoding='utf-8')
print("[*] Starting deploy_tel_data.py...")

# ==========================================
# 1. Update web/data/monster.lua
# ==========================================
monster_path = r'D:\yugitauapk\web\data\monster.lua'
with open(monster_path, 'r', encoding='utf-8') as f:
    mon_content = f.read()

monster_entry = '  [12385]={["_atk"]={[1]=1700,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58375,["_category"]=6,["_cost"]=0,["_descSid"]=58374,["_guideSid"]=0,["_hp"]={[1]=100,},["_id"]=12385,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=303,["_maxCount"]=3,["_nameSid"]=58373,["_nature"]=1,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="telannas",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20232,[2]=20233,[3]=20234,},["_skin"]={[1]=0,},["_star"]=4,},\n'

if '[12385]=' not in mon_content:
    idx = mon_content.rfind('\n}')
    if idx != -1:
        mon_content = mon_content[:idx] + '\n' + monster_entry + mon_content[idx:]
        with open(monster_path, 'w', encoding='utf-8') as f:
            f.write(mon_content)
        print("[OK] monster.lua updated with 12385.")
    else:
        print("[ERR] closing brace not found in monster.lua")
else:
    print("[SKIP] 12385 already in monster.lua")

# ==========================================
# 2. Update web/data/skill.lua
# ==========================================
skill_path = r'D:\yugitauapk\web\data\skill.lua'
with open(skill_path, 'r', encoding='utf-8') as f:
    sk_content = f.read()

skill_entries = '''  [20232]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=3,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58377,["_effectVal"]={[1]=0,},["_id"]=20232,["_isIgnoreDefend"]=0,["_modes"]={[1]=31,},["_nameSid"]=58376,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=12385,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
  [20233]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58379,["_effectVal"]={[1]=0,},["_id"]=20233,["_isIgnoreDefend"]=0,["_modes"]={[1]=31,},["_nameSid"]=58378,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=12385,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
  [20234]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58381,["_effectVal"]={[1]=0,},["_id"]=20234,["_isIgnoreDefend"]=0,["_modes"]={[1]=2,},["_nameSid"]=58380,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=12385,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
'''

if '[20232]=' not in sk_content:
    idx = sk_content.rfind('\n}')
    if idx != -1:
        sk_content = sk_content[:idx] + '\n' + skill_entries + sk_content[idx:]
        with open(skill_path, 'w', encoding='utf-8') as f:
            f.write(sk_content)
        print("[OK] skill.lua updated with 20232, 20233, 20234.")
    else:
        print("[ERR] closing brace not found in skill.lua")
else:
    print("[SKIP] 20232 already in skill.lua")

# ==========================================
# 3. Update web/src/h5_patch.lua
# ==========================================
patch_path = r'D:\yugitauapk\web\src\h5_patch.lua'
with open(patch_path, 'r', encoding='utf-8') as f:
    patch = f.read()

# 3a. Add skillInfo in h5_patch
sk_patch_target = '''\t\t\t\tData._skillInfo[20231] = {
\t\t\t\t\t_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
\t\t\t\t\t_descSid = 58372, _effectVal = { 0 }, _targetType = 0, _id = 20231, _isIgnoreDefend = 0,
\t\t\t\t\t_modes = { 31 }, _nameSid = 58371, _needExtraGem = 0, _needNoGem = 0,
\t\t\t\t\t_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 12384 },
\t\t\t\t\t_refSkills = { 0 }, _removeMode = { 0 }, _val = { 0 }
\t\t\t\t}'''

sk_patch_addition = '''\n\t\t\t\tData._skillInfo[20232] = {
\t\t\t\t\t_against = { 0 }, _avoidP2B = 0, _count = 3, _decrease = { 0, 0, 0, 0, 0 },
\t\t\t\t\t_descSid = 58377, _effectVal = { 0 }, _targetType = 0, _id = 20232, _isIgnoreDefend = 0,
\t\t\t\t\t_modes = { 31 }, _nameSid = 58376, _needExtraGem = 0, _needNoGem = 0,
\t\t\t\t\t_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 12385 },
\t\t\t\t\t_refSkills = { 0 }, _removeMode = { 0 }, _val = { 0 }
\t\t\t\t}
\t\t\t\tData._skillInfo[20233] = {
\t\t\t\t\t_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
\t\t\t\t\t_descSid = 58379, _effectVal = { 0 }, _targetType = 0, _id = 20233, _isIgnoreDefend = 0,
\t\t\t\t\t_modes = { 31 }, _nameSid = 58378, _needExtraGem = 0, _needNoGem = 0,
\t\t\t\t\t_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 12385 },
\t\t\t\t\t_refSkills = { 0 }, _removeMode = { 0 }, _val = { 0 }
\t\t\t\t}
\t\t\t\tData._skillInfo[20234] = {
\t\t\t\t\t_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
\t\t\t\t\t_descSid = 58381, _effectVal = { 0 }, _targetType = 0, _id = 20234, _isIgnoreDefend = 0,
\t\t\t\t\t_modes = { 2 }, _nameSid = 58380, _needExtraGem = 0, _needNoGem = 0,
\t\t\t\t\t_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 12385 },
\t\t\t\t\t_refSkills = { 0 }, _removeMode = { 0 }, _val = { 0 }
\t\t\t\t}'''

if 'Data._skillInfo[20232]' not in patch:
    if sk_patch_target in patch:
        patch = patch.replace(sk_patch_target, sk_patch_target + sk_patch_addition, 1)
        print("[OK] Added skillInfo 20232, 20233, 20234 to h5_patch.lua")
    else:
        print("[WARN] sk_patch_target not found in h5_patch.lua")

# 3b. Add monsterInfo in h5_patch
mon_patch_target = '''\t\t\tData._monsterInfo[12384] = {
\t\t\t\t_atk = { 3000 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58368, _category = 6,
\t\t\t\t_cost = 0, _descSid = 58367, _guideSid = 0, _hp = { 2500 }, _id = 12384, _isHide = 0,
\t\t\t\t_joinResult = { 0 }, _keyword = 303, _maxCount = 3, _nameSid = 58366, _nature = 1, _option = 2,
\t\t\t\t_originId = 0, _packageId = { 0 }, _picId = 0, _py = "airithunguyen", _quality = 4, _recruitable = 1,
\t\t\t\t_skillId = { 20230, 20231, 1010, 1008, 2797 }, _skin = { 0 }, _star = 8
\t\t\t}'''

mon_patch_addition = '''\n\t\t\tData._monsterInfo[12385] = {
\t\t\t\t_atk = { 1700 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58375, _category = 6,
\t\t\t\t_cost = 0, _descSid = 58374, _guideSid = 0, _hp = { 100 }, _id = 12385, _isHide = 0,
\t\t\t\t_joinResult = { 0 }, _keyword = 303, _maxCount = 3, _nameSid = 58373, _nature = 1, _option = 2,
\t\t\t\t_originId = 0, _packageId = { 0 }, _picId = 0, _py = "telannas", _quality = 4, _recruitable = 1,
\t\t\t\t_skillId = { 20232, 20233, 20234 }, _skin = { 0 }, _star = 4
\t\t\t}'''

if 'Data._monsterInfo[12385]' not in patch:
    if mon_patch_target in patch:
        patch = patch.replace(mon_patch_target, mon_patch_target + mon_patch_addition, 1)
        print("[OK] Added monsterInfo 12385 to h5_patch.lua")
    else:
        print("[WARN] mon_patch_target not found in h5_patch.lua")

# 3c. Add CARD_NAME_OVERRIDES in h5_patch
lan_patch_target = '[58372] = "Kĩ năng chủ động: 1 lượt 1 lần, nhận 1080 Liên Trảm.",'
lan_patch_addition = '''\n\t\t-- tel'annas - Thứ nguyên vệ thần (12385)
\t\t[58373] = "tel'annas - Thứ nguyên vệ thần",
\t\t[58374] = "[Chiến Binh / Hiệu Ứng / UR]\\nThuộc tính: Quang | 4 Sao\\nTừ khóa: \\"liqi\\"\\nATK: 1700 | DEF: 100",
\t\t[58375] = "tel'annas - Thứ nguyên vệ thần",
\t\t[58376] = "Thần Tiễn Triệu Tập",
\t\t[58377] = "Kĩ năng chủ động: 1 lượt tối đa 3 lần, khi được triệu hồi lên sân, chọn 1 quái có từ khóa \\"liqi\\" 6 sao trở xuống từ trên tay triệu hồi đặc biệt lên sân.",
\t\t[58378] = "Tiếp Tế Tinh Linh",
\t\t[58379] = "Kĩ năng chủ động: 1 lượt 1 lần, chọn 1 bài trên tay đưa vào mộ, chọn lấy 1 quái 6 sao trở xuống từ bộ bài có từ khóa \\"liqi\\" lấy lên tay.",
\t\t[58380] = "Cộng Hưởng Sinh Mệnh",
\t\t[58381] = "Khi lên sân, tăng lp phe ta bằng số bài có từ khóa \\"liqi\\" trong mộ x100, đối phương cũng đồng thời nhận số lp tương ứng x2.",'''

if '[58373]' not in patch:
    if lan_patch_target in patch:
        patch = patch.replace(lan_patch_target, lan_patch_target + lan_patch_addition, 1)
        print("[OK] Added language overrides 58373..58381 to h5_patch.lua")
    else:
        print("[WARN] lan_patch_target not found in h5_patch.lua")

with open(patch_path, 'w', encoding='utf-8') as f:
    f.write(patch)

# ==========================================
# 4. Update web/src/Data.lua
# ==========================================
data_path = r'D:\yugitauapk\web\src\Data.lua'
with open(data_path, 'r', encoding='utf-8') as f:
    data_content = f.read()

data_target = 'if arg_13_0 == 20230 or arg_13_0 == 20231 then'
data_replacement = 'if (arg_13_0 >= 20230 and arg_13_0 <= 20234) then'

if 'arg_13_0 <= 20234' not in data_content:
    if data_target in data_content:
        data_content = data_content.replace(data_target, data_replacement, 1)
        with open(data_path, 'w', encoding='utf-8') as f:
            f.write(data_content)
        print("[OK] Data.lua updated with getSkillType for 20230..20234.")
    else:
        print("[WARN] data_target not found in Data.lua")
else:
    print("[SKIP] 20234 already in Data.lua")

# ==========================================
# 5. Update web/src/StringEnums.lua
# ==========================================
se_path = r'D:\yugitauapk\web\src\StringEnums.lua'
with open(se_path, 'r', encoding='utf-8') as f:
    se_content = f.read()

se_target = '''\tSID_SKILL_NAME_20231 = 58371,
\tSID_SKILL_DESC_20231 = 58372,
}'''

se_replacement = '''\tSID_SKILL_NAME_20231 = 58371,
\tSID_SKILL_DESC_20231 = 58372,
\tSID_MONSTER_NAME_12385 = 58373,
\tSID_MONSTER_DESC_12385 = 58374,
\tSID_MONSTER_BRIEFNAME_12385 = 58375,
\tSID_SKILL_NAME_20232 = 58376,
\tSID_SKILL_DESC_20232 = 58377,
\tSID_SKILL_NAME_20233 = 58378,
\tSID_SKILL_DESC_20233 = 58379,
\tSID_SKILL_NAME_20234 = 58380,
\tSID_SKILL_DESC_20234 = 58381,
}'''

if 'SID_MONSTER_NAME_12385' not in se_content:
    if se_target in se_content:
        se_content = se_content.replace(se_target, se_replacement, 1)
        with open(se_path, 'w', encoding='utf-8') as f:
            f.write(se_content)
        print("[OK] StringEnums.lua updated with 12385, 20232..20234.")
    else:
        print("[WARN] se_target not found in StringEnums.lua")
else:
    print("[SKIP] 12385 already in StringEnums.lua")

# ==========================================
# 6. Update web/src/BattleInitiativeSkillsDialog.lua
# ==========================================
bisd_path = r'D:\yugitauapk\web\src\BattleInitiativeSkillsDialog.lua'
with open(bisd_path, 'r', encoding='utf-8') as f:
    bisd_content = f.read()

bisd_target = '[20231] = "Long Kiếm Liên Trảm",'
bisd_addition = '\n\t\t[20232] = "Thần Tiễn Triệu Tập",\n\t\t[20233] = "Tiếp Tế Tinh Linh",'

if '[20232]' not in bisd_content:
    if bisd_target in bisd_content:
        bisd_content = bisd_content.replace(bisd_target, bisd_target + bisd_addition, 1)
        with open(bisd_path, 'w', encoding='utf-8') as f:
            f.write(bisd_content)
        print("[OK] BattleInitiativeSkillsDialog.lua updated with 20232, 20233.")
    else:
        print("[WARN] bisd_target not found in BattleInitiativeSkillsDialog.lua")
else:
    print("[SKIP] 20232 already in BattleInitiativeSkillsDialog.lua")

# ==========================================
# 7. Update web/src/ClientView.lua
# ==========================================
cv_path = r'D:\yugitauapk\web\src\ClientView.lua'
with open(cv_path, 'r', encoding='utf-8') as f:
    cv_content = f.read()

cv_target = '[12384] = true'
cv_addition = ', [12385] = true'

if '[12385] = true' not in cv_content:
    if cv_target in cv_content:
        cv_content = cv_content.replace(cv_target, cv_target + cv_addition, 1)
        with open(cv_path, 'w', encoding='utf-8') as f:
            f.write(cv_content)
        print("[OK] ClientView.lua updated with 12385.")
    else:
        print("[WARN] cv_target not found in ClientView.lua")
else:
    print("[SKIP] 12385 already in ClientView.lua")

# ==========================================
# 8. Update web/src/PlayerCard.lua
# ==========================================
pc_path = r'D:\yugitauapk\web\src\PlayerCard.lua'
with open(pc_path, 'r', encoding='utf-8') as f:
    pc_content = f.read()

pc_target = '12383, 12384'
pc_replacement = '12383, 12384, 12385'

if '12385' not in pc_content:
    if pc_target in pc_content:
        pc_content = pc_content.replace(pc_target, pc_replacement, 1)
        with open(pc_path, 'w', encoding='utf-8') as f:
            f.write(pc_content)
        print("[OK] PlayerCard.lua updated with 12385.")
    else:
        print("[WARN] pc_target not found in PlayerCard.lua")
else:
    print("[SKIP] 12385 already in PlayerCard.lua")

# ==========================================
# 9. Update MySQL card_monsters & user_cards
# ==========================================
try:
    conn = pymysql.connect(
        host='127.0.0.1',
        user='root',
        password='',
        database='yugioh_game',
        charset='utf8mb4',
        autocommit=True
    )
    with conn.cursor() as cur:
        # Insert / Update card_monsters
        sql_mon = """
        INSERT INTO card_monsters (id, name, category, attribute, keyword, stars, atk, def, quality, cost, max_count, pinyin, description, guide)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE
            name=VALUES(name),
            category=VALUES(category),
            attribute=VALUES(attribute),
            keyword=VALUES(keyword),
            stars=VALUES(stars),
            atk=VALUES(atk),
            def=VALUES(def),
            quality=VALUES(quality),
            cost=VALUES(cost),
            max_count=VALUES(max_count),
            pinyin=VALUES(pinyin),
            description=VALUES(description),
            guide=VALUES(guide)
        """
        cur.execute(sql_mon, (
            12385,
            "tel'annas - Thứ nguyên vệ thần",
            'Chiến Binh',
            'Quang',
            'liqi',
            4,
            1700,
            100,
            'UR',
            0,
            3,
            'telannas',
            '[Chiến Binh / Hiệu Ứng / UR]\nThuộc tính: Quang | 4 Sao\nTừ khóa: "liqi"\nATK: 1700 | DEF: 100',
            ''
        ))
        print("[OK] card_monsters table updated for 12385.")

        # Grant 3x to all accounts
        cur.execute("SELECT id FROM accounts")
        acc_ids = [r[0] for r in cur.fetchall()]
        batch_size = 500
        for i in range(0, len(acc_ids), batch_size):
            batch = acc_ids[i:i + batch_size]
            records = [(aid, 12385, 3) for aid in batch]
            cur.executemany("""
                INSERT INTO user_cards (account_id, card_id, count)
                VALUES (%s, %s, %s)
                ON DUPLICATE KEY UPDATE count = GREATEST(count, 3)
            """, records)
        print(f"[OK] Granted 3x card 12385 to {len(acc_ids)} accounts in user_cards.")
    conn.close()
except Exception as e:
    print(f"[ERR] MySQL error: {e}")

# ==========================================
# 10. Update Desktop text files
# ==========================================
# monster.txt
monster_txt_path = r'C:\Users\Nitro 5\OneDrive\Máy tính\monster.txt'
if os.path.exists(monster_txt_path):
    with open(monster_txt_path, 'r', encoding='utf-8') as f:
        mtxt = f.read()
    if '12385:' not in mtxt:
        if not mtxt.endswith('\n'):
            mtxt += '\n'
        mtxt += "12385: tel'annas - Thứ nguyên vệ thần\n"
        with open(monster_txt_path, 'w', encoding='utf-8') as f:
            f.write(mtxt)
        print("[OK] monster.txt updated.")
    else:
        print("[SKIP] 12385 already in monster.txt")

# skill.txt
skill_txt_path = r'C:\Users\Nitro 5\OneDrive\Máy tính\skill.txt'
if os.path.exists(skill_txt_path):
    with open(skill_txt_path, 'r', encoding='utf-8') as f:
        stxt = f.read()
    if '20232 Thần Tiễn Triệu Tập' not in stxt:
        addition = '''20232 Thần Tiễn Triệu Tập: Kĩ năng chủ động: 1 lượt tối đa 3 lần, khi được triệu hồi lên sân, chọn 1 quái có từ khóa "liqi" 6 sao trở xuống từ trên tay triệu hồi đặc biệt lên sân. [Thẻ: tel'annas - Thứ nguyên vệ thần (12385)]
20233 Tiếp Tế Tinh Linh: Kĩ năng chủ động: 1 lượt 1 lần, chọn 1 bài trên tay đưa vào mộ, chọn lấy 1 quái 6 sao trở xuống từ bộ bài có từ khóa "liqi" lấy lên tay. [Thẻ: tel'annas - Thứ nguyên vệ thần (12385)]
20234 Cộng Hưởng Sinh Mệnh: Khi lên sân, tăng lp phe ta bằng số bài có từ khóa "liqi" trong mộ x100, đối phương cũng đồng thời nhận số lp tương ứng x2. [Thẻ: tel'annas - Thứ nguyên vệ thần (12385)]
'''
        if not stxt.endswith('\n'):
            stxt += '\n'
        stxt += addition
        with open(skill_txt_path, 'w', encoding='utf-8') as f:
            f.write(stxt)
        print("[OK] skill.txt updated.")
    else:
        print("[SKIP] 20232 already in skill.txt")

# ==========================================
# 11. Update extend_lan.txt and extend.lan
# ==========================================
LAN_FILES = [
    r"D:\yugitauapk\extend_lan.txt",
    r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
]

new_lan_entries = {
    58373: "tel'annas - Thứ nguyên vệ thần\n",
    58374: '[Chiến Binh / Hiệu Ứng / UR]\\nThuộc tính: Quang | 4 Sao\\nTừ khóa: "liqi"\\nATK: 1700 | DEF: 100\n',
    58375: "tel'annas - Thứ nguyên vệ thần\n",
    58376: "Thần Tiễn Triệu Tập\n",
    58377: 'Kĩ năng chủ động: 1 lượt tối đa 3 lần, khi được triệu hồi lên sân, chọn 1 quái có từ khóa "liqi" 6 sao trở xuống từ trên tay triệu hồi đặc biệt lên sân.\n',
    58378: "Tiếp Tế Tinh Linh\n",
    58379: 'Kĩ năng chủ động: 1 lượt 1 lần, chọn 1 bài trên tay đưa vào mộ, chọn lấy 1 quái 6 sao trở xuống từ bộ bài có từ khóa "liqi" lấy lên tay.\n',
    58380: "Cộng Hưởng Sinh Mệnh\n",
    58381: 'Khi lên sân, tăng lp phe ta bằng số bài có từ khóa "liqi" trong mộ x100, đối phương cũng đồng thời nhận số lp tương ứng x2.\n'
}

for lp in LAN_FILES:
    if os.path.isfile(lp):
        with open(lp, 'r', encoding='utf-8') as f:
            llines = f.readlines()
        while len(llines) < 58381:
            llines.append('\n')
        for sid, text in new_lan_entries.items():
            llines[sid - 1] = text
        with open(lp, 'w', encoding='utf-8', newline='\n') as f:
            f.writelines(llines)
        print(f"[OK] Updated {lp}, now {len(llines)} lines.")

print("[*] Finished deploy_tel_data.py successfully!")
