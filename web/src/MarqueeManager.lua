local var_0_0 = {
	Msgs = {}
}
local var_0_1 = 100

function var_0_0.attach(arg_1_0)
	local var_1_0 = var_0_0.Panel

	if var_1_0 == nil then
		local var_1_1 = lc.createSprite("img_marquee_bg")

		var_1_0 = lc.createNode(cc.size(ClientView.SCR_W - 360, lc.h(var_1_1)))

		var_1_0:setCascadeOpacityEnabled(true)
		var_1_1:setScaleX(lc.w(var_1_0) / lc.w(var_1_1))
		lc.addChildToCenter(var_1_0, var_1_1)
		var_1_0:retain()

		var_1_0._bg = var_1_1

		local var_1_2 = ClientView.createClipNode(nil, cc.rect(0, 0, lc.w(var_1_0), lc.h(var_1_0)))

		var_1_2:setCascadeColorEnabled(true)
		lc.addChildToCenter(var_1_0, var_1_2)

		var_1_0._clip = var_1_2
		var_0_0.Panel = var_1_0

		function var_1_0.removeMsg(arg_2_0)
			if arg_2_0._msg then
				arg_2_0._msg:removeFromParent()

				arg_2_0._msg = nil

				table.remove(var_0_0.Msgs, 1)

				if #var_0_0.Msgs == 0 and not arg_2_0._isFadingOut then
					arg_2_0:runAction(lc.sequence(lc.fadeOut(0.5), function()
						arg_2_0._isFadingOut = false
					end))

					arg_2_0._isFadingOut = true
				end
			end
		end

		var_1_0._listener = lc.addEventListener(Data.Event.message, function(arg_4_0)
			if arg_4_0._event == P._playerMessage.Event.msg_dirty and arg_4_0._type == Data.MsgType.bulletin then
				local var_4_0 = arg_4_0._param
				local var_4_1 = P._playerMessage._msgAll[Data.MsgType.bulletin]
				local var_4_2 = P._loginTime

				for iter_4_0 = 1, var_4_0 do
					local var_4_3 = var_4_1[iter_4_0]

					if var_4_3._needMarquee and math.floor(var_4_3._timestamp) > math.ceil(var_4_2) then
						var_0_0.push(string.format("#|%s|#%s", var_4_3._user._name, var_4_3._content))
					end
				end
			end
		end)

		lc.addChildToPos(arg_1_0, var_1_0, cc.p(lc.w(arg_1_0) / 2, 90))
	else
		var_1_0:setVisible(true)
		lc.changeParent(var_1_0, nil, arg_1_0)
	end

	var_1_0:setOpacity(#var_0_0.Msgs == 0 and 0 or 255)
	var_1_0:scheduleUpdateWithPriorityLua(var_0_0.update, 0)
end

function var_0_0.unattach()
	if var_0_0.Panel then
		var_0_0.Panel:removeFromParent(false)
	end
end

function var_0_0.release()
	var_0_0.Msgs = {}

	if var_0_0.Panel then
		lc.Dispatcher:removeEventListener(var_0_0.Panel._listener)
		var_0_0.Panel:removeFromParent()
		var_0_0.Panel:release()

		var_0_0.Panel = nil
	end
end

function var_0_0.push(arg_7_0, arg_7_1)
	if #arg_7_0 > var_0_1 then
		return false
	end

	table.insert(var_0_0.Msgs, arg_7_0)
	var_0_0.showPanel()

	return true
end

function var_0_0.pushArray(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
		if not var_0_0.push(iter_8_1, true) then
			break
		end
	end

	var_0_0.showPanel()
end

function var_0_0.stop()
	local var_9_0 = var_0_0.Panel

	if var_9_0 then
		var_9_0:setVisible(false)
	end
end

function var_0_0.showPanel()
	local var_10_0 = var_0_0.Panel

	if var_10_0 == nil or not var_10_0:isVisible() then
		return
	end

	var_10_0._isFadingOut = false

	var_10_0:stopAllActions()
	var_10_0:runAction(lc.fadeIn(0.5))
end

function var_0_0.update(arg_11_0)
	local var_11_0 = var_0_0.Msgs
	local var_11_1 = var_0_0.Panel

	if var_11_1 == nil or not var_11_1:isVisible() or #var_11_0 == 0 then
		return
	end

	if var_11_1._msg == nil then
		local var_11_2 = var_11_0[1]
		local var_11_3
		local var_11_4 = string.find(var_11_2, "#")

		if var_11_4 == 1 then
			local var_11_5 = string.find(var_11_2, "#", var_11_4 + 1)

			var_11_3 = string.sub(var_11_2, var_11_4 + 1, var_11_5 - 1)
			var_11_2 = string.sub(var_11_2, var_11_5 + 1)
		end

		local var_11_6 = {
			_fontSize = ClientView.FontSize.S2,
			_normalClr = ClientView.COLOR_TEXT_LIGHT,
			_boldClr = ClientView.COLOR_TEXT_PURPLE
		}
		local var_11_7

		if var_11_3 then
			var_11_7 = ClientView.createBoldRichText(var_11_3, ClientView.RICHTEXT_PARAM_LIGHT_S2)

			ClientView.appendBoldRichText(var_11_7, var_11_2, var_11_6)
			var_11_7:formatText()
		else
			var_11_7 = ClientView.createBoldRichText(var_11_2, var_11_6)
		end

		lc.addChildToPos(var_11_1._clip, var_11_7, cc.p(lc.w(var_11_1) + lc.w(var_11_7) / 2, lc.h(var_11_1) / 2))
		var_11_7:runAction(lc.sequence(lc.moveTo(20, -lc.w(var_11_7) / 2, lc.y(var_11_7)), function()
			var_11_1:removeMsg()
		end))

		var_11_1._msg = var_11_7
	end
end

MarqueeManager = var_0_0

return var_0_0
