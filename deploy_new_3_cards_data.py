# -*- coding: utf-8 -*-
import os, sys, pymysql

sys.stdout.reconfigure(encoding='utf-8')
print("[*] Starting deploy_new_3_cards_data.py...")

# ==========================================
# 1. Update web/data/monster.lua (12387, 12388) & fix 12386 category
# ==========================================
monster_path = r'D:\yugitauapk\web\data\monster.lua'
with open(monster_path, 'r', encoding='utf-8') as f:
    mon_content = f.read()

# Fix 12386 category from 2 to 1 (Spellcaster/Magician)
mon_content = mon_content.replace('[12386]={["_atk"]={[1]=0,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58384,["_category"]=2,',
                                  '[12386]={["_atk"]={[1]=0,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58384,["_category"]=1,')

monster_entries = '''  [12387]={["_atk"]={[1]=700,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58391,["_category"]=8,["_cost"]=0,["_descSid"]=58390,["_guideSid"]=0,["_hp"]={[1]=1000,},["_id"]=12387,["_isHide"]=0,["_joinResult"]={[1]=40782,},["_keyword"]=303,["_maxCount"]=3,["_nameSid"]=58389,["_nature"]=5,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="dolia",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20237,},["_skin"]={[1]=0,},["_star"]=3,},
  [12388]={["_atk"]={[1]=2200,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58396,["_category"]=1,["_cost"]=0,["_descSid"]=58395,["_guideSid"]=0,["_hp"]={[1]=1800,},["_id"]=12388,["_isHide"]=0,["_joinResult"]={[1]=40782,},["_keyword"]=303,["_maxCount"]=3,["_nameSid"]=58394,["_nature"]=1,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="heino",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20238,},["_skin"]={[1]=0,},["_star"]=6,},
'''

if '[12387]=' not in mon_content:
    idx = mon_content.rfind('\n}')
    if idx != -1:
        mon_content = mon_content[:idx] + '\n' + monster_entries + mon_content[idx:]
        with open(monster_path, 'w', encoding='utf-8') as f:
            f.write(mon_content)
        print("[OK] monster.lua updated with 12387, 12388.")
    else:
        print("[ERR] closing brace not found in monster.lua")
else:
    print("[SKIP] 12387 already in monster.lua")

# ==========================================
# 2. Update web/data/rare.lua (40782)
# ==========================================
rare_path = r'D:\yugitauapk\web\data\rare.lua'
with open(rare_path, 'r', encoding='utf-8') as f:
    rare_content = f.read()

rare_entry = '  [40782]={["_atk"]={[1]=2800,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58401,["_category"]=1,["_cost"]=0,["_descSid"]=58400,["_guideSid"]=0,["_hp"]={[1]=2600,},["_id"]=40782,["_isHide"]=0,["_joinComponent"]={[1]=12388,[2]=12387,},["_joinResult"]={[1]=0,},["_keyword"]=303,["_link"]={[1]=0,},["_linkAllCandidates"]="0.0",["_linkCandidate"]="0.0",["_linkCount"]="0.0",["_linkSelectedCandidates"]="0.0",["_maxCount"]=3,["_nameSid"]=58399,["_nature"]=1,["_option"]=6,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="heinoxdolia",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=13850,[2]=20239,[3]=20240,},["_skin"]={[1]=0,},["_star"]=8,["_syncComponent"]={[1]={[1]=0,},},},\n'

if '[40782]=' not in rare_content:
    idx = rare_content.rfind('\n}')
    if idx != -1:
        rare_content = rare_content[:idx] + '\n' + rare_entry + rare_content[idx:]
        with open(rare_path, 'w', encoding='utf-8') as f:
            f.write(rare_content)
        print("[OK] rare.lua updated with 40782.")
    else:
        print("[ERR] closing brace not found in rare.lua")
else:
    print("[SKIP] 40782 already in rare.lua")

