import os, sys, re

sys.stdout.reconfigure(encoding='utf-8')

# 1. web/data/rare.lua (Skeleton 40747)
RARE_LUA = r"D:\yugitauapk\web\data\rare.lua"
with open(RARE_LUA, 'r', encoding='utf-8') as f:
    rare_content = f.read()

skeleton_rare_str = """  [40747]={["_atk"]={[1]=1600,},
  ["_attackEffect"]=1,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=57326,["_category"]=17,["_cost"]=0,["_descSid"]=57325,["_guideSid"]=0,["_hp"]={[1]=0,},
  ["_id"]=40747,["_isHide"]=0,["_joinComponent"]={[1]=5008,[2]=6008,},
  ["_joinResult"]={[1]=0,},
  ["_keyword"]=304,["_link"]={[1]=0,},
  ["_linkAllCandidates"]="0.0",["_linkCandidate"]="0.0",["_linkCount"]="0.0",["_linkSelectedCandidates"]="0.0",["_maxCount"]=3,["_nameSid"]=57324,["_nature"]=3,["_option"]=514,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="skeleton",["_quality"]=3,["_recruitable"]=1,["_skillId"]={[1]=14793,},
  ["_skin"]={[1]=0,},
  ["_star"]=4,["_syncComponent"]={[1]={[1]=0,},
  [2]={[1]=0,},},},
"""

if '[40747]=' not in rare_content:
    last_brace = rare_content.rfind('}')
    if last_brace != -1:
        rare_content = rare_content[:last_brace] + skeleton_rare_str + rare_content[last_brace:]
        with open(RARE_LUA, 'w', encoding='utf-8') as f:
            f.write(rare_content)
        print("[OK] Added Skeleton 40747 to rare.lua")
    else:
        print("[ERR] last_brace not found in rare.lua")
else:
    print("[SKIP] rare.lua already has 40747")

# 2. web/data/monster.lua (Enderman 12338)
MON_LUA = r"D:\yugitauapk\web\data\monster.lua"
with open(MON_LUA, 'r', encoding='utf-8') as f:
    mon_content = f.read()

enderman_mon_str = """  [12338]={["_atk"]={[1]=2000,},
  ["_attackEffect"]=1,["_available"]=1,["_bgId"]=0,["_briefNameSid"]=57331,["_category"]=4,["_cost"]=0,["_descSid"]=57330,["_guideSid"]=0,["_hp"]={[1]=1000,},
  ["_id"]=12338,["_isHide"]=0,["_joinResult"]={[1]=0,},
  ["_keyword"]=304,["_maxCount"]=3,["_nameSid"]=57329,["_nature"]=2,["_option"]=2,["_originId"]=0,["_packageId"]={[1]=0,},
  ["_picId"]=0,["_py"]="enderman",["_quality"]=3,["_recruitable"]=1,["_skillId"]={[1]=12007,[2]=14794,[3]=14795,},
  ["_skin"]={[1]=0,},
  ["_star"]=6,},
"""

if '[12338]=' not in mon_content:
    last_brace = mon_content.rfind('}')
    if last_brace != -1:
        mon_content = mon_content[:last_brace] + enderman_mon_str + mon_content[last_brace:]
        with open(MON_LUA, 'w', encoding='utf-8') as f:
            f.write(mon_content)
        print("[OK] Added Enderman 12338 to monster.lua")
    else:
        print("[ERR] last_brace not found in monster.lua")
else:
    print("[SKIP] monster.lua already has 12338")

# 3. web/data/skill.lua (Skills 14793, 14794, 14795)
SKILL_LUA = r"D:\yugitauapk\web\data\skill.lua"
with open(SKILL_LUA, 'r', encoding='utf-8') as f:
    sk_content = f.read()

