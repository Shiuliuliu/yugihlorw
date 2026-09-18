local var_0_0 = class("SystemMailItem", lc.ExtendUIWidget)

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_IMAGE, "img_com_bg_33", ccui.TextureResType.plistType)

	var_1_0:setScale9Enabled(true)
	var_1_0:setCapInsets(ClientView.CRECT_COM_BG33)
	var_1_0:setContentSize(cc.size(arg_1_0, 190))
	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1._content
	local var_2_1 = lc.createSprite("img_deco_bar_01")

	lc.addChildToPos(arg_2_0, var_2_1, cc.p(lc.w(var_2_1) / 2, lc.h(arg_2_0) - lc.h(var_2_1) / 2 - 20))

	local var_2_2 = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2)

	var_2_2:setAnchorPoint(0, 0.5)
	var_2_2:setColor(ClientView.COLOR_TEXT_LIGHT)
	lc.addChildToPos(var_2_1, var_2_2, cc.p(40, lc.h(var_2_1) / 2))

	arg_2_0._title = var_2_2

	if arg_2_2 then
		local var_2_3 = ClientView.createTTF("", ClientView.FontSize.S2, ClientView.COLOR_TEXT_TITLE)

		var_2_3:setAnchorPoint(1, 0.5)
		lc.addChildToPos(var_2_1, var_2_3, cc.p(lc.w(var_2_1) - 62, lc.h(var_2_1) / 2))

		arg_2_0._time = var_2_3
	end

	local var_2_4 = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2, cc.size(lc.w(arg_2_0) - 248, 66))

	var_2_4:setAnchorPoint(0, 1)
	var_2_4:setColor(ClientView.COLOR_TEXT_DARK)
	lc.addChildToPos(arg_2_0, var_2_4, cc.p(50, lc.bottom(var_2_1) - 20))

	arg_2_0._content = var_2_4

	local function var_2_5()
		require("MailDetailForm").create(arg_2_0._title:getString(), arg_2_0._mail._content, arg_2_0._mail._timestamp):show()
	end

	local var_2_6 = ClientView.createScale9ShaderButton("img_btn_1", var_2_5, ClientView.CRECT_BUTTON, 120)

	var_2_6:addLabel(Str(STR.DETAIL))
	lc.addChildToPos(arg_2_0, var_2_6, cc.p(lc.w(arg_2_0) - 50 - lc.w(var_2_6) / 2, lc.top(var_2_4) - lc.h(var_2_6) / 2))
	arg_2_0:setTouchEnabled(true)
	arg_2_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	arg_2_0:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 == ccui.TouchEventType.ended then
			var_2_5()
		end
	end)
	arg_2_0:setMail(arg_2_1)
end

function var_0_0.setMail(arg_5_0, arg_5_1)
	arg_5_0._mail = arg_5_1

	arg_5_0._title:setString(arg_5_1._title or Str(STR.NO_TITLE))

	if arg_5_0._time then
		arg_5_0._time:setString(ClientData.getTimeAgo(arg_5_1._timestamp))
	end

	local var_5_0 = string.gsub(arg_5_1._content, "|", "")

	arg_5_0._content:setString(var_5_0)
end

local var_0_1 = class("MsgMailItem", lc.ExtendUIWidget)

function var_0_1.create(arg_6_0, arg_6_1)
	local var_6_0 = var_0_1.new(lc.EXTEND_IMAGE, "img_com_bg_33", ccui.TextureResType.plistType)

	var_6_0:init(arg_6_0, arg_6_1)

	return var_6_0
end

function var_0_1.onEnter(arg_7_0)
	arg_7_0._listener = lc.addEventListener(Data.Event.mail, function(arg_8_0)
		local var_8_0 = require("PlayerMail")

		if arg_8_0._event == var_8_0.Event.mail_dirty and arg_8_0._data == arg_7_0._mail then
			ClientView.getActiveIndicator():hide()
			arg_7_0:updateView()
		end
	end)

	arg_7_0:updateView()
end

function var_0_1.onExit(arg_9_0)
	lc.Dispatcher:removeEventListener(arg_9_0._listener)
end

