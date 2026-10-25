import os

MONSTER_LUA = r"D:\yugitauapk\web\data\monster.lua"
DIAMOND_LUA = r"D:\yugitauapk\web\data\diamond_products.lua"
PRIVILEGE_LUA = r"D:\yugitauapk\web\data\privilege_products.lua"

monster_entry = """  [12336]={["_atk"]={[1]=300,},
  ["_attackEffect"]=1,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=57302,["_category"]=1,["_cost"]=0,["_descSid"]=57301,["_guideSid"]=0,["_hp"]={[1]=100,},
  ["_id"]=12336,["_isHide"]=0,["_joinResult"]={[1]=0,},
  ["_keyword"]=0,["_maxCount"]=3,["_nameSid"]=57300,["_nature"]=1,["_option"]=129,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="sucvatalice",["_quality"]=5,["_recruitable"]=1,["_skillId"]={[1]=0,},
  ["_skin"]={[1]=0,},
  ["_star"]=3,},
"""

diamond_entry = '  [547]={["_cardId"]=12336,["_cost"]=50000,["_date"]="20240101.0",["_id"]=547,["_resType"]=3,["_type"]=0,},\n'
privilege_entry = '  [16]={["_cardId"]=12336,["_cost"]=50000,["_date"]="20240101.0",["_id"]=16,["_resType"]=3,},\n'

# 1. Update monster.lua
with open(MONSTER_LUA, 'r', encoding='utf-8') as f:
    mon_content = f.read()

if '[12336]=' not in mon_content:
    last_brace = mon_content.rfind('}')
    if last_brace != -1:
        new_mon = mon_content[:last_brace] + monster_entry + mon_content[last_brace:]
        with open(MONSTER_LUA, 'w', encoding='utf-8') as f:
            f.write(new_mon)
        print("[OK] Updated monster.lua with card 12336")
else:
    print("[SKIP] monster.lua already has 12336")

# 2. Update diamond_products.lua
with open(DIAMOND_LUA, 'r', encoding='utf-8') as f:
    dia_content = f.read()

if '[547]=' not in dia_content and '12336' not in dia_content:
    last_brace = dia_content.rfind('}')
    if last_brace != -1:
        new_dia = dia_content[:last_brace] + diamond_entry + dia_content[last_brace:]
        with open(DIAMOND_LUA, 'w', encoding='utf-8') as f:
            f.write(new_dia)
        print("[OK] Updated diamond_products.lua with product 547 (card 12336)")
else:
    print("[SKIP] diamond_products.lua already has product for 12336")

# 3. Update privilege_products.lua
with open(PRIVILEGE_LUA, 'r', encoding='utf-8') as f:
    priv_content = f.read()

if '[16]=' not in priv_content and '12336' not in priv_content:
    last_brace = priv_content.rfind('}')
    if last_brace != -1:
        new_priv = priv_content[:last_brace] + privilege_entry + priv_content[last_brace:]
        with open(PRIVILEGE_LUA, 'w', encoding='utf-8') as f:
            f.write(new_priv)
        print("[OK] Updated privilege_products.lua with product 16 (card 12336)")
else:
    print("[SKIP] privilege_products.lua already has product for 12336")

print("[OK] All data files updated successfully!")