new_skills_str = """  [14793]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=3,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57328,["_effectVal"]={[1]=0,},
  ["_id"]=14793,["_isIgnoreDefend"]=1,["_modes"]={[1]=33,},
  ["_nameSid"]=57327,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=3,},
  ["_priority"]=1,["_quality"]=3,["_refCards"]={[1]=304,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
  [14794]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57333,["_effectVal"]={[1]=0,},
  ["_id"]=14794,["_isIgnoreDefend"]=0,["_modes"]={[1]=34,},
  ["_nameSid"]=57332,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=0,},
  ["_priority"]=0,["_quality"]=3,["_refCards"]={[1]=304,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
  [14795]={["_against"]={[1]=0,},
  ["_avoidP2B"]=0,["_count"]=1,["_decrease"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,},
  ["_descSid"]=57335,["_effectVal"]={[1]=0,},
  ["_id"]=14795,["_isIgnoreDefend"]=1,["_modes"]={[1]=2,},
  ["_nameSid"]=57334,["_needExtraGem"]=0,["_needNoGem"]=0,["_option"]={[1]=1,},
  ["_priority"]=1,["_quality"]=3,["_refCards"]={[1]=0,},
  ["_refSkills"]={[1]=0,},
  ["_removeMode"]={[1]=0,},
  ["_targetType"]=0,["_val"]={[1]=0,},},
"""

if '[14793]=' not in sk_content:
    last_brace = sk_content.rfind('}')
    if last_brace != -1:
        sk_content = sk_content[:last_brace] + new_skills_str + sk_content[last_brace:]
        with open(SKILL_LUA, 'w', encoding='utf-8') as f:
            f.write(sk_content)
        print("[OK] Added skills 14793, 14794, 14795 to skill.lua")
    else:
        print("[ERR] last_brace not found in skill.lua")
else:
    print("[SKIP] skill.lua already has 14793")

# 4. web/data/diamond_products.lua
DIA_LUA = r"D:\yugitauapk\web\data\diamond_products.lua"
with open(DIA_LUA, 'r', encoding='utf-8') as f:
    dia_content = f.read()

diamond_extra_str = '  [551]={["_cardId"]=40747,["_cost"]=10000,["_date"]="20240101.0",["_id"]=551,["_resType"]=3,["_type"]=0,},\n  [552]={["_cardId"]=12338,["_cost"]=10000,["_date"]="20240101.0",["_id"]=552,["_resType"]=3,["_type"]=0,},\n'
if '[551]=' not in dia_content and '40747' not in dia_content:
    last_brace = dia_content.rfind('}')
    if last_brace != -1:
        dia_content = dia_content[:last_brace] + diamond_extra_str + dia_content[last_brace:]
        with open(DIA_LUA, 'w', encoding='utf-8') as f:
            f.write(dia_content)
        print("[OK] Updated diamond_products.lua with products 551 & 552")
else:
    print("[SKIP] diamond_products.lua already has products")

# 5. web/src/Data.lua
DATA_LUA = r"D:\yugitauapk\web\src\Data.lua"
with open(DATA_LUA, 'r', encoding='utf-8') as f:
    data_content = f.read()

# getSkillType routing for monsterSpell
if 'arg_13_0 == 14793' not in data_content:
    target_data_spell = 'or arg_13_0 == 14789 then'
    repl_data_spell = 'or arg_13_0 == 14789 or arg_13_0 == 14793 or arg_13_0 == 14794 then'
    if target_data_spell in data_content:
        data_content = data_content.replace(target_data_spell, repl_data_spell, 1)
        print("[OK] Data.lua monsterSpell routing updated for 14793, 14794")
    else:
        print("[ERR] target_data_spell not found in Data.lua")

# getSkillType routing for monster4Halo
if 'arg_13_0 == 14795' not in data_content:
    target_data_halo = 'or arg_13_0 == 14790 or arg_13_0 == 14792 then'
    repl_data_halo = 'or arg_13_0 == 14790 or arg_13_0 == 14792 or arg_13_0 == 14795 then'
    if target_data_halo in data_content:
        data_content = data_content.replace(target_data_halo, repl_data_halo, 1)
        print("[OK] Data.lua monster4Halo routing updated for 14795")
    else:
        print("[ERR] target_data_halo not found in Data.lua")

with open(DATA_LUA, 'w', encoding='utf-8') as f:
    f.write(data_content)

# 6. web/src/BattleSkill.lua
BS_LUA = r"D:\yugitauapk\web\src\BattleSkill.lua"
with open(BS_LUA, 'r', encoding='utf-8') as f:
    bs_content = f.read()

# monsterSpell whitelist at line 364
if 'arg_1_2._id == 14793' not in bs_content:
    target_bs_spell = 'or arg_1_2._id == 14789'
    repl_bs_spell = 'or arg_1_2._id == 14789 or arg_1_2._id == 14793 or arg_1_2._id == 14794'
    if target_bs_spell in bs_content:
        bs_content = bs_content.replace(target_bs_spell, repl_bs_spell, 1)
        print("[OK] BattleSkill.lua line 364 updated with 14793, 14794")
    else:
        print("[ERR] target_bs_spell not found in BattleSkill.lua")

