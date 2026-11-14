# -*- coding: utf-8 -*-
import re
import os

BS_PATH = r"D:\yugitauapk\web\src\BattleSkill.lua"
PUI_PATH = r"D:\yugitauapk\web\src\PlayerUi.lua"

print("[*] Starting patch_tel_logic.py...")

# 1. Patch BattleSkill.lua
with open(BS_PATH, 'r', encoding='utf-8') as f:
    bs_content = f.read()

# 1.a) canUseInitiativeSkill
target_can_use = "if arg_36_2._id == 20219 or arg_36_2._id == 20222 or arg_36_2._id == 20223 or arg_36_2._id == 20224 or arg_36_2._id == 20225 or arg_36_2._id == 20230 or arg_36_2._id == 20231 then"
repl_can_use = "if arg_36_2._id == 20219 or arg_36_2._id == 20222 or arg_36_2._id == 20223 or arg_36_2._id == 20224 or arg_36_2._id == 20225 or arg_36_2._id == 20230 or arg_36_2._id == 20231 or arg_36_2._id == 20232 or arg_36_2._id == 20233 then"

if target_can_use in bs_content:
    bs_content = bs_content.replace(target_can_use, repl_can_use, 1)
    print("[OK] BattleSkill.lua: canUseInitiativeSkill updated.")
elif "20232" in bs_content and "20233" in bs_content and "canUseInitiativeSkill1" in bs_content:
    print("[SKIP] BattleSkill.lua: canUseInitiativeSkill already has 20232/20233.")
else:
    print("[ERR] Could not find target_can_use in BattleSkill.lua!")

# 1.b) canUseInitiativeSkill1
target_can_use_1 = """	elseif var_37_0 == 20231 then
		if arg_37_0._castedSkillCounts[var_37_0] ~= nil and arg_37_0._castedSkillCounts[var_37_0] > 0 then
			return false
		end

		if arg_37_1._status ~= BattleData.CardStatus.board then
			return false
		end

		return true"""

repl_can_use_1 = """	elseif var_37_0 == 20231 then
		if arg_37_0._castedSkillCounts[var_37_0] ~= nil and arg_37_0._castedSkillCounts[var_37_0] > 0 then
			return false
		end

		if arg_37_1._status ~= BattleData.CardStatus.board then
			return false
		end

		return true
	elseif var_37_0 == 20232 then
		-- TEL'ANNAS (12385): 1 luot toi da 3 lan, trieu hoi dac biet 1 quai liqi <= 6 sao tu tay len san
		if (arg_37_0._castedSkillCounts[var_37_0] or 0) >= 3 then
			return false
		end

		if arg_37_1._status ~= BattleData.CardStatus.board then
			return false
		end

		if arg_37_0._isSummonDisabled or arg_37_0._isSpecialSummonDisabled then
			return false
		end

		if #arg_37_0:getBoardCards() >= Data.MAX_CARD_COUNT_ON_BOARD then
			return false
		end

		local hasTarget = false
		for _, c in ipairs(arg_37_0:getBattleCards("H")) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare)
				and (c:isKeyword(303) or (c._info and c._info._keyword == 303))
				and c:getStar() <= 6
				and arg_37_0:canSpecialSummon(c) then
				hasTarget = true
				break
			end
		end

		return hasTarget
	elseif var_37_0 == 20233 then
		-- TEL'ANNAS (12385): 1 luot 1 lan, bo 1 bai tren tay vao mo -> lay 1 quai liqi <= 6 sao tu deck len tay
		if (arg_37_0._castedSkillCounts[var_37_0] or 0) >= 1 then
			return false
		end

		if arg_37_1._status ~= BattleData.CardStatus.board then
			return false
		end

		if #arg_37_0:getBattleCards("H") < 1 then
			return false
		end

		local hasHandToDiscard = false
		for _, c in ipairs(arg_37_0:getBattleCards("H")) do
			if c:canChangeToLeave() then
				hasHandToDiscard = true
				break
			end
		end
		if not hasHandToDiscard then
			return false
		end

		local hasDeckLiqi = false
		for _, c in ipairs(arg_37_0:filterCanChangeToHandCards(arg_37_0:getBattleCards("P"))) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare)
				and (c:isKeyword(303) or (c._info and c._info._keyword == 303))
				and c:getStar() <= 6 then
				hasDeckLiqi = true
				break
			end
		end

		return hasDeckLiqi"""

if target_can_use_1 in bs_content:
    bs_content = bs_content.replace(target_can_use_1, repl_can_use_1, 1)
    print("[OK] BattleSkill.lua: canUseInitiativeSkill1 updated with 20232, 20233.")
