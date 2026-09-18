local var_0_0 = class("AncientShopArea", lc.ExtendCCNode)
local var_0_1 = require("CardList")
local var_0_2 = 800
local var_0_3 = 250

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
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
	var_1_0:init(arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._packageType = arg_3_1
	arg_3_0._info = {}

	for iter_3_0, iter_3_1 in ipairs(Data._ancientProductsInfo) do
		if iter_3_1._type == arg_3_1 then
			arg_3_0._info[#arg_3_0._info + 1] = {
				_infoId = iter_3_1._cardId,
				_price = iter_3_1._cost,
				_priceType = iter_3_1._resType,
				_id = iter_3_1._id
			}
		end
	end

	arg_3_0:showCardBox(arg_3_0._info)
end

function var_0_0.onEnter(arg_4_0)
	arg_4_0._listeners = {}
end

function var_0_0.onExit(arg_5_0)
	return
end

function var_0_0.onCleanUp(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_6_1)
	end
end

function var_0_0.showCardBox(arg_7_0, arg_7_1)
	local var_7_0 = cc.Node:create()

	var_7_0:setContentSize(lc.w(arg_7_0), lc.h(arg_7_0))
	var_7_0:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToCenter(arg_7_0, var_7_0)

	arg_7_0._detailPanel = var_7_0

	arg_7_0:addCardList(var_7_0, arg_7_1._type)
	arg_7_0:updateCardList()
	ClientView.getResourceUI():setMode(Data.PropsId.times_package_ticket)
end

function var_0_0.addCardList(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg1", cc.rect(27, 13, 1, 1))

	var_8_0:setContentSize(cc.size(lc.w(arg_8_1) - 95, lc.h(arg_8_1) - 40))
	lc.addChildToPos(arg_8_1, var_8_0, cc.p(lc.cw(arg_8_1), lc.ch(arg_8_1) + 20))

	local var_8_1 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_8_1:setContentSize(cc.size(lc.w(arg_8_1) - 20, lc.h(var_8_1)))
	lc.addChildToPos(arg_8_1, var_8_1, cc.p(lc.cw(arg_8_1), lc.ch(arg_8_1) + 125))

	local var_8_2 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_shop_bg2", cc.rect(61, 30, 1, 1))

	var_8_2:setContentSize(cc.size(lc.w(arg_8_1) - 20, lc.h(var_8_2)))
	lc.addChildToPos(arg_8_1, var_8_2, cc.p(lc.cw(arg_8_1), 130))

	local var_8_3 = var_0_1.create(cc.size(lc.w(arg_8_1) - 100, lc.h(arg_8_1)), 0.5, false, 220)

	var_8_3:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_8_1, var_8_3, cc.p(lc.cw(arg_8_1), lc.ch(var_8_3) + 0))

	local function var_8_4(arg_9_0)
		local var_9_0 = arg_9_0._card
		local var_9_1 = P:getItemCount(var_9_0._priceType)
		local var_9_2 = var_9_0._price
		local var_9_3 = 0

		local function var_9_4()
			ClientData.sendBuyAncient(var_9_0._id)
			P._playerCard:addCard(var_9_0._infoId, 1)
			P:addResource(var_9_0._priceType, nil, -var_9_2)
			P:addResource(Data.PropsId.common_fragment, nil, -var_9_3)
			require("RewardCardPanel").create(Str(STR.BUYSUCCESS), {
				var_9_0
			}):show()
			lc.Audio.playAudio(AUDIO.E_CARD_GET)
			var_8_3:refresh()
		end

		if var_9_0._price > P:getItemCount(var_9_0._priceType) then
			local var_9_5 = var_9_0._price - P:getItemCount(var_9_0._priceType)

			if var_9_5 > P:getItemCount(Data.PropsId.common_fragment) then
				return ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(Data._propsInfo[var_9_0._priceType]._nameSid)))
			else
				var_9_2 = P:getItemCount(var_9_0._priceType)
				var_9_3 = var_9_5

				return require("Dialog").showDialog(string.format(Str(STR.CONFIRM_ANCIENT_REPLACE), P:getItemCount(var_9_0._priceType), ClientData.getNameByInfoId(var_9_0._priceType), var_9_3, ClientData.getNameByInfoId(Data.PropsId.common_fragment)), function()
					var_9_4()
				end)
			end
		else
			var_9_4()
		end
	end

	local function var_8_5(arg_12_0)
		local var_12_0 = arg_12_0._card

		if P._playerCard:getCardCount(var_12_0._infoId) >= (Data.getInfo(var_12_0._infoId)._maxCount or 3) then
			return ToastManager.push(Str(STR.SHOP_CARD_MAX))
		end

		return require("Dialog").showDialog(Str(STR.SURE_TO_BUY), function()
			var_8_4(arg_12_0)
		end)
	end

	var_8_3:registerTapBtnCustom1(var_8_5)
	var_8_3:setMode(var_0_1.ModeType.diamond_shop)

	var_8_3._shopInfo = arg_8_0._info

	var_8_3:registerCardSelectedHandler(function(arg_14_0, arg_14_1)
		local var_14_0 = require("CardInfoPanel")

		var_14_0.create(arg_14_0, 1, var_14_0.OperateType.view, var_8_3._shopInfo[arg_14_1]):show()
	end)
	var_8_3:init(Data.BaseCardTypes[1])
	var_8_3._pageLabel:setPositionY(var_8_3._pageLabel:getPositionY())
	var_8_3:refresh(true)

	arg_8_0._cardList = var_8_3

	local var_8_6 = 10

	var_8_3._pageLeft._pos = cc.p(var_8_6, lc.ch(var_8_3))
	var_8_3._pageRight._pos = cc.p(lc.w(var_8_3) - var_8_6, lc.ch(var_8_3))

	local var_8_7 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_8_0._cardList, var_8_7, cc.p(0, lc.ch(var_8_7) + 50), -1)
	var_8_7:setScale(-1, 0.9)
	arg_8_0._cardList._pageLabel:setPosition(cc.p(var_8_7:getPosition()))
end

function var_0_0.updateCardList(arg_15_0)
	arg_15_0._cardList:refresh()
end

return var_0_0
