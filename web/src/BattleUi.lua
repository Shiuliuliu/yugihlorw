local var_0_0 = class("BattleUi", function()
	return ccui.Widget:create()
end)

BattleUi = var_0_0
var_0_0.PVP_ROUND_DURATION = 45
var_0_0.PVP_ROUND_OFFLINE_DURATION = 2
var_0_0.PVP_ROPE_DURATION = 15
var_0_0.PVP_RETREAT_DURATION = 90
var_0_0.BattleSpeed = {
	1.5,
	2.5,
	3.5,
	5
}
var_0_0.ShakeScreenType = {
	to_board = 1,
	equip_book = 2,
	fortress_hurt = 13,
	retreat = 21,
	attack_card = 3,
	fortress_die = 12
}
var_0_0.Tag = {
	remove_when_reset = 2000,
	help_dialog = 1000,
	retreat_dialog = 1001
}
var_0_0.FilmBottomMode = {
	na = 1,
	wide = 2,
	narrow = 3
}
var_0_0.ZOrder = {
	effect = 100,
	card_action = 40,
	action = 1,
	skill_label = 120,
	card_touch = 200,
	label = 110,
	card_hand = 30,
	card_board = 20,
	card = 10,
	ui = 0,
	normal = 0
}
var_0_0.ShowEffect = false

function var_0_0.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.new()

	var_2_0:init(arg_2_0, arg_2_1, arg_2_2)
	var_2_0:registerScriptHandler(function(arg_3_0)
		if arg_3_0 == "enter" then
			var_2_0:onEnter()
		elseif arg_3_0 == "exit" then
			var_2_0:onExit()
		elseif arg_3_0 == "cleanup" then
			var_2_0:onCleanup()
		end
	end)

	return var_2_0
end

function var_0_0.init(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._scene = arg_4_1
	arg_4_0._isReverse = false

	arg_4_0:setContentSize(ClientView.SCR_SIZE)
	arg_4_0:setAnchorPoint(cc.p(0.5, 0.5))

	local var_4_0 = math.min(math.max(16, math.floor(ClientView.SCR_W / 64)), 21)

	arg_4_0._scale = 1 - (21 - var_4_0) * 0.04
	arg_4_0._offsetY = 120 - (21 - var_4_0) * 4

	arg_4_0:setPosition(cc.p(ClientView.SCR_CW, ClientView.SCR_CH + arg_4_0._offsetY))
	arg_4_0:setScale(arg_4_0._scale)
	arg_4_0:setRotation3D({
		z = 0,
		y = 0,
		x = -ClientView.BATTLE_ROTATION_X
	})

	if ClientData._cfg and ClientData._cfg.battleSpeed and ClientData._cfg.battleSpeed > 0 then
		var_0_0.BattleSpeed[1] = ClientData._cfg.battleSpeed
	end

	arg_4_0._audioEngine = BattleAudio.new(arg_4_0)
	arg_4_0._nameTag = arg_4_3

	arg_4_0:initData(arg_4_2)
	arg_4_0:initBackground()
	arg_4_0:initUiControl()

	arg_4_0._playerUi = PlayerUi.new(arg_4_0, arg_4_0._player, arg_4_0._sceneType, arg_4_0._input._player._cardBackId)
	arg_4_0._opponentUi = PlayerUi.new(arg_4_0, arg_4_0._opponent, arg_4_0._sceneType, arg_4_0._input._opponent._cardBackId)
	arg_4_0._playerUi._opponentUi = arg_4_0._opponentUi
	arg_4_0._opponentUi._opponentUi = arg_4_0._playerUi

	arg_4_0._playerUi:resetWhenBattleStart()
	arg_4_0._opponentUi:resetWhenBattleStart()
	arg_4_0._scene:seenByCamera3D(arg_4_0)

	BATTLE_UI_INSTANCE = arg_4_0

	return true
end

function var_0_0.onEnter(arg_5_0)
	if not arg_5_0._playVideo then
		if arg_5_0._isBattleFinished and arg_5_0._battleType ~= Data.BattleType.unittest then
			return
		end

		if arg_5_0._battleType == Data.BattleType.teach then
			require("BattleTestExtend")
		end

		local var_5_0 = cc.EventListenerTouchOneByOne:create()

		var_5_0:setSwallowTouches(true)
		var_5_0:registerScriptHandler(function(arg_6_0, arg_6_1)
			return arg_5_0:onTouchBegan(arg_6_0)
		end, cc.Handler.EVENT_TOUCH_BEGAN)
		var_5_0:registerScriptHandler(function(arg_7_0, arg_7_1)
			return arg_5_0:onTouchMoved(arg_7_0)
		end, cc.Handler.EVENT_TOUCH_MOVED)
		var_5_0:registerScriptHandler(function(arg_8_0, arg_8_1)
			return arg_5_0:onTouchEnded(arg_8_0)
		end, cc.Handler.EVENT_TOUCH_ENDED)
		var_5_0:registerScriptHandler(function(arg_9_0, arg_9_1)
			return arg_5_0:onTouchCanceled()
		end, cc.Handler.EVENT_TOUCH_CANCELLED)
		arg_5_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_5_0, arg_5_0)

		arg_5_0._battleListener = lc.addEventListener(PlayerBattle.EVENT, function(arg_10_0)
			return arg_5_0:onBattleEvent(arg_10_0)
		end)
		arg_5_0._playerUiListener = lc.addEventListener(PlayerUi.EVENT, function(arg_11_0)
			return arg_5_0:onPlayerUiEvent(arg_11_0)
		end)
		arg_5_0._cardSpriteListener = lc.addEventListener(CardSprite.EVENT, function(arg_12_0)
			return arg_5_0:onCardSpriteEvent(arg_12_0)
		end)

		if arg_5_0._battleType == Data.BattleType.PVP_room then
			arg_5_0._roomListener = lc.addEventListener(Data.Event.room_exit_dirty, function(arg_13_0)
				return lc.replaceScene(require("ResSwitchScene").create(arg_5_0._scene._sceneId, ClientData.SceneId.find))
			end)
		end

		arg_5_0:setBattleSpeed()

		if arg_5_0._isOnlinePvp then
			arg_5_0:setOppoOnline(false)
		end

		arg_5_0:runAction(lc.sequence(arg_5_0._battleType == Data.BattleType.unittest and 0 or 1, function()
			arg_5_0:resetWhenBattleStart()

			if arg_5_0._needForward then
				if P._guideID < 100 then
					arg_5_0:forwardToRound(true, 5)
				else
					arg_5_0:forwardToCurRound()
				end
			elseif arg_5_0._needTask then
				arg_5_0._isWaitToStart = true

				if arg_5_0._battleType == Data.BattleType.teach then
					arg_5_0._scene:seenByCamera3D(arg_5_0)

					arg_5_0._player._playerType = BattleData.PlayerType.player

					if Data._teachYgoInfo == nil or #Data._teachYgoInfo == 0 then
						local var_14_0 = lc.App:loadRes("res/teach.lcres")

						for iter_14_0 = 1, #var_14_0 do
							local var_14_1 = var_14_0[iter_14_0]

							if string.hasSuffix(var_14_1, ".bin") then
								local var_14_2 = lc.App:getBinData(var_14_1)

								Data.parseTeach(var_14_1, var_14_2)
								lc.App:unloadRes(var_14_1)
							end
						end
					end

					local var_14_3 = tonumber(arg_5_0._input._teachingId)

					if var_14_3 ~= nil then
						arg_5_0:loadYgoContent(Data._teachYgoInfo[var_14_3])

						ClientData._battleFromTeach = var_14_3
					end
				end

				arg_5_0:showTask()
			elseif arg_5_0._battleType == Data.BattleType.unittest then
				arg_5_0._scene:seenByCamera3D(arg_5_0)

				if ClientData._unitTestFile ~= nil then
					BattleTestData._curOpType = BattleTestData.OperationType._load

					arg_5_0:loadUnitTestFile(ClientData._unitTestFile)
					arg_5_0._testMaskLayer:setVisible(false)

					arg_5_0._player._playerType = BattleData.PlayerType.player
				end

				return
			elseif arg_5_0._needShowInning then
				arg_5_0:runAction(lc.sequence(function()
					arg_5_0._btnSetting:setVisible(false)

					for iter_15_0, iter_15_1 in ipairs(arg_5_0._showButtons) do
						iter_15_1:setVisible(false)
					end

					arg_5_0:showDialog(BattleDialog.Type.inning, P._playerFindDark._inning)
				end, 2.7, function()
					arg_5_0._btnSetting:setVisible(true)

					for iter_16_0, iter_16_1 in ipairs(arg_5_0._showButtons) do
						iter_16_1:setVisible(true)
					end

					arg_5_0:startBattle()
				end))
			else
				arg_5_0:startBattle()
			end

			if P._guideID == 11 and ClientData.isPlayVideo() then
				arg_5_0:playVideo()
			else
				arg_5_0:openVS()
			end
		end))
	else
		arg_5_0._playVideo = false

		arg_5_0:openVS()
		arg_5_0._player:getActionPlayer():step()
	end
end

function var_0_0.onExit(arg_17_0)
	if not arg_17_0._playVideo then
		GuideManager.stopGuide()
		lc.Dispatcher:removeEventListener(arg_17_0._battleListener)
		lc.Dispatcher:removeEventListener(arg_17_0._playerUiListener)
		lc.Dispatcher:removeEventListener(arg_17_0._cardSpriteListener)

		if arg_17_0._roomListener then
			lc.Dispatcher:removeEventListener(arg_17_0._roomListener)
		end

		arg_17_0:getEventDispatcher():removeEventListenersForTarget(arg_17_0)

		if arg_17_0._baseBattleType ~= Data.BattleType.base_PVP and arg_17_0._baseBattleType ~= Data.BattleType.base_guidance and arg_17_0._baseBattleType ~= Data.BattleType.base_replay and lc._configs ~= nil then
			lc.writeConfig(ClientData.ConfigKey.battle_speed, arg_17_0._battleSpeed)
		end

		cc.Director:getInstance():getScheduler():setTimeScale(1)

		if arg_17_0._statusScheduler ~= nil then
			lc.Scheduler:unscheduleScriptEntry(arg_17_0._statusScheduler)
		end

		arg_17_0:removeSoftGuide()

		if arg_17_0._isOnlinePvp then
			arg_17_0:stopPvpTiming()
			arg_17_0:removePvpTimingRope()
		end
	end
end

function var_0_0.onCleanup(arg_18_0)
	if arg_18_0._chatCDScheduler then
		lc.Scheduler:unscheduleScriptEntry(arg_18_0._chatCDScheduler)
	end

	if arg_18_0._playerUi ~= nil then
		arg_18_0._playerUi:resetCardSprites()
	end

	if arg_18_0._opponentUi ~= nil then
		arg_18_0._opponentUi:resetCardSprites()
	end

	arg_18_0:preloadEffects()
end

