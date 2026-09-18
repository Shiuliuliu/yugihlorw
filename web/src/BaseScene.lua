local var_0_0 = class("BaseScene", lc.ExtendCCNode)
local var_0_1 = require("RewardPanel")
local var_0_2 = require("MarqueeManager")

var_0_0.Reloads = {
	"ActivityScene",
	"BadgeExForm2"
}
var_0_0._sceneList = {}

function var_0_0.init(arg_1_0, arg_1_1)
	if lc._runningScene ~= nil and lc._runningScene._sceneId == arg_1_1 then
		return false
	end

	if arg_1_1 == ClientData.SceneId.city then
		ClientView._cityScene = arg_1_0
	elseif arg_1_1 == ClientData.SceneId.world then
		ClientView._worldScene = arg_1_0
	end

	arg_1_0._sceneId = arg_1_1
	arg_1_0._needSyncData = false
	lc._runningScene = arg_1_0

	table.insert(var_0_0._sceneList, arg_1_0)

	arg_1_0._isGuideOnEnter = true

	if lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and ClientView.SCR_W == 1664 then
		local var_1_0 = lc.createSpriteWithMask("res/jpg/img_x.jpg")

		lc.addChildToCenter(arg_1_0._scene, var_1_0, 100)
	end

	return true
end

function var_0_0.onEnter(arg_2_0)
	lc._runningScene = arg_2_0

	local var_2_0 = {
		sceneId = arg_2_0._sceneId,
		sync = arg_2_0._needSyncData
	}

	if GuideManager.isGuideEnabled() then
		GuideManager.showOperateLayer(false)

		var_2_0.guideId = P._guideID
	end

	ClientData.sendUserEvent(var_2_0)

	if arg_2_0._sceneId == ClientData.SceneId.city or arg_2_0._sceneId == ClientData.SceneId.world then
		var_0_2.attach(arg_2_0)
	else
		var_0_2.stop()
	end

	if arg_2_0._needSyncData then
		arg_2_0._needSyncData = false

		arg_2_0:syncData()
	end

	arg_2_0:checkUnlockModule()

	if arg_2_0._isGuideOnEnter and GuideManager.isGuideEnabled() then
		if arg_2_0._needGuideStartStep then
			GuideManager.startStepLater()

			arg_2_0._needGuideStartStep = false
		else
			GuideManager.finishStepLater()
		end
	end

	if ClientView.EnvelopePanel then
		arg_2_0:runAction(lc.sequence(0, function()
			ClientView.EnvelopePanel:removeFromParent()
			ClientView.EnvelopePanel:show()
		end))
	end

	NoticeManager.bindToRunningScene()
	arg_2_0:runAction(lc.sequence(0, function()
		BasePanel.onPanelsExchangeScene()
	end))

	local function var_2_1(arg_5_0)
		if arg_5_0 == cc.KeyCode.KEY_F4 then
			require("BattleData", true)
			require("PlayerBattle", true)
			require("BattleHelper", true)
			require("BattleStaticHelper", true)
			require("BattleSkillCompiler", true)
			require("BattleCombination", true)
			require("BattleSkill", true)
			require("BattleStep", true)
			require("BattleCondition", true)
			require("BattleCard", true)
			require("BattleCardStatus", true)
			require("BattleEvent", true)
			require("BattleAi", true)
			require("BattleTestData", true)
			require("BattleScene", true)
			require("BattleUi", true)
			require("BattleUiTouch", true)
			require("BattleUiView", true)
			require("PlayerUi", true)
			require("SkillUi", true)
			require("StatusUi", true)
			require("CardSprite", true)
			require("BattleAudio", true)
			require("BattleLine", true)
			require("BattleDialog", true)
			require("BattleCardInfoDialog", true)
			require("BattleChatDialog", true)
			require("BattleEventDialog", true)
			require("BattleHelpDialog", true)
			require("BattlePVPDialog", true)
			require("BattleSettingDialog", true)
			require("BattleTaskDialog", true)
			require("BattleResultDialog", true)
			require("BattleListDialog", true)
			require("BattlePosDialog", true)
			require("BattleTestScene", true)

			local var_5_0 = lc.App:loadRes("res/data.lcres")

			for iter_5_0 = 1, #var_5_0 do
				local var_5_1 = var_5_0[iter_5_0]

				if string.hasSuffix(var_5_1, ".bin") then
					Data.parseData(var_5_1, lc.App:getBinData(var_5_1))
					lc.App:unloadRes(var_5_1)
				end
			end

			require("StringEnums", true)

			if lc._runningScene._sceneId == ClientData.SceneId.battle then
				lc.replaceScene(require("BattleTestScene").create())
			end
		elseif arg_5_0 == cc.KeyCode.KEY_F5 then
			local var_5_2 = require("BaseScene", true).Reloads

			for iter_5_1, iter_5_2 in ipairs(var_5_2) do
				print("++++++++++reload", iter_5_2)
				require(iter_5_2, true)
			end

			local var_5_3 = lc.App:loadRes("res/data.lcres")

			for iter_5_3 = 1, #var_5_3 do
				local var_5_4 = var_5_3[iter_5_3]

				if string.hasSuffix(var_5_4, ".bin") then
					Data.parseData(var_5_4, lc.App:getBinData(var_5_4))
					lc.App:unloadRes(var_5_4)
				end
			end

			require("StringEnums", true)
			lc._runningScene:clearPanels()

			if lc._runningScene._sceneId ~= ClientData.SceneId.city then
				ClientView.popScene()
			end
		end
	end

	local var_2_2 = cc.EventListenerKeyboard:create()

	var_2_2:registerScriptHandler(var_2_1, cc.Handler.EVENT_KEYBOARD_RELEASED)
	arg_2_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_2_2, arg_2_0)
end

function var_0_0.onExit(arg_6_0)
	var_0_0._lastSceneId = arg_6_0._sceneId

	for iter_6_0, iter_6_1 in pairs(ToastManager.Toasts) do
		iter_6_1:removeFromParent()
	end

	var_0_2.unattach()
	NoticeManager.unbindFromRunningScene()

	if ClientView.EnvelopePanel then
		ClientView.EnvelopePanel:removeFromParent()
	end

	local var_6_0 = ClientView.getActiveIndicator()

	if var_6_0._isShowing then
		var_6_0:hide()
	end
end

function var_0_0.onCleanup(arg_7_0)
	for iter_7_0 = 1, #var_0_0._sceneList do
		if var_0_0._sceneList[iter_7_0] == arg_7_0 then
			table.remove(var_0_0._sceneList, iter_7_0)

			break
		end
	end

	if sceneId == ClientData.SceneId.city then
		ClientView._cityScene = nil
	end
end

function var_0_0.syncData(arg_8_0)
	return
end

function var_0_0.checkUnlockModule(arg_9_0)
	return
end