elif "var_37_0 == 20232" in bs_content:
    print("[SKIP] BattleSkill.lua: canUseInitiativeSkill1 already has 20232.")
else:
    print("[ERR] Could not find target_can_use_1 in BattleSkill.lua!")

# 1.c) castMonsterSpellSkill handlers
target_cast = """	elseif var_4_4 == 20231 then
		-- AIRI - THU NGUYEN VE THAN (12384): 1 luot 1 lan, nhan 1080 Lien Tram
		local airiCard = var_4_1 or arg_4_1
		local pOwner = (airiCard and airiCard._owner) or arg_4_0
		pOwner._castedSkillCounts[var_4_4] = (pOwner._castedSkillCounts[var_4_4] or 0) + 1
		if airiCard and airiCard._status == BattleData.CardStatus.board then
			airiCard:addSkill(1080, 1, BattleData.SkillProvider.given)
			arg_4_0:incPositiveStatus(airiCard, { BattleData.PositiveType.extraSkill }, true, var_4_5, var_4_4, arg_4_3)
			arg_4_0:incPositiveValue(airiCard, BattleData.PositiveType.extraSkill, 65536 + 1080, Data.AggregateType.table, var_4_5, var_4_4, arg_4_3)
			var_4_13 = true
		end"""

repl_cast = target_cast + """
	elseif var_4_4 == 20232 then
		-- TEL'ANNAS - THU NGUYEN VE THAN (12385): 1 luot toi da 3 lan, trieu hoi dac biet 1 quai liqi <= 6 sao tu tay
		local telCard = var_4_1 or arg_4_1
		local pOwner = (telCard and telCard._owner) or arg_4_0
		pOwner._castedSkillCounts[var_4_4] = (pOwner._castedSkillCounts[var_4_4] or 0) + 1

		local chosenId = (var_4_15 > 0 and var_4_15) or (var_4_14 > 0 and var_4_14) or (arg_4_2 and arg_4_2._id)
		local targetCard = nil
		if chosenId and chosenId > 0 then
			local cid = chosenId % BattleData.UseCardId.id_group
			targetCard = pOwner:getCardById(cid) or pOwner:getCardById(chosenId)
		end
		if targetCard == nil or targetCard._status ~= BattleData.CardStatus.hand then
			for _, c in ipairs(pOwner:getBattleCards("H")) do
				if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare)
					and (c:isKeyword(303) or (c._info and c._info._keyword == 303))
					and c:getStar() <= 6
					and pOwner:canSpecialSummon(c) then
					targetCard = c
					break
				end
			end
		end

		if targetCard and targetCard._status == BattleData.CardStatus.hand then
			local emptyPos = pOwner:getEmptyBoardPos(targetCard)
			if emptyPos then
				targetCard._saved._pos = emptyPos
				pOwner:setCardStatus(targetCard, BattleData.CardStatus.board, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.h2b_special)
				var_4_13 = true
			end
		end
	elseif var_4_4 == 20233 then
		-- TEL'ANNAS - THU NGUYEN VE THAN (12385): 1 luot 1 lan, bo 1 bai tren tay vao mo -> lay 1 quai liqi <= 6 sao tu deck len tay
		local telCard = var_4_1 or arg_4_1
		local pOwner = (telCard and telCard._owner) or arg_4_0
		pOwner._castedSkillCounts[var_4_4] = (pOwner._castedSkillCounts[var_4_4] or 0) + 1

		local handDiscardId = var_4_15 % BattleData.UseCardId.id_group
		local deckSearchId = math.floor(var_4_15 / BattleData.UseCardId.id_group) % BattleData.UseCardId.id_group

		local discardCard = pOwner:getCardById(handDiscardId)
		if discardCard == nil or discardCard._status ~= BattleData.CardStatus.hand then
			for _, c in ipairs(pOwner:getBattleCards("H")) do
				if c:canChangeToLeave() then
					discardCard = c
					break
				end
			end
		end

		if discardCard and discardCard._status == BattleData.CardStatus.hand then
			pOwner:setCardStatus(discardCard, BattleData.CardStatus.grave, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.h2g_sacrifice)
		end

		local searchCard = pOwner:getCardById(deckSearchId)
		if searchCard == nil or searchCard._status ~= BattleData.CardStatus.pile then
			for _, c in ipairs(pOwner:filterCanChangeToHandCards(pOwner:getBattleCards("P"))) do
				if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare)
					and (c:isKeyword(303) or (c._info and c._info._keyword == 303))
					and c:getStar() <= 6 then
					searchCard = c
					break
				end
			end
		end

		if searchCard and searchCard._status == BattleData.CardStatus.pile then
			pOwner:setCardStatus(searchCard, BattleData.CardStatus.hand, var_4_5, var_4_4, arg_4_3, BattleData.CardStatusVal.p2h_draw)
			var_4_13 = true
		end
	elseif var_4_4 == 20234 then
		-- TEL'ANNAS - THU NGUYEN VE THAN (12385): Khi len san, tang LP phe ta bang so bai "liqi" trong mo x100, doi phuong nhan so LP tuong ung x2
		local telCard = var_4_1 or arg_4_1
		local pOwner = (telCard and telCard._owner) or arg_4_0
		local liqiGraveCount = 0
		for _, c in ipairs(pOwner:getBattleCards("G")) do
			if c:isKeyword(303) or (c._info and c._info._keyword == 303) then
				liqiGraveCount = liqiGraveCount + 1
			end
		end

		local selfLp = liqiGraveCount * 100
		local oppoLp = selfLp * 2

		if selfLp > 0 and pOwner._fortress then
			arg_4_0:incHp(pOwner._fortress, selfLp, false, var_4_5, var_4_4, arg_4_3)
		end

		if oppoLp > 0 and pOwner._opponent and pOwner._opponent._fortress then
			arg_4_0:incHp(pOwner._opponent._fortress, oppoLp, false, var_4_5, var_4_4, arg_4_3)
		end
		var_4_13 = true"""