# canUseInitiativeSkill4 check
bs_canuse_skills = """	elseif var_40_0 == 14793 then
		if arg_40_1._status ~= BattleData.CardStatus.rare then
			return false
		end
		local pOwner = arg_40_1._owner or arg_40_0
		if (pOwner._castedSkillCounts and pOwner._castedSkillCounts[14793] and pOwner._castedSkillCounts[14793] >= 3) then
			return false
		end
		if pOwner._isSummonDisabled or pOwner._isSpecialSummonDisabled then
			return false
		end
		if pOwner:getEmptyBoardPos(arg_40_1) == nil then
			return false
		end
		local candidates = {}
		for _, c in ipairs(pOwner:getBattleCards("G")) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster) and (c:isKeyword(304) or (c._info and c._info._keyword == 304)) then
				return true
			end
		end
		return false
	elseif var_40_0 == 14794 then
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
		local boardMonsters = pOwner:getBoardCards()
		local canSummon = false
		if #boardMonsters == 0 then
			canSummon = true
		else
			for _, c in ipairs(boardMonsters) do
				if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster) and (c:isKeyword(304) or (c._info and c._info._keyword == 304)) then
					canSummon = true
					break
				end
			end
		end
		if not canSummon then
			return false
		end
		return #pOwner:filterCanChangeToBoardCards({ arg_40_1 }) > 0
"""

if 'var_40_0 == 14793' not in bs_content:
    target_bs_canuse = '	elseif var_40_0 == 14786 then'
    if target_bs_canuse in bs_content:
        bs_content = bs_content.replace(target_bs_canuse, bs_canuse_skills + target_bs_canuse, 1)
        print("[OK] BattleSkill.lua canUseInitiativeSkill4 updated for 14793, 14794")
    else:
        target_bs_canuse_crlf = target_bs_canuse.replace('\n', '\r\n')
        if target_bs_canuse_crlf in bs_content:
            bs_content = bs_content.replace(target_bs_canuse_crlf, bs_canuse_skills.replace('\n', '\r\n') + target_bs_canuse_crlf, 1)
            print("[OK] BattleSkill.lua (CRLF) canUseInitiativeSkill4 updated for 14793, 14794")
        else:
            print("[ERR] target_bs_canuse not found in BattleSkill.lua")

# castMonsterSpellSkill execution
bs_cast_skills = """	elseif var_4_4 == 14793 then
		local ownerCard = var_4_1 or arg_4_1
		local pOwner = (ownerCard and ownerCard._owner) or arg_4_0
		pOwner._castedSkillCounts[14793] = (pOwner._castedSkillCounts[14793] or 0) + 1
		arg_4_0._castedSkillCounts[14793] = (arg_4_0._castedSkillCounts[14793] or 0) + 1

		local targetCard = nil
		if var_4_15 > 0 and pOwner then
			local cid = var_4_15 % BattleData.UseCardId.id_group
			targetCard = pOwner:getCardById(cid) or pOwner:getCardById(var_4_15)
		end
		if targetCard == nil or targetCard._status ~= BattleData.CardStatus.grave then
			for _, c in ipairs(pOwner:getBattleCards("G")) do
				if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster) and (c:isKeyword(304) or (c._info and c._info._keyword == 304)) then
					targetCard = c
					break
				end
			end
		end

		if targetCard then
			pOwner:setCardStatus(targetCard, BattleData.CardStatus.leave, arg_4_1._id, 14793, arg_4_3, BattleData.CardStatusVal.g2l_cost)
		end

		local emptyPos = pOwner:getEmptyBoardPos(arg_4_1)
		if emptyPos then
			pOwner:setCardStatus(arg_4_1, BattleData.CardStatus.board, arg_4_1._id, 14793, arg_4_3, BattleData.CardStatusVal.r2b_sync, emptyPos)
		end
		var_4_13 = true
	elseif var_4_4 == 14794 then
		local ownerCard = var_4_1 or arg_4_1
		local pOwner = (ownerCard and ownerCard._owner) or arg_4_0
		if arg_4_3 == Data.SkillMode.initiative_hand or arg_4_1._status == BattleData.CardStatus.hand then
			local emptyPos = pOwner:getEmptyBoardPos(arg_4_1)
			if emptyPos then
				pOwner:setCardStatus(arg_4_1, BattleData.CardStatus.board, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.h2b_special, emptyPos)
				var_4_13 = true
			end
		end
"""

