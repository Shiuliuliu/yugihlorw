local var_0_0 = class("CreateGroupForm", BaseForm)
local var_0_1 = cc.size(720, 550)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = cc.size(400, 60)
	local var_2_1 = ClientView.createEditBox("img_com_bg_5", ClientView.CRECT_COM_BG3, var_2_0, Str(STR.INPUT_GROUP_NAME), true)

	var_2_1:setFontColor(lc.Color4B.white)
	var_2_1:setPosition(var_0_0.LEFT_MARGIN + 200 + var_2_0.width / 2, lc.h(arg_2_0._form) - var_0_0.TOP_MARGIN - 90)
	arg_2_0._form:addChild(var_2_1)

	arg_2_0._editor = var_2_1

	local var_2_2 = ClientView.createTTF(Str(STR.SELECT_GROUP_HEAD), ClientView.FontSize.S2)

	lc.addChildToPos(arg_2_0._form, var_2_2, cc.p(lc.cw(arg_2_0._form), lc.bottom(var_2_1) - lc.ch(var_2_2) - 30))

	local var_2_3 = lc.createSprite("img_glow")

	var_2_3:setScale(0.7)
	var_2_3:runAction(lc.rep(lc.spawn(lc.rotateBy(5, 270), lc.ease(lc.sequence(lc.spawn(lc.scaleTo(2.5, 0.5), lc.fadeOut(2.5)), lc.spawn(lc.scaleTo(2.5, 0.7), lc.fadeIn(2.5))), "SineIO"))))
	lc.addChildToPos(arg_2_0._form, var_2_3, cc.p(lc.left(var_2_1) / 2, lc.y(var_2_1)))

	arg_2_0._avatar = 1

	local var_2_4 = ClientView.createGroupAvatar(arg_2_0._avatar)

	lc.addChildToPos(arg_2_0._form, var_2_4, cc.p(lc.left(var_2_1) / 2, lc.y(var_2_1)))

	arg_2_0._curAvatar = var_2_4

	local var_2_5 = lc.List.createH(cc.size(lc.w(arg_2_0._form) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 6, 150), 20, 20)

	var_2_5:setAnchorPoint(0.5, 0.5)

	local var_2_6 = lc.createSprite({
		_name = "group_avatars_bg",
		_crect = cc.rect(1, 1, 2, 2),
		_size = var_2_5:getContentSize()
	})

	lc.addChildToPos(arg_2_0._form, var_2_6, cc.p(lc.w(arg_2_0._form) / 2, lc.bottom(var_2_2) - 30 - lc.h(var_2_5) / 2))
	lc.addChildToPos(arg_2_0._form, var_2_5, cc.p(lc.w(arg_2_0._form) / 2, lc.bottom(var_2_2) - 30 - lc.h(var_2_5) / 2))

	arg_2_0._selectedBg = lc.createSprite("res/jpg/group_avatar_selected.jpg")

	arg_2_0._selectedBg:retain()

	arg_2_0._avatars = {}

	for iter_2_0 = 1, 10 do
		local var_2_7 = ClientView.createShaderButton(nil, function(arg_3_0)
			arg_2_0._avatar = iter_2_0

			arg_2_0:updateAvatarPreview()
		end)
		local var_2_8 = ClientView.createGroupAvatar(iter_2_0)

		var_2_7:setContentSize(var_2_8:getContentSize())
		lc.addChildToCenter(var_2_7, var_2_8)
		var_2_5:pushBackCustomItem(var_2_7)
		table.insert(arg_2_0._avatars, var_2_7)
	end

	arg_2_0:updateAvatarPreview()

	local var_2_9 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_4_0)
		arg_2_0:onConfirm()
	end, ClientView.CRECT_BUTTON, ClientView.PANEL_BTN_WIDTH)

	var_2_9:addLabel(Str(STR.OK))
	lc.addChildToPos(arg_2_0._form, var_2_9, cc.p(lc.cw(arg_2_0._form), lc.ch(var_2_9) + 50))

	arg_2_0._btnOk = var_2_9
end

function var_0_0.updateAvatarPreview(arg_5_0)
	arg_5_0._curAvatar.update(arg_5_0._avatar)
	arg_5_0._selectedBg:removeFromParent()
	lc.addChildToCenter(arg_5_0._avatars[arg_5_0._avatar], arg_5_0._selectedBg, -1)
end

function var_0_0.onConfirm(arg_6_0)
	if arg_6_0._editor:isValidName(ClientData.MAX_GROUP_NAME_DISPLAY_LEN) then
		ClientView.getActiveIndicator():show(Str(STR.WAITING))

		local var_6_0 = arg_6_0._editor:getText()
		local var_6_1 = arg_6_0._avatar

		P._playerUnion:createGroup(var_6_0, var_6_1)
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
	else
		ToastManager.push(Str(STR.INPUT_NAME_INVALID))
	end
end

function var_0_0.onEnter(arg_7_0)
	var_0_0.super.onEnter(arg_7_0)

	arg_7_0._listeners = {}

	table.insert(arg_7_0._listeners, lc.addEventListener(Data.Event.union_group_dirty, function()
		if P._playerUnion:getMyGroup() then
			arg_7_0:hide()
		end
	end))
end

function var_0_0.onExit(arg_9_0)
	var_0_0.super.onExit(arg_9_0)

	for iter_9_0 = 1, #arg_9_0._listeners do
		lc.Dispatcher:removeEventListener(arg_9_0._listeners[iter_9_0])
	end
end

function var_0_0.onCleanup(arg_10_0)
	var_0_0.super.onCleanup(arg_10_0)
	arg_10_0._selectedBg:release()
end

return var_0_0
