local var_0_0 = class("CardOperateScene", BaseUIScene)
local var_0_1 = require("FilterWidget")
local var_0_2 = require("CardThumbnail")
local var_0_3 = require("CardList")
local var_0_4 = require("CardInfoPanel")
local var_0_5 = cc.rect(34, 40, 2, 2)
local var_0_6 = cc.rect(20, 54, 2, 2)
local var_0_7 = 0.5
local var_0_8 = 0.45

var_0_0.MAX_OPERATE_COUNT = 40

local var_0_9 = 8
local var_0_10 = cc.c4b(235, 218, 175, 255)
local var_0_11 = {
	vertical = 2,
	horizontal = 1,
	none = 0
}

var_0_0.TouchStatus = {
	press = 1,
	tap = 3,
	move = 2
}
var_0_0.MODE_UNTROOP = 1
var_0_0.MODE_TROOP = 2
var_0_0.EXPEDITION_BASE_LEVEL = 1

local var_0_12 = 244
local var_0_13 = 80

function var_0_0.create(arg_1_0)
	return lc.createScene(var_0_0, arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.card_operate, STR.SMELT, BaseUIScene.STYLE_TAB, true) then
		return false
	end

	arg_2_0._cardsOperateTroop = {}

	arg_2_0:createFrame()
	arg_2_0:createTroopArea()
	arg_2_0:createCardList()
	ClientView.addVerticalTabButtons(arg_2_0, {
		Str(STR.MONSTER),
		Str(STR.MAGIC),
		Str(STR.TRAP),
		Str(STR.RARE) .. Str(STR.MONSTER)
	}, lc.top(arg_2_0._frame) - 60, lc.left(arg_2_0._frame) - 124, 450, 100)
	arg_2_0:updateTroopList()

	arg_2_0._lastTabIndex = nil

	arg_2_0:showTab(arg_2_0._tabArea._focusTabIndex and arg_2_0._tabArea._focusTabIndex or 1)

	return true
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	arg_3_0._listeners = {}

	local var_3_0 = lc.addEventListener(Data.Event.card_dirty, function(arg_4_0)
		arg_3_0:updateBottomValueAreas()
	end)

	table.insert(arg_3_0._listeners, var_3_0)

	if arg_3_0._needUpdateTroopList then
		arg_3_0:updateTroopList()

		arg_3_0._needUpdateTroopList = nil
	end
end

function var_0_0.onExit(arg_5_0)
	var_0_0.super.onExit(arg_5_0)

	for iter_5_0 = 1, #arg_5_0._listeners do
		lc.Dispatcher:removeEventListener(arg_5_0._listeners[iter_5_0])
	end

	arg_5_0:releaseToopList()

	arg_5_0._needUpdateTroopList = true
end

function var_0_0.onCleanup(arg_6_0)
	var_0_0.super.onCleanup(arg_6_0)
	arg_6_0:releaseToopList()

	var_0_4._operateType = var_0_4.OperateType.na
end

function var_0_0.createFrame(arg_7_0)
	local var_7_0 = ClientView.createFrameBox(cc.size(lc.w(arg_7_0) - (16 + ClientView.FRAME_TAB_WIDTH + ClientView.SCR_EDGE) * 2, lc.h(arg_7_0) - 250))

	lc.addChildToPos(arg_7_0, var_7_0, cc.p(lc.w(arg_7_0) / 2, lc.bottom(arg_7_0._titleArea) - lc.h(var_7_0) / 2 + 10))

	arg_7_0._frame = var_7_0
end

