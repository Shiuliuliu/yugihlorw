local var_0_0 = class("MonthCard5ShopArea", lc.ExtendCCNode)
local var_0_1 = require("CardList")

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
	arg_3_0:addCardList()

	local var_3_0 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg1", cc.rect(27, 13, 1, 1))

	var_3_0:setContentSize(cc.size(arg_3_0:getContentSize().width, arg_3_0:getContentSize().height + 20))
	lc.addChildToPos(arg_3_0, var_3_0, cc.p(lc.cw(arg_3_0), lc.ch(arg_3_0) + 20))

	local var_3_1 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_3_1:setContentSize(cc.size(arg_3_0:getContentSize().width + 75, lc.h(var_3_1)))
	lc.addChildToPos(arg_3_0, var_3_1, cc.p(lc.cw(arg_3_0), lc.ch(arg_3_0) + 130))

	local var_3_2 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_3_2:setContentSize(cc.size(arg_3_0:getContentSize().width + 75, lc.h(var_3_2)))
	lc.addChildToPos(arg_3_0, var_3_2, cc.p(lc.cw(arg_3_0), 137))

	local var_3_3 = arg_3_0._cardList
	local var_3_4 = 10

	var_3_3._pageLeft._pos = cc.p(var_3_4, lc.ch(var_3_3))
	var_3_3._pageRight._pos = cc.p(lc.w(var_3_3) - var_3_4, lc.ch(var_3_3))

	local var_3_5 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_3_0._cardList, var_3_5, cc.p(0, lc.ch(var_3_5) + 50), -1)
	var_3_5:setScale(-1, 0.9)
	arg_3_0._cardList._pageLabel:setPosition(cc.p(var_3_5:getPosition()))

	local var_3_6 = {}

	table.insert(var_3_6, lc.addEventListener(Data.Event.gold_dirty, function(arg_4_0)
		if arg_3_0:isVisible() then
			arg_3_0._cardList:refresh()
		end
	end))
	table.insert(var_3_6, lc.addEventListener(Data.Event.card_dirty, function(arg_5_0)
		if arg_3_0:isVisible() then
			arg_3_0._cardList:refresh()
		end
	end))

	arg_3_0._listeners = var_3_6
end

function var_0_0.onEnter(arg_6_0)
	return
end

function var_0_0.onExit(arg_7_0)
	ClientData.removeMsgListener(arg_7_0)
end

function var_0_0.onCleanUp(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_8_1)
	end
end

function var_0_0.addCardList(arg_9_0)
	local var_9_0 = var_0_1.create(cc.size(lc.w(arg_9_0), lc.h(arg_9_0)), 0.5, false, 220)

	var_9_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_9_0, var_9_0, cc.p(lc.cw(arg_9_0), lc.ch(arg_9_0)), 2)

	local function var_9_1(arg_10_0)
		local var_10_0 = arg_10_0._card

		ClientData.sendBuyMonthCard5Product(var_10_0._id)
		P._playerCard:addCard(var_10_0._infoId, 1)
		P:addResource(var_10_0._priceType, 1, -var_10_0._price)
		require("RewardCardPanel").create(Str(STR.BUYSUCCESS), {
			var_10_0
		}):show()
		lc.Audio.playAudio(AUDIO.E_CARD_GET)
		var_9_0:refresh()
	end

	local function var_9_2(arg_11_0)
		local var_11_0 = arg_11_0._card

		if var_11_0._price > P:getItemCount(var_11_0._priceType) then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(var_11_0._priceType)))
		else
			require("Dialog").showDialog(Str(STR.SURE_TO_BUY), function()
				var_9_1(arg_11_0)
			end)
		end
	end

	var_9_0:registerTapBtnCustom1(var_9_2)
	var_9_0:setMode(var_0_1.ModeType.rare_shop)

	local var_9_3 = Data._monthCard5ProductsInfo
	local var_9_4 = {}

	for iter_9_0 = 1, table.maxn(var_9_3) do
		local var_9_5 = var_9_3[iter_9_0]

		if var_9_5 then
			local var_9_6 = var_9_5._cardId
			local var_9_7 = ClientData.getServerTick()
			local var_9_8 = tonumber(var_9_5._date) * 100
			local var_9_9 = true

			if var_9_8 ~= 0 and var_9_7 < var_9_8 then
				var_9_9 = false
			end

			if var_9_9 then
				local var_9_10 = {
					_infoId = var_9_6,
					_price = var_9_5._cost,
					_priceType = var_9_5._resType,
					_id = var_9_5._id
				}

				for iter_9_1, iter_9_2 in pairs(var_9_5) do
					var_9_10[iter_9_1] = iter_9_2
				end

				table.insert(var_9_4, var_9_10)
			end
		end
	end

	var_9_0._shopInfo = var_9_4

	var_9_0:registerCardSelectedHandler(function(arg_13_0)
		local var_13_0 = require("CardInfoPanel")

		var_13_0.create(arg_13_0, 1, var_13_0.OperateType.view):show()
	end)
	var_9_0:init(Data.BaseCardTypes[1])

	local var_9_11 = 20

	var_9_0._pageLeft._pos = cc.p(-var_9_11, lc.ch(var_9_0))
	var_9_0._pageRight._pos = cc.p(lc.w(var_9_0) + var_9_11, lc.ch(var_9_0))

	var_9_0:refresh(true)

	arg_9_0._cardList = var_9_0
end

function var_0_0.refreshCardList(arg_14_0)
	arg_14_0._cardList:refresh()
end

return var_0_0