function var_0_0.reconnect(arg_10_0, arg_10_1)
	if arg_10_0._reloadDialog ~= nil then
		return
	end

	lc.log("[NETWORK] reconnect~~")

	if arg_10_1 ~= nil then
		if ClientData._heartbeatGapNoticeId ~= nil then
			NoticeManager.hide(ClientData._heartbeatGapNoticeId)

			ClientData._heartbeatGapNoticeId = nil
		end

		local var_10_0 = ccui.RichTextEx:create()

		var_10_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_DARK, 255, arg_10_1, ClientView.TTF_FONT, ClientView.FontSize.S1))

		ClientData._heartbeatLostNoticeId = NoticeManager.show(var_10_0, nil, ClientData._heartbeatLostNoticeId)
	end

	if arg_10_0._sceneId == ClientData.SceneId.region then
		ClientData.reconnectRegionServer()
	elseif arg_10_0._sceneId == ClientData.SceneId.loading then
		ClientData.switchToRegionScene()
	else
		if arg_10_0._sceneId == ClientData.SceneId.battle then
			arg_10_0:pause()
		end

		ClientData.reconnectGameServer()
		ClientView.getActiveIndicator():show(Str(STR.CONNECTING))
	end
end

function var_0_0.reload(arg_11_0, arg_11_1)
	if arg_11_1 == SglMsg_pb.PB_STATUS_INVALID_VERSION or arg_11_1 == SglMsg_pb.PB_STATUS_LOGIN_ELSEWHERE then
		ClientData.switchToUpdateScene()
	else
		arg_11_0:reconnect()
	end
end

