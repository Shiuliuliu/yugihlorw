import sys, os, pymysql

sys.stdout.reconfigure(encoding='utf-8')

print("[*] Starting complete implementation of Labrynth Batch 3 gameplay logic...")

def replace_once(path, old, new, label=""):
    with open(path, "r", encoding="utf-8") as f:
        text = f.read()
    if new in text:
        print(f"[SKIP] Already applied in {path} ({label})")
        return
    if old not in text:
        old_crlf = old.replace("\n", "\r\n")
        new_crlf = new.replace("\n", "\r\n")
        if new_crlf in text:
            print(f"[SKIP] Already applied (CRLF) in {path} ({label})")
            return
        if old_crlf in text:
            text = text.replace(old_crlf, new_crlf, 1)
        else:
            raise AssertionError(f"Target not found in {path} ({label})")
    else:
        text = text.replace(old, new, 1)
    with open(path, "w", encoding="utf-8") as f:
        f.write(text)
    print(f"[OK] Updated {path} ({label})")

# ==============================================================================
# 1. BattleCard.lua
# ==============================================================================
# a) Shield in hasShieldInType
bc_shield_target = """	if not arg_40_2 and arg_40_0._status == BattleData.CardStatus.board then
		local cid = arg_40_0._infoId"""

bc_shield_code = """	if not arg_40_2 and arg_40_0._status == BattleData.CardStatus.board then
		-- Labrynth Labyrinth (21173 / 20214): Quai Labrynth nhan Khien Chan Quai / Phep / Bay
		if (arg_40_0:isKeyword(308) or (arg_40_0._info and arg_40_0._info._keyword == 308)) and arg_40_0._owner and arg_40_0._owner._boardCards then
			for _, bc in ipairs(arg_40_0._owner._boardCards) do
				if bc and (bc:isInfoId(21173) or bc._infoId == 21173 or bc:hasSkillFast(20214)) then
					if (arg_40_1 >= BattleData.PositiveType.shieldMonster and arg_40_1 <= BattleData.PositiveType.shieldTrap) or (arg_40_1 >= BattleData.PositiveType.shieldExMonster and arg_40_1 <= BattleData.PositiveType.shieldExTrap) then
						return true
					end
					break
				end
			end
		end

		local cid = arg_40_0._infoId"""
replace_once(r"D:\yugitauapk\web\src\BattleCard.lua", bc_shield_target, bc_shield_code, "BattleCard hasShieldInType Labyrinth")

# b) Shield in hasShieldExInType
bc_shield_ex_target = """	if not arg_41_2 and arg_41_0._status == BattleData.CardStatus.board then
		local cid = arg_41_0._infoId"""

bc_shield_ex_code = """	if not arg_41_2 and arg_41_0._status == BattleData.CardStatus.board then
		if (arg_41_0:isKeyword(308) or (arg_41_0._info and arg_41_0._info._keyword == 308)) and arg_41_0._owner and arg_41_0._owner._boardCards then
			for _, bc in ipairs(arg_41_0._owner._boardCards) do
				if bc and (bc:isInfoId(21173) or bc._infoId == 21173 or bc:hasSkillFast(20214)) then
					if (arg_41_1 >= BattleData.PositiveType.shieldMonster and arg_41_1 <= BattleData.PositiveType.shieldTrap) or (arg_41_1 >= BattleData.PositiveType.shieldExMonster and arg_41_1 <= BattleData.PositiveType.shieldExTrap) then
						return true
					end
					break
				end
			end
		end

		local cid = arg_41_0._infoId"""
replace_once(r"D:\yugitauapk\web\src\BattleCard.lua", bc_shield_ex_target, bc_shield_ex_code, "BattleCard hasShieldExInType Labyrinth")

# c) ATK in getAtk
bc_atk_target = """	-- Kiêu Hãnh Saiyan (20097) / Vegeta - SSJ Blue 2 (40776)"""
bc_atk_code = """	-- Labrynth Labyrinth (21173 / 20214): +300 ATK cho quai Labrynth
	if (arg_282_0:isKeyword(308) or (arg_282_0._info and arg_282_0._info._keyword == 308)) and arg_282_0._status == BattleData.CardStatus.board then
		local owner = arg_282_0._owner
		if owner and owner._boardCards then
			for _, bc in ipairs(owner._boardCards) do
				if bc and (bc:isInfoId(21173) or bc._infoId == 21173 or bc:hasSkillFast(20214)) then
					local labBonus = 300
					local oldLabBonus = arg_282_0._labLabyrinthBonus or 0
					if labBonus ~= oldLabBonus then
						arg_282_0._atk = (arg_282_0._atk or arg_282_0._maxAtk or 0) - oldLabBonus + labBonus
						arg_282_0._labLabyrinthBonus = labBonus
					end
					break
				end
			end
		end
	end

	-- Kiêu Hãnh Saiyan (20097) / Vegeta - SSJ Blue 2 (40776)"""
replace_once(r"D:\yugitauapk\web\src\BattleCard.lua", bc_atk_target, bc_atk_code, "BattleCard getAtk Labyrinth")

