local var_0_0 = class("FindSurvivalExArea", lc.ExtendCCNode)
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

	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.survival_ex_game_over, function(arg_4_0)
		ClientView.getActiveIndicator():hide()
		arg_3_0:enterLayer()
	end))
	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.survival_privilege_dirty, function(arg_5_0)
		ClientView.getActiveIndicator():hide()
		arg_3_0:enterLayer()
	end))
	ClientData.addMsgListener(arg_3_0, function(arg_6_0)
		return arg_3_0:onMsg(arg_6_0)
	end, 0)
	arg_3_0:enterLayer()
end

function var_0_0.enterLayer(arg_7_0)
	arg_7_0:hideDoor()
	arg_7_0:hideSelectCards()
	arg_7_0:hideSelectCharacter()
	arg_7_0:hideBattleField()

	if not P._playerFindSurvivalEx._hasTicket then
		arg_7_0:enterDoor()
	elseif P._playerFindSurvivalEx._characterId == 0 then
		arg_7_0:enterSelectCharacter()
	elseif P._playerFindSurvivalEx._step <= P._playerFindSurvivalEx.MAX_TROOP_COUNT then
		arg_7_0:enterSelectCards()
	else
		arg_7_0:enterBattleField()
	end
end

function var_0_0.onExit(arg_8_0)
	arg_8_0:releaseSelectCards()
	arg_8_0:releaseTroopCards()

	for iter_8_0 = 1, #arg_8_0._listeners do
		lc.Dispatcher:removeEventListener(arg_8_0._listeners[iter_8_0])
	end

	ClientData.removeMsgListener(arg_8_0)
end

function var_0_0.onCleanup(arg_9_0)
	arg_9_0:releaseSelectCards()
	arg_9_0:releaseTroopCards()
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/arena_door.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/img_survive_start_bg.jpg"))
end

function var_0_0.onMsg(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.type

	if var_10_0 == SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX then
		ClientView.getActiveIndicator():hide()
		arg_10_0:enterSelectCharacter()

		return true
	elseif var_10_0 == SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX or var_10_0 == SglMsgType_pb.PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX then
		ClientView.getActiveIndicator():hide()
		arg_10_0:enterLayer()

		return true
	elseif var_10_0 == SglMsgType_pb.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL_EX then
		P._playerFindSurvivalEx._step = arg_10_1.Extensions[World_pb.SglWorldMsg.world_select_card_resp]

		if P._playerFindSurvivalEx._step % P._playerFindSurvivalEx.SELECT_CARD_COUNT == 1 then
			if P._playerFindSurvivalEx._step > P._playerFindSurvivalEx.MAX_TROOP_COUNT then
				P._playerFindSurvivalEx:initExtraTroop()
				arg_10_0:enterBattleField()
			elseif arg_10_0._cardsLayer then
				arg_10_0:updateSelectCards()
			end
		end

		return true
	end

	return false
end

function var_0_0.init(arg_11_0)
	arg_11_0._thumbnails = {}
end

function var_0_0.onSelectCard(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_2 = arg_12_2 or P._playerFindSurvivalEx:getSelectCardIndex(arg_12_1)

	P._playerFindSurvivalEx:addCardToTroop(arg_12_1, arg_12_2)
	ClientData.sendSurvivalExSelectCard(arg_12_2)

	if arg_12_0._movingSprite then
		arg_12_3 = arg_12_0._movingSprite._srcPos
	end

	arg_12_0:updateSelectCards()
	arg_12_0:runAction(lc.sequence(0, function()
		arg_12_0:playAction(arg_12_3, arg_12_1)
	end))
end

function var_0_0.onSelectCharacter(arg_14_0)
	P._playerFindSurvivalEx._characterId = arg_14_0._characterId
	P._playerFindSurvivalEx._step = 1

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendSurvivalExSelectCharacter(arg_14_0._characterId)
end

function var_0_0.onBuyTicket(arg_15_0, arg_15_1)
	if arg_15_1 == Data.ResType.gold then
		if not ClientView.checkGold(Data._globalInfo._SurvivalExCostGold) then
			return
		end

		P:changeResource(Data.ResType.gold, -Data._globalInfo._SurvivalExCostGold)
	elseif arg_15_1 == Data.ResType.ingot then
		if not ClientView.checkIngot(Data._globalInfo._SurvivalExCostIngot) then
			return
		end

		P:changeResource(Data.ResType.ingot, -Data._globalInfo._SurvivalExCostIngot)
	else
		if not P._propBag:hasProps(Data.PropsId.survival_ex_ticket, 1) then
			return ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(Data._propsInfo[Data.PropsId.survival_ex_ticket]._nameSid)))
		end

		P._propBag:changeProps(Data.PropsId.survival_ex_ticket, -1)
	end

	P._playerFindSurvivalEx._hasTicket = true

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendSurvivalExBuyTicket(arg_15_1)
end

function var_0_0.onFindingHall(arg_16_0)
	if ClientView._findMatchPanel then
		return
	end

	if P._playerFindSurvivalEx:getIsValidTime() == 0 then
		require("FindMatchPanel").create(Data.FindMatchType.survival_ex):show()
	else
		local var_16_0 = P._playerFindSurvivalEx:getTimeTip()

		ToastManager.push(var_16_0)
	end
