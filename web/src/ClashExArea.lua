local var_0_0 = class("ClashExArea", lc.ExtendCCNode)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_0, arg_1_1)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		end
	end)

	return var_1_0
end

function var_0_0.enterLayer(arg_3_0)
	if arg_3_0._contentLayer then
		arg_3_0._contentLayer:removeFromParent()

		arg_3_0._contentLayer = nil
	end

	local var_3_0

	if not P._playerFindClashEx._hasTicket then
		var_3_0 = arg_3_0:createDoorLayer()

		ClientView.getResourceUI():setMode(Data.PropsId.clash_ex_ticket)
	else
		var_3_0 = arg_3_0:createFindLayer()

		ClientView.getResourceUI():setMode(Data.ResType.clash_ex_trophy)
	end

	lc.addChildToCenter(arg_3_0, var_3_0, 1)

	arg_3_0._contentLayer = var_3_0

	arg_3_0:updateTroopButton()
end

function var_0_0.createDoorLayer(arg_4_0)
	local var_4_0 = lc.createNode(arg_4_0:getContentSize())

	var_4_0._doors = {}

	for iter_4_0 = 1, 2 do
		local var_4_1 = cc.Sprite:create("res/jpg/arena_door.jpg")

		lc.addChildToCenter(var_4_0, var_4_1)
		var_4_1:setAnchorPoint(cc.p(2 - iter_4_0, 0.5))
		var_4_1:setFlippedX(iter_4_0 == 2)

		var_4_0._doors[iter_4_0] = var_4_1
	end

	local var_4_2 = lc.createNode()

	lc.addChildToPos(var_4_0, var_4_2, cc.p(0, 0))

	var_4_0._tipNode = var_4_2

	if not ClientData.isAppStoreReviewing() then
		local var_4_3 = lc.createSprite({
			_name = "img_com_bg_41",
			_size = cc.size(672, 54),
			_crect = cc.rect(29, 26, 1, 1)
		})

		lc.addChildToPos(var_4_2, var_4_3, cc.p(lc.cw(var_4_0), 180))

		local var_4_4 = ClientView.createTTF(P._playerFindClashEx:getTimeTip(), ClientView.FontSize.M2, nil, cc.size(652, 0), cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

		lc.addChildToCenter(var_4_3, var_4_4)
		var_4_3:setContentSize(lc.w(var_4_3), math.max(lc.h(var_4_4) + 20, 54))
		var_4_4:setPositionY(lc.ch(var_4_3))
	end

	local var_4_5 = (function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_6_0)
			arg_4_0:onBuyTicket(arg_5_2)
		end, ClientView.CRECT_BUTTON, 180)
		local var_5_1 = lc.createSprite(arg_5_0)
		local var_5_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_5_1)

		lc.addChildToPos(var_5_0, var_5_1, cc.p(lc.cw(var_5_0) - (lc.w(var_5_2) + 12) / 2, lc.ch(var_5_0)))
		lc.addChildToPos(var_5_0, var_5_2, cc.p(lc.right(var_5_1) + lc.cw(var_5_2) + 12, lc.ch(var_5_0)))

		return var_5_0
	end)(ClientData.getIconName(Data.PropsId.clash_ex_ticket), 1, Data.PropsId.clash_ex_ticket)

	lc.addChildToPos(var_4_2, var_4_5, cc.p(lc.cw(var_4_0), 80))

	return var_4_0
end

function var_0_0.createFindLayer(arg_7_0)
	local var_7_0 = lc.createNode(arg_7_0:getContentSize())

	arg_7_0:initTopArea(var_7_0)
	arg_7_0:initFieldArea(var_7_0)
	arg_7_0:initBottomArea(var_7_0)

	return var_7_0
end

