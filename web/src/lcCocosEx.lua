lc = lc or {}
lc.EXTEND_NODE = 0
lc.EXTEND_LAYER = 1
lc.EXTEND_SPRITE = 2
lc.EXTEND_SHADERSPRITE = 3
lc.EXTEND_LAYERCOLOR = 4
lc.EXTEND_SCALE9 = 5
lc.EXTEND_WIDGET = 0
lc.EXTEND_LAYOUT = 1
lc.EXTEND_LAYOUT_MASK = 2
lc.EXTEND_LIST = 3
lc.EXTEND_IMAGE = 4
lc.EXTEND_BUTTON = 5

function lc.ExtendUIWidget(arg_1_0, ...)
	local var_1_0

	if arg_1_0 == lc.EXTEND_WIDGET then
		var_1_0 = ccui.Widget:create(...)
	elseif arg_1_0 == lc.EXTEND_LAYOUT then
		var_1_0 = ccui.Layout:create(...)
	elseif arg_1_0 == lc.EXTEND_LAYOUT_MASK then
		var_1_0 = ccui.Layout:create()

		lc.initMaskLayer(var_1_0, ...)
	elseif arg_1_0 == lc.EXTEND_LIST then
		var_1_0 = ccui.ListView:create(...)
	elseif arg_1_0 == lc.EXTEND_IMAGE then
		var_1_0 = ccui.ImageView:create(...)
	elseif arg_1_0 == lc.EXTEND_BUTTON then
		var_1_0 = ClientView.createShaderButton(...)
	end

	var_1_0.__index = var_1_0

	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			if var_1_0.onEnter then
				var_1_0:onEnter()
			end
		elseif arg_2_0 == "exit" then
			if var_1_0.onExit then
				var_1_0:onExit()
			end
		elseif arg_2_0 == "enterTransitionFinish" then
			if var_1_0.onEnterTransitionFinish then
				var_1_0:onEnterTransitionFinish()
			end
		elseif arg_2_0 == "exitTransitionStart" then
			if var_1_0.onExitTransitionStart then
				var_1_0:onExitTransitionStart()
			end
		elseif arg_2_0 == "cleanup" and var_1_0.onCleanup then
			var_1_0:onCleanup()
		end
	end)

	return var_1_0
end

function lc.ExtendCCNode(arg_3_0, ...)
	local var_3_0

	if arg_3_0 == lc.EXTEND_NODE then
		var_3_0 = cc.Node:create(...)
	elseif arg_3_0 == lc.EXTEND_LAYER then
		var_3_0 = cc.Layer:create(...)
	elseif arg_3_0 == lc.EXTEND_SPRITE then
		var_3_0 = cc.Sprite:create(...)
	elseif arg_3_0 == lc.EXTEND_SHADERSPRITE then
		var_3_0 = cc.ShaderSprite:create(...)
	elseif arg_3_0 == lc.EXTEND_LAYERCOLOR then
		var_3_0 = cc.LayerColor:create(...)
	elseif arg_3_0 == lc.EXTEND_SCALE9 then
		var_3_0 = ccui.Scale9Sprite:createWithSpriteFrameName(...)
	end

	var_3_0.__index = var_3_0

	return var_3_0
end

function ccui.Widget.onClick(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_3 = arg_4_3 or 0.9

	arg_4_0:setTouchEnabled(true)

	arg_4_0._callback = arg_4_1

	arg_4_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

	local var_4_0 = arg_4_0:getScale()

	arg_4_0:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 == 0 then
			arg_4_0._oldScale = arg_4_0._oldScale or var_4_0

			arg_4_0:stopActionByTag(255)

			local var_5_0 = cc.ScaleTo:create(0.1, arg_4_3 * (arg_4_0._oldScale or var_4_0))

			var_5_0:setTag(255)
			arg_5_0:runAction(var_5_0)

			arg_4_0._isDoneLoseFocusEvent = false
		elseif arg_5_1 == 1 then
			-- block empty
		elseif arg_5_1 == 2 then
			arg_4_0:stopActionByTag(255)
			arg_4_0:setScale(arg_4_0._oldScale or var_4_0)

			if arg_4_0._callback then
				arg_4_0._callback(arg_4_0)
			end
		else
			if arg_4_0._isDoneLoseFocusEvent == true then
				return
			end

			arg_4_0._isDoneLoseFocusEvent = true

			arg_4_0:stopActionByTag(255)
			arg_4_0:setScale(arg_4_0._oldScale or var_4_0)
		end
	end)

	return arg_4_0
end
