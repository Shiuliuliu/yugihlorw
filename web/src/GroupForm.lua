local var_0_0 = class("GroupForm", BaseForm)
local var_0_1 = cc.size(960, 700)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.JOIN_GROUP), bor(var_0_0.FLAG.ADVANCE_TITLE_BG, var_0_0.FLAG.SCROLL_V))

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._form) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 12, lc.bottom(arg_2_0._titleFrame)), 20, 0)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0._frame, var_2_0, cc.p(lc.cw(arg_2_0._form), lc.ch(arg_2_0._form)), -1)

	arg_2_0._groupList = var_2_0
	arg_2_0._indicator = ClientView.showPanelActiveIndicator(arg_2_0._form)

	ClientData.sendGetGroups()
end

function var_0_0.updateView(arg_3_0)
	local var_3_0 = P._playerUnion:getGroups()

	arg_3_0:updateGroupList(var_3_0)
end

function var_0_0.updateGroupList(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._groupList

	var_4_0:removeAllItems()

	if not arg_4_1 then
		return
	end

	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		table.insert(var_4_1, iter_4_1)
	end

	var_4_0:bindData(var_4_1, function(arg_5_0, arg_5_1)
		arg_4_0:setOrCreateGroupItem(arg_5_0, arg_5_1)
	end, math.min(#var_4_1, 6))

	for iter_4_2 = 1, #var_4_1 do
		local var_4_2 = arg_4_0:setOrCreateGroupItem(nil, var_4_1[iter_4_2])

		var_4_0:pushBackCustomItem(var_4_2)
	end

	var_4_0:checkEmpty(Str(STR.LIST_EMPTY_GROUP))
end

function var_0_0.setOrCreateGroupItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 == nil then
		arg_6_1 = ccui.Widget:create()

		arg_6_1:setContentSize(lc.w(arg_6_0._groupList) - 20, 180)

		arg_6_3 = arg_6_3 or true

		local var_6_0 = lc.createSprite({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35,
			_size = arg_6_1:getContentSize()
		})

		lc.addChildToCenter(arg_6_1, var_6_0, -1)

		arg_6_1._bg = var_6_0

		local var_6_1 = lc.createSprite("img_bg_deco_29")

		var_6_1:setPosition(cc.p(lc.w(var_6_0) - lc.cw(var_6_1) / 2 - 60, lc.h(var_6_0) / 2))
		var_6_1:setScale(lc.h(var_6_0) / lc.h(var_6_1))
		var_6_0:addChild(var_6_1)

		local var_6_2 = ClientView.createGroupAvatar(1)

		var_6_2:setScale(0.9)
		lc.addChildToPos(arg_6_1, var_6_2, cc.p(lc.cw(var_6_2) + 20, lc.ch(arg_6_1) + 25))

		local var_6_3 = lc.createSprite("group_name_bg")

		lc.addChildToPos(arg_6_1, var_6_3, cc.p(lc.x(var_6_2), lc.bottom(var_6_2) - 20))

		local var_6_4 = ClientView.createTTF("", ClientView.FontSize.S3)

		lc.addChildToCenter(var_6_3, var_6_4)

		local var_6_5 = lc.createSprite("my_split_line")

		var_6_5:setScaleY((lc.h(arg_6_1) - 15) / lc.h(var_6_5))
		lc.addChildToPos(arg_6_1, var_6_5, cc.p(lc.right(var_6_2) + 30, lc.ch(arg_6_1) + 6))

		local var_6_6 = lc.right(var_6_2) + 10
		local var_6_7 = {}
		local var_6_8 = {}

		for iter_6_0 = 1, Data.GROUP_NUM do
			local var_6_9 = ClientView.createUnionGroupMemItem(nil, var_6_7[iter_6_0], true, false)

			function var_6_9._addFunc(arg_7_0)
				arg_6_0:joinGroup(arg_7_0._groupId)
			end

			lc.addChildToPos(arg_6_1, var_6_9, cc.p(var_6_6 + iter_6_0 * 120 - 30, lc.ch(arg_6_1) + 10))
			table.insert(var_6_8, var_6_9)
		end

		for iter_6_1 = Data.GROUP_NUM + 1, 5 do
			local var_6_10 = lc.createSprite("group_mem_lock")

			lc.addChildToPos(arg_6_1, var_6_10, cc.p(var_6_6 + iter_6_1 * 120 - 30, lc.ch(arg_6_1) + 15))
		end

		function arg_6_1.update(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
			arg_8_0._groupId = arg_8_1._id

			var_6_2.update(arg_8_1._avatar)
			var_6_4:setString(arg_8_1._name)

			local var_8_0 = arg_8_1._members

			for iter_8_0 = 1, Data.GROUP_NUM do
				var_6_8[iter_8_0]:update(arg_8_1._id, var_8_0[iter_8_0], arg_8_2, arg_8_3)
				var_6_8[iter_8_0]._nameLabel:setColor(var_8_0[iter_8_0] and ClientView.COLOR_TEXT_DARK or ClientView.COLOR_TEXT_BLUE_DARK)
			end
		end
	end

	arg_6_1:update(arg_6_2, true, false)

	return arg_6_1
end

function var_0_0.joinGroup(arg_9_0, arg_9_1)
	P._playerUnion:joinGroup(arg_9_1)
end

function var_0_0.onEnter(arg_10_0)
	var_0_0.super.onEnter(arg_10_0)

	arg_10_0._listeners = {}

	table.insert(arg_10_0._listeners, lc.addEventListener(Data.Event.union_group_dirty, function(arg_11_0)
		if arg_10_0._indicator then
			arg_10_0._indicator:removeFromParent()

			arg_10_0._indicator = nil
		end

		if P._playerUnion:getMyGroup() then
			arg_10_0:hide()
		else
			arg_10_0:updateView()
		end
	end))
end

function var_0_0.onExit(arg_12_0)
	var_0_0.super.onExit(arg_12_0)

	for iter_12_0, iter_12_1 in pairs(arg_12_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_12_1)
	end
end

function var_0_0.onCleanup(arg_13_0)
	var_0_0.super.onCleanup(arg_13_0)
	ClientData.sendStopUpdateGroups()
	ClientData.removeMsgListener(arg_13_0)
end

return var_0_0
