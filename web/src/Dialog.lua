local var_0_0 = class("Dialog", BaseForm)
local var_0_1 = 700
local var_0_2 = 40
local var_0_3 = 80
local var_0_4 = 100
local var_0_5 = var_0_1 - var_0_0.FRAME_THICK_H - var_0_3
local var_0_6 = 140

function var_0_0.showDialog(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)
	var_1_0:show()

	return var_1_0
end

function var_0_0.showSelectCountDialog(...)
	local var_2_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_2_0:init(...)
	var_2_0:show()

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	ClientData.loadLCRes("res/general.lcres")

	local var_3_0 = ClientView.createBoldRichTextMultiLine(arg_3_1, ClientView.RICHTEXT_PARAM_LIGHT_S1, var_0_5)
	local var_3_1 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_3_0:close(true)
	end, ClientView.CRECT_BUTTON, var_0_6)

	var_3_1:addLabel(Str(STR.OK))

	arg_3_0._btnOk = var_3_1
	arg_3_0._okHandler = arg_3_2

	local var_3_2 = var_0_0.FRAME_THICK_V + var_0_3 + lc.h(var_3_0) + var_0_2 + lc.h(var_3_1) + (arg_3_4 and var_0_4 or 0)

	var_0_0.super.init(arg_3_0, cc.size(var_0_1, var_3_2), nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_3_0._hideBg = true

	arg_3_0._btnBack:setVisible(false)
	lc.addChildToPos(arg_3_0._form, var_3_0, cc.p(lc.w(arg_3_0._form) / 2, lc.h(arg_3_0._form) - var_0_0.TOP_MARGIN - var_0_2 - 10 - lc.h(var_3_0) / 2))

	arg_3_0._checkBoxFunc = arg_3_5

	if arg_3_5 then
		local var_3_3 = false
		local var_3_4 = ccui.CheckBox:create("img_filter_item", "img_filter", ccui.TextureResType.plistType)

		var_3_4:setSelected(var_3_3)
		lc.addChildToPos(arg_3_0._form, var_3_4, cc.p((var_0_0.FRAME_THICK_H + var_0_3) / 2, lc.ch(arg_3_0._form) + 44), 1)
		var_3_4:addEventListener(function(arg_5_0, arg_5_1)
			var_3_3 = not var_3_3

			var_3_4:setSelected(var_3_3)
		end)

		arg_3_0._checkBox = var_3_4

		lc.offset(var_3_0, 10, 0)

		local var_3_5 = ClientView.createShaderButton(nil, arg_3_5)

		var_3_5:setContentSize(var_3_0:getContentSize())
		lc.addChildToPos(var_3_0:getParent(), var_3_5, cc.p(var_3_0:getPosition()))
	end

	local var_3_6 = var_0_0.BOTTOM_MARGIN + var_0_2 + var_0_4 / 2 + 70

	if arg_3_4 then
		local var_3_7 = require("SelectCountWidget").create(nil, nil, arg_3_4)

		lc.addChildToPos(arg_3_0._form, var_3_7, cc.p(lc.cw(arg_3_0._form), var_3_6))

		arg_3_0._selectCountWidget = var_3_7
	end

	local var_3_8 = var_0_0.BOTTOM_MARGIN + var_0_2

	lc.addChildToPos(arg_3_0._form, var_3_1, cc.p(0, var_3_8 + lc.h(var_3_1) / 2 - 10))

	if arg_3_3 then
		var_3_1:setPositionX(lc.x(var_3_0))
		arg_3_0:addTouchEventListener(function()
			return
		end)
	else
		var_3_1:setPositionX(lc.x(var_3_0) + 20 + var_0_6 / 2)

		local var_3_9 = ClientView.createScale9ShaderButton("img_btn_2", function()
			arg_3_0:close()
		end, ClientView.CRECT_BUTTON, var_0_6)

		var_3_9:addLabel(Str(STR.CANCEL))
		lc.addChildToPos(arg_3_0._form, var_3_9, cc.p(lc.x(var_3_0) - 20 - var_0_6 / 2, lc.y(var_3_1)))

		arg_3_0._btnCancel = var_3_9
	end
end

function var_0_0.show(arg_8_0, arg_8_1)
	var_0_0.super.show(arg_8_0, arg_8_1)
	arg_8_0:setLocalZOrder(ClientData.ZOrder.dialog)
end

function var_0_0.hide(arg_9_0)
	var_0_0.super.hide(arg_9_0)

	if arg_9_0._cancelHandler then
		arg_9_0._cancelHandler()
	end
end

function var_0_0.close(arg_10_0, arg_10_1)
	if arg_10_1 and arg_10_0._checkBoxFunc and not arg_10_0._checkBox:isSelected() then
		return ToastManager.push(Str(STR.SELECT_CLOSE_ACCOUNT))
	end

	arg_10_0._closeCount = (arg_10_0._closeCount or 0) + 1

	if arg_10_1 and arg_10_0._checkBoxFunc and arg_10_0._closeCount < 3 then
		return ToastManager.push(string.format(Str(STR.CONFIRM_TO_CLOSE_ACCOUNT), 3 - arg_10_0._closeCount))
	end

	arg_10_0._btnOk:setEnabled(false)

	if arg_10_0._btnCancel then
		arg_10_0._btnCancel:setEnabled(false)
	end

	arg_10_0:hide()

	if arg_10_1 and arg_10_0._okHandler then
		arg_10_0._okHandler(arg_10_0)
	end
end

return var_0_0