# ==========================================
# 3. Update web/data/skill.lua (20237..20240)
# ==========================================
skill_path = r'D:\yugitauapk\web\data\skill.lua'
with open(skill_path, 'r', encoding='utf-8') as f:
    sk_content = f.read()

skill_entries = '''  [20237]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58393,["_effectVal"]={[1]=0,},["_id"]=20237,["_isIgnoreDefend"]=0,["_modes"]={[1]=41,[2]=91,},["_nameSid"]=58392,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=12387,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
  [20238]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58398,["_effectVal"]={[1]=0,},["_id"]=20238,["_isIgnoreDefend"]=0,["_modes"]={[1]=32,},["_nameSid"]=58397,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=12388,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
  [20239]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58403,["_effectVal"]={[1]=0,},["_id"]=20239,["_isIgnoreDefend"]=0,["_modes"]={[1]=31,},["_nameSid"]=58402,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=40782,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
  [20240]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58405,["_effectVal"]={[1]=0,},["_id"]=20240,["_isIgnoreDefend"]=0,["_modes"]={[1]=32,},["_nameSid"]=58404,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=40782,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
'''

if '[20237]=' not in sk_content:
    idx = sk_content.rfind('\n}')
    if idx != -1:
        sk_content = sk_content[:idx] + '\n' + skill_entries + sk_content[idx:]
        with open(skill_path, 'w', encoding='utf-8') as f:
            f.write(sk_content)
        print("[OK] skill.lua updated with 20237..20240.")
    else:
        print("[ERR] closing brace not found in skill.lua")
else:
    print("[SKIP] 20237 already in skill.lua")

# ==========================================
# 4. Update web/src/h5_patch.lua
# ==========================================
patch_path = r'D:\yugitauapk\web\src\h5_patch.lua'
with open(patch_path, 'r', encoding='utf-8') as f:
    patch = f.read()

# 4a. Add skillInfo in h5_patch
sk_patch_target = '''\t\t\t\tData._skillInfo[20236] = {
\t\t\t\t\t_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
\t\t\t\t\t_descSid = 58388, _effectVal = { 0 }, _targetType = 0, _id = 20236, _isIgnoreDefend = 0,
\t\t\t\t\t_modes = { 2 }, _nameSid = 58387, _needExtraGem = 0, _needNoGem = 0,
\t\t\t\t\t_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 12386 },
\t\t\t\t\t_refSkills = { 0 }, _removeMode = { 0 }, _val = { 0 }
\t\t\t\t}'''

sk_patch_addition = '''\n\t\t\t\tData._skillInfo[20237] = {
\t\t\t\t\t_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
\t\t\t\t\t_descSid = 58393, _effectVal = { 0 }, _targetType = 0, _id = 20237, _isIgnoreDefend = 0,
\t\t\t\t\t_modes = { 41, 91 }, _nameSid = 58392, _needExtraGem = 0, _needNoGem = 0,
\t\t\t\t\t_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 12387 },
\t\t\t\t\t_refSkills = { 0 }, _removeMode = { 0 }, _val = { 0 }
\t\t\t\t}
\t\t\t\tData._skillInfo[20238] = {
\t\t\t\t\t_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
\t\t\t\t\t_descSid = 58398, _effectVal = { 0 }, _targetType = 0, _id = 20238, _isIgnoreDefend = 0,
\t\t\t\t\t_modes = { 32 }, _nameSid = 58397, _needExtraGem = 0, _needNoGem = 0,
\t\t\t\t\t_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 12388 },
\t\t\t\t\t_refSkills = { 0 }, _removeMode = { 0 }, _val = { 0 }
\t\t\t\t}
\t\t\t\tData._skillInfo[20239] = {
\t\t\t\t\t_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
\t\t\t\t\t_descSid = 58403, _effectVal = { 0 }, _targetType = 0, _id = 20239, _isIgnoreDefend = 0,
\t\t\t\t\t_modes = { 31 }, _nameSid = 58402, _needExtraGem = 0, _needNoGem = 0,
\t\t\t\t\t_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 40782 },
\t\t\t\t\t_refSkills = { 0 }, _removeMode = { 0 }, _val = { 0 }
\t\t\t\t}
\t\t\t\tData._skillInfo[20240] = {
\t\t\t\t\t_against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 },
\t\t\t\t\t_descSid = 58405, _effectVal = { 0 }, _targetType = 0, _id = 20240, _isIgnoreDefend = 0,
\t\t\t\t\t_modes = { 32 }, _nameSid = 58404, _needExtraGem = 0, _needNoGem = 0,
\t\t\t\t\t_option = { 1 }, _priority = 0, _quality = 4, _refCards = { 40782 },
\t\t\t\t\t_refSkills = { 0 }, _removeMode = { 0 }, _val = { 0 }
\t\t\t\t}'''

