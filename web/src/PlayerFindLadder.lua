local var_0_0 = class("PlayerFindLadder")

var_0_0.MAX_TROOP_COUNT = 40
var_0_0.MAX_BATTLE_COUNT = 12
var_0_0.MAX_LOSE_COUNT = 3
var_0_0.TOTAL_CARD_COUNT = 5
var_0_0.SELECT_CARD_COUNT = 2

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._hasTicket = false
	arg_3_0._step = 0
	arg_3_0._characterId = 0
	arg_3_0._cardsPool = {}
	arg_3_0._characters = {}
	arg_3_0._troopCards = {}
	arg_3_0._selected = {}
	arg_3_0._winCount = 0
	arg_3_0._loseCount = 0
	arg_3_0._chest = {
		_infoId = 0,
		_isOpened = false
	}
	arg_3_0._usedExtraLoseTimes = 0
	arg_3_0._rollTimes = 0
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0._hasTicket = arg_4_1.has_ticket
	arg_4_0._characterId = arg_4_1:HasField("char_id") and arg_4_1.char_id or 0
	arg_4_0._step = arg_4_1.step
	arg_4_0._cardsPool = {}

	for iter_4_0 = 1, #arg_4_1.pool do
		arg_4_0._cardsPool[iter_4_0] = arg_4_1.pool[iter_4_0]
	end

	arg_4_0._troopCards = {}

	for iter_4_1 = 1, #arg_4_1.cards do
		local var_4_0 = arg_4_1.cards[iter_4_1]

		arg_4_0._troopCards[iter_4_1] = {
			_infoId = var_4_0.info_id,
			_num = var_4_0.num
		}
	end

	arg_4_0._winCount = math.min(12, arg_4_1.win)
	arg_4_0._loseCount = arg_4_1.lose
	arg_4_0._chest = {
		_infoId = 0,
		_isOpened = false
	}

	if arg_4_1:HasField("chest") then
		local var_4_1 = arg_4_1.chest

		arg_4_0._chest._infoId = var_4_1.id
		arg_4_0._chest._isOpened = var_4_1.opened
	end

	arg_4_0._characters = {}

	for iter_4_2 = 1, #arg_4_1.chars do
		arg_4_0._characters[iter_4_2] = arg_4_1.chars[iter_4_2]
	end

	arg_4_0._selected = {}

	for iter_4_3 = 1, #arg_4_1.selected do
		arg_4_0._selected[iter_4_3] = arg_4_1.selected[iter_4_3] + 1
	end

	arg_4_0._rollTimes = arg_4_1.roll_times
	arg_4_0._usedExtraLoseTimes = arg_4_1.used_extra_lose_times
end

