local var_0_0 = class("BattleScene", require("BaseScene"))

BattleScene = var_0_0
var_0_0.ZOrder = {
	dialog = 30,
	ui = 20,
	top = 100,
	battle = 10,
	form = 40,
	bg = 0,
	story = 50
}
var_0_0.MANUAL_GUIDE_STEP_COUNT = 5

function var_0_0.create(arg_1_0)
	return lc.createScene(var_0_0, arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.battle) then
		return false
	end

	arg_2_0._input = arg_2_1
	ClientData._battleScene = arg_2_0
	arg_2_0._isGuideOnEnter = false

	if arg_2_1._battleType == Data.BattleType.guidance_train then
		arg_2_0:enterManualGuideMode(1)
	else
		arg_2_0._battleUiNormal = BattleUi.create(arg_2_0, arg_2_1, "normal")

		arg_2_0:addChild(arg_2_0._battleUiNormal)

		arg_2_0._battleUi = arg_2_0._battleUiNormal

		ClientData.sendUserEvent({
			battleType = arg_2_1._battleType,
			isAttacker = arg_2_1._isAttacker
		})

		if P._guideID == 11 then
			local var_2_0 = cc.Sprite:createWithTexture(ClientView._rt:getSprite():getTexture())

			var_2_0:setFlippedY(true)
			ClientView._rt:release()
			lc.addChildToCenter(arg_2_0, var_2_0, 100000)

			arg_2_0._screenShot = var_2_0
		end
	end

	return true
end

function var_0_0.playBgMusic(arg_3_0)
	if P._guideID >= 21 then
		if arg_3_0._battleUiNormal then
			if arg_3_0._battleUiNormal._baseBattleType == Data.BattleType.base_PVP or arg_3_0._battleUiNormal._baseBattleType == Data.BattleType.base_replay then
				lc.Audio.playAudio(AUDIO.M_BATTLE1)
			else
				lc.Audio.playAudio(AUDIO.M_BATTLE)
			end
		else
			lc.Audio.playAudio(AUDIO.M_GUIDE2)
		end
	else
		lc.Audio.playAudio(AUDIO.M_GUIDE)
	end
end

function var_0_0.onEnter(arg_4_0)
	var_0_0.super.onEnter(arg_4_0)

	if arg_4_0._battleUi and arg_4_0._battleUi._isBattleFinished then
		return
	end

	GuideManager.releaseLayer()
	arg_4_0:playBgMusic()
end

function var_0_0.onCleanup(arg_5_0)
	var_0_0.super.onCleanup(arg_5_0)

	if ClientData._battleScene == arg_5_0 then
		ClientData._battleScene = nil
	end
end

function var_0_0.onMsg(arg_6_0, arg_6_1)
	if arg_6_0._battleUiNormal and arg_6_0._battleUiNormal:onMsg(arg_6_1) then
		return true
	end

	return var_0_0.super.onMsg(arg_6_0, arg_6_1)
end

