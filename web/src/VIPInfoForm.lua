local var_0_0 = class("VIPInfoForm", BaseForm)
local var_0_1 = cc.size(980, 648)

local function var_0_2()
	if P._vip <= 8 then
		return 9
	else
		return math.min(P._vip + 1, #Data._globalInfo._vipIngot - 2)
	end
end

function var_0_0.create()
	local var_2_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	var_0_0.super.init(arg_3_0, var_0_1, "VIP" .. Str(STR.PRIVILEGE))

	local var_3_0 = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.M1)

	var_3_0:setColor(ClientView.COLOR_TEXT_TITLE)
	lc.addChildToPos(arg_3_0._frame, var_3_0, cc.p(lc.cw(arg_3_0._frame), lc.h(arg_3_0._frame) - 80))

	arg_3_0._titleLabel = var_3_0

	local var_3_1 = V.createScale9ShaderButton("img_btn_1_s", function()
		require("VipStorePanel").create():show()
	end, V.CRECT_BUTTON_S, 150)

	var_3_1:addLabel(Str(STR.VIP_SHOP))
	lc.addChildToPos(arg_3_0._frame, var_3_1, cc.p(lc.cw(arg_3_0._frame) + 290, lc.y(var_3_0)))

	arg_3_0._btnStore = var_3_1

	local var_3_2 = lc.createNode(cc.size(lc.w(arg_3_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_3_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM))

	lc.addChildToPos(arg_3_0._frame, var_3_2, cc.p(lc.cw(arg_3_0._frame), lc.ch(arg_3_0._frame) - 60))

	local var_3_3 = lc.w(var_3_2)
	local var_3_4 = lc.h(var_3_2)
	local var_3_5 = 100
	local var_3_6 = 100
	local var_3_7 = ClientView.createArrowButton(true, cc.size(var_3_5, var_3_6), function(arg_5_0)
		arg_3_0:onBtnArrow(arg_5_0)
	end)

	lc.addChildToPos(var_3_2, var_3_7, cc.p(var_3_5 / 2, var_3_4 / 2))

	var_3_2._btnArrowLeft = var_3_7

	local var_3_8 = ClientView.createBMFont(ClientView.BMFont.huali_26, "V")

	lc.addChildToPos(var_3_7, var_3_8, cc.p(var_3_5 / 2, var_3_6 / 2 + 5 + lc.h(var_3_8)))

	var_3_2._arrowLeftLabel = var_3_8

	local var_3_9 = ClientView.createArrowButton(false, cc.size(var_3_5, var_3_6), function(arg_6_0)
		arg_3_0:onBtnArrow(arg_6_0)
	end)

	lc.addChildToPos(var_3_2, var_3_9, cc.p(var_3_3 - var_3_5 / 2, var_3_4 / 2))

	var_3_2._btnArrowRight = var_3_9

	local var_3_10 = ClientView.createBMFont(ClientView.BMFont.huali_26, "V")

	lc.addChildToPos(var_3_9, var_3_10, cc.p(var_3_5 / 2, lc.y(var_3_8)))

	var_3_2._arrowRightLabel = var_3_10

	local var_3_11 = ccui.Layout:create()

	var_3_11:setContentSize(cc.size(var_3_3 - var_3_5 - var_3_5, var_3_4 - 110))
	var_3_11:setAnchorPoint(0.5, 0.5)
	var_3_11:setClippingEnabled(true)
	lc.addChildToPos(var_3_2, var_3_11, cc.p(var_3_3 / 2, var_3_4 - 24 - lc.h(var_3_11) / 2))

	var_3_2._textArea = var_3_11

	local var_3_12 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = var_3_11:getContentSize()
	})

	lc.addChildToCenter(var_3_11, var_3_12)

	arg_3_0._vipArea = var_3_2

	arg_3_0:scrollToVip(math.max(P._vip, 1), true)
end