if 'var_4_4 == 14793' not in bs_content:
    target_bs_cast = '	elseif var_4_4 == 14786 then'
    if target_bs_cast in bs_content:
        bs_content = bs_content.replace(target_bs_cast, bs_cast_skills + target_bs_cast, 1)
        print("[OK] BattleSkill.lua castMonsterSpellSkill updated for 14793, 14794")
    else:
        target_bs_cast_crlf = target_bs_cast.replace('\n', '\r\n')
        if target_bs_cast_crlf in bs_content:
            bs_content = bs_content.replace(target_bs_cast_crlf, bs_cast_skills.replace('\n', '\r\n') + target_bs_cast_crlf, 1)
            print("[OK] BattleSkill.lua (CRLF) castMonsterSpellSkill updated for 14793, 14794")
        else:
            print("[ERR] target_bs_cast not found in BattleSkill.lua")

# castMonster4HaloSkill execution (Skill 14795)
bs_cast_14795 = """	elseif var_8_4 == 14795 then
		local ownerCard = var_8_1 or arg_8_1
		local pOwner = (ownerCard and ownerCard._owner) or arg_8_0
		local oppo = pOwner._opponent or var_8_8
		local turnId = (pOwner._round or 0) * 1000 + (oppo and oppo._round or 0)
		if ownerCard._endermanStealTurn ~= turnId and (pOwner._castedSkillCounts[14795] or 0) == 0 then
			ownerCard._endermanStealTurn = turnId
			pOwner._castedSkillCounts[14795] = (pOwner._castedSkillCounts[14795] or 0) + 1
			arg_8_0._castedSkillCounts[14795] = (arg_8_0._castedSkillCounts[14795] or 0) + 1

			local oppoHands = oppo:getBattleCards("H")
			if #oppoHands > 0 and #pOwner:getBattleCards("H") < Data.MAX_CARD_COUNT_IN_HAND then
				local stolen = arg_8_0:randomOne(oppoHands)
				if stolen ~= nil then
					arg_8_0:setCardStatus(stolen, BattleData.CardStatus.hand, var_8_5, var_8_4, arg_8_3, BattleData.CardStatusVal.h2h_oppo)
					var_8_13 = true
				end
			end
		end
"""

if 'var_8_4 == 14795' not in bs_content:
    target_bs_halo = '	elseif var_8_4 == 14792 then'
    if target_bs_halo in bs_content:
        bs_content = bs_content.replace(target_bs_halo, bs_cast_14795 + target_bs_halo, 1)
        print("[OK] BattleSkill.lua castMonster4HaloSkill updated for 14795")
    else:
        target_bs_halo_crlf = target_bs_halo.replace('\n', '\r\n')
        if target_bs_halo_crlf in bs_content:
            bs_content = bs_content.replace(target_bs_halo_crlf, bs_cast_14795.replace('\n', '\r\n') + target_bs_halo_crlf, 1)
            print("[OK] BattleSkill.lua (CRLF) castMonster4HaloSkill updated for 14795")
        else:
            print("[ERR] target_bs_halo not found in BattleSkill.lua")

with open(BS_LUA, 'w', encoding='utf-8') as f:
    f.write(bs_content)

# 7. web/src/BattleHelper.lua
BH_LUA = r"D:\yugitauapk\web\src\BattleHelper.lua"
with open(BH_LUA, 'r', encoding='utf-8') as f:
    bh_content = f.read()

# Fix Buster Dragon lag bug at line 4749
if '#arg_239_1._owner:getBattleCards("B", 40535)' in bh_content:
    bh_content = bh_content.replace('#arg_239_1._owner:getBattleCards("B", 40535)', '#arg_239_1._owner:getBattleCardsByInfoId("B", 40535)')
    print("[OK] Fixed Buster Dragon (40535) parameter bug in BattleHelper.lua")

