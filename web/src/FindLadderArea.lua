local var_0_0 = class("FindLadderArea", lc.ExtendCCNode)
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
	arg_3_0._listeners = {}

	ClientData.addMsgListener(arg_3_0, function(arg_4_0)
		return arg_3_0:onMsg(arg_4_0)
	end, 0)
	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.arena_privilege_dirty, function(arg_5_0)
		ClientView.getActiveIndicator():hide()
		arg_3_0:enterLayer()
	end))
	arg_3_0:enterLayer()
end

function var_0_0.enterLayer(arg_6_0)
	if arg_6_0._doorLayer then
		arg_6_0._doorLayer:removeFromParent()

		arg_6_0._doorLayer = nil
	end

	if arg_6_0._characterLayer then
		arg_6_0._characterLayer:removeFromParent()

		arg_6_0._characterLayer = nil
	end

	if arg_6_0._cardsLayer then
		arg_6_0._cardsLayer:removeFromParent()

		arg_6_0._cardsLayer = nil
	end

	if arg_6_0._battleLayer then
		arg_6_0._battleLayer:removeFromParent()

		arg_6_0._battleLayer = nil
	end

	if not P._playerFindLadder._hasTicket then
		arg_6_0:enterDoor()
	elseif P._playerFindLadder._characterId == 0 then
		arg_6_0:enterSelectCharacter()
	elseif P._playerFindLadder._step <= P._playerFindLadder.MAX_TROOP_COUNT then
		arg_6_0:enterSelectCards()
	else
		arg_6_0:enterBattleField()
	end
end

function var_0_0.onExit(arg_7_0)
	for iter_7_0 = 1, #arg_7_0._listeners do
		lc.Dispatcher:removeEventListener(arg_7_0._listeners[iter_7_0])
	end

	ClientData.removeMsgListener(arg_7_0)
end

function var_0_0.onCleanup(arg_8_0)
	arg_8_0:releaseSelectCards()
	arg_8_0:releaseTroopCards()
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/arena_door.jpg"))
end

function var_0_0.onMsg(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.type

	if var_9_0 == SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET then
		ClientView.getActiveIndicator():hide()
		arg_9_0:enterSelectCharacter()

		return true
	elseif var_9_0 == SglMsgType_pb.PB_TYPE_WORLD_ROLL_CHAR then
		ClientView.getActiveIndicator():hide()

		if arg_9_0._characterLayer then
			arg_9_0._characterLayer:removeFromParent()

			arg_9_0._characterLayer = nil
		end

		arg_9_0._characterId = 0

		arg_9_0:enterSelectCharacter()

		return true
	elseif var_9_0 == SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR then
		ClientView.getActiveIndicator():hide()
		arg_9_0:enterSelectCards()

		return true
	elseif var_9_0 == SglMsgType_pb.PB_TYPE_WORLD_SELECT_CARD then
		P._playerFindLadder._step = arg_9_1.Extensions[World_pb.SglWorldMsg.world_select_card_resp]

		if P._playerFindLadder._step % P._playerFindLadder.SELECT_CARD_COUNT == 1 then
			if P._playerFindLadder._step > P._playerFindLadder.MAX_TROOP_COUNT then
				arg_9_0:enterBattleField()
			else
				arg_9_0:updateSelectCards()
			end
		end

		return true
	elseif var_9_0 == SglMsgType_pb.PB_TYPE_WORLD_QUIT then
		ClientData.sendOpenBox(P._playerFindLadder._chest._infoId, 1)

		return true
	elseif var_9_0 == SglMsgType_pb.PB_TYPE_USER_OPEN_CHEST then
		local var_9_1 = arg_9_1.Extensions[User_pb.SglUserMsg.user_open_chest_resp]

		P._playerFindLadder:clear()

		arg_9_0._characterId = 0

		ClientView.getActiveIndicator():hide()
		arg_9_0:hideBattleField()
		arg_9_0:enterDoor()

		local var_9_2 = require("RewardPanel")

		var_9_2.create(var_9_1, var_9_2.MODE_CHEST):show()

		return true
	end

	return false
end

function var_0_0.init(arg_10_0)
	arg_10_0._characterId = P._playerFindLadder._characterId
	arg_10_0._thumbnails = {}
end

function var_0_0.onSelectCard(arg_11_0, arg_11_1)
	local var_11_0 = P._playerFindLadder:getSelectCardIndex(arg_11_1)

	P._playerFindLadder:addCardToTroop(arg_11_1, var_11_0)
	ClientData.sendLadderSelectCard(var_11_0)

	local var_11_1 = arg_11_0._movingSprite._srcPos

	arg_11_0:updateSelectCards()
	arg_11_0:runAction(lc.sequence(0, function()
		arg_11_0:playAction(var_11_1, arg_11_1)
	end))
end

function var_0_0.onSelectCharacter(arg_13_0)
	P._playerFindLadder._characterId = arg_13_0._characterId
	P._playerFindLadder._step = 1

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendLadderSelectCharacter(arg_13_0._characterId)
end

function var_0_0.onBuyTicket(arg_14_0, arg_14_1)
	if arg_14_1 == Data.ResType.gold then
		if not ClientView.checkGold(Data._globalInfo._buyTicketGold) then
			return
		end

		P:changeResource(Data.ResType.gold, -Data._globalInfo._buyTicketGold)
	elseif arg_14_1 == Data.ResType.ingot then
		if not ClientView.checkIngot(Data._globalInfo._buyTicketIngot) then
			return
		end

		P:changeResource(Data.ResType.ingot, -Data._globalInfo._buyTicketIngot)
	else
		if not P._propBag:hasProps(Data.PropsId.ladder_ticket, 1) then
			return ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(Data._propsInfo[Data.PropsId.ladder_ticket]._nameSid)))
		end

		P._propBag:changeProps(Data.PropsId.ladder_ticket, -1)
	end

	P._playerFindLadder._hasTicket = true

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendLadderBuyTicket(arg_14_1)
end

