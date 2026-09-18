local var_0_0 = class("UnionBattleArea", lc.ExtendCCNode)
local var_0_1 = 300
local var_0_2 = 100
local var_0_3 = 260
local var_0_4 = 380
local var_0_5 = 75
local var_0_6 = 100

var_0_0.AreaType = {
	default = 1,
	my_group = 2,
	game_info = 3
}

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
	local var_3_0 = lc.createSprite("res/jpg/union_battle_bg.jpg")

	lc.addChildToCenter(arg_3_0, var_3_0)

	arg_3_0._areaNode = lc.createNode()

	arg_3_0._areaNode:setContentSize(arg_3_0:getContentSize())
	lc.addChildToCenter(arg_3_0, arg_3_0._areaNode)

	arg_3_0._listeners = {}

	ClientData.addMsgListener(arg_3_0, function(arg_4_0)
		return arg_3_0:onMsg(arg_4_0)
	end, 0)
	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.union_group_dirty, function()
		if arg_3_0:isDataReady() then
			if arg_3_0._indicator then
				arg_3_0._indicator:removeFromParent()

				arg_3_0._indicator = nil
			end

			arg_3_0:updateView()
		end
	end))
	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.group_cards_dirty, function()
		if arg_3_0._areaType == var_0_0.AreaType.my_group then
			lc.pushScene(require("HeroCenterScene").create(Data.TroopIndex.union_battle1))
		end
	end))
	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.rank_list_dirty, function(arg_7_0)
		if arg_3_0._areaType == var_0_0.AreaType.game_info then
			if arg_7_0._type == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP then
				arg_3_0:refreshMVPRankList()
			end

			if arg_7_0._type == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM then
				arg_3_0:refreshGroupRankList()
			end
		end

		if (arg_7_0._type == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM or arg_7_0._type == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP) and arg_3_0:isDataReady() then
			if arg_3_0._indicator then
				arg_3_0._indicator:removeFromParent()

				arg_3_0._indicator = nil
			end

			arg_3_0:updateView()
		end
	end))
end

function var_0_0.initTopArea(arg_8_0)
	local var_8_0 = lc.createNode()

	var_8_0:setContentSize(arg_8_0:getContentSize())
	lc.addChildToCenter(arg_8_0, var_8_0)

	arg_8_0._topArea = var_8_0

	local var_8_1 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(var_8_0, var_8_1, cc.p(lc.w(arg_8_0) / 2, lc.h(arg_8_0) - lc.h(var_8_1) / 2 + 5))

	local var_8_2 = ClientView.createTTF(Str(STR.UNION_BATTLE_CHAMPION), ClientView.FontSize.S1)

	lc.addChildToPos(var_8_1, var_8_2, cc.p(lc.w(var_8_1) / 2, lc.h(var_8_1) / 2 + 5))

	local function var_8_3(arg_9_0)
		local var_9_0 = ccui.Widget:create()

		var_9_0:setContentSize(250, 236)

		local var_9_1 = lc.w(var_9_0) / 2
		local var_9_2 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM)
		local var_9_3

		if var_9_2 and var_9_2[arg_9_0] then
			var_9_3 = var_9_2[arg_9_0]._group
		end

		if var_9_3 then
			var_9_0:setTouchEnabled(true)
			var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
				if arg_10_1 == ccui.TouchEventType.ended then
					require("GroupInfoForm").create(var_9_3):show()
				end
			end)
		end

		local var_9_4 = cc.ShaderSprite:createWithFramename("img_stage_gold")

		lc.addChildToPos(var_9_0, var_9_4, cc.p(var_9_1, lc.h(var_9_4) / 2))

		local var_9_5 = cc.ShaderSprite:createWithFramename("img_stage_gold_light")

		var_9_5:setScale(2)
		lc.addChildToPos(var_9_4, var_9_5, cc.p(lc.w(var_9_4) / 2, lc.h(var_9_4) + 40))

		local var_9_6 = require("GroupWidget")
		local var_9_7 = ClientView.createGroupAvatar(var_9_3 and var_9_3._avatar or 1)

		lc.addChildToPos(var_9_0, var_9_7, cc.p(var_9_1, lc.h(var_9_0) - lc.h(var_9_7) / 2))

		var_9_0._avatar = var_9_7

		local var_9_8 = 0

		if var_9_3 then
			for iter_9_0, iter_9_1 in ipairs(var_9_3:getMembers()) do
				var_9_8 = var_9_8 + math.max(500, iter_9_1._massWarScore)
			end
		end

		local var_9_9 = ClientView.createIconLabelArea("img_icon_res15_s", var_9_8, 150)

		var_9_9._valBg:setScale(0.84)
		var_9_9._icon:setScale(0.84)
		lc.offset(var_9_9._icon, 10)
		lc.offset(var_9_9._label, -10)
		lc.addChildToPos(var_9_0, var_9_9, cc.p(var_9_1, 85))

		var_9_0._trophy = var_9_9._label

		local var_9_10 = ClientView.createTTF(var_9_3 and var_9_3._name or string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.GROUP)), ClientView.FontSize.S2)

		lc.addChildToPos(var_9_0, var_9_10, cc.p(var_9_1, 24))

		var_9_0._name = var_9_10

		if arg_9_0 == 1 then
			-- block empty
		else
			var_9_4:setScaleY(0.9)
			lc.offset(var_9_7, 0, -4)
			lc.offset(var_9_10, 0, 4)

			if arg_9_0 == 2 then
				var_9_4:setEffect(ClientView.SHADER_COLOR_STAGE_SILVER)
				var_9_5:setEffect(ClientView.SHADER_COLOR_STAGE_SILVER)
			elseif arg_9_0 == 3 then
				var_9_4:setEffect(ClientView.SHADER_COLOR_STAGE_BRONZE)
				var_9_5:setEffect(ClientView.SHADER_COLOR_STAGE_BRONZE)
			end
		end

		return var_9_0
	end

	local var_8_4 = var_8_3(1)

	lc.addChildToPos(var_8_0, var_8_4, cc.p(lc.w(arg_8_0) / 2, lc.bottom(var_8_1) + 8 - lc.h(var_8_4) / 2), 1)

	local var_8_5 = var_8_3(2)

	lc.addChildToPos(var_8_0, var_8_5, cc.p(math.max(lc.left(var_8_4) - 30 - lc.w(var_8_5), 0) + lc.w(var_8_5) / 2, lc.y(var_8_4)))

	local var_8_6 = var_8_3(3)

	lc.addChildToPos(var_8_0, var_8_6, cc.p(math.min(lc.right(var_8_4) + 30 + lc.w(var_8_5), lc.w(arg_8_0)) - lc.w(var_8_6) / 2, lc.y(var_8_4)))

	var_8_0._stages = {
		var_8_4,
		var_8_5,
		var_8_6
	}
