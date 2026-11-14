import sys
sys.stdout.reconfigure(encoding='utf-8')

# 1. Update magic.lua
with open(r'D:\yugitauapk\web\data\magic.lua', 'r', encoding='utf-8') as f:
    magic_content = f.read()

magic_entries = '''  [21174]={["_available"]=1,["_briefNameSid"]=58351,["_descSid"]=58352,["_guideSid"]=0,["_id"]=21174,["_isHide"]=0,["_isSummon"]=0,["_keyword"]=303,["_maxCount"]=3,["_nameSid"]=58351,["_option"]=1,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="napquanhuy",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20226,},["_targetType"]=0,["_type"]=11,},
  [21175]={["_available"]=1,["_briefNameSid"]=58362,["_descSid"]=58363,["_guideSid"]=0,["_id"]=21175,["_isHide"]=0,["_isSummon"]=0,["_keyword"]=303,["_maxCount"]=3,["_nameSid"]=58362,["_option"]=1,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="huhucacnguoibatnatta",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20229,},["_targetType"]=0,["_type"]=11,},
'''

if '[21174]=' not in magic_content:
    idx = magic_content.rfind('\n}')
    if idx != -1:
        magic_content = magic_content[:idx] + '\n' + magic_entries + magic_content[idx:]
        with open(r'D:\yugitauapk\web\data\magic.lua', 'w', encoding='utf-8') as f:
            f.write(magic_content)
        print("[OK] magic.lua updated.")
    else:
        print("[ERR] closing brace not found in magic.lua")
else:
    print("[SKIP] 21174 already in magic.lua")

# 2. Update monster.lua
with open(r'D:\yugitauapk\web\data\monster.lua', 'r', encoding='utf-8') as f:
    monster_content = f.read()

monster_entry = '''  [12383]={["_atk"]={[1]=1800,},["_attackEffect"]=2,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=58357,["_category"]=6,["_cost"]=0,["_descSid"]=58356,["_guideSid"]=0,["_hp"]={[1]=200,},["_id"]=12383,["_isHide"]=0,["_joinResult"]={[1]=0,},["_keyword"]=303,["_maxCount"]=3,["_nameSid"]=58355,["_nature"]=1,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},["_picId"]=0,["_py"]="elsumafia",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=20227,[2]=20228,},["_skin"]={[1]=0,},["_star"]=4,},
'''

if '[12383]=' not in monster_content:
    idx = monster_content.rfind('\n}')
    if idx != -1:
        monster_content = monster_content[:idx] + '\n' + monster_entry + monster_content[idx:]
        with open(r'D:\yugitauapk\web\data\monster.lua', 'w', encoding='utf-8') as f:
            f.write(monster_content)
        print("[OK] monster.lua updated.")
    else:
        print("[ERR] closing brace not found in monster.lua")
else:
    print("[SKIP] 12383 already in monster.lua")

# 3. Update skill.lua
with open(r'D:\yugitauapk\web\data\skill.lua', 'r', encoding='utf-8') as f:
    skill_content = f.read()

skill_entries = '''  [20226]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58354,["_effectVal"]={[1]=0,},["_id"]=20226,["_isIgnoreDefend"]=0,["_modes"]={[1]=61,},["_nameSid"]=58353,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=21174,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
  [20227]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58359,["_effectVal"]={[1]=0,},["_id"]=20227,["_isIgnoreDefend"]=0,["_modes"]={[1]=13,},["_nameSid"]=58358,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=12383,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
  [20228]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58361,["_effectVal"]={[1]=0,},["_id"]=20228,["_isIgnoreDefend"]=0,["_modes"]={[1]=2,},["_nameSid"]=58360,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=12383,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
  [20229]={["_against"]={[1]=0,},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},["_descSid"]=58365,["_effectVal"]={[1]=0,},["_id"]=20229,["_isIgnoreDefend"]=0,["_modes"]={[1]=61,},["_nameSid"]=58364,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=21175,},["_refSkills"]={[1]=0,},["_removeMode"]={[1]=0,},["_targetType"]=0,["_val"]={[1]=0,},},
'''

if '[20226]=' not in skill_content:
    idx = skill_content.rfind('\n}')
    if idx != -1:
        skill_content = skill_content[:idx] + '\n' + skill_entries + skill_content[idx:]
        with open(r'D:\yugitauapk\web\data\skill.lua', 'w', encoding='utf-8') as f:
            f.write(skill_content)
        print("[OK] skill.lua updated.")
    else:
        print("[ERR] closing brace not found in skill.lua")
else:
    print("[SKIP] 20226 already in skill.lua")