function var_0_0.onMsgErrorStatus(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == SglMsg_pb.PB_STATUS_BATTLE_JOIN_NOT_ALLOWED then
		if arg_7_0._battleUiNormal then
			arg_7_0._battleUiNormal:exitScene()
		end

		return true
	end

	return var_0_0.super.onMsgErrorStatus(arg_7_0, arg_7_1, arg_7_2)
end

function var_0_0.onIdle(arg_8_0)
	if arg_8_0._battleUiNormal and arg_8_0._battleUiNormal._resultDialog == nil then
		lc.Director:updateTouchTimestamp()

		return
	end

	var_0_0.super.onIdle(arg_8_0)
end

function var_0_0.onLogin(arg_9_0)
	if var_0_0.super.onLogin(arg_9_0) then
		return true
	end

	if arg_9_0._battleUiNormal then
		ClientData._fromSceneId = nil

		arg_9_0._battleUiNormal:exitScene()
	else
		arg_9_0._battleUiGuide:exitScene()
	end

	return true
end

function var_0_0.onBattleRecover(arg_10_0, arg_10_1)
	(function()
		ClientView.getActiveIndicator():hide()

		if arg_10_1._sceneType ~= arg_10_0._battleUi._sceneType then
			arg_10_0._battleUi:stopAllActions()
		end

		lc._runningScene = nil

		lc.replaceScene(BattleScene.create(arg_10_1))
		ClientData.sendBattleLoadingDone()
	end)()
end

function var_0_0.onBattleEnd(arg_12_0, arg_12_1)
	if arg_12_0._isBattleWait then
		return var_0_0.super.onBattleEnd(arg_12_0, arg_12_1)
	end

	if arg_12_0._battleUiNormal then
		arg_12_0._battleUiNormal:onBattleEnd(arg_12_1)
	end
end

function var_0_0.onBattleWait(arg_13_0)
	var_0_0.super.onBattleWait(arg_13_0)

	arg_13_0._isBattleWait = true
end

function var_0_0.onAttack(arg_14_0, arg_14_1)
	arg_14_0:onBattleRecover(arg_14_1)
end

function var_0_0.onChallenge(arg_15_0, arg_15_1)
	arg_15_0:onBattleRecover(arg_15_1)
end

function var_0_0.onExpedition(arg_16_0, arg_16_1)
	arg_16_0:onBattleRecover(arg_16_1)
end

function var_0_0.onExpeditionEx(arg_17_0, arg_17_1)
	arg_17_0:onBattleRecover(arg_17_1)
end

function var_0_0.onHorse(arg_18_0, arg_18_1)
	arg_18_0:onBattleRecover(arg_18_1)
end

function var_0_0.onRobExp(arg_19_0, arg_19_1)
	arg_19_0:onBattleRecover(arg_19_1)
end

function var_0_0.onBoss(arg_20_0, arg_20_1)
	arg_20_0:onBattleRecover(arg_20_1)
end

function var_0_0.onElite(arg_21_0, arg_21_1)
	arg_21_0:onBattleRecover(arg_21_1)
end

function var_0_0.onReplay(arg_22_0, arg_22_1)
	arg_22_0:onBattleRecover(arg_22_1)
end

function var_0_0.showReloadDialog(arg_23_0, arg_23_1, arg_23_2)
	var_0_0.super.showReloadDialog(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._battleUi:pause()
end

function var_0_0.reconnect(arg_24_0, arg_24_1)
	var_0_0.super.reconnect(arg_24_0, arg_24_1)
	arg_24_0._battleUi:pause()
end

function var_0_0.enterManualGuideMode(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0._battleUiNormal then
		arg_25_0._battleUiNormal:pause()
	end

	arg_25_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_25_2 and 1 or 0), cc.CallFunc:create(function()
		arg_25_0:enterManualGuideModeInternal(arg_25_1 or 1)
	end)))

	if arg_25_2 then
		arg_25_0._mask = cc.LayerColor:create(lc.Color3B.black, lc.w(arg_25_0), lc.h(arg_25_0))

		arg_25_0._mask:setOpacity(0)
		arg_25_0._mask:runAction(cc.Sequence:create(cc.FadeIn:create(1), cc.FadeOut:create(1), cc.CallFunc:create(function()
			arg_25_0._mask:removeFromParent()
		end)))
		arg_25_0:addChild(arg_25_0._mask, ClientData.ZOrder.toast)
	end
end

