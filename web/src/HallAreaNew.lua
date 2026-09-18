local var_0_0 = class("HallArea", lc.ExtendCCNode)
local var_0_1 = 800

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
		elseif arg_2_0 == "cleanup" then
			var_1_0:onCleanup()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0)
	arg_3_0:initBottomArea()

	local var_3_0 = 10

	lc.TextureCache:addImageWithMask("res/jpg/create_single_room.jpg")

	local var_3_1 = ClientView.createShaderButton("res/jpg/create_single_room.jpg", function(arg_4_0)
		arg_3_0:createRoom(Data.RoomType.normal)
	end)

	var_3_1:setAnchorPoint(1, 0.5)
	lc.addChildToPos(arg_3_0, var_3_1, cc.p(lc.cw(arg_3_0) - var_3_0, lc.ch(arg_3_0) + lc.ch(arg_3_0._bottomArea)))

	arg_3_0._createBtn = var_3_1

	lc.TextureCache:addImageWithMask("res/jpg/create_dark_room.jpg")

	local var_3_2 = ClientView.createShaderButton("res/jpg/create_dark_room.jpg", function(arg_5_0)
		arg_3_0:createRoom(Data.RoomType.dark)
	end)

	var_3_2:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_3_0, var_3_2, cc.p(lc.cw(arg_3_0) + var_3_0, lc.y(var_3_1)))

	arg_3_0._createDarkBtn = var_3_2

	local var_3_3 = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_3_0._ignoreSync = true

		lc.pushScene(require("HeroCenterScene").create())
	end, ClientView.CRECT_BUTTON_S, 100)

	var_3_3:addLabel("0")
	lc.addChildToPos(var_3_1, var_3_3, cc.p(lc.w(var_3_1) - lc.cw(var_3_3) - 10, lc.ch(var_3_3) + 20))

	arg_3_0._btnTroop = var_3_3

	local var_3_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_7_0)
		lc.pushScene(require("HeroCenterScene").create(Data.TroopIndex.room_dark_battle1))
	end, ClientView.CRECT_BUTTON_S, 100)

	var_3_4:addLabel(Str(STR.MANAGE_CARDS))
	lc.addChildToPos(var_3_2, var_3_4, cc.p(lc.w(var_3_1) - lc.cw(var_3_3) - 10, lc.ch(var_3_3) + 20))
end

function var_0_0.initBottomArea(arg_8_0)
	local var_8_0 = lc.createNode(cc.size(lc.w(arg_8_0), 80))

	lc.addChildToPos(arg_8_0, var_8_0, cc.p(lc.w(arg_8_0) / 2, lc.h(var_8_0) / 2))

	arg_8_0._bottomArea = var_8_0

	local var_8_1 = ClientView.createLineSprite("img_bottom_bg", lc.w(var_8_0))

	lc.addChildToPos(var_8_0, var_8_1, cc.p(lc.w(var_8_0) / 2, lc.h(var_8_0) / 2))

	local var_8_2 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("RoomBattleReportForm").create():show()
	end, ClientView.CRECT_BUTTON_S, 120)

	var_8_2:addLabel(Str(STR.LOG))
	lc.addChildToPos(var_8_0, var_8_2, cc.p(lc.w(var_8_0) - 6 - lc.w(var_8_2) / 2 - ClientView.SCR_EDGE, 36))

	local var_8_3 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("InputNumberForm").create("", P._lastRoomId, function(arg_11_0, arg_11_1)
			arg_8_0:onJoinRoom(arg_11_0, arg_11_1)
		end):show()
	end, ClientView.CRECT_BUTTON_S, 120)

	var_8_3:addLabel(Str(STR.JOIN))
	lc.addChildToPos(var_8_0, var_8_3, cc.p(lc.left(var_8_2) - 10 - lc.w(var_8_3) / 2, lc.y(var_8_2)))
end

function var_0_0.updateTroopButton(arg_12_0)
	if arg_12_0._btnTroop then
		arg_12_0._btnTroop._label:setString(string.format("%s %d", Str(STR.TROOP), P._curTroopIndex))
	end
end

function var_0_0.onJoinRoom(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = tonumber(arg_13_2)

	if not var_13_0 or #arg_13_2 < 4 or #arg_13_2 > 6 then
		ToastManager.push(Str(STR.MATCH_JOIN_NOT_ALLOWED))
		arg_13_1:hide()

		return
	end

	local var_13_3, var_13_4 = P._playerCard:checkTroop(P._curTroopIndex)
	if not var_13_3 then
		arg_13_1:hide()
		return ToastManager.push(var_13_4)
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendQueryRoom(var_13_0)
	arg_13_1:hide()
end

function var_0_0.createRoom(arg_14_0, arg_14_1)
	local var_14_2, var_14_3 = P._playerCard:checkTroop(P._curTroopIndex)
	if not var_14_2 then
		return ToastManager.push(var_14_3)
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendCreateRoom(arg_14_1)
end

function var_0_0.onEnter(arg_15_0)
	arg_15_0:updateTroopButton()

	arg_15_0._listeners = {}
end

function var_0_0.onExit(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_16_1)
	end
end

function var_0_0.onCleanup(arg_17_0)
	lc.TextureCache:removeTextureForKey("res/jpg/create_single_room.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/create_dark_room.jpg")
end

return var_0_0
