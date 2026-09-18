local var_0_0 = class("RenameForm", BaseForm)
local var_0_1 = cc.size(640, 360)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._isGuide = arg_2_1

	local var_2_0 = cc.Label:createWithTTF(Str(STR.INPUT_YOUR_NAME) .. ":", ClientView.TTF_FONT, ClientView.FontSize.S1)

	var_2_0:setColor(ClientView.COLOR_TEXT_LIGHT)
	var_2_0:setPosition(var_0_0.LEFT_MARGIN + lc.w(var_2_0) / 2 + 60, lc.h(arg_2_0._form) - var_0_0.TOP_MARGIN - 70)
	arg_2_0._form:addChild(var_2_0)

	arg_2_0._label = var_2_0

	local var_2_1 = cc.size(380, 60)
	local var_2_2 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, var_2_1, "", true)

	var_2_2:setPosition(lc.left(var_2_0) + var_2_1.width / 2, lc.bottom(var_2_0) - var_2_1.height / 2 - 20)
	arg_2_0._form:addChild(var_2_2)

	arg_2_0._editor = var_2_2

	lc.TextureCache:addImageWithMask("res/jpg/img_icon_dice.jpg")

	local var_2_3 = ClientView.createShaderButton("res/jpg/img_icon_dice.jpg", function(arg_3_0)
		arg_2_0:randomNickname()
	end)

	var_2_3:setPosition(lc.right(var_2_2) + lc.w(var_2_3) / 2 + 10, lc.y(var_2_2))
	arg_2_0._form:addChild(var_2_3)

	local var_2_4 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_4_0)
		arg_2_0:onChangeName()
	end, ClientView.CRECT_BUTTON, ClientView.PANEL_BTN_WIDTH)

	var_2_4:addLabel(Str(STR.OK))
	arg_2_0._form:addChild(var_2_4)

	arg_2_0._btnOk = var_2_4

	local var_2_5 = var_0_0.BOTTOM_MARGIN + lc.h(var_2_4) / 2 + 10

	if arg_2_1 then
		GuideManager.releaseLayer()
		arg_2_0:addTouchEventListener(function()
			return
		end)
		arg_2_0._btnBack:setVisible(false)
		var_2_4:setPosition(lc.w(arg_2_0._form) / 2, var_2_5)
		arg_2_0:randomNickname()
	else
		var_2_4:setPosition(lc.w(arg_2_0._form) / 2 + lc.w(var_2_4) / 2 + 15, var_2_5)

		local var_2_6 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_6_0)
			arg_2_0:hide()
		end, ClientView.CRECT_BUTTON, ClientView.PANEL_BTN_WIDTH)

		var_2_6:addLabel(Str(STR.CANCEL))
		var_2_6:setPosition(lc.w(arg_2_0._form) / 2 - lc.w(var_2_6) / 2 - 15, var_2_5)
		arg_2_0._form:addChild(var_2_6)
		arg_2_0:refreshChangeNameLabel()
	end
end

function var_0_0.refreshChangeNameLabel(arg_7_0)
	if arg_7_0._labelChangeName ~= nil then
		arg_7_0._labelChangeName:removeFromParent()
	end

	local var_7_0 = arg_7_0._labelChangeName

	if P._changeNameCount == 0 then
		var_7_0 = cc.Label:createWithTTF(Str(STR.FIRST_CHANGE_FREE), ClientView.TTF_FONT, ClientView.FontSize.S1)

		var_7_0:setColor(ClientView.COLOR_TEXT_LIGHT)
		var_7_0:setPosition(lc.x(arg_7_0._btnOk), lc.y(arg_7_0._btnOk) + 65)
	else
		var_7_0 = ccui.RichTextEx:create()

		var_7_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, string.format("%d", Data._globalInfo._editNameIngot), ClientView.TTF_FONT, ClientView.FontSize.S1))
		var_7_0:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, cc.Sprite:createWithSpriteFrameName(string.format("img_icon_res%d_s", Data.ResType.ingot))))
		var_7_0:formatText()
		var_7_0:setPosition(lc.x(arg_7_0._btnOk), lc.y(arg_7_0._btnOk) + 65)
	end

	arg_7_0._form:addChild(var_7_0)

	arg_7_0._labelChangeName = var_7_0
end

function var_0_0.onEnter(arg_8_0)
	var_0_0.super.onEnter(arg_8_0)
	ClientData.addMsgListener(arg_8_0, function(arg_9_0)
		return arg_8_0:onMsg(arg_9_0)
	end, 0)

	arg_8_0._listener = lc.addEventListener(Data.Event.change_name_dirty, function(arg_10_0)
		arg_8_0:refreshChangeNameLabel()
	end)
end

function var_0_0.onExit(arg_11_0)
	var_0_0.super.onExit(arg_11_0)
	lc.Dispatcher:removeEventListener(arg_11_0._listener)
	ClientData.removeMsgListener(arg_11_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/img_icon_dice.jpg"))
end

function var_0_0.onMsg(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.type

	if var_12_0 == SglMsgType_pb.PB_TYPE_USER_SET_NAME or var_12_0 == SglMsgType_pb.PB_TYPE_USER_SET_NAME_GUIDE then
		ClientView.getActiveIndicator():hide()

		local var_12_1 = string.trim(arg_12_0._editor:getText())

		P:changeName(var_12_1)

		if not arg_12_0._isGuide then
			if P._changeNameCount > 0 then
				P:changeResource(Data.ResType.ingot, -Data._globalInfo._editNameIngot)
			end

			P._changeNameCount = P._changeNameCount + 1
		end

		local var_12_2 = cc.EventCustom:new(Data.Event.change_name_dirty)

		lc.Dispatcher:dispatchEvent(var_12_2)
		arg_12_0:hide()

		return true
	end

	return false
end

function var_0_0.onChangeName(arg_13_0)
	if not arg_13_0._editor:isValidName() then
		ToastManager.push(Str(STR.INPUT_NAME_INVALID))
	else
		local var_13_0 = string.trim(arg_13_0._editor:getText())

		if not arg_13_0._isGuide then
			if P._changeNameCount > 0 and not ClientView.checkIngot(Data._globalInfo._editNameIngot) then
				return
			end

			ClientView.getActiveIndicator():show(Str(STR.WAITING))
			ClientData.sendChangeName(var_13_0)
		else
			ClientView.getActiveIndicator():show(Str(STR.WAITING))
			ClientData.sendChangeNameGuide(var_13_0)
		end
	end
end

function var_0_0.randomNickname(arg_14_0)
	require("NameSample")

	local var_14_0
	local var_14_1

	while var_14_0 == nil and var_14_1 == nil or var_14_0 == var_14_1 do
		var_14_0 = FAMILY_NAMES[math.random(#FAMILY_NAMES)]
		var_14_1 = math.random() > 0.5 and MALE1_NAMES[math.random(#MALE1_NAMES)] or FEMALE1_NAMES[math.random(#FEMALE1_NAMES)]
	end

	arg_14_0._editor:setText(var_14_0 .. var_14_1)
end

return var_0_0
