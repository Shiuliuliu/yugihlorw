local var_0_0 = class("InputForm", BaseForm)
local var_0_1 = cc.size(720, 280)

var_0_0.Type = {
	TROOP_REMARK = 2,
	FEEDBACK = 1,
	UNION_CHAT = 3
}

local var_0_2 = {
	Str(STR.RATE_ADVICE),
	Str(STR.CHANGE) .. Str(STR.REMARK),
	Str(STR.SEND),
	Str(STR.INPUT_MESSAGE)
}
local var_0_3 = {
	Str(STR.SEND),
	Str(STR.CHANGE),
	Str(STR.SEND)
}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.init(arg_2_0, var_0_1, var_0_2[arg_2_1], 0)

	arg_2_0._type = arg_2_1
	arg_2_0._param = arg_2_2
	arg_2_0._callback = arg_2_3

	local var_2_0 = arg_2_0._form
	local var_2_1 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(600, 60), Str(STR.INPUT_SHARE_TEXT))

	lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.w(var_2_0) / 2, lc.bottom(arg_2_0._titleFrame) - 20 - lc.h(var_2_1) / 2))

	arg_2_0._editor = var_2_1

	local var_2_2 = ClientView.createScale9ShaderButton("img_btn_2", function()
		arg_2_0:send()
	end, ClientView.CRECT_BUTTON, 120)

	var_2_2:addLabel(var_0_3[arg_2_1])
	lc.addChildToPos(var_2_0, var_2_2, cc.p(lc.right(var_2_1) - lc.w(var_2_2) / 2, 80))

	arg_2_0._btnSend = var_2_2
end

function var_0_0.send(arg_4_0)
	local var_4_0 = arg_4_0._editor:getText()
	local var_4_1 = arg_4_0._type

	if var_4_1 == var_0_0.Type.FEEDBACK then
		if lc.utf8len(var_4_0) > 400 then
			ToastManager.push(Str(STR.MESSAGE) .. string.format(Str(STR.CANNOT_MORE_THAN), 400))

			return
		elseif lc.utf8len(var_4_0) == 0 then
			ToastManager.push(Str(STR.INPUT_MESSAGE))

			return
		else
			ClientData.sendFeedback(Feedback_pb.PB_FEEDBACK_SUGGESTION, var_4_0)
			ToastManager.push(Str(STR.FEEDBACK_THANKS))
			arg_4_0:hide()
		end
	elseif var_4_1 == var_0_0.Type.TROOP_REMARK then
		local var_4_2 = ClientView.createTTF(var_4_0, ClientView.FontSize.S2)

		if var_4_0 == "" or lc.w(var_4_2) > 200 then
			ToastManager.push(Str(STR.REMARK_INVALID))

			return
		else
			local var_4_3 = arg_4_0._param
			local var_4_4 = arg_4_0._callback

			arg_4_0._callback = nil

			local function var_4_5()
				P._troopRemarks[var_4_3] = var_4_0

				if var_4_4 then
					var_4_4()
				end
			end

			arg_4_0:hide()
			ClientView.getActiveIndicator():show(Str(STR.WATING), nil, var_4_5)
			ClientData.sendTroopRemark(var_4_3, var_4_0)
		end
	elseif var_4_1 == var_0_0.Type.UNION_CHAT then
		if lc.utf8len(var_4_0) > ClientData.MAX_INPUT_LEN then
			ToastManager.push(Str(STR.MESSAGE) .. string.format(Str(STR.CANNOT_MORE_THAN), ClientData.MAX_INPUT_LEN))

			return
		elseif lc.utf8len(var_4_0) == 0 then
			ToastManager.push(Str(STR.INPUT_MESSAGE))

			return
		else
			local var_4_6 = P._playerUnion
			local var_4_7 = var_4_6:canOperate(var_4_6.Operate.send_message)

			if var_4_7 == Data.ErrorType.ok then
				ClientData.sendChat(Chat_pb.PB_CHAT_UNION, P._unionId, var_4_0)
			else
				ToastManager.push(ClientData.getUnionErrorStr(var_4_7))
			end

			arg_4_0:hide()
		end
	end
end

function var_0_0.hide(arg_6_0, arg_6_1)
	var_0_0.super.hide(arg_6_0, arg_6_1)

	if arg_6_0._callback then
		arg_6_0._callback()
	end
end

return var_0_0
