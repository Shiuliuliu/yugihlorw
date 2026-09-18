local var_0_0 = class("FindSurvivalArea", lc.ExtendCCNode)
local var_0_1 = require("CardThumbnail")
local var_0_2 = require("CardInfoPanel")
local var_0_3 = 320
local var_0_4 = 500
local var_0_5 = 0.7
local var_0_6 = 0.45

var_0_0.TouchStatus = {
	press = 1,
	tap = 3,
	move = 2
}

local var_0_7 = {
	vertical = 2,
	horizontal = 1,
	none = 0
}
local var_0_8 = {
	troop_card = 1,
	select_card = 2
}

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_0, arg_1_1)
	var_1_0:init()
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		elseif arg_2_0 == "cleanup" then
			var_1_0:onCleanup()
		end
	end)

	return var_1_0
end

function var_0_0.onEnter(arg_3_0)
	ClientView.getResourceUI():setMode(Data.ResType.gold)

	arg_3_0._listeners = {}

	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.survival_game_over, function(arg_4_0)
		ClientView.getActiveIndicator():hide()
		arg_3_0:hideBattleField()
		arg_3_0:enterDoor()
	end))
	ClientData.addMsgListener(arg_3_0, function(arg_5_0)
		return arg_3_0:onMsg(arg_5_0)
	end, 0)
	arg_3_0:hideDoor()
	arg_3_0:hideSelectCards()
	arg_3_0:hideSelectCharacter()
	arg_3_0:hideBattleField()

	if not P._playerFindSurvival._hasTicket then
		arg_3_0:enterDoor()
	elseif P._playerFindSurvival._characterId == 0 then
		arg_3_0:enterSelectCharacter()
	elseif P._playerFindSurvival._step <= P._playerFindSurvival.MAX_TROOP_COUNT then
		arg_3_0:enterSelectCards()
	else
		arg_3_0:enterBattleField()
	end
end

function var_0_0.onExit(arg_6_0)
	arg_6_0:releaseSelectCards()
	arg_6_0:releaseTroopCards()

	for iter_6_0 = 1, #arg_6_0._listeners do
		lc.Dispatcher:removeEventListener(arg_6_0._listeners[iter_6_0])
	end

	ClientData.removeMsgListener(arg_6_0)
end

function var_0_0.onCleanup(arg_7_0)
	arg_7_0:releaseSelectCards()
	arg_7_0:releaseTroopCards()
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/arena_door.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/img_survive_start_bg.jpg"))
end

function var_0_0.onMsg(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.type

	if var_8_0 == SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL then
		ClientView.getActiveIndicator():hide()
		arg_8_0:enterSelectCharacter()

		return true
	elseif var_8_0 == SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL then
		ClientView.getActiveIndicator():hide()
		arg_8_0:enterSelectCards()

		return true
	elseif var_8_0 == SglMsgType_pb.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL then
		P._playerFindSurvival._step = arg_8_1.Extensions[World_pb.SglWorldMsg.world_select_card_resp]

		if P._playerFindSurvival._step % P._playerFindSurvival.SELECT_CARD_COUNT == 1 then
			if P._playerFindSurvival._step > P._playerFindSurvival.MAX_TROOP_COUNT then
				arg_8_0:enterBattleField()
			else
				arg_8_0:updateSelectCards()
			end
		end

		return true
	end

	return false
end

function var_0_0.init(arg_9_0)
	arg_9_0._thumbnails = {}
end

function var_0_0.onSelectCard(arg_10_0, arg_10_1)
	local var_10_0 = P._playerFindSurvival:getSelectCardIndex(arg_10_1)

	P._playerFindSurvival:addCardToTroop(arg_10_1, var_10_0)
	ClientData.sendSurvivalSelectCard(var_10_0)

	local var_10_1 = arg_10_0._movingSprite._srcPos

	arg_10_0:updateSelectCards()
	arg_10_0:runAction(lc.sequence(0, function()
		arg_10_0:playAction(var_10_1, arg_10_1)
	end))
end

function var_0_0.onSelectCharacter(arg_12_0)
	P._playerFindSurvival._characterId = arg_12_0._characterId
	P._playerFindSurvival._step = 1

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendSurvivalSelectCharacter(arg_12_0._characterId)
end

function var_0_0.onBuyTicket(arg_13_0, arg_13_1)
	if arg_13_1 == Data.ResType.gold then
		if not ClientView.checkGold(Data._globalInfo._SurvivalCostGold) then
			return
		end

		P:changeResource(Data.ResType.gold, -Data._globalInfo._SurvivalCostGold)
	elseif arg_13_1 == Data.ResType.ingot then
		if not ClientView.checkIngot(Data._globalInfo._SurvivalCostIngot) then
			return
		end

		P:changeResource(Data.ResType.ingot, -Data._globalInfo._SurvivalCostIngot)
	else
		if not P._propBag:hasProps(Data.PropsId.survival_ticket, 1) then
			return ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(Data._propsInfo[Data.PropsId.survival_ticket]._nameSid)))
		end

		P._propBag:changeProps(Data.PropsId.survival_ticket, -1)
	end

	P._playerFindSurvival._hasTicket = true

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendSurvivalBuyTicket(arg_13_1)
end

