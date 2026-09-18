local var_0_0 = class("PlayerBadgeEx")
local var_0_1 = require("BadgeTask")

function var_0_0.ctor(arg_1_0)
	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0._grade = arg_4_1.spring_badge_level
	arg_4_0._isBuyBadge = arg_4_1.spring_badge_purchased
	arg_4_0._starNum = arg_4_1.spring_badge_exp
	arg_4_0._starTotal = Data._globalInfo._springBadgeExpPerLevel
	arg_4_0._curStage = arg_4_1.spring_badge_season or 1
	arg_4_0._endTime = arg_4_1.spring_badge_end_timestamp / 1000

	local var_4_0 = {}
	local var_4_1 = {}

	if arg_4_1:HasField("bonus") then
		var_4_0, var_4_1 = arg_4_0:hashPbBonus(arg_4_1.bonus)
	end

	arg_4_0._badgeTask = {}

	for iter_4_0, iter_4_1 in pairs(Data._battlepassTaskEx) do
		local var_4_2 = false
		local var_4_3 = 0

		if var_4_1[iter_4_0] then
			var_4_2 = var_4_1[iter_4_0]
		end

		if var_4_0[iter_4_0] then
			var_4_3 = var_4_0[iter_4_0]
		end

		local var_4_4 = var_0_1.new({
			infoId = iter_4_0,
			isClaimed = var_4_2,
			value = var_4_3
		}, true)

		arg_4_0._badgeTask[iter_4_0] = var_4_4
	end

	arg_4_0:refreshBonusValue()
end

function var_0_0.refreshBonusValue(arg_5_0)
	for iter_5_0 = 1, #P._playerBonus._bonusBadgeEx do
		P._playerBonus._bonusBadgeEx[iter_5_0]:setValue(arg_5_0._grade)
	end
end

function var_0_0.hashPbBonus(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.bonuses) do
		var_6_0[iter_6_1.cid] = iter_6_1.value
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_1.claimed) do
		var_6_1[iter_6_3] = true
	end

	return var_6_0, var_6_1
end

function var_0_0.setBuyBadgeStatus(arg_7_0, arg_7_1)
	arg_7_0._isBuyBadge = arg_7_1
end

function var_0_0.IsBuyBadge(arg_8_0)
	return arg_8_0._isBuyBadge
end

function var_0_0.getGrade(arg_9_0)
	return arg_9_0._grade
end

function var_0_0.addGrade(arg_10_0, arg_10_1)
	arg_10_0._grade = math.min(arg_10_0._grade + arg_10_1, 100)

	arg_10_0:refreshBonusValue()
end

function var_0_0.getCurStarNum(arg_11_0)
	return arg_11_0._starNum
end

function var_0_0.changeStarNum(arg_12_0, arg_12_1)
	arg_12_0._starNum = arg_12_0._starNum + arg_12_1

	while true do
		if arg_12_0._starNum >= arg_12_0._starTotal then
			arg_12_0:addGrade(1)

			if arg_12_0:getGrade() >= 100 then
				arg_12_0._starNum = arg_12_0._starTotal

				break
			else
				arg_12_0._starNum = math.max(arg_12_0._starNum - arg_12_0._starTotal, 0)
			end
		else
			break
		end
	end
end

function var_0_0.getStarTotal(arg_13_0)
	return arg_13_0._starTotal
end

function var_0_0.getCurStage(arg_14_0)
	return arg_14_0._curStage
end

function var_0_0.getDayStar(arg_15_0, arg_15_1)
	local var_15_0 = 0
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in pairs(Data._battlepassTaskEx) do
		if tonumber(iter_15_1._releaseDay) == tonumber(arg_15_1) then
			if arg_15_0._badgeTask[iter_15_0]:isClaim() then
				var_15_0 = var_15_0 + iter_15_1._num
			end

			var_15_1 = var_15_1 + iter_15_1._num
		end
	end

	return var_15_0, var_15_1
end

function var_0_0.getTaskObj(arg_16_0, arg_16_1)
	return arg_16_0._badgeTask[arg_16_1]
end

function var_0_0.getCountDown(arg_17_0)
	local var_17_0 = arg_17_0._endTime - ClientData.getCurrentTime()
	local var_17_1 = math.floor(var_17_0 / 86400)
	local var_17_2 = var_17_0 / 3600

	return var_17_1, var_17_2 + 1
end

function var_0_0.getBadgeClaimFlag(arg_18_0)
	for iter_18_0 = 1, #P._playerBonus._bonusBadgeEx do
		local var_18_0 = P._playerBonus._bonusBadgeEx[iter_18_0]
		local var_18_1 = var_18_0._type

		if var_18_1 == 57 then
			if var_18_0:canClaim() then
				return true
			end
		elseif var_18_1 == 58 and arg_18_0:IsBuyBadge() and var_18_0:canClaim() then
			return true
		end
	end

	return false
end

function var_0_0.getTaskClaimFlag(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._badgeTask) do
		if iter_19_1._type == 1 then
			if iter_19_1:canClaim() then
				return true
			end
		elseif iter_19_1._type == 2 and arg_19_0:IsBuyBadge() and iter_19_1:canClaim() then
			return true
		end
	end

	return false
end

function var_0_0.getOneDayTaskClaimFlag(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._badgeTask) do
		if iter_20_1._type == 1 then
			if tonumber(iter_20_1._info._releaseDay) == tonumber(arg_20_1) and iter_20_1:canClaim() then
				return true
			end
		elseif iter_20_1._type == 2 and arg_20_0:IsBuyBadge() and tonumber(iter_20_1._info._releaseDay) == tonumber(arg_20_1) and iter_20_1:canClaim() then
			return true
		end
	end

	return false
end

function var_0_0.getBadgeBonusFlag(arg_21_0)
	return arg_21_0:getBadgeClaimFlag() or arg_21_0:getTaskClaimFlag()
end

function var_0_0.onMsg(arg_22_0, arg_22_1)
	if arg_22_1.type == SglMsgType_pb.PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS then
		local var_22_0 = arg_22_1.Extensions[Bonus_pb.SglBonusMsg.player_bonus]
		local var_22_1, var_22_2 = arg_22_0:hashPbBonus(var_22_0)

		for iter_22_0, iter_22_1 in pairs(arg_22_0._badgeTask) do
			if var_22_1[iter_22_0] then
				iter_22_1._value = var_22_1[iter_22_0]
			end

			if var_22_2[iter_22_0] ~= nil then
				iter_22_1._isClaimed = var_22_2[iter_22_0]
			end
		end

		lc.sendEvent(Data.Event.badge_reward_ex)

		return false
	end

	return false
end

return var_0_0