end

function var_0_0.onFinishBattle(arg_17_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendSurvivalExQuit()
end

function var_0_0.enterDoor(arg_18_0)
	if arg_18_0._doorLayer ~= nil then
		return
	end

	local var_18_0 = lc.createNode(arg_18_0:getContentSize())

	lc.addChildToCenter(arg_18_0, var_18_0, 1)

	arg_18_0._doorLayer = var_18_0

	local var_18_1 = cc.Sprite:create("res/jpg/survival_door.jpg")

	lc.addChildToCenter(var_18_0, var_18_1)

	local var_18_2 = Particle.create("jdqs")

	lc.addChildToPos(var_18_1, var_18_2, cc.p(lc.cw(var_18_1), lc.ch(var_18_1) - 30))

	local var_18_3 = lc.createNode()

	lc.addChildToPos(var_18_0, var_18_3, cc.p(0, 0))

	var_18_0._tipNode = var_18_3

	local var_18_4 = lc.createSprite({
		_name = "img_com_bg_41",
		_size = cc.size(672, 54),
		_crect = cc.rect(29, 26, 1, 1)
	})

	lc.addChildToPos(var_18_3, var_18_4, cc.p(lc.cw(var_18_0), 180))

	local var_18_5 = ClientView.createTTF(P._playerFindSurvivalEx:getTimeTip(), ClientView.FontSize.M2)

	lc.addChildToCenter(var_18_4, var_18_5)

	local function var_18_6(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_20_0)
			arg_18_0:onBuyTicket(arg_19_2)
		end, ClientView.CRECT_BUTTON, 180)
		local var_19_1 = lc.createSprite(arg_19_0)
		local var_19_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_19_1)

		lc.addChildToPos(var_19_0, var_19_1, cc.p(lc.cw(var_19_0) - (lc.w(var_19_2) + 12) / 2, lc.ch(var_19_0)))
		lc.addChildToPos(var_19_0, var_19_2, cc.p(lc.right(var_19_1) + lc.cw(var_19_2) + 12, lc.ch(var_19_0)))

		return var_19_0
	end

	if P._propBag:hasProps(Data.PropsId.survival_ex_ticket, 1) then
		local var_18_7 = var_18_6("img_icon_props_s7132", 1, Data.PropsId.survival_ex_ticket)

		lc.addChildToPos(var_18_3, var_18_7, cc.p(lc.cw(var_18_0), 80))
	else
		local var_18_8 = var_18_6("img_icon_res1_s", Data._globalInfo._SurvivalExCostGold, Data.ResType.gold)

		lc.addChildToPos(var_18_3, var_18_8, cc.p(lc.cw(var_18_0), 80))
	end

	local var_18_9 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("LogForm").create(Battle_pb.PB_BATTLE_SURVIVAL_EX):show()
	end, ClientView.CRECT_BUTTON_S, 100)

	lc.addChildToPos(var_18_0, var_18_9, cc.p(lc.w(var_18_0) - lc.cw(var_18_9) - 20, 80))
	var_18_9:addLabel(Str(STR.LOG))
	var_18_0:runAction(lc.rep(lc.sequence(function()
		local var_22_0 = P._playerFindSurvivalEx:getPrivilegeTimeStr()
		local var_22_1 = var_18_0._tip

		if var_22_1 then
			var_22_1:removeFromParent()
		end

		if var_22_0 then
			local var_22_2 = ClientView.createBoldRichText(var_22_0, {
				_boldClr = ClientView.COLOR_TEXT_INGOT
			})

			lc.addChildToPos(var_18_0, var_22_2, cc.p(lc.cw(arg_18_0), lc.h(var_18_0) - 30))

			var_18_0._tip = var_22_2
		end
	end, 1)))
	ClientView.getResourceUI():setMode(Data.PropsId.survival_ex_ticket)
end

function var_0_0.hideDoor(arg_23_0)
	if not arg_23_0._doorLayer then
		return
	end

	local var_23_0 = arg_23_0._doorLayer

	var_23_0._tipNode:setVisible(false)
	var_23_0:removeFromParent()

	arg_23_0._doorLayer = nil
	arg_23_0._doors = nil

	ClientView.getResourceUI():setMode(Data.PropsId.survival_ex_ticket)
end