if 'Data._skillInfo[20237]' not in patch:
    if sk_patch_target in patch:
        patch = patch.replace(sk_patch_target, sk_patch_target + sk_patch_addition, 1)
        print("[OK] Added skillInfo 20237..20240 to h5_patch.lua")

# 4b. Add monsterInfo (12387, 12388) in h5_patch
mon_patch_target = '''\t\t\tData._monsterInfo[12386] = {
\t\t\t\t_atk = { 0 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58384, _category = 2,
\t\t\t\t_cost = 0, _descSid = 58383, _guideSid = 0, _hp = { 1800 }, _id = 12386, _isHide = 0,
\t\t\t\t_joinResult = { 0 }, _keyword = 303, _maxCount = 3, _nameSid = 58382, _nature = 1, _option = 2,
\t\t\t\t_originId = 0, _packageId = { 0 }, _picId = 0, _py = "helen", _quality = 4, _recruitable = 1,
\t\t\t\t_skillId = { 20235, 20236 }, _skin = { 0 }, _star = 2
\t\t\t}'''

mon_patch_addition = '''\t\t\tData._monsterInfo[12386] = {
\t\t\t\t_atk = { 0 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58384, _category = 1,
\t\t\t\t_cost = 0, _descSid = 58383, _guideSid = 0, _hp = { 1800 }, _id = 12386, _isHide = 0,
\t\t\t\t_joinResult = { 0 }, _keyword = 303, _maxCount = 3, _nameSid = 58382, _nature = 1, _option = 2,
\t\t\t\t_originId = 0, _packageId = { 0 }, _picId = 0, _py = "helen", _quality = 4, _recruitable = 1,
\t\t\t\t_skillId = { 20235, 20236 }, _skin = { 0 }, _star = 2
\t\t\t}
\t\t\tData._monsterInfo[12387] = {
\t\t\t\t_atk = { 700 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58391, _category = 8,
\t\t\t\t_cost = 0, _descSid = 58390, _guideSid = 0, _hp = { 1000 }, _id = 12387, _isHide = 0,
\t\t\t\t_joinResult = { 40782 }, _keyword = 303, _maxCount = 3, _nameSid = 58389, _nature = 5, _option = 2,
\t\t\t\t_originId = 0, _packageId = { 0 }, _picId = 0, _py = "dolia", _quality = 4, _recruitable = 1,
\t\t\t\t_skillId = { 20237 }, _skin = { 0 }, _star = 3
\t\t\t}
\t\t\tData._monsterInfo[12388] = {
\t\t\t\t_atk = { 2200 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58396, _category = 1,
\t\t\t\t_cost = 0, _descSid = 58395, _guideSid = 0, _hp = { 1800 }, _id = 12388, _isHide = 0,
\t\t\t\t_joinResult = { 40782 }, _keyword = 303, _maxCount = 3, _nameSid = 58394, _nature = 1, _option = 2,
\t\t\t\t_originId = 0, _packageId = { 0 }, _picId = 0, _py = "heino", _quality = 4, _recruitable = 1,
\t\t\t\t_skillId = { 20238 }, _skin = { 0 }, _star = 6
\t\t\t}'''