end

function var_0_0.enterDefultArea(arg_11_0)
	if arg_11_0._areaType and arg_11_0._areaType == var_0_0.AreaType.default then
		arg_11_0._areaNode:update()

		return
	else
		arg_11_0._areaType = var_0_0.AreaType.default
	end

	arg_11_0._areaType = var_0_0.AreaType.default

	arg_11_0._topArea:setVisible(true)

	local var_11_0 = arg_11_0._areaNode

	var_11_0:removeAllChildren()

	local var_11_1 = lc.createNode()

	lc.addChildToPos(var_11_0, var_11_1, cc.p(lc.cw(var_11_0), lc.h(var_11_0) - var_0_1 - 70))

	local var_11_2 = lc.createSpriteWithMask("res/jpg/my_group_bg.jpg")

	var_11_2:setScale(lc.w(var_11_0) / lc.w(var_11_2), 130 / lc.h(var_11_2))
	var_11_2:setPositionY(-5)
	var_11_1:addChild(var_11_2)

	local var_11_3, var_11_4 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP)

	if var_11_3 and #var_11_3 > 0 then
		var_11_4 = var_11_3[1]._user
	end

	local var_11_5 = lc.createNode()
	local var_11_6 = lc.createSprite("img_medal_mvp")
	local var_11_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.LAST_SEASON))

	var_11_5:setContentSize(cc.size(lc.w(var_11_6), lc.h(var_11_6) + 40))
	lc.addChildToPos(var_11_5, var_11_6, cc.p(lc.cw(var_11_5), lc.ch(var_11_6)))
	lc.addChildToPos(var_11_5, var_11_7, cc.p(lc.cw(var_11_5), lc.top(var_11_6) + lc.ch(var_11_7) + 10))

	local var_11_8 = UserWidget.create(var_11_4, var_11_4 and bor(UserWidget.Flag.NAME_UNION) or 0, 1)

	if var_11_4 then
		var_11_8._unionArea._name:setColor(ClientView.COLOR_TEXT_WHITE)
	end

	lc.addNodesToCenter(var_11_1, {
		var_11_5,
		var_11_8
	}, 10)

	local var_11_9 = "create_group"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_11_9 .. "_2")) then
		var_11_9 = var_11_9 .. "_2"
	end

	lc.TextureCache:addImageWithMask(lc.formatJpg(var_11_9))

	local var_11_10 = ClientView.createShaderButton(lc.formatJpg(var_11_9), function(arg_12_0)
		if not P._playerUnion:getMyUnion() then
			return ToastManager.push(Str(STR.NOT_JOIN_ANY_UNION))
		end

		require("CreateGroupForm").create():show()
	end)

	lc.addChildToPos(var_11_0, var_11_10, cc.p(lc.cw(arg_11_0) - 200, lc.ch(var_11_10) + 20))

	local var_11_11 = "join_group"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_11_11 .. "_2")) then
		var_11_11 = var_11_11 .. "_2"
	end

	lc.TextureCache:addImageWithMask(lc.formatJpg(var_11_11))

	local var_11_12 = ClientView.createShaderButton(lc.formatJpg(var_11_11), function(arg_13_0)
		if not P._playerUnion:getMyUnion() then
			return ToastManager.push(Str(STR.NOT_JOIN_ANY_UNION))
		end

		require("GroupForm").create():show()
	end)

	lc.addChildToPos(arg_11_0._areaNode, var_11_12, cc.p(lc.cw(arg_11_0) + 200, lc.y(var_11_10)))

	local var_11_13 = lc.createNode()

	var_11_13:setScale(0.8)

	local var_11_14 = ClientView.createShaderButton("img_btn_wheel", function()
		lc.pushScene(require("LotteryScene").create(Data.LotteryType.dark))
	end)

	lc.addChildToCenter(var_11_13, var_11_14)

	local var_11_15 = DragonBones.create("choujiang")

	lc.addChildToCenter(var_11_14, var_11_15)
	var_11_15:gotoAndPlay("effect1")
	lc.addChildToPos(var_11_0, var_11_13, cc.p(lc.w(var_11_0) - lc.cw(var_11_14) - 20, lc.y(var_11_1)))

	function var_11_0.update(arg_15_0)
		return
	end
