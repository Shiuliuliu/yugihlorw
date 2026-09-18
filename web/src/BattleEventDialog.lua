local var_0_0 = class("BattleEventDialog", lc.ExtendUIWidget)

BattleEventDialog = var_0_0
var_0_0.Type = {
	guide_drag_to_card = 33,
	info_help = 21,
	guide_drag_to_pos = 34,
	guide_drag_to_attack = 35,
	guide_drag = 32,
	guide_tap = 31,
	guide_drag_to_defend = 36,
	story = 11
}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0._type = arg_2_2
	arg_2_0._battleUi = arg_2_1
	arg_2_0._battleUi._guideCard = nil
	arg_2_0._val = arg_2_3
	arg_2_0._delayFinger = arg_2_4

	if arg_2_2 == var_0_0.Type.story then
		arg_2_0._story = {}

		for iter_2_0 = 1, #arg_2_3 do
			table.insert(arg_2_0._story, arg_2_3[iter_2_0])
		end

		arg_2_0:showStory()
	elseif arg_2_2 == var_0_0.Type.info_help then
		arg_2_0:showHelp()
	elseif arg_2_2 == var_0_0.Type.guide_tap then
		arg_2_0:showGuideTap(arg_2_3)
	elseif arg_2_2 == var_0_0.Type.guide_drag then
		arg_2_0:showGuideDrag(arg_2_3)
	elseif arg_2_2 == var_0_0.Type.guide_drag_to_card or arg_2_2 == var_0_0.Type.guide_drag_to_pos or arg_2_2 == var_0_0.Type.guide_drag_to_attack or arg_2_2 == var_0_0.Type.guide_drag_to_defend then
		arg_2_0:showGuideDragTo(arg_2_2, arg_2_3)
	end
end

function var_0_0.hide(arg_3_0)
	if arg_3_0._type == var_0_0.Type.story then
		GuideManager.closeStoryDialog()
	end

	arg_3_0:removeFromParent()
end

function var_0_0.showStory(arg_4_0)
	local var_4_0 = arg_4_0._story[1]

	if var_4_0 == nil or var_4_0 == 0 then
		return arg_4_0._battleUi:hideEvent()
	end

	table.remove(arg_4_0._story, 1)

	local var_4_1 = Data._storyInfo[var_4_0]

	if var_4_1 == nil then
		arg_4_0._battleUi:leaveFilmMode()

		return arg_4_0._battleUi:hideEvent()
	end

	arg_4_0:setOpacity(ClientView.MASK_OPACITY_LIGHT)

	local var_4_2 = GuideManager.createStoryDialog(var_4_1, function()
		arg_4_0:showStory()
	end)

	arg_4_0:addChild(var_4_2, BattleScene.ZOrder.form)

	if arg_4_0._battleUi._isAuto and not arg_4_0._battleUi._isBattleFinished then
		local var_4_3 = 3 * cc.Director:getInstance():getScheduler():getTimeScale()

		var_4_2:runAction(lc.sequence(var_4_3, function()
			GuideManager.closeStoryDialog()
			arg_4_0:showStory()
		end))
	end
end

function var_0_0.showHelp(arg_7_0)
	arg_7_0:setOpacity(0)
	arg_7_0:setTouchEnabled(false)

	local var_7_0 = BattleHelpDialog.create(arg_7_0._battleUi)

	var_7_0:setTouchEnabled(true)
	var_7_0:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 == ccui.TouchEventType.ended then
			var_7_0:runAction(lc.sequence(lc.remove(), 0.5, arg_7_0._battleUi:hideEvent()))
		end
	end)
	arg_7_0:addChild(var_7_0)
end

function var_0_0.showGuideTap(arg_9_0, arg_9_1)
	arg_9_0:setOpacity(0)
	arg_9_0:setTouchEnabled(false)

	local var_9_0 = arg_9_1

	if var_9_0.setEnabled then
		var_9_0:setEnabled(true)
	end

	arg_9_0:createOperateLayer(var_9_0)
end

function var_0_0.showGuideDrag(arg_10_0, arg_10_1)
	arg_10_0:setOpacity(0)
	arg_10_0:setTouchEnabled(false)

	local var_10_0 = arg_10_1._pFrame
	local var_10_1 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH)

	arg_10_0:createOperateLayer(var_10_0, var_10_1)
end

