local var_0_0 = class("FindTrophyArea", lc.ExtendCCNode)
local var_0_1 = 960

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_0, arg_1_1)
	var_1_0:init()
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0)
	arg_3_0:initTopArea()
	arg_3_0:initBottomArea()

	arg_3_0._opponentArea = {}

	arg_3_0:findMatch()
end

function var_0_0.initTopArea(arg_4_0)
	local var_4_0 = lc.createSprite({
		_name = "img_com_bg_4",
		_crect = ClientView.CRECT_COM_BG4,
		_size = cc.size(math.min(lc.w(arg_4_0), var_0_1), 110)
	})

	lc.addChildToPos(arg_4_0, var_4_0, cc.p(lc.w(arg_4_0) / 2, lc.h(arg_4_0) - 40), 1)

	arg_4_0._topArea = var_4_0

	local var_4_1 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_4_0:findMatch()
	end, ClientView.CRECT_BUTTON, 150)

	var_4_1:addLabel(Str(STR.SEARCH))
	var_4_1:addIcon("img_icon_search")
	lc.addChildToPos(var_4_0, var_4_1, cc.p(lc.w(var_4_0) - 22 - lc.w(var_4_1) / 2, 56))

	arg_4_0._btnSearch = var_4_1

	local var_4_2 = ClientView.createResConsumeButtonArea({
		140,
		150
	}, "img_icon_lock", lc.Color3B.black, "", Str(STR.COPY_PVP_UNLOCK), "img_btn_2")

	var_4_2._resArea._ico:setScale(0.6)
	lc.addChildToPos(var_4_0, var_4_2, cc.p(lc.w(var_4_0) - 22 - lc.w(var_4_2) / 2, lc.y(var_4_1)))

	arg_4_0._unlockArea = var_4_2

	function var_4_2._btn._callback()
		local var_6_0 = lc.arrayAt(Data._globalInfo._buyRefreshFindCost, P._unlockCopyPvpTimes + 1)

		require("Dialog").showDialog(string.format(Str(STR.CONFIRM_UNLOCK_COPY_PVP), var_6_0), function()
			if ClientView.checkIngot(var_6_0) then
				arg_4_0:unlockFind()
			end
		end)
	end

	arg_4_0:checkUnlockState()

	local var_4_3 = lc.createSprite("img_glow")

	var_4_3:setScale(0.65, 0.5)
	lc.addChildToPos(var_4_0, var_4_3, cc.p(80, lc.y(var_4_1)))

	local var_4_4, var_4_5 = var_4_3:getPosition()
	local var_4_6 = ClientView.createTTF(Str(STR.BATTLE_CUR_RANK), ClientView.FontSize.S3, ClientView.COLOR_LABEL_DARK)

	lc.addChildToPos(var_4_0, var_4_6, cc.p(var_4_4, var_4_5 + 24))

	local var_4_7 = ClientView.createBMFont(ClientView.BMFont.num_48, "?")

	lc.addChildToPos(var_4_0, var_4_7, cc.p(var_4_4, var_4_5 - 6))

	arg_4_0._rank = var_4_7

	arg_4_0:updateRemainTimes()
end

