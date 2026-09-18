local var_0_0 = class("BattleEvent")

BattleEvent = var_0_0
var_0_0.EventType = {
	round_begin = 3,
	before_status_change = 8,
	after_status_change = 7,
	try_use_card = 5,
	fortress_died = 11,
	battle_start = 1,
	card_rebirth = 12,
	do_use_card = 6,
	battle_end = 2,
	all_cards_died = 10,
	round_end = 4
}

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._player = arg_1_1
	arg_1_0._events = {}

	if next(arg_1_2) then
		for iter_1_0 = 1, #arg_1_2 do
			local var_1_0 = arg_1_2[iter_1_0]
			local var_1_1 = Data._eventInfo[var_1_0]

			if var_1_1 then
				table.insert(arg_1_0._events, {
					_id = var_1_0,
					_info = var_1_1
				})
			end
		end
	end

	arg_1_0:reset()
end

function var_0_0.reset(arg_2_0)
	for iter_2_0 = 1, #arg_2_0._events do
		local var_2_0 = arg_2_0._events[iter_2_0]

		var_2_0._owner = arg_2_0._player
		var_2_0._isCasted = false
	end
end

function var_0_0.getSatisfiedEvents(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0 = 1, #arg_3_0._events do
		local var_3_1 = arg_3_0._events[iter_3_0]

		if var_3_1._info._status == arg_3_1 and arg_3_0:isEventSatisfied(var_3_1) then
			table.insert(var_3_0, var_3_1)
		end
	end

	return var_3_0
end

function var_0_0.isEventSatisfied(arg_4_0, arg_4_1)
	local var_4_0 = true

	for iter_4_0 = 1, #arg_4_1._info._condition do
		local var_4_1 = arg_4_1._info._condition[iter_4_0]
		local var_4_2 = arg_4_1._info._conditionValue[iter_4_0]

		if arg_4_1._info._isOnce == 1 and arg_4_1._isCasted or not arg_4_0:isSatisfied(var_4_1, var_4_2) then
			var_4_0 = false

			break
		end
	end

	return var_4_0
end

function var_0_0.getEventById(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_0._events do
		local var_5_0 = arg_5_0._events[iter_5_0]

		if var_5_0._id == arg_5_1 then
			return var_5_0
		end
	end

	return nil
end

function var_0_0.isSatisfied(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = false
	local var_6_1 = arg_6_2 or {}
	local var_6_2 = var_6_1[1]
	local var_6_3 = arg_6_0._player
	local var_6_4 = arg_6_0._player._opponent
	local var_6_5 = var_6_3._actionCard or var_6_4._actionCard

	if arg_6_1 == 1 then
		var_6_0 = true
	elseif arg_6_1 == 2 then
		if var_6_5:isInfoId(var_6_2) and var_6_5._sourceStatus == var_6_1[2] and var_6_5._destStatus == var_6_1[3] then
			return true
		end
	elseif arg_6_1 == 11 or arg_6_1 == 13 then
		if #var_6_3:getBattleCardsByInfoId("B", var_6_2) > 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 12 or arg_6_1 == 14 then
		if #var_6_3:getBattleCardsByInfoId("B", var_6_2) == 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 15 then
		if #var_6_3:getBattleCardsByInfoId("B", var_6_2) == 0 and #var_6_4:getBattleCardsByInfoId("B", var_6_2) == 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 16 then
		if #var_6_3:getBoardCardByEventId(var_6_1[10]) ~= nil then
			var_6_0 = true
		end
	elseif arg_6_1 == 17 or arg_6_1 == 18 then
		if #var_6_3:getBattleCardsByInfoId("B", var_6_2) > 0 or #var_6_4:getBattleCardsByInfoId("B", var_6_2) > 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 19 then
		if #B.filterDefPostureCards(var_6_3:getBattleCardsByInfoId("B", var_6_2), true) > 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 20 then
		if #B.filterDefPostureCards(var_6_3:getBattleCardsByInfoId("B", var_6_2), false) > 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 21 or arg_6_1 == 23 then
		if #var_6_3:getBattleCardsByInfoId("H", var_6_2) > 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 22 or arg_6_1 == 24 then
		if #var_6_3:getBattleCardsByInfoId("H", var_6_2) == 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 31 then
		if var_6_5 ~= nil and var_6_5:isInfoId(var_6_2) then
			var_6_0 = true
		end
	elseif arg_6_1 == 32 then
		if var_6_5 ~= nil and var_6_5:isInfoId(var_6_2) and var_6_5._isFromEvent then
			var_6_0 = true
		end
	elseif arg_6_1 == 33 then
		if var_6_5 ~= nil and var_6_5._type == Data.CardType.monster and var_6_5._owner == var_6_3 then
			var_6_0 = true
		end
	elseif arg_6_1 == 34 then
		if var_6_3._cardToTryUse ~= nil then
			local var_6_6 = var_6_3._cardToTryUse._card

			if var_6_6 ~= nil and var_6_6:isInfoId(var_6_2) or var_6_6 == nil and var_6_2 == 0 then
				var_6_0 = true
			end
		end
	elseif arg_6_1 == 41 then
		if var_6_3._round == var_6_2 then
			var_6_0 = true
		end
	elseif arg_6_1 == 42 then
		if var_6_2 <= var_6_3._round then
			var_6_0 = true
		end
	elseif arg_6_1 == 43 then
		if var_6_2 >= var_6_3._round then
			var_6_0 = true
		end
	elseif arg_6_1 == 44 then
		if var_6_3:getActionPlayer() == var_6_3 then
			var_6_0 = true
		end
	elseif arg_6_1 == 45 then
		-- block empty
	elseif arg_6_1 == 51 then
		if var_6_3._isAttacker and var_6_3:getResult() == Data.BattleResult.win then
			var_6_0 = true
		elseif var_6_3._opponent._isAttacker and var_6_3._opponent:getResult() == Data.BattleResult.win then
			var_6_0 = true
		end
	elseif arg_6_1 == 52 then
		if var_6_3._isAttacker and var_6_3:getResult() == Data.BattleResult.lose then
			var_6_0 = true
		elseif var_6_3._opponent._isAttacker and var_6_3._opponent:getResult() == Data.BattleResult.lose then
			var_6_0 = true
		end
	elseif arg_6_1 == 53 then
		local var_6_7 = arg_6_0:getEventById(var_6_2)

		if var_6_7 ~= nil and not var_6_7._isCasted then
			var_6_0 = true
		end
	elseif arg_6_1 == 61 then
		if var_6_2 == var_6_3._gem then
			var_6_0 = true
		end
	elseif arg_6_1 == 71 and not var_6_3._isUsedCard and not var_6_3._opponent._isUsedCard then
		var_6_0 = true
	end

	return var_6_0
end

function var_0_0.castEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = false
	local var_7_1 = arg_7_0._player
	local var_7_2 = arg_7_0._player._opponent

	if not var_7_1._actionCard then
		local var_7_3 = var_7_2._actionCard
	end

	local var_7_4 = arg_7_2 or {}

	if arg_7_1 == 1 then
		var_7_0 = true
	elseif arg_7_1 == 2 then
		local var_7_5 = B.createCardByEvent(var_7_4)

		if var_7_5 ~= nil then
			var_7_1:addCardToCards(var_7_5)

			if var_7_5._type == Data.CardType.monster then
				if var_7_1:getEmptyBoardPos(var_7_5) ~= nil then
					var_7_1:changeCardStatus(var_7_5, BattleData.CardStatus.leave, BattleData.CardStatus.board)
				elseif #var_7_1._handCards < Data.MAX_CARD_COUNT_IN_HAND then
					var_7_1:changeCardStatus(var_7_5, BattleData.CardStatus.leave, BattleData.CardStatus.hand, BattleData.CardStatusVal.e2h_self_new)
				else
					var_7_1:changeCardStatus(var_7_5, BattleData.CardStatus.leave, BattleData.CardStatus.pile)
				end
			else
				var_7_1:changeCardStatus(var_7_5, BattleData.CardStatus.leave, BattleData.CardStatus.board)
			end

			var_7_0 = true
		end
	elseif arg_7_1 == 3 then
		local var_7_6 = B.createCardByEvent(var_7_4)

		if var_7_6 ~= nil then
			var_7_1:addCardToCards(var_7_6)

			if #var_7_1._handCards < Data.MAX_CARD_COUNT_IN_HAND then
				var_7_1:changeCardStatus(var_7_6, BattleData.CardStatus.leave, BattleData.CardStatus.hand, BattleData.CardStatusVal.e2h_self_new)
			else
				var_7_1:changeCardStatus(var_7_6, BattleData.CardStatus.leave, BattleData.CardStatus.pile)
			end

			var_7_0 = true
		end
	elseif arg_7_1 == 4 then
		local var_7_7 = var_7_1:getBattleCardsByInfoId("H", var_7_4.c.id)[1]

		if var_7_7 ~= nil then
			var_7_1:changeCardStatus(var_7_7, BattleData.CardStatus.hand, BattleData.CardStatus.board)

			var_7_0 = true
		end
	elseif arg_7_1 == 5 then
		local var_7_8 = var_7_1:getBattleCardsByInfoId("B", var_7_4.c.id)[1]

		if var_7_8 ~= nil then
			var_7_1:changeCardStatus(var_7_8, BattleData.CardStatus.board, BattleData.CardStatus.grave)

			var_7_0 = true
		end
	elseif arg_7_1 == 6 or arg_7_1 == 17 then
		-- block empty
	elseif arg_7_1 == 7 then
		var_7_0 = true
	elseif arg_7_1 == 8 then
		-- block empty
	elseif arg_7_1 == 9 then
		var_7_0 = true
	elseif arg_7_1 == 10 then
		var_7_0 = true
	elseif arg_7_1 == 11 then
		var_7_0 = true
	elseif arg_7_1 == 12 then
		local var_7_9 = B.createCardByEvent(var_7_4)

		if var_7_9 ~= nil then
			var_7_1:addCardToCards(var_7_9)
			var_7_1:changeCardStatus(var_7_9, BattleData.CardStatus.leave, BattleData.CardStatus.pile)

			var_7_0 = true
		end
	elseif arg_7_1 == 13 then
		var_7_0 = true
	elseif arg_7_1 == 14 then
		var_7_0 = true
	elseif arg_7_1 == 15 then
		var_7_0 = true
	elseif arg_7_1 == 16 then
		var_7_0 = true
	elseif arg_7_1 == 18 then
		local var_7_10 = var_7_1._fortress

		var_7_10._hpInc = var_7_10._hpInc + var_7_4.hp
		var_7_10._maxHpInc = var_7_10._hpInc > 0 and var_7_10._hpInc or 0
		var_7_10._haloedMaxHpInc = var_7_10._maxHpInc
		var_7_10._hp = math.max(var_7_10._maxHp + var_7_10._hpInc, 0)
	elseif arg_7_1 == 19 then
		var_7_0 = true
	elseif arg_7_1 == 20 then
		var_7_0 = true
	elseif arg_7_1 == 21 then
		var_7_0 = true
	elseif arg_7_1 == 22 then
		var_7_0 = true
	elseif arg_7_1 == 51 or arg_7_1 == 52 or arg_7_1 == 53 or arg_7_1 == 54 or arg_7_1 == 55 then
		var_7_0 = true
	elseif arg_7_1 == 61 then
		arg_7_0._player:changeFortressSkill(var_7_4.id, var_7_4.lv)

		var_7_0 = true
	elseif arg_7_1 == 81 then
		arg_7_0._player:loadUnitTest()

		var_7_0 = true
	end

	if var_7_0 then
		arg_7_3._isCasted = true
	end
end

function var_0_0.getEventById(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_0._events do
		local var_8_0 = arg_8_0._events[iter_8_0]

		if var_8_0._id == arg_8_1 then
			return var_8_0
		end
	end

	return nil
end

return var_0_0
