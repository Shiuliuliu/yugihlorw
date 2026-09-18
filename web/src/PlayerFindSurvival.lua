local var_0_0 = class("PlayerFindSurvival")

var_0_0.MAX_TROOP_COUNT = 40
var_0_0.MAX_BATTLE_COUNT = 12
var_0_0.MAX_LOSE_COUNT = 3
var_0_0.TOTAL_CARD_COUNT = 5
var_0_0.SELECT_CARD_COUNT = 2

local var_0_1 = 1305

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()

	arg_1_0._privilegeStamp = 0

	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._hasTicket = false
	arg_3_0._isInHall = false
	arg_3_0._step = 0
	arg_3_0._characterId = 0
	arg_3_0._cardsPool = {}
	arg_3_0._characters = {}
	arg_3_0._troopCards = {}
	arg_3_0._selected = {}
	arg_3_0._captures = {}
	arg_3_0._dieTimeStamp = 0
	arg_3_0._hallUserNum = 1
end

function var_0_0.clearBonus(arg_4_0)
	arg_4_0._rewards = nil
	arg_4_0._rank = nil
	arg_4_0._getSeconds = nil
end

function var_0_0.sortFunc(arg_5_0, arg_5_1)
	local var_5_0 = Data.getOriginId(arg_5_0._infoId)
	local var_5_1 = Data.getOriginId(arg_5_1._infoId)

	if var_5_0 < var_5_1 then
		return true
	elseif var_5_1 < var_5_0 then
		return false
	else
		return arg_5_0._infoId < arg_5_1._infoId
	end
end

function var_0_0.init(arg_6_0, arg_6_1)
	arg_6_0._hasTicket = arg_6_1.has_ticket
	arg_6_0._characterId = arg_6_1:HasField("char_id") and arg_6_1.char_id or 0
	arg_6_0._step = arg_6_1.step
	arg_6_0._cardsPool = {}

	for iter_6_0 = 1, #arg_6_1.pool do
		arg_6_0._cardsPool[iter_6_0] = arg_6_1.pool[iter_6_0]
	end

	local var_6_0 = math.max(math.min(arg_6_0._step - 1, var_0_0.MAX_TROOP_COUNT), 0)

	arg_6_0._troopCards = {}

	if var_6_0 > 0 then
		for iter_6_1 = 1, #arg_6_1.cards do
			local var_6_1 = arg_6_1.cards[iter_6_1]
			local var_6_2 = math.min(var_6_0, var_6_1.num)

			arg_6_0._troopCards[iter_6_1] = {
				_infoId = var_6_1.info_id,
				_num = var_6_2
			}
			var_6_0 = var_6_0 - var_6_2

			if var_6_0 <= 0 then
				break
			end
		end
	end

	table.sort(arg_6_0._troopCards, var_0_0.sortFunc)

	arg_6_0._captures = {}

	for iter_6_2 = 1, #arg_6_1.captures do
		local var_6_3 = arg_6_1.captures[iter_6_2]
		local var_6_4 = Data.getType(var_6_3.info_id)

		if var_6_4 == Data.CardType.monster or var_6_4 == Data.CardType.magic or var_6_4 == Data.CardType.trap then
			arg_6_0._captures[#arg_6_0._captures + 1] = {
				_infoId = var_6_3.info_id,
				_num = var_6_3.num
			}
		end
	end

	table.sort(arg_6_0._captures, var_0_0.sortFunc)

	arg_6_0._characters = {}

	for iter_6_3 = 1, #arg_6_1.chars do
		arg_6_0._characters[iter_6_3] = arg_6_1.chars[iter_6_3]
	end

	arg_6_0._selected = {}

	for iter_6_4 = 1, #arg_6_1.selected do
		arg_6_0._selected[iter_6_4] = arg_6_1.selected[iter_6_4] + 1
	end

	arg_6_0._privilegeStamp = arg_6_1.privilege_stamp / 1000
