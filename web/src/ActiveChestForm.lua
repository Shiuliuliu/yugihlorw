local var_0_0 = class("ActiveChestForm", BaseForm)
local var_0_1 = cc.size(760, 570)
local var_0_2 = cc.size(620, 280)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = {
		"mubaoxiang",
		"tongbaoxiang",
		"yinbaoxiang",
		"jinbaoxiang",
		"heizuanbaoxiang"
	}
	local var_2_1 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(arg_2_0._form, var_2_1, cc.p(lc.w(arg_2_0._form) / 2, lc.h(arg_2_0._form) - var_0_0.FRAME_THICK_TOP - lc.h(var_2_1) / 2))

	local var_2_2 = ClientView.createTTF(Str(STR.ACTIVE_BONUS), ClientView.FontSize.S1)

	lc.addChildToPos(var_2_1, var_2_2, cc.p(lc.w(var_2_1) / 2, 40))

	local var_2_3 = DragonBones.create(var_2_0[arg_2_1])

	var_2_3:gotoAndPlay("effect4")
	var_2_3:setScale(0.4)
	lc.addChildToPos(arg_2_0._form, var_2_3, cc.p(120, lc.bottom(var_2_1) - 40))

	local var_2_4 = 30
	local var_2_5 = ClientView.createTTF(string.format(Str(arg_2_2._info._nameSid), arg_2_2._info._val), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)

	lc.addChildToPos(arg_2_0._form, var_2_5, cc.p(lc.x(var_2_3) + 70 + lc.w(var_2_5) / 2, lc.y(var_2_3)))

	local var_2_6 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = var_0_2
	})

	lc.addChildToPos(arg_2_0._form, var_2_6, cc.p(lc.w(arg_2_0._form) / 2, lc.bottom(var_2_1) - 100 - lc.h(var_2_6) / 2))
	ClientView.addDecoratedLabel(var_2_6, Str(STR.GET) .. Str(STR.BONUS), cc.p(lc.w(var_2_6) / 2, lc.h(var_2_6) - 40), 26):setColor(lc.Color3B.white)

	local var_2_7 = arg_2_2._info._rid
	local var_2_8 = arg_2_2._info._count
	local var_2_9 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_7) do
		local var_2_10 = IconWidget.create({
			_infoId = iter_2_1,
			_count = var_2_8[iter_2_0]
		}, IconWidget.DisplayFlag.NAME)

		var_2_10._name:setColor(lc.Color3B.white)

		local var_2_11 = ClientView.createBMFont(ClientView.BMFont.huali_20, string.format("%s", ClientData.formatNum(var_2_8[iter_2_0], 9999)))

		var_2_11:setColor(lc.Color3B.white)
		lc.addChildToPos(var_2_10, var_2_11, cc.p(lc.cw(var_2_10), -16))
		table.insert(var_2_9, var_2_10)
	end

	lc.addNodesToCenter(var_2_6, var_2_9, 16, lc.h(var_2_6) / 2 + 6)
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)
end

function var_0_0.onExit(arg_4_0)
	var_0_0.super.onExit(arg_4_0)
end

return var_0_0
