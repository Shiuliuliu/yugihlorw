local var_0_0 = class("Group")

function var_0_0.create(arg_1_0)
	local var_1_0

	if arg_1_0 then
		var_1_0 = var_0_0.new(arg_1_0)
	end

	return var_1_0
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:updateInfo(arg_2_1)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._members = nil
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1._pb

	arg_4_0._id = var_4_0.id
	arg_4_0._members = arg_4_1._members or {}
	arg_4_0._name = var_4_0.name or "no name"
	arg_4_0._avatar = var_4_0.avatar or 1
	arg_4_0._gameStarted = var_4_0.masswar_started or false
end

function var_0_0.getMembers(arg_5_0)
	return arg_5_0._members
end

return var_0_0