function var_0_0.enterSelectCharacter(arg_24_0)
	if arg_24_0._characterLayer ~= nil then
		return
	end

	arg_24_0:hideDoor()

	local var_24_0 = lc.createNode(arg_24_0:getContentSize())

	lc.addChildToCenter(arg_24_0, var_24_0)

	arg_24_0._characterLayer = var_24_0

	local var_24_1 = lc.createSprite({
		_name = "img_title_bg",
		_size = cc.size(480, 52),
		_crect = cc.rect(115, 25, 1, 1)
	})

	lc.addChildToPos(var_24_0, var_24_1, cc.p(lc.cw(var_24_0), lc.h(var_24_0) - 40))

	local var_24_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.PVP_SELECT_YOUR_CHARACTER))

	lc.addChildToCenter(var_24_1, var_24_2)

	local var_24_3 = 980
	local var_24_4 = lc.List.createH(cc.size(lc.w(var_24_0), var_0_4), math.max(0, (lc.w(var_24_0) - var_24_3) / 2))

	var_24_4:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_24_0, var_24_4, cc.p(lc.cw(var_24_0), lc.ch(var_24_0) + 40))

	arg_24_0._characterList = var_24_4

	for iter_24_0 = 1, #P._playerFindSurvivalEx._characters do
		local var_24_5 = P._playerFindSurvivalEx._characters[iter_24_0]
		local var_24_6 = arg_24_0:createCharacterItem(var_24_5)

		var_24_4:pushBackCustomItem(var_24_6)
	end

	local var_24_7 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_25_0)
		arg_24_0:onSelectCharacter()
	end, ClientView.CRECT_BUTTON, 250)

	lc.addChildToPos(var_24_0, var_24_7, cc.p(lc.cw(var_24_0) - 200, 95))
	var_24_7:addLabel(Str(STR.OK))

	local var_24_8 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_26_0)
		arg_24_0:onReselectCharacter()
	end, ClientView.CRECT_BUTTON, 250)

	lc.addChildToPos(var_24_0, var_24_8, cc.p(lc.cw(var_24_0) + 200, 95))

	local var_24_9 = lc.createSprite({
		_name = "img_title_bg",
		_size = cc.size(480, 52),
		_crect = cc.rect(115, 25, 1, 1)
	})

	lc.addChildToPos(var_24_0, var_24_9, cc.p(lc.cw(var_24_0), 20))

	local var_24_10

	if P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.survival_privilege_2) > 0 then
		var_24_10 = string.format(Str(STR.SURVIVAL_PRIVILEGE_REMAIN_2), P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.survival_privilege_2))

		var_24_8:addLabel(Str(STR.RESELECT) .. string.format("(%s)", string.format(Str(STR.REMAIN_BUY_TIMES), P._playerFindSurvivalEx:getRemainRollTimes())))
	elseif P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.survival_privilege_1) > 0 then
		var_24_10 = string.format(Str(STR.SURVIVAL_PRIVILEGE_REMAIN), P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.survival_privilege_1))

		var_24_8:addLabel(Str(STR.RESELECT) .. string.format("(%s)", string.format(Str(STR.REMAIN_BUY_TIMES), P._playerFindSurvivalEx:getRemainRollTimes())))
	else
		var_24_8:addLabel(Str(STR.RESELECT))
	end

	if var_24_10 then
		local var_24_11 = ClientView.createTTF(var_24_10, ClientView.FontSize.S1)

		lc.addChildToCenter(var_24_9, var_24_11)
	else
		var_24_9:setVisible(false)
	end

	arg_24_0._characterId = P._playerFindSurvivalEx._characterId

	if arg_24_0._characterId == 0 then
		arg_24_0._characterId = P._playerFindSurvivalEx._characters[1]
	end

	arg_24_0:selectCharacter(arg_24_0._characterId)
	ClientView.getResourceUI():setMode(Data.ResType.gold)
end

function var_0_0.hideSelectCharacter(arg_27_0)
	if not arg_27_0._characterLayer then
		return
	end

	arg_27_0._characterLayer:removeFromParent()

	arg_27_0._characterLayer = nil
end

function var_0_0.createCharacterItem(arg_28_0, arg_28_1)
	local var_28_0 = Data._characterInfo[arg_28_1]
	local var_28_1 = ClientView.createShaderButton(nil, function(arg_29_0)
		arg_28_0:selectCharacter(var_28_0._id)
	end)

	var_28_1._id = var_28_0._id

	var_28_1:setContentSize(var_0_3, var_0_4)

	local var_28_2 = lc.createSprite({
		_name = "img_com_bg_43",
		_size = cc.size(var_0_3, ClientView.CRECT_COM_BG43.height),
		_crect = ClientView.CRECT_COM_BG43
	})

	lc.addChildToPos(var_28_1, var_28_2, cc.p(lc.cw(var_28_1), lc.ch(var_28_2)), 1)

	var_28_1._nameBg = var_28_2

	local var_28_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(var_28_0._nameSid))

	lc.addChildToCenter(var_28_2, var_28_3)

	local var_28_4 = DragonBones.create(Data.getCharacterBoneName(var_28_0._id))

	var_28_4:gotoAndPlay(Data.getCharacterAniName(var_28_0._id))
	var_28_4:setScale(0.5)
	lc.addChildToPos(var_28_1, var_28_4, cc.p(lc.x(var_28_2), lc.top(var_28_2) + 120))
	lc.offset(var_28_4, 0, Data.getCharacterOffsetY(var_28_0._id, true) * 0.5)

	local var_28_5 = lc.createSprite("img_light")

	var_28_5:setScale(5.5)
	lc.addChildToPos(var_28_1, var_28_5, cc.p(lc.x(var_28_2), lc.top(var_28_2) + 180), -1)

	var_28_1._light = var_28_5

	local var_28_6 = Particle.create("xuanzhong")

	var_28_6:setPositionType(cc.POSITION_TYPE_GROUPED)
	lc.addChildToPos(var_28_1, var_28_6, cc.p(lc.x(var_28_2), lc.top(var_28_2) + 20), -1)

	var_28_1._particle = var_28_6

	if var_28_0._id == 2 then
		lc.offset(var_28_4, 10, 0)
	end

	if var_28_0._id == 14 then
		lc.offset(var_28_4, 0, 60)
	end

	return var_28_1