function var_0_0.onFindingBattle(arg_15_0)
	if ClientView._findMatchPanel then
		return
	end

	if ClientData.isAppStoreReviewing() or P._playerFindLadder:getIsValidTime() == 0 then
		require("FindMatchPanel").create(Data.FindMatchType.ladder):show()
	else
		local var_15_0 = P._playerFindLadder:getTimeTip()

		ToastManager.push(var_15_0)
	end
end

function var_0_0.onFinishBattle(arg_16_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendLadderQuit()
end

function var_0_0.enterDoor(arg_17_0)
	if arg_17_0._doorLayer ~= nil then
		return
	end

	local var_17_0 = lc.createNode(arg_17_0:getContentSize())

	lc.addChildToCenter(arg_17_0, var_17_0, 1)

	arg_17_0._doorLayer = var_17_0
	arg_17_0._doors = {}

	for iter_17_0 = 1, 2 do
		local var_17_1 = cc.Sprite:create("res/jpg/arena_door.jpg")

		lc.addChildToCenter(var_17_0, var_17_1)
		var_17_1:setAnchorPoint(cc.p(2 - iter_17_0, 0.5))
		var_17_1:setFlippedX(iter_17_0 == 2)

		arg_17_0._doors[iter_17_0] = var_17_1
	end

	local var_17_2 = lc.createNode()

	lc.addChildToPos(var_17_0, var_17_2, cc.p(0, 0))

	var_17_0._tipNode = var_17_2

	if not ClientData.isAppStoreReviewing() then
		local var_17_3 = lc.createSprite({
			_name = "img_com_bg_41",
			_size = cc.size(672, 54),
			_crect = cc.rect(29, 26, 1, 1)
		})

		lc.addChildToPos(var_17_2, var_17_3, cc.p(lc.cw(var_17_0), 180))

		local var_17_4 = ClientView.createTTF(P._playerFindLadder:getTimeTip(), ClientView.FontSize.M2, nil, cc.size(652, 0), cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

		lc.addChildToCenter(var_17_3, var_17_4)
		var_17_3:setContentSize(lc.w(var_17_3), math.max(lc.h(var_17_4) + 20, 54))
		var_17_4:setPositionY(lc.ch(var_17_3))
	end

	local function var_17_5(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = ccui.Button:create("img_btn_1.png")
		var_18_0:addClickEventListener(function(arg_19_0)
			arg_17_0:onBuyTicket(arg_18_2)
		end)
		var_18_0:setScale9Enabled(true)
		var_18_0:setContentSize(cc.size(180, 50))
		local var_18_1 = lc.createSprite(arg_18_0)
		local var_18_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_18_1)

		lc.addChildToPos(var_18_0, var_18_1, cc.p(lc.cw(var_18_0) - (lc.w(var_18_2) + 12) / 2, lc.ch(var_18_0)))
		lc.addChildToPos(var_18_0, var_18_2, cc.p(lc.right(var_18_1) + lc.cw(var_18_2) + 12, lc.ch(var_18_0)))

		return var_18_0
	end

	if P._propBag:hasProps(Data.PropsId.ladder_ticket, 1) then
		local var_17_6 = var_17_5("img_icon_props_s7106", 1, Data.PropsId.ladder_ticket)

		lc.addChildToPos(var_17_2, var_17_6, cc.p(lc.cw(var_17_0), 80))
	else
		local var_17_7 = var_17_5("img_icon_res1_s", Data._globalInfo._buyTicketGold, Data.ResType.gold)

		lc.addChildToPos(var_17_2, var_17_7, cc.p(lc.cw(var_17_0), 80))
	end

	ClientView.getResourceUI():setMode(Data.PropsId.ladder_ticket)
end

function var_0_0.hideDoor(arg_20_0)
	if not arg_20_0._doorLayer then
		return
	end

	local var_20_0 = arg_20_0._doorLayer

	var_20_0._tipNode:setVisible(false)

	for iter_20_0 = 1, #arg_20_0._doors do
		local var_20_1 = cc.p(iter_20_0 == 1 and 0 or lc.w(arg_20_0._doorLayer), lc.ch(arg_20_0._doorLayer))

		arg_20_0._doors[iter_20_0]:runAction(lc.sequence(lc.moveTo(0.8, var_20_1), lc.call(function()
			var_20_0:removeFromParent()
		end)))
	end

	arg_20_0._doorLayer = nil
	arg_20_0._doors = nil

	ClientView.getResourceUI():setMode(ClientData.isAppStoreReviewing() and Data.ResType.gold or Data.ResType.ladder_trophy)
end

function var_0_0.enterSelectCharacter(arg_22_0)
	if arg_22_0._characterLayer ~= nil then
		return
	end

	arg_22_0:hideDoor()

	if ClientData.isAppStoreReviewing() then
		arg_22_0._characterId = P._playerFindLadder._characters[1]

		arg_22_0:onSelectCharacter()

		return
	end

	local var_22_0 = lc.createNode(arg_22_0:getContentSize())

	lc.addChildToCenter(arg_22_0, var_22_0)

	arg_22_0._characterLayer = var_22_0

	local var_22_1 = 980
	local var_22_2 = lc.List.createH(cc.size(lc.w(var_22_0), var_0_4), math.max(0, (lc.w(var_22_0) - var_22_1) / 2))

	var_22_2:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_22_0, var_22_2, cc.p(lc.cw(var_22_0), lc.ch(var_22_0) + 70))

	arg_22_0._characterList = var_22_2

	for iter_22_0 = 1, #P._playerFindLadder._characters do
		local var_22_3 = P._playerFindLadder._characters[iter_22_0]
		local var_22_4 = arg_22_0:createCharacterItem(var_22_3)

		var_22_2:pushBackCustomItem(var_22_4)
	end

	local var_22_5 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_23_0)
		arg_22_0:onSelectCharacter()
	end, ClientView.CRECT_BUTTON, 250)

	lc.addChildToPos(var_22_0, var_22_5, cc.p(lc.cw(var_22_0) - 200, 110))
	var_22_5:addLabel(Str(STR.OK))

	local var_22_6 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_24_0)
		arg_22_0:onReselectCharacter()
	end, ClientView.CRECT_BUTTON, 250)

	lc.addChildToPos(var_22_0, var_22_6, cc.p(lc.cw(var_22_0) + 200, 110))

	local var_22_7 = lc.createSprite({
		_name = "img_title_bg",
		_size = cc.size(480, 52),
		_crect = cc.rect(115, 25, 1, 1)
	})

	lc.addChildToPos(var_22_0, var_22_7, cc.p(lc.cw(var_22_0), 40))

	local var_22_8

	if P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.arena_privilege_2) > 0 then
		var_22_8 = string.format(Str(STR.ARENA_PRIVILEGE_REMAIN_2), P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.arena_privilege_2))

		var_22_6:addLabel(Str(STR.RESELECT) .. string.format("(%s)", string.format(Str(STR.REMAIN_BUY_TIMES), P._playerFindLadder:getRemainRollTimes())))
	elseif P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.arena_privilege_1) > 0 then
		var_22_8 = string.format(Str(STR.ARENA_PRIVILEGE_REMAIN), P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.arena_privilege_1))

		var_22_6:addLabel(Str(STR.RESELECT) .. string.format("(%s)", string.format(Str(STR.REMAIN_BUY_TIMES), P._playerFindLadder:getRemainRollTimes())))
	else
		var_22_6:addLabel(Str(STR.RESELECT))
	end

	if var_22_8 then
		local var_22_9 = ClientView.createTTF(var_22_8, ClientView.FontSize.S1)

		lc.addChildToCenter(var_22_7, var_22_9)
	else
		var_22_7:setVisible(false)
	end

	if arg_22_0._characterId == 0 then
		arg_22_0._characterId = P._playerFindLadder._characters[1]
	end

	arg_22_0:selectCharacter(arg_22_0._characterId)