end

function var_0_0.enterMyGroupArea(arg_16_0)
	if arg_16_0._areaType and arg_16_0._areaType == var_0_0.AreaType.my_group then
		arg_16_0._areaNode:update()

		return
	end

	arg_16_0._areaType = var_0_0.AreaType.my_group

	arg_16_0._topArea:setVisible(true)

	local var_16_0 = arg_16_0._areaNode

	var_16_0:removeAllChildren()

	local var_16_1 = arg_16_0:createMyGroupArea(var_0_3, false, true)

	lc.addChildToPos(var_16_0, var_16_1, cc.p(lc.cw(var_16_0), lc.h(var_16_0) - var_0_1 - var_0_3))

	local var_16_2 = lc.createSprite("wait_text_bg")

	var_16_2:setScale(lc.w(var_16_0) / lc.w(var_16_2), 41 / lc.h(var_16_2))
	lc.addChildToPos(var_16_0, var_16_2, cc.p(lc.cw(var_16_0), lc.bottom(var_16_1) - 20))

	local var_16_3 = lc.createNode()

	var_16_3:setScale(0.8)

	local var_16_4 = ClientView.createShaderButton("img_btn_wheel", function()
		lc.pushScene(require("LotteryScene").create(Data.LotteryType.dark))
	end)

	lc.addChildToCenter(var_16_3, var_16_4)

	local var_16_5 = DragonBones.create("choujiang")

	lc.addChildToCenter(var_16_4, var_16_5)
	var_16_5:gotoAndPlay("effect1")
	lc.addChildToPos(var_16_0, var_16_3, cc.p(lc.w(var_16_0) - lc.cw(var_16_4) - 20, lc.y(var_16_2)))

	local var_16_6 = ClientView.createTTF(P._playerFindUnionBattle:getStartTimeTip(), ClientView.FontSize.S2)

	lc.addChildToPos(var_16_0, var_16_6, cc.p(lc.cw(var_16_0), lc.bottom(var_16_1) - 20))

	local var_16_7 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_18_0)
		arg_16_0:onStartBtn()
	end, ClientView.CRECT_BUTTON, 150)

	var_16_7:addLabel(Str(STR.ENTER_GROUP_BATTLE))
	lc.addChildToPos(var_16_0, var_16_7, cc.p(lc.cw(var_16_0), 50))

	local var_16_8 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_19_0)
		arg_16_0:onExitGroup()
	end, ClientView.CRECT_BUTTON_S, 150)

	var_16_8:addLabel(Str(STR.EXIT_GROUP))
	lc.addChildToPos(var_16_0, var_16_8, cc.p(lc.cw(var_16_0) + 200, 50))

	local var_16_9 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_20_0)
		arg_16_0:onTroopBtn()
	end, ClientView.CRECT_BUTTON_S, 150)

	var_16_9:addLabel(Str(STR.MANAGE_CARDS))
	lc.addChildToPos(var_16_0, var_16_9, cc.p(lc.cw(var_16_0) - 200, 50))

	function var_16_0.update()
		var_16_1.update()
	end

	var_16_0.update()
