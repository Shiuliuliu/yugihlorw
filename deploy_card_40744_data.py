import os

SKILL_LUA = r"D:\yugitauapk\web\data\skill.lua"
RARE_LUA = r"D:\yugitauapk\web\data\rare.lua"

skills_str = """  [14784]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57292,["_effectVal"]={[1]=0,},
  ["_id"]=14784,["_isIgnoreDefend"]=0,["_modes"]={[1]=33,},
  ["_nameSid"]=57291,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},
  ["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=0,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
  [14785]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57294,["_effectVal"]={[1]=0,},
  ["_id"]=14785,["_isIgnoreDefend"]=0,["_modes"]={[1]=31,},
  ["_nameSid"]=57293,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},
  ["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=204,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
  [14786]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57296,["_effectVal"]={[1]=0,},
  ["_id"]=14786,["_isIgnoreDefend"]=0,["_modes"]={[1]=31,},
  ["_nameSid"]=57295,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},
  ["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=21,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
"""

card_40744_str = """  [40744]={["_atk"]={[1]=1800,},
  ["_attackEffect"]=1,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=57299,["_category"]=6,["_cost"]=0,["_descSid"]=57298,["_guideSid"]=0,["_hp"]={[1]=0,},
  ["_id"]=40744,["_isHide"]=0,["_joinComponent"]={[1]=0,},
  ["_joinResult"]={[1]=0,},
  ["_keyword"]=21,["_link"]={[1]=1,},
  ["_linkAllCandidates"]="0.0",["_linkCandidate"]="K==204||K==21",["_linkCount"]="#==1",["_linkSelectedCandidates"]="0.0",["_maxCount"]=3,["_nameSid"]=57297,["_nature"]=3,["_option"]=8194,["_originId"]=0,["_packageId"]={[1]=128001,},
  ["_picId"]=0,["_py"]="ksdrts",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=14784,[2]=14785,[3]=14786,},
  ["_skin"]={[1]=0,},
  ["_star"]=0,["_syncComponent"]={[1]={[1]=0,},},},
"""

# Update skill.lua
with open(SKILL_LUA, 'r', encoding='utf-8') as f:
    skill_content = f.read()

if '[14784]=' not in skill_content:
    last_brace = skill_content.rfind('}')
    if last_brace != -1:
        new_skill = skill_content[:last_brace] + skills_str + skill_content[last_brace:]
        with open(SKILL_LUA, 'w', encoding='utf-8') as f:
            f.write(new_skill)
        print("[OK] Updated skill.lua with skills 14784, 14785, 14786")
else:
    print("[SKIP] skill.lua already has 14784")

# Update rare.lua
with open(RARE_LUA, 'r', encoding='utf-8') as f:
    rare_content = f.read()

if '[40744]=' not in rare_content:
    last_brace = rare_content.rfind('}')
    if last_brace != -1:
        new_rare = rare_content[:last_brace] + card_40744_str + rare_content[last_brace:]
        with open(RARE_LUA, 'w', encoding='utf-8') as f:
            f.write(new_rare)
        print("[OK] Updated rare.lua with card 40744")
else:
    print("[SKIP] rare.lua already has 40744")
