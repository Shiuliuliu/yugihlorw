local var_0_0 = require("BaseUIScene")
local var_0_1 = 0.5
local var_0_2 = class("EffectScene", var_0_0)
local var_0_3 = require("FilterWidget")
local var_0_4 = require("CardList")
local var_0_5 = require("CardThumbnail")

function var_0_2.create()
	return lc.createScene(var_0_2, troopType)
end

function var_0_2.init(arg_2_0)
	if not var_0_2.super.init(arg_2_0, ClientData.SceneId.effect, STR.EFFECT_STORE, var_0_0.STYLE_TAB, true) then
		return false
	end

	arg_2_0:createFrame()
	arg_2_0:createCardList()
	ClientView.addVerticalTabButtons(arg_2_0, {
		Str(STR.MONSTER),
		Str(STR.RARE) .. Str(STR.MONSTER)
	}, lc.top(arg_2_0._frame) - 60, lc.left(arg_2_0._frame) - 124, 450, 100)

	local var_2_0 = ClientView.createScale9ShaderButton("img_btn_3", function()
		lc.pushScene(require("CardOperateScene").create())
	end, ClientView.CRECT_BUTTON, 140)

	var_2_0:addLabel(Str(STR.SMELT))
	lc.addChildToPos(arg_2_0, var_2_0, cc.p(lc.w(arg_2_0) - lc.cw(var_2_0) - 10, lc.ch(var_2_0) + 30))
	arg_2_0:showTab(1)

	return true
end

function var_0_2.createFrame(arg_4_0)
	local var_4_0 = ClientView.createFrameBox(cc.size(lc.w(arg_4_0) - (16 + ClientView.FRAME_TAB_WIDTH + ClientView.SCR_EDGE) * 2, lc.h(arg_4_0) - 40))

	lc.addChildToPos(arg_4_0, var_4_0, cc.p(lc.w(arg_4_0) / 2, lc.bottom(arg_4_0._titleArea) - lc.h(var_4_0) / 2 + 10))

	arg_4_0._frame = var_4_0
end

function var_0_2.createCardList(arg_5_0)
	arg_5_0._cardList = var_0_4.create(cc.size(lc.w(arg_5_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 90, lc.h(arg_5_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), var_0_1, false)

	arg_5_0._cardList:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_5_0._frame, arg_5_0._cardList, cc.p(lc.w(arg_5_0._frame) / 2, lc.h(arg_5_0._frame) / 2))
	arg_5_0._cardList:setMode(var_0_4.ModeType.effect_store)
	arg_5_0._cardList:registerCardSelectedHandler(function(arg_6_0, arg_6_1)
		arg_5_0:onCardSelected(arg_6_0, arg_6_1)
	end)

	local var_5_0 = (lc.w(arg_5_0._frame) - lc.w(arg_5_0._cardList)) / 2 + 16

	arg_5_0._cardList._pageLeft._pos = cc.p(-var_5_0, 80)
	arg_5_0._cardList._pageRight._pos = cc.p(lc.w(arg_5_0._cardList) + var_5_0, 80)

	local var_5_1 = var_5_0 + 32
	local var_5_2 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_5_0._frame, var_5_2, cc.p(-lc.w(var_5_2) / 2 + 12, 40), -1)
	arg_5_0._cardList._pageLabel:setPosition(-var_5_1, 12)

	arg_5_0._filterWidgets = {}

	local var_5_3 = {
		var_0_3.ModeType.monster,
		var_0_3.ModeType.magic,
		var_0_3.ModeType.trap,
		var_0_3.ModeType.rare
	}

	for iter_5_0 = 1, #var_5_3 do
		local var_5_4 = var_0_3.create(var_5_3[iter_5_0], lc.h(arg_5_0._frame) - 80)

		var_5_4:resetAllFilter()
		var_5_4:registerSortFilterHandler(function()
			arg_5_0:updateCardList(true)
		end)
		var_5_4:setVisible(iter_5_0 == 1)
		lc.addChildToPos(arg_5_0._frame, var_5_4, cc.p(lc.w(arg_5_0._frame) + ClientView.FRAME_TAB_WIDTH - lc.w(var_5_4) / 2 + 2, lc.h(var_5_4) / 2))

		arg_5_0._filterWidgets[iter_5_0] = var_5_4
	end
end

function var_0_2.showTab(arg_8_0, arg_8_1)
	arg_8_0._tabArea:showTab(arg_8_1)

	local var_8_0 = arg_8_1 == 1 and arg_8_1 or Data.CardType.rare

	for iter_8_0 = 1, #arg_8_0._filterWidgets do
		arg_8_0._filterWidgets[iter_8_0]:setVisible(var_8_0 == iter_8_0)
	end

	arg_8_0:updateCardList(true)
end

