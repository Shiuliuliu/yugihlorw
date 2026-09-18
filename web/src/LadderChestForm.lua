local var_0_0 = class("LadderChestForm", BaseForm)
local var_0_1 = cc.size(760, 570)
local var_0_2 = cc.size(620, 280)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form
	local var_2_1 = {
		"mubaoxiang",
		"tongbaoxiang",
		"yinbaoxiang",
		"jinbaoxiang",
		"heizuanbaoxiang"
	}
	local var_2_2 = Data._propsInfo[arg_2_1]
	local var_2_3 = DragonBones.create(var_2_1[var_2_2._picId - 7820 + 1])

	lc.addChildToPos(var_2_0, var_2_3, cc.p(150, lc.h(var_2_0) - 140))
	var_2_3:setScale(0.6)
	var_2_3:gotoAndPlay("effect4")

	local var_2_4 = ClientView.createTTF(Str(var_2_2._descSid), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(440, 0))

	lc.addChildToPos(var_2_0, var_2_4, cc.p(lc.x(var_2_3) + lc.cw(var_2_4) + 100, lc.y(var_2_3)))

	local var_2_5 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = var_0_2
	})

	lc.addChildToPos(var_2_0, var_2_5, cc.p(lc.w(var_2_0) / 2, lc.h(var_2_5) / 2 + 60))
	ClientView.addDecoratedLabel(var_2_5, Str(STR.MAYBE) .. Str(STR.GET), cc.p(lc.w(var_2_5) / 2, lc.h(var_2_5) - 40), 26):setColor(lc.Color3B.white)

	local var_2_6

	if arg_2_1 < Data.PropsId.clash_ex_chest then
		var_2_6 = arg_2_1 - Data.PropsId.ladder_chest + 100
	else
		var_2_6 = arg_2_1 - Data.PropsId.clash_ex_chest + 201
	end

	local var_2_7 = Data._ladderChestsInfo[var_2_6]
	local var_2_8 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_7._dropId) do
		local var_2_9
		local var_2_10
		local var_2_11

		if var_2_7._min[iter_2_0] ~= var_2_7._max[iter_2_0] then
			var_2_9 = IconWidget.create({
				_showOwnCount = true,
				_infoId = iter_2_1,
				_param = {
					_min = var_2_7._min[iter_2_0],
					_max = var_2_7._max[iter_2_0]
				}
			}, IconWidget.DisplayFlag.NAME)
			var_2_11 = ClientView.createBMFont(ClientView.BMFont.huali_20, string.format("%s-%s", ClientData.formatNum(var_2_7._min[iter_2_0], 9999), ClientData.formatNum(var_2_7._max[iter_2_0], 9999)))
		else
			var_2_9 = IconWidget.create({
				_infoId = iter_2_1,
				_count = var_2_7._min[iter_2_0]
			}, IconWidget.DisplayFlag.NAME)
			var_2_11 = ClientView.createBMFont(ClientView.BMFont.huali_20, ClientData.formatNum(var_2_7._min[iter_2_0], 9999))
		end

		var_2_9._name:setColor(lc.Color3B.white)
		var_2_11:setColor(lc.Color3B.white)
		lc.addChildToPos(var_2_9, var_2_11, cc.p(lc.cw(var_2_9), -16))
		table.insert(var_2_8, var_2_9)
	end

	lc.addNodesToCenter(var_2_5, var_2_8, 16, lc.h(var_2_5) / 2 + 6)
end

return var_0_0