function var_0_0.onMsg(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.type
	local var_19_1 = arg_19_1.status

	if var_19_0 == SglMsgType_pb.PB_TYPE_BATTLE_OP_USECARD then
		arg_19_0:oppoTryUseCard()

		return true
	elseif var_19_0 == SglMsgType_pb.PB_TYPE_BATTLE_USECARD then
		arg_19_0:observeTryUseCard()

		return true
	elseif var_19_0 == SglMsgType_pb.PB_TYPE_BATTLE_OP_ONLINE then
		ClientData.addBattleDebugLog("ONLINE")
		arg_19_0:setOppoOnline(true)

		return true
	elseif var_19_0 == SglMsgType_pb.PB_TYPE_BATTLE_OP_OFFLINE then
		ClientData.addBattleDebugLog("OFFLINE")
		arg_19_0:setOppoOnline(true)

		return true
	elseif var_19_0 == SglMsgType_pb.PB_TYPE_BATTLE_ONLINE then
		ClientData.addBattleDebugLog("PLAYER ONLINE")
		arg_19_0:setPlayerOnline(true)

		return true
	elseif var_19_0 == SglMsgType_pb.PB_TYPE_BATTLE_OFFLINE then
		ClientData.addBattleDebugLog("PLAYER OFFLINE")
		arg_19_0:setPlayerOffline(true)

		return true
	elseif var_19_0 == SglMsgType_pb.PB_TYPE_BATTLE_CHAT then
		local var_19_2 = arg_19_1.Extensions[Battle_pb.SglBattleMsg.battle_chat_resp]

		arg_19_0:addChat(arg_19_0._player, var_19_2)

		return true
	elseif var_19_0 == SglMsgType_pb.PB_TYPE_BATTLE_OP_CHAT then
		local var_19_3 = arg_19_1.Extensions[Battle_pb.SglBattleMsg.battle_chat_resp]

		if not arg_19_0._isIgnoreChat then
			arg_19_0:addChat(arg_19_0._opponent, var_19_3)
		end

		return true
	end

	return false
end

function var_0_0.exitScene(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or ClientData._fromSceneId

	if arg_20_0._battleType == Data.BattleType.PVP_room and P._playerRoom:getMyRoom() then
		arg_20_1 = ClientData.SceneId.in_room
	end

	if P._playerFindDark:isInDarkBattle() then
		arg_20_1 = ClientData.SceneId.find
	end

	if arg_20_0._battleType == Data.BattleType.PVP_survival then
		if P._playerFindSurvival._isInHall then
			arg_20_1 = ClientData.SceneId.survival_hall
		else
			arg_20_1 = ClientData.SceneId.find
			ClientData._battleFromFindIndex = Data.FindMatchType.survival
		end
	elseif arg_20_0._battleType == Data.BattleType.PVP_survival_ex then
		if P._playerFindSurvivalEx._isInHall then
			arg_20_1 = ClientData.SceneId.survival_ex_hall
		else
			arg_20_1 = ClientData.SceneId.find
			ClientData._battleFromFindIndex = Data.FindMatchType.survival_ex
		end
	end

	arg_20_0:stopAllActions()
	cc.Director:getInstance():getScheduler():setTimeScale(1)

	ClientData._replayInBattle = false

	if P._guideID < 100 then
		local var_20_0 = math.floor(P._guideID / 10) + 1

		if var_20_0 > 5 then
			GuideManager.setGuideIDandSave(101)

			local var_20_1 = cc.LayerColor:create(cc.c4b(255, 255, 255, 0), ClientView.SCR_W, ClientView.SCR_H)

			lc.addChildToCenter(arg_20_0._layer, var_20_1)
			lc.Audio.playAudio(AUDIO.E_FLASH)
			var_20_1:runAction(lc.sequence(lc.fadeIn(1), function()
				lc.replaceScene(require("ResSwitchScene").create(arg_20_0._scene._sceneId, ClientData.SceneId.city))
			end))
		else
			GuideManager.setGuideIDandSave(var_20_0 * 10 + 1, true)

			local var_20_2 = ClientData.genInputFromGuidance(var_20_0)

			arg_20_0._scene:onBattleRecover(var_20_2)
		end
	else
		if arg_20_0._baseBattleType == Data.BattleType.base_guidance then
			arg_20_1 = ClientData.SceneId.city
		elseif GuideManager._hasNewCityGuide then
			arg_20_1 = ClientData.SceneId.city
		end

		lc.replaceScene(require("ResSwitchScene").create(ClientData.SceneId.battle, arg_20_1))
	end
end

function var_0_0.initData(arg_22_0, arg_22_1)
	arg_22_0._input = arg_22_1
	arg_22_0._battleType = arg_22_1._battleType
	arg_22_0._baseBattleType = math.floor(arg_22_0._battleType / Data.BattleType.base_type)
	arg_22_0._sceneType = arg_22_1._sceneType or Data.BattleSceneType.stone_scene
	arg_22_0._timestamp = math.floor((arg_22_1._timestamp or (os.time() * 1000)) / 1000)

	if arg_22_0._isReverse then
		arg_22_0._isAttacker = not arg_22_1._isAttacker
	else
		arg_22_0._isAttacker = arg_22_1._isAttacker
	end

	arg_22_0._needForward = arg_22_1._needForward
	arg_22_0._storyName = arg_22_1._storyName
	arg_22_0._isSkipStory = false
	arg_22_0._isBattleEndSended = false

	if arg_22_1._replayBattleType then
		arg_22_0._replayType = arg_22_1._replayBattleType
		arg_22_0._replayBaseType = math.floor(arg_22_1._replayBattleType / Data.BattleType.base_type)
	end

	arg_22_0._timeOutTimes = 0
	arg_22_0._autoConfig = ClientData._isAutoBattle

	local function var_22_0(arg_23_0, arg_23_1)
		arg_23_1 = arg_23_1 or 0

		if arg_23_1 >= 9 then
			return 4
		elseif arg_23_1 >= 8 then
			return 3
		elseif arg_23_0 >= 60 or arg_23_1 >= 4 then
			return 2
		else
			return 1
		end
	end

	local function var_22_1(arg_24_0)
		if arg_24_0 >= 2000 then
			return 4
		elseif arg_24_0 >= 1500 then
			return 3
		elseif arg_24_0 >= 1200 then
			return 2
		else
			return 1
		end
	end

	local var_22_2 = var_22_0(arg_22_1._player._level, arg_22_1._player._vip)
	local var_22_3 = var_22_0(arg_22_1._opponent._level, arg_22_1._opponent._vip)

	local var_22_2 = math.max(3, var_22_0(arg_22_1._player._level, arg_22_1._player._vip))
	local var_22_3 = math.max(3, var_22_0(arg_22_1._opponent._level, arg_22_1._opponent._vip))

	if arg_22_0._nameTag ~= "normal" then
		arg_22_0._battleSpeed = 3
	elseif arg_22_0._baseBattleType == Data.BattleType.base_guidance then
		arg_22_0._battleSpeed = 1
	elseif arg_22_0._baseBattleType == Data.BattleType.base_PVP then
		arg_22_0._battleSpeed = 3
	elseif arg_22_0._baseBattleType == Data.BattleType.base_replay then
		arg_22_0._battleSpeed = math.max(3, var_22_0(P._level, P._vip))
	elseif lc._configs ~= nil then
		if arg_22_0:isGuideWorldBattle() then
			arg_22_0._battleSpeed = 1
		else
			arg_22_0._battleSpeed = lc.readConfig(ClientData.ConfigKey.battle_speed, 3)

			if arg_22_0._battleSpeed == nil or arg_22_0._battleSpeed < 1 or arg_22_0._battleSpeed > #var_0_0.BattleSpeed then
				arg_22_0._battleSpeed = 3
			end
		end
	else
		arg_22_0._battleSpeed = 3
	end

	arg_22_0._isObserver = arg_22_1._isWatcher
	arg_22_0._needSendEvent = arg_22_0._baseBattleType == Data.BattleType.base_PVP or arg_22_0._baseBattleType == Data.BattleType.base_PVE
	arg_22_0._needOperation = arg_22_0._baseBattleType == Data.BattleType.base_PVP or arg_22_0._baseBattleType == Data.BattleType.base_PVE or arg_22_0._baseBattleType == Data.BattleType.base_guidance or arg_22_0._baseBattleType == Data.BattleType.base_test or arg_22_0._battleType == Data.BattleType.test_story
	arg_22_0._needRetreat = (arg_22_0._baseBattleType == Data.BattleType.base_PVP or arg_22_0._baseBattleType == Data.BattleType.base_PVE or arg_22_0._baseBattleType == Data.BattleType.base_test or arg_22_0._battleType == Data.BattleType.teach) and not arg_22_0._isObserver
	arg_22_0._needReturn = (arg_22_0._baseBattleType == Data.BattleType.base_replay or arg_22_0._battleType == Data.BattleType.guidance_train or arg_22_0._battleType == Data.BattleType.recommend_train) and not arg_22_0._isObserver
	arg_22_0._needTask = (arg_22_0._battleType == Data.BattleType.task or arg_22_0._battleType == Data.BattleType.sweep or arg_22_1._replayBattleType == Data.BattleType.task or arg_22_1._replayBattleType == Data.BattleType.sweep or arg_22_0._battleType == Data.BattleType.teach) and not arg_22_0._isObserver
	arg_22_0._needEvents = arg_22_0._baseBattleType == Data.BattleType.base_PVP or arg_22_0._replayBaseType == Data.BattleType.base_PVP or arg_22_0._battleType == Data.BattleType.task or arg_22_0._battleType == Data.BattleType.world_boss or arg_22_0._battleType == Data.BattleType.sweep or arg_22_0._battleType == Data.BattleType.copy_commander or arg_22_0._battleType == Data.BattleType.guidance or arg_22_0._battleType == Data.BattleType.guidance_train or arg_22_0._battleType == Data.BattleType.recommend_train or arg_22_0._battleType == Data.BattleType.test or arg_22_0._battleType == Data.BattleType.test_story or arg_22_0._battleType == Data.BattleType.replay
	arg_22_0._retreatReturn = arg_22_0._battleType == Data.BattleType.boss
	arg_22_0._needShowInning = arg_22_0._battleType == Data.BattleType.PVP_dark
	arg_22_0._needSoftGuide = arg_22_0._nameTag == "normal" and (P and P._guideID or 0) >= 500 and (P and P._level or 50) < 10
	arg_22_0._isTesting = arg_22_1._isTesting
	-- a relayed room duel that is really a rank game: scored on the rank board
	arg_22_0._isRankLadder = arg_22_1._isRankLadder == true
	arg_22_0._speedFactor = arg_22_1._speedFactor or 1

	if (arg_22_0._isTesting and not arg_22_0._isOnlinePvp) or arg_22_0._isObserver then
		arg_22_0._needSendEvent = false
	end

	local var_22_6 = arg_22_1._isAttacker

	if arg_22_0._isReverse == true then
		var_22_6 = not arg_22_1._isAttacker
	end

	B._ruleType = arg_22_1._ruleType
	B._isAttackerController = var_22_6

	local var_22_7 = {
		_isClient = true,
		_isAttacker = var_22_6,
		_randomSeed = arg_22_1._randomSeed,
		_usedCards = arg_22_1._player._usedCards or {},
		_fortressHp = arg_22_1._player._fortressHp,
		_bossId = arg_22_1._player._bossId,
		_bossLevel = arg_22_1._player._bossLevel,
		_troopCards = arg_22_1._player._troopCards,
		_troopLevels = arg_22_1._player._troopLevels,
		_extraSkills = arg_22_1._player._extraSkills,
		_troopSkins = arg_22_1._player._troopSkins,
		_events = arg_22_0._needEvents and arg_22_1._eventIds or {},
		_conditions = (arg_22_0._needTask or (P and P._guideID and P._guideID < 100)) and {
			_conditionIds = arg_22_1._conditionIds or {},
			_conditionValues = arg_22_1._conditionValues or {}
		} or {},
		_storyRound = arg_22_1._storyRound or 0,
		_atkLevel = arg_22_1._isAttacker and arg_22_1._player._level or arg_22_1._opponent._level,
		_fortressSkill = arg_22_1._player._fortressSkill,
		_assistantHp = arg_22_1._player._assistantHp,
		_battleType = arg_22_0._replayType or arg_22_0._battleType,
		_isNpc = arg_22_1._player._isNpc,
		_idInRoom = arg_22_1._player._idInRoom,
		_survivalTimeStamp = arg_22_1._player._survivalTimeStamp,
		_reviewType = ClientData._cfg and ClientData._cfg.battleReview or 0,
		_monthCardType = arg_22_1._player._monthCardType,
		_isNewRound = arg_22_1._player._isNewRound,
		_roundTimeInit = arg_22_1._player._roundTimeInit,
		_roundTimeMax = arg_22_1._player._roundTimeMax,
		_roundTimeDelta = arg_22_1._player._roundTimeDelta
	}
	local var_22_8 = {
		_isClient = true,
		_isAttacker = not var_22_6,
		_randomSeed = arg_22_1._randomSeed,
		_usedCards = arg_22_1._opponent._usedCards or {},
		_fortressHp = arg_22_1._opponent._fortressHp,
		_bossId = arg_22_1._opponent._bossId,
		_bossLevel = arg_22_1._opponent._bossLevel,
		_troopCards = arg_22_1._opponent._troopCards,
		_troopLevels = arg_22_1._opponent._troopLevels,
		_extraSkills = arg_22_1._opponent._extraSkills,
		_troopSkins = arg_22_1._opponent._troopSkins,
		_events = arg_22_0._needEvents and arg_22_1._oppoEventIds or {},
		_conditions = {},
		_storyRound = arg_22_1._storyRound or 0,
		_atkLevel = arg_22_1._isAttacker and arg_22_1._player._level or arg_22_1._opponent._level,
		_fortressSkill = arg_22_1._opponent._fortressSkill,
		_assistantHp = arg_22_1._opponent._assistantHp,
		_battleType = arg_22_0._replayType or arg_22_0._battleType,
		_isNpc = arg_22_1._opponent._isNpc,
		_idInRoom = arg_22_1._opponent._idInRoom,
		_survivalTimeStamp = arg_22_1._opponent._survivalTimeStamp,
		_reviewType = ClientData._cfg and ClientData._cfg.battleReview or 0,
		_monthCardType = arg_22_1._opponent._monthCardType,
		_isNewRound = arg_22_1._opponent._isNewRound,
		_roundTimeInit = arg_22_1._opponent._roundTimeInit,
		_roundTimeMax = arg_22_1._opponent._roundTimeMax,
		_roundTimeDelta = arg_22_1._opponent._roundTimeDelta
	}

	ClientData._battleRoundStartInfo = nil
	arg_22_0._player = PlayerBattle.new(var_22_7)
	arg_22_0._opponent = PlayerBattle.new(var_22_8)
	arg_22_0._player._opponent, arg_22_0._opponent._opponent = arg_22_0._opponent, arg_22_0._player
	arg_22_0._player._name, arg_22_0._opponent._name = arg_22_1._player._name, arg_22_1._opponent._name
	arg_22_0._player._level, arg_22_0._opponent._level = arg_22_1._player._level, arg_22_1._opponent._level
	arg_22_0._player._vip, arg_22_0._opponent._vip = arg_22_1._player._vip, arg_22_1._opponent._vip
	arg_22_0._player._avatar, arg_22_0._opponent._avatar = arg_22_1._player._avatar, arg_22_1._opponent._avatar
	arg_22_0._player._crown, arg_22_0._opponent._crown = arg_22_1._player._crown, arg_22_1._opponent._crown
	if (arg_22_0._player._crown == nil or arg_22_0._player._crown._infoId == 0) then
		if P and P._crown and P._crown._infoId and P._crown._infoId ~= 0 then
			arg_22_0._player._crown = P._crown
		elseif ClientData and ClientData._account then
			local gc = tonumber(ClientData._account.gold_cup) or 0
			local sc = tonumber(ClientData._account.silver_cup) or 0
			local bc = tonumber(ClientData._account.bronze_cup) or 0
			if gc > 0 then
				arg_22_0._player._crown = { _infoId = 7204, _num = gc }
			elseif sc > 0 then
				arg_22_0._player._crown = { _infoId = 7205, _num = sc }
			elseif bc > 0 then
				arg_22_0._player._crown = { _infoId = 7206, _num = bc }
			end
		end
	end
	arg_22_0._player._legendCrown, arg_22_0._opponent._legendCrown = arg_22_1._player._legendCrown, arg_22_1._opponent._legendCrown
	arg_22_0._player._privilege, arg_22_0._opponent._privilege = arg_22_1._player._privilege or 0, arg_22_1._opponent._privilege or 0

	arg_22_0:resetBattle()

	if arg_22_0._nameTag == "normal" then
		ClientData._reportBattleDebugLog = true
		ClientData._battleDebugLog = "" .. P._id .. ": "

		for iter_22_0 = 1, #var_22_7._usedCards do
			ClientData.addBattleDebugLog((var_22_7._isAttacker and "AU" or "DU") .. var_22_7._usedCards[iter_22_0] .. ",")
		end

		for iter_22_1 = 1, #var_22_8._usedCards do
			ClientData.addBattleDebugLog((var_22_8._isAttacker and "AU" or "DU") .. var_22_8._usedCards[iter_22_1] .. ",")
		end

		ClientData.addBattleDebugLog("\n\n")
	end

	arg_22_0._isOnlinePvp = arg_22_0._battleType == Data.BattleType.PVP_clash or arg_22_0._battleType == Data.BattleType.PVP_clash_ex or arg_22_0._battleType == Data.BattleType.PVP_ladder or arg_22_0._battleType == Data.BattleType.PVP_room or arg_22_0._battleType == Data.BattleType.PVP_group or arg_22_0._battleType == Data.BattleType.PVP_dark or arg_22_0._battleType == Data.BattleType.PVP_survival or arg_22_0._battleType == Data.BattleType.PVP_survival_ex or arg_22_0._battleType == Data.BattleType.PVP_friend or (arg_22_1 and (arg_22_1._isOppoOnline or arg_22_1._pvpMatch))
	arg_22_0._needSendRound = arg_22_0._isOnlinePvp or arg_22_0._battleType == Data.BattleType.PVP_friend

	if arg_22_0._isOnlinePvp or arg_22_0._baseBattleType == Data.BattleType.base_PVP then
		arg_22_0._battleSpeed = 3
	end

	if arg_22_0._baseBattleType == Data.BattleType.base_replay then
		arg_22_0._player._playerType = BattleData.PlayerType.replay
		arg_22_0._opponent._playerType = BattleData.PlayerType.replay
		arg_22_0._isSkipStory = true
	elseif arg_22_0._baseBattleType == Data.BattleType.base_guidance then
		arg_22_0._player._playerType = P._guideID < 21 and BattleData.PlayerType.replay or BattleData.PlayerType.player
		arg_22_0._opponent._playerType = BattleData.PlayerType.replay
	elseif arg_22_0._baseBattleType == Data.BattleType.base_PVP then
		if arg_22_0._battleType == Data.BattleType.PVP_room and arg_22_0._isObserver then
			arg_22_0._player._playerType = BattleData.PlayerType.observe
		else
			arg_22_0._player._playerType = BattleData.PlayerType.player
		end

		if arg_22_0._isOnlinePvp then
			arg_22_0._opponent._playerType = BattleData.PlayerType.opponent
		elseif arg_22_0._battleType == Data.BattleType.PVP_friend then
			arg_22_0._opponent._playerType = BattleData.PlayerType.opponent
		else
			arg_22_0._opponent._playerType = BattleData.PlayerType.enviroment
		end

		if arg_22_0._battleType == Data.BattleType.PVP_survival_ex and arg_22_0._opponent._isNpc then
			arg_22_0._opponent._playerType = BattleData.PlayerType.enviroment
		end
	elseif arg_22_0._baseBattleType == Data.BattleType.base_PVE then
		arg_22_0._player._playerType = BattleData.PlayerType.player
		arg_22_0._opponent._playerType = BattleData.PlayerType.enviroment

		if arg_22_1._opponent._isUnionBoss then
			arg_22_0._needRetreat = false
		end
	elseif arg_22_0._battleType == Data.BattleType.test then
		arg_22_0._player._playerType = ClientData._isAutoTesting and BattleData.PlayerType.enviroment or BattleData.PlayerType.player
		arg_22_0._opponent._playerType = BattleData.PlayerType.enviroment
	elseif arg_22_0._battleType == Data.BattleType.recommend_train then
		arg_22_0._player._playerType = ClientData._isAutoTesting and BattleData.PlayerType.enviroment or BattleData.PlayerType.player
		arg_22_0._opponent._playerType = BattleData.PlayerType.enviroment
	elseif arg_22_0._battleType == Data.BattleType.test_story then
		arg_22_0._player._playerType = BattleData.PlayerType.player
		arg_22_0._opponent._playerType = BattleData.PlayerType.replay
	elseif arg_22_0._battleType == Data.BattleType.unittest then
		arg_22_0._player._playerType = BattleData.PlayerType.player
		arg_22_0._opponent._playerType = BattleData.PlayerType.enviroment
	elseif arg_22_0._battleType == Data.BattleType.teach then
		arg_22_0._player._playerType = BattleData.PlayerType.player
		arg_22_0._opponent._playerType = BattleData.PlayerType.enviroment
	end

	if arg_22_0._isOnlinePvp then
		arg_22_0:stopPvpTiming()
		arg_22_0:removePvpTimingRope()
	end
end

function var_0_0.resetAction(arg_25_0)
	arg_25_0:setPosition(cc.p(ClientView.SCR_CW, ClientView.SCR_CH + arg_25_0._offsetY))
	arg_25_0:setScale(arg_25_0._scale)
	arg_25_0:stopAllActions()
end

function var_0_0.initBackground(arg_26_0)
	local var_26_0 = arg_26_0._sceneType or 11

	if var_26_0 ~= 21 and (var_26_0 < 11 or var_26_0 > 10 + Data.FindClashGrade.legend) then
		var_26_0 = 1
	end

	local var_26_1 = string.format("res/bat_scene/bat_scene_%d_bg.jpg", var_26_0)
	local var_26_2 = cc.Sprite:create(var_26_1)

	lc.addChildToCenter(ClientData._battleScene, var_26_2, -1)
	arg_26_0._scene:seenByCamera3D(var_26_2)

	arg_26_0._skySpr = var_26_2
	arg_26_0._battleFrame = lc.createSpriteWithMask("res/jpg/battle_frame_bg.jpg")

	lc.addChildToCenter(arg_26_0, arg_26_0._battleFrame)

	local var_26_3 = ClientView.createShaderButton(nil, function()
		local var_27_0 = arg_26_0._playerUi

		if var_27_0 then
			local var_27_1 = var_27_0._player._graveCards
			local var_27_2 = var_27_0._player:getBattleCards("L")

			arg_26_0:showGraveList(var_27_0, var_27_1, var_27_2)
		end
	end)

	var_26_3:setContentSize(cc.size(ClientView.CARD_SIZE.width * CardSprite.Scale.grave, ClientView.CARD_SIZE.height * CardSprite.Scale.grave))
	var_26_3:setCameraMask(ClientData.CAMERA_3D_FLAG)
	lc.addChildToPos(arg_26_0, var_26_3, PlayerUi.Pos.attacker_grave)

	local var_26_4 = ClientView.createShaderButton(nil, function()
		local var_28_0 = arg_26_0._opponentUi

		if var_28_0 then
			local var_28_1 = var_28_0._player._graveCards
			local var_28_2 = var_28_0._player:getBattleCards("L")

			arg_26_0:showGraveList(var_28_0, var_28_1, var_28_2)
		end
	end)

	var_26_4:setContentSize(cc.size(ClientView.CARD_SIZE.width * CardSprite.Scale.grave, ClientView.CARD_SIZE.height * CardSprite.Scale.grave))
	var_26_4:setCameraMask(ClientData.CAMERA_3D_FLAG)
	lc.addChildToPos(arg_26_0, var_26_4, PlayerUi.Pos.defender_grave)
end

function var_0_0.initUiControl(arg_29_0)
	local var_29_0 = cc.Node:create()

	var_29_0:setContentSize(ClientView.SCR_SIZE)
	var_29_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_29_0._scene, var_29_0, BattleScene.ZOrder.ui)

	arg_29_0._layer = var_29_0

	local function var_29_1(arg_30_0, arg_30_1)
		local var_30_0 = arg_30_0._name
		local var_30_1 = arg_30_0._level
		local var_30_2 = arg_30_0._region
		local var_30_3 = arg_29_0._battleType == Data.BattleType.replay and arg_29_0._replayType or arg_29_0._battleType
		local var_30_4 = var_30_3 == Data.BattleType.PVP_clash or var_30_3 == Data.BattleType.PVP_clash_npc
		local var_30_5 = ccui.Widget:create()

		var_30_5:setContentSize(140, 86)
		var_30_5:setTouchEnabled(true)
		var_30_5:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 == ccui.TouchEventType.ended then
				arg_29_0:showDialog(arg_30_1 and BattleDialog.Type.your_card_pile or BattleDialog.Type.oppo_card_pile)
			end
		end)

		local var_30_6 = ClientView.createTTF(var_30_0 or "")
		local var_30_7 = lc.createSprite({
			_name = "img_com_bg_2",
			_crect = ClientView.CRECT_COM_BG2,
			_size = cc.size(lc.w(var_30_6) + 24, 30)
		})

		var_30_7:setColor(lc.Color3B.black)
		var_30_7:setOpacity(150)
		var_30_7:setFlippedX(true)
		lc.addChildToPos(var_30_5, var_30_7, cc.p(lc.w(var_30_5) - lc.w(var_30_7) / 2 - 2, arg_30_1 and lc.h(var_30_7) / 2 or lc.h(var_30_5) - lc.h(var_30_7) / 2))
		lc.addChildToPos(var_30_5, var_30_6, cc.p(var_30_7:getPosition()))

		local var_30_8

		if var_30_1 and var_30_1 > 0 then
			local var_30_9 = ClientView.createLevelArea(var_30_1)

			lc.addChildToPos(var_30_5, var_30_9, cc.p(lc.w(var_30_5) - lc.w(var_30_9) / 2, lc.y(var_30_6)))
			lc.offset(var_30_7, -18)
			lc.offset(var_30_6, -24)

			if arg_29_0._battleType == Data.BattleType.PVP_clash and not arg_30_1 then
				var_30_9._level:setString("?")
			end
		end

		if var_30_2 and var_30_2 > 0 and var_30_4 and (not arg_30_1 or arg_29_0._battleType == Data.BattleType.replay) then
			local var_30_10 = string.format(Str(STR.BRACKETS_S), ClientData.genChannelRegionName(var_30_2))
			local var_30_11 = ClientView.createTTF(var_30_10, nil, ClientView.COLOR_TEXT_GREEN)

			lc.addChildToPos(var_30_5, var_30_11, cc.p(lc.left(var_30_6) - lc.w(var_30_11) / 2 - 4, lc.y(var_30_6)))
		end

		local var_30_12 = ClientView.createIconLabelArea("img_icon_cardnum", "", lc.w(var_30_5))

		lc.addChildToPos(var_30_5, var_30_12, cc.p(lc.w(var_30_12) / 2, arg_30_1 and lc.h(var_30_5) - lc.h(var_30_12) / 2 - 4 or lc.h(var_30_12) / 2))

		var_30_5._pile = var_30_12

		if var_30_4 then
			local var_30_13 = ClientView.createIconLabelArea("img_icon_res6_s", arg_30_0._trophy, lc.w(var_30_5))

			lc.addChildToPos(var_30_5, var_30_13, cc.p(lc.w(var_30_13) / 2, arg_30_1 and lc.top(var_30_12) + 4 + lc.h(var_30_13) / 2 or lc.bottom(var_30_12) - 4 - lc.h(var_30_13) / 2))
		end

		return var_30_5
	end

	local function var_29_2(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
		local var_32_0 = ClientView.createShaderButton(arg_32_0, function(arg_33_0)
			arg_29_0:onButtonEvent(arg_33_0)
		end)
		local var_32_1

		if arg_32_1 then
			var_32_1 = lc.createSprite(arg_32_1)
		elseif arg_32_2 then
			if type(arg_32_2) == "table" then
				var_32_1 = ClientView.createBMFont(arg_32_2._font, arg_32_2._str)
			else
				var_32_1 = ClientView.createBMFont(ClientView.BMFont.huali_32, arg_32_2)
			end
		end

		if var_32_1 then
			lc.addChildToPos(var_32_0, var_32_1, cc.p(lc.w(var_32_0) / 2, lc.h(var_32_0) / 2))

			var_32_0._icon = var_32_1
		end

		if arg_32_3 then
			local var_32_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_32_3)

			var_32_2:setColor(ClientView.COLOR_BUTTON_TITLE)
			lc.addChildToPos(var_32_0, var_32_2, cc.p(lc.w(var_32_0) / 2, -6))

			var_32_0._title = var_32_2
		end

		var_29_0:addChild(var_32_0)

		return var_32_0
	end

	local var_29_3 = 12 + ClientView.SCR_EDGE
	local var_29_4 = 20

	arg_29_0._btnEndRound = var_29_2("bat_btn_6")

	arg_29_0._btnEndRound:setPosition(ClientView.SCR_W - 40, 150 - ClientView.SCR_EDGE / 2)
	arg_29_0._btnEndRound:setRotation(var_29_4)
	arg_29_0._btnEndRound:setTouchEnabled(false)

	arg_29_0._pRoundTitle = lc.createSprite("bat_label_atk")
	arg_29_0._pRoundTitle:setVisible(false)

	lc.addChildToPos(arg_29_0._btnEndRound, arg_29_0._pRoundTitle, cc.p(52, 52))
	arg_29_0._pRoundTitle:setRotation(-var_29_4)

	local var_round_txt = ClientView.createBMFont(ClientView.BMFont.huali_26, "KẾT THÚC")
	var_round_txt:setScale(0.8)
	lc.addChildToPos(arg_29_0._btnEndRound, var_round_txt, cc.p(52, 52))
	var_round_txt:setRotation(-var_29_4)
	arg_29_0._pRoundText = var_round_txt

	arg_29_0._pRoundLabel = ClientView.createBMFont(ClientView.BMFont.huali_26, "0")

	lc.addChildToPos(arg_29_0._btnEndRound, arg_29_0._pRoundLabel, cc.p(100, 30))
	arg_29_0._pRoundLabel:setRotation(-var_29_4)

	arg_29_0._btnSetting = var_29_2("bat_btn_2", "bat_btn_set")

	arg_29_0._btnSetting:setPosition(lc.cw(arg_29_0._btnSetting) + var_29_3, ClientView.SCR_H - 80 - lc.ch(arg_29_0._btnSetting))

	arg_29_0._btnMusic = var_29_2(ClientData._isMusicOn and "bat_btn_3" or "bat_btn_2", nil, Str(ClientData._isMusicOn and STR.ON or STR.OFF), Str(STR.AUDIO_MUSIC))
	arg_29_0._btnSndEffect = var_29_2(ClientData._isEffectOn and "bat_btn_3" or "bat_btn_2", nil, Str(ClientData._isEffectOn and STR.ON or STR.OFF), Str(STR.AUDIO_EFFECT))
	arg_29_0._btnPos = var_29_2(ClientData._isPosOn and "bat_btn_3" or "bat_btn_2", nil, Str(ClientData._isPosOn and STR.ON or STR.OFF), Str(STR.POS_LABEL, true))
	arg_29_0._btnHelp = var_29_2("bat_btn_2", "bat_btn_icon_help", nil, Str(STR.HELP))
	arg_29_0._btnManualGuide = var_29_2("bat_btn_2", "bat_btn_icon_guide", nil, Str(STR.GUIDE))

	arg_29_0._btnMusic:setVisible(false)
	arg_29_0._btnSndEffect:setVisible(false)
	arg_29_0._btnPos:setVisible(false)
	arg_29_0._btnHelp:setVisible(false)
	arg_29_0._btnManualGuide:setVisible(false)

	arg_29_0._btnTask = var_29_2("bat_btn_2", "bat_btn_icon_task", nil, string.sub(Str(STR.PASS_CONDITION), 7))
	arg_29_0._btnRetreat = var_29_2("bat_btn_2", "bat_btn_icon_retreat", nil, arg_29_0._retreatReturn and Str(STR.BATTLE_RETURN) or Str(STR.BATTLE_RETREAT))
	arg_29_0._btnReturn = var_29_2("bat_btn_2", "bat_btn_icon_back", nil, Str(STR.RETURN))

	arg_29_0._btnTask:setVisible(false)
	arg_29_0._btnRetreat:setVisible(false)
	arg_29_0._btnReturn:setVisible(false)

	local var_29_5 = var_29_2("bat_btn_2", "bat_btn_icon_pause")

	var_29_5:setPosition(var_29_3 + lc.w(var_29_5) / 2, lc.bottom(arg_29_0._btnSetting) - lc.ch(var_29_5))

	arg_29_0._btnReplay = var_29_5

	local var_29_6 = var_29_2("bat_btn_2", "bat_btn_icon_auto", nil, Str(STR.AUTO))

	var_29_6:setPosition(var_29_5:getPosition())
	lc.offset(var_29_6._title, 0, 16)

	arg_29_0._btnAuto = var_29_6

	arg_29_0:setBtnAuto(arg_29_0._autoConfig)

	local var_29_7 = var_29_2("bat_btn_2", nil, string.format("x%d", arg_29_0._battleSpeed))

	var_29_7:setTouchRect(cc.rect(-6, -6, lc.w(var_29_7) + 12, lc.h(var_29_7) + 12))

	if arg_29_0._battleType == Data.BattleType.teach then
		var_29_7:setPosition(var_29_3 + lc.w(var_29_7) / 2, lc.bottom(arg_29_0._btnSetting) - lc.ch(var_29_7))
	else
		var_29_7:setPosition(var_29_3 + lc.w(var_29_7) / 2, lc.bottom(var_29_5) - lc.ch(var_29_7))
	end

	arg_29_0._btnSpeed = var_29_7
	if arg_29_0._isOnlinePvp or arg_29_0._baseBattleType == Data.BattleType.base_PVP then
		arg_29_0._btnSpeed:setVisible(false)
		arg_29_0._btnSpeed:setTouchEnabled(false)
	end

	local var_29_8 = var_29_2("bat_btn_2", "bat_btn_icon_switch")

	var_29_8:setTouchRect(cc.rect(-6, -6, lc.w(var_29_8) + 12, lc.h(var_29_8) + 12))
	var_29_8:setPosition(var_29_3 + lc.w(var_29_8) / 2, lc.bottom(arg_29_0._btnSetting) - lc.ch(var_29_8))

	arg_29_0._btnSwitchView = var_29_8

	local var_29_9 = var_29_2("initiative_icon")

	var_29_9:setPosition(ClientView.SCR_W - 160 - ClientView.SCR_EDGE, 40)
	var_29_9:setDisabledShader(ClientView.SHADER_DISABLE)

	arg_29_0._btnInitiative = var_29_9

	local var_29_10 = var_29_2("initiative_icon_rare")

	var_29_10:setPosition(130 + ClientView.SCR_EDGE, 180)
	var_29_10:setDisabledShader(ClientView.SHADER_DISABLE)

	arg_29_0._btnRare = var_29_10

	local var_29_11 = var_29_2("initiative_icon_rare")

	var_29_11:setPosition(lc.left(var_29_9) - 20 - lc.cw(var_29_11), 40)
	var_29_11:setDisabledShader(ClientView.SHADER_DISABLE)

	arg_29_0._btnRare2 = var_29_11

	local function var_29_12()
		local var_34_0 = var_29_2("bat_btn_1", "bat_icon_guide_npc", nil, Str(STR.TIP))

		var_34_0:setPosition(var_29_3 + lc.w(var_34_0) / 2 - 300, var_29_3 + lc.h(var_34_0) / 2)
		var_34_0:setVisible(false)

		arg_29_0._btnGuideHelp = var_34_0

		local var_34_1 = lc.createImageView({
			_name = "img_com_bg_11",
			_crect = ClientView.CRECT_COM_BG11
		})

		var_34_1:setVisible(false)
		lc.addChildToPos(arg_29_0._layer, var_34_1, cc.p(ClientView.SCR_CW, 740), BattleScene.ZOrder.ui)

		arg_29_0._guideHelp = var_34_1
	end

	local var_29_13 = {
		var_29_6,
		var_29_5,
		var_29_7,
		var_29_8
	}
	local var_29_14 = {}

	if arg_29_0._baseBattleType == Data.BattleType.base_PVP then
		if lc.PLATFORM == cc.PLATFORM_OS_WINDOWS then
			var_29_5:setPositionX(var_29_5:getPosition() + 100)

			if arg_29_0._battleType == Data.BattleType.PVP_clash or arg_29_0._battleType == Data.BattleType.PVP_friend or arg_29_0._battleType == Data.BattleType.PVP_ladder or arg_29_0._battleType == Data.BattleType.PVP_room or arg_29_0._battleType == Data.BattleType.PVP_group or arg_29_0._battleType == Data.BattleType.PVP_dark or arg_29_0._battleType == Data.BattleType.PVP_survival or arg_29_0._battleType == Data.BattleType.PVP_survival_ex then
				if arg_29_0._isObserver then
					var_29_14 = {
						var_29_8
					}
				else
					var_29_14 = {
						var_29_6,
						var_29_5
					}
				end
			else
				var_29_14 = {
					var_29_6,
					var_29_7,
					var_29_5
				}
			end
		elseif arg_29_0._battleType == Data.BattleType.PVP_clash or arg_29_0._battleType == Data.BattleType.PVP_friend or arg_29_0._battleType == Data.BattleType.PVP_ladder or arg_29_0._battleType == Data.BattleType.PVP_room or arg_29_0._battleType == Data.BattleType.PVP_group or arg_29_0._battleType == Data.BattleType.PVP_dark or arg_29_0._battleType == Data.BattleType.PVP_survival or arg_29_0._battleType == Data.BattleType.PVP_survival then
			if arg_29_0._isObserver then
				var_29_14 = {
					var_29_8
				}
			else
				var_29_14 = {
					var_29_6
				}
			end
		else
			var_29_14 = {
				var_29_6,
				var_29_7
			}
		end
	elseif arg_29_0._baseBattleType == Data.BattleType.base_PVE then
		if arg_29_0._isObserver then
			var_29_14 = {
				var_29_8
			}
		else
			var_29_14 = {
				var_29_6,
				var_29_7
			}
		end
	elseif arg_29_0._baseBattleType == Data.BattleType.base_replay then
		var_29_14 = {
			var_29_5,
			var_29_7,
			var_29_8
		}
	elseif arg_29_0._baseBattleType == Data.BattleType.base_guidance then
		var_29_12()

		var_29_14 = {}
	elseif arg_29_0._battleType == Data.BattleType.test then
		var_29_14 = {
			var_29_5,
			var_29_7
		}
	elseif arg_29_0._battleType == Data.BattleType.test_story then
		var_29_14 = {
			var_29_7,
			var_29_6
		}
	elseif arg_29_0._battleType == Data.BattleType.unittest then
		var_29_14 = {
			var_29_7,
			var_29_6
		}
	elseif arg_29_0._battleType == Data.BattleType.recommend_train then
		var_29_14 = {
			var_29_7,
			var_29_6
		}
	elseif arg_29_0._battleType == Data.BattleType.teach then
		var_29_14 = {
			var_29_7
		}
	end

	arg_29_0._showButtons = var_29_14

	for iter_29_0, iter_29_1 in ipairs(var_29_13) do
		iter_29_1:setVisible(false)
	end

	for iter_29_2, iter_29_3 in ipairs(var_29_14) do
		iter_29_3:setVisible(true)
	end

	if arg_29_0._isOnlinePvp or arg_29_0._baseBattleType == Data.BattleType.base_PVP then
		arg_29_0._btnSpeed:setVisible(false)
		arg_29_0._btnSpeed:setTouchEnabled(false)
	end

	local var_29_15 = lc.createMaskLayer(200, lc.Color3B.black, cc.size(ClientView.SCR_W + 50, ClientView.SCR_H + 50))

	var_29_15:setAnchorPoint(0.5, 0.5)

	arg_29_0._mask = var_29_15

	arg_29_0._layer:addChild(var_29_15, BattleScene.ZOrder.form)

	function var_29_15.resetAction(arg_35_0)
		arg_35_0:setPosition(ClientView.SCR_CW, ClientView.SCR_CH)
		arg_35_0:setVisible(false)
		arg_35_0:setOpacity(200)
		arg_35_0:stopAllActions()
	end

	var_29_15:resetAction()

	if P._guideID >= 21 and arg_29_0._battleType ~= Data.BattleType.unittest then
		local var_29_16 = cc.DragonBonesNode:createWithDecrypt("res/effects/vs.lcres", "vs", "vs")

		lc.addChildToPos(arg_29_0._scene, var_29_16, cc.p(ClientView.SCR_CW, ClientView.SCR_CH), BattleScene.ZOrder.top)
		var_29_16:gotoAndPlay("effect1")
		var_29_16:setScale(1.2 * math.max(1, ClientView.SCR_W / 1366))

		arg_29_0._vsBones = var_29_16

		arg_29_0._audioEngine:playEffect("e_vs")
	end

	if arg_29_0._battleType == Data.BattleType.unittest then
		arg_29_0._testMaskLayer = lc.createMaskLayer(128)

		lc.addChildToCenter(var_29_0, arg_29_0._testMaskLayer)

		arg_29_0._btnBatch = var_29_2("bat_btn_2", "bat_btn_icon_play", nil, Str(STR.BATCH))
		arg_29_0._btnLayout = var_29_2("bat_btn_2", "bat_btn_set", nil, Str(STR.LAYOUT))
		arg_29_0._btnLoad = var_29_2("bat_btn_2", "bat_btn_icon_back", nil, Str(STR.LOAD))
		arg_29_0._btnRunFree = var_29_2("bat_btn_2", "bat_btn_icon_manual", nil, Str(STR.RUN_FREE))
		arg_29_0._btnExport = var_29_2("bat_btn_2", "bat_btn_icon_retreat", nil, Str(STR.EXPORT))
		arg_29_0._btnRunTest = var_29_2("bat_btn_2", "bat_btn_icon_play", nil, Str(STR.RUN_TEST))

		local var_29_17 = {
			arg_29_0._btnBatch,
			arg_29_0._btnLayout,
			arg_29_0._btnLoad,
			arg_29_0._btnRunFree,
			arg_29_0._btnExport,
			arg_29_0._btnRunTest
		}

		for iter_29_4 = 1, #var_29_17 do
			lc.offset(var_29_17[iter_29_4]._title, 0, 20)
			var_29_17[iter_29_4]:setPosition(80 + ClientView.SCR_EDGE + 70 * iter_29_4, lc.h(var_29_0) - lc.ch(var_29_17[iter_29_4]) - 2)
			var_29_17[iter_29_4]:setVisible(iter_29_4 <= 3)
		end

		arg_29_0:createTestProgress()
	end