# ==============================================================================
# 2. BattleSkill.lua: canUseTrap, canUseMagic, canTriggerTrapWhenAttack, canTriggerTrapWhenStatusChange
# ==============================================================================
# a) canUseTrap
bs_trap_target = """	if var_27_1 == 20117 then"""
bs_trap_code = """	if var_27_1 == 20197 then
		-- Labrynth Barrage (30603)
		return #arg_27_0:getBattleCards("C") + #arg_27_0:getBattleCards("S") < Data.MAX_CARD_COUNT_ON_BOARD
	elseif var_27_1 == 20200 then
		-- Barrage trigger: sac self when trap activated to add 8-star Labrynth
		if (arg_27_0._castedSkillCounts[20200] or 0) > 0 then return false end
		for _, c in ipairs(B.mergeTable({ arg_27_0:getBattleCards("G"), arg_27_0:getBattleCards("L") })) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:getStar() == 8 and c:canChangeToHand() then
				return true
			end
		end
		return false
	elseif var_27_1 == 20202 then
		-- Welcome Labrynth (30604): 1 luot 1 la, sp summon Labrynth from hand/deck
		if (arg_27_0._castedSkillCounts[20202] or 0) > 0 then return false end
		if #arg_27_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_27_0._isSummonDisabled or arg_27_0._isSpecialSummonDisabled then return false end
		for _, c in ipairs(arg_27_0:getBattleCards("H")) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and arg_27_0:getEmptyBoardPos(c) ~= nil and arg_27_0:canSpecialSummon(c) then return true end
		end
		for _, c in ipairs(arg_27_0:filterCanChangeToBoardCards(arg_27_0:getBattleCards("P"))) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and arg_27_0:getEmptyBoardPos(c) ~= nil and arg_27_0:canSpecialSummon(c) then return true end
		end
		return false
	elseif var_27_1 == 20206 then
		-- Big Welcome Labrynth (30605): 1 luot 1 la, sp summon Labrynth from hand/deck/grave/leave
		if (arg_27_0._castedSkillCounts[20206] or 0) > 0 then return false end
		if #arg_27_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_27_0._isSummonDisabled or arg_27_0._isSpecialSummonDisabled then return false end
		for _, c in ipairs(B.mergeTable({ arg_27_0:getBattleCards("H"), arg_27_0:getBattleCards("P"), arg_27_0:getBattleCards("G"), arg_27_0:getBattleCards("L") })) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and arg_27_0:getEmptyBoardPos(c) ~= nil and arg_27_0:canSpecialSummon(c) then return true end
		end
		return false
	elseif var_27_1 == 20117 then"""
replace_once(r"D:\yugitauapk\web\src\BattleSkill.lua", bs_trap_target, bs_trap_code, "BattleSkill canUseTrap batch 3")

# b) canUseMagic
bs_magic_target = """	if var_0_2.spellsThisTurn(ks_player) >= var_0_2.SPELLS_PER_TURN then
		return false
	end"""
bs_magic_code = """	if var_0_2.spellsThisTurn(ks_player) >= var_0_2.SPELLS_PER_TURN then
		return false
	end

	if ks_card._infoId == 21172 or ks_card:hasSkillFast(20210) then
		-- Labrynth Set-Up (21172): 1 luot 1 la, shuffle up to 2 Labrynth S/T from grave/leave into deck
		if (ks_player._castedSkillCounts[20210] or 0) > 0 then return false end
		local hasTarget = false
		for _, c in ipairs(B.mergeTable({ ks_player:getBattleCards("G"), ks_player:getBattleCards("L") })) do
			if c ~= ks_card and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) then
				hasTarget = true
				break
			end
		end
		return hasTarget
	elseif ks_card._infoId == 21173 or ks_card:hasSkillFast(20213) then
		-- Labrynth Labyrinth (21173): Field spell
		return #ks_player:getBattleCards("C") + #ks_player:getBattleCards("S") < Data.MAX_CARD_COUNT_ON_BOARD
	end"""
replace_once(r"D:\yugitauapk\web\src\BattleSkill.lua", bs_magic_target, bs_magic_code, "BattleSkill canUseMagic batch 3")

# c) canTriggerTrapWhenAttack
bs_trigger_atk_target = """	if var_33_1 == 5011 or"""
bs_trigger_atk_code = """	if var_33_1 == 20194 then
		-- Farewelcome Labrynth (30602): hand trap when attacked and has Labrynth monster on board
		if arg_33_1._owner == arg_33_2._owner then return false end
		local hasLab = false
		for _, c in ipairs(arg_33_1._owner:getBoardCards()) do
			if c:isKeyword(308) or (c._info and c._info._keyword == 308) then
				hasLab = true
				break
			end
		end
		return hasLab
	elseif var_33_1 == 20196 or var_33_1 == 20201 or var_33_1 == 20205 or var_33_1 == 20209 then
		-- Grave attack reaction: once per turn
		if arg_33_1._owner == arg_33_2._owner then return false end
		return (arg_33_1._owner._castedSkillCounts[var_33_1] or 0) == 0
	elseif var_33_1 == 5011 or"""
replace_once(r"D:\yugitauapk\web\src\BattleSkill.lua", bs_trigger_atk_target, bs_trigger_atk_code, "BattleSkill canTriggerTrapWhenAttack batch 3")

# d) canTriggerTrapWhenStatusChange
bs_trigger_status_target = """	if var_32_1 == 5029 or"""
bs_trigger_status_code = """	if var_32_1 == 20200 then
		-- Barrage (30603): when self activates trap
		if (arg_32_1._owner._castedSkillCounts[20200] or 0) > 0 then return false end
		local actCard = arg_32_2
		if not actCard or actCard._owner ~= arg_32_1._owner or actCard == arg_32_1 then return false end
		return actCard:isTrap() or actCard._type == Data.CardType.trap
	elseif var_32_1 == 20203 then
		-- Welcome Labrynth in grave: when self summons Labrynth monster -> draw 1
		if (arg_32_1._owner._castedSkillCounts[20203] or 0) > 0 then return false end
		local actCard = arg_32_2
		if not actCard or actCard._owner ~= arg_32_1._owner then return false end
		return isMonsterCard(actCard) and (actCard:isKeyword(308) or (actCard._info and actCard._info._keyword == 308))
	elseif var_32_1 == 20204 then
		-- Welcome Labrynth in grave/leave: when Labrynth monster leaves board by trap -> return to hand
		if (arg_32_1._owner._castedSkillCounts[20204] or 0) > 0 then return false end
		local actCard = arg_32_2
		if not actCard or actCard._owner ~= arg_32_1._owner then return false end
		return isMonsterCard(actCard) and (actCard:isKeyword(308) or (actCard._info and actCard._info._keyword == 308))
	elseif var_32_1 == 20215 then
		-- Labrynth Labyrinth (21173): when self activates trap -> sp summon Labrynth monster from hand
		if (arg_32_1._owner._castedSkillCounts[20215] or 0) > 0 then return false end
		local actCard = arg_32_2
		if not actCard or actCard._owner ~= arg_32_1._owner then return false end
		if not (actCard:isTrap() or actCard._type == Data.CardType.trap) then return false end
		if #arg_32_1._owner:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_32_1._owner._isSummonDisabled or arg_32_1._owner._isSpecialSummonDisabled then return false end
		for _, c in ipairs(arg_32_1._owner:getBattleCards("H")) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and arg_32_1._owner:getEmptyBoardPos(c) ~= nil and arg_32_1._owner:canSpecialSummon(c) then
				return true
			end
		end
		return false
	elseif var_32_1 == 5029 or"""
