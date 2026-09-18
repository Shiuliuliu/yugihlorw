lc = lc or {}

local var_0_0 = {
	TouchState = {
		still = 3,
		began = 1,
		moved = 2,
		ended = 4,
		cancelled = 5,
		none = 0
	},
	TouchEvent = {
		cancelled = "LC_TOUCH_CANCELLED",
		began = "LC_TOUCH_BEGAN",
		ended = "LC_TOUCH_ENDED"
	},
	GestureEvent = {
		swipe = "LC_GESTURE_SWIPE",
		pan = "LC_GESTURE_PAN",
		pinch = "LC_GESTURE_PINCH",
		long_press = "LC_GESTURE_LONG_PRESS",
		tap = "LC_GESTURE_TAP"
	}
}

var_0_0.SUPPORT_TOUCH_COUNT = 2
var_0_0.BUDGE_LIMIT = 32
var_0_0.TAP_TIME_LIMIT = 0.5
var_0_0.LONG_PRESS_TIME_LIMIT = 2

local function var_0_1(arg_1_0)
	return {
		tick = 0,
		prevTick = 0,
		beganTick = 0,
		tapCount = 0,
		id = arg_1_0,
		state = var_0_0.TouchState.none,
		budgedDir = lc.Dir.none,
		budgeLimit = var_0_0.BUDGE_LIMIT,
		tapTimeLimit = var_0_0.TAP_TIME_LIMIT,
		pos = {
			x = 0,
			y = 0
		},
		beganPos = {
			x = 0,
			y = 0
		},
		prevPos = {
			x = 0,
			y = 0
		},
		isBudgedX = function(arg_2_0)
			return math.abs(arg_2_0.pos.x - arg_2_0.beganPos.x) >= arg_2_0.budgeLimit or arg_2_0.budgedDir == lc.Dir.horizontal
		end,
		isBudgedY = function(arg_3_0)
			return math.abs(arg_3_0.pos.y - arg_3_0.beganPos.y) >= arg_3_0.budgeLimit or arg_3_0.budgedDir == lc.Dir.vertical
		end,
		isBudged = function(arg_4_0)
			return arg_4_0:isBudgedX() or arg_4_0:isBudgedY()
		end,
		getRelPos = function(arg_5_0, arg_5_1)
			return arg_5_1:convertToNodeSpace(arg_5_0.pos)
		end,
		getRelBeganPos = function(arg_6_0, arg_6_1)
			return arg_6_1:convertToNodeSpace(arg_6_0.beganPos)
		end,
		getRelPrevPos = function(arg_7_0, arg_7_1)
			return arg_7_1:convertToNodeSpace(arg_7_0.prevPos)
		end
	}
end

