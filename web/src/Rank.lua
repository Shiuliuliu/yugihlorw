local var_0_0 = class("Rank")

function var_0_0.set(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_2 == SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL or arg_1_2 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_TIME or arg_1_2 == SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY then
		arg_1_0._union = require("Union").create(arg_1_1.union_info)
		arg_1_0._id = arg_1_0._union._id
	elseif arg_1_2 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM or arg_1_2 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM then
		local var_1_0 = arg_1_1.team
		local var_1_1 = var_1_0.user_info
		local var_1_2 = {}

		for iter_1_0 = 1, #var_1_1 do
			local var_1_3 = var_1_1[iter_1_0]

			table.insert(var_1_2, require("User").create(var_1_3))
		end

		arg_1_0._group = require("Group").create({
			_pb = var_1_0,
			_members = var_1_2
		})
	else
		arg_1_0._user = require("User").create(arg_1_1.user_info)
		arg_1_0._id = arg_1_0._user._id
	end

	arg_1_0._value = arg_1_1.value
	arg_1_0._rank = arg_1_1.rank
	arg_1_0._type = arg_1_2
	arg_1_0._subType = arg_1_3
end

return var_0_0
