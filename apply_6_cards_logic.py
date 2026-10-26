import sys, re

sys.stdout.reconfigure(encoding='utf-8')

# 8. Update BattleCard.lua
bcard_path = r'D:\yugitauapk\web\src\BattleCard.lua'
with open(bcard_path, 'r', encoding='utf-8') as f:
    bcard_content = f.read()

# 8a. Death triggers: 14806, 14808, 14810
target_death_trigger = "if (arg_264_0._infoId == 12327 or arg_264_0:hasSkillFast(14718)) and arg_264_0._dieFromStatus == BattleData.CardStatus.board and arg_264_0._dieByAttack then"
new_death_triggers = r"""-- Zombified piglin cam kiem (12342 / 14806): Khi bi pha huy trong chien dau -> trieu hoi toi da 3 <Zombified piglin cam riu> (12343) tu bo bai / bai tren tay
	if (arg_264_0._infoId == 12342 or arg_264_0:hasSkillFast(14806)) and arg_264_0._dieFromStatus == BattleData.CardStatus.board and arg_264_0._dieByAttack then
		local owner = arg_264_0._owner
		if owner and not owner._isSummonDisabled and not owner._isSpecialSummonDisabled then
			local count = 0
			local candidates = {}
			for _, c in ipairs(owner._pileCards) do
				if c._infoId == 12343 or c:isInfoId(12343) then
					table.insert(candidates, { card = c, sVal = BattleData.CardStatusVal.p2b_special })
				end
			end
			for _, c in ipairs(owner._handCards) do
				if c._infoId == 12343 or c:isInfoId(12343) then
					table.insert(candidates, { card = c, sVal = BattleData.CardStatusVal.h2b_special })
				end
			end
			for _, item in ipairs(candidates) do
				if count >= 3 then break end
				local emptyPos = owner:getEmptyBoardPos(item.card)
				if emptyPos ~= nil then
					item.card._saved._pos = emptyPos
					owner:setCardStatus(item.card, BattleData.CardStatus.board, 12342, 14806, Data.SkillMode.magic, item.sVal)
					count = count + 1
				end
			end
		end
	end

	-- Zombified piglin cam riu (12343 / 14808): Khi bi pha huy trong chien dau -> trieu hoi toi da 3 <Zombified piglin cam kiem> (12342) tu bo bai / bai tren tay
	if (arg_264_0._infoId == 12343 or arg_264_0:hasSkillFast(14808)) and arg_264_0._dieFromStatus == BattleData.CardStatus.board and arg_264_0._dieByAttack then
		local owner = arg_264_0._owner
		if owner and not owner._isSummonDisabled and not owner._isSpecialSummonDisabled then
			local count = 0
			local candidates = {}
			for _, c in ipairs(owner._pileCards) do
				if c._infoId == 12342 or c:isInfoId(12342) then
					table.insert(candidates, { card = c, sVal = BattleData.CardStatusVal.p2b_special })
				end
			end
			for _, c in ipairs(owner._handCards) do
				if c._infoId == 12342 or c:isInfoId(12342) then
					table.insert(candidates, { card = c, sVal = BattleData.CardStatusVal.h2b_special })
				end
			end
			for _, item in ipairs(candidates) do
				if count >= 3 then break end
				local emptyPos = owner:getEmptyBoardPos(item.card)
				if emptyPos ~= nil then
					item.card._saved._pos = emptyPos
					owner:setCardStatus(item.card, BattleData.CardStatus.board, 12343, 14808, Data.SkillMode.magic, item.sVal)
					count = count + 1
				end
			end
		end
	end

	-- Husk (12344 / 14810): Khi bi pha huy (chien dau hoac hieu ung), doi phuong bo ngau nhien 1 bai tren tay vao mo
	if (arg_264_0._infoId == 12344 or arg_264_0:hasSkillFast(14810)) and arg_264_0._dieFromStatus == BattleData.CardStatus.board and (arg_264_0._dieByAttack or arg_264_0._dieByEffect) then
		local oppo = arg_264_0._owner and arg_264_0._owner._opponent
		if oppo then
			local oppoHand = oppo:getBattleCards("H")
			if #oppoHand > 0 then
				local targetCard = oppo:randomOne(oppoHand)
				if targetCard then
					oppo:setCardStatus(targetCard, BattleData.CardStatus.grave, 12344, 14810, Data.SkillMode.magic, BattleData.CardStatusVal.h2g_drop)
				end
			end
		end
	end

	""" + target_death_trigger