if 'Data._monsterInfo[12387]' not in patch:
    if mon_patch_target in patch:
        patch = patch.replace(mon_patch_target, mon_patch_addition, 1)
        print("[OK] Added monsterInfo 12387, 12388 to h5_patch.lua")

# 4c. Add rareInfo (40782) in h5_patch
rare_patch_target = '''\t\t\tData._rareInfo[40781] = {
\t\t\t\t_atk = { 3000 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58331, _category = 6,
\t\t\t\t_cost = 0, _descSid = 58330, _guideSid = 0, _hp = { 1000 }, _id = 40781, _isHide = 0,
\t\t\t\t_joinComponent = { 8, 8, 8, 8 }, _joinResult = { 0 }, _keyword = 303, _link = { 0 },
\t\t\t\t_linkAllCandidates = "0.0", _linkCandidate = "0.0", _linkCount = "0.0", _linkSelectedCandidates = "0.0",
\t\t\t\t_maxCount = 3, _nameSid = 58329, _nature = 1, _option = 1026, _originId = 0, _packageId = { 0 },
\t\t\t\t_picId = 0, _py = "hayate", _quality = 5, _recruitable = 1,
\t\t\t\t_skillId = { 20219, 20220, 2797, 12006, 20221 }, _skin = { 0 }, _star = 8,
\t\t\t\t_syncComponent = { { 0 } }
\t\t\t}'''

rare_patch_addition = '''\n\t\t\tData._rareInfo[40782] = {
\t\t\t\t_atk = { 2800 }, _attackEffect = 2, _available = 1, _bgId = 0, _briefNameSid = 58401, _category = 1,
\t\t\t\t_cost = 0, _descSid = 58400, _guideSid = 0, _hp = { 2600 }, _id = 40782, _isHide = 0,
\t\t\t\t_joinComponent = { 12388, 12387 }, _joinResult = { 0 }, _keyword = 303, _link = { 0 },
\t\t\t\t_linkAllCandidates = "0.0", _linkCandidate = "0.0", _linkCount = "0.0", _linkSelectedCandidates = "0.0",
\t\t\t\t_maxCount = 3, _nameSid = 58399, _nature = 1, _option = 6, _originId = 0, _packageId = { 0 },
\t\t\t\t_picId = 0, _py = "heinoxdolia", _quality = 4, _recruitable = 1,
\t\t\t\t_skillId = { 13850, 20239, 20240 }, _skin = { 0 }, _star = 8,
\t\t\t\t_syncComponent = { { 0 } }
\t\t\t}'''

if 'Data._rareInfo[40782]' not in patch:
    if rare_patch_target in patch:
        patch = patch.replace(rare_patch_target, rare_patch_target + rare_patch_addition, 1)
        print("[OK] Added rareInfo 40782 to h5_patch.lua")