function var_0_1.init(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:setScale9Enabled(true)
	arg_10_0:setCapInsets(ClientView.CRECT_COM_BG33)
	arg_10_0:setContentSize(cc.size(arg_10_1, 160))
	arg_10_0:setAnchorPoint(0.5, 0.5)
	arg_10_0:setTouchEnabled(true)
	arg_10_0:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 == ccui.TouchEventType.ended then
			ClientView.operateUser(arg_10_0._mail._user, arg_10_0)
		end
	end)

	arg_10_0._mail = arg_10_2

	local var_10_0 = UserWidget.create(arg_10_2._user, UserWidget.Flag.NAME_UNION)

	var_10_0:setScale(0.95)
	lc.addChildToPos(arg_10_0, var_10_0, cc.p(lc.w(var_10_0) / 2 + 28, lc.h(arg_10_0) / 2 + 4))

	arg_10_0._userArea = var_10_0

	local var_10_1 = ClientView.createTTF("0", nil, ClientView.COLOR_TEXT_DARK, cc.size(292, 100), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)

	var_10_1:setAnchorPoint(0, 1)
	lc.addChildToPos(arg_10_0, var_10_1, cc.p(lc.w(arg_10_0) - lc.w(var_10_1) - 16, lc.top(var_10_0) + 8))

	arg_10_0._content = var_10_1

	local var_10_2 = ClientView.createTTF("", nil, ClientView.COLOR_LABEL_DARK)

	var_10_2:setAnchorPoint(1, 0.5)
	lc.addChildToPos(arg_10_0, var_10_2, cc.p(lc.right(var_10_1), 32 + lc.h(var_10_2) / 2))

	arg_10_0._time = var_10_2
end

function var_0_1.updateView(arg_12_0)
	local var_12_0 = arg_12_0._mail

	arg_12_0._userArea:setUser(var_12_0._user, true)
	arg_12_0._time:setString(ClientData.getTimeAgo(var_12_0._timestamp))
	arg_12_0._content:setDimensions(292, 100)
	arg_12_0._content:setString(var_12_0._title or var_12_0._content)

	local var_12_1 = 1000

	local function var_12_2(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		arg_12_0._content:setDimensions(292, 54)
		arg_13_0:addLabel(arg_13_1)
		lc.addChildToPos(arg_12_0, arg_13_0, cc.p(lc.left(arg_12_0._content) + lc.w(arg_13_0) / 2, lc.bottom(arg_12_0._time) + lc.h(arg_13_0) / 2), 0, var_12_1)

		if arg_13_2 then
			arg_13_2:addLabel(arg_13_3)
			lc.addChildToPos(arg_12_0, arg_13_2, cc.p(lc.right(arg_13_0) + 10 + lc.w(arg_13_2) / 2, lc.y(arg_13_0)), 0, var_12_1)
		end
	end

	local function var_12_3(arg_14_0, arg_14_1)
		arg_12_0._content:setDimensions(292, 54)

		local var_14_0 = lc.createSprite("img_status_rect")

		var_14_0:setColor(arg_14_1)
		var_14_0:setScale(0.8)
		lc.addChildToCenter(var_14_0, ClientView.createTTF(arg_14_0, ClientView.FontSize.S1, arg_14_1))
		lc.addChildToPos(arg_12_0, var_14_0, cc.p(lc.left(arg_12_0._content) + lc.sw(var_14_0) / 2, lc.bottom(arg_12_0._time) + lc.sh(var_14_0) / 2), 0, var_12_1)
	end

	arg_12_0:removeChildrenByTag(var_12_1)

	if var_12_0._title then
		local var_12_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
			require("MailDetailForm").create(var_12_0._title, var_12_0._content, var_12_0._timestamp):show()
		end, ClientView.CRECT_BUTTON_S, 100)

		var_12_2(var_12_4, Str(STR.DETAIL))
	else
		local var_12_5 = var_12_0._inviteStatus or var_12_0._applyStatus or var_12_0._sosStatus

		if var_12_0._inviteStatus or var_12_0._applyStatus then
			if var_12_5 == SglMsg_pb.PB_INVITE_INVITED or var_12_5 == SglMsg_pb.PB_APPLY_APPLIED then
				local var_12_6 = ClientView.createScale9ShaderButton("img_btn_2_s", function()
					P._playerMail:refuseMail(var_12_0)
				end, ClientView.CRECT_BUTTON_S, 100)
				local var_12_7 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
					P._playerMail:acceptMail(var_12_0)
				end, ClientView.CRECT_BUTTON_S, 100)

				var_12_2(var_12_6, Str(STR.REFUSE), var_12_7, Str(STR.ACCEPT))
			elseif var_12_5 == SglMsg_pb.PB_INVITE_ACCEPTED or var_12_5 == SglMsg_pb.PB_APPLY_ACCEPTED then
				var_12_3(Str(STR.ACCEPTED), ClientView.COLOR_TEXT_GREEN)
			else
				var_12_3(Str(STR.REFUSED), ClientView.COLOR_TEXT_RED)
			end
		elseif var_12_0._sosStatus then
			if var_12_5 == SglMsg_pb.PB_SOS_ISSUED then
				local var_12_8 = ClientView.createShaderButton("img_btn_2", function(arg_18_0)
					if var_12_0._opponentId == P._id then
						ToastManager.push(Str(STR.CANT_RESCUE))
					else
						local var_18_0, var_18_1 = P._playerCard:checkTroop(P._curTroopIndex)

						if not var_18_0 then
							ToastManager.push(var_18_1)

							return
						end

						ClientView.getActiveIndicator():show(Str(STR.WAITING), nil, var_12_0)
						ClientData.sendWorldCityRescue(P._curTroopIndex, var_12_0._id)
					end
				end)
				local var_12_9 = ClientView.createShaderButton("img_btn_1", function(arg_19_0)
					require("VisitForm").create(var_12_0._opponentId):show()
				end)

				var_12_2(var_12_8, Str(STR.UNION_HELP), var_12_9, Str(STR.INFO))
			else
				var_12_3(Str(STR.RESCUED), ClientView.COLOR_TEXT_GREEN)
			end
		end
	end
