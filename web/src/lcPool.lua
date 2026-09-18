lc = lc or {}

local var_0_0 = lc.Pool or {}

function var_0_0.new(arg_1_0, arg_1_1)
	var_0_0.extend(arg_1_0, arg_1_1)
end

function var_0_0.clear(arg_2_0)
	if var_0_0[arg_2_0] == nil then
		return
	end

	local var_2_0 = var_0_0[arg_2_0]

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1.poolClear then
			iter_2_1:poolClear()
		end
	end

	var_0_0[arg_2_0] = nil
end

function var_0_0.extend(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0[arg_3_0]

	if var_3_0 then
		arg_3_1 = arg_3_1 or var_3_0.extSize
	else
		var_3_0 = {}
		var_0_0[arg_3_0] = var_3_0
		var_3_0.extSize = arg_3_1
	end

	local var_3_1 = #var_3_0
	local var_3_2 = _G[arg_3_0]

	for iter_3_0 = 1, arg_3_1 do
		local var_3_3 = var_3_2.poolCreate()

		table.insert(var_3_0, var_3_3)
	end

	var_3_0.size = var_3_1 + arg_3_1

	lc.log("Pool size of '%s' is extend to %d", arg_3_0, var_3_0.size)
end

function var_0_0.get(arg_4_0, ...)
	local var_4_0 = var_0_0[arg_4_0]

	if var_4_0 == nil then
		return nil
	end

	local var_4_1

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if not iter_4_1._isUsingInPool then
			var_4_1 = iter_4_1

			break
		end
	end

	if var_4_1 == nil then
		var_0_0.extend(arg_4_0)

		var_4_1 = var_4_0[#var_4_0]
	end

	if var_4_1.poolGet then
		var_4_1:poolGet(...)
	end

	var_4_1._isUsingInPool = true

	return var_4_1
end

function var_0_0.free(arg_5_0, ...)
	if not arg_5_0._isUsingInPool then
		return
	end

	if arg_5_0.poolFree then
		arg_5_0:poolFree(...)
	end

	arg_5_0._isUsingInPool = nil
end

lc.Pool = var_0_0

return var_0_0
