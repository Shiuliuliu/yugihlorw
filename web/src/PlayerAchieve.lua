local var_0_0 = require("MainTask")
local var_0_1 = require("ActivityTask")
local var_0_2 = class("PlayerAchieve")

function var_0_2.ctor(arg_1_0)
	arg_1_0:clear()
end

function var_0_2.clear(arg_2_0)
	arg_2_0._mainTasks = {}
	arg_2_0._activityTasks = {}
end

function var_0_2.init(arg_3_0)
	arg_3_0:initMainTask()
	arg_3_0:initActivityTask()
end

function var_0_2.initMainTask(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(Data._mainTaskInfo) do
		if iter_4_1._type <= 0 then
			local var_4_0 = var_0_0.new(iter_4_0)

			arg_4_0._mainTasks[iter_4_0] = var_4_0
		end
	end
end

function var_0_2.initActivityTask(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(Data._activityTaskInfo) do
		if type(iter_5_0) == "number" then
			local var_5_0 = var_0_1.new(iter_5_0)

			arg_5_0._activityTasks[iter_5_0] = var_5_0
		end
	end
end

function var_0_2.getDailyTaskLevel(arg_6_0, arg_6_1)
	if arg_6_1 == Data.DailyTaskType.player_battle_win then
		return Data._globalInfo._unlockFindMatch
	elseif arg_6_1 == Data.DailyTaskType.view_palace_task then
		return P._playerCity:getPalaceUnlockLevel()
	elseif arg_6_1 == Data.DailyTaskType.upgrade_equip then
		return P._playerCity:getBlacksmithUnlockLevel()
	elseif arg_6_1 == Data.DailyTaskType.challenge_elite then
		return Data._globalInfo._unlockElite
	elseif arg_6_1 == Data.DailyTaskType.copy_boss then
		return Data._globalInfo._unlockRobExp
	elseif arg_6_1 == Data.DailyTaskType.collect_fragment then
		return P._playerCity:getGuardUnlockLevel()
	elseif arg_6_1 == Data.DailyTaskType.rob_horse then
		return Data._globalInfo._unlockCommander
	elseif arg_6_1 == Data.DailyTaskType.upgrade_horse then
		return P._playerCity:getStableUnlockLevel()
	elseif arg_6_1 == Data.DailyTaskType.book_lottery then
		return P._playerCity:getLibraryUnlockLevel()
	elseif arg_6_1 == Data.DailyTaskType.expedition then
		return Data._globalInfo._unlockExpedition
	elseif arg_6_1 == Data.DailyTaskType.challenge_uboss then
		return P._playerCity:getUnionUnlockLevel()
	end

	return 0
end

function var_0_2.getOrderedMainTasks(arg_7_0)
	return lc.reorderToArray(arg_7_0._mainTasks, function(arg_8_0, arg_8_1)
		return arg_8_0._infoId < arg_8_1._infoId
	end)
end

function var_0_2.getOrderedActivityTasks(arg_9_0)
	return lc.reorderToArray(arg_9_0._activityTasks, function(arg_10_0, arg_10_1)
		return arg_10_0._infoId < arg_10_1._infoId
	end)
end

function var_0_2.dailyTaskDone(arg_11_0, arg_11_1, arg_11_2)
	return
end

function var_0_2.activityTaskDone(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._activityTasks[arg_12_1]:getBonus()

	if var_12_0 == nil then
		return
	end

	local var_12_1 = var_12_0._value

	var_12_0._value = var_12_0._value + (delta or 1)

	var_12_0:sendBonusDirty(var_12_1)
end

function var_0_2.sendAchieveListDirty(arg_13_0)
	local var_13_0 = cc.EventCustom:new(Data.Event.achieve_list_dirty)

	lc.Dispatcher:dispatchEvent(var_13_0)
end

return var_0_2