end

function var_0_0.hideSelectCharacter(arg_25_0)
	if not arg_25_0._characterLayer then
		return
	end

	arg_25_0._characterLayer:removeFromParent()

	arg_25_0._characterLayer = nil
end

function var_0_0.createCharacterItem(arg_26_0, arg_26_1)
	local var_26_0 = Data._characterInfo[arg_26_1]
	local var_26_1 = ClientView.createShaderButton(nil, function(arg_27_0)
		arg_26_0:selectCharacter(var_26_0._id)
	end)

	var_26_1._id = var_26_0._id

	var_26_1:setContentSize(var_0_3, var_0_4)

	local var_26_2 = lc.createSprite({
		_name = "img_com_bg_43",
		_size = cc.size(var_0_3, ClientView.CRECT_COM_BG43.height),
		_crect = ClientView.CRECT_COM_BG43
	})

	lc.addChildToPos(var_26_1, var_26_2, cc.p(lc.cw(var_26_1), lc.ch(var_26_2)), 1)

	var_26_1._nameBg = var_26_2

	local var_26_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(var_26_0._nameSid))

	lc.addChildToCenter(var_26_2, var_26_3)

	local var_26_4 = DragonBones.create(Data.getCharacterBoneName(var_26_0._id))

	var_26_4:gotoAndPlay(Data.getCharacterAniName(var_26_0._id))
	var_26_4:setScale(0.5)
	lc.addChildToPos(var_26_1, var_26_4, cc.p(lc.x(var_26_2), lc.top(var_26_2) + 120))
	lc.offset(var_26_4, 0, Data.getCharacterOffsetY(var_26_0._id, true) * 0.5)

	local var_26_5 = lc.createSprite("img_light")

	var_26_5:setScale(5.5)
	lc.addChildToPos(var_26_1, var_26_5, cc.p(lc.x(var_26_2), lc.top(var_26_2) + 180), -1)

	var_26_1._light = var_26_5

	local var_26_6 = Particle.create("xuanzhong")

	var_26_6:setPositionType(cc.POSITION_TYPE_GROUPED)
	lc.addChildToPos(var_26_1, var_26_6, cc.p(lc.x(var_26_2), lc.top(var_26_2) + 20), -1)

	var_26_1._particle = var_26_6

	if var_26_0._id == 2 then
		lc.offset(var_26_4, 10, 0)
	end

	if var_26_0._id == 14 then
		lc.offset(var_26_4, 0, 60)
	end

	return var_26_1
end

function var_0_0.selectCharacter(arg_28_0, arg_28_1)
	arg_28_0._characterId = arg_28_1

	local var_28_0 = arg_28_0._characterList:getItems()

	for iter_28_0 = 1, #var_28_0 do
		local var_28_1 = var_28_0[iter_28_0]

		var_28_1._nameBg:setSpriteFrame(lc.FrameCache:getSpriteFrame(var_28_1._id == arg_28_1 and "img_com_bg_44" or "img_com_bg_43"), ClientView.CRECT_COM_BG43)
		var_28_1._nameBg:setContentSize(var_0_3, ClientView.CRECT_COM_BG43.height)
		var_28_1._light:setVisible(var_28_1._id == arg_28_1)
		var_28_1._particle:setVisible(var_28_1._id == arg_28_1)
	end
end

