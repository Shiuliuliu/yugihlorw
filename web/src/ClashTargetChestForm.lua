local var_0_0 = class("ClashTargetChestForm", BaseForm)
local var_0_1 = cc.size(760, 570)
local var_0_2 = cc.size(620, 280)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form
	local var_2_1 = P._playerBonus._bonusClashTarget[arg_2_1]
	local var_2_2 = ClientView.createClashTargetChest(arg_2_1)
	local var_2_3 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(var_2_0, var_2_3, cc.p(lc.w(var_2_0) / 2, lc.h(var_2_0) - var_0_0.FRAME_THICK_TOP - lc.h(var_2_3) / 2))

	local var_2_4 = ClientView.createTTF(Str(STR.FIND_CLASH_SEASON_TARGET), ClientView.FontSize.S1)

	lc.addChildToPos(var_2_3, var_2_4, cc.p(lc.w(var_2_3) / 2, 40))
	var_2_2:setTouchEnabled(false)
	lc.addChildToPos(var_2_0, var_2_2, cc.p(130, lc.bottom(var_2_3) - lc.h(var_2_2) / 2 - 10))

	local var_2_5 = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = ClientView.CRECT_COM_BG2,
		_size = cc.size(400, 40)
	})

	var_2_5:setColor(lc.Color3B.black)
	var_2_5:setOpacity(100)
	lc.addChildToPos(var_2_0, var_2_5, cc.p(lc.right(var_2_2) - 10 + lc.w(var_2_5) / 2, lc.top(var_2_2) - lc.h(var_2_5) / 2 - 10), -1)

	local var_2_6 = 30
	local var_2_7 = ClientView.createTTF(string.format(Str(var_2_1._info._nameSid), var_2_1._info._val), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(440, 0))

	lc.addChildToPos(var_2_0, var_2_7, cc.p(lc.right(var_2_2) + 20 + lc.w(var_2_7) / 2, lc.top(var_2_2) - var_2_6 - lc.h(var_2_7) / 2))

	local var_2_8 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = var_0_2
	})

	lc.addChildToPos(var_2_0, var_2_8, cc.p(lc.w(var_2_0) / 2, lc.bottom(var_2_2) - 20 - lc.h(var_2_8) / 2))

	local var_2_9 = {}

	for iter_2_0 = 1, #var_2_1._info._rid do
		local var_2_10 = IconWidget.create({
			_infoId = var_2_1._info._rid[iter_2_0],
			_count = var_2_1._info._count[iter_2_0]
		}, IconWidget.DisplayFlag.NAME)

		var_2_10._name:setColor(lc.Color3B.white)

		local var_2_11 = ClientView.createBMFont(ClientView.BMFont.huali_20, string.format("%s", ClientData.formatNum(var_2_1._info._count[iter_2_0], 9999)))

		var_2_11:setColor(lc.Color3B.white)
		lc.addChildToPos(var_2_10, var_2_11, cc.p(lc.cw(var_2_10), -16))
		table.insert(var_2_9, var_2_10)
	end

	lc.addNodesToCenter(var_2_8, var_2_9, 16, lc.h(var_2_8) / 2 + 6)
end

return var_0_0
