local var_0_0 = class("FindMatchPanel", BasePanel)
local var_0_1 = 45

MatchNames = {
	"",
	Str(STR.FIND_ARENA_TITLE),
	Str(STR.FIND_CLASH_TITLE),
	Str(STR.FIND_HALL_TITLE),
	Str(STR.FIND_UNION_BATTLE_TITLE),
	Str(STR.DARK_BATTLE),
	Str(STR.PUBG),
	Str(STR.PUBG),
	Str(STR.FIND_CLASH_EX_TITLE)
}

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, true)

	arg_2_0._matchType = arg_2_1

	local var_2_0 = DragonBones.create("search")

	var_2_0:gotoAndPlay("effect1")
	lc.addChildToPos(arg_2_0, var_2_0, cc.p(lc.w(arg_2_0) / 2, 500))

	arg_2_0._bones = var_2_0

	local var_2_1 = ClientView.createScale9ShaderButton("img_btn_3", function()
		arg_2_0:cancelFind()
	end, ClientView.CRECT_BUTTON, 200)

	var_2_1:addLabel(Str(STR.CANCEL))
	lc.addChildToPos(arg_2_0, var_2_1, cc.p(lc.w(arg_2_0) / 2, 280))

	arg_2_0._btnCancel = var_2_1

	local var_2_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, "0")

	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.x(var_2_1), lc.bottom(var_2_1) - 20 - lc.h(var_2_2) / 2))
	var_2_2:setVisible(false)

	arg_2_0._countDownDuration = var_0_1
	arg_2_0._formatStr = Str(STR.FIND_MATCH_COUNTDOWN)

	if arg_2_1 == Data.FindMatchType.survival_ex then
		arg_2_0._countDownDuration = 180
		arg_2_0._formatStr = Str(STR.FIND_MATCH_COUNTDOWN_SURVIVAL_EX)
	end

	arg_2_0._countDownTimestamp = ClientData.getCurrentTime()

	arg_2_0:scheduleUpdateWithPriorityLua(function(arg_4_0)
		if arg_2_1 == Data.FindMatchType.survival_ex and P._playerFindSurvivalEx._openTimestamp ~= 0 then
			arg_2_0._countDownDuration = P._playerFindSurvivalEx._openTimestamp - arg_2_0._countDownTimestamp
		end

		local var_4_0 = math.max(0, arg_2_0._countDownDuration - math.floor(ClientData.getCurrentTime() - arg_2_0._countDownTimestamp))

		if arg_2_1 == Data.FindMatchType.survival_ex and var_4_0 == 0 then
			if P._playerFindSurvivalEx._hallUserNum <= 1 then
				ToastManager.push(Str(STR.FIND_MATCH_COUNTDOWN_SURVIVAL_EX_TIME_OUT))
				arg_2_0:cancelFind()

				return
			end

			arg_2_0:unscheduleUpdate()
			var_2_2:setString(Str(STR.FIND_MATCH_COUNTDOWN_SURVIVAL_EX_0))
		end

		var_2_2:setString(string.format(arg_2_0._formatStr, var_4_0))
	end, 0)

	if ClientData.isAppStoreReviewing() then
		return
	end

	local var_2_3 = lc.createSprite({
		_name = "img_com_bg_7",
		_crect = ClientView.CRECT_COM_BG7,
		_size = cc.size(500, 60)
	})

	var_2_3:setColor(ClientView.COLOR_TEXT_DARK)
	var_2_3:setOpacity(180)
	lc.addChildToPos(arg_2_0, var_2_3, cc.p(lc.w(arg_2_0) / 2, 100))

	arg_2_0._tipBg = var_2_3
	arg_2_0._tipSids = {}

	for iter_2_0, iter_2_1 in pairs(Data._tipInfo) do
		table.insert(arg_2_0._tipSids, iter_2_1._nameSid)
	end

	arg_2_0._tipIndex = math.random(1, #arg_2_0._tipSids)

	local var_2_4 = ClientView.createTTF(Str(arg_2_0._tipSids[arg_2_0._tipIndex]), nil, nil, cc.size(400, 0))

	lc.addChildToCenter(var_2_3, var_2_4)

	arg_2_0._tip = var_2_4

	local var_2_5 = 100
	local var_2_6 = lc.h(var_2_3)
	local var_2_7 = ClientView.createArrowButton(true, cc.size(var_2_5, var_2_6), function(arg_5_0)
		arg_2_0:onBtnArrow(arg_5_0)
	end)

	lc.addChildToPos(arg_2_0, var_2_7, cc.p(lc.left(var_2_3) - var_2_5 / 2 - 10, lc.y(var_2_3)))

	arg_2_0._btnArrowLeft = var_2_7

	local var_2_8 = ClientView.createArrowButton(false, cc.size(var_2_5, var_2_6), function(arg_6_0)
		arg_2_0:onBtnArrow(arg_6_0)
	end)

	lc.addChildToPos(arg_2_0, var_2_8, cc.p(lc.right(var_2_3) + var_2_5 / 2 + 10, lc.y(var_2_3)))

	arg_2_0._btnArrowRight = var_2_8

	-- Online players count label placed neatly above tip section
	local onlineLabel = cc.Label:createWithTTF("Người chơi trực tuyến: ...", ClientView.TTF_FONT, ClientView.FontSize.S2)
	onlineLabel:setColor(cc.c3b(255, 235, 120))
	onlineLabel:enableOutline(cc.c4b(0, 0, 0, 200), 1)
	lc.addChildToPos(arg_2_0, onlineLabel, cc.p(lc.w(arg_2_0) / 2, lc.top(var_2_3) + 16))
	arg_2_0._onlineLabel = onlineLabel

	local function updateOnlineCount()
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("online_count", {}, function(rawRes)
				local res = (type(rawRes) == "string") and require("json").decode(rawRes) or rawRes
				if res and res.count then
					pcall(function()
						onlineLabel:setString("Người chơi trực tuyến: " .. tostring(res.count))
					end)
				end
			end)
		end
	end
	updateOnlineCount()
	onlineLabel:runAction(cc.RepeatForever:create(cc.Sequence:create(
		cc.DelayTime:create(3),
		cc.CallFunc:create(updateOnlineCount)
	)))

	if arg_2_1 == Data.FindMatchType.clash then
		arg_2_0:runAction(lc.sequence(1, function()
			ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_WORLD_LADDER)
		end, 120, function()
			ClientData.sendWorldFindExCancel()

			if ClientData._isAutoBattle then
				ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_WORLD_LADDER)
			else
				ToastManager.push(Str(STR.FIND_TIME_OUT))
				arg_2_0:hide()
			end
		end))
	elseif arg_2_1 == Data.FindMatchType.clash_ex then
		arg_2_0:runAction(lc.sequence(1, function()
			ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_WORLD_LEGEND)
		end, 60, function()
			ClientData.sendWorldFindExCancel()

			if ClientData._isAutoBattle then
				ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_WORLD_LEGEND)
			else
				ToastManager.push(Str(STR.FIND_TIME_OUT))
				arg_2_0:hide()
			end
		end))
	elseif arg_2_1 == Data.FindMatchType.ladder then
		arg_2_0:runAction(lc.sequence(1, function()
			ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_WORLD_LADDER_EX)
		end, 120, function()
			ClientData.sendWorldFindExCancel()
			ToastManager.push(Str(STR.FIND_TIME_OUT))
			arg_2_0:hide()
		end))
	elseif arg_2_1 == Data.FindMatchType.union_battle then
		arg_2_0:runAction(lc.sequence(1, function()
			ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_MASSWAR_MULTIPLE)
		end, 120, function()
			ClientData.sendWorldFindExCancel()
			ToastManager.push(Str(STR.FIND_TIME_OUT))
			arg_2_0:hide()
		end))
	elseif arg_2_1 == Data.FindMatchType.dark then
		arg_2_0:runAction(lc.sequence(1, function()
			P._playerFindDark:find(true)
		end, 120, function()
			ClientData.sendWorldFindExCancel()
			ToastManager.push(Str(STR.FIND_TIME_OUT))
			arg_2_0:hide()
		end))
	elseif arg_2_1 == Data.FindMatchType.survival then
		local var_2_9 = Str(STR.SURVIVAL_FIND_TIP)
		local var_2_10 = ClientView.createTTF("", ClientView.FontSize.S2)

		lc.addChildToPos(arg_2_0, var_2_10, cc.p(lc.cw(arg_2_0), lc.top(var_2_1) + 60))
		var_2_10:runAction(lc.rep(lc.sequence(function()
			var_2_10:setString(var_2_9 .. ".")
		end, 1, function()
			var_2_10:setString(var_2_9 .. "..")
		end, 1, function()
			var_2_10:setString(var_2_9 .. "...")
		end, 1)))

		local var_2_11 = ClientView.createTTF("1 / " .. Data._globalInfo._SurvivalHallNum, ClientView.FontSize.S2)

		lc.addChildToPos(arg_2_0, var_2_11, cc.p(lc.cw(arg_2_0), lc.top(var_2_1) + 30))

		arg_2_0._userCountLabel = var_2_11

		arg_2_0:runAction(lc.sequence(1, function()
			ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_SURVIVAL)
		end))
	elseif arg_2_1 == Data.FindMatchType.survival_ex then
		var_2_2:setVisible(true)

		local var_2_12 = Str(STR.SURVIVAL_EX_FIND_TIP)
		local var_2_13 = ClientView.createTTF("", ClientView.FontSize.S2)

		lc.addChildToPos(arg_2_0, var_2_13, cc.p(lc.cw(arg_2_0), lc.top(var_2_1) + 60))
		var_2_13:runAction(lc.rep(lc.sequence(function()
			var_2_13:setString(var_2_12 .. ".")
		end, 1, function()
			var_2_13:setString(var_2_12 .. "..")
		end, 1, function()
			var_2_13:setString(var_2_12 .. "...")
		end, 1)))

		local var_2_14 = ClientView.createTTF("1 / " .. Data._globalInfo._SurvivalExHallNum, ClientView.FontSize.S2)

		lc.addChildToPos(arg_2_0, var_2_14, cc.p(lc.cw(arg_2_0), lc.top(var_2_1) + 30))

		arg_2_0._userCountLabel = var_2_14

		arg_2_0:runAction(lc.sequence(1, function()
			ClientData.sendWorldFindEx(P._curTroopIndex, Battle_pb.PB_BATTLE_SURVIVAL_EX)
		end))
	end
