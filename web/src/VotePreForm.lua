local var_0_0 = class("VotePreForm", BaseForm)
local var_0_1 = cc.size(700, 640)
local var_0_2 = 180

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(logType, focusTab)

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.VOTE_PRE), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 32, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 32, 10)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0._form, var_2_0)
	lc.offset(var_2_0, 4, 0)

	arg_2_0._list = var_2_0

	arg_2_0:refreshList()
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)
end

function var_0_0.onExit(arg_4_0)
	var_0_0.super.onExit(arg_4_0)
end

function var_0_0.refreshList(arg_5_0)
	if arg_5_0._indicator then
		arg_5_0._indicator:removeFromParent()

		arg_5_0._indicator = nil
	end

	local var_5_0 = Data._voteRankInfo

	if var_5_0 == nil then
		return
	end

	local var_5_1 = arg_5_0._list

	var_5_1:bindData(var_5_0, function(arg_6_0, arg_6_1)
		arg_5_0:setOrCreateItem(arg_6_0, arg_6_1)
	end, math.min(7, #var_5_0))

	for iter_5_0 = 1, var_5_1._cacheCount do
		local var_5_2 = var_5_0[iter_5_0]
		local var_5_3 = arg_5_0:setOrCreateItem(nil, var_5_2)

		var_5_1:pushBackCustomItem(var_5_3)
	end

	var_5_1:refreshView()
	var_5_1:gotoTop()
end

function var_0_0.setOrCreateItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == nil then
		arg_7_1 = lc.createImageView({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35
		})

		arg_7_1:setContentSize(cc.size(lc.w(arg_7_0._list), 108))
		arg_7_1:setTouchEnabled(true)
		arg_7_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

		local var_7_0 = lc.createSprite("img_bg_deco_35")

		lc.addChildToPos(arg_7_1, var_7_0, cc.p(lc.cw(var_7_0), lc.ch(arg_7_1) + 3))

		arg_7_1._bar = var_7_0

		local var_7_1 = ClientView.createTTF("", ClientView.FontSize.M1)

		var_7_1:enableOutline(lc.Color3B.black, 2)
		lc.addChildToPos(arg_7_1, var_7_1, cc.p(64, lc.h(arg_7_1) / 2 + 2))

		arg_7_1._icons = {}

		function arg_7_1.update(arg_8_0)
			if arg_8_0 then
				arg_7_1._info = arg_8_0

				local var_8_0 = arg_8_0._id

				var_7_1:setString(string.format(Str(STR.STAGE_NO), var_8_0))

				for iter_8_0, iter_8_1 in ipairs(arg_7_1._icons) do
					iter_8_1:removeFromParent()
				end

				table.clear(arg_7_1._icons)

				for iter_8_2, iter_8_3 in ipairs(arg_8_0._rank) do
					local var_8_1 = IconWidget.createByInfoId(iter_8_3, nil, IconWidget.DisplayFlag.ITEM_NO_NAME)

					var_8_1:setScale(0.9)

					arg_7_1._icons[#arg_7_1._icons + 1] = var_8_1
				end

				lc.addNodesToCenter(arg_7_1, arg_7_1._icons, 10, nil, nil, nil, lc.cw(var_7_0) + lc.cw(arg_7_1))
			end
		end
	end

	arg_7_1.update(arg_7_2)

	return arg_7_1
end

function var_0_0.parseListData(arg_9_0, arg_9_1)
	arg_9_0._data = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = require("User").create(iter_9_1.user_info)

		table.insert(arg_9_0._data, {
			_period = iter_9_1.period,
			_user = var_9_0
		})
	end

	table.sort(arg_9_0._data, function(arg_10_0, arg_10_1)
		return arg_10_0._period > arg_10_1._period
	end)
end

function var_0_0.onMsg(arg_11_0, arg_11_1)
	if arg_11_1.type == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_OPENED then
		local var_11_0 = arg_11_1.Extensions[World_pb.SglWorldMsg.lottery_open_list_resp]

		arg_11_0:parseListData(var_11_0)
		arg_11_0:refreshList()

		return true
	end

	return false
end

return var_0_0
