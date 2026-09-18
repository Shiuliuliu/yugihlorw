local var_0_0 = class("CheckinForm", require("BaseForm"))
local var_0_1 = cc.size(1024, 720)
local var_0_2 = cc.size(940, 176)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.CHECKIN_CENTER), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	arg_2_0._resNames = ClientData.loadLCRes("res/activity.lcres")

	local var_2_0 = lc.createSprite({
		_name = "img_blank",
		_crect = cc.rect(1, 1, 1, 1),
		_size = var_0_2
	})

	lc.addChildToPos(arg_2_0._form, var_2_0, cc.p(lc.w(arg_2_0._form) / 2, lc.h(var_2_0) / 2 + 10), 1)

	arg_2_0._buttonBG = var_2_0
	var_0_0.CheckinTypes = {
		Data.CheckinType.month_checkin,
		Data.CheckinType.week_checkin,
		Data.CheckinType.month_card,
		Data.CheckinType.novice,
		Data.CheckinType.online
	}

	if ClientData.getValidActivityByType(Data.ActivityType.month_card3) then
		table.insert(var_0_0.CheckinTypes, 4, Data.CheckinType.month_card3)
	end

	local var_2_1 = {}

	arg_2_0._buttons = {}

	for iter_2_0 = 1, #var_0_0.CheckinTypes do
		local var_2_2 = var_0_0.CheckinTypes[iter_2_0]
		local var_2_3 = true

		if var_2_3 then
			local var_2_4 = ccui.Widget:create()

			var_2_4:setContentSize(124, 128)
			table.insert(var_2_1, var_2_4)

			local var_2_5 = ClientView.createShaderButton("checkin_button_unfocus", function(arg_3_0)
				arg_2_0:showTab(iter_2_0)
			end)

			lc.addChildToPos(var_2_4, var_2_5, cc.p(lc.w(var_2_4) / 2, lc.h(var_2_5) / 2))
			table.insert(arg_2_0._buttons, var_2_5)

			local var_2_6 = lc.createSprite(string.format("checkin_button%d", var_2_2))

			lc.addChildToPos(var_2_5, var_2_6, cc.p(lc.w(var_2_5) / 2, lc.h(var_2_5) / 2 + 4))

			var_2_5:setContentSize(124, 128)
			local _tabNames = {
				[Data.CheckinType.month_checkin] = "Điểm danh",
				[Data.CheckinType.week_checkin] = "7 Ngày",
				[Data.CheckinType.month_card] = "Thẻ tháng",
				[Data.CheckinType.month_card3] = "Chí tôn",
				[Data.CheckinType.novice] = "Tân thủ",
				[Data.CheckinType.online] = "Online"
			}
			local _titleStr = _tabNames[var_2_2] or Str(STR.CHECKIN_MONTH + var_2_2 - 1)
			local var_2_7 = ClientView.createTTF(_titleStr, ClientView.FontSize.S2, lc.Color3B.yellow)
			lc.addChildToPos(var_2_5, var_2_7, cc.p(lc.w(var_2_4) / 2, 18))
			ClientView.fitLabel(var_2_7, lc.w(var_2_4) - 12, 0.4)
		end
	end

	lc.addNodesToCenter(var_2_0, var_2_1, 20)

	arg_2_0._focusTabIndex = arg_2_1 or 1

	arg_2_0:showTab(arg_2_0._focusTabIndex)

	return true
end

function var_0_0.onEnter(arg_4_0)
	var_0_0.super.onEnter(arg_4_0)

	arg_4_0._listeners = {}

	local var_4_0 = lc.addEventListener(Data.Event.bonus_dirty, function(arg_5_0)
		local var_5_0 = arg_5_0._data._type

		if var_5_0 == Data.BonusType.vip_daily then
			arg_4_0:updateTabFlag(Data.CheckinType.vip)
		elseif var_5_0 == Data.BonusType.month_card then
			arg_4_0:updateTabFlag(Data.CheckinType.month_card)
			arg_4_0:updateTabFlag(Data.CheckinType.month_card3)
		elseif var_5_0 == Data.BonusType.week_checkin then
			arg_4_0:updateTabFlag(Data.CheckinType.week_checkin)
		elseif var_5_0 == Data.BonusType.month_checkin then
			arg_4_0:updateTabFlag(Data.CheckinType.month_checkin)
		elseif var_5_0 == Data.BonusType.login then
			arg_4_0:updateTabFlag(Data.CheckinType.novice)
		elseif var_5_0 == Data.BonusType.online then
			arg_4_0:updateTabFlag(Data.CheckinType.online)
		end
	end)

	table.insert(arg_4_0._listeners, var_4_0)
	arg_4_0:updateTabFlag(Data.CheckinType.vip)
	arg_4_0:updateTabFlag(Data.CheckinType.month_card)
	arg_4_0:updateTabFlag(Data.CheckinType.month_card3)
	arg_4_0:updateTabFlag(Data.CheckinType.week_checkin)
	arg_4_0:updateTabFlag(Data.CheckinType.month_checkin)
	arg_4_0:updateTabFlag(Data.CheckinType.novice)
	arg_4_0:updateTabFlag(Data.CheckinType.online)

	local var_4_1 = lc.addEventListener(GuideManager.Event.seek, function(arg_6_0)
		arg_4_0:onGuide(arg_6_0)
	end)

	table.insert(arg_4_0._listeners, var_4_1)
	ClientData.addMsgListener(arg_4_0, function(arg_7_0)
		arg_4_0:onMsg(arg_7_0)
	end, 0)
end