function var_0_0.createTroopArea(arg_8_0)
	local var_8_0 = lc.createSprite({
		_name = "res/jpg/troop_operate_bg.jpg",
		_size = cc.size(lc.w(arg_8_0) - ClientView.SCR_EDGE * 2, 211),
		_crect = cc.rect(47, 20, 1, 191)
	})
	local var_8_1 = lc.createNode(cc.size(lc.w(var_8_0), lc.h(var_8_0)))

	lc.addChildToPos(arg_8_0, var_8_1, cc.p(lc.w(arg_8_0) / 2, lc.h(var_8_1) / 2))

	arg_8_0._troopArea = var_8_1

	local var_8_2 = lc.createNode(cc.size(181, 210))

	lc.addChildToPos(var_8_1, var_8_2, cc.p(lc.w(var_8_1) - lc.cw(var_8_2) - 10, lc.ch(var_8_2) - 4), 1)

	arg_8_0._troopBgSmall = var_8_2

	lc.addChildToCenter(var_8_1, var_8_0)

	local var_8_3 = lc.List.createH(cc.size(lc.w(var_8_1) - lc.w(var_8_2) - 40, lc.h(var_8_1) - 6), 20, 10)

	lc.addChildToPos(var_8_1, var_8_3, cc.p(24, 0))

	arg_8_0._troopList = var_8_3

	local var_8_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_9_0)
		arg_8_0:onSmelt()
	end, ClientView.CRECT_BUTTON_S, 160)

	var_8_4:addLabel(Str(STR.SMELT))
	lc.addChildToPos(var_8_2, var_8_4, cc.p(lc.cw(var_8_2), lc.ch(var_8_4) + 5))
end

function var_0_0.updateGotMaterialArea(arg_10_0)
	if arg_10_0._gotMatArea then
		arg_10_0._gotMatArea:removeFromParent()

		arg_10_0._gotMatArea = nil
	end

	local var_10_0 = {}
	local var_10_1, var_10_2 = P._playerCard:getSmeltDust(arg_10_0._infoId)
	local var_10_3 = var_10_2 * arg_10_0:getTroopCardNum(arg_10_0._cardsOperateTroop)

	table.insert(var_10_0, arg_10_0:createMat(arg_10_0._infoId, var_10_1, var_10_3))

	local var_10_4 = ClientView.createMaterialArea(var_10_0, "", false)

	lc.addChildToCenter(arg_10_0._troopBgSmall, var_10_4)
	var_10_4:setScale(0.8)
	lc.offset(var_10_4, 0, -50)

	arg_10_0._gotMatArea = var_10_4
end

