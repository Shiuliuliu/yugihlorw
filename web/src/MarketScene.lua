local var_0_0 = require("BaseUIScene")
local var_0_1 = class("MarketScene", var_0_0)
local var_0_2 = require("BaseForm")
local var_0_3 = require("CardList")
local var_0_4 = require("FilterWidget")
local var_0_5 = require("ProductWidget")
local var_0_6 = require("CardInfoPanel")
local var_0_7 = 1
local var_0_8 = 190
local var_0_9 = 540
local var_0_10 = 476
local var_0_11 = {
	book = 4,
	equip = 2,
	hero = 1,
	horse = 3,
	vip = Data.MarketBuyType.vip,
	daily = Data.MarketBuyType.daily,
	random = Data.MarketBuyType.random,
	union = Data.MarketBuyType.union,
	dragon_flag = Data.MarketBuyType.dragon_flag
}
local var_0_12 = var_0_5.PRODUCT_ITEM_SIZE
local var_0_13 = 16
local var_0_14

function var_0_1.create(arg_1_0, arg_1_1)
	return lc.createScene(var_0_1, arg_1_0, arg_1_1)
end

function var_0_1.init(arg_2_0, arg_2_1, arg_2_2)
	if not var_0_1.super.init(arg_2_0, ClientData.SceneId.market, STR.SID_FIXITY_NAME_1008, var_0_0.STYLE_TAB, true) then
		return false
	end

	local var_2_0 = ClientView.createFrameBox(cc.size(lc.w(arg_2_0) - 148, lc.bottom(arg_2_0._titleArea)))

	lc.addChildToPos(arg_2_0, var_2_0, cc.p(lc.w(var_2_0) / 2 + 148, lc.h(var_2_0) / 2))

	arg_2_0._frame = var_2_0

	ClientView.addVerticalTabButtons(arg_2_0, {
		"",
		"",
		"",
		"",
		""
	}, lc.top(arg_2_0._frame) - 80, lc.left(arg_2_0._frame) - 124, 580)

	local var_2_1 = ClientView.createLineSprite("img_bottom_bg", lc.w(var_2_0) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT)

	lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.w(var_2_0) / 2, lc.h(var_2_1) / 2 + ClientView.FRAME_INNER_BOTTOM - 12), -1)

	arg_2_0._bottomArea = var_2_1
	arg_2_0._topBgPos = cc.p(arg_2_0._titleArea:getPosition())

	local var_2_2 = ccui.Layout:create()

	var_2_2:setContentSize(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - lc.top(arg_2_0._bottomArea)))
	var_2_2:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.x(arg_2_0._frame), lc.top(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - lc.h(var_2_2) / 2))

	arg_2_0._listArea = var_2_2
	arg_2_0._isSell = arg_2_2 or false
	arg_2_0._tabArea._focusTabIndex = arg_2_1 or var_0_11.daily

	arg_2_0:syncData()

	return true
end