replace_once(r"D:\yugitauapk\web\src\BattleSkill.lua", bs_trigger_status_target, bs_trigger_status_code, "BattleSkill canTriggerTrapWhenStatusChange batch 3")

# ==============================================================================
# 3. BattleSkill.lua: castSkill executions
# ==============================================================================
bs_cast_target = """	elseif var_9_4 == 20117 then"""
bs_cast_code = """	elseif var_9_4 == 20194 then
		-- FAREWELCOME LABRYNTH (30602): hand trap when attacked -> negate attack, send attacker to grave (pierce trap wall)
		arg_9_0:setCardStatus(arg_9_1, BattleData.CardStatus.grave, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.h2g_self)
		local atkCard = var_9_12 or (arg_9_0._opponent and arg_9_0._opponent._actionCard)
		if atkCard and B.isAlive(atkCard) then
			atkCard._cannotAttack = true
			arg_9_0:setCardStatus(atkCard, BattleData.CardStatus.grave, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.x2gl_oppo_cost)
		end
		var_9_13 = true
	elseif var_9_4 == 20196 or var_9_4 == 20201 or var_9_4 == 20205 or var_9_4 == 20209 then
		-- Grave attack reaction: Banish self -> buff board Labrynth ATK, or lock all oppo attacks if no Labrynth on board but in grave
		arg_9_0._castedSkillCounts[var_9_4] = (arg_9_0._castedSkillCounts[var_9_4] or 0) + 1
		arg_9_0:setCardStatus(arg_9_1, BattleData.CardStatus.leave, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.g2l_cost)
		local boardLabMonsters = {}
		for _, c in ipairs(arg_9_0:getBoardCards()) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
				table.insert(boardLabMonsters, c)
			end
		end
		if #boardLabMonsters > 0 then
			local labSTCount = 0
			for _, c in ipairs(B.mergeTable({ arg_9_0:getBattleCards("G"), arg_9_0:getBattleCards("L") })) do
				if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) then
					labSTCount = labSTCount + 1
				end
			end
			local atkInc = labSTCount * 200
			if atkInc > 0 then
				for _, m in ipairs(boardLabMonsters) do
					m._atk = (m._atk or m._maxAtk or 0) + atkInc
				end
			end
		else
			local hasLabInGrave = false
			for _, c in ipairs(arg_9_0:getBattleCards("G")) do
				if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
					hasLabInGrave = true
					break
				end
			end
			if hasLabInGrave and arg_9_0._opponent then
				arg_9_0._opponent._labrynthAllAttackLockedTurn = arg_9_0._round
				local oppoAtkCard = var_9_12 or arg_9_0._opponent._actionCard
				if oppoAtkCard then oppoAtkCard._cannotAttack = true end
			end
		end
		var_9_13 = true
	elseif var_9_4 == 20197 then
		-- LABRYNTH BARRAGE (30603): Activate and place into S/T zone
		arg_9_0:setCardStatus(arg_9_1, BattleData.CardStatus.board, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.h2b_normal)
		var_9_13 = true
	elseif var_9_4 == 20200 then
		-- LABRYNTH BARRAGE (30603): Sac self -> add 1 8-star Labrynth from grave/leave to hand
		arg_9_0._castedSkillCounts[20200] = (arg_9_0._castedSkillCounts[20200] or 0) + 1
		arg_9_0:setCardStatus(arg_9_1, BattleData.CardStatus.grave, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.b2g_sacrifice)
		local targets8 = {}
		for _, c in ipairs(B.mergeTable({ arg_9_0:getBattleCards("G"), arg_9_0:getBattleCards("L") })) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:getStar() == 8 and c:canChangeToHand() then
				table.insert(targets8, c)
			end
		end
		if #targets8 > 0 then
			local chosen = (var_9_15 and arg_9_0:getCardById(var_9_15)) or arg_9_0:randomOne(targets8)
			if chosen then
				arg_9_0:setCardStatus(chosen, BattleData.CardStatus.hand, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.g2h_draw)
			end
		end
		var_9_13 = true
	elseif var_9_4 == 20202 then
		-- WELCOME LABRYNTH (30604): 1 luot 1 la, sp summon Labrynth from hand/deck -> lock non-Labrynth sp summon
		arg_9_0._castedSkillCounts[20202] = (arg_9_0._castedSkillCounts[20202] or 0) + 1
		arg_9_0:setCardStatus(arg_9_1, BattleData.CardStatus.grave, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.x2gl_cost)
		local cands = {}
		for _, c in ipairs(arg_9_0:getBattleCards("H")) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and arg_9_0:getEmptyBoardPos(c) ~= nil and arg_9_0:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		for _, c in ipairs(arg_9_0:filterCanChangeToBoardCards(arg_9_0:getBattleCards("P"))) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and arg_9_0:getEmptyBoardPos(c) ~= nil and arg_9_0:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			local chosen = (var_9_15 and arg_9_0:getCardById(var_9_15)) or arg_9_0:randomOne(cands)
			if chosen then
				local srcVal = (chosen._status == BattleData.CardStatus.hand) and BattleData.CardStatusVal.h2b_normal or BattleData.CardStatusVal.p2b_normal
				arg_9_0:setCardStatus(chosen, BattleData.CardStatus.board, var_9_5, var_9_4, arg_9_3, srcVal)
			end
		end
		arg_9_0._onlyLabrynthSpecialTurn = (arg_9_0._round or 0) * 1000 + (arg_9_0._opponent and arg_9_0._opponent._round or 0)
		var_9_13 = true
	elseif var_9_4 == 20203 then
		-- WELCOME LABRYNTH (30604): In grave, draw 1 card when Labrynth monster summoned
		arg_9_0._castedSkillCounts[20203] = (arg_9_0._castedSkillCounts[20203] or 0) + 1
		if arg_9_0:canDrawCards() then
			arg_9_0:drawCards(1)
		end
		var_9_13 = true
	elseif var_9_4 == 20204 then
		-- WELCOME LABRYNTH (30604): Return self to hand from grave/leave
		arg_9_0._castedSkillCounts[20204] = (arg_9_0._castedSkillCounts[20204] or 0) + 1
		arg_9_0:setCardStatus(arg_9_1, BattleData.CardStatus.hand, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.g2h_draw)
		var_9_13 = true
	elseif var_9_4 == 20206 then
		-- BIG WELCOME LABRYNTH (30605): 1 luot 1 la, sp summon Labrynth from hand/deck/grave/leave -> return 1 board monster to hand
		arg_9_0._castedSkillCounts[20206] = (arg_9_0._castedSkillCounts[20206] or 0) + 1
		arg_9_0:setCardStatus(arg_9_1, BattleData.CardStatus.grave, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.x2gl_cost)
		local cands = {}
		for _, c in ipairs(B.mergeTable({ arg_9_0:getBattleCards("H"), arg_9_0:getBattleCards("P"), arg_9_0:getBattleCards("G"), arg_9_0:getBattleCards("L") })) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and arg_9_0:getEmptyBoardPos(c) ~= nil and arg_9_0:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 then
			local chosen = (var_9_15 and arg_9_0:getCardById(var_9_15)) or arg_9_0:randomOne(cands)
			if chosen then
				local srcVal = (chosen._status == BattleData.CardStatus.hand) and BattleData.CardStatusVal.h2b_normal or ((chosen._status == BattleData.CardStatus.grave) and BattleData.CardStatusVal.g2b_normal or BattleData.CardStatusVal.p2b_normal)
				arg_9_0:setCardStatus(chosen, BattleData.CardStatus.board, var_9_5, var_9_4, arg_9_3, srcVal)
			end
		end
		local myBoard = arg_9_0:getBoardCards()
		if #myBoard > 0 then
			local toHand = arg_9_0:randomOne(myBoard)
			if toHand and toHand:canChangeToHand() then
				arg_9_0:setCardStatus(toHand, BattleData.CardStatus.hand, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.b2h_normal)
			end
		end
		var_9_13 = true
	elseif var_9_4 == 20210 then
		-- LABRYNTH SET-UP (21172): 1 luot 1 la, shuffle up to 2 Labrynth S/T into deck -> add non-Labrynth Traps from deck to hand
		arg_9_0._castedSkillCounts[20210] = (arg_9_0._castedSkillCounts[20210] or 0) + 1
		local targetsST = {}
		for _, c in ipairs(B.mergeTable({ arg_9_0:getBattleCards("G"), arg_9_0:getBattleCards("L") })) do
			if c ~= arg_9_1 and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) then
				table.insert(targetsST, c)
			end
		end
		local shuffledCount = 0
		for i = 1, math.min(2, #targetsST) do
			local sc = targetsST[i]
			arg_9_0:setCardStatus(sc, BattleData.CardStatus.pile, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.g2p_normal)
			shuffledCount = shuffledCount + 1
		end
		local hasBoardLab = false
		for _, c in ipairs(arg_9_0:getBoardCards()) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
				hasBoardLab = true
				break
			end
		end
		if hasBoardLab and shuffledCount > 0 then
			local nonLabTraps = {}
			local seenNames = {}
			for _, c in ipairs(arg_9_0:getBattleCards("P")) do
				if (c:isTrap() or c._type == Data.CardType.trap) and not (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
					local nameKey = c._info and c._info._nameSid or c._id
					if not seenNames[nameKey] then
						seenNames[nameKey] = true
						table.insert(nonLabTraps, c)
					end
				end
			end
			for i = 1, math.min(shuffledCount, #nonLabTraps) do
				arg_9_0:setCardStatus(nonLabTraps[i], BattleData.CardStatus.hand, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.p2h_draw)
			end
		end
		arg_9_0:setCardStatus(arg_9_1, BattleData.CardStatus.grave, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.x2gl_cost)
		var_9_13 = true
	elseif var_9_4 == 20213 then
		-- LABRYNTH LABYRINTH (21173): Place into S/T zone
		arg_9_0:setCardStatus(arg_9_1, BattleData.CardStatus.board, var_9_5, var_9_4, arg_9_3, BattleData.CardStatusVal.h2b_normal)
		var_9_13 = true
	elseif var_9_4 == 20117 then"""
