local var_0_0 = class("IllustrationForm", BaseForm)
local var_0_1 = require("FilterWidget")
local var_0_2 = require("CardInfoPanel")
local var_0_3 = 30
local var_0_4 = 100
local var_0_5 = 100
local var_0_6 = 26

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local var_2_0 = lc.Director:getVisibleSize()

	var_0_0.super.init(arg_2_0, cc.size(var_2_0.width - (16 + ClientView.FRAME_TAB_WIDTH + ClientView.SCR_EDGE) * 2, 680), Str(STR.ILLUSTRATION), bor(0), true)
	arg_2_0._form:setTouchEnabled(false)
	arg_2_0:createCardArea()

	if arg_2_1 == nil or type(arg_2_1) == "number" then
		ClientView.addVerticalTabButtons(arg_2_0._form, {
			Str(STR.MONSTER),
			Str(STR.MAGIC),
			Str(STR.TRAP),
			Str(STR.RARE) .. Str(STR.MONSTER)
		}, lc.top(arg_2_0._frame) - 80, lc.left(arg_2_0._frame) - 124, 480)
		arg_2_0:createFilters()
	else
		local var_2_1 = ClientView.createBoldRichText(string.format(Str(STR.DISPLAY_CARDS_WITH_SKILL), arg_2_1), {
			_fontSize = ClientView.FontSize.S1,
			_normalClr = ClientView.COLOR_LABEL_DARK,
			_boldClr = ClientView.COLOR_TEXT_GREEN_DARK
		})

		lc.addChildToPos(arg_2_0._frame, var_2_1, cc.p(lc.w(arg_2_0._frame) / 2, lc.h(arg_2_0._frame) - lc.h(var_2_1) / 2 - 20))

		arg_2_0._searchKey = arg_2_1

		arg_2_0:updateCardList()
	end

	function arg_2_0._form.showTab(arg_3_0, arg_3_1)
		arg_2_0._form._tabArea:showTab(arg_3_1)
		arg_2_0:updateCardList()

		for iter_3_0, iter_3_1 in ipairs(arg_2_0._filters) do
			iter_3_1:setVisible(false)
		end

		arg_2_0._filters[arg_3_1]:setVisible(true)

		return true
	end

	arg_2_0._form:showTab(1)

	var_0_2._operateType = var_0_2.OperateType.view
end

function var_0_0.onCleanup(arg_4_0)
	var_0_0.super.onCleanup(arg_4_0)

	var_0_2._operateType = var_0_2.OperateType.na
end

function var_0_0.createFilters(arg_5_0)
	local function var_5_0(arg_6_0)
		return var_0_1.create(var_0_1.ModeType[arg_6_0] + var_0_1.ModeType.illustration, lc.h(arg_5_0._frame) - 80)
	end

	local var_5_1 = var_5_0("monster")

	var_5_1:setFilterNature(var_0_1.FilterNature.all)
	var_5_1:setFilterLevel(var_0_1.FilterLevel.all)
	var_5_1:setFilterCategory(var_0_1.FilterCategory.all)
	var_5_1:setSort(var_0_1.SortType.infoId)

	local var_5_2 = var_5_0("rare")

	var_5_2:setFilterNature(var_0_1.FilterNature.all)
	var_5_2:setFilterLevel(var_0_1.FilterLevel.all)
	var_5_2:setFilterCategory(var_0_1.FilterCategory.all)
	var_5_2:setSort(var_0_1.SortType.infoId)

	arg_5_0._filters = {
		var_5_1,
		var_5_0("magic"),
		var_5_0("trap"),
		var_5_2
	}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._filters) do
		iter_5_1:setFilterQuality(var_0_1.FilterQuality.all)
		iter_5_1:setSort(var_0_1.SortType.infoId)
		iter_5_1:setVisible(false)
		iter_5_1:registerSortFilterHandler(function()
			arg_5_0:updateCardList()
		end)
		lc.addChildToPos(arg_5_0._frame, iter_5_1, cc.p(lc.w(arg_5_0._frame) + ClientView.FRAME_TAB_WIDTH - lc.w(iter_5_1) / 2 + 2, lc.h(iter_5_1) / 2))
	end
end

