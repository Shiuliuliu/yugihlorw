local var_0_0 = class("AncientShopForm", BaseForm)
local var_0_1 = cc.size(860, 690)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._isShowResourceUI = true

	local var_2_0 = arg_2_0._form
	local var_2_1 = require("AncientShopArea").create(var_0_1.width - 20, var_0_1.height, arg_2_1)

	lc.addChildToCenter(arg_2_0._frame, var_2_1, -1)
	lc.offset(var_2_1, 0, -20)
	ClientView.getResourceUI():setMode(Data.PropsId.special_common_fragment)
end

function var_0_0.onCleanup(arg_3_0)
	var_0_0.super.onCleanup(arg_3_0)
end

return var_0_0
