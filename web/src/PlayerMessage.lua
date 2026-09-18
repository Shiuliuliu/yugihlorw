local var_0_0 = class("PlayerMessage")
local var_0_1 = require("Message")

var_0_0.Event = {
	msg_update = "msg update",
	union_clear = "union clear",
	msg_new = "msg new",
	send_ok = "send ok"
}

local var_0_2 = {
	ClientData.ConfigKey.new_world_msg,
	ClientData.ConfigKey.new_bulletin_msg,
	ClientData.ConfigKey.new_battle_msg,
	ClientData.ConfigKey.new_union_msg
}

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._msgAll = {
		{},
		{},
		{},
		{}
	}
	pcall(function()
		if _G.flushPendingChatQueue then _G.flushPendingChatQueue() end
	end)
end

function var_0_0.clearUnion(arg_4_0)
	arg_4_0._msgAll[Data.MsgType.union] = {}

	arg_4_0:sendMessageEvent(var_0_0.Event.union_clear)
end

function var_0_0.getNew(arg_5_0, arg_5_1)
	if arg_5_1 then
		local var_5_0 = {}

		if type(arg_5_1) == "number" then
			var_5_0 = arg_5_0._msgAll[arg_5_1]
			arg_5_1 = var_0_2[arg_5_1]
		end

		local var_5_1 = lc.readConfig(arg_5_1, 0)
		local var_5_2 = 0

		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			if iter_5_1._user and iter_5_1._user._id ~= P._id and math.floor(iter_5_1._timestamp) > math.ceil(var_5_1) then
				var_5_2 = var_5_2 + 1
			end
		end

		return var_5_2
	end

	return arg_5_0:getNewWorld() + arg_5_0:getNewUnion() + arg_5_0:getNewBulletin() + arg_5_0:getNewBattle()
end

function var_0_0.clearNew(arg_6_0, arg_6_1)
	if type(arg_6_1) == "number" then
		arg_6_1 = var_0_2[arg_6_1]
	end

	lc.writeConfig(arg_6_1, ClientData.getCurrentTime())
end

function var_0_0.getNewWorld(arg_7_0)
	return arg_7_0:getNew(Data.MsgType.world)
end

function var_0_0.getNewUnion(arg_8_0)
	return arg_8_0:getNew(Data.MsgType.union)
end

function var_0_0.getNewBulletin(arg_9_0)
	return arg_9_0:getNew(Data.MsgType.bulletin)
end

function var_0_0.getNewBattle(arg_10_0)
	return arg_10_0:getNew(Data.MsgType.battle)
end

