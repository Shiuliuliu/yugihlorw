local var_0_0 = class("UnionTechForm", BaseForm)
local var_0_1 = require("TechWidget")
local var_0_2 = cc.size(720, 400)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.init(arg_2_0, var_0_2, (arg_2_2 and Str(STR.UNION) or Str(STR.PERSONAL)) .. Str(STR.TECH), bor(var_0_0.FLAG.ADVANCE_TITLE_BG, var_0_0.FLAG.PAPER_BG))

	arg_2_0._tech = arg_2_1
	arg_2_0._isUnion = arg_2_2
	arg_2_0._isShowResourceUI = true

	local var_2_0 = P._playerUnion:getMyUnion()

	arg_2_0._isLock = arg_2_1._level == 0

	local var_2_1 = arg_2_0._form
	local var_2_2 = var_0_1.createIcon(arg_2_1)

	var_2_2._ignoreEvent = true

	var_2_2._levelBg:setVisible(false)
	lc.addChildToPos(var_2_1, var_2_2, cc.p(120, lc.h(var_2_1) - var_0_0.FRAME_THICK_TOP - 30 - lc.h(var_2_2) / 2), 1)

	arg_2_0._icon = var_2_2

	local var_2_3
	local var_2_4

	if arg_2_0._isLock then
		var_2_3, var_2_4 = 1
	elseif arg_2_1._level == arg_2_1._info._maxLevel then
		var_2_3, var_2_4 = arg_2_1._level
	else
		var_2_3, var_2_4 = arg_2_1._level, arg_2_1._level + 1
	end

	local var_2_5 = ClientView.createTTF(string.format("%s %d", Str(arg_2_1._info._nameSid), var_2_3), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)
	local var_2_6 = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = ClientView.CRECT_COM_BG2,
		_size = cc.size(400, 36)
	})

	var_2_6:setColor(lc.Color3B.black)
	var_2_6:setOpacity(100)
	lc.addChildToPos(var_2_6, var_2_5, cc.p(30 + lc.w(var_2_5) / 2, lc.h(var_2_6) / 2 - 1))
	lc.addChildToPos(var_2_1, var_2_6, cc.p(lc.right(var_2_2) + lc.w(var_2_6) / 2 - 22, lc.y(var_2_2) + 23))

	if var_2_4 then
		local var_2_7 = lc.createSprite("img_arrow_right")

		var_2_7:setScale(0.5)
		var_2_7:setColor(ClientView.COLOR_TEXT_GREEN)
		lc.addChildToPos(var_2_6, var_2_7, cc.p(lc.right(var_2_5) + 30, lc.y(var_2_5)))

		local var_2_8 = ClientView.createTTF(tostring(var_2_4), ClientView.FontSize.S1, ClientView.COLOR_TEXT_GREEN)

		lc.addChildToPos(var_2_6, var_2_8, cc.p(math.floor(lc.right(var_2_7)) + 16 + lc.w(var_2_8) / 2, lc.y(var_2_5)))
	end

	local var_2_9 = ClientView.createTTF(string.format("(%s: %s)", Str(STR.MAX_LEVEL), arg_2_1._info._maxLevel), ClientView.FontSize.S1, ClientView.COLOR_LABEL_DARK)

	lc.addChildToPos(var_2_6, var_2_9, cc.p(lc.w(var_2_6) + 24, lc.y(var_2_5)))

	local var_2_10 = ClientView.createUnionTechDesc(arg_2_1._info, var_2_3, var_2_4, 440, {
		_fontSize = ClientView.FontSize.S1,
		_curColor = ClientView.COLOR_TEXT_DARK,
		_nextColor = ClientView.COLOR_TEXT_GREEN_DARK
	})

	lc.addChildToPos(var_2_1, var_2_10, cc.p(lc.right(var_2_2) + lc.w(var_2_10) / 2 + 10, lc.bottom(var_2_6) - lc.h(var_2_10) / 2 - 10))

	local var_2_11 = 150
	local var_2_12 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_3_0)
		arg_2_0:upgrade()
	end, ClientView.CRECT_BUTTON, var_2_11)

	var_2_12:addLabel(Str(STR.UPGRADE))
	var_2_12:setDisabledShader(ClientView.SHADER_DISABLE)
	lc.addChildToPos(var_2_1, var_2_12, cc.p(lc.w(var_2_1) / 2, lc.h(var_2_12) / 2 + lc.bottom(arg_2_0._frame) + 30))

	if arg_2_2 then
		if not arg_2_0._isLock then
			if arg_2_1._level == arg_2_1._info._maxLevel then
				local var_2_13 = ClientView.createTTF(Str(STR.UNION_TECH_REACH_MAX), ClientView.FontSize.S1, ClientView.COLOR_TEXT_RED_DARK)

				lc.addChildToPos(var_2_1, var_2_13, cc.p(lc.x(var_2_12), lc.top(var_2_12) + 10 + lc.h(var_2_13) / 2))
				var_2_12:setEnabled(false)
			else
				local var_2_14, var_2_15, var_2_16 = arg_2_1:getUpgradeRes()
				local var_2_17 = ClientView.createResIconLabel(var_2_11 - 10, "img_icon_res12_s")

				var_2_17._label:setString(var_2_15)
				var_2_17._label:setColor(var_2_15 <= var_2_0._wood and lc.Color3B.white or lc.Color3B.red)
				lc.addChildToPos(var_2_1, var_2_17, cc.p(lc.x(var_2_12) + 6, lc.top(var_2_12) + 10 + lc.h(var_2_17) / 2))

				local var_2_18 = ClientView.createResIconLabel(var_2_11 - 10, "img_icon_res11_s")

				var_2_18._label:setString(var_2_14)
				var_2_18._label:setColor(var_2_14 <= var_2_0._gold and lc.Color3B.white or lc.Color3B.red)
				lc.addChildToPos(var_2_1, var_2_18, cc.p(lc.left(var_2_17) - 110, lc.y(var_2_17)))

				local var_2_19 = ClientView.createResIconLabel(var_2_11 - 10, ClientData.getPropIconName(arg_2_1._info._updateUnionBook))

				var_2_19._label:setString(var_2_16)
				var_2_19._label:setColor(var_2_16 <= P:getItemCount(arg_2_1._info._updateUnionBook) and lc.Color3B.white or lc.Color3B.red)
				lc.addChildToPos(var_2_1, var_2_19, cc.p(lc.right(var_2_17) + 110, lc.y(var_2_17)))
			end
		else
			local var_2_20 = ClientView.createTTF(string.format(Str(STR.UNION_UNLOCK_LEVEL), arg_2_1._info._unlockLevel), ClientView.FontSize.S1, ClientView.COLOR_TEXT_RED_DARK)

			lc.addChildToPos(var_2_1, var_2_20, cc.p(lc.x(var_2_12), lc.top(var_2_12) + 10 + lc.h(var_2_20) / 2))
			var_2_12:setEnabled(false)
		end
	else
		if arg_2_0._isLock then
			var_2_12._label:setString(Str(STR.UNLOCK))
		end

		local var_2_21 = var_2_0._techs[arg_2_1._infoId]

		if var_2_21._level <= arg_2_1._level then
			local var_2_22 = var_2_21._level < arg_2_1._level and Str(STR.UNION_TECH_SELF_LIMIT) or Str(STR.UNION_TECH_SELF_UPGRADE_TIP)
			local var_2_23 = ClientView.createTTF(var_2_22, ClientView.FontSize.S1, ClientView.COLOR_TEXT_RED_DARK)

			lc.addChildToPos(var_2_1, var_2_23, cc.p(lc.x(var_2_12), lc.top(var_2_12) + 10 + lc.h(var_2_23) / 2))
			var_2_12:setEnabled(false)
		else
			local var_2_24 = ClientView.createResIconLabel(var_2_11 - 10, ClientData.getPropIconName(Data.PropsId.yubi))
			local var_2_25 = arg_2_1:getUpgradeYubi()

			var_2_24._label:setString(var_2_25)
			var_2_24._label:setColor(var_2_25 <= P:getItemCount(Data.PropsId.yubi) and lc.Color3B.white or lc.Color3B.red)
			lc.addChildToPos(var_2_1, var_2_24, cc.p(lc.x(var_2_12) + 6, lc.top(var_2_12) + 10 + lc.h(var_2_24) / 2))
		end
	end