replace_once(r"D:\yugitauapk\web\src\BattleSkill.lua", bs_cast_target, bs_cast_code, "BattleSkill castSkill batch 3")

# ==============================================================================
# 4. BattleSkill.lua: var_0_lab.canUseLabSkill & handlers
# ==============================================================================
bs_lab_target = """	elseif sid == 20193 then
		-- PRINCESS (12381): Kỹ năng mộ chủ động: Loại bỏ 2 lá bài trong mộ đối thủ; Triệu hồi đặc biệt bản thân từ mộ
		if arg_cu_1._status ~= BattleData.CardStatus.grave or not arg_cu_1:canChangeToBoard() then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0:getEmptyBoardPos(arg_cu_1) == nil or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled or not arg_cu_0:canSpecialSummon(arg_cu_1) then
			return false
		end
		local oppo = arg_cu_0._opponent
		return oppo and #oppo:getBattleCards("G") >= 2
	end"""

bs_lab_code = """	elseif sid == 20193 then
		-- PRINCESS (12381): Kỹ năng mộ chủ động: Loại bỏ 2 lá bài trong mộ đối thủ; Triệu hồi đặc biệt bản thân từ mộ
		if arg_cu_1._status ~= BattleData.CardStatus.grave or not arg_cu_1:canChangeToBoard() then
			return false
		end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0:getEmptyBoardPos(arg_cu_1) == nil or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled or not arg_cu_0:canSpecialSummon(arg_cu_1) then
			return false
		end
		local oppo = arg_cu_0._opponent
		return oppo and #oppo:getBattleCards("G") >= 2

	elseif sid == 20195 then
		-- FAREWELCOME (30602): Kỹ năng mộ chủ động: Banish self -> add 1 Labrynth S/T from deck to hand
		if arg_cu_1._status ~= BattleData.CardStatus.grave or not arg_cu_1:canChangeToLeave() then return false end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToHandCards(arg_cu_0:getBattleCards("P"))) do
			if (pc:isKeyword(308) or (pc._info and pc._info._keyword == 308)) and (pc:isMagic() or pc:isTrap() or pc._type == Data.CardType.magic or pc._type == Data.CardType.trap) then
				return true
			end
		end
		return false

	elseif sid == 20198 then
		-- BARRAGE (30603): Chủ động Ⅰ: Sp summon 1 5 or 7 star Labrynth monster from deck in def posture
		if arg_cu_1._status ~= BattleData.CardStatus.board and arg_cu_1._status ~= BattleData.CardStatus.field then return false end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled then return false end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToBoardCards(arg_cu_0:getBattleCards("P"))) do
			if isMonsterCard(pc) and (pc:isKeyword(308) or (pc._info and pc._info._keyword == 308)) and (pc:getStar() == 5 or pc:getStar() == 7) and arg_cu_0:getEmptyBoardPos(pc) ~= nil and arg_cu_0:canSpecialSummon(pc) then
				return true
			end
		end
		return false

	elseif sid == 20199 then
		-- BARRAGE (30603): Chủ động Ⅱ: Place Labrynth field spell (21173) from deck into S/T zone
		if arg_cu_1._status ~= BattleData.CardStatus.board and arg_cu_1._status ~= BattleData.CardStatus.field then return false end
		if #arg_cu_0:getBattleCards("C") + #arg_cu_0:getBattleCards("S") >= Data.MAX_CARD_COUNT_ON_BOARD then return false end
		for _, pc in ipairs(arg_cu_0:getBattleCards("P")) do
			if pc._infoId == 21173 or (pc:isKeyword(308) and pc:isMagic() and pc._info and pc._info._option == 4) then
				return true
			end
		end
		return false

	elseif sid == 20207 then
		-- BIG WELCOME (30605): Kỹ năng mộ chủ động: Banish self -> return 1 oppo card on board to hand
		if arg_cu_1._status ~= BattleData.CardStatus.grave or not arg_cu_1:canChangeToLeave() then return false end
		local hasBoardLab = false
		for _, c in ipairs(arg_cu_0:getBoardCards()) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
				hasBoardLab = true
				break
			end
		end
		if not hasBoardLab then return false end
		local oppo = arg_cu_0._opponent
		return oppo and #B.mergeTable({ oppo:getBoardCards(), oppo:getBattleCards("C"), oppo:getBattleCards("S") }) > 0

	elseif sid == 20208 then
		-- BIG WELCOME (30605): Kỹ năng loại bỏ chủ động: Add 1 Labrynth card from grave to hand
		if arg_cu_1._status ~= BattleData.CardStatus.leave then return false end
		for _, c in ipairs(arg_cu_0:getBattleCards("G")) do
			if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:canChangeToHand() then
				return true
			end
		end
		return false

	elseif sid == 20211 then
		-- LABRYNTH SET-UP (21172): Kỹ năng mộ chủ động: Banish self -> add 1 <=4 star Labrynth monster from deck
		if arg_cu_1._status ~= BattleData.CardStatus.grave or not arg_cu_1:canChangeToLeave() then return false end
		for _, pc in ipairs(arg_cu_0:filterCanChangeToHandCards(arg_cu_0:getBattleCards("P"))) do
			if isMonsterCard(pc) and (pc:isKeyword(308) or (pc._info and pc._info._keyword == 308)) and pc:getStar() <= 4 then
				return true
			end
		end
		return false

	elseif sid == 20212 then
		-- LABRYNTH SET-UP (21172): Kỹ năng loại bỏ chủ động: Shuffle 2 cards from oppo grave into deck
		if arg_cu_1._status ~= BattleData.CardStatus.leave then return false end
		local oppo = arg_cu_0._opponent
		return oppo and #oppo:getBattleCards("G") >= 1

	elseif sid == 20215 then
		-- LABRYNTH LABYRINTH (21173): Chủ động: Sp summon 1 Labrynth monster from hand
		if arg_cu_1._status ~= BattleData.CardStatus.board and arg_cu_1._status ~= BattleData.CardStatus.field then return false end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled then return false end
		for _, c in ipairs(arg_cu_0:getBattleCards("H")) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and arg_cu_0:getEmptyBoardPos(c) ~= nil and arg_cu_0:canSpecialSummon(c) then
				return true
			end
		end
		return false

	elseif sid == 20216 then
		-- LABRYNTH LABYRINTH (21173): Chủ động: Send 1 oppo board card to grave (bypass spell wall)
		if arg_cu_1._status ~= BattleData.CardStatus.board and arg_cu_1._status ~= BattleData.CardStatus.field then return false end
		local oppo = arg_cu_0._opponent
		return oppo and #B.mergeTable({ oppo:getBoardCards(), oppo:getBattleCards("C"), oppo:getBattleCards("S") }) > 0

	elseif sid == 20217 then
		-- LABRYNTH LABYRINTH (21173): Chủ động: Add 1 Labrynth S/T from grave/leave to hand
		if arg_cu_1._status ~= BattleData.CardStatus.board and arg_cu_1._status ~= BattleData.CardStatus.field then return false end
		for _, c in ipairs(B.mergeTable({ arg_cu_0:getBattleCards("G"), arg_cu_0:getBattleCards("L") })) do
			if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) and c:canChangeToHand() then
				return true
			end
		end
		return false

	elseif sid == 20218 then
		-- LABRYNTH LABYRINTH (21173): Kỹ năng loại bỏ chủ động: Sp summon 1 non-fusion monster from oppo grave/leave to our board
		if arg_cu_1._status ~= BattleData.CardStatus.leave then return false end
		if #arg_cu_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD or arg_cu_0._isSummonDisabled or arg_cu_0._isSpecialSummonDisabled then return false end
		local oppo = arg_cu_0._opponent
		if not oppo then return false end
		for _, c in ipairs(B.mergeTable({ oppo:getBattleCards("G"), oppo:getBattleCards("L") })) do
			if isMonsterCard(c) and not c:isMerge() and arg_cu_0:getEmptyBoardPos(c) ~= nil and arg_cu_0:canSpecialSummon(c) then
				return true
			end
		end
		return false
	end"""
