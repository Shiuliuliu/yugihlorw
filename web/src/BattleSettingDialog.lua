local var_0_0 = class("BattleSettingDialog", lc.ExtendUIWidget)

BattleSettingDialog = var_0_0

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._battleUi = arg_2_1

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 == ccui.TouchEventType.ended then
			arg_2_1:hideSetting()
		end
	end)
	arg_2_1._btnSetting:setLocalZOrder(BattleScene.ZOrder.form + 2)

	local var_2_0 = {
		arg_2_1._btnMusic,
		arg_2_1._btnSndEffect
	}
	local var_2_1 = {}

	if not P._characters or P:getMaxCharacterLevel() >= ClientData.POS_UNLOCK_LEVEL then
		table.insert(var_2_0, arg_2_1._btnPos)
	end

	if not arg_2_1._isOnlinePvp then
		table.insert(var_2_0, arg_2_1._btnHelp)
	end

	if arg_2_1._needTask then
		table.insert(var_2_0, arg_2_1._btnTask)
	end

	if arg_2_1._needRetreat then
		table.insert(var_2_0, arg_2_1._btnRetreat)
	end

	if arg_2_1._needReturn then
		table.insert(var_2_0, arg_2_1._btnReturn)
	end

	local var_2_2 = arg_2_0:getDefaultPosition()

	for iter_2_0 = 1, #var_2_0 do
		local var_2_3 = cc.p(var_2_2.x + iter_2_0 * 90, var_2_2.y)
		local var_2_4 = var_2_0[iter_2_0]

		var_2_4:setLocalZOrder(BattleScene.ZOrder.form + 1)
		var_2_4:stopAllActions()
		var_2_4:setPosition(var_2_2)
		var_2_4:setScale(0)
		var_2_4:setDisabledShader(ClientView.SHADER_DISABLE)

		local var_2_5 = true

		if var_2_4 == arg_2_1._btnRetreat and arg_2_1._player._isFinished then
			var_2_5 = false
		end

		local var_2_6 = cc.Director:getInstance():getScheduler():getTimeScale()

		var_2_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * (iter_2_0 - 1) * var_2_6), cc.CallFunc:create(function()
			var_2_4:setVisible(true)
			var_2_4:setEnabled(false)
		end), cc.EaseBackOut:create(cc.Spawn:create(cc.ScaleTo:create(0.35 * var_2_6, 1), cc.MoveTo:create(0.35 * var_2_6, var_2_3))), cc.CallFunc:create(function()
			var_2_4:setEnabled(var_2_5)
		end)))
	end

	for iter_2_1 = 1, #var_2_1 do
		local var_2_7 = cc.p(var_2_2.x, var_2_2.y - iter_2_1 * 90)
		local var_2_8 = var_2_1[iter_2_1]

		var_2_8:setLocalZOrder(BattleScene.ZOrder.form + 1)
		var_2_8:stopAllActions()
		var_2_8:setPosition(var_2_2)
		var_2_8:setScale(0.5)
		var_2_8:setDisabledShader(ClientView.SHADER_DISABLE)

		local var_2_9 = true

		if var_2_8 == arg_2_1._btnRetreat and (arg_2_1._player._isFinished or arg_2_1:isGuideWorldBattle()) then
			var_2_9 = false
		end

		local var_2_10 = cc.Director:getInstance():getScheduler():getTimeScale()

		var_2_8:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * (iter_2_1 - 1) * var_2_10), cc.CallFunc:create(function()
			var_2_8:setVisible(true)
			var_2_8:setEnabled(false)
		end), cc.EaseBackOut:create(cc.Spawn:create(cc.ScaleTo:create(0.35 * var_2_10, 1), cc.MoveTo:create(0.35 * var_2_10, var_2_7))), cc.CallFunc:create(function()
			var_2_8:setEnabled(var_2_9)
		end)))
	end
end

function var_0_0.hide(arg_8_0)
	local var_8_0 = arg_8_0._battleUi

	var_8_0._btnSetting:setLocalZOrder(BattleScene.ZOrder.ui + 1)
	var_8_0._btnSetting:setEnabled(true)
	var_8_0._btnSetting:setColor(lc.Color3B.white)

	local var_8_1 = {
		var_8_0._btnMusic,
		var_8_0._btnSndEffect,
		var_8_0._btnPos,
		var_8_0._btnHelp,
		var_8_0._btnManualGuide
	}
	local var_8_2 = {}

	if var_8_0._needTask then
		table.insert(var_8_1, var_8_0._btnTask)
	end

	if var_8_0._needRetreat then
		table.insert(var_8_1, var_8_0._btnRetreat)
	end

	if var_8_0._needReturn then
		table.insert(var_8_1, var_8_0._btnReturn)
	end

	local var_8_3 = arg_8_0:getDefaultPosition()

	for iter_8_0 = 1, #var_8_1 do
		local var_8_4 = var_8_1[iter_8_0]

		var_8_4:setLocalZOrder(BattleScene.ZOrder.ui)
		var_8_4:stopAllActions()
		var_8_4:setEnabled(false)

		local var_8_5 = cc.Director:getInstance():getScheduler():getTimeScale()

		var_8_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * (iter_8_0 - 1) * var_8_5), cc.EaseBackIn:create(cc.Spawn:create(cc.ScaleTo:create(0.3 * var_8_5, 0), cc.MoveTo:create(0.3 * var_8_5, var_8_3)))))
	end

	for iter_8_1 = 1, #var_8_2 do
		local var_8_6 = var_8_2[iter_8_1]

		var_8_6:setLocalZOrder(BattleScene.ZOrder.ui)
		var_8_6:stopAllActions()
		var_8_6:setEnabled(false)

		local var_8_7 = cc.Director:getInstance():getScheduler():getTimeScale()

		var_8_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * (iter_8_1 - 1) * var_8_7), cc.EaseBackIn:create(cc.Spawn:create(cc.ScaleTo:create(0.3 * var_8_7, 0.1), cc.MoveTo:create(0.3 * var_8_7, var_8_3)))))
	end

	arg_8_0:removeFromParent()
end

function var_0_0.getDefaultPosition(arg_9_0)
	return cc.p(arg_9_0._battleUi._btnSetting:getPosition())
end

return var_0_0
