local var_0_0 = class("GetNumberForm", BaseForm)
local var_0_1 = cc.size(720, 280)
local var_0_2 = cc.size(720, 380)

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1 = arg_2_1 or {}
	arg_2_0._param = arg_2_1
	arg_2_0._callback = arg_2_2

	local var_2_0 = var_0_1

	if arg_2_1._titleStr then
		var_2_0 = var_0_2
	end

	var_0_0.super.init(arg_2_0, var_2_0, nil, bor(BaseForm.FLAG.BASE_TITLE_BG))

	local var_2_1 = arg_2_0._form
	local var_2_2 = lc.h(var_2_1) - var_0_0.TOP_MARGIN

	if arg_2_1._titleStr then
		local var_2_3 = ClientView.createBoldRichTextMultiLine(arg_2_1._titleStr, ClientView.RICHTEXT_PARAM_LIGHT_S1, 600)

		lc.addChildToPos(var_2_1, var_2_3, cc.p(lc.cw(var_2_1), var_2_2 - 60))

		local var_2_4 = var_2_2 - 100
	end

	local var_2_5 = require("NumberWidget").create(arg_2_0._param._minCount, arg_2_0._param._maxCount)

	arg_2_0._widget = var_2_5

	local var_2_6 = ClientView.createTTF(Str(STR.TIMES), ClientView.FontSize.M2)

	lc.addNodesToCenter(var_2_1, {
		var_2_6,
		var_2_5
	}, -10, 190, nil, nil, lc.cw(var_2_1) - 20)

	local var_2_7 = ClientView.createScale9ShaderButton("img_btn_2", function()
		if arg_2_0._callback then
			arg_2_0._callback(arg_2_0._widget:getCount(), sender)
		end

		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, 200)

	var_2_7:addLabel(Str(STR.OK))
	lc.addChildToPos(var_2_1, var_2_7, cc.p(lc.cw(var_2_1), 80))

	arg_2_0._btnSend = var_2_7
end

return var_0_0