end

function var_0_0.resetWhenBattleStart(arg_36_0)
	arg_36_0._isAutoAuto = false
	arg_36_0._isAuto = arg_36_0._autoConfig
	arg_36_0._isPaused = false
	arg_36_0._isOperating = false
	arg_36_0._isAddingBoardCard = false
	arg_36_0._isBattleFinished = false
	arg_36_0._isWaitting = false

	arg_36_0:preloadEffects()
	arg_36_0:preloadEffects(true)
	arg_36_0:removeChildrenByTag(var_0_0.Tag.remove_when_reset)
end

function var_0_0.resetWhenBattleEnd(arg_37_0)
	if arg_37_0._statusScheduler ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_37_0._statusScheduler)
	end

	arg_37_0:removeSoftGuide()
	arg_37_0:hideThinking()

	if arg_37_0._isOnlinePvp then
		arg_37_0:stopPvpTiming()
		arg_37_0:removePvpTimingRope()
	end

	local var_37_0 = 20
	local var_37_1 = var_37_0
	local var_37_2 = 0.016666666666666666
	local var_37_3 = cc.Director:getInstance():getScheduler():getTimeScale()

	if var_37_3 > 1 then
		local var_37_4 = lc.rep(lc.sequence(function()
			local var_38_0 = 1 + (var_37_3 - 1) * var_37_1 / var_37_0

			cc.Director:getInstance():getScheduler():setTimeScale(var_38_0)

			if var_37_1 == 0 then
				return arg_37_0._scene:stopActionByTag(45)
			end

			var_37_1 = var_37_1 - 1
		end, var_37_2))

		var_37_4:setTag(45)
		arg_37_0._scene:runAction(var_37_4)
	end
end

function var_0_0.resetWhenRoundBegin(arg_39_0)
	arg_39_0._isOperating = false
	arg_39_0._isEndOperating = false
	arg_39_0._isAddingBoardCard = false
	arg_39_0._isEnableDrap = false

	arg_39_0:updateRoundButton()
	arg_39_0:updateRound()
end

function var_0_0.resetWhenInitialDeal(arg_40_0)
	arg_40_0._playerUi:resetWhenInitialDeal()
	arg_40_0._opponentUi:resetWhenInitialDeal()
end

function var_0_0.startBattle(arg_41_0)
	if arg_41_0._isAttacker then
		return arg_41_0._player:start()
	else
		return arg_41_0._opponent:start()
	end
end

function var_0_0.start(arg_42_0, arg_42_1)
	arg_42_0:updatePile(arg_42_0._playerUi)
	arg_42_0:updatePile(arg_42_0._opponentUi)
	arg_42_0:updateRound()

	return arg_42_1
end

function var_0_0.finish(arg_43_0)
	if arg_43_0._isBattleFinished then
		return
	end

	arg_43_0:resetWhenBattleEnd()

	arg_43_0._isBattleFinished = true

	local var_43_0 = 0.5
	local var_43_1 = arg_43_0._player:getResult()

	if var_43_1 ~= Data.BattleResult.draw then
		if arg_43_0._player._isRetreat or arg_43_0._opponent._isRetreat then
			arg_43_0:addChat(arg_43_0._player._isRetreat and arg_43_0._player or arg_43_0._opponent, Str(STR.BATTLE_CHAT_RETREAT))

			var_43_0 = 0.5
		elseif arg_43_0._player._isUseCardFinish or arg_43_0._opponent._isUseCardFinish then
			arg_43_0:addChat(arg_43_0._player._isUseCardFinish and arg_43_0._player or arg_43_0._opponent, Str(STR.BATTLE_CHAT_RETREAT))

			var_43_0 = 0.5
		elseif arg_43_0._player._isRemainUnusable or arg_43_0._opponent._isRemainUnusable then
			arg_43_0:addChat(arg_43_0._player._isRemainUnusable and arg_43_0._player or arg_43_0._opponent, Str(STR.BATTLE_CHAT_REMAIN_UNUSABLE))

			var_43_0 = 0.5
		elseif arg_43_0._baseBattleType == Data.BattleType.base_PVP then
			arg_43_0:addChat(var_43_1 == Data.BattleResult.win and arg_43_0._opponent or arg_43_0._player, Str(STR.BATTLE_CHAT_LOSE))

			var_43_0 = 0.5
		elseif arg_43_0._player:getIsRoundExceed() or arg_43_0._opponent:getIsRoundExceed() then
			arg_43_0:addChat(var_43_1 == Data.BattleResult.win and arg_43_0._opponent or arg_43_0._player, Str(STR.BATTLE_CHAT_ROUND_EXCEED))

			var_43_0 = 0.5
		elseif arg_43_0._battleType == Data.BattleType.teach then
			-- block empty
		elseif arg_43_0._player:getIsPileEmpty() or arg_43_0._opponent:getIsPileEmpty() then
			arg_43_0:addChat(var_43_1 == Data.BattleResult.win and arg_43_0._opponent or arg_43_0._player, Str(STR.BATTLE_CHAT_PILE_EMPTY))

			var_43_0 = 0.5
		end
	end

	return (arg_43_0._playerUi:finish(var_43_0))
end