function var_0_0.createMat(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {}

	if arg_11_2 then
		var_11_0._icon = IconWidget.create({
			_infoId = arg_11_2,
			_num = P:getItemCount(arg_11_2)
		}, 0)
		var_11_0._need = arg_11_3 or card:getRebirthNeedCount()
	else
		var_11_0._icon = IconWidget.create({
			_isFragment = false,
			_infoId = arg_11_1,
			_count = P._playerCard:getCardCount(arg_11_1)
		}, 0)
		var_11_0._need = arg_11_3 or card:getRebirthNeedCount()
	end

	return var_11_0
end

function var_0_0.createCardList(arg_12_0)
	arg_12_0._cardList = require("CardList").create(cc.size(lc.w(arg_12_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 90, lc.h(arg_12_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), var_0_7, false)

	arg_12_0._cardList:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_12_0._frame, arg_12_0._cardList, cc.p(lc.w(arg_12_0._frame) / 2, lc.h(arg_12_0._frame) / 2))
	arg_12_0._cardList:registerCardSelectedHandler(function(arg_13_0, arg_13_1)
		arg_12_0:onCardSelected(arg_13_0, arg_13_1)
	end)
	arg_12_0._cardList:registerTouchThumbnail(function(arg_14_0, arg_14_1)
		arg_12_0:onCardTouch(arg_14_0, arg_14_1)
	end)

	arg_12_0._cardList._operateMode = Data.OperateMode.smelt
	arg_12_0._cardList._cardOperateTroop = arg_12_0._cardsOperateTroop

	arg_12_0._cardList:setMode(var_0_3.ModeType.card_operate)

	local var_12_0 = (lc.w(arg_12_0._frame) - lc.w(arg_12_0._cardList)) / 2 + 16

	arg_12_0._cardList._pageLeft._pos = cc.p(-var_12_0, 80)
	arg_12_0._cardList._pageRight._pos = cc.p(lc.w(arg_12_0._cardList) + var_12_0, 80)

	local var_12_1 = var_12_0 + 32
	local var_12_2 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_12_0._frame, var_12_2, cc.p(-lc.w(var_12_2) / 2 + 12, 40), -1)
	arg_12_0._cardList._pageLabel:setPosition(-var_12_1, 12)

	arg_12_0._filterWidgets = {}

	local var_12_3 = {
		var_0_1.ModeType.monster,
		var_0_1.ModeType.magic,
		var_0_1.ModeType.trap,
		var_0_1.ModeType.rare
	}

	for iter_12_0 = 1, #var_12_3 do
		local var_12_4 = var_0_1.create(var_12_3[iter_12_0], lc.h(arg_12_0._frame) - 80)

		var_12_4:resetAllFilter()
		var_12_4:registerSortFilterHandler(function()
			arg_12_0:updateCardList(true)
		end)
		var_12_4:setVisible(iter_12_0 == 1)
		lc.addChildToPos(arg_12_0._frame, var_12_4, cc.p(lc.w(arg_12_0._frame) + ClientView.FRAME_TAB_WIDTH - lc.w(var_12_4) / 2 + 2, lc.h(var_12_4) / 2))

		arg_12_0._filterWidgets[iter_12_0] = var_12_4
	end
end

function var_0_0.releaseToopList(arg_16_0)
	local var_16_0 = arg_16_0._troopList:getItems()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		var_0_2.releaseToPool(iter_16_1._item)
		iter_16_1:release()
	end

	arg_16_0._troopList:removeAllItems()
end

function var_0_0.updateTroopList(arg_17_0)
	local var_17_0 = arg_17_0._cardsOperateTroop
	local var_17_1 = {}

	arg_17_0:releaseToopList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_2 = ccui.Layout:create()

		var_17_2:retain()

		local var_17_3 = var_0_2.createFromPool(iter_17_1._infoId, var_0_8, P._playerCard:getSkinId(iter_17_1._infoId))

		var_17_3._countArea:update(true, iter_17_1._num)
		var_17_2:setContentSize(var_17_3._thumbnail:getContentSize())
		var_17_2:setAnchorPoint(cc.p(0.5, 0.5))
		lc.addChildToPos(var_17_2, var_17_3, cc.p(lc.cw(var_17_2), lc.ch(var_17_2) + 10))
		var_17_3._thumbnail:setTouchEnabled(true)
		var_17_3._thumbnail:addTouchEventListener(function(arg_18_0, arg_18_1)
			arg_17_0:onTroopTouchThumbnail(arg_18_0, arg_18_1)
		end)

		var_17_2._item = var_17_3

		table.insert(var_17_1, var_17_2)

		var_17_2._card = iter_17_1
	end

	local function var_17_4(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0._card._infoId
		local var_19_1 = arg_19_1._card._infoId
		local var_19_2 = Data.removeAdditional(var_19_0)
		local var_19_3 = Data.removeAdditional(var_19_1)

		if var_19_2 == var_19_3 then
			return var_19_1 < var_19_0
		else
			return var_19_2 < var_19_3
		end
	end

	table.sort(var_17_1, var_17_4)

	for iter_17_2, iter_17_3 in ipairs(var_17_1) do
		arg_17_0._troopList:pushBackCustomItem(iter_17_3)
	end

	arg_17_0:updateBottomValueAreas()
end

function var_0_0.showTab(arg_20_0, arg_20_1)
	arg_20_0._tabArea:showTab(arg_20_1)

	for iter_20_0 = 1, #arg_20_0._filterWidgets do
		arg_20_0._filterWidgets[iter_20_0]:setVisible(arg_20_0._tabArea._focusTabIndex == iter_20_0)
	end

	arg_20_0:updateCardList(true)

	arg_20_0._lastTabIndex = arg_20_1
end

function var_0_0.updateCardList(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._cardsOperateTroop
	local var_21_1 = arg_21_0._tabArea._focusTabIndex
	local var_21_2 = {}
	local var_21_3 = {}
	local var_21_4
	local var_21_5 = arg_21_0._filterWidgets[var_21_1]
	local var_21_6, var_21_7 = var_21_5:getSortFunc()

	if var_21_6 then
		var_21_4 = {
			_func = var_21_6,
			_isReverse = not var_21_7
		}
	end

	if Data.BaseCardTypes[var_21_1] == Data.CardType.monster or Data.BaseCardTypes[var_21_1] == Data.CardType.rare then
		local var_21_8, var_21_9 = var_21_5:getFilterNatureFunc()

		if var_21_8 then
			var_21_3[var_0_3.FilterType.country] = {
				_func = var_21_8,
				_keyVal = var_21_9
			}
		end

		local var_21_10, var_21_11 = var_21_5:getFilterCategoryFunc()

		if var_21_10 then
			var_21_3[var_0_3.FilterType.category] = {
				_func = var_21_10,
				_keyVal = var_21_11
			}
		end

		local var_21_12, var_21_13 = var_21_5:getFilterLevelFunc()

		if var_21_12 then
			var_21_3[var_0_3.FilterType.cost] = {
				_func = var_21_12,
				_keyVal = var_21_13
			}
		end
	end

	local var_21_14, var_21_15 = var_21_5:getFilterQualityFunc()

	if var_21_14 then
		var_21_3[var_0_3.FilterType.quality] = {
			_func = var_21_14,
			_keyVal = var_21_15
		}
	end

	if Data.BaseCardTypes[var_21_1] == Data.CardType.magic then
		local var_21_16, var_21_17 = var_21_5:getFilterMagicOptionFunc()

		if var_21_16 then
			var_21_3[var_0_3.FilterType.option] = {
				_func = var_21_16,
				_keyVal = var_21_17
			}
		end
	elseif Data.BaseCardTypes[var_21_1] == Data.CardType.trap then
		local var_21_18, var_21_19 = var_21_5:getFilterTrapOptionFunc()

		if var_21_18 then
			var_21_3[var_0_3.FilterType.option] = {
				_func = var_21_18,
				_keyVal = var_21_19
			}
		end
	end

	local var_21_20, var_21_21 = var_21_5:getFilterSearchFunc()

	if var_21_20 then
		var_21_3[var_0_3.FilterType.search] = {
			_func = var_21_20,
			_keyVal = var_21_21
		}
	end

	local var_21_22 = arg_21_0._cardList

	var_21_22:init(Data.BaseCardTypes[var_21_1], var_21_2, var_21_4, var_21_3)

	var_21_22._pageLeft._pos = cc.p(16, lc.ch(var_21_22))
	var_21_22._pageRight._pos = cc.p(lc.w(var_21_22) - 16, lc.ch(var_21_22))

	var_21_22:refresh(arg_21_1)
end

function var_0_0.clearTroop(arg_22_0)
	table.clear(arg_22_0._cardsOperateTroop)
	arg_22_0:updateCardList()
	arg_22_0:updateTroopList()
end

function var_0_0.updateBottomValueAreas(arg_23_0)
	arg_23_0:updateGotMaterialArea()
end

function var_0_0.onItemPress(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0._movingSprite then
		return
	end

	arg_24_0._touchStatus = var_0_0.TouchStatus.press
	arg_24_0._movingDir = var_0_11.none
	arg_24_0._movingDeadCard = nil
end

function var_0_0.onItemMove(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0._touchStatus == var_0_0.TouchStatus.tap then
		return
	end

	arg_25_0._touchStatus = var_0_0.TouchStatus.move

	if arg_25_0._movingSprite == nil then
		if arg_25_0._movingDir == var_0_11.none then
			local var_25_0 = math.abs(cc.pSub(arg_25_1:getTouchMovePosition(), arg_25_1:getTouchBeganPosition()).x)
			local var_25_1 = math.abs(cc.pSub(arg_25_1:getTouchMovePosition(), arg_25_1:getTouchBeganPosition()).y)

			if var_25_0 > 32 or var_25_1 > 32 then
				arg_25_0._movingDir = var_25_1 <= var_25_0 and var_0_11.horizontal or var_0_11.vertical
			end
		end

		if arg_25_2 == var_0_0.MODE_TROOP or arg_25_0._movingDir == var_0_11.vertical then
			arg_25_0:createMovingSpriteAndMaskLayer(arg_25_1, arg_25_2)
		end
	end

	if arg_25_0._movingSprite then
		arg_25_0._movingSprite:setPosition(cc.pAdd(arg_25_0._movingSprite._srcPos, cc.pSub(arg_25_1:getTouchMovePosition(), arg_25_1:getTouchBeganPosition())))
		arg_25_0:checkList(arg_25_2 == var_0_0.MODE_TROOP and arg_25_0._troopList or arg_25_0._cardList)
	end
end

function var_0_0.onItemTap(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._touchStatus = var_0_0.TouchStatus.tap

	local var_26_0 = arg_26_1._infoId
	local var_26_1, var_26_2 = Data.getInfo(var_26_0)
	local var_26_3 = arg_26_0._cardsOperateTroop
	local var_26_4 = var_0_0.MAX_OPERATE_COUNT
	local var_26_5 = arg_26_0:getTroopCardNum(var_26_3)
	local var_26_6 = arg_26_0:getTroopCardCount(var_26_3, var_26_0)

	if arg_26_2 == var_0_0.MODE_TROOP then
		if arg_26_0._movingSprite and arg_26_0._isInList then
			local var_26_7 = P._playerCard:getCardOperateCount(var_26_0)

			if var_26_5 < var_26_4 and var_26_6 < var_26_7 then
				arg_26_0:onCardUnlocked(var_26_0)

				var_26_3._isDirty = true

				arg_26_0:addCardToTroop(var_26_3, var_26_0)
				arg_26_0:updateCardList(false)
				arg_26_0:updateTroopList()
				arg_26_0:updateBottomValueAreas()
				arg_26_0:playAction(var_26_0, true, arg_26_0._movingSprite._srcPos)
			elseif var_26_4 <= var_26_5 then
				ToastManager.push(Str(STR.FULL_IN_OPERATE_TROOP))
			end
		end
	elseif arg_26_2 == var_0_0.MODE_UNTROOP and arg_26_0._movingSprite and arg_26_0._isInList then
		var_26_3._isDirty = true

		arg_26_0:removeCardFromTroop(var_26_3, var_26_0)
		arg_26_0:updateCardList(false)
		arg_26_0:updateTroopList()
		arg_26_0:updateBottomValueAreas()
		arg_26_0:playAction(var_26_0, false, arg_26_0._movingSprite._srcPos)
	end

	if arg_26_0._maskLayer then
		arg_26_0:removeMaskLayer(arg_26_2)
	end

	if arg_26_0._movingSprite then
		arg_26_0._movingSprite:removeFromParent()

		arg_26_0._movingSprite = nil
	end
end

function var_0_0.onTroopTouchThumbnail(arg_27_0, arg_27_1, arg_27_2)
	arg_27_1:stopAllActions()

	if arg_27_2 == ccui.TouchEventType.began then
		arg_27_1:runAction(lc.scaleTo(0.1, 0.95))
		arg_27_0:onItemPress(arg_27_1, var_0_0.MODE_UNTROOP)
	elseif arg_27_2 == ccui.TouchEventType.ended or arg_27_2 == ccui.TouchEventType.canceled then
		arg_27_1:runAction(lc.scaleTo(0.08, 1))
		arg_27_0:onItemTap(arg_27_1, var_0_0.MODE_UNTROOP)

		if arg_27_2 == ccui.TouchEventType.ended then
			arg_27_0:onTroopThumbnailSelected(arg_27_1)
		end
	elseif arg_27_2 == ccui.TouchEventType.moved then
		arg_27_0:onItemMove(arg_27_1, var_0_0.MODE_UNTROOP)
	end
end

function var_0_0.onTroopThumbnailSelected(arg_28_0, arg_28_1)
	if true then
		local var_28_0 = var_0_4.create(arg_28_1._infoId, P._playerCard._levels[arg_28_1._infoId], var_0_4.OperateType.troop)
		local var_28_1 = {}
		local var_28_2 = 0
		local var_28_3 = arg_28_0._troopList:getItems()

		for iter_28_0 = 1, #var_28_3 do
			local var_28_4 = var_28_3[iter_28_0]._item._thumbnail

			var_28_1[#var_28_1 + 1] = {
				_infoId = var_28_4._infoId,
				_num = var_28_4._count
			}

			if arg_28_1 == var_28_4 then
				var_28_2 = iter_28_0
			end
		end

		var_28_0:setCardList(var_28_1, var_28_2, Str(STR.CUR_TROOP))
		var_28_0:setCardCount(arg_28_1._count)
		var_28_0:show()
	end
end

function var_0_0.onCardTouch(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_2 == ccui.TouchEventType.began then
		arg_29_0:onItemPress(arg_29_1, var_0_0.MODE_TROOP)
	elseif arg_29_2 == ccui.TouchEventType.ended or arg_29_2 == ccui.TouchEventType.canceled then
		if arg_29_0._movingDeadCard then
			return
		end

		arg_29_0:onItemTap(arg_29_1, var_0_0.MODE_TROOP)
	elseif arg_29_2 == ccui.TouchEventType.moved then
		if arg_29_1._item._locked or arg_29_0._movingDeadCard then
			return
		end

		arg_29_0:onItemMove(arg_29_1, var_0_0.MODE_TROOP)
	end
end

function var_0_0.onCardSelected(arg_30_0, arg_30_1, arg_30_2)
	if not arg_30_1 or arg_30_1 == 0 then return end
	for iter_30_0 = 1, #lc._runningScene._scene:getChildren() do
		if lc._runningScene._scene:getChildren()[iter_30_0]._panelName == "CardInfoPanel" then
			return
		end
	end

	arg_30_0:onCardUnlocked(arg_30_1)

	local cardLvl = (P._playerCard and P._playerCard._levels and P._playerCard._levels[arg_30_1]) or 1
	var_0_4.create(arg_30_1, cardLvl, var_0_4.OperateType.view):show()
end

function var_0_0.onCardUnlocked(arg_31_0, arg_31_1)
	if P._playerCard:isUnlocked(arg_31_1) then
		P._playerCard:removeUnlocked(arg_31_1)
		ClientData.sendCardUnlockConfirmed(arg_31_1)
	end
end

function var_0_0.createMovingSpriteAndMaskLayer(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2 == var_0_0.MODE_TROOP and arg_32_0._troopList or arg_32_0._cardList
	local var_32_1 = arg_32_2 == var_0_0.MODE_TROOP and arg_32_0._cardList or arg_32_0._troopList
	local var_32_2 = arg_32_1:convertToWorldSpace(cc.p(lc.w(arg_32_1) / 2, lc.h(arg_32_1) / 2))
	local var_32_3 = arg_32_0:convertToNodeSpace(var_32_2)
	local var_32_4 = arg_32_1._infoId
	local var_32_5 = var_0_2.create(var_32_4, var_0_7, P._playerCard:getSkinId(var_32_4))

	arg_32_0:addChild(var_32_5, ClientData.ZOrder.ui + 2)

	arg_32_0._movingSprite = var_32_5
	arg_32_0._movingSprite._srcPos = var_32_3
	arg_32_0._movingSprite._abc = 1

	arg_32_0._movingSprite:setPosition(cc.pAdd(var_32_3, cc.pSub(arg_32_1:getTouchMovePosition(), arg_32_1:getTouchBeganPosition())))

	if var_32_1 == arg_32_0._troopList then
		var_32_1:setIsScrollEnabled(false)
	end

	local var_32_6 = var_32_0:convertToWorldSpace(cc.p(0, 0))
	local var_32_7 = arg_32_0:convertToNodeSpace(var_32_6)

	var_32_7.x = 0

	local var_32_8 = cc.rect(var_32_7.x, var_32_7.y, lc.w(arg_32_0), lc.h(var_32_0))

	arg_32_0._maskLayer = arg_32_0:createMaskLayer(var_32_8)

	arg_32_0:addChild(arg_32_0._maskLayer, ClientData.ZOrder.ui + 1)

	arg_32_0._separatorPos = arg_32_2 == var_0_0.MODE_UNTROOP and var_32_7.y or var_32_7.y + var_32_8.height
end

function var_0_0.createMaskLayer(arg_33_0, arg_33_1)
	local var_33_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 192), lc.w(arg_33_0), lc.h(arg_33_0))

	return ClientView.createClipNode(var_33_0, arg_33_1, true)
end

function var_0_0.removeMaskLayer(arg_34_0, arg_34_1)
	if arg_34_1 == var_0_0.MODE_TROOP then
		-- block empty
	else
		arg_34_0._troopList:setIsScrollEnabled(true)
	end

	arg_34_0._maskLayer:removeFromParent(true)

	arg_34_0._maskLayer = nil
end

function var_0_0.checkList(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1 == arg_35_0._troopList
	local var_35_1

	var_35_1 = var_35_0 and 0.5 or 0

	local var_35_2 = arg_35_0._movingSprite

	if var_35_0 then
		arg_35_0._isInList = arg_35_0._separatorPos > lc.y(var_35_2)
	else
		arg_35_0._isInList = arg_35_0._separatorPos < lc.y(var_35_2)
	end
end

function var_0_0.hide(arg_36_0)
	var_0_0.super.hide(arg_36_0)
end

function var_0_0.addCardToTroop(arg_37_0, arg_37_1, arg_37_2)
	for iter_37_0 = 1, #arg_37_1 do
		local var_37_0 = arg_37_1[iter_37_0]

		if var_37_0._infoId == arg_37_2 then
			var_37_0._num = var_37_0._num + 1

			return
		end
	end

	arg_37_1[#arg_37_1 + 1] = {
		_num = 1,
		_infoId = arg_37_2
	}
end

function var_0_0.removeCardFromTroop(arg_38_0, arg_38_1, arg_38_2)
	for iter_38_0 = 1, #arg_38_1 do
		local var_38_0 = arg_38_1[iter_38_0]

		if var_38_0._infoId == arg_38_2 then
			var_38_0._num = var_38_0._num - 1

			if var_38_0._num == 0 then
				table.remove(arg_38_1, iter_38_0)
			end

			break
		end
	end
end

function var_0_0.getTroopCardNum(arg_39_0, arg_39_1)
	local var_39_0 = 0

	for iter_39_0 = 1, #arg_39_1 do
		var_39_0 = var_39_0 + arg_39_1[iter_39_0]._num
	end

	return var_39_0
end

function var_0_0.getTroopCardCount(arg_40_0, arg_40_1, arg_40_2)
	for iter_40_0 = 1, #arg_40_1 do
		local var_40_0 = arg_40_1[iter_40_0]

		if var_40_0._infoId == arg_40_2 then
			return var_40_0._num
		end
	end

	return 0
end

function var_0_0.getTroopItem(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0._troopList:getItems()

	for iter_41_0 = 1, #var_41_0 do
		local var_41_1 = var_41_0[iter_41_0]._item
		local var_41_2 = var_41_1._thumbnail

		if var_41_2 and var_41_2._infoId == arg_41_1 then
			return var_41_1
		end
	end

	return nil
end

function var_0_0.getCardItem(arg_42_0, arg_42_1)
	for iter_42_0 = 1, arg_42_0._cardList._itemRow do
		for iter_42_1 = 1, arg_42_0._cardList._itemCol do
			local var_42_0 = arg_42_0._cardList._items[iter_42_0][iter_42_1]

			if var_42_0 and var_42_0._thumbnail._infoId == arg_42_1 then
				return var_42_0
			end
		end
	end

	return nil
end

function var_0_0.playAction(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	arg_43_0:runAction(lc.sequence(lc.delay(0), lc.call(function()
		local var_44_0
		local var_44_1

		if arg_43_2 then
			var_44_0 = arg_43_3

			local var_44_2 = arg_43_0:getTroopItem(arg_43_1)

			var_44_1 = var_44_2 and arg_43_0:convertToNodeSpace(var_44_2:convertToWorldSpace(cc.p(lc.cw(var_44_2), lc.ch(var_44_2)))) or cc.p(ClientView.SCR_W - 120, 60)
			var_44_1.x = math.min(ClientView.SCR_W - 120, math.max(0, var_44_1.x))
		else
			var_44_1 = arg_43_3

			local var_44_3 = arg_43_0:getCardItem(arg_43_1)

			var_44_0 = var_44_3 and arg_43_0:convertToNodeSpace(var_44_3:convertToWorldSpace(cc.p(lc.cw(var_44_3), lc.ch(var_44_3)))) or cc.p(100, ClientView.SCR_CH + 50)
		end

		local var_44_4 = cc.Node:create()

		arg_43_0:addChild(var_44_4)

		local var_44_5 = Particle.create("sz1")

		lc.addChildToCenter(var_44_4, var_44_5)

		local var_44_6 = Particle.create("sz2")

		lc.addChildToCenter(var_44_4, var_44_6)

		local var_44_7 = arg_43_2 and var_44_0 or var_44_1
		local var_44_8 = arg_43_2 and var_44_1 or var_44_0

		var_44_4:setPosition(var_44_7)
		var_44_4:setScale(2)
		var_44_4:runAction(lc.sequence(lc.moveTo(0.4, var_44_8), lc.call(function()
			var_44_5:setDuration(0.1)
			var_44_6:setDuration(0.1)
		end), lc.delay(1), lc.remove()))
	end)))
end

function var_0_0.onSmelt(arg_46_0)
	if arg_46_0:getTroopCardNum(arg_46_0._cardsOperateTroop) == 0 then
		return ToastManager.push(Str(STR.SELECT_COUNT_SMELT))
	end

	arg_46_0:doSmelt()
	table.clear(arg_46_0._cardsOperateTroop)
	arg_46_0:updateCardList()
	arg_46_0:updateTroopList()
end

function var_0_0.doSmelt(arg_47_0)
	local var_47_0 = 0

	for iter_47_0, iter_47_1 in ipairs(arg_47_0._cardsOperateTroop) do
		local var_47_1 = iter_47_1._infoId
		local var_47_2 = iter_47_1._num
		local var_47_3 = P._playerCard:smeltCard(var_47_1, var_47_2)

		if var_47_3 == Data.ErrorType.ok then
			var_47_0 = var_47_0 + var_47_2

			ClientData.sendCardSmelt(var_47_1, var_47_2)
		elseif var_47_3 == Data.ErrorType.need_more_samecard then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getStrByCardType(cardType)))
		end
	end

	if var_47_0 > 0 then
		local var_47_4, var_47_5 = P._playerCard:getSmeltDust()
		local var_47_6 = require("RewardPanel")

		var_47_6.create({
			{
				_infoId = var_47_4,
				_count = var_47_5 * var_47_0
			}
		}, var_47_6.MODE_SPLIT):show()
	end
end

return var_0_0
