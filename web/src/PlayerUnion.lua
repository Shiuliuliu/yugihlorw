local var_0_0 = class("PlayerUnion")

var_0_0.Operate = {
	impeach = 108,
	cancel_battle = 205,
	refresh_store = 106,
	buy_product = 102,
	invite_user = 206,
	view_contribute = 209,
	view_activity = 210,
	contribute_wood = 104,
	upgrade_tech = 212,
	give_leader = 302,
	fire_member = 201,
	refuse_user = 203,
	give_fund = 107,
	agree_user = 202,
	edit = 207,
	upgrade = 208,
	send_message = 105,
	contribute_gold = 103,
	unlock_boss = 211,
	set_job = 301,
	exit_union = 101,
	launch_battle = 204
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._searchUnions = {}
	arg_1_0._recommandUnions = {}
	arg_1_0._myActivityPoint = 0
	arg_1_0._groupId = nil
	arg_1_0._groupJob = nil

	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._searchUnions = {}
	arg_3_0._recommandUnions = {}
	arg_3_0._hireMembers = {}
	arg_3_0._myHires = {}
	arg_3_0._hiredHero = nil
	arg_3_0._lastHireTimestamp = nil

	arg_3_0:stopHireSchedule()

	if arg_3_0._myUnion then
		arg_3_0._myUnion:clear()

		arg_3_0._myUnion = nil
		arg_3_0._hasDetailInfo = nil
	end

	arg_3_0._nextRefreshTime = nil
	arg_3_0._myGroup = nil
	arg_3_0._groupId = nil
	arg_3_0._groupJob = nil
	arg_3_0._isSyncData = nil
end

function var_0_0.initBase(arg_4_0, arg_4_1)
	arg_4_0:clear()
	arg_4_0:initMyUnion(arg_4_1.info, arg_4_1.techs)
	arg_4_0:init(arg_4_1.data)
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0._nextRefreshTime = arg_5_1.next_refresh / 1000
	arg_5_0._hireMembers = {}

	if #arg_5_1.rented > 0 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1.rented) do
			table.insert(arg_5_0._hireMembers, iter_5_1)
		end
	end

	arg_5_0._techs = {}

	for iter_5_2, iter_5_3 in pairs(Data._unionTechInfo) do
		arg_5_0._techs[iter_5_2] = require("UnionTech").new(iter_5_2)
		arg_5_0._techs[iter_5_2]._isSelf = true
	end

	if #arg_5_1.techs > 0 then
		for iter_5_4, iter_5_5 in ipairs(arg_5_1.techs) do
			arg_5_0._techs[iter_5_5.id]:update(iter_5_5)
		end
	end

	if #arg_5_1.cards > 0 then
		arg_5_0._hiredHero = require("HireHero").new(arg_5_1)
		arg_5_0._lastHireTimestamp = arg_5_1.last_rent / 1000
		arg_5_0._lastHireSpan = (Data._globalInfo._unionRentTime + arg_5_0:getTechVal(Data.UnionTechId.lord_hired)) * 60

		arg_5_0:startHireSchedule()
	else
		arg_5_0._hiredHero = nil
		arg_5_0._lastHireTimestamp = nil

		arg_5_0:stopHireSchedule()
	end

	arg_5_0._groupId = arg_5_1:HasField("team_info") and arg_5_1.team_info.id or nil
	arg_5_0._battleTrophy = arg_5_1:HasField("team_info") and arg_5_1.team_info.masswar_score or 500
end

function var_0_0.initMyUnion(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1.detail
	local var_6_1

	if var_6_0 then
		if var_6_0.union_info.id == P._unionId then
			var_6_1 = require("Union").create(var_6_0.union_info, var_6_0.member_info, arg_6_1)
			arg_6_0._hasDetailInfo = true
		end
	elseif arg_6_1.id == P._unionId then
		var_6_1 = require("Union").create(arg_6_1)
	end

	if var_6_1 then
		arg_6_0._myUnion = var_6_1
		P._unionName = var_6_1._name
		P._unionBadge = var_6_1._badge
		P._unionWord = var_6_1._word
		P._unionType = var_6_1._joinType
		arg_6_0._myHires = {}

		for iter_6_0, iter_6_1 in pairs(var_6_1._hires) do
			if iter_6_1:isSelfCard() then
				table.insert(arg_6_0._myHires, iter_6_1)
			end
		end

		if arg_6_2 then
			var_6_1:updateTechs(arg_6_2)
		end

		var_6_1:sendUnionDirty()
		var_6_1:sendUnionResDirty()
	end
end

function var_0_0.getMyUnion(arg_7_0)
	return arg_7_0._myUnion
end

function var_0_0.getMyGroup(arg_8_0)
	return arg_8_0._myGroup
end

function var_0_0.getGroups(arg_9_0)
	return arg_9_0._groups
end

function var_0_0.canLottery(arg_10_0)
	return math.floor(arg_10_0._myUnion._energy / 100) > P._unionLottery
end

function var_0_0.addMember(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._myUnion

	if var_11_0 then
		var_11_0:addMember(arg_11_1)
	end
end

function var_0_0.removeMember(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._myUnion

	if var_12_0 then
		var_12_0:removeMember(arg_12_1)

		if arg_12_1 == P._id then
			P._unionId = 0

			P._playerMessage:clearUnion()
			P:setUnionFundValid(false)
			lc.sendEvent(Data.Event.union_fund_dirty)
			arg_12_0:clear()
			arg_12_0:sendExitUnionDirty()

			if arg_12_2 then
				ToastManager.push(Str(STR.UNION_BE_KICKED_OUT))
			end
		else
			var_12_0._impeach[arg_12_1] = nil
		end
	end
end

function var_0_0.upgrade(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._myUnion

	if var_13_0 then
		if arg_13_1 then
			if var_13_0._level >= #Data._globalInfo._unionLevel then
				return Data.ErrorType.union_level_max
			end

			if var_13_0._act < var_13_0:getLevelupAct() then
				return Data.ErrorType.need_more_union_act
			end
		else
			var_13_0:upgrade()
			lc.sendEvent(Data.Event.union_level_upgrade)
		end

		return Data.ErrorType.ok
	end
end

function var_0_0.upgradeTech(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._techs[arg_14_1]
	local var_14_1 = var_14_0:getUpgradeYubi()

	if var_14_1 > P:getItemCount(Data.PropsId.yubi) then
		return Data.ErrorType.need_more_yubi
	end

	P._propBag:changeProps(Data.PropsId.yubi, -var_14_1)

	var_14_0._level = var_14_0._level + 1

	lc.sendEvent(Data.Event.union_tech_dirty, var_14_0)

	if arg_14_1 == Data.UnionTechId.lord_hired and arg_14_0._hiredHero then
		arg_14_0._lastHireSpan = (Data._globalInfo._unionRentTime + arg_14_0:getTechVal(arg_14_1)) * 60
	end

	return Data.ErrorType.ok
end

function var_0_0.getTech(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._myUnion

	if var_15_0 then
		local var_15_1 = arg_15_0._techs[arg_15_1]
		local var_15_2 = math.min(var_15_1._level, var_15_0._techs[arg_15_1]._level)

		return var_15_1, var_15_2
	end

	return nil
end

function var_0_0.getTechVal(arg_16_0, arg_16_1)
	local var_16_0, var_16_1 = arg_16_0:getTech(arg_16_1)

	return var_16_0 and var_16_0._info._val[var_16_1] or 0
end

function var_0_0.addMyHire(arg_17_0, arg_17_1)
	local var_17_0 = require("HireHero").addHire(arg_17_1)

	table.insert(arg_17_0._myHires, var_17_0)

	return #arg_17_0._myHires
end

function var_0_0.removeMyHire(arg_18_0, arg_18_1)
	if arg_18_0._myHires == nil or arg_18_1 > #arg_18_0._myHires then
		return
	end

	table.remove(arg_18_0._myHires, arg_18_1)

	return #arg_18_0._myHires
end

function var_0_0.hire(arg_19_0, arg_19_1)
	table.insert(arg_19_0._hireMembers, arg_19_1._ownerId)

	arg_19_1._isHired = true

	arg_19_0._myUnion:setAllHired(arg_19_1._ownerId)

	arg_19_0._hiredHero = arg_19_1
	arg_19_0._lastHireTimestamp = ClientData.getCurrentTime()
	arg_19_0._lastHireSpan = (Data._globalInfo._unionRentTime + arg_19_0:getTechVal(Data.UnionTechId.lord_hired)) * 60

	arg_19_0:startHireSchedule()
end

function var_0_0.startHireSchedule(arg_20_0)
	arg_20_0:stopHireSchedule()

	arg_20_0._hireSchedulerId = lc.Scheduler:scheduleScriptFunc(function(arg_21_0)
		if arg_20_0._lastHireTimestamp + arg_20_0._lastHireSpan <= ClientData.getCurrentTime() then
			arg_20_0._hiredHero = nil
			arg_20_0._lastHireTimestamp = nil

			arg_20_0:stopHireSchedule()
		end
	end, 1, false)
end

function var_0_0.stopHireSchedule(arg_22_0)
	if arg_22_0._hireSchedulerId then
		lc.Scheduler:unscheduleScriptEntry(arg_22_0._hireSchedulerId)

		arg_22_0._hireSchedulerId = nil
	end
end

function var_0_0.canOperate(arg_23_0, arg_23_1)
	if P._unionId > 0 then
		local var_23_0 = math.floor(arg_23_1 / 100)

		if var_23_0 <= P._unionJob then
			return Data.ErrorType.ok
		end

		if var_23_0 == Data.UnionJob.leader then
			return Data.ErrorType.leader_operate
		elseif var_23_0 == Data.UnionJob.elder then
			return Data.ErrorType.elder_operate
		elseif var_23_0 == Data.UnionJob.rookie then
			return Data.ErrorType.rookie_operate
		end
	end

	return Data.ErrorType.union_operate
end

function var_0_0.getSearchUnions(arg_24_0)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(arg_24_0._searchUnions) do
		table.insert(var_24_0, iter_24_1)
	end

	return var_24_0
end

function var_0_0.getRecommandUnions(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(arg_25_0._recommandUnions) do
		table.insert(var_25_0, iter_25_1)
	end

	return var_25_0
end

function var_0_0.getMaxResource(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._myUnion

	if var_26_0 == nil then
		return 0
	end

	if arg_26_1 == Data.ResType.union_gold then
		return Data._globalInfo._unionMaxGold[var_26_0._level]
	elseif arg_26_1 == Data.ResType.union_wood then
		return Data._globalInfo._unionMaxWood[var_26_0._level]
	elseif arg_26_1 == Data.ResType.union_act then
		return Data._globalInfo._unionLevelupExp[var_26_0._level]
	end
end

function var_0_0.isReachMaxResource(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0._myUnion

	if var_27_0 == nil then
		return true
	end

	if arg_27_1 == Data.ResType.union_gold then
		return var_27_0._gold + arg_27_2 > Data._globalInfo._unionMaxGold[var_27_0._level]
	elseif arg_27_1 == Data.ResType.union_wood then
		return var_27_0._wood + arg_27_2 > Data._globalInfo._unionMaxWood[var_27_0._level]
	end
end

function var_0_0.changeResource(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0._myUnion

	if var_28_0 == nil then
		return
	end

	if arg_28_1 == Data.ResType.union_gold then
		local var_28_1 = arg_28_0:getMaxResource(arg_28_1)
		local var_28_2 = var_28_0._gold + arg_28_2

		if var_28_2 >= 0 then
			if var_28_1 < var_28_2 then
				var_28_2 = var_28_1
			end

			var_28_0._gold = var_28_2

			var_28_0:sendUnionResDirty(arg_28_1)
		end
	elseif arg_28_1 == Data.ResType.union_wood then
		local var_28_3 = arg_28_0:getMaxResource(arg_28_1)
		local var_28_4 = var_28_0._wood + arg_28_2

		if var_28_4 >= 0 then
			if var_28_3 < var_28_4 then
				var_28_4 = var_28_3
			end

			var_28_0._wood = var_28_4

			var_28_0:sendUnionResDirty(arg_28_1)
		end
	elseif arg_28_1 == Data.ResType.union_act then
		local var_28_5 = var_28_0._act + arg_28_2

		if var_28_5 >= 0 then
			var_28_0._act = var_28_5

			var_28_0:sendUnionResDirty(arg_28_1)

			if arg_28_0:upgrade(true) == Data.ErrorType.ok then
				arg_28_0:upgrade(false)
			end
		end
	end
end

function var_0_0.sendSearchUnionsDirty(arg_29_0)
	local var_29_0 = cc.EventCustom:new(Data.Event.union_search_dirty)

	lc.Dispatcher:dispatchEvent(var_29_0)
end

function var_0_0.sendRecommandUnionsDirty(arg_30_0)
	local var_30_0 = cc.EventCustom:new(Data.Event.union_recommand_dirty)

	lc.Dispatcher:dispatchEvent(var_30_0)
end

function var_0_0.sendEnterUnionDirty(arg_31_0)
	local var_31_0 = cc.EventCustom:new(Data.Event.union_enter_dirty)

	lc.Dispatcher:dispatchEvent(var_31_0)
end

function var_0_0.sendExitUnionDirty(arg_32_0)
	local var_32_0 = cc.EventCustom:new(Data.Event.union_exit_dirty)

	lc.Dispatcher:dispatchEvent(var_32_0)
end

function var_0_0.sendEditUnionDirty(arg_33_0)
	local var_33_0 = cc.EventCustom:new(Data.Event.union_edit_dirty)

	lc.Dispatcher:dispatchEvent(var_33_0)
end

function var_0_0.onMsg(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1.type
	local var_34_1 = arg_34_1.status

	if var_34_0 == SglMsgType_pb.PB_TYPE_UNION_MINE then
		local var_34_2 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_mine_resp]

		arg_34_0:initMyUnion(var_34_2)

		ClientData._unionLogs = nil

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_EDIT then
		if ClientView.getActiveIndicator()._userData and type(ClientView.getActiveIndicator()._userData) == "function" then
			ClientView.getActiveIndicator()._userData()

			ClientView.getActiveIndicator()._userData = nil
		end

		ToastManager.push(Str(STR.SUCCESS) .. Str(STR.CHANGE) .. Str(STR.UNION) .. Str(STR.INFO))
		arg_34_0:sendEditUnionDirty()

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_CREATE then
		local var_34_3 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_create_resp]

		P._unionId = var_34_3.info.id
		P._unionJob = Data.UnionJob.leader

		if P:getItemCount(Data.PropsId.union_create) > 0 then
			P:addResource(Data.PropsId.union_create, 1, -1)
		else
			P:changeResource(Data.ResType.ingot, -Data._globalInfo._createUnionIngot)
		end

		arg_34_0:initBase(var_34_3)
		arg_34_0:sendEnterUnionDirty()

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_JOIN then
		local var_34_4 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_join_resp]

		P._unionId = var_34_4.info.id
		P._unionJob = Data.UnionJob.rookie

		arg_34_0:initBase(var_34_4)
		arg_34_0:sendEnterUnionDirty()

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_LEAVE or var_34_0 == SglMsgType_pb.PB_TYPE_UNION_KICKOUT then
		arg_34_0:removeMember(P._id, var_34_0 == SglMsgType_pb.PB_TYPE_UNION_KICKOUT)

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_SEARCH then
		arg_34_0._searchUnions = {}

		local var_34_5 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_search_resp]

		for iter_34_0 = 1, #var_34_5 do
			local var_34_6 = require("Union").create(var_34_5[iter_34_0])

			if var_34_6 then
				arg_34_0._searchUnions[var_34_6._id] = var_34_6
			end
		end

		arg_34_0:sendSearchUnionsDirty()

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_RECOMMEND then
		arg_34_0._recommandUnions = {}

		local var_34_7 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_recommend_resp]

		for iter_34_1 = 1, #var_34_7 do
			local var_34_8 = require("Union").create(var_34_7[iter_34_1])

			if var_34_8 then
				arg_34_0._recommandUnions[var_34_8._id] = var_34_8
			end
		end

		arg_34_0:sendRecommandUnionsDirty()

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_REFRESH or var_34_0 == SglMsgType_pb.PB_TYPE_UNION_REFRESH_EX then
		local var_34_9 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_refresh_resp]

		arg_34_0:init(var_34_9)

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_LET then
		local var_34_10 = arg_34_0._myUnion

		if var_34_10 then
			local var_34_11 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_let_resp]
			local var_34_12 = var_34_10:addHire(var_34_11)

			lc.sendEvent(Data.Event.union_hires_dirty)

			if var_34_12:isSelfCard() then
				for iter_34_2, iter_34_3 in ipairs(arg_34_0._myHires) do
					if iter_34_3._infoId == var_34_12._infoId then
						iter_34_3._guid = var_34_12._guid

						break
					end
				end
			end
		end

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_UNLET then
		local var_34_13 = arg_34_0._myUnion

		if var_34_13 then
			local var_34_14 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_unlet_resp]

			if var_34_13._hires[var_34_14] then
				var_34_13._hires[var_34_14] = nil

				lc.sendEvent(Data.Event.union_hires_dirty)
			end
		end
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_BOSS_UNLOCK then
		local var_34_15 = arg_34_0._myUnion

		if var_34_15 and arg_34_0._hasDetailInfo then
			local var_34_16 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_boss_unlock_resp]

			var_34_15:unlockBoss(var_34_16)
			lc.sendEvent(Data.Event.union_boss_dirty, var_34_16)
		end
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_BOSS_DAMAGE then
		local var_34_17 = arg_34_0._myUnion

		if var_34_17 and arg_34_0._hasDetailInfo then
			local var_34_18 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_boss_damage_resp]
			local var_34_19 = var_34_18.id
			local var_34_20 = var_34_18.info.id
			local var_34_21 = var_34_17._bosses[var_34_19]

			if var_34_21 then
				var_34_21._scores[var_34_20] = var_34_18.score
				var_34_21._counts[var_34_20] = (var_34_21._counts[var_34_20] or 0) + 1

				var_34_21:hurt(var_34_18.damage)
				var_34_21:hurtAssistant(var_34_18.assistant_damage)

				if var_34_21._attacker and var_34_21._attacker._id == var_34_20 then
					var_34_21._attacker = nil
				end

				lc.sendEvent(Data.Event.union_boss_dirty, var_34_19)
			end
		end

		P._playerRank:clearRank(SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE)
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_BOSS_FOCUS then
		local var_34_22 = arg_34_0._myUnion

		if var_34_22 and arg_34_0._hasDetailInfo then
			local var_34_23 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_boss_focus_resp]
			local var_34_24 = var_34_23.info.id
			local var_34_25 = var_34_22._bosses[var_34_23.id]

			if var_34_24 ~= P._id and var_34_25 then
				var_34_25._attacker = var_34_22._members[var_34_23.info.id]

				lc.sendEvent(Data.Event.union_boss_dirty, var_34_25._id)
			end
		end
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_BOSS_KILL then
		if arg_34_0._myUnion and arg_34_0._hasDetailInfo then
			local var_34_26 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_boss_kill_resp]

			for iter_34_4, iter_34_5 in ipairs(var_34_26) do
				P:addResource(iter_34_5.info_id, iter_34_5.level, iter_34_5.num, iter_34_5.is_fragment)
			end
		end

		P._playerRank:clearRank(SglMsgType_pb.PB_TYPE_RANK_UBOSS_TIME)
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_USER_FUND_GIVEN then
		P:givenUnionFund()
		lc.sendEvent(Data.Event.union_fund_dirty)
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_UNION_MESSAGE then
		local var_34_27 = arg_34_0._myUnion

		if var_34_27 then
			local function var_34_28(arg_35_0, arg_35_1)
				local var_35_0 = var_34_27:findMember(arg_35_0)

				if var_35_0 then
					var_35_0._unionJob = arg_35_1

					if P._id == arg_35_0 then
						P._unionJob = arg_35_1
					end

					var_35_0:sendUserDirty()
				end
			end

			local var_34_29 = arg_34_1.Extensions[Union_pb.SglUnionMsg.union_message_resp]

			for iter_34_6, iter_34_7 in ipairs(var_34_29) do
				local var_34_30 = iter_34_7.type
				local var_34_31 = iter_34_7.user1.id
				local var_34_32

				if iter_34_7:HasField("user2") then
					var_34_32 = iter_34_7.user2.id
				end

				if var_34_30 == Union_pb.PB_UNION_JOIN then
					arg_34_0:addMember(require("User").create(iter_34_7.user1))
				elseif var_34_30 == Union_pb.PB_UNION_KICKOUT then
					arg_34_0:removeMember(var_34_32)

					if var_34_31 == P._id then
						ToastManager.push(Str(STR.UNION_KICKOUT_SUCCESS))
					end
				elseif var_34_30 == Union_pb.PB_UNION_LEAVE then
					arg_34_0:removeMember(var_34_31)
				elseif var_34_30 == Union_pb.PB_UNION_TO_MEMBER or var_34_30 == Union_pb.PB_UNION_TO_CO_LEADER then
					var_34_28(var_34_32, iter_34_7.user2.union_title)

					if var_34_31 == P._id then
						ToastManager.push(Str(STR.CHANGE_JOB_SUCCESS))
					end
				elseif var_34_30 == Union_pb.PB_UNION_TO_LEADER then
					var_34_28(var_34_31, iter_34_7.user1.union_title)

					var_34_27._impeach = {}
				elseif var_34_30 == Union_pb.PB_UNION_RESIGN then
					var_34_28(var_34_31, iter_34_7.user1.union_title)
					var_34_28(var_34_32, iter_34_7.user2.union_title)

					var_34_27._impeach = {}
				elseif var_34_30 == Union_pb.PB_UNION_UPGRADE then
					arg_34_0:upgrade()

					if var_34_31 == P._id then
						require("LevelUpPanel").createUnion(var_34_27._level - 1, var_34_27._level):show()
					end
				elseif var_34_30 == Union_pb.PB_UNION_TECH_UPGRADE then
					local var_34_33 = var_34_27._techs[iter_34_7.param2]

					var_34_27:upgradeTech(var_34_33._infoId)

					local var_34_34 = arg_34_0._techs[iter_34_7.param2]

					lc.sendEvent(Data.Event.union_tech_dirty, var_34_34)

					if var_34_31 == P._id then
						ToastManager.push(string.format(Str(STR.UNION_TECH_UPGRADE_SUCCESS), Str(var_34_33._info._nameSid), iter_34_7.param1))
						lc.sendEvent(Data.Event.union_tech_upgrade, var_34_33)
					end
				elseif var_34_30 == Union_pb.PB_UNION_IMPEACH then
					var_34_27._impeach[var_34_31] = true
				elseif var_34_30 == Union_pb.PB_UNION_UNIMPEACH then
					var_34_27._impeach[var_34_31] = nil
				elseif var_34_30 == Union_pb.PB_UNION_IMPEACHED then
					var_34_28(var_34_31, iter_34_7.user1.union_title)
				elseif var_34_30 == Union_pb.PB_UNION_ADD_EXP then
					local var_34_35 = iter_34_7.resource

					for iter_34_8, iter_34_9 in ipairs(var_34_35) do
						arg_34_0:changeResource(iter_34_9._infoId, iter_34_9._num)
					end
				end
			end
		end
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_WORLD_MASSWAR_PRE then
		arg_34_0._isSyncData = true

		local var_34_36 = arg_34_1.Extensions[World_pb.SglWorldMsg.world_user_id_resp]

		lc.sendEvent(Data.Event.union_battle_ready)

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_QUERY_INFO then
		local var_34_37 = arg_34_1.Extensions[UnionWar_pb.SglUnionWarMsg.masswar_team_list_resp]

		arg_34_0:initGroups(var_34_37)
		lc.sendEvent(Data.Event.union_group_dirty)
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_CREATE_TEAM then
		ClientView.getActiveIndicator():hide()

		local var_34_38 = arg_34_1.Extensions[UnionWar_pb.SglUnionWarMsg.masswar_team_list_resp]

		arg_34_0:initGroups(var_34_38)
		lc.sendEvent(Data.Event.union_group_dirty)
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_START then
		ClientView.getActiveIndicator():hide()

		local var_34_39 = arg_34_1.Extensions[UnionWar_pb.SglUnionWarMsg.masswar_team_list_resp]

		arg_34_0:initGroups(var_34_39)
		lc.sendEvent(Data.Event.union_group_dirty)
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TEAM then
		ClientView.getActiveIndicator():hide()

		arg_34_0._groupId = nil
		arg_34_0._groupJob = nil
		arg_34_0._myGroup = nil

		lc.sendEvent(Data.Event.union_group_dirty)
	end

	return false