replace_once(r"D:\yugitauapk\web\src\BattleSkill.lua", bs_lab_target, bs_lab_code, "BattleSkill canUseLabSkill batch 3")

# e) var_0_lab.handlers
bs_handlers_target = """var_0_1.register(308, var_0_lab)"""
bs_handlers_code = """-- 20195 / FAREWELCOME (30602): Banish self -> add 1 Labrynth S/T from deck to hand
var_0_lab.handlers[195] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20195
	local ks_mode = ks_fc.mode or 91

	ks_player._castedSkillCounts[20195] = (ks_player._castedSkillCounts[20195] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.leave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2l_normal)
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2h_draw)
	end
	return true
end

-- 20198 / BARRAGE (30603): Sp summon 1 5 or 7 star Labrynth monster from deck in def posture
var_0_lab.handlers[198] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20198
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20198] = (ks_player._castedSkillCounts[20198] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		local turnId = (ks_player._round or 0) * 1000 + (ks_player._opponent and ks_player._opponent._round or 0)
		targetCard._cannotChangePostureTurn = turnId
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2b_normal)
		ks_player:changePosture(targetCard, false, ks_cid, ks_sid, ks_mode)
	end
	return true
end

-- 20199 / BARRAGE (30603): Place Labrynth Labyrinth from deck to S/T zone
var_0_lab.handlers[199] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20199
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20199] = (ks_player._castedSkillCounts[20199] or 0) + 1
	for _, pc in ipairs(ks_player:getBattleCards("P")) do
		if pc._infoId == 21173 or (pc:isKeyword(308) and pc:isMagic() and pc._info and pc._info._option == 4) then
			ks_battle:setCardStatus(pc, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2b_normal)
			break
		end
	end
	return true
end

-- 20207 / BIG WELCOME (30605): Return 1 oppo card on board to hand
var_0_lab.handlers[207] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20207
	local ks_mode = ks_fc.mode or 91

	ks_player._castedSkillCounts[20207] = (ks_player._castedSkillCounts[20207] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.leave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2l_normal)
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.b2h_normal)
	end
	return true
end

-- 20208 / BIG WELCOME (30605): Add 1 Labrynth card from grave to hand
var_0_lab.handlers[208] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20208
	local ks_mode = ks_fc.mode or 92

	ks_player._castedSkillCounts[20208] = (ks_player._castedSkillCounts[20208] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2h_draw)
	end
	return true
end

-- 20211 / LABRYNTH SET-UP (21172): Banish self -> add 1 <=4 star Labrynth monster from deck to hand
var_0_lab.handlers[211] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20211
	local ks_mode = ks_fc.mode or 91

	ks_player._castedSkillCounts[20211] = (ks_player._castedSkillCounts[20211] or 0) + 1
	ks_battle:setCardStatus(ks_card, BattleData.CardStatus.leave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2l_normal)
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.p2h_draw)
	end
	return true
end

-- 20212 / LABRYNTH SET-UP (21172): Shuffle 2 cards from oppo grave to oppo deck
var_0_lab.handlers[212] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20212
	local ks_mode = ks_fc.mode or 92

	ks_player._castedSkillCounts[20212] = (ks_player._castedSkillCounts[20212] or 0) + 1
	local chosenIds = decodeLabMultiChoice(ks_fc)
	for _, id in ipairs(chosenIds) do
		local tc = ks_battle:getCardById(id)
		if tc and tc._status == BattleData.CardStatus.grave then
			ks_battle:setCardStatus(tc, BattleData.CardStatus.pile, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.g2p_normal)
		end
	end
	return true
end

-- 20215 / LABRYNTH LABYRINTH (21173): Sp summon 1 Labrynth monster from hand
var_0_lab.handlers[215] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20215
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20215] = (ks_player._castedSkillCounts[20215] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.h2b_normal)
	end
	return true
end

-- 20216 / LABRYNTH LABYRINTH (21173): Send 1 oppo card on board to grave
var_0_lab.handlers[216] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20216
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20216] = (ks_player._castedSkillCounts[20216] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.grave, ks_cid, ks_sid, ks_mode, BattleData.CardStatusVal.x2gl_oppo_cost)
	end
	return true
end

-- 20217 / LABRYNTH LABYRINTH (21173): Add 1 Labrynth S/T from grave/leave to hand
var_0_lab.handlers[217] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20217
	local ks_mode = ks_fc.mode or 31

	ks_player._castedSkillCounts[20217] = (ks_player._castedSkillCounts[20217] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		local srcVal = (targetCard._status == BattleData.CardStatus.grave) and BattleData.CardStatusVal.g2h_draw or BattleData.CardStatusVal.l2h_normal
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.hand, ks_cid, ks_sid, ks_mode, srcVal)
	end
	return true
end

-- 20218 / LABRYNTH LABYRINTH (21173): Sp summon 1 non-fusion monster from oppo grave/leave to our board
var_0_lab.handlers[218] = function(ks_fc)
	local ks_battle = ks_fc.battle
	local ks_card = ks_fc.card
	local ks_player = ks_card._owner
	local ks_cid = ks_card._id
	local ks_sid = ks_fc.id or 20218
	local ks_mode = ks_fc.mode or 92

	ks_player._castedSkillCounts[20218] = (ks_player._castedSkillCounts[20218] or 0) + 1
	local chosenId = decodeLabSingleChoice(ks_fc)
	local targetCard = ks_battle:getCardById(chosenId)
	if targetCard then
		local srcVal = (targetCard._status == BattleData.CardStatus.grave) and BattleData.CardStatusVal.g2b_oppo or BattleData.CardStatusVal.l2b_oppo
		ks_battle:setCardStatus(targetCard, BattleData.CardStatus.board, ks_cid, ks_sid, ks_mode, srcVal)
	end
	return true
end

var_0_1.register(308, var_0_lab)"""
replace_once(r"D:\yugitauapk\web\src\BattleSkill.lua", bs_handlers_target, bs_handlers_code, "BattleSkill var_0_lab.handlers batch 3")

