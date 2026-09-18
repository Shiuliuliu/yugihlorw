local var_0_0 = class("FreeShowPanel", lc.ExtendCCNode)

var_0_0.STATE_IDLE = 0
var_0_0.STATE_MOVING = 1
var_0_0.STATE_MOVING_INERTIA = 2
var_0_0.STATE_MOVING_BACK = 3
var_0_0.STATE_SCALING = 4
var_0_0.STATE_SCALING_BACK = 5
var_0_0.STATE_SCALING_WAITING = 6
var_0_0.Event = {
	offset = "FREESHOWPANEL_OFFSET",
	animate_stopped = "FREESHOWPANEL_ANIMATE_STOPPED",
	scale = "FREESHOWPANEL_SCALE"
}

local var_0_1 = 100
local var_0_2 = 4
local var_0_3 = 400
local var_0_4 = lc.Scheduler
local var_0_5
local var_0_6

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYER)

	var_1_0:ignoreAnchorPointForPosition(false)
	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:setContentSize(arg_2_1 or {})

	arg_2_0._moveBufferRatio = {
		t = 0,
		l = 0,
		b = 0,
		r = 0
	}
	arg_2_0._moveBackTime = 0.4
	arg_2_0._moveDampFactor = 0.3
	arg_2_0._moveVelocity = {
		x = 0,
		y = 0
	}
	arg_2_0._moveAcc = {
		x = 0,
		y = 0
	}
	arg_2_0._moveBackPos = {
		x = 0,
		y = 0
	}
	arg_2_0._touchCount = 0
	arg_2_0._touchEnabled = true
	arg_2_0._state = var_0_0.STATE_IDLE
	arg_2_0._scheduleId = {}
	arg_2_0._moveBound = {
		width = 0,
		height = 0,
		x = 0,
		y = 0
	}
	arg_2_0._maxMoveVelocity = 1000
	arg_2_0._moveRestrictDir = arg_2_2 or lc.Dir.none
	arg_2_0._isSupportScale = arg_2_3

	if arg_2_0._isSupportScale then
		arg_2_0._scaleMin = 0.5
		arg_2_0._scaleMax = 1
		arg_2_0._scaleBackTime = 0.4
		arg_2_0._scaleDampFactor = 0.3
		arg_2_0._scaleWaitingInterval = 0.1
	else
		arg_2_0._scaleMin = 1
		arg_2_0._scaleMax = 1
	end

	arg_2_0._scaleMinBuffer = 0
	arg_2_0._scaleMaxBuffer = 0

	arg_2_0:registerScriptHandler(function(arg_3_0)
		if arg_3_0 == "enter" then
			arg_2_0:onEnter()
		elseif arg_3_0 == "exit" then
			arg_2_0:onExit()
		end
	end)
end

function var_0_0.onEnter(arg_4_0)
	local function var_4_0(arg_5_0)
		if arg_4_0:onGesture(arg_5_0) then
			arg_5_0:stopPropagation()
		end
	end

	if arg_4_0._moveRestrictDir == lc.Dir.none then
		lc.addGestureEventListener(lc.Gesture.GestureEvent.pan, var_4_0, arg_4_0)
	else
		lc.addGestureEventListener(lc.Gesture.GestureEvent.swipe, var_4_0, arg_4_0)
	end

	if arg_4_0._isSupportScale then
		lc.addGestureEventListener(lc.Gesture.GestureEvent.pinch, var_4_0, arg_4_0)
	end

	lc.addGestureEventListener(lc.Gesture.TouchEvent.began, var_4_0, arg_4_0)
	lc.addGestureEventListener(lc.Gesture.TouchEvent.ended, var_4_0, arg_4_0)
	lc.addGestureEventListener(lc.Gesture.TouchEvent.cancelled, var_4_0, arg_4_0)

	if lc.PLATFORM == cc.PLATFORM_OS_WINDOWS then
		local var_4_1 = cc.EventListenerMouse:create()

		var_4_1:registerScriptHandler(function(arg_6_0)
			if GuideManager.isGuideEnabled() then
				return
			end

			local var_6_0 = {
				x = arg_6_0:getCursorX(),
				y = arg_6_0:getCursorY()
			}
			local var_6_1 = arg_6_0:getScrollY()

			if arg_4_0._isSupportScale then
				arg_4_0._state = var_0_0.STATE_SCALING
				arg_4_0._scaleLocalCenter = arg_4_0:convertToNodeSpace(var_6_0)

				local var_6_2 = var_6_1 < 0 and 1.1 or 0.9

				arg_4_0:scaleView(var_6_2)

				local var_6_3 = lc.convertPos(arg_4_0._scaleLocalCenter, arg_4_0, arg_4_0:getParent())
				local var_6_4 = lc.convertPos(arg_4_0:convertToNodeSpace(var_6_0), arg_4_0, arg_4_0:getParent())
				local var_6_5 = {
					x = var_6_4.x - var_6_3.x,
					y = var_6_4.y - var_6_3.y
				}

				arg_4_0:moveView(var_6_5)

				arg_4_0._state = var_0_0.STATE_IDLE

				if not arg_4_0:checkScaleBack() then
					arg_4_0:checkMoveBack()
				end
			end
		end, cc.Handler.EVENT_MOUSE_SCROLL)
		arg_4_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_4_1, arg_4_0)
	end

	arg_4_0._touchCount = 0
	var_0_5 = -1
	var_0_6 = -1
