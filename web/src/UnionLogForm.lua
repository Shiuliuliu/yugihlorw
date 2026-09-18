local var_0_0 = class("UnionLogForm", BaseForm)
local var_0_1 = cc.size(900, 700)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.UNION) .. Str(STR.UNION_LOG), 0)

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 30, 0)

	lc.addChildToPos(arg_2_0._frame, var_2_0, cc.p(4, ClientView.FRAME_INNER_BOTTOM))

	arg_2_0._list = var_2_0

	if ClientData._unionLogs == nil then
		arg_2_0._activeIndicator = ClientView.showPanelActiveIndicator(arg_2_0._form)
	else
		arg_2_0:updateLogs()
	end
end

function var_0_0.parseLog(arg_3_0, arg_3_1)
	local var_3_0 = {
		_content = "",
		_timestamp = arg_3_1.timestamp / 1000
	}

	var_3_0._date = os.date("!*t", var_3_0._timestamp + ClientData._timezone)

	local var_3_1 = arg_3_1.user1.name
	local var_3_2

	if arg_3_1:HasField("user2") then
		var_3_2 = arg_3_1.user2.name
	end

	local var_3_3 = arg_3_1.type

	if var_3_3 == Union_pb.PB_UNION_CREATE then
		var_3_0._content = string.format("|%s|%s|%s|", var_3_1, Str(STR.CREATE_UNION), arg_3_1.user1.union_name)
	elseif var_3_3 == Union_pb.PB_UNION_JOIN then
		if var_3_2 then
			var_3_0._content = string.format("|%s|" .. Str(STR.BE_INVITED_TO) .. "%s", var_3_1, var_3_2, Str(STR.UNION_JOIN_NEWS))
		else
			var_3_0._content = string.format("|%s|%s", var_3_1, Str(STR.UNION_JOIN_NEWS))
		end
	elseif var_3_3 == Union_pb.PB_UNION_KICKOUT then
		var_3_0._content = string.format("|%s|" .. Str(STR.UNION_KICKOUT_NEWS), var_3_1, var_3_2)
	elseif var_3_3 == Union_pb.PB_UNION_LEAVE then
		var_3_0._content = string.format("|%s|%s", var_3_1, Str(STR.UNION_LEAVE_NEWS))
	elseif var_3_3 == Union_pb.PB_UNION_TO_CO_LEADER or var_3_3 == Union_pb.PB_UNION_TO_MEMBER then
		var_3_0._content = string.format("|%s|" .. Str(STR.UNION_CHANGE_JOB_NEWS), var_3_1, var_3_2, Str(STR.ROOKIE + arg_3_1.user2.union_title - 1))
	elseif var_3_3 == Union_pb.PB_UNION_TO_LEADER then
		var_3_0._content = string.format("|%s|%s", var_3_1, Str(STR.UNION_TO_LEADER))
	elseif var_3_3 == Union_pb.PB_UNION_RESIGN then
		var_3_0._content = string.format("|%s|" .. Str(STR.UNION_GIVE_LEADER_TO), var_3_1, var_3_2)
	elseif var_3_3 == Union_pb.PB_UNION_UPGRADE then
		var_3_0._content = string.format("|%s|" .. Str(STR.UNION_UPGRADE_NEWS), var_3_1, arg_3_1.param1)
	elseif var_3_3 == Union_pb.PB_UNION_TECH_UPGRADE then
		local var_3_4 = P._playerUnion:getMyUnion()

		if var_3_4 then
			var_3_0._content = string.format("|%s|" .. Str(STR.UNION_UPGRADE_TECH_NEWS), var_3_1, Str(var_3_4._techs[arg_3_1.param2]._info._nameSid), arg_3_1.param1)
		else
			var_3_0._content = ""
		end
	elseif var_3_3 == Union_pb.PB_UNION_DONATE then
		var_3_0._msg = arg_3_1
	elseif var_3_3 == Union_pb.PB_UNION_IMPEACHED then
		var_3_0._content = string.format("|%s|" .. Str(STR.UNION_IMPEACHED_NEWS), var_3_1)
	end

	return var_3_0
end

function var_0_0.mergeLog(arg_4_0, arg_4_1, arg_4_2)
	table.sort(arg_4_2, function(arg_5_0, arg_5_1)
		return arg_5_0._timestamp > arg_5_1._timestamp
	end)

	local var_4_0 = arg_4_2[1]._msg.type
	local var_4_1 = 0
	local var_4_2 = 0
	local var_4_3 = 0
	local var_4_4 = 0

	if var_4_0 == Union_pb.PB_UNION_DONATE then
		local function var_4_5(arg_6_0, arg_6_1)
			if arg_6_1 > 0 then
				arg_6_0._content = string.format(Str(STR.NEWS_MEMBER_ALL_CONTRIBUTE), arg_6_1)

				table.insert(arg_4_1, arg_6_0)
			end
		end

		local var_4_6 = 0

		for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
			local var_4_7 = iter_4_1._date

			if var_4_7.year ~= var_4_2 or var_4_7.month ~= var_4_3 or var_4_7.day ~= var_4_4 then
				var_4_5(var_4_1, var_4_6)

				var_4_1, var_4_2, var_4_3, var_4_4 = iter_4_1, var_4_7.year, var_4_7.month, var_4_7.day
				var_4_6 = 0
			end

			for iter_4_2, iter_4_3 in ipairs(iter_4_1._msg.resource) do
				if iter_4_3.info_id == Data.ResType.union_act then
					var_4_6 = var_4_6 + iter_4_3.num
				end
			end
		end

		var_4_5(var_4_1, var_4_6)
	end

	return log