end

function var_0_0.onMsg(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.type

	if var_7_0 == SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL then
		local var_7_1 = arg_7_1.Extensions[World_pb.SglWorldMsg.world_buy_ticket_resp]

		arg_7_0._characters = {}

		for iter_7_0 = 1, #var_7_1 do
			arg_7_0._characters[iter_7_0] = var_7_1[iter_7_0]
		end
	elseif var_7_0 == SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL then
		local var_7_2 = arg_7_1.Extensions[World_pb.SglWorldMsg.world_select_char_resp]

		arg_7_0._cardsPool = {}

		for iter_7_1 = 1, #var_7_2 do
			arg_7_0._cardsPool[iter_7_1] = var_7_2[iter_7_1]
		end
	elseif var_7_0 == SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_GAME_OVER then
		local var_7_3 = arg_7_1.Extensions[World_pb.SglWorldMsg.world_survival_end_resp]

		arg_7_0._rank = var_7_3.rank

		local var_7_4 = ClientData.getCurrentTime()

		if arg_7_0._rank == 1 then
			arg_7_0._privilegeStamp = math.max(arg_7_0._privilegeStamp, var_7_4) + Data._globalInfo._SurvivalPrivilegeTime * 3600
		end

		arg_7_0._captures = {}

		local var_7_5 = {}

		for iter_7_2 = 1, #var_7_3.resource do
			local var_7_6 = var_7_3.resource[iter_7_2]

			var_7_5[#var_7_5 + 1] = {
				_infoId = var_7_6.info_id,
				_count = var_7_6.num
			}
		end

		if #var_7_5 > 0 then
			arg_7_0._rewards = var_7_5

			P:addResourcesData(var_7_5)
		end

		arg_7_0:clear()
		lc.sendEvent(Data.Event.survival_game_over)
	elseif var_7_0 == SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_HALL_INFO then
		local var_7_7 = arg_7_1.Extensions[World_pb.SglWorldMsg.world_survival_hall_info_resp]

		arg_7_0._hallUserNum = var_7_7.num

		if var_7_7:HasField("gameover_timestamp") then
			arg_7_0._dieTimeStamp = var_7_7.gameover_timestamp / 1000
		end

		if arg_7_0:canFindHall() and arg_7_0._hallUserNum > 1 then
			if not arg_7_0._isInHall and var_7_7.is_in_hall then
				arg_7_0._isInHall = var_7_7.is_in_hall

				lc._runningScene:onEnterSurvivalHall()
			end

			arg_7_0._isInHall = var_7_7.is_in_hall
		else
			arg_7_0._isInHall = false
		end

		lc.sendEvent(Data.Event.survival_info_dirty)
	elseif var_7_0 == SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_EXPLORE_END then
		local var_7_8 = arg_7_1.Extensions[World_pb.SglWorldMsg.world_survival_explore_resp]

		arg_7_0:parseExploreResp(var_7_8)
	end

	return false
end

function var_0_0.canFindHall(arg_8_0)
	return arg_8_0._hasTicket and arg_8_0._characterId ~= 0 and arg_8_0._step > var_0_0.MAX_TROOP_COUNT
end

function var_0_0.parseExploreResp(arg_9_0, arg_9_1)
	arg_9_0._dieTimeStamp, arg_9_0._getSeconds = arg_9_1.gameover_timestamp / 1000, arg_9_1.gain_time
	arg_9_0._captures = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.captures) do
		local var_9_0 = Data.getType(iter_9_1.info_id)

		if var_9_0 == Data.CardType.monster or var_9_0 == Data.CardType.magic or var_9_0 == Data.CardType.trap then
			arg_9_0._captures[#arg_9_0._captures + 1] = {
				_infoId = iter_9_1.info_id,
				_num = iter_9_1.num
			}
		end
	end

	table.sort(arg_9_0._captures, var_0_0.sortFunc)
	lc.sendEvent(Data.Event.survival_explore_end)
