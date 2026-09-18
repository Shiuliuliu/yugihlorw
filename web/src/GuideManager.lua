local var_0_0 = {
	StepType = {
		tip = 3,
		other = 4,
		operation = 2,
		dialog = 1
	},
	OperateType = {
		tap = 1,
		move = 2
	},
	HighlightType = {
		battle_setting_btn = 8,
		battle_atk = 3,
		herocenter_troop = 100,
		battle_atk_hp_2 = 9,
		battle_atk_hp = 2,
		battle_gem = 1,
		battle_empty_pos = 7,
		battle_skill = 5,
		battle_round_btn = 4,
		battle_fortress = 6
	},
	Event = {
		finish = "guide finished",
		seek = "guide seek"
	}
}

var_0_0.GUIDE_ID_GROUP_SIZE = 100

function var_0_0.checkStartNewGuideByLevel()
	local var_1_0 = P._level
	local var_1_1 = P._playerCity
	local var_1_2 = {
		Data._globalInfo._unlockFindMatch,
		Data._globalInfo._unlockExpedition
	}
	local var_1_3 = {
		Data.UnlockGuideType.find_match,
		Data.UnlockGuideType.expedition
	}

	for iter_1_0 = 1, #var_1_2 do
		if var_1_0 >= var_1_2[iter_1_0] and (P._guideID < 500 or P._guideID % var_0_0.GUIDE_ID_GROUP_SIZE == 0) and math.floor(P._guideID / var_0_0.GUIDE_ID_GROUP_SIZE) < var_1_3[iter_1_0] then
			local var_1_4 = var_1_3[iter_1_0] * var_0_0.GUIDE_ID_GROUP_SIZE + 1

			var_0_0.setGuideIDandSave(var_1_4)

			if Data._guideInfo[var_1_4]._sceneId == ClientData.SceneId.world then
				var_0_0._hasNewWorldGuide = true

				break
			end

			var_0_0._hasNewCityGuide = true

			break
		end
	end
end

function var_0_0.getGuideStepType(arg_2_0)
	return arg_2_0._stepType01
end

function var_0_0.startStepLater(arg_3_0)
	lc._runningScene:runAction(lc.sequence(arg_3_0 or 0.1, function()
		var_0_0.startStep()
	end))
end

function var_0_0.startStep()
	if lc._runningScene._reloadDialog ~= nil then
		return
	end

	local var_5_0 = P._guideID
	local var_5_1 = Data._guideInfo[var_5_0]

	if var_5_1 ~= nil then
		local var_5_2 = math.floor(var_0_0.getGuideStepType(var_5_1) / 10)

		lc.log("startStep %d, mainType = %d", P._guideID, var_5_2)

		var_0_0._hasNewWorldGuide = false
		var_0_0._hasNewCityGuide = false

		if var_5_2 == 0 then
			if var_0_0.getGuideStepType(var_5_1) ~= 0 then
				var_0_0.showOperateLayer(true)
			end
		elseif var_5_2 == var_0_0.StepType.dialog then
			var_0_0.showStoryDialog()
		elseif var_5_2 == var_0_0.StepType.operation then
			var_0_0.showOperateLayer(true)
		elseif var_5_2 == var_0_0.StepType.tip then
			var_0_0.showNpcTipLayer()
		else
			var_0_0.showOperateLayer(false)
		end

		return true
	end

	return false
end

function var_0_0.finishStepLater(arg_6_0)
	if var_0_0._layer then
		var_0_0._layer._blockTouch = true
	end

	lc._runningScene:runAction(lc.sequence(arg_6_0 or 0.1, function()
		var_0_0.finishStep()
	end))
end

function var_0_0.finishStep(arg_8_0)
	lc.log("finish step id: %d, name: %s, isMaualStep = %s", P._guideID, var_0_0.getCurStepName(), arg_8_0 and "true" or "false")

	local var_8_0 = P._guideID
	local var_8_1 = Data._guideInfo[var_8_0]

	if var_8_1 == nil then
		return
	end

	if var_0_0.getGuideStepType(var_8_1) ~= 33 and var_0_0.getGuideStepType(var_8_1) ~= 34 then
		var_0_0.closeNpcTipLayer()
	end

	var_0_0.releaseLayer()
	var_0_0.releaseFinger()

	local var_8_2 = var_8_1._saveStep

	if var_8_0 < 200 and var_8_2 > 0 or var_8_0 >= 200 and var_8_2 >= 500 and var_8_2 % var_0_0.GUIDE_ID_GROUP_SIZE == 0 then
		if var_8_2 < 10000 then
			ClientData.sendGuideID(var_8_2)

			local var_8_3 = cc.EventCustom:new(var_0_0.Event.finish)

			var_8_3._guideId = var_8_2

			lc.Dispatcher:dispatchEvent(var_8_3)
		else
			P._guideID = GuideManager._savedGuideId
			var_0_0._savedGuideId = nil

			if var_0_0.isGuideEnabled() then
				var_0_0.startStep()
			end

			return
		end
	end

	local var_8_4 = var_8_1._sceneId

	P._guideID = var_8_0 + 1

	local var_8_5 = Data._guideInfo[P._guideID]

	if var_8_5 == nil and var_8_5 == nil then
		return
	end

	if var_8_4 ~= var_8_5._sceneId and var_8_2 > 0 then
		ClientData.sendGuideID(var_8_2)
	end

	if lc._runningScene._reloadDialog == nil then
		if arg_8_0 then
			var_0_0.showOperateLayer(false)
		else
			var_0_0.startStep()
		end
	end
end

function var_0_0.pauseGuide()
	if var_0_0._layer == nil and var_0_0._storyLayer == nil and var_0_0._tipLayer == nil then
		return
	end

	if var_0_0._layer then
		var_0_0._layer:setVisible(false)

		var_0_0._layer._ignoreTouch = true
	end

	if var_0_0._storyLayer then
		var_0_0._storyLayer:setVisible(false)
	end

	if var_0_0._tipLayer then
		var_0_0._tipLayer:setVisible(false)
	end

	if var_0_0._finger then
		var_0_0._finger:setVisible(false)
	end