function var_0_0.onFindingHall(arg_14_0)
	if ClientView._findMatchPanel then
		return
	end

	if P._playerFindSurvival:getIsValidTime() == 0 then
		require("FindMatchPanel").create(Data.FindMatchType.survival):show()
	else
		local var_14_0 = P._playerFindSurvival:getTimeTip()

		ToastManager.push(var_14_0)
	end
end

function var_0_0.onFinishBattle(arg_15_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendSurvivalQuit()
end

function var_0_0.enterDoor(arg_16_0)
	if arg_16_0._doorLayer ~= nil then
		return
	end

	local var_16_0 = lc.createNode(arg_16_0:getContentSize())

	lc.addChildToCenter(arg_16_0, var_16_0, 1)

	arg_16_0._doorLayer = var_16_0

	local var_16_1 = cc.Sprite:create("res/jpg/survival_door.jpg")

	lc.addChildToCenter(var_16_0, var_16_1)

	local var_16_2 = Particle.create("jdqs")

	lc.addChildToPos(var_16_1, var_16_2, cc.p(lc.cw(var_16_1), lc.ch(var_16_1) - 30))

	local var_16_3 = lc.createNode()

	lc.addChildToPos(var_16_0, var_16_3, cc.p(0, 0))

	var_16_0._tipNode = var_16_3

	local var_16_4 = lc.createSprite({
		_name = "img_com_bg_41",
		_size = cc.size(672, 54),
		_crect = cc.rect(29, 26, 1, 1)
	})

	lc.addChildToPos(var_16_3, var_16_4, cc.p(lc.cw(var_16_0), 180))

	local var_16_5 = ClientView.createTTF(P._playerFindSurvival:getTimeTip(), ClientView.FontSize.M2)

	lc.addChildToCenter(var_16_4, var_16_5)

	local function var_16_6(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_18_0)
			arg_16_0:onBuyTicket(arg_17_2)
		end, ClientView.CRECT_BUTTON, 180)
		local var_17_1 = lc.createSprite(arg_17_0)
		local var_17_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_17_1)

		lc.addChildToPos(var_17_0, var_17_1, cc.p(lc.cw(var_17_0) - (lc.w(var_17_2) + 12) / 2, lc.ch(var_17_0)))
		lc.addChildToPos(var_17_0, var_17_2, cc.p(lc.right(var_17_1) + lc.cw(var_17_2) + 12, lc.ch(var_17_0)))

		return var_17_0
	end

	if P._propBag:hasProps(Data.PropsId.survival_ticket, 1) then
		local var_16_7 = var_16_6("img_icon_props_s7132", 1, Data.PropsId.survival_ticket)

		lc.addChildToPos(var_16_3, var_16_7, cc.p(lc.cw(var_16_0), 80))
	else
		local var_16_8 = var_16_6("img_icon_res1_s", Data._globalInfo._SurvivalCostGold, Data.ResType.gold)

		lc.addChildToPos(var_16_3, var_16_8, cc.p(lc.cw(var_16_0), 80))
	end

	local var_16_9 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("LogForm").create(Battle_pb.PB_BATTLE_SURVIVAL):show()
	end, ClientView.CRECT_BUTTON_S, 100)

	lc.addChildToPos(var_16_0, var_16_9, cc.p(lc.w(var_16_0) - lc.cw(var_16_9) - 20, 80))
	var_16_9:addLabel(Str(STR.LOG))
	var_16_0:runAction(lc.rep(lc.sequence(function()
		local var_20_0 = P._playerFindSurvival:getPrivilegeTimeStr()
		local var_20_1 = var_16_0._tip

		if var_20_1 then
			var_20_1:removeFromParent()
		end

		if var_20_0 then
			local var_20_2 = ClientView.createBoldRichText(var_20_0, {
				_boldClr = ClientView.COLOR_TEXT_INGOT
			})

			lc.addChildToPos(var_16_0, var_20_2, cc.p(lc.cw(arg_16_0), lc.h(var_16_0) - 30))

			var_16_0._tip = var_20_2
		end
	end, 1)))
	ClientView.getResourceUI():setMode(Data.PropsId.survival_ticket)
