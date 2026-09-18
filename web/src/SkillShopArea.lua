local var_0_0 = class("DepotShopArea", lc.ExtendCCNode)
local var_0_1 = require("ItemList")
local var_0_2 = cc.size(180, 210)

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
	arg_3_0:addItemlist()

	local var_3_0 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg1", cc.rect(27, 13, 1, 1))

	var_3_0:setContentSize(cc.size(arg_3_0:getContentSize().width, arg_3_0:getContentSize().height + 20))
	lc.addChildToPos(arg_3_0, var_3_0, cc.p(lc.cw(arg_3_0), lc.ch(arg_3_0) + 20))

	local var_3_1 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_3_1:setContentSize(cc.size(arg_3_0:getContentSize().width + 75, lc.h(var_3_1)))
	lc.addChildToPos(arg_3_0, var_3_1, cc.p(lc.cw(arg_3_0), lc.ch(arg_3_0) + 220))

	local var_3_2 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_3_2:setContentSize(cc.size(arg_3_0:getContentSize().width + 75, lc.h(var_3_2)))
	lc.addChildToPos(arg_3_0, var_3_2, cc.p(lc.cw(arg_3_0), 345))

	local var_3_3 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_3_3:setContentSize(cc.size(arg_3_0:getContentSize().width + 75, lc.h(var_3_3)))
	lc.addChildToPos(arg_3_0, var_3_3, cc.p(lc.cw(arg_3_0), 110))

	local var_3_4 = arg_3_0._itemList
	local var_3_5 = 10

	var_3_4._pageLeft._pos = cc.p(var_3_5, lc.ch(var_3_4))
	var_3_4._pageRight._pos = cc.p(lc.w(var_3_4) - var_3_5, lc.ch(var_3_4))

	local var_3_6 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_3_0._itemList, var_3_6, cc.p(0, lc.ch(var_3_6) + 50), -1)
	var_3_6:setScale(-1, 0.9)
	arg_3_0._itemList._pageLabel:setPosition(cc.p(var_3_6:getPosition()))

	local var_3_7 = {}

	table.insert(var_3_7, lc.addEventListener(Data.Event.prop_dirty, function(arg_4_0)
		if arg_3_0:isVisible() and arg_4_0._data._infoId == Data.PropsId.skill_item_token then
			arg_3_0._itemList:updatePage()
		end
	end))

	arg_3_0._listeners = var_3_7
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

function var_0_0.onBtn(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1._data

	if var_8_0._num - P._playerMarket:getRubbingBoughtCount(var_8_0._id) <= 0 then
		return ToastManager.push(Str(STR.NOT_ENOUGH_GOODS))
	end

	if P:getItemCount(var_8_0._resType) < var_8_0._cost then
		if var_8_0._resType == Data.PropsId.skill_item_token then
			lc.pushScene(require("RechargeSkillTokenScene").create())
		else
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(Data._propsInfo[var_8_0._resType]._nameSid)))
		end

		return
	end

	require("Dialog").showDialog(Str(STR.SURE_TO_BUY), function()
		P._playerMarket._rubbingMap[var_8_0._id] = (P._playerMarket._rubbingMap[var_8_0._id] or 0) + 1

		ClientData.sendBuySkill(var_8_0._id)
		P:addResource(var_8_0._infoId, 1, 1)
		P:addResource(var_8_0._resType, 1, -var_8_0._cost)

		local var_9_0 = require("RewardPanel")

		var_9_0.create({
			{
				count = 1,
				info_id = var_8_0._infoId
			}
		}, var_9_0.MODE_EXCHANGE):show()
		lc.Audio.playAudio(AUDIO.E_CLAIM)
		arg_8_0._itemList:updatePage()
	end)
end

function var_0_0.getData(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = ClientData.getServerTick()

	for iter_10_0, iter_10_1 in ipairs(Data._rubbingProducts) do
		if var_10_1 >= iter_10_1._startTime and var_10_1 <= iter_10_1._endTime then
			var_10_0[#var_10_0 + 1] = iter_10_1
		end
	end

	return var_10_0
end

function var_0_0.setOrCreateItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_1 then
		arg_11_1 = ccui.Layout:create()

		arg_11_1:setTouchEnabled(true)
		arg_11_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
		arg_11_1:setAnchorPoint(0.5, 0.5)
		arg_11_1:setContentSize(var_0_2)

		local var_11_0 = ClientView.createShaderButton("buy_button", function(arg_12_0)
			arg_11_0:onBtn(arg_12_0)
		end)

		var_11_0:setTouchRect(cc.rect(0, 0, lc.w(arg_11_1), lc.h(arg_11_1)))
		lc.addChildToPos(arg_11_1, var_11_0, cc.p(lc.cw(arg_11_1), lc.ch(var_11_0)))

		arg_11_1._btn = var_11_0

		local var_11_1 = IconWidget.createByInfoId(Data.PropsId.skill_item_token, 1, IconWidget.DisplayFlag.ITEM)

		lc.addChildToPos(arg_11_1, var_11_1, cc.p(lc.cw(arg_11_1), lc.top(var_11_0) + lc.ch(var_11_1) - 25))

		function arg_11_1.update(arg_13_0)
			if not arg_13_0 then
				return arg_11_1:setVisible(false)
			end

			arg_11_1:setVisible(true)

			var_11_0._data = arg_13_0

			local var_13_0 = arg_13_0._num - P._playerMarket:getRubbingBoughtCount(arg_13_0._id)

			var_11_1:resetData({
				_infoId = arg_13_0._infoId,
				_count = var_13_0
			})
			var_11_1._countBg._count:setString(string.format("%d/%d", var_13_0, arg_13_0._num))
			ClientView.addPriceToBtn(var_11_0, arg_13_0._cost, arg_13_0._resType, 100, 30)
		end
	end

	arg_11_1.update(arg_11_2)

	return arg_11_1
end

function var_0_0.addItemlist(arg_14_0)
	arg_14_0._itemList = var_0_1.create(cc.size(lc.w(arg_14_0), lc.h(arg_14_0)), var_0_2, string.format(Str(STR.LIST_EMPTY_NO_X), ClientData.getNameByInfoId(Data.PropsId.item_skill_base)), function()
		return arg_14_0:setOrCreateItem()
	end, function(arg_16_0, arg_16_1)
		return arg_14_0:setOrCreateItem(arg_16_0, arg_16_1)
	end, 3, 5)

	arg_14_0._itemList:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_14_0, arg_14_0._itemList, cc.p(lc.cw(arg_14_0), lc.ch(arg_14_0)), 1)

	local var_14_0 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_14_0, var_14_0, cc.p(-lc.w(var_14_0) / 2 + 12, 48), -1)
	arg_14_0._itemList._pageLabel:setPosition(-120, 20)
	arg_14_0._itemList:setData(arg_14_0:getData())

	local var_14_1 = arg_14_0._itemList
	local var_14_2 = 20

	var_14_1._pageLeft._pos = cc.p(-var_14_2, lc.ch(var_14_1))
	var_14_1._pageRight._pos = cc.p(lc.w(var_14_1) + var_14_2, lc.ch(var_14_1))

	var_14_1:updatePage(true)
end

function var_0_0.refreshItemlist(arg_17_0)
	arg_17_0._itemList:refresh()
end

return var_0_0
