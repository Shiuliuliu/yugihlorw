local var_0_0 = class("InRoomSceneNew", BaseUIScene)
local var_0_1 = 150
local var_0_2 = 5
local var_0_3 = 300

function var_0_0.create()
	return lc.createScene(var_0_0)
end

function var_0_0.init(arg_2_0)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.in_room, STR.HALL, BaseUIScene.STYLE_EMPTY, true) then
		return false
	end

	arg_2_0._selectTroop = true

	arg_2_0:createBgs()
	arg_2_0:initBottomArea()

	function arg_2_0._titleArea._btnBack._callback()
		arg_2_0:onExitRoom()
	end

	return true
end

function var_0_0.createBgs(arg_4_0)
	lc.TextureCache:addImage("res/jpg/in_room_bg.jpg")
	arg_4_0._bg:setTexture("res/jpg/in_room_bg.jpg")

	local var_4_0 = lc.createSprite({
		_name = "room_top_bg",
		_crect = cc.rect(165, 0, 1, 1)
	})

	var_4_0:setContentSize(cc.size(700, lc.h(var_4_0)))
	var_4_0:setAnchorPoint(0.5, 0.5)

	local var_4_1 = UserWidget.create(nil, bor(UserWidget.Flag.LEVEL_NAME, UserWidget.Flag.UNION, UserWidget.Flag.REGION), 1.2)

	arg_4_0:adjustUserWidget(var_4_1)
	lc.addChildToPos(var_4_0, var_4_1, cc.p(lc.cw(var_4_0), lc.ch(var_4_0) + 10))

	local var_4_2 = lc.createSprite("room_player_unknown")

	lc.addChildToCenter(var_4_0, var_4_2)

	var_4_1._unknownUser = var_4_2

	lc.addChildToPos(arg_4_0, var_4_0, cc.p(lc.cw(arg_4_0), lc.bottom(arg_4_0._titleArea) - lc.ch(var_4_0)))

	local var_4_3 = lc.createNode()

	lc.addChildToPos(var_4_0, var_4_3, cc.p(lc.cw(var_4_0), 25))

	var_4_1._jobNode = var_4_3

	local var_4_4 = ClientView.createTTF("", ClientView.FontSize.S3, ClientView.COLOR_TEXT_WHITE)

	lc.addChildToPos(var_4_0, var_4_4, cc.p(lc.cw(var_4_0), 75))

	var_4_1._onlineLabel = var_4_4

	local var_4_5 = ClientView.createBMFont(ClientView.BMFont.huali_32, "", cc.TEXT_ALIGNMENT_CENTER, 700)

	var_4_5:setColor(ClientView.COLOR_TEXT_INGOT)
	lc.addChildToPos(var_4_0, var_4_5, cc.p(lc.cw(var_4_0), lc.h(var_4_0) - 30))

	arg_4_0._roomId = var_4_5

	local var_4_6 = ClientView.createShaderButton("img_icon_share", function(arg_5_0)
		arg_4_0:onShare(arg_5_0)
	end)

	lc.addChildToPos(var_4_0, var_4_6, cc.p(lc.w(var_4_0) - 100, lc.h(var_4_0) - 30))

	arg_4_0._shareBtn = var_4_6

	local var_4_7 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_6_0)
		arg_4_0:onBtnHp()
	end, ClientView.CRECT_BUTTON_S, 150)

	lc.addChildToPos(var_4_0, var_4_7, cc.p(120, lc.h(var_4_0) - 30))
	var_4_7:addLabel("")

	arg_4_0._btnHp = var_4_7

	local var_4_8 = lc.createSprite({
		_name = "room_left_bg",
		_crect = cc.rect(10, 10, 1, 1)
	})

	var_4_8:setContentSize(cc.size(lc.cw(arg_4_0) - 20, lc.h(var_4_8)))
	var_4_8:setAnchorPoint(0.5, 0.5)

	local var_4_9 = UserWidget.create(nil, bor(UserWidget.Flag.LEVEL_NAME, UserWidget.Flag.UNION, UserWidget.Flag.REGION), 1.2)

	arg_4_0:adjustUserWidget(var_4_9)
	lc.addChildToPos(var_4_8, var_4_9, cc.p(lc.cw(var_4_8) - 10, lc.ch(var_4_8) - 10))

	local var_4_10 = lc.createNode()

	lc.addChildToPos(var_4_8, var_4_10, cc.p(lc.cw(var_4_8), lc.h(var_4_8) + 20))

	local var_4_11 = ClientView.createBMFont(ClientView.BMFont.huali_32, Str(STR.WIN_S))

	var_4_11:setColor(ClientView.COLOR_TEXT_INGOT)

	local var_4_12 = ClientView.createBMFont(ClientView.BMFont.huali_32, "0")

	var_4_12:setColor(ClientView.COLOR_TEXT_WHITE)
	lc.addNodesToCenter(var_4_10, {
		var_4_11,
		var_4_12
	}, 10)

	var_4_10._winNum = var_4_12
	var_4_9._winNode = var_4_10

	local var_4_13 = arg_4_0:createTroopFrame(var_0_3)

	lc.addChildToPos(var_4_8, var_4_13, cc.p(lc.cw(var_4_13), -lc.ch(var_4_13) + 3))

	var_4_9._troopFrame = var_4_13

	local var_4_14 = lc.createSprite("room_player_unknown")

	lc.addChildToPos(var_4_8, var_4_14, cc.p(lc.cw(var_4_8) - 10, lc.ch(var_4_8) - 20))

	var_4_9._unknownUser = var_4_14

	lc.addChildToPos(arg_4_0, var_4_8, cc.p(lc.cw(var_4_8), var_0_1 + lc.ch(var_4_8)))

	local var_4_15 = lc.createNode()

	lc.addChildToPos(var_4_8, var_4_15, cc.p(lc.cw(var_4_8), lc.h(var_4_8) - 25))

	var_4_9._jobNode = var_4_15

	local var_4_16 = ClientView.createTTF("", ClientView.FontSize.S3, ClientView.COLOR_TEXT_WHITE)

	lc.addChildToPos(var_4_8, var_4_16, cc.p(lc.cw(var_4_8), 30))

	var_4_9._onlineLabel = var_4_16

	local var_4_17 = lc.createSprite({
		_name = "room_right_bg",
		_crect = cc.rect(110, 10, 1, 1)
	})

	var_4_17:setContentSize(cc.size(lc.cw(arg_4_0) - 20, lc.h(var_4_17)))
	var_4_17:setAnchorPoint(0.5, 0.5)

	local var_4_18 = UserWidget.create(nil, bor(UserWidget.Flag.LEVEL_NAME, UserWidget.Flag.UNION, UserWidget.Flag.REGION), 1.2)

	arg_4_0:adjustUserWidget(var_4_18, true)
	lc.addChildToPos(var_4_17, var_4_18, cc.p(lc.cw(var_4_17) + 10, lc.ch(var_4_17) - 10))

	local var_4_19 = lc.createNode()

	lc.addChildToPos(var_4_17, var_4_19, cc.p(lc.cw(var_4_17), lc.h(var_4_17) + 20))

	local var_4_20 = ClientView.createBMFont(ClientView.BMFont.huali_32, Str(STR.WIN_S))

	var_4_20:setColor(ClientView.COLOR_TEXT_INGOT)

	local var_4_21 = ClientView.createBMFont(ClientView.BMFont.huali_32, "0")

	var_4_21:setColor(ClientView.COLOR_TEXT_WHITE)
	lc.addNodesToCenter(var_4_19, {
		var_4_20,
		var_4_21
	}, 10)

	var_4_19._winNum = var_4_21
	var_4_18._winNode = var_4_19

	local var_4_22 = arg_4_0:createTroopFrame(var_0_3, true)

	lc.addChildToPos(var_4_17, var_4_22, cc.p(lc.w(var_4_17) - lc.cw(var_4_22), -lc.ch(var_4_22) + 3))

	var_4_18._troopFrame = var_4_22

	local var_4_23 = lc.createSprite("room_player_unknown")

	lc.addChildToPos(var_4_17, var_4_23, cc.p(lc.cw(var_4_17) + 10, lc.ch(var_4_17) - 20))

	var_4_18._unknownUser = var_4_23

	lc.addChildToPos(arg_4_0, var_4_17, cc.p(lc.w(arg_4_0) - lc.cw(var_4_17), var_0_1 + lc.ch(var_4_17)))

	local var_4_24 = lc.createNode()

	lc.addChildToPos(var_4_17, var_4_24, cc.p(lc.cw(var_4_17), lc.h(var_4_17) - 25))

	var_4_18._jobNode = var_4_24

	local var_4_25 = ClientView.createTTF("", ClientView.FontSize.S3, ClientView.COLOR_TEXT_WHITE)

	lc.addChildToPos(var_4_17, var_4_25, cc.p(lc.cw(var_4_17), 30))

	var_4_18._onlineLabel = var_4_25
	arg_4_0._bgs = {
		var_4_0,
		var_4_8,
		var_4_17
	}
	arg_4_0._users = {
		var_4_1,
		var_4_9,
		var_4_18
	}

	local var_4_26 = lc.createSprite("img_vs")

	lc.addChildToCenter(arg_4_0, var_4_26)

	arg_4_0._vsSpr = var_4_26