# Whitelist at line 7890
if 'arg_304_1._id ~= 14793' not in bh_content:
    target_bh_wl = 'arg_304_1._id ~= 14786 and arg_304_3 ~='
    repl_bh_wl = 'arg_304_1._id ~= 14786 and arg_304_1._id ~= 14793 and arg_304_3 ~='
    if target_bh_wl in bh_content:
        bh_content = bh_content.replace(target_bh_wl, repl_bh_wl, 1)
        print("[OK] BattleHelper.lua isGraveSkill whitelist updated for 14793")
    else:
        print("[ERR] target_bh_wl not found in BattleHelper.lua")

# isGraveSkill target selection for 14793
bh_isgrave_14793 = """	elseif arg_304_1._id == 14793 then
		local ownerCard = arg_304_1._owner or arg_304_2 or (arg_304_1._card)
		if ownerCard == nil then
			local cards = arg_304_0:getBattleCardsByInfoId("R", 40747)
			if #cards > 0 then ownerCard = cards[1] end
		end
		local pOwner = (ownerCard and ownerCard._owner) or arg_304_0
		if ownerCard and ownerCard._status ~= BattleData.CardStatus.rare then
			return false
		end
		if (pOwner._castedSkillCounts and pOwner._castedSkillCounts[14793] and pOwner._castedSkillCounts[14793] >= 3) then
			return false
		end
		if pOwner._isSummonDisabled or pOwner._isSpecialSummonDisabled then
			return false
		end
		if pOwner:getEmptyBoardPos(ownerCard) == nil then
			return false
		end
		local candidates = {}
		for _, c in ipairs(pOwner:getBattleCards("G")) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster) and (c:isKeyword(304) or (c._info and c._info._keyword == 304)) then
				table.insert(candidates, c)
			end
		end
		if #candidates > 0 then
			return true, candidates, 1
		end
		return false
"""

if 'arg_304_1._id == 14793' not in bh_content:
    target_bh_target = '	elseif arg_304_1._id == 14786 then'
    if target_bh_target in bh_content:
        bh_content = bh_content.replace(target_bh_target, bh_isgrave_14793 + target_bh_target, 1)
        print("[OK] BattleHelper.lua isGraveSkill target selection updated for 14793")
    else:
        target_bh_target_crlf = target_bh_target.replace('\n', '\r\n')
        if target_bh_target_crlf in bh_content:
            bh_content = bh_content.replace(target_bh_target_crlf, bh_isgrave_14793.replace('\n', '\r\n') + target_bh_target_crlf, 1)
            print("[OK] BattleHelper.lua (CRLF) isGraveSkill target selection updated for 14793")
        else:
            print("[ERR] target_bh_target not found in BattleHelper.lua")

with open(BH_LUA, 'w', encoding='utf-8') as f:
    f.write(bh_content)

# 8. web/src/BattleCardStatus.lua (Enderman on-summon & shield)
BCS_LUA = r"D:\yugitauapk\web\src\BattleCardStatus.lua"
with open(BCS_LUA, 'r', encoding='utf-8') as f:
    bcs_content = f.read()

enderman_bcs = """			if arg_15_1._infoId == 12338 or arg_15_1:isInfoId(12338) then
				arg_15_0:incShield(arg_15_1, { 12007 }, false, false, arg_15_1._id, 12007, Data.SkillMode.using)
				local owner = arg_15_1._owner or arg_15_0
				local oppo = owner and owner._opponent
				local turnId = (owner and owner._round or 0) * 1000 + (oppo and oppo._round or 0)
				if oppo and arg_15_1._endermanStealTurn ~= turnId then
					arg_15_1._endermanStealTurn = turnId
					local oppoHands = oppo:getBattleCards("H")
					if #oppoHands > 0 and #owner:getBattleCards("H") < Data.MAX_CARD_COUNT_IN_HAND then
						local stolen = owner:randomOne(oppoHands)
						if stolen then
							owner:setCardStatus(stolen, BattleData.CardStatus.hand, arg_15_1._id, 14795, Data.SkillMode.using, BattleData.CardStatusVal.h2h_oppo)
						end
					end
				end
			end
"""

