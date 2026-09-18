local var_0_0 = class("ExchangeCodeForm", BaseForm)
local var_0_1 = cc.size(640, 360)
local var_0_2 = 32

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = cc.Label:createWithTTF(Str(STR.INPUT_EXCHANGE_CODE) .. ":", ClientView.TTF_FONT, ClientView.FontSize.S1)

	var_2_0:setColor(ClientView.COLOR_TEXT_LIGHT)
	var_2_0:setPosition(var_0_0.LEFT_MARGIN + lc.w(var_2_0) / 2 + 60, lc.h(arg_2_0._form) - var_0_0.TOP_MARGIN - 70)
	arg_2_0._form:addChild(var_2_0)

	arg_2_0._label = var_2_0

	local var_2_1 = cc.size(440, 60)
	local var_2_2 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, var_2_1, nil, true)

	var_2_2:setPosition(lc.left(var_2_0) + var_2_1.width / 2, lc.bottom(var_2_0) - var_2_1.height / 2 - 20)
	arg_2_0._form:addChild(var_2_2)

	arg_2_0._editor = var_2_2

	local var_2_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_3_0)
		arg_2_0:onExchange()
	end, ClientView.CRECT_BUTTON, ClientView.PANEL_BTN_WIDTH)

	var_2_3:addLabel(Str(STR.EXCHANGE))
	lc.addChildToPos(arg_2_0._form, var_2_3, cc.p(lc.w(arg_2_0._form) / 2, var_0_0.FRAME_THICK_BOTTOM + 30 + lc.h(var_2_3) / 2))
end

function var_0_0.onEnter(arg_4_0)
	var_0_0.super.onEnter(arg_4_0)
	ClientData.addMsgListener(arg_4_0, function(arg_5_0)
		return arg_4_0:onMsg(arg_5_0)
	end, 0)
end

function var_0_0.onExit(arg_6_0)
	var_0_0.super.onExit(arg_6_0)
	ClientData.removeMsgListener(arg_6_0)
end

function var_0_0.onMsg(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.type
	local var_7_1 = arg_7_1.status

	if var_7_0 == SglMsgType_pb.PB_TYPE_USER_CLAIM_GIFT then
		ClientView.getActiveIndicator():hide()
		arg_7_0:hide()
		require("RewardPanel").create(arg_7_1.Extensions[User_pb.SglUserMsg.user_claim_gift_resp]):show()

		return true
	end

	return false
end

function var_0_0.onExchange(arg_8_0)
	local var_8_0 = string.gsub(arg_8_0._editor:getText() or "", "^%s*(.-)%s*$", "%1")

	if var_8_0 == "" then
		ToastManager.push(Str(STR.INPUT_EXCHANGE_CODE))
	elseif #var_8_0 > var_0_2 then
		ToastManager.push(string.format(Str(STR.CANNOT_MORE_THAN), var_0_2))
	else
		arg_8_0._editor:setText("")
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
		ClientData.sendUserGiftExchange(var_8_0)
	end
end

return var_0_0