function var_0_0.enterSelectCards(arg_29_0)
	if arg_29_0._cardsLayer ~= nil then
		return
	end

	arg_29_0:hideSelectCharacter()

	local var_29_0 = lc.createNode(arg_29_0:getContentSize())

	lc.addChildToCenter(arg_29_0, var_29_0)

	arg_29_0._cardsLayer = var_29_0

	local var_29_1 = arg_29_0:createTroopArea(var_29_0)
	local var_29_2 = lc.createSprite({
		_name = "img_title_bg",
		_size = cc.size(480, 52),
		_crect = cc.rect(115, 25, 1, 1)
	})

	lc.addChildToPos(var_29_0, var_29_2, cc.p(lc.cw(var_29_0), lc.h(var_29_0) - 40))

	local var_29_3 = string.format(lc.str(STR.SELECT_CARD), 0, P._playerFindLadder.TOTAL_CARD_COUNT, P._playerFindLadder.SELECT_CARD_COUNT)
	local var_29_4 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_29_3)

	lc.addChildToCenter(var_29_2, var_29_4)

	arg_29_0._selectTitle = var_29_4

	local var_29_5 = 10
	local var_29_6 = P._playerFindLadder.TOTAL_CARD_COUNT * (ClientView.CARD_SIZE.width * var_0_5 + var_29_5) - var_29_5
	local var_29_7 = lc.List.createH(cc.size(lc.w(arg_29_0), 300), math.max(20, (lc.w(var_29_0) - var_29_6) / 2), var_29_5)

	lc.addChildToPos(var_29_1, var_29_7, cc.p(0, 300))

	arg_29_0._selectCardList = var_29_7

	for iter_29_0 = 1, P._playerFindLadder.TOTAL_CARD_COUNT do
		local var_29_8 = 10001
		local var_29_9 = ccui.Layout:create()

		var_29_9:setContentSize(cc.size(190, 270))
		var_29_9:setAnchorPoint(0.5, 0.5)
		var_29_7:pushBackCustomItem(var_29_9)

		local var_29_10 = var_0_1.createFromPool(var_29_8, var_0_5)

		var_29_10._thumbnail:setTouchEnabled(true)
		var_29_10._thumbnail:addTouchEventListener(function(arg_30_0, arg_30_1)
			arg_29_0:onTouchThumbnail(arg_30_0, arg_30_1, var_0_8.select_card)
		end)
		lc.addChildToCenter(var_29_9, var_29_10)
		table.insert(arg_29_0._thumbnails, var_29_10)
	end

	arg_29_0:updateSelectCards()
end

function var_0_0.hideSelectCards(arg_31_0)
	if not arg_31_0._cardsLayer then
		return
	end

	arg_31_0:releaseSelectCards()
	arg_31_0:releaseTroopCards()
	arg_31_0._cardsLayer:removeFromParent()

	arg_31_0._cardsLayer = nil
	arg_31_0._troopList = nil
	arg_31_0._selectCardList = nil
end

function var_0_0.updateSelectCards(arg_32_0)
	local var_32_0, var_32_1, var_32_2, var_32_3, var_32_4 = P._playerFindLadder:getTroopCardCount()
	local var_32_5 = string.format(lc.str(STR.FIND_ARENA_TIPS), var_32_0, P._playerFindLadder.MAX_TROOP_COUNT, var_32_1 + var_32_2, var_32_3 + var_32_4)

	arg_32_0._troopDescLabel:setString(var_32_5)

	local var_32_6 = P._playerFindLadder:getSelectCards()
	local var_32_7 = 0

	for iter_32_0 = 1, #var_32_6 do
		local var_32_8 = var_32_6[iter_32_0]
		local var_32_9 = arg_32_0._thumbnails[iter_32_0]

		var_32_9._thumbnail:updateComponent(var_32_8._infoId)
		var_32_9:setVisible(true)

		if not var_32_8._isValid then
			var_32_9._thumbnail._frame._frame:setEffect(ClientView.SHADER_DISABLE)
			var_32_9._thumbnail._frame:setEffect(ClientView.SHADER_DISABLE)

			var_32_7 = var_32_7 + 1
		else
			var_32_9._thumbnail._frame:setEffect(nil)
		end
	end

	for iter_32_1 = 1, #var_32_6 do
		local var_32_10 = arg_32_0._thumbnails[iter_32_1]

		if var_32_7 == P._playerFindLadder.SELECT_CARD_COUNT then
			var_32_10._isValid = false
		else
			var_32_10._isValid = var_32_6[iter_32_1]._isValid
		end

		if var_32_7 == 0 then
			var_32_10._thumbnail:setOpacity(0)
			var_32_10._thumbnail:runAction(lc.fadeTo(1, 255))

			local var_32_11 = Particle.create("chuxian")

			lc.addChildToCenter(var_32_10, var_32_11)
		else
			var_32_10._thumbnail:setOpacity(255)
		end
	end

	local var_32_12 = P._playerFindLadder.SELECT_CARD_COUNT - var_32_7
	local var_32_13 = string.format(lc.str(STR.SELECT_CARD), var_32_12, P._playerFindLadder.TOTAL_CARD_COUNT, P._playerFindLadder.SELECT_CARD_COUNT)

	arg_32_0._selectTitle:setString(var_32_13)
	arg_32_0:updateTroopList()
end

