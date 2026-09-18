local var_0_0 = class("BattlePVPDialog", function()
	return cc.Node:create()
end)

BattlePVPDialog = var_0_0
var_0_0.Type = {
	online = 1,
	offline = 2,
	thinking = 3
}

function var_0_0.create(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.new()

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._battleUi = arg_3_1

	if arg_3_2 == var_0_0.Type.online then
		arg_3_0:initOnline()
	elseif arg_3_2 == var_0_0.Type.offline then
		arg_3_0:initOffline()
	elseif arg_3_2 == var_0_0.Type.thinking then
		arg_3_0:initThinking()
	end
end

function var_0_0.initOnline(arg_4_0)
	local var_4_0 = DragonBones.create("zg")

	var_4_0:setPosition(ClientView.SCR_CW, ClientView.SCR_CH + 100)
	arg_4_0:addChild(var_4_0)
	var_4_0:gotoAndPlay("effect")

	local var_4_1 = var_4_0:getAnimationDuration("effect")

	var_4_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_4_1), cc.CallFunc:create(function()
		arg_4_0:hide()
	end)))
end

function var_0_0.initOffline(arg_6_0)
	local var_6_0 = DragonBones.create("zg2")

	var_6_0:setPosition(ClientView.SCR_CW, ClientView.SCR_H - 150)
	arg_6_0:addChild(var_6_0)
	var_6_0:gotoAndPlay("effect")

	local var_6_1 = var_6_0:getAnimationDuration("effect") * 3

	var_6_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_6_1), cc.CallFunc:create(function()
		arg_6_0:hide()
	end)))
end

function var_0_0.initThinking(arg_8_0)
	local var_8_0 = ccui.Scale9Sprite:createWithSpriteFrameName("img_tip_bg", ClientView.CRECT_TIP_BG)

	var_8_0:setContentSize(250, 130)
	var_8_0:setScale(0.6)
	arg_8_0:addChild(var_8_0)

	arg_8_0._bg = var_8_0

	local var_8_1 = cc.Label:createWithTTF(Str(STR.BATTLE_CHAT_THINKING), ClientView.TTF_FONT, ClientView.FontSize.M2)

	var_8_1:setColor(cc.c3b(0, 0, 0))
	arg_8_0:addChild(var_8_1)

	arg_8_0._prefix = var_8_1

	if arg_8_0._battleUi._player._stepStatus == BattleData.Status.wait_opponent then
		var_8_0:setFlippedX(arg_8_0._battleUi._isReverse)
		var_8_0:setFlippedY(not arg_8_0._battleUi._isReverse)
		var_8_0:setPosition(not arg_8_0._battleUi._isReverse and cc.p(ClientView.SCR_W - 330, ClientView.SCR_H - 34) or cc.p(200, 220))
		var_8_1:setPosition(not arg_8_0._battleUi._isReverse and cc.p(ClientView.SCR_W - 350, lc.y(var_8_0) - 10) or cc.p(180, lc.y(var_8_0) + 10))
	else
		var_8_0:setFlippedX(not arg_8_0._battleUi._isReverse)
		var_8_0:setFlippedY(arg_8_0._battleUi._isReverse)
		var_8_0:setPosition(arg_8_0._battleUi._isReverse and cc.p(ClientView.SCR_W - 330, ClientView.SCR_H - 34) or cc.p(200, 220))
		var_8_1:setPosition(arg_8_0._battleUi._isReverse and cc.p(ClientView.SCR_W - 350, lc.y(var_8_0) - 10) or cc.p(180, lc.y(var_8_0) + 10))
	end

	local var_8_2 = ". "
	local var_8_3 = ClientData.getCurrentTime()
	local var_8_4 = ClientData._battleRoundStartInfo._endTime
	local var_8_5 = var_8_4 ~= nil and var_8_3 < var_8_4 and var_8_4 - var_8_3 or 0
	local var_8_6 = cc.Label:createWithTTF(var_8_5 > 0 and " " .. math.floor(var_8_5) or var_8_2, ClientView.TTF_FONT, ClientView.FontSize.M2)

	var_8_6:setAnchorPoint(0, 0.5)
	var_8_6:setColor(cc.c3b(0, 0, 0))
	var_8_6:setPosition(lc.right(var_8_1) + 2, lc.y(var_8_1))
	arg_8_0:addChild(var_8_6)

	arg_8_0._dots = var_8_6

	local var_8_7 = 1

	var_8_6:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_8_7 = var_8_7 + 1

		if var_8_7 > 3 then
			var_8_7 = 1
		end

		local var_9_0 = ClientData.getCurrentTime()
		local var_9_1 = ClientData._battleRoundStartInfo._endTime
		local var_9_2 = var_9_1 ~= nil and var_9_0 < var_9_1 and var_9_1 - var_9_0 or 0
		local var_9_3 = ""

		if var_9_2 > 0 then
			var_9_3 = " " .. math.floor(var_9_2)
		else
			for iter_9_0 = 1, var_8_7 do
				var_9_3 = var_9_3 .. var_8_2
			end
		end

		var_8_6:setString(var_9_3)
	end))))
	arg_8_0:setVisible(false)
end

function var_0_0.hide(arg_10_0)
	arg_10_0:removeFromParent()
end

function var_0_0.reverse(arg_11_0)
	local var_11_0 = arg_11_0._bg
	local var_11_1 = arg_11_0._prefix

	if arg_11_0._battleUi._player._stepStatus == BattleData.Status.wait_opponent then
		var_11_0:setFlippedX(arg_11_0._battleUi._isReverse)
		var_11_0:setFlippedY(not arg_11_0._battleUi._isReverse)
		var_11_0:setPosition(not arg_11_0._battleUi._isReverse and cc.p(ClientView.SCR_W - 330, ClientView.SCR_H - 34) or cc.p(200, 220))
		var_11_1:setPosition(not arg_11_0._battleUi._isReverse and cc.p(ClientView.SCR_W - 350, lc.y(var_11_0) - 10) or cc.p(180, lc.y(var_11_0) + 10))
	else
		var_11_0:setFlippedX(not arg_11_0._battleUi._isReverse)
		var_11_0:setFlippedY(arg_11_0._battleUi._isReverse)
		var_11_0:setPosition(arg_11_0._battleUi._isReverse and cc.p(ClientView.SCR_W - 330, ClientView.SCR_H - 34) or cc.p(200, 220))
		var_11_1:setPosition(arg_11_0._battleUi._isReverse and cc.p(ClientView.SCR_W - 350, lc.y(var_11_0) - 10) or cc.p(180, lc.y(var_11_0) + 10))
	end

	arg_11_0._dots:setPosition(lc.right(var_11_1) + 2, lc.y(var_11_1))
end

return var_0_0
