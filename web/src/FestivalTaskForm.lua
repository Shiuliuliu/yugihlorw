local var_0_0 = class("FestivalTaskForm", BaseForm)
local var_0_1 = cc.size(960, 700)
local var_0_2 = 180
local var_0_3 = 100

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(isUnion, focusTab)

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.SID_FIXITY_NAME_2001), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_0 = arg_2_0._form

	arg_2_0:initTopArea()

	local var_2_1 = lc.List.createV(cc.size(lc.w(var_2_0) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN, lc.h(var_2_0) - var_0_0.TOP_MARGIN - var_0_0.BOTTOM_MARGIN - lc.h(arg_2_0._topArea) + 40), 6, 0)

	var_2_1:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.w(var_2_0) / 2, lc.h(var_2_1) / 2 + 24))

	arg_2_0._list = var_2_1

	arg_2_0:updateList()
end

function var_0_0.initTopArea(arg_3_0)
	local var_3_0 = lc.createSprite({
		_name = "img_com_bg_4",
		_crect = ClientView.CRECT_COM_BG4,
		_size = cc.size(lc.w(arg_3_0._form) - var_0_0.FRAME_THICK_H, 110)
	})

	lc.addChildToPos(arg_3_0._form, var_3_0, cc.p(lc.w(arg_3_0._form) / 2, lc.h(arg_3_0._form) - var_0_0.FRAME_THICK_TOP - lc.h(var_3_0) / 2 + 24), 1)

	arg_3_0._topArea = var_3_0

	local var_3_1 = ClientView.createTTF(Str(STR.MERRY_XMAS), ClientView.FontSize.S2, ClientView.COLOR_LABEL_DARK)

	lc.addChildToPos(var_3_0, var_3_1, cc.p(24 + lc.w(var_3_1) / 2, 50))

	local var_3_2 = {}

	for iter_3_0, iter_3_1 in pairs(P._playerAchieve._activityTasks) do
		if iter_3_1:isExchangeTask() then
			for iter_3_2, iter_3_3 in ipairs(iter_3_1._info._param) do
				var_3_2[iter_3_3[1]] = iter_3_3[1]
			end
		end
	end

	local var_3_3 = lc.reorderToArray(var_3_2, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)
	local var_3_4 = lc.w(var_3_0) - 30
	local var_3_5 = {}

	for iter_3_4, iter_3_5 in ipairs(var_3_3) do
		local var_3_6

		if Data.getType(iter_3_5) == Data.CardType.res then
			var_3_6 = string.format("img_icon_res%d_s%d", iter_3_5)
		else
			var_3_6 = ClientData.getPropIconName(iter_3_5)
		end

		local var_3_7 = ClientView.createItemCountArea(iter_3_5, var_3_6, 160)

		var_3_7._type = iter_3_5

		table.insert(var_3_5, var_3_7)
		lc.addChildToPos(var_3_0, var_3_7, cc.p(var_3_4 - lc.w(var_3_7) / 2, 50))

		var_3_4 = var_3_4 - lc.w(var_3_7) - 10
	end

	var_3_0._areas = var_3_5
end

function var_0_0.updateResCount(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._topArea._areas) do
		iter_5_1._label:setString(P:getItemCount(iter_5_1._type))
	end
end

