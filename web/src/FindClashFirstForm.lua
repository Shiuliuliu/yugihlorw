local var_0_0 = class("FindClashFirstForm", BaseForm)
local var_0_1 = cc.size(640, 400)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form
	local var_2_1 = P._playerFindClash
	local var_2_2 = lc.w(var_2_0) / 2
	local var_2_3 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(var_2_0, var_2_3, cc.p(var_2_2, lc.h(var_2_0) - var_0_0.FRAME_THICK_TOP - lc.h(var_2_3) / 2))

	local var_2_4 = Str(Data._ladderInfo[var_2_1._grade]._nameSid)
	local var_2_5 = ClientView.createTTF(var_2_4 .. Str(STR.FIND_CLASH_FIELD), ClientView.FontSize.S1)

	lc.addChildToPos(var_2_3, var_2_5, cc.p(lc.w(var_2_3) / 2, 32))

	local var_2_6 = ClientView.createBoldRichText(Str(STR.FIND_CLASH_FIRST_TIP1), ClientView.RICHTEXT_PARAM_LIGHT_S1, 500)

	lc.addChildToPos(var_2_0, var_2_6, cc.p(var_2_2, lc.bottom(var_2_3) - 20 - lc.h(var_2_6) / 2))

	local var_2_7 = string.format(Str(STR.FIND_CLASH_FIRST_TIP2), P._level, var_2_1._trophy, var_2_4)
	local var_2_8 = ClientView.createBoldRichTextWithIcons(var_2_7, ClientView.RICHTEXT_PARAM_LIGHT_S1, 500)

	lc.addChildToPos(var_2_0, var_2_8, cc.p(var_2_2, lc.bottom(var_2_6) - 20 - lc.h(var_2_8) / 2))

	local var_2_9 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, 140)

	var_2_9:addLabel(Str(STR.OK))
	lc.addChildToPos(var_2_0, var_2_9, cc.p(var_2_2, lc.bottom(var_2_8) - 24 - lc.h(var_2_9) / 2))
end

return var_0_0
