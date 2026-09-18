local var_0_0 = class("SelectRegionForm", BaseForm)
local var_0_1 = cc.size(940, 600)
local var_0_2 = 10

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.REGION_TITLE), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))
	arg_2_0:initTabArea()
	arg_2_0:initList()
	arg_2_0._tabArea:focusAtPos(1)
end

function var_0_0.initTabArea(arg_3_0)
	local var_3_0 = ClientData._regionCount
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs(ClientData._regions) do
		table.insert(var_3_1, iter_3_1)
	end

	table.sort(var_3_1, function(arg_4_0, arg_4_1)
		return arg_4_0._id < arg_4_1._id
	end)

	arg_3_0._orderedRegions = var_3_1

	local var_3_2 = {}

	for iter_3_2 = 1, var_3_0, 10 do
		local var_3_3 = string.format(Str(STR.REGION_A_TO_B), iter_3_2, math.min(iter_3_2 + 9, var_3_0))

		table.insert(var_3_2, 1, {
			_str = var_3_3,
			_index = iter_3_2
		})
	end

	if #ClientData._historyRegion > 0 then
		table.insert(var_3_2, 1, {
			_index = 0,
			_str = Str(STR.REGION_HISTORY)
		})
	end

	local var_3_4 = ClientView.createVerticalTabListArea(lc.h(arg_3_0._form) - var_0_0.TOP_MARGIN - var_0_0.BOTTOM_MARGIN, var_3_2, function(arg_5_0, arg_5_1, arg_5_2)
		arg_3_0:showTab(arg_5_0._index, not arg_5_1, arg_5_2)
	end)

	lc.addChildToPos(arg_3_0._form, var_3_4, cc.p(var_0_0.LEFT_MARGIN + lc.w(var_3_4) / 2 - 12, lc.h(arg_3_0._form) / 2))

	arg_3_0._tabArea = var_3_4
end

