local var_0_0 = class("LogForm", BaseForm)
local var_0_1 = cc.size(960, 640)
local var_0_2 = 180
local var_0_3 = 100

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._type = arg_2_1

	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.LOG), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 32, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 32, 20)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0._form, var_2_0)

	arg_2_0._list = var_2_0

	if arg_2_1 == Battle_pb.PB_BATTLE_PLAYER then
		arg_2_0:addTabs({
			Str(STR.DEFENSE_LOG),
			Str(STR.ATTACK_LOG)
		}, arg_2_2)
	else
		arg_2_0:refreshLog()
	end
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	arg_3_0._listener = lc.addEventListener(Data.Event.log_dirty, function(arg_4_0)
		arg_3_0:onLogEvent(arg_4_0)
	end)
end

function var_0_0.onExit(arg_5_0)
	var_0_0.super.onExit(arg_5_0)

	if lc._runningScene._sceneId == ClientData.SceneId.find then
		lc._runningScene:showTabFlag()
	end

	ClientView.getMenuUI():updateBattleFlag()
	lc.Dispatcher:removeEventListener(arg_5_0._listener)
end

function var_0_0.showTab(arg_6_0, arg_6_1, arg_6_2)
	if not var_0_0.super.showTab(arg_6_0, arg_6_1, arg_6_2) then
		return false
	end

	arg_6_0:refreshLog(arg_6_1)

	return true
end