if 'arg_15_1._infoId == 12338' not in bcs_content:
    target_bcs = '			if arg_15_1._infoId == 40535 or arg_15_1:isInfoId(40535) or arg_15_1:hasSkillFast(14771) then'
    if target_bcs in bcs_content:
        bcs_content = bcs_content.replace(target_bcs, enderman_bcs + target_bcs, 1)
        with open(BCS_LUA, 'w', encoding='utf-8') as f:
            f.write(bcs_content)
        print("[OK] BattleCardStatus.lua addCardToBoard updated for Enderman 12338")
    else:
        target_bcs_crlf = target_bcs.replace('\n', '\r\n')
        if target_bcs_crlf in bcs_content:
            bcs_content = bcs_content.replace(target_bcs_crlf, enderman_bcs.replace('\n', '\r\n') + target_bcs_crlf, 1)
            with open(BCS_LUA, 'w', encoding='utf-8') as f:
                f.write(bcs_content)
            print("[OK] BattleCardStatus.lua (CRLF) addCardToBoard updated for Enderman 12338")
        else:
            print("[ERR] target_bcs not found in BattleCardStatus.lua")
else:
    print("[SKIP] BattleCardStatus.lua already has 12338")

# 9. web/src/BattleStep.lua (reset skill counts per round)
BSTEP_LUA = r"D:\yugitauapk\web\src\BattleStep.lua"
with open(BSTEP_LUA, 'r', encoding='utf-8') as f:
    bstep_content = f.read()

bstep_reset = """	arg_2_0._castedSkillCounts[14793] = nil
	arg_2_0._opponent._castedSkillCounts[14793] = nil
	arg_2_0._castedSkillCounts[14794] = nil
	arg_2_0._opponent._castedSkillCounts[14794] = nil
	arg_2_0._castedSkillCounts[14795] = nil
	arg_2_0._opponent._castedSkillCounts[14795] = nil
"""

if 'arg_2_0._castedSkillCounts[14793]' not in bstep_content:
    target_bstep = '\targ_2_0._opponent._castedSkillCounts[3] = nil'
    if target_bstep in bstep_content:
        bstep_content = bstep_content.replace(target_bstep, target_bstep + '\n' + bstep_reset, 1)
        with open(BSTEP_LUA, 'w', encoding='utf-8') as f:
            f.write(bstep_content)
        print("[OK] BattleStep.lua round reset updated for 14793, 14794, 14795")
    else:
        target_bstep_crlf = target_bstep.replace('\n', '\r\n')
        if target_bstep_crlf in bstep_content:
            bstep_content = bstep_content.replace(target_bstep_crlf, target_bstep_crlf + '\r\n' + bstep_reset.replace('\n', '\r\n'), 1)
            with open(BSTEP_LUA, 'w', encoding='utf-8') as f:
                f.write(bstep_content)
            print("[OK] BattleStep.lua (CRLF) round reset updated for 14793, 14794, 14795")
        else:
            print("[ERR] target_bstep not found in BattleStep.lua")
else:
    print("[SKIP] BattleStep.lua already has 14793 reset")

# 10. web/src/h5_patch.lua
HP_LUA = r"D:\yugitauapk\web\src\h5_patch.lua"
with open(HP_LUA, 'r', encoding='utf-8') as f:
    hp_content = f.read()