function var_0_0.createCardArea(arg_8_0)
	local var_8_0 = lc.w(arg_8_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT
	local var_8_1 = lc.h(arg_8_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM
	local var_8_2 = lc.List.createV(cc.size(var_8_0, var_8_1), 10, 10)

	var_8_2:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_8_0._frame, var_8_2)

	arg_8_0._list = var_8_2
	arg_8_0._cardCountInRow = math.floor(lc.w(var_8_2) / (var_0_5 + var_0_6))
	arg_8_0._data = {
		{},
		{},
		{},
		{}
	}

	local var_8_3 = arg_8_0._data[1]

	for iter_8_0, iter_8_1 in pairs(Data._monsterInfo) do
		if Data.isUserVisible(iter_8_0) then
			var_8_3[#var_8_3 + 1] = iter_8_1
		end
	end

	table.sort(var_8_3, function(arg_9_0, arg_9_1)
		return arg_9_0._id < arg_9_1._id
	end)

	local var_8_4 = arg_8_0._data[2]

	for iter_8_2, iter_8_3 in pairs(Data._magicInfo) do
		if Data.isUserVisible(iter_8_2) then
			var_8_4[#var_8_4 + 1] = iter_8_3
		end
	end

	table.sort(var_8_4, function(arg_10_0, arg_10_1)
		return arg_10_0._id < arg_10_1._id
	end)

	local var_8_5 = arg_8_0._data[3]

	for iter_8_4, iter_8_5 in pairs(Data._trapInfo) do
		if Data.isUserVisible(iter_8_4) then
			var_8_5[#var_8_5 + 1] = iter_8_5
		end
	end

	table.sort(var_8_5, function(arg_11_0, arg_11_1)
		return arg_11_0._id < arg_11_1._id
	end)

	local var_8_6 = arg_8_0._data[4]

	for iter_8_6, iter_8_7 in pairs(Data._rareInfo) do
		if Data.isUserVisible(iter_8_6) then
			var_8_6[#var_8_6 + 1] = iter_8_7
		end
	end

	table.sort(var_8_6, function(arg_12_0, arg_12_1)
		return arg_12_0._id < arg_12_1._id
	end)
end

function var_0_0.updateCardList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if arg_13_0._searchKey then
		local function var_13_1(arg_14_0)
			table.insert(var_13_0, var_0_4 + arg_14_0)

			local var_14_0 = ClientData._player:filterBySearch(arg_13_0._data[arg_14_0], arg_13_0._searchKey)
			local var_14_1 = {}

			for iter_14_0, iter_14_1 in ipairs(var_14_0) do
				table.insert(var_14_1, iter_14_1)

				if #var_14_1 == arg_13_0._cardCountInRow then
					table.insert(var_13_0, var_14_1)

					var_14_1 = {}
				end
			end

			if #var_14_1 > 0 then
				table.insert(var_13_0, var_14_1)
			end

			if type(var_13_0[#var_13_0]) == "number" then
				table.remove(var_13_0)
			end
		end

		var_13_1(1)
		var_13_1(2)
		var_13_1(3)
		var_13_1(4)
	else
		local var_13_2 = arg_13_0._form._tabArea._focusTabIndex
		local var_13_3 = arg_13_0._data[var_13_2]
		local var_13_4 = arg_13_0._filters[var_13_2]
		local var_13_5 = ClientData._player

		if Data.BaseCardTypes[var_13_2] == Data.CardType.monster or Data.BaseCardTypes[var_13_2] == Data.CardType.rare then
			local var_13_6, var_13_7 = var_13_4:getFilterNatureFunc()

			if var_13_6 then
				var_13_3 = var_13_6(var_13_5, var_13_3, var_13_7)
			end

			local var_13_8, var_13_9 = var_13_4:getFilterLevelFunc()

			if var_13_8 then
				var_13_3 = var_13_8(var_13_5, var_13_3, var_13_9)
			end

			local var_13_10, var_13_11 = var_13_4:getFilterCategoryFunc()

			if var_13_10 then
				var_13_3 = var_13_10(var_13_5, var_13_3, var_13_11)
			end
		end

		if Data.BaseCardTypes[var_13_2] == Data.CardType.monster then
			local var_13_12, var_13_13 = var_13_4:getFilterMonsterOptionFunc()

			if var_13_12 then
				var_13_3 = var_13_12(var_13_5, var_13_3, var_13_13)
			end
		elseif Data.BaseCardTypes[var_13_2] == Data.CardType.magic then
			local var_13_14, var_13_15 = var_13_4:getFilterMagicOptionFunc()

			if var_13_14 then
				var_13_3 = var_13_14(var_13_5, var_13_3, var_13_15)
			end
		elseif Data.BaseCardTypes[var_13_2] == Data.CardType.trap then
			local var_13_16, var_13_17 = var_13_4:getFilterTrapOptionFunc()

			if var_13_16 then
				var_13_3 = var_13_16(var_13_5, var_13_3, var_13_17)
			end
		elseif Data.BaseCardTypes[var_13_2] == Data.CardType.rare then
			local var_13_18, var_13_19 = var_13_4:getFilterRareOptionFunc()

			if var_13_18 then
				var_13_3 = var_13_18(var_13_5, var_13_3, var_13_19)
			end
		end

		local var_13_20, var_13_21 = var_13_4:getFilterCollectFunc()

		if var_13_20 then
			var_13_3 = var_13_20(var_13_5, var_13_3, var_13_21)
		end

		local var_13_22, var_13_23 = var_13_4:getFilterSearchFunc()

		if var_13_22 then
			var_13_3 = var_13_22(var_13_5, var_13_3, var_13_23)
		end

		local var_13_24, var_13_25 = var_13_4:getSortFunc()

		for iter_13_0 = Data.CardQuality.HR, Data.CardQuality.N, -1 do
			local var_13_27 = {}

			for iter_13_1, iter_13_2 in ipairs(var_13_3) do
				if iter_13_2._quality == iter_13_0 then
					table.insert(var_13_27, iter_13_2)
				end
			end

			if #var_13_27 > 0 then
				table.insert(var_13_0, iter_13_0)

				table.sort(var_13_27, function(a, b)
					local aid = a._infoId or a._id or 0
					local bid = b._infoId or b._id or 0
					return aid < bid
				end)

				local var_13_26 = {}
				for iter_13_3, iter_13_4 in ipairs(var_13_27) do
					table.insert(var_13_26, iter_13_4)

					if #var_13_26 == arg_13_0._cardCountInRow then
						table.insert(var_13_0, var_13_26)
						var_13_26 = {}
					end
				end

				if #var_13_26 > 0 then
					table.insert(var_13_0, var_13_26)
				end
			end
		end
	end

	local var_13_28 = arg_13_0._list

	var_13_28:bindData(var_13_0, function(arg_15_0, arg_15_1)
		arg_13_0:setOrCreateItem(arg_15_0, arg_15_1)
	end, math.min(8, #var_13_0), 1)

	for iter_13_5 = 1, var_13_28._cacheCount do
		local var_13_29 = var_13_0[iter_13_5]
		local var_13_30 = arg_13_0:setOrCreateItem(nil, var_13_29)

		var_13_28:pushBackCustomItem(var_13_30)
	end

	var_13_28:jumpToTop()
end

function var_0_0.setOrCreateItem(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == nil then
		arg_16_1 = ccui.Widget:create()
	end

	arg_16_1:removeAllChildren()

	if type(arg_16_2) == "number" then
		local var_16_0 = {
			Str(STR.MONSTER),
			Str(STR.MAGIC),
			Str(STR.TRAP),
			Str(STR.RARE) .. Str(STR.MONSTER)
		}
		local var_16_1 = lc.createSprite({
			_name = "img_title_decoration",
			_crect = ClientView.CRECT_LABEL_DECORATION,
			_size = cc.size(lc.w(arg_16_0._list), ClientView.CRECT_LABEL_DECORATION.height)
		})

		if arg_16_2 < var_0_4 then
			local var_16_2 = arg_16_2
			local var_16_3, var_16_4 = ClientView.getCardQualityStrColor(var_16_2)
			local var_16_5 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_16_3 .. var_16_0[arg_16_0._form._tabArea._focusTabIndex])

			var_16_5:setColor(var_16_4)
			lc.addChildToPos(var_16_1, var_16_5, cc.p(lc.w(var_16_1) / 2, lc.h(var_16_1) / 2 + 2))
		else
			local var_16_6 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_16_0[arg_16_2 - var_0_4])

			lc.addChildToCenter(var_16_1, var_16_6)
		end

		arg_16_1:setContentSize(lc.w(arg_16_0._list), 80)
		lc.addChildToCenter(arg_16_1, var_16_1)
	else
		local var_16_7 = (var_0_5 + var_0_6) * arg_16_0._cardCountInRow - var_0_6

		arg_16_1:setContentSize(var_16_7, 130)

		local var_16_8 = ClientData._player._playerCard._levels
		local var_16_9 = cc.p(var_0_5 / 2, lc.h(arg_16_1) / 2)

		for iter_16_0, iter_16_1 in ipairs(arg_16_2) do
			local var_16_10 = IconWidget.create({
				_infoId = iter_16_1._id
			})

			var_16_10:setGray(not var_16_8[iter_16_1._id])
			var_16_10._name:setColor(ClientView.COLOR_BMFONT)
			lc.addChildToPos(arg_16_1, var_16_10, var_16_9)

			var_16_9.x = var_16_9.x + var_0_5 + var_0_6
		end
	end

	return arg_16_1
end

return var_0_0
