local var_0_0 = class("RareShopArea", lc.ExtendCCNode)
local var_0_1 = require("CardList")
local var_0_2 = 800
local var_0_3 = 250

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(math.min(arg_1_0, var_0_2), arg_1_1)
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
	arg_3_0:generateCardPackageData()

	local var_3_0 = lc.List.createH(cc.size(ClientView.SCR_W - ClientView.VERTICAL_TAB_WIDTH - ClientView.SCR_EDGE, lc.h(arg_3_0) - 60), 30, 30)

	var_3_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_3_0, var_3_0, cc.p(lc.cw(arg_3_0), lc.ch(arg_3_0) + 10))

	arg_3_0._list = var_3_0
	arg_3_0._recruitItems = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0._packageCardNum) do
		local var_3_1 = arg_3_0:createRecruitItem(iter_3_1)

		var_3_0:pushBackCustomItem(var_3_1)
		table.insert(arg_3_0._recruitItems, var_3_1)
	end

	local var_3_2 = {}

	table.insert(var_3_2, lc.addEventListener(Data.Event.prop_dirty, function(arg_4_0)
		arg_3_0:updateCardBox()
	end))
	table.insert(var_3_2, lc.addEventListener(Data.Event.card_dirty, function(arg_5_0)
		arg_3_0:updateCardBox()
	end))

	arg_3_0._listeners = var_3_2
end

function var_0_0.generateCardPackageData(arg_6_0)
	local var_6_0 = Data._rareProductsInfo
	local var_6_1 = {}
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_3 = iter_6_1._type

		if var_6_1[var_6_3] == nil then
			var_6_1[var_6_3] = {}
		end

		local var_6_4

		for iter_6_2, iter_6_3 in ipairs(var_6_2) do
			if iter_6_3._type == var_6_3 then
				var_6_4 = iter_6_3

				break
			end
		end

		if not var_6_4 then
			var_6_4 = {
				_num = 0,
				_type = var_6_3
			}

			table.insert(var_6_2, var_6_4)
		end

		local var_6_5 = iter_6_1._cardId
		local var_6_6, var_6_7, var_6_8, var_6_9 = ClientData.getServerDate()
		local var_6_10 = iter_6_1._date
		local var_6_11 = string.sub(var_6_10, 1, 4)
		local var_6_12 = string.sub(var_6_10, 5, 6)
		local var_6_13 = string.sub(var_6_10, 7, 8)
		local var_6_14 = 12 * (var_6_9 - var_6_11) + (var_6_8 - var_6_12)
		local var_6_15 = true

		if var_6_14 < 0 then
			var_6_15 = false
		end

		if var_6_14 == 0 and var_6_7 - var_6_13 < 0 then
			var_6_15 = false
		end

		if iter_6_1._resType == Data.PropsId.rare_coin and P._vip == 0 then
			var_6_15 = false
		end

		if var_6_15 then
			local var_6_16 = iter_6_1._cost

			table.insert(var_6_1[var_6_3], {
				_infoId = var_6_5,
				_price = var_6_16,
				_priceType = iter_6_1._resType,
				_disCount = j,
				_id = iter_6_1._id
			})

			local var_6_17 = false

			if P._playerMarket._rareGoodsMap[var_6_3] then
				var_6_17 = true
			end

			if not var_6_17 then
				var_6_4._num = var_6_4._num + 1
			end
		end
	end

	table.sort(var_6_2, function(arg_7_0, arg_7_1)
		if arg_7_0._num == 0 and arg_7_1._num > 0 then
			return false
		elseif arg_7_1._num == 0 and arg_7_0._num > 0 then
			return true
		end

		return arg_7_0._type < arg_7_1._type
	end)

	arg_6_0._packages = var_6_1
	arg_6_0._packageCardNum = var_6_2
end

