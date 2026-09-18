local var_0_0 = class("InputNumberForm", BaseForm)
local var_0_1 = cc.size(720, 550)
local var_0_2 = {
	cc.p(100, 330),
	cc.p(230, 330),
	cc.p(360, 330),
	cc.p(490, 330),
	cc.p(620, 330),
	cc.p(100, 200),
	cc.p(230, 200),
	cc.p(360, 200),
	cc.p(490, 200),
	cc.p(620, 200)
}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._confirmHandle = arg_2_3

	if arg_2_1 and (string.find(tostring(arg_2_1), "phòng") or string.find(tostring(arg_2_1), "phong") or tostring(arg_2_1) == ":") then
		arg_2_1 = ""
	end

	local var_2_0 = cc.size(580, 60)
	local var_2_1 = ClientView.createEditBox("img_com_bg_5", ClientView.CRECT_COM_BG3, var_2_0, arg_2_1 or "", true)

	var_2_1:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC)
	var_2_1:setFontColor(lc.Color4B.white)
	var_2_1:setEnabled(false)
	var_2_1:setPosition(var_0_0.LEFT_MARGIN + 30 + var_2_0.width / 2, lc.h(arg_2_0._form) - var_0_0.TOP_MARGIN - 60)

	if arg_2_2 then
		var_2_1:setText(arg_2_2)
	end

	arg_2_0._form:addChild(var_2_1)

	arg_2_0._editor = var_2_1

	local var_2_2 = ClientView.createShaderButton(nil, function(arg_3_0)
		arg_2_0._editor:setText("")
	end)

	var_2_2:setContentSize(cc.size(60, 60))
	lc.addChildToPos(arg_2_0._form, var_2_2, cc.p(lc.right(var_2_1) - lc.cw(var_2_2), lc.y(var_2_1)))

	local var_2_3 = lc.createSprite("img_troop_x")

	lc.addChildToCenter(var_2_2, var_2_3)

	local var_2_4 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_4_0)
		arg_2_0:onConfirm()
	end, ClientView.CRECT_BUTTON, ClientView.PANEL_BTN_WIDTH)

	var_2_4:addLabel(Str(STR.OK))
	lc.addChildToPos(arg_2_0._form, var_2_4, cc.p(lc.cw(arg_2_0._form), lc.ch(var_2_4) + 40))

	arg_2_0._btnOk = var_2_4

	local var_2_5 = var_0_0.BOTTOM_MARGIN + lc.h(var_2_4) / 2 + 10

	arg_2_0:initNumbers()
end

function var_0_0.onConfirm(arg_5_0)
	if arg_5_0._confirmHandle then
		local var_5_0 = arg_5_0._editor:getText()

		arg_5_0._confirmHandle(arg_5_0, var_5_0)
	end
end

function var_0_0.registerConfirmHandle(arg_6_0, arg_6_1)
	arg_6_0._confirmHandle = arg_6_1
end

function var_0_0.initNumbers(arg_7_0)
	for iter_7_0 = 1, 10 do
		local var_7_0 = arg_7_0:createNumberButton(iter_7_0)

		lc.addChildToPos(arg_7_0._frame, var_7_0, var_0_2[iter_7_0])
	end
end

function var_0_0.createNumberButton(arg_8_0, arg_8_1)
	local var_8_0 = ClientView.createShaderButton("room_number_btn", function(arg_9_0)
		arg_8_0._editor:setText(arg_8_0._editor:getText() .. arg_8_1 % 10)
	end)
	local var_8_1 = ClientView.createTTF(arg_8_1 % 10, ClientView.FontSize.B2)

	lc.addChildToCenter(var_8_0, var_8_1)
	var_8_1:setColor(ClientView.COLOR_TEXT_DARK)

	return var_8_0
end

function var_0_0.onEnter(arg_10_0)
	var_0_0.super.onEnter(arg_10_0)

	arg_10_0._listeners = {}
end

function var_0_0.onExit(arg_11_0)
	var_0_0.super.onExit(arg_11_0)

	for iter_11_0 = 1, #arg_11_0._listeners do
		lc.Dispatcher:removeEventListener(arg_11_0._listeners[iter_11_0])
	end
end

return var_0_0
