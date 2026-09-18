local var_0_0 = class("UnderAttack")

function var_0_0.ctor(arg_1_0)
	arg_1_0._list = {}
end

function var_0_0.clear(arg_2_0)
	arg_2_0._list = {}
end

function var_0_0.addBattle(arg_3_0, arg_3_1)
	table.insert(arg_3_0._list, {
		_isUnionWar = false,
		_user = require("User").create(arg_3_1.user_info),
		_troop = ClientData.pbTroopToTroop(arg_3_1.troop),
		_isRevenge = arg_3_1.is_revenge or false,
		_isRescue = arg_3_1.is_rescue or false,
		_timestamp = arg_3_1.timestamp
	})
end

function var_0_0.removeBattle(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._list) do
		if iter_4_1._user._id == arg_4_1 and not iter_4_1._isUnionWar then
			table.remove(arg_4_0._list, iter_4_0)

			return iter_4_1
		end
	end
end

function var_0_0.addUnionBattle(arg_5_0, arg_5_1)
	table.insert(arg_5_0._list, {
		_isUnionWar = true,
		_user = require("User").create(arg_5_1.attacker),
		_isRevenge = flase,
		_timestamp = arg_5_1.timestamp
	})
end

function var_0_0.removeUnionBattle(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._list) do
		if iter_6_1._user._id == arg_6_1 and iter_6_1._isUnionWar then
			table.remove(arg_6_0._list, iter_6_0)

			return iter_6_1
		end
	end
end

return var_0_0
