local var_0_0 = class("EffectForm", BaseForm)
local var_0_1 = cc.size(560, 580)
local var_0_2 = 180
local var_0_3 = 150

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._isShowResourceUI = true
	arg_2_0._infoId = arg_2_1
	arg_2_0._cardCategory = Data.getInfo(arg_2_1)._category
	arg_2_0._categaryType = 0
	arg_2_0._skinEffectType = Data.SkinEffectType.toBoard

	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(Data.getSkinEffectId(arg_2_0._cardCategory, arg_2_0._skinEffectType)) do
		if iter_2_0 > 1 then
			var_2_0[#var_2_0 + 1] = Str(STR.CARD_CATEGORY_BEGIN + arg_2_0._cardCategory) .. iter_2_0 - 1
		else
			var_2_0[#var_2_0 + 1] = Str(STR.COMMON)
		end
	end

	for iter_2_2, iter_2_3 in ipairs(var_2_0) do
		local var_2_2 = {
			_tag = iter_2_2,
			_labelStr = var_2_0[iter_2_2],
			_width = var_0_3,
			_handler = function(arg_3_0)
				arg_2_0:showTab(arg_3_0)
			end
		}

		table.insert(var_2_1, var_2_2)
	end

	var_2_1[1]._left = 40

	arg_2_0._frame:setVisible(false)

	local var_2_3 = ClientView.createHorizontalContentTab(cc.size(var_0_1.width, var_0_1.height), var_2_1)

	lc.addChildToPos(arg_2_0._form, var_2_3, cc.p(var_0_1.width / 2, lc.h(var_2_3) / 2 - 1))

	arg_2_0._contentBg = var_2_3

	local var_2_4 = arg_2_0._infoId == 10006 or arg_2_0._infoId == 10293 or arg_2_0._infoId == 10307 or arg_2_0._infoId == 10407 or arg_2_0._infoId == 12142 or arg_2_0._infoId == 10446 or arg_2_0._infoId == 10270 or arg_2_0._infoId == 10763 or arg_2_0._infoId == 10896

	ClientView.addVerticalTabButtons(arg_2_0._form, {
		Str(STR.TO_BOARD),
		Str(STR.ON_BOARD),
		Str(STR.BUBBLE_ATTACK)
	}, lc.h(arg_2_0._form) - 60, -124, 450, 100)

	arg_2_0._tabArea = arg_2_0._form._tabArea

	function arg_2_0._form.showTab(arg_4_0, arg_4_1)
		if arg_4_1 == 1 and var_2_4 then
			ToastManager.push(Str(STR.TO_BOARD_DISABLED))
		else
			arg_2_0._tabArea:showTab(arg_4_1)

			arg_2_0._skinEffectType = arg_4_1 + 1

			arg_2_0:updateEffectShowArea()
		end
	end

	arg_2_0:createEffectShowArea()
	var_2_3:showTab(1, true)
	arg_2_0._form:showTab(var_2_4 and 2 or 1)
end

function var_0_0.showTab(arg_5_0, arg_5_1)
	arg_5_0:setCameraMask(ClientData.CAMERA_3D_FLAG)

	arg_5_0._categaryType = arg_5_0._cardCategory

	arg_5_0:updateEffectShowArea()
end

function var_0_0.createButtonArea(arg_6_0)
	local var_6_0 = lc.createNode(cc.size(lc.w(arg_6_0._contentBg), 100))

	lc.addChildToPos(arg_6_0, var_6_0, cc.p(lc.cw(arg_6_0), lc.ch(var_6_0)))

	arg_6_0._buttonArea = var_6_0

	local var_6_1 = arg_6_0._effectId
	local var_6_2 = Data._skinInfo[var_6_1]
	local var_6_3 = var_6_2._resType
	local var_6_4 = var_6_2._price
	local var_6_5 = Data.getType(var_6_3)
	local var_6_6 = ClientData.getIconName(var_6_3)
	local var_6_7 = var_6_4 <= P:getItemCount(var_6_3)
	local var_6_8 = P._playerCard:cardHasSkin(arg_6_0._infoId, var_6_1, true)
	local var_6_9 = P._playerCard:getSkinId(arg_6_0._infoId, arg_6_0._skinEffectType) == var_6_1

	if not var_6_8 then
		local var_6_10 = ClientView.createResConsumeButton(250, 110, var_6_6, var_6_4, Str(STR.BUY), "img_btn_1")

		if not var_6_7 then
			var_6_10._resLabel:setColor(ClientView.COLOR_TEXT_RED)
		end

		function var_6_10._callback()
			arg_6_0:buyEffect()
		end

		lc.addChildToCenter(var_6_0, var_6_10)
	elseif var_6_9 then
		local var_6_11 = ClientView.createScale9ShaderButton("img_btn_1", function()
			arg_6_0:resetEffect()
		end, ClientView.CRECT_BUTTON, 150)

		var_6_11:addLabel(Str(STR.RESET))
		lc.addChildToCenter(var_6_0, var_6_11)
	else
		local var_6_12 = ClientView.createScale9ShaderButton("img_btn_1", function()
			arg_6_0:setEffect()
		end, ClientView.CRECT_BUTTON, 150)

		var_6_12:addLabel(Str(STR.SETTING))
		lc.addChildToCenter(var_6_0, var_6_12)
	end

	var_6_0:setCameraMask(ClientData.CAMERA_3D_FLAG)
end

function var_0_0.buyEffect(arg_10_0)
	local var_10_0 = arg_10_0._effectId
	local var_10_1 = Data._skinInfo[var_10_0]
	local var_10_2 = var_10_1._resType
	local var_10_3 = ClientData.getPropIconName(var_10_2)
	local var_10_4 = var_10_1._price

	if var_10_4 > P:getItemCount(var_10_2) then
		return ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(var_10_2)))
	end

	if P._playerCard:buySkinId(var_10_0, 0, arg_10_0._infoId) then
		P:addResource(var_10_2, 1, -var_10_4)

		local var_10_5 = Data.removeAdditional(arg_10_0._infoId)

		ClientData.sendBuyEffect(var_10_5, var_10_0, 0)
		arg_10_0:updateButtonArea()
		require("Dialog").showDialog(Str(STR.BUY_EFFECT_SUCCEED), function()
			arg_10_0:setEffect()
		end)
	else
		ToastManager.push(Str(STR.BUY_EFFECT_FAILED))
	end
