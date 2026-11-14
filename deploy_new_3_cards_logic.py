# -*- coding: utf-8 -*-
import os

print("[*] Starting deploy_new_3_cards_logic.py...")

# =========================================================================
# 1. BattleCard.lua: canChangeToAttack (_lockedPostureTurn) & canAttack (_peaceLockTurn)
# =========================================================================
BC_PATH = r"D:\yugitauapk\web\src\BattleCard.lua"
with open(BC_PATH, 'r', encoding='utf-8') as f:
    bc_code = f.read()

# 1.a) canAttack
target_can_attack = "function var_0_0.canAttack(arg_215_0, arg_215_1)"
repl_can_attack = """function var_0_0.canAttack(arg_215_0, arg_215_1)
	-- Heino x Dolia (40782 / 20239): Phong Toa Khong Gian: khong the tan cong trong 1 luot
	if arg_215_0._owner and arg_215_0._owner._peaceLockTurn then
		local turnId = (arg_215_0._owner._round or 0) * 1000 + (arg_215_0._owner._opponent and arg_215_0._owner._opponent._round or 0)
		if arg_215_0._owner._peaceLockTurn == turnId then
			return false
		end
	end"""

if target_can_attack in bc_code and "_peaceLockTurn" not in bc_code:
    bc_code = bc_code.replace(target_can_attack, repl_can_attack, 1)
    print("[OK] BattleCard.lua: Added _peaceLockTurn check to canAttack.")

# 1.b) canChangeToAttack
target_can_change = "function var_0_0.canChangeToAttack(arg_217_0)"
repl_can_change = """function var_0_0.canChangeToAttack(arg_217_0)
	-- Heino (12388 / 20238): Khong the thay doi tu the trong luot hoi sinh
	if arg_217_0._lockedPostureTurn and arg_217_0._owner then
		local turnId = (arg_217_0._owner._round or 0) * 1000 + (arg_217_0._owner._opponent and arg_217_0._owner._opponent._round or 0)
		if arg_217_0._lockedPostureTurn == turnId then
			return false
		end
	end"""

if target_can_change in bc_code and "_lockedPostureTurn" not in bc_code:
    bc_code = bc_code.replace(target_can_change, repl_can_change, 1)
    print("[OK] BattleCard.lua: Added _lockedPostureTurn check to canChangeToAttack.")

with open(BC_PATH, 'w', encoding='utf-8') as f:
    f.write(bc_code)

# =========================================================================
# 2. BattleStep.lua: Round begin Dolia (12387 / 20237) heal in grave
# =========================================================================
STEP_PATH = r"D:\yugitauapk\web\src\BattleStep.lua"
with open(STEP_PATH, 'r', encoding='utf-8') as f:
    step_code = f.read()

target_step_round = """	if arg_2_0._round == (arg_2_0._battleType == Data.BattleType.PVP_room and 2 or 1) then
		local var_2_12 = arg_2_0:getBattleCardsBySkillFast("R", 13354)

		B.appendTable(var_2_11, var_2_12)
	end"""

repl_step_round = target_step_round + """

	-- Dolia (12387 / 20237): Khi o trong mo, bat dau moi luot phe ta, phe ta nhan 500 LP
	for _, gc in ipairs(arg_2_0:getBattleCards("G")) do
		if gc._infoId == 12387 or gc:hasSkillFast(20237) then
			if arg_2_0._fortress then
				arg_2_0:incHp(arg_2_0._fortress, 500, false, gc._id, 20237, Data.SkillMode.round_begin)
			end
		end
	end"""

if target_step_round in step_code and "Dolia (12387 / 20237)" not in step_code:
    step_code = step_code.replace(target_step_round, repl_step_round, 1)
    with open(STEP_PATH, 'w', encoding='utf-8') as f:
        f.write(step_code)
    print("[OK] BattleStep.lua: Added Dolia round_begin grave heal.")

# =========================================================================
# 3. BattleSkill.lua: canUseInitiativeSkill, canUseInitiativeSkill1, castMonsterSpellSkill
# =========================================================================
BS_PATH = r"D:\yugitauapk\web\src\BattleSkill.lua"
with open(BS_PATH, 'r', encoding='utf-8') as f:
    bs_code = f.read()

# 3.a) canUseInitiativeSkill
target_can_use_bs = "arg_36_2._id == 20233 or arg_36_2._id == 20235"
repl_can_use_bs = "arg_36_2._id == 20233 or arg_36_2._id == 20235 or arg_36_2._id == 20238 or arg_36_2._id == 20239 or arg_36_2._id == 20240"

if target_can_use_bs in bs_code:
    bs_code = bs_code.replace(target_can_use_bs, repl_can_use_bs, 1)
    print("[OK] BattleSkill.lua: canUseInitiativeSkill updated with 20238..20240.")

# 3.b) canUseInitiativeSkill1
target_can_use_1_bs = """		return selfHp < oppoHp"""