function var_0_0.sendBattleEnd(arg_44_0)
	if arg_44_0._needSendEvent then
		if arg_44_0._isBattleEndSended then
			return
		elseif not arg_44_0._player._isSkipped then
			arg_44_0._isBattleEndSended = true

			arg_44_0:showWaiting()

			-- the server relays a PvP match without simulating it, so it has to
			-- be told the outcome this side arrived at
			local var_44_2 = arg_44_0._player:getResult()

			if arg_44_0:isGuideWorldBattle() then
				local var_44_0 = P._guideID

				while true do
					if Data._guideInfo[var_44_0]._stepName == "in battle" then
						break
					end

					var_44_0 = var_44_0 + 1
				end

				if arg_44_0._player:getResult() == Data.BattleResult.win then
					P._guideID = var_44_0 + 1

					ClientData.sendBattleEnd(true, var_44_2)

					P._isGuideBattleLose = nil
				else
					P._guideID = var_44_0 - 6

					ClientData.sendBattleEnd(nil, var_44_2)

					P._isGuideBattleLose = true
				end
			else
				ClientData.sendBattleEnd(nil, var_44_2)
			end
		end
	elseif not arg_44_0._isObserver then
		arg_44_0:showResult()
	end
end

function var_0_0.retry(arg_45_0)
	if not P:checkBattleCost(nil, nil, arg_45_0._input._levelId) then
		ToastManager.push(Str(STR.NOT_ENOUGH_GRAIN), ToastManager.DURATION_LONG)

		return
	end

	local var_45_0 = P._playerCard:getTroop(P._curTroopIndex)

	if var_45_0 == nil or #var_45_0 == 0 then
		ToastManager.push(Str(STR.EMPTY_IN_TROOP))

		return
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendBattleAgain()
end

function var_0_0.replay(arg_46_0)
	arg_46_0:hideResult()
	arg_46_0._playerUi:efcFortressDieRemove()
	arg_46_0._opponentUi:efcFortressDieRemove()
	arg_46_0:resetBattle()
	arg_46_0._playerUi:resetWhenBattleStart()
	arg_46_0._opponentUi:resetWhenBattleStart()
	arg_46_0:resetWhenBattleStart()
	arg_46_0:setBattleSpeed()

	return arg_46_0:startBattle()
end

function var_0_0.retreat(arg_47_0, arg_47_1)
	if arg_47_0._player._isFinished or arg_47_0._opponent._isFinished then
		return
	end

	if arg_47_1 then
		arg_47_1._recordedUsedCards = arg_47_1._recordedUsedCards or {}
		table.insert(arg_47_1._recordedUsedCards, BattleData.UseCardId.retreat)
		table.insert(arg_47_1._recordedUsedCards, BattleData.UseCardId.none)
		table.insert(arg_47_1._recordedUsedCards, BattleData.UseCardId.none)
		table.insert(arg_47_1._recordedUsedCards, math.floor(ClientData.getCurrentTime()))
	end

	if arg_47_0._statusScheduler ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_47_0._statusScheduler)

		arg_47_0._statusScheduler = nil
	end

	if arg_47_0._needSendEvent then
		if arg_47_1._isAttacker == arg_47_0._isAttacker then
			if arg_47_0._retreatReturn then
				ClientData.sendBattleRetry()
				arg_47_0:exitScene()

				return true
			else
				ClientData.sendBattleUseCard(arg_47_1, BattleData.UseCardId.retreat, BattleData.UseCardId.none, BattleData.UseCardId.none)
			end
		else
			ClientData.sendBattleOppoUseCard(arg_47_1, BattleData.UseCardId.retreat, BattleData.UseCardId.none, BattleData.UseCardId.none)
		end
	end

	return arg_47_1:retreat()
end

function var_0_0.skip(arg_48_0)
	if arg_48_0._player._isFinished or arg_48_0._opponent._isFinished or arg_48_0._player._isSkipped then
		return
	end

	if arg_48_0._statusScheduler ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_48_0._statusScheduler)

		arg_48_0._statusScheduler = nil
	end

	if arg_48_0._needSendEvent then
		arg_48_0._isBattleFinished = true

		arg_48_0:showWaiting()
		ClientData.sendBattleSkip()
	end

	return arg_48_0._player:skip()
end

function var_0_0.skipAllStory(arg_49_0)
	arg_49_0:hideEvent()

	arg_49_0._isSkipStory = true

	arg_49_0:forwardToRound(false, 1)
end

function var_0_0.pause(arg_50_0)
	arg_50_0._isPaused = true

	GuideManager.pauseGuide()
	arg_50_0._player:pause()
	arg_50_0._opponent:pause()
end

function var_0_0.resume(arg_51_0)
	arg_51_0._isPaused = false

	GuideManager.resumeGuide()
	arg_51_0._player:resume()
	arg_51_0._opponent:resume()
end