end

function var_0_0.resumeGuide()
	if var_0_0._layer then
		var_0_0._layer:setVisible(true)

		var_0_0._layer._ignoreTouch = false
	end

	if var_0_0._storyLayer then
		var_0_0._storyLayer:setVisible(true)
	end

	if var_0_0._tipLayer then
		var_0_0._tipLayer:setVisible(true)
	end

	if var_0_0._finger then
		var_0_0._finger:setVisible(true)
	end
end

function var_0_0.stopGuide()
	var_0_0.closeStoryDialog()
	var_0_0.closeNpcTipLayer()
	var_0_0.releaseLayer()
	var_0_0.releaseFinger()
end

function var_0_0.addContainerLayer(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_2 then
		var_12_0 = ClientView.createClipNode(arg_12_0, arg_12_2, true)
	else
		var_12_0 = cc.Node:create()

		var_12_0:addChild(arg_12_0)
	end

	var_12_0:setContentSize(lc._runningScene._scene:getContentSize())
	lc._runningScene._scene:addChild(var_12_0, arg_12_1 or ClientData.ZOrder.guide)

	arg_12_0._guideContainer = var_12_0

	return var_12_0
end

function var_0_0.removeContainerLayer(arg_13_0)
	if arg_13_0._guideContainer then
		arg_13_0._guideContainer:removeFromParent()

		arg_13_0._guideContainer = nil
	else
		arg_13_0:removeFromParent()
	end
end

function var_0_0.addHighlightEffect(arg_14_0, arg_14_1)
	local var_14_0 = ClientView.SCR_CW
	local var_14_1 = ClientView.SCR_CH
	local var_14_2

	local function var_14_3(arg_15_0, arg_15_1, arg_15_2)
		var_14_2 = lc.createSprite("img_arrow_right")

		var_14_2:setColor(lc.Color3B.yellow)
		var_14_2:setPosition(arg_15_0.x - 40, arg_15_0.y + 70)
		var_14_2:runAction(lc.rep(lc.sequence(lc.moveBy(0.5, -10, 0), lc.moveBy(0.5, 10, 0))))

		if arg_15_2 then
			var_14_2:setFlippedX(arg_15_2)
		end

		arg_15_1 = arg_15_1 and ClientView.createTTF(arg_15_1, ClientView.FontSize.S1, lc.Color3B.yellow)

		return arg_15_1, var_14_2
	end

	local var_14_4 = var_0_0._tipLayer or var_0_0._storyDialog
	local var_14_5
	local var_14_6
	local var_14_7
	local var_14_8
	local var_14_9
	local var_14_10

	if arg_14_0 == var_0_0.HighlightType.battle_gem then
		local var_14_11 = lc._runningScene._battleUi
		local var_14_12 = var_14_11._playerUi._pHandCards[1]
		local var_14_13 = 70 * var_14_11._scale
		local var_14_14 = 8 * var_14_11._scale
		local var_14_15 = var_14_4:convertToNodeSpace(var_14_12._pFrame._starArea:getParent():convertToWorldSpace(cc.p(var_14_12._pFrame._starArea:getPosition())))

		var_14_15.x = var_14_15.x
		var_14_15.y = var_14_15.y - 40
		var_14_5 = cc.rect(var_14_15.x - var_14_13, var_14_15.y - var_14_14, var_14_13 * 2, var_14_14 * 2)
		var_14_7, var_14_6 = var_14_3(var_14_5, Str(STR.MONSTER_STAR))

		var_14_6:setPosition(var_14_5.x - 30, var_14_5.y + var_14_14)
		var_14_7:setPosition(lc.right(var_14_6) - lc.w(var_14_7) / 2, lc.top(var_14_6) + lc.h(var_14_7) / 2)
	elseif arg_14_0 == var_0_0.HighlightType.battle_atk_hp or arg_14_0 == var_0_0.HighlightType.battle_atk_hp_2 then
		local var_14_16 = lc._runningScene._battleUi
		local var_14_17 = var_14_16._playerUi._pBoardCards[1]
		local var_14_18 = var_14_4:convertToNodeSpace(var_14_17:getParent():convertToWorldSpace(cc.p(var_14_17:getPosition())))

		var_14_18.y = var_14_18.y - 40 * var_14_16:getScale()

		local var_14_19 = 80 * var_14_16:getScale()
		local var_14_20 = 18 * var_14_16:getScale()

		var_14_5 = cc.rect(var_14_18.x - var_14_19, var_14_18.y - var_14_20, var_14_19 * 2, var_14_20 * 2)
		var_14_7, var_14_6 = var_14_3(var_14_5, Str(arg_14_0 == var_0_0.HighlightType.battle_atk_hp and STR.ATK_VALUE or STR.HP_VALUE))

		var_14_6:setPosition(var_14_5.x - 30, var_14_5.y + var_14_20)
		var_14_7:setPosition(lc.right(var_14_6) - lc.w(var_14_7) / 2, lc.top(var_14_6) + lc.h(var_14_7) / 2)
	elseif arg_14_0 == var_0_0.HighlightType.battle_atk then
		local var_14_21 = lc._runningScene._battleUi
		local var_14_22 = var_14_21._playerUi._pBoardCards[1]
		local var_14_23 = cc.p(ClientView.SCR_CW - 30, lc.y(var_14_21))
		local var_14_24 = 76 * var_14_21:getScale()
		local var_14_25 = 240 * var_14_21:getScale()

		var_14_5 = cc.rect(var_14_23.x - var_14_24, var_14_23.y - var_14_25, var_14_24 * 2, var_14_25 * 2)

		local var_14_26 = lc.createSprite({
			_name = "img_arrow_up_3",
			_crect = ClientView.CRECT_ARROW_3,
			_size = cc.size(40, 300)
		})

		var_14_26:setOpacity(230)

		local var_14_27 = ClientView.createBMFont(ClientView.BMFont.huali_32, Str(STR.POWER))

		var_14_27:setColor(cc.c3b(255, 150, 150))
		lc.addChildToCenter(var_14_26, var_14_27)
		table.insert(var_14_4._highlightObjs, var_14_26)
		lc.addChildToPos(lc._runningScene._scene, var_14_26, cc.p(var_14_0 - 30, var_14_1 + 60), ClientData.ZOrder.guide)
	elseif arg_14_0 == var_0_0.HighlightType.battle_round_btn then
		local var_14_28 = lc._runningScene._battleUi
		local var_14_29 = var_14_28._playerUi
		local var_14_30 = var_14_4:convertToNodeSpace(var_14_28._btnEndRound:getParent():convertToWorldSpace(cc.p(var_14_28._btnEndRound:getPosition())))

		var_14_30.x = var_14_30.x - 16
		var_14_30.y = var_14_30.y - 6

		local var_14_31 = 60 * var_14_28:getScale()
		local var_14_32 = 64 * var_14_28:getScale()

		var_14_5 = cc.rect(var_14_30.x - var_14_31, var_14_30.y - var_14_32, var_14_31 * 2, var_14_32 * 2)
		_, var_14_6 = var_14_3(var_14_5)

		var_14_6:setPosition(var_14_5.x - 40, var_14_5.y + 35)
		var_14_28._btnEndRound:loadTextureNormal("bat_btn_5", ccui.TextureResType.plistType)
		var_14_28._pRoundTitle:setSpriteFrame("bat_label_end_2")
	elseif arg_14_0 == var_0_0.HighlightType.battle_skill then
		var_14_5 = cc.rect(var_14_0 - 452, var_14_1 - 76, 320, 160)
	elseif arg_14_0 == var_0_0.HighlightType.battle_fortress then
		var_14_5 = cc.rect(var_14_0 - 105, var_14_1 + 256, 210, 80)
		var_14_7, var_14_6 = var_14_3(var_14_5, string.format("%s%s", Str(STR.LEVEL_UP_HP), string.format(Str(STR.BRACKETS_S), Str(STR.LIFE))))

		var_14_6:setPosition(var_14_5.x - 40, var_14_5.y + 30)
		var_14_7:setPosition(lc.right(var_14_6) - lc.w(var_14_7) / 2, lc.top(var_14_6) + lc.h(var_14_7) / 2)
	elseif arg_14_0 == var_0_0.HighlightType.battle_empty_pos then
		var_14_5 = cc.rect(var_14_0 + 80, var_14_1 - 130, 160, 400)

		local var_14_33 = lc.createSprite({
			_name = "img_arrow_up_3",
			_crect = ClientView.CRECT_ARROW_3,
			_size = cc.size(40, 340)
		})

		var_14_33:setOpacity(230)
		var_14_33:setRotation(-20)

		local var_14_34 = ClientView.createBMFont(ClientView.BMFont.huali_32, Str(STR.POWER) .. Str(STR.FORTRESS))

		var_14_34:setColor(cc.c3b(255, 150, 150))
		lc.addChildToCenter(var_14_33, var_14_34)
		table.insert(var_14_4._highlightObjs, var_14_33)
		lc.addChildToPos(lc._runningScene._scene, var_14_33, cc.p(var_14_0 + 90, var_14_1 + 140), ClientData.ZOrder.guide)
	elseif arg_14_0 == var_0_0.HighlightType.battle_setting_btn then
		local var_14_35 = lc.x(arg_14_1)
		local var_14_36 = lc.y(arg_14_1)
		local var_14_37 = lc.w(arg_14_1)
		local var_14_38 = lc.h(arg_14_1)

		var_14_5 = cc.rect(var_14_35 - var_14_37 / 2, var_14_36 - var_14_38 / 2 + 3, var_14_37, var_14_38)
		var_14_7, var_14_6 = var_14_3(var_14_5, Str(STR.BATTLE_SETTING_BUTTON), true)

		var_14_6:setPosition(var_14_35 + 80, var_14_36 - 12)
		var_14_7:setPosition(lc.left(var_14_6) + lc.w(var_14_7) / 2, lc.top(var_14_6) + lc.h(var_14_7) / 2)
	elseif arg_14_0 == var_0_0.HighlightType.herocenter_troop then
		local var_14_39 = ClientView.SCR_W

		var_14_5 = cc.rect(var_14_39 - 212, 4, 208, 104)
	end

	if var_14_5 then
		local var_14_40 = lc.createSprite({
			_name = "img_highlight_rect",
			_crect = cc.rect(21, 21, 1, 1),
			_size = cc.size(var_14_5.width + 20, var_14_5.height + 20)
		})

		var_14_40:setColor(lc.Color3B.yellow)
		table.insert(var_14_4._highlightObjs, var_14_40)
		lc.addChildToPos(var_14_4, var_14_40, cc.p(var_14_5.x + var_14_5.width / 2, var_14_5.y + var_14_5.height / 2))

		if var_14_6 then
			table.insert(var_14_4._highlightObjs, var_14_6)
			var_14_4:addChild(var_14_6)
		end

		if var_14_7 then
			table.insert(var_14_4._highlightObjs, var_14_7)
			var_14_4:addChild(var_14_7)
		end
	end

	return var_14_5
end

function var_0_0.getCurSaveGuideId()
	local var_16_0 = P._guideID

	if var_16_0 == nil then
		return nil
	end

	local var_16_1 = Data._guideInfo[var_16_0]

	if var_16_1 == nil or var_16_1._saveStep == 0 then
		return nil
	end

	return var_16_1._saveStep
end

function var_0_0.getGroup()
	return math.floor(P._guideID / var_0_0.GUIDE_ID_GROUP_SIZE)
end

function var_0_0.isGuideEnabled()
	local var_18_0 = P._guideID

	if var_18_0 == nil then
		return false
	end

	return Data._guideInfo[var_18_0] ~= nil or P._guideID < 100
end

function var_0_0.isGuideInCity()
	local var_19_0 = Data._guideInfo[P._guideID]

	if var_19_0 == nil then
		return false
	end

	return var_19_0._sceneId == ClientData.SceneId.city and var_0_0.isGuideEnabled()
end

function var_0_0.isGuideInWorld()
	local var_20_0 = Data._guideInfo[P._guideID]

	if var_20_0 == nil then
		return false
	end

	return var_20_0._sceneId == ClientData.SceneId.world and var_0_0.isGuideEnabled()
end

function var_0_0.setGuideIDandSave(arg_21_0, arg_21_1)
	if P._guideID == arg_21_0 then
		return
	end

	lc.log("Set guide id = %d", arg_21_0)

	if arg_21_1 or Data._guideInfo[arg_21_0] then
		P._guideID = arg_21_0

		ClientData.sendGuideID(arg_21_0)
	end
end

function var_0_0.showStoryDialog()
	local var_22_0 = Data._guideInfo[P._guideID]

	var_0_0.releaseLayer()

	local var_22_1 = lc.createMaskLayer(ClientView.MASK_OPACITY_LIGHT)

	var_0_0.addContainerLayer(var_22_1)

	local var_22_2 = var_0_0.createStoryDialog({
		_nameSid = var_22_0._nameSid,
		_stepType = var_0_0.getGuideStepType(var_22_0),
		_roleId = var_22_0._param
	}, function()
		var_0_0.finishStep()
		var_22_1:removeFromParent()
	end)

	var_22_1:addChild(var_22_2)
end

function var_0_0.createStoryDialog(arg_24_0, arg_24_1)
	local var_24_0 = 800
	local var_24_1 = 240
	local var_24_2 = 450
	local var_24_3 = 50
	local var_24_4 = 70
	local var_24_5 = arg_24_0._stepType < 20
	local var_24_6 = arg_24_0._stepType % 10 == 1

	var_0_0.closeStoryDialog()

	local var_24_7 = ccui.Widget:create()

	var_24_7:setContentSize(lc.Director:getVisibleSize())
	var_24_7:setAnchorPoint(0, 0)
	var_24_7:setPosition(0, 0)

	var_24_7._isSelfStory = var_24_5
	var_0_0._storyDialog = var_24_7
	var_24_7._highlightObjs = {}

	local var_24_8 = lc.createSprite({
		_name = "img_com_bg_16",
		_crect = ClientView.CRECT_COM_BG16,
		_size = cc.size(var_24_0, var_24_1)
	})

	var_24_8:setPosition(lc.w(var_24_7) / 2, lc.h(var_24_7) / 2 + (var_24_5 and -80 or 250))

	var_24_7._bg = var_24_8

	var_24_7:addChild(var_24_8)
	var_24_7:setTouchEnabled(false)

	var_24_7._closeHandler = arg_24_1

	var_24_7:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 == ccui.TouchEventType.ended then
			var_0_0.closeStoryDialog()

			if var_24_7._closeHandler then
				var_24_7._closeHandler()
			end
		end
	end)

	local var_24_9 = arg_24_0._roleId
	local var_24_10
	local var_24_11

	if var_24_9 == 0 then
		var_24_10 = lc.createSprite("card_thu_0")
		var_24_11 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.NPC_NAME))
	else
		var_24_10 = lc.createSprite(string.format("card_thu_%d", ClientData.getPicIdByInfoId(var_24_9)))
		var_24_11 = ClientView.createBMFont(ClientView.BMFont.huali_26, ClientData.getNameByInfoId(var_24_9))
	end

	var_24_8:addChild(var_24_10)
	var_24_8:addChild(var_24_11)

	local var_24_12 = ClientView.createBoldRichText(Str(arg_24_0._nameSid), {
		_normalClr = ClientView.COLOR_TEXT_DARK,
		_boldClr = ClientView.COLOR_TEXT_GREEN_DARK,
		_fontSize = ClientView.FontSize.S1,
		_width = var_24_2
	})

	var_24_12:setCascadeOpacityEnabled(true)
	var_24_8:addChild(var_24_12)

	local var_24_13 = cc.Label:createWithTTF(Str(STR.CONTINUE), ClientView.TTF_FONT, ClientView.FontSize.S2)

	var_24_13:setPositionY(lc.h(var_24_13) / 2 + 40)
	var_24_13:setColor(ClientView.COLOR_TEXT_DARK)

	var_24_7._nextLabel = var_24_13

	var_24_8:addChild(var_24_13)

	local var_24_14 = 236
	local var_24_15 = 262

	if var_24_6 then
		var_24_10:setPosition(var_24_14 / 2 + 30, var_24_15 / 2 + 40)
		var_24_12:setPosition(var_24_4 + lc.w(var_24_12) / 2 + var_24_14 - 30, lc.h(var_24_8) - var_24_3 - lc.h(var_24_12) / 2)
		var_24_13:setPositionX(650)
	else
		var_24_10:setPosition(lc.w(var_24_8) - var_24_14 / 2 - 30, var_24_15 / 2 + 40)
		var_24_12:setPosition(var_24_4 + lc.w(var_24_12) / 2, lc.h(var_24_8) - var_24_3 - lc.h(var_24_12) / 2)
		var_24_13:setPositionX(lc.left(var_24_12) + lc.w(var_24_13) / 2)
	end

	var_24_11:setPosition(lc.x(var_24_10), 40)

	local var_24_16 = cc.Sprite:createWithSpriteFrameName("img_title_decoration")

	var_24_16:setFlippedX(true)
	lc.addChildToPos(var_24_8, var_24_16, cc.p(lc.left(var_24_11) - lc.w(var_24_16) / 2 - 10, lc.y(var_24_11)))

	local var_24_17 = cc.Sprite:createWithSpriteFrameName("img_title_decoration")

	lc.addChildToPos(var_24_8, var_24_17, cc.p(lc.right(var_24_11) + lc.w(var_24_17) / 2 + 10, lc.y(var_24_11)))

	for iter_24_0, iter_24_1 in ipairs(var_24_8:getChildren()) do
		iter_24_1:setOpacity(0)
	end

	local var_24_18 = lc.frameSize("img_com_bg_16")

	var_24_8:setAnchorPoint(var_24_5 and 0 or 1, 1)
	var_24_8:setPositionX(lc.w(var_24_7) / 2 + (lc.ax(var_24_8) - 0.5) * var_24_0)
	var_24_8:setContentSize(var_24_18)
	var_24_8:setOpacity(0)
	var_24_8:runAction(cc.FadeIn:create(0.3))

	local var_24_19 = 0.4

	lc.offset(var_24_12, var_24_6 and -50 or 50)
	var_24_12:runAction(lc.sequence(var_24_19 + 0.1, {
		lc.fadeIn(0.2),
		lc.moveBy(0.2, var_24_6 and 50 or -50, 0)
	}, function()
		var_24_13:runAction(lc.rep(lc.sequence(lc.fadeIn(0.5), 0.5, lc.fadeOut(0.5))))
		var_24_7:setTouchEnabled(true)
	end))

	local var_24_20 = 7
	local var_24_21 = (var_24_0 - var_24_18.width) * var_24_20 / (var_24_1 - var_24_18.height)

	var_24_8:registerScriptHandler(function(arg_27_0)
		if arg_27_0 == "enter" then
			var_24_8:scheduleUpdateWithPriorityLua(function(arg_28_0)
				local var_28_0 = var_24_8:getContentSize()

				var_28_0.width = var_28_0.width + var_24_21
				var_28_0.height = var_28_0.height + var_24_20

				if var_28_0.height > var_24_1 then
					var_28_0.width = var_24_0
					var_28_0.height = var_24_1

					var_24_8:unscheduleUpdate()
					lc.offset(var_24_10, 0, 50)
					var_24_10:runAction(lc.sequence(0.05, {
						lc.fadeIn(var_24_19),
						lc.ease(lc.moveBy(var_24_19, 0, -50), "BackO")
					}))
					var_24_11:runAction(lc.fadeIn(var_24_19))
					var_24_16:runAction(lc.fadeIn(var_24_19))
					var_24_17:runAction(lc.fadeIn(var_24_19))
				end

				var_24_8:setContentSize(var_28_0)
			end, 0)
		elseif arg_27_0 == "exit" then
			var_24_8:unscheduleUpdate()
		end
	end)

	return var_24_7
