local var_0_0 = class("UnionDetailForm", BaseForm)
local var_0_1 = cc.size(870, 720)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.UNION) .. Str(STR.DETAIL), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_0 = arg_2_0._form
	local var_2_1 = require("UnionUnionArea").create(arg_2_1, var_0_1.width - var_0_0.FRAME_THICK_H, var_0_1.height - var_0_0.FRAME_THICK_V)

	lc.addChildToCenter(var_2_0, var_2_1)

	function var_2_1._callback()
		arg_2_0:hide()
		ToastManager.push(Str(STR.INVALID_UNION))
	end
end

return var_0_0