function var_0_0.initTopArea(arg_8_0, arg_8_1)
	local var_8_0 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(arg_8_1, var_8_0, cc.p(lc.w(arg_8_1) / 2, lc.h(arg_8_1) - lc.h(var_8_0) / 2))

	local var_8_1 = ClientView.createTTF(Str(STR.FIND_CLASH_LAST_CHAMPION), ClientView.FontSize.S1)

	lc.addChildToPos(var_8_0, var_8_1, cc.p(lc.w(var_8_0) / 2, lc.h(var_8_0) / 2 + 5))

	local var_8_2 = {
		"img_stage_gold_ex",
		"img_stage_silver_ex",
		"img_stage_bronze_ex"
	}

	local function var_8_3(arg_9_0)
		local var_9_0 = ccui.Widget:create()

		var_9_0:setContentSize(250, 236)

		local var_9_1 = lc.w(var_9_0) / 2
		local var_9_2 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_LEGEND_PRE)
		local var_9_3

		if var_9_2 and var_9_2[arg_9_0] then
			var_9_3 = var_9_2[arg_9_0]._user
		end

		if var_9_3 then
			var_9_0:setTouchEnabled(true)
			var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
				if arg_10_1 == ccui.TouchEventType.ended then
					require("ClashUserInfoForm").create(var_9_3._id):show()
				end
			end)
		end

		local var_9_4 = cc.ShaderSprite:createWithFramename(var_8_2[arg_9_0])

		lc.addChildToPos(var_9_0, var_9_4, cc.p(var_9_1, lc.h(var_9_4) / 2))

		local var_9_5 = require("UserWidget").create()

		lc.addChildToPos(var_9_0, var_9_5, cc.p(var_9_1, lc.h(var_9_0) - lc.h(var_9_5) / 2 - 24))

		var_9_0._avatar = var_9_5

		local var_9_6 = ClientView.createIconLabelArea("img_icon_res23_s", var_9_3 and var_9_2[arg_9_0]._value or 0, 150)

		var_9_6._valBg:setScale(0.84)
		var_9_6._icon:setScale(0.84)
		lc.offset(var_9_6._icon, 10)
		lc.offset(var_9_6._label, -10)
		lc.addChildToPos(var_9_0, var_9_6, cc.p(var_9_1, 88))

		var_9_0._trophy = var_9_6._label

		local var_9_7 = ClientView.createTTF(var_9_3 and var_9_3._name or string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.LORD)), ClientView.FontSize.S2)

		lc.addChildToPos(var_9_0, var_9_7, cc.p(var_9_1, 24))

		var_9_0._name = var_9_7

		local var_9_8 = {
			_avatar = var_9_3 and var_9_3._avatar,
			_vip = var_9_3 and var_9_3._vip or 0
		}

		if arg_9_0 == 1 then
			var_9_8._avatarFrameId = 7512
		else
			var_9_4:setScaleY(0.9)
			lc.offset(var_9_5, 0, -4)
			lc.offset(var_9_6, 0, -2)
			lc.offset(var_9_7, 0, 4)

			if arg_9_0 == 2 then
				var_9_8._avatarFrameId = 7510
			elseif arg_9_0 == 3 then
				var_9_8._avatarFrameId = 7511
			end
		end

		var_9_5:setUser(var_9_8)

		return var_9_0
	end

	local var_8_4 = var_8_3(1)

	lc.addChildToPos(arg_8_1, var_8_4, cc.p(lc.w(arg_8_1) / 2, lc.bottom(var_8_0) + 8 - lc.h(var_8_4) / 2), 1)

	local var_8_5 = var_8_3(2)

	lc.addChildToPos(arg_8_1, var_8_5, cc.p(math.max(lc.left(var_8_4) - 30 - lc.w(var_8_5), 0) + lc.w(var_8_5) / 2, lc.y(var_8_4)))

	local var_8_6 = var_8_3(3)

	lc.addChildToPos(arg_8_1, var_8_6, cc.p(math.min(lc.right(var_8_4) + 30 + lc.w(var_8_5), lc.w(arg_8_1)) - lc.w(var_8_6) / 2, lc.y(var_8_4)))

	arg_8_1._stages = {
		var_8_4,
		var_8_5,
		var_8_6
	}
end