function var_0_0.refreshLog(arg_7_0, arg_7_1)
	local var_7_0

	if arg_7_1 then
		if not arg_7_0._tabs or arg_7_0._focusTab ~= arg_7_0._tabs[arg_7_1] then
			return
		end

		var_7_0 = P._playerLog:getLogList(Battle_pb.PB_BATTLE_PLAYER, arg_7_1 == Str(STR.ATTACK_LOG))

		if arg_7_1 == Str(STR.ATTACK_LOG) then
			lc.writeConfig(ClientData.ConfigKey.new_attack_log, ClientData.getCurrentTime())
		elseif arg_7_1 == Str(STR.DEFENSE_LOG) then
			lc.writeConfig(ClientData.ConfigKey.new_defense_log, ClientData.getCurrentTime())
		end
	else
		var_7_0 = P._playerLog:getLogList(arg_7_0._type)

		if arg_7_0._type == Battle_pb.PB_BATTLE_WORLD_LADDER then
			lc.writeConfig(ClientData.ConfigKey.new_clash_log, ClientData.getCurrentTime())
		else
			lc.writeConfig(ClientData.ConfigKey.new_ladder_log, ClientData.getCurrentTime())
		end
	end

	if var_7_0 and arg_7_0._type == Battle_pb.PB_BATTLE_DARK then
		for iter_7_0 = 1, #var_7_0 do
			local var_7_1 = var_7_0[iter_7_0]
			local var_7_2

			if iter_7_0 < #var_7_0 then
				var_7_2 = var_7_0[iter_7_0 + 1]
			end

			if iter_7_0 == 1 then
				var_7_1._isFirst = true
			end

			if iter_7_0 == #var_7_0 then
				var_7_1._isLast = true
			end

			if var_7_2 and var_7_2._creator ~= var_7_1._creator then
				var_7_1._isLast = true
				var_7_2._isFirst = true
			end

			if var_7_2 and var_7_2._creator == var_7_1._creator and var_7_1._isFirst == true then
				var_7_2._isMiddle = true
			end
		end
	end

	if var_7_0 then
		local var_7_3 = arg_7_0._list

		var_7_3:bindData(var_7_0, function(arg_8_0, arg_8_1)
			arg_7_0:setOrCreateItem(arg_8_0, arg_8_1)
		end, math.min(6, #var_7_0))

		var_7_3._items = {}
		for iter_7_1 = 1, var_7_3._cacheCount do
			local var_7_4 = arg_7_0:setOrCreateItem(nil, var_7_0[iter_7_1])
			table.insert(var_7_3._items, var_7_4)
			var_7_3:pushBackCustomItem(var_7_4)
		end

		var_7_3:refreshView()
		var_7_3:gotoTop()
		arg_7_0._list:checkEmpty(Str(STR.LIST_EMPTY_NO_LOG))
	else
		if arg_7_0._indicator == nil then
			arg_7_0._indicator = ClientView.showPanelActiveIndicator(arg_7_0._form)
		end

		ClientData.sendGetPvpLogs(arg_7_0._type)
	end
end

function var_0_0.setOrCreateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2:isLocal()

	if arg_9_1 == nil then
		arg_9_1 = ccui.Widget:create()

		local var_9_1 = lc.createImageView({
			_name = "img_com_bg_33",
			_crect = ClientView.CRECT_COM_BG33,
			_size = cc.size(lc.w(arg_9_0._list), ClientView.CRECT_COM_BG33.height)
		})

		arg_9_1:setContentSize(var_9_1:getContentSize())
		var_9_1:setTouchEnabled(true)
		var_9_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
		lc.addChildToCenter(arg_9_1, var_9_1)

		arg_9_1._item = var_9_1

		if arg_9_0._type == Battle_pb.PB_BATTLE_DARK then
			if arg_9_2._isFirst == arg_9_2._isLast or arg_9_2._isMiddle then
				var_9_1:setPositionY(lc.ch(arg_9_1))
			elseif arg_9_2._isFirst then
				var_9_1:setPositionY(lc.ch(arg_9_1) - 20)
			elseif arg_9_2._isLast then
				var_9_1:setPositionY(lc.ch(arg_9_1) + 20)
			end
		end

		local var_9_2 = lc.createSprite("img_bg_deco_33")

		lc.addChildToPos(var_9_1, var_9_2, cc.p(lc.w(var_9_2) / 2, lc.h(var_9_1) / 2 + 3))
		var_9_2:setColor(lc.Color3B.red)

		var_9_1._bar = var_9_2

		local var_9_3 = UserWidget.create(P, UserWidget.Flag.REGION_NAME_UNION, 1, false, true)

		lc.addChildToPos(var_9_1, var_9_3, cc.p(176 + lc.w(var_9_3) / 2, lc.h(var_9_1) / 2 + 4))

		var_9_1._userArea = var_9_3

		local var_9_4

		if var_9_0 then
			var_9_4 = "img_icon_res5_s"
		elseif arg_9_0._type == Battle_pb.PB_BATTLE_WORLD_LADDER then
			var_9_4 = "img_icon_res6_s"
		end

		local var_9_5

		if var_9_4 then
			var_9_5 = ClientView.createIconLabelArea(var_9_4, "", 140)

			lc.addChildToPos(var_9_1, var_9_5, cc.p(600, 110))

			var_9_1._trophyArea = var_9_5

			local var_9_6 = lc.createSprite(var_9_4)

			lc.addChildToPos(var_9_1, var_9_6, cc.p(lc.left(var_9_5) + lc.w(var_9_6) / 2, lc.bottom(var_9_5) - 18))
			var_9_6:setScale(0.7)

			var_9_1._trophyIco = var_9_6

			local var_9_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, "")

			var_9_7:setAnchorPoint(0, 0.5)
			lc.addChildToPos(var_9_1, var_9_7, cc.p(lc.right(var_9_6) + 6, lc.y(var_9_6)))

			var_9_1._trophyChange = var_9_7
		end

		local var_9_8 = var_9_5 and cc.p(lc.left(var_9_5) + 6, lc.bottom(var_9_5) - 50) or cc.p(600, 110)
		local var_9_9 = ClientView.createTTF("0", nil, ClientView.COLOR_LABEL_DARK)

		var_9_9:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_9_1, var_9_9, var_9_8)

		var_9_1._timeValue = var_9_9

		local var_9_10 = lc.createSprite("img_win")

		lc.addChildToPos(var_9_1, var_9_10, cc.p(70, lc.h(var_9_1) / 2))

		var_9_1._resultImg = var_9_10

		local var_9_11 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_10_0)
			arg_9_0:onReplay(var_9_1._log)
		end, ClientView.CRECT_BUTTON_S, 120)

		var_9_11:addLabel(Str(STR.REPLAY))
		var_9_11:setDisabledShader(ClientView.SHADER_DISABLE)
		lc.addChildToPos(var_9_1, var_9_11, cc.p(lc.w(var_9_1) - lc.w(var_9_11) / 2 - 28, lc.h(var_9_1) / 2 + lc.h(var_9_11) / 2 + 4))

		var_9_1._btnReplay = var_9_11

		local var_9_12 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_11_0)
			arg_9_0:onShare(var_9_1._log)
		end, ClientView.CRECT_BUTTON_S, 120)

		var_9_12:addLabel(Str(STR.SHARE))
		var_9_12:setDisabledShader(ClientView.SHADER_DISABLE)
		lc.addChildToPos(var_9_1, var_9_12, cc.p(lc.x(var_9_11), lc.h(var_9_1) / 2 - lc.h(var_9_12) / 2))

		var_9_1._btnShare = var_9_12
	end

	local var_9_13 = (arg_9_1 and arg_9_1._item) or (arg_9_1 and arg_9_1.getChildren and #arg_9_1:getChildren() > 0 and arg_9_1:getChildren()[1]) or arg_9_1
	if not var_9_13 then return arg_9_1 end
	if arg_9_1 then arg_9_1._item = var_9_13 end

	var_9_13:removeChildrenByTag(var_0_3)

	var_9_13._log = arg_9_2

	local var_9_14 = arg_9_2._opponent
	local var_9_15 = arg_9_2._resultType

	var_9_13:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 == ccui.TouchEventType.ended then
			if var_9_0 then
				ClientView.operateUser(var_9_14, var_9_13)
			elseif arg_9_0._type == Battle_pb.PB_BATTLE_WORLD_LADDER and var_9_14._regionId > 0 then
				require("ClashUserInfoForm").create(var_9_14._id):show()
			end
		end
	end)
	var_9_13._userArea:setUser(var_9_14, true)

	if var_9_13._userArea._unionArea ~= nil and not var_9_13._userArea._unionArea:isVisible() then
		-- block empty
	end

	if var_9_13._trophyArea then
		var_9_13._trophyArea._label:setString(string.format("%d", var_9_14._trophy))
		var_9_13._trophyChange:setString(string.format("%s", (var_9_15 ~= Data.BattleResult.lose and "+" or "-") .. arg_9_2._trophy))
	end

	var_9_13._timeValue:setString(lc.formatDate(arg_9_2._timestamp))
	var_9_13._resultImg:setSpriteFrame(var_9_15 == Data.BattleResult.win and "img_win" or var_9_15 == Data.BattleResult.draw and "img_draw" or "img_lose")
	var_9_13._bar:setColor(var_9_15 == Data.BattleResult.win and cc.c3b(236, 112, 64) or var_9_15 == Data.BattleResult.draw and cc.c3b(102, 194, 128) or lc.Color3B.white)
	var_9_13._btnReplay:setEnabled(arg_9_2._isAvailable)
	var_9_13._btnShare:setEnabled(arg_9_2._isAvailable and not P._playerMessage:isLogShared(arg_9_2._id))

	if var_9_15 == Data.BattleResult.lose then
		var_9_13:setColor(cc.c3b(200, 200, 200))
	else
		var_9_13:setColor(lc.Color3B.white)
	end

	if arg_9_0._type == Battle_pb.PB_BATTLE_DARK then
		if arg_9_2._isFirst == arg_9_2._isLast or arg_9_2._isMiddle then
			var_9_13:setPositionY(lc.ch(arg_9_1))
		elseif arg_9_2._isFirst then
			var_9_13:setPositionY(lc.ch(arg_9_1) - 20)
		elseif arg_9_2._isLast then
			var_9_13:setPositionY(lc.ch(arg_9_1) + 20)
		end
	end

	return arg_9_1