function var_0_1.onEnter(arg_3_0)
	var_0_1.super.onEnter(arg_3_0)
	arg_3_0:scheduleUpdateWithPriorityLua(function(arg_4_0)
		if not arg_3_0:checkWorking() then
			return
		end

		arg_3_0:updateTime()
	end, 0)

	arg_3_0._listeners = {}

	local var_3_0 = lc.addEventListener(Data.Event.prop_dirty, function(arg_5_0)
		local var_5_0 = arg_5_0._data
		local var_5_1 = P:getItemCount(var_5_0._infoId)

		for iter_5_0, iter_5_1 in ipairs(arg_3_0._moneyAreas) do
			if iter_5_1._resType == var_5_0._infoId then
				iter_5_1._label:setString(var_5_1)

				break
			end
		end
	end)

	table.insert(arg_3_0._listeners, var_3_0)

	local var_3_1 = lc.addEventListener(Data.Event.market_list_dirty, function(arg_6_0)
		if not arg_3_0._isSell and arg_3_0._tabArea._focusTabIndex == arg_6_0._type then
			arg_3_0:prepareRefresh()
			arg_3_0:refreshMarket(arg_6_0._type)
		end
	end)

	table.insert(arg_3_0._listeners, var_3_1)

	local var_3_2 = lc.addEventListener(Data.Event.card_select, function(arg_7_0)
		arg_3_0:updateSellGold()
	end)

	table.insert(arg_3_0._listeners, var_3_2)

	local var_3_3 = lc.addEventListener(Data.Event.card_list_dirty, function(arg_8_0)
		arg_3_0:updateSellGold()
	end)

	table.insert(arg_3_0._listeners, var_3_3)

	local var_3_4 = lc.addEventListener(Data.Event.fragment_market_open, function(arg_9_0)
		arg_3_0:refreshMode(var_0_11.fragment)
	end)

	table.insert(arg_3_0._listeners, var_3_4)

	local var_3_5 = lc.addEventListener(Data.Event.fragment_market_closed, function(arg_10_0)
		if arg_3_0._tabArea._tabs[var_0_11.fragment]:isVisible() then
			arg_3_0:showTab(var_0_11.fragment)
		end
	end)

	table.insert(arg_3_0._listeners, var_3_5)

	local var_3_6 = lc.addEventListener(Data.Event.vip_dirty, function(arg_11_0)
		local var_11_0 = arg_3_0._tabArea._focusTabIndex

		if var_11_0 == Data.MarketBuyType.daily then
			arg_3_0:refreshMarket(var_11_0)
		end
	end)

	table.insert(arg_3_0._listeners, var_3_6)
end

function var_0_1.hide(arg_12_0)
	if arg_12_0._isSell then
		arg_12_0:changeMode()
	else
		var_0_1.super.hide(arg_12_0)
	end
end

function var_0_1.onExit(arg_13_0)
	var_0_1.super.onExit(arg_13_0)

	for iter_13_0 = 1, #arg_13_0._listeners do
		lc.Dispatcher:removeEventListener(arg_13_0._listeners[iter_13_0])
	end

	arg_13_0:unscheduleUpdate()
end

function var_0_1.onCleanup(arg_14_0)
	var_0_1.super.onCleanup(arg_14_0)
end

function var_0_1.syncData(arg_15_0)
	var_0_1.super.syncData(arg_15_0)

	var_0_14 = P._playerMarket

	if not arg_15_0._isSell and arg_15_0._tabArea._focusTabIndex == var_0_11.fragment and var_0_14:isFragMarketClosed() then
		arg_15_0._tabArea._focusTabIndex = var_0_11.daily
	end

	arg_15_0:refreshMode(arg_15_0._tabArea._focusTabIndex)
end

function var_0_1.changeMode(arg_16_0)
	arg_16_0._isSell = not arg_16_0._isSell

	if arg_16_0._isSell then
		arg_16_0:refreshMode(var_0_11.hero)
	elseif var_0_14:isFragMarketClosed() then
		arg_16_0:refreshMode(var_0_11.daily)
	else
		arg_16_0:refreshMode(var_0_11.fragment)
	end
end

--- A refused refresh has to put the list back, not just toast.
function var_0_1.onMsgErrorStatus(arg_90_0, arg_90_1, arg_90_2)
	local var_90_0 = P._playerMarket:onRefreshFailed(arg_90_1.type)

	if var_90_0 then
		arg_90_0:refreshMarket(var_90_0)
	end

	return var_0_1.super.onMsgErrorStatus(arg_90_0, arg_90_1, arg_90_2)
end

function var_0_1.prepareRefresh(arg_17_0)
	arg_17_0._list = nil
	arg_17_0._listArea._indicator = nil

	arg_17_0._listArea:removeAllChildren()

	if arg_17_0._topArea then
		arg_17_0._topArea:removeFromParent()

		arg_17_0._topArea = nil
	end

	if arg_17_0._filterWidget then
		arg_17_0._filterWidget:removeFromParent()

		arg_17_0._filterWidget = nil
	end
end