local var_0_2
local var_0_3 = lc.Scheduler
local var_0_4
local var_0_5 = {}
local var_0_6 = {
	getOffset = function(arg_8_0, arg_8_1)
		local var_8_0
		local var_8_1

		if arg_8_1 then
			var_8_0, var_8_1 = arg_8_0.touch:getRelPos(arg_8_1), arg_8_0.touch:getRelPrevPos(arg_8_1)
		else
			var_8_0, var_8_1 = arg_8_0.touch.pos, arg_8_0.touch.prevPos
		end

		return {
			x = var_8_0.x - var_8_1.x,
			y = var_8_0.y - var_8_1.y
		}
	end,
	getVelocity = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0.touch.tick - arg_9_0.touch.prevTick

		if var_9_0 <= 0 then
			var_9_0 = 0.001
		end

		local var_9_1 = arg_9_0:getOffset(arg_9_1)

		return {
			x = var_9_1.x / var_9_0,
			y = var_9_1.y / var_9_0
		}
	end
}
local var_0_7 = {
	getOffset = function(arg_10_0, arg_10_1)
		local var_10_0
		local var_10_1

		if arg_10_1 then
			var_10_0, var_10_1 = arg_10_0.touch:getRelPos(arg_10_1), arg_10_0.touch:getRelPrevPos(arg_10_1)
		else
			var_10_0, var_10_1 = arg_10_0.touch.pos, arg_10_0.touch.prevPos
		end

		return arg_10_0.touch.budgedDir == lc.Dir.horizontal and var_10_0.x - var_10_1.x or var_10_0.y - var_10_1.y
	end,
	getVelocity = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0.touch.tick - arg_11_0.touch.prevTick

		return arg_11_0:getOffset(arg_11_1) / var_11_0
	end
}
local var_0_8 = {
	getScale = function(arg_12_0, arg_12_1)
		local var_12_0
		local var_12_1
		local var_12_2
		local var_12_3

		if arg_12_1 then
			var_12_0, var_12_1 = arg_12_0.touch1:getRelPos(arg_12_1), arg_12_0.touch1:getRelPrevPos(arg_12_1)
			var_12_2, var_12_3 = arg_12_0.touch2:getRelPos(arg_12_1), arg_12_0.touch2:getRelPrevPos(arg_12_1)
		else
			var_12_0, var_12_1 = arg_12_0.touch1.pos, arg_12_0.touch1.prevPos
			var_12_2, var_12_3 = arg_12_0.touch2.pos, arg_12_0.touch2.prevPos
		end

		local var_12_4 = lc.calcDistance(var_12_1, var_12_3)

		return lc.calcDistance(var_12_0, var_12_2) / var_12_4
	end,
	getCenter = function(arg_13_0, arg_13_1)
		local var_13_0
		local var_13_1

		if arg_13_1 then
			var_13_0, var_13_1 = arg_13_0.touch1:getRelPos(arg_13_1), arg_13_0.touch2:getRelPos(arg_13_1)
		else
			var_13_0, var_13_1 = arg_13_0.touch1.pos, arg_13_0.touch2.pos
		end

		return {
			x = (var_13_0.x + var_13_1.x) / 2,
			y = (var_13_0.y + var_13_1.y) / 2
		}
	end,
	getCenterOffset = function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0:getCenter(arg_14_1)
		local var_14_1
		local var_14_2

		if arg_14_1 then
			var_14_1, var_14_2 = arg_14_0.touch1:getRelPrevPos(arg_14_1), arg_14_0.touch2:getRelPrevPos(arg_14_1)
		else
			var_14_1, var_14_2 = arg_14_0.touch1.prevPos, arg_14_0.touch2.prevPos
		end

		local var_14_3 = {
			x = (var_14_1.x + var_14_2.x) / 2,
			y = (var_14_1.y + var_14_2.y) / 2
		}

		return {
			x = var_14_0.x - var_14_3.x,
			y = var_14_0.y - var_14_3.y
		}
	end
}
local var_0_9 = {}

local function var_0_10()
	if not var_0_0._isEnabled then
		return
	end

	local var_15_0 = cc.EventCustom:new(var_0_0.TouchEvent.began)

	for iter_15_0, iter_15_1 in ipairs(var_0_2) do
		if iter_15_1.state == var_0_0.TouchState.began then
			var_15_0.touch = iter_15_1

			var_0_4:dispatchEvent(var_15_0)

			iter_15_1.state = var_0_0.TouchState.still

			if var_0_0._isLongPressEnabled then
				local var_15_1 = -1

				var_15_1 = var_0_3:scheduleScriptFunc(function()
					var_0_3:unscheduleScriptEntry(var_15_1)

					var_0_9.touch = iter_15_1
					var_15_0 = cc.EventCustom:new(var_0_0.GestureEvent.long_press)
					var_15_0.gesture = var_0_9

					var_0_4:dispatchEvent(var_15_0)
				end, var_0_0.LONG_PRESS_TIME_LIMIT, false)
			end
		end
	end
end

