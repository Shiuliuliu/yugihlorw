local var_0_0 = class("BattleLine", lc.ExtendUIWidget)

BattleLine = var_0_0
var_0_0.MOVE_SPEED = 500
var_0_0.SCALE_SPEED = 1
var_0_0.OPACITY_SPEED = 255

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:setAnchorPoint(0.5, 0)
	arg_2_0:setPosition(arg_2_1)
	arg_2_0:setCascadeColorEnabled(true)
	arg_2_0:setClippingEnabled(true)

	arg_2_0._isRect = arg_2_2
	arg_2_0._arrow = cc.Sprite:createWithSpriteFrameName("bat_arrow_1")

	arg_2_0:addChild(arg_2_0._arrow)

	arg_2_0._segments = {}
	arg_2_0._startPos = arg_2_1

	local var_2_0 = cc.Sprite:createWithSpriteFrameName("bat_arrow_2")

	arg_2_0._segmentH = lc.h(var_2_0)
end

function var_0_0.onEnter(arg_3_0)
	arg_3_0:scheduleUpdateWithPriorityLua(function(arg_4_0)
		arg_3_0:onSchedule(arg_4_0)
	end, 0)
end

function var_0_0.onExit(arg_5_0)
	arg_5_0:unscheduleUpdate()
end

function var_0_0.onCleanup(arg_6_0)
	if arg_6_0._targetCard then
		arg_6_0._targetCard:stopAllActions()

		if not arg_6_0._isRect then
			arg_6_0._targetCard:updateBatCardSelected(false)
		end

		arg_6_0._targetCard:setPosition(arg_6_0._targetPos)
		arg_6_0._targetCard:setScale(arg_6_0._targetScale)
	end

	if not arg_6_0._isRect and ClientData._battleScene then
		ClientData._battleScene._battleUi._playerUi:updateCardsActive()
	end
end

function var_0_0.onSchedule(arg_7_0, arg_7_1)
	if not arg_7_0._isAnimation then
		return
	end

	arg_7_0._arrow:setPositionY(lc.y(arg_7_0._arrow) + var_0_0.MOVE_SPEED * arg_7_1)

	if lc.top(arg_7_0._arrow) > lc.h(arg_7_0) - 90 then
		if arg_7_0._arrow:getScale() > 0 then
			arg_7_0._arrow:setScale(arg_7_0._arrow:getScale() - var_0_0.SCALE_SPEED * arg_7_1)
		end

		if arg_7_0._arrow:getOpacity() > 0 then
			arg_7_0._arrow:setOpacity(arg_7_0._arrow:getOpacity() - var_0_0.OPACITY_SPEED * arg_7_1)
		end
	end

	for iter_7_0 = 1, #arg_7_0._segments do
		arg_7_0._segments[iter_7_0]:setPositionY(lc.y(arg_7_0._segments[iter_7_0]) + var_0_0.MOVE_SPEED * arg_7_1)

		if lc.top(arg_7_0._segments[iter_7_0]) > lc.h(arg_7_0) - 90 then
			if arg_7_0._segments[iter_7_0]:getScale() > 0 then
				arg_7_0._segments[iter_7_0]:setScale(arg_7_0._segments[iter_7_0]:getScale() - var_0_0.SCALE_SPEED * arg_7_1)
			end

			if arg_7_0._segments[iter_7_0]:getOpacity() > 0 then
				arg_7_0._segments[iter_7_0]:setOpacity(arg_7_0._segments[iter_7_0]:getOpacity() - var_0_0.OPACITY_SPEED * arg_7_1)
			end
		end
	end

	local var_7_0

	if #arg_7_0._segments > 0 then
		var_7_0 = lc.bottom(arg_7_0._segments[#arg_7_0._segments])
	else
		var_7_0 = lc.bottom(arg_7_0._arrow)
	end

	if var_7_0 > lc.h(arg_7_0) then
		arg_7_0:resetToPos(-lc.h(arg_7_0._arrow) / 2)
	end
end

function var_0_0.resetToPos(arg_8_0, arg_8_1)
	arg_8_0._isAniFromBottom = false

	arg_8_0._arrow:setPositionY(arg_8_1)
	arg_8_0._arrow:setScale(1)
	arg_8_0._arrow:setOpacity(255)

	local var_8_0 = lc.bottom(arg_8_0._arrow) - 10

	for iter_8_0 = 1, #arg_8_0._segments do
		arg_8_0._segments[iter_8_0]:setPositionY(var_8_0 - lc.h(arg_8_0._segments[iter_8_0]) / 2)
		arg_8_0._segments[iter_8_0]:setScale(1)
		arg_8_0._segments[iter_8_0]:setOpacity(255)

		var_8_0 = lc.bottom(arg_8_0._segments[iter_8_0]) - 10
	end
end

function var_0_0.directTo(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = cc.pGetDistance(arg_9_1, arg_9_0._startPos)

	if var_9_0 < 70 then
		var_9_0 = 70
	end

	arg_9_0:setContentSize(120, var_9_0)
	arg_9_0:setRotation(90 - math.deg(cc.pToAngleSelf(cc.pSub(arg_9_1, arg_9_0._startPos))))

	arg_9_0._isAnimation = false

	if arg_9_0._targetCard == arg_9_2 and arg_9_2 ~= nil then
		arg_9_0._isAnimation = true

		return
	end

	for iter_9_0 = 1, #arg_9_0._segments do
		arg_9_0._segments[iter_9_0]:removeFromParent()
	end

	arg_9_0._segments = {}

	arg_9_0._arrow:setPosition(lc.w(arg_9_0) / 2, lc.h(arg_9_0) - lc.h(arg_9_0._arrow) / 2)
	arg_9_0._arrow:setScale(1)
	arg_9_0._arrow:setOpacity(255)

	local var_9_1 = lc.bottom(arg_9_0._arrow) - 10

	repeat
		local var_9_2 = cc.Sprite:createWithSpriteFrameName("bat_arrow_2")

		var_9_2:setPosition(lc.w(arg_9_0) / 2, var_9_1 - lc.h(var_9_2) / 2)
		arg_9_0:addChild(var_9_2)
		table.insert(arg_9_0._segments, var_9_2)

		var_9_1 = lc.bottom(var_9_2) - 10
	until var_9_1 <= 0

	if arg_9_0._targetCard ~= arg_9_2 then
		if arg_9_0._targetCard ~= nil then
			if not arg_9_0._isRect then
				arg_9_0._targetCard:updateBatCardSelected(false)
			end

			arg_9_0._targetCard:stopActionByTag(255)
			arg_9_0._targetCard:setPosition(arg_9_0._targetPos)
			arg_9_0._targetCard:setScale(arg_9_0._targetScale)

			arg_9_0._targetCard = nil
		end

		arg_9_0._targetCard = arg_9_2

		if arg_9_2 ~= nil then
			arg_9_0._targetPos = cc.p(arg_9_2:getPosition())
			arg_9_0._targetScale = arg_9_2:getScale()

			local var_9_3 = lc.rep(lc.sequence(cc.ScaleTo:create(0.5, 1.1), cc.ScaleTo:create(0.5, 1)))
			var_9_3._dontFixPos = true
			var_9_3:setTag(255)
			arg_9_2:runAction(var_9_3)

			if not arg_9_0._isRect then
				arg_9_2:updateBatCardSelected(true)
			end
		end
	end
end

return var_0_0