end

function var_0_0.selectCharacter(arg_30_0, arg_30_1)
	arg_30_0._characterId = arg_30_1

	local var_30_0 = arg_30_0._characterList:getItems()

	for iter_30_0 = 1, #var_30_0 do
		local var_30_1 = var_30_0[iter_30_0]

		var_30_1._nameBg:setSpriteFrame(lc.FrameCache:getSpriteFrame(var_30_1._id == arg_30_1 and "img_com_bg_44" or "img_com_bg_43"), ClientView.CRECT_COM_BG43)
		var_30_1._nameBg:setContentSize(var_0_3, ClientView.CRECT_COM_BG43.height)
		var_30_1._light:setVisible(var_30_1._id == arg_30_1)
		var_30_1._particle:setVisible(var_30_1._id == arg_30_1)
	end
end

function var_0_0.enterSelectCards(arg_31_0)
	if arg_31_0._cardsLayer ~= nil then
		return
	end

	arg_31_0:hideSelectCharacter()

	local var_31_0 = lc.createNode(arg_31_0:getContentSize())

	lc.addChildToCenter(arg_31_0, var_31_0)

	arg_31_0._cardsLayer = var_31_0

	local var_31_1 = arg_31_0:createTroopArea(var_31_0)
	local var_31_2 = lc.createSprite({
		_name = "img_title_bg",
		_size = cc.size(480, 52),
		_crect = cc.rect(115, 25, 1, 1)
	})

	lc.addChildToPos(var_31_0, var_31_2, cc.p(lc.cw(var_31_0), lc.h(var_31_0) - 40))

	local var_31_3 = string.format(lc.str(STR.SELECT_CARD), 0, P._playerFindSurvivalEx.TOTAL_CARD_COUNT, P._playerFindSurvivalEx.SELECT_CARD_COUNT)
	local var_31_4 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_31_3)

	lc.addChildToCenter(var_31_2, var_31_4)

	arg_31_0._selectTitle = var_31_4

	local var_31_5 = 10
	local var_31_6 = P._playerFindSurvivalEx.TOTAL_CARD_COUNT * (ClientView.CARD_SIZE.width * var_0_5 + var_31_5) - var_31_5
	local var_31_7 = lc.List.createH(cc.size(lc.w(arg_31_0), 300), math.max(20, (lc.w(var_31_0) - var_31_6) / 2), var_31_5)

	lc.addChildToPos(var_31_1, var_31_7, cc.p(0, 300))

	arg_31_0._selectCardList = var_31_7

	for iter_31_0 = 1, P._playerFindSurvivalEx.TOTAL_CARD_COUNT do
		local var_31_8 = 10001
		local var_31_9 = ccui.Layout:create()

		var_31_9:setContentSize(cc.size(190, 270))
		var_31_9:setAnchorPoint(0.5, 0.5)
		var_31_7:pushBackCustomItem(var_31_9)

		local var_31_10 = var_0_1.createFromPool(var_31_8, var_0_5)

		var_31_10._thumbnail:setTouchEnabled(true)
		var_31_10._thumbnail:addTouchEventListener(function(arg_32_0, arg_32_1)
			arg_31_0:onTouchThumbnail(arg_32_0, arg_32_1, var_0_8.select_card)
		end)
		lc.addChildToCenter(var_31_9, var_31_10)
		table.insert(arg_31_0._thumbnails, var_31_10)
	end

	if ClientData._cfg and ClientData._cfg.testSurvival == 1 then
		for iter_31_1 = math.floor((P._playerFindSurvivalEx._step - 1) / P._playerFindSurvivalEx.SELECT_CARD_COUNT) + 1, 20 do
			local var_31_11 = P._playerFindSurvivalEx:getSelectCards()
			local var_31_12 = ""
			local var_31_13 = 0

			for iter_31_2, iter_31_3 in ipairs(var_31_11) do
				if not iter_31_3._isValid then
					var_31_13 = var_31_13 + 1
				end

				var_31_12 = var_31_12 .. "-" .. iter_31_3._infoId
			end

			print("++++++++++++++++++++++++cards", var_31_12)

			for iter_31_4 = var_31_13 + 1, 2 do
				for iter_31_5, iter_31_6 in ipairs(var_31_11) do
					if iter_31_6._isValid then
						print("++++++++++++++++++++++++select", iter_31_6._infoId, P._playerFindSurvivalEx:getSelectCardIndex(iter_31_6._infoId))
						arg_31_0:onSelectCard(iter_31_6._infoId)

						P._playerFindSurvivalEx._step = P._playerFindSurvivalEx._step + 1
						iter_31_6._isValid = false

						break
					end
				end
			end
		end

		arg_31_0:enterBattleField()

		local var_31_14 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_33_0)
			local var_33_0 = P._playerFindSurvivalEx:getSelectCards()

			for iter_33_0, iter_33_1 in ipairs(var_33_0) do
				if iter_33_1._isValid then
					local var_33_1 = lc.convertPos(cc.p(0, 0), arg_31_0._thumbnails[iter_33_0])

					return arg_31_0:onSelectCard(iter_33_1._infoId, nil, var_33_1)
				end
			end
		end, ClientView.CRECT_BUTTON, 150)

		var_31_14:addLabel(Str(STR.RANDOM))
		lc.addChildToPos(var_31_1, var_31_14, cc.p(lc.w(var_31_1) - lc.cw(var_31_14) - 10, lc.h(var_31_1) - lc.ch(var_31_14) + 80))

		return
	end

	arg_31_0:updateSelectCards()
	ClientView.getResourceUI():setMode(Data.ResType.gold)
