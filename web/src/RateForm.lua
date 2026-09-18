local var_0_0 = class("RateForm", BaseForm)
local var_0_1 = require("InputForm")
local var_0_2 = cc.size(600, 410)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_2, Str(STR.RATE), bor(BaseForm.FLAG.BASE_TITLE_BG, BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form
	local var_2_1 = ClientView.createBoldRichText(Str(STR.RATE_TIP), ClientView.RICHTEXT_PARAM_DARK_S1)

	lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.w(var_2_0) / 2, lc.bottom(arg_2_0._titleFrame) - 20 - lc.h(var_2_1) / 2))

	local var_2_2 = ClientView.createScale9ShaderButton("img_btn_2", function()
		arg_2_0:hide()
		lc.App:openUrl(lc.App:getAppRateUrl())
		ClientData.sendUserEvent({
			action = "goto",
			type = "rate"
		})
	end, ClientView.CRECT_BUTTON, 200)

	var_2_2:addLabel(Str(STR.RATE_GO))
	lc.addChildToPos(var_2_0, var_2_2, cc.p(lc.left(var_2_1) + lc.w(var_2_2) / 2 + 20, lc.bottom(var_2_1) - 30 - lc.h(var_2_2) / 2))

	local var_2_3 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_2_0:hide()
		var_0_1.create(var_0_1.Type.FEEDBACK):show()
		ClientData.sendUserEvent({
			action = "feedback",
			type = "rate"
		})
	end, ClientView.CRECT_BUTTON, 200)

	var_2_3:addLabel(Str(STR.RATE_ADVICE))
	lc.addChildToPos(var_2_0, var_2_3, cc.p(lc.x(var_2_2), lc.bottom(var_2_2) - 10 - lc.h(var_2_3) / 2))

	local var_2_4 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_2_0:hide()
		ClientData.sendUserEvent({
			action = "refuse",
			type = "rate"
		})
	end, ClientView.CRECT_BUTTON, 200)

	var_2_4:addLabel(Str(STR.RATE_REFUSE))
	lc.addChildToPos(var_2_0, var_2_4, cc.p(lc.x(var_2_2), lc.bottom(var_2_3) - 10 - lc.h(var_2_4) / 2))

	local var_2_5 = lc.createSprite("card_thu_0")

	lc.addChildToPos(var_2_0, var_2_5, cc.p(lc.w(var_2_0) - lc.w(var_2_5) / 2 - 40, lc.h(var_2_5) / 2 + 32))
	arg_2_0:addTouchEventListener(function()
		return
	end)
	arg_2_0._btnBack:setVisible(false)
end

return var_0_0
