local var_0_0 = class("SkillForm", BaseForm)
local var_0_1 = 720
local var_0_2 = cc.size(200, 320)
local var_0_3 = {
	_fontSize = ClientView.FontSize.S1,
	_curColor = ClientView.COLOR_TEXT_LIGHT,
	_nextColor = ClientView.COLOR_TEXT_GREEN_DARK
}

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = Data._skillInfo[arg_2_1]

	arg_2_0._skillInfo = var_2_0
	arg_2_0._skillLevel = arg_2_2

	local var_2_1 = arg_2_0:createSkillArea(CardHelper.getSkillMaxLevel(arg_2_1))
	local var_2_2 = lc.h(var_2_1)
	local var_2_3 = arg_2_0:createSkillArea(arg_2_2, var_2_2)
	local var_2_4 = var_2_0._refSkills
	local var_2_5 = 0
	local var_2_6 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_4) do
		if iter_2_1 > 100 and iter_2_1 < 20000 then
			var_2_5 = var_2_5 + 1
		elseif iter_2_1 > 0 and iter_2_1 <= 100 then
			var_2_6 = var_2_6 + 1
		end
	end

	local var_2_7 = var_2_2 + var_0_0.FRAME_THICK_V + 80

	if var_2_5 > 0 then
		var_2_7 = var_2_7 + 64 + math.floor((var_2_5 + 1) / 2) * 54
	end

	if var_2_6 > 0 then
		var_2_7 = var_2_7 + 64 + var_2_6 * 54
	end

	local var_2_8 = {}
	local var_2_9 = 0

	for iter_2_2, iter_2_3 in ipairs(var_2_0._refCards) do
		if iter_2_3 > 10000 and iter_2_3 < 50000 then
			var_2_9 = var_2_9 + 1
			var_2_8[#var_2_8 + 1] = iter_2_3
		end
	end

	if var_2_9 > 0 then
		var_2_7 = var_2_7 + 30 + 140 * (math.floor((var_2_9 - 1) / 5) + 1)
	end

	var_0_0.super.init(arg_2_0, cc.size(var_0_1, var_2_7), nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_10 = arg_2_0._form

	lc.addChildToPos(var_2_10, var_2_3, cc.p(var_0_1 / 2, var_2_7 - var_0_0.FRAME_THICK_TOP - 30 - var_2_2 / 2))

	arg_2_0._skillArea = var_2_3
	arg_2_0._maxLevel = CardHelper.getSkillMaxLevel(arg_2_1)

	local var_2_11 = lc.bottom(var_2_3)

	if var_2_5 > 0 then
		local var_2_12 = lc.createSprite("img_divide_line_8")

		var_2_12:setScale((lc.w(var_2_10) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT) / lc.w(var_2_12), 1)
		lc.addChildToPos(var_2_10, var_2_12, cc.p(lc.w(var_2_10) / 2, var_2_11 - 10))

		local var_2_13 = cc.Label:createWithTTF(Str(STR.SKILL_REF), ClientView.TTF_FONT, ClientView.FontSize.M1)

		var_2_13:setColor(ClientView.COLOR_TEXT_ORANGE)
		lc.addChildToPos(var_2_10, var_2_13, cc.p(var_0_1 / 2, var_2_11 - 40), 60)

		local var_2_14 = lc.bottom(var_2_13) - 16
		local var_2_15

		if var_2_5 == 1 then
			var_2_15 = true
		end

		local var_2_16 = cc.rect(ClientView.CRECT_COM_BG5.x, 0, ClientView.CRECT_COM_BG5.width, lc.frameSize("img_com_bg_5").height)
		local var_2_17 = 1

		for iter_2_4, iter_2_5 in ipairs(var_2_4) do
			if iter_2_5 > 100 and iter_2_5 < 20000 then
				local var_2_18 = ClientView.createScale9ShaderButton("img_com_bg_5", function()
					var_0_0.create(iter_2_5, 1):show()
				end, var_2_16, 220)
				local var_2_19, var_2_20 = ClientView.getSkillDisplayInfo(iter_2_5, 1)
				local var_2_21 = ClientView.createTTF(var_2_20, ClientView.FontSize.S1)

				lc.addChildToCenter(var_2_18, var_2_21)

				local var_2_22 = var_2_17 % 2 == 1
				local var_2_23 = var_0_1 / 2 + (var_2_15 and 0 or var_2_22 and -120 or 120)

				lc.addChildToPos(var_2_10, var_2_18, cc.p(var_2_23, var_2_14 - lc.h(var_2_18) / 2))

				if not var_2_22 then
					var_2_14 = var_2_14 - 54
				end

				var_2_17 = var_2_17 + 1
			end
		end

		var_2_11 = var_2_11 - 64 - math.floor((var_2_5 + 1) / 2) * 54
	end

	if var_2_6 > 0 then
		local var_2_24 = lc.createSprite("img_divide_line_8")

		var_2_24:setScale((lc.w(var_2_10) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT) / lc.w(var_2_24), 1)
		lc.addChildToPos(var_2_10, var_2_24, cc.p(lc.w(var_2_10) / 2, var_2_11 - 10))

		local var_2_25 = cc.Label:createWithTTF(Str(STR.SKILL_STATUS_REF), ClientView.TTF_FONT, ClientView.FontSize.M1)

		var_2_25:setColor(ClientView.COLOR_TEXT_ORANGE)
		lc.addChildToPos(var_2_10, var_2_25, cc.p(var_0_1 / 2, var_2_11 - 40), 60)

		local var_2_26 = lc.bottom(var_2_25) - 16
		local var_2_27

		for iter_2_6, iter_2_7 in ipairs(var_2_4) do
			if iter_2_7 > 0 and iter_2_7 < 100 then
				local var_2_28 = ClientView.createBoldRichText(Str(STR.SKILL_STATUS1 + iter_2_7 - 1), ClientView.RICHTEXT_PARAM_LIGHT_S2)
				local var_2_29 = var_0_1 / 2

				lc.addChildToPos(var_2_10, var_2_28, cc.p(var_2_29, var_2_26 - lc.h(var_2_28) / 2))

				var_2_26 = var_2_26 - 40
			end
		end

		var_2_11 = var_2_11 - 64 - math.floor((var_2_6 + 1) / 2) * 54
	end

	if var_2_9 > 0 then
		local var_2_30 = lc.createSprite("img_divide_line_8")

		var_2_30:setScale((lc.w(var_2_10) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT) / lc.w(var_2_30), 1)
		lc.addChildToPos(var_2_10, var_2_30, cc.p(lc.w(var_2_10) / 2, var_2_11 - 10))

		local var_2_31 = cc.Label:createWithTTF(Str(STR.SKILL_CARD_REF), ClientView.TTF_FONT, ClientView.FontSize.M1)

		var_2_31:setColor(ClientView.COLOR_TEXT_ORANGE)
		lc.addChildToPos(var_2_10, var_2_31, cc.p(var_0_1 / 2, var_2_11 - 40), 60)

		local var_2_32 = 100
		local var_2_33 = 20
		local var_2_34 = math.floor((var_2_9 - 1) / 5) + 1

		for iter_2_8 = 1, var_2_34 do
			local var_2_35 = math.min(5, var_2_9 - (iter_2_8 - 1) * 5)
			local var_2_36 = (lc.w(var_2_10) - var_2_35 * var_2_32 - (var_2_35 - 1) * var_2_33) / 2
			local var_2_37 = lc.bottom(var_2_31) - 8 - (iter_2_8 - 1) * 140

			for iter_2_9 = 1, var_2_35 do
				local var_2_38 = IconWidget.create({
					_infoId = var_2_8[(iter_2_8 - 1) * 5 + iter_2_9]
				})

				var_2_38._name:setColor(ClientView.COLOR_BMFONT)
				lc.addChildToPos(var_2_10, var_2_38, cc.p(var_2_36 + var_2_32 / 2, var_2_37 - lc.ch(var_2_38)))

				var_2_36 = var_2_36 + var_2_32 + var_2_33
			end
		end
	end
end

function var_0_0.createSkillArea(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = lc.createNode()

	var_4_0:setCascadeOpacityEnabled(true)

	local var_4_1 = arg_4_0._skillInfo
	local var_4_2 = Data.getSkillType(var_4_1._id)
	local var_4_3 = lc.createSprite(string.format("img_icon_skill_%d", var_4_2))
	local var_4_4 = ClientView.createSkillDesc(var_4_1._id, arg_4_1, nil, 500, var_0_3)

	var_4_0._desc = var_4_4
	arg_4_2 = arg_4_2 or lc.h(var_4_3) + lc.h(var_4_4) + 50

	var_4_0:setContentSize(lc.w(var_4_4), arg_4_2)
	lc.addChildToPos(var_4_0, var_4_3, cc.p(lc.w(var_4_0) / 2 - 120, arg_4_2 - lc.h(var_4_3) / 2))

	local var_4_5 = cc.rect(ClientView.CRECT_COM_BG5.x, 0, ClientView.CRECT_COM_BG5.width, lc.frameSize("img_com_bg_5").height)
	local var_4_6 = ClientView.createScale9ShaderButton("img_com_bg_5", function()
		arg_4_0:onShowSkills()
	end, var_4_5, 220)
	local var_4_7, var_4_8 = ClientView.getSkillDisplayInfo(var_4_1._id, arg_4_1)
	local var_4_9 = ClientView.createTTF(var_4_8, ClientView.FontSize.S1)

	lc.addChildToCenter(var_4_6, var_4_9)
	var_4_6:setCascadeOpacityEnabled(true)

	var_4_6._label = var_4_9
	var_4_0._btn = var_4_6

	lc.addChildToPos(var_4_0, var_4_6, cc.p(lc.right(var_4_3) + 10 + lc.w(var_4_6) / 2, lc.y(var_4_3)))

	if var_4_1._val[1] == 0 then
		var_4_6:setEnabled(false)
		var_4_6:setColor(lc.Color3B.gray)
	end

	local var_4_10 = Str(STR[string.format("SKILL_TYPE_%d", var_4_2)])
	local var_4_11 = ClientView.createTTF(var_4_10, nil, ClientView.COLOR_LABEL_LIGHT)

	lc.addChildToPos(var_4_0, var_4_11, cc.p(lc.w(var_4_0) / 2, lc.bottom(var_4_3) - 4 - lc.h(var_4_11) / 2))
	lc.addChildToPos(var_4_0, var_4_4, cc.p(lc.w(var_4_0) / 2, lc.bottom(var_4_11) - 20 - lc.h(var_4_4) / 2))

	return var_4_0
end

function var_0_0.onShowSkills(arg_6_0)
	return
end

function var_0_0.onSelectSkill(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._skillLevel then
		return
	end

	arg_7_0._skillLevel = arg_7_1

	local var_7_0 = arg_7_0._skillInfo._id
	local var_7_1, var_7_2 = ClientView.getSkillDisplayInfo(var_7_0, arg_7_1)

	arg_7_0._skillArea._btn._label:setString(var_7_2)

	local var_7_3 = arg_7_0._skillArea._desc
	local var_7_4, var_7_5 = var_7_3:getPosition()

	var_7_3:removeFromParent()

	local var_7_6 = ClientView.createSkillDesc(var_7_0, arg_7_1, nil, 300, var_0_3)

	lc.addChildToPos(arg_7_0._skillArea, var_7_6, cc.p(var_7_4, var_7_5))

	arg_7_0._skillArea._desc = var_7_6
end

function var_0_0.onBtnArrow(arg_8_0, arg_8_1)
	arg_8_0._skillArea._btn:setEnabled(false)
	arg_8_0._btnArrowLeft:setVisible(true)
	arg_8_0._btnArrowRight:setVisible(true)

	local var_8_0 = lc.x(arg_8_0._skillArea) - lc.w(arg_8_0._skillArea) / 2
	local var_8_1 = lc.w(arg_8_0._form) / 2
	local var_8_2 = lc.y(arg_8_0._skillArea)
	local var_8_3
	local var_8_4

	if arg_8_1 == arg_8_0._btnArrowLeft then
		var_8_3 = arg_8_0._skillLevel - 1
		var_8_4 = arg_8_0:createSkillArea(arg_8_0._skillLevel - 1)
	else
		var_8_3 = arg_8_0._skillLevel + 1
		var_8_4 = arg_8_0:createSkillArea(arg_8_0._skillLevel + 1)
		var_8_0 = -var_8_0
	end

	arg_8_0._btnArrowLeft:setVisible(var_8_3 ~= 1)
	arg_8_0._btnArrowRight:setVisible(var_8_3 ~= arg_8_0._maxLevel)
	var_8_4._btn:setEnabled(false)
	var_8_4:setOpacity(0)
	lc.addChildToPos(arg_8_0._form, var_8_4, cc.p(var_8_1 - var_8_0, var_8_2))

	local var_8_5 = arg_8_0._skillArea
	local var_8_6 = lc.absTime(0.2)

	var_8_5:stopAllActions()
	var_8_5:runAction(lc.sequence({
		lc.moveTo(var_8_6, var_8_1 + var_8_0, var_8_2),
		lc.fadeOut(var_8_6)
	}, lc.remove()))
	var_8_4:runAction(lc.sequence({
		lc.moveTo(var_8_6, var_8_1, var_8_2),
		lc.fadeIn(var_8_6)
	}, function()
		var_8_4._btn:setEnabled(true)
	end))

	arg_8_0._skillArea = var_8_4
	arg_8_0._skillLevel = var_8_3
end

return var_0_0
