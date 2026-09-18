local var_0_0 = class("UnionShopArea", lc.ExtendCCNode)
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
	lc.addChildToPos(arg_3_0, var_3_0, cc.p(lc.cw(arg_3_0), lc.ch(arg_3_0)))

	arg_3_0._list = var_3_0
	arg_3_0._recruitItems = {}

	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0._packageCardNum) do
		var_3_1[#var_3_1 + 1] = iter_3_0
	end

	table.sort(var_3_1, function(arg_4_0, arg_4_1)
		return arg_4_1 < arg_4_0
	end)

	for iter_3_2 = 1, #var_3_1 do
		local var_3_2 = arg_3_0:createRecruitItem({
			_type = var_3_1[iter_3_2]
		})

		var_3_0:pushBackCustomItem(var_3_2)
		table.insert(arg_3_0._recruitItems, var_3_2)
	end

	local var_3_3 = {}

	table.insert(var_3_3, lc.addEventListener(Data.Event.prop_dirty, function(arg_5_0)
		arg_3_0:updateCardBox()
	end))
	table.insert(var_3_3, lc.addEventListener(Data.Event.card_dirty, function(arg_6_0)
		arg_3_0:updateCardBox()
	end))

	arg_3_0._listeners = var_3_3
end

function var_0_0.generateCardPackageData(arg_7_0)
	local var_7_0 = Data._unionProductsExInfo
	local var_7_1 = {}
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_3 = iter_7_1._type

		if var_7_1[var_7_3] == nil then
			var_7_1[var_7_3] = {}
		end

		if not var_7_2[var_7_3] then
			var_7_2[var_7_3] = 0
		end

		local var_7_4 = iter_7_1._cardId
		local var_7_5, var_7_6, var_7_7, var_7_8 = ClientData.getServerDate()
		local var_7_9 = iter_7_1._date
		local var_7_10 = string.sub(var_7_9, 1, 4)
		local var_7_11 = string.sub(var_7_9, 5, 6)
		local var_7_12 = string.sub(var_7_9, 7, 8)
		local var_7_13 = 12 * (var_7_8 - var_7_10) + (var_7_7 - var_7_11)
		local var_7_14 = true

		if var_7_13 < 0 then
			var_7_14 = false
		end

		if var_7_13 == 0 and var_7_6 - var_7_12 < 0 then
			var_7_14 = false
		end

		if var_7_14 then
			local var_7_15 = Data._globalInfo._unionShopDiscountMonth
			local var_7_16 = 0

			for iter_7_2, iter_7_3 in ipairs(var_7_15) do
				if iter_7_3 <= var_7_13 then
					var_7_16 = iter_7_2
				end

				if var_7_13 <= iter_7_3 then
					break
				end
			end

			local var_7_17 = iter_7_1._cost
			local var_7_18 = 100

			if var_7_16 > 0 then
				var_7_17 = var_7_17 * Data._globalInfo._unionShopDiscount[var_7_16] / 100
			end

			table.insert(var_7_1[var_7_3], {
				_infoId = var_7_4,
				_price = var_7_17,
				_priceType = iter_7_1._resType,
				_disCount = var_7_16,
				_id = iter_7_1._id
			})

			var_7_2[var_7_3] = var_7_2[var_7_3] + 1
		end
	end

	for iter_7_4, iter_7_5 in pairs(var_7_1) do
		table.sort(iter_7_5, function(arg_8_0, arg_8_1)
			local var_8_0 = var_7_0[arg_8_0._id]
			local var_8_1 = var_7_0[arg_8_1._id]

			if var_8_0._date == var_8_1._date then
				return var_8_0._id < var_8_1._id
			else
				return var_8_0._date > var_8_1._date
			end
		end)
	end

	arg_7_0._packages = var_7_1
	arg_7_0._packageCardNum = var_7_2
end

function var_0_0.createRecruitItem(arg_9_0, arg_9_1)
	local var_9_0 = ccui.Layout:create()

	var_9_0:setContentSize(cc.size(var_0_3, lc.h(arg_9_0)))
	var_9_0:setAnchorPoint(0.5, 0.5)

	local var_9_1 = ClientView.createUnionCardPackage(arg_9_1)
	local var_9_2 = ClientView.createShaderButton(nil, function(arg_10_0)
		if arg_9_0._packageCardNum[arg_9_1._type] > 0 then
			arg_9_0:showCardBox(arg_9_1)
		else
			ToastManager.push(Str(STR.ONSALE_NEXT_MONTH))
		end
	end)

	var_9_2:setContentSize(var_9_1:getContentSize())
	var_9_2:setZoomScale(0.02)
	lc.addChildToCenter(var_9_2, var_9_1)
	lc.addChildToCenter(var_9_0, var_9_2)

	var_9_0._info = arg_9_1

	local var_9_3 = false
	local var_9_4 = ""

	if var_9_3 then
		var_9_2:setTouchEnabled(false)
		var_9_1:setGray()

		local var_9_5 = lc.createSprite("img_com_bg_45")

		lc.addChildToPos(var_9_1, var_9_5, cc.p(lc.cw(var_9_1), lc.ch(var_9_1) + 30))

		local var_9_6 = ClientView.createBoldRichTextMultiLine(var_9_4, ClientView.RICHTEXT_PARAM_LIGHT_S2)

		lc.addChildToCenter(var_9_5, var_9_6)
	end

	return var_9_0
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

	var_14_1:setContentSize(cc.size(ClientView.SCR_W - ClientView.VERTICAL_TAB_WIDTH, lc.h(arg_14_0)))
	var_14_1:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToCenter(arg_14_0, var_14_1)

	arg_14_0._detailPanel = var_14_1
	arg_14_0._detailPanel._package = var_14_0

	arg_14_0:addCardList(var_14_1, arg_14_1._type)
	arg_14_0:updateCardBox()
	var_14_0:setPosition(cc.p(lc.x(var_14_0) + 100, lc.y(var_14_0)))
	var_14_0:runAction(lc.sequence(lc.moveBy(0.2, cc.p(-100, 0))))
	var_14_1:setVisible(false)
	var_14_1:setPositionX(lc.cw(arg_14_0) - 200)
	var_14_1:runAction(lc.sequence(lc.delay(0.2), lc.show(), lc.ease(lc.moveBy(0.3, cc.p(200, 0)), "BackO")))
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
end

function var_0_0.addCardList(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg1", cc.rect(27, 13, 1, 1))

	var_18_0:setContentSize(cc.size(lc.w(arg_18_1) - 75, lc.h(arg_18_1) + 18))
	lc.addChildToPos(arg_18_1, var_18_0, cc.p(lc.cw(arg_18_1), lc.ch(arg_18_1)))

	local var_18_1 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_18_1:setContentSize(cc.size(lc.w(arg_18_1), lc.h(var_18_1)))
	lc.addChildToPos(arg_18_1, var_18_1, cc.p(lc.cw(arg_18_1), lc.ch(arg_18_1) + 130))

	local var_18_2 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_18_2:setContentSize(cc.size(lc.w(arg_18_1), lc.h(var_18_2)))
	lc.addChildToPos(arg_18_1, var_18_2, cc.p(lc.cw(arg_18_1), 138))

	local var_18_3 = var_0_1.create(cc.size(lc.w(arg_18_1) - 100, lc.h(arg_18_1)), 0.5, false, 220)

	var_18_3:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_18_1, var_18_3)

	local function var_18_4(arg_19_0)
		local var_19_0 = arg_19_0._card

		ClientData.sendBuyUnion(var_19_0._id)
		P._playerCard:addCard(var_19_0._infoId, 1)
		P:addResource(var_19_0._priceType, nil, -var_19_0._price)
		require("RewardCardPanel").create(Str(STR.BUYSUCCESS), {
			var_19_0
		}):show()
		lc.Audio.playAudio(AUDIO.E_CARD_GET)
		var_18_3:refresh()
	end

	local function var_18_5(arg_20_0)
		local var_20_0 = arg_20_0._card

		if P._playerCard:getCardCount(var_20_0._infoId) >= (Data.getInfo(var_20_0._infoId)._maxCount or 3) then
			return ToastManager.push(Str(STR.SHOP_CARD_MAX))
		end

		local var_20_1 = arg_20_0._card

		if var_20_1._price > P:getItemCount(var_20_1._priceType) then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(Data._propsInfo[Data.PropsId.yubi]._nameSid)))
			require("UnionContributeForm").create():show()
		else
			require("Dialog").showDialog(Str(STR.SURE_TO_BUY), function()
				var_18_4(arg_20_0)
			end)
		end
	end

	var_18_3:registerTapBtnCustom1(var_18_5)
	var_18_3:setMode(var_0_1.ModeType.union_shop)

	var_18_3._shopInfo = arg_18_0._packages[arg_18_2]

	var_18_3:registerCardSelectedHandler(function(arg_22_0, arg_22_1)
		local var_22_0 = require("CardInfoPanel")

		var_22_0.create(arg_22_0, 1, var_22_0.OperateType.view, var_18_3._shopInfo[arg_22_1]):show()
	end)
	var_18_3:init(Data.BaseCardTypes[1])
	var_18_3._pageLabel:setPositionY(var_18_3._pageLabel:getPositionY())
	var_18_3:refresh(true)

	arg_18_0._cardList = var_18_3

	local var_18_6 = 10

	var_18_3._pageLeft._pos = cc.p(var_18_6, lc.ch(var_18_3))
	var_18_3._pageRight._pos = cc.p(lc.w(var_18_3) - var_18_6, lc.ch(var_18_3))

	local var_18_7 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_18_0._cardList, var_18_7, cc.p(0, lc.ch(var_18_7) + 20), -1)
	var_18_7:setScale(-1, 0.9)
	arg_18_0._cardList._pageLabel:setPosition(cc.p(var_18_7:getPosition()))
end

function var_0_0.updateCardList(arg_23_0)
	arg_23_0._cardList:refresh()
end

return var_0_0