function var_0_0.onExit(arg_8_0)
	var_0_0.super.onExit(arg_8_0)

	for iter_8_0 = 1, #arg_8_0._listeners do
		lc.Dispatcher:removeEventListener(arg_8_0._listeners[iter_8_0])
	end

	ClientData.removeMsgListener(arg_8_0)
end

function var_0_0.onCleanup(arg_9_0)
	var_0_0.super.onCleanup(arg_9_0)
	ClientData.unloadLCRes(arg_9_0._resNames)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_common_bg.jpg"))
end

function var_0_0.show(arg_10_0)
	var_0_0.super.show(arg_10_0)

	ClientView._checkinForm = arg_10_0

	ClientData.setActivityShowed(Data.PurchaseType.checkin)
end

function var_0_0.hide(arg_11_0)
	var_0_0.super.hide(arg_11_0)

	ClientView._checkinForm = nil
end

function var_0_0.showTab(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getBgName(arg_12_1)

	if arg_12_0._focusTabIndex ~= nil then
		arg_12_0._buttons[arg_12_0._focusTabIndex]:setEnabled(true)
		arg_12_0._buttons[arg_12_0._focusTabIndex]:loadTextureNormal("checkin_button_unfocus", ccui.TextureResType.plistType)

		if arg_12_0._activityPanel ~= nil then
			arg_12_0._activityPanel:removeFromParent()

			arg_12_0._activityPanel = nil
		end

		local var_12_1 = arg_12_0:getBgName(arg_12_0._focusTabIndex)

		if var_12_1 ~= var_12_0 then
			lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename(var_12_1))
		end
	end

	arg_12_0._buttons[arg_12_1]:setEnabled(false)
	arg_12_0._buttons[arg_12_1]:loadTextureNormal("checkin_button_focus", ccui.TextureResType.plistType)

	local var_12_2 = var_0_0.CheckinTypes[arg_12_1]

	arg_12_0._activityPanel = require(arg_12_0:getPanelName(var_12_2)).create(var_12_0, cc.size(lc.w(arg_12_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN, 512))

	lc.addChildToPos(arg_12_0._frame, arg_12_0._activityPanel, cc.p(lc.w(arg_12_0._frame) / 2, lc.h(arg_12_0._frame) - lc.h(arg_12_0._activityPanel) / 2 - var_0_0.TOP_MARGIN), -1)

	arg_12_0._focusTabIndex = arg_12_1
end

function var_0_0.updateTabFlag(arg_13_0, arg_13_1)
	local var_13_0 = ClientData._player._playerBonus
	local var_13_1 = 0

	if arg_13_1 == Data.CheckinType.vip then
		var_13_1 = var_13_0:getVipDailyBonusFlag()
	elseif arg_13_1 == Data.CheckinType.month_card then
		var_13_1 = var_13_0:getMonthCardBonusFlag()
	elseif arg_13_1 == Data.CheckinType.month_card3 then
		var_13_1 = var_13_0:getMonthCard3BonusFlag()
	elseif arg_13_1 == Data.CheckinType.week_checkin then
		var_13_1 = var_13_0:getWeekCheckinBonusFlag()
	elseif arg_13_1 == Data.CheckinType.month_checkin then
		var_13_1 = var_13_0:getMonthCheckinBonusFlag()
	elseif arg_13_1 == Data.CheckinType.novice then
		var_13_1 = var_13_0:getLoginBonusFlag()
	elseif arg_13_1 == Data.CheckinType.online then
		var_13_1 = var_13_0:getOnlineTaskBonusFlag()
	end

	local var_13_2 = 0

	for iter_13_0 = 1, #var_0_0.CheckinTypes do
		if var_0_0.CheckinTypes[iter_13_0] == arg_13_1 then
			var_13_2 = iter_13_0
		end
	end

	if var_13_2 > 0 then
		local var_13_3 = arg_13_0._buttons[var_13_2]

		ClientView.checkNewFlag(var_13_3, var_13_1, 24)
	end
end

function var_0_0.getPanelName(arg_14_0, arg_14_1)
	if arg_14_1 == Data.CheckinType.vip then
		return "VIPPanel"
	elseif arg_14_1 == Data.CheckinType.month_card then
		return "MonthCardPanel"
	elseif arg_14_1 == Data.CheckinType.month_card3 then
		return "MonthCard3Panel"
	elseif arg_14_1 == Data.CheckinType.week_checkin then
		return "WeekCheckinPanel"
	elseif arg_14_1 == Data.CheckinType.month_checkin then
		return "MonthCheckinPanel"
	elseif arg_14_1 == Data.CheckinType.novice then
		return "NovicePanel"
	elseif arg_14_1 == Data.CheckinType.online then
		return "OnlinePanel"
	end
end

function var_0_0.getBgName(arg_15_0, arg_15_1)
	return "res/jpg/activity_common_bg.jpg"
end

function var_0_0.onMsg(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.type
	local var_16_1 = arg_16_1.status

	if var_16_0 == SglMsgType_pb.PB_TYPE_USER_CLAIM_GIFT then
		ClientView.getActiveIndicator():hide()
		require("RewardPanel").create(arg_16_1.Extensions[User_pb.SglUserMsg.user_claim_gift_resp]):show()

		return true
	end

	return false
end

function var_0_0.onGuide(arg_17_0, arg_17_1)
	local var_17_0 = GuideManager.getCurStepName()

	if var_17_0 == "show tab novice" then
		GuideManager.setOperateLayer(arg_17_0._buttons[Data.CheckinType.novice])
	elseif var_17_0 == "leave giftcenter" then
		GuideManager.setOperateLayer(arg_17_0._btnBack)
	else
		return
	end

	arg_17_1:stopPropagation()
end

return var_0_0
