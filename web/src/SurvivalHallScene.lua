local var_0_0 = class("SurvivalHallScene", BaseUIScene)
local var_0_1 = require("PlayerFindSurvival")
local var_0_2 = require("CardThumbnail")
local var_0_3 = require("CardInfoPanel")
local var_0_4 = 320
local var_0_5 = 500
local var_0_6 = 0.45
local var_0_7 = 0.45
local var_0_8 = math.floor((ClientView.SCR_W - 150) / (ClientView.CARD_SIZE.width * var_0_6 + 10))

var_0_0.TouchStatus = {
	press = 1,
	tap = 3,
	move = 2
}

local var_0_9 = {
	vertical = 2,
	horizontal = 1,
	none = 0
}
local var_0_10 = {
	troop_card = 1,
	select_card = 2
}

function var_0_0.create()
	return lc.createScene(var_0_0)
end

function var_0_0.init(arg_2_0)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.survival_hall, STR.HALL, BaseUIScene.STYLE_EMPTY, true) then
		return false
	end

	if P and P._playerFindSurvival then
		P._playerFindSurvival._isInHall = true
	end

	arg_2_0:createTopArea()

	function arg_2_0._titleArea._btnBack._callback()
		arg_2_0:onExitHall()
	end

	return true
end

function var_0_0.createTopArea(arg_4_0)
	local var_4_0 = lc.createSprite({
		_name = "img_survival_time_bg",
		_crect = cc.rect(0, 0, 39, 163),
		_size = cc.size(lc.w(arg_4_0), 120)
	})

	lc.addChildToPos(arg_4_0, var_4_0, cc.p(lc.cw(arg_4_0), lc.bottom(arg_4_0._titleArea) - lc.ch(var_4_0)))

	local var_4_1 = ClientView.createTTF(Str(STR.SURVIVAL_REST_TIME), ClientView.FontSize.S1, ClientView.COLOR_TEXT_INGOT)

	lc.addChildToPos(var_4_0, var_4_1, cc.p(lc.cw(var_4_0) - 200, lc.ch(var_4_0) + 20))

	local var_4_2 = ClientView.createLabelProgressBar(300)

	lc.addChildToPos(var_4_0, var_4_2, cc.p(lc.right(var_4_1) + lc.cw(var_4_2), lc.y(var_4_1)))

	local var_4_3 = ClientView.createTTF(Str(STR.SURVIVAL_DIE_TIP), ClientView.FontSize.S3)

	lc.addChildToPos(var_4_0, var_4_3, cc.p(lc.x(var_4_2), lc.ch(var_4_0) - 20))

	local var_4_4 = ClientView.createTTF(Str(STR.REMIAN_PLAYERS), ClientView.FontSize.S1)

	lc.addChildToPos(var_4_0, var_4_4, cc.p(100, lc.ch(var_4_0) + 20))

	local var_4_5 = lc.createSprite({
		_name = "img_com_bg_42",
		_crect = ClientView.CRECT_COM_BG42,
		_size = cc.size(100, 36)
	})

	lc.addChildToPos(var_4_0, var_4_5, cc.p(lc.x(var_4_4), lc.ch(var_4_0) - 20))

	local var_4_6 = ClientView.createTTF("", ClientView.FontSize.S1)

	lc.addChildToCenter(var_4_5, var_4_6)

	local var_4_7 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_5_0)
		arg_4_0:startExplore()
	end, ClientView.CRECT_BUTTON, 140)

	var_4_7:addLabel(Str(STR.EXPLORE))
	lc.addChildToPos(var_4_0, var_4_7, cc.p(lc.w(var_4_0) - lc.cw(var_4_7) - 30, lc.ch(var_4_0)))

	local var_4_8 = Particle.create("tansuotexiao")

	lc.addChildToCenter(var_4_7, var_4_8, -1)

	function var_4_0.update()
		local var_6_0 = ClientData.getCurrentTime()
		local var_6_1 = P._playerFindSurvival._dieTimeStamp - var_6_0
		local var_6_2 = ClientView.getActiveIndicator()

		if var_6_1 < 0 then
			if not var_6_2._isShowing then
				var_6_2:show(Str(STR.WAITTING_ACCOUNT))
			end
		else
			ClientView.getActiveIndicator():hide()
		end

		local var_6_3 = math.max(var_6_1, 0)
		local var_6_4 = var_6_3 / 480 * 100

		var_4_2._bar:setPercent(var_6_4)
		var_4_2._label:setString(ClientData.formatTime(var_6_3))
		var_4_6:setString(P._playerFindSurvival._hallUserNum or 1)
	end

	var_4_0:runAction(lc.rep(lc.sequence(0, function()
		if not P._playerFindSurvival._isInHall then
			var_4_0:stopAllActions()
			arg_4_0:hide()

			return
		end

		var_4_0.update()
	end, 1)))

	arg_4_0._topArea = var_4_0
