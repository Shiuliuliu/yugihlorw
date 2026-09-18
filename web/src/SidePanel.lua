local var_0_0 = class("SidePanel", lc.ExtendUIWidget)
local var_0_1 = require("BaseForm")

var_0_0.WIDTH = 400

local var_0_2 = 14

var_0_0.CONTENT_MARGIN_LEFT = 15
var_0_0.CONTENT_MARGIN_RIGHT = 15
var_0_0.CONTENT_MARGIN_H = var_0_0.CONTENT_MARGIN_LEFT + var_0_0.CONTENT_MARGIN_RIGHT
var_0_0.CONTENT_MARGIN_BOTTOM = 50

function var_0_0.createSidePanel(arg_1_0)
	local var_1_0 = arg_1_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setContentSize(lc.Director:getVisibleSize())
	var_1_0:setTouchEnabled(true)
	var_1_0:setTouchSwallow(false)

	return var_1_0
end

function var_0_0.create()
	local var_2_0 = var_0_0.createSidePanel(var_0_0)

	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local var_3_0 = ClientView.createFrameBox(cc.size(var_0_0.WIDTH, lc.h(arg_3_0) - 20))

	var_3_0:setPosition(lc.w(arg_3_0) + lc.w(var_3_0) / 2, lc.h(arg_3_0) / 2 - 5)
	arg_3_0:addChild(var_3_0)
	var_3_0:runAction(cc.Sequence:create(cc.EaseSineOut:create(lc.moveTo(0.2, cc.p(lc.w(arg_3_0) - lc.w(var_3_0) / 2, lc.y(var_3_0))))))

	arg_3_0._formBG = var_3_0

	local var_3_1 = lc.createMaskLayer(192, lc.Color3B.black, cc.size(lc.w(var_3_0) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, 40))

	var_3_1:setAnchorPoint(0.5, 1)
	var_3_1:setPosition(lc.w(var_3_0) / 2, lc.h(var_3_0) - ClientView.FRAME_INNER_TOP)

	arg_3_0._title = ClientView.createBMFont(ClientView.BMFont.huali_32, "")

	lc.addChildToCenter(var_3_1, arg_3_0._title)
	var_3_0:addChild(var_3_1, -1)

	arg_3_0._titleBG = var_3_1
end

function var_0_0.setWillRemoveCallback(arg_4_0, arg_4_1)
	arg_4_0._willRemoveCallback = arg_4_1
end

function var_0_0.bindToNode(arg_5_0, arg_5_1)
	arg_5_0._bindNode = arg_5_1
	arg_5_1._panel = arg_5_0
end

function var_0_0.hide(arg_6_0)
	arg_6_0._formBG:stopAllActions()
	arg_6_0._formBG:runAction(cc.Sequence:create(cc.EaseSineIn:create(cc.MoveTo:create(0.2, cc.p(lc.w(arg_6_0) + lc.w(arg_6_0._formBG) / 2, lc.y(arg_6_0._formBG)))), cc.CallFunc:create(function()
		arg_6_0:removeFromParent(true)
	end)))

	if arg_6_0._willRemoveCallback ~= nil then
		arg_6_0._willRemoveCallback()
	end

	if arg_6_0._bindNode ~= nil then
		arg_6_0._bindNode._panel = nil
		arg_6_0._bindNode = nil
	end
end

function var_0_0.initContentBg(arg_8_0, arg_8_1)
	local var_8_0 = lc.w(arg_8_0._formBG) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT
	local var_8_1 = lc.bottom(arg_8_0._titleBG)
	local var_8_2

	if arg_8_1 then
		var_8_1 = var_8_1 - 40
		var_8_2 = ClientView.createHorizontalContentTab(cc.size(var_8_0, var_8_1), arg_8_1)

		lc.addChildToPos(arg_8_0._formBG, var_8_2, cc.p(lc.w(arg_8_0._formBG) / 2, lc.h(var_8_2) / 2 - 6), -1)
	else
		local var_8_3 = var_8_1 + 10

		var_8_2 = ccui.Layout:create()

		var_8_2:setAnchorPoint(0.5, 0.5)
		var_8_2:setContentSize(cc.size(var_8_0, var_8_3))
		var_8_2:setTouchEnabled(true)
		lc.addChildToPos(arg_8_0._formBG, var_8_2, cc.p(lc.w(arg_8_0._formBG) / 2, lc.h(var_8_2) / 2 - 6), -1)
	end

	arg_8_0._contentBg = var_8_2