end

function var_0_0.closeStoryDialog()
	local var_29_0 = var_0_0._storyDialog

	if var_29_0 then
		var_29_0:setTouchEnabled(false)
		var_29_0._nextLabel:stopAllActions()
		var_0_0.hideHighlightObjs(var_29_0)
		var_29_0:runAction(lc.sequence({
			lc.fadeOut(0.4),
			lc.ease(lc.moveBy(0.2, 0, var_29_0._isSelfStory and -500 or 350), "BackI")
		}, function()
			var_0_0.removeHighlightObjs(var_29_0)
			var_0_0.removeContainerLayer(var_29_0)
		end))

		var_0_0._storyDialog = nil
	end
end

function var_0_0.showNpcTipLayer()
	local var_31_0 = P._guideID
	local var_31_1 = Data._guideInfo[var_31_0]

	lc.log("show Npc guideId = %d", var_31_0)
	var_0_0.releaseLayer()

	local var_31_2 = var_0_0.getGuideStepType(var_31_1) % 10
	local var_31_3 = var_31_2 <= 2
	local var_31_4 = var_31_2 == 1 or var_31_2 == 3
	local var_31_5 = var_31_1._param < 5000 and var_31_1._param or 0
	local var_31_6 = var_0_0.createNpcTipLayer(var_31_1, var_31_3, var_31_4, false, var_31_5)

	if var_31_3 then
		function var_31_6._closeHandler()
			var_0_0.finishStep()
		end

		if var_31_1._param > 5000 then
			local var_31_7 = var_31_1._param - 5000
			local var_31_8 = var_0_0.addHighlightEffect(var_31_7)

			var_0_0.addContainerLayer(var_31_6, nil, var_31_8)

			return
		end
	else
		var_0_0.finishStep()
	end

	var_0_0.addContainerLayer(var_31_6)
