local var_0_0 = class("RareGiftForm", BaseForm)
local var_0_1 = cc.size(820, 700)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 - Data.PurchaseType.rare_gift_1 + 1

	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.RARE_GIFT) .. var_2_0, bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	arg_2_0._purchaseType = arg_2_1

	local var_2_1 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_3_0)
		arg_2_0:onBuy(arg_3_0)
	end, ClientView.CRECT_BUTTON, 150)

	var_2_1:addLabel(Str(STR.BUY))
	lc.addChildToPos(arg_2_0._frame, var_2_1, cc.p(lc.cw(arg_2_0._frame), lc.ch(var_2_1) + ClientView.FRAME_INNER_BOTTOM + 10))

	local var_2_2 = lc.createSprite("activity_rmb_" .. ClientData.getPrice(arg_2_1))

	lc.addChildToPos(var_2_1, var_2_2, cc.p(lc.cw(var_2_1), lc.h(var_2_1) + lc.ch(var_2_2)))

	local var_2_3 = cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 20, lc.bottom(arg_2_0._titleFrame) - 180)
	local var_2_4 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = cc.size(var_2_3.width, var_2_3.height + 20)
	})

	lc.addChildToPos(arg_2_0._frame, var_2_4, cc.p(lc.cw(arg_2_0._frame), lc.ch(var_2_4) + 150))

	local var_2_5 = lc.List.createV(var_2_3, 10, 10)

	var_2_5:setAnchorPoint(0.5, 0)
	lc.addChildToCenter(var_2_4, var_2_5)

	arg_2_0._list = var_2_5

	local var_2_6 = lc.arrayToTable(arg_2_2, 5, function()
		return true
	end)

	for iter_2_0, iter_2_1 in ipairs(var_2_6) do
		local var_2_7 = arg_2_0:createItem(iter_2_1)

		var_2_5:pushBackCustomItem(var_2_7)
	end
end

function var_0_0.createItem(arg_5_0, arg_5_1)
	local var_5_0 = ccui.Widget:create()

	var_5_0:setContentSize(lc.w(arg_5_0._list), 150)

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_1 = IconWidget.create(iter_5_1)

		var_5_1._name:setColor(ClientView.COLOR_TEXT_WHITE)
		lc.addChildToPos(var_5_0, var_5_1, cc.p(150 * (iter_5_0 - 0.5), lc.ch(var_5_0)))
	end

	return var_5_0
end

function var_0_0.onBuy(arg_6_0, arg_6_1)
	ClientView.startIAP(arg_6_0._purchaseType)
	arg_6_0:hide()
end

function var_0_0.onEnter(arg_7_0)
	var_0_0.super.onEnter(arg_7_0)
end

function var_0_0.onExit(arg_8_0)
	var_0_0.super.onExit(arg_8_0)
end

return var_0_0