function var_0_0.onMsg(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.type

	if var_5_0 == SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET then
		local var_5_1 = arg_5_1.Extensions[World_pb.SglWorldMsg.world_buy_ticket_resp]

		arg_5_0._characters = {}

		for iter_5_0 = 1, #var_5_1 do
			arg_5_0._characters[iter_5_0] = var_5_1[iter_5_0]
		end
	elseif var_5_0 == SglMsgType_pb.PB_TYPE_WORLD_ROLL_CHAR then
		local var_5_2 = arg_5_1.Extensions[World_pb.SglWorldMsg.world_roll_char_resp]

		arg_5_0._characters = {}

		for iter_5_1 = 1, #var_5_2 do
			arg_5_0._characters[iter_5_1] = var_5_2[iter_5_1]
		end
	elseif var_5_0 == SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR then
		local var_5_3 = arg_5_1.Extensions[World_pb.SglWorldMsg.world_select_char_resp]

		arg_5_0._cardsPool = {}

		for iter_5_2 = 1, #var_5_3 do
			arg_5_0._cardsPool[iter_5_2] = var_5_3[iter_5_2]
		end
	elseif var_5_0 == SglMsgType_pb.PB_TYPE_WORLD_QUIT then
		local var_5_4 = arg_5_1.Extensions[World_pb.SglWorldMsg.world_quit_resp]

		for iter_5_3 = 1, #var_5_4 do
			arg_5_0:changeChest(var_5_4[iter_5_3].info_id)
		end
	end

	return false
end

function var_0_0.addCardToTroop(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._selected[#arg_6_0._selected + 1] = arg_6_2 + math.floor((arg_6_0._step - 1) / var_0_0.SELECT_CARD_COUNT) * var_0_0.TOTAL_CARD_COUNT

	local var_6_0 = arg_6_0._troopCards

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = var_6_0[iter_6_0]

		if var_6_1._infoId == arg_6_1 then
			var_6_1._num = var_6_1._num + 1

			return
		end
	end

	var_6_0[#var_6_0 + 1] = {
		_num = 1,
		_infoId = arg_6_1
	}
end

function var_0_0.getTroopCardCount(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = 0
	local var_7_2 = 0
	local var_7_3 = 0
	local var_7_4 = 0

	for iter_7_0 = 1, #arg_7_0._troopCards do
		local var_7_5 = arg_7_0._troopCards[iter_7_0]
		local var_7_6 = Data.getType(var_7_5._infoId)

		var_7_0 = var_7_0 + var_7_5._num

		if var_7_6 == Data.CardType.monster then
			var_7_1 = var_7_1 + var_7_5._num
		elseif var_7_6 == Data.CardType.rare then
			var_7_2 = var_7_2 + var_7_5._num
		elseif var_7_6 == Data.CardType.magic then
			var_7_3 = var_7_3 + var_7_5._num
		elseif var_7_6 == Data.CardType.trap then
			var_7_4 = var_7_4 + var_7_5._num
		end
	end

	return var_7_0, var_7_1, var_7_2, var_7_3, var_7_4
end

function var_0_0.changeChest(arg_8_0, arg_8_1)
	arg_8_0._chest = {
		_isOpened = false,
		_infoId = arg_8_1
	}
end

function var_0_0.getSelectCards(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = math.floor((arg_9_0._step - 1) / var_0_0.SELECT_CARD_COUNT) * var_0_0.TOTAL_CARD_COUNT

	for iter_9_0 = 1, var_0_0.TOTAL_CARD_COUNT do
		var_9_0[iter_9_0] = {
			_isValid = true,
			_infoId = arg_9_0._cardsPool[var_9_1 + iter_9_0]
		}
	end

	for iter_9_1 = 1, #arg_9_0._selected do
		local var_9_2 = arg_9_0._selected[iter_9_1] - var_9_1

		if var_9_2 > 0 and var_9_2 <= var_0_0.TOTAL_CARD_COUNT then
			var_9_0[var_9_2]._isValid = false
		end
	end

	return var_9_0
end

function var_0_0.getSelectCardIndex(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getSelectCards()

	for iter_10_0 = 1, #var_10_0 do
		local var_10_1 = var_10_0[iter_10_0]

		if var_10_1._infoId == arg_10_1 and var_10_1._isValid then
			return iter_10_0
		end
	end

	return 0
end

function var_0_0.getLadderDuration()
	local var_11_0
	local var_11_1

	for iter_11_0, iter_11_1 in pairs(Data._activityInfo) do
		if iter_11_1._type[1] == 1302 then
			if iter_11_1._beginTime == "" then
				var_11_0 = iter_11_1
			elseif ClientData.isActivityValid(iter_11_1) then
				var_11_1 = iter_11_1
			end
		end
	end

	return (var_11_1 or var_11_0)._param
end

function var_0_0.getIsValidTime(arg_12_0)
	local var_12_0, var_12_1, var_12_2, var_12_3 = ClientData.getServerDate()
	local var_12_4 = arg_12_0:getLadderDuration()
	local var_12_5 = ClientData.getDayOfWeek()

	var_12_5 = var_12_5 == 0 and 7 or var_12_5

	local var_12_6 = var_12_4[3 * (var_12_5 - 1) + 2]
	local var_12_7 = var_12_4[3 * (var_12_5 - 1) + 3]
	local var_12_8 = 0

	if var_12_0 < var_12_6 then
		var_12_8 = 1
	elseif var_12_7 <= var_12_0 then
		var_12_8 = -1
	end

	return var_12_8
end

function var_0_0.getTimeTip(arg_13_0)
	local var_13_0, var_13_1, var_13_2, var_13_3 = ClientData.getServerDate()
	local var_13_4 = ClientData.getCurrentTime() - ClientData.getExpireTimestamp(0)
	local var_13_5 = arg_13_0:getLadderDuration()
	local var_13_6 = ClientData.getDayOfWeek()

	var_13_6 = var_13_6 == 0 and 7 or var_13_6

	local var_13_7 = var_13_5[3 * (var_13_6 - 1) + 2]
	local var_13_8 = var_13_5[3 * (var_13_6 - 1) + 3]
	local var_13_9 = var_13_7 * 3600 - var_13_4
	local var_13_10 = ""

	if var_13_7 == var_13_8 then
		var_13_10 = var_13_10 .. Str(STR.FIND_ARENA_CLOSED)
	else
		var_13_10 = var_13_10 .. string.format(Str(STR.FIND_ARENA_TIME), var_13_7, 0, var_13_8, 0)
	end

	if ClientData.getValidActivityByType(Data.ActivityType.ladder_new_rule) then
		var_13_10 = var_13_10 .. "\n" .. Str(STR.NEW_RULE_TIP)
	end

	return var_13_10
end

function var_0_0.getRemainRollTimes(arg_14_0)
	if ClientData._cfg and ClientData._cfg.testArena then
		return 1
	end

	if P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.arena_privilege_2) > 0 then
		return 2 - arg_14_0._rollTimes
	elseif P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.arena_privilege_1) > 0 then
		return 1 - arg_14_0._rollTimes
	else
		return 0
	end
end

function var_0_0.couldRollCharacter(arg_15_0)
	if arg_15_0:getRemainRollTimes() > 0 then
		return true
	end

	return false
end

return var_0_0