end

function var_0_0.createNpcTipLayer(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_0._id
	local var_33_1 = arg_33_0._nameSid
	local var_33_2 = 60
	local var_33_3 = 45
	local var_33_4 = var_33_3
	local var_33_5 = var_33_3 + var_33_4
	local var_33_6 = 30
	local var_33_7 = 70
	local var_33_8 = var_33_6 + var_33_7
	local var_33_9 = cc.p(350, 336)
	local var_33_10 = cc.p(900, 336)

	if arg_33_4 == nil or arg_33_4 <= 0 then
		arg_33_4 = 320
	end

	var_0_0.closeNpcTipLayer()

	local var_33_11 = lc.createMaskLayer(arg_33_1 and ClientView.MASK_OPACITY_LIGHT or 0, nil, ClientView.SCR_SIZE)

	var_33_11:setTouchEnabled(arg_33_1)

	var_33_11._canClose = false
	var_0_0._tipLayer = var_33_11
	var_33_11._highlightObjs = {}

	local var_33_12 = lc.createNode(ClientView.SCR_SIZE)

	lc.addChildToCenter(var_33_11, var_33_12)

	local var_33_13
	local var_33_14 = ClientView.SCR_EDGE

	if arg_33_0._roleId == 1 then
		if ClientData.isAnotherSkin() then
			var_33_13 = cc.DragonBonesNode:createWithDecrypt("res/effects/loading.lcres", "loading", "loading")

			var_33_13:setPosition(arg_33_2 and 280 + var_33_14 or lc.w(var_33_12) - 280 - var_33_14, 130)
			var_33_13:gotoAndPlay("effect4")
		elseif ClientData.isAnotherSkin2() then
			var_33_13 = cc.DragonBonesNode:createWithDecrypt("res/effects/youxi_pifu2.lcres", "youxi_pifu2", "youxi_pifu2")

			var_33_13:setPosition(arg_33_2 and 280 + var_33_14 or lc.w(var_33_12) - 280 - var_33_14, 130)
			var_33_13:setScale(0.7)
			var_33_13:gotoAndPlay("effect")
		else
			var_33_13 = cc.DragonBonesNode:createWithDecrypt("res/effects/youxi_nv.lcres", "youxi_nv", "youxi_nv")

			var_33_13:setPosition(arg_33_2 and 280 + var_33_14 or lc.w(var_33_12) - 280 - var_33_14, 130)
			var_33_13:setScale(0.7)
			var_33_13:gotoAndPlay("effect")
		end
	elseif arg_33_0._roleId == 2 then
		if ClientData.isAnotherSkin() then
			var_33_13 = cc.DragonBonesNode:createWithDecrypt("res/effects/loading.lcres", "loading", "loading")

			var_33_13:setPosition(arg_33_2 and 280 + var_33_14 or lc.w(var_33_12) - 280 - var_33_14, 130)
			var_33_13:gotoAndPlay("effect5")
		elseif ClientData.isAnotherSkin2() then
			var_33_13 = cc.DragonBonesNode:createWithDecrypt("res/effects/haima_pifu2.lcres", "haima_pifu2", "haima_pifu2")

			var_33_13:setPosition(arg_33_2 and 280 + var_33_14 or lc.w(var_33_12) - 280 - var_33_14, 130)
			var_33_13:setScale(0.7)
			var_33_13:gotoAndPlay("effect")
		else
			var_33_13 = cc.DragonBonesNode:createWithDecrypt("res/effects/haima_nv.lcres", "haima_nv", "haima_nv")

			var_33_13:setPosition(arg_33_2 and 280 + var_33_14 or lc.w(var_33_12) - 280 - var_33_14, 130)
			var_33_13:setScale(0.7)
			var_33_13:gotoAndPlay("effect")
		end
	elseif ClientData.isAnotherSkin() then
		var_33_13 = cc.DragonBonesNode:createWithDecrypt("res/effects/hmssn.lcres", "hmssn", "hmssn")

		var_33_13:setPosition(arg_33_2 and 250 + var_33_14 or lc.w(var_33_12) - 250 - var_33_14, 130)
		var_33_13:gotoAndPlay(arg_33_2 and "effect1" or "effect2")
	else
		var_33_13 = cc.DragonBonesNode:createWithDecrypt("res/effects/yindao2.lcres", "yindao2", "yindao2")

		var_33_13:setPosition(arg_33_2 and 250 + var_33_14 or lc.w(var_33_12) - 250 - var_33_14, 90)
		var_33_13:setScale(arg_33_2 and -0.7 or 0.7, 0.7)
		var_33_13:gotoAndPlay("effect")
	end

	var_33_12:addChild(var_33_13, 1)

	var_33_11._npc = var_33_13

	local var_33_15

	if arg_33_1 then
		var_33_11:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 == ccui.TouchEventType.ended and var_33_11._canClose then
				var_0_0.closeNpcTipLayer()

				if var_33_11._closeHandler then
					var_33_11._closeHandler()
				end
			end
		end)

		var_33_15 = cc.Label:createWithTTF(Str(STR.CONTINUE), ClientView.TTF_FONT, ClientView.FontSize.S2)

		var_33_15:setColor(ClientView.COLOR_TEXT_DARK)
		var_33_15:setOpacity(0)

		var_33_11._next = var_33_15
	end

	local var_33_16 = string.splitByChar(Str(var_33_1), "/")
	local var_33_17 = string.gsub(var_33_16[1], "USERNAME", P._name)
	local var_33_18 = ClientView.createBoldRichText(var_33_17, {
		_normalClr = ClientView.COLOR_TEXT_DARK,
		_boldClr = ClientView.COLOR_TEXT_BLUE_2,
		_fontSize = ClientView.FontSize.S1,
		_width = arg_33_4
	})

	var_33_18:setCascadeOpacityEnabled(true)
	var_33_18:setAnchorPoint(cc.p(arg_33_2 and 0 or 1, 0))
	var_33_18:setOpacity(0)

	var_33_11._tip = var_33_18

	local var_33_19 = ccui.Scale9Sprite:createWithSpriteFrameName("img_tip_bg", ClientView.CRECT_TIP_BG)

	var_33_19:setAnchorPoint(arg_33_2 and 0 or 1, 0)
	var_33_19:setScale(0)
	var_33_19:setContentSize(cc.size(lc.w(var_33_18) + var_33_5, lc.h(var_33_18) + var_33_8 + (var_33_15 and lc.h(var_33_15) + 10 or 0)))
	var_33_19:setFlippedX(arg_33_2)

	var_33_11._tipBg = var_33_19

	local var_33_20

	if arg_33_0._roleId == 1 or arg_33_0._roleId == 2 then
		var_33_20 = cc.p(arg_33_2 and 620 + lc.w(var_33_19) + var_33_14 or ClientView.SCR_W - 450 - var_33_14, 60)
	else
		var_33_20 = cc.p(arg_33_2 and lc.w(var_33_19) + var_33_14 or lc.w(var_33_12) - var_33_14, 360)
	end

	lc.addChildToPos(var_33_12, var_33_19, var_33_20, 2)
	lc.addChildToPos(var_33_12, var_33_18, cc.p(var_33_20.x + (arg_33_2 and -var_33_4 - lc.w(var_33_18) or -var_33_4), var_33_20.y + var_33_7 + (var_33_15 and lc.h(var_33_15) + 10 or 0)), 2)

	if var_33_15 then
		lc.addChildToPos(var_33_12, var_33_15, cc.p(lc.right(var_33_18) - lc.w(var_33_15) / 2, lc.bottom(var_33_18) - 10 - lc.h(var_33_15) / 2))
	end

	lc.offset(var_33_13, 0, -200)
	var_33_13:runAction(lc.spawn(lc.ease(lc.moveBy(0.4, 0, 200), "BackO"), lc.sequence(0.1, function()
		local var_35_0 = AUDIO[string.format(arg_33_3 and "E_STORY_%d" or "E_GUIDE_%d", var_33_0)]

		if var_35_0 then
			lc.Audio.playAudio(var_35_0)
		end

		var_33_19:runAction(lc.sequence({
			lc.fadeIn(0.2),
			lc.ease(lc.scaleTo(0.4, 1), "BackO")
		}, function()
			var_33_18:runAction(lc.sequence(lc.fadeIn(0.1), 0.5, function()
				var_33_11._canClose = true

				if var_33_11._next then
					var_33_11._next:runAction(lc.rep(lc.sequence(lc.fadeIn(0.5), 0.5, lc.fadeOut(0.5))))
				end

				if var_33_11._canCloseHandler then
					var_33_11._canCloseHandler()
				end
			end))
		end))
	end)))

	return var_33_11
