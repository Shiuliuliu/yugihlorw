local var_0_0 = class("SendMailForm", BaseForm)
local var_0_1 = cc.size(640, 440)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local var_2_0 = cc.size(var_0_1.width, var_0_1.height)

	if arg_2_1 == nil then
		var_2_0.height = 320
	end

	var_0_0.super.init(arg_2_0, var_2_0, arg_2_1 and Str(STR.LEAVE_MESSAGE) or Str(STR.SEND_GROUP) .. Str(STR.MAIL), 0)

	local var_2_1 = arg_2_0._form

	arg_2_0._user = arg_2_1

	local var_2_2

	if arg_2_1 then
		local var_2_3 = UserWidget.create(arg_2_1, UserWidget.Flag.NAME_UNION)

		var_2_3._unionArea._name:setColor(ClientView.COLOR_TEXT_ORANGE)
		lc.addChildToPos(var_2_1, var_2_3, cc.p(260, lc.bottom(arg_2_0._titleFrame) - 70))

		var_2_2 = lc.bottom(var_2_3)

		if not P:hasPrivilege(Data.Privilege.mail_free) then
			local var_2_4 = Data._globalInfo._dailySendMailCount
			local var_2_5 = ClientView.createBoldRichText(string.format(Str(STR.DAILY_SEND_MAILS), var_2_4 - P._dailySendMail, var_2_4), ClientView.RICHTEXT_PARAM_LIGHT_S1)

			var_2_5:setAnchorPoint(cc.p(0, 1))
			lc.addChildToPos(var_2_1, var_2_5, cc.p(lc.left(var_2_3), lc.bottom(var_2_3) - 10))

			var_2_2 = lc.bottom(var_2_5)
		end
	else
		var_2_2 = lc.bottom(arg_2_0._titleFrame) - 10
	end

	local var_2_6 = cc.size(500, 60)
	local var_2_7 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, var_2_6, nil, true)

	lc.addChildToPos(var_2_1, var_2_7, cc.p(70 + var_2_6.width / 2, var_2_2 - var_2_6.height / 2 - 10))

	arg_2_0._editor = var_2_7

	local var_2_8 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_2_0:sendMail()
	end, ClientView.CRECT_BUTTON, 140)

	var_2_8:addLabel(Str(STR.SEND))
	lc.addChildToPos(var_2_1, var_2_8, cc.p(lc.w(var_2_1) / 2, var_0_0.BOTTOM_MARGIN + lc.h(var_2_8) / 2 + 30))
end

function var_0_0.sendMail(arg_4_0)
	local var_4_0 = arg_4_0._editor:getText()

	if var_4_0 == "" then
		ToastManager.push(Str(STR.INPUT_MESSAGE))
	elseif lc.utf8len(var_4_0) > ClientData.MAX_INPUT_LEN then
		ToastManager.push(Str(STR.MAIL) .. string.format(Str(STR.CANNOT_MORE_THAN), ClientData.MAX_INPUT_LEN))
	else
		if arg_4_0._user then
			P._dailySendMail = P._dailySendMail + 1

			ClientData.sendMailSend(var_4_0, arg_4_0._user._id)
		else
			ClientData.sendMailSend(var_4_0)
		end

		arg_4_0:hide()
	end
end

return var_0_0
