local var_0_0 = _G
local var_0_1 = require("string")
local var_0_2 = require("socket")
local var_0_3 = require("ltn12")

var_0_2.tp = {}

local var_0_4 = var_0_2.tp

var_0_4.TIMEOUT = 60

local function var_0_5(arg_1_0)
	local var_1_0
	local var_1_1
	local var_1_2
	local var_1_3, var_1_4 = arg_1_0:receive()
	local var_1_5 = var_1_3

	if var_1_4 then
		return nil, var_1_4
	end

	local var_1_6, var_1_7 = var_0_2.skip(2, var_0_1.find(var_1_3, "^(%d%d%d)(.?)"))

	if not var_1_6 then
		return nil, "invalid server reply"
	end

	if var_1_7 == "-" then
		repeat
			local var_1_8, var_1_9 = arg_1_0:receive()

			if var_1_9 then
				return nil, var_1_9
			end

			local var_1_10, var_1_11 = var_0_2.skip(2, var_0_1.find(var_1_8, "^(%d%d%d)(.?)"))

			var_1_5 = var_1_5 .. "\n" .. var_1_8
		until var_1_6 == var_1_10 and var_1_11 == " "
	end

	return var_1_6, var_1_5
end

local var_0_6 = {
	__index = {}
}

function var_0_6.__index.check(arg_2_0, arg_2_1)
	local var_2_0, var_2_1 = var_0_5(arg_2_0.c)

	if not var_2_0 then
		return nil, var_2_1
	end

	if var_0_0.type(arg_2_1) ~= "function" then
		if var_0_0.type(arg_2_1) == "table" then
			for iter_2_0, iter_2_1 in var_0_0.ipairs(arg_2_1) do
				if var_0_1.find(var_2_0, iter_2_1) then
					return var_0_0.tonumber(var_2_0), var_2_1
				end
			end

			return nil, var_2_1
		elseif var_0_1.find(var_2_0, arg_2_1) then
			return var_0_0.tonumber(var_2_0), var_2_1
		else
			return nil, var_2_1
		end
	else
		return arg_2_1(var_0_0.tonumber(var_2_0), var_2_1)
	end
end

function var_0_6.__index.command(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1 = var_0_1.upper(arg_3_1)

	if arg_3_2 then
		return arg_3_0.c:send(arg_3_1 .. " " .. arg_3_2 .. "\r\n")
	else
		return arg_3_0.c:send(arg_3_1 .. "\r\n")
	end
end

function var_0_6.__index.sink(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = c:receive(arg_4_2)

	return arg_4_1(var_4_0, var_4_1)
end

function var_0_6.__index.send(arg_5_0, arg_5_1)
	return arg_5_0.c:send(arg_5_1)
end

function var_0_6.__index.receive(arg_6_0, arg_6_1)
	return arg_6_0.c:receive(arg_6_1)
end

function var_0_6.__index.getfd(arg_7_0)
	return arg_7_0.c:getfd()
end

function var_0_6.__index.dirty(arg_8_0)
	return arg_8_0.c:dirty()
end

function var_0_6.__index.getcontrol(arg_9_0)
	return arg_9_0.c
end

function var_0_6.__index.source(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = var_0_2.sink("keep-open", arg_10_0.c)
	local var_10_1, var_10_2 = var_0_3.pump.all(arg_10_1, var_10_0, arg_10_2 or var_0_3.pump.step)

	return var_10_1, var_10_2
end

function var_0_6.__index.close(arg_11_0)
	arg_11_0.c:close()

	return 1
end

function var_0_4.connect(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0, var_12_1 = (arg_12_3 or var_0_2.tcp)()

	if not var_12_0 then
		return nil, var_12_1
	end

	var_12_0:settimeout(arg_12_2 or var_0_4.TIMEOUT)

	local var_12_2, var_12_3 = var_12_0:connect(arg_12_0, arg_12_1)

	if not var_12_2 then
		var_12_0:close()

		return nil, var_12_3
	end

	return var_0_0.setmetatable({
		c = var_12_0
	}, var_0_6)
end

return var_0_4
