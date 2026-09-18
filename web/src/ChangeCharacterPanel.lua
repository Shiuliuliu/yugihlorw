local var_0_0 = class("ChangeCharacterPanel", require("BasePanel"))
local var_0_1 = 320
local var_0_2 = 500
local var_0_3 = 10
local var_0_4 = 140
local var_0_5 = {
	nil,
	"qingyanbailong",
	"heimodao",
	"qiquanniao",
	"shijianmoshushi",
	nil,
	"dafeie",
	nil,
	"dianzisha",
	"xiaoyilong",
	"danlong",
	"baiyezhinvwang",
	"kuileishi",
	"shouqianglong",
	"yuyiliziqiu",
	"xcl",
	"dianzihuatianshi",
	"taiyangshengzhiyishenglong",
	"heiqiangweilong"
}
local var_0_6 = {
	[2] = cc.p(-150, 80),
	[3] = cc.p(-150, 60),
	[5] = cc.p(-150, 20),
	[12] = cc.p(-150, 20),
	[4] = cc.p(-150, 86),
	[13] = cc.p(-150, 56),
	[10] = cc.p(-150, 6),
	[9] = cc.p(-150, 36),
	[7] = cc.p(-150, 66),
	[14] = cc.p(-150, 66),
	[11] = cc.p(-150, 30),
	[15] = cc.p(-150, 30),
	[16] = cc.p(-150, 30),
	[17] = cc.p(-150, 30),
	[18] = cc.p(-150, 30),
	[19] = cc.p(-150, 30)
}

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, not ClientView.isInBattleScene())

	arg_2_0._panelName = "ChangeCharacterPanel"
	arg_2_0._isGuide = arg_2_1
	arg_2_0._bottomH = arg_2_0._isGuide and 220 or 190

	if not arg_2_0._isGuide then
		local var_2_0 = ClientView.createTitleArea(Str(STR.CHANGE_CHARACTER), function()
			arg_2_0:hide()
		end)

		arg_2_0:addChild(var_2_0, 1)
	end

	local var_2_1 = lc.createSprite("res/jpg/change_character_bg.jpg")

	lc.addChildToCenter(arg_2_0, var_2_1)

	arg_2_0._bg = var_2_1

	local var_2_2 = lc.createSprite("change_character_title")

	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.cw(var_2_2) + ClientView.SCR_EDGE, lc.h(arg_2_0) - ClientView.UI_SCENE_TITLE_HEIGHT - lc.ch(var_2_2)))

	arg_2_0._title = var_2_2

	local var_2_3 = ccui.Scale9Sprite:createWithSpriteFrameName("change_character_list_bg", cc.rect(0, 0, 0, 0))

	var_2_3:setContentSize(cc.size(lc.w(arg_2_0._title), lc.bottom(arg_2_0._title)))
	lc.addChildToPos(arg_2_0, var_2_3, cc.p(lc.x(arg_2_0._title), lc.ch(var_2_3)))

	arg_2_0._listBg = var_2_3
	arg_2_0._curCharaNode = lc.createNode()

	lc.addChildToPos(arg_2_0, arg_2_0._curCharaNode, cc.p(lc.cw(arg_2_0) + lc.cw(var_2_2) - var_0_3 + 40, lc.ch(arg_2_0)))

	if arg_2_0._isGuide then
		local var_2_4 = cc.Label:createWithTTF(Str(STR.SELECT_YOUR_CHARACTER), ClientView.TTF_FONT, ClientView.FontSize.S1)

		var_2_4:setColor(ClientView.COLOR_TEXT_LIGHT)
		var_2_4:setPosition(lc.x(arg_2_0._curCharaNode), lc.h(arg_2_0) - 40)
		arg_2_0:addChild(var_2_4)

		local var_2_5 = cc.Label:createWithTTF(Str(STR.USE_DIFFICULTY_1), ClientView.TTF_FONT, ClientView.FontSize.S1)

		var_2_5:setColor(ClientView.COLOR_TEXT_LIGHT)
		var_2_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_2_5:setPosition(lc.x(arg_2_0._curCharaNode), 192)
		arg_2_0:addChild(var_2_5)

		arg_2_0._difficultyLabel = var_2_5

		local var_2_6 = cc.size(380, 60)
		local var_2_7 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, var_2_6, "", true)

		var_2_7:setPosition(lc.x(arg_2_0._curCharaNode), 142)
		arg_2_0:addChild(var_2_7)

		arg_2_0._editor = var_2_7

		local var_2_8 = cc.Label:createWithTTF(Str(STR.NICKNAME), ClientView.TTF_FONT, ClientView.FontSize.M2)

		var_2_8:setColor(ClientView.COLOR_TEXT_LIGHT)
		var_2_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_2_8:setPosition(lc.left(var_2_7) - lc.cw(var_2_8) - 10, 142)
		arg_2_0:addChild(var_2_8)

		arg_2_0._label = var_2_8

		lc.TextureCache:addImageWithMask("res/jpg/img_icon_dice.jpg")

		local var_2_9 = ClientView.createShaderButton("res/jpg/img_icon_dice.jpg", function(arg_4_0)
			arg_2_0:randomNickname()
		end)

		var_2_9:setPosition(lc.right(var_2_7) + lc.w(var_2_9) / 2 + 10, lc.y(var_2_7))
		arg_2_0:addChild(var_2_9)
	end

	local var_2_10 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_5_0)
		arg_2_0:onConfirm()
	end, ClientView.CRECT_BUTTON, ClientView.PANEL_BTN_WIDTH)

	var_2_10:addLabel(Str(STR.OK))
	arg_2_0:addChild(var_2_10)

	arg_2_0._btnOk = var_2_10

	local var_2_11 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_6_0)
		arg_2_0:onUnlock(arg_2_0._selectedId)
	end, ClientView.CRECT_BUTTON, ClientView.PANEL_BTN_WIDTH)

	var_2_11:addLabel(Str(STR.UNLOCK))
	arg_2_0:addChild(var_2_11)

	arg_2_0._btnUnlock = var_2_11

	local var_2_12 = lc.h(var_2_10) / 2 + (arg_2_0._isGuide and 20 or 70)

	if arg_2_1 then
		GuideManager.releaseLayer()
		arg_2_0:addTouchEventListener(function()
			return
		end)
		var_2_10:setPosition(lc.x(arg_2_0._curCharaNode), var_2_12)
		arg_2_0:randomNickname()
		arg_2_0._btnUnlock:setVisible(false)
	else
		var_2_10:setPosition(lc.x(arg_2_0._curCharaNode), var_2_12)
		arg_2_0._btnUnlock:setPosition(lc.x(var_2_10), var_2_12)
	end

	arg_2_0._curCharaNode:setPositionY(lc.ch(arg_2_0) + lc.top(var_2_10) / 2 + (arg_2_0._isGuide and 40 or 10))
	arg_2_0:initCharacterList()
