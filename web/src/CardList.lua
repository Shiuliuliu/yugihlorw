local var_0_0 = class("CardList", lc.ExtendUIWidget)

var_0_0.ModeType = {
	hire = 9,
	sacrifice = 1,
	vote_shop = 23,
	recruite_langend = 12,
	mix_book = 5,
	union_shop = 14,
	dark_troop = 19,
	card_operate = 21,
	multi_select = 10,
	diamond_shop = 18,
	recruite = 11,
	room_dark_troop = 20,
	effect_store = 22,
	collect_shop = 25,
	vote_recovery = 24,
	check = 4,
	rare_shop = 15,
	expedition_troop = 8,
	exchange = 6,
	recruite_list = 13,
	mix = 2,
	union_battle_troop = 17,
	troop = 7,
	god_shop = 16,
	radio = 3
}
var_0_0.FilterType = {
	cost = 7,
	quality = 3,
	category = 5,
	status = 5,
	country = 1,
	equip = 2,
	search = 6,
	collect = 9,
	option = 8
}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setTouchEnabled(not GuideManager.isGuideEnabled())
	var_1_0:setContentSize(arg_1_0)
	var_1_0:setCascadeOpacityEnabled(true)

	var_1_0._itemScale = arg_1_1 or 1
	var_1_0._hideBottom = arg_1_2
	var_1_0._addH = arg_1_3
	var_1_0._tip = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S1)

	var_1_0._tip:setPosition(lc.w(var_1_0) / 2, lc.h(var_1_0) / 2)
	var_1_0:addProtectedChild(var_1_0._tip)
	var_1_0:initUI()

	return var_1_0
end

function var_0_0.initUI(arg_2_0)
	local var_2_0 = (arg_2_0._hideBottom and 0 or 50) + (arg_2_0._addH and arg_2_0._addH or 0)
	local var_2_1 = ClientView.CARD_SIZE.width * arg_2_0._itemScale
	local var_2_2 = (ClientView.CARD_SIZE.height + var_2_0) * arg_2_0._itemScale
	local var_2_3 = math.min(3, math.floor(lc.h(arg_2_0) / (var_2_2 + 0)))
	local var_2_4 = 5
	local var_2_5 = math.max(1, var_2_3)
	local var_2_6 = (lc.h(arg_2_0) - var_2_5 * var_2_2) / (var_2_5 + 1)
	local var_2_7 = (lc.w(arg_2_0) - var_2_4 * var_2_1) / (var_2_4 + 1)

	if var_2_7 < 10 then
		var_2_4 = 4
		var_2_7 = (lc.w(arg_2_0) - var_2_4 * var_2_1) / (var_2_4 + 1)
	end

	local var_2_8 = var_2_7 + var_2_1 / 2
	local var_2_9 = var_2_6 + var_2_2 / 2 + var_2_0 * arg_2_0._itemScale / 2

	arg_2_0._itemRow, arg_2_0._itemCol = var_2_5, var_2_4
	arg_2_0._curPage = 1
	arg_2_0._totalPage = 1
	arg_2_0._items = {}

	for iter_2_0 = 1, var_2_5 do
		arg_2_0._items[iter_2_0] = {}

		for iter_2_1 = 1, var_2_4 do
			local var_2_10 = require("CardThumbnail").createFromPool(nil, arg_2_0._itemScale)
			local var_2_11 = var_2_10._thumbnail

			var_2_11._infoId = nil
			var_2_11._index = (iter_2_0 - 1) * var_2_4 + iter_2_1

			var_2_11:setTouchEnabled(true)
			var_2_11:addTouchEventListener(function(arg_3_0, arg_3_1)
				arg_2_0:onTouchThumbnail(arg_3_0, arg_3_1)
			end)
			var_2_10:setVisible(false)
			lc.addChildToPos(arg_2_0, var_2_10, cc.p(var_2_8 + (iter_2_1 - 1) * (var_2_1 + var_2_7), var_2_9 + (var_2_5 - iter_2_0) * (var_2_2 + var_2_6)))

			arg_2_0._items[iter_2_0][iter_2_1] = var_2_10
		end
	end

	local var_2_12 = cc.p(arg_2_0._items[1][1]:getPositionX() - ClientView.CARD_SIZE.width / 2 - 10, lc.h(arg_2_0) / 2)

	arg_2_0._pageLeft = ClientView.createPageArrow(true, var_2_12, function()
		if arg_2_0._curPage > 1 then
			arg_2_0._curPage = arg_2_0._curPage - 1
		end

		arg_2_0:refresh(false)
	end)

	lc.addChildToPos(arg_2_0, arg_2_0._pageLeft, var_2_12)

	local var_2_13 = cc.p(arg_2_0._items[1][arg_2_0._itemCol]:getPositionX() + ClientView.CARD_SIZE.width / 2 + 10, lc.h(arg_2_0) / 2)

	arg_2_0._pageRight = ClientView.createPageArrow(false, var_2_13, function()
		if arg_2_0._curPage < arg_2_0._totalPage then
			arg_2_0._curPage = arg_2_0._curPage + 1
		end

		arg_2_0:refresh(false)
	end)

	lc.addChildToPos(arg_2_0, arg_2_0._pageRight, var_2_13)

	local var_2_14 = ClientView.createBMFont(ClientView.BMFont.huali_26, "1/1")

	-- "Trang 1/1" is half again as wide as the 第1/1页 this plate was drawn
	-- for, and the plate sits hard against the edge of the panel.
	var_2_14:setScale(0.8)

	lc.addChildToPos(arg_2_0, var_2_14, cc.p(lc.w(arg_2_0) - 64, lc.h(arg_2_0) + 20))

	arg_2_0._pageLabel = var_2_14
end

