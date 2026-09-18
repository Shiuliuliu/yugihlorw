local var_0_0 = class("RoomBattleReportForm", BaseForm)
local var_0_1 = cc.size(900, 700)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.LOG), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))
	P._playerRoom:sendGetRoomLog()

	arg_2_0._indicator = ClientView.showPanelActiveIndicator(arg_2_0._form)

	arg_2_0:initReplayList()
end

function var_0_0.onEnter(arg_3_0)
	arg_3_0._listeners = {}

	arg_3_0:updateList()
	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.log_dirty, function(arg_4_0)
		arg_3_0:onLogEvent(arg_4_0)
	end))
end

function var_0_0.onExit(arg_5_0)
	for iter_5_0 = 1, #arg_5_0._listeners do
		lc.Dispatcher:removeEventListener(arg_5_0._listeners[iter_5_0])
	end
end

function var_0_0.onLogEvent(arg_6_0, arg_6_1)
	local var_6_0 = require("PlayerLog")

	if arg_6_1._event == var_6_0.Event.room_log_dirty then
		if arg_6_0._indicator then
			arg_6_0._indicator:removeFromParent()

			arg_6_0._indicator = nil
		end

		arg_6_0:updateList()
	end
end

function var_0_0.initReplayList(arg_7_0)
	local var_7_0 = lc.List.createV(cc.size(lc.w(arg_7_0._form) - 100, lc.bottom(arg_7_0._titleFrame)), 6, 0)

	lc.addChildToPos(arg_7_0._form, var_7_0, cc.p(50, 25))

	arg_7_0._replayList = var_7_0
end

function var_0_0.updateList(arg_8_0)
	local var_8_0 = Battle_pb.PB_BATTLE_MATCH
	local var_8_1 = P._playerLog:getLogList(var_8_0)

	if not var_8_1 then
		return
	end

	arg_8_0._replayList:bindData(var_8_1, function(arg_9_0, arg_9_1)
		arg_8_0:setOrCreateItem(arg_9_0, arg_9_1)
	end, math.min(5, #var_8_1))

	for iter_8_0 = 1, arg_8_0._replayList._cacheCount do
		local var_8_2 = arg_8_0:setOrCreateItem(nil, var_8_1[iter_8_0])

		arg_8_0._replayList:pushBackCustomItem(var_8_2)
	end

	arg_8_0._replayList:stopAllActions()
	arg_8_0._replayList:checkEmpty(Str(STR.LIST_EMPTY_NO_LOG))
end

function var_0_0.setOrCreateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2._player
	local var_10_1 = arg_10_2._opponent
	local var_10_2 = arg_10_2._resultType

	if not arg_10_1 then
		arg_10_1 = ccui.Layout:create()

		arg_10_1:setContentSize(cc.size(lc.w(arg_10_0._replayList), 200))
		arg_10_1:setAnchorPoint(cc.p(0.5, 0.5))

		arg_10_1._log = arg_10_2

		local var_10_3 = lc.createSprite({
			_name = "img_com_bg_54",
			_crect = cc.rect(20, 70, 1, 1),
			_size = cc.size(lc.w(arg_10_0._replayList), 180)
		})

		lc.addChildToCenter(arg_10_1, var_10_3)

		local var_10_4 = UserWidget.create(var_10_0, UserWidget.Flag.REGION_NAME_UNION, 0.8, false)

		lc.addChildToPos(arg_10_1, var_10_4, cc.p(lc.cw(var_10_4) + 20, lc.h(arg_10_1) - lc.ch(var_10_4) - 30))

		arg_10_1._userAvatar = var_10_4

		local var_10_5 = UserWidget.create(var_10_1, UserWidget.Flag.REGION_NAME_UNION, 0.8, true)

		lc.addChildToPos(arg_10_1, var_10_5, cc.p(lc.w(arg_10_1) - lc.cw(var_10_5) - 30, lc.y(var_10_4)))

		arg_10_1._oppoAvatar = var_10_5

		local var_10_6 = lc.createSprite("img_win")

		lc.addChildToPos(arg_10_1, var_10_6, cc.p(lc.x(var_10_4), lc.bottom(var_10_4) - 30))

		arg_10_1._leftSpr = var_10_6

		local var_10_7 = lc.createSprite("img_lose")

		lc.addChildToPos(arg_10_1, var_10_7, cc.p(lc.x(var_10_5), lc.bottom(var_10_5) - 30))

		arg_10_1._rightSpr = var_10_7

		local var_10_8 = lc.createSprite("img_vs_s")

		lc.addChildToPos(arg_10_1, var_10_8, cc.p(lc.cw(arg_10_1), lc.y(var_10_4) + 20))

		local var_10_9 = ClientView.createTTF("", ClientView.FontSize.S3)

		lc.addChildToPos(var_10_8, var_10_9, cc.p(lc.cw(var_10_8), lc.ch(var_10_8) - 50))
		var_10_9:setColor(lc.Color3B.black)

		arg_10_1._timeLabel = var_10_9

		local var_10_10 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_11_0)
			arg_10_0:onBattleReplay(arg_10_2)
		end, ClientView.CRECT_BUTTON_S, 140)

		lc.addChildToPos(arg_10_1, var_10_10, cc.p(lc.cw(arg_10_1), lc.ch(var_10_10) + 30))
		var_10_10:addLabel(lc.str(STR.REPLAY))

		arg_10_1._btnReplay = var_10_10

		function arg_10_1.update(arg_12_0)
			arg_12_0._btnReplay:setVisible(arg_12_0._log._replayId ~= nil)
			arg_12_0._userAvatar:setUser(arg_12_0._log._player)
			arg_12_0._oppoAvatar:setUser(arg_12_0._log._opponent)
			arg_12_0._timeLabel:setString(ClientData.getTimeAgo(arg_12_0._log._timestamp))

			if arg_12_0._log._resultType == Data.BattleResult.win then
				arg_12_0._leftSpr:setSpriteFrame("img_win")
				arg_12_0._rightSpr:setSpriteFrame("img_lose")
			elseif arg_12_0._log._resultType == Data.BattleResult.lose then
				arg_12_0._leftSpr:setSpriteFrame("img_lose")
				arg_12_0._rightSpr:setSpriteFrame("img_win")
			elseif arg_12_0._log._resultType == Data.BattleResult.draw then
				arg_12_0._leftSpr:setSpriteFrame("img_draw")
				arg_12_0._rightSpr:setSpriteFrame("img_draw")
			end
		end
	else
		arg_10_1._log = arg_10_2
	end

	arg_10_1:update()

	return arg_10_1
end

function var_0_0.onBattleReplay(arg_13_0, arg_13_1)
	ClientData._replayingLog = arg_13_1

	local var_13_0 = arg_13_1:isLocal()

	ClientData.sendBattleReplay(arg_13_1._replayId, var_13_0)
end

return var_0_0