# 4d. Add language overrides in h5_patch
lan_patch_target = '[58388] = "Khi lên sân, phe ta tăng 500 LP. Nếu đối phương có nhiều hơn phe ta 4000 LP, phe ta tăng thêm 500 LP nữa.",'
lan_patch_addition = '''\n\t\t-- Dolia (12387)
\t\t[58389] = "Dolia",
\t\t[58390] = "[Thủy / Hiệu Ứng / UR]\\nThuộc tính: Thủy | 3 Sao\\nTừ khóa: \\"liqi\\"\\nATK: 700 | DEF: 1000",
\t\t[58391] = "Dolia",
\t\t[58392] = "Khúc Ca Đại Dương",
\t\t[58393] = "Khi lá bài này nằm trong mộ, bắt đầu mỗi lượt phe ta, phe ta nhận 500 LP.",
\t\t-- Heino (12388)
\t\t[58394] = "Heino",
\t\t[58395] = "[Phù Thủy / Hiệu Ứng / UR]\\nThuộc tính: Quang | 6 Sao\\nTừ khóa: \\"liqi\\"\\nATK: 2200 | DEF: 1800",
\t\t[58396] = "Heino",
\t\t[58397] = "Hồi Sinh Định Mệnh",
\t\t[58398] = "Kĩ năng chủ động mộ: 1 lượt 1 lần, triệu hồi đặc biệt bản thân lên sân trong thế thủ (không thể thay đổi tư thế trong lượt này).",
\t\t-- Heino x Dolia (40782)
\t\t[58399] = "Heino x Dolia",
\t\t[58400] = "[Phù Thủy / Dung Hợp / Hiệu Ứng / UR]\\nThuộc tính: Quang | 8 Sao\\nTừ khóa: \\"liqi\\"\\nATK: 2800 | DEF: 2600",
\t\t[58401] = "Heino x Dolia",
\t\t[58402] = "Phong Tỏa Không Gian",
\t\t[58403] = "Kĩ năng chủ động: Chỉ có thể kích hoạt 1 lần: Nếu phe ta chưa tấn công có thể kích hoạt: Phe ta và đối phương không thể tấn công trong 1 lượt.",
\t\t[58404] = "Ký Ức Thời Gian",
\t\t[58405] = "Kĩ năng chủ động mộ: Loại bỏ bản thân, phe ta rút 1 lá.",'''

if '[58389]' not in patch:
    if lan_patch_target in patch:
        patch = patch.replace(lan_patch_target, lan_patch_target + lan_patch_addition, 1)
        print("[OK] Added language overrides 58389..58405 to h5_patch.lua")

with open(patch_path, 'w', encoding='utf-8') as f:
    f.write(patch)

# ==========================================
# 5. Update web/src/Data.lua (getSkillType range)
# ==========================================
data_path = r'D:\yugitauapk\web\src\Data.lua'
with open(data_path, 'r', encoding='utf-8') as f:
    data_content = f.read()

data_target = 'if (arg_13_0 >= 20230 and arg_13_0 <= 20236) then'
data_replacement = 'if (arg_13_0 >= 20230 and arg_13_0 <= 20240) then'

if data_target in data_content:
    data_content = data_content.replace(data_target, data_replacement, 1)
    with open(data_path, 'w', encoding='utf-8') as f:
        f.write(data_content)
    print("[OK] Data.lua updated with getSkillType for 20230..20240.")

# ==========================================
# 6. Update web/src/StringEnums.lua
# ==========================================
se_path = r'D:\yugitauapk\web\src\StringEnums.lua'
with open(se_path, 'r', encoding='utf-8') as f:
    se_content = f.read()

se_target = '''\tSID_SKILL_NAME_20236 = 58387,
\tSID_SKILL_DESC_20236 = 58388,
}'''

se_replacement = '''\tSID_SKILL_NAME_20236 = 58387,
\tSID_SKILL_DESC_20236 = 58388,
\tSID_MONSTER_NAME_12387 = 58389,
\tSID_MONSTER_DESC_12387 = 58390,
\tSID_MONSTER_BRIEFNAME_12387 = 58391,
\tSID_SKILL_NAME_20237 = 58392,
\tSID_SKILL_DESC_20237 = 58393,
\tSID_MONSTER_NAME_12388 = 58394,
\tSID_MONSTER_DESC_12388 = 58395,
\tSID_MONSTER_BRIEFNAME_12388 = 58396,
\tSID_SKILL_NAME_20238 = 58397,
\tSID_SKILL_DESC_20238 = 58398,
\tSID_MONSTER_NAME_40782 = 58399,
\tSID_MONSTER_DESC_40782 = 58400,
\tSID_MONSTER_BRIEFNAME_40782 = 58401,
\tSID_SKILL_NAME_20239 = 58402,
\tSID_SKILL_DESC_20239 = 58403,
\tSID_SKILL_NAME_20240 = 58404,
\tSID_SKILL_DESC_20240 = 58405,
}'''