function var_0_1.refreshMode(arg_18_0, arg_18_1)
	local var_18_0

	if not arg_18_0._isSell then
		var_18_0 = {
			Str(STR.VIP_MARKET),
			Str(STR.DAILY_MARKET),
			Str(STR.RANDOM_MARKET),
			Str(STR.UNION_MARKET),
			Str(STR.CLASH_MARKET)
		}
	else
		var_18_0 = {
			Str(STR.MONSTER),
			Str(STR.EQUIP),
			Str(STR.HORSE),
			Str(STR.BOOK)
		}
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._tabArea._tabs) do
		iter_18_1._label:setString(var_18_0[iter_18_0])
		iter_18_1:setVisible(iter_18_0 <= #var_18_0)

		if iter_18_1._off then
			iter_18_1._off:removeFromParent()

			iter_18_1._off = nil
		end
	end

	if not arg_18_0._isSell then
		if not var_0_14:hasVipGoods() then
			arg_18_0._tabArea:unfocusTab(var_0_11.vip)
			arg_18_0._tabArea._tabs[var_0_11.vip]:setVisible(false)
		end

		arg_18_0._tabArea:unfocusTab(var_0_11.union)
		arg_18_0._tabArea._tabs[var_0_11.union]:setVisible(false)

		for iter_18_2, iter_18_3 in ipairs(arg_18_0._tabArea._tabs) do
			if P._playerMarket._offs[iter_18_2] * 10 < 10 then
				local var_18_1 = lc.createNode(cc.size(50, 50))
				local var_18_2 = lc.createSprite("img_hl_bg")

				var_18_2:setScale(0.6)
				lc.addChildToCenter(var_18_1, var_18_2)

				local var_18_3 = P._playerMarket._offs[iter_18_2] * 10
				local var_18_4 = ClientView.createBMFont(ClientView.BMFont.huali_20, string.format("%d%s", var_18_3, Str(STR.DISCOUNT)))

				var_18_4:setScale(0.8)
				var_18_4:setColor(ClientView.COLOR_TEXT_RED)
				var_18_4:setRotation(10)
				lc.addChildToCenter(var_18_1, var_18_4)
				lc.addChildToPos(iter_18_3, var_18_1, cc.p(lc.w(iter_18_3) - 30, lc.h(iter_18_3) - 20))

				iter_18_3._off = var_18_1
			end
		end
	end

	arg_18_0._tabArea:updateTabsPos()
	arg_18_0:showTab(arg_18_1)
end

function var_0_1.showTab(arg_19_0, arg_19_1)
	if arg_19_0._isSell then
		if arg_19_1 ~= var_0_11.hero then
			local var_19_0

			if arg_19_1 == var_0_11.equip then
				var_19_0 = P._playerCity:getBlacksmithUnlockLevel()
			elseif arg_19_1 == var_0_11.horse then
				var_19_0 = P._playerCity:getStableUnlockLevel()
			elseif arg_19_1 == var_0_11.book then
				var_19_0 = P._playerCity:getLibraryUnlockLevel()
			end

			if var_19_0 > P._level then
				ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), var_19_0))

				return
			end
		end
	elseif arg_19_1 == var_0_11.fragment then
		if P._level < Data._globalInfo._unlockExchange then
			ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), Data._globalInfo._unlockExchange))

			return
		end
	elseif arg_19_1 == var_0_11.flag then
		if P._level < Data._globalInfo._unlockFindMatch then
			ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), Data._globalInfo._unlockFindMatch))

			return
		end
	elseif arg_19_1 == var_0_11.dragon_flag then
		if P._level < Data._globalInfo._unlockFindMatch then
			ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), Data._globalInfo._unlockFindMatch))

			return
		end
	elseif arg_19_1 == var_0_11.union and not P:hasUnion() then
		ToastManager.push(Str(STR.UNLOCK_JOIN_UNION))

		return
	end

	arg_19_0._tabArea:showTab(arg_19_1)
	arg_19_0:prepareRefresh()

	local var_19_1 = arg_19_0._titleArea

	if arg_19_0._isSell then
		arg_19_0:refreshSellArea()
	else
		local var_19_2 = arg_19_0._tabArea._focusTabIndex

		arg_19_0:refreshMarket(var_19_2)
	end

	arg_19_0:refreshBottomArea()
end