end

function var_0_0.addCloseButton(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._formBG
	local var_9_1 = ClientView.createShaderButton("img_btn_close", arg_9_1)

	lc.addChildToPos(var_9_0, var_9_1, cc.p(lc.w(var_9_0) - 56, lc.h(var_9_0) - 36), 2)
end

function var_0_0.addArea(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 then
		lc.addChildToPos(arg_10_0._contentBg, arg_10_1, cc.p(lc.w(arg_10_0._contentBg) / 2 - 8, arg_10_2 - lc.h(arg_10_1) / 2))

		return arg_10_2 - lc.h(arg_10_1) - var_0_2
	else
		arg_10_0._contentBg:addChild(arg_10_1)
	end
end

function var_0_0.createPlayerArea(arg_11_0, arg_11_1)
	local var_11_0 = lc.w(arg_11_0._contentBg) - var_0_0.CONTENT_MARGIN_H
	local var_11_1 = 144
	local var_11_2 = lc.createNode(cc.size(var_11_0, var_11_1))
	local var_11_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_11_1)

	lc.addChildToPos(var_11_2, var_11_3, cc.p(var_0_0.CONTENT_MARGIN_LEFT + lc.w(var_11_3) / 2, var_11_1 - lc.h(var_11_3) / 2))

	local var_11_4 = UserWidget.create(nil, UserWidget.Flag.NAME_UNION)

	var_11_4:setContentSize(lc.w(var_11_4) + UserWidget.AVATAR_GAP + UserWidget.NAME_WIDTH, lc.h(var_11_4))
	lc.addChildToPos(var_11_2, var_11_4, cc.p(lc.left(var_11_3) + lc.w(var_11_4) / 2, lc.h(var_11_4) / 2))

	arg_11_0._userArea = var_11_4
	arg_11_0._playerArea = var_11_2

	return var_11_2
end

function var_0_0.createTroopArea(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = lc.w(arg_12_0._contentBg)

	arg_12_2 = arg_12_2 or 142

	local var_12_1 = arg_12_2 > 142
	local var_12_2 = lc.createNode(cc.size(var_12_0, arg_12_2))
	local var_12_3 = lc.createSprite({
		_name = "img_com_bg_5",
		_crect = ClientView.CRECT_COM_BG5,
		_size = cc.size(90, 46)
	})

	lc.addChildToPos(var_12_2, var_12_3, cc.p(lc.w(var_12_2) - lc.w(var_12_3) / 2, arg_12_2 - lc.h(var_12_3) / 2 + 12))

	local var_12_4 = lc.createSprite("img_icon_cardnum")

	var_12_4:setScale(0.6)
	lc.addChildToPos(var_12_3, var_12_4, cc.p(24, lc.h(var_12_3) / 2 + 2))

	var_12_2._cardNumLabel = ClientView.createBMFont(ClientView.BMFont.huali_26, "0")

	lc.addChildToPos(var_12_3, var_12_2._cardNumLabel, cc.p(60, lc.h(var_12_3) / 2 + 2))

	local var_12_5 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_12_1)

	lc.addChildToPos(var_12_2, var_12_5, cc.p(var_0_0.CONTENT_MARGIN_LEFT + lc.w(var_12_5) / 2, arg_12_2 - lc.h(var_12_5) / 2))

	local var_12_6

	if var_12_1 then
		var_12_6 = lc.List.createV(cc.size(var_12_0, arg_12_2 - 36), 6, 2)

		local var_12_7 = lc.createSprite("img_gradient_border")

		var_12_7:setScaleX(var_12_0 / lc.w(var_12_7))
		var_12_7:setColor(cc.c3b(222, 210, 182))
		lc.addChildToPos(var_12_2, var_12_7, cc.p(var_12_0 / 2, lc.h(var_12_6) - 5), 1)

		local var_12_8 = lc.createSprite("img_gradient_border")

		var_12_8:setScaleX(var_12_0 / lc.w(var_12_8))
		var_12_8:setFlippedY(true)
		var_12_8:setColor(cc.c3b(222, 210, 182))
		lc.addChildToPos(var_12_2, var_12_8, cc.p(var_12_0 / 2, 5), 1)
	else
		var_12_6 = lc.List.createH(cc.size(var_12_0, 110), var_0_0.CONTENT_MARGIN_LEFT, 10)
	end

	lc.addChildToPos(var_12_2, var_12_6, cc.p(0, 0))

	var_12_2._list = var_12_6
	var_12_6._isMultiLine = var_12_1

	return var_12_2
end

function var_0_0.createDropArea(arg_13_0, arg_13_1)
	local var_13_0 = lc.w(arg_13_0._contentBg)
	local var_13_1 = 140
	local var_13_2 = lc.createNode(cc.size(var_13_0, var_13_1))
	local var_13_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.MAYBE) .. Str(STR.GET))

	var_13_3:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_13_2, var_13_3, cc.p(var_0_0.CONTENT_MARGIN_LEFT, var_13_1 - lc.h(var_13_3) / 2))

	local var_13_4 = lc.List.createH(cc.size(var_13_0, 110), var_0_0.CONTENT_MARGIN_LEFT, 10)

	lc.addChildToPos(var_13_2, var_13_4, cc.p(0, 0))

	arg_13_0._dropList = var_13_4
	arg_13_0._dropArea = var_13_2
	arg_13_0._dropTitle = var_13_3

	return var_13_2
