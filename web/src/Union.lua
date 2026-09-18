local var_0_0 = class("Union")

var_0_0.Unions = {}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_0.member == 0 then
		return nil
	end

	local var_1_0

	if var_0_0.Unions[arg_1_0.id] then
		var_1_0 = var_0_0.Unions[arg_1_0.id]
	else
		var_1_0 = var_0_0.new(arg_1_0.id)
		var_1_0._members = {}
		var_1_0._dailyContributes = {}
		var_1_0._weeklyContributes = {}
		var_1_0._dailyActivePoints = {}
		var_1_0._hires = {}
		var_1_0._bosses = {}
		var_1_0._techs = {}
		var_1_0._impeach = {}
	end

	var_1_0:updateInfo(arg_1_0, arg_1_2 ~= nil)

	if arg_1_1 and arg_1_1 then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
			local var_1_1 = require("User").create(iter_1_1, true)

			var_1_0._members[var_1_1._id] = var_1_1
		end
	end

	if arg_1_2 then
		local var_1_2 = arg_1_2.weekly_donates
		local var_1_3 = arg_1_2.daily_donates

		if var_1_2 and var_1_3 then
			local var_1_4 = var_1_0._weeklyContributes

			for iter_1_2, iter_1_3 in ipairs(var_1_2) do
				var_1_4[iter_1_3.id] = var_1_0:genContribution(iter_1_3.exp)
			end

			local var_1_5 = var_1_0._dailyContributes

			for iter_1_4, iter_1_5 in ipairs(var_1_3) do
				var_1_5[iter_1_5.id] = var_1_0:genContribution(iter_1_5.exp)
			end

			local var_1_6 = var_1_0._dailyActivePoints

			for iter_1_6, iter_1_7 in ipairs(var_1_3) do
				var_1_6[iter_1_7.id] = var_1_0:genActivePoint(iter_1_7.power)

				if P._id == iter_1_7.id then
					P._playerUnion._myActivityPoint = iter_1_7.power
				end
			end
		end

		local var_1_7 = arg_1_2.lets

		if var_1_7 then
			for iter_1_8, iter_1_9 in ipairs(var_1_7) do
				var_1_0:addHire(iter_1_9)
			end
		end

		var_1_0:updateBosses(arg_1_2.data.bosses, arg_1_2.focuses)
		var_1_0:updateTechs(arg_1_2.data.techs)
		var_1_0:updateImpeach(arg_1_2.impeaches)

		local var_1_8 = arg_1_2.data.props

		if var_1_8 then
			for iter_1_10, iter_1_11 in ipairs(var_1_8) do
				P._propBag:setProps(iter_1_11.info_id, iter_1_11.num)
			end
		end
	end

	return var_1_0
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._id = arg_2_1
	var_0_0.Unions[arg_2_1] = arg_2_0
end

function var_0_0.clear(arg_3_0)
	var_0_0.Unions[arg_3_0._id] = nil
end

function var_0_0.updateInfo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._id = arg_4_1.id
	arg_4_0._name = arg_4_1.name
	arg_4_0._level = arg_4_1.level
	arg_4_0._reqLevel = arg_4_1.required_level
	arg_4_0._joinType = arg_4_1.type
	arg_4_0._badge = arg_4_1.avatar
	arg_4_0._word = arg_4_1.tag
	arg_4_0._memberNum = arg_4_1.member
	arg_4_0._memberCapacity = 20 + 2 * (arg_4_0._level - 1)
	arg_4_0._announce = arg_4_1.announcement or ""

	if arg_4_2 then
		arg_4_0._gold = arg_4_1.gold
		arg_4_0._wood = arg_4_1.wood
		arg_4_0._act = arg_4_1.exp or 0
	end
end