end

function var_0_0.addCardToTroop(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._selected[#arg_10_0._selected + 1] = arg_10_2 + math.floor((arg_10_0._step - 1) / var_0_0.SELECT_CARD_COUNT) * var_0_0.TOTAL_CARD_COUNT

	local var_10_0 = arg_10_0._troopCards

	for iter_10_0 = 1, #var_10_0 do
		local var_10_1 = var_10_0[iter_10_0]

		if var_10_1._infoId == arg_10_1 then
			var_10_1._num = var_10_1._num + 1

			return
		end
	end

	var_10_0[#var_10_0 + 1] = {
		_num = 1,
		_infoId = arg_10_1
	}
end

function var_0_0.captures2Troop(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = false

	for iter_11_0 = 1, #arg_11_0._captures do
		local var_11_1 = arg_11_0._captures[iter_11_0]

		if var_11_1._infoId == arg_11_1 then
			var_11_1._num = var_11_1._num - arg_11_2

			if var_11_1._num <= 0 then
				table.remove(arg_11_0._captures, iter_11_0)
			end

			var_11_0 = true

			break
		end
	end

	if not var_11_0 and arg_11_2 < 0 then
		arg_11_0._captures[#arg_11_0._captures + 1] = {
			_infoId = arg_11_1,
			_num = -arg_11_2
		}
	end

	local var_11_2 = false

	for iter_11_1 = 1, #arg_11_0._troopCards do
		local var_11_3 = arg_11_0._troopCards[iter_11_1]

		if var_11_3._infoId == arg_11_1 then
			var_11_3._num = var_11_3._num + arg_11_2

			if var_11_3._num <= 0 then
				table.remove(arg_11_0._troopCards, iter_11_1)
			end

			var_11_2 = true

			break
		end
	end

	if not var_11_2 and arg_11_2 > 0 then
		arg_11_0._troopCards[#arg_11_0._troopCards + 1] = {
			_infoId = arg_11_1,
			_num = arg_11_2
		}
	end
end

function var_0_0.getTroopCardCount(arg_12_0, arg_12_1)
	if not arg_12_1 then
		local var_12_0 = 0
		local var_12_1 = 0
		local var_12_2 = 0
		local var_12_3 = 0
		local var_12_4 = 0

		for iter_12_0 = 1, #arg_12_0._troopCards do
			local var_12_5 = arg_12_0._troopCards[iter_12_0]
			local var_12_6 = Data.getType(var_12_5._infoId)

			var_12_0 = var_12_0 + var_12_5._num

			if var_12_6 == Data.CardType.monster then
				var_12_1 = var_12_1 + var_12_5._num
			elseif var_12_6 == Data.CardType.rare then
				var_12_2 = var_12_2 + var_12_5._num
			elseif var_12_6 == Data.CardType.magic then
				var_12_3 = var_12_3 + var_12_5._num
			elseif var_12_6 == Data.CardType.trap then
				var_12_4 = var_12_4 + var_12_5._num
			end
		end

		return var_12_0, var_12_1, var_12_2, var_12_3, var_12_4
	else
		local var_12_7 = 0

		for iter_12_1 = 1, #arg_12_0._troopCards do
			local var_12_8 = arg_12_0._troopCards[iter_12_1]

			if var_12_8._infoId == arg_12_1 then
				var_12_7 = var_12_7 + var_12_8._num
			end
		end

		return var_12_7
	end
end

function var_0_0.getSelectCards(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = math.floor((arg_13_0._step - 1) / var_0_0.SELECT_CARD_COUNT) * var_0_0.TOTAL_CARD_COUNT

	for iter_13_0 = 1, var_0_0.TOTAL_CARD_COUNT do
		var_13_0[iter_13_0] = {
			_isValid = true,
			_infoId = arg_13_0._cardsPool[var_13_1 + iter_13_0]
		}
	end

	for iter_13_1 = 1, #arg_13_0._selected do
		local var_13_2 = arg_13_0._selected[iter_13_1] - var_13_1

		if var_13_2 > 0 and var_13_2 <= var_0_0.TOTAL_CARD_COUNT then
			var_13_0[var_13_2]._isValid = false
		end
	end

	return var_13_0
end

function var_0_0.getSelectCardIndex(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getSelectCards()

	for iter_14_0 = 1, #var_14_0 do
		local var_14_1 = var_14_0[iter_14_0]

		if var_14_1._infoId == arg_14_1 and var_14_1._isValid then
			return iter_14_0
		end
	end

	return 0
end

function var_0_0.getSurvivalDuration()
	local var_15_0
	local var_15_1

	for iter_15_0, iter_15_1 in pairs(Data._activityInfo) do
		if iter_15_1._type[1] == 1305 then
			if iter_15_1._beginTime == "" then
				var_15_0 = iter_15_1
			elseif ClientData.isActivityValid(iter_15_1) then
				var_15_1 = iter_15_1
			end
		end
	end

	return (var_15_1 or var_15_0)._param
end

function var_0_0.getIsValidTime(arg_16_0)
	local var_16_0, var_16_1, var_16_2, var_16_3 = ClientData.getServerDate()
	local var_16_4 = arg_16_0:getSurvivalDuration()
	local var_16_5 = ClientData.getDayOfWeek()

	var_16_5 = var_16_5 == 0 and 7 or var_16_5

	local var_16_6 = var_16_4[3 * (var_16_5 - 1) + 2]
	local var_16_7 = var_16_4[3 * (var_16_5 - 1) + 3]
	local var_16_8 = 0

	if var_16_0 < var_16_6 then
		var_16_8 = 1
	elseif var_16_7 <= var_16_0 then
		var_16_8 = -1
	end

	return var_16_8
end

function var_0_0.getTimeTip(arg_17_0)
	local var_17_0, var_17_1, var_17_2, var_17_3 = ClientData.getServerDate()
	local var_17_4 = ClientData.getCurrentTime() - ClientData.getExpireTimestamp(0)
	local var_17_5 = arg_17_0:getSurvivalDuration()
	local var_17_6 = ClientData.getDayOfWeek()

	var_17_6 = var_17_6 == 0 and 7 or var_17_6

	local var_17_7 = var_17_5[3 * (var_17_6 - 1) + 2]
	local var_17_8 = var_17_5[3 * (var_17_6 - 1) + 3]
	local var_17_9 = var_17_7 * 3600 - var_17_4

	if var_17_7 == var_17_8 then
		return Str(STR.FIND_SURVIVAL_CLOSED)
	else
		return string.format(Str(STR.FIND_SURVIVAL_TIME), var_17_7, 0, var_17_8, 0)
	end
end

function var_0_0.isTroopValid(arg_18_0)
	return arg_18_0:getTroopCardCount() == var_0_0.MAX_TROOP_COUNT
end

function var_0_0.isPrivilegeValid(arg_19_0)
	return ClientData.getCurrentTime() < arg_19_0._privilegeStamp
end

function var_0_0.getPrivilegeTimeStr(arg_20_0)
	local var_20_0 = ClientData.getCurrentTime()

	if not arg_20_0:isPrivilegeValid() then
		return
	end

	local var_20_1 = arg_20_0._privilegeStamp - var_20_0
	local var_20_2 = math.floor(var_20_1 / 86400)
	local var_20_3 = var_20_1 % 86400
	local var_20_4 = math.floor(var_20_3 / 3600)
	local var_20_5 = math.floor(var_20_3 % 3600 / 60)

	return string.format(Str(STR.PRIVELEGE_EFFECTING_COUNTDOWN), var_20_2, var_20_4, var_20_5)
end

return var_0_0