end

function var_0_0.createTroopFrame(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = ccui.Widget:create()
	local var_7_1 = lc.createSprite("room_troop_frame1")
	local var_7_2 = lc.createSprite({
		_name = "room_troop_frame2",
		_crect = cc.rect(0, 0, 5, 7),
		_size = cc.size(arg_7_1 - lc.cw(var_7_1), 7)
	})

	var_7_0:setContentSize(cc.size(arg_7_1, lc.h(var_7_1)))

	if not arg_7_2 then
		lc.addChildToPos(var_7_0, var_7_2, cc.p(lc.cw(var_7_2), lc.ch(var_7_2)))
		lc.addChildToPos(var_7_0, var_7_1, cc.p(lc.w(var_7_2) + lc.cw(var_7_1) - 5, lc.ch(var_7_1) + 1))
	else
		lc.addChildToPos(var_7_0, var_7_2, cc.p(lc.cw(var_7_1) + lc.cw(var_7_2) + 7, lc.ch(var_7_2)))
		lc.addChildToPos(var_7_0, var_7_1, cc.p(lc.cw(var_7_1), lc.ch(var_7_1) + 1))
		var_7_1:setScaleX(-1)
	end

	local var_7_3 = cc.ClippingNode:create()

	var_7_3:setContentSize(cc.size(arg_7_1, 50))

	local var_7_4 = cc.DrawNode:create()

	if not arg_7_2 then
		var_7_4:drawSolidPoly({
			cc.p(0, 0),
			cc.p(arg_7_1 - 15, 0),
			cc.p(arg_7_1, 50),
			cc.p(0, 50)
		}, 4, ClientView.COLOR_TEXT_WHITE)
	else
		var_7_4:drawSolidPoly({
			cc.p(15, 0),
			cc.p(arg_7_1, 0),
			cc.p(arg_7_1, 50),
			cc.p(0, 50)
		}, 4, ClientView.COLOR_TEXT_WHITE)
	end

	var_7_4:setPosition(0, 0)
	var_7_3:setStencil(var_7_4)
	lc.addChildToCenter(var_7_0, var_7_3, -1)

	local var_7_5 = 0
	local var_7_6 = {}

	for iter_7_0 = 1, 3 do
		local var_7_7 = 95

		if not arg_7_2 and iter_7_0 == 3 or arg_7_2 and iter_7_0 == 1 then
			var_7_7 = 110
		end

		local var_7_8 = ClientView.createScale9ShaderButton("dark_troop_btn_left", function(arg_8_0)
			arg_7_0:onSelectTroop(arg_8_0)
		end, cc.rect(3, 0, 4, 43), var_7_7, 50)

		lc.addChildToPos(var_7_3, var_7_8, cc.p(var_7_5 + lc.cw(var_7_8), lc.ch(var_7_3) + 5))
		var_7_8:addLabel("")
		var_7_8._label:setPosition(cc.p(not arg_7_2 and 50 or lc.w(var_7_8) - 50, 20))

		var_7_5 = lc.right(var_7_8)
		var_7_6[iter_7_0] = var_7_8
	end

	var_7_0._btns = var_7_6

	function var_7_0.update(arg_9_0)
		local var_9_0 = P._playerRoom:getMyRoom()

		if not var_9_0 then
			return
		end

		if not var_9_0._type == Data.RoomType.dark then
			var_7_0:setVisible(false)

			return
		end

		local var_9_1 = var_9_0:getMembers()[arg_9_0]
		local var_9_2 = var_9_1._idInRoom == P._playerRoom._myIdInRoom

		for iter_9_0, iter_9_1 in ipairs(var_7_6) do
			local var_9_3 = Data.TroopIndex.room_dark_battle1 + iter_9_0 - 1

			iter_9_1:setEnabled(var_9_1._troopMap[var_9_3] == true and var_9_3 ~= var_9_1._curTroop and var_9_2)

			local var_9_4 = iter_9_1:getContentSize()

			iter_9_1:loadTextureNormal(var_9_3 == var_9_1._curTroop and "dark_troop_btn_light" or arg_9_0 == 2 and "dark_troop_btn_left" or "dark_troop_btn_right", ccui.TextureResType.plistType)
			iter_9_1:setContentSize(var_9_4)
			iter_9_1._label:setString(Data.getTroopName(var_9_3, true))
			iter_9_1._label:setColor(var_9_1._troopMap[var_9_3] == true and ClientView.COLOR_TEXT_WHITE or ClientView.COLOR_TEXT_GRAY)

			iter_9_1._troopIndex = var_9_3
		end
	end

	return var_7_0
end

function var_0_0.onSelectTroop(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1._troopIndex

	if not var_10_0 then
		return
	end

	if not arg_10_0._selectTroop then
		return ToastManager.push(Str(STR.OPERATE_REGULARLY))
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendRoomSelectTroop(var_10_0)

	arg_10_0._selectTroop = false

	arg_10_0:runAction(lc.sequence(2, function()
		arg_10_0._selectTroop = true
	end))
end

function var_0_0.initBottomArea(arg_12_0)
	local var_12_0 = lc.createSprite("wait_text_bg")

	var_12_0:setScale(600 / lc.w(var_12_0), 41 / lc.h(var_12_0))
	lc.addChildToPos(arg_12_0, var_12_0, cc.p(lc.cw(arg_12_0), var_0_1 - lc.ch(var_12_0) - 10))

	local var_12_1 = ClientView.createTTF(Str(STR.WAITING) .. Str(STR.LORD) .. Str(STR.JOIN), ClientView.FontSize.S1, ClientView.COLOR_TEXT_WHITE, cc.size(600, 0), cc.TEXT_ALIGNMENT_CENTER)

	lc.addChildToPos(arg_12_0, var_12_1, cc.p(lc.x(var_12_0), lc.y(var_12_0)))

	arg_12_0._tip = var_12_1

	local var_12_2 = lc.createNode()

	lc.addChildToPos(arg_12_0, var_12_2, cc.p(lc.cw(arg_12_0), lc.bottom(var_12_0) / 2))

	local var_12_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_13_0)
		return
	end, ClientView.CRECT_BUTTON, 200)

	var_12_3:addLabel(Str(STR.JOIN) .. Str(STR.CAPTURE))
	var_12_3:setDisabledShader(ClientView.SHADER_DISABLE)
	lc.addChildToPos(arg_12_0, var_12_3, cc.p(lc.cw(arg_12_0) - 100, lc.bottom(var_12_0) / 2))

	arg_12_0._joinBtn = var_12_3

	local var_12_4 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_14_0)
		arg_12_0:startRoomMatch()
	end, ClientView.CRECT_BUTTON, 200)

	var_12_4:addLabel(Str(STR.START))
	var_12_4:setDisabledShader(ClientView.SHADER_DISABLE)
	lc.addChildToPos(arg_12_0, var_12_4, cc.p(lc.cw(arg_12_0) + 100, lc.bottom(var_12_0) / 2))

	arg_12_0._startBtn = var_12_4
