local var_0_0 = class("ImpeachForm", BaseForm)
local var_0_1 = cc.size(640, 650)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.UNION_IMPEACH) .. Str(STR.LEADER), var_0_0.FLAG.ADVANCE_TITLE_BG)

	arg_2_0._leader = arg_2_1

	local var_2_0 = arg_2_0._form
	local var_2_1 = lc.w(var_2_0) / 2
	local var_2_2 = ClientView.createBoldRichText(Str(STR.UNION_IMPEACH_TIP), ClientView.RICHTEXT_PARAM_LIGHT_S1, 500)

	lc.addChildToPos(var_2_0, var_2_2, cc.p(var_2_1, lc.bottom(arg_2_0._titleFrame) - 50))

	local var_2_3 = lc.createSprite({
		_name = "img_com_bg_10",
		_crect = ClientView.CRECT_COM_BG10,
		_size = cc.size(500, 270)
	})

	lc.addChildToPos(var_2_0, var_2_3, cc.p(var_2_1, lc.bottom(var_2_2) - 20 - lc.h(var_2_3) / 2))

	local var_2_4 = ClientView.addDecoratedLabel(var_2_3, Str(STR.UNION_IMPEACH_MEMBERS), cc.p(lc.w(var_2_3) / 2, lc.h(var_2_3) - 40), 26)
	local var_2_5 = P._playerUnion:getMyUnion()
	local var_2_6 = 0
	local var_2_7

	if var_2_5 then
		local var_2_8 = var_2_5._members
		local var_2_9 = lc.bottom(var_2_4) - 16

		if next(var_2_5._impeach) then
			for iter_2_0 in pairs(var_2_5._impeach) do
				local var_2_10 = var_2_8[iter_2_0]

				if var_2_10 then
					local var_2_11 = ClientView.createLevelNameArea(var_2_10._level, var_2_10._name)

					lc.addChildToPos(var_2_3, var_2_11, cc.p(130, var_2_9 - lc.h(var_2_11) / 2))

					var_2_9 = var_2_9 - lc.h(var_2_11) - 10
					var_2_6 = var_2_6 + 1
				end
			end

			var_2_7 = var_2_5._impeach[P._id] ~= nil
		else
			local var_2_12 = ClientView.createTTF(string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.UNION_MEMBER)), ClientView.FontSize.S2, ClientView.COLOR_TEXT_DARK)

			lc.addChildToPos(var_2_3, var_2_12, cc.p(lc.w(var_2_3) / 2, var_2_9 - lc.h(var_2_12) / 2))
		end
	end

	arg_2_0._impeachNum = var_2_6

	local var_2_13 = ClientView.createScale9ShaderButton("img_btn_2", function()
		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, 140)

	var_2_13:addLabel(Str(STR.BACK))
	lc.addChildToPos(var_2_0, var_2_13, cc.p(var_2_1 - 10 - lc.w(var_2_13) / 2, 10 + lc.h(var_2_13)))

	local var_2_14 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_2_0:impeach(var_2_7)
	end, ClientView.CRECT_BUTTON, 140)

	var_2_14:addLabel(var_2_7 and Str(STR.CANCEL) .. Str(STR.UNION_IMPEACH) or Str(STR.UNION_IMPEACH))
	lc.addChildToPos(var_2_0, var_2_14, cc.p(var_2_1 + 10 + lc.w(var_2_14) / 2, lc.y(var_2_13)))
end

function var_0_0.impeach(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_2 and arg_5_0._impeachNum == 4 then
		require("Dialog").showDialog(Str(STR.UNION_IMPEACH_LAST), function()
			arg_5_0:impeach(arg_5_1, true)
		end)

		return
	end

	ClientData.sendUnionImpeach(arg_5_0._leader._id, arg_5_1)
	arg_5_0:hide()
end

return var_0_0