end

function var_0_0.onStartBtn(arg_22_0)
	if P._playerFindUnionBattle:getIsValidTime() ~= 0 then
		return ToastManager.push(string.format(Str(STR.UNION_WAR_NOT_STARTED), Str(STR.FIND_UNION_BATTLE_TITLE)))
	end

	if #P._playerUnion:getMyGroup()._members ~= Data.GROUP_NUM then
		return ToastManager.push(Str(STR.CANNOT_START_UNION_BATTLE))
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendStartUnionBattle()
end

function var_0_0.createMyGroupArea(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = lc.createNode()

	var_23_0:setContentSize(cc.size(lc.w(arg_23_0, arg_23_1)))
	var_23_0:setAnchorPoint(0.5, 0.5)

	local var_23_1 = lc.createSpriteWithMask("res/jpg/my_group_bg.jpg")

	var_23_1:setScale(lc.w(var_23_0) / lc.w(var_23_1), arg_23_1 / lc.h(var_23_1))
	lc.addChildToPos(var_23_0, var_23_1, cc.p(lc.cw(var_23_0), arg_23_1 / 2))

	local var_23_2 = ClientView.createGroupAvatar(1)

	lc.addChildToPos(var_23_0, var_23_2, cc.p(lc.cw(var_23_0) - 310, lc.y(var_23_1) + 20))

	local var_23_3 = lc.createSprite("group_name_bg")

	lc.addChildToPos(var_23_0, var_23_3, cc.p(lc.x(var_23_2), lc.bottom(var_23_2) - 20))

	local var_23_4 = ClientView.createTTF("", ClientView.FontSize.S3)

	lc.addChildToCenter(var_23_3, var_23_4)

	local var_23_5 = lc.createSprite("my_split_line")

	var_23_5:setScaleY((arg_23_1 - 3) / lc.h(var_23_5))
	lc.addChildToPos(var_23_0, var_23_5, cc.p(lc.right(var_23_2) + 20, lc.y(var_23_1) + 1))

	local var_23_6 = lc.right(var_23_5) - 10
	local var_23_7 = {}
	local var_23_8 = {}

	for iter_23_0 = 1, Data.GROUP_NUM do
		local var_23_9 = ClientView.createUnionGroupMemItem(nil, var_23_7[iter_23_0], false, arg_23_2)

		var_23_9._canOperate = arg_23_3

		function var_23_9._addFunc(arg_24_0)
			arg_23_0:onInvite()
		end

		lc.addChildToPos(var_23_0, var_23_9, cc.p(var_23_6 + iter_23_0 * 120 - 30, lc.y(var_23_1)))
		table.insert(var_23_8, var_23_9)
	end

	for iter_23_1 = Data.GROUP_NUM + 1, 5 do
		local var_23_10 = lc.createSprite("group_mem_lock")

		lc.addChildToPos(var_23_0, var_23_10, cc.p(var_23_6 + iter_23_1 * 120 - 30, lc.y(var_23_1) + (arg_23_2 and 25 or 5)))
	end

	function var_23_0.update()
		local var_25_0 = P._playerUnion:getMyGroup()

		var_23_2.update(var_25_0._avatar)
		var_23_4:setString(var_25_0._name)

		local var_25_1 = var_25_0._members

		for iter_25_0 = 1, Data.GROUP_NUM do
			var_23_8[iter_25_0]:update(var_25_0._id, var_25_1[iter_25_0], false, arg_23_2)
			var_23_8[iter_25_0]._nameLabel:setColor(var_25_1[iter_25_0] and ClientView.COLOR_TEXT_WHITE or ClientView.COLOR_TEXT_BLUE)
		end
	end

	return var_23_0
end

function var_0_0.onTroopBtn(arg_26_0)
	local var_26_0 = P._playerUnion:getMyGroup()

	if not var_26_0 then
		return arg_26_0:updateView()
	end

	if #var_26_0:getMembers() < Data.GROUP_NUM then
		ToastManager.push(Str(STR.CANNOT_MANAGE_CARDS))
	else
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
		ClientData.sendGetGroupCards()
	end
end

function var_0_0.onExitGroup(arg_27_0)
	require("Dialog").showDialog(Str(STR.EXIT_GROUP_CONFIRM), function()
		if P._playerUnion:getMyGroup() then
			P._playerUnion:exitGroup()
		end
	end)
end

function var_0_0.getRanks(arg_29_0)
	if arg_29_0._areaType ~= var_0_0.AreaType.game_info and arg_29_0._rankUpdateSchedule then
		return lc.Scheduler:unscheduleScriptEntry(arg_29_0._rankUpdateSchedule)
	end

	ClientData.sendRankRequest(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP)
	ClientData.sendRankRequest(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM)
end

function var_0_0.enterGameInfoArea(arg_30_0)
	if arg_30_0._areaType and arg_30_0._areaType == var_0_0.AreaType.game_info then
		arg_30_0._areaNode:update()

		return
	end

	arg_30_0._areaType = var_0_0.AreaType.game_info

	arg_30_0._topArea:setVisible(false)

	local var_30_0 = arg_30_0._areaNode

	var_30_0:removeAllChildren()

	arg_30_0._rankUpdateSchedule = lc.Scheduler:scheduleScriptFunc(function(arg_31_0)
		arg_30_0:getRanks()
	end, 60, false)

	local var_30_1 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(var_30_0, var_30_1, cc.p(lc.w(arg_30_0) / 2, lc.h(arg_30_0) - lc.h(var_30_1) / 2 + 5))

	local var_30_2 = ClientView.createTTF(Str(STR.UNION_BATTLE_ARENA), ClientView.FontSize.S1)

	lc.addChildToPos(var_30_1, var_30_2, cc.p(lc.w(var_30_1) / 2, lc.h(var_30_1) / 2 + 5))

	local var_30_3 = ClientView.createTTF("", ClientView.FontSize.S2, ClientView.COLOR_TEXT_INGOT)

	lc.addChildToPos(var_30_0, var_30_3, cc.p(lc.cw(var_30_0), lc.bottom(var_30_1) - 15))
	var_30_3:runAction(lc.rep(lc.sequence(function()
		if P._playerFindUnionBattle:getIsValidTime() == 0 then
			var_30_3:setString(Str(STR.END_COUNTDOWN) .. "  " .. P._playerFindUnionBattle:getEndTimeTip())
		elseif P._playerFindUnionBattle:getIsValidTime() == -1 then
			var_30_3:stopAllActions()
			var_30_3:setString(Str(STR.UNION_BATTLE_ENDED))
			ToastManager.push(Str(STR.UNION_BATTLE_ENDED))

			P._playerUnion:getMyGroup()._gameStarted = false

			P._playerRank:clearPreRank(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP)
			P._playerRank:clearPreRank(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM)
			arg_30_0._topArea:removeFromParent()

			arg_30_0._topArea = nil

			arg_30_0:updateView()
		elseif P._playerFindUnionBattle:getIsValidTime() == 1 then
			var_30_3:setString(P._playerFindUnionBattle:getStartTimeTip())
		end
	end, lc.delay(1))))

	local var_30_4 = arg_30_0:createMyGroupArea(var_0_3 - 80, true)

	lc.addChildToPos(var_30_0, var_30_4, cc.p(lc.cw(var_30_0), lc.h(var_30_0) - var_0_3 - 10))
	var_30_4.update()

	local var_30_5 = lc.createSprite("rank_bg")

	var_30_5:setScaleX(lc.w(var_30_0) / lc.w(var_30_5))
	lc.addChildToPos(var_30_0, var_30_5, cc.p(lc.cw(var_30_0), lc.bottom(var_30_4) - lc.ch(var_30_5)))

	local var_30_6 = ClientView.createTTF(Str(STR.GROUP_RANK), ClientView.FontSize.S3)

	lc.addChildToPos(var_30_0, var_30_6, cc.p(lc.cw(var_30_0) - 200, lc.y(var_30_5)))

	local var_30_7 = ClientView.createTTF(Str(STR.MVP_RANK), ClientView.FontSize.S3)

	lc.addChildToPos(var_30_0, var_30_7, cc.p(lc.cw(var_30_0) + 200, lc.y(var_30_5)))
	arg_30_0:addRankLists(lc.bottom(var_30_5))

	local var_30_8 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_33_0)
		if P._playerFindUnionBattle:getIsValidTime() ~= 0 then
			return ToastManager.push(Str(STR.UNION_WAR_NOT_STARTED))
		end

		arg_30_0:find()
	end, ClientView.CRECT_BUTTON, 150)

	var_30_8:addLabel(Str(STR.SEEK_OPPONENT))
	lc.addChildToPos(var_30_0, var_30_8, cc.p(lc.cw(var_30_0), 50))
	P._playerRank:sendRankRequest(SglMsgType_pb.PB_TYPE_RANK_TROPHY)
	arg_30_0:getRanks()

	function var_30_0.update(arg_34_0)
		var_30_4.update()
	end