end

function var_0_0.cancelFind(arg_25_0)
	ClientData._isAutoBattle = false
	ClientData._autoReloadCount = 0

	if arg_25_0._matchType == Data.FindMatchType.dark and P._playerFindDark:isInDarkBattle() then
		return require("Dialog").showDialog(Str(STR.CANCLE_DARK_TIP), function()
			P._playerFindDark:retreat()
			ClientView.getActiveIndicator():show(Str(STR.WAIT_BATTLE_RESULT))
		end)
	elseif arg_25_0._matchType == Data.FindMatchType.survival_ex then
		P._playerFindSurvivalEx:clearFind()
		ClientData.sendWorldFindExCancel()
	else
		ClientData.sendWorldFindExCancel()
	end
end

function var_0_0.stopEffect(arg_27_0)
	if arg_27_0._effectId then
		cc.SimpleAudioEngine:getInstance():stopEffect(arg_27_0._effectId)
		lc.Audio.stopAudio(AUDIO.E_FIND_MATCH_OVER)

		arg_27_0._effectId = nil
	end

	lc.Audio.stopAudio(AUDIO.E_FIND_MATCH_OVER)

	if arg_27_0._effectScheduleId then
		lc.Scheduler:unscheduleScriptEntry(arg_27_0._effectScheduleId)

		arg_27_0._effectScheduleId = nil
	end
