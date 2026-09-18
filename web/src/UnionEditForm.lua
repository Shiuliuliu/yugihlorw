local var_0_0 = class("UnionEditForm", BaseForm)
local var_0_1 = require("UnionCreateArea")
local var_0_2 = cc.size(960, 720)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_2, Str(STR.CHANGE) .. Str(STR.UNION) .. Str(STR.INFO), 0)

	local var_2_0 = var_0_1.create(var_0_1.Mode.edit, lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT)

	lc.addChildToCenter(arg_2_0._frame, var_2_0, -1)
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	arg_3_0._listener = lc.addEventListener(Data.Event.union_edit_dirty, function()
		arg_3_0:hide()
	end)
end

function var_0_0.onExit(arg_5_0)
	var_0_0.super.onExit(arg_5_0)
	lc.Dispatcher:removeEventListener(arg_5_0._listener)
end

return var_0_0
