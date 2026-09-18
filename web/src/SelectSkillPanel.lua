local var_0_0 = class("SelectSkillPanel", BasePanel)
local var_0_1 = cc.size(190, 250)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.init(arg_2_0, true)

	arg_2_0._callback = arg_2_2

	local var_2_0 = lc.createSprite({
		_name = "img_title_bg",
		_size = cc.size(480, 52),
		_crect = cc.rect(115, 25, 1, 1)
	})

	lc.addChildToPos(arg_2_0, var_2_0, cc.p(lc.cw(arg_2_0), lc.h(arg_2_0) - 200))

	local var_2_1 = ClientView.createTTF(Str(STR.SELECT_SKILL_TITLE), ClientView.FontSize.S1)

	lc.addChildToCenter(var_2_0, var_2_1)

	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		var_2_2[iter_2_0] = arg_2_0:createSkillItem(iter_2_1)
	end

	lc.addNodesToCenter(arg_2_0, var_2_2, 50)
end

function var_0_0.createSkillItem(arg_3_0, arg_3_1)
	local var_3_0 = ccui.Widget:create()

	var_3_0:setContentSize(var_0_1)

	local var_3_1 = lc.createImageView({
		_name = "img_com_bg_16",
		_crect = ClientView.CRECT_COM_BG16,
		_size = cc.size(var_0_1.width, var_0_1.height - 30)
	})

	lc.addChildToPos(var_3_0, var_3_1, cc.p(lc.cw(var_3_0), lc.h(var_3_0) - lc.ch(var_3_1)))

	local var_3_2 = IconWidget.createByInfoId(arg_3_1, 1, IconWidget.DisplayFlag.ITEM)

	lc.addChildToCenter(var_3_1, var_3_2)
	var_3_2:setNameColor(lc.Color3B.white)

	var_3_1._icon = var_3_2

	local var_3_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_4_0)
		arg_3_0:onSelect(arg_4_0._sid)
	end, ClientView.CRECT_BUTTON, 150)

	var_3_3:addLabel(Str(STR.SELECT))
	lc.addChildToPos(var_3_0, var_3_3, cc.p(lc.cw(var_3_1), 30))

	function var_3_0.update(arg_5_0)
		var_3_3._sid = arg_5_0
		var_3_1._icon._data._infoId = arg_5_0

		var_3_1._icon:setData(var_3_1._icon._data)
	end

	var_3_0.update(arg_3_1)

	return var_3_0
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	P._playerFindSurvivalEx:selectSkill(arg_6_1)

	local var_6_0 = arg_6_0._callback

	arg_6_0:hide()

	if var_6_0 then
		var_6_0()
	end
end

function var_0_0.onEnter(arg_7_0)
	var_0_0.super.onEnter(arg_7_0)
end

function var_0_0.onExit(arg_8_0)
	var_0_0.super.onExit(arg_8_0)
end

return var_0_0
