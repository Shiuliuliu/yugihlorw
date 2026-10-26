import os, sys, re

sys.stdout.reconfigure(encoding='utf-8')

# 1. web/data/monster.lua (12339 Ender Dragon, 12340 Trung Rong Ender)
MON_LUA = r"D:\yugitauapk\web\data\monster.lua"
with open(MON_LUA, 'r', encoding='utf-8') as f:
    mon_content = f.read()

new_monsters_str = """  [12339]={["_atk"]={[1]=4500,},
  ["_attackEffect"]=1,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=57343,["_category"]=2,["_cost"]=0,["_descSid"]=57342,["_guideSid"]=0,["_hp"]={[1]=4500,},
  ["_id"]=12339,["_isHide"]=0,["_joinResult"]={[1]=0,},
  ["_keyword"]=304,["_maxCount"]=3,["_nameSid"]=57341,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="enderdragon",["_quality"]=5,["_recruitable"]=1,["_skillId"]={[1]=3043,[2]=14798,[3]=14799,},
  ["_skin"]={[1]=0,},
  ["_star"]=10,},
  [12340]={["_atk"]={[1]=0,},
  ["_attackEffect"]=1,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=57369,["_category"]=2,["_cost"]=0,["_descSid"]=57368,["_guideSid"]=0,["_hp"]={[1]=0,},
  ["_id"]=12340,["_isHide"]=0,["_joinResult"]={[1]=0,},
  ["_keyword"]=304,["_maxCount"]=3,["_nameSid"]=57367,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="trungrongender",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=12006,[2]=14804,},
  ["_skin"]={[1]=0,},
  ["_star"]=1,},
"""

if '[12339]=' not in mon_content:
    last_brace = mon_content.rfind('}')
    if last_brace != -1:
        mon_content = mon_content[:last_brace] + new_monsters_str + mon_content[last_brace:]
        with open(MON_LUA, 'w', encoding='utf-8') as f:
            f.write(mon_content)
        print("[OK] Added 12339 & 12340 to monster.lua")
    else:
        print("[ERR] last_brace not found in monster.lua")
else:
    print("[SKIP] monster.lua already has 12339")

# 2. web/data/magic.lua (21148 Command Block, 21149 Tao Vang)
MAGIC_LUA = r"D:\yugitauapk\web\data\magic.lua"
with open(MAGIC_LUA, 'r', encoding='utf-8') as f:
    mag_content = f.read()

new_magic_str = """  [21148]={["_available"]=1,["_briefNameSid"]=57350,["_descSid"]=57349,["_guideSid"]=0,["_id"]=21148,["_isHide"]=0,["_isSummon"]=0,["_keyword"]=304,["_maxCount"]=3,["_nameSid"]=57348,["_option"]=1,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="commandblock",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=14800,},
  ["_targetType"]=0,["_type"]=11,},
  [21149]={["_available"]=1,["_briefNameSid"]=57362,["_descSid"]=57361,["_guideSid"]=0,["_id"]=21149,["_isHide"]=0,["_isSummon"]=0,["_keyword"]=304,["_maxCount"]=3,["_nameSid"]=57360,["_option"]=1,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="taovang",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=14803,[2]=14797,[3]=9232,},
  ["_targetType"]=0,["_type"]=11,},
"""

if '[21148]=' not in mag_content:
    last_brace = mag_content.rfind('}')
    if last_brace != -1:
        mag_content = mag_content[:last_brace] + new_magic_str + mag_content[last_brace:]
        with open(MAGIC_LUA, 'w', encoding='utf-8') as f:
            f.write(mag_content)
        print("[OK] Added 21148 & 21149 to magic.lua")
    else:
        print("[ERR] last_brace not found in magic.lua")
else:
    print("[SKIP] magic.lua already has 21148")

# 3. web/data/trap.lua (30596 Totem)
TRAP_LUA = r"D:\yugitauapk\web\data\trap.lua"
with open(TRAP_LUA, 'r', encoding='utf-8') as f:
    trap_content = f.read()

new_trap_str = """  [30596]={["_available"]=1,["_briefNameSid"]=57355,["_descSid"]=57354,["_guideSid"]=0,["_id"]=30596,["_isHide"]=0,["_isSummon"]=0,["_keyword"]=304,["_maxCount"]=3,["_nameSid"]=57353,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="totem",["_quality"]=4,["_recruitable"]=1,["_skillId"]={[1]=14801,[2]=14802,},
  ["_targetType"]=0,["_type"]=13,},
"""

if '[30596]=' not in trap_content:
    last_brace = trap_content.rfind('}')
    if last_brace != -1:
        trap_content = trap_content[:last_brace] + new_trap_str + trap_content[last_brace:]
        with open(TRAP_LUA, 'w', encoding='utf-8') as f:
            f.write(trap_content)
        print("[OK] Added 30596 to trap.lua")
    else:
        print("[ERR] last_brace not found in trap.lua")
else:
    print("[SKIP] trap.lua already has 30596")

# 4. web/data/skill.lua (Skills 14797..14804)
SKILL_LUA = r"D:\yugitauapk\web\data\skill.lua"
with open(SKILL_LUA, 'r', encoding='utf-8') as f:
    sk_content = f.read()