function var_0_0.initFieldArea(arg_11_0, arg_11_1)
	local var_11_0 = lc.createSprite({
		_name = "img_troop_bg_3",
		_crect = cc.rect(20, 22, 1, 1),
		_size = cc.size(750, 320)
	})

	lc.addChildToPos(arg_11_1, var_11_0, cc.p(lc.cw(arg_11_1), lc.ch(var_11_0) + 90))

	arg_11_1._fieldArea = var_11_0

	local var_11_1 = lc.createSprite({
		_name = "img_divide_line_10",
		_crect = cc.rect(1, 14, 1, 1),
		_size = cc.size(3, lc.h(var_11_0) - 20)
	})

	lc.addChildToPos(var_11_0, var_11_1, cc.p(lc.cw(var_11_0), lc.ch(var_11_0)))

	local var_11_2 = ClientView.createTTF(lc.str(STR.BATTLE_WIN_COUNT), ClientView.FontSize.M2, ClientView.COLOR_GLOW)

	lc.addChildToPos(var_11_0, var_11_2, cc.p(lc.cw(var_11_0) - 190, lc.h(var_11_0) - 30))
	var_11_2:enableShadow(lc.Color4B.black)

	local var_11_3 = ClientView.createTTF(lc.str(STR.BATTLE_LOSE_COUNT), ClientView.FontSize.M2, ClientView.COLOR_GLOW_BLUE)

	lc.addChildToPos(var_11_0, var_11_3, cc.p(lc.cw(var_11_0) - 190, lc.ch(var_11_0) - 50))
	var_11_3:enableShadow(lc.Color4B.black)

	local var_11_4 = lc.createSprite("img_troop_win")

	lc.addChildToPos(var_11_0, var_11_4, cc.p(lc.x(var_11_2), lc.bottom(var_11_2) - lc.ch(var_11_4)))

	local var_11_5 = ClientView.createTTF("0", 60)

	lc.addChildToPos(var_11_4, var_11_5, cc.p(lc.cw(var_11_4), lc.ch(var_11_4)))
	var_11_5:enableShadow(lc.Color4B.black)

	local var_11_6 = {}

	for iter_11_0 = 1, 3 do
		local var_11_7 = lc.createSprite("img_troop_bg_4")

		lc.addChildToPos(var_11_0, var_11_7, cc.p(lc.x(var_11_3) + 80 * (iter_11_0 - 2), lc.bottom(var_11_3) - lc.ch(var_11_7) - 10))

		local var_11_8 = lc.createSprite("img_troop_x")

		lc.addChildToPos(var_11_7, var_11_8, cc.p(lc.cw(var_11_7), lc.ch(var_11_7)))

		var_11_6[iter_11_0] = var_11_8
	end

	local var_11_9 = ClientView.createTTF(lc.str(STR.BATTLE_WIN_REWARD), ClientView.FontSize.M2, ClientView.COLOR_GLOW)

	lc.addChildToPos(var_11_0, var_11_9, cc.p(lc.cw(var_11_0) + 190, lc.h(var_11_0) - 30))
	var_11_9:enableShadow(lc.Color4B.black)

	local var_11_10 = {
		"mubaoxiang",
		"tongbaoxiang",
		"yinbaoxiang",
		"jinbaoxiang",
		"heizuanbaoxiang"
	}
	local var_11_11 = Data._propsInfo[Data.PropsId.clash_ex_chest + P._playerFindClashEx._winCount]
	local var_11_12 = ClientView.createShaderButton(nil, function()
		require("LadderChestForm").create(var_11_11._id):show()
	end)

	var_11_12:setContentSize(cc.size(160, 130))
	lc.addChildToPos(var_11_0, var_11_12, cc.p(lc.x(var_11_9), lc.y(var_11_9) - 100))

	local var_11_13 = DragonBones.create(var_11_10[var_11_11._picId - 7820 + 1])

	lc.addChildToCenter(var_11_12, var_11_13)
	var_11_13:setScale(0.6)
	var_11_13:gotoAndPlay("effect4")

	local var_11_14 = string.format("%s: %d/%d", lc.str(STR.BATTLE_WIN_PROGRESS), 0, 0)
	local var_11_15 = ClientView.createTTF(var_11_14, ClientView.FontSize.M2, ClientView.COLOR_GLOW_BLUE)

	lc.addChildToPos(var_11_0, var_11_15, cc.p(lc.cw(var_11_0) + 190, lc.ch(var_11_0) - 50))
	var_11_15:enableShadow(lc.Color4B.black)

	local var_11_16 = ClientView.createProgressBar(260)

	lc.addChildToPos(var_11_0, var_11_16, cc.p(lc.x(var_11_15), lc.bottom(var_11_15) - 40))

	local var_11_17 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_13_0)
		arg_11_0:onFindingBattle()
	end, ClientView.CRECT_BUTTON, 180)

	lc.addChildToPos(var_11_0, var_11_17, cc.p(lc.cw(var_11_0), lc.ch(var_11_0)))
	var_11_17:addLabel(Str(STR.BATTLE))

	local var_11_18 = var_11_17
	local var_11_19 = ClientView.createScale9ShaderButton("img_btn_3", function(arg_14_0)
		arg_11_0:onFinishBattle()
	end, ClientView.CRECT_BUTTON, 180)

	lc.addChildToPos(var_11_0, var_11_19, cc.p(lc.cw(var_11_0), lc.ch(var_11_0)))
	var_11_19:addLabel(Str(STR.DONE))

	local var_11_20 = var_11_19
	local var_11_21 = ClientView.createScale9ShaderButton("img_btn_3_s", function(arg_15_0)
		require("Dialog").showDialog(string.format(Str(STR.CONFIRM_GIVE_UP_CLASH_EX), P._playerFindClashEx._winCount), function()
			arg_11_0:onGiveUpBattle()
		end)
	end, ClientView.CRECT_BUTTON_S, 120)

	lc.addChildToPos(var_11_0, var_11_21, cc.p(lc.cw(var_11_0), lc.ch(var_11_0) - 100))
	var_11_21:addLabel(Str(STR.GIVEUP))

	local var_11_22 = var_11_21

	function var_11_0.update()
		var_11_5:setString(P._playerFindClashEx._winCount)
		var_11_16._bar:setPercent(P._playerFindClashEx._winCount / P._playerFindClashEx.MAX_BATTLE_COUNT * 100)

		local var_17_0 = string.format("%s: %d/%d", lc.str(STR.BATTLE_WIN_PROGRESS), P._playerFindClashEx._winCount, P._playerFindClashEx.MAX_BATTLE_COUNT)

		var_11_15:setString(var_17_0)

		for iter_17_0 = 1, #var_11_6 do
			var_11_6[iter_17_0]:setVisible(iter_17_0 <= P._playerFindClashEx._loseCount)
		end

		local var_17_1 = P._playerFindClashEx._winCount >= P._playerFindClashEx.MAX_BATTLE_COUNT or P._playerFindClashEx._loseCount >= P._playerFindClashEx.MAX_LOSE_COUNT

		var_11_18:setVisible(not var_17_1)
		var_11_20:setVisible(var_17_1)
	end

	var_11_0.update()