function var_0_1.createProductList(arg_20_0)
	local var_20_0 = arg_20_0._listArea
	local var_20_1 = lc.List.createH(cc.size(lc.w(var_20_0), lc.h(var_20_0)), 20, var_0_13)

	lc.addChildToPos(var_20_0, var_20_1, cc.p(0, 0))

	arg_20_0._list = var_20_1
end

function var_0_1.refreshMarket(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._listArea._indicator

	if var_0_14:isRefreshing(arg_21_1) then
		if arg_21_0._list then
			arg_21_0._list:setVisible(false)
		end

		if var_21_0 == nil then
			arg_21_0._listArea._indicator = ClientView.showPanelActiveIndicator(arg_21_0._listArea)
		end
	else
		if var_21_0 then
			var_21_0:removeFromParent()

			arg_21_0._listArea._indicator = nil
		end

		arg_21_0:createProductList()

		local var_21_1 = var_0_14:getProducts(arg_21_1)

		arg_21_0:refreshProductList(var_21_1)

		arg_21_0._moneyRes = {}

		if arg_21_1 == Data.MarketBuyType.random then
			arg_21_0._moneyRes[Data.PropsId.refresh_token] = 1

			if GuideManager.getCurStepName() == "show tab randommarket" then
				GuideManager.finishStep()
			end
		elseif arg_21_1 == Data.MarketBuyType.fragment then
			arg_21_0._moneyRes[Data.CommonFragmentId.hero_legend] = 1
		end
	end
end

function var_0_1.refreshProductList(arg_22_0, arg_22_1)
	local var_22_0 = lc.arrayToTable(arg_22_1, 2)
	local var_22_1 = arg_22_0._list

	var_22_1:bindData(var_22_0, function(arg_23_0, arg_23_1)
		arg_22_0:setOrCreateProductItem(arg_23_0, arg_23_1)
	end, math.min(8, #var_22_0))

	for iter_22_0 = 1, var_22_1._cacheCount do
		local var_22_2 = arg_22_0:setOrCreateProductItem(nil, var_22_0[iter_22_0])

		var_22_1:pushBackCustomItem(var_22_2)
	end

	var_22_1:jumpToLeft()
end

function var_0_1.setOrCreateProductItem(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 == nil then
		local var_24_0 = var_0_13
		local var_24_1 = var_0_12.width
		local var_24_2 = var_0_12.height + var_24_0 + var_0_12.height

		arg_24_1 = ccui.Widget:create()

		arg_24_1:setContentSize(var_24_1, var_24_2)

		arg_24_1._products = {}

		local var_24_3 = var_24_1 / 2
		local var_24_4 = var_24_2 - var_0_12.height / 2

		arg_24_1._pos = {
			cc.p(var_24_3, var_24_4),
			cc.p(var_24_3, var_24_4 - var_0_12.height - var_24_0)
		}
	end

	local var_24_5 = arg_24_1._products

	for iter_24_0 = 1, 2 do
		local var_24_6 = var_24_5[iter_24_0]
		local var_24_7 = arg_24_2[iter_24_0]

		if iter_24_0 <= #arg_24_2 then
			if var_24_6 == nil then
				var_24_6 = var_0_5.create(var_24_7)

				lc.addChildToPos(arg_24_1, var_24_6, arg_24_1._pos[iter_24_0])

				var_24_5[iter_24_0] = var_24_6
			else
				var_24_6:updateProduct(var_24_7)
			end

			var_24_6:registerCallback(function(arg_25_0)
				arg_24_0:doBuy(arg_25_0)
			end)
			var_24_6:setVisible(true)
		elseif var_24_6 then
			var_24_6:setVisible(false)
		end
	end

	return arg_24_1
end

function var_0_1.refreshSellArea(arg_26_0)
	local var_26_0 = arg_26_0._tabArea._focusTabIndex
	local var_26_1

	if var_26_0 == var_0_11.hero then
		var_26_1 = var_0_4.create(var_0_4.ModeType.monster)

		var_26_1:setFilterNature(var_0_4.FilterNature.all)
	elseif var_26_0 == var_0_11.equip then
		var_26_1 = var_0_4.create(var_0_4.ModeType.equip)
	elseif var_26_0 == var_0_11.horse then
		var_26_1 = var_0_4.create(var_0_4.ModeType.horse)
	elseif var_26_0 == var_0_11.book then
		var_26_1 = var_0_4.create(var_0_4.ModeType.book)
	end

	var_26_1:resetAllFilter()
	var_26_1:registerSortFilterHandler(function()
		arg_26_0:updateSellCardList()
	end)
	lc.addChildToPos(arg_26_0, var_26_1, cc.p(lc.w(arg_26_0) / 2, lc.h(var_26_1) / 2 - 2))

	arg_26_0._filterWidget = var_26_1
	arg_26_0._list = var_0_3.create(cc.size(lc.w(arg_26_0._listArea), lc.h(arg_26_0._listArea)))

	arg_26_0._list:setMode(var_0_3.ModeType.check)
	arg_26_0._list:registerCardSelectedHandler(function(arg_28_0)
		var_0_6.create(arg_28_0, nil, var_0_6.OperateType.own):show()
	end)
	arg_26_0._listArea:addChild(arg_26_0._list)
	arg_26_0:updateSellCardList()
end

function var_0_1.updateSellCardList(arg_29_0, arg_29_1)
	local var_29_0
	local var_29_1 = {}
	local var_29_2, var_29_3 = arg_29_0._filterWidget:getSortFunc()

	if var_29_2 ~= nil then
		var_29_0 = {
			_func = var_29_2,
			_isReverse = not var_29_3
		}
	end

	local var_29_4, var_29_5 = arg_29_0._filterWidget:getFilterNatureFunc()

	if var_29_4 ~= nil then
		var_29_1[var_0_3.FilterType.country] = {
			_func = var_29_4,
			_keyVal = var_29_5
		}
	end

	local var_29_6, var_29_7 = arg_29_0._filterWidget:getFilterCategoryFunc()

	if var_29_6 then
		var_29_1[var_0_3.FilterType.category] = {
			_func = var_29_6,
			_keyVal = var_29_7
		}
	end

	local var_29_8, var_29_9 = arg_29_0._filterWidget:getFilterLevelFunc()

	if var_29_8 then
		var_29_1[var_0_3.FilterType.cost] = {
			_func = var_29_8,
			_keyVal = var_29_9
		}
	end

	local var_29_10, var_29_11 = arg_29_0._filterWidget:getFilterQualityFunc()

	if var_29_10 ~= nil then
		var_29_1[var_0_3.FilterType.quality] = {
			_func = var_29_10,
			_keyVal = var_29_11
		}
	end

	local var_29_12, var_29_13 = arg_29_0._filterWidget:getFilterSearchFunc()

	if var_29_12 ~= nil then
		var_29_1[var_0_3.FilterType.search] = {
			_func = var_29_12,
			_keyVal = var_29_13
		}
	end

	local var_29_14 = arg_29_0._tabArea._focusTabIndex
	local var_29_15

	if var_29_14 == var_0_11.hero then
		var_29_15 = Data.CardType.monster
	elseif var_29_14 == var_0_11.equip then
		var_29_15 = Data.CardType.equip
	elseif var_29_14 == var_0_11.horse then
		var_29_15 = Data.CardType.horse
	elseif var_29_14 == var_0_11.book then
		var_29_15 = Data.CardType.book
	end

	local var_29_16 = P._playerCard:getCards(var_29_15)
	local var_29_17 = {}

	for iter_29_0, iter_29_1 in pairs(var_29_16) do
		iter_29_1._selected = 0

		if not iter_29_1:isSellable() then
			var_29_17[iter_29_0] = iter_29_1
		end
	end

	arg_29_0._list:init(var_29_15, var_29_17, var_29_0, var_29_1)

	if not arg_29_1 then
		arg_29_0._list:refresh(true)
	end
end

function var_0_1.updateTime(arg_30_0)
	if not var_0_14:isFragMarketClosed() and arg_30_0._fragMasterLeaveTime then
		local var_30_0 = var_0_14:getFragMarketRemainTime()

		if var_30_0 < 0 then
			var_30_0 = 0
		end

		arg_30_0._fragMasterLeaveTime:setString(ClientData.formatPeriod(var_30_0))
	end
end

function var_0_1.updateSellGold(arg_31_0)
	if arg_31_0._sellGold then
		local var_31_0 = arg_31_0._list:getSelectedCards()
		local var_31_1 = 0

		for iter_31_0 = 1, #var_31_0 do
			var_31_1 = var_31_1 + var_31_0[iter_31_0]:getSellGold()
		end

		arg_31_0._sellGold:setString(string.format("%d", var_31_1))
	end
end

function var_0_1.refreshBottomArea(arg_32_0)
	local var_32_0 = arg_32_0._bottomArea

	var_32_0:removeAllChildren()

	arg_32_0._fragMasterLeaveTime = nil
	arg_32_0._btnMode = nil
	arg_32_0._sellGold = nil
	arg_32_0._moneyAreas = {}

	if arg_32_0._isSell then
		-- block empty
	else
		local var_32_1 = arg_32_0._tabArea._focusTabIndex
		local var_32_2
		local var_32_3

		if var_32_1 == var_0_11.fragment then
			local var_32_4

			if var_0_14:isFragMarketClosed() then
				local var_32_5 = ClientView.createTTF(Str(STR.FRAG_MARKET_CLOSE_TIP), ClientView.FontSize.S1, ClientView.COLOR_TEXT_RED)

				lc.addChildToPos(var_32_0, var_32_5, cc.p(12 + lc.w(var_32_5) / 2, lc.h(var_32_0) / 2))
			else
				local var_32_6, var_32_7 = ClientView.createKeyValueLabel(Str(STR.FRAG_MARKET_OPEN_TIP), "", ClientView.FontSize.S1, true)

				arg_32_0._fragMasterLeaveTime = var_32_7

				var_32_6:addToParent(var_32_0, cc.p(12, lc.h(var_32_0) / 2))
			end
		elseif var_32_1 == var_0_11.daily then
			local var_32_8 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_33_0)
				arg_32_0:changeMode()
			end, ClientView.CRECT_BUTTON, 120)

			var_32_8:addLabel(Str(STR.SELL))

			arg_32_0._btnMode = var_32_8
		elseif var_32_1 == var_0_11.random then
			var_32_2 = true
		elseif var_32_1 == var_0_11.flag then
			var_32_2 = true
			var_32_3 = ClientView.createTTF(Str(STR.FLAG_MARKET_TIP), ClientView.FontSize.S1)
		elseif var_32_1 == var_0_11.union then
			var_32_2 = true
			var_32_3 = ClientView.createTTF(Str(STR.UNION_MARKET_TIP), ClientView.FontSize.S1)
		elseif var_32_1 == var_0_11.dragon_flag then
			var_32_2 = true
			var_32_3 = ClientView.createTTF(Str(STR.DRAGON_FLAG_MARKET_TIP), ClientView.FontSize.S1)
		end

		if var_32_3 then
			lc.addChildToPos(var_32_0, var_32_3, cc.p(lc.w(var_32_3) / 2 + 12, lc.h(var_32_0) / 2))
		end

		local var_32_9 = lc.w(var_32_0) - 12

		if var_32_2 then
			local function var_32_10(arg_34_0)
				local var_34_0 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
					arg_32_0:refresh(var_32_1, arg_34_0)
				end, ClientView.CRECT_BUTTON_S, 150)

				var_34_0:addLabel(Str(STR.REFRESH))

				if Data.getType(arg_34_0) == Data.CardType.res then
					var_34_0:addIcon(string.format("img_icon_res%d_s", arg_34_0))
				else
					var_34_0:addIcon(ClientData.getPropIconName(arg_34_0))
				end

				return var_34_0
			end

			local var_32_11 = var_32_10(Data.ResType.ingot)

			lc.addChildToPos(var_32_0, var_32_11, cc.p(lc.w(var_32_0) - lc.w(var_32_11) / 2 - 12, lc.h(var_32_0) / 2))

			var_32_9 = var_32_9 - lc.w(var_32_11) - 10

			local var_32_12

			if var_32_1 == var_0_11.random then
				var_32_12 = var_32_10(Data.PropsId.refresh_token)
			elseif var_32_1 == var_0_11.flag then
				var_32_12 = var_32_10(Data.PropsId.flag)
			elseif var_32_1 == var_0_11.union then
				var_32_12 = var_32_10(Data.PropsId.yubi)
			elseif var_32_1 == var_0_11.dragon_flag then
				var_32_12 = var_32_10(Data.PropsId.dragon_flag)
			end

			if var_32_12 then
				lc.addChildToPos(var_32_0, var_32_12, cc.p(lc.left(var_32_11) - lc.w(var_32_12) / 2 - 10, lc.y(var_32_11)))

				var_32_9 = var_32_9 - lc.w(var_32_12) - 10
			end
		end

		local var_32_13 = var_32_9
		local var_32_14 = lc.h(var_32_0) / 2

		for iter_32_0, iter_32_1 in pairs(arg_32_0._moneyRes) do
			local var_32_15, var_32_16 = Data.getType(iter_32_0)

			if var_32_15 == Data.CardType.res then
				var_32_16 = string.format("img_icon_res%d_s", iter_32_0)
			elseif var_32_15 == Data.CardType.common_fragment then
				var_32_16 = string.format("img_icon_%d", iter_32_0)
			else
				var_32_16 = ClientData.getPropIconName(iter_32_0)
			end

			local var_32_17 = ClientView.createItemCountArea(iter_32_0, var_32_16, 160)

			var_32_17:setAnchorPoint(1, 0.5)

			var_32_17._resType = iter_32_0

			table.insert(arg_32_0._moneyAreas, var_32_17)
			lc.addChildToPos(var_32_0, var_32_17, cc.p(var_32_13, var_32_14))

			var_32_13 = var_32_13 - lc.w(var_32_17) - 10
		end
	end
end

function var_0_1.onCardSell(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._list:getSelectedCards()

	if #var_36_0 == 0 then
		ToastManager.push(Str(STR.SELECT_SALE_CARDS))

		return
	end

	local var_36_1 = P._playerCard:sellCard(var_36_0, arg_36_1)

	if var_36_1 == Data.ErrorType.ok then
		ToastManager.push(Str(STR.SELLSUCCESS))

		local var_36_2 = {}

		for iter_36_0 = 1, #var_36_0 do
			table.insert(var_36_2, var_36_0[iter_36_0]._id)
		end

		ClientData.sendCardSell(var_36_0[1]._infoId, var_36_2)
	elseif var_36_1 == Data.ErrorType.card_not_support then
		ToastManager.push(Str(STR.NOTSELL))
	elseif var_36_1 == Data.ErrorType.card_contain_legend then
		require("Dialog").showDialog(Str(STR.LEGEND_CARD_SOLD) .. "\n" .. Str(STR.SURE_TO_SELL), function()
			arg_36_0:onCardSell(true)
		end)
	end
end

function var_0_1.doBuy(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_1._product

	if var_38_0 == nil then
		ToastManager(Str(STR.INVALID_PRODUCT))

		return
	end

	if arg_38_1._isResLack then
		local var_38_1 = var_38_0._resType

		if var_38_1 == Data.ResType.gold then
			ToastManager.push(Str(STR.NOT_ENOUGH_GOLD))
			require("ExchangeResForm").create(Data.ResType.gold):show()
		elseif var_38_1 == Data.ResType.ingot then
			require("PromptForm").ConfirmBuyIngot.create():show()
		else
			ToastManager.push(Str(STR.NOT_ENOUGH_MONEY))
		end

		return
	end

	if var_38_0._isAct then
		if not arg_38_2 then
			require("PromptForm").ConfirmBuyProduct.create(var_38_0, function()
				arg_38_0:doBuy(arg_38_1, true)
			end):show()

			return
		end

		if var_0_14:buyProduct(var_38_0) == Data.ErrorType.ok then
			ClientData.sendBuyGoods(var_38_0._id, 1)
			arg_38_0:refreshBottomArea()
			ToastManager.push(Str(STR.BUYSUCCESS))
		else
			ToastManager.push(Str(STR.BUYFAIL))
		end
	elseif var_38_0._type == Data.MarketBuyType.daily then
		local var_38_2 = var_0_14:getBuyGoodsNumber(var_38_0._infoId)

		if var_38_2 ~= nil and var_38_2 == 0 then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH_BUY_TIMES), Str(STR.BUY) .. ClientData.getNameByInfoId(var_38_0._infoId)))

			return
		end

		require("SelectCountForm").create(var_38_0):show()
	else
		if var_38_0._type == Data.MarketBuyType.union then
			if P._playerUnion:getMyUnion()._level < var_38_0._info._level then
				ToastManager.push(string.format(Str(STR.UNION_UNLOCK_LEVEL), var_38_0._info._level))

				return
			end
		elseif var_38_0._type == Data.MarketBuyType.fragment and var_0_14:isFragMarketClosed() then
			ToastManager.push(Str(STR.FRAG_MARKET_CLOSE_TIP))
		end

		if not arg_38_2 then
			require("PromptForm").ConfirmBuyProduct.create(var_38_0, function()
				arg_38_0:doBuy(arg_38_1, true)
			end):show()

			return
		end

		if var_0_14:buyProduct(var_38_0) == Data.ErrorType.ok then
			ClientData.sendProductBuy(var_38_0)
			arg_38_0:refreshBottomArea()
			ToastManager.push(Str(STR.BUYSUCCESS))
		else
			ToastManager.push(Str(STR.BUYFAIL))
		end
	end