if 'SID_MONSTER_NAME_12387' not in se_content:
    if se_target in se_content:
        se_content = se_content.replace(se_target, se_replacement, 1)
        with open(se_path, 'w', encoding='utf-8') as f:
            f.write(se_content)
        print("[OK] StringEnums.lua updated with 12387, 12388, 40782, 20237..20240.")

# ==========================================
# 7. Update web/src/BattleInitiativeSkillsDialog.lua
# ==========================================
bisd_path = r'D:\yugitauapk\web\src\BattleInitiativeSkillsDialog.lua'
with open(bisd_path, 'r', encoding='utf-8') as f:
    bisd_content = f.read()

bisd_target = '[20235] = "Khúc Ca Cứu Rỗi",'
bisd_addition = '\n\t\t[20238] = "Hồi Sinh Định Mệnh",\n\t\t[20239] = "Phong Tỏa Không Gian",\n\t\t[20240] = "Ký Ức Thời Gian",'

if '[20238]' not in bisd_content:
    if bisd_target in bisd_content:
        bisd_content = bisd_content.replace(bisd_target, bisd_target + bisd_addition, 1)
        with open(bisd_path, 'w', encoding='utf-8') as f:
            f.write(bisd_content)
        print("[OK] BattleInitiativeSkillsDialog.lua updated with 20238, 20239, 20240.")

# ==========================================
# 8. Update web/src/ClientView.lua
# ==========================================
cv_path = r'D:\yugitauapk\web\src\ClientView.lua'
with open(cv_path, 'r', encoding='utf-8') as f:
    cv_content = f.read()

cv_target = '[12386] = true'
cv_addition = ', [12387] = true, [12388] = true, [40782] = true'

if '[40782] = true' not in cv_content:
    if cv_target in cv_content:
        cv_content = cv_content.replace(cv_target, cv_target + cv_addition, 1)
        with open(cv_path, 'w', encoding='utf-8') as f:
            f.write(cv_content)
        print("[OK] ClientView.lua updated with 12387, 12388, 40782.")

# ==========================================
# 9. Update web/src/PlayerCard.lua
# ==========================================
pc_path = r'D:\yugitauapk\web\src\PlayerCard.lua'
with open(pc_path, 'r', encoding='utf-8') as f:
    pc_content = f.read()

pc_target = '12385, 12386'
pc_replacement = '12385, 12386, 12387, 12388, 40782'

if '40782' not in pc_content:
    if pc_target in pc_content:
        pc_content = pc_content.replace(pc_target, pc_replacement, 1)
        with open(pc_path, 'w', encoding='utf-8') as f:
            f.write(pc_content)
        print("[OK] PlayerCard.lua updated with 12387, 12388, 40782.")

