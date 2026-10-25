import os, sys, re

sys.stdout.reconfigure(encoding='utf-8')

# 1. web/src/Data.lua
DATA_LUA = r"D:\yugitauapk\web\src\Data.lua"
with open(DATA_LUA, 'r', encoding='utf-8') as f:
    data_content = f.read()

# Add minecraft = 304 to CardKeyword
if 'minecraft = 304' not in data_content:
    data_content = data_content.replace('liqi = 303\n}', 'liqi = 303,\n\tminecraft = 304\n}')
    print("[OK] Data.lua updated with minecraft = 304")
else:
    print("[SKIP] Data.lua already has minecraft = 304")

# Add 14792 to monster4Halo in getSkillType
if 'arg_13_0 == 14792' not in data_content:
    target_st = 'arg_13_0 == 14788 or arg_13_0 == 14790 then'
    repl_st = 'arg_13_0 == 14788 or arg_13_0 == 14790 or arg_13_0 == 14792 then'
    if target_st in data_content:
        data_content = data_content.replace(target_st, repl_st, 1)
        print("[OK] Data.lua getSkillType updated with skill 14792")
    else:
        print("[ERR] target_st not found in Data.lua")
else:
    print("[SKIP] Data.lua getSkillType already has 14792")

with open(DATA_LUA, 'w', encoding='utf-8') as f:
    f.write(data_content)

# 2. web/src/CardInfoWidget.lua
CIW_LUA = r"D:\yugitauapk\web\src\CardInfoWidget.lua"
with open(CIW_LUA, 'r', encoding='utf-8') as f:
    ciw_content = f.read()

if 'var_9_4._keyword == 304' not in ciw_content:
    target_ciw = 'elseif var_9_4._keyword == 303 then\n\t\tkwStr = "liqi"'
    repl_ciw = 'elseif var_9_4._keyword == 303 then\n\t\tkwStr = "liqi"\n\telseif var_9_4._keyword == 304 then\n\t\tkwStr = "minecraft"'
    if target_ciw in ciw_content:
        ciw_content = ciw_content.replace(target_ciw, repl_ciw, 1)
        with open(CIW_LUA, 'w', encoding='utf-8') as f:
            f.write(ciw_content)
        print("[OK] CardInfoWidget.lua updated with keyword 304 -> minecraft")
    else:
        print("[ERR] target_ciw not found in CardInfoWidget.lua")
else:
    print("[SKIP] CardInfoWidget.lua already has keyword 304")

# 3. web/src/DescForm.lua
DESC_LUA = r"D:\yugitauapk\web\src\DescForm.lua"
with open(DESC_LUA, 'r', encoding='utf-8') as f:
    desc_content = f.read()

if 'iter_4_5 == 304' not in desc_content:
    target_desc = '(iter_4_5 == 303 and "liqi") or Str(STR.CARD_KEYWORD_BEGIN + iter_4_5))'
    repl_desc = '(iter_4_5 == 303 and "liqi") or (iter_4_5 == 304 and "minecraft") or Str(STR.CARD_KEYWORD_BEGIN + iter_4_5))'
    if target_desc in desc_content:
        desc_content = desc_content.replace(target_desc, repl_desc, 1)
        with open(DESC_LUA, 'w', encoding='utf-8') as f:
            f.write(desc_content)
        print("[OK] DescForm.lua updated with keyword 304 -> minecraft")
    else:
        print("[ERR] target_desc not found in DescForm.lua")
else:
    print("[SKIP] DescForm.lua already has keyword 304")

# 4. web/src/Player.lua
PLAYER_LUA = r"D:\yugitauapk\web\src\Player.lua"
with open(PLAYER_LUA, 'r', encoding='utf-8') as f:
    player_content = f.read()

if 'var_67_1._keyword == 304' not in player_content:
    target_player = '(var_67_1._keyword == 302 and "Hiệp sĩ mặt nạ") or Str(STR.CARD_KEYWORD_BEGIN + var_67_1._keyword))'
    repl_player = '(var_67_1._keyword == 302 and "Hiệp sĩ mặt nạ") or (var_67_1._keyword == 303 and "liqi") or (var_67_1._keyword == 304 and "minecraft") or Str(STR.CARD_KEYWORD_BEGIN + var_67_1._keyword))'
    if target_player in player_content:
        player_content = player_content.replace(target_player, repl_player, 1)
        with open(PLAYER_LUA, 'w', encoding='utf-8') as f:
            f.write(player_content)
        print("[OK] Player.lua updated with keyword 304 -> minecraft")
    else:
        print("[ERR] target_player not found in Player.lua")
