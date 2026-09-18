local var_0_0 = class("BuyGiftForm", BaseForm)
local var_0_1 = cc.size(680, 400)
local var_0_2 = cc.size(560, 180)

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_0.super.init(arg_2_0, var_0_1, arg_2_2, bor(BaseForm.FLAG.ADVANCE_TITLE_BG, BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form
	local var_2_1 = lc.createSprite({
		_name = "img_com_bg_10",
		_crect = ClientView.CRECT_COM_BG10,
		_size = BONUS_AREA_SIZE
	})

	lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.w(var_2_0) / 2, lc.h(var_2_0) - var_0_0.FRAME_THICK_TOP - 20 - lc.h(var_2_1) / 2))

	local var_2_2 = ClientView.createScale9ShaderButton("img_btn_1", function()
		if arg_2_4 then
			arg_2_4()
		end

		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, 140)

	var_2_2:addLabel("500")
	var_2_2:setDisabledShader(ClientView.SHADER_DISABLE)
	lc.addChildToPos(var_2_0, var_2_2, cc.p(lc.w(var_2_0) / 2, var_0_0.FRAME_THICK_BOTTOM + 20 + lc.h(var_2_2) / 2))

	arg_2_0._btnBuy = var_2_2

	local var_2_3 = cc.DragonBonesNode:createWithDecrypt("res/effects/yuanbao.lcres", "yuanbao", "yuanbao")

	var_2_3:gotoAndPlay("yuanbao")
	lc.addChildToPos(var_2_2, var_2_3, cc.p(26, lc.y(var_2_2._label)))

	local var_2_4 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_5 = IconWidget.create({
			_infoId = iter_2_1._infoId,
			_level = iter_2_1._level,
			_count = iter_2_1._count,
			_isFragment = iter_2_1._isFragment
		})

		table.insert(var_2_4, var_2_5)
	end

	P:sortResultItems(var_2_4)

	local var_2_6 = 20
	local var_2_7 = math.min(lc.w(var_2_1) - 30, (IconWidget.SIZE + var_2_6) * #var_2_4 + var_2_6)
	local var_2_8 = lc.List.createH(cc.size(var_2_7, 130), var_2_6, var_2_6)

	var_2_8:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(var_2_1, var_2_8)

	for iter_2_2, iter_2_3 in ipairs(var_2_4) do
		var_2_8:pushBackCustomItem(iter_2_3)
	end

	var_2_8:setBounceEnabled(#var_2_4 > 5)

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

	lc.addChildToPos(arg_4_0._form, var_4_0, cc.p(lc.w(arg_4_0._form) / 2, lc.top(arg_4_0._btnBuy) + 10 + lc.h(var_4_0) / 2))

	arg_4_0._tip = var_4_0
end

return var_0_0
