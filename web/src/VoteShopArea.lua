local var_0_0 = class("VoteShopArea", lc.ExtendCCNode)
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
	ClientData.addMsgListener(arg_6_0, function(arg_7_0)
		return arg_6_0:onMsg(arg_7_0)
	end, 0)
end

function var_0_0.onExit(arg_8_0)
	ClientData.removeMsgListener(arg_8_0)
end

function var_0_0.onCleanUp(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_9_1)
	end
end

function var_0_0.addCardList(arg_10_0)
	local var_10_0 = var_0_1.create(cc.size(lc.w(arg_10_0), lc.h(arg_10_0)), 0.5, false, 220)

	var_10_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_10_0, var_10_0, cc.p(lc.cw(arg_10_0), lc.ch(arg_10_0)), 2)

	local function var_10_1(arg_11_0)
		local var_11_0 = arg_11_0._card

		ClientData.sendBuyVote(var_11_0._id)
		P._playerCard:addCard(var_11_0._infoId, 1)
		P:addResource(var_11_0._priceType, 1, -var_11_0._price)
		require("RewardCardPanel").create(Str(STR.BUYSUCCESS), {
			var_11_0
		}):show()
		lc.Audio.playAudio(AUDIO.E_CARD_GET)
		var_10_0:refresh()
	end

	local function var_10_2(arg_12_0)
		local var_12_0 = arg_12_0._card

		if var_12_0._price > P:getItemCount(var_12_0._priceType) then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(var_12_0._priceType)))
		elseif var_12_0._totalNumer > 0 then
			function arg_10_0.onData(arg_13_0)
				local var_13_0 = math.max(0, var_12_0._totalNumer - arg_13_0)

				if var_13_0 <= 0 then
					return ToastManager.push(Str(STR.SOLD_OUT))
				else
					require("Dialog").showDialog(string.format(Str(STR.SURE_TO_BUY_WITH_LIMIT), var_12_0._totalNumer, var_13_0), function()
						var_10_1(arg_12_0)
					end)
				end
			end

			ClientData.sendGetVoteShopCount(var_12_0._id)
			ClientView.getActiveIndicator():show(Str(STR.WAITING))
		else
			require("Dialog").showDialog(Str(STR.SURE_TO_BUY), function()
				var_10_1(arg_12_0)
			end)
		end
	end

	var_10_0:registerTapBtnCustom1(var_10_2)
	var_10_0:setMode(var_0_1.ModeType.vote_shop)

	local var_10_3 = Data._voteProductsInfo
	local var_10_4 = {}

	for iter_10_0 = 1, table.maxn(var_10_3) do
		local var_10_5 = var_10_3[iter_10_0]

		if var_10_5 then
			local var_10_6 = var_10_5._cardId
			local var_10_7 = ClientData.getServerTick()
			local var_10_8 = tonumber(var_10_5._startData)
			local var_10_9 = tonumber(var_10_5._endData)
			local var_10_10 = true

			if var_10_8 ~= 0 and var_10_7 < var_10_8 or var_10_9 ~= 0 and var_10_9 < var_10_7 then
				var_10_10 = false
			end

			if not ClientData.isActivityForSubChannel(var_10_5) then
				var_10_10 = false
			end

			if var_10_10 then
				local var_10_11 = {
					_infoId = var_10_6,
					_price = var_10_5._cost,
					_priceType = var_10_5._resType,
					_id = var_10_5._id
				}

				for iter_10_1, iter_10_2 in pairs(var_10_5) do
					var_10_11[iter_10_1] = iter_10_2
				end

				table.insert(var_10_4, var_10_11)
			end
		end
	end

	var_10_0._shopInfo = var_10_4

	var_10_0:registerCardSelectedHandler(function(arg_16_0)
		local var_16_0 = require("CardInfoPanel")

		var_16_0.create(arg_16_0, 1, var_16_0.OperateType.view):show()
	end)
	var_10_0:init(Data.BaseCardTypes[1])

	local var_10_12 = 20

	var_10_0._pageLeft._pos = cc.p(-var_10_12, lc.ch(var_10_0))
	var_10_0._pageRight._pos = cc.p(lc.w(var_10_0) + var_10_12, lc.ch(var_10_0))

	var_10_0:refresh(true)

	arg_10_0._cardList = var_10_0
end

function var_0_0.refreshCardList(arg_17_0)
	arg_17_0._cardList:refresh()
end

function var_0_0.onMsg(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.type
	local var_18_1 = arg_18_1.status

	if var_18_0 == SglMsgType_pb.PB_TYPE_SHOP_VOTE_COUNT then
		ClientView.getActiveIndicator():hide()

		if arg_18_0.onData then
			arg_18_0.onData(arg_18_1.Extensions[Shop_pb.SglShopMsg.shop_vote_count_resp])
		end

		return true
	end
end

return var_0_0