end

function var_0_0.initBottomArea(arg_18_0, arg_18_1)
	local var_18_0 = lc.createNode(cc.size(lc.w(arg_18_1), 80))

	lc.addChildToPos(arg_18_1, var_18_0, cc.p(lc.w(arg_18_1) / 2, lc.h(var_18_0) / 2))

	arg_18_1._bottomArea = var_18_0

	local var_18_1 = ClientView.createLineSprite("img_bottom_bg", lc.w(var_18_0))

	lc.addChildToPos(var_18_0, var_18_1, cc.p(lc.w(var_18_0) / 2, lc.h(var_18_0) / 2))

	local var_18_2 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("RankForm").create(Data.RankRange.lord):show()
	end, ClientView.CRECT_BUTTON_S, 120)

	var_18_2:addLabel(Str(STR.RANK))
	var_18_2:addIcon("img_icon_res6_s")
	lc.addChildToPos(var_18_0, var_18_2, cc.p(6 + lc.w(var_18_2) / 2, 36))

	local var_18_3 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("ClashUserInfoForm").create(P._playerFindClash._clashId):show()
	end, ClientView.CRECT_BUTTON_S, 120)

	var_18_3:addLabel(Str(STR.RANK_HISTORY))
	var_18_3:addIcon("img_icon_rank_history")
	lc.offset(var_18_3._icon, -4, 0)
	lc.addChildToPos(var_18_0, var_18_3, cc.p(lc.right(var_18_2) + 10 + lc.w(var_18_3) / 2, lc.y(var_18_2)))

	local var_18_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("LogForm").create(Battle_pb.PB_BATTLE_WORLD_LEGEND):show()
	end, ClientView.CRECT_BUTTON_S, 120)

	var_18_4:addLabel(Str(STR.LOG))
	lc.addChildToPos(var_18_0, var_18_4, cc.p(lc.w(var_18_0) - 6 - lc.w(var_18_4) / 2 - ClientView.SCR_EDGE, lc.y(var_18_2)))

	local var_18_5 = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_18_0._ignoreSync = true

		lc.pushScene(require("HeroCenterScene").create())
	end, ClientView.CRECT_BUTTON_S, 120)

	var_18_5:addLabel("0")
	lc.addChildToPos(var_18_0, var_18_5, cc.p(lc.left(var_18_4) - 10 - lc.w(var_18_5) / 2, lc.y(var_18_2)))

	arg_18_1._btnTroop = var_18_5

	local var_18_6 = lc.createSprite({
		_name = "img_com_bg_55",
		_crect = ClientView.CRECT_COM_BG55,
		_size = cc.size(200, ClientView.CRECT_COM_BG55.height)
	})

	lc.addChildToPos(var_18_0, var_18_6, cc.p(lc.w(var_18_0) / 2, lc.ch(var_18_6) + 3))

	local var_18_7 = ClientView.createTTF("0", ClientView.FontSize.S3)

	lc.addChildToPos(var_18_6, var_18_7, cc.p(lc.cw(var_18_6), lc.ch(var_18_6) + 14))

	local var_18_8 = ClientView.createTTF("0", ClientView.FontSize.S3)

	lc.addChildToPos(var_18_6, var_18_8, cc.p(lc.cw(var_18_6), lc.ch(var_18_6) - 20))
	var_18_6:scheduleUpdateWithPriorityLua(function(arg_23_0)
		local var_23_0 = P._playerFindClashEx._endTime - ClientData.getCurrentTime()

		if var_23_0 > 0 then
			var_18_7:setString(Str(STR.FIND_CLASH_SEASON_CD))
			var_18_8:setString(ClientData.formatPeriod(var_23_0))
		else
			var_18_7:setString(Str(STR.FIND_CLASH_SEASON_REVIEWING_1))
			var_18_8:setString(Str(STR.FIND_CLASH_SEASON_REVIEWING_2))
		end
	end, 0)
