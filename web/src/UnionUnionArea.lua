local var_0_0 = class("UnionUnionArea", lc.ExtendCCNode)
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

	arg_3_0:initTopArea()

	local var_3_0 = lc.List.createV(cc.size(lc.w(arg_3_0) - 12, lc.bottom(arg_3_0._topArea) + 8), 6, 0)

	lc.addChildToPos(arg_3_0, var_3_0, cc.p(10, 0))

	arg_3_0._memList = var_3_0
end

function var_0_0.initTopArea(arg_4_0)
	local var_4_0 = arg_4_0._unionId == P._unionId
	local var_4_1 = lc.createSprite({
		_name = "img_com_bg_4",
		_crect = ClientView.CRECT_COM_BG4,
		_size = cc.size(lc.w(arg_4_0) - 12, 220)
	})

	lc.addChildToPos(arg_4_0, var_4_1, cc.p(lc.w(arg_4_0) / 2 + 4, lc.h(arg_4_0) - lc.h(var_4_1) / 2 - 8), 1)

	arg_4_0._topArea = var_4_1

	local var_4_2 = P._playerUnion:getMyUnion()

	if var_4_2 then
		local var_4_3 = lc.createSprite({
			_name = "img_txt_bottom",
			_crect = cc.rect(21, 0, 1, 30),
			_size = cc.size(lc.w(var_4_1) - 20, 30)
		})

		lc.addChildToPos(var_4_1, var_4_3, cc.p(lc.cw(var_4_1), lc.ch(var_4_3) + 15))

		local var_4_4 = ClientView.createTTF(Str(STR.ALL_BATTLE_EXP))

		var_4_4:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_4_3, var_4_4, cc.p(10, lc.ch(var_4_3)))

		local var_4_5 = ClientView.createTTF("+" .. var_4_2._gold, nil, ClientView.COLOR_TEXT_GREEN_2)

		var_4_5:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_4_3, var_4_5, cc.p(lc.right(var_4_4), lc.ch(var_4_3)))
	end

	local var_4_6
	local var_4_7

	if lc.w(var_4_1) == var_0_1 then
		var_4_6, var_4_7 = -10, -18
	else
		var_4_6, var_4_7 = -30, -10
	end

	local var_4_8 = lc.createSprite("img_glow")

	var_4_8:setScale(0.8)
	lc.addChildToPos(var_4_1, var_4_8, cc.p(math.floor(lc.sw(var_4_8) / 2) + var_4_6, lc.h(var_4_1) / 2 + 20))

	local var_4_9 = ClientView.createBadge(1, "")

	var_4_9:setScale(0.7)
	lc.addChildToPos(var_4_1, var_4_9, cc.p(var_4_8:getPosition()), 1)

	arg_4_0._badge = var_4_9

	local var_4_10 = ClientView.createLevelNameArea(1, "")

	lc.addChildToPos(var_4_1, var_4_10, cc.p(math.floor(lc.right(var_4_9)) - 2, lc.y(var_4_9) + lc.h(var_4_10) / 2 - 14))

	arg_4_0._nameArea = var_4_10

	local var_4_11 = lc.left(var_4_10) + 40

	arg_4_0._id = ClientView.addIconValue(var_4_1, "img_icon_id", 0, var_4_11, lc.y(var_4_9) - 10)

	arg_4_0._id:setColor(ClientView.COLOR_TEXT_DARK)

	arg_4_0._member = ClientView.addIconValue(var_4_1, "img_icon_troop", 0, var_4_0 and var_4_11 + 150 or var_4_11, var_4_0 and lc.y(var_4_9) - 10 or lc.bottom(arg_4_0._id) - 35)

	arg_4_0._member:setColor(ClientView.COLOR_TEXT_DARK)

	local var_4_12 = lc.createSprite({
		_name = "img_com_bg_10",
		_crect = ClientView.CRECT_COM_BG10,
		_size = cc.size(454, 190)
	})

	var_4_12:setScale(0.75)
	lc.addChildToPos(var_4_1, var_4_12, cc.p(lc.w(var_4_1) + var_4_7 - math.floor(lc.sw(var_4_12) / 2), lc.h(var_4_1) / 2 + 22))

	local var_4_13 = ClientView.createTTF(Str(STR.UNION_SUMMARY), ClientView.FontSize.S2, ClientView.COLOR_TEXT_INGOT, cc.size(340, 0), cc.TEXT_ALIGNMENT_CENTER)

	var_4_13:setAnchorPoint(0.5, 1)

	local var_4_14 = lc.createSprite("icon_mask")

	var_4_14:setCascadeOpacityEnabled(true)
	var_4_14:setScale(330 / lc.w(var_4_14), 40 / lc.h(var_4_13))
	var_4_14:setAnchorPoint(0.5, 1)
	lc.addChildToPos(var_4_1, var_4_14, cc.p(math.floor(lc.left(var_4_12) + lc.cw(var_4_13)), lc.top(var_4_12) - 5))
	lc.addChildToPos(var_4_1, var_4_13, cc.p(math.floor(lc.left(var_4_12) + lc.cw(var_4_13)), lc.top(var_4_12) - 10))

	local var_4_15 = ClientView.createTTF("", ClientView.FontSize.S2, nil, cc.size(300, 0), cc.TEXT_ALIGNMENT_LEFT)

	var_4_15:setAnchorPoint(0, 1)
	var_4_15:setLineBreakWithoutSpace(true)
	lc.addChildToPos(var_4_1, var_4_15, cc.p(math.floor(lc.left(var_4_12) + 20), lc.bottom(var_4_13) - 10))

	arg_4_0._desc = var_4_15

	if var_4_0 then
		local var_4_16 = ClientView.createShaderButton(nil, function(arg_5_0)
			require("DescForm").create({
				_infoId = Data.ResType.union_act
			}):show()
		end)

		var_4_16:setContentSize(cc.size(220, 50))
		lc.addChildToPos(var_4_1, var_4_16, cc.p(var_4_11 + 110, lc.bottom(arg_4_0._member) - 35))

		arg_4_0._expBar = ClientView.addUnionPersonalPowerBar(var_4_16, Data.ResType.union_act, 0, 50, 220)
	end
