import os, sys, pymysql

sys.stdout.reconfigure(encoding='utf-8')

# 1. Update web/data/monster.lua
MONSTER_LUA = r"D:\yugitauapk\web\data\monster.lua"
with open(MONSTER_LUA, 'r', encoding='utf-8') as f:
    mon_content = f.read()

target_mon = '["_picId"]=0,["_py"]="enderman",["_quality"]=3,'
repl_mon = '["_picId"]=0,["_py"]="enderman",["_quality"]=4,'
if target_mon in mon_content:
    mon_content = mon_content.replace(target_mon, repl_mon, 1)
    with open(MONSTER_LUA, 'w', encoding='utf-8') as f:
        f.write(mon_content)
    print("[OK] Updated monster.lua: Enderman (12338) quality -> 4 (UR)")
else:
    print("[WARN] target_mon not found in monster.lua")

# 2. Update web/data/skill.lua
SKILL_LUA = r"D:\yugitauapk\web\data\skill.lua"
with open(SKILL_LUA, 'r', encoding='utf-8') as f:
    sk_content = f.read()

pos_14794 = sk_content.find('[14794]={')
pos_14795 = sk_content.find('[14795]={')
pos_14796 = sk_content.find('[14796]={')

if pos_14794 != -1 and pos_14795 != -1:
    chunk = sk_content[pos_14794:pos_14795]
    if '["_quality"]=3,' in chunk:
        chunk_new = chunk.replace('["_quality"]=3,', '["_quality"]=4,', 1)
        sk_content = sk_content[:pos_14794] + chunk_new + sk_content[pos_14795:]
        print("[OK] Updated skill.lua: Skill 14794 quality -> 4 (UR)")
        # recalculate pos_14795 and pos_14796
        pos_14795 = sk_content.find('[14795]={')
        pos_14796 = sk_content.find('[14796]={')

if pos_14795 != -1 and pos_14796 != -1:
    chunk = sk_content[pos_14795:pos_14796]
    if '["_quality"]=3,' in chunk:
        chunk_new = chunk.replace('["_quality"]=3,', '["_quality"]=4,', 1)
        sk_content = sk_content[:pos_14795] + chunk_new + sk_content[pos_14796:]
        print("[OK] Updated skill.lua: Skill 14795 quality -> 4 (UR)")

with open(SKILL_LUA, 'w', encoding='utf-8') as f:
    f.write(sk_content)

# 3. Update web/src/h5_patch.lua
HP_LUA = r"D:\yugitauapk\web\src\h5_patch.lua"
with open(HP_LUA, 'r', encoding='utf-8') as f:
    hp_content = f.read()

# Enderman in h5_patch
hp_target = """					_py = "enderman",
					_quality = 3,"""
hp_repl = """					_py = "enderman",
					_quality = 4,"""

hp_target2 = """			if Data._monsterInfo and Data._monsterInfo[12338] then
				Data._monsterInfo[12338]._quality = 3"""
hp_repl2 = """			if Data._monsterInfo and Data._monsterInfo[12338] then
				Data._monsterInfo[12338]._quality = 4"""

if hp_target in hp_content:
    hp_content = hp_content.replace(hp_target, hp_repl, 1)
    print("[OK] Updated h5_patch.lua initial _quality for Enderman")
else:
    # try CRLF
    hp_target_crlf = hp_target.replace('\n', '\r\n')
    if hp_target_crlf in hp_content:
        hp_content = hp_content.replace(hp_target_crlf, hp_repl.replace('\n', '\r\n'), 1)
        print("[OK] Updated h5_patch.lua (CRLF) initial _quality for Enderman")

if hp_target2 in hp_content:
    hp_content = hp_content.replace(hp_target2, hp_repl2, 1)
    print("[OK] Updated h5_patch.lua override _quality for Enderman")
else:
    hp_target2_crlf = hp_target2.replace('\n', '\r\n')
    if hp_target2_crlf in hp_content:
        hp_content = hp_content.replace(hp_target2_crlf, hp_repl2.replace('\n', '\r\n'), 1)
        print("[OK] Updated h5_patch.lua (CRLF) override _quality for Enderman")

# Skills 14794 & 14795 in h5_patch
sk_patch_target = """			-- Skill 14794
			if Data._skillInfo and not Data._skillInfo[14794] then
				Data._skillInfo[14794] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57333, _effectVal = { 0 }, _id = 14794, _isIgnoreDefend = 0, _modes = { 34 }, _nameSid = 57332, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 3, _refCards = { 304 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
			end
			-- Skill 14795
			if Data._skillInfo and not Data._skillInfo[14795] then
				Data._skillInfo[14795] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57335, _effectVal = { 0 }, _id = 14795, _isIgnoreDefend = 1, _modes = { 2 }, _nameSid = 57334, _needExtraGem = 0, _needNoGem = 0, _option = { 1 }, _priority = 1, _quality = 3, _refCards = { 0 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
			end"""

sk_patch_repl = """			-- Skill 14794
			if Data._skillInfo and not Data._skillInfo[14794] then
				Data._skillInfo[14794] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57333, _effectVal = { 0 }, _id = 14794, _isIgnoreDefend = 0, _modes = { 34 }, _nameSid = 57332, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 4, _refCards = { 304 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
			end
			if Data._skillInfo and Data._skillInfo[14794] then
				Data._skillInfo[14794]._quality = 4
			end
			-- Skill 14795
			if Data._skillInfo and not Data._skillInfo[14795] then
				Data._skillInfo[14795] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57335, _effectVal = { 0 }, _id = 14795, _isIgnoreDefend = 1, _modes = { 2 }, _nameSid = 57334, _needExtraGem = 0, _needNoGem = 0, _option = { 1 }, _priority = 1, _quality = 4, _refCards = { 0 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
			end
			if Data._skillInfo and Data._skillInfo[14795] then
				Data._skillInfo[14795]._quality = 4
			end"""

if sk_patch_target in hp_content:
    hp_content = hp_content.replace(sk_patch_target, sk_patch_repl, 1)
    print("[OK] Updated h5_patch.lua for Skills 14794 & 14795 quality")
else:
    sk_patch_target_crlf = sk_patch_target.replace('\n', '\r\n')
    if sk_patch_target_crlf in hp_content:
        hp_content = hp_content.replace(sk_patch_target_crlf, sk_patch_repl.replace('\n', '\r\n'), 1)
        print("[OK] Updated h5_patch.lua (CRLF) for Skills 14794 & 14795 quality")

with open(HP_LUA, 'w', encoding='utf-8') as f:
    f.write(hp_content)

# 4. Update MySQL database
conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='',
    database='yugioh_game',
    charset='utf8mb4',
    autocommit=True
)
cur = conn.cursor(pymysql.cursors.DictCursor)
cur.execute("UPDATE card_monsters SET quality = 'UR' WHERE id = 12338")
print(f"[OK] MySQL card_monsters updated rows: {cur.rowcount}")

cur.execute("SELECT id, name, category, quality, stars, atk, def FROM card_monsters WHERE id = 12338")
row = cur.fetchone()
print(f"[VERIFY] MySQL row: {row}")
conn.close()

print("[COMPLETE] All Enderman UR updates applied successfully!")