function var_0_0.addMsg(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_1.new(arg_11_1, arg_11_2)

	if var_11_0._hiddenInChat then
		return nil
	end

	local var_11_1 = arg_11_0._msgAll[var_11_0._type]

	if ((arg_11_2 == SglMsgType_pb.PB_TYPE_UNION_MESSAGE or arg_11_2 == SglMsgType_pb.PB_TYPE_FRIEND_BATTLE) and ClientData.MAX_UNION_MSG_COUNT or ClientData.MAX_MSG_COUNT) <= #var_11_1 then
		table.remove(var_11_1, #var_11_1)
	end

	table.insert(var_11_1, 1, var_11_0)

	return var_11_0
end

function var_0_0.isLogShared(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._msgAll[Data.MsgType.battle]) do
		if iter_12_1._log and iter_12_1._log._id == arg_12_1 then
			return true
		end
	end

	return false
end

function var_0_0.sendMessageEvent(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = cc.EventCustom:new(Data.Event.message)

	var_13_0._event = arg_13_1
	var_13_0._type = arg_13_2
	var_13_0._param = arg_13_3

	lc.Dispatcher:dispatchEvent(var_13_0)
end

function var_0_0.onMsg(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2 = arg_14_2 or arg_14_1.type

	if arg_14_2 == SglMsgType_pb.PB_TYPE_USER_LOADING_DONE then
		arg_14_0:onMsg(arg_14_1, SglMsgType_pb.PB_TYPE_CHAT)
		arg_14_0:onMsg(arg_14_1, SglMsgType_pb.PB_TYPE_NEWS)
		arg_14_0:onMsg(arg_14_1, SglMsgType_pb.PB_TYPE_BATTLE_SHARE)

		return true
	elseif arg_14_2 == SglMsgType_pb.PB_TYPE_CHAT then
		local var_14_0 = arg_14_1.Extensions[Chat_pb.SglChatMsg.chat_receive_resp]
		local var_14_1 = 0
		local var_14_2 = 0

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			local var_14_3 = arg_14_0:addMsg(iter_14_1, arg_14_2)

			if var_14_3 then
				if var_14_3._type == Data.MsgType.world then
					var_14_1 = var_14_1 + 1
				else
					var_14_2 = var_14_2 + 1
				end
			end
		end

		if var_14_1 > 0 then
			arg_14_0:sendMessageEvent(var_0_0.Event.msg_new, Data.MsgType.world, var_14_1)
		end

		if var_14_2 > 0 then
			arg_14_0:sendMessageEvent(var_0_0.Event.msg_new, Data.MsgType.bulletin, var_14_2)
		end

		return true
	elseif arg_14_2 == SglMsgType_pb.PB_TYPE_UNION_MESSAGE then
		if P:hasUnion() then
			local var_14_4 = arg_14_1.Extensions[Union_pb.SglUnionMsg.union_message_resp]
			local var_14_5 = 0

			for iter_14_2, iter_14_3 in ipairs(var_14_4) do
				if arg_14_0:addMsg(iter_14_3, arg_14_2) then
					var_14_5 = var_14_5 + 1
				end
			end

			local var_14_6 = arg_14_1.Extensions[Friend_pb.SglFriendMsg.friend_battle_resp]

			for iter_14_4, iter_14_5 in ipairs(var_14_6) do
				if arg_14_0:addMsg(iter_14_5, SglMsgType_pb.PB_TYPE_FRIEND_BATTLE) then
					var_14_5 = var_14_5 + 1
				end
			end

			table.sort(arg_14_0._msgAll[Data.MsgType.union], function(arg_15_0, arg_15_1)
				return arg_15_0._timestamp > arg_15_1._timestamp
			end)

			if var_14_5 > 0 then
				arg_14_0:sendMessageEvent(var_0_0.Event.msg_new, Data.MsgType.union, var_14_5)
			end
		end
	elseif arg_14_2 == SglMsgType_pb.PB_TYPE_NEWS then
		local var_14_7 = arg_14_1.Extensions[News_pb.SglNewsMsg.news_receive_resp]
		local var_14_8 = 0

		for iter_14_6, iter_14_7 in ipairs(var_14_7) do
			if arg_14_0:addMsg(iter_14_7, arg_14_2) then
				var_14_8 = var_14_8 + 1
			end
		end

		arg_14_0:sendMessageEvent(var_0_0.Event.msg_new, Data.MsgType.bulletin, var_14_8)

		return true
	elseif arg_14_2 == SglMsgType_pb.PB_TYPE_BATTLE_SHARE then
		local var_14_9 = arg_14_1.Extensions[Battle_pb.SglBattleMsg.battle_share_resp]
		local var_14_10 = 0

		for iter_14_8, iter_14_9 in ipairs(var_14_9) do
			local var_14_11 = arg_14_0:addMsg(iter_14_9, arg_14_2)

			if var_14_11 then
				var_14_10 = var_14_10 + 1

				if var_14_11._log and var_14_11._user._id > 0 then
					P._playerLog:sendLogDirty(P._playerLog.Event.log_item_dirty, var_14_11._log._id)
				end
			end
		end

		arg_14_0:sendMessageEvent(var_0_0.Event.msg_new, Data.MsgType.battle, var_14_10)

		return true
	elseif arg_14_2 == SglMsgType_pb.PB_TYPE_FRIEND_BATTLE_START then
		local var_14_12 = arg_14_1.Extensions[Friend_pb.SglFriendMsg.friend_battle_start_resp]

		if arg_14_0:addMsg(var_14_12, arg_14_2) then
			arg_14_0:sendMessageEvent(var_0_0.Event.msg_new, Data.MsgType.battle, 1)
		end

		return true
	elseif arg_14_2 == SglMsgType_pb.PB_TYPE_FRIEND_BATTLE_END then
		local var_14_13 = arg_14_1.Extensions[Friend_pb.SglFriendMsg.friend_battle_end_resp]

		for iter_14_10, iter_14_11 in ipairs(arg_14_0._msgAll[Data.MsgType.battle]) do
			if iter_14_11._battleId == var_14_13.id then
				iter_14_11._result = var_14_13.result_type == Data.BattleResult.win and 1 or 0
				iter_14_11._content = var_14_13.result_type == Data.BattleResult.win and Str(STR.FRIEND_BATTLE_WIN) or Str(STR.FRIEND_BATTLE_LOSE)

				arg_14_0:sendMessageEvent(var_0_0.Event.msg_update, Data.MsgType.battle, iter_14_11)

				break
			end
		end

		return true
	elseif arg_14_2 == SglMsgType_pb.PB_TYPE_USER_BAN_CHAT then
		local var_14_14 = arg_14_1.Extensions[User_pb.SglUserMsg.user_ban_chat_resp]

		P._chatBanList[var_14_14] = true

		return true
	elseif arg_14_2 == SglMsgType_pb.PB_TYPE_BATTLE_THUMBS_UP or arg_14_2 == SglMsgType_pb.PB_TYPE_BATTLE_THUMBS_UP_CANCEL then
		local var_14_15 = arg_14_1.Extensions[Battle_pb.SglBattleMsg.battle_thumbs_up_resp]
		local var_14_16 = var_14_15.user_id
		local var_14_17 = var_14_15.log_id

		for iter_14_12, iter_14_13 in ipairs(arg_14_0._msgAll[Data.MsgType.battle]) do
			if iter_14_13._log and iter_14_13._log._id == var_14_15.log_id then
				if arg_14_2 == SglMsgType_pb.PB_TYPE_BATTLE_THUMBS_UP then
					iter_14_13._likeIds[var_14_16] = true
					iter_14_13._likeIdsCount = iter_14_13._likeIdsCount + 1
				else
					iter_14_13._likeIds[var_14_16] = nil
					iter_14_13._likeIdsCount = math.max(0, iter_14_13._likeIdsCount - 1)
				end

				arg_14_0:sendMessageEvent(var_0_0.Event.msg_update, Data.MsgType.battle, iter_14_13)

				break
			end
		end

		return true
	elseif arg_14_2 == SglMsgType_pb.PB_TYPE_BATTLE_SHARE_WATCH then
		local var_14_18 = arg_14_1.Extensions[Battle_pb.SglBattleMsg.battle_share_watch_resp]
		local var_14_19 = var_14_18.user_id
		local var_14_20 = var_14_18.log_id

		for iter_14_14, iter_14_15 in ipairs(arg_14_0._msgAll[Data.MsgType.battle]) do
			if iter_14_15._log and iter_14_15._log._id == var_14_18.log_id then
				if not iter_14_15._watchIds[var_14_19] then
					iter_14_15._watchIds[var_14_19] = true
					iter_14_15._watchIdsCount = iter_14_15._watchIdsCount + 1
				end

				arg_14_0:sendMessageEvent(var_0_0.Event.msg_update, Data.MsgType.battle, iter_14_15)

				break
			end
		end

		return true
	elseif arg_14_2 == SglMsgType_pb.PB_TYPE_FRIEND_BATTLE_UPDATE then
		local var_14_21 = arg_14_1.Extensions[Friend_pb.SglFriendMsg.friend_battle_update_resp]

		for iter_14_16, iter_14_17 in ipairs(arg_14_0._msgAll[Data.MsgType.union]) do
			if iter_14_17._battleId and iter_14_17._battleId == var_14_21.battle_id then
				if var_14_21:HasField("user2") then
					iter_14_17._opponent = require("User").create(var_14_21.user2)
				end

				iter_14_17._isValid = var_14_21.is_valid

				if var_14_21:HasField("result") then
					iter_14_17._resultType = var_14_21.result.result_type
					iter_14_17._replayId = var_14_21.result.replay_id
				end

				arg_14_0:sendMessageEvent(var_0_0.Event.msg_update, Data.MsgType.union, iter_14_17)

				break
			end
		end
	end

	return false
end

return var_0_0
