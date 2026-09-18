local var_0_0 = class("SelectCountForm", require("BaseForm"))
local var_0_1 = cc.size(640, 420)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._data = arg_2_1

	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form

	arg_2_0._isShowResourceUI = true

	local var_2_1 = IconWidget.create(arg_2_1, IconWidget.DisplayFlag.COUNT)

	var_2_1:setTouchEnabled(false)
	lc.addChildToPos(var_2_0, var_2_1, cc.p(120, var_0_1.height - var_0_0.FRAME_THICK_TOP - 30 - lc.h(var_2_1) / 2))

	arg_2_0._icon = var_2_1

	local var_2_2 = ClientView.createTTF(ClientData.getNameByInfoId(arg_2_1._infoId), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)
	local var_2_3 = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = ClientView.CRECT_COM_BG2,
		_size = cc.size(320, 40)
	})

	var_2_3:setColor(lc.Color3B.black)
	var_2_3:setOpacity(100)
	lc.addChildToPos(var_2_3, var_2_2, cc.p(30 + lc.w(var_2_2) / 2, lc.h(var_2_3) / 2 - 1))
	lc.addChildToPos(var_2_0, var_2_3, cc.p(lc.right(var_2_1) - 10 + lc.w(var_2_3) / 2, lc.top(var_2_1) - lc.h(var_2_3) / 2 - 10))

	local var_2_4 = P:getItemCount(arg_2_1._infoId)

	if var_2_4 >= 0 then
		local var_2_5 = Data.isUnionRes(arg_2_1._infoId) and Str(STR.UNION_OWN) or Str(STR.CURRENT_OWN)
		local var_2_6 = ClientView.createTTF(string.format("(%s: %s)", var_2_5, ClientData.formatNum(var_2_4, 9999)), ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)

		lc.addChildToPos(var_2_0, var_2_6, cc.p(lc.w(var_2_0) - lc.w(var_2_6) / 2 - 60, lc.y(var_2_3)))
	end

	arg_2_0:updateBuyTimes()

	local var_2_7 = require("SelectCountWidget").create(function(arg_3_0)
		arg_2_0:updateBuyPrice(arg_3_0)
	end, 140, P._playerMarket:getBuyGoodsNumber(arg_2_0._data._infoId))

	arg_2_0._countWidget = var_2_7

	lc.addChildToPos(var_2_0, var_2_7, cc.p(lc.w(var_2_0) / 2, lc.bottom(var_2_1) - 30 - var_2_7.HEIGHT / 2))

	local var_2_8 = ClientView.createScale9ShaderButton("img_btn_2", function()
		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, 150)

	var_2_8:addLabel(Str(STR.CANCEL))
	lc.addChildToPos(var_2_0, var_2_8, cc.p(lc.w(var_2_0) / 2 - lc.w(var_2_8) / 2 - 20, 80))

	local var_2_9 = ClientView.createResConsumeButtonArea(150, string.format("img_icon_res%d_s", arg_2_1._resType), ClientView.COLOR_RES_LABEL_BG_LIGHT, "0", Str(STR.BUY))

	function var_2_9._btn._callback()
		arg_2_0:buy()
	end

	lc.addChildToPos(var_2_0, var_2_9, cc.p(lc.w(var_2_0) / 2 + lc.w(var_2_9) / 2 + 20, lc.bottom(var_2_8) + lc.h(var_2_9) / 2))

	arg_2_0._price = var_2_9._resLabel

	arg_2_0:updateBuyPrice()
end

function var_0_0.buy(arg_6_0)
	local var_6_0 = arg_6_0._countWidget:getCount()
	local var_6_1 = P._playerMarket:buyGoods(arg_6_0._data, var_6_0)

	if var_6_1 == Data.ErrorType.ok then
		ClientData.sendBuyGoods(arg_6_0._data._id, var_6_0)
		ToastManager.push(Str(STR.BUYSUCCESS))
		arg_6_0:hide()
	elseif var_6_1 == Data.ErrorType.need_more_ingot then
		require("PromptForm").ConfirmBuyIngot.create():show()
	elseif var_6_1 == Data.ErrorType.need_more_gold then
		ToastManager.push(Str(STR.NOT_ENOUGH_GOLD))
		require("ExchangeResForm").create(Data.ResType.gold):show()
	elseif var_6_1 == Data.ErrorType.need_more_grain then
		ToastManager.push(Str(STR.NOT_ENOUGH_GRAIN))
		require("ExchangeResForm").create(Data.ResType.grain):show()
	end
end

function var_0_0.updateBuyTimes(arg_7_0)
	if arg_7_0._buyTimes then
		arg_7_0._buyTimes:removeFromParent()
	end

	local var_7_0 = P._playerMarket
	local var_7_1 = var_7_0:getBuyGoodsNumber(arg_7_0._data._infoId)
	local var_7_2 = var_7_0:getBuyGoodsNumber(arg_7_0._data._infoId, true)
	local var_7_3 = string.format(Str(STR.DAILY_BUY_TIMES), var_7_1, var_7_2)
	local var_7_4 = ClientView.createBoldRichText(var_7_3, {
		_normalClr = ClientView.COLOR_TEXT_LIGHT,
		_boldClr = ClientView.COLOR_TEXT_GREEN_DARK,
		_fontSize = ClientView.FontSize.S1
	})

	lc.addChildToPos(arg_7_0._form, var_7_4, cc.p(lc.right(arg_7_0._icon) + 20 + lc.w(var_7_4) / 2, lc.bottom(arg_7_0._icon) + lc.h(var_7_4) / 2))

	arg_7_0._buyTimes = var_7_4
end

function var_0_0.updateBuyPrice(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or 1

	local var_8_0 = arg_8_0._data._cost * arg_8_1

	arg_8_0._price:setString(tostring(var_8_0))

	local var_8_1 = arg_8_0._data._resType
	local var_8_2 = P
	local var_8_3 = var_8_1 == Data.ResType.gold and var_8_2._gold or var_8_2._ingot

	arg_8_0._price:setColor(var_8_3 < var_8_0 and lc.Color3B.red or lc.Color3B.white)
end

function var_0_0.onEnter(arg_9_0)
	var_0_0.super.onEnter(arg_9_0)

	arg_9_0._listeners = {}

	table.insert(arg_9_0._listeners, lc.addEventListener(Data.Event.vip_dirty, function()
		arg_9_0:updateBuyTimes()
	end))
	table.insert(arg_9_0._listeners, lc.addEventListener(Data.Event.ingot_dirty, function()
		arg_9_0:updateBuyPrice()
	end))
	table.insert(arg_9_0._listeners, lc.addEventListener(Data.Event.gold_dirty, function()
		arg_9_0:updateBuyPrice()
	end))
end

function var_0_0.onExit(arg_13_0)
	var_0_0.super.onExit(arg_13_0)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_13_1)
	end
end

return var_0_0