end

function var_0_0.onExitRoom(arg_15_0)
	if arg_15_0._isExiting then return end
	local var_15_0 = Str(STR.CONFIRM_CLOSE_ROOM)

	if P and P._roomJob == Data.RoomJob.leader then
		var_15_0 = Str(STR.CREATOR_CONFIRM_CLOSE_ROOM)
	end

	require("Dialog").showDialog(var_15_0, function()
		if arg_15_0._isExiting then return end
		arg_15_0._isExiting = true

		if arg_15_0._roomPollSchedule then
			lc.Scheduler:unscheduleScriptEntry(arg_15_0._roomPollSchedule)
			arg_15_0._roomPollSchedule = nil
		end

		if P and P._playerRoom then
			pcall(function() P._playerRoom:exitMyRoom() end)
		else
			ClientData.sendQuitRoom()
		end

		if lc._runningScene == arg_15_0 or (lc._runningScene and lc._runningScene._sceneId == ClientData.SceneId.in_room) then
			ClientView.popScene()
		end
	end)
end

function var_0_0.onChangeToBattle(arg_17_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendToggleRoomMatch()
end

function var_0_0.startRoomMatch(arg_18_0)
	local var_18_0 = P._playerRoom:getMyRoom():getMembers()

	if var_18_0[2] and var_18_0[3] and var_18_0[2]._isOnline and var_18_0[3]._isOnline then
		ClientData.sendStartRoomMatch()
		ClientView.getActiveIndicator():show(Str(STR.PREPARE_LIVE_BATTLE), nil)
	else
		return ToastManager.push(Str(STR.ROOM_MEMBERS_NOT_READY))
	end
end

function var_0_0.syncData(arg_19_0)
	var_0_0.super.syncData(arg_19_0)

	if not P._roomId then
		arg_19_0:hide()
	end
end

function var_0_0.reload(arg_20_0, arg_20_1)
	var_0_0.super:reload(arg_20_1)

	if not P._roomId then
		arg_20_0:hide()
	end
end

function var_0_0.onEnterRoom(arg_21_0)
	arg_21_0:refreshView()
end

function var_0_0.onChangeToObserve(arg_22_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendToggleRoomMatch()
end

function var_0_0.adjustUserWidget(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1._nameArea._level:setVisible(true)
	arg_23_1._nameArea:setPosition(cc.p(lc.right(arg_23_1._frame) - 5, lc.y(arg_23_1._frame)))
	arg_23_1._unionArea:setPosition(cc.p(lc.right(arg_23_1._frame) + lc.cw(arg_23_1._unionArea) + 5, lc.y(arg_23_1._frame) - lc.ch(arg_23_1._unionArea) - 10))
	arg_23_1._unionArea._name:setColor(ClientView.COLOR_TEXT_WHITE)
	arg_23_1._regionArea:setPositionY(lc.bottom(arg_23_1._frame) - 20)
	arg_23_1._regionArea:setColor(ClientView.COLOR_TEXT_WHITE)
	arg_23_1._idArea:setVisible(false)

	if arg_23_2 then
		arg_23_1:setScaleX(-arg_23_1:getScaleX())
		arg_23_1._frame:setScaleX(-arg_23_1._frame:getScaleX())
		arg_23_1._nameArea._name:setScaleX(-arg_23_1._nameArea._name:getScaleX())
		arg_23_1._nameArea._name:setAnchorPoint(1, 0.5)
		arg_23_1._nameArea._level._level:setScaleX(-arg_23_1._nameArea._level._level:getScaleX())
		arg_23_1._unionArea._name:setScaleX(-arg_23_1._unionArea._name:getScaleX())
		arg_23_1._unionArea._name:setAnchorPoint(1, 0.5)
		arg_23_1._unionArea._word:setScaleX(-arg_23_1._unionArea._word:getScaleX())
		arg_23_1._regionArea:setScaleX(-arg_23_1._regionArea:getScaleX())
		arg_23_1._regionArea:setAnchorPoint(1, 0)
	end
end

function var_0_0.refreshView(arg_24_0)
	arg_24_0._room = P._playerRoom:getMyRoom()

	if not arg_24_0._room then
		return
	end

	local var_24_0 = arg_24_0._room
	local var_24_1 = P._roomId

	arg_24_0._roomId:setString(Str(STR.ROOM_ID) .. " " .. var_24_1)

	local var_24_2 = var_24_0._hp

	arg_24_0._btnHp._label:setString(Str(STR.HP) .. " " .. var_24_2)
	arg_24_0:refreshPlayers()

	local var_24_3 = arg_24_0._room._members

	arg_24_0._pos = nil

	if var_24_3[2] and var_24_3[3] then
		arg_24_0._tip:setString(Str(STR.WAITING) .. Str(STR.CREATOR) .. Str(STR.START) .. Str(STR.COMPETITION))
	else
		arg_24_0._tip:setString(Str(STR.WAITING) .. Str(STR.LORD) .. Str(STR.JOIN))
	end

	for iter_24_0 = 1, 3 do
		local var_24_4 = var_24_3[iter_24_0]

		if var_24_4 and P._playerRoom._myIdInRoom == var_24_4._idInRoom then
			arg_24_0._pos = iter_24_0

			break
		end
	end

	if P._roomJob == Data.RoomJob.leader then
		arg_24_0._btnHp:setVisible(true)

		if P:hasUnion() then
			arg_24_0._shareBtn:setVisible(true)
		else
			arg_24_0._shareBtn:setVisible(false)
		end

		arg_24_0._startBtn:setVisible(true)
		arg_24_0._joinBtn:setPositionX(lc.cw(arg_24_0) - 100)

		if var_24_3[1] and var_24_3[2] and var_24_3[3] then
			arg_24_0._joinBtn:setEnabled(false)
		else
			arg_24_0._joinBtn:setEnabled(true)
		end

		if var_24_3[2] and var_24_3[3] then
			arg_24_0._startBtn:setEnabled(true)
		else
			arg_24_0._startBtn:setEnabled(false)
		end

		if arg_24_0._pos == 1 then
			arg_24_0._joinBtn._label:setString(Str(STR.JOIN) .. Str(STR.CAPTURE))

			function arg_24_0._joinBtn._callback(arg_25_0)
				arg_24_0:onChangeToBattle()
			end
		else
			arg_24_0._joinBtn._label:setString(Str(STR.OBSERVE))

			function arg_24_0._joinBtn._callback(arg_26_0)
				arg_24_0:onChangeToObserve()
			end
		end
	else
		arg_24_0._btnHp:setVisible(false)
		arg_24_0._shareBtn:setVisible(false)
		arg_24_0._startBtn:setVisible(false)
		arg_24_0._joinBtn:setPositionX(lc.cw(arg_24_0))
		arg_24_0._joinBtn._label:setString(Str(STR.EXIT))

		function arg_24_0._joinBtn._callback(arg_27_0)
			arg_24_0:onExitRoom()
		end
	end
end

function var_0_0.refreshPlayers(arg_28_0)
	local var_28_0 = P._playerRoom:getMyRoom()
	local var_28_1 = var_28_0._members

	for iter_28_0 = 1, 3 do
		local var_28_2 = var_28_1[iter_28_0]
		local var_28_3 = arg_28_0._users[iter_28_0]

		var_28_3._jobNode:removeAllChildren()

		if var_28_2 then
			local var_28_4

			var_28_4 = var_28_2._idInRoom == P._playerRoom._myIdInRoom

			var_28_3:setVisible(true)
			var_28_3._unknownUser:setVisible(false)
			var_28_3._jobNode:addChild(lc.createSprite(var_28_2._roomJob == Data.RoomJob.leader and "img_room_leader" or "img_room_rookie"))
			var_28_3._onlineLabel:setString("(" .. (var_28_2._isOnline and Str(STR.ONLINE) or Str(STR.OFFLINE)) .. ")")
			var_28_3._onlineLabel:setColor(var_28_2._isOnline and ClientView.COLOR_TEXT_WHITE or ClientView.COLOR_TEXT_RED)
			var_28_3:setUser(var_28_2)
			var_28_3._idArea:setVisible(false)

			if iter_28_0 > 1 then
				var_28_3._winNode:setVisible(true)
				var_28_3._winNode._winNum:setString(var_28_2._win)
			end

			if iter_28_0 == 3 then
				var_28_3._nameArea._name:setScaleX(-math.abs(var_28_3._nameArea._name:getScaleX()))
			end

			if var_28_3._troopFrame then
				if var_28_0._type == Data.RoomType.dark and iter_28_0 ~= 1 then
					var_28_3._troopFrame:setVisible(true)
					var_28_3._troopFrame.update(iter_28_0)
				else
					var_28_3._troopFrame:setVisible(false)
				end
			end
		else
			var_28_3:setVisible(false)
			var_28_3._unknownUser:setVisible(true)
			var_28_3._onlineLabel:setString("")

			if iter_28_0 > 1 then
				var_28_3._winNode:setVisible(false)

				if var_28_3._troopFrame then
					var_28_3._troopFrame:setVisible(false)
				end
			end
		end
	end
end

function var_0_0.runActionEnterRoom(arg_29_0)
	local var_29_0 = arg_29_0._bgs[1]

	var_29_0:setPositionY(lc.y(var_29_0) + lc.h(var_29_0))
	var_29_0:runAction(lc.ease(lc.moveBy(0.5, cc.p(0, -lc.h(var_29_0))), "SineIO"))

	local var_29_1 = arg_29_0._bgs[2]

	var_29_1:setPositionX(lc.x(var_29_1) - lc.w(var_29_1))
	var_29_1:runAction(lc.ease(lc.moveBy(0.5, cc.p(lc.w(var_29_1), 0)), "SineIO"))

	local var_29_2 = arg_29_0._bgs[3]

	var_29_2:setPositionX(lc.x(var_29_2) + lc.w(var_29_2))
	var_29_2:runAction(lc.ease(lc.moveBy(0.5, cc.p(-lc.w(var_29_2), 0)), "SineIO"))

	local var_29_3 = arg_29_0._vsSpr

	var_29_3:setOpacity(0)
	var_29_3:setScale(0.5)
	var_29_3:runAction(lc.sequence(0.4, lc.fadeIn(0.1), lc.ease(lc.scaleTo(0.2, 1), "BackO")))
end

function var_0_0.onBtnHp(arg_30_0)
	if not arg_30_0._room then
		return
	end

	local var_30_0 = {}

	table.insert(var_30_0, {
		_str = "8000",
		_handler = function()
			arg_30_0:setHp(8000)
		end
	})
	table.insert(var_30_0, {
		_str = "12000",
		_handler = function()
			arg_30_0:setHp(12000)
		end
	})
	table.insert(var_30_0, {
		_str = "16000",
		_handler = function()
			arg_30_0:setHp(16000)
		end
	})

	local var_30_1 = require("TopMostPanel").ButtonList.create(cc.size(200, 320))

	if var_30_1 then
		local var_30_2 = lc.convertPos(cc.p(lc.cw(arg_30_0._btnHp), 0), arg_30_0._btnHp)

		var_30_1:setButtonDefs(var_30_0)
		var_30_1:setPosition(var_30_2.x, var_30_2.y - lc.ch(var_30_1))
		var_30_1:linkNode(arg_30_0._btnHp)
		var_30_1:show()
	end
end

function var_0_0.setHp(arg_34_0, arg_34_1)
	arg_34_0._room._hp = arg_34_1

	ClientData.sendSelectHp(arg_34_1)
	arg_34_0._btnHp._label:setString(Str(STR.HP) .. " " .. arg_34_1)
end

function var_0_0.onEnter(arg_35_0)
	var_0_0.super.onEnter(arg_35_0)
	ClientView.getResourceUI():setVisible(false)

	if not P._playerRoom:getMyRoom() then
		arg_35_0:hide()
	end

	arg_35_0:refreshView()
	arg_35_0:runActionEnterRoom()

	local var_35_0 = {}

	table.insert(var_35_0, lc.addEventListener(Data.Event.room_dirty, function(arg_36_0)
		arg_35_0:refreshView()
	end))
	table.insert(var_35_0, lc.addEventListener(Data.Event.room_exit_dirty, function(arg_37_0)
		if not arg_35_0._isExiting then
			arg_35_0._isExiting = true
			if arg_35_0._roomPollSchedule then
				lc.Scheduler:unscheduleScriptEntry(arg_35_0._roomPollSchedule)
				arg_35_0._roomPollSchedule = nil
			end
			arg_35_0:hide()
		end
	end))

	arg_35_0._listeners = var_35_0

	-- Periodic real-time room polling
	if arg_35_0._roomPollSchedule then
		lc.Scheduler:unscheduleScriptEntry(arg_35_0._roomPollSchedule)
		arg_35_0._roomPollSchedule = nil
	end
	arg_35_0._roomPollSchedule = lc.Scheduler:scheduleScriptFunc(function()
		if not P or not P._roomId then return end
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("get_room_status", { room_id = tostring(P._roomId) }, function(rawRes)
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and res.code == 200 and res.room then
					if res.room.status == "battle" then
						if arg_35_0._roomPollSchedule then
							lc.Scheduler:unscheduleScriptEntry(arg_35_0._roomPollSchedule)
							arg_35_0._roomPollSchedule = nil
						end
						if ClientData.onRoomBattleStart then
							ClientData.onRoomBattleStart(res.room)
						end
					elseif res.room.status == "waiting" then
						if ClientData.syncRoomData then
							ClientData.syncRoomData(res.room)
						end
					end
				elseif res and res.code == 404 then
					if arg_35_0._roomPollSchedule then
						lc.Scheduler:unscheduleScriptEntry(arg_35_0._roomPollSchedule)
						arg_35_0._roomPollSchedule = nil
					end
					ToastManager.push("Phòng đã đóng!")
					if not arg_35_0._isExiting then
						arg_35_0._isExiting = true
						if P and P._playerRoom then
							pcall(function() P._playerRoom:exitMyRoom() end)
						end
						arg_35_0:hide()
					end
				end
			end)
		end
	end, 1.2, false)
end

function var_0_0.onExit(arg_38_0)
	var_0_0.super.onExit(arg_38_0)
	ClientView.getResourceUI():setVisible(true)

	for iter_38_0 = 1, #arg_38_0._listeners do
		lc.Dispatcher:removeEventListener(arg_38_0._listeners[iter_38_0])
	end

	if arg_38_0._countDownSchedule then
		lc.Scheduler:unscheduleScriptEntry(arg_38_0._countDownSchedule)
	end

	if arg_38_0._roomPollSchedule then
		lc.Scheduler:unscheduleScriptEntry(arg_38_0._roomPollSchedule)
		arg_38_0._roomPollSchedule = nil
	end

	lc.TextureCache:removeTextureForKey("res/jpg/in_room_bg.jpg")
end

function var_0_0.onShare(arg_39_0, arg_39_1)
	arg_39_1:setEnabled(false)

	local var_39_0 = P._playerUnion
	local var_39_1 = var_39_0:canOperate(var_39_0.Operate.send_message)

	if var_39_1 == Data.ErrorType.ok then
		ClientData.sendChat(Chat_pb.PB_CHAT_UNION, P._unionId, string.format(Str(STR.ROOM_SHARE), P._roomId))
		ToastManager.push(Str(STR.ROOM_SHARE_SUCCESS))
	else
		ToastManager.push(ClientData.getUnionErrorStr(var_39_1))
	end
end

function var_0_0.onCleanup(arg_40_0)
	var_0_0.super.onCleanup(arg_40_0)
end

return var_0_0