if "arg_264_0._infoId == 12342" not in bcard_content:
    assert target_death_trigger in bcard_content, "target_death_trigger not found in BattleCard.lua"
    bcard_content = bcard_content.replace(target_death_trigger, new_death_triggers, 1)

# 8b. hasSkillFast for 2002 (Cua dia nguc aura Tin Nguong)
target_fast_skill = "function var_0_0.hasSkillFast(arg_127_0, arg_127_1)"
new_fast_skill = r"""function var_0_0.hasSkillFast(arg_127_0, arg_127_1)
	if arg_127_1 == 2002 then
		if arg_127_0._status == BattleData.CardStatus.board and (arg_127_0:isMonster() or arg_127_0:isMonsterRare() or arg_127_0._type == Data.CardType.monster) then
			local isUndead = arg_127_0:isCategory(17) or (arg_127_0._info and arg_127_0._info._category == 17)
			if isUndead then
				local owner = arg_127_0._owner
				if owner and (#owner:getBattleCardsByInfoId("S", 30597) > 0 or #owner:getBattleCardsByInfoId("B", 30597) > 0) then
					return true
				end
			end
		end
	end"""

if "arg_127_1 == 2002" not in bcard_content:
    assert target_fast_skill in bcard_content, "target_fast_skill not found in BattleCard.lua"
    bcard_content = bcard_content.replace(target_fast_skill, new_fast_skill, 1)

# 8c. hasSkills check for 2002
target_has_skills = "\tfor iter_126_0 = 1, #arg_126_0._skills do"
new_has_skills = r"""	if B.tableContain(arg_126_1, 2002) and arg_126_0:hasSkillFast(2002) then
		var_126_0[#var_126_0 + 1] = { _id = 2002, _level = 1, _modes = { Data.SkillMode.under_attack_damage }, _owner = arg_126_0 }
		return true, var_126_0
	end

	for iter_126_0 = 1, #arg_126_0._skills do"""

if "B.tableContain(arg_126_1, 2002)" not in bcard_content:
    assert target_has_skills in bcard_content, "target_has_skills not found in BattleCard.lua"
    bcard_content = bcard_content.replace(target_has_skills, new_has_skills, 1)

# 8d. getSkillsByMode check for 2002
target_skills_by_mode = "\tlocal var_118_443 = {}"
new_skills_by_mode = r"""	if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0:hasSkillFast(2002) then
		table.insert(var_118_0, { _id = 2002, _level = 1, _modes = { Data.SkillMode.under_attack_damage }, _owner = arg_118_0 })
	end

	local var_118_443 = {}"""

if "arg_118_0:hasSkillFast(2002)" not in bcard_content:
    assert target_skills_by_mode in bcard_content, "target_skills_by_mode not found in BattleCard.lua"
    bcard_content = bcard_content.replace(target_skills_by_mode, new_skills_by_mode, 1)

with open(bcard_path, 'w', encoding='utf-8') as f:
    f.write(bcard_content)
print("[OK] Updated BattleCard.lua")

# 9. Update BattleCardStatus.lua
bcs_path = r'D:\yugitauapk\web\src\BattleCardStatus.lua'
with open(bcs_path, 'r', encoding='utf-8') as f:
    bcs_content = f.read()

