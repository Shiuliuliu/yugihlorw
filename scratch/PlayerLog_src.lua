local var_0_0 = class("PlayerLog")
local var_0_1 = require("Log")

var_0_0.Event = {
	log_already_shared = "log already shared",
	defense_log_dirty = "defense log dirty",
	log_item_dirty = "log item dirty",
	melee_log_dirty = "melee log dirty",
	room_log_dirty = "room log dirty",
	clash_log_dirty = "clash log dirty",
	survival_log_dirty = "survival log dirty",
	survival_ex_log_dirty = "survival_ex_log_dirty",
	clash_ex_log_dirty = "clash_ex_log_dirty",
	dark_log_dirty = "dark log dirty",
	attack_log_dirty = "attack log dirty"
}

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._attackLogs = {}
	arg_3_0._defenseLogs = {}
	arg_3_0._clashLogs = {}
	arg_3_0._isClashLogsReady = false
	arg_3_0._meleeLogs = {}
	arg_3_0._isMeleeLogsReady = false
	arg_3_0._roomLogs = {}
	arg_3_0._isRoomLogsReady = false
	arg_3_0._darkLogs = {}
	arg_3_0._isDarkLogsReady = false
	arg_3_0._survivalLogs = {}
	arg_3_0._isSurvivalLogsReady = false
	arg_3_0._survivalExLogs = {}
	arg_3_0._isSurvivalExLogsReady = false
	arg_3_0._clashExLogs = {}
	arg_3_0._isClashExLogsReady = false
end

