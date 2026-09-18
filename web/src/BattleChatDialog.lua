local var_0_0 = class("BattleChatDialog", lc.ExtendUIWidget)

BattleChatDialog = var_0_0

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._battleUi = arg_2_1

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 == ccui.TouchEventType.ended then
			arg_2_0:hide()
		end
	end)

	if arg_2_2 then
		for iter_2_0, iter_2_1 in pairs(Data._pvpChatInfo) do
			local var_2_0 = Str(iter_2_1._nameSid)
			local var_2_1 = iter_2_0 % 2 == 0
			local var_2_2 = math.floor((iter_2_0 - 1) / 2) + 1
			local var_2_3 = cc.p(350 + 160 * (var_2_1 and -1 or 1), 110 * var_2_2 + 30)
			local var_2_4 = cc.size(300, 130)

			arg_2_0:addChatWidget(arg_2_2, var_2_0, var_2_3, var_2_4, var_2_1)
		end
	else
		local var_2_5 = Str(arg_2_1._isIgnoreChat and STR.SHOW_CHAT or STR.IGNORE_CHAT)
		local var_2_6 = false
		local var_2_7 = cc.p(ClientView.SCR_W - 180, ClientView.SCR_H - 140)
		local var_2_8 = cc.size(300, 130)

		arg_2_0:addChatWidget(arg_2_2, var_2_5, var_2_7, var_2_8, var_2_6)
	end
end

function var_0_0.hide(arg_4_0)
	arg_4_0:removeFromParent()
end

function var_0_0.addChatWidget(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = ccui.Widget:create()

	var_5_0:setContentSize(arg_5_4)
	var_5_0:setTouchEnabled(true)
	var_5_0:setAnchorPoint(0.5, 0.5)
	var_5_0:setPosition(arg_5_3)
	arg_5_0:addChild(var_5_0)
	var_5_0:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 == ccui.TouchEventType.began then
			var_5_0:stopAllActions()
			var_5_0:runAction(cc.ScaleTo:create(0.08, 0.9))
		elseif arg_6_1 == ccui.TouchEventType.canceled then
			var_5_0:stopAllActions()
			var_5_0:runAction(cc.ScaleTo:create(0.08, 1))
		elseif arg_6_1 == ccui.TouchEventType.ended then
			local var_6_0 = arg_5_0._battleUi
			pcall(function()
				if var_6_0 then
					var_6_0._chatCDScheduler = lc.Scheduler:scheduleScriptFunc(function(arg_7_0)
						pcall(function()
							if var_6_0 and var_6_0._chatCDScheduler then
								lc.Scheduler:unscheduleScriptEntry(var_6_0._chatCDScheduler)
								var_6_0._chatCDScheduler = nil
							end
						end)
					end, 10, false)

					if arg_5_1 then
						pcall(function() var_6_0:addChat(var_6_0._player, arg_5_2) end)
						pcall(function() ClientData.sendBattleChat(arg_5_2) end)
					else
						var_6_0._isIgnoreChat = not var_6_0._isIgnoreChat
					end
				end
			end)

			pcall(function() arg_5_0:hide() end)
		end
	end)

	local var_5_1 = ccui.Scale9Sprite:createWithSpriteFrameName("img_tip_bg", ClientView.CRECT_TIP_BG)

	var_5_1:setContentSize(arg_5_4)
	var_5_1:setFlippedX(arg_5_5)
	var_5_1:setFlippedY(not arg_5_1)
	var_5_1:setPosition(arg_5_4.width / 2, arg_5_4.height / 2)
	var_5_0:addChild(var_5_1)

	local var_5_2 = ClientView.createTTF(arg_5_2, ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)

	var_5_2:setPosition(cc.p(arg_5_4.width / 2, arg_5_1 and 80 or 50))
	var_5_0:addChild(var_5_2)
	var_5_0:setScale(0.3)
	var_5_0:runAction(cc.EaseBackOut:create(cc.ScaleTo:create(0.3, 1)))
end

return var_0_0