end

function var_0_1.refresh(arg_41_0, arg_41_1, arg_41_2)
	local function var_41_0()
		var_0_14:sendRefresh(arg_41_1, arg_41_2)
		arg_41_0:refreshMarket(arg_41_1)
	end

	local var_41_1 = P:getBuyRefreshCost(arg_41_1, arg_41_2)
	local var_41_2 = ClientData.getNameByInfoId(arg_41_2)

	if arg_41_2 == Data.ResType.ingot then
		local var_41_3 = P:getRemainBuyRefreshTimes(arg_41_1)

		if var_41_3 == 0 then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH_BUY_TIMES), Str(STR.BUY) .. Str(STR.REFRESH)))

			return
		end

		require("Dialog").showDialog(string.format(Str(STR.CONFIRM_REFRESH_PRODUCTS_TIMES, true), var_41_1, var_41_2, var_41_3, P:getBuyRefreshTimes(arg_41_1)), function()
			if ClientView.checkIngot(var_41_1) then
				if arg_41_1 == Data.MarketBuyType.random then
					P._dailyBuyRefresh = P._dailyBuyRefresh + 1
				elseif arg_41_1 == Data.MarketBuyType.flag then
					P._dailyBuyRefreshPvp = P._dailyBuyRefreshPvp + 1
				elseif arg_41_1 == Data.MarketBuyType.union then
					P._dailyBuyRefreshUnion = P._dailyBuyRefreshUnion + 1
				elseif arg_41_1 == Data.MarketBuyType.dragon_flag then
					P._dailyBuyRefreshLadder = P._dailyBuyRefreshLadder + 1
				end

				P:changeResource(Data.ResType.ingot, -var_41_1)
				var_41_0(arg_41_1)
			end
		end)
	elseif not P._propBag:hasProps(arg_41_2, var_41_1) then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), var_41_2))
	else
		local function var_41_4()
			P._propBag:changeProps(arg_41_2, -var_41_1)
			var_41_0(arg_41_1)
		end

		if var_41_1 == 1 then
			var_41_4()
		else
			require("Dialog").showDialog(string.format(Str(STR.CONFIRM_REFRESH_PRODUCTS, true), var_41_1, var_41_2), var_41_4)
		end
	end
end

function var_0_1.onGuide(arg_45_0, arg_45_1)
	if GuideManager.getCurStepName() == "show tab randommarket" then
		GuideManager.setOperateLayer(arg_45_0._tabArea._tabs[var_0_11.random])

		return
	end

	arg_45_1:stopPropagation()
end

return var_0_1