end

function var_0_0.hideSelectCards(arg_34_0)
	if not arg_34_0._cardsLayer then
		return
	end

	arg_34_0:releaseSelectCards()
	arg_34_0:releaseTroopCards()
	arg_34_0._cardsLayer:removeFromParent()

	arg_34_0._cardsLayer = nil
	arg_34_0._troopList = nil
	arg_34_0._selectCardList = nil
end

function var_0_0.updateSelectCards(arg_35_0)
	local var_35_0 = P._playerFindSurvivalEx:getSelectCards()
	local var_35_1 = 0

	for iter_35_0 = 1, #var_35_0 do
		local var_35_2 = var_35_0[iter_35_0]
		local var_35_3 = arg_35_0._thumbnails[iter_35_0]

		var_35_3._thumbnail:updateComponent(var_35_2._infoId)
		var_35_3:setVisible(true)

		if not var_35_2._isValid then
			var_35_3._thumbnail._frame._frame:setEffect(ClientView.SHADER_DISABLE)
			var_35_3._thumbnail._frame:setEffect(ClientView.SHADER_DISABLE)

			var_35_1 = var_35_1 + 1
		else
			var_35_3._thumbnail._frame:setEffect(nil)
		end
	end

	for iter_35_1 = 1, #var_35_0 do
		local var_35_4 = arg_35_0._thumbnails[iter_35_1]

		if var_35_1 == P._playerFindSurvivalEx.SELECT_CARD_COUNT then
			var_35_4._isValid = false
		else
			var_35_4._isValid = var_35_0[iter_35_1]._isValid
		end

		if var_35_1 == 0 then
			var_35_4._thumbnail:setOpacity(0)
			var_35_4._thumbnail:runAction(lc.fadeTo(1, 255))

			local var_35_5 = Particle.create("chuxian")

			lc.addChildToCenter(var_35_4, var_35_5)
		else
			var_35_4._thumbnail:setOpacity(255)
		end
	end

	local var_35_6 = P._playerFindSurvivalEx.SELECT_CARD_COUNT - var_35_1
	local var_35_7 = string.format(lc.str(STR.SELECT_CARD), var_35_6, P._playerFindSurvivalEx.TOTAL_CARD_COUNT, P._playerFindSurvivalEx.SELECT_CARD_COUNT)

	arg_35_0._selectTitle:setString(var_35_7)
	arg_35_0:updateTroopList()
end

function var_0_0.updateTroopList(arg_36_0)
	local var_36_0 = arg_36_0:remainItemFromList()

	arg_36_0:releaseTroopCards()

	local var_36_1 = {}

	for iter_36_0, iter_36_1 in ipairs(P._playerFindSurvivalEx:getTroopCards()) do
		local var_36_2

		for iter_36_2 = 1, #var_36_0 do
			if var_36_0[iter_36_2]._card._infoId == iter_36_1._infoId then
				var_36_2 = var_36_0[iter_36_2]

				break
			end
		end

		if not var_36_2 then
			var_36_2 = ccui.Layout:create()

			var_36_2:retain()

			local var_36_3 = var_0_1.createFromPool(iter_36_1._infoId, var_0_6)

			var_36_3._countArea:update(true, iter_36_1._num)
			var_36_2:setContentSize(var_36_3._thumbnail:getContentSize())
			var_36_2:setAnchorPoint(cc.p(0.5, 0.5))
			lc.addChildToPos(var_36_2, var_36_3, cc.p(lc.cw(var_36_2), lc.ch(var_36_2) + 10))
			var_36_3._thumbnail:setTouchEnabled(true)
			var_36_3._thumbnail:addTouchEventListener(function(arg_37_0, arg_37_1)
				arg_36_0:onTouchThumbnail(arg_37_0, arg_37_1, var_0_8.troop_card)
			end)

			var_36_2._item = var_36_3
		else
			var_36_2._item._countArea:update(true, iter_36_1._num)
		end

		table.insert(var_36_1, var_36_2)

		var_36_2._card = iter_36_1
	end

	table.sort(var_36_1, function(arg_38_0, arg_38_1)
		local var_38_0 = Data.getOriginId(arg_38_0._card._infoId)
		local var_38_1 = Data.getOriginId(arg_38_1._card._infoId)

		if var_38_0 < var_38_1 then
			return true
		elseif var_38_1 < var_38_0 then
			return false
		else
			return arg_38_0._card._infoId < arg_38_1._card._infoId
		end
	end)

	for iter_36_3, iter_36_4 in ipairs(var_36_1) do
		arg_36_0._troopList:pushBackCustomItem(iter_36_4)
	end

	local var_36_4, var_36_5, var_36_6, var_36_7, var_36_8 = P._playerFindSurvivalEx:getTroopCardCount()
	local var_36_9 = string.format(lc.str(STR.FIND_SURVIVAL_EX_TIPS), var_36_4, P._playerFindSurvivalEx.MAX_TROOP_COUNT, var_36_5 + var_36_6, var_36_7 + var_36_8)

	arg_36_0._troopDescLabel:setString(var_36_9)
