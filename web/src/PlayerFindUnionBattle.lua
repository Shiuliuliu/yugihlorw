local var_0_0 = class("PlayerFindUnionBattle")
local var_0_1 = 1303

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.init(arg_4_0, arg_4_1)
	return
end

function var_0_0.onMsg(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.type

	return false
end

function var_0_0.getLadderDuration()
	local var_6_0
	local var_6_1
	local var_6_2 = ClientData.getValidActivityByType(var_0_1)

	if var_6_2 then
		if var_6_2._beginTime == "" then
			var_6_0 = var_6_2
		elseif ClientData.isActivityValid(var_6_2) then
			var_6_1 = var_6_2
		end
	end

	return (var_6_1 or var_6_0)._param
end

function var_0_0.getIsUnionBattleActivityValid(arg_7_0)
	local var_7_0 = ClientData.getValidActivityByType(var_0_1)

	return var_7_0 ~= nil and (var_7_0._beginTime == "" or ClientData.isActivityValid(var_7_0))
end

function var_0_0.getIsValidTime(arg_8_0)
	local var_8_0, var_8_1, var_8_2, var_8_3 = ClientData.getServerDate()
	local var_8_4 = arg_8_0:getLadderDuration()
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

function var_0_0.getStartTimeTip(arg_9_0)
	local var_9_0, var_9_1, var_9_2, var_9_3 = ClientData.getServerDate()
	local var_9_4 = ClientData.getCurrentTime() - ClientData.getExpireTimestamp(0)
	local var_9_5 = arg_9_0:getLadderDuration()
	local var_9_6 = 6
	local var_9_7 = var_9_5[3 * (var_9_6 - 1) + 2]
	local var_9_8 = var_9_5[3 * (var_9_6 - 1) + 3]
	local var_9_9 = var_9_7 * 3600 - var_9_4

	return string.format(Str(STR.UNION_BATTLE_START_TIP), var_9_7, var_9_8)
end

function var_0_0.getEndTimeTip(arg_10_0)
	local var_10_0, var_10_1, var_10_2, var_10_3 = ClientData.getServerDate()
	local var_10_4 = ClientData.getCurrentTime() - ClientData.getExpireTimestamp(0)
	local var_10_5 = arg_10_0:getLadderDuration()
	local var_10_6 = 6
	local var_10_7 = var_10_5[3 * (var_10_6 - 1) + 2]
	local var_10_8 = var_10_5[3 * (var_10_6 - 1) + 3] * 3600 - var_10_4

	return arg_10_0:getRemainSecondsStr(var_10_8)
end

function var_0_0.getRemainSecondsStr(arg_11_0, arg_11_1)
	local var_11_0 = math.floor(arg_11_1 / 3600)
	local var_11_1 = math.floor((arg_11_1 - var_11_0 * 3600) / 60)
	local var_11_2 = math.floor(arg_11_1 % 60)

	return (string.format("%d:%02d:%02d", var_11_0, var_11_1, var_11_2))
end

return var_0_0
