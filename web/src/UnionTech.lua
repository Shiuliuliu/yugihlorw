local var_0_0 = class("UnionTech")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._infoId = arg_1_1
	arg_1_0._info = Data._unionTechInfo[arg_1_1]

	if arg_1_2 then
		arg_1_0:update(arg_1_2)
	else
		arg_1_0._level = 0
	end

	return union
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0._level = arg_2_1.level
end

function var_0_0.getUpgradeRes(arg_3_0)
	local var_3_0 = arg_3_0._info
	local var_3_1 = arg_3_0._level

	return var_3_0._updateUnionCoin[var_3_1 + 1], var_3_0._updateUnionWood[var_3_1 + 1], var_3_0._updateUnionBookNum[var_3_1 + 1]
end

function var_0_0.getUpgradeYubi(arg_4_0)
	return arg_4_0._info._updateCoin[arg_4_0._level + 1]
end

return var_0_0