end

function var_0_0.releaseSelectCards(arg_39_0)
	if #arg_39_0._thumbnails > 0 then
		for iter_39_0, iter_39_1 in ipairs(arg_39_0._thumbnails) do
			var_0_1.releaseToPool(iter_39_1)
		end

		arg_39_0._thumbnails = {}
	end
end

function var_0_0.releaseTroopCards(arg_40_0)
	if arg_40_0._troopList then
		local var_40_0 = arg_40_0._troopList:getItems()

		for iter_40_0, iter_40_1 in ipairs(var_40_0) do
			var_0_1.releaseToPool(iter_40_1._item)
			iter_40_1:release()
		end

		arg_40_0._troopList:removeAllItems()
	end
end

function var_0_0.createTroopArea(arg_41_0, arg_41_1)
	local var_41_0 = lc.createSprite({
		_name = "img_troop_bg_1",
		_size = cc.size(lc.w(arg_41_0), 212),
		_crect = cc.rect(47, 0, 1, 212)
	})

	lc.addChildToPos(arg_41_1, var_41_0, cc.p(lc.cw(arg_41_1), lc.ch(var_41_0)))

	local var_41_1 = lc.createSprite("img_troop_name_bg")

	lc.addChildToPos(var_41_0, var_41_1, cc.p(lc.cw(var_41_1) + 25, lc.h(var_41_0) + lc.ch(var_41_1)))

	local var_41_2 = ClientView.createTTF(Str(STR.PUBG), ClientView.FontSize.M2, ClientView.COLOR_TEXT_BLUE)

	var_41_2:enableShadow()
	lc.addChildToPos(var_41_1, var_41_2, cc.p(lc.cw(var_41_2) + 10, lc.ch(var_41_1)))

	local var_41_3 = lc.List.createH(cc.size(lc.w(var_41_0) - 40, lc.h(var_41_0) - 6), 20, 10)

	lc.addChildToPos(var_41_0, var_41_3, cc.p(24, 0))

	arg_41_0._troopList = var_41_3

	local var_41_4 = P._playerFindSurvivalEx
	local var_41_5 = string.format(lc.str(STR.FIND_SURVIVAL_EX_TIPS), var_41_4.MAX_TROOP_COUNT, var_41_4.MAX_TROOP_COUNT, var_41_4.MAX_TROOP_COUNT, var_41_4.MAX_TROOP_COUNT)
	local var_41_6 = ClientView.createTTF(var_41_5, ClientView.FontSize.S1, lc.Color3B.black)
	local var_41_7 = lc.createSprite({
		_name = "img_tip_bg2",
		_size = cc.size(lc.w(var_41_6) + 40 + 40, 51),
		_crect = cc.rect(36, 25, 1, 1)
	})

	lc.addChildToPos(var_41_0, var_41_7, cc.p(lc.right(var_41_1) + 230, lc.h(var_41_0) + lc.ch(var_41_7) + 10))
	lc.addChildToPos(var_41_7, var_41_6, cc.p(lc.cw(var_41_6) + 40, lc.ch(var_41_7)))

	arg_41_0._troopDescLabel = var_41_6

	return var_41_0
end

