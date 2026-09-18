local var_0_0 = class("GivePropForm", BaseForm)
local var_0_1 = cc.size(800, 600)
local var_0_2 = 5

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._user = arg_2_1
	arg_2_0._activityType = arg_2_2

	local var_2_0 = P:getItemsToSend()

	arg_2_0._props = {
		{},
		{}
	}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1._isGold then
			arg_2_0._props[2][#arg_2_0._props[2] + 1] = iter_2_1
		else
			arg_2_0._props[1][#arg_2_0._props[1] + 1] = iter_2_1
		end
	end

	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.SEND_GIFT), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_1 = lc.List.createV(cc.size(var_0_1.width - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, var_0_1.height - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 50, 10)

	lc.addChildToCenter(arg_2_0._form, var_2_1)

	arg_2_0._itemList = var_2_1

	local var_2_2 = {
		Str(STR.PROPS),
		Str(STR.CARD)
	}

	arg_2_0._tabDefs = var_2_2

	ClientView.addVerticalTabButtons(arg_2_0._frame, var_2_2, lc.h(arg_2_0._frame) - 80, -124, 580)

	arg_2_0._tabArea = arg_2_0._frame._tabArea

	function arg_2_0._frame.showTab(...)
		arg_2_0:showTab(...)
	end

	arg_2_0._frame:showTab(1)
end

function var_0_0.showTab(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0._tabArea._focusTabIndex == arg_4_2 and not arg_4_3 then
		return
	end

	arg_4_0._tabArea:showTab(arg_4_2)

	arg_4_0._tabIndex = arg_4_2

	arg_4_0:refreshList()
end

function var_0_0.refreshList(arg_5_0)
	local var_5_0 = lc.arrayToTable(arg_5_0._props[arg_5_0._tabIndex], var_0_2, function(arg_6_0)
		return true
	end)

	arg_5_0._itemList:bindData(var_5_0, function(arg_7_0, arg_7_1)
		arg_5_0:setOrCreateItem(arg_7_0, arg_7_1)
	end, math.min(5, #var_5_0))

	for iter_5_0 = 1, arg_5_0._itemList._cacheCount do
		local var_5_1 = arg_5_0:setOrCreateItem(nil, var_5_0[iter_5_0])

		arg_5_0._itemList:pushBackCustomItem(var_5_1)
	end

	arg_5_0._itemList:checkEmpty(string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.COULD_GIVE) .. arg_5_0._tabDefs[arg_5_0._tabIndex]))
end

function var_0_0.setOrCreateItem(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 then
		arg_8_1 = ccui.Widget:create()

		arg_8_1:setContentSize(cc.size(lc.w(arg_8_0._itemList), 150))

		arg_8_1._icons = {}

		function arg_8_1.update(arg_9_0)
			for iter_9_0, iter_9_1 in ipairs(arg_8_1._icons) do
				iter_9_1:setVisible(false)
			end

			for iter_9_2, iter_9_3 in ipairs(arg_9_0) do
				local var_9_0 = iter_9_3._id
				local var_9_1 = var_9_0

				if iter_9_3._isBonus then
					var_9_1 = Data._bonusInfo[var_9_0]._rid[1]
				end

				local var_9_2 = arg_8_1._icons[iter_9_2]
				local var_9_3 = P:getItemCount(var_9_1)

				if not var_9_2 then
					var_9_2 = IconWidget.create({
						_infoId = var_9_1,
						_count = var_9_3
					})

					var_9_2._name:setColor(ClientView.COLOR_TEXT_WHITE)

					var_9_2._nameColor = ClientView.COLOR_TEXT_WHITE

					function var_9_2._callback()
						arg_8_0:onSelectProp(var_9_2)
					end

					lc.addChildToPos(arg_8_1, var_9_2, cc.p((iter_9_2 - 0.5) * 150, lc.ch(arg_8_1)))
					table.insert(arg_8_1._icons, iter_9_2, var_9_2)
				else
					var_9_2:resetData({
						_infoId = var_9_1,
						_count = P:getItemCount(var_9_1)
					})
					var_9_2:setVisible(true)
				end

				var_9_2:setGray(var_9_3 == 0)
				var_9_2._countBg:setVisible(var_9_3 > 0)

				var_9_2._id = var_9_0
				var_9_2._def = iter_9_3
			end
		end
	end

	arg_8_1.update(arg_8_2)

	return arg_8_1
end

function var_0_0.onSelectProp(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1._def
	local var_11_1 = arg_11_1._id
	local var_11_2 = arg_11_1._data._infoId

	if P:getItemCount(var_11_2) <= 0 then
		return ToastManager.push(Str(STR.COUNT_NOT_ENOUGH))
	end

	local var_11_3 = ClientData.getNameByInfoId(var_11_2)

	if var_11_0._isGold then
		local var_11_4 = Data._globalInfo._sendRedCardCost

		if var_11_4 > P:getItemCount(Data.ResType.ingot) then
			return ToastManager.push(string.format(Str(STR.GIVE_COST_TIP), var_11_3, var_11_4))
		end
	end

	if P._playerActivity:isPrivilegeValid() and not var_11_0._isGold then
		require("Dialog").showSelectCountDialog(string.format(Str(STR.CONFIRM_SEND_2), var_11_3, arg_11_0._user._name), function(arg_12_0)
			local var_12_0 = arg_12_0._selectCountWidget:getCount()

			P:addResource(var_11_2, 1, -var_12_0)
			ClientData.sendProp(arg_11_0._user._id, var_11_1, var_12_0, var_11_0._isBonus)
			ToastManager.push(Str(STR.SEND_GIFT) .. Str(STR.SUCCESS))
			arg_11_0:hide()
		end, nil, P:getItemCount(var_11_2))
	else
		require("Dialog").showDialog(var_11_0._isGold and string.format(Str(STR.CONFIRM_SEND_COST_TIP), var_11_3, Data._globalInfo._sendRedCardCost) or string.format(Str(STR.CONFIRM_SEND), var_11_3, arg_11_0._user._name), function()
			local var_13_0 = 1

			P:addResource(var_11_2, 1, -var_13_0)

			if var_11_0._isGold then
				P:addResource(Data.ResType.ingot, 1, -Data._globalInfo._sendRedCardCost)
			end

			ClientData.sendProp(arg_11_0._user._id, var_11_1, var_13_0, var_11_0._isBonus)
			ToastManager.push(Str(STR.SEND_GIFT) .. Str(STR.SUCCESS))
			arg_11_0:hide()
		end)
	end
end

function var_0_0.onEnter(arg_14_0)
	var_0_0.super.onEnter(arg_14_0)
end

function var_0_0.onExit(arg_15_0)
	var_0_0.super.onExit(arg_15_0)
end

return var_0_0