local function var_0_11()
	if not var_0_0._isEnabled then
		return
	end

	local var_17_0 = var_0_2[1]
	local var_17_1 = var_0_2[2]

	if var_17_0.active and var_17_1.active then
		if var_0_0._isPinchEnabled and (var_17_0.state == var_0_0.TouchState.moved or var_17_1.state == var_0_0.TouchState.moved) then
			var_0_8.touch1, var_0_8.touch2 = var_17_0, var_17_1

			local var_17_2 = cc.EventCustom:new(var_0_0.GestureEvent.pinch)

			var_17_2.gesture = var_0_8

			var_0_4:dispatchEvent(var_17_2)
		end
	else
		local var_17_3 = var_17_0.active and var_17_0 or var_17_1

		if var_17_3.state == var_0_0.TouchState.moved then
			var_0_6.touch = var_17_3

			local var_17_4 = cc.EventCustom:new(var_0_0.GestureEvent.pan)

			var_17_4.gesture = var_0_6

			var_0_4:dispatchEvent(var_17_4)
		end

		if var_17_3.state == var_0_0.TouchState.moved and var_17_3.budgedDir ~= lc.Dir.none then
			var_0_7.touch = var_17_3

			local var_17_5 = cc.EventCustom:new(var_0_0.GestureEvent.swipe)

			var_17_5.gesture = var_0_7

			var_0_4:dispatchEvent(var_17_5)
		end
	end
end

local function var_0_12()
	local var_18_0 = cc.EventCustom:new(var_0_0.TouchEvent.ended)

	for iter_18_0, iter_18_1 in ipairs(var_0_2) do
		if iter_18_1.state == var_0_0.TouchState.ended then
			var_18_0.touch = iter_18_1

			var_0_4:dispatchEvent(var_18_0)

			if iter_18_1.tapCount > 0 and iter_18_1.budgedDir == lc.Dir.none then
				var_0_5.touch = iter_18_1

				local var_18_1 = cc.EventCustom:new(var_0_0.GestureEvent.tap)

				var_18_1.gesture = var_0_5

				var_0_4:dispatchEvent(var_18_1)
			end
		end
	end
end

local function var_0_13()
	local var_19_0 = cc.EventCustom:new(var_0_0.TouchEvent.cancelled)

	for iter_19_0, iter_19_1 in ipairs(var_0_2) do
		if iter_19_1.state == var_0_0.TouchState.cancelled then
			var_19_0.touch = iter_19_1

			var_0_4:dispatchEvent(var_19_0)
		end
	end
end

