local var_0_0 = class("PlayerRoom")
local var_0_1 = require("Room")

function var_0_0.ctor(arg_1_0)
	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	if arg_3_0._myRoom then
		arg_3_0._myRoom:clear()
	end

	arg_3_0._myRoom = nil
	arg_3_0._myIdInRoom = nil
	P._roomId = nil
	P._roomJob = nil
end

function var_0_0.initMyRoom(arg_4_0, arg_4_1)
	if not arg_4_0:getMyRoom() then
		arg_4_0._myRoom = var_0_1.create(arg_4_1)

		arg_4_0:updateMyRoom(arg_4_1)
		lc._runningScene:onEnterRoom()
	else
		arg_4_0:updateMyRoom(arg_4_1)
		var_0_1:sendRoomDirty()
	end
end

function var_0_0.updateMyRoom(arg_5_0, arg_5_1)
	arg_5_0._myRoom:updateInfo(arg_5_1)

	local var_5_0 = arg_5_0._myRoom

	P._roomId = var_5_0._id
	arg_5_0._myIdInRoom = arg_5_1.user_id

	if arg_5_0._myIdInRoom == var_5_0._creator._idInRoom then
		P._roomJob = Data.RoomJob.leader
	else
		P._roomJob = Data.RoomJob.rookie
	end

	local var_5_1 = var_5_0:getMembers()
	local var_5_2 = true
	local var_5_3 = true

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		if arg_5_0._myIdInRoom == iter_5_1._idInRoom then
			var_5_2 = false
		end

		if var_5_0._creator and var_5_0._creator._idInRoom == iter_5_1._idInRoom then
			var_5_3 = false
		end
	end

	if var_5_2 or var_5_3 then
		arg_5_0:exitMyRoom()
	end

	if P._roomId then
		P._lastRoomId = P._roomId
	end
end

function var_0_0.getMyRoom(arg_6_0)
	return arg_6_0._myRoom
end

function var_0_0.addMember(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._myRoom

	if var_7_0 then
		var_7_0:addMember(arg_7_1)
	end
end

function var_0_0.removeMember(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._myRoom

	if var_8_0 then
		var_8_0:removeMember(arg_8_1)

		if arg_8_1 == P._id then
			P._roomId = 0

			arg_8_0:clear()
			arg_8_0:sendExitRoomDirty()

			if arg_8_2 then
				ToastManager.push(Str(STR.ROOM_BE_KICKED_OUT))
			end
		else
			var_8_0._impeach[arg_8_1] = nil
		end
	end
end

function var_0_0.sendEnterRoomDirty(arg_9_0)
	local var_9_0 = cc.EventCustom:new(Data.Event.room_enter_dirty)

	lc.Dispatcher:dispatchEvent(var_9_0)
end

function var_0_0.sendExitRoomDirty(arg_10_0)
	local var_10_0 = cc.EventCustom:new(Data.Event.room_exit_dirty)

	lc.Dispatcher:dispatchEvent(var_10_0)
end

function var_0_0.onMsg(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.type
	local var_11_1 = arg_11_1.status

	if var_11_0 == SglMsgType_pb.PB_TYPE_WORLD_GET_MATCH then
		local var_11_2 = ClientView.getActiveIndicator()

		if var_11_2._isShowing then
			var_11_2:hide()
		end

		local var_11_3 = arg_11_1.Extensions[World_pb.SglWorldMsg.world_get_match_resp]

		arg_11_0:initMyRoom(var_11_3)

		return true
	elseif var_11_0 == SglMsgType_pb.PB_TYPE_WORLD_CLOSE_MATCH then
		arg_11_0:clear()
		arg_11_0:sendExitRoomDirty()

		return true
	end

	return false
end

function var_0_0.exitMyRoom(arg_12_0)
	arg_12_0:clear()
	ClientData.sendQuitRoom()
end

function var_0_0.sendGetRoomLog(arg_13_0)
	ClientData.sendGetPvpLogs(Battle_pb.PB_BATTLE_MATCH)
end

return var_0_0
