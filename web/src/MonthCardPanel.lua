local var_0_0 = class("MonthCardPanel", lc.ExtendUIWidget)
local var_0_1 = cc.size(418, 344)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setContentSize(arg_1_1)
	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local var_2_0 = "activity_top"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_2_0 .. "_2")) then
		var_2_0 = var_2_0 .. "_2"
	end

	if ClientData.isAnotherSkin2() and lc.File:isFileExist(lc.formatJpg(var_2_0 .. "_3")) then
		var_2_0 = var_2_0 .. "_3"
	end

	local var_2_1 = lc.createSprite(lc.formatJpg(var_2_0))

	lc.addChildToPos(arg_2_0, var_2_1, cc.p(lc.w(arg_2_0) / 2, lc.h(arg_2_0) - lc.h(var_2_1) / 2))

	local var_2_2 = ClientView.createCheckinTitle(Str(STR.MONTH_CARD_CHECKIN_TITLE), 0)

	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.w(arg_2_0) / 2 + 140, lc.h(arg_2_0) - lc.h(var_2_2) / 2 - 24))

	local var_2_3 = ClientView.createTTF(Str(STR.MONTH_CARD_CHECKIN_TIP), ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)

	lc.addChildToPos(arg_2_0, var_2_3, cc.p(lc.x(var_2_2), lc.bottom(var_2_2) - lc.h(var_2_3) / 2 - 12))

	local var_2_4 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = cc.size(lc.w(arg_2_0) - 20, 390)
	})

	lc.addChildToPos(arg_2_0, var_2_4, cc.p(lc.w(arg_2_0) / 2, lc.h(var_2_4) / 2))

	arg_2_0._areas = {}

	local var_2_5 = arg_2_0:createItemArea(1)

	lc.addChildToPos(arg_2_0, var_2_5, cc.p(38 + var_0_1.width / 2, lc.y(var_2_4)))
	table.insert(arg_2_0._areas, var_2_5)

	local var_2_6 = arg_2_0:createItemArea(2)

	lc.addChildToPos(arg_2_0, var_2_6, cc.p(lc.w(arg_2_0) - 38 - var_0_1.width / 2, lc.y(var_2_4)))
	table.insert(arg_2_0._areas, var_2_6)
end

function var_0_0.createItemArea(arg_3_0, arg_3_1)
	local var_3_0 = lc.createSprite({
		_name = "activity_bonus_bg2",
		_crect = cc.rect(30, 30, 8, 4),
		_size = var_0_1
	})
	local var_3_1 = P._playerBonus._bonusMonthCard[arg_3_1]

	var_3_0._bonus = var_3_1

	local var_3_2 = var_3_1._info
	local var_3_3 = {}

	for iter_3_0 = 1, #var_3_2._rid do
		local var_3_4 = IconWidget.createByBonus(var_3_2, iter_3_0)

		var_3_4._name:setColor(lc.Color3B.white)
		table.insert(var_3_3, var_3_4)
	end

	lc.addNodesToCenter(var_3_0, {
		var_3_3[1],
		var_3_3[2],
		var_3_3[3]
	}, 30, var_0_1.height - 150)

	local var_3_5 = ClientView.createScale9ShaderButton("img_btn_1", function()
		if var_3_1._value >= var_3_1._info._val then
			local var_4_0 = ClientData.claimBonus(var_3_1)

			ClientView.showClaimBonusResult(var_3_1, var_4_0)
		else
			ToastManager.push(Str(STR.MONTH_CARD_NO_DAYS))
		end
	end, ClientView.CRECT_BUTTON, 180)

	var_3_5:addLabel(Str(STR.CLAIM))
	lc.addChildToPos(var_3_0, var_3_5, cc.p(lc.cw(var_3_0), 20 + lc.h(var_3_5) / 2))

	var_3_0._btnClaim = var_3_5

	local var_3_6 = ClientView.createStatusLabel(Str(STR.CLAIMED), ClientView.COLOR_TEXT_GREEN)

	lc.addChildToPos(var_3_0, var_3_6, cc.p(var_3_5:getPosition()))

	var_3_0._claimedFlag = var_3_6

	local var_3_7 = lc.createSprite(string.format("activity_icon_%d", 100 + arg_3_1))

	lc.addChildToPos(var_3_0, var_3_7, cc.p(lc.cw(var_3_0) - 70, lc.h(var_3_0) - 40))

	local var_3_8 = ClientView.createTTF("", ClientView.FontSize.S1)

	var_3_8:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_3_0, var_3_8, cc.p(lc.right(var_3_7) + 6, lc.y(var_3_7)))

	var_3_0._label = var_3_8

	local var_3_9 = ClientView.createScale9ShaderButton("img_btn_3", function()
		lc.pushScene(require("ActivityScene").create(require("ActivityScene").Tab.month_card))
	end, ClientView.CRECT_BUTTON, 180)

	var_3_9:addLabel(Str(STR.BUY_MONTH_CARD))
	lc.addChildToPos(var_3_0, var_3_9, cc.p(var_3_5:getPosition()))

	var_3_0._btnBuy = var_3_9
	var_3_0._index = arg_3_1

	return var_3_0
end

function var_0_0.updateAreaView(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1._index
	local var_6_1 = arg_6_1._bonus
	local var_6_2 = var_6_0 == 1 and P._monthCardDay1 or P._monthCardDay2

	arg_6_1._btnClaim:setVisible(var_6_2 > 0 and not var_6_1._isClaimed)
	arg_6_1._claimedFlag:setVisible(var_6_2 > 0 and var_6_1._isClaimed)
	arg_6_1._btnBuy:setVisible(var_6_2 <= 0)

	if var_6_2 > 0 then
		arg_6_1._label:setString(string.format(Str(STR.REMAIN_DAYS), var_6_2))
		arg_6_1._label:setColor(ClientView.COLOR_TEXT_GREEN)
	else
		arg_6_1._label:setString(string.format(Str(STR[string.format("MONTH_CARD%d", var_6_0)])))
		arg_6_1._label:setColor(ClientView.COLOR_TEXT_ORANGE)
	end
end

function var_0_0.onEnter(arg_7_0)
	arg_7_0._listener = lc.addEventListener(Data.Event.bonus_dirty, function(arg_8_0)
		for iter_8_0, iter_8_1 in ipairs(arg_7_0._areas) do
			if arg_8_0._data == iter_8_1._bonus then
				arg_7_0:updateAreaView(iter_8_1)

				break
			end
		end
	end)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._areas) do
		arg_7_0:updateAreaView(iter_7_1)
	end
end

function var_0_0.onExit(arg_9_0)
	lc.Dispatcher:removeEventListener(arg_9_0._listener)
end

return var_0_0
