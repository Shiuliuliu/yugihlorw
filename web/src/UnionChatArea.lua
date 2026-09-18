local var_0_0 = class("UnionChatArea", lc.ExtendCCNode)

PlayerMessage = require("PlayerMessage")

local var_0_1 = 800

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(math.min(arg_1_1, var_0_1), arg_1_2)
	var_1_0:init(arg_1_0)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._unionId = arg_3_1
	arg_3_0._isBattleWaiting = false

	arg_3_0:initTopArea()
	arg_3_0:initChatList()
end

function var_0_0.onEnter(arg_4_0)
	arg_4_0._listeners = {}

	table.insert(arg_4_0._listeners, lc.addEventListener(Data.Event.message, function(arg_5_0)
		arg_4_0:onEvent(arg_5_0)
	end))
	arg_4_0:updateTop()
	arg_4_0:updateList()
	P._playerMessage:clearNew(Data.MsgType.union)
end

function var_0_0.onExit(arg_6_0)
	for iter_6_0 = 1, #arg_6_0._listeners do
		lc.Dispatcher:removeEventListener(arg_6_0._listeners[iter_6_0])
	end
end

function var_0_0.initTopArea(arg_7_0)
	local var_7_0 = lc.createSprite({
		_name = "img_com_bg_4",
		_crect = ClientView.CRECT_COM_BG4,
		_size = cc.size(lc.w(arg_7_0) - 12, 180)
	})

	lc.addChildToPos(arg_7_0, var_7_0, cc.p(lc.w(arg_7_0) / 2 + 4, lc.h(arg_7_0) - lc.h(var_7_0) / 2 - 8), 1)

	arg_7_0._topArea = var_7_0

	local var_7_1
	local var_7_2

	if lc.w(var_7_0) == var_0_1 then
		var_7_1 = -10, -18
	else
		var_7_1 = -30, -10
	end

	local var_7_3 = lc.createSprite("img_glow")

	var_7_3:setScale(0.8)
	lc.addChildToPos(var_7_0, var_7_3, cc.p(math.floor(lc.sw(var_7_3) / 2) + var_7_1, lc.h(var_7_0) / 2))

	local var_7_4 = ClientView.createBadge(1, "")

	var_7_4:setScale(0.7)
	lc.addChildToPos(var_7_0, var_7_4, cc.p(var_7_3:getPosition()), 1)

	arg_7_0._badge = var_7_4

	local var_7_5 = ClientView.createLevelNameArea(1, "")

	lc.addChildToPos(var_7_0, var_7_5, cc.p(math.floor(lc.right(var_7_4)) - 2, lc.y(var_7_4) + lc.h(var_7_5) / 2 - 14))

	arg_7_0._nameArea = var_7_5

	local var_7_6 = lc.left(var_7_5) + 40

	arg_7_0._id = ClientView.addIconValue(var_7_0, "img_icon_id", 0, var_7_6, lc.y(var_7_4) - 10)

	arg_7_0._id:setColor(ClientView.COLOR_TEXT_DARK)

	arg_7_0._member = ClientView.addIconValue(var_7_0, "img_icon_troop", 0, var_7_6, lc.y(var_7_4) - 50)

	arg_7_0._member:setColor(ClientView.COLOR_TEXT_DARK)

	local var_7_7 = string.format("%s: %d/%d", lc.str(STR.ONLINE), 1, 20)
	local var_7_8 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_7_7)

	lc.addChildToPos(var_7_0, var_7_8, cc.p(lc.w(var_7_0) - 40, lc.ch(var_7_0) + 50))
	var_7_8:setAnchorPoint(cc.p(1, 0.5))
	var_7_8:setColor(ClientView.COLOR_TEXT_GREEN_2)
	var_7_8:setVisible(false)

	local var_7_9 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_8_0)
		arg_7_0:onBattleCreate()
	end, ClientView.CRECT_BUTTON, 150)

	lc.addChildToPos(var_7_0, var_7_9, cc.p(lc.w(var_7_0) - lc.cw(var_7_9) - 30, lc.ch(var_7_0) - 20))
	var_7_9:addLabel(lc.str(STR.FRIEND_BATTLE))

	local var_7_10 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_9_0)
		local var_9_0 = require("InputForm")

		var_9_0.create(var_9_0.Type.UNION_CHAT):show()
	end, ClientView.CRECT_BUTTON, 150)

	lc.addChildToPos(var_7_0, var_7_10, cc.p(lc.left(var_7_9) - lc.cw(var_7_10) - 30, lc.y(var_7_9)))
	var_7_10:addIcon("img_icon_chat_l")
end