function var_0_0.initOpponentArea(arg_8_0, arg_8_1)
	local function var_8_0()
		local var_9_0 = lc.createSprite({
			_name = "img_com_bg_16",
			_crect = ClientView.CRECT_COM_BG16,
			_size = cc.size(lc.w(arg_8_0._topArea), 260)
		})
		local var_9_1 = require("UserWidget")
		local var_9_2 = var_9_1.create(nil, var_9_1.Flag.NAME_UNION, 0.5)

		var_9_2:setAnchorPoint(0, 1)
		var_9_2._nameArea:setAnchorPoint(0, 0.5)
		var_9_2._nameArea:setPosition(0, lc.y(var_9_2._frame))
		var_9_2._unionArea:setAnchorPoint(0, 0.5)
		var_9_2._unionArea._name:setVisible(false)
		var_9_2._unionArea:setPosition(math.floor(lc.right(var_9_2._frame) + 10), lc.y(var_9_2._frame))
		lc.addChildToPos(var_9_0, var_9_2, cc.p(34, lc.h(var_9_0) - 30))

		var_9_0._userArea = var_9_2

		local var_9_3 = lc.createSprite("img_glow")

		var_9_3:setScale(0.6, 0.4)
		var_9_3:setOpacity(150)
		lc.addChildToPos(var_9_0, var_9_3, cc.p(lc.w(var_9_0) - 100, lc.h(var_9_0) - 54))

		local var_9_4 = ClientView.createBMFont(ClientView.BMFont.num_48, tostring(200))

		var_9_4:setScale(0.8)
		lc.addChildToPos(var_9_0, var_9_4, cc.p(var_9_3:getPosition()))

		var_9_0._rank = var_9_4

		local var_9_5 = lc.List.createH(cc.size(lc.w(var_9_0) - 18, 100), 16, -6)

		lc.addChildToPos(var_9_0, var_9_5, cc.p(8, lc.bottom(var_9_2) - lc.h(var_9_5) - 4))

		var_9_0._list = var_9_5

		local var_9_6 = ClientView.createScale9ShaderButton("img_btn_1", function()
			arg_8_0:attack(var_9_0)
		end, ClientView.CRECT_BUTTON, 150)

		var_9_6:addLabel(Str(STR.COPY_PVP))
		var_9_6:addIcon("img_icon_battle")
		lc.addChildToPos(var_9_0, var_9_6, cc.p(lc.w(var_9_0) - lc.w(var_9_6) / 2 - 30, 50))

		var_9_0._fightVal = ClientView.addIconValue(var_9_0, "img_icon_power", 0, 50, lc.y(var_9_6), nil, ClientView.COLOR_TEXT_DARK)
		var_9_0._cardNum = ClientView.addIconValue(var_9_0, "img_icon_cardnum", 0, 200, lc.y(var_9_6), nil, ClientView.COLOR_TEXT_DARK)
		var_9_0._trophyNum = ClientView.addIconValue(var_9_0, "img_icon_res5_s", 0, 350, lc.y(var_9_6), nil, ClientView.COLOR_TEXT_DARK)

		function var_9_0.update(arg_11_0, arg_11_1, arg_11_2)
			local var_11_0 = require("User").create(arg_11_1.info)

			arg_11_0._user = var_11_0

			var_9_2:setUser(var_11_0)

			local var_11_1 = var_11_0._unionId and var_11_0._unionId > 0

			var_9_2._nameArea:setPositionX(var_11_1 and 110 or 72)

			if var_9_2._vip then
				var_9_2._vip:setVisible(false)
			end

			local var_11_2 = ClientData.pbTroopToTroop(arg_11_1.cards)
			local var_11_3 = 0

			for iter_11_0, iter_11_1 in ipairs(var_11_2) do
				var_11_3 = var_11_3 + iter_11_1:getFightingValue()
			end

			var_9_5:bindData(var_11_2, function(arg_12_0, arg_12_1)
				arg_12_0:resetData(arg_12_1)
			end, math.min(#var_11_2, 13))

			for iter_11_2 = 1, var_9_5._cacheCount do
				local var_11_4 = IconWidget.create(var_11_2[iter_11_2], IconWidget.DisplayFlag.CARD_TROOP)

				var_11_4:setScale(0.8)
				var_9_5:pushBackCustomItem(var_11_4)
			end

			arg_11_0._fightVal:setString(var_11_3)
			arg_11_0._cardNum:setString(#var_11_2)
			arg_11_0._trophyNum:setString(var_11_0._trophy)

			arg_11_0._rankVal = arg_11_2

			arg_11_0._rank:setString(arg_11_2)
		end

		return var_9_0
	end

	local var_8_1 = var_8_0()
	local var_8_2 = var_8_0()

	var_8_1:setVisible(false)
	var_8_2:setVisible(false)

	arg_8_0._opponentArea = {
		var_8_1,
		var_8_2
	}

	lc.addChildToPos(arg_8_0, var_8_1, cc.p(lc.w(arg_8_0) / 2, lc.bottom(arg_8_0._topArea) - lc.h(var_8_1) / 2 + 8))
	lc.addChildToPos(arg_8_0, var_8_2, cc.p(lc.w(arg_8_0) / 2, lc.bottom(var_8_1) - lc.h(var_8_2) / 2 + 4))

	local var_8_3 = #arg_8_1.opponents

	if var_8_3 == 0 then
		-- block empty
	else
		if var_8_3 >= 1 then
			var_8_1:update(arg_8_1.opponents[1], arg_8_1.opponent_ranks[1])
			var_8_1:setVisible(true)
		end

		if var_8_3 == 2 then
			var_8_2:update(arg_8_1.opponents[2], arg_8_1.opponent_ranks[2])
			var_8_2:setVisible(true)
		end
	end
end

function var_0_0.initBottomArea(arg_13_0)
	local var_13_0 = lc.createNode(cc.size(lc.w(arg_13_0), 80))

	lc.addChildToPos(arg_13_0, var_13_0, cc.p(lc.w(arg_13_0) / 2, lc.h(var_13_0) / 2))

	arg_13_0._bottomArea = var_13_0

	local var_13_1 = lc.createSprite("img_com_bg_8")

	var_13_1:setScaleX(lc.w(var_13_0) / lc.w(var_13_1) + 0.1)
	var_13_1:setScaleY(lc.h(var_13_0) / lc.h(var_13_1))
	lc.addChildToPos(var_13_0, var_13_1, cc.p(lc.w(var_13_0) / 2, lc.h(var_13_0) / 2))

	local var_13_2 = ClientView.createLineSprite("img_divide_line_4", lc.w(var_13_0) + 20)

	var_13_2:setRotation(180)
	lc.addChildToPos(var_13_0, var_13_2, cc.p(lc.w(var_13_0) / 2, 4))

	local var_13_3 = ClientView.createLineSprite("img_divide_line_1", lc.w(var_13_0) + 20)

	lc.addChildToPos(var_13_0, var_13_3, cc.p(lc.w(var_13_0) / 2, lc.h(var_13_0)))

	local var_13_4 = ClientView.createScale9ShaderButton("img_btn_1", function()
		require("RankForm").create(Data.RankRange.lord, 4):show()
	end, ClientView.CRECT_BUTTON, 140)

	var_13_4:addLabel(Str(STR.RANK))
	var_13_4:addIcon("img_icon_res5_s")
	lc.addChildToPos(var_13_0, var_13_4, cc.p(6 + lc.w(var_13_4) / 2, 42))

	local var_13_5 = ClientView.createScale9ShaderButton("img_btn_1", function()
		lc.pushScene(require("MarketScene").create(Data.MarketBuyType.flag))
	end, ClientView.CRECT_BUTTON, 140)

	var_13_5:addLabel(Str(STR.EXCHANGE))
	var_13_5:addIcon(ClientData.getPropIconName(7019))
	lc.addChildToPos(var_13_0, var_13_5, cc.p(lc.right(var_13_4) + 10 + lc.w(var_13_5) / 2, lc.y(var_13_4)))

	local var_13_6 = ClientView.createScale9ShaderButton("img_btn_1", function()
		require("LogForm").create(Battle_pb.PB_BATTLE_PLAYER):show()
	end, ClientView.CRECT_BUTTON, 140)

	var_13_6:addLabel(Str(STR.LOG))
	lc.addChildToPos(var_13_0, var_13_6, cc.p(lc.w(var_13_0) - 6 - lc.w(var_13_6) / 2, lc.y(var_13_4)))

	arg_13_0._btnLog = var_13_6

	local var_13_7 = ClientView.createScale9ShaderButton("img_btn_2", function()
		arg_13_0._ignoreSync = true

		lc.pushScene(require("HeroCenterScene").create())
	end, ClientView.CRECT_BUTTON, 140)

	var_13_7:addLabel("0")
	lc.addChildToPos(var_13_0, var_13_7, cc.p(lc.left(var_13_6) - 10 - lc.w(var_13_7) / 2, lc.y(var_13_4)))

	arg_13_0._btnTroop = var_13_7
end

function var_0_0.checkUnlockState(arg_18_0)
	local var_18_0 = P._nextCopyPvp > ClientData.getCurrentTime() and Data._globalInfo._maxAtkPlayer > P._dailyCopyPvpTimes

	arg_18_0._btnSearch:setVisible(not var_18_0)
	arg_18_0._unlockArea:setVisible(var_18_0)

	if var_18_0 then
		arg_18_0._unlockArea:scheduleUpdateWithPriorityLua(function(arg_19_0)
			local var_19_0 = P._nextCopyPvp - ClientData.getCurrentTime()

			if var_19_0 > 0 then
				arg_18_0._unlockArea._resLabel:setString(ClientData.formatPeriod(var_19_0))
			else
				arg_18_0:checkUnlockState()
			end
		end, 0)
	else
		arg_18_0._unlockArea:unscheduleUpdate()
	end
end

function var_0_0.updateRemainTimes(arg_20_0)
	local var_20_0 = arg_20_0._remainTimes

	if var_20_0 then
		var_20_0:removeFromParent()
	end

	local var_20_1 = ClientView.createBoldRichText(string.format(Str(STR.FIND_TROPHY_REMAIN), Data._globalInfo._maxAtkPlayer - P._dailyCopyPvpTimes, Data._globalInfo._maxAtkPlayer), ClientView.RICHTEXT_PARAM_DARK_S1)

	lc.addChildToPos(arg_20_0._topArea, var_20_1, cc.p(280, lc.y(arg_20_0._btnSearch)))

	arg_20_0._remainTimes = var_20_1
end

function var_0_0.updateLogFlag(arg_21_0)
	local var_21_0 = P._playerLog:getNewDefenseLogCount()

	ClientView.checkNewFlag(arg_21_0._btnLog, var_21_0)
end

function var_0_0.findMatch(arg_22_0)
	if arg_22_0._indicator then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._opponentArea) do
		iter_22_1:removeFromParent()
	end

	arg_22_0._opponentArea = {}
	arg_22_0._indicator = ClientView.showPanelActiveIndicator(arg_22_0)

	ClientData.sendWorldFind()
end

function var_0_0.unlockFind(arg_23_0)
	if P._nextCopyPvp > ClientData.getCurrentTime() then
		P._nextCopyPvp = ClientData.getCurrentTime()

		arg_23_0:checkUnlockState()

		P._unlockCopyPvpTimes = P._unlockCopyPvpTimes + 1

		local var_23_0 = lc.arrayAt(Data._globalInfo._buyRefreshFindCost, P._unlockCopyPvpTimes)

		P:changeResource(Data.ResType.ingot, -var_23_0)
		ClientData.sendCopyPvpUnlock()
	end
end

function var_0_0.attack(arg_24_0, arg_24_1)
	if Data._globalInfo._maxAtkPlayer <= P._dailyCopyPvpTimes then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH_BUY_TIMES), Str(STR.COPY_PVP)))

		return
	end

	local var_24_0 = ClientData.getCurrentTime()

	if var_24_0 < P._nextCopyPvp then
		ToastManager.push(string.format(Str(STR.FIND_TROPHY_COOLDOWN), ClientData.formatPeriod(P._nextCopyPvp - var_24_0)))

		return
	end

	local var_24_1, var_24_2 = P._playerCard:checkTroop(P._curTroopIndex)

	if not var_24_1 then
		ToastManager.push(var_24_2)

		return
	end

	P._nextCopyPvp = var_24_0 + Data._globalInfo._findCD * 60

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendWorldFindStart(P._curTroopIndex, arg_24_1 == arg_24_0._opponentArea[1] and 0 or 1)
end

