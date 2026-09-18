local var_0_0 = class("GodPumpUnopendForm", BaseForm)
local var_0_1 = cc.size(600, 640)
local var_0_2 = 180

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(logType, focusTab)

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.LOTTERY_UNOPENED), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 32, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 32, 10)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0._form, var_2_0)
	lc.offset(var_2_0, 4, 0)

	arg_2_0._list = var_2_0
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	if not arg_3_0._data then
		ClientData.sendGetLotteryUnopened()

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

		local var_8_2 = ClientView.createTTF(Str(STR.PROGRESS), ClientView.FontSize.S2, ClientView.COLOR_TEXT_DARK)

		lc.addChildToPos(arg_8_1, var_8_2, cc.p(lc.cw(arg_8_1) + 40, lc.ch(arg_8_1) + 20))

		local var_8_3 = ClientView.createLabelProgressBar(180)

		lc.addChildToPos(arg_8_1, var_8_3, cc.p(lc.cw(arg_8_1) + 40, lc.ch(arg_8_1) - 20))

		local var_8_4 = ClientView.createTTF(Str(STR.PROBABILITY), ClientView.FontSize.S2, ClientView.COLOR_TEXT_DARK)

		lc.addChildToPos(arg_8_1, var_8_4, cc.p(lc.w(arg_8_1) - 70, lc.ch(arg_8_1) + 20))

		local var_8_5 = ClientView.createTTF("", ClientView.FontSize.S2, ClientView.COLOR_TEXT_DARK)

		lc.addChildToPos(arg_8_1, var_8_5, cc.p(lc.w(arg_8_1) - 70, lc.ch(arg_8_1) - 20))

		function arg_8_1.update(arg_9_0)
			if arg_9_0 then
				arg_8_1._info = arg_9_0

				local var_9_0 = arg_9_0._period

				var_8_1:setString(string.format(Str(STR.ISSUE_NO), var_9_0))
				var_8_3._bar:setPercent(arg_9_0._progress * 100 / 2500)
				var_8_3._label:setString(arg_9_0._progress .. "/" .. "2500")

				local var_9_1 = math.min(100, arg_9_0._count / 2500 * 100)

				var_8_5:setString(string.format("%.2f", var_9_1) .. "%")
				var_8_5:setColor(ClientView.getProbabilityColor(var_9_1))
			end
		end
	end

	arg_8_1.update(arg_8_2)

	return arg_8_1
end

function var_0_0.parseListData(arg_10_0, arg_10_1)
	arg_10_0._data = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		table.insert(arg_10_0._data, {
			_period = iter_10_1.period,
			_progress = iter_10_1.lottery_progress,
			_count = iter_10_1.lottery_count
		})
	end

	table.sort(arg_10_0._data, function(arg_11_0, arg_11_1)
		return arg_11_0._period > arg_11_1._period
	end)
end

function var_0_0.onMsg(arg_12_0, arg_12_1)
	if arg_12_1.type == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_UNOPEN then
		local var_12_0 = arg_12_1.Extensions[World_pb.SglWorldMsg.lottery_unopen_list_resp]

		arg_12_0:parseListData(var_12_0)
		arg_12_0:refreshList()

		return true
	end

	return false
end

return var_0_0
