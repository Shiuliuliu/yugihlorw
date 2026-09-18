local var_0_0 = class("ActivityTask")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._infoId = arg_1_1
	arg_1_0._info = Data._activityTaskInfo[arg_1_1]

	local var_1_0 = arg_1_0:getBonus()

	if var_1_0 and var_1_0._info._type == 20 then
		var_1_0._task = arg_1_0
	end

	if arg_1_0:isExchangeTask() then
		arg_1_0._resNeed = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_0._info._param) do
			table.insert(arg_1_0._resNeed, {
				_infoId = iter_1_1[1],
				_count = iter_1_1[2]
			})
		end
	end
end

function var_0_0.getBonus(arg_2_0)
	return P._playerBonus._bonuses[arg_2_0._info._bonusId]
end

function var_0_0.getTitle(arg_3_0)
	local var_3_0 = arg_3_0:getBonus()._info

	return Str(var_3_0._nameSid)
end

function var_0_0.exchange(arg_4_0)
	if arg_4_0:isExchangable() then
		local var_4_0 = arg_4_0:getBonus()

		if arg_4_0:isExchangeTask() then
			local var_4_1 = var_4_0._info

			P:addResources(var_4_1._rid, var_4_1._level, var_4_1._count, var_4_1._isFragment)

			for iter_4_0, iter_4_1 in ipairs(arg_4_0._resNeed) do
				local var_4_2 = Data.getType(iter_4_1._infoId)

				if var_4_2 == Data.CardType.res then
					P:changeResource(iter_4_1._infoId, -iter_4_1._count)
				elseif var_4_2 == Data.CardType.props or var_4_2 == Data.CardType.item_skill then
					P._propBag:changeProps(iter_4_1._infoId, -iter_4_1._count)
				end
			end

			ClientData.sendClaimActivityBonus(arg_4_0._infoId)

			if arg_4_0._info._type == Data.ActivityTaskType.exchange_daily or arg_4_0._info._type == Data.ActivityTaskType.exchange_once then
				var_4_0._isClaimed = true
			end
		else
			P._playerBonus:claimBonus(var_4_0._infoId)
		end

		return Data.ErrorType.ok
	end

	return Data.ErrorType.need_more_exchange_res
end

function var_0_0.isExchangeTask(arg_5_0)
	local var_5_0 = arg_5_0._info._type

	return var_5_0 >= Data.ActivityTaskType.exchange_minor and var_5_0 <= Data.ActivityTaskType.exchange_once
end

function var_0_0.isExchangable(arg_6_0)
	if arg_6_0._resNeed then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._resNeed) do
			if P:getItemCount(iter_6_1._infoId) < iter_6_1._count then
				return false
			end
		end

		return true
	end
end

function var_0_0.isValid(arg_7_0)
	return true
end

return var_0_0