function var_0_0.onTouchThumbnail(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	if arg_42_2 == ccui.TouchEventType.began then
		arg_42_1:stopAllActions()
		arg_42_1:runAction(lc.scaleTo(0.1, 0.95))
		arg_42_0:onItemPress(arg_42_1, arg_42_3)
	elseif arg_42_2 == ccui.TouchEventType.ended or arg_42_2 == ccui.TouchEventType.canceled then
		arg_42_1:stopAllActions()
		arg_42_1:runAction(lc.scaleTo(0.08, 1))
		arg_42_0:onItemTap(arg_42_1, arg_42_3)
	elseif arg_42_2 == ccui.TouchEventType.moved then
		arg_42_0:onItemMove(arg_42_1, arg_42_3)
	end
end

function var_0_0.onItemPress(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_0._movingSprite then
		return
	end

	arg_43_0._touchStatus = var_0_0.TouchStatus.press
	arg_43_0._movingDir = var_0_7.none
end

function var_0_0.onItemMove(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_0._touchStatus == var_0_0.TouchStatus.tap then
		return
	end

	arg_44_0._touchStatus = var_0_0.TouchStatus.move

	if arg_44_0._movingSprite == nil then
		if arg_44_0._movingDir == var_0_7.none then
			local var_44_0 = math.abs(cc.pSub(arg_44_1:getTouchMovePosition(), arg_44_1:getTouchBeganPosition()).x)
			local var_44_1 = math.abs(cc.pSub(arg_44_1:getTouchMovePosition(), arg_44_1:getTouchBeganPosition()).y)

			if var_44_0 > 32 or var_44_1 > 32 then
				arg_44_0._movingDir = var_44_1 <= var_44_0 and var_0_7.horizontal or var_0_7.vertical
			end
		end

		if arg_44_2 == var_0_8.select_card and arg_44_0._movingDir == var_0_7.vertical and arg_44_1._item._isValid then
			arg_44_0:createMovingSpriteAndMaskLayer(arg_44_1)

			if arg_44_0._selectCardList then
				arg_44_0._selectCardList:setIsScrollEnabled(false)
			end
		end
	end

	if arg_44_0._movingSprite then
		arg_44_0._movingSprite:setPosition(cc.pAdd(arg_44_0._movingSprite._srcPos, cc.pSub(arg_44_1:getTouchMovePosition(), arg_44_1:getTouchBeganPosition())))
	end
end

function var_0_0.onItemTap(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0._touchStatus = var_0_0.TouchStatus.tap

	local var_45_0 = arg_45_1._infoId

	if arg_45_0._movingDir == var_0_7.none then
		if arg_45_2 == var_0_8.troop_card then
			local var_45_1 = {}
			local var_45_2 = 0
			local var_45_3 = arg_45_0._troopList:getItems()

			for iter_45_0 = 1, #var_45_3 do
				local var_45_4 = var_45_3[iter_45_0]._item._thumbnail

				var_45_1[#var_45_1 + 1] = {
					_infoId = var_45_4._infoId,
					_num = var_45_4._count
				}

				if arg_45_1 == var_45_4 then
					var_45_2 = iter_45_0
				end
			end

			local var_45_5 = var_0_2.create(var_45_0, 1, var_0_2.OperateType.na)

			var_45_5:setCardList(var_45_1, var_45_2, Str(STR.CUR_TROOP))
			var_45_5:setCardCount(arg_45_1._count)
			var_45_5:show()
		else
			var_0_2.create(var_45_0, 1, var_0_2.OperateType.na):show()
		end
	elseif arg_45_2 == var_0_8.select_card and arg_45_0._movingSprite then
		if P._playerFindSurvivalEx:getTroopCardCount() < P._playerFindSurvivalEx.MAX_TROOP_COUNT then
			if lc.y(arg_45_0._movingSprite) < arg_45_0._separatorPos then
				arg_45_0:onSelectCard(var_45_0)
			end
		else
			ToastManager.push(Str(STR.FULL_IN_TROOP))
		end
	end

	if arg_45_0._maskLayer then
		arg_45_0._maskLayer:removeFromParent(true)

		arg_45_0._maskLayer = nil
	end

	if arg_45_0._movingSprite then
		arg_45_0._movingSprite:removeFromParent()

		arg_45_0._movingSprite = nil
	end

	if arg_45_0._selectCardList then
		arg_45_0._selectCardList:setIsScrollEnabled(true)
	end
end

function var_0_0.createMovingSpriteAndMaskLayer(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0._troopList
	local var_46_1 = arg_46_1:convertToWorldSpace(cc.p(lc.w(arg_46_1) / 2, lc.h(arg_46_1) / 2))
	local var_46_2 = arg_46_0:convertToNodeSpace(var_46_1)
	local var_46_3 = arg_46_1._infoId
	local var_46_4 = var_0_1.create(var_46_3, var_0_5)

	arg_46_0:addChild(var_46_4, ClientData.ZOrder.ui + 2)

	arg_46_0._movingSprite = var_46_4
	arg_46_0._movingSprite._srcPos = var_46_2
	arg_46_0._movingSprite._abc = 1

	arg_46_0._movingSprite:setPosition(cc.pAdd(var_46_2, cc.pSub(arg_46_1:getTouchMovePosition(), arg_46_1:getTouchBeganPosition())))

	local var_46_5 = var_46_0:convertToWorldSpace(cc.p(0, 0))
	local var_46_6 = arg_46_0:convertToNodeSpace(var_46_5)

	var_46_6.x = 0

	local var_46_7 = cc.rect(var_46_6.x, var_46_6.y, lc.w(arg_46_0), lc.h(var_46_0))
	local var_46_8 = cc.LayerColor:create(cc.c4b(0, 0, 0, 192), lc.w(arg_46_0), lc.h(arg_46_0))

	arg_46_0._maskLayer = ClientView.createClipNode(var_46_8, var_46_7, true)

	arg_46_0:addChild(arg_46_0._maskLayer, ClientData.ZOrder.ui + 1)

	arg_46_0._separatorPos = var_46_6.y + var_46_7.height
end

function var_0_0.remainItemFromList(arg_47_0)
	local var_47_0 = {}
	local var_47_1 = arg_47_0._troopList:getItems()

	for iter_47_0 = #var_47_1, 1, -1 do
		local var_47_2 = var_47_1[iter_47_0]
		local var_47_3 = false

		for iter_47_1, iter_47_2 in ipairs(P._playerFindSurvivalEx:getTroopCards()) do
			if var_47_2._card._infoId == iter_47_2._infoId then
				var_47_3 = true

				break
			end
		end

		if var_47_3 then
			table.insert(var_47_0, var_47_2)
			arg_47_0._troopList:removeItem(iter_47_0 - 1, false)
		end
	end

	return var_47_0
end

function var_0_0.playAction(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = cc.p(lc.cw(arg_48_0), lc.ch(arg_48_0._troopList))
	local var_48_1 = arg_48_0._troopList:getItems()

	for iter_48_0, iter_48_1 in ipairs(var_48_1) do
		if iter_48_1._card._infoId == arg_48_2 then
			var_48_0 = arg_48_0:convertToNodeSpace(iter_48_1:convertToWorldSpace(cc.p(lc.cw(iter_48_1), lc.ch(iter_48_1))))

			break
		end
	end

	local var_48_2 = cc.Node:create()

	lc.addChildToPos(arg_48_0, var_48_2, arg_48_1)

	local var_48_3 = Particle.create("sz1")

	lc.addChildToCenter(var_48_2, var_48_3)

	local var_48_4 = Particle.create("sz2")

	lc.addChildToCenter(var_48_2, var_48_4)
	var_48_2:setScale(2)
	var_48_2:runAction(lc.sequence(lc.moveTo(0.4, var_48_0), lc.call(function()
		var_48_3:setDuration(0.1)
		var_48_4:setDuration(0.1)
	end), lc.delay(1), lc.remove()))
end

function var_0_0.enterBattleField(arg_50_0)
	if arg_50_0._battleLayer ~= nil then
		return
	end

	arg_50_0:hideSelectCards()

	local var_50_0 = lc.createNode(arg_50_0:getContentSize())

	lc.addChildToCenter(arg_50_0, var_50_0, 100)

	arg_50_0._battleLayer = var_50_0

	local var_50_1 = arg_50_0:createTroopArea(var_50_0)

	arg_50_0:updateTroopList()

	local var_50_2 = lc.createSpriteWithMask("res/jpg/img_survive_start_bg.jpg")

	lc.addChildToPos(var_50_0, var_50_2, cc.p(lc.cw(var_50_0), lc.h(var_50_0) - lc.ch(var_50_2)))

	local var_50_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_51_0)
		arg_50_0:onFindingHall()
	end, ClientView.CRECT_BUTTON, 140)

	lc.addChildToPos(var_50_2, var_50_3, cc.p(lc.cw(var_50_2), 20))
	var_50_3:addLabel(Str(STR.START))

	arg_50_0._btnFind = var_50_3

	local var_50_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("LogForm").create(Battle_pb.PB_BATTLE_SURVIVAL_EX):show()
	end, ClientView.CRECT_BUTTON_S, 100)

	lc.addChildToPos(var_50_0, var_50_4, cc.p(lc.w(var_50_0) - lc.cw(var_50_4) - 20 - ClientView.SCR_EDGE, lc.top(var_50_1) + lc.ch(var_50_4)))
	var_50_4:addLabel(Str(STR.LOG))

	local var_50_5 = ClientView.createScale9ShaderButton("img_btn_3_s", function(arg_53_0)
		require("Dialog").showDialog(Str(STR.CONFIRM_TO_GIVEUP), function()
			arg_50_0:onFinishBattle()
		end)
	end, ClientView.CRECT_BUTTON_S, 100)

	lc.addChildToPos(var_50_0, var_50_5, cc.p(lc.left(var_50_4) - lc.cw(var_50_5) - 20, lc.y(var_50_4)))
	var_50_5:addLabel(Str(STR.GIVEUP))

	arg_50_0._btnGiveup = var_50_5

	ClientView.getResourceUI():setMode(Data.ResType.gold)
end

function var_0_0.hideBattleField(arg_55_0)
	if not arg_55_0._battleLayer then
		return
	end

	arg_55_0:releaseTroopCards()
	arg_55_0._battleLayer:removeFromParent()

	arg_55_0._battleLayer = nil
	arg_55_0._troopList = nil
end

function var_0_0.onReselectCharacter(arg_56_0)
	if P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.survival_privilege_1) > 0 or P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.survival_privilege_2) > 0 then
		if P._playerFindSurvivalEx:couldRollCharacter() then
			P._playerFindSurvivalEx._rollTimes = P._playerFindSurvivalEx._rollTimes + 1

			ClientView.getActiveIndicator():show(Str(STR.WAITING))
			ClientData.sendSurvivalReselectCharacter()

			return
		else
			return ToastManager.push(Str(STR.SURVIVAL_PRIVILEGE_UPGRADE_TIP))
		end
	end

	require("ArenaPrivilegePanel").create(2):show()
end

return var_0_0