end

function var_0_0.updateTroopButton(arg_24_0)
	if arg_24_0._contentLayer and arg_24_0._contentLayer._btnTroop then
		arg_24_0._contentLayer._btnTroop._label:setString(string.format("%s %d", Str(STR.TROOP), P._curTroopIndex))
	end
end

function var_0_0.onFindingBattle(arg_25_0, arg_25_1)
	if ClientView._findMatchPanel then
		return
	end

	if P._playerFindClashEx:getIsValidTime() ~= 0 then
		local var_25_0 = P._playerFindClashEx:getTimeTip()

		ToastManager.push(var_25_0)

		return
	end

	local var_25_1, var_25_2 = P._playerCard:checkTroop(P._curTroopIndex)

	if not var_25_1 then
		ToastManager.push(var_25_2)

		return
	end

	ClientData._isAutoBattle = arg_25_1

	require("FindMatchPanel").create(Data.FindMatchType.clash_ex):show()
end

function var_0_0.hideDoor(arg_26_0)
	local var_26_0 = arg_26_0._contentLayer

	if not var_26_0 then
		return
	end

	var_26_0:setLocalZOrder(10)

	arg_26_0._contentLayer = nil

	local var_26_1 = var_26_0._doors

	if var_26_0._tipNode then
		var_26_0._tipNode:setVisible(false)
	end

	if not var_26_1 then
		var_26_0:removeFromParent()
		return
	end

	for iter_26_0 = 1, #var_26_1 do
		local var_26_2 = cc.p(iter_26_0 == 1 and 0 or lc.w(var_26_0), lc.ch(var_26_0))

		var_26_1[iter_26_0]:runAction(lc.sequence(lc.moveTo(0.8, var_26_2), lc.call(function()
			var_26_0:removeFromParent()
		end)))
	end