function var_0_0.scrollToVip(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._titleLabel:setString(string.format("VIP %d %s%s", arg_7_1, Str(STR.LEVEL), Str(STR.PRIVILEGE)))

	local var_7_0 = arg_7_0._vipArea
	local var_7_1 = var_0_2()

	var_7_0._btnArrowLeft:setVisible(arg_7_1 ~= 1)
	var_7_0._btnArrowRight:setVisible(arg_7_1 ~= var_7_1)

	if arg_7_1 > 1 then
		var_7_0._arrowLeftLabel:setString(string.format("VIP %d", arg_7_1 - 1))
	end

	if arg_7_1 < var_7_1 then
		var_7_0._arrowRightLabel:setString(string.format("VIP %d", arg_7_1 + 1))
	end

	local var_7_2 = var_7_0._vip == nil or arg_7_1 > var_7_0._vip
	local var_7_3 = var_7_0._textArea
	local var_7_4 = lc.w(var_7_3)
	local var_7_5 = lc.h(var_7_3)
	local var_7_6 = var_7_3._list
	local var_7_7 = arg_7_2 and 0 or 0.2

	if var_7_6 then
		var_7_6:stopAllActions()
		var_7_6:runAction(lc.sequence({
			lc.moveBy(var_7_7, var_7_2 and -var_7_4 or var_7_4, 0),
			lc.fadeOut(var_7_7)
		}, lc.remove()))
	end

	local var_7_8 = arg_7_0:createVipItemsList(arg_7_1)

	lc.addChildToPos(var_7_3, var_7_8, cc.p(lc.w(var_7_3) / 2 + (var_7_2 and var_7_4 or -var_7_4), lc.h(var_7_3) / 2))
	var_7_8:runAction(lc.sequence({
		lc.moveTo(var_7_7, lc.w(var_7_3) / 2, lc.y(var_7_8)),
		lc.fadeIn(var_7_7)
	}))

	var_7_3._list = var_7_8
	var_7_0._vip = arg_7_1

	arg_7_0._btnStore:setVisible(P._vip >= #Data._globalInfo._vipIngot - 3)
end

function var_0_0.onBtnArrow(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._vipArea

	if var_8_0 == nil then
		return
	end

	if arg_8_1 == var_8_0._btnArrowLeft then
		arg_8_0:scrollToVip(var_8_0._vip - 1)
	else
		arg_8_0:scrollToVip(var_8_0._vip + 1)
	end
end

function var_0_0.createVipItemsList(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._vipArea._textArea
	local var_9_1 = lc.List.createV(cc.size(lc.w(var_9_0) - 40, lc.h(var_9_0) - 16), 20, 20)

	var_9_1:setAnchorPoint(0.5, 0.5)
	var_9_1:pushBackCustomItem(arg_9_0:createVipTextItem(arg_9_1, lc.w(var_9_1)))
	var_9_1:pushBackCustomItem(arg_9_0:createVipBonusItem(arg_9_1, lc.w(var_9_1)))

	return var_9_1
end

function var_0_0.createVipTextItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}
	local var_10_1 = 4
	local var_10_2 = 0

	local function var_10_3(arg_11_0)
		if arg_11_0 then
			local var_11_0 = arg_10_0:createRichText(arg_11_0)

			table.insert(var_10_0, var_11_0)

			if var_10_2 > 0 then
				var_10_2 = var_10_2 + var_10_1
			end

			var_10_2 = var_10_2 + lc.h(var_11_0)
		end
	end

	local var_10_4 = {
		Str(STR.VIP_CONTENT_1),
		Str(STR.VIP_CONTENT_2),
		Str(STR.VIP_CONTENT_3),
		Str(STR.VIP_CONTENT_4),
		Str(STR.VIP_CONTENT_5),
		Str(STR.VIP_CONTENT_6),
		Str(STR.VIP_CONTENT_7),
		Str(STR.VIP_CONTENT_8),
		Str(STR.VIP_CONTENT_9),
		Str(STR.VIP_CONTENT_10),
		Str(STR.VIP_CONTENT_11),
		Str(STR.VIP_CONTENT_12),
		Str(STR.VIP_CONTENT_13),
		Str(STR.VIP_CONTENT_14),
		Str(STR.VIP_CONTENT_15),
		Str(STR.VIP_CONTENT_16),
		Str(STR.VIP_CONTENT_17),
		Str(STR.VIP_CONTENT_18),
		Str(STR.VIP_CONTENT_19),
		Str(STR.VIP_CONTENT_20),
		Str(STR.VIP_CONTENT_21),
		Str(STR.VIP_CONTENT_22),
		Str(STR.VIP_CONTENT_23),
		Str(STR.VIP_CONTENT_24),
		Str(STR.VIP_CONTENT_25),
		Str(STR.VIP_CONTENT_26),
		Str(STR.VIP_CONTENT_27),
		Str(STR.VIP_CONTENT_28),
		Str(STR.VIP_CONTENT_29),
		Str(STR.VIP_CONTENT_30)
	}
	local var_10_5 = Data._globalInfo
	local var_10_6 = arg_10_1 + 1

	var_10_3(string.format(var_10_4[1], var_10_5._vipIngot[var_10_6]))
	var_10_3(string.format(var_10_4[2], arg_10_1))

	if arg_10_1 >= 14 then
		var_10_3(var_10_4[29])
	elseif arg_10_1 >= 10 then
		var_10_3(var_10_4[28])
	elseif arg_10_1 >= 7 then
		var_10_3(var_10_4[27])
	end

	if arg_10_1 == 4 or arg_10_1 == 8 or arg_10_1 == 9 then
		local var_10_7 = arg_10_1 == 4 and 3 or arg_10_1 == 8 and 4 or 5

		var_10_3(string.format(var_10_4[11], var_10_7))
	end

	local var_10_8 = Data._globalInfo._vipLadderExp[arg_10_1 + 1]

	if var_10_8 > 0 then
		var_10_3(string.format(var_10_4[24], var_10_8))
	end

	local var_10_9 = Data._globalInfo._vipLegendLadderExp[arg_10_1 + 1]

	if var_10_9 > 0 then
		var_10_3(string.format(var_10_4[30], var_10_9))
	end

	local var_10_10 = Data._globalInfo._vipLadderExExp[arg_10_1 + 1]

	if var_10_10 > 0 then
		var_10_3(string.format(var_10_4[25], var_10_10))
	end

	local var_10_11 = Data._globalInfo._vipExpeditionExp[arg_10_1 + 1]

	if var_10_11 > 0 then
		var_10_3(string.format(var_10_4[26], var_10_11))
	end

	local var_10_12 = cc.Label:createWithTTF(Str(STR.SPECIFIC_PRIVILEGE) .. ":", ClientView.TTF_FONT, ClientView.FontSize.S1)

	var_10_12:setColor(ClientView.COLOR_TEXT_LIGHT)

	var_10_2 = var_10_2 + lc.h(var_10_12)

	local var_10_13 = ccui.Widget:create()
	local var_10_14 = 40

	var_10_2 = var_10_2 + var_10_14

	var_10_13:setContentSize(arg_10_2, var_10_2)
	var_10_13:setCascadeOpacityEnabled(true)
	ClientView.addDecoratedLabel(var_10_13, Str(STR.SPECIFIC_PRIVILEGE), cc.p(lc.w(var_10_13) / 2, var_10_2 - var_10_14 / 2), 26)

	local var_10_15 = var_10_2 - var_10_14

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		lc.addChildToPos(var_10_13, iter_10_1, cc.p(arg_10_2 / 2, var_10_15 - lc.h(iter_10_1) / 2))

		var_10_15 = var_10_15 - lc.h(iter_10_1) - var_10_1
	end

	return var_10_13
end

function var_0_0.createVipBonusItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {
		10099,
		10100,
		10101,
		10130,
		10102,
		10103,
		10104,
		10105,
		10106,
		10107,
		10108,
		10109,
		10110,
		10111,
		10112,
		10827
	}
	local var_12_1 = Data._bonusInfo[var_12_0[arg_12_1]]
	local var_12_2 = {}

	for iter_12_0 = 1, #var_12_1._rid do
		local var_12_3 = IconWidget.create({
			_infoId = var_12_1._rid[iter_12_0],
			_level = var_12_1._level[iter_12_0],
			_count = var_12_1._count[iter_12_0],
			_isFragment = var_12_1._isFragment[iter_12_0] > 0
		})

		var_12_3._name:setColor(ClientView.COLOR_BMFONT)
		table.insert(var_12_2, var_12_3)
	end

	P:sortResultItems(var_12_2)

	local var_12_4 = ccui.Widget:create()
	local var_12_5 = 30

	var_12_4:setContentSize(arg_12_2, var_12_5 + lc.h(var_12_2[1]) + 10)
	var_12_4:setCascadeOpacityEnabled(true)
	ClientView.addDecoratedLabel(var_12_4, Str(STR.SPECIFIC_BONUS), cc.p(lc.w(var_12_4) / 2, lc.h(var_12_4) - var_12_5 / 2), 26)
	lc.addNodesToCenter(var_12_4, var_12_2, 20, 56)

	return var_12_4
end

function var_0_0.genVipItemsListText(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = Data._globalInfo
	local var_13_1 = arg_13_2[arg_13_1]

	if vip == 1 or arg_13_2[arg_13_1] ~= arg_13_2[arg_13_1 - 1] then
		if var_13_1 == 1 then
			if arg_13_2 == var_13_0._vipBuyElite then
				var_13_1 = Str(STR.COPY_ELITE)
			elseif arg_13_2 == var_13_0._vipBuyBoss then
				var_13_1 = Str(STR.COPY_BOSS)
			elseif arg_13_2 == var_13_0._vipBuyCommander then
				var_13_1 = Str(STR.COPY_COMMANDER)
			elseif arg_13_2 == var_13_0._vipBuyExpedition then
				var_13_1 = Str(STR.COPY_EXPEDITION)
			elseif arg_13_2 == var_13_0._vipGrace or arg_13_2 == var_13_0._vipLegendChest then
				return string.format(arg_13_3, var_13_1)
			else
				var_13_1 = nil
			end

			return string.format(arg_13_4, var_13_1)
		elseif var_13_1 > 0 then
			if arg_13_2 == var_13_0._vipRobExpCount or arg_13_2 == var_13_0._vipBuyRobExp then
				return string.format(arg_13_3, Str(STR.COPY_IMMUNITY_PHY), var_13_1)
			elseif arg_13_2 == var_13_0._vipEliteCount or arg_13_2 == var_13_0._vipBuyElite then
				return string.format(arg_13_3, Str(STR.COPY_ELITE), var_13_1)
			elseif arg_13_2 == var_13_0._vipCommanderCount or arg_13_2 == var_13_0._vipBuyCommander then
				return string.format(arg_13_3, Str(STR.COPY_COMMANDER), var_13_1)
			elseif arg_13_2 == var_13_0._vipExpeditionCount or arg_13_2 == var_13_0._vipBuyExpedition then
				return string.format(arg_13_3, Str(STR.COPY_EXPEDITION), var_13_1)
			else
				return string.format(arg_13_3, var_13_1)
			end
		end
	end

	return nil
end

function var_0_0.createRichText(arg_14_0, arg_14_1)
	local var_14_0 = ClientView.createBoldRichText("", {}, 680)

	if arg_14_1 then
		ClientView.appendBoldRichText(var_14_0, arg_14_1, {
			_normalClr = ClientView.COLOR_TEXT_LIGHT,
			_boldClr = ClientView.COLOR_TEXT_GREEN_DARK
		})
		var_14_0:setCascadeOpacityEnabled(true)
	elseif P._vip < var_0_2() then
		var_14_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(STR.RECHARGE_AGAIN), ClientView.TTF_FONT, ClientView.FontSize.S1))
		var_14_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_INGOT, 255, string.format(" %d ", P:getVIPupExp() - P._vipExp), ClientView.TTF_FONT, ClientView.FontSize.S1))
		var_14_0:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, lc.createSprite(string.format("img_icon_res%d_s", Data.ResType.ingot))))
		var_14_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, " " .. Str(STR.CAN_ARRIVE), ClientView.TTF_FONT, ClientView.FontSize.S1))
	else
		var_14_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(STR.VIP_MAX), ClientView.TTF_FONT, ClientView.FontSize.S1))

		local var_14_1 = ClientView.createBMFont(ClientView.BMFont.huali_26, string.format(" VIP %d", var_0_2()))

		var_14_1:setColor(ClientView.COLOR_TEXT_VIP)
		var_14_0:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, var_14_1))
	end

	var_14_0:formatText()

	return var_14_0
end

return var_0_0
