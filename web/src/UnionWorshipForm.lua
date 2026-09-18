local var_0_0 = class("UnionWorshipForm", BaseForm)
local var_0_1 = cc.size(800, 460)
local var_0_2 = cc.size(172, 240)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.SELECT_WORSHIP), bor(BaseForm.FLAG.BASE_TITLE_BG, BaseForm.FLAG.PAPER_BG))

	arg_2_0._member = arg_2_1
	arg_2_0._isShowResourceUI = true

	ClientView.getResourceUI():setMode(Data.ResType.gold)

	local var_2_0 = arg_2_0._form

	if P._vip < Data._globalInfo._vipWorship then
		local var_2_1 = cc.p(lc.w(var_2_0) / 2 - 25 - var_0_2.width / 2, lc.bottom(arg_2_0._titleFrame) - 60 - var_0_2.height / 2)

		for iter_2_0 = 1, 2 do
			local var_2_2 = arg_2_0:createItem(iter_2_0)

			lc.addChildToPos(var_2_0, var_2_2, var_2_1, 0, iter_2_0)

			var_2_1.x = var_2_1.x + var_0_2.width + 50
		end
	else
		local var_2_3 = cc.p(var_0_0.FRAME_THICK_LEFT + 54 + var_0_2.width / 2, lc.bottom(arg_2_0._titleFrame) - 60 - var_0_2.height / 2)

		for iter_2_1 = 1, 3 do
			local var_2_4 = arg_2_0:createItem(iter_2_1)

			lc.addChildToPos(var_2_0, var_2_4, var_2_3, 0, iter_2_1)

			var_2_3.x = var_2_3.x + var_0_2.width + 50
		end
	end

	arg_2_0:updateRemainTimes()
end

function var_0_0.createItem(arg_3_0, arg_3_1)
	local var_3_0 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = var_0_2
	})
	local var_3_1 = lc.createSprite("img_item_title_bg")

	lc.addChildToPos(var_3_0, var_3_1, cc.p(var_0_2.width / 2, var_0_2.height - 38))

	local var_3_2 = ClientView.createTTF(Str(STR.WORSHIP_TITLE1 + arg_3_1 - 1), ClientView.FontSize.S2)

	lc.addChildToPos(var_3_1, var_3_2, cc.p(lc.w(var_3_1) / 2, 32))

	local var_3_3 = IconWidget.create({
		_infoId = Data.ResType.grain,
		_count = Data._globalInfo._worshipGain[arg_3_1]
	}, IconWidgetFlag.ITEM_NO_NAME)

	lc.addChildToPos(var_3_0, var_3_3, cc.p(var_0_2.width / 2, var_0_2.height / 2 + 10))

	local var_3_4 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_3_0:worship(arg_3_1)
	end, ClientView.CRECT_BUTTON, 160)

	if arg_3_1 == 1 then
		var_3_4:addLabel(Str(STR.FREE))
	else
		var_3_0._resType = arg_3_1 == 2 and Data.ResType.gold or Data.ResType.ingot

		var_3_4:addLabel(Data._globalInfo._worshipCost[arg_3_1])
		var_3_4:addIcon(string.format("img_icon_res%d_s", var_3_0._resType))
	end

	lc.addChildToPos(var_3_0, var_3_4, cc.p(var_0_2.width / 2, 40))

	return var_3_0
end

function var_0_0.updateRemainTimes(arg_5_0)
	local var_5_0 = arg_5_0._remainTimes

	if var_5_0 then
		var_5_0:removeFromParent()
	end

	local var_5_1 = Data._globalInfo._dailyWorshipCount
	local var_5_2 = ClientView.createBoldRichText(string.format(Str(STR.DAILY_WORSHIP_TIMES), var_5_1 - P._dailyWorship, var_5_1), ClientView.RICHTEXT_PARAM_DARK_S1)

	lc.addChildToPos(arg_5_0._form, var_5_2, cc.p(lc.w(arg_5_0._form) / 2, lc.bottom(arg_5_0._titleFrame) - 20))

	arg_5_0._remainTimes = var_5_2
end

function var_0_0.worship(arg_6_0, arg_6_1)
	if P._dailyWorship >= Data._globalInfo._dailyWorshipCount then
		ToastManager.push(Str(STR.CANNOT_UNION_WORSHIP))

		return
	end

	local var_6_0 = arg_6_0._form:getChildByTag(arg_6_1)
	local var_6_1 = Data._globalInfo._worshipCost[arg_6_1]

	if var_6_0._resType == Data.ResType.ingot then
		if not ClientView.checkIngot(var_6_1) then
			return
		end
	elseif not ClientView.checkGold(var_6_1) then
		return
	end

	local var_6_2 = Data._globalInfo._worshipGain[arg_6_1]

	P._dailyWorship = P._dailyWorship + 1

	P:changeResource(var_6_0._resType, -var_6_1)
	P:changeResource(Data.ResType.grain, var_6_2)
	ClientData.sendUnionWorship(arg_6_0._member._id, arg_6_1)
	arg_6_0:updateRemainTimes()
	arg_6_0:hide()
	ClientView.showResChangeText(lc._runningScene, Data.ResType.grain, var_6_2)
end

function var_0_0.onExit(arg_7_0)
	var_0_0.super.onExit(arg_7_0)
	ClientView.getResourceUI():setMode(Data.PropsId.yubi)
end

return var_0_0