end

function var_0_0.find(arg_35_0)
	if ClientView._findMatchPanel then
		return
	end

	require("FindMatchPanel").create(Data.FindMatchType.union_battle):show()
end

function var_0_0.addRankLists(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._areaNode
	local var_36_1 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP)
	local var_36_2 = var_36_1 and var_36_1._selfRank

	if not var_36_2 then
		var_36_2 = {
			_user = P,
			_value = P._playerUnion._battleTrophy
		}
		var_36_2._rank = 0
	end

	local var_36_3 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM)
	local var_36_4 = groupranks and var_36_3._selfRank

	if not var_36_4 then
		var_36_4 = {}

		local var_36_5 = P._playerUnion:getMyGroup()

		var_36_4._group = var_36_5

		local var_36_6 = 0

		for iter_36_0, iter_36_1 in ipairs(var_36_5:getMembers()) do
			var_36_6 = var_36_6 + math.max(500, iter_36_1._massWarScore)
		end

		var_36_4._value = var_36_6
		var_36_4._rank = 0
	end

	local var_36_7 = arg_36_0:setOrCreateItem(nil, var_36_2, SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP)

	var_36_7._item._bar:setVisible(false)
	var_36_7._item:setSpriteFrame("img_com_bg_4")
	lc.addChildToPos(var_36_0, var_36_7, cc.p(lc.cw(var_36_0) + 203, arg_36_1 - var_0_5 / 2))

	arg_36_0._myMvpRankItem = var_36_7

	local var_36_8 = arg_36_0:setOrCreateItem(nil, var_36_4, SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM)

	var_36_8._item._bar:setVisible(false)
	lc.addChildToPos(var_36_0, var_36_8, cc.p(lc.cw(var_36_0) - 195, arg_36_1 - var_0_5 / 2))

	arg_36_0._myGroupRankItem = var_36_8
	arg_36_1 = arg_36_1 - var_0_5

	local var_36_9 = lc.List.createV(cc.size(var_0_4, arg_36_1 - 100), 6, 0)

	var_36_9:setAnchorPoint(0.5, 0.5)

	var_36_9._rankType = SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM

	lc.addChildToPos(var_36_0, var_36_9, cc.p(lc.cw(var_36_0) - 195, arg_36_1 - lc.ch(var_36_9)))

	arg_36_0._groupList = var_36_9

	local var_36_10 = lc.List.createV(cc.size(var_0_4, arg_36_1 - 100), 6, 0)

	var_36_10:setAnchorPoint(0.5, 0.5)

	var_36_10._rankType = SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP

	lc.addChildToPos(var_36_0, var_36_10, cc.p(lc.cw(var_36_0) + 203, arg_36_1 - lc.ch(var_36_10)))

	arg_36_0._mvpList = var_36_10