else:
    print("[SKIP] Player.lua already has keyword 304")

# 5. web/src/PlayerBattle.lua
PB_LUA = r"D:\yugitauapk\web\src\PlayerBattle.lua"
with open(PB_LUA, 'r', encoding='utf-8') as f:
    pb_content = f.read()

target_pb = """		local var_50_kysi = arg_50_0:getBattleCardsByInfoId("R", 40746)[1]

		if var_50_kysi ~= nil then
			local var_50_sk = var_50_kysi:getSkillById(14788)

			if var_50_sk then
				var_50_8[#var_50_8 + 1] = var_50_sk
			end
		end"""

repl_pb = """		local var_50_kysi = arg_50_0:getBattleCardsByInfoId("R", 40746)[1]

		if var_50_kysi ~= nil then
			local var_50_sk = var_50_kysi:getSkillById(14788)

			if var_50_sk then
				var_50_8[#var_50_8 + 1] = var_50_sk
			end
		end

		local var_50_creepers = arg_50_0:getBattleCardsByInfoId("B", 12337)
		for iter_creeper = 1, #var_50_creepers do
			local var_creeper_sk = var_50_creepers[iter_creeper]:getSkillById(14792)
			if var_creeper_sk then
				var_50_8[#var_50_8 + 1] = var_creeper_sk
			end
		end"""

if '12337' not in pb_content:
    if target_pb in pb_content:
        pb_content = pb_content.replace(target_pb, repl_pb, 1)
        with open(PB_LUA, 'w', encoding='utf-8') as f:
            f.write(pb_content)
        print("[OK] PlayerBattle.lua updated with Creeper 12337 trigger check")
    else:
        target_pb_crlf = target_pb.replace('\n', '\r\n')
        repl_pb_crlf = repl_pb.replace('\n', '\r\n')
        if target_pb_crlf in pb_content:
            pb_content = pb_content.replace(target_pb_crlf, repl_pb_crlf, 1)
            with open(PB_LUA, 'w', encoding='utf-8') as f:
                f.write(pb_content)
            print("[OK] PlayerBattle.lua (CRLF) updated with Creeper 12337 trigger check")
        else:
            print("[ERR] target_pb not found in PlayerBattle.lua")
else:
    print("[SKIP] PlayerBattle.lua already has 12337")

# 6. web/src/BattleSkill.lua
BS_LUA = r"D:\yugitauapk\web\src\BattleSkill.lua"
with open(BS_LUA, 'r', encoding='utf-8') as f:
    bs_content = f.read()

creeper_bs_skill = """	elseif var_8_4 == 14792 then
		if var_8_1._status == BattleData.CardStatus.board and arg_8_1._owner == var_8_1._owner._opponent and arg_8_1:isMonster() then
			local oppoOwner = arg_8_1._owner or var_8_8
			local oppoPos = arg_8_1._pos
			local creeperOwner = var_8_1._owner

			if arg_8_1.resetBuffByType then
				if BattleData.PositiveType.shieldMonster then arg_8_1:resetBuffByType(true, BattleData.PositiveType.shieldMonster) end
				if BattleData.PositiveType.shieldExMonster then arg_8_1:resetBuffByType(true, BattleData.PositiveType.shieldExMonster) end
				if BattleData.PositiveType.shieldHaloMonster then arg_8_1:resetBuffByType(true, BattleData.PositiveType.shieldHaloMonster) end
				if BattleData.PositiveType.shieldOppoMonster then arg_8_1:resetBuffByType(true, BattleData.PositiveType.shieldOppoMonster) end
				if BattleData.PositiveType.shieldHaloOppoMonster then arg_8_1:resetBuffByType(true, BattleData.PositiveType.shieldHaloOppoMonster) end
			end
			arg_8_1._shields = arg_8_1._shields or {}
			arg_8_1._shields[12008] = nil
			arg_8_1._shields[11008] = nil
			arg_8_1._markIgnoreOppoShield = true

			oppoOwner:setCardStatus(arg_8_1, BattleData.CardStatus.grave, var_8_5, var_8_4, arg_8_3, BattleData.CardStatusVal.b2g_kill)
			creeperOwner:setCardStatus(var_8_1, BattleData.CardStatus.grave, var_8_5, var_8_4, arg_8_3, BattleData.CardStatusVal.b2g_kill)

			if oppoPos and oppoPos >= 1 and oppoPos <= 6 then
				arg_8_0:incNegativeStatus(oppoOwner._fortress, {
					BattleData.NegativeType.boardLock
				}, false, var_8_5, var_8_4, arg_8_3)
				arg_8_0:incNegativeValue(oppoOwner._fortress, BattleData.NegativeType.boardLock, oppoPos, Data.AggregateType.table, var_8_5, var_8_4, arg_8_3)
			end

			var_8_13 = true
		end
"""