new_skills_str = """  [14797]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57366,["_effectVal"]={[1]=0,},
  ["_id"]=14797,["_isIgnoreDefend"]=0,["_modes"]={[1]=91,[2]=41,},
  ["_nameSid"]=57365,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=0,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=400,},},
  [14798]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57345,["_effectVal"]={[1]=0,},
  ["_id"]=14798,["_isIgnoreDefend"]=0,["_modes"]={[1]=34,},
  ["_nameSid"]=57344,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=0,["_quality"]=5,["_refCards"]={[1]=304,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
  [14799]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57347,["_effectVal"]={[1]=0,},
  ["_id"]=14799,["_isIgnoreDefend"]=1,["_modes"]={[1]=24,},
  ["_nameSid"]=57346,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=0,["_quality"]=5,["_refCards"]={[1]=0,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
  [14800]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57352,["_effectVal"]={[1]=0,},
  ["_id"]=14800,["_isIgnoreDefend"]=0,["_modes"]={[1]=31,},
  ["_nameSid"]=57351,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},
  ["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=304,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=1,},},
  [14801]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57357,["_effectVal"]={[1]=0,},
  ["_id"]=14801,["_isIgnoreDefend"]=1,["_modes"]={[1]=24,},
  ["_nameSid"]=57356,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},
  ["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=304,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
  [14802]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57359,["_effectVal"]={[1]=0,},
  ["_id"]=14802,["_isIgnoreDefend"]=0,["_modes"]={[1]=34,},
  ["_nameSid"]=57358,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},
  ["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=304,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=1000,},},
  [14803]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57364,["_effectVal"]={[1]=0,},
  ["_id"]=14803,["_isIgnoreDefend"]=0,["_modes"]={[1]=31,},
  ["_nameSid"]=57363,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=0,["_quality"]=4,["_refCards"]={[1]=0,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=3000,},},
  [14804]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57371,["_effectVal"]={[1]=0,},
  ["_id"]=14804,["_isIgnoreDefend"]=1,["_modes"]={[1]=33,},
  ["_nameSid"]=57370,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},
  ["_priority"]=1,["_quality"]=4,["_refCards"]={[1]=12339,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
"""

if '[14797]=' not in sk_content:
    last_brace = sk_content.rfind('}')
    if last_brace != -1:
        sk_content = sk_content[:last_brace] + new_skills_str + sk_content[last_brace:]
        with open(SKILL_LUA, 'w', encoding='utf-8') as f:
            f.write(sk_content)
        print("[OK] Added skills 14797-14804 to skill.lua")
    else:
        print("[ERR] last_brace not found in skill.lua")
else:
    print("[SKIP] skill.lua already has 14797")

# 5. web/data/diamond_products.lua
DIA_LUA = r"D:\yugitauapk\web\data\diamond_products.lua"
with open(DIA_LUA, 'r', encoding='utf-8') as f:
    dia_content = f.read()

diamond_extra_str = """  [553]={["_cardId"]=12339,["_cost"]=10000,["_date"]="20240101.0",["_id"]=553,["_resType"]=3,["_type"]=0,},
  [554]={["_cardId"]=21148,["_cost"]=10000,["_date"]="20240101.0",["_id"]=554,["_resType"]=3,["_type"]=0,},
  [555]={["_cardId"]=30596,["_cost"]=10000,["_date"]="20240101.0",["_id"]=555,["_resType"]=3,["_type"]=0,},
  [556]={["_cardId"]=21149,["_cost"]=10000,["_date"]="20240101.0",["_id"]=556,["_resType"]=3,["_type"]=0,},
  [557]={["_cardId"]=12340,["_cost"]=10000,["_date"]="20240101.0",["_id"]=557,["_resType"]=3,["_type"]=0,},
"""
if '[553]=' not in dia_content:
    last_brace = dia_content.rfind('}')
    if last_brace != -1:
        dia_content = dia_content[:last_brace] + diamond_extra_str + dia_content[last_brace:]
        with open(DIA_LUA, 'w', encoding='utf-8') as f:
            f.write(dia_content)
        print("[OK] Updated diamond_products.lua with products 553-557")
else:
    print("[SKIP] diamond_products.lua already has product 553")

# 6. web/src/Data.lua
DATA_LUA = r"D:\yugitauapk\web\src\Data.lua"
with open(DATA_LUA, 'r', encoding='utf-8') as f:
    data_content = f.read()

# Route 14798 and 14804 to monsterSpell
if 'arg_13_0 == 14798' not in data_content:
    target_data_spell = 'or arg_13_0 == 14794 then'
    repl_data_spell = 'or arg_13_0 == 14794 or arg_13_0 == 14798 or arg_13_0 == 14804 then'
    if target_data_spell in data_content:
        data_content = data_content.replace(target_data_spell, repl_data_spell, 1)
        with open(DATA_LUA, 'w', encoding='utf-8') as f:
            f.write(data_content)
        print("[OK] Data.lua monsterSpell routing updated for 14798, 14804")
    else:
        print("[ERR] target_data_spell not found in Data.lua")
else:
    print("[SKIP] Data.lua already has 14798")

# 7. web/src/BattleSkill.lua
BS_LUA = r"D:\yugitauapk\web\src\BattleSkill.lua"
with open(BS_LUA, 'r', encoding='utf-8') as f:
    bs_content = f.read()

# monsterSpell whitelist at line 364
if 'arg_1_2._id == 14798' not in bs_content:
    target_bs_spell = 'or arg_1_2._id == 14794'
    repl_bs_spell = 'or arg_1_2._id == 14794 or arg_1_2._id == 14798 or arg_1_2._id == 14804'
    if target_bs_spell in bs_content:
        bs_content = bs_content.replace(target_bs_spell, repl_bs_spell, 1)
        print("[OK] BattleSkill.lua line 364 updated with 14798, 14804")
    else:
        print("[ERR] target_bs_spell not found in BattleSkill.lua")