end

function var_0_0.refreshMVPRankList(arg_37_0)
	local var_37_0 = arg_37_0._mvpList
	local var_37_1 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP)

	if var_37_1 == nil then
		return
	end

	local var_37_2 = var_37_1._selfRank

	if var_37_2 then
		arg_37_0._myMvpRankItem.update(var_37_2, SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP)
		arg_37_0._myMvpRankItem._item:setSpriteFrame("img_com_bg_4")
	end

	var_37_0:bindData(var_37_1, function(arg_38_0, arg_38_1)
		arg_37_0:setOrCreateItem(arg_38_0, arg_38_1, SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP)
	end, math.min(4, var_37_1._count))

	for iter_37_0 = 1, var_37_0._cacheCount do
		local var_37_3 = var_37_1[iter_37_0]
		local var_37_4 = arg_37_0:setOrCreateItem(nil, var_37_3, SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP)

		var_37_0:pushBackCustomItem(var_37_4)
	end

	var_37_0:checkEmpty(Str(STR.LIST_EMPTY_RANK_MVP))
	var_37_0:refreshView()
	var_37_0:gotoTop()
end

function var_0_0.refreshGroupRankList(arg_39_0)
	local var_39_0 = arg_39_0._groupList
	local var_39_1 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM)

	if var_39_1 == nil then
		return
	end

	local var_39_2 = var_39_1._selfRank

	if var_39_2 then
		arg_39_0._myGroupRankItem.update(var_39_2, SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM)
	end

	var_39_0:bindData(var_39_1, function(arg_40_0, arg_40_1)
		arg_39_0:setOrCreateItem(arg_40_0, arg_40_1, SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM)
	end, math.min(4, var_39_1._count or 0))

	for iter_39_0 = 1, var_39_0._cacheCount do
		local var_39_3 = var_39_1[iter_39_0]
		local var_39_4 = arg_39_0:setOrCreateItem(nil, var_39_3, SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM)

		var_39_0:pushBackCustomItem(var_39_4)
	end

	var_39_0:checkEmpty(Str(STR.LIST_EMPTY_RANK_GROUP))
	var_39_0:refreshView()
	var_39_0:gotoTop()
