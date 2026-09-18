local var_0_0 = class("ServerBonus")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._id = arg_1_1.id
	arg_1_0._timestamp = arg_1_1.timestamp / 1000
	arg_1_0._isClaimed = arg_1_1.claimed
	arg_1_0._value = 0
	arg_1_0._infoId = arg_1_1.info_id

	if arg_1_1:HasField("title") then
		arg_1_0._title = arg_1_1.title
	end

	if arg_1_1:HasField("extra") then
		arg_1_0._extraBonus = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_1.extra.resources) do
			table.insert(arg_1_0._extraBonus, {
				_infoId = iter_1_1.info_id,
				_count = iter_1_1.num,
				_level = iter_1_1._level,
				_isFragment = iter_1_1.is_fragment
			})
		end
	else
		arg_1_0._info = Data._bonusInfo[arg_1_0._infoId]
	end
end

function var_0_0.sendBonusDirty(arg_2_0)
	return
end

function var_0_0.canClaim(arg_3_0)
	return true
end

return var_0_0
