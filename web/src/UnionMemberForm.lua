local var_0_0 = class("UnionMemberForm", BaseForm)
local var_0_1 = cc.size(960, 700)

var_0_0.Mode = {
	contribute = 2,
	select = 1,
	activity = 3,
	boss_rank = 4
}

local var_0_2 = 1000

function var_0_0.createSelect(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.create(var_0_0.Mode.select, arg_1_0)

	function var_1_0._bottomArea._btnOk._callback()
		arg_1_1(var_1_0)
	end

	return var_1_0
end

function var_0_0.createContribute()
	return var_0_0.create(var_0_0.Mode.contribute)
end

function var_0_0.createActivity()
	return var_0_0.create(var_0_0.Mode.activity)
end

function var_0_0.createBossRank(arg_5_0)
	return var_0_0.create(var_0_0.Mode.boss_rank, arg_5_0)
end

function var_0_0.create(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_6_0:init(arg_6_0, arg_6_1)

	return var_6_0
end

function var_0_0.init(arg_7_0, arg_7_1, arg_7_2)
	var_0_0.super.init(arg_7_0, var_0_1, "", bor(var_0_0.FLAG.ADVANCE_TITLE_BG, var_0_0.FLAG.SCROLL_V))

	arg_7_0._mode = arg_7_1

	if arg_7_1 == var_0_0.Mode.select then
		arg_7_0._maxCount = arg_7_2
		arg_7_0._selCount = 0

		arg_7_0:initBottomArea()
	elseif arg_7_1 == var_0_0.Mode.boss_rank then
		arg_7_0._boss = arg_7_2
		arg_7_0._isRank = true

		arg_7_0:initBottomArea()
	end

	arg_7_0._form:setTouchEnabled(false)

	local var_7_0 = lc.List.createV(cc.size(lc.w(arg_7_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.bottom(arg_7_0._titleFrame) + 20 - (arg_7_0._bottomArea and lc.h(arg_7_0._bottomArea) or 0)), 30, 0)

	lc.addChildToPos(arg_7_0._frame, var_7_0, cc.p(ClientView.FRAME_INNER_LEFT + 2, arg_7_0._bottomArea and lc.h(arg_7_0._bottomArea) or 15), -1)

	arg_7_0._list = var_7_0

	arg_7_0:updateList()
	arg_7_0:updateTitle()
end

function var_0_0.initBottomArea(arg_8_0)
	local var_8_0 = lc.createNode(cc.size(lc.w(arg_8_0._frame), 95))

	lc.addChildToPos(arg_8_0._frame, var_8_0, cc.p(lc.w(arg_8_0._frame) / 2, lc.h(var_8_0) / 2), 1)

	arg_8_0._bottomArea = var_8_0

	local var_8_1 = ClientView.createLineSprite("img_divide_line_1", lc.w(var_8_0) - 50)

	lc.addChildToPos(var_8_0, var_8_1, cc.p(lc.cw(var_8_0), lc.h(var_8_0)))

	if arg_8_0._mode == var_0_0.Mode.boss_rank then
		local var_8_2 = ClientView.createScale9ShaderButton("img_btn_1_s", nil, ClientView.CRECT_BUTTON_S, 160)

		var_8_2:addLabel(Str(STR.BONUS_RULE))
		lc.addChildToPos(var_8_0, var_8_2, cc.p(lc.cw(var_8_0), lc.h(var_8_0) / 2 + 10), 1)

		var_8_0._btnRule = var_8_2
	else
		local var_8_3 = ClientView.createScale9ShaderButton("img_btn_1_s", nil, ClientView.CRECT_BUTTON_S, 160)

		var_8_3:addLabel(Str(STR.OK))
		lc.addChildToPos(var_8_0, var_8_3, cc.p(lc.cw(var_8_0), lc.h(var_8_0) / 2 + 10), 1)

		var_8_0._btnOk = var_8_3
	end
end

function var_0_0.updateList(arg_9_0)
	arg_9_0._members = nil

	if not P._playerUnion._hasDetailInfo then
		arg_9_0._activeIndicator = ClientView.showPanelActiveIndicator(arg_9_0._form)

		performWithDelay(arg_9_0, ClientData.sendGetMyUnionDetail, var_0_0.ACTION_DURATION)

		return
	end

	local var_9_0 = P._playerUnion:getMyUnion()
	local var_9_1 = arg_9_0._mode
	local var_9_2 = var_9_0:getMembers()

	if var_9_1 == var_0_0.Mode.select then
		local var_9_3

		for iter_9_0, iter_9_1 in ipairs(var_9_2) do
			iter_9_1._isSelected = false

			if iter_9_1._id == P._id then
				var_9_3 = iter_9_0
			end
		end

		if var_9_3 then
			table.remove(var_9_2, var_9_3)
		end
	elseif var_9_1 == var_0_0.Mode.contribute then
		table.sort(var_9_2, function(arg_10_0, arg_10_1)
			local var_10_0 = var_9_0:getContribution(arg_10_0._id)
			local var_10_1 = var_9_0:getContribution(arg_10_1._id)
			local var_10_2 = var_10_0[Data.ResType.union_act]
			local var_10_3 = var_10_1[Data.ResType.union_act]

			if var_10_2 == var_10_3 then
				if arg_10_0._level == arg_10_1._level then
					return arg_10_0._lastLogin > arg_10_1._lastLogin
				end

				return arg_10_0._level > arg_10_1._level
			end

			return var_10_3 < var_10_2
		end)
	elseif var_9_1 == var_0_0.Mode.activity then
		table.sort(var_9_2, function(arg_11_0, arg_11_1)
			local var_11_0 = var_9_0:getContribution(arg_11_0._id)
			local var_11_1 = var_9_0:getContribution(arg_11_1._id)
			local var_11_2, var_11_3 = var_11_0[Data.ResType.union_act], var_11_1[Data.ResType.union_act]

			if var_11_2 == var_11_3 then
				if arg_11_0._level == arg_11_1._level then
					return arg_11_0._lastLogin > arg_11_1._lastLogin
				end

				return arg_11_0._level > arg_11_1._level
			end

			return var_11_3 < var_11_2
		end)
	elseif var_9_1 == var_0_0.Mode.boss_rank then
		local var_9_4 = P._playerUnion:getMyUnion()
		local var_9_5 = var_9_4._bosses[arg_9_0._boss._id]

		for iter_9_2, iter_9_3 in ipairs(var_9_2) do
			iter_9_3._score = var_9_4:getMemberBossScore(iter_9_3._id, arg_9_0._boss._id)
			iter_9_3._count = var_9_4:getMemberBossCount(iter_9_3._id, arg_9_0._boss._id)
		end

		table.sort(var_9_2, function(arg_12_0, arg_12_1)
			return arg_12_0._score > arg_12_1._score
		end)

		local var_9_6

		for iter_9_4, iter_9_5 in pairs(var_9_2) do
			iter_9_5._rank = iter_9_4

			if iter_9_5._id == P._id then
				var_9_6 = iter_9_4
			end
		end

		function arg_9_0._bottomArea._btnRule._callback()
			require("RankBonusForm").create(var_9_6, SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE, arg_9_0._boss):show()
		end
	end

	local var_9_7 = arg_9_0._list

	var_9_7:bindData(var_9_2, function(arg_14_0, arg_14_1)
		arg_9_0:setOrCreateItem(arg_14_0, arg_14_1)
	end, math.min(7, #var_9_2))

	arg_9_0._members = var_9_2

	for iter_9_6 = 1, var_9_7._cacheCount do
		local var_9_8 = arg_9_0:setOrCreateItem(nil, var_9_2[iter_9_6])

		var_9_7:pushBackCustomItem(var_9_8)
	end
end

function var_0_0.updateTitle(arg_15_0)
	local var_15_0 = arg_15_0._mode
	local var_15_1

	if var_15_0 == var_0_0.Mode.select then
		var_15_1 = string.format("%s%s (%d/%d)", Str(STR.SELECT), Str(STR.UNION_MEMBER), arg_15_0._selCount, arg_15_0._maxCount)
	elseif var_15_0 == var_0_0.Mode.contribute then
		var_15_1 = Str(STR.MEMBER_CONTRIBUTE)
	elseif var_15_0 == var_0_0.Mode.activity then
		var_15_1 = Str(STR.MEMBER_ACTIVITY)
	elseif var_15_0 == var_0_0.Mode.boss_rank then
		var_15_1 = string.format(Str(STR.BRACKETS_S) .. Str(STR.DAMAGE_RANK), Str(arg_15_0._boss._info._nameSid))
	end

	arg_15_0._titleLabel:setString(var_15_1)
end

function var_0_0.addOneValueArea(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = ClientView.createTTF(arg_16_2 .. ": ", ClientView.FontSize.S2, ClientView.COLOR_LABEL_DARK)

	var_16_0:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_16_1, var_16_0, cc.p(arg_16_4, arg_16_5))

	local var_16_1

	if arg_16_3 then
		var_16_1 = ClientView.addIconValue(arg_16_1, arg_16_3, 0, lc.right(var_16_0) + 16, lc.y(var_16_0))

		var_16_1:setColor(ClientView.COLOR_TEXT_DARK)
	else
		var_16_1 = ClientView.createTTF("", ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)

		var_16_1:setAnchorPoint(0, 0.5)
		lc.addChildToPos(arg_16_1, var_16_1, cc.p(lc.right(var_16_0) + 16, lc.y(var_16_0)))
	end

	return var_16_1
end

function var_0_0.setOrCreateItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = P._playerUnion:getMyUnion()
	local var_17_1 = arg_17_0._mode

	if arg_17_1 == nil then
		arg_17_1 = ClientView.createUnionMemberItem(arg_17_2, lc.w(arg_17_0._list), true)

		if var_17_1 == var_0_0.Mode.select then
			local var_17_2 = ClientView.createCheckLabelArea("")

			lc.addChildToPos(arg_17_1, var_17_2, cc.p(lc.w(arg_17_1) - 80, lc.y(arg_17_1._userArea)))

			arg_17_1._checkArea = var_17_2

			arg_17_1._starArea:setVisible(false)
		elseif var_17_1 == var_0_0.Mode.contribute then
			arg_17_1._todayGold, arg_17_1._todayWood = ClientView.addUnionContribution(arg_17_1, Str(STR.TODAY) .. Str(STR.CONTRIBUTE), ClientView.FontSize.S2, 500, lc.h(arg_17_1) / 2 + 24)
			arg_17_1._weekGold, arg_17_1._weekWood = ClientView.addUnionContribution(arg_17_1, Str(STR.THIS_WEEK) .. Str(STR.CONTRIBUTE), ClientView.FontSize.S2, 500, lc.h(arg_17_1) / 2 - 16)
		elseif var_17_1 == var_0_0.Mode.activity then
			arg_17_1._todayAct = arg_17_0:addOneValueArea(arg_17_1, Str(STR.TODAY) .. Str(STR.ACTIVE), "img_icon_res14_s", 530, lc.h(arg_17_1) / 2)
		elseif var_17_1 == var_0_0.Mode.boss_rank then
			arg_17_1._score = ClientView.createIconLabelArea("img_icon_score", nil, 160)

			lc.addChildToPos(arg_17_1, arg_17_1._score, cc.p(760, lc.h(arg_17_1) / 2 + 4))

			local var_17_3 = ClientView.createKeyValueLabel(Str(STR.ATTACK_TIMES), "", ClientView.FontSize.S2, false)

			var_17_3:addToParent(arg_17_1._userArea, cc.p(lc.left(arg_17_1._lastLogin) + 250, lc.y(arg_17_1._lastLogin)))

			arg_17_1._count = var_17_3
		end

		if arg_17_0._isRank then
			lc.offset(arg_17_1._userArea, 90)
		end
	end

	arg_17_1:removeChildrenByTag(var_0_2)

	if arg_17_0._isRank then
		local var_17_4 = arg_17_2._rank

		if var_17_4 <= 3 then
			local var_17_5 = lc.createSprite(string.format("img_medal_%d", var_17_4))

			var_17_5:setPosition(lc.w(var_17_5) / 2 + 40, lc.h(arg_17_1) / 2 + 5)
			arg_17_1:addChild(var_17_5, 0, var_0_2)
		else
			local var_17_6 = ClientView.createBMFont(ClientView.BMFont.num_48, string.format("%d", var_17_4))

			var_17_6:setPosition(70, lc.h(arg_17_1) / 2 + 2)
			arg_17_1:addChild(var_17_6, 0, var_0_2)
		end
	end

	arg_17_1:update(arg_17_2)

	if var_17_1 == var_0_0.Mode.select then
		function arg_17_1._checkArea._callback(arg_18_0)
			if arg_18_0 == arg_17_2._isSelected then
				return
			end

			if arg_18_0 and arg_17_0._selCount >= arg_17_0._maxCount then
				ToastManager.push(string.format(Str(STR.UNION_MEMBER_SELECT_MAX), arg_17_0._maxCount))
				arg_17_1._checkArea:setCheck(false)

				return
			end

			arg_17_2._isSelected = arg_18_0
			arg_17_0._selCount = arg_17_0._selCount + (arg_18_0 and 1 or -1)

			arg_17_0:updateTitle()
		end

		arg_17_1._checkArea:setCheck(arg_17_2._isSelected)
	elseif var_17_1 == var_0_0.Mode.contribute then
		local var_17_7, var_17_8 = var_17_0:getContribution(arg_17_2._id)

		arg_17_1._todayGold:setString(ClientData.formatNum(var_17_7[Data.ResType.union_act], 9999))
		arg_17_1._weekGold:setString(ClientData.formatNum(var_17_8[Data.ResType.union_act], 9999))
	elseif var_17_1 == var_0_0.Mode.activity then
		local var_17_9 = var_17_0:getActivePoint(arg_17_2._id)

		arg_17_1._todayAct:setString(ClientData.formatNum(var_17_9[Data.ResType.union_personal_power], 9999))
	elseif var_17_1 == var_0_0.Mode.boss_rank then
		arg_17_1._score._label:setString(arg_17_2._score)
		arg_17_1._count._value:setString(arg_17_2._count)
	end

	return arg_17_1
end

function var_0_0.onEnter(arg_19_0)
	var_0_0.super.onEnter(arg_19_0)

	local function var_19_0()
		if arg_19_0._activeIndicator then
			arg_19_0._activeIndicator:removeFromParent()

			arg_19_0._activeIndicator = nil
		end

		arg_19_0:updateList()
	end

	local var_19_1 = {}

	table.insert(var_19_1, lc.addEventListener(Data.Event.union_member_dirty, var_19_0))
	table.insert(var_19_1, lc.addEventListener(Data.Event.union_dirty, var_19_0))

	arg_19_0._listeners = var_19_1
end

function var_0_0.onExit(arg_21_0)
	var_0_0.super.onExit(arg_21_0)

	for iter_21_0 = 1, #arg_21_0._listeners do
		lc.Dispatcher:removeEventListener(arg_21_0._listeners[iter_21_0])
	end
end

return var_0_0