# ==============================================================================
# 5. PlayerUi.lua: Choices & UI support
# ==============================================================================
# a) cands in showChoiceCard
pui_cands_target = """	elseif arg_55_2._id == 20155 then"""
pui_cands_code = """	elseif arg_55_2._id == 20195 then
		-- FAREWELCOME (30602): Select 1 Labrynth S/T from deck
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToHandCards(arg_55_0._player:getBattleCards("P"))) do
			if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) then
				table.insert(cands, c)
			end
		end
		return cands
	elseif arg_55_2._id == 20198 then
		-- BARRAGE (30603): Select 1 5 or 7 star Labrynth monster from deck
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToBoardCards(arg_55_0._player:getBattleCards("P"))) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:getStar() == 5 or c:getStar() == 7) and arg_55_0._player:getEmptyBoardPos(c) ~= nil and arg_55_0._player:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		return cands
	elseif arg_55_2._id == 20207 then
		-- BIG WELCOME (30605): Select 1 oppo card on board to return to hand
		local cands = {}
		local oppo = arg_55_0._player._opponent
		if oppo then
			for _, c in ipairs(B.mergeTable({ oppo:getBoardCards(), oppo:getBattleCards("C"), oppo:getBattleCards("S") })) do
				if c:canChangeToHand() then table.insert(cands, c) end
			end
		end
		return cands
	elseif arg_55_2._id == 20208 then
		-- BIG WELCOME (30605): Select 1 Labrynth card from grave to hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("G")) do
			if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:canChangeToHand() then
				table.insert(cands, c)
			end
		end
		return cands
	elseif arg_55_2._id == 20211 then
		-- LABRYNTH SET-UP (21172): Select 1 <=4 star Labrynth monster from deck
		local cands = {}
		for _, c in ipairs(arg_55_0._player:filterCanChangeToHandCards(arg_55_0._player:getBattleCards("P"))) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and c:getStar() <= 4 then
				table.insert(cands, c)
			end
		end
		return cands
	elseif arg_55_2._id == 20212 then
		-- LABRYNTH SET-UP (21172): Select 2 cards from oppo grave to deck
		local cands = {}
		local oppo = arg_55_0._player._opponent
		if oppo then
			for _, c in ipairs(oppo:getBattleCards("G")) do
				table.insert(cands, c)
			end
		end
		return cands
	elseif arg_55_2._id == 20215 then
		-- LABRYNTH LABYRINTH (21173): Select 1 Labrynth monster from hand
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("H")) do
			if isMonsterCard(c) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and arg_55_0._player:getEmptyBoardPos(c) ~= nil and arg_55_0._player:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		return cands
	elseif arg_55_2._id == 20216 then
		-- LABRYNTH LABYRINTH (21173): Select 1 oppo board card to grave
		local cands = {}
		local oppo = arg_55_0._player._opponent
		if oppo then
			for _, c in ipairs(B.mergeTable({ oppo:getBoardCards(), oppo:getBattleCards("C"), oppo:getBattleCards("S") })) do
				table.insert(cands, c)
			end
		end
		return cands
	elseif arg_55_2._id == 20217 then
		-- LABRYNTH LABYRINTH (21173): Select 1 Labrynth S/T from grave/leave
		local cands = {}
		for _, c in ipairs(B.mergeTable({ arg_55_0._player:getBattleCards("G"), arg_55_0._player:getBattleCards("L") })) do
			if (c:isKeyword(308) or (c._info and c._info._keyword == 308)) and (c:isMagic() or c:isTrap() or c._type == Data.CardType.magic or c._type == Data.CardType.trap) and c:canChangeToHand() then
				table.insert(cands, c)
			end
		end
		return cands
	elseif arg_55_2._id == 20218 then
		-- LABRYNTH LABYRINTH (21173): Select 1 non-fusion monster from oppo grave/leave
		local cands = {}
		local oppo = arg_55_0._player._opponent
		if oppo then
			for _, c in ipairs(B.mergeTable({ oppo:getBattleCards("G"), oppo:getBattleCards("L") })) do
				if isMonsterCard(c) and not c:isMerge() and arg_55_0._player:getEmptyBoardPos(c) ~= nil and arg_55_0._player:canSpecialSummon(c) then
					table.insert(cands, c)
				end
			end
		end
		return cands
	elseif arg_55_2._id == 20155 then"""
