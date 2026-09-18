local var_0_0 = class("PlayerWorld")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.clear(arg_2_0)
	return
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._curLevel = {}

	for iter_3_0 = 1, #arg_3_1.cur_levels do
		arg_3_0._curLevel[#arg_3_0._curLevel + 1] = arg_3_1.cur_levels[iter_3_0]

		print("@@@@@@@@ LEVEL", arg_3_0._curLevel[iter_3_0])
	end
end

function var_0_0.getChapterProgress(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1 * 100 + arg_4_2
	local var_4_1 = 0
	local var_4_2 = 0
	local var_4_3 = {}

	for iter_4_0, iter_4_1 in pairs(Data._levelInfo) do
		if math.floor(iter_4_1._id / 100) == var_4_0 then
			var_4_1 = var_4_1 + 1

			if iter_4_1._id < arg_4_0._curLevel[arg_4_1] then
				var_4_2 = var_4_2 + 1
			end
		end
	end

	return var_4_1, var_4_2
end

function var_0_0.getLastChapterId(arg_5_0, arg_5_1)
	return arg_5_0._curLevel[arg_5_1] or 0
end

return var_0_0