end

function var_0_0.resetEffect(arg_12_0)
	local var_12_0 = arg_12_0._effectId

	if P._playerCard:setSkinId(arg_12_0._infoId, 0, arg_12_0._skinEffectType) then
		ClientData.sendSetSkin(arg_12_0._infoId, -var_12_0)
		arg_12_0:updateButtonArea()
		ToastManager.push(Str(STR.SET_EFFECT_SUCCEED))
	else
		ToastManager.push(Str(STR.SET_EFFECT_FAILED))
	end
end

function var_0_0.setEffect(arg_13_0)
	local var_13_0 = arg_13_0._effectId

	if P._playerCard:setSkinId(arg_13_0._infoId, var_13_0, arg_13_0._skinEffectType) then
		ClientData.sendSetSkin(arg_13_0._infoId, var_13_0)
		arg_13_0:updateButtonArea()
		ToastManager.push(Str(STR.SET_EFFECT_SUCCEED))
	else
		ToastManager.push(Str(STR.SET_EFFECT_FAILED))
	end
end

function var_0_0.updateEffectShowArea(arg_14_0)
	local var_14_0 = arg_14_0._contentBg._focusTabIndex
	local var_14_1 = Data.getSkinEffectId(arg_14_0._categaryType, arg_14_0._skinEffectType)[var_14_0]

	arg_14_0._effectId = var_14_1

	arg_14_0:stopAllActions()

	if arg_14_0._skinEffectType == Data.SkinEffectType.toBoard then
		arg_14_0:runAction(lc.rep(lc.sequence(function()
			arg_14_0._battleUi.showToBoard(var_14_1)
		end, 3)))
	elseif arg_14_0._skinEffectType == Data.SkinEffectType.onBoard then
		arg_14_0._battleUi.showOnBoard(var_14_1)
	else
		arg_14_0:runAction(lc.rep(lc.sequence(function()
			arg_14_0._battleUi.showAttack(var_14_1)
		end, 3)))
	end

	arg_14_0:updateButtonArea()
