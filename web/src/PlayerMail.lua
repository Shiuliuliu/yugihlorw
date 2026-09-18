local var_0_0 = class("PlayerMail")
local var_0_1 = require("Mail")

var_0_0.Event = {
	mail_dirty = "mail dirty",
	mail_list_dirty = "mail list dirty",
	send_ok = "send ok"
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._mails = {}

	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._mails = {}
end

function var_0_0.refreshMails(arg_4_0, arg_4_1)
	arg_4_0._mails = {}

	for iter_4_0 = 1, #arg_4_1 do
		local var_4_0 = var_0_1.create(arg_4_1[iter_4_0])

		arg_4_0:addMail(var_4_0)
	end

	arg_4_0:sendMailEvent(arg_4_0.Event.mail_list_dirty)
end

function var_0_0.addMail(arg_5_0, arg_5_1)
	arg_5_0._mails[arg_5_1._id] = arg_5_1
end

function var_0_0.sendMailEvent(arg_6_0, arg_6_1)
	local var_6_0 = cc.EventCustom:new(Data.Event.mail)

	var_6_0._event = arg_6_1

	lc.Dispatcher:dispatchEvent(var_6_0)
end

function var_0_0.getMailList(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}

	if arg_7_0._mails then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._mails) do
			if (iter_7_1._type == arg_7_1 or iter_7_1._type == arg_7_2) and arg_7_0:isMailVisible(iter_7_1) then
				table.insert(var_7_0, iter_7_1)
			end
		end
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0._timestamp > arg_8_1._timestamp
	end)

	return var_7_0
end

function var_0_0.isMailVisible(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1._isIgnore

	if arg_9_1._type == Mail_pb.PB_MAIL_UNION and not var_9_0 then
		local var_9_1 = P._playerUnion

		if arg_9_1._applyStatus and var_9_1:canOperate(var_9_1.Operate.agree_user) ~= Data.ErrorType.ok then
			var_9_0 = true
		end
	end

	return not var_9_0
end

function var_0_0.acceptMail(arg_10_0, arg_10_1)
	if arg_10_1._type == Mail_pb.PB_MAIL_FRIEND then
		if arg_10_1._inviteStatus then
			ClientData.sendUnionAcceptInvite(arg_10_1._id, true)
		end
	elseif arg_10_1._type == Mail_pb.PB_MAIL_UNION and arg_10_1._applyStatus then
		ClientData.sendUnionAcceptApply(arg_10_1._id, true)
	end
end

function var_0_0.refuseMail(arg_11_0, arg_11_1)
	if arg_11_1._type == Mail_pb.PB_MAIL_FRIEND then
		if arg_11_1._inviteStatus then
			arg_11_1._inviteStatus = SglMsg_pb.PB_INVITE_REFUSED

			ClientData.sendUnionAcceptInvite(arg_11_1._id, false)
		end
	elseif arg_11_1._type == Mail_pb.PB_MAIL_UNION and arg_11_1._applyStatus then
		arg_11_1._applyStatus = SglMsg_pb.PB_INVITE_REFUSED

		ClientData.sendUnionAcceptApply(arg_11_1._id, false)
	end

	arg_11_1:sendMailDirty()
end

function var_0_0.getNewUnionMails(arg_12_0)
	local var_12_0 = lc.readConfig(ClientData.ConfigKey.new_union_mail, 0)
	local var_12_1 = 0

	if arg_12_0._mails then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._mails) do
			if iter_12_1._type == Mail_pb.PB_MAIL_UNION and arg_12_0:isMailVisible(iter_12_1) and math.floor(iter_12_1._timestamp) > math.floor(var_12_0) then
				var_12_1 = var_12_1 + 1
			end
		end
	end

	return var_12_1
end

function var_0_0.clearNewUnionMails(arg_13_0)
	lc.writeConfig(ClientData.ConfigKey.new_union_mail, ClientData.getCurrentTime())
end

function var_0_0.getNewMsgMails(arg_14_0)
	local var_14_0 = lc.readConfig(ClientData.ConfigKey.new_friend_mail, 0)
	local var_14_1 = 0

	if arg_14_0._mails ~= nil then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._mails) do
			if iter_14_1._type == (Mail_pb.PB_MAIL_FRIEND or iter_14_1._type == Mail_pb.PB_MAIL_NOTIFY) and math.floor(iter_14_1._timestamp) > math.floor(var_14_0) then
				var_14_1 = var_14_1 + 1
			end
		end
	end

	return var_14_1