end

function var_0_0.closeNpcTipLayer()
	local var_38_0 = var_0_0._tipLayer

	if var_38_0 then
		var_38_0:setTouchEnabled(false)
		var_38_0:setOpacity(0)
		var_0_0.hideHighlightObjs(var_38_0)

		if var_38_0._canCloseHandler then
			var_38_0._canCloseHandler()
		end

		var_38_0._tipBg:stopAllActions()
		var_38_0._tipBg:runAction(lc.fadeOut(0.1))
		var_38_0._tip:stopAllActions()
		var_38_0._tip:runAction(lc.fadeOut(0.1))

		if var_38_0._next then
			var_38_0._next:stopAllActions()
			var_38_0._next:runAction(lc.fadeOut(0.1))
		end

		var_38_0._npc:stopAllActions()
		var_38_0._npc:runAction(lc.sequence(lc.ease(lc.moveBy(0.5, 0, -600), "BackO"), function()
			var_0_0.removeHighlightObjs(var_38_0)
			var_0_0.removeContainerLayer(var_38_0)
		end))

		var_0_0._tipLayer = nil
	end
end

function var_0_0.showOperateLayer(arg_40_0)
	var_0_0.releaseLayer()

	local var_40_0 = ClientView.createTouchLayer()

	lc._runningScene._scene:addChild(var_40_0, ClientData.ZOrder.guide)

	var_0_0._layer = var_40_0

	var_0_0._layer:retain()

	if arg_40_0 then
		local var_40_1 = cc.EventCustom:new(var_0_0.Event.seek)

		if P._guideID == 145 then
			lc._runningScene:onGuide(var_40_1)
		else
			lc.Dispatcher:dispatchEvent(var_40_1)
		end
	end