function var_0_0.init(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_0._type = arg_6_1
	arg_6_0._excepts = arg_6_2

	if arg_6_3 then
		arg_6_0:setSortFunc(arg_6_3._func, arg_6_3._isReverse, false)
	else
		arg_6_0._sort = nil
	end

	arg_6_0._filters = {}

	if arg_6_4 then
		for iter_6_0, iter_6_1 in pairs(arg_6_4) do
			arg_6_0:setFilterFunc(iter_6_0, iter_6_1._func, iter_6_1._keyVal, false)
		end
	end

	arg_6_0._selectedCards = arg_6_5 or {}
end

function var_0_0.onEnter(arg_7_0)
	arg_7_0._listeners = {}

	local var_7_0 = lc.addEventListener(Data.Event.card_list_dirty, function(arg_8_0)
		if arg_7_0._type == arg_8_0._type then
			arg_7_0:refresh(false)
		end
	end)
	local var_7_1 = lc.addEventListener(Data.Event.card_skill_dirty, function(arg_9_0)
		if arg_7_0._type == Data.CardType.monster then
			arg_7_0:refresh(false)
		end
	end)

	table.insert(arg_7_0._listeners, var_7_1)

	local var_7_2 = lc.addEventListener(Data.Event.card_dirty, function(arg_10_0)
		for iter_10_0 = 1, arg_7_0._itemRow do
			for iter_10_1 = 1, arg_7_0._itemCol do
				local var_10_0 = arg_7_0._items[iter_10_0][iter_10_1]

				if arg_10_0._infoId and var_10_0._thumbnail._infoId and select(1, Data.removeAdditional(var_10_0._thumbnail._infoId)) == select(1, Data.removeAdditional(arg_10_0._infoId)) then
					arg_7_0:refreshItem(var_10_0, var_10_0._thumbnail._infoId)
				end
			end
		end
	end)

	table.insert(arg_7_0._listeners, var_7_2)

	local var_7_3 = lc.addEventListener(GuideManager.Event.seek, function(arg_11_0)
		arg_7_0:onGuide(arg_11_0)
	end)

	table.insert(arg_7_0._listeners, var_7_3)
end

function var_0_0.onExit(arg_12_0)
	for iter_12_0 = 1, #arg_12_0._listeners do
		lc.Dispatcher:removeEventListener(arg_12_0._listeners[iter_12_0])
	end

	arg_12_0._listeners = {}
end

function var_0_0.onCleanup(arg_13_0)
	for iter_13_0 = 1, arg_13_0._itemRow do
		for iter_13_1 = 1, arg_13_0._itemCol do
			local var_13_0 = arg_13_0._items[iter_13_0][iter_13_1]

			require("CardThumbnail").releaseToPool(var_13_0)
		end
	end
end

function var_0_0.getThumbnail(arg_14_0, arg_14_1)
	for iter_14_0 = 1, arg_14_0._itemRow do
		for iter_14_1 = 1, arg_14_0._itemCol do
			local var_14_0 = arg_14_0._items[iter_14_0][iter_14_1]

			if var_14_0 and var_14_0._thumbnail._infoId == arg_14_1 then
				return var_14_0._thumbnail
			end
		end
	end
end

function var_0_0.insertItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_2

	if var_15_0 == nil or var_15_0 <= 0 then
		var_15_0 = #arg_15_0._cards + 1
	end

	table.insert(arg_15_0._cards, var_15_0, arg_15_1)
end

function var_0_0.onTouchThumbnail(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:stopAllActions()

	if arg_16_2 == ccui.TouchEventType.began then
		arg_16_1:runAction(cc.ScaleTo:create(0.1, 0.95))

		if arg_16_0._onTouchThumbnail ~= nil then
			arg_16_0._onTouchThumbnail(arg_16_1, arg_16_2)
		end
	elseif arg_16_2 == ccui.TouchEventType.ended then
		arg_16_1:runAction(cc.ScaleTo:create(0.08, 1))

		if arg_16_0._onTouchThumbnail ~= nil then
			arg_16_0._onTouchThumbnail(arg_16_1, arg_16_2)
		end

		if arg_16_0._onCardSelected ~= nil then
			arg_16_0._onCardSelected(arg_16_1._infoId, arg_16_1._index)
		end
	elseif arg_16_2 == ccui.TouchEventType.moved then
		if arg_16_0._onTouchThumbnail ~= nil then
			arg_16_0._onTouchThumbnail(arg_16_1, arg_16_2)
		end
	elseif arg_16_2 == ccui.TouchEventType.canceled then
		arg_16_1:runAction(cc.ScaleTo:create(0.08, 1))

		if arg_16_0._onTouchThumbnail ~= nil then
			arg_16_0._onTouchThumbnail(arg_16_1, arg_16_2)
		end
	end
end

function var_0_0.registerCardSelectedHandler(arg_17_0, arg_17_1)
	arg_17_0._onCardSelected = arg_17_1
end

function var_0_0.registerTouchThumbnail(arg_18_0, arg_18_1)
	arg_18_0._onTouchThumbnail = arg_18_1
end

function var_0_0.registerTapBtnCustom1(arg_19_0, arg_19_1)
	arg_19_0._onTapBtnCustom1 = arg_19_1
end

function var_0_0.registerTapRadio(arg_20_0, arg_20_1)
	arg_20_0._onTapRadio = arg_20_1
end

function var_0_0.registerTapCheck(arg_21_0, arg_21_1)
	arg_21_0._onTapCheck = arg_21_1
end

function var_0_0.registerCardSelectCountChangeHandler(arg_22_0, arg_22_1)
	arg_22_0._onCardSelectCountChange = arg_22_1
end

function var_0_0.setMode(arg_23_0, arg_23_1)
	if arg_23_0._mode then
		return
	end

	arg_23_0._mode = arg_23_1
end

function var_0_0.setSortFunc(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._sort = {
		_func = arg_24_1,
		_isReverse = arg_24_2
	}
end

function var_0_0.setFilterFunc(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0._filters[arg_25_1] = {
		_func = arg_25_2,
		_keyVal = arg_25_3
	}
end

function var_0_0.refresh(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = {}
	local var_26_2 = {}
	local var_26_3 = {}

	if arg_26_0._mode == var_0_0.ModeType.hire then
		local var_26_4 = P._playerUnion:getMyUnion()._hires

		for iter_26_0, iter_26_1 in pairs(var_26_4) do
			if iter_26_1:isSelfCard() then
				table.insert(var_26_3, iter_26_1)
			elseif iter_26_1:isHired() then
				table.insert(var_26_2, iter_26_1)
			else
				table.insert(var_26_1, iter_26_1)
			end
		end
	elseif arg_26_0._mode == var_0_0.ModeType.union_shop or arg_26_0._mode == var_0_0.ModeType.rare_shop or arg_26_0._mode == var_0_0.ModeType.diamond_shop or arg_26_0._mode == var_0_0.ModeType.god_shop or arg_26_0._mode == var_0_0.ModeType.vote_shop or arg_26_0._mode == var_0_0.ModeType.vote_recovery or arg_26_0._mode == var_0_0.ModeType.collect_shop then
		for iter_26_2 = 1, #arg_26_0._shopInfo do
			local var_26_5 = arg_26_0._shopInfo[iter_26_2]._infoId or arg_26_0._shopInfo[iter_26_2]._cardId

			var_26_2[#var_26_2 + 1] = var_26_5
		end
	elseif arg_26_0._mode == var_0_0.ModeType.recruite or arg_26_0._mode == var_0_0.ModeType.recruite_langend then
		for iter_26_3 = 1, #arg_26_0._recruiteInfo do
			local var_26_6 = arg_26_0._recruiteInfo[iter_26_3]._infoId

			var_26_2[#var_26_2 + 1] = var_26_6
		end
	elseif arg_26_0._mode == var_0_0.ModeType.recruite_list then
		for iter_26_4 = 1, #arg_26_0._recruiteInfo do
			local var_26_7 = arg_26_0._recruiteInfo[iter_26_4]._infoId

			var_26_2[#var_26_2 + 1] = var_26_7
		end
	elseif arg_26_0._mode == var_0_0.ModeType.multi_select and arg_26_0._rareCards ~= nil then
		for iter_26_5 = 1, #arg_26_0._rareCards do
			local var_26_8 = {
				_infoId = arg_26_0._rareCards[iter_26_5]
			}

			var_26_8._selected = arg_26_0._selectedCards[var_26_8._infoId] or 0
			var_26_8._num = P._playerCard:getCardCount(var_26_8._infoId) - P._playerCard:getCardCountInTroop(var_26_8._infoId, true)

			local var_26_9 = arg_26_0._selectedCards

			function var_26_8.setSelected(arg_27_0, arg_27_1)
				var_26_8._selected = arg_27_1
				var_26_9[var_26_8._infoId] = arg_27_1
			end

			table.insert(var_26_2, var_26_8)
		end
	elseif arg_26_0._mode == var_0_0.ModeType.union_battle_troop then
		local var_26_10 = P._playerCard:getGroupCards(arg_26_0._type)

		for iter_26_6, iter_26_7 in pairs(var_26_10) do
			if Data.getExtraSid(iter_26_6) > 0 then
				local var_26_11
			end

			if iter_26_7 > 0 then
				table.insert(var_26_2, iter_26_6)
			end
		end
	elseif arg_26_0._mode == var_0_0.ModeType.card_operate then
		local var_26_12 = P._playerCard:getCanOperateCards(arg_26_0._type, arg_26_0._operateMode)

		for iter_26_8, iter_26_9 in ipairs(var_26_12) do
			var_26_2[#var_26_2 + 1] = iter_26_9
		end
	else
		local var_26_13 = P._playerCard:getCards(arg_26_0._type)

		for iter_26_10, iter_26_11 in pairs(var_26_13) do
			if arg_26_0._excepts == nil or arg_26_0._excepts[iter_26_10] == nil then
				repeat
					if arg_26_0._mode == var_0_0.ModeType.troop then
						if GuideManager.isGuideEnabled() then
							if arg_26_0._guideFront == nil then
								arg_26_0._guideFront = {}
							end

							if arg_26_0._guideFront[iter_26_10] == nil then
								arg_26_0._guideFront[iter_26_10] = P._playerCard:getCardFreeCount(iter_26_10) > 0
							end
						end

						if arg_26_0._guideFront and arg_26_0._guideFront[iter_26_10] == true then
							table.insert(var_26_1, iter_26_10)

							break
						end
					elseif arg_26_0._mode == var_0_0.ModeType.radio or arg_26_0._mode == var_0_0.ModeType.check then
						if arg_26_0._selectedCards[iter_26_10] then
							table.insert(var_26_0, iter_26_10)

							break
						end
					elseif arg_26_0._mode == var_0_0.ModeType.sacrifice then
						if not GuideManager.isGuideEnabled() then
							table.insert(var_26_1, iter_26_10)

							break
						end
					elseif arg_26_0._mode == var_0_0.ModeType.expedition_troop then
						-- block empty
					end

					if iter_26_11 > 0 then
						table.insert(var_26_2, iter_26_10)
					end
				until true
			end
		end
	end

	if arg_26_0._sort then
		var_26_0 = arg_26_0._sort._func(P, var_26_0, arg_26_0._sort._isReverse)
		var_26_1 = arg_26_0._sort._func(P, var_26_1, arg_26_0._sort._isReverse)
		var_26_2 = arg_26_0._sort._func(P, var_26_2, arg_26_0._sort._isReverse)
		var_26_3 = arg_26_0._sort._func(P, var_26_3, arg_26_0._sort._isReverse)
	end

	for iter_26_12, iter_26_13 in pairs(arg_26_0._filters) do
		var_26_0 = iter_26_13._func(P, var_26_0, iter_26_13._keyVal)
		var_26_1 = iter_26_13._func(P, var_26_1, iter_26_13._keyVal)
		var_26_2 = iter_26_13._func(P, var_26_2, iter_26_13._keyVal)
		var_26_3 = iter_26_13._func(P, var_26_3, iter_26_13._keyVal)
	end

	local var_26_14 = #var_26_0 + #var_26_1 + #var_26_2 + #var_26_3

	arg_26_0._cards = {}

	for iter_26_14, iter_26_15 in ipairs(var_26_0) do
		arg_26_0:insertItem(iter_26_15)
	end

	for iter_26_16, iter_26_17 in ipairs(var_26_1) do
		arg_26_0:insertItem(iter_26_17)
	end

	for iter_26_18, iter_26_19 in ipairs(var_26_2) do
		arg_26_0:insertItem(iter_26_19)
	end

	for iter_26_20, iter_26_21 in ipairs(var_26_3) do
		arg_26_0:insertItem(iter_26_21)
	end

	arg_26_0._totalPage = #arg_26_0._cards == 0 and 1 or math.floor((#arg_26_0._cards - 1) / (arg_26_0._itemRow * arg_26_0._itemCol)) + 1

	if arg_26_1 then
		arg_26_0._curPage = 1
	end

	for iter_26_22 = 1, arg_26_0._itemRow do
		for iter_26_23 = 1, arg_26_0._itemCol do
			local var_26_15 = arg_26_0._items[iter_26_22][iter_26_23]
			local var_26_16 = arg_26_0._cards[(arg_26_0._curPage - 1) * arg_26_0._itemRow * arg_26_0._itemCol + (iter_26_22 - 1) * arg_26_0._itemCol + iter_26_23]

			arg_26_0:refreshItem(var_26_15, var_26_16)
		end
	end

	arg_26_0._pageLabel:setString(string.format("%s%d/%d%s", lc.str(STR.PAGE_PREFIX), arg_26_0._curPage, arg_26_0._totalPage, lc.str(STR.PAGE_SUFFIX)))
	arg_26_0._pageLeft:setVisible(arg_26_0._curPage > 1)
	arg_26_0._pageLeft:float()
	arg_26_0._pageRight:setVisible(arg_26_0._curPage < arg_26_0._totalPage)
	arg_26_0._pageRight:float()
	arg_26_0._tip:setString("")

	if arg_26_0._mode == var_0_0.ModeType.sacrifice or arg_26_0._mode == var_0_0.ModeType.radio or arg_26_0._mode == var_0_0.ModeType.check or arg_26_0._mode == var_0_0.ModeType.multi_select and arg_26_0._rareCards == nil or arg_26_0._mode == var_0_0.ModeType.troop or arg_26_0._mode == var_0_0.ModeType.expedition_troop or arg_26_0._mode == var_0_0.ModeType.dark_troop or arg_26_0._mode == var_0_0.ModeType.room_dark_troop or arg_26_0._mode == var_0_0.ModeType.union_battle_troop or arg_26_0._mode == var_0_0.ModeType.card_operate or arg_26_0._mode == var_0_0.ModeType.effect_store then
		if var_26_14 == 0 then
			if arg_26_0._type == Data.CardType.monster then
				arg_26_0._tip:setString(string.format(Str(STR.LIST_EMPTY_NO_CARD), Str(STR.MONSTER)))
			elseif arg_26_0._type == Data.CardType.magic then
				arg_26_0._tip:setString(string.format(Str(STR.LIST_EMPTY_NO_CARD), Str(STR.MAGIC)))
			elseif arg_26_0._type == Data.CardType.trap then
				arg_26_0._tip:setString(string.format(Str(STR.LIST_EMPTY_NO_CARD), Str(STR.TRAP)))
			else
				arg_26_0._tip:setString(string.format(Str(STR.LIST_EMPTY_NO_CARD), Str(STR.RARE) .. Str(STR.MONSTER)))
			end

			arg_26_0._tip:setColor(ClientView.COLOR_LABEL_LIGHT)
		end
	elseif arg_26_0._mode == var_0_0.ModeType.multi_select and arg_26_0._rareCards ~= nil then
		if var_26_14 == 0 then
			arg_26_0._tip:setString(Str(STR.COMPOSE_LIST_EMPTY_NO_CARD))
			arg_26_0._tip:setColor(ClientView.COLOR_LABEL_LIGHT)
		end
	elseif arg_26_0._mode == var_0_0.ModeType.recruite or arg_26_0._mode == var_0_0.ModeType.recruite_langend then
		if var_26_14 == 0 then
			if arg_26_0._type == Data.CardType.monster then
				arg_26_0._tip:setString(string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.MONSTER) .. Str(STR.CARD)))
			elseif arg_26_0._type == Data.CardType.magic then
				arg_26_0._tip:setString(string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.MAGIC) .. Str(STR.CARD)))
			elseif arg_26_0._type == Data.CardType.trap then
				arg_26_0._tip:setString(string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.TRAP) .. Str(STR.CARD)))
			else
				arg_26_0._tip:setString(string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.RARE) .. Str(STR.MONSTER) .. Str(STR.CARD)))
			end

			arg_26_0._tip:setColor(ClientView.COLOR_LABEL_LIGHT)
		end
	elseif arg_26_0._mode == var_0_0.ModeType.hire then
		if var_26_14 == 0 then
			arg_26_0._tip:setString(Str(STR.LIST_EMPTY_NO_HIRE))
			arg_26_0._tip:setColor(ClientView.COLOR_LABEL_LIGHT)
		end
	elseif arg_26_0._mode == var_0_0.ModeType.union_shop or arg_26_0._mode == var_0_0.ModeType.rare_shop or arg_26_0._mode == var_0_0.ModeType.diamond_shop or arg_26_0._mode == var_0_0.ModeType.god_shop or arg_26_0._mode == var_0_0.ModeType.vote_shop or arg_26_0._mode == var_0_0.ModeType.collect_shop then
		if var_26_14 == 0 then
			arg_26_0._tip:setString(Str(STR.LIST_EMPTY_SHOP))
			arg_26_0._tip:setColor(ClientView.COLOR_LABEL_LIGHT)
		end
	elseif arg_26_0._mode == var_0_0.ModeType.vote_recovery and var_26_14 == 0 then
		arg_26_0._tip:setString(Str(STR.LIST_EMPTY_RECOVERY))
		arg_26_0._tip:setColor(ClientView.COLOR_LABEL_LIGHT)
	end
end

function var_0_0.refreshItem(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_2 ~= nil then
		if arg_28_0._mode == var_0_0.ModeType.recruite or arg_28_0._mode == var_0_0.ModeType.recruite_langend then
			arg_28_1._thumbnail:updateComponent(arg_28_2)
		elseif arg_28_0._mode == var_0_0.ModeType.multi_select and arg_28_0._rareCards then
			arg_28_1._thumbnail:updateComponent(arg_28_2._infoId)
		else
			arg_28_1._thumbnail:updateComponent(arg_28_2, P._playerCard:getSkinId(arg_28_2))
		end

		arg_28_1:setVisible(true)
		arg_28_0:refreshItemCustom(arg_28_1, arg_28_2)
	else
		arg_28_1:setVisible(false)
	end
end

function var_0_0.refreshItemCustom(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0._mode == var_0_0.ModeType.troop or arg_29_0._mode == var_0_0.ModeType.expedition_troop or arg_29_0._mode == var_0_0.ModeType.union_battle_troop or arg_29_0._mode == var_0_0.ModeType.dark_troop or arg_29_0._mode == var_0_0.ModeType.room_dark_troop or arg_29_0._mode == var_0_0.ModeType.card_operate then
		local var_29_0 = arg_29_1._statusRect

		if arg_29_0._mode == var_0_0.ModeType.expedition_troop then
			local var_29_1 = arg_29_2._fragmentNum == nil and arg_29_2._isDead

			arg_29_1:showStatusRect(var_29_1, Str(STR.CARD_DEAD_STATUS), ClientView.COLOR_TEXT_RED)
		end

		local var_29_2 = arg_29_0._mode == var_0_0.ModeType.card_operate and arg_29_0._cardOperateTroop or ClientData._cloneTroops[arg_29_0._troopIndex]

		if arg_29_0._mode == var_0_0.ModeType.union_battle_troop then
			local var_29_3 = P._playerCard:getGroupCardCount(arg_29_2)
			local var_29_4, var_29_5 = arg_29_0:getCardCountInTroop(var_29_2, arg_29_2)
			local var_29_6, var_29_7 = arg_29_0:getCardCountInUnionTroops(arg_29_2)
			local var_29_8, var_29_9 = Data.getInfo(arg_29_1._thumbnail._infoId)

			arg_29_1._countArea:update(true, var_29_4, var_29_8._maxCount * Data.GROUP_NUM, var_29_5, var_29_3 - var_29_7)
		elseif arg_29_0._mode == var_0_0.ModeType.dark_troop then
			local var_29_10 = P._playerCard:getCardCount(arg_29_2)
			local var_29_11, var_29_12 = arg_29_0:getCardCountInTroop(var_29_2, arg_29_2)
			local var_29_13, var_29_14 = arg_29_0:getCardCountInDarkTroops(arg_29_2)
			local var_29_15, var_29_16 = Data.getInfo(arg_29_1._thumbnail._infoId)

			arg_29_1._countArea:update(true, var_29_11, var_29_15._maxCount, var_29_12, var_29_10 - var_29_14)
		elseif arg_29_0._mode == var_0_0.ModeType.room_dark_troop then
			local var_29_17, var_29_18 = arg_29_0:getCardCountInTroop(var_29_2, arg_29_2)
			local var_29_19, var_29_20 = arg_29_0:getCardCountInRoomDarkTroops(arg_29_2)
			local var_29_21, var_29_22 = Data.getInfo(arg_29_1._thumbnail._infoId)
			local var_29_23 = P._playerCard:getCardCount(arg_29_2)

			arg_29_1._countArea:update(true, var_29_17 + var_29_19, var_29_21._maxCount, var_29_18, var_29_23 - var_29_20)
		elseif arg_29_0._mode == var_0_0.ModeType.card_operate then
			local var_29_24, var_29_25 = arg_29_0:getCardCountInTroop(var_29_2, arg_29_2)
			local var_29_26, var_29_27 = Data.getInfo(arg_29_1._thumbnail._infoId)
			local var_29_28 = P._playerCard:getCardOperateCount(arg_29_2)

			arg_29_1._countArea:update(true, var_29_24, var_29_28, var_29_25, var_29_28)
		else
			local var_29_29, var_29_30 = arg_29_0:getCardCountInTroop(var_29_2, arg_29_2)
			local var_29_31, var_29_32 = Data.getInfo(arg_29_1._thumbnail._infoId)

			arg_29_1._countArea:update(true, var_29_29, var_29_31._maxCount, var_29_30)
		end

		arg_29_1._thumbnail:updateFlag()
	elseif arg_29_0._mode == var_0_0.ModeType.radio or arg_29_0._mode == var_0_0.ModeType.check then
		local var_29_33

		if arg_29_0._mode == var_0_0.ModeType.radio then
			arg_29_1._btnRadio:setVisible(true)
			arg_29_1._btnRadio._checkedSprite:setVisible(arg_29_0._selectedCards[arg_29_2] ~= nil)

			if arg_29_0._selectedCards[arg_29_2] then
				arg_29_0._lastSelectCard = arg_29_2
			end

			arg_29_1._btnRadio:setEnabled(true)
			arg_29_1._btnRadio:addTouchEventListener(function(arg_30_0, arg_30_1)
				if arg_30_1 == ccui.TouchEventType.ended then
					lc.Audio.playAudio(AUDIO.E_BUTTON_DEFAULT)

					if arg_29_0._lastSelectCard ~= nil and arg_29_0._lastSelectCard ~= arg_29_2 then
						arg_29_0._selectedCards[arg_29_0._lastSelectCard] = nil

						P._playerCard:sendCardSelect(arg_29_0._lastSelectCard, 0)
					end

					arg_29_0._lastSelectCard = arg_29_2

					if arg_29_0._selectedCards[arg_29_2] then
						arg_29_0._selectedCards[arg_29_2] = nil

						P._playerCard:sendCardSelect(arg_29_0._lastSelectCard, 0)
					else
						arg_29_0._selectedCards[arg_29_2] = 1

						P._playerCard:sendCardSelect(arg_29_0._lastSelectCard, 1)
					end

					if arg_29_0._onTapRadio ~= nil then
						arg_29_0._onTapRadio(arg_29_2)
					end

					if GuideManager.isGuideEnabled() then
						GuideManager.finishStep()
					end
				end
			end)

			local var_29_34 = arg_29_1._btnRadio
		else
			arg_29_1._btnCheck:setVisible(true)
			arg_29_1._btnCheck._checkedSprite:setVisible(arg_29_2._selected > 0)
			arg_29_1._btnCheck:setEnabled(true)
			arg_29_1._btnCheck:addTouchEventListener(function(arg_31_0, arg_31_1)
				if arg_31_1 == ccui.TouchEventType.ended then
					lc.Audio.playAudio(AUDIO.E_BUTTON_DEFAULT)
					arg_29_2:setSelected(arg_29_2._selected == 0 and 1 or 0)

					if arg_29_0._onTapCheck ~= nil then
						arg_29_0._onTapCheck(arg_29_2)
					end

					if GuideManager.isGuideEnabled() then
						GuideManager.finishStep()
					end
				end
			end)

			local var_29_35 = arg_29_1._btnCheck
		end
	elseif arg_29_0._mode == var_0_0.ModeType.multi_select then
		local var_29_36 = arg_29_1._multiSelectArea

		var_29_36:setVisible(true)

		function var_29_36._callbackAdd(arg_32_0)
			if arg_29_2._num > arg_29_2._selected then
				arg_29_2:setSelected(arg_29_2._selected + 1)
				var_29_36._label:setString(arg_29_2._selected)

				if arg_29_0._onCardSelectCountChange then
					arg_29_0._onCardSelectCountChange()
				end
			end
		end

		function var_29_36._callbackMinus(arg_33_0)
			if arg_29_2._selected > 0 then
				arg_29_2:setSelected(arg_29_2._selected - 1)
				var_29_36._label:setString(arg_29_2._selected)

				if arg_29_0._onCardSelectCountChange then
					arg_29_0._onCardSelectCountChange()
				end
			end
		end

		var_29_36._label:setString(arg_29_2._selected)
	elseif arg_29_0._mode == var_0_0.ModeType.mix or arg_29_0._mode == var_0_0.ModeType.mix_book then
		arg_29_1._countArea:update(true)
	elseif arg_29_0._mode == var_0_0.ModeType.hire then
		-- block empty
	elseif arg_29_0._mode == var_0_0.ModeType.recruite then
		local var_29_37 = (arg_29_0._curPage - 1) * arg_29_0._itemRow * arg_29_0._itemCol + arg_29_1._thumbnail._index
		local var_29_38 = arg_29_0._recruiteInfo[var_29_37]

		if var_29_38 then
			arg_29_1._countArea:updateDetermined(true, var_29_38._remainNum, var_29_38._remainNum + var_29_38._getNum)
		end

		if arg_29_0._upCard then
			arg_29_1._thumbnail:setUp(arg_29_1._thumbnail._infoId == arg_29_0._upCard)
		end
	elseif arg_29_0._mode == var_0_0.ModeType.recruite_langend then
		arg_29_1._countArea:update(false)

		if arg_29_0._upCard then
			arg_29_1._thumbnail:setUp(arg_29_1._thumbnail._infoId == arg_29_0._upCard)
		end
	elseif arg_29_0._mode == var_0_0.ModeType.recruite_list then
		local var_29_39 = (arg_29_0._curPage - 1) * arg_29_0._itemRow * arg_29_0._itemCol + arg_29_1._thumbnail._index
		local var_29_40 = arg_29_0._recruiteInfo[var_29_39]

		arg_29_1._countArea:update(true, var_29_40._num)
		arg_29_1._thumbnail:updateFlag()

		if arg_29_0._upCard then
			arg_29_1._thumbnail:setUp(arg_29_1._thumbnail._infoId == arg_29_0._upCard)
		end
	elseif arg_29_0._mode == var_0_0.ModeType.union_shop then
		local var_29_41 = (arg_29_0._curPage - 1) * arg_29_0._itemRow * arg_29_0._itemCol + arg_29_1._thumbnail._index
		local var_29_42 = arg_29_0._shopInfo[var_29_41]
		local var_29_43 = P._playerCard:getCardCount(var_29_42._infoId)
		local var_29_44 = (Data.getInfo(var_29_42._infoId)._maxCount or 3) - var_29_43

		arg_29_1._thumbnail:updateUnionShopFlag(var_29_43, var_29_44 + var_29_43, var_29_42._price, var_29_42._priceType, var_29_42._disCount)

		local var_29_45 = arg_29_1._btnCustom1

		var_29_45:loadTextureNormal("buy_button", ccui.TextureResType.plistType)
		var_29_45:setVisible(true)
		var_29_45:setContentSize(140, 90)
		var_29_45._label:setVisible(false)
		ClientView.addPriceToBtn(var_29_45, var_29_42._price, var_29_42._priceType, 100, 30)

		var_29_45._card = var_29_42

		if var_29_45._callback == nil and arg_29_0._onTapBtnCustom1 ~= nil then
			var_29_45._callback = arg_29_0._onTapBtnCustom1
		end

		var_29_45:setPosition(0, lc.bottom(arg_29_1._countArea) - lc.ch(var_29_45) + 20)
		var_29_45:setLocalZOrder(-3)
	elseif arg_29_0._mode == var_0_0.ModeType.vote_shop then
		local var_29_46 = (arg_29_0._curPage - 1) * arg_29_0._itemRow * arg_29_0._itemCol + arg_29_1._thumbnail._index
		local var_29_47 = arg_29_0._shopInfo[var_29_46]
		local var_29_48 = P._playerCard:getCardCount(var_29_47._infoId)

		if not Data.getInfo(var_29_47._infoId)._maxCount then
			local var_29_49 = 3
		end

		local var_29_50 = arg_29_1._btnCustom1

		var_29_50:loadTextureNormal("buy_button", ccui.TextureResType.plistType)
		var_29_50:setVisible(true)
		var_29_50:setContentSize(140, 90)
		var_29_50._label:setVisible(false)
		ClientView.addPriceToBtn(var_29_50, var_29_47._price, var_29_47._priceType, 100, 30)
		var_29_50:setEnabled(true)

		var_29_50._card = var_29_47

		if var_29_50._callback == nil and arg_29_0._onTapBtnCustom1 ~= nil then
			var_29_50._callback = arg_29_0._onTapBtnCustom1
		end

		arg_29_1._thumbnail:updateVoteShopFlag(var_29_47._id)
		var_29_50:setPosition(0, lc.bottom(arg_29_1._countArea) - lc.ch(var_29_50) + 20)
		var_29_50:setLocalZOrder(-3)
	elseif arg_29_0._mode == var_0_0.ModeType.vote_recovery then
		local var_29_51 = (arg_29_0._curPage - 1) * arg_29_0._itemRow * arg_29_0._itemCol + arg_29_1._thumbnail._index
		local var_29_52 = arg_29_0._shopInfo[var_29_51]
		local var_29_53 = P._playerCard:getCardCount(var_29_52._cardId)
		local var_29_54 = Data.getInfo(var_29_52._cardId)
		local var_29_55 = arg_29_1._btnCustom1

		ClientView.addPriceToBtn(var_29_55)
		var_29_55:loadTextureNormal("buy_button", ccui.TextureResType.plistType)
		var_29_55:setVisible(true)
		var_29_55:setContentSize(140, 90)
		var_29_55._label:setVisible(true)
		var_29_55._label:setString(Str(STR.RECOVERY))
		var_29_55._label:setPosition(cc.p(lc.cw(var_29_55), lc.ch(var_29_55)))
		var_29_55:setEnabled(true)

		var_29_55._card = var_29_52

		if var_29_55._callback == nil and arg_29_0._onTapBtnCustom1 ~= nil then
			var_29_55._callback = arg_29_0._onTapBtnCustom1
		end

		arg_29_1._thumbnail:updateRecoveryFlag(var_29_52._id, var_29_52._cardsNum - (P._playerMarket._recoveryMap[var_29_52._id] or 0))
		var_29_55:setPosition(0, lc.bottom(arg_29_1._countArea) - lc.ch(var_29_55) + 20)
		var_29_55:setLocalZOrder(-3)
	elseif arg_29_0._mode == var_0_0.ModeType.rare_shop then
		local var_29_56 = (arg_29_0._curPage - 1) * arg_29_0._itemRow * arg_29_0._itemCol + arg_29_1._thumbnail._index
		local var_29_57 = arg_29_0._shopInfo[var_29_56]
		local var_29_58 = P._playerCard:getCardCount(var_29_57._infoId)
		local var_29_59 = (Data.getInfo(var_29_57._infoId)._maxCount or 3) - var_29_58
		local var_29_60 = false

		if P._playerMarket._rareGoodsMap[var_29_57._id] then
			var_29_60 = true
		end

		arg_29_1._thumbnail:updateRareShopFlag(var_29_58, var_29_59 + var_29_58, var_29_57._price, var_29_57._priceType, var_29_60)

		local var_29_61 = arg_29_1._btnCustom1

		var_29_61:loadTextureNormal("buy_button", ccui.TextureResType.plistType)
		var_29_61:setVisible(true)
		var_29_61:setContentSize(140, 90)
		var_29_61._label:setVisible(false)
		ClientView.addPriceToBtn(var_29_61, var_29_57._price, var_29_57._priceType, 100, 30)

		var_29_61._card = var_29_57

		if var_29_61._callback == nil and arg_29_0._onTapBtnCustom1 ~= nil then
			var_29_61._callback = arg_29_0._onTapBtnCustom1
		end

		var_29_61:setPosition(0, lc.bottom(arg_29_1._countArea) - lc.ch(var_29_61) + 20)
		var_29_61:setLocalZOrder(-3)
	elseif arg_29_0._mode == var_0_0.ModeType.diamond_shop then
		local var_29_62 = (arg_29_0._curPage - 1) * arg_29_0._itemRow * arg_29_0._itemCol + arg_29_1._thumbnail._index
		local var_29_63 = arg_29_0._shopInfo[var_29_62]
		local var_29_64 = P._playerCard:getCardCount(var_29_63._infoId)
		local var_29_65 = (Data.getInfo(var_29_63._infoId)._maxCount or 3) - var_29_64

		arg_29_1._thumbnail:updateDiamondShopFlag(var_29_64, var_29_65 + var_29_64, var_29_63._price, var_29_63._priceType)

		local var_29_66 = arg_29_1._btnCustom1

		var_29_66:loadTextureNormal("buy_button", ccui.TextureResType.plistType)
		var_29_66:setVisible(true)
		var_29_66:setContentSize(140, 90)
		var_29_66._label:setVisible(false)
		ClientView.addPriceToBtn(var_29_66, var_29_63._price, var_29_63._priceType, 100, 30)

		var_29_66._card = var_29_63

		if var_29_66._callback == nil and arg_29_0._onTapBtnCustom1 ~= nil then
			var_29_66._callback = arg_29_0._onTapBtnCustom1
		end

		var_29_66:setPosition(0, lc.bottom(arg_29_1._countArea) - lc.ch(var_29_66) + 20)
		var_29_66:setLocalZOrder(-3)
	elseif arg_29_0._mode == var_0_0.ModeType.collect_shop then
		local var_29_67 = (arg_29_0._curPage - 1) * arg_29_0._itemRow * arg_29_0._itemCol + arg_29_1._thumbnail._index
		local var_29_68 = arg_29_0._shopInfo[var_29_67]
		local var_29_69 = P._playerCard:getCardCount(var_29_68._infoId)
		local var_29_70 = (Data.getInfo(var_29_68._infoId)._maxCount or 3) - var_29_69
		local var_29_71 = false

		arg_29_1._thumbnail:updateRareShopFlag(var_29_69, var_29_70 + var_29_69, var_29_68._price, var_29_68._priceType, var_29_71)

		local var_29_72 = arg_29_1._btnCustom1

		var_29_72:loadTextureNormal("buy_button", ccui.TextureResType.plistType)
		var_29_72:setVisible(true)
		var_29_72:setContentSize(140, 90)
		var_29_72._label:setVisible(false)
		ClientView.addPriceToBtn(var_29_72, var_29_68._price, var_29_68._priceType, 100, 30)

		var_29_72._card = var_29_68

		if var_29_72._callback == nil and arg_29_0._onTapBtnCustom1 ~= nil then
			var_29_72._callback = arg_29_0._onTapBtnCustom1
		end

		var_29_72:setPosition(0, lc.bottom(arg_29_1._countArea) - lc.ch(var_29_72) + 20)
		var_29_72:setLocalZOrder(-3)
	elseif arg_29_0._mode == var_0_0.ModeType.effect_store then
		local var_29_73 = P._playerCard:getCardEffectCount(arg_29_2)

		arg_29_1._countArea:updateEffect(true, var_29_73)
	else
		arg_29_1._countArea:update(true)
	end
end

function var_0_0.onGuide(arg_34_0, arg_34_1)
	local var_34_0, var_34_1 = GuideManager.getCurStepName()

	if var_34_0 == "enter upgrade card" then
		if arg_34_0._mode == var_0_0.ModeType.sacrifice then
			local var_34_2 = arg_34_0:getItems()

			for iter_34_0, iter_34_1 in ipairs(var_34_2) do
				local var_34_3 = iter_34_1._thumbnail._card

				if var_34_3:getQuality() == Data.CardQuality.UR and var_34_3._level == 1 then
					GuideManager.setOperateLayer(iter_34_1._btnCustom1)

					var_34_1 = true

					break
				end
			end
		end
	elseif var_34_0 == "enter evolve card" then
		if arg_34_0._mode == var_0_0.ModeType.sacrifice then
			local var_34_4 = arg_34_0:getItems()

			for iter_34_2, iter_34_3 in ipairs(var_34_4) do
				if iter_34_3._thumbnail._card:getQuality() == Data.CardQuality.UR then
					GuideManager.setOperateLayer(iter_34_3._btnCustom1)

					var_34_1 = true

					break
				end
			end
		end
	elseif var_34_0 == "pick card" then
		if arg_34_0._mode == var_0_0.ModeType.check or arg_34_0._mode == var_0_0.ModeType.radio then
			local var_34_5 = arg_34_0:getItems()

			for iter_34_4, iter_34_5 in ipairs(var_34_5) do
				GuideManager.setOperateLayer(arg_34_0._mode == var_0_0.ModeType.check and iter_34_5._btnCheck or iter_34_5._btnRadio)

				break
			end

			var_34_1 = true
		end
	else
		return
	end

	if var_34_1 then
		arg_34_1:stopPropagation()
	end
end

function var_0_0.getSelectedCards(arg_35_0)
	return arg_35_0._selectedCards
end

function var_0_0.getUnselectedCards(arg_36_0)
	local var_36_0 = {}

	for iter_36_0 = 1, #arg_36_0._cards do
		if arg_36_0._cards[iter_36_0]._selected == 0 then
			table.insert(var_36_0, arg_36_0._cards[iter_36_0])
		end
	end

	return var_36_0
end

function var_0_0.getSelectedCardNumber(arg_37_0)
	local var_37_0 = 0

	for iter_37_0 = 1, #arg_37_0._cards do
		if arg_37_0._cards[iter_37_0]._selected > 0 then
			var_37_0 = var_37_0 + arg_37_0._cards[iter_37_0]._selected
		end
	end

	return var_37_0
end

function var_0_0.getUnselectedCardNumber(arg_38_0)
	local var_38_0 = 0

	for iter_38_0 = 1, #arg_38_0._cards do
		if arg_38_0._cards[iter_38_0]._selected == 0 then
			var_38_0 = var_38_0 + 1
		end
	end

	return var_38_0
end

function var_0_0.selectAllCards(arg_39_0)
	for iter_39_0 = 1, #arg_39_0._cards do
		arg_39_0._cards[iter_39_0]:setSelected(1)
	end
end

function var_0_0.unselectAllCards(arg_40_0)
	for iter_40_0 = 1, #arg_40_0._cards do
		arg_40_0._cards[iter_40_0]:setSelected(0)
	end
end

function var_0_0.getCardCountInTroop(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0, var_41_1, var_41_2 = Data.removeAdditional(arg_41_2)
	local var_41_3 = Data.getOriginId(var_41_0)
	local var_41_4 = 0
	local var_41_5 = 0

	for iter_41_0 = 1, #arg_41_1 do
		local var_41_6, var_41_7, var_41_8 = Data.removeAdditional(arg_41_1[iter_41_0]._infoId)

		if Data.getOriginId(var_41_6) == var_41_3 then
			var_41_4 = var_41_4 + arg_41_1[iter_41_0]._num
		end

		if arg_41_2 == arg_41_1[iter_41_0]._infoId then
			var_41_5 = var_41_5 + arg_41_1[iter_41_0]._num
		end
	end

	return var_41_4, var_41_5
end

function var_0_0.getCardCountInUnionTroops(arg_42_0, arg_42_1)
	local var_42_0, var_42_1, var_42_2 = Data.removeAdditional(arg_42_1)
	local var_42_3 = Data.getOriginId(var_42_0)
	local var_42_4 = 0
	local var_42_5 = 0

	for iter_42_0 = Data.TroopIndex.union_battle1, Data.TroopIndex.union_battle1 + Data.GROUP_NUM - 1 do
		if iter_42_0 ~= arg_42_0._troopIndex then
			local var_42_6 = ClientData._cloneTroops[iter_42_0] or P._playerCard:getTroop(iter_42_0, false)

			for iter_42_1 = 1, #var_42_6 do
				local var_42_7, var_42_8, var_42_9 = Data.removeAdditional(var_42_6[iter_42_1]._infoId)

				if Data.getOriginId(var_42_7) == var_42_3 then
					var_42_4 = var_42_4 + var_42_6[iter_42_1]._num
				end

				if arg_42_1 == var_42_6[iter_42_1]._infoId then
					var_42_5 = var_42_5 + var_42_6[iter_42_1]._num
				end
			end
		end
	end

	return var_42_4, var_42_5
end

function var_0_0.getCardCountInDarkTroops(arg_43_0, arg_43_1)
	local var_43_0, var_43_1, var_43_2 = Data.removeAdditional(arg_43_1)
	local var_43_3 = Data.getOriginId(var_43_0)
	local var_43_4 = 0
	local var_43_5 = 0

	for iter_43_0 = Data.TroopIndex.dark_battle1, Data.TroopIndex.dark_battle3 do
		if iter_43_0 ~= arg_43_0._troopIndex then
			local var_43_6 = ClientData._cloneTroops[iter_43_0] or P._playerCard:getTroop(iter_43_0, false)

			for iter_43_1 = 1, #var_43_6 do
				local var_43_7, var_43_8, var_43_9 = Data.removeAdditional(var_43_6[iter_43_1]._infoId)

				if Data.getOriginId(var_43_7) == var_43_3 then
					var_43_4 = var_43_4 + var_43_6[iter_43_1]._num
				end

				if arg_43_1 == var_43_6[iter_43_1]._infoId then
					var_43_5 = var_43_5 + var_43_6[iter_43_1]._num
				end
			end
		end
	end

	return var_43_4, var_43_5
end

function var_0_0.getCardCountInRoomDarkTroops(arg_44_0, arg_44_1)
	local var_44_0, var_44_1, var_44_2 = Data.removeAdditional(arg_44_1)
	local var_44_3 = Data.getOriginId(var_44_0)
	local var_44_4 = 0
	local var_44_5 = 0

	for iter_44_0 = Data.TroopIndex.room_dark_battle1, Data.TroopIndex.room_dark_battle3 do
		if iter_44_0 ~= arg_44_0._troopIndex then
			local var_44_6 = ClientData._cloneTroops[iter_44_0] or P._playerCard:getTroop(iter_44_0, false)

			for iter_44_1 = 1, #var_44_6 do
				local var_44_7, var_44_8, var_44_9 = Data.removeAdditional(var_44_6[iter_44_1]._infoId)

				if Data.getOriginId(var_44_7) == var_44_3 then
					var_44_4 = var_44_4 + var_44_6[iter_44_1]._num
				end

				if arg_44_1 == var_44_6[iter_44_1]._infoId then
					var_44_5 = var_44_5 + var_44_6[iter_44_1]._num
				end
			end
		end
	end

	return var_44_4, var_44_5
end

return var_0_0