end

function var_0_0.onEnter(arg_28_0)
	var_0_0.super.onEnter(arg_28_0)
	ClientData.addMsgListener(arg_28_0, function(arg_29_0)
		return arg_28_0:onMsg(arg_29_0)
	end, 0)

	ClientView._findMatchPanel = arg_28_0

	arg_28_0:stopEffect()

	if ClientData._isEffectOn then
		local function var_28_0()
			arg_28_0._effectId = cc.SimpleAudioEngine:getInstance():playEffect("res/audio/e_find_match.wav", false)
		end

		arg_28_0._effectScheduleId = lc.Scheduler:scheduleScriptFunc(var_28_0, 0.95, false)

		var_28_0()
	end

	local var_28_1 = {}

	arg_28_0._listeners = var_28_1

	if arg_28_0._matchType == Data.FindMatchType.survival then
		var_28_1[#var_28_1 + 1] = lc.addEventListener(Data.Event.survival_info_dirty, function(arg_31_0)
			arg_28_0._userCountLabel:setString(P._playerFindSurvival._hallUserNum .. " / " .. Data._globalInfo._SurvivalHallNum)
		end)
	elseif arg_28_0._matchType == Data.FindMatchType.survival_ex then
		var_28_1[#var_28_1 + 1] = lc.addEventListener(Data.Event.survival_ex_info_dirty, function(arg_32_0)
			arg_28_0._userCountLabel:setString(P._playerFindSurvivalEx._hallUserNum .. " / " .. Data._globalInfo._SurvivalExHallNum)
		end)
	end
