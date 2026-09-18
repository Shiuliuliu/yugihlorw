local var_0_0 = class("LevelUpPanel", require("BasePanel"))

var_0_0.Type = {
	lord = 1,
	vip = 2,
	union = 3
}

function var_0_0.createLord(arg_1_0, arg_1_1)
	return var_0_0.create(var_0_0.Type.lord, arg_1_0, arg_1_1)
end

function var_0_0.createVip(arg_2_0, arg_2_1)
	return var_0_0.create(var_0_0.Type.vip, arg_2_0, arg_2_1)
end

function var_0_0.createUnion(arg_3_0, arg_3_1)
	return var_0_0.create(var_0_0.Type.union, arg_3_0, arg_3_1)
end

function var_0_0.create(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_4_0:init(arg_4_0, arg_4_1, arg_4_2)

	return var_4_0
end

function var_0_0.init(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._type = arg_5_1

	var_0_0.super.init(arg_5_0, true, true)

	arg_5_0._curLevel = arg_5_3
	arg_5_0._preLevel = arg_5_2

	local var_5_0 = lc.createSpriteWithMask("res/jpg/img_word_level_bg.jpg")

	lc.addChildToCenter(arg_5_0, var_5_0)

	arg_5_0._bg = var_5_0

	local var_5_1 = lc.createSprite("img_glow")

	var_5_1:setScale(1.5)
	var_5_1:setColor(ClientView.COLOR_GLOW_BLUE)
	var_5_1:runAction(lc.rep(lc.rotateBy(1, 10)))
	lc.addChildToPos(var_5_0, var_5_1, cc.p(lc.cw(var_5_0), lc.h(var_5_0) - 40))

	local var_5_2 = ClientView.createBMFont(ClientView.BMFont.num_48, tostring(arg_5_2))

	var_5_2:setColor(lc.Color4B.white)

	local var_5_3 = ClientView.createBMFont(ClientView.BMFont.num_48, tostring(arg_5_3))

	var_5_3:setColor(lc.Color4B.green)

	local var_5_4 = lc.createSprite("img_arrow_right")

	var_5_4:setColor(lc.Color4B.green)
	lc.addNodesToCenter(var_5_0, {
		var_5_2,
		var_5_4,
		var_5_3
	}, 20, lc.h(var_5_0) - 130)

	local var_5_5 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_5_0:hide()
	end, ClientView.CRECT_BUTTON_S, 200)

	var_5_5:addLabel(Str(STR.BACK))
	var_5_5:setPosition(ClientView.SCR_CW, lc.bottom(var_5_0) + 80)
	arg_5_0:addChild(var_5_5)

	arg_5_0._btnBack = var_5_5

	if arg_5_1 == var_0_0.Type.lord then
		arg_5_0:initLord()
	elseif arg_5_1 == var_0_0.Type.vip then
		arg_5_0:initVip()
	elseif arg_5_1 == var_0_0.Type.union then
		arg_5_0:initUnion()
	end
end

function var_0_0.initLord(arg_7_0)
	local var_7_0 = lc.createSpriteWithMask("res/jpg/img_word_lord.jpg")

	lc.addChildToPos(arg_7_0._bg, var_7_0, cc.p(lc.cw(arg_7_0._bg), lc.h(arg_7_0._bg) - 30))

	local var_7_1 = ClientData._player
	local var_7_2 = arg_7_0._preLevel
	local var_7_3 = arg_7_0._curLevel
	local var_7_4 = {}

	local function var_7_5(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		if arg_8_2 ~= arg_8_3 then
			local var_8_0 = arg_7_0:createUpdateLine(arg_8_0, arg_8_1, arg_8_2, arg_8_3)

			table.insert(var_7_4, var_8_0)
		end
	end

	local var_7_6 = UserWidget.create(P, bor(UserWidget.Flag.LEVEL_NAME, UserWidget.Flag.VIP, UserWidget.Flag.CLICKABLE), 1, false, true)

	var_7_6:setName(Str(Data._characterInfo[P:getCharacterId()]._nameSid))
	lc.addChildToCenter(arg_7_0._bg, var_7_6)
	lc.offset(var_7_6, 0, -10)
end

function var_0_0.initVip(arg_9_0)
	local var_9_0 = lc.createSpriteWithMask("res/jpg/img_word_vip.jpg")

	lc.addChildToPos(arg_9_0._bg, var_9_0, cc.p(lc.cw(arg_9_0._bg), lc.h(arg_9_0._bg) - 30))

	local var_9_1 = ClientView.createScale9ShaderButton("img_btn_1_s", nil, ClientView.CRECT_BUTTON_S, 200)

	var_9_1:addLabel(Str(STR.LOOK_OVER) .. " VIP " .. Str(STR.PRIVILEGE))

	function var_9_1._callback()
		arg_9_0:hide()
		require("VIPInfoForm").create():show()
	end

	lc.addChildToPos(arg_9_0._bg, var_9_1, cc.p(lc.cw(arg_9_0._bg), lc.ch(arg_9_0._bg)))
	lc.offset(arg_9_0._btnBack, 0, 40)
end

function var_0_0.initUnion(arg_11_0)
	local var_11_0 = lc.createSpriteWithMask("res/jpg/img_word_union.jpg")

	lc.addChildToPos(arg_11_0._bg, var_11_0, cc.p(lc.cw(arg_11_0._bg), lc.h(arg_11_0._bg) - 30))
end

function var_0_0.createUpdateLine(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = lc.createNode(cc.size(450, 32))
	local var_12_1 = lc.createSprite(arg_12_2)

	lc.addChildToPos(var_12_0, var_12_1, cc.p(lc.w(var_12_1) / 2, lc.h(var_12_0) / 2))

	local var_12_2 = ClientView.createKeyValueLabel(arg_12_1, tostring(arg_12_3), ClientView.FontSize.M2, true)

	var_12_2:addToParent(var_12_0, cc.p(lc.right(var_12_1) + 10, lc.h(var_12_0) / 2))
	var_12_2:setColor(lc.Color4B.white)

	local var_12_3 = lc.createSprite("img_arrow_right")

	var_12_3:setScale(0.8)
	var_12_3:setColor(lc.Color4B.green)
	lc.addChildToPos(var_12_0, var_12_3, cc.p(320, lc.h(var_12_0) / 2))
	var_12_2._value:setPositionX(lc.left(var_12_3) - 20 - lc.w(var_12_2._value))

	local var_12_4 = ClientView.createTTF(tostring(arg_12_4), ClientView.FontSize.M2, lc.Color4B.green)

	lc.addChildToPos(var_12_0, var_12_4, cc.p(lc.right(var_12_3) + 20 + lc.w(var_12_4) / 2, lc.h(var_12_0) / 2))

	var_12_0._hasValue = true

	return var_12_0
end

function var_0_0.onEnter(arg_13_0)
	var_0_0.super.onEnter(arg_13_0)
	lc.Audio.playAudio(AUDIO.E_PLAYER_UPGRADE)
end

function var_0_0.onCleanup(arg_14_0)
	var_0_0.super.onCleanup(arg_14_0)

	if arg_14_0._cleanupHandler then
		arg_14_0._cleanupHandler()
	end

	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/img_word_level.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/img_word_level_bg.jpg"))

	if arg_14_0._type == var_0_0.Type.lord then
		lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/img_word_lord.jpg"))
	elseif arg_14_0._type == var_0_0.Type.vip then
		lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/img_word_vip.jpg"))
	elseif arg_14_0._type == var_0_0.Type.union then
		lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/img_word_union.jpg"))
	end
end

return var_0_0