# canUseInitiativeSkill4 check
bs_canuse_skills = """	elseif var_40_0 == 14798 then
		if arg_40_1._status ~= BattleData.CardStatus.hand then
			return false
		end
		local pOwner = arg_40_1._owner or arg_40_0
		if pOwner._isSummonDisabled or pOwner._isSpecialSummonDisabled then
			return false
		end
		if pOwner:getEmptyBoardPos(arg_40_1) == nil then
			return false
		end
		local count = 0
		for _, c in ipairs(pOwner:getBattleCards("G")) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster) and (c:isKeyword(304) or (c._info and c._info._keyword == 304)) then
				count = count + 1
			end
		end
		if count < 5 then
			return false
		end
		return #pOwner:filterCanChangeToBoardCards({ arg_40_1 }) > 0
	elseif var_40_0 == 14804 then
		if arg_40_1._status ~= BattleData.CardStatus.board then
			return false
		end
		local pOwner = arg_40_1._owner or arg_40_0
		if (pOwner._castedSkillCounts and pOwner._castedSkillCounts[14804] and pOwner._castedSkillCounts[14804] >= 1) then
			return false
		end
		if pOwner._isSummonDisabled or pOwner._isSpecialSummonDisabled then
			return false
		end
		local hasTarget = false
		for _, c in ipairs(pOwner._pileCards) do
			if c._infoId == 12339 or c:isInfoId(12339) then
				hasTarget = true
				break
			end
		end
		if not hasTarget then
			for _, c in ipairs(pOwner._handCards) do
				if c._infoId == 12339 or c:isInfoId(12339) then
					hasTarget = true
					break
				end
			end
		end
		if not hasTarget then
			for _, c in ipairs(pOwner._graveCards) do
				if c._infoId == 12339 or c:isInfoId(12339) then
					hasTarget = true
					break
				end
			end
		end
		return hasTarget
"""

if 'var_40_0 == 14798' not in bs_content:
    target_bs_canuse = '	elseif var_40_0 == 14793 then'
    if target_bs_canuse in bs_content:
        bs_content = bs_content.replace(target_bs_canuse, bs_canuse_skills + target_bs_canuse, 1)
        print("[OK] BattleSkill.lua canUseInitiativeSkill4 updated for 14798, 14804")
    else:
        target_bs_canuse_crlf = target_bs_canuse.replace('\n', '\r\n')
        if target_bs_canuse_crlf in bs_content:
            bs_content = bs_content.replace(target_bs_canuse_crlf, bs_canuse_skills.replace('\n', '\r\n') + target_bs_canuse_crlf, 1)
            print("[OK] BattleSkill.lua (CRLF) canUseInitiativeSkill4 updated for 14798, 14804")
        else:
            print("[ERR] target_bs_canuse not found in BattleSkill.lua")

# castMonsterSpellSkill execution
bs_cast_skills = """	elseif var_4_4 == 14798 then
		local ownerCard = var_4_1 or arg_4_1
		local pOwner = (ownerCard and ownerCard._owner) or arg_4_0
		if arg_4_3 == Data.SkillMode.initiative_hand or arg_4_1._status == BattleData.CardStatus.hand then
			local emptyPos = pOwner:getEmptyBoardPos(arg_4_1)
			if emptyPos then
				pOwner:setCardStatus(arg_4_1, BattleData.CardStatus.board, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.h2b_special, emptyPos)
				var_4_13 = true
			end
		end
	elseif var_4_4 == 14804 then
		local ownerCard = var_4_1 or arg_4_1
		local pOwner = (ownerCard and ownerCard._owner) or arg_4_0
		pOwner._castedSkillCounts[14804] = (pOwner._castedSkillCounts[14804] or 0) + 1
		arg_4_0._castedSkillCounts[14804] = (arg_4_0._castedSkillCounts[14804] or 0) + 1

		local emptyPos = ownerCard._pos
		pOwner:setCardStatus(ownerCard, BattleData.CardStatus.grave, ownerCard._id, 14804, arg_4_3, BattleData.CardStatusVal.b2g_sacrifice)

		local targetCard = nil
		if var_4_15 > 0 and pOwner then
			local cid = var_4_15 % BattleData.UseCardId.id_group
			targetCard = pOwner:getCardById(cid) or pOwner:getCardById(var_4_15)
		end
		if targetCard == nil or not (targetCard._infoId == 12339 or targetCard:isInfoId(12339)) then
			for _, c in ipairs(pOwner._pileCards) do
				if c._infoId == 12339 or c:isInfoId(12339) then targetCard = c break end
			end
			if targetCard == nil then
				for _, c in ipairs(pOwner._handCards) do
					if c._infoId == 12339 or c:isInfoId(12339) then targetCard = c break end
				end
			end
			if targetCard == nil then
				for _, c in ipairs(pOwner._graveCards) do
					if c._infoId == 12339 or c:isInfoId(12339) then targetCard = c break end
				end
			end
		end

		if targetCard then
			local targetPos = pOwner:getEmptyBoardPos(targetCard) or emptyPos
			local sVal = BattleData.CardStatusVal.h2b_special
			if targetCard._status == BattleData.CardStatus.pile then
				sVal = BattleData.CardStatusVal.p2b_special
			elseif targetCard._status == BattleData.CardStatus.grave then
				sVal = BattleData.CardStatusVal.g2b_special
			end
			pOwner:setCardStatus(targetCard, BattleData.CardStatus.board, ownerCard._id, 14804, arg_4_3, sVal, targetPos)
		end

		pOwner._isSpecialSummonDisabledBy14804 = true
		var_4_13 = true
"""

if 'var_4_4 == 14798' not in bs_content:
    target_bs_cast = '	elseif var_4_4 == 14793 then'
    if target_bs_cast in bs_content:
        bs_content = bs_content.replace(target_bs_cast, bs_cast_skills + target_bs_cast, 1)
        print("[OK] BattleSkill.lua castMonsterSpellSkill updated for 14798, 14804")
    else:
        target_bs_cast_crlf = target_bs_cast.replace('\n', '\r\n')
        if target_bs_cast_crlf in bs_content:
            bs_content = bs_content.replace(target_bs_cast_crlf, bs_cast_skills.replace('\n', '\r\n') + target_bs_cast_crlf, 1)
            print("[OK] BattleSkill.lua (CRLF) castMonsterSpellSkill updated for 14798, 14804")
        else:
            print("[ERR] target_bs_cast not found in BattleSkill.lua")