# ==========================================
# 10. Update MySQL card_monsters, card_extra & user_cards
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
        # Insert 12387 (Dolia) into card_monsters
        sql_mon = """
        INSERT INTO card_monsters (id, name, category, attribute, keyword, stars, atk, def, quality, cost, max_count, pinyin, description, guide)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE
            name=VALUES(name), category=VALUES(category), attribute=VALUES(attribute), keyword=VALUES(keyword),
            stars=VALUES(stars), atk=VALUES(atk), def=VALUES(def), quality=VALUES(quality), cost=VALUES(cost),
            max_count=VALUES(max_count), pinyin=VALUES(pinyin), description=VALUES(description), guide=VALUES(guide)
        """
        cur.execute(sql_mon, (
            12387, "Dolia", "Thủy", "Thủy", "liqi", 3, 700, 1000, "UR", 0, 3, "dolia",
            '[Thủy / Hiệu Ứng / UR]\nThuộc tính: Thủy | 3 Sao\nTừ khóa: "liqi"\nATK: 700 | DEF: 1000', ''
        ))
        # Insert 12388 (Heino) into card_monsters
        cur.execute(sql_mon, (
            12388, "Heino", "Phù Thủy", "Quang", "liqi", 6, 2200, 1800, "UR", 0, 3, "heino",
            '[Phù Thủy / Hiệu Ứng / UR]\nThuộc tính: Quang | 6 Sao\nTừ khóa: "liqi"\nATK: 2200 | DEF: 1800', ''
        ))
        print("[OK] card_monsters updated with 12387 and 12388.")

        # Insert 40782 (Heino x Dolia) into card_extra
        sql_extra = """
        INSERT INTO card_extra (id, name, summon_type, category, attribute, keyword, stars, atk, def, quality, materials, link_arrows, pinyin, description, guide)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE
            name=VALUES(name), summon_type=VALUES(summon_type), category=VALUES(category), attribute=VALUES(attribute),
            keyword=VALUES(keyword), stars=VALUES(stars), atk=VALUES(atk), def=VALUES(def), quality=VALUES(quality),
            materials=VALUES(materials), link_arrows=VALUES(link_arrows), pinyin=VALUES(pinyin), description=VALUES(description), guide=VALUES(guide)
        """
        cur.execute(sql_extra, (
            40782, "Heino x Dolia", "Dung Hợp", "Phù Thủy", "Quang", "liqi", 8, 2800, 2600, "UR",
            "Heino + Dolia", "", "heinoxdolia",
            '[Phù Thủy / Dung Hợp / Hiệu Ứng / UR]\nThuộc tính: Quang | 8 Sao\nTừ khóa: "liqi"\nATK: 2800 | DEF: 2600', ''
        ))
        print("[OK] card_extra updated with 40782.")

        # Grant x3 cards (12387, 12388, 40782) to all accounts
        cur.execute("SELECT id FROM accounts")
        acc_ids = [r[0] for r in cur.fetchall()]
        batch_size = 500
        for i in range(0, len(acc_ids), batch_size):
            batch = acc_ids[i:i + batch_size]
            records = []
            for aid in batch:
                records.append((aid, 12387, 3))
                records.append((aid, 12388, 3))
                records.append((aid, 40782, 3))
            cur.executemany("""
                INSERT INTO user_cards (account_id, card_id, count)
                VALUES (%s, %s, %s)
                ON DUPLICATE KEY UPDATE count = GREATEST(count, 3)
            """, records)
        print(f"[OK] Granted 3x cards (12387, 12388, 40782) to {len(acc_ids)} accounts in user_cards.")
    conn.close()
except Exception as e:
    print(f"[ERR] MySQL error: {e}")

# ==========================================
# 11. Update Desktop text files
# ==========================================
# monster.txt
monster_txt_path = r'C:\Users\Nitro 5\OneDrive\Máy tính\monster.txt'
if os.path.exists(monster_txt_path):
    with open(monster_txt_path, 'r', encoding='utf-8') as f:
        mtxt = f.read()
    if '12387:' not in mtxt:
        if not mtxt.endswith('\n'): mtxt += '\n'
        mtxt += "12387: Dolia\n12388: Heino\n"
        with open(monster_txt_path, 'w', encoding='utf-8') as f:
            f.write(mtxt)
        print("[OK] monster.txt updated.")

# monsterextra.txt
monsterextra_txt_path = r'C:\Users\Nitro 5\OneDrive\Máy tính\monsterextra.txt'
if os.path.exists(monsterextra_txt_path):
    with open(monsterextra_txt_path, 'r', encoding='utf-8') as f:
        mextxt = f.read()
    if '40782:' not in mextxt:
        if not mextxt.endswith('\n'): mextxt += '\n'
        mextxt += "40782: Heino x Dolia\n"
        with open(monsterextra_txt_path, 'w', encoding='utf-8') as f:
            f.write(mextxt)
        print("[OK] monsterextra.txt updated.")

