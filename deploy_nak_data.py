import os, re

SKILL_LUA = r"D:\yugitauapk\web\data\skill.lua"
MONSTER_LUA = r"D:\yugitauapk\web\data\monster.lua"
RARE_LUA = r"D:\yugitauapk\web\data\rare.lua"
DIAMOND_LUA = r"D:\yugitauapk\web\data\diamond_products.lua"
PRIVILEGE_LUA = r"D:\yugitauapk\web\data\privilege_products.lua"

skill_14787_str = """  [14787]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57307,["_effectVal"]={[1]=0,},
  ["_id"]=14787,["_isIgnoreDefend"]=1,["_modes"]={[1]=1,},
  ["_nameSid"]=57306,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=1,["_quality"]=1,["_refCards"]={[1]=0,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=1000,},},
"""

card_40745_str = """  [40745]={["_atk"]={[1]=0,},
  ["_attackEffect"]=1,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=57305,["_category"]=6,["_cost"]=0,["_descSid"]=57304,["_guideSid"]=0,["_hp"]={[1]=0,},
  ["_id"]=40745,["_isHide"]=0,["_joinComponent"]={[1]=0,},
  ["_joinResult"]={[1]=0,},
  ["_keyword"]=303,["_link"]={[1]=1,},
  ["_linkAllCandidates"]="0.0",["_linkCandidate"]="Q==5&&K==303",["_linkCount"]="#==1",["_linkSelectedCandidates"]="0.0",["_maxCount"]=3,["_nameSid"]=57303,["_nature"]=1,["_option"]=8194,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="nak",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=3043,[2]=14787,[3]=1076,[4]=6629,[5]=3191,},
  ["_skin"]={[1]=0,},
  ["_star"]=0,["_syncComponent"]={[1]={[1]=0,},},},
"""

diamond_548_str = '  [548]={["_cardId"]=40745,["_cost"]=20000,["_date"]="20240101.0",["_id"]=548,["_resType"]=3,["_type"]=0,},\n'
privilege_17_str = '  [17]={["_cardId"]=40745,["_cost"]=20000,["_date"]="20240101.0",["_id"]=17,["_resType"]=3,},\n'

# 1. Update skill.lua
with open(SKILL_LUA, 'r', encoding='utf-8') as f:
    skill_content = f.read()

if '[14787]=' not in skill_content:
    last_brace = skill_content.rfind('}')
    if last_brace != -1:
        skill_content = skill_content[:last_brace] + skill_14787_str + skill_content[last_brace:]
        with open(SKILL_LUA, 'w', encoding='utf-8') as f:
            f.write(skill_content)
        print("[OK] Updated skill.lua with skill 14787")
else:
    print("[SKIP] skill.lua already has 14787")

# 2. Update monster.lua (card 12336 keyword -> 303)
with open(MONSTER_LUA, 'r', encoding='utf-8') as f:
    mon_content = f.read()

# Replace ["_keyword"]=0 in card 12336
idx = mon_content.find('[12336]=')
if idx != -1:
    end = mon_content.find('},', idx)
    entry = mon_content[idx:end+2]
    new_entry = re.sub(r'\["_keyword"\]=\d+', '["_keyword"]=303', entry)
    mon_content = mon_content[:idx] + new_entry + mon_content[end+2:]
    with open(MONSTER_LUA, 'w', encoding='utf-8') as f:
        f.write(mon_content)
    print("[OK] Updated monster.lua card 12336 keyword to 303")
else:
    print("[ERR] Could not find 12336 in monster.lua")

# 3. Update rare.lua:
# (a) card 40731 keyword -> 303
# (b) add card 40745
with open(RARE_LUA, 'r', encoding='utf-8') as f:
    rare_content = f.read()

idx = rare_content.find('[40731]=')
if idx != -1:
    end = rare_content.find('},', idx)
    entry = rare_content[idx:end+2]
    new_entry = re.sub(r'\["_keyword"\]=\d+', '["_keyword"]=303', entry)
    rare_content = rare_content[:idx] + new_entry + rare_content[end+2:]
    print("[OK] Updated rare.lua card 40731 keyword to 303")
else:
    print("[ERR] Could not find 40731 in rare.lua")

if '[40745]=' not in rare_content:
    last_brace = rare_content.rfind('}')
    if last_brace != -1:
        rare_content = rare_content[:last_brace] + card_40745_str + rare_content[last_brace:]
        print("[OK] Added card 40745 to rare.lua")
else:
    print("[SKIP] rare.lua already has 40745")

with open(RARE_LUA, 'w', encoding='utf-8') as f:
    f.write(rare_content)

# 4. Update diamond_products.lua
with open(DIAMOND_LUA, 'r', encoding='utf-8') as f:
    dia_content = f.read()

if '[548]=' not in dia_content and '40745' not in dia_content:
    last_brace = dia_content.rfind('}')
    if last_brace != -1:
        dia_content = dia_content[:last_brace] + diamond_548_str + dia_content[last_brace:]
        with open(DIAMOND_LUA, 'w', encoding='utf-8') as f:
            f.write(dia_content)
        print("[OK] Updated diamond_products.lua with product 548 (card 40745)")
else:
    print("[SKIP] diamond_products.lua already has 40745")

# 5. Update privilege_products.lua
with open(PRIVILEGE_LUA, 'r', encoding='utf-8') as f:
    priv_content = f.read()

if '[17]=' not in priv_content and '40745' not in priv_content:
    last_brace = priv_content.rfind('}')
    if last_brace != -1:
        priv_content = priv_content[:last_brace] + privilege_17_str + priv_content[last_brace:]
        with open(PRIVILEGE_LUA, 'w', encoding='utf-8') as f:
            f.write(priv_content)
        print("[OK] Updated privilege_products.lua with product 17 (card 40745)")
else:
    print("[SKIP] privilege_products.lua already has 40745")

print("[OK] All data files updated successfully!")