function var_0_0.initChatList(arg_10_0)
	local var_10_0 = lc.List.createV(cc.size(lc.w(arg_10_0) - 12, lc.bottom(arg_10_0._topArea) + 8), 6, 0)

	lc.addChildToPos(arg_10_0, var_10_0, cc.p(10, 0))

	arg_10_0._chatList = var_10_0
end

function var_0_0.updateList(arg_11_0)
	local var_11_0 = P._playerMessage._msgAll[Data.MsgType.union]
	local var_11_1 = 1
	local var_11_2 = 1

	while true do
		local var_11_3 = var_11_0[var_11_1]
		local var_11_4 = arg_11_0._chatList:getItems()[var_11_2]

		if not var_11_3 then
			if not var_11_4 then
				break
			else
				arg_11_0._chatList:removeItem(var_11_2 - 1)
			end
		elseif not var_11_4 or var_11_3 ~= var_11_4._message then
			if arg_11_0:getIsInvalidBattle(var_11_3) then
				var_11_1 = var_11_1 + 1
			else
				arg_11_0:addNewMessage(var_11_3, var_11_2 - 1)

				var_11_2 = var_11_2 + 1
				var_11_1 = var_11_1 + 1
			end
		elseif arg_11_0:getIsInvalidBattle(var_11_3) then
			arg_11_0._chatList:removeItem(var_11_2 - 1)

			var_11_1 = var_11_1 + 1
		else
			var_11_2 = var_11_2 + 1
			var_11_1 = var_11_1 + 1
		end
	end

	arg_11_0._chatList:stopAllActions()
end

function var_0_0.getIsInvalidBattle(arg_12_0, arg_12_1)
	if arg_12_1._type == Data.MsgType.union and arg_12_1._battleId and not arg_12_1._isValid and not arg_12_1._opponent then
		return true
	end

	return false
end

