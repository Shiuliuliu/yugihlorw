local var_0_0 = class("BasePanel", lc.ExtendUIWidget)

var_0_0.DEFAULT_MASK_OPACITY = 192
var_0_0.Panels = {}

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._isForce = arg_1_1
	arg_1_0._hideBg = arg_1_2
	arg_1_0._ignoreBlur = lc._runningScene and lc._runningScene._sceneId == ClientData.SceneId.battle

	arg_1_0:addTouchEventListener(function(arg_2_0, arg_2_1)
		if arg_2_1 == ccui.TouchEventType.ended and not arg_1_0._isForce then
			arg_1_0:hide()
		end
	end)

	return true
end

function var_0_0.onEnter(arg_3_0)
	arg_3_0._blurListener = lc.addEventListener("director_after_blur", function(arg_4_0)
		arg_3_0:afterBlur(arg_4_0)
	end)

	local var_3_0 = false

	for iter_3_0 = 1, #var_0_0.Panels do
		if arg_3_0:getLocalZOrder() < var_0_0.Panels[iter_3_0]:getLocalZOrder() then
			table.insert(var_0_0.Panels, iter_3_0, arg_3_0)

			var_3_0 = true

			break
		end
	end

	if not var_3_0 then
		table.insert(var_0_0.Panels, arg_3_0)
	end

	if not arg_3_0._ignoreBlur then
		arg_3_0:updateBg()
	end
end

function var_0_0.onExit(arg_5_0)
	lc.Dispatcher:removeEventListener(arg_5_0._blurListener)

	for iter_5_0 = 1, #var_0_0.Panels do
		if var_0_0.Panels[iter_5_0] == arg_5_0 then
			table.remove(var_0_0.Panels, iter_5_0)

			break
		end
	end

	if not arg_5_0._ignoreBlur then
		arg_5_0:updateBg()
	end
end

function var_0_0.onCleanup(arg_6_0)
	return
end

function var_0_0.updateBg(arg_7_0)
	local var_7_0 = arg_7_0:getParent():getChildren()

	for iter_7_0 = 2, #var_7_0 do
		var_7_0[iter_7_0]:setVisible(var_7_0[iter_7_0]:getLocalZOrder() ~= ClientData.ZOrder.guide)
	end

	local var_7_1

	for iter_7_1 = #var_0_0.Panels, 1, -1 do
		local var_7_2 = var_0_0.Panels[iter_7_1]

		var_7_2:setVisible(false)

		if not var_7_2._hideBg and var_7_1 == nil then
			var_7_1 = var_7_2
		end
	end

	if var_7_1 ~= nil then
		if var_0_0._blurredBg == nil then
			local var_7_3 = lc.Director:getBlurredScene()

			var_7_3:setBlendFunc(gl.ONE, gl.ONE_MINUS_SRC_ALPHA)

			var_0_0._blurredBg = var_7_3
			var_0_0._isBlurring = true
		end

		var_0_0._blurredBg:removeFromParent()
		var_7_1:addChild(var_0_0._blurredBg, -1)
	else
		var_0_0._blurredBg = nil
	end

	if not var_0_0._isBlurring then
		arg_7_0:updatePanels()
	end
end

function var_0_0.afterBlur(arg_8_0, arg_8_1)
	if arg_8_0 == var_0_0.Panels[#var_0_0.Panels] then
		var_0_0._isBlurring = false

		arg_8_0:updatePanels()

		local var_8_0 = arg_8_0:getParent()._layer

		if var_8_0._sceneId == ClientData.SceneId.battle then
			var_8_0:setVisible(true)
			var_8_0:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
				local var_9_0 = {
					var_8_0._battleUi,
					var_8_0._battleUi._layer,
					var_8_0._battleUi._skySpr
				}

				for iter_9_0 = 1, #var_9_0 do
					local var_9_1 = var_9_0[iter_9_0]
					local var_9_2 = var_9_1:getPosition()

					var_9_1:setPositionX(var_9_2 + 1)
					var_9_1:setPositionX(var_9_2)
				end

				var_8_0:setVisible(false)
			end)))
		end
	end
