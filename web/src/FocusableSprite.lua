local var_0_0 = class("FocusableSprite", lc.ExtendCCNode)

var_0_0.ActionTag = {
	focused = 2,
	focusing = 1
}

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_SPRITE)

	var_1_0:setSpriteFrame(arg_1_0)
	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0._isFocused = false
end

function var_0_0.setFocusFactor(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._basePos = arg_3_1
	arg_3_0._baseScale = arg_3_2 or 1
end

function var_0_0.focus(arg_4_0)
	if arg_4_0._isFocused then
		return true
	end

	arg_4_0._isFocused = true

	local var_4_0 = lc.spawn({
		lc.scaleTo(0.1, arg_4_0._baseScale * 1.2),
		lc.scaleTo(0.1, arg_4_0._baseScale)
	}, {
		lc.moveBy(0.1, 0, 16),
		lc.moveBy(0.1, 0, -16)
	})

	var_4_0:setTag(var_0_0.ActionTag.focused)
	arg_4_0:runAction(var_4_0)

	local var_4_1 = lc.rep(lc.sequence(lc.tintTo(0.5, 128, 128, 128), lc.tintTo(0.5, 255, 255, 255)))

	var_4_1:setTag(var_0_0.ActionTag.focusing)
	arg_4_0:runAction(var_4_1)

	return true
end

function var_0_0.unfocus(arg_5_0)
	if not arg_5_0._isFocused then
		return true
	end

	arg_5_0._isFocused = false

	arg_5_0:stopActionByTag(var_0_0.ActionTag.focused)
	arg_5_0:setScale(arg_5_0._baseScale)
	arg_5_0:setPosition(arg_5_0._basePos)
	arg_5_0:stopActionByTag(var_0_0.ActionTag.focusing)
	arg_5_0:setColor(lc.Color3B.white)

	return true
end

return var_0_0
