local var_0_0 = BattleUi

function var_0_0.updateCardZOrder(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0 = 1, 2 do
		local var_1_1 = iter_1_0 == 1 and arg_1_0._playerUi or arg_1_0._opponentUi
		local var_1_2 = Data.MAX_CARD_COUNT_ON_BOARD + #var_1_1._pGraveCards + #var_1_1._pHandCards

		for iter_1_1 = 1, var_1_2 do
			local var_1_3

			if var_1_2 <= Data.MAX_CARD_COUNT_ON_BOARD then
				var_1_3 = var_1_1._pBoardCards[iter_1_1]
			elseif var_1_2 <= Data.MAX_CARD_COUNT_ON_BOARD + #var_1_1._pGraveCards then
				var_1_3 = var_1_1._pGraveCards[iter_1_1 - Data.MAX_CARD_COUNT_ON_BOARD]
			else
				var_1_3 = var_1_1._pHandCards[iter_1_1 - Data.MAX_CARD_COUNT_ON_BOARD - #var_1_1._pGraveCards]
			end

			if var_1_3 then
				var_1_3:updateZOrder(var_1_3 == arg_1_1)
			end
		end
	end
end

function var_0_0.createParticle(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if arg_2_3 == nil or arg_2_1 == nil then
		return
	end

	local var_2_0 = Particle.create(arg_2_1)
	if not var_2_0 then return nil end

	var_2_0:setPosition(arg_2_2)
	arg_2_3:addChild(var_2_0, arg_2_5 or 0)

	if arg_2_4 then
		var_2_0:setPositionType(cc.POSITION_TYPE_GROUPED)
	end

	if arg_2_3.getCameraMask and arg_2_3:getCameraMask() == (ClientData and ClientData.CAMERA_3D_FLAG or 2) then
		arg_2_0._scene:seenByCamera3D(var_2_0)
	end

	return var_2_0
end

function var_0_0.createDragonBones(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	if arg_3_3 == nil or arg_3_1 == nil then
		return
	end

	arg_3_4 = arg_3_4 or "effect"

	if arg_3_5 == nil then
		arg_3_5 = true
	end

	local var_3_0 = DragonBones.create(arg_3_1)

	var_3_0:setPosition(arg_3_2)
	var_3_0:setScale(arg_3_6 or 1)
	arg_3_3:addChild(var_3_0, arg_3_7 or 0)
	if arg_3_3.getCameraMask and arg_3_3:getCameraMask() == (ClientData and ClientData.CAMERA_3D_FLAG or 2) then
		arg_3_0._scene:seenByCamera3D(var_3_0)
	end
	var_3_0:gotoAndPlay(arg_3_4)

	if arg_3_5 then
		local var_3_1 = var_3_0:getAnimationDuration(arg_3_4)

		var_3_0:runAction(lc.sequence(var_3_1, lc.remove()))
	end

	return var_3_0
end

function var_0_0.showResult(arg_4_0)
	lc.Director:updateTouchTimestamp()
	cc.Director:getInstance():getScheduler():setTimeScale(1)

	local var_4_0 = arg_4_0._result or {}
	local var_4_1 = BattleResultDialog.Type.battle_result

	if arg_4_0._baseBattleType == Data.BattleType.base_replay or arg_4_0._battleType == Data.BattleType.PVP_room and arg_4_0._isObserver then
		var_4_1 = BattleResultDialog.Type.replay_result
	elseif arg_4_0._battleType == Data.BattleType.PVP_dark then
		var_4_1 = BattleResultDialog.Type.dark_result
	elseif arg_4_0._baseBattleType == Data.BattleType.base_guidance then
		var_4_0._resultType = Data.BattleResult.win
		var_4_1 = BattleResultDialog.Type.guide_result
	elseif arg_4_0._battleType == Data.BattleType.boss then
		var_4_1 = BattleResultDialog.Type.boss_result
	elseif arg_4_0._battleType == Data.BattleType.world_boss then
		var_4_1 = BattleResultDialog.Type.world_boss_result
	end

	if arg_4_0._battleType == (Data.BattleType.PVP_room and arg_4_0._isObserver) or arg_4_0._battleType == Data.BattleType.recommend_train then
		var_4_0 = {
			_resultType = arg_4_0._player._resultType,
			_player = arg_4_0._player,
			_opponent = arg_4_0._opponent,
			_battleType = arg_4_0._battleType
		}
	elseif arg_4_0._battleType == Data.BattleType.PVP_dark then
		var_4_0._battleType = Data.BattleType.PVP_dark
		var_4_0._winScore = P._playerFindDark._winScore
		var_4_0._loseScore = P._playerFindDark._loseScore

		if var_4_1 == BattleResultDialog.Type.replay_result then
			var_4_0._hideButton = true
		end
	elseif arg_4_0._baseBattleType == Data.BattleType.base_PVP or arg_4_0._baseBattleType == Data.BattleType.base_PVE then
		if var_4_0._resultType == Data.BattleResult.lose and var_4_0._trophy ~= nil and var_4_0._trophy > 0 then
			var_4_0._trophy = -var_4_0._trophy
		end

		if arg_4_0._needTask then
			var_4_0._isTask = true
			var_4_0._tasks = arg_4_0._player._battleCondition:getConditionDesc()
			var_4_0._taskResults = var_4_0._taskResult
		elseif arg_4_0._battleType == Data.BattleType.PVP_revenge then
			var_4_0._isOccupyCity = true
			var_4_0._levelId = arg_4_0._input._levelId
		elseif var_4_0._curRank ~= nil and var_4_0._curRank ~= 0 then
			var_4_0._isRank = true
			var_4_0._rank = (var_4_0._preRank or 0) - (var_4_0._curRank or 0)
			var_4_0._curRank = var_4_0._curRank or 0
		end
	elseif arg_4_0._baseBattleType == Data.BattleType.base_replay then
		if arg_4_0._input._replayingLog then
			local var_4_2 = arg_4_0._input._replayingLog

			if var_4_2._player ~= nil then
				var_4_0 = {
					_resultType = var_4_2._resultType,
					_isAttacker = var_4_2._isAttack,
					_city = var_4_2._city,
					_trophy = var_4_2._trophy,
					_oppoTrophy = var_4_2._oppoTrophy,
					_gold = var_4_2._gold,
					_log = var_4_2,
					_player = var_4_2._player,
					_opponent = var_4_2._opponent,
					_battleType = var_4_2._battleType == 17 and Data.BattleType.PVP_ladder or nil
				}
			elseif var_4_2._attacker ~= nil then
				var_4_0 = {
					_isAttacker = true,
					_resultType = var_4_2._resultType,
					_log = var_4_2,
					_player = var_4_2._attacker,
					_opponent = var_4_2._defender
				}
			else
				var_4_0 = {}
			end
		else
			var_4_0 = {
				_resultType = Data.BattleResult.win
			}
		end
	elseif arg_4_0._baseBattleType == Data.BattleType.base_test then
		var_4_0 = {
			_preExp = 0,
			_gold = 600,
			_curExp = 50,
			_curLevel = 4,
			_preLevel = 4,
			_exp = 100,
			_trophy = 1,
			_resultType = arg_4_0._player:getResult(),
			_score = arg_4_0._player._damageScore[PlayerBattle.KEY_TOTAL],
			_cards = {
				{
					_infoId = 11001,
					_count = 1
				},
				{
					_infoId = 11001,
					_count = 2
				}
			}
		}

		if false then
			var_4_0._isTask = true
			var_4_0._tasks = arg_4_0._player._battleCondition:getConditionDesc()
			var_4_0._taskResults = arg_4_0._player._battleCondition:getTaskResult()
		elseif false then
			var_4_0._isOccupyCity = true
			var_4_0._levelId = arg_4_0._input._levelId
		else
			var_4_0._isRank = true
			var_4_0._rank = 10
			var_4_0._curRank = 98760
		end
	elseif arg_4_0._battleType == Data.BattleType.teach then
		var_4_0 = {
			_exp = 0,
			_resultType = arg_4_0._player:getResult()
		}
		var_4_0._isTask = true
		var_4_0._tasks = arg_4_0._player._battleCondition:getConditionDesc()
		var_4_0._taskResults = arg_4_0._player._battleCondition:getTaskResult()

		local var_4_3 = arg_4_0._input._teachingId
		local var_4_4 = Data._teachInfo[var_4_3]
		local var_4_5 = P._playerBonus._bonusTeach[var_4_4._bonusId]

		if var_4_5 ~= nil and var_4_0._resultType == Data.BattleResult.win and var_4_0._taskResults[1] == true then
			var_4_5._value = var_4_5._info._val

			ClientData.sendTeachingFinish(var_4_3)
		end
	end

	local var_4_6 = BattleResultDialog.create(arg_4_0, var_4_1, var_4_0)

	arg_4_0._layer:addChild(var_4_6, BattleScene.ZOrder.form)

	arg_4_0._resultDialog = var_4_6
end

function var_0_0.hideResult(arg_5_0)
	if arg_5_0._resultDialog ~= nil then
		arg_5_0._resultDialog:hide()

		arg_5_0._resultDialog = nil
	end
end

function var_0_0.showThinking(arg_6_0)
	if arg_6_0._opponentUi._player._isNewRound then
		return
	end

	local var_6_0 = BattlePVPDialog.create(arg_6_0, BattlePVPDialog.Type.thinking)

	arg_6_0._layer:addChild(var_6_0, BattleScene.ZOrder.dialog)

	arg_6_0._thinkingLayer = var_6_0
end

function var_0_0.hideThinking(arg_7_0)
	if arg_7_0._thinkingLayer ~= nil then
		arg_7_0._thinkingLayer:hide()

		arg_7_0._thinkingLayer = nil
	end
end

function var_0_0.reverseThinking(arg_8_0)
	if arg_8_0._thinkingLayer ~= nil then
		arg_8_0._thinkingLayer:reverse()
	end
end

function var_0_0.showWaiting(arg_9_0)
	local var_9_0 = ClientView.getActiveIndicator()

	arg_9_0._layer:addChild(var_9_0, BattleScene.ZOrder.dialog)
	var_9_0:show(Str(STR.WAITING))
end

function var_0_0.hideWaitting(arg_10_0)
	ClientView.getActiveIndicator():hide()
end

function var_0_0.showSetting(arg_11_0)
	local var_11_0 = BattleSettingDialog.create(arg_11_0)

	arg_11_0._layer:addChild(var_11_0, BattleScene.ZOrder.form)

	arg_11_0._settingLayer = var_11_0
end

function var_0_0.hideSetting(arg_12_0)
	if arg_12_0._settingLayer ~= nil then
		arg_12_0._settingLayer:hide()

		arg_12_0._settingLayer = nil
	end
end

function var_0_0.showTask(arg_13_0)
	local var_13_0 = BattleTaskDialog.create(arg_13_0)

	arg_13_0._layer:addChild(var_13_0, BattleScene.ZOrder.form)

	arg_13_0._taskLayer = var_13_0
end

function var_0_0.hideTask(arg_14_0)
	if arg_14_0._taskLayer ~= nil then
		arg_14_0._taskLayer:hide()

		arg_14_0._taskLayer = nil

		if P._guideID < 100 then
			arg_14_0._player:getActionPlayer():step()
		elseif arg_14_0._isWaitToStart then
			arg_14_0._isWaitToStart = false

			local var_14_0 = ccui.Layout:create()

			var_14_0:setContentSize(ClientView.SCR_SIZE)
			var_14_0:setTouchEnabled(true)
			var_14_0:setAnchorPoint(0, 0)
			var_14_0:setPosition(0, 0)
			arg_14_0._layer:addChild(var_14_0, BattleScene.ZOrder.form)

			local var_14_1 = cc.Director:getInstance():getScheduler():getTimeScale()

			arg_14_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6 * var_14_1), cc.CallFunc:create(function()
				if arg_14_0._battleType == Data.BattleType.task then
					arg_14_0:startBattle()
				end

				var_14_0:removeFromParent()
			end)))
		elseif arg_14_0._isWaitToShowResult then
			arg_14_0._isWaitToShowResult = false

			local var_14_2 = cc.Director:getInstance():getScheduler():getTimeScale()

			arg_14_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6 * var_14_2), cc.CallFunc:create(function()
				arg_14_0:showResult()
			end)))
		end
	end
