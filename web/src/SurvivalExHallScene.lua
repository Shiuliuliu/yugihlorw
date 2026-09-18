local var_0_0 = class("SurvivalExHallScene", BaseUIScene)
local var_0_1 = require("PlayerFindSurvivalEx")
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
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.survival_ex_hall, STR.HALL, BaseUIScene.STYLE_EMPTY, true) then
		return false
	end

	arg_2_0:setEx(false)
	arg_2_0:createTopArea()

	function arg_2_0._titleArea._btnBack._callback()
		arg_2_0:onExitHall()
	end

	return true
end

function var_0_0.setEx(arg_4_0, arg_4_1)
	arg_4_0._isEx = arg_4_1
	arg_4_0._maxTroopCount = arg_4_1 and P._playerFindSurvivalEx.MAX_TROOP_COUNT_EX or P._playerFindSurvivalEx.MAX_TROOP_COUNT
end

function var_0_0.createTopArea(arg_5_0)
	local var_5_0 = lc.createSprite({
		_name = "img_survival_time_bg",
		_crect = cc.rect(0, 0, 39, 163),
		_size = cc.size(lc.w(arg_5_0), 120)
	})

	lc.addChildToPos(arg_5_0, var_5_0, cc.p(lc.cw(arg_5_0), lc.bottom(arg_5_0._titleArea) - lc.ch(var_5_0)))

	local var_5_1 = ClientView.createTTF(Str(STR.SURVIVAL_EX_REST_TIME), ClientView.FontSize.S1, ClientView.COLOR_TEXT_INGOT)

	lc.addChildToPos(var_5_0, var_5_1, cc.p(lc.cw(var_5_0) - 120, lc.ch(var_5_0) + 20))

	local var_5_2 = ClientView.createLabelProgressBar(300)

	lc.addChildToPos(var_5_0, var_5_2, cc.p(lc.right(var_5_1) + lc.cw(var_5_2), lc.y(var_5_1)))

	local var_5_3 = ClientView.createTTF(Str(STR.SURVIVAL_EX_DIE_TIP), ClientView.FontSize.S3)

	lc.addChildToPos(var_5_0, var_5_3, cc.p(lc.x(var_5_2), lc.ch(var_5_0) - 20))

	local var_5_4 = ClientView.createTTF(lc.str(STR.BATTLE_LOSE_COUNT), ClientView.FontSize.S1, ClientView.COLOR_GLOW_BLUE)

	lc.addChildToPos(var_5_0, var_5_4, cc.p(lc.cw(var_5_0) - 270, lc.ch(var_5_0) + 20))

	arg_5_0._loseSprites = {}

	for iter_5_0 = 1, 2 do
		local var_5_5 = lc.createSprite("img_troop_bg_4")

		lc.addChildToPos(var_5_0, var_5_5, cc.p(lc.x(var_5_4) + 80 * (iter_5_0 - 1.5), lc.bottom(var_5_4) - lc.ch(var_5_5)))

		local var_5_6 = lc.createSprite("img_troop_x")

		lc.addChildToPos(var_5_5, var_5_6, cc.p(lc.cw(var_5_5), lc.ch(var_5_5)))

		arg_5_0._loseSprites[iter_5_0] = var_5_6
	end

	local var_5_7 = ClientView.createTTF(Str(STR.REMIAN_PLAYERS), ClientView.FontSize.S1)

	lc.addChildToPos(var_5_0, var_5_7, cc.p(100, lc.ch(var_5_0) + 20))

	local var_5_8 = lc.createSprite({
		_name = "img_com_bg_42",
		_crect = ClientView.CRECT_COM_BG42,
		_size = cc.size(100, 36)
	})

	lc.addChildToPos(var_5_0, var_5_8, cc.p(lc.x(var_5_7), lc.ch(var_5_0) - 20))

	local var_5_9 = ClientView.createTTF("", ClientView.FontSize.S1)

	lc.addChildToCenter(var_5_8, var_5_9)

	local var_5_10 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_6_0)
		arg_5_0:startExplore()
	end, ClientView.CRECT_BUTTON, 140)

	var_5_10:addLabel(Str(STR.EXPLORE))
	lc.addChildToPos(var_5_0, var_5_10, cc.p(lc.w(var_5_0) - lc.cw(var_5_10) - 30, lc.ch(var_5_0)))

	local var_5_11 = Particle.create("tansuotexiao")

	lc.addChildToCenter(var_5_10, var_5_11, -1)

	local var_5_12 = ClientView.createTTF(Str(STR.SKILL_POOL), ClientView.FontSize.M2)

	var_5_12:setAnchorPoint(0, 0)
	lc.addChildToPos(var_5_0, var_5_12, cc.p(200, -74))

	arg_5_0._skillTitle = var_5_12

	local var_5_13 = lc.List.createH(cc.size(lc.w(arg_5_0) - 10 - lc.right(var_5_12), 75))

	lc.addChildToPos(var_5_0, var_5_13, cc.p(lc.right(var_5_12), lc.y(var_5_12)), 1)
	lc.offset(var_5_12, 0, 20)

	local var_5_14 = lc.createSprite({
		_name = "img_troop_bg_4",
		_size = cc.size(lc.w(var_5_13) - 6, lc.h(var_5_13)),
		_crect = cc.rect(5, 5, 1, 1)
	})

	var_5_14:setAnchorPoint(0, 0)
	lc.addChildToPos(var_5_0, var_5_14, cc.p(var_5_13:getPosition()))
	lc.offset(var_5_14, -3, 0)

	function var_5_0.update()
		local var_7_0 = ClientData.getCurrentTime()
		local var_7_1 = P._playerFindSurvivalEx._dieTimeStamp - var_7_0
		local var_7_2 = ClientView.getActiveIndicator()

		if var_7_1 < 0 then
			if not var_7_2._isShowing then
				var_7_2:show(Str(STR.WAITTING_ACCOUNT))
			end
		else
			ClientView.getActiveIndicator():hide()
		end

		local var_7_3 = math.max(var_7_1, 0)
		local var_7_4 = var_7_3 / 480 * 100

		var_5_2._bar:setPercent(var_7_4)
		var_5_2._label:setString(ClientData.formatTime(var_7_3))
		var_5_9:setString(P._playerFindSurvivalEx._hallUserNum or 0)

		local var_7_5 = P._playerFindSurvivalEx._skills[1]

		if var_7_5 then
			var_5_13:bindData(var_7_5, function(...)
				return arg_5_0:setOrCreateSkillItem(...)
			end, math.min(#var_7_5, 10))

			for iter_7_0 = 1, var_5_13._cacheCount do
				var_5_13:pushBackCustomItem(arg_5_0:setOrCreateSkillItem(nil, var_7_5[iter_7_0]))
			end
		else
			var_5_13:removeAllItems()
		end

		var_5_13:checkEmpty(string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.SKILL)))
	end

	var_5_0:runAction(lc.rep(lc.sequence(0, function()
		if not P._playerFindSurvivalEx._isInHall then
			var_5_0:stopAllActions()
			arg_5_0:hide()

			return
		end

		var_5_0.update()
	end, 1)))

	arg_5_0._topArea = var_5_0