# 14797 support in 3081 graveyard heal
if 'var_4_4 == 3081 or var_4_4 == 14797' not in bs_content:
    target_bs_3081 = 'elseif var_4_4 == 3081 then'
    repl_bs_3081 = 'elseif var_4_4 == 3081 or var_4_4 == 14797 then'
    if target_bs_3081 in bs_content:
        bs_content = bs_content.replace(target_bs_3081, repl_bs_3081, 1)
        print("[OK] BattleSkill.lua 3081 check updated with 14797")
    else:
        print("[ERR] target_bs_3081 not found in BattleSkill.lua")

# castOtherSkill whitelist (line ~20000)
if 'arg_1_2._id ~= 14800' not in bs_content:
    target_bs_other_wl = 'arg_1_2._id ~= 14749 and'
    repl_bs_other_wl = 'arg_1_2._id ~= 14749 and arg_1_2._id ~= 14800 and arg_1_2._id ~= 14803 and'
    if target_bs_other_wl in bs_content:
        bs_content = bs_content.replace(target_bs_other_wl, repl_bs_other_wl, 1)
        print("[OK] BattleSkill.lua castOtherSkill whitelist updated for 14800, 14803")
    else:
        print("[ERR] target_bs_other_wl not found in BattleSkill.lua")

# castOtherSkill execution for 14800 & 14803
bs_cast_other_skills = """	elseif var_13_4 == 14800 then
		local targetCard = nil
		local cid = (var_13_15 > 0 and (var_13_15 % BattleData.UseCardId.id_group)) or (var_13_14 > 0 and (var_13_14 % BattleData.UseCardId.id_group)) or var_13_15 or var_13_14
		if cid and cid > 0 then
			targetCard = arg_13_0:getCardById(cid)
		end
		if targetCard == nil or (targetCard._status ~= BattleData.CardStatus.pile and targetCard._status ~= BattleData.CardStatus.grave) then
			for _, c in ipairs(arg_13_0._pileCards) do
				if c:isKeyword(304) or (c._info and c._info._keyword == 304) then
					targetCard = c
					break
				end
			end
			if targetCard == nil then
				for _, c in ipairs(arg_13_0._graveCards) do
					if c:isKeyword(304) or (c._info and c._info._keyword == 304) then
						targetCard = c
						break
					end
				end
			end
		end
		if targetCard and #arg_13_0._handCards < Data.MAX_CARD_COUNT_IN_HAND then
			local sVal = (targetCard._status == BattleData.CardStatus.pile) and BattleData.CardStatusVal.p2h_deal or BattleData.CardStatusVal.g2h_deal
			arg_13_0:setCardStatus(targetCard, BattleData.CardStatus.hand, arg_13_1._id, 14800, arg_13_3, sVal)
			var_13_13 = true
		end
	elseif var_13_4 == 14803 then
		local fortress = arg_13_0._fortress
		if fortress then
			local currentHp = fortress._hp or 0
			local healAmt = math.max(3000, 8000 - currentHp)
			if healAmt > 0 then
				arg_13_0:incHp(fortress, healAmt, false, arg_13_1._id, 14803, arg_13_3)
			end
			var_13_13 = true
		end
"""

if 'var_13_4 == 14800' not in bs_content:
    target_bs_other_cast = '	elseif var_13_4 == 14749 then'
    if target_bs_other_cast in bs_content:
        bs_content = bs_content.replace(target_bs_other_cast, bs_cast_other_skills + target_bs_other_cast, 1)
        print("[OK] BattleSkill.lua castOtherSkill updated for 14800, 14803")
    else:
        target_bs_other_cast_crlf = target_bs_other_cast.replace('\n', '\r\n')
        if target_bs_other_cast_crlf in bs_content:
            bs_content = bs_content.replace(target_bs_other_cast_crlf, bs_cast_other_skills.replace('\n', '\r\n') + target_bs_other_cast_crlf, 1)
            print("[OK] BattleSkill.lua (CRLF) castOtherSkill updated for 14800, 14803")
        else:
            print("[ERR] target_bs_other_cast not found in BattleSkill.lua")

# canUseMagic checks for 21148 and 21149
bs_canuse_magic = """	if arg_22_1:isInfoId(21148) or arg_22_1:hasSkillFast(14800) then
		local hasCard = false
		for _, c in ipairs(arg_22_0._pileCards) do
			if c:isKeyword(304) or (c._info and c._info._keyword == 304) then
				hasCard = true
				break
			end
		end
		if not hasCard then
			for _, c in ipairs(arg_22_0._graveCards) do
				if c:isKeyword(304) or (c._info and c._info._keyword == 304) then
					hasCard = true
					break
				end
			end
		end
		if not hasCard then
			return false
		end
		if not arg_22_2 then
			return true
		end
	end

	if arg_22_1:isInfoId(21149) or arg_22_1:hasSkillFast(14803) then
		if not arg_22_2 then
			return true
		end
	end
"""

if 'arg_22_1:isInfoId(21148)' not in bs_content:
    target_bs_canuse_mag = '	if arg_22_1:isInfoId(21144) or arg_22_1:hasSkillFast(14749) then'
    if target_bs_canuse_mag in bs_content:
        bs_content = bs_content.replace(target_bs_canuse_mag, bs_canuse_magic + target_bs_canuse_mag, 1)
        print("[OK] BattleSkill.lua canUseMagic updated for 21148, 21149")
    else:
        target_bs_canuse_mag_crlf = target_bs_canuse_mag.replace('\n', '\r\n')
        if target_bs_canuse_mag_crlf in bs_content:
            bs_content = bs_content.replace(target_bs_canuse_mag_crlf, bs_canuse_magic.replace('\n', '\r\n') + target_bs_canuse_mag_crlf, 1)
            print("[OK] BattleSkill.lua (CRLF) canUseMagic updated for 21148, 21149")
        else:
            print("[ERR] target_bs_canuse_mag not found in BattleSkill.lua")