function var_0_0.updateList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(P._playerAchieve._activityTasks) do
		local var_6_2 = iter_6_1:getBonus()

		table.insert(var_6_0, iter_6_1)
	end

	local var_6_3 = arg_6_0._list

	var_6_3:bindData(var_6_0, function(arg_7_0, arg_7_1)
		arg_6_0:setOrCreateItem(arg_7_0, arg_7_1)
	end, math.min(4, #var_6_0))

	for iter_6_2 = 1, var_6_3._cacheCount do
		local var_6_4 = arg_6_0:setOrCreateItem(nil, var_6_0[iter_6_2])

		var_6_3:pushBackCustomItem(var_6_4)
	end

	var_6_3:refreshView()
	var_6_3:gotoTop()
end

function var_0_0.refreshList(arg_8_0)
	local var_8_0 = arg_8_0._list:getItems()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		arg_8_0:setOrCreateItem(iter_8_1, iter_8_1._task)
	end
end

function var_0_0.setOrCreateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2:getBonus()

	if arg_9_1 == nil then
		arg_9_1 = require("BonusWidget").create(880, arg_9_2:getBonus(), arg_9_2:getTitle())

		arg_9_1:registerCallback(function(arg_10_0)
			arg_9_0:dealTask(arg_10_0)
		end)
	end

	arg_9_1._task = arg_9_2

	arg_9_1:setBonus(var_9_0, arg_9_2:getTitle())
	arg_9_1:removeChildrenByTag(var_0_3)

	if arg_9_2:isExchangeTask() then
		local var_9_1 = lc.right(arg_9_1._button)
		local var_9_2 = lc.bottom(arg_9_1._button) - 30

		for iter_9_0, iter_9_1 in ipairs(arg_9_2._info._param) do
			local var_9_3 = ClientView.createResIconLabel(140, ClientData.getPropIconName(iter_9_1[1]), ClientView.COLOR_RES_LABEL_BG_DARK)
			local var_9_4 = P:getItemCount(iter_9_1[1])

			var_9_3._label:setString(iter_9_1[2])

			if var_9_4 < iter_9_1[2] then
				var_9_3._label:setColor(lc.Color3B.red)
			end

			lc.addChildToPos(arg_9_1, var_9_3, cc.p(var_9_1 - lc.w(var_9_3) / 2, var_9_2), 0, var_0_3)

			var_9_1 = lc.left(var_9_3) - 10
		end

		local var_9_5 = arg_9_2:getBonus()._isClaimed

		arg_9_1._button:setVisible(not var_9_5)
		arg_9_1._claimedFlag:setVisible(var_9_5)

		if var_9_5 then
			arg_9_1._claimedFlag._label:setString(Str(STR.EXCHANGED))
		else
			arg_9_1._button._label:setString(Str(STR.EXCHANGE))
		end
	end

	return arg_9_1
end

function var_0_0.dealTask(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1._task

	if var_11_0:isExchangeTask() then
		local var_11_1 = var_11_0:exchange()

		if var_11_1 == Data.ErrorType.ok then
			arg_11_0:updateResCount()
			arg_11_0:refreshList()
			ClientView.showClaimBonusResult(arg_11_1, var_11_1)
		elseif var_11_1 == Data.ErrorType.need_more_exchange_res then
			ToastManager.push(Str(STR.NEED_MORE_EXCHANGE_RES))
		end
	elseif arg_11_1._value >= arg_11_1._info._val then
		if not arg_11_1._isClaimed then
			local var_11_2 = ClientData.claimBonus(arg_11_1)

			arg_11_0:refreshList()
			ClientView.showClaimBonusResult(arg_11_1, var_11_2)
		end
	else
		local var_11_3 = var_11_0._info._type

		if var_11_3 == Data.ActivityTaskType.pvp then
			lc.pushScene(require("WorldScene").create())
			GuideManager.showSoftGuideFinger(ClientView.getMenuUI()._btnActivityPvp)
		elseif var_11_3 == Data.ActivityTaskType.world_boss then
			local var_11_4 = P._playerWorld._cities[Data._activityTaskInfo._worldBoss._param[1][1]]

			lc.pushScene(require("WorldScene").create(var_11_4, ClientData._worldDisplayCity))
		end

		arg_11_0:hide(true)
	end
end

function var_0_0.onEnter(arg_12_0)
	var_0_0.super.onEnter(arg_12_0)
end

function var_0_0.onExit(arg_13_0)
	var_0_0.super.onExit(arg_13_0)
end

return var_0_0