function var_0_0.initList(arg_6_0)
	local var_6_0 = lc.w(arg_6_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN - lc.w(arg_6_0._tabArea) + 6
	local var_6_1 = lc.h(arg_6_0._tabArea) + 4
	local var_6_2 = lc.List.createV(cc.size(var_6_0, var_6_1), 20, 8)

	lc.addChildToPos(arg_6_0._form, var_6_2, cc.p(lc.right(arg_6_0._tabArea), 15))

	arg_6_0._list = var_6_2
end

function var_0_0.showTab(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_2 then
		return
	end

	arg_7_0._focusTabIndex = arg_7_1

	arg_7_0:refreshList()
end

function var_0_0.refreshList(arg_8_0)
	local var_8_0 = arg_8_0._list
	local var_8_1 = arg_8_0._focusTabIndex

	if var_8_1 == 0 then
		var_8_0:bindData(ClientData._historyRegion, function(arg_9_0, arg_9_1)
			arg_8_0:setOrCreateHistoryItem(arg_9_0, arg_9_1)
		end, math.min(10, #ClientData._historyRegion))

		for iter_8_0 = 1, var_8_0._cacheCount do
			local var_8_2 = arg_8_0:setOrCreateHistoryItem(nil, ClientData._historyRegion[iter_8_0])

			var_8_0:pushBackCustomItem(var_8_2)
		end

		var_8_0:setBounceEnabled(true)
	else
		local var_8_3 = {}

		for iter_8_1 = var_8_1, var_8_1 + 9, 2 do
			table.insert(var_8_3, {
				arg_8_0._orderedRegions[iter_8_1],
				arg_8_0._orderedRegions[iter_8_1 + 1]
			})
		end

		var_8_0:bindData(var_8_3, function(arg_10_0, arg_10_1)
			arg_8_0:setOrCreateRegionItem(arg_10_0, arg_10_1)
		end, math.min(5, #var_8_3))

		for iter_8_2 = 1, var_8_0._cacheCount do
			local var_8_4 = arg_8_0:setOrCreateRegionItem(nil, var_8_3[iter_8_2])

			var_8_0:pushBackCustomItem(var_8_4)
		end

		var_8_0:setBounceEnabled(false)
	end

	var_8_0:refreshView()
	var_8_0:jumpToTop()
end

function var_0_0.setOrCreateHistoryItem(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == nil then
		arg_11_1 = ccui.Widget:create()

		arg_11_1:setContentSize(570, 80)

		local var_11_0 = ClientView.createScale9ShaderButton("img_com_bg_2", nil, ClientView.CRECT_COM_BG2, lc.w(arg_11_1), 50)

		var_11_0:setColor(lc.Color3B.black)
		var_11_0:setOpacity(100)
		lc.addChildToPos(arg_11_1, var_11_0, cc.p(lc.w(var_11_0) / 2, lc.h(arg_11_1) / 2))

		arg_11_1._btn = var_11_0

		local var_11_1 = UserWidget.create(nil, UserWidget.Flag.LEVEL_NAME, 1)

		var_11_1:setScale(0.7)
		lc.addChildToPos(var_11_0, var_11_1, cc.p(lc.w(var_11_1) / 2 - 40, lc.h(var_11_0) / 2))

		arg_11_1._avatar = var_11_1

		var_11_1._nameArea:setPosition(lc.right(var_11_1._frame), lc.y(var_11_1._frame))

		local var_11_2 = ClientView.createTTF("", ClientView.FontSize.S1)

		var_11_2:setAnchorPoint(1, 0.5)
		lc.addChildToPos(var_11_0, var_11_2, cc.p(lc.w(var_11_0), lc.h(var_11_0) / 2))

		arg_11_1._region = var_11_2
	end

	arg_11_1._history = arg_11_2

	function arg_11_1._btn._callback()
		if arg_11_0._callback then
			arg_11_0._callback(arg_11_2._rid)
		end

		arg_11_0:hide()
	end

	arg_11_1._avatar:setUser(arg_11_2)

	local var_11_3 = ClientData._regions[arg_11_2._rid]

	arg_11_1._region:setString(ClientData.genFullRegionName(var_11_3._id, var_11_3._name))

	return arg_11_1
end

function var_0_0.setOrCreateRegionItem(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == nil then
		arg_13_1 = ccui.Widget:create()

		arg_13_1:setContentSize(570, 80)

		local function var_13_0()
			local var_14_0 = ClientView.createScale9ShaderButton("img_com_bg_2", nil, cc.rect(8, 14, 1, 1), lc.w(arg_13_1) / 2 - 20, 50)

			var_14_0:setColor(lc.Color3B.black)
			var_14_0:setOpacity(100)

			local var_14_1 = ClientView.createTTF("", ClientView.FontSize.S1)

			var_14_1:setAnchorPoint(0, 0.5)
			lc.addChildToPos(var_14_0, var_14_1, cc.p(12, lc.h(var_14_0) / 2))

			var_14_0._label = var_14_1

			local var_14_2 = lc.createSprite("img_region_full")

			lc.addChildToPos(var_14_0, var_14_2, cc.p(lc.w(var_14_0) - lc.w(var_14_2) / 2 + 10, lc.h(var_14_0) / 2))

			var_14_0._flag = var_14_2

			return var_14_0
		end

		arg_13_1._left = var_13_0()

		lc.addChildToPos(arg_13_1, arg_13_1._left, cc.p(lc.w(arg_13_1._left) / 2, lc.h(arg_13_1) / 2))

		arg_13_1._right = var_13_0()

		lc.addChildToPos(arg_13_1, arg_13_1._right, cc.p(lc.w(arg_13_1) - lc.w(arg_13_1._right) / 2, lc.h(arg_13_1) / 2))
	end

	local function var_13_1(arg_15_0, arg_15_1)
		arg_15_0._region = arg_15_1

		if arg_15_1 then
			arg_15_0:setVisible(true)

			function arg_15_0._callback()
				if arg_13_0._callback then
					lc.log("Select region: %d", arg_15_1._id)
					arg_13_0._callback(arg_15_1._id)
				end

				arg_13_0:hide()
			end

			local var_15_0

			if arg_15_1._isRecommend then
				var_15_0 = "img_region_recommend"
			elseif arg_15_1._isNew then
				var_15_0 = "img_region_new"
			elseif arg_15_1._status == Region_pb.PB_TYPE_FULL then
				var_15_0 = "img_region_full"
			end

			if var_15_0 then
				arg_15_0._flag:setSpriteFrame(var_15_0)
				arg_15_0._flag:setVisible(true)
			else
				arg_15_0._flag:setVisible(false)
			end

			arg_15_0._label:setString(ClientData.genFullRegionName(arg_15_1._id, arg_15_1._name))
		else
			arg_15_0:setVisible(false)
		end
	end

	var_13_1(arg_13_1._left, arg_13_2[1])
	var_13_1(arg_13_1._right, arg_13_2[2])

	return arg_13_1
end

return var_0_0