end

function var_0_0.hideDoor(arg_21_0)
	if not arg_21_0._doorLayer then
		return
	end

	local var_21_0 = arg_21_0._doorLayer

	var_21_0._tipNode:setVisible(false)
	var_21_0:removeFromParent()

	arg_21_0._doorLayer = nil
	arg_21_0._doors = nil

	ClientView.getResourceUI():setMode(Data.PropsId.survival_ticket)
end

function var_0_0.enterSelectCharacter(arg_22_0)
	if arg_22_0._characterLayer ~= nil then
		return
	end

	arg_22_0:hideDoor()

	local var_22_0 = lc.createNode(arg_22_0:getContentSize())

	lc.addChildToCenter(arg_22_0, var_22_0)

	arg_22_0._characterLayer = var_22_0

	local var_22_1 = lc.createSprite({
		_name = "img_title_bg",
		_size = cc.size(480, 52),
		_crect = cc.rect(115, 25, 1, 1)
	})

	lc.addChildToPos(var_22_0, var_22_1, cc.p(lc.cw(var_22_0), lc.h(var_22_0) - 40))

	local var_22_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.PVP_SELECT_YOUR_CHARACTER))

	lc.addChildToCenter(var_22_1, var_22_2)

	local var_22_3 = 980
	local var_22_4 = lc.List.createH(cc.size(lc.w(var_22_0), var_0_4), math.max(0, (lc.w(var_22_0) - var_22_3) / 2))

	var_22_4:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_22_0, var_22_4, cc.p(lc.cw(var_22_0), lc.ch(var_22_0) + 20))

	arg_22_0._characterList = var_22_4

	for iter_22_0 = 1, #P._playerFindSurvival._characters do
		local var_22_5 = P._playerFindSurvival._characters[iter_22_0]
		local var_22_6 = arg_22_0:createCharacterItem(var_22_5)

		var_22_4:pushBackCustomItem(var_22_6)
	end

	local var_22_7 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_23_0)
		arg_22_0:onSelectCharacter()
	end, ClientView.CRECT_BUTTON, 180)

	lc.addChildToPos(var_22_0, var_22_7, cc.p(lc.cw(var_22_0), 60))
	var_22_7:addLabel(Str(STR.OK))

	arg_22_0._characterId = P._playerFindSurvival._characterId

	if arg_22_0._characterId == 0 then
		arg_22_0._characterId = P._playerFindSurvival._characters[1]
	end

	arg_22_0:selectCharacter(arg_22_0._characterId)
	ClientView.getResourceUI():setMode(Data.ResType.gold)
end

function var_0_0.hideSelectCharacter(arg_24_0)
	if not arg_24_0._characterLayer then
		return
	end

	arg_24_0._characterLayer:removeFromParent()

	arg_24_0._characterLayer = nil
end

function var_0_0.createCharacterItem(arg_25_0, arg_25_1)
	local var_25_0 = Data._characterInfo[arg_25_1]
	local var_25_1 = ClientView.createShaderButton(nil, function(arg_26_0)
		arg_25_0:selectCharacter(var_25_0._id)
	end)

	var_25_1._id = var_25_0._id

	var_25_1:setContentSize(var_0_3, var_0_4)

	local var_25_2 = lc.createSprite({
		_name = "img_com_bg_43",
		_size = cc.size(var_0_3, ClientView.CRECT_COM_BG43.height),
		_crect = ClientView.CRECT_COM_BG43
	})

	lc.addChildToPos(var_25_1, var_25_2, cc.p(lc.cw(var_25_1), lc.ch(var_25_2)), 1)

	var_25_1._nameBg = var_25_2

	local var_25_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(var_25_0._nameSid))

	lc.addChildToCenter(var_25_2, var_25_3)

	local var_25_4 = DragonBones.create(Data.getCharacterBoneName(var_25_0._id))

	var_25_4:gotoAndPlay(Data.getCharacterAniName(var_25_0._id))
	var_25_4:setScale(0.5)
	lc.addChildToPos(var_25_1, var_25_4, cc.p(lc.x(var_25_2), lc.top(var_25_2) + 120))
	lc.offset(var_25_4, 0, Data.getCharacterOffsetY(var_25_0._id, true) * 0.5)

	local var_25_5 = lc.createSprite("img_light")

	var_25_5:setScale(5.5)
	lc.addChildToPos(var_25_1, var_25_5, cc.p(lc.x(var_25_2), lc.top(var_25_2) + 180), -1)

	var_25_1._light = var_25_5

	local var_25_6 = Particle.create("xuanzhong")

	var_25_6:setPositionType(cc.POSITION_TYPE_GROUPED)
	lc.addChildToPos(var_25_1, var_25_6, cc.p(lc.x(var_25_2), lc.top(var_25_2) + 20), -1)

	var_25_1._particle = var_25_6

	if var_25_0._id == 2 then
		lc.offset(var_25_4, 10, 0)
	end

	if var_25_0._id == 14 then
		lc.offset(var_25_4, 0, 60)
	end

	return var_25_1