end

function var_0_0.popSelectPanel(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = require("TopMostPanel").ButtonList.create(cc.size(200, lc.h(arg_6_0)))

	if var_6_0 then
		local var_6_1 = lc.convertPos(cc.p(lc.w(arg_6_1) / 2, lc.h(arg_6_1) / 2), arg_6_1)

		var_6_0:setButtonDefs(arg_6_2)
		var_6_0:setPosition(var_6_1.x, var_6_1.y - lc.h(var_6_0) / 2 - 24)
		var_6_0:linkNode(arg_6_1)
		var_6_0:show()
	end
end

function var_0_0.updateView(arg_7_0, arg_7_1)
	arg_7_0._badge:update(arg_7_1._badge, arg_7_1._word)

	local var_7_0 = arg_7_0._nameArea

	var_7_0._level:setString(tostring(arg_7_1._level))
	var_7_0:setName(arg_7_1._name)
	arg_7_0._id:setString(ClientData.convertId(arg_7_1._id))
	arg_7_0._member:setString(string.format("%d/%d", arg_7_1:getMembersNum(), arg_7_1._memberCapacity))

	if arg_7_1._announce and arg_7_1._announce ~= "" then
		arg_7_0._desc:setString(arg_7_1._announce)
		arg_7_0._desc:setColor(ClientView.COLOR_TEXT_LIGHT)
	else
		arg_7_0._desc:setString(Str(STR.UNION_SUMMARY))
		arg_7_0._desc:setColor(ClientView.COLOR_TEXT_GRAY)
	end

	arg_7_0:updateMemberList(arg_7_1:getMembers())

	if arg_7_0._unionId == P._unionId then
		local var_7_1 = arg_7_1._act
		local var_7_2, var_7_3 = P._playerUnion:getUnionUpgradeExp()

		if not var_7_2 then
			arg_7_0._expBar.update(var_7_1, var_7_1 + var_7_3)
		else
			arg_7_0._expBar._label:setString(Str(STR.UNION_LEVEL_MAX))
		end
	end
end

function var_0_0.updateMemberList(arg_8_0, arg_8_1)
	table.sort(arg_8_1, function(arg_9_0, arg_9_1)
		if arg_9_0._unionJob == arg_9_1._unionJob then
			if arg_9_0._level == arg_9_1._level then
				return arg_9_0._lastLogin > arg_9_1._lastLogin
			end

			return arg_9_0._level > arg_9_1._level
		end

		return arg_9_0._unionJob > arg_9_1._unionJob
	end)

	local var_8_0 = arg_8_0._memList

	var_8_0:bindData(arg_8_1, function(arg_10_0, arg_10_1)
		arg_8_0:setOrCreateMemberItem(arg_10_0, arg_10_1)
	end, math.min(6, #arg_8_1))

	for iter_8_0 = 1, var_8_0._cacheCount do
		local var_8_1 = arg_8_0:setOrCreateMemberItem(nil, arg_8_1[iter_8_0])

		var_8_0:pushBackCustomItem(var_8_1)
	end
end

function var_0_0.setOrCreateMemberItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._unionId == P._unionId

	if arg_11_1 == nil then
		arg_11_1 = ClientView.createUnionMemberItem(arg_11_2, lc.w(arg_11_0._memList), true)

		arg_11_1._badgeIcon:setVisible(true)
		arg_11_1._badgeTxt:setVisible(true)
		arg_11_1._expDonateTxt:setVisible(true)

		if not var_11_0 and not P:isUserAdmin() then
			arg_11_1._lastLogin:setVisible(false)
			arg_11_1._lastLogin._value:setVisible(false)
		end
	end

	arg_11_1:update(arg_11_2)

	if var_11_0 and arg_11_1._btn then
		arg_11_1._btn:removeFromParent()

		arg_11_1._btn = nil
	end

	return arg_11_1
end

function var_0_0.onEnter(arg_12_0)
	arg_12_0._listeners = {}

	table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.user_dirty, function(arg_13_0)
		local var_13_0 = arg_12_0._memList:getItems()

		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			if iter_13_1._member == arg_13_0._data then
				arg_12_0:setOrCreateMemberItem(iter_13_1, arg_13_0._data)

				break
			end
		end
	end))

	local function var_12_0()
		arg_12_0:updateView(P._playerUnion:getMyUnion())
	end

	table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.union_dirty, var_12_0))
	table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.union_edit_dirty, var_12_0))
	table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.union_member_dirty, var_12_0))
	table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.union_level_upgrade, var_12_0))
	table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.union_res_dirty, var_12_0))
	ClientData.addMsgListener(arg_12_0, function(arg_15_0)
		return arg_12_0:onMsg(arg_15_0)
	end, 0)

	if P._unionId == arg_12_0._unionId then
		local var_12_1 = P._playerUnion:getMyUnion()

		if var_12_1 then
			arg_12_0:updateView(var_12_1)
		end
	else
		arg_12_0._indicator = ClientView.showPanelActiveIndicator(arg_12_0)

		arg_12_0._topArea:setVisible(false)
		performWithDelay(arg_12_0, function()
			ClientData.sendGetUnionDetail(arg_12_0._unionId)
		end, BaseForm.ACTION_DURATION)
	end
end

function var_0_0.onExit(arg_17_0)
	for iter_17_0 = 1, #arg_17_0._listeners do
		lc.Dispatcher:removeEventListener(arg_17_0._listeners[iter_17_0])
	end

	ClientData.removeMsgListener(arg_17_0)
end

function var_0_0.onMsg(arg_18_0, arg_18_1)
	if arg_18_1.type == SglMsgType_pb.PB_TYPE_UNION_DETAIL then
		local var_18_0 = arg_18_1.Extensions[Union_pb.SglUnionMsg.union_detail_resp]

		if var_18_0.union_info.id == arg_18_0._unionId then
			local var_18_1 = require("Union").create(var_18_0.union_info, var_18_0.member_info)

			if arg_18_0._indicator then
				arg_18_0._indicator:removeFromParent()

				arg_18_0._indicator = nil
			end

			if var_18_1 then
				arg_18_0:updateView(var_18_1)
				arg_18_0._topArea:setVisible(true)
			elseif arg_18_0._callback then
				arg_18_0._callback()
			end
		end
	end

	return false
end

return var_0_0