# skill.txt
skill_txt_path = r'C:\Users\Nitro 5\OneDrive\Máy tính\skill.txt'
if os.path.exists(skill_txt_path):
    with open(skill_txt_path, 'r', encoding='utf-8') as f:
        stxt = f.read()
    if '20237 Khúc Ca Đại Dương' not in stxt:
        addition = '''20237 Khúc Ca Đại Dương: Khi lá bài này nằm trong mộ, bắt đầu mỗi lượt phe ta, phe ta nhận 500 LP. [Thẻ: Dolia (12387)]
20238 Hồi Sinh Định Mệnh: Kĩ năng chủ động mộ: 1 lượt 1 lần, triệu hồi đặc biệt bản thân lên sân trong thế thủ (không thể thay đổi tư thế trong lượt này). [Thẻ: Heino (12388)]
20239 Phong Tỏa Không Gian: Kĩ năng chủ động: Chỉ có thể kích hoạt 1 lần: Nếu phe ta chưa tấn công có thể kích hoạt: Phe ta và đối phương không thể tấn công trong 1 lượt. [Thẻ: Heino x Dolia (40782)]
20240 Ký Ức Thời Gian: Kĩ năng chủ động mộ: Loại bỏ bản thân, phe ta rút 1 lá. [Thẻ: Heino x Dolia (40782)]
'''
        if not stxt.endswith('\n'): stxt += '\n'
        stxt += addition
        with open(skill_txt_path, 'w', encoding='utf-8') as f:
            f.write(stxt)
        print("[OK] skill.txt updated.")

# ==========================================
# 12. Update extend_lan.txt and extend.lan
# ==========================================
LAN_FILES = [
    r"D:\yugitauapk\extend_lan.txt",
    r"D:\yugitauapk\web\res\lan.lcres\extend.lan"
]

new_lan_entries = {
    58389: "Dolia\n",
    58390: '[Thủy / Hiệu Ứng / UR]\\nThuộc tính: Thủy | 3 Sao\\nTừ khóa: "liqi"\\nATK: 700 | DEF: 1000\n',
    58391: "Dolia\n",
    58392: "Khúc Ca Đại Dương\n",
    58393: 'Khi lá bài này nằm trong mộ, bắt đầu mỗi lượt phe ta, phe ta nhận 500 LP.\n',
    58394: "Heino\n",
    58395: '[Phù Thủy / Hiệu Ứng / UR]\\nThuộc tính: Quang | 6 Sao\\nTừ khóa: "liqi"\\nATK: 2200 | DEF: 1800\n',
    58396: "Heino\n",
    58397: "Hồi Sinh Định Mệnh\n",
    58398: 'Kĩ năng chủ động mộ: 1 lượt 1 lần, triệu hồi đặc biệt bản thân lên sân trong thế thủ (không thể thay đổi tư thế trong lượt này).\n',
    58399: "Heino x Dolia\n",
    58400: '[Phù Thủy / Dung Hợp / Hiệu Ứng / UR]\\nThuộc tính: Quang | 8 Sao\\nTừ khóa: "liqi"\\nATK: 2800 | DEF: 2600\n',
    58401: "Heino x Dolia\n",
    58402: "Phong Tỏa Không Gian\n",
    58403: 'Kĩ năng chủ động: Chỉ có thể kích hoạt 1 lần: Nếu phe ta chưa tấn công có thể kích hoạt: Phe ta và đối phương không thể tấn công trong 1 lượt.\n',
    58404: "Ký Ức Thời Gian\n",
    58405: 'Kĩ năng chủ động mộ: Loại bỏ bản thân, phe ta rút 1 lá.\n'
}

for lp in LAN_FILES:
    if os.path.isfile(lp):
        with open(lp, 'r', encoding='utf-8') as f:
            llines = f.readlines()
        while len(llines) < 58405:
            llines.append('\n')
        for sid, text in new_lan_entries.items():
            llines[sid - 1] = text
        with open(lp, 'w', encoding='utf-8', newline='\n') as f:
            f.writelines(llines)
        print(f"[OK] Updated {lp}, now {len(llines)} lines.")

print("[*] Finished deploy_new_3_cards_data.py successfully!")
