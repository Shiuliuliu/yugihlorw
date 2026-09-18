local var_0_0 = class("RecoveryShopArea", lc.ExtendCCNode)
local var_0_1 = require("CardList")

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_0, arg_1_1)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		elseif arg_2_0 == "cleanup" then
			var_1_0:onCleanUp()
		end
	end)
	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_3_0)
	arg_3_0:addCardList()

	local var_3_0 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg1", cc.rect(27, 13, 1, 1))

	var_3_0:setContentSize(cc.size(arg_3_0:getContentSize().width, arg_3_0:getContentSize().height + 20))
	lc.addChildToPos(arg_3_0, var_3_0, cc.p(lc.cw(arg_3_0), lc.ch(arg_3_0) + 20))

	local var_3_1 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_3_1:setContentSize(cc.size(arg_3_0:getContentSize().width + 75, lc.h(var_3_1)))
	lc.addChildToPos(arg_3_0, var_3_1, cc.p(lc.cw(arg_3_0), lc.ch(arg_3_0) + 130))

	local var_3_2 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_3_2:setContentSize(cc.size(arg_3_0:getContentSize().width + 75, lc.h(var_3_2)))
	lc.addChildToPos(arg_3_0, var_3_2, cc.p(lc.cw(arg_3_0), 137))

	local var_3_3 = arg_3_0._cardList
	local var_3_4 = 10

	var_3_3._pageLeft._pos = cc.p(var_3_4, lc.ch(var_3_3))
	var_3_3._pageRight._pos = cc.p(lc.w(var_3_3) - var_3_4, lc.ch(var_3_3))

	local var_3_5 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_3_0._cardList, var_3_5, cc.p(0, lc.ch(var_3_5) + 50), -1)
	var_3_5:setScale(-1, 0.9)
	arg_3_0._cardList._pageLabel:setPosition(cc.p(var_3_5:getPosition()))

	local var_3_6 = {}

	table.insert(var_3_6, lc.addEventListener(Data.Event.card_dirty, function(arg_4_0)
		if arg_3_0:isVisible() then
			arg_3_0._cardList:refresh()
		end
	end))

	arg_3_0._listeners = var_3_6
end

function var_0_0.onEnter(arg_5_0)
	return
end

function var_0_0.onExit(arg_6_0)
	return
end

function var_0_0.onCleanUp(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_7_1)
	end
end

function var_0_0.addCardList(arg_8_0)
	local var_8_0 = var_0_1.create(cc.size(lc.w(arg_8_0), lc.h(arg_8_0)), 0.5, false, 220)

	var_8_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_8_0, var_8_0, cc.p(lc.cw(arg_8_0), lc.ch(arg_8_0)), 2)
	var_8_0:init(Data.BaseCardTypes[1])
	var_8_0:registerTapBtnCustom1(function(arg_9_0)
		local var_9_0 = require("CardOperatePanel")
		local var_9_1 = arg_9_0._card

		var_9_0.create(var_9_1._cardId, var_9_0.OperateMode.recall, var_9_1):show()
	end)
	var_8_0:setMode(var_0_1.ModeType.vote_recovery)

	local var_8_1 = {}
	local var_8_2 = ClientData.getServerTick()

	for iter_8_0, iter_8_1 in ipairs(Data._recallInfo) do
		if var_8_2 >= iter_8_1._startTime and var_8_2 <= iter_8_1._endTime then
			var_8_1[#var_8_1 + 1] = iter_8_1
		end
	end

	var_8_0._shopInfo = var_8_1

	var_8_0:registerCardSelectedHandler(function(arg_10_0, arg_10_1)
		local var_10_0 = require("CardInfoPanel")

		var_10_0.create(arg_10_0, 1, var_10_0.OperateType.view, var_8_0._shopInfo[arg_10_1]):show()
	end)

	local var_8_3 = 20

	var_8_0._pageLeft._pos = cc.p(-var_8_3, lc.ch(var_8_0))
	var_8_0._pageRight._pos = cc.p(lc.w(var_8_0) + var_8_3, lc.ch(var_8_0))

	var_8_0:refresh(true)

	arg_8_0._cardList = var_8_0
end

function var_0_0.refreshCardList(arg_11_0)
	arg_11_0._cardList:refresh()
end

return var_0_0