end

function var_0_0.setOrCreateItem(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = arg_41_0._range

	if arg_41_1 == nil then
		arg_41_1 = ccui.Widget:create()

		arg_41_1:setContentSize(cc.size(var_0_4, var_0_5))

		local var_41_1 = lc.createImageView({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35
		})

		var_41_1:setContentSize(var_0_4 * 108 / lc.h(arg_41_1), var_41_0 == Data.RankRange.lord and var_41_0 == Data.RankRange.region and 108 or 108)
		var_41_1:setScale(lc.h(arg_41_1) / 108)
		var_41_1:setTouchEnabled(true)
		var_41_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
		lc.addChildToCenter(arg_41_1, var_41_1)

		arg_41_1._item = var_41_1

		local var_41_2 = lc.createSprite("img_bg_deco_35")
		local var_41_3 = 150 / lc.w(var_41_2)

		var_41_2:setScaleX(var_41_3)
		lc.addChildToPos(var_41_1, var_41_2, cc.p(lc.cw(var_41_2) * var_41_3, lc.ch(var_41_1) + 3))

		var_41_1._bar = var_41_2

		local var_41_4

		if arg_41_3 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP then
			local var_41_5 = UserWidget.create(nil, UserWidget.Flag.NAME_UNION, 1.2)

			var_41_5:setScale(0.7)
			lc.addChildToPos(var_41_1, var_41_5, cc.p(85 + lc.w(var_41_5) / 2 + 10, lc.h(var_41_1) / 2 + 4))

			var_41_1._avatarArea = var_41_5
			var_41_4 = arg_41_0:addValueArea(var_41_1, "img_icon_res15_s", "")
		elseif arg_41_3 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM then
			var_41_1:addTouchEventListener(function(arg_42_0, arg_42_1)
				if arg_42_1 == ccui.TouchEventType.ended then
					local var_42_0 = arg_42_0._rank._group

					if var_42_0._id ~= P._playerUnion._groupId then
						require("GroupInfoForm").create(var_42_0):show()
					end
				end
			end)

			local var_41_6 = require("GroupWidget")
			local var_41_7 = var_41_6.create(nil, bor(var_41_6.Flag.NAME, var_41_6.Flag.REGION), 0.8)

			var_41_7:setScale(0.9)
			lc.addChildToPos(var_41_1, var_41_7, cc.p(120 + lc.w(var_41_7) / 2, lc.h(var_41_1) / 2 + 5))
			var_41_7._regionLabel:setColor(ClientView.COLOR_TEXT_DARK)

			var_41_1._avatarArea = var_41_7
			var_41_4 = arg_41_0:addValueArea(var_41_1, "img_icon_res15_s", "")
		end

		if var_41_4 then
			var_41_4:setPosition(lc.w(var_41_1) - 5 - lc.cw(var_41_4), lc.y(var_41_1._avatarArea))

			var_41_1._valueArea = var_41_4
		end

		function arg_41_1.update(arg_43_0, arg_43_1)
			if arg_43_0 then
				local var_43_0 = arg_41_1._item

				var_43_0:removeChildrenByTag(var_0_6)

				var_43_0._rank = arg_43_0
				var_43_0._rankType = arg_43_1

				local var_43_1 = arg_43_0._rank

				if var_43_1 <= 3 and var_43_1 > 0 then
					local var_43_2 = string.format("img_medal_%d", var_43_1)

					if arg_43_1 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP and var_43_1 == 1 then
						var_43_2 = "img_medal_mvp"
					end

					local var_43_3 = lc.createSprite(var_43_2)

					var_43_3:setPosition(lc.w(var_43_3) / 2 + 5, lc.h(var_43_0) / 2 + 5)
					var_43_0:addChild(var_43_3, 0, var_0_6)
					var_43_0._bar:setColor(var_43_1 == 1 and cc.c3b(250, 64, 0) or var_43_1 == 2 and cc.c3b(0, 144, 250) or cc.c3b(166, 128, 136))
				elseif var_43_1 == 0 then
					local var_43_4 = ClientView.createBMFont(ClientView.BMFont.huali_32, Str(STR.NOT_IN_RANK))

					var_43_4:setPosition(50, lc.h(var_43_0) / 2 + 2)
					var_43_0:addChild(var_43_4, 0, var_0_6)
					var_43_0._bar:setColor(lc.Color3B.white)
				else
					local var_43_5 = ClientView.createBMFont(ClientView.BMFont.huali_32, tostring(var_43_1))

					var_43_5:setScale(1.5)
					var_43_5:setPosition(65, lc.h(var_43_0) / 2 + 2)
					var_43_0:addChild(var_43_5, 0, var_0_6)
					var_43_0._bar:setColor(lc.Color3B.white)
				end

				if arg_43_1 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP then
					if arg_41_0._mvpList and arg_41_0._mvpList._data and arg_41_0._mvpList._data._rankId and arg_43_0._user._id == arg_41_0._mvpList._data._rankId then
						var_43_0:setSpriteFrame("img_com_bg_4")
					else
						var_43_0:setSpriteFrame("img_com_bg_35")
					end

					var_43_0._avatarArea:setUser(arg_43_0._user, true)
					var_43_0._valueArea._label:setString(arg_43_0._value)
				elseif arg_43_1 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM then
					if arg_43_0._group._id == P._playerUnion:getMyGroup()._id then
						var_43_0:setSpriteFrame("img_com_bg_4")
					else
						var_43_0:setSpriteFrame("img_com_bg_35")
					end

					var_43_0._avatarArea:setGroup(arg_43_0._group)
					var_43_0._valueArea._label:setString(arg_43_0._value)
				end
			end
		end
	end

	arg_41_1.update(arg_41_2, arg_41_3)

	return arg_41_1
end

function var_0_0.addValueArea(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	local var_44_0 = ClientView.createIconLabelArea(arg_44_2, tostring(arg_44_3), arg_44_4 or 140)

	var_44_0:setAnchorPoint(0.5, 0.5)
	arg_44_1:addChild(var_44_0)

	return var_44_0
end

function var_0_0.onInvite(arg_45_0)
	ToastManager.push(Str(STR.WAIT_MEMBER))
end

function var_0_0.onEnter(arg_46_0)
	P._playerRank:clearPreRank(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP)
	P._playerRank:clearPreRank(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM)
	arg_46_0:updateView()
end

function var_0_0.isDataReady(arg_47_0)
	return (not P._playerUnion._groupId or not not P._playerUnion:getMyGroup()) and P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP) and P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM)