end

function var_0_0.selectCharacter(arg_27_0, arg_27_1)
	arg_27_0._characterId = arg_27_1

	local var_27_0 = arg_27_0._characterList:getItems()

	for iter_27_0 = 1, #var_27_0 do
		local var_27_1 = var_27_0[iter_27_0]

		var_27_1._nameBg:setSpriteFrame(lc.FrameCache:getSpriteFrame(var_27_1._id == arg_27_1 and "img_com_bg_44" or "img_com_bg_43"), ClientView.CRECT_COM_BG43)
		var_27_1._nameBg:setContentSize(var_0_3, ClientView.CRECT_COM_BG43.height)
		var_27_1._light:setVisible(var_27_1._id == arg_27_1)
		var_27_1._particle:setVisible(var_27_1._id == arg_27_1)
	end
end

function var_0_0.enterSelectCards(arg_28_0)
	if arg_28_0._cardsLayer ~= nil then
		return
	end

	arg_28_0:hideSelectCharacter()

	local var_28_0 = lc.createNode(arg_28_0:getContentSize())

	lc.addChildToCenter(arg_28_0, var_28_0)

	arg_28_0._cardsLayer = var_28_0

	local var_28_1 = arg_28_0:createTroopArea(var_28_0)
	local var_28_2 = lc.createSprite({
		_name = "img_title_bg",
		_size = cc.size(480, 52),
		_crect = cc.rect(115, 25, 1, 1)
	})

	lc.addChildToPos(var_28_0, var_28_2, cc.p(lc.cw(var_28_0), lc.h(var_28_0) - 40))

	local var_28_3 = string.format(lc.str(STR.SELECT_CARD), 0, P._playerFindSurvival.TOTAL_CARD_COUNT, P._playerFindSurvival.SELECT_CARD_COUNT)
	local var_28_4 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_28_3)

	lc.addChildToCenter(var_28_2, var_28_4)

	arg_28_0._selectTitle = var_28_4

	local var_28_5 = 10
	local var_28_6 = P._playerFindSurvival.TOTAL_CARD_COUNT * (ClientView.CARD_SIZE.width * var_0_5 + var_28_5) - var_28_5
	local var_28_7 = lc.List.createH(cc.size(lc.w(arg_28_0), 300), math.max(20, (lc.w(var_28_0) - var_28_6) / 2), var_28_5)

	lc.addChildToPos(var_28_1, var_28_7, cc.p(0, 300))

	arg_28_0._selectCardList = var_28_7

	for iter_28_0 = 1, P._playerFindSurvival.TOTAL_CARD_COUNT do
		local var_28_8 = 10001
		local var_28_9 = ccui.Layout:create()

		var_28_9:setContentSize(cc.size(190, 270))
		var_28_9:setAnchorPoint(0.5, 0.5)
		var_28_7:pushBackCustomItem(var_28_9)

		local var_28_10 = var_0_1.createFromPool(var_28_8, var_0_5)

		var_28_10._thumbnail:setTouchEnabled(true)
		var_28_10._thumbnail:addTouchEventListener(function(arg_29_0, arg_29_1)
			arg_28_0:onTouchThumbnail(arg_29_0, arg_29_1, var_0_8.select_card)
		end)
		lc.addChildToCenter(var_28_9, var_28_10)
		table.insert(arg_28_0._thumbnails, var_28_10)
	end

	arg_28_0:updateSelectCards()
	ClientView.getResourceUI():setMode(Data.ResType.gold)
end

function var_0_0.hideSelectCards(arg_30_0)
	if not arg_30_0._cardsLayer then
		return
	end

	arg_30_0:releaseSelectCards()
	arg_30_0:releaseTroopCards()
	arg_30_0._cardsLayer:removeFromParent()

	arg_30_0._cardsLayer = nil
	arg_30_0._troopList = nil
	arg_30_0._selectCardList = nil
end