function var_0_0.forwardToRound(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0._player:beginForward(not arg_52_1 and arg_52_2 or nil)
	arg_52_0._opponent:beginForward(arg_52_1 and arg_52_2 or nil)
	arg_52_0:startBattle()
	arg_52_0._player:endForward()
	arg_52_0._opponent:endForward()

	if arg_52_0._battleType == Data.BattleType.teach or arg_52_0._battleType == Data.BattleType.unittest then
		arg_52_0._player._fortress._hp = tonumber(arg_52_0._player._unitTestData.AttackerFields.HP) and tonumber(arg_52_0._player._unitTestData.AttackerFields.HP) or 8000
		arg_52_0._opponent._fortress._hp = tonumber(arg_52_0._player._unitTestData.DefenderFields.HP) and tonumber(arg_52_0._player._unitTestData.DefenderFields.HP) or 8000
		arg_52_0._player._fortress._maxHp = arg_52_0._player._fortress._hp
		arg_52_0._opponent._fortress._maxHp = arg_52_0._opponent._fortress._hp
		arg_52_0._player._fortress._updateInitHp = arg_52_0._player._fortress._hp
		arg_52_0._opponent._fortress._updateInitHp = arg_52_0._opponent._fortress._hp
	end

	arg_52_0._playerUi:forward()
	arg_52_0._opponentUi:forward()
	arg_52_0:updateRound()

	local var_52_0 = arg_52_0._player:getActionPlayer()

	if arg_52_0._player._isFinished or arg_52_0._opponent._isFinished then
		arg_52_0:finish()

		return arg_52_0:sendBattleEnd()
	end

	var_52_0:step()
end

function var_0_0.forwardToCurRound(arg_53_0)
	arg_53_0._player:beginForward()
	arg_53_0._opponent:beginForward()
	arg_53_0:startBattle()
	arg_53_0._player:endForward()
	arg_53_0._opponent:endForward()
	arg_53_0._playerUi:forward()
	arg_53_0._opponentUi:forward()
	arg_53_0:updateRound()

	local var_53_0 = arg_53_0._player:getActionPlayer()

	if arg_53_0._player._isFinished or arg_53_0._opponent._isFinished then
		arg_53_0:finish()

		return arg_53_0:sendBattleEnd()
	end

	var_53_0:step()
end

function var_0_0.initialDeal(arg_54_0, arg_54_1)
	if arg_54_0._nameTag == "normal" then
		arg_54_0:leaveFilmMode()
	end

	arg_54_0:resetWhenInitialDeal()
	arg_54_0:showDialog(BattleDialog.Type.initial_deal)

	return 0.6
end

function var_0_0.roundBegin(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_1._isAttacker == arg_55_0._isAttacker and arg_55_0._playerUi or arg_55_0._opponentUi

	arg_55_0:resetWhenRoundBegin()
	var_55_0:roundBegin()

	if arg_55_1._round == 0 then
		arg_55_2 = 0.2
	else
		local var_55_1 = 0

		if arg_55_1._isAttacker and arg_55_1._round >= arg_55_1._maxRound - 5 then
			if arg_55_1._maxRound - arg_55_1._round >= 0 then
				performWithDelay(arg_55_0, function()
					arg_55_0:showDialog(BattleDialog.Type.remain_round, arg_55_1._maxRound - arg_55_1._round)
				end, var_55_1)
			end
		else
			performWithDelay(arg_55_0, function()
				arg_55_0:showDialog(arg_55_1._isAttacker == arg_55_0._isAttacker and BattleDialog.Type.your_round or BattleDialog.Type.oppo_round)
			end, var_55_1)
		end

		arg_55_2 = 0.6 + var_55_1
	end

	if arg_55_0._battleType == Data.BattleType.PVP_room then
		if arg_55_1._round == 1 then
			if arg_55_0._exchangeDialog == nil then
				arg_55_0._exchangeDialog = arg_55_0:showDialog(BattleDialog.Type.exchange)
			end
		elseif arg_55_0._exchangeDialog ~= nil then
			arg_55_0._exchangeDialog:removeFromParent()

			arg_55_0._exchangeDialog = nil
		end
	end

	if arg_55_1._playerType == BattleData.PlayerType.enviroment and ClientData._cfg and ClientData._cfg.aiSurrender then
		arg_55_0:retreat(arg_55_1)
	end

	return arg_55_2
end

function var_0_0.roundEnd(arg_58_0, arg_58_1, arg_58_2)
	arg_58_2 = (arg_58_1._isAttacker == arg_58_0._isAttacker and arg_58_0._playerUi or arg_58_0._opponentUi):roundEnd(arg_58_2)

	if not arg_58_0._isTesting and P._guideID < 100 then
		P._guideID = P._guideID + 1

		ClientData.sendGuideID(P._guideID)
	end

	return arg_58_2
end

function var_0_0.action(arg_59_0, arg_59_1)
	(arg_59_1._isAttacker == arg_59_0._isAttacker and arg_59_0._playerUi or arg_59_0._opponentUi):action()
end

function var_0_0.onBattleEvent(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_1._sender

	if var_60_0 ~= arg_60_0._player and var_60_0 ~= arg_60_0._opponent then
		return
	end

	if arg_60_0._statusScheduler ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_60_0._statusScheduler)

		arg_60_0._statusScheduler = nil
	end

	local var_60_1 = arg_60_1._type
	local var_60_2 = var_60_0._actionCard
	local var_60_3 = var_60_0._isAttacker == arg_60_0._isAttacker and arg_60_0._playerUi or arg_60_0._opponentUi
	local var_60_4 = var_60_2 ~= nil and (var_60_2._owner._isAttacker == arg_60_0._isAttacker and arg_60_0._playerUi or arg_60_0._opponentUi) or nil
	local var_60_5 = 0

	if var_60_1 == BattleData.Status.battle_start then
		var_60_5 = arg_60_0:start(var_60_5)
	elseif var_60_1 == BattleData.Status.battle_end then
		var_60_5 = arg_60_0:finish()
	elseif var_60_1 == BattleData.Status.round_begin then
		var_60_5 = arg_60_0:roundBegin(var_60_0, var_60_5)
		var_60_5 = var_60_3:accountAction(var_60_5, var_60_1, var_60_2)
	elseif var_60_1 == BattleData.Status.round_end then
		local var_60_6 = #var_60_0:getUnderChangedCards() > 0

		var_60_5 = arg_60_0:roundEnd(var_60_0, var_60_5)
		var_60_5 = var_60_3:accountAction(var_60_5, var_60_1, var_60_2)

		if var_60_6 then
			var_60_5 = var_60_5 + 0.5
		end
	elseif var_60_1 == BattleData.Status.deal then
		-- block empty
	elseif var_60_1 == BattleData.Status.use then
		arg_60_0._playerUi:updateBoardCardsActive()
		arg_60_0._opponentUi:updateBoardCardsActive()
		arg_60_0._playerUi:updateBoardCardsInitialSkills()
	elseif var_60_1 == BattleData.Status.action then
		arg_60_0:action(var_60_0)
	elseif var_60_1 == BattleData.Status.initial_deal then
		var_60_5 = arg_60_0:initialDeal(var_60_5)
	elseif var_60_1 == BattleData.Status.spelling or var_60_1 == BattleData.Status.under_spell_damage or var_60_1 == BattleData.Status.account_spell or var_60_1 == BattleData.Status.after_spell or var_60_1 == BattleData.Status.end_spell or var_60_1 == BattleData.Status.before_attack or var_60_1 == BattleData.Status.attacking or var_60_1 == BattleData.Status.under_attack or var_60_1 == BattleData.Status.under_attack_damage or var_60_1 == BattleData.Status.ac_under_attack_damage or var_60_1 == BattleData.Status.account_attack or var_60_1 == BattleData.Status.end_attack then
		var_60_5 = var_60_3:accountAction(var_60_5, var_60_1, var_60_2)
	elseif var_60_1 == BattleData.Status.account_status then
		var_60_5 = var_60_4:accountStatus(var_60_2, var_60_5)

		var_60_3:updateBoardCardsInitialSkills()
	elseif var_60_1 == BattleData.Status.account_halo then
		var_60_5 = var_60_3:accountHalo(var_60_5, var_60_1, var_60_2)
		var_60_5 = var_60_3:accountAction(var_60_5, var_60_1, var_60_2)
	elseif var_60_1 == BattleData.Status.account_event then
		var_60_5 = var_60_3:accountEvent(var_60_5)

		if var_60_5 == nil then
			return
		end
	elseif var_60_1 == BattleData.Status.try_use_card then
		return arg_60_0:tryUseCard(var_60_0)
	elseif var_60_1 == BattleData.Status.wait_oppo_use_card then
		return arg_60_0:waitOppoUseCard(var_60_0)
	elseif var_60_1 == BattleData.Status.wait_observe_use_card then
		return arg_60_0:waitObserveUseCard(var_60_0)
	elseif var_60_1 == BattleData.Status.send_battle_end then
		return arg_60_0:sendBattleEnd()
	elseif var_60_1 == BattleData.Status.use_card then
		arg_60_0:addBoardCardBegan(var_60_0)

		if var_60_2 == var_60_0._useCardTarget then
			var_60_5 = arg_60_0:defAction(var_60_0, var_60_2)
		else
			var_60_5 = arg_60_0:prepareAction(var_60_0, var_60_2)
		end

		if var_60_0 and var_60_2 and var_60_2._id then
			var_60_0._recordedUsedCards = var_60_0._recordedUsedCards or {}
			local rec_cid = B and B.extendId and B.extendId(var_60_0, var_60_2._id) or var_60_2._id
			local rec_tid = var_60_0._useCardTarget ~= nil and var_60_0._useCardTarget._id or BattleData.UseCardId.none
			if var_60_2._extra ~= nil and B and B.tableCount then
				rec_tid = rec_tid + B.tableCount(var_60_2._extra) * 10000
			end
			table.insert(var_60_0._recordedUsedCards, rec_cid)
			table.insert(var_60_0._recordedUsedCards, rec_tid)
			table.insert(var_60_0._recordedUsedCards, var_60_2._choice or BattleData.UseCardId.none)
			table.insert(var_60_0._recordedUsedCards, math.floor(ClientData.getCurrentTime()))
			if var_60_2._extra ~= nil and type(var_60_2._extra) == "table" then
				for extra_k, extra_v in pairs(var_60_2._extra) do
					table.insert(var_60_0._recordedUsedCards, extra_k)
					table.insert(var_60_0._recordedUsedCards, (type(extra_v) == "table" and #extra_v) or 0)
					if type(extra_v) == "table" then
						for extra_i = 1, #extra_v do
							table.insert(var_60_0._recordedUsedCards, extra_v[extra_i])
						end
					end
				end
			end
		end

		if arg_60_0._needSendEvent then
			if var_60_0._playerType == BattleData.PlayerType.player then
				if not var_60_0._isSkipped then
					ClientData.sendBattleUseCard(var_60_0, var_60_2._id, var_60_0._useCardTarget ~= nil and var_60_0._useCardTarget._id or BattleData.UseCardId.none, var_60_2._choice or BattleData.UseCardId.none, var_60_2._extra)
				end
			elseif var_60_0._playerType == BattleData.PlayerType.opponent then
				-- block empty
			elseif var_60_0._playerType == BattleData.PlayerType.enviroment then
				ClientData.sendBattleOppoUseCard(var_60_0, var_60_2._id, var_60_0._useCardTarget ~= nil and var_60_0._useCardTarget._id or BattleData.UseCardId.none, var_60_2._choice or BattleData.UseCardId.none, var_60_2._extra)
			elseif var_60_0._playerType == BattleData.PlayerType.mix and not ClientData._isOppoOnline then
				ClientData.sendBattleOppoUseCard(var_60_0, var_60_2._id, var_60_0._useCardTarget ~= nil and var_60_0._useCardTarget._id or BattleData.UseCardId.none, var_60_2._choice or BattleData.UseCardId.none, var_60_2._extra)
			end

			var_60_0:addRoundDuration()
		end
	elseif var_60_1 == BattleData.Status.start_action then

		if arg_60_0._isOnlinePvp then
			arg_60_0:stopPvpTiming()
			arg_60_0:removePvpTimingRope()
		end

		arg_60_0:resetWhenRoundEnd()

		if var_60_0 then
			var_60_0._recordedUsedCards = var_60_0._recordedUsedCards or {}
			table.insert(var_60_0._recordedUsedCards, BattleData.UseCardId.round)
			table.insert(var_60_0._recordedUsedCards, var_60_0._round)
			table.insert(var_60_0._recordedUsedCards, BattleData.UseCardId.none)
			table.insert(var_60_0._recordedUsedCards, math.floor(ClientData.getCurrentTime()))
			table.insert(var_60_0._recordedUsedCards, 0)
			table.insert(var_60_0._recordedUsedCards, 0)
			table.insert(var_60_0._recordedUsedCards, 0)
		end

		if arg_60_0._needSendEvent and (not arg_60_0._needSendRound or var_60_0._playerType == BattleData.PlayerType.enviroment) then
			if var_60_0 == arg_60_0._player then
				ClientData.sendBattleUseCard(var_60_0, BattleData.UseCardId.round, var_60_0._round, BattleData.UseCardId.none)
			else
				ClientData.sendBattleOppoUseCard(var_60_0, BattleData.UseCardId.round, var_60_0._round, BattleData.UseCardId.none)
			end
		end
	elseif var_60_1 == BattleData.Status.update_score_damage and (not var_60_0._isAttacker or true) then
		-- block empty
	elseif var_60_1 == BattleData.Status.update_score_destroy_card then
		-- block empty
	elseif var_60_1 == BattleData.Status.update_board_active then
		var_60_3:updateBoardCardsActive()
	elseif var_60_1 == BattleData.Status.update_oppo_board_active then
		var_60_3._opponentUi:updateBoardCardsActive()
	elseif var_60_1 == BattleData.Status.change_fortress_skill then
		var_60_3:updateFortressSkill()
	elseif var_60_1 == BattleData.Status.pvp_timing_begin then
		arg_60_0:pvpTimingWhenRoundBegin(var_60_0)
	elseif var_60_1 == BattleData.Status.after_account_attack then
		var_60_3:updateBoardCardsActive()

		return
	end

	arg_60_0._battleEvent = {}
	arg_60_0._battleEvent._type = arg_60_1._type
	arg_60_0._battleEvent._sender = arg_60_1._sender
	arg_60_0._statusScheduler = lc.Scheduler:scheduleScriptFunc(function(arg_61_0)
		arg_60_0:onBattleEventFinished()
	end, var_60_5 or 0, false)
end

function var_0_0.onBattleEventFinished(arg_62_0)
	if arg_62_0._statusScheduler ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_62_0._statusScheduler)

		arg_62_0._statusScheduler = nil
	end

	return arg_62_0._battleEvent._sender:step()
end

function var_0_0.tryUseCard(arg_63_0, arg_63_1)
	if not arg_63_0._isEndAllOperation then
		arg_63_0._isEndAllOperation = arg_63_0._nameTag == "normal" and arg_63_0._playerUi:getIsEndAllOperation() or false

		if arg_63_0._isEndAllOperation and not arg_63_0._isAuto and arg_63_0._baseBattleType ~= Data.BattleType.base_replay then
			arg_63_0._isAuto = true
			arg_63_0._isAutoAuto = true

			arg_63_0:setBtnAuto(arg_63_0._isAuto)
		end
	elseif arg_63_0._isAutoAuto then
		arg_63_0._isEndAllOperation = arg_63_0._playerUi:getIsEndAllOperation()

		if not arg_63_0._isEndAllOperation then
			arg_63_0._isAuto = false
			arg_63_0._isAutoAuto = false

			arg_63_0:setBtnAuto(arg_63_0._isAuto)
		end
	end

	if arg_63_0._isAuto then
		local var_63_0, var_63_1, var_63_2 = arg_63_1:aiUseCard()

		if var_63_0 == nil and arg_63_0._needSendRound and arg_63_0._needSendEvent then
			arg_63_0._isWaitting = true

			return ClientData.sendBattleUseCard(arg_63_0._player, BattleData.UseCardId.round, arg_63_1._round, BattleData.UseCardId.none)
		end

		return arg_63_1:doUseCard(var_63_0, var_63_1, var_63_2)
	elseif arg_63_0._isPvpTimeout then
		if arg_63_0._needSendRound and arg_63_0._needSendEvent then
			arg_63_0._isWaitting = true

			return ClientData.sendBattleUseCard(arg_63_0._player, BattleData.UseCardId.round, arg_63_1._round, -1)
		else
			return arg_63_1:doUseCard()
		end
	else
		if arg_63_0._isOperating then
			arg_63_0:addBoardCardEnded(arg_63_1)
		else
			arg_63_0._isAddingBoardCard = false
			arg_63_0:operateBegin()
		end

		if arg_63_0._isEnableDrap then
			if arg_63_0._player:getActionPlayer():getIsNeedDrop() then
				arg_63_0:showDropHand()
			else
				arg_63_0:finishDropHand()
			end
		end
	end
end

function var_0_0.waitOppoUseCard(arg_64_0, arg_64_1)

	arg_64_0._isWaitting = true

	if not arg_64_0:oppoTryUseCard() then
		arg_64_0:showThinking()
	end
end

function var_0_0.waitObserveUseCard(arg_65_0)
	arg_65_0._isWaitting = true

	if not arg_65_0:observeTryUseCard() then
		arg_65_0:showThinking()
	end
end

function var_0_0.operateBegin(arg_66_0)
	if arg_66_0._isOperating then
		return
	end

	local var_66_0 = arg_66_0._player
	local var_66_1 = arg_66_0._playerUi

	arg_66_0._isOperating = true
	arg_66_0._isAddingBoardCard = false

	var_66_1:updateCardsActive()
	arg_66_0:updateRoundButton()

	if arg_66_0._needSoftGuide then
		arg_66_0:addSoftGuide()
	end
end

function var_0_0.resetWhenRoundEnd(arg_67_0)
	local var_67_0 = arg_67_0._player

	arg_67_0._isOperating = false
	arg_67_0._isEndOperating = true

	if arg_67_0._isTouching then
		arg_67_0:onTouchCanceled(true)
	end

	if arg_67_0._dropLayer then
		arg_67_0:hideDropHand()
	end

	if arg_67_0._choiceMaskLayer then
		arg_67_0._choiceMaskLayer:cancelChoice()
	end

	if arg_67_0._choiceGraveDialog then
		arg_67_0._choiceGraveDialog:cancel()
	end

	if arg_67_0._choicePosDialog then
		arg_67_0._choicePosDialog:cancel()
	end

	arg_67_0._playerUi:updateCardsActive()
	arg_67_0:updateRoundButton()
	arg_67_0:removeExchangeArrow()
	arg_67_0:removeSoftGuide()

	if arg_67_0._timeOutTimes >= 3 and not arg_67_0._isAuto then
		arg_67_0._timeOutTimes = 0
		arg_67_0._isAuto = true

		arg_67_0:setBtnAuto(arg_67_0._isAuto)
	end
end

function var_0_0.useRoundEnd(arg_68_0)
	if arg_68_0._isAuto then
		return arg_68_0:tryUseCard(arg_68_0._player)
	elseif arg_68_0._isPvpTimeout then
		if arg_68_0._isOnlinePvp or (arg_68_0._needSendRound and arg_68_0._needSendEvent) then
			ClientData.sendBattleUseCard(arg_68_0._player, BattleData.UseCardId.round, arg_68_0._player._round, -1)
		end
		return arg_68_0._player:doUseCard()
	elseif arg_68_0._isOnlinePvp or (arg_68_0._needSendRound and arg_68_0._needSendEvent) then
		ClientData.sendBattleUseCard(arg_68_0._player, BattleData.UseCardId.round, arg_68_0._player._round, BattleData.UseCardId.none)
		return arg_68_0._player:doUseCard()
	else
		return arg_68_0._player:doUseCard()
	end
end

function var_0_0.operateEnd(arg_69_0, arg_69_1)
	if not arg_69_0._isOperating and arg_69_0._player ~= arg_69_0._player:getActionPlayer() then
		return
	end

	arg_69_0._isAddingBoardCard = false
	arg_69_0._btnEndRound:setTouchEnabled(false)
	arg_69_0:useRoundEnd()
end

function var_0_0.autoOperate(arg_70_0, arg_70_1)
	arg_70_0._isAuto = arg_70_1

	if arg_70_1 then
		if arg_70_0._isOperating then
			arg_70_0:operateEnd()
		end
	elseif arg_70_0._isAddingBoardCard then
		arg_70_0:operateBegin()
	end

	arg_70_0:setBtnAuto(arg_70_0._isAuto)
end

function var_0_0.addBoardCardBegan(arg_71_0, arg_71_1)
	if not arg_71_0._isOperating then
		return
	end

	local var_71_0 = arg_71_1._isAttacker == arg_71_0._isAttacker and arg_71_0._playerUi or arg_71_0._opponentUi

	arg_71_0._isAddingBoardCard = true

	var_71_0:updateGem()
	var_71_0:updateCardsActive()
	arg_71_0:updateRoundButton()

	if arg_71_0._needSoftGuide then
		arg_71_0:removeSoftGuide()
	end
end

function var_0_0.addBoardCardEnded(arg_72_0, arg_72_1)
	if not arg_72_0._isAddingBoardCard then
		return
	end

	local var_72_0 = arg_72_1._isAttacker == arg_72_0._isAttacker and arg_72_0._playerUi or arg_72_0._opponentUi

	arg_72_0._isAddingBoardCard = false

	var_72_0:updateCardsActive()
	arg_72_0:updateRoundButton()

	if arg_72_0._isOperating and arg_72_0._needSoftGuide then
		arg_72_0:addSoftGuide()
	end
end

function var_0_0.setOppoOnline(arg_73_0, arg_73_1)
	arg_73_1 = arg_73_1 and not arg_73_0._isBattleFinished

	if ClientData._isOppoOnline then
		if arg_73_1 then
			arg_73_0:showOppoOnline()
		end
	else
		if arg_73_1 then
			arg_73_0:showOppoOffline()
		end

		if arg_73_0._battleType == Data.BattleType.PVP_friend and arg_73_0._isWaitting then
			arg_73_0._isWaitting = false

			arg_73_0:hideThinking()
			arg_73_0._opponent:use()
		end
	end
end

function var_0_0.setPlayerOnline(arg_74_0, arg_74_1)
	arg_74_1 = arg_74_1 and not arg_74_0._isBattleFinished

	if ClientData._isPlayerOnline then
		if arg_74_1 then
			arg_74_0:showPlayerOnline()
		end
	elseif arg_74_1 then
		arg_74_0:showPlayerOffline()
	end
end

function var_0_0.onButtonEvent(arg_75_0, arg_75_1)
	if arg_75_0._choicePosDialog then
		return
	end

	if arg_75_1 == arg_75_0._btnReturn then
		arg_75_0:tryExitScene()
	elseif arg_75_1 == arg_75_0._btnEndRound then
		if arg_75_0._player:getActionPlayer():getIsNeedDrop() then
			arg_75_0:showDropHand()
		else
			arg_75_0._timeOutTimes = 0

			arg_75_0:operateEnd()
			arg_75_0:hideTip()
			arg_75_0:setGuideHelpButtonVisible(false)
		end
	elseif arg_75_1 == arg_75_0._btnSpeed then
		if arg_75_0._isOnlinePvp or arg_75_0._baseBattleType == Data.BattleType.base_PVP then
			return
		end
		local var_75_5 = arg_75_0._battleSpeed
		var_75_5 = (var_75_5 >= 4) and 1 or (var_75_5 + 1)
		arg_75_0:setBattleSpeed(var_75_5)
		if lc.writeConfig then
			lc.writeConfig(ClientData.ConfigKey.battle_speed, var_75_5)
		end
	elseif arg_75_1 == arg_75_0._btnReplay then
		arg_75_0._isPaused = not arg_75_0._isPaused

		if arg_75_0._isPaused then
			arg_75_0:pause()
			arg_75_0._btnReplay._icon:setSpriteFrame("bat_btn_icon_play")
		else
			arg_75_0:resume()
			arg_75_0._btnReplay._icon:setSpriteFrame("bat_btn_icon_pause")
		end
	elseif arg_75_1 == arg_75_0._btnAuto then
		local var_75_6 = P._id ~= 0 and P:getMaxCharacterLevel() or arg_75_0._player._level
		local var_75_7 = ClientData._isAutoBattle and 0 or 0

		if var_75_6 < var_75_7 then
			local var_75_8 = string.format(Str(STR.LORD_UNLOCK_LEVEL), var_75_7) .. Str(STR.BATTLE_AUTO)

			ToastManager.push(var_75_8)
		else
			arg_75_0._autoConfig = not arg_75_0._autoConfig

			arg_75_0:autoOperate(not arg_75_0._isAuto)

			if arg_75_0._autoConfig == false and ClientData._isAutoBattle then
				require("Dialog").showDialog(Str(STR.STOP_AUTO_BATTLE_TIP), function()
					ClientData._isAutoBattle = false
					ClientData._autoReloadCount = 0
				end)
			end
		end
	elseif arg_75_1 == arg_75_0._btnSetting then
		if ClientData.getCurrentTime() - arg_75_0._timestamp < 4 then
			return
		end

		if arg_75_0._settingLayer == nil then
			arg_75_0:showSetting()
		else
			arg_75_0:hideSetting()
		end
	elseif arg_75_1 == arg_75_0._btnMusic then
		ClientData.toggleAudio(lc.Audio.Behavior.music, not ClientData._isMusicOn)
		arg_75_0._btnMusic._icon:setString(Str(ClientData._isMusicOn and STR.ON or STR.OFF))
		arg_75_0._btnMusic:loadTextureNormal(ClientData._isMusicOn and "bat_btn_3" or "bat_btn_2", ccui.TextureResType.plistType)
	elseif arg_75_1 == arg_75_0._btnSndEffect then
		ClientData.toggleAudio(lc.Audio.Behavior.effect, not ClientData._isEffectOn)
		arg_75_0._btnSndEffect._icon:setString(Str(ClientData._isEffectOn and STR.ON or STR.OFF))
		arg_75_0._btnSndEffect:loadTextureNormal(ClientData._isEffectOn and "bat_btn_3" or "bat_btn_2", ccui.TextureResType.plistType)

		if not ClientData._isEffectOn then
			cc.SimpleAudioEngine:getInstance():stopAllEffects()
		end
	elseif arg_75_1 == arg_75_0._btnPos then
		ClientData.togglePos(not ClientData._isPosOn)
		arg_75_0._btnPos._icon:setString(Str(ClientData._isPosOn and STR.ON or STR.OFF))
		arg_75_0._btnPos:loadTextureNormal(ClientData._isPosOn and "bat_btn_3" or "bat_btn_2", ccui.TextureResType.plistType)
	elseif arg_75_1 == arg_75_0._btnRetreat then
		arg_75_0:hideSetting()
		arg_75_0:showRetreat()
	elseif arg_75_1 == arg_75_0._btnHelp then
		arg_75_0:hideSetting()
		require("BattleHelpForm").create():show()
	elseif arg_75_1 == arg_75_0._btnManualGuide then
		arg_75_0:hideSetting()
		arg_75_0._scene:enterManualGuideMode(1, true)
	elseif arg_75_1 == arg_75_0._btnGuideHelp then
		if arg_75_0._guideTipVals then
			arg_75_0._guideTipVals.t.touch = 1

			if arg_75_0._guideTipVals.t.hl_type == GuideManager.HighlightType.battle_skill then
				arg_75_0._guideTipVals.t.hl_type = nil
			end

			arg_75_0:showTip(arg_75_0._guideTipVals)
		end
	elseif arg_75_1 == arg_75_0._btnTask then
		arg_75_0:hideSetting()
		arg_75_0:showTask()
	elseif arg_75_1 == arg_75_0._btnLayout then
		arg_75_0:hideTestProgress()
		arg_75_0:setLoadRelativeButtonsVisbile(false)

		ClientData._unitTestFile = nil

		lc.replaceScene(require("BattleTestScene").create(arg_75_0._scene))
	elseif arg_75_1 == arg_75_0._btnLoad then
		arg_75_0:hideTestProgress()

		local var_75_9 = lc.App:getOpenFileName()

		if var_75_9 ~= nil and var_75_9 ~= "" then
			ClientData._unitTestFile = nil
			ClientData._battleDebugLog = ""
			BattleTestData._curOpType = BattleTestData.OperationType._load
			BattleTestData._singleFileName = var_75_9

			BattleTestData.resetUsedCards()
			arg_75_0:loadUnitTestFile(var_75_9)
		end
	elseif arg_75_1 == arg_75_0._btnBatch then
		arg_75_0:showTestProgress()
		arg_75_0:setLoadRelativeButtonsVisbile(false)

		local var_75_10

		if ClientData._cfg and ClientData._cfg.importFile then
			var_75_10 = ClientData._cfg.importFile
		else
			var_75_10 = lc.App:getOpenFileName()
		end

		if var_75_10 ~= nil and var_75_10 ~= "" then
			ClientData._unitTestFile = nil

			local var_75_11 = string.find(string.reverse(var_75_10), "\\")
			local var_75_12 = string.sub(var_75_10, 1, #var_75_10 - var_75_11 + 1)
			local var_75_13 = string.sub(var_75_10, #var_75_10 - var_75_11 + 2, #var_75_10)
			local var_75_14 = io.popen("dir \"" .. var_75_12 .. "\""):read("*all")

			BattleTestData._batch._filenames = arg_75_0:parseFileList(var_75_14, var_75_12, var_75_13)
			BattleTestData._batch._batchCount = #BattleTestData._batch._filenames

			function BattleTestData._batch._callback()
				arg_75_0:startBatchSingle()
			end

			arg_75_0:startBatchSingle()
		end
	elseif arg_75_1 == arg_75_0._btnRunFree then
		arg_75_0:hideTestProgress()
		arg_75_0._testMaskLayer:setVisible(false)

		arg_75_0._player._playerType = BattleData.PlayerType.player
	elseif arg_75_1 == arg_75_0._btnRunTest then
		if ClientData._unitTestFile == BattleTestData.DEFAULT_FILE then
			ToastManager.push("EXPORT FIRST")
		else
			arg_75_0:hideTestProgress()

			BattleTestData._curOpType = BattleTestData.OperationType._runTest

			arg_75_0._testMaskLayer:setVisible(false)

			arg_75_0._player._playerType = BattleData.PlayerType.enviroment

			arg_75_0._player:step()
		end
	elseif arg_75_1 == arg_75_0._btnExport then
		arg_75_0:hideTestProgress()
		arg_75_0:onExportUnitTestData()
	elseif arg_75_1 == arg_75_0._btnSwitchView then
		arg_75_0:reverse()
	elseif arg_75_1 == arg_75_0._btnInitiative or arg_75_1 == arg_75_0._btnRare or arg_75_1 == arg_75_0._btnRare2 then
		if not arg_75_0._playerUi._isController or arg_75_0._isObserver then
			return true
		end

		if arg_75_0._isAddingBoardCard then
			arg_75_0._playerUi:sendEvent(PlayerUi.EventType.dialog_adding_board_card)

			return true
		end

		local var_75_15, var_75_16 = arg_75_0._playerUi._player:getBattleCardsByCanCastInitiativeSkill(arg_75_1 == arg_75_0._btnInitiative and "BSDGHL" or "R")
		local var_75_17 = require("BattleInitiativeSkillsDialog").create(var_75_16, arg_75_1 == arg_75_0._btnInitiative and Str(STR.INITIATIVE_SKILL) or Str(STR.RARE_INITIATIVE_SKILL), 6)

		var_75_17:registerItemTouchHandles(function()
			arg_75_0._isMoved = false
		end, function(arg_79_0)
			if cc.pGetDistance(arg_79_0:getTouchMovePosition(), arg_79_0:getTouchBeganPosition()) > lc.Gesture.BUDGE_LIMIT then
				arg_75_0._isMoved = true
			end
		end, function(arg_80_0, arg_80_1)
			if var_75_17._isHiding then
				return
			end

			if arg_75_0._skillArea then
				arg_75_0._skillArea:removeFromParent()

				arg_75_0._skillArea = nil
				arg_75_0._isMoved = false

				return
			end

			if arg_75_0._isMoved then
				arg_75_0._isMoved = false

				return
			end

			var_75_17:hide()

			local var_80_0 = arg_80_0._skill

			arg_75_0._playerUi:castInitiativeSkill(var_80_0._owner, var_80_0)
		end, function(arg_81_0, arg_81_1)
			arg_75_0:showSkill(arg_81_0, arg_81_1)
		end)
		var_75_17:show()
	end
end

function var_0_0.showSkill(arg_82_0, arg_82_1, arg_82_2)
	if arg_82_0._skillArea then
		arg_82_0._skillArea:removeFromParent()

		arg_82_0._skillArea = nil
	end

	if not arg_82_0._skillArea then
		local var_82_0 = arg_82_1._skill
		local var_82_1 = 604
		local var_82_2 = 600
		local var_82_3 = cc.size(var_82_1 - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, var_82_2)
		local var_82_4 = require("SkillForm").create(var_82_0._id, var_82_0._level)

		var_82_4._btnBack:setVisible(false)
		lc.changeParent(var_82_4._form, var_82_4, arg_82_0._scene, BattleScene.ZOrder.form)

		arg_82_0._skillArea = var_82_4._form
	end
end

function var_0_0.onSwitchView(arg_83_0)
	arg_83_0._isReverse = not arg_83_0._isReverse

	arg_83_0:hideResult()
	arg_83_0._playerUi:efcFortressDieRemove()
	arg_83_0._opponentUi:efcFortressDieRemove()
	arg_83_0:resetBattle()
	arg_83_0._playerUi:resetWhenBattleStart()
	arg_83_0._opponentUi:resetWhenBattleStart()
	arg_83_0:resetWhenBattleStart()
	arg_83_0:setBattleSpeed()
	arg_83_0._playerUi:clear()
	arg_83_0._opponentUi:clear()

	local var_83_0 = arg_83_0._input._player

	arg_83_0._input._player = arg_83_0._input._opponent
	arg_83_0._input._opponent = var_83_0

	arg_83_0:initData(arg_83_0._input)

	arg_83_0._playerUi = PlayerUi.new(arg_83_0, arg_83_0._player, arg_83_0._sceneType, arg_83_0._input._player._cardBackId)
	arg_83_0._opponentUi = PlayerUi.new(arg_83_0, arg_83_0._opponent, arg_83_0._sceneType, arg_83_0._input._opponent._cardBackId)
	arg_83_0._playerUi._opponentUi = arg_83_0._opponentUi
	arg_83_0._opponentUi._opponentUi = arg_83_0._playerUi

	arg_83_0._playerUi:resetWhenBattleStart()
	arg_83_0._opponentUi:resetWhenBattleStart()
	arg_83_0:resetWhenBattleStart()
	arg_83_0:startBattle()
	arg_83_0._scene:seenByCamera3D(arg_83_0)
end

function var_0_0.addChild(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	if arg_84_2 then
		cc.Node.addChild(arg_84_0, arg_84_1, arg_84_2)
	elseif arg_84_3 then
		cc.Node.addChild(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	else
		cc.Node.addChild(arg_84_0, arg_84_1)
	end

	local var_84_0 = arg_84_1:getScaleY()

	if arg_84_1.setFlippedY then
		arg_84_1:setFlippedY(arg_84_0._isReverse)
	elseif arg_84_0._isReverse and var_84_0 > 0 then
		arg_84_1:setScaleY(-var_84_0)
	end
end

function var_0_0.tryExitScene(arg_85_0)
	if ClientData._replayInBattle then
		ClientData._replayInBattle = false
		arg_85_0._isBattleFinished = true
		arg_85_0._battleType = ClientData._replayInBattleType
		arg_85_0._baseBattleType = Data.BattleType.base_PVE

		local var_85_0 = BattleResultDialog.create(arg_85_0, BattleResultDialog.Type.battle_result, {
			_resultType = Data.BattleResult.lose
		})

		arg_85_0._scene:addChild(var_85_0, BattleScene.ZOrder.form)

		arg_85_0._resultDialog = var_85_0

		arg_85_0:hideSetting()
		arg_85_0:pause()
	else
		arg_85_0:exitScene()
	end
end

function var_0_0.reverse(arg_86_0)
	arg_86_0._isReverse = not arg_86_0._isReverse

	arg_86_0:setFlippedY(arg_86_0._isReverse)

	local var_86_0 = arg_86_0:getRotation3D()

	arg_86_0._playerUi:reverse(arg_86_0._isReverse)
	arg_86_0._opponentUi:reverse(arg_86_0._isReverse)

	for iter_86_0, iter_86_1 in ipairs(arg_86_0:getChildren()) do
		if iter_86_1.setFlippedY then
			iter_86_1:setFlippedY(arg_86_0._isReverse)
		end
	end

	arg_86_0._playerUi:updateHandCardsPos()
	arg_86_0._playerUi:updateBoardCardsPos()
	arg_86_0._opponentUi:updateHandCardsPos()
	arg_86_0._opponentUi:updateBoardCardsPos()

	if arg_86_0._playerUi._hideHandCards ~= arg_86_0._opponentUi._hideHandCards then
		arg_86_0._playerUi:hideHandCards()
		arg_86_0._opponentUi:hideHandCards()
	end

	arg_86_0:reverseThinking()
end

function var_0_0.onPlayerUiEvent(arg_87_0, arg_87_1)
	local var_87_0 = arg_87_1._sender

	if var_87_0._battleUi ~= arg_87_0 then
		return
	end

	local var_87_1 = var_87_0._player
	local var_87_2 = arg_87_1._type
	local var_87_3 = arg_87_1._val

	if var_87_2 == PlayerUi.EventType.dialog_defender_hand_cards then
		arg_87_0:showDialog(BattleDialog.Type.defender_hand_cards)
	elseif var_87_2 == PlayerUi.EventType.dialog_attacker_hand_cards then
		arg_87_0:showDialog(BattleDialog.Type.attacker_hand_cards)
	elseif var_87_2 == PlayerUi.EventType.dialog_not_enough_gem then
		arg_87_0:showDialog(BattleDialog.Type.not_enough_gem)
	elseif var_87_2 == PlayerUi.EventType.dialog_board_card_full then
		arg_87_0:showDialog(BattleDialog.Type.board_card_full)
	elseif var_87_2 == PlayerUi.EventType.dialog_not_your_round then
		arg_87_0:showDialog(BattleDialog.Type.not_your_round)
	elseif var_87_2 == PlayerUi.EventType.dialog_card_need_aim then
		arg_87_0:showDialog(BattleDialog.Type.card_need_aim, var_87_3)
	elseif var_87_2 == PlayerUi.EventType.dialog_card_need_target then
		arg_87_0:showDialog(BattleDialog.Type.card_need_target)
	elseif var_87_2 == PlayerUi.EventType.dialog_cannot_effect then
		arg_87_0:showDialog(BattleDialog.Type.cannot_effect, var_87_3)
	elseif var_87_2 == PlayerUi.EventType.dialog_special_summon_invalid then
		arg_87_0:showDialog(BattleDialog.Type.special_summon_invalid)
	elseif var_87_2 == PlayerUi.EventType.dialog_trap_existed then
		arg_87_0:showDialog(BattleDialog.Type.trap_existed, var_87_3)
	elseif var_87_2 == PlayerUi.EventType.dialog_adding_board_card then
		arg_87_0:showDialog(BattleDialog.Type.adding_board_card)
	elseif var_87_2 == PlayerUi.EventType.dialog_target_unattackable then
		arg_87_0:showDialog(BattleDialog.Type.target_unattackable)
	elseif var_87_2 == PlayerUi.EventType.dialog_cannot_attack then
		arg_87_0:showDialog(BattleDialog.Type.cannot_attack)
	elseif var_87_2 == PlayerUi.EventType.dialog_cannot_change_posture then
		arg_87_0:showDialog(BattleDialog.Type.cannot_change_posture, var_87_3)
	elseif var_87_2 == PlayerUi.EventType.efc_screen_fortress_die then
		arg_87_0:shakeScreen(var_0_0.ShakeScreenType.fortress_die, var_87_0, var_87_3 or {})
	elseif var_87_2 == PlayerUi.EventType.efc_screen_fortress_hurt then
		arg_87_0:shakeScreen(var_0_0.ShakeScreenType.fortress_hurt, var_87_0, var_87_3 or {})
	elseif var_87_2 == PlayerUi.EventType.efc_screen_to_board then
		arg_87_0:shakeScreen(var_0_0.ShakeScreenType.to_board, var_87_0, var_87_3 or {})
	elseif var_87_2 == PlayerUi.EventType.efc_screen_equip_book then
		arg_87_0:shakeScreen(var_0_0.ShakeScreenType.equip_book, var_87_0, var_87_3 or {})
	elseif var_87_2 == PlayerUi.EventType.efc_screen_attack_card then
		arg_87_0:shakeScreen(var_0_0.ShakeScreenType.attack_card, var_87_0, var_87_3 or {})
	elseif var_87_2 == PlayerUi.EventType.efc_camera_to then
		arg_87_0:cameraTo(arg_87_1._val._isAttacker, arg_87_1._val._delayTime)
	elseif var_87_2 == PlayerUi.EventType.update_card_pile_count then
		arg_87_0:updatePile(var_87_0)
		arg_87_0:updatePile(var_87_0._opponentUi)
	elseif var_87_2 == PlayerUi.EventType.send_use_card then
		if var_87_3._card then
			var_87_3._card._opInfoId = var_87_3._card._infoId
		end

		var_87_1:doUseCard(var_87_3._card, var_87_3._target, var_87_3._choice, var_87_3._extra)
	end
end

function var_0_0.onCardSpriteEvent(arg_88_0, arg_88_1)
	local var_88_0 = arg_88_1._sender

	if var_88_0._battleUi ~= arg_88_0 then
		return
	end

	local var_88_1 = arg_88_1._type
	local var_88_2 = arg_88_1._val

	if var_88_1 == CardSprite.EventType.show_card_info then
		if var_88_0._mask ~= nil then
			arg_88_0:showCardInfo(var_88_0, var_88_0._mask._card)
		else
			arg_88_0:showCardInfo(var_88_0, var_88_0._card)
		end
	elseif var_88_1 == CardSprite.EventType.hide_card_info then
		arg_88_0:hideCardInfo()
	elseif var_88_1 == CardSprite.EventType.show_grave_list then
		local var_88_3 = var_88_0._card._owner._graveCards
		local var_88_4 = var_88_0._card._owner:getBattleCards("L")
		local var_88_5 = var_88_0._ownerUi

		arg_88_0:showGraveList(var_88_5, var_88_3, var_88_4)
	elseif var_88_1 == CardSprite.EventType.show_rare_list then
		local var_88_6 = var_88_0._card._owner._rareCards

		BattleListDialog.create(arg_88_0, var_88_6, BattleListDialog.Mode.list, lc.str(STR.BATTLE_EXCARD_LIST)):show()
	elseif var_88_1 == CardSprite.EventType.show_hand_list then
		local var_88_7 = var_88_0._card._owner._handCards

		BattleListDialog.create(arg_88_0, var_88_7, BattleListDialog.Mode.list, lc.str(STR.BATTLE_HAND)):show()
	end
end

function var_0_0.showGraveList(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	local var_89_0 = BattleListDialog.create(arg_89_0, arg_89_2, BattleListDialog.Mode.list, lc.str(STR.BATTLE_GRAVE), arg_89_1)

	var_89_0._showGrave = true

	local var_89_1 = ClientView.createShaderButton("grave_light")
	local var_89_2 = ClientView.createShaderButton("leave_dark")

	function var_89_1._callback(arg_90_0)
		var_89_0:setCardInfos(arg_89_2, Str(STR.BATTLE_GRAVE))
		var_89_1:setEnabled(false)
		var_89_2:setEnabled(true)
		var_89_1:loadTextureNormal("grave_light", ccui.TextureResType.plistType)
		var_89_2:loadTextureNormal("leave_dark", ccui.TextureResType.plistType)
	end

	lc.addChildToPos(var_89_0, var_89_1, cc.p(lc.cw(var_89_0) - 100, 100))

	function var_89_2._callback(arg_91_0)
		var_89_0:setCardInfos(arg_89_3, Str(STR.BATTLE_LEAVE))
		var_89_1:setEnabled(true)
		var_89_2:setEnabled(false)
		var_89_1:loadTextureNormal("grave_dark", ccui.TextureResType.plistType)
		var_89_2:loadTextureNormal("leave_light", ccui.TextureResType.plistType)
	end

	lc.addChildToPos(var_89_0, var_89_2, cc.p(lc.cw(var_89_0) + 100, 100))
	var_89_0:show()
end

function var_0_0.softGuide(arg_92_0)
	arg_92_0:removeSoftGuide()

	local var_92_0
	local var_92_1, var_92_2, var_92_3 = arg_92_0._player:aiUseCard()

	if var_92_1 == nil then
		local var_92_4 = arg_92_0._layer:convertToNodeSpace(arg_92_0._btnEndRound:convertToWorldSpace(cc.p(54, 40)))

		print(var_92_4.x, var_92_4.y)

		var_92_0 = arg_92_0:createDragonBones("jiantou", var_92_4, arg_92_0._layer, "tap", false, 2, BattleUi.ZOrder.effect)
	elseif var_92_1._status == BattleData.CardStatus.hand then
		local var_92_5 = cc.p(arg_92_0._playerUi._pHandCards[var_92_1._pos]._default._position.x, 100)

		var_92_0 = arg_92_0._playerUi:efcDragonBones(nil, "jiantou", var_92_5, false, false, "drag", 2)
	end

	arg_92_0._softGuideLayer = var_92_0
end

function var_0_0.addSoftGuide(arg_93_0, arg_93_1)
	arg_93_0:removeSoftGuide()

	if arg_93_0._battleType == Data.BattleType.teach then
		return
	end

	arg_93_1 = (P._level <= 3 and 3 or P._level <= 5 and 5 or 10) * cc.Director:getInstance():getScheduler():getTimeScale()
	arg_93_0._softGuideScheduler = lc.Scheduler:scheduleScriptFunc(function(arg_94_0)
		arg_93_0:softGuide()
	end, arg_93_1, false)
end

function var_0_0.removeSoftGuide(arg_95_0)
	if arg_95_0._softGuideScheduler ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_95_0._softGuideScheduler)

		arg_95_0._softGuideScheduler = nil
	end

	if arg_95_0._softGuideLayer ~= nil then
		arg_95_0._softGuideLayer:removeFromParent()

		arg_95_0._softGuideLayer = nil
	end
end

function var_0_0.addChat(arg_96_0, arg_96_1, arg_96_2)
	if arg_96_1._isAttacker == arg_96_0._isAttacker then
		arg_96_0:showDialog(BattleDialog.Type.chat_dialog, arg_96_2)
	else
		arg_96_0:showDialog(BattleDialog.Type.oppo_chat_dialog, arg_96_2)
	end
end

function var_0_0.changeResource(arg_97_0, arg_97_1)
	local var_97_0 = arg_97_1._resultType
	local var_97_1 = var_97_0 == Data.BattleResult.win

	if arg_97_0._baseBattleType ~= Data.BattleType.base_PVE or arg_97_0._battleType == Data.BattleType.npc then
		-- block empty
	elseif arg_97_0._battleType == Data.BattleType.boss then
		local var_97_2 = P:getBattleCost(nil, var_97_0 == Data.BattleResult.lose, arg_97_0._input._levelId)

		P:changeResource(Data.ResType.grain, -var_97_2)

		if var_97_0 == Data.BattleResult.win and arg_97_1._propId ~= nil then
			P._propBag:changeProps(arg_97_1._propId, -1)
		end
	elseif arg_97_0._battleType == Data.BattleType.expedition_ex then
		if ClientData._expeditionNpcInfos[ClientData._expeditionCurNpc]._challengeCount == 0 then
			local var_97_3 = {
				Data._globalInfo._expeditionSimpleNPCCost,
				Data._globalInfo._expeditionMediumNPCCost,
				Data._globalInfo._expeditionHardNPCCost
			}

			P:changeResource(Data.ResType.gold, -var_97_3[ClientData._expeditionNpcInfos[ClientData._expeditionCurNpc]._level + 1])
		end
	elseif arg_97_0._battleType == Data.BattleType.expedition_ex_boss then
		if ClientData._expeditionBossInfo._challengeCount == 0 then
			P:changeResource(Data.ResType.gold, -Data._globalInfo._expeditionBossCost)
		end
	elseif not arg_97_0:isGuideWorldBattle() or var_97_1 then
		local var_97_4 = P:getBattleCost(nil, var_97_0 == Data.BattleResult.lose, arg_97_0._input._levelId)

		P:changeResource(Data.ResType.grain, -var_97_4)
	end

	if arg_97_0._battleType == Data.BattleType.PVP_room then
		local var_97_5 = P._playerRoom:getMyRoom()

		if var_97_5 and var_97_5._type == Data.RoomType.normal then
			local var_97_6 = var_97_5._members

			for iter_97_0 = 1, 3 do
				local var_97_7 = var_97_6[iter_97_0]

				if var_97_7 and var_97_7._idInRoom == arg_97_0._player._idInRoom then
					var_97_7._win = var_97_7._win + (var_97_1 and 1 or 0)
				elseif var_97_7 and var_97_7._idInRoom == arg_97_0._opponent._idInRoom then
					var_97_7._win = var_97_7._win + (var_97_1 and 0 or 1)
				end
			end
		end
	end

	local var_97_8 = P._characters[P:getCharacterId()]

	arg_97_1._preExp = var_97_8._exp
	arg_97_1._preLevel = var_97_8._level

	P:changeExp(arg_97_1._exp, arg_97_1._timestamp / 1000)

	arg_97_1._curExp = var_97_8._exp
	arg_97_1._curLevel = var_97_8._level
	arg_97_1._exp = Data._globalInfo._playerLevelupExp[arg_97_1._curLevel] - Data._globalInfo._playerLevelupExp[arg_97_1._preLevel] + arg_97_1._curExp - arg_97_1._preExp

	P:changeResource(Data.ResType.gold, arg_97_1._gold)
	P:changeResource(Data.ResType.grain, arg_97_1._grain)
	P:changeResource(Data.ResType.ingot, arg_97_1._ingot)

	local var_97_9 = arg_97_0._battleType == Data.BattleType.PVP_clash or arg_97_0._battleType == Data.BattleType.PVP_clash_npc or arg_97_0._isRankLadder

	if arg_97_1._trophy then
		local var_97_10 = var_97_1 and arg_97_1._trophy or -arg_97_1._trophy

		if var_97_9 then
			P._playerFindClash:changeTrophy(var_97_10)
		else
			P:changeTrophy(var_97_10)

			P._dailyTrophy = P._dailyTrophy + var_97_10
		end
	end

	if arg_97_1._clashExTrophy then
		P:changeResource(Data.ResType.clash_ex_trophy, arg_97_1._clashExTrophy)
	end

	if arg_97_1.survival_ex_trophy then
		P:changeResource(Data.ResType.survival_ex_trophy, arg_97_1.survival_ex_trophy)
	end

	if arg_97_1._unionBattleTrophy then
		P:changeResource(Data.ResType.union_battle_trophy, arg_97_1._unionBattleTrophy)
	end

	if arg_97_1._darkTrophy then
		P:changeResource(Data.ResType.dark_trophy, arg_97_1._darkTrophy)
	end

	if arg_97_1._yubi then
		P._propBag:changeProps(Data.PropsId.yubi, arg_97_1._yubi)
	end

	if arg_97_1._newServerScore then
		P:changeResource(Data.ResType.new_server_score, arg_97_1._newServerScore)
	end

	if arg_97_1.trophy_activity then
		P:changeResource(Data.ResType.trophy_activity, arg_97_1.trophy_activity)
	end

	if arg_97_1.rank1 then
		P:changeResource(Data.ResType.rank1, arg_97_1.rank1)
	end

	if arg_97_1._activePoint then
		P:changeResource(Data.ResType.union_personal_power, arg_97_1._activePoint)
	end

	if arg_97_1._loseSkinCrystal then
		P._propBag:changeProps(Data.PropsId.skin_crystal, arg_97_1._loseSkinCrystal)
	end

	if arg_97_1._ladderChest then
		P._playerFindLadder:changeChest(arg_97_1._ladderChest)
	end

	if arg_97_1._clashExChest then
		P._playerFindSurvivalEx:changeChest(arg_97_1._clashExChest)
	end

	local var_97_11 = {}
	local var_97_12 = {}
	local var_97_13 = {}
	local var_97_14 = {}

	for iter_97_1, iter_97_2 in ipairs(arg_97_1._cards) do
		table.insert(var_97_11, iter_97_2._infoId)
		table.insert(var_97_12, iter_97_2._count)
		table.insert(var_97_13, iter_97_2._level)
		table.insert(var_97_14, iter_97_2._isFragment)
	end

	P:addResources(var_97_11, var_97_13, var_97_12, var_97_14)

	if arg_97_1._logPb then
		local var_97_15
		local var_97_16

		if arg_97_0._battleType == Data.BattleType.PVP_clash or arg_97_0._battleType == Data.BattleType.PVP_clash_npc or arg_97_0._isRankLadder then
			var_97_15 = Battle_pb.PB_BATTLE_WORLD_LADDER
		elseif arg_97_0._battleType == Data.BattleType.PVP_room then
			var_97_15 = Battle_pb.PB_BATTLE_MATCH
		elseif arg_97_0._battleType == Data.BattleType.PVP_dark then
			var_97_15 = Battle_pb.PB_BATTLE_DARK
		elseif arg_97_0._battleType == Data.BattleType.PVP_survival then
			var_97_15 = Battle_pb.PB_BATTLE_SURVIVAL
		elseif arg_97_0._battleType == Data.BattleType.PVP_survival then
			var_97_15 = Battle_pb.PB_BATTLE_SURVIVAL_EX
		else
			var_97_15 = Battle_pb.PB_BATTLE_PLAYER
			var_97_16 = true
		end

		local var_97_17 = require("Log").new(var_97_16, arg_97_1._logPb)

		P._playerLog:addLog(var_97_17, var_97_15)
		P._playerLog:sendLogDirty(require("PlayerLog").Event.attack_log_dirty)

		arg_97_1._log = var_97_17
	end

	if var_97_1 then
		local var_97_18 = arg_97_0._input._copyId

		if arg_97_0._battleType == Data.BattleType.task or arg_97_0._battleType == Data.BattleType.sweep then
			-- block empty
		elseif arg_97_0._battleType == Data.BattleType.PVP_clash or arg_97_0._battleType == Data.BattleType.PVP_clash_npc then
			-- block empty
		elseif arg_97_0._battleType == Data.BattleType.PVP_trophy or arg_97_0._battleType == Data.BattleType.npc or arg_97_0._battleType == Data.BattleType.PVP_revenge then
			-- block empty
		elseif arg_97_0._battleType == Data.BattleType.copy_elite or arg_97_0._battleType == Data.BattleType.copy_boss or arg_97_0._battleType == Data.BattleType.copy_commander then
			P:accountCopyWin(Data._copyInfo[var_97_18]._type)

			if not arg_97_0._player._hasHiredHero and arg_97_1._score > P._copyScore[var_97_18] then
				P._copyScore[var_97_18] = arg_97_1._score
			end
		elseif arg_97_0._battleType == Data.BattleType.copy_expedition then
			P:accountCopyWin(Data.CopyType.expedition)
		elseif arg_97_0._battleType == Data.BattleType.pvp_union then
			-- block empty
		end

		if var_97_18 and var_97_18 > 0 then
			P._copyPassTimes[var_97_18] = P._copyPassTimes[var_97_18] + 1
		end
	end

	if arg_97_0._battleType == Data.BattleType.boss then
		local var_97_19 = arg_97_0._input._opponent._bossId

		if var_97_19 >= 101 and var_97_19 <= 112 then
			P:accountCopyWin(Data.CopyType.boss)
		else
			P._dailyChallengeUBoss[var_97_19] = P._dailyChallengeUBoss[var_97_19] + 1
		end
	elseif arg_97_0._battleType == Data.BattleType.world_boss then
		P._dailyWorldBoss = P._dailyWorldBoss + 1

		if arg_97_1._score > P._worldBossScore then
			P._worldBossScore = arg_97_1._score
		end
	elseif arg_97_0._battleType == Data.BattleType.PVP_trophy then
		P._dailyCopyPvpTimes = P._dailyCopyPvpTimes + 1
	elseif var_97_9 then
		if var_97_0 == Data.BattleResult.win then
			if P._ladderContLose > 0 then
				P._dailyClashWin = 0
				P._ladderContWin = 0
			end

			P._pvpWinDaily = P._pvpWinDaily + 1
			P._dailyClashWin = P._dailyClashWin + 1
			P._ladderContWin = P._ladderContWin + 1
			P._ladderContLose = 0
		elseif var_97_0 == Data.BattleResult.lose then
			P._ladderContLose = P._ladderContLose + 1

			if P._ladderContLose > 1 then
				P._dailyClashWin = 0
				P._ladderContWin = 0
			end
		end
	elseif arg_97_0._battleType == Data.BattleType.PVP_ladder or arg_97_0._battleType == Data.BattleType.PVP_ladder_npc then
		if var_97_0 == Data.BattleResult.win then
			P._playerFindLadder._winCount = math.min(12, P._playerFindLadder._winCount + 1)

			P:changeLadderTrophy(Data._globalInfo._ladderExTrophy[P._playerFindLadder._winCount])
		elseif var_97_0 == Data.BattleResult.lose then
			if P._playerFindLadder._usedExtraLoseTimes == 0 and P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.arena_privilege_2) > 0 then
				P._playerFindLadder._usedExtraLoseTimes = 1
				P._playerFindLadder._isLoseSubed = true
			else
				P._playerFindLadder._loseCount = P._playerFindLadder._loseCount + 1
			end
		end
	elseif arg_97_0._battleType == Data.BattleType.PVP_clash_ex then
		if var_97_0 == Data.BattleResult.win then
			P._playerFindClashEx._winCount = math.min(12, P._playerFindClashEx._winCount + 1)
		else
			P._playerFindClashEx._loseCount = P._playerFindClashEx._loseCount + 1
		end
	end

	if arg_97_0._battleType == Data.BattleType.task then
		if var_97_1 then
			local var_97_20 = true

			for iter_97_3 = 1, #arg_97_1._taskResult do
				if not arg_97_1._taskResult[iter_97_3] then
					var_97_20 = false

					break
				end
			end

			if var_97_20 then
				local var_97_21 = arg_97_0._input._levelId
				local var_97_22 = math.floor(var_97_21 / 10000)
				local var_97_23 = var_97_21 + 1

				if Data._levelInfo[var_97_23] == nil then
					var_97_23 = (math.floor(var_97_21 / 100) + 1) * 100 + 1
				end

				P._playerWorld._curLevel[var_97_22] = math.max(P._playerWorld._curLevel[var_97_22], var_97_23)

				local var_97_24 = cc.EventCustom:new(Data.Event.chapter_level_dirty)

				var_97_24._levelId = var_97_21

				lc.Dispatcher:dispatchEvent(var_97_24)
			end
		end
	elseif arg_97_0._battleType == Data.BattleType.sweep and (not var_97_1 or true) then
		-- block empty
	elseif (arg_97_0._battleType == Data.BattleType.PVP_revenge or arg_97_0._battleType == Data.BattleType.npc) and var_97_1 then
		P._playerWorld._cities[arg_97_0._input._levelId]:captureSuccess()
		ClientData.sendWorldGetOpponent()
	end

	if arg_97_0._battleType == Data.BattleType.copy_expedition then
		local var_97_25 = arg_97_1._expeditionResult._player
		local var_97_26 = arg_97_1._expeditionResult._opponent

		for iter_97_4 = 1, #var_97_25 do
			local var_97_27 = var_97_25[iter_97_4]

			for iter_97_5 = 1, #var_97_27 do
				local var_97_28

				if iter_97_4 == 1 then
					if var_97_27[iter_97_5] < 0 then
						if P._playerUnion._hiredHero then
							P._playerUnion._hiredHero._isDead = true
						end
					else
						local var_97_29 = P._playerCard:setHeroDead(var_97_27[iter_97_5])
					end
				elseif iter_97_4 == 2 then
					-- block empty
				elseif iter_97_4 == 3 then
					-- block empty
				end
			end
		end

		if not var_97_1 then
			for iter_97_6 = 1, #var_97_26 do
				local var_97_30 = var_97_26[iter_97_6]

				for iter_97_7 = 1, #var_97_30 do
					if iter_97_6 == 1 then
						P._playerExpedition:setCardDead(P._playerExpedition._chapter + 1, var_97_30[iter_97_7], Data.CardType.monster)
					end
				end
			end
		end
	end
end

function var_0_0.initResource(arg_98_0, arg_98_1)
	if arg_98_1 == nil then
		arg_98_1 = {
			_exp = 0,
			_preRank = 0,
			_curRank = 0,
			_trophy = 0,
			_grain = 0,
			_ingot = 0,
			_gold = 0,
			_cards = {}
		}
		arg_98_1._resultType = arg_98_0._player:getResult()
		arg_98_0._result = arg_98_1
	end

	arg_98_1._preExp = 0
	arg_98_1._curExp = 0
	arg_98_1._exp = 0
	arg_98_1._preLevel = arg_98_0._player._level > 0 and arg_98_0._player._level or 1
	arg_98_1._curLevel = arg_98_0._player._level > 0 and arg_98_0._player._level or 1

	return arg_98_1
end

function var_0_0.onBattleEnd(arg_99_0, arg_99_1)
	ClientView.getActiveIndicator():hide()

	local var_99_0 = arg_99_1.resource or {}
	local var_99_1

	if arg_99_1:HasField("log") then
		var_99_1 = arg_99_1.log
	end

	local var_99_2 = {
		_ingot = 0,
		_exp = 0,
		_gold = 0,
		_grain = 0,
		_timestamp = arg_99_1.timestamp,
		_trophy = arg_99_1.trophy,
		_preRank = arg_99_1.rank1,
		_curRank = arg_99_1.rank2,
		_cards = {},
		_logPb = var_99_1,
		_levelId = arg_99_1.city
	}

	for iter_99_0 = 1, #var_99_0 do
		local var_99_3 = var_99_0[iter_99_0]

		print("+++++++++++++++resoure", var_99_3.info_id, var_99_3.num)

		if var_99_3.info_id == Data.ResType.gold then
			var_99_2._gold = (var_99_2._gold or 0) + var_99_3.num
		elseif var_99_3.info_id == Data.ResType.grain then
			var_99_2._grain = var_99_3.num
		elseif var_99_3.info_id == Data.ResType.ingot then
			var_99_2._ingot = var_99_3.num
		elseif var_99_3.info_id == Data.ResType.exp or var_99_3.info_id == Data.ResType.character_exp then
			var_99_2._exp = var_99_3.num
		elseif var_99_3.info_id == Data.ResType.union_personal_power then
			var_99_2._activePoint = var_99_3.num
		elseif var_99_3.info_id == Data.ResType.union_battle_trophy then
			var_99_2._unionBattleTrophy = var_99_3.num
		elseif var_99_3.info_id == Data.ResType.dark_trophy then
			var_99_2._darkTrophy = var_99_3.num
		elseif var_99_3.info_id == Data.ResType.clash_ex_trophy then
			var_99_2._clashExTrophy = var_99_3.num
		elseif var_99_3.info_id == Data.PropsId.skin_crystal and var_99_3.num < 0 then
			var_99_2._loseSkinCrystal = var_99_3.num
		elseif var_99_3.info_id == Data.PropsId.yubi then
			var_99_2._yubi = var_99_3.num
		elseif var_99_3.info_id == Data.ResType.new_server_score then
			var_99_2._newServerScore = var_99_3.num
		elseif var_99_3.info_id == Data.ResType.trophy_activity then
			var_99_2.trophy_activity = var_99_3.num
		elseif var_99_3.info_id == Data.ResType.rank1 then
			var_99_2.trophy_activity = var_99_3.num
		elseif var_99_3.info_id == Data.ResType.survival_ex_trophy then
			var_99_2.survival_ex_trophy = var_99_3.num
		elseif var_99_3.info_id >= Data.PropsId.ladder_chest and var_99_3.info_id <= Data.PropsId.ladder_chest_end then
			var_99_2._ladderChest = var_99_3.info_id
		elseif var_99_3.info_id >= Data.PropsId.clash_ex_chest and var_99_3.info_id <= Data.PropsId.clash_ex_chest_end then
			var_99_2._clashExChest = var_99_3.info_id
		else
			table.insert(var_99_2._cards, {
				_infoId = var_99_3.info_id,
				_count = var_99_3.num,
				_isFragment = var_99_3.is_fragment,
				_level = var_99_3.level
			})

			if var_99_3.info_id == Data.PropsId.flag then
				var_99_2._flag = var_99_3.num
			end
		end
	end

	var_99_2._resultType = arg_99_1.type
	var_99_2._taskResult = arg_99_1.task_result
	var_99_2._expeditionResult = {
		_player = {
			arg_99_1.atk_expend.hero,
			arg_99_1.atk_expend.horse,
			arg_99_1.atk_expend.book
		},
		_opponent = {
			arg_99_1.def_expend.hero,
			arg_99_1.def_expend.horse,
			arg_99_1.def_expend.book
		}
	}
	var_99_2._bossResult = {
		_damage = arg_99_1.boss.damage,
		_hp = arg_99_1.boss.hp,
		_damageGold = var_99_2._gold - arg_99_1.boss.extra_gold,
		_killGold = arg_99_1.boss.extra_gold
	}
	var_99_2._score = arg_99_0._player._damageScore[PlayerBattle.KEY_TOTAL]

	if arg_99_1:HasField("score") then
		var_99_2._score = arg_99_1.score
	end

	var_99_2._battleType = arg_99_0._battleType
	var_99_2._player = arg_99_0._player
	var_99_2._opponent = arg_99_0._opponent

	if arg_99_1:HasField("param") then
		var_99_2._propId = arg_99_1.param
	end

	arg_99_0:hideWaitting()

	if arg_99_0._baseBattleType == Data.BattleType.base_PVP and arg_99_0._battleType ~= Data.BattleType.PVP_friend or arg_99_0._baseBattleType == Data.BattleType.base_PVE then
		arg_99_0:changeResource(var_99_2)
	else
		arg_99_0:initResource(var_99_2)
	end

	arg_99_0._player:genResult(var_99_2._resultType)

	arg_99_0._result = var_99_2

	arg_99_0:showResult()
end

function var_0_0.checkUnlockModule(arg_100_0)
	if arg_100_0._isTesting then
		return
	end

	local var_100_0 = P._level
	local var_100_1 = lc.readConfig(ClientData.ConfigKey.lock_level_battle, var_100_0)
	local var_100_2 = {}

	if var_100_1 < Data._globalInfo._2xSpeedLevel and var_100_0 >= Data._globalInfo._2xSpeedLevel then
		table.insert(var_100_2, Str(STR.BATTLE_SPEED_2X) .. Str(STR.UNLOCKED))
		lc.writeConfig(ClientData.ConfigKey.lock_level_battle, var_100_0)
	elseif var_100_0 < Data._globalInfo._2xSpeedLevel then
		local var_100_3 = P._vip

		if lc.readConfig(ClientData.ConfigKey.lock_level_vip, var_100_3) < Data._globalInfo._2xSpeedVip and var_100_3 >= Data._globalInfo._2xSpeedVip then
			table.insert(var_100_2, Str(STR.BATTLE_SPEED_2X) .. Str(STR.UNLOCKED))
			lc.writeConfig(ClientData.ConfigKey.lock_level_vip, var_100_3)
		end
	end

	if #var_100_2 > 0 then
		ToastManager.pushArray(var_100_2)
	end
end

function var_0_0.isGuideWorldBattle(arg_101_0, arg_101_1)
	return arg_101_0._battleType == Data.BattleType.task and GuideManager.isGuideEnabled() and (arg_101_1 and arg_101_0._input._levelId == arg_101_1 or arg_101_1 == nil and arg_101_0._input._levelId <= 10101)
end

function var_0_0.oppoTryUseCard(arg_102_0)
	if #ClientData._usedCardsToAdd > 0 then
		local var_102_0 = B.parseOperations(arg_102_0._opponent._isAttacker, ClientData._usedCardsToAdd, false)

		arg_102_0._opponent:setFromOps(var_102_0)

		for iter_102_0 = 1, #var_102_0 do
			if var_102_0[iter_102_0]._card == BattleData.UseCardId.round and arg_102_0._opponent._playerType == BattleData.PlayerType.enviroment then
				-- block empty
			else
				table.insert(arg_102_0._opponent._ops, var_102_0[iter_102_0])
			end
		end

		ClientData._usedCardsToAdd = {}
	end

	if arg_102_0._opponent._replayIndex > #arg_102_0._opponent._ops then
		return false
	end

	if arg_102_0._opponent._ops[arg_102_0._opponent._replayIndex]._card == BattleData.UseCardId.retreat then
		arg_102_0:hideThinking()
		arg_102_0:retreat(arg_102_0._opponent)

		return true
	end

	if arg_102_0._isWaitting == false then
		return false
	end

	arg_102_0._isWaitting = false

	arg_102_0:hideThinking()
	arg_102_0._opponent:use()

	return true
end

function var_0_0.observeTryUseCard(arg_103_0)
	if not ClientData._observeUsedCards then
		ClientData._observeUsedCards = {}
	end

	if #ClientData._observeUsedCards > 0 then
		local var_103_0 = B.parseOperations(arg_103_0._player._isAttacker, ClientData._observeUsedCards, false)

		arg_103_0._player:setFromOps(var_103_0)

		for iter_103_0 = 1, #var_103_0 do
			table.insert(arg_103_0._player._ops, var_103_0[iter_103_0])
		end

		ClientData._observeUsedCards = {}
	end

	if arg_103_0._player._replayIndex > #arg_103_0._player._ops then
		return false
	end

	if arg_103_0._player._ops[arg_103_0._player._replayIndex]._card == BattleData.UseCardId.retreat then
		arg_103_0:hideThinking()
		arg_103_0:retreat(arg_103_0._player)

		return true
	end

	arg_103_0._isWaitting = false

	arg_103_0:hideThinking()
	arg_103_0._player:use()

	return true
end

function var_0_0.updateScoreDamage(arg_104_0)
	if arg_104_0._scoreSchedulerID ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_104_0._scoreSchedulerID)
	end

	local var_104_0 = 0.05
	local var_104_1 = arg_104_0._player._damageScore[PlayerBattle.KEY_TOTAL]
	local var_104_2 = arg_104_0._score._label
	local var_104_3 = arg_104_0._score._ico

	arg_104_0._scoreSchedulerID = lc.Scheduler:scheduleScriptFunc(function(arg_105_0)
		local var_105_0 = true

		if var_104_1 ~= var_104_2._value and var_104_2._value ~= nil then
			var_105_0 = false

			local var_105_1 = (var_104_1 - var_104_2._value) / 2

			if var_105_1 > 0 then
				var_105_1 = math.ceil(var_105_1)
			else
				var_105_1 = math.floor(var_105_1)
			end

			var_104_2._value = var_104_2._value + var_105_1

			if (var_104_1 - var_104_2._value) * var_105_1 < 0 then
				var_104_2._value = var_104_1
			end

			var_104_2:setString(ClientData.formatNum(var_104_2._value, 9999999))

			if var_104_2:getNumberOfRunningActions() == 0 then
				local var_105_2 = cc.EaseSineInOut:create(cc.ScaleBy:create(0.1, 1.2))

				var_104_2:runAction(cc.Sequence:create(var_105_2, var_105_2:reverse()))
			end

			if var_104_3:getNumberOfRunningActions() == 0 then
				local var_105_3 = cc.EaseSineInOut:create(cc.ScaleBy:create(0.1, 1.2))

				var_104_3:runAction(cc.Sequence:create(var_105_3, var_105_3:reverse()))
			end
		end

		if var_105_0 and arg_104_0._scoreSchedulerID ~= nil then
			lc.Scheduler:unscheduleScriptEntry(arg_104_0._scoreSchedulerID)

			arg_104_0._scoreSchedulerID = nil
		end
	end, var_104_0, false)
end

function var_0_0.setBtnAuto(arg_106_0, arg_106_1)
	arg_106_0._btnAuto._title:setString(Str(arg_106_1 and STR.MANUAL or STR.AUTO))
	arg_106_0._btnAuto._icon:setSpriteFrame(arg_106_1 and "bat_btn_icon_auto" or "bat_btn_icon_manual")
end

function var_0_0.pvpTimingWhenRoundBegin(arg_107_0, arg_107_1)

	arg_107_0:stopPvpTiming()
	arg_107_0:removePvpTimingRope()

	arg_107_0._isPvpTimeout = false
	arg_107_0._pvpPlayer = arg_107_1
	arg_107_0._roundRealStartTime = os.time()
	arg_107_0._roundDuration = 90

	local var_107_0 = ClientData.getCurrentTime()

	-- 90s action duration for each player turn per user request
	ClientData._battleRoundStartInfo = {
		_round = (ClientData._battleRoundStartInfo and ClientData._battleRoundStartInfo._round or 0) + 1,
		_isAttacker = arg_107_1 == arg_107_0._player,
		_beginTime = var_107_0,
		_endTime = var_107_0 + 90
	}

	local var_107_1 = 90
	local var_107_2 = 0

	local var_107_3 = arg_107_0._player == arg_107_1 and arg_107_0._playerUi or arg_107_0._opponentUi
	local var_107_4 = var_107_3._opponentUi

	if var_107_3._survivalCountDown then
		var_107_3._survivalCountDown.startCountDown()
	end

	if var_107_4._survivalCountDown then
		var_107_4._survivalCountDown.update(ClientData.getCurrentTime())
		var_107_4._survivalCountDown:stopAllActions()
	end

	arg_107_0:startPvpTiming()
end

function var_0_0.addPvpRoundSeconds(arg_108_0, arg_108_1, arg_108_2)
	local delta = tonumber(arg_108_1) or 5
	local maxTime = tonumber(arg_108_2) or 120
	if arg_108_0._roundRealStartTime then
		local curNow = os.time()
		local totalDur = arg_108_0._roundDuration or 90
		local curRemaining = totalDur - (curNow - arg_108_0._roundRealStartTime)
		local newRemaining = math.min(maxTime, curRemaining + delta)
		arg_108_0._roundRealStartTime = curNow - (totalDur - newRemaining)
		if ClientData._battleRoundStartInfo and ClientData._battleRoundStartInfo._beginTime then
			ClientData._battleRoundStartInfo._endTime = ClientData._battleRoundStartInfo._beginTime + newRemaining
		end
		arg_108_0:updateRoundTimer(newRemaining)
	end
end

function var_0_0.syncPvpRoundSeconds(arg_108_0, arg_108_1)
	local newRemaining = math.min(120, math.max(0, tonumber(arg_108_1) or 0))
	if arg_108_0._roundRealStartTime and newRemaining > 0 then
		local curNow = os.time()
		local totalDur = arg_108_0._roundDuration or 90
		arg_108_0._roundRealStartTime = curNow - (totalDur - newRemaining)
		if ClientData._battleRoundStartInfo and ClientData._battleRoundStartInfo._beginTime then
			ClientData._battleRoundStartInfo._endTime = ClientData._battleRoundStartInfo._beginTime + newRemaining
		end
		arg_108_0:updateRoundTimer(newRemaining)
	end
end

function var_0_0.startPvpTiming(arg_108_0)
	if arg_108_0._roundRealStartTime == nil then
		arg_108_0._roundRealStartTime = os.time()
	end
	if arg_108_0._roundDuration == nil then
		arg_108_0._roundDuration = 90
	end
	arg_108_0._pvpTimingScheduler = lc.Scheduler:scheduleScriptFunc(function(arg_109_0)
		-- Strictly unscaled real wall-clock countdown (90s base, plus delta per action)
		local curNow = os.time()
		local totalDur = arg_108_0._roundDuration or 90
		local elapsed = curNow - (arg_108_0._roundRealStartTime or curNow)
		local var_109_0 = math.max(0, totalDur - elapsed)

		arg_108_0:updateRoundTimer(var_109_0)

		if var_109_0 <= 0 then
			arg_108_0:stopPvpTiming()
			arg_108_0:removePvpTimingRope()
			arg_108_0:pvpTimeout()

			return
		end

		if var_109_0 <= var_0_0.PVP_ROPE_DURATION then
			arg_108_0:showPvpTimingRope()
			arg_108_0:updatePvpTimingRope(var_109_0)
		else
			arg_108_0:removePvpTimingRope()
		end
	end, 0.1, false)
end

function var_0_0.stopPvpTiming(arg_110_0)
	if arg_110_0._pvpTimingScheduler ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_110_0._pvpTimingScheduler)

		arg_110_0._pvpTimingScheduler = nil
	end
end

function var_0_0.showPvpTimingRope(arg_111_0)
	if arg_111_0._pvpTimingRope then
		return
	end

	local var_111_0 = arg_111_0._pRoundLabel:getParent()
	local var_111_1 = ccui.LoadingBar:create()

	var_111_1:loadTexture("bat_scene_wick_rope", ccui.TextureResType.plistType)
	var_111_1:setDirection(ccui.LoadingBarDirection.RIGHT)
	var_111_1:setPosition(lc.cw(arg_111_0) - 26, lc.ch(arg_111_0))
	var_111_1:setPercent(100)
	arg_111_0:addChild(var_111_1)

	arg_111_0._pvpTimingRope = var_111_1

	local var_111_2 = lc.createSprite("bat_scene_wick_bg")

	lc.addChildToCenter(var_111_1, var_111_2, -1)
	arg_111_0._scene:seenByCamera3D(var_111_1)
end

function var_0_0.updatePvpTimingRope(arg_112_0, arg_112_1)
	if arg_112_0._pvpTimingRope == nil then
		return
	end

	local var_112_0 = arg_112_0._pvpTimingRope
	local var_112_1 = var_112_0:getContentSize().width
	local var_112_2 = var_112_0:getContentSize().height / 2 + 4
	local var_112_3 = var_0_0.PVP_ROPE_DURATION
	local var_112_4 = var_112_0:getPercent()

	var_112_0:stopAllActions()

	local var_112_5 = math.ceil(arg_112_1 / var_112_3 * 100)

	var_112_0:setPercent(var_112_5)
end

function var_0_0.removePvpTimingRope(arg_113_0)
	if arg_113_0._pvpTimingRope ~= nil then
		arg_113_0._pvpTimingRope:removeFromParent()

		arg_113_0._pvpTimingRope = nil
	end
end

function var_0_0.updateRoundTimer(arg_114_0, arg_114_1)
	local var_114_0 = arg_114_0._player:getActionPlayer()
	local var_114_1 = arg_114_0._playerUi._player == var_114_0 and arg_114_0._playerUi or arg_114_0._opponentUi

	if var_114_1._opponentUi._roundTimerBg then
		var_114_1._opponentUi._roundTimerBg:setVisible(false)
	end

	local var_114_2 = 90
	if ClientData._battleRoundStartInfo and ClientData._battleRoundStartInfo._endTime and ClientData._battleRoundStartInfo._beginTime then
		var_114_2 = math.max(1, ClientData._battleRoundStartInfo._endTime - ClientData._battleRoundStartInfo._beginTime)
	end
	local var_114_3 = math.max(0, arg_114_1)

	if not var_114_1._roundTimerBg then
		return
	end

	if arg_114_1 <= 0 then
		return var_114_1._roundTimerBg:setVisible(false)
	end

	var_114_1._roundTimerBg:setVisible(true)
	var_114_1._roundTimer2:setVisible(arg_114_1 > var_0_0.PVP_ROPE_DURATION)
	var_114_1._roundTimer3:setVisible(arg_114_1 <= var_0_0.PVP_ROPE_DURATION)
	var_114_1._roundTimerLabel:setString(math.max(0, math.ceil(arg_114_1)))

	if ClientData._cfg and ClientData._cfg.isTest then
		var_114_1._roundTimerLabel:setScale(0.5)

		var_114_1._roundTimerLabel:setString(string.format("%d", math.max(0, math.ceil(arg_114_1))))
	end

	local var_114_4 = var_114_3 / var_114_2 * 100

	var_114_1._roundTimer:setPercentage(var_114_4)

	local var_114_5 = math.min(100, math.max(0, arg_114_1 / 90 * 100))

	var_114_1._roundTimer2:setPercentage(var_114_5)
	var_114_1._roundTimer3:setPercentage(var_114_5)
end

function var_0_0.pvpTimeout(arg_115_0)
	arg_115_0:removePvpTimingRope()
	arg_115_0:stopPvpTiming()

	local var_115_0 = arg_115_0._player._isAttacker and arg_115_0._player or arg_115_0._opponent
	local isLocalTurn = (arg_115_0._pvpPlayer == (arg_115_0._isAttacker and var_115_0 or var_115_0._opponent))

	if isLocalTurn then
		arg_115_0._isPvpTimeout = true
		arg_115_0._timeOutTimes = (arg_115_0._timeOutTimes or 0) + 1
		arg_115_0._isAddingBoardCard = false
		if arg_115_0._btnEndRound then
			arg_115_0._btnEndRound:setTouchEnabled(false)
		end
		arg_115_0:useRoundEnd()
	elseif not arg_115_0._isObserver then
		if arg_115_0._opponent then
			local roundOp = {
				_card = BattleData.UseCardId.round,
				_target = 0,
				_choice = -1,
				_round = arg_115_0._opponent._round or 1,
				_time = math.floor(ClientData.getCurrentTime() or os.time())
			}
			table.insert(arg_115_0._opponent._ops, roundOp)
			arg_115_0._isWaitting = false
			arg_115_0:hideThinking()
			arg_115_0._opponent:use()
		end
	end
end

function var_0_0.prepareAction(arg_116_0, arg_116_1, arg_116_2)
	local var_116_0 = arg_116_1 == arg_116_0._playerUi._player and arg_116_0._playerUi or arg_116_0._opponentUi
	local var_116_1 = arg_116_2._saved._monsterTarget or arg_116_2._saved._magicTarget or arg_116_2._atkTarget
	local var_116_2 = arg_116_0._playerUi:getCardSprite(arg_116_2) or arg_116_0._opponentUi:getCardSprite(arg_116_2)

	if not var_116_1 or not var_116_2 then
		return 0
	end

	var_116_2:updatePositiveStatus()

	if var_116_0._isController and arg_116_1._playerType == BattleData.PlayerType.player then
		return 0
	end

	local var_116_3 = arg_116_0._playerUi:getCardSprite(var_116_1) or arg_116_0._opponentUi:getCardSprite(var_116_1)
	local var_116_4 = cc.p(arg_116_0._layer:convertToNodeSpace(var_116_2:convertToWorldSpace(cc.p(0, 0))))
	local var_116_5

	if var_116_3 then
		var_116_5 = cc.p(arg_116_0._layer:convertToNodeSpace(var_116_3:convertToWorldSpace(cc.p(0, 0))))
	elseif not arg_116_0._isReverse then
		var_116_5 = cc.p(arg_116_0._layer:convertToNodeSpace(var_116_0._isController and PlayerUi.Pos.defender_fortress or PlayerUi.Pos.attacker_fortress))
	else
		var_116_5 = cc.p(arg_116_0._layer:convertToNodeSpace(var_116_0._isController and PlayerUi.Pos.attacker_fortress or PlayerUi.Pos.defender_fortress))
	end

	local var_116_6 = BattleLine.create(var_116_4)

	arg_116_0._layer:addChild(var_116_6)
	var_116_6:directTo(var_116_5, nil)
	var_116_6:resetToPos(lc.h(var_116_6) - 250)

	var_116_6._isAnimation = true

	local var_116_7 = 0.8

	var_116_6:runAction(lc.sequence(lc.delay(var_116_7), lc.remove()))

	return var_116_7
end

function var_0_0.defAction(arg_117_0, arg_117_1, arg_117_2)
	if arg_117_1 ~= arg_117_0._playerUi._player or not arg_117_0._playerUi then
		local var_117_0 = arg_117_0._opponentUi
	end

	local var_117_1 = arg_117_0._playerUi:getCardSprite(arg_117_2) or arg_117_0._opponentUi:getCardSprite(arg_117_2)

	if not var_117_1 then
		return 0
	end

	var_117_1:updateBoardActive()
	var_117_1:updatePositiveStatus()

	return 0.2
end

function var_0_0.openVS(arg_118_0)
	ClientData._battleScene:playBgMusic()

	if arg_118_0._scene._screenShot ~= nil then
		arg_118_0._scene._screenShot:setVisible(false)

		arg_118_0._scene._screenShot = nil
	end

	if not arg_118_0._vsBones then
		return
	end

	local var_118_0 = arg_118_0._vsBones:getAnimationDuration("effect2")

	arg_118_0._vsBones:gotoAndPlay("effect2")
	arg_118_0._vsBones:runAction(lc.sequence(var_118_0, function()
		arg_118_0._vsBones:removeFromParent()
		ClientData.unloadDragonBones("vs")

		arg_118_0._vsBones = nil
	end))
end

function var_0_0.playVideo(arg_120_0)
	arg_120_0._playVideo = true

	lc.Audio.stopAudio(AUDIO.M_BATTLE)

	local var_120_0 = require("VideoScene").create()

	lc.pushScene(var_120_0)
end

function var_0_0.resetBattle(arg_121_0)
	PlayerBattle._randomSeed = PlayerBattle._originRandomSeed

	if arg_121_0._player._isAttacker then
		arg_121_0._player:resetWhenBattleStart()
		arg_121_0._opponent:resetWhenBattleStart()
	else
		arg_121_0._opponent:resetWhenBattleStart()
		arg_121_0._player:resetWhenBattleStart()
	end
end

function var_0_0.loadUnitTestFile(arg_122_0, arg_122_1)
	local var_122_0 = lc.readFile(arg_122_1)

	arg_122_0:loadYgoContent(var_122_0)
end

function var_0_0.loadYgoContent(arg_123_0, arg_123_1)
	arg_123_0._player._playerType = BattleData.PlayerType.player
	arg_123_0._player._unitTestData = json.decode(arg_123_1)

	arg_123_0._playerUi:efcFortressDieRemove()
	arg_123_0._opponentUi:efcFortressDieRemove()
	arg_123_0:resetBattle()
	arg_123_0._playerUi:resetWhenBattleStart()
	arg_123_0._opponentUi:resetWhenBattleStart()
	arg_123_0:resetWhenBattleStart()
	arg_123_0:setBattleSpeed()
	arg_123_0:forwardToRound(false, 1)

	if arg_123_0._testMaskLayer then
		arg_123_0._testMaskLayer:setVisible(true)
	end

	if BattleTestData._curOpType ~= BattleTestData.OperationType._batch then
		arg_123_0:setLoadRelativeButtonsVisbile(true)
	end
end

function var_0_0.setLoadRelativeButtonsVisbile(arg_124_0, arg_124_1)
	if arg_124_0._battleType == Data.BattleType.unittest then
		arg_124_0._btnRunFree:setVisible(arg_124_1)
		arg_124_0._btnExport:setVisible(arg_124_1)
		arg_124_0._btnRunTest:setVisible(arg_124_1)
	end
end

function var_0_0.startBatchSingle(arg_125_0)
	ClientData._battleDebugLog = ""

	arg_125_0._testOkProgressBar._bar:setPercent(BattleTestData._batch._okCount * 100 / BattleTestData._batch._batchCount)
	arg_125_0._testOkProgressBar:setLabel(BattleTestData._batch._okCount, BattleTestData._batch._batchCount)
	arg_125_0._testErrorProgressBar._bar:setPercent(BattleTestData._batch._errorCount * 100 / BattleTestData._batch._batchCount)
	arg_125_0._testErrorProgressBar:setLabel(BattleTestData._batch._errorCount, BattleTestData._batch._batchCount)

	if BattleTestData._batch._filenames then
		BattleTestData._curOpType = BattleTestData.OperationType._batch
		BattleTestData._singleFileName = BattleTestData._batch._filenames[BattleTestData._batch._curBatch]

		local var_125_0 = string.reverse(BattleTestData._singleFileName)
		local var_125_1 = string.find(var_125_0, "\\")
		local var_125_2 = string.sub(BattleTestData._singleFileName, #BattleTestData._singleFileName - var_125_1 + 2, #BattleTestData._singleFileName)
		local var_125_3 = string.sub(var_125_2, 1, 5) .. "_" .. string.sub(var_125_2, #var_125_2 - 8, #var_125_2)

		lc.log("[UNITTEST BATCH] " .. var_125_3)
		arg_125_0:loadUnitTestFile(BattleTestData._singleFileName)
		arg_125_0._testMaskLayer:setVisible(false)

		arg_125_0._player._playerType = BattleData.PlayerType.enviroment

		arg_125_0:runAction(lc.sequence(0, function()
			arg_125_0._player:step()
		end))
	end
end

function var_0_0.onExportUnitTestData(arg_127_0)
	local var_127_0 = BattleTestData._singleFileName

	if ClientData._unitTestFile == BattleTestData.DEFAULT_FILE then
		local var_127_1 = lc.App:getSaveFileName()

		BattleTestData._singleFileName = var_127_1

		if var_127_1 ~= nil and var_127_1 ~= "" then
			ClientData._unitTestFile = nil

			local var_127_2 = lc.readFile(BattleTestData.DEFAULT_FILE)

			lc.writeFile(BattleTestData._singleFileName, var_127_2)
		end
	end

	if BattleTestData._singleFileName ~= nil and BattleTestData._singleFileName ~= "" and BattleTestData._singleFileName ~= BattleTestData.DEFAULT_FILE then
		BattleTestData.exportToBattleLog()
		BattleTestData.exportUsedCards()
		ToastManager.push(Str(STR.EXPORT) .. Str(STR.SUCCESS))

		return
	end

	BattleTestData._singleFileName = var_127_0
end

function var_0_0.createTestProgress(arg_128_0)
	if arg_128_0._testOkProgressBar then
		return
	end

	local var_128_0 = ClientView.createLabelProgressBar(300)

	lc.addChildToPos(arg_128_0._scene, var_128_0, cc.p(ClientView.SCR_CW, lc.top(arg_128_0._btnRunTest) - lc.h(arg_128_0._btnRunFree) / 4), 50)

	arg_128_0._testOkProgressBar = var_128_0

	arg_128_0._testOkProgressBar._bar:setColor(lc.Color3B.green)
	arg_128_0._testOkProgressBar:setVisible(false)

	local var_128_1 = ClientView.createLabelProgressBar(300)

	lc.addChildToPos(arg_128_0._scene, var_128_1, cc.p(ClientView.SCR_CW, lc.top(arg_128_0._btnRunTest) - 3 * lc.h(arg_128_0._btnRunFree) / 4), 50)

	arg_128_0._testErrorProgressBar = var_128_1

	arg_128_0._testErrorProgressBar._bar:setColor(lc.Color3B.red)
	arg_128_0._testErrorProgressBar:setVisible(false)
end

function var_0_0.showTestProgress(arg_129_0)
	arg_129_0._testOkProgressBar:setVisible(true)
	arg_129_0._testErrorProgressBar:setVisible(true)
end

function var_0_0.hideTestProgress(arg_130_0)
	BattleTestData.resetBatch()
	arg_130_0._testOkProgressBar._bar:setPercent(0)
	arg_130_0._testOkProgressBar:setLabel(0, 0)
	arg_130_0._testOkProgressBar:setVisible(false)
	arg_130_0._testErrorProgressBar._bar:setPercent(0)
	arg_130_0._testErrorProgressBar:setLabel(0, 0)
	arg_130_0._testErrorProgressBar:setVisible(false)
end

function var_0_0.parseFileList(arg_131_0, arg_131_1, arg_131_2, arg_131_3)
	local var_131_0 = {}
	local var_131_1 = false

	if arg_131_1 ~= nil and type(arg_131_1) == "string" then
		local var_131_2 = arg_131_0:splitString(arg_131_1, "\n")

		if #var_131_2 > 0 then
			for iter_131_0 = 1, #var_131_2 do
				local var_131_3 = var_131_2[iter_131_0]
				local var_131_4 = string.reverse(var_131_3)
				local var_131_5 = string.find(var_131_4, " ")

				if var_131_5 then
					local var_131_6 = string.sub(var_131_3, #var_131_3 - var_131_5 + 2)

					if string.find(var_131_6, ".ygo") and var_131_6 ~= "DEFAULT_TEST_CARDS.ygo" then
						if var_131_6 == arg_131_3 then
							var_131_1 = true
						end

						if var_131_1 then
							table.insert(var_131_0, arg_131_2 .. var_131_6)
						end
					end
				end
			end
		end
	end

	return var_131_0
end

function var_0_0.splitString(arg_132_0, arg_132_1, arg_132_2)
	local var_132_0 = {}

	while true do
		local var_132_1 = string.find(arg_132_1, arg_132_2)

		if var_132_1 then
			local var_132_2 = string.sub(arg_132_1, 1, var_132_1 - 1)

			table.insert(var_132_0, var_132_2)

			arg_132_1 = string.sub(arg_132_1, var_132_1 + 1)
		else
			break
		end
	end

	return var_132_0
end

function var_0_0.preloadEffects(arg_133_0, arg_133_1)
	for iter_133_0 = 1, 2 do
		local var_133_0 = iter_133_0 == 1 and arg_133_0._player or arg_133_0._opponent

		for iter_133_1, iter_133_2 in ipairs(var_133_0._troopSkins) do
			local var_133_1 = iter_133_2.effect_ids

			for iter_133_3, iter_133_4 in ipairs(var_133_1) do
				local var_133_2 = Data._skinInfo[iter_133_4]

				if var_133_2 and var_133_2._isHide == 0 and var_133_2._type > 0 then
					local var_133_3 = string.split(var_133_2._effect, "|")

					for iter_133_5, iter_133_6 in ipairs(var_133_3) do
						if #iter_133_6 > 1 and iter_133_6[#iter_133_6 - 1] == "1" and (not ClientData._dragonBonesTexture[iter_133_6] or ClientData._dragonBonesTexture[iter_133_6] == 0) then
							if arg_133_1 then
								local var_133_4 = DragonBones.create(iter_133_6)

								ClientData._dragonBonesTexture[iter_133_6] = (ClientData._dragonBonesTexture[iter_133_6] or 0) + 1
							else
								ClientData.unloadDragonBones(iter_133_6)
							end
						end
					end
				end
			end
		end
	end
end

return var_0_0
