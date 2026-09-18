local var_0_0 = class("EnvelopePanel", lc.ExtendCCNode)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setContentSize(ClientView.SCR_W, ClientView.SCR_H)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		end
	end)
	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._user = arg_3_1
	arg_3_0._isFirstEnter = true

	local var_3_0 = ClientView.createScale9ShaderButton(nil, function(arg_4_0)
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
		ClientData.sendClaimEnvelope(arg_3_0._user)
		arg_3_0:hide()
	end, ClientView.CRECT_BUTTON, 140)

	var_3_0:setContentSize(500, 500)
	lc.addChildToCenter(arg_3_0, var_3_0)

	arg_3_0._claimBtn = var_3_0
	arg_3_0._countDown = 5

	local var_3_1 = ClientView.createBMFont(ClientView.BMFont.num_48, arg_3_0._countDown)

	lc.addChildToPos(arg_3_0, var_3_1, cc.p(lc.x(var_3_0), lc.ch(arg_3_0) + 300))

	arg_3_0._countDownLabel = var_3_1

	local var_3_2 = math.random(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

	if arg_3_0._user then
		arg_3_0._userStr = string.format(Str(STR.ENVELOPE_TIP_1 + var_3_2 - 1), ClientData.genChannelRegionName(arg_3_1._regionId), arg_3_1._name)
	end

	return true
end

function var_0_0.onEnter(arg_5_0)
	arg_5_0._listeners = {}

	local var_5_0 = lc.rep(lc.sequence(function()
		if arg_5_0._countDown > 0 then
			arg_5_0._countDownLabel:setString(arg_5_0._countDown)

			arg_5_0._countDown = arg_5_0._countDown - 1
		else
			arg_5_0:hide()
		end
	end, 1))

	var_5_0:setTag(100)
	arg_5_0:runAction(var_5_0)

	if arg_5_0._user then
		ToastManager.push(arg_5_0._userStr):setLocalZOrder(arg_5_0:getLocalZOrder() + 1)
	end

	local var_5_1 = DragonBones.create("hongbao")

	arg_5_0._bones = var_5_1

	lc.addChildToCenter(arg_5_0._claimBtn, var_5_1)

	if arg_5_0._isFirstEnter then
		local var_5_2 = var_5_1:getAnimationDuration("begin") - 0.1

		var_5_1:runAction(lc.sequence(function()
			var_5_1:gotoAndPlay("begin")
		end, var_5_2, function()
			var_5_1:gotoAndPlay("loop")
		end))
	else
		var_5_1:gotoAndPlay("loop")
	end

	arg_5_0._isFirstEnter = false
end

function var_0_0.onExit(arg_9_0)
	arg_9_0._bones:removeFromParent()

	arg_9_0._bones = nil

	arg_9_0:stopAllActionsByTag(100)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_9_1)
	end
end

function var_0_0.show(arg_10_0)
	if not arg_10_0:getParent() then
		lc.addChildToCenter(lc._runningScene._scene, arg_10_0, BattleScene.ZOrder.top)
	end
end

function var_0_0.hide(arg_11_0)
	ClientView.releaseEnvelopePanel()
end

return var_0_0