end

function var_0_0.updateLogs(arg_7_0)
	local var_7_0 = ClientData._unionLogs
	local var_7_1 = arg_7_0._list

	var_7_1:bindData(var_7_0, function(arg_8_0, arg_8_1)
		arg_7_0:setOrCreateLogItem(arg_8_0, arg_8_1)
	end, math.min(25, #var_7_0))

	for iter_7_0 = 1, var_7_1._cacheCount do
		local var_7_2 = arg_7_0:setOrCreateLogItem(nil, var_7_0[iter_7_0])

		var_7_1:pushBackCustomItem(var_7_2)
	end

	var_7_1:forceDoLayout()
	var_7_1:jumpToTop()
end

function var_0_0.setOrCreateLogItem(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == nil then
		arg_9_1 = ccui.Widget:create()

		arg_9_1:setContentSize(830, 32)

		local var_9_0 = ClientView.createTTF("")

		var_9_0:setAnchorPoint(0, 0.5)
		lc.addChildToPos(arg_9_1, var_9_0, cc.p(70, lc.h(arg_9_1) / 2))

		arg_9_1._label = var_9_0
	end

	arg_9_1._log = arg_9_2

	if arg_9_1._removeElement then
		arg_9_1._removeElement:removeFromParent()
	end

	if arg_9_2._date then
		arg_9_1._label:setString(string.format("%02d:%02d", arg_9_2._date.hour, arg_9_2._date.min))
		arg_9_1._label:setColor(ClientView.COLOR_LABEL_LIGHT)

		local var_9_1 = ClientView.createBoldRichText(arg_9_2._content, ClientView.RICHTEXT_PARAM_LIGHT_S2)

		var_9_1:setAnchorPoint(cc.p(0, 0.5))
		lc.addChildToPos(arg_9_1, var_9_1, cc.p(150, lc.y(arg_9_1._label)))

		arg_9_1._removeElement = var_9_1
	else
		arg_9_1._label:setString(arg_9_2._content)
		arg_9_1._label:setColor(ClientView.COLOR_TEXT_LIGHT)

		local var_9_2 = lc.createSprite({
			_name = "img_com_bg_2",
			_crect = ClientView.CRECT_COM_BG2,
			_size = cc.size(300, 30)
		})

		var_9_2:setColor(lc.Color3B.black)
		var_9_2:setOpacity(100)
		lc.addChildToPos(arg_9_1, var_9_2, cc.p(lc.w(var_9_2) / 2 + 50, lc.h(arg_9_1) / 2), -1)

		arg_9_1._removeElement = var_9_2
	end

	return arg_9_1
end

function var_0_0.removeIndicator(arg_10_0)
	if arg_10_0._activeIndicator then
		arg_10_0._activeIndicator:removeFromParent()

		arg_10_0._activeIndicator = nil
	end
end

function var_0_0.onEnter(arg_11_0)
	var_0_0.super.onEnter(arg_11_0)
	ClientData.addMsgListener(arg_11_0, function(arg_12_0)
		return arg_11_0:onMsg(arg_12_0)
	end, 0)
end

function var_0_0.onExit(arg_13_0)
	var_0_0.super.onExit(arg_13_0)
	ClientData.removeMsgListener(arg_13_0)
end

function var_0_0.onShowActionFinished(arg_14_0)
	if ClientData._unionLogs == nil then
		ClientData.sendGetUnionLog()
	end
end

function var_0_0.onMsg(arg_15_0, arg_15_1)
	if arg_15_1.type == SglMsgType_pb.PB_TYPE_UNION_LOG then
		arg_15_0:removeIndicator()

		local var_15_0 = arg_15_1.Extensions[Union_pb.SglUnionMsg.union_message_resp]
		local var_15_1 = {}
		local var_15_2 = {}

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_3 = arg_15_0:parseLog(iter_15_1)

			if var_15_3._msg then
				var_15_2[iter_15_1.type] = var_15_2[iter_15_1.type] or {}

				table.insert(var_15_2[iter_15_1.type], var_15_3)
			else
				table.insert(var_15_1, var_15_3)
			end
		end

		for iter_15_2, iter_15_3 in pairs(var_15_2) do
			arg_15_0:mergeLog(var_15_1, iter_15_3)
		end

		table.sort(var_15_1, function(arg_16_0, arg_16_1)
			return arg_16_0._timestamp > arg_16_1._timestamp
		end)

		local var_15_4 = 1
		local var_15_5 = 0
		local var_15_6 = 0
		local var_15_7 = 0

		while var_15_4 <= #var_15_1 do
			local var_15_8 = var_15_1[var_15_4]._date

			if var_15_8.year ~= var_15_5 or var_15_8.month ~= var_15_6 or var_15_8.day ~= var_15_7 then
				var_15_5, var_15_6, var_15_7 = var_15_8.year, var_15_8.month, var_15_8.day

				table.insert(var_15_1, var_15_4, {
					_content = string.format("%s%s%s%s%s%s", var_15_5, Str(STR.YEAR), var_15_6, Str(STR.MONTH), var_15_7, Str(STR.DAY_RI))
				})

				var_15_4 = var_15_4 + 1
			end

			var_15_4 = var_15_4 + 1
		end

		ClientData._unionLogs = var_15_1

		arg_15_0:updateLogs()

		return true
	end

	return false
end

return var_0_0