replace_once(r"D:\yugitauapk\web\src\PlayerUi.lua", pui_cands_target, pui_cands_code, "PlayerUi cands batch 3")

# b) Dialog titles in PlayerUi.lua
pui_title_target = """	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20155,"""
pui_title_code = """	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20195, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài Phép/Bẫy \"Labrynth\" từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20198, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú \"Labrynth\" 5 hoặc 7 sao từ bộ bài lên sân"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20207, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài trên sân đối thủ để trả về tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20208, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài \"Labrynth\" từ mộ vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20211, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú \"Labrynth\" 4 sao trở xuống từ bộ bài vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20212, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 2 lá bài trong mộ đối thủ để trộn vào bộ bài"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20215, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú \"Labrynth\" từ trên tay lên sân"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20216, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài trên sân đối thủ để đưa vào mộ"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20217, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 lá bài Phép/Bẫy \"Labrynth\" từ mộ/loại bỏ vào tay"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20218, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú từ mộ/loại bỏ đối thủ triệu hồi về sân phe ta"
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20155,"""
replace_once(r"D:\yugitauapk\web\src\PlayerUi.lua", pui_title_target, pui_title_code, "PlayerUi dialog titles batch 3")

# c) Single choice IDs dispatch in PlayerUi.lua
pui_disp_single_target = """arg_89_2._card:isSkillAtIndex(20190, labIdx) then"""
pui_disp_single_code = """arg_89_2._card:isSkillAtIndex(20190, labIdx) or arg_89_2._card:isSkillAtIndex(20195, labIdx) or arg_89_2._card:isSkillAtIndex(20198, labIdx) or arg_89_2._card:isSkillAtIndex(20207, labIdx) or arg_89_2._card:isSkillAtIndex(20208, labIdx) or arg_89_2._card:isSkillAtIndex(20211, labIdx) or arg_89_2._card:isSkillAtIndex(20215, labIdx) or arg_89_2._card:isSkillAtIndex(20216, labIdx) or arg_89_2._card:isSkillAtIndex(20217, labIdx) or arg_89_2._card:isSkillAtIndex(20218, labIdx) then"""
replace_once(r"D:\yugitauapk\web\src\PlayerUi.lua", pui_disp_single_target, pui_disp_single_code, "PlayerUi dispatch single choice batch 3")