function var_0_0.updateSelectCards(arg_31_0)
	local var_31_0 = P._playerFindSurvival:getSelectCards()
	local var_31_1 = 0

	for iter_31_0 = 1, #var_31_0 do
		local var_31_2 = var_31_0[iter_31_0]
		local var_31_3 = arg_31_0._thumbnails[iter_31_0]

		var_31_3._thumbnail:updateComponent(var_31_2._infoId)
		var_31_3:setVisible(true)

		if not var_31_2._isValid then
			var_31_3._thumbnail._frame._frame:setEffect(ClientView.SHADER_DISABLE)
			var_31_3._thumbnail._frame:setEffect(ClientView.SHADER_DISABLE)

			var_31_1 = var_31_1 + 1
		else
			var_31_3._thumbnail._frame:setEffect(nil)
		end
	end

	for iter_31_1 = 1, #var_31_0 do
		local var_31_4 = arg_31_0._thumbnails[iter_31_1]

		if var_31_1 == P._playerFindSurvival.SELECT_CARD_COUNT then
			var_31_4._isValid = false
		else
			var_31_4._isValid = var_31_0[iter_31_1]._isValid
		end

		if var_31_1 == 0 then
			var_31_4._thumbnail:setOpacity(0)
			var_31_4._thumbnail:runAction(lc.fadeTo(1, 255))

			local var_31_5 = Particle.create("chuxian")

			lc.addChildToCenter(var_31_4, var_31_5)
		else
			var_31_4._thumbnail:setOpacity(255)
		end
	end

	local var_31_6 = P._playerFindSurvival.SELECT_CARD_COUNT - var_31_1
	local var_31_7 = string.format(lc.str(STR.SELECT_CARD), var_31_6, P._playerFindSurvival.TOTAL_CARD_COUNT, P._playerFindSurvival.SELECT_CARD_COUNT)

	arg_31_0._selectTitle:setString(var_31_7)
	arg_31_0:updateTroopList()
end

function var_0_0.updateTroopList(arg_32_0)
	local var_32_0 = arg_32_0:remainItemFromList()

	arg_32_0:releaseTroopCards()

	local var_32_1 = {}

	for iter_32_0, iter_32_1 in ipairs(P._playerFindSurvival._troopCards) do
		local var_32_2

		for iter_32_2 = 1, #var_32_0 do
			if var_32_0[iter_32_2]._card._infoId == iter_32_1._infoId then
				var_32_2 = var_32_0[iter_32_2]

				break
			end
		end

		if not var_32_2 then
			var_32_2 = ccui.Layout:create()

			var_32_2:retain()

			local var_32_3 = var_0_1.createFromPool(iter_32_1._infoId, var_0_6)

			var_32_3._countArea:update(true, iter_32_1._num)
			var_32_2:setContentSize(var_32_3._thumbnail:getContentSize())
			var_32_2:setAnchorPoint(cc.p(0.5, 0.5))
			lc.addChildToPos(var_32_2, var_32_3, cc.p(lc.cw(var_32_2), lc.ch(var_32_2) + 10))
			var_32_3._thumbnail:setTouchEnabled(true)
			var_32_3._thumbnail:addTouchEventListener(function(arg_33_0, arg_33_1)
				arg_32_0:onTouchThumbnail(arg_33_0, arg_33_1, var_0_8.troop_card)
			end)

			var_32_2._item = var_32_3
		else
			var_32_2._item._countArea:update(true, iter_32_1._num)
		end

		table.insert(var_32_1, var_32_2)

		var_32_2._card = iter_32_1
	end

	table.sort(var_32_1, function(arg_34_0, arg_34_1)
		local var_34_0 = Data.getOriginId(arg_34_0._card._infoId)
		local var_34_1 = Data.getOriginId(arg_34_1._card._infoId)

		if var_34_0 < var_34_1 then
			return true
		elseif var_34_1 < var_34_0 then
			return false
		else
			return arg_34_0._card._infoId < arg_34_1._card._infoId
		end
	end)

	for iter_32_3, iter_32_4 in ipairs(var_32_1) do
		arg_32_0._troopList:pushBackCustomItem(iter_32_4)
	end

	local var_32_4, var_32_5, var_32_6, var_32_7, var_32_8 = P._playerFindSurvival:getTroopCardCount()
	local var_32_9 = string.format(lc.str(STR.FIND_SURVIVAL_TIPS), var_32_4, P._playerFindSurvival.MAX_TROOP_COUNT, var_32_5 + var_32_6, var_32_7 + var_32_8)

	arg_32_0._troopDescLabel:setString(var_32_9)