function var_0_0.updateBosses(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 then
		for iter_5_0, iter_5_1 in pairs(Data._unionBossInfo) do
			arg_5_0:addBoss(iter_5_0)
		end

		for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
			local var_5_0 = arg_5_0._bosses[iter_5_3.id]

			if var_5_0 then
				var_5_0:update(iter_5_3)
			end
		end

		for iter_5_4, iter_5_5 in pairs(arg_5_0._bosses) do
			local var_5_1 = arg_5_0._bosses[iter_5_4 - 1]
			local var_5_2

			if var_5_1 then
				var_5_2 = var_5_1._killedCount > 0
			else
				var_5_2 = true
			end

			iter_5_5._isActive = var_5_2
		end

		if arg_5_2 then
			for iter_5_6, iter_5_7 in ipairs(arg_5_2) do
				arg_5_0._bosses[iter_5_7.id]._attacker = arg_5_0._members[iter_5_7.info.id]
			end
		end
	end
end

function var_0_0.updateTechs(arg_6_0, arg_6_1)
	if arg_6_1 then
		for iter_6_0, iter_6_1 in pairs(Data._unionTechInfo) do
			arg_6_0:addTech(iter_6_0)
		end

		for iter_6_2, iter_6_3 in ipairs(arg_6_1) do
			arg_6_0._techs[iter_6_3.id]:update(iter_6_3)
		end

		for iter_6_4, iter_6_5 in pairs(arg_6_0._techs) do
			if iter_6_5._level == 0 then
				if iter_6_5._info._unlockLevel <= arg_6_0._level then
					iter_6_5._level = 1
				end
			elseif iter_6_5._info._unlockLevel > arg_6_0._level then
				iter_6_5._level = 0
			end
		end
	end
end

function var_0_0.updateImpeach(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0._impeach = {}

		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			if arg_7_0._members[iter_7_1] then
				arg_7_0._impeach[iter_7_1] = true
			end
		end
	end
end

function var_0_0.addHire(arg_8_0, arg_8_1)
	local var_8_0 = require("HireHero").new(arg_8_1)

	arg_8_0._hires[var_8_0._guid] = var_8_0

	return var_8_0
end

function var_0_0.setAllHired(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._hires) do
		if iter_9_1._ownerId == arg_9_1 then
			iter_9_1._isHired = true
		end
	end
end

function var_0_0.genContribution(arg_10_0, arg_10_1)
	return {
		[Data.ResType.union_act] = arg_10_1 or 0
	}
end

function var_0_0.genActivePoint(arg_11_0, arg_11_1)
	return {
		[Data.ResType.union_personal_power] = arg_11_1 or 0
	}
end

function var_0_0.contribute(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0, var_12_1 = arg_12_0:getContribution(arg_12_1)

	var_12_0[arg_12_2] = var_12_0[arg_12_2] + arg_12_3
	var_12_1[arg_12_2] = var_12_1[arg_12_2] + arg_12_3
end

function var_0_0.getActivePoint(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._dailyActivePoints[arg_13_1]

	if var_13_0 == nil then
		var_13_0 = arg_13_0:genActivePoint()
		arg_13_0._dailyActivePoints[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.getContribution(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._dailyContributes[arg_14_1]

	if var_14_0 == nil then
		var_14_0 = arg_14_0:genContribution()
		arg_14_0._dailyContributes[arg_14_1] = var_14_0
	end

	local var_14_1 = arg_14_0._weeklyContributes[arg_14_1]

	if var_14_1 == nil then
		var_14_1 = arg_14_0:genContribution()
		arg_14_0._weeklyContributes[arg_14_1] = var_14_1
	end

	return var_14_0, var_14_1
end

function var_0_0.getMembersNum(arg_15_0)
	return arg_15_0._memberNum
end

function var_0_0.getMembers(arg_16_0)
	local var_16_0 = {}

	if arg_16_0._members ~= nil then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._members) do
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function var_0_0.addMember(arg_17_0, arg_17_1)
	if arg_17_0._members[arg_17_1._id] == nil then
		arg_17_0._members[arg_17_1._id] = arg_17_1
		arg_17_0._memberNum = arg_17_0._memberNum + 1

		lc.sendEvent(Data.Event.union_member_dirty)
	end
end

function var_0_0.removeMember(arg_18_0, arg_18_1)
	if arg_18_0._members[arg_18_1] then
		arg_18_0._members[arg_18_1] = nil
		arg_18_0._memberNum = arg_18_0._memberNum - 1

		local var_18_0

		for iter_18_0, iter_18_1 in pairs(arg_18_0._hires) do
			if iter_18_1._ownerId == arg_18_1 then
				arg_18_0._hires[iter_18_1._guid] = nil
				var_18_0 = true
			end
		end

		if var_18_0 then
			lc.sendEvent(Data.Event.union_hires_dirty)
		end

		lc.sendEvent(Data.Event.union_member_dirty)
	end
end

function var_0_0.findMember(arg_19_0, arg_19_1)
	if arg_19_0._members == nil then
		return nil
	end

	return arg_19_0._members[arg_19_1]
end

function var_0_0.getMaxLevel(arg_20_0)
	return #Data._globalInfo._unionLevelupExp
end

function var_0_0.upgrade(arg_21_0)
	if arg_21_0._act then
		arg_21_0._act = arg_21_0._act - arg_21_0:getLevelupAct()

		arg_21_0:sendUnionResDirty()
	end

	arg_21_0._level = arg_21_0._level + 1
	arg_21_0._memberCapacity = arg_21_0._memberCapacity < 28 and arg_21_0._memberCapacity + 2 or 30
end

function var_0_0.getLevelupGold(arg_22_0)
	return Data._globalInfo._unionLevelupGold[arg_22_0._level + 1]
end

function var_0_0.getLevelupWood(arg_23_0)
	return Data._globalInfo._unionLevelupWood[arg_23_0._level + 1]
end

function var_0_0.getLevelupAct(arg_24_0)
	return Data._globalInfo._unionLevelupExp[arg_24_0._level + 1]
end

function var_0_0.addBoss(arg_25_0, arg_25_1)
	local var_25_0 = require("UnionBoss").new(arg_25_1)

	arg_25_0._bosses[arg_25_1] = var_25_0

	return var_25_0
end

function var_0_0.unlockBoss(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._bosses[arg_26_1]

	if var_26_0 then
		var_26_0:unlock()

		arg_26_0._act = arg_26_0._act - var_26_0._info._unlockRes

		arg_26_0:sendUnionResDirty(Data.ResType.union_act)
	end
end

function var_0_0.getMemberBossScore(arg_27_0, arg_27_1, arg_27_2)
	return arg_27_0._bosses[arg_27_2]._scores[arg_27_1] or 0
end

function var_0_0.getMemberBossCount(arg_28_0, arg_28_1, arg_28_2)
	return arg_28_0._bosses[arg_28_2]._counts[arg_28_1] or 0
end

function var_0_0.addTech(arg_29_0, arg_29_1)
	local var_29_0 = require("UnionTech").new(arg_29_1)

	arg_29_0._techs[arg_29_1] = var_29_0

	return var_29_0
end

function var_0_0.upgradeTech(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0._techs[arg_30_1]
	local var_30_1, var_30_2, var_30_3 = var_30_0:getUpgradeRes()

	if arg_30_2 then
		if var_30_1 > arg_30_0._gold then
			return Data.ErrorType.need_more_union_gold
		end

		if var_30_2 > arg_30_0._wood then
			return Data.ErrorType.need_more_union_wood
		end

		if var_30_3 > P:getItemCount(var_30_0._info._updateUnionBook) then
			return Data.ErrorType.need_more_union_tech_res
		end
	else
		if arg_30_0._gold then
			arg_30_0._gold = arg_30_0._gold - var_30_1
			arg_30_0._wood = arg_30_0._wood - var_30_2
		end

		P._propBag:changeProps(var_30_0._info._updateUnionBook, -var_30_3)

		var_30_0._level = var_30_0._level + 1

		lc.sendEvent(Data.Event.union_tech_dirty, var_30_0)
	end

	return Data.ErrorType.ok
end

function var_0_0.sendUnionDirty(arg_31_0)
	local var_31_0 = cc.EventCustom:new(Data.Event.union_dirty)

	var_31_0._data = arg_31_0

	lc.Dispatcher:dispatchEvent(var_31_0)
end

function var_0_0.sendUnionResDirty(arg_32_0, arg_32_1)
	local var_32_0 = cc.EventCustom:new(Data.Event.union_res_dirty)

	var_32_0._infoId = arg_32_1

	lc.Dispatcher:dispatchEvent(var_32_0)
end

return var_0_0
