local var_0_0 = class("BattleTaskDialog", lc.ExtendUIWidget)

BattleTaskDialog = var_0_0

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._battleUi = arg_2_1

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 == ccui.TouchEventType.ended then
			arg_2_0._battleUi:hideTask()
		end
	end)

	local var_2_0 = lc.createSprite("battle_task_bg")

	var_2_0:setPosition(ClientView.SCR_CW + 20, ClientView.SCR_CH + 40)
	arg_2_0:addChild(var_2_0)

	local var_2_1 = cc.p(var_2_0:getContentSize().width / 2, var_2_0:getContentSize().height / 2)
	local var_2_2 = arg_2_0._battleUi._player._battleCondition:getConditionDesc()
	local var_2_3 = cc.p(var_2_1.x, var_2_1.y + 10)

	for iter_2_0 = 1, #var_2_2 do
		local var_2_4 = cc.p(var_2_3.x, var_2_3.y - (iter_2_0 - 1) * 60)
		local var_2_5 = cc.Label:createWithTTF(var_2_2[iter_2_0], ClientView.TTF_FONT, ClientView.FontSize.S1)

		var_2_5:setPosition(var_2_4.x + 10, var_2_4.y)
		var_2_0:addChild(var_2_5)

		local var_2_6 = lc.createSprite("battle_task_star")

		lc.addChildToPos(var_2_0, var_2_6, cc.p(lc.left(var_2_5) - 30, var_2_4.y))
	end

	arg_2_0._bg = var_2_0

	local var_2_7 = cc.Director:getInstance():getScheduler():getTimeScale()

	var_2_0:setScale(0)
	var_2_0:runAction(cc.EaseBackOut:create(cc.ScaleTo:create(0.3 * var_2_7, 1)))

	local var_2_8 = ClientView.createTTF(Str(STR.CONTINUE), ClientView.FontSize.S1)

	var_2_8:setPosition(ClientView.SCR_CW, 40)
	var_2_8:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeIn:create(0.5), cc.DelayTime:create(0.5), cc.FadeOut:create(0.5))))
	arg_2_0:addChild(var_2_8)
end

function var_0_0.hide(arg_4_0)
	local var_4_0 = cc.Director:getInstance():getScheduler():getTimeScale()

	arg_4_0._bg:runAction(cc.Sequence:create(cc.EaseBackIn:create(cc.ScaleTo:create(0.2 * var_4_0, 0)), cc.CallFunc:create(function()
		arg_4_0:removeFromParent()
	end)))
end

return var_0_0
