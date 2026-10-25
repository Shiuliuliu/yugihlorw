import os, re, sys
sys.stdout.reconfigure(encoding='utf-8')

SKILL_LUA = r"D:\yugitauapk\web\data\skill.lua"
RARE_LUA = r"D:\yugitauapk\web\data\rare.lua"
DIAMOND_LUA = r"D:\yugitauapk\web\data\diamond_products.lua"
PRIVILEGE_LUA = r"D:\yugitauapk\web\data\privilege_products.lua"

skills_str = """  [14788]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57312,["_effectVal"]={[1]=0,},
  ["_id"]=14788,["_isIgnoreDefend"]=1,["_modes"]={[1]=132,},
  ["_nameSid"]=57311,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=1,["_quality"]=1,["_refCards"]={[1]=21,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
  [14789]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57314,["_effectVal"]={[1]=0,},
  ["_id"]=14789,["_isIgnoreDefend"]=1,["_modes"]={[1]=2,},
  ["_nameSid"]=57313,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=1,["_quality"]=1,["_refCards"]={[1]=2,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=2,},},
  [14790]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57316,["_effectVal"]={[1]=0,},
  ["_id"]=14790,["_isIgnoreDefend"]=1,["_modes"]={[1]=132,},
  ["_nameSid"]=57315,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=1,["_quality"]=1,["_refCards"]={[1]=2,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
  [14791]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57318,["_effectVal"]={[1]=0,},
  ["_id"]=14791,["_isIgnoreDefend"]=1,["_modes"]={[1]=4,},
  ["_nameSid"]=57317,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=1,["_quality"]=1,["_refCards"]={[1]=2,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
"""

card_40746_str = """  [40746]={["_atk"]={[1]=2900,},
  ["_attackEffect"]=1,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=57310,["_category"]=6,["_cost"]=0,["_descSid"]=57309,["_guideSid"]=0,["_hp"]={[1]=0,},
  ["_id"]=40746,["_isHide"]=0,["_joinComponent"]={[1]=0,},
  ["_joinResult"]={[1]=0,},
  ["_keyword"]=21,["_link"]={[1]=1,[2]=2,[3]=7,[4]=8,},
  ["_linkAllCandidates"]="0.0",["_linkCandidate"]="0.0",["_linkCount"]="#>=2",["_linkSelectedCandidates"]="0.0",["_maxCount"]=3,["_nameSid"]=57308,["_nature"]=3,["_option"]=8194,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="ksdr",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=14788,[2]=14789,[3]=6199,[4]=2797,[5]=14790,[6]=14791,},
  ["_skin"]={[1]=0,},
  ["_star"]=0,["_syncComponent"]={[1]={[1]=0,},},},
"""

diamond_549_str = '  [549]={["_cardId"]=40746,["_cost"]=20000,["_date"]="20240101.0",["_id"]=549,["_resType"]=3,["_type"]=0,},\n'
privilege_18_str = '  [18]={["_cardId"]=40746,["_cost"]=20000,["_date"]="20240101.0",["_id"]=18,["_resType"]=3,},\n'

# 1. Update skill.lua
with open(SKILL_LUA, 'r', encoding='utf-8') as f:
    skill_content = f.read()

if '[14788]=' not in skill_content:
    last_brace = skill_content.rfind('}')
    if last_brace != -1:
        skill_content = skill_content[:last_brace] + skills_str + skill_content[last_brace:]
        with open(SKILL_LUA, 'w', encoding='utf-8') as f:
            f.write(skill_content)
        print("[OK] Updated skill.lua with skills 14788-14791")
else:
    print("[SKIP] skill.lua already has 14788")

# 2. Update rare.lua
with open(RARE_LUA, 'r', encoding='utf-8') as f:
    rare_content = f.read()

if '[40746]=' not in rare_content:
    last_brace = rare_content.rfind('}')
    if last_brace != -1:
        rare_content = rare_content[:last_brace] + card_40746_str + rare_content[last_brace:]
        with open(RARE_LUA, 'w', encoding='utf-8') as f:
            f.write(rare_content)
        print("[OK] Added card 40746 to rare.lua")
else:
    print("[SKIP] rare.lua already has 40746")

# 3. Update diamond_products.lua
with open(DIAMOND_LUA, 'r', encoding='utf-8') as f:
    dia_content = f.read()

if '[549]=' not in dia_content and '40746' not in dia_content:
    last_brace = dia_content.rfind('}')
    if last_brace != -1:
        dia_content = dia_content[:last_brace] + diamond_549_str + dia_content[last_brace:]
        with open(DIAMOND_LUA, 'w', encoding='utf-8') as f:
            f.write(dia_content)
        print("[OK] Updated diamond_products.lua with product 549 (card 40746)")
else:
    print("[SKIP] diamond_products.lua already has 40746")

# 4. Update privilege_products.lua
with open(PRIVILEGE_LUA, 'r', encoding='utf-8') as f:
    priv_content = f.read()

if '[18]=' not in priv_content and '40746' not in priv_content:
    last_brace = priv_content.rfind('}')
    if last_brace != -1:
        priv_content = priv_content[:last_brace] + privilege_18_str + priv_content[last_brace:]
        with open(PRIVILEGE_LUA, 'w', encoding='utf-8') as f:
            f.write(priv_content)
        print("[OK] Updated privilege_products.lua with product 18 (card 40746)")
else:
    print("[SKIP] privilege_products.lua already has 40746")

print("[OK] All data files updated successfully!")
