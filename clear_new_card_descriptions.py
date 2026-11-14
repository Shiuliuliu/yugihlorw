import re
import sys
import subprocess
import pymysql

sys.stdout.reconfigure(encoding='utf-8')

print("[*] Starting clear_new_card_descriptions...")

# ==========================================
# 1. Update web/src/h5_patch.lua
# ==========================================
h5_patch_path = r"D:\yugitauapk\web\src\h5_patch.lua"
with open(h5_patch_path, 'r', encoding='utf-8') as f:
    h5_content = f.read()

# 1a. Spell 21171 _descSid = 0
h5_content = re.sub(
    r'(Data\._magicInfo\[21171\]\s*=\s*\{[^}]+?_descSid\s*=\s*)\d+',
    r'\g<1>0',
    h5_content
)

# 1b. Traps 30602..30605 and Spells 21172..21173 _descSid = 0
for cid in [30602, 30603, 30604, 30605]:
    h5_content = re.sub(
        rf'(Data\._trapInfo\[{cid}\]\s*=\s*\{{[^}}]+?_descSid\s*=\s*)\d+',
        r'\g<1>0',
        h5_content
    )

for cid in [21172, 21173]:
    h5_content = re.sub(
        rf'(Data\._magicInfo\[{cid}\]\s*=\s*\{{[^}}]+?_descSid\s*=\s*)\d+',
        r'\g<1>0',
        h5_content
    )

# 1c. Traps 30598..30601 _descSid = 0
for cid in [30598, 30599, 30600, 30601]:
    h5_content = re.sub(
        rf'(Data\._trapInfo\[{cid}\]\s*=\s*\{{[^}}]+?_descSid\s*=\s*)\d+',
        r'\g<1>0',
        h5_content
    )

# 1d. Skills 20117..20120 nameSid & descSid in h5_patch.lua
# 20117: nameSid = 58053, descSid = 58054
# 20118: nameSid = 58058, descSid = 58059
# 20119: nameSid = 58063, descSid = 58064
# 20120: nameSid = 58068, descSid = 58069
skill_fixes = {
    20117: (58050, 58053, 58052, 58054),
    20118: (58055, 58058, 58057, 58059),
    20119: (58060, 58063, 58062, 58064),
    20120: (58065, 58068, 58067, 58069),
}
for skid, (old_n, new_n, old_d, new_d) in skill_fixes.items():
    # Replace in h5_patch.lua
    # _descSid = old_d ... _nameSid = old_n inside Data._skillInfo[skid]
    pattern = rf'(Data\._skillInfo\[{skid}\]\s*=\s*\{{.+?_descSid\s*=\s*){old_d}(.+?_nameSid\s*=\s*){old_n}'
    h5_content = re.sub(pattern, rf'\g<1>{new_d}\g<2>{new_n}', h5_content, flags=re.DOTALL)

# 1e. Empty string entries in string table
# [57971], [58262], [58271], [58284], [58295], [58306], [58315], [58052], [58057], [58062], [58067]
desc_sids = [57971, 58262, 58271, 58284, 58295, 58306, 58315, 58052, 58057, 58062, 58067]
for sid in desc_sids:
    h5_content = re.sub(rf'(\[{sid}\]\s*=\s*)"(?:[^"\\]|\\.)*"', r'\1""', h5_content)

with open(h5_patch_path, 'w', encoding='utf-8') as f:
    f.write(h5_content)
print("[OK] Updated web/src/h5_patch.lua")

# ==========================================
# 2. Update web/data/magic.lua
# ==========================================
magic_path = r"D:\yugitauapk\web\data\magic.lua"
with open(magic_path, 'r', encoding='utf-8') as f:
    magic_content = f.read()

for mid in [21171, 21172, 21173]:
    magic_content = re.sub(
        rf'(\[{mid}\]=\{{[^}}]+?\["_descSid"\]=)\d+',
        r'\g<1>0',
        magic_content
    )

with open(magic_path, 'w', encoding='utf-8') as f:
    f.write(magic_content)
print("[OK] Updated web/data/magic.lua")

# ==========================================
# 3. Update web/data/trap.lua
# ==========================================
trap_path = r"D:\yugitauapk\web\data\trap.lua"
with open(trap_path, 'r', encoding='utf-8') as f:
    trap_content = f.read()

for tid in [30598, 30599, 30600, 30601, 30602, 30603, 30604, 30605]:
    trap_content = re.sub(
        rf'(\[{tid}\]=\{{[^}}]+?\["_descSid"\]=)\d+',
        r'\g<1>0',
        trap_content
    )

with open(trap_path, 'w', encoding='utf-8') as f:
    f.write(trap_content)
print("[OK] Updated web/data/trap.lua")

# ==========================================
# 4. Update web/data/skill.lua
# ==========================================
skill_path = r"D:\yugitauapk\web\data\skill.lua"
with open(skill_path, 'r', encoding='utf-8') as f:
    skill_content = f.read()

for skid, (old_n, new_n, old_d, new_d) in skill_fixes.items():
    skill_content = skill_content.replace(
        f'[{skid}]={{["_against"]={{[1]=0,}},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={{[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,}},["_descSid"]={old_d},["_effectVal"]={{[1]=0,}},["_id"]={skid},["_isIgnoreDefend"]=0,["_modes"]={{[1]=32,}},["_nameSid"]={old_n}',
        f'[{skid}]={{["_against"]={{[1]=0,}},["_avoidP2B"]=0,["_count"]=1,["_decrease"]={{[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,}},["_descSid"]={new_d},["_effectVal"]={{[1]=0,}},["_id"]={skid},["_isIgnoreDefend"]=0,["_modes"]={{[1]=32,}},["_nameSid"]={new_n}'
    )

with open(skill_path, 'w', encoding='utf-8') as f:
    f.write(skill_content)
print("[OK] Updated web/data/skill.lua")

# ==========================================
# 5. Update MySQL database
# ==========================================
try:
    conn = pymysql.connect(host='127.0.0.1', user='root', password='', db='yugioh_game')
    cur = conn.cursor()
    cur.execute("UPDATE card_traps SET description = '' WHERE id IN (30598, 30599, 30600, 30601, 30602, 30603, 30604, 30605)")
    cur.execute("UPDATE card_spells SET description = '' WHERE id IN (21171, 21172, 21173)")
    conn.commit()
    conn.close()
    print("[OK] Updated MySQL card_traps and card_spells descriptions to empty")
except Exception as e:
    print(f"[WARN] MySQL update error: {e}")