function var_0_0.addLog(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:getLogs(arg_4_2, arg_4_1._isAttack)[arg_4_1._id] = arg_4_1
end

function var_0_0.sendLogDirty(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = cc.EventCustom:new(Data.Event.log_dirty)

	var_5_0._event = arg_5_1
	var_5_0._logId = arg_5_2

	lc.Dispatcher:dispatchEvent(var_5_0)
end

function var_0_0.sendLogShared(arg_6_0, arg_6_1)
	local var_6_0 = cc.EventCustom:new(Data.Event.log_shared)

	var_6_0._event = var_0_0.Event.log_already_shared
	var_6_0._logId = arg_6_1

	lc.Dispatcher:dispatchEvent(var_6_0)
end

function var_0_0.getLogs(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == Battle_pb.PB_BATTLE_WORLD_LADDER then
		return arg_7_0._clashLogs
	elseif arg_7_1 == Battle_pb.PB_BATTLE_WORLD_LADDER_EX then
		return arg_7_0._meleeLogs
	elseif arg_7_1 == Battle_pb.PB_BATTLE_MATCH then
		return arg_7_0._roomLogs
	elseif arg_7_1 == Battle_pb.PB_BATTLE_DARK then
		return arg_7_0._darkLogs
	elseif arg_7_1 == Battle_pb.PB_BATTLE_SURVIVAL then
		return arg_7_0._survivalLogs
	elseif arg_7_1 == Battle_pb.PB_BATTLE_SURVIVAL_EX then
		return arg_7_0._survivalExLogs
	elseif arg_7_1 == Battle_pb.PB_BATTLE_WORLD_LEGEND then
		return arg_7_0._clashExLogs
	else
		return arg_7_2 and arg_7_0._attackLogs or arg_7_0._defenseLogs
	end
end

function var_0_0.getLogList(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == Battle_pb.PB_BATTLE_WORLD_LADDER then
		if not arg_8_0._isClashLogsReady then
			return nil
		end
	elseif arg_8_1 == Battle_pb.PB_BATTLE_MATCH then
		if not arg_8_0._isRoomLogsReady then
			return nil
		end
	elseif arg_8_1 == Battle_pb.PB_BATTLE_WORLD_LADDER_EX then
		if not arg_8_0._isMeleeLogsReady then
			return nil
		end
	elseif arg_8_1 == Battle_pb.PB_BATTLE_DARK then
		if not arg_8_0._isDarkLogsReady then
			return nil
		end
	elseif arg_8_1 == Battle_pb.PB_BATTLE_SURVIVAL then
		if not arg_8_0._isSurvivalLogsReady then
			return nil
		end
	elseif arg_8_1 == Battle_pb.PB_BATTLE_SURVIVAL_EX then
		if not arg_8_0._isSurvivalExLogsReady then
			return nil
		end
	elseif arg_8_1 == Battle_pb.PB_BATTLE_WORLD_LEGEND and not arg_8_0._isClashExLogsReady then
		return nil
	end

	local var_8_0 = {}
	local var_8_1 = arg_8_0:getLogs(arg_8_1, arg_8_2)

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		table.insert(var_8_0, iter_8_1)
	end

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		return arg_9_0._timestamp > arg_9_1._timestamp
	end)

	return var_8_0
end

function var_0_0.getNewAttackLogCount(arg_10_0)
	local var_10_0 = lc.readConfig(ClientData.ConfigKey.new_attack_log, 0)
	local var_10_1 = 0

	if arg_10_0._attackLogs ~= nil then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._attackLogs) do
			if var_10_0 < iter_10_1._timestamp then
				var_10_1 = var_10_1 + 1
			end
		end
	end

	return var_10_1
end

function var_0_0.getNewDefenseLogCount(arg_11_0)
	local var_11_0 = lc.readConfig(ClientData.ConfigKey.new_defense_log, 0)
	local var_11_1 = 0

	if arg_11_0._defenseLogs ~= nil then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._defenseLogs) do
			if var_11_0 < iter_11_1._timestamp then
				var_11_1 = var_11_1 + 1
			end
		end
	end

	return var_11_1
end

function var_0_0.onMsg(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.type
	local var_12_1 = arg_12_1.status

	if var_12_0 == SglMsgType_pb.PB_TYPE_BATTLE_LOG then
		local var_12_2 = arg_12_1.Extensions[Battle_pb.SglBattleMsg.battle_log_resp]

		for iter_12_0 = 1, #var_12_2.attack_log do
			local var_12_3 = var_0_1.new(true, var_12_2.attack_log[iter_12_0])

			arg_12_0:addLog(var_12_3, Battle_pb.PB_BATTLE_PLAYER)
		end

		for iter_12_1 = 1, #var_12_2.defend_log do
			local var_12_4 = var_0_1.new(false, var_12_2.defend_log[iter_12_1])

			arg_12_0:addLog(var_12_4, Battle_pb.PB_BATTLE_PLAYER)
		end

		arg_12_0:sendLogDirty(var_0_0.Event.attack_log_dirty)
		arg_12_0:sendLogDirty(var_0_0.Event.defense_log_dirty)

		return true
	elseif var_12_0 == SglMsgType_pb.PB_TYPE_BATTLE_LOG_EX then
		local var_12_5 = arg_12_1.Extensions[Battle_pb.SglBattleMsg.battle_log_ex_resp]
		local var_12_6 = var_12_5.type
		local var_12_7 = var_12_5.logs

		for iter_12_2, iter_12_3 in ipairs(var_12_7) do
			local var_12_8 = var_0_1.new(nil, iter_12_3)

			arg_12_0:addLog(var_12_8, var_12_6)
		end

		if var_12_6 == Battle_pb.PB_BATTLE_WORLD_LADDER then
			arg_12_0._isClashLogsReady = true

			arg_12_0:sendLogDirty(var_0_0.Event.clash_log_dirty)
		elseif var_12_6 == Battle_pb.PB_BATTLE_MATCH then
			arg_12_0._isRoomLogsReady = true

			arg_12_0:sendLogDirty(var_0_0.Event.room_log_dirty)
		elseif var_12_6 == Battle_pb.PB_BATTLE_DARK then
			arg_12_0._isDarkLogsReady = true

			arg_12_0:sendLogDirty(var_0_0.Event.dark_log_dirty)
		elseif var_12_6 == Battle_pb.PB_BATTLE_SURVIVAL then
			arg_12_0._isSurvivalLogsReady = true

			arg_12_0:sendLogDirty(var_0_0.Event.survival_log_dirty)
		elseif var_12_6 == Battle_pb.PB_BATTLE_SURVIVAL_EX then
			arg_12_0._isSurvivalExLogsReady = true

			arg_12_0:sendLogDirty(var_0_0.Event.survival_ex_log_dirty)
		elseif var_12_6 == Battle_pb.PB_BATTLE_WORLD_LEGEND then
			arg_12_0._isClashExLogsReady = true

			arg_12_0:sendLogDirty(var_0_0.Event.clash_ex_log_dirty)
		else
			arg_12_0._isMeleeLogsReady = true

			arg_12_0:sendLogDirty(var_0_0.Event.melee_log_dirty)
		end

		return true
	end

	return false
end

return var_0_0