function var_0_0.createRecruitItem(arg_8_0, arg_8_1)
	local var_8_0 = ccui.Layout:create()

	var_8_0:setContentSize(cc.size(var_0_3, lc.h(arg_8_0)))
	var_8_0:setAnchorPoint(0.5, 0.5)

	local var_8_1 = ClientView.createRareCardPackage(arg_8_1)
	local var_8_2 = ClientView.createShaderButton(nil, function(arg_9_0)
		if arg_8_1._num > 0 then
			arg_8_0:showCardBox(arg_8_1)
		else
			ToastManager.push(Str(STR.SID_FIXITY_DESC_1013))
		end
	end)

	var_8_2:setContentSize(var_8_1:getContentSize())
	var_8_2:setZoomScale(0.02)
	lc.addChildToCenter(var_8_2, var_8_1)
	lc.addChildToCenter(var_8_0, var_8_2)

	var_8_0._info = arg_8_1

	local var_8_3, var_8_4 = arg_8_0:isLocked(arg_8_1)

	if var_8_3 then
		var_8_1:setGray()

		local var_8_5 = lc.createSprite("img_com_bg_45")

		lc.addChildToPos(var_8_1, var_8_5, cc.p(lc.cw(var_8_1), lc.ch(var_8_1) + 30))

		local var_8_6 = ClientView.createBoldRichTextMultiLine(var_8_4, ClientView.RICHTEXT_PARAM_LIGHT_S2)

		lc.addChildToCenter(var_8_5, var_8_6)
	end

	return var_8_0
end

function var_0_0.isLocked(arg_10_0, arg_10_1)
	local var_10_0 = false
	local var_10_1 = ""

	if arg_10_1._type * 100 + 1 >= 103001 and P:getCharacterUnlockCount() < 2 then
		var_10_0 = true
		var_10_1 = string.format(Str(STR.NEED_UNLOCK_CHARACTER_COUNT), 2)
	end

	return var_10_0, var_10_1
end

function var_0_0.onEnter(arg_11_0)
	return
end

function var_0_0.onExit(arg_12_0)
	return
end

function var_0_0.onCleanUp(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_13_1)
	end
end

function var_0_0.showCardBox(arg_14_0, arg_14_1)
	if arg_14_0._detailPanel then
		return arg_14_0:updateCardBox()
	end

	arg_14_0._list:setVisible(false)

	local var_14_0 = ClientView.createShaderButton(nil, function(arg_15_0)
		arg_14_0:hideCardBox()
	end)
	local var_14_1 = cc.Node:create()

	var_14_1:setContentSize(cc.size(ClientView.SCR_W - ClientView.VERTICAL_TAB_WIDTH - ClientView.SCR_EDGE * 2, lc.h(arg_14_0)))
	var_14_1:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToCenter(arg_14_0, var_14_1)

	arg_14_0._detailPanel = var_14_1
	arg_14_0._detailPanel._package = var_14_0

	arg_14_0:addCardList(var_14_1, arg_14_1._type)
	arg_14_0:updateCardBox()
	var_14_0:setPosition(cc.p(lc.x(var_14_0) + 100, lc.y(var_14_0)))
	var_14_0:runAction(lc.sequence(lc.moveBy(0.2, cc.p(-100, 0))))
	var_14_1:setVisible(false)
	var_14_1:setPositionX(lc.cw(arg_14_0) - 80)
	var_14_1:runAction(lc.sequence(lc.delay(0.2), lc.show(), lc.ease(lc.moveBy(0.3, cc.p(80, 0)), "BackO")))
	ClientView.getResourceUI():setMode(arg_14_1._type == 0 and Data.PropsId.winged_dragon or Data.PropsId.rare_silver_coin)
end

function var_0_0.updateCardBox(arg_16_0)
	if not arg_16_0._detailPanel then
		return
	end

	arg_16_0:updateCardList()
end

function var_0_0.hideCardBox(arg_17_0)
	arg_17_0._list:setVisible(true)

	if arg_17_0._detailPanel then
		arg_17_0._detailPanel._package:removeFromParent()

		arg_17_0._detailPanel._package = nil

		arg_17_0._cardList:removeFromParent()

		arg_17_0._cardList = nil

		arg_17_0._detailPanel:removeFromParent()

		arg_17_0._detailPanel = nil
	end

	ClientView.getResourceUI():setMode(Data.ResType.gold)
end