if 'var_8_4 == 14792' not in bs_content:
    target_bs = '	elseif var_8_4 == 14256 then'
    if target_bs in bs_content:
        bs_content = bs_content.replace(target_bs, creeper_bs_skill + target_bs, 1)
        with open(BS_LUA, 'w', encoding='utf-8') as f:
            f.write(bs_content)
        print("[OK] BattleSkill.lua updated with skill 14792 logic")
    else:
        target_bs_crlf = target_bs.replace('\n', '\r\n')
        if target_bs_crlf in bs_content:
            bs_content = bs_content.replace(target_bs_crlf, creeper_bs_skill.replace('\n', '\r\n') + target_bs_crlf, 1)
            with open(BS_LUA, 'w', encoding='utf-8') as f:
                f.write(bs_content)
            print("[OK] BattleSkill.lua (CRLF) updated with skill 14792 logic")
        else:
            print("[ERR] target_bs not found in BattleSkill.lua")
else:
    print("[SKIP] BattleSkill.lua already has 14792")

# 7. web/src/h5_patch.lua
HP_LUA = r"D:\yugitauapk\web\src\h5_patch.lua"
with open(HP_LUA, 'r', encoding='utf-8') as f:
    hp_content = f.read()

h5_patch_creeper = """
			if Data._monsterInfo and not Data._monsterInfo[12337] then
				Data._monsterInfo[12337] = {
					_atk = { 1200 },
					_attackEffect = 1,
					_available = 1,
					_bgId = 0,
					_briefNameSid = 57321,
					_category = 17,
					_cost = 0,
					_descSid = 57320,
					_guideSid = 0,
					_hp = { 1000 },
					_id = 12337,
					_isHide = 0,
					_joinResult = { 0 },
					_keyword = 304,
					_maxCount = 3,
					_nameSid = 57319,
					_nature = 2,
					_option = 2,
					_originId = 0,
					_packageId = { 0 },
					_picId = 0,
					_py = "creeper",
					_quality = 3,
					_recruitable = 1,
					_skillId = { 14792 },
					_skin = { 0 },
					_star = 3,
					_syncComponent = { { 0 } }
				}
			end
			if Data._monsterInfo and Data._monsterInfo[12337] then
				Data._monsterInfo[12337]._quality = 3
				Data._monsterInfo[12337]._keyword = 304
				Data._monsterInfo[12337]._nameSid = 57319
				Data._monsterInfo[12337]._descSid = 57320
				Data._monsterInfo[12337]._briefNameSid = 57321
				Data._monsterInfo[12337]._skillId = { 14792 }
			end
			if Data._skillInfo and not Data._skillInfo[14792] then
				Data._skillInfo[14792] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57323, _effectVal = { 0 }, _id = 14792, _isIgnoreDefend = 1, _modes = { 132, 134 }, _nameSid = 57322, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 1, _quality = 3, _refCards = { 0 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
			end
			if Data._skillInfo and Data._skillInfo[14792] then
				Data._skillInfo[14792]._nameSid = 57322
				Data._skillInfo[14792]._descSid = 57323
			end
"""

if 'Data._monsterInfo[12337]' not in hp_content:
    target_hp = 'Data._rareInfo[40746]._briefNameSid = 57310\n\t\t\tend'
    if target_hp in hp_content:
        hp_content = hp_content.replace(target_hp, target_hp + h5_patch_creeper, 1)
        with open(HP_LUA, 'w', encoding='utf-8') as f:
            f.write(hp_content)
        print("[OK] h5_patch.lua updated with Creeper 12337 and skill 14792")
    else:
        target_hp_crlf = target_hp.replace('\n', '\r\n')
        if target_hp_crlf in hp_content:
            hp_content = hp_content.replace(target_hp_crlf, target_hp_crlf + h5_patch_creeper.replace('\n', '\r\n'), 1)
            with open(HP_LUA, 'w', encoding='utf-8') as f:
                f.write(hp_content)
            print("[OK] h5_patch.lua (CRLF) updated with Creeper 12337 and skill 14792")
        else:
            print("[ERR] target_hp not found in h5_patch.lua")
