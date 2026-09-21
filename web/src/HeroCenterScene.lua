local var_0_0 = require("BaseUIScene")
local var_0_1 = class("HeroCenterScene", var_0_0)
local var_0_2 = require("FilterWidget")
local var_0_3 = require("CardThumbnail")
local var_0_4 = require("CardList")
local var_0_5 = require("CardInfoPanel")
local var_0_6 = cc.rect(34, 40, 2, 2)
local var_0_7 = cc.rect(20, 54, 2, 2)
local var_0_8 = 0.5
local var_0_9 = 0.45
local var_0_10 = 8
local var_0_11 = cc.c4b(235, 218, 175, 255)
local var_0_12 = {
	vertical = 2,
	horizontal = 1,
	none = 0
}

var_0_1.TouchStatus = {
	press = 1,
	tap = 3,
	move = 2
}
var_0_1.MODE_UNTROOP = 1
var_0_1.MODE_TROOP = 2
var_0_1.EXPEDITION_BASE_LEVEL = 1

local var_0_13 = 244
local var_0_14 = 80

function var_0_1.create(arg_1_0)
	return lc.createScene(var_0_1, arg_1_0)
end

function var_0_1.init(arg_2_0, arg_2_1)
	if not var_0_1.super.init(arg_2_0, ClientData.SceneId.manage_troop, STR.SID_FIXITY_NAME_1006, var_0_0.STYLE_TAB, true) then
		return false
	end

	arg_2_0._curTroopIndex = arg_2_1 or P._curTroopIndex

	arg_2_0:createFrame()
	arg_2_0:createTroopArea()
	arg_2_0:createCardList()
	ClientView.addVerticalTabButtons(arg_2_0, {
		Str(STR.MONSTER),
		Str(STR.MAGIC),
		Str(STR.TRAP),
		Str(STR.RARE) .. Str(STR.MONSTER)
	}, lc.top(arg_2_0._frame) - 60, lc.left(arg_2_0._frame) - 124, 450, 100)

	local var_2_0 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		local var_3_0 = require("RecommendTroopListForm").create()
		local var_3_1 = var_3_0.hide

		function var_3_0.hide(arg_4_0)
			var_3_1(arg_4_0)
			arg_2_0:updateTroopList()
		end

		arg_2_0:releaseToopList()
		var_3_0:show()
	end, ClientView.CRECT_BUTTON_S, 180, 56)

	var_2_0:addLabel(Str(STR.RECOMMEND_TROOP))

	lc.addChildToPos(arg_2_0, var_2_0, cc.p(ClientView.SCR_W - 24 - lc.cw(var_2_0) - ClientView.SCR_EDGE, lc.top(arg_2_0._troopArea) + 10 + lc.ch(var_2_0)))
	var_2_0:setVisible(Data.isNormalTroop(arg_2_0._curTroopIndex))
	arg_2_0:syncData(true)
	arg_2_0:updateButtonFlags()

	return true
end

function var_0_1.onEnter(arg_5_0)
	var_0_1.super.onEnter(arg_5_0)

	arg_5_0._listeners = {}

	local var_5_0 = lc.addEventListener(Data.Event.card_dirty, function(arg_6_0)
		arg_5_0:updateBottomValueAreas()
	end)

	table.insert(arg_5_0._listeners, var_5_0)
	table.insert(arg_5_0._listeners, lc.addEventListener(Data.Event.group_cards_dirty, function()
		arg_5_0:onSelectTroop(arg_5_0._curTroopIndex, true)
	end))
	table.insert(arg_5_0._listeners, lc.addEventListener(Data.Event.union_group_dirty, function()
		if Data.isUnionBattleTroop(arg_5_0._curTroopIndex) then
			local var_8_0 = P._playerUnion:getMyGroup()

			if var_8_0 and var_8_0._gameStarted then
				ClientView.popScene(true)
			end
		end
	end))

	local var_5_1 = lc.addEventListener(Data.Event.card_flag_dirty, function(arg_9_0)
		arg_5_0:onCardFlagDirty(arg_9_0)
	end)

	table.insert(arg_5_0._listeners, var_5_1)

	if arg_5_0._needUpdateTroopList then
		arg_5_0:updateTroopList()

		arg_5_0._needUpdateTroopList = nil
	end

	if Data.isUnionBattleTroop(arg_5_0._curTroopIndex) then
		local var_5_2 = P._playerUnion:getMyGroup()

		if var_5_2 and var_5_2._gameStarted then
			ClientView.popScene(true)
		end
	end

	ClientData.addMsgListener(arg_5_0, function(arg_10_0)
		return arg_5_0:onMsg(arg_10_0)
	end, 0)
end

function var_0_1.onExit(arg_11_0)
	var_0_1.super.onExit(arg_11_0)

	for iter_11_0 = 1, #arg_11_0._listeners do
		lc.Dispatcher:removeEventListener(arg_11_0._listeners[iter_11_0])
	end

	arg_11_0:releaseToopList()

	arg_11_0._needUpdateTroopList = true

	ClientData.removeMsgListener(arg_11_0)
end

function var_0_1.onCleanup(arg_12_0)
	var_0_1.super.onCleanup(arg_12_0)
	arg_12_0:releaseToopList()

	var_0_5._operateType = var_0_5.OperateType.na
end

function var_0_1.syncData(arg_13_0, arg_13_1)
	var_0_1.super.syncData(arg_13_0)

	ClientData._cloneTroops = {}

	if Data.isUnionBattleTroop(arg_13_0._curTroopIndex) and not arg_13_1 then
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
		ClientData.sendGetGroupCards()
	else
		arg_13_0:onSelectTroop(arg_13_0._curTroopIndex, true)
	end

	if Data.isUnionBattleTroop(arg_13_0._curTroopIndex) then
		local var_13_0 = P._playerUnion:getMyGroup()

		if var_13_0 and var_13_0._gameStarted then
			ClientView.popScene(true)
		end
	end
end

function var_0_1.createFrame(arg_14_0)
	local var_14_0 = ClientView.createFrameBox(cc.size(lc.w(arg_14_0) - (16 + ClientView.FRAME_TAB_WIDTH + ClientView.SCR_EDGE) * 2, lc.h(arg_14_0) - 250))

	lc.addChildToPos(arg_14_0, var_14_0, cc.p(lc.w(arg_14_0) / 2, lc.bottom(arg_14_0._titleArea) - lc.h(var_14_0) / 2 + 10))

	arg_14_0._frame = var_14_0
end