# AI canUseMagic routing
if 'var_22_1 == 14800' not in bs_content:
    target_bs_ai = 'elseif var_22_1 == 14749'
    repl_bs_ai = 'elseif var_22_1 == 14800 or var_22_1 == 14803 or var_22_1 == 14749'
    if target_bs_ai in bs_content:
        bs_content = bs_content.replace(target_bs_ai, repl_bs_ai, 1)
        print("[OK] BattleSkill.lua AI canUseMagic updated for 14800, 14803")
    else:
        print("[ERR] target_bs_ai not found in BattleSkill.lua")

with open(BS_LUA, 'w', encoding='utf-8') as f:
    f.write(bs_content)

# 8. web/src/BattleHelper.lua
BH_LUA = r"D:\yugitauapk\web\src\BattleHelper.lua"
with open(BH_LUA, 'r', encoding='utf-8') as f:
    bh_content = f.read()

# isGraveSkill whitelist at line 7890
if 'arg_304_1._id ~= 14800' not in bh_content:
    target_bh_wl = 'arg_304_1._id ~= 14793 and arg_304_3 ~='
    repl_bh_wl = 'arg_304_1._id ~= 14793 and arg_304_1._id ~= 14800 and arg_304_1._id ~= 14804 and arg_304_3 ~='
    if target_bh_wl in bh_content:
        bh_content = bh_content.replace(target_bh_wl, repl_bh_wl, 1)
        print("[OK] BattleHelper.lua isGraveSkill whitelist updated for 14800, 14804")
    else:
        print("[ERR] target_bh_wl not found in BattleHelper.lua")

# isGraveSkill target selection for 14800 & 14804
bh_isgrave_targets = """	elseif arg_304_1._id == 14800 then
		local pOwner = arg_304_0
		local candidates = {}
		for _, c in ipairs(pOwner._pileCards) do
			if c:isKeyword(304) or (c._info and c._info._keyword == 304) then
				table.insert(candidates, c)
			end
		end
		for _, c in ipairs(pOwner._graveCards) do
			if c:isKeyword(304) or (c._info and c._info._keyword == 304) then
				table.insert(candidates, c)
			end
		end
		if #candidates > 0 then
			return true, candidates, 1
		end
		return false
	elseif arg_304_1._id == 14804 then
		local ownerCard = arg_304_1._owner or arg_304_2 or (arg_304_1._card)
		if ownerCard == nil then
			local cards = arg_304_0:getBattleCardsByInfoId("B", 12340)
			if #cards > 0 then ownerCard = cards[1] end
		end
		local pOwner = (ownerCard and ownerCard._owner) or arg_304_0
		if ownerCard and ownerCard._status ~= BattleData.CardStatus.board then
			return false
		end
		if (pOwner._castedSkillCounts and pOwner._castedSkillCounts[14804] and pOwner._castedSkillCounts[14804] >= 1) then
			return false
		end
		if pOwner._isSummonDisabled or pOwner._isSpecialSummonDisabled then
			return false
		end
		local candidates = {}
		for _, c in ipairs(pOwner._pileCards) do
			if c._infoId == 12339 or c:isInfoId(12339) then
				table.insert(candidates, c)
			end
		end
		for _, c in ipairs(pOwner._handCards) do
			if c._infoId == 12339 or c:isInfoId(12339) then
				table.insert(candidates, c)
			end
		end
		for _, c in ipairs(pOwner._graveCards) do
			if c._infoId == 12339 or c:isInfoId(12339) then
				table.insert(candidates, c)
			end
		end
		if #candidates > 0 then
			return true, candidates, 1
		end
		return false
"""

if 'arg_304_1._id == 14800' not in bh_content:
    target_bh_target = '	elseif arg_304_1._id == 14793 then'
    if target_bh_target in bh_content:
        bh_content = bh_content.replace(target_bh_target, bh_isgrave_targets + target_bh_target, 1)
        print("[OK] BattleHelper.lua isGraveSkill target selection updated for 14800, 14804")
    else:
        target_bh_target_crlf = target_bh_target.replace('\n', '\r\n')
        if target_bh_target_crlf in bh_content:
            bh_content = bh_content.replace(target_bh_target_crlf, bh_isgrave_targets.replace('\n', '\r\n') + target_bh_target_crlf, 1)
            print("[OK] BattleHelper.lua (CRLF) isGraveSkill target selection updated for 14800, 14804")
        else:
            print("[ERR] target_bh_target not found in BattleHelper.lua")

# canSpecialSummon restriction for 14804
bh_sp_lock = """	if arg_293_0._isSpecialSummonDisabledBy14804 and not (arg_293_1:isKeyword(304) or (arg_293_1._info and arg_293_1._info._keyword == 304)) then
		return false
	end
"""

if 'arg_293_0._isSpecialSummonDisabledBy14804' not in bh_content:
    target_bh_sp = '	if arg_293_0._isSpecialSummonDisabledBy3153 and not arg_293_1:isKeyword(Data._skillInfo[3153]._refCards[1]) then'
    if target_bh_sp in bh_content:
        bh_content = bh_content.replace(target_bh_sp, bh_sp_lock + target_bh_sp, 1)
        print("[OK] BattleHelper.lua canSpecialSummon restriction added for 14804")
    else:
        target_bh_sp_crlf = target_bh_sp.replace('\n', '\r\n')
        if target_bh_sp_crlf in bh_content:
            bh_content = bh_content.replace(target_bh_sp_crlf, bh_sp_lock.replace('\n', '\r\n') + target_bh_sp_crlf, 1)
            print("[OK] BattleHelper.lua (CRLF) canSpecialSummon restriction added for 14804")
        else:
            print("[ERR] target_bh_sp not found in BattleHelper.lua")

with open(BH_LUA, 'w', encoding='utf-8') as f:
    f.write(bh_content)