function var_0_0.showGuideDragTo(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:setOpacity(0)
	arg_11_0:setTouchEnabled(false)

	local var_11_0 = arg_11_2[1]._pFrame
	local var_11_1 = arg_11_2[2]
	local var_11_2

	if var_11_1 then
		if arg_11_1 == var_0_0.Type.guide_drag_to_card then
			var_11_2 = arg_11_0._battleUi._layer:convertToNodeSpace(var_11_1:convertToWorldSpace(cc.p(0, 0)))
		else
			var_11_2 = arg_11_0._battleUi._layer:convertToNodeSpace(var_11_1:convertToWorldSpace(cc.p(0, 0)))
		end
	elseif arg_11_1 == var_0_0.Type.guide_drag_to_attack then
		var_11_2 = cc.p(ClientView.SCR_CW, 600)
	elseif arg_11_1 == var_0_0.Type.guide_drag_to_defend then
		var_11_2 = cc.p(ClientView.SCR_CW - 20, 100)
	else
		local var_11_3 = arg_11_0._battleUi._playerUi._pBoardCards

		for iter_11_0 = Data.MAX_CARD_COUNT_ON_BOARD, 1, -1 do
			if var_11_3[iter_11_0] then
				var_11_2 = cc.p(ClientView.SCR_CW + 100, ClientView.SCR_CH)

				break
			end
		end

		if var_11_2 == nil or var_11_2.x < ClientView.SCR_CW then
			var_11_2 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH)
		end
	end

	local var_11_4 = arg_11_0._battleUi._layer:convertToNodeSpace(arg_11_2[1]:getParent():convertToWorldSpace(arg_11_2[1]._default._position))
	local var_11_5 = cc.pGetDistance(var_11_4, var_11_2)
	local var_11_6 = 90 - math.deg(cc.pToAngleSelf(cc.pSub(var_11_2, var_11_4)))
	local var_11_7 = lc.createSprite({
		_name = "img_arrow_up_4",
		_crect = ClientView.CRECT_ARROW_4,
		_size = cc.size(48, var_11_5)
	})

	var_11_7:setRotation(var_11_6)
	var_11_7:setOpacity(0)
	lc.addChildToPos(arg_11_0, var_11_7, cc.p((var_11_2.x + var_11_4.x) / 2, (var_11_2.y + var_11_4.y) / 2))

	arg_11_0._guideArrow = var_11_7

	arg_11_0:createOperateLayer(var_11_0, var_11_2)
end

function var_0_0.createOperateLayer(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = ClientView.createTouchLayer()

	arg_12_0:addChild(var_12_0)

	function var_12_0._touchHandler(arg_13_0, arg_13_1, arg_13_2)
		if arg_12_0._ignoreTouch or GuideManager._tipLayer and arg_12_0._battleUi._guideTipVals.t.touch == 1 then
			return 0
		end

		if arg_12_0._blockTouch then
			return 1
		end

		local var_13_0 = arg_12_0._battleUi._btnEndRound

		if arg_12_1 == var_13_0 then
			arg_12_0._battleUi._guideNode = arg_12_1

			return 0
		else
			local var_13_1 = cc.p(arg_13_1, arg_13_2)

			if lc.contain(arg_12_1, var_13_1) then
				arg_12_0._battleUi._guideNode = arg_12_1

				return 0
			else
				arg_12_0._battleUi._guideNode = nil

				return lc.contain(var_13_0, var_13_1) and 1 or 0
			end
		end
	end

	function arg_12_0.showFinger(arg_14_0)
		local function var_14_0()
			local var_15_0 = arg_14_0._battleUi._layer:convertToNodeSpace(arg_12_1:convertToWorldSpace(cc.p(lc.w(arg_12_1) / 2, lc.h(arg_12_1) / 2)))

			if arg_12_1 == arg_14_0._battleUi._btnEndRound then
				var_15_0.x = var_15_0.x - 14
				var_15_0.y = var_15_0.y + 12
			end

			return var_15_0
		end

		local var_14_1 = var_14_0()
		local var_14_2 = GuideManager.createFinger(false, var_14_1, arg_12_2, var_14_0)

		var_14_2:setCameraMask(arg_12_1:getCameraMask())
		arg_14_0._battleUi._layer:addChild(var_14_2, BattleScene.ZOrder.form - 1)

		if arg_14_0._guideArrow then
			arg_14_0._guideArrow:setOpacity(255)
			arg_14_0._guideArrow:runAction(lc.rep(lc.sequence(1, lc.fadeTo(0.5, 100), lc.fadeTo(0.5, 255))))
		end

		arg_14_0._blockTouch = nil
	end

	if arg_12_0._delayFinger then
		arg_12_0._blockTouch = true
	else
		arg_12_0:showFinger()
	end

	return var_12_0
end

return var_0_0
