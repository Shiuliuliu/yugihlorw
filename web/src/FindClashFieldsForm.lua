local var_0_0 = class("FindClashFieldsForm", BaseForm)
local var_0_1 = cc.size(780, 560)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.FIND_CLASH_FIELDS_TITLE), var_0_0.FLAG.SCROLL_H)

	arg_2_0._grade = arg_2_1

	local var_2_0 = cc.ClippingNode:create()

	var_2_0:setContentSize(arg_2_0._form:getContentSize())

	local var_2_1 = cc.LayerColor:create(lc.Color4B.white, lc.w(arg_2_0._form) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_2_0._form))

	var_2_1:setPosition(ClientView.FRAME_INNER_LEFT, 0)
	var_2_0:setStencil(var_2_1)
	lc.addChildToCenter(arg_2_0._form, var_2_0)

	arg_2_0._clipNode = var_2_0

	local var_2_2 = var_2_0
	local var_2_3 = 120
	local var_2_4 = 430
	local var_2_5 = ClientView.createArrowButton(true, cc.size(var_2_3, var_2_4), function(arg_3_0)
		arg_2_0:onBtnArrow(arg_3_0)
	end)

	lc.addChildToPos(var_2_2, var_2_5, cc.p(var_0_0.FRAME_THICK_LEFT + var_2_3 / 2 - 10, lc.h(var_2_2) / 2))

	arg_2_0._btnArrowLeft = var_2_5

	if arg_2_1 == Data.FindClashGrade.bronze then
		var_2_5:setVisible(false)
	end

	local var_2_6 = ClientView.createArrowButton(false, cc.size(var_2_3, var_2_4), function(arg_4_0)
		arg_2_0:onBtnArrow(arg_4_0)
	end)

	lc.addChildToPos(var_2_2, var_2_6, cc.p(lc.w(var_2_2) - var_0_0.FRAME_THICK_RIGHT - var_2_3 / 2 + 10, lc.h(var_2_2) / 2))

	arg_2_0._btnArrowRight = var_2_6

	if arg_2_1 == Data.FindClashGrade.legend then
		var_2_6:setVisible(false)
	end

	local var_2_7 = arg_2_0:createArea(arg_2_1)

	lc.addChildToPos(var_2_2, var_2_7, cc.p(lc.w(var_2_2) / 2, var_0_0.FRAME_THICK_BOTTOM + 30 + lc.h(var_2_7) / 2))

	arg_2_0._fieldArea = var_2_7
end

function var_0_0.createArea(arg_5_0, arg_5_1)
	local var_5_0 = lc.createNode()

	var_5_0:setCascadeOpacityEnabled(true)

	local var_5_1 = ClientView.createClashFieldArea(arg_5_1, nil, true)

	var_5_1:setCascadeOpacityEnabled(true)

	local var_5_2 = {}

	for iter_5_0 = 1, 5 do
		local var_5_3 = ClientView.createClashFieldChest(arg_5_1, iter_5_0, iter_5_0 <= 3 and Data.CardQuality.R or iter_5_0 <= 5 and Data.CardQuality.SR or Data.CardQuality.UR, true)

		var_5_3:setCascadeOpacityEnabled(true)
		table.insert(var_5_2, var_5_3)
	end

	local var_5_4 = lc.w(var_5_1)
	local var_5_5 = lc.h(var_5_1) + 8 + lc.h(var_5_2[1])

	var_5_0:setContentSize(var_5_4, var_5_5)
	lc.addChildToPos(var_5_0, var_5_1, cc.p(lc.w(var_5_0) / 2, lc.h(var_5_0) - lc.h(var_5_1) / 2))

	local var_5_6 = -86
	local var_5_7 = lc.bottom(var_5_1) - 8

	for iter_5_1, iter_5_2 in ipairs(var_5_2) do
		lc.addChildToPos(var_5_0, iter_5_2, cc.p(var_5_6 + lc.w(iter_5_2) / 2, var_5_7 - lc.h(iter_5_2) / 2))

		var_5_6 = var_5_6 + lc.w(iter_5_2) + 35
	end

	return var_5_0
end

function var_0_0.onBtnArrow(arg_6_0, arg_6_1)
	arg_6_0._btnArrowLeft:setVisible(true)
	arg_6_0._btnArrowRight:setVisible(true)

	local var_6_0 = lc.w(arg_6_0._form)
	local var_6_1 = lc.cw(arg_6_0._form)
	local var_6_2 = lc.y(arg_6_0._fieldArea)
	local var_6_3
	local var_6_4

	if arg_6_1 == arg_6_0._btnArrowLeft then
		var_6_3 = arg_6_0._grade - 1
	else
		var_6_3 = arg_6_0._grade + 1
		var_6_0 = -var_6_0
	end

	local var_6_5 = arg_6_0:createArea(var_6_3)

	arg_6_0._btnArrowLeft:setVisible(var_6_3 ~= Data.FindClashGrade.bronze)
	arg_6_0._btnArrowRight:setVisible(var_6_3 ~= Data.FindClashGrade.legend)
	lc.addChildToPos(arg_6_0._clipNode, var_6_5, cc.p(var_6_1 - var_6_0, var_6_2))

	local var_6_6 = arg_6_0._fieldArea
	local var_6_7 = lc.absTime(0.5)

	var_6_6:stopAllActions()
	var_6_6:runAction(lc.sequence(lc.ease(lc.moveTo(var_6_7, var_6_1 + var_6_0, var_6_2), "BackO"), lc.remove()))
	var_6_5:runAction(lc.ease(lc.moveTo(var_6_7, var_6_1, var_6_2), "BackO"))

	arg_6_0._fieldArea = var_6_5
	arg_6_0._grade = var_6_3
end

return var_0_0