end

function var_0_0.startExplore(arg_8_0)
	if ClientView._explorePanel then
		return
	end

	if P._playerFindSurvival:isTroopValid() then
		require("ExplorePanel").create():show()
	else
		ToastManager.push(string.format(Str(STR.SURVIVAL_TROOP_TIP), var_0_1.MAX_TROOP_COUNT))
	end
end

function var_0_0.createSelectCardsArea(arg_9_0)
	local var_9_0 = ClientView.createFrameBox(cc.size(lc.w(arg_9_0), 260))

	lc.addChildToPos(arg_9_0, var_9_0, cc.p(lc.cw(arg_9_0), 400))

	local var_9_1 = lc.createSprite("img_troop_name_bg")

	lc.addChildToPos(var_9_0, var_9_1, cc.p(lc.cw(var_9_1) + 25, lc.h(var_9_0) + lc.ch(var_9_1) - 15))

	local var_9_2 = ClientView.createTTF(Str(STR.OPTIONAL) .. Str(STR.TROOP), ClientView.FontSize.M2, ClientView.COLOR_TEXT_BLUE)

	var_9_2:enableShadow()
	lc.addChildToPos(var_9_1, var_9_2, cc.p(lc.cw(var_9_2) + 10, lc.ch(var_9_1)))

	arg_9_0._thumbnails = {}

	local var_9_3 = 10
	local var_9_4 = ClientView.CARD_SIZE.width * var_0_6
	local var_9_5 = lc.List.createH(cc.size(lc.w(var_9_0) - 180, lc.h(var_9_0)), var_9_3, var_9_3)

	var_9_5:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(var_9_0, var_9_5)
	lc.offset(var_9_5, 0, 5)

	arg_9_0._selectCardList = var_9_5

	arg_9_0:initThumbnails()

	arg_9_0._curPage = 1

	local var_9_6 = cc.p(90, lc.ch(var_9_0))
	local var_9_7 = ClientView.createPageArrow(true, var_9_6, function()
		if arg_9_0._curPage > 1 then
			arg_9_0._curPage = arg_9_0._curPage - 1
		end

		arg_9_0:updateSelectCards()
	end)

	lc.addChildToPos(var_9_0, var_9_7, var_9_6)
	var_9_7:float()

	arg_9_0._pageLeft = var_9_7

	local var_9_8 = cc.p(lc.w(var_9_0) - 90, lc.ch(var_9_0))
	local var_9_9 = ClientView.createPageArrow(false, var_9_8, function()
		if arg_9_0._curPage < math.ceil(#P._playerFindSurvival._captures / var_0_8) then
			arg_9_0._curPage = arg_9_0._curPage + 1
		end

		arg_9_0:updateSelectCards()
	end)

	lc.addChildToPos(var_9_0, var_9_9, var_9_8)
	var_9_9:float()

	arg_9_0._pageRight = var_9_9

	local var_9_10 = ClientView.createTTF(Str(STR.OPTIONAL_TROOP_TIP), ClientView.FontSize.S1)

	lc.addChildToCenter(var_9_0, var_9_10)

	var_9_0._tip = var_9_10

	return var_9_0
end

function var_0_0.initThumbnails(arg_12_0)
	local var_12_0 = arg_12_0._selectCardList

	var_12_0:removeAllItems()

	local var_12_1 = ClientView.CARD_SIZE.width * var_0_6

	for iter_12_0 = 1, var_0_8 do
		local var_12_2 = 10001
		local var_12_3 = ccui.Layout:create()

		var_12_3:setContentSize(cc.size(var_12_1, 270))
		var_12_3:setAnchorPoint(0.5, 0.5)
		var_12_0:pushBackCustomItem(var_12_3)

		local var_12_4 = var_0_2.createFromPool(var_12_2, var_0_6)

		var_12_4._thumbnail:setTouchEnabled(true)
		var_12_4._thumbnail:addTouchEventListener(function(arg_13_0, arg_13_1)
			arg_12_0:onTouchThumbnail(arg_13_0, arg_13_1, var_0_10.select_card)
		end)
		lc.addChildToCenter(var_12_3, var_12_4)
		table.insert(arg_12_0._thumbnails, var_12_4)
	end
end

function var_0_0.updateSelectCards(arg_14_0)
	local var_14_0 = P._playerFindSurvival._captures

	arg_14_0._totalPage = math.ceil(#var_14_0 / var_0_8)
	arg_14_0._curPage = math.max(math.min(arg_14_0._curPage, arg_14_0._totalPage), 1)

	local var_14_1 = {}

	for iter_14_0 = (arg_14_0._curPage - 1) * var_0_8 + 1, arg_14_0._curPage * var_0_8 do
		var_14_1[#var_14_1 + 1] = var_14_0[iter_14_0]
	end

	for iter_14_1, iter_14_2 in ipairs(arg_14_0._thumbnails) do
		iter_14_2._card = nil

		iter_14_2:setVisible(false)
	end

	for iter_14_3 = 1, #var_14_1 do
		local var_14_2 = var_14_1[iter_14_3]
		local var_14_3 = arg_14_0._thumbnails[iter_14_3]

		if not var_14_3 then
			break
		end

		var_14_3._card = var_14_2

		var_14_3._thumbnail:updateComponent(var_14_2._infoId)
		var_14_3._countArea:update(true, var_14_2._num)
		var_14_3:setVisible(true)

		var_14_3._thumbnail._frame:setEffect(nil)
		var_14_3._isValid = true
	end

	arg_14_0._pageLeft:setVisible(arg_14_0._curPage > 1)
	arg_14_0._pageLeft:float()
	arg_14_0._pageRight:setVisible(arg_14_0._curPage < arg_14_0._totalPage)
	arg_14_0._pageRight:float()
	arg_14_0._selectCardsArea._tip:setVisible(#var_14_0 <= 0)
end

function var_0_0.updateTroopList(arg_15_0)
	local var_15_0 = arg_15_0:remainItemFromList()

	arg_15_0:releaseTroopCards()

	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(P._playerFindSurvival._troopCards) do
		local var_15_2

		for iter_15_2 = 1, #var_15_0 do
			if var_15_0[iter_15_2]._card._infoId == iter_15_1._infoId then
				var_15_2 = var_15_0[iter_15_2]

				break
			end
		end

		if not var_15_2 then
			var_15_2 = ccui.Layout:create()

			var_15_2:retain()

			local var_15_3 = var_0_2.createFromPool(iter_15_1._infoId, var_0_7)

			var_15_3._countArea:update(true, iter_15_1._num)
			var_15_2:setContentSize(var_15_3._thumbnail:getContentSize())
			var_15_2:setAnchorPoint(cc.p(0.5, 0.5))
			lc.addChildToPos(var_15_2, var_15_3, cc.p(lc.cw(var_15_2), lc.ch(var_15_2) + 10))
			var_15_3._thumbnail:setTouchEnabled(true)
			var_15_3._thumbnail:addTouchEventListener(function(arg_16_0, arg_16_1)
				arg_15_0:onTouchThumbnail(arg_16_0, arg_16_1, var_0_10.troop_card)
			end)

			var_15_2._item = var_15_3
		else
			var_15_2._item._countArea:update(true, iter_15_1._num)
		end

		table.insert(var_15_1, var_15_2)

		var_15_2._card = iter_15_1
	end

	table.sort(var_15_1, function(arg_17_0, arg_17_1)
		local var_17_0 = Data.getOriginId(arg_17_0._card._infoId)
		local var_17_1 = Data.getOriginId(arg_17_1._card._infoId)

		if var_17_0 < var_17_1 then
			return true
		elseif var_17_1 < var_17_0 then
			return false
		else
			return arg_17_0._card._infoId < arg_17_1._card._infoId
		end
	end)

	for iter_15_3, iter_15_4 in ipairs(var_15_1) do
		arg_15_0._troopList:pushBackCustomItem(iter_15_4)
	end

	local var_15_4, var_15_5, var_15_6, var_15_7, var_15_8 = P._playerFindSurvival:getTroopCardCount()
	local var_15_9 = string.format(lc.str(STR.FIND_SURVIVAL_TIPS), var_15_4, P._playerFindSurvival.MAX_TROOP_COUNT, var_15_5 + var_15_6, var_15_7 + var_15_8)

	arg_15_0._troopDescLabel:setString(var_15_9)
end

function var_0_0.releaseSelectCards(arg_18_0)
	if #arg_18_0._thumbnails > 0 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._thumbnails) do
			var_0_2.releaseToPool(iter_18_1)
		end

		arg_18_0._thumbnails = {}
	end
end

function var_0_0.releaseTroopCards(arg_19_0)
	if arg_19_0._troopList then
		local var_19_0 = arg_19_0._troopList:getItems()

		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			var_0_2.releaseToPool(iter_19_1._item)
			iter_19_1:release()
		end

		arg_19_0._troopList:removeAllItems()
	end
end

function var_0_0.createTroopArea(arg_20_0)
	local var_20_0 = lc.createSprite({
		_name = "img_troop_bg_1",
		_size = cc.size(lc.w(arg_20_0), 212),
		_crect = cc.rect(47, 0, 1, 212)
	})

	lc.addChildToPos(arg_20_0, var_20_0, cc.p(lc.cw(arg_20_0), lc.ch(var_20_0)))

	local var_20_1 = lc.createSprite("img_troop_name_bg")

	lc.addChildToPos(var_20_0, var_20_1, cc.p(lc.cw(var_20_1) + 25, lc.h(var_20_0) + lc.ch(var_20_1)))

	local var_20_2 = ClientView.createTTF(Str(STR.PUBG), ClientView.FontSize.M2, ClientView.COLOR_TEXT_BLUE)

	var_20_2:enableShadow()
	lc.addChildToPos(var_20_1, var_20_2, cc.p(lc.cw(var_20_2) + 10, lc.ch(var_20_1)))

	local var_20_3 = lc.List.createH(cc.size(lc.w(var_20_0) - 40, lc.h(var_20_0) - 6), 20, 10)

	lc.addChildToPos(var_20_0, var_20_3, cc.p(24, 0))

	arg_20_0._troopList = var_20_3

	local var_20_4 = P._playerFindSurvival
	local var_20_5 = string.format(lc.str(STR.FIND_SURVIVAL_TIPS), var_20_4.MAX_TROOP_COUNT, var_20_4.MAX_TROOP_COUNT, var_20_4.MAX_TROOP_COUNT, var_20_4.MAX_TROOP_COUNT)
	local var_20_6 = ClientView.createTTF(var_20_5, ClientView.FontSize.S1, lc.Color3B.black)
	local var_20_7 = lc.createSprite({
		_name = "img_tip_bg2",
		_size = cc.size(lc.w(var_20_6) + 40 + 40, 51),
		_crect = cc.rect(36, 25, 1, 1)
	})

	lc.addChildToPos(var_20_0, var_20_7, cc.p(lc.right(var_20_1) + 230, lc.h(var_20_0) + lc.ch(var_20_7) + 10))
	lc.addChildToPos(var_20_7, var_20_6, cc.p(lc.cw(var_20_6) + 40, lc.ch(var_20_7)))

	arg_20_0._troopDescLabel = var_20_6

	return var_20_0
end

function var_0_0.onTouchThumbnail(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_1:stopAllActions()

	if arg_21_2 == ccui.TouchEventType.began then
		arg_21_1:runAction(lc.scaleTo(0.1, 0.95))
		arg_21_0:onItemPress(arg_21_1, arg_21_3)
	elseif arg_21_2 == ccui.TouchEventType.ended or arg_21_2 == ccui.TouchEventType.canceled then
		arg_21_1:runAction(lc.scaleTo(0.08, 1))
		arg_21_0:onItemTap(arg_21_1, arg_21_3)
	elseif arg_21_2 == ccui.TouchEventType.moved then
		arg_21_0:onItemMove(arg_21_1, arg_21_3)
	end
end

function var_0_0.onItemPress(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0._movingSprite then
		return
	end

	arg_22_0._touchStatus = var_0_0.TouchStatus.press
	arg_22_0._movingDir = var_0_9.none
end

function var_0_0.onItemMove(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0._touchStatus == var_0_0.TouchStatus.tap then
		return
	end

	arg_23_0._touchStatus = var_0_0.TouchStatus.move

	if arg_23_0._movingSprite == nil then
		if arg_23_0._movingDir == var_0_9.none then
			local var_23_0 = math.abs(cc.pSub(arg_23_1:getTouchMovePosition(), arg_23_1:getTouchBeganPosition()).x)
			local var_23_1 = math.abs(cc.pSub(arg_23_1:getTouchMovePosition(), arg_23_1:getTouchBeganPosition()).y)

			if var_23_0 > 32 or var_23_1 > 32 then
				arg_23_0._movingDir = var_23_1 <= var_23_0 and var_0_9.horizontal or var_0_9.vertical
			end
		end

		if arg_23_0._movingDir == var_0_9.vertical and (arg_23_2 == var_0_10.troop_card or arg_23_1._item._isValid) then
			arg_23_0:createMovingSpriteAndMaskLayer(arg_23_1, arg_23_2)
		end
	end

	if arg_23_0._movingSprite then
		arg_23_0._movingSprite:setPosition(cc.pAdd(arg_23_0._movingSprite._srcPos, cc.pSub(arg_23_1:getTouchMovePosition(), arg_23_1:getTouchBeganPosition())))
		arg_23_0:checkList(arg_23_2 == var_0_10.troop_card and arg_23_0._selectCardList or arg_23_0._troopList)
	end
end

function var_0_0.checkList(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1 == arg_24_0._troopList
	local var_24_1

	var_24_1 = var_24_0 and 0.5 or 0

	local var_24_2 = arg_24_0._movingSprite

	if var_24_0 then
		arg_24_0._isInList = arg_24_0._separatorPos > lc.y(var_24_2)
	else
		arg_24_0._isInList = arg_24_0._separatorPos < lc.y(var_24_2)
	end
end

function var_0_0.onItemTap(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0._touchStatus = var_0_0.TouchStatus.tap

	local var_25_0 = arg_25_1._infoId
	local var_25_1 = Data.getInfo(var_25_0)
	local var_25_2 = P._playerFindSurvival:getTroopCardCount(var_25_0)

	if arg_25_0._movingDir == var_0_9.none then
		if arg_25_2 == var_0_10.troop_card then
			local var_25_3 = {}
			local var_25_4 = 0
			local var_25_5 = arg_25_0._troopList:getItems()

			for iter_25_0 = 1, #var_25_5 do
				local var_25_6 = var_25_5[iter_25_0]._item._thumbnail

				var_25_3[#var_25_3 + 1] = {
					_infoId = var_25_6._infoId,
					_num = var_25_6._count
				}

				if arg_25_1 == var_25_6 then
					var_25_4 = iter_25_0
				end
			end

			local var_25_7 = var_0_3.create(var_25_0, 1, var_0_3.OperateType.na)

			var_25_7:setCardList(var_25_3, var_25_4, Str(STR.CUR_TROOP))
			var_25_7:setCardCount(arg_25_1._count)
			var_25_7:show()
		else
			var_0_3.create(var_25_0, 1, var_0_3.OperateType.na):show()
		end
	elseif arg_25_0._movingSprite and arg_25_0._isInList then
		if arg_25_2 == var_0_10.select_card then
			if P._playerFindSurvival:getTroopCardCount() >= P._playerFindSurvival.MAX_TROOP_COUNT then
				ToastManager.push(Str(STR.FULL_IN_TROOP))
			else
				P._playerFindSurvival:captures2Troop(var_25_0, 1)

				local var_25_8 = arg_25_0._movingSprite._srcPos

				arg_25_0:updateSelectCards()
				arg_25_0:runAction(lc.sequence(0, function()
					arg_25_0:playAction(var_25_0, true, var_25_8)
				end))
			end
		else
			P._playerFindSurvival:captures2Troop(var_25_0, -1)

			local var_25_9 = arg_25_0._movingSprite._srcPos

			arg_25_0:updateSelectCards()
			arg_25_0:runAction(lc.sequence(0, function()
				arg_25_0:playAction(var_25_0, false, var_25_9)
			end))
		end

		arg_25_0:updateTroopList()
	end

	if arg_25_0._maskLayer then
		arg_25_0._maskLayer:removeFromParent(true)

		arg_25_0._maskLayer = nil
	end

	if arg_25_0._movingSprite then
		arg_25_0._movingSprite:removeFromParent()

		arg_25_0._movingSprite = nil
	end

	if arg_25_0._selectCardList then
		arg_25_0._selectCardList:setIsScrollEnabled(true)
	end

	if arg_25_0._troopList then
		arg_25_0._troopList:setIsScrollEnabled(true)
	end
end

function var_0_0.createMovingSpriteAndMaskLayer(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2 == var_0_10.select_card and arg_28_0._troopList or arg_28_0._selectCardList

	;(arg_28_2 == var_0_10.select_card and arg_28_0._selectCardList or arg_28_0._troopList):setIsScrollEnabled(false)

	local var_28_1 = arg_28_1:convertToWorldSpace(cc.p(lc.w(arg_28_1) / 2, lc.h(arg_28_1) / 2))
	local var_28_2 = arg_28_0:convertToNodeSpace(var_28_1)
	local var_28_3 = arg_28_1._infoId
	local var_28_4 = var_0_2.create(var_28_3, var_0_6)

	arg_28_0:addChild(var_28_4, ClientData.ZOrder.ui + 2)

	arg_28_0._movingSprite = var_28_4
	arg_28_0._movingSprite._srcPos = var_28_2
	arg_28_0._movingSprite._abc = 1

	arg_28_0._movingSprite:setPosition(cc.pAdd(var_28_2, cc.pSub(arg_28_1:getTouchMovePosition(), arg_28_1:getTouchBeganPosition())))

	local var_28_5 = var_28_0:convertToWorldSpace(cc.p(0, 0))
	local var_28_6 = arg_28_0:convertToNodeSpace(var_28_5)

	var_28_6.x = 0

	local var_28_7 = cc.rect(var_28_6.x, var_28_6.y, lc.w(arg_28_0), lc.h(var_28_0))
	local var_28_8 = cc.LayerColor:create(cc.c4b(0, 0, 0, 192), lc.w(arg_28_0), lc.h(arg_28_0))

	arg_28_0._maskLayer = ClientView.createClipNode(var_28_8, var_28_7, true)

	arg_28_0:addChild(arg_28_0._maskLayer, ClientData.ZOrder.ui + 1)

	arg_28_0._separatorPos = arg_28_2 == var_0_10.select_card and var_28_6.y + var_28_7.height or var_28_6.y
end

function var_0_0.remainItemFromList(arg_29_0)
	local var_29_0 = {}
	local var_29_1 = arg_29_0._troopList:getItems()

	for iter_29_0 = #var_29_1, 1, -1 do
		local var_29_2 = var_29_1[iter_29_0]
		local var_29_3 = false

		for iter_29_1, iter_29_2 in ipairs(P._playerFindSurvival._troopCards) do
			if var_29_2._card._infoId == iter_29_2._infoId then
				var_29_3 = true

				break
			end
		end

		if var_29_3 then
			table.insert(var_29_0, var_29_2)
			arg_29_0._troopList:removeItem(iter_29_0 - 1, false)
		end
	end

	return var_29_0
end

function var_0_0.playAction(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0:runAction(lc.sequence(lc.delay(0), lc.call(function()
		local var_31_0 = cc.Node:create()

		arg_30_0:addChild(var_31_0)

		local var_31_1 = Particle.create("sz1")

		lc.addChildToCenter(var_31_0, var_31_1)

		local var_31_2 = Particle.create("sz2")

		lc.addChildToCenter(var_31_0, var_31_2)

		local var_31_3 = arg_30_3
		local var_31_4

		if arg_30_2 then
			var_31_4 = cc.p(lc.cw(arg_30_0), lc.ch(arg_30_0._troopList))

			local var_31_5 = arg_30_0._troopList:getItems()

			for iter_31_0, iter_31_1 in ipairs(var_31_5) do
				if iter_31_1._card._infoId == arg_30_1 then
					var_31_4 = arg_30_0:convertToNodeSpace(iter_31_1:convertToWorldSpace(cc.p(lc.cw(iter_31_1), lc.ch(iter_31_1))))

					break
				end
			end
		else
			var_31_4 = cc.p(lc.x(arg_30_0._selectCardsArea), lc.y(arg_30_0._selectCardsArea))

			local var_31_6

			for iter_31_2, iter_31_3 in ipairs(P._playerFindSurvival._captures) do
				if iter_31_3._infoId == arg_30_1 then
					var_31_6 = math.ceil(iter_31_2 / var_0_8)

					break
				end
			end

			var_31_6 = var_31_6 or math.ceil(#P._playerFindSurvival._captures / var_0_8)

			if arg_30_0._curPage ~= var_31_6 then
				var_31_4 = var_31_6 < arg_30_0._curPage and cc.p(lc.left(arg_30_0._selectCardsArea), lc.y(arg_30_0._selectCardsArea)) or cc.p(lc.right(arg_30_0._selectCardsArea), lc.y(arg_30_0._selectCardsArea))
			else
				for iter_31_4, iter_31_5 in ipairs(arg_30_0._thumbnails) do
					if iter_31_5._card and iter_31_5._card._infoId == arg_30_1 then
						var_31_4 = arg_30_0:convertToNodeSpace(iter_31_5:convertToWorldSpace(cc.p(lc.cw(iter_31_5), lc.ch(iter_31_5))))

						break
					end
				end
			end
		end

		var_31_0:setPosition(var_31_3)
		var_31_0:setScale(2)
		var_31_0:runAction(lc.sequence(lc.moveTo(0.4, var_31_4), lc.call(function()
			var_31_1:setDuration(0.1)
			var_31_2:setDuration(0.1)
		end), lc.delay(1), lc.remove()))
	end)))
end

function var_0_0.onExitHall(arg_33_0)
	if P._playerFindSurvival._isInHall then
		local var_33_0 = Str(STR.CONFIRM_EXIT_SURVIVAL)

		require("Dialog").showDialog(var_33_0, function()
			ClientView.getActiveIndicator():show(Str(STR.WAITING))
			ClientData.sendSurvivalQuit()
		end)
	else
		arg_33_0:hide()
	end
end

function var_0_0.onChangeToBattle(arg_35_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendToggleRoomMatch()
end

function var_0_0.startMatch(arg_36_0)
	ClientData.sendSurvivalExploreStart()
end

function var_0_0.syncData(arg_37_0)
	var_0_0.super.syncData(arg_37_0)

	if not P._playerFindSurvival._isInHall then
		return arg_37_0:hide()
	end

	arg_37_0:refreshView()
end

function var_0_0.reload(arg_38_0, arg_38_1)
	var_0_0.super:reload(arg_38_1)

	if not P._playerFindSurvival._isInHall then
		return arg_38_0:hide()
	end

	arg_38_0:refreshView()
end

function var_0_0.onEnterSurvivalHall(arg_39_0)
	if arg_39_0._isLogin then
		arg_39_0:onLogin()

		arg_39_0._isLogin = false
	end

	arg_39_0:refreshView()
end

function var_0_0.refreshView(arg_40_0)
	if not arg_40_0._thumbnails or #arg_40_0._thumbnails == 0 then
		arg_40_0:initThumbnails()
	end

	arg_40_0:updateSelectCards()
	arg_40_0:updateTroopList()
	arg_40_0._topArea.update()
end

function var_0_0.checkSurvivalBonus(arg_41_0)
	local var_41_0 = P._playerFindSurvival

	if var_41_0._rewards or var_41_0._getSeconds and var_41_0._getSeconds > 0 then
		require("SurvivalBonusPanel").create():show()
		var_41_0:clearBonus()
	end
end

function var_0_0.onEnter(arg_42_0)
	var_0_0.super.onEnter(arg_42_0)

	if not arg_42_0._troopArea then
		arg_42_0._troopArea = arg_42_0:createTroopArea()

		arg_42_0:updateTroopList()
	end

	if not arg_42_0._selectCardsArea then
		arg_42_0._selectCardsArea = arg_42_0:createSelectCardsArea()

		arg_42_0:updateSelectCards()
	end

	ClientView.getResourceUI():setVisible(false)

	local var_42_0 = {}

	arg_42_0._listeners = var_42_0

	table.insert(var_42_0, lc.addEventListener(Data.Event.survival_info_dirty, function(arg_43_0)
		arg_42_0:refreshView()
	end))
	table.insert(var_42_0, lc.addEventListener(Data.Event.survival_game_over, function(arg_44_0)
		arg_42_0:hide()
	end))
	table.insert(var_42_0, lc.addEventListener(Data.Event.survival_explore_end, function(arg_45_0)
		arg_42_0:checkSurvivalBonus()
		arg_42_0:updateSelectCards()
	end))
	arg_42_0:refreshView()

	if not P._playerFindSurvival._isInHall then
		return arg_42_0:hide()
	end

	arg_42_0:checkSurvivalBonus()
end

function var_0_0.onExit(arg_46_0)
	var_0_0.super.onExit(arg_46_0)
	ClientView.getResourceUI():setVisible(true)

	for iter_46_0 = 1, #arg_46_0._listeners do
		lc.Dispatcher:removeEventListener(arg_46_0._listeners[iter_46_0])
	end

	arg_46_0:releaseSelectCards()
	arg_46_0:releaseTroopCards()
end

function var_0_0.onCleanup(arg_47_0)
	var_0_0.super.onCleanup(arg_47_0)
	arg_47_0:releaseSelectCards()
	arg_47_0:releaseTroopCards()
end

return var_0_0
