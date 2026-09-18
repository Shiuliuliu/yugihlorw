local var_0_0 = class("PlayerInvite")

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._ingot = 0
	arg_3_0._invitedNum = 0
	arg_3_0._inviter = nil
end

function var_0_0.init(arg_4_0, arg_4_1)
	return
end

function var_0_0.onMsg(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.type
	local var_5_1 = arg_5_1.status

	if var_5_0 == 1 then
		-- block empty
	end

	return false
end
