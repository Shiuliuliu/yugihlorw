local var_0_0 = class("ClaimForm", BaseForm)
local var_0_1 = cc.size(560, 180)

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = type(arg_2_1) == "number" and Data._bonusInfo[arg_2_1] or arg_2_1._info
	local var_2_1 = lc.createSprite({
		_name = "img_com_bg_10",
		_crect = ClientView.CRECT_COM_BG10,
		_size = var_0_1
	})
	local var_2_2 = ClientView.createScale9ShaderButton("img_btn_1", function()
		if arg_2_4 then
			arg_2_4()
		end

		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, 140)

	var_2_2:addLabel(Str(STR.CLAIM))
	var_2_2:setDisabledShader(ClientView.SHADER_DISABLE)
	var_2_2:setEnabled(arg_2_4 ~= nil)

	local var_2_3 = var_0_1.width + 40 + var_0_0.FRAME_THICK_H
	local var_2_4 = var_0_1.height + 60 + var_0_0.FRAME_THICK_V + lc.h(var_2_2)

	if arg_2_3 then
		var_2_4 = var_2_4 + 50
	end

	var_0_0.super.init(arg_2_0, cc.size(var_2_3, var_2_4), arg_2_2, bor(BaseForm.FLAG.ADVANCE_TITLE_BG, BaseForm.FLAG.PAPER_BG))

	local var_2_5 = arg_2_0._form

	lc.addChildToPos(var_2_5, var_2_1, cc.p(lc.w(var_2_5) / 2, var_2_4 - var_0_0.FRAME_THICK_TOP - 20 - lc.h(var_2_1) / 2))
	lc.addChildToPos(var_2_5, var_2_2, cc.p(lc.w(var_2_5) / 2, var_0_0.FRAME_THICK_BOTTOM + 20 + lc.h(var_2_2) / 2))

	arg_2_0._btnClaim = var_2_2

	local var_2_6 = {}

	for iter_2_0 = 1, #var_2_0._rid do
		local var_2_7 = IconWidget.create({
			_infoId = var_2_0._rid[iter_2_0],
			_level = var_2_0._level[iter_2_0],
			_count = var_2_0._count[iter_2_0],
			_isFragment = var_2_0._isFragment[iter_2_0] > 0
		})

		table.insert(var_2_6, var_2_7)
	end

	P:sortResultItems(var_2_6)

	local var_2_8 = 20
	local var_2_9 = math.min(lc.w(var_2_1) - 30, (IconWidget.SIZE + var_2_8) * #var_2_6 + var_2_8)
	local var_2_10 = lc.List.createH(cc.size(var_2_9, 130), var_2_8, var_2_8)

	var_2_10:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(var_2_1, var_2_10)

	for iter_2_1, iter_2_2 in ipairs(var_2_6) do
		var_2_10:pushBackCustomItem(iter_2_2)
	end

	var_2_10:setBounceEnabled(#var_2_6 > 5)

	if arg_2_3 then
		arg_2_0:updateTip(arg_2_3)
	end
end

function var_0_0.updateTip(arg_4_0, arg_4_1)
	if arg_4_0._tip then
		arg_4_0._tip:removeFromParent()

		arg_4_0._tip = nil
	end

	local var_4_0 = ClientView.createBoldRichText(arg_4_1, ClientView.RICHTEXT_PARAM_DARK_S1)

	lc.addChildToPos(arg_4_0._form, var_4_0, cc.p(lc.w(arg_4_0._form) / 2, lc.top(arg_4_0._btnClaim) + 10 + lc.h(var_4_0) / 2))

	arg_4_0._tip = var_4_0
end

return var_0_0
