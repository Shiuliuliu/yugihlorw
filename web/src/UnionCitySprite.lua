local var_0_0 = class("UnionCitySprite", lc.ExtendCCNode)

var_0_0.ActionTag = {
	focused = 2,
	focusing = 1
}

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_SHADERSPRITE)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._city = arg_2_1
	arg_2_0._isFocused = false

	arg_2_0:initSpriteFrame(arg_2_1)
	arg_2_0:registerScriptHandler(function(arg_3_0)
		if arg_3_0 == "enter" then
			arg_2_0:onEnter()
		elseif arg_3_0 == "exit" then
			arg_2_0:onExit()
		end
	end)
end

function var_0_0.onEnter(arg_4_0)
	arg_4_0:updateCity()
end

function var_0_0.onExit(arg_5_0)
	arg_5_0:removeFlag()
	arg_5_0:removeFire()
	arg_5_0:removeHalo()
end

function var_0_0.initSpriteFrame(arg_6_0, arg_6_1)
	local var_6_0 = string.format("union_war_city_%02d", arg_6_1._level)

	arg_6_0:setSpriteFrame(var_6_0)

	arg_6_0._baseScale = 1

	arg_6_0:setScale(arg_6_0._baseScale)
	arg_6_0:setAnchorPoint(0.5, 0.5)
	arg_6_0:setPosition(cc.p(arg_6_1._x, arg_6_1._y))
	ClientView.addFixityName(arg_6_0, arg_6_1._name, ClientView.COLOR_BMFONT)
end

function var_0_0.focus(arg_7_0)
	if arg_7_0._isFocused then
		return true
	end

	arg_7_0._isFocused = true

	local var_7_0 = cc.Spawn:create(cc.Sequence:create(cc.ScaleTo:create(0.1, arg_7_0._baseScale * 1.2), cc.ScaleTo:create(0.1, arg_7_0._baseScale)), cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 5)), cc.MoveBy:create(0.1, cc.p(0, -5))))

	var_7_0:setTag(var_0_0.ActionTag.focused)
	arg_7_0:runAction(var_7_0)

	local var_7_1 = cc.RepeatForever:create(cc.Sequence:create(cc.TintTo:create(0.5, 128, 128, 128), cc.TintTo:create(0.5, 255, 255, 255)))

	var_7_1:setTag(var_0_0.ActionTag.focusing)
	arg_7_0:runAction(var_7_1)

	return true
end

function var_0_0.unfocus(arg_8_0)
	if not arg_8_0._isFocused then
		return
	end

	arg_8_0._isFocused = false

	arg_8_0:stopActionByTag(var_0_0.ActionTag.focused)
	arg_8_0:setScale(arg_8_0._baseScale)
	arg_8_0:stopActionByTag(var_0_0.ActionTag.focusing)
	arg_8_0:setColor(lc.Color3B.white)
end

function var_0_0.updateCity(arg_9_0)
	arg_9_0:unscheduleUpdate()
	arg_9_0:unfocus()
	arg_9_0:addFlag()

	if arg_9_0._city._war ~= nil then
		arg_9_0:addFire()
	else
		arg_9_0:removeFire()
	end

	if arg_9_0._city._attacker ~= nil and arg_9_0._city._attacker._id == ClientData._player._unionId or arg_9_0._city._defender ~= nil and arg_9_0._city._defender._id == ClientData._player._unionId then
		arg_9_0:addHalo()
	else
		arg_9_0:removeHalo()
	end
end

function var_0_0.addFire(arg_10_0)
	if arg_10_0._fire == nil then
		local var_10_0 = ClientView.createSword()

		lc.addChildToPos(arg_10_0, var_10_0, cc.p(lc.w(arg_10_0) / 2, lc.h(arg_10_0) - 100), 2)

		arg_10_0._fire = var_10_0
	end
end

function var_0_0.removeFire(arg_11_0)
	if arg_11_0._fire ~= nil then
		arg_11_0._fire:removeFromParent()

		arg_11_0._fire = nil
	end
end

function var_0_0.addFlag(arg_12_0)
	if arg_12_0._flag == nil then
		arg_12_0._flag = ClientView.createWavingFlag(arg_12_0._city._owner ~= nil and arg_12_0._city._owner._badge or nil, arg_12_0._city._owner ~= nil and arg_12_0._city._owner._word or nil)

		lc.addChildToPos(arg_12_0, arg_12_0._flag, cc.p(lc.w(arg_12_0) / 2 - (arg_12_0._city._level == 1 and 8 or 0), lc.h(arg_12_0) - lc.h(arg_12_0._flag) - 16), -1)
		arg_12_0._flag:startWave()
	end
end

function var_0_0.removeFlag(arg_13_0)
	if arg_13_0._flag ~= nil then
		arg_13_0._flag:stopWave()
		arg_13_0._flag:removeFromParent()

		arg_13_0._flag = nil
	end
end

function var_0_0.addHalo(arg_14_0)
	if arg_14_0._haloEffect == nil then
		local var_14_0 = cc.Sprite:createWithSpriteFrameName("union_war_halo")
		local var_14_1 = {
			1,
			0.6,
			0.4,
			0.4
		}
		local var_14_2 = {
			80,
			70,
			60,
			50
		}

		lc.addChildToPos(arg_14_0, var_14_0, cc.p(lc.w(arg_14_0) / 2, lc.h(arg_14_0) / 2 - var_14_2[arg_14_0._city._level]), -1)
		var_14_0:runAction(cc.Repeat:create(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.4, 2 * var_14_1[arg_14_0._city._level]), cc.FadeTo:create(0.4, 128)), cc.Spawn:create(cc.ScaleTo:create(0.4, 1.5 * var_14_1[arg_14_0._city._level]), cc.FadeTo:create(0.4, 255))), -1))

		arg_14_0._haloEffect = var_14_0
	end

	if arg_14_0._haloParticle == nil then
		-- block empty
	end
end

function var_0_0.removeHalo(arg_15_0)
	if arg_15_0._haloEffect ~= nil then
		arg_15_0._haloEffect:removeFromParent()

		arg_15_0._haloEffect = nil
	end

	if arg_15_0._haloParticle ~= nil then
		arg_15_0._haloParticle:removeFromParent()

		arg_15_0._haloParticle = nil
	end
end

return var_0_0