function var_0_0.updateTroopList(arg_33_0)
	local var_33_0 = arg_33_0:remainItemFromList()

	arg_33_0:releaseTroopCards()

	local var_33_1 = {}

	for iter_33_0, iter_33_1 in ipairs(P._playerFindLadder._troopCards) do
		local var_33_2

		for iter_33_2 = 1, #var_33_0 do
			if var_33_0[iter_33_2]._card._infoId == iter_33_1._infoId then
				var_33_2 = var_33_0[iter_33_2]

				break
			end
		end

		if not var_33_2 then
			var_33_2 = ccui.Layout:create()

			var_33_2:retain()

			local var_33_3 = var_0_1.createFromPool(iter_33_1._infoId, var_0_6)

			var_33_3._countArea:update(true, iter_33_1._num)
			var_33_2:setContentSize(var_33_3._thumbnail:getContentSize())
			var_33_2:setAnchorPoint(cc.p(0.5, 0.5))
			lc.addChildToPos(var_33_2, var_33_3, cc.p(lc.cw(var_33_2), lc.ch(var_33_2) + 10))
			var_33_3._thumbnail:setTouchEnabled(true)
			var_33_3._thumbnail:addTouchEventListener(function(arg_34_0, arg_34_1)
				arg_33_0:onTouchThumbnail(arg_34_0, arg_34_1, var_0_8.troop_card)
			end)

			var_33_2._item = var_33_3
		else
			var_33_2._item._countArea:update(true, iter_33_1._num)
		end

		table.insert(var_33_1, var_33_2)

		var_33_2._card = iter_33_1
	end

	table.sort(var_33_1, function(arg_35_0, arg_35_1)
		local var_35_0 = Data.getOriginId(arg_35_0._card._infoId)
		local var_35_1 = Data.getOriginId(arg_35_1._card._infoId)

		if var_35_0 < var_35_1 then
			return true
		elseif var_35_1 < var_35_0 then
			return false
		else
			return arg_35_0._card._infoId < arg_35_1._card._infoId
		end
	end)

	for iter_33_3, iter_33_4 in ipairs(var_33_1) do
		arg_33_0._troopList:pushBackCustomItem(iter_33_4)
	end
end

function var_0_0.releaseSelectCards(arg_36_0)
	if #arg_36_0._thumbnails > 0 then
		for iter_36_0, iter_36_1 in ipairs(arg_36_0._thumbnails) do
			var_0_1.releaseToPool(iter_36_1)
		end

		arg_36_0._thumbnails = {}
	end
end

function var_0_0.releaseTroopCards(arg_37_0)
	if arg_37_0._troopList then
		local var_37_0 = arg_37_0._troopList:getItems()

		for iter_37_0, iter_37_1 in ipairs(var_37_0) do
			var_0_1.releaseToPool(iter_37_1._item)
			iter_37_1:release()
		end

		arg_37_0._troopList:removeAllItems()
	end
end

function var_0_0.createTroopArea(arg_38_0, arg_38_1)
	local var_38_0 = lc.createSprite({
		_name = "img_troop_bg_1",
		_size = cc.size(lc.w(arg_38_0), 212),
		_crect = cc.rect(47, 0, 1, 212)
	})

	lc.addChildToPos(arg_38_1, var_38_0, cc.p(lc.cw(arg_38_1), lc.ch(var_38_0)))

	local var_38_1 = lc.List.createH(cc.size(lc.w(var_38_0) - 40, lc.h(var_38_0) - 6), 20, 10)

	lc.addChildToPos(var_38_0, var_38_1, cc.p(24, 0))

	arg_38_0._troopList = var_38_1

	local var_38_2 = P._playerFindLadder
	local var_38_3 = string.format(lc.str(STR.FIND_ARENA_TIPS), var_38_2.MAX_TROOP_COUNT, var_38_2.MAX_TROOP_COUNT, var_38_2.MAX_TROOP_COUNT, var_38_2.MAX_TROOP_COUNT)
	local var_38_4 = ClientView.createTTF(var_38_3, ClientView.FontSize.S1, lc.Color3B.black)
	local var_38_5 = lc.createSprite({
		_name = "img_tip_bg2",
		_size = cc.size(lc.w(var_38_4) + 40 + 40, 51),
		_crect = cc.rect(36, 25, 1, 1)
	})

	lc.addChildToPos(arg_38_1, var_38_5, cc.p(lc.cw(var_38_5) + 30, lc.top(var_38_0) + lc.ch(var_38_5) + 10))
	lc.addChildToPos(var_38_5, var_38_4, cc.p(lc.cw(var_38_4) + 40, lc.ch(var_38_5)))

	arg_38_0._troopDescLabel = var_38_4

	return var_38_0
end

