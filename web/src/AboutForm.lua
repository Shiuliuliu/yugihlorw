local var_0_0 = class("AboutForm", BaseForm)
local var_0_1 = cc.size(600, 540)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0._resNames = ClientData.loadLCRes("res/about.lcres")

	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form
	local var_2_1 = arg_2_0:createCopyRight()

	lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.w(var_2_0) / 2, lc.h(var_2_0) - var_0_0.FRAME_THICK_TOP - 48 - lc.h(var_2_1) / 2))

	local var_2_2 = arg_2_0:createSpecialThanks()

	lc.addChildToPos(var_2_0, var_2_2, cc.p(lc.w(var_2_0) / 2, lc.bottom(var_2_1) - 40 - lc.h(var_2_2) / 2))
end

function var_0_0.onCleanup(arg_3_0)
	var_0_0.super.onCleanup(arg_3_0)
	ClientData.unloadLCRes(arg_3_0._resNames)
end

function var_0_0.createCopyRight(arg_4_0)
	local var_4_0 = lc.createNode(cc.size(lc.w(arg_4_0._form) - 100, 180))
	local var_4_1 = ClientView.addDecoratedLabel(var_4_0, Str(STR.COPYRIGHT), cc.p(lc.w(var_4_0) / 2, lc.h(var_4_0) - 20), 26):getParent()
	local var_4_2 = lc.createSprite("about_logo_leocool")

	lc.addChildToPos(var_4_0, var_4_2, cc.p(lc.x(var_4_1), lc.bottom(var_4_1) - 20 - lc.h(var_4_2) / 2))

	local var_4_3 = ClientView.createTTF(Str(STR.COPYRIGHT_OWNER_CN), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)

	lc.addChildToPos(var_4_0, var_4_3, cc.p(lc.x(var_4_1), lc.bottom(var_4_2) - 6 - lc.h(var_4_3) / 2))

	return var_4_0
end

function var_0_0.createSpecialThanks(arg_5_0)
	local var_5_0 = lc.createNode(cc.size(lc.w(arg_5_0._form) - 100, 180))
	local var_5_1 = ClientView.addDecoratedLabel(var_5_0, Str(STR.SPECIAL_THANKS), cc.p(lc.w(var_5_0) / 2, lc.h(var_5_0) - 20), 26):getParent()
	local var_5_2 = lc.bottom(var_5_1) - 20

	local function var_5_3(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = ClientView.createTTF(arg_6_0, ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)

		lc.addChildToPos(var_5_0, var_6_0, cc.p(arg_6_2, var_5_2 - lc.h(var_6_0) / 2))

		local var_6_1 = lc.createSprite(arg_6_1)

		lc.addChildToPos(var_5_0, var_6_1, cc.p(arg_6_2, lc.bottom(var_6_0) - 6 - lc.h(var_6_1) / 2))
	end

	local var_5_4 = lc.w(var_5_0) / 2

	var_5_3(Str(STR.TECHNOLOGY_ENGINE), "about_logo_cocos2dx", var_5_4 - 160)
	var_5_3(Str(STR.IMAGE_DESIGN), "about_logo_shengtang", var_5_4)
	var_5_3(Str(STR.AUDIO_DEVELOP), "about_logo_guangyun", var_5_4 + 160)

	return var_5_0
end

return var_0_0