end

function var_0_0.onExit(arg_33_0)
	var_0_0.super.onExit(arg_33_0)
	ClientData.removeMsgListener(arg_33_0)

	ClientView._findMatchPanel = nil

	for iter_33_0, iter_33_1 in ipairs(arg_33_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_33_1)
	end

	arg_33_0:stopEffect()
end

function var_0_0.onFind(arg_34_0, arg_34_1)
	lc._runningScene:onBattleRecover(arg_34_1)
end

function var_0_0.onBtnArrow(arg_35_0, arg_35_1)
	local var_35_0 = lc.x(arg_35_0._tipBg) - lc.w(arg_35_0._tipBg) / 2
	local var_35_1 = lc.w(arg_35_0._tipBg) / 2
	local var_35_2 = lc.h(arg_35_0._tipBg) / 2
	local var_35_3 = arg_35_0._tipIndex

	if arg_35_1 == arg_35_0._btnArrowLeft then
		var_35_3 = var_35_3 - 1

		if var_35_3 == 0 then
			var_35_3 = #arg_35_0._tipSids
		end
	else
		var_35_3 = var_35_3 + 1

		if var_35_3 == #arg_35_0._tipSids + 1 then
			var_35_3 = 1
		end

		var_35_0 = -var_35_0
	end

	local var_35_4 = ClientView.createTTF(Str(arg_35_0._tipSids[var_35_3]), nil, nil, cc.size(400, 0))

	var_35_4:setOpacity(0)
	lc.addChildToPos(arg_35_0._tipBg, var_35_4, cc.p(var_35_1 - var_35_0, var_35_2))

	local var_35_5 = arg_35_0._fieldArea
	local var_35_6 = lc.absTime(0.1)

	arg_35_0._tip:stopAllActions()
	arg_35_0._tip:runAction(lc.sequence({
		lc.moveTo(var_35_6, var_35_1 + var_35_0, var_35_2),
		lc.fadeOut(var_35_6)
	}, lc.remove()))
	var_35_4:runAction(lc.sequence({
		lc.moveTo(var_35_6, var_35_1, var_35_2),
		lc.fadeIn(var_35_6)
	}))

	arg_35_0._tip = var_35_4
	arg_35_0._tipIndex = var_35_3
end

function var_0_0.onMsg(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.type

	return false
end

return var_0_0