# d) Multi choice dispatch in PlayerUi.lua (20212)
pui_disp_multi_target = """arg_89_2._card:isSkillAtIndex(20193, labIdx) then"""
pui_disp_multi_code = """arg_89_2._card:isSkillAtIndex(20193, labIdx) or arg_89_2._card:isSkillAtIndex(20212, labIdx) then"""
replace_once(r"D:\yugitauapk\web\src\PlayerUi.lua", pui_disp_multi_target, pui_disp_multi_code, "PlayerUi dispatch multi choice batch 3")

# e) Choice count check in PlayerUi.lua
pui_cnt_target = """			if dbCard:isSkillAtIndex(20193, sBase) then"""
pui_cnt_code = """			if dbCard:isSkillAtIndex(20193, sBase) or dbCard:isSkillAtIndex(20212, sBase) then
				return var_91_0 == 2
			end
			if dbCard:isSkillAtIndex(20193, sBase) then"""
replace_once(r"D:\yugitauapk\web\src\PlayerUi.lua", pui_cnt_target, pui_cnt_code, "PlayerUi choice count check batch 3")

# ==============================================================================
# 6. Grant cards (30602..30605 and 21172..21173) to ALL accounts
# ==============================================================================
conn = pymysql.connect(host='127.0.0.1', user='root', password='', database='yugioh_game', charset='utf8mb4', autocommit=True)
with conn.cursor() as cur:
    new_card_ids = [30602, 30603, 30604, 30605, 21172, 21173]
    cur.execute("SELECT id FROM accounts")
    acc_ids = [r[0] for r in cur.fetchall()]
    total_accs = len(acc_ids)
    print(f"[*] Granting x3 new cards to {total_accs} accounts in database...")

    batch_size = 500
    for i in range(0, total_accs, batch_size):
        batch = acc_ids[i:i + batch_size]
        records = []
        for aid in batch:
            for cid in new_card_ids:
                records.append((aid, cid, 3))
        cur.executemany("""
            INSERT INTO user_cards (account_id, card_id, count)
            VALUES (%s, %s, %s)
            ON DUPLICATE KEY UPDATE count = GREATEST(count, 3)
        """, records)
    print(f"[OK] Granted x3 new cards {new_card_ids} to all {total_accs} accounts!")

conn.close()

# Also update starter_cards in yugioh_proto_server.py
proto_path = r"D:\yugitauapk\yugioh_proto_server.py"
with open(proto_path, 'r', encoding='utf-8') as f:
    proto_code = f.read()

old_proto_starter = "[30598, 30599, 30600, 30601] + list(range(12371, 12382))"
new_proto_starter = "[30598, 30599, 30600, 30601, 30602, 30603, 30604, 30605, 21172, 21173] + list(range(12371, 12382))"

if old_proto_starter in proto_code:
    proto_code = proto_code.replace(old_proto_starter, new_proto_starter, 1)
    with open(proto_path, 'w', encoding='utf-8') as f:
        f.write(proto_code)
    print("[OK] Updated starter cards in yugioh_proto_server.py")

print("\n[*] All Labrynth Batch 3 logic and card data successfully applied!")