target_bcs_add = "\t\tif arg_15_1._statusVal == BattleData.CardStatusVal.g2b_3347 then"
new_bcs_add = r"""		local turnId = (arg_15_0._round or 0) * 1000 + (arg_15_0._opponent and arg_15_0._opponent._round or 0)
		if arg_15_0._turnSummonRoundId ~= turnId then
			arg_15_0._turnSummonRoundId = turnId
			arg_15_0._turnSummonCount = 0
		end
		arg_15_0._turnSummonCount = (arg_15_0._turnSummonCount or 0) + 1

		-- Warden (12345 / 14814): 1 luot 1 lan, khi doi phuong trieu hoi quai lan 3, Warden tren tay kich hoat
		if arg_15_0._turnSummonCount == 3 then
			local oppo = arg_15_0._opponent
			if oppo and oppo._wardenHandTriggerTurn ~= turnId and not oppo._isSummonDisabled and not oppo._isSpecialSummonDisabled then
				local wardenCard = nil
				for _, c in ipairs(oppo._handCards) do
					if (c:isInfoId(12345) or c._infoId == 12345) and oppo:canSpecialSummon(c) then
						wardenCard = c
						break
					end
				end
				if wardenCard then
					local emptyPos = oppo:getEmptyBoardPos(wardenCard)
					if emptyPos ~= nil then
						oppo._wardenHandTriggerTurn = turnId
						wardenCard._saved._pos = emptyPos
						oppo:setCardStatus(wardenCard, BattleData.CardStatus.board, wardenCard._id, 14814, Data.SkillMode.using, BattleData.CardStatusVal.h2b_special)
						if arg_15_1._status == BattleData.CardStatus.board then
							arg_15_0:setCardStatus(arg_15_1, BattleData.CardStatus.hand, wardenCard._id, 14814, Data.SkillMode.using, arg_15_1._owner ~= arg_15_1._originOwner and BattleData.CardStatusVal.b2h_oppo or nil)
						end
					end
				end
			end
		end

		if arg_15_1._statusVal == BattleData.CardStatusVal.g2b_3347 then"""

if "arg_15_0._turnSummonCount == 3" not in bcs_content:
    assert target_bcs_add in bcs_content, "target_bcs_add not found in BattleCardStatus.lua"
    bcs_content = bcs_content.replace(target_bcs_add, new_bcs_add, 1)
    with open(bcs_path, 'w', encoding='utf-8') as f:
        f.write(bcs_content)
    print("[OK] Updated BattleCardStatus.lua")
else:
    print("[SKIP] BattleCardStatus.lua already has Warden 3rd summon logic")

# 10. Update PlayerBattle.lua
pb_path = r'D:\yugitauapk\web\src\PlayerBattle.lua'
with open(pb_path, 'r', encoding='utf-8') as f:
    pb_content = f.read()

target_pb_account = r"""		local cardOwner = arg_38_1._owner or arg_38_0
		if B.isWitherOnField(cardOwner) and arg_38_1._status == BattleData.CardStatus.board and (arg_38_1:isMonster() or arg_38_1:isMonsterRare() or arg_38_1._type == Data.CardType.monster) then
			local isUndead = arg_38_1:isCategory(17) or (arg_38_1._info and arg_38_1._info._category == 17)
			if not isUndead then
				arg_38_1._atk = math.floor(arg_38_1._atk / 2)
			end
		end"""

repl_pb_account = r"""		local cardOwner = arg_38_1._owner or arg_38_0
		if B.isWitherOnField(cardOwner) and arg_38_1._status == BattleData.CardStatus.board and (arg_38_1:isMonster() or arg_38_1:isMonsterRare() or arg_38_1._type == Data.CardType.monster) then
			local isUndead = arg_38_1:isCategory(17) or (arg_38_1._info and arg_38_1._info._category == 17)
			if not isUndead then
				arg_38_1._atk = math.floor(arg_38_1._atk / 2)
			end
		end

		-- Cua dia nguc (30597 / 14813): Khi tren san, quai xac song phe ta nhan 500 atk
		if cardOwner and arg_38_1._status == BattleData.CardStatus.board and (arg_38_1:isMonster() or arg_38_1:isMonsterRare() or arg_38_1._type == Data.CardType.monster) then
			local isUndead = arg_38_1:isCategory(17) or (arg_38_1._info and arg_38_1._info._category == 17)
			if isUndead then
				local sCards = cardOwner:getBattleCardsByInfoId("S", 30597)
				local bCards = cardOwner:getBattleCardsByInfoId("B", 30597)
				if #sCards > 0 or #bCards > 0 then
					arg_38_1._atk = arg_38_1._atk + 500
				end
			end
		end"""

if "30597" not in pb_content:
    assert target_pb_account in pb_content, "target_pb_account not found in PlayerBattle.lua"
    pb_content = pb_content.replace(target_pb_account, repl_pb_account, 1)
    with open(pb_path, 'w', encoding='utf-8') as f:
        f.write(pb_content)
    print("[OK] Updated PlayerBattle.lua")
else:
    print("[SKIP] PlayerBattle.lua already has 30597 account logic")

print("\nAll logic files updated successfully!")