function var_0_0.enterManualGuideModeInternal(arg_28_0, arg_28_1)
	if arg_28_0._battleUiGuide then
		arg_28_0._battleUiGuide:removeFromParent()
	end

	arg_28_0._manualGuideStep = arg_28_1
	arg_28_0._battleUiGuide = BattleUi.create(arg_28_0, arg_28_0:genInputForManualGuide(arg_28_1), "guide")

	arg_28_0:addChild(arg_28_0._battleUiGuide)

	if arg_28_0._battleUiNormal then
		arg_28_0._battleUiNormal:setVisible(false)
	end

	arg_28_0._battleUiGuide:enterFilmMode(string.format("%s (%d/%d)", Str(STR.MANUAL_GUIDE), arg_28_1, var_0_0.MANUAL_GUIDE_STEP_COUNT), BattleUi.FilmBottomMode.na)

	local var_28_0 = lc.w(arg_28_0._battleUiGuide)
	local var_28_1 = 90
	local var_28_2 = 120
	local var_28_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_29_0)
		arg_28_0:manualGuidePrev()
	end, ClientView.CRECT_BUTTON, var_28_2)

	var_28_3:setDisabledShader(ClientView.SHADER_DISABLE)
	var_28_3:addLabel(Str(STR.MANUAL_GUIDE_PREV))
	lc.addChildToPos(arg_28_0._battleUiGuide._filmTopLayer, var_28_3, cc.p(var_28_0 - var_28_2 - var_28_2 - var_28_2 / 2 - 30, var_28_1 / 2 - 32))
	var_28_3:setEnabled(arg_28_0._manualGuideStep > 1)

	local var_28_4 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_30_0)
		arg_28_0:manualGuideNext()
	end, ClientView.CRECT_BUTTON, var_28_2)

	var_28_4:setDisabledShader(ClientView.SHADER_DISABLE)
	var_28_4:addLabel(Str(STR.MANUAL_GUIDE_NEXT))
	lc.addChildToPos(arg_28_0._battleUiGuide._filmTopLayer, var_28_4, cc.p(var_28_0 - var_28_2 - var_28_2 / 2 - 20, var_28_1 / 2 - 32))
	var_28_4:setEnabled(arg_28_0._manualGuideStep < var_0_0.MANUAL_GUIDE_STEP_COUNT)

	local var_28_5 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_31_0)
		arg_28_0:manualGuideExit()
	end, ClientView.CRECT_BUTTON, var_28_2)

	var_28_5:addLabel(Str(STR.MANUAL_GUIDE_EXIT))
	lc.addChildToPos(arg_28_0._battleUiGuide._filmTopLayer, var_28_5, cc.p(var_28_0 - var_28_2 / 2 - 10, var_28_1 / 2 - 32))
	arg_28_0._battleUiGuide:setVisible(true)

	arg_28_0._battleUi = arg_28_0._battleUiGuide
end

function var_0_0.leaveManualGuideMode(arg_32_0)
	arg_32_0._battleUiGuide:leaveFilmMode()

	if arg_32_0._battleUiNormal then
		arg_32_0._mask = cc.LayerColor:create(lc.Color3B.black, lc.w(arg_32_0), lc.h(arg_32_0))

		arg_32_0._mask:setOpacity(0)
		arg_32_0._mask:runAction(cc.Sequence:create(cc.FadeIn:create(1), cc.FadeOut:create(1), cc.CallFunc:create(function()
			arg_32_0._mask:removeFromParent()
		end)))
		arg_32_0:addChild(arg_32_0._mask, ClientData.ZOrder.toast)
		arg_32_0:runAction(lc.sequence(1, cc.CallFunc:create(function()
			if arg_32_0._battleUiGuide then
				arg_32_0._battleUiGuide:removeFromParent()

				arg_32_0._battleUiGuide = nil
			end

			arg_32_0._battleUiNormal:setVisible(true)

			arg_32_0._battleUi = arg_32_0._battleUiNormal

			arg_32_0._battleUi:setBattleSpeed()

			local var_34_0 = require("Dialog").showDialog(Str(STR.BATTLE_DIALOG_RESUME_BATTLE), function()
				arg_32_0._battleUiNormal:resume()
			end, true)
		end)))
	else
		arg_32_0._battleUiGuide:exitScene()
	end
end

function var_0_0.manualGuideNext(arg_36_0)
	arg_36_0:enterManualGuideMode(arg_36_0._manualGuideStep + 1)
end

function var_0_0.manualGuidePrev(arg_37_0)
	arg_37_0:enterManualGuideMode(arg_37_0._manualGuideStep - 1)
end

function var_0_0.manualGuideExit(arg_38_0)
	arg_38_0:leaveManualGuideMode()
end