end

function var_0_0.onExit(arg_7_0)
	arg_7_0:removeAllSchedulers()
	arg_7_0:getEventDispatcher():removeEventListenersForTarget(arg_7_0)
end

function var_0_0.setMoveBufferRatio(arg_8_0, ...)
	local var_8_0 = {
		...
	}
	local var_8_1 = #var_8_0
	local var_8_2 = arg_8_0._moveBufferRatio

	if var_8_1 == 1 then
		var_8_2.l, var_8_2.r, var_8_2.t, var_8_2.b = var_8_0[1], var_8_0[1], var_8_0[1], var_8_0[1]
	elseif var_8_1 == 2 then
		var_8_2.l, var_8_2.r, var_8_2.t, var_8_2.b = var_8_0[1], var_8_0[1], var_8_0[2], var_8_0[2]
	elseif var_8_1 == 4 then
		var_8_2.l, var_8_2.r, var_8_2.t, var_8_2.b = var_8_0[1], var_8_0[2], var_8_0[3], var_8_0[4]
	else
		assert(false, "[FreeShowPanel:setMoveBufferRatio] Argument count is not 1, 2, 4!")
	end
end

function var_0_0.setMoveBoundSize(arg_9_0, arg_9_1)
	arg_9_0._moveBound.width = arg_9_1.width
	arg_9_0._moveBound.height = arg_9_1.height
end