end

function var_0_0.releaseSelectCards(arg_35_0)
	if #arg_35_0._thumbnails > 0 then
		for iter_35_0, iter_35_1 in ipairs(arg_35_0._thumbnails) do
			var_0_1.releaseToPool(iter_35_1)
		end

		arg_35_0._thumbnails = {}
	end
end

function var_0_0.releaseTroopCards(arg_36_0)
	if arg_36_0._troopList then
		local var_36_0 = arg_36_0._troopList:getItems()

		for iter_36_0, iter_36_1 in ipairs(var_36_0) do
			var_0_1.releaseToPool(iter_36_1._item)
			iter_36_1:release()
		end

		arg_36_0._troopList:removeAllItems()
	end
end

function var_0_0.createTroopArea(arg_37_0, arg_37_1)
	local var_37_0 = lc.createSprite({
		_name = "img_troop_bg_1",
		_size = cc.size(lc.w(arg_37_0), 212),
		_crect = cc.rect(47, 0, 1, 212)
	})

	lc.addChildToPos(arg_37_1, var_37_0, cc.p(lc.cw(arg_37_1), lc.ch(var_37_0)))

	local var_37_1 = lc.createSprite("img_troop_name_bg")

	lc.addChildToPos(var_37_0, var_37_1, cc.p(lc.cw(var_37_1) + 25, lc.h(var_37_0) + lc.ch(var_37_1)))

	local var_37_2 = ClientView.createTTF(Str(STR.PUBG), ClientView.FontSize.M2, ClientView.COLOR_TEXT_BLUE)

	var_37_2:enableShadow()
	lc.addChildToPos(var_37_1, var_37_2, cc.p(lc.cw(var_37_2) + 10, lc.ch(var_37_1)))

	local var_37_3 = lc.List.createH(cc.size(lc.w(var_37_0) - 40, lc.h(var_37_0) - 6), 20, 10)

	lc.addChildToPos(var_37_0, var_37_3, cc.p(24, 0))

	arg_37_0._troopList = var_37_3

	local var_37_4 = P._playerFindSurvival
	local var_37_5 = string.format(lc.str(STR.FIND_SURVIVAL_TIPS), var_37_4.MAX_TROOP_COUNT, var_37_4.MAX_TROOP_COUNT, var_37_4.MAX_TROOP_COUNT, var_37_4.MAX_TROOP_COUNT)
	local var_37_6 = ClientView.createTTF(var_37_5, ClientView.FontSize.S1, lc.Color3B.black)
	local var_37_7 = lc.createSprite({
		_name = "img_tip_bg2",
		_size = cc.size(lc.w(var_37_6) + 40 + 40, 51),
		_crect = cc.rect(36, 25, 1, 1)
	})

	lc.addChildToPos(var_37_0, var_37_7, cc.p(lc.right(var_37_1) + 230, lc.h(var_37_0) + lc.ch(var_37_7) + 10))
	lc.addChildToPos(var_37_7, var_37_6, cc.p(lc.cw(var_37_6) + 40, lc.ch(var_37_7)))

	arg_37_0._troopDescLabel = var_37_6

	return var_37_0
end

