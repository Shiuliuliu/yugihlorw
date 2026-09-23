local var_0_0 = PlayerBattle

function var_0_0.getAllCards(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0 = 1, (Data.MAX_CARD_COUNT_ON_BOARD + 1) * 2 do
		local var_1_2 = iter_1_0 <= Data.MAX_CARD_COUNT_ON_BOARD + 1 and arg_1_0._boardCards[iter_1_0] or arg_1_0._opponent._boardCards[iter_1_0 - Data.MAX_CARD_COUNT_ON_BOARD - 1]

		if var_1_2 ~= nil then
			var_1_0[#var_1_0 + 1] = var_1_2
			var_1_1[var_1_2._id] = var_1_2
		end
	end

	for iter_1_1 = 1, Data.MAX_CARD_COUNT_IN_HAND * 2 do
		local var_1_3 = iter_1_1 <= Data.MAX_CARD_COUNT_IN_HAND and arg_1_0._handCards[iter_1_1] or arg_1_0._opponent._handCards[iter_1_1 - Data.MAX_CARD_COUNT_IN_HAND]

		if var_1_3 ~= nil then
			var_1_0[#var_1_0 + 1] = var_1_3
			var_1_1[var_1_3._id] = var_1_3
		end
	end

	for iter_1_2 = 1, #arg_1_0._cards do
		local var_1_4 = arg_1_0._cards[iter_1_2]

		if var_1_1[var_1_4._id] == nil then
			var_1_0[#var_1_0 + 1] = var_1_4
			var_1_1[var_1_4._id] = var_1_4
		end
	end

	for iter_1_3 = 1, #arg_1_0._opponent._cards do
		local var_1_5 = arg_1_0._opponent._cards[iter_1_3]

		if var_1_1[var_1_5._id] == nil then
			var_1_0[#var_1_0 + 1] = var_1_5
			var_1_1[var_1_5._id] = var_1_5
		end
	end

	for iter_1_4 = 1, 2 do
		local var_1_6 = iter_1_4 == 1 and arg_1_0._fortress or arg_1_0._opponent._fortress

		if var_1_6._type ~= Data.CardType.boss or var_1_6._info._isDeamon == 0 then
			var_1_0[#var_1_0 + 1] = var_1_6
		end
	end

	return var_1_0
end

function var_0_0.getCardById(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._opponent

	if arg_2_1 == arg_2_0._fortress._id then
		return arg_2_0._fortress
	elseif arg_2_1 == var_2_0._fortress._id then
		return var_2_0._fortress
	end

	for iter_2_0 = 1, #arg_2_0._cards do
		if arg_2_0._cards[iter_2_0]._id == arg_2_1 then
			return arg_2_0._cards[iter_2_0]
		end
	end

	for iter_2_1 = 1, #var_2_0._cards do
		if var_2_0._cards[iter_2_1]._id == arg_2_1 then
			return var_2_0._cards[iter_2_1]
		end
	end

	return nil
end

function var_0_0.addCardToCards(arg_3_0, arg_3_1)
	if arg_3_1._id == nil then
		arg_3_0._cardIdBase = arg_3_0._cardIdBase + 1
		arg_3_1._id = arg_3_0._cardIdBase
	end

	arg_3_0._cards[#arg_3_0._cards + 1] = arg_3_1

	local var_3_0 = arg_3_1._owner == nil

	arg_3_1._owner = arg_3_0

	if var_3_0 then
		arg_3_1:baseResetSkills()
		arg_3_1:resetSkills()
	end

	arg_3_1._originOwner = arg_3_1._originOwner or arg_3_0
end

function var_0_0.addCardByStatusPos(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	arg_4_0:addCardToCards(arg_4_1)
	arg_4_0:setCardStatus(arg_4_1, arg_4_2, arg_4_4, arg_4_5, arg_4_6, arg_4_7)

	if arg_4_3 ~= nil then
		arg_4_1._saved = {
			_pos = arg_4_3
		}
	end
end

function var_0_0.removeCardFromCards(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_0._cards do
		if arg_5_1 == arg_5_0._cards[iter_5_0] then
			table.remove(arg_5_0._cards, iter_5_0)

			break
		end
	end

	if arg_5_1._horse ~= nil then
		arg_5_0:removeCardFromCards(arg_5_1._horse)
	end
end

function var_0_0.removeCardToOppo(arg_6_0, arg_6_1)
	arg_6_0:removeCardFromCards(arg_6_1)
	arg_6_0._opponent:addCardToCards(arg_6_1)
end

function var_0_0.getGhostCard(arg_7_0)
	if arg_7_0._ghostCard == nil then
		local var_7_0 = B.createCard(20001, 1)

		arg_7_0:addCardToCards(var_7_0)

		arg_7_0._ghostCard = var_7_0
	end

	return arg_7_0._ghostCard
end

function var_0_0.createRandomMagic(arg_8_0, arg_8_1)
	if arg_8_0._magicPool == nil or #arg_8_0._magicPool == 0 then
		local var_8_0 = {}
		local var_8_1 = 6

		for iter_8_0 = 1, var_8_1 do
			table.insert(var_8_0, 10000 + iter_8_0)
		end

		arg_8_0._magicPool = arg_8_0:randomTable(var_8_0, var_8_1)
	end

	local var_8_2 = arg_8_0._magicPool[1]

	table.remove(arg_8_0._magicPool, 1)

	return B.createCard(var_8_2, arg_8_1)
end

function var_0_0.changeCardInfoId(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	arg_9_0:setCardStatus(arg_9_1, BattleData.CardStatus.leave, arg_9_3, arg_9_4, arg_9_5)

	local var_9_0 = BattleCard.new(arg_9_2, arg_9_1._level, arg_9_0)

	var_9_0:resetOnce()

	var_9_0._status = BattleData.CardStatus.leave
	var_9_0._originCard = arg_9_1

	arg_9_0:addCardByStatusPos(var_9_0, BattleData.CardStatus.board, arg_9_1._pos, arg_9_3, arg_9_4, arg_9_5)
end

function var_0_0.getBattleCards(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_2 or Data.CARD_MAX_LEVEL
	local var_10_1 = {}
	local var_10_2 = false

	for iter_10_0 = 1, #arg_10_1 do
		local var_10_3 = string.sub(arg_10_1, iter_10_0, iter_10_0)

		if var_10_3 == "B" then
			for iter_10_1 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
				local var_10_4 = arg_10_0._boardCards[iter_10_1]

				if B.isAlive(var_10_4) and var_10_4 ~= arg_10_3 and var_10_0 >= var_10_4._level then
					var_10_1[#var_10_1 + 1] = var_10_4
				end
			end
		elseif var_10_3 == "b" then
			for iter_10_2 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
				local var_10_5 = arg_10_0._opponent._boardCards[iter_10_2]

				if B.isAlive(var_10_5) and var_10_5 ~= arg_10_3 and var_10_0 >= var_10_5._level then
					var_10_1[#var_10_1 + 1] = var_10_5
				end
			end
		elseif var_10_3 == "H" then
			for iter_10_3 = 1, Data.MAX_CARD_COUNT_IN_HAND do
				local var_10_6 = arg_10_0._handCards[iter_10_3]

				if var_10_6 ~= nil and var_10_6 ~= arg_10_3 and var_10_0 >= var_10_6._level then
					var_10_1[#var_10_1 + 1] = var_10_6
				end
			end
		elseif var_10_3 == "P" then
			for iter_10_4 = 1, #arg_10_0._pileCards do
				local var_10_7 = arg_10_0._pileCards[iter_10_4]

				if var_10_7 ~= nil and var_10_7 ~= arg_10_3 and var_10_0 >= var_10_7._level then
					var_10_1[#var_10_1 + 1] = var_10_7
				end
			end
		elseif var_10_3 == "G" then
			for iter_10_5 = #arg_10_0._graveCards, 1, -1 do
				local var_10_8 = arg_10_0._graveCards[iter_10_5]

				if var_10_8 ~= nil and var_10_8 ~= arg_10_3 and var_10_0 >= var_10_8._level then
					var_10_1[#var_10_1 + 1] = var_10_8
				end
			end
		elseif var_10_3 == "g" then
			for iter_10_6 = #arg_10_0._opponent._graveCards, 1, -1 do
				local var_10_9 = arg_10_0._opponent._graveCards[iter_10_6]

				if var_10_9 ~= nil and var_10_9 ~= arg_10_3 and var_10_0 >= var_10_9._level then
					var_10_1[#var_10_1 + 1] = var_10_9
				end
			end
		elseif var_10_3 == "C" then
			for iter_10_7 = 1, Data.MAX_CARD_COUNT_ON_COVER do
				local var_10_10 = arg_10_0._coverCards[iter_10_7]

				if B.isAlive(var_10_10) and var_10_10 ~= arg_10_3 and var_10_0 >= var_10_10._level then
					var_10_1[#var_10_1 + 1] = var_10_10
				end
			end
		elseif var_10_3 == "S" then
			for iter_10_8 = 1, Data.MAX_CARD_COUNT_ON_COVER do
				local var_10_11 = arg_10_0._showCards[iter_10_8]

				if B.isAlive(var_10_11) and var_10_11 ~= arg_10_3 and var_10_0 >= var_10_11._level then
					var_10_1[#var_10_1 + 1] = var_10_11
				end
			end
		elseif var_10_3 == "R" then
			for iter_10_9 = 1, #arg_10_0._rareCards do
				local var_10_12 = arg_10_0._rareCards[iter_10_9]

				if var_10_12 ~= nil and var_10_12 ~= arg_10_3 and var_10_0 >= var_10_12._level then
					var_10_1[#var_10_1 + 1] = var_10_12
				end
			end
		elseif var_10_3 == "D" then
			local var_10_13 = arg_10_0._fieldCard

			if var_10_13 ~= nil and var_10_13 ~= arg_10_3 and var_10_0 >= var_10_13._level then
				var_10_1[#var_10_1 + 1] = var_10_13
			end
		elseif var_10_3 == "L" then
			for iter_10_10 = 1, #arg_10_0._leaveCards do
				local var_10_14 = arg_10_0._leaveCards[iter_10_10]

				if var_10_14 ~= arg_10_3 and var_10_0 >= var_10_14._level and not var_10_14._invisibleInLeave and not var_10_14._invisibleInLeaveEx and var_10_14._isTroopCard then
					var_10_1[#var_10_1 + 1] = var_10_14
				end
			end
		elseif var_10_3 == "[" then
			var_10_2 = true
		end
	end

	if var_10_2 then
		var_10_1 = B.filterNotActionedCards(var_10_1)
	end

	return var_10_1
end

function var_0_0.getBoardCards(arg_11_0)
	if arg_11_0._isBoardDirty then
		arg_11_0._isBoardDirty = false
		arg_11_0._curBoardCards = {}

		for iter_11_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
			local var_11_0 = arg_11_0._boardCards[iter_11_0]

			if B.isAlive(var_11_0) then
				arg_11_0._curBoardCards[#arg_11_0._curBoardCards + 1] = var_11_0
			end
		end
	end

	return arg_11_0._curBoardCards
end

function var_0_0.getBattleCardsByInfoId(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = arg_12_0:getBattleCards(arg_12_1, arg_12_3, arg_12_4)
	local var_12_1 = {}

	for iter_12_0 = 1, #var_12_0 do
		local var_12_2 = var_12_0[iter_12_0]

		if var_12_2:isInfoId(arg_12_2) then
			var_12_1[#var_12_1 + 1] = var_12_2
		end
	end

	return var_12_1
end

function var_0_0.getBattleCardsByOriginId(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_0:getBattleCards(arg_13_1, arg_13_3, arg_13_4)
	local var_13_1 = {}

	for iter_13_0 = 1, #var_13_0 do
		local var_13_2 = var_13_0[iter_13_0]

		if var_13_2._info._originId == arg_13_2 then
			var_13_1[#var_13_1 + 1] = var_13_2
		end
	end

	return var_13_1
end

function var_0_0.getBattleCardsBySpecifiedInfoId(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = arg_14_0:getBattleCards(arg_14_1, arg_14_3, arg_14_4)
	local var_14_1 = {}

	for iter_14_0 = 1, #var_14_0 do
		local var_14_2 = var_14_0[iter_14_0]

		if var_14_2._infoId == arg_14_2 then
			var_14_1[#var_14_1 + 1] = var_14_2
		end
	end

	return var_14_1
end

function var_0_0.getBattleCardsByInfoIdGroup(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = arg_15_0:getBattleCards(arg_15_1, arg_15_3, arg_15_4)
	local var_15_1 = {}

	for iter_15_0 = 1, #var_15_0 do
		local var_15_2 = var_15_0[iter_15_0]

		if var_15_2:isInInfoIdGroup(arg_15_2) then
			var_15_1[#var_15_1 + 1] = var_15_2
		end
	end

	return var_15_1
end

function var_0_0.getBattleCardsByType(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_0:getBattleCards(arg_16_1, arg_16_3, arg_16_4)
	local var_16_1 = {}

	for iter_16_0 = 1, #var_16_0 do
		local var_16_2 = var_16_0[iter_16_0]

		if var_16_2._type == arg_16_2 or arg_16_2 == Data.CardType.monster and var_16_2:isMonsterRare() then
			var_16_1[#var_16_1 + 1] = var_16_2
		end
	end

	return var_16_1
end

function var_0_0.getBattleCardsByTypeGroup(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_0:getBattleCards(arg_17_1, arg_17_3, arg_17_4)
	local var_17_1 = {}

	for iter_17_0 = 1, #var_17_0 do
		local var_17_2 = var_17_0[iter_17_0]

		for iter_17_1 = 1, #arg_17_2 do
			if var_17_2._type == arg_17_2[iter_17_1] then
				var_17_1[#var_17_1 + 1] = var_17_2

				break
			end
		end
	end

	return var_17_1
end

function var_0_0.getBattleCardsByCategory(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = arg_18_0:getBattleCards(arg_18_1, arg_18_3, arg_18_4)
	local var_18_1 = {}

	for iter_18_0 = 1, #var_18_0 do
		local var_18_2 = var_18_0[iter_18_0]

		if var_18_2._info._category == arg_18_2 then
			var_18_1[#var_18_1 + 1] = var_18_2
		end
	end

	return var_18_1
end

function var_0_0.getBattleCardsByCategoryGroup(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = arg_19_0:getBattleCards(arg_19_1, arg_19_3, arg_19_4)
	local var_19_1 = {}

	for iter_19_0 = 1, #var_19_0 do
		local var_19_2 = var_19_0[iter_19_0]

		if var_19_2:isCategoryGroup(arg_19_2) then
			var_19_1[#var_19_1 + 1] = var_19_2
		end
	end

	return var_19_1
end

function var_0_0.getBattleCardsByKeyword(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = arg_20_0:getBattleCards(arg_20_1, arg_20_3, arg_20_4)
	local var_20_1 = {}

	for iter_20_0 = 1, #var_20_0 do
		local var_20_2 = var_20_0[iter_20_0]

		if var_20_2:isKeyword(arg_20_2) then
			var_20_1[#var_20_1 + 1] = var_20_2
		end
	end

	return var_20_1
end

function var_0_0.getBattleCardsByKeywordGroup(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0 = arg_21_0:getBattleCards(arg_21_1, arg_21_3, arg_21_4)
	local var_21_1 = {}

	for iter_21_0 = 1, #var_21_0 do
		local var_21_2 = var_21_0[iter_21_0]

		for iter_21_1 = 1, #arg_21_2 do
			if var_21_2:isKeyword(arg_21_2[iter_21_1]) then
				var_21_1[#var_21_1 + 1] = var_21_2

				break
			end
		end
	end

	return var_21_1
end

function var_0_0.getBattleCardsByNature(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = arg_22_0:getBattleCards(arg_22_1, arg_22_3, arg_22_4)
	local var_22_1 = {}

	for iter_22_0 = 1, #var_22_0 do
		local var_22_2 = var_22_0[iter_22_0]

		if var_22_2:isNature(arg_22_2) then
			var_22_1[#var_22_1 + 1] = var_22_2
		end
	end

	return var_22_1
end

function var_0_0.getBattleCardsByNatureGroup(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_0:getBattleCards(arg_23_1, arg_23_3, arg_23_4)
	local var_23_1 = {}

	for iter_23_0 = 1, #var_23_0 do
		local var_23_2 = var_23_0[iter_23_0]

		for iter_23_1 = 1, #arg_23_2 do
			if var_23_2:isNature(arg_23_2[iter_23_1]) then
				var_23_1[#var_23_1 + 1] = var_23_2

				break
			end
		end
	end

	return var_23_1
end

function var_0_0.getBattleCardsByStar(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = arg_24_0:getBattleCards(arg_24_1, arg_24_3, arg_24_4)
	local var_24_1 = {}

	for iter_24_0 = 1, #var_24_0 do
		local var_24_2 = var_24_0[iter_24_0]

		if var_24_2:getStar() == arg_24_2 then
			var_24_1[#var_24_1 + 1] = var_24_2
		end
	end

	return var_24_1
end

function var_0_0.getBattleCardsByStarGroup(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = arg_25_0:getBattleCards(arg_25_1, arg_25_3, arg_25_4)
	local var_25_1 = {}

	for iter_25_0 = 1, #var_25_0 do
		local var_25_2 = var_25_0[iter_25_0]
		local var_25_3 = var_25_2:getStar()

		for iter_25_1 = 1, #arg_25_2 do
			if var_25_3 == arg_25_2[iter_25_1] then
				var_25_1[#var_25_1 + 1] = var_25_2

				break
			end
		end
	end

	return var_25_1
end

function var_0_0.getBattleCardsByMaxStar(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = arg_26_0:getBattleCards(arg_26_1, arg_26_3, arg_26_4)
	local var_26_1 = {}

	for iter_26_0 = 1, #var_26_0 do
		local var_26_2 = var_26_0[iter_26_0]
		local var_26_3 = var_26_2:getStar()

		if var_26_3 > 0 and var_26_3 <= arg_26_2 then
			var_26_1[#var_26_1 + 1] = var_26_2
		end
	end

	return var_26_1
end

function var_0_0.getBattleCardsByMinStar(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = arg_27_0:getBattleCards(arg_27_1, arg_27_3, arg_27_4)
	local var_27_1 = {}

	for iter_27_0 = 1, #var_27_0 do
		local var_27_2 = var_27_0[iter_27_0]
		local var_27_3 = var_27_2:getStar()

		if var_27_3 > 0 and arg_27_2 <= var_27_3 and var_27_3 ~= Data.XYZ_STAR then
			var_27_1[#var_27_1 + 1] = var_27_2
		end
	end

	return var_27_1
end

function var_0_0.getBattleCardsByStarOrLevel(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = arg_28_0:getBattleCards(arg_28_1, arg_28_3, arg_28_4)
	local var_28_1 = {}

	for iter_28_0 = 1, #var_28_0 do
		local var_28_2 = var_28_0[iter_28_0]

		if not var_28_2:isLink() and arg_28_2 == var_28_2:getStarOrLevel() then
			var_28_1[#var_28_1 + 1] = var_28_2
		end
	end

	return var_28_1
end

function var_0_0.getBattleCardsByMinStarOrLevel(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = arg_29_0:getBattleCards(arg_29_1, arg_29_3, arg_29_4)
	local var_29_1 = {}

	for iter_29_0 = 1, #var_29_0 do
		local var_29_2 = var_29_0[iter_29_0]
		local var_29_3 = not var_29_2:isXYZ() and var_29_2:getStar() or var_29_2._info._star

		if var_29_3 > 0 and arg_29_2 <= var_29_3 and var_29_3 ~= Data.XYZ_STAR then
			var_29_1[#var_29_1 + 1] = var_29_2
		end
	end

	return var_29_1
end

function var_0_0.getBattleCardsByMaxStarOrLevel(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	local var_30_0 = arg_30_0:getBattleCards(arg_30_1, arg_30_3, arg_30_4)
	local var_30_1 = {}

	for iter_30_0 = 1, #var_30_0 do
		local var_30_2 = var_30_0[iter_30_0]

		if not var_30_2:isLink() and arg_30_2 >= var_30_2:getStarOrLevel() then
			var_30_1[#var_30_1 + 1] = var_30_2
		end
	end

	return var_30_1
end

function var_0_0.getBattleCardsBetweenStar(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	local var_31_0 = arg_31_0:getBattleCards(arg_31_1, arg_31_4, arg_31_5)
	local var_31_1 = {}

	for iter_31_0 = 1, #var_31_0 do
		local var_31_2 = var_31_0[iter_31_0]
		local var_31_3 = var_31_2:getStar()

		if var_31_3 > 0 and arg_31_2 <= var_31_3 and var_31_3 <= arg_31_3 then
			var_31_1[#var_31_1 + 1] = var_31_2
		end
	end

	return var_31_1
end

function var_0_0.getBattleCardsByStarOrLevelGroup(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	local var_32_0 = arg_32_0:getBattleCards(arg_32_1, arg_32_3, arg_32_4)
	local var_32_1 = {}

	for iter_32_0 = 1, #var_32_0 do
		local var_32_2 = var_32_0[iter_32_0]
		local var_32_3 = not var_32_2:isXYZ() and var_32_2:getStar() or var_32_2._info._star

		for iter_32_1 = 1, #arg_32_2 do
			if var_32_3 == arg_32_2[iter_32_1] then
				var_32_1[#var_32_1 + 1] = var_32_2

				break
			end
		end
	end

	return var_32_1
end

function var_0_0.getBattleCardsByMaxXYZStar(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = B.filterXYZCards(arg_33_0:getBattleCards(arg_33_1, arg_33_3, arg_33_4), true)
	local var_33_1 = {}

	for iter_33_0 = 1, #var_33_0 do
		local var_33_2 = var_33_0[iter_33_0]
		local var_33_3 = var_33_2._info._star

		if var_33_3 > 0 and var_33_3 <= arg_33_2 then
			var_33_1[#var_33_1 + 1] = var_33_2
		end
	end

	return var_33_1
end

function var_0_0.getBattleCardsByMaxQuality(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = arg_34_0:getBattleCards(arg_34_1, arg_34_3, arg_34_4)
	local var_34_1 = {}

	for iter_34_0 = 1, #var_34_0 do
		local var_34_2 = var_34_0[iter_34_0]

		if var_34_2._info._quality ~= nil and arg_34_2 >= var_34_2._info._quality then
			var_34_1[#var_34_1 + 1] = var_34_2
		end
	end

	return var_34_1
end

function var_0_0.getBattleCardsByAtk(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0 = arg_35_0:getBattleCards(arg_35_1, arg_35_3, arg_35_4)
	local var_35_1 = {}

	for iter_35_0 = 1, #var_35_0 do
		local var_35_2 = var_35_0[iter_35_0]

		if var_35_2._atk == arg_35_2 then
			var_35_1[#var_35_1 + 1] = var_35_2
		end
	end

	return var_35_1
end

function var_0_0.getBattleCardsByMaxAtk(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = arg_36_0:getBattleCards(arg_36_1, arg_36_3, arg_36_4)
	local var_36_1 = {}

	for iter_36_0 = 1, #var_36_0 do
		local var_36_2 = var_36_0[iter_36_0]

		if var_36_2._atk ~= nil and arg_36_2 >= var_36_2._atk then
			var_36_1[#var_36_1 + 1] = var_36_2
		end
	end

	return var_36_1
end

function var_0_0.getBattleCardsByMinAtk(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0 = arg_37_0:getBattleCards(arg_37_1, arg_37_3, arg_37_4)
	local var_37_1 = {}

	for iter_37_0 = 1, #var_37_0 do
		local var_37_2 = var_37_0[iter_37_0]

		if var_37_2._atk ~= nil and arg_37_2 <= var_37_2._atk then
			var_37_1[#var_37_1 + 1] = var_37_2
		end
	end

	return var_37_1
end

function var_0_0.getBattleCardsByHp(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	local var_38_0 = B.filterLinkCards(arg_38_0:getBattleCards(arg_38_1, arg_38_3, arg_38_4), false)
	local var_38_1 = {}

	for iter_38_0 = 1, #var_38_0 do
		local var_38_2 = var_38_0[iter_38_0]

		if var_38_2._hp == arg_38_2 then
			var_38_1[#var_38_1 + 1] = var_38_2
		end
	end

	return var_38_1
end

function var_0_0.getBattleCardsByMaxHp(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = B.filterLinkCards(arg_39_0:getBattleCards(arg_39_1, arg_39_3, arg_39_4), false)
	local var_39_1 = {}

	for iter_39_0 = 1, #var_39_0 do
		local var_39_2 = var_39_0[iter_39_0]

		if var_39_2._hp ~= nil and arg_39_2 >= var_39_2._hp then
			var_39_1[#var_39_1 + 1] = var_39_2
		end
	end

	return var_39_1
end

function var_0_0.getBattleCardsByMinHp(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	local var_40_0 = B.filterLinkCards(arg_40_0:getBattleCards(arg_40_1, arg_40_3, arg_40_4), false)
	local var_40_1 = {}

	for iter_40_0 = 1, #var_40_0 do
		local var_40_2 = var_40_0[iter_40_0]

		if var_40_2._hp ~= nil and arg_40_2 <= var_40_2._hp then
			var_40_1[#var_40_1 + 1] = var_40_2
		end
	end

	return var_40_1
end

function var_0_0.getBattleCardsByAtkDef(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	local var_41_0 = B.filterLinkCards(arg_41_0:getBattleCards(arg_41_1, arg_41_4, arg_41_5), false)
	local var_41_1 = {}

	for iter_41_0 = 1, #var_41_0 do
		local var_41_2 = var_41_0[iter_41_0]

		if var_41_2._atk == arg_41_2 and var_41_2._hp == arg_41_3 then
			var_41_1[#var_41_1 + 1] = var_41_2
		end
	end

	return var_41_1
end

function var_0_0.getBattleCardsByMinAtkDef(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	local var_42_0 = B.filterLinkCards(arg_42_0:getBattleCards(arg_42_1, arg_42_4, arg_42_5), false)
	local var_42_1 = {}

	for iter_42_0 = 1, #var_42_0 do
		local var_42_2 = var_42_0[iter_42_0]

		if arg_42_2 <= var_42_2._atk and var_42_2._hp == arg_42_3 then
			var_42_1[#var_42_1 + 1] = var_42_2
		end
	end

	return var_42_1
end

function var_0_0.getBattleCardsByMinAtkMaxDef(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	local var_43_0 = B.filterLinkCards(arg_43_0:getBattleCards(arg_43_1, arg_43_4, arg_43_5), false)
	local var_43_1 = {}

	for iter_43_0 = 1, #var_43_0 do
		local var_43_2 = var_43_0[iter_43_0]

		if var_43_2._atk ~= nil and var_43_2._hp ~= nil and arg_43_2 <= var_43_2._atk and arg_43_3 >= var_43_2._hp then
			var_43_1[#var_43_1 + 1] = var_43_2
		end
	end

	return var_43_1
end

function var_0_0.getBattleCardsByMaxOriginAtk(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	local var_44_0 = arg_44_0:getBattleCards(arg_44_1, arg_44_3, arg_44_4)
	local var_44_1 = {}

	for iter_44_0 = 1, #var_44_0 do
		local var_44_2 = var_44_0[iter_44_0]

		if not var_44_2:isAtkHide() and var_44_2._maxAtk ~= nil and arg_44_2 >= var_44_2._maxAtk then
			var_44_1[#var_44_1 + 1] = var_44_2
		end
	end

	return var_44_1
end

function var_0_0.getBattleCardsByMaxOriginDef(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	local var_45_0 = B.filterLinkCards(arg_45_0:getBattleCards(arg_45_1, arg_45_3, arg_45_4), false)
	local var_45_1 = {}

	for iter_45_0 = 1, #var_45_0 do
		local var_45_2 = var_45_0[iter_45_0]

		if not var_45_2:isDefHide() and var_45_2._maxHp ~= nil and arg_45_2 >= var_45_2._maxHp then
			var_45_1[#var_45_1 + 1] = var_45_2
		end
	end

	return var_45_1
end

function var_0_0.getBattleCardsByMinOriginAtk(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	local var_46_0 = arg_46_0:getBattleCards(arg_46_1, arg_46_3, arg_46_4)
	local var_46_1 = {}

	for iter_46_0 = 1, #var_46_0 do
		local var_46_2 = var_46_0[iter_46_0]

		if not var_46_2:isAtkHide() and var_46_2._maxAtk ~= nil and arg_46_2 <= var_46_2._maxAtk then
			var_46_1[#var_46_1 + 1] = var_46_2
		end
	end

	return var_46_1
end

function var_0_0.getBattleCardsByMinOriginDef(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	local var_47_0 = B.filterLinkCards(arg_47_0:getBattleCards(arg_47_1, arg_47_3, arg_47_4), false)
	local var_47_1 = {}

	for iter_47_0 = 1, #var_47_0 do
		local var_47_2 = var_47_0[iter_47_0]

		if not var_47_2:isDefHide() and var_47_2._maxHp ~= nil and arg_47_2 <= var_47_2._maxHp then
			var_47_1[#var_47_1 + 1] = var_47_2
		end
	end

	return var_47_1
end

function var_0_0.getBattleCardsByOriginAtkOrDef(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0 = B.filterLinkCards(arg_48_0:getBattleCards(arg_48_1, arg_48_3, arg_48_4), false)
	local var_48_1 = {}

	for iter_48_0 = 1, #var_48_0 do
		local var_48_2 = var_48_0[iter_48_0]

		if not var_48_2:isAtkHide() and var_48_2._maxAtk == arg_48_2 or not var_48_2:isDefHide() and var_48_2._maxHp == arg_48_2 then
			var_48_1[#var_48_1 + 1] = var_48_2
		end
	end

	return var_48_1
end

function var_0_0.getBattleCardsByCategoryAndNature(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4, arg_49_5)
	local var_49_0 = arg_49_0:getBattleCards(arg_49_1, arg_49_4, arg_49_5)
	local var_49_1 = {}

	for iter_49_0 = 1, #var_49_0 do
		local var_49_2 = var_49_0[iter_49_0]

		if var_49_2._info._category == arg_49_2 and var_49_2:isNature(arg_49_3) then
			var_49_1[#var_49_1 + 1] = var_49_2
		end
	end

	return var_49_1
end

function var_0_0.getBattleCardsByCanMergeFrom(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = arg_50_0:getBattleCards(arg_50_1, arg_50_2, arg_50_3)
	local var_50_1 = {}

	for iter_50_0 = 1, #var_50_0 do
		local var_50_2 = var_50_0[iter_50_0]

		if var_50_2:canMergeFrom() then
			var_50_1[#var_50_1 + 1] = var_50_2
		end
	end

	return var_50_1
end

function var_0_0.getBattleCardsByBuff(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4, arg_51_5)
	local var_51_0 = arg_51_0:getBattleCards(arg_51_1, arg_51_4, arg_51_5)
	local var_51_1 = {}

	for iter_51_0 = 1, #var_51_0 do
		local var_51_2 = var_51_0[iter_51_0]

		if var_51_2:hasBuff(arg_51_2, arg_51_3) then
			var_51_1[#var_51_1 + 1] = var_51_2
		end
	end

	return var_51_1
end

function var_0_0.getBattleCardsByNoBuff(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	local var_52_0 = arg_52_0:getBattleCards(arg_52_1, arg_52_4, arg_52_5)
	local var_52_1 = {}

	for iter_52_0 = 1, #var_52_0 do
		local var_52_2 = var_52_0[iter_52_0]

		if not var_52_2:hasBuff(arg_52_2, arg_52_3) then
			var_52_1[#var_52_1 + 1] = var_52_2
		end
	end

	return var_52_1
end

function var_0_0.getBattleCardsByMinBuffValue(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5, arg_53_6)
	local var_53_0 = arg_53_0:getBattleCards(arg_53_1, arg_53_5, arg_53_6)
	local var_53_1 = {}

	for iter_53_0 = 1, #var_53_0 do
		local var_53_2 = var_53_0[iter_53_0]

		if arg_53_4 <= var_53_2:getBuffValue(arg_53_2, arg_53_3) then
			var_53_1[#var_53_1 + 1] = var_53_2
		end
	end

	return var_53_1
end

function var_0_0.getBattleCardsByBuffWithValue(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5)
	local var_54_0 = arg_54_0:getBattleCards(arg_54_1, arg_54_4, arg_54_5)
	local var_54_1 = {}
	local var_54_2 = 0

	for iter_54_0 = 1, #var_54_0 do
		local var_54_3 = var_54_0[iter_54_0]

		if var_54_3:hasBuff(arg_54_2, arg_54_3) then
			var_54_1[#var_54_1 + 1] = var_54_3
			var_54_2 = var_54_2 + var_54_3:getBuffValue(arg_54_2, arg_54_3)
		end
	end

	return var_54_1, var_54_2
end

function var_0_0.getBattleCardsByJoinComponent(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	local var_55_0 = arg_55_0:getBattleCards(arg_55_1, arg_55_3, arg_55_4)
	local var_55_1 = {}

	for iter_55_0 = 1, #var_55_0 do
		local var_55_2 = var_55_0[iter_55_0]

		if var_55_2:hasJoinComponent(arg_55_2) then
			var_55_1[#var_55_1 + 1] = var_55_2
		end
	end

	return var_55_1
end

function var_0_0.getBattleCardsBySkills(arg_56_0, arg_56_1, arg_56_2, arg_56_3, arg_56_4)
	local var_56_0 = arg_56_0:getBattleCards(arg_56_1, arg_56_3, arg_56_4)
	local var_56_1 = {}
	local var_56_2 = {}

	for iter_56_0 = 1, #var_56_0 do
		local var_56_3 = var_56_0[iter_56_0]
		local var_56_4, var_56_5 = var_56_3:hasSkills(arg_56_2)

		if var_56_4 then
			var_56_1[#var_56_1 + 1] = var_56_3

			for iter_56_1 = 1, #var_56_5 do
				var_56_2[#var_56_2 + 1] = var_56_5[iter_56_1]
			end
		end
	end

	return var_56_1, var_56_2
end

function var_0_0.getBattleCardsBySkillFast(arg_57_0, arg_57_1, arg_57_2, arg_57_3, arg_57_4)
	local var_57_0 = arg_57_0:getBattleCards(arg_57_1, arg_57_3, arg_57_4)
	local var_57_1 = {}

	for iter_57_0 = 1, #var_57_0 do
		local var_57_2 = var_57_0[iter_57_0]

		if var_57_2:hasSkillFast(arg_57_2) then
			var_57_1[#var_57_1 + 1] = var_57_2
		end
	end

	return var_57_1
end

function var_0_0.hasBattleCardsBySkillFast(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	local var_58_0 = arg_58_0:getBattleCards(arg_58_1, arg_58_3, arg_58_4)

	for iter_58_0 = 1, #var_58_0 do
		if var_58_0[iter_58_0]:hasSkillFast(arg_58_2) then
			return true
		end
	end

	return false
end

function var_0_0.getBattleCardsByCanCastMonsterSkillFast(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	local var_59_0 = arg_59_0:getBattleCards(arg_59_1, arg_59_3, arg_59_4)
	local var_59_1 = {}

	for iter_59_0 = 1, #var_59_0 do
		local var_59_2 = var_59_0[iter_59_0]

		if var_59_2:hasCanCastMonsterSkillFast(arg_59_2) then
			var_59_1[#var_59_1 + 1] = var_59_2
		end
	end

	return var_59_1
end

function var_0_0.getBattleCardsByCanCastMagicSkillFast(arg_60_0, arg_60_1, arg_60_2, arg_60_3, arg_60_4)
	local var_60_0 = arg_60_0:getBattleCards(arg_60_1, arg_60_3, arg_60_4)
	local var_60_1 = {}

	for iter_60_0 = 1, #var_60_0 do
		local var_60_2 = var_60_0[iter_60_0]

		if var_60_2:hasCanCastMagicSkillFast(arg_60_2) then
			var_60_1[#var_60_1 + 1] = var_60_2
		end
	end

	return var_60_1
end

function var_0_0.getBattleCardsByCanCastTrapSkillFast(arg_61_0, arg_61_1, arg_61_2, arg_61_3, arg_61_4)
	local var_61_0 = arg_61_0:getBattleCards(arg_61_1, arg_61_3, arg_61_4)
	local var_61_1 = {}

	for iter_61_0 = 1, #var_61_0 do
		local var_61_2 = var_61_0[iter_61_0]

		if var_61_2:hasCanCastTrapSkillFast(arg_61_2) then
			var_61_1[#var_61_1 + 1] = var_61_2
		end
	end

	return var_61_1
end

function var_0_0.hasBattleCardsByCanCastMonsterSkillFast(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4)
	local var_62_0 = arg_62_0:getBattleCards(arg_62_1, arg_62_3, arg_62_4)

	for iter_62_0 = 1, #var_62_0 do
		if var_62_0[iter_62_0]:hasCanCastMonsterSkillFast(arg_62_2) then
			return true
		end
	end

	return false
end

function var_0_0.hasBattleCardsByCanCastMagicSkillFast(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
	local var_63_0 = arg_63_0:getBattleCards(arg_63_1, arg_63_3, arg_63_4)

	for iter_63_0 = 1, #var_63_0 do
		if var_63_0[iter_63_0]:hasCanCastMagicSkillFast(arg_63_2) then
			return true
		end
	end

	return false
end

function var_0_0.hasBattleCardsByCanCastTrapSkillFast(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4)
	local var_64_0 = arg_64_0:getBattleCards(arg_64_1, arg_64_3, arg_64_4)

	for iter_64_0 = 1, #var_64_0 do
		if var_64_0[iter_64_0]:hasCanCastTrapSkillFast(arg_64_2) then
			return true
		end
	end

	return false
end

function var_0_0.getBattleCardsBySkillMode(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4)
	local var_65_0 = arg_65_0:getBattleCards(arg_65_1, arg_65_3, arg_65_4)
	local var_65_1 = {}
	local var_65_2 = {}

	for iter_65_0 = 1, #var_65_0 do
		local var_65_3 = var_65_0[iter_65_0]
		local var_65_4, var_65_5 = var_65_3:hasSkillInMode(arg_65_2)

		if var_65_4 then
			var_65_1[#var_65_1 + 1] = var_65_3

			for iter_65_1 = 1, #var_65_5 do
				var_65_2[#var_65_2 + 1] = var_65_5[iter_65_1]
			end
		end
	end

	return var_65_1, var_65_2
end

function var_0_0.getBattleCardsBySkillModes(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	local var_66_0 = arg_66_0:getBattleCards(arg_66_1, arg_66_3, arg_66_4)
	local var_66_1 = {}
	local var_66_2 = {}

	for iter_66_0 = 1, #var_66_0 do
		local var_66_3 = var_66_0[iter_66_0]
		local var_66_4, var_66_5 = var_66_3:hasSkillInModes(arg_66_2)

		if var_66_4 then
			var_66_1[#var_66_1 + 1] = var_66_3

			for iter_66_1 = 1, #var_66_5 do
				var_66_2[#var_66_2 + 1] = var_66_5[iter_66_1]
			end
		end
	end

	return var_66_1, var_66_2
end

function var_0_0.getBattleCardsByCanCastInitiativeSkill(arg_67_0, arg_67_1, arg_67_2, arg_67_3, arg_67_4)
	local var_67_0 = {}
	local var_67_1 = {}
	local var_67_2 = arg_67_0:getBattleCards(arg_67_1, arg_67_2, arg_67_3)

	for iter_67_0 = 1, #var_67_2 do
		local var_67_3 = var_67_2[iter_67_0]
		local var_67_4, var_67_5 = var_67_3:canCastInitiativeSkill()

		if var_67_4 then
			var_67_0[#var_67_0 + 1] = var_67_3

			if arg_67_4 then
				break
			end

			for iter_67_1 = 1, #var_67_5 do
				var_67_1[#var_67_1 + 1] = var_67_5[iter_67_1]
			end
		end
	end

	return var_67_0, var_67_1
end

function var_0_0.getBattleCardsByCanAddMagicMark(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = Data._skillInfo[5137]
	local var_68_1 = arg_68_0:getBattleCardsByInfoIdGroup(arg_68_1, var_68_0._refCards, Data.CARD_MAX_LEVEL, arg_68_3)
	local var_68_2 = arg_68_0:getBattleCardsBySkillFast("B", 6169, Data.CARD_MAX_LEVEL, arg_68_3)

	return B.mergeTable({
		var_68_1,
		var_68_2
	})
end

function var_0_0.getBattleCardsByXYZMagicTrapCardMark(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	local var_69_0 = arg_69_0:getBattleCards(arg_69_1, arg_69_2, arg_69_3)
	local var_69_1 = {}

	for iter_69_0 = 1, #var_69_0 do
		local var_69_2 = var_69_0[iter_69_0]

		if var_69_2:hasBuff(true, BattleData.PositiveType.xyzMark) or var_69_2:hasBuff(true, BattleData.PositiveType.magicCardMark) or var_69_2:hasBuff(true, BattleData.PositiveType.trapCardMark) then
			var_69_1[#var_69_1 + 1] = var_69_2
		end
	end

	return var_69_1
end

function var_0_0.getBattleCardsByInvisibleLeave(arg_70_0)
	local var_70_0 = {}

	for iter_70_0 = 1, #arg_70_0._leaveCards do
		local var_70_1 = arg_70_0._leaveCards[iter_70_0]

		if var_70_1._invisibleInLeave or var_70_1._invisibleInLeaveEx then
			var_70_0[#var_70_0 + 1] = var_70_1
		end
	end

	return var_70_0
end

function var_0_0.getBattleCardsBy4509(arg_71_0, arg_71_1)
	local var_71_0 = {}
	local var_71_1 = B.filterInKeywordCards(arg_71_0:getBattleCardsByType("G", Data.CardType.monster), 50)
	local var_71_2, var_71_3 = arg_71_1:getLVInfo()

	if var_71_2 ~= nil then
		for iter_71_0 = 1, #var_71_1 do
			local var_71_4, var_71_5 = var_71_1[iter_71_0]:getLVInfo()

			if var_71_2 == var_71_4 and var_71_5 < var_71_3 then
				var_71_0[#var_71_0 + 1] = var_71_1[iter_71_0]
			end
		end
	end

	return var_71_0
end

function var_0_0.getBattleCardsBy4588(arg_72_0, arg_72_1)
	local var_72_0 = {}
	local var_72_1 = B.filterSyncCards(arg_72_0:getBoardCards(), true)

	for iter_72_0 = 1, #var_72_1 do
		local var_72_2 = var_72_1[iter_72_0]:getStar()

		if var_72_2 ~= Data.XYZ_STAR and #arg_72_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_72_0:getBattleCardsByStar("R", var_72_2), true)) > 0 then
			var_72_0[#var_72_0 + 1] = var_72_1[iter_72_0]
		end
	end

	return var_72_0
end

function var_0_0.getBattleCardsBy4620(arg_73_0)
	local var_73_0 = Data._skillInfo[4620]
	local var_73_1 = {}
	local var_73_2 = arg_73_0:getBattleCardsByInfoIdGroup("BCSDH", var_73_0._refCards)

	for iter_73_0 = 1, #var_73_2 do
		local var_73_3 = var_73_2[iter_73_0]:get4620InfoId()

		if #arg_73_0:filterCanChangeToBoardCards(arg_73_0:getBattleCardsByInfoId("R", var_73_3), true, true) > 0 then
			var_73_1[#var_73_1 + 1] = var_73_2[iter_73_0]
		end
	end

	return var_73_1
end

function var_0_0.getBattleCardsBy4633(arg_74_0)
	local var_74_0 = Data._skillInfo[4633]
	local var_74_1 = {}
	local var_74_2 = B.filterInKeywordCards(arg_74_0:getBattleCardsByType("G", Data.CardType.monster), var_74_0._refCards[1])

	for iter_74_0 = 1, #var_74_2 do
		local var_74_3 = var_74_2[iter_74_0]

		if #arg_74_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_74_0:getBattleCardsByKeyword("G", var_74_0._refCards[1], Data.CARD_MAX_LEVEL, var_74_3), true)) > 0 then
			var_74_1[#var_74_1 + 1] = var_74_3
		end
	end

	return var_74_1
end

function var_0_0.getBattleCardsBy4644(arg_75_0)
	local var_75_0 = Data._skillInfo[4644]
	local var_75_1 = {}
	local var_75_2 = arg_75_0:getBattleCardsByType("H", Data.CardType.monster)

	if #var_75_2 == 0 then
		return var_75_1
	end

	for iter_75_0 = 1, #var_75_2 do
		local var_75_3 = var_75_2[iter_75_0]

		if #arg_75_0:filterCanChangeToBoardCards(arg_75_0:getBattleCardsByStar("PH", var_75_0._val[1], Data.CARD_MAX_LEVEL, var_75_3)) > 0 then
			var_75_1[#var_75_1 + 1] = var_75_3
		end
	end

	return var_75_1
end

function var_0_0.getBattleCardsBy4645(arg_76_0)
	local var_76_0 = Data._skillInfo[4645]
	local var_76_1 = {}
	local var_76_2 = B.filterXYZCards(arg_76_0:getBattleCardsByKeyword("G", var_76_0._refCards[1]), true)

	if #var_76_2 == 0 then
		return var_76_1
	end

	for iter_76_0 = 1, #var_76_2 do
		local var_76_3 = var_76_2[iter_76_0]

		if #arg_76_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_76_0:getBattleCards("R"), true), var_76_3._info._star + 2)) > 0 then
			var_76_1[#var_76_1 + 1] = var_76_3
		end
	end

	return var_76_1
end

function var_0_0.getBattleCardsBy4655(arg_77_0)
	local var_77_0 = Data._skillInfo[4655]
	local var_77_1 = {}
	local var_77_2 = B.filterCeremonyMonsterCards(arg_77_0:getBattleCardsByKeyword("HB", var_77_0._refCards[1]))

	if #var_77_2 == 0 then
		return var_77_1
	end

	for iter_77_0 = 1, #var_77_2 do
		local var_77_3 = var_77_2[iter_77_0]

		if #arg_77_0:getBattleCardsByCategoryAndNature("B", var_77_0._refCards[3], var_77_0._refCards[2], Data.CARD_MAX_LEVEL, var_77_3) > 0 then
			var_77_1[#var_77_1 + 1] = var_77_3
		end
	end

	return var_77_1
end

function var_0_0.getBattleCardsBy4664(arg_78_0)
	local var_78_0 = Data._skillInfo[4664]
	local var_78_1 = {}
	local var_78_2 = arg_78_0:getBattleCardsByKeyword("B", var_78_0._refCards[1])

	if #var_78_2 == 0 then
		return var_78_1
	end

	for iter_78_0 = 1, #var_78_2 do
		local var_78_3 = var_78_2[iter_78_0]

		if #arg_78_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_78_0:getBattleCardsByNature("R", var_78_3._info._nature), var_78_0._refCards[2]), true, nil, nil, true) > 0 then
			var_78_1[#var_78_1 + 1] = var_78_3
		end
	end

	return var_78_1
end

function var_0_0.getBattleCardsBy4672(arg_79_0, arg_79_1)
	local var_79_0 = Data._skillInfo[4672]
	local var_79_1 = {}
	local var_79_2 = B.filterMergeCards(arg_79_0:getBattleCardsByKeyword("B", var_79_0._refCards[1]))

	for iter_79_0 = 1, #var_79_2 do
		local var_79_3 = var_79_2[iter_79_0]

		if #arg_79_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_79_0:getBattleCardsByStar("R", var_79_3:getStar()), var_79_0._refCards[2]), var_79_3), true, true, nil, true) > 0 then
			var_79_1[#var_79_1 + 1] = var_79_2[iter_79_0]
		end
	end

	return var_79_1
end

function var_0_0.getBattleCardsBy4674(arg_80_0, arg_80_1)
	local var_80_0 = Data._skillInfo[4674]
	local var_80_1 = {}
	local var_80_2 = arg_80_0:filterCanChangeToBoardCards(arg_80_0:getBattleCardsByKeyword("G", var_80_0._refCards[1]))

	for iter_80_0 = 1, #var_80_2 do
		local var_80_3 = var_80_2[iter_80_0]

		if #arg_80_0:filterCanChangeToBoardCards(B.filterInStarCards(arg_80_0:getBattleCardsByKeyword("P", var_80_0._refCards[2]), var_80_3:getStar())) > 0 then
			var_80_1[#var_80_1 + 1] = var_80_2[iter_80_0]
		end
	end

	return var_80_1
end

function var_0_0.getBattleCardsBy4753(arg_81_0)
	local var_81_0 = Data._skillInfo[4753]
	local var_81_1 = {}
	local var_81_2 = arg_81_0:getBoardCards()
	local var_81_3 = arg_81_0:canDrawCards()
	local var_81_4 = #arg_81_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_81_0:getBattleCardsByMaxStar("P", var_81_0._val[1]), var_81_0._refCards[1])) > 0

	for iter_81_0 = 1, #var_81_2 do
		local var_81_5 = var_81_2[iter_81_0]

		if var_81_5._info._category == var_81_0._refCards[1] and var_81_3 or var_81_5._info._category ~= var_81_0._refCards[1] and var_81_4 then
			var_81_1[#var_81_1 + 1] = var_81_2[iter_81_0]
		end
	end

	return var_81_1
end

function var_0_0.getBattleCardsBy4756(arg_82_0)
	local var_82_0 = Data._skillInfo[4756]
	local var_82_1 = arg_82_0:getBattleCardsByCategory("B", var_82_0._refCards[1])
	local var_82_2 = arg_82_0._opponent:getBattleCardsByCategory("B", var_82_0._refCards[1])
	local var_82_3 = 0

	for iter_82_0 = 1, #var_82_1 do
		var_82_3 = var_82_3 + var_82_1[iter_82_0]._atk
	end

	for iter_82_1 = 1, #var_82_2 do
		var_82_3 = var_82_3 + var_82_2[iter_82_1]._atk
	end

	return arg_82_0:filterCanChangeToBoardCards(arg_82_0:getBattleCardsByAtk("G", var_82_3))
end

function var_0_0.getBattleCardsBy4760(arg_83_0, arg_83_1)
	local var_83_0 = Data._skillInfo[4760]
	local var_83_1 = {}
	local var_83_2 = arg_83_0:getBattleCardsByKeyword("B", var_83_0._refCards[1])

	for iter_83_0 = 1, #var_83_2 do
		local var_83_3 = var_83_2[iter_83_0]

		if #arg_83_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_83_0:getBattleCardsByKeyword("P", var_83_0._refCards[1]), var_83_3)) > 0 then
			var_83_1[#var_83_1 + 1] = var_83_3
		end
	end

	return var_83_1
end

function var_0_0.getBattleCardsBy4766(arg_84_0, arg_84_1)
	local var_84_0 = Data._skillInfo[4766]
	local var_84_1 = {}
	local var_84_2 = arg_84_0:getBattleCardsByKeyword("B", var_84_0._refCards[1])

	for iter_84_0 = 1, #var_84_2 do
		local var_84_3 = var_84_2[iter_84_0]

		if #arg_84_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_84_0:getBattleCardsByAtk("P", var_84_3._atk), var_84_0._refCards[1]), var_84_3)) > 0 then
			var_84_1[#var_84_1 + 1] = var_84_2[iter_84_0]
		end
	end

	return var_84_1
end

function var_0_0.getBattleCardsBy4872(arg_85_0)
	local var_85_0 = Data._skillInfo[4872]
	local var_85_1 = {}
	local var_85_2 = arg_85_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_85_0:getBattleCardsByKeywordGroup("R", var_85_0._refCards), true), true, true)
	local var_85_3 = B.filterAdjustCards(arg_85_0:getBattleCardsByMinStar("G", 0), true)
	local var_85_4 = B.filterAdjustCards(arg_85_0:getBattleCardsByMinStar("G", 0), false)

	for iter_85_0 = 1, #var_85_2 do
		local var_85_5 = var_85_2[iter_85_0]
		local var_85_6 = false

		for iter_85_1 = 1, #var_85_3 do
			local var_85_7 = var_85_3[iter_85_1]

			if #B.filterInStarCards(var_85_4, var_85_5:getStar() - var_85_7:getStar()) > 0 then
				var_85_6 = true

				break
			end
		end

		if var_85_6 then
			var_85_1[#var_85_1 + 1] = var_85_2[iter_85_0]
		end
	end

	return var_85_1
end

function var_0_0.getBattleCardsBy4901(arg_86_0, arg_86_1)
	local var_86_0 = Data._skillInfo[4901]
	local var_86_1 = {}
	local var_86_2 = B.filterNoBuffCards(B.filterXYZCards(arg_86_0._opponent:getBoardCards(), true), true, BattleData.PositiveType.xyzMark)
	local var_86_3 = B.filterXYZCards(arg_86_0:getBattleCardsByKeyword("B", var_86_0._refCards[1]), true)

	B.appendTable(var_86_2, var_86_3)

	for iter_86_0 = 1, #var_86_2 do
		local var_86_4 = var_86_2[iter_86_0]

		if #arg_86_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_86_0:getBattleCardsByKeyword("R", var_86_0._refCards[1]), true), var_86_4._info._star + 1), nil, nil, nil, var_86_4._owner == arg_86_1._owner) > 0 then
			var_86_1[#var_86_1 + 1] = var_86_2[iter_86_0]
		end
	end

	return var_86_1
end

function var_0_0.getBattleCardsBy6507(arg_87_0)
	local var_87_0 = Data._skillInfo[6507]
	local var_87_1 = arg_87_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.sugarMark)
	local var_87_2 = {}

	for iter_87_0 = 1, #var_87_1 do
		local var_87_3 = var_87_1[iter_87_0]

		if var_87_3:getBuffValue(true, BattleData.PositiveType.sugarMark) >= var_87_0._val[1] then
			var_87_2[#var_87_2 + 1] = var_87_3
		end
	end

	local var_87_4 = arg_87_0:getBattleCardsByBuff("SD", true, BattleData.PositiveType.sugarMark2)

	for iter_87_1 = 1, #var_87_4 do
		local var_87_5 = var_87_4[iter_87_1]

		if var_87_5:getBuffValue(true, BattleData.PositiveType.sugarMark2) >= var_87_0._val[1] then
			var_87_2[#var_87_2 + 1] = var_87_5
		end
	end

	return var_87_2
end

function var_0_0.getBattleCardsBy6773(arg_88_0)
	local var_88_0 = B.filterMergeCards(arg_88_0:getBattleCards("R"))
	local var_88_1 = {}
	local var_88_2 = {}

	for iter_88_0 = 1, #var_88_0 do
		local var_88_3 = var_88_0[iter_88_0]._info._joinComponent

		for iter_88_1 = 1, #var_88_3 do
			local var_88_4 = var_88_3[iter_88_1]

			if var_88_4 == 0 then
				break
			end

			if var_88_4 > Data.INFO_ID_GROUP_SIZE_LARGE and var_88_2[var_88_4] == nil then
				var_88_2[var_88_4] = true
				var_88_1[#var_88_1 + 1] = var_88_4
			end
		end
	end

	return arg_88_0:filterCanChangeToBoardCards(arg_88_0:getBattleCardsByInfoIdGroup("G", var_88_1))
end

function var_0_0.getBattleCardsBy2155(arg_89_0)
	local var_89_0 = arg_89_0._opponent
	local var_89_1 = B.filterInTypeCards(var_89_0:getBattleCards("L"), Data.CardType.rare)
	local var_89_2 = {}

	for iter_89_0 = 1, #var_89_1 do
		local var_89_3 = var_89_1[iter_89_0]
		local var_89_4

		if var_89_3:isMerge() then
			var_89_4 = B.filterMergeCards(var_89_0:getBoardCards())
		elseif var_89_3:isSync() then
			var_89_4 = B.filterSyncCards(var_89_0:getBoardCards(), true)
		elseif var_89_3:isXYZ() then
			var_89_4 = B.filterXYZCards(var_89_0:getBoardCards(), true)
		end

		if var_89_4 ~= nil and #var_89_4 > 0 then
			var_89_2[#var_89_2 + 1] = var_89_3
		end
	end

	return var_89_2
end

function var_0_0.getBattleCardsBy2415(arg_90_0, arg_90_1)
	local var_90_0 = {}
	local var_90_1 = B.filterNotActionedCards(arg_90_0:getBattleCards(arg_90_1))

	for iter_90_0 = 1, #var_90_1 do
		local var_90_2 = var_90_1[iter_90_0]

		if var_90_2:getStar() == 6 or var_90_2._originOwner ~= var_90_2._owner then
			var_90_0[#var_90_0 + 1] = var_90_2
		end
	end

	return var_90_0
end

function var_0_0.getBattleCardsBy2429(arg_91_0, arg_91_1)
	local var_91_0 = Data._skillInfo[2429]
	local var_91_1 = B.filterAdjustCards(arg_91_0:getBattleCardsByCategory("G", var_91_0._refCards[1]), false)
	local var_91_2 = {}

	for iter_91_0 = 1, #var_91_1 do
		local var_91_3 = var_91_1[iter_91_0]

		if #arg_91_0:filterCanChangeToBoardCards(B.filterSyncCards(B.filterInCategoryCards(arg_91_0:getBattleCardsByStar("R", var_91_3:getStar() + arg_91_1:getStar()), var_91_0._refCards[1]), true)) > 0 then
			var_91_2[#var_91_2 + 1] = var_91_3
		end
	end

	return var_91_2
end

function var_0_0.getBattleCardsBy2482(arg_92_0)
	local var_92_0 = Data._skillInfo[2482]
	local var_92_1 = B.filterInKeywordCards(arg_92_0:getBattleCardsByTypeGroup("G", {
		Data.CardType.magic,
		Data.CardType.trap
	}), var_92_0._refCards[1])
	local var_92_2 = {}

	for iter_92_0 = 1, #var_92_1 do
		local var_92_3 = var_92_1[iter_92_0]

		if #arg_92_0:filterCanChangeToHandCards(arg_92_0:getBattleCardsByInfoId("P", var_92_3._infoId)) > 0 then
			var_92_2[#var_92_2 + 1] = var_92_3
		end
	end

	return var_92_2
end

function var_0_0.getBattleCardsBy2615(arg_93_0)
	local var_93_0 = Data._skillInfo[2615]
	local var_93_1 = B.filterXYZCards(arg_93_0:getBattleCardsByType("G", Data.CardType.monster), false)
	local var_93_2 = {}

	for iter_93_0 = 1, #var_93_1 do
		local var_93_3 = var_93_1[iter_93_0]

		if #B.filterInKeywordCards(arg_93_0:getBattleCardsByMinStar("B", var_93_3:getStar() + 1), var_93_0._refCards[1]) > 0 then
			var_93_2[#var_93_2 + 1] = var_93_3
		end
	end

	return var_93_2
end

function var_0_0.getBattleCardsBy2750(arg_94_0, arg_94_1)
	local var_94_0 = Data._skillInfo[2750]
	local var_94_1 = arg_94_0:getBattleCardsByCategory("G", var_94_0._refCards[1], Data.CARD_MAX_LEVEL, arg_94_1)
	local var_94_2 = {}

	for iter_94_0 = 1, #var_94_1 do
		local var_94_3 = var_94_1[iter_94_0]

		if #arg_94_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_94_0:getBattleCardsByMinStar("G", var_94_0._val[1], Data.CARD_MAX_LEVEL, var_94_3), var_94_0._refCards[1])) > 0 then
			var_94_2[#var_94_2 + 1] = var_94_3
		end
	end

	return var_94_2
end

function var_0_0.getBattleCardsBy2785(arg_95_0)
	local var_95_0 = Data._skillInfo[2785]
	local var_95_1 = B.filterCanBeSacrificedCards(B.filterTokenCards(arg_95_0:getBoardCards(), true))
	local var_95_2 = {}

	for iter_95_0 = 1, #var_95_1 do
		local var_95_3 = var_95_1[iter_95_0]

		if #B.filterXYZCards(arg_95_0:getBattleCards("B", Data.CARD_MAX_LEVEL, var_95_3), false) > 0 then
			var_95_2[#var_95_2 + 1] = var_95_3
		end
	end

	return var_95_2
end

function var_0_0.getBattleCardsBy2787(arg_96_0)
	local var_96_0 = Data._skillInfo[2787]
	local var_96_1 = B.filterCanBeSacrificedCards(B.filterTokenCards(arg_96_0:getBoardCards(), true))
	local var_96_2 = {}

	for iter_96_0 = 1, #var_96_1 do
		local var_96_3 = var_96_1[iter_96_0]

		if #arg_96_0:getBattleCardsByKeyword("B", var_96_0._refCards[1], Data.CARD_MAX_LEVEL, var_96_3) > 0 then
			var_96_2[#var_96_2 + 1] = var_96_3
		end
	end

	return var_96_2
end

function var_0_0.getBattleCardsBy2838(arg_97_0)
	local var_97_0 = Data._skillInfo[2838]
	local var_97_1 = B.filterEquipMagicCards(arg_97_0:getBattleCardsByKeyword("S", var_97_0._refCards[1]))
	local var_97_2 = {}

	for iter_97_0 = 1, #var_97_1 do
		local var_97_3 = var_97_1[iter_97_0]

		if #arg_97_0:getBattleCardsByKeyword("B", var_97_0._refCards[1], Data.CARD_MAX_LEVEL, var_97_3._binds[1]) > 0 then
			var_97_2[#var_97_2 + 1] = var_97_3
		end
	end

	return var_97_2
end

function var_0_0.getBattleCardsBy4554Target(arg_98_0)
	local var_98_0 = Data._skillInfo[4554]
	local var_98_1 = {}
	local var_98_2 = B.filterXYZCards(arg_98_0:getBattleCardsByKeyword("B", var_98_0._refCards[1]), true)
	local var_98_3
	local var_98_4

	for iter_98_0 = 1, #var_98_2 do
		local var_98_5 = var_98_2[iter_98_0]
		local var_98_6 = arg_98_0:getBattleCardsBy4554Cards(var_98_5)

		if #var_98_6 > 0 then
			var_98_1[#var_98_1 + 1] = var_98_5
			var_98_3 = var_98_5
			var_98_4 = var_98_6[1]._id * BattleData.ChoiceId.stage_2 + 1
		end
	end

	return var_98_1, var_98_3, var_98_4
end

function var_0_0.getBattleCardsBy4554Cards(arg_99_0, arg_99_1)
	local var_99_0 = Data._skillInfo[4554]
	local var_99_1 = B.getSameNumberHigherInfoId(arg_99_1._infoId)

	if var_99_1 ~= nil then
		return arg_99_0:filterCanChangeToBoardCards(arg_99_0:getBattleCardsByInfoId("R", var_99_1), true)
	else
		return {}
	end
end

function var_0_0.getBattleCardsBy4558Target(arg_100_0)
	local var_100_0 = Data._skillInfo[4558]
	local var_100_1 = {}
	local var_100_2 = B.filterInCategoryCards(arg_100_0:getBattleCardsByMaxAtk("B", var_100_0._val[1]), var_100_0._refCards[1])
	local var_100_3
	local var_100_4

	for iter_100_0 = 1, #var_100_2 do
		local var_100_5 = var_100_2[iter_100_0]
		local var_100_6 = arg_100_0:getBattleCardsBy4558Cards(var_100_5)

		if #var_100_6 > 0 then
			var_100_1[#var_100_1 + 1] = var_100_5
			var_100_3 = var_100_5
			var_100_4 = ((var_100_6[2] and var_100_6[2]._id or 0) * BattleData.UseCardId.id_group + var_100_6[1]._id) * BattleData.ChoiceId.stage_2 + 1
		end
	end

	return var_100_1, var_100_3, var_100_4
end

function var_0_0.getBattleCardsBy4558Cards(arg_101_0, arg_101_1)
	local var_101_0 = Data._skillInfo[4558]

	return arg_101_0:filterCanChangeToBoardCards(B.filterSameNameCards(arg_101_0:getBattleCardsByCategory("P", var_101_0._refCards[1]), arg_101_1))
end

function var_0_0.getBattleCardsBy4559Target(arg_102_0)
	local var_102_0 = {}
	local var_102_1 = arg_102_0:filterCanChangeToHandCards(B.filterCeremonyMagicCards(arg_102_0:getBattleCardsByType("P", Data.CardType.magic)))
	local var_102_2

	for iter_102_0 = 1, #var_102_1 do
		local var_102_3 = var_102_1[iter_102_0]
		local var_102_4 = arg_102_0:getBattleCardsBy4559Cards(var_102_3)

		if #var_102_4 > 0 then
			var_102_0[#var_102_0 + 1] = var_102_3
			var_102_2 = (var_102_3._id * BattleData.UseCardId.id_group + var_102_4[1]._id) * BattleData.ChoiceId.stage_2 + 1
		end
	end

	return var_102_0, var_102_2
end

function var_0_0.getBattleCardsBy4559Cards(arg_103_0, arg_103_1)
	return arg_103_0:filterCanChangeToHandCards(arg_103_0:getValidCeremonyResultCardsBy4559(arg_103_1))
end

function var_0_0.getBattleCardsBy4599(arg_104_0)
	local var_104_0 = {}
	local var_104_1 = arg_104_0:getBattleCardsByMinStar("B", 0)

	for iter_104_0 = 1, #var_104_1 do
		local var_104_2 = var_104_1[iter_104_0]

		if #arg_104_0:getBattleCardsByCategoryAndNature("B", var_104_2._info._category, var_104_2._info._nature, Data.CARD_MAX_LEVEL, var_104_2) > 0 then
			var_104_0[#var_104_0 + 1] = var_104_2
		end
	end

	return var_104_0
end

function var_0_0.getBattleCardsBy4747Cards(arg_105_0, arg_105_1)
	local var_105_0 = {}
	local var_105_1 = B.filterXYZCards(arg_105_0:getBattleCardsByType("H", Data.CardType.monster), false)

	for iter_105_0 = 1, #var_105_1 do
		local var_105_2 = var_105_1[iter_105_0]

		if #arg_105_0._opponent:getBattleCardsByStar("B", var_105_2:getStar()) > 0 then
			var_105_0[#var_105_0 + 1] = var_105_2
		end
	end

	return var_105_0
end

function var_0_0.getBattleCardsBy4944(arg_106_0)
	local var_106_0 = Data._skillInfo[4944]
	local var_106_1 = B.filterCanBeSacrificedCards(arg_106_0:getBattleCardsByMinStar("B", 0))
	local var_106_2 = {}

	for iter_106_0 = 1, #var_106_1 do
		local var_106_3 = var_106_1[iter_106_0]

		if #arg_106_0:filterCanChangeToBoardCards(B.filterNotInStarCards(arg_106_0:getBattleCardsByKeywordGroup("P", var_106_0._refCards), var_106_3:getStar()), nil, nil, nil, true) > 0 then
			var_106_2[#var_106_2 + 1] = var_106_3
		end
	end

	return var_106_2
end

function var_0_0.getBattleCardsBy4977(arg_107_0)
	local var_107_0 = Data._skillInfo[4977]
	local var_107_1 = B.filterNotActionedCards(B.filterXYZCards(arg_107_0:getBattleCardsByKeyword("B", var_107_0._refCards[1]), true))
	local var_107_2 = {}

	for iter_107_0 = 1, #var_107_1 do
		local var_107_3 = var_107_1[iter_107_0]

		if #arg_107_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_107_0:getBattleCardsByKeyword("R", var_107_0._refCards[1]), true), var_107_3._info._star + 1), nil, nil, nil, true) > 0 then
			var_107_2[#var_107_2 + 1] = var_107_3
		end
	end

	return var_107_2
end

function var_0_0.getBattleCardsBy5363(arg_108_0, arg_108_1)
	local var_108_0 = Data._skillInfo[5363]
	local var_108_1 = {}
	local var_108_2 = B.filterInCategoryCards(arg_108_0:getBattleCardsByNatureGroup("H", {
		var_108_0._refCards[1],
		var_108_0._refCards[2]
	}), var_108_0._refCards[3])

	for iter_108_0 = 1, #var_108_2 do
		local var_108_3 = var_108_2[iter_108_0]

		if #arg_108_0:filterCanChangeToHandCards(B.filterInNatureCards(B.filterInCategoryCards(arg_108_0:getBattleCardsByStar("P", var_108_3:getStar()), var_108_0._refCards[3]), var_108_0._refCards[var_108_3._info._nature == var_108_0._refCards[1] and 2 or 1])) > 0 then
			var_108_1[#var_108_1 + 1] = var_108_3
		end
	end

	return var_108_1
end

function var_0_0.getBattleCardsBy5391(arg_109_0)
	local var_109_0 = Data._skillInfo[5391]
	local var_109_1 = {}
	local var_109_2 = B.filterXYZCards(arg_109_0:getBoardCards(), true)

	for iter_109_0 = 1, #var_109_2 do
		local var_109_3 = var_109_2[iter_109_0]

		if #arg_109_0:filterCanChangeToBoardCards(B.filterXYZStarCards(arg_109_0:getBattleCardsByKeywordGroup("R", var_109_0._refCards), var_109_3._info._star + var_109_0._val[1])) > 0 then
			var_109_1[#var_109_1 + 1] = var_109_3
		end
	end

	return var_109_1
end

function var_0_0.getBattleCardsBy5416(arg_110_0)
	local var_110_0 = {}
	local var_110_1 = B.mergeTable({
		arg_110_0._opponent:getBattleCards("BSD"),
		arg_110_0:getBattleCards("BSD")
	})

	for iter_110_0 = 1, #var_110_1 do
		local var_110_2 = var_110_1[iter_110_0]

		if #arg_110_0:filterCanChangeToHandCards(arg_110_0:getBattleCardsByInfoId("P", var_110_2._infoId)) > 0 then
			var_110_0[#var_110_0 + 1] = var_110_2
		end
	end

	return var_110_0
end

function var_0_0.getBattleCardsBy5420(arg_111_0)
	local var_111_0 = Data._skillInfo[5420]
	local var_111_1 = {}
	local var_111_2 = B.filterCanBeSacrificedCards(B.filterInCategoryCards(arg_111_0:getBattleCardsByKeyword("B", var_111_0._refCards[1]), var_111_0._refCards[2]))

	for iter_111_0 = 1, #var_111_2 do
		local var_111_3 = var_111_2[iter_111_0]

		if #arg_111_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_111_0:getBattleCardsByKeyword("G", var_111_0._refCards[1]), var_111_3), nil, nil, nil, true) > 0 then
			var_111_1[#var_111_1 + 1] = var_111_3
		end
	end

	return var_111_1
end

function var_0_0.getBattleCardsBy5440(arg_112_0)
	local var_112_0 = Data._skillInfo[5440]
	local var_112_1 = {}
	local var_112_2 = B.filterXYZCards(arg_112_0:getBattleCardsByNature("B", var_112_0._refCards[1]), true)

	for iter_112_0 = 1, #var_112_2 do
		local var_112_3 = var_112_2[iter_112_0]

		if #arg_112_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_112_0:getBattleCardsByNature("R", var_112_0._refCards[1]), true), var_112_3._info._star + 1), nil, nil, nil, true) > 0 then
			var_112_1[#var_112_1 + 1] = var_112_3
		end
	end

	return var_112_1
end

function var_0_0.getBattleCardsBy5445(arg_113_0, arg_113_1)
	local var_113_0 = Data._skillInfo[5445]
	local var_113_1 = {}
	local var_113_2 = arg_113_0:getBattleCardsByKeyword("HG", var_113_0._refCards[1], Data.CARD_MAX_LEVEL, arg_113_1)

	for iter_113_0 = 1, #var_113_2 do
		local var_113_3 = var_113_2[iter_113_0]

		if #arg_113_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_113_0:getBattleCardsByKeyword("P", var_113_0._refCards[1]), var_113_3)) > 0 then
			var_113_1[#var_113_1 + 1] = var_113_3
		end
	end

	return var_113_1
end

function var_0_0.getBattleCardsBy5450(arg_114_0)
	local var_114_0 = {}
	local var_114_1 = B.filterSyncCards(arg_114_0:getBattleCardsByMinStar("B", 0), true)
	local var_114_2 = B.filterAdjustCards(arg_114_0:getBattleCardsByMinStar("G", 0), true)

	for iter_114_0 = 1, #var_114_1 do
		local var_114_3 = var_114_1[iter_114_0]

		for iter_114_1 = 1, #var_114_2 do
			local var_114_4 = var_114_2[iter_114_1]

			if #arg_114_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_114_0:getBattleCardsByStar("R", var_114_3:getStar() + var_114_4:getStar()), true), true, true, nil, true) > 0 then
				var_114_0[#var_114_0 + 1] = var_114_3

				break
			end
		end
	end

	return var_114_0
end

function var_0_0.getBattleCards2By5450(arg_115_0, arg_115_1)
	local var_115_0 = {}
	local var_115_1 = B.filterAdjustCards(arg_115_0:getBattleCardsByMinStar("G", 0), true)

	for iter_115_0 = 1, #var_115_1 do
		local var_115_2 = var_115_1[iter_115_0]

		if #arg_115_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_115_0:getBattleCardsByStar("R", arg_115_1:getStar() + var_115_2:getStar()), true), true, true, nil, true) > 0 then
			var_115_0[#var_115_0 + 1] = var_115_2
		end
	end

	return var_115_0
end

function var_0_0.getBattleCardsBy5494(arg_116_0)
	local var_116_0 = Data._skillInfo[5494]
	local var_116_1 = {}
	local var_116_2 = arg_116_0:filterCanChangeToHandCards(B.filterNotActionedCards(B.filterInCategoryGroupCards(arg_116_0:getBattleCardsByMinStar("B", 0), var_116_0._refCards)))

	for iter_116_0 = 1, #var_116_2 do
		local var_116_3 = var_116_2[iter_116_0]

		if #arg_116_0:filterCanChangeToBoardCards(arg_116_0:getBattleCardsByStar("H", var_116_3:getStar())) > 0 then
			var_116_1[#var_116_1 + 1] = var_116_3
		end
	end

	return var_116_1
end

function var_0_0.getBattleCardsBy5502(arg_117_0)
	local var_117_0 = Data._skillInfo[5502]

	return (B.mergeTable({
		arg_117_0:getBattleCards("BCSD"),
		arg_117_0._opponent:getBattleCards("BCSD")
	}))
end

function var_0_0.getBattleCardsBy5517(arg_118_0)
	local var_118_0 = Data._skillInfo[5517]
	local var_118_1 = {}
	local var_118_2 = arg_118_0:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_118_0:getBattleCardsByType("P", Data.CardType.monster), {
		var_118_0._refCards[1],
		var_118_0._refCards[2]
	}))

	for iter_118_0 = 1, #var_118_2 do
		if #B.filterInCategoryCards(arg_118_0:getBattleCardsByType("P", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_118_2[iter_118_0]), var_118_0._refCards[3]) > 0 then
			var_118_1[#var_118_1 + 1] = var_118_2[iter_118_0]
		end
	end

	return var_118_1
end

function var_0_0.getBattleCardsBy5547(arg_119_0)
	local var_119_0 = Data._skillInfo[5547]
	local var_119_1 = {}
	local var_119_2 = B.filterInKeywordGroupCards(arg_119_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.xyzMark), var_119_0._refCards)

	for iter_119_0 = 1, #var_119_2 do
		if #arg_119_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_119_0:getBattleCardsByKeywordGroup("R", var_119_0._refCards), true), var_119_2[iter_119_0]._info._star), true, true) > 0 then
			var_119_1[#var_119_1 + 1] = var_119_2[iter_119_0]
		end
	end

	return var_119_1
end

function var_0_0.getBattleCardsBy5585(arg_120_0)
	local var_120_0 = Data._skillInfo[5585]
	local var_120_1 = {}
	local var_120_2 = B.filterNotActionedCards(arg_120_0:getBattleCardsByKeywordGroup("B", var_120_0._refCards))

	for iter_120_0 = 1, #var_120_2 do
		local var_120_3 = var_120_2[iter_120_0]

		if #arg_120_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_120_0:getBattleCardsByKeyword("PG", var_120_0._refCards[1]), var_120_3), nil, nil, nil, true) > 0 then
			var_120_1[#var_120_1 + 1] = var_120_3
		end
	end

	return var_120_1
end

function var_0_0.getBattleCardsBy5601(arg_121_0)
	local var_121_0 = Data._skillInfo[5601]
	local var_121_1 = {}
	local var_121_2 = arg_121_0:getBattleCardsByMaxQuality("P", var_121_0._refCards[1])

	for iter_121_0 = 1, #var_121_2 do
		local var_121_3 = var_121_2[iter_121_0]

		if #B.filterNotSameNameCards(B.filterInStarCards(B.filterInNatureCards(B.filterInCategoryCards(var_121_2, var_121_3._info._category), var_121_3._info._nature), var_121_3._info._star), var_121_3) > 0 then
			var_121_1[#var_121_1 + 1] = var_121_3
		end
	end

	return (arg_121_0:filterCanChangeToHandCards(var_121_1))
end

function var_0_0.getBattleCardsBy5603(arg_122_0)
	local var_122_0 = Data._skillInfo[5603]
	local var_122_1 = {}
	local var_122_2 = B.filterLinkCards(arg_122_0:getBattleCardsByKeyword("B", var_122_0._refCards[1]), true)

	for iter_122_0 = 1, #var_122_2 do
		local var_122_3 = var_122_2[iter_122_0]

		if #arg_122_0:getBattleCardsByNature("B", var_122_0._refCards[2], Data.CARD_MAX_LEVEL, var_122_3) > 0 then
			var_122_1[#var_122_1 + 1] = var_122_3
		end
	end

	return var_122_1
end

function var_0_0.getBattleCardsBy5604(arg_123_0)
	local var_123_0 = Data._skillInfo[5603]
	local var_123_1 = {}
	local var_123_2 = B.filterLinkCards(arg_123_0:getBattleCardsByKeyword("R", var_123_0._refCards[1]), true)
	local var_123_3 = B.filterLinkCards(arg_123_0:getBoardCards(), true)

	for iter_123_0 = 1, #var_123_2 do
		local var_123_4 = var_123_2[iter_123_0]
		local var_123_5 = false

		for iter_123_1 = 1, #var_123_3 do
			if var_123_3[iter_123_1]:getLink() == var_123_4:getLink() then
				var_123_5 = true

				break
			end
		end

		if not var_123_5 then
			var_123_1[#var_123_1 + 1] = var_123_4
		end
	end

	return (arg_123_0:filterCanChangeToBoardCards(var_123_1))
end

function var_0_0.getBattleCardsBy5607(arg_124_0)
	local var_124_0 = Data._skillInfo[5607]
	local var_124_1 = {}
	local var_124_2 = B.filterInTypeCards(arg_124_0:getBattleCardsByKeyword("G", var_124_0._refCards[1]), Data.CardType.monster)

	for iter_124_0 = 1, #var_124_2 do
		local var_124_3 = var_124_2[iter_124_0]

		if #arg_124_0:filterCanChangeToHandCards(B.filterSameNameCards(arg_124_0:getBattleCardsByType("P", Data.CardType.monster), var_124_3)) > 0 then
			var_124_1[#var_124_1 + 1] = var_124_3
		end
	end

	return var_124_1
end

function var_0_0.getBattleCardsBy5622(arg_125_0)
	local var_125_0 = Data._skillInfo[5622]
	local var_125_1 = {}
	local var_125_2 = B.filterCanBeSacrificedCards(arg_125_0:getBattleCardsByCategoryGroup("HB", var_125_0._refCards))

	for iter_125_0 = 1, #var_125_2 do
		local var_125_3 = var_125_2[iter_125_0]
		local var_125_4 = arg_125_0:getBattleCards("B", Data.CARD_MAX_LEVEL, var_125_3)
		local var_125_5 = arg_125_0._opponent:getBoardCards()

		if #var_125_4 + #var_125_5 > 0 then
			var_125_1[#var_125_1 + 1] = var_125_3
		end
	end

	return var_125_1
end

function var_0_0.getBattleCardsBy5624(arg_126_0)
	local var_126_0 = Data._skillInfo[5624]
	local var_126_1 = {}
	local var_126_2 = B.filterCanBeSacrificedCards(arg_126_0:getBattleCardsByCategory("HB", var_126_0._refCards[1]))

	for iter_126_0 = 1, #var_126_2 do
		local var_126_3 = var_126_2[iter_126_0]
		local var_126_4 = arg_126_0:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, var_126_3)
		local var_126_5 = arg_126_0._opponent:getBattleCards("BCSD")

		if #var_126_4 + #var_126_5 > 0 then
			var_126_1[#var_126_1 + 1] = var_126_3
		end
	end

	return var_126_1
end

function var_0_0.getBattleCardsBy5647(arg_127_0)
	local var_127_0 = Data._skillInfo[5647]
	local var_127_1 = {}
	local var_127_2 = arg_127_0:getBattleCardsByKeyword("B", var_127_0._refCards[1])

	for iter_127_0 = 1, #var_127_2 do
		local var_127_3 = var_127_2[iter_127_0]

		if #arg_127_0:filterCanChangeToHandCards(B.filterSameNameCards(arg_127_0:getBattleCardsByType("P", Data.CardType.monster), var_127_3)) > 0 then
			var_127_1[#var_127_1 + 1] = var_127_3
		end
	end

	return var_127_1
end

function var_0_0.getBattleCardsBy7328(arg_128_0)
	local var_128_0 = Data._skillInfo[7328]
	local var_128_1 = {}
	local var_128_2 = B.filterXYZCards(arg_128_0:getBoardCards(), false)

	for iter_128_0 = 1, #var_128_2 do
		local var_128_3 = var_128_2[iter_128_0]

		if #arg_128_0:filterCanChangeToBoardCards(B.filterInNatureCards(B.filterInKeywordCards(arg_128_0:getBattleCardsByMinStar("R", var_128_3:getStar()), var_128_0._refCards[1]), var_128_3._info._nature), true, true) > 0 then
			var_128_1[#var_128_1 + 1] = var_128_3
		end
	end

	return var_128_1
end

function var_0_0.getBattleCardsBy7408(arg_129_0)
	local var_129_0 = Data._skillInfo[7408]
	local var_129_1 = {}
	local var_129_2 = B.filterCanBeSacrificedCards(B.filterCeremonyMonsterCards(arg_129_0:getBattleCardsByKeyword("BH", var_129_0._refCards[1])))

	for iter_129_0 = 1, #var_129_2 do
		local var_129_3 = var_129_2[iter_129_0]

		if #arg_129_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_129_0:getBattleCardsByKeyword("H", var_129_0._refCards[1], Data.CARD_MAX_LEVEL, var_129_3)), false, true, nil, var_129_3._status == BattleData.CardStatus.board) > 0 then
			var_129_1[#var_129_1 + 1] = var_129_3
		end
	end

	return var_129_1
end

function var_0_0.getBattleCardsBy7582(arg_130_0)
	local var_130_0 = Data._skillInfo[7582]
	local var_130_1 = {}
	local var_130_2 = B.filterMergeCards(arg_130_0:getBattleCardsByKeyword("G", var_130_0._refCards[1]))

	for iter_130_0 = 1, #var_130_2 do
		local var_130_3 = var_130_2[iter_130_0]

		if #arg_130_0:filterCanChangeToBoardCards(B.filterMergeCards(arg_130_0:getBattleCardsByKeyword("G", var_130_0._refCards[1], Data.CARD_MAX_LEVEL, var_130_3))) > 0 then
			var_130_1[#var_130_1 + 1] = var_130_3
		end
	end

	return var_130_1
end

function var_0_0.getBattleCardsBy7592(arg_131_0)
	local var_131_0 = Data._skillInfo[7592]
	local var_131_1 = {}
	local var_131_2 = arg_131_0:getBattleCardsByType("B", Data.CardType.rare)

	for iter_131_0 = 1, #var_131_2 do
		local var_131_3 = var_131_2[iter_131_0]

		if var_131_3._info._keyword == var_131_0._refCards[1] and #arg_131_0:filterCanChangeToBoardCards(B.filterSameNameCards(arg_131_0:getBattleCards("R"), var_131_3), true, true, nil, true) > 0 then
			var_131_1[#var_131_1 + 1] = var_131_3
		end
	end

	return var_131_1
end

function var_0_0.getBattleCardsBy7601(arg_132_0)
	local var_132_0 = Data._skillInfo[7601]
	local var_132_1 = {}
	local var_132_2 = arg_132_0:getBattleCardsByType("B", Data.CardType.rare)

	for iter_132_0 = 1, #var_132_2 do
		local var_132_3 = var_132_2[iter_132_0]

		if var_132_3._info._keyword == var_132_0._refCards[1] and #arg_132_0:filterCanChangeToBoardCards(B.filterSameNameCards(arg_132_0:getBattleCards("R"), var_132_3), true, true, nil, true) > 0 then
			var_132_1[#var_132_1 + 1] = var_132_3
		end
	end

	return var_132_1
end

function var_0_0.getBattleCardsBy7646(arg_133_0)
	local var_133_0 = Data._skillInfo[7646]
	local var_133_1 = {}
	local var_133_2 = arg_133_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_133_0:getBattleCardsByCategory("G", var_133_0._refCards[1]), true))

	for iter_133_0 = 1, #var_133_2 do
		local var_133_3 = var_133_2[iter_133_0]

		if #B.filterAdjustCards(arg_133_0:getBattleCardsByType("G", Data.CardType.monster, Data.MAX_CARD_LEVEL, var_133_3), true) > 0 and #B.filterAdjustCards(arg_133_0:getBattleCardsByType("G", Data.CardType.monster, Data.MAX_CARD_LEVEL, var_133_3), false) > 0 then
			var_133_1[#var_133_1 + 1] = var_133_3
		end
	end

	return var_133_1
end

function var_0_0.getBattleCardsBy7648(arg_134_0)
	local var_134_0 = Data._skillInfo[7648]
	local var_134_1 = {}
	local var_134_2 = B.filterCanBeSacrificedCards(B.filterNotActionedCards(B.filterXYZCards(arg_134_0:getBoardCards(), true)))

	for iter_134_0 = 1, #var_134_2 do
		local var_134_3 = var_134_2[iter_134_0]

		if #arg_134_0:filterCanChangeToBoardCards(B.filterXYZStarCards(arg_134_0:getBattleCardsByCategoryAndNature("R", var_134_3._info._category, var_134_3._info._nature), var_134_3._info._star), nil, nil, nil, true) > 0 then
			var_134_1[#var_134_1 + 1] = var_134_3
		end
	end

	return var_134_1
end

function var_0_0.getBattleCardsBy7686(arg_135_0)
	local var_135_0 = Data._skillInfo[7686]
	local var_135_1 = {}
	local var_135_2 = B.filterNotActionedCards(B.filterInKeywordCards(arg_135_0:getBattleCardsByType(arg_135_0:getEmptyBoardPos() == nil and "B" or "HB", Data.CardType.monster), var_135_0._refCards[1]))

	for iter_135_0 = 1, #var_135_2 do
		local var_135_3 = var_135_2[iter_135_0]

		if #arg_135_0:filterCanChangeToBoardCards(arg_135_0:getBattleCardsByType("H", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_135_3), nil, nil, nil, true) > 0 then
			var_135_1[#var_135_1 + 1] = var_135_3
		end
	end

	return var_135_1
end

function var_0_0.getBattleCardsBy7687(arg_136_0)
	local var_136_0 = Data._skillInfo[7687]
	local var_136_1 = {}
	local var_136_2

	if arg_136_0:getEmptyBoardPos() == nil then
		var_136_2 = arg_136_0:getBoardCards()
	else
		var_136_2 = B.mergeTable({
			arg_136_0:getBattleCards("BCSD"),
			arg_136_0._opponent:getBattleCards("BCSD")
		})
	end

	for iter_136_0 = 1, #var_136_2 do
		local var_136_3 = var_136_2[iter_136_0]

		if #arg_136_0:filterCanChangeToBoardCards(arg_136_0:getBattleCardsByKeyword("HG", var_136_0._refCards[1], Data.CARD_MAX_LEVEL, var_136_3), nil, nil, nil, true) > 0 then
			var_136_1[#var_136_1 + 1] = var_136_3
		end
	end

	return var_136_1
end

function var_0_0.getBattleCardsBy7705(arg_137_0)
	local var_137_0 = {}
	local var_137_1 = arg_137_0:getBattleCardsByMinStar("B", 0)

	for iter_137_0 = 1, #var_137_1 do
		local var_137_2 = var_137_1[iter_137_0]

		if #arg_137_0:filterCanChangeToBoardCards(arg_137_0:getBattleCardsByStar("HG", var_137_2:getStar())) > 0 then
			var_137_0[#var_137_0 + 1] = var_137_2
		end
	end

	return var_137_0
end

function var_0_0.getBattleCardsBy7706(arg_138_0)
	local var_138_0 = Data._skillInfo[7706]
	local var_138_1 = {}
	local var_138_2 = B.filterXYZCards(arg_138_0:getBoardCards(), true)

	for iter_138_0 = 1, #var_138_2 do
		local var_138_3 = var_138_2[iter_138_0]

		if #arg_138_0:filterCanChangeToHandCards(B.filterInStarCards(arg_138_0:getBattleCardsByMaxQuality("G", var_138_0._refCards[1]), var_138_3._info._star)) > 0 then
			var_138_1[#var_138_1 + 1] = var_138_3
		end
	end

	return var_138_1
end

function var_0_0.getBattleCardsBy7733(arg_139_0)
	local var_139_0 = Data._skillInfo[7733]
	local var_139_1 = {}
	local var_139_2 = arg_139_0:getBattleCardsByCategory("H", var_139_0._refCards[1], Data.CARD_MAX_LEVEL, fromCard)

	for iter_139_0 = 1, #var_139_2 do
		local var_139_3 = var_139_2[iter_139_0]

		if #arg_139_0:filterCanChangeToHandCards(B.filterMoreThanStarCards(arg_139_0:getBattleCardsByCategoryAndNature("P", var_139_0._refCards[1], var_139_3._info._nature), var_139_0._val[1])) > 0 then
			var_139_1[#var_139_1 + 1] = var_139_3
		end
	end

	return var_139_1
end

function var_0_0.getBattleCardsBy7742(arg_140_0)
	local var_140_0 = Data._skillInfo[7742]
	local var_140_1 = {}
	local var_140_2 = arg_140_0:getBattleCardsByKeyword("G", var_140_0._refCards[1])

	for iter_140_0 = 1, #var_140_2 do
		local var_140_3 = var_140_2[iter_140_0]

		if #arg_140_0:filterCanChangeToBoardCards(arg_140_0:getBattleCardsByKeyword("HG", var_140_0._refCards[1], Data.CARD_MAX_LEVEL, var_140_3), nil, true) > 0 then
			var_140_1[#var_140_1 + 1] = var_140_3
		end
	end

	return var_140_1
end

function var_0_0.getBattleCardsBy7752(arg_141_0)
	local var_141_0 = Data._skillInfo[7752]
	local var_141_1 = {}
	local var_141_2 = B.filterInTypeCards(arg_141_0:getBattleCardsByKeywordGroup("B", var_141_0._refCards), Data.CardType.monster)

	for iter_141_0 = 1, #var_141_2 do
		local var_141_3 = var_141_2[iter_141_0]

		if #arg_141_0:filterCanChangeToBoardCards(B.filterSameNameCards(arg_141_0:getBattleCardsByType("P", Data.CardType.monster), var_141_3)) > 0 then
			var_141_1[#var_141_1 + 1] = var_141_3
		end
	end

	return var_141_1
end

function var_0_0.getBattleCardsBy7787(arg_142_0)
	local var_142_0 = Data._skillInfo[7787]
	local var_142_1 = B.filterNotActionedCards(B.filterXYZCards(arg_142_0:getBoardCards(), true))
	local var_142_2 = {}

	for iter_142_0 = 1, #var_142_1 do
		local var_142_3 = var_142_1[iter_142_0]

		if #arg_142_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_142_0:getBattleCardsByKeyword("R", var_142_0._refCards[1]), true), var_142_3._info._star + 1), nil, nil, nil, true) > 0 then
			var_142_2[#var_142_2 + 1] = var_142_3
		end
	end

	return var_142_2
end

function var_0_0.getBattleCardsBy7793(arg_143_0)
	local var_143_0 = Data._skillInfo[7793]
	local var_143_1 = B.filterXYZCards(arg_143_0:getBoardCards(), true)
	local var_143_2 = {}

	for iter_143_0 = 1, #var_143_1 do
		local var_143_3 = var_143_1[iter_143_0]

		if #arg_143_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_143_0:getBattleCardsByKeyword("R", var_143_0._refCards[1]), true), var_143_3._info._star + 2), nil, nil, nil, true) > 0 then
			var_143_2[#var_143_2 + 1] = var_143_3
		end
	end

	return var_143_2
end

function var_0_0.getBattleCardsBy7794(arg_144_0)
	local var_144_0 = Data._skillInfo[7794]
	local var_144_1 = B.filterInKeywordCards(arg_144_0:getBattleCardsByType("G", Data.CardType.monster), var_144_0._refCards[1])
	local var_144_2 = {}

	for iter_144_0 = 1, #var_144_1 do
		local var_144_3 = var_144_1[iter_144_0]

		if #arg_144_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_144_0:getBattleCardsByKeyword("G", var_144_0._refCards[1], Data.CARD_MAX_LEVEL, var_144_3), true)) > 0 then
			var_144_2[#var_144_2 + 1] = var_144_3
		end
	end

	return var_144_2
end

function var_0_0.getBattleCardsBy7819(arg_145_0, arg_145_1)
	local var_145_0 = Data._skillInfo[7819]
	local var_145_1 = arg_145_0:getBattleCardsByCategory("G", var_145_0._refCards[1], Data.CARD_MAX_LEVEL, arg_145_1)
	local var_145_2 = {}

	for iter_145_0 = 1, #var_145_1 do
		local var_145_3 = var_145_1[iter_145_0]
		local var_145_4 = arg_145_0:filterCanChangeToBoardCards(arg_145_0:getBattleCardsByCategory("G", var_145_0._refCards[1]))
		local var_145_5 = false

		for iter_145_1 = 1, #var_145_4 do
			if var_145_4[iter_145_1] ~= arg_145_1 and var_145_4[iter_145_1] ~= var_145_3 then
				var_145_5 = true
			end
		end

		if var_145_5 then
			var_145_2[#var_145_2 + 1] = var_145_3
		end
	end

	return var_145_2
end

function var_0_0.getBattleCardsBy8082(arg_146_0)
	local var_146_0 = Data._skillInfo[8082]
	local var_146_1 = B.filterInKeywordCards(arg_146_0:getBattleCardsByCategory("G", var_146_0._refCards[2]), var_146_0._refCards[1])
	local var_146_2 = arg_146_0:getBattleCardsByKeyword("B", var_146_0._refCards[1])

	return B.filterCanBindAlterMagicCardsEx(var_146_1, var_146_2)
end

function var_0_0.getBattleCardsBy8083(arg_147_0)
	local var_147_0 = Data._skillInfo[8083]
	local var_147_1 = {}
	local var_147_2 = arg_147_0:getBattleCardsByKeywordGroup("B", var_147_0._refCards)

	for iter_147_0 = 1, #var_147_2 do
		local var_147_3 = var_147_2[iter_147_0]

		if #arg_147_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_147_0:getBattleCardsByKeyword("P", var_147_0._refCards[1]), var_147_3)) > 0 then
			var_147_1[#var_147_1 + 1] = var_147_3
		end
	end

	return var_147_1
end

function var_0_0.getBattleCardsBy9051(arg_148_0, arg_148_1)
	local var_148_0 = Data._skillInfo[9051]
	local var_148_1 = {}
	local var_148_2 = arg_148_0:getBattleCardsByKeyword("B", var_148_0._refCards[1])

	if arg_148_1 == 9051 then
		var_148_2 = B.filterLessThanStarCards(var_148_2, 11)
	else
		var_148_2 = B.filterMoreThanStarCards(var_148_2, 2)
	end

	for iter_148_0 = 1, #var_148_2 do
		local var_148_3 = var_148_2[iter_148_0]

		if #arg_148_0:getBattleCardsByCategory("BHG", var_148_0._refCards[2], Data.CARD_MAX_LEVEL, var_148_3) > 0 then
			var_148_1[#var_148_1 + 1] = var_148_3
		end
	end

	return var_148_1
end

function var_0_0.getBattleCardsBy9072(arg_149_0)
	local var_149_0 = Data._skillInfo[9072]
	local var_149_1 = arg_149_0:getBattleCardsByKeyword("B", var_149_0._refCards[1])
	local var_149_2 = arg_149_0:getBattleCardsByKeyword("H", var_149_0._refCards[1])
	local var_149_3 = arg_149_0._opponent:getBattleCards("BCSD")

	if #var_149_2 + #var_149_3 > 0 or #var_149_1 > 1 then
		return B.mergeTable({
			var_149_1,
			var_149_2
		})
	else
		return {}
	end
end

function var_0_0.getBattleCardsBy9258(arg_150_0)
	local var_150_0 = {}
	local var_150_1 = B.filterDualCards(arg_150_0:getBattleCardsByType("P", Data.CardType.monster))

	for iter_150_0 = 1, #var_150_1 do
		local var_150_2 = var_150_1[iter_150_0]

		if #arg_150_0:filterCanChangeToHandCards(B.filterDualCards(arg_150_0:getBattleCardsByType("P", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_150_2))) > 0 then
			var_150_0[#var_150_0 + 1] = var_150_2
		end
	end

	return var_150_0
end

function var_0_0.getBattleCardsBy9375(arg_151_0)
	local var_151_0 = {}
	local var_151_1 = B.mergeTable({
		arg_151_0:getBattleCardsByType("G", Data.CardType.rare),
		arg_151_0._opponent:getBattleCardsByType("G", Data.CardType.rare)
	})

	for iter_151_0 = 1, #var_151_1 do
		local var_151_2 = var_151_1[iter_151_0]

		if #arg_151_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_151_0:getBattleCardsByType("G", Data.CardType.rare, Data.CARD_MAX_LEVEL, var_151_2),
			arg_151_0._opponent:getBattleCardsByType("G", Data.CardType.rare, Data.CARD_MAX_LEVEL, var_151_2)
		}), nil, nil, nil, true) > 0 then
			var_151_0[#var_151_0 + 1] = var_151_2
		end
	end

	return var_151_0
end

function var_0_0.getBattleCardsBy9378(arg_152_0, arg_152_1)
	local var_152_0 = Data._skillInfo[9378]
	local var_152_1 = {}
	local var_152_2 = B.filterXYZCards(arg_152_0:getBattleCardsByCategory("B", var_152_0._refCards[1]), false)

	for iter_152_0 = 1, #var_152_2 do
		local var_152_3 = var_152_2[iter_152_0]

		if #arg_152_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_152_0:getBattleCardsByMaxStar(arg_152_1 == 9378 and "HG" or "P", var_152_3:getStar()), var_152_0._refCards[2]), var_152_3)) > 0 then
			var_152_1[#var_152_1 + 1] = var_152_3
		end
	end

	return var_152_1
end

function var_0_0.getBattleCardsBy9495(arg_153_0)
	local var_153_0 = Data._skillInfo[9495]
	local var_153_1 = {}
	local var_153_2 = B.filterInKeywordCards(arg_153_0:getBattleCardsByType("BG", Data.CardType.monster), var_153_0._refCards[1])

	for iter_153_0 = 1, #var_153_2 do
		local var_153_3 = var_153_2[iter_153_0]

		if #B.filterSameNatureCards(var_153_3._owner._opponent:getBoardCards(), var_153_3) > 0 then
			var_153_1[#var_153_1 + 1] = var_153_3
		end
	end

	return var_153_1
end

function var_0_0.getBattleCardsBy9538(arg_154_0, arg_154_1)
	local var_154_0 = Data._skillInfo[9538]
	local var_154_1 = {}
	local var_154_2 = arg_154_0:getBattleCardsByCategory("H", var_154_0._refCards[1])

	for iter_154_0 = 1, #var_154_2 do
		local var_154_3 = var_154_2[iter_154_0]
		local var_154_4 = false
		local var_154_5 = var_154_3:getAlterMagicInfoId()

		if var_154_5 ~= nil then
			if not arg_154_1:isBinded(var_154_5) then
				var_154_4 = true
			end
		else
			for iter_154_1 = 2, #var_154_0._refCards do
				if not arg_154_1:isBinded(var_154_0._refCards[iter_154_1]) then
					var_154_4 = true

					break
				end
			end
		end

		if var_154_4 then
			var_154_1[#var_154_1 + 1] = var_154_3
		end
	end

	return var_154_1
end

function var_0_0.getBattleCardsBy9600(arg_155_0, arg_155_1)
	local var_155_0 = Data._skillInfo[9600]
	local var_155_1 = {}
	local var_155_2 = arg_155_0._opponent:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_155_0:getBattleCardsByType("HP", Data.CardType.monster), var_155_0._refCards[1]), arg_155_1))

	for iter_155_0 = 1, #var_155_2 do
		local var_155_3 = var_155_2[iter_155_0]

		if #arg_155_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterNotInStarCards(B.filterInKeywordCards(arg_155_0:getBattleCardsByType("P", Data.CardType.monster), var_155_0._refCards[1]), var_155_3:getStar()), arg_155_1)) > 0 then
			var_155_1[#var_155_1 + 1] = var_155_3
		end
	end

	return var_155_1
end

function var_0_0.getBattleCardsBy9690(arg_156_0, arg_156_1)
	local var_156_0 = Data._skillInfo[9690]
	local var_156_1 = {}
	local var_156_2 = arg_156_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.defendPosture)

	for iter_156_0 = 1, #var_156_2 do
		local var_156_3 = var_156_2[iter_156_0]

		if #arg_156_0:getBattleCardsByKeyword("B", var_156_0._refCards[1], Data.CARD_MAX_LEVEL, var_156_3) > 0 then
			var_156_1[#var_156_1 + 1] = var_156_3
		end
	end

	return var_156_1
end

function var_0_0.getBattleCardsBy9763(arg_157_0)
	local var_157_0 = Data._skillInfo[9763]
	local var_157_1 = {}
	local var_157_2 = B.filterInCategoryCards(arg_157_0:getBattleCardsByMinStar("BH", 0), var_157_0._refCards[1])

	if #var_157_2 == 0 then
		return var_157_1
	end

	local var_157_3 = 0

	for iter_157_0 = 1, #var_157_2 do
		var_157_3 = var_157_3 + var_157_2[iter_157_0]:getStar()
	end

	return arg_157_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_157_0:getBattleCardsByMaxStar("P", var_157_3), var_157_0._refCards[1]))
end

function var_0_0.getBattleCardsBy9867(arg_158_0)
	local var_158_0 = Data._skillInfo[9867]
	local var_158_1 = {}
	local var_158_2 = B.filterInKeywordCards(arg_158_0:getBattleCardsByMinStar("B", 0), var_158_0._refCards[1])

	for iter_158_0 = 1, #var_158_2 do
		local var_158_3 = var_158_2[iter_158_0]

		if #arg_158_0:filterCanChangeToBoardCards(arg_158_0:getBattleCardsByMaxStar("H", var_158_3:getStar())) > 0 then
			var_158_1[#var_158_1 + 1] = var_158_3
		end
	end

	return var_158_1
end

function var_0_0.getBattleCardsBy9916(arg_159_0)
	local var_159_0 = Data._skillInfo[9916]
	local var_159_1 = {}
	local var_159_2 = arg_159_0._handCards
	local var_159_3 = #arg_159_0:getBattleCardsByInfoId("SD", var_159_0._refCards[2]) > 0

	for iter_159_0 = 1, #var_159_2 do
		local var_159_4 = var_159_2[iter_159_0]
		local var_159_5 = arg_159_0:filterCanChangeToHandCards(arg_159_0:getBattleCardsByKeyword("P", var_159_0._refCards[1]))

		if var_159_3 then
			B.appendTable(var_159_5, arg_159_0:filterCanChangeToHandCards(arg_159_0:getBattleCardsByCategory("P", var_159_0._refCards[3])))
		end

		if #var_159_5 > 0 then
			var_159_1[#var_159_1 + 1] = var_159_4
		end
	end

	return var_159_1
end

function var_0_0.getBattleCardsBy9917(arg_160_0)
	local var_160_0 = Data._skillInfo[9917]
	local var_160_1 = {}
	local var_160_2 = B.filterInCategoryCards(arg_160_0:getBattleCardsByMinStar("G", 0), var_160_0._refCards[1])

	for iter_160_0 = 1, #var_160_2 do
		local var_160_3 = var_160_2[iter_160_0]

		if #arg_160_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_160_0:getBattleCardsByMinStar("H", var_160_3:getStar()), var_160_0._refCards[1])) > 0 then
			var_160_1[#var_160_1 + 1] = var_160_3
		end
	end

	return var_160_1
end

function var_0_0.getBattleCardsBy9984(arg_161_0, arg_161_1)
	local var_161_0 = Data._skillInfo[9984]
	local var_161_1 = {}
	local var_161_2 = B.filterInKeywordCards(arg_161_0:getBattleCardsByType("P", Data.CardType.monster), var_161_0._refCards[1])

	for iter_161_0 = 1, #var_161_2 do
		local var_161_3 = var_161_2[iter_161_0]

		if #arg_161_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_161_0:getBattleCardsByType("HP", Data.CardType.monster, Data.CARD_MAX_LEVEL, var_161_3), var_161_0._refCards[1]), nil, nil, nil, true) > 0 then
			var_161_1[#var_161_1 + 1] = var_161_3

			if arg_161_1 then
				break
			end
		end
	end

	return var_161_1
end

function var_0_0.getBattleCardsBy9991(arg_162_0)
	local var_162_0 = Data._skillInfo[9991]
	local var_162_1 = {}
	local var_162_2 = arg_162_0._opponent:getBattleCardsByType("G", Data.CardType.monster)

	for iter_162_0 = 1, #var_162_2 do
		local var_162_3 = var_162_2[iter_162_0]

		if var_162_3._dieByAttack and var_162_3._onGraveEndRound == arg_162_0._opponent._endRound then
			var_162_1[#var_162_1 + 1] = var_162_3
		end
	end

	return var_162_1
end

function var_0_0.getBattleCardsBy13072(arg_163_0)
	local var_163_0 = Data._skillInfo[13072]
	local var_163_1 = B.filterInKeywordCards(arg_163_0:getBattleCardsByType("G", Data.CardType.monster), var_163_0._refCards[1])

	if #var_163_1 == 0 then
		return {}
	end

	local var_163_2 = arg_163_0:getBattleCardsByKeyword("B", var_163_0._refCards[2])

	if #var_163_2 == 0 then
		return {}
	end

	return B.filterCanBindAlterMagicCardsEx(var_163_1, var_163_2)
end

function var_0_0.getBattleCardsBy13168(arg_164_0)
	local var_164_0 = Data._skillInfo[13168]
	local var_164_1 = {}
	local var_164_2 = B.filterCanBeSacrificedCards(arg_164_0:getBattleCardsByKeyword("B", var_164_0._refCards[1]))

	for iter_164_0 = 1, #var_164_2 do
		local var_164_3 = var_164_2[iter_164_0]

		if arg_164_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_164_0:getBattleCardsByType("P", Data.CardType.monster), var_164_0._refCards[1]), var_164_3)) then
			var_164_1[#var_164_1 + 1] = var_164_3
		end
	end

	return var_164_1
end

function var_0_0.getBattleCardsBy13480(arg_165_0, arg_165_1)
	local var_165_0 = Data._skillInfo[13480]
	local var_165_1 = {}
	local var_165_2 = arg_165_0:getBattleCardsByHp("P", 1000)

	for iter_165_0 = 1, #var_165_2 do
		local var_165_3 = var_165_2[iter_165_0]

		if var_165_3._atk >= 2400 then
			var_165_1[#var_165_1 + 1] = var_165_3
		end
	end

	return (arg_165_0:filterCanChangeToHandCards(B.filterNotSameNameCards(var_165_1, arg_165_1)))
end

function var_0_0.getBattleCardsBy13506(arg_166_0)
	local var_166_0 = Data._skillInfo[13506]
	local var_166_1 = {}
	local var_166_2 = {}
	local var_166_3 = B.filterMergeCards(arg_166_0:getBattleCardsByKeyword("R", var_166_0._refCards[1]))

	for iter_166_0 = 1, #var_166_3 do
		local var_166_4 = var_166_3[iter_166_0]._info._joinComponent

		for iter_166_1 = 1, #var_166_4 do
			local var_166_5 = var_166_4[iter_166_1]

			if var_166_5 == 0 then
				break
			end

			if var_166_5 > Data.INFO_ID_GROUP_SIZE_LARGE then
				if var_166_2[var_166_5] == nil and #arg_166_0:filterCanChangeToHandCards(arg_166_0:getBattleCardsByInfoId("P", var_166_5)) > 0 then
					var_166_2[var_166_5] = true
				end

				if var_166_2[var_166_5] ~= nil then
					var_166_1[#var_166_1 + 1] = var_166_3[iter_166_0]
				end
			end
		end
	end

	return (B.filterUniqueInfoIdCards(var_166_1))
end

function var_0_0.getBattleCardsBy13552(arg_167_0)
	local var_167_0 = Data._skillInfo[13552]
	local var_167_1 = {}
	local var_167_2 = B.filterInKeywordCards(arg_167_0:getBattleCardsByType("H", Data.CardType.monster), var_167_0._refCards[1])

	for iter_167_0 = 1, #var_167_2 do
		local var_167_3 = var_167_2[iter_167_0]

		if #arg_167_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_167_0:getBattleCardsByType("G", Data.CardType.monster), var_167_0._refCards[1]), var_167_3)) > 0 then
			var_167_1[#var_167_1 + 1] = var_167_3
		end
	end

	return var_167_1
end

function var_0_0.getBattleCardsBy13553(arg_168_0)
	local var_168_0 = Data._skillInfo[13553]
	local var_168_1 = {}
	local var_168_2 = B.filterInKeywordCards(arg_168_0:getBattleCardsByType("G", Data.CardType.monster), var_168_0._refCards[1])

	for iter_168_0 = 1, #var_168_2 do
		local var_168_3 = var_168_2[iter_168_0]

		if #B.filterNotSameNameCards(B.filterInKeywordCards(arg_168_0:getBattleCardsByType("P", Data.CardType.monster), var_168_0._refCards[1]), var_168_3) > 0 then
			var_168_1[#var_168_1 + 1] = var_168_3
		end
	end

	return var_168_1
end

function var_0_0.getBattleCardsBy13572(arg_169_0)
	local var_169_0 = Data._skillInfo[13572]
	local var_169_1 = {}
	local var_169_2 = B.filterInKeywordCards(arg_169_0:getBattleCardsByTypeGroup("G", {
		Data.CardType.magic,
		Data.CardType.trap
	}), var_169_0._refCards[1])

	for iter_169_0 = 1, #var_169_2 do
		local var_169_3 = var_169_2[iter_169_0]

		if #arg_169_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_169_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_169_0._refCards[1]), var_169_3)) > 0 then
			var_169_1[#var_169_1 + 1] = var_169_3
		end
	end

	return var_169_1
end

function var_0_0.getBattleCardsBy13607(arg_170_0, arg_170_1)
	local var_170_0 = Data._skillInfo[13607]
	local var_170_1 = {}
	local var_170_2 = arg_170_0:getBattleCardsByKeyword("BCSDH", var_170_0._refCards[1])

	for iter_170_0 = 1, #var_170_2 do
		local var_170_3 = var_170_2[iter_170_0]

		if #arg_170_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_170_0:getBattleCardsByKeyword("G", var_170_0._refCards[1]), arg_170_1), nil, nil, nil, var_170_3._status == BattleData.CardStatus.board) > 0 then
			var_170_1[#var_170_1 + 1] = var_170_3
		end
	end

	return var_170_1
end

function var_0_0.getBattleCardsBy13678(arg_171_0, arg_171_1)
	local var_171_0 = Data._skillInfo[13678]
	local var_171_1 = {}
	local var_171_2 = B.filterNotActionedCards(arg_171_0:getBattleCardsByKeyword("B", var_171_0._refCards[1]))

	for iter_171_0 = 1, #var_171_2 do
		local var_171_3 = var_171_2[iter_171_0]

		if #B.filterNotActionedCards(arg_171_0:getBattleCardsByType("B", Data.CardType.rare, Data.CARD_MAX_LEVEl, var_171_3)) > 0 then
			var_171_1[#var_171_1 + 1] = var_171_3
		end
	end

	return var_171_1
end

function var_0_0.getBattleCardsBy13703(arg_172_0, arg_172_1)
	local var_172_0 = Data._skillInfo[13703]
	local var_172_1 = {}
	local var_172_2 = B.filterInKeywordCards(arg_172_0:getBattleCardsByTypeGroup("CSD", {
		Data.CardType.magic,
		Data.CardType.trap
	}), var_172_0._refCards[1])

	for iter_172_0 = 1, #var_172_2 do
		local var_172_3 = var_172_2[iter_172_0]

		if #B.filterNotSameNamesCards(B.mergeTable({
			B.filterSustainableMagicCards(B.filterInKeywordCards(arg_172_0:getBattleCardsByType("P", Data.CardType.magic), var_172_0._refCards[1])),
			B.filterSustainableTrapCards(B.filterInKeywordCards(arg_172_0:getBattleCardsByType("P", Data.CardType.trap), var_172_0._refCards[1]))
		}), arg_172_0:getBattleCards("CSD")) > 0 then
			var_172_1[#var_172_1 + 1] = var_172_3
		end
	end

	return var_172_1
end

function var_0_0.getBattleCardsBy13859(arg_173_0)
	local var_173_0 = Data._skillInfo[13859]
	local var_173_1 = {}
	local var_173_2 = arg_173_0:getBattleCardsByKeyword("G", var_173_0._refCards[1])

	for iter_173_0 = 1, #var_173_2 do
		local var_173_3 = var_173_2[iter_173_0]

		if #arg_173_0:filterCanChangeToBoardCards(arg_173_0:getBattleCardsByKeyword("G", var_173_0._refCards[1], Data.CARD_MAX_LEVEL, var_173_3)) > 0 then
			var_173_1[#var_173_1 + 1] = var_173_3
		end
	end

	return var_173_1
end

function var_0_0.getBattleCardsBy13995(arg_174_0)
	local var_174_0 = Data._skillInfo[13995]
	local var_174_1 = {}
	local var_174_2 = arg_174_0:getBattleCardsByKeyword("R", var_174_0._refCards[1])

	for iter_174_0 = 1, #var_174_2 do
		local var_174_3 = var_174_2[iter_174_0]

		if #arg_174_0._opponent:getBattleCardsByNature("B", var_174_3._info._nature) > 0 then
			var_174_1[#var_174_1 + 1] = var_174_3
		end
	end

	return var_174_1
end

function var_0_0.getBattleCardsBy14176(arg_175_0)
	local var_175_0 = Data._skillInfo[14176]
	local var_175_1 = {}
	local var_175_2 = arg_175_0:getBattleCardsByCategory("L", var_175_0._refCards[1])

	for iter_175_0 = 1, #var_175_2 do
		local var_175_3 = var_175_2[iter_175_0]

		if var_175_3:getStar() <= var_175_0._val[1] then
			if #arg_175_0:filterCanChangeToHandCards({
				var_175_3
			}) > 0 then
				var_175_1[#var_175_1 + 1] = var_175_3
			end
		elseif #arg_175_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_175_0:getBattleCardsByMaxStar("P", var_175_0._val[1]), var_175_0._refCards[1])) > 0 then
			var_175_1[#var_175_1 + 1] = var_175_3
		end
	end

	return var_175_1
end

function var_0_0.getBattleCardsBy14263(arg_176_0, arg_176_1)
	local var_176_0 = Data._skillInfo[14263]
	local var_176_1 = {}

	for iter_176_0 = 1, #var_176_0._refCards do
		local var_176_2 = var_176_0._refCards[iter_176_0]

		if arg_176_1:isKeyword(var_176_2) then
			local var_176_3 = arg_176_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_176_0:getBattleCardsByType("P", Data.CardType.monster), var_176_2))

			B.appendTable(var_176_1, var_176_3)
		end
	end

	return var_176_1
end

function var_0_0.getBattleCardsBy14400(arg_177_0, arg_177_1)
	local var_177_0 = Data._skillInfo[14400]
	local var_177_1 = {}
	local var_177_2 = {}
	local var_177_3 = arg_177_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_177_0:getBattleCardsByMinStar("G", 0), var_177_0._refCards[1]))

	for iter_177_0 = 1, #var_177_3 do
		for iter_177_1 = iter_177_0 + 1, #var_177_3 do
			if var_177_3[iter_177_0]:getStar() + var_177_3[iter_177_1]:getStar() == arg_177_1:getStar() then
				if var_177_2[iter_177_0] == nil then
					var_177_2[iter_177_0] = true
					var_177_1[#var_177_1 + 1] = var_177_3[iter_177_0]
				end

				if var_177_2[iter_177_1] == nil then
					var_177_2[iter_177_1] = true
					var_177_1[#var_177_1 + 1] = var_177_3[iter_177_1]
				end
			end
		end
	end

	return var_177_1
end

function var_0_0.getCanEffectTrapCardsBySkills(arg_178_0, arg_178_1, arg_178_2, arg_178_3, arg_178_4)
	local var_178_0 = arg_178_0:getBattleCardsByType(arg_178_1, Data.CardType.trap, arg_178_3, arg_178_4)
	local var_178_1 = {}
	local var_178_2 = {}

	for iter_178_0 = 1, #var_178_0 do
		local var_178_3 = var_178_0[iter_178_0]
		local var_178_4, var_178_5 = var_178_3:hasSkills(arg_178_2)

		if var_178_4 and arg_178_0:canTrapEffect(var_178_3) then
			var_178_1[#var_178_1 + 1] = var_178_3

			for iter_178_1 = 1, #var_178_5 do
				var_178_2[#var_178_2 + 1] = var_178_5[iter_178_1]
			end
		end
	end

	return var_178_1, var_178_2
end

function var_0_0.getIsNeedDrop(arg_179_0)
	return #arg_179_0._handCards > Data.MAX_CARD_COUNT_IN_HAND_AFTER_DROP
end

function var_0_0.getIronyOrShieldBoardCards(arg_180_0)
	local var_180_0 = {}

	for iter_180_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		local var_180_1 = arg_180_0._boardCards[iter_180_0]
	end

	return var_180_0
end

function var_0_0.getMaskCard(arg_181_0)
	local var_181_0

	for iter_181_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		local var_181_1 = arg_181_0._boardCards[iter_181_0]
	end

	return var_181_0
end

function var_0_0.getCanFrozenCards(arg_182_0)
	local var_182_0 = arg_182_0:getBoardCards()
	local var_182_1 = 1

	while true do
		if var_182_1 > #var_182_0 then
			break
		end

		local var_182_2 = var_182_0[var_182_1]
		local var_182_3 = false

		for iter_182_0, iter_182_1 in ipairs(BattleData.NEGATIVE_FROZEN) do
			if var_182_2._negativeStatus[iter_182_1] ~= true then
				var_182_3 = true

				break
			end
		end

		if not var_182_3 then
			table.remove(var_182_0, var_182_1)
		else
			var_182_1 = var_182_1 + 1
		end
	end

	return var_182_0
end

function var_0_0.getCanIncSkillLevelCards(arg_183_0)
	local var_183_0 = arg_183_0:getBoardCards()
	local var_183_1 = 1

	while true do
		if var_183_1 > #var_183_0 then
			break
		end

		local var_183_2 = var_183_0[var_183_1]
		local var_183_3 = false

		for iter_183_0 = 1, #var_183_2._skills do
			local var_183_4 = var_183_2._skills[iter_183_0]

			if var_183_4._level < CardHelper.getSkillMaxLevel(var_183_4._id) then
				var_183_3 = true

				break
			end
		end

		if not var_183_3 then
			table.remove(var_183_0, var_183_1)
		else
			var_183_1 = var_183_1 + 1
		end
	end

	return var_183_0
end

function var_0_0.getHasUnderTypeCastedModeCards(arg_184_0, arg_184_1, arg_184_2)
	local var_184_0 = {}
	local var_184_1 = {}

	if arg_184_1 >= Data.SkillType.monsterSpell and arg_184_1 <= Data.SkillType.trapSpell then
		table.insert(var_184_1, Data.SkillMode.under_ruse_casted)

		if B.skillHasMode(arg_184_2, Data.SkillMode.using) then
			table.insert(var_184_1, Data.SkillMode.under_ruse_using_casted)
		end
	end

	if #var_184_1 > 0 then
		local var_184_2 = B.mergeTable({
			arg_184_0:getBoardCards(),
			arg_184_0._opponent:getBoardCards()
		})

		for iter_184_0 = 1, #var_184_2 do
			local var_184_3 = var_184_2[iter_184_0]

			for iter_184_1 = 1, #var_184_1 do
				if var_184_3:getSkillByMode(var_184_1[iter_184_1], 1) ~= nil then
					table.insert(var_184_0, var_184_3)

					break
				end
			end
		end
	end

	return var_184_0, var_184_1
end

function var_0_0.getUnderSkillTypeCards(arg_185_0, arg_185_1)
	local var_185_0 = arg_185_0:getAllCards()
	local var_185_1 = {}

	for iter_185_0 = 1, #var_185_0 do
		local var_185_2 = var_185_0[iter_185_0]

		for iter_185_1 = 1, #var_185_2._underSkills do
			local var_185_3 = var_185_2._underSkills[iter_185_1]

			if math.floor(var_185_3._sid / Data.INFO_ID_GROUP_SIZE) == arg_185_1 then
				table.insert(var_185_1, var_185_2)

				break
			end
		end
	end

	return var_185_1
end

function var_0_0.getMagicMarkCards(arg_186_0)
	local var_186_0 = arg_186_0:getBattleCards("BSD")
	local var_186_1 = {}
	local var_186_2 = 0

	for iter_186_0 = 1, #var_186_0 do
		local var_186_3 = var_186_0[iter_186_0]
		local var_186_4 = var_186_3:getBuffValue(true, BattleData.PositiveType.magicMark)

		if var_186_4 > 0 then
			var_186_2 = var_186_4 + var_186_2
			var_186_1[#var_186_1 + 1] = var_186_3
		end
	end

	return var_186_1, var_186_2
end

function var_0_0.getBCSDCardChoice(arg_187_0, arg_187_1)
	local var_187_0 = arg_187_0._opponent
	local var_187_1 = 0

	for iter_187_0 = 1, #arg_187_1 do
		if arg_187_1[iter_187_0] == arg_187_0._fieldCard then
			var_187_1 = var_187_1 + 2^((Data.MAX_CARD_COUNT_ON_COVER + Data.MAX_CARD_COUNT_ON_BOARD) * 2)
		elseif arg_187_1[iter_187_0] == var_187_0._fieldCard then
			var_187_1 = var_187_1 + 2^((Data.MAX_CARD_COUNT_ON_COVER + Data.MAX_CARD_COUNT_ON_BOARD) * 2 + 1)
		else
			local var_187_2 = arg_187_1[iter_187_0]._owner == arg_187_0 and 0 or Data.MAX_CARD_COUNT_ON_COVER + Data.MAX_CARD_COUNT_ON_BOARD

			if arg_187_1[iter_187_0]._status == BattleData.CardStatus.board then
				var_187_2 = var_187_2 + Data.MAX_CARD_COUNT_ON_COVER
			end

			var_187_1 = var_187_1 + 2^(arg_187_1[iter_187_0]._pos + var_187_2 - 1)
		end
	end

	return var_187_1
end

function var_0_0.getBCSDCards(arg_188_0, arg_188_1)
	local var_188_0 = arg_188_0._opponent
	local var_188_1 = {}

	for iter_188_0 = 1, Data.MAX_CARD_COUNT_ON_COVER do
		local var_188_2 = arg_188_0._coverCards[iter_188_0] or arg_188_0._showCards[iter_188_0]

		if var_188_2 ~= nil and band(arg_188_1, 2^(iter_188_0 - 1)) > 0 then
			var_188_1[#var_188_1 + 1] = var_188_2
		end
	end

	for iter_188_1 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		local var_188_3 = arg_188_0._boardCards[iter_188_1]

		if var_188_3 ~= nil and band(arg_188_1, 2^(iter_188_1 + Data.MAX_CARD_COUNT_ON_COVER - 1)) > 0 then
			var_188_1[#var_188_1 + 1] = var_188_3
		end
	end

	for iter_188_2 = 1, Data.MAX_CARD_COUNT_ON_COVER do
		local var_188_4 = var_188_0._coverCards[iter_188_2] or var_188_0._showCards[iter_188_2]

		if var_188_4 ~= nil and band(arg_188_1, 2^(Data.MAX_CARD_COUNT_ON_COVER + Data.MAX_CARD_COUNT_ON_BOARD + iter_188_2 - 1)) > 0 then
			var_188_1[#var_188_1 + 1] = var_188_4
		end
	end

	for iter_188_3 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		local var_188_5 = var_188_0._boardCards[iter_188_3]

		if var_188_5 ~= nil and band(arg_188_1, 2^(Data.MAX_CARD_COUNT_ON_COVER * 2 + Data.MAX_CARD_COUNT_ON_BOARD + iter_188_3 - 1)) > 0 then
			var_188_1[#var_188_1 + 1] = var_188_5
		end
	end

	if arg_188_0._fieldCard ~= nil and band(arg_188_1, 2^((Data.MAX_CARD_COUNT_ON_COVER + Data.MAX_CARD_COUNT_ON_BOARD) * 2)) > 0 then
		var_188_1[#var_188_1 + 1] = arg_188_0._fieldCard
	end

	if var_188_0._fieldCard ~= nil and band(arg_188_1, 2^((Data.MAX_CARD_COUNT_ON_COVER + Data.MAX_CARD_COUNT_ON_BOARD) * 2 + 1)) > 0 then
		var_188_1[#var_188_1 + 1] = var_188_0._fieldCard
	end

	return var_188_1
end

function var_0_0.getSingleBCSDCardChoice(arg_189_0, arg_189_1)
	local var_189_0 = 0

	for iter_189_0 = 1, #arg_189_1 do
		if arg_189_1[iter_189_0] == arg_189_0._fieldCard then
			var_189_0 = var_189_0 + 2^(Data.MAX_CARD_COUNT_ON_COVER + Data.MAX_CARD_COUNT_ON_BOARD + 1)
		else
			local var_189_1 = 0

			if arg_189_1[iter_189_0]._status == BattleData.CardStatus.board then
				var_189_1 = var_189_1 + Data.MAX_CARD_COUNT_ON_COVER
			end

			var_189_0 = var_189_0 + 2^(arg_189_1[iter_189_0]._pos + var_189_1 - 1)
		end
	end

	return var_189_0
end

function var_0_0.getSingleBCSDCards(arg_190_0, arg_190_1)
	local var_190_0 = arg_190_0._opponent
	local var_190_1 = {}

	for iter_190_0 = 1, Data.MAX_CARD_COUNT_ON_COVER do
		local var_190_2 = arg_190_0._coverCards[iter_190_0] or arg_190_0._showCards[iter_190_0]

		if var_190_2 ~= nil and band(arg_190_1, 2^(iter_190_0 - 1)) > 0 then
			var_190_1[#var_190_1 + 1] = var_190_2
		end
	end

	for iter_190_1 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_190_3 = arg_190_0._boardCards[iter_190_1]

		if var_190_3 ~= nil and band(arg_190_1, 2^(iter_190_1 + Data.MAX_CARD_COUNT_ON_COVER - 1)) > 0 then
			var_190_1[#var_190_1 + 1] = var_190_3
		end
	end

	if arg_190_0._fieldCard ~= nil and band(arg_190_1, 2^(Data.MAX_CARD_COUNT_ON_COVER + Data.MAX_CARD_COUNT_ON_BOARD + 1)) > 0 then
		var_190_1[#var_190_1 + 1] = arg_190_0._fieldCard
	end

	return var_190_1
end

function var_0_0.getBCardChoice(arg_191_0, arg_191_1)
	local var_191_0 = arg_191_0._opponent
	local var_191_1 = 0

	for iter_191_0 = 1, #arg_191_1 do
		local var_191_2 = arg_191_1[iter_191_0]._owner == arg_191_0 and 0 or Data.MAX_CARD_COUNT_ON_BOARD + 1

		var_191_1 = var_191_1 + 2^(arg_191_1[iter_191_0]._pos + var_191_2 - 1)
	end

	return var_191_1
end

function var_0_0.getBCards(arg_192_0, arg_192_1)
	local var_192_0 = arg_192_0._opponent
	local var_192_1 = {}

	for iter_192_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_192_2 = arg_192_0._boardCards[iter_192_0]

		if var_192_2 ~= nil and band(arg_192_1, 2^(iter_192_0 - 1)) > 0 then
			var_192_1[#var_192_1 + 1] = var_192_2
		end
	end

	for iter_192_1 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_192_3 = var_192_0._boardCards[iter_192_1]

		if var_192_3 ~= nil and band(arg_192_1, 2^(Data.MAX_CARD_COUNT_ON_BOARD + 1 + iter_192_1 - 1)) > 0 then
			var_192_1[#var_192_1 + 1] = var_192_3
		end
	end

	return var_192_1
end

function var_0_0.hasRareCard(arg_193_0, arg_193_1, arg_193_2, arg_193_3)
	for iter_193_0 = 1, #arg_193_0._rareCards do
		local var_193_0 = false

		if arg_193_1 == 40452 or arg_193_1 == 40568 then
			var_193_0 = arg_193_0._rareCards[iter_193_0]._infoId == arg_193_1
		else
			var_193_0 = arg_193_0._rareCards[iter_193_0]:isInfoId(arg_193_1)
		end

		if var_193_0 then
			local var_193_1 = arg_193_0._rareCards[iter_193_0]:hasSkillFast(3454) or arg_193_0._rareCards[iter_193_0]:hasSkillFast(6357) or arg_193_0._rareCards[iter_193_0]:hasSkillFast(2892) or arg_193_0._rareCards[iter_193_0]:hasSkillFast(9649)

			return arg_193_0:canSpecialSummon(arg_193_0._rareCards[iter_193_0], var_193_1 or arg_193_2, arg_193_3), arg_193_0._rareCards[iter_193_0]
		end
	end

	return false
end

function var_0_0.getAllRareInfoIds(arg_194_0)
	local var_194_0 = {}

	for iter_194_0, iter_194_1 in pairs(Data._rareInfo) do
		if iter_194_1._isHide == 0 then
			var_194_0[#var_194_0 + 1] = iter_194_0
		end
	end

	table.sort(var_194_0, function(arg_195_0, arg_195_1)
		return arg_195_0 < arg_195_1
	end)

	return var_194_0
end

function var_0_0.getAllMergeResultInfoIds(arg_196_0, arg_196_1, arg_196_2, arg_196_3)
	local var_196_0 = false

	if not arg_196_1 then
		arg_196_1 = "BHP"
		var_196_0 = true
	end

	local var_196_1 = {}
	local var_196_2 = arg_196_0:getBattleCards(arg_196_1)

	for iter_196_0 = 1, #var_196_2 do
		var_196_2[iter_196_0]:canMergeTo(var_196_1)
	end

	if not var_196_0 then
		local var_196_3 = arg_196_0:getBattleCards("R")

		for iter_196_1 = 1, #var_196_3 do
			local var_196_4 = var_196_3[iter_196_1]

			if var_196_4:canMergeFromSuperId() then
				var_196_1[var_196_4._infoId] = true
			end
		end
	else
		for iter_196_2, iter_196_3 in pairs(Data._rareInfo) do
			if #arg_196_0:getBattleCardsByInfoId("R", iter_196_2) == 0 and Data.canMergeFromSuperId(iter_196_3) then
				var_196_1[iter_196_2] = true
			end
		end
	end

	local var_196_5 = {}

	for iter_196_4, iter_196_5 in pairs(var_196_1) do
		if arg_196_2 ~= nil and arg_196_3 ~= nil then
			local var_196_6 = Data.getInfo(iter_196_4)

			if var_196_6._nature == arg_196_2 and var_196_6._keyword == arg_196_3 then
				var_196_5[#var_196_5 + 1] = iter_196_4
			end
		elseif arg_196_2 ~= nil then
			if Data.getInfo(iter_196_4)._nature == arg_196_2 then
				var_196_5[#var_196_5 + 1] = iter_196_4
			end
		elseif arg_196_3 ~= nil then
			if Data.getInfo(iter_196_4)._keyword == arg_196_3 then
				var_196_5[#var_196_5 + 1] = iter_196_4
			end
		else
			var_196_5[#var_196_5 + 1] = iter_196_4
		end
	end

	table.sort(var_196_5, function(arg_197_0, arg_197_1)
		return arg_197_0 < arg_197_1
	end)

	return var_196_5
end

function var_0_0.get2318MergeResultInfoIds(arg_198_0)
	local var_198_0 = Data._skillInfo[2318]
	local var_198_1 = B.filterUniqueInfoIdCards(arg_198_0:getBattleCardsByCategory("R", var_198_0._refCards[1]))
	local var_198_2 = {}

	for iter_198_0 = 1, #var_198_1 do
		var_198_2[#var_198_2 + 1] = var_198_1[iter_198_0]._infoId
	end

	return var_198_2
end

function var_0_0.get2982MergeResultInfoIds(arg_199_0)
	local var_199_0 = Data._skillInfo[2982]
	local var_199_1 = B.filterUniqueInfoIdCards(arg_199_0:getBattleCardsByKeyword("R", var_199_0._refCards[1]))
	local var_199_2 = {}

	for iter_199_0 = 1, #var_199_1 do
		var_199_2[#var_199_2 + 1] = var_199_1[iter_199_0]._infoId
	end

	return var_199_2
end

function var_0_0.get2985MergeResultInfoIds(arg_200_0)
	local var_200_0 = Data._skillInfo[2985]
	local var_200_1 = B.filterUniqueInfoIdCards(arg_200_0:getBattleCardsByKeyword("R", var_200_0._refCards[1]))
	local var_200_2 = {}

	for iter_200_0 = 1, #var_200_1 do
		var_200_2[#var_200_2 + 1] = var_200_1[iter_200_0]._infoId
	end

	return var_200_2
end

function var_0_0.get4207MergeResultInfoIds(arg_201_0)
	local var_201_0 = Data._skillInfo[4207]
	local var_201_1 = B.filterUniqueInfoIdCards(arg_201_0:getBattleCardsByKeyword("R", var_201_0._refCards[1]))
	local var_201_2 = {}

	for iter_201_0 = 1, #var_201_1 do
		var_201_2[#var_201_2 + 1] = var_201_1[iter_201_0]._infoId
	end

	return var_201_2
end

function var_0_0.get4290MergeResultInfoIds(arg_202_0)
	local var_202_0 = Data._skillInfo[4290]
	local var_202_1 = B.filterUniqueInfoIdCards(arg_202_0:getBattleCardsByJoinComponent("R", var_202_0._refCards[1]))
	local var_202_2 = {}

	for iter_202_0 = 1, #var_202_1 do
		var_202_2[#var_202_2 + 1] = var_202_1[iter_202_0]._infoId
	end

	return var_202_2
end

function var_0_0.get4511MergeResultInfoIds(arg_203_0)
	local var_203_0 = Data._skillInfo[4511]
	local var_203_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_203_0:getBattleCardsByKeyword("R", var_203_0._refCards[1])))
	local var_203_2 = {}

	for iter_203_0 = 1, #var_203_1 do
		var_203_2[#var_203_2 + 1] = var_203_1[iter_203_0]._infoId
	end

	return var_203_2
end

function var_0_0.get4526MergeResultInfoIds(arg_204_0)
	local var_204_0 = Data._skillInfo[4526]
	local var_204_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_204_0:getBattleCardsByCategory("R", var_204_0._refCards[1])))
	local var_204_2 = {}

	for iter_204_0 = 1, #var_204_1 do
		var_204_2[#var_204_2 + 1] = var_204_1[iter_204_0]._infoId
	end

	return var_204_2
end

function var_0_0.get4530MergeResultInfoIds(arg_205_0)
	local var_205_0 = Data._skillInfo[4530]
	local var_205_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_205_0:getBattleCardsByCategory("R", var_205_0._refCards[1])))
	local var_205_2 = {}

	for iter_205_0 = 1, #var_205_1 do
		var_205_2[#var_205_2 + 1] = var_205_1[iter_205_0]._infoId
	end

	return var_205_2
end

function var_0_0.get4735MergeResultInfoIds(arg_206_0)
	local var_206_0 = Data._skillInfo[4735]
	local var_206_1 = B.filterUniqueInfoIdCards(arg_206_0:getBattleCardsByCategory("R", var_206_0._refCards[1]))
	local var_206_2 = {}

	for iter_206_0 = 1, #var_206_1 do
		var_206_2[#var_206_2 + 1] = var_206_1[iter_206_0]._infoId
	end

	return var_206_2
end

function var_0_0.get4736MergeResultInfoIds(arg_207_0)
	local var_207_0 = Data._skillInfo[4736]
	local var_207_1 = B.filterUniqueInfoIdCards(arg_207_0:getBattleCardsByKeyword("R", var_207_0._refCards[1]))
	local var_207_2 = {}

	for iter_207_0 = 1, #var_207_1 do
		var_207_2[#var_207_2 + 1] = var_207_1[iter_207_0]._infoId
	end

	return var_207_2
end

function var_0_0.get4861MergeResultInfoIds(arg_208_0)
	local var_208_0 = Data._skillInfo[4861]
	local var_208_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_208_0:getBattleCardsByKeyword("R", var_208_0._refCards[1])))
	local var_208_2 = {}

	for iter_208_0 = 1, #var_208_1 do
		var_208_2[#var_208_2 + 1] = var_208_1[iter_208_0]._infoId
	end

	return var_208_2
end

function var_0_0.get4978MergeResultInfoIds(arg_209_0)
	local var_209_0 = Data._skillInfo[4978]
	local var_209_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_209_0:getBattleCardsByKeyword("R", var_209_0._refCards[1])))
	local var_209_2 = {}

	for iter_209_0 = 1, #var_209_1 do
		var_209_2[#var_209_2 + 1] = var_209_1[iter_209_0]._infoId
	end

	return var_209_2
end

function var_0_0.get4979MergeResultInfoIds(arg_210_0)
	local var_210_0 = Data._skillInfo[4979]
	local var_210_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_210_0:getBattleCardsByKeyword("R", var_210_0._refCards[1])))
	local var_210_2 = {}

	for iter_210_0 = 1, #var_210_1 do
		var_210_2[#var_210_2 + 1] = var_210_1[iter_210_0]._infoId
	end

	return var_210_2
end

function var_0_0.get4980MergeResultInfoIds(arg_211_0)
	local var_211_0 = Data._skillInfo[4980]
	local var_211_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_211_0:getBattleCardsByKeyword("R", var_211_0._refCards[1])))
	local var_211_2 = {}

	for iter_211_0 = 1, #var_211_1 do
		var_211_2[#var_211_2 + 1] = var_211_1[iter_211_0]._infoId
	end

	return var_211_2
end

function var_0_0.get5280MergeResultInfoIds(arg_212_0)
	local var_212_0 = Data._skillInfo[5280]
	local var_212_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_212_0:getBattleCardsByKeyword("R", var_212_0._refCards[1])))
	local var_212_2 = {}

	for iter_212_0 = 1, #var_212_1 do
		var_212_2[#var_212_2 + 1] = var_212_1[iter_212_0]._infoId
	end

	return var_212_2
end

function var_0_0.get5298MergeResultInfoIds(arg_213_0)
	local var_213_0 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_213_0:getBattleCards("R")))
	local var_213_1 = {}

	for iter_213_0 = 1, #var_213_0 do
		var_213_1[#var_213_1 + 1] = var_213_0[iter_213_0]._infoId
	end

	return var_213_1
end

function var_0_0.get543xMergeResultInfoIds(arg_214_0)
	local var_214_0 = Data._skillInfo[5430]
	local var_214_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_214_0:getBattleCardsByCategory("R", var_214_0._refCards[1])))
	local var_214_2 = {}

	for iter_214_0 = 1, #var_214_1 do
		var_214_2[#var_214_2 + 1] = var_214_1[iter_214_0]._infoId
	end

	return var_214_2
end

function var_0_0.get5470MergeResultInfoIds(arg_215_0)
	local var_215_0 = Data._skillInfo[5470]
	local var_215_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_215_0:getBattleCardsByCategory("R", var_215_0._refCards[1])))
	local var_215_2 = {}

	for iter_215_0 = 1, #var_215_1 do
		var_215_2[#var_215_2 + 1] = var_215_1[iter_215_0]._infoId
	end

	return var_215_2
end

function var_0_0.get5485MergeResultInfoIds(arg_216_0)
	local var_216_0 = Data._skillInfo[5485]
	local var_216_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_216_0:getBattleCardsByNature("R", var_216_0._refCards[1])))
	local var_216_2 = {}

	for iter_216_0 = 1, #var_216_1 do
		var_216_2[#var_216_2 + 1] = var_216_1[iter_216_0]._infoId
	end

	return var_216_2
end

function var_0_0.get5549MergeResultInfoIds(arg_217_0)
	local var_217_0 = Data._skillInfo[5549]
	local var_217_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_217_0:getBattleCardsByKeyword("R", var_217_0._refCards[1])))
	local var_217_2 = {}

	for iter_217_0 = 1, #var_217_1 do
		var_217_2[#var_217_2 + 1] = var_217_1[iter_217_0]._infoId
	end

	return var_217_2
end

function var_0_0.get7373MergeResultInfoIds(arg_218_0)
	local var_218_0 = Data._skillInfo[7373]
	local var_218_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_218_0:getBattleCardsByCategory("R", var_218_0._refCards[1])))
	local var_218_2 = {}

	for iter_218_0 = 1, #var_218_1 do
		var_218_2[#var_218_2 + 1] = var_218_1[iter_218_0]._infoId
	end

	return var_218_2
end

function var_0_0.get7544MergeResultInfoIds(arg_219_0)
	local var_219_0 = Data._skillInfo[7544]
	local var_219_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_219_0:getBattleCardsByCategory("R", var_219_0._refCards[1])))
	local var_219_2 = {}

	for iter_219_0 = 1, #var_219_1 do
		var_219_2[#var_219_2 + 1] = var_219_1[iter_219_0]._infoId
	end

	return var_219_2
end

function var_0_0.get7579MergeResultInfoIds(arg_220_0)
	local var_220_0 = Data._skillInfo[7579]
	local var_220_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_220_0:getBattleCardsByKeyword("R", var_220_0._refCards[1])))
	local var_220_2 = {}

	for iter_220_0 = 1, #var_220_1 do
		var_220_2[#var_220_2 + 1] = var_220_1[iter_220_0]._infoId
	end

	return var_220_2
end

function var_0_0.get7622MergeResultInfoIds(arg_221_0)
	local var_221_0 = Data._skillInfo[7622]
	local var_221_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_221_0:getBattleCardsByKeyword("R", var_221_0._refCards[1])))
	local var_221_2 = {}

	for iter_221_0 = 1, #var_221_1 do
		var_221_2[#var_221_2 + 1] = var_221_1[iter_221_0]._infoId
	end

	return var_221_2
end

function var_0_0.get7631MergeResultInfoIds(arg_222_0)
	local var_222_0 = Data._skillInfo[7631]
	local var_222_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_222_0:getBattleCardsByKeyword("R", var_222_0._refCards[1])))
	local var_222_2 = {}

	for iter_222_0 = 1, #var_222_1 do
		var_222_2[#var_222_2 + 1] = var_222_1[iter_222_0]._infoId
	end

	return var_222_2
end

function var_0_0.get7673MergeResultInfoIds(arg_223_0)
	local var_223_0 = Data._skillInfo[7673]
	local var_223_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_223_0:getBattleCardsByCategory("R", var_223_0._refCards[1])))
	local var_223_2 = {}

	for iter_223_0 = 1, #var_223_1 do
		var_223_2[#var_223_2 + 1] = var_223_1[iter_223_0]._infoId
	end

	return var_223_2
end

function var_0_0.get7693MergeResultInfoIds(arg_224_0)
	local var_224_0 = Data._skillInfo[7693]
	local var_224_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_224_0:getBattleCards("R")))
	local var_224_2 = {}

	for iter_224_0 = 1, #var_224_1 do
		if #var_224_1[iter_224_0]._info._joinComponent == 3 then
			var_224_2[#var_224_2 + 1] = var_224_1[iter_224_0]._infoId
		end
	end

	return var_224_2
end

function var_0_0.get7731MergeResultInfoIds(arg_225_0)
	local var_225_0 = Data._skillInfo[7731]
	local var_225_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_225_0:getBattleCardsByKeyword("R", var_225_0._refCards[1])))
	local var_225_2 = {}

	for iter_225_0 = 1, #var_225_1 do
		var_225_2[#var_225_2 + 1] = var_225_1[iter_225_0]._infoId
	end

	return var_225_2
end

function var_0_0.get7732MergeResultInfoIds(arg_226_0)
	local var_226_0 = Data._skillInfo[7732]
	local var_226_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_226_0:getBattleCardsByKeyword("R", var_226_0._refCards[1])))
	local var_226_2 = {}

	for iter_226_0 = 1, #var_226_1 do
		var_226_2[#var_226_2 + 1] = var_226_1[iter_226_0]._infoId
	end

	return var_226_2
end

function var_0_0.get7753MergeResultInfoIds(arg_227_0)
	local var_227_0 = Data._skillInfo[7753]
	local var_227_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_227_0:getBattleCardsByCategory("R", var_227_0._refCards[1])))
	local var_227_2 = {}

	for iter_227_0 = 1, #var_227_1 do
		var_227_2[#var_227_2 + 1] = var_227_1[iter_227_0]._infoId
	end

	return var_227_2
end

function var_0_0.get7785MergeResultInfoIds(arg_228_0)
	local var_228_0 = Data._skillInfo[7785]
	local var_228_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_228_0:getBattleCardsByKeyword("R", var_228_0._refCards[1])))
	local var_228_2 = {}

	for iter_228_0 = 1, #var_228_1 do
		var_228_2[#var_228_2 + 1] = var_228_1[iter_228_0]._infoId
	end

	return var_228_2
end

function var_0_0.get7831MergeResultInfoIds(arg_229_0)
	local var_229_0 = Data._skillInfo[7831]
	local var_229_1 = B.filterUniqueInfoIdCards(B.filterMergeCards(arg_229_0:getBattleCardsByCategory("R", var_229_0._refCards[1])))
	local var_229_2 = {}

	for iter_229_0 = 1, #var_229_1 do
		var_229_2[#var_229_2 + 1] = var_229_1[iter_229_0]._infoId
	end

	return var_229_2
end

function var_0_0.get13119MergeResultInfoIds(arg_230_0)
	local var_230_0 = Data._skillInfo[13119]
	local var_230_1 = B.filterUniqueInfoIdCards(arg_230_0:getBattleCardsByKeyword("R", var_230_0._refCards[1]))
	local var_230_2 = {}

	for iter_230_0 = 1, #var_230_1 do
		var_230_2[#var_230_2 + 1] = var_230_1[iter_230_0]._infoId
	end

	return var_230_2
end

function var_0_0.get14487MergeResultInfoIds(arg_231_0)
	local var_231_0 = Data._skillInfo[14487]
	local var_231_1 = B.filterUniqueInfoIdCards(arg_231_0:getBattleCardsByKeyword("R", var_231_0._refCards[1]))
	local var_231_2 = {}

	for iter_231_0 = 1, #var_231_1 do
		var_231_2[#var_231_2 + 1] = var_231_1[iter_231_0]._infoId
	end

	return var_231_2
end

function var_0_0.get14541MergeResultInfoIds(arg_232_0)
	local var_232_0 = Data._skillInfo[14541]
	local var_232_1 = B.filterUniqueInfoIdCards(arg_232_0:getBattleCardsByCategory("R", var_232_0._refCards[1]))
	local var_232_2 = {}

	for iter_232_0 = 1, #var_232_1 do
		var_232_2[#var_232_2 + 1] = var_232_1[iter_232_0]._infoId
	end

	return var_232_2
end

function var_0_0.getValidMergeResultInfoIdsByTriggerCard(arg_233_0, arg_233_1, arg_233_2)
	local var_233_0 = arg_233_1._skills[arg_233_2 or 1]

	if var_233_0._id == 3705 or var_233_0._id == 3850 or var_233_0._id == 2324 then
		local var_233_1 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(B.filterNoSkillInfoIds(arg_233_0:getAllMergeResultInfoIds("BH", var_233_1._refCards[1]), 3454), "BH", true, arg_233_1, false, false, false)
	elseif var_233_0._id == 2243 then
		local var_233_2 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:getAllMergeResultInfoIds("B"), "B", true, arg_233_1, false, false, false)
	elseif var_233_0._id == 2318 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get2318MergeResultInfoIds(), "BH", true, nil, false, false, false)
	elseif var_233_0._id == 2982 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get2982MergeResultInfoIds(), "H", false, arg_233_1, false, false, false)
	elseif var_233_0._id == 2985 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get2985MergeResultInfoIds(), "G", false, arg_233_1, false, false, false)
	elseif var_233_0._id == 4048 or var_233_0._id == 7144 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:getAllMergeResultInfoIds("BH"), "BH", true, nil, false, false, false)
	elseif var_233_0._id == 4171 or var_233_0._id == 4497 then
		local var_233_3 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(var_233_3._refCards, "BHP", false, nil, false, false, false)
	elseif var_233_0._id == 4186 then
		local var_233_4 = Data._skillInfo[4186]

		return arg_233_0:getValidMergeResultInfoIds(var_233_4._refCards, "B", true, nil, true, false, false)
	elseif var_233_0._id == 4207 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4207MergeResultInfoIds(), "BG", true, nil, true, false, false)
	elseif var_233_0._id == 4290 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4290MergeResultInfoIds(), "BGH", true, nil, true, true, false)
	elseif var_233_0._id == 4305 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:getAllMergeResultInfoIds("B"), "B", true, nil, false, false, false)
	elseif var_233_0._id == 4454 then
		local var_233_5 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(var_233_5._refCards, "HP", false, nil, false, false, false)
	elseif var_233_0._id == 4511 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4511MergeResultInfoIds(), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 4514 then
		local var_233_6 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(var_233_6._refCards, "BHP", true, nil, true, true, false)
	elseif var_233_0._id == 4521 then
		local var_233_7 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(var_233_7._refCards, "BL", true, nil, false, false, false)
	elseif var_233_0._id == 4526 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4526MergeResultInfoIds(), "HBG", true, nil, false, false, false)
	elseif var_233_0._id == 4530 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4530MergeResultInfoIds(), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 4735 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4735MergeResultInfoIds(), "BH", false, nil, false, false, false)
	elseif var_233_0._id == 4736 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4736MergeResultInfoIds(), "HG", false, nil, false, false, false)
	elseif var_233_0._id == 4740 then
		local var_233_8 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(var_233_8._refCards, "BH", false, nil, false, false, false)
	elseif var_233_0._id == 4748 then
		local var_233_9 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:getAllMergeResultInfoIds("bB"), "bB", false, nil, false, false, false)
	elseif var_233_0._id == 4836 then
		local var_233_10 = Data._skillInfo[var_233_0._id]

		return B.filterUniqueInfoIds(B.mergeTable({
			arg_233_0:getValidMergeResultInfoIds(arg_233_0:getAllMergeResultInfoIds("H"), "H", true, nil, false, false, false),
			arg_233_0:getValidMergeResultInfoIds(arg_233_0:getAllMergeResultInfoIds("HBGg", nil, var_233_10._refCards[1]), "HBGg", true, nil, false, false, false)
		}))
	elseif var_233_0._id == 4861 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4861MergeResultInfoIds(), "HBG", true, nil, true, true, false)
	elseif var_233_0._id == 4957 then
		local var_233_11 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(var_233_11._refCards, "HBb", false, nil, false, false, false)
	elseif var_233_0._id == 4978 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4978MergeResultInfoIds(), "HBb", true, false, false, false, false)
	elseif var_233_0._id == 4979 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4979MergeResultInfoIds(), #arg_233_0._opponent:getBattleCardsByType("B", Data.CardType.rare) > 0 and "HBP" or "HB", true, nil, false, false, false)
	elseif var_233_0._id == 4980 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get4980MergeResultInfoIds(), "HB", true, arg_233_1._binds[1], false, false, false)
	elseif var_233_0._id == 5244 then
		local var_233_12 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:getAllMergeResultInfoIds("B", nil, var_233_12._refCards[1]), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 5280 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get5280MergeResultInfoIds(), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 5298 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get5298MergeResultInfoIds(), "G", true, nil, false, false, false)
	elseif var_233_0._id == 5430 or var_233_0._id == 5431 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get543xMergeResultInfoIds(), var_233_0._id == 5430 and "HB" or "G", true, nil, false, false, false)
	elseif var_233_0._id == 5452 then
		local var_233_13 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(var_233_13._refCards, "G", true, nil, false, false, false)
	elseif var_233_0._id == 5470 then
		local var_233_14 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get5470MergeResultInfoIds(), "BG", true, nil, false, false, false)
	elseif var_233_0._id == 5485 then
		local var_233_15 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get5485MergeResultInfoIds(), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 5544 then
		local var_233_16 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(var_233_16._refCards, "G", true, nil, false, false, false)
	elseif var_233_0._id == 5549 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get5549MergeResultInfoIds(), "BG", true, nil, false, false, false)
	elseif var_233_0._id == 7373 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7373MergeResultInfoIds(), "HBG", false, nil, false, false, false)
	elseif var_233_0._id == 7544 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7544MergeResultInfoIds(), "BGL", false, nil, false, false, false)
	elseif var_233_0._id == 7579 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7579MergeResultInfoIds(), "gG", false, nil, true, true, false)
	elseif var_233_0._id == 7622 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7622MergeResultInfoIds(), "bB", false, nil, false, false, false)
	elseif var_233_0._id == 7631 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7631MergeResultInfoIds(), "HBb", false, nil, false, false, false)
	elseif var_233_0._id == 7673 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7673MergeResultInfoIds(), "HB", false, nil, false, false, false)
	elseif var_233_0._id == 7674 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7673MergeResultInfoIds(), "G", false, nil, false, false, false)
	elseif var_233_0._id == 7693 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7693MergeResultInfoIds(), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 7731 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7731MergeResultInfoIds(), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 7732 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7732MergeResultInfoIds(), "P", true, nil, false, false, false)
	elseif var_233_0._id == 7753 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7753MergeResultInfoIds(), "HB", false, nil, false, false, false)
	elseif var_233_0._id == 7785 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7785MergeResultInfoIds(), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 7831 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get7831MergeResultInfoIds(), "HB", false, nil, false, false, false)
	elseif var_233_0._id == 9796 then
		return arg_233_0:getValidMergeResultInfoIds({
			arg_233_1._infoId
		}, "HBG", false, nil, false, false, false)
	elseif var_233_0._id == 9868 then
		return arg_233_0:getValidMergeResultInfoIds({
			arg_233_1._infoId
		}, "B", false, nil, false, false, false)
	elseif var_233_0._id == 13119 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get13119MergeResultInfoIds(), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 13259 then
		return arg_233_0:getValidMergeResultInfoIds({
			arg_233_1._infoId
		}, "Bb", true, nil, false, false, false)
	elseif var_233_0._id == 13264 then
		return arg_233_0:getValidMergeResultInfoIds({
			arg_233_1._infoId
		}, "B", true, nil, false, false, false)
	elseif var_233_0._id == 13292 then
		return arg_233_0:getValidMergeResultInfoIds({
			arg_233_1._infoId
		}, "[HB", true, nil, false, false, false)
	elseif var_233_0._id == 13348 then
		local var_233_17 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(var_233_17._refCards, "P", false, nil, false, false, false)
	elseif var_233_0._id == 13718 then
		return arg_233_0:getValidMergeResultInfoIds({
			arg_233_1._infoId
		}, "B", true, nil, false, false, false)
	elseif var_233_0._id == 13736 then
		local var_233_18 = Data._skillInfo[var_233_0._id]

		return arg_233_0:getValidMergeResultInfoIds(var_233_18._refCards, "HB", true, arg_233_1, false, false, false)
	elseif var_233_0._id == 13850 then
		return arg_233_0:getValidMergeResultInfoIds({
			arg_233_1._infoId
		}, "HB", true, nil, false, false, false)
	elseif var_233_0._id == 13920 then
		return arg_233_0:getValidMergeResultInfoIds({
			arg_233_1._infoId
		}, "HB", true, nil, false, true, false)
	elseif var_233_0._id == 13989 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:getAllMergeResultInfoIds("BH"), "BH", true, nil, false, false, false)
	elseif var_233_0._id == 14390 or var_233_0._id == 14519 then
		return arg_233_0:getValidMergeResultInfoIds({
			arg_233_1._infoId
		}, "HB", true, nil, false, false, false)
	elseif var_233_0._id == 14487 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get14487MergeResultInfoIds(), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 14541 then
		return arg_233_0:getValidMergeResultInfoIds(arg_233_0:get14541MergeResultInfoIds(), "HB", true, nil, false, false, false)
	elseif var_233_0._id == 14555 then
		return arg_233_0:getValidMergeResultInfoIds({
			arg_233_1._infoId
		}, "BG", true, nil, false, false, false)
	else
		return {}
	end
end

function var_0_0.getValidMergeResultInfoIds(arg_234_0, arg_234_1, arg_234_2, arg_234_3, arg_234_4, arg_234_5, arg_234_6, arg_234_7)
	local var_234_0 = {}

	for iter_234_0 = 1, #arg_234_1 do
		if arg_234_0:isValidMergeResult(arg_234_1[iter_234_0], arg_234_2, arg_234_3, arg_234_4, arg_234_5, arg_234_6, arg_234_7) then
			var_234_0[#var_234_0 + 1] = arg_234_1[iter_234_0]
		end
	end

	return var_234_0
end

function var_0_0.getMergeComponentIds(arg_235_0, arg_235_1)
	local var_235_0 = Data._rareInfo[arg_235_1]
	local var_235_1 = {}

	for iter_235_0 = 1, #var_235_0._joinComponent do
		local var_235_2 = var_235_0._joinComponent[iter_235_0]

		if var_235_1[var_235_2] == nil then
			var_235_1[var_235_2] = 1
		else
			var_235_1[var_235_2] = var_235_1[var_235_2] + 1
		end
	end

	return var_235_1
end

function var_0_0.isValidMergeResultByTriggerCard(arg_236_0, arg_236_1, arg_236_2, arg_236_3)
	local var_236_0 = arg_236_2._skills[arg_236_3 or 1]

	if var_236_0._id == 3705 or var_236_0._id == 3850 or var_236_0._id == 2324 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BH", true, arg_236_2, false, false, false)
	elseif var_236_0._id == 3874 then
		return arg_236_0:isValidMergeResult(arg_236_1, "B", true, nil, false, false, false)
	elseif var_236_0._id == 3885 then
		return arg_236_0:isValidMergeResult(arg_236_1, "B", true, nil, false, true, false)
	elseif var_236_0._id == 2243 then
		return arg_236_0:isValidMergeResult(arg_236_1, "B", true, arg_236_2, false, false, false)
	elseif var_236_0._id == 2318 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BH", true, nil, false, false, false)
	elseif var_236_0._id == 2982 then
		return arg_236_0:isValidMergeResult(arg_236_1, "H", false, arg_236_2, false, false, false)
	elseif var_236_0._id == 2985 then
		return arg_236_0:isValidMergeResult(arg_236_1, "G", false, arg_236_2, false, false, false)
	elseif var_236_0._id == 2375 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BH", true, nil, false, true, false)
	elseif var_236_0._id == 4048 or var_236_0._id == 7144 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BH", true, nil, false, false, false)
	elseif var_236_0._id == 4171 or var_236_0._id == 4497 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BHP", false, nil, false, false, false)
	elseif var_236_0._id == 4186 then
		return arg_236_0:isValidMergeResult(arg_236_1, "B", true, nil, true, false, false)
	elseif var_236_0._id == 4207 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BG", true, nil, true, false, false)
	elseif var_236_0._id == 4290 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BGH", true, nil, true, true, false)
	elseif var_236_0._id == 4305 then
		return arg_236_0:isValidMergeResult(arg_236_1, "B", true, nil, false, false, false)
	elseif var_236_0._id == 4454 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HP", false, nil, false, false, false)
	elseif var_236_0._id == 4511 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 4514 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BHP", true, nil, true, true, false)
	elseif var_236_0._id == 4521 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BL", true, nil, false, false, false)
	elseif var_236_0._id == 4526 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HBG", true, nil, false, false, false)
	elseif var_236_0._id == 4530 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 4735 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BH", false, nil, false, false, false)
	elseif var_236_0._id == 4736 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HG", false, nil, false, false, false)
	elseif var_236_0._id == 4740 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BH", false, nil, false, false, false)
	elseif var_236_0._id == 4748 then
		local var_236_1, var_236_2 = arg_236_0:hasRareCard(arg_236_1, false, false)

		if not var_236_1 then
			return false
		end

		local var_236_3 = arg_236_0:getMergeCandidates(var_236_2, "bB", false, nil)

		return arg_236_0:isValidMergeComponents(var_236_2, var_236_3, false, false)
	elseif var_236_0._id == 4836 then
		local var_236_4 = Data._skillInfo[var_236_0._id]

		if Data._rareInfo[arg_236_1]._keyword == var_236_4._refCards[1] then
			return arg_236_0:isValidMergeResult(arg_236_1, "HBGg", true, nil, false, false, false)
		else
			return arg_236_0:isValidMergeResult(arg_236_1, "H", true, nil, false, false, false)
		end
	elseif var_236_0._id == 4861 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HBG", true, nil, true, true, false)
	elseif var_236_0._id == 4957 then
		local var_236_5, var_236_6 = arg_236_0:hasRareCard(arg_236_1, false, false)

		if not var_236_5 then
			return false
		end

		local var_236_7 = B.filterPlayerNoShieldCards(arg_236_0:getMergeCandidates(var_236_6, "HBb", false, nil), arg_236_0._opponent, BattleData.PositiveType.shieldMagic)

		return arg_236_0:isValidMergeComponents(var_236_6, var_236_7, false, false)
	elseif var_236_0._id == 4978 then
		local var_236_8, var_236_9 = arg_236_0:hasRareCard(arg_236_1, false, false)

		if not var_236_8 then
			return false
		end

		local var_236_10 = arg_236_0:getMergeCandidates(var_236_9, "HBb", true, nil)

		if #B.filterSameOwnerCards(var_236_10, var_236_9) == 0 then
			return false
		end

		return arg_236_0:isValidMergeComponents(var_236_9, var_236_10, nil, false)
	elseif var_236_0._id == 4979 then
		return arg_236_0:isValidMergeResult(arg_236_1, #arg_236_0._opponent:getBattleCardsByType("B", Data.CardType.rare) > 0 and "HBP" or "HB", true, nil, false, false, false)
	elseif var_236_0._id == 4980 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, arg_236_2._binds[1], false, false, false)
	elseif var_236_0._id == 5244 then
		return arg_236_0:isValidMergeResult(arg_236_1, "B", true, nil, false, false, false)
	elseif var_236_0._id == 5280 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 5298 then
		return arg_236_0:isValidMergeResult(arg_236_1, "G", true, nil, false, false, false)
	elseif var_236_0._id == 5430 or var_236_0._id == 5431 then
		return arg_236_0:isValidMergeResult(arg_236_1, var_236_0._id == 5430 and "HB" or "G", true, nil, false, false, false)
	elseif var_236_0._id == 5452 then
		return arg_236_0:isValidMergeResult(arg_236_1, "G", true, nil, false, false, false)
	elseif var_236_0._id == 5470 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BG", true, nil, false, false, false)
	elseif var_236_0._id == 5485 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 5544 then
		return arg_236_0:isValidMergeResult(arg_236_1, "G", true, nil, false, false, false)
	elseif var_236_0._id == 5549 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BG", true, nil, false, false, false)
	elseif var_236_0._id == 7373 then
		return arg_236_0:isValidMergeResult(arg_236_1, (Data._rareInfo[arg_236_1]._keyword == Data._skillInfo[7373]._refCards[2] or B.tableContain(Data._rareInfo[arg_236_1]._skillId, 2987)) and "HBG" or "HB", false, nil, false, false, false)
	elseif var_236_0._id == 7544 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BGL", false, nil, false, false, false)
	elseif var_236_0._id == 7579 then
		return arg_236_0:isValidMergeResult(arg_236_1, "gG", false, nil, true, true, false)
	elseif var_236_0._id == 7622 then
		local var_236_11, var_236_12 = arg_236_0:hasRareCard(arg_236_1, false, false)

		if not var_236_11 then
			return false
		end

		local var_236_13 = arg_236_0:getMergeCandidates(var_236_12, "bB", false, nil)

		return arg_236_0:isValidMergeComponents(var_236_12, var_236_13, false, false)
	elseif var_236_0._id == 7631 then
		local var_236_14, var_236_15 = arg_236_0:hasRareCard(arg_236_1, false, false)

		if not var_236_14 then
			return false
		end

		local var_236_16 = arg_236_0:getMergeCandidates(var_236_15, "HBb", false, nil)

		return arg_236_0:isValidMergeComponents(var_236_15, var_236_16, false, false)
	elseif var_236_0._id == 7673 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", false, nil, false, false, false)
	elseif var_236_0._id == 7674 then
		return arg_236_0:isValidMergeResult(arg_236_1, "G", false, nil, false, false, false)
	elseif var_236_0._id == 7693 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 7731 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 7732 then
		return arg_236_0:isValidMergeResult(arg_236_1, "P", true, nil, false, false, false)
	elseif var_236_0._id == 7753 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", false, nil, false, false, false)
	elseif var_236_0._id == 7785 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 7831 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", false, nil, false, false, false)
	elseif var_236_0._id == 9796 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HBG", false, nil, false, false, false)
	elseif var_236_0._id == 9868 then
		local var_236_17, var_236_18 = arg_236_0:hasRareCard(arg_236_1, false, false)

		if not var_236_17 then
			return false
		end

		local var_236_19 = B.filterNotActionedCards(arg_236_0:getMergeCandidates(var_236_18, "B", false, nil))

		return arg_236_0:isValidMergeComponents(var_236_18, var_236_19, nil, false)
	elseif var_236_0._id == 13119 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 13259 then
		return arg_236_0:isValidMergeResult(arg_236_1, "Bb", true, nil, false, false, false)
	elseif var_236_0._id == 13264 then
		return arg_236_0:isValidMergeResult(arg_236_1, "B", true, nil, false, false, false)
	elseif var_236_0._id == 13292 then
		return arg_236_0:isValidMergeResult(arg_236_1, "[HB", true, nil, false, false, false)
	elseif var_236_0._id == 13348 then
		return arg_236_0:isValidMergeResult(arg_236_1, "P", false, nil, false, false, false)
	elseif var_236_0._id == 13718 then
		return arg_236_0:isValidMergeResult(arg_236_1, "B", true, nil, false, false, false)
	elseif var_236_0._id == 13736 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, arg_236_2, false, false, false)
	elseif var_236_0._id == 13850 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 13920 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, true, false)
	elseif var_236_0._id == 13989 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, true, false)
	elseif var_236_0._id == 14390 or var_236_0._id == 14519 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 14487 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 14541 then
		return arg_236_0:isValidMergeResult(arg_236_1, "HB", true, nil, false, false, false)
	elseif var_236_0._id == 14555 then
		return arg_236_0:isValidMergeResult(arg_236_1, "BG", true, nil, false, false, false)
	else
		return false
	end
end

function var_0_0.isValidMergeResult(arg_237_0, arg_237_1, arg_237_2, arg_237_3, arg_237_4, arg_237_5, arg_237_6, arg_237_7)
	arg_237_6 = arg_237_6 or arg_237_1 == 40658

	local var_237_0, var_237_1 = arg_237_0:hasRareCard(arg_237_1, arg_237_5, arg_237_6)

	if not var_237_0 then
		return false
	end

	local var_237_2 = arg_237_0:getMergeCandidates(var_237_1, arg_237_2, arg_237_3, arg_237_4)

	return arg_237_0:isValidMergeComponents(var_237_1, var_237_2, arg_237_4, arg_237_7)
end

function var_0_0.getMergeCandidatesByTriggerCard(arg_238_0, arg_238_1, arg_238_2, arg_238_3)
	local var_238_0 = arg_238_2._skills[arg_238_3 or 1]

	if var_238_0._id == 3705 or var_238_0._id == 3850 or var_238_0._id == 2324 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BH", true, arg_238_2)
	elseif var_238_0._id == 3874 or var_238_0._id == 3885 then
		return arg_238_0:getMergeCandidates(arg_238_1, "B", true, nil)
	elseif var_238_0._id == 2243 then
		return arg_238_0:getMergeCandidates(arg_238_1, "B", true, arg_238_2)
	elseif var_238_0._id == 2318 or var_238_0._id == 2375 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BH", true, nil)
	elseif var_238_0._id == 2982 then
		return arg_238_0:getMergeCandidates(arg_238_1, "H", false, arg_238_2)
	elseif var_238_0._id == 2985 then
		return arg_238_0:getMergeCandidates(arg_238_1, "G", false, arg_238_2)
	elseif var_238_0._id == 4048 or var_238_0._id == 7144 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BH", true, nil)
	elseif var_238_0._id == 4171 or var_238_0._id == 4497 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BHP", false, nil)
	elseif var_238_0._id == 4186 then
		return arg_238_0:getMergeCandidates(arg_238_1, "B", true, nil)
	elseif var_238_0._id == 4207 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BG", true, nil)
	elseif var_238_0._id == 4290 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BGH", true, nil)
	elseif var_238_0._id == 4305 then
		return arg_238_0:getMergeCandidates(arg_238_1, "B", true, nil)
	elseif var_238_0._id == 4454 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HP", false, nil)
	elseif var_238_0._id == 4511 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 4514 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BHP", true, nil)
	elseif var_238_0._id == 4521 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BL", true, nil)
	elseif var_238_0._id == 4526 or var_238_0._id == 4861 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HBG", true, nil)
	elseif var_238_0._id == 4530 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 4735 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BH", false, nil)
	elseif var_238_0._id == 4736 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HG", false, nil)
	elseif var_238_0._id == 4740 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BH", false, nil)
	elseif var_238_0._id == 4748 or var_238_0._id == 7622 then
		return arg_238_0:getMergeCandidates(arg_238_1, "bB", false, nil)
	elseif var_238_0._id == 4836 then
		local var_238_1 = Data._skillInfo[var_238_0._id]

		if arg_238_1:isKeyword(var_238_1._refCards[1]) then
			return arg_238_0:getMergeCandidates(arg_238_1, "HBGg", true, nil)
		else
			return arg_238_0:getMergeCandidates(arg_238_1, "H", true, nil)
		end
	elseif var_238_0._id == 4957 then
		return B.filterPlayerNoShieldCards(arg_238_0:getMergeCandidates(arg_238_1, "HBb", false, nil), arg_238_0._opponent, BattleData.PositiveType.shieldMagic)
	elseif var_238_0._id == 4978 or var_238_0._id == 7631 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HBb", true, nil)
	elseif var_238_0._id == 4979 then
		return arg_238_0:getMergeCandidates(arg_238_1, #arg_238_0._opponent:getBattleCardsByType("B", Data.CardType.rare) > 0 and "HBP" or "HB", true, nil)
	elseif var_238_0._id == 4980 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, arg_238_2._binds[1])
	elseif var_238_0._id == 5244 then
		return arg_238_0:getMergeCandidates(arg_238_1, "B", true, nil)
	elseif var_238_0._id == 5280 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 5298 then
		return arg_238_0:getMergeCandidates(arg_238_1, "G", true, nil)
	elseif var_238_0._id == 5430 or var_238_0._id == 5431 then
		return arg_238_0:getMergeCandidates(arg_238_1, var_238_0._id == 5430 and "HB" or "G", true, nil)
	elseif var_238_0._id == 5452 then
		return arg_238_0:getMergeCandidates(arg_238_1, "G", true, nil)
	elseif var_238_0._id == 5470 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BG", true, nil)
	elseif var_238_0._id == 5485 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 5544 then
		return arg_238_0:getMergeCandidates(arg_238_1, "G", true, nil)
	elseif var_238_0._id == 5549 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BG", true, nil)
	elseif var_238_0._id == 7373 then
		return arg_238_0:getMergeCandidates(arg_238_1, arg_238_1:isKeyword(Data._skillInfo[7373]._refCards[2]) and "HBG" or "HB", false, nil)
	elseif var_238_0._id == 7544 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BGL", false, nil)
	elseif var_238_0._id == 7579 then
		return arg_238_0:getMergeCandidates(arg_238_1, "gG", false, nil)
	elseif var_238_0._id == 7673 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", false, nil)
	elseif var_238_0._id == 7674 then
		return arg_238_0:getMergeCandidates(arg_238_1, "G", false, nil)
	elseif var_238_0._id == 7693 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 7731 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 7753 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", false, nil)
	elseif var_238_0._id == 7732 then
		return arg_238_0:getMergeCandidates(arg_238_1, "P", true, nil)
	elseif var_238_0._id == 7785 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 7831 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", false, nil)
	elseif var_238_0._id == 9796 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HBG", false, nil)
	elseif var_238_0._id == 9868 then
		return B.filterNotActionedCards(arg_238_0:getMergeCandidates(arg_238_1, "B", false, nil))
	elseif var_238_0._id == 13119 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 13259 then
		return arg_238_0:getMergeCandidates(arg_238_1, "Bb", true, nil)
	elseif var_238_0._id == 13264 then
		return arg_238_0:getMergeCandidates(arg_238_1, "B", true, nil)
	elseif var_238_0._id == 13292 then
		return arg_238_0:getMergeCandidates(arg_238_1, "[HB", true, nil)
	elseif var_238_0._id == 13348 then
		return arg_238_0:getMergeCandidates(arg_238_1, "P", false, nil)
	elseif var_238_0._id == 13718 then
		return arg_238_0:getMergeCandidates(arg_238_1, "B", true, nil)
	elseif var_238_0._id == 13736 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, arg_238_2)
	elseif var_238_0._id == 13850 or var_238_0._id == 13920 or var_238_0._id == 13989 or var_238_0._id == 14390 or var_238_0._id == 14519 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 14487 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 14541 then
		return arg_238_0:getMergeCandidates(arg_238_1, "HB", true, nil)
	elseif var_238_0._id == 14555 then
		return arg_238_0:getMergeCandidates(arg_238_1, "BG", true, nil)
	else
		return {}
	end
end

function var_0_0.getMergeCandidates(arg_239_0, arg_239_1, arg_239_2, arg_239_3, arg_239_4)
	local var_239_0 = arg_239_0:getMergeComponentIds(arg_239_1._infoId)

	if arg_239_1:isKeyword(Data._skillInfo[7585]._refCards[1]) and arg_239_1._owner:hasBattleCardsByCanCastMagicSkillFast("S", 7585) then
		var_239_0 = {
			[504] = 2
		}
	end

	local var_239_1 = {}

	for iter_239_0, iter_239_1 in pairs(var_239_0) do
		var_239_1[#var_239_1 + 1] = iter_239_0
	end

	table.sort(var_239_1, function(arg_240_0, arg_240_1)
		return arg_240_0 < arg_240_1
	end)

	local var_239_2 = {}
	local var_239_3 = {}

	if arg_239_3 and not arg_239_1:hasSkills({
		3087
	}) and arg_239_1:canMergeFromInfoId() then
		local var_239_4 = B.filterCanBeSacrificedCards(arg_239_0:getBattleCardsBySkillFast(arg_239_2, 3072), true, false)

		for iter_239_2 = 1, #var_239_4 do
			if (arg_239_4 == nil or var_239_4[iter_239_2] == arg_239_4) and not var_239_3[var_239_4[iter_239_2]._id] then
				var_239_2[#var_239_2 + 1] = var_239_4[iter_239_2]
				var_239_3[var_239_4[iter_239_2]._id] = true
			end
		end
	end

	for iter_239_3 = 1, #var_239_1 do
		local var_239_5 = var_239_1[iter_239_3]
		local var_239_6

		if var_239_5 > Data.INFO_ID_GROUP_SIZE_LARGE then
			var_239_6 = arg_239_0:getBattleCardsByInfoId(arg_239_2, var_239_5)

			if var_239_5 == 10004 and arg_239_1:isInfoId(40494) then
				var_239_6 = arg_239_0:getBattleCardsByInfoId(arg_239_2, var_239_5)

				B.appendTable(var_239_6, arg_239_0:getBattleCardsByInfoId(arg_239_2, 10006))
			end
		else
			var_239_6 = B.filterInSuperIdCards(arg_239_0:getBattleCards(arg_239_2), var_239_5)

			if var_239_5 == 3003 and arg_239_1:isInfoId(40033) then
				var_239_6 = B.filterInStarCards(B.filterNormalCards(var_239_6), 6)
			elseif var_239_5 == 3008 and arg_239_1:isInfoId(40033) then
				var_239_6 = B.filterNormalCards(var_239_6)
			elseif var_239_5 == 5010 and arg_239_1:isInfoId(40116) then
				var_239_6 = B.filterInCategoryCards(var_239_6, 23)
			elseif var_239_5 == 5003 and arg_239_1:isInfoId(40168) then
				var_239_6 = B.filterInKeywordCards(var_239_6, 103)
			elseif var_239_5 == 3104 and arg_239_1:isInInfoIdGroup({
				40272,
				40276
			}) then
				var_239_6 = B.filterNormalCards(var_239_6)
			elseif var_239_5 == 5002 and arg_239_1:isInfoId(40274) then
				var_239_6 = B.filterLessThanStarCards(var_239_6, 4)
			elseif var_239_5 == 2004 and arg_239_1:isInfoId(40364) then
				var_239_6 = B.filterMoreThanStarCards(var_239_6, 6)
			elseif var_239_5 == 2006 and arg_239_1:isInfoId(40400) then
				var_239_6 = B.filterSyncCards(B.filterInNatureCards(var_239_6, 3), true)
			elseif var_239_5 == 305 and arg_239_1:isInfoId(40424) then
				var_239_6 = B.filterInKeywordCards(var_239_6, 158)
			elseif var_239_5 == 1002 and arg_239_1:isInfoId(40470) then
				var_239_6 = B.filterInCategoryCards(var_239_6, Data.CardCategory.angle)
			elseif var_239_5 == 2002 and arg_239_1:isInfoId(40495) then
				var_239_6 = B.filterEffectCards(var_239_6, Data.CardCategory.angle)

				B.appendTable(var_239_6, arg_239_0:getBattleCardsByInfoId(arg_239_2, 10086))
			elseif var_239_5 == 2002 and (arg_239_1:isInfoId(40056) or arg_239_1:isInfoId(40539)) then
				if arg_239_2 == "HBb" and #arg_239_1._owner:getBattleCards("B", 40535) > 0 then
					B.appendTable(var_239_6, B.filterNotInSuperIdCards(B.filterNoShieldCards(arg_239_0:getBattleCards("b"), BattleData.PositiveType.shieldMagic), var_239_5))
				end
			elseif var_239_5 == 3103 and arg_239_1:isInfoId(40534) then
				B.appendTable(var_239_6, B.filterInSuperIdCards(arg_239_0:getBattleCards(arg_239_2), 3000 + Data._skillInfo[13046]._refCards[1]))
			elseif var_239_5 == 2006 and arg_239_1:isInfoId(40640) then
				var_239_6 = B.filterInNatureCards(var_239_6, Data.CardNature.light)
			elseif var_239_5 == 306 and arg_239_1:isInfoId(40646) then
				var_239_6 = B.filterInKeywordCards(var_239_6, 104)
			elseif var_239_5 == 3104 and arg_239_1:isInfoId(40658) then
				var_239_6 = B.filterMergeCards(var_239_6)
			elseif var_239_5 == 3906 and arg_239_1:isInfoId(40662) then
				var_239_6 = B.filterMergeCards(B.filterInSuperIdCards(arg_239_0:getBattleCards(arg_239_2), var_239_5 - 900))
			end
		end

		local var_239_7 = B.filterCanBeSacrificedCards(var_239_6, true, false)

		for iter_239_4 = 1, #var_239_7 do
			if not var_239_3[var_239_7[iter_239_4]._id] then
				var_239_2[#var_239_2 + 1] = var_239_7[iter_239_4]
				var_239_3[var_239_7[iter_239_4]._id] = true
			end
		end
	end

	return var_239_2
end

function var_0_0.isValidMergeComponents(arg_241_0, arg_241_1, arg_241_2, arg_241_3, arg_241_4)
	if arg_241_1._infoId == 40221 or arg_241_1._infoId == 40231 then
		arg_241_4 = true
	end

	local var_241_0 = arg_241_1._info._joinComponent

	if arg_241_1:isKeyword(Data._skillInfo[7585]._refCards[1]) and arg_241_1._owner:hasBattleCardsByCanCastMagicSkillFast("S", 7585) then
		var_241_0 = {
			504,
			504
		}
	end

	if #arg_241_2 < #var_241_0 then
		return false
	end

	if arg_241_3 then
		local var_241_1 = false

		for iter_241_0 = 1, #arg_241_2 do
			if arg_241_2[iter_241_0] == arg_241_3 then
				var_241_1 = true

				break
			end
		end

		if not var_241_1 then
			return false
		end
	end

	local var_241_2 = arg_241_0:getEmptyBoardPos() == nil

	if var_241_2 then
		local var_241_3 = false

		for iter_241_1 = 1, #arg_241_2 do
			if arg_241_2[iter_241_1]._status == BattleData.CardStatus.board and arg_241_2[iter_241_1]._owner == arg_241_1._owner then
				var_241_3 = true
			end
		end

		if not var_241_3 then
			return false
		end
	end

	if arg_241_1:hasSkills({
		6018
	}) then
		local var_241_4 = arg_241_0:getBattleCardsBySpecifiedInfoId("B", arg_241_1._infoId)

		for iter_241_2 = 1, #var_241_4 do
			local var_241_5 = var_241_4[iter_241_2]
			local var_241_6 = false

			for iter_241_3 = 1, #arg_241_2 do
				if arg_241_2[iter_241_3] == var_241_5 then
					var_241_6 = true

					break
				end
			end

			if not var_241_6 then
				return false
			end
		end
	end

	local var_241_7 = {
		{},
		{},
		{}
	}

	for iter_241_4 = 1, #arg_241_2 do
		for iter_241_5 = 1, #var_241_0 do
			if B.isValidMergeComponent(var_241_0[iter_241_5], arg_241_2[iter_241_4], arg_241_1) then
				var_241_7[iter_241_5][#var_241_7[iter_241_5] + 1] = arg_241_2[iter_241_4]
			end
		end
	end

	for iter_241_6 = 1, #var_241_0 do
		if #var_241_7[iter_241_6] == 0 then
			return false
		end
	end

	local var_241_8 = 0
	local var_241_9 = {}
	local var_241_10 = {}
	local var_241_11 = {}

	for iter_241_7 = 1, #var_241_7[1] do
		var_241_9[1] = var_241_7[1][iter_241_7]
		var_241_10[1] = var_241_9[1]:hasSkills({
			3072
		}) and 1 or 0
		var_241_11[1] = var_241_9[1]._status == BattleData.CardStatus.board and var_241_9[1]._owner == arg_241_1._owner and 1 or 0

		for iter_241_8 = 1, #var_241_7[2] do
			var_241_9[2] = var_241_7[2][iter_241_8]
			var_241_10[2] = var_241_9[2]:hasSkills({
				3072
			}) and arg_241_1._infoId ~= 40274 and 1 or 0
			var_241_11[2] = var_241_9[2]._status == BattleData.CardStatus.board and var_241_9[2]._owner == arg_241_1._owner and 1 or 0

			if var_241_9[1]._id ~= var_241_9[2]._id and var_241_10[1] + var_241_10[2] <= 1 and (not arg_241_4 or not var_241_9[1]:isSameNameWith(var_241_9[2])) then
				if #var_241_0 == 2 then
					if var_241_11[1] + var_241_11[2] > 0 or not var_241_2 then
						var_241_8 = B.getChoiceByCandidatePos(arg_241_2, var_241_9)

						break
					end
				else
					for iter_241_9 = 1, #var_241_7[3] do
						var_241_9[3] = var_241_7[3][iter_241_9]
						var_241_10[3] = var_241_9[3]:hasSkills({
							3072
						}) and 1 or 0
						var_241_11[3] = var_241_9[3]._status == BattleData.CardStatus.board and var_241_9[3]._owner == arg_241_1._owner and 1 or 0

						if var_241_9[1]._id ~= var_241_9[3]._id and var_241_9[2]._id ~= var_241_9[3]._id and var_241_10[1] + var_241_10[2] + var_241_10[3] <= 1 and (var_241_11[1] + var_241_11[2] + var_241_11[3] > 0 or not var_241_2) and (not arg_241_4 or not var_241_9[1]:isSameNameWith(var_241_9[3]) and not var_241_9[2]:isSameNameWith(var_241_9[3])) then
							var_241_8 = B.getChoiceByCandidatePos(arg_241_2, var_241_9)

							break
						end
					end

					if var_241_8 > 0 then
						break
					end
				end
			end
		end

		if var_241_8 > 0 then
			break
		end
	end

	return var_241_8 > 0, var_241_8
end

function var_0_0.getMergedComponents(arg_242_0, arg_242_1, arg_242_2)
	local var_242_0 = arg_242_0:getMergeComponentIds(arg_242_1)
	local var_242_1 = {}
	local var_242_2 = {}

	for iter_242_0, iter_242_1 in pairs(var_242_0) do
		var_242_2[#var_242_2 + 1] = iter_242_0
	end

	table.sort(var_242_2, function(arg_243_0, arg_243_1)
		return arg_243_0 < arg_243_1
	end)

	for iter_242_2 = 1, #var_242_2 do
		local var_242_3 = var_242_2[iter_242_2]
		local var_242_4 = var_242_0[var_242_3]
		local var_242_5 = arg_242_0:getBattleCardsByInfoId("G", var_242_3, arg_242_2)

		for iter_242_3 = 1, math.min(var_242_4, #var_242_5) do
			var_242_1[#var_242_1 + 1] = var_242_5[iter_242_3]
		end
	end

	return var_242_1
end

function var_0_0.getValidSyncResultInfoIdsByTriggerCard(arg_244_0, arg_244_1)
	local var_244_0 = {}

	if arg_244_1._skills[1]._id == 3940 then
		local var_244_1 = Data._skillInfo[arg_244_1._skills[1]._id]
		local var_244_2 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCards("R")), true)

		for iter_244_0 = 1, #var_244_2 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_2[iter_244_0]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_2[iter_244_0]._infoId
			end
		end
	elseif arg_244_1._skills[1]._id == 6349 then
		local var_244_3 = Data._skillInfo[arg_244_1._skills[1]._id]
		local var_244_4 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCardsByKeyword("R", var_244_3._refCards[1])), true)

		for iter_244_1 = 1, #var_244_4 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_4[iter_244_1]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_4[iter_244_1]._infoId
			end
		end
	elseif arg_244_1._skills[1]._id == 2437 then
		local var_244_5 = Data._skillInfo[arg_244_1._skills[1]._id]
		local var_244_6 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCards("R")), true)

		for iter_244_2 = 1, #var_244_6 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_6[iter_244_2]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_6[iter_244_2]._infoId
			end
		end
	elseif arg_244_1:hasSkillFast(2560) then
		local var_244_7 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCards("R")), true)

		for iter_244_3 = 1, #var_244_7 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_7[iter_244_3]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_7[iter_244_3]._infoId
			end
		end
	elseif arg_244_1:hasSkillFast(2611) then
		local var_244_8 = Data._skillInfo[2611]
		local var_244_9 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCardsByKeyword("R", var_244_8._refCards[1])), true)

		for iter_244_4 = 1, #var_244_9 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_9[iter_244_4]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_9[iter_244_4]._infoId
			end
		end
	elseif arg_244_1:hasSkillFast(2781) then
		local var_244_10 = Data._skillInfo[2781]
		local var_244_11 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCardsByCategory("R", var_244_10._refCards[1])), true)

		for iter_244_5 = 1, #var_244_11 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_11[iter_244_5]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_11[iter_244_5]._infoId
			end
		end
	elseif arg_244_1:hasSkillFast(9453) then
		local var_244_12 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCards("R")), true)

		for iter_244_6 = 1, #var_244_12 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_12[iter_244_6]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_12[iter_244_6]._infoId
			end
		end
	elseif arg_244_1:hasSkillFast(9462) then
		local var_244_13 = Data._skillInfo[9462]
		local var_244_14 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCardsByKeyword("R", var_244_13._refCards[2])), true)

		for iter_244_7 = 1, #var_244_14 do
			if #var_244_14[iter_244_7]._info._joinComponent >= 3 and arg_244_0:isValidSyncResultByTriggerCard(var_244_14[iter_244_7]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_14[iter_244_7]._infoId
			end
		end
	elseif arg_244_1:hasSkillFast(9507) then
		local var_244_15 = Data._skillInfo[9507]
		local var_244_16 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCardsByKeyword("R", var_244_15._refCards[2])), true)

		for iter_244_8 = 1, #var_244_16 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_16[iter_244_8]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_16[iter_244_8]._infoId
			end
		end
	elseif arg_244_1:hasSkillFast(9685) then
		local var_244_17 = Data._skillInfo[9685]
		local var_244_18 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCardsByKeyword("R", var_244_17._refCards[1])), true)

		for iter_244_9 = 1, #var_244_18 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_18[iter_244_9]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_18[iter_244_9]._infoId
			end
		end
	elseif arg_244_1:hasSkillFast(13007) then
		local var_244_19 = Data._skillInfo[13007]
		local var_244_20 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCards("R")), true)

		for iter_244_10 = 1, #var_244_20 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_20[iter_244_10]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_20[iter_244_10]._infoId
			end
		end
	elseif arg_244_1:hasSkillFast(7824) then
		local var_244_21 = Data._skillInfo[7824]
		local var_244_22 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_244_0:getBattleCardsByCategory("R", var_244_21._refCards[1])), true)

		for iter_244_11 = 1, #var_244_22 do
			if arg_244_0:isValidSyncResultByTriggerCard(var_244_22[iter_244_11]._infoId, arg_244_1, false) then
				var_244_0[#var_244_0 + 1] = var_244_22[iter_244_11]._infoId
			end
		end
	end

	return var_244_0
end

local var_0_1 = {
	2437,
	2560,
	2611,
	2781,
	3940,
	6349,
	9453,
	9462,
	9685,
	13007
}

function var_0_0.isValidSyncResultByTriggerCard(arg_245_0, arg_245_1, arg_245_2, arg_245_3)
	if arg_245_2:hasSkillFast(3940) then
		return arg_245_0:isValidSyncResult(arg_245_1, "H", arg_245_3, arg_245_2, false, false, false)
	elseif arg_245_2:hasSkillFast(6349) then
		return arg_245_0:isValidSyncResult(arg_245_1, "HB", arg_245_3, arg_245_2, false, false, false)
	elseif arg_245_2:hasSkillFast(2437) then
		return arg_245_0:isValidSyncResult(arg_245_1, "B", arg_245_3, arg_245_2, false, false, false)
	elseif arg_245_2:hasSkillFast(2560) then
		return arg_245_0:isValidSyncResult(arg_245_1, "H", arg_245_3, arg_245_2, false, false, false)
	elseif arg_245_2:hasSkillFast(2611) then
		return arg_245_0:isValidSyncResult(arg_245_1, "b", arg_245_3, arg_245_2, false, false, false)
	elseif arg_245_2:hasSkillFast(2781) then
		return arg_245_0:isValidSyncResult(arg_245_1, "HB", arg_245_3, arg_245_2, false, false, false)
	elseif arg_245_2:hasSkillFast(9453) then
		return arg_245_0:isValidSyncResult(arg_245_1, "H", arg_245_3, arg_245_2, false, false, false)
	elseif arg_245_2:hasSkillFast(9462) then
		return arg_245_0:isValidSyncResult(arg_245_1, "H", arg_245_3, arg_245_2, false, false, false)
	elseif arg_245_2:hasSkillFast(9507) then
		return arg_245_0:isValidSyncResult(arg_245_1, "P", arg_245_3, nil, false, false, false)
	elseif arg_245_2:hasSkillFast(9685) then
		return arg_245_0:isValidSyncResult(arg_245_1, "b", arg_245_3, arg_245_2, false, false, false)
	elseif arg_245_2:hasSkillFast(13007) then
		return arg_245_0:isValidSyncResult(arg_245_1, "H", arg_245_3, arg_245_2, false, false, false)
	elseif arg_245_2:hasSkillFast(7824) then
		if arg_245_0._fortress._hp > arg_245_0._opponent._fortress._hp then
			return arg_245_0:isValidSyncResult(arg_245_1, "HB", arg_245_3, nil, false, false, false)
		else
			return arg_245_0:isValidSyncResult(arg_245_1, "HBG", arg_245_3, nil, false, false, false)
		end
	else
		return arg_245_0:isValidSyncResult(arg_245_1, "B", arg_245_3, nil, true, false, false)
	end
end

function var_0_0.isValidSyncResult(arg_246_0, arg_246_1, arg_246_2, arg_246_3, arg_246_4, arg_246_5, arg_246_6, arg_246_7)
	local var_246_0, var_246_1 = arg_246_0:hasRareCard(arg_246_1, arg_246_6, arg_246_7)

	if not var_246_0 then
		return false
	end

	if var_246_1:hasSkillFast(6018) and #arg_246_0:getBattleCardsBySpecifiedInfoId("B", var_246_1._infoId) > 0 then
		return false
	end

	local var_246_2 = arg_246_0:getSyncCandidates(var_246_1, arg_246_2, arg_246_4, arg_246_5)

	if not var_246_2 then
		return false
	end

	return arg_246_0:isValidSyncComponents(var_246_1, var_246_2, false, arg_246_3, arg_246_4)
end

function var_0_0.getSyncCandidatesByTriggerCard(arg_247_0, arg_247_1, arg_247_2)
	if arg_247_2:hasSkillFast(3940) then
		return arg_247_0:getSyncCandidates(arg_247_1, "H", arg_247_2, false)
	elseif arg_247_2:hasSkillFast(6349) then
		return arg_247_0:getSyncCandidates(arg_247_1, "HB", arg_247_2, false)
	elseif arg_247_2:hasSkillFast(2437) then
		return arg_247_0:getSyncCandidates(arg_247_1, "B", arg_247_2, false)
	elseif arg_247_2:hasSkillFast(2560) then
		return arg_247_0:getSyncCandidates(arg_247_1, "H", arg_247_2, false)
	elseif arg_247_2:hasSkillFast(2611) then
		return arg_247_0:getSyncCandidates(arg_247_1, "b", arg_247_2, false)
	elseif arg_247_2:hasSkillFast(2781) then
		return arg_247_0:getSyncCandidates(arg_247_1, "HB", arg_247_2, false)
	elseif arg_247_2:hasSkillFast(9453) then
		return arg_247_0:getSyncCandidates(arg_247_1, "H", arg_247_2, false)
	elseif arg_247_2:hasSkillFast(9462) then
		return arg_247_0:getSyncCandidates(arg_247_1, "H", arg_247_2, false)
	elseif arg_247_2:hasSkillFast(9507) then
		return arg_247_0:getSyncCandidates(arg_247_1, "P", nil, false)
	elseif arg_247_2:hasSkillFast(9685) then
		return arg_247_0:getSyncCandidates(arg_247_1, "b", arg_247_2, false)
	elseif arg_247_2:hasSkillFast(13007) then
		return arg_247_0:getSyncCandidates(arg_247_1, "H", arg_247_2, false)
	elseif arg_247_2:hasSkillFast(7824) then
		if arg_247_0._fortress._hp > arg_247_0._opponent._fortress._hp then
			return arg_247_0:getSyncCandidates(arg_247_1, "HBG", nil, false)
		else
			return arg_247_0:getSyncCandidates(arg_247_1, "HB", nil, false)
		end
	else
		return arg_247_0:getSyncCandidates(arg_247_1, "B", nil, true)
	end
end

function var_0_0.getSyncCandidates(arg_248_0, arg_248_1, arg_248_2, arg_248_3, arg_248_4)
	local var_248_0 = B.filterUniqueInfoIds(arg_248_1._info._joinComponent)
	local var_248_1 = {}
	local var_248_2 = {}

	if arg_248_3 ~= nil then
		var_248_2[arg_248_3._id] = true
		var_248_1[#var_248_1 + 1] = arg_248_3
	end

	local var_248_3 = B.filterCanBeSyncedCards(B.filterCanBeSacrificedCards(arg_248_0:getBattleCardsByType(arg_248_2, Data.CardType.monster), false, true), arg_248_1)

	if arg_248_3 and (arg_248_3._infoId == 11529 or arg_248_3._infoId == 11860) then
		B.appendTable(var_248_1, B.filterInStarCards(var_248_3, arg_248_1:getStar() - arg_248_3:getStar()))

		return var_248_1
	end

	if arg_248_3 and arg_248_3._infoId == 11587 then
		var_248_3 = B.filterInKeywordCards(var_248_3, Data._skillInfo[2781]._refCards[2])
	end

	if #var_248_3 + #var_248_1 < #arg_248_1._info._joinComponent then
		return nil
	end

	for iter_248_0 = 1, #var_248_0 do
		local var_248_4 = var_248_0[iter_248_0]
		local var_248_5 = {}

		if var_248_4 > Data.INFO_ID_GROUP_SIZE_LARGE and arg_248_3 == nil then
			var_248_5 = B.filterEqualInfoIdCards(var_248_3, var_248_4)

			local var_248_6 = Data.getInfo(var_248_4)

			if var_248_6._keyword == Data._skillInfo[3893]._refCards[1] then
				B.appendTable(var_248_5, B.filterHasSkillCards(var_248_3, 3893))
			end

			if var_248_6._keyword == Data._skillInfo[2302]._refCards[1] then
				B.appendTable(var_248_5, B.filterHasSkillCards(var_248_3, 2302))
			end

			if var_248_4 == Data._skillInfo[2613]._refCards[1] then
				B.appendTable(var_248_5, B.filterHasSkillCards(var_248_3, 2613))
			end
		elseif var_248_4 == 5008 and arg_248_3 == nil then
			var_248_5 = B.filterInSuperIdCards(var_248_3, var_248_4)

			local var_248_7 = arg_248_1._info._syncComponent[1]

			for iter_248_1 = 1, #var_248_7 do
				local var_248_8 = var_248_7[iter_248_1]

				if var_248_8 ~= 0 then
					if var_248_8 > Data.INFO_ID_GROUP_SIZE_LARGE then
						var_248_5 = B.filterInInfoIdCards(var_248_5, var_248_8)
					else
						var_248_5 = B.filterInSuperIdCards(var_248_5, var_248_8)
					end
				end
			end

			if arg_248_1:isInfoId(40664) then
				var_248_5 = B.filterSyncCards(var_248_5, true)
			end

			if arg_248_4 then
				var_248_5 = B.filterNoSkillsCards(var_248_5, var_0_1)
			end
		elseif var_248_4 == 6008 then
			var_248_5 = B.filterInSuperIdCards(var_248_3, var_248_4)

			local var_248_9 = arg_248_1._info._syncComponent[2]

			for iter_248_2 = 1, #var_248_9 do
				local var_248_10 = var_248_9[iter_248_2]

				if var_248_10 ~= 0 then
					if var_248_10 > Data.INFO_ID_GROUP_SIZE_LARGE then
						var_248_5 = B.filterInInfoIdCards(var_248_5, var_248_10)
					else
						var_248_5 = B.filterInSuperIdCards(var_248_5, var_248_10)
					end
				end
			end

			if arg_248_3 then
				if arg_248_3:hasSkillFast(3940) then
					var_248_5 = B.filterInSuperIdCards(var_248_5, 200 + arg_248_1:getStar() - arg_248_3:getStar())
				elseif arg_248_3:hasSkillFast(6349) then
					local var_248_11 = B.filterInStatusCards(var_248_5, BattleData.CardStatus.board)

					B.appendTable(var_248_11, B.filterInSuperIdCards(B.filterInStatusCards(var_248_5, BattleData.CardStatus.hand), 3000 + Data._skillInfo[6349]._refCards[1]))

					var_248_5 = var_248_11
				elseif arg_248_3:hasSkills({
					2437,
					2560,
					2611,
					2781,
					9453,
					9685
				}) then
					var_248_5 = B.filterInSuperIdCards(var_248_5, 200 + arg_248_1:getStar() - arg_248_3:getStar())
				elseif arg_248_3:hasSkillFast(9462) then
					var_248_5 = B.filterInKeywordCards(var_248_5, Data._skillInfo[9462]._refCards[1])
				elseif arg_248_3:hasSkillFast(13007) then
					var_248_5 = B.filterInSuperIdCards(var_248_5, 200 + arg_248_1:getStar() - arg_248_3:getStar())
				end
			end
		end

		for iter_248_3 = 1, #var_248_5 do
			local var_248_12 = var_248_5[iter_248_3]

			if not var_248_2[var_248_12._id] then
				var_248_2[var_248_12._id] = true
				var_248_1[#var_248_1 + 1] = var_248_12
			end
		end
	end

	if #var_248_1 < #arg_248_1._info._joinComponent then
		return nil
	end

	local var_248_13 = B.filterAdjustCards(var_248_1, true)

	if #var_248_13 == 0 then
		return nil
	end

	if not B.cardsNotHaveSkillId(var_248_13, 6713) then
		var_248_1 = B.filterInKeywordCards(var_248_1, Data._skillInfo[6713]._refCards[1])
	end

	if not B.cardsNotHaveSkillId(var_248_13, 2567) then
		var_248_1 = B.filterInKeywordCards(var_248_1, Data._skillInfo[2567]._refCards[1])
	end

	if #var_248_1 < #arg_248_1._info._joinComponent then
		return nil
	end

	return var_248_1
end

function var_0_0.isValidSyncComponents(arg_249_0, arg_249_1, arg_249_2, arg_249_3, arg_249_4, arg_249_5)
	local var_249_0 = arg_249_1._info._joinComponent
	local var_249_1 = arg_249_1._info._syncComponent
	local var_249_2 = 0

	for iter_249_0 = 1, #var_249_0 do
		if var_249_0[iter_249_0] == 6008 or iter_249_0 > 1 and var_249_0[iter_249_0 - 1] == 5008 and var_249_0[iter_249_0] > Data.INFO_ID_GROUP_SIZE_LARGE then
			break
		end

		var_249_2 = var_249_2 + 1
	end

	local var_249_3 = #var_249_0 - var_249_2
	local var_249_4 = {}
	local var_249_5 = {}
	local var_249_6 = 0
	local var_249_7 = 255
	local var_249_8 = 255
	local var_249_9 = 255

	for iter_249_1 = 1, #arg_249_2 do
		local var_249_10 = arg_249_2[iter_249_1]:getSyncStar(arg_249_1)

		var_249_6 = var_249_6 + var_249_10

		if arg_249_2[iter_249_1]:isAdjust() then
			var_249_4[#var_249_4 + 1] = arg_249_2[iter_249_1]

			if var_249_10 < var_249_7 then
				var_249_7 = var_249_10
			end
		elseif arg_249_2[iter_249_1]:isNotAdjust() then
			var_249_5[#var_249_5 + 1] = arg_249_2[iter_249_1]

			if var_249_10 < var_249_8 then
				var_249_9 = var_249_8
				var_249_8 = var_249_10
			elseif var_249_10 < var_249_9 then
				var_249_9 = var_249_10
			end
		end
	end

	if arg_249_3 then
		if var_249_6 < arg_249_1:getStar() then
			return false
		end
	elseif var_249_6 < arg_249_1:getStar() then
		return false
	end

	if var_249_3 > 1 and var_249_8 + var_249_9 > arg_249_1:getStar() - var_249_7 then
		return false
	end

	if arg_249_5 and (arg_249_5._infoId == 11529 or arg_249_5._infoId == 11860) then
		local var_249_11 = {
			arg_249_5
		}
		local var_249_12 = {
			var_249_5[1]
		}

		if not arg_249_4 then
			return true
		end

		local var_249_13 = B.getChoiceByCandidatePos(arg_249_2, B.mergeTable({
			var_249_11,
			var_249_12
		}))
		local var_249_14 = arg_249_1:getSkillIndexById(3851)

		return true, nil, var_249_14 * BattleData.ChoiceId.stage_3 + var_249_13 * BattleData.ChoiceId.stage_2, B.mergeTable({
			var_249_11,
			var_249_12
		})
	end

	if arg_249_3 then
		if #var_249_4 ~= var_249_2 or var_249_3 > #var_249_5 then
			return false
		end
	elseif var_249_2 > #var_249_4 or var_249_3 > #var_249_5 then
		return false
	end

	if arg_249_5 then
		local var_249_15 = false

		for iter_249_2 = 1, #arg_249_2 do
			if arg_249_2[iter_249_2] == arg_249_5 then
				var_249_15 = true

				break
			end
		end

		if not var_249_15 then
			return false
		end
	end

	if arg_249_1._infoId == 40315 and #B.filterEqualInfoIdCards(var_249_5, 40122) == 0 then
		return false
	end

	local var_249_16 = arg_249_0:getEmptyBoardPos() == nil

	if var_249_16 then
		local var_249_17 = false

		for iter_249_3 = 1, #arg_249_2 do
			if arg_249_2[iter_249_3]._status == BattleData.CardStatus.board then
				var_249_17 = true

				break
			end
		end

		if not var_249_17 then
			return false
		end
	end

	local var_249_18 = {
		{},
		{},
		{}
	}

	for iter_249_4 = 1, #var_249_4 do
		for iter_249_5 = 1, var_249_2 do
			if B.isValidSyncAdjustComponent(var_249_0[iter_249_5], var_249_1[1], var_249_4[iter_249_4], arg_249_1) then
				var_249_18[iter_249_5][#var_249_18[iter_249_5] + 1] = var_249_4[iter_249_4]
			end
		end
	end

	for iter_249_6 = 1, var_249_2 do
		if #var_249_18[iter_249_6] == 0 then
			return false
		end
	end

	local var_249_19 = false
	local var_249_20 = {}
	local var_249_21 = {}

	for iter_249_7 = 1, #var_249_18[1] do
		var_249_20[1] = var_249_18[1][iter_249_7]

		if var_249_2 == 1 then
			local var_249_22, var_249_23 = B.isValidNotAdjustCards(arg_249_1, var_249_20, var_249_5, var_249_3, var_249_16, arg_249_3, arg_249_4)

			if var_249_22 then
				var_249_19 = true
				var_249_21 = var_249_23

				break
			end
		else
			for iter_249_8 = 1, #var_249_18[2] do
				var_249_20[2] = var_249_18[2][iter_249_8]

				if var_249_20[1]._id ~= var_249_20[2]._id then
					if var_249_2 == 2 then
						local var_249_24, var_249_25 = B.isValidNotAdjustCards(arg_249_1, var_249_20, var_249_5, var_249_3, var_249_16, arg_249_3, arg_249_4)

						if var_249_24 then
							var_249_19 = true
							var_249_21 = var_249_25

							break
						end
					else
						for iter_249_9 = 1, #var_249_18[3] do
							var_249_20[3] = var_249_18[3][iter_249_9]

							if var_249_20[1]._id ~= var_249_20[3]._id and var_249_20[2]._id ~= var_249_20[3]._id then
								local var_249_26, var_249_27 = B.isValidNotAdjustCards(arg_249_1, var_249_20, var_249_5, var_249_3, var_249_16, arg_249_3, arg_249_4)

								if var_249_26 then
									var_249_19 = true
									var_249_21 = var_249_27

									break
								end
							end
						end

						if var_249_19 then
							break
						end
					end
				end
			end

			if var_249_19 then
				break
			end
		end
	end

	if var_249_19 then
		if not arg_249_4 then
			return true
		end

		if var_249_21 == nil then
			return true
		end

		local var_249_28 = B.getChoiceByCandidatePos(arg_249_2, B.mergeTable({
			var_249_20,
			var_249_21
		}))
		local var_249_29 = arg_249_1:getSkillIndexById(3851)

		return true, nil, var_249_29 * BattleData.ChoiceId.stage_3 + var_249_28 * BattleData.ChoiceId.stage_2, B.mergeTable({
			var_249_20,
			var_249_21
		})
	end

	return false
end

function var_0_0.getValidXYZResultInfoIdsByTriggerCard(arg_250_0, arg_250_1)
	local var_250_0 = {}

	if arg_250_1._skills[1]._id == 9999 then
		local var_250_1 = Data._skillInfo[arg_250_1._skills[1]._id]
		local var_250_2 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_250_0:getBattleCards("R")), true)

		for iter_250_0 = 1, #var_250_2 do
			if arg_250_0:isValidXYZResultByTriggerCard(var_250_2[iter_250_0]._infoId, arg_250_1, false) then
				var_250_0[#var_250_0 + 1] = var_250_2[iter_250_0]._infoId
			end
		end
	elseif arg_250_1._skills[1]._id == 9999 then
		local var_250_3 = Data._skillInfo[arg_250_1._skills[1]._id]
		local var_250_4 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_250_0:getBattleCardsByKeyword("R", var_250_3._refCards[1])), true)

		for iter_250_1 = 1, #var_250_4 do
			if arg_250_0:isValidXYZResultByTriggerCard(var_250_4[iter_250_1]._infoId, arg_250_1, false) then
				var_250_0[#var_250_0 + 1] = var_250_4[iter_250_1]._infoId
			end
		end
	end

	return var_250_0
end

function var_0_0.isValidXYZResultByTriggerCard(arg_251_0, arg_251_1, arg_251_2, arg_251_3)
	if arg_251_0._isSpecialSummonDisabledBy2534 and not arg_251_2:isKeyword(Data._skillInfo[2534]._refCards[2]) then
		return false
	end

	if false then
		return arg_251_0:isValidXYZResult(arg_251_1, "H", arg_251_3, arg_251_2, {}, false, false)
	else
		return arg_251_0:isValidXYZResult(arg_251_1, "B", arg_251_3, nil, nil, false, false)
	end
end

function var_0_0.isValidXYZResult(arg_252_0, arg_252_1, arg_252_2, arg_252_3, arg_252_4, arg_252_5, arg_252_6, arg_252_7)
	local var_252_0, var_252_1 = arg_252_0:hasRareCard(arg_252_1, arg_252_6, arg_252_7)

	if not var_252_0 then
		return false
	end

	if var_252_1:hasSkillFast(6018) and #arg_252_0:getBattleCardsBySpecifiedInfoId("B", var_252_1._infoId) > 0 then
		return false
	end

	local var_252_2 = arg_252_0:getXYZCandidates(var_252_1, arg_252_2, arg_252_4, arg_252_5)

	if not var_252_2 then
		return false
	end

	return arg_252_0:isValidXYZComponents(var_252_1, var_252_2, false, arg_252_3, arg_252_4)
end

function var_0_0.getXYZCandidatesByTriggerCard(arg_253_0, arg_253_1, arg_253_2)
	if false then
		return arg_253_0:getXYZCandidates(arg_253_1, "H", arg_253_2, {})
	else
		return arg_253_0:getXYZCandidates(arg_253_1, "B", nil, nil)
	end
end

function var_0_0.getXYZCandidates(arg_254_0, arg_254_1, arg_254_2, arg_254_3, arg_254_4)
	local var_254_0 = #arg_254_1._info._joinComponent
	local var_254_1 = arg_254_1._info._joinComponent[1]
	local var_254_2 = {}
	local var_254_3 = {}

	if arg_254_3 ~= nil then
		var_254_3[arg_254_3._id] = true
		var_254_2[#var_254_2 + 1] = arg_254_3
	end

	local var_254_4 = B.filterCanBeXYZedCards(arg_254_0:getBattleCards(arg_254_2), arg_254_1)

	if var_254_1 > 0 then
		var_254_4 = B.filterInStarCards(var_254_4, var_254_1)
	end

	if arg_254_1._info._syncComponent[1][1] > 0 then
		if #arg_254_1._info._syncComponent == 1 then
			local var_254_5

			if arg_254_1._infoId == 40537 then
				var_254_5 = B.filterInSuperIdCards(var_254_4, 3000 + Data._skillInfo[13048]._refCards[1])
			elseif arg_254_1._infoId == 40526 or arg_254_1._infoId == 40527 then
				var_254_5 = B.filterInSuperIdCards(var_254_4, 3000 + Data._skillInfo[13064]._refCards[1])
			end

			for iter_254_0 = 1, #arg_254_1._info._syncComponent[1] do
				var_254_4 = B.filterInSuperIdCards(var_254_4, arg_254_1._info._syncComponent[1][iter_254_0])
			end

			if var_254_5 and #var_254_5 > 0 then
				B.appendTable(var_254_4, var_254_5)
			end
		else
			local var_254_6 = {}

			for iter_254_1 = 1, #arg_254_1._info._syncComponent do
				local var_254_7 = var_254_4

				for iter_254_2 = 1, #arg_254_1._info._syncComponent[iter_254_1] do
					var_254_7 = B.filterInSuperIdCards(var_254_4, arg_254_1._info._syncComponent[iter_254_1][iter_254_2])
				end

				B.appendTable(var_254_6, var_254_7)
			end

			var_254_4 = var_254_6
		end
	end

	if arg_254_1:hasSkillFast(2414) then
		B.appendTable(var_254_4, B.filterCanBeXYZedCards(B.filterOppoCards(arg_254_0:getBoardCards())), arg_254_1)
	end

	if arg_254_1:hasSkillFast(9540) then
		B.appendTable(var_254_4, B.filterCanBeXYZedCards(B.filterInKeywordCards(arg_254_0:getBoardCards(), Data._skillInfo[9540]._refCards[1]), arg_254_1))
	end

	for iter_254_3 = 1, #var_254_4 do
		local var_254_8 = var_254_4[iter_254_3]

		if not var_254_3[var_254_8._id] then
			var_254_3[var_254_8._id] = true
			var_254_2[#var_254_2 + 1] = var_254_8
		end
	end

	return var_254_2
end

function var_0_0.isValidXYZComponents(arg_255_0, arg_255_1, arg_255_2, arg_255_3, arg_255_4, arg_255_5)
	local var_255_0 = #arg_255_1._info._joinComponent

	if arg_255_3 then
		if #arg_255_2 ~= var_255_0 then
			return false
		end
	elseif var_255_0 > #arg_255_2 then
		return false
	end

	if arg_255_1._infoId == 40353 then
		if #B.filterInKeywordCards(arg_255_2, 153) == 0 then
			return false
		end
	elseif arg_255_1._infoId == 40528 and #B.filterInKeywordCards(arg_255_2, 202) == 0 then
		return false
	end

	if arg_255_5 then
		local var_255_1 = false

		for iter_255_0 = 1, #arg_255_2 do
			if arg_255_2[iter_255_0] == arg_255_5 then
				var_255_1 = true

				break
			end
		end

		if not var_255_1 then
			return false
		end
	end

	local var_255_2 = arg_255_0:getEmptyBoardPos() == nil

	if var_255_2 then
		local var_255_3 = false

		for iter_255_1 = 1, #arg_255_2 do
			if arg_255_2[iter_255_1]._status == BattleData.CardStatus.board then
				var_255_3 = true

				break
			end
		end

		if not var_255_3 then
			return false
		end
	end

	local var_255_4 = 1

	while true do
		local var_255_5 = B.combinateTable(arg_255_2, var_255_0, var_255_4)

		if var_255_5 == nil then
			break
		end

		local var_255_6 = not var_255_2
		local var_255_7 = not arg_255_5

		if not var_255_6 or not var_255_7 then
			for iter_255_2 = 1, var_255_0 do
				if var_255_2 and var_255_5[iter_255_2]._status == BattleData.CardStatus.board then
					var_255_6 = true
				end

				if arg_255_5 and var_255_5[iter_255_2] == arg_255_5 then
					var_255_7 = true
				end
			end
		end

		if var_255_6 and var_255_7 then
			if arg_255_4 then
				local var_255_8 = arg_255_1:getSkillIndexById(6753)
				local var_255_9 = B.getChoiceByCandidatePos(arg_255_2, var_255_5)

				return true, nil, var_255_8 * BattleData.ChoiceId.stage_3 + var_255_9 * BattleData.ChoiceId.stage_2, var_255_5
			else
				return true
			end
		end

		var_255_4 = var_255_4 + 1
	end

	return false
end

function var_0_0.getValidLinkResultInfoIdsByTriggerCard(arg_256_0, arg_256_1)
	local var_256_0 = {}

	if arg_256_1._skills[1]._id == 9999 then
		local var_256_1 = Data._skillInfo[arg_256_1._skills[1]._id]
		local var_256_2 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_256_0:getBattleCards("R")), true)

		for iter_256_0 = 1, #var_256_2 do
			if arg_256_0:isValidLinkResultByTriggerCard(var_256_2[iter_256_0]._infoId, arg_256_1, false) then
				var_256_0[#var_256_0 + 1] = var_256_2[iter_256_0]._infoId
			end
		end
	elseif arg_256_1._skills[1]._id == 9999 then
		local var_256_3 = Data._skillInfo[arg_256_1._skills[1]._id]
		local var_256_4 = B.filterSyncCards(B.filterUniqueInfoIdCards(arg_256_0:getBattleCardsByKeyword("R", var_256_3._refCards[1])), true)

		for iter_256_1 = 1, #var_256_4 do
			if arg_256_0:isValidLinkResultByTriggerCard(var_256_4[iter_256_1]._infoId, arg_256_1, false) then
				var_256_0[#var_256_0 + 1] = var_256_4[iter_256_1]._infoId
			end
		end
	end

	return var_256_0
end

function var_0_0.isValidLinkResultByTriggerCard(arg_257_0, arg_257_1, arg_257_2, arg_257_3)
	if false then
		return arg_257_0:isValidLinkResult(arg_257_1, "H", arg_257_3, arg_257_2, {}, false, false)
	else
		return arg_257_0:isValidLinkResult(arg_257_1, "B", arg_257_3, nil, nil, false, false)
	end
end

function var_0_0.isValidLinkResult(arg_258_0, arg_258_1, arg_258_2, arg_258_3, arg_258_4, arg_258_5, arg_258_6, arg_258_7)
	local var_258_0, var_258_1 = arg_258_0:hasRareCard(arg_258_1, arg_258_6, arg_258_7)

	if not var_258_0 then
		return false
	end

	if var_258_1:hasSkillFast(6018) and #arg_258_0:getBattleCardsBySpecifiedInfoId("B", var_258_1._infoId) > 0 then
		return false
	end

	local var_258_2 = arg_258_0:getLinkCandidates(var_258_1, arg_258_2, arg_258_4, arg_258_5)

	if not var_258_2 then
		return false
	end

	return arg_258_0:isValidLinkComponents(var_258_1, var_258_2, false, arg_258_3, arg_258_4)
end

function var_0_0.getLinkCandidatesByTriggerCard(arg_259_0, arg_259_1, arg_259_2)
	if false then
		return arg_259_0:getLinkCandidates(arg_259_1, "H", arg_259_2, {})
	else
		return arg_259_0:getLinkCandidates(arg_259_1, "B", nil, nil)
	end
end

function var_0_0.getLinkCandidates(arg_260_0, arg_260_1, arg_260_2, arg_260_3, arg_260_4)
	local var_260_0 = arg_260_1._infoId == 40712
	local var_260_1 = B.filterCanBeLinkedCards(arg_260_0:getBattleCards(arg_260_2), arg_260_1, var_260_0)

	if arg_260_1._infoId == 40709 then
		var_260_1 = B.filterLinkCards(var_260_1, true)
	end

	if arg_260_1._infoId == 40420 then
		B.appendTable(var_260_1, B.filterCanBeLinkedCards(arg_260_0:getBattleCardsByInfoId("H", 11756), arg_260_1, false))
	elseif arg_260_1._infoId == 40551 then
		B.appendTable(var_260_1, B.filterCanBeLinkedCards(arg_260_0._opponent:getBattleCardsByType("B", Data.CardType.rare), arg_260_1, true))
	elseif arg_260_1._infoId == 40558 or arg_260_1._infoId == 40607 then
		B.appendTable(var_260_1, B.filterCanBeLinkedCards(B.filterNotActionedCards(B.filterInKeywordCards(arg_260_0:getBattleCardsByType("B", Data.CardType.rare), Data._skillInfo[13166]._refCards[1])), arg_260_1, true))
	elseif arg_260_1._infoId == 40569 then
		B.appendTable(var_260_1, B.filterCanBeLinkedCards(B.filterNotActionedCards(B.filterInKeywordCards(arg_260_0:getBattleCardsByType("B", Data.CardType.rare), Data._skillInfo[13245]._refCards[1])), arg_260_1, true))
	elseif arg_260_1:hasSkillFast(13461) then
		B.appendTable(var_260_1, B.filterCanBeLinkedCards(B.filterNotActionedCards(B.filterInKeywordCards(arg_260_0:getBattleCardsByType("B", Data.CardType.rare), Data._skillInfo[13461]._refCards[1])), arg_260_1, true))
	elseif arg_260_1._infoId == 40636 or arg_260_1._infoId == 40638 or arg_260_1._infoId == 40660 then
		B.appendTable(var_260_1, B.filterCanBeLinkedCards(B.filterNotActionedCards(B.filterInKeywordCards(arg_260_0:getBattleCardsByType("B", Data.CardType.rare), Data._skillInfo[13749]._refCards[1])), arg_260_1, true))
	elseif arg_260_1._infoId == 40655 or arg_260_1._infoId == 40656 or arg_260_1._infoId == 40657 or arg_260_1._infoId == 40699 then
		B.appendTable(var_260_1, B.filterCanBeLinkedCards(B.filterNotActionedCards(B.filterInKeywordCards(arg_260_0:getBattleCardsByType("B", Data.CardType.rare), Data._skillInfo[13885]._refCards[1])), arg_260_1, true))
	elseif arg_260_1._infoId == 40690 or arg_260_1._infoId == 40691 or arg_260_1._infoId == 40693 or arg_260_1._infoId == 40694 then
		B.appendTable(var_260_1, B.filterCanBeLinkedCards(B.filterNotActionedCards(B.filterInKeywordCards(arg_260_0:getBattleCardsByType("B", Data.CardType.rare), Data._skillInfo[14234]._refCards[1])), arg_260_1, true))
	elseif arg_260_1._infoId == 40692 then
		B.appendTable(var_260_1, B.filterCanBeLinkedCards(B.filterNotActionedCards(B.filterInKeywordCards(arg_260_0:getBattleCardsByType("B", Data.CardType.rare), Data._skillInfo[14234]._refCards[1])), arg_260_1, true))

		if arg_260_0._castedSkillCounts[14242] == nil then
			B.appendTable(var_260_1, B.filterCanBeLinkedCards(B.filterNotActionedCards(B.mergeTable({
				B.filterLinkCards(B.filterInTypeCards(arg_260_0._opponent:getBattleCardsByMaxQuality("B", Data._skillInfo[14242]._refCards[1]), Data.CardType.rare), false),
				B.filterLinkCardsByMaxLink(arg_260_0._opponent:getBoardCards(), Data._skillInfo[14242]._val[1])
			})), arg_260_1, true))
		end
	elseif arg_260_1._infoId == 40713 then
		B.appendTable(var_260_1, B.filterCanBeLinkedCards(B.filterLinkCardsByMaxLink(arg_260_0._opponent:getBoardCards(), 3), arg_260_1, true))
	end

	if #var_260_1 < arg_260_1._linkCountNode._subNodes[2]:value() then
		return {}
	end

	local var_260_2 = 0

	for iter_260_0 = 1, #var_260_1 do
		var_260_2 = var_260_2 + var_260_1[iter_260_0]:getLink()
	end

	if var_260_2 < arg_260_1:getLink() then
		return {}
	end

	local var_260_3 = {}
	local var_260_4 = {}

	if arg_260_3 ~= nil then
		var_260_4[arg_260_3._id] = true
		var_260_3[#var_260_3 + 1] = arg_260_3
	end

	for iter_260_1 = 1, #var_260_1 do
		local var_260_5 = var_260_1[iter_260_1]

		if not var_260_4[var_260_5._id] and (arg_260_1._linkCandidateNode and arg_260_1._linkCandidateNode:value(var_260_5) or not arg_260_1._linkCandidateNode) then
			var_260_4[var_260_5._id] = true
			var_260_3[#var_260_3 + 1] = var_260_5
		end
	end

	return var_260_3
end

function var_0_0.isValidLinkComponents(arg_261_0, arg_261_1, arg_261_2, arg_261_3, arg_261_4, arg_261_5)
	local var_261_0 = arg_261_1._linkCountNode._subNodes[2]:value()
	local var_261_1 = arg_261_1:getLink()
	local var_261_2
	local var_261_3

	if arg_261_1._infoId == 40551 or arg_261_1._infoId == 40692 or arg_261_1._infoId == 40713 then
		var_261_2 = B.filterSameOwnerCards(arg_261_2, arg_261_1)
		var_261_3 = B.filterSameOwnerCards(arg_261_2, arg_261_1._owner._opponent._fortress)
	end

	if arg_261_3 then
		if var_261_1 < #arg_261_2 or not arg_261_1._linkCountNode:value(arg_261_2) then
			return false
		end
	elseif var_261_0 > #arg_261_2 then
		return false
	end

	if arg_261_1._infoId == 40551 or arg_261_1._infoId == 40692 then
		if #var_261_2 < var_261_0 - 1 then
			return false
		end

		if arg_261_3 and #var_261_3 > 1 then
			return false
		end
	elseif arg_261_1._infoId == 40713 then
		if #var_261_2 < var_261_0 - 2 then
			return false
		end

		if arg_261_3 and #var_261_3 > 2 then
			return false
		end
	end

	if var_261_1 > B.getSumLink(arg_261_2) then
		return false
	end

	if (arg_261_1._infoId == 40551 or arg_261_1._infoId == 40692) and var_261_1 > B.getSumLink(var_261_2) + B.getMaxLink(var_261_3) then
		return false
	end

	if arg_261_5 and not B.tableContain(arg_261_2, arg_261_5) then
		return false
	end

	local var_261_4 = arg_261_0:getEmptyLinkPos() == nil

	if var_261_4 and #B.filterLinkPosCards(arg_261_2, true) == 0 then
		return false
	end

	if (arg_261_1._infoId == 40551 or arg_261_1._infoId == 40692 or arg_261_1._infoId == 40713) and var_261_4 and #B.filterLinkPosCards(var_261_2, true) == 0 then
		return false
	end

	if arg_261_3 then
		if arg_261_1._linkSelectedCandidatesNode and not arg_261_1._linkSelectedCandidatesNode:value(arg_261_2) then
			return false
		end

		return true
	else
		if arg_261_1._linkAllCandidatesNode and not arg_261_1._linkAllCandidatesNode:value(arg_261_2) then
			return false
		end

		for iter_261_0 = var_261_0, var_261_1 do
			i = 1

			while true do
				local var_261_5 = B.combinateTable(arg_261_2, iter_261_0, i)

				if var_261_5 == nil then
					break
				end

				if var_261_1 <= B.getSumLink(var_261_5) and (not var_261_4 or #B.filterLinkPosCards(var_261_5, true) > 0) and (not arg_261_5 or B.tableContain(var_261_5, arg_261_5)) and (not arg_261_1._linkSelectedCandidatesNode or arg_261_1._linkSelectedCandidatesNode:value(var_261_5)) then
					if arg_261_4 then
						local var_261_6 = arg_261_1:getSkillIndexById(9298)
						local var_261_7 = B.getChoiceByCandidatePos(arg_261_2, var_261_5)

						return true, nil, var_261_6 * BattleData.ChoiceId.stage_3 + var_261_7 * BattleData.ChoiceId.stage_2, var_261_5
					else
						return true
					end
				end

				i = i + 1
			end
		end

		return false
	end
end

function var_0_0.getValidCeremonyResultCardsBy4559(arg_262_0, arg_262_1)
	local var_262_0 = arg_262_1._skills[1]._id

	if B.isSkillCeremony(var_262_0) then
		local var_262_1 = Data._skillInfo[var_262_0]

		if var_262_0 == 4214 or var_262_0 == 4741 then
			return B.filterCeremonyMonsterCards(arg_262_0:getBattleCards("P"))
		elseif var_262_0 == 4216 or var_262_0 == 4218 or var_262_0 == 4386 or var_262_0 == 4388 or var_262_0 == 4504 or var_262_0 == 4528 or var_262_0 == 4576 or var_262_0 == 4585 or var_262_0 == 4597 or var_262_0 == 4573 or var_262_0 == 4648 or var_262_0 == 4956 then
			return B.filterCeremonyMonsterCards(arg_262_0:getBattleCardsByKeyword("P", var_262_1._refCards[1]))
		elseif var_262_0 == 4363 or var_262_0 == 4395 then
			return B.filterCeremonyMonsterCards(arg_262_0:getBattleCardsByNature("P", var_262_1._refCards[1]))
		elseif var_262_0 == 4382 then
			return arg_262_0:getBattleCardsByCategory("P", var_262_1._refCards[1])
		elseif var_262_0 == 4498 then
			return arg_262_0:getBattleCardsByInfoIdGroup("P", var_262_1._refCards)
		else
			return arg_262_0:getBattleCardsByInfoIdGroup("P", var_262_1._refCards)
		end
	else
		return {}
	end
end

function var_0_0.getValidCeremonyResultCardsByTriggerCard(arg_263_0, arg_263_1)
	local var_263_0 = arg_263_1._infoId == 21024 and 2 or 1
	local var_263_1 = arg_263_1._skills[var_263_0]._id

	if B.isSkillCeremony(var_263_1) then
		local var_263_2 = Data._skillInfo[var_263_1]

		if var_263_1 == 4214 or var_263_1 == 4741 then
			return arg_263_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_263_0:getBattleCards("H")), false, true)
		elseif var_263_1 == 4216 or var_263_1 == 4218 or var_263_1 == 4386 or var_263_1 == 4388 or var_263_1 == 4504 or var_263_1 == 4528 or var_263_1 == 4576 or var_263_1 == 4585 or var_263_1 == 4597 then
			if var_263_1 == 4585 and arg_263_0._castedSkillCounts[var_263_1] ~= nil then
				return {}
			end

			return arg_263_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_263_0:getBattleCardsByKeyword("H", var_263_2._refCards[1])), false, true)
		elseif var_263_1 == 4363 or var_263_1 == 4395 then
			return arg_263_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_263_0:getBattleCardsByNature("H", var_263_2._refCards[1])), false, true)
		elseif var_263_1 == 4382 then
			return arg_263_0:filterCanChangeToBoardCards(arg_263_0:getBattleCardsByCategory("G", var_263_2._refCards[1]))
		elseif var_263_1 == 4498 then
			return arg_263_0:filterCanChangeToBoardCards(arg_263_0:getBattleCardsByInfoIdGroup("P", var_263_2._refCards), false, true)
		elseif var_263_1 == 4573 then
			if arg_263_0._castedSkillCounts[var_263_1] ~= nil then
				return {}
			end

			return arg_263_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_263_0:getBattleCardsByKeyword("HG", var_263_2._refCards[1])), false, true)
		elseif var_263_1 == 4648 or var_263_1 == 4956 then
			return arg_263_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_263_0:getBattleCardsByKeyword("HG", var_263_2._refCards[1])), false, true)
		else
			return arg_263_0:filterCanChangeToBoardCards(arg_263_0:getBattleCardsByInfoIdGroup("H", var_263_2._refCards), false, true)
		end
	else
		return {}
	end
end

function var_0_0.isValidCeremonyResultByTriggerCard(arg_264_0, arg_264_1, arg_264_2, arg_264_3)
	if arg_264_2:hasSkillFast(4214) then
		local var_264_0 = arg_264_0:getCeremonyPileCandidates(arg_264_1)
		local var_264_1, var_264_2 = arg_264_0:isValidCeremonyComponents(arg_264_1, var_264_0)

		if var_264_1 then
			return true, var_264_2
		end
	elseif arg_264_3 == 2 and arg_264_2:hasSkillFast(4388) then
		local var_264_3 = arg_264_0:get4388CeremonyCandidates(arg_264_1)
		local var_264_4, var_264_5 = arg_264_0:isValidCeremonyComponents(arg_264_1, var_264_3)

		if var_264_4 then
			return true, var_264_5
		end
	elseif arg_264_2:hasSkillFast(4504) then
		local var_264_6 = arg_264_0:get4504CeremonyCandidates(arg_264_1)
		local var_264_7, var_264_8 = arg_264_0:isValidCeremonyComponents(arg_264_1, var_264_6)

		if var_264_7 then
			return true, var_264_8
		end
	elseif arg_264_3 == 2 and arg_264_2:hasSkillFast(4576) then
		local var_264_9 = arg_264_0:get4576CeremonyCandidates(arg_264_1)
		local var_264_10, var_264_11 = arg_264_0:isValidCeremonyComponents(arg_264_1, var_264_9)

		if var_264_10 then
			return true, var_264_11
		end
	elseif arg_264_2:hasSkillFast(4585) then
		local var_264_12 = arg_264_0:get4585CeremonyCandidates(arg_264_1)
		local var_264_13, var_264_14 = arg_264_0:isValidCeremonyComponents(arg_264_1, var_264_12)

		if var_264_13 then
			return true, var_264_14
		end
	elseif arg_264_2:hasSkillFast(4597) then
		local var_264_15 = arg_264_0:get4597CeremonyCandidates(arg_264_1)
		local var_264_16, var_264_17 = arg_264_0:isValidCeremonyComponents(arg_264_1, var_264_15)

		if var_264_16 then
			return true, var_264_17
		end
	elseif arg_264_2:hasSkillFast(4648) then
		local var_264_18 = arg_264_0:get4648CeremonyCandidates(arg_264_1)
		local var_264_19, var_264_20 = arg_264_0:isValidCeremonyComponents(arg_264_1, var_264_18)

		if var_264_19 then
			return true, var_264_20
		end
	elseif arg_264_2:hasSkillFast(4741) then
		local var_264_21 = arg_264_0:getCeremonyCandidates(arg_264_1)
		local var_264_22 = Data._skillInfo[4741]

		if #B.filterInInfoIdGroupCards(var_264_21, var_264_22._refCards) == 0 then
			return false
		end

		table.sort(var_264_21, function(arg_265_0, arg_265_1)
			local var_265_0 = arg_265_0:isInInfoIdGroup(var_264_22._refCards)
			local var_265_1 = arg_265_1:isInInfoIdGroup(var_264_22._refCards)

			if var_265_0 and not var_265_1 then
				return true
			elseif not var_265_0 and var_265_1 then
				return false
			else
				return arg_265_0._id < arg_265_1._id
			end
		end)

		local var_264_23, var_264_24 = arg_264_0:isValidCeremonyComponents(arg_264_1, var_264_21)

		if var_264_23 then
			return true, var_264_24
		end
	else
		local var_264_25 = arg_264_0:getCeremonyCandidates(arg_264_1)
		local var_264_26, var_264_27 = arg_264_0:isValidCeremonyComponents(arg_264_1, var_264_25)

		if var_264_26 then
			return true, var_264_27
		end

		if arg_264_1:hasSkillFast(3486) then
			local var_264_28 = arg_264_0:getCeremonyGraveCandidates(arg_264_1)
			local var_264_29, var_264_30 = arg_264_0:isValidCeremonyComponents(arg_264_1, var_264_28)

			if var_264_29 then
				return true, var_264_30
			end
		end
	end

	return false
end

function var_0_0.getCeremonyCandidatesByTriggerCard(arg_266_0, arg_266_1, arg_266_2)
	return arg_266_0:getCeremonyCandidates(arg_266_1)
end

function var_0_0.getCeremonyCandidates(arg_267_0, arg_267_1)
	local var_267_0 = B.mergeTable({
		B.filterCanBeSacrificedCards(B.mergeTable({
			arg_267_0:getBoardCards(),
			arg_267_0._opponent:getBattleCardsByBuff("B", false, BattleData.NegativeType.canBeSacriByOppo)
		})),
		arg_267_0:getBattleCardsByType("H", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_267_1)
	})

	if arg_267_1:isKeyword(Data._skillInfo[3629]._refCards[1]) then
		local var_267_1 = arg_267_0:getBattleCardsBySkillFast("G", 3629)

		var_267_0 = B.mergeTable({
			var_267_0,
			var_267_1
		})
	end

	local var_267_2 = arg_267_0:getBattleCardsBySkillFast("G", 3757)
	local var_267_3 = B.mergeTable({
		var_267_0,
		var_267_2
	})
	local var_267_4 = B.filterNoMark6368Cards(var_267_3)
	local var_267_5 = B.filterCanBeCeremonyedCards(var_267_4, arg_267_1)

	return B.filterXYZCards(var_267_5, false)
end

function var_0_0.getCeremonyGraveCandidatesByTriggerCard(arg_268_0, arg_268_1, arg_268_2)
	return arg_268_0:getCeremonyGraveCandidates(arg_268_1)
end

function var_0_0.getCeremonyGraveCandidates(arg_269_0, arg_269_1)
	local var_269_0 = B.filterSpiritCards(arg_269_0:getBattleCardsByType("G", Data.CardType.monster))
	local var_269_1 = arg_269_0:getBattleCardsBySkillFast("G", 3757)
	local var_269_2 = B.mergeTable({
		var_269_0,
		var_269_1
	})
	local var_269_3 = B.filterCanBeCeremonyedCards(var_269_2, arg_269_1)

	return B.filterXYZCards(var_269_3, false)
end

function var_0_0.getCeremonyPileCandidatesByTriggerCard(arg_270_0, arg_270_1, arg_270_2)
	return arg_270_0:getCeremonyPileCandidates(arg_270_1)
end

function var_0_0.getCeremonyPileCandidates(arg_271_0, arg_271_1)
	local var_271_0 = B.filterNormalCards(arg_271_0:getBattleCardsByType("P", Data.CardType.monster))
	local var_271_1 = arg_271_0:getBattleCardsBySkillFast("G", 3757)

	B.appendTable(var_271_0, var_271_1)

	local var_271_2 = B.filterCanBeCeremonyedCards(var_271_0, arg_271_1)

	return B.filterXYZCards(var_271_2, false)
end

function var_0_0.get4388CeremonyCandidatesByTriggerCard(arg_272_0, arg_272_1, arg_272_2)
	return arg_272_0:get4388CeremonyCandidates(arg_272_1)
end

function var_0_0.get4388CeremonyCandidates(arg_273_0, arg_273_1)
	local var_273_0 = Data._skillInfo[4388]
	local var_273_1 = B.filterInCategoryGroupCards(arg_273_0:getBattleCardsByType("G", Data.CardType.monster), {
		var_273_0._refCards[2],
		var_273_0._refCards[3]
	})

	return B.filterXYZCards(var_273_1, false)
end

function var_0_0.get4504CeremonyCandidatesByTriggerCard(arg_274_0, arg_274_1, arg_274_2)
	return arg_274_0:get4504CeremonyCandidates(arg_274_1)
end

function var_0_0.get4504CeremonyCandidates(arg_275_0, arg_275_1)
	local var_275_0 = Data._skillInfo[4504]
	local var_275_1 = arg_275_0:getCeremonyCandidates(arg_275_1)

	B.appendTable(var_275_1, arg_275_0:getBattleCardsByInfoIdGroup("G", {
		var_275_0._refCards[2],
		var_275_0._refCards[3]
	}))

	return B.filterXYZCards(var_275_1, false)
end

function var_0_0.get4576CeremonyCandidatesByTriggerCard(arg_276_0, arg_276_1, arg_276_2)
	return arg_276_0:get4576CeremonyCandidates(arg_276_1)
end

function var_0_0.get4576CeremonyCandidates(arg_277_0, arg_277_1)
	local var_277_0 = Data._skillInfo[4576]
	local var_277_1 = B.filterInKeywordCards(arg_277_0:getBattleCardsByType("G", Data.CardType.monster), var_277_0._refCards[1])

	return B.filterXYZCards(var_277_1, false)
end

function var_0_0.get4585CeremonyCandidatesByTriggerCard(arg_278_0, arg_278_1, arg_278_2)
	return arg_278_0:get4585CeremonyCandidates(arg_278_1)
end

function var_0_0.get4585CeremonyCandidates(arg_279_0, arg_279_1)
	local var_279_0 = Data._skillInfo[4585]
	local var_279_1 = B.filterInTypeCards(arg_279_0:getBattleCardsByKeywordGroup("P", var_279_0._refCards), Data.CardType.monster)

	return B.filterXYZCards(var_279_1, false)
end

function var_0_0.get4597CeremonyCandidatesByTriggerCard(arg_280_0, arg_280_1, arg_280_2)
	return arg_280_0:get4597CeremonyCandidates(arg_280_1)
end

function var_0_0.get4597CeremonyCandidates(arg_281_0, arg_281_1)
	local var_281_0 = Data._skillInfo[4597]
	local var_281_1 = B.filterCanBeSacrificedCards(arg_281_0:getBoardCards())

	B.appendTable(var_281_1, B.filterCanBeSacrificedCards(arg_281_0._opponent:getBoardCards()))

	local var_281_2 = B.filterCanBeCeremonyedCards(var_281_1, arg_281_1)

	return B.filterXYZCards(var_281_2, false)
end

function var_0_0.get4648CeremonyCandidatesByTriggerCard(arg_282_0, arg_282_1, arg_282_2)
	return arg_282_0:get4648CeremonyCandidates(arg_282_1)
end

function var_0_0.get4648CeremonyCandidates(arg_283_0)
	local var_283_0 = Data._skillInfo[4648]
	local var_283_1 = {}
	local var_283_2 = B.filterXYZCards(B.filterCanBeSacrificedCards(arg_283_0:getBattleCardsByNatureGroup("HP", {
		var_283_0._refCards[2],
		var_283_0._refCards[3]
	})), false)

	if #var_283_2 == 0 then
		return var_283_1
	end

	for iter_283_0 = 1, #var_283_2 do
		local var_283_3 = var_283_2[iter_283_0]

		if #B.filterInNatureCards(arg_283_0:getBattleCardsByStar(var_283_3._status == BattleData.CardStatus.hand and "P" or "H", var_283_0._val[1] - var_283_3:getStar()), var_283_0._refCards[var_283_3._info._nature == var_283_0._refCards[2] and 3 or 2]) > 0 then
			var_283_1[#var_283_1 + 1] = var_283_3
		end
	end

	return var_283_1
end

function var_0_0.isValidCeremonyComponents(arg_284_0, arg_284_1, arg_284_2)
	local var_284_0 = arg_284_1:getStar()
	local var_284_1 = 0
	local var_284_2 = 0

	for iter_284_0 = 1, #arg_284_2 do
		var_284_1 = var_284_1 + arg_284_2[iter_284_0]:getCeremonyStar(arg_284_1)
		var_284_2 = var_284_2 + 2^(iter_284_0 - 1)

		if var_284_0 <= var_284_1 then
			break
		end
	end

	if var_284_1 < var_284_0 then
		return false
	end

	if arg_284_0:getEmptyBoardPos() == nil then
		local var_284_3 = false

		for iter_284_1 = 1, #arg_284_2 do
			if arg_284_2[iter_284_1]._status == BattleData.CardStatus.board and arg_284_2[iter_284_1]._owner == arg_284_1._owner then
				var_284_3 = true
			end
		end

		if not var_284_3 then
			return false
		end
	end

	return true, var_284_2
end

function var_0_0.isBoardPosLocked(arg_285_0, arg_285_1)
	local var_285_0 = arg_285_0._fortress:getBuffValue(false, BattleData.NegativeType.boardLock)

	if type(var_285_0) ~= "table" then
		return false
	end

	for iter_285_0 = 1, #var_285_0 do
		if arg_285_1 == var_285_0[iter_285_0] then
			return true
		end
	end

	return false
end

function var_0_0.isBoardPosEmpty(arg_286_0, arg_286_1)
	return arg_286_0._boardCards[arg_286_1] == nil and not arg_286_0:isBoardPosLocked(arg_286_1)
end

function var_0_0.getEmptyBoardPosCount(arg_287_0)
	local var_287_0 = 0

	for iter_287_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		if arg_287_0:isBoardPosEmpty(iter_287_0) then
			var_287_0 = var_287_0 + 1
		end
	end

	return var_287_0
end

function var_0_0.getEmptyBoardPos(arg_288_0, arg_288_1)
	if arg_288_1 ~= nil and arg_288_1:hasSkills({
		6018
	}) and #arg_288_0:getBattleCardsBySpecifiedInfoId("B", arg_288_1._infoId) > 0 then
		return nil
	end

	for iter_288_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		if arg_288_0:isBoardPosEmpty(iter_288_0) then
			return iter_288_0
		end
	end

	return nil
end

function var_0_0.isLinkPosEmpty(arg_289_0, arg_289_1)
	return arg_289_0:isBoardPosEmpty(arg_289_1) and arg_289_0._linkPos[arg_289_1] == true
end

function var_0_0.getEmptyLinkPosCount(arg_290_0)
	local var_290_0 = 0

	for iter_290_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		if arg_290_0:isLinkPosEmpty(iter_290_0) then
			var_290_0 = var_290_0 + 1
		end
	end

	return var_290_0
end

function var_0_0.getEmptyLinkPos(arg_291_0, arg_291_1)
	if arg_291_1 ~= nil and arg_291_1:hasSkills({
		6018
	}) and #arg_291_0:getBattleCardsBySpecifiedInfoId("B", arg_291_1._infoId) > 0 then
		return nil
	end

	if arg_291_0:isLinkPosEmpty(Data.MAX_CARD_COUNT_ON_BOARD + 1) then
		return Data.MAX_CARD_COUNT_ON_BOARD + 1
	end

	for iter_291_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		if arg_291_0:isLinkPosEmpty(iter_291_0) then
			return iter_291_0
		end
	end

	return nil
end

function var_0_0.canSpecialSummonAnyCard(arg_292_0)
	if arg_292_0._isSummonDisabled or arg_292_0._isSummonDisabledEx or arg_292_0._isSpecialSummonDisabled then
		return false
	end

	local var_292_0 = arg_292_0._opponent
	local var_292_1 = arg_292_0:getBoardCards()
	local var_292_2 = var_292_0:getBoardCards()

	if arg_292_0:hasBattleCardsBySkillFast("B", 13353) or var_292_0:hasBattleCardsBySkillFast("B", 13353) then
		return false
	end

	if #arg_292_0._rareCards == 0 and B.cardsHaveSkillId(var_292_1, 6069) or #var_292_0._rareCards == 0 and B.cardsHaveSkillId(var_292_2, 6069) then
		return false
	end

	if B.cardsHaveSkillId(var_292_1, 6111) and #arg_292_0:getBattleCardsByCategory("B", Data._skillInfo[6111]._refCards[1]) > 1 then
		return false
	end

	if B.cardsHaveSkillId(var_292_2, 6111) and #var_292_0:getBattleCardsByCategory("B", Data._skillInfo[6111]._refCards[1]) > 1 then
		return false
	end

	if B.cardsHaveSkillId(var_292_1, 6201) then
		return false
	end

	if B.cardsHaveSkillId(var_292_1, 9504) then
		return false
	end

	if #B.filterCanEffectTrapCards(arg_292_0:getBattleCardsBySkillFast("S", 8017)) + #B.filterCanEffectTrapCards(var_292_0:getBattleCardsBySkillFast("S", 8017)) > 0 and #arg_292_0._normalSummonedCards + #arg_292_0._specialSummonedCards + #var_292_0._normalSummonedCards + #var_292_0._specialSummonedCards >= Data._skillInfo[8017]._val[1] then
		return false
	end

	if arg_292_0:hasBattleCardsBySkillFast("S", 8052) or var_292_0:hasBattleCardsBySkillFast("S", 8052) then
		return false
	end

	if B.cardsHaveSkillId(var_292_2, 13111) and #arg_292_0._specialSummonedCards > 0 then
		return false
	end

	return true
end

function var_0_0.canSpecialSummon(arg_293_0, arg_293_1, arg_293_2, arg_293_3)
	local var_293_0 = arg_293_0._opponent

	if not arg_293_0:canSpecialSummonAnyCard() then
		return false
	end

	if arg_293_1._mark6509 then
		return false
	end

	if arg_293_0._mark9359 and arg_293_1._status == BattleData.CardStatus.grave then
		return false
	end

	if arg_293_0._mark14256 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isNature(arg_293_0._mark14256) then
		return false
	end

	local var_293_1 = arg_293_1:getStar()

	if arg_293_0._isSummonDisabledByInfoId ~= nil and not arg_293_1:isInfoId(arg_293_0._isSummonDisabledByInfoId) then
		return false
	end

	if arg_293_0._isSummonDisabledBySelfStar[var_293_1] or arg_293_0._isSummonDisabledByOppoStar[var_293_1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledByNature[arg_293_1._info._nature] then
		return false
	end

	if arg_293_0._isSpecialSummonExcludeCeremony and not arg_293_1:isCeremonyMonster() then
		return false
	end

	if arg_293_0._isSummonDisabledBy1143 == arg_293_0._round and arg_293_1:getStar() ~= Data.XYZ_STAR and arg_293_1:getStar() >= Data._skillInfo[1143]._val[1] then
		return false
	end

	if arg_293_0._isSummonDisabledBy4659 and not arg_293_1:isNature(Data._skillInfo[4659]._refCards[1]) then
		return false
	end

	if arg_293_0._isSummonDisabledBy4674 and not arg_293_1:isKeyword(Data._skillInfo[4674]._refCards[1]) and not arg_293_1:isKeyword(Data._skillInfo[4674]._refCards[2]) then
		return false
	end

	if arg_293_0._isSummonDisabledBy4825 and not arg_293_1:isKeyword(Data._skillInfo[4825]._refCards[1]) then
		return false
	end

	if arg_293_0._isSummonDisabledBy4941 and not arg_293_1:isKeyword(Data._skillInfo[4941]._refCards[1]) then
		return false
	end

	if arg_293_0._isSummonDisabledBy7773 and not arg_293_1:isKeyword(Data._skillInfo[7773]._refCards[1]) then
		return false
	end

	if arg_293_0._isSummonDisabledBy2723 and (arg_293_1._info._category ~= Data._skillInfo[2723]._refCards[1] or not arg_293_1:isNature(Data._skillInfo[2723]._refCards[2]) and not arg_293_1:isNature(Data._skillInfo[2723]._refCards[3])) then
		return false
	end

	if arg_293_0._isSummonDisabledBy9480 and not arg_293_1:isKeywordGroup(Data._skillInfo[9480]._refCards) then
		return false
	end

	if arg_293_0._isSummonDisabledBy9699 and not arg_293_1:isKeyword(Data._skillInfo[9699]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy4454 and (not arg_293_1:isNature(Data._skillInfo[4454]._refCards[#Data._skillInfo[4454]._refCards - 1]) or not arg_293_1:isKeyword(Data._skillInfo[4454]._refCards[#Data._skillInfo[4454]._refCards])) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy4812 and not arg_293_1:isCategoryGroup(Data._skillInfo[4812]._refCards) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy4847 and arg_293_1._info._category ~= Data._skillInfo[4847]._refCards[2] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy5288 and not arg_293_1:isNature(Data._skillInfo[5288]._refCards[4]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy5400 and not arg_293_1:isKeywordGroup(Data._skillInfo[5400]._refCards) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy5582 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[5582]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy5592 and arg_293_1._status == BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[5592]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy5611 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[5611]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy5634 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[5634]._refCards[1]) then
		return false
	end

	if (arg_293_0._isSpecialSummonDisabledBy5618 or var_293_0._isSpecialSummonDisabledBy5618) and arg_293_1:isToken() then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy6706 and not arg_293_1:isKeyword(Data._skillInfo[6706]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy2123 and arg_293_1._info._category ~= Data._skillInfo[2123]._refCards[2] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy2521 and arg_293_1._info._category ~= Data._skillInfo[2521]._refCards[1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy2779 and not arg_293_1:isNature(Data._skillInfo[2779]._refCards[3]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy2980 and arg_293_1._info._category ~= Data._skillInfo[2980]._refCards[2] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy3153 and not arg_293_1:isKeyword(Data._skillInfo[3153]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy4594 and arg_293_1._info._category ~= Data._skillInfo[4594]._refCards[1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy7397 and not arg_293_1:isKeyword(Data._skillInfo[7397]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy7549 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[7549]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy7608 and not arg_293_1:isNature(Data._skillInfo[7608]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy7621 and arg_293_1._status ~= BattleData.CardStatus.rare and arg_293_1._info._category ~= Data._skillInfo[7621]._refCards[3] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy7681 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[7681]._refCards[3]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy7752 and not arg_293_1:isKeywordGroup(Data._skillInfo[7752]._refCards) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy7812 and arg_293_1._status == BattleData.CardStatus.rare and not arg_293_1:isMerge() then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy7825 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isNature(Data._skillInfo[7825]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy7830 and not arg_293_1:isKeyword(Data._skillInfo[7830]._refCards[2]) and arg_293_1._info._category ~= Data._skillInfo[7830]._refCards[3] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9223 and arg_293_1._info._category ~= Data._skillInfo[9223]._refCards[2] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9314 and not arg_293_1:isKeyword(Data._skillInfo[9314]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9541 and not arg_293_1:isKeyword(Data._skillInfo[9541]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9561 and not arg_293_1:isKeyword(Data._skillInfo[9561]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9598 and not arg_293_1:isNature(Data._skillInfo[9598]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9687 and not arg_293_1:isKeyword(Data._skillInfo[9687]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9758 and not arg_293_1:isKeyword(Data._skillInfo[9758]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9785 and not arg_293_1:isKeyword(Data._skillInfo[9785]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9824 and arg_293_1._info._category ~= Data._skillInfo[9824]._refCards[1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9858 and not arg_293_1:isNature(Data._skillInfo[9858]._refCards[2]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9864 and not arg_293_1:isKeyword(Data._skillInfo[9864]._refCards[2]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy9954 and not arg_293_1:isKeyword(Data._skillInfo[9954]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy8116 and arg_293_1._info._category ~= Data._skillInfo[8116]._refCards[1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13096 and not arg_293_1:isKeyword(Data._skillInfo[13096]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13098 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[13098]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13118 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[13118]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13153 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeywordGroup(Data._skillInfo[13153]._refCards) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13156 and not arg_293_1:isKeyword(Data._skillInfo[13156]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13164 and not arg_293_1:isKeyword(Data._skillInfo[13164]._refCards[1]) and arg_293_1._info._category ~= Data._skillInfo[13164]._refCards[2] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13167 and not arg_293_1:isKeyword(Data._skillInfo[13167]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13170 and arg_293_1._info._category ~= Data._skillInfo[13170]._refCards[2] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13184 and not arg_293_1:isKeyword(Data._skillInfo[13184]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13307 and arg_293_1._status == BattleData.CardStatus.rare and not arg_293_1:isNature(Data._skillInfo[13307]._refCards[2]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13335 and not arg_293_1:isKeyword(Data._skillInfo[13335]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13345 and not arg_293_1:isKeyword(Data._skillInfo[13345]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13347 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[13347]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13350 and not arg_293_1:isKeywordGroup(Data._skillInfo[13350]._refCards) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13409 and not arg_293_1:isKeyword(Data._skillInfo[13409]._refCards[2]) and not arg_293_1:isKeyword(Data._skillInfo[13409]._refCards[3]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13420 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[13420]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13423 and arg_293_1:isToken() then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13480 and arg_293_1._hp ~= 1000 then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13481 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[13481]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13482 and arg_293_1._status ~= BattleData.CardStatus.rare and arg_293_1._info._category ~= Data._skillInfo[13482]._refCards[1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13485 and not arg_293_1:isKeyword(Data._skillInfo[13485]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13496 and arg_293_1._info._category ~= Data._skillInfo[13496]._refCards[1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13524 and arg_293_1._status == BattleData.CardStatus.rare and arg_293_1._info._category ~= arg_293_0._isSpecialSummonDisabledBy13524._info._category and not arg_293_1:isNature(arg_293_0._isSpecialSummonDisabledBy13524._info._nature) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13530 and not arg_293_1:isKeywordGroup(Data._skillInfo[13530]._refCards) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13539 and arg_293_1._status == BattleData.CardStatus.rare and not arg_293_1:isNature(Data._skillInfo[13539]._refCards[2]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13561 and not arg_293_1:isCategoryGroup(Data._skillInfo[13561]._refCards) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13586 and not arg_293_1:isKeyword(Data._skillInfo[13586]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13588 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isNature(Data._skillInfo[13588]._refCards[2]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13590 and not arg_293_1:isNature(Data._skillInfo[13590]._refCards[2]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13618 and arg_293_1._status == BattleData.CardStatus.rare and arg_293_1._info._category ~= Data._skillInfo[13618]._refCards[3] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13626 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[13626]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13661 and not arg_293_1:isKeywordGroup(Data._skillInfo[13661]._refCards) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13666 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isNature(Data._skillInfo[13666]._refCards[2]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13727 and not arg_293_1:isKeyword(Data._skillInfo[13727]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13777 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isNature(Data._skillInfo[13777]._refCards[2]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13844 and arg_293_1._status ~= BattleData.CardStatus.rare and arg_293_1._info._category ~= Data._skillInfo[13844]._refCards[1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13868 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[13868]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13949 and arg_293_1._status ~= BattleData.CardStatus.rare and arg_293_1._info._category ~= Data._skillInfo[13949]._refCards[1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy13956 and arg_293_1._status ~= BattleData.CardStatus.rare and arg_293_1._info._category ~= Data._skillInfo[13956]._refCards[3] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14016 and not arg_293_1:isNature(Data._skillInfo[14016]._refCards[3]) and arg_293_1._info._category ~= Data._skillInfo[14016]._refCards[4] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14018 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[14018]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14038 and (arg_293_1._status == BattleData.CardStatus.pile or arg_293_1._status == BattleData.CardStatus.grave) and not arg_293_1:isNature(arg_293_0._isSpecialSummonDisabledBy14038) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14039 and (arg_293_1._status == BattleData.CardStatus.hand or arg_293_1._status == BattleData.CardStatus.leave) and not arg_293_1:isNature(arg_293_0._isSpecialSummonDisabledBy14039) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14044 and not arg_293_1:isNature(Data._skillInfo[14044]._refCards[2]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14123 and not arg_293_1:isKeyword(Data._skillInfo[14123]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14140 and arg_293_1._status ~= BattleData.CardStatus.rare and arg_293_1._info._category ~= Data._skillInfo[14140]._refCards[2] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14201 and arg_293_1._status ~= BattleData.CardStatus.rare and not arg_293_1:isKeyword(Data._skillInfo[14201]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14202 and not arg_293_1:isKeyword(Data._skillInfo[14202]._refCards[3]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14220 and arg_293_1._status ~= BattleData.CardStatus.rare and arg_293_1._info._category ~= Data._skillInfo[14220]._refCards[1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14412 and not arg_293_1:isKeywordGroup(Data._skillInfo[14412]._refCards) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14458 and arg_293_1._status ~= BattleData.CardStatus.rare and arg_293_1._info._category ~= Data._skillInfo[14458]._refCards[2] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14470 and arg_293_1._info._category ~= Data._skillInfo[14470]._refCards[1] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14489 and not arg_293_1:isKeyword(Data._skillInfo[14489]._refCards[1]) then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14534 and arg_293_1._status ~= BattleData.CardStatus.rare and arg_293_1._info._category ~= Data._skillInfo[14534]._refCards[2] then
		return false
	end

	if arg_293_0._isSpecialSummonDisabledBy14543 and arg_293_1:isSameNameWith(arg_293_0._isSpecialSummonDisabledBy14543) then
		return false
	end

	if arg_293_0:hasBattleCardsBySkillFast("B", 2561) and arg_293_1._info._category ~= Data._skillInfo[2561]._refCards[1] then
		return false
	end

	if arg_293_1:hasSkillFast(13258) and #arg_293_0._specialSummonedCards > 0 then
		return false
	end

	if B._mark9972 then
		for iter_293_0, iter_293_1 in pairs(B._mark9972) do
			for iter_293_2 = 1, #iter_293_1 do
				if arg_293_1:isSameNameWith(iter_293_1[iter_293_2]) then
					return false
				end
			end
		end
	end

	for iter_293_3, iter_293_4 in pairs(arg_293_0._isSpecialSummonDisabledByExcludeKeyword) do
		if not arg_293_1:isKeyword(iter_293_3) then
			return false
		end
	end

	if arg_293_0._isSpecialSummonDisabledByMaxStar ~= nil and var_293_1 ~= Data.XYZ_STAR and var_293_1 > arg_293_0._isSpecialSummonDisabledByMaxStar then
		return false
	end

	if arg_293_1._type == Data.CardType.rare and not arg_293_0:canSummonRareCard(arg_293_1, arg_293_2, arg_293_3) then
		return false
	end

	if arg_293_0._isSummonExcludeSyncDisabled and (arg_293_1._type ~= Data.CardType.rare or arg_293_1._status ~= BattleData.CardStatus.rare or not arg_293_1:isSync()) then
		return false
	end

	if not arg_293_1:isNormalMonster() and (arg_293_0:hasBattleCardsBySkillFast("S", 8010) or var_293_0:hasBattleCardsBySkillFast("S", 8010)) then
		return false
	end

	if var_293_1 ~= Data.XYZ_STAR and var_293_1 >= Data._skillInfo[8012]._val[1] and (arg_293_0:hasBattleCardsBySkillFast("S", 8012) or var_293_0:hasBattleCardsBySkillFast("S", 8012)) then
		return false
	end

	if not arg_293_3 and arg_293_1:hasSkillFast(2337) then
		return false
	end

	if arg_293_1:hasSkillInMode(Data.SkillMode.use_disable) then
		return false
	end

	if not arg_293_3 and arg_293_1:hasSkillInMode(Data.SkillMode.use_special_disable) then
		return false
	end

	if not arg_293_2 and (arg_293_1:hasSkillInMode(Data.SkillMode.use_specific_by_another_card) or arg_293_1:hasSkillInMode(Data.SkillMode.use_normal_or_specific_by_another_card)) then
		return false
	end

	if not arg_293_3 and arg_293_1:hasSkillInMode(Data.SkillMode.use_specific_by_condition) then
		return false
	end

	if not arg_293_3 and arg_293_1._boardCount == 0 and arg_293_1:hasSkillInMode(Data.SkillMode.use_specific_by_condition_once) then
		return false
	end

	if not arg_293_3 then
		local var_293_2, var_293_3 = arg_293_1:hasSkillInMode(Data.SkillMode.use_special_disable_except)

		if var_293_2 then
			local var_293_4 = var_293_3[1]._id
			local var_293_5 = Data._skillInfo[var_293_4]

			if var_293_4 == 3178 then
				if arg_293_1._status == BattleData.CardStatus.grave then
					return false
				end
			elseif var_293_4 == 3448 then
				local var_293_6 = arg_293_0:getBattleCardsByInfoIdGroup("G", var_293_5._refCards)

				if #B.filterUniqueInfoIdCards(var_293_6) ~= #var_293_5._refCards then
					return false
				end
			elseif var_293_4 == 3467 or var_293_4 == 3468 or var_293_4 == 3470 then
				if #arg_293_0:getBattleCardsByInfoId("SD", var_293_5._refCards[1]) == 0 then
					return false
				end
			elseif var_293_4 == 3634 then
				local var_293_7 = arg_293_0:getBattleCardsByNature("G", var_293_5._refCards[1])
				local var_293_8 = arg_293_0:getBattleCardsByNature("G", var_293_5._refCards[2])

				if #var_293_7 == 0 or #var_293_8 == 0 or #var_293_7 ~= #var_293_8 then
					return false
				end
			end
		end
	end

	if arg_293_1:hasSkillFast(3150) and arg_293_0._isSummonedFromRare then
		return false
	end

	if arg_293_1:hasSkillFast(3310) and arg_293_1._status == BattleData.CardStatus.pile then
		return false
	end

	if arg_293_1:hasSkillFast(3446) and arg_293_0._specialSummonedMonsterIdCountsInRound[arg_293_1._id] ~= nil then
		return false
	end

	if arg_293_1:hasSkillFast(2460) and arg_293_0._specialSummonedMonsterInfoIdCountsInRound[Data.getOriginId(arg_293_1._infoId)] ~= nil then
		return false
	end

	if arg_293_1:hasSkillFast(3676) and #arg_293_0:getBattleCardsByInfoId("S", Data._skillInfo[3676]._refCards[1]) == 0 then
		return false
	end

	if arg_293_1:hasSkillFast(6262) and (arg_293_1._status == BattleData.CardStatus.pile or arg_293_1._status == BattleData.CardStatus.grave) then
		return false
	end

	if arg_293_0:hasBattleCardsBySkillFast("B", 13287) and arg_293_1._info._category ~= Data._skillInfo[13287]._refCards[1] then
		return false
	end

	local var_293_9 = arg_293_0:getBoardCards()
	local var_293_10 = var_293_0:getBoardCards()
	local var_293_11 = B.mergeTable({
		var_293_9,
		var_293_10
	})

	if B.cardsHaveSkillId(var_293_10, 6027) and arg_293_1._status == BattleData.CardStatus.pile and not arg_293_1:isNature(Data.CardNature.wind) then
		return false
	end

	if B.cardsHaveSkillId(var_293_10, 6043) and arg_293_1._status == BattleData.CardStatus.pile and not arg_293_1:isNature(Data.CardNature.light) then
		return false
	end

	if B.cardsHaveSkillId(var_293_10, 6060) and arg_293_1._status == BattleData.CardStatus.pile and not arg_293_1:isNature(Data.CardNature.dark) then
		return false
	end

	if B.cardsHaveSkillId(var_293_10, 6083) and arg_293_1._status == BattleData.CardStatus.pile and not arg_293_1:isNature(Data.CardNature.water) then
		return false
	end

	if B.cardsHaveSkillId(var_293_10, 6115) and arg_293_1._status == BattleData.CardStatus.pile and not arg_293_1:isNature(Data.CardNature.earth) then
		return false
	end

	if B.cardsHaveSkillId(var_293_10, 6126) and arg_293_1._status == BattleData.CardStatus.pile and not arg_293_1:isNature(Data.CardNature.fire) then
		return false
	end

	if B.cardsHaveSkillId(var_293_10, 13914) and arg_293_1._status == BattleData.CardStatus.grave then
		return false
	end

	if B.cardsHaveSkillId(var_293_10, 13915) and arg_293_1._status == BattleData.CardStatus.leave then
		return false
	end

	if B.cardsHaveSkillId(var_293_10, 14152) and arg_293_1._type == Data.CardType.rare then
		return false
	end

	if B.cardsHaveSkillId(var_293_9, 6121) and arg_293_1._info._category ~= Data._skillInfo[6121]._refCards[1] then
		return false
	end

	if B.cardsHaveSkillId(var_293_9, 6150) and arg_293_1._info._category ~= Data._skillInfo[6150]._refCards[1] then
		return false
	end

	if B.cardsHaveSkillId(var_293_11, 6081) and arg_293_1._atk >= Data._skillInfo[6081]._val[1] then
		return false
	end

	if B.cardsHaveSkillId(var_293_9, 6129) and arg_293_1._status == BattleData.CardStatus.rare then
		return false
	end

	if B.cardsHaveSkillId(var_293_9, 6141) and not arg_293_1:isNature(Data.CardNature.dark) then
		return false
	end

	if B.cardsHaveSkillId(var_293_11, 6523) and arg_293_1:isNature(Data.CardNature.dark) then
		return false
	end

	if B.cardsHaveSkillId(var_293_11, 9237) and arg_293_1:isToken() then
		return false
	end

	if B.cardsHaveSkillId(var_293_11, 2307) and arg_293_1:getStar() ~= Data.XYZ_STAR and arg_293_1:getStar() >= Data._skillInfo[2307]._val[1] and #B.filterHasBuffCards(arg_293_0:getBattleCardsBySkillFast("B", 2307), BattleData.PositiveType.xyzMark) + #B.filterHasBuffCards(var_293_0:getBattleCardsBySkillFast("B", 2307), BattleData.PositiveType.xyzMark) > 0 then
		return false
	end

	if arg_293_1:hasSkillFast(2742) and #B.filterInCategoryCards(var_293_9, Data._skillInfo[2742]._refCards[1]) < Data._skillInfo[2742]._val[1] then
		return false
	end

	local var_293_12 = var_293_0:getBattleCardsBySkillFast("S", 7590)[1]

	if var_293_12 ~= nil and not arg_293_1:isAtkHide() and var_293_12._binds[1] and arg_293_1._maxAtk <= var_293_12._binds[1]._maxAtk then
		return false
	end

	if (arg_293_0:hasBattleCardsBySkillFast("S", 7289) or var_293_0:hasBattleCardsBySkillFast("S", 7289)) and arg_293_0._isNormalSummoned then
		return false
	end

	if arg_293_1._atk <= Data._skillInfo[7518]._val[1] and (arg_293_0:hasBattleCardsBySkillFast("S", 7518) or var_293_0:hasBattleCardsBySkillFast("S", 7518)) then
		return false
	end

	if #arg_293_0:getBattleCardsByTypeGroup("G", {
		Data.CardType.magic,
		Data.CardType.trap
	}) > 0 and #B.filterSameNameCards(arg_293_0:getBattleCardsBySkillFast("H", 9734), arg_293_1) > 0 then
		return false
	end

	if B.cardsHaveSkillId(var_293_10, 13129) and #B.filterInNatureCards(B.filterCeremonyMonsterCards(var_293_10), arg_293_1._info._nature) > 0 then
		return false
	end

	return true
end

function var_0_0.canSummonRareCard(arg_294_0, arg_294_1, arg_294_2, arg_294_3)
	if arg_294_0._mark6423 ~= nil and arg_294_1._status == BattleData.CardStatus.rare and (arg_294_1._info._category ~= Data._skillInfo[6423]._refCards[2] or not arg_294_1:isNature(Data._skillInfo[6423]._refCards[3]) or not arg_294_1:isSync()) then
		return false
	end

	if arg_294_0._isSpecialSummonDisabledBy2562 and not arg_294_1:isNature(Data._skillInfo[2562]._refCards[3]) then
		return false
	end

	if arg_294_0._isSpecialSummonDisabledBy2872 and not arg_294_1:isKeyword(Data._skillInfo[2872]._refCards[1]) then
		return false
	end

	if arg_294_0._isSpecialSummonDisabledBy9094 and arg_294_1._info._category ~= Data._skillInfo[9094]._refCards[1] then
		return false
	end

	if arg_294_0._isSpecialSummonDisabledBy9861 and (not arg_294_1:isNature(Data._skillInfo[9861]._refCards[1]) or not (arg_294_1:getStar() >= Data._skillInfo[9861]._val[1]) or arg_294_1:isXYZ() or not not arg_294_1:isLink()) then
		return false
	end

	if arg_294_0._isSpecialSummonDisabledBy4943 and arg_294_1._info._category ~= Data._skillInfo[4943]._refCards[2] and arg_294_1._info._category ~= Data._skillInfo[4943]._refCards[3] then
		return false
	end

	if arg_294_0._isSpecialSummonDisabledBy13190 then
		return false
	end

	if arg_294_0._mark13790 then
		local var_294_0 = arg_294_1:getRareOption()

		if var_294_0 ~= nil and arg_294_0._mark13790[var_294_0] ~= nil and arg_294_0._mark13790[var_294_0] > 0 then
			return false
		end
	end

	if arg_294_1._status == BattleData.CardStatus.rare then
		if arg_294_0._isSummonFromRareDisabled then
			return false
		end

		if arg_294_1:isMerge() and arg_294_0._isSummonByMergeDisabled then
			return false
		end

		if not arg_294_1:isMerge() and arg_294_0._isRareSummonExcludeMergeDisabled then
			return false
		end

		if not arg_294_1:isSync() and arg_294_0._isRareSummonExcludeSyncDisabled then
			return false
		end

		if not arg_294_1:isXYZ() and arg_294_0._isRareSummonExcludeXYZDisabled then
			return false
		end

		if (not arg_294_1:isXYZ() or arg_294_1._info._category ~= Data._skillInfo[9634]._refCards[2]) and arg_294_0._isSpecialSummonDisabledBy9634 then
			return false
		end

		if not arg_294_2 and arg_294_1:hasSkillFast(3454) then
			return false
		end

		if arg_294_0:hasBattleCardsBySkillFast("S", 7106) then
			return false
		end

		if arg_294_1:isMerge() and (arg_294_0:hasBattleCardsBySkillFast("S", 8114) or arg_294_0._opponent:hasBattleCardsBySkillFast("S", 8114)) then
			return false
		end

		if arg_294_0._mark6365 ~= nil and arg_294_1._info._category ~= arg_294_0._mark6365 then
			return false
		end

		if arg_294_0._mark2959 ~= nil and not arg_294_1:isSync() then
			return false
		end

		if arg_294_0._mark2971 ~= nil and arg_294_0._totalRareSummonCount >= arg_294_0._mark2971 then
			return false
		end

		if arg_294_0._mark13019 ~= nil and not arg_294_1:isNature(arg_294_0._mark13019) then
			return false
		end

		if #arg_294_0._opponent._rareCards == 0 and arg_294_0._opponent:hasBattleCardsBySkillFast("D", 7525) and #B.filterSummonBySacrificeCards(arg_294_0:getBoardCards()) == 0 and #B.filterSummonBySacrificeCards(arg_294_0._opponent:getBoardCards()) ~= 0 then
			return false
		end

		if arg_294_0._isSpecialSummonDisabledBy14288 and not arg_294_1:isMerge() and not arg_294_1:isKeyword(Data._skillInfo[14288]._refCards[1]) then
			return false
		end

		if #B.filterCanEffectTrapCards(arg_294_0:getBattleCardsBySkillFast("S", 8121)) + #B.filterCanEffectTrapCards(arg_294_0._opponent:getBattleCardsBySkillFast("S", 8121)) > 0 and arg_294_0._rareSummonCountInRound + arg_294_0._opponent._rareSummonCountInRound >= Data._skillInfo[8121]._val[1] then
			return false
		end

		if arg_294_1._owner._opponent:hasBattleCardsBySkillFast("S", 7524) then
			return false
		end

		if not arg_294_1:isSync() and arg_294_1._owner._opponent:hasBattleCardsBySkillFast("S", 5639) then
			return false
		end

		if not arg_294_1:isLink() and arg_294_1._owner._opponent:hasBattleCardsBySkillFast("S", 5640) then
			return false
		end
	elseif (arg_294_1._status == BattleData.CardStatus.grave or arg_294_1._status == BattleData.CardStatus.leave) and not arg_294_3 then
		if arg_294_1:isSync() then
			if not arg_294_1._summonedBySync then
				return false
			end
		elseif arg_294_1:isXYZ() then
			if not arg_294_1._summonedByXYZ then
				return false
			end
		elseif arg_294_1:isLink() then
			if not arg_294_1._summonedByLink then
				return false
			end
		elseif not arg_294_1._summonedByMerge then
			return false
		end
	end

	if not arg_294_2 and (arg_294_1:hasSkillFast(6357) and not arg_294_1._summonBySync or arg_294_1:hasSkillFast(2892) or arg_294_1:hasSkillFast(9649)) then
		return false
	end

	return true
end

function var_0_0.canUseSyncCard(arg_295_0, arg_295_1, arg_295_2)
	if arg_295_0._mark5317 or arg_295_0._opponent._mark5317 then
		return infoIds
	end

	return arg_295_0:isValidSyncResultByTriggerCard(arg_295_1._infoId, arg_295_1, arg_295_2)
end

function var_0_0.canUseXYZCard(arg_296_0, arg_296_1, arg_296_2)
	if arg_296_0._mark5317 or arg_296_0._opponent._mark5317 then
		return infoIds
	end

	return arg_296_0:isValidXYZResultByTriggerCard(arg_296_1._infoId, arg_296_1, arg_296_2)
end

function var_0_0.canUseLinkCard(arg_297_0, arg_297_1, arg_297_2)
	return arg_297_0:isValidLinkResultByTriggerCard(arg_297_1._infoId, arg_297_1, arg_297_2)
end

function var_0_0.canDrawCards(arg_298_0)
	if #arg_298_0._pileCards == 0 then
		return false
	end

	return #arg_298_0:filterCanChangeToHandCards({
		arg_298_0._pileCards[1]
	}) > 0
end

function var_0_0.filterCanChangeToBoardCards(arg_299_0, arg_299_1, arg_299_2, arg_299_3, arg_299_4, arg_299_5)
	if not arg_299_5 and arg_299_0:getEmptyBoardPos() == nil then
		return {}
	end

	local var_299_0 = {}

	for iter_299_0 = 1, #arg_299_1 do
		if arg_299_1[iter_299_0]:isMonsterRare() and (arg_299_5 or arg_299_0:getEmptyBoardPos(arg_299_1[iter_299_0])) then
			var_299_0[#var_299_0 + 1] = arg_299_1[iter_299_0]
		end
	end

	if arg_299_4 then
		return var_299_0
	else
		return B.filterCanSpecialSummonCards(var_299_0, arg_299_2, arg_299_3)
	end
end

function var_0_0.filterCanChangeToHandCards(arg_300_0, arg_300_1)
	local var_300_0 = {}

	if arg_300_0._isSpecialSummonDisabledBy13191 then
		return var_300_0
	end

	if arg_300_0._opponent:hasBattleCardsBySkillFast("B", 6075) then
		arg_300_1 = B.filterNotInStatusCards(arg_300_1, BattleData.CardStatus.grave)
	end

	if arg_300_0._mark4319 then
		arg_300_1 = B.filterNotInStatusCards(arg_300_1, BattleData.CardStatus.pile)
	end

	for iter_300_0 = 1, #arg_300_1 do
		if not arg_300_1[iter_300_0]:isChangingToStatus({
			BattleData.CardStatus.grave,
			BattleData.CardStatus.leave,
			BattleData.CardStatus.board,
			BattleData.CardStatus.hand
		}) then
			var_300_0[#var_300_0 + 1] = arg_300_1[iter_300_0]
		end
	end

	return var_300_0
end

function var_0_0.filterCanUseMagicOnTargetCards(arg_301_0, arg_301_1, arg_301_2)
	local var_301_0 = {}

	for iter_301_0 = 1, #arg_301_1 do
		if arg_301_0:canUseMagicOnTarget(arg_301_1[iter_301_0], arg_301_2) then
			var_301_0[#var_301_0 + 1] = arg_301_1[iter_301_0]
		end
	end

	return var_301_0
end

function var_0_0.filterCanUse7113Cards(arg_302_0, arg_302_1)
	local var_302_0 = {}

	for iter_302_0 = 1, #arg_302_1 do
		if arg_302_0:canUseMonster7113(arg_302_1[iter_302_0]) then
			var_302_0[#var_302_0 + 1] = arg_302_1[iter_302_0]
		end
	end

	return var_302_0
end

function var_0_0.filterSacrificeCards(arg_303_0, arg_303_1)
	local var_303_0 = B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_303_1))

	B.appendTable(var_303_0, B.sortCardsByBoardPos(arg_303_0._opponent:getBattleCardsByBuff("B", false, BattleData.NegativeType.canBeSacriByOppo)))

	return var_303_0
end

function var_0_0.isGraveSkill(arg_304_0, arg_304_1, arg_304_2, arg_304_3)
	if arg_304_1 == nil then
		return false
	end

	if arg_304_3 ~= (B.skillHasMode(arg_304_1, Data.SkillMode.initiative_bcs) or B.skillHasMode(arg_304_1, Data.SkillMode.initiative_grave) or B.skillHasMode(arg_304_1, Data.SkillMode.initiative_hand) or B.skillHasMode(arg_304_1, Data.SkillMode.initiative_rare) or B.skillHasMode(arg_304_1, Data.SkillMode.initiative_leave)) then
		return false
	end

	local var_304_0 = arg_304_0._opponent
	local var_304_1 = Data._skillInfo[arg_304_1._id]
	local var_304_2 = var_304_1._val[math.min(arg_304_1._level, #var_304_1._val)] or 0

	if arg_304_1._id == 14610 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), 6))), 1
	elseif arg_304_1._id == 14611 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoId("P", 20301)), 1
	elseif arg_304_1._id == 3002 or arg_304_1._id == 3351 or arg_304_1._id == 3357 or arg_304_1._id == 3680 then
		local var_304_3 = B.sortCardsByBoardPos(B.filterNotBindedAllyEquipCards(arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[1])))

		if #var_304_3 > 0 then
			return true, var_304_3, 1
		end
	elseif arg_304_1._id == 3003 then
		local var_304_4 = B.sortCardsByBoardPos(B.filterNotBindedAllyEquipCards(arg_304_0:getBattleCardsByInfoIdGroup("B", {
			var_304_1._refCards[1],
			var_304_1._refCards[2]
		})))

		if #var_304_4 > 0 then
			return true, var_304_4, 1
		end
	elseif arg_304_1._id == 3007 then
		local var_304_5 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2, Data.CARD_MAX_LEVEL, arg_304_1._owner))

		if #var_304_5 > 0 then
			return true, var_304_5, 1
		end
	elseif arg_304_1._id == 3012 then
		local var_304_6 = B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner))
		})

		if #var_304_6 > 0 then
			return true, var_304_6, 1
		end
	elseif arg_304_1._id == 3016 then
		return true, arg_304_0:getBattleCardsByCategory("H", Data.CardCategory.dragon, Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 3017 or arg_304_1._id == 3248 or arg_304_1._id == 3534 or arg_304_1._id == 3625 or arg_304_1._id == 3646 or arg_304_1._id == 3664 or arg_304_1._id == 3729 or arg_304_1._id == 3804 or arg_304_1._id == 3899 or arg_304_1._id == 3903 or arg_304_1._id == 3915 or arg_304_1._id == 3921 or arg_304_1._id == 4115 or arg_304_1._id == 4601 or arg_304_1._id == 4625 or arg_304_1._id == 4737 or arg_304_1._id == 4841 or arg_304_1._id == 4990 or arg_304_1._id == 5060 or arg_304_1._id == 5295 or arg_304_1._id == 5568 or arg_304_1._id == 6255 or arg_304_1._id == 6257 or arg_304_1._id == 6322 or arg_304_1._id == 6385 or arg_304_1._id == 6439 or arg_304_1._id == 6470 or arg_304_1._id == 6501 or arg_304_1._id == 6502 or arg_304_1._id == 6534 or arg_304_1._id == 6695 or arg_304_1._id == 6701 or arg_304_1._id == 6741 or arg_304_1._id == 6755 or arg_304_1._id == 6763 or arg_304_1._id == 6879 or arg_304_1._id == 6887 or arg_304_1._id == 6983 or arg_304_1._id == 6986 or arg_304_1._id == 2100 or arg_304_1._id == 2157 or arg_304_1._id == 2248 or arg_304_1._id == 2265 or arg_304_1._id == 2287 or arg_304_1._id == 2292 or arg_304_1._id == 2314 or arg_304_1._id == 2447 or arg_304_1._id == 2543 or arg_304_1._id == 2546 or arg_304_1._id == 2148 or arg_304_1._id == 2278 or arg_304_1._id == 2552 or arg_304_1._id == 2556 or arg_304_1._id == 2621 or arg_304_1._id == 2639 or arg_304_1._id == 2694 or arg_304_1._id == 2727 or arg_304_1._id == 2758 or arg_304_1._id == 2813 or arg_304_1._id == 2944 or arg_304_1._id == 9011 or arg_304_1._id == 9070 or arg_304_1._id == 9246 or arg_304_1._id == 9309 or arg_304_1._id == 9312 or arg_304_1._id == 9333 or arg_304_1._id == 9447 or arg_304_1._id == 9516 or arg_304_1._id == 9539 or arg_304_1._id == 9736 or arg_304_1._id == 9762 or arg_304_1._id == 9818 or arg_304_1._id == 9921 or arg_304_1._id == 9927 or arg_304_1._id == 9970 or arg_304_1._id == 9982 or arg_304_1._id == 7270 or arg_304_1._id == 7649 or arg_304_1._id == 7696 or arg_304_1._id == 8136 or arg_304_1._id == 13030 or arg_304_1._id == 13309 or arg_304_1._id == 13312 or arg_304_1._id == 13328 or arg_304_1._id == 13331 or arg_304_1._id == 13336 or arg_304_1._id == 13369 or arg_304_1._id == 13439 or arg_304_1._id == 13466 or arg_304_1._id == 13471 or arg_304_1._id == 13473 or arg_304_1._id == 13516 or arg_304_1._id == 13526 or arg_304_1._id == 13648 or arg_304_1._id == 13652 or arg_304_1._id == 13728 or arg_304_1._id == 13813 or arg_304_1._id == 13814 or arg_304_1._id == 13837 or arg_304_1._id == 13843 or arg_304_1._id == 13882 then
		return true, B.sortCardsByBoardPos(var_304_0:getBoardCards()), 1
	elseif arg_304_1._id == 3024 then
		return true, var_304_0:filterCanChangeToHandCards(B.sortCardsByBoardPos(var_304_0:getBoardCards())), 1
	elseif arg_304_1._id == 3025 or arg_304_1._id == 4610 or arg_304_1._id == 2484 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByType("G", Data.CardType.magic)), 1
	elseif arg_304_1._id == 3034 or arg_304_1._id == 3035 or arg_304_1._id == 3127 or arg_304_1._id == 3247 or arg_304_1._id == 3473 or arg_304_1._id == 3474 or arg_304_1._id == 3484 then
		local var_304_7 = arg_304_0:getBattleCards("H")

		if #var_304_7 > 0 then
			return true, var_304_7, 1
		end
	elseif arg_304_1._id == 3073 then
		local var_304_8 = B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner)),
			arg_304_0:getBattleCards("CSD")
		})

		if #var_304_8 > 0 then
			return true, var_304_8, 1
		end
	elseif arg_304_1._id == 3084 then
		if arg_304_0._fortress._hp <= 1000 then
			return false
		end

		local var_304_9 = arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_304_0:getBattleCardsByMaxStar("R", var_304_2), false))

		if #var_304_9 > 0 then
			return true, var_304_9, 1
		end
	elseif arg_304_1._id == 3126 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterOriginDefLessThanCards(arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[1]), var_304_2))), 1
	elseif arg_304_1._id == 3173 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxOriginAtk("H", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3177 then
		local var_304_10 = B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBoardCards(), BattleData.PositiveType.shieldMonster))

		if #var_304_10 >= 2 then
			return true, var_304_10, 2
		end
	elseif arg_304_1._id == 3188 then
		local var_304_11 = B.sortCardsByBoardPos(B.filterCanActionCards(B.filterSummonBySacrificeCards(arg_304_0:getBoardCards())))

		if #var_304_11 > 0 then
			return true, var_304_11, 1
		end
	elseif arg_304_1._id == 3202 then
		local var_304_12 = B.sortCardsByBoardPos(B.filterCanActionCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStar("B", var_304_2), var_304_1._refCards[1])))

		if #var_304_12 >= 2 then
			return true, var_304_12, 2
		end
	elseif arg_304_1._id == 3250 then
		local var_304_13 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic), var_304_1._refCards[1])))

		if #var_304_13 > 0 then
			return true, var_304_13, 1
		end
	elseif arg_304_1._id == 3253 then
		local var_304_14 = var_304_0:getBattleCardsByType("SD", Data.CardType.magic)

		if #var_304_14 > 0 then
			return true, var_304_14, 1
		end
	elseif arg_304_1._id == 3257 or arg_304_1._id == 3947 or arg_304_1._id == 4329 or arg_304_1._id == 4356 or arg_304_1._id == 4507 or arg_304_1._id == 4518 or arg_304_1._id == 4618 or arg_304_1._id == 4749 or arg_304_1._id == 4769 or arg_304_1._id == 4830 or arg_304_1._id == 4919 or arg_304_1._id == 7347 or arg_304_1._id == 7360 or arg_304_1._id == 7512 or arg_304_1._id == 7715 or arg_304_1._id == 5122 or arg_304_1._id == 5229 or arg_304_1._id == 5351 or arg_304_1._id == 5461 or arg_304_1._id == 5481 or arg_304_1._id == 6448 or arg_304_1._id == 6524 or arg_304_1._id == 6557 or arg_304_1._id == 6611 or arg_304_1._id == 2099 or arg_304_1._id == 2109 or arg_304_1._id == 2231 or arg_304_1._id == 2247 or arg_304_1._id == 2258 or arg_304_1._id == 2323 or arg_304_1._id == 2382 or arg_304_1._id == 2402 or arg_304_1._id == 2412 or arg_304_1._id == 2465 or arg_304_1._id == 2516 or arg_304_1._id == 2791 or arg_304_1._id == 2801 or arg_304_1._id == 2812 or arg_304_1._id == 2850 or arg_304_1._id == 2890 or arg_304_1._id == 8132 or arg_304_1._id == 9111 or arg_304_1._id == 9459 or arg_304_1._id == 9569 or arg_304_1._id == 9722 or arg_304_1._id == 9807 or arg_304_1._id == 9835 or arg_304_1._id == 8021 or arg_304_1._id == 13052 or arg_304_1._id == 13109 or arg_304_1._id == 13145 or arg_304_1._id == 13148 or arg_304_1._id == 13232 or arg_304_1._id == 13440 or arg_304_1._id == 13447 or arg_304_1._id == 13505 or arg_304_1._id == 13534 or arg_304_1._id == 13549 or arg_304_1._id == 13562 or arg_304_1._id == 13605 or arg_304_1._id == 13744 or arg_304_1._id == 13785 or arg_304_1._id == 13798 or arg_304_1._id == 13867 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")), 1
	elseif arg_304_1._id == 3262 then
		local var_304_15 = arg_304_0:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_304_1._owner)
		local var_304_16 = arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCards("P"))

		if #var_304_15 >= 2 and #var_304_16 > 0 then
			return true, var_304_15, 2
		end
	elseif arg_304_1._id == 3264 then
		local var_304_17 = B.sortCardsByBoardPos(B.filterDefPostureCards(var_304_0:getBoardCards(), false))

		if #var_304_17 > 0 then
			return true, var_304_17, 1
		end
	elseif arg_304_1._id == 3268 then
		local var_304_18 = arg_304_0:getBattleCardsByMinStar("G", var_304_2)

		if #var_304_18 > 0 then
			return true, var_304_18, 1
		end
	elseif arg_304_1._id == 3309 then
		local var_304_19 = B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotActionedCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]))))

		if #var_304_19 > 0 then
			return true, var_304_19, 1
		end
	elseif arg_304_1._id == 3317 or arg_304_1._id == 3318 then
		local var_304_20 = arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), arg_304_1._owner))

		if #var_304_20 > 0 then
			return true, var_304_20, 1
		end
	elseif arg_304_1._id == 3319 then
		local var_304_21 = var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("C"))

		if #var_304_21 > 0 then
			return true, var_304_21, 1
		end
	elseif arg_304_1._id == 3320 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)),
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByNature("B", var_304_1._refCards[1]))
		}), 1
	elseif arg_304_1._id == 3324 then
		local var_304_22 = B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCanAddMagicMark("BSD"))

		if #var_304_22 > 0 then
			return true, var_304_22, 1
		end
	elseif arg_304_1._id == 3329 then
		local var_304_23 = arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])

		if #var_304_23 > 1 then
			return true, var_304_23, 2
		end
	elseif arg_304_1._id == 3331 then
		local var_304_24 = B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))
		local var_304_25 = var_304_0:getBoardCards()

		if #var_304_24 > 0 and #var_304_25 > 0 then
			return true, var_304_24, 1
		end
	elseif arg_304_1._id == 3334 then
		local var_304_26 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("GPH", Data.CardType.monster), var_304_1._refCards[1])))

		if #var_304_26 > 0 then
			return true, var_304_26, 1
		end
	elseif arg_304_1._id == 3344 then
		local var_304_27 = arg_304_0:getBattleCards("H")
		local var_304_28 = var_304_0:getBattleCards("BSD")

		if #var_304_27 > 0 and #var_304_28 > 0 then
			return true, var_304_27, 1
		end
	elseif arg_304_1._id == 3361 or arg_304_1._id == 3363 then
		local var_304_29 = arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])

		if var_304_2 <= #var_304_29 then
			return true, var_304_29, var_304_2
		end
	elseif arg_304_1._id == 3365 then
		local var_304_30 = arg_304_0:getBattleCards("SD")

		if #var_304_30 > 0 then
			return true, var_304_30, 1
		end
	elseif arg_304_1._id == 3368 then
		local var_304_31 = arg_304_0:getBattleCards("CSD")

		if #var_304_31 >= 2 then
			return true, var_304_31, 2
		end
	elseif arg_304_1._id == 3369 then
		local var_304_32 = var_304_0:getBattleCards("CSD")

		if #var_304_32 > 0 then
			return true, var_304_32, 1
		end
	elseif arg_304_1._id == 3370 or arg_304_1._id == 3371 then
		local var_304_33 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoId("GPH", var_304_1._refCards[1]), true, nil, nil, true)

		if #var_304_33 > 0 then
			return true, var_304_33, 1
		end
	elseif arg_304_1._id == 3375 or arg_304_1._id == 3377 then
		local var_304_34 = B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]))

		if #var_304_34 > 0 then
			return true, var_304_34, 1
		end
	elseif arg_304_1._id == 3379 then
		local var_304_35 = arg_304_0:getBattleCardsByNature("H", var_304_1._refCards[1])

		if #var_304_35 > 0 then
			return true, var_304_35, 1
		end
	elseif arg_304_1._id == 3380 then
		local var_304_36 = B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)))

		if #var_304_36 > 0 then
			return true, var_304_36, 1
		end
	elseif arg_304_1._id == 3382 then
		local var_304_37 = arg_304_1._owner:getBuffValue(true, BattleData.PositiveType.magicMark) + arg_304_1._owner._owner:getFieldMagicMark()

		if var_304_37 > 0 then
			local var_304_38 = arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("GH", var_304_37), var_304_1._refCards[1]))

			if #var_304_38 > 0 then
				return true, var_304_38, 1
			end
		end
	elseif arg_304_1._id == 3383 or arg_304_1._id == 3494 or arg_304_1._id == 3715 or arg_304_1._id == 3861 or arg_304_1._id == 3873 or arg_304_1._id == 3875 or arg_304_1._id == 3883 or arg_304_1._id == 3912 or arg_304_1._id == 3986 or arg_304_1._id == 4338 or arg_304_1._id == 4486 or arg_304_1._id == 4959 or arg_304_1._id == 5191 or arg_304_1._id == 5571 or arg_304_1._id == 5572 or arg_304_1._id == 6275 or arg_304_1._id == 6361 or arg_304_1._id == 6519 or arg_304_1._id == 6549 or arg_304_1._id == 6746 or arg_304_1._id == 6772 or arg_304_1._id == 6899 or arg_304_1._id == 6923 or arg_304_1._id == 6973 or arg_304_1._id == 2111 or arg_304_1._id == 2203 or arg_304_1._id == 2212 or arg_304_1._id == 2320 or arg_304_1._id == 2449 or arg_304_1._id == 2494 or arg_304_1._id == 2585 or arg_304_1._id == 2587 or arg_304_1._id == 2766 or arg_304_1._id == 2959 or arg_304_1._id == 7192 or arg_304_1._id == 7198 or arg_304_1._id == 7285 or arg_304_1._id == 7309 or arg_304_1._id == 7310 or arg_304_1._id == 7332 or arg_304_1._id == 7433 or arg_304_1._id == 7542 or arg_304_1._id == 9320 or arg_304_1._id == 9497 or arg_304_1._id == 9556 or arg_304_1._id == 9614 or arg_304_1._id == 9615 or arg_304_1._id == 9721 or arg_304_1._id == 9815 or arg_304_1._id == 9841 or arg_304_1._id == 13097 or arg_304_1._id == 13380 then
		return true, arg_304_0:getBattleCards("H"), 1
	elseif arg_304_1._id == 3385 then
		local var_304_39 = B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1])))

		if #var_304_39 > 0 then
			return true, var_304_39, 1
		end
	elseif arg_304_1._id == 3389 then
		local var_304_40 = B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner)))

		if #var_304_40 > 0 then
			return true, var_304_40, 1
		end
	elseif arg_304_1._id == 3391 then
		local var_304_41 = arg_304_0:getBattleCardsByNature("G", var_304_1._refCards[1])

		if var_304_2 <= #var_304_41 then
			return true, var_304_41, var_304_2
		end
	elseif arg_304_1._id == 3396 then
		local var_304_42 = B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster), var_304_1._refCards[1])

		if #var_304_42 > 0 then
			return true, var_304_42, 1
		end
	elseif arg_304_1._id == 3397 then
		local var_304_43 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("GPH", var_304_1._refCards[1])))

		if #var_304_43 > 0 then
			return true, var_304_43, 1
		end
	elseif arg_304_1._id == 3398 or arg_304_1._id == 3443 or arg_304_1._id == 4188 then
		local var_304_44 = B.sortCardsByBoardPos(var_304_0:getBoardCards())

		if #var_304_44 > 0 then
			return true, var_304_44, 1
		end
	elseif arg_304_1._id == 3401 then
		if arg_304_0:getEmptyBoardPos() ~= nil then
			local var_304_45 = B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1])

			if #var_304_45 > 0 then
				return true, var_304_45, 1
			end
		end
	elseif arg_304_1._id == 3406 then
		local var_304_46 = B.getMaxStarCard(arg_304_0:getBattleCardsByCategory("H", var_304_1._refCards[1])):getStar()
		local var_304_47 = B.sortCardsByBoardPos(var_304_0:getBattleCardsByMaxStar("B", var_304_46))

		if #var_304_47 > 0 then
			return true, var_304_47, 1
		end
	elseif arg_304_1._id == 3410 or arg_304_1._id == 3412 or arg_304_1._id == 3614 or arg_304_1._id == 3667 or arg_304_1._id == 3679 or arg_304_1._id == 3750 or arg_304_1._id == 3823 then
		local var_304_48 = B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			B.sortCardsByBoardPos(arg_304_0:getBoardCards())
		})

		if #var_304_48 > 0 then
			return true, var_304_48, 1
		end
	elseif arg_304_1._id == 3414 then
		local var_304_49 = B.filterHasSkillCards(var_304_0:getBattleCards("BS"))

		if #var_304_49 > 0 then
			return true, var_304_49, 1
		end
	elseif arg_304_1._id == 3421 then
		local var_304_50 = var_304_0:getBattleCards("CSD")

		if #var_304_50 > 0 then
			return true, var_304_50, 1
		end
	elseif arg_304_1._id == 3423 then
		local var_304_51 = B.sortCardsByBoardPos(B.filterNotSameNameCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]), arg_304_1._owner))

		if #var_304_51 > 0 then
			return true, var_304_51, 1
		end
	elseif arg_304_1._id == 3424 then
		local var_304_52 = var_304_0:getBattleCards("CSD")

		if #var_304_52 > 0 then
			return true, var_304_52, 1
		end
	elseif arg_304_1._id == 3428 or arg_304_1._id == 3619 then
		local var_304_53 = B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))

		if #var_304_53 > 0 then
			return true, var_304_53, 1
		end
	elseif arg_304_1._id == 3430 then
		local var_304_54 = B.sortCardsByBoardPos(B.filterNotBindedAllyEquipCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1])))

		if #var_304_54 > 0 then
			return true, var_304_54, 1
		end
	elseif arg_304_1._id == 3431 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[2]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 3432 or arg_304_1._id == 3433 or arg_304_1._id == 3820 or arg_304_1._id == 3821 or arg_304_1._id == 3829 then
		local var_304_55 = B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[2]))

		if #var_304_55 > 0 then
			return true, var_304_55, 1
		end
	elseif arg_304_1._id == 3434 or arg_304_1._id == 3713 or arg_304_1._id == 3911 or arg_304_1._id == 6312 or arg_304_1._id == 4187 or arg_304_1._id == 4209 or arg_304_1._id == 4237 or arg_304_1._id == 4239 or arg_304_1._id == 4636 or arg_304_1._id == 4643 or arg_304_1._id == 4761 or arg_304_1._id == 4834 or arg_304_1._id == 4835 or arg_304_1._id == 4849 or arg_304_1._id == 4850 or arg_304_1._id == 4898 or arg_304_1._id == 4992 or arg_304_1._id == 7543 or arg_304_1._id == 7589 or arg_304_1._id == 7647 or arg_304_1._id == 5247 or arg_304_1._id == 5448 or arg_304_1._id == 5587 or arg_304_1._id == 8066 or arg_304_1._id == 2198 or arg_304_1._id == 2527 or arg_304_1._id == 2704 or arg_304_1._id == 2977 or arg_304_1._id == 9004 or arg_304_1._id == 9014 or arg_304_1._id == 9684 or arg_304_1._id == 9958 or arg_304_1._id == 13031 or arg_304_1._id == 13084 or arg_304_1._id == 13343 or arg_304_1._id == 13349 or arg_304_1._id == 13361 or arg_304_1._id == 13481 or arg_304_1._id == 13633 or arg_304_1._id == 13640 or arg_304_1._id == 13687 or arg_304_1._id == 13699 or arg_304_1._id == 13881 or arg_304_1._id == 13929 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 3435 then
		if arg_304_1._owner._status == BattleData.CardStatus.grave then
			local var_304_56 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))

			if #var_304_56 > 0 then
				return true, var_304_56, 1
			end
		end
	elseif arg_304_1._id == 3437 then
		local var_304_57 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(B.mergeTable({
			arg_304_0:getBattleCardsByType("P", Data.CardType.magic),
			arg_304_0:getBattleCardsByType("P", Data.CardType.trap)
		}), var_304_1._refCards[1])))

		if #var_304_57 > 0 then
			return true, var_304_57, 1
		end
	elseif arg_304_1._id == 3438 then
		local var_304_58 = B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1])))

		if #var_304_58 > 0 then
			return true, var_304_58, 1
		end
	elseif arg_304_1._id == 3440 then
		local var_304_59 = B.mergeTable({
			arg_304_0:getBattleCardsByType("H", Data.CardType.magic),
			arg_304_0:getBattleCardsByType("H", Data.CardType.trap)
		})

		if #var_304_59 > 0 then
			return true, var_304_59, 1
		end
	elseif arg_304_1._id == 3447 then
		local var_304_60 = B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1])

		if #var_304_60 > 0 then
			return true, var_304_60, 1
		end
	elseif arg_304_1._id == 3456 then
		local var_304_61 = B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1])))

		if #var_304_61 >= 3 then
			return true, var_304_61, 3
		end
	elseif arg_304_1._id == 3457 then
		local var_304_62 = B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner)))

		if #var_304_62 > 0 then
			return true, var_304_62, 1
		end
	elseif arg_304_1._id == 3468 or arg_304_1._id == 3470 then
		local var_304_63 = B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterCanActionCards(arg_304_0:getBoardCards())))

		if #var_304_63 >= Data._skillInfo[arg_304_1._id]._val[1] then
			return true, var_304_63, Data._skillInfo[arg_304_1._id]._val[1]
		end
	elseif arg_304_1._id == 3469 or arg_304_1._id == 2566 then
		local var_304_64 = B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBoardCards()))

		if #var_304_64 > 0 then
			return true, var_304_64, 1
		end
	elseif arg_304_1._id == 3452 or arg_304_1._id == 3472 then
		local var_304_65 = B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			var_304_0:getBattleCards("CSD")
		})

		if #var_304_65 > 0 then
			return true, var_304_65, 1
		end
	elseif arg_304_1._id == 3476 then
		local var_304_66 = B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner)),
			arg_304_0:getBattleCards("CS"),
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			var_304_0:getBattleCards("CS")
		})
		local var_304_67 = var_304_0:getBattleCards("G")

		if #var_304_66 > 0 then
			return true, var_304_66, 1
		end

		if #var_304_67 > 0 then
			return true, var_304_67, 1
		end
	elseif arg_304_1._id == 3478 then
		local var_304_68 = arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner)),
			arg_304_0:getBattleCards("CS"),
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			var_304_0:getBattleCards("CS")
		}))

		if #var_304_68 > 0 then
			return true, var_304_68, 1
		end
	elseif arg_304_1._id == 3479 then
		local var_304_69 = var_304_0:getBattleCards("CSD")

		if #var_304_69 > 0 then
			return true, var_304_69, 1
		end
	elseif arg_304_1._id == 3480 then
		local var_304_70 = arg_304_0:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_304_1._owner)

		if #var_304_70 > 0 then
			return true, var_304_70, 1
		end
	elseif arg_304_1._id == 3481 then
		local var_304_71 = B.filterSpiritCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster))

		if #var_304_71 > 0 then
			return true, var_304_71, 1
		end
	elseif arg_304_1._id == 3483 then
		local var_304_72 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterSpiritCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster)), arg_304_1._owner)))

		if #var_304_72 > 0 then
			return true, var_304_72, 1
		end
	elseif arg_304_1._id == 3489 then
		local var_304_73 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByNature("P", var_304_1._refCards[1]))

		if #var_304_73 > 0 then
			return true, var_304_73, 1
		end
	elseif arg_304_1._id == 3492 then
		local var_304_74 = B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeywordGroup("B", var_304_1._refCards))

		if #var_304_74 > 0 then
			return true, var_304_74, 1
		end
	elseif arg_304_1._id == 3493 then
		local var_304_75 = arg_304_0:getBattleCardsByNatureGroup("G", var_304_1._refCards, Data.CARD_MAX_LEVEL, arg_304_1._owner)

		if #var_304_75 > 0 then
			return true, var_304_75, 2
		end
	elseif arg_304_1._id == 3496 then
		return true, B.filterNormalCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster)), 1
	elseif arg_304_1._id == 3498 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxHp("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 3500 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByAtkDef("G", 800, 1000), arg_304_1._owner)), 1
	elseif arg_304_1._id == 3502 then
		local var_304_76 = arg_304_0:getBattleCards("H")

		if #var_304_76 > 0 then
			return true, var_304_76, 1
		end
	elseif arg_304_1._id == 3515 then
		return true, B.filterNotEqualSacrificeCountCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1]), 0), 1
	elseif arg_304_1._id == 3517 or arg_304_1._id == 4665 or arg_304_1._id == 6441 or arg_304_1._id == 2992 or arg_304_1._id == 9007 or arg_304_1._id == 13617 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3529 or arg_304_1._id == 2185 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("PH", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 3535 then
		local var_304_77 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("PH", var_304_1._refCards[1])))
		local var_304_78 = B.filterEffectCards(var_304_0:getBoardCards())

		return true, var_304_77, math.min(math.min(math.min(#var_304_77, #var_304_78), 2), arg_304_0:getEmptyBoardPosCount())
	elseif arg_304_1._id == 3537 or arg_304_1._id == 3539 then
		local var_304_79 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterAdjustCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByStar(arg_304_1._id == 3537 and "P" or "G", var_304_2), arg_304_1._owner), true)))

		if #var_304_79 > 0 then
			return true, var_304_79, 1
		end
	elseif arg_304_1._id == 3538 or arg_304_1._id == 3540 then
		local var_304_80 = B.sortCardsByBoardPos(B.filterEffectCards(arg_304_0:getBoardCards()))

		if #var_304_80 > 0 then
			return true, var_304_80, 1
		end
	elseif arg_304_1._id == 3545 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBoardCards()),
			arg_304_0:getBattleCards("CSH")
		}), 1
	elseif arg_304_1._id == 3548 then
		local var_304_81 = B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD"))
		})
		local var_304_82 = arg_304_1._owner._sacrificedCards
		local var_304_83 = B.filterNoMark6140Cards(var_304_82)

		return true, var_304_81, math.min(#var_304_81, var_304_82 ~= nil and #var_304_82 > 0 and #var_304_83 == #B.filterInNatureCards(var_304_83, var_304_1._refCards[1]) and 2 or 1)
	elseif arg_304_1._id == 3550 then
		return true, arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]),
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]))
		})), 1
	elseif arg_304_1._id == 3551 then
		local var_304_84 = arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2)))

		if #var_304_84 > 0 then
			return true, var_304_84, 1
		end
	elseif arg_304_1._id == 3552 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCards("G", Data.CardType.monster), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3554 then
		local var_304_85 = arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(B.filterInNatureCards(arg_304_0:getBattleCardsByStar("H", var_304_2, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1]), true))

		if #var_304_85 > 0 then
			return true, var_304_85, 1
		end
	elseif arg_304_1._id == 3558 then
		local var_304_86 = arg_304_0:filterCanChangeToHandCards(B.filterCeremonyMonsterCards(arg_304_0:getBattleCards("P")))

		if #var_304_86 > 0 then
			return true, var_304_86, 1
		end
	elseif arg_304_1._id == 3570 then
		local var_304_87 = B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]))

		if #var_304_87 > 0 then
			return true, var_304_87, 1
		end
	elseif arg_304_1._id == 3575 then
		return true, B.filterFirstCards(var_304_0:getBattleCards("H"), 2), 1
	elseif arg_304_1._id == 3578 then
		local var_304_88 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterCeremonyMagicCards(arg_304_0:getBattleCards("P"))))

		if #var_304_88 > 0 then
			return true, var_304_88, 1
		end
	elseif arg_304_1._id == 3585 or arg_304_1._id == 3588 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCardsByCategory("HG", var_304_1._refCards[1]),
			var_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])
		})), 1
	elseif arg_304_1._id == 3573 then
		return true, arg_304_0:getBattleCardsByKeyword("GH", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 3555 or arg_304_1._id == 13411 then
		return true, B.sortCardsByBoardPos(B.filterEffectCards(arg_304_0:getBoardCards())), 1
	elseif arg_304_1._id == 3593 then
		local var_304_89 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1])))

		if #var_304_89 > 0 then
			return true, var_304_89, 1
		end
	elseif arg_304_1._id == 3594 or arg_304_1._id == 2976 or arg_304_1._id == 13441 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 3596 or arg_304_1._id == 4594 or arg_304_1._id == 7623 or arg_304_1._id == 7628 or arg_304_1._id == 2821 or arg_304_1._id == 8046 or arg_304_1._id == 9373 then
		return true, arg_304_0:getBattleCardsByCategory("H", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 3599 or arg_304_1._id == 4137 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCanAddMagicMark("BSD")), 1
	elseif arg_304_1._id == 3604 or arg_304_1._id == 13068 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner))), 1
	elseif arg_304_1._id == 3606 then
		local var_304_90 = B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]))

		if #var_304_90 > 0 then
			return true, var_304_90, 1
		end
	elseif arg_304_1._id == 3607 or arg_304_1._id == 3862 or arg_304_1._id == 4262 or arg_304_1._id == 4495 or arg_304_1._id == 4631 or arg_304_1._id == 4961 or arg_304_1._id == 6365 or arg_304_1._id == 6978 or arg_304_1._id == 2390 or arg_304_1._id == 2578 then
		return true, arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 3614 or arg_304_1._id == 4258 or arg_304_1._id == 4330 or arg_304_1._id == 4453 or arg_304_1._id == 4529 or arg_304_1._id == 5237 or arg_304_1._id == 5512 or arg_304_1._id == 6381 or arg_304_1._id == 6537 or arg_304_1._id == 6698 or arg_304_1._id == 2392 or arg_304_1._id == 2483 or arg_304_1._id == 9282 or arg_304_1._id == 9352 or arg_304_1._id == 8012 or arg_304_1._id == 13212 or arg_304_1._id == 13249 or arg_304_1._id == 13341 or arg_304_1._id == 13394 or arg_304_1._id == 13754 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBoardCards()), 1
	elseif arg_304_1._id == 3621 then
		return true, B.filterNotSameNameCards(B.filterDualCards(arg_304_0:getBattleCards("G")), arg_304_1._owner), 1
	elseif arg_304_1._id == 3631 or arg_304_1._id == 3714 or arg_304_1._id == 4288 or arg_304_1._id == 4397 or arg_304_1._id == 4416 or arg_304_1._id == 4417 or arg_304_1._id == 4426 or arg_304_1._id == 4485 or arg_304_1._id == 4941 or arg_304_1._id == 4991 or arg_304_1._id == 5599 or arg_304_1._id == 6921 or arg_304_1._id == 6964 or arg_304_1._id == 6974 or arg_304_1._id == 6982 or arg_304_1._id == 6996 or arg_304_1._id == 2341 or arg_304_1._id == 2359 or arg_304_1._id == 2630 or arg_304_1._id == 2778 or arg_304_1._id == 9786 or arg_304_1._id == 7210 or arg_304_1._id == 7551 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 3632 or arg_304_1._id == 3917 or arg_304_1._id == 6569 or arg_304_1._id == 2256 or arg_304_1._id == 2379 or arg_304_1._id == 9491 or arg_304_1._id == 9492 or arg_304_1._id == 4948 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoIdGroup("P", var_304_1._refCards))), 1
	elseif arg_304_1._id == 3640 or arg_304_1._id == 3741 or arg_304_1._id == 6252 or arg_304_1._id == 6253 or arg_304_1._id == 6704 or arg_304_1._id == 6781 or arg_304_1._id == 2196 or arg_304_1._id == 2598 or arg_304_1._id == 13121 or arg_304_1._id == 13176 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 3644 then
		local var_304_91 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterCeremonyMonsterCards(arg_304_0:getBattleCards("P")),
			B.filterCeremonyMagicCards(arg_304_0:getBattleCards("P"))
		})))

		if #var_304_91 > 0 then
			return true, var_304_91, 1
		end
	elseif arg_304_1._id == 3645 then
		local var_304_92 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByAtk("P", var_304_2), var_304_1._refCards[1])))

		if #var_304_92 > 0 then
			return true, var_304_92, 1
		end
	elseif arg_304_1._id == 3648 then
		return true, arg_304_0:getBattleCards("SD"), 1
	elseif arg_304_1._id == 3670 then
		local var_304_93 = B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[2]))

		if #var_304_93 > 0 then
			return true, var_304_93, 1
		end
	elseif arg_304_1._id == 3671 then
		return true, arg_304_0:getBattleCardsByNature("H", var_304_1._refCards[2]), 1
	elseif arg_304_1._id == 3687 then
		return true, B.sortCardsByBoardPos(B.filterDualCards(arg_304_0:getBattleCards("HB"))), 1
	elseif arg_304_1._id == 3690 or arg_304_1._id == 4224 or arg_304_1._id == 4374 or arg_304_1._id == 4480 or arg_304_1._id == 4556 or arg_304_1._id == 2457 then
		return true, B.mergeTable({
			arg_304_0:getBattleCards("CSD"),
			var_304_0:getBattleCards("CSD")
		}), 1
	elseif arg_304_1._id == 3691 or arg_304_1._id == 13327 then
		return true, B.sortCardsByBoardPos(B.filterDefPostureCards(var_304_0:getBoardCards(), false)), 1
	elseif arg_304_1._id == 3695 or arg_304_1._id == 3824 or arg_304_1._id == 3904 or arg_304_1._id == 3905 or arg_304_1._id == 3980 or arg_304_1._id == 3990 or arg_304_1._id == 2534 or arg_304_1._id == 4189 or arg_304_1._id == 4274 or arg_304_1._id == 4583 or arg_304_1._id == 4607 or arg_304_1._id == 7546 or arg_304_1._id == 7655 or arg_304_1._id == 7666 or arg_304_1._id == 7669 or arg_304_1._id == 5067 or arg_304_1._id == 5281 or arg_304_1._id == 6254 or arg_304_1._id == 6290 or arg_304_1._id == 6436 or arg_304_1._id == 6457 or arg_304_1._id == 6473 or arg_304_1._id == 6498 or arg_304_1._id == 6716 or arg_304_1._id == 6796 or arg_304_1._id == 6848 or arg_304_1._id == 6905 or arg_304_1._id == 6907 or arg_304_1._id == 2293 or arg_304_1._id == 2340 or arg_304_1._id == 2344 or arg_304_1._id == 2346 or arg_304_1._id == 2602 or arg_304_1._id == 8130 or arg_304_1._id == 9087 or arg_304_1._id == 9088 or arg_304_1._id == 9092 or arg_304_1._id == 9115 or arg_304_1._id == 9116 or arg_304_1._id == 9319 or arg_304_1._id == 9347 or arg_304_1._id == 9383 or arg_304_1._id == 9577 or arg_304_1._id == 9847 or arg_304_1._id == 9931 or arg_304_1._id == 13113 or arg_304_1._id == 13165 or arg_304_1._id == 13236 or arg_304_1._id == 13567 or arg_304_1._id == 13573 or arg_304_1._id == 13692 or arg_304_1._id == 13714 or arg_304_1._id == 13716 or arg_304_1._id == 13721 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3697 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByCategory("HG", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 3700 then
		local var_304_94 = B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoIdGroup("P", var_304_1._refCards)))

		if #var_304_94 > 0 then
			return true, var_304_94, 1
		end
	elseif arg_304_1._id == 3707 then
		return true, B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("S", Data.CardType.magic)), 1
	elseif arg_304_1._id == 3717 or arg_304_1._id == 6324 or arg_304_1._id == 6454 or arg_304_1._id == 6465 or arg_304_1._id == 2962 or arg_304_1._id == 9095 or arg_304_1._id == 13179 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 3726 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("B", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3735 then
		local var_304_95 = arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1])
		local var_304_96 = {}

		for iter_304_0 = 1, #var_304_95 do
			local var_304_97 = var_304_95[iter_304_0]

			if #arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByStar("P", var_304_97:getStar()), var_304_1._refCards[1])) > 0 then
				var_304_96[#var_304_96 + 1] = var_304_97
			end
		end

		return true, B.sortCardsByBoardPos(var_304_96), 1
	elseif arg_304_1._id == 3737 or arg_304_1._id == 3962 or arg_304_1._id == 3965 then
		return true, arg_304_0:getBattleCardsByKeyword("S", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 3742 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[2]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 3746 or arg_304_1._id == 3888 or arg_304_1._id == 3901 or arg_304_1._id == 4295 or arg_304_1._id == 4522 or arg_304_1._id == 4572 or arg_304_1._id == 5202 or arg_304_1._id == 5463 or arg_304_1._id == 5472 or arg_304_1._id == 5617 or arg_304_1._id == 5619 or arg_304_1._id == 6270 or arg_304_1._id == 6428 or arg_304_1._id == 6437 or arg_304_1._id == 2541 or arg_304_1._id == 2573 or arg_304_1._id == 2631 or arg_304_1._id == 9066 or arg_304_1._id == 9166 or arg_304_1._id == 9359 or arg_304_1._id == 7235 or arg_304_1._id == 13457 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 3749 or arg_304_1._id == 2590 or arg_304_1._id == 2945 or arg_304_1._id == 8134 or arg_304_1._id == 13495 then
		return true, var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("CSD")), 1
	elseif arg_304_1._id == 3751 or arg_304_1._id == 6714 or arg_304_1._id == 6940 or arg_304_1._id == 2592 or arg_304_1._id == 2426 or arg_304_1._id == 9780 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 3760 or arg_304_1._id == 13117 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BSD"))
		}), 1
	elseif arg_304_1._id == 3762 or arg_304_1._id == 3764 or arg_304_1._id == 3766 or arg_304_1._id == 3837 or arg_304_1._id == 3839 or arg_304_1._id == 2664 then
		return true, B.filterCanBindAlterMagicCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("GH", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner), 1
	elseif arg_304_1._id == 3768 or arg_304_1._id == 3775 or arg_304_1._id == 9069 then
		return true, arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 3772 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxOriginAtk("G", var_304_2), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 3774 then
		local var_304_98 = B.getMinStarCard(B.filterInKeywordCards(arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[2]), var_304_1._refCards[1]))

		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStar("B", var_304_98:getStar()), var_304_1._refCards[2]), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3787 or arg_304_1._id == 5157 or arg_304_1._id == 2225 or arg_304_1._id == 5005 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3788 or arg_304_1._id == 4427 or arg_304_1._id == 4671 or arg_304_1._id == 6370 or arg_304_1._id == 6434 or arg_304_1._id == 13620 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 3789 then
		local var_304_99 = B.sortCardsByBoardPos(var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("BCSD")))

		return true, var_304_99, math.min(#var_304_99, 2)
	elseif arg_304_1._id == 3802 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("S", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3806 or arg_304_1._id == 3928 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBattleCardsByNature("B", var_304_1._refCards[1]), BattleData.PositiveType.shieldMonster)), 1
	elseif arg_304_1._id == 3809 then
		return true, arg_304_0:getBattleCardsByType("S", Data.CardType.trap), 3
	elseif arg_304_1._id == 3814 or arg_304_1._id == 6391 then
		return true, B.mergeTable({
			var_304_0:getBattleCards("SD"),
			arg_304_0:getBattleCards("SD")
		}), 1
	elseif arg_304_1._id == 3815 then
		return true, B.mergeTable({
			var_304_0:getBattleCards("C"),
			arg_304_0:getBattleCards("C")
		}), 1
	elseif arg_304_1._id == 3822 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), var_304_2
	elseif arg_304_1._id == 3828 then
		local var_304_100 = B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1])

		if #var_304_100 > 0 then
			return true, var_304_100, 1
		end
	elseif arg_304_1._id == 3834 or arg_304_1._id == 5613 or arg_304_1._id == 6481 or arg_304_1._id == 6762 or arg_304_1._id == 2146 or arg_304_1._id == 13224 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3835 then
		local var_304_101 = B.mergeTable({
			arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]),
			var_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])
		})
		local var_304_102 = B.getMinStarCard(var_304_101):getStar()

		return true, B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStar("H", var_304_102), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 3836 then
		local var_304_103 = arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterCeremonyMonsterCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1])),
			B.filterCeremonyMagicCards(arg_304_0:getBattleCards("G"))
		}))

		if #var_304_103 > 0 then
			return true, var_304_103, 1
		end
	elseif arg_304_1._id == 3841 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(var_304_0:getBattleCardsByNature("B", var_304_1._refCards[1]), false, false, true)), 1
	elseif arg_304_1._id == 3842 or arg_304_1._id == 2491 or arg_304_1._id == 9697 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 3845 or arg_304_1._id == 5104 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoId("H", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3847 then
		return true, B.sortCardsByBoardPos(B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic))), 1
	elseif arg_304_1._id == 3852 or arg_304_1._id == 3854 or arg_304_1._id == 3855 then
		return true, B.sortCardsByBoardPos(arg_304_1._id == 3852 and var_304_0:getBoardCards() or var_304_0:getBattleCardsByMaxStar("B", var_304_2)), 1
	elseif arg_304_1._id == 3864 or arg_304_1._id == 6876 or arg_304_1._id == 4097 or arg_304_1._id == 4771 or arg_304_1._id == 4829 or arg_304_1._id == 5556 or arg_304_1._id == 6968 or arg_304_1._id == 2526 or arg_304_1._id == 7246 or arg_304_1._id == 7266 or arg_304_1._id == 7396 or arg_304_1._id == 13124 or arg_304_1._id == 13282 or arg_304_1._id == 13433 or arg_304_1._id == 13530 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3866 or arg_304_1._id == 2384 then
		return true, var_304_0:getBattleCards("CSD"), #arg_304_0:getBattleCardsByKeywordGroup("B", var_304_1._refCards, Data.CARD_MAX_LEVEL, arg_304_1._id == 3866 and arg_304_1._owner or nil)
	elseif arg_304_1._id == 3867 or arg_304_1._id == 4159 or arg_304_1._id == 6863 or arg_304_1._id == 2369 or arg_304_1._id == 13299 or arg_304_1._id == 13305 or arg_304_1._id == 13674 or arg_304_1._id == 13827 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeywordGroup("P", var_304_1._refCards))), 1
	elseif arg_304_1._id == 3876 or arg_304_1._id == 2093 or arg_304_1._id == 2896 or arg_304_1._id == 9591 or arg_304_1._id == 9704 or arg_304_1._id == 13446 then
		return true, B.sortCardsByBoardPos(var_304_0:filterCanChangeToHandCards(var_304_0:getBoardCards())), 1
	elseif arg_304_1._id == 3884 then
		return true, B.filterInTypeCards(arg_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1]), Data.CardType.monster), 1
	elseif arg_304_1._id == 3887 then
		local var_304_104 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2))

		if #var_304_104 > 0 then
			return true, var_304_104, 1
		end
	elseif arg_304_1._id == 3891 then
		local var_304_105 = B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1])

		if #var_304_105 > 0 then
			return true, var_304_105, 1
		end
	elseif arg_304_1._id == 3892 or arg_304_1._id == 2132 or arg_304_1._id == 2209 or arg_304_1._id == 9752 then
		return true, arg_304_0:getBattleCardsByType("H", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 3896 or arg_304_1._id == 9830 or arg_304_1._id == 9831 or arg_304_1._id == 13019 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByMinStar("B", 0, Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 3906 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 3907 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2)), 1
	elseif arg_304_1._id == 3910 then
		local var_304_106 = B.sortCardsByBoardPos(var_304_0:getBattleCardsByAtk("B", 0))

		if #var_304_106 > 0 then
			return true, var_304_106, 1
		end
	elseif arg_304_1._id == 3914 then
		return true, B.filterCanBeSacrificedCards(B.mergeTable({
			B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBattleCardsByAtk("B", 0), BattleData.PositiveType.shieldMonster)),
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByAtk("B", 0))
		})), 2
	elseif arg_304_1._id == 3916 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoIdGroup("PH", var_304_1._refCards), nil, true, nil, true), 1
	elseif arg_304_1._id == 3919 then
		return true, arg_304_0:filterSacrificeCards(B.filterTokenCards(arg_304_0:getBoardCards(), false)), 3
	elseif arg_304_1._id == 3923 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3926 or arg_304_1._id == 6415 or arg_304_1._id == 9937 or arg_304_1._id == 13319 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 3930 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByMaxOriginAtk("H", arg_304_1._owner._mark3930)), 1
	elseif arg_304_1._id == 3935 then
		return true, B.filterDualCards(arg_304_0:getBattleCards("H")), 1
	elseif arg_304_1._id == 3937 or arg_304_1._id == 6675 or arg_304_1._id == 2715 or arg_304_1._id == 2886 or arg_304_1._id == 5508 or arg_304_1._id == 7234 then
		return true, arg_304_0:getBattleCardsByType("H", Data.CardType.magic), 1
	elseif arg_304_1._id == 3939 then
		local var_304_107 = arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryGroupCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards))

		if #var_304_107 > 0 then
			return true, var_304_107, 1
		end
	elseif arg_304_1._id == 3942 or arg_304_1._id == 3943 then
		return true, arg_304_0:getBattleCardsByMinAtk("H", B.getMinAtkCard(var_304_0:getBoardCards())._atk), 1
	elseif arg_304_1._id == 3948 or arg_304_1._id == 2924 or arg_304_1._id == 9909 or arg_304_1._id == 8081 or arg_304_1._id == 4946 then
		return true, B.filterCanSummonAlterMonsterCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("S", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 3949 then
		local var_304_108 = B.filterCanBindAlterMagicCards(B.filterInKeywordCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[2]), var_304_1._refCards[1]), arg_304_1._owner)

		if #var_304_108 > 0 then
			return true, var_304_108, 1
		end
	elseif arg_304_1._id == 3950 or arg_304_1._id == 13401 then
		return true, B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("S", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3954 or arg_304_1._id == 5582 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 3955 or arg_304_1._id == 3963 or arg_304_1._id == 6868 then
		local var_304_109 = B.filterCanBindAlterMagicCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), var_304_1._refCards[2]), arg_304_1._owner)

		if arg_304_1._id == 3963 then
			var_304_109 = B.filterNotSameNameCards(var_304_109, arg_304_1._owner)
		end

		return true, var_304_109, 1
	elseif arg_304_1._id == 3957 then
		local var_304_110 = B.filterInCategoryCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[2]), var_304_1._refCards[1])
		local var_304_111 = B.filterInCategoryCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[2]), var_304_1._refCards[3])
		local var_304_112 = {}

		for iter_304_1 = 1, #var_304_110 do
			if #B.filterCanBindAlterMagicCards(var_304_111, var_304_110[iter_304_1]) > 0 then
				var_304_112[#var_304_112 + 1] = var_304_110[iter_304_1]
			end
		end

		return true, B.sortCardsByBoardPos(var_304_112), 1
	elseif arg_304_1._id == 3958 then
		local var_304_113 = arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1]), var_304_1._refCards[2]))

		if #var_304_113 > 0 then
			return true, var_304_113, 1
		end
	elseif arg_304_1._id == 3960 then
		local var_304_114 = arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1]))

		if #var_304_114 > 0 then
			return true, var_304_114, 1
		end
	elseif arg_304_1._id == 3972 then
		return true, B.filterCanBindAlterMagicCards(B.filterInCategoryCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1]), var_304_1._refCards[2]), arg_304_1._owner), 1
	elseif arg_304_1._id == 3973 then
		return true, B.filterEquipMagicCards(arg_304_1._owner._binds), 1
	elseif arg_304_1._id == 3974 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInCategoryGroupCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards))), 1
	elseif arg_304_1._id == 3975 then
		return true, B.filterInCategoryCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 3977 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInNatureCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), arg_304_1._owner._info._category), arg_304_1._owner._info._nature)), 1
	elseif arg_304_1._id == 3981 or arg_304_1._id == 4436 or arg_304_1._id == 4608 or arg_304_1._id == 4823 or arg_304_1._id == 5325 or arg_304_1._id == 6577 or arg_304_1._id == 6723 or arg_304_1._id == 6789 or arg_304_1._id == 2220 or arg_304_1._id == 2389 or arg_304_1._id == 2400 or arg_304_1._id == 2454 or arg_304_1._id == 9090 or arg_304_1._id == 9523 or arg_304_1._id == 9633 or arg_304_1._id == 13434 or arg_304_1._id == 13491 or arg_304_1._id == 13538 or arg_304_1._id == 13860 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3988 or arg_304_1._id >= 5550 and arg_304_1._id <= 5555 or arg_304_1._id == 6453 or arg_304_1._id == 2166 or arg_304_1._id == 2259 or arg_304_1._id == 2260 or arg_304_1._id == 2395 or arg_304_1._id == 2475 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByNature("B", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 3994 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCards("BSD", Data.CARD_MAX_LEVEL, arg_304_1._owner))), 0
	elseif arg_304_1._id == 3995 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryGroupCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards))), 1
	elseif arg_304_1._id == 3996 or arg_304_1._id == 9754 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4018 or arg_304_1._id == 4096 or arg_304_1._id == 4347 or arg_304_1._id == 4697 or arg_304_1._id == 6355 or arg_304_1._id == 6364 or arg_304_1._id == 6903 or arg_304_1._id == 6971 or arg_304_1._id == 2101 or arg_304_1._id == 2282 or arg_304_1._id == 2364 or arg_304_1._id == 2649 or arg_304_1._id == 2904 or arg_304_1._id == 9267 or arg_304_1._id == 9335 or arg_304_1._id == 9336 or arg_304_1._id == 9519 or arg_304_1._id == 9628 or arg_304_1._id == 9703 or arg_304_1._id == 9727 or arg_304_1._id == 9887 or arg_304_1._id == 9932 or arg_304_1._id == 9988 or arg_304_1._id == 13451 or arg_304_1._id == 13778 or arg_304_1._id == 13802 then
		return true, var_304_0:getBattleCards("CSD"), 1
	elseif arg_304_1._id == 4022 then
		return true, B.reverseTable(arg_304_0:filterCanChangeToBoardCards(B.filterNoSkillCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), 6009))), 1
	elseif arg_304_1._id == 4024 or arg_304_1._id == 9280 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2))), 1
	elseif arg_304_1._id == 9287 then
		local var_304_115 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("HG", var_304_1._refCards[1]))

		return true, var_304_115, math.min(math.min(var_304_2, #var_304_115), arg_304_1._owner:getDoubleLinkedCardsEmptyLinkPosCount())
	elseif arg_304_1._id == 9288 then
		local var_304_116 = var_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("HG", var_304_1._refCards[1]))

		return true, var_304_116, math.min(math.min(var_304_2, #var_304_116), arg_304_1._owner:getDoubleLinkedCardsEmptyOppoLinkPosCount())
	elseif arg_304_1._id == 4027 or arg_304_1._id == 4811 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryGroupCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards)), 1
	elseif arg_304_1._id == 4029 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByStar("P", arg_304_2:getStar() + 1), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4030 then
		return true, arg_304_0:getBattleCardsByNature("H", var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 4053 or arg_304_1._id == 4174 or arg_304_1._id == 5326 or arg_304_1._id == 6323 or arg_304_1._id == 6988 or arg_304_1._id == 7063 or arg_304_1._id == 7074 or arg_304_1._id == 7614 or arg_304_1._id == 2521 or arg_304_1._id == 13263 or arg_304_1._id == 13298 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("H", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4054 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterComposeMaterialCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster))), 1
	elseif arg_304_1._id == 4063 then
		return true, B.reverseTable(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByType("G", Data.CardType.magic))), 1
	elseif arg_304_1._id == 4068 or arg_304_1._id == 4443 or arg_304_1._id == 4445 or arg_304_1._id == 4452 or arg_304_1._id == 4513 or arg_304_1._id == 4568 or arg_304_1._id == 4581 or arg_304_1._id == 4612 or arg_304_1._id == 4628 or arg_304_1._id == 4653 or arg_304_1._id == 4673 or arg_304_1._id == 4675 or arg_304_1._id == 4681 or arg_304_1._id == 4832 or arg_304_1._id == 4984 or arg_304_1._id == 5332 or arg_304_1._id == 5343 or arg_304_1._id == 5382 or arg_304_1._id == 6857 or arg_304_1._id == 2626 or arg_304_1._id == 7698 or arg_304_1._id == 8043 then
		return true, arg_304_0:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 4070 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByOriginId("PH", var_304_1._refCards[3])),
			arg_304_0:getBattleCardsByInfoId("PH", var_304_1._refCards[2])
		}), false, true)), 1
	elseif arg_304_1._id == 4075 or arg_304_1._id == 6689 then
		return true, var_304_0:getBattleCardsByType("SD", Data.CardType.magic), 1
	elseif arg_304_1._id == 4080 or arg_304_1._id == 6819 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4088 or arg_304_1._id == 4094 or arg_304_1._id == 4334 or arg_304_1._id == 4366 or arg_304_1._id == 4464 or arg_304_1._id == 4551 or arg_304_1._id == 4640 or arg_304_1._id == 4820 or arg_304_1._id == 4854 or arg_304_1._id == 4910 or arg_304_1._id == 4999 or arg_304_1._id == 5037 or arg_304_1._id == 5196 or arg_304_1._id == 5364 or arg_304_1._id == 5480 or arg_304_1._id == 5558 or arg_304_1._id == 5567 or arg_304_1._id == 5591 or arg_304_1._id == 5592 or arg_304_1._id == 6423 or arg_304_1._id == 6604 or arg_304_1._id == 6885 or arg_304_1._id == 7645 or arg_304_1._id == 2192 or arg_304_1._id == 2333 or arg_304_1._id == 2980 or arg_304_1._id == 2990 or arg_304_1._id == 2991 or arg_304_1._id == 2994 or arg_304_1._id == 9008 or arg_304_1._id == 9085 or arg_304_1._id == 9349 or arg_304_1._id == 9871 or arg_304_1._id == 9893 or arg_304_1._id == 7240 or arg_304_1._id == 7567 or arg_304_1._id == 7577 or arg_304_1._id == 7630 or arg_304_1._id == 8070 or arg_304_1._id == 13069 or arg_304_1._id == 13167 or arg_304_1._id == 13351 or arg_304_1._id == 13431 or arg_304_1._id == 13518 or arg_304_1._id == 13713 or arg_304_1._id == 13799 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4093 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterCanActionCards(arg_304_0:getBoardCards()))), 2
	elseif arg_304_1._id == 4095 or arg_304_1._id == 4318 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNoSkillCards(arg_304_0:getBattleCards("H"), arg_304_1._id)), 0
	elseif arg_304_1._id == 4101 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCards(arg_304_0:getEmptyBoardPos() == nil and "B" or "BCSD")), 1
	elseif arg_304_1._id == 4111 or arg_304_1._id == 6682 then
		return true, B.reverseTable(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster))), 1
	elseif arg_304_1._id == 4112 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBoardCards()),
			B.sortCardsByBoardPos(var_304_0:getBoardCards())
		}), 2
	elseif arg_304_1._id == 4113 or arg_304_1._id == 4884 then
		local var_304_117

		if arg_304_2:isInfoId(var_304_1._refCards[1]) then
			var_304_117 = arg_304_0:getBattleCardsByInfoIdGroup("R", {
				var_304_1._refCards[2],
				var_304_1._refCards[3],
				var_304_1._refCards[4],
				var_304_1._refCards[5],
				var_304_1._refCards[6],
				var_304_1._refCards[7],
				var_304_1._refCards[8]
			})
		else
			var_304_117 = arg_304_0:getBattleCardsByInfoIdGroup("R", {
				var_304_1._refCards[10],
				var_304_1._refCards[11]
			})
		end

		return true, var_304_117, 1
	elseif arg_304_1._id == 4116 or arg_304_1._id == 5580 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("GP", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4117 then
		return true, B.sortCardsByBoardPos(B.filterSameAtkCards(B.filterCanActionCards(arg_304_0:getBoardCards()))), 1
	elseif arg_304_1._id == 4120 or arg_304_1._id == 4987 or arg_304_1._id == 7466 or arg_304_1._id == 7709 or arg_304_1._id == 2418 or arg_304_1._id == 2525 or arg_304_1._id == 2616 or arg_304_1._id == 2629 or arg_304_1._id == 2871 or arg_304_1._id == 2918 or arg_304_1._id == 13036 or arg_304_1._id == 13059 or arg_304_1._id == 13272 or arg_304_1._id == 13273 or arg_304_1._id == 13368 or arg_304_1._id == 13420 or arg_304_1._id == 13498 or arg_304_1._id == 13513 or arg_304_1._id == 13630 or arg_304_1._id == 13865 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 4122 or arg_304_1._id == 4487 or arg_304_1._id == 6377 or arg_304_1._id == 7411 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4124 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoIdGroup("B", {
			var_304_1._refCards[1],
			var_304_1._refCards[2]
		})), 3
	elseif arg_304_1._id == 4125 then
		return true, B.filterStarLessThanSumOfOthers(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("GH", var_304_1._refCards[1])), arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4126 or arg_304_1._id == 4803 or arg_304_1._id == 5497 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4129 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByMaxAtk("B", B.getMinAtkCard(var_304_0:getBoardCards())._atk)), 1
	elseif arg_304_1._id == 4132 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryAndNature("GH", var_304_1._refCards[1], var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 4133 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2)))), 1
	elseif arg_304_1._id == 4134 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("H", var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 4135 then
		return true, arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			arg_304_0:getBattleCardsByNature("G", var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByNature("G", var_304_1._refCards[2])
		})), 1
	elseif arg_304_1._id == 4136 then
		local var_304_118
		local var_304_119 = arg_304_0:getBattleCardsByCategory("GH", var_304_1._refCards[1])

		if #var_304_119 == 1 then
			var_304_118 = var_304_119[1]
		end

		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStar("PH", var_304_2, Data.CARD_MAX_LEVEL, var_304_118), var_304_1._refCards[1]), true, true)), 1
	elseif arg_304_1._id == 4140 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1])), 3
	elseif arg_304_1._id == 4141 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4142 or arg_304_1._id == 5064 or arg_304_1._id == 6408 or arg_304_1._id == 6572 or arg_304_1._id == 6945 or arg_304_1._id == 2403 or arg_304_1._id == 2438 or arg_304_1._id == 2458 or arg_304_1._id == 2670 or arg_304_1._id == 2901 or arg_304_1._id == 2947 or arg_304_1._id == 9145 or arg_304_1._id == 9500 or arg_304_1._id == 9823 or arg_304_1._id == 9990 or arg_304_1._id == 7636 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			B.sortCardsByBoardPos(arg_304_0:getBoardCards())
		}), 1
	elseif arg_304_1._id == 4143 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(B.mergeTable({
			arg_304_0:getBattleCardsByStar("G", 7),
			arg_304_0:getBattleCardsByStar("G", 8)
		}), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4145 then
		return true, arg_304_0:getBattleCardsByStar("H", 8), 1
	elseif arg_304_1._id == 4150 then
		return true, var_304_0:getBattleCards("CS"), 1
	elseif arg_304_1._id == 4152 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[2]))), 1
	elseif arg_304_1._id == 4155 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterDieByEffectCards(B.filterDieRoundCards(arg_304_0:getBattleCardsByStar("G", 4), arg_304_0._round), true)), 1
	elseif arg_304_1._id == 4156 then
		return true, B.mergeTable({
			arg_304_0:getBattleCards("C"),
			var_304_0:getBattleCards("C")
		}), 1
	elseif arg_304_1._id == 4157 then
		return true, arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 4158 then
		local var_304_120 = arg_304_0:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_304_1._owner)

		if #var_304_120 > 0 then
			return true, var_304_120, 1
		end
	elseif arg_304_1._id == 4160 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoIdGroup("PG", var_304_1._refCards))), 1
	elseif arg_304_1._id == 4161 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4166 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("G", arg_304_1._owner:getBuffValue(true, BattleData.PositiveType.wasteMark)), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4169 or arg_304_1._id == 4100 or arg_304_1._id == 13330 then
		return true, arg_304_0:getBattleCards("CSD"), 1
	elseif arg_304_1._id == 4170 or arg_304_1._id == 4205 or arg_304_1._id == 4532 or arg_304_1._id == 4637 or arg_304_1._id == 6642 or arg_304_1._id == 6696 or arg_304_1._id == 9064 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("PH", Data.CardType.monster), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4178 or arg_304_1._id == 4785 or arg_304_1._id == 4858 or arg_304_1._id == 4896 or arg_304_1._id == 5623 or arg_304_1._id == 7442 or arg_304_1._id == 7594 or arg_304_1._id == 7684 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 4173 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]), BattleData.PositiveType.shieldMagic)), 1
	elseif arg_304_1._id == 4182 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(B.filterHasSkillCards(var_304_0:getBoardCards()), BattleData.PositiveType.shieldMagic)), 1
	elseif arg_304_1._id == 4191 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.mergeTable({
			arg_304_0:getBattleCardsByAtkDef("P", 2400, 1000),
			arg_304_0:getBattleCardsByAtkDef("P", 2800, 1000)
		}), arg_304_1._owner._mark4191))), 1
	elseif arg_304_1._id == 4193 or arg_304_1._id == 13781 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster))), 1
	elseif arg_304_1._id == 4194 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterSpiritCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster)),
			B.filterCeremonyMagicCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic))
		}))), 1
	elseif arg_304_1._id == 4200 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNormalCards(arg_304_0:getBattleCardsByMinStar("P", var_304_2)))), 1
	elseif arg_304_1._id == 4206 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSummonedByMergeCards(arg_304_0:getBattleCardsByType("G", Data.CardType.rare))), 1
	elseif arg_304_1._id == 4210 then
		local var_304_121 = arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1])
		local var_304_122 = B.mergeTable({
			var_304_0:getBattleCards("CSD"),
			arg_304_0:getBattleCards("CSD")
		})

		return true, var_304_122, math.min(#var_304_122, math.min(#var_304_121, #var_304_122), 2)
	elseif arg_304_1._id == 4213 then
		return true, B.sortCardsByBoardPos(B.filterDefPostureCards(var_304_0:getBoardCards(), false)), 1
	elseif arg_304_1._id == 4215 or arg_304_1._id == 5466 or arg_304_1._id == 9783 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByType("P", Data.CardType.monster)), 1
	elseif arg_304_1._id == 4217 or arg_304_1._id == 4466 or arg_304_1._id == 4799 or arg_304_1._id == 4983 or arg_304_1._id == 5233 or arg_304_1._id == 5432 or arg_304_1._id == 6801 or arg_304_1._id == 8102 or arg_304_1._id == 2279 or arg_304_1._id == 2979 or arg_304_1._id == 9461 or arg_304_1._id == 9759 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4219 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1])), false, true), 1
	elseif arg_304_1._id == 4223 or arg_304_1._id == 13203 then
		return true, B.filterNotDisablePostureCards(B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBoardCards()),
			B.sortCardsByBoardPos(var_304_0:getBoardCards())
		})), 1
	elseif arg_304_1._id == 4225 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterCeremonyMonsterCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1])),
			arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[2])
		}))), 1
	elseif arg_304_1._id == 4226 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterCeremonyMagicCards(arg_304_0:getBattleCards("P")))), 1
	elseif arg_304_1._id == 4227 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInNatureCards(arg_304_0:getBattleCardsByCategoryGroup("P", {
			var_304_1._refCards[1],
			var_304_1._refCards[2],
			var_304_1._refCards[3]
		}), var_304_1._refCards[4]))), 1
	elseif arg_304_1._id == 4238 then
		local var_304_123 = arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1])
		local var_304_124 = {}

		for iter_304_2 = 1, #var_304_123 do
			local var_304_125 = var_304_123[iter_304_2]

			if #B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("GPH", var_304_125:getStar()), var_304_1._refCards[1]))) > 0 then
				var_304_124[#var_304_124 + 1] = var_304_125
			end
		end

		return true, B.sortCardsByBoardPos(var_304_124), 1
	elseif arg_304_1._id == 4249 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_304_0:getBattleCards("G"))), 1
	elseif arg_304_1._id == 4254 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, arg_304_1._owner))
		}), 1
	elseif arg_304_1._id == 4263 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterCeremonyMonsterCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2)))), 1
	elseif arg_304_1._id == 4267 or arg_304_1._id == 6484 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 4268 or arg_304_1._id == 4586 or arg_304_1._id == 8084 or arg_304_1._id == 13456 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeywordGroup("B", var_304_1._refCards)), 1
	elseif arg_304_1._id == 4269 then
		return true, B.sortCardsByBoardPos(B.filterInTypeCards(arg_304_0:getBattleCardsByKeyword("GP", var_304_1._refCards[1]), Data.CardType.monster)), 1
	elseif arg_304_1._id == 4270 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterEffectCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4279 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, arg_304_2))
		}), 1
	elseif arg_304_1._id == 4296 then
		return true, B.filterDefPostureCards(var_304_0:getBoardCards(), true), 1
	elseif arg_304_1._id == 4297 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), false)), 1
	elseif arg_304_1._id == 4300 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterAdjustCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), true))), 1
	elseif arg_304_1._id == 4301 then
		return true, B.filterCanBindAlterMagicCards(B.filterAdjustCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), var_304_1._refCards[2]), true), arg_304_1._owner), 1
	elseif arg_304_1._id == 4302 then
		local var_304_126 = arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1])
		local var_304_127 = B.filterInCategoryCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1]), var_304_1._refCards[2])
		local var_304_128 = {}

		for iter_304_3 = 1, #var_304_126 do
			if #B.filterCanBindAlterMagicCards(var_304_127, var_304_126[iter_304_3]) > 0 then
				var_304_128[#var_304_128 + 1] = var_304_126[iter_304_3]
			end
		end

		return true, B.sortCardsByBoardPos(var_304_128), 1
	elseif arg_304_1._id == 4303 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterIdMapCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), arg_304_1._owner._mark4303, false)), 1
	elseif arg_304_1._id == 4306 then
		return true, B.filterMergeCards(arg_304_0:getBattleCardsByType("G", Data.CardType.rare)), 1
	elseif arg_304_1._id == 4322 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("H", var_304_2), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 4323 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), false, true), var_304_2
	elseif arg_304_1._id == 4326 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("H", {
			Data.CardType.magic,
			Data.CardType.trap
		}, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 4327 or arg_304_1._id == 4337 or arg_304_1._id == 5373 or arg_304_1._id == 5459 or arg_304_1._id == 5535 or arg_304_1._id == 5632 or arg_304_1._id == 6896 or arg_304_1._id == 2126 or arg_304_1._id == 2186 or arg_304_1._id == 2308 or arg_304_1._id == 2342 or arg_304_1._id == 2817 or arg_304_1._id == 9045 or arg_304_1._id == 9123 or arg_304_1._id == 9225 or arg_304_1._id == 9245 or arg_304_1._id == 9510 or arg_304_1._id == 9567 or arg_304_1._id == 9738 or arg_304_1._id == 9789 or arg_304_1._id == 9790 or arg_304_1._id == 13087 or arg_304_1._id == 13091 or arg_304_1._id == 13139 or arg_304_1._id == 13260 or arg_304_1._id == 13487 or arg_304_1._id == 13608 or arg_304_1._id == 13666 or arg_304_1._id == 13732 or arg_304_1._id == 13748 or arg_304_1._id == 13875 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4328 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[2], Data.CARD_MAX_LEVEL, arg_304_2)), 1
	elseif arg_304_1._id == 4333 or arg_304_1._id == 4939 then
		local var_304_129 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]))

		return true, var_304_129, math.min(math.min(2, #var_304_129), arg_304_0:getEmptyBoardPosCount())
	elseif arg_304_1._id == 4349 or arg_304_1._id == 9102 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("PH", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4350 then
		local var_304_130 = arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategory("L", var_304_1._refCards[1]))

		return true, var_304_130, math.min(2, #var_304_130)
	elseif arg_304_1._id == 4353 or arg_304_1._id == 4368 or arg_304_1._id == 4560 or arg_304_1._id == 4892 or arg_304_1._id == 5462 or arg_304_1._id == 5609 or arg_304_1._id == 5612 or arg_304_1._id == 5626 or arg_304_1._id == 7231 or arg_304_1._id == 7372 or arg_304_1._id == 7438 or arg_304_1._id == 7596 or arg_304_1._id == 7670 or arg_304_1._id == 7675 or arg_304_1._id == 7685 or arg_304_1._id == 6291 or arg_304_1._id == 6493 or arg_304_1._id == 6518 or arg_304_1._id == 6894 or arg_304_1._id == 6902 or arg_304_1._id == 2393 or arg_304_1._id == 2633 or arg_304_1._id == 9217 or arg_304_1._id == 9632 or arg_304_1._id == 9756 or arg_304_1._id == 9890 or arg_304_1._id == 9923 or arg_304_1._id == 8036 or arg_304_1._id == 13639 or arg_304_1._id == 13682 or arg_304_1._id == 13735 or arg_304_1._id == 13871 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4358 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2)), 1
	elseif arg_304_1._id == 4364 then
		local var_304_131 = B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD"))

		if #var_304_131 > 0 then
			return true, var_304_131, math.min(#var_304_131, 1)
		end
	elseif arg_304_1._id == 4365 or arg_304_1._id == 5193 or arg_304_1._id == 5289 or arg_304_1._id == 5597 or arg_304_1._id == 6396 or arg_304_1._id == 7640 or arg_304_1._id == 9220 or arg_304_1._id == 9328 or arg_304_1._id == 9584 or arg_304_1._id == 13489 or arg_304_1._id == 13861 then
		return true, arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 4367 then
		return true, B.sortCardsByBoardPos(B.filterSyncCards(arg_304_0:getBoardCards(), true)), 1
	elseif arg_304_1._id == 4373 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterAdjustCards(arg_304_0:getBattleCardsByMaxStar("G", math.floor(arg_304_2:getStar() / 2)), true)), 1
	elseif arg_304_1._id == 4381 then
		return true, B.mergeTable({
			arg_304_0:filterCanChangeToBoardCards(var_304_0:getBattleCardsByType("G", Data.CardType.monster)),
			arg_304_0:filterCanChangeToHandCards(var_304_0:getBattleCardsByTypeGroup("G", {
				Data.CardType.magic,
				Data.CardType.trap
			}))
		}), 1
	elseif arg_304_1._id == 4384 or arg_304_1._id == 6736 or arg_304_1._id == 2404 then
		return true, var_304_0:getBattleCards("G"), 2
	elseif arg_304_1._id == 4390 or arg_304_1._id == 4895 or arg_304_1._id == 5015 then
		return true, arg_304_0:getBattleCardsByType("G", Data.CardType.magic), 2
	elseif arg_304_1._id == 4391 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(B.filterInNatureCards(arg_304_0:getBattleCardsByMaxStar("G", arg_304_1._owner:getBuffValue(true, BattleData.PositiveType.weddingMark)), var_304_1._refCards[2]), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4394 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterQualityLessThanCards(B.filterInStatusCards(arg_304_1._owner._ceremonyComponents, BattleData.CardStatus.grave), var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 4405 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCards("L")), 1
	elseif arg_304_1._id == 4408 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByMaxQuality("L", var_304_1._refCards[3])), 2
	elseif arg_304_1._id == 4409 or arg_304_1._id == 4596 or arg_304_1._id == 5285 or arg_304_1._id == 5327 or arg_304_1._id == 5328 or arg_304_1._id == 5428 or arg_304_1._id == 3696 or arg_304_1._id == 2251 or arg_304_1._id == 2317 or arg_304_1._id == 2421 or arg_304_1._id == 2963 or arg_304_1._id == 9938 or arg_304_1._id == 13180 or arg_304_1._id == 13262 or arg_304_1._id == 13269 or arg_304_1._id == 13825 or arg_304_1._id == 13852 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4411 then
		return true, B.sortCardsByBoardPos(B.filterNormalCards(arg_304_0:getBattleCards("PH"))), 1
	elseif arg_304_1._id == 4412 or arg_304_1._id == 4949 or arg_304_1._id == 13214 or arg_304_1._id == 13383 or arg_304_1._id == 13646 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoId("P", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4413 or arg_304_1._id == 2367 or arg_304_1._id == 2955 or arg_304_1._id == 8125 or arg_304_1._id == 9079 or arg_304_1._id == 9269 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4419 then
		return true, arg_304_0:getBattleCardsByAtkDef("H", 2800, 1000), 1
	elseif arg_304_1._id == 4420 then
		return true, arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterSustainableMagicCards(arg_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1])),
			B.filterFieldMagicCards(arg_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1]))
		})), 1
	elseif arg_304_1._id == 4424 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinAtkMaxDef("P", 3000, 2500), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 4425 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[2])), 2
	elseif arg_304_1._id == 4428 then
		return true, B.filter4428Cards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), arg_304_0), 1
	elseif arg_304_1._id == 4430 then
		return true, B.filterFirstCards(var_304_0:getBattleCards("P"), var_304_2), 1
	elseif arg_304_1._id == 4431 or arg_304_1._id == 6362 or arg_304_1._id == 2285 or arg_304_1._id == 9563 or arg_304_1._id == 13452 or arg_304_1._id == 13453 or arg_304_1._id == 13501 or arg_304_1._id == 13912 then
		return true, arg_304_0:getBattleCardsByType("G", Data.CardType.monster), 1
	elseif arg_304_1._id == 4432 or arg_304_1._id == 4819 or arg_304_1._id == 4960 or arg_304_1._id == 5533 or arg_304_1._id == 2893 or arg_304_1._id == 2960 or arg_304_1._id == 9607 then
		return true, var_304_0:getBattleCardsByType("G", Data.CardType.monster), 1
	elseif arg_304_1._id == 4433 then
		return true, B.filterMergeCards(arg_304_0:getBattleCardsByKeywordGroup("G", var_304_1._refCards)), 2
	elseif arg_304_1._id == 4434 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxOriginAtk("GL", arg_304_0._fortress._hp - 1), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4435 or arg_304_1._id == 4772 or arg_304_1._id == 7334 or arg_304_1._id == 7710 or arg_304_1._id == 5299 or arg_304_1._id == 5620 or arg_304_1._id == 6305 or arg_304_1._id == 6435 or arg_304_1._id == 6837 or arg_304_1._id == 2127 or arg_304_1._id == 9223 or arg_304_1._id == 9862 or arg_304_1._id == 9873 or arg_304_1._id == 13278 or arg_304_1._id == 13279 or arg_304_1._id == 13335 or arg_304_1._id == 13445 or arg_304_1._id == 13527 or arg_304_1._id == 13539 or arg_304_1._id == 13769 or arg_304_1._id == 13938 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4437 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterAdjustCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]), true))), 1
	elseif arg_304_1._id == 4441 or arg_304_1._id == 4442 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInStarCards(arg_304_0:getBattleCardsByCategoryAndNature("P", arg_304_2._info._category, arg_304_2._info._nature), arg_304_2:getStar() + (arg_304_1._id == 4441 and 1 or -1))), 1
	elseif arg_304_1._id == 4448 then
		return true, B.reverseTable(arg_304_0:filterCanChangeToBoardCards(B.filterNoSkillCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), 6009))), 1
	elseif arg_304_1._id == 4455 or arg_304_1._id == 4516 or arg_304_1._id == 5362 or arg_304_1._id == 3340 or arg_304_1._id == 3395 or arg_304_1._id == 6568 or arg_304_1._id == 6583 or arg_304_1._id == 6700 or arg_304_1._id == 6583 or arg_304_1._id == 7458 or arg_304_1._id == 9874 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD"))
		}), 1
	elseif arg_304_1._id == 4458 then
		local var_304_132 = arg_304_0:filterCanChangeToHandCards(B.filterInTypeCards(arg_304_0:getBattleCardsByKeywordGroup("P", var_304_1._refCards), Data.CardType.monster))

		return true, var_304_132, math.min(#var_304_132, var_304_2)
	elseif arg_304_1._id == 4463 or arg_304_1._id == 4964 or arg_304_1._id == 2363 or arg_304_1._id == 2717 or arg_304_1._id == 5403 or arg_304_1._id == 5477 or arg_304_1._id == 5539 or arg_304_1._id == 13039 or arg_304_1._id == 13205 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 4261 or arg_304_1._id == 4450 or arg_304_1._id == 4465 or arg_304_1._id == 4798 or arg_304_1._id == 4963 or arg_304_1._id == 7677 or arg_304_1._id == 5116 or arg_304_1._id == 5574 or arg_304_1._id == 8113 or arg_304_1._id == 2529 or arg_304_1._id == 2199 or arg_304_1._id == 2690 or arg_304_1._id == 2783 or arg_304_1._id == 2983 or arg_304_1._id == 9562 or arg_304_1._id == 9634 or arg_304_1._id == 13015 or arg_304_1._id == 13074 or arg_304_1._id == 13098 or arg_304_1._id == 13717 or arg_304_1._id == 13854 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4468 then
		return true, B.sortCardsByBoardPos(B.filterCanBindMagicCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[2])), arg_304_2)), 1
	elseif arg_304_1._id == 4470 or arg_304_1._id == 4696 or arg_304_1._id == 2666 or arg_304_1._id == 9194 or arg_304_1._id == 9202 or arg_304_1._id == 9203 or arg_304_1._id == 9231 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4475 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByMinHp("B", B.getMaxHpCard(B.filterLinkCards(var_304_0:getBoardCards(), false))._hp)), 1
	elseif arg_304_1._id == 4483 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("GL", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 4488 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterInKeywordCards(arg_304_0:getBattleCardsByType("PG", Data.CardType.monster), var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByKeywordGroup("PG", {
				var_304_1._refCards[2],
				var_304_1._refCards[3]
			})
		}))), 1
	elseif arg_304_1._id == 4490 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoId("PGH", var_304_1._refCards[2]))), 1
	elseif arg_304_1._id == 4492 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCardsByMinStar("H", var_304_2))), 1
	elseif arg_304_1._id == 4493 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByMaxOriginAtk("P", var_304_2))), 1
	elseif arg_304_1._id == 4499 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 4500 then
		return true, B.filterInCategoryCards(arg_304_0:getBattleCardsByStarOrLevelGroup("BH", {
			7,
			8
		}), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 4505 or arg_304_1._id == 9529 or arg_304_1._id == 13358 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeywordGroup("G", var_304_1._refCards)), 1
	elseif arg_304_1._id == 4506 or arg_304_1._id == 5261 or arg_304_1._id == 9559 or arg_304_1._id == 13528 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4508 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), true, true), 1
	elseif arg_304_1._id == 4509 then
		return true, arg_304_0:getBattleCardsBy4509(arg_304_2), 1
	elseif arg_304_1._id == 4510 or arg_304_1._id == 4773 or arg_304_1._id == 5199 or arg_304_1._id == 5287 or arg_304_1._id == 7536 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 4515 or arg_304_1._id == 4678 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByJoinComponent("B", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4519 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategoryAndNature("P", var_304_1._refCards[3], var_304_1._refCards[2]))), 1
	elseif arg_304_1._id == 4520 or arg_304_1._id == 5631 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoId("HG", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4523 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterComposeMaterialCards(arg_304_0:getBattleCards("G"))), 1
	elseif arg_304_1._id == 4525 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterMergeCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[2])), true, true), 1
	elseif arg_304_1._id == 4527 then
		return true, arg_304_0:getBattleCardsByStar("HB", var_304_2), 1
	elseif arg_304_1._id == 4531 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("H", math.floor((arg_304_0._fortress._hp - 1) / var_304_2)), var_304_1._refCards[1])), false, true), 1
	elseif arg_304_1._id == 4545 or arg_304_1._id == 4609 or arg_304_1._id == 7538 then
		return true, arg_304_0:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_304_1._owner), 2
	elseif arg_304_1._id == 4546 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByType("G", Data.CardType.trap)), 1
	elseif arg_304_1._id == 4550 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("G", 0), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 4555 or arg_304_1._id == 2327 or arg_304_1._id == 9063 or arg_304_1._id == 13587 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("L", Data.CardType.monster), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4558 then
		return true, arg_304_0:getBattleCardsBy4558Cards(arg_304_2), 2
	elseif arg_304_1._id == 4559 then
		local var_304_133 = arg_304_0:getBattleCardsBy4559Target()

		return true, B.sortCardsByBoardPos(var_304_133), 1
	elseif arg_304_1._id == 4565 then
		return true, B.filterAdjustCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxOriginAtk("H", var_304_2), var_304_1._refCards[1]), true), 1
	elseif arg_304_1._id == 4566 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCards("L"),
			var_304_0:getBattleCards("L")
		})), 1
	elseif arg_304_1._id == 4567 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInNatureCards(arg_304_0:getBattleCardsByMaxOriginAtk("G", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4569 or arg_304_1._id == 7535 or arg_304_1._id == 5135 or arg_304_1._id == 5563 or arg_304_1._id == 6931 or arg_304_1._id == 2240 or arg_304_1._id == 2360 or arg_304_1._id == 2802 or arg_304_1._id == 2975 or arg_304_1._id == 9134 or arg_304_1._id == 9499 or arg_304_1._id == 13947 then
		return true, var_304_0:getBattleCards("G"), 1
	elseif arg_304_1._id == 4570 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByMinStar("HB", 0)),
			arg_304_0:getBattleCardsByMinStar("R", 0)
		})), 1
	elseif arg_304_1._id == 4571 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("H", arg_304_1._owner:getBuffValue(true, BattleData.PositiveType.ylyMark)), var_304_1._refCards[1])), false, true), 1
	elseif arg_304_1._id == 4579 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster)), false, true), 1
	elseif arg_304_1._id == 4580 then
		return true, var_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_304_1._owner)), 2
	elseif arg_304_1._id == 4582 then
		return true, B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("S", Data.CardType.magic)), 1
	elseif arg_304_1._id == 4588 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_304_0:getBattleCardsByStar("R", arg_304_2:getStar()), true)), 1
	elseif arg_304_1._id == 4589 or arg_304_1._id == 5335 or arg_304_1._id == 5336 or arg_304_1._id == 6620 or arg_304_1._id == 2105 or arg_304_1._id == 9957 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4592 or arg_304_1._id == 4605 or arg_304_1._id == 7624 or arg_304_1._id == 5375 or arg_304_1._id == 2445 or arg_304_1._id == 9083 then
		return true, arg_304_0:getBattleCardsByCategory("L", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 4595 or arg_304_1._id == 5049 or arg_304_1._id == 5583 or arg_304_1._id == 6402 or arg_304_1._id == 6456 or arg_304_1._id == 6598 or arg_304_1._id == 2425 or arg_304_1._id == 2443 or arg_304_1._id == 9034 or arg_304_1._id == 9396 or arg_304_1._id == 9918 or arg_304_1._id == 8069 then
		return true, arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 4598 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		})), 1
	elseif arg_304_1._id == 4599 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategoryAndNature("B", arg_304_2._info._category, arg_304_2._info._nature, Data.CARD_MAX_LEVEL, arg_304_2)), 1
	elseif arg_304_1._id == 4600 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInNatureCards(arg_304_0:getBattleCardsByHp("G", 0), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 4617 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4620 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy4620()), 1
	elseif arg_304_1._id == 4621 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNoSkillCards(B.mergeTable({
			arg_304_0:getBattleCardsByAtkDef("G", 2400, 1000),
			arg_304_0:getBattleCardsByAtkDef("G", 2800, 1000)
		}), 6009)), 1
	elseif arg_304_1._id == 4622 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNoSkillCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), 6009)), 1
	elseif arg_304_1._id == 4627 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("R", arg_304_2._info._category), true, true), 1
	elseif arg_304_1._id == 4628 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryGroupCards(arg_304_0:getBattleCardsByMaxStar("L", var_304_2), var_304_1._refCards)), 1
	elseif arg_304_1._id == 4630 or arg_304_1._id == 4921 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZStarCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), arg_304_2._info._star + 1), false, false, false, true), 1
	elseif arg_304_1._id == 4632 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZStarCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), arg_304_2._info._star + 2), false, false, false, true), 1
	elseif arg_304_1._id == 4633 then
		return true, arg_304_0:getBattleCardsBy4633(), 1
	elseif arg_304_1._id == 4638 or arg_304_1._id == 5239 or arg_304_1._id == 9511 or arg_304_1._id == 9588 or arg_304_1._id == 13578 or arg_304_1._id == 13579 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 4644 then
		return true, arg_304_0:getBattleCardsBy4644(), 1
	elseif arg_304_1._id == 4645 then
		return true, arg_304_0:getBattleCardsBy4645(), 1
	elseif arg_304_1._id == 4651 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4654 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterMoreThanStarCards(arg_304_0:getBattleCardsByKeywordGroup("P", var_304_1._refCards), var_304_2))), 1
	elseif arg_304_1._id == 4655 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy4655()), 1
	elseif arg_304_1._id == 4656 then
		return true, B.mergeTable({
			var_304_0:getBattleCards("C"),
			arg_304_0:getBattleCards("C")
		}), 1
	elseif arg_304_1._id == 4657 then
		return true, B.mergeTable({
			arg_304_0:getBattleCards("SD"),
			var_304_0:getBattleCards("SD")
		}), 1
	elseif arg_304_1._id == 4658 or arg_304_1._id == 2702 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterLessThanStarCards(arg_304_0:getBattleCardsByKeywordGroup("P", var_304_1._refCards), var_304_2))), 1
	elseif arg_304_1._id == 4660 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotEqualInfoIdCards(B.filterInTypeCards(arg_304_0:getBattleCardsByKeywordGroup("P", {
			var_304_1._refCards[2],
			var_304_1._refCards[3]
		}), Data.CardType.monster), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4664 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByNature("R", arg_304_2._info._nature), var_304_1._refCards[2]), true, nil, nil, true)), 1
	elseif arg_304_1._id == 4666 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("BCSD", var_304_1._refCards[1])),
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BSD"))
		}), 3
	elseif arg_304_1._id == 4672 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("R", arg_304_2:getStar()), var_304_1._refCards[2]), arg_304_2), true, true, nil, true), 1
	elseif arg_304_1._id == 4674 then
		return true, arg_304_0:getBattleCardsBy4674(), 1
	elseif arg_304_1._id == 4677 then
		return true, B.filterUniqueInfoIdCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), true), 2
	elseif arg_304_1._id == 4683 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterCeremonyMonsterCards(arg_304_0:getBattleCardsByKeyword("BH", var_304_1._refCards[1])))), 1
	elseif arg_304_1._id == 4684 then
		return true, var_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByType("H", Data.CardType.magic, Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 4689 then
		local var_304_134 = B.filterCanBeSacrificedCards(B.filterTokenCards(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1]), false))

		return true, B.sortCardsByBoardPos(var_304_134), #var_304_134
	elseif arg_304_1._id == 4695 then
		return true, B.filterEquipMagicCards(arg_304_0:getBattleCards("S")), 1
	elseif arg_304_1._id == 4698 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), true))), 1
	elseif arg_304_1._id == 4701 then
		local var_304_135 = B.filterCanSummonAlterMonsterCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("S", var_304_1._refCards[1])))

		return true, var_304_135, math.min(#var_304_135, arg_304_0:getEmptyBoardPosCount())
	elseif arg_304_1._id == 4703 then
		return true, B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4719 then
		return true, B.filterCanBindMagicCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("G", Data.CardType.magic)), arg_304_1._owner._binds[1]), 1
	elseif arg_304_1._id == 4720 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByMaxQuality("P", 4)), 1
	elseif arg_304_1._id == 4722 then
		local var_304_136 = arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[1])

		return true, B.sortCardsByBoardPos(var_304_136), #B.filterNormalCards(var_304_136) > 0 and 2 or 1
	elseif arg_304_1._id == 4723 then
		return true, B.mergeTable({
			B.filterAdjustCards(var_304_0:getBattleCardsByType("G", Data.CardType.monster), true),
			B.filterAdjustCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), true)
		}), 1
	elseif arg_304_1._id == 4728 then
		local var_304_137 = B.filterFirstCards(arg_304_0._pileCards, 3)
		local var_304_138 = arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterEqualInfoIdCards(var_304_137, var_304_1._refCards[2]),
			B.filterInKeywordCards(B.filterInTypeGroupCards(var_304_137, {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_304_1._refCards[1])
		}))

		return true, B.sortCardsByBoardPos(#var_304_138 > 0 and var_304_138 or var_304_137), 1
	elseif arg_304_1._id == 4730 then
		local var_304_139 = arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoId("GP", var_304_1._refCards[2]))

		return true, B.sortCardsByBoardPos(var_304_139), math.min(#var_304_139, 2)
	elseif arg_304_1._id == 4732 or arg_304_1._id == 5443 then
		return true, var_304_0:getBattleCardsByType("G", Data.CardType.magic), 1
	elseif arg_304_1._id == 4734 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterAllyMonsterCards(arg_304_0:getBattleCardsByCategoryAndNature("P", var_304_1._refCards[2], var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4738 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInNatureCards(arg_304_0:getBattleCardsByMaxStar("HG", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4744 then
		return true, B.mergeTable({
			arg_304_0:getBattleCards("H"),
			{
				arg_304_0:filterCanChangeToHandCards(arg_304_0._pileCards)[1]
			}
		}), 1
	elseif arg_304_1._id == 4747 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy4747Cards()), 1
	elseif arg_304_1._id == 4750 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByMinAtk("B", 2000)), 1
	elseif arg_304_1._id == 4753 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy4753()), 1
	elseif arg_304_1._id == 4756 then
		return true, arg_304_0:getBattleCardsBy4756(), 1
	elseif arg_304_1._id == 4760 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_2))), 1
	elseif arg_304_1._id == 4765 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]),
			var_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1])
		})), 1
	elseif arg_304_1._id == 4766 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByAtk("P", arg_304_2._atk), var_304_1._refCards[1]), arg_304_2))), 1
	elseif arg_304_1._id == 4767 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterEffectCards(B.filterInKeywordGroupCards(arg_304_0:getBattleCardsByMaxStar("P", arg_304_1._owner:getBuffValue(true, BattleData.PositiveType.samuraiMark)), var_304_1._refCards)))), 1
	elseif arg_304_1._id == 4775 then
		return true, B.sortCardsByBoardPos(B.filterNotInNatureCards(arg_304_0:getBattleCardsByStar("BH", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4776 or arg_304_1._id == 4777 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByStar("BH", var_304_2)), 1
	elseif arg_304_1._id == 4779 then
		return true, var_304_0:getBattleCards(#arg_304_0:getBattleCardsByInfoId("S", var_304_1._refCards[1]) > 0 and "BCSD" or "C"), 1
	elseif arg_304_1._id == 4781 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInTypeCards(arg_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1]), Data.CardType.monster)), 1
	elseif arg_304_1._id == 4782 then
		return true, B.sortCardsByBoardPos(B.filterHasAlterMagicCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4783 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterUniqueInfoIdCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1])))), 1
	elseif arg_304_1._id == 4784 or arg_304_1._id == 7389 then
		return true, B.filterCanSummonAlterMonsterCards(arg_304_0:getBattleCardsByKeyword("CSD", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4793 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterMergeCards(arg_304_0:getBattleCards("R")), true, true), 1
	elseif arg_304_1._id == 4794 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_304_0:getBattleCards("R"), true), true), 1
	elseif arg_304_1._id == 4795 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_304_0:getBattleCards("R"), true)), 1
	elseif arg_304_1._id == 4804 or arg_304_1._id == 5107 or arg_304_1._id == 5127 or arg_304_1._id == 5484 or arg_304_1._id == 5487 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("HB", Data.CardType.monster), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4806 or arg_304_1._id == 7545 or arg_304_1._id == 9393 or arg_304_1._id == 9594 or arg_304_1._id == 13657 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4807 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("PR", var_304_1._refCards[1]), true, true)), 1
	elseif arg_304_1._id == 4809 then
		return true, B.filterXYZCards(arg_304_0:getBattleCardsByNature("G", var_304_1._refCards[1]), true), 1
	elseif arg_304_1._id == 4810 then
		return true, B.sortCardsByBoardPos(B.filterNormalCards(B.filterDualCards(arg_304_0:getBoardCards()))), 1
	elseif arg_304_1._id == 4812 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryGroup("P", var_304_1._refCards))), 1
	elseif arg_304_1._id == 4813 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategoryGroup("P", var_304_1._refCards))), 1
	elseif arg_304_1._id == 4814 then
		return true, B.filterNoMark4814Cards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("H", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4816 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_304_0:getBattleCards("G"), true)), 1
	elseif arg_304_1._id == 4821 or arg_304_1._id == 9694 or arg_304_1._id == 13697 then
		return true, B.sortCardsByBoardPos(B.filterFirstCards(arg_304_0._pileCards, var_304_2)), 1
	elseif arg_304_1._id == 4839 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			var_304_0:getBattleCardsByType("G", Data.CardType.monster),
			arg_304_0:getBattleCardsByType("G", Data.CardType.monster)
		}), nil, nil, nil, true), 1
	elseif arg_304_1._id == 4840 then
		return true, B.sortCardsByBoardPos(B.filterEffectCards(B.filterDualCards(arg_304_0:getBoardCards()))), 1
	elseif arg_304_1._id == 4842 or arg_304_1._id == 4873 or arg_304_1._id == 7626 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryAndNature("H", var_304_1._refCards[2], var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4847 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterLessThanStarCards(arg_304_0:getBattleCardsByCategoryAndNature("G", var_304_1._refCards[2], var_304_1._refCards[1]), var_304_2)), 1
	elseif arg_304_1._id == 4857 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterMergeCards(B.filterNotInNatureCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), arg_304_2._info._nature)), nil, nil, nil, true), 1
	elseif arg_304_1._id == 4859 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]))), 2
	elseif arg_304_1._id == 4862 then
		local var_304_140 = arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]))

		if #var_304_140 > 0 then
			return true, var_304_140, 1
		end
	elseif arg_304_1._id == 4866 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterUniqueIdCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("GHP", var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByCategory("GHP", var_304_1._refCards[2])
		})))), 1
	elseif arg_304_1._id == 4867 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterUniqueIdCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByCategory("H", var_304_1._refCards[2])
		})))), 1
	elseif arg_304_1._id == 4868 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterUniqueIdCards(B.mergeTable({
			B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_1._owner),
			arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[2])
		})))), 1
	elseif arg_304_1._id == 4870 then
		local var_304_141 = arg_304_0:filterCanChangeToBoardCards(B.filterInTypeCards(arg_304_0:getBattleCardsByStarGroup("GH", {
			5,
			6
		}), Data.CardType.monster))

		return true, var_304_141, math.min(#var_304_141, math.min(2, arg_304_0:getEmptyBoardPosCount()))
	elseif arg_304_1._id == 4871 then
		local var_304_142 = B.filterInNatureCards(B.mergeTable({
			B.filterFirstCards(arg_304_0:filterCanChangeToHandCards(arg_304_0._pileCards), 2),
			arg_304_0._handCards
		}), var_304_1._refCards[1])

		if #var_304_142 > 0 then
			return true, B.sortCardsByBoardPos(var_304_142), 1
		end
	elseif arg_304_1._id == 4872 then
		return true, arg_304_0:getBattleCardsBy4872(), 1
	elseif arg_304_1._id == 4875 then
		return true, B.mergeTable({
			B.filterXYZCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_2), true),
			B.filterXYZCards(var_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_2), true)
		}), 1
	elseif arg_304_1._id == 4899 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryGroup("GL", var_304_1._refCards)), 1
	elseif arg_304_1._id == 4900 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInCategoryGroupCards(arg_304_0:getBattleCardsByMaxStar("GL", var_304_2), var_304_1._refCards)), 1
	elseif arg_304_1._id == 4901 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), true), arg_304_2._info._star + 1), nil, nil, nil, arg_304_2._owner == arg_304_1._owner._owner), 1
	elseif arg_304_1._id == 4906 or arg_304_1._id == 7559 or arg_304_1._id == 5610 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("GL", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4907 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("PG", var_304_1._refCards[2]), arg_304_2), nil, nil, nil, arg_304_2._owner == arg_304_1._owner._owner)), 1
	elseif arg_304_1._id == 4909 then
		return true, B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStar("G", 10), var_304_1._refCards[2]), 2
	elseif arg_304_1._id == 4912 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]))), 2
	elseif arg_304_1._id == 4913 or arg_304_1._id == 9939 or arg_304_1._id == 13788 or arg_304_1._id == 13834 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByStar("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4914 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByNatureGroup("GL", {
			var_304_1._refCards[1],
			var_304_1._refCards[2]
		}), var_304_1._refCards[3])), 1
	elseif arg_304_1._id == 4915 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2), var_304_1._refCards[2])), 2
	elseif arg_304_1._id == 4917 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByStar("P", arg_304_2:getStar()), var_304_1._refCards[1]), nil, nil, nil, true)), 1
	elseif arg_304_1._id == 4918 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByMaxAtk("B", arg_304_2._atk)), 1
	elseif arg_304_1._id == 4920 then
		return true, B.mergeTable({
			arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]),
			B.filterCounterTrapCards(arg_304_0:getBattleCardsByType("G", Data.CardType.trap))
		}), 1
	elseif arg_304_1._id == 4934 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNormalCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster))), 2
	elseif arg_304_1._id == 4935 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByNature("P", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4936 then
		return true, B.sortCardsByBoardPos(B.filterInNatureCards(arg_304_0:getBattleCardsByMinStar("B", 0), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4937 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("PGH", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 4940 or arg_304_1._id == 13438 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), true), nil, nil, nil, true), 1
	elseif arg_304_1._id == 4943 then
		local var_304_143 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), nil, nil, nil, true)

		return true, B.sortCardsByBoardPos(var_304_143), math.min(2, math.min(arg_304_0:getEmptyBoardPosCount() + 1, #var_304_143))
	elseif arg_304_1._id == 4944 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy4944()), 1
	elseif arg_304_1._id == 4945 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("GP", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 4975 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotEqualInfoIdCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[2]), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 4977 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), true), arg_304_2._info._star + 1), nil, nil, nil, true), 1
	elseif arg_304_1._id == 4981 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInNatureCards(arg_304_0:getBattleCardsByMaxAtk("G", var_304_2), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 4985 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("HP", Data.CardKeyword.cartoon), true, true)), 1
	elseif arg_304_1._id == 4986 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoIdGroup("GP", var_304_1._refCards)), 1
	elseif arg_304_1._id == 4993 or arg_304_1._id == 5566 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("G", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 4994 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNoSkillCards(var_304_0:getBattleCardsByType("G", Data.CardType.monster), 6009)), 1
	elseif arg_304_1._id == 5028 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterCanMergeToCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster)))), 1
	elseif arg_304_1._id == 5044 or arg_304_1._id == 9611 or arg_304_1._id == 9620 or arg_304_1._id == 7574 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("GH", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5048 or arg_304_1._id == 5476 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBattleCards("BCSD"), BattleData.PositiveType.shieldTrap)), 1
	elseif arg_304_1._id == 5063 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterFieldMagicCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic)))), 1
	elseif arg_304_1._id == 5068 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNormalCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 5079 then
		return true, B.reverseTable(arg_304_0:filterCanChangeToHandCards(var_304_0:getBattleCardsByType("G", Data.CardType.magic))), 1
	elseif arg_304_1._id == 5087 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1])), var_304_2
	elseif arg_304_1._id == 5088 then
		return true, B.filterInKeywordCards(B.mergeTable({
			arg_304_0:getBattleCardsByType("G", Data.CardType.magic),
			arg_304_0:getBattleCardsByType("G", Data.CardType.trap, Data.CARD_MAX_LEVEL, arg_304_1._owner)
		}), var_304_1._refCards[2]), 1
	elseif arg_304_1._id == 5093 then
		return true, B.mergeTable({
			arg_304_0:getBattleCardsByInfoId("G", var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByInfoId("G", var_304_1._refCards[2])
		}), 1
	elseif arg_304_1._id == 5105 or arg_304_1._id == 5600 then
		return true, var_304_0:getBattleCards("SD"), 1
	elseif arg_304_1._id == 5106 then
		local var_304_144 = B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			var_304_0:getBattleCards("CSD")
		})

		return true, var_304_144, math.min(#var_304_144, 2)
	elseif arg_304_1._id == 5113 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.magicMark)),
			arg_304_0:getBattleCardsByBuff("CSD", true, BattleData.PositiveType.magicMark)
		}), 1
	elseif arg_304_1._id == 5121 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("G", 4), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5143 or arg_304_1._id == 5144 or arg_304_1._id == 9585 or arg_304_1._id == 7654 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[2]))), 1
	elseif arg_304_1._id == 5145 then
		local var_304_145 = arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("GH", 3), var_304_1._refCards[2]))

		return true, var_304_145, math.min(#var_304_145, 2)
	elseif arg_304_1._id == 5156 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("HB", Data.CardType.monster), var_304_1._refCards[1]), BattleData.PositiveType.shieldTrap, true)), 1
	elseif arg_304_1._id == 5168 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("PH", arg_304_2:getStar()), var_304_1._refCards[2]), nil, true)), 1
	elseif arg_304_1._id == 5174 then
		local var_304_146 = B.sortCardsByBoardPos(var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("BCSD")))

		return true, var_304_146, math.min(#var_304_146, 2)
	elseif arg_304_1._id == 5176 or arg_304_1._id == 9043 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoIdGroup("GP", var_304_1._refCards))), 1
	elseif arg_304_1._id == 5185 then
		local var_304_147 = B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD"))

		return true, var_304_147, math.min(#var_304_147, 2)
	elseif arg_304_1._id == 5189 then
		local var_304_148 = arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]),
			var_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1])
		}))

		return true, var_304_148, math.min(#var_304_148, 2)
	elseif arg_304_1._id == 5190 then
		return true, B.filterSpiritCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster)), 1
	elseif arg_304_1._id == 5198 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 5200 or arg_304_1._id == 5270 or arg_304_1._id == 5441 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBoardCards(), BattleData.PositiveType.shieldTrap)), 1
	elseif arg_304_1._id == 5204 then
		local var_304_149 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[2]))

		return true, var_304_149, math.min(#var_304_149, 2)
	elseif arg_304_1._id == 5208 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSummonedBySyncCards(arg_304_0:getBattleCardsByType("G", Data.CardType.rare))), 1
	elseif arg_304_1._id == 5210 then
		local var_304_150 = arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxOriginDef("P", var_304_2), var_304_1._refCards[1]))

		if #var_304_150 > 0 then
			return true, var_304_150, 1
		end
	elseif arg_304_1._id == 5211 then
		local var_304_151 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]))

		if #var_304_151 > 0 then
			return true, var_304_151, 1
		end
	elseif arg_304_1._id == 5214 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster), var_304_1._refCards[1])), nil, true), 1
	elseif arg_304_1._id == 5218 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxAtk("G", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5227 or arg_304_1._id == 5353 then
		local var_304_152 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]))
		local var_304_153 = {}

		for iter_304_4 = 1, #var_304_152 do
			if #B.filterInStarCards(var_304_152, var_304_152[iter_304_4]:getStar()) > 1 then
				var_304_153[#var_304_153 + 1] = var_304_152[iter_304_4]
			end
		end

		return true, var_304_153, 2
	elseif arg_304_1._id == 5230 then
		return true, arg_304_0:getBattleCardsByCategory("L", var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 5232 then
		local var_304_154 = B.filterNotActionedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]))
		local var_304_155 = {}

		for iter_304_5 = 1, #var_304_154 do
			if #B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1]), var_304_154[iter_304_5]) > 0 then
				var_304_155[#var_304_155 + 1] = var_304_154[iter_304_5]
			end
		end

		return true, B.sortCardsByBoardPos(var_304_155), 1
	elseif arg_304_1._id == 5243 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("HP", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5254 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCards("L")), 1
	elseif arg_304_1._id == 5255 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInNatureCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5257 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_304_0:getBattleCardsByStar("R", arg_304_2:getStar() + 1), true)), 1
	elseif arg_304_1._id == 5260 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSDGH")), 1
	elseif arg_304_1._id == 5267 then
		local var_304_156 = B.filterUniqueInfoIdCards(arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			B.filterAdjustCards(arg_304_0:getBattleCards("G"), true),
			B.filterSyncCards(arg_304_0:getBattleCards("G"), true)
		})))

		return true, var_304_156, math.min(#var_304_156, 2)
	elseif arg_304_1._id == 5274 or arg_304_1._id == i then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategory("L", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5282 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("HB", Data.CardType.monster), var_304_1._refCards[1])), var_304_2
	elseif arg_304_1._id == 5283 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD"))
		}), 3
	elseif arg_304_1._id == 5284 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")), var_304_2
	elseif arg_304_1._id == 5288 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeywordGroup("GP", {
			var_304_1._refCards[2],
			var_304_1._refCards[3]
		})), 2
	elseif arg_304_1._id == 5290 or arg_304_1._id == 6794 or arg_304_1._id == 9531 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeywordGroup("H", var_304_1._refCards)), 1
	elseif arg_304_1._id == 5296 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotEqualInfoIdExCards(arg_304_0:getBattleCardsByCategory("HG", arg_304_2._info._category), arg_304_2._infoId)), 1
	elseif arg_304_1._id == 5301 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[3])), 1
	elseif arg_304_1._id == 5307 or arg_304_1._id == 6984 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			B.sortCardsByBoardPos(arg_304_0:getBoardCards())
		}), 2
	elseif arg_304_1._id == 5309 or arg_304_1._id == 4797 or arg_304_1._id == 4853 or arg_304_1._id == 9720 or arg_304_1._id == 13417 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("L", Data.CardType.monster), var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 5311 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCardsByType("L", Data.CardType.monster),
			var_304_0:getBattleCardsByType("L", Data.CardType.monster)
		})), 1
	elseif arg_304_1._id == 5312 or arg_304_1._id == 7699 or arg_304_1._id == 13201 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCardsByType("G", Data.CardType.monster),
			var_304_0:getBattleCardsByType("G", Data.CardType.monster)
		})), 1
	elseif arg_304_1._id == 5314 then
		if B.getMaxSameNameCardsCount(B.filterTokenCards(arg_304_0:getBoardCards(), false)) == 2 then
			return true, var_304_0:getBattleCards("CSD"), 1
		end
	elseif arg_304_1._id == 5315 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterCeremonyMagicCards(arg_304_0:getBattleCardsByType("PGH", Data.CardType.magic))), 1
	elseif arg_304_1._id == 5324 then
		local var_304_157 = B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, arg_304_2))
		})

		if #var_304_157 > 0 then
			return true, var_304_157, math.min(#var_304_157, 2)
		end
	elseif arg_304_1._id == 5329 then
		return true, B.filterInCategoryCards(arg_304_0:getBattleCardsByHp("L", 0), var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 5337 then
		return true, B.filterInNatureCards(arg_304_0:getBattleCardsByMaxAtk("B", var_304_2), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 5344 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInStarCards(arg_304_0:getBattleCardsByCategoryAndNature("GP", arg_304_2._info._category, arg_304_2._info._nature), arg_304_2:getStar()), arg_304_2)), 1
	elseif arg_304_1._id == 5363 then
		return true, arg_304_0:getBattleCardsBy5363(), 1
	elseif arg_304_1._id == 5365 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("GL", var_304_1._refCards[1]), true, true), 1
	elseif arg_304_1._id == 5372 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoId("GH", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5374 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_2._owner:getBattleCardsByCategory("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5383 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoId("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5385 or arg_304_1._id == 8090 then
		local var_304_158 = arg_304_0:getBattleCardsByCategoryAndNature("L", var_304_1._refCards[2], var_304_1._refCards[1])
		local var_304_159 = arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			B.filterNormalCards(var_304_158),
			B.filterAllyMonsterCards(var_304_158)
		}))

		return true, var_304_159, 1
	elseif arg_304_1._id == 5386 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAllyMonsterCards(arg_304_0:getBattleCards("G"))), 1
	elseif arg_304_1._id == 5391 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZStarCards(arg_304_0:getBattleCardsByKeywordGroup("R", var_304_1._refCards), arg_304_2._info._star + var_304_2)), 1
	elseif arg_304_1._id == 5393 then
		local var_304_160 = B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("L", var_304_1._refCards[1]), arg_304_1._owner)

		return true, var_304_160, math.min(#var_304_160, 2)
	elseif arg_304_1._id == 5394 then
		return true, B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("L", var_304_1._refCards[1]), arg_304_1._owner), 1
	elseif arg_304_1._id == 5399 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[2])
		})), 1
	elseif arg_304_1._id == 5406 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStar("PH", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 5407 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_2)), 1
	elseif arg_304_1._id == 5410 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("BCSD", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5413 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("PG", var_304_1._refCards[2]), true, true)), 1
	elseif arg_304_1._id == 5416 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy5416()), 1
	elseif arg_304_1._id == 5418 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterUniqueIdCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("PH", var_304_1._refCards[1]),
			B.filterAdjustCards(arg_304_0:getBattleCardsByMaxStar("PH", var_304_2), true)
		})))), 1
	elseif arg_304_1._id == 5419 or arg_304_1._id == 5614 or arg_304_1._id == 13636 or arg_304_1._id == 13691 then
		return true, B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), arg_304_1._owner), 1
	elseif arg_304_1._id == 5420 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), arg_304_2), nil, nil, nil, true), 1
	elseif arg_304_1._id == 5422 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("L", var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 5423 or arg_304_1._id == 5425 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("HGL", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5426 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNoMark5426Cards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 5433 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]), BattleData.PositiveType.shieldTrap)), 1
	elseif arg_304_1._id == 5438 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterOnGraveRoundCards(B.filterMarkLinkComponentToGraveCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster)), arg_304_0._round)), 1
	elseif arg_304_1._id == 5439 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByMaxXYZStar("G", var_304_2), true, true), 1
	elseif arg_304_1._id == 5440 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy5440()), 1
	elseif arg_304_1._id == 5445 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy5445(arg_304_1._owner)), 1
	elseif arg_304_1._id == 5446 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("HGP", var_304_1._refCards[2]), arg_304_2)), 1
	elseif arg_304_1._id == 5447 then
		local var_304_161 = B.filterUniqueIdCards(B.mergeTable({
			arg_304_0:getBattleCardsByCategory("GL", var_304_1._refCards[1]),
			B.filterNotEqualInfoIdCards(arg_304_0:getBattleCardsByKeyword("GL", var_304_1._refCards[2]), var_304_1._refCards[3])
		}))

		return true, var_304_161, math.min(2, #var_304_161)
	elseif arg_304_1._id == 5450 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy5450()), 1
	elseif arg_304_1._id == 5453 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterUniqueInfoIdCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1])), nil, nil, nil, true)), 2
	elseif arg_304_1._id == 5455 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterDualCards(arg_304_0:getBattleCards("L"))), 1
	elseif arg_304_1._id == 5458 then
		return true, B.filterExcludeCards(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryAndNature("L", var_304_1._refCards[2], var_304_1._refCards[1])), arg_304_1._owner._mark5458 or {}), 1
	elseif arg_304_1._id == 5492 then
		local var_304_162 = B.mergeTable({
			B.filterFirstCards(arg_304_0:filterCanChangeToHandCards(arg_304_0._pileCards), 2),
			arg_304_0._handCards
		})
		local var_304_163 = B.mergeTable({
			B.filterNormalCards(var_304_162),
			B.filterDualCards(var_304_162)
		})

		if #var_304_163 > 0 then
			return true, B.sortCardsByBoardPos(var_304_163), 1
		end
	elseif arg_304_1._id == 5494 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByStar("H", arg_304_2:getStar())), 1
	elseif arg_304_1._id == 5498 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("B", 4), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5502 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy5502()), 1
	elseif arg_304_1._id == 5503 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")), 3
	elseif arg_304_1._id == 5505 then
		return true, B.sortCardsByBoardPos(B.filterFirstCards(arg_304_0._pileCards, #arg_304_0:getBattleCardsByKeyword("BCSD", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 5506 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNamesCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]), arg_304_0:getBoardCards()))), 1
	elseif arg_304_1._id == 5510 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), true)), 1
	elseif arg_304_1._id == 5514 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("G", {
			Data.CardType.magic,
			Data.CardType.trap
		}, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5515 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("GL", var_304_1._refCards[1]), true, true, nil, true), 1
	elseif arg_304_1._id == 5517 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy5517()), 1
	elseif arg_304_1._id == 5522 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByStar("P", arg_304_2:getStar())), 1
	elseif arg_304_1._id == 5525 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 5527 then
		return true, B.filter5527Cards(arg_304_0:getBattleCardsByType("HG", Data.CardType.monster), arg_304_0), 1
	elseif arg_304_1._id == 5529 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("PR", var_304_1._refCards[1]), true, true), 1
	elseif arg_304_1._id == 5538 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("PH", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 5545 then
		return true, B.sortCardsByBoardPos(B.filterUniqueIdCards(B.mergeTable({
			B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_1._owner),
			B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[2])
		}))), 2
	elseif arg_304_1._id == 5547 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeywordGroup("R", var_304_1._refCards), true), arg_304_2._info._star), true, true), 1
	elseif arg_304_1._id == 5559 then
		return true, B.sortCardsByBoardPos(B.filterInTypeCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), Data.CardType.monster)), 1
	elseif arg_304_1._id == 5561 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.rare), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 5564 or arg_304_1._id == 5565 then
		return true, B.filterInKeywordGroupCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster), var_304_1._refCards), 1
	elseif arg_304_1._id == 5570 then
		local var_304_164 = var_304_0._graveCards

		return true, var_304_164, math.min(#var_304_164, var_304_2)
	elseif arg_304_1._id == 5577 then
		return true, arg_304_0:getBattleCardsByCategory("GL", var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 5578 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterSameNameCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), arg_304_2))), 1
	elseif arg_304_1._id == 5581 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoIdGroup("R", var_304_1._refCards), true, true, nil, true)), 1
	elseif arg_304_1._id == 5585 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("PG", var_304_1._refCards[1]), arg_304_2), nil, nil, nil, true)), 1
	elseif arg_304_1._id == 5595 then
		local var_304_165 = arg_304_0:getBattleCardsByKeyword("BCSD", var_304_1._refCards[1])

		return true, B.sortCardsByBoardPos(var_304_165), #var_304_165
	elseif arg_304_1._id == 5598 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.xyzMark), BattleData.PositiveType.shieldTrap, true)), 1
	elseif arg_304_1._id == 5616 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), true)), 1
	elseif arg_304_1._id == 6243 or arg_304_1._id == 6250 or arg_304_1._id == 6371 or arg_304_1._id == 6431 or arg_304_1._id == 2299 or arg_304_1._id == 2849 or arg_304_1._id == 13022 or arg_304_1._id == 13344 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6244 then
		local var_304_166 = arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]))

		if #var_304_166 > 0 then
			return true, var_304_166, 1
		end
	elseif arg_304_1._id == 6246 then
		local var_304_167 = arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1]))

		if #var_304_167 > 0 then
			return true, var_304_167, 1
		end
	elseif arg_304_1._id == 6261 or arg_304_1._id == 2859 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(var_304_0:getBoardCards())), 1
	elseif arg_304_1._id == 6263 or arg_304_1._id == 2408 or arg_304_1._id == 2450 or arg_304_1._id == 9074 or arg_304_1._id == 9370 or arg_304_1._id == 9934 or arg_304_1._id == 13851 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6265 or arg_304_1._id == 6268 or arg_304_1._id == 9073 or arg_304_1._id == 5543 or arg_304_1._id == 5557 or arg_304_1._id == 13533 or arg_304_1._id == 13551 or arg_304_1._id == 13622 or arg_304_1._id == 13693 or arg_304_1._id == 13792 or arg_304_1._id == 13793 then
		return true, arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 6266 or arg_304_1._id == 6267 or arg_304_1._id == 6994 or arg_304_1._id == 13112 or arg_304_1._id == 13425 or arg_304_1._id == 13443 or arg_304_1._id == 13581 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("G", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6272 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 2
	elseif arg_304_1._id == 6286 or arg_304_1._id == 7635 or arg_304_1._id == 9598 or arg_304_1._id == 13602 then
		return true, arg_304_0:getBattleCardsByNature("H", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 6274 or arg_304_1._id == 5263 or arg_304_1._id == 5489 or arg_304_1._id == 5495 or arg_304_1._id == 13365 then
		return true, arg_304_0:getBattleCardsByType("H", Data.CardType.monster), 1
	elseif arg_304_1._id == 6277 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("B", var_304_2), var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 6285 then
		return true, B.filterInNatureCards(arg_304_0:getBattleCardsByMinStar("H", var_304_2, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 6296 then
		return true, arg_304_0:filterCanChangeToBoardCards(var_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6303 then
		local var_304_168 = arg_304_0:getBattleCardsByMaxStar("P", var_304_2)

		if #var_304_168 > 0 then
			return true, var_304_168, 1
		end
	elseif arg_304_1._id == 6307 or arg_304_1._id == 6784 or arg_304_1._id == 6969 or arg_304_1._id == 2477 or arg_304_1._id == 9381 or arg_304_1._id == 9680 or arg_304_1._id == 9719 or arg_304_1._id == 9829 or arg_304_1._id == 13004 or arg_304_1._id == 13053 or arg_304_1._id == 13088 or arg_304_1._id == 13363 or arg_304_1._id == 13418 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6308 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 6309 or arg_304_1._id == 9114 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 6313 or arg_304_1._id == 2757 then
		return true, arg_304_0:getBattleCards("H"), 2
	elseif arg_304_1._id == 6321 or arg_304_1._id == 6440 or arg_304_1._id == 6882 or arg_304_1._id == 6883 or arg_304_1._id == 7404 or arg_304_1._id == 2406 or arg_304_1._id == 2435 or arg_304_1._id == 2586 or arg_304_1._id == 2588 or arg_304_1._id == 2958 or arg_304_1._id == 9760 or arg_304_1._id == 9880 or arg_304_1._id == 13220 or arg_304_1._id == 13221 or arg_304_1._id == 13672 then
		return true, arg_304_0:getBattleCardsByNature("G", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 6327 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 6332 then
		return true, var_304_0:getBattleCardsByNature("B", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 6333 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 6335 then
		local var_304_169 = B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1])

		if #var_304_169 > 0 then
			return true, var_304_169, 1
		end
	elseif arg_304_1._id == 6338 or arg_304_1._id == 6906 or arg_304_1._id == 6908 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 6339 then
		local var_304_170 = arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1]), var_304_1._refCards[2]))

		if #var_304_170 > 0 then
			return true, var_304_170, 1
		end
	elseif arg_304_1._id == 6340 or arg_304_1._id == 2868 or arg_304_1._id == 4727 or arg_304_1._id == 5530 then
		return true, arg_304_0:getBattleCardsByNature("G", var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 6316 or arg_304_1._id == 6346 or arg_304_1._id == 6694 or arg_304_1._id == 3522 or arg_304_1._id == 2207 or arg_304_1._id == 2266 or arg_304_1._id == 2674 or arg_304_1._id == 2803 or arg_304_1._id == 9490 or arg_304_1._id == 9744 or arg_304_1._id == 9745 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBoardCards(), BattleData.PositiveType.shieldMonster)), 1
	elseif arg_304_1._id == 6347 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner), BattleData.PositiveType.shieldMagic, true)), 1
	elseif arg_304_1._id == 6351 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2), var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 6360 then
		local var_304_171 = B.filterSyncCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), true)
		local var_304_172 = {}

		for iter_304_6 = 1, #var_304_171 do
			if var_304_171[iter_304_6]._syncComponents ~= nil and #arg_304_0:filterCanChangeToBoardCards(B.filterInStatusCards(var_304_171[iter_304_6]._syncComponents, BattleData.CardStatus.grave)) > 0 then
				var_304_172[#var_304_172 + 1] = var_304_171[iter_304_6]
			end
		end

		return true, var_304_172, 1
	elseif arg_304_1._id == 6372 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByStar("P", 4), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6374 or arg_304_1._id == 7629 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategory("L", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6375 or arg_304_1._id == 2345 then
		return true, var_304_0:getBattleCards("C"), 1
	elseif arg_304_1._id == 6382 then
		local var_304_173 = arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[1])

		if #var_304_173 > 0 then
			return true, B.sortCardsByBoardPos(var_304_173), 1
		end
	elseif arg_304_1._id == 6384 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCards("P"), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6393 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterAdjustCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxOriginAtk("P", var_304_2), var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 6398 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxOriginAtk("R", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6400 or arg_304_1._id == 2738 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]),
			var_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])
		})), 1
	elseif arg_304_1._id == 6401 or arg_304_1._id == 6406 or arg_304_1._id == 7507 or arg_304_1._id == 7697 or arg_304_1._id == 9313 then
		return true, var_304_0:getBattleCards("H"), 1
	elseif arg_304_1._id == 6407 then
		local var_304_174 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2, Data.CARD_MAX_LEVEL, arg_304_1._owner))

		if #var_304_174 > 0 then
			return true, var_304_174, 1
		end
	elseif arg_304_1._id == 6412 then
		local var_304_175 = B.filterSyncCards(arg_304_0:getBoardCards(), true)
		local var_304_176 = B.filterSyncCards(var_304_0:getBoardCards(), true)

		if #var_304_175 + #var_304_176 > 0 then
			local var_304_177 = arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_1._owner))

			if #var_304_177 > 0 then
				return true, var_304_177, 1
			end
		end
	elseif arg_304_1._id == 6419 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBoardCards(), BattleData.PositiveType.shieldMonster)), 1
	elseif arg_304_1._id == 6420 or arg_304_1._id == 6877 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), true)), 1
	elseif arg_304_1._id == 6422 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(B.filterInNatureCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[2]), var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 6424 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("G", var_304_2), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 6444 or arg_304_1._id == 2409 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6458 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxOriginDef("P", var_304_2), var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 6468 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("PG", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 6451 or arg_304_1._id == 6452 or arg_304_1._id == 6510 or arg_304_1._id == 6511 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 6474 or arg_304_1._id == 2608 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxOriginAtk("P", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6475 or arg_304_1._id == 6480 then
		local var_304_178 = arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar(arg_304_1._id == 6475 and "G" or "L", var_304_2), var_304_1._refCards[1]))

		if #var_304_178 > 0 then
			return true, var_304_178, 1
		end
	elseif arg_304_1._id == 6476 then
		local var_304_179 = B.filterAdjustCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), false)
		local var_304_180 = {}

		for iter_304_7 = 1, #var_304_179 do
			local var_304_181 = var_304_179[iter_304_7]

			if #arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("R", arg_304_1._owner:getStar() + var_304_181:getStar()), var_304_1._refCards[1]), true)) > 0 then
				var_304_180[#var_304_180 + 1] = var_304_181
			end
		end

		return true, var_304_180, 1
	elseif arg_304_1._id == 6497 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByMaxHp("B", arg_304_1._owner._atk)), 2
	elseif arg_304_1._id == 6485 or arg_304_1._id == 13032 or arg_304_1._id == 13586 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), true), true, true), 1
	elseif arg_304_1._id == 6507 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy6507()), 1
	elseif arg_304_1._id == 6509 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6512 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByStar("P", var_304_2), var_304_1._refCards[1]))), 2
	elseif arg_304_1._id == 6514 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByMaxOriginAtk("G", arg_304_1._owner._mark6514)), 1
	elseif arg_304_1._id == 6515 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxOriginAtk("P", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6520 or arg_304_1._id == 5573 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterSustainableTrapCards(arg_304_0:getBattleCardsByType("G", Data.CardType.trap))), 1
	elseif arg_304_1._id == 6525 or arg_304_1._id == 2956 or arg_304_1._id == 13023 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByMaxStar("B", var_304_2)), 1
	elseif arg_304_1._id == 6526 or arg_304_1._id == 6596 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByCategoryGroup("B", var_304_1._refCards)), 1
	elseif arg_304_1._id == 6528 then
		return true, B.sortCardsByBoardPos(var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("BCSD"))), 2
	elseif arg_304_1._id == 6531 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInNatureCards(arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[1]), var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 6532 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterCeremonyMagicCards(arg_304_0:getBattleCards("GP")))), 1
	elseif arg_304_1._id == 6535 then
		return true, B.mergeTable({
			B.filterCeremonyMonsterCards(arg_304_0:getBattleCards("G")),
			arg_304_0:getBattleCardsByInfoId("G", var_304_1._refCards[1])
		}), 1
	elseif arg_304_1._id == 6547 then
		return true, arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByInfoId("P", var_304_1._refCards[2])
		})), 1
	elseif arg_304_1._id == 6550 then
		return true, arg_304_0:getBattleCardsByCategoryGroup("BH", var_304_1._refCards, Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 6552 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterCeremonyMagicCards(arg_304_0:getBattleCards("G"))), 1
	elseif arg_304_1._id == 6555 then
		local var_304_182 = B.sortCardsByBoardPos(B.filterDefPostureCards(var_304_0:getBoardCards(), true))

		if #var_304_182 >= 2 then
			return true, var_304_182, 2
		end
	elseif arg_304_1._id == 6556 or arg_304_1._id == 2737 or arg_304_1._id == 9377 or arg_304_1._id == 9391 or arg_304_1._id == 9400 or arg_304_1._id == 13332 then
		return true, arg_304_0:getBattleCardsByCategory("H", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 6558 then
		local var_304_183 = arg_304_1._owner:getStar()
		local var_304_184 = {}
		local var_304_185 = arg_304_0:getBattleCardsByCategory("H", var_304_1._refCards[1])

		for iter_304_8 = 1, #var_304_185 do
			local var_304_186 = false
			local var_304_187 = var_304_185[iter_304_8]:getStar()

			if var_304_183 <= var_304_187 then
				var_304_186 = true
			end

			if not var_304_186 then
				for iter_304_9 = 1, #var_304_185 do
					if iter_304_8 ~= iter_304_9 and var_304_183 <= var_304_187 + var_304_185[iter_304_9]:getStar() then
						var_304_186 = true

						break
					end
				end
			end

			if var_304_186 then
				var_304_184[#var_304_184 + 1] = var_304_185[iter_304_8]
			end
		end

		return true, var_304_184, 2
	elseif arg_304_1._id == 6559 or arg_304_1._id == 9082 then
		return true, arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 6560 or arg_304_1._id == 7244 or arg_304_1._id == 8059 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByType("BH", Data.CardType.monster)), 1
	elseif arg_304_1._id == 6561 then
		local var_304_188 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("H", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))

		if #var_304_188 > 0 then
			return true, var_304_188, 1
		end
	elseif arg_304_1._id == 6562 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCards("HG")), 1
	elseif arg_304_1._id == 6563 then
		return true, var_304_0:getBattleCardsByType("GB", Data.CardType.monster), 1
	elseif arg_304_1._id == 6564 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(B.filterInCategoryCards(B.mergeTable({
			arg_304_0:getBattleCardsByStar("G", 7),
			arg_304_0:getBattleCardsByStar("G", 8),
			var_304_0:getBattleCardsByStar("G", 7),
			var_304_0:getBattleCardsByStar("G", 8)
		}), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 6571 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 6573 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterMergeCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 6579 then
		return true, B.sortCardsByBoardPos(B.filterAdjustCards(arg_304_0:getBattleCardsByType("GHB", Data.CardType.monster), true)), 1
	elseif arg_304_1._id == 6584 then
		local var_304_189

		if arg_304_1._owner:isInfoId(var_304_1._refCards[2]) then
			var_304_189 = arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("P", {
				Data.CardType.monster,
				Data.CardType.magic
			}), var_304_1._refCards[1]))
		else
			var_304_189 = arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]))
		end

		return true, B.sortCardsByBoardPos(var_304_189), 1
	elseif arg_304_1._id == 6585 then
		local var_304_190 = arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1]))

		if #var_304_190 > 0 then
			return true, var_304_190, 1
		end
	elseif arg_304_1._id == 6591 then
		local var_304_191 = arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxAtk("G", var_304_2), var_304_1._refCards[1]))

		if #var_304_191 > 0 then
			return true, var_304_191, 1
		end
	elseif arg_304_1._id == 6594 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("PHG", var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 6595 then
		if #var_304_0:getBoardCards() > 0 then
			local var_304_192 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))

			if #var_304_192 > 0 then
				return true, var_304_192, 1
			end
		end
	elseif arg_304_1._id == 6597 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 6601 then
		local var_304_193 = B.getMinAtkCard(arg_304_0:getBoardCards())._atk
		local var_304_194 = var_304_0:getBoardCards()

		if #var_304_194 > 0 then
			var_304_193 = math.min(var_304_193, B.getMinAtkCard(var_304_194)._atk)
		end

		local var_304_195 = B.sortCardsByBoardPos(arg_304_0:getBattleCardsByAtk("B", var_304_193))

		B.appendTable(var_304_195, B.sortCardsByBoardPos(var_304_0:getBattleCardsByAtk("B", var_304_193)))

		return true, var_304_195, 1
	elseif arg_304_1._id == 6605 or arg_304_1._id == 9838 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, arg_304_1._owner)), 2
	elseif arg_304_1._id == 6609 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("GH", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 6613 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1]), arg_304_1._owner), true, true), 1
	elseif arg_304_1._id == 6614 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("PH", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 6615 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSDGH")), 1
	elseif arg_304_1._id == 6616 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("H", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 6617 then
		return true, B.filterNoShieldCards(B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD", Data.CARD_MAX_LEVEL, arg_304_2))
		}), BattleData.PositiveType.shieldMonster), 2
	elseif arg_304_1._id == 6618 or arg_304_1._id == 6909 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_304_0:getBoardCards())), 1
	elseif arg_304_1._id == 6619 then
		local var_304_196 = arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCards("G"), true))
		local var_304_197 = {}

		for iter_304_10 = 1, #var_304_196 do
			local var_304_198 = var_304_196[iter_304_10]

			if #arg_304_0:filterCanChangeToBoardCards(B.filterInStarCards(B.filterAdjustCards(arg_304_0:getBattleCards("P"), true), var_304_198:getStar())) > 0 then
				var_304_197[#var_304_197 + 1] = var_304_198
			end
		end

		return true, var_304_197, 1
	elseif arg_304_1._id == 6621 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCardsByNature("G", var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 6624 then
		return true, arg_304_0:filterCanChangeToBoardCards(var_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6627 or arg_304_1._id == 13002 or arg_304_1._id == 13430 or arg_304_1._id == 13575 or arg_304_1._id == 13626 then
		return true, B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner), 1
	elseif arg_304_1._id == 6631 then
		return true, arg_304_0:getBattleCardsByNature("G", var_304_1._refCards[2]), 1
	elseif arg_304_1._id == 6636 then
		return true, var_304_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.deedMark), 1
	elseif arg_304_1._id == 6639 or arg_304_1._id == 6643 or arg_304_1._id == 2312 or arg_304_1._id == 8038 or arg_304_1._id == 9643 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCards("G"))), 1
	elseif arg_304_1._id == 6649 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCards("P"), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 6650 then
		return true, arg_304_0:getBattleCardsByNatureGroup("G", var_304_1._refCards), 2
	elseif arg_304_1._id == 6656 or arg_304_1._id == 2238 or arg_304_1._id == 2277 or arg_304_1._id == 2538 or arg_304_1._id == 2572 then
		return true, B.sortCardsByBoardPos(B.filterSummonByNormalCards(var_304_0:getBoardCards(), false)), 1
	elseif arg_304_1._id == 6657 or arg_304_1._id == 4824 or arg_304_1._id == 9952 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 6658 then
		return true, B.mergeTable({
			arg_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner),
			var_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1])
		}), 1
	elseif arg_304_1._id == 6661 or arg_304_1._id == 4758 then
		return true, B.mergeTable({
			arg_304_0:getBattleCards("L"),
			var_304_0:getBattleCards("L")
		}), 1
	elseif arg_304_1._id == 6663 or arg_304_1._id == 6664 or arg_304_1._id == 2348 or arg_304_1._id == 2349 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCards((arg_304_1._id == 6663 or arg_304_1._id == 2348) and "BCSD" or "G")), 1
	elseif arg_304_1._id == 6667 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByHp("P", 1500), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6671 then
		return true, arg_304_0:getBattleCardsByMinStar("B", var_304_2), 1
	elseif arg_304_1._id == 6673 or arg_304_1._id == 2112 or arg_304_1._id == 9746 then
		return true, arg_304_0:getBattleCardsByTypeGroup("H", {
			Data.CardType.magic,
			Data.CardType.trap
		}), 1
	elseif arg_304_1._id == 6674 then
		return true, B.filterSyncCards(var_304_0:getBoardCards(), true), 1
	elseif arg_304_1._id == 6676 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByAtkDef("P", 800, 1000), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6677 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.mergeTable({
			arg_304_0:getBattleCardsByType("G", Data.CardType.monster),
			var_304_0:getBattleCardsByType("G", Data.CardType.monster)
		}), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6678 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("L", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6679 then
		return true, arg_304_0:getBattleCardsByNatureGroup("L", var_304_1._refCards), 1
	elseif arg_304_1._id == 6681 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6684 or arg_304_1._id == 2711 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD"))
		}), 2
	elseif arg_304_1._id == 6686 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6688 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxAtk("H", arg_304_1._owner._atk), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6690 or arg_304_1._id == 6702 or arg_304_1._id == 2221 or arg_304_1._id == 9956 or arg_304_1._id == 13028 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 6691 or arg_304_1._id == 6692 then
		local var_304_199 = B.sortCardsByBoardPos(B.mergeTable({
			B.filterCanBeSacrificedCards(B.filterTokenCards(arg_304_0:getBoardCards(), false)),
			B.filterTokenCards(arg_304_0:getBoardCards(), true)
		}))
		local var_304_200 = B.filterInKeywordCards(var_304_199, var_304_1._refCards[1])[1]

		if #var_304_199 >= 3 and var_304_200 ~= nil then
			return true, var_304_199, 3
		end
	elseif arg_304_1._id == 6699 or arg_304_1._id == 9062 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 6705 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBoardCards())),
			arg_304_0:getBattleCardsByType("CS", Data.CardType.trap)
		}), 2
	elseif arg_304_1._id == 6707 or arg_304_1._id == 6934 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeywordGroup("B", var_304_1._refCards, Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 6709 or arg_304_1._id == 2593 or arg_304_1._id == 9682 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6710 or arg_304_1._id == 4251 or arg_304_1._id == 4634 or arg_304_1._id == 4908 or arg_304_1._id == 7495 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6711 or arg_304_1._id == 2219 or arg_304_1._id == 4667 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6712 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(B.filterNotActionedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1])), BattleData.PositiveType.shieldMonster)), 1
	elseif arg_304_1._id == 6721 then
		local var_304_201 = arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), true))

		if #var_304_201 > 0 then
			return true, var_304_201, 1
		end
	elseif arg_304_1._id == 6730 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), false)), 1
	elseif arg_304_1._id == 6732 or arg_304_1._id == 6733 or arg_304_1._id == 6735 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(arg_304_0:getBattleCards("BCSD"), BattleData.PositiveType.shieldMonster)), 1
	elseif arg_304_1._id == 6866 or arg_304_1._id == 6929 or arg_304_1._id == 9361 or arg_304_1._id == 9488 or arg_304_1._id == 9840 then
		return true, var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("BCSD")), 1
	elseif arg_304_1._id == 6737 then
		return true, arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic), var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByInfoId("P", var_304_1._refCards[2])
		})), 1
	elseif arg_304_1._id == 6744 then
		return true, B.filterCounterTrapCards(arg_304_0:getBattleCardsByType("G", Data.CardType.trap)), 1
	elseif arg_304_1._id == 6745 then
		return true, B.filterInCategoryCards(arg_304_0:getBattleCardsByStarGroup("P", {
			var_304_1._refCards[2],
			var_304_1._refCards[3]
		}), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 6747 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByCategory("GH", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6748 or arg_304_1._id == 2188 or arg_304_1._id == 2298 or arg_304_1._id == 2353 or arg_304_1._id == 9710 or arg_304_1._id == 9779 or arg_304_1._id == 9858 or arg_304_1._id == 9953 or arg_304_1._id == 13092 or arg_304_1._id == 13408 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6751 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNormalCards(arg_304_0:getBattleCardsByCategory("GP", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 6754 then
		local var_304_202 = var_304_0:getBattleCardsByType("CS", Data.CardType.trap)

		if #var_304_202 >= 0 then
			return true, var_304_202, 1
		end
	elseif arg_304_1._id == 6765 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner), true)), 1
	elseif arg_304_1._id == 6766 or arg_304_1._id == 6767 then
		local var_304_203 = B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1]))

		if #var_304_203 > 0 then
			return true, var_304_203, 1
		end
	elseif arg_304_1._id == 6770 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNormalCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 6771 then
		local var_304_204 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByStar("G", var_304_2))

		if #var_304_204 > 0 then
			return true, var_304_204, 1
		end
	elseif arg_304_1._id == 6773 then
		return true, arg_304_0:getBattleCardsBy6773(), 1
	elseif arg_304_1._id == 6775 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByMaxOriginAtk("P", var_304_2)), 1
	elseif arg_304_1._id == 6778 then
		return true, B.filterXYZCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), false), 1
	elseif arg_304_1._id == 6782 then
		local var_304_205 = arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1]))

		if #var_304_205 > 0 then
			return true, var_304_205, 1
		end
	elseif arg_304_1._id == 6783 or arg_304_1._id == 13747 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("B", 0, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6786 or arg_304_1._id == 2657 or arg_304_1._id == 2741 or arg_304_1._id == 4962 or arg_304_1._id == 5516 or arg_304_1._id == 7704 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(arg_304_0:getBoardCards(), true)), 1
	elseif arg_304_1._id == 6787 then
		local var_304_206 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]))

		if #var_304_206 > 0 then
			return true, var_304_206, 1
		end
	elseif arg_304_1._id == 6792 then
		local var_304_207 = B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD"))

		return true, var_304_207, math.min(#var_304_207, #arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))
	elseif arg_304_1._id == 6795 then
		local var_304_208 = arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1])
		local var_304_209 = B.filterXYZCards(var_304_208, true)

		if #var_304_209 > 1 then
			return true, B.sortCardsByBoardPos(var_304_208), 1
		else
			return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, var_304_209[1])), 1
		end
	elseif arg_304_1._id == 6800 then
		local var_304_210 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2, Data.CARD_MAX_LEVEL, arg_304_1._owner))

		if #var_304_210 > 0 then
			return true, var_304_210, 1
		end
	elseif arg_304_1._id == 6803 or arg_304_1._id == 2677 or arg_304_1._id == 2951 then
		return true, arg_304_1._owner:getBindedEquipsByType(Data.CardType.magic), 1
	elseif arg_304_1._id == 6807 then
		return true, arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			arg_304_0:getBattleCardsByType("G", Data.CardType.trap),
			var_304_0:getBattleCardsByType("G", Data.CardType.trap)
		})), 1
	elseif arg_304_1._id == 6809 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotEqualInfoIdCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_1._owner._info._originId)), 1
	elseif arg_304_1._id == 6821 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInStarCards(B.filterInNatureCards(arg_304_0:getBattleCardsByCategoryGroup("P", {
			var_304_1._refCards[2],
			var_304_1._refCards[3]
		}), var_304_1._refCards[1]), var_304_2)), 1
	elseif arg_304_1._id == 6824 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]), arg_304_1._owner._info._originId)), 1
	elseif arg_304_1._id == 6829 then
		local var_304_211 = arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1])))

		if #var_304_211 > 0 then
			return true, var_304_211, 1
		end
	elseif arg_304_1._id == 6830 or arg_304_1._id == 6922 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("B", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6831 or arg_304_1._id == 6832 then
		local var_304_212 = B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), var_304_1._refCards[2]))

		if #var_304_212 > 0 then
			return true, var_304_212, 1
		end
	elseif arg_304_1._id == 6833 then
		local var_304_213 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))

		if #var_304_213 > 0 then
			return true, var_304_213, 2
		end
	elseif arg_304_1._id == 6835 then
		return true, arg_304_0:getBattleCardsByKeywordGroup("G", var_304_1._refCards), var_304_2
	elseif arg_304_1._id == 6836 then
		return true, arg_304_0:getBattleCardsByKeywordGroup("G", var_304_1._refCards), 1
	elseif arg_304_1._id == 6838 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 6839 or arg_304_1._id == 2531 or arg_304_1._id == 7716 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 6841 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[2]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6842 then
		return true, B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 6845 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 6846 or arg_304_1._id == 6847 then
		return true, B.sortCardsByBoardPos(B.filterNormalCards(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 6852 or arg_304_1._id == 9963 or arg_304_1._id == 13170 or arg_304_1._id == 13795 or arg_304_1._id == 13948 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6853 then
		return true, arg_304_0:getBattleCardsByNatureGroup("G", Data._skillInfo[6853]._refCards), 2
	elseif arg_304_1._id == 6854 then
		return true, arg_304_0:getBattleCardsByMaxStar("H", Data._skillInfo[6854]._val[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 6856 then
		return true, B.sortCardsByBoardPos(B.filterInTypeCards(arg_304_0:getBattleCardsByMinStar("BG", 0, Data.CARD_MAX_LEVEL, arg_304_1._owner), Data.CardType.monster)), 1
	elseif arg_304_1._id == 6858 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategoryAndNature("B", var_304_1._refCards[1], var_304_1._refCards[2], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 6859 then
		return true, B.filterCanBindMagicCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1])), arg_304_1._owner), 1
	elseif arg_304_1._id == 6860 then
		return true, B.filterCanBindMagicCards(B.filterUniqueInfoIdCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]))), arg_304_1._owner), math.min(2, arg_304_0:getEmptyGroundPosCount())
	elseif arg_304_1._id == 6861 then
		return true, B.mergeTable({
			var_304_0:getBattleCards("CSD"),
			arg_304_0:getBattleCards("CSD")
		}), #B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("S", var_304_1._refCards[1]))
	elseif arg_304_1._id == 6862 then
		return true, B.sortCardsByBoardPos(B.filterCanBindMagicCards(B.filterEquipMagicCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic), var_304_1._refCards[1])), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6864 or arg_304_1._id == 2368 or arg_304_1._id == 9285 or arg_304_1._id == 9417 or arg_304_1._id == 9978 or arg_304_1._id == 13398 or arg_304_1._id == 13761 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner))
		}), 1
	elseif arg_304_1._id == 6865 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("G", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6867 or arg_304_1._id == 2537 or arg_304_1._id == 9925 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), true), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6870 then
		return true, B.sortCardsByBoardPos(B.filterCanBindAlterMagicCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6871 then
		return true, arg_304_0:getBattleCardsByNatureGroup("H", var_304_1._refCards), 2
	elseif arg_304_1._id == 6872 or arg_304_1._id == 6873 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInNatureCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStar("G", var_304_2), var_304_1._refCards[1]), var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 6874 or arg_304_1._id == 6881 then
		return true, arg_304_0:getBattleCardsByInfoIdGroup("L", var_304_1._refCards), 1
	elseif arg_304_1._id == 6886 then
		return true, B.filterSyncCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), true), 1
	elseif arg_304_1._id == 6890 then
		return true, B.sortCardsByBoardPos(B.filterInTypeCards(arg_304_0:getBattleCardsByMaxQuality("P", var_304_1._refCards[1]), Data.CardType.monster)), 1
	elseif arg_304_1._id == 6897 or arg_304_1._id == 2770 or arg_304_1._id == 13429 or arg_304_1._id == 13577 then
		return true, B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner), 1
	elseif arg_304_1._id == 6919 or arg_304_1._id == 13569 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("L", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6920 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("L", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6927 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByStarGroup("G", {
			7,
			8
		}), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6944 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(B.filterInNatureCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]), var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 6946 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByMaxQuality("BCSD", var_304_1._refCards[1])),
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByMaxQuality("BCSD", var_304_1._refCards[1]))
		}), 1
	elseif arg_304_1._id == 6947 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("CSD", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6949 or arg_304_1._id == 13187 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStar("G", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6952 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByAtkDef("G", 1500, 200), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6965 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(var_304_0:getBattleCards("BCSD"), false, false)),
			B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCards("BCSD"), false, false))
		}), 1
	elseif arg_304_1._id == 6966 then
		return true, B.filterNoShieldCards(B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			B.sortCardsByBoardPos(arg_304_0:getBoardCards())
		}), BattleData.PositiveType.shieldMonster), 1
	elseif arg_304_1._id == 6967 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6970 or arg_304_1._id == 9059 or arg_304_1._id == 13100 or arg_304_1._id == 13101 or arg_304_1._id == 13357 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 6972 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInStarCards(arg_304_0:getBattleCardsByCategoryAndNature("P", var_304_1._refCards[2], var_304_1._refCards[1]), var_304_2)), 1
	elseif arg_304_1._id == 6977 or arg_304_1._id == 2338 or arg_304_1._id == 9091 or arg_304_1._id == 4911 or arg_304_1._id == 13419 or arg_304_1._id == 13591 or arg_304_1._id == 13688 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 6980 or arg_304_1._id == 6889 or arg_304_1._id == 2746 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCards("P")), 1
	elseif arg_304_1._id == 6981 or arg_304_1._id == 9627 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), true, true, nil, arg_304_1._id == 9627), 1
	elseif arg_304_1._id == 6985 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByMinAtk("B", 0)), 1
	elseif arg_304_1._id == 6987 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByMaxQuality("BCSD", var_304_1._refCards[1])),
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByMaxQuality("BCSD", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))
		}), 1
	elseif arg_304_1._id == 6989 or arg_304_1._id == 2481 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 6992 then
		local var_304_214 = arg_304_0:filterCanChangeToHandCards(B.filterUniqueInfoIdCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1])))

		return true, B.sortCardsByBoardPos(var_304_214), #B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("B", var_304_2), var_304_1._refCards[2]) > 0 and math.min(2, #var_304_214) or 1
	elseif arg_304_1._id == 2104 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterSyncCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), var_304_1._refCards[2]), true), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2113 then
		local var_304_215 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("H", var_304_1._refCards[1]))

		return true, var_304_215, math.min(#var_304_215, 2)
	elseif arg_304_1._id == 2114 or arg_304_1._id == 2159 or arg_304_1._id == 2424 or arg_304_1._id == 2678 or arg_304_1._id == 2719 or arg_304_1._id == 2721 or arg_304_1._id == 2914 or arg_304_1._id == 5513 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCards("BSD")), 1
	elseif arg_304_1._id == 2116 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD"))
		}), 3
	elseif arg_304_1._id == 2117 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotActionedCards(arg_304_0:getBoardCards()), false, false)), 1
	elseif arg_304_1._id == 2118 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByMinStar("GH", var_304_2), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2120 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoId("R", var_304_1._refCards[3])), 1
	elseif arg_304_1._id == 2131 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotEqualInfoIdExCards(arg_304_0:getBattleCardsByInfoId("PG", var_304_1._refCards[1]), arg_304_1._owner._infoId))), 1
	elseif arg_304_1._id == 2133 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(B.mergeTable({
			arg_304_0:getBattleCardsByAtk("G", 2100),
			arg_304_0:getBattleCardsByHp("G", 2100)
		}), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2134 then
		return true, B.filterInCategoryCards(arg_304_0:getBattleCardsByStarGroup("HG", {
			7,
			8
		}), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2135 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner), false, false)), 1
	elseif arg_304_1._id == 2137 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCards("G", Data.CARD_MAX_LEVEL, arg_304_1._owner),
			var_304_0:getBattleCards("G")
		})), 1
	elseif arg_304_1._id == 2139 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoId("PG", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 2141 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[2])),
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByCategory("B", var_304_1._refCards[2]))
		}), 2
	elseif arg_304_1._id == 2142 then
		local var_304_216 = B.filterNotActionedCards(B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)),
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]))
		}))

		return true, var_304_216, #var_304_216
	elseif arg_304_1._id == 2143 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoId("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2144 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoId("HB", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2152 or arg_304_1._id == 9811 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoId("PHG", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 2155 then
		return true, arg_304_0:getBattleCardsBy2155(), 1
	elseif arg_304_1._id == 2156 then
		return true, B.sortCardsByBoardPos(B.filterDifAtkMaxAtkCards(var_304_0:getBoardCards())), 1
	elseif arg_304_1._id == 2160 then
		local var_304_217 = B.filterInTypeCards(B.filterFirstCards(var_304_0:getBattleCards("P"), 3), Data.CardType.monster)

		if #var_304_217 > 0 then
			local var_304_218 = var_304_0:getBattleCards("BCSD")

			if #var_304_218 > 0 then
				return true, var_304_218, math.min(#var_304_217, #var_304_218)
			end
		end
	elseif arg_304_1._id == 2163 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[1]), false)), 1
	elseif arg_304_1._id == 2164 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInNatureCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_1._owner._info._nature)), 1
	elseif arg_304_1._id == 2168 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterCeremonyMagicCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 2169 then
		local var_304_219 = arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)

		if #var_304_219 > 0 then
			return true, B.sortCardsByBoardPos(var_304_219), 1
		end
	elseif arg_304_1._id == 2170 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterCeremonyMonsterCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 2173 or arg_304_1._id == 2174 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByType("P", var_304_2)), 1
	elseif arg_304_1._id == 2177 or arg_304_1._id == 2179 or arg_304_1._id == 2181 or arg_304_1._id == 2183 then
		local var_304_220 = B.sortCardsByBoardPos(B.filterNotBindedAllyEquipCards(arg_304_0:getBattleCardsByCategoryAndNature("B", var_304_1._refCards[2], var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)))

		if arg_304_1._id == 2183 then
			var_304_220 = B.filterMergeCards(var_304_220)
		end

		return true, var_304_220, 1
	elseif arg_304_1._id == 2178 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterAllyMonsterCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner))), 1
	elseif arg_304_1._id == 2180 or arg_304_1._id == 4889 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterAllyMonsterCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster))), 1
	elseif arg_304_1._id == 2182 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAllyMonsterCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster))), 1
	elseif arg_304_1._id == 2187 or arg_304_1._id == 2189 or arg_304_1._id == 7429 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("HBCSD", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2194 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByMinAtk("B", arg_304_1._owner._atk)), 1
	elseif arg_304_1._id == 2205 or arg_304_1._id == 4557 or arg_304_1._id == 7617 then
		return true, arg_304_0:filterCanChangeToBoardCards(var_304_0:getBattleCardsByType("G", Data.CardType.monster)), 1
	elseif arg_304_1._id == 2208 or arg_304_1._id == 5621 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoId("P", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 2215 then
		local var_304_221 = {}
		local var_304_222 = arg_304_0:filterCanChangeToHandCards(B.filterAdjustCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), true))

		for iter_304_11 = 1, #var_304_222 do
			local var_304_223 = arg_304_0:filterCanChangeToHandCards(B.filterAdjustCards(arg_304_0:getBattleCardsByCategoryAndNature("G", var_304_222[iter_304_11]._info._category, var_304_222[iter_304_11]._info._nature), false))

			if #var_304_223 > 0 then
				var_304_221[#var_304_221 + 1] = var_304_222[iter_304_11]

				B.appendTable(var_304_221, var_304_223)
			end
		end

		return true, var_304_221, 2
	elseif arg_304_1._id == 2217 then
		return true, B.sortCardsByBoardPos(B.filterSummonByNormalCards(var_304_0:getBoardCards(), false)), 1
	elseif arg_304_1._id == 2229 then
		return true, B.sortCardsByBoardPos(B.filterDualCards(arg_304_0:getBattleCardsByType("BH", Data.CardType.monster))), 2
	elseif arg_304_1._id == 2241 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_304_0:getBattleCardsByCategoryAndNature("R", var_304_1._refCards[2], var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 2242 then
		return true, arg_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2244 then
		return true, arg_304_0:getBattleCardsByInfoIdGroup("B", arg_304_1._owner._info._joinComponent), 2
	elseif arg_304_1._id == 2249 then
		return true, var_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2267 or arg_304_1._id == 4768 or arg_304_1._id == 13016 or arg_304_1._id == 13102 or arg_304_1._id == 13730 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("L", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2268 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNormalMagicCards(arg_304_0:getBattleCardsByType("G", Data.CardType.magic))), 1
	elseif arg_304_1._id == 2270 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCards("L", Data.CardType.monster), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 2272 or arg_304_1._id == 2274 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByStar("H", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2273 or arg_304_1._id == 2275 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("P", var_304_2), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2276 or arg_304_1._id == 2932 then
		return true, B.sortCardsByBoardPos(var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("BSD"))), 1
	elseif arg_304_1._id == 2283 then
		return true, B.sortCardsByBoardPos(B.filterNotInNatureCards(var_304_0:getBoardCards(), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2300 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("B", 11), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2301 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("B", 2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2310 then
		return true, B.sortCardsByBoardPos(var_304_0:getBoardCards()), 2
	elseif arg_304_1._id == 2328 or arg_304_1._id == 2336 or arg_304_1._id == 2355 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterCeremonyMonsterCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[2]), var_304_1._refCards[1])))), 1
	elseif arg_304_1._id == 2329 or arg_304_1._id == 2915 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2343 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(B.filterFromStatusCards(var_304_0:getBoardCards(), BattleData.CardStatus.rare), BattleData.PositiveType.shieldMonster)), 1
	elseif arg_304_1._id == 2352 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByType("HB", Data.CardType.monster))), 2
	elseif arg_304_1._id == 2354 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(B.filterFromStatusCards(arg_304_0:getBoardCards(), BattleData.CardStatus.rare)),
			B.sortCardsByBoardPos(B.filterFromStatusCards(var_304_0:getBoardCards(), BattleData.CardStatus.rare))
		}), 2
	elseif arg_304_1._id == 2356 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("L", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 2358 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(B.filterDefPostureCards(arg_304_0:getBoardCards(), false)),
			B.sortCardsByBoardPos(B.filterDefPostureCards(var_304_0:getBoardCards(), false))
		}), 1
	elseif arg_304_1._id == 2361 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(B.filterXYZCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner), true), var_304_1._refCards[#var_304_1._refCards])), 1
	elseif arg_304_1._id == 2373 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterMergeCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1])), true, true), 1
	elseif arg_304_1._id == 2380 then
		return true, B.filterNoShieldCards(B.filterFromStatusCards(B.filterSummonByNormalCards(var_304_0:getBoardCards(), false), BattleData.CardStatus.rare), BattleData.PositiveType.shieldMonster), 1
	elseif arg_304_1._id == 2385 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("PH", var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByInfoId("PH", var_304_1._refCards[2])
		}))), 1
	elseif arg_304_1._id == 2386 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByInfoId("G", var_304_1._refCards[2])
		}))), 1
	elseif arg_304_1._id == 2387 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterLessThanStarCards(arg_304_0:getBattleCardsByKeywordGroup("H", var_304_1._refCards), var_304_2)), 1
	elseif arg_304_1._id == 2388 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeywordGroup("G", var_304_1._refCards), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2396 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("GH", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2410 or arg_304_1._id == 13320 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 2413 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInStatusCards(arg_304_0._mark2413, BattleData.CardStatus.grave)), 1
	elseif arg_304_1._id == 2415 then
		return true, arg_304_0:getBattleCardsBy2415("B"), 1
	elseif arg_304_1._id == 2417 then
		return true, B.mergeTable({
			arg_304_0:getBattleCards("H"),
			{
				arg_304_0:filterCanChangeToHandCards(arg_304_0._pileCards)[1]
			}
		}), 1
	elseif arg_304_1._id == 2422 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("L", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 2423 or arg_304_1._id == 2716 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("GH", var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 2429 then
		return true, arg_304_0:getBattleCardsBy2429(arg_304_1._owner), 1
	elseif arg_304_1._id == 2430 or arg_304_1._id == 7534 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 2431 or arg_304_1._id == 13734 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("L", var_304_1._refCards[1]), arg_304_1._owner)), #arg_304_0:getBattleCardsByInfoId("SD", var_304_1._refCards[2]) > 0 and 2 or 1
	elseif arg_304_1._id == 2434 or arg_304_1._id == 4827 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBoardCards())), 1
	elseif arg_304_1._id == 2440 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByType("GB", Data.CardType.monster)), 1
	elseif arg_304_1._id == 2441 then
		return true, B.filterSyncCards(arg_304_0:getBattleCardsByCategory("GL", var_304_1._refCards[1]), true), 1
	elseif arg_304_1._id == 2444 then
		return true, B.filterInCategoryCards(arg_304_0:getBattleCardsByHp("L", 0), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2456 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(var_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]))),
			B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])))
		}), 1
	elseif arg_304_1._id == 2459 then
		return true, B.mergeTable({
			var_304_0:getBattleCards("G"),
			arg_304_0:getBattleCards("G")
		}), 1
	elseif arg_304_1._id == 2464 or arg_304_1._id == 13426 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 2479 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByType("BG", Data.CardType.monster)),
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByType("BG", Data.CardType.monster))
		}), 1
	elseif arg_304_1._id == 2482 then
		return true, arg_304_0:getBattleCardsBy2482(), 1
	elseif arg_304_1._id == 2486 or arg_304_1._id == 2487 then
		return true, arg_304_1._owner:getBindedEquipsByType(Data.CardType.magic), 1
	elseif arg_304_1._id == 2490 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByType(arg_304_0:getEmptyBoardPos() and "BH" or "B", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2495 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			var_304_0:getBoardCards(),
			{
				arg_304_1._owner._owner ~= arg_304_1._owner._mark2495._owner and arg_304_1._owner._mark2495._status == BattleData.CardStatus.grave and arg_304_1._owner._mark2495
			}
		}))), 1
	elseif arg_304_1._id == 2504 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeywordGroup("GH", var_304_1._refCards)), 1
	elseif arg_304_1._id == 2505 then
		return true, B.sortCardsByBoardPos(B.filterXYZStarBetweenCards(B.filterXYZCards(B.filterInNatureCards(arg_304_0:getBattleCardsByMinBuffValue("B", true, BattleData.PositiveType.xyzMark, var_304_2), var_304_1._refCards[1]), true), 8, 10)), 1
	elseif arg_304_1._id == 2513 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[#var_304_1._refCards])), 1
	elseif arg_304_1._id == 2514 then
		return true, B.sortCardsByBoardPos(B.filterXYZStarCards(B.filterXYZCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]), true), var_304_2)), 1
	elseif arg_304_1._id == 2515 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCardsByCategory("PH", var_304_1._refCards[1])))), 1
	elseif arg_304_1._id == 2517 or arg_304_1._id == 13869 then
		return true, arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2519 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("BH", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 2520 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2528 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("PGH", var_304_2), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 2533 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[2], Data.CARD_MAX_LEVEL, arg_304_0:getBattleCardsByInfoId("G", var_304_1._refCards[1])[1])), 1
	elseif arg_304_1._id == 2535 or arg_304_1._id == 4091 or arg_304_1._id == 13158 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByStar("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 2544 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), true), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2562 or arg_304_1._id == 9785 or arg_304_1._id == 9959 or arg_304_1._id == 13300 or arg_304_1._id == 13690 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2563 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoId("P", var_304_1._refCards[2]))), 1
	elseif arg_304_1._id == 2568 or arg_304_1._id == 2661 or arg_304_1._id == 2663 or arg_304_1._id == 9214 or arg_304_1._id == 9771 or arg_304_1._id == 13572 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("G", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2570 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), false)), 1
	elseif arg_304_1._id == 2577 or arg_304_1._id == 7467 then
		return true, arg_304_0:getBattleCardsByKeyword("L", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2582 then
		return true, B.mergeTable({
			arg_304_0:getBattleCards("H"),
			B.filterFirstCards(arg_304_0:filterCanChangeToHandCards(arg_304_0._pileCards), 2)
		}), 1
	elseif arg_304_1._id == 2584 or arg_304_1._id == 9224 or arg_304_1._id == 13428 or arg_304_1._id == 13442 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByNature("G", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2599 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[2]), 1
	elseif arg_304_1._id == 2606 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxAtk("B", var_304_2 - 1), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2607 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]), var_304_1._refCards[2]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 2614 then
		return true, B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("L", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner), 1
	elseif arg_304_1._id == 2615 then
		return true, arg_304_0:getBattleCardsBy2615(), 1
	elseif arg_304_1._id == 2620 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterAdjustCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 2625 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCardsByHp("G", 2400),
			arg_304_0:getBattleCardsByHp("G", 2800)
		})), 1
	elseif arg_304_1._id == 2627 then
		return true, B.sortCardsByBoardPos(B.filterSyncCards(arg_304_0:getBoardCards(), true)), 1
	elseif arg_304_1._id == 2632 or arg_304_1._id == 9299 or arg_304_1._id == 9476 or arg_304_1._id == 9638 or arg_304_1._id == 9965 then
		return true, arg_304_0:getBattleCardsByNature("H", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 2638 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotActionedCards(arg_304_0:getBattleCardsByMinAtk("B", var_304_2)))), 2
	elseif arg_304_1._id == 2643 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBattleCardsByKeywordGroup("B", {
			var_304_1._refCards[1],
			var_304_1._refCards[2]
		}, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[#var_304_1._refCards])), 1
	elseif arg_304_1._id == 2653 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 2659 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), true), var_304_2)), 1
	elseif arg_304_1._id == 2660 then
		return true, arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), 2
	elseif arg_304_1._id == 2667 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInTypeCards(arg_304_0:getBattleCardsByKeywordGroup("P", var_304_1._refCards), Data.CardType.monster), arg_304_1._owner))), 1
	elseif arg_304_1._id == 2673 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[2]), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 2676 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), true), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2700 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("LG", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 2709 or arg_304_1._id == 9941 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByType("BG", Data.CardType.monster)), 1
	elseif arg_304_1._id == 2710 then
		return true, B.mergeTable({
			arg_304_0:getBattleCardsByType("G", Data.CardType.monster),
			var_304_0:getBattleCardsByType("G", Data.CardType.monster)
		}), 1
	elseif arg_304_1._id == 2720 or arg_304_1._id == 2760 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 2723 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByStar("H", var_304_2, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2724 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(B.filterInStarCards(arg_304_0:getBattleCardsByNatureGroup("G", {
			var_304_1._refCards[1],
			var_304_1._refCards[2]
		}), var_304_2), var_304_1._refCards[3])), 1
	elseif arg_304_1._id == 2730 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByKeyword("GR", var_304_1._refCards[1]), var_304_1._refCards[2]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2733 or arg_304_1._id == 9812 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBattleCards("BSD"), BattleData.PositiveType.shieldMonster)), 1
	elseif arg_304_1._id == 2739 or arg_304_1._id == 9121 or arg_304_1._id == 9960 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.xyzMark)), 1
	elseif arg_304_1._id == 2744 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")),
			B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSDG"))
		}), 1
	elseif arg_304_1._id == 2745 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBoardCards()), 3
	elseif arg_304_1._id == 2749 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(B.filterMoreThanStarCards(arg_304_0:getBattleCardsByCategoryAndNature("G", var_304_1._refCards[3], var_304_1._refCards[2]), 6), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2750 then
		return true, arg_304_0:getBattleCardsBy2750(arg_304_1._owner), 1
	elseif arg_304_1._id == 2751 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByMinStar("B", 0, Data.CARD_MAX_LEVEL, arg_304_1._owner)),
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByMinStar("B", 0))
		}), 1
	elseif arg_304_1._id == 2752 then
		return true, B.mergeTable({
			arg_304_0:getBattleCards("H"),
			arg_304_0:getBattleCardsByType("G", Data.CardType.monster)
		}), 1
	elseif arg_304_1._id == 2754 then
		return true, B.filterSpiritCards(arg_304_0:getBattleCards("H")), 1
	elseif arg_304_1._id == 2756 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(var_304_0:getBoardCards(), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2762 then
		return true, B.sortCardsByBoardPos(B.filterOppoCards(var_304_0:getBoardCards())), 1
	elseif arg_304_1._id == 2764 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCardsByMaxStar("L", var_304_2), false)), 1
	elseif arg_304_1._id == 2772 or arg_304_1._id == 2774 or arg_304_1._id == 2789 or arg_304_1._id == 2806 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterTokenCards(arg_304_0:getBoardCards(), true))), 1
	elseif arg_304_1._id == 2776 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterTokenCards(arg_304_0:getBoardCards(), true))), 2
	elseif arg_304_1._id == 2777 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]))), 2
	elseif arg_304_1._id == 2780 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))), 1
	elseif arg_304_1._id == 2785 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy2785()), 1
	elseif arg_304_1._id == 2787 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy2787()), 1
	elseif arg_304_1._id == 2790 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategoryAndNature("B", var_304_1._refCards[2], var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 2793 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterCeremonyMonsterCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1])), arg_304_1._owner), true, true), 1
	elseif arg_304_1._id == 2796 then
		return true, B.mergeTable({
			arg_304_0:getBattleCards("H"),
			B.sortCardsByBoardPos(B.filterNotActionedCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1])))
		}), 2
	elseif arg_304_1._id == 2798 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByStar("G", var_304_2)), 1
	elseif arg_304_1._id == 2807 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[1]))), 2
	elseif arg_304_1._id == 2809 or arg_304_1._id == 9046 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInTypeCards(arg_304_0:getBattleCardsByMaxQuality("P", 4), Data.CardType.magic))), 1
	elseif arg_304_1._id == 2811 or arg_304_1._id == 7454 or arg_304_1._id == 13432 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 2819 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.magic), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2822 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			B.filterNormalCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1])),
			B.filterNormalCards(var_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]))
		})), 1
	elseif arg_304_1._id == 2823 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInStarCards(arg_304_0:getBattleCardsByCategoryAndNature("G", var_304_1._refCards[2], var_304_1._refCards[1]), var_304_2)), 1
	elseif arg_304_1._id == 2838 then
		return true, arg_304_0:getBattleCardsBy2838(), 1
	elseif arg_304_1._id == 2839 or arg_304_1._id == 2840 or arg_304_1._id == 2843 or arg_304_1._id == 2844 or arg_304_1._id == 2845 or arg_304_1._id == 2846 or arg_304_1._id == 2907 or arg_304_1._id == 2908 or arg_304_1._id == 2909 or arg_304_1._id == 2910 or arg_304_1._id == 9709 or arg_304_1._id == 13192 or arg_304_1._id == 13197 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), arg_304_1._owner:getAlterMagicInfoId())), 1
	elseif arg_304_1._id == 2841 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("G", Data.CardType.magic))), 1
	elseif arg_304_1._id == 2847 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic)))), 1
	elseif arg_304_1._id == 2853 then
		return true, B.filterCanBindAlterMagicCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner), 1
	elseif arg_304_1._id == 2856 then
		return true, B.filterCanBindMagicCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("G", Data.CardType.magic)), arg_304_1._owner), 1
	elseif arg_304_1._id == 2858 then
		return true, B.sortCardsByBoardPos(B.filterCanBindMagicCards(B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic)), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2867 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(B.filterEquipMagicCards(arg_304_0:getBattleCardsByKeyword("S", var_304_1._refCards[1]))),
			B.sortCardsByBoardPos(B.filterEquipMagicCards(var_304_0:getBattleCardsByKeyword("S", var_304_1._refCards[1])))
		}), 1
	elseif arg_304_1._id == 2872 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 2878 then
		local var_304_224 = var_304_0:getBattleCards(#arg_304_0:getBattleCardsByInfoId("S", var_304_1._refCards[1]) > 0 and "BCSD" or "CSD")

		return true, B.sortCardsByBoardPos(var_304_224), math.min(2, #var_304_224)
	elseif arg_304_1._id == 2879 then
		local var_304_225 = var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("BCSD"))

		return true, B.sortCardsByBoardPos(var_304_225), math.min(3, #var_304_225)
	elseif arg_304_1._id == 2880 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterSpiritCards(arg_304_0:getBattleCardsByMaxStar("PH", var_304_2)), true, true)), 1
	elseif arg_304_1._id == 2887 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterCeremonyMagicCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic)),
			arg_304_0:getBattleCardsByInfoId("P", var_304_1._refCards[2])
		}))), 1
	elseif arg_304_1._id == 2888 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStar("P", var_304_2), var_304_1._refCards[2]))), 1
	elseif arg_304_1._id == 2902 then
		return true, B.sortCardsByBoardPos(B.filterNoBuffCards(B.filterXYZCards(B.filterXYZStarCards(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1]), var_304_2), true), true, BattleData.PositiveType.xyzMark)), 1
	elseif arg_304_1._id == 2906 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("GL", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2916 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[2]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2917 or arg_304_1._id == 9025 or arg_304_1._id == 9561 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("PH", var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 2925 or arg_304_1._id == 13277 or arg_304_1._id == 13342 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("GL", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 2927 or arg_304_1._id == 2928 or arg_304_1._id == 9029 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStar("P", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2929 then
		local var_304_226 = B.mergeTable({
			var_304_0:getBattleCards("CSD"),
			arg_304_0:getBattleCards("CSD"),
			arg_304_0:getBattleCardsByTypeGroup("H", {
				Data.CardType.magic,
				Data.CardType.trap
			})
		})

		return true, var_304_226, math.min(#var_304_226, 2)
	elseif arg_304_1._id == 2930 then
		return true, arg_304_0:getBattleCardsByInfoId("SD", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2942 then
		return true, B.filterInKeywordGroupCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards), 1
	elseif arg_304_1._id == 2946 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			var_304_0:getBattleCardsByType("L", Data.CardType.monster),
			arg_304_0:getBattleCardsByType("L", Data.CardType.monster)
		})), 1
	elseif arg_304_1._id == 2953 or arg_304_1._id == 9485 or arg_304_1._id == 9486 then
		return true, B.filterAdjustCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), true), 1
	elseif arg_304_1._id == 2954 then
		return true, B.sortCardsByBoardPos(B.filterInNatureCards(arg_304_0:getBattleCardsByStar("HB", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2964 then
		return true, B.sortCardsByBoardPos(B.filterSyncCards(arg_304_0:getBattleCardsByCategoryAndNature("B", var_304_1._refCards[1], var_304_1._refCards[2]), true)), 1
	elseif arg_304_1._id == 2966 then
		local var_304_227 = arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("PH", var_304_1._refCards[3]), arg_304_1._owner))

		return true, B.sortCardsByBoardPos(var_304_227), math.min(#var_304_227, 2)
	elseif arg_304_1._id == 2969 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoId("PH", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2970 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 2972 or arg_304_1._id == 13085 or arg_304_1._id == 13086 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(arg_304_0:getBattleCardsByKeywordGroup("B", var_304_1._refCards), true)), 1
	elseif arg_304_1._id == 2973 or arg_304_1._id == 2974 then
		return true, arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 2978 then
		return true, B.sortCardsByBoardPos(B.filterNotInGroundCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 2986 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("L", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 2998 or arg_304_1._id == 9222 then
		return true, B.sortCardsByBoardPos(B.filterXYZStarCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), true), var_304_2)), 1
	elseif arg_304_1._id == 9001 or arg_304_1._id == 9018 then
		return true, B.sortCardsByBoardPos(B.filterSyncCards(arg_304_0:getBattleCardsByType("BG", Data.CardType.monster), true)), 1
	elseif arg_304_1._id == 9009 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeywordGroup("BCSD", var_304_1._refCards))), 1
	elseif arg_304_1._id == 9010 or arg_304_1._id == 9204 or arg_304_1._id == 9207 or arg_304_1._id == 9213 or arg_304_1._id == 9218 or arg_304_1._id == 9230 or arg_304_1._id == 13373 then
		return true, arg_304_0:getBattleCardsByKeyword("CSD", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 9017 or arg_304_1._id == 13073 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeywordGroup("P", var_304_1._refCards)), 1
	elseif arg_304_1._id == 9019 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBoardCards())), 2
	elseif arg_304_1._id == 9022 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInTypeCards(arg_304_0:getBattleCardsByMaxQuality("L", 4), Data.CardType.monster), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9024 then
		return true, arg_304_0:getBattleCards("R"), 1
	elseif arg_304_1._id == 9026 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByInfoIdGroup("P", {
			var_304_1._refCards[3],
			var_304_1._refCards[4]
		}))), 1
	elseif arg_304_1._id == 9028 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("GH", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9039 or arg_304_1._id == 9619 then
		return true, B.sortCardsByBoardPos(var_304_0:filterCanChangeToHandCards(B.filterSummonByNormalCards(var_304_0:getBoardCards(), false))), 1
	elseif arg_304_1._id == 9044 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]),
			B.filterSyncCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[2]), true)
		})), 1
	elseif arg_304_1._id == 9049 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), false))), 1
	elseif arg_304_1._id == 9051 or arg_304_1._id == 9052 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy9051(arg_304_1._id)), 1
	elseif arg_304_1._id == 9055 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoIdGroup("BCSD", var_304_1._refCards, Data.CARD_MAX_LEVEL, arg_304_1._owner)),
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByInfoIdGroup("BCSD", var_304_1._refCards))
		}), 1
	elseif arg_304_1._id == 9056 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("BG", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 9057 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[2]), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9060 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNatureCardsMulti(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]), arg_304_0:getBoardCards()))), 1
	elseif arg_304_1._id == 9067 or arg_304_1._id == 5400 or arg_304_1._id == 7555 then
		local var_304_228 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1]))

		return true, var_304_228, math.min(math.min(2, #var_304_228), arg_304_0:getEmptyBoardPosCount())
	elseif arg_304_1._id == 9071 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("BCSD", var_304_1._refCards[1])), 3
	elseif arg_304_1._id == 9072 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy9072()), 1
	elseif arg_304_1._id == 9075 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 9076 then
		return true, B.mergeTable({
			arg_304_0:getBattleCards("H"),
			{
				arg_304_0:filterCanChangeToHandCards(arg_304_0._pileCards)[1]
			}
		}), 1
	elseif arg_304_1._id == 9080 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByNature("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))), 1
	elseif arg_304_1._id == 9089 then
		return true, B.filterXYZCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("GL", Data.CardType.monster), var_304_1._refCards[1]), false), 1
	elseif arg_304_1._id == 9094 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.xyzMark), BattleData.PositiveType.shieldMonster)),
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.xyzMark))
		}), 1
	elseif arg_304_1._id == 9096 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryAndNature("G", var_304_1._refCards[2], var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 9099 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterUniqueIdCards(B.mergeTable({
			B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic)),
			arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1])
		})))), 1
	elseif arg_304_1._id == 9105 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInTypeCards(var_304_0:getBattleCardsByMaxQuality("H", 4), Data.CardType.magic)), 1
	elseif arg_304_1._id == 9106 or arg_304_1._id == 9110 then
		return true, B.sortCardsByBoardPos(B.filterXYZStarCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), true), var_304_2)), 1
	elseif arg_304_1._id == 9112 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), true), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9113 or arg_304_1._id == 13727 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 9124 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSDH", Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 9127 then
		return true, B.filterCanBeSacrificedCards(B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBoardCards()),
			B.sortCardsByBoardPos(arg_304_0:getBoardCards())
		})), 1
	elseif arg_304_1._id == 9130 or arg_304_1._id == 9131 or arg_304_1._id == 9850 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_304_0:getBattleCardsByStar("B", var_304_2))), 1
	elseif arg_304_1._id == 9142 then
		local var_304_229 = B.filterCanSummonAlterMonsterCards(arg_304_0:getBattleCardsByKeyword("CSD", var_304_1._refCards[1]))

		return true, var_304_229, math.min(#var_304_229, arg_304_0:getEmptyBoardPosCount())
	elseif arg_304_1._id == 9146 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("BCSD", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9148 then
		return true, B.sortCardsByBoardPos(B.filterHasAlterMagicCards(arg_304_0:getBattleCardsByKeyword("HPG", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9164 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 9165 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("BCSD", var_304_1._refCards[1])), var_304_2
	elseif arg_304_1._id == 9168 then
		return true, B.filterAdjustCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), true), 1
	elseif arg_304_1._id == 9170 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotActionedCards(B.filterSyncCards(arg_304_0:getBoardCards(), true)))), var_304_2
	elseif arg_304_1._id == 9178 then
		return true, B.sortCardsByBoardPos(B.filterSyncCards(arg_304_0:getBattleCardsByCategoryAndNature("B", var_304_1._refCards[2], var_304_1._refCards[1]), true)), 2
	elseif arg_304_1._id == 9182 then
		return true, var_304_0:getBattleCardsByType("CS", Data.CardType.trap), 1
	elseif arg_304_1._id == 9183 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInNatureGroupCards(arg_304_0:getBattleCardsByStar("PH", var_304_2), var_304_1._refCards))), 1
	elseif arg_304_1._id == 9184 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_304_0:getBattleCardsByStar("B", var_304_2, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9187 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(B.filterNoShieldCards(B.filterDefPostureCards(arg_304_0:getBoardCards(), false), BattleData.PositiveType.shieldMonster)),
			B.sortCardsByBoardPos(B.filterNoShieldCards(B.filterDefPostureCards(var_304_0:getBoardCards(), false), BattleData.PositiveType.shieldMonster))
		}), 2
	elseif arg_304_1._id == 9188 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByCategory("HB", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))), 1
	elseif arg_304_1._id == 9189 or arg_304_1._id == 9190 then
		return true, B.filterCanBeSacrificedCards(arg_304_0:getBattleCardsByCategory("HB", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9193 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("HBCSD", var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 9197 or arg_304_1._id == 9208 or arg_304_1._id == 13724 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.trap), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9198 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("CSDP", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9200 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]), arg_304_1._owner._infoId))), 1
	elseif arg_304_1._id == 9206 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeyword("BCSDH", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 2
	elseif arg_304_1._id == 9212 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInNatureCards(arg_304_0:getBattleCardsByStar("G", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9219 or arg_304_1._id == 9770 or arg_304_1._id == 5488 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCards("BCSD")), 2
	elseif arg_304_1._id == 9227 then
		return true, arg_304_0:getBattleCardsByKeyword("CSD", var_304_1._refCards[1]), 3
	elseif arg_304_1._id == 9228 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]))), 2
	elseif arg_304_1._id == 9234 then
		return true, var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("SD")), 1
	elseif arg_304_1._id == 9239 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryGroup("G", var_304_1._refCards)), 1
	elseif arg_304_1._id == 9240 then
		return true, arg_304_0:getBattleCardsByNature("G", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 9252 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryGroup("HG", var_304_1._refCards)), 1
	elseif arg_304_1._id == 9255 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterDualCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster)))), 1
	elseif arg_304_1._id == 9256 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterDualCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2))), 1
	elseif arg_304_1._id == 9258 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy9258()), 1
	elseif arg_304_1._id == 9260 then
		return true, B.filterDualCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster)), 1
	elseif arg_304_1._id == 9277 or arg_304_1._id == 13289 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 9289 then
		local var_304_230 = B.mergeTable({
			B.filterLinkPosCards(B.filterLinkCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), true), true),
			B.filterLinkPosCards(B.filterLinkCards(var_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), true), true)
		})
		local var_304_231 = var_304_0:getBattleCards("CSD")

		return true, var_304_231, math.min(#var_304_230, #var_304_231)
	elseif arg_304_1._id == 9296 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 9297 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 9300 then
		return true, B.filterInNatureCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 9302 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInNatureCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9304 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInNatureCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9305 or arg_304_1._id == 9306 then
		return true, var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("L")), 1
	elseif arg_304_1._id == 9308 then
		return true, B.mergeTable({
			arg_304_0:getBattleCardsByMaxQuality("GL", var_304_1._refCards[1]),
			var_304_0:getBattleCardsByMaxQuality("GL", var_304_1._refCards[1])
		}), 1
	elseif arg_304_1._id == 9310 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByType("P", Data.CardType.magic)), 1
	elseif arg_304_1._id == 9314 then
		return true, arg_304_0:getBattleCardsByType("HSD", Data.CardType.magic), 1
	elseif arg_304_1._id == 9316 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByStar("H", var_304_2)), 1
	elseif arg_304_1._id == 9317 then
		return true, B.mergeTable({
			B.filterHasStarCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner)),
			B.filterHasStarCards(var_304_0:getBoardCards())
		}), 1
	elseif arg_304_1._id == 9318 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("H", arg_304_1._owner:getStar() - 1), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9321 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByKeywordGroup("BCSD", var_304_1._refCards, Data.CARD_MAX_LEVEL, arg_304_1._owner)), 1
	elseif arg_304_1._id == 9323 or arg_304_1._id == 9766 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_304_0:getBoardCards())), var_304_2
	elseif arg_304_1._id == 9330 then
		local var_304_232 = B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster), var_304_1._refCards[1])

		return true, var_304_232, #var_304_232
	elseif arg_304_1._id == 9331 then
		return true, B.filterCanBeSacrificedCards(B.filterNotSameNameCards(B.filterNotActionedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1])), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9338 then
		return true, B.filterCanBeSacrificedCards(B.filterNotSameNameCards(B.filterNotActionedCards(B.filterInStarCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), arg_304_1._owner:getStar())), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9343 then
		local var_304_233 = B.filterFirstCards(var_304_0._pileCards, 3)

		return true, var_304_233, #var_304_233
	elseif arg_304_1._id == 9374 then
		return true, var_304_0:getBattleCardsByTypeGroup("G", {
			Data.CardType.magic,
			Data.CardType.trap
		}), 1
	elseif arg_304_1._id == 9375 then
		return true, arg_304_0:getBattleCardsBy9375(), 1
	elseif arg_304_1._id == 9378 or arg_304_1._id == 9392 then
		return true, arg_304_0:getBattleCardsBy9378(arg_304_1._id), 1
	elseif arg_304_1._id == 9379 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("PH", var_304_1._refCards[1]), arg_304_1._owner), nil, nil, nil, true)), 1
	elseif arg_304_1._id == 9382 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))), 1
	elseif arg_304_1._id == 9386 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinAtk("B", B.getMinAtkCard(var_304_0:getBoardCards())._atk), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9390 or arg_304_1._id == 9641 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategoryAndNature("P", var_304_1._refCards[2], var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9401 then
		return true, B.sortCardsByBoardPos(B.filterMergeCards(arg_304_0:getBoardCards())), 1
	elseif arg_304_1._id == 9404 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterDualCards(arg_304_0._handCards)), 1
	elseif arg_304_1._id == 9409 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByType("BH", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner)), 2
	elseif arg_304_1._id == 9415 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(B.filterUniqueIdCards(B.mergeTable({
			arg_304_0:getBattleCardsByCategoryAndNature("G", var_304_1._refCards[3], var_304_1._refCards[2]),
			B.filterDualCards(arg_304_0:getBattleCards("G"))
		})), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9416 then
		return true, B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("SDG", Data.CardType.magic)), 1
	elseif arg_304_1._id == 9419 then
		return true, B.filterUniqueIdCards(B.mergeTable({
			arg_304_0:getBattleCardsByCategoryAndNature("GL", var_304_1._refCards[2], var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner),
			arg_304_0:getBattleCardsByKeyword("GL", var_304_1._refCards[3])
		})), 2
	elseif arg_304_1._id == 9423 or arg_304_1._id == 9425 or arg_304_1._id == 9455 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]), arg_304_1._owner:getAlterMagicInfoId())), 1
	elseif arg_304_1._id == 9424 then
		return true, B.sortCardsByBoardPos(arg_304_0:getEmptyBoardPos() ~= nil and B.mergeTable({
			arg_304_0:getBattleCardsByCategoryAndNature("HB", var_304_1._refCards[2], var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner),
			B.filterEquipMagicCards(arg_304_0:getBattleCards("HS"))
		}) or arg_304_0:getBattleCardsByCategoryAndNature("B", var_304_1._refCards[2], var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9434 or arg_304_1._id == 13764 then
		return true, arg_304_0._graveCards, 1
	elseif arg_304_1._id == 9437 then
		return true, arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterNotSameNameCards(arg_304_0:getBattleCardsByCategoryAndNature("GL", var_304_1._refCards[2], var_304_1._refCards[1]), arg_304_1._owner),
			B.filterEquipMagicCards(arg_304_0:getBattleCards("GL"))
		})), 1
	elseif arg_304_1._id == 9442 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterHasSkillInModeCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), Data.SkillMode.initiative_grave))), 1
	elseif arg_304_1._id == 9448 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterDualCards(arg_304_0:getBattleCards("G"))), 1
	elseif arg_304_1._id == 9454 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[1]),
			B.filterEquipMagicCards(arg_304_0:getBattleCards("P"))
		})), 2
	elseif arg_304_1._id == 9458 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterOppoCards(var_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9464 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("H", B.getMaxStarCard(arg_304_0:getBattleCardsByMinStar("B", 0, Data.CARD_MAX_LEVEL, arg_304_1._owner)):getStar()), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9465 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster), var_304_1._refCards[1]), 2
	elseif arg_304_1._id == 9469 then
		return true, B.sortCardsByBoardPos(B.filterNotInStarCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner:getStar())), 1
	elseif arg_304_1._id == 9478 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCards("HG"), true)), 1
	elseif arg_304_1._id == 9480 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(B.filterNotEqualInfoIdCards(arg_304_0:getBattleCards("HBCSD"), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9481 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_304_0:getBattleCardsByInfoId("HB", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9489 then
		return true, var_304_0:getBattleCards("HC"), 1
	elseif arg_304_1._id == 9495 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy9495()), 1
	elseif arg_304_1._id == 9501 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterAdjustCards(B.filterNotEqualInfoIdCards(arg_304_0:getBattleCardsByType("HB", Data.CardType.monster), var_304_1._refCards[1]), true))), 2
	elseif arg_304_1._id == 9509 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoIdGroup("HP", var_304_1._refCards), true, true, nil, true)), 1
	elseif arg_304_1._id == 9513 or arg_304_1._id == 9515 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByInfoIdGroup("B", var_304_1._refCards)), 3
	elseif arg_304_1._id == 9518 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.xyzMark), BattleData.PositiveType.shieldMonster)), 1
	elseif arg_304_1._id == 9520 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("BH", Data.CardType.monster), var_304_1._refCards[1]))), 2
	elseif arg_304_1._id == 9530 or arg_304_1._id == 13580 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9533 then
		return true, B.filterNotSameNameCards(B.filterInNatureGroupCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards), arg_304_1._owner), 1
	elseif arg_304_1._id == 9534 then
		return true, var_304_0._graveCards, 1
	elseif arg_304_1._id == 9538 then
		return true, arg_304_0:getBattleCardsBy9538(arg_304_1._owner), 1
	elseif arg_304_1._id == 9541 or arg_304_1._id == 9542 or arg_304_1._id == 9543 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword(arg_304_1._id == 9541 and "H" or arg_304_1._id == 9542 and "G" or "P", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9552 then
		local var_304_234 = B.filterFirstCards(arg_304_0._pileCards, var_304_2)

		return true, var_304_234, 0
	elseif arg_304_1._id == 9564 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), nil, nil, nil, true)), 1
	elseif arg_304_1._id == 9566 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("BCSD", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner))), 1
	elseif arg_304_1._id == 9578 then
		local var_304_235 = B.mergeTable({
			arg_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1]),
			arg_304_0._opponent:getBattleCardsByMaxQuality("G", var_304_1._refCards[1])
		})

		return true, var_304_235, math.min(var_304_2, #var_304_235)
	elseif arg_304_1._id == 9580 then
		local var_304_236 = arg_304_0:getBattleCardsByKeyword("GL", var_304_1._refCards[1])

		return true, var_304_236, math.min(var_304_2, #var_304_236)
	elseif arg_304_1._id == 9581 or arg_304_1._id == 7644 or arg_304_1._id == 7681 or arg_304_1._id == 13868 or arg_304_1._id == 13886 then
		local var_304_237 = var_304_0:getBattleCards("BCSD")

		return true, var_304_237, math.min(var_304_2, #var_304_237)
	elseif arg_304_1._id == 7646 then
		return true, arg_304_0:getBattleCardsBy7646(), 1
	elseif arg_304_1._id == 7648 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZStarCards(arg_304_0:getBattleCardsByCategoryAndNature("R", arg_304_2._info._category, arg_304_2._info._nature), arg_304_2._info._star), nil, nil, nil, true), 1
	elseif arg_304_1._id == 9583 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxXYZStar("B", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9587 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_304_0:getBattleCardsByMaxStar("HP", var_304_2)))), 1
	elseif arg_304_1._id == 9593 then
		return true, B.sortCardsByBoardPos(arg_304_1._owner:getLinkedCards()), 1
	elseif arg_304_1._id == 9600 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy9600(arg_304_1._owner)), 1
	elseif arg_304_1._id == 9639 then
		return true, B.filterUniqueIdCards(B.mergeTable({
			arg_304_0:getBattleCardsByCategory("HG", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner),
			arg_304_0:getBattleCardsByNature("HG", var_304_1._refCards[2], Data.CARD_MAX_LEVEL, arg_304_1._owner)
		})), 2
	elseif arg_304_1._id == 9642 then
		return true, B.filterInTypeGroupCards(arg_304_0:getBattleCardsByMaxQuality("G", var_304_1._refCards[1]), {
			Data.CardType.monster,
			Data.CardType.rare
		}), 2
	elseif arg_304_1._id == 9644 then
		return true, var_304_0:getBattleCardsByType("G", Data.CardType.monster), 2
	elseif arg_304_1._id == 9646 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("P", {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByInfoId("P", var_304_1._refCards[2])
		}))), 1
	elseif arg_304_1._id == 9647 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryGroup("H", var_304_1._refCards)), 1
	elseif arg_304_1._id == 9686 or arg_304_1._id == 9884 or arg_304_1._id == 13765 or arg_304_1._id == 13794 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("B", 0), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9690 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy9690()), 1
	elseif arg_304_1._id == 9692 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("HP", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), nil, nil, nil, true)), 1
	elseif arg_304_1._id == 9698 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.defendPosture), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9699 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterHasSameNameCardCards(var_304_0:getBoardCards()))), 2
	elseif arg_304_1._id == 9701 then
		local var_304_238 = var_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster), var_304_1._refCards[1]))

		return true, var_304_238, math.min(math.min(#var_304_238, 2), var_304_0:getEmptyBoardPosCount())
	elseif arg_304_1._id == 9712 or arg_304_1._id == 9872 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCards("BCSD")), 1
	elseif arg_304_1._id == 9716 then
		return true, B.mergeTable({
			var_304_0:getBattleCards("CSD"),
			arg_304_0:getBattleCards("CSD")
		}), 2
	elseif arg_304_1._id == 9717 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategoryGroup("GL", var_304_1._refCards)), 1
	elseif arg_304_1._id == 9724 or arg_304_1._id == 9725 then
		return true, arg_304_0:filterCanChangeToHandCards(var_304_0:getBattleCardsByTypeGroup("G", {
			Data.CardType.magic,
			Data.CardType.trap
		})), 1
	elseif arg_304_1._id == 9733 then
		return true, B.filterUniqueInfoIdCards(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9735 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("GPH", var_304_1._refCards[3]), arg_304_1._owner), true, true)), 1
	elseif arg_304_1._id == 9737 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoIdGroup("PH", var_304_1._refCards)), 1
	elseif arg_304_1._id == 9739 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryAndNature("PH", var_304_1._refCards[2], var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9749 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBoardCards(), arg_304_1._owner:getAlterMagicInfoId())), 1
	elseif arg_304_1._id == 9750 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterNotSameNameCards(arg_304_0:getBattleCardsByCategoryAndNature("P", var_304_1._refCards[2], var_304_1._refCards[1]), arg_304_1._owner),
			B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic))
		}))), 1
	elseif arg_304_1._id == 9757 then
		local var_304_239 = B.filterEquipMagicCards(arg_304_0:getBattleCardsByType("P", Data.CardType.magic))

		return true, B.sortCardsByBoardPos(var_304_239), math.min(2, #var_304_239)
	elseif arg_304_1._id == 9758 then
		local var_304_240 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]))

		return true, B.sortCardsByBoardPos(var_304_240), math.min(math.min(2, #var_304_240), arg_304_0:getEmptyBoardPosCount())
	elseif arg_304_1._id == 9763 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy9763()), 1
	elseif arg_304_1._id == 9764 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInStarCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByNatureGroup("G", {
			var_304_1._refCards[1],
			var_304_1._refCards[2]
		}), var_304_1._refCards[3]), var_304_2)), 1
	elseif arg_304_1._id == 9765 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedAllyEquipCards(arg_304_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_304_1._owner))), 1
	elseif arg_304_1._id == 9768 then
		local var_304_241 = B.filterCanBeSacrificedCards(B.filterNotActionedCards(arg_304_0:getBattleCardsByMinStar("B", 0)))

		return true, B.sortCardsByBoardPos(var_304_241), #var_304_241
	elseif arg_304_1._id == 9769 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("BG", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9773 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoIdGroup("G", var_304_1._refCards)), 1
	elseif arg_304_1._id == 9774 or arg_304_1._id == 9775 or arg_304_1._id == 9776 or arg_304_1._id == 9777 then
		return true, B.filterNotSameNameCards(arg_304_0:getBattleCardsByType("L", Data.CardType.monster), arg_304_1._owner), 1
	elseif arg_304_1._id == 9781 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("L", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9788 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("B", 0), var_304_1._refCards[1])),
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByMinStar("B", 0))
		}), 1
	elseif arg_304_1._id == 9793 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("GL", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9794 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_304_1._refCards[2]))), 1
	elseif arg_304_1._id == 9802 then
		return true, arg_304_0:getBattleCardsByMaxStar("H", var_304_2, Data.CARD_MAX_LEVEL, arg_304_1._owner), 1
	elseif arg_304_1._id == 9822 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByHp("HP", var_304_2), var_304_1._refCards[1]), arg_304_1._owner))), 1
	elseif arg_304_1._id == 9824 then
		return true, arg_304_0:getBattleCardsByCategory("PR", var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 9826 or arg_304_1._id == 13164 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("H", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9828 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("P", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9839 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[2]), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9843 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(B.filterXYZStarCards(B.filterXYZCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]), true), var_304_2))), 1
	elseif arg_304_1._id == 9848 or arg_304_1._id == 13199 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMinStarOrLevel("R", var_304_2), var_304_1._refCards[1]), true), nil, nil, nil, true), 1
	elseif arg_304_1._id == 9851 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByType("HB", Data.CardType.monster)), 1
	elseif arg_304_1._id == 9852 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByMaxQuality("HBCSD", var_304_1._refCards[1]), nil, nil, nil, true), 1
	elseif arg_304_1._id == 9864 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("PH", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner)), 1
	elseif arg_304_1._id == 9865 then
		local var_304_242 = B.filterNotEqualInfoIdCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("GL", Data.CardType.monster), var_304_1._refCards[2]), var_304_1._refCards[1])

		return true, var_304_242, math.min(#var_304_242, 2)
	elseif arg_304_1._id == 9867 then
		return true, arg_304_0:getBattleCardsBy9867(), 1
	elseif arg_304_1._id == 9869 then
		return true, B.filterNotSameNameCards(B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByType("G", Data.CardType.monster)),
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByType("G", Data.CardType.monster))
		}), arg_304_1._owner), 1
	elseif arg_304_1._id == 9870 then
		return true, B.mergeTable({
			arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoId("G", var_304_1._refCards[1])),
			arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByMaxStar("G", var_304_2), var_304_1._refCards[2]))
		}), 2
	elseif arg_304_1._id == 9876 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9879 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByAtkDef("P", 800, 1000))), 1
	elseif arg_304_1._id == 9881 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByInfoId("P", var_304_1._refCards[2]),
			arg_304_0:getBattleCardsByInfoId("P", var_304_1._refCards[3])
		}))), 1
	elseif arg_304_1._id == 9885 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]))),
			B.sortCardsByBoardPos(var_304_0:filterCanChangeToHandCards(var_304_0:getBoardCards()))
		}), 1
	elseif arg_304_1._id == 9886 then
		local var_304_243 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByType("HG", Data.CardType.monster))

		return true, var_304_243, math.min(math.min(#var_304_243, 2), arg_304_0:getEmptyBoardPosCount())
	elseif arg_304_1._id == 9895 or arg_304_1._id == 9898 or arg_304_1._id == 13058 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[1]), arg_304_1._owner:getAlterMagicInfoId())), 1
	elseif arg_304_1._id == 9896 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByCategory("HBG", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner)), 2
	elseif arg_304_1._id == 9897 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]),
			B.filterCounterTrapCards(arg_304_0:getBattleCardsByType("P", Data.CardType.trap))
		}))), 1
	elseif arg_304_1._id == 9908 or arg_304_1._id == 9910 or arg_304_1._id == 9912 or arg_304_1._id == 9914 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), arg_304_1._owner:getAlterMagicInfoId())), 1
	elseif arg_304_1._id == 9913 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_304_0:getBattleCardsByType("L", Data.CardType.monster), true)), 1
	elseif arg_304_1._id == 9916 then
		return true, arg_304_0:getBattleCardsBy9916(), 1
	elseif arg_304_1._id == 9917 then
		return true, arg_304_0:getBattleCardsBy9917(), 1
	elseif arg_304_1._id == 9919 then
		return true, B.filterXYZCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), true), 1
	elseif arg_304_1._id == 9926 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 9935 then
		return true, B.filterNoShieldCards(B.mergeTable({
			B.sortCardsByBoardPos(B.filterXYZCards(var_304_0:getBoardCards(), true)),
			B.sortCardsByBoardPos(B.filterXYZCards(arg_304_0:getBoardCards(), true))
		}), BattleData.PositiveType.shieldMonster, true), 1
	elseif arg_304_1._id == 9943 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByType("L", Data.CardType.monster)),
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByType("L", Data.CardType.monster))
		})), 1
	elseif arg_304_1._id == 9944 then
		return true, B.filterFirstCards(arg_304_0._pileCards, var_304_2), 1
	elseif arg_304_1._id == 9945 then
		return true, arg_304_0:getBattleCardsByNatureGroup("HG", var_304_1._refCards, Data.CARD_MAX_LEVEL, arg_304_1._owner), 2
	elseif arg_304_1._id == 9947 then
		return true, arg_304_0:getBattleCardsByType("G", Data.CardType.magic), 1
	elseif arg_304_1._id == 9948 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_304_0:getBattleCardsByCategory("B", var_304_1._refCards[1]))), 2
	elseif arg_304_1._id == 9950 then
		return true, B.filterCanBeSacrificedCards(var_304_0:getBoardCards()), 1
	elseif arg_304_1._id == 9954 or arg_304_1._id == 13093 or arg_304_1._id == 13485 or arg_304_1._id == 13486 or arg_304_1._id == 13563 or arg_304_1._id == 13584 or arg_304_1._id == 13758 or arg_304_1._id == 13824 or arg_304_1._id == 13879 then
		return true, B.sortCardsByBoardPos(var_304_0:filterCanChangeToHandCards(var_304_0:getBattleCards("BCSD"))), 1
	elseif arg_304_1._id == 9961 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(B.filterNotInKeywordCards(var_304_0:getBoardCards(), var_304_1._refCards[1]), BattleData.PositiveType.shieldMonster)), 1
	elseif arg_304_1._id == 9964 then
		return true, arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1], Data.CARD_MAX_LEVEL, arg_304_1._owner), 2
	elseif arg_304_1._id == 9966 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByNature("PH", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9967 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryGroup("PH", var_304_1._refCards), nil, nil, nil, true)), 1
	elseif arg_304_1._id == 9969 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInCategoryGroupCards(arg_304_0:getBattleCardsByStar("GH", var_304_2), var_304_1._refCards))), 1
	elseif arg_304_1._id == 9971 then
		return true, B.sortCardsByBoardPos(var_304_0:getBattleCardsByInfoId("B", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 9972 then
		return true, B.filterHasSameNameCardCards(B.mergeTable({
			B.sortCardsByBoardPos(arg_304_0:getBoardCards()),
			B.sortCardsByBoardPos(var_304_0:getBoardCards())
		})), 1
	elseif arg_304_1._id == 9974 or arg_304_1._id == 13350 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1])), 2
	elseif arg_304_1._id == 9979 then
		return true, B.sortCardsByBoardPos(B.filterXYZStarCards(B.filterNotActionedCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), true)), var_304_2)), 1
	elseif arg_304_1._id == 9983 then
		return true, B.filterUniqueIdCards(B.mergeTable({
			B.filterAdjustCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), true),
			B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_304_1._owner), var_304_1._refCards[1])
		})), 1
	elseif arg_304_1._id == 9984 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy9984(false)), 1
	elseif arg_304_1._id == 9986 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), true)), 1
	elseif arg_304_1._id == 9989 then
		return true, arg_304_0:getBattleCardsByCategoryGroup("G", var_304_1._refCards, Data.CARD_MAX_LEVEL, arg_304_1._owner._status == BattleData.CardStatus.grave and arg_304_1._owner), 2
	elseif arg_304_1._id == 9991 then
		return true, arg_304_0:getBattleCardsBy9991(), 1
	elseif arg_304_1._id == 7077 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInNatureCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2), var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 7113 then
		return true, arg_304_0:filterCanUse7113Cards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster)), 1
	elseif arg_304_1._id == 7199 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster), var_304_1._refCards[1]), math.min(var_304_2, #arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCards("P")))
	elseif arg_304_1._id == 7245 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategoryAndNature("H", var_304_1._refCards[1], var_304_1._refCards[2])), 1
	elseif arg_304_1._id == 7280 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeywordGroup("P", var_304_1._refCards))), 1
	elseif arg_304_1._id == 7288 or arg_304_1._id == 9816 or arg_304_1._id == 13789 then
		return true, arg_304_0:getBattleCardsByMinStar("H", var_304_2), 1
	elseif arg_304_1._id == 7297 or arg_304_1._id == 9866 then
		return true, B.filterInKeywordCards(arg_304_0:getBattleCardsByMinStar("G", 0), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 7299 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_304_0:getBattleCardsByKeyword("L", var_304_1._refCards[1]), false)), 1
	elseif arg_304_1._id == 7304 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterOnGraveRoundCards(B.filterCeremonyComponentToGraveCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster)), arg_304_0._round)), 1
	elseif arg_304_1._id == 7305 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterAtkMoreDefLessCards(arg_304_0:getBattleCardsByCategory("P", var_304_1._refCards[1]), 3000, 2500))), 2
	elseif arg_304_1._id == 7316 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByMaxAtk("P", var_304_2)), 1
	elseif arg_304_1._id == 7318 or arg_304_1._id == 13588 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("GP", Data.CardType.monster), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 7320 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterCeremonyMonsterCards(arg_304_0:getBattleCardsByKeyword("HG", var_304_1._refCards[1])), false, true), 1
	elseif arg_304_1._id == 7325 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNamesCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 7328 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy7328()), 1
	elseif arg_304_1._id == 7329 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterUniqueInfoIdCards(arg_304_0:getBattleCardsByKeyword("GPH", var_304_1._refCards[1])), true, true)), 2
	elseif arg_304_1._id == 7336 or arg_304_1._id == 7337 or arg_304_1._id == 7338 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.mergeTable({
			B.filterTokenCards(arg_304_0:getBoardCards(), true),
			B.filterTokenCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), false)
		}))), 1
	elseif arg_304_1._id == 7358 then
		return true, arg_304_0:getBattleCardsByType("L", Data.CardType.monster), 1
	elseif arg_304_1._id == 7359 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInNatureCards(arg_304_0:getBattleCardsByStar("P", var_304_2), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 7364 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterAllyMonsterCards(arg_304_0:getBattleCardsByCategoryAndNature("P", var_304_1._refCards[2], var_304_1._refCards[1])), arg_304_1._owner._mark7364))), 1
	elseif arg_304_1._id == 7365 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("PR", Data.CardType.monster), var_304_1._refCards[1]), false)), 1
	elseif arg_304_1._id == 7369 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[2]))), 1
	elseif arg_304_1._id == 7370 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[2]))), 1
	elseif arg_304_1._id == 7374 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			arg_304_0:getBattleCardsByCategory("G", var_304_1._refCards[1]),
			B.filterInKeywordCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster), var_304_1._refCards[2])
		})), 1
	elseif arg_304_1._id == 7380 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsByBuff("BCSD", true, BattleData.PositiveType.xyzMark)), 1
	elseif arg_304_1._id == 7399 then
		local var_304_244 = var_304_0:getBattleCards("C")

		if #var_304_244 > 0 then
			return true, var_304_244, 1
		end
	elseif arg_304_1._id == 7402 or arg_304_1._id == 13771 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategoryGroup("G", var_304_1._refCards)), 1
	elseif arg_304_1._id == 7405 then
		return true, B.sortCardsByBoardPos(B.filterNotEqualInfoIdCards(B.filterNotEqualInfoIdCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByType("P", Data.CardType.monster), var_304_1._refCards[1]), arg_304_1._owner._mark7405[1]), arg_304_1._owner._mark7405[2])), 1
	elseif arg_304_1._id == 7408 then
		return true, B.sortCardsByBoardPos(arg_304_0:getBattleCardsBy7408()), 1
	elseif arg_304_1._id == 7409 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterUniqueInfoIdCards(B.filterNotEqualInfoIdCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[2]), var_304_1._refCards[1]))), var_304_2
	elseif arg_304_1._id == 7414 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByCategory("PH", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 7417 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategoryAndNature("G", var_304_1._refCards[2], var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 7423 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterLessThanStarCards(arg_304_0:getBattleCardsByCategoryAndNature("P", var_304_1._refCards[2], var_304_1._refCards[1]), var_304_2))), 1
	elseif arg_304_1._id == 7434 then
		return true, arg_304_0:filterCanChangeToHandCards(B.filterSustainableMagicCards(arg_304_0:getBattleCards("G"))), 1
	elseif arg_304_1._id == 7444 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(B.filterInTypeCards(B.filterUniqueIdCards(B.mergeTable({
			arg_304_0:getBattleCardsByKeyword("GP", var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByCategory("GP", var_304_1._refCards[2])
		})), Data.CardType.monster))), 1
	elseif arg_304_1._id == 7463 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterAllyMonsterCards(arg_304_0:getBattleCardsByMaxStar("H", var_304_2))), 1
	elseif arg_304_1._id == 7465 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_304_0:getBattleCardsByStar("P", 4), var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 7479 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBattleCards("BSD"), BattleData.PositiveType.shieldMonster)),
			B.sortCardsByBoardPos(B.filterNoShieldCards(arg_304_0:getBattleCards("BSD", Data.CARD_MAX_LEVEL, arg_304_2), BattleData.PositiveType.shieldMonster))
		}), 1
	elseif arg_304_1._id == 7484 then
		return true, arg_304_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterNormalCards(arg_304_0:getBattleCardsByType("G", Data.CardType.monster)),
			arg_304_0:getBattleCardsByInfoId("G", var_304_1._refCards[1]),
			arg_304_0:getBattleCardsByInfoId("G", var_304_1._refCards[2])
		})), 1
	elseif arg_304_1._id == 7485 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterDualCards(arg_304_0:getBattleCards("H"))), 1
	elseif arg_304_1._id == 7540 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByCategoryAndNature("GP", var_304_1._refCards[2], var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 7549 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("GP", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 7550 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[2])), 2
	elseif arg_304_1._id == 7556 then
		local var_304_245 = arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("GL", var_304_1._refCards[1]))

		return true, var_304_245, math.min(math.min(2, #var_304_245), arg_304_0:getEmptyBoardPosCount())
	elseif arg_304_1._id == 7558 then
		return true, arg_304_0:getBattleCardsByKeywordGroup("GL", var_304_1._refCards), 1
	elseif arg_304_1._id == 7566 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			B.filterInKeywordCards(arg_304_0:getBattleCardsByType("H", Data.CardType.monster), var_304_1._refCards[1]),
			B.filterNotActionedCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]))
		})), 1
	elseif arg_304_1._id == 7569 then
		return true, B.sortCardsByBoardPos(B.filterFieldMagicCards(arg_304_0:getBattleCardsByKeyword("PG", var_304_1._refCards[1]))), 1
	elseif arg_304_1._id == 7578 then
		return true, B.filterNotSameNameCards(arg_304_0:getBattleCardsByKeyword("H", var_304_1._refCards[1]), arg_304_1._owner), 1
	elseif arg_304_1._id == 7581 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInStarCards(arg_304_0:getBattleCardsByKeyword("R", var_304_1._refCards[1]), arg_304_2:getStar() + var_304_2), true, true, nil, true), 1
	elseif arg_304_1._id == 7582 then
		return true, arg_304_0:getBattleCardsBy7582(), 1
	elseif arg_304_1._id == 7583 then
		return true, B.filterInCategoryCards(arg_304_0:getBattleCardsByMaxStar("P", var_304_2), var_304_1._refCards[1]), 1
	elseif arg_304_1._id == 7593 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterUniqueInfoIdCards(B.filterInTypeCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), Data.CardType.monster))), 2
	elseif arg_304_1._id == 7597 then
		return true, B.sortCardsByBoardPos(B.filterLinkCards(arg_304_0:getBattleCardsByKeyword("B", var_304_1._refCards[1]), true)), 1
	elseif arg_304_1._id == 7601 then
		return true, arg_304_0:getBattleCardsBy7601(), 1
	elseif arg_304_1._id == 7606 or arg_304_1._id == 7690 then
		return true, arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByKeyword("HG", var_304_1._refCards[1])), 1
	elseif arg_304_1._id == 7607 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterLinkCards(arg_304_0:getBattleCardsByKeyword("HG", var_304_1._refCards[1]), false)), 2
	elseif arg_304_1._id == 7612 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(var_304_0:getBattleCardsByMaxQuality("BCSDG", 4)),
			B.sortCardsByBoardPos(arg_304_0:getBattleCardsByMaxQuality("BCSDG", 4))
		}), 1
	elseif arg_304_1._id == 7613 then
		if #arg_304_0._handCards > 0 then
			return true, B.mergeTable({
				arg_304_0._handCards,
				B.filterFirstCards(arg_304_0:filterCanChangeToHandCards(arg_304_0._pileCards), 1)
			}), 1
		end
	elseif arg_304_1._id == 7615 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(B.filterLinkCards(arg_304_0:getBoardCards(), true)),
			B.sortCardsByBoardPos(var_304_0:getBoardCards())
		}), 2
	elseif arg_304_1._id == 7616 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_304_0:getBattleCardsByMaxQuality("B", var_304_1._refCards[1]), BattleData.PositiveType.shieldMagic, true)), 1
	elseif arg_304_1._id == 7619 or arg_304_1._id == 13589 or arg_304_1._id == 13664 then
		return true, arg_304_0:filterCanChangeToBoardCards(B.filterInTypeCards(arg_304_0:getBattleCardsByKeyword("G", var_304_1._refCards[1]), Data.CardType.monster)), 1
	elseif arg_304_1._id == 7620 then
		return true, arg_304_0:filterCanChangeToHandCards(arg_304_0:getBattleCardsByKeywordGroup("L", var_304_1._refCards)), 1
	elseif arg_304_1._id == 7621 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(arg_304_0:getBattleCardsByInfoIdGroup("GLPH", var_304_1._refCards))), 1
	elseif arg_304_1._id == 7633 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterNotInCategoryCards(arg_304_0:getBattleCardsByKeyword("P", var_304_1._refCards[1]), arg_304_1._owner._binds[1]._info._category))), 1
	elseif arg_304_1._id == 7634 then
		return true, B.sortCardsByBoardPos(arg_304_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_304_0:getBattleCardsByStar("P", var_304_2), true))), 1
	else
		return arg_304_0:isGraveSkill2(arg_304_1, arg_304_2, arg_304_3)
	end
end

function var_0_0.isGraveSkill2(arg_305_0, arg_305_1, arg_305_2, arg_305_3)
	if arg_305_1 == nil then
		return false
	end

	if arg_305_3 ~= (B.skillHasMode(arg_305_1, Data.SkillMode.initiative_bcs) or B.skillHasMode(arg_305_1, Data.SkillMode.initiative_grave) or B.skillHasMode(arg_305_1, Data.SkillMode.initiative_hand) or B.skillHasMode(arg_305_1, Data.SkillMode.initiative_rare) or B.skillHasMode(arg_305_1, Data.SkillMode.initiative_leave)) then
		return false
	end

	local var_305_0 = arg_305_0._opponent
	local var_305_1 = Data._skillInfo[arg_305_1._id]
	local var_305_2 = var_305_1._val[math.min(arg_305_1._level, #var_305_1._val)] or 0

	if arg_305_1._id == 5601 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy5601()), 1
	elseif arg_305_1._id == 5602 then
		return true, B.filterInKeywordCards(B.filterAdjustCards(arg_305_0:getBattleCardsByType("G", Data.CardType.monster), true), var_305_1._refCards[1]), 2
	elseif arg_305_1._id == 5603 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy5603()), 1
	elseif arg_305_1._id == 5605 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByNature("HB", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 5607 then
		return true, arg_305_0:getBattleCardsBy5607(), 1
	elseif arg_305_1._id == 5608 then
		return true, B.sortCardsByBoardPos(B.filterLinkCards(arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[1]), true)), 3
	elseif arg_305_1._id == 5622 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy5622()), 1
	elseif arg_305_1._id == 5624 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy5624()), 1
	elseif arg_305_1._id == 5630 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_305_0:getBoardCards(), BattleData.PositiveType.shieldTrap, true)), 1
	elseif arg_305_1._id == 5634 then
		return true, B.sortCardsByBoardPos(B.filterUniqueInfoIdCards(arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[1])))), 2
	elseif arg_305_1._id == 5637 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterSyncCards(arg_305_0:getBattleCardsByKeywordGroup("B", {
			var_305_1._refCards[2],
			var_305_1._refCards[3]
		}), true))), 1
	elseif arg_305_1._id == 5638 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterLinkCards(arg_305_0:getBattleCardsByKeywordGroup("B", {
			var_305_1._refCards[2],
			var_305_1._refCards[3]
		}), true))), 1
	elseif arg_305_1._id == 5641 then
		local var_305_3 = arg_305_0:getBattleCardsByCategory("L", var_305_1._refCards[1])

		return true, var_305_3, math.min(2, #var_305_3)
	elseif arg_305_1._id == 5644 then
		return true, B.filterInTypeGroupCards(arg_305_0:getBattleCardsByMaxQuality("G", var_305_1._refCards[1]), {
			Data.CardType.magic,
			Data.CardType.trap
		}), 1
	elseif arg_305_1._id == 5646 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 5647 then
		local var_305_4 = arg_305_0:getBattleCardsBy5647()

		if #var_305_4 > 0 then
			return true, B.sortCardsByBoardPos(var_305_4), 1
		end
	elseif arg_305_1._id == 5650 then
		local var_305_5 = var_305_0._graveCards

		return true, var_305_5, math.min(2, #var_305_5)
	elseif arg_305_1._id == 5651 then
		local var_305_6 = var_305_0:filterCanChangeToHandCards(var_305_0:getBattleCards("BCSD"))

		return true, var_305_6, math.min(2, #var_305_6)
	elseif arg_305_1._id == 5652 then
		local var_305_7 = arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByNature("G", var_305_1._refCards[1]))

		return true, var_305_7, math.min(math.min(2, #var_305_7), arg_305_0:getEmptyBoardPosCount())
	elseif arg_305_1._id == 5653 then
		local var_305_8 = var_305_0:getBattleCards("BCSD")

		return true, var_305_8, math.min(2, #var_305_8)
	elseif arg_305_1._id == 5654 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByKeyword("HG", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 5656 then
		local var_305_9 = B.filterInKeywordCards(arg_305_0:getBattleCardsByType("G", Data.CardType.monster), var_305_1._refCards[1])

		return true, var_305_9, math.min(2, #var_305_9)
	elseif arg_305_1._id == 5657 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByKeyword("G", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 5660 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByKeyword("HGL", var_305_1._refCards[1]), true, true), 1
	elseif arg_305_1._id == 5665 then
		return true, B.sortCardsByBoardPos(var_305_0:getBattleCards("BCSD")), 1
	elseif arg_305_1._id == 5667 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_305_0:getBattleCardsByCategoryAndNature("L", var_305_1._refCards[2], var_305_1._refCards[1]), true)), 1
	elseif arg_305_1._id == 7653 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("P", Data.CardType.monster), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 7658 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_305_0:getBattleCardsByStar("HP", var_305_2), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 7661 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_305_0:getBattleCardsByType("H", Data.CardType.monster), true)), 1
	elseif arg_305_1._id == 7663 then
		return true, arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.mergeTable({
			B.filterInKeywordCards(arg_305_0:getBattleCardsByTypeGroup("GL", {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_305_1._refCards[1]),
			B.filterInKeywordCards(var_305_0:getBattleCardsByTypeGroup("GL", {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_305_1._refCards[1])
		}), arg_305_1._owner)), 1
	elseif arg_305_1._id == 7667 then
		return true, B.sortCardsByBoardPos(B.filterHasSameNameCardCards(arg_305_0:getBattleCardsByMaxStar("B", var_305_2))), 2
	elseif arg_305_1._id == 7671 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_305_0:getBoardCards(), BattleData.PositiveType.shieldMagic, true)), 1
	elseif arg_305_1._id == 7686 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy7686()), 1
	elseif arg_305_1._id == 7687 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy7687()), 1
	elseif arg_305_1._id == 7692 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByStar("P", var_305_2), var_305_1._refCards[2]))), 1
	elseif arg_305_1._id == 7700 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_305_0:getBattleCardsByMaxAtk("PG", arg_305_0._opponent._fortress._hp - arg_305_0._fortress._hp), var_305_1._refCards))), 1
	elseif arg_305_1._id == 7701 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.filterInKeywordGroupCards(arg_305_0:getBattleCardsByMaxAtk("PG", arg_305_0._opponent._fortress._hp - arg_305_0._fortress._hp), var_305_1._refCards))), 1
	elseif arg_305_1._id == 7705 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy7705()), 1
	elseif arg_305_1._id == 7706 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy7706()), 1
	elseif arg_305_1._id == 7707 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByKeyword("HGL", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 7708 then
		return true, arg_305_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterInKeywordCards(arg_305_0:getBattleCardsByType("P", Data.CardType.monster), var_305_1._refCards[1]),
			B.filterNotSameNameCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByTypeGroup("P", {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_305_1._refCards[1]), arg_305_1._owner)
		})), 2
	elseif arg_305_1._id == 7719 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCardsByKeywordGroup("P", var_305_1._refCards))), 1
	elseif arg_305_1._id == 7720 then
		return true, B.sortCardsByBoardPos(B.filterUniqueInfoIdCards(B.mergeTable({
			arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[1]),
			B.filterMergeCards(arg_305_0:getBoardCards(), true)
		}))), 1
	elseif arg_305_1._id == 7721 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0._handCards), 1
	elseif arg_305_1._id == 7722 then
		return true, B.sortCardsByBoardPos(var_305_0:filterCanChangeToHandCards(var_305_0:getBattleCards("BCSD"))), 1
	elseif arg_305_1._id == 7723 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("HP", Data.CardType.monster), var_305_1._refCards[1]), nil, nil, nil, true)), 1
	elseif arg_305_1._id == 8010 then
		return true, B.sortCardsByBoardPos(B.filterTokenCards(B.filterNormalCards(arg_305_0:getBoardCards()), false)), var_305_2
	elseif arg_305_1._id == 8042 then
		return true, B.filterInKeywordCards(B.mergeTable({
			arg_305_0:getBattleCardsByType("G", Data.CardType.magic),
			arg_305_0:getBattleCardsByType("G", Data.CardType.trap)
		}), var_305_1._refCards[1]), 2
	elseif arg_305_1._id == 8018 or arg_305_1._id == 8056 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("BH", Data.CardType.monster), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 8019 then
		return true, B.filterInCategoryCards(arg_305_0:getBattleCardsByType("H", Data.CardType.monster), var_305_1._refCards[1]), 1
	elseif arg_305_1._id == 8058 then
		return true, B.sortCardsByBoardPos(var_305_0:getBattleCardsByMaxStar("B", #arg_305_0:getBattleCardsByType("G", Data.CardType.monster))), 1
	elseif arg_305_1._id == 8062 or arg_305_1._id == 5576 or arg_305_1._id == 9536 or arg_305_1._id == 9589 or arg_305_1._id == 9636 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByMaxStar("G", var_305_2)), 1
	elseif arg_305_1._id == 8065 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.filterNotSameNamesCards(arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[1]), arg_305_0:getBoardCards()))), 1
	elseif arg_305_1._id == 8068 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByCategory("BH", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 8071 then
		return true, var_305_0:filterCanChangeToHandCards(var_305_0:getBattleCards("BCSD")), 2
	elseif arg_305_1._id == 8073 then
		return true, B.sortCardsByBoardPos(B.filterTokenCards(arg_305_0:getBoardCards(), false)), var_305_2
	elseif arg_305_1._id == 8077 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_305_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.xyzMark), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 8082 then
		return true, arg_305_0:getBattleCardsBy8082(), 1
	elseif arg_305_1._id == 8083 then
		return true, arg_305_0:getBattleCardsBy8083(), 1
	elseif arg_305_1._id == 8085 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_305_0:getBattleCardsByInfoId("GH", var_305_1._refCards[1]),
			arg_305_0:getBattleCardsByKeyword("GH", var_305_1._refCards[2])
		})), 1
	elseif arg_305_1._id == 8087 then
		return true, B.mergeTable({
			var_305_0:getBattleCards("C"),
			arg_305_0:getBattleCards("C")
		}), 1
	elseif arg_305_1._id == 8088 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByNature("B", var_305_1._refCards[2])), 1
	elseif arg_305_1._id == 8091 then
		return true, B.mergeTable({
			arg_305_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("G", Data.CardType.monster), var_305_1._refCards[1])),
			arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCardsByKeyword("G", var_305_1._refCards[2]))
		}), 1
	elseif arg_305_1._id == 8094 or arg_305_1._id == 8133 or arg_305_1._id == 8145 or arg_305_1._id == 8145 or arg_305_1._id == 13828 then
		return true, arg_305_0:getBattleCardsByKeywordGroup("H", var_305_1._refCards), 1
	elseif arg_305_1._id == 8103 or arg_305_1._id == 4942 then
		return true, B.filterInKeywordCards(arg_305_0:getBattleCardsByType("L", Data.CardType.monster), var_305_1._refCards[1]), 1
	elseif arg_305_1._id == 8109 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByCategoryAndNature("P", var_305_1._refCards[3], var_305_1._refCards[2])), 1
	elseif arg_305_1._id == 8111 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByInfoId("BGH", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 8123 or arg_305_1._id == 8124 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_305_0:getBattleCardsByCategory("B", var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 8126 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByType("PH", Data.CardType.trap)), 1
	elseif arg_305_1._id == 8131 then
		return true, arg_305_0:getBattleCardsByNature("G", var_305_1._refCards[1]), 1
	elseif arg_305_1._id == 9351 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(B.filterSelfCards(var_305_0:getBoardCards()), BattleData.PositiveType.shieldMonster)), 1
	elseif arg_305_1._id == 13001 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterCeremonyMonsterCards(arg_305_0:getBattleCards("P")))), 1
	elseif arg_305_1._id == 13003 or arg_305_1._id == 13005 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByNatureGroup("P", {
			var_305_1._refCards[1],
			var_305_1._refCards[2]
		}), var_305_1._refCards[3]))), 1
	elseif arg_305_1._id == 13006 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterCeremonyMagicCards(arg_305_0:getBattleCardsByType("P", Data.CardType.magic)))), 1
	elseif arg_305_1._id == 13009 then
		local var_305_10 = B.filterNoShieldCards(var_305_0:getBattleCards("BCSD"), BattleData.PositiveType.shieldMonster)

		return true, B.sortCardsByBoardPos(var_305_10), math.min(#var_305_10, #B.filterSyncCards(arg_305_0:getBattleCardsByType("G", Data.CardType.monster), true))
	elseif arg_305_1._id == 13010 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterSyncCards(B.filterInKeywordGroupCards(arg_305_0:getBattleCardsByMaxStar("G", var_305_2), var_305_1._refCards), true)), 1
	elseif arg_305_1._id == 13018 then
		return true, B.sortCardsByBoardPos(var_305_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.sugarMark)), 1
	elseif arg_305_1._id == 13027 then
		return true, B.filterInKeywordCards(arg_305_0:getBattleCardsByType("P", Data.CardType.monster), var_305_1._refCards[1]), 1
	elseif arg_305_1._id == 13035 or arg_305_1._id == 13040 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByXYZMagicTrapCardMark("B")), 1
	elseif arg_305_1._id == 13037 then
		return true, B.sortCardsByBoardPos(B.filterUniqueInfoIdCards(arg_305_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[2]), arg_305_1._owner)))), 2
	elseif arg_305_1._id == 13044 then
		return true, B.sortCardsByBoardPos(B.filterFirstCards(arg_305_0._pileCards, var_305_2)), 1
	elseif arg_305_1._id == 13045 then
		return true, B.sortCardsByBoardPos(B.filterFirstCards(var_305_0._pileCards, var_305_2)), 1
	elseif arg_305_1._id == 13054 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(arg_305_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_305_1._owner), true)), 1
	elseif arg_305_1._id == 13061 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByInfoId("GH", var_305_1._refCards[1]), nil, nil, nil, true), 1
	elseif arg_305_1._id == 13062 then
		return true, arg_305_0:getBattleCardsByKeyword("H", var_305_1._refCards[2]), 1
	elseif arg_305_1._id == 13066 then
		return true, B.filterInInfoIdGroupCards(arg_305_1._owner._binds, var_305_1._refCards), 1
	elseif arg_305_1._id == 13067 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByStar("PH", var_305_2), var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13072 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy13072()), 1
	elseif arg_305_1._id == 13094 then
		local var_305_11 = var_305_0:getBattleCards("CSD")

		return true, var_305_11, math.min(#var_305_11, 2)
	elseif arg_305_1._id == 13099 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			B.filterCanBeSacrificedCards(arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[1])),
			B.filterInKeywordCards(arg_305_0:getBattleCardsByType("H", Data.CardType.monster), var_305_1._refCards[1])
		})), 1
	elseif arg_305_1._id == 13103 then
		local var_305_12 = B.mergeTable({
			arg_305_0:getBattleCards("G"),
			var_305_0:getBattleCards("G")
		})

		return true, var_305_12, math.min(#var_305_12, 2)
	elseif arg_305_1._id == 13106 then
		local var_305_13 = B.sortCardsByBoardPos(B.filterNoShieldCards(var_305_0:getBoardCards(), BattleData.PositiveType.shieldMonster))

		return true, var_305_13, math.min(math.min(#var_305_13, arg_305_1._owner:getBuffValue(true, BattleData.PositiveType.xyzMark)), arg_305_0:getEmptyBoardPosCount())
	elseif arg_305_1._id == 13108 then
		local var_305_14 = B.filterNotActionedCards(B.filterXYZStarCards(B.filterXYZCards(arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[1]), true), var_305_2))
		local var_305_15 = B.filterNotActionedCards(B.filterXYZStarCards(B.filterXYZCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[2]), var_305_1._refCards[3]), true), var_305_2))

		return true, B.sortCardsByBoardPos(B.mergeTable({
			var_305_14,
			var_305_15
		})), 1
	elseif arg_305_1._id == 13118 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByTypeGroup("PG", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13120 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByKeyword(arg_305_0:getEmptyBoardPos() == nil and "B" or "BCSDH", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13132 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCards(arg_305_0:getEmptyBoardPos() == nil and "B" or "BCSDHG")), 1
	elseif arg_305_1._id == 13138 then
		local var_305_16 = var_305_0:filterCanChangeToHandCards(var_305_0:getBattleCards("BCSD"))

		return true, B.sortCardsByBoardPos(var_305_16), math.min(#var_305_16, arg_305_1._owner._mark13138)
	elseif arg_305_1._id == 13141 or arg_305_1._id == 13755 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByMinStar("B", 0)), 1
	elseif arg_305_1._id == 13142 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			B.filterInStarCards(var_305_0:getBattleCardsByMinStar("B", 0), arg_305_1._owner:getStar()),
			B.filterXYZStarCards(B.filterXYZCards(var_305_0:getBoardCards(), true), arg_305_1._owner:getStar())
		})), 1
	elseif arg_305_1._id == 13147 then
		local var_305_17 = B.filterNotActionedCards(B.filterInKeywordGroupCards(arg_305_0:getBattleCardsByMinStar("BH", 0, Data.CARD_MAX_LEVEL, arg_305_1._owner), {
			var_305_1._refCards[1],
			Data.CardKeyword.cartoon
		}))

		return true, B.sortCardsByBoardPos(var_305_17), #var_305_17
	elseif arg_305_1._id == 13149 then
		local var_305_18 = var_305_0:getBattleCards("BCSD")

		return true, B.sortCardsByBoardPos(var_305_18), math.min(#var_305_18, var_305_2)
	elseif arg_305_1._id == 13155 or arg_305_1._id == 13226 or arg_305_1._id == 13629 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotActionedCards(arg_305_0:getBoardCards()))), 1
	elseif arg_305_1._id == 13156 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotActionedCards(arg_305_0:getBoardCards()))), 2
	elseif arg_305_1._id == 13157 or arg_305_1._id == 13223 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotActionedCards(arg_305_0:getBoardCards()))), 3
	elseif arg_305_1._id == 13159 or arg_305_1._id == 13246 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[2]))), 1
	elseif arg_305_1._id == 13160 then
		return true, arg_305_0:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_305_0:getBattleCardsByType("G", Data.CardType.monster), var_305_1._refCards)), 1
	elseif arg_305_1._id == 13168 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy13168()), 1
	elseif arg_305_1._id == 13169 or arg_305_1._id == 13796 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_305_0:getBattleCardsByCategory("P", var_305_1._refCards[1]), arg_305_1._owner))), 1
	elseif arg_305_1._id == 13172 or arg_305_1._id == 13175 or arg_305_1._id == 13185 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotActionedCards(arg_305_0:getBattleCardsByCategory("B", var_305_1._refCards[1])))), 1
	elseif arg_305_1._id == 13173 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterUniqueIdCards(B.mergeTable({
			arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[2]),
			arg_305_0:getBattleCardsByCategory("P", var_305_1._refCards[1])
		})))), 1
	elseif arg_305_1._id == 13178 then
		local var_305_19 = B.filterInCategoryCards(arg_305_0:getBattleCardsByMinStar("B", 0), var_305_1._refCards[1])

		return true, B.sortCardsByBoardPos(var_305_19), math.min(2, #var_305_19)
	elseif arg_305_1._id == 13182 then
		local var_305_20 = B.filterInCategoryCards(arg_305_0:getBattleCardsByMinStar("B", 0, Data.CARD_MAX_LEVEL, arg_305_1._owner), var_305_1._refCards[1])

		return true, B.sortCardsByBoardPos(var_305_20), math.min(2, #var_305_20)
	elseif arg_305_1._id == 13184 or arg_305_1._id == 5615 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(B.filterXYZCards(var_305_0:getBoardCards(), true), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_305_1._id == 13186 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_305_0:getBattleCardsByMinStar("B", 0), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13188 or arg_305_1._id == 7564 then
		return true, B.filterUniqueIdCards(B.mergeTable({
			arg_305_0:getBattleCardsByKeyword("GL", var_305_1._refCards[1]),
			arg_305_0:getBattleCardsByCategory("GL", var_305_1._refCards[2])
		})), 1
	elseif arg_305_1._id == 13190 then
		return true, B.sortCardsByBoardPos(B.filterQualityLessThanCards(var_305_0:getBattleCardsByMinStar("B", 0), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13191 then
		return true, B.sortCardsByBoardPos(B.filterQualityLessThanCards(B.filterXYZCards(var_305_0:getBoardCards(), true), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13196 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterAdjustCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("P", Data.CardType.monster), var_305_1._refCards[1]), true), arg_305_1._owner))), 1
	elseif arg_305_1._id == 13198 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterUniqueIdCards(B.mergeTable({
			arg_305_0:getBattleCardsByCategory("G", var_305_1._refCards[1]),
			arg_305_0:getBattleCardsByKeyword("G", var_305_1._refCards[2])
		})))), 1
	elseif arg_305_1._id == 13207 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_305_0:getBattleCardsByCategory("HG", var_305_1._refCards[1]), arg_305_1._owner))), 1
	elseif arg_305_1._id == 13209 or arg_305_1._id == 13395 or arg_305_1._id == 13478 or arg_305_1._id == 13540 or arg_305_1._id == 13615 or arg_305_1._id == 13804 then
		return true, arg_305_0:filterCanChangeToBoardCards(var_305_0:getBattleCardsByNature("G", var_305_1._refCards[1]), true, true), 1
	elseif arg_305_1._id == 13210 or arg_305_1._id == 13396 or arg_305_1._id == 13479 or arg_305_1._id == 13541 or arg_305_1._id == 13616 or arg_305_1._id == 13805 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterInNatureCards(arg_305_0:getBattleCardsByMaxOriginDef("P", var_305_2), var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13215 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterAllyMonsterCards(arg_305_0:getBattleCardsByKeyword("H", var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13218 then
		return true, arg_305_0:getBattleCardsByNature("L", var_305_1._refCards[1]), 1
	elseif arg_305_1._id == 13231 then
		local var_305_21 = arg_305_0:getBattleCardsByType("CS", Data.CardType.trap)

		if #arg_305_0:getBattleCardsByInfoId("S", var_305_1._refCards[1]) > 0 then
			B.appendTable(var_305_21, var_305_0:getBattleCardsByType("CS", Data.CardType.trap))
		end

		return true, var_305_21, var_305_2
	elseif arg_305_1._id == 13237 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("BH", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_305_1._owner), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13239 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_305_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.xyzMark), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_305_1._id == 13241 or arg_305_1._id == 13329 or arg_305_1._id == 13806 then
		return true, B.sortCardsByBoardPos(var_305_0:getBattleCardsByMaxAtk("B", arg_305_1._owner._atk)), 1
	elseif arg_305_1._id == 13251 then
		return true, B.filterLinkCards(var_305_0:getBattleCardsByType("G", Data.CardType.monster), false), 1
	elseif arg_305_1._id == 13253 then
		return true, B.sortCardsByBoardPos(B.filterInNatureCards(arg_305_0:getBattleCardsByBuff("B", true, BattleData.PositiveType.xyzMark), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13261 then
		return true, B.sortCardsByBoardPos(B.filterLinkCards(arg_305_0:getBoardCards(), true)), 1
	elseif arg_305_1._id == 13271 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterSameNameCards(arg_305_0:getBattleCardsByType("P", Data.CardType.monster), arg_305_1._owner))), 1
	elseif arg_305_1._id == 13274 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_305_0:getBattleCardsByKeyword("GL", var_305_1._refCards[1]), arg_305_1._owner)), 1
	elseif arg_305_1._id == 13275 or arg_305_1._id == 13276 then
		return true, arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCards("H")), 0
	elseif arg_305_1._id == 13280 then
		local var_305_22 = B.filterInCategoryCards(arg_305_0:getEmptyBoardPos() == nil and arg_305_0:getBattleCardsByMaxStar("B", var_305_2) or arg_305_0:getBattleCardsByMaxStar("HB", var_305_2, Data.CARD_MAX_LEVEL, arg_305_1._owner), var_305_1._refCards[1])

		return true, B.sortCardsByBoardPos(var_305_22), 1
	elseif arg_305_1._id == 13281 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByCategory("G", var_305_1._refCards[1])), var_305_2
	elseif arg_305_1._id == 13283 then
		return true, B.sortCardsByBoardPos(B.filterHasSameNameCardCards(B.filterInCategoryCards(B.filterInNatureCards(B.filterInStarCards(arg_305_0:getBattleCardsByMaxOriginAtk("P", var_305_2), 4), var_305_1._refCards[1]), var_305_1._refCards[2]))), 2
	elseif arg_305_1._id == 13284 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(B.filterInNatureCards(B.filterInStarCards(arg_305_0:getBattleCardsByMaxOriginAtk("G", var_305_2), 4), var_305_1._refCards[1]), var_305_1._refCards[2])), 1
	elseif arg_305_1._id == 13285 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInStarCards(arg_305_0:getBattleCardsByCategoryAndNature("H", var_305_1._refCards[2], var_305_1._refCards[1]), var_305_2), arg_305_1._owner)), 1
	elseif arg_305_1._id == 13286 then
		return true, arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInStarCards(arg_305_0:getBattleCardsByCategoryAndNature("P", var_305_1._refCards[2], var_305_1._refCards[1]), var_305_2), arg_305_1._owner)), 1
	elseif arg_305_1._id == 13293 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			arg_305_0:getBattleCardsByCategory("H", var_305_1._refCards[1]),
			B.filterNotEqualInfoIdCards(B.filterMergeCards(B.filterNotActionedCards(arg_305_0:getBattleCardsByCategory("B", var_305_1._refCards[1]))), var_305_1._refCards[2])
		})), 2
	elseif arg_305_1._id == 13294 then
		local var_305_23 = var_305_0:getBattleCards("BCSD")

		var_305_23[#var_305_23 + 1] = arg_305_1._owner

		return true, B.sortCardsByBoardPos(var_305_23), 1
	elseif arg_305_1._id == 13296 then
		return true, arg_305_0:getBattleCards("H"), 1
	elseif arg_305_1._id == 13301 then
		local var_305_24 = B.filterInKeywordCards(arg_305_0:getBattleCardsByType("L", Data.CardType.monster), var_305_1._refCards[1])

		return true, var_305_24, math.min(#var_305_24, 2)
	elseif arg_305_1._id == 13307 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("G", Data.CardType.monster), var_305_1._refCards[1])), 2
	elseif arg_305_1._id == 13308 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[1]), arg_305_1._owner), nil, nil, nil, arg_305_1._owner._status == BattleData.CardStatus.board)), 1
	elseif arg_305_1._id == 13311 then
		local var_305_25 = var_305_0:getBattleCards("CSD")

		return true, var_305_25, math.min(#var_305_25, 2)
	elseif arg_305_1._id == 13313 then
		return true, var_305_0:getBattleCards("R"), 1
	elseif arg_305_1._id == 13315 or arg_305_1._id == 13388 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_305_0:getBattleCardsByKeywordGroup("PG", var_305_1._refCards), arg_305_1._owner))), 1
	elseif arg_305_1._id == 13318 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_305_0:getBattleCardsByKeywordGroup("B", var_305_1._refCards))), 1
	elseif arg_305_1._id == 13321 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_305_0:getBoardCards(), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_305_1._id == 13323 then
		return true, B.mergeTable({
			B.filterLinkCards(var_305_0:getBattleCardsByType("G", Data.CardType.monster), true),
			B.filterLinkCards(arg_305_0:getBattleCardsByType("G", Data.CardType.monster), true)
		}), 1
	elseif arg_305_1._id == 13338 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[2]), var_305_1._refCards[1]), nil, nil, nil, true)), 2
	elseif arg_305_1._id == 13339 then
		return true, B.sortCardsByBoardPos(B.filterNotBindedCards(B.filterOnBoardRoundCards(B.filterSummonByXYZCards(arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[1])), arg_305_0._round), var_305_1._refCards[2])), 1
	elseif arg_305_1._id == 13347 then
		return true, B.sortCardsByBoardPos(B.filterHasOppoShieldCards(var_305_0:getBoardCards())), 1
	elseif arg_305_1._id == 13352 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByKeyword("PG", var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13359 or arg_305_1._id == 13673 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCardsByNature("P", var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13362 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByStar("P", var_305_2), var_305_1._refCards[1]), arg_305_1._owner))), 1
	elseif arg_305_1._id == 13367 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterOppoCards(arg_305_0:getBoardCards()))), 1
	elseif arg_305_1._id == 13370 then
		local var_305_26 = var_305_0:getBattleCards("BCSD")

		return true, arg_305_0._handCards, math.min(#var_305_26, #arg_305_0._handCards)
	elseif arg_305_1._id == 13371 then
		local var_305_27 = var_305_0:filterCanChangeToHandCards(var_305_0:getBattleCards("BCSD"))

		return true, var_305_27, math.min(arg_305_1._owner:getBuffValue(true, BattleData.PositiveType.bjjMark), #var_305_27)
	elseif arg_305_1._id == 13374 then
		return true, B.filterNotSameNameCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("GL", Data.CardType.monster), var_305_1._refCards[1]), arg_305_1._owner), 1
	elseif arg_305_1._id == 13378 then
		return true, B.filterInKeywordCards(arg_305_0:getBattleCardsByType("GL", Data.CardType.magic), var_305_1._refCards[1]), 1
	elseif arg_305_1._id == 13382 then
		return true, B.mergeTable({
			var_305_0:getBattleCardsByMaxQuality("B", var_305_1._refCards[1]),
			B.filterMergeCards(arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[2]))
		}), 1
	elseif arg_305_1._id == 13387 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_305_0:getBattleCardsByKeywordGroup("P", var_305_1._refCards), arg_305_1._owner))), 1
	elseif arg_305_1._id == 13399 then
		return true, arg_305_0:getBattleCardsByCategoryAndNature("HG", var_305_1._refCards[2], var_305_1._refCards[1], Data.CARD_MAX_LEVEL, arg_305_1._owner), 1
	elseif arg_305_1._id == 13402 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			B.filterInKeywordCards(arg_305_0:getBattleCardsByType("P", Data.CardType.monster), var_305_1._refCards[1]),
			B.filterEquipMagicCards(arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[2]))
		})), 1
	elseif arg_305_1._id == 13403 then
		return true, B.filterEquipMagicCards(arg_305_0:getBattleCardsByKeyword("L", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13404 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterEquipMagicCards(arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[1])))), 1
	elseif arg_305_1._id == 13405 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_305_0:getBattleCardsByMaxQuality("B", var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13409 then
		return true, B.sortCardsByBoardPos(var_305_0:filterCanChangeToHandCards(var_305_0:getBattleCardsByMaxQuality("B", var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13410 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByMaxQuality("B", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13416 then
		return true, arg_305_0:getBattleCardsByKeyword("G", var_305_1._refCards[1], Data.CARD_MAX_LEVEL, arg_305_1._owner), 2
	elseif arg_305_1._id == 13422 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[1]), arg_305_1._owner)), 1
	elseif arg_305_1._id == 13424 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterNormalMagicCards(arg_305_0:getBattleCardsByKeyword("P", var_305_1._refCards[2])))), 1
	elseif arg_305_1._id == 13444 then
		local var_305_28 = arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCardsByKeyword("GP", var_305_1._refCards[1]))

		return true, B.sortCardsByBoardPos(var_305_28), math.min(2, #var_305_28)
	elseif arg_305_1._id == 13449 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterLinkCards(var_305_0:getBattleCardsByType("G", Data.CardType.monster), true), true, true), 1
	elseif arg_305_1._id == 13454 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterAdjustCards(B.filterInNatureCards(arg_305_0:getBattleCardsByStar("P", var_305_2), var_305_1._refCards[1]), true), arg_305_1._owner))), 1
	elseif arg_305_1._id == 13462 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_305_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_305_1._refCards[1])), var_305_2
	elseif arg_305_1._id == 13463 then
		return true, B.sortCardsByBoardPos(B.filter5527Cards(arg_305_0:getBattleCardsByType("P", Data.CardType.monster), arg_305_0)), 1
	elseif arg_305_1._id == 13465 then
		local var_305_29 = arg_305_0:getBattleCardsByAtkDef("GL", 800, 1000)

		return true, var_305_29, math.min(#var_305_29, 2)
	elseif arg_305_1._id == 13467 then
		return true, B.filterLinkCards(arg_305_0:getBattleCards("R"), true), 1
	elseif arg_305_1._id == 13468 then
		return true, B.filterNotSameNameCards(arg_305_0:getBattleCardsByCategory("G", var_305_1._refCards[1]), arg_305_1._owner), 1
	elseif arg_305_1._id == 13469 then
		return true, B.filterUniqueIdCards(B.mergeTable({
			arg_305_0:getBattleCardsByCategory("G", var_305_1._refCards[1]),
			arg_305_0:getBattleCardsByHp("G", 1000)
		})), 2
	elseif arg_305_1._id == 13474 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_305_0:getBattleCards("BCS")),
			B.sortCardsByBoardPos(var_305_0:getBattleCards("BCSG"))
		}), 2
	elseif arg_305_1._id == 13476 then
		return true, B.mergeTable({
			B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCards("BCSD"))),
			B.sortCardsByBoardPos(var_305_0:filterCanChangeToHandCards(var_305_0:getBattleCards("BCSD")))
		}), 1
	elseif arg_305_1._id == 13480 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy13480(arg_305_1._owner)), 1
	elseif arg_305_1._id == 13482 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("P", Data.CardType.monster), var_305_1._refCards[2]))), 1
	elseif arg_305_1._id == 13490 or arg_305_1._id == 7668 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterInTypeCards(arg_305_0:getBattleCardsByKeyword("HG", var_305_1._refCards[1]), Data.CardType.monster)), 1
	elseif arg_305_1._id == 13492 then
		local var_305_30 = B.mergeTable({
			B.sortCardsByBoardPos(B.filterXYZCards(arg_305_0:getBoardCards(), true)),
			B.sortCardsByBoardPos(B.filterXYZCards(var_305_0:getBoardCards(), true))
		})

		if #var_305_30 > 0 then
			return true, var_305_30, 1
		end
	elseif arg_305_1._id == 13503 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[1]))), 2
	elseif arg_305_1._id == 13506 then
		return true, arg_305_0:getBattleCardsBy13506(), 1
	elseif arg_305_1._id == 13511 then
		local var_305_31 = arg_305_0:getEmptyGroundPosCount() + var_305_0:getEmptyGroundPosCount() + (arg_305_0._fieldCard == nil and 1 or 0) + (var_305_0._fieldCard == nil and 1 or 0)
		local var_305_32 = arg_305_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByMaxStar("PH", var_305_31), var_305_1._refCards[1]))

		return true, B.sortCardsByBoardPos(var_305_32), 1
	elseif arg_305_1._id == 13521 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterInKeywordGroupCards(arg_305_0:getBattleCardsByType("G", Data.CardType.monster), var_305_1._refCards)), 1
	elseif arg_305_1._id == 13523 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterAdjustCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByMaxStar("G", var_305_2), var_305_1._refCards[1]), true)), 1
	elseif arg_305_1._id == 13531 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[1], Data.CARD_MAX_LEVEL, arg_305_1._owner))), 1
	elseif arg_305_1._id == 13545 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByKeyword("HP", var_305_1._refCards[1]))), 2
	elseif arg_305_1._id == 13552 then
		return true, arg_305_0:getBattleCardsBy13552(), 1
	elseif arg_305_1._id == 13553 then
		return true, arg_305_0:getBattleCardsBy13553(), 1
	elseif arg_305_1._id == 13561 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByKeyword("HG", var_305_1._refCards[1])), 2
	elseif arg_305_1._id == 13565 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterAdjustCards(arg_305_0:getBattleCardsByKeyword("L", var_305_1._refCards[1]), true)), 1
	elseif arg_305_1._id == 13571 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByNature("H", var_305_1._refCards[2])), 1
	elseif arg_305_1._id == 13576 then
		local var_305_33 = B.filterFirstCards(arg_305_0._pileCards, 3)
		local var_305_34 = arg_305_0:filterCanChangeToHandCards(B.filterInKeywordCards(var_305_33, var_305_1._refCards[2]))

		return true, B.sortCardsByBoardPos(#var_305_34 > 0 and var_305_34 or var_305_33), 1
	elseif arg_305_1._id == 13590 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterInNatureCards(arg_305_0:getBattleCardsByMaxOriginAtk("G", var_305_2), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13593 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterInTypeCards(arg_305_0:getBattleCardsByKeyword("GL", var_305_1._refCards[1]), Data.CardType.monster)), 1
	elseif arg_305_1._id == 13594 then
		return true, arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCardsByKeyword("GL", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13595 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByNature("P", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13596 then
		local var_305_35 = B.filterNotSameNameCards(arg_305_0:getBattleCardsByKeyword("GL", var_305_1._refCards[1]), arg_305_1._owner)

		return true, var_305_35, math.min(#var_305_35, 2)
	elseif arg_305_1._id == 13598 then
		return true, B.filterNotSameNameCards(arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByKeyword("GL", var_305_1._refCards[1])), arg_305_1._owner), 1
	elseif arg_305_1._id == 13599 or arg_305_1._id == 13701 then
		local var_305_36 = var_305_0:getBattleCards("G")

		return true, var_305_36, math.min(#var_305_36, 2)
	elseif arg_305_1._id == 13600 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByNature("BG", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13607 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsBy13607(arg_305_1._owner)), 1
	elseif arg_305_1._id == 13612 then
		return true, B.filterUniqueIdCards(B.mergeTable({
			arg_305_0:getBattleCardsByNature("G", var_305_1._refCards[1]),
			arg_305_0:getBattleCardsByCategory("G", var_305_1._refCards[2])
		})), 1
	elseif arg_305_1._id == 13613 then
		return true, B.filterQualityLessThanCards(arg_305_0:getBattleCardsByType("L", Data.CardType.monster), var_305_1._refCards[2]), 1
	elseif arg_305_1._id == 13614 then
		local var_305_37 = var_305_0:getBattleCards("G")

		return true, var_305_37, math.min(#var_305_37, 2)
	elseif arg_305_1._id == 13618 then
		return true, arg_305_0:filterCanChangeToHandCards(B.mergeTable({
			arg_305_0:getBattleCardsByKeyword("CSD", var_305_1._refCards[1]),
			B.filterInKeywordCards(arg_305_0:getBattleCardsByTypeGroup("G", {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_305_1._refCards[1])
		})), 1
	elseif arg_305_1._id == 13619 or arg_305_1._id == 7682 then
		local var_305_38 = arg_305_0:getBattleCardsByKeyword("L", var_305_1._refCards[1])

		return true, var_305_38, math.min(#var_305_38, 2)
	elseif arg_305_1._id == 13625 then
		return true, arg_305_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("GL", Data.CardType.monster), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13635 then
		local var_305_39 = B.filterUniqueIdCards(B.mergeTable({
			arg_305_0:getBattleCardsByKeyword("L", var_305_1._refCards[1]),
			arg_305_0:getBattleCardsByNature("L", var_305_1._refCards[2])
		}))

		return true, var_305_39, math.min(#var_305_39, 2)
	elseif arg_305_1._id == 13637 then
		return true, B.sortCardsByBoardPos(B.filterInNatureCards(arg_305_0:getBattleCardsByMinStar("HB", 0), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13644 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByStar("P", 1), var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13645 then
		return true, arg_305_0:getBattleCardsByCategoryGroup("G", var_305_1._refCards), 2
	elseif arg_305_1._id == 13650 then
		return true, B.filterInCategoryCards(arg_305_0:getBattleCardsByNatureGroup("G", {
			var_305_1._refCards[1],
			var_305_1._refCards[2]
		}), var_305_1._refCards[3]), 1
	elseif arg_305_1._id == 13651 then
		return true, B.sortCardsByBoardPos(arg_305_0:getBattleCardsByCategoryAndNature("P", var_305_1._refCards[1], var_305_1._refCards[2])), 1
	elseif arg_305_1._id == 13658 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterInTypeCards(arg_305_0:getBattleCardsByCategoryAndNature("G", var_305_1._refCards[2], var_305_1._refCards[1]), Data.CardType.monster)), 1
	elseif arg_305_1._id == 13660 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_305_0:getBattleCardsByKeyword("R", var_305_1._refCards[2]), true)), 1
	elseif arg_305_1._id == 13661 or arg_305_1._id == 13662 then
		local var_305_40 = arg_305_0:getBattleCardsByMaxStar("P", arg_305_1._owner:getStar())

		return true, var_305_40, math.min(#var_305_40, 2)
	elseif arg_305_1._id == 13671 then
		return true, B.filterNoShieldCards(var_305_0:getBattleCards("BCSD"), BattleData.PositiveType.shieldMonster, var_305_2 <= #B.filterLinkCards(arg_305_0:getBattleCards("R"), true)), 1
	elseif arg_305_1._id == 13676 then
		return true, B.sortCardsByBoardPos(B.filterSameNatureCards(var_305_0:getBoardCards(), arg_305_1._owner)), 1
	elseif arg_305_1._id == 13678 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(B.filterUniqueIdCards(B.mergeTable({
			arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[1]),
			arg_305_0:getBattleCardsByType("B", Data.CardType.rare)
		})))), 2
	elseif arg_305_1._id == 13681 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_305_0:getBattleCardsByMinStar("B", 0), var_305_1._refCards[1])), 2
	elseif arg_305_1._id == 13684 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(B.filterXYZCards(arg_305_0:getBattleCardsByKeyword("B", var_305_1._refCards[1]), true))), 1
	elseif arg_305_1._id == 13686 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterXYZCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByMaxXYZStar("G", var_305_2), var_305_1._refCards[1]), true)), 1
	elseif arg_305_1._id == 13702 then
		local var_305_41 = var_305_0:filterCanChangeToHandCards(var_305_0:getBattleCards("BCSD"))

		return true, B.sortCardsByBoardPos(var_305_41), math.min(2, #var_305_41)
	elseif arg_305_1._id == 13703 then
		return true, arg_305_0:getBattleCardsBy13703(), 1
	elseif arg_305_1._id == 13707 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.mergeTable({
			B.sortCardsByBoardPos(B.filterNormalCards(arg_305_0._graveCards)),
			B.sortCardsByBoardPos(B.filterNormalCards(var_305_0._graveCards))
		})), 1
	elseif arg_305_1._id == 13709 then
		local var_305_42 = arg_305_0:getBattleCardsByType(arg_305_0:getEmptyBoardPos() == nil and "B" or "HBP", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_305_1._owner)
		local var_305_43 = B.mergeTable({
			B.filterNormalCards(var_305_42),
			B.filterDualCards(var_305_42)
		})

		return true, B.sortCardsByBoardPos(var_305_43), 1
	elseif arg_305_1._id == 13710 then
		return true, B.filterCanBeSacrificedCards(B.filterNotActionedCards(B.filterEffectCards(arg_305_0:getBoardCards()))), 1
	elseif arg_305_1._id == 13719 then
		return true, arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCards("H")), 0
	elseif arg_305_1._id == 13726 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterNotInKeywordCards(arg_305_0:getBattleCardsByCategory("P", var_305_1._refCards[2]), var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13733 then
		local var_305_44 = arg_305_0:getBattleCardsByKeyword("H", var_305_1._refCards[1])

		return true, var_305_44, math.min(#var_305_44, 3)
	elseif arg_305_1._id == 13739 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.mergeTable({
			arg_305_0:getBattleCardsByMaxStar("H", var_305_2),
			B.filterInKeywordCards(arg_305_0:getBattleCardsByMaxStar("G", var_305_2), var_305_1._refCards[1])
		})), 1
	elseif arg_305_1._id == 13740 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByMaxStar("HG", var_305_2)), 1
	elseif arg_305_1._id == 13746 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByMaxStar("G", var_305_2), nil, nil, nil, true), 1
	elseif arg_305_1._id == 13750 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByMaxStar("GL", var_305_2), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13766 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("HB", Data.CardType.monster), var_305_1._refCards[1]))), 1
	elseif arg_305_1._id == 13767 then
		return true, B.filterCanBeSacrificedCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByTypeGroup("HCSD", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13774 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToBoardCards(B.mergeTable({
			B.filterNormalCards(arg_305_0:getBattleCards("PG")),
			B.filterDualCards(arg_305_0:getBattleCards("PG"))
		}))), 1
	elseif arg_305_1._id == 13777 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("PH", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_305_1._owner), var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13782 then
		return true, arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCardsByInfoId("L", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13783 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_305_0:getBattleCardsByMaxStarOrLevel("B", var_305_2), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_305_1._id == 13786 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(arg_305_0:getBattleCardsByHp("P", var_305_2))), 1
	elseif arg_305_1._id == 13807 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotActionedCards(arg_305_0:getBattleCardsByNature("B", var_305_1._refCards[1])))), 1
	elseif arg_305_1._id == 13815 then
		local var_305_45 = var_305_0:getBoardCards()

		return true, B.sortCardsByBoardPos(var_305_45), math.min(2, #var_305_45)
	elseif arg_305_1._id == 13817 then
		return true, arg_305_0:getBattleCardsByCategoryGroup("BHG", var_305_1._refCards, Data.CARD_MAX_LEVEL, arg_305_1._owner), 2
	elseif arg_305_1._id == 13818 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_305_0:getBattleCardsByKeyword("LP", var_305_1._refCards[1]), arg_305_1._owner))), 1
	elseif arg_305_1._id == 13823 then
		return true, B.filterInKeywordGroupCards(arg_305_0:getBattleCardsByType("L", Data.CardType.monster), var_305_1._refCards), 1
	elseif arg_305_1._id == 13833 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByMaxStar("H", var_305_2), var_305_1._refCards[1]), nil, nil, nil, true), 1
	elseif arg_305_1._id == 13836 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_305_0:getBattleCardsByType("P", Data.CardType.monster), var_305_1._refCards))), 1
	elseif arg_305_1._id == 13838 then
		local var_305_46 = var_305_0:getBoardCards()

		return true, B.sortCardsByBoardPos(var_305_46), math.min(2, #var_305_46)
	elseif arg_305_1._id == 13839 then
		return true, arg_305_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_305_0:getBattleCardsByCategory("GL", var_305_1._refCards[1]), true)), 1
	elseif arg_305_1._id == 13844 or arg_305_1._id == 13954 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByMaxStar("P", var_305_2), var_305_1._refCards[1]), arg_305_1._owner))), 1
	elseif arg_305_1._id == 13845 then
		return true, B.filterNotSameNameCards(B.filterInCategoryCards(arg_305_0:getBattleCardsByMaxStar("L", var_305_2), var_305_1._refCards[1]), arg_305_1._owner), 1
	elseif arg_305_1._id == 13847 then
		return true, B.mergeTable({
			arg_305_0:getBattleCardsByType("G", Data.CardType.trap),
			arg_305_0:getBattleCardsByCategory("G", var_305_1._refCards[1])
		}), 1
	elseif arg_305_1._id == 13859 then
		return true, arg_305_0:filterCanChangeToBoardCards(arg_305_0:getBattleCardsByKeyword("G", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13870 then
		local var_305_47 = var_305_0._graveCards

		return true, var_305_47, math.min(2, #var_305_47)
	elseif arg_305_1._id == 13872 then
		return true, arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByType("L", Data.CardType.monster), var_305_1._refCards[2]), arg_305_1._owner)), 1
	elseif arg_305_1._id == 13874 then
		return true, arg_305_0:filterCanChangeToBoardCards(var_305_0:getBattleCardsByMaxQuality("G", var_305_1._refCards[1])), 1
	elseif arg_305_1._id == 13876 then
		return true, arg_305_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_305_0:getBattleCardsByTypeGroup("L", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_305_1._refCards[2])), 1
	elseif arg_305_1._id == 13897 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			B.filterNormalCards(arg_305_0:getBattleCardsByMinStar("HP", var_305_2)),
			arg_305_0:getBattleCardsByInfoId("HP", var_305_1._refCards[1])
		})), 1
	elseif arg_305_1._id == 13898 then
		return true, B.sortCardsByBoardPos(arg_305_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_305_0:getBattleCardsByKeyword("GP", var_305_1._refCards[1]), arg_305_1._owner))), 1
	else
		return arg_305_0:isGraveSkill3(arg_305_1, arg_305_2, arg_305_3)
	end
end

function var_0_0.isGraveSkill3(arg_306_0, arg_306_1, arg_306_2, arg_306_3)
	if arg_306_1 == nil then
		return false
	end

	if arg_306_3 ~= (B.skillHasMode(arg_306_1, Data.SkillMode.initiative_bcs) or B.skillHasMode(arg_306_1, Data.SkillMode.initiative_grave) or B.skillHasMode(arg_306_1, Data.SkillMode.initiative_hand) or B.skillHasMode(arg_306_1, Data.SkillMode.initiative_rare) or B.skillHasMode(arg_306_1, Data.SkillMode.initiative_leave)) then
		return false
	end

	local var_306_0 = arg_306_0._opponent
	local var_306_1 = Data._skillInfo[arg_306_1._id]
	local var_306_2 = var_306_1._val[math.min(arg_306_1._level, #var_306_1._val)] or 0

	if arg_306_1._id == 13902 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("HP", var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 13909 or arg_306_1._id == 13946 then
		return true, var_306_0:getBattleCardsByMaxQuality("L", var_306_1._refCards[1]), 1
	elseif arg_306_1._id == 13917 then
		local var_306_3 = arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1]))

		return true, var_306_3, math.min(math.min(2, #var_306_3), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 13921 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategory("HP", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 13925 then
		local var_306_4 = arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("G", Data.CardType.monster), var_306_1._refCards[1]))

		return true, var_306_4, math.min(2, #var_306_4)
	elseif arg_306_1._id == 13926 or arg_306_1._id == 13933 then
		local var_306_5 = arg_306_0:getBattleCardsByKeyword("L", var_306_1._refCards[1])

		return true, var_306_5, math.min(2, #var_306_5)
	elseif arg_306_1._id == 13939 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterXYZCards(arg_306_0:getBattleCardsByKeyword("R", var_306_1._refCards[1]), true), true, true, nil, true), 1
	elseif arg_306_1._id == 13943 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]), arg_306_1._owner),
			arg_306_0:getBattleCardsByInfoId("P", var_306_1._refCards[2])
		}))), 1
	elseif arg_306_1._id == 13944 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterNormalCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]), true), nil, nil, nil, true)), 1
	elseif arg_306_1._id == 13949 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMinStar("G", 0), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 13950 then
		return true, arg_306_0:filterCanChangeToBoardCards(var_306_0:getBattleCardsByMinStar("G", 0)), 1
	elseif arg_306_1._id == 13951 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 13957 or arg_306_1._id == 7724 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByInfoId("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 13958 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 13959 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordGroupCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards)), 1
	elseif arg_306_1._id == 13962 then
		local var_306_6 = arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("H", var_306_2), var_306_1._refCards[1]))

		return true, var_306_6, math.min(math.min(2, #var_306_6), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 13963 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 13965 then
		return true, arg_306_0:getBattleCardsByType("G", Data.CardType.monster), 1
	elseif arg_306_1._id == 13966 then
		return true, B.mergeTable({
			B.filterLinkCards(arg_306_0:getBattleCardsByType("G", Data.CardType.rare), false),
			B.filterCeremonyMonsterCards(arg_306_0:getBattleCardsByType("G", Data.CardType.monster))
		}), 1
	elseif arg_306_1._id == 13970 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterDieByAttackOrEffectCards(B.filterOnGraveEndRoundCards(arg_306_0._graveCards, arg_306_0._endRound))), 1
	elseif arg_306_1._id == 13972 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByMaxQuality("BCSD", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 13977 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByCategoryAndNature("P", var_306_1._refCards[2], var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 13979 then
		return true, arg_306_0:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_306_1._owner), 1
	elseif arg_306_1._id == 13985 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 13988 then
		return true, arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByCategoryAndNature("G", var_306_1._refCards[2], var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 13992 then
		return true, B.filterInTypeCards(var_306_0:getBattleCardsByMaxQuality("G", var_306_1._refCards[1]), Data.CardType.monster), 1
	elseif arg_306_1._id == 13993 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("HP", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_306_1._owner), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 13994 then
		local var_306_7 = arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("L", var_306_1._refCards[1]))

		return true, var_306_7, math.min(math.min(2, #var_306_7), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 13995 then
		return true, arg_306_0:getBattleCardsBy13995(), 1
	elseif arg_306_1._id == 13998 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("GP", {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_306_1._refCards[1]),
			arg_306_0:getBattleCardsByKeyword("GP", var_306_1._refCards[2])
		}))), 1
	elseif arg_306_1._id == 14001 then
		local var_306_8 = B.filterLinkCards(var_306_0:getBattleCardsByType("G", Data.CardType.monster), false)

		return true, var_306_8, math.min(2, #var_306_8)
	elseif arg_306_1._id == 14002 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			arg_306_0:getBattleCardsByMaxQuality("B", var_306_1._refCards[1]),
			B.filterInTypeCards(arg_306_0:getBattleCardsByMaxQuality("H", var_306_1._refCards[1]), Data.CardType.monster)
		})), 1
	elseif arg_306_1._id == 14004 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("P", {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_306_1._refCards[1]),
			arg_306_0:getBattleCardsByInfoId("P", var_306_1._refCards[2])
		}))), 1
	elseif arg_306_1._id == 14005 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14009 then
		return true, var_306_0._graveCards, 1
	elseif arg_306_1._id == 14010 then
		local var_306_9 = #B.filterAdjustCards(arg_306_0:getBattleCardsByType("G", Data.CardType.monster), true)
		local var_306_10 = B.filterNoShieldCards(var_306_0:getBattleCards("BSD"), BattleData.PositiveType.shieldMonster, true)

		return true, var_306_10, math.min(#var_306_10, var_306_9)
	elseif arg_306_1._id == 14011 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterAdjustCards(arg_306_0:getBattleCardsByType("G", Data.CardType.monster), true)), 1
	elseif arg_306_1._id == 14012 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14015 then
		local var_306_11 = arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeywordGroup("H", var_306_1._refCards))

		return true, var_306_11, math.min(math.min(2, #var_306_11), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 14016 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeywordGroup("P", {
			var_306_1._refCards[1],
			var_306_1._refCards[2]
		}))), 1
	elseif arg_306_1._id == 14018 then
		local var_306_12 = B.sortCardsByBoardPos(var_306_0:filterCanChangeToHandCards(var_306_0:getBattleCards("BCSD")))

		return true, var_306_12, math.min(2, #var_306_12)
	elseif arg_306_1._id == 14019 then
		return true, B.filterLinkCards(var_306_0:getBattleCardsByType("G", Data.CardType.monster), false), 1
	elseif arg_306_1._id == 14020 then
		return true, arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1]), 1
	elseif arg_306_1._id == 14021 then
		return true, B.sortCardsByBoardPos(B.filterUniqueIdCards(B.mergeTable({
			B.filterSyncCards(B.filterAdjustCards(arg_306_0:getBattleCardsByType("BG", Data.CardType.monster), true), true),
			B.filterInKeywordCards(arg_306_0:getBattleCardsByType("BG", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_306_1._owner), var_306_1._refCards[1])
		}))), 2
	elseif arg_306_1._id == 14024 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14025 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByCategoryAndNature("P", var_306_1._refCards[2], var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14026 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByStar("P", 3), var_306_1._refCards[2]))), 1
	elseif arg_306_1._id == 14027 then
		return true, B.sortCardsByBoardPos(var_306_0:getBoardCards()), 1
	elseif arg_306_1._id == 14029 then
		return true, var_306_0._graveCards, 1
	elseif arg_306_1._id == 14030 then
		return true, B.mergeTable({
			arg_306_0:filterCanChangeToBoardCards(B.filterInTypeCards(var_306_0:getBattleCardsByMaxQuality("G", var_306_1._refCards[1]), Data.CardType.monster)),
			arg_306_0:filterCanChangeToHandCards(B.filterInTypeGroupCards(var_306_0:getBattleCardsByMaxQuality("G", var_306_1._refCards[1]), {
				Data.CardType.magic,
				Data.CardType.trap
			}))
		}), 1
	elseif arg_306_1._id == 14036 then
		return true, arg_306_0:getBattleCardsByType("CSH", Data.CardType.trap), 1
	elseif arg_306_1._id == 14040 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1]), arg_306_1._owner), nil, true), 1
	elseif arg_306_1._id == 14042 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotInStarCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]), arg_306_1._owner._info._star))), 1
	elseif arg_306_1._id == 14044 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14047 then
		return true, arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14048 then
		return true, B.sortCardsByBoardPos(B.filterLinkCards(var_306_0:getBattleCardsByMaxQuality("B", var_306_1._refCards[1]), false)), 1
	elseif arg_306_1._id == 14049 then
		return true, B.sortCardsByBoardPos(var_306_0:getBoardCards()), 1
	elseif arg_306_1._id == 14051 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByKeyword("L", var_306_1._refCards[1]),
			arg_306_0:getBattleCardsByCategory("L", var_306_1._refCards[2])
		}))), 1
	elseif arg_306_1._id == 14056 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_306_0:getBoardCards(), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_306_1._id == 14057 then
		return true, B.filterUniqueIdCards(B.mergeTable({
			B.filterInKeywordCards(arg_306_0:getBattleCardsByType("H", Data.CardType.monster), var_306_1._refCards[1]),
			arg_306_0:getBattleCardsByCategory("H", var_306_1._refCards[2])
		})), 1
	elseif arg_306_1._id == 14064 then
		return true, arg_306_0:getBattleCardsByType("G", Data.CardType.magic), 1
	elseif arg_306_1._id == 14069 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(arg_306_0:getBoardCards(), true)), 1
	elseif arg_306_1._id == 14071 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeywordGroup("G", var_306_1._refCards)), 1
	elseif arg_306_1._id == 14072 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByMinStar("B", 0)), 1
	elseif arg_306_1._id == 14073 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards))), 1
	elseif arg_306_1._id == 14074 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByKeywordGroup("B", var_306_1._refCards, Data.CARD_MAX_LEVEL, arg_306_1._owner)), 1
	elseif arg_306_1._id == 14081 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategory("H", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14082 then
		return true, B.sortCardsByBoardPos(var_306_0:getBattleCards("BCSD")), 1
	elseif arg_306_1._id == 14083 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByKeywordGroup("B", var_306_1._refCards)), 1
	elseif arg_306_1._id == 14089 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeywordGroup("P", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14090 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByKeywordGroup("P", var_306_1._refCards)), 1
	elseif arg_306_1._id == 14091 then
		return true, B.sortCardsByBoardPos(B.filterCanActionCards(arg_306_0:getBattleCardsByInfoId("B", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14093 then
		return true, var_306_0._graveCards, 1
	elseif arg_306_1._id == 14097 then
		local var_306_13 = B.filterInTypeGroupCards(arg_306_0:getBattleCardsByMaxQuality("G", var_306_1._refCards[1]), {
			Data.CardType.monster,
			Data.CardType.rare
		})

		return true, var_306_13, math.min(2, #var_306_13)
	elseif arg_306_1._id == 14098 then
		local var_306_14 = B.filterInTypeGroupCards(var_306_0:getBattleCardsByMaxQuality("G", var_306_1._refCards[1]), {
			Data.CardType.monster,
			Data.CardType.rare
		})

		return true, var_306_14, math.min(2, #var_306_14)
	elseif arg_306_1._id == 14099 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("H", var_306_2), var_306_1._refCards[1]), nil, nil, nil, true), 1
	elseif arg_306_1._id == 14100 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMaxStar("H", var_306_2), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14103 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMinStar("HG", var_306_2), var_306_1._refCards[1]), nil, nil, nil, true), 1
	elseif arg_306_1._id == 14104 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("H", var_306_2, Data.CARD_MAX_LEVEL, arg_306_1._owner), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14106 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("G", var_306_2), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14107 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMinStar("H", var_306_2), var_306_1._refCards[1]), nil, nil, nil, true), 1
	elseif arg_306_1._id == 14108 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMaxStar("H", var_306_2), var_306_1._refCards[1]), nil, nil, nil, true), 1
	elseif arg_306_1._id == 14109 then
		return true, arg_306_0:getBattleCardsByMinStar("H", var_306_2), 1
	elseif arg_306_1._id == 14110 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByStarOrLevelGroup("L", {
			var_306_2
		}), var_306_1._refCards[1]), arg_306_1._owner)), 1
	elseif arg_306_1._id == 14112 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14113 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14114 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_306_0:getBattleCards("BCSD"), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_306_1._id == 14115 then
		return true, B.sortCardsByBoardPos(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1]),
			arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[2])
		}))), 1
	elseif arg_306_1._id == 14116 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByStarOrLevelGroup("HG", {
			var_306_2
		}), var_306_1._refCards[1]), nil, nil, nil, true), 1
	elseif arg_306_1._id == 14117 then
		return true, B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("H", var_306_2), var_306_1._refCards[1]), 1
	elseif arg_306_1._id == 14120 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByCategory("H", var_306_1._refCards[1]), arg_306_1._owner), nil, nil, nil, true), 1
	elseif arg_306_1._id == 14121 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("HG", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14122 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_306_0:getBattleCards("BCSD"), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_306_1._id == 14125 then
		local var_306_15 = arg_306_0:filterCanChangeToBoardCards(B.filterInTypeCards(var_306_0._graveCards, Data.CardType.monster))

		return true, var_306_15, math.min(math.min(2, #var_306_15), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 14126 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_306_0:getBoardCards())), 2
	elseif arg_306_1._id == 14127 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("HG", var_306_1._refCards[1]), nil, nil, nil, arg_306_1._owner._status == BattleData.CardStatus.board), 1
	elseif arg_306_1._id == 14132 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByNature("G", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14134 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterCeremonyMonsterCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster)),
			B.filterCeremonyMagicCards(arg_306_0:getBattleCardsByType("P", Data.CardType.magic))
		}))), 2
	elseif arg_306_1._id == 14138 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByCategoryGroup("P", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14139 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInStarCards(arg_306_0:getBattleCardsByCategoryGroup("P", var_306_1._refCards), var_306_2), nil, nil, nil, true)), 1
	elseif arg_306_1._id == 14140 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterMergeCards(arg_306_0:getBattleCardsByKeyword("R", var_306_1._refCards[1]), true), true, true), 1
	elseif arg_306_1._id == 14141 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByKeyword("B", var_306_1._refCards[1], Data.CARD_MAX_LEVEL, arg_306_1._owner)), 1
	elseif arg_306_1._id == 14142 then
		return true, B.filterMergeCards(arg_306_0:getBattleCardsByType("G", Data.CardType.rare)), 1
	elseif arg_306_1._id == 14143 then
		local var_306_16 = arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[1]), nil, nil, nil, true)

		return true, B.sortCardsByBoardPos(var_306_16), math.min(math.min(2, #var_306_16), arg_306_0:getEmptyBoardPosCount() + 1)
	elseif arg_306_1._id == 14144 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("HG", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14147 then
		return true, var_306_0._graveCards, 1
	elseif arg_306_1._id == 14148 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(B.filterNotInNatureCards(var_306_0:getBoardCards(), var_306_1._refCards[1]), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_306_1._id == 14154 then
		local var_306_17 = var_306_0:getBattleCards("BCSD")
		local var_306_18 = B.filterPendulumCards(arg_306_0:getBoardCards(), true)

		return true, B.sortCardsByBoardPos(var_306_17), math.min(#var_306_17, #var_306_18)
	elseif arg_306_1._id == 14155 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterPendulumCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), true))), 1
	elseif arg_306_1._id == 14157 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_306_0:getBoardCards(), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_306_1._id == 14158 then
		local var_306_19 = arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1]))

		return true, B.sortCardsByBoardPos(var_306_19), math.min(math.min(2, #var_306_19), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 14161 then
		return true, arg_306_0:getBattleCardsByCategoryGroup("H", var_306_1._refCards), 1
	elseif arg_306_1._id == 14162 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_306_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards))), 1
	elseif arg_306_1._id == 14163 then
		return true, arg_306_0:getBattleCardsByKeywordGroup("H", var_306_1._refCards, Data.CARD_MAX_LEVEL, arg_306_1._owner), 1
	elseif arg_306_1._id == 14168 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14169 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMinStar("HG", var_306_2), var_306_1._refCards[1]), nil, nil, nil, true), 1
	elseif arg_306_1._id == 14170 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14171 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeywordGroup("P", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14172 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByNature("P", var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14174 then
		local var_306_20 = arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("HP", var_306_1._refCards[1]), nil, true, nil, true)

		return true, B.sortCardsByBoardPos(var_306_20), math.min(math.min(2, #var_306_20), arg_306_0:getEmptyBoardPosCount() + 1)
	elseif arg_306_1._id == 14175 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByType("B", Data.CardType.rare)), 1
	elseif arg_306_1._id == 14176 then
		return true, arg_306_0:getBattleCardsBy14176(), 1
	elseif arg_306_1._id == 14177 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(B.filterLinkCards(arg_306_0:getBattleCardsByKeyword("B", var_306_1._refCards[1]), true))), 1
	elseif arg_306_1._id == 14180 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14182 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("H", var_306_1._refCards[1]), arg_306_1._owner), nil, nil, nil, true), 1
	elseif arg_306_1._id == 14185 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByType("P", Data.CardType.monster)), 1
	elseif arg_306_1._id == 14190 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInStarCards(arg_306_0:getBattleCardsByCategoryAndNature("P", var_306_1._refCards[2], var_306_1._refCards[1]), var_306_2), nil, nil, nil, true)), 1
	elseif arg_306_1._id == 14191 then
		return true, var_306_0._graveCards, 1
	elseif arg_306_1._id == 14196 then
		return true, B.sortCardsByBoardPos(var_306_0:getBoardCards()), 1
	elseif arg_306_1._id == 14197 then
		return true, B.sortCardsByBoardPos(var_306_0:getBattleCards("BCSD")), 1
	elseif arg_306_1._id == 14199 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("G", Data.CardType.monster), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14201 then
		local var_306_21 = var_306_0:filterCanChangeToHandCards(var_306_0:getBattleCards("BCSD"))

		return true, B.sortCardsByBoardPos(var_306_21), math.min(3, #var_306_21)
	elseif arg_306_1._id == 14202 then
		local var_306_22 = arg_306_0:getBattleCardsByMaxQuality("B", var_306_1._refCards[1])

		return true, B.sortCardsByBoardPos(var_306_22), math.min(2, #var_306_22)
	elseif arg_306_1._id == 14204 or arg_306_1._id == 14205 or arg_306_1._id == 14206 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByStarOrLevel("G", var_306_2), var_306_1._refCards[1]), nil, true, nil, true), 1
	elseif arg_306_1._id == 14209 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14210 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMinStar("P", var_306_2), var_306_1._refCards[1]), nil, true)), 1
	elseif arg_306_1._id == 14212 then
		return true, B.sortCardsByBoardPos(B.filterFieldMagicCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14213 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_306_0:getBattleCardsByMinStar("B", 0), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14214 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMaxStar("G", var_306_2), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14215 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMaxStar("L", var_306_2), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14217 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14219 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(B.filterInTypeCards(arg_306_0:getBattleCardsByKeyword("B", var_306_1._refCards[1]), Data.CardType.monster))), 2
	elseif arg_306_1._id == 14220 then
		return true, var_306_0._graveCards, 2
	elseif arg_306_1._id == 14221 then
		return true, B.filterInKeywordCards(arg_306_0:getBattleCardsByType("G", Data.CardType.monster), var_306_1._refCards[1]), 2
	elseif arg_306_1._id == 14223 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14224 then
		local var_306_23 = arg_306_0:filterCanChangeToBoardCards(B.filterInTypeCards(arg_306_0:getBattleCardsByKeyword("GL", var_306_1._refCards[1]), Data.CardType.monster), nil, true)

		return true, var_306_23, math.min(math.min(2, #var_306_23), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 14225 then
		return true, B.sortCardsByBoardPos(B.filterFieldMagicCards(arg_306_0:getBattleCardsByType("P", Data.CardType.magic))), 1
	elseif arg_306_1._id == 14233 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14238 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMaxStar("G", var_306_2), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14239 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]), nil, true)), 1
	elseif arg_306_1._id == 14240 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInTypeCards(var_306_0:getBattleCardsByMaxQuality("L", var_306_1._refCards[1]), Data.CardType.monster)), 1
	elseif arg_306_1._id == 14245 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMaxStar("GL", var_306_2), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14246 then
		return true, B.sortCardsByBoardPos(B.filterOppoCards(arg_306_0:getBattleCardsByMaxQuality("B", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14251 then
		local var_306_24 = var_306_0:getBoardCards()

		return true, var_306_24, math.min(2, #var_306_24)
	elseif arg_306_1._id == 14252 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14258 then
		return true, B.filterInKeywordCards(arg_306_0:getBattleCardsByType("H", Data.CardType.monster), var_306_1._refCards[1]), 1
	elseif arg_306_1._id == 14260 then
		local var_306_25 = arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("H", var_306_1._refCards[1]), nil, true)

		return true, var_306_25, math.min(math.min(2, #var_306_25), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 14261 then
		local var_306_26 = arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]), nil, true)

		return true, B.sortCardsByBoardPos(var_306_26), math.min(2, #var_306_26)
	elseif arg_306_1._id == 14263 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsBy14263(arg_306_1._owner)), 1
	elseif arg_306_1._id == 14264 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterEquipMagicCards(arg_306_0:getBattleCardsByType("P", Data.CardType.magic)))), 1
	elseif arg_306_1._id == 14266 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14267 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.magic), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14269 then
		return true, B.sortCardsByBoardPos(var_306_0:getBoardCards()), 1
	elseif arg_306_1._id == 14270 then
		return true, B.sortCardsByBoardPos(var_306_0:filterCanChangeToHandCards(var_306_0:getBattleCards("BCSD"))), 1
	elseif arg_306_1._id == 14273 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1]), arg_306_1._owner)), 1
	elseif arg_306_1._id == 14274 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14275 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("H", Data.CardType.monster), var_306_1._refCards[1]), arg_306_1._owner)), 1
	elseif arg_306_1._id == 14282 then
		return true, arg_306_0:getBattleCardsByCategory("H", var_306_1._refCards[1], Data.CARD_MAX_LEVEL, arg_306_1._owner), 1
	elseif arg_306_1._id == 14283 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByStar("P", var_306_2), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14286 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14287 then
		return true, var_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1]), 1
	elseif arg_306_1._id == 14288 then
		return true, B.filterLinkCardsByMaxLink(var_306_0:getBoardCards(), var_306_2), 2
	elseif arg_306_1._id == 14289 then
		return true, B.sortCardsByBoardPos(B.filterFieldMagicCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14290 then
		return true, arg_306_0:getBattleCardsByType("H", Data.CardType.monster), 1
	elseif arg_306_1._id == 14291 then
		return true, arg_306_0:getBattleCardsByTypeGroup("H", {
			Data.CardType.magic,
			Data.CardType.trap
		}), 1
	elseif arg_306_1._id == 14292 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("PG", Data.CardType.monster), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14293 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMaxStar("PR", var_306_2), var_306_1._refCards[1]), true, true, nil, true)), 1
	elseif arg_306_1._id == 14294 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_306_0:filterCanChangeToHandCards(var_306_0:getBoardCards()), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_306_1._id == 14297 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByCategoryGroup("G", {
				var_306_1._refCards[1],
				var_306_1._refCards[2]
			}, Data.CARD_MAX_LELVEL, arg_306_1._owner),
			B.filterInNatureCards(arg_306_0:getBattleCardsByStar("G", var_306_2, Data.CARD_MAX_LELVEL, arg_306_1._owner), var_306_1._refCards[3])
		}))), 1
	elseif arg_306_1._id == 14298 then
		return true, B.filterInTypeCards(var_306_0:getBattleCardsByMaxQuality("G", var_306_1._refCards[1]), Data.CardType.monster), 1
	elseif arg_306_1._id == 14299 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.trap), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14300 then
		return true, var_306_0:getBattleCards("CSD"), 1
	elseif arg_306_1._id == 14301 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByNature("G", var_306_1._refCards[1]),
			arg_306_0:getBattleCardsByCategory("G", var_306_1._refCards[2]),
			var_306_0:getBattleCardsByNature("G", var_306_1._refCards[1]),
			var_306_0:getBattleCardsByCategory("G", var_306_1._refCards[2])
		}))), 1
	elseif arg_306_1._id == 14302 then
		local var_306_27 = B.mergeTable({
			arg_306_0._graveCards,
			var_306_0._graveCards
		})

		return true, var_306_27, math.min(2, #var_306_27)
	elseif arg_306_1._id == 14303 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14307 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("H", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14308 then
		local var_306_28 = var_306_0:getBoardCards()

		return true, B.sortCardsByBoardPos(var_306_28), math.min(#var_306_28, #arg_306_0:getBattleCardsByInfoId("G", var_306_1._refCards[1]))
	elseif arg_306_1._id == 14312 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterLinkCards(var_306_0:getBattleCardsByMaxQuality("B", var_306_1._refCards[1]), false))), 1
	elseif arg_306_1._id == 14314 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			var_306_0:getBattleCards("BCSD"),
			arg_306_0:getBattleCards("BCSD")
		})), 1
	elseif arg_306_1._id == 14317 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByAtkDef("PGLH", 2500, 2100), true, true)), 1
	elseif arg_306_1._id == 14322 then
		return true, B.filterNotSameNameCards(arg_306_0:getBattleCardsByCategory("L", var_306_1._refCards[1]), arg_306_1._owner), 1
	elseif arg_306_1._id == 14325 then
		return true, B.sortCardsByBoardPos(B.filterInCategoryCards(arg_306_0:getBattleCardsByMinStar("B", 0), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14326 then
		return true, arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeyword("GL", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14327 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategory("HG", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14329 then
		return true, B.filterNotSameNameCards(arg_306_0:getBattleCardsByCategory("L", var_306_1._refCards[1]), arg_306_1._owner), 1
	elseif arg_306_1._id == 14330 then
		return true, B.sortCardsByBoardPos(arg_306_1._owner:getLinkedCards(2)), 1
	elseif arg_306_1._id == 14331 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategoryAndNature("P", var_306_1._refCards[2], var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14332 then
		return true, B.filterOppoCards(arg_306_0:getBattleCardsByType("G", Data.CardType.monster)), 1
	elseif arg_306_1._id == 14336 then
		return true, B.filterAdjustCards(arg_306_0:getBattleCardsByType("H", Data.CardType.monster), true), 1
	elseif arg_306_1._id == 14337 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(arg_306_0:getBattleCardsByKeyword("B", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14338 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14341 then
		return true, B.filterInTypeGroupCards(arg_306_0._graveCards, {
			Data.CardType.magic,
			Data.CardType.trap
		}), 1
	elseif arg_306_1._id == 14342 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterInTypeCards(var_306_0:getBattleCardsByMaxQuality("G", var_306_1._refCards[1]), Data.CardType.magic)), 1
	elseif arg_306_1._id == 14345 then
		return true, B.sortCardsByBoardPos(var_306_0:getBoardCards()), 1
	elseif arg_306_1._id == 14347 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategoryGroup("P", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14348 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByCategoryGroup("P", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14352 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14355 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_306_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards))), 1
	elseif arg_306_1._id == 14356 then
		return true, B.filterXYZCards(arg_306_0:getBattleCardsByCategory("GL", var_306_1._refCards[1]), true), 1
	elseif arg_306_1._id == 14359 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategory("H", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14360 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("G", Data.CardType.trap), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14362 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeywordGroup("P", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14363 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByKeywordGroup("P", var_306_1._refCards)), 1
	elseif arg_306_1._id == 14364 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByMinStar("B", 0)), 1
	elseif arg_306_1._id == 14369 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14371 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("G", var_306_2), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14376 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14378 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByNature("G", var_306_1._refCards[1]), true, true), 1
	elseif arg_306_1._id == 14379 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_306_0:getBoardCards(), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_306_1._id == 14380 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("L", var_306_2), var_306_1._refCards[1]), arg_306_1._owner)), 1
	elseif arg_306_1._id == 14381 then
		return true, arg_306_0:getBattleCardsByCategory("G", var_306_1._refCards[1], Data.CARD_MAX_LEVEL, arg_306_1._owner), 1
	elseif arg_306_1._id == 14383 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("H", var_306_2), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14385 then
		return true, arg_306_0:filterCanChangeToBoardCards(var_306_0:getBattleCardsByNature("G", var_306_1._refCards[1]), true, true), 1
	elseif arg_306_1._id == 14393 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeywordGroup("P", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14394 then
		return true, B.sortCardsByBoardPos(var_306_0:getBattleCards("BCSD")), 1
	elseif arg_306_1._id == 14395 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14397 then
		return true, B.sortCardsByBoardPos(B.filterUniqueIdCards(B.mergeTable({
			B.filterNotSameNameCards(arg_306_0:getBattleCardsByNature("P", var_306_1._refCards[1]), arg_306_1._owner),
			arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[2])
		}))), 1
	elseif arg_306_1._id == 14398 then
		return true, arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14399 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByKeyword("B", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14400 then
		return true, arg_306_0:getBattleCardsBy14400(arg_306_1._owner), 2
	elseif arg_306_1._id == 14402 then
		return true, B.sortCardsByBoardPos(var_306_0:getBoardCards()), 1
	elseif arg_306_1._id == 14403 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14404 then
		return true, B.sortCardsByBoardPos(var_306_0:getBoardCards()), 1
	elseif arg_306_1._id == 14406 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByMaxStar("G", var_306_2))), 1
	elseif arg_306_1._id == 14407 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(arg_306_0:getBattleCardsByKeyword("B", var_306_1._refCards[1]), true)), 1
	elseif arg_306_1._id == 14410 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14411 then
		return true, arg_306_0._handCards, 1
	elseif arg_306_1._id == 14412 then
		local var_306_29 = arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1]), arg_306_1._owner))

		return true, var_306_29, math.min(2, #var_306_29)
	elseif arg_306_1._id == 14418 then
		local var_306_30 = arg_306_0:filterCanChangeToBoardCards(var_306_0:getBattleCardsByMaxQuality("L", var_306_1._refCards[1]))

		return true, var_306_30, math.min(math.min(2, #var_306_30), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 14421 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14424 then
		return true, var_306_0:getBattleCards("G"), 1
	elseif arg_306_1._id == 14425 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByKeywordGroup("G", {
				var_306_1._refCards[1],
				var_306_1._refCards[2]
			}),
			B.filterInCategoryCards(arg_306_0:getBattleCardsByStar("G", var_306_2), var_306_1._refCards[3])
		})), arg_306_1._owner)), 1
	elseif arg_306_1._id == 14430 then
		return true, B.sortCardsByBoardPos(B.filterInInfoIdCards(arg_306_0:getBattleCardsByMinBuffValue("B", true, BattleData.PositiveType.xyzMark, var_306_2), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14434 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterXYZCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1]), arg_306_1._owner), true)), 1
	elseif arg_306_1._id == 14435 then
		return true, arg_306_0:getBattleCardsByInfoId("G", var_306_1._refCards[1]), var_306_2
	elseif arg_306_1._id == 14436 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards))), 1
	elseif arg_306_1._id == 14441 then
		return true, arg_306_0:getBattleCardsByKeywordGroup("H", var_306_1._refCards), 1
	elseif arg_306_1._id == 14444 then
		return true, B.sortCardsByBoardPos(var_306_0:getBattleCards("BCSD")), 1
	elseif arg_306_1._id == 14448 then
		return true, arg_306_0:getBattleCardsByCategoryAndNature("H", var_306_1._refCards[2], var_306_1._refCards[1], Data.CARD_MAX_LEVEL, arg_306_1._owner), 1
	elseif arg_306_1._id == 14449 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByInfoIdGroup("G", var_306_1._refCards)), 1
	elseif arg_306_1._id == 14452 then
		local var_306_31 = arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]))

		return true, var_306_31, math.min(2, #var_306_31)
	elseif arg_306_1._id == 14458 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14459 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategory("H", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14461 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]),
			B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[2])
		})), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14463 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]),
			B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[2])
		})), arg_306_1._owner)), 1
	elseif arg_306_1._id == 14465 then
		return true, B.sortCardsByBoardPos(var_306_0:getBoardCards()), 1
	elseif arg_306_1._id == 14466 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByMinStar("B", var_306_2)), 1
	elseif arg_306_1._id == 14467 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterSyncCards(arg_306_0:getBattleCards("GL"), true)), 1
	elseif arg_306_1._id == 14470 then
		return true, B.filterSyncCards(arg_306_0:getBattleCardsByCategory("R", var_306_1._refCards[1], Data.CARD_MAX_LEVEL, arg_306_1._owner), true), 1
	elseif arg_306_1._id == 14471 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14474 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByKeyword("B", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14476 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14477 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByInfoId("HP", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14478 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_306_0:getBattleCardsByMinStar("B", 0), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14479 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInNatureCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByStarGroup("P", {
			7,
			8
		}), var_306_1._refCards[2]), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14480 then
		return true, var_306_0:filterCanChangeToHandCards(var_306_0:getBoardCards()), 1
	elseif arg_306_1._id == 14485 then
		return true, B.sortCardsByBoardPos(var_306_0:getBattleCards("BCSD")), 1
	elseif arg_306_1._id == 14488 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByAtkDef("P", 2500, 2100))), 1
	elseif arg_306_1._id == 14489 then
		local var_306_32 = B.filterLinkCardsByMaxLink(var_306_0:getBoardCards(), 2)

		return true, B.sortCardsByBoardPos(var_306_32), math.min(#var_306_32, 2)
	elseif arg_306_1._id == 14495 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeywordGroup("P", var_306_1._refCards), true, true)), 1
	elseif arg_306_1._id == 14496 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByInfoIdGroup("PG", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14499 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("BHP", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_306_1._owner), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14500 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards))), 1
	elseif arg_306_1._id == 14501 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterUniqueIdCards(B.mergeTable({
			B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("H", var_306_2), var_306_1._refCards[1]),
			arg_306_0:getBattleCardsByKeywordGroup("H", {
				var_306_1._refCards[2],
				var_306_1._refCards[3]
			})
		}))), 1
	elseif arg_306_1._id == 14506 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategory("HG", var_306_1._refCards[1], Data.CARD_MAX_LEVEL, arg_306_1._owner)), 1
	elseif arg_306_1._id == 14507 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14508 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[2]))), 1
	elseif arg_306_1._id == 14511 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategoryGroup("P", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14512 then
		return true, B.sortCardsByBoardPos(var_306_0:getBattleCards("BCSD")), 1
	elseif arg_306_1._id == 14515 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14517 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14522 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBoardCards()), 1
	elseif arg_306_1._id == 14523 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByStar("P", var_306_2), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14526 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterNotEqualInfoIdCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByStar("P", var_306_2), var_306_1._refCards[2]), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14528 then
		local var_306_33 = var_306_0:getBattleCards("BCSD")

		return true, B.sortCardsByBoardPos(var_306_33), math.min(#var_306_33, var_306_2)
	elseif arg_306_1._id == 14530 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.magic), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14531 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("G", Data.CardType.magic), var_306_1._refCards[2])), 1
	elseif arg_306_1._id == 14533 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14534 then
		return true, arg_306_0:getBattleCardsByCategory("H", var_306_1._refCards[1]), 1
	elseif arg_306_1._id == 14535 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByMaxStar("HG", var_306_2), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14537 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByMinStar("B", 0, Data.CARD_MAX_LEVEL, arg_306_1._owner)), 1
	elseif arg_306_1._id == 14540 then
		local var_306_34 = arg_306_0:getBattleCardsByMaxStar("P", var_306_2)
		local var_306_35 = arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(B.filterUniqueIdCards(B.mergeTable({
			B.filterInCategoryCards(var_306_34, var_306_1._refCards[1]),
			B.filterAllyMonsterCards(var_306_34)
		})), arg_306_1._owner))

		return true, B.sortCardsByBoardPos(var_306_35), 1
	elseif arg_306_1._id == 14542 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByCategoryAndNature("P", var_306_1._refCards[2], var_306_1._refCards[1]),
			B.filterInNatureCards(arg_306_0:getBattleCardsByStar("P", var_306_2), var_306_1._refCards[1])
		})), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14545 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategory("G", var_306_1._refCards[1], Data.CARD_MAX_LEVEL, arg_306_1._owner)), 1
	elseif arg_306_1._id == 14546 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14547 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByCategoryAndNature("L", var_306_1._refCards[2], var_306_1._refCards[1]), arg_306_1._owner)), 1
	elseif arg_306_1._id == 14548 then
		return true, B.sortCardsByBoardPos(var_306_0:filterCanChangeToHandCards(var_306_0:getBattleCards("BCSD"))), 1
	elseif arg_306_1._id == 14549 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterUniqueIdCards(B.mergeTable({
			B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[1]),
			B.filterAllyMonsterCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster))
		})))), 1
	elseif arg_306_1._id == 14551 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14554 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_306_0:getBoardCards(), BattleData.PositiveType.shieldMonster, true)), 1
	elseif arg_306_1._id == 14556 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByCategory("H", var_306_1._refCards[1]),
			B.filterAllyMonsterCards(arg_306_0:getBattleCardsByType("H", Data.CardType.monster))
		}))), 1
	elseif arg_306_1._id == 14557 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14559 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("HG", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14560 then
		return true, B.sortCardsByBoardPos(B.filterNotInKeywordCards(arg_306_0:getBattleCardsByNature("P", var_306_1._refCards[2]), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14561 then
		return true, arg_306_0:getBattleCardsByNature("G", var_306_1._refCards[1]), 1
	elseif arg_306_1._id == 14565 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByNature("P", var_306_1._refCards[1]),
			B.filterInTypeCards(arg_306_0:getBattleCardsByKeywordGroup("P", {
				var_306_1._refCards[2],
				var_306_1._refCards[3]
			}), Data.CardType.monster)
		})))), 1
	elseif arg_306_1._id == 14567 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByMinStar("B", 0)), 1
	elseif arg_306_1._id == 14568 then
		return true, B.mergeTable({
			arg_306_0._graveCards,
			var_306_0._graveCards
		}), 1
	elseif arg_306_1._id == 14570 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByNature("P", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14571 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterLinkCardsByMaxLink(arg_306_0:getBattleCardsByType("G", Data.CardType.monster, Data.CARD_MAX_LEVEL, arg_306_1._owner), 3)), 1
	elseif arg_306_1._id == 14575 then
		return true, B.sortCardsByBoardPos(B.filterXYZCards(arg_306_0:getBoardCards(), true)), 1
	elseif arg_306_1._id == 14576 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByHp("P", var_306_2), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14578 then
		return true, arg_306_0:getBattleCardsByNatureGroup("G", var_306_1._refCards), 1
	elseif arg_306_1._id == 14579 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterUniqueIdCards(B.mergeTable({
			B.filterInStarCards(arg_306_0:getBattleCardsByNatureGroup("P", {
				var_306_1._refCards[1],
				var_306_1._refCards[2]
			}), var_306_2),
			arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[3])
		})), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14580 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14581 then
		return true, B.sortCardsByBoardPos(B.filterCanBeSacrificedCards(B.filterNotActionedCards(B.filterInTypeCards(arg_306_0:getBattleCardsByCategory("B", var_306_1._refCards[1]), Data.CardType.monster)))), 1
	elseif arg_306_1._id == 14583 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInTypeCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]), Data.CardType.monster))), 1
	elseif arg_306_1._id == 14584 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14585 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByInfoIdGroup("P", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14586 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInNatureCards(arg_306_0:getBattleCardsByMaxOriginAtk("P", var_306_2), var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14588 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByInfoId("P", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14590 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("GL", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 14591 then
		local var_306_36 = var_306_0:getBattleCardsByMaxQuality("CSD", var_306_1._refCards[1])

		return true, var_306_36, math.min(2, #var_306_36)
	elseif arg_306_1._id == 14592 then
		return true, B.sortCardsByBoardPos(B.filterNotActionedCards(arg_306_0:getBattleCardsByInfoId("B", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 14593 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInNatureCards(arg_306_0:getBattleCardsByMaxHp("P", var_306_2), var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 14596 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByInfoIdGroup("P", var_306_1._refCards))), 1
	elseif arg_306_1._id == 14598 then
		return true, B.sortCardsByBoardPos(B.filterNotSameNameCards(arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1]), arg_306_1._owner)), 1
	elseif arg_306_1._id == 14602 then
		return true, B.sortCardsByBoardPos(B.filterUniqueIdCards(B.mergeTable({
			arg_306_0:getBattleCardsByCategory("P", var_306_1._refCards[1]),
			B.filterInTypeCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[2]), Data.CardType.monster)
		}))), 1
	elseif arg_306_1._id == 14603 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInTypeCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]), Data.CardType.magic))), 1
	elseif arg_306_1._id == 14604 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("R", var_306_1._refCards[1]), true, true), 1
	elseif arg_306_1._id == 14606 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategoryGroup("G", var_306_1._refCards, Data.CARD_MAX_LEVEL, arg_306_1._owner)), 1
	elseif arg_306_1._id == 14607 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByInfoId("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 5642 then
		local var_306_37 = B.filterNoShieldCards(var_306_0:getBattleCardsByType("B", Data.CardType.rare), BattleData.PositiveType.shieldTrap, true)

		return true, var_306_37, math.min(2, #var_306_37)
	elseif arg_306_1._id == 7728 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 7729 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 7733 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsBy7733()), 1
	elseif arg_306_1._id == 7734 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordGroupCards(arg_306_0:getBattleCardsByType("HB", Data.CardType.monster), var_306_1._refCards)), 1
	elseif arg_306_1._id == 7735 then
		local var_306_38 = B.filterLinkCardsByLink(arg_306_0:getBattleCardsByType("G", Data.CardType.monster), 1)

		return true, var_306_38, math.min(2, #var_306_38)
	elseif arg_306_1._id == 7736 then
		local var_306_39 = arg_306_0:filterCanChangeToBoardCards(B.filterLinkCardsByLink(arg_306_0:getBattleCardsByType("G", Data.CardType.monster), 1))

		return true, var_306_39, math.min(math.min(2, #var_306_39), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 7737 then
		local var_306_40 = arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByInfoId("PGHL", var_306_1._refCards[2]))

		return true, var_306_40, math.min(math.min(2, #var_306_40), arg_306_0:getEmptyBoardPosCount())
	elseif arg_306_1._id == 7738 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("GL", var_306_1._refCards[2])), 1
	elseif arg_306_1._id == 7742 then
		return true, arg_306_0:getBattleCardsBy7742(), 1
	elseif arg_306_1._id == 7744 then
		local var_306_41 = B.mergeTable({
			arg_306_0._handCards,
			B.filterFirstCards(arg_306_0:filterCanChangeToHandCards(arg_306_0._pileCards), 3)
		})

		return true, var_306_41, math.min(2, #var_306_41)
	elseif arg_306_1._id == 7745 then
		return true, arg_306_0:getBattleCards("G", Data.CARD_MAX_LEVEL, arg_306_1._owner), 1
	elseif arg_306_1._id == 7748 then
		return true, B.sortCardsByBoardPos(B.filterLinkCards(arg_306_0:getBattleCardsByKeyword("B", var_306_1._refCards[1]), false)), 1
	elseif arg_306_1._id == 7749 then
		return true, B.sortCardsByBoardPos(var_306_0:getBattleCardsByMaxAtk("B", var_306_2)), 1
	elseif arg_306_1._id == 7751 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByMinStar("B", var_306_2)), 1
	elseif arg_306_1._id == 7752 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsBy7752()), 1
	elseif arg_306_1._id == 7754 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeyword("B", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 7755 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByKeywordGroup("P", var_306_1._refCards)), 1
	elseif arg_306_1._id == 7756 then
		return true, var_306_0._rareCards, 1
	elseif arg_306_1._id == 7757 then
		return true, arg_306_0:filterCanChangeToBoardCards(var_306_0:getBattleCardsByKeyword("R", var_306_1._refCards[2]), true, true), 1
	elseif arg_306_1._id == 7758 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterNormalMagicCards(arg_306_0:getBattleCardsByMaxQuality("P", var_306_1._refCards[1])), arg_306_1._owner))), 1
	elseif arg_306_1._id == 7760 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(arg_306_0:getBattleCardsByKeyword("G", var_306_1._refCards[1]), arg_306_1._owner)), 1
	elseif arg_306_1._id == 7762 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterUniqueIdCards(B.mergeTable({
			B.filterInNatureCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards[1]),
			B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[2])
		})))), 1
	elseif arg_306_1._id == 7763 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("PG", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 7767 then
		local var_306_42 = arg_306_0:getBattleCardsByKeyword("L", var_306_1._refCards[1])

		return true, var_306_42, math.min(2, #var_306_42)
	elseif arg_306_1._id == 7768 then
		return true, B.sortCardsByBoardPos(var_306_0:getBattleCards("BCSD")), 1
	elseif arg_306_1._id == 7769 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInTypeCards(arg_306_0:getBattleCardsByKeyword("L", var_306_1._refCards[1]), Data.CardType.monster), nil, true), 1
	elseif arg_306_1._id == 7771 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterNotSameNameCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByTypeGroup("P", {
			Data.CardType.magic,
			Data.CardType.trap
		}), var_306_1._refCards[1]), arg_306_1._owner))), 1
	elseif arg_306_1._id == 7772 then
		return true, arg_306_0._graveCards, 1
	elseif arg_306_1._id == 7773 then
		return true, B.sortCardsByBoardPos(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1])), 2
	elseif arg_306_1._id == 7774 then
		return true, arg_306_0:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_306_1._owner), 1
	elseif arg_306_1._id == 7775 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_306_0:getBattleCardsByKeyword("R", var_306_1._refCards[1]), true), arg_306_2._info._star - 1), nil, nil, nil, true), 1
	elseif arg_306_1._id == 7776 then
		local var_306_43 = arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByKeyword("GL", var_306_1._refCards[1]))

		return true, var_306_43, math.min(2, #var_306_43)
	elseif arg_306_1._id == 7778 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInStatusCards(arg_306_1._owner._mark7778._linkComponents, BattleData.CardStatus.grave)), 1
	elseif arg_306_1._id == 7779 then
		return true, B.filterInKeywordCards(arg_306_0:getBattleCardsByType("G", Data.CardType.monster), var_306_1._refCards[1]), 1
	elseif arg_306_1._id == 7781 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("L", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 7782 then
		return true, B.sortCardsByBoardPos(B.filterNoShieldCards(var_306_0:getBoardCards(), BattleData.PositiveType.shieldMagic, true)), 1
	elseif arg_306_1._id == 7783 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 7784 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("G", Data.CardType.monster), var_306_1._refCards[1]), true, true), 1
	elseif arg_306_1._id == 7787 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_306_0:getBattleCardsByKeyword("R", var_306_1._refCards[1]), true), arg_306_2._info._star + 1), nil, nil, nil, true), 1
	elseif arg_306_1._id == 7789 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordGroupCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards))), 1
	elseif arg_306_1._id == 7790 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordGroupCards(arg_306_0:getBattleCardsByType("PH", Data.CardType.monster), var_306_1._refCards))), 1
	elseif arg_306_1._id == 7792 then
		return true, B.filterInKeywordGroupCards(arg_306_0:getBattleCardsByType("G", Data.CardType.monster), var_306_1._refCards), 1
	elseif arg_306_1._id == 7793 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterXYZStarCards(B.filterXYZCards(arg_306_0:getBattleCardsByKeyword("R", var_306_1._refCards[1]), true), arg_306_2._info._star + 2), nil, nil, nil, true), 1
	elseif arg_306_1._id == 7794 then
		return true, arg_306_0:getBattleCardsBy7794(), 1
	elseif arg_306_1._id == 7795 then
		return true, B.sortCardsByBoardPos(var_306_0:getBattleCards("BCSD")), 1
	elseif arg_306_1._id == 7797 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.mergeTable({
			B.filterNotSameNameCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.magic), var_306_1._refCards[1]), arg_306_1._owner),
			B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[2])
		}))), 1
	elseif arg_306_1._id == 7798 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("GL", Data.CardType.monster), var_306_1._refCards[2])), 1
	elseif arg_306_1._id == 7799 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("GL", Data.CardType.monster), var_306_1._refCards[2])), 1
	elseif arg_306_1._id == 7801 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("R", var_306_1._refCards[2]), true, true), 1
	elseif arg_306_1._id == 7802 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByAtk("PH", var_306_2), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 7804 then
		return true, arg_306_0:getBattleCardsByNature("GL", var_306_1._refCards[1]), 2
	elseif arg_306_1._id == 7805 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByNature("G", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 7806 then
		return true, B.sortCardsByBoardPos(B.mergeTable({
			var_306_0:getBattleCards("BCSD"),
			arg_306_0:getBattleCards("BCSD")
		})), 1
	elseif arg_306_1._id == 7807 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterInCategoryCards(arg_306_0:getBattleCardsByMaxStar("P", 4), var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 7808 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByCategory("B", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 7809 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster), var_306_1._refCards[1]))), var_306_2
	elseif arg_306_1._id == 7812 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(B.filterCanMergeToCards(arg_306_0:getBattleCardsByType("P", Data.CardType.monster)))), 1
	elseif arg_306_1._id == 7813 then
		return true, arg_306_0:filterCanChangeToHandCards(B.filterInKeywordCards(arg_306_0:getBattleCardsByType("G", Data.CardType.magic, Data.CARD_MAX_LEVEL, arg_306_1._owner), var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 7814 then
		local var_306_44 = {}

		for iter_306_0 = 1, #var_306_1._refCards do
			if #arg_306_0:getBattleCardsByInfoId("S", var_306_1._refCards[iter_306_0]) == 0 then
				var_306_44[#var_306_44 + 1] = var_306_1._refCards[iter_306_0]
			end
		end

		local var_306_45 = arg_306_0:getBattleCardsByInfoIdGroup("P", var_306_44)

		return true, B.sortCardsByBoardPos(var_306_45), 1
	elseif arg_306_1._id == 7815 then
		return true, arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByCategoryAndNature("HG", var_306_1._refCards[2], var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 7818 then
		return true, arg_306_0:getBattleCardsByCategory("G", var_306_1._refCards[1]), 1
	elseif arg_306_1._id == 7819 then
		return true, arg_306_0:getBattleCardsBy7819(arg_306_1._owner), 1
	elseif arg_306_1._id == 7821 then
		return true, B.sortCardsByBoardPos(var_306_0:getBattleCards("BCSD")), 1
	elseif arg_306_1._id == 7822 then
		local var_306_46 = var_306_0._graveCards

		return true, var_306_46, math.min(2, #var_306_46)
	elseif arg_306_1._id == 7823 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByInfoIdGroup("P", var_306_1._refCards)), 1
	elseif arg_306_1._id == 7825 then
		return true, arg_306_0:filterCanChangeToBoardCards(B.filterLinkCards(arg_306_0:getBattleCardsByNature("G", var_306_1._refCards[1]), false)), 1
	elseif arg_306_1._id == 7826 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("P", var_306_1._refCards[2]))), 1
	elseif arg_306_1._id == 7827 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterAtkOrDefEqualCards(arg_306_0:getBattleCardsByNature("P", var_306_1._refCards[1]), 0))), 1
	elseif arg_306_1._id == 7828 then
		return true, B.sortCardsByBoardPos(arg_306_0:getBattleCardsByNature("P", var_306_1._refCards[1])), 1
	elseif arg_306_1._id == 7830 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToBoardCards(arg_306_0:getBattleCardsByKeyword("PGL", var_306_1._refCards[1]))), 1
	elseif arg_306_1._id == 7832 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(B.filterInCategoryGroupCards(arg_306_0:getBattleCardsByMaxStar("P", var_306_2), var_306_1._refCards))), 1
	elseif arg_306_1._id == 7833 then
		return true, B.sortCardsByBoardPos(arg_306_0:filterCanChangeToHandCards(arg_306_0:getBattleCardsByInfoIdGroup("P", var_306_1._refCards))), 1
	end
end

function var_0_0.getDieByAttackDestStatus(arg_307_0, arg_307_1, arg_307_2)
	if arg_307_1:hasCanCastMonsterSkillFast(1003) or arg_307_1:hasCanCastMonsterSkillFast(1073) then
		return BattleData.CardStatus.leave
	elseif arg_307_1:hasCanCastMonsterSkillFast(1026) and (arg_307_2:hasBuff(true, BattleData.PositiveType.defendPosture) or not (arg_307_2._atk >= (arg_307_1:hasBuff(true, BattleData.PositiveType.defendPosture) and arg_307_1._hp or arg_307_1._atk))) then
		return BattleData.CardStatus.leave
	elseif arg_307_1:hasCanCastMonsterSkillFast(2009) then
		arg_307_2._saved = {
			_pos = #arg_307_2._owner._pileCards + 1
		}

		return BattleData.CardStatus.pile
	elseif not arg_307_2:hasBuff(true, BattleData.PositiveType.defendPosture) and arg_307_1:hasCanCastMonsterSkillFast(2011) then
		arg_307_2._saved = {
			_pos = 1
		}

		return BattleData.CardStatus.pile
	elseif arg_307_1._owner:hasBattleCardsByCanCastMonsterSkillFast("B", 6058) or arg_307_1._owner._opponent:hasBattleCardsByCanCastMonsterSkillFast("B", 6058, Data.CARD_MAX_LEVEL, arg_307_2) then
		return BattleData.CardStatus.pile
	end

	return BattleData.CardStatus.grave
end

function var_0_0.getDamageByAttack(arg_308_0, arg_308_1, arg_308_2, arg_308_3, arg_308_4)
	local var_308_0

	arg_308_1._attackDamage = nil
	arg_308_1._attackCard = arg_308_3
	arg_308_1._defendCard = arg_308_4

	if arg_308_3._owner._mark4321 ~= nil and arg_308_3 == arg_308_3._owner._mark4321 then
		return 0
	end

	if not arg_308_1._owner._isSkillDisabled and arg_308_1._owner:hasBattleCardsByCanCastMonsterSkillFast("B", 13229) then
		return 0
	end

	if arg_308_0:hasBattleCardsBySkillFast("D", 7139) or arg_308_0._opponent:hasBattleCardsBySkillFast("D", 7139) then
		if arg_308_3 and arg_308_3._info._category == Data._skillInfo[7139]._refCards[1] and arg_308_1._owner == arg_308_3._owner then
			return 0
		end

		if arg_308_4 and arg_308_4._info._category == Data._skillInfo[7139]._refCards[1] and arg_308_1._owner == arg_308_4._owner then
			return 0
		end
	end

	local var_targetOwner = arg_308_1 and arg_308_1._owner
	if var_targetOwner and not var_targetOwner._isSkillDisabled then
		local hasBaoLoc = var_targetOwner:hasBattleCardsBySkillFast("S", 8007) or #var_targetOwner:getBattleCardsByInfoId("S", 30171) > 0
		if hasBaoLoc then
			if arg_308_4 and arg_308_4._owner == var_targetOwner and arg_308_4:isKeyword(6) then
				return 0
			end
			if arg_308_3 and arg_308_3._owner == var_targetOwner and arg_308_3:isKeyword(6) then
				return 0
			end
		end
	end

	if arg_308_3 and arg_308_3:hasSkillFast(9576) and arg_308_3._owner == arg_308_1._owner and #B.filterInKeywordCards(arg_308_3:getLinkedCards(), Data._skillInfo[9576]._refCards[1]) > 0 then
		return 0
	end

	if arg_308_4 and arg_308_4:hasSkillFast(9576) and arg_308_4._owner == arg_308_1._owner and #B.filterInKeywordCards(arg_308_4:getLinkedCards(), Data._skillInfo[9576]._refCards[1]) > 0 then
		return 0
	end

	if arg_308_3 and arg_308_3:hasSkills({
		2075,
		6217,
		13775
	}) then
		return 0
	end

	if arg_308_3 and arg_308_3._mark13249 then
		return 0
	end

	if arg_308_4 and arg_308_4:hasSkills({
		2075,
		13775
	}) then
		return 0
	end

	if arg_308_3 and arg_308_3:hasSkills({
		1106
	}) then
		arg_308_2 = arg_308_2 * 2
	end

	if arg_308_3 and arg_308_3:hasSkillFast(9813) and arg_308_3._owner:checkHandCardsYongHuo() then
		arg_308_2 = arg_308_2 * 2
	end

	if arg_308_3 and arg_308_3._mark5629 and arg_308_1._owner == arg_308_3._owner then
		arg_308_2 = arg_308_2 * 2
	end

	if arg_308_3 and arg_308_3:hasSkillFast(14428) then
		arg_308_2 = arg_308_2 * 2
	end

	if arg_308_4 and arg_308_4:hasSkills({
		2067
	}) and arg_308_3 and arg_308_3:isMonsterRare() and arg_308_3:isNature(Data._skillInfo[2067]._refCards[1]) then
		return 0
	end

	arg_308_1._damageUpdatedBy3209 = nil

	if arg_308_1._hp > Data._skillInfo[3209]._val[1] and not arg_308_1._owner._isSkillDisabled and arg_308_1._owner._castedSkillCounts[3209] == nil and arg_308_1._owner:hasBattleCardsBySkillFast("G", 3209) then
		arg_308_1._damageUpdatedBy3209 = true
		var_308_0 = Data._skillInfo[3209]._val[1]
	end

	if var_308_0 == nil and arg_308_3:hasSkills({
		1034
	}) then
		var_308_0 = arg_308_3._maxAtk
	end

	if var_308_0 == nil and arg_308_3:isBindedSkill(7048) then
		var_308_0 = 1000
	end

	if var_308_0 ~= nil then
		arg_308_2 = var_308_0
	end

	if arg_308_3._owner ~= arg_308_1._owner and arg_308_3:hasSkills({
		2021
	}) and arg_308_3:canCastMonsterSkill() then
		arg_308_2 = math.floor(arg_308_2 / 2)
	end

	if arg_308_3._owner == arg_308_1._owner and arg_308_3:hasSkills({
		2061
	}) and arg_308_3:canCastMonsterSkill() then
		arg_308_2 = math.floor(arg_308_2 / 2)
	end

	if arg_308_4 ~= nil and arg_308_4._owner == arg_308_1._owner and arg_308_4:hasSkills({
		2061
	}) and arg_308_4:canCastMonsterSkill() then
		arg_308_2 = math.floor(arg_308_2 / 2)
	end

	if arg_308_4 == nil and arg_308_3:isBindedSkill(7197) then
		arg_308_2 = math.floor(arg_308_2 / 2)
	end

	if arg_308_1._owner:hasBattleCardsBySkillFast("B", 6094) or arg_308_1._owner._opponent:hasBattleCardsBySkillFast("B", 6095) then
		arg_308_2 = math.floor(arg_308_2 / 2)
	end

	if arg_308_3:hasSkillFast(1092) then
		arg_308_2 = math.floor(arg_308_2 / 2)
	end

	if arg_308_3:hasSkillFast(2091) or arg_308_4 ~= nil and arg_308_4:hasSkillFast(2091) then
		arg_308_2 = math.floor(arg_308_2 / 2)
	end

	if arg_308_1._owner:hasBattleCardsBySkillFast("D", 7386) and #arg_308_1._owner:getBattleCardsByKeyword("CSD", Data._skillInfo[7386]._refCards[1]) >= 2 then
		arg_308_2 = math.floor(arg_308_2 / 2)
	end

	arg_308_1._attackDamage = arg_308_2

	return arg_308_2
end

function var_0_0.getSameNameBoardCards(arg_309_0)
	local var_309_0 = {}
	local var_309_1 = B.mergeTable({
		arg_309_0:getBoardCards(),
		arg_309_0._opponent:getBoardCards()
	})

	for iter_309_0 = 1, #var_309_1 do
		local var_309_2 = var_309_1[iter_309_0]

		for iter_309_1 = 1, #var_309_1 do
			if iter_309_0 ~= iter_309_1 then
				local var_309_3 = var_309_1[iter_309_1]

				if var_309_2:isSameNameWith(var_309_3) then
					var_309_0[#var_309_0 + 1] = var_309_2

					break
				end
			end
		end
	end

	return var_309_0
end

function var_0_0.calcFortressDamage(arg_310_0, arg_310_1, arg_310_2)
	local var_310_0 = arg_310_0:getBattleCardsBySkillFast("S", 8040)[1]

	if var_310_0 ~= nil and arg_310_0:canTrapEffect(var_310_0) and #arg_310_0:getBattleCardsByCategory("B", Data._skillInfo[8040]._refCards[1]) > 0 then
		arg_310_1 = math.floor(arg_310_1 / 2)
	end

	if arg_310_0._mark7465_3 or arg_310_0._mark9950 or arg_310_0._mark5608 or arg_310_0._mark5036 then
		arg_310_1 = math.floor(arg_310_1 / 2)
	end

	if not arg_310_0._isSkillDisabled and (arg_310_0:hasBattleCardsByCanCastMonsterSkillFast("B", 2997) or arg_310_0:hasBattleCardsByCanCastMagicSkillFast("S", 7678) and not arg_310_0._mark2548) and not arg_310_2 then
		arg_310_1 = -arg_310_1
	end

	return arg_310_1
end

function var_0_0.calcFortressCost(arg_311_0, arg_311_1)
	return arg_311_1
end

function var_0_0.checkHandCardsYongHuo(arg_312_0, arg_312_1)
	return #arg_312_0:getBattleCards("H", Data.CARD_MAX_LEVEL, arg_312_1) <= (#B.filterNoBuffCards(arg_312_0:getBattleCardsBySkillFast("D", 7213), false, BattleData.NegativeType.disableMagicTrap) > 0 and 1 or 0)
end

function var_0_0.setCardStatusByChoice(arg_313_0, arg_313_1, arg_313_2, arg_313_3, arg_313_4, arg_313_5, arg_313_6, arg_313_7)
	local var_313_0 = arg_313_0:getCardById(arg_313_1)

	if var_313_0 ~= nil then
		if arg_313_5 == BattleData.CardStatus.board then
			var_313_0._saved._pos = B.getToBoardPos(arg_313_7, var_313_0._id)
		end

		arg_313_0:setCardStatus(var_313_0, arg_313_5, arg_313_2, arg_313_3, arg_313_4, arg_313_6)

		return true
	end

	return false
end

function var_0_0.setTwoCardsStatusByChoice(arg_314_0, arg_314_1, arg_314_2, arg_314_3, arg_314_4, arg_314_5, arg_314_6, arg_314_7, arg_314_8)
	local var_314_0 = arg_314_1 % BattleData.UseCardId.id_group
	local var_314_1 = math.floor(arg_314_1 / BattleData.UseCardId.id_group) % BattleData.UseCardId.id_group
	local var_314_2 = arg_314_0:getCardById(var_314_0)
	local var_314_3 = arg_314_0:getCardById(var_314_1)

	if var_314_2 ~= nil and var_314_3 ~= nil then
		arg_314_0:setCardStatus(var_314_2, arg_314_5, arg_314_2, arg_314_3, arg_314_4, arg_314_7)
		arg_314_0:setCardStatus(var_314_3, arg_314_6, arg_314_2, arg_314_3, arg_314_4, arg_314_8)

		return true
	end

	return false
end

function var_0_0.drawCards(arg_315_0, arg_315_1, arg_315_2, arg_315_3, arg_315_4, arg_315_5, arg_315_6)
	local var_315_0 = false
	local var_315_1

	if arg_315_6 then
		var_315_1 = B.filterFirstCards(arg_315_0:filterCanChangeToHandCards(B.filterNotHasChangeStatusUnderSkillCards(arg_315_0._pileCards, {
			BattleData.CardStatus.grave,
			BattleData.CardStatus.leave,
			BattleData.CardStatus.hand
		})), arg_315_1)
	else
		var_315_1 = B.filterFirstCards(arg_315_0:filterCanChangeToHandCards(arg_315_0._pileCards), arg_315_1)
	end

	for iter_315_0 = 1, #var_315_1 do
		arg_315_0:setCardStatus(var_315_1[iter_315_0], BattleData.CardStatus.hand, arg_315_2, arg_315_3, arg_315_4, arg_315_5)

		var_315_0 = true
	end

	return var_315_0
end

function var_0_0.addCardToLinkPos(arg_316_0, arg_316_1, arg_316_2, arg_316_3, arg_316_4, arg_316_5, arg_316_6, arg_316_7)
	local var_316_0 = false
	local var_316_1 = arg_316_0:getCardById(arg_316_2)

	if var_316_1 ~= nil then
		var_316_1._saved._pos = B.getToBoardPos(arg_316_7, var_316_1._id) or arg_316_1:getCardEmptyLinkPos()

		arg_316_0:setCardStatus(var_316_1, BattleData.CardStatus.board, arg_316_3, arg_316_4, arg_316_5)

		var_316_0 = true
	end

	return var_316_0
end

function var_0_0.addCardToDoubleLinkedCardsLinkPos(arg_317_0, arg_317_1, arg_317_2, arg_317_3, arg_317_4, arg_317_5, arg_317_6, arg_317_7)
	local var_317_0 = false
	local var_317_1 = arg_317_0:getCardById(arg_317_2)

	if var_317_1 ~= nil then
		var_317_1._saved._pos = B.getToBoardPos(arg_317_7, var_317_1._id) or arg_317_1:getDoubleLinkedCardsEmptyLinkPos()

		arg_317_0:setCardStatus(var_317_1, BattleData.CardStatus.board, arg_317_3, arg_317_4, arg_317_5)

		var_317_0 = true
	end

	return var_317_0
end

function var_0_0.addCardToDoubleLinkedCardsOppoLinkPos(arg_318_0, arg_318_1, arg_318_2, arg_318_3, arg_318_4, arg_318_5, arg_318_6, arg_318_7)
	local var_318_0 = false
	local var_318_1 = arg_318_0:getCardById(arg_318_2)

	if var_318_1 ~= nil then
		var_318_1._saved._pos = arg_318_1:getDoubleLinkedCardsEmptyOppoLinkPos()

		arg_318_0:setCardStatus(var_318_1, BattleData.CardStatus.board, arg_318_3, arg_318_4, arg_318_5, BattleData.CardStatusVal.g2b_oppo)

		var_318_0 = true
	end

	return var_318_0
end

function var_0_0.isGroundPosEmpty(arg_319_0, arg_319_1)
	return arg_319_0._coverCards[arg_319_1] == nil and arg_319_0._showCards[arg_319_1] == nil
end

function var_0_0.getEmptyGroundPos(arg_320_0)
	for iter_320_0 = 1, Data.MAX_CARD_COUNT_ON_COVER do
		if arg_320_0:isGroundPosEmpty(iter_320_0) then
			return iter_320_0
		end
	end

	return nil
end

function var_0_0.getEmptyGroundPosCount(arg_321_0)
	local var_321_0 = 0

	for iter_321_0 = 1, Data.MAX_CARD_COUNT_ON_COVER do
		if arg_321_0:isGroundPosEmpty(iter_321_0) then
			var_321_0 = var_321_0 + 1
		end
	end

	return var_321_0
end

function var_0_0.getFieldMagicMark(arg_322_0)
	if arg_322_0._fieldCard ~= nil and arg_322_0._usedFieldMark == nil then
		return arg_322_0._fieldCard:getBuffValue(true, BattleData.PositiveType.magicMark)
	end

	return 0
end

function var_0_0.randomPile(arg_323_0)
	arg_323_0._pileCards = arg_323_0:randomTable(arg_323_0._pileCards, #arg_323_0._pileCards)

	for iter_323_0 = 1, #arg_323_0._pileCards do
		arg_323_0._pileCards[iter_323_0]._pos = iter_323_0
	end
end

function var_0_0.getTempLeaveCardByInfoId(arg_324_0, arg_324_1, arg_324_2)
	for iter_324_0 = 1, #arg_324_0._tempLeaveCards do
		local var_324_0 = arg_324_0._tempLeaveCards[iter_324_0]

		if var_324_0 ~= nil and var_324_0:isInfoId(arg_324_1) then
			if arg_324_2 then
				table.remove(arg_324_0._tempLeaveCards, iter_324_0)
			end

			return var_324_0
		end
	end
end

function var_0_0.returnCard(arg_325_0, arg_325_1)
	local var_325_0 = arg_325_1._returnStatus or BattleData.CardStatus.hand

	if arg_325_1._returnCheckValid then
		if var_325_0 == BattleData.CardStatus.hand then
			if #arg_325_0:filterCanChangeToHandCards({
				arg_325_1
			}) == 0 then
				return false
			end
		elseif returnstatus == BattleData.CardStatus.board and #arg_325_0:filterCanChangeToBoardCards({
			arg_325_1
		}) == 0 then
			return false
		end
	end

	arg_325_1._saved._addSkills = arg_325_1._returnAddSkills
	arg_325_1._saved._addAtk = arg_325_1._returnAddAtk

	arg_325_0:changeCardStatus(arg_325_1, BattleData.CardStatus.leave, var_325_0, arg_325_1._returnStatusVal)

	arg_325_1._returnRound = nil
	arg_325_1._returnStatus = nil
	arg_325_1._returnStatusVal = nil
	arg_325_1._returnAddSkills = nil
	arg_325_1._returnAddAtk = nil
	arg_325_1._returnCheckValid = nil

	return true
end

function var_0_0.canUseHandCard(arg_326_0)
	if #arg_326_0._handCards == 0 then
		return false
	end

	for iter_326_0 = 1, #arg_326_0._handCards do
		local var_326_0 = arg_326_0._handCards[iter_326_0]

		if var_326_0._type == Data.CardType.monster then
			if arg_326_0:canUseMonster(var_326_0, false) then
				return true
			end
		elseif var_326_0._type == Data.CardType.magic then
			if arg_326_0:canUseMagic(var_326_0, false) then
				return true
			end
		elseif var_326_0._type == Data.CardType.trap and arg_326_0:canUseTrap(var_326_0, false) then
			return true
		end
	end

	return false
end

function var_0_0.canUseCard(arg_327_0, arg_327_1, arg_327_2, arg_327_3)
	if arg_327_1 == nil then
		return false
	end

	if arg_327_1._type == Data.CardType.monster then
		return arg_327_0:canUseMonsterOnTarget(arg_327_1, arg_327_2)
	elseif arg_327_1._type == Data.CardType.magic then
		return arg_327_0:canUseMagicOnTarget(arg_327_1, arg_327_2)
	elseif arg_327_1._type == Data.CardType.trap then
		return arg_327_0:canUseTrapOnTarget(arg_327_1, arg_327_2)
	end

	return false
end

function var_0_0.getSacrificeChoice(arg_328_0, arg_328_1, arg_328_2, arg_328_3)
	local var_328_0 = math.max(0, arg_328_1:getSacrificeCount() + (arg_328_3 or 0))
	local var_328_1

	if arg_328_2 then
		var_328_1 = B.filterCanSacrificeCards(arg_328_0._opponent:getBoardCards(), arg_328_1)
	else
		var_328_1 = B.filterCanSacrificeCards(B.filterCanActionCards(arg_328_0:getBoardCards()), arg_328_1)
	end

	table.sort(var_328_1, function(arg_329_0, arg_329_1)
		local var_329_0, var_329_1 = arg_329_0:hasPowerSacrificeSkill(arg_328_1)
		local var_329_2, var_329_3 = arg_329_1:hasPowerSacrificeSkill(arg_328_1)
		local var_329_4 = arg_329_0:getStar()
		local var_329_5 = arg_329_1:getStar()

		if var_329_0 and not var_329_2 then
			return true
		elseif var_329_2 and not var_329_0 then
			return false
		elseif var_329_0 and var_329_2 and var_329_1._val[1] > var_329_3._val[1] then
			return true
		elseif var_329_0 and var_329_2 and var_329_1._val[1] < var_329_3._val[1] then
			return false
		elseif var_329_4 < var_329_5 then
			return true
		elseif var_329_5 < var_329_4 then
			return false
		elseif arg_329_0._atk < arg_329_1._atk then
			return true
		elseif arg_329_0._atk > arg_329_1._atk then
			return false
		elseif arg_329_0._hp < arg_329_1._hp then
			return true
		elseif arg_329_0._hp > arg_329_1._hp then
			return false
		else
			return arg_329_0._id < arg_329_1._id
		end
	end)

	if arg_328_2 then
		if #var_328_1 == Data.MAX_CARD_COUNT_ON_BOARD + 1 then
			var_328_1 = B.filterFirstCards(var_328_1, Data.MAX_CARD_COUNT_ON_BOARD)
		end

		var_328_1 = B.reverseTable(var_328_1)
	end

	local var_328_2 = 0
	local var_328_3 = {
		1,
		2,
		4,
		8,
		16,
		1024
	}
	local var_328_4 = 0

	for iter_328_0 = 1, #var_328_1 do
		var_328_2 = var_328_2 + var_328_3[var_328_1[iter_328_0]._pos]
		var_328_4 = var_328_4 + arg_328_0:getCanSacrificeCount({
			var_328_1[iter_328_0]
		}, arg_328_1, not arg_328_2)

		if var_328_4 == var_328_0 then
			break
		end
	end

	return var_328_2 * BattleData.ChoiceId.stage_2 + (arg_328_2 and 4 or arg_328_3 ~= nil and 5 or 1), var_328_4
end

function var_0_0.getCanSacrificeCount(arg_330_0, arg_330_1, arg_330_2, arg_330_3, arg_330_4)
	local var_330_0 = math.max(0, arg_330_2:getSacrificeCount() + (arg_330_4 or 0))
	local var_330_1 = 0

	if #arg_330_1 == 1 and arg_330_1[1]._pos == 6 and arg_330_0:getEmptyBoardPos() == nil then
		return var_330_1
	end

	for iter_330_0 = 1, #arg_330_1 do
		local var_330_2 = arg_330_1[iter_330_0]

		if not arg_330_3 or var_330_2._type ~= Data.CardType.rare and var_330_2:getStar() < 5 then
			local var_330_3, var_330_4 = var_330_2:hasPowerSacrificeSkill(arg_330_2)

			if var_330_3 then
				var_330_1 = var_330_1 + math.min(var_330_4._val[1], var_330_0)
			else
				var_330_1 = var_330_1 + 1
			end
		end
	end

	return var_330_1
end

function var_0_0.getSacrificedCards(arg_331_0, arg_331_1)
	local var_331_0 = math.floor(arg_331_1 / BattleData.ChoiceId.stage_2) % BattleData.ChoiceId.stage_size_2
	local var_331_1 = {}

	for iter_331_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		if band(var_331_0, 2^(iter_331_0 - 1)) > 0 and B.isAlive(arg_331_0._boardCards[iter_331_0]) then
			var_331_1[#var_331_1 + 1] = arg_331_0._boardCards[iter_331_0]
		end
	end

	for iter_331_1 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		if band(var_331_0, 2^(Data.MAX_CARD_COUNT_ON_BOARD + iter_331_1 - 1)) > 0 and B.isAlive(arg_331_0._opponent._boardCards[iter_331_1]) then
			var_331_1[#var_331_1 + 1] = arg_331_0._opponent._boardCards[iter_331_1]
		end
	end

	if band(var_331_0, 2^(Data.MAX_CARD_COUNT_ON_BOARD * 2)) > 0 and B.isAlive(arg_331_0._boardCards[6]) then
		var_331_1[#var_331_1 + 1] = arg_331_0._boardCards[6]
	end

	if band(var_331_0, 2^(Data.MAX_CARD_COUNT_ON_BOARD * 2 + 1)) > 0 and B.isAlive(arg_331_0._opponent._boardCards[6]) then
		var_331_1[#var_331_1 + 1] = arg_331_0._opponent._boardCards[6]
	end

	return var_331_1
end

function var_0_0.checkCanAttack(arg_332_0, arg_332_1)
	local var_332_0 = B.isAlive(arg_332_1) and arg_332_1:canAttack(false) and B.isAlive(arg_332_1._atkTargets[1])

	if var_332_0 and arg_332_0._attackIndex ~= nil and arg_332_0._attackIndex > arg_332_1._atkCount then
		var_332_0 = false
	end

	if var_332_0 and arg_332_1._dieCountBeforeAttack ~= arg_332_1._dieCount then
		var_332_0 = false
	end

	return var_332_0
end

function var_0_0.getJoinPartner(arg_333_0, arg_333_1)
	local var_333_0 = arg_333_1._info

	if var_333_0._join == 0 then
		return nil
	end

	local var_333_1 = arg_333_1._owner:getBattleCardsByInfoId("BH", var_333_0._join)[1]

	if var_333_1 ~= nil then
		return var_333_1
	end

	return nil
end

function var_0_0.joinCard(arg_334_0, arg_334_1, arg_334_2, arg_334_3)
	local var_334_0 = arg_334_2._info._joinResult

	return B.createCard(var_334_0, 1)
end

function var_0_0.getMaxRound(arg_335_0, arg_335_1)
	if not arg_335_0._isAttacker or arg_335_1 == nil then
		return BattleData.MaxRound[4]
	elseif arg_335_1 < 30 then
		return BattleData.MaxRound[1]
	elseif arg_335_1 >= 30 and arg_335_1 < 45 then
		return BattleData.MaxRound[2]
	elseif arg_335_1 >= 45 then
		return BattleData.MaxRound[3]
	end

	return BattleData.MaxRound[4]
end

function var_0_0.getRandom(arg_336_0)
	if arg_336_0._isClient and P._guideID < 100 then
		return 0
	end

	if arg_336_0._battleType == Data.BattleType.unittest and var_0_0._randomSeed == nil then
		var_0_0._randomSeed = 0
	end

	var_0_0._randomSeed = (var_0_0._randomSeed * 1103515245 + 12345) % 65536

	return var_0_0._randomSeed / 65536
end

function var_0_0.randomOne(arg_337_0, arg_337_1)
	if arg_337_1 == nil then
		return nil, nil
	end

	local var_337_0 = #arg_337_1

	if var_337_0 == 0 then
		return nil
	elseif var_337_0 == 1 then
		return arg_337_1[1], 1
	else
		local var_337_1 = math.min(math.floor(arg_337_0:getRandom() * var_337_0 + 1), var_337_0)

		return arg_337_1[var_337_1], var_337_1
	end
end

function var_0_0.randomOneTryExcept(arg_338_0, arg_338_1, arg_338_2)
	local var_338_0 = {}

	for iter_338_0 = 1, #arg_338_1 do
		if arg_338_1[iter_338_0] ~= arg_338_2 then
			table.insert(var_338_0, arg_338_1[iter_338_0])
		end
	end

	return arg_338_0:randomOne(var_338_0) or arg_338_2
end

function var_0_0.randomTable(arg_339_0, arg_339_1, arg_339_2)
	if arg_339_1 == nil then
		return {}
	end

	local var_339_0 = {}
	local var_339_1 = #arg_339_1

	if var_339_1 < arg_339_2 then
		for iter_339_0 = 1, var_339_1 do
			table.insert(var_339_0, arg_339_1[iter_339_0])
		end
	else
		local var_339_2 = {}

		for iter_339_1 = 1, arg_339_2 do
			local var_339_3 = math.min(math.floor(arg_339_0:getRandom() * var_339_1 + 1), var_339_1)

			while true do
				if var_339_2[var_339_3] ~= true then
					var_339_2[var_339_3] = true

					table.insert(var_339_0, arg_339_1[var_339_3])

					break
				else
					var_339_3 = var_339_3 % var_339_1 + 1
				end
			end
		end
	end

	return var_339_0
end

function var_0_0.getDamageFactor(arg_340_0, arg_340_1)
	return 1
end

function var_0_0.getTotalDamageScore(arg_341_0)
	return arg_341_0._damageScore[var_0_0.KEY_TOTAL]
end

function var_0_0.addDamageScore(arg_342_0, arg_342_1)
	if arg_342_0._round < 1 then
		return
	end

	local var_342_0 = "R" .. math.max(arg_342_0._round, arg_342_0._opponent._round)

	if arg_342_0._damageScore[var_342_0] == nil then
		arg_342_0._damageScore[var_342_0] = 0
	end

	arg_342_0._damageScore[var_342_0] = arg_342_0._damageScore[var_342_0] + arg_342_1 * arg_342_0:getDamageFactor(var_342_0)
	arg_342_0._damageScore[var_0_0.KEY_TOTAL] = arg_342_0._damageScore[var_0_0.KEY_TOTAL] + arg_342_1

	if not arg_342_0._isReviewing then
		arg_342_0:sendEvent(BattleData.Status.update_score_damage)
	end
end

function var_0_0.addDestroyCardScore(arg_343_0, arg_343_1)
	if arg_343_0._round < 1 then
		return
	end

	local var_343_0 = "R" .. math.max(arg_343_0._round, arg_343_0._opponent._round)

	if arg_343_0._destroyCardScore[var_343_0] == nil then
		arg_343_0._destroyCardScore[var_343_0] = 0
	end

	arg_343_0._destroyCardScore[var_343_0] = arg_343_0._destroyCardScore[var_343_0] + 1
	arg_343_0._destroyCardScore[var_0_0.KEY_TOTAL] = arg_343_0._destroyCardScore[var_0_0.KEY_TOTAL] + 1

	if arg_343_1._type == Data.CardType.monster then
		if arg_343_0._destroyHeroScore[var_343_0] == nil then
			arg_343_0._destroyHeroScore[var_343_0] = 0
		end

		arg_343_0._destroyHeroScore[var_343_0] = arg_343_0._destroyHeroScore[var_343_0] + 1
		arg_343_0._destroyHeroScore[var_0_0.KEY_TOTAL] = arg_343_0._destroyHeroScore[var_0_0.KEY_TOTAL] + 1
	end

	if arg_343_1:isMonsterRare() then
		if arg_343_0._destroyMonsterCount[arg_343_1._infoId] == nil then
			arg_343_0._destroyMonsterCount[arg_343_1._infoId] = 0
		end

		arg_343_0._destroyMonsterCount[arg_343_1._infoId] = arg_343_0._destroyMonsterCount[arg_343_1._infoId] + 1
		arg_343_0._destroyMonsterCount[0] = arg_343_0._destroyMonsterCount[0] + 1
	end

	if not arg_343_0._isReviewing then
		arg_343_0:sendEvent(BattleData.Status.update_score_destroy_card)
	end
end

function var_0_0.getTotalRound(arg_344_0)
	return arg_344_0._round
end

function var_0_0.getFortressDamage(arg_345_0)
	if arg_345_0._fortress._type == Data.CardType.boss then
		local var_345_0 = arg_345_0._fortress._status == BattleData.CardStatus.board and arg_345_0._fortress._hp or 0

		return {
			arg_345_0._fortressHp - var_345_0,
			var_345_0
		}
	else
		return {
			arg_345_0._fortress._maxHp - arg_345_0._fortress._hp,
			arg_345_0._fortress._hp
		}
	end
end

function var_0_0.getAssistantDamage(arg_346_0)
	local var_346_0 = {}

	for iter_346_0, iter_346_1 in ipairs(arg_346_0._assistant) do
		table.insert(var_346_0, (iter_346_1._updateInitHp or iter_346_1._maxHp) - (B.isAlive(iter_346_1) and iter_346_1._hp or 0))
	end

	return var_346_0
end

function var_0_0.getDestroyMonsterCount(arg_347_0, arg_347_1)
	arg_347_1 = arg_347_1 or 0

	return arg_347_0._destroyMonsterCount[arg_347_1] or 0
end

function var_0_0.getNormalSummonedMonsterCountLessThan4(arg_348_0)
	return arg_348_0._totalNormalSummonedMonsterCount4
end

function var_0_0.getNormalSummonedMonsterCountLargerThan5(arg_349_0)
	return arg_349_0._totalNormalSummonedMonsterCount5
end

function var_0_0.getSpecialSummonedMonsterCount(arg_350_0)
	return arg_350_0._totalSpecialSummonedMonsterCount
end

function var_0_0.getCastedMagicCount(arg_351_0)
	return arg_351_0._totalCastedMagicCount
end

function var_0_0.getCastedTrapCount(arg_352_0)
	return arg_352_0._totalCastedTrapCount
end

function var_0_0.getIsCheating(arg_353_0)
	return arg_353_0._isCheating
end

function var_0_0.checkSacrifice(arg_354_0, arg_354_1, arg_354_2, arg_354_3)
	if #arg_354_3 == 0 and arg_354_2 > 0 then
		return false
	end

	local var_354_0 = 0

	for iter_354_0 = 1, #arg_354_3 do
		local var_354_1, var_354_2 = arg_354_3[iter_354_0]:hasPowerSacrificeSkill(arg_354_1)

		if var_354_1 then
			var_354_0 = var_354_0 + var_354_2._val[1]
		else
			var_354_0 = var_354_0 + 1
		end
	end

	return arg_354_2 <= var_354_0
end

function var_0_0.checkOpInfoId(arg_355_0, arg_355_1)
	if arg_355_1._opInfoId ~= nil and arg_355_1._opInfoId ~= 0 and arg_355_1._infoId ~= arg_355_1._opInfoId then
		return false
	end

	return true
end

function var_0_0.refreshLinkPos(arg_356_0)
	arg_356_0._linkPos = {}
	arg_356_0._opponent._linkPos = {}
	arg_356_0._linkPos[Data.MAX_CARD_COUNT_ON_BOARD + 1] = true
	arg_356_0._opponent._linkPos[Data.MAX_CARD_COUNT_ON_BOARD + 1] = true

	for iter_356_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_356_0 = arg_356_0._boardCards[iter_356_0]

		if var_356_0 ~= nil and var_356_0:isLink() then
			for iter_356_1 = 1, #var_356_0._info._link do
				local var_356_1 = BattleData.LINK_POS[iter_356_0][var_356_0._info._link[iter_356_1]]

				if var_356_1 > 0 then
					arg_356_0._linkPos[var_356_1] = true
				elseif var_356_1 < 0 then
					arg_356_0._opponent._linkPos[-var_356_1] = true
				end
			end
		end
	end

	for iter_356_2 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_356_2 = arg_356_0._opponent._boardCards[iter_356_2]

		if var_356_2 ~= nil and var_356_2:isLink() then
			for iter_356_3 = 1, #var_356_2._info._link do
				local var_356_3 = BattleData.LINK_POS[iter_356_2][var_356_2._info._link[iter_356_3]]

				if var_356_3 > 0 then
					arg_356_0._opponent._linkPos[var_356_3] = true
				elseif var_356_3 < 0 then
					arg_356_0._linkPos[-var_356_3] = true
				end
			end
		end
	end
end

function var_0_0.hasEx(arg_357_0)
	return arg_357_0._boardCards[Data.MAX_CARD_COUNT_ON_BOARD + 1] ~= nil
end

function var_0_0.loadUnitTest(arg_358_0)
	if arg_358_0._unitTestData == nil then
		return
	end

	local var_358_0 = arg_358_0._opponent
	local var_358_1 = arg_358_0._unitTestData.AttackerFields
	local var_358_2 = arg_358_0._unitTestData.DefenderFields

	arg_358_0:loadFields(var_358_1, "PHBGLR")
	var_358_0:loadFields(var_358_2, "PHBGLR")
	arg_358_0:loadFields(var_358_1, "S")
	var_358_0:loadFields(var_358_2, "S")
	arg_358_0:loadUsedCards(arg_358_0._unitTestData.AttackerUsedCards)
	var_358_0:loadUsedCards(arg_358_0._unitTestData.DefenderUsedCards)
end

function var_0_0.loadFields(arg_359_0, arg_359_1, arg_359_2)
	for iter_359_0 = 1, #arg_359_2 do
		local var_359_0 = string.sub(arg_359_2, iter_359_0, iter_359_0)

		if var_359_0 == "B" then
			for iter_359_1 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
				arg_359_0:loadCard(arg_359_1.B[iter_359_1] or 0, arg_359_1.BS and arg_359_1.BS[iter_359_1] or 0, BattleData.CardStatus.board, iter_359_1)
			end
		elseif var_359_0 == "S" then
			for iter_359_2 = 1, Data.MAX_CARD_COUNT_ON_COVER do
				arg_359_0:loadCard(arg_359_1.S[iter_359_2], arg_359_1.SS and arg_359_1.SS[iter_359_2] or 0, BattleData.CardStatus.show, iter_359_2)
			end
		elseif var_359_0 == "P" then
			for iter_359_3 = 1, #arg_359_1.P do
				arg_359_0:loadCard(arg_359_1.P[iter_359_3], arg_359_1.PS and arg_359_1.PS[iter_359_3] or 0, BattleData.CardStatus.pile, iter_359_3)
			end
		elseif var_359_0 == "H" then
			for iter_359_4 = 1, #arg_359_1.H do
				arg_359_0:loadCard(arg_359_1.H[iter_359_4], arg_359_1.HS and arg_359_1.HS[iter_359_4] or 0, BattleData.CardStatus.hand, iter_359_4)
			end
		elseif var_359_0 == "G" then
			for iter_359_5 = 1, #arg_359_1.G do
				arg_359_0:loadCard(arg_359_1.G[iter_359_5], arg_359_1.GS and arg_359_1.GS[iter_359_5] or 0, BattleData.CardStatus.grave, iter_359_5)
			end
		elseif var_359_0 == "L" then
			if arg_359_1.L then
				for iter_359_6 = 1, #arg_359_1.L do
					arg_359_0:loadCard(arg_359_1.L[iter_359_6], arg_359_1.LS and arg_359_1.LS[iter_359_6] or 0, BattleData.CardStatus.leave, iter_359_6)
				end
			end
		elseif var_359_0 == "R" then
			for iter_359_7 = 1, #arg_359_1.R do
				arg_359_0:loadCard(arg_359_1.R[iter_359_7], arg_359_1.RS and arg_359_1.RS[iter_359_7] or 0, BattleData.CardStatus.rare, iter_359_7)
			end
		elseif var_359_0 == "D" then
			for iter_359_8 = 1, #arg_359_1.D do
				arg_359_0:loadCard(arg_359_1.D[iter_359_8], arg_359_1.DS and arg_359_1.DS[iter_359_8] or 0, BattleData.CardStatus.field, iter_359_8)
			end
		end
	end
end

function var_0_0.loadCard(arg_360_0, arg_360_1, arg_360_2, arg_360_3, arg_360_4)
	if arg_360_1 == 0 then
		return
	end

	local var_360_0 = B.createCard(math.abs(arg_360_1), 1)

	if arg_360_2 ~= nil and arg_360_2 > 0 then
		var_360_0._extraSkillId = arg_360_2
	end

	arg_360_0:addCardToCards(var_360_0)

	var_360_0._isTroopCard = true
	var_360_0._saved._pos = arg_360_4

	if arg_360_3 == BattleData.CardStatus.show and var_360_0._type == Data.CardType.trap then
		arg_360_3 = BattleData.CardStatus.cover
	end

	arg_360_0:changeCardStatus(var_360_0, BattleData.CardStatus.leave, arg_360_3, arg_360_1 < 0 and BattleData.CardStatusVal.e2x_fast_def or BattleData.CardStatusVal.e2x_fast)
end

function var_0_0.loadUsedCards(arg_361_0, arg_361_1)
	if arg_361_1 == nil then
		return
	end

	arg_361_0._ops = B.parseOperations(arg_361_0._isAttacker, arg_361_1, not arg_361_1._hasTime)

	arg_361_0:setFromOps(arg_361_0._ops)
end

function var_0_0.setFromOps(arg_362_0, arg_362_1)
	if not arg_362_0._opponent then
		return
	end

	local var_362_0 = arg_362_0._isAttacker and arg_362_0 or arg_362_0._opponent
	local var_362_1 = var_362_0._opponent

	if arg_362_1._attackerSurvialTime and arg_362_1._attackerSurvialTime > 0 then
		var_362_0._survivalTimeStamp = arg_362_1._attackerSurvialTime
	end

	if arg_362_1._defenderSurvialTime and arg_362_1._defenderSurvialTime > 0 then
		var_362_1._survivalTimeStamp = arg_362_1._defenderSurvialTime
	end
end

function var_0_0.sendEvent(arg_363_0, arg_363_1)
	local var_363_0 = cc.EventCustom:new(var_0_0.EVENT)

	var_363_0._sender = arg_363_0
	var_363_0._type = arg_363_1

	lc.Dispatcher:dispatchEvent(var_363_0)
end

function var_0_0.battleLog(arg_364_0, ...)
	if arg_364_0._reviewType == 3 then
		return
	end

	local var_364_0 = string.format(...)

	if arg_364_0._isClient then
		ClientData.addBattleDebugLog(var_364_0 .. "\n")
	end

	if arg_364_0._reviewType == 2 then
		return
	end

	lc.log(var_364_0)
end

function var_0_0.cardName(arg_365_0, arg_365_1)
	return arg_365_1._type == Data.CardType.fortress and Str(STR.FORTRESS) or Str(arg_365_1._info._nameSid)
end