end

function var_0_0.createBattleTitle(arg_17_0, arg_17_1)
	local var_17_0 = lc.createSprite("bat_story_title_bg")
	local var_17_1 = Particle.create("par_story_title")

	var_17_1:setPositionType(cc.POSITION_TYPE_GROUPED)
	lc.addChildToCenter(var_17_0, var_17_1, -1)

	local var_17_2 = ClientView.createTTF(arg_17_1, ClientView.FontSize.S1, lc.Color3B.yellow)

	lc.addChildToPos(var_17_0, var_17_2, cc.p(lc.w(var_17_0) / 2, 30))

	return var_17_0
end

function var_0_0.enterFilmMode(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._filmTopLayer or arg_18_0._filmBottomLayer then
		return
	end

	local var_18_0 = lc.w(arg_18_0)
	local var_18_1 = 90
	local var_18_2 = 1
	local var_18_3 = lc.createImageView({
		_name = "bat_story_bg",
		_crect = cc.rect(0, 0, 2, var_18_1),
		_size = cc.size(var_18_0, var_18_1)
	})

	var_18_3:setAnchorPoint(0, 0)
	lc.addChildToPos(arg_18_0._layer, var_18_3, cc.p(0, lc.h(arg_18_0)), BattleScene.ZOrder.story)
	var_18_3:runAction(lc.moveTo(var_18_2, 0, lc.h(arg_18_0) - lc.h(var_18_3) + 26))

	arg_18_0._filmTopLayer = var_18_3

	local var_18_4 = arg_18_0:createBattleTitle(arg_18_1)

	lc.addChildToPos(var_18_3, var_18_4, cc.p(24 + lc.w(var_18_4) / 2, lc.h(var_18_3) - 50 - lc.h(var_18_4) / 2))

	if arg_18_2 ~= var_0_0.FilmBottomMode.na then
		local var_18_5 = lc.createImageView({
			_name = "bat_story_bg",
			_crect = cc.rect(0, 0, 2, var_18_1),
			_size = cc.size(var_18_0, arg_18_2 == var_0_0.FilmBottomMode.wide and var_18_1 or var_18_1 / 2)
		})

		var_18_5:setFlippedY(true)

		local var_18_6 = lc.createNode(var_18_5:getContentSize())

		var_18_6:setAnchorPoint(0, 0)
		lc.addChildToCenter(var_18_6, var_18_5)
		lc.addChildToPos(arg_18_0._layer, var_18_6, cc.p(0, -lc.h(var_18_6)), BattleScene.ZOrder.story)
		var_18_6:runAction(lc.moveTo(var_18_2, 0, 0))

		arg_18_0._filmBottomLayer = var_18_6
	end

	arg_18_0._atkPile:getParent():runAction(lc.moveBy(var_18_2, 300, 0))
	arg_18_0._defPile:getParent():runAction(lc.moveBy(var_18_2, 300, 0))
	arg_18_0._pRoundLabel:getParent():runAction(lc.moveBy(var_18_2, 40, 0))

	local function var_18_7(arg_19_0)
		arg_19_0:setTouchEnabled(false)
		arg_19_0:runAction(lc.moveBy(var_18_2, -200, 0))
	end

	var_18_7(arg_18_0._btnSetting)
	var_18_7(arg_18_0._btnAuto)
	var_18_7(arg_18_0._btnSpeed)
end

function var_0_0.leaveFilmMode(arg_20_0)
	local var_20_0 = arg_20_0._filmTopLayer
	local var_20_1 = arg_20_0._filmBottomLayer
	local var_20_2 = arg_20_0._filmBottomLayer == nil and 1 or 0.2

	if var_20_0 then
		arg_20_0._filmTopLayer = nil

		var_20_0:runAction(lc.sequence(lc.moveTo(var_20_2, 0, lc.h(arg_20_0) + lc.h(var_20_0)), lc.remove()))
		arg_20_0._atkPile:getParent():runAction(lc.moveBy(var_20_2, -300, 0))
		arg_20_0._defPile:getParent():runAction(lc.moveBy(var_20_2, -300, 0))
		arg_20_0._pRoundLabel:getParent():runAction(lc.moveBy(var_20_2, -40, 0))

		local function var_20_3(arg_21_0)
			arg_21_0:runAction(lc.sequence(lc.moveBy(var_20_2, 200, 0), function()
				arg_21_0:setTouchEnabled(true)
			end))
		end

		var_20_3(arg_20_0._btnSetting)
		var_20_3(arg_20_0._btnAuto)
		var_20_3(arg_20_0._btnSpeed)
	end

	if var_20_1 then
		arg_20_0._filmBottomLayer = nil

		var_20_1:runAction(lc.sequence(lc.moveTo(var_20_2, 0, -lc.h(var_20_1)), lc.remove()))
	end
end

function var_0_0.enterStoryMode(arg_23_0, arg_23_1)
	arg_23_0:enterFilmMode(arg_23_0._storyName, arg_23_1)

	if arg_23_0._baseBattleType ~= Data.BattleType.base_guidance then
		local var_23_0 = lc.w(arg_23_0)
		local var_23_1 = 90
		local var_23_2 = ClientView.createShaderButton(nil, function()
			arg_23_0:skipAllStory()
		end)
		local var_23_3 = ClientView.createTTF(Str(STR.SKIP_STORY), ClientView.FontSize.S1)

		var_23_2:setContentSize(lc.w(var_23_3) + 40, lc.h(var_23_3) + 40)
		lc.addChildToCenter(var_23_2, var_23_3)
		lc.addChildToPos(arg_23_0._filmBottomLayer, var_23_2, cc.p(var_23_0 / 2, var_23_1 / 2 - 10))
	end
end

function var_0_0.showEvent(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = BattleEventDialog.create(arg_25_0, arg_25_1, arg_25_2, arg_25_3)

	arg_25_0._layer:addChild(var_25_0, BattleScene.ZOrder.dialog)

	arg_25_0._eventLayer = var_25_0

	if arg_25_0._cardInfoLayer then
		arg_25_0:hideCardInfo()
	end
end

function var_0_0.hideEvent(arg_26_0)
	if arg_26_0._eventLayer then
		arg_26_0._eventLayer:hide()

		arg_26_0._eventLayer = nil

		arg_26_0:hideTip()

		if arg_26_0._baseBattleType == Data.BattleType.base_guidance then
			arg_26_0:setGuideHelpButtonVisible(false)
		end

		GuideManager.releaseFinger()

		return arg_26_0._player:getActionPlayer():step()
	end
end

function var_0_0.showCardInfo(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1:getCardStatusStrs()
	local var_27_1 = require("CardInfoPanel")
	local var_27_2

	if not arg_27_1._ownerUi._isController and arg_27_2:hasBuff(true, BattleData.PositiveType.mask2) then
		var_27_2 = var_27_1.create(Data._skillInfo[3341]._refCards[1], 1, var_27_1.OperateType.na, nil, nil)
	elseif not arg_27_1._ownerUi._isController and arg_27_2:hasBuff(true, BattleData.PositiveType.mask) then
		var_27_2 = var_27_1.create(Data._skillInfo[9487]._refCards[1], 1, var_27_1.OperateType.na, nil, nil)
	else
		var_27_2 = var_27_1.create(arg_27_2._infoId, 1, var_27_1.OperateType.na, arg_27_2, var_27_0)
	end

	var_27_2:show()
end

function var_0_0.hideCardInfo(arg_28_0)
	if arg_28_0._cardInfoLayer then
		arg_28_0._cardInfoLayer:hide()

		arg_28_0._cardInfoLayer = nil

		if arg_28_0._eventLayer then
			arg_28_0._eventLayer._ignoreTouch = nil
		end
	end
end

function var_0_0.showTip(arg_29_0, arg_29_1)
	arg_29_0:hideTip()

	if arg_29_1.t.story == 0 then
		return
	end

	arg_29_0:setGuideHelpButtonVisible(false)

	arg_29_0._guideTipVals = arg_29_1

	local var_29_0 = Str(Data._storyInfo[arg_29_1.t.story]._nameSid)
	local var_29_1
	local var_29_2

	if var_29_0[1] == "/" then
		var_29_2 = string.sub(var_29_0, 2)
	else
		local var_29_3 = string.splitByChar(var_29_0, "/")

		var_29_1, var_29_2 = var_29_3[1], var_29_3[2]
	end

	if arg_29_1.t.guide ~= 0 and arg_29_0._btnGuideHelp then
		arg_29_0._btnGuideHelp._text = var_29_1
	end

	local var_29_4 = arg_29_0._guideHelp

	if var_29_4 then
		if var_29_4._text then
			var_29_4._text:removeFromParent()

			var_29_4._text = nil
		end

		if var_29_2 then
			local var_29_5 = ClientView.createBoldRichText(var_29_2, {
				_normalClr = ClientView.COLOR_TEXT_LIGHT,
				_boldClr = ClientView.COLOR_TEXT_GREEN_DARK,
				_fontSize = ClientView.FontSize.M1
			})
			local var_29_6 = lc.w(var_29_5) + 40

			var_29_4:setContentSize(var_29_6, 60)
			var_29_4:setPositionX(lc.cw(var_29_4) + 10 + ClientView.SCR_EDGE)

			var_29_4._text = var_29_5

			lc.addChildToPos(var_29_4, var_29_5, cc.p(var_29_6 / 2, 30))
		end
	elseif var_29_2 and arg_29_0:isGuideWorldBattle() then
		local var_29_7 = lc.createImageView({
			_name = "img_com_bg_11",
			_crect = ClientView.CRECT_COM_BG11,
			_size = cc.size(290, 120)
		})

		lc.addChildToPos(arg_29_0, var_29_7, cc.p(lc.w(arg_29_0) / 2 + 350, 180))

		arg_29_0._freeTip = var_29_7

		local var_29_8 = ClientView.createBoldRichText(var_29_2, {
			_width = 210,
			_normalClr = ClientView.COLOR_TEXT_DARK,
			_boldClr = ClientView.COLOR_TEXT_GREEN_DARK,
			_fontSize = ClientView.FontSize.S1
		})

		lc.addChildToPos(var_29_7, var_29_8, cc.p(lc.w(var_29_7) / 2, lc.h(var_29_7) / 2 + 2))
	end

	if var_29_1 then
		local var_29_9 = arg_29_1.t.touch == 1
		local var_29_10 = GuideManager.createNpcTipLayer(Data._storyInfo[arg_29_1.t.story], var_29_9, arg_29_1.t.left == 1, true, arg_29_1.t.width)

		if var_29_9 then
			if arg_29_0._eventLayer then
				arg_29_0._eventLayer._blockTouch = nil
			end

			function var_29_10._closeHandler()
				if arg_29_0._eventLayer and arg_29_0._eventLayer._delayFinger then
					arg_29_0._eventLayer:showFinger()
				end

				arg_29_0:setGuideHelpButtonVisible(true)
				arg_29_0._player:getActionPlayer():step()
			end
		else
			function var_29_10._canCloseHandler()
				if arg_29_0._eventLayer and arg_29_0._eventLayer._delayFinger then
					arg_29_0._eventLayer:showFinger()
				end
			end
		end

		local var_29_11 = arg_29_1.t.hl_type
		local var_29_12

		if var_29_11 then
			local var_29_13

			if var_29_11 == GuideManager.HighlightType.battle_setting_btn then
				var_29_13 = arg_29_0._btnSetting
			end

			var_29_12 = GuideManager.addHighlightEffect(var_29_11, var_29_13)
		end

		local var_29_14 = GuideManager.addContainerLayer(var_29_10, BattleScene.ZOrder.dialog, var_29_12)

		var_29_14:setPosition((ClientView.SCR_W - lc.w(var_29_14)) / 2, 0)

		if arg_29_0:getChildByTag(var_0_0.Tag.help_dialog) or arg_29_0:getChildByTag(var_0_0.Tag.retreat_dialog) then
			var_29_14:setVisible(false)
		end
	else
		if arg_29_0._eventLayer and arg_29_0._eventLayer._delayFinger then
			arg_29_0._eventLayer:showFinger()
		end

		arg_29_0:setGuideHelpButtonVisible(true)
	end
end

function var_0_0.hideTip(arg_32_0)
	if GuideManager._tipLayer then
		GuideManager.closeNpcTipLayer()
		arg_32_0:setGuideHelpButtonVisible(true)
	end

	if arg_32_0._freeTip then
		arg_32_0._freeTip:removeFromParent()

		arg_32_0._freeTip = nil
	end
end

function var_0_0.setGuideHelpButtonVisible(arg_33_0, arg_33_1)
	if arg_33_0._btnGuideHelp then
		arg_33_0._btnGuideHelp:setVisible(arg_33_1 and arg_33_0._btnGuideHelp._text ~= nil)
		arg_33_0._guideHelp:setVisible(arg_33_1 and arg_33_0._guideHelp._text ~= nil)

		if arg_33_1 and arg_33_0._guideTipVals then
			local var_33_0 = AUDIO[string.format("E_STORY_%d_1", arg_33_0._guideTipVals.t.story)]

			if var_33_0 then
				lc.Audio.playAudio(var_33_0)
			end
		end
	end
end

function var_0_0.getEventDrag(arg_34_0)
	if arg_34_0._eventLayer ~= nil and arg_34_0._eventLayer._val ~= nil then
		local var_34_0 = arg_34_0._eventLayer._type

		if var_34_0 == BattleEventDialog.Type.guide_drag_to_card or var_34_0 == BattleEventDialog.Type.guide_drag_to_pos or var_34_0 == BattleEventDialog.Type.guide_drag_to_attack or var_34_0 == BattleEventDialog.Type.guide_drag_to_defend or var_34_0 == BattleEventDialog.Type.guide_drag then
			return arg_34_0._eventLayer._val[1]
		end
	end

	return nil
end

function var_0_0.getEventDragTo(arg_35_0)
	if arg_35_0._eventLayer ~= nil and arg_35_0._eventLayer._val ~= nil then
		local var_35_0 = arg_35_0._eventLayer._type

		if var_35_0 == BattleEventDialog.Type.guide_drag_to_card or var_35_0 == BattleEventDialog.Type.guide_drag_to_pos or var_35_0 == BattleEventDialog.Type.guide_drag_to_attack then
			return arg_35_0._eventLayer._val[2], var_35_0
		elseif var_35_0 == BattleEventDialog.Type.guide_drag_to_defend then
			return nil, var_35_0
		end
	end

	return nil, nil
end

function var_0_0.showDialog(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = BattleDialog.create(arg_36_0, arg_36_1, arg_36_2)

	arg_36_0._layer:addChild(var_36_0, BattleScene.ZOrder.dialog)

	return var_36_0
end

function var_0_0.showRetreat(arg_37_0)
	local var_37_0

	if arg_37_0._retreatReturn then
		var_37_0 = require("Dialog").showDialog(Str(STR.BATTLE_DIALOG_RETRY))
	else
		var_37_0 = require("Dialog").showDialog(Str(STR.BATTLE_DIALOG_RETREAT))
	end

	function var_37_0._okHandler()
		if arg_37_0._battleType == Data.BattleType.teach then
			arg_37_0:exitScene()
		elseif arg_37_0._baseBattleType ~= Data.BattleType.base_PVP then
			arg_37_0:resume()
		end

		arg_37_0:retreat(arg_37_0._player)
	end

	if arg_37_0._baseBattleType ~= Data.BattleType.base_PVP then
		function var_37_0._cancelHandler()
			arg_37_0:resume()
		end

		arg_37_0:pause()
	end

	var_37_0:setTag(var_0_0.Tag.retreat_dialog)
	var_37_0:setLocalZOrder(BattleScene.ZOrder.form)
end

function var_0_0.showShare(arg_40_0, arg_40_1)
	require("ShareForm").create(arg_40_1):show()
end

function var_0_0.showChat(arg_41_0, arg_41_1)
	if arg_41_0._chatCDScheduler then
		ToastManager.push(Str(STR.BATTLE_CHAT_CD))

		return
	end

	local var_41_0 = BattleChatDialog.create(arg_41_0, arg_41_1)

	arg_41_0._layer:addChild(var_41_0, BattleScene.ZOrder.form)
end

function var_0_0.showOppoOnline(arg_42_0)
	ToastManager.push(Str(STR.OPPONENT_ONLINE))
end

function var_0_0.showOppoOffline(arg_43_0)
	ToastManager.push(Str(STR.OPPONENT_OFFLINE))
end

function var_0_0.showOppoOnline(arg_44_0)
	ToastManager.push(Str(STR.PLAYER_ONLINE))
end

function var_0_0.showOppoOffline(arg_45_0)
	ToastManager.push(Str(STR.PLAYER_OFFLINE))
end

function var_0_0.setBattleSpeed(arg_46_0, arg_46_1)
	arg_46_1 = arg_46_1 or arg_46_0._battleSpeed

	local var_46_0

	if arg_46_0._baseBattleType == Data.BattleType.base_replay then
		var_46_0 = arg_46_1 > #var_0_0.BattleSpeed and 3 or var_0_0.BattleSpeed[arg_46_1]
	else
		if arg_46_1 == nil or arg_46_1 < 1 or arg_46_1 > #var_0_0.BattleSpeed then
			arg_46_1 = 1
		end

		var_46_0 = arg_46_0._isTesting and arg_46_1 ~= 1 and var_0_0.BattleSpeed[arg_46_1] * arg_46_0._speedFactor or var_0_0.BattleSpeed[arg_46_1]
	end

	arg_46_0._battleSpeed = arg_46_1

	arg_46_0._btnSpeed._icon:setString(string.format("x%d", arg_46_1))

	if lc.PLATFORM == cc.PLATFORM_OS_WINDOWS then
		arg_46_0:runAction(lc.sequence(0, function()
			ToastManager.push("Speed: " .. var_46_0)
		end))
	end

	cc.Director:getInstance():getScheduler():setTimeScale(var_46_0)
end

function var_0_0.updatePile(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_1._player
	local var_48_1 = arg_48_1._pile._label
	local var_48_2 = #var_48_0._pileCards

	if var_48_1:getString() == tostring(var_48_2) then
		return
	end

	if var_48_0._handCardsToAdd ~= nil then
		var_48_2 = var_48_2 + #var_48_0._handCardsToAdd
	end

	var_48_1:setString(var_48_2)
	var_48_1:stopAllActions()
	var_48_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.5), cc.ScaleTo:create(0.2, 1)))
end

function var_0_0.updateRound(arg_49_0)
	local var_49_0 = math.max(1, math.max(arg_49_0._player._round, arg_49_0._opponent._round))

	arg_49_0._pRoundLabel:setString(var_49_0)
end

function var_0_0.updateRoundButton(arg_50_0)
	local var_50_0 = false

	if arg_50_0._pRoundTitle then
		arg_50_0._pRoundTitle:setVisible(false)
	end

	if arg_50_0._dropLayer then
		arg_50_0._btnEndRound:setTouchEnabled(false)
	elseif arg_50_0._player._macroStatus == BattleData.Status.round_begin then
		arg_50_0._btnEndRound:setTouchEnabled(false)
		arg_50_0._btnEndRound:loadTextureNormal("bat_btn_6", ccui.TextureResType.plistType)
		arg_50_0._pRoundTitle:setSpriteFrame("bat_label_atk")
		if arg_50_0._pRoundText then arg_50_0._pRoundText:setString("TẤN CÔNG") end
	elseif arg_50_0._opponent._macroStatus == BattleData.Status.round_begin then
		arg_50_0._btnEndRound:setTouchEnabled(false)
		arg_50_0._btnEndRound:loadTextureNormal("bat_btn_6", ccui.TextureResType.plistType)
		arg_50_0._pRoundTitle:setSpriteFrame("bat_label_def")
		if arg_50_0._pRoundText then arg_50_0._pRoundText:setString("PHÒNG THỦ") end
	elseif arg_50_0._player == arg_50_0._player:getActionPlayer() then
		if arg_50_0._isOperating then
			if arg_50_0._isAddingBoardCard then
				arg_50_0._btnEndRound:setTouchEnabled(false)
				arg_50_0._btnEndRound:loadTextureNormal("bat_btn_6", ccui.TextureResType.plistType)
				arg_50_0._pRoundTitle:setSpriteFrame("bat_label_atk")
			if arg_50_0._pRoundText then arg_50_0._pRoundText:setString("TẤN CÔNG") end
			elseif not arg_50_0._playerUi:getIsMoreOperation() then
				arg_50_0._btnEndRound:setTouchEnabled(true)
				arg_50_0._btnEndRound:loadTextureNormal("bat_btn_5", ccui.TextureResType.plistType)
				arg_50_0._pRoundTitle:setSpriteFrame("bat_label_end_2")
				if arg_50_0._pRoundText then arg_50_0._pRoundText:setString("KẾT THÚC") end

				local var_50_1 = true

				if arg_50_0:isGuideWorldBattle() then
					arg_50_0:addSoftGuide(0)
				end
			else
				arg_50_0._btnEndRound:setTouchEnabled(true)
				arg_50_0._btnEndRound:loadTextureNormal("bat_btn_4", ccui.TextureResType.plistType)
				arg_50_0._pRoundTitle:setSpriteFrame("bat_label_end")
				if arg_50_0._pRoundText then arg_50_0._pRoundText:setString("KẾT THÚC") end
			end
		else
			arg_50_0._btnEndRound:setTouchEnabled(false)
			arg_50_0._btnEndRound:loadTextureNormal("bat_btn_6", ccui.TextureResType.plistType)
			arg_50_0._pRoundTitle:setSpriteFrame("bat_label_atk")
			if arg_50_0._pRoundText then arg_50_0._pRoundText:setString("TẤN CÔNG") end
		end
	else
		arg_50_0._btnEndRound:setTouchEnabled(false)
		arg_50_0._btnEndRound:loadTextureNormal("bat_btn_6", ccui.TextureResType.plistType)
		arg_50_0._pRoundTitle:setSpriteFrame("bat_label_atk")
		if arg_50_0._pRoundText then arg_50_0._pRoundText:setString("TẤN CÔNG") end
	end
end

function var_0_0.shakeScreen(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = arg_51_2._isAttacker == arg_51_0._isAttacker
	local var_51_1 = var_51_0 and 1 or -1
	local var_51_2

	if arg_51_1 == var_0_0.ShakeScreenType.fortress_hurt then
		local var_51_3 = 0.1
		local var_51_4 = 12

		var_51_2 = cc.Sequence:create(cc.EaseInOut:create(cc.MoveBy:create(var_51_3, cc.p(0, var_51_4)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_3, cc.p(-var_51_4, 0)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_3, cc.p(0, -var_51_4)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_3, cc.p(var_51_4, 0)), 2.5))
	elseif arg_51_1 == var_0_0.ShakeScreenType.fortress_die then
		local var_51_5 = 0.05
		local var_51_6 = 12

		var_51_2 = cc.Repeat:create(cc.Sequence:create(cc.EaseInOut:create(cc.MoveBy:create(var_51_5, cc.p(0, var_51_6)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_5, cc.p(-var_51_6, 0)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_5, cc.p(0, -var_51_6)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_5, cc.p(var_51_6, 0)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_5, cc.p(0, -var_51_6)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_5, cc.p(-var_51_6, 0)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_5, cc.p(0, var_51_6)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_5, cc.p(var_51_6, 0)), 2.5)), 2)
	elseif arg_51_1 == var_0_0.ShakeScreenType.retreat then
		local var_51_7 = 0.05
		local var_51_8 = 10 * var_51_1

		var_51_2 = cc.Sequence:create(cc.EaseInOut:create(cc.MoveBy:create(var_51_7, cc.p(0, var_51_8)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_7, cc.p(-var_51_8, 0)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_7, cc.p(0, -var_51_8)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(var_51_7, cc.p(var_51_8, 0)), 2.5))
	elseif arg_51_1 == var_0_0.ShakeScreenType.to_board then
		local var_51_9 = arg_51_3._startPos
		local var_51_10 = arg_51_3._endPos
		local var_51_11, var_51_12 = arg_51_2:calLengthAndAngle(var_51_9, var_51_10)
		local var_51_13 = cc.p(math.cos(math.rad(var_51_12)) * 8, math.sin(math.rad(var_51_12)) * 8)

		var_51_2 = cc.Sequence:create(cc.EaseInOut:create(cc.Spawn:create(cc.ScaleTo:create(0.08, 0.975 * arg_51_0._scale), cc.MoveBy:create(0.08, cc.p(var_51_13.x, var_51_13.y))), 2.5), cc.EaseInOut:create(cc.Spawn:create(cc.ScaleTo:create(0.1, 1.01 * arg_51_0._scale), cc.MoveBy:create(0.1, cc.p(-var_51_13.x * 1.05, -var_51_13.y * 1.05))), 2.5), cc.EaseInOut:create(cc.Spawn:create(cc.ScaleTo:create(0.1, 1 * arg_51_0._scale), cc.MoveBy:create(0.1, cc.p(var_51_13.x * 0.05, -var_51_13.y * 0.05))), 2.5))
	elseif arg_51_1 == var_0_0.ShakeScreenType.equip_book then
		if var_51_0 then
			var_51_2 = cc.Sequence:create(cc.EaseInOut:create(cc.MoveBy:create(0.06, cc.p(4, 8)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(0.08, cc.p(-4, -8)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(0.1, cc.p(5, 5)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(0.1, cc.p(-5, -5)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(0.1, cc.p(2, 3)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(0.1, cc.p(-2, -3)), 2.5))
		else
			var_51_2 = cc.Sequence:create(cc.EaseInOut:create(cc.MoveBy:create(0.06, cc.p(5, 5)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(0.1, cc.p(-6, -5)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(0.1, cc.p(2, 3)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(0.1, cc.p(-1, -3)), 2.5))
		end
	elseif arg_51_1 == var_0_0.ShakeScreenType.attack_card then
		local var_51_14 = arg_51_3._startPos
		local var_51_15 = arg_51_3._endPos
		local var_51_16, var_51_17 = arg_51_2:calLengthAndAngle(var_51_14, var_51_15)
		local var_51_18 = cc.p(math.cos(math.rad(var_51_17)) * 10, math.sin(math.rad(var_51_17)) * 10)

		var_51_2 = cc.Sequence:create(cc.EaseInOut:create(cc.MoveBy:create(0.08, cc.p(var_51_18.x, var_51_18.y)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(0.1, cc.p(-var_51_18.x * 1.05, -var_51_18.y * 1.05)), 2.5), cc.EaseInOut:create(cc.MoveBy:create(0.1, cc.p(var_51_18.x * 0.05, var_51_18.y * 0.05)), 2.5))
	end

	arg_51_0:resetAction()
	arg_51_0:runAction(var_51_2)
end

function var_0_0.cameraTo(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = cc.p(0, -180)
	local var_52_1 = cc.p(-var_52_0.x, -var_52_0.y)

	arg_52_0:resetAction()
	arg_52_0:runAction(lc.sequence({
		lc.moveBy(0.15, var_52_0),
		lc.scaleTo(0.15, 1.3 * arg_52_0._scale)
	}, arg_52_2, {
		lc.moveBy(0.15, var_52_1),
		lc.scaleTo(0.15, 1 * arg_52_0._scale)
	}))

	local var_52_2 = arg_52_0._mask

	var_52_2:resetAction()
	var_52_2:setVisible(true)
	var_52_2:runAction(lc.sequence(0.15 + arg_52_2, lc.fadeOut(0.15), lc.hide()))
end

function var_0_0.showDropHand(arg_53_0)
	local var_53_0 = arg_53_0._player:getActionPlayer()
	local var_53_1 = var_53_0 == arg_53_0._player and arg_53_0._playerUi or arg_53_0._opponentUi
	local var_53_2 = lc.createMaskLayer(200, lc.Color3B.black, cc.size(ClientView.SCR_W, ClientView.SCR_H + 100))

	var_53_2:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(arg_53_0, var_53_2, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - arg_53_0._offsetY), var_0_0.ZOrder.card_hand)
	var_53_2:setRotation3D({
		z = 0,
		y = 0,
		x = ClientView.BATTLE_ROTATION_X
	})
	var_53_2:setScale(1 / arg_53_0:getScale())

	arg_53_0._dropLayer = var_53_2

	local var_53_3 = string.format(lc.str(STR.DISCARD_HAND_TIP_1), #var_53_0._handCards - Data.MAX_CARD_COUNT_IN_HAND_AFTER_DROP)
	local var_53_4 = ClientView.createTTF(var_53_3, ClientView.FontSize.M1, ClientView.COLOR_LABEL_LIGHT)

	lc.addChildToPos(var_53_2, var_53_4, cc.p(ClientView.SCR_CW, 300))

	local var_53_5 = ClientView.createTTF(lc.str(STR.DISCARD_HAND_TIP_2), ClientView.FontSize.M2, ClientView.COLOR_LABEL_LIGHT)

	lc.addChildToPos(var_53_2, var_53_5, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 140))
	arg_53_0._scene:seenByCamera3D(var_53_2)
	arg_53_0._btnSetting:setTouchEnabled(false)
	arg_53_0._btnReplay:setTouchEnabled(false)
	arg_53_0._btnAuto:setTouchEnabled(false)
	arg_53_0._btnSpeed:setTouchEnabled(false)
	arg_53_0:updateRoundButton()
	var_53_1:updateBoardCardsInitialSkills()

	arg_53_0._isEnableDrap = true

	for iter_53_0 = 1, #var_53_1._pHandCards do
		local var_53_6 = var_53_1._pHandCards[iter_53_0]

		if var_53_6 then
			var_53_6:updateActive(true)
		end
	end

	var_53_2:setTouchEnabled(false)

	function var_53_2.onTouchBegan(arg_54_0, arg_54_1)
		local var_54_0 = arg_53_0:getTouchedCard(arg_54_1)

		if var_54_0 and (not var_54_0._isController or var_54_0._card._status ~= BattleData.CardStatus.hand) then
			var_54_0 = nil
		end

		arg_54_0._touchCard = var_54_0

		if var_54_0 then
			var_54_0:onTouchBegan(arg_54_1)
		end

		return true
	end

	function var_53_2.onTouchMoved(arg_55_0, arg_55_1)
		if arg_55_0._touchCard then
			arg_55_0._touchCard:onTouchMoved(arg_55_1)
		end
	end

	function var_53_2.onTouchEnded(arg_56_0, arg_56_1)
		if not arg_56_0._touchCard then
			if cc.pGetDistance(arg_56_1:getLocation(), arg_56_1:getStartLocation()) <= lc.Gesture.BUDGE_LIMIT then
				arg_53_0._isEnableDrap = false

				arg_53_0:hideDropHand()
			end
		elseif arg_56_0._touchCard then
			arg_56_0._touchCard:onTouchEnded(arg_56_1)

			if not arg_53_0._isAddingBoardCard and arg_56_1:getLocation().y >= PlayerUi.Pos.use_area then
				var_53_1:sendEvent(PlayerUi.EventType.send_use_card, {
					_card = arg_56_0._touchCard._card,
					_choice = BattleData.ChoiceId.drop
				})
				arg_53_0:hideDropHand()
			else
				var_53_1:playAction(arg_56_0._touchCard, PlayerUi.Action.replace_hand_card, 0, 1)
			end
		end
	end

	function var_53_2.onTouchCanceled(arg_57_0)
		arg_53_0:hideDropHand()
	end
end

function var_0_0.hideDropHand(arg_58_0)
	if arg_58_0._dropLayer then
		arg_58_0._dropLayer:removeFromParent()

		arg_58_0._dropLayer = nil

		local var_58_0 = arg_58_0._player:getActionPlayer() == arg_58_0._player and arg_58_0._playerUi or arg_58_0._opponentUi

		var_58_0:updateCardsActive()
		arg_58_0._btnSetting:setTouchEnabled(true)
		arg_58_0._btnReplay:setTouchEnabled(true)
		arg_58_0._btnAuto:setTouchEnabled(true)
		arg_58_0._btnSpeed:setTouchEnabled(true)
		arg_58_0:updateRoundButton()
		var_58_0:updateBoardCardsInitialSkills()
	end
end

function var_0_0.finishDropHand(arg_59_0)
	arg_59_0:onButtonEvent(arg_59_0._btnEndRound)
end