end

function var_0_0.show(arg_10_0, arg_10_1)
	var_0_0.hideTopMost()
	lc._runningScene._scene:addChild(arg_10_0, arg_10_1 or ClientData.ZOrder.form)
end

function var_0_0.hide(arg_11_0)
	arg_11_0:removeFromParent()
end

function var_0_0.hideTopMost()
	if var_0_0._topMostPanel then
		var_0_0._topMostPanel:hide()
	end
end

function var_0_0.updatePanels(arg_13_0)
	local var_13_0 = #var_0_0.Panels
	local var_13_1 = lc._runningScene._sceneId
	local var_13_2 = {}

	if var_13_0 > 0 then
		local var_13_3 = var_0_0.Panels[var_13_0]
		local var_13_4 = true
		local var_13_5 = 0

		for iter_13_0 = var_13_0, 1, -1 do
			local var_13_6 = var_0_0.Panels[iter_13_0]

			var_13_6:setVisible(var_13_4)

			if not var_13_6._hideBg then
				var_13_4 = var_13_4 and false
			end

			if var_13_6:isVisible() then
				if not var_13_6._hideBg then
					table.insert(var_13_2, var_13_6)
				end

				if var_13_6.setBackGroundColorOpacity then
					if var_13_6._isNeedTransparent then
						var_13_6:setBackGroundColorOpacity(0)
					elseif var_13_5 == 0 then
						var_13_5 = var_0_0.DEFAULT_MASK_OPACITY

						var_13_6:setBackGroundColorOpacity(var_13_5)
					else
						var_13_6:setBackGroundColorOpacity(0)
					end
				end
			end
		end

		if var_13_1 ~= ClientData.SceneId.loading and var_13_1 ~= ClientData.SceneId.region and var_13_3:getLocalZOrder() ~= ClientData.ZOrder.indicator and var_13_3:getLocalZOrder() ~= ClientData.ZOrder.dialog then
			local var_13_7 = var_13_3._isShowResourceUI and var_13_3:getLocalZOrder() + 1 or ClientData.ZOrder.ui

			ClientView.getResourceUI():setLocalZOrder(var_13_7)
		end
	elseif var_13_1 ~= ClientData.SceneId.loading and var_13_1 ~= ClientData.SceneId.region then
		ClientView.getResourceUI():setLocalZOrder(ClientData.ZOrder.ui)
	end

	local var_13_8 = arg_13_0:getParent():getChildren()
	local var_13_9 = #var_13_2 > 0 and var_13_2[1]:getLocalZOrder() or -1
	local var_13_10 = #var_13_2 > 0 and var_13_2[#var_13_2]:getLocalZOrder() or -1

	for iter_13_1 = 2, #var_13_8 do
		if var_13_10 > var_13_8[iter_13_1]:getLocalZOrder() then
			var_13_8[iter_13_1]:setVisible(false)
		elseif var_13_9 < var_13_8[iter_13_1]:getLocalZOrder() then
			var_13_8[iter_13_1]:setVisible(true)
		end
	end
end

function var_0_0.addBackButton(arg_14_0)
	local var_14_0 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_15_0)
		arg_14_0:hide()
	end, ClientView.CRECT_BUTTON, 180)

	var_14_0:addLabel(Str(STR.BACK))
	var_14_0:setPosition(lc.w(arg_14_0) / 2, 60)
	var_14_0:setTouchRect(cc.rect(-20, -20, lc.w(var_14_0) + 40, lc.h(var_14_0) + 40))
	var_14_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	arg_14_0:addChild(var_14_0)

	arg_14_0._btnBack = var_14_0
end

function var_0_0.onPanelsExchangeScene()
	for iter_16_0, iter_16_1 in ipairs(BasePanel.Panels) do
		if iter_16_1.onExchangeScene then
			iter_16_1:onExchangeScene()
		end
	end
end

BasePanel = var_0_0

return var_0_0