function var_0_0.onEnter(arg_25_0)
	ClientData.addMsgListener(arg_25_0, function(arg_26_0)
		return arg_25_0:onMsg(arg_26_0)
	end, 0)

	arg_25_0._listeners = {}

	arg_25_0._btnTroop._label:setString(string.format("%s %d", Str(STR.TROOP), P._curTroopIndex))
	arg_25_0:updateLogFlag()
end

function var_0_0.onExit(arg_27_0)
	ClientData.removeMsgListener(arg_27_0)

	for iter_27_0 = 1, #arg_27_0._listeners do
		lc.Dispatcher:removeEventListener(arg_27_0._listeners[iter_27_0])
	end
end

function var_0_0.onMsg(arg_28_0, arg_28_1)
	if arg_28_1.type == SglMsgType_pb.PB_TYPE_WORLD_FIND then
		if arg_28_0._indicator then
			arg_28_0._indicator:removeFromParent()

			arg_28_0._indicator = nil
		end

		local var_28_0 = arg_28_1.Extensions[World_pb.SglWorldMsg.world_find_resp]

		arg_28_0:initOpponentArea(var_28_0)

		arg_28_0._rankVal = var_28_0.rank

		arg_28_0._rank:setString(var_28_0.rank)

		return true
	end

	return false
end

return var_0_0