if target_cast in bs_content:
    bs_content = bs_content.replace(target_cast, repl_cast, 1)
    print("[OK] BattleSkill.lua: castMonsterSpellSkill updated with 20232, 20233, 20234.")
elif "var_4_4 == 20232" in bs_content:
    print("[SKIP] BattleSkill.lua: castMonsterSpellSkill already has 20232.")
else:
    print("[ERR] Could not find target_cast in BattleSkill.lua!")

with open(BS_PATH, 'w', encoding='utf-8') as f:
    f.write(bs_content)
print("[OK] BattleSkill.lua saved.")

# 2. Patch PlayerUi.lua
with open(PUI_PATH, 'r', encoding='utf-8') as f:
    pui_content = f.read()

# 2.a) showInitiativeSkillDialog
target_ui_dialog = """	elseif arg_55_2._id == 20230 then
		-- AIRI - THU NGUYEN VE THAN (12384): Sac 2 "liqi" monsters on board -> special summon self
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBoardCards()) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(303) or (c._info and c._info._keyword == 303)) then
				table.insert(cands, c)
			end
		end
		if #cands >= 2 and arg_55_0._player:canSpecialSummon(arg_55_1) then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 2, var_55_4 * BattleData.ChoiceId.stage_3)
		end"""

repl_ui_dialog = target_ui_dialog + """
	elseif arg_55_2._id == 20232 then
		-- TEL'ANNAS (12385): Kĩ năng 1: Chọn 1 quái "liqi" <= 6 sao trên tay triệu hồi đặc biệt
		local cands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("H")) do
			if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(303) or (c._info and c._info._keyword == 303)) and c:getStar() <= 6 and arg_55_0._player:canSpecialSummon(c) then
				table.insert(cands, c)
			end
		end
		if #cands > 0 and arg_55_0._player:getEmptyBoardPos() ~= nil then
			return arg_55_0:showChoiceGrave(var_55_0, nil, cands, 1, var_55_4 * BattleData.ChoiceId.stage_3, "tel_hand_summon")
		end
	elseif arg_55_2._id == 20233 then
		-- TEL'ANNAS (12385): Kĩ năng 2: Two-stage (Bỏ 1 bài trên tay vào mộ -> lấy 1 quái "liqi" <= 6 sao từ deck lên tay)
		local handCands = {}
		for _, c in ipairs(arg_55_0._player:getBattleCards("H")) do
			if c:canChangeToLeave() then
				table.insert(handCands, c)
			end
		end
		if #handCands > 0 then
			return arg_55_0:showChoiceGrave(var_55_0, nil, handCands, 1, var_55_4 * BattleData.ChoiceId.stage_3, "tel_discard_hand")
		end"""

if target_ui_dialog in pui_content:
    pui_content = pui_content.replace(target_ui_dialog, repl_ui_dialog, 1)
    print("[OK] PlayerUi.lua: showInitiativeSkillDialog updated with 20232, 20233.")
elif "arg_55_2._id == 20232" in pui_content:
    print("[SKIP] PlayerUi.lua: showInitiativeSkillDialog already has 20232.")
else:
    print("[ERR] Could not find target_ui_dialog in PlayerUi.lua!")