end

function var_0_0.onLogEvent(arg_13_0, arg_13_1)
	local var_13_0 = require("PlayerLog")
	local var_13_1 = arg_13_1._event

	if var_13_1 == var_13_0.Event.attack_log_dirty then
		arg_13_0:refreshLog(Str(STR.ATTACK_LOG))
	elseif var_13_1 == var_13_0.Event.defense_log_dirty then
		arg_13_0:refreshLog(Str(STR.DEFENSE_LOG))
	elseif var_13_1 == var_13_0.Event.clash_log_dirty or var_13_1 == var_13_0.Event.melee_log_dirty or var_13_1 == var_13_0.Event.dark_log_dirty or var_13_1 == var_13_0.Event.survival_log_dirty or var_13_1 == var_13_0.Event.survival_ex_log_dirty or var_13_1 == var_13_0.Event.clash_ex_log_dirty then
		if arg_13_0._indicator then
			arg_13_0._indicator:removeFromParent()

			arg_13_0._indicator = nil
		end

		arg_13_0:refreshLog()
	elseif var_13_1 == var_13_0.Event.log_item_dirty then
		local var_13_2 = arg_13_1._logId
		local var_13_3 = arg_13_0._list:getItems()

		for iter_13_0, iter_13_1 in ipairs(var_13_3) do
			if iter_13_1._log and iter_13_1._log._id == var_13_2 then
				arg_13_0:setOrCreateItem(iter_13_1, iter_13_1._log)
			end
		end
	end
end

function var_0_0.onReplay(arg_14_0, arg_14_1)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))

	local var_14_0 = arg_14_1:isLocal()

	ClientData._replayingLog = arg_14_1
	ClientData._replaySharable = not var_14_0

	ClientData.sendBattleReplay(arg_14_1._replayId, var_14_0)
	ClientData.sendUserEvent({
		logReplayId = arg_14_1._replayId
	})
end

function var_0_0.onShare(arg_15_0, arg_15_1)
	require("ShareForm").create(arg_15_1._id):show()
end

return var_0_0
