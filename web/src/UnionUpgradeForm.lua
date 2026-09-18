local var_0_0 = class("UnionUpgradeForm", BaseForm)
local var_0_1 = cc.size(800, 530)
local var_0_2 = cc.size(640, 260)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.UNION) .. Str(STR.UPGRADE), bor(BaseForm.FLAG.ADVANCE_TITLE_BG, BaseForm.FLAG.PAPER_BG))

	arg_2_0._isShowResourceUI = true

	local var_2_0 = arg_2_0._form
	local var_2_1 = P._playerUnion:getMyUnion()
	local var_2_2 = ClientView.createTTF(Str(STR.UNION) .. Str(STR.LEVEL) .. ": ", ClientView.FontSize.S1, ClientView.COLOR_LABEL_DARK)
	local var_2_3 = ClientView.createTTF(tostring(var_2_1._level), ClientView.FontSize.M2, ClientView.COLOR_TEXT_DARK)
	local var_2_4 = ClientView.createTTF(tostring(var_2_1._level + 1), ClientView.FontSize.M2, ClientView.COLOR_TEXT_DARK)
	local var_2_5 = lc.createSprite("img_arrow_right")

	var_2_5:setColor(ClientView.COLOR_TEXT_GREEN)
	lc.addNodesToCenter(var_2_0, {
		var_2_2,
		var_2_3,
		var_2_5,
		var_2_4
	}, 16, lc.bottom(arg_2_0._titleFrame) - 30)

	local var_2_6 = lc.createSprite({
		_name = "img_com_bg_10",
		_crect = ClientView.CRECT_COM_BG10,
		_size = var_0_2
	})

	lc.addChildToPos(var_2_0, var_2_6, cc.p(lc.w(var_2_0) / 2, lc.bottom(var_2_2) - 16 - var_0_2.height / 2))

	local var_2_7 = lc.List.createV(cc.size(var_0_2.width - 40, var_0_2.height - 30))

	var_2_7:setAnchorPoint(0.5, 0.5)
	var_2_7:setBounceEnabled(false)
	lc.addChildToPos(var_2_6, var_2_7, cc.p(lc.w(var_2_6) / 2, lc.h(var_2_6) / 2 + 4))

	local var_2_8 = {
		Str(STR.UNION_UPGRADE_UNLOCK_MARKET)
	}
	local var_2_9 = 32

	for iter_2_0, iter_2_1 in pairs(var_2_1._techs) do
		if iter_2_1._info._unlockLevel == var_2_1._level + 1 then
			table.insert(var_2_8, string.format(Str(STR.UNION_UPGRADE_UNLOCK_TECH), Str(iter_2_1._info._nameSid)))
		end
	end

	local var_2_10 = 50 + var_2_9 * #var_2_8
	local var_2_11 = ccui.Widget:create()

	var_2_11:setContentSize(lc.w(var_2_7), var_2_10)
	ClientView.addDecoratedLabel(var_2_11, Str(STR.UNLOCK_FUNCTION), cc.p(lc.w(var_2_11) / 2, var_2_10 - 16), 26)

	local var_2_12 = var_2_10 - 50

	for iter_2_2, iter_2_3 in ipairs(var_2_8) do
		local var_2_13 = ClientView.createBoldRichText(iter_2_3, {
			_normalClr = ClientView.COLOR_TEXT_DARK,
			_boldClr = ClientView.COLOR_TEXT_GREEN_DARK,
			_fontSize = ClientView.FontSize.S1
		})

		lc.addChildToPos(var_2_11, var_2_13, cc.p(lc.w(var_2_11) / 2, var_2_12 - var_2_9 / 2))

		var_2_12 = var_2_12 - var_2_9
	end

	var_2_7:pushBackCustomItem(var_2_11)

	local var_2_14 = 180
	local var_2_15 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_3_0)
		arg_2_0:upgrade()
	end, ClientView.CRECT_BUTTON, var_2_14)

	var_2_15:addLabel(Str(STR.UPGRADE))
	lc.addChildToPos(var_2_0, var_2_15, cc.p(lc.w(var_2_0) / 2, lc.h(var_2_15) / 2 + var_0_0.BOTTOM_MARGIN + 24))

	local var_2_16 = ClientView.createResIconLabel(var_2_14 - 20, "img_icon_res12_s")
	local var_2_17 = var_2_1:getLevelupWood()

	var_2_16._label:setString(var_2_17)
	var_2_16._label:setColor(var_2_17 <= var_2_1._wood and lc.Color3B.white or lc.Color3B.red)
	lc.addChildToPos(var_2_0, var_2_16, cc.p(lc.x(var_2_15) + 6, lc.top(var_2_15) + 10 + lc.h(var_2_16) / 2))

	local var_2_18 = ClientView.createResIconLabel(var_2_14 - 20, "img_icon_res11_s")
	local var_2_19 = var_2_1:getLevelupGold()

	var_2_18._label:setString(var_2_19)
	var_2_18._label:setColor(var_2_19 <= var_2_1._gold and lc.Color3B.white or lc.Color3B.red)
	lc.addChildToPos(var_2_0, var_2_18, cc.p(lc.left(var_2_16) - 120, lc.y(var_2_16)))

	local var_2_20 = ClientView.createResIconLabel(var_2_14 - 20, "img_icon_res13_s")
	local var_2_21 = var_2_1:getLevelupAct()

	var_2_20._label:setString(var_2_21)
	var_2_20._label:setColor(var_2_21 <= var_2_1._act and lc.Color3B.white or lc.Color3B.red)
	lc.addChildToPos(var_2_0, var_2_20, cc.p(lc.right(var_2_16) + 120, lc.y(var_2_16)))
end

function var_0_0.upgrade(arg_4_0)
	local var_4_0 = P._playerUnion:upgrade(true)

	if var_4_0 == Data.ErrorType.ok then
		ClientData.sendUnionUpgrade()
		arg_4_0:hide()
	elseif var_4_0 == Data.ErrorType.need_more_union_gold then
		ToastManager.push(Str(STR.NOT_ENOUGH_UNION_GOLD))
	elseif var_4_0 == Data.ErrorType.need_more_union_wood then
		ToastManager.push(Str(STR.NOT_ENOUGH_UNION_WOOD))
	elseif var_4_0 == Data.ErrorType.need_more_union_act then
		ToastManager.push(Str(STR.NOT_ENOUGH_UNION_ACT))
	end
end

return var_0_0