function var_0_1.createTroopArea(arg_15_0)
	local var_15_0 = lc.createSprite({
		_name = "img_troop_bg_1",
		_size = cc.size(lc.w(arg_15_0) - ClientView.SCR_EDGE * 2, 212),
		_crect = cc.rect(47, 0, 1, 212)
	})
	local var_15_1 = lc.createNode(cc.size(lc.w(var_15_0), lc.h(var_15_0)))

	lc.addChildToPos(arg_15_0, var_15_1, cc.p(lc.w(arg_15_0) / 2, lc.h(var_15_1) / 2))

	arg_15_0._troopArea = var_15_1

	local var_15_2 = lc.createSprite({
		_name = "img_troop_bg_2",
		_size = cc.size(181, 210),
		_crect = cc.rect(90, 62, 1, 1)
	})

	lc.addChildToPos(var_15_1, var_15_2, cc.p(lc.w(var_15_1) - lc.cw(var_15_2) - 24, lc.ch(var_15_2) - 4), 1)
	lc.addChildToCenter(var_15_1, var_15_0)

	-- "img_troop_main" and "img_troop_rare" have their captions painted
	-- into the artwork, so the heading is drawn as text instead and the
	-- two setSpriteFrame calls below became setString.
	local var_15_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, "Bộ bài chính")

	var_15_3:setColor(ClientView.COLOR_TEXT_INGOT)

	lc.addChildToPos(var_15_2, var_15_3, cc.p(lc.cw(var_15_2), lc.h(var_15_2) - lc.ch(var_15_3) - 16))

	arg_15_0._troopTitle = var_15_3

	local var_15_4 = lc.createSprite({
		_name = "img_com_bg_26",
		_crect = ClientView.CRECT_COM_BG26,
		_size = cc.size(110, 28)
	})

	lc.addChildToPos(var_15_2, var_15_4, cc.p(lc.cw(var_15_2) + 4, lc.bottom(var_15_3) - lc.ch(var_15_4) - 16))

	local var_15_5 = lc.createSprite("img_icon_cardnum")

	var_15_5:setScale(0.8)
	lc.addChildToPos(var_15_4, var_15_5, cc.p(lc.cw(var_15_5) - 14, lc.ch(var_15_4) + 2))

	local var_15_6 = ClientView.createBMFont(ClientView.BMFont.huali_26, "1/1")

	lc.addChildToPos(var_15_4, var_15_6, cc.p(lc.cw(var_15_4) + 8, lc.h(var_15_4) / 2 + 2))

	arg_15_0._cardNumValue = var_15_6

	local var_15_7 = ClientView.createBMFont(ClientView.BMFont.huali_20, string.format(Str(STR.TROOP_TYPE_COUNT, true), 0, 0))

	var_15_7:setScale(0.8)
	lc.addChildToPos(var_15_2, var_15_7, cc.p(lc.x(var_15_4), lc.bottom(var_15_4) - lc.ch(var_15_7) - 4))

	arg_15_0._cardTypeNumLabel = var_15_7

	local var_15_8 = ClientView.createShaderButton("img_icon_clear", function(arg_16_0)
		require("Dialog").showDialog(Str(STR.SURE_TO_CLEAR_TROOP), function()
			arg_15_0:clearTroop()
		end)
	end)

	lc.addChildToPos(var_15_2, var_15_8, cc.p(lc.cw(var_15_2) + 60, lc.ch(var_15_8) + 18))

	local var_15_9 = lc.List.createH(cc.size(lc.w(var_15_1) - lc.w(var_15_2) - 40, lc.h(var_15_1) - 6), 20, 10)

	lc.addChildToPos(var_15_1, var_15_9, cc.p(24, 0))

	arg_15_0._troopList = var_15_9

	if Data.isNormalTroop(arg_15_0._curTroopIndex) or Data.isUnionBattleTroop(arg_15_0._curTroopIndex) or Data.isDarkTroop(arg_15_0._curTroopIndex) or Data.isRoomDarkTroop(arg_15_0._curTroopIndex) then
		local var_15_10 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_18_0)
			arg_15_0:popSelectTroop()
		end, ClientView.CRECT_BUTTON_S, 110, 44)

		lc.addChildToPos(var_15_2, var_15_10, cc.p(lc.cw(var_15_2) - 10, lc.y(var_15_8)))
		var_15_10:setScale(0.6)
		var_15_10:addLabel(string.format("%s%d", Str(STR.TROOP), P._curTroopIndex))
		var_15_10._label:setScale(0.8)

		arg_15_0._btnTroop = var_15_10
	else
		local var_15_11

		if var_15_11 then
			local var_15_12 = ClientView.createBoldRichText(var_15_11, {
				_normalClr = ClientView.COLOR_LABEL_LIGHT,
				_boldClr = ClientView.COLOR_TEXT_GREEN,
				_fontSize = ClientView.FontSize.S1
			})

			lc.addChildToPos(var_15_2, var_15_12, cc.p(12 + lc.w(var_15_12) / 2, lc.h(var_15_2) / 2))
		end
	end
end

function var_0_1.createCardList(arg_19_0)
	arg_19_0._cardList = require("CardList").create(cc.size(lc.w(arg_19_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 90, lc.h(arg_19_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), var_0_8, false)

	arg_19_0._cardList:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_19_0._frame, arg_19_0._cardList, cc.p(lc.w(arg_19_0._frame) / 2, lc.h(arg_19_0._frame) / 2))
	arg_19_0._cardList:registerCardSelectedHandler(function(arg_20_0, arg_20_1)
		arg_19_0:onCardSelected(arg_20_0, arg_20_1)
	end)
	arg_19_0._cardList:registerTouchThumbnail(function(arg_21_0, arg_21_1)
		arg_19_0:onCardTouch(arg_21_0, arg_21_1)
	end)

	if Data.isUnionBattleTroop(arg_19_0._curTroopIndex) then
		arg_19_0._cardList:setMode(var_0_4.ModeType.union_battle_troop)
	elseif Data.isDarkTroop(arg_19_0._curTroopIndex) then
		arg_19_0._cardList:setMode(var_0_4.ModeType.dark_troop)
	elseif Data.isRoomDarkTroop(arg_19_0._curTroopIndex) then
		arg_19_0._cardList:setMode(var_0_4.ModeType.room_dark_troop)
	else
		arg_19_0._cardList:setMode(var_0_4.ModeType.troop)
	end

	local var_19_0 = (lc.w(arg_19_0._frame) - lc.w(arg_19_0._cardList)) / 2 + 16

	arg_19_0._cardList._pageLeft._pos = cc.p(-var_19_0, 80)
	arg_19_0._cardList._pageRight._pos = cc.p(lc.w(arg_19_0._cardList) + var_19_0, 80)

	local var_19_1 = var_19_0 + 32
	local var_19_2 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_19_0._frame, var_19_2, cc.p(-lc.w(var_19_2) / 2 + 12, 40), -1)
	arg_19_0._cardList._pageLabel:setPosition(-var_19_1, 12)

	arg_19_0._filterWidgets = {}

	local var_19_3 = {
		var_0_2.ModeType.monster,
		var_0_2.ModeType.magic,
		var_0_2.ModeType.trap,
		var_0_2.ModeType.rare
	}

	for iter_19_0 = 1, #var_19_3 do
		local var_19_4 = var_0_2.create(var_19_3[iter_19_0], lc.h(arg_19_0._frame) - 80)

		var_19_4:resetAllFilter()
		var_19_4:registerSortFilterHandler(function()
			arg_19_0:updateCardList(true)
		end)
		var_19_4:setVisible(iter_19_0 == 1)
		lc.addChildToPos(arg_19_0._frame, var_19_4, cc.p(lc.w(arg_19_0._frame) + ClientView.FRAME_TAB_WIDTH - lc.w(var_19_4) / 2 + 2, lc.h(var_19_4) / 2))

		arg_19_0._filterWidgets[iter_19_0] = var_19_4
	end
end

