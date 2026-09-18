local var_0_0 = class("Mail")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._id = arg_1_2.id
	arg_1_0._isAttack = arg_1_1
	arg_1_0._type = arg_1_2.battle_type

	if arg_1_2 then
		arg_1_0._timestamp = arg_1_2.timestamp / 1000
		arg_1_0._resultType = arg_1_2.result_type
		arg_1_0._battleType = arg_1_2.battle_type
		arg_1_0._isAvailable = arg_1_2.is_available
		arg_1_0._replayId = arg_1_2.replay_id
		arg_1_0._trophy = arg_1_2.trophy
		arg_1_0._oppoTrophy = arg_1_2.trophy_ex
		arg_1_0._city = arg_1_2.city
		arg_1_0._creator = arg_1_2.creator
		arg_1_0._opponent = require("User").create(arg_1_2.opponent_info)
		arg_1_0._player = require("User").create(arg_1_2.player_info)
	end
end

function var_0_0.isLocal(arg_2_0)
	return arg_2_0._type == Battle_pb.PB_BATTLE_PLAYER
end

return var_0_0
