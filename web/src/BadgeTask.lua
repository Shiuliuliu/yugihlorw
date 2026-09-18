local var_0_0 = class("BadgeTask")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._infoId = arg_1_1.infoId
	arg_1_0._info = Data._battlepassTask[arg_1_1.infoId % 1000 + 1000]
	arg_1_0._isClaimed = arg_1_1.isClaimed
	arg_1_0._value = arg_1_1.value
	arg_1_0._type = arg_1_0._info._type
end

function var_0_0.canClaim(arg_2_0)
	if arg_2_0._value >= arg_2_0._info._value and not arg_2_0._isClaimed then
		return true
	end

	return false
end

function var_0_0.isClaim(arg_3_0)
	return arg_3_0._isClaimed
end

function var_0_0.setClaim(arg_4_0, arg_4_1)
	arg_4_0._isClaimed = arg_4_1
end

function var_0_0.getValue(arg_5_0)
	return arg_5_0._value
end

function var_0_0.getMaxValue(arg_6_0)
	return arg_6_0._info._value
end

return var_0_0