end

function var_0_0.initCharacterList(arg_8_0)
	arg_8_0._heads = {}

	local var_8_0 = lc.List.createV(arg_8_0._listBg:getContentSize(), 2 * var_0_3, 2 * var_0_3)

	var_8_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_8_0._listBg, var_8_0)

	arg_8_0._list = var_8_0

	local var_8_1 = arg_8_0._isGuide and {
		{
			5,
			2
		},
		{
			3,
			15
		}
	} or {
		{
			15,
			2
		},
		{
			3,
			5
		},
		{
			16,
			12
		},
		{
			4,
			13
		},
		{
			10,
			9
		},
		{
			7,
			14
		},
		{
			11,
			17
		},
		{
			18,
			19
		}
	}

	for iter_8_0 = 1, #var_8_1 do
		local var_8_2 = var_8_1[iter_8_0]
		local var_8_3 = Data._characterInfo[var_8_2[1]]
		local var_8_4 = Data._characterInfo[var_8_2[2]]

		var_8_3 = var_8_3 or {
			_id = -1
		}
		var_8_4 = var_8_4 or {
			_id = -1
		}

		local var_8_5 = arg_8_0:setOrCreateItem(var_8_3, var_8_4)

		var_8_0:pushBackCustomItem(var_8_5)
	end

	arg_8_0:selectCharacter(P:getCharacterId())
end