end

function var_0_0.updateButtonArea(arg_17_0)
	if arg_17_0._buttonArea then
		arg_17_0._buttonArea:removeFromParent()

		arg_17_0._buttonArea = nil
	end

	arg_17_0:createButtonArea()
end

function var_0_0.createEffectShowArea(arg_18_0)
	local var_18_0 = lc.createSprite("res/jpg/effect_show_bg.jpg")

	lc.addChildToPos(arg_18_0._contentBg, var_18_0, cc.p(lc.cw(arg_18_0._contentBg), lc.h(arg_18_0._contentBg) - lc.ch(var_18_0) - 25), -1)

	local var_18_1 = var_18_0:convertToWorldSpace(cc.p(lc.cw(var_18_0), lc.ch(var_18_0)))

	arg_18_0._effectShowArea = var_18_0

	local var_18_2 = lc.createNode(var_18_0:getContentSize())

	lc.addChildToCenter(var_18_0, var_18_2)

	arg_18_0._battleUi = var_18_2

	lc.offset(var_18_2, 0, 10)
	var_18_2:setRotation3D({
		z = 0,
		y = 0,
		x = -ClientView.BATTLE_ROTATION_X
	})
	var_18_2:setVisible(false)

	local var_18_3 = cc.p(lc.cw(var_18_2), lc.ch(var_18_2))
	local var_18_4 = cc.p(lc.cw(var_18_2), lc.ch(var_18_2) - 140)
	local var_18_5 = cc.p(lc.cw(var_18_2), lc.ch(var_18_2) + 140)
	local var_18_6 = 0.35
	local var_18_7 = 0.4
	local var_18_8 = 0.38
	local var_18_9 = 1 / var_18_8
	local var_18_10 = ClientView.createCardFrame(arg_18_0._infoId, nil, nil, nil)

	var_18_10:setScale(var_18_8)
	var_18_10:setStatus(true, true)

	var_18_10._defaultPos = var_18_5

	lc.addChildToPos(var_18_2, var_18_10, var_18_5)

	local var_18_11 = ClientView.createCardFrame(arg_18_0._infoId, nil, nil, nil)

	var_18_11._defaultPos = var_18_4

	lc.addChildToPos(var_18_2, var_18_11, var_18_4)

	function var_18_11.reset(arg_19_0)
		arg_19_0:stopAllActions()

		arg_19_0._effectId = nil

		arg_19_0:setScale(var_18_8)
		arg_19_0:update(arg_19_0._infoId, arg_19_0._skinId)
		arg_19_0:setStatus(true, true)
		arg_19_0:setPosition(arg_19_0._defaultPos)
		arg_19_0._image:removeAllChildren()
		arg_19_0:setCameraMask(ClientData.CAMERA_3D_FLAG)
	end

	function var_18_11.efcSkinEffect(arg_20_0, arg_20_1)
		local var_20_0 = cc.p(lc.cw(arg_20_0._image), lc.ch(arg_20_0._image))
		local var_20_1 = Data.getEffectNamesById(arg_20_1)

		if var_20_1[1] == "0.0" then
			return
		end

		for iter_20_0 = 1, #var_20_1 do
			local var_20_2 = var_20_1[iter_20_0]
			local var_20_3 = false

			if var_20_2 == "emozhanchang11" then
				var_20_3 = true
			end

			if tonumber(string.sub(var_20_2, -2, -2)) == 0 then
				local var_20_4 = Particle.create(var_20_2)

				var_20_4:setCameraMask(ClientData.CAMERA_3D_FLAG)
				lc.addChildToPos(arg_20_0._image, var_20_4, var_20_0, var_20_3 and -1 or 1)
			else
				local var_20_5 = DragonBones.create(var_20_2)

				var_20_5:setCameraMask(ClientData.CAMERA_3D_FLAG)
				var_20_5:gotoAndPlay("effect")
				lc.addChildToPos(arg_20_0._image, var_20_5, var_20_0, var_20_3 and -1 or 1)
			end
		end

		local var_20_6 = Data._skinInfo[arg_20_1]

		if var_20_6._category == 3 and var_20_6._type == Data.SkinEffectType.toBoard then
			(arg_20_0._bones or arg_20_0._image):runAction(lc.sequence(lc.fadeOut(0), 0.3, lc.fadeIn(0.8)))
		end
	end

	function var_18_2.showToBoard(arg_21_0)
		local var_21_0 = cc.p(var_18_11:getPosition())
		local var_21_1 = PlayerUi.calLengthAndAngle(nil, var_18_3, var_21_0) / 1500

		var_18_11.reset(var_18_10)
		var_18_11:reset()
		var_18_11:runAction(lc.sequence(function()
			var_18_11:setStatus(true, false)
			var_18_11:setCameraMask(ClientData.CAMERA_3D_FLAG)
			var_18_11:setRotation3D({
				z = 0,
				y = 0,
				x = ClientView.BATTLE_ROTATION_X
			})
			var_18_11:setPosition(var_18_3)
			var_18_11:setScale(1)

			local var_22_0 = Particle.create("par_kprc01")

			var_22_0:setCameraMask(ClientData.CAMERA_3D_FLAG)
			lc.addChildToCenter(var_18_11, var_22_0, 100)
			var_22_0:setScale(var_18_9)

			local var_22_1 = Particle.create("par_kprc02")

			var_22_1:setCameraMask(ClientData.CAMERA_3D_FLAG)
			lc.addChildToCenter(var_18_11, var_22_1, 100)
			var_22_1:setScale(var_18_9)
		end, lc.delay(var_18_7), lc.ease(lc.spawn(lc.moveTo(var_18_6, var_18_4), lc.rotateTo(var_18_6, 0, 0, 0), lc.scaleTo(var_18_6, var_18_8)), "O", 0.4), lc.call(function()
			local var_23_0 = Particle.create("par_yhcx")

			lc.addChildToCenter(var_18_11, var_23_0, CardSprite.ZOrder.efc)
			var_18_11:setStatus(true, true)
			var_18_11:setCameraMask(ClientData.CAMERA_3D_FLAG)
			var_18_11._image:setScale(0.6)
			var_18_11._image:runAction(lc.sequence(lc.scaleTo(0.2, ClientView.getCardBattleScale(var_18_11._infoId) * 1.1), lc.scaleTo(0.1, ClientView.getCardBattleScale(var_18_11._infoId))))
			var_18_11:efcSkinEffect(arg_21_0)
		end)))
	end

	function var_18_2.showOnBoard(arg_24_0)
		var_18_11:reset()
		var_18_11:setScale(var_18_8)
		var_18_11:setPosition(var_18_4)
		var_18_11:update(var_18_11._infoId, var_18_11._skinId, arg_24_0)
		var_18_11:setCameraMask(ClientData.CAMERA_3D_FLAG)
	end

	function var_18_2.showAttack(arg_25_0)
		var_18_11:reset()

		local var_25_0 = var_18_11._image:getOpacity() ~= 0 and var_18_11._image or var_18_11._bones
		local var_25_1 = var_25_0:getParent()
		local var_25_2 = cc.p(var_25_0:getPosition())
		local var_25_3 = var_18_10._image
		local var_25_4 = var_25_0:getParent():convertToNodeSpace(var_25_3:getParent():convertToWorldSpace(cc.p(var_25_3:getPosition())))

		var_25_0:stopAllActions()
		var_25_0:runAction(lc.sequence(delay, lc.ease(lc.moveTo(0.2, var_25_4), "I", 2.5), function()
			var_18_11.efcSkinEffect(var_18_10, arg_25_0)
		end, lc.ease(lc.moveTo(0.2, var_25_2), "BackO", 2.5), function()
			var_25_0:startFloat()
		end))
	end
end

function var_0_0.onEnter(arg_28_0)
	var_0_0.super.onEnter(arg_28_0)
	arg_28_0:setCameraMask(ClientData.CAMERA_2D_FLAG)

	arg_28_0._listeners = {}
end

function var_0_0.onExit(arg_29_0)
	var_0_0.super.onExit(arg_29_0)

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_29_1)
	end
end

function var_0_0.onShowActionFinished(arg_30_0)
	lc._runningScene:seenByCamera3D(arg_30_0)
	arg_30_0._battleUi:setVisible(true)
end

return var_0_0