end

function var_0_0.enterFind(arg_28_0)
	arg_28_0:hideDoor()
	arg_28_0:enterLayer()
end

function var_0_0.onEnter(arg_29_0)
	ClientData.addMsgListener(arg_29_0, function(arg_30_0)
		return arg_29_0:onMsg(arg_30_0)
	end, 0)

	arg_29_0._listeners = {}

	table.insert(arg_29_0._listeners, lc.addEventListener(Data.Event.rematch_again, function(arg_31_0)
		arg_29_0:onRematchEvent(arg_31_0)
	end))
	arg_29_0:enterLayer()
end

function var_0_0.onExit(arg_32_0)
	for iter_32_0 = 1, #arg_32_0._listeners do
		lc.Dispatcher:removeEventListener(arg_32_0._listeners[iter_32_0])
	end

	ClientData.removeMsgListener(arg_32_0)
end

function var_0_0.onBuyTicket(arg_33_0, arg_33_1)
	if P._trophy < Data._globalInfo._legendLadderTrophyLowLimit then
		return ToastManager.push(string.format(Str(STR.CLASH_EX_TIP), Data._globalInfo._legendLadderTrophyLowLimit))
	end

	local var_33_0

	if arg_33_1 == Data.ResType.ingot then
		var_33_0 = Data._globalInfo._legendLadderCost
	elseif arg_33_1 == Data.PropsId.clash_ex_ticket then
		var_33_0 = 1
	else
		return
	end

	if var_33_0 > P:getItemCount(arg_33_1) then
		return ToastManager.push(string.format(Str(STR.NOT_ENOUGH_X), ClientData.getNameByInfoId(arg_33_1)))
	end

	P:addResource(arg_33_1, 1, -var_33_0)

	P._playerFindClashEx._hasTicket = true
	arg_33_0._pendingTicketRes = arg_33_1
	arg_33_0._pendingTicketCost = var_33_0

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendClashExBuyTicket(arg_33_1)
end

function var_0_0.onFinishBattle(arg_34_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendClashExQuit()
end

function var_0_0.onGiveUpBattle(arg_35_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendClashExQuit()
end

function var_0_0.onMsg(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.type

	if var_36_0 == SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_LEGEND then
		arg_36_0._pendingTicketRes = nil
		arg_36_0._pendingTicketCost = nil
		ClientView.getActiveIndicator():hide()
		arg_36_0:enterFind()
	elseif var_36_0 == SglMsgType_pb.PB_TYPE_WORLD_QUIT_LEGEND then
		ClientData.sendOpenBox(P._playerFindClashEx._chest._infoId, 1)

		return true
	elseif var_36_0 == SglMsgType_pb.PB_TYPE_USER_OPEN_CHEST then
		local var_36_1 = arg_36_1.Extensions[User_pb.SglUserMsg.user_open_chest_resp]

		P._playerFindClashEx:clear()
		ClientView.getActiveIndicator():hide()
		arg_36_0:enterLayer()

		local var_36_2 = require("RewardPanel")

		var_36_2.create(var_36_1, var_36_2.MODE_CHEST):show()

		return true
	end
end

-- ClientData dispatches non-OK responses here before onMsg.  Buying the
-- ticket is optimistic on the native screen, so restore that local payment
-- and door state when the server rejects a stale or invalid request.
function var_0_0.onMsgErrorStatus(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1.type == SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_LEGEND then
		if arg_37_0._pendingTicketRes and arg_37_0._pendingTicketCost then
			P:addResource(arg_37_0._pendingTicketRes, 1, arg_37_0._pendingTicketCost)
		end
		arg_37_0._pendingTicketRes = nil
		arg_37_0._pendingTicketCost = nil
		P._playerFindClashEx._hasTicket = false
		ClientView.getActiveIndicator():hide()
		arg_37_0:enterLayer()
		return true
	end

	return var_0_0.super.onMsgErrorStatus(arg_37_0, arg_37_1, arg_37_2)
end

return var_0_0