function var_0_0.showReloadDialog(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._reloadDialog == nil then
		ClientData._isWorking = false

		print("ClientData._isWorking = false")

		arg_12_0._reloadDialog = true

		local var_12_0 = require("Dialog").showDialog(arg_12_1, function()
			return
		end, true)

		arg_12_0._reloadDialog = var_12_0

		function var_12_0._okHandler()
			if tolua.isnull(arg_12_0) then
				return
			end

			var_12_0:stopActionByTag(100)

			arg_12_0._reloadDialog = nil

			arg_12_0:reload(arg_12_2)
		end

		ClientData._autoReloadCount = (ClientData._autoReloadCount or 0) + 1

		if ClientData._autoReloadCount <= 20 and ClientData._isAutoBattle then
			local var_12_1 = lc.sequence(3, function()
				arg_12_0._reloadDialog:close(true)
			end)

			var_12_1:setTag(100)
			arg_12_0._reloadDialog:runAction(var_12_1)
		end
	end

	GuideManager.stopGuide()
end

function var_0_0.onMsgErrorStatus(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0
	local var_16_1 = arg_16_1.type
	local var_16_2 = false
	local var_16_3 = ClientView.getActiveIndicator():hide()

	if arg_16_2 == SglMsg_pb.PB_STATUS_AUTHENTICATION_FAIL then
		var_16_0 = Str(STR.AUTHENTICATION_FAIL)
		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_INVALID_ARG then
		var_16_0 = Str(STR.INVALID_ARG)
		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_LOGIN_FAIL then
		var_16_0 = Str(STR.LOGIN_FAIL)
		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_USER_BAN_LOGIN then
		local var_16_4 = arg_16_1.Extensions[User_pb.SglUserMsg.user_ban_login_resp] / 1000

		if var_16_4 == 0 then
			var_16_0 = Str(STR.BAN_LOGIN_FOREVER)
		elseif arg_16_1.Extensions[User_pb.SglUserMsg.user_ban_login_resp] == 1 then
			var_16_0 = Str(STR.BAN_LOGIN_CLOSED)
		else
			local var_16_5 = os.date("*t", var_16_4)

			var_16_0 = string.format(Str(STR.BAN_LOGIN), string.format(Str(STR.DATE_FORMAT), var_16_5.year, var_16_5.month, var_16_5.day, var_16_5.hour))
		end

		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_SERVER_ERROR then
		var_16_0 = Str(STR.SERVER_ERROR)
		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_DATA_ERROR then
		var_16_0 = Str(STR.DATA_ERROR)
		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_OUT_OF_SYNC then
		var_16_0 = Str(STR.OUT_OF_SYNC)

		if arg_16_0._sceneId == ClientData.SceneId.battle then
			ClientData._needSendBattleDebugLog = true
		end

		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_LOGIN_ELSEWHERE then
		var_16_0 = Str(STR.LOGIN_ELSEWHERE)
		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_BATTLE_ALREADY_SHARED then
		local var_16_6 = arg_16_1.Extensions[Battle_pb.SglBattleMsg.battle_share_resp]

		for iter_16_0, iter_16_1 in ipairs(var_16_6) do
			P._playerLog:sendLogShared(iter_16_1.log.id)
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_USER_OFFLINE then
		var_16_0 = Str(STR.OPPOSITE_OFFLINE)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_OPPONENT_NOT_FOUND then
		local var_16_7 = arg_16_1.Extensions[World_pb.SglWorldMsg.world_opponent_not_found_resp]

		if arg_16_0.onOpponentNotFound then
			arg_16_0:onOpponentNotFound(var_16_7)
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_SERVER_MAINTENANCE then
		var_16_0 = arg_16_1.Extensions[News_pb.SglNewsMsg.news_maintenance_resp] or Str(STR.SERVER_MAINTENANCE)
		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_USER_UNDER_ATTACK then
		local var_16_8 = arg_16_1.Extensions[User_pb.SglUserMsg.user_under_attack_resp]

		if var_16_1 == SglMsgType_pb.PB_TYPE_USER_LOGIN or var_16_1 == SglMsgType_pb.PB_TYPE_USER_REGISTER then
			local var_16_9 = string.format(Str(STR.UNDER_ATTACKING), var_16_8.name)

			ClientView.getActiveIndicator():show(var_16_9)
		else
			var_16_0 = Str(STR.OPPONENT) .. string.format(Str(STR.UNDER_ATTACKING), var_16_8.name)
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_BATTLE_WAIT then
		if ClientData._socketStatus == ClientData.SocketStatus.login then
			lc._runningScene:onBattleWait()
		else
			var_16_0 = Str(STR.WAIT_BATTLE_RESULT_RETRY)
			var_16_2 = true
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_BATTLE_TIMEOUT then
		var_16_0 = Str(STR.BATTLE_ACTION_TIMEOUT)
		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_USER_ONLINE then
		var_16_0 = Str(STR.OPPOSITE_ONLINE)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_USER_SHILED then
		var_16_0 = Str(STR.OPPOSITE_SHIELD)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_ILLEGAL_NAME then
		local var_16_10 = arg_16_1.Extensions[User_pb.SglUserMsg.user_illegal_input_resp]

		var_16_0 = string.format(Str(STR.CONTAIN_ILLEGAL_NAME), var_16_10)

		local var_16_11 = cc.EventCustom:new(Data.Event.invalid_input)

		lc.Dispatcher:dispatchEvent(var_16_11)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_NAME_EXISTS then
		var_16_0 = Str(STR.NICKNAME_EXISTED)

		local var_16_12 = cc.EventCustom:new(Data.Event.invalid_input)

		lc.Dispatcher:dispatchEvent(var_16_12)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_INVALID_VERSION then
		var_16_0 = Str(STR.NEW_VERSION_AVAILABLE)
		var_16_2 = true
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_OPPONENT_NOT_FOUND then
		var_16_0 = Str(STR.OPPOSITE_NOT_FOUND)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_BATTLE_JOIN_NOT_ALLOWED then
		var_16_0 = Str(STR.BATTLE_JOIN_NOT_ALLOWED)

		if var_16_1 == SglMsgType_pb.PB_TYPE_USER_LOGIN or var_16_1 == SglMsgType_pb.PB_TYPE_USER_REGISTER then
			var_16_2 = true
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_CITY_FOCUSED then
		local var_16_13 = arg_16_1.Extensions[World_pb.SglWorldMsg.world_focus_resp]
		local var_16_14 = var_16_13.info.name
		local var_16_15 = var_16_13.status

		if var_16_15 == SglMsg_pb.PB_FOCUS_RESCUE then
			var_16_0 = string.format(Str(STR.UNION_HELPING_BY), var_16_14)
		elseif var_16_15 == SglMsg_pb.PB_FOCUS_ATTACK or var_16_15 == SglMsg_pb.PB_FOCUS_CHALLENGE then
			var_16_0 = string.format(Str(STR.UNION_ATTACKING_BY), var_16_14)
		else
			var_16_0 = Str(STR.CITY_IS_FOCUSED)
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_INVALID_RESCUE then
		var_16_0 = Str(STR.INVALID_RESCUE)

		local var_16_16 = var_16_3

		var_16_16._sosStatus = SglMsg_pb.PB_SOS_INVALID

		var_16_16:sendMailDirty()
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_ALREADY_IN_UNION then
		var_16_0 = Str(STR.UNION_ALREADY_IN)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_NOT_IN_UNION then
		var_16_0 = Str(STR.UNION_NOT_IN)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_PRIVILEGE_ERROR then
		var_16_0 = Str(STR.UNION_PRIVILEGE_ERROR)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_GIFT_CLAIMED then
		var_16_0 = Str(STR.EXCHANGE_CODE_CLAIMED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_GIFT_DUPLICATE then
		var_16_0 = Str(STR.EXCHANGE_CODE_DUPLICATE)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_GIFT_EXPIRED then
		var_16_0 = Str(STR.EXCHANGE_CODE_EXPIRED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_GIFT_INVALID then
		var_16_0 = Str(STR.EXCHANGE_CODE_INVALID)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_ILLEGAL_INVITE_CODE then
		var_16_0 = Str(STR.INVITE_CODE_INVALID)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_UNION_CLOSED then
		var_16_0 = Str(STR.INVALID_UNION)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_UNION_EXCEEDED then
		var_16_0 = Str(STR.UNION_EXCEEDED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_UNION_APPLY_NOT_ALLOWED then
		var_16_0 = Str(STR.UNION_CANT_APPLY)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_CO_LEADER_EXCEEDED then
		var_16_0 = string.format(Str(STR.UNION_ELDER_MAX), 2)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_UNION_TAG_EXISTS then
		var_16_0 = Str(STR.UNION_FLAG_EXISTS)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_UNION_NAME_EXISTS then
		var_16_0 = Str(STR.UNION_NAME_EXISTS)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_UNION_KICKOUT_FAILED then
		var_16_0 = Str(STR.UNION_KICKOUT_FAILED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_UNION_BOSS_LOCKED then
		var_16_0 = Str(STR.UNION_BOSS_LOCKED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_UNION_BOSS_UNLOCKED then
		var_16_0 = Str(STR.UNION_BOSS_UNLOCKED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_UNION_BOSS_FOCUSED then
		var_16_0 = Str(STR.UNION_BOSS_FOCUSED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_FUND_OWNED then
		var_16_0 = Str(STR.FUND_OWNED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_LET_NOT_FOUND then
		var_16_0 = Str(STR.HIRE_NOT_FOUND)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_UNION_JOIN_CD then
		local var_16_17 = arg_16_1.Extensions[Union_pb.SglUnionMsg.union_join_cd_resp] / 1000

		var_16_0 = string.format(Str(STR.UNION_JOIN_CD), ClientData.formatPeriod(var_16_17))
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_WAR_NOT_STARTED then
		if ClientView._findMatchPanel then
			var_16_0 = string.format(Str(STR.UNION_WAR_NOT_STARTED), MatchNames[ClientView._findMatchPanel._matchType])
		else
			var_16_0 = string.format(Str(STR.UNION_WAR_NOT_STARTED), MatchNames[Data.FindMatchType.union_battle])
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_WAR_ENDED then
		var_16_0 = Str(STR.UNION_WAR_ENDED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_CAMP_DEFEATED then
		var_16_0 = Str(STR.UNION_OPPONENT) .. Str(STR.UNION_CAMP) .. Str(STR.UNION_DEFEATED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_BATTLE_NOT_ENDED then
		var_16_0 = Str(STR.UNION_WAR_BATTLE_NOT_ENDED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_ERROR_CONNECT_BATTLE_SERVER then
		var_16_0 = Str(STR.FIND_MATCH_NO_OPPONENT)

		if ClientData._findMatchPanel then
			ClientData._findMatchPanel:hide()
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_BATTLE_NOT_ALLOWED then
		ToastManager.push(Str(STR.BATTLE_NOT_ALLOWED))

		if ClientData._findMatchPanel then
			ClientData._findMatchPanel:hide()
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_MATCH_JOIN_NOT_ALLOWED then
		P._playerRoom:sendExitRoomDirty()
		P._playerRoom:clear()

		var_16_0 = Str(STR.MATCH_JOIN_NOT_ALLOWED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_MATCH_START_NOT_ALLOWED then
		var_16_0 = Str(STR.MATCH_START_NOT_ALLOWED)

		ClientView.getActiveIndicator():hide()
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_ERROR_CREATE_MATCH then
		var_16_0 = Str(STR.ERROR_CREATE_MATCH)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_MASSWAR_JOIN_NOT_ALLOWED then
		var_16_0 = Str(STR.GROUP_JOIN_NOT_ALLOWED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_LEGEND_CANNOT_FIND then
		var_16_0 = Str(STR.CLASH_EX_LIMIT_TIP)

		if ClientView._findMatchPanel then
			ClientView._findMatchPanel:cancelFind()
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_MASSWAR_KICKOUT_NOT_ALLOWED then
		var_16_0 = Str(STR.GROUP_KICKOUT_NOT_ALLOWED)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_MASSWAR_TEAM_TROOP_LOCKED then
		if arg_16_0._sceneId == ClientData.SceneId.manage_troop then
			arg_16_0:hide()
		end

		var_16_0 = Str(STR.MANAGING_CARDS)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_MASSWAR_ALREADY_IN_TEAM then
		var_16_0 = Str(STR.ALREADY_IN_TEAM)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_MASSWAR_NOT_IN_TEAM then
		var_16_0 = Str(STR.NOT_IN_TEAM)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_MASSWAR_TEAM_NOT_FULL then
		var_16_0 = Str(STR.CANNOT_START_UNION_BATTLE)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_MASSWAR_TROOP_NOT_FULL then
		var_16_0 = Str(STR.TROOP_NOT_FULL)

		if ClientView._findMatchPanel then
			ClientView._findMatchPanel:cancelFind()
		end
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_MASSWAR_CANNOT_LEAVE_TEAM then
		var_16_0 = Str(STR.CANNOT_LEAVE_TEAM)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_INVALID_TUTORIAL then
		var_16_0 = Str(STR.INVALID_REPLAY)

		lc.sendEvent(Data.Event.invalid_tutorial)
	elseif arg_16_2 == SglMsg_pb.PB_STATUS_DARK_DUEL_NOT_STARTED then
		var_16_0 = Str(STR.DARK_DUEL_NOT_STARTED)

		lc.sendEvent(Data.Event.invalid_tutorial)
	end

	if var_16_0 ~= nil then
		if var_16_2 then
			if arg_16_0._reloadDialog == nil then
				arg_16_0:showReloadDialog(var_16_0, arg_16_2)
			end
		else
			ToastManager.push(var_16_0)
		end

		return true
	end

	return false
end

function var_0_0.onMsg(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.type
	local var_17_1 = arg_17_1.status

	if var_17_0 == SglMsgType_pb.PB_TYPE_IAP_START then
		local var_17_2 = arg_17_1.Extensions[Buy_pb.SglBuyMsg.iap_start_resp]

		print("#### iap start resp: ", var_17_2.purchase_id, var_17_2.type)
		ClientData.pay(var_17_2.type, var_17_2.purchase_id)

		return true
	elseif var_17_0 == SglMsgType_pb.PB_TYPE_IAP_FINISH then
		ClientData._isIAPing = false
		ClientData._subChannelVipLevel = nil

		if ClientData._subChannelUid then
			ClientData.sendGetOppoVipLevel(ClientData._subChannelUid)
		end

		local var_17_3 = arg_17_1.Extensions[Buy_pb.SglBuyMsg.iap_finish_resp]

		print("#### iap finish resp: ", var_17_3.purchase_id, var_17_3.type, var_17_3.is_success, var_17_3.fail_desc)
		ClientView.iapFinish()

		if var_17_3.is_success then
			local var_17_4 = var_17_3.type
			local var_17_5 = P._vip
			local var_17_6 = ClientData.getPrice(var_17_4)
			local var_17_7, var_17_8 = ClientData.getIngot(var_17_4)
			local var_17_9 = ClientData.isRecharged(var_17_4)

			ClientData.setRecharged(var_17_4)

			if var_17_4 == Data.PurchaseType.month_card_1 or var_17_4 == Data.PurchaseType.month_card_2 then
				if ClientData.isAppStoreReviewing() then
					local var_17_10 = var_17_4 == Data.PurchaseType.month_card_1 and 4000 or 10000

					P:changeResource(Data.ResType.gold, var_17_10)
					ClientView.showResChangeText(arg_17_0._scene, Data.ResType.gold, var_17_10)
					ToastManager.push(string.format(Str(STR.BUY_GOLD_SUCCESS), var_17_10))
				else
					P:changeVIPExp(var_17_7)

					local var_17_11 = var_17_4 == Data.PurchaseType.month_card_1 and 9003 or 9015
					local var_17_12, var_17_13, var_17_14, var_17_15 = ClientData.getServerDate()
					local var_17_16 = Data._bonusInfo[var_17_11 + var_17_14 - 1]
					local var_17_17 = require("RewardPanel")
					local var_17_18 = {}

					for iter_17_0 = 1, #var_17_16._rid do
						var_17_18[#var_17_18 + 1] = {
							info_id = var_17_16._rid[iter_17_0],
							num = var_17_16._count[iter_17_0]
						}
					end

					local var_17_19 = var_17_4 - Data.PurchaseType.month_card_1 + 1
					local var_17_20 = P._playerBonus._bonusMonthCardBought[var_17_19]._value

					if var_17_20 == 0 then
						if var_17_19 == 1 then
							P._monthCardDay1 = P._monthCardDay1 + 31
						else
							P._monthCardDay2 = P._monthCardDay2 + 31
						end
					elseif var_17_20 == 1 or var_17_20 == 2 then
						local var_17_21 = P._playerBonus._bonusMonthCardPackage[(var_17_19 - 1) * 2 + var_17_20]._info

						for iter_17_1 = 1, #var_17_21._rid do
							var_17_18[#var_17_18 + 1] = {
								info_id = var_17_21._rid[iter_17_1],
								num = var_17_21._count[iter_17_1]
							}
						end
					end

					P._playerBonus._bonusMonthCardBought[var_17_19]._value = P._playerBonus._bonusMonthCardBought[var_17_19]._value + 1

					var_17_17.create(var_17_18, var_17_17.MODE_BUY):show()
					ToastManager.push(Str(STR.BUY_MONTH_CARD_SUCCESS))
				end

				P:sendMonthCardDirty()
			elseif var_17_4 == Data.PurchaseType.month_card_3 or var_17_4 == Data.PurchaseType.month_card_4 or var_17_4 == Data.PurchaseType.month_card_5 or var_17_4 == Data.PurchaseType.month_card_6 then
				P:changeVIPExp(var_17_7)

				local var_17_22 = require("RewardPanel")
				local var_17_23 = {}

				var_17_23[#var_17_23 + 1] = {
					info_id = Data.ResType.ingot,
					num = var_17_7
				}

				local var_17_24 = P._playerBonus:getBonusByPurchaseType(var_17_4)

				var_17_24._value = var_17_24._value + 1

				if var_17_4 == Data.PurchaseType.month_card_4 then
					local var_17_25 = 86400
					local var_17_26 = math.min(30, math.floor(ClientData.getCurrentTime() / var_17_25) - math.floor(P._regTime / var_17_25))

					for iter_17_2, iter_17_3 in ipairs(var_17_24._info._rid) do
						var_17_23[#var_17_23 + 1] = {
							info_id = iter_17_3,
							num = var_17_24._info._count[iter_17_2] * var_17_26
						}
					end
				end

				var_17_22.create(var_17_23, var_17_22.MODE_BUY):show()
				ToastManager.push(Str(STR.BUY_MONTH_CARD_SUCCESS3))
				P:sendMonthCardDirty()
			elseif var_17_4 == Data.PurchaseType.badge_ex then
				P._playerBadgeEx:setBuyBadgeStatus(true)
				P._playerBadgeEx:addGrade(1)
				ToastManager.push(Str(STR.BUYSUCCESS))
				lc.sendEvent(Data.Event.badge_reward_ex, true)
			elseif var_17_4 == Data.PurchaseType.badge_ex2 then
				P._playerBadgeEx2:setBuyBadgeStatus(true)
				P._playerBadgeEx2:addGrade(1)
				ToastManager.push(Str(STR.BUYSUCCESS))
				lc.sendEvent(Data.Event.badge_reward_ex2, true)
			elseif var_17_4 == Data.PurchaseType.arena_privilege_1 or var_17_4 == Data.PurchaseType.arena_privilege_2 then
				local var_17_27 = P._playerBonus:getBonusIdByPurchaseType(var_17_4)
				local var_17_28 = Data._bonusInfo[var_17_27]
				local var_17_29 = {}

				var_17_29[#var_17_29 + 1] = {
					info_id = Data.ResType.ingot,
					num = var_17_7
				}
				P._playerFindLadder._rollTimes = 0

				P._playerActivity:addPurchaseRemainDay(var_17_4, 7)

				local var_17_30 = var_0_1.create(var_17_29, var_0_1.MODE_BUY)

				var_17_30:show()

				function var_17_30._exitFunc()
					local var_18_0 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

					var_18_0:init(false, true)

					local var_18_1 = var_17_4 - Data.PurchaseType.arena_privilege_1 + 1
					local var_18_2 = lc.createSprite("arena_spr_" .. var_18_1)
					local var_18_3 = lc.createSprite("arena_light_" .. var_18_1)

					var_18_3:setScale(5)
					var_18_3:runAction(lc.rep(lc.sequence(lc.scaleTo(0.5, 4), lc.scaleTo(0.5, 6))))

					local var_18_4 = ClientView.createBoldRichText(var_17_4 == Data.PurchaseType.arena_privilege_1 and Str(STR.BUY_ARENA_SUCCESS) or Str(STR.BUY_ARENA_SUCCESS_2), ClientView.RICHTEXT_PARAM_LIGHT_S1)

					lc.addChildToCenter(var_18_2, var_18_3, -1)
					lc.addChildToCenter(var_18_0, var_18_2)
					lc.addChildToPos(var_18_0, var_18_4, cc.p(lc.x(var_18_2), lc.top(var_18_2) + 100))
					var_18_2:setScale(0)
					var_18_2:runAction(lc.scaleTo(0.3, 1))
					var_18_0:show()
				end

				lc.sendEvent(Data.Event.arena_privilege_dirty)
			elseif var_17_4 == Data.PurchaseType.survival_privilege_1 or var_17_4 == Data.PurchaseType.survival_privilege_2 then
				local var_17_31 = P._playerBonus:getBonusIdByPurchaseType(var_17_4)
				local var_17_32 = Data._bonusInfo[var_17_31]
				local var_17_33 = {}

				var_17_33[#var_17_33 + 1] = {
					info_id = Data.ResType.ingot,
					num = var_17_7
				}
				P._playerFindLadder._rollTimes = 0

				P._playerActivity:addPurchaseRemainDay(var_17_4, 7)

				local var_17_34 = var_0_1.create(var_17_33, var_0_1.MODE_BUY)

				var_17_34:show()

				function var_17_34._exitFunc()
					local var_19_0 = require("BasePanel").new(lc.EXTEND_LAYOUT_MASK)

					var_19_0:init(false, true)

					local var_19_1 = var_17_4 - Data.PurchaseType.survival_privilege_1 + 1
					local var_19_2 = lc.createSprite("survival_spr_" .. var_19_1)
					local var_19_3 = lc.createSprite("survival_light_" .. var_19_1)

					var_19_3:setScale(5)
					var_19_3:runAction(lc.rep(lc.sequence(lc.scaleTo(0.5, 4), lc.scaleTo(0.5, 6))))

					local var_19_4 = ClientView.createBoldRichText(var_17_4 == Data.PurchaseType.survival_privilege_1 and Str(STR.BUY_SURVIVAL_SUCCESS) or Str(STR.BUY_SURVIVAL_SUCCESS_2), ClientView.RICHTEXT_PARAM_LIGHT_S1)

					lc.addChildToCenter(var_19_2, var_19_3, -1)
					lc.addChildToCenter(var_19_0, var_19_2)
					lc.addChildToPos(var_19_0, var_19_4, cc.p(lc.x(var_19_2), lc.top(var_19_2) + 100))
					var_19_2:setScale(0)
					var_19_2:runAction(lc.scaleTo(0.3, 1))
					var_19_0:show()
				end

				lc.sendEvent(Data.Event.survival_privilege_dirty)
			elseif var_17_4 == Data.PurchaseType.fund then
				if ClientData.isAppStoreReviewing() then
					local var_17_35 = 14000

					P:changeResource(Data.ResType.gold, var_17_35)
					ClientView.showResChangeText(arg_17_0._scene, Data.ResType.gold, var_17_35)
					ToastManager.push(string.format(Str(STR.BUY_GOLD_SUCCESS), var_17_35))
				else
					if var_17_9 then
						local var_17_36 = require("RewardPanel")

						var_17_36.create({
							{
								num = 1,
								info_id = Data.PropsId.union_fund
							}
						}, var_17_36.MODE_BUY):show()
					else
						ToastManager.push(Str(STR.BUY_FUND_SUCCESS))
					end

					P:changeVIPExp(var_17_7)
					P._playerBonus:onFundLevelDirty(true)
				end

				P:sendFundDirty()
			elseif var_17_4 >= Data.PurchaseType.personal_fund_1 and var_17_4 <= Data.PurchaseType.personal_fund_7 then
				P:changeVIPExp(var_17_6 * 10)

				P._playerActivity._personalFundStatus[var_17_4] = ClientData.getExpireTimestamp(0)

				P._playerBonus:updatePersonalFundValue()
				ToastManager.push(Str(STR.BUY_PERSONAL_FUND_SUCCESS))
			elseif var_17_4 >= Data.PurchaseType.rare_gift_1 and var_17_4 <= Data.PurchaseType.rare_gift_max then
				local var_17_37 = (var_17_4 - Data.PurchaseType.rare_gift_1 + 1 + 100) * 1000 + 1
				local var_17_38 = Data._recruitInfo[var_17_37]._param[8]

				if var_17_38 then
					P._playerBonus._bonuses[var_17_38]._isClaimed = true
				end

				if arg_17_0._rareGiftRewards then
					local var_17_39 = arg_17_0._rareGiftRewards[var_17_4]

					if var_17_39 then
						var_0_1.create(var_17_39, var_0_1.MODE_BUY):show()
					end
				end

				P:changeVIPExp(var_17_6 * 10)
				ToastManager.push(Str(STR.BUY_RARE_GIFT_SUCCESS))
				lc.sendEvent(Data.Event.rare_gift_dirty)
			elseif var_17_4 == Data.PurchaseType.daily_1 or var_17_4 == Data.PurchaseType.daily_2 or var_17_4 == Data.PurchaseType.daily_3 then
				local var_17_40 = P._playerBonus:getBonusByPurchaseType(var_17_4)
				local var_17_41 = require("RewardPanel")
				local var_17_42 = {}

				for iter_17_4 = 1, #var_17_40._info._rid do
					var_17_42[#var_17_42 + 1] = {
						info_id = var_17_40._info._rid[iter_17_4],
						num = var_17_40._info._count[iter_17_4]
					}
				end

				var_17_41.create(var_17_42, var_17_41.MODE_BUY):show()
				P:changeVIPExp(var_17_7)

				var_17_40._isClaimed = true

				if var_17_4 == Data.PurchaseType.daily_1 or var_17_4 == Data.PurchaseType.daily_2 then
					var_17_40 = P._playerBonus._packageBonus[1306]
				end

				var_17_40._value = var_17_40._value + 1

				P:sendPackageDirty()
			elseif var_17_4 >= Data.PurchaseType.skill_1 and var_17_4 <= Data.PurchaseType.skill_max then
				local var_17_43 = P._playerBonus:getBonusByPurchaseType(var_17_4)
				local var_17_44 = require("RewardPanel")
				local var_17_45 = {}

				for iter_17_5 = 1, #var_17_43._info._rid do
					var_17_45[#var_17_45 + 1] = {
						info_id = var_17_43._info._rid[iter_17_5],
						num = var_17_43._info._count[iter_17_5]
					}
				end

				var_17_44.create(var_17_45, var_17_44.MODE_BUY):show()
				P:changeVIPExp(var_17_7)

				var_17_43._isClaimed = true

				P:sendPackageDirty()
			elseif var_17_4 >= Data.PurchaseType.package_1 and var_17_4 < Data.PurchaseType.limit_minus_2 then
				local var_17_46 = P._playerBonus._packageBonus[var_17_4 - Data.PurchaseType.package_1 + 1121]
				local var_17_47 = require("RewardPanel")
				local var_17_48 = {}

				if ClientData.isAppStoreReviewing() then
					ClientData.modifyPackageBonus(var_17_46._info, var_17_4)
				end

				for iter_17_6 = 1, #var_17_46._info._rid do
					var_17_48[#var_17_48 + 1] = {
						info_id = var_17_46._info._rid[iter_17_6],
						num = var_17_46._info._count[iter_17_6]
					}
				end

				var_17_47.create(var_17_48, var_17_47.MODE_BUY):show()
				P:changeVIPExp(var_17_7)

				var_17_46._isClaimed = true

				P:sendPackageDirty()
			elseif var_17_4 >= Data.PurchaseType.limit_minus_2 and var_17_4 <= Data.PurchaseType.limit_2 then
				local var_17_49 = ClientData.getValidActivityByParam(var_17_4)
				local var_17_50 = P._playerBonus._bonuses[var_17_49._bonusId[1]]
				local var_17_51 = (var_17_49._type[1] == 1701 or var_17_49._type[1] == 1705) and var_17_50 or P._playerBonus._bonuses[var_17_49._bonusId[math.min(3, var_17_50._value + 1)]]
				local var_17_52 = require("RewardPanel")
				local var_17_53 = {}

				for iter_17_7 = 1, #var_17_51._info._rid do
					var_17_53[#var_17_53 + 1] = {
						info_id = var_17_51._info._rid[iter_17_7],
						num = var_17_51._info._count[iter_17_7]
					}
				end

				var_17_52.create(var_17_53, var_17_52.MODE_BUY):show()
				P:changeVIPExp(var_17_7)

				var_17_51._isClaimed = true
				var_17_50._value = var_17_50._value + 1

				P:sendPackageDirty()
			elseif var_17_4 >= Data.PurchaseType.active_1 and var_17_4 <= Data.PurchaseType.active_2 then
				local var_17_54 = P._playerBonus._bonusActiveGift[var_17_4 - Data.PurchaseType.active_1 + 1]
				local var_17_55 = require("RewardPanel")
				local var_17_56 = {}

				for iter_17_8 = 1, #var_17_54._info._rid do
					var_17_56[#var_17_56 + 1] = {
						info_id = var_17_54._info._rid[iter_17_8],
						num = var_17_54._info._count[iter_17_8]
					}
				end

				var_17_55.create(var_17_56, var_17_55.MODE_BUY):show()
				P:changeVIPExp(var_17_7)

				var_17_54._isClaimed = true
				var_17_54._value = var_17_54._value + 1

				P:sendPackageDirty()
			elseif var_17_4 >= Data.PurchaseType.privilege_1 and var_17_4 <= Data.PurchaseType.privilege_2 then
				local var_17_57 = P._playerBonus._bonusPrivilegeGift[var_17_4 - Data.PurchaseType.privilege_1 + 1]
				local var_17_58 = require("RewardPanel")
				local var_17_59 = {}

				for iter_17_9 = 1, #var_17_57._info._rid do
					var_17_59[#var_17_59 + 1] = {
						info_id = var_17_57._info._rid[iter_17_9],
						num = var_17_57._info._count[iter_17_9]
					}
				end

				var_17_58.create(var_17_59, var_17_58.MODE_BUY):show()
				P:changeVIPExp(var_17_7)

				var_17_57._isClaimed = true
				var_17_57._value = var_17_57._value + 1

				P:sendPackageDirty()

				if var_17_4 == Data.PurchaseType.privilege_2 then
					P._playerActivity._privilegeStamp = ClientData.getExpireTimestamp(1)
				else
					local var_17_60 = ClientData.getValidActivityByType(528)

					if var_17_60 then
						local var_17_61 = ClientData.parseTimeStr(var_17_60._endTime)

						P._playerActivity._privilegeStamp = var_17_61
					end
				end
			elseif var_17_4 >= Data.PurchaseType.cumulative_newbie_start and var_17_4 <= Data.PurchaseType.cumulative_newbie_end then
				P:changeVIPExp(var_17_7)

				if P._playerActivity._actCharge then
					P._playerActivity._chargeIngot = P._playerActivity._chargeIngot + var_17_7
				end

				local var_17_62 = {}
				local var_17_63 = math.floor(var_17_4 % 100 / 10) + 1
				local var_17_64 = Data.ActivityType.cumulative_newbie_start + var_17_63 - 1
				local var_17_65 = P._playerBonus._bonusCumulativeNewBie[var_17_63]

				for iter_17_10, iter_17_11 in ipairs(var_17_65) do
					iter_17_11._value = iter_17_11._value + var_17_7

					local var_17_66 = iter_17_11._info

					if iter_17_11._value >= var_17_66._val and iter_17_11._value - var_17_7 < var_17_66._val then
						var_17_62[#var_17_62 + 1] = iter_17_11
					end
				end

				local var_17_67 = {}

				if #var_17_62 > 0 then
					for iter_17_12, iter_17_13 in ipairs(var_17_62) do
						local var_17_68 = iter_17_13._info

						for iter_17_14 = 1, #var_17_68._rid do
							var_17_67[#var_17_67 + 1] = {
								info_id = var_17_68._rid[iter_17_14],
								num = var_17_68._count[iter_17_14]
							}
						end

						iter_17_13._isClaimed = true
					end
				end

				var_0_1.create(var_17_67, var_0_1.MODE_BUY):show()
				lc.sendEvent(Data.Event.package_dirty)
			else
				if P._playerActivity._actCharge and var_17_4 < Data.PurchaseType.month_card_1 then
					P._playerActivity._chargeIngot = P._playerActivity._chargeIngot + var_17_7

					P:sendFundDirty()
				end

				P:changeResource(Data.ResType.ingot, var_17_7 + var_17_8)
				P:changeVIPExp(var_17_7)
				ClientView.showResChangeText(arg_17_0._scene, Data.ResType.ingot, var_17_7 + var_17_8)
				P._playerActivity:checkChargeDays()

				local var_17_69 = {}

				if var_17_8 > 0 then
					var_17_69[1] = string.format(Str(STR.BUY_INGOT_SUCCESS), var_17_7) .. string.format(Str(STR.CHARGE_BONUS_INGOT), var_17_8)
				else
					var_17_69[1] = string.format(Str(STR.BUY_INGOT_SUCCESS), var_17_7)
				end

				if P._playerActivity._actChargeGift and var_17_4 < Data.PurchaseType.month_card_1 then
					P:addResource(Data.PropsId.cumulative_exchange_token, 1, var_17_7 / 10, false)

					var_17_69[2] = string.format(Str(STR.GET_BONUS_EXTRA), ClientData.getNameByInfoId(Data.PropsId.cumulative_exchange_token), var_17_7 / 10)
				end

				ToastManager.pushArray(var_17_69)
			end

			if var_17_5 < P._vip then
				require("LevelUpPanel").createVip(var_17_5, P._vip):show()
			end

			if P._playerActivity._actRebate then
				P._playerActivity._rebateIngot = P._playerActivity._rebateIngot + var_17_7
			end

			if P._playerActivity._actDailyChargeTimes then
				P._ingotDailyRecharge = P._ingotDailyRecharge + 1
			end

			local var_17_70 = cc.EventCustom:new(Data.Event.recharge_success)

			var_17_70._type = var_17_4

			lc.Dispatcher:dispatchEvent(var_17_70)
		else
			local var_17_71 = Str(STR.BUYFAIL)

			print(var_17_71)
			ToastManager.push(var_17_71)
		end

		return true
	elseif var_17_0 == SglMsgType_pb.PB_TYPE_WORLD_SWEEP_COPY or var_17_0 == SglMsgType_pb.PB_TYPE_WORLD_SWEEP_COPY_ONCE then
		local var_17_72 = ClientView.getActiveIndicator():hide()
		local var_17_73 = arg_17_1.Extensions[World_pb.SglWorldMsg.world_sweep_resp]

		ClientView.showSweepForm(var_17_73)

		local var_17_74 = #var_17_73.result
		local var_17_75 = P:getBattleCost()

		P:changeResource(Data.ResType.grain, -var_17_75)
		P:accountCopyWin(var_17_72._type)
		lc.sendEvent(Data.Event.copy_times_dirty, {
			_type = var_17_72._type
		})

		return true
	elseif var_17_0 == SglMsgType_pb.PB_TYPE_BONUS_CLAIM_ENVELOPE or var_17_0 == SglMsgType_pb.PB_TYPE_BONUS_CLAIM_CHARGE_ENVELOPE then
		ClientView.getActiveIndicator():hide()
	end

	return false
end

function var_0_0.onError(arg_20_0, arg_20_1)
	arg_20_0:showReloadDialog(Str(STR.CRC_ERROR))

	return true
end

function var_0_0.onConnectFailEvent(arg_21_0, arg_21_1)
	if arg_21_1._socket ~= ClientData._socket then
		return
	end

	arg_21_0:showReloadDialog(Str(STR.DISCONNECT))
	ClientData.writeSocketLog(ClientData.SocketLog.disconnect)
end

function var_0_0.onDisconnectEvent(arg_22_0, arg_22_1)
	if arg_22_1._socket ~= ClientData._socket then
		return
	end

	arg_22_0:showReloadDialog(Str(STR.HEARTBEAT_LOST))
end

function var_0_0.onIdle(arg_23_0)
	ClientData.disconnect(false)
	arg_23_0:showReloadDialog(Str(STR.IDLE))
end

function var_0_0.onReachabilityChanged(arg_24_0)
	return
end

function var_0_0.onGameCenterIdChanged(arg_25_0)
	ClientData.disconnect(false)
	arg_25_0:showReloadDialog(Str(STR.GAMECENTER_ID_CHANGED), SglMsg_pb.PB_STATUS_INVALID_VERSION)
end

function var_0_0.onLogin(arg_26_0)
	ClientView.getActiveIndicator():hide()

	if GuideManager.isGuideEnabled() then
		ClientView.popScene(true)
		lc.replaceScene(require("LoadingScene").create())

		return true
	end

	if lc._runningScene._sceneId ~= ClientData.SceneId.loading and lc._runningScene._sceneId ~= ClientData.SceneId.res_switch and lc._runningScene._sceneId ~= ClientData.SceneId.battle then
		arg_26_0:clearPanels()

		for iter_26_0 = 1, #var_0_0._sceneList do
			if var_0_0._sceneList[iter_26_0] ~= arg_26_0 then
				var_0_0._sceneList[iter_26_0]._needSyncData = true
			end
		end

		arg_26_0:syncData()
	end

	return false
end

function var_0_0.onMail(arg_27_0, arg_27_1)
	if arg_27_1 == require("PlayerMail").Event.send_ok then
		ToastManager.push(Str(STR.SEND_SUCCESS))
	end
end

function var_0_0.onAttack(arg_28_0, arg_28_1)
	arg_28_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		ClientView.popScene(true)
		lc.replaceScene(require("ResSwitchScene").create(arg_28_0._sceneId, ClientData.SceneId.battle, arg_28_1))
	end)))

	if arg_28_1._battleType == Data.BattleType.task then
		-- block empty
	end
end

function var_0_0.onEnterRoom(arg_30_0)
	if not P._playerRoom:getMyRoom() then
		return
	end

	if arg_30_0._sceneId == ClientData.SceneId.battle then
		arg_30_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			lc.replaceScene(require("ResSwitchScene").create(arg_30_0._sceneId, ClientData.SceneId.in_room))
		end)))
	else
		lc.pushScene(require("InRoomScene").create())
	end
end

function var_0_0.onEnterSurvivalHall(arg_32_0)
	ClientView.getActiveIndicator():hide()

	if ClientView._findMatchPanel then
		ClientView._findMatchPanel:hide()

		ClientView._findMatchPanel = nil
	end

	if not P._playerFindSurvival._isInHall then
		return
	end

	if arg_32_0._sceneId == ClientData.SceneId.battle then
		-- block empty
	else
		lc.pushScene(require("SurvivalHallScene").create())
	end
end

function var_0_0.onEnterSurvivalExHall(arg_33_0)
	ClientView.getActiveIndicator():hide()

	if ClientView._findMatchPanel then
		ClientView._findMatchPanel:hide()

		ClientView._findMatchPanel = nil
	end

	if not P._playerFindSurvivalEx._isInHall then
		return
	end

	if arg_33_0._sceneId == ClientData.SceneId.battle then
		-- block empty
	else
		lc.pushScene(require("SurvivalExHallScene").create())
	end
end

function var_0_0.onChallenge(arg_34_0, arg_34_1)
	arg_34_0:runAction(lc.sequence(0.5, function()
		ClientView.popScene(true)
		lc.replaceScene(require("ResSwitchScene").create(arg_34_0._sceneId, ClientData.SceneId.battle, arg_34_1))
	end))

	ClientData._focusCityId = arg_34_1._levelId
end

function var_0_0.onExpedition(arg_36_0, arg_36_1)
	arg_36_0:runAction(lc.sequence(0.5, function()
		ClientView.popScene(true)
		lc.replaceScene(require("ResSwitchScene").create(arg_36_0._sceneId, ClientData.SceneId.battle, arg_36_1))
	end))
end

function var_0_0.onExpeditionEx(arg_38_0, arg_38_1)
	arg_38_0:runAction(lc.sequence(0.5, function()
		ClientView.popScene(true)
		lc.replaceScene(require("ResSwitchScene").create(arg_38_0._sceneId, ClientData.SceneId.battle, arg_38_1))
	end))
end

function var_0_0.onHorse(arg_40_0, arg_40_1)
	arg_40_0:runAction(lc.sequence(0.5, function()
		ClientView.popScene(true)
		lc.replaceScene(require("ResSwitchScene").create(arg_40_0._sceneId, ClientData.SceneId.battle, arg_40_1))
	end))
end

function var_0_0.onRobExp(arg_42_0, arg_42_1)
	arg_42_0:runAction(lc.sequence(0.5, function()
		ClientView.popScene(true)
		lc.replaceScene(require("ResSwitchScene").create(arg_42_0._sceneId, ClientData.SceneId.battle, arg_42_1))
	end))
end

function var_0_0.onBoss(arg_44_0, arg_44_1)
	arg_44_0:runAction(lc.sequence(0.5, function()
		ClientView.popScene(true)
		lc.replaceScene(require("ResSwitchScene").create(arg_44_0._sceneId, ClientData.SceneId.battle, arg_44_1))
	end))
end

function var_0_0.onElite(arg_46_0, arg_46_1)
	arg_46_0:runAction(lc.sequence(0.5, function()
		ClientView.popScene(true)
		lc.replaceScene(require("ResSwitchScene").create(arg_46_0._sceneId, ClientData.SceneId.battle, arg_46_1))
	end))
end

function var_0_0.onGold(arg_48_0, arg_48_1)
	return
end

function var_0_0.onFindStart(arg_49_0, arg_49_1)
	ClientView.getActiveIndicator():hide()
	ClientView.popScene(true)
	lc.replaceScene(require("ResSwitchScene").create(arg_49_0._sceneId, ClientData.SceneId.battle, arg_49_1))
end

function var_0_0.onReplay(arg_50_0, arg_50_1)
	ClientView.getActiveIndicator():hide()
	ClientView.popScene(true)
	lc.replaceScene(require("ResSwitchScene").create(arg_50_0._sceneId, ClientData.SceneId.battle, arg_50_1))
end

function var_0_0.onFriendBattle(arg_51_0, arg_51_1)
	ClientView.getActiveIndicator():hide()
	ClientView.popScene(true)
	lc.replaceScene(require("ResSwitchScene").create(arg_51_0._sceneId, ClientData.SceneId.battle, arg_51_1))
end

function var_0_0.onBattleRecover(arg_52_0, arg_52_1)
	ClientView.getActiveIndicator():hide()
	ClientView.popScene(true)

	lc._runningScene = nil

	lc.replaceScene(require("ResSwitchScene").create(arg_52_0._sceneId, ClientData.SceneId.battle, arg_52_1))
end

function var_0_0.onBattleEnd(arg_53_0, arg_53_1)
	arg_53_0:reconnect()
end

function var_0_0.onBattleWait(arg_54_0)
	ClientView.getActiveIndicator():show(Str(STR.WAIT_BATTLE_RESULT))
end

function var_0_0.onUnionAttack(arg_55_0, arg_55_1)
	arg_55_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		ClientView.popScene(true)
		lc.replaceScene(require("ResSwitchScene").create(arg_55_0._sceneId, ClientData.SceneId.battle, arg_55_1))
	end)))
end

function var_0_0.onGuide(arg_57_0, arg_57_1)
	return
end

function var_0_0.onHelp(arg_58_0)
	return
end

function var_0_0.seenByCamera3D(arg_59_0, arg_59_1)
	local var_59_0 = ClientData._camera3D

	if var_59_0:getParent() ~= arg_59_0 then
		if var_59_0:getParent() then
			var_59_0:removeFromParent()
		end

		arg_59_0:addChild(var_59_0)
	end

	arg_59_1:setCameraMask(ClientData.CAMERA_3D_FLAG)
end

function var_0_0.clearPanels(arg_60_0)
	local var_60_0 = {}
	local var_60_1 = require("BasePanel")

	for iter_60_0 = 1, #var_60_1.Panels do
		if var_60_1.Panels[iter_60_0] ~= arg_60_0._reloadDialog then
			table.insert(var_60_0, var_60_1.Panels[iter_60_0])
		end
	end

	for iter_60_1 = 1, #var_60_0 do
		var_60_0[iter_60_1]:hide(true)
	end
end

function var_0_0.checkWorking(arg_61_0)
	if ClientData._isWorking == false then
		if arg_61_0._reloadDialog and arg_61_0._reloadDialog ~= true and not tolua.isnull(arg_61_0._reloadDialog) then
			ClientData._isWorking = false
		else
			arg_61_0:showReloadDialog(Str(STR.DISCONNECT))
		end
	end

	return ClientData._isWorking
end

function var_0_0.setSwallowAllTouches(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_0._swallowLayer then
		arg_62_0._swallowLayer:removeFromParent()

		arg_62_0._swallowLayer = nil
	end

	if not arg_62_1 then
		return
	end

	local var_62_0 = lc.createMaskLayer(0)

	lc.addChildToCenter(arg_62_0._scene, var_62_0, ClientData.ZOrder.swallow)

	arg_62_0._swallowLayer = var_62_0

	if arg_62_2 then
		arg_62_0._swallowLayer:runAction(lc.sequence(arg_62_2, function()
			arg_62_0:setSwallowAllTouches(false)
		end))
	end
end

BaseScene = var_0_0

return var_0_0