end

function var_0_0.addDividingLine(arg_14_0, arg_14_1)
	local var_14_0 = ClientView.createDividingLine(lc.w(arg_14_0._contentBg), ClientView.COLOR_DIVIDING_LINE_LIGHT)

	lc.addChildToPos(arg_14_0._contentBg, var_14_0, cc.p(lc.w(arg_14_0._contentBg) / 2, arg_14_1))

	arg_14_0._dividingLine = var_14_0
end

function var_0_0.createButtonArea(arg_15_0)
	local var_15_0 = lc.w(arg_15_0._contentBg)
	local var_15_1 = 130
	local var_15_2 = ccui.Layout:create()

	var_15_2:setContentSize(var_15_0, var_15_1)
	var_15_2:setAnchorPoint(0.5, 0.5)
	var_15_2:setPosition(lc.w(arg_15_0._contentBg) / 2, var_0_0.CONTENT_MARGIN_BOTTOM + var_15_1 / 2)

	arg_15_0._buttonArea = var_15_2

	return var_15_2
end

function var_0_0.updateTroopArea(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1._list
	local var_16_1 = arg_16_1._list._isMultiLine

	var_16_0:removeAllChildren()

	local var_16_2 = 0
	local var_16_3 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_2) do
		local var_16_4 = IconWidget.create({
			_infoId = iter_16_1._infoId,
			_num = iter_16_1._num
		}, IconWidget.DisplayFlag.CARD_TROOP)

		var_16_2 = var_16_2 + iter_16_1._num

		table.insert(var_16_3, var_16_4)
	end

	if var_16_1 then
		local var_16_5 = 100
		local var_16_6 = IconWidget.SIZE / 2 + 16
		local var_16_7 = var_16_5 / 2
		local var_16_8

		for iter_16_2, iter_16_3 in ipairs(var_16_3) do
			if var_16_8 == nil then
				var_16_8 = ccui.Widget:create()

				var_16_8:setContentSize(lc.w(var_16_0), var_16_5)
			end

			lc.addChildToPos(var_16_8, iter_16_3, cc.p(var_16_6, var_16_7))

			if iter_16_2 % 4 == 0 then
				var_16_0:pushBackCustomItem(var_16_8)

				var_16_8 = nil
				var_16_6 = IconWidget.SIZE / 2 + 16
			else
				var_16_6 = var_16_6 + IconWidget.SIZE + 12
			end
		end

		if var_16_8 then
			var_16_0:pushBackCustomItem(var_16_8)
		end
	else
		for iter_16_4, iter_16_5 in ipairs(var_16_3) do
			var_16_0:pushBackCustomItem(iter_16_5)
		end
	end

	arg_16_1._cardNumLabel:setString(string.format("%d", var_16_2))
end

function var_0_0.updateDropArea(arg_17_0, arg_17_1)
	arg_17_0._dropList:removeAllItems()

	for iter_17_0 = 1, #arg_17_1 do
		local var_17_0 = arg_17_1[iter_17_0]
		local var_17_1 = IconWidget.create({
			_showOwnCount = true,
			_isFragment = false,
			_infoId = var_17_0
		}, IconWidgetFlag.ITEM_NO_NAME)

		arg_17_0._dropList:pushBackCustomItem(var_17_1)
	end
end

return var_0_0