else:
    print("[SKIP] h5_patch.lua already has 12337")

# 8. web/data/monster.lua
MON_LUA = r"D:\yugitauapk\web\data\monster.lua"
with open(MON_LUA, 'r', encoding='utf-8') as f:
    mon_content = f.read()

creeper_mon_str = """  [12337]={["_atk"]={[1]=1200,},
  ["_attackEffect"]=1,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=57321,["_category"]=17,["_cost"]=0,["_descSid"]=57320,["_guideSid"]=0,["_hp"]={[1]=1000,},
  ["_id"]=12337,["_isHide"]=0,["_joinResult"]={[1]=0,},
  ["_keyword"]=304,["_maxCount"]=3,["_nameSid"]=57319,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="creeper",["_quality"]=3,["_recruitable"]=1,["_skillId"]={[1]=14792,},
  ["_skin"]={[1]=0,},
  ["_star"]=3,},
"""

if '[12337]=' not in mon_content:
    last_brace = mon_content.rfind('}')
    if last_brace != -1:
        mon_content = mon_content[:last_brace] + creeper_mon_str + mon_content[last_brace:]
        with open(MON_LUA, 'w', encoding='utf-8') as f:
            f.write(mon_content)
        print("[OK] Added card 12337 to monster.lua")
    else:
        print("[ERR] last_brace not found in monster.lua")
else:
    print("[SKIP] monster.lua already has 12337")

# 9. web/data/skill.lua
SKILL_LUA = r"D:\yugitauapk\web\data\skill.lua"
with open(SKILL_LUA, 'r', encoding='utf-8') as f:
    sk_content = f.read()

creeper_sk_str = """  [14792]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57323,["_effectVal"]={[1]=0,},
  ["_id"]=14792,["_isIgnoreDefend"]=1,["_modes"]={[1]=132,[2]=134,},
  ["_nameSid"]=57322,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=1,["_quality"]=3,["_refCards"]={[1]=0,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
"""

if '[14792]=' not in sk_content:
    last_brace = sk_content.rfind('}')
    if last_brace != -1:
        sk_content = sk_content[:last_brace] + creeper_sk_str + sk_content[last_brace:]
        with open(SKILL_LUA, 'w', encoding='utf-8') as f:
            f.write(sk_content)
        print("[OK] Added skill 14792 to skill.lua")
    else:
        print("[ERR] last_brace not found in skill.lua")
else:
    print("[SKIP] skill.lua already has 14792")

# 10. web/data/diamond_products.lua
DIA_LUA = r"D:\yugitauapk\web\data\diamond_products.lua"
with open(DIA_LUA, 'r', encoding='utf-8') as f:
    dia_content = f.read()

diamond_550_str = '  [550]={["_cardId"]=12337,["_cost"]=10000,["_date"]="20240101.0",["_id"]=550,["_resType"]=3,["_type"]=0,},\n'
if '[550]=' not in dia_content and '12337' not in dia_content:
    last_brace = dia_content.rfind('}')
    if last_brace != -1:
        dia_content = dia_content[:last_brace] + diamond_550_str + dia_content[last_brace:]
        with open(DIA_LUA, 'w', encoding='utf-8') as f:
            f.write(dia_content)
        print("[OK] Updated diamond_products.lua with product 550 (card 12337)")
else:
    print("[SKIP] diamond_products.lua already has product for 12337")

# 11. web/data/privilege_products.lua
PRIV_LUA = r"D:\yugitauapk\web\data\privilege_products.lua"
with open(PRIV_LUA, 'r', encoding='utf-8') as f:
    priv_content = f.read()

privilege_18_str = '  [18]={["_cardId"]=12337,["_cost"]=10000,["_date"]="20240101.0",["_id"]=18,["_resType"]=3,},\n'
if '[18]=' not in priv_content and '12337' not in priv_content:
    last_brace = priv_content.rfind('}')
    if last_brace != -1:
        priv_content = priv_content[:last_brace] + privilege_18_str + priv_content[last_brace:]
        with open(PRIV_LUA, 'w', encoding='utf-8') as f:
            f.write(priv_content)
        print("[OK] Updated privilege_products.lua with product 18 (card 12337)")
else:
    print("[SKIP] privilege_products.lua already has product for 12337")

print("[OK] All Lua files deployed successfully!")
