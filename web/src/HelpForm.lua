local var_0_0 = class("HelpForm", BaseForm)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.init(arg_2_0, cc.size(800, 600), arg_2_1 or Str(STR.HELP), 0)

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN, lc.bottom(arg_2_0._titleFrame) - var_0_0.BOTTOM_MARGIN + 10), 20, 30)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0._form, var_2_0, cc.p(lc.w(arg_2_0._form) / 2, lc.bottom(arg_2_0._titleFrame) - lc.h(var_2_0) / 2 + 8))

	for iter_2_0 = 1, #arg_2_2 do
		local var_2_1 = ccui.Widget:create()

		var_2_1:setContentSize(lc.w(var_2_0) - 80, 0)

		local var_2_2 = cc.Label:createWithTTF(string.format("%d.", iter_2_0), ClientView.TTF_FONT, ClientView.FontSize.S1)

		var_2_2:setColor(ClientView.COLOR_TEXT_LIGHT)
		var_2_1:addChild(var_2_2)

		local var_2_3

		if string.find(arg_2_2[iter_2_0], "|") then
			var_2_3 = ccui.RichTextEx:create()

			var_2_3:setMaxWidth(lc.w(var_2_1) - 60)

			local var_2_4 = string.splitByChar(arg_2_2[iter_2_0], "|")
			local var_2_5 = 1
			local var_2_6 = {}

			for iter_2_1 = 1, #var_2_4 do
				local var_2_7 = string.find(var_2_4[iter_2_1], "%[")
				local var_2_8 = string.find(var_2_4[iter_2_1], "%]")

				if var_2_7 and var_2_8 then
					local var_2_9 = string.sub(var_2_4[iter_2_1], var_2_7 + 1, var_2_8 - 1)
					local var_2_10 = lc.createSprite(var_2_9)

					table.insert(var_2_6, var_2_10)
					var_2_3:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, var_2_10))
					var_2_3:insertElement(ccui.RichItemLabel:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(STR[string.format("SKILL_TYPE_%d", tonumber(var_2_9[#var_2_9]))]) .. "          ", ClientView.TTF_FONT, ClientView.FontSize.S1))

					if var_2_5 % 2 == 0 then
						var_2_3:insertNewLine()
					end

					var_2_5 = var_2_5 + 1
				else
					var_2_3:insertElement(ccui.RichItemLabel:create(0, ClientView.COLOR_TEXT_LIGHT, 255, var_2_4[iter_2_1], ClientView.TTF_FONT, ClientView.FontSize.S1))
					var_2_3:insertNewLine()
				end
			end

			var_2_3:formatText()

			for iter_2_2, iter_2_3 in ipairs(var_2_6) do
				lc.offset(iter_2_3, 0, -10)
			end
		else
			var_2_3 = ClientView.createTTF(arg_2_2[iter_2_0] .. "\n", ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(lc.w(var_2_1) - 60, 0))
		end

		var_2_1:addChild(var_2_3)
		var_2_1:setContentSize(lc.w(var_2_1), lc.h(var_2_3))
		var_2_2:setPosition(lc.w(var_2_2) / 2, lc.h(var_2_1) - lc.h(var_2_2) / 2)
		var_2_3:setPosition(lc.w(var_2_3) / 2 + 40, lc.h(var_2_1) / 2)

		if iter_2_0 < #arg_2_2 then
			local var_2_11 = ClientView.createDividingLine(lc.w(var_2_1), ClientView.COLOR_DIVIDING_LINE_LIGHT)

			var_2_11:setPosition(lc.w(var_2_1) / 2, -12)
			var_2_11:setOpacity(128)
			var_2_1:addChild(var_2_11)
		end

		var_2_0:pushBackCustomItem(var_2_1)
	end
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	if GuideManager.isGuideEnabled() then
		GuideManager.pauseGuide()
	end
end

function var_0_0.onExit(arg_4_0)
	var_0_0.super.onExit(arg_4_0)

	if GuideManager.isGuideEnabled() then
		GuideManager.resumeGuide()
	end
end

return var_0_0