end

function var_0_0.clearNewMsgMails(arg_15_0)
	lc.writeConfig(ClientData.ConfigKey.new_friend_mail, ClientData.getCurrentTime())
end

function var_0_0.getNewSystemMails(arg_16_0)
	return arg_16_0:getNewAnnouncements() + arg_16_0:getNewNoticeMails() + P._playerBonus:getClaimCenterBonusFlag() + P._playerBonus:getSendBonusFlag()
end

function var_0_0.getNewAnnouncements(arg_17_0)
	local var_17_0 = lc.readConfig(ClientData.ConfigKey.new_announce, 0)
	local var_17_1 = 0

	for iter_17_0, iter_17_1 in ipairs(ClientData._player._systemAnnouncement) do
		if math.floor(iter_17_1._timestamp) > math.floor(var_17_0) then
			var_17_1 = var_17_1 + 1
		end
	end

	return var_17_1
end

function var_0_0.getNewNoticeMails(arg_18_0)
	local var_18_0 = lc.readConfig(ClientData.ConfigKey.new_notice_mail, 0)
	local var_18_1 = 0

	if arg_18_0._mails then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._mails) do
			if iter_18_1._type == Mail_pb.PB_MAIL_SYSTEM and math.floor(iter_18_1._timestamp) > math.floor(var_18_0) then
				var_18_1 = var_18_1 + 1
			end
		end
	end

	return var_18_1
end

function var_0_0.clearNewAnnouncements(arg_19_0)
	lc.writeConfig(ClientData.ConfigKey.new_announce, ClientData.getCurrentTime())
end

function var_0_0.clearNewNoticeMails(arg_20_0)
	lc.writeConfig(ClientData.ConfigKey.new_notice_mail, ClientData.getCurrentTime())
end

function var_0_0.onMsg(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.type
	local var_21_1 = arg_21_1.status

	if var_21_0 == SglMsgType_pb.PB_TYPE_MAIL_SEND then
		arg_21_0:sendMailEvent(arg_21_0.Event.send_ok)

		return true
	elseif var_21_0 == SglMsgType_pb.PB_TYPE_MAIL_LIST then
		local var_21_2 = arg_21_1.Extensions[Mail_pb.SglMailMsg.mail_list_resp]

		arg_21_0:refreshMails(var_21_2)

		return true
	elseif var_21_0 == SglMsgType_pb.PB_TYPE_MAIL_RECEIVE then
		local var_21_3 = arg_21_1.Extensions[Mail_pb.SglMailMsg.mail_receive_resp]
		local var_21_4 = var_0_1.create(var_21_3)

		arg_21_0:addMail(var_21_4)
		arg_21_0:sendMailEvent(arg_21_0.Event.mail_list_dirty)

		if var_21_4._type == Mail_pb.PB_MAIL_SYSTEM then
			local var_21_5 = cc.EventCustom:new(Data.Event.push_notice)

			var_21_5._title = Str(STR.NEW_SYS_MAIL)
			var_21_5._content = var_21_4._title
			var_21_5._isImportant = var_21_4._isImportant

			lc.Dispatcher:dispatchEvent(var_21_5)
		end

		return true
	elseif var_21_0 == SglMsgType_pb.PB_TYPE_UNION_ACCEPT_INVITE then
		local var_21_6 = arg_21_1.Extensions[Union_pb.SglUnionMsg.union_accept_resp]
		local var_21_7 = arg_21_0._mails[var_21_6]

		if var_21_7._inviteStatus == SglMsg_pb.PB_INVITE_INVITED then
			var_21_7._inviteStatus = SglMsg_pb.PB_INVITE_ACCEPTED

			var_21_7:sendMailDirty()
		end

		return true
	elseif var_21_0 == SglMsgType_pb.PB_TYPE_UNION_ACCEPT_APPLY then
		local var_21_8 = arg_21_1.Extensions[Union_pb.SglUnionMsg.union_accept_resp]
		local var_21_9 = arg_21_0._mails[var_21_8]

		if var_21_9._applyStatus == SglMsg_pb.PB_APPLY_APPLIED then
			var_21_9._applyStatus = SglMsg_pb.PB_APPLY_ACCEPTED

			var_21_9:sendMailDirty()
		end
	end

	return false
end

return var_0_0