h5_patch_additions = """
			-- Skeleton (40747)
			if Data._rareInfo and not Data._rareInfo[40747] then
				Data._rareInfo[40747] = {
					_atk = { 1600 },
					_attackEffect = 1,
					_available = 1,
					_bgId = 0,
					_briefNameSid = 57326,
					_category = 17,
					_cost = 0,
					_descSid = 57325,
					_guideSid = 0,
					_hp = { 0 },
					_id = 40747,
					_isHide = 0,
					_joinComponent = { 5008, 6008 },
					_joinResult = { 0 },
					_keyword = 304,
					_link = { 0 },
					_linkAllCandidates = "0.0",
					_linkCandidate = "0.0",
					_linkCount = "0.0",
					_linkSelectedCandidates = "0.0",
					_maxCount = 3,
					_nameSid = 57324,
					_nature = 3,
					_option = 514,
					_originId = 0,
					_packageId = { 0 },
					_picId = 0,
					_py = "skeleton",
					_quality = 3,
					_recruitable = 1,
					_skillId = { 14793 },
					_skin = { 0 },
					_star = 4,
					_syncComponent = { { 0 }, { 0 } }
				}
			end
			if Data._rareInfo and Data._rareInfo[40747] then
				Data._rareInfo[40747]._quality = 3
				Data._rareInfo[40747]._keyword = 304
				Data._rareInfo[40747]._nameSid = 57324
				Data._rareInfo[40747]._descSid = 57325
				Data._rareInfo[40747]._briefNameSid = 57326
				Data._rareInfo[40747]._skillId = { 14793 }
			end

			-- Enderman (12338)
			if Data._monsterInfo and not Data._monsterInfo[12338] then
				Data._monsterInfo[12338] = {
					_atk = { 2000 },
					_attackEffect = 1,
					_available = 1,
					_bgId = 0,
					_briefNameSid = 57331,
					_category = 4,
					_cost = 0,
					_descSid = 57330,
					_guideSid = 0,
					_hp = { 1000 },
					_id = 12338,
					_isHide = 0,
					_joinResult = { 0 },
					_keyword = 304,
					_maxCount = 3,
					_nameSid = 57329,
					_nature = 2,
					_option = 2,
					_originId = 0,
					_packageId = { 0 },
					_picId = 0,
					_py = "enderman",
					_quality = 3,
					_recruitable = 1,
					_skillId = { 12007, 14794, 14795 },
					_skin = { 0 },
					_star = 6,
					_syncComponent = { { 0 } }
				}
			end
			if Data._monsterInfo and Data._monsterInfo[12338] then
				Data._monsterInfo[12338]._quality = 3
				Data._monsterInfo[12338]._keyword = 304
				Data._monsterInfo[12338]._nameSid = 57329
				Data._monsterInfo[12338]._descSid = 57330
				Data._monsterInfo[12338]._briefNameSid = 57331
				Data._monsterInfo[12338]._skillId = { 12007, 14794, 14795 }
			end

			-- Skill 14793
			if Data._skillInfo and not Data._skillInfo[14793] then
				Data._skillInfo[14793] = { _against = { 0 }, _avoidP2B = 0, _count = 3, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57328, _effectVal = { 0 }, _id = 14793, _isIgnoreDefend = 1, _modes = { 33 }, _nameSid = 57327, _needExtraGem = 0, _needNoGem = 0, _option = { 3 }, _priority = 1, _quality = 3, _refCards = { 304 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
			end
			-- Skill 14794
			if Data._skillInfo and not Data._skillInfo[14794] then
				Data._skillInfo[14794] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57333, _effectVal = { 0 }, _id = 14794, _isIgnoreDefend = 0, _modes = { 34 }, _nameSid = 57332, _needExtraGem = 0, _needNoGem = 0, _option = { 0 }, _priority = 0, _quality = 3, _refCards = { 304 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
			end
			-- Skill 14795
			if Data._skillInfo and not Data._skillInfo[14795] then
				Data._skillInfo[14795] = { _against = { 0 }, _avoidP2B = 0, _count = 1, _decrease = { 0, 0, 0, 0, 0 }, _descSid = 57335, _effectVal = { 0 }, _id = 14795, _isIgnoreDefend = 1, _modes = { 2 }, _nameSid = 57334, _needExtraGem = 0, _needNoGem = 0, _option = { 1 }, _priority = 1, _quality = 3, _refCards = { 0 }, _refSkills = { 0 }, _removeMode = { 0 }, _targetType = 0, _val = { 0 } }
			end
"""

if 'Data._rareInfo[40747]' not in hp_content:
    target_hp = 'Data._monsterInfo[12337]._skillId = { 14792 }\n\t\t\tend'
    if target_hp in hp_content:
        hp_content = hp_content.replace(target_hp, target_hp + h5_patch_additions, 1)
        with open(HP_LUA, 'w', encoding='utf-8') as f:
            f.write(hp_content)
        print("[OK] h5_patch.lua updated with 40747, 12338 and skills 14793-14795")
    else:
        target_hp_crlf = target_hp.replace('\n', '\r\n')
        if target_hp_crlf in hp_content:
            hp_content = hp_content.replace(target_hp_crlf, target_hp_crlf + h5_patch_additions.replace('\n', '\r\n'), 1)
            with open(HP_LUA, 'w', encoding='utf-8') as f:
                f.write(hp_content)
            print("[OK] h5_patch.lua (CRLF) updated with 40747, 12338 and skills 14793-14795")
        else:
            print("[ERR] target_hp not found in h5_patch.lua")
else:
    print("[SKIP] h5_patch.lua already has 40747")

print("[OK] All code and data modifications completed successfully!")
