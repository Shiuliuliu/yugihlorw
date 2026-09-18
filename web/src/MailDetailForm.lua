local var_0_0 = class("MailDetailForm", BaseForm)
local var_0_1 = cc.size(700, 540)

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form
	local var_2_1 = lc.createSprite("img_icon_mail")

	lc.addChildToPos(var_2_0, var_2_1, cc.p(var_0_0.LEFT_MARGIN + lc.w(var_2_1) / 2 + 30, lc.h(var_2_0) - lc.h(var_2_1) / 2 - var_0_0.TOP_MARGIN - 20), 1)

	local var_2_2 = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = ClientView.CRECT_COM_BG2,
		_size = cc.size(500, 40)
	})

	var_2_2:setColor(lc.Color3B.black)
	var_2_2:setOpacity(100)
	lc.addChildToPos(var_2_0, var_2_2, cc.p(lc.x(var_2_1) + lc.w(var_2_2) / 2, lc.y(var_2_1)))

	local var_2_3 = ClientView.createTTF(arg_2_1, ClientView.FontSize.S1)

	lc.addChildToPos(var_2_2, var_2_3, cc.p(lc.w(var_2_3) / 2 + 40, lc.h(var_2_2) / 2))

	local var_2_4 = ccui.Scale9Sprite:createWithSpriteFrameName("img_com_bg_10", ClientView.CRECT_COM_BG10)

	var_2_4:setContentSize(cc.size(lc.w(arg_2_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN - 60, lc.bottom(var_2_1) - var_0_0.BOTTOM_MARGIN - 50))
	lc.addChildToPos(arg_2_0._form, var_2_4, cc.p(lc.w(arg_2_0._form) / 2, lc.h(var_2_4) / 2 + var_0_0.BOTTOM_MARGIN + 30))

	local var_2_5 = lc.List.createV(cc.size(lc.w(var_2_4) - 40, lc.h(var_2_4) - 36), 10)

	var_2_5:setTouchEnabled(true)
	var_2_5:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_2_4, var_2_5, cc.p(lc.w(var_2_4) / 2, lc.h(var_2_4) / 2 + 2))

	local var_2_6 = ClientView.createBoldRichTextMultiLine(arg_2_2, ClientView.RICHTEXT_PARAM_LIGHT_S2, lc.w(var_2_5) - 30)
	local var_2_7 = ccui.Widget:create()

	var_2_7:setContentSize(var_2_6:getContentSize())
	lc.addChildToCenter(var_2_7, var_2_6)
	var_2_5:pushBackCustomItem(var_2_7)
end

return var_0_0
