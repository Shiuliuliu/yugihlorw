local var_0_0 = class("PlayerFindClashEx")

var_0_0.MAX_BATTLE_COUNT = 12
var_0_0.MAX_LOSE_COUNT = 3

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0, arg_3_1)
	arg_3_0._hasTicket = false
	arg_3_0._winCount = 0
	arg_3_0._loseCount = 0
	arg_3_0._chest = {
		_infoId = 0,
		_isOpened = false
	}

	if arg_3_1 then
		arg_3_0._trophy = 0
		arg_3_0._endTime = 0
	end
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0._hasTicket = arg_4_1.legend_ticket
	arg_4_0._winCount = math.min(12, arg_4_1.legend_win)
	arg_4_0._loseCount = arg_4_1.legend_lose
	arg_4_0._chest = {
		_infoId = 0,
		_isOpened = false
	}

	if arg_4_1:HasField("legend_chest") then
		local var_4_0 = arg_4_1.legend_chest

		arg_4_0._chest._infoId = var_4_0.id
		arg_4_0._chest._isOpened = var_4_0.opened
	end
end

function var_0_0.onMsg(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.type

	if var_5_0 == SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_LEGEND then
		-- block empty
	elseif var_5_0 == SglMsgType_pb.PB_TYPE_WORLD_QUIT_LEGEND then
		local var_5_1 = arg_5_1.Extensions[World_pb.SglWorldMsg.world_quit_legend_resp]

		for iter_5_0 = 1, #var_5_1 do
			arg_5_0:changeChest(var_5_1[iter_5_0].info_id)
		end
	end

	return false
end

function var_0_0.changeChest(arg_6_0, arg_6_1)
	arg_6_0._chest = {
		_isOpened = false,
		_infoId = arg_6_1
	}
end

function var_0_0.getDuration()
	local var_7_0
	local var_7_1

	for iter_7_0, iter_7_1 in pairs(Data._activityInfo) do
		if iter_7_1._type[1] == Data.ActivityType.clash_ex then
			if iter_7_1._beginTime == "" then
				var_7_0 = iter_7_1
			elseif ClientData.isActivityValid(iter_7_1) then
				var_7_1 = iter_7_1
			end
		end
	end

	return (var_7_1 or var_7_0)._param
end

function var_0_0.getIsValidTime(arg_8_0)
	local var_8_0, var_8_1, var_8_2, var_8_3 = ClientData.getServerDate()
	local var_8_4 = arg_8_0:getDuration()
	local var_8_5 = ClientData.getDayOfWeek()

	var_8_5 = var_8_5 == 0 and 7 or var_8_5

	local var_8_6 = var_8_4[3 * (var_8_5 - 1) + 2]
	local var_8_7 = var_8_4[3 * (var_8_5 - 1) + 3]
	local var_8_8 = 0

	if var_8_0 < var_8_6 then
		var_8_8 = 1
	elseif var_8_7 <= var_8_0 then
		var_8_8 = -1
	end

	return var_8_8
end

function var_0_0.getTimeTip(arg_9_0)
	local var_9_0, var_9_1, var_9_2, var_9_3 = ClientData.getServerDate()
	local var_9_4 = ClientData.getCurrentTime() - ClientData.getExpireTimestamp(0)
	local var_9_5 = arg_9_0:getDuration()
	local var_9_6

	var_9_6 = ClientData.getDayOfWeek() == 0 and 7 or var_9_6

	local var_9_7 = ""

	for iter_9_0 = 1, 7 do
		local var_9_8 = var_9_5[3 * (iter_9_0 - 1) + 2]
		local var_9_9 = var_9_5[3 * (iter_9_0 - 1) + 3]
		local var_9_10 = var_9_8 * 3600 - var_9_4

		if var_9_8 ~= var_9_9 then
			var_9_7 = var_9_7 .. string.format(Str(STR.FIND_CLASH_EX_TIME), Str(STR.WEEK_1 + iter_9_0 - 1), var_9_8, var_9_9)

			break
		end
	end

	return var_9_7
end

return var_0_0