function var_0_0.addCardList(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg1", cc.rect(27, 13, 1, 1))

	var_18_0:setContentSize(cc.size(lc.w(arg_18_1) - 95, lc.h(arg_18_1) - 40))
	lc.addChildToPos(arg_18_1, var_18_0, cc.p(lc.cw(arg_18_1), lc.ch(arg_18_1) + 20))

	local var_18_1 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_18_1:setContentSize(cc.size(lc.w(arg_18_1) - 20, lc.h(var_18_1)))
	lc.addChildToPos(arg_18_1, var_18_1, cc.p(lc.cw(arg_18_1), lc.ch(arg_18_1) + 125))

	local var_18_2 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_18_2:setContentSize(cc.size(lc.w(arg_18_1) - 20, lc.h(var_18_2)))
	lc.addChildToPos(arg_18_1, var_18_2, cc.p(lc.cw(arg_18_1), 168))

	local var_18_3 = var_0_1.create(cc.size(lc.w(arg_18_1) - 100, lc.h(arg_18_1) - 60), 0.5, false, 220)

	var_18_3:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_18_1, var_18_3, cc.p(lc.cw(arg_18_1), lc.ch(var_18_3) + 15))

	local var_18_4 = false
	local var_18_5 = ""
	local var_18_6 = arg_18_2 * 100 + 1

	if var_18_6 == 103001 and P:getCharacterUnlockCount() < 2 then
		var_18_4 = true
		var_18_5 = string.format(Str(STR.NEED_UNLOCK_CHARACTER_COUNT), 2)
	elseif var_18_6 == 104001 and P:getCharacterUnlockCount() < 2 then
		var_18_4 = true
		var_18_5 = string.format(Str(STR.NEED_UNLOCK_CHARACTER_COUNT), 2)
	end

	local function var_18_7(arg_19_0)
		local var_19_0 = arg_19_0._card

		ClientData.sendBuyRare(var_19_0._id)
		P._playerCard:addCard(var_19_0._infoId, 1)
		P:addResource(var_19_0._priceType, nil, -var_19_0._price)
		require("RewardCardPanel").create(Str(STR.BUYSUCCESS), {
			var_19_0
		}):show()
		lc.Audio.playAudio(AUDIO.E_CARD_GET)
		var_18_3:refresh()
	end

	local function var_18_8(arg_20_0)
		local var_20_0 = arg_20_0._card

		if P._playerMarket._rareGoodsMap[var_20_0._id] and false then
			return ToastManager.push(Str(STR.SHOP_CARD_ONCE))
		end

		if P._playerCard:getCardCount(var_20_0._infoId) >= (Data.getInfo(var_20_0._infoId)._maxCount or 3) then
			return ToastManager.push(Str(STR.SHOP_CARD_MAX))
		end

		local var_20_1 = arg_20_0._card

		if var_18_4 then
			ToastManager.push(var_18_5)
		elseif var_20_1._price > P:getItemCount(var_20_1._priceType) then
			if var_20_1._priceType == 7158 then
				require("ExchangeResForm").create(7158):show()
			else
				ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(Data._propsInfo[var_20_1._priceType]._nameSid)))
			end
		else
			require("Dialog").showDialog(Str(STR.SURE_TO_BUY), function()
				var_18_7(arg_20_0)
			end)
		end
	end

	var_18_3:registerTapBtnCustom1(var_18_8)
	var_18_3:setMode(var_0_1.ModeType.rare_shop)

	var_18_3._shopInfo = arg_18_0._packages[arg_18_2]

	var_18_3:registerCardSelectedHandler(function(arg_22_0, arg_22_1)
		local var_22_0 = require("CardInfoPanel")

		var_22_0.create(arg_22_0, 1, var_22_0.OperateType.view, var_18_3._shopInfo[arg_22_1]):show()
	end)
	var_18_3:init(Data.BaseCardTypes[1])
	var_18_3._pageLabel:setPositionY(var_18_3._pageLabel:getPositionY())
	var_18_3:refresh(true)

	arg_18_0._cardList = var_18_3

	local var_18_9 = 10

	var_18_3._pageLeft._pos = cc.p(var_18_9, lc.ch(var_18_3))
	var_18_3._pageRight._pos = cc.p(lc.w(var_18_3) - var_18_9, lc.ch(var_18_3))

	local var_18_10 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_18_0._cardList, var_18_10, cc.p(0, lc.ch(var_18_10) + 50), -1)
	var_18_10:setScale(-1, 0.9)
	arg_18_0._cardList._pageLabel:setPosition(cc.p(var_18_10:getPosition()))
end

function var_0_0.updateCardList(arg_23_0)
	arg_23_0._cardList:refresh()
end

return var_0_0