# 9. web/src/BattleStep.lua (resets and Totem hand-trap)
BSTEP_LUA = r"D:\yugitauapk\web\src\BattleStep.lua"
with open(BSTEP_LUA, 'r', encoding='utf-8') as f:
    bstep_content = f.read()

bstep_reset = """	arg_2_0._castedSkillCounts[14798] = nil
	arg_2_0._opponent._castedSkillCounts[14798] = nil
	arg_2_0._castedSkillCounts[14804] = nil
	arg_2_0._opponent._castedSkillCounts[14804] = nil
	arg_2_0._isSpecialSummonDisabledBy14804 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14804 = nil
	arg_2_0._totemBoardProtectTurn = nil
	arg_2_0._opponent._totemBoardProtectTurn = nil
	arg_2_0._totemHandProtectTurn = nil
	arg_2_0._opponent._totemHandProtectTurn = nil
"""

if 'arg_2_0._castedSkillCounts[14798]' not in bstep_content:
    target_bstep = 'arg_2_0._opponent._castedSkillCounts[14795] = nil'
    if target_bstep in bstep_content:
        bstep_content = bstep_content.replace(target_bstep, target_bstep + '\n' + bstep_reset, 1)
        print("[OK] BattleStep.lua round reset updated for 14798, 14804, Totem")
    else:
        target_bstep_crlf = target_bstep.replace('\n', '\r\n')
        if target_bstep_crlf in bstep_content:
            bstep_content = bstep_content.replace(target_bstep_crlf, target_bstep_crlf + '\r\n' + bstep_reset.replace('\n', '\r\n'), 1)
            print("[OK] BattleStep.lua (CRLF) round reset updated for 14798, 14804, Totem")
        else:
            print("[ERR] target_bstep not found in BattleStep.lua")

# Totem hand-trap hook in underAttack
totem_hand_trap_code = """		elseif var_66_1._type == Data.CardType.fortress and arg_66_0:accountDamage(var_66_1) > 0 then
			local defender = var_66_1._owner
			local attacker = var_66_0
			local atkVal = attacker and (attacker._atkWhileAttacking or attacker._atk or 0) or 0
			local lpVal = var_66_1._hp or 0
			if defender and atkVal >= lpVal then
				local turnId = (defender._round or 0) * 1000 + (defender._opponent and defender._opponent._round or 0)
				if defender._totemHandProtectTurn ~= turnId then
					local handTotems = defender:getBattleCardsByInfoId("H", 30596)
					if #handTotems > 0 then
						defender._totemHandProtectTurn = turnId
						local totemCard = handTotems[1]
						defender:setCardStatus(totemCard, BattleData.CardStatus.grave, totemCard._id, 14802, Data.SkillMode.initiative_hand, BattleData.CardStatusVal.h2g_magic)
						defender:incShield(var_66_1, { 11005 }, false, false, totemCard._id, 11005, Data.SkillMode.using)
						defender:incHp(var_66_1, 1000, false, totemCard._id, 14802, Data.SkillMode.using)
					end
				end
			end
"""

if 'defender:getBattleCardsByInfoId("H", 30596)' not in bstep_content:
    target_totem_underattack = '		elseif var_66_1._type == Data.CardType.fortress and arg_66_0:accountDamage(var_66_1) > 0 then'
    if target_totem_underattack in bstep_content:
        bstep_content = bstep_content.replace(target_totem_underattack, totem_hand_trap_code, 1)
        print("[OK] BattleStep.lua underAttack updated for Totem hand-trap (14802)")
    else:
        target_totem_crlf = target_totem_underattack.replace('\n', '\r\n')
        if target_totem_crlf in bstep_content:
            bstep_content = bstep_content.replace(target_totem_crlf, totem_hand_trap_code.replace('\n', '\r\n'), 1)
            print("[OK] BattleStep.lua (CRLF) underAttack updated for Totem hand-trap (14802)")
        else:
            print("[ERR] target_totem_underattack not found in BattleStep.lua")

with open(BSTEP_LUA, 'w', encoding='utf-8') as f:
    f.write(bstep_content)

# 10. web/src/PlayerBattle.lua (Totem board protection 14801 & Ender dragon on-destroy 14799)
PB_LUA = r"D:\yugitauapk\web\src\PlayerBattle.lua"
with open(PB_LUA, 'r', encoding='utf-8') as f:
    pb_content = f.read()

pb_hooks = """	-- Totem (30596 / 14801): 1 luot 1 lan, khi quai Minecraft tren san phe ta bi pha huy, bo qua 1 lan pha huy
	if (arg_7_1:isKeyword(304) or (arg_7_1._info and arg_7_1._info._keyword == 304)) and arg_7_1._status == BattleData.CardStatus.board and (arg_7_2 == BattleData.CardStatus.grave or arg_7_2 == BattleData.CardStatus.leave) then
		local isCostOrSac = (arg_7_6 == BattleData.CardStatusVal.sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_sync_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_link_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_summon_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.x2gl_cost
			or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost
			or arg_7_6 == BattleData.CardStatusVal.h2l_temp
			or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo)
		if not isCostOrSac then
			local owner = arg_7_1._owner
			if owner then
				local turnId = (owner._round or 0) * 1000 + (owner._opponent and owner._opponent._round or 0)
				local hasTotemOnBoard = #owner:getBattleCardsByInfoId("B", 30596) > 0 or #owner:getBattleCardsByInfoId("C", 30596) > 0
				if hasTotemOnBoard and owner._totemBoardProtectTurn ~= turnId then
					owner._totemBoardProtectTurn = turnId
					if arg_7_1._hp and arg_7_1._hp <= 0 then
						arg_7_1._hp = 1
					end
					return
				end
			end
		end
	end

	-- Ender Dragon (12339 / 14799): Khi bi pha huy, phe ta tang LP bang tong ATK quai doi phuong tren san
	if (arg_7_1:isInfoId(12339) or arg_7_1._infoId == 12339 or arg_7_1:hasSkillFast(14799)) and arg_7_1._status == BattleData.CardStatus.board and (arg_7_2 == BattleData.CardStatus.grave or arg_7_2 == BattleData.CardStatus.leave) then
		local isCostOrSac = (arg_7_6 == BattleData.CardStatusVal.sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_sync_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_link_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_summon_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.x2gl_cost
			or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost
			or arg_7_6 == BattleData.CardStatusVal.h2l_temp
			or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo)
		if not isCostOrSac then
			local owner = arg_7_1._owner
			local oppo = owner and owner._opponent
			if oppo and owner and owner._fortress then
				local totalAtk = 0
				for _, oppoMon in ipairs(oppo:getBoardCards()) do
					if oppoMon:isMonster() or oppoMon:isMonsterRare() or oppoMon._type == Data.CardType.monster then
						totalAtk = totalAtk + math.max(0, oppoMon._atk or 0)
					end
				end
				if totalAtk > 0 then
					owner:incHp(owner._fortress, totalAtk, false, arg_7_1._id, 14799, Data.SkillMode.using)
				end
			end
		end
	end
"""

