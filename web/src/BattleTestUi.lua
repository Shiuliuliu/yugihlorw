local var_0_0 = class("BattleTestUi", function()
	return cc.Node:create()
end)

BattleTestUi = var_0_0
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
var_0_0.TouchTarget = {
	opponent_grave = 11,
	player_leave = 5,
	opponent_rare = 12,
	opponent_hand = 13,
	player_pile = 4,
	opponent_pile = 14,
	opponent_leave = 15,
	player_hand = 3,
	player_rare = 2,
	player_grave = 1
}

local var_0_1 = ClientView.SCR_H / 768

var_0_0.POS = {
	BTN_PLAYER_GRAVE = {
		X = ClientView.SCR_CW - 542 * var_0_1,
		Y = ClientView.SCR_CH - 59 * var_0_1
	},
	BTN_PLAYER_LEAVE = {
		X = ClientView.SCR_CW - 610 * var_0_1,
		Y = ClientView.SCR_CH - 59 * var_0_1
	},
	BTN_PLAYER_RARE = {
		X = ClientView.SCR_CW - 542 * var_0_1,
		Y = ClientView.SCR_CH - 169 * var_0_1
	},
	BTN_OPPONENT_GRAVE = {
		X = ClientView.SCR_CW - 542 * var_0_1,
		Y = ClientView.SCR_CH + 59 * var_0_1
	},
	BTN_OPPONENT_LEAVE = {
		X = ClientView.SCR_CW - 610 * var_0_1,
		Y = ClientView.SCR_CH + 59 * var_0_1
	},
	BTN_OPPONENT_RARE = {
		X = ClientView.SCR_CW - 542 * var_0_1,
		Y = ClientView.SCR_CH + 169 * var_0_1
	},
	BTN_PLAYER_ADD_HAND_CARD = {
		X = ClientView.SCR_CW + 596 * var_0_1,
		Y = ClientView.SCR_CH - 51 * var_0_1
	},
	BTN_OPPONENT_ADD_HAND_CARD = {
		X = ClientView.SCR_CW + 596 * var_0_1,
		Y = ClientView.SCR_CH + 61 * var_0_1
	},
	BTN_PLAYER_EDIT_HAND_CARD = {
		X = ClientView.SCR_CW + 596 * var_0_1,
		Y = ClientView.SCR_CH - 120 * var_0_1
	},
	BTN_OPPONENT_EDIT_HAND_CARD = {
		X = ClientView.SCR_CW + 596 * var_0_1,
		Y = ClientView.SCR_CH + 130 * var_0_1
	}
}

