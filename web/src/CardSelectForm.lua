local var_0_0 = class("CardSelectForm", BaseForm)
local var_0_1 = require("CardList")
local var_0_2 = require("FilterWidget")
local var_0_3 = require("CardInfoPanel")

var_0_0.MODE_SWALLOW = 1
var_0_0.MODE_GUARD = 2
var_0_0.MODE_PALACE = 3
var_0_0.MODE_HIRE = 4
var_0_0.MODE_TRANSFER = 5
var_0_0.MODE_RARE_COMPOSE = 6

local var_0_4 = 0.6
local var_0_5 = 80
local var_0_6 = cc.size(math.min(1200, lc.Director:getVisibleSize().width) - (16 + ClientView.FRAME_TAB_WIDTH) * 2, 680)
local var_0_7 = bor(BaseForm.FLAG.ADVANCE_TITLE_BG, BaseForm.FLAG.PAPER_BG, BaseForm.FLAG.TOP_AREA, BaseForm.FLAG.BOTTOM_AREA, BaseForm.FLAG.SCROLL_H)

function var_0_0.createSwallowForm(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:initSwallowForm(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.createTransferForm(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_2_0:initTransferForm(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function var_0_0.createRareComposeForm(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_3_0:initRareComposeForm(arg_3_0, arg_3_1)

	return var_3_0
end

function var_0_0.createStationedForm(arg_4_0)
	local var_4_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_4_0:initStationedForm(arg_4_0)

	return var_4_0
end

function var_0_0.createPalaceForm(arg_5_0)
	local var_5_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_5_0:initPalaceForm(arg_5_0)

	return var_5_0
end

function var_0_0.createHireForm(arg_6_0)
	local var_6_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_6_0:initHireForm(arg_6_0)

	return var_6_0
end

function var_0_0.initSwallowForm(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._mode = var_0_0.MODE_SWALLOW

	if type(arg_7_1) == "number" then
		arg_7_0._exceptCard = nil
		arg_7_0._selectType = arg_7_1
	else
		arg_7_0._exceptCard = arg_7_1
		arg_7_0._selectType = arg_7_0._exceptCard._type
	end

	local var_7_0 = ""

	if arg_7_0._selectType == Data.CardType.monster then
		var_7_0 = Str(STR.MONSTER)
	elseif arg_7_0._selectType == Data.CardType.book then
		var_7_0 = Str(STR.BOOK)
	elseif arg_7_0._selectType == Data.CardType.horse then
		var_7_0 = Str(STR.HORSE)
	elseif arg_7_0._selectType == Data.CardType.weapon then
		var_7_0 = Str(STR.WEAPON)
	elseif arg_7_0._selectType == Data.CardType.armor then
		var_7_0 = Str(STR.ARMOR)
	end

	var_0_0.super.init(arg_7_0, var_0_6, Str(STR.SELECT) .. var_7_0, var_0_7)

	arg_7_0._selectCards = arg_7_2

	local var_7_1 = lc.w(arg_7_0._form) - var_0_0.FRAME_THICK_LEFT - var_0_0.FRAME_THICK_RIGHT - 24

	if arg_7_0._selectType == Data.CardType.monster then
		arg_7_0._filterWidget = var_0_2.create(var_0_2.ModeType.monster, var_7_1)

		arg_7_0._filterWidget:setFilterNature(var_0_2.FilterNature.all)
	elseif arg_7_0._selectType == Data.CardType.book then
		arg_7_0._filterWidget = var_0_2.create(var_0_2.ModeType.book, var_7_1)
	elseif arg_7_0._selectType == Data.CardType.horse then
		arg_7_0._filterWidget = var_0_2.create(var_0_2.ModeType.horse, var_7_1)
	elseif arg_7_0._selectType == Data.CardType.weapon then
		arg_7_0._filterWidget = var_0_2.create(var_0_2.ModeType.weapon, var_7_1)
	elseif arg_7_0._selectType == Data.CardType.armor then
		arg_7_0._filterWidget = var_0_2.create(var_0_2.ModeType.armor, var_7_1)
	end

	arg_7_0._filterWidget:resetAllFilter()
	arg_7_0._filterWidget:registerSortFilterHandler(function()
		arg_7_0:updateCardList()
	end)
	lc.addChildToPos(arg_7_0._form, arg_7_0._filterWidget, cc.p(lc.w(arg_7_0._form) / 2, 40))
	arg_7_0:createListArea()
	arg_7_0:createBottomArea()
end

function var_0_0.initTransferForm(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0._mode = var_0_0.MODE_TRANSFER
	arg_9_0._selectType = arg_9_1
	arg_9_0._exceptCards = arg_9_3
	arg_9_0._selectCards = arg_9_4

	local var_9_0 = ""

	if arg_9_0._selectType == Data.CardType.monster then
		var_9_0 = Str(STR.MONSTER)
	elseif arg_9_0._selectType == Data.CardType.magic then
		var_9_0 = Str(STR.MAGIC)
	elseif arg_9_0._selectType == Data.CardType.trap then
		var_9_0 = Str(STR.TRAP)
	end

	local var_9_1 = lc.Director:getVisibleSize()

	var_0_0.super.init(arg_9_0, cc.size(var_9_1.width - (16 + ClientView.FRAME_TAB_WIDTH) * 2, var_9_1.height - 40), Str(STR.SELECT) .. var_9_0, var_0_7)

	if arg_9_0._selectType == Data.CardType.monster then
		arg_9_0._filterWidget = var_0_2.create(var_0_2.ModeType.monster, lc.h(arg_9_0._frame) - 80)

		arg_9_0._filterWidget:setFilterNature(var_0_2.FilterNature.all)
	elseif arg_9_0._selectType == Data.CardType.magic then
		arg_9_0._filterWidget = var_0_2.create(var_0_2.ModeType.magic, lc.h(arg_9_0._frame) - 80)
	elseif arg_9_0._selectType == Data.CardType.trap then
		arg_9_0._filterWidget = var_0_2.create(var_0_2.ModeType.trap, lc.h(arg_9_0._frame) - 80)
	end

	arg_9_0._filterWidget:resetAllFilter()
	arg_9_0._filterWidget:registerSortFilterHandler(function()
		arg_9_0:updateCardList()
	end)
	lc.addChildToPos(arg_9_0._frame, arg_9_0._filterWidget, cc.p(lc.w(arg_9_0._frame) + ClientView.FRAME_TAB_WIDTH - lc.w(arg_9_0._filterWidget) / 2 + 2, lc.h(arg_9_0._filterWidget) / 2))
	lc.offset(arg_9_0._filterWidget._searchArea, 0, 196)
	arg_9_0:createListArea()
	arg_9_0:createBottomArea()
	arg_9_0:updateSelectCount()
end

function var_0_0.initRareComposeForm(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._mode = var_0_0.MODE_RARE_COMPOSE
	arg_11_0._cards = arg_11_1
	arg_11_0._selectCards = arg_11_2

	local var_11_0 = ""
	local var_11_1 = lc.Director:getVisibleSize()

	var_0_0.super.init(arg_11_0, cc.size(var_11_1.width - (16 + ClientView.FRAME_TAB_WIDTH) * 2, var_11_1.height - 40), Str(STR.SELECT) .. var_11_0, var_0_7)
	arg_11_0:createListArea()
	arg_11_0:createBottomArea()
	arg_11_0:updateSelectCount()
end

function var_0_0.initStationedForm(arg_12_0, arg_12_1)
	local var_12_0 = lc.Director:getVisibleSize()

	var_0_0.super.init(arg_12_0, cc.size(var_12_0.width - (16 + ClientView.FRAME_TAB_WIDTH) * 2, var_12_0.height - 40), Str(STR.SELECT_STATIONED_HERO), var_0_7)

	arg_12_0._mode = var_0_0.MODE_GUARD
	arg_12_0._selectCards = {
		arg_12_1
	}
	arg_12_0._selectType = Data.CardType.monster

	ClientView.addVerticalTabButtons(arg_12_0._form, {
		Str(STR.MONSTER),
		Str(STR.MAGIC),
		Str(STR.TRAP)
	}, lc.top(arg_12_0._frame) - 80, lc.left(arg_12_0._frame) - 124, 350)

	arg_12_0._filterWidgets = {}

	for iter_12_0 = Data.CardType.monster, Data.CardType.trap do
		local var_12_1 = var_0_2.create(iter_12_0, lc.h(arg_12_0._frame) - 80)

		var_12_1:resetAllFilter()
		var_12_1:registerSortFilterHandler(function()
			arg_12_0:updateCardList()
		end)
		lc.addChildToPos(arg_12_0._frame, var_12_1, cc.p(lc.w(arg_12_0._frame) + ClientView.FRAME_TAB_WIDTH - lc.w(var_12_1) / 2 + 2, lc.h(var_12_1) / 2))

		arg_12_0._filterWidgets[iter_12_0] = var_12_1
	end

	arg_12_0:createListArea()
	arg_12_0:createBottomArea()

	function arg_12_0._form.showTab(arg_14_0, arg_14_1)
		arg_12_0._form._tabArea:showTab(arg_14_1)

		if arg_14_1 == 1 then
			arg_12_0._selectType = Data.CardType.monster
		elseif arg_14_1 == 2 then
			arg_12_0._selectType = Data.CardType.magic
		elseif arg_14_1 == 3 then
			arg_12_0._selectType = Data.CardType.trap
		end

		for iter_14_0 = 1, 3 do
			arg_12_0._filterWidgets[iter_14_0]:setVisible(iter_14_0 == arg_14_1)
		end

		arg_12_0._filterWidget = arg_12_0._filterWidgets[arg_14_1]

		arg_12_0:updateCardList()
	end

	arg_12_0._form:showTab(1)
end

function var_0_0.initPalaceForm(arg_15_0, arg_15_1)
	var_0_0.super.init(arg_15_0, var_0_6, Str(STR.SELECT_RECOMMEND_HERO), var_0_7)

	arg_15_0._mode = var_0_0.MODE_PALACE
	arg_15_0._selectCards = arg_15_1
	arg_15_0._selectType = Data.CardType.monster
	arg_15_0._filterWidget = var_0_2.create(var_0_2.ModeType.monster, lc.w(arg_15_0._form) - var_0_0.FRAME_THICK_LEFT - var_0_0.FRAME_THICK_RIGHT - 24)

	arg_15_0._filterWidget:resetAllFilter()
	arg_15_0._filterWidget:registerSortFilterHandler(function()
		arg_15_0:updateCardList()
	end)
	lc.addChildToPos(arg_15_0._form, arg_15_0._filterWidget, cc.p(lc.w(arg_15_0._form) / 2, lc.y(arg_15_0._frameTopBg)))
	arg_15_0:createListArea()
	arg_15_0:createBottomArea()
end

function var_0_0.initHireForm(arg_17_0, arg_17_1, arg_17_2)
	var_0_0.super.init(arg_17_0, var_0_6, Str(STR.SELECT_HIRE_HERO), var_0_7)

	arg_17_0._mode = var_0_0.MODE_HIRE
	arg_17_0._hireCards = arg_17_1
	arg_17_0._selectCards = {
		arg_17_2
	}
	arg_17_0._selectType = Data.CardType.monster

	local var_17_0 = var_0_2.create(var_0_2.ModeType.monster, lc.w(arg_17_0._form) - var_0_0.FRAME_THICK_LEFT - var_0_0.FRAME_THICK_RIGHT - 24)

	var_17_0:resetAllFilter()
	var_17_0:registerSortFilterHandler(function()
		arg_17_0:updateCardList()
	end)
	lc.addChildToPos(arg_17_0._form, var_17_0, cc.p(lc.w(arg_17_0._form) / 2, lc.y(arg_17_0._frameTopBg)))

	arg_17_0._filterWidget = var_17_0

	arg_17_0:createListArea()
	arg_17_0:createBottomArea()
end

function var_0_0.createBottomArea(arg_19_0)
	local var_19_0 = ClientView.createLineSprite("img_bottom_bg", lc.w(arg_19_0._cardList))

	var_19_0:setAnchorPoint(0.5, 0)
	lc.addChildToPos(arg_19_0._frame, var_19_0, cc.p(lc.w(arg_19_0._frame) / 2, ClientView.FRAME_INNER_BOTTOM - 12), -1)

	arg_19_0._bottomArea = var_19_0

	local var_19_1 = ClientView.createBMFont(ClientView.BMFont.huali_26, "")

	var_19_1:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_19_0, var_19_1, cc.p(20, lc.h(var_19_0) / 2))

	arg_19_0._info = var_19_1

	local var_19_2 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		if arg_19_0._cardList:getSelectedCardNumber() <= 6 then
			arg_19_0:onConfirmSelected()
		end
	end, ClientView.CRECT_BUTTON, 100, ClientView.CRECT_BUTTON_S.height)

	var_19_2:setDisabledShader(ClientView.SHADER_DISABLE)
	var_19_2:addLabel(Str(STR.OK))
	lc.addChildToPos(arg_19_0._bottomArea, var_19_2, cc.p(lc.w(arg_19_0._bottomArea) - lc.w(var_19_2) / 2 - 20, lc.h(arg_19_0._bottomArea) / 2))
	var_19_2:setEnabled(false)

	arg_19_0._btnConfirm = var_19_2

	if arg_19_0._mode == var_0_0.MODE_SWALLOW then
		local var_19_3 = ClientView.createShaderButton("img_btn_1", function(arg_21_0)
			arg_19_0._cardList:selectAllCards()
		end)

		var_19_3:addLabel(Str(STR.SELECT_ALL))
		lc.addChildToPos(arg_19_0._form, var_19_3, cc.p(lc.w(var_19_3) / 2 + var_0_0.FRAME_THICK_LEFT + 12, lc.y(var_19_2)))

		local var_19_4 = ClientView.createShaderButton("img_btn_1", function(arg_22_0)
			arg_19_0._cardList:unselectAllCards()
		end)

		var_19_4:addLabel(Str(STR.UNSELECT_ALL))
		lc.addChildToPos(arg_19_0._form, var_19_4, cc.p(lc.right(var_19_3) + lc.w(var_19_4) / 2 + 10, lc.y(var_19_2)))

		local var_19_5
		local var_19_6, var_19_7 = ClientView.createKeyValueLabel(Str(STR.SELECTED), "0", ClientView.FontSize.S1, true)

		arg_19_0._cardNumValue = var_19_7

		var_19_6:addToParent(arg_19_0._form, cc.p(lc.right(var_19_4) + 280, lc.y(var_19_4)))
	elseif arg_19_0._mode == var_0_0.MODE_GUARD and GuideManager.isGuideEnabled() then
		local var_19_8 = ClientView.createTTF(Str(STR.CHECK_SELECT_HERO), ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)

		lc.addChildToPos(arg_19_0._form, var_19_8, cc.p(lc.w(arg_19_0._form) / 2, lc.y(var_19_2)))
	end
end

function var_0_0.createListArea(arg_23_0)
	local var_23_0 = var_0_1.create(cc.size(lc.w(arg_23_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_23_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - var_0_5), var_0_4)
	local var_23_1 = arg_23_0._mode

	var_23_0:setAnchorPoint(0.5, 0.5)

	arg_23_0._cardList = var_23_0

	if var_23_1 == var_0_0.MODE_EQUIP or var_23_1 == var_0_0.MODE_GUARD or var_23_1 == var_0_0.MODE_EQUIP2HERO or var_23_1 == var_0_0.MODE_HIRE then
		var_23_0:setMode(var_0_1.ModeType.radio)
	elseif var_23_1 == var_0_0.MODE_TRANSFER then
		var_23_0:setMode(var_0_1.ModeType.multi_select)
	elseif var_23_1 == var_0_0.MODE_RARE_COMPOSE then
		var_23_0._rareCards = arg_23_0._cards

		var_23_0:setMode(var_0_1.ModeType.multi_select)
	else
		var_23_0:setMode(var_0_1.ModeType.check)
	end

	var_23_0:setPosition(lc.w(arg_23_0._frame) / 2, lc.h(arg_23_0._frame) / 2 + var_0_5 / 2)
	var_23_0:registerCardSelectedHandler(function(arg_24_0)
		var_0_3.create(arg_24_0, nil, var_0_3.OperateType.own):show()
	end)
	var_23_0:registerCardSelectCountChangeHandler(function(arg_25_0)
		arg_23_0:onCardSelectCountChange()
	end)
	arg_23_0._form:addChild(var_23_0)

	local var_23_2 = (lc.w(arg_23_0._frame) - lc.w(arg_23_0._cardList)) / 2 + 16

	arg_23_0._cardList._pageLeft._pos = cc.p(-var_23_2, 26)
	arg_23_0._cardList._pageRight._pos = cc.p(lc.w(arg_23_0._cardList) + var_23_2, 26)

	local var_23_3 = var_23_2 + 32
	local var_23_4 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_23_0._frame, var_23_4, cc.p(-lc.w(var_23_4) / 2 + 12, 40), -1)

	arg_23_0._pageBg = var_23_4

	arg_23_0._cardList._pageLabel:setPosition(-var_23_3, -68)
	arg_23_0:updateCardList()
end

function var_0_0.updateCardList(arg_26_0)
	local var_26_0 = {}
	local var_26_1

	if arg_26_0._filterWidget then
		local var_26_2, var_26_3 = arg_26_0._filterWidget:getSortFunc()

		if var_26_2 ~= nil then
			var_26_1 = {
				_func = var_26_2,
				_isReverse = not var_26_3
			}
		end

		local var_26_4, var_26_5 = arg_26_0._filterWidget:getFilterNatureFunc()

		if var_26_4 ~= nil then
			var_26_0[var_0_1.FilterType.country] = {
				_func = var_26_4,
				_keyVal = var_26_5
			}
		end

		local var_26_6, var_26_7 = arg_26_0._filterWidget:getFilterCategoryFunc()

		if var_26_6 then
			var_26_0[var_0_1.FilterType.category] = {
				_func = var_26_6,
				_keyVal = var_26_7
			}
		end

		local var_26_8, var_26_9 = arg_26_0._filterWidget:getFilterLevelFunc()

		if var_26_8 then
			var_26_0[var_0_1.FilterType.cost] = {
				_func = var_26_8,
				_keyVal = var_26_9
			}
		end

		local var_26_10, var_26_11 = arg_26_0._filterWidget:getFilterQualityFunc()

		if var_26_10 ~= nil then
			var_26_0[var_0_1.FilterType.quality] = {
				_func = var_26_10,
				_keyVal = var_26_11
			}
		end

		local var_26_12, var_26_13 = arg_26_0._filterWidget:getFilterMagicOptionFunc()

		if var_26_12 then
			var_26_0[var_0_1.FilterType.option] = {
				_func = var_26_12,
				_keyVal = var_26_13
			}
		end

		local var_26_14, var_26_15 = arg_26_0._filterWidget:getFilterTrapOptionFunc()

		if var_26_14 then
			var_26_0[var_0_1.FilterType.option] = {
				_func = var_26_14,
				_keyVal = var_26_15
			}
		end

		local var_26_16, var_26_17 = arg_26_0._filterWidget:getFilterSearchFunc()

		if var_26_16 ~= nil then
			var_26_0[var_0_1.FilterType.search] = {
				_func = var_26_16,
				_keyVal = var_26_17
			}
		end
	end

	local var_26_18 = P._playerCard:getCards(arg_26_0._selectType)

	if arg_26_0._mode == var_0_0.MODE_RARE_COMPOSE then
		var_26_18 = arg_26_0._cards
	end

	local var_26_19 = {}

	for iter_26_0, iter_26_1 in pairs(var_26_18) do
		if arg_26_0._mode == var_0_0.MODE_GUARD then
			if not Data.isGuardable(iter_26_1) then
				var_26_19[iter_26_0] = iter_26_1
			end
		elseif arg_26_0._mode == var_0_0.MODE_PALACE then
			if iter_26_1._taskId then
				var_26_19[iter_26_0] = iter_26_1
			end
		elseif arg_26_0._mode == var_0_0.MODE_SWALLOW then
			if iter_26_1 == arg_26_0._exceptCard or not iter_26_1:isSwallowable() then
				var_26_19[iter_26_0] = iter_26_1
			end
		elseif arg_26_0._mode == var_0_0.MODE_HIRE then
			for iter_26_2, iter_26_3 in ipairs(arg_26_0._hireCards) do
				if iter_26_1._infoId == iter_26_3._infoId then
					var_26_19[iter_26_0] = iter_26_1

					break
				end
			end
		elseif arg_26_0._mode == var_0_0.MODE_TRANSFER then
			for iter_26_4 = 1, #arg_26_0._exceptCards do
				if iter_26_1 == arg_26_0._exceptCards[iter_26_4] then
					var_26_19[iter_26_0] = iter_26_1
				end
			end
		end
	end

	arg_26_0._cardList:init(arg_26_0._selectType, var_26_19, var_26_1, var_26_0, arg_26_0._selectCards)
	arg_26_0._cardList:refresh(true)
end

function var_0_0.onEnter(arg_27_0)
	var_0_0.super.onEnter(arg_27_0)

	arg_27_0._listeners = {}

	local var_27_0 = lc.addEventListener(Data.Event.card_select, function(arg_28_0)
		arg_27_0:updateView()
	end)

	table.insert(arg_27_0._listeners, var_27_0)

	local var_27_1 = lc.addEventListener(GuideManager.Event.seek, function(arg_29_0)
		arg_27_0:onGuide(arg_29_0)
	end)

	table.insert(arg_27_0._listeners, var_27_1)
	arg_27_0:updateView()
end

function var_0_0.onExit(arg_30_0)
	var_0_0.super.onExit(arg_30_0)

	for iter_30_0 = 1, #arg_30_0._listeners do
		lc.Dispatcher:removeEventListener(arg_30_0._listeners[iter_30_0])
	end
end

function var_0_0.onShowActionFinished(arg_31_0)
	if GuideManager.isGuideEnabled() then
		GuideManager.finishStep()
	end
end

function var_0_0.onHideActionFinished(arg_32_0)
	if GuideManager.isGuideEnabled() then
		GuideManager.finishStep()
	end
end

function var_0_0.onConfirmSelected(arg_33_0)
	if arg_33_0._selectRadioHandler ~= nil then
		local var_33_0

		for iter_33_0, iter_33_1 in pairs(arg_33_0._selectCards) do
			var_33_0 = iter_33_0
		end

		arg_33_0._selectRadioHandler(var_33_0)
	end

	if arg_33_0._selectHandler ~= nil then
		arg_33_0._selectHandler(arg_33_0._selectCards)
	end

	arg_33_0:hide()
end

function var_0_0.updateView(arg_34_0)
	arg_34_0._selectCount = 0

	for iter_34_0, iter_34_1 in pairs(arg_34_0._selectCards) do
		arg_34_0._selectCount = arg_34_0._selectCount + iter_34_1
	end

	if arg_34_0._cardNumValue ~= nil then
		arg_34_0._cardNumValue:setString(arg_34_0._selectCount)
	end
end

function var_0_0.registerRadioSelectedHandler(arg_35_0, arg_35_1)
	arg_35_0._selectRadioHandler = arg_35_1
end

function var_0_0.registerSelectedHandler(arg_36_0, arg_36_1)
	arg_36_0._selectHandler = arg_36_1
end

function var_0_0.onGuide(arg_37_0, arg_37_1)
	if GuideManager.getCurStepName() == "confirm pick card" then
		GuideManager.setOperateLayer(arg_37_0._btnConfirm)
	else
		return
	end

	arg_37_1:stopPropagation()
end

function var_0_0.onCardSelectCountChange(arg_38_0)
	arg_38_0:updateSelectCount()
end

function var_0_0.updateSelectCount(arg_39_0)
	local var_39_0 = arg_39_0._cardList:getSelectedCardNumber()

	arg_39_0._info:setString(string.format(Str(STR.SELECT_MULTI_NEED), 6) .. Str(STR.COMMA) .. string.format(Str(STR.SELECT_MULTI_CURRENT), var_39_0))
	arg_39_0._btnConfirm:setEnabled(var_39_0 <= 6)
end

return var_0_0