end

function var_0_0.createGroup(arg_36_0, arg_36_1, arg_36_2)
	ClientData.sendCreateGroup(arg_36_1, arg_36_2)
end

function var_0_0.joinGroup(arg_37_0, arg_37_1)
	ClientData.sendGroupJoin(arg_37_1)
end

function var_0_0.exitGroup(arg_38_0)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendExitGroup(arg_38_0._groupId)
end

function var_0_0.initGroups(arg_39_0, arg_39_1)
	arg_39_0._groups = {}
	arg_39_0._myGroup = nil
	arg_39_0._groupId = nil
	arg_39_0._groupJob = nil

	if not arg_39_0:getMyUnion() then
		return
	end

	local var_39_0 = arg_39_1.teams

	for iter_39_0 = 1, #var_39_0 do
		local var_39_1 = false
		local var_39_2
		local var_39_3 = var_39_0[iter_39_0].user_info
		local var_39_4 = {}

		for iter_39_1 = 1, #var_39_3 do
			local var_39_5 = var_39_3[iter_39_1]

			if var_39_5.id == P._id then
				var_39_1 = true
				var_39_2 = iter_39_1
			end

			table.insert(var_39_4, require("User").create(var_39_5))
		end

		local var_39_6 = require("Group").create({
			_members = var_39_4,
			_pb = var_39_0[iter_39_0]
		})

		arg_39_0._groups[var_39_6._id] = var_39_6

		if var_39_1 then
			arg_39_0._myGroup = var_39_6
			arg_39_0._groupId = var_39_6._id

			if var_39_2 == 1 then
				arg_39_0._groupJob = Data.GroupJob.leader
			else
				arg_39_0._groupJob = Data.GroupJob.rookie
			end
		end
	end
end

function var_0_0.getUnionUpgradeExp(arg_40_0)
	local var_40_0 = arg_40_0._myUnion
	local var_40_1 = false
	local var_40_2 = -1

	if var_40_0._level >= arg_40_0:getUnionMaxLevel() then
		var_40_1 = true
	else
		var_40_2 = Data._globalInfo._unionLevelupExp[var_40_0._level + 1] - var_40_0._act
	end

	return var_40_1, var_40_2
end

function var_0_0.getUnionMaxLevel(arg_41_0)
	return #Data._globalInfo._unionLevelupExp
end

return var_0_0
