local var_0_0 = class("UnionBoss")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._id = arg_1_1
	arg_1_0._scores = {}
	arg_1_0._counts = {}
	arg_1_0._info = Data._unionBossInfo[arg_1_1]
	arg_1_0._hp = 0
	arg_1_0._killedCount = 0
	arg_1_0._isLocked = true
	arg_1_0._assistants = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._info._assistant) do
		if iter_1_1 > 0 then
			local var_1_0 = require("Card").create(iter_1_1)

			var_1_0._curHp = var_1_0:getHp()

			table.insert(arg_1_0._assistants, var_1_0)
		end
	end

	if arg_1_2 then
		arg_1_0:update(arg_1_2)
	end

	return union
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0._hp = arg_2_1.hp
	arg_2_0._killedCount = arg_2_1.killed_count

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.score) do
		arg_2_0._scores[iter_2_1.id] = iter_2_1.score
		arg_2_0._counts[iter_2_1.id] = iter_2_1.count
	end

	arg_2_0._isLocked = arg_2_0._hp == 0

	for iter_2_2, iter_2_3 in ipairs(arg_2_0._assistants) do
		iter_2_3._curHp = arg_2_0._isLocked and iter_2_3:getHp() or arg_2_1.assistant[iter_2_2]
	end
end

function var_0_0.unlock(arg_3_0)
	arg_3_0._hp = arg_3_0._info._hp
	arg_3_0._isLocked = false
	arg_3_0._scores = {}
	arg_3_0._counts = {}
end

function var_0_0.hurt(arg_4_0, arg_4_1)
	arg_4_0._hp = arg_4_0._hp - arg_4_1

	if arg_4_0._hp <= 0 then
		arg_4_0._killedCount = arg_4_0._killedCount + 1
		arg_4_0._hp = 0
		arg_4_0._isLocked = true

		for iter_4_0, iter_4_1 in ipairs(arg_4_0._assistants) do
			iter_4_1._curHp = iter_4_1:getHp()
		end
	end
end

function var_0_0.hurtAssistant(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._assistants) do
		iter_5_1._curHp = iter_5_1._curHp - arg_5_1[iter_5_0]

		if iter_5_1._curHp <= 0 then
			iter_5_1._curHp = 0
		end
	end
end

return var_0_0