function var_0_0.setCurrentCharacter(arg_9_0, arg_9_1)
	if arg_9_1._id == -1 then
		return ToastManager.push(Str(STR.SID_FIXITY_DESC_1013))
	end

	if arg_9_1._id == 15 or arg_9_1._id == 16 then
		arg_9_0._bg:setTexture("res/jpg/change_character_bg2.jpg")
	else
		arg_9_0._bg:setTexture("res/jpg/change_character_bg.jpg")
	end

	arg_9_0._selectedId = arg_9_1._id

	local var_9_0 = ClientView.createShaderButton(nil, function(arg_10_0)
		if arg_10_0._lock:isVisible() then
			arg_9_0:onUnlock(arg_9_1._id)
		end
	end)

	var_9_0._id = arg_9_1._id

	var_9_0:setContentSize(var_0_1, lc.h(arg_9_0) - arg_9_0._bottomH)

	local var_9_1 = lc.createSprite({
		_name = "img_com_bg_43",
		_size = cc.size(var_0_1, ClientView.CRECT_COM_BG43.height),
		_crect = ClientView.CRECT_COM_BG43
	})

	lc.addChildToPos(var_9_0, var_9_1, cc.p(lc.cw(var_9_0), lc.ch(var_9_1) + 20), 1)

	var_9_0._nameBg = var_9_1

	local var_9_2 = ClientView.createBMFont(ClientView.BMFont.huali_32, Str(arg_9_1._nameSid))

	lc.addChildToCenter(var_9_1, var_9_2)

	local var_9_3 = DragonBones.create(var_0_5[arg_9_1._id])

	var_9_3:gotoAndPlay("effect1")
	var_9_3:setScale(0.8)
	lc.addChildToPos(var_9_0, var_9_3, cc.p(lc.x(var_9_1) + var_0_6[arg_9_1._id].x, lc.top(var_9_1) + 120 + var_0_6[arg_9_1._id].y))

	if ClientData.isAnotherSkin2() then
		var_9_3:setVisible(false)
	end

	local var_9_4 = DragonBones.create(Data.getCharacterBoneName(arg_9_1._id))

	var_9_4:gotoAndPlay(Data.getCharacterAniName(arg_9_1._id))
	var_9_4:setScale(0.495)
	lc.addChildToPos(var_9_0, var_9_4, cc.p(lc.x(var_9_1), lc.top(var_9_1) + 120))
	lc.offset(var_9_4, 0, Data.getCharacterOffsetY(arg_9_1._id))

	local var_9_5 = lc.createSprite("img_light")

	var_9_5:setScale(5)
	var_9_5:runAction(lc.rep(lc.sequence(lc.scaleTo(0.8, 6), lc.scaleTo(0.8, 5))))
	lc.addChildToPos(var_9_0, var_9_5, cc.p(lc.x(var_9_1), lc.top(var_9_1) + 200), -1)

	var_9_0._light = var_9_5

	local var_9_6 = lc.createSprite("img_lock")

	lc.addChildToPos(var_9_0, var_9_6, cc.p(lc.x(var_9_1), lc.top(var_9_1) + 64))

	var_9_0._lock = var_9_6

	local var_9_7 = lc.createSprite({
		_name = "img_form_title_light_1",
		_crect = ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT,
		_size = cc.size(300, ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT.height)
	})

	lc.addChildToPos(var_9_0, var_9_7, cc.p(lc.x(var_9_1), lc.top(var_9_1) + 12))

	var_9_0._tipBg = var_9_7

	if arg_9_1._packageIds[1] ~= 0 then
		local var_9_8 = ClientView.createTTF(Str(STR.CAN_S) .. Str(STR.UNLOCK) .. Str(Data.getRecruiteInfo(arg_9_1._packageIds[1])._nameSid), ClientView.FontSize.S3)

		var_9_8:setColor(lc.Color3B.yellow)
		lc.addChildToCenter(var_9_7, var_9_8)
	end

	if arg_9_1._id == 2 then
		lc.offset(var_9_4, 10, 0)
	end

	arg_9_0._curCharaNode:removeAllChildren()
	arg_9_0._curCharaNode:addChild(var_9_0)

	local var_9_9 = not arg_9_0._isGuide and not P:isCharacterUnlocked(var_9_0._id) or false

	var_9_0._nameBg:setSpriteFrame(lc.FrameCache:getSpriteFrame(not var_9_9 and "img_com_bg_44" or "img_com_bg_43"), ClientView.CRECT_COM_BG43)
	var_9_0._nameBg:setContentSize(var_0_1, ClientView.CRECT_COM_BG43.height)
	var_9_0._nameBg:setEffect(nil)
	var_9_0._nameBg:setEffect(var_9_9 and ClientView.SHADER_DISABLE or nil)
	var_9_0._light:setVisible(not var_9_9)
	var_9_0._lock:setVisible(var_9_9)
	var_9_0._tipBg:setVisible(var_9_9 or arg_9_0._isGuide)

	if arg_9_1._visibleLevel > 0 then
		local var_9_10 = ClientView.createTTF(Str(STR.CHARACTER_NO_PACKAGE), ClientView.FontSize.S1)

		lc.addChildToPos(var_9_0, var_9_10, cc.p(lc.cw(var_9_0), -140))
	end

	if arg_9_0._isGuide then
		local var_9_11 = arg_9_1._difficulty

		arg_9_0._difficultyLabel:setString(Str(STR["USE_DIFFICULTY_" .. var_9_11]))
	end

	arg_9_0._btnOk:setVisible(not var_9_9)
	arg_9_0._btnUnlock:setVisible(var_9_9)
