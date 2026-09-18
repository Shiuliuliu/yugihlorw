local var_0_0 = class("ClashChestForm", BaseForm)
local var_0_1 = cc.size(760, 570)
local var_0_2 = cc.size(620, 280)

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = ClientView.createClashFieldChest(arg_2_1, arg_2_2, arg_2_3, true)
	local var_2_1 = arg_2_0._form
	local var_2_2 = Data.getInfo(var_2_0._infoId)
	local var_2_3 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(var_2_1, var_2_3, cc.p(lc.w(var_2_1) / 2, lc.h(var_2_1) - var_0_0.FRAME_THICK_TOP - lc.h(var_2_3) / 2))

	local var_2_4 = ClientView.createTTF(Str(Data._ladderInfo[arg_2_1]._nameSid) .. Str(STR.FIND_CLASH_FIELD), ClientView.FontSize.S1)

	lc.addChildToPos(var_2_3, var_2_4, cc.p(lc.w(var_2_3) / 2, 40))
	var_2_0:setTouchEnabled(false)
	lc.addChildToPos(var_2_1, var_2_0, cc.p(130, lc.bottom(var_2_3) - lc.h(var_2_0) / 2 - 10))

	local var_2_5 = ClientView.createTTF(ClientData.getNameByInfoId(var_2_0._infoId), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)
	local var_2_6 = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = ClientView.CRECT_COM_BG2,
		_size = cc.size(400, 40)
	})

	var_2_6:setColor(lc.Color3B.black)
	var_2_6:setOpacity(100)
	lc.addChildToPos(var_2_6, var_2_5, cc.p(30 + lc.w(var_2_5) / 2, lc.h(var_2_6) / 2 - 1))
	lc.addChildToPos(var_2_1, var_2_6, cc.p(lc.right(var_2_0) - 10 + lc.w(var_2_6) / 2, lc.top(var_2_0) - lc.h(var_2_6) / 2 - 10), -1)

	local var_2_7 = 30
	local var_2_8 = ClientView.createBoldRichTextMultiLine(Str(var_2_2._descSid), ClientView.RICHTEXT_PARAM_LIGHT_S1, 480)

	lc.addChildToPos(var_2_1, var_2_8, cc.p(lc.right(var_2_0) + 20 + lc.w(var_2_8) / 2, lc.top(var_2_0) - var_2_7 - lc.h(var_2_8) / 2))

	local var_2_9 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = var_0_2
	})

	lc.addChildToPos(var_2_1, var_2_9, cc.p(lc.w(var_2_1) / 2, lc.bottom(var_2_0) - 20 - lc.h(var_2_9) / 2))
	ClientView.addDecoratedLabel(var_2_9, Str(STR.MAYBE) .. Str(STR.GET), cc.p(lc.w(var_2_9) / 2, lc.h(var_2_9) - 40), 26):setColor(lc.Color3B.white)

	local var_2_10 = var_2_0._infoId - Data.PropsId.clash_chest
	local var_2_11 = Data._ladderChestsInfo[var_2_10]
	local var_2_12 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_11._dropId) do
		local var_2_13 = IconWidget.create({
			_infoId = iter_2_1,
			_count = var_2_11._min[iter_2_0]
		}, IconWidget.DisplayFlag.NAME)

		var_2_13._name:setColor(lc.Color3B.white)

		local var_2_14 = ClientView.createBMFont(ClientView.BMFont.huali_20, string.format("%s", ClientData.formatNum(var_2_11._min[iter_2_0], 9999)))

		var_2_14:setColor(lc.Color3B.white)
		lc.addChildToPos(var_2_13, var_2_14, cc.p(lc.cw(var_2_13), -16))
		table.insert(var_2_12, var_2_13)
	end

	lc.addNodesToCenter(var_2_9, var_2_12, 16, lc.h(var_2_9) / 2 + 6)
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)
end

function var_0_0.onExit(arg_4_0)
	var_0_0.super.onExit(arg_4_0)
end

return var_0_0