function var_0_0.onGesture(arg_10_0, arg_10_1)
	assert(arg_10_0._moveBound.width ~= 0 and arg_10_0._moveBound.height ~= 0, "The size of move bound must be set!")

	if not arg_10_0._touchEnabled or not arg_10_0:checkWorking() or GuideManager.isGuideEnabled() then
		return
	end

	local var_10_0 = arg_10_1:getEventName()

	if var_10_0 == lc.Gesture.TouchEvent.began then
		local var_10_1 = arg_10_1.touch

		if var_10_1.id == 1 or var_10_1.id == 2 then
			arg_10_0:removeAllSchedulers()

			arg_10_0._state = var_0_0.STATE_IDLE
			arg_10_0._moveVelocity = {
				x = 0,
				y = 0
			}

			if arg_10_0._isSupportScale then
				arg_10_0._scaleVelocity = 0
			end

			if arg_10_0._touchCount == 0 then
				var_0_5 = var_10_1.id
			else
				var_0_6 = var_10_1.id
			end

			arg_10_0._touchCount = arg_10_0._touchCount + 1
		end
	elseif var_10_0 == lc.Gesture.TouchEvent.ended or var_10_0 == lc.Gesture.TouchEvent.cancelled then
		if var_10_0 == lc.Gesture.TouchEvent.cancelled and arg_10_1.exceptTarget == arg_10_0 then
			return
		end

		local var_10_2 = arg_10_1.touch

		if arg_10_0._state == var_0_0.STATE_MOVING then
			if arg_10_0:isTouchValidAndRemove(var_10_2) then
				local var_10_3 = math.abs(arg_10_0._moveVelocity.x)
				local var_10_4 = math.abs(arg_10_0._moveVelocity.y)

				if var_10_3 > var_0_3 or var_10_4 > var_0_3 then
					arg_10_0:startMoveInertially(var_10_3, var_10_4)
				elseif not arg_10_0._isSupportScale or not arg_10_0:checkScaleBack() then
					arg_10_0:checkMoveBack()
				end
			end
		elseif arg_10_0._state == var_0_0.STATE_SCALING then
			if arg_10_0:isTouchValidAndRemove(var_10_2) then
				arg_10_0._state = var_0_0.STATE_SCALING_WAITING
				arg_10_0._scheduleId.scaleWaitingTimeout = var_0_4:scheduleScriptFunc(function(arg_11_0)
					arg_10_0._state = var_0_0.STATE_MOVING

					var_0_4:unscheduleScriptEntry(arg_10_0._scheduleId.scaleWaitingTimeout)
				end, arg_10_0._scaleWaitingInterval, false)
			end
		elseif arg_10_0._state == var_0_0.STATE_SCALING_WAITING then
			if arg_10_0:isTouchValidAndRemove(var_10_2) then
				var_0_4:unscheduleScriptEntry(arg_10_0._scheduleId.scaleWaitingTimeout)

				arg_10_0._state = var_0_0.STATE_IDLE

				if not arg_10_0._isSupportScale or not arg_10_0:checkScaleBack() then
					arg_10_0:checkMoveBack()
				end
			end
		elseif arg_10_0:isTouchValidAndRemove(var_10_2) and arg_10_0._touchCount == 0 and (not arg_10_0._isSupportScale or not arg_10_0:checkScaleBack()) then
			arg_10_0:checkMoveBack()
		end
	elseif var_10_0 == lc.Gesture.GestureEvent.swipe then
		if GuideManager.isGuideEnabled() then
			return
		end

		local var_10_5 = arg_10_1.gesture
		local var_10_6 = var_10_5.touch

		if var_0_5 == var_10_6.id then
			local var_10_7 = var_10_6.budgedDir

			if arg_10_0._moveRestrictDir == var_10_7 then
				local var_10_8 = var_10_5:getOffset(arg_10_0:getParent())

				arg_10_0:handleTouchOffset(var_10_5, var_10_7 == lc.Dir.horizontal and {
					y = 0,
					x = var_10_8
				} or {
					x = 0,
					y = var_10_8
				})
			end
		end
	elseif var_10_0 == lc.Gesture.GestureEvent.pan then
		if GuideManager.isGuideEnabled() then
			return
		end

		local var_10_9 = arg_10_1.gesture
		local var_10_10 = var_10_9.touch

		if var_0_5 == var_10_10.id and arg_10_0._moveRestrictDir == lc.Dir.none and var_10_10.budgedDir ~= lc.Dir.none then
			arg_10_0:handleTouchOffset(var_10_9, var_10_9:getOffset(arg_10_0:getParent()))
		end
	elseif var_10_0 == lc.Gesture.GestureEvent.pinch then
		if GuideManager.isGuideEnabled() then
			return
		end

		if arg_10_0._isSupportScale and arg_10_0._touchCount == 2 then
			local var_10_11 = arg_10_1.gesture
			local var_10_12 = var_10_11.touch1
			local var_10_13 = var_10_11.touch2
			local var_10_14 = false

			if arg_10_0._state == var_0_0.STATE_IDLE then
				arg_10_0._state = var_0_0.STATE_SCALING
				arg_10_0._scaleLocalCenter = var_10_11:getCenter(arg_10_0)

				local var_10_15 = true
			end

			local var_10_16 = arg_10_0:getParent()
			local var_10_17 = var_10_11:getScale(var_10_16)
			local var_10_18 = arg_10_0:scaleView(var_10_17)
			local var_10_19 = var_10_16:convertToNodeSpace(arg_10_0:convertToWorldSpace(arg_10_0._scaleLocalCenter))
			local var_10_20 = var_10_11:getCenter(var_10_16)
			local var_10_21 = cc.p(var_10_20.x - var_10_19.x, var_10_20.y - var_10_19.y)
			local var_10_22 = arg_10_0:moveView(var_10_21)

			lc.Gesture.cancelTouch(var_10_12, arg_10_0)
			lc.Gesture.cancelTouch(var_10_13, arg_10_0)
		end
	end
end

function var_0_0.removeAllSchedulers(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._scheduleId) do
		var_0_4:unscheduleScriptEntry(iter_12_1)
	end
end

function var_0_0.isTouchValidAndRemove(arg_13_0, arg_13_1)
	if arg_13_0._touchCount == 1 then
		var_0_5 = -1
		arg_13_0._touchCount = arg_13_0._touchCount - 1

		return true
	elseif arg_13_0._touchCount == 2 then
		if var_0_5 == arg_13_1.id then
			var_0_5 = var_0_6
		end

		var_0_6 = -1
		arg_13_0._touchCount = arg_13_0._touchCount - 1

		return true
	end

	return false