end

function var_0_0.onEnter(arg_11_0)
	var_0_0.super.onEnter(arg_11_0)
	ClientData.addMsgListener(arg_11_0, function(arg_12_0)
		return arg_11_0:onMsg(arg_12_0)
	end, 0)

	arg_11_0._invalidInputListener = lc.addEventListener(Data.Event.invalid_input, function(arg_13_0)
		arg_11_0._btnOk:setEnabled(true)
	end)
end

function var_0_0.onExit(arg_14_0)
	var_0_0.super.onExit(arg_14_0)
	ClientData.removeMsgListener(arg_14_0)
	lc.Dispatcher:removeEventListener(arg_14_0._invalidInputListener)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/img_icon_dice.jpg"))
end

function var_0_0.onCleanup(arg_15_0)
	var_0_0.super.onCleanup(arg_15_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/change_character_bg.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/change_character_bg2.jpg"))
end

function var_0_0.onMsg(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.type

	if var_16_0 == SglMsgType_pb.PB_TYPE_USER_SET_NAME or var_16_0 == SglMsgType_pb.PB_TYPE_USER_SET_NAME_GUIDE then
		ClientView.getActiveIndicator():hide()

		local var_16_1 = string.trim(arg_16_0._editor:getText())

		P:changeName(var_16_1)

		local var_16_2 = cc.EventCustom:new(Data.Event.change_name_dirty)

		lc.Dispatcher:dispatchEvent(var_16_2)

		P._characters[arg_16_0._selectedId]._level = 1

		P:changeCharacter(arg_16_0._selectedId, true)
		ClientData.sendSetCharacter(arg_16_0._selectedId, true)

		if lc.App:getChannelName() == "ASDK" then
			ClientData.submitRoleData("1")
		end

		return true
	elseif var_16_0 == SglMsgType_pb.PB_TYPE_USER_SET_CHARACTER then
		-- Older/private servers may acknowledge the guide request without
		-- sending starter cards. Treat that as a valid response so the panel
		-- still closes and the guide can advance.
		local var_16_3 = arg_16_1.Extensions[User_pb.SglUserMsg.init_cards_resp] or {}

		for iter_16_0 = 1, #var_16_3 do
			local var_16_4 = var_16_3[iter_16_0].info_id
			local var_16_5 = var_16_3[iter_16_0].num
			local var_16_6 = Data.getType(var_16_4)

			P._playerCard:addCard(var_16_4, var_16_5)

			if var_16_6 ~= Data.CardType.rare then
				P._playerCard._troops[1][#P._playerCard._troops[1] + 1] = {
					_infoId = var_16_4,
					_num = var_16_5
				}
			end

			P._playerCard._unlocked[var_16_4] = nil
		end

		arg_16_0:hide()
		GuideManager.finishStep()

		return true
	end

	return false
end

function var_0_0.onConfirm(arg_17_0)
	if not arg_17_0._isGuide then
		if arg_17_0._selectedId ~= P:getCharacterId() then
			P:changeCharacter(arg_17_0._selectedId)
			ClientData.sendSetCharacter(arg_17_0._selectedId)
		end

		arg_17_0:hide()
	elseif not arg_17_0._editor:isValidName() then
		ToastManager.push(Str(STR.INPUT_NAME_INVALID))
	else
		local var_17_0 = string.trim(arg_17_0._editor:getText())

		ClientView.getActiveIndicator():show(Str(STR.WAITING))
		ClientData.sendChangeNameGuide(var_17_0)
		arg_17_0._btnOk:setEnabled(false)
	end
end

function var_0_0.randomNickname(arg_18_0)
	require("NameSample")

	local var_18_0
	local var_18_1

	while var_18_0 == nil and var_18_1 == nil or var_18_0 == var_18_1 do
		var_18_0 = FAMILY_NAMES[math.random(#FAMILY_NAMES)]
		var_18_1 = math.random() > 0.5 and MALE1_NAMES[math.random(#MALE1_NAMES)] or FEMALE1_NAMES[math.random(#FEMALE1_NAMES)]
	end

	arg_18_0._editor:setText(var_18_0 .. var_18_1)
end

function var_0_0.createHead(arg_19_0, arg_19_1)
	local var_19_0 = ClientView.createShaderButton(nil)

	var_19_0:setDisabledShader(ClientView.SHADER_DISABLE)

	local var_19_1 = ClientView.createCharacterHeadById(arg_19_1._id)

	var_19_0:setContentSize(var_19_1:getContentSize())
	lc.addChildToCenter(var_19_0, var_19_1)

	var_19_0._headSpr = var_19_1

	function var_19_0.select(arg_20_0, arg_20_1)
		if arg_20_1 == -1 then
			return
		end

		var_19_1:removeAllChildren()

		if arg_20_1 == arg_19_1._id then
			local var_20_0 = lc.createSprite("character_selected")

			lc.addChildToCenter(var_19_1, var_20_0, -1)
		end
	end

	function var_19_0._callback(arg_21_0)
		if arg_19_0._isGuide and arg_19_1._id ~= 2 and arg_19_1._id ~= 3 and arg_19_1._id ~= 5 and arg_19_1._id ~= 15 then
			return ToastManager.push(Str(STR.CANNOT_SELECT_CHARACTR))
		end

		arg_19_0:setCurrentCharacter(arg_19_1)

		for iter_21_0, iter_21_1 in pairs(arg_19_0._heads) do
			iter_21_1:select(arg_19_1._id)
		end
	end

	arg_19_0._heads[arg_19_1._id] = var_19_0

	if arg_19_0._isGuide and arg_19_1._id ~= 2 and arg_19_1._id ~= 3 and arg_19_1._id ~= 5 and arg_19_1._id ~= 15 then
		var_19_1:setEffect(ClientView.SHADER_DISABLE)
	end

	return var_19_0
end

function var_0_0.setOrCreateItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:createHead(arg_22_1)
	local var_22_1 = arg_22_0:createHead(arg_22_2)
	local var_22_2 = ccui.Widget:create()

	var_22_2:setContentSize(cc.size(lc.w(var_22_0) + lc.w(var_22_1) + 2 * var_0_3, lc.h(var_22_0)))
	lc.addChildToPos(var_22_2, var_22_0, cc.p(lc.cw(var_22_0), lc.ch(var_22_2)))
	lc.addChildToPos(var_22_2, var_22_1, cc.p(lc.w(var_22_2) - lc.cw(var_22_1), lc.ch(var_22_2)))

	return var_22_2
end

function var_0_0.onSelectCharacter(arg_23_0, arg_23_1)
	return
end

function var_0_0.onUnlock(arg_24_0, arg_24_1)
	local var_24_0, var_24_1 = P:canUnlockCharacter(arg_24_1)

	if not var_24_0 then
		return ToastManager.push(var_24_1)
	end

	local var_24_2 = Data.PropsId.char_break_out_token

	if P._propBag:hasProps(var_24_2, 1) then
		require("Dialog").showDialog(string.format(Str(STR.SURE_TO_UNLOCK_CHARACTER_PROP), 1, Str(Data._propsInfo[var_24_2]._nameSid), Str(Data._characterInfo[arg_24_1]._nameSid)), function()
			P._propBag:changeProps(var_24_2, -1)
			ClientData.sendUnlockCharacter(arg_24_1, false)
			arg_24_0:onUnlocked(arg_24_1)
		end)
	else
		var_24_2 = Data.ResType.ingot

		local var_24_3 = P:getCharacterUnlockIngot(arg_24_1)

		if var_24_3 == 0 then
			ClientData.sendUnlockCharacter(arg_24_1, true)
			arg_24_0:onUnlocked(arg_24_1)
		else
			require("Dialog").showDialog(string.format(Str(STR.SURE_TO_UNLOCK_CHARACTER_INGOT, true), var_24_3, Str(Data._resInfo[var_24_2]._nameSid), Str(Data._characterInfo[arg_24_1]._nameSid)), function()
				if ClientView.checkIngot(var_24_3) then
					P:changeResource(var_24_2, -var_24_3)
					ClientData.sendUnlockCharacter(arg_24_1, true)
					arg_24_0:onUnlocked(arg_24_1)
				end
			end)
		end
	end
end

function var_0_0.onUnlocked(arg_27_0, arg_27_1)
	ToastManager.push(string.format(Str(STR.CHARACTER_UNLOCKED), Str(Data._characterInfo[arg_27_1]._nameSid)))

	P._characters[arg_27_1]._level = 1

	arg_27_0:selectCharacter(arg_27_1)
end

function var_0_0.selectCharacter(arg_28_0, arg_28_1)
	arg_28_0._heads[arg_28_1]:_callback()
end

return var_0_0
