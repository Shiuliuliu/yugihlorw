local var_0_0 = class("PlayerFindDark")
local var_0_1 = 1304

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._inning = 0
	arg_3_0._winScore = 0
	arg_3_0._loseScore = 0
	arg_3_0._trophy = 0
end

function var_0_0.clearScore(arg_4_0)
	arg_4_0._inning = 0
	arg_4_0._winScore = 0
	arg_4_0._loseScore = 0
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0._inning = arg_5_1.inning or 0
	arg_5_0._trophy = arg_5_1.score or 0
	arg_5_0._winScore = arg_5_1.win or 0
	arg_5_0._loseScore = arg_5_1.opWin or 0
end

function var_0_0.onMsg(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.type

	return false
end

function var_0_0.isDarkFinished(arg_7_0)
	local var_7_0 = false

	if arg_7_0._inning >= 3 or arg_7_0._winScore >= 2 or arg_7_0._loseScore >= 2 then
		var_7_0 = true
	end

	return var_7_0
end

function var_0_0.isInDarkBattle(arg_8_0)
	return arg_8_0._inning > 0 and not arg_8_0:isDarkFinished()
end

function var_0_0.getDarkDuration()
	local var_9_0
	local var_9_1
	local var_9_2 = ClientData.getValidActivityByType(var_0_1)

	if var_9_2 then
		if var_9_2._beginTime == "" then
			var_9_0 = var_9_2
		elseif ClientData.isActivityValid(var_9_2) then
			var_9_1 = var_9_2
		end
	end

	return (var_9_1 or var_9_0)._param
end

function var_0_0.getIsDarkActivityValid(arg_10_0)
	local var_10_0 = ClientData.getValidActivityByType(var_0_1)

	return var_10_0 ~= nil and (var_10_0._beginTime == "" or ClientData.isActivityValid(var_10_0))
end

function var_0_0.getIsValidTime(arg_11_0)
	local var_11_0, var_11_1, var_11_2, var_11_3 = ClientData.getServerDate()
	local var_11_4 = arg_11_0:getDarkDuration()
	local var_11_5 = ClientData.getDayOfWeek()

	var_11_5 = var_11_5 == 0 and 7 or var_11_5

	local var_11_6 = var_11_4[3 * (var_11_5 - 1) + 2]
	local var_11_7 = var_11_4[3 * (var_11_5 - 1) + 3]
	local var_11_8 = 0

	if var_11_0 < var_11_6 then
		var_11_8 = 1
	elseif var_11_7 <= var_11_0 then
		var_11_8 = -1
	end

	return var_11_8
end

function var_0_0.getStartTimeTip(arg_12_0)
	local var_12_0, var_12_1, var_12_2, var_12_3 = ClientData.getServerDate()
	local var_12_4 = ClientData.getCurrentTime() - ClientData.getExpireTimestamp(0)
	local var_12_5 = arg_12_0:getDarkDuration()
	local var_12_6 = 5
	local var_12_7 = var_12_5[3 * (var_12_6 - 1) + 2]
	local var_12_8 = var_12_5[3 * (var_12_6 - 1) + 3]
	local var_12_9 = var_12_7 * 3600 - var_12_4

	return string.format(Str(STR.DARK_START_TIP), var_12_7, var_12_8)
end

function var_0_0.getEndTimeTip(arg_13_0)
	local var_13_0, var_13_1, var_13_2, var_13_3 = ClientData.getServerDate()
	local var_13_4 = ClientData.getCurrentTime() - ClientData.getExpireTimestamp(0)
	local var_13_5 = arg_13_0:getDarkDuration()
	local var_13_6 = 5
	local var_13_7 = var_13_5[3 * (var_13_6 - 1) + 2]
	local var_13_8 = var_13_5[3 * (var_13_6 - 1) + 3] * 3600 - var_13_4

	return arg_13_0:getRemainSecondsStr(var_13_8)
end

function var_0_0.getRemainSecondsStr(arg_14_0, arg_14_1)
	local var_14_0 = math.floor(arg_14_1 / 3600)
	local var_14_1 = math.floor((arg_14_1 - var_14_0 * 3600) / 60)
	local var_14_2 = math.floor(arg_14_1 % 60)

	return (string.format("%d:%02d:%02d", var_14_0, var_14_1, var_14_2))
end

function var_0_0.find(arg_15_0, arg_15_1)
	if arg_15_0:isDarkFinished() then
		if arg_15_1 then
			arg_15_0:clearScore()
			ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_DARK)
		end
	else
		ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_DARK)
	end
end

function var_0_0.onFind(arg_16_0)
	arg_16_0._inning = arg_16_0._inning + 1

	if arg_16_0._inning == 1 and P._propBag:hasProps(Data.PropsId.dark_ticket, 1) then
		P:addResource(Data.PropsId.dark_ticket, 1, -1)
	end
end

function var_0_0.onFindCancled(arg_17_0)
	arg_17_0:clearScore()
end

function var_0_0.retreat(arg_18_0, arg_18_1)
	if arg_18_1 then
		ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_DARK)
	end

	ClientData.sendDarkRetreat()
end

function var_0_0.onInningEnd(arg_19_0, arg_19_1)
	arg_19_0._inning = arg_19_1.inning
	arg_19_0._winScore = arg_19_1.win
	arg_19_0._loseScore = arg_19_1.lose
end

return var_0_0