function var_0_0.onTouchThumbnail(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if arg_38_2 == ccui.TouchEventType.began then
		arg_38_1:stopAllActions()
		arg_38_1:runAction(lc.scaleTo(0.1, 0.95))
		arg_38_0:onItemPress(arg_38_1, arg_38_3)
	elseif arg_38_2 == ccui.TouchEventType.ended or arg_38_2 == ccui.TouchEventType.canceled then
		arg_38_1:stopAllActions()
		arg_38_1:runAction(lc.scaleTo(0.08, 1))
		arg_38_0:onItemTap(arg_38_1, arg_38_3)
	elseif arg_38_2 == ccui.TouchEventType.moved then
		arg_38_0:onItemMove(arg_38_1, arg_38_3)
	end
end

function var_0_0.onItemPress(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0._movingSprite then
		return
	end

	arg_39_0._touchStatus = var_0_0.TouchStatus.press
	arg_39_0._movingDir = var_0_7.none
end

function var_0_0.onItemMove(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_0._touchStatus == var_0_0.TouchStatus.tap then
		return
	end

	arg_40_0._touchStatus = var_0_0.TouchStatus.move

	if arg_40_0._movingSprite == nil then
		if arg_40_0._movingDir == var_0_7.none then
			local var_40_0 = math.abs(cc.pSub(arg_40_1:getTouchMovePosition(), arg_40_1:getTouchBeganPosition()).x)
			local var_40_1 = math.abs(cc.pSub(arg_40_1:getTouchMovePosition(), arg_40_1:getTouchBeganPosition()).y)

			if var_40_0 > 32 or var_40_1 > 32 then
				arg_40_0._movingDir = var_40_1 <= var_40_0 and var_0_7.horizontal or var_0_7.vertical
			end
		end

		if arg_40_2 == var_0_8.select_card and arg_40_0._movingDir == var_0_7.vertical and arg_40_1._item._isValid then
			arg_40_0:createMovingSpriteAndMaskLayer(arg_40_1)

			if arg_40_0._selectCardList then
				arg_40_0._selectCardList:setIsScrollEnabled(false)
			end
		end
	end

	if arg_40_0._movingSprite then
		arg_40_0._movingSprite:setPosition(cc.pAdd(arg_40_0._movingSprite._srcPos, cc.pSub(arg_40_1:getTouchMovePosition(), arg_40_1:getTouchBeganPosition())))
	end
end

function var_0_0.onItemTap(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0._touchStatus = var_0_0.TouchStatus.tap

	local var_41_0 = arg_41_1._infoId

	if arg_41_0._movingDir == var_0_7.none then
		if arg_41_2 == var_0_8.troop_card then
			local var_41_1 = {}
			local var_41_2 = 0
			local var_41_3 = arg_41_0._troopList:getItems()

			for iter_41_0 = 1, #var_41_3 do
				local var_41_4 = var_41_3[iter_41_0]._item._thumbnail

				var_41_1[#var_41_1 + 1] = {
					_infoId = var_41_4._infoId,
					_num = var_41_4._count
				}

				if arg_41_1 == var_41_4 then
					var_41_2 = iter_41_0
				end
			end

			local var_41_5 = var_0_2.create(var_41_0, 1, var_0_2.OperateType.na)

			var_41_5:setCardList(var_41_1, var_41_2, Str(STR.CUR_TROOP))
			var_41_5:setCardCount(arg_41_1._count)
			var_41_5:show()
		else
			var_0_2.create(var_41_0, 1, var_0_2.OperateType.na):show()
		end
	elseif arg_41_2 == var_0_8.select_card and arg_41_0._movingSprite then
		if P._playerFindSurvival:getTroopCardCount() < P._playerFindSurvival.MAX_TROOP_COUNT then
			if lc.y(arg_41_0._movingSprite) < arg_41_0._separatorPos then
				arg_41_0:onSelectCard(var_41_0)
			end
		else
			ToastManager.push(Str(STR.FULL_IN_TROOP))
		end
	end

	if arg_41_0._maskLayer then
		arg_41_0._maskLayer:removeFromParent(true)

		arg_41_0._maskLayer = nil
	end

	if arg_41_0._movingSprite then
		arg_41_0._movingSprite:removeFromParent()

		arg_41_0._movingSprite = nil
	end

	if arg_41_0._selectCardList then
		arg_41_0._selectCardList:setIsScrollEnabled(true)
	end
end

function var_0_0.createMovingSpriteAndMaskLayer(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0._troopList
	local var_42_1 = arg_42_1:convertToWorldSpace(cc.p(lc.w(arg_42_1) / 2, lc.h(arg_42_1) / 2))
	local var_42_2 = arg_42_0:convertToNodeSpace(var_42_1)
	local var_42_3 = arg_42_1._infoId
	local var_42_4 = var_0_1.create(var_42_3, var_0_5)

	arg_42_0:addChild(var_42_4, ClientData.ZOrder.ui + 2)

	arg_42_0._movingSprite = var_42_4
	arg_42_0._movingSprite._srcPos = var_42_2
	arg_42_0._movingSprite._abc = 1

	arg_42_0._movingSprite:setPosition(cc.pAdd(var_42_2, cc.pSub(arg_42_1:getTouchMovePosition(), arg_42_1:getTouchBeganPosition())))

	local var_42_5 = var_42_0:convertToWorldSpace(cc.p(0, 0))
	local var_42_6 = arg_42_0:convertToNodeSpace(var_42_5)

	var_42_6.x = 0

	local var_42_7 = cc.rect(var_42_6.x, var_42_6.y, lc.w(arg_42_0), lc.h(var_42_0))
	local var_42_8 = cc.LayerColor:create(cc.c4b(0, 0, 0, 192), lc.w(arg_42_0), lc.h(arg_42_0))

	arg_42_0._maskLayer = ClientView.createClipNode(var_42_8, var_42_7, true)

	arg_42_0:addChild(arg_42_0._maskLayer, ClientData.ZOrder.ui + 1)

	arg_42_0._separatorPos = var_42_6.y + var_42_7.height
end

function var_0_0.remainItemFromList(arg_43_0)
	local var_43_0 = {}
	local var_43_1 = arg_43_0._troopList:getItems()

	for iter_43_0 = #var_43_1, 1, -1 do
		local var_43_2 = var_43_1[iter_43_0]
		local var_43_3 = false

		for iter_43_1, iter_43_2 in ipairs(P._playerFindSurvival._troopCards) do
			if var_43_2._card._infoId == iter_43_2._infoId then
				var_43_3 = true

				break
			end
		end

		if var_43_3 then
			table.insert(var_43_0, var_43_2)
			arg_43_0._troopList:removeItem(iter_43_0 - 1, false)
		end
	end

	return var_43_0
end

function var_0_0.playAction(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = cc.p(lc.cw(arg_44_0), lc.ch(arg_44_0._troopList))
	local var_44_1 = arg_44_0._troopList:getItems()

	for iter_44_0, iter_44_1 in ipairs(var_44_1) do
		if iter_44_1._card._infoId == arg_44_2 then
			var_44_0 = arg_44_0:convertToNodeSpace(iter_44_1:convertToWorldSpace(cc.p(lc.cw(iter_44_1), lc.ch(iter_44_1))))

			break
		end
	end

	local var_44_2 = cc.Node:create()

	lc.addChildToPos(arg_44_0, var_44_2, arg_44_1)

	local var_44_3 = Particle.create("sz1")

	lc.addChildToCenter(var_44_2, var_44_3)

	local var_44_4 = Particle.create("sz2")

	lc.addChildToCenter(var_44_2, var_44_4)
	var_44_2:setScale(2)
	var_44_2:runAction(lc.sequence(lc.moveTo(0.4, var_44_0), lc.call(function()
		var_44_3:setDuration(0.1)
		var_44_4:setDuration(0.1)
	end), lc.delay(1), lc.remove()))
end

function var_0_0.enterBattleField(arg_46_0)
	if arg_46_0._battleLayer ~= nil then
		return
	end

	arg_46_0:hideSelectCards()

	local var_46_0 = lc.createNode(arg_46_0:getContentSize())

	lc.addChildToCenter(arg_46_0, var_46_0, 100)

	arg_46_0._battleLayer = var_46_0

	local var_46_1 = arg_46_0:createTroopArea(var_46_0)

	arg_46_0:updateTroopList()

	local var_46_2 = lc.createSpriteWithMask("res/jpg/img_survive_start_bg.jpg")

	lc.addChildToPos(var_46_0, var_46_2, cc.p(lc.cw(var_46_0), lc.h(var_46_0) - lc.ch(var_46_2)))

	local var_46_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_47_0)
		arg_46_0:onFindingHall()
	end, ClientView.CRECT_BUTTON, 140)

	lc.addChildToPos(var_46_2, var_46_3, cc.p(lc.cw(var_46_2), 20))
	var_46_3:addLabel(Str(STR.START))

	arg_46_0._btnFind = var_46_3

	local var_46_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("LogForm").create(Battle_pb.PB_BATTLE_SURVIVAL):show()
	end, ClientView.CRECT_BUTTON_S, 100)

	lc.addChildToPos(var_46_0, var_46_4, cc.p(lc.w(var_46_0) - lc.cw(var_46_4) - 20 - ClientView.SCR_EDGE, lc.top(var_46_1) + lc.ch(var_46_4)))
	var_46_4:addLabel(Str(STR.LOG))

	local var_46_5 = ClientView.createScale9ShaderButton("img_btn_3_s", function(arg_49_0)
		require("Dialog").showDialog(Str(STR.CONFIRM_TO_GIVEUP), function()
			arg_46_0:onFinishBattle()
		end)
	end, ClientView.CRECT_BUTTON_S, 100)

	lc.addChildToPos(var_46_0, var_46_5, cc.p(lc.left(var_46_4) - lc.cw(var_46_5) - 20, lc.y(var_46_4)))
	var_46_5:addLabel(Str(STR.GIVEUP))

	arg_46_0._btnGiveup = var_46_5

	ClientView.getResourceUI():setMode(Data.ResType.gold)
end

function var_0_0.hideBattleField(arg_51_0)
	if not arg_51_0._battleLayer then
		return
	end

	arg_51_0:releaseTroopCards()
	arg_51_0._battleLayer:removeFromParent()

	arg_51_0._battleLayer = nil
	arg_51_0._troopList = nil
end

return var_0_0