repl_can_use_1_bs = """		return selfHp < oppoHp
	elseif var_37_0 == 20238 then
		-- HEINO (12388): Chu dong mo: 1 luot 1 lan, trieu hoi dac biet the thu len san
		if (arg_37_0._castedSkillCounts[var_37_0] or 0) > 0 then
			return false
		end
		if arg_37_1._status ~= BattleData.CardStatus.grave then
			return false
		end
		if arg_37_0._isSummonDisabled or arg_37_0._isSpecialSummonDisabled or not arg_37_0:canSpecialSummon(arg_37_1) then
			return false
		end
		if #arg_37_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD then
			return false
		end
		return arg_37_0:getEmptyBoardPos(arg_37_1) ~= nil
	elseif var_37_0 == 20239 then
		-- HEINO X DOLIA (40782): Chu dong san: kich hoat 1 lan neu phe ta chua tan cong: ca 2 ben khong the tan cong 1 luot
		if (arg_37_0._castedSkillCounts[var_37_0] or 0) > 0 or arg_37_1._heinoDoliaLockUsed then
			return false
		end
		if arg_37_1._status ~= BattleData.CardStatus.board then
			return false
		end
		if arg_37_0._isAnyMonsterActioned then
			return false
		end
		for _, bc in ipairs(arg_37_0:getBoardCards()) do
			if (bc._actionIndex and bc._actionIndex > 0) or bc._hasAttacked then
				return false
			end
		end
		return true
	elseif var_37_0 == 20240 then
		-- HEINO X DOLIA (40782): Chu dong mo: loai bo ban than, rut 1 la
		if arg_37_1._status ~= BattleData.CardStatus.grave or not arg_37_1:canChangeToLeave() then
			return false
		end
		return #arg_37_0:filterCanChangeToHandCards(arg_37_0:getBattleCards("P")) > 0"""

if target_can_use_1_bs in bs_code and "var_37_0 == 20238" not in bs_code:
    bs_code = bs_code.replace(target_can_use_1_bs, repl_can_use_1_bs, 1)
    print("[OK] BattleSkill.lua: canUseInitiativeSkill1 updated with 20238..20240.")

# 3.c) castMonsterSpellSkill handlers
target_cast_bs = """		if healAmount > 0 and pOwner._fortress then
			arg_4_0:incHp(pOwner._fortress, healAmount, false, var_4_5, var_4_4, arg_4_3)
			var_4_13 = true
		end"""

repl_cast_bs = target_cast_bs + """
	elseif var_4_4 == 20237 then
		-- DOLIA (12387): Khuc Ca Dai Duong
		local doliaCard = var_4_1 or arg_4_1
		local pOwner = (doliaCard and doliaCard._owner) or arg_4_0
		if pOwner and pOwner._fortress then
			arg_4_0:incHp(pOwner._fortress, 500, false, var_4_5, var_4_4, arg_4_3)
			var_4_13 = true
		end
	elseif var_4_4 == 20238 then
		-- HEINO (12388): Chu dong mo: 1 luot 1 lan, trieu hoi dac biet the thu len san (khong the doi tu the)
		local heinoCard = var_4_1 or arg_4_1
		local pOwner = (heinoCard and heinoCard._owner) or arg_4_0
		pOwner._castedSkillCounts[var_4_4] = (pOwner._castedSkillCounts[var_4_4] or 0) + 1
		if heinoCard and heinoCard._status == BattleData.CardStatus.grave then
			local emptyPos = pOwner:getEmptyBoardPos(heinoCard)
			if emptyPos then
				heinoCard._saved._pos = emptyPos
				pOwner:setCardStatus(heinoCard, BattleData.CardStatus.board, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.g2b_normal)
				heinoCard:addBuff(true, BattleData.PositiveType.defendPosture, 1)
				pOwner:incPositiveStatus(heinoCard, { BattleData.PositiveType.defendPosture }, false, var_4_5, var_4_4, arg_4_3)
				local turnId = (pOwner._round or 0) * 1000 + (pOwner._opponent and pOwner._opponent._round or 0)
				heinoCard._lockedPostureTurn = turnId
				var_4_13 = true
			end
		end
	elseif var_4_4 == 20239 then
		-- HEINO X DOLIA (40782): Phong Toa Khong Gian: ca 2 ben khong the tan cong trong 1 luot
		local hdCard = var_4_1 or arg_4_1
		local pOwner = (hdCard and hdCard._owner) or arg_4_0
		pOwner._castedSkillCounts[var_4_4] = (pOwner._castedSkillCounts[var_4_4] or 0) + 1
		if hdCard then
			hdCard._heinoDoliaLockUsed = true
		end
		local turnId = (pOwner._round or 0) * 1000 + (pOwner._opponent and pOwner._opponent._round or 0)
		pOwner._peaceLockTurn = turnId
		if pOwner._opponent then
			pOwner._opponent._peaceLockTurn = turnId
		end
		var_4_13 = true
	elseif var_4_4 == 20240 then
		-- HEINO X DOLIA (40782): Ky Uc Thoi Gian: Loai bo ban than tu mo, rut 1 la
		local hdCard = var_4_1 or arg_4_1
		local pOwner = (hdCard and hdCard._owner) or arg_4_0
		if hdCard and hdCard._status == BattleData.CardStatus.grave then
			pOwner:setCardStatus(hdCard, BattleData.CardStatus.leave, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.g2l_cost)
			local pileCards = pOwner:filterCanChangeToHandCards(pOwner:getBattleCards("P"))
			if #pileCards > 0 then
				pOwner:setCardStatus(pileCards[1], BattleData.CardStatus.hand, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.p2h_draw)
			end
			var_4_13 = true
		end"""

if target_cast_bs in bs_code and "var_4_4 == 20237" not in bs_code:
    bs_code = bs_code.replace(target_cast_bs, repl_cast_bs, 1)
    print("[OK] BattleSkill.lua: castMonsterSpellSkill updated with 20237..20240.")

with open(BS_PATH, 'w', encoding='utf-8') as f:
    f.write(bs_code)

print("[*] Finished deploy_new_3_cards_logic.py successfully!")
