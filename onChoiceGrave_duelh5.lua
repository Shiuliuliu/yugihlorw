function var_0_0.onChoiceGrave(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	local var_89_0 = arg_89_1:getSelectedCards()

	arg_89_0._battleUi._choiceGraveDialog = nil

	if arg_89_2._card._status ~= BattleData.CardStatus.leave then
		arg_89_2:setVisible(true)
	end

	local var_89_1 = 0

	if arg_89_2._card:hasSkills({
		4048,
		4171,
		4186,
		4207,
		4290,
		4454,
		4497,
		4521,
		4735,
		4736,
		4740,
		4748,
		4836,
		7144,
		7373,
		7693
	}) or arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:hasSkills({
		3874,
		3885,
		2375
	}) or arg_89_2._card._status == BattleData.CardStatus.board and arg_89_2._card:hasSkills({
		2243,
		2318
	}) or arg_89_2._card._status == BattleData.CardStatus.grave and arg_89_2._card:hasSkills({
		2985
	}) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
		2982,
		4305,
		4511,
		4514,
		4526,
		4530,
		4861,
		4957,
		4979,
		5244,
		5280,
		5298,
		7544,
		7579,
		7622,
		7631,
		7731,
		7753
	}) and not arg_89_2._card:isSkillAtIndex(7733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(3705, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(3850, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(2324, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(4978, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(4980, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5430, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5431, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5452, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5470, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5485, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5544, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(5549, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7673, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7674, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7732, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7785, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7831, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(9796, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(9868, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13119, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13259, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13264, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13292, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13348, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13718, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13736, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13850, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13920, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13989, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14390, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14487, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14519, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14541, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14555, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_2 = arg_89_1._choiceParam

		if var_89_2 then
			local var_89_3 = arg_89_0._player:getMergeCandidatesByTriggerCard(var_89_2, arg_89_2._card, (arg_89_2._card._infoId == 30429 or arg_89_2._card._infoId == 21067) and math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or (arg_89_2._card._infoId == 20991 or arg_89_2._card._infoId == 30113 or arg_89_2._card._infoId == 30442 or arg_89_2._card._infoId == 30467 or arg_89_2._card._infoId == 30469 or arg_89_2._card._infoId == 30510 or arg_89_2._card:isSkillAtIndex(13264, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7732, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7785, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7831, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14487, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(14541, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3))) and 2 or nil)

			var_89_1 = B.getChoiceByCandidatePos(var_89_3, var_89_0)

			if arg_89_1._choiceBase % 10 == 0 then
				var_89_1 = var_89_1 * 100
			end

			if not arg_89_2._card:hasSkills({
				3705,
				3850,
				2243,
				2318,
				2324,
				2375,
				2982,
				2985,
				3874,
				3885,
				7144,
				7373,
				7693
			}) and var_89_2._infoId ~= 40534 then
				local var_89_4, var_89_5 = var_89_2:hasChoiceSkill()

				if var_89_4 and B.isSkillChoiceSkill(var_89_5) then
					return arg_89_0:showChoiceSkill(arg_89_2, arg_89_3, var_89_5, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
				end
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(3851, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:hasSkills({
		2437,
		2560,
		2781,
		3940,
		6349,
		9453,
		9462
	}) or arg_89_2._card:isSkillAtIndex(2611, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(9507, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(9685, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13007, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(7824, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_6 = arg_89_1._choiceParam

		if var_89_6 then
			local var_89_7 = arg_89_0._player:getSyncCandidatesByTriggerCard(var_89_6, arg_89_2._card)

			var_89_1 = B.getChoiceByCandidatePos(var_89_7, var_89_0)

			if arg_89_1._choiceBase % 10 == 0 then
				var_89_1 = var_89_1 * 100
			end
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:isSkillAtIndex(6753, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_8 = arg_89_1._choiceParam

		if var_89_8 then
			local var_89_9 = arg_89_0._player:getXYZCandidatesByTriggerCard(var_89_8, arg_89_2._card)

			var_89_1 = B.getChoiceByCandidatePos(var_89_9, var_89_0)

			if arg_89_1._choiceBase % 10 == 0 then
				var_89_1 = var_89_1 * 100
			end
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:isSkillAtIndex(9298, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_10 = arg_89_1._choiceParam

		if var_89_10 then
			local var_89_11 = arg_89_0._player:getLinkCandidatesByTriggerCard(var_89_10, arg_89_2._card)

			var_89_1 = B.getChoiceByCandidatePos(var_89_11, var_89_0)

			if arg_89_1._choiceBase % 10 == 0 then
				var_89_1 = var_89_1 * 100
			end
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and B.isSkillCeremony(arg_89_2._card._skills[1]._id) or arg_89_1._choiceBase ~= nil and arg_89_2._card:isSkillAtIndex(7576, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_12 = arg_89_1._choiceParam

		if var_89_12 then
			local var_89_13 = arg_89_1._choiceBase and math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0
			local var_89_14

			if arg_89_2._card:hasSkillFast(4214) then
				var_89_14 = arg_89_0._player:getCeremonyPileCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			elseif arg_89_2._card:hasSkillFast(4504) then
				var_89_14 = arg_89_0._player:get4504CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			elseif var_89_13 == 2 and arg_89_2._card._infoId ~= 21024 then
				if arg_89_2._card:hasSkillFast(4199) then
					var_89_14 = arg_89_0._player:getCeremonyGraveCandidatesByTriggerCard(var_89_12, arg_89_2._card)
				elseif arg_89_2._card:hasSkillFast(4576) then
					var_89_14 = arg_89_0._player:get4576CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
				else
					var_89_14 = arg_89_0._player:get4388CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
				end
			elseif arg_89_2._card:hasSkillFast(4585) then
				var_89_14 = arg_89_0._player:get4585CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			elseif arg_89_2._card:hasSkillFast(4597) then
				var_89_14 = arg_89_0._player:get4597CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			elseif arg_89_2._card:hasSkillFast(4648) then
				var_89_14 = arg_89_0._player:get4648CeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			else
				var_89_14 = arg_89_0._player:getCeremonyCandidatesByTriggerCard(var_89_12, arg_89_2._card)
			end

			var_89_1 = B.getChoiceByCandidatePos(var_89_14, var_89_0)

			if not var_89_12:hasSkills({
				3825
			}) then
				local var_89_15, var_89_16 = var_89_12:hasChoiceSkill()

				if var_89_13 ~= 2 and var_89_15 and B.isSkillChoiceSkill(var_89_16) then
					return arg_89_0:showChoiceSkill(arg_89_2, arg_89_3, var_89_16, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
				end
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(3320, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_17 = Data._skillInfo[3320]
		local var_89_18 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_17._refCards[2]))

		if #var_89_18 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_18), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkills({
		3456,
		6691,
		6692
	}) and arg_89_1._choiceBase == 3 then
		for iter_89_0 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_0]._pos - 1)
		end
	elseif arg_89_2._card:hasSkills({
		3476
	}) and arg_89_1._choiceParam == nil and arg_89_1._choiceBase == 2 * BattleData.ChoiceId.stage_3 then
		var_89_1 = var_89_0[1]._id

		local var_89_19 = Data._skillInfo[3476]
		local var_89_20 = B.mergeTable({
			arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, arg_89_2._card),
			arg_89_0._player._opponent:getBattleCards("BCSD")
		})
		local var_89_21 = arg_89_0._player._opponent:getBattleCards("G")

		if #var_89_20 > 0 and #var_89_21 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_21, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkills({
		3538
	}) and arg_89_1._choiceParam == nil and arg_89_1._choiceBase == 2 then
		var_89_1 = var_89_0[1]._id

		local var_89_22 = Data._skillInfo[3538]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_22._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		3540
	}) and arg_89_1._choiceParam == nil and arg_89_2._card._status == BattleData.CardStatus.grave then
		var_89_1 = var_89_0[1]._id

		local var_89_23 = Data._skillInfo[3540]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_23._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		3555
	}) and arg_89_1._choiceParam == nil and arg_89_2._card._status == BattleData.CardStatus.board then
		var_89_1 = var_89_0[1]._id

		local var_89_24 = Data._skillInfo[3555]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("H", Data.CardType.monster), var_89_24._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(3714, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_25 = Data._skillInfo[3714]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(3737, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_26 = Data._skillInfo[3737]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_26._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		3835
	}) and arg_89_1._choiceParam == nil and arg_89_2._card._status == BattleData.CardStatus.board then
		var_89_1 = var_89_0[1]._id

		local var_89_27 = Data._skillInfo[3835]
		local var_89_28 = var_89_0[1]:getStar()
		local var_89_29 = B.mergeTable({
			B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_28), var_89_27._refCards[1]),
			B.filterInCategoryCards(arg_89_0._player._opponent:getBattleCardsByMaxStar("G", var_89_28), var_89_27._refCards[1])
		})

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_29, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(3866, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(3950, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		3809,
		4124
	}) then
		for iter_89_1 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_1]._pos + (var_89_0[iter_89_1]._owner == arg_89_2._card._owner and 0 or Data.MAX_CARD_COUNT_ON_BOARD) - 1)
		end
	elseif arg_89_2._card:hasSkills({
		3919
	}) and arg_89_2._card._status == BattleData.CardStatus.hand then
		for iter_89_2 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_2]._pos + (var_89_0[iter_89_2]._owner == arg_89_2._card._owner and 0 or Data.MAX_CARD_COUNT_ON_BOARD) - 1)
		end
	elseif arg_89_2._card:isSkillAtIndex(3957, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_30 = Data._skillInfo[3957]
		local var_89_31 = B.sortCardsByBoardPos(B.filterCanBindAlterMagicCards(B.filterInCategoryCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_30._val[1]), var_89_30._refCards[2]), var_89_30._refCards[3]), var_89_0[1]))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_31, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(3974, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_32 = Data._skillInfo[3974]

		var_89_1 = var_89_0[1]._id

		local var_89_33 = arg_89_0._player:getBattleCardsByCategoryGroup("H", var_89_32._refCards)

		var_89_33[#var_89_33 + 1] = var_89_0[1]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_33, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		3994
	}) then
		local var_89_34 = arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCards("BSD", Data.CARD_MAX_LEVLE, arg_89_2._card))

		for iter_89_3 = 1, #var_89_34 do
			var_89_34[iter_89_3]._tempPos = iter_89_3
		end

		for iter_89_4 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_4]._tempPos - 1)
		end

		for iter_89_5 = 1, #var_89_34 do
			var_89_34[iter_89_5]._tempPos = nil
		end
	elseif arg_89_2._card:hasSkills({
		4095,
		4318
	}) then
		local var_89_35 = arg_89_0._player:filterCanChangeToHandCards(B.filterNoSkillCards(arg_89_0._player:getBattleCards("H"), arg_89_2._card._skills[1]._id))

		for iter_89_6 = 1, #var_89_35 do
			var_89_35[iter_89_6]._tempPos = iter_89_6
		end

		for iter_89_7 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_7]._tempPos - 1)
		end

		for iter_89_8 = 1, #var_89_35 do
			var_89_35[iter_89_8]._tempPos = nil
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
		4100
	}) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_36 = Data._skillInfo[4100]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_36._refCards[1]), true, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		4140
	}) then
		for iter_89_9 = 1, #arg_89_1._cardInfos do
			arg_89_1._cardInfos[iter_89_9]._tempIndex = iter_89_9
		end

		for iter_89_10 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_10]._tempIndex - 1)
		end

		for iter_89_11 = 1, #arg_89_1._cardInfos do
			arg_89_1._cardInfos[iter_89_11]._tempIndex = nil
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.grave and arg_89_2._card:hasSkills({
		4157
	}) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_37 = Data._skillInfo[4157]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			arg_89_0._player:getBattleCards("C"),
			arg_89_0._player._opponent:getBattleCards("C")
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.field and arg_89_2._card:hasSkills({
		4411
	}) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_38 = Data._skillInfo[4411]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
		4431
	}) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_39 = Data._skillInfo[4431]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filter4431Cards(arg_89_0._player:getBattleCardsByMinStar("H", var_89_39._val[1]), arg_89_0._player), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		4445
	}) and arg_89_1._choiceParam ~= nil then
		var_89_1 = arg_89_1._choiceParam * 4000

		for iter_89_12 = 1, #var_89_0 do
			if var_89_0[iter_89_12] == arg_89_2._card._owner._fieldCard then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_COVER * 2)
			elseif var_89_0[iter_89_12] == arg_89_2._card._owner._opponent._fieldCard then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_COVER * 2 + 1)
			else
				var_89_1 = var_89_1 + 2^(var_89_0[iter_89_12]._pos + (var_89_0[iter_89_12]._owner == arg_89_2._card._owner and 0 or Data.MAX_CARD_COUNT_ON_COVER) - 1)
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(4465, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil or arg_89_2._card:isSkillAtIndex(4798, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_40 = Data._skillInfo[4465]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterEquipMagicCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_40._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4486, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_41 = Data._skillInfo[4486]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_41._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4529, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_42 = Data._skillInfo[4529]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInTypeCards(arg_89_0._player:getBattleCardsByKeywordGroup("P", var_89_42._refCards), Data.CardType.magic))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4572, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_43 = Data._skillInfo[4572]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic), var_89_43._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4589) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_44 = B.mergeTable({
			arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]),
			arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.monster)
		})

		if #var_89_44 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_44, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkillFast(4594) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_45 = Data._skillInfo[4594]
		local var_89_46 = B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("GP", var_89_45._refCards[2])))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_46, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4596, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_47 = Data._skillInfo[4596]
		local var_89_48 = B.sortCardsByBoardPos(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByHp("P", 0), var_89_47._refCards[1]))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_48, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4628) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_49 = Data._skillInfo[4628]
		local var_89_50 = arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryGroupCards(arg_89_0._player:getBattleCardsByMaxStar("L", var_89_49._val[1]), var_89_49._refCards))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_50, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4631, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_51 = Data._skillInfo[4631]
		local var_89_52 = arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_51._refCards[2]), arg_89_2._card))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_52, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4633, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_53 = Data._skillInfo[4633]
		local var_89_54 = arg_89_0._player:filterCanChangeToBoardCards(B.filterXYZCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_53._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), true))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_54, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4666) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(4678, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_55 = Data._skillInfo[4678]
		local var_89_56 = arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("L", var_89_55._refCards[2]), nil, nil, nil, true)

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_56, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4689) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:hasSkillFast(4701) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(4728, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_57 = Data._skillInfo[4728]
		local var_89_58 = B.filterFirstCards(arg_89_0._player:getBattleCards("P", Data.CARD_MAX_LEVEL, var_89_0[1]), 2)

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_58, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4804, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4821, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

		if #arg_89_1._cardInfos > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(4827, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_59 = Data._skillInfo[4827]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_59._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4840, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_60 = Data._skillInfo[4840]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4872) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_61 = Data._skillInfo[4872]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByMinStar("G", 0)), 2, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(4872) and arg_89_1._choiceParam ~= nil then
		arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_89_2._card,
			_target = arg_89_0._player:getCardById(arg_89_1._choiceParam),
			_choice = (var_89_0[1]._id * BattleData.UseCardId.id_group + var_89_0[2]._id) * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase
		})

		return
	elseif arg_89_2._card:isSkillAtIndex(4941, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_62 = Data._skillInfo[4941]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_62._refCards[1]), arg_89_2._card))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4942, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_63 = arg_89_0._player._opponent:getBattleCards("BCSD")

		if #var_89_63 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_63), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(4944, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_64 = Data._skillInfo[4944]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotInStarCards(arg_89_0._player:getBattleCardsByKeywordGroup("P", var_89_64._refCards), var_89_0[1]:getStar()), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4983, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_65 = Data._skillInfo[4983]
		local var_89_66 = arg_89_0._player._opponent:getBattleCards("BCSD")

		if #var_89_66 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_66), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkillFast(4984) and arg_89_3 == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_67 = Data._skillInfo[4984]
		local var_89_68 = arg_89_0._player:filterCanChangeToHandCards(B.mergeTable({
			arg_89_0._player:getBattleCardsByInfoId("P", var_89_67._refCards[1]),
			arg_89_0._player:getBattleCardsByKeywordGroup("P", {
				var_89_67._refCards[2],
				var_89_67._refCards[3]
			})
		}))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), B.sortCardsByBoardPos(var_89_68), 2, arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(4991, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("CSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(4993, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_69 = Data._skillInfo[4993]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_69._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
		5104
	}) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_70 = Data._skillInfo[5104]
		local var_89_71 = B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInNatureCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_70._val[1]), var_89_70._refCards[2]), var_89_70._refCards[3])))

		if #var_89_71 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_71, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkills({
		5118
	}) and arg_89_1._choiceBase % BattleData.ChoiceId.stage_size_1 == 1 and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_72 = Data._skillInfo[5118]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterNotBindedCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_72._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_0[1]:getAlterMagicInfoId()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5232) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_73 = Data._skillInfo[5232]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_73._refCards[1]), var_89_0[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5283, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(5285, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 2, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5285, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam ~= nil then
		local var_89_74 = {
			arg_89_0._player:getCardById(arg_89_1._choiceParam)
		}

		for iter_89_13 = 1, #var_89_0 do
			var_89_74[#var_89_74 + 1] = var_89_0[iter_89_13]
		end

		var_89_1 = arg_89_0._player:getBCSDCardChoice(var_89_74)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5332) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_75 = Data._skillInfo[5332]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5343) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_76 = Data._skillInfo[5343]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5440, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_77 = Data._skillInfo[5440]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_89_0._player:getBattleCardsByNature("R", var_89_77._refCards[1]), true), var_89_0[1]._info._star + 1), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5445) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_78 = Data._skillInfo[5445]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_78._refCards[1]), var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5450, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		if arg_89_3 == nil then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), arg_89_0._player:getBattleCards2By5450(var_89_0[1]), 1, arg_89_1._choiceBase)
		else
			var_89_1 = var_89_0[1]._id

			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterSyncCards(arg_89_0._player:getBattleCardsByStar("R", arg_89_3._card:getStar() + var_89_0[1]:getStar()), true), true, true, nil, true), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5461) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_79 = Data._skillInfo[5461]

		if #arg_89_0._player:getBattleCardsByInfoId("B", var_89_79._refCards[3]) > 0 and #arg_89_0._player._opponent:getBattleCards("BCSD") > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(5463, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_80 = Data._skillInfo[5463]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_80._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5472) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_81 = Data._skillInfo[5472]
		local var_89_82 = arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1])

		if #var_89_82 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_82, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5476) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_83 = Data._skillInfo[5476]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("BG", Data.CardType.monster), var_89_83._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5502, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_84 = Data._skillInfo[5502]
		local var_89_85 = B.filterXYZCards(arg_89_0._player:getBattleCardsByCategory("B", var_89_84._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), true)

		if #var_89_85 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_85), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5503) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(5505, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

		if #arg_89_1._cardInfos > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5508) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldTrap)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5517) then
		if arg_89_1._choiceParam == nil then
			var_89_1 = var_89_0[1]._id

			local var_89_86 = Data._skillInfo[5517]
			local var_89_87 = B.filterInCategoryCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_86._refCards[3])

			return arg_89_0:showChoiceGrave(arg_89_2, nil, B.sortCardsByBoardPos(var_89_87), 2, arg_89_1._choiceBase, var_89_1)
		else
			for iter_89_14 = #var_89_0, 1, -1 do
				var_89_1 = var_89_1 * BattleData.UseCardId.id_group + var_89_0[iter_89_14]._id
			end

			return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
				_card = arg_89_2._card,
				_target = arg_89_0._player:getCardById(arg_89_1._choiceParam),
				_choice = var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase
			})
		end
	elseif arg_89_2._card:isSkillAtIndex(5539, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("G"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5543) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_88 = Data._skillInfo[5543]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_88._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5561, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_89 = Data._skillInfo[5561]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_89._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5566, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_90 = Data._skillInfo[5566]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_90._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5571, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_91 = Data._skillInfo[5571]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("G", var_89_91._refCards)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5572, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_92 = Data._skillInfo[5572]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByInfoIdGroup("G", var_89_92._refCards), true, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5595) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(5597, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_93 = Data._skillInfo[5597]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterHasOppoShieldCards(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5603, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_94 = Data._skillInfo[5603]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByNature("B", var_89_94._refCards[2], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5605, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_95 = Data._skillInfo[5605]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldTrap, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5608) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(5614, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_96 = Data._skillInfo[5614]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(5617, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_97 = Data._skillInfo[5617]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBoardCards())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5622) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_98 = Data._skillInfo[5622]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5624) and arg_89_3 == nil then
		local var_89_99 = Data._skillInfo[5624]
		local var_89_100 = B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_89_0[1]))
		})

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), var_89_100, math.min(2, #var_89_100), arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(5646, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_101 = Data._skillInfo[5646]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_101._refCards[2]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		6265
	}) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_102 = Data._skillInfo[6265]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByKeyword("G", var_89_102._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		6286
	}) and arg_89_2._card._status == BattleData.CardStatus.board and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_103 = Data._skillInfo[6286]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByNature("P", var_89_103._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6365, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_104 = Data._skillInfo[6365]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterCanBindAlterMagicCards(B.filterAdjustCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_104._refCards[1]), true), arg_89_2._card), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6396, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_105 = Data._skillInfo[6396]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6507, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_106 = Data._skillInfo[6507]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		6616
	}) and arg_89_2._card._status == BattleData.CardStatus.grave and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_107 = Data._skillInfo[6616]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.mergeTable({
			arg_89_0._player:getBattleCardsByAtkDef("G", 2400, 1000),
			arg_89_0._player:getBattleCardsByAtkDef("G", 2800, 1000)
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6618, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_108 = Data._skillInfo[6618]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_108._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6619, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_109 = Data._skillInfo[6619]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInStarCards(B.filterAdjustCards(arg_89_0._player:getBattleCards("P"), true), var_89_0[1]:getStar())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6679, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_110 = Data._skillInfo[6679]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6732, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_111 = Data._skillInfo[6732]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BCSD"), BattleData.PositiveType.shieldMonster)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BCSD"), BattleData.PositiveType.shieldMonster))), 2, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam ~= nil then
		local var_89_112 = {
			arg_89_0._player:getCardById(arg_89_1._choiceParam)
		}

		for iter_89_15 = 1, #var_89_0 do
			var_89_112[#var_89_112 + 1] = var_89_0[iter_89_15]
		end

		var_89_1 = arg_89_0._player:getBCSDCardChoice(var_89_112)
	elseif arg_89_2._card:isSkillAtIndex(6735, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_113 = Data._skillInfo[6735]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("G")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6746, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_114 = Data._skillInfo[6746]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByStarGroup("G", {
			var_89_114._refCards[2],
			var_89_114._refCards[3]
		}), var_89_114._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6772, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_115 = Data._skillInfo[6772]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic), var_89_115._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6792, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		for iter_89_16 = 1, #var_89_0 do
			if var_89_0[iter_89_16] == arg_89_2._card._owner._opponent._fieldCard then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_BOARD + Data.MAX_CARD_COUNT_ON_COVER)
			elseif var_89_0[iter_89_16]._status ~= BattleData.CardStatus.board then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_BOARD + var_89_0[iter_89_16]._pos - 1)
			else
				var_89_1 = var_89_1 + 2^(var_89_0[iter_89_16]._pos - 1)
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(6795, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_116 = Data._skillInfo[6795]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_116._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6861, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		for iter_89_17 = 1, #var_89_0 do
			if var_89_0[iter_89_17] == arg_89_2._card._owner._fieldCard then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_COVER * 2)
			elseif var_89_0[iter_89_17] == arg_89_2._card._owner._opponent._fieldCard then
				var_89_1 = var_89_1 + 2^(Data.MAX_CARD_COUNT_ON_COVER * 2 + 1)
			else
				var_89_1 = var_89_1 + 2^(var_89_0[iter_89_17]._pos + (var_89_0[iter_89_17]._owner == arg_89_2._card._owner and 0 or Data.MAX_CARD_COUNT_ON_COVER) - 1)
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(6841, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_117 = Data._skillInfo[6841]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_2._card:getBindedEquipsByKeyword(var_89_117._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6848, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_118 = Data._skillInfo[6848]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterEquipMagicCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_118._refCards[2])))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6921, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_119 = Data._skillInfo[6921]
		local var_89_120 = B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_119._refCards[1])))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_120, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6964, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6978, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSDG")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(6982, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_121 = Data._skillInfo[6982]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByInfoIdGroup("B", {
			var_89_121._refCards[2],
			var_89_121._refCards[3]
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2111, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2112, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_122 = Data._skillInfo[2112]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("P", var_89_122._refCards))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2116, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2117, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_123 = arg_89_0._player._opponent:getBoardCards()

		if #var_89_123 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_123), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(2135, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_124 = Data._skillInfo[2135]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByStarGroup("G", {
			7,
			8
		}), var_89_124._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2142, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2155, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		if var_89_0[1]:isMerge() then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterMergeCards(arg_89_0._player._opponent:getBoardCards())), 1, arg_89_1._choiceBase, var_89_1)
		elseif var_89_0[1]:isSync() then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterSyncCards(arg_89_0._player._opponent:getBoardCards(), true)), 1, arg_89_1._choiceBase, var_89_1)
		elseif var_89_0[1]:isXYZ() then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player._opponent:getBoardCards(), true)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(2160, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2196, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2203, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2209, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNormalCards(arg_89_0._player:getBattleCards("G")))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2212, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2279, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_125 = Data._skillInfo[2279]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_125._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2320, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_126 = Data._skillInfo[2320]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterMoreThanStarCards(arg_89_0._player:getBattleCardsByMaxQuality("G", 4), var_89_126._val[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2341, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_127 = Data._skillInfo[2341]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, arg_89_2._card))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2359, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2384, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2389, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2392, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_128 = Data._skillInfo[2392]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_128._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2400, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2409, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_129 = Data._skillInfo[2409]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByCategory("H", var_89_129._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2429, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_130 = Data._skillInfo[2429]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterSyncCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByStar("R", var_89_0[1]:getStar() + arg_89_2._card:getStar()), var_89_130._refCards[1]), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2430, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_131 = Data._skillInfo[2430]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterAdjustCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByHp("P", 0), var_89_131._refCards[1]), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2434, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_132 = Data._skillInfo[2434]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]))),
			B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBoardCards()))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2441, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_133 = Data._skillInfo[2441]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2449, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_134 = Data._skillInfo[2449]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByMinStar("B", 0)),
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByMinStar("B", 0))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2450, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_135 = Data._skillInfo[2450]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByMinStar("B", 0)),
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByMinStar("B", 0))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2486, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2487, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_136 = Data._skillInfo[2487]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("G", 7), var_89_136._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2534, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_137 = Data._skillInfo[2534]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_137._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2562, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_138 = Data._skillInfo[2562]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoId("P", var_89_138._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2578, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_139 = Data._skillInfo[2578]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotEqualInfoIdExCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_139._refCards[1]), var_89_139._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2585, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_140 = Data._skillInfo[2585]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByNature("B", var_89_140._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2586, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2587, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_141 = Data._skillInfo[2587]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByNature("B", var_89_141._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2588, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
			B.sortCardsByBoardPos(arg_89_0._player:getBoardCards())
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2598, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2599, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBoardCards())),
			B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBoardCards()))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2602, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2615, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_142 = Data._skillInfo[2615]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMinStar("B", var_89_0[1]:getStar() + 1), var_89_142._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2739, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2745, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2750, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_143 = Data._skillInfo[2750]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMinStar("G", var_89_143._val[1], Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_143._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2772, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_144 = Data._skillInfo[2772]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_144._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2774, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_145 = Data._skillInfo[2774]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_145._refCards[1]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2776, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = arg_89_0._player:getBCSDCardChoice(var_89_0)

		local var_89_146 = Data._skillInfo[2776]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2785, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_147 = Data._skillInfo[2785]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]), false)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2787, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_148 = Data._skillInfo[2787]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_148._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2789, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_149 = Data._skillInfo[2789]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_149._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2806, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_150 = Data._skillInfo[2806]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_150._val[1]), var_89_150._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2811, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2813, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_151 = Data._skillInfo[2813]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeywordGroup("P", var_89_151._refCards))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2838, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_152 = Data._skillInfo[2838]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_152._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]._binds[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2867, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_153 = Data._skillInfo[2867]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_153._val[1]), var_89_153._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2879, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2886, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_154 = Data._skillInfo[2886]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByStar("P", var_89_154._val[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2915, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_155 = Data._skillInfo[2915]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_155._refCards[1]), arg_89_2._card))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2928, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_156 = Data._skillInfo[2928]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByInfoIdGroup("G", {
			var_89_156._refCards[2],
			var_89_156._refCards[3]
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2930, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = arg_89_0._player:getBCSDCardChoice(var_89_0)

		local var_89_157 = Data._skillInfo[2930]
		local var_89_158 = arg_89_0._player._opponent:getBattleCards("BCSD")

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_158), math.min(#var_89_158, 2), arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2930, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam ~= nil then
		var_89_1 = arg_89_1._choiceParam + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(2942, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_159 = Data._skillInfo[2942]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2951, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_160 = Data._skillInfo[2951]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2959, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_161 = Data._skillInfo[2959]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByMaxStar("G", var_89_161._val[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2963, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_162 = Data._skillInfo[2963]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterSyncCards(arg_89_0._player:getBattleCardsByCategoryAndNature("G", var_89_162._refCards[2], var_89_162._refCards[3]), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2969, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_163 = Data._skillInfo[2969]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBoardCards(), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(2964, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 1, 8, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(2976, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 1, 8, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(2986, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldMonster)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9009, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_89_0._player._opponent:getBoardCards())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9034, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByBuff("B", true, BattleData.PositiveType.defendPosture)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9051, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_164 = Data._skillInfo[9051]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByCategory("BHG", var_89_164._refCards[2], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9052, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_165 = Data._skillInfo[9051]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByCategory("BHG", var_89_165._refCards[2], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9071, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9072, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_166 = Data._skillInfo[9072]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_89_0[1])),
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9092, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9124, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_167 = Data._skillInfo[9124]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_167._refCards[1]), var_89_167._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9142, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9165, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9168, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9189, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9198, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_168 = Data._skillInfo[9198]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_168._refCards[1]), arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9204, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9213, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_169 = Data._skillInfo[9213]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_169._refCards[1]), arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9214, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_170 = Data._skillInfo[9214]

		var_89_1 = var_89_0[1]._id

		local var_89_171 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMinStar("P", var_89_170._val[1]), var_89_170._refCards[1]))

		if #var_89_171 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_171), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(9218, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_172 = Data._skillInfo[9218]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_172._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9220, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSDG")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9227, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9230, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9258, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterDualCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1])))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9260, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9269, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9282, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9289, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9305, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_173 = Data._skillInfo[9305]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInNatureCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_173._val[1]), var_89_173._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9306, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_174 = Data._skillInfo[9306]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInNatureCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_174._val[1]), var_89_174._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9314, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_175 = Data._skillInfo[9314]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByStar("P", var_89_175._val[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9320, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9323, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9330, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_176 = Data._skillInfo[9330]
		local var_89_177 = B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("H", Data.CardType.monster), var_89_176._refCards[1])

		for iter_89_18 = 1, #var_89_177 do
			var_89_177[iter_89_18]._tempPos = iter_89_18
		end

		for iter_89_19 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_19]._tempPos - 1)
		end

		for iter_89_20 = 1, #var_89_177 do
			var_89_177[iter_89_20]._tempPos = nil
		end
	elseif arg_89_2._card:hasSkillFast(9343) then
		for iter_89_21 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_21]._pos - 1)
		end
	elseif arg_89_2._card:isSkillAtIndex(9373, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterSustainableMagicCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic)))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9375, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.mergeTable({
			arg_89_0._player:getBattleCardsByType("G", Data.CardType.rare, Data.CARD_MAX_LEVEL, var_89_0[1]),
			arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.rare, Data.CARD_MAX_LEVEL, var_89_0[1])
		}), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9378, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_178 = Data._skillInfo[9378]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("HG", var_89_0[1]:getStar()), var_89_178._refCards[2]), var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9392, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_179 = Data._skillInfo[9378]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_0[1]:getStar()), var_89_179._refCards[2]), var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9382, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBattleCards("CSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9396, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_180 = Data._skillInfo[9396]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNotBindedAllInfoIdGroupCards(arg_89_0._player:getBattleCardsByInfoId("B", var_89_180._refCards[2]), {
			var_89_180._refCards[3],
			var_89_180._refCards[4],
			var_89_180._refCards[5],
			var_89_180._refCards[6],
			var_89_180._refCards[7]
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif (arg_89_2._card:isSkillAtIndex(9480, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(9481, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3))) and arg_89_1._choiceParam == nil then
		local var_89_181 = Data._skillInfo[9480]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_181._refCards[2]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9485, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_182 = Data._skillInfo[9485]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.mergeTable({
			arg_89_0._player:getBattleCardsByType("G", Data.CardType.trap),
			arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.trap)
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9497, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_183 = Data._skillInfo[9497]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("P", var_89_183._refCards))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9513, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9515, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9518, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBoardCards(), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9523, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9556, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("C"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9563, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_184 = Data._skillInfo[9563]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_184._refCards[1]), arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9593, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_185 = Data._skillInfo[9593]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByCategory("P", var_89_185._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9600, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_186 = Data._skillInfo[9600]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterNotInStarCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_186._refCards[1]), var_89_0[1]:getStar()), arg_89_2._card))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9614, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_187 = Data._skillInfo[9614]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_187._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9615, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_188 = Data._skillInfo[9615]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_188._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9638, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_189 = Data._skillInfo[9638]

		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByCategory("P", var_89_189._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9694, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if #var_89_0 > 0 then
			var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

			if #arg_89_1._cardInfos > 1 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
			end
		else
			var_89_1 = arg_89_1._choiceParam or 0
		end
	elseif arg_89_2._card:isSkillAtIndex(9712, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("R"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9721, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_190 = Data._skillInfo[9733]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterUniqueInfoIdCards(arg_89_0._player:getBattleCardsByCategory("G", var_89_190._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9739, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9763, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if arg_89_3 == nil then
			var_89_1 = var_89_0[1]._id

			local var_89_191 = Data._skillInfo[9763]
			local var_89_192 = B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMinStar("BH", 0), var_89_191._refCards[1])

			return arg_89_0:showChoiceGrave(arg_89_2, {
				_card = var_89_0[1]
			}, B.sortCardsByBoardPos(var_89_192), #var_89_192, arg_89_1._choiceBase)
		else
			var_89_1 = 0

			for iter_89_22 = 1, #var_89_0 do
				local var_89_193 = var_89_0[iter_89_22]._pos

				if var_89_0[iter_89_22]._status == BattleData.CardStatus.hand then
					var_89_193 = var_89_193 + Data.MAX_CARD_COUNT_ON_BOARD + 1
				end

				var_89_1 = var_89_1 + 2^var_89_193
			end
		end
	elseif arg_89_2._card:isSkillAtIndex(9766, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9768, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(9785, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_194 = Data._skillInfo[9785]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_194._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9786, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_195 = Data._skillInfo[9786]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9815, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9841, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_196 = arg_89_0._player:getBattleCardsByType("G", Data.CardType.magic)
		local var_89_197 = B.filterSustainableMagicCards(var_89_196)

		B.appendTable(var_89_197, B.filterFieldMagicCards(var_89_196))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(var_89_197), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9851, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_198 = Data._skillInfo[9851]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_198._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9867, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_199 = Data._skillInfo[9867]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByMaxStar("H", var_89_0[1]:getStar())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9916, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_200 = Data._skillInfo[9916]
		local var_89_201 = #arg_89_0._player:getBattleCardsByInfoId("SD", var_89_200._refCards[2]) > 0
		local var_89_202 = arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_200._refCards[1]))

		if var_89_201 then
			B.appendTable(var_89_202, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByCategory("P", var_89_200._refCards[3])))

			var_89_202 = B.filterUniqueInfoIdCards(var_89_202)
		end

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_202), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9917, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_203 = Data._skillInfo[9917]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMinStar("H", var_89_0[1]:getStar()), var_89_203._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9918, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_204 = Data._skillInfo[9918]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByCategory("B", var_89_204._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card), var_89_204._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9934, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterFieldMagicCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic)))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9944, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._alreadySatisfied then
		arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
			_card = arg_89_2._card,
			_target = arg_89_3 ~= nil and arg_89_3._card or nil,
			_choice = arg_89_1._choiceBase
		})
	elseif arg_89_2._card:isSkillAtIndex(9956, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBattleCardsByNoBuff("B", true, BattleData.PositiveType.xyzMark), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9960, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_205 = Data._skillInfo[9960]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_205._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9965, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_206 = Data._skillInfo[9965]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoId("PG", var_89_206._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9983, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_207 = Data._skillInfo[9983]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_207._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(9984, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_208 = Data._skillInfo[9984]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("HP", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_208._refCards[2]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13002, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_209 = Data._skillInfo[13002]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("P", {
			var_89_209._refCards[2],
			var_89_209._refCards[3]
		}))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13009, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13039, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("G"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13044, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

		if #arg_89_1._cardInfos > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13045, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

		if #arg_89_1._cardInfos > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13054, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_210 = Data._skillInfo[13054]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("P", var_89_210._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13068, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_211 = Data._skillInfo[13068]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterNormalTrapCards(arg_89_0._player:getBattleCardsByType("GL", Data.CardType.trap))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13072, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_212 = Data._skillInfo[13072]
		local var_89_213 = B.filterNotBindedCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_212._refCards[2]), var_89_0[1]:getAlterMagicInfoId())

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_213), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13106, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13138, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13141, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 1, 8, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(13147, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = 0

		for iter_89_23 = 1, #var_89_0 do
			local var_89_214 = var_89_0[iter_89_23]._pos

			if var_89_0[iter_89_23]._status == BattleData.CardStatus.hand then
				var_89_214 = var_89_214 + Data.MAX_CARD_COUNT_ON_BOARD + 1
			end

			var_89_1 = var_89_1 + 2^var_89_214
		end
	elseif arg_89_2._card:isSkillAtIndex(13149, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13155, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = 0

		for iter_89_24 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_24]._pos - 1)
		end

		local var_89_215 = Data._skillInfo[13155]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13156, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = 0

		for iter_89_25 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_25]._pos - 1)
		end

		local var_89_216 = Data._skillInfo[13156]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_216._refCards[1]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13157, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = 0

		for iter_89_26 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_26]._pos - 1)
		end

		local var_89_217 = Data._skillInfo[13157]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterHasOppoShieldCards(arg_89_0._player._opponent:getBoardCards())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13165, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_218 = Data._skillInfo[13165]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByStar("P", var_89_218._val[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13168, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_219 = Data._skillInfo[13168]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_219._refCards[1]), var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13185, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_220 = Data._skillInfo[13185]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByCategory("H", var_89_220._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13218, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13220, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13221, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13223, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13231, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13275, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_89_2._card:isSkillAtIndex(13276, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_89_221 = arg_89_0._player:filterCanChangeToHandCards(B.filterNoSkillCards(arg_89_0._player:getBattleCards("H"), arg_89_2._card._skills[1]._id))

		for iter_89_27 = 1, #var_89_221 do
			var_89_221[iter_89_27]._tempPos = iter_89_27
		end

		for iter_89_28 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_28]._tempPos - 1)
		end

		for iter_89_29 = 1, #var_89_221 do
			var_89_221[iter_89_29]._tempPos = nil
		end
	elseif arg_89_2._card:isSkillAtIndex(13296, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_222 = Data._skillInfo[13296]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterLinkCards(arg_89_0._player:getBattleCardsByCategory("G", var_89_222._refCards[1]), false)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13318, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_223 = Data._skillInfo[13318]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_223._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13321, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_224 = Data._skillInfo[13321]
		local var_89_225 = arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_224._refCards[1]))

		if #var_89_225 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_225, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13330, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_226 = Data._skillInfo[13330]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterDieByAttackOrEffectCards(B.mergeTable({
			B.filterOnGraveRoundCards(arg_89_0._player._graveCards, arg_89_0._player._round),
			B.filterOnGraveEndRoundCards(arg_89_0._player._opponent._graveCards, arg_89_0._player._opponent._endRound)
		}))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13332, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_227 = Data._skillInfo[13332]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_89_0._player:getBattleCardsByMaxQuality("B", var_89_227._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13365, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_228 = Data._skillInfo[13365]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("PG", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_228._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13367, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_229 = Data._skillInfo[13367]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13370, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		for iter_89_30 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_30]._pos - 1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13371, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(13373, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_230 = Data._skillInfo[13373]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13380, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_231 = Data._skillInfo[13380]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player._opponent:getBattleCardsByMaxQuality("G", var_89_231._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13398, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_232 = Data._skillInfo[13398]
		local var_89_233 = arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_232._refCards[1]))

		if #var_89_233 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_233), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13401, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_234 = Data._skillInfo[13401]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBoardCards())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13405, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_235 = Data._skillInfo[13405]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_235._refCards[2]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13408, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_236 = Data._skillInfo[13408]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByInfoIdGroup("BSD", var_89_236._refCards), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13411, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_237 = Data._skillInfo[13411]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_237._refCards[1]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13430, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_238 = Data._skillInfo[13430]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13432, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_239 = Data._skillInfo[13432]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13452, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_240 = Data._skillInfo[13452]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13468, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_241 = Data._skillInfo[13468]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:filterCanChangeToHandCards(arg_89_0._player._opponent:getBattleCards("BCSD"))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13538, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_242 = Data._skillInfo[13538]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_242._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13552, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_243 = Data._skillInfo[13552]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_243._refCards[1]), var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13553, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_244 = Data._skillInfo[13553]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_244._refCards[1]), var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13572, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_245 = Data._skillInfo[13572]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_245._refCards[1]), var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13602, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_246 = Data._skillInfo[13602]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInTypeCards(arg_89_0._player:getBattleCardsByKeyword("GL", var_89_246._refCards[2]), Data.CardType.monster)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13607, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_247 = Data._skillInfo[13607]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_247._refCards[1]), arg_89_2._card), nil, nil, nil, var_89_0[1]._status == BattleData.CardStatus.board), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13576, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_248 = Data._skillInfo[13576]
		local var_89_249 = B.filterFirstCards(arg_89_0._player:getBattleCards("P", Data.CARD_MAX_LEVEL, var_89_0[1]), 2)

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_249, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13618, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_250 = Data._skillInfo[13618]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_250._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13626, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_251 = Data._skillInfo[13626]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13697, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = (arg_89_1._choiceParam or 0) * 10 + var_89_0[1]._pos

		if #arg_89_1._cardInfos > 1 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterExcludeCards(arg_89_1._cardInfos, var_89_0)), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(13703, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_252 = Data._skillInfo[13703]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNotSameNamesCards(B.mergeTable({
			B.filterSustainableMagicCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic), var_89_252._refCards[1])),
			B.filterSustainableTrapCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.trap), var_89_252._refCards[1]))
		}), arg_89_0._player:getBattleCards("CSD"))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13710, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_253 = Data._skillInfo[13710]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.mergeTable({
			B.filterNormalCards(arg_89_0._player:getBattleCardsByType("HP", Data.CardType.monster)),
			B.filterDualCards(arg_89_0._player:getBattleCardsByType("HP", Data.CardType.monster))
		}), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13719, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_254 = arg_89_0._player:filterCanChangeToHandCards(B.filterNoSkillCards(arg_89_0._player:getBattleCards("H"), arg_89_2._card._skills[1]._id))

		for iter_89_31 = 1, #var_89_254 do
			var_89_254[iter_89_31]._tempPos = iter_89_31
		end

		for iter_89_32 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_32]._tempPos - 1)
		end

		for iter_89_33 = 1, #var_89_254 do
			var_89_254[iter_89_33]._tempPos = nil
		end
	elseif arg_89_2._card:isSkillAtIndex(13733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		local var_89_255 = Data._skillInfo[13733]
		local var_89_256 = arg_89_0._player:getBattleCardsByKeyword("H", var_89_255._refCards[1])

		for iter_89_34 = 1, #var_89_256 do
			var_89_256[iter_89_34]._tempPos = iter_89_34
		end

		for iter_89_35 = 1, #var_89_0 do
			var_89_1 = var_89_1 + 2^(var_89_0[iter_89_35]._tempPos - 1)
		end

		for iter_89_36 = 1, #var_89_256 do
			var_89_256[iter_89_36]._tempPos = nil
		end
	elseif arg_89_2._card:isSkillAtIndex(13747, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 1, 8, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(13764, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_257 = Data._skillInfo[13764]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_257._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13766, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_258 = Data._skillInfo[13766]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_258._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13767, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_259 = Data._skillInfo[13767]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_259._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13792, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_260 = Data._skillInfo[13792]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13793, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13847, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13851, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 1, 5, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(13959, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(13995, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByNature("B", var_89_0[1]._info._nature)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14010, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(14020, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_261 = Data._skillInfo[14020]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_261._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14047, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_262 = Data._skillInfo[14047]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByKeyword("G", var_89_262._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14154, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player:getBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(14163, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14176, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_263 = Data._skillInfo[14176]
		local var_89_264 = arg_89_0._player:filterCanChangeToHandCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_263._val[1]), var_89_263._refCards[1]))

		if var_89_0[1]:getStar() == var_89_263._val[1] then
			B.appendTable(var_89_264, {
				var_89_0[1]
			})
		end

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_264), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14185, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14201, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player._opponent:getSingleBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(14308, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player._opponent:getSingleBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(14325, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceNumber(arg_89_2, arg_89_3, 4, 5, var_89_1 * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	elseif arg_89_2._card:isSkillAtIndex(14337, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_265 = Data._skillInfo[14337]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_265._refCards[1]), arg_89_2._card), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14411, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_266 = Data._skillInfo[14411]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByNature("G", var_89_266._refCards[1]), arg_89_2._card)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14441, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_267 = Data._skillInfo[14441]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14474, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14534, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14528, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		var_89_1 = var_89_1 + arg_89_0._player._opponent:getSingleBCSDCardChoice(var_89_0)
	elseif arg_89_2._card:isSkillAtIndex(14561, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_268 = Data._skillInfo[14561]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterNotInKeywordCards(arg_89_0._player:getBattleCardsByNature("P", var_89_268._refCards[1]), var_89_268._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14570, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_269 = Data._skillInfo[14570]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_269._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14579, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_270 = Data._skillInfo[14579]
		local var_89_271 = arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoId("P", var_89_270._refCards[4]))

		if #var_89_271 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_271), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(14588, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14598, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_272 = Data._skillInfo[14598]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCardsByMaxQuality("BCSD", var_89_272._refCards[2]), BattleData.PositiveType.shieldMonster, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(14604, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_273 = Data._skillInfo[14604]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterInTypeCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_273._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card), Data.CardType.monster), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		7113
	}) then
		return arg_89_0:showChoiceSacrifice(arg_89_0:getCardSprite(var_89_0[1]), arg_89_2, arg_89_1._choiceBase + var_89_0[1]._id * BattleData.UseCardId.id_group * BattleData.ChoiceId.stage_2 + 7, nil)
	elseif arg_89_2._card:isSkillAtIndex(7234, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_274 = Data._skillInfo[7234]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.mergeTable({
			B.filterCeremonyMonsterCards(arg_89_0._player:getBattleCardsByNature("P", var_89_274._refCards[1])),
			B.filterCeremonyMagicCards(arg_89_0._player:getBattleCards("P"))
		})), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7244, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_275 = Data._skillInfo[7244]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_275._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7309, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_276 = Data._skillInfo[7309]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByHp("G", 0), var_89_276._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7310, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_277 = Data._skillInfo[7310]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterInCategoryCards(arg_89_0._player:getBattleCardsByHp("L", 0), var_89_277._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7328, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_278 = Data._skillInfo[7328]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInNatureCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByMinStar("R", var_89_0[1]:getStar()), var_89_278._refCards[1]), var_89_0[1]._info._nature), true, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7336, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7337, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_279 = Data._skillInfo[7337]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_279._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7338, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_280 = Data._skillInfo[7338]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_280._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7365, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_281 = Data._skillInfo[7365]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByCategory("B", var_89_281._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7374, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7380, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_282 = Data._skillInfo[7380]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_282._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7404, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_283 = Data._skillInfo[7404]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInCategoryGroupCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_283._val[1]), {
			var_89_283._refCards[2],
			var_89_283._refCards[3],
			var_89_283._refCards[4]
		}))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7408, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_284 = Data._skillInfo[7408]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_284._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1])), false, true, nil, var_89_0[1]._status == BattleData.CardStatus.board), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7429, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_285 = Data._skillInfo[7429]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_285._val[1]), var_89_285._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7433, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_286 = Data._skillInfo[7433]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByAtkDef("G", 0, 0), var_89_286._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7454, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_287 = Data._skillInfo[7454]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_287._refCards[1]), nil, nil, nil, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7534, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_288 = Data._skillInfo[7534]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_288._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7551, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_289 = Data._skillInfo[7551]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), var_89_289._refCards)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7566, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_290 = Data._skillInfo[7566]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BSD"), BattleData.PositiveType.shieldMagic)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(7574) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_291 = Data._skillInfo[7574]
		local var_89_292 = arg_89_0._player:getBattleCardsByCategory("PH", var_89_291._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1])

		if #var_89_292 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_292), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkillFast(7578) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_293 = Data._skillInfo[7578]
		local var_89_294 = B.filterXYZCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_293._refCards[1]), true)

		if #var_89_294 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_294), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(7582, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_295 = Data._skillInfo[7582]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterMergeCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_295._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(7628) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_3 == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_296 = Data._skillInfo[7628]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), B.sortCardsByBoardPos(B.filterUniqueInfoIdCards(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_296._refCards[2])))), 2, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7635, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_297 = Data._skillInfo[7635]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_89_297._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7640, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_298 = arg_89_0._player._opponent:getBattleCards("BCSD")

		if #var_89_298 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_298), 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:hasSkillFast(7646) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_3 == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_299 = Data._skillInfo[7646]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster, Data.MAX_CARD_LEVEL, var_89_0[1]), 2, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7669, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("B", Data.CAR_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7686, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_300 = Data._skillInfo[7686]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByType("H", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_89_0[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7687, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_301 = Data._skillInfo[7687]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("HG", var_89_301._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7705, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_302 = Data._skillInfo[7705]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByStar("HG", var_89_0[1]:getStar())), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7706, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_303 = Data._skillInfo[7706]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInStarCards(arg_89_0._player:getBattleCardsByMaxQuality("G", var_89_303._refCards[1]), var_89_0[1]._info._star)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7722, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_304 = Data._skillInfo[7722]
		local var_89_305 = arg_89_0._player:filterCanChangeToBoardCards(B.mergeTable({
			arg_89_0._player:getBattleCardsByInfoId("H", var_89_304._refCards[1]),
			B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("H", Data.CardType.monster), var_89_304._refCards[2])
		}))

		if #var_89_305 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_305, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(7733, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_306 = Data._skillInfo[7733]
		local var_89_307 = arg_89_0._player:filterCanChangeToHandCards(B.filterMoreThanStarCards(arg_89_0._player:getBattleCardsByCategoryAndNature("P", var_89_306._refCards[1], var_89_0[1]._info._nature), var_89_306._val[1]))

		if #var_89_307 > 0 then
			return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_307, 1, arg_89_1._choiceBase, var_89_1)
		end
	elseif arg_89_2._card:isSkillAtIndex(7742, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_308 = Data._skillInfo[7742]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("HG", var_89_308._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7772, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_309 = Data._skillInfo[7772]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("L", Data.CardType.monster), var_89_309._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkillFast(7774) and arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_3 == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_310 = Data._skillInfo[7774]
		local var_89_311 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), {
			var_89_310._refCards[1],
			var_89_310._refCards[2]
		}))
		local var_89_312 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), {
			var_89_310._refCards[1],
			var_89_310._refCards[3]
		}))
		local var_89_313 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic), {
			var_89_310._refCards[4],
			var_89_310._refCards[5]
		}))

		B.appendTable(var_89_311, var_89_312)
		B.appendTable(var_89_311, var_89_313)

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_0:getCardSprite(var_89_0[1]), B.sortCardsByBoardPos(var_89_311), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7792, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_314 = Data._skillInfo[7792]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7794, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_315 = Data._skillInfo[7794]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterXYZCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_315._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1]), true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7818, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7819, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_316 = Data._skillInfo[7819]
		local var_89_317 = arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByCategory("G", var_89_316._refCards[1]))
		local var_89_318 = {}

		for iter_89_37 = 1, #var_89_317 do
			if var_89_317[iter_89_37] ~= arg_89_2._card and var_89_317[iter_89_37] ~= var_89_0[1] then
				var_89_318[#var_89_318 + 1] = var_89_317[iter_89_37]
			end
		end

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_318, 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(7828, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_319 = Data._skillInfo[7828]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BCSD"), BattleData.PositiveType.shieldMagic, true)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:hasSkills({
		8056
	}) and arg_89_2._card._status == BattleData.CardStatus.show and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_320 = Data._skillInfo[8056]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BCSD"), BattleData.PositiveType.shieldTrap)), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8077, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8082, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_321 = Data._skillInfo[8082]
		local var_89_322 = B.filterNotBindedCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_321._refCards[1]), var_89_0[1]:getAlterMagicInfoId())

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_322), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8083, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_323 = Data._skillInfo[8083]
		local var_89_324 = arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_323._refCards[1]), var_89_0[1]))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_324), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8084, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_325 = Data._skillInfo[8084]
		local var_89_326 = arg_89_0._player:filterCanChangeToHandCards(B.filterNotEqualInfoIdCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_325._refCards[1]), var_89_325._refCards[3]))

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_326), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8094, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil or arg_89_2._card:isSkillAtIndex(8145, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
			B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD"))
		}), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8111, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8123, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_327 = Data._skillInfo[8123]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByCategory("G", var_89_327._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8124, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8126, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_328 = Data._skillInfo[8126]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByInfoId("B", var_89_328._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_2._card:isSkillAtIndex(8131, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_89_1._choiceParam == nil then
		var_89_1 = var_89_0[1]._id

		local var_89_329 = Data._skillInfo[8131]

		return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_329._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
	elseif arg_89_1._choiceParam == nil then
		local var_89_330, var_89_331 = arg_89_2._card:hasSkills({
			3034,
			3035,
			3073,
			3127,
			3247,
			3248,
			3331,
			3344,
			3365,
			3406,
			3428,
			3473,
			3474,
			3480,
			3484,
			3573,
			3594,
			3707,
			3726,
			3735,
			3741,
			3768,
			3774,
			3775,
			3901,
			3912,
			3935,
			3937,
			3943,
			4117,
			4169,
			4170,
			4174,
			4205,
			4213,
			4238,
			4262,
			4263,
			4288,
			4302,
			4367,
			4413,
			4416,
			4430,
			4436,
			4443,
			4445,
			4463,
			4464,
			4490,
			4495,
			4507,
			4519,
			4532,
			4534,
			4559,
			4644,
			4645,
			4653,
			4655,
			4665,
			4674,
			4684,
			4723,
			4747,
			4750,
			4753,
			4771,
			4783,
			4816,
			5049,
			5067,
			5107,
			5127,
			5156,
			5191,
			5193,
			5237,
			5363,
			5382,
			5403,
			5410,
			5443,
			6274,
			6338,
			6436,
			6437,
			6440,
			6451,
			6452,
			6454,
			6465,
			6476,
			6509,
			6510,
			6511,
			6549,
			6579,
			6598,
			6631,
			6673,
			6675,
			6707,
			6810,
			6894,
			6923,
			6934,
			6946,
			7192,
			7235,
			8018,
			8019,
			8046
		})

		if var_89_330 then
			var_89_1 = var_89_0[1]._id

			local var_89_332 = Data._skillInfo[var_89_331[1]._id]

			if var_89_332._id == 3034 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("SD"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3035 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
					arg_89_0._player._opponent:getBattleCards("CSD")
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3073 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3127 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					arg_89_0._player._opponent:getBattleCards("CSD"),
					arg_89_0._player:getBattleCards("CSD")
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3247 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByMaxOriginAtk("B", arg_89_2._card._atk)),
					B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByMaxOriginAtk("B", arg_89_2._card._atk))
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3248 then
				local var_89_333 = arg_89_0._player._opponent:filterCanChangeToBoardCards(arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.monster))

				if #var_89_333 > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_333, 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 3331 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3344 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("BSD"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3365 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_332._val[1]), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3406 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMinStar("H", var_89_0[1]:getStar()), var_89_332._refCards[1]), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3428 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByNature("G", var_89_332._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3473 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("C"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3474 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterDefPostureCards(arg_89_0._player._opponent:getBoardCards(), true)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3480 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterSpiritCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3484 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterDefPostureCards(arg_89_0._player._opponent:getBoardCards(), false)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3538 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3573 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
					arg_89_0._player._opponent:getBattleCards("CSD"),
					B.sortCardsByBoardPos(arg_89_0._player:getBoardCards()),
					arg_89_0._player:getBattleCards("CSD")
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3594 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByCategory("P", var_89_332._refCards[2]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3707 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3726 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3735 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByStar("P", var_89_0[1]:getStar()), var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3741 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
					arg_89_0._player._opponent:getBattleCards("CSD")
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3768 or var_89_332._id == 3775 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNotBindedCards(arg_89_0._player:getBattleCardsByKeyword("B", var_89_332._refCards[2]), arg_89_2._card:getAlterMagicInfoId())), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3774 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_0[1]:getStar()), var_89_332._refCards[2]), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3901 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3912 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3935 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3937 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterEquipMagicCards(arg_89_0._player:getBattleCardsByType("GP", Data.CardType.magic)))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 3943 then
				local var_89_334 = arg_89_0._player._opponent:getBattleCardsByMaxAtk("B", var_89_0[1]._atk)

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_334, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4117 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterAtkEqualCards(arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_0[1]._atk), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4169 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
					B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_89_0[1]))
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4170 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(B.mergeTable({
					B.filterNotSameNameCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.magic), arg_89_2._card),
					arg_89_0._player:getBattleCardsByType("P", Data.CardType.trap)
				}), var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4174 then
				local var_89_335 = arg_89_0._player._opponent:getBoardCards()

				if #var_89_335 > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_335), 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 4205 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4213 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_332._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4238 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByStar("GPH", var_89_0[1]:getStar()), var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4262 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4263 then
				local var_89_336 = arg_89_0._player:filterCanChangeToHandCards(B.filterCeremonyMagicCards(arg_89_0._player:getBattleCards("G")))

				if #var_89_336 > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_336), 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 4288 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4302 then
				local var_89_337 = B.filterCanBindAlterMagicCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_332._refCards[1]), var_89_332._refCards[2]), var_89_0[1])

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_337, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4367 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterSyncCards(arg_89_0._player:getBoardCards(), false)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4413 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByNature("G", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4416 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4430 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterFirstCards(arg_89_0._player._opponent:getBattleCards("P", Data.CARD_MAX_LEVEL, var_89_0[1]), var_89_332._val[1] - 1), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4436 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("B", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4443 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
					B.sortCardsByBoardPos(arg_89_0._player:getBoardCards())
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4445 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					arg_89_0._player._opponent:getBattleCards("CSD"),
					arg_89_0._player:getBattleCards("CSD")
				}), 2, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4463 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterXYZCards(arg_89_0._player:getBattleCardsByKeyword("R", var_89_332._refCards[1]), true), var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4464 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterCanBindMagicCards(B.filterEquipMagicCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_332._refCards[2])), var_89_0[1]), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4490 then
				local var_89_338 = arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("P", {
					var_89_332._refCards[3],
					var_89_332._refCards[4],
					var_89_332._refCards[5],
					var_89_332._refCards[6]
				}))

				if #var_89_338 > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_338, 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 4495 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4507 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("H", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4519 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByCategoryAndNature("G", var_89_332._refCards[3], var_89_332._refCards[2]), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4532 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4534 then
				local var_89_339

				if math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) == 1 then
					var_89_339 = B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_332._refCards[1])
				else
					var_89_339 = arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_332._refCards[1]))
				end

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_339, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4559 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsBy4559Cards(var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4644 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByStar("PH", var_89_332._val[1], Data.CARD_MAX_LEVEL, var_89_0[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4645 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_89_0._player:getBattleCards("R"), true), var_89_0[1]._info._star + 2)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4653 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(B.filterInTypeCards(arg_89_0._player:getBattleCardsByMaxQuality("G", Data.CardQuality.UR), Data.CardType.monster)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4655 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByCategoryAndNature("B", var_89_332._refCards[3], var_89_332._refCards[2], Data.CARD_MAX_LEVEL, var_89_0[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4665 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_332._refCards[2])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4674 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToBoardCards(B.filterInStarCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_332._refCards[2]), var_89_0[1]:getStar()))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4684 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInNatureCards(arg_89_0._player:getBattleCardsByStarGroup("P", {
					7,
					8
				}), var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4723 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterXYZCards(arg_89_0._player:getBoardCards(), false)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4747 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCardsByStar("B", var_89_0[1]:getStar())), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4750 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCardsByMinAtk("B", 2000), BattleData.PositiveType.shieldMagic)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4753 then
				if var_89_0[1]._info._category == var_89_332._refCards[1] then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.mergeTable({
						arg_89_0._player:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_89_2._card),
						B.filterFirstCards(arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player._pileCards), 2)
					})), 1, arg_89_1._choiceBase, var_89_1)
				else
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_332._val[1]), var_89_332._refCards[1]))), 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 4771 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByKeyword("G", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4783 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterUniqueInfoIdCards(arg_89_0._player:getBattleCardsByKeyword("P", var_89_332._refCards[1], Data.CARD_MAX_LEVEL, var_89_0[1])))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 4816 then
				local var_89_340 = arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.monster)

				if #var_89_340 > 0 then
					return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_340), 1, arg_89_1._choiceBase, var_89_1)
				end
			elseif var_89_332._id == 5049 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldExCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldTrap)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5067 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5107 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5127 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.filterNoShieldCards(B.filterEffectCards(B.mergeTable({
					arg_89_0._player:getBattleCards("B", Data.CARD_MAX_LEVEL, var_89_0[1]),
					arg_89_0._player._opponent:getBoardCards()
				})), BattleData.PositiveType.shieldTrap), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5191 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCardsByKeyword("P", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5156 or var_89_332._id == 5193 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBattleCards("BCSD"), BattleData.PositiveType.shieldTrap)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5237 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5363 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterInNatureCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByStar("P", var_89_0[1]:getStar()), var_89_332._refCards[3]), var_89_332._refCards[var_89_0[1]._info._nature == var_89_332._refCards[1] and 2 or 1]))), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5382 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldTrap)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5403 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterXYZCards(arg_89_0._player:getBattleCardsByType("G", Data.CardType.monster), true), true, true), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5410 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 5443 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCardsByType("SD", Data.CardType.magic), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6274 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.mergeTable({
					B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_332._val[1]), var_89_332._refCards[1]),
					B.filterInCategoryCards(arg_89_0._player._opponent:getBattleCardsByMaxStar("G", var_89_332._val[1]), var_89_332._refCards[1])
				})), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6338 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("G", var_89_332._val[1]), var_89_332._refCards[3])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6436 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6437 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_89_0._player._opponent:getBoardCards(), BattleData.PositiveType.shieldMonster)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6440 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6451 or var_89_332._id == 6452 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByNature("H", var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6454 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMaxStar("P", var_89_332._val[1]), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6465 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(B.filterNotEqualInfoIdCards(arg_89_0._player:getBattleCardsByCategory("G", var_89_332._refCards[1]), var_89_332._refCards[2]), var_89_332._refCards[3])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6476 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterSyncCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByStar("R", arg_89_2._card:getStar() + var_89_0[1]:getStar()), var_89_332._refCards[1]), true)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6509 or var_89_332._id == 6510 or var_89_332._id == 6511 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(arg_89_0._player:getBattleCardsByNature("H", var_89_332._refCards[1]), nil, nil, nil, true), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6549 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterDefPostureCards(arg_89_0._player._opponent:getBoardCards(), false)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6579 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBattleCards("BCSD")),
					B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_89_0[1]))
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6598 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:getBattleCardsByCategory("H", var_89_332._refCards[1], Data.CARD_MAX_LEVEL, arg_89_2._card), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6631 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(B.filterInNatureCards(arg_89_0._player._opponent:getBattleCardsByMaxStar("B", var_89_332._val[1]), var_89_332._refCards[3])), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6673 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToHandCards(arg_89_0._player:getBattleCardsByInfoIdGroup("P", var_89_332._refCards)), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6675 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCardsByType("SD", Data.CardType.magic), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6707 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6810 then
				local var_89_341

				if arg_89_1._choiceBase % BattleData.ChoiceId.stage_size_1 == 1 then
					var_89_341 = arg_89_0._player:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_332._refCards[1]), true, true)
				else
					var_89_341 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByTypeGroup("P", {
						Data.CardType.magic,
						Data.CardType.trap
					}), var_89_332._refCards[1]))
				end

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(var_89_341), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6894 then
				local var_89_342 = arg_89_0._player:getBattleCards("H")

				var_89_342[#var_89_342 + 1] = var_89_0[1]

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_342, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6923 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.mergeTable({
					B.sortCardsByBoardPos(arg_89_0._player._opponent:getBoardCards()),
					B.sortCardsByBoardPos(arg_89_0._player:getBoardCards())
				}), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6934 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBattleCards("CSD"), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 6946 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, B.sortCardsByBoardPos(arg_89_0._player:getBattleCards("BCSD")), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 7192 then
				local var_89_343 = arg_89_1._choiceBase and math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0
				local var_89_344 = arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster)
				local var_89_345

				if var_89_343 == 1 then
					var_89_345 = B.sortCardsByBoardPos(B.filterInCategoryCards(var_89_344, var_89_332._refCards[1]))
				else
					var_89_345 = B.sortCardsByBoardPos(arg_89_0._player:filterCanChangeToHandCards(B.filterLessThanStarCards(B.filterInKeywordCards(var_89_344, Data._skillInfo[7198]._refCards[1]), Data._skillInfo[7198]._val[1])))
				end

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_345, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 7235 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player._opponent:getBoardCards(), 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 8018 then
				local var_89_346 = arg_89_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(arg_89_0._player:getBattleCardsByType("P", Data.CardType.monster), var_89_332._refCards[1]))

				var_89_346[#var_89_346 + 1] = var_89_0[1]

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_346, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 8019 then
				local var_89_347 = arg_89_0._player._opponent:getBattleCardsByType("G", Data.CardType.monster)

				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, var_89_347, 1, arg_89_1._choiceBase, var_89_1)
			elseif var_89_332._id == 8046 then
				return arg_89_0:showChoiceGrave(arg_89_2, arg_89_3, arg_89_0._player:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_89_0._player:getBattleCardsByMinStar("G", var_89_332._val[1]), var_89_332._refCards[1])), 1, arg_89_1._choiceBase, var_89_1)
			end
		else
			for iter_89_38 = #var_89_0, 1, -1 do
				var_89_1 = var_89_1 * BattleData.UseCardId.id_group + var_89_0[iter_89_38]._id
			end
		end
	else
		if arg_89_2._card:hasSkills({
			3034,
			3035,
			3073,
			3127,
			3247,
			3248,
			3331,
			3344,
			3365,
			3406,
			3428,
			3473,
			3474,
			3476,
			3480,
			3484,
			3540,
			3573,
			3594,
			3707,
			3726,
			3735,
			3741,
			3768,
			3774,
			3775,
			3901,
			3912,
			3935,
			3937,
			3943,
			4117,
			4169,
			4170,
			4174,
			4205,
			4213,
			4238,
			4262,
			4263,
			4288,
			4302,
			4367,
			4413,
			4416,
			4430,
			4436,
			4443,
			4463,
			4464,
			4490,
			4495,
			4507,
			4519,
			4532,
			4534,
			4559,
			4644,
			4645,
			4653,
			4655,
			4665,
			4674,
			4684,
			4723,
			4747,
			4750,
			4753,
			4771,
			4783,
			4816,
			5049,
			5067,
			5104,
			5107,
			5127,
			5156,
			5191,
			5193,
			5237,
			5363,
			5382,
			5403,
			5410,
			5443,
			6274,
			6338,
			6436,
			6437,
			6440,
			6451,
			6452,
			6454,
			6465,
			6476,
			6509,
			6510,
			6511,
			6549,
			6579,
			6598,
			6631,
			6673,
			6675,
			6707,
			6810,
			6894,
			6923,
			6934,
			6946,
			7192,
			7235,
			8018,
			8019,
			8046
		}) or arg_89_2._card:isSkillAtIndex(3320, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_1._choiceBase == 2 and arg_89_2._card:hasSkills({
			3538
		}) or arg_89_2._card._status == BattleData.CardStatus.board and arg_89_2._card:hasSkills({
			3555
		}) or arg_89_2._card._status == BattleData.CardStatus.board and arg_89_2._card:hasSkills({
			3835
		}) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
			4100
		}) or arg_89_2._card._status == BattleData.CardStatus.grave and arg_89_2._card:hasSkills({
			4157
		}) or arg_89_2._card._status == BattleData.CardStatus.field and arg_89_2._card:hasSkills({
			4411
		}) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
			4431
		}) or arg_89_2._card:isSkillAtIndex(4465, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4798, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4486, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4529, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4572, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:hasSkills({
			4589,
			4594,
			4628
		}) or arg_89_2._card:isSkillAtIndex(4596, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4631, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4633, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4678, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4728, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13576, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4804, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4827, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4840, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4941, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4942, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4944, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4983, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:hasSkillFast(4984) or arg_89_2._card:isSkillAtIndex(4991, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(4993, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5566, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5571, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5572, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5597, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5603, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5605, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5614, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5617, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_1._choiceBase % BattleData.ChoiceId.stage_size_1 == 1 and arg_89_2._card:hasSkills({
			5118
		}) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5232) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5332) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5343) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5445) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5461) or arg_89_2._card:isSkillAtIndex(5440, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5450, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(5463, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5472) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5476) or arg_89_2._card:isSkillAtIndex(5502, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5508) or arg_89_2._card:isSkillAtIndex(5539, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5543) or arg_89_2._card:isSkillAtIndex(5561, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5622) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(5624) or arg_89_2._card:isSkillAtIndex(5646, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(3714, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(3737, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(3950, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(3957, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(3974, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkills({
			6265
		}) or arg_89_2._card._status == BattleData.CardStatus.board and arg_89_2._card:hasSkills({
			6286
		}) or arg_89_2._card:isSkillAtIndex(6365, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6396, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6507, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.grave and arg_89_2._card:hasSkills({
			6616
		}) or arg_89_2._card:isSkillAtIndex(6618, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6619, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6679, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6732, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6735, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6746, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6772, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6795, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6843, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6841, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6848, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6921, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6964, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6978, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(6982, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2111, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2112, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2117, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2135, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2155, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2196, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2203, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2209, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2212, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2279, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2320, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2341, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2359, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2389, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2392, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2400, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2409, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2429, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2430, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2434, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2441, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2449, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2450, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2486, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2487, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2534, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2562, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2578, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2585, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2586, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2587, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2588, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2598, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2599, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2602, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2615, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2739, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2750, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2772, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2774, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2776, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2785, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2787, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2789, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2806, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2811, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2813, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2838, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2867, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2886, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2915, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2928, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2942, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2951, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2959, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2963, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2969, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(2986, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9009, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9034, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9051, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9052, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9072, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9092, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9124, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9168, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9189, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9198, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9204, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9213, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9214, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9218, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9220, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9230, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9258, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9260, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9269, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9282, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9305, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9306, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9314, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9320, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9373, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9375, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9378, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9392, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9382, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9396, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9480, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9481, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9485, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9497, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9518, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9523, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9556, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9563, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9593, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9600, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9614, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9615, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9638, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9712, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9721, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9733, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9739, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9785, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9786, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9815, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9841, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9851, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9867, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9916, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9917, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9918, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9934, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9956, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9965, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9983, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9984, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(9960, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7234, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7244, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7309, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7310, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7328, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7336, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7337, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7338, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7365, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7374, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7380, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7404, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7408, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7429, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7433, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7454, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7534, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7551, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7566, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(7574) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(7578) or arg_89_2._card:isSkillAtIndex(7582, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7635, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7640, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7669, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7686, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7687, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7705, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7706, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7722, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7733, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7742, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7772, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.hand and arg_89_2._card:hasSkillFast(7774) or arg_89_2._card:isSkillAtIndex(7792, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7794, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7818, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7819, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(7828, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card._status == BattleData.CardStatus.show and arg_89_2._card:hasSkillFast(8056) or arg_89_2._card:isSkillAtIndex(8077, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8082, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8083, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8084, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8094, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8145, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8111, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8123, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8124, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8126, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(8131, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13002, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13039, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13054, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13068, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13072, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13155, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13156, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13157, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13165, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13168, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13185, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13218, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13220, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13221, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13296, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13318, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13321, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13330, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13332, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13365, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13367, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13373, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13380, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13398, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13401, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13405, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13408, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13411, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13430, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13432, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13452, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13468, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13538, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13552, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13553, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13572, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13602, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13607, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13618, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13626, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13703, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13710, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13764, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13766, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13767, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13792, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13793, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13847, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13959, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(13995, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14020, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14047, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14163, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14176, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14185, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14337, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14411, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14441, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14474, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14534, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14561, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14570, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14579, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14588, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14598, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) or arg_89_2._card:isSkillAtIndex(14604, arg_89_1._choiceBase / BattleData.ChoiceId.stage_3) then
			var_89_1 = arg_89_1._choiceParam
		end

		for iter_89_39 = #var_89_0, 1, -1 do
			var_89_1 = var_89_1 * BattleData.UseCardId.id_group + var_89_0[iter_89_39]._id
		end
	end

	if arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:isSkillAtIndex(3851, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_89_0:showChoicePos(arg_89_2, arg_89_3, nil, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase, {
			arg_89_2._card
		}, B.filterBoardCards(arg_89_0._player._boardCards, var_89_0), BattlePosDialog.Mode.sync)
	elseif arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:isSkillAtIndex(6753, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_89_0:showChoicePos(arg_89_2, arg_89_3, nil, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase, {
			arg_89_2._card
		}, B.filterBoardCards(arg_89_0._player._boardCards, var_89_0), BattlePosDialog.Mode.xyz)
	elseif arg_89_2._card._status == BattleData.CardStatus.rare and arg_89_2._card:isSkillAtIndex(9298, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_89_0:showChoicePos(arg_89_2, arg_89_3, nil, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase, {
			arg_89_2._card
		}, B.filterBoardCards(arg_89_0._player._boardCards, var_89_0), BattlePosDialog.Mode.link)
	elseif arg_89_2._card:isSkillAtIndex(9280, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_89_0:showChoicePos(arg_89_2, arg_89_3, nil, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase, {
			arg_89_0._player:getCardById(var_89_1)
		}, B.filterBoardCards(arg_89_0._player._boardCards, var_89_0), 9280)
	end

	if #var_89_0 == 1 and arg_89_2._card:hasSkills({
		3084,
		4022,
		4053,
		4088,
		4094,
		4111,
		5037
	}) then
		local var_89_348 = var_89_0[1]
		local var_89_349, var_89_350 = var_89_348:hasChoiceSkill()

		if var_89_349 and B.isSkillChoiceSkill(var_89_350) and not B.skillHasMode(var_89_350, Data.SkillMode.initiative_bcs) and not B.skillHasMode(var_89_350, Data.SkillMode.initiative_grave) and not B.skillHasMode(var_89_350, Data.SkillMode.initiative_hand) and not B.skillHasMode(var_89_350, Data.SkillMode.initiative_rare) and not B.skillHasMode(var_89_350, Data.SkillMode.initiative_leave) then
			if var_89_348:hasSkills({
				3098,
				3119,
				3491,
				3592,
				3651,
				3825,
				3865,
				2383
			}) then
				return arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
					_card = arg_89_2._card,
					_target = arg_89_3 ~= nil and arg_89_3._card or nil,
					_choice = var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase
				})
			else
				return arg_89_0:showChoiceSkill(arg_89_2, arg_89_3, var_89_350, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
			end
		end
	end

	if arg_89_2._card:isSkillAtIndex(7655, math.floor(arg_89_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_89_0:showChoiceSkill(arg_89_2, arg_89_3, skill, var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase)
	end

	arg_89_0:sendEvent(var_0_0.EventType.send_use_card, {
		_card = arg_89_2._card,
		_target = arg_89_3 ~= nil and arg_89_3._card or nil,
		_choice = var_89_1 * BattleData.ChoiceId.stage_2 + arg_89_1._choiceBase
	})
end