function var_0_0.onTouchThumbnail(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if arg_39_2 == ccui.TouchEventType.began then
		arg_39_1:stopAllActions()
		arg_39_1:runAction(lc.scaleTo(0.1, 0.95))
		arg_39_0:onItemPress(arg_39_1, arg_39_3)
	elseif arg_39_2 == ccui.TouchEventType.ended or arg_39_2 == ccui.TouchEventType.canceled then
		arg_39_1:stopAllActions()
		arg_39_1:runAction(lc.scaleTo(0.08, 1))
		arg_39_0:onItemTap(arg_39_1, arg_39_3)
	elseif arg_39_2 == ccui.TouchEventType.moved then
		arg_39_0:onItemMove(arg_39_1, arg_39_3)
	end
end

function var_0_0.onItemPress(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_0._movingSprite then
		return
	end

	arg_40_0._touchStatus = var_0_0.TouchStatus.press
	arg_40_0._movingDir = var_0_7.none
end

function var_0_0.onItemMove(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_0._touchStatus == var_0_0.TouchStatus.tap then
		return
	end

	arg_41_0._touchStatus = var_0_0.TouchStatus.move

	if arg_41_0._movingSprite == nil then
		if arg_41_0._movingDir == var_0_7.none then
			local var_41_0 = math.abs(cc.pSub(arg_41_1:getTouchMovePosition(), arg_41_1:getTouchBeganPosition()).x)
			local var_41_1 = math.abs(cc.pSub(arg_41_1:getTouchMovePosition(), arg_41_1:getTouchBeganPosition()).y)

			if var_41_0 > 32 or var_41_1 > 32 then
				arg_41_0._movingDir = var_41_1 <= var_41_0 and var_0_7.horizontal or var_0_7.vertical
			end
		end

		if arg_41_2 == var_0_8.select_card and arg_41_0._movingDir == var_0_7.vertical and arg_41_1._item._isValid then
			arg_41_0:createMovingSpriteAndMaskLayer(arg_41_1)

			if arg_41_0._selectCardList then
				arg_41_0._selectCardList:setIsScrollEnabled(false)
			end
		end
	end

	if arg_41_0._movingSprite then
		arg_41_0._movingSprite:setPosition(cc.pAdd(arg_41_0._movingSprite._srcPos, cc.pSub(arg_41_1:getTouchMovePosition(), arg_41_1:getTouchBeganPosition())))
	end
end

function var_0_0.onItemTap(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0._touchStatus = var_0_0.TouchStatus.tap

	local var_42_0 = arg_42_1._infoId

	if arg_42_0._movingDir == var_0_7.none then
		if arg_42_2 == var_0_8.troop_card then
			local var_42_1 = {}
			local var_42_2 = 0
			local var_42_3 = arg_42_0._troopList:getItems()

			for iter_42_0 = 1, #var_42_3 do
				local var_42_4 = var_42_3[iter_42_0]._item._thumbnail

				var_42_1[#var_42_1 + 1] = {
					_infoId = var_42_4._infoId,
					_num = var_42_4._count
				}

				if arg_42_1 == var_42_4 then
					var_42_2 = iter_42_0
				end
			end

			local var_42_5 = var_0_2.create(var_42_0, 1, var_0_2.OperateType.na)

			var_42_5:setCardList(var_42_1, var_42_2, Str(STR.CUR_TROOP))
			var_42_5:setCardCount(arg_42_1._count)
			var_42_5:show()
		else
			var_0_2.create(var_42_0, 1, var_0_2.OperateType.na):show()
		end
	elseif arg_42_2 == var_0_8.select_card and arg_42_0._movingSprite then
		if P._playerFindLadder:getTroopCardCount() < P._playerFindLadder.MAX_TROOP_COUNT then
			if lc.y(arg_42_0._movingSprite) < arg_42_0._separatorPos then
				arg_42_0:onSelectCard(var_42_0)
			end
		else
			ToastManager.push(Str(STR.FULL_IN_TROOP))
		end
	end

	if arg_42_0._maskLayer then
		arg_42_0._maskLayer:removeFromParent(true)

		arg_42_0._maskLayer = nil
	end

	if arg_42_0._movingSprite then
		arg_42_0._movingSprite:removeFromParent()

		arg_42_0._movingSprite = nil
	end

	if arg_42_0._selectCardList then
		arg_42_0._selectCardList:setIsScrollEnabled(true)
	end
end

function var_0_0.createMovingSpriteAndMaskLayer(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0._troopList
	local var_43_1 = arg_43_1:convertToWorldSpace(cc.p(lc.w(arg_43_1) / 2, lc.h(arg_43_1) / 2))
	local var_43_2 = arg_43_0:convertToNodeSpace(var_43_1)
	local var_43_3 = arg_43_1._infoId
	local var_43_4 = var_0_1.create(var_43_3, var_0_5)

	arg_43_0:addChild(var_43_4, ClientData.ZOrder.ui + 2)

	arg_43_0._movingSprite = var_43_4
	arg_43_0._movingSprite._srcPos = var_43_2
	arg_43_0._movingSprite._abc = 1

	arg_43_0._movingSprite:setPosition(cc.pAdd(var_43_2, cc.pSub(arg_43_1:getTouchMovePosition(), arg_43_1:getTouchBeganPosition())))

	local var_43_5 = var_43_0:convertToWorldSpace(cc.p(0, 0))
	local var_43_6 = arg_43_0:convertToNodeSpace(var_43_5)

	var_43_6.x = 0

	local var_43_7 = cc.rect(var_43_6.x, var_43_6.y, lc.w(arg_43_0), lc.h(var_43_0))
	local var_43_8 = cc.LayerColor:create(cc.c4b(0, 0, 0, 192), lc.w(arg_43_0), lc.h(arg_43_0))

	arg_43_0._maskLayer = ClientView.createClipNode(var_43_8, var_43_7, true)

	arg_43_0:addChild(arg_43_0._maskLayer, ClientData.ZOrder.ui + 1)

	arg_43_0._separatorPos = var_43_6.y + var_43_7.height
end

function var_0_0.remainItemFromList(arg_44_0)
	local var_44_0 = {}
	local var_44_1 = arg_44_0._troopList:getItems()

	for iter_44_0 = #var_44_1, 1, -1 do
		local var_44_2 = var_44_1[iter_44_0]
		local var_44_3 = false

		for iter_44_1, iter_44_2 in ipairs(P._playerFindLadder._troopCards) do
			if var_44_2._card._infoId == iter_44_2._infoId then
				var_44_3 = true

				break
			end
		end

		if var_44_3 then
			table.insert(var_44_0, var_44_2)
			arg_44_0._troopList:removeItem(iter_44_0 - 1, false)
		end
	end

	return var_44_0
end

function var_0_0.playAction(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = cc.p(lc.cw(arg_45_0), lc.ch(arg_45_0._troopList))
	local var_45_1 = arg_45_0._troopList:getItems()

	for iter_45_0, iter_45_1 in ipairs(var_45_1) do
		if iter_45_1._card._infoId == arg_45_2 then
			var_45_0 = arg_45_0:convertToNodeSpace(iter_45_1:convertToWorldSpace(cc.p(lc.cw(iter_45_1), lc.ch(iter_45_1))))

			break
		end
	end

	local var_45_2 = cc.Node:create()

	lc.addChildToPos(arg_45_0, var_45_2, arg_45_1)

	local var_45_3 = Particle.create("sz1")

	lc.addChildToCenter(var_45_2, var_45_3)

	local var_45_4 = Particle.create("sz2")

	lc.addChildToCenter(var_45_2, var_45_4)
	var_45_2:setScale(2)
	var_45_2:runAction(lc.sequence(lc.moveTo(0.4, var_45_0), lc.call(function()
		var_45_3:setDuration(0.1)
		var_45_4:setDuration(0.1)
	end), lc.delay(1), lc.remove()))
end

function var_0_0.enterBattleField(arg_47_0)
	if arg_47_0._battleLayer ~= nil then
		return
	end

	arg_47_0:hideSelectCards()

	local var_47_0 = lc.createNode(arg_47_0:getContentSize())

	lc.addChildToCenter(arg_47_0, var_47_0, 100)

	arg_47_0._battleLayer = var_47_0

	local var_47_1 = arg_47_0:createTroopArea(var_47_0)

	arg_47_0:updateTroopList()

	local var_47_2 = lc.createSprite({
		_name = "img_troop_bg_3",
		_crect = cc.rect(20, 22, 1, 1),
		_size = cc.size(750, 360)
	})

	lc.addChildToPos(var_47_0, var_47_2, cc.p(lc.cw(var_47_0), lc.h(var_47_0) - lc.ch(var_47_2) - 20))

	local var_47_3 = lc.createSprite({
		_name = "img_divide_line_10",
		_crect = cc.rect(1, 14, 1, 1),
		_size = cc.size(3, lc.h(var_47_2) - 20)
	})

	lc.addChildToPos(var_47_2, var_47_3, cc.p(lc.cw(var_47_2), lc.ch(var_47_2)))

	local var_47_4 = ClientView.createTTF(lc.str(STR.BATTLE_WIN_COUNT), ClientView.FontSize.M2, ClientView.COLOR_GLOW)

	lc.addChildToPos(var_47_2, var_47_4, cc.p(lc.cw(var_47_2) - 190, lc.h(var_47_2) - 30))
	var_47_4:enableShadow(lc.Color4B.black)

	local var_47_5 = ClientView.createTTF(lc.str(STR.BATTLE_LOSE_COUNT), ClientView.FontSize.M2, ClientView.COLOR_GLOW_BLUE)

	lc.addChildToPos(var_47_2, var_47_5, cc.p(lc.cw(var_47_2) - 190, lc.ch(var_47_2) - 50))
	var_47_5:enableShadow(lc.Color4B.black)

	local var_47_6 = lc.createSprite("img_troop_win")

	lc.addChildToPos(var_47_2, var_47_6, cc.p(lc.x(var_47_4), lc.bottom(var_47_4) - lc.ch(var_47_6)))

	local var_47_7 = ClientView.createTTF("0", 60)

	lc.addChildToPos(var_47_6, var_47_7, cc.p(lc.cw(var_47_6), lc.ch(var_47_6)))
	var_47_7:enableShadow(lc.Color4B.black)

	arg_47_0._winCound = var_47_7
	arg_47_0._loseSprites = {}

	for iter_47_0 = 1, 3 do
		local var_47_8 = lc.createSprite("img_troop_bg_4")

		lc.addChildToPos(var_47_2, var_47_8, cc.p(lc.x(var_47_5) + 80 * (iter_47_0 - 2), lc.bottom(var_47_5) - lc.ch(var_47_8) - 10))

		local var_47_9 = lc.createSprite("img_troop_x")

		lc.addChildToPos(var_47_8, var_47_9, cc.p(lc.cw(var_47_8), lc.ch(var_47_8)))

		arg_47_0._loseSprites[iter_47_0] = var_47_9
	end

	local var_47_10 = ClientView.createTTF(lc.str(STR.BATTLE_WIN_REWARD), ClientView.FontSize.M2, ClientView.COLOR_GLOW)

	lc.addChildToPos(var_47_2, var_47_10, cc.p(lc.cw(var_47_2) + 190, lc.h(var_47_2) - 30))
	var_47_10:enableShadow(lc.Color4B.black)

	local var_47_11 = {
		"mubaoxiang",
		"tongbaoxiang",
		"yinbaoxiang",
		"jinbaoxiang",
		"heizuanbaoxiang"
	}
	local var_47_12 = Data._propsInfo[Data.PropsId.ladder_chest + P._playerFindLadder._winCount + 1]
	local var_47_13 = ClientView.createShaderButton(nil, function()
		require("LadderChestForm").create(var_47_12._id):show()
	end)

	var_47_13:setContentSize(cc.size(160, 130))
	lc.addChildToPos(var_47_2, var_47_13, cc.p(lc.x(var_47_10), lc.y(var_47_10) - 100))

	local var_47_14 = DragonBones.create(var_47_11[var_47_12._picId - 7820 + 1])

	lc.addChildToCenter(var_47_13, var_47_14)
	var_47_14:setScale(0.6)
	var_47_14:gotoAndPlay("effect4")

	local var_47_15 = string.format("%s: %d/%d", lc.str(STR.BATTLE_WIN_PROGRESS), 0, 0)
	local var_47_16 = ClientView.createTTF(var_47_15, ClientView.FontSize.M2, ClientView.COLOR_GLOW_BLUE)

	lc.addChildToPos(var_47_2, var_47_16, cc.p(lc.cw(var_47_2) + 190, lc.ch(var_47_2) - 50))
	var_47_16:enableShadow(lc.Color4B.black)

	arg_47_0._progressTip = var_47_16

	local var_47_17 = ClientView.createProgressBar(260)

	lc.addChildToPos(var_47_2, var_47_17, cc.p(lc.x(var_47_16), lc.bottom(var_47_16) - 40))

	arg_47_0._progressBar = var_47_17

	local var_47_18 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_49_0)
		arg_47_0:onFindingBattle()
	end, ClientView.CRECT_BUTTON, 180)

	lc.addChildToPos(var_47_2, var_47_18, cc.p(lc.cw(var_47_2), 0))
	var_47_18:addLabel(Str(STR.BATTLE))

	arg_47_0._btnFind = var_47_18

	local var_47_19 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("LogForm").create(Battle_pb.PB_BATTLE_WORLD_LADDER_EX):show()
	end, ClientView.CRECT_BUTTON_S, 100)

	lc.addChildToPos(var_47_0, var_47_19, cc.p(lc.w(var_47_0) - lc.cw(var_47_19) - 20 - ClientView.SCR_EDGE, lc.top(var_47_1) + lc.ch(var_47_19)))
	var_47_19:addLabel(Str(STR.LOG))

	local var_47_20 = ClientView.createScale9ShaderButton("img_btn_3_s", function(arg_51_0)
		require("Dialog").showDialog(Str(STR.CONFIRM_TO_GIVEUP), function()
			arg_47_0:onFinishBattle()
		end)
	end, ClientView.CRECT_BUTTON_S, 100)

	lc.addChildToPos(var_47_0, var_47_20, cc.p(lc.left(var_47_19) - lc.cw(var_47_20) - 20, lc.y(var_47_19)))
	var_47_20:addLabel(Str(STR.GIVEUP))

	arg_47_0._btnGiveup = var_47_20

	local var_47_21 = ClientView.createScale9ShaderButton("img_btn_3", function(arg_53_0)
		arg_47_0:onFinishBattle()
	end, ClientView.CRECT_BUTTON, 180)

	lc.addChildToPos(var_47_2, var_47_21, cc.p(lc.cw(var_47_2), 0))
	var_47_21:addLabel(Str(STR.DONE))

	arg_47_0._btnFinish = var_47_21

	arg_47_0:updateBattleField()

	local var_47_22 = 0

	if P._playerFindLadder._isLoseSubed then
		arg_47_0:runAction(lc.sequence(var_47_22, function()
			P._playerFindLadder._isLoseSubed = false

			arg_47_0:runAction(lc.sequence(0.2, function()
				local var_55_0 = lc.createSprite("arena_spr_2")
				local var_55_1 = lc.createSprite("arena_light_2")

				var_55_1:setScale(5)
				var_55_1:runAction(lc.rep(lc.sequence(lc.scaleTo(0.5, 4), lc.scaleTo(0.5, 6))))
				lc.addChildToCenter(var_55_0, var_55_1, -1)
				var_55_0:setScale(0)
				var_55_0:runAction(lc.sequence(lc.scaleTo(0.3, 1), 1, lc.scaleTo(0.3, 0), lc.remove()))
				lc.addChildToCenter(var_47_0, var_55_0, 100)
			end))
			arg_47_0._loseSprites[P._playerFindLadder._loseCount + 1]:setVisible(true)
			arg_47_0._loseSprites[P._playerFindLadder._loseCount + 1]:setScale(0)
			arg_47_0._loseSprites[P._playerFindLadder._loseCount + 1]:runAction(lc.sequence(lc.scaleTo(0.3, 1), 1.2, lc.scaleTo(0.3, 0), lc.hide()))
		end))

		local var_47_23 = var_47_22 + 1.8

		lc._runningScene:setSwallowAllTouches(true, var_47_23 + 0.1)
	end
end

function var_0_0.updateBattleField(arg_56_0)
	arg_56_0._winCound:setString(P._playerFindLadder._winCount)
	arg_56_0._progressBar._bar:setPercent(P._playerFindLadder._winCount / P._playerFindLadder.MAX_BATTLE_COUNT * 100)

	local var_56_0 = string.format("%s: %d/%d", lc.str(STR.BATTLE_WIN_PROGRESS), P._playerFindLadder._winCount, P._playerFindLadder.MAX_BATTLE_COUNT)

	arg_56_0._progressTip:setString(var_56_0)

	local var_56_1, var_56_2, var_56_3, var_56_4, var_56_5 = P._playerFindLadder:getTroopCardCount()
	local var_56_6 = string.format(lc.str(STR.FIND_ARENA_TIPS), var_56_1, P._playerFindLadder.MAX_TROOP_COUNT, var_56_2 + var_56_3, var_56_4 + var_56_5)

	arg_56_0._troopDescLabel:setString(var_56_6)

	for iter_56_0 = 1, #arg_56_0._loseSprites do
		arg_56_0._loseSprites[iter_56_0]:setVisible(iter_56_0 <= P._playerFindLadder._loseCount)
	end

	local var_56_7 = P._playerFindLadder._winCount >= P._playerFindLadder.MAX_BATTLE_COUNT or P._playerFindLadder._loseCount >= P._playerFindLadder.MAX_LOSE_COUNT

	arg_56_0._btnFind:setVisible(not var_56_7)
	arg_56_0._btnGiveup:setVisible(not var_56_7)
	arg_56_0._btnFinish:setVisible(var_56_7)
end

function var_0_0.hideBattleField(arg_57_0)
	if not arg_57_0._battleLayer then
		return
	end

	arg_57_0:releaseTroopCards()
	arg_57_0._battleLayer:removeFromParent()

	arg_57_0._battleLayer = nil
	arg_57_0._troopList = nil
end

function var_0_0.onReselectCharacter(arg_58_0)
	if P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.arena_privilege_1) > 0 or P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.arena_privilege_2) > 0 then
		if P._playerFindLadder:couldRollCharacter() then
			P._playerFindLadder._rollTimes = P._playerFindLadder._rollTimes + 1

			ClientView.getActiveIndicator():show(Str(STR.WAITING))
			ClientData.sendLadderReselectCharacter()

			return
		else
			return ToastManager.push(Str(STR.ARENA_PRIVILEGE_UPGRADE_TIP))
		end
	end

	require("ArenaPrivilegePanel").create():show()
end

return var_0_0