function var_0_2.updateCardList(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._tabArea._focusTabIndex
	local var_9_1 = {}
	local var_9_2 = var_9_0 == 1 and var_9_0 or Data.CardType.rare
	local var_9_3 = {}
	local var_9_4
	local var_9_5 = arg_9_0._filterWidgets[var_9_2]
	local var_9_6, var_9_7 = var_9_5:getSortFunc()

	if var_9_6 then
		var_9_4 = {
			_func = var_9_6,
			_isReverse = not var_9_7
		}
	end

	if Data.BaseCardTypes[var_9_2] == Data.CardType.monster or Data.BaseCardTypes[var_9_2] == Data.CardType.rare then
		local var_9_8, var_9_9 = var_9_5:getFilterNatureFunc()

		if var_9_8 then
			var_9_3[var_0_4.FilterType.country] = {
				_func = var_9_8,
				_keyVal = var_9_9
			}
		end

		local var_9_10, var_9_11 = var_9_5:getFilterCategoryFunc()

		if var_9_10 then
			var_9_3[var_0_4.FilterType.category] = {
				_func = var_9_10,
				_keyVal = var_9_11
			}
		end

		local var_9_12, var_9_13 = var_9_5:getFilterLevelFunc()

		if var_9_12 then
			var_9_3[var_0_4.FilterType.cost] = {
				_func = var_9_12,
				_keyVal = var_9_13
			}
		end

		local var_9_14, var_9_15 = var_9_5:getFilterMonsterOptionFunc()

		if var_9_14 then
			var_9_3[var_0_4.FilterType.option] = {
				_func = var_9_14,
				_keyVal = var_9_15
			}
		end
	end

	local var_9_16, var_9_17 = var_9_5:getFilterQualityFunc()

	if var_9_16 then
		var_9_3[var_0_4.FilterType.quality] = {
			_func = var_9_16,
			_keyVal = var_9_17
		}
	end

	local var_9_18, var_9_19 = var_9_5:getFilterCollectFunc()

	if var_9_18 then
		var_9_3[var_0_4.FilterType.collect] = {
			_func = var_9_18,
			_keyVal = var_9_19
		}
	end

	if Data.BaseCardTypes[var_9_0] == Data.CardType.magic then
		local var_9_20, var_9_21 = var_9_5:getFilterMagicOptionFunc()

		if var_9_20 then
			var_9_3[var_0_4.FilterType.option] = {
				_func = var_9_20,
				_keyVal = var_9_21
			}
		end
	elseif Data.BaseCardTypes[var_9_0] == Data.CardType.trap then
		local var_9_22, var_9_23 = var_9_5:getFilterTrapOptionFunc()

		if var_9_22 then
			var_9_3[var_0_4.FilterType.option] = {
				_func = var_9_22,
				_keyVal = var_9_23
			}
		end
	elseif Data.BaseCardTypes[var_9_0] == Data.CardType.rare then
		local var_9_24, var_9_25 = var_9_5:getFilterRareOptionFunc()

		if var_9_24 then
			var_9_3[var_0_4.FilterType.option] = {
				_func = var_9_24,
				_keyVal = var_9_25
			}
		end
	end

	local var_9_26, var_9_27 = var_9_5:getFilterSearchFunc()

	if var_9_26 then
		var_9_3[var_0_4.FilterType.search] = {
			_func = var_9_26,
			_keyVal = var_9_27
		}
	end

	local var_9_28 = arg_9_0._cardList

	var_9_28._troopIndex = arg_9_0._curTroopIndex

	var_9_28:init(Data.BaseCardTypes[var_9_2], var_9_1, var_9_4, var_9_3)

	var_9_28._pageLeft._pos = cc.p(16, lc.ch(var_9_28))
	var_9_28._pageRight._pos = cc.p(lc.w(var_9_28) - 16, lc.ch(var_9_28))

	var_9_28:refresh(arg_9_1)
end

function var_0_2.onCardSelected(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._cardList:getThumbnail(arg_10_1)

	if cc.pGetDistance(var_10_0:getTouchEndPosition(), var_10_0:getTouchBeganPosition()) < 20 then
		require("EffectForm").create(arg_10_1):show()
	end
end

function var_0_2.onEnter(arg_11_0)
	var_0_2.super.onEnter(arg_11_0)
	ClientView:getResourceUI():setMode(Data.PropsId.effect_skin_crystal)

	arg_11_0._listeners = {}
	arg_11_0._listeners[#arg_11_0._listeners + 1] = lc.addEventListener(Data.Event.skin_dirty, function()
		arg_11_0:updateCardList()
	end)

	arg_11_0:updateCardList()
end

function var_0_2.onExit(arg_13_0)
	var_0_2.super.onExit(arg_13_0)

	for iter_13_0 = 1, #arg_13_0._listeners do
		lc.Dispatcher:removeEventListener(arg_13_0._listeners[iter_13_0])
	end
end

function var_0_2.onCleanup(arg_14_0)
	var_0_2.super.onCleanup(arg_14_0)
end

function var_0_2.syncData(arg_15_0)
	var_0_2.super.syncData(arg_15_0)
end

return var_0_2