function var_0_0.create(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.new()

	var_2_0:init(arg_2_0, arg_2_1)
	var_2_0:setScale(0.8)
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

function var_0_0.init(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._scene = arg_4_1

	arg_4_0:setContentSize(ClientView.SCR_SIZE)
	arg_4_0:setAnchorPoint(cc.p(0.5, 0.5))

	local var_4_0 = math.min(math.max(16, math.floor(ClientView.SCR_W / 64)), 21)

	arg_4_0._scale = 1
	arg_4_0._offsetY = 0

	arg_4_0:setPosition(cc.p(ClientView.SCR_CW, ClientView.SCR_CH))

	arg_4_0._audioEngine = BattleAudio.new(arg_4_0)
	arg_4_0._nameTag = arg_4_2

	arg_4_0:initData()
	arg_4_0:initBackground()
	arg_4_0:initUiControl()

	arg_4_0._playerUi = PlayerUi.new(arg_4_0, arg_4_0._player, arg_4_0._sceneType, arg_4_0._input._player._cardBackId)
	arg_4_0._opponentUi = PlayerUi.new(arg_4_0, arg_4_0._opponent, arg_4_0._sceneType, arg_4_0._input._opponent._cardBackId)
	arg_4_0._playerUi._opponentUi = arg_4_0._opponentUi
	arg_4_0._opponentUi._opponentUi = arg_4_0._playerUi

	arg_4_0._playerUi:resetWhenBattleStart()
	arg_4_0._opponentUi:resetWhenBattleStart()
	arg_4_0._scene:seenByCamera3D(arg_4_0)

	return true
end

function var_0_0.onEnter(arg_5_0)
	local var_5_0 = cc.EventListenerTouchOneByOne:create()

	var_5_0:setSwallowTouches(true)
	var_5_0:registerScriptHandler(function(arg_6_0, arg_6_1)
		return arg_5_0:onTouchBegan(arg_6_0, arg_5_0._isInitCards)
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_5_0:registerScriptHandler(function(arg_7_0, arg_7_1)
		return arg_5_0:onTouchMoved(arg_7_0, arg_5_0._isInitCards)
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_5_0:registerScriptHandler(function(arg_8_0, arg_8_1)
		return arg_5_0:onTouchEnded(arg_8_0, arg_5_0._isInitCards)
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_5_0:registerScriptHandler(function(arg_9_0, arg_9_1)
		return arg_5_0:onTouchCanceled()
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	arg_5_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_5_0, arg_5_0)

	if BattleTestData._singleFileName ~= nil and BattleTestData._singleFileName ~= "" then
		arg_5_0:importTestCards(BattleTestData._singleFileName)
	elseif TEST_BATTLE_PARAM ~= "" then
		local var_5_1 = lc.File:fullPathForFilename(TEST_BATTLE_PARAM .. ".ygo")

		arg_5_0:importTestCards(var_5_1)
	end
end

function var_0_0.onExit(arg_10_0)
	arg_10_0:getEventDispatcher():removeEventListenersForTarget(arg_10_0)
end

function var_0_0.onCleanup(arg_11_0)
	if arg_11_0._playerUi ~= nil then
		arg_11_0._playerUi:resetCardSprites()
	end

	if arg_11_0._opponentUi ~= nil then
		arg_11_0._opponentUi:resetCardSprites()
	end
end

function var_0_0.initData(arg_12_0)
	arg_12_0._isInitCards = true
	input = {
		_storyName = "",
		_levelId = 10102,
		_isAttacker = true,
		_battleType = Data.BattleType.layout,
		_sceneType = Data.BattleSceneType.country_scene_wei,
		_timestamp = math.random(65536),
		_player = {
			_level = 1,
			_avatar = 1,
			_fortressHp = 8000,
			_name = Str(Data._characterInfo[3]._nameSid),
			_troopCards = {
				_infoId = 10001,
				_num = 3
			},
			_troopLevels = {},
			_troopSkins = {},
			_usedCards = {}
		},
		_opponent = {
			_level = 1,
			_avatar = 2,
			_fortressHp = 8000,
			_name = Str(Data._characterInfo[2]._nameSid),
			_troopCards = {},
			_troopLevels = {},
			_troopSkins = {},
			_usedCards = {}
		}
	}
	arg_12_0._input = input
	arg_12_0._battleType = input._battleType
	arg_12_0._baseBattleType = math.floor(arg_12_0._battleType / Data.BattleType.base_type)
	arg_12_0._sceneType = input._sceneType or Data.BattleTestSceneType.stone_scene
	arg_12_0._timestamp = math.floor(input._timestamp / 1000)
	arg_12_0._isAttacker = input._isAttacker
	arg_12_0._needForward = input._needForward
	arg_12_0._storyName = input._storyName
	arg_12_0._isSkipStory = false
	arg_12_0._isBattleEndSended = false

	if input._replayBattleType then
		arg_12_0._replayType = input._replayBattleType
		arg_12_0._replayBaseType = math.floor(input._replayBattleType / Data.BattleType.base_type)
	end

	arg_12_0._timeOutTimes = 0
	arg_12_0._autoConfig = false
	arg_12_0._battleSpeed = 3

	local var_12_0 = {
		_isClient = true,
		_isAttacker = input._isAttacker,
		_randomSeed = input._randomSeed,
		_usedCards = input._player._usedCards or {},
		_fortressHp = input._player._fortressHp,
		_bossId = input._player._bossId,
		_bossLevel = input._player._bossLevel,
		_troopCards = input._player._troopCards,
		_troopLevels = input._player._troopLevels,
		_troopSkins = input._player._troopSkins,
		_events = arg_12_0._needEvents and input._eventIds or {},
		_conditions = (arg_12_0._needTask or P._guideID < 100) and {
			_conditionIds = input._conditionIds or {},
			_conditionValues = input._conditionValues or {}
		} or {},
		_storyRound = input._storyRound or 0,
		_atkLevel = input._isAttacker and input._player._level or input._opponent._level,
		_fortressSkill = input._player._fortressSkill,
		_assistantHp = input._player._assistantHp,
		_battleType = arg_12_0._replayType or arg_12_0._battleType,
		_isNpc = input._player._isNpc,
		_reviewType = ClientData._cfg and ClientData._cfg.battleReview or 0
	}
	local var_12_1 = {
		_isClient = true,
		_isAttacker = not input._isAttacker,
		_randomSeed = input._randomSeed,
		_usedCards = input._opponent._usedCards or {},
		_fortressHp = input._opponent._fortressHp,
		_bossId = input._opponent._bossId,
		_bossLevel = input._opponent._bossLevel,
		_troopCards = input._opponent._troopCards,
		_troopLevels = input._opponent._troopLevels,
		_troopSkins = input._opponent._troopSkins,
		_events = arg_12_0._needEvents and input._oppoEventIds or {},
		_conditions = {},
		_storyRound = input._storyRound or 0,
		_atkLevel = input._isAttacker and input._player._level or input._opponent._level,
		_fortressSkill = input._opponent._fortressSkill,
		_assistantHp = input._opponent._assistantHp,
		_battleType = arg_12_0._replayType or arg_12_0._battleType,
		_isNpc = input._opponent._isNpc,
		_reviewType = ClientData._cfg and ClientData._cfg.battleReview or 0
	}

	arg_12_0._player = PlayerBattle.new(var_12_0)
	arg_12_0._opponent = PlayerBattle.new(var_12_1)
	arg_12_0._player._opponent, arg_12_0._opponent._opponent = arg_12_0._opponent, arg_12_0._player

	arg_12_0:resetBattle()

	if arg_12_0._nameTag == "normal" then
		ClientData._reportBattleDebugLog = true
		ClientData._battleDebugLog = ""

		for iter_12_0 = 1, #var_12_0._usedCards do
			ClientData.addBattleDebugLog((var_12_0._isAttacker and "AU" or "DU") .. var_12_0._usedCards[iter_12_0] .. ",")
		end

		for iter_12_1 = 1, #var_12_1._usedCards do
			ClientData.addBattleDebugLog((var_12_1._isAttacker and "AU" or "DU") .. var_12_1._usedCards[iter_12_1] .. ",")
		end

		ClientData.addBattleDebugLog("\n\n")
	end

	arg_12_0._player._name, arg_12_0._opponent._name = input._player._name, input._opponent._name
	arg_12_0._player._level, arg_12_0._opponent._level = input._player._level, input._opponent._level
	arg_12_0._player._vip, arg_12_0._opponent._vip = input._player._vip, input._opponent._vip
	arg_12_0._player._avatar, arg_12_0._opponent._avatar = input._player._avatar, input._opponent._avatar
	arg_12_0._player._crown, arg_12_0._opponent._crown = input._player._crown, input._opponent._crown
end

function var_0_0.initBackground(arg_13_0)
	local var_13_0 = arg_13_0._sceneType

	if var_13_0 < 11 or var_13_0 > 15 then
		local var_13_1 = 1
	end

	local var_13_2 = "res/bat_scene/bat_scene_11_bg.jpg"
	local var_13_3 = cc.Sprite:create(var_13_2)

	lc.addChildToCenter(arg_13_0._scene, var_13_3, -1)
	arg_13_0._scene:seenByCamera3D(var_13_3)

	arg_13_0._skySpr = var_13_3
	arg_13_0._battleFrame = lc.createSpriteWithMask("res/jpg/battle_frame_bg.jpg")

	lc.addChildToCenter(arg_13_0, arg_13_0._battleFrame)
end

function var_0_0.initUiControl(arg_14_0)
	local var_14_0 = cc.Node:create()

	var_14_0:setContentSize(ClientView.SCR_SIZE)
	var_14_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_14_0._scene, var_14_0, BattleScene.ZOrder.ui)

	arg_14_0._layer = var_14_0

	local function var_14_1(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
		local var_15_0 = ClientView.createShaderButton(arg_15_0, function(arg_16_0)
			arg_14_0:onButtonEvent(arg_16_0)
		end)
		local var_15_1

		if arg_15_1 then
			var_15_1 = lc.createSprite(arg_15_1)
		elseif arg_15_2 then
			if type(arg_15_2) == "table" then
				var_15_1 = ClientView.createBMFont(arg_15_2._font, arg_15_2._str)
			else
				var_15_1 = ClientView.createBMFont(ClientView.BMFont.huali_32, arg_15_2)
			end
		end

		if var_15_1 then
			lc.addChildToPos(var_15_0, var_15_1, cc.p(lc.w(var_15_0) / 2, lc.h(var_15_0) / 2))

			var_15_0._icon = var_15_1
		end

		if arg_15_3 then
			local var_15_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_15_3)

			var_15_2:setColor(ClientView.COLOR_BUTTON_TITLE)

			if arg_15_4 then
				lc.addChildToPos(var_15_0, var_15_2, cc.p(lc.w(var_15_0) / 2, lc.h(var_15_0) / 2))
			else
				lc.addChildToPos(var_15_0, var_15_2, cc.p(lc.w(var_15_0) / 2, -6))
			end

			var_15_0._title = var_15_2
		end

		var_14_0:addChild(var_15_0)

		return var_15_0
	end

	local var_14_2 = 12 + ClientView.SCR_EDGE

	arg_14_0._btnReturn = var_14_1("bat_btn_2", "bat_btn_icon_back")

	arg_14_0._btnReturn:setPosition(lc.cw(arg_14_0._btnReturn) + var_14_2, ClientView.SCR_H - 80 - lc.ch(arg_14_0._btnReturn))

	arg_14_0._btnExport = var_14_1("bat_btn_2", nil, nil, Str(STR.EXPORT), true)

	arg_14_0._btnExport:setTouchRect(cc.rect(-6, -6, lc.w(arg_14_0._btnExport) + 12, lc.h(arg_14_0._btnExport) + 12))
	arg_14_0._btnExport:setPosition(var_14_2 + lc.w(arg_14_0._btnExport) / 2, lc.bottom(arg_14_0._btnReturn) - lc.ch(arg_14_0._btnExport))

	arg_14_0._btnImport = var_14_1("bat_btn_2", nil, nil, Str(STR.LOAD), true)

	arg_14_0._btnImport:setTouchRect(cc.rect(-6, -6, lc.w(arg_14_0._btnImport) + 12, lc.h(arg_14_0._btnImport) + 12))
	arg_14_0._btnImport:setPosition(var_14_2 + lc.w(arg_14_0._btnImport) / 2, lc.bottom(arg_14_0._btnExport) - lc.ch(arg_14_0._btnImport))

	arg_14_0._btnSwap = var_14_1("bat_btn_2", nil, nil, Str(STR.SWAP), true)

	arg_14_0._btnSwap:setTouchRect(cc.rect(-6, -6, lc.w(arg_14_0._btnSwap) + 12, lc.h(arg_14_0._btnSwap) + 12))
	arg_14_0._btnSwap:setPosition(var_14_2 + lc.w(arg_14_0._btnSwap) / 2, lc.bottom(arg_14_0._btnImport) - lc.ch(arg_14_0._btnSwap))

	arg_14_0._btnStart = var_14_1("bat_btn_2", nil, nil, Str(STR.RUN_FREE), true)

	arg_14_0._btnStart:setTouchRect(cc.rect(-6, -6, lc.w(arg_14_0._btnStart) + 12, lc.h(arg_14_0._btnStart) + 12))
	arg_14_0._btnStart:setPosition(var_14_2 + lc.w(arg_14_0._btnStart) / 2, lc.bottom(arg_14_0._btnSwap) - lc.ch(arg_14_0._btnStart))

	arg_14_0._btnClear = var_14_1("bat_btn_2", nil, nil, Str(STR.CLEAR), true)

	arg_14_0._btnClear:setTouchRect(cc.rect(-6, -6, lc.w(arg_14_0._btnClear) + 12, lc.h(arg_14_0._btnClear) + 12))
	arg_14_0._btnClear:setPosition(var_14_2 + lc.w(arg_14_0._btnClear) / 2, lc.bottom(arg_14_0._btnStart) - lc.ch(arg_14_0._btnClear))
end

function var_0_0.onButtonEvent(arg_17_0, arg_17_1)
	if arg_17_1 == arg_17_0._btnReturn then
		ClientData._unitTestFile = nil

		local var_17_0 = ClientData.genInputFromUnitTest()

		lc.replaceScene(require("BattleScene").create(var_17_0))
	elseif arg_17_1 == arg_17_0._btnEndRound then
		if arg_17_0:isGuideWorldBattle(10101) and (arg_17_0._guide10101Round == nil or arg_17_0._guide10101Round < arg_17_0._player._round) then
			arg_17_0._guide10101Round = arg_17_0._player._round

			if arg_17_0._player:canUseHandCard() then
				arg_17_0:showTip({
					t = {
						touch = 1,
						left = 1,
						story = 201
					}
				})

				return
			end
		end

		if arg_17_0._player:getActionPlayer():getIsNeedDrop() then
			arg_17_0:showDropHand()
		else
			arg_17_0._timeOutTimes = 0

			arg_17_0:operateEnd()
			arg_17_0:hideTip()
			arg_17_0:setGuideHelpButtonVisible(false)
		end
	elseif arg_17_1 == arg_17_0._btnExport then
		local var_17_1 = lc.App:getSaveFileName()

		if var_17_1 ~= nil and var_17_1 ~= "" then
			arg_17_0:exportTestCards(var_17_1)
		end
	elseif arg_17_1 == arg_17_0._btnImport then
		local var_17_2

		if ClientData._cfg and ClientData._cfg.importFile then
			var_17_2 = ClientData._cfg.importFile
		else
			var_17_2 = lc.App:getOpenFileName()
		end

		if var_17_2 ~= nil and var_17_2 ~= "" then
			BattleTestData._singleFileName = var_17_2

			arg_17_0:importTestCards(var_17_2)
		end
	elseif arg_17_1 == arg_17_0._btnStart then
		arg_17_0:exportTestCards(BattleTestData.DEFAULT_FILE)

		ClientData._unitTestFile = BattleTestData.DEFAULT_FILE
		BattleTestData._singleFileName = ClientData._unitTestFile

		BattleTestData.resetUsedCards()

		local var_17_3 = ClientData.genInputFromUnitTest()

		lc.replaceScene(require("BattleScene").create(var_17_3))
	elseif arg_17_1 == arg_17_0._btnClear then
		BattleTestData._singleFileName = nil

		arg_17_0:reset()
	elseif arg_17_1 == arg_17_0._btnSwap then
		arg_17_0:swap()
	end
end

function var_0_0.addSprites(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	arg_18_4 = arg_18_4 or {}

	for iter_18_0 = 1, #arg_18_3 do
		if arg_18_3[iter_18_0] ~= nil then
			local var_18_0 = iter_18_0
			local var_18_1
			local var_18_2 = false

			if arg_18_3[iter_18_0] < 0 then
				var_18_2 = true
				arg_18_3[iter_18_0] = -arg_18_3[iter_18_0]
			end

			local var_18_3 = require("BattleCard").new(arg_18_3[iter_18_0], 1, arg_18_2)

			var_18_3._extraSkillId = arg_18_4[iter_18_0]

			var_18_3:resetOnce()
			arg_18_2:addCardToCards(var_18_3)

			if arg_18_5 == "P" then
				var_18_3._saved._pos = var_18_0

				arg_18_2:addCardToPile(var_18_3)
				arg_18_0:updatePile(arg_18_1)
			elseif arg_18_5 == "B" then
				if arg_18_3[iter_18_0] > 0 then
					var_18_3._pos = var_18_0
					arg_18_2._boardCards[var_18_0] = var_18_3

					local var_18_4 = arg_18_1:createCardSprite(var_18_3)

					arg_18_0:addChild(var_18_4)
					arg_18_1:addCardToBoardFast(var_18_3)

					if var_18_2 then
						var_18_4._card._positiveStatus[BattleData.PositiveType.defendPosture] = true

						var_18_4:updateDefendPosture(false)
					end
				end
			elseif arg_18_5 == "S" then
				if arg_18_3[iter_18_0] > 0 then
					var_18_3._sourceStatus = BattleData.CardStatus.hand
					var_18_3._pos = var_18_0
					arg_18_2._showCards[var_18_0] = var_18_3

					local var_18_5 = arg_18_1:createCardSprite(var_18_3)

					arg_18_0:addChild(var_18_5)
					arg_18_1:addCardToShowFast(var_18_3)
				end
			elseif arg_18_5 == "R" then
				arg_18_2:addCardToRare(var_18_3)

				local var_18_6 = arg_18_1:createCardSprite(var_18_3)

				arg_18_0:addChild(var_18_6)
				arg_18_1:addCardToRareFast(var_18_3)
			elseif arg_18_5 == "G" then
				arg_18_2:addCardToGrave(var_18_3)

				local var_18_7 = arg_18_1:createCardSprite(var_18_3)

				arg_18_0:addChild(var_18_7)
				arg_18_1:addCardToGrave(var_18_3, 0, 0)
			elseif arg_18_5 == "L" then
				arg_18_2:addCardToLeave(var_18_3)

				local var_18_8 = arg_18_1:createCardSprite(var_18_3)

				arg_18_0:addChild(var_18_8)
				arg_18_1:addCardToLeave(var_18_3, 0, 0)
			elseif arg_18_5 == "H" then
				var_18_3._pos = var_18_0

				arg_18_2:addCardToHand(var_18_3)

				local var_18_9 = arg_18_1:createCardSprite(var_18_3)

				arg_18_0:addChild(var_18_9)
				arg_18_1:addCardToHandFast(var_18_3)
			end
		end
	end
end

function var_0_0.resetBattle(arg_19_0)
	PlayerBattle._randomSeed = PlayerBattle._originRandomSeed

	if arg_19_0._player._isAttacker then
		arg_19_0._player:resetWhenBattleStart()
		arg_19_0._opponent:resetWhenBattleStart()
	else
		arg_19_0._opponent:resetWhenBattleStart()
		arg_19_0._player:resetWhenBattleStart()
	end
end

function var_0_0.createDragonBones(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
	if arg_20_3 == nil or arg_20_1 == nil then
		return
	end

	arg_20_4 = arg_20_4 or "effect"

	if arg_20_5 == nil then
		arg_20_5 = true
	end

	local var_20_0 = DragonBones.create(arg_20_1)

	var_20_0:setPosition(arg_20_2)
	var_20_0:setScale(arg_20_6 or 1)
	arg_20_3:addChild(var_20_0, arg_20_7 or 0)
	arg_20_0._scene:seenByCamera3D(arg_20_3)
	var_20_0:gotoAndPlay(arg_20_4)

	if arg_20_5 then
		local var_20_1 = var_20_0:getAnimationDuration(arg_20_4)

		var_20_0:runAction(lc.sequence(var_20_1, lc.remove()))
	end

	return var_20_0
end

function var_0_0.updatePile(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1._player
	local var_21_1 = arg_21_1._pile._label
	local var_21_2 = #var_21_0._pileCards

	if var_21_0._handCardsToAdd ~= nil then
		var_21_2 = var_21_2 + #var_21_0._handCardsToAdd
	end

	var_21_1:setString(var_21_2)
	var_21_1:stopAllActions()
end

function var_0_0.exportTestCards(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_2 and arg_22_0._opponentUi or arg_22_0._playerUi
	local var_22_1 = arg_22_2 and arg_22_0._playerUi or arg_22_0._opponentUi
	local var_22_2 = {
		attackerHP = var_22_0._pHpLabel:getString(),
		attackerP = var_22_0._player._pileCards,
		attackerH = var_22_0._player._handCards,
		attackerB = var_22_0._player._boardCards,
		attackerG = var_22_0._player._graveCards,
		attackerL = var_22_0._player._leaveCards,
		attackerR = var_22_0._player._rareCards,
		attackerS = var_22_0._player._showCards,
		defenderHP = var_22_1._pHpLabel:getString(),
		defenderP = var_22_1._player._pileCards,
		defenderH = var_22_1._player._handCards,
		defenderB = var_22_1._player._boardCards,
		defenderG = var_22_1._player._graveCards,
		defenderL = var_22_1._player._leaveCards,
		defenderS = var_22_1._player._showCards,
		defenderR = var_22_1._player._rareCards
	}

	BattleTestData.exportTestCardsData(arg_22_1, var_22_2)
end

function var_0_0.importTestCards(arg_23_0, arg_23_1)
	BattleTestData.resetUsedCards()

	local var_23_0 = BattleTestData.importBattleTestData(arg_23_1)

	arg_23_0:reset()
	arg_23_0._playerUi:setFortressHp(var_23_0.AttackerFields.HP)
	arg_23_0._opponentUi:setFortressHp(var_23_0.DefenderFields.HP)
	arg_23_0:addSprites(arg_23_0._playerUi, arg_23_0._player, var_23_0.AttackerFields.P, var_23_0.AttackerFields.PS, "P")
	arg_23_0:addSprites(arg_23_0._playerUi, arg_23_0._player, var_23_0.AttackerFields.H, var_23_0.AttackerFields.HS, "H")
	arg_23_0:addSprites(arg_23_0._playerUi, arg_23_0._player, var_23_0.AttackerFields.B, var_23_0.AttackerFields.BS, "B")
	arg_23_0:addSprites(arg_23_0._playerUi, arg_23_0._player, var_23_0.AttackerFields.G, var_23_0.AttackerFields.GS, "G")

	if var_23_0.AttackerFields.L then
		arg_23_0:addSprites(arg_23_0._playerUi, arg_23_0._player, var_23_0.AttackerFields.L, var_23_0.AttackerFields.LS, "L")
	end

	arg_23_0:addSprites(arg_23_0._playerUi, arg_23_0._player, var_23_0.AttackerFields.S, var_23_0.AttackerFields.SS, "S")
	arg_23_0:addSprites(arg_23_0._playerUi, arg_23_0._player, var_23_0.AttackerFields.R, var_23_0.AttackerFields.RS, "R")
	arg_23_0:addSprites(arg_23_0._opponentUi, arg_23_0._opponent, var_23_0.DefenderFields.P, var_23_0.DefenderFields.PS, "P")
	arg_23_0:addSprites(arg_23_0._opponentUi, arg_23_0._opponent, var_23_0.DefenderFields.H, var_23_0.DefenderFields.HS, "H")
	arg_23_0:addSprites(arg_23_0._opponentUi, arg_23_0._opponent, var_23_0.DefenderFields.B, var_23_0.DefenderFields.BS, "B")
	arg_23_0:addSprites(arg_23_0._opponentUi, arg_23_0._opponent, var_23_0.DefenderFields.G, var_23_0.DefenderFields.GS, "G")

	if var_23_0.DefenderFields.L then
		arg_23_0:addSprites(arg_23_0._opponentUi, arg_23_0._opponent, var_23_0.DefenderFields.L, var_23_0.DefenderFields.LS, "L")
	end

	arg_23_0:addSprites(arg_23_0._opponentUi, arg_23_0._opponent, var_23_0.DefenderFields.S, var_23_0.DefenderFields.SS, "S")
	arg_23_0:addSprites(arg_23_0._opponentUi, arg_23_0._opponent, var_23_0.DefenderFields.R, var_23_0.DefenderFields.RS, "R")
end

function var_0_0.swap(arg_24_0)
	arg_24_0:exportTestCards(BattleTestData.DEFAULT_FILE, true)
	arg_24_0:importTestCards(BattleTestData.DEFAULT_FILE)
end

return var_0_0
