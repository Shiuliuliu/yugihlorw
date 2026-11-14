import sys, os

sys.stdout.reconfigure(encoding='utf-8')

print("[*] Applying Labrynth Batch 3 gameplay logic...")

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

# 1. BattleCard.lua
# a) Check _labrynthAllAttackLockedTurn in checkCanAttack / canAttack
bc_atk_target = """	if arg_215_0._owner and arg_215_0._owner._princessAttackLockedTurn == arg_215_0._owner._round then
		return false
	end"""
bc_atk_code = """	if arg_215_0._owner and arg_215_0._owner._princessAttackLockedTurn == arg_215_0._owner._round then
		return false
	end
	if arg_215_0._owner and arg_215_0._owner._labrynthAllAttackLockedTurn == arg_215_0._owner._round then
		return false
	end"""
replace_once(r"D:\yugitauapk\web\src\BattleCard.lua", bc_atk_target, bc_atk_code, "BattleCard _labrynthAllAttackLockedTurn")

# b) Labrynth Labyrinth (21173 / skill 20214): Shields (Quái / Phép / Bẫy) on Labrynth monsters
bc_shield_target = """	-- Labrynth Archfiend (12378 / 20159): Khi lên sân, nhận được "Khiên Chắn Phá Hủy" (12006)
	if arg_127_1 == 12006 and (arg_127_0:isInfoId(12378) or arg_127_0._infoId == 12378 or arg_127_0:hasSkillFast(20159)) and arg_127_0._status == BattleData.CardStatus.board then
		return true
	end"""
bc_shield_code = """	-- Labrynth Archfiend (12378 / 20159): Khi lên sân, nhận được "Khiên Chắn Phá Hủy" (12006)
	if arg_127_1 == 12006 and (arg_127_0:isInfoId(12378) or arg_127_0._infoId == 12378 or arg_127_0:hasSkillFast(20159)) and arg_127_0._status == BattleData.CardStatus.board then
		return true
	end

	-- Labrynth Labyrinth (21173 / 20214): Quái Labrynth nhận Khiên Chắn Quái (12003), Phép (12004), Bẫy (12005)
	if (arg_127_1 == 12003 or arg_127_1 == 12004 or arg_127_1 == 12005) and (arg_127_0:isKeyword(308) or (arg_127_0._info and arg_127_0._info._keyword == 308)) and arg_127_0._status == BattleData.CardStatus.board then
		local owner = arg_127_0._owner
		if owner and owner._boardCards then
			for _, bc in ipairs(owner._boardCards) do
				if bc and (bc:isInfoId(21173) or bc._infoId == 21173 or bc:hasSkillFast(20214)) then
					return true
				end
			end
		end
	end"""
replace_once(r"D:\yugitauapk\web\src\BattleCard.lua", bc_shield_target, bc_shield_code, "BattleCard Labyrinth shields")

# c) Labrynth Labyrinth (21173 / 20214): +300 ATK for Labrynth monsters
bc_atk_bonus_target = """	if arg_126_0._labKnightAtkBonus and arg_126_0._labKnightAtkBonus > 0 and arg_126_0:getStar() == 8 and (arg_126_0:isKeyword(308) or (arg_126_0._info and arg_126_0._info._keyword == 308)) then
		var_126_0 = var_126_0 + arg_126_0._labKnightAtkBonus
	end"""
bc_atk_bonus_code = """	if arg_126_0._labKnightAtkBonus and arg_126_0._labKnightAtkBonus > 0 and arg_126_0:getStar() == 8 and (arg_126_0:isKeyword(308) or (arg_126_0._info and arg_126_0._info._keyword == 308)) then
		var_126_0 = var_126_0 + arg_126_0._labKnightAtkBonus
	end

	-- Labrynth Labyrinth (21173 / 20214): +300 ATK
	if (arg_126_0:isKeyword(308) or (arg_126_0._info and arg_126_0._info._keyword == 308)) and arg_126_0._status == BattleData.CardStatus.board then
		local owner = arg_126_0._owner
		if owner and owner._boardCards then
			for _, bc in ipairs(owner._boardCards) do
				if bc and (bc:isInfoId(21173) or bc._infoId == 21173 or bc:hasSkillFast(20214)) then
					var_126_0 = var_126_0 + 300
					break
				end
			end
		end
	end"""
replace_once(r"D:\yugitauapk\web\src\BattleCard.lua", bc_atk_bonus_target, bc_atk_bonus_code, "BattleCard Labyrinth ATK bonus")

# 2. BattleSkill.lua:
# a) canUseTrap for 20197, 20200, 20202, 20206
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

# b) canUseMagic for 20210, 20213
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

# c) canTriggerTrapWhenAttack for 20194, 20196, 20201, 20205, 20209
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

# d) canTriggerTrapWhenStatusChange for 20200, 20203, 20204, 20215
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

print("[*] Skill gates updated successfully!")
