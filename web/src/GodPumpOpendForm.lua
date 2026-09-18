local var_0_0 = class("GodPumpOpendForm", BaseForm)
local var_0_1 = cc.size(600, 640)
local var_0_2 = 180

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(logType, focusTab)

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.LOTTERY_OPENED), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 32, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 32, 10)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0._form, var_2_0)
	lc.offset(var_2_0, 4, 0)

	arg_2_0._list = var_2_0
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	if not arg_3_0._data then
		ClientData.sendGetLotteryOpened()

		arg_3_0._indicator = ClientView.showPanelActiveIndicator(arg_3_0._form, lc.bound(arg_3_0._list))

		lc.offset(arg_3_0._indicator, 0, 20)
	end

	ClientData.addMsgListener(arg_3_0, function(arg_4_0)
		return arg_3_0:onMsg(arg_4_0)
	end, 0)
end

function var_0_0.onExit(arg_5_0)
	var_0_0.super.onExit(arg_5_0)
	lc.Dispatcher:removeEventListener(arg_5_0._listener)
	ClientData.removeMsgListener(arg_5_0)
end

function var_0_0.refreshList(arg_6_0)
	if arg_6_0._indicator then
		arg_6_0._indicator:removeFromParent()

		arg_6_0._indicator = nil
	end

	local var_6_0 = arg_6_0._data

	if var_6_0 == nil then
		return
	end

	local var_6_1 = arg_6_0._list

	var_6_1:bindData(var_6_0, function(arg_7_0, arg_7_1)
		arg_6_0:setOrCreateItem(arg_7_0, arg_7_1)
	end, math.min(7, #var_6_0))

	for iter_6_0 = 1, var_6_1._cacheCount do
		local var_6_2 = var_6_0[iter_6_0]
		local var_6_3 = arg_6_0:setOrCreateItem(nil, var_6_2)

		var_6_1:pushBackCustomItem(var_6_3)
	end

	var_6_1:checkEmpty(Str(STR.LIST_EMPTY_NO_X))
	var_6_1:refreshView()
	var_6_1:gotoTop()
end

function var_0_0.setOrCreateItem(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == nil then
		arg_8_1 = lc.createImageView({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35
		})

		arg_8_1:setContentSize(cc.size(lc.w(arg_8_0._list), 108))
		arg_8_1:setTouchEnabled(true)
		arg_8_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

		local var_8_0 = lc.createSprite("img_bg_deco_35")

		lc.addChildToPos(arg_8_1, var_8_0, cc.p(lc.cw(var_8_0), lc.ch(arg_8_1) + 3))

		arg_8_1._bar = var_8_0

		local var_8_1 = ClientView.createBMFont(ClientView.BMFont.huali_32, "")

		lc.addChildToPos(arg_8_1, var_8_1, cc.p(64, lc.h(arg_8_1) / 2 + 2))
		arg_8_1:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 == ccui.TouchEventType.ended and arg_9_0._info and arg_8_0._list and arg_9_0._info._user._id ~= P._id then
				ClientView.operateUser(arg_9_0._info._user, arg_9_0)
				require("ClashUserInfoForm").create(arg_9_0._info._user._id):show()
			end
		end)

		local var_8_2 = UserWidget.create(nil, UserWidget.Flag.REGION_NAME_UNION, 1.2)

		var_8_2:setScale(0.7)
		lc.addChildToPos(arg_8_1, var_8_2, cc.p(150 + lc.w(var_8_2) / 2, lc.h(arg_8_1) / 2 + 4))

		arg_8_1._avatarArea = var_8_2

		function arg_8_1.update(arg_10_0)
			if arg_10_0 then
				arg_8_1._info = arg_10_0

				local var_10_0 = arg_10_0._period

				var_8_1:setString(string.format(Str(STR.ISSUE_NO), var_10_0))

				local var_10_1 = arg_8_1._avatarArea

				var_10_1:setUser(arg_10_0._user, true)
				var_10_1._regionArea:setPosition(cc.p(lc.right(var_10_1._frame), 0))
			end
		end
	end

	arg_8_1.update(arg_8_2)

	return arg_8_1
end

function var_0_0.parseListData(arg_11_0, arg_11_1)
	arg_11_0._data = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_0 = require("User").create(iter_11_1.user_info)

		table.insert(arg_11_0._data, {
			_period = iter_11_1.period,
			_user = var_11_0
		})
	end

	table.sort(arg_11_0._data, function(arg_12_0, arg_12_1)
		return arg_12_0._period > arg_12_1._period
	end)
end

function var_0_0.onMsg(arg_13_0, arg_13_1)
	if arg_13_1.type == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_OPENED then
		local var_13_0 = arg_13_1.Extensions[World_pb.SglWorldMsg.lottery_open_list_resp]

		arg_13_0:parseListData(var_13_0)
		arg_13_0:refreshList()

		return true
	end

	return false
end

return var_0_0
