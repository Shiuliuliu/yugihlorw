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

	lc.TextureCache:addImageWithMask("res/jpg/create_room.jpg")

	local var_3_1 = ClientView.createShaderButton("res/jpg/create_room.jpg", function(arg_4_0)
		arg_3_0:createRoom()
	end)

	var_3_1:setAnchorPoint(1, 0.5)
	lc.addChildToPos(arg_3_0, var_3_1, cc.p(lc.cw(arg_3_0) - var_3_0, lc.ch(arg_3_0) + lc.ch(arg_3_0._bottomArea)))
	lc.TextureCache:addImageWithMask("res/jpg/join_room.jpg")

	local var_3_2 = ClientView.createShaderButton("res/jpg/join_room.jpg", function(arg_5_0)
		require("InputNumberForm").create(Str(STR.INPUT_ROOM_ID) .. ":", P._lastRoomId, function(arg_6_0, arg_6_1)
			arg_3_0:onJoinRoom(arg_6_0, arg_6_1)
		end):show()
	end)

	var_3_2:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_3_0, var_3_2, cc.p(lc.cw(arg_3_0) + var_3_0, lc.y(var_3_1)))
end

function var_0_0.initBottomArea(arg_7_0)
	local var_7_0 = lc.createNode(cc.size(lc.w(arg_7_0), 80))

	lc.addChildToPos(arg_7_0, var_7_0, cc.p(lc.w(arg_7_0) / 2, lc.h(var_7_0) / 2))

	arg_7_0._bottomArea = var_7_0

	local var_7_1 = ClientView.createLineSprite("img_bottom_bg", lc.w(var_7_0))

	lc.addChildToPos(var_7_0, var_7_1, cc.p(lc.w(var_7_0) / 2, lc.h(var_7_0) / 2))

	local var_7_2 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("RoomBattleReportForm").create():show()
	end, ClientView.CRECT_BUTTON_S, 120)

	var_7_2:addLabel(Str(STR.LOG))
	lc.addChildToPos(var_7_0, var_7_2, cc.p(lc.w(var_7_0) - 6 - lc.w(var_7_2) / 2, 36))

	local var_7_3 = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_7_0._ignoreSync = true

		lc.pushScene(require("HeroCenterScene").create())
	end, ClientView.CRECT_BUTTON_S, 120)

	var_7_3:addLabel("0")
	lc.addChildToPos(var_7_0, var_7_3, cc.p(lc.left(var_7_2) - 10 - lc.w(var_7_3) / 2, lc.y(var_7_2)))

	arg_7_0._btnTroop = var_7_3
end

function var_0_0.updateTroopButton(arg_10_0)
	if arg_10_0._btnTroop then
		arg_10_0._btnTroop._label:setString(string.format("%s %d", Str(STR.TROOP), P._curTroopIndex))
	end
end

function var_0_0.onJoinRoom(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = tonumber(arg_11_2)

	if not var_11_0 or #arg_11_2 < 4 or #arg_11_2 > 6 then
		ToastManager.push(Str(STR.MATCH_JOIN_NOT_ALLOWED))
		arg_11_1:hide()

		return
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendQueryRoom(var_11_0)
	arg_11_1:hide()
end

function var_0_0.createRoom(arg_12_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendCreateRoom()
end

function var_0_0.onEnter(arg_13_0)
	arg_13_0:updateTroopButton()

	arg_13_0._listeners = {}
end

function var_0_0.onExit(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_14_1)
	end
end

function var_0_0.onCleanup(arg_15_0)
	lc.TextureCache:removeTextureForKey("res/jpg/create_room.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/join_room.jpg")
end

return var_0_0
