function clone(arg_1_0)
	local var_1_0 = {}

	local function var_1_1(arg_2_0)
		if type(arg_2_0) ~= "table" then
			return arg_2_0
		elseif var_1_0[arg_2_0] then
			return var_1_0[arg_2_0]
		end

		local var_2_0 = {}

		var_1_0[arg_2_0] = var_2_0

		for iter_2_0, iter_2_1 in pairs(arg_2_0) do
			var_2_0[var_1_1(iter_2_0)] = var_1_1(iter_2_1)
		end

		return setmetatable(var_2_0, getmetatable(arg_2_0))
	end

	return var_1_1(arg_1_0)
end

function class(arg_3_0, arg_3_1)
	local var_3_0 = type(arg_3_1)
	local var_3_1

	if var_3_0 ~= "function" and var_3_0 ~= "table" then
		var_3_0 = nil
		arg_3_1 = nil
	end

	if var_3_0 == "function" or arg_3_1 and arg_3_1.__ctype == 1 then
		var_3_1 = {}

		if var_3_0 == "table" then
			for iter_3_0, iter_3_1 in pairs(arg_3_1) do
				var_3_1[iter_3_0] = iter_3_1
			end

			var_3_1.__create = arg_3_1.__create
			var_3_1.super = arg_3_1
		else
			var_3_1.__create = arg_3_1
		end

		function var_3_1.ctor()
			return
		end

		var_3_1.__cname = arg_3_0
		var_3_1.__ctype = 1

		function var_3_1.new(...)
			local var_5_0 = var_3_1.__create(...)

			for iter_5_0, iter_5_1 in pairs(var_3_1) do
				var_5_0[iter_5_0] = iter_5_1
			end

			var_5_0.class = var_3_1

			var_5_0:ctor(...)

			return var_5_0
		end
	else
		if arg_3_1 then
			var_3_1 = clone(arg_3_1)
			var_3_1.super = arg_3_1
		else
			var_3_1 = {
				ctor = function()
					return
				end
			}
		end

		var_3_1.__cname = arg_3_0
		var_3_1.__ctype = 2
		var_3_1.__index = var_3_1

		function var_3_1.new(...)
			local var_7_0 = setmetatable({}, var_3_1)

			var_7_0.class = var_3_1

			var_7_0:ctor(...)

			return var_7_0
		end
	end

	return var_3_1
end

function schedule(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = cc.DelayTime:create(arg_8_2)
	local var_8_1 = cc.Sequence:create(var_8_0, cc.CallFunc:create(arg_8_1))
	local var_8_2 = cc.RepeatForever:create(var_8_1)

	arg_8_0:runAction(var_8_2)

	return var_8_2
end

function performWithDelay(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2 = tonumber(arg_9_2) or 0.01
	local var_9_0 = cc.DelayTime:create(arg_9_2)
	local var_9_1 = cc.Sequence:create(var_9_0, cc.CallFunc:create(arg_9_1))

	arg_9_0:runAction(var_9_1)

	return var_9_1
end