local function var_0_14(arg_20_0, arg_20_1)
	local var_20_0 = cc.Camera:getVisitingCamera()

	if var_20_0 ~= nil and var_20_0:getCameraFlag() ~= 1 then
		return
	end

	if arg_20_0 == "began" then
		for iter_20_0 = 1, #arg_20_1, 3 do
			local var_20_1 = arg_20_1[iter_20_0 + 2] + 1

			if var_20_1 <= var_0_0.SUPPORT_TOUCH_COUNT then
				local var_20_2 = arg_20_1[iter_20_0]
				local var_20_3 = arg_20_1[iter_20_0 + 1]
				local var_20_4 = var_0_2[var_20_1]

				var_20_4.pos.x, var_20_4.pos.y = var_20_2, var_20_3

				local var_20_5 = var_20_4:isBudgedX() or var_20_4:isBudgedY()

				var_20_4.beganPos.x, var_20_4.beganPos.y = var_20_2, var_20_3
				var_20_4.prevPos.x, var_20_4.prevPos.y = var_20_2, var_20_3
				var_20_4.state = var_0_0.TouchState.began
				var_20_4.budgedDir = lc.Dir.none
				var_20_4.isLongPressed = false

				local var_20_6 = lc.Director:getCurrentTime()

				var_20_4.beganTick, var_20_4.prevTick, var_20_4.tick = var_20_6, var_20_6, var_20_6

				if var_20_4.tick - var_20_4.prevTick >= var_20_4.tapTimeLimit or var_20_5 then
					var_20_4.tapCount = 0
				end

				var_20_4.active = true
			end
		end

		var_0_10()
	elseif arg_20_0 == "moved" then
		for iter_20_1, iter_20_2 in ipairs(var_0_2) do
			if iter_20_2.active then
				iter_20_2.state = var_0_0.TouchState.still
			end
		end

		for iter_20_3 = 1, #arg_20_1, 3 do
			local var_20_7 = arg_20_1[iter_20_3 + 2] + 1

			if var_20_7 <= var_0_0.SUPPORT_TOUCH_COUNT then
				local var_20_8 = arg_20_1[iter_20_3]
				local var_20_9 = arg_20_1[iter_20_3 + 1]
				local var_20_10 = var_0_2[var_20_7]

				var_20_10.prevPos.x, var_20_10.prevPos.y = var_20_10.pos.x, var_20_10.pos.y
				var_20_10.pos.x, var_20_10.pos.y = var_20_8, var_20_9
				var_20_10.state = var_0_0.TouchState.moved
				var_20_10.prevTick = var_20_10.tick
				var_20_10.tick = lc.Director:getCurrentTime()

				if var_20_10.budgedDir == lc.Dir.none then
					if var_20_10:isBudgedX() then
						var_20_10.budgedDir = lc.Dir.horizontal
					elseif var_20_10:isBudgedY() then
						var_20_10.budgedDir = lc.Dir.vertical
					end

					if var_20_10.budgedDir ~= lc.Dir.none then
						var_20_10.tapCount = 0

						if var_20_10.schedulerId then
							var_0_3:unscheduleScriptEntry(var_20_10.schedulerId)

							var_20_10.schedulerId = nil
						end
					end
				end
			end
		end

		var_0_11()
	elseif arg_20_0 == "ended" or arg_20_0 == "cancelled" then
		local var_20_11 = arg_20_0 == "cancelled"

		for iter_20_4 = 1, #arg_20_1, 3 do
			local var_20_12 = arg_20_1[iter_20_4 + 2] + 1

			if var_20_12 <= var_0_0.SUPPORT_TOUCH_COUNT then
				local var_20_13 = arg_20_1[iter_20_4]
				local var_20_14 = arg_20_1[iter_20_4 + 1]
				local var_20_15 = var_0_2[var_20_12]

				var_20_15.prevPos.x, var_20_15.prevPos.y = var_20_15.pos.x, var_20_15.pos.y
				var_20_15.pos.x, var_20_15.pos.y = var_20_13, var_20_14
				var_20_15.budgeLimit = var_0_0.BUDGE_LIMIT
				var_20_15.active = false
				var_20_15.prevTick = var_20_15.tick
				var_20_15.tick = lc.Director:getCurrentTime()

				if var_20_11 then
					var_20_15.tapCount = 0
					var_20_15.state = var_0_0.TouchState.cancelled
				else
					local var_20_16 = var_20_15:isBudgedX() or var_20_15:isBudgedY()

					if var_20_15.tick - var_20_15.prevTick < var_20_15.tapTimeLimit and var_20_15.budgedDir == lc.Dir.none and not var_20_16 then
						var_20_15.tapCount = var_20_15.tapCount + 1
					else
						var_20_15.tapCount = 0
					end

					var_20_15.state = var_0_0.TouchState.ended
				end
			end
		end

		if var_20_11 then
			var_0_13()
		else
			var_0_12()
		end
	end
end

local var_0_15 = cc.Layer:create()

var_0_15:retain()
var_0_15:setTouchEnabled(true)
var_0_15:registerScriptTouchHandler(var_0_14, true)
var_0_15:resume()

var_0_4 = var_0_15:getEventDispatcher()

function var_0_0.cancelTouch(arg_21_0, arg_21_1)
	local var_21_0 = cc.EventCustom:new(var_0_0.TouchState.cancelled)

	var_21_0.touch = arg_21_0
	var_21_0.exceptTarget = arg_21_1

	var_0_4:dispatchEvent(var_21_0)
end

function var_0_0.resetTouches()
	var_0_2 = {}

	for iter_22_0 = 1, var_0_0.SUPPORT_TOUCH_COUNT do
		table.insert(var_0_2, var_0_1(iter_22_0))
	end
end

var_0_0.resetTouches()

var_0_0._isEnabled = true
var_0_0._isLongPressEnabled = false
var_0_0._isPinchEnabled = true
lc.Gesture = var_0_0

return var_0_0