end

function var_0_0.upgrade(arg_4_0)
	local var_4_0 = arg_4_0._tech

	if arg_4_0._isUnion then
		local var_4_1 = P._playerUnion:getMyUnion():upgradeTech(var_4_0._infoId, true)

		if var_4_1 == Data.ErrorType.ok then
			ClientData.sendUnionUpgradeTech(var_4_0._infoId)
			arg_4_0:hide()
		elseif var_4_1 == Data.ErrorType.need_more_union_gold then
			ToastManager.push(Str(STR.NOT_ENOUGH_UNION_GOLD))
		elseif var_4_1 == Data.ErrorType.need_more_union_wood then
			ToastManager.push(Str(STR.NOT_ENOUGH_UNION_WOOD))
		else
			ToastManager.push(Str(STR.NOT_ENOUGH_UPGRADE_RES))
		end
	else
		local var_4_2 = P._playerUnion:upgradeTech(var_4_0._infoId)

		if var_4_2 == Data.ErrorType.ok then
			ToastManager.push(string.format(Str(STR.UNION_TECH_UPGRADE_SUCCESS), Str(var_4_0._info._nameSid), var_4_0._level))
			lc.sendEvent(Data.Event.union_tech_upgrade, var_4_0)
			ClientData.sendUnionUpgradeTechSelf(var_4_0._infoId)
			arg_4_0:hide()
		elseif var_4_2 == Data.ErrorType.need_more_yubi then
			ToastManager.push(Str(STR.NOT_ENOUGH_YUBI))
		end
	end
end

function var_0_0.onEnter(arg_5_0)
	var_0_0.super.onEnter(arg_5_0)

	arg_5_0._listeners = {}
end

function var_0_0.onExit(arg_6_0)
	var_0_0.super.onExit(arg_6_0)

	for iter_6_0 = 1, #arg_6_0._listeners do
		lc.Dispatcher:removeEventListener(arg_6_0._listeners[iter_6_0])
	end
end

return var_0_0