end

function var_0_0.setOrCreateSkillItem(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		arg_10_1 = ccui.Widget:create()

		arg_10_1:setContentSize(75, 75)

		local var_10_0 = IconWidget.createByInfoId(arg_10_2)

		var_10_0:setScale(lc.h(arg_10_1) / lc.h(var_10_0))
		lc.addChildToCenter(arg_10_1, var_10_0)

		arg_10_1._icon = var_10_0
	else
		arg_10_1._icon._data._infoId = arg_10_2

		arg_10_1._icon:resetData(arg_10_1._icon._data)
	end

	return arg_10_1
end

function var_0_0.startExplore(arg_11_0)
	if ClientView._explorePanel then
		return
	end

	if P._playerFindSurvivalEx:isTroopValid() then
		require("ExplorePanel").create(true):show()
	else
		ToastManager.push(string.format(Str(STR.SURVIVAL_EX_TROOP_TIP), var_0_1.MAX_TROOP_COUNT, var_0_1.MAX_TROOP_COUNT_EX))
	end
end

function var_0_0.createSelectCardsArea(arg_12_0)
	local var_12_0 = ClientView.createFrameBox(cc.size(lc.w(arg_12_0), 260))

	lc.addChildToPos(arg_12_0, var_12_0, cc.p(lc.cw(arg_12_0), 400))

	local var_12_1 = lc.createSprite("img_troop_name_bg")

	lc.addChildToPos(var_12_0, var_12_1, cc.p(lc.cw(var_12_1) + 25, lc.h(var_12_0) + lc.ch(var_12_1) - 15))

	local var_12_2 = ClientView.createTTF(Str(STR.OPTIONAL) .. Str(STR.TROOP), ClientView.FontSize.M2, ClientView.COLOR_TEXT_BLUE)

	var_12_2:enableShadow()
	lc.addChildToPos(var_12_1, var_12_2, cc.p(lc.cw(var_12_2) + 10, lc.ch(var_12_1)))

	arg_12_0._thumbnails = {}

	local var_12_3 = 10
	local var_12_4 = ClientView.CARD_SIZE.width * var_0_6
	local var_12_5 = lc.List.createH(cc.size(lc.w(var_12_0) - 180, lc.h(var_12_0)), var_12_3, var_12_3)

	var_12_5:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(var_12_0, var_12_5)
	lc.offset(var_12_5, 0, 5)

	arg_12_0._selectCardList = var_12_5

	arg_12_0:initThumbnails()

	arg_12_0._curPage = 1

	local var_12_6 = cc.p(90, lc.ch(var_12_0))
	local var_12_7 = ClientView.createPageArrow(true, var_12_6, function()
		if arg_12_0._curPage > 1 then
			arg_12_0._curPage = arg_12_0._curPage - 1
		end

		arg_12_0:updateSelectCards()
	end)

	lc.addChildToPos(var_12_0, var_12_7, var_12_6)
	var_12_7:float()

	arg_12_0._pageLeft = var_12_7

	local var_12_8 = cc.p(lc.w(var_12_0) - 90, lc.ch(var_12_0))
	local var_12_9 = ClientView.createPageArrow(false, var_12_8, function()
		if arg_12_0._curPage < math.ceil(#P._playerFindSurvivalEx:getCaptures(arg_12_0._isEx) / var_0_8) then
			arg_12_0._curPage = arg_12_0._curPage + 1
		end

		arg_12_0:updateSelectCards()
	end)

	lc.addChildToPos(var_12_0, var_12_9, var_12_8)
	var_12_9:float()

	arg_12_0._pageRight = var_12_9

	local var_12_10 = ClientView.createTTF(Str(STR.OPTIONAL_TROOP_TIP), ClientView.FontSize.S1)

	lc.addChildToCenter(var_12_0, var_12_10)

	var_12_0._tip = var_12_10

	return var_12_0
end

function var_0_0.initThumbnails(arg_15_0)
	local var_15_0 = arg_15_0._selectCardList

	var_15_0:removeAllItems()

	local var_15_1 = ClientView.CARD_SIZE.width * var_0_6

	for iter_15_0 = 1, var_0_8 do
		local var_15_2 = 10001
		local var_15_3 = ccui.Layout:create()

		var_15_3:setContentSize(cc.size(var_15_1, 270))
		var_15_3:setAnchorPoint(0.5, 0.5)
		var_15_0:pushBackCustomItem(var_15_3)

		local var_15_4 = var_0_2.createFromPool(var_15_2, var_0_6)

		var_15_4._thumbnail:setTouchEnabled(true)
		var_15_4._thumbnail:addTouchEventListener(function(arg_16_0, arg_16_1)
			arg_15_0:onTouchThumbnail(arg_16_0, arg_16_1, var_0_10.select_card)
		end)
		lc.addChildToCenter(var_15_3, var_15_4)
		table.insert(arg_15_0._thumbnails, var_15_4)
	end
end

function var_0_0.updateSelectCards(arg_17_0)
	local var_17_0 = P._playerFindSurvivalEx:getCaptures(arg_17_0._isEx)

	arg_17_0._totalPage = math.ceil(#var_17_0 / var_0_8)
	arg_17_0._curPage = math.max(math.min(arg_17_0._curPage, arg_17_0._totalPage), 1)

	local var_17_1 = {}

	for iter_17_0 = (arg_17_0._curPage - 1) * var_0_8 + 1, arg_17_0._curPage * var_0_8 do
		var_17_1[#var_17_1 + 1] = var_17_0[iter_17_0]
	end

	for iter_17_1, iter_17_2 in ipairs(arg_17_0._thumbnails) do
		iter_17_2._card = nil

		iter_17_2:setVisible(false)
	end

	for iter_17_3 = 1, #var_17_1 do
		local var_17_2 = var_17_1[iter_17_3]
		local var_17_3 = arg_17_0._thumbnails[iter_17_3]

		if not var_17_3 then
			break
		end

		var_17_3._card = var_17_2

		var_17_3._thumbnail:updateComponent(var_17_2._infoId)
		var_17_3._countArea:update(true, var_17_2._num)
		var_17_3:setVisible(true)

		if P._playerFindSurvivalEx:getTroopCardCount(var_17_2._infoId) >= Data.getInfo(var_17_2._infoId)._maxCount * 2 then
			var_17_3._thumbnail._frame._frame:setEffect(ClientView.SHADER_DISABLE)
			var_17_3._thumbnail._frame:setEffect(ClientView.SHADER_DISABLE)

			var_17_3._isValid = false
		else
			var_17_3._thumbnail._frame:setEffect(nil)

			var_17_3._isValid = true
		end
	end

	arg_17_0._pageLeft:setVisible(arg_17_0._curPage > 1)
	arg_17_0._pageLeft:float()
	arg_17_0._pageRight:setVisible(arg_17_0._curPage < arg_17_0._totalPage)
	arg_17_0._pageRight:float()
	arg_17_0._selectCardsArea._tip:setVisible(#var_17_0 <= 0)
end

function var_0_0.updateTroopList(arg_18_0)
	local var_18_0 = arg_18_0:remainItemFromList()

	arg_18_0:releaseTroopCards()

	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(P._playerFindSurvivalEx:getTroopCards(arg_18_0._isEx)) do
		local var_18_2

		for iter_18_2 = 1, #var_18_0 do
			if var_18_0[iter_18_2]._card._infoId == iter_18_1._infoId then
				var_18_2 = var_18_0[iter_18_2]

				break
			end
		end

		if not var_18_2 then
			var_18_2 = ccui.Layout:create()

			var_18_2:retain()

			local var_18_3 = var_0_2.createFromPool(iter_18_1._infoId, var_0_7)

			var_18_3._countArea:update(true, iter_18_1._num)
			var_18_2:setContentSize(var_18_3._thumbnail:getContentSize())
			var_18_2:setAnchorPoint(cc.p(0.5, 0.5))
			lc.addChildToPos(var_18_2, var_18_3, cc.p(lc.cw(var_18_2), lc.ch(var_18_2) + 10))
			var_18_3._thumbnail:setTouchEnabled(true)
			var_18_3._thumbnail:addTouchEventListener(function(arg_19_0, arg_19_1)
				arg_18_0:onTouchThumbnail(arg_19_0, arg_19_1, var_0_10.troop_card)
			end)

			var_18_2._item = var_18_3

			local var_18_4 = lc.createSprite("img_compose_add")

			var_18_4:setScale(60 / lc.w(var_18_4))
			lc.addChildToPos(var_18_2, var_18_4, cc.p(30, lc.h(var_18_2) - 30))
			var_18_4:runAction(lc.rep(lc.sequence(lc.fadeOut(0.5), lc.fadeIn(0.5))))
			var_18_4:setVisible(false)

			function var_18_2.update(arg_20_0)
				var_18_2._item._countArea:update(true, arg_20_0._num)

				local var_20_0 = P._playerFindSurvivalEx:getCouldEquipSkills(arg_20_0._infoId)

				var_18_4:setVisible(#var_20_0 > 0)
			end
		end

		var_18_2.update(iter_18_1)
		table.insert(var_18_1, var_18_2)

		var_18_2._card = iter_18_1
	end

	table.sort(var_18_1, function(arg_21_0, arg_21_1)
		local var_21_0 = Data.getOriginId(arg_21_0._card._infoId)
		local var_21_1 = Data.getOriginId(arg_21_1._card._infoId)

		if var_21_0 < var_21_1 then
			return true
		elseif var_21_1 < var_21_0 then
			return false
		else
			return arg_21_0._card._infoId < arg_21_1._card._infoId
		end
	end)

	for iter_18_3, iter_18_4 in ipairs(var_18_1) do
		arg_18_0._troopList:pushBackCustomItem(iter_18_4)
	end

	local var_18_5, var_18_6, var_18_7, var_18_8, var_18_9 = P._playerFindSurvivalEx:getTroopCardCount(nil, arg_18_0._isEx)
	local var_18_10 = string.format(lc.str(STR.FIND_SURVIVAL_EX_TIPS), var_18_5, arg_18_0._maxTroopCount, var_18_6 + var_18_7, var_18_8 + var_18_9)

	arg_18_0._troopDescLabel:setString(var_18_10)
end

function var_0_0.releaseSelectCards(arg_22_0)
	if #arg_22_0._thumbnails > 0 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._thumbnails) do
			var_0_2.releaseToPool(iter_22_1)
		end

		arg_22_0._thumbnails = {}
	end
end

function var_0_0.releaseTroopCards(arg_23_0)
	if arg_23_0._troopList then
		local var_23_0 = arg_23_0._troopList:getItems()

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			var_0_2.releaseToPool(iter_23_1._item)
			iter_23_1:release()
		end

		arg_23_0._troopList:removeAllItems()
	end
end

function var_0_0.createTroopArea(arg_24_0)
	local var_24_0 = lc.createSprite({
		_name = "img_troop_bg_1",
		_size = cc.size(lc.w(arg_24_0), 212),
		_crect = cc.rect(47, 0, 1, 212)
	})

	lc.addChildToPos(arg_24_0, var_24_0, cc.p(lc.cw(arg_24_0), lc.ch(var_24_0)))

	local var_24_1 = lc.createSprite("img_troop_name_bg")

	lc.addChildToPos(var_24_0, var_24_1, cc.p(lc.cw(var_24_1) + 25, lc.h(var_24_0) + lc.ch(var_24_1)))

	local var_24_2 = ClientView.createTTF(Str(STR.PUBG), ClientView.FontSize.M2, ClientView.COLOR_TEXT_BLUE)

	var_24_2:enableShadow()
	lc.addChildToPos(var_24_1, var_24_2, cc.p(lc.cw(var_24_2) + 10, lc.ch(var_24_1)))

	local var_24_3 = lc.List.createH(cc.size(lc.w(var_24_0) - 40, lc.h(var_24_0) - 6), 20, 10)

	lc.addChildToPos(var_24_0, var_24_3, cc.p(24, 0))

	arg_24_0._troopList = var_24_3

	local var_24_4 = P._playerFindSurvivalEx
	local var_24_5 = string.format(lc.str(STR.FIND_SURVIVAL_EX_TIPS), arg_24_0._maxTroopCount, arg_24_0._maxTroopCount, arg_24_0._maxTroopCount, arg_24_0._maxTroopCount)
	local var_24_6 = ClientView.createTTF(var_24_5, ClientView.FontSize.S1, lc.Color3B.black)
	local var_24_7 = lc.createSprite({
		_name = "img_tip_bg2",
		_size = cc.size(lc.w(var_24_6) + 40 + 40, 51),
		_crect = cc.rect(36, 25, 1, 1)
	})

	lc.addChildToPos(var_24_0, var_24_7, cc.p(lc.right(var_24_1) + 230, lc.h(var_24_0) + lc.ch(var_24_7) + 10))
	lc.addChildToPos(var_24_7, var_24_6, cc.p(lc.cw(var_24_6) + 40, lc.ch(var_24_7)))

	arg_24_0._troopDescLabel = var_24_6

	local var_24_8 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_25_0)
		arg_24_0:setEx(not arg_24_0._isEx)
		arg_25_0._icon:setSpriteFrame(arg_24_0._isEx and "img_troop_rare" or "img_troop_main")
		arg_24_0:refreshView()
	end, ClientView.CRECT_BUTTON_S, 140)

	var_24_8:addIcon("img_troop_main")
	lc.addChildToPos(var_24_0, var_24_8, cc.p(lc.right(var_24_7) + 100, lc.h(var_24_0) + lc.ch(var_24_7) + 10))

	return var_24_0
end

function var_0_0.onTouchThumbnail(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_1:stopAllActions()

	if arg_26_2 == ccui.TouchEventType.began then
		arg_26_1:runAction(lc.scaleTo(0.1, 0.95))
		arg_26_0:onItemPress(arg_26_1, arg_26_3)
	elseif arg_26_2 == ccui.TouchEventType.ended or arg_26_2 == ccui.TouchEventType.canceled then
		arg_26_1:runAction(lc.scaleTo(0.08, 1))
		arg_26_0:onItemTap(arg_26_1, arg_26_3)
	elseif arg_26_2 == ccui.TouchEventType.moved then
		arg_26_0:onItemMove(arg_26_1, arg_26_3)
	end
end

function var_0_0.onItemPress(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0._movingSprite then
		return
	end

	arg_27_0._touchStatus = var_0_0.TouchStatus.press
	arg_27_0._movingDir = var_0_9.none
end

function var_0_0.onItemMove(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_0._touchStatus == var_0_0.TouchStatus.tap then
		return
	end

	arg_28_0._touchStatus = var_0_0.TouchStatus.move

	if arg_28_0._movingSprite == nil then
		if arg_28_0._movingDir == var_0_9.none then
			local var_28_0 = math.abs(cc.pSub(arg_28_1:getTouchMovePosition(), arg_28_1:getTouchBeganPosition()).x)
			local var_28_1 = math.abs(cc.pSub(arg_28_1:getTouchMovePosition(), arg_28_1:getTouchBeganPosition()).y)

			if var_28_0 > 32 or var_28_1 > 32 then
				arg_28_0._movingDir = var_28_1 <= var_28_0 and var_0_9.horizontal or var_0_9.vertical
			end
		end

		if arg_28_0._movingDir == var_0_9.vertical and (arg_28_2 == var_0_10.troop_card or arg_28_1._item._isValid) then
			arg_28_0:createMovingSpriteAndMaskLayer(arg_28_1, arg_28_2)
		end
	end

	if arg_28_0._movingSprite then
		arg_28_0._movingSprite:setPosition(cc.pAdd(arg_28_0._movingSprite._srcPos, cc.pSub(arg_28_1:getTouchMovePosition(), arg_28_1:getTouchBeganPosition())))
		arg_28_0:checkList(arg_28_2 == var_0_10.troop_card and arg_28_0._selectCardList or arg_28_0._troopList)
	end
end

function var_0_0.checkList(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1 == arg_29_0._troopList
	local var_29_1

	var_29_1 = var_29_0 and 0.5 or 0

	local var_29_2 = arg_29_0._movingSprite

	if var_29_0 then
		arg_29_0._isInList = arg_29_0._separatorPos > lc.y(var_29_2)
	else
		arg_29_0._isInList = arg_29_0._separatorPos < lc.y(var_29_2)
	end
end

function var_0_0.onItemTap(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0._touchStatus = var_0_0.TouchStatus.tap

	local var_30_0 = arg_30_1._infoId
	local var_30_1 = Data.getInfo(var_30_0)
	local var_30_2 = P._playerFindSurvivalEx:getTroopCardCount(var_30_0)

	if arg_30_0._movingDir == var_0_9.none then
		if arg_30_2 == var_0_10.troop_card then
			local var_30_3 = {}
			local var_30_4 = 0
			local var_30_5 = arg_30_0._troopList:getItems()

			for iter_30_0 = 1, #var_30_5 do
				local var_30_6 = var_30_5[iter_30_0]._item._thumbnail

				var_30_3[#var_30_3 + 1] = {
					_infoId = var_30_6._infoId,
					_num = var_30_6._count
				}

				if arg_30_1 == var_30_6 then
					var_30_4 = iter_30_0
				end
			end

			local var_30_7 = var_0_3.create(var_30_0, 1, var_0_3.OperateType.na, nil, nil, {
				_isEquip = true
			})

			var_30_7:setCardList(var_30_3, var_30_4, Str(STR.CUR_TROOP))
			var_30_7:setCardCount(arg_30_1._count)
			var_30_7:show()
		else
			var_0_3.create(var_30_0, 1, var_0_3.OperateType.na):show()
		end
	elseif arg_30_0._movingSprite and arg_30_0._isInList then
		if arg_30_2 == var_0_10.select_card then
			if P._playerFindSurvivalEx:getTroopCardCount(nil, arg_30_0._isEx) >= arg_30_0._maxTroopCount then
				ToastManager.push(Str(STR.FULL_IN_TROOP))
			elseif var_30_2 >= var_30_1._maxCount * 2 then
				ToastManager.push(Str(STR.CARD_MAX_IN_ROOP))
			else
				P._playerFindSurvivalEx:captures2Troop(var_30_0, 1)

				local var_30_8 = arg_30_0._movingSprite._srcPos

				arg_30_0:updateSelectCards()
				arg_30_0:runAction(lc.sequence(0, function()
					arg_30_0:playAction(var_30_0, true, var_30_8)
				end))
			end
		else
			P._playerFindSurvivalEx:captures2Troop(var_30_0, -1)

			local var_30_9 = arg_30_0._movingSprite._srcPos

			arg_30_0:updateSelectCards()
			arg_30_0:runAction(lc.sequence(0, function()
				arg_30_0:playAction(var_30_0, false, var_30_9)
			end))
		end

		arg_30_0:updateTroopList()
	end

	if arg_30_0._maskLayer then
		arg_30_0._maskLayer:removeFromParent(true)

		arg_30_0._maskLayer = nil
	end

	if arg_30_0._movingSprite then
		arg_30_0._movingSprite:removeFromParent()

		arg_30_0._movingSprite = nil
	end

	if arg_30_0._selectCardList then
		arg_30_0._selectCardList:setIsScrollEnabled(true)
	end

	if arg_30_0._troopList then
		arg_30_0._troopList:setIsScrollEnabled(true)
	end
end

function var_0_0.createMovingSpriteAndMaskLayer(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_2 == var_0_10.select_card and arg_33_0._troopList or arg_33_0._selectCardList

	;(arg_33_2 == var_0_10.select_card and arg_33_0._selectCardList or arg_33_0._troopList):setIsScrollEnabled(false)

	local var_33_1 = arg_33_1:convertToWorldSpace(cc.p(lc.w(arg_33_1) / 2, lc.h(arg_33_1) / 2))
	local var_33_2 = arg_33_0:convertToNodeSpace(var_33_1)
	local var_33_3 = arg_33_1._infoId
	local var_33_4 = var_0_2.create(var_33_3, var_0_6)

	arg_33_0:addChild(var_33_4, ClientData.ZOrder.ui + 2)

	arg_33_0._movingSprite = var_33_4
	arg_33_0._movingSprite._srcPos = var_33_2
	arg_33_0._movingSprite._abc = 1

	arg_33_0._movingSprite:setPosition(cc.pAdd(var_33_2, cc.pSub(arg_33_1:getTouchMovePosition(), arg_33_1:getTouchBeganPosition())))

	local var_33_5 = var_33_0:convertToWorldSpace(cc.p(0, 0))
	local var_33_6 = arg_33_0:convertToNodeSpace(var_33_5)

	var_33_6.x = 0

	local var_33_7 = cc.rect(var_33_6.x, var_33_6.y, lc.w(arg_33_0), lc.h(var_33_0))
	local var_33_8 = cc.LayerColor:create(cc.c4b(0, 0, 0, 192), lc.w(arg_33_0), lc.h(arg_33_0))

	arg_33_0._maskLayer = ClientView.createClipNode(var_33_8, var_33_7, true)

	arg_33_0:addChild(arg_33_0._maskLayer, ClientData.ZOrder.ui + 1)

	arg_33_0._separatorPos = arg_33_2 == var_0_10.select_card and var_33_6.y + var_33_7.height or var_33_6.y
end

function var_0_0.remainItemFromList(arg_34_0)
	local var_34_0 = {}
	local var_34_1 = arg_34_0._troopList:getItems()

	for iter_34_0 = #var_34_1, 1, -1 do
		local var_34_2 = var_34_1[iter_34_0]
		local var_34_3 = false

		for iter_34_1, iter_34_2 in ipairs(P._playerFindSurvivalEx:getTroopCards(arg_34_0._isEx)) do
			if var_34_2._card._infoId == iter_34_2._infoId then
				var_34_3 = true

				break
			end
		end

		if var_34_3 then
			table.insert(var_34_0, var_34_2)
			arg_34_0._troopList:removeItem(iter_34_0 - 1, false)
		end
	end

	return var_34_0
end

function var_0_0.playAction(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0:runAction(lc.sequence(lc.delay(0), lc.call(function()
		local var_36_0 = cc.Node:create()

		arg_35_0:addChild(var_36_0)

		local var_36_1 = Particle.create("sz1")

		lc.addChildToCenter(var_36_0, var_36_1)

		local var_36_2 = Particle.create("sz2")

		lc.addChildToCenter(var_36_0, var_36_2)

		local var_36_3 = arg_35_3
		local var_36_4

		if arg_35_2 then
			var_36_4 = cc.p(lc.cw(arg_35_0), lc.ch(arg_35_0._troopList))

			local var_36_5 = arg_35_0._troopList:getItems()

			for iter_36_0, iter_36_1 in ipairs(var_36_5) do
				if iter_36_1._card._infoId == arg_35_1 then
					var_36_4 = arg_35_0:convertToNodeSpace(iter_36_1:convertToWorldSpace(cc.p(lc.cw(iter_36_1), lc.ch(iter_36_1))))

					break
				end
			end
		else
			var_36_4 = cc.p(lc.x(arg_35_0._selectCardsArea), lc.y(arg_35_0._selectCardsArea))

			local var_36_6

			for iter_36_2, iter_36_3 in ipairs(P._playerFindSurvivalEx:getCaptures(arg_35_0._isEx)) do
				if iter_36_3._infoId == arg_35_1 then
					var_36_6 = math.ceil(iter_36_2 / var_0_8)

					break
				end
			end

			var_36_6 = var_36_6 or math.ceil(#P._playerFindSurvivalEx:getCaptures(arg_35_0._isEx) / var_0_8)

			if arg_35_0._curPage ~= var_36_6 then
				var_36_4 = var_36_6 < arg_35_0._curPage and cc.p(lc.left(arg_35_0._selectCardsArea), lc.y(arg_35_0._selectCardsArea)) or cc.p(lc.right(arg_35_0._selectCardsArea), lc.y(arg_35_0._selectCardsArea))
			else
				for iter_36_4, iter_36_5 in ipairs(arg_35_0._thumbnails) do
					if iter_36_5._card and iter_36_5._card._infoId == arg_35_1 then
						var_36_4 = arg_35_0:convertToNodeSpace(iter_36_5:convertToWorldSpace(cc.p(lc.cw(iter_36_5), lc.ch(iter_36_5))))

						break
					end
				end
			end
		end

		var_36_0:setPosition(var_36_3)
		var_36_0:setScale(2)
		var_36_0:runAction(lc.sequence(lc.moveTo(0.4, var_36_4), lc.call(function()
			var_36_1:setDuration(0.1)
			var_36_2:setDuration(0.1)
		end), lc.delay(1), lc.remove()))
	end)))
end

function var_0_0.onExitHall(arg_38_0)
	if P._playerFindSurvivalEx._isInHall then
		local var_38_0 = Str(STR.CONFIRM_EXIT_SURVIVAL)

		require("Dialog").showDialog(var_38_0, function()
			ClientView.getActiveIndicator():show(Str(STR.WAITING))
			ClientData.sendSurvivalExQuit()
		end)
	else
		arg_38_0:hide()
	end
end

function var_0_0.onChangeToBattle(arg_40_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendToggleRoomMatch()
end

function var_0_0.startMatch(arg_41_0)
	ClientData.sendSurvivalExExploreStart()
end

function var_0_0.syncData(arg_42_0)
	var_0_0.super.syncData(arg_42_0)

	if not P._playerFindSurvivalEx._isInHall then
		return arg_42_0:hide()
	end

	arg_42_0:refreshView()
end

function var_0_0.reload(arg_43_0, arg_43_1)
	var_0_0.super:reload(arg_43_1)

	if not P._playerFindSurvivalEx._isInHall then
		return arg_43_0:hide()
	end

	arg_43_0:refreshView()
end

function var_0_0.onEnterSurvivalExHall(arg_44_0)
	if arg_44_0._isLogin then
		arg_44_0:onLogin()

		arg_44_0._isLogin = false
	end

	arg_44_0:refreshView()
end

function var_0_0.refreshView(arg_45_0)
	if not arg_45_0._thumbnails or #arg_45_0._thumbnails == 0 then
		arg_45_0:initThumbnails()
	end

	arg_45_0:updateSelectCards()
	arg_45_0:updateTroopList()
	arg_45_0._topArea.update()

	for iter_45_0 = 1, #arg_45_0._loseSprites do
		arg_45_0._loseSprites[iter_45_0]:setVisible(iter_45_0 <= P._playerFindSurvivalEx._lose)
	end

	if not arg_45_0._isSelecting and P._playerFindSurvivalEx._skills[0] and #P._playerFindSurvivalEx._skills[0] > 0 then
		local var_45_0 = {}

		for iter_45_1 = 1, 3 do
			var_45_0[iter_45_1] = P._playerFindSurvivalEx._skills[0][iter_45_1]
		end

		local var_45_1 = require("SelectSkillPanel").create(var_45_0)

		function var_45_1.onCleanup()
			arg_45_0._isSelecting = false

			arg_45_0:refreshView()
		end

		var_45_1:show()

		arg_45_0._isSelecting = true
	end
end

function var_0_0.checkSurvivalExBonus(arg_47_0)
	local var_47_0 = P._playerFindSurvivalEx

	if var_47_0._rewards or var_47_0._getSeconds and var_47_0._getSeconds > 0 then
		require("SurvivalBonusPanel").create(true):show()
		var_47_0:clearBonus()
	end
end

function var_0_0.onEnter(arg_48_0)
	var_0_0.super.onEnter(arg_48_0)

	if not arg_48_0._troopArea then
		arg_48_0._troopArea = arg_48_0:createTroopArea()

		arg_48_0:updateTroopList()
	end

	if not arg_48_0._selectCardsArea then
		arg_48_0._selectCardsArea = arg_48_0:createSelectCardsArea()

		arg_48_0:updateSelectCards()
	end

	ClientView.getResourceUI():setMode(Data.ResType.survival_ex_trophy)

	local var_48_0 = {}

	arg_48_0._listeners = var_48_0

	table.insert(var_48_0, lc.addEventListener(Data.Event.survival_ex_info_dirty, function(arg_49_0)
		arg_48_0:refreshView()
	end))
	table.insert(var_48_0, lc.addEventListener(Data.Event.survival_ex_game_over, function(arg_50_0)
		arg_48_0:hide()
	end))
	table.insert(var_48_0, lc.addEventListener(Data.Event.survival_ex_explore_end, function(arg_51_0)
		arg_48_0:checkSurvivalExBonus()
		arg_48_0:updateSelectCards()
	end))
	table.insert(var_48_0, lc.addEventListener(Data.Event.card_equip_skill_dirty, function(arg_52_0)
		arg_48_0:updateTroopList()
	end))
	arg_48_0:refreshView()

	if not P._playerFindSurvivalEx._isInHall then
		return arg_48_0:hide()
	end

	arg_48_0:checkSurvivalExBonus()
end

function var_0_0.onExit(arg_53_0)
	var_0_0.super.onExit(arg_53_0)
	ClientView.getResourceUI():setVisible(true)

	for iter_53_0 = 1, #arg_53_0._listeners do
		lc.Dispatcher:removeEventListener(arg_53_0._listeners[iter_53_0])
	end

	arg_53_0:releaseSelectCards()
	arg_53_0:releaseTroopCards()
end

function var_0_0.onCleanup(arg_54_0)
	var_0_0.super.onCleanup(arg_54_0)
	arg_54_0:releaseSelectCards()
	arg_54_0:releaseTroopCards()
end

return var_0_0