function var_0_1.onSelectTroop(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0._curTroopIndex == arg_23_1 and not arg_23_2 then
		return
	end

	arg_23_0._curTroopIndex = arg_23_1

	if ClientData._cloneTroops[arg_23_0._curTroopIndex] == nil then
		local var_23_0 = P._playerCard:getTroop(arg_23_0._curTroopIndex, true)

		ClientData._cloneTroops[arg_23_0._curTroopIndex] = var_23_0
	end

	arg_23_0._lastTabIndex = nil

	arg_23_0:showTab(arg_23_0._tabArea._focusTabIndex and arg_23_0._tabArea._focusTabIndex or 1)
end

function var_0_1.releaseToopList(arg_24_0)
	local var_24_0 = (arg_24_0._troopItems and #arg_24_0._troopItems > 0 and arg_24_0._troopItems) or arg_24_0._troopList:getItems()

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		local var_item = iter_24_1._item or (iter_24_1.getChildren and #iter_24_1:getChildren() > 0 and iter_24_1:getChildren()[1])
		if var_item then
			var_0_3.releaseToPool(var_item)
		end
		pcall(function() iter_24_1:release() end)
	end

	arg_24_0._troopItems = nil
	arg_24_0._troopList:removeAllItems()
end

function var_0_1.remainItemFromList(arg_25_0, arg_25_1)
	local var_25_0 = {}
	local var_25_1 = (arg_25_0._troopItems and #arg_25_0._troopItems > 0 and arg_25_0._troopItems) or arg_25_0._troopList:getItems()

	for iter_25_0 = #var_25_1, 1, -1 do
		local var_25_2 = var_25_1[iter_25_0]
		local var_25_3 = false

		if var_25_2 and var_25_2._card then
			for iter_25_1, iter_25_2 in ipairs(arg_25_1) do
				if var_25_2._card._infoId == iter_25_2._infoId then
					var_25_3 = true

					break
				end
			end
		end

		if var_25_3 then
			table.insert(var_25_0, var_25_2)
			arg_25_0._troopList:removeItem(iter_25_0 - 1, false)
			if arg_25_0._troopItems then
				table.remove(arg_25_0._troopItems, iter_25_0)
			end
		end
	end

	return var_25_0
end

function var_0_1.updateTroopList(arg_26_0)
	local var_26_0 = ClientData._cloneTroops[arg_26_0._curTroopIndex]
	local var_26_1 = {}
	local var_26_2 = arg_26_0._tabArea._focusTabIndex == Data.CardType.rare

	arg_26_0:releaseToopList()

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_3 = Data.getType(iter_26_1._infoId)

		if var_26_2 and var_26_3 == Data.CardType.rare or not var_26_2 and var_26_3 ~= Data.CardType.rare then
			local var_26_4

			if not var_26_4 then
				var_26_4 = ccui.Layout:create()

				var_26_4:retain()

				local var_26_5 = var_0_3.createFromPool(iter_26_1._infoId, var_0_9, P._playerCard:getSkinId(iter_26_1._infoId))

				var_26_5._countArea:update(true, iter_26_1._num)
				var_26_4:setContentSize(var_26_5._thumbnail:getContentSize())
				var_26_4:setAnchorPoint(cc.p(0.5, 0.5))
				lc.addChildToPos(var_26_4, var_26_5, cc.p(lc.cw(var_26_4), lc.ch(var_26_4) + 10))
				var_26_5._thumbnail:setTouchEnabled(true)
				var_26_5._thumbnail:addTouchEventListener(function(arg_27_0, arg_27_1)
					arg_26_0:onTroopTouchThumbnail(arg_27_0, arg_27_1)
				end)

				var_26_4._item = var_26_5
			else
				var_26_4._item._countArea:update(true, iter_26_1._num)
			end

			table.insert(var_26_1, var_26_4)

			var_26_4._card = iter_26_1
		end
	end

	local function var_26_6(arg_28_0, arg_28_1)
		local var_28_0 = arg_28_0._card._infoId
		local var_28_1 = arg_28_1._card._infoId
		local var_28_2 = Data.removeAdditional(var_28_0)
		local var_28_3 = Data.removeAdditional(var_28_1)

		if var_28_2 == var_28_3 then
			return var_28_1 < var_28_0
		else
			return var_28_2 < var_28_3
		end
	end

	table.sort(var_26_1, var_26_6)

	arg_26_0._troopItems = var_26_1

	for iter_26_2, iter_26_3 in ipairs(var_26_1) do
		arg_26_0._troopList:pushBackCustomItem(iter_26_3)
	end
end

function var_0_1.showTab(arg_29_0, arg_29_1)
	arg_29_0._tabArea:showTab(arg_29_1)

	for iter_29_0 = 1, #arg_29_0._filterWidgets do
		arg_29_0._filterWidgets[iter_29_0]:setVisible(arg_29_0._tabArea._focusTabIndex == iter_29_0)
	end

	arg_29_0:updateCardList(true)

	if arg_29_0._lastTabIndex == nil or arg_29_0._lastTabIndex == Data.CardType.rare and arg_29_0._tabArea._focusTabIndex ~= Data.CardType.rare or arg_29_0._lastTabIndex ~= Data.CardType.rare and arg_29_0._tabArea._focusTabIndex == Data.CardType.rare then
		arg_29_0:updateTroopList()
	end

	arg_29_0:updateBottomValueAreas()

	arg_29_0._lastTabIndex = arg_29_1

	local var_29_0 = GuideManager.getCurStepName()

	if string.find(var_29_0, "show tab") then
		GuideManager.finishStepLater()
	end
end

function var_0_1.updateCardList(arg_30_0, arg_30_1)
	if ClientData._cloneTroops[arg_30_0._curTroopIndex] == nil then
		local var_30_0 = P._playerCard:getTroop(arg_30_0._curTroopIndex, true)

		ClientData._cloneTroops[arg_30_0._curTroopIndex] = var_30_0
	end

	local var_30_1 = arg_30_0._tabArea._focusTabIndex
	local var_30_2 = {}
	local var_30_3 = {}
	local var_30_4
	local var_30_5 = arg_30_0._filterWidgets[var_30_1]
	local var_30_6, var_30_7 = var_30_5:getSortFunc()

	if var_30_6 then
		var_30_4 = {
			_func = var_30_6,
			_isReverse = not var_30_7
		}
	end

	if Data.BaseCardTypes[var_30_1] == Data.CardType.monster or Data.BaseCardTypes[var_30_1] == Data.CardType.rare then
		local var_30_8, var_30_9 = var_30_5:getFilterNatureFunc()

		if var_30_8 then
			var_30_3[var_0_4.FilterType.country] = {
				_func = var_30_8,
				_keyVal = var_30_9
			}
		end

		local var_30_10, var_30_11 = var_30_5:getFilterCategoryFunc()

		if var_30_10 then
			var_30_3[var_0_4.FilterType.category] = {
				_func = var_30_10,
				_keyVal = var_30_11
			}
		end

		local var_30_12, var_30_13 = var_30_5:getFilterLevelFunc()

		if var_30_12 then
			var_30_3[var_0_4.FilterType.cost] = {
				_func = var_30_12,
				_keyVal = var_30_13
			}
		end

		local var_30_14, var_30_15 = var_30_5:getFilterMonsterOptionFunc()

		if var_30_14 then
			var_30_3[var_0_4.FilterType.option] = {
				_func = var_30_14,
				_keyVal = var_30_15
			}
		end
	end

	local var_30_16, var_30_17 = var_30_5:getFilterQualityFunc()

	if var_30_16 then
		var_30_3[var_0_4.FilterType.quality] = {
			_func = var_30_16,
			_keyVal = var_30_17
		}
	end

	local var_30_18, var_30_19 = var_30_5:getFilterCollectFunc()

	if var_30_18 then
		var_30_3[var_0_4.FilterType.collect] = {
			_func = var_30_18,
			_keyVal = var_30_19
		}
	end

	if Data.BaseCardTypes[var_30_1] == Data.CardType.magic then
		local var_30_20, var_30_21 = var_30_5:getFilterMagicOptionFunc()

		if var_30_20 then
			var_30_3[var_0_4.FilterType.option] = {
				_func = var_30_20,
				_keyVal = var_30_21
			}
		end
	elseif Data.BaseCardTypes[var_30_1] == Data.CardType.trap then
		local var_30_22, var_30_23 = var_30_5:getFilterTrapOptionFunc()

		if var_30_22 then
			var_30_3[var_0_4.FilterType.option] = {
				_func = var_30_22,
				_keyVal = var_30_23
			}
		end
	elseif Data.BaseCardTypes[var_30_1] == Data.CardType.rare then
		local var_30_24, var_30_25 = var_30_5:getFilterRareOptionFunc()

		if var_30_24 then
			var_30_3[var_0_4.FilterType.option] = {
				_func = var_30_24,
				_keyVal = var_30_25
			}
		end
	end

	local var_30_26, var_30_27 = var_30_5:getFilterSearchFunc()

	if var_30_26 then
		var_30_3[var_0_4.FilterType.search] = {
			_func = var_30_26,
			_keyVal = var_30_27
		}
	end

	local var_30_28 = arg_30_0._cardList

	var_30_28._troopIndex = arg_30_0._curTroopIndex

	var_30_28:init(Data.BaseCardTypes[var_30_1], var_30_2, var_30_4, var_30_3)

	var_30_28._pageLeft._pos = cc.p(16, lc.ch(var_30_28))
	var_30_28._pageRight._pos = cc.p(lc.w(var_30_28) - 16, lc.ch(var_30_28))

	var_30_28:refresh(arg_30_1)
end

function var_0_1.popSelectTroop(arg_31_0)
	local var_31_0 = {}

	if Data.isUnionBattleTroop(arg_31_0._curTroopIndex) then
		local var_31_1 = Data.TroopIndex.union_battle1 + Data.GROUP_NUM - 1

		for iter_31_0 = Data.TroopIndex.union_battle1, var_31_1 do
			local var_31_2 = {
				_str = string.format("%s %d", Str(STR.UNION_TROOP), iter_31_0 - Data.TroopIndex.union_battle1 + 1)
			}

			var_31_2._hideRemark = true
			var_31_2._hideExchange = true

			function var_31_2._handler(arg_32_0)
				if arg_32_0 == 1 then
					arg_31_0:onSelectTroop(iter_31_0, false)
				elseif arg_32_0 == 2 then
					-- block empty
				end
			end

			table.insert(var_31_0, var_31_2)
		end
	elseif Data.isDarkTroop(arg_31_0._curTroopIndex) then
		local var_31_3 = Data.TroopIndex.dark_battle3

		for iter_31_1 = Data.TroopIndex.dark_battle1, var_31_3 do
			local var_31_4 = {
				_str = string.format("%s %d", Str(STR.DARK_TROOP), iter_31_1 - Data.TroopIndex.dark_battle1 + 1)
			}

			var_31_4._hideRemark = true
			var_31_4._hideExchange = iter_31_1 == arg_31_0._curTroopIndex

			function var_31_4._handler(arg_33_0)
				if arg_33_0 == 1 then
					arg_31_0:onSelectTroop(iter_31_1, false)
				elseif arg_33_0 == 2 then
					-- block empty
				elseif arg_33_0 == 4 then
					arg_31_0:exchangeTroop(iter_31_1)
				else
					local var_33_0 = require("InputForm")

					var_33_0.create(var_33_0.Type.TROOP_REMARK, iter_31_1, function()
						arg_31_0:popSelectTroop()
					end):show()
				end
			end

			table.insert(var_31_0, var_31_4)
		end
	elseif Data.isRoomDarkTroop(arg_31_0._curTroopIndex) then
		local var_31_5 = Data.TroopIndex.room_dark_battle3

		for iter_31_2 = Data.TroopIndex.room_dark_battle1, var_31_5 do
			local var_31_6 = {
				_str = string.format("%s %d", Str(STR.DARK_TROOP), iter_31_2 - Data.TroopIndex.room_dark_battle1 + 1)
			}

			var_31_6._hideRemark = true
			var_31_6._hideExchange = iter_31_2 == arg_31_0._curTroopIndex

			function var_31_6._handler(arg_35_0)
				if arg_35_0 == 1 then
					arg_31_0:onSelectTroop(iter_31_2, false)
				elseif arg_35_0 == 2 then
					-- block empty
				elseif arg_35_0 == 4 then
					arg_31_0:exchangeTroop(iter_31_2)
				else
					local var_35_0 = require("InputForm")

					var_35_0.create(var_35_0.Type.TROOP_REMARK, iter_31_2, function()
						arg_31_0:popSelectTroop()
					end):show()
				end
			end

			table.insert(var_31_0, var_31_6)
		end
	else
		local var_31_7 = P:getMaxTroopCount()
		local var_31_8 = var_31_7

		if P._playerCard:getExtraTroopCount() < P:getCharacterUnlockCount() then
			var_31_8 = var_31_8 + 1
		end

		for iter_31_3 = 1, var_31_8 do
			local var_31_9 = {
				_troopIndex = iter_31_3
			}

			if var_31_7 < iter_31_3 then
				var_31_9._str = Str(STR.UNLOCK_TROOP)
				var_31_9._hideRemark = true
				var_31_9._hideExchange = true

				function var_31_9._handler()
					require("Dialog").showDialog(string.format(Str(STR.CONFIRM_UNLOCK_TROOP), Data.TROOP_UNLOCK_INGOT), function()
						if P:getItemCount(Data.ResType.ingot) < Data.TROOP_UNLOCK_INGOT then
							ToastManager.push(Str(STR.NOT_ENOUGH_INGOT))
						else
							P._playerCard:unlockTroop()
							ToastManager.push(Str(STR.UNLOCK) .. Str(STR.SUCCESS))
						end
					end)
				end
			else
				var_31_9._str = string.format("%s %d", Str(STR.TROOP), iter_31_3)
				var_31_9._isDef = false
				var_31_9._hideRemark = false
				var_31_9._remark = P._troopRemarks and P._troopRemarks[iter_31_3]
				var_31_9._hideExchange = true

				function var_31_9._handler(arg_39_0)
					if arg_39_0 == 1 then
						arg_31_0:onSelectTroop(iter_31_3, false)
					elseif arg_39_0 == 2 then
						-- block empty
					else
						local var_39_0 = require("InputForm")

						var_39_0.create(var_39_0.Type.TROOP_REMARK, iter_31_3, function()
							arg_31_0:popSelectTroop()
						end):show()
					end
				end
			end

			table.insert(var_31_0, var_31_9)
		end
	end

	local var_31_10 = arg_31_0._btnTroop
	local var_31_11 = require("TopMostPanel").TroopList.create()

	if var_31_11 then
		local var_31_12 = lc.convertPos(cc.p(lc.cw(var_31_10), lc.ch(var_31_10)), var_31_10)

		var_31_11:setButtonDefs(var_31_0)
		var_31_11:setPosition(var_31_12.x - lc.w(var_31_11) / 2 + 66, var_31_12.y + lc.h(var_31_11) / 2)
		var_31_11:linkNode(arg_31_0._btnTroop)
		var_31_11:show()
	end
end

function var_0_1.clearTroop(arg_41_0)
	ClientData._cloneTroops[arg_41_0._curTroopIndex] = {}
	ClientData._cloneTroops[arg_41_0._curTroopIndex]._isDirty = true

	if ClientData.saveTroops() then
		arg_41_0:updateBottomValueAreas()
	end

	arg_41_0:updateCardList()
	arg_41_0:updateTroopList()
end

function var_0_1.exchangeTroop(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1
	local var_42_1 = arg_42_0._curTroopIndex
	local var_42_2 = ClientData._cloneTroops[arg_42_1] or P._playerCard:getTroop(arg_42_1, true)
	local var_42_3 = ClientData._cloneTroops[var_42_1] or P._playerCard:getTroop(var_42_1, true)

	ClientData._cloneTroops[var_42_0] = var_42_3
	ClientData._cloneTroops[var_42_0]._isDirty = true
	ClientData._cloneTroops[var_42_1] = var_42_2
	ClientData._cloneTroops[var_42_1]._isDirty = true

	if ClientData.saveTroops() then
		arg_42_0:updateBottomValueAreas()
	end

	arg_42_0:updateCardList()
	arg_42_0:updateTroopList()
end

function var_0_1.updateBottomValueAreas(arg_43_0)
	local var_43_0 = arg_43_0._tabArea._focusTabIndex == Data.CardType.rare

	if var_43_0 then
		arg_43_0._cardNumValue:setString(string.format("%d/%d", P._playerCard:getTroopCardCountByType(Data.CardType.rare, arg_43_0._curTroopIndex, true), Data.MAX_RARE_TROOP_CARD_COUNT))
	elseif Data.isUnionBattleTroop(arg_43_0._curTroopIndex) then
		arg_43_0._cardNumValue:setString(string.format("%d/%d", P._playerCard:getTroopCardCountByType(nil, arg_43_0._curTroopIndex, true), Data.MAX_UNION_TROOP_CARD_COUNT))
	elseif Data.isNormalTroop(arg_43_0._curTroopIndex) then
		arg_43_0._cardNumValue:setString(string.format("%d/%d", P._playerCard:getTroopCardCountByType(nil, arg_43_0._curTroopIndex, true), Data.MAX_TROOP_CARD_COUNT))
	else
		arg_43_0._cardNumValue:setString(string.format("%d/%d", P._playerCard:getTroopCardCountByType(nil, arg_43_0._curTroopIndex, true), Data.MAX_TROOP_CARD_COUNT_2))
	end

	if var_43_0 then
		arg_43_0._troopTitle:setString("Bộ bài hiếm")
		arg_43_0._cardTypeNumLabel:setString(string.format(Str(STR.TROOP_RARE_COUNT, true), P._playerCard:getTroopCardCountByType(Data.CardType.rare, arg_43_0._curTroopIndex, true)))
	else
		arg_43_0._troopTitle:setString("Bộ bài chính")
		arg_43_0._cardTypeNumLabel:setString(string.format(Str(STR.TROOP_TYPE_COUNT, true), P._playerCard:getTroopCardCountByType(Data.CardType.monster, arg_43_0._curTroopIndex, true), P._playerCard:getTroopCardCountByType(Data.CardType.magic, arg_43_0._curTroopIndex, true) + P._playerCard:getTroopCardCountByType(Data.CardType.trap, arg_43_0._curTroopIndex, true)))
	end

	if arg_43_0._btnTroop and arg_43_0._btnTroop._label then
		if Data.isUnionBattleTroop(arg_43_0._curTroopIndex) then
			arg_43_0._btnTroop._label:setString(Str(STR.UNION_TROOP) .. arg_43_0._curTroopIndex - Data.TroopIndex.union_battle1 + 1)
		elseif Data.isDarkTroop(arg_43_0._curTroopIndex) then
			arg_43_0._btnTroop._label:setString(Str(STR.DARK_TROOP) .. arg_43_0._curTroopIndex - Data.TroopIndex.dark_battle1 + 1)
		elseif Data.isRoomDarkTroop(arg_43_0._curTroopIndex) then
			arg_43_0._btnTroop._label:setString(Str(STR.DARK_TROOP) .. arg_43_0._curTroopIndex - Data.TroopIndex.room_dark_battle1 + 1)
		else
			local remark = P._troopRemarks and P._troopRemarks[arg_43_0._curTroopIndex]
			if remark and remark ~= "" then
				arg_43_0._btnTroop._label:setString(remark)
			else
				arg_43_0._btnTroop._label:setString(Str(STR.TROOP) .. " " .. arg_43_0._curTroopIndex)
			end
		end
	end
end

function var_0_1.onItemPress(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_0._movingSprite then
		return
	end

	arg_44_0._touchStatus = var_0_1.TouchStatus.press
	arg_44_0._movingDir = var_0_12.none
	arg_44_0._movingDeadCard = nil
	arg_44_0._isInList = false
end

function var_0_1.onItemMove(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_0._touchStatus == var_0_1.TouchStatus.tap then
		return
	end

	arg_45_0._touchStatus = var_0_1.TouchStatus.move

	local beganPos = arg_45_1:getTouchBeganPosition()
	local movePos = arg_45_1:getTouchMovePosition()
	local delta = cc.pSub(movePos, beganPos)
	local var_45_0 = math.abs(delta.x)
	local var_45_1 = math.abs(delta.y)

	if arg_45_0._movingSprite == nil then
		if arg_45_2 == var_0_1.MODE_UNTROOP then
			-- Moving upward (delta.y > 3) or predominantly upward gesture
			if delta.y > 3 or (var_45_1 > 4 and delta.y > 0) or (var_45_1 > 6 and var_45_1 >= var_45_0 * 0.3) then
				arg_45_0._movingDir = var_0_12.vertical
				if arg_45_0._troopList and arg_45_0._troopList.setIsScrollEnabled then
					arg_45_0._troopList:setIsScrollEnabled(false)
				end
			elseif var_45_0 > 16 and delta.y <= 0 then
				arg_45_0._movingDir = var_0_12.horizontal
			end
		else
			if var_45_0 > 8 or var_45_1 > 8 then
				arg_45_0._movingDir = var_45_1 <= var_45_0 and var_0_12.horizontal or var_0_12.vertical
			end
		end

		if arg_45_2 == var_0_1.MODE_TROOP or arg_45_0._movingDir == var_0_12.vertical then
			arg_45_0:createMovingSpriteAndMaskLayer(arg_45_1, arg_45_2)
			if arg_45_2 == var_0_1.MODE_UNTROOP and arg_45_0._troopList and arg_45_0._troopList.setIsScrollEnabled then
				arg_45_0._troopList:setIsScrollEnabled(false)
			end
		end
	end

	if arg_45_0._movingSprite then
		arg_45_0._movingSprite:setPosition(cc.pAdd(arg_45_0._movingSprite._srcPos, delta))
		arg_45_0:checkList(arg_45_2 == var_0_1.MODE_TROOP and arg_45_0._troopList or arg_45_0._cardList)
	end
end

function var_0_1.onItemTap(arg_46_0, arg_46_1, arg_46_2)
	arg_46_0._touchStatus = var_0_1.TouchStatus.tap

	local var_46_0 = arg_46_0._tabArea._focusTabIndex == Data.CardType.rare
	local var_46_1 = arg_46_1._infoId
	local var_46_2, var_46_3 = Data.getInfo(var_46_1)
	local var_46_4 = ClientData._cloneTroops[arg_46_0._curTroopIndex]
	local var_46_5

	if var_46_0 then
		var_46_5 = Data.MAX_RARE_TROOP_CARD_COUNT
	elseif Data.isUnionBattleTroop(arg_46_0._curTroopIndex) then
		var_46_5 = Data.MAX_UNION_TROOP_CARD_COUNT
	elseif Data.isNormalTroop(arg_46_0._curTroopIndex) then
		var_46_5 = Data.MAX_TROOP_CARD_COUNT
	else
		var_46_5 = Data.MAX_TROOP_CARD_COUNT_2
	end

	local var_46_6 = var_46_0 and P._playerCard:getTroopCardCountByType(Data.CardType.rare, arg_46_0._curTroopIndex, true) or P._playerCard:getTroopCardCountByType(nil, arg_46_0._curTroopIndex, true)
	local var_46_7 = arg_46_0:getTroopCardCount(var_46_4, var_46_1)

	if arg_46_2 == var_0_1.MODE_TROOP then
		if arg_46_0._movingSprite and (arg_46_0._isInList or lc.y(arg_46_0._movingSprite) < 240) then
			local var_46_8 = var_46_2._maxCount

			if Data.isUnionBattleTroop(arg_46_0._curTroopIndex) then
				var_46_8 = var_46_8 * Data.GROUP_NUM
			end

			if var_46_6 < var_46_5 and var_46_7 < var_46_8 then
				arg_46_0:onCardUnlocked(var_46_1)

				var_46_4._isDirty = true

				arg_46_0:addCardToTroop(var_46_4, var_46_1)
				arg_46_0:updateCardList(false)
				arg_46_0:updateTroopList()
				arg_46_0:updateBottomValueAreas()

				arg_46_0:playAction(var_46_1, true, arg_46_0._movingSprite._srcPos)

				local var_46_9 = GuideManager.getCurStepName()

				if string.sub(var_46_9, 1, 10) == "troop card" then
					GuideManager.finishStepLater(0.1)
				end
			elseif var_46_5 <= var_46_6 then
				ToastManager.push(Str(STR.FULL_IN_TROOP))
			elseif var_46_3 == Data.CardType.monster then
				ToastManager.push(string.format(Str(STR.SAME_CARD_IN_TROOP), Str(STR.MONSTER)))
			elseif var_46_3 == Data.CardType.magic then
				ToastManager.push(string.format(Str(STR.SAME_CARD_IN_TROOP), Str(STR.MAGIC)))
			elseif var_46_3 == Data.CardType.trap then
				ToastManager.push(string.format(Str(STR.SAME_CARD_IN_TROOP), Str(STR.TRAP)))
			end
		end
	elseif arg_46_2 == var_0_1.MODE_UNTROOP then
		local spriteY = arg_46_0._movingSprite and lc.y(arg_46_0._movingSprite) or 0
		local touchY = 0
		if arg_46_1 and arg_46_1.getTouchEndPosition then
			local ep = arg_46_1:getTouchEndPosition()
			if ep then touchY = ep.y end
		end
		local thresh = math.max(220, arg_46_0._separatorPos or 212)
		local isInAllCardArea = (spriteY >= thresh) or (touchY >= thresh) or (arg_46_0._isInList and spriteY >= 215)

		if arg_46_0._movingSprite and isInAllCardArea then
			var_46_4._isDirty = true

			local srcPos = arg_46_0._movingSprite._srcPos

			arg_46_0:removeCardFromTroop(var_46_4, var_46_1)
			arg_46_0:updateCardList(false)
			arg_46_0:updateTroopList()
			arg_46_0:updateBottomValueAreas()

			if srcPos then
				arg_46_0:playAction(var_46_1, false, srcPos)
			end
		end
	end

	if arg_46_0._maskLayer then
		arg_46_0:removeMaskLayer(arg_46_2)
	end

	if arg_46_0._movingSprite then
		arg_46_0._movingSprite:removeFromParent()

		arg_46_0._movingSprite = nil
	end
end

function var_0_1.onTroopTouchThumbnail(arg_47_0, arg_47_1, arg_47_2)
	arg_47_1:stopAllActions()

	if arg_47_2 == ccui.TouchEventType.began then
		arg_47_1:runAction(lc.scaleTo(0.1, 0.95))
		arg_47_0:onItemPress(arg_47_1, var_0_1.MODE_UNTROOP)
	elseif arg_47_2 == ccui.TouchEventType.ended or arg_47_2 == ccui.TouchEventType.canceled then
		arg_47_1:runAction(lc.scaleTo(0.08, 1))
		local wasMoving = (arg_47_0._movingSprite ~= nil) or (arg_47_0._movingDir == var_0_12.vertical)
		arg_47_0:onItemTap(arg_47_1, var_0_1.MODE_UNTROOP)

		if arg_47_0._troopList and arg_47_0._troopList.setIsScrollEnabled then
			arg_47_0._troopList:setIsScrollEnabled(true)
		end

		local dist = 0
		if arg_47_1.getTouchEndPosition and arg_47_1.getTouchBeganPosition then
			dist = cc.pGetDistance(arg_47_1:getTouchEndPosition(), arg_47_1:getTouchBeganPosition())
		end
		if arg_47_2 == ccui.TouchEventType.ended and not wasMoving and dist < 24 then
			arg_47_0:onTroopThumbnailSelected(arg_47_1)
		end
	elseif arg_47_2 == ccui.TouchEventType.moved then
		arg_47_0:onItemMove(arg_47_1, var_0_1.MODE_UNTROOP)
	end
end

function var_0_1.onTroopThumbnailSelected(arg_48_0, arg_48_1)
	if arg_48_1 ~= nil then
		local var_48_0 = var_0_5.create(arg_48_1._infoId, P._playerCard._levels[arg_48_1._infoId], var_0_5.OperateType.troop)
		local var_48_1 = {}
		local var_48_2 = 0
		local var_48_3 = (arg_48_0._troopItems and #arg_48_0._troopItems > 0 and arg_48_0._troopItems) or arg_48_0._troopList:getItems()

		for iter_48_0 = 1, #var_48_3 do
			local var_item = var_48_3[iter_48_0]._item or (var_48_3[iter_48_0].getChildren and #var_48_3[iter_48_0]:getChildren() > 0 and var_48_3[iter_48_0]:getChildren()[1])
			local var_48_4 = var_item and var_item._thumbnail

			if var_48_4 then
				var_48_1[#var_48_1 + 1] = {
					_infoId = var_48_4._infoId,
					_num = var_48_4._count
				}

				if arg_48_1 == var_48_4 then
					var_48_2 = iter_48_0
				end
			end
		end

		var_48_0:setCardList(var_48_1, var_48_2, Str(STR.CUR_TROOP))
		var_48_0:setCardCount(arg_48_1._count)
		var_48_0:show()
	end
end

function var_0_1.onCardTouch(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_2 == ccui.TouchEventType.began then
		arg_49_0:onItemPress(arg_49_1, var_0_1.MODE_TROOP)
	elseif arg_49_2 == ccui.TouchEventType.ended or arg_49_2 == ccui.TouchEventType.canceled then
		if arg_49_0._movingDeadCard then
			return
		end

		arg_49_0:onItemTap(arg_49_1, var_0_1.MODE_TROOP)
	elseif arg_49_2 == ccui.TouchEventType.moved then
		if arg_49_1._item._locked or arg_49_0._movingDeadCard then
			return
		end

		arg_49_0:onItemMove(arg_49_1, var_0_1.MODE_TROOP)
	end
end

function var_0_1.onCardSelected(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_0._cardList:getThumbnail(arg_50_1)

	if var_50_0 ~= nil then
		for iter_50_0 = 1, #lc._runningScene._scene:getChildren() do
			if lc._runningScene._scene:getChildren()[iter_50_0]._panelName == "CardInfoPanel" then
				return
			end
		end

		arg_50_0:onCardUnlocked(arg_50_1)

		local var_50_1 = var_0_5.OperateType.operate

		if Data.isUnionBattleTroop(arg_50_0._curTroopIndex) or Data.isDarkTroop(arg_50_0._curTroopIndex) or Data.isRoomDarkTroop(arg_50_0._curTroopIndex) then
			var_50_1 = var_0_5.OperateType.na
		end

		local var_50_2 = var_0_5.create(arg_50_1, var_50_0._level, var_50_1)

		if not GuideManager.isGuideEnabled() then
			local var_50_3 = (arg_50_0._cardList._curPage - 1) * arg_50_0._cardList._itemRow * arg_50_0._cardList._itemCol + arg_50_2

			var_50_2:setCardList(arg_50_0._cardList._cards, var_50_3, ClientData.getStrByCardType(Data.getType(var_50_0._infoId)) .. Str(STR.CARD_LIST))
		elseif GuideManager.getCurStepName() == "rare card" then
			GuideManager.finishStep()
		end

		var_50_2:show()

		if GuideManager.isGuideEnabled() then
			GuideManager.pauseGuide()
		end
	end
end

function var_0_1.onCardUnlocked(arg_51_0, arg_51_1)
	if P._playerCard:isUnlocked(arg_51_1) then
		P._playerCard:removeUnlocked(arg_51_1)
		ClientData.sendCardUnlockConfirmed(arg_51_1)
	end
end

function var_0_1.createMovingSpriteAndMaskLayer(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_2 == var_0_1.MODE_TROOP and arg_52_0._troopList or arg_52_0._cardList
	local var_52_1 = arg_52_2 == var_0_1.MODE_TROOP and arg_52_0._cardList or arg_52_0._troopList
	local var_52_2 = arg_52_1:convertToWorldSpace(cc.p(lc.w(arg_52_1) / 2, lc.h(arg_52_1) / 2))
	local var_52_3 = arg_52_0:convertToNodeSpace(var_52_2)
	local var_52_4 = arg_52_1._infoId
	local var_52_5 = var_0_3.create(var_52_4, var_0_8, P._playerCard:getSkinId(var_52_4))

	arg_52_0:addChild(var_52_5, ClientData.ZOrder.ui + 2)

	arg_52_0._movingSprite = var_52_5
	arg_52_0._movingSprite._srcPos = var_52_3
	arg_52_0._movingSprite._abc = 1

	arg_52_0._movingSprite:setPosition(cc.pAdd(var_52_3, cc.pSub(arg_52_1:getTouchMovePosition(), arg_52_1:getTouchBeganPosition())))

	if var_52_1 == arg_52_0._troopList or arg_52_2 == var_0_1.MODE_UNTROOP then
		if arg_52_0._troopList and arg_52_0._troopList.setIsScrollEnabled then
			arg_52_0._troopList:setIsScrollEnabled(false)
		end
	end

	local var_52_6 = var_52_0:convertToWorldSpace(cc.p(0, 0))
	local var_52_7 = arg_52_0:convertToNodeSpace(var_52_6)

	var_52_7.x = 0

	local var_52_8 = cc.rect(var_52_7.x, var_52_7.y, lc.w(arg_52_0), lc.h(var_52_0))

	arg_52_0._maskLayer = arg_52_0:createMaskLayer(var_52_8)

	arg_52_0:addChild(arg_52_0._maskLayer, ClientData.ZOrder.ui + 1)

	arg_52_0._separatorPos = arg_52_2 == var_0_1.MODE_UNTROOP and var_52_7.y or var_52_7.y + var_52_8.height
end

function var_0_1.createMaskLayer(arg_53_0, arg_53_1)
	local var_53_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 192), lc.w(arg_53_0), lc.h(arg_53_0))

	return ClientView.createClipNode(var_53_0, arg_53_1, true)
end

function var_0_1.removeMaskLayer(arg_54_0, arg_54_1)
	if arg_54_1 == var_0_1.MODE_TROOP then
		-- block empty
	else
		if arg_54_0._troopList and arg_54_0._troopList.setIsScrollEnabled then
			arg_54_0._troopList:setIsScrollEnabled(true)
		end
	end

	if arg_54_0._maskLayer then
		arg_54_0._maskLayer:removeFromParent(true)
		arg_54_0._maskLayer = nil
	end
end

function var_0_1.checkList(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_1 == arg_55_0._troopList
	local var_55_1

	var_55_1 = var_55_0 and 0.5 or 0

	local var_55_2 = arg_55_0._movingSprite

	if var_55_2 then
		if var_55_0 then
			arg_55_0._isInList = arg_55_0._separatorPos > lc.y(var_55_2)
		else
			local thresh = math.max(220, arg_55_0._separatorPos or 212)
			arg_55_0._isInList = lc.y(var_55_2) >= thresh
		end
	end
end

function var_0_1.checkUnlockModule(arg_56_0)
	local var_56_0 = P._level
	local var_56_1 = lc.readConfig(ClientData.ConfigKey.lock_level_herocenter, var_56_0)
	local var_56_2 = {}
	local var_56_3 = P:getMaxTroopCount(var_56_0)
	local var_56_4 = P:getMaxTroopCount(var_56_1)
	local var_56_5 = ""

	for iter_56_0 = var_56_4 + 1, var_56_3 do
		if var_56_5 ~= "" then
			var_56_5 = string.format("%s,%d", var_56_5, iter_56_0)
		else
			var_56_5 = string.format("%d", iter_56_0)
		end
	end

	if var_56_5 ~= "" then
		table.insert(var_56_2, #var_56_2 + 1, Str(STR.TROOP) .. var_56_5 .. Str(STR.UNLOCKED))
	end

	if #var_56_2 > 0 then
		ToastManager.pushArray(var_56_2)
		lc.writeConfig(ClientData.ConfigKey.lock_level_herocenter, var_56_0)
	end
end

function var_0_1.getTotalTroopCardCount(arg_57_0, arg_57_1)
	local var_57_0 = ClientData._cloneTroops[arg_57_1] or P._playerCard:getTroop(arg_57_1, true)
	local var_57_1 = 0

	for iter_57_0 = 1, #var_57_0 do
		var_57_1 = var_57_1 + var_57_0[iter_57_0]._num
	end

	return var_57_1
end

function var_0_1.hide(arg_58_0)
	local var_58_0, var_58_1 = P._playerCard:checkTroop(arg_58_0._curTroopIndex)

	if not var_58_0 then
		return require("Dialog").showDialog(var_58_1, function()
			if Data.isDarkTroop(arg_58_0._curTroopIndex) or Data.isRoomDarkTroop(arg_58_0._curTroopIndex) then
				P._playerRank:clearRank(SglMsgType_pb.PB_TYPE_RANK_POWER)
				arg_58_0:syncTroop()
				var_0_1.super.hide(arg_58_0)
			end
		end, true)
	end

	P._playerRank:clearRank(SglMsgType_pb.PB_TYPE_RANK_POWER)
	arg_58_0:syncTroop()
	var_0_1.super.hide(arg_58_0)
end

function var_0_1.onGuide(arg_60_0, arg_60_1)
	local var_60_0 = GuideManager.getCurStepName()

	if string.sub(var_60_0, 1, 10) == "troop card" then
		local var_60_1

		for iter_60_0 = 1, arg_60_0._cardList._itemRow do
			for iter_60_1 = 1, arg_60_0._cardList._itemCol do
				if not arg_60_0._cardList._items[iter_60_0][iter_60_1]._locked then
					var_60_1 = arg_60_0._cardList._items[iter_60_0][iter_60_1]

					break
				end
			end

			if var_60_1 ~= nil then
				break
			end
		end

		local var_60_2 = {}

		for iter_60_2 = 1, arg_60_0._cardList._itemRow do
			for iter_60_3 = 1, arg_60_0._cardList._itemCol do
				var_60_2[#var_60_2 + 1] = arg_60_0._cardList._items[iter_60_2][iter_60_3]._thumbnail
			end
		end

		local var_60_3 = arg_60_0:convertToNodeSpace(var_60_1:convertToWorldSpace(cc.p(lc.w(var_60_1) / 2, lc.h(var_60_1) / 2))).x
		local var_60_4 = arg_60_0:convertToNodeSpace(arg_60_0._troopList:convertToWorldSpace(cc.p(lc.w(arg_60_0._troopList) / 2, lc.h(arg_60_0._troopList) / 2))).y

		GuideManager.setOperateLayer(var_60_1._thumbnail, cc.p(var_60_3, var_60_4), var_60_2)
	elseif var_60_0 == "rare card" then
		local var_60_5 = arg_60_0._cardList._items[1][1]

		GuideManager.setOperateLayer(var_60_5._thumbnail)
	elseif var_60_0 == "show tab magic" then
		local var_60_6 = arg_60_0._tabArea._tabs[2]

		GuideManager.setOperateLayer(var_60_6)
	elseif var_60_0 == "show tab rare" then
		local var_60_7 = arg_60_0._tabArea._tabs[4]

		GuideManager.setOperateLayer(var_60_7)
	elseif var_60_0 == "leave manage troop" then
		GuideManager.setOperateLayer(arg_60_0._titleArea._btnBack)
	else
		return
	end

	arg_60_1:stopPropagation()
end

function var_0_1.addCardToTroop(arg_61_0, arg_61_1, arg_61_2)
	for iter_61_0 = 1, #arg_61_1 do
		local var_61_0 = arg_61_1[iter_61_0]

		if var_61_0._infoId == arg_61_2 then
			var_61_0._num = var_61_0._num + 1

			return
		end
	end

	arg_61_1[#arg_61_1 + 1] = {
		_num = 1,
		_infoId = arg_61_2
	}
end

function var_0_1.removeCardFromTroop(arg_62_0, arg_62_1, arg_62_2)
	for iter_62_0 = 1, #arg_62_1 do
		local var_62_0 = arg_62_1[iter_62_0]

		if tonumber(var_62_0._infoId) == tonumber(arg_62_2) then
			var_62_0._num = (tonumber(var_62_0._num) or 1) - 1

			if var_62_0._num <= 0 then
				table.remove(arg_62_1, iter_62_0)
			end

			break
		end
	end
end

function var_0_1.getTroopCardCount(arg_63_0, arg_63_1, arg_63_2)
	for iter_63_0 = 1, #arg_63_1 do
		local var_63_0 = arg_63_1[iter_63_0]

		if tonumber(var_63_0._infoId) == tonumber(arg_63_2) then
			return tonumber(var_63_0._num) or 0
		end
	end

	return 0
end

function var_0_1.getTroopItem(arg_64_0, arg_64_1)
	local var_64_0 = (arg_64_0._troopItems and #arg_64_0._troopItems > 0 and arg_64_0._troopItems) or arg_64_0._troopList:getItems()

	for iter_64_0 = 1, #var_64_0 do
		local var_64_1 = var_64_0[iter_64_0]._item or (var_64_0[iter_64_0].getChildren and #var_64_0[iter_64_0]:getChildren() > 0 and var_64_0[iter_64_0]:getChildren()[1])
		local var_64_2 = var_64_1 and var_64_1._thumbnail

		if var_64_2 and var_64_2._infoId == arg_64_1 then
			return var_64_1
		end
	end

	return nil
end

function var_0_1.getCardItem(arg_65_0, arg_65_1)
	for iter_65_0 = 1, arg_65_0._cardList._itemRow do
		for iter_65_1 = 1, arg_65_0._cardList._itemCol do
			local var_65_0 = arg_65_0._cardList._items[iter_65_0][iter_65_1]

			if var_65_0 and var_65_0._thumbnail._infoId == arg_65_1 then
				return var_65_0
			end
		end
	end

	return nil
end

function var_0_1.playAction(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	arg_66_0:runAction(lc.sequence(lc.delay(0), lc.call(function()
		local var_67_0
		local var_67_1

		if arg_66_2 then
			var_67_0 = arg_66_3

			local var_67_2 = arg_66_0:getTroopItem(arg_66_1)

			var_67_1 = var_67_2 and arg_66_0:convertToNodeSpace(var_67_2:convertToWorldSpace(cc.p(lc.cw(var_67_2), lc.ch(var_67_2)))) or cc.p(ClientView.SCR_W - 120, 60)
			var_67_1.x = math.min(ClientView.SCR_W - 120, math.max(0, var_67_1.x))
		else
			var_67_1 = arg_66_3

			local var_67_3 = arg_66_0:getCardItem(arg_66_1)

			var_67_0 = var_67_3 and arg_66_0:convertToNodeSpace(var_67_3:convertToWorldSpace(cc.p(lc.cw(var_67_3), lc.ch(var_67_3)))) or cc.p(100, ClientView.SCR_CH + 50)
		end

		local var_67_4 = cc.Node:create()

		arg_66_0:addChild(var_67_4)

		local var_67_5 = Particle.create("sz1")

		lc.addChildToCenter(var_67_4, var_67_5)

		local var_67_6 = Particle.create("sz2")

		lc.addChildToCenter(var_67_4, var_67_6)

		local var_67_7 = arg_66_2 and var_67_0 or var_67_1
		local var_67_8 = arg_66_2 and var_67_1 or var_67_0

		var_67_4:setPosition(var_67_7)
		var_67_4:setScale(2)
		var_67_4:runAction(lc.sequence(lc.moveTo(0.4, var_67_8), lc.call(function()
			var_67_5:setDuration(0.1)
			var_67_6:setDuration(0.1)
		end), lc.delay(1), lc.remove()))
	end)))
end

function var_0_1.onCardFlagDirty(arg_69_0, arg_69_1)
	arg_69_0:updateButtonFlags()

	local var_69_0 = arg_69_0:getCardItem(arg_69_1._infoId)

	if var_69_0 then
		var_69_0._thumbnail:updateFlag()
	end
end

function var_0_1.updateButtonFlags(arg_70_0)
	local var_70_0 = P._playerCard:getMonsterFlag()

	ClientView.checkNewFlag(arg_70_0._tabArea._tabs[1], var_70_0, 20, -4)

	local var_70_1 = P._playerCard:getMagicFlag()

	ClientView.checkNewFlag(arg_70_0._tabArea._tabs[2], var_70_1, 20, -4)

	local var_70_2 = P._playerCard:getTrapFlag()

	ClientView.checkNewFlag(arg_70_0._tabArea._tabs[3], var_70_2, 20, -4)

	local var_70_3 = P._playerCard:getRareFlag()

	ClientView.checkNewFlag(arg_70_0._tabArea._tabs[4], var_70_3, 20, -4)
end

function var_0_1.syncTroop(arg_71_0)
	ClientData.saveTroops(true)
	ClientData.sendTroops(true, arg_71_0._curTroopIndex)

	if Data.isNormalTroop(arg_71_0._curTroopIndex) then
		ClientData.sendDefTroopIndex(arg_71_0._curTroopIndex)

		local var_71_0 = ClientData._cloneTroops[arg_71_0._curTroopIndex]

		if var_71_0 ~= nil and #var_71_0 > 0 then
			P:setCurrentTroopIndex(arg_71_0._curTroopIndex, false)
		end
	end

	if Data.isUnionBattleTroop(arg_71_0._curTroopIndex) then
		return ClientData.sendQuitGroupCards()
	end
end

function var_0_1.onMsg(arg_72_0, arg_72_1)
	if arg_72_1.type == SglMsgType_pb.PB_TYPE_TROOP_MARK then
		local var_72_0 = ClientView.getActiveIndicator():hide()

		if var_72_0 then
			var_72_0()
		end
	end
end

return var_0_1
