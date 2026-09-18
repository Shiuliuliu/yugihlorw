local var_0_0 = class("RecruiteDetailForm", BaseForm)
local var_0_1 = require("CardList")
local var_0_2 = require("FilterWidget")
local var_0_3 = require("CardInfoPanel")
local var_0_4 = 0.6
local var_0_5 = 80

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = lc.Director:getVisibleSize()

	var_0_0.super.init(arg_2_0, cc.size(var_2_0.width - (16 + ClientView.FRAME_TAB_WIDTH) * 2, var_2_0.height - 80), Str(arg_2_1._nameSid), initFlag, true)

	arg_2_0._infoOnce = arg_2_1
	arg_2_0._infoTen = arg_2_2
	arg_2_0._selectType = Data.CardType.monster

	arg_2_0:createListArea()
	arg_2_0:createBottomArea()
end

function var_0_0.createListArea(arg_3_0)
	local var_3_0 = var_0_1.create(cc.size(lc.w(arg_3_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_3_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - var_0_5), var_0_4, true)

	var_3_0:setAnchorPoint(0.5, 0.5)

	arg_3_0._cardList = var_3_0

	var_3_0:setMode(var_0_1.ModeType.recruite)

	var_3_0._recruiteInfo = arg_3_0._infoOnce

	var_3_0:setPosition(lc.w(arg_3_0._frame) / 2, lc.h(arg_3_0._frame) / 2 + var_0_5 / 2)
	var_3_0:registerCardSelectedHandler(function(arg_4_0)
		var_0_3.create(arg_4_0, 1, var_0_3.OperateType.view):show()
	end)
	arg_3_0._form:addChild(var_3_0)

	local var_3_1 = (lc.w(arg_3_0._frame) - lc.w(arg_3_0._cardList)) / 2 + 16

	arg_3_0._cardList._pageLeft._pos = cc.p(-var_3_1, 276)
	arg_3_0._cardList._pageRight._pos = cc.p(lc.w(arg_3_0._cardList) + var_3_1, 276)

	local var_3_2 = var_3_1 + 32
	local var_3_3 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_3_0._frame, var_3_3, cc.p(-lc.w(var_3_3) / 2 + 12, 40), -1)

	arg_3_0._pageBg = var_3_3

	arg_3_0._cardList._pageLabel:setPosition(-var_3_2, -68)
	arg_3_0:updateCardList()
end

function var_0_0.createBottomArea(arg_5_0)
	local var_5_0 = ClientView.createLineSprite("img_bottom_bg", lc.w(arg_5_0._cardList))

	var_5_0:setAnchorPoint(0.5, 0)
	lc.addChildToPos(arg_5_0._frame, var_5_0, cc.p(lc.w(arg_5_0._frame) / 2, ClientView.FRAME_INNER_BOTTOM - 12), -1)

	arg_5_0._bottomArea = var_5_0

	local var_5_1 = ClientView.createTTF(Str(arg_5_0._infoOnce._descSid), ClientView.FontSize.S1)

	var_5_1:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_5_0, var_5_1, cc.p(20, lc.h(var_5_0) / 2))

	arg_5_0._info = var_5_1
end

function var_0_0.updateCardList(arg_6_0)
	arg_6_0._cardList:init(arg_6_0._selectType, {})
	arg_6_0._cardList:refresh(true)
end

function var_0_0.onEnter(arg_7_0)
	var_0_0.super.onEnter(arg_7_0)

	arg_7_0._listeners = {}
end

function var_0_0.onExit(arg_8_0)
	var_0_0.super.onExit(arg_8_0)

	for iter_8_0 = 1, #arg_8_0._listeners do
		lc.Dispatcher:removeEventListener(arg_8_0._listeners[iter_8_0])
	end
end

return var_0_0