end

function var_0_1.updateMail(arg_20_0, arg_20_1)
	arg_20_0._mail = arg_20_1

	arg_20_0:updateView()
end

local var_0_2 = class("MailForm", BaseForm)
local var_0_3 = cc.size(1010, 640)

var_0_2.SystemMail = {
	announce = 1,
	send = 6,
	notice = 2,
	union = 4,
	leave_message = 5,
	bonus = 3
}

function var_0_2.create()
	local var_21_0 = var_0_2.new(lc.EXTEND_LAYOUT_MASK)

	var_21_0:init()

	return var_21_0
end

function var_0_2.init(arg_22_0)
	var_0_2.super.init(arg_22_0, var_0_3, Str(STR.MAIL), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))
	arg_22_0._form:setTouchEnabled(false)
	arg_22_0:createSystemMailArea()
end

function var_0_2.createSystemMailArea(arg_23_0)
	local var_23_0 = {
		{
			_str = Str(STR.ANNOUNCEMENT)
		},
		{
			_str = Str(STR.NOTICE)
		},
		{
			_str = Str(STR.BONUS)
		},
		{
			_str = Str(STR.UNION)
		},
		{
			_str = Str(STR.LEAVE_MESSAGE)
		},
		{
			_str = Str(STR.SEND_GIFT)
		}
	}
	local var_23_1 = ClientView.createVerticalTabListArea(lc.h(arg_23_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM, var_23_0, function(arg_24_0, arg_24_1, arg_24_2)
		arg_23_0:showSystemTab(arg_24_0._index, not arg_24_1, arg_24_2)
	end)

	lc.addChildToPos(arg_23_0._frame, var_23_1, cc.p(ClientView.FRAME_INNER_LEFT + lc.w(var_23_1) / 2, lc.h(arg_23_0._frame) / 2), 0)

	arg_23_0._tabArea = var_23_1

	local var_23_2 = lc.List.createV(cc.size(lc.w(arg_23_0._frame) - lc.right(var_23_1) - ClientView.FRAME_INNER_RIGHT - 24, lc.h(arg_23_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 30, 10)

	var_23_2:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_23_0._frame, var_23_2, cc.p(lc.right(var_23_1) + 14 + lc.w(var_23_2) / 2, lc.h(arg_23_0._frame) / 2))

	arg_23_0._list = var_23_2

	arg_23_0._tabArea:showTab(1)
end

function var_0_2.showSystemTab(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_2 then
		return
	end

	arg_25_0._focusTabIndex = arg_25_1

	arg_25_0:refreshSystemMails()
end

function var_0_2.showSystemTabFlag(arg_26_0)
	local var_26_0 = arg_26_0._tabArea._list:getItems()

	for iter_26_0 = 1, #var_26_0 do
		local var_26_1 = 0

		if iter_26_0 == var_0_2.SystemMail.bonus then
			var_26_1 = P._playerBonus:getClaimCenterBonusFlag()
		elseif iter_26_0 == var_0_2.SystemMail.announce then
			var_26_1 = P._playerMail:getNewAnnouncements()
		elseif iter_26_0 == var_0_2.SystemMail.notice then
			var_26_1 = P._playerMail:getNewNoticeMails()
		elseif iter_26_0 == var_0_2.SystemMail.union then
			var_26_1 = P._playerMail:getNewUnionMails()
		elseif iter_26_0 == var_0_2.SystemMail.leave_message then
			var_26_1 = P._playerMail:getNewMsgMails()
		elseif iter_26_0 == var_0_2.SystemMail.send then
			var_26_1 = P._playerBonus:getSendBonusFlag()
		end

		local var_26_2 = var_26_0[iter_26_0]

		ClientView.checkNewFlag(var_26_2, var_26_1)
	end
end

function var_0_2.onEnter(arg_27_0)
	var_0_2.super.onEnter(arg_27_0)

	arg_27_0._listeners = {}

	local var_27_0 = lc.addEventListener(Data.Event.mail, function(arg_28_0)
		arg_27_0:onMail(arg_28_0._event)
	end)

	table.insert(arg_27_0._listeners, var_27_0)

	local var_27_1 = lc.addEventListener(Data.Event.server_bonus_list_dirty, function(arg_29_0)
		arg_27_0:onServerBonus()
	end)

	table.insert(arg_27_0._listeners, var_27_1)
end

function var_0_2.onExit(arg_30_0)
	var_0_2.super.onExit(arg_30_0)

	for iter_30_0 = 1, #arg_30_0._listeners do
		lc.Dispatcher:removeEventListener(arg_30_0._listeners[iter_30_0])
	end

	ClientView.getMenuUI():updateMailFlag()
end

function var_0_2.onCleanup(arg_31_0)
	var_0_2.super.onCleanup(arg_31_0)
end

function var_0_2.refreshSystemMails(arg_32_0)
	local var_32_0 = arg_32_0._list

	if arg_32_0._focusTabIndex == var_0_2.SystemMail.bonus then
		local var_32_1 = P._playerBonus._serverBonuses

		local function var_32_2(arg_33_0, arg_33_1)
			local var_33_0 = arg_33_1._info and string.format(Str(arg_33_1._info._nameSid), arg_33_1._info._val) or arg_33_1._title
			local var_33_1 = string.gsub(var_33_0, Str(STR.HUAWEI), "")

			if arg_33_0 == nil then
				arg_33_0 = require("BonusWidget").create(lc.w(var_32_0), arg_33_1, var_33_1)
			else
				arg_33_0:setBonus(arg_33_1, var_33_1)
			end

			arg_33_0:registerCallback(function(arg_34_0)
				local var_34_0 = ClientData.claimBonus(arg_34_0)

				ClientView.showClaimBonusResult(arg_34_0, var_34_0)
				arg_32_0:onClaimBonus()
			end)

			return arg_33_0
		end

		var_32_0:bindData(var_32_1, var_32_2, math.min(5, #var_32_1))

		for iter_32_0 = 1, var_32_0._cacheCount do
			local var_32_3 = var_32_2(nil, var_32_1[iter_32_0])

			var_32_0:pushBackCustomItem(var_32_3)
		end

		var_32_0:checkEmpty(Str(STR.LIST_EMPTY_NO_BONUS))
	elseif arg_32_0._focusTabIndex == var_0_2.SystemMail.send then
		local var_32_4 = P._playerBonus._sendBonuses

		local function var_32_5(arg_35_0, arg_35_1)
			local var_35_0 = arg_35_1._title or string.format(Str(arg_35_1._info._nameSid), arg_35_1._info._val)
			local var_35_1 = string.gsub(var_35_0, Str(STR.HUAWEI), "")

			if arg_35_0 == nil then
				arg_35_0 = require("BonusWidget").create(lc.w(var_32_0), arg_35_1, var_35_1)
			else
				arg_35_0:setBonus(arg_35_1, var_35_1)
			end

			arg_35_0:registerCallback(function(arg_36_0)
				local var_36_0 = ClientData.claimBonus(arg_36_0)

				ClientView.showClaimBonusResult(arg_36_0, var_36_0)
				arg_32_0:onClaimBonus()
			end)

			return arg_35_0
		end

		var_32_0:bindData(var_32_4, var_32_5, math.min(5, #var_32_4))

		for iter_32_1 = 1, var_32_0._cacheCount do
			local var_32_6 = var_32_5(nil, var_32_4[iter_32_1])

			var_32_0:pushBackCustomItem(var_32_6)
		end

		var_32_0:checkEmpty(Str(STR.LIST_EMPTY_NO_BONUS))
	elseif arg_32_0._focusTabIndex == var_0_2.SystemMail.announce then
		local var_32_7 = P._systemAnnouncement

		var_32_0:bindData(var_32_7, function(arg_37_0, arg_37_1)
			arg_37_0:setMail(arg_37_1)
		end, math.min(5, #var_32_7))

		for iter_32_2 = 1, var_32_0._cacheCount do
			local var_32_8 = var_0_0.create(lc.w(var_32_0), var_32_7[iter_32_2])

			var_32_0:pushBackCustomItem(var_32_8)
		end

		P._playerMail:clearNewAnnouncements()
	elseif arg_32_0._focusTabIndex == var_0_2.SystemMail.union then
		local var_32_9 = P._playerMail:getMailList(Mail_pb.PB_MAIL_UNION)

		var_32_0:bindData(var_32_9, function(arg_38_0, arg_38_1)
			arg_38_0:updateMail(arg_38_1)
		end, math.min(5, #var_32_9))

		for iter_32_3 = 1, var_32_0._cacheCount do
			local var_32_10 = var_0_1.create(lc.w(var_32_0), var_32_9[iter_32_3])

			var_32_0:pushBackCustomItem(var_32_10)
		end

		P._playerMail:clearNewUnionMails()
		var_32_0:checkEmpty(Str(STR.LIST_EMPTY_NO_MAIL))
	elseif arg_32_0._focusTabIndex == var_0_2.SystemMail.leave_message then
		local var_32_11 = P._playerMail:getMailList(Mail_pb.PB_MAIL_FRIEND, Mail_pb.PB_MAIL_NOTIFY)

		var_32_0:bindData(var_32_11, function(arg_39_0, arg_39_1)
			arg_39_0:updateMail(arg_39_1)
		end, math.min(5, #var_32_11))

		for iter_32_4 = 1, var_32_0._cacheCount do
			local var_32_12 = var_0_1.create(lc.w(var_32_0), var_32_11[iter_32_4])

			var_32_0:pushBackCustomItem(var_32_12)
		end

		P._playerMail:clearNewMsgMails()
		var_32_0:checkEmpty(Str(STR.LIST_EMPTY_NO_MAIL))
	else
		local var_32_13 = P._playerMail:getMailList(Mail_pb.PB_MAIL_SYSTEM)

		var_32_0:bindData(var_32_13, function(arg_40_0, arg_40_1)
			arg_40_0:setMail(arg_40_1)
		end, math.min(5, #var_32_13))

		for iter_32_5 = 1, var_32_0._cacheCount do
			local var_32_14 = var_0_0.create(lc.w(var_32_0), var_32_13[iter_32_5], true)

			var_32_0:pushBackCustomItem(var_32_14)
		end

		P._playerMail:clearNewNoticeMails()
		var_32_0:checkEmpty(Str(STR.LIST_EMPTY_NO_NOTICE))
	end

	var_32_0:gotoTop()
	arg_32_0:showSystemTabFlag()
end

function var_0_2.onMail(arg_41_0, arg_41_1)
	if arg_41_1 == require("PlayerMail").Event.mail_list_dirty then
		arg_41_0:refreshSystemMails()
		arg_41_0:showSystemTabFlag()
	end
end

function var_0_2.onServerBonus(arg_42_0)
	arg_42_0:refreshSystemMails()
	arg_42_0:showSystemTabFlag()
end

function var_0_2.onClaimBonus(arg_43_0)
	arg_43_0._list:refreshItems()
	arg_43_0:showSystemTabFlag()
end

return var_0_2