function var_0_0.addNewMessage(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	if arg_13_1._type == Data.MsgType.union then
		if arg_13_1._battleId == nil then
			var_13_0 = arg_13_0:addChatItem(arg_13_1)
		else
			var_13_0 = arg_13_0:addBattleItem(arg_13_1)
		end
	end

	if var_13_0 then
		arg_13_0._chatList:insertCustomItem(var_13_0, arg_13_2)
	end
end

function var_0_0.addChatItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1._user._id == P._id
	local var_14_1 = ccui.Layout:create()

	var_14_1._message = arg_14_1

	local var_14_2 = arg_14_1._clr and lc.Color3B.light_blue or lc.Color3B.black
	local var_14_3 = ClientView.createBoldRichText(arg_14_1._content, {
		_normalClr = var_14_2,
		_boldClr = var_14_2,
		_width = lc.w(arg_14_0._chatList) - 150
	})
	local var_14_4 = math.max(lc.h(var_14_3) + 50, 84)
	local var_14_5 = 130 + var_14_4 - 84

	var_14_1:setContentSize(cc.size(lc.w(arg_14_0._chatList), var_14_5))
	var_14_1:setAnchorPoint(cc.p(0.5, 0.5))

	local var_14_6 = var_14_0 and lc.createSprite({
		_name = "img_com_bg_53",
		_size = cc.size(lc.w(arg_14_0._chatList) - 100, var_14_4),
		_crect = cc.rect(30, 60, 1, 1)
	}) or lc.createSprite({
		_name = "img_com_bg_52",
		_size = cc.size(lc.w(arg_14_0._chatList) - 100, var_14_4),
		_crect = cc.rect(40, 60, 1, 1)
	})
	local var_14_7 = var_14_0 and lc.cw(var_14_6) or lc.cw(var_14_6) + 100

	lc.addChildToPos(var_14_1, var_14_6, cc.p(var_14_7, lc.h(var_14_1) - lc.ch(var_14_6) - 40))

	local var_14_8 = var_14_0 and lc.cw(var_14_3) + 10 or lc.cw(var_14_3) + 40

	lc.addChildToPos(var_14_6, var_14_3, cc.p(var_14_8, lc.ch(var_14_6) + 6))

	local var_14_9 = UserWidget.create(arg_14_1._user, 0)
	local var_14_10 = var_14_0 and lc.w(var_14_1) - lc.cw(var_14_9) or lc.cw(var_14_9)

	lc.addChildToPos(var_14_1, var_14_9, cc.p(var_14_10, lc.h(var_14_1) - lc.ch(var_14_9) - 20))

	local var_14_11 = ClientView.createTTF(arg_14_1._user._name, ClientView.FontSize.S2)
	local var_14_12 = var_14_0 and lc.left(var_14_9) - lc.cw(var_14_11) - 30 or lc.right(var_14_9) + lc.cw(var_14_11) + 30

	lc.addChildToPos(var_14_1, var_14_11, cc.p(var_14_12, lc.h(var_14_1) - lc.ch(var_14_11) - 12))

	local var_14_13 = string.format("%d%s", "0", lc.str(STR.SECOND_AGO))
	local var_14_14 = ClientView.createTTF(var_14_13, ClientView.FontSize.S2)
	local var_14_15 = var_14_0 and 10 or lc.w(var_14_1) - 10

	var_14_14:setAnchorPoint(var_14_0 and cc.p(0, 0.5) or cc.p(1, 0.5))
	lc.addChildToPos(var_14_1, var_14_14, cc.p(var_14_15, lc.h(var_14_1) - lc.ch(var_14_14) - 12))

	var_14_1._time = var_14_14

	function var_14_1.update(arg_15_0)
		arg_15_0._time:setString(ClientData.getTimeAgo(arg_15_0._message._timestamp))
	end

	var_14_1:update(arg_14_0)

	return var_14_1
end

function var_0_0.addBattleItem(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1._user._id == P._id
	local var_16_1 = ccui.Layout:create()

	var_16_1:setContentSize(cc.size(lc.w(arg_16_0._chatList), 200))
	var_16_1:setAnchorPoint(cc.p(0.5, 0.5))

	var_16_1._message = arg_16_1

	local var_16_2 = lc.createSprite({
		_name = "img_com_bg_54",
		_crect = cc.rect(20, 70, 1, 1),
		_size = cc.size(lc.w(arg_16_0._chatList), 180)
	})

	lc.addChildToCenter(var_16_1, var_16_2)

	local var_16_3 = UserWidget.create(arg_16_1._user, UserWidget.Flag.LEVEL_NAME, 0.8, false)

	lc.addChildToPos(var_16_1, var_16_3, cc.p(lc.cw(var_16_3) + 20, lc.h(var_16_1) - lc.ch(var_16_3) - 25))

	local var_16_4 = UserWidget.create(arg_16_1._user, UserWidget.Flag.LEVEL_NAME, 0.8, true)

	lc.addChildToPos(var_16_1, var_16_4, cc.p(lc.w(var_16_1) - lc.cw(var_16_4) - 20, lc.y(var_16_3)))

	local var_16_5 = lc.createSprite("img_vs_s")

	lc.addChildToPos(var_16_1, var_16_5, cc.p(lc.cw(var_16_1), lc.y(var_16_3) + 20))

	local var_16_6 = ClientView.createTTF("", ClientView.FontSize.S3)

	lc.addChildToPos(var_16_5, var_16_6, cc.p(lc.cw(var_16_5), lc.ch(var_16_5) - 50))
	var_16_6:setColor(lc.Color3B.black)

	if var_16_0 then
		local var_16_7 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_17_0)
			arg_16_0:onBattleCancel()
		end, ClientView.CRECT_BUTTON_S, 140)

		lc.addChildToPos(var_16_1, var_16_7, cc.p(lc.cw(var_16_1), lc.ch(var_16_7) + 30))
		var_16_7:addLabel(lc.str(STR.CANCEL))

		var_16_1._btnCancel = var_16_7
	else
		local var_16_8 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_18_0)
			arg_16_0:onBattleJoin(arg_16_1)
		end, ClientView.CRECT_BUTTON_S, 140)

		lc.addChildToPos(var_16_1, var_16_8, cc.p(lc.cw(var_16_1), lc.ch(var_16_8) + 30))
		var_16_8:addLabel(lc.str(STR.JOIN))

		var_16_1._btnJoin = var_16_8
	end

	local var_16_9 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_19_0)
		arg_16_0:onBattleReplay(arg_16_1)
	end, ClientView.CRECT_BUTTON_S, 140)

	lc.addChildToPos(var_16_1, var_16_9, cc.p(lc.cw(var_16_1), lc.ch(var_16_9) + 30))
	var_16_9:addLabel(lc.str(STR.REPLAY))

	var_16_1._btnReplay = var_16_9

	local var_16_10 = ClientView.createTTF(lc.str(STR.FRIEND_BATTLE_SEARCH), ClientView.FontSize.M2)

	lc.addChildToPos(var_16_1, var_16_10, cc.p(lc.cw(var_16_1) + lc.cw(var_16_10) + 30, lc.y(var_16_3)))
	var_16_10:setColor(lc.Color3B.black)

	local var_16_11 = ClientView.createTTF(lc.str(STR.DISABLED), ClientView.FontSize.M1)

	lc.addChildToPos(var_16_1, var_16_11, cc.p(lc.cw(var_16_1), lc.y(var_16_9)))
	var_16_11:setColor(lc.Color3B.black)

	function var_16_1.update(arg_20_0, arg_20_1)
		if arg_20_0._message._isValid then
			if arg_20_0._btnCancel then
				arg_20_0._btnCancel:setVisible(true)
			elseif arg_20_0._btnJoin then
				arg_20_0._btnJoin:setVisible(true)
			end

			arg_20_0._btnReplay:setVisible(false)
			var_16_11:setVisible(false)
			var_16_10:setVisible(true)
			var_16_4:setVisible(false)
			var_16_5:setVisible(false)
		elseif not arg_20_0._message._opponent then
			if arg_20_0._btnCancel then
				arg_20_0._btnCancel:setVisible(false)
			elseif arg_20_0._btnJoin then
				arg_20_0._btnJoin:setVisible(false)
			end

			arg_20_0._btnReplay:setVisible(false)
			var_16_11:setVisible(true)
			var_16_11:setString(lc.str(STR.DISABLED))
			var_16_10:setVisible(true)
			var_16_4:setVisible(false)
			var_16_5:setVisible(false)
		elseif not arg_20_0._message._resultType then
			if arg_20_0._btnCancel then
				arg_20_0._btnCancel:setVisible(false)
			elseif arg_20_0._btnJoin then
				arg_20_0._btnJoin:setVisible(false)
			end

			arg_20_0._btnReplay:setVisible(false)
			var_16_11:setVisible(true)
			var_16_11:setString(lc.str(STR.FRIEND_BATTLE_UNDER))
			var_16_10:setVisible(false)
			var_16_4:setVisible(true)
			var_16_4:setUser(arg_20_0._message._opponent)
			var_16_5:setVisible(true)
			var_16_6:setString(ClientData.getTimeAgo(arg_20_0._message._timestamp))
		else
			if arg_20_0._btnCancel then
				arg_20_0._btnCancel:setVisible(false)
			elseif arg_20_0._btnJoin then
				arg_20_0._btnJoin:setVisible(false)
			end

			arg_20_0._btnReplay:setVisible(arg_20_0._message._replayId ~= nil)
			var_16_11:setVisible(false)
			var_16_10:setVisible(false)
			var_16_4:setVisible(true)
			var_16_4:setUser(arg_20_0._message._opponent)
			var_16_5:setVisible(true)
			var_16_6:setString(ClientData.getTimeAgo(arg_20_0._message._timestamp))
		end
	end

	var_16_1:update(arg_16_0)

	return var_16_1