end

function var_0_0.handleTouchOffset(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2.x == 0 and arg_14_2.y == 0 then
		return
	end

	local var_14_0 = false

	if arg_14_0._state == var_0_0.STATE_IDLE then
		arg_14_0._state = var_0_0.STATE_MOVING

		local var_14_1 = true
	end

	local var_14_2 = arg_14_0:moveView(arg_14_2)

	arg_14_0._moveVelocity = arg_14_1:getVelocity()

	if arg_14_0._moveVelocity.x >= 0 then
		arg_14_0._moveVelocity.x = math.min(arg_14_0._moveVelocity.x, arg_14_0._maxMoveVelocity)
	else
		arg_14_0._moveVelocity.x = math.max(arg_14_0._moveVelocity.x, -arg_14_0._maxMoveVelocity)
	end

	if arg_14_0._moveVelocity.y >= 0 then
		arg_14_0._moveVelocity.y = math.min(arg_14_0._moveVelocity.y, arg_14_0._maxMoveVelocity)
	else
		arg_14_0._moveVelocity.y = math.max(arg_14_0._moveVelocity.y, -arg_14_0._maxMoveVelocity)
	end

	lc.Gesture.cancelTouch(arg_14_1.touch)
end

function var_0_0.moveView(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._moveBound
	local var_15_1 = var_15_0.y + var_15_0.height
	local var_15_2 = var_15_0.x + var_15_0.width
	local var_15_3 = arg_15_0._moveBufferRatio
	local var_15_4 = arg_15_0._moveDampFactor
	local var_15_5 = lc.sw(arg_15_0)
	local var_15_6 = lc.sh(arg_15_0)
	local var_15_7 = false
	local var_15_8 = lc.left(arg_15_0)

	if arg_15_1.x > 0 and var_15_8 > var_15_0.x - var_15_3.l * var_15_5 then
		arg_15_1.x = arg_15_1.x * var_15_4
		var_15_7 = true
	end

	if var_15_8 + arg_15_1.x > var_15_0.x then
		arg_15_1.x = var_15_0.x - var_15_8
		var_15_7 = true
	end

	if not var_15_7 then
		local var_15_9 = lc.right(arg_15_0)

		if var_15_9 < var_15_2 + var_15_3.r * var_15_5 then
			arg_15_1.x = arg_15_1.x * var_15_4
		end

		if var_15_2 > var_15_9 + arg_15_1.x then
			arg_15_1.x = var_15_2 - var_15_9
		end
	end

	local var_15_10 = false
	local var_15_11 = lc.bottom(arg_15_0)

	if var_15_11 > var_15_0.y - var_15_3.b * var_15_6 then
		arg_15_1.y = arg_15_1.y * var_15_4
	end

	if var_15_11 + arg_15_1.y > var_15_0.y then
		arg_15_1.y = var_15_0.y - var_15_11
	end

	if not var_15_10 then
		local var_15_12 = lc.top(arg_15_0)

		if var_15_12 < var_15_1 + var_15_3.t * var_15_6 then
			arg_15_1.y = arg_15_1.y * var_15_4
		end

		if var_15_1 > var_15_12 + arg_15_1.y then
			arg_15_1.y = var_15_1 - var_15_12
		end
	end

	arg_15_0:setPosOffsetWithEvent(arg_15_1.x, arg_15_1.y)

	return arg_15_1
end

function var_0_0.startMoveInertially(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = var_0_1 / (arg_16_1 + arg_16_2)

	arg_16_0._moveAcc.x, arg_16_0._moveAcc.y = var_16_0 * arg_16_1 / lc.FPS, var_16_0 * arg_16_2 / lc.FPS
	arg_16_0._state = var_0_0.STATE_MOVING_INERTIA
	arg_16_0._scheduleId.moveInertially = var_0_4:scheduleScriptFunc(function(arg_17_0)
		arg_16_0:moveInertially(arg_17_0)
	end, lc.FPS, false)
end

function var_0_0.moveInertially(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._moveBound
	local var_18_1 = false
	local var_18_2 = lc.sw(arg_18_0)
	local var_18_3 = arg_18_0._moveBufferRatio.l * var_18_2
	local var_18_4 = arg_18_0._moveBufferRatio.r * var_18_2
	local var_18_5 = lc.left(arg_18_0)
	local var_18_6 = lc.right(arg_18_0)
	local var_18_7 = arg_18_0._moveVelocity.x > 0 and -arg_18_0._moveAcc.x or arg_18_0._moveAcc.x

	if var_18_3 > 0 and var_18_5 - (var_18_0.x - var_18_3) > 0 then
		var_18_7 = var_18_7 * ((var_18_5 - (var_18_0.x - var_18_3)) * var_0_2 / var_18_3 + 1)
	elseif var_18_4 > 0 and var_18_6 - (var_18_0.x + var_18_0.width + var_18_4) < 0 then
		var_18_7 = var_18_7 * ((var_18_6 - (var_18_0.x + var_18_0.width + var_18_4)) * var_0_2 / var_18_4 + 1)
	end

	local var_18_8 = arg_18_0._moveVelocity.x
	local var_18_9 = var_18_8 > 0 and 1 or -1

	arg_18_0._moveVelocity.x = arg_18_0._moveVelocity.x + var_18_7 * arg_18_1

	local var_18_10 = (var_18_9 * math.min(math.abs(var_18_8), arg_18_0._maxMoveVelocity) + var_18_9 * math.min(math.abs(arg_18_0._moveVelocity.x), arg_18_0._maxMoveVelocity)) / 2 * arg_18_1

	if var_18_5 + var_18_10 > var_18_0.x then
		var_18_1 = true
		var_18_10 = var_18_0.x - var_18_5
	elseif var_18_6 + var_18_10 < var_18_0.x + var_18_0.width then
		var_18_1 = true
		var_18_10 = var_18_0.x + var_18_0.width - var_18_6
	end

	local var_18_11 = false

	if not var_18_1 and (var_18_7 <= 0 and arg_18_0._moveVelocity.x <= 0 or var_18_7 >= 0 and arg_18_0._moveVelocity.x >= 0) then
		arg_18_0._moveAcc.x, arg_18_0._moveVelocity.x = 0, 0
		var_18_11 = true
	end

	local var_18_12 = lc.sh(arg_18_0)
	local var_18_13 = arg_18_0._moveBufferRatio.t * var_18_12
	local var_18_14 = arg_18_0._moveBufferRatio.b * var_18_12
	local var_18_15 = lc.top(arg_18_0)
	local var_18_16 = lc.bottom(arg_18_0)
	local var_18_17 = arg_18_0._moveVelocity.y > 0 and -arg_18_0._moveAcc.y or arg_18_0._moveAcc.y

	if var_18_14 > 0 and var_18_16 - (var_18_0.y - var_18_14) > 0 then
		var_18_17 = var_18_17 * ((var_18_16 - (var_18_0.y - var_18_14)) * var_0_2 / var_18_14 + 1)
	elseif var_18_13 > 0 and var_18_15 - (var_18_0.y + var_18_0.height + var_18_13) < 0 then
		var_18_17 = var_18_17 * ((var_18_15 - (var_18_0.y + var_18_0.height + var_18_13)) * var_0_2 / var_18_13 + 1)
	end

	local var_18_18 = arg_18_0._moveVelocity.y
	local var_18_19 = var_18_18 > 0 and 1 or -1

	arg_18_0._moveVelocity.y = arg_18_0._moveVelocity.y + var_18_17 * arg_18_1

	local var_18_20 = (var_18_19 * math.min(math.abs(var_18_18), arg_18_0._maxMoveVelocity) + var_18_19 * math.min(math.abs(arg_18_0._moveVelocity.y), arg_18_0._maxMoveVelocity)) / 2 * arg_18_1

	if var_18_16 + var_18_20 > var_18_0.y then
		var_18_1 = true
		var_18_20 = var_18_0.y - var_18_16
	elseif var_18_15 + var_18_20 < var_18_0.y + var_18_0.height then
		var_18_1 = true
		var_18_20 = var_18_0.y + var_18_0.height - var_18_15
	end

	if not var_18_1 and (var_18_17 <= 0 and arg_18_0._moveVelocity.y <= 0 or var_18_17 >= 0 and arg_18_0._moveVelocity.y >= 0) then
		arg_18_0._moveAcc.y, arg_18_0._moveVelocity.y = 0, 0

		if var_18_11 then
			var_18_1 = true
		end
	end

	arg_18_0:setPosOffsetWithEvent(var_18_10, var_18_20)

	if var_18_1 then
		arg_18_0._state = var_0_0.STATE_IDLE

		var_0_4:unscheduleScriptEntry(arg_18_0._scheduleId.moveInertially)
		arg_18_0:checkMoveBack()
	end
end

function var_0_0.checkMoveBack(arg_19_0, arg_19_1)
	if arg_19_0._isAnimating then
		return false
	end

	local var_19_0 = arg_19_0:getScale()

	if arg_19_1 then
		arg_19_0:setScale(arg_19_1)
	end

	local var_19_1 = arg_19_0._moveBound
	local var_19_2 = arg_19_0._moveBufferRatio
	local var_19_3 = lc.left(arg_19_0)
	local var_19_4 = lc.right(arg_19_0)
	local var_19_5 = lc.sw(arg_19_0)
	local var_19_6 = false
	local var_19_7 = 0

	if var_19_2.l > 0 or var_19_2.r > 0 then
		local var_19_8 = var_19_1.x - var_19_2.l * var_19_5
		local var_19_9 = var_19_1.x + var_19_1.width + var_19_2.r * var_19_5

		if var_19_8 - var_19_3 < -0.001 then
			arg_19_0._moveBackPos.x = var_19_8
			var_19_7 = var_19_8 - var_19_3
			var_19_6 = true
		elseif var_19_9 - var_19_4 > 0.001 then
			arg_19_0._moveBackPos.x = var_19_9
			var_19_7 = var_19_9 - var_19_4
			var_19_6 = true
		end

		if not var_19_6 then
			arg_19_0._moveAcc.x, arg_19_0._moveVelocity.x = 0, 0
		end
	end

	local var_19_10 = lc.top(arg_19_0)
	local var_19_11 = lc.bottom(arg_19_0)
	local var_19_12 = lc.sh(arg_19_0)
	local var_19_13 = false
	local var_19_14 = 0

	if var_19_2.b > 0 or var_19_2.t > 0 then
		local var_19_15 = var_19_1.y - var_19_2.b * var_19_12
		local var_19_16 = var_19_1.y + var_19_1.height + var_19_2.t * var_19_12

		if var_19_15 - var_19_11 < -0.001 then
			arg_19_0._moveBackPos.y = var_19_15
			var_19_14 = var_19_15 - var_19_11
			var_19_13 = true
		elseif var_19_16 - var_19_10 > 0.001 then
			arg_19_0._moveBackPos.y = var_19_16
			var_19_14 = var_19_16 - var_19_10
			var_19_13 = true
		end

		if not var_19_13 then
			arg_19_0._moveAcc.y, arg_19_0._moveVelocity.y = 0, 0
		end
	end

	if arg_19_1 then
		arg_19_0:setScale(var_19_0)
	end

	if var_19_6 or var_19_13 then
		if var_19_6 then
			arg_19_0._moveVelocity.x = (var_19_7 + var_19_7) / arg_19_0._moveBackTime
			arg_19_0._moveAcc.x = -arg_19_0._moveVelocity.x / arg_19_0._moveBackTime
		end

		if var_19_13 then
			arg_19_0._moveVelocity.y = (var_19_14 + var_19_14) / arg_19_0._moveBackTime
			arg_19_0._moveAcc.y = -arg_19_0._moveVelocity.y / arg_19_0._moveBackTime
		end

		arg_19_0._state = var_0_0.STATE_MOVING_BACK

		if arg_19_0._scheduleId.moveBack then
			var_0_4:unscheduleScriptEntry(arg_19_0._scheduleId.moveBack)
		end

		arg_19_0._scheduleId.moveBack = var_0_4:scheduleScriptFunc(function(arg_20_0)
			arg_19_0:moveBack(arg_20_0)
		end, lc.FPS, false)

		return true
	else
		if arg_19_0._state ~= var_0_0.STATE_SCALING_BACK then
			arg_19_0._state = var_0_0.STATE_IDLE
		end

		return false
	end
end

function var_0_0.moveBack(arg_21_0, arg_21_1)
	local var_21_0 = false
	local var_21_1 = arg_21_0._moveAcc
	local var_21_2 = arg_21_0._moveVelocity.x

	arg_21_0._moveVelocity.x = arg_21_0._moveVelocity.x + var_21_1.x * arg_21_1

	local var_21_3 = (var_21_2 + arg_21_0._moveVelocity.x) / 2 * arg_21_1

	if var_21_1.x > 0 and arg_21_0._moveVelocity.x >= 0 then
		var_21_3 = arg_21_0._moveBackPos.x - lc.left(arg_21_0)
		var_21_0 = true
	elseif var_21_1.x < 0 and arg_21_0._moveVelocity.x <= 0 then
		var_21_3 = arg_21_0._moveBackPos.x - lc.right(arg_21_0)
		var_21_0 = true
	end

	local var_21_4 = arg_21_0._moveVelocity.y

	arg_21_0._moveVelocity.y = arg_21_0._moveVelocity.y + var_21_1.y * arg_21_1

	local var_21_5 = (var_21_4 + arg_21_0._moveVelocity.y) / 2 * arg_21_1

	if var_21_1.y < 0 and arg_21_0._moveVelocity.y <= 0 then
		var_21_5 = arg_21_0._moveBackPos.y - lc.top(arg_21_0)
		var_21_0 = true
	elseif var_21_1.y > 0 and arg_21_0._moveVelocity.y >= 0 then
		var_21_5 = arg_21_0._moveBackPos.y - lc.bottom(arg_21_0)
		var_21_0 = true
	end

	arg_21_0:setPosOffsetWithEvent(var_21_3, var_21_5)

	if var_21_0 then
		arg_21_0._state = var_0_0.STATE_IDLE

		var_0_4:unscheduleScriptEntry(arg_21_0._scheduleId.moveBack)

		arg_21_0._scheduleId.moveBack = nil
	end
end

function var_0_0.scaleView(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getScale()

	if var_22_0 < arg_22_0._scaleMin or var_22_0 > arg_22_0._scaleMax then
		if arg_22_1 > 1 then
			arg_22_1 = (arg_22_1 - 1) * arg_22_0._scaleDampFactor + 1
		else
			arg_22_1 = 1 - (1 - arg_22_1) * arg_22_0._scaleDampFactor
		end
	end

	local var_22_1 = arg_22_1 * var_22_0

	if var_22_1 < arg_22_0._scaleMin - arg_22_0._scaleMinBuffer then
		var_22_1 = arg_22_0._scaleMin - arg_22_0._scaleMinBuffer
	elseif var_22_1 > arg_22_0._scaleMax + arg_22_0._scaleMaxBuffer then
		var_22_1 = arg_22_0._scaleMax + arg_22_0._scaleMaxBuffer
	end

	arg_22_0:setScaleWithEvent(var_22_1)

	return var_22_1 - var_22_0
end

function var_0_0.checkScaleBack(arg_23_0)
	if arg_23_0._scaleMinBuffer > 0 or arg_23_0._scaleMaxBuffer > 0 then
		local var_23_0 = arg_23_0:getScale()
		local var_23_1 = false
		local var_23_2 = 0

		if var_23_0 < arg_23_0._scaleMin then
			var_23_2 = arg_23_0._scaleMin - var_23_0
			var_23_1 = true
		elseif var_23_0 > arg_23_0._scaleMax then
			var_23_2 = arg_23_0._scaleMax - var_23_0
			var_23_1 = true
		end

		if var_23_1 then
			arg_23_0._scaleVelocity = (var_23_2 + var_23_2) / arg_23_0._scaleBackTime
			arg_23_0._scaleAcc = -arg_23_0._scaleVelocity / arg_23_0._scaleBackTime
			arg_23_0._state = var_0_0.STATE_SCALING_BACK

			if arg_23_0._scheduleId.scaleBack then
				var_0_4:unscheduleScriptEntry(arg_23_0._scheduleId.scaleBack)
			end

			arg_23_0._scheduleId.scaleBack = var_0_4:scheduleScriptFunc(function(arg_24_0)
				arg_23_0:scaleBack(arg_24_0)
			end, lc.FPS, false)
			arg_23_0._isMoveWhenScaleBack = not arg_23_0:checkMoveBack(var_23_0 + var_23_2)

			if arg_23_0._isMoveWhenScaleBack then
				arg_23_0._scaleCenter = lc.convertPos(arg_23_0._scaleLocalCenter, arg_23_0, arg_23_0:getParent())
			end

			return true
		else
			arg_23_0._state = var_0_0.STATE_IDLE

			return false
		end
	end

	return false
end

function var_0_0.scaleBack(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._scaleAcc
	local var_25_1 = arg_25_0._scaleVelocity

	arg_25_0._scaleVelocity = arg_25_0._scaleVelocity + var_25_0 * arg_25_1

	local var_25_2 = arg_25_0:getScale() + (var_25_1 + arg_25_0._scaleVelocity) / 2 * arg_25_1
	local var_25_3 = false

	if var_25_0 < 0 and var_25_2 >= arg_25_0._scaleMin then
		var_25_2 = arg_25_0._scaleMin
		var_25_3 = true
	elseif var_25_0 > 0 and var_25_2 <= arg_25_0._scaleMax then
		var_25_2 = arg_25_0._scaleMax
		var_25_3 = true
	end

	arg_25_0:setScaleWithEvent(var_25_2)

	if arg_25_0._isMoveWhenScaleBack then
		local var_25_4 = lc.convertPos(arg_25_0._scaleLocalCenter, arg_25_0, arg_25_0:getParent())

		arg_25_0:setPosOffsetWithEvent(arg_25_0._scaleCenter.x - var_25_4.x, arg_25_0._scaleCenter.y - var_25_4.y)
	end

	if not var_25_3 and (var_25_0 < 0 and arg_25_0._scaleVelocity <= 0 or var_25_0 > 0 and arg_25_0._scaleVelocity >= 0) then
		var_25_3 = true
	end

	if var_25_3 then
		arg_25_0._state = var_0_0.STATE_IDLE

		var_0_4:unscheduleScriptEntry(arg_25_0._scheduleId.scaleBack)
	end
end

function var_0_0.setPosOffsetWithEvent(arg_26_0, arg_26_1, arg_26_2)
	lc.offset(arg_26_0, arg_26_1, arg_26_2)

	if arg_26_0._isEventEnabled then
		local var_26_0 = cc.EventCustom:new(var_0_0.Event.offset)

		var_26_0.offset = {
			x = arg_26_1,
			y = arg_26_2
		}

		arg_26_0:getEventDispatcher():dispatchEvent(var_26_0)
	end
end

function var_0_0.setScaleWithEvent(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getScale()

	arg_27_0:setScale(arg_27_1)

	if arg_27_0._isEventEnabled then
		local var_27_1 = cc.EventCustom:new(var_0_0.Event.scale)

		var_27_1.scaleDelta = arg_27_1 - var_27_0

		arg_27_0:getEventDispatcher():dispatchEvent(var_27_1)
	end
end

function var_0_0.animateTo(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	if arg_28_0._scheduleId.moveBack then
		var_0_4:unscheduleScriptEntry(arg_28_0._scheduleId.moveBack)

		arg_28_0._scheduleId.moveBack = nil
	end

	local var_28_0 = arg_28_0:getContentSize()
	local var_28_1 = arg_28_0:getParent():getContentSize()

	arg_28_2 = math.min(arg_28_0._scaleMax, math.max(arg_28_0._scaleMin, arg_28_2))

	local var_28_2 = var_28_1.height - (var_28_0.height - arg_28_3.y) * arg_28_2
	local var_28_3 = arg_28_3.y * arg_28_2
	local var_28_4 = var_28_1.width - (var_28_0.width - arg_28_3.x) * arg_28_2
	local var_28_5 = arg_28_3.x * arg_28_2
	local var_28_6 = math.max(var_28_4, math.min(var_28_5, arg_28_4.x))
	local var_28_7 = math.max(var_28_2, math.min(var_28_3, arg_28_4.y))
	local var_28_8 = var_28_6 - (arg_28_3.x - var_28_0.width / 2) * arg_28_2
	local var_28_9 = var_28_7 - (arg_28_3.y - var_28_0.height / 2) * arg_28_2

	arg_28_0:stopAnimation()

	arg_28_0._isAnimating = true

	arg_28_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(arg_28_1, cc.p(var_28_8, var_28_9)), cc.ScaleTo:create(arg_28_1, arg_28_2)), cc.CallFunc:create(function()
		arg_28_0:stopAnimation(true)
	end)))

	if arg_28_0._isEventEnabled then
		arg_28_0._scheduleId.animateTo = var_0_4:scheduleScriptFunc(function(arg_30_0)
			local var_30_0 = cc.p(arg_28_0:getPosition())
			local var_30_1 = cc.EventCustom:new(var_0_0.Event.scale)

			var_30_1.scaleDelta = 0

			arg_28_0:getEventDispatcher():dispatchEvent(var_30_1)
		end, 0.1, false)
	end
end

function var_0_0.stopAnimation(arg_31_0, arg_31_1)
	arg_31_0._isAnimating = false

	arg_31_0:stopAllActions()

	if arg_31_0._isEventEnabled then
		if arg_31_1 == true then
			local var_31_0 = cc.EventCustom:new(var_0_0.Event.animate_stopped)

			arg_31_0:getEventDispatcher():dispatchEvent(var_31_0)
		end

		if arg_31_0._scheduleId.animateTo ~= nil then
			var_0_4:unscheduleScriptEntry(arg_31_0._scheduleId.animateTo)

			arg_31_0._scheduleId.animateTo = nil
		end
	end
end

return var_0_0