function var_0_0.genInputForManualGuide(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0._input

	var_39_0._battleType = Data.BattleType.guidance
	var_39_0._needForward = true
	var_39_0._storyName = nil

	local var_39_1 = 1000
	local var_39_2 = 1000
	local var_39_3 = {}
	local var_39_4 = {}
	local var_39_5 = {}
	local var_39_6 = {}
	local var_39_7 = {}
	local var_39_8 = {}

	if arg_39_1 == 1 then
		table.insert(var_39_3, {
			info_id = 1011,
			id = 1,
			level = 5
		})
		table.insert(var_39_4, {
			info_id = 5001,
			id = 1,
			level = 1
		})

		var_39_7 = {
			50001,
			50002,
			50003,
			50004,
			50005,
			50006
		}
	elseif arg_39_1 == 2 then
		table.insert(var_39_3, {
			info_id = 5010,
			id = 1,
			level = 1
		})
		table.insert(var_39_3, {
			info_id = 5011,
			id = 2,
			level = 1
		})
		table.insert(var_39_3, {
			info_id = 1089,
			id = 3,
			level = 8
		})
		table.insert(var_39_4, {
			info_id = 5001,
			id = 1,
			level = 1
		})
		table.insert(var_39_4, {
			info_id = 5001,
			id = 2,
			level = 1
		})
		table.insert(var_39_4, {
			info_id = 5001,
			id = 3,
			level = 1
		})

		var_39_5 = {
			1,
			1,
			0,
			1001,
			0,
			0,
			1002,
			0,
			0
		}
		var_39_6 = {
			2003,
			0,
			0,
			1,
			1,
			0
		}
		var_39_7 = {
			50101,
			50102,
			50103,
			50104,
			50105
		}
		var_39_1 = 2000
	elseif arg_39_1 == 3 then
		table.insert(var_39_3, {
			info_id = 5010,
			id = 1,
			level = 1
		})
		table.insert(var_39_3, {
			info_id = 5011,
			id = 2,
			level = 1
		})
		table.insert(var_39_3, {
			info_id = 1233,
			id = 3,
			level = 15
		})
		table.insert(var_39_4, {
			info_id = 5032,
			id = 1,
			level = 10
		})
		table.insert(var_39_4, {
			info_id = 5032,
			id = 2,
			level = 10
		})

		var_39_5 = {
			1003,
			0,
			0,
			1,
			1,
			0,
			1001,
			0,
			0,
			1002,
			0,
			0
		}
		var_39_6 = {
			1,
			1,
			0
		}
		var_39_7 = {
			50201,
			50202,
			50203,
			50204,
			50205
		}
		var_39_2 = 2000
	elseif arg_39_1 == 4 then
		table.insert(var_39_3, {
			info_id = 1491,
			id = 1,
			level = 10
		})
		table.insert(var_39_3, {
			info_id = 4305,
			id = 2,
			level = 10
		})
		table.insert(var_39_4, {
			info_id = 5002,
			id = 1,
			level = 1
		})
		table.insert(var_39_4, {
			info_id = 5002,
			id = 2,
			level = 1
		})
		table.insert(var_39_4, {
			info_id = 5002,
			id = 3,
			level = 1
		})
		table.insert(var_39_4, {
			info_id = 5002,
			id = 4,
			level = 1
		})

		var_39_5 = {
			1,
			1,
			0,
			1001,
			0,
			0
		}
		var_39_6 = {
			2003,
			0,
			0,
			2004,
			0,
			0,
			1,
			1,
			0
		}
		var_39_7 = {
			50301,
			50302,
			50303,
			50304,
			50305
		}
	elseif arg_39_1 == 5 then
		table.insert(var_39_3, {
			info_id = 6204,
			id = 1,
			level = 10
		})
		table.insert(var_39_4, {
			info_id = 5005,
			id = 1,
			level = 1
		})
		table.insert(var_39_4, {
			info_id = 5005,
			id = 2,
			level = 1
		})
		table.insert(var_39_4, {
			info_id = 5005,
			id = 3,
			level = 1
		})
		table.insert(var_39_4, {
			info_id = 5005,
			id = 4,
			level = 1
		})

		var_39_5 = {
			1,
			1,
			0
		}
		var_39_6 = {
			2003,
			0,
			0,
			2004,
			0,
			0,
			1,
			1,
			0
		}
		var_39_7 = {
			50401,
			50402,
			50403,
			50404,
			50405,
			50406
		}
	end

	var_39_0._player._fortressHp = var_39_1
	var_39_0._player._troop = var_39_3
	var_39_0._player._usedCards = var_39_5
	var_39_0._eventIds = var_39_7
	var_39_0._opponent._fortressHp = var_39_2
	var_39_0._opponent._troop = var_39_4
	var_39_0._opponent._usedCards = var_39_6
	var_39_0._oppoEventIds = var_39_8
	var_39_0._randomSeed = 0
	var_39_0._timestamp = 0

	return var_39_0
end

function var_0_0.onEnterSurvivalHall(arg_40_0)
	arg_40_0:onLogin()
end

function var_0_0.onEnterSurvivalExHall(arg_41_0)
	arg_41_0:onLogin()
end

return var_0_0