if 'Totem (30596 / 14801)' not in pb_content:
    target_pb = '	-- Overload ("quá tải") check: khi rời sân bị loại bỏ'
    if target_pb in pb_content:
        pb_content = pb_content.replace(target_pb, pb_hooks + '\n\t' + target_pb, 1)
        print("[OK] PlayerBattle.lua setCardStatus updated for Totem and Ender Dragon")
    else:
        target_pb_crlf = target_pb.replace('\n', '\r\n')
        if target_pb_crlf in pb_content:
            pb_content = pb_content.replace(target_pb_crlf, pb_hooks.replace('\n', '\r\n') + '\r\n\t' + target_pb_crlf, 1)
            print("[OK] PlayerBattle.lua (CRLF) setCardStatus updated for Totem and Ender Dragon")
        else:
            print("[ERR] target_pb not found in PlayerBattle.lua")

with open(PB_LUA, 'w', encoding='utf-8') as f:
    f.write(pb_content)

# 11. web/src/h5_patch.lua
HP_LUA = r"D:\yugitauapk\web\src\h5_patch.lua"
with open(HP_LUA, 'r', encoding='utf-8') as f:
    hp_content = f.read()

h5_patch_new = """
			-- Ender Dragon (12339)
			if Data._monsterInfo and not Data._monsterInfo[12339] then
				Data._monsterInfo[12339] = {
					_atk = { 4500 },
					_attackEffect = 1,
					_available = 1,
					_bgId = 0,
					_briefNameSid = 57343,
					_category = 2,
					_cost = 0,
					_descSid = 57342,
					_guideSid = 0,
					_hp = { 4500 },
					_id = 12339,
					_isHide = 0,
					_joinResult = { 0 },
					_keyword = 304,
					_maxCount = 3,
					_nameSid = 57341,
					_nature = 2,
					_option = 2,
					_originId = 0,
					_packageId = { 0 },
					_picId = 0,
					_py = "enderdragon",
					_quality = 5,
					_recruitable = 1,
					_skillId = { 3043, 14798, 14799 },
					_skin = { 0 },
					_star = 10
				}
			end
			if Data._monsterInfo and Data._monsterInfo[12339] then
				Data._monsterInfo[12339]._quality = 5
				Data._monsterInfo[12339]._keyword = 304
				Data._monsterInfo[12339]._nameSid = 57341
				Data._monsterInfo[12339]._descSid = 57342
				Data._monsterInfo[12339]._briefNameSid = 57343
				Data._monsterInfo[12339]._skillId = { 3043, 14798, 14799 }
			end

			-- Trung Rong Ender (12340)
			if Data._monsterInfo and not Data._monsterInfo[12340] then
				Data._monsterInfo[12340] = {
					_atk = { 0 },
					_attackEffect = 1,
					_available = 1,
					_bgId = 0,
					_briefNameSid = 57369,
					_category = 2,
					_cost = 0,
					_descSid = 57368,
					_guideSid = 0,
					_hp = { 0 },
					_id = 12340,
					_isHide = 0,
					_joinResult = { 0 },
					_keyword = 304,
					_maxCount = 3,
					_nameSid = 57367,
					_nature = 2,
					_option = 2,
					_originId = 0,
					_packageId = { 0 },
					_picId = 0,
					_py = "trungrongender",
					_quality = 4,
					_recruitable = 1,
					_skillId = { 12006, 14804 },
					_skin = { 0 },
					_star = 1
				}
			end
			if Data._monsterInfo and Data._monsterInfo[12340] then
				Data._monsterInfo[12340]._quality = 4
				Data._monsterInfo[12340]._keyword = 304
				Data._monsterInfo[12340]._nameSid = 57367
				Data._monsterInfo[12340]._descSid = 57368
				Data._monsterInfo[12340]._briefNameSid = 57369
				Data._monsterInfo[12340]._skillId = { 12006, 14804 }
			end

			-- Command Block (21148)
			if Data._magicInfo and not Data._magicInfo[21148] then
				Data._magicInfo[21148] = {
					_available = 1,
					_briefNameSid = 57350,
					_descSid = 57349,
					_guideSid = 0,
					_id = 21148,
					_isHide = 0,
					_isSummon = 0,
					_keyword = 304,
					_maxCount = 3,
					_nameSid = 57348,
					_option = 1,
					_originId = 0,
					_packageId = { 0 },
					_picId = 0,
					_py = "commandblock",
					_quality = 4,
					_recruitable = 1,
					_skillId = { 14800 },
					_targetType = 0,
					_type = 11
				}
			end
			if Data._magicInfo and Data._magicInfo[21148] then
				Data._magicInfo[21148]._quality = 4
				Data._magicInfo[21148]._keyword = 304
				Data._magicInfo[21148]._nameSid = 57348
				Data._magicInfo[21148]._descSid = 57349
				Data._magicInfo[21148]._briefNameSid = 57350
				Data._magicInfo[21148]._skillId = { 14800 }
			end

			-- Tao vang duoc phu phep (21149)
			if Data._magicInfo and not Data._magicInfo[21149] then
				Data._magicInfo[21149] = {
					_available = 1,
					_briefNameSid = 57362,
					_descSid = 57361,
					_guideSid = 0,
					_id = 21149,
					_isHide = 0,
					_isSummon = 0,
					_keyword = 304,
					_maxCount = 3,
					_nameSid = 57360,
					_option = 1,
					_originId = 0,
					_packageId = { 0 },
					_picId = 0,
					_py = "taovang",
					_quality = 4,
					_recruitable = 1,
					_skillId = { 14803, 14797, 9232 },
					_targetType = 0,
					_type = 11
				}
			end
			if Data._magicInfo and Data._magicInfo[21149] then
				Data._magicInfo[21149]._quality = 4
				Data._magicInfo[21149]._keyword = 304
				Data._magicInfo[21149]._nameSid = 57360
				Data._magicInfo[21149]._descSid = 57361
				Data._magicInfo[21149]._briefNameSid = 57362
				Data._magicInfo[21149]._skillId = { 14803, 14797, 9232 }
			end

			-- Totem (30596)
			if Data._trapInfo and not Data._trapInfo[30596] then
				Data._trapInfo[30596] = {
					_available = 1,
					_briefNameSid = 57355,
					_descSid = 57354,
					_guideSid = 0,
					_id = 30596,
					_isHide = 0,
					_isSummon = 0,
					_keyword = 304,
					_maxCount = 3,
					_nameSid = 57353,
					_option = 2,
					_originId = 0,
					_packageId = { 0 },
					_picId = 0,
					_py = "totem",
					_quality = 4,
					_recruitable = 1,
					_skillId = { 14801, 14802 },
					_targetType = 0,
					_type = 13
				}
			end
			if Data._trapInfo and Data._trapInfo[30596] then
				Data._trapInfo[30596]._quality = 4
				Data._trapInfo[30596]._keyword = 304
				Data._trapInfo[30596]._nameSid = 57353
				Data._trapInfo[30596]._descSid = 57354
				Data._trapInfo[30596]._briefNameSid = 57355
				Data._trapInfo[30596]._skillId = { 14801, 14802 }
			end

			-- Skills 14797..14804
			if Data._skillInfo then
				Data._skillInfo[14797] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57366, _effectVal = { 0 }, _id = 14797, _isIgnoreDefend = 0, _modes = { 91, 41 }, _nameSid = 57365, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 4, _refCards = { 0 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 400 } }
				Data._skillInfo[14798] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57345, _effectVal = { 0 }, _id = 14798, _isIgnoreDefend = 0, _modes = { 34 }, _nameSid = 57344, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 5, _refCards = { 304 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
				Data._skillInfo[14799] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57347, _effectVal = { 0 }, _id = 14799, _isIgnoreDefend = 1, _modes = { 24 }, _nameSid = 57346, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 5, _refCards = { 0 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
				Data._skillInfo[14800] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57352, _effectVal = { 0 }, _id = 14800, _isIgnoreDefend = 0, _modes = { 31 }, _nameSid = 57351, _needExtraGem = 0, _needNoGem = 0, _option = { 1 }, _priority = 0, _quality = 4, _refCards = { 304 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 1 } }
				Data._skillInfo[14801] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57357, _effectVal = { 0 }, _id = 14801, _isIgnoreDefend = 1, _modes = { 24 }, _nameSid = 57356, _needExtraGem = 0, _needNoGem = 0, _option = { 1 }, _priority = 0, _quality = 4, _refCards = { 304 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
				Data._skillInfo[14802] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57359, _effectVal = { 0 }, _id = 14802, _isIgnoreDefend = 0, _modes = { 34 }, _nameSid = 57358, _needExtraGem = 0, _needNoGem = 0, _option = { 1 }, _priority = 0, _quality = 4, _refCards = { 304 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 1000 } }
				Data._skillInfo[14803] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57364, _effectVal = { 0 }, _id = 14803, _isIgnoreDefend = 0, _modes = { 31 }, _nameSid = 57363, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 4, _refCards = { 0 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 3000 } }
				Data._skillInfo[14804] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57371, _effectVal = { 0 }, _id = 14804, _isIgnoreDefend = 1, _modes = { 33 }, _nameSid = 57370, _needExtraGem = 0, _needNoGem = 0, _option = { 1 }, _priority = 1, _quality = 4, _refCards = { 12339 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
			end
"""

if 'Data._monsterInfo[12339]' not in hp_content:
    target_hp = 'Data._monsterInfo[12338]._skillId = { 12007, 14794, 14795 }\n\t\t\tend'
    if target_hp in hp_content:
        hp_content = hp_content.replace(target_hp, target_hp + h5_patch_new, 1)
        with open(HP_LUA, 'w', encoding='utf-8') as f:
            f.write(hp_content)
        print("[OK] h5_patch.lua updated with 12339, 12340, 21148, 21149, 30596, and skills 14797-14804")
    else:
        target_hp_crlf = target_hp.replace('\n', '\r\n')
        if target_hp_crlf in hp_content:
            hp_content = hp_content.replace(target_hp_crlf, target_hp_crlf + h5_patch_new.replace('\n', '\r\n'), 1)
            with open(HP_LUA, 'w', encoding='utf-8') as f:
                f.write(hp_content)
            print("[OK] h5_patch.lua (CRLF) updated with 12339, 12340, 21148, 21149, 30596, and skills 14797-14804")
        else:
            print("[ERR] target_hp not found in h5_patch.lua")
else:
    print("[SKIP] h5_patch.lua already has 12339")

print("[OK] All code and data modifications completed successfully!")