# 2.b) showChoiceGrave title
target_ui_title = """	elseif (arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20230, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) or arg_85_1._card:hasSkillFast(20230) or arg_85_1._card:isInfoId(12384) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 2 quái thú 'liqi' trên sân để hi sinh\""""

repl_ui_title = target_ui_title + """
	elseif (arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20232, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) or arg_85_1._card:hasSkillFast(20232) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = "Chọn 1 quái thú 'liqi' 6 sao trở xuống từ trên tay để Triệu hồi Đặc biệt"
	elseif (arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(20233, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) or arg_85_1._card:hasSkillFast(20233) then
		var_85_0 = BattleListDialog.Mode.choice
		if arg_85_6 == "tel_discard_hand" then
			var_85_1 = "Chọn 1 lá bài trên tay đưa vào Mộ"
		else
			var_85_1 = "Chọn 1 quái thú 'liqi' 6 sao trở xuống từ Bộ bài lên tay"
		end"""

if target_ui_title in pui_content:
    pui_content = pui_content.replace(target_ui_title, repl_ui_title, 1)
    print("[OK] PlayerUi.lua: showChoiceGrave title updated with 20232, 20233.")
elif "isSkillAtIndex(20232" in pui_content:
    print("[SKIP] PlayerUi.lua: showChoiceGrave title already has 20232.")
else:
    print("[ERR] Could not find target_ui_title in PlayerUi.lua!")

# 2.c) onChoiceGrave
target_ui_choice = """	-- Labrynth two-stage choices (20137, 20140, 20148)
	if arg_89_1._choiceBase then"""

repl_ui_choice = """	-- Tel'Annas skills (20232, 20233)
	if arg_89_1._choiceBase then
		local telIdx = math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)
		if arg_89_2._card:isSkillAtIndex(20232, telIdx) or arg_89_2._card:hasSkillFast(20232) then
			local targetCard = (var_89_0 and #var_89_0 > 0) and var_89_0[1] or nil
			local chVal = targetCard and targetCard._id or 0
			return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
				_card = arg_89_2._card,
				_target = targetCard,
				_choice = chVal * BattleData.ChoiceId.stage_2 + (arg_89_1._choiceBase or 0)
			})
		elseif arg_89_2._card:isSkillAtIndex(20233, telIdx) or arg_89_2._card:hasSkillFast(20233) then
			if arg_89_1._choiceParam == "tel_discard_hand" then
				arg_89_2._card._telStage1Id = (var_89_0 and #var_89_0 > 0) and var_89_0[1]._id or 0
				local stage2Cands = {}
				for _, c in ipairs(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCards("P"))) do
					if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(303) or (c._info and c._info._keyword == 303)) and c:getStar() <= 6 then
						table.insert(stage2Cands, c)
					end
				end
				if #stage2Cands > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, stage2Cands, 1, arg_89_1._choiceBase, "tel_stage2")
				end
				local s1 = arg_89_2._card._telStage1Id or 0
				arg_89_2._card._telStage1Id = nil
				return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
					_card = arg_89_2._card,
					_target = arg_89_3 ~= nil and arg_89_3._card or nil,
					_choice = s1 * BattleData.ChoiceId.stage_2 + (arg_89_1._choiceBase or 0)
				})
			else
				local s1 = arg_89_2._card._telStage1Id or 0
				local s2 = (var_89_0 and #var_89_0 > 0) and var_89_0[1]._id or 0
				arg_89_2._card._telStage1Id = nil
				local var_choice = s2 * BattleData.UseCardId.id_group + s1
				return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
					_card = arg_89_2._card,
					_target = arg_89_3 ~= nil and arg_89_3._card or nil,
					_choice = var_choice * BattleData.ChoiceId.stage_2 + (arg_89_1._choiceBase or 0)
				})
			end
		end
	end

	-- Labrynth two-stage choices (20137, 20140, 20148)
	if arg_89_1._choiceBase then"""

if target_ui_choice in pui_content:
    pui_content = pui_content.replace(target_ui_choice, repl_ui_choice, 1)
    print("[OK] PlayerUi.lua: onChoiceGrave updated with 20232, 20233.")
elif "arg_89_2._card:isSkillAtIndex(20232" in pui_content:
    print("[SKIP] PlayerUi.lua: onChoiceGrave already has 20232.")
else:
    print("[ERR] Could not find target_ui_choice in PlayerUi.lua!")

with open(PUI_PATH, 'w', encoding='utf-8') as f:
    f.write(pui_content)
print("[OK] PlayerUi.lua saved.")
print("[*] Finished patch_tel_logic.py!")