end

function var_0_0.updateView(arg_48_0)
	if P._playerUnion._groupId and not P._playerUnion:getMyGroup() then
		if not arg_48_0._indicator then
			arg_48_0._indicator = ClientView.showPanelActiveIndicator(arg_48_0)
		end

		ClientData.sendGetGroups()
	end

	if not P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP) or not P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM) then
		if not arg_48_0._indicator then
			arg_48_0._indicator = ClientView.showPanelActiveIndicator(arg_48_0)
		end

		ClientData.sendGetPreRanks()
	end

	if not arg_48_0:isDataReady() then
		return
	end

	if not arg_48_0._topArea then
		arg_48_0:initTopArea()
	end

	if P._playerUnion:getMyGroup() and P._playerUnion:getMyGroup()._gameStarted and P._playerFindUnionBattle:getIsValidTime() then
		arg_48_0:enterGameInfoArea()
	elseif P._playerUnion:getMyGroup() then
		arg_48_0:enterMyGroupArea()
	else
		arg_48_0:enterDefultArea()
	end
end

function var_0_0.onExit(arg_49_0)
	ClientData.removeMsgListener(arg_49_0)
end

function var_0_0.onMsg(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_1.type

	return false
end

function var_0_0.onCleanup(arg_51_0)
	lc.TextureCache:removeTextureForKey("res/jpg/union_battle_bg.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/create_group.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/join_group.jpg")

	for iter_51_0 = 1, #arg_51_0._listeners do
		lc.Dispatcher:removeEventListener(arg_51_0._listeners[iter_51_0])
	end

	if arg_51_0._areaType == var_0_0.AreaType.game_info then
		-- block empty
	end

	if arg_51_0._rankUpdateSchedule then
		lc.Scheduler:unscheduleScriptEntry(arg_51_0._rankUpdateSchedule)

		arg_51_0._rankUpdateSchedule = nil
	end
end

return var_0_0