end

function var_0_0.updateTop(arg_21_0)
	local var_21_0 = P._playerUnion:getMyUnion()

	arg_21_0._badge:update(var_21_0._badge, var_21_0._word)

	local var_21_1 = arg_21_0._nameArea

	var_21_1._level:setString(tostring(var_21_0._level))
	var_21_1:setName(var_21_0._name)
	arg_21_0._id:setString(ClientData.convertId(var_21_0._id))
	arg_21_0._member:setString(string.format("%d/%d", var_21_0:getMembersNum(), var_21_0._memberCapacity))
end

function var_0_0.onBattleCreate(arg_22_0)
	if arg_22_0._isBattleWaiting then
		ToastManager.push(lc.str(STR.FRIEND_BATTLE_SEARCHING))
	else
		arg_22_0._isBattleWaiting = true

		ClientData.sendUnionFriendBattle(P._curTroopIndex)
	end
end

function var_0_0.onBattleCancel(arg_23_0, arg_23_1)
	if arg_23_0._isBattleWaiting then
		arg_23_0._isBattleWaiting = false

		if not arg_23_1 then
			ToastManager.push(lc.str(STR.FRIEND_BATTLE_CANCEL))
		end

		ClientData.sendUnionFriendBattleCancel()
	end
end

function var_0_0.onBattleJoin(arg_24_0, arg_24_1)
	if arg_24_0._isBattleWaiting then
		return arg_24_0:onBattleCancel()
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendUnionFriendBattleJoin(P._curTroopIndex, arg_24_1._battleId, arg_24_1._user._id)
end

function var_0_0.onBattleReplay(arg_25_0, arg_25_1)
	if arg_25_0._isBattleWaiting then
		arg_25_0:onBattleCancel()
	end

	ClientData.sendBattleReplay(arg_25_1._replayId, true)
end

function var_0_0.onEvent(arg_26_0, arg_26_1)
	if arg_26_1._event == PlayerMessage.Event.msg_new then
		if arg_26_1._param > 0 then
			arg_26_0:updateList()
		end
	elseif arg_26_1._event == PlayerMessage.Event.msg_update then
		arg_26_0:updateList()
	end
end

return var_0_0