end

function var_0_0.setOperateLayer(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = var_0_0._layer

	if var_41_0 == nil then
		return
	end

	if arg_41_0.setPropagateTouchEvents then
		arg_41_0:setPropagateTouchEvents(false)
	end

	function var_41_0._touchHandler(arg_42_0, arg_42_1, arg_42_2)
		if var_41_0._ignoreTouch then
			return 0
		end

		if var_41_0._blockTouch then
			return 1
		end

		local var_42_0 = cc.p(arg_42_1, arg_42_2)

		if ClientView.containPos(arg_41_0, var_42_0) then
			return 0
		end

		if arg_41_2 then
			for iter_42_0, iter_42_1 in ipairs(arg_41_2) do
				if lc.contain(iter_42_1, var_42_0) then
					return 0
				end
			end
		end

		return 1
	end

	local var_41_1 = lc._runningScene:convertToNodeSpace(arg_41_0:convertToWorldSpace(cc.p(lc.w(arg_41_0) / 2, lc.h(arg_41_0) / 2)))
	local var_41_2 = var_0_0.createFinger(arg_41_0 ~= var_0_0.lastOperateNode, var_41_1, arg_41_1)

	var_0_0.addContainerLayer(var_41_2)

	var_0_0.lastOperateNode = arg_41_0
end

function var_0_0.hideHighlightObjs(arg_43_0)
	if arg_43_0._highlightObjs then
		for iter_43_0, iter_43_1 in ipairs(arg_43_0._highlightObjs) do
			iter_43_1:setVisible(false)
		end
	end
end

function var_0_0.removeHighlightObjs(arg_44_0)
	if arg_44_0._highlightObjs then
		for iter_44_0, iter_44_1 in ipairs(arg_44_0._highlightObjs) do
			iter_44_1:removeFromParent()
		end

		arg_44_0._highlightObjs = nil
	end
end

function var_0_0.getCurStepName()
	local var_45_0 = Data._guideInfo[P._guideID]

	if var_45_0 == nil then
		return ""
	end

	return var_45_0._stepName
end

function var_0_0.getCurStepId()
	local var_46_0 = Data._guideInfo[P._guideID]

	if var_46_0 == nil then
		return -1
	end

	return var_46_0._id
end

function var_0_0.getNextStepName()
	local var_47_0 = Data._guideInfo[P._guideID]

	if var_47_0._saveStep % var_0_0.GUIDE_ID_GROUP_SIZE == 0 and math.floor(var_47_0._saveStep / var_0_0.GUIDE_ID_GROUP_SIZE) == math.floor(P._guideID / var_0_0.GUIDE_ID_GROUP_SIZE) then
		return ""
	end

	local var_47_1 = P._guideID + 1
	local var_47_2 = Data._guideInfo[var_47_1]

	if var_47_2 == nil then
		local var_47_3 = (var_0_0.getGroup() + 1) * var_0_0.GUIDE_ID_GROUP_SIZE + 1

		var_47_2 = Data._guideInfo[var_47_3]

		if var_47_2 == nil then
			return ""
		end
	end

	return var_47_2._stepName
end

function var_0_0.createFinger(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = lc._runningScene

	var_0_0.releaseFinger()

	local var_48_1 = cc.Sprite:createWithSpriteFrameName("img_finger_01")

	var_48_1:setCascadeOpacityEnabled(false)
	var_48_1:setOpacity(0)
	var_48_1:setAnchorPoint(0, 1)
	var_48_1:setPosition(arg_48_1)

	var_48_1._srcPos = arg_48_1
	var_0_0._finger = var_48_1

	var_0_0._finger:retain()

	if lc.right(var_48_1) > lc.w(var_48_0) then
		var_48_1:setFlippedX(true)
		var_48_1:setAnchorPoint(1, 1)
	end

	local function var_48_2()
		local var_49_0 = cc.Sprite:createWithSpriteFrameName("img_circle")

		var_49_0:setOpacity(0)
		var_49_0:setScale(0.5)
		var_49_0:setPosition(var_48_1:isFlippedX() and lc.w(var_48_1) - 5 or 5, lc.h(var_48_1) - 5)

		return var_49_0
	end

	local var_48_3 = var_48_2()
	local var_48_4 = var_48_2()

	var_48_1:addChild(var_48_3, -1)
	var_48_1:addChild(var_48_4, -1)

	local function var_48_5()
		local var_50_0 = lc.sequence(0.1, lc.fadeIn(0.1), lc.scaleTo(0.4, 3), lc.fadeOut(0.1), lc.scaleTo(0, 0.5))

		var_48_3:runAction(var_50_0)
		var_48_4:runAction(lc.sequence(0.16, var_50_0:clone()))
	end

	local var_48_6

	if arg_48_0 then
		var_48_1:setPosition(lc.w(lc._runningScene) / 2, lc.h(lc._runningScene) / 2)
		var_48_1:setOpacity(255)
		var_48_3:setScale(5)
		var_48_4:setScale(5)

		local var_48_7 = lc.sequence(lc.fadeIn(0.05), lc.scaleTo(0.3, 1), lc.fadeOut(0.05), lc.scaleTo(0, 0.5))

		var_48_3:runAction(var_48_7)
		var_48_4:runAction(lc.sequence(0.16, var_48_7:clone()))

		var_48_6 = lc.ease(lc.moveTo(0.4, arg_48_1.x, arg_48_1.y), "SineIO")
	else
		var_48_6 = lc.fadeIn(0.1)
	end

	var_48_1:runAction(lc.sequence(var_48_6, function()
		if arg_48_2 then
			local var_51_0 = cc.pGetLength(cc.pSub(arg_48_2, arg_48_1))
			local var_51_1 = 300

			var_48_1:runAction(lc.rep(lc.sequence(0.1, function()
				var_48_1:setScale(0.95 * (var_48_1._baseScale or 1))
				var_48_1:setSpriteFrame("img_finger_02")
				var_48_5()
			end, 0.4, lc.moveTo(var_51_0 / var_51_1, arg_48_2), function()
				if arg_48_3 then
					arg_48_1 = arg_48_3()
				end

				var_48_1:setPosition(arg_48_1)
				var_48_1:setScale(1 * (var_48_1._baseScale or 1))
				var_48_1:setSpriteFrame("img_finger_01")
			end)))
		else
			var_48_1:runAction(lc.rep(lc.sequence(0.1, function()
				var_48_1:setScale(0.95 * (var_48_1._baseScale or 1))
				var_48_1:setSpriteFrame("img_finger_02")
				var_48_5()
			end, 0.6, function()
				if arg_48_3 then
					arg_48_1 = arg_48_3()

					var_48_1:setPosition(arg_48_1)
				end

				var_48_1:setScale(1 * (var_48_1._baseScale or 1))
				var_48_1:setSpriteFrame("img_finger_01")
			end)))
		end
	end))

	return var_48_1
end

function var_0_0.showSoftGuideFinger(arg_56_0, arg_56_1)
	local var_56_0 = var_0_0.createFinger(false, cc.p(lc.w(arg_56_0) / 2, lc.h(arg_56_0) / 2))

	arg_56_0._softGuideFinger = var_56_0

	arg_56_0:addChild(var_56_0, 100)

	if arg_56_1 then
		var_56_0:runAction(lc.sequence(0.7 * arg_56_1, function()
			var_0_0.releaseFinger()
		end))
	end
end

function var_0_0.releaseLayer()
	if var_0_0._layer then
		if var_0_0._layer:getParent() then
			var_0_0._layer:removeFromParent()
		end

		var_0_0._layer:release()

		var_0_0._layer = nil
	end
end

function var_0_0.releaseFinger()
	local var_59_0 = var_0_0._finger

	if var_59_0 then
		if var_59_0:getParent() then
			var_0_0.removeContainerLayer(var_59_0)
		end

		var_59_0:release()

		var_0_0._finger = nil
	end
end

function var_0_0.getGuideIDByStepName(arg_60_0)
	for iter_60_0, iter_60_1 in pairs(Data._guideInfo) do
		if iter_60_1._stepName == arg_60_0 then
			return iter_60_0
		end
	end

	return 65535
end

function var_0_0.getCurDifficultyStepName()
	local var_61_0 = Data._guideInfo[P._guideDifficultyID]

	if var_61_0 == nil then
		return ""
	end

	return var_61_0._stepName
end

function var_0_0.getCurRecruiteStepName()
	local var_62_0 = Data._guideInfo[P._guideRecruiteID]

	if var_62_0 == nil then
		return ""
	end

	return var_62_0._stepName
end

GuideManager = var_0_0

return var_0_0
