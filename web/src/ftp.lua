local var_0_0 = _G
local var_0_1 = require("table")
local var_0_2 = require("string")
local var_0_3 = require("math")
local var_0_4 = require("socket")
local var_0_5 = require("socket.url")
local var_0_6 = require("socket.tp")
local var_0_7 = require("ltn12")

var_0_4.ftp = {}

local var_0_8 = var_0_4.ftp

var_0_8.TIMEOUT = 60
var_0_8.PORT = 21
var_0_8.USER = "ftp"
var_0_8.PASSWORD = "anonymous@anonymous.org"

local var_0_9 = {
	__index = {}
}

function var_0_8.open(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_4.try(var_0_6.connect(arg_1_0, arg_1_1 or var_0_8.PORT, var_0_8.TIMEOUT, arg_1_2))
	local var_1_1 = var_0_0.setmetatable({
		tp = var_1_0
	}, var_0_9)

	var_1_1.try = var_0_4.newtry(function()
		var_1_1:close()
	end)

	return var_1_1
end

function var_0_9.__index.portconnect(arg_3_0)
	arg_3_0.try(arg_3_0.server:settimeout(var_0_8.TIMEOUT))

	arg_3_0.data = arg_3_0.try(arg_3_0.server:accept())

	arg_3_0.try(arg_3_0.data:settimeout(var_0_8.TIMEOUT))
end

function var_0_9.__index.pasvconnect(arg_4_0)
	arg_4_0.data = arg_4_0.try(var_0_4.tcp())

	arg_4_0.try(arg_4_0.data:settimeout(var_0_8.TIMEOUT))
	arg_4_0.try(arg_4_0.data:connect(arg_4_0.pasvt.ip, arg_4_0.pasvt.port))
end

function var_0_9.__index.login(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.try(arg_5_0.tp:command("user", arg_5_1 or var_0_8.USER))

	local var_5_0, var_5_1 = arg_5_0.try(arg_5_0.tp:check({
		"2..",
		331
	}))

	if var_5_0 == 331 then
		arg_5_0.try(arg_5_0.tp:command("pass", arg_5_2 or var_0_8.PASSWORD))
		arg_5_0.try(arg_5_0.tp:check("2.."))
	end

	return 1
end

function var_0_9.__index.pasv(arg_6_0)
	arg_6_0.try(arg_6_0.tp:command("pasv"))

	local var_6_0, var_6_1 = arg_6_0.try(arg_6_0.tp:check("2.."))
	local var_6_2 = "(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)"
	local var_6_3, var_6_4, var_6_5, var_6_6, var_6_7, var_6_8 = var_0_4.skip(2, var_0_2.find(var_6_1, var_6_2))

	arg_6_0.try(var_6_3 and var_6_4 and var_6_5 and var_6_6 and var_6_7 and var_6_8, var_6_1)

	arg_6_0.pasvt = {
		ip = var_0_2.format("%d.%d.%d.%d", var_6_3, var_6_4, var_6_5, var_6_6),
		port = var_6_7 * 256 + var_6_8
	}

	if arg_6_0.server then
		arg_6_0.server:close()

		arg_6_0.server = nil
	end

	return arg_6_0.pasvt.ip, arg_6_0.pasvt.port
end

function var_0_9.__index.port(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.pasvt = nil

	if not arg_7_1 then
		arg_7_1, arg_7_2 = arg_7_0.try(arg_7_0.tp:getcontrol():getsockname())
		arg_7_0.server = arg_7_0.try(var_0_4.bind(arg_7_1, 0))
		arg_7_1, arg_7_2 = arg_7_0.try(arg_7_0.server:getsockname())

		arg_7_0.try(arg_7_0.server:settimeout(var_0_8.TIMEOUT))
	end

	local var_7_0 = var_0_3.mod(arg_7_2, 256)
	local var_7_1 = (arg_7_2 - var_7_0) / 256
	local var_7_2 = var_0_2.gsub(var_0_2.format("%s,%d,%d", arg_7_1, var_7_1, var_7_0), "%.", ",")

	arg_7_0.try(arg_7_0.tp:command("port", var_7_2))
	arg_7_0.try(arg_7_0.tp:check("2.."))

	return 1
end

function var_0_9.__index.send(arg_8_0, arg_8_1)
	arg_8_0.try(arg_8_0.pasvt or arg_8_0.server, "need port or pasv first")

	if arg_8_0.pasvt then
		arg_8_0:pasvconnect()
	end

	local var_8_0 = arg_8_1.argument or var_0_5.unescape(var_0_2.gsub(arg_8_1.path or "", "^[/\\]", ""))

	if var_8_0 == "" then
		var_8_0 = nil
	end

	local var_8_1 = arg_8_1.command or "stor"

	arg_8_0.try(arg_8_0.tp:command(var_8_1, var_8_0))

	local var_8_2, var_8_3 = arg_8_0.try(arg_8_0.tp:check({
		"2..",
		"1.."
	}))

	if not arg_8_0.pasvt then
		arg_8_0:portconnect()
	end

	local var_8_4 = arg_8_1.step or var_0_7.pump.step
	local var_8_5 = {
		arg_8_0.tp.c
	}

	local function var_8_6(arg_9_0, arg_9_1)
		if var_0_4.select(var_8_5, nil, 0)[var_0_6] then
			var_8_2 = arg_8_0.try(arg_8_0.tp:check("2.."))
		end

		return var_8_4(arg_9_0, arg_9_1)
	end

	local var_8_7 = var_0_4.sink("close-when-done", arg_8_0.data)

	arg_8_0.try(var_0_7.pump.all(arg_8_1.source, var_8_7, var_8_6))

	if var_0_2.find(var_8_2, "1..") then
		arg_8_0.try(arg_8_0.tp:check("2.."))
	end

	arg_8_0.data:close()

	local var_8_8 = var_0_4.skip(1, arg_8_0.data:getstats())

	arg_8_0.data = nil

	return var_8_8
end

function var_0_9.__index.receive(arg_10_0, arg_10_1)
	arg_10_0.try(arg_10_0.pasvt or arg_10_0.server, "need port or pasv first")

	if arg_10_0.pasvt then
		arg_10_0:pasvconnect()
	end

	local var_10_0 = arg_10_1.argument or var_0_5.unescape(var_0_2.gsub(arg_10_1.path or "", "^[/\\]", ""))

	if var_10_0 == "" then
		var_10_0 = nil
	end

	local var_10_1 = arg_10_1.command or "retr"

	arg_10_0.try(arg_10_0.tp:command(var_10_1, var_10_0))

	local var_10_2, var_10_3 = arg_10_0.try(arg_10_0.tp:check({
		"1..",
		"2.."
	}))

	if var_10_2 >= 200 and var_10_2 <= 299 then
		arg_10_1.sink(var_10_3)

		return 1
	end

	if not arg_10_0.pasvt then
		arg_10_0:portconnect()
	end

	local var_10_4 = var_0_4.source("until-closed", arg_10_0.data)
	local var_10_5 = arg_10_1.step or var_0_7.pump.step

	arg_10_0.try(var_0_7.pump.all(var_10_4, arg_10_1.sink, var_10_5))

	if var_0_2.find(var_10_2, "1..") then
		arg_10_0.try(arg_10_0.tp:check("2.."))
	end

	arg_10_0.data:close()

	arg_10_0.data = nil

	return 1
end

function var_0_9.__index.cwd(arg_11_0, arg_11_1)
	arg_11_0.try(arg_11_0.tp:command("cwd", arg_11_1))
	arg_11_0.try(arg_11_0.tp:check(250))

	return 1
end

function var_0_9.__index.type(arg_12_0, arg_12_1)
	arg_12_0.try(arg_12_0.tp:command("type", arg_12_1))
	arg_12_0.try(arg_12_0.tp:check(200))

	return 1
end

function var_0_9.__index.greet(arg_13_0)
	local var_13_0 = arg_13_0.try(arg_13_0.tp:check({
		"1..",
		"2.."
	}))

	if var_0_2.find(var_13_0, "1..") then
		arg_13_0.try(arg_13_0.tp:check("2.."))
	end

	return 1
end

function var_0_9.__index.quit(arg_14_0)
	arg_14_0.try(arg_14_0.tp:command("quit"))
	arg_14_0.try(arg_14_0.tp:check("2.."))

	return 1
end

function var_0_9.__index.close(arg_15_0)
	if arg_15_0.data then
		arg_15_0.data:close()
	end

	if arg_15_0.server then
		arg_15_0.server:close()
	end

	return arg_15_0.tp:close()
end

local function var_0_10(arg_16_0)
	if arg_16_0.url then
		local var_16_0 = var_0_5.parse(arg_16_0.url)

		for iter_16_0, iter_16_1 in var_0_0.pairs(arg_16_0) do
			var_16_0[iter_16_0] = iter_16_1
		end

		return var_16_0
	else
		return arg_16_0
	end
end

local function var_0_11(arg_17_0)
	arg_17_0 = var_0_10(arg_17_0)

	var_0_4.try(arg_17_0.host, "missing hostname")

	local var_17_0 = var_0_8.open(arg_17_0.host, arg_17_0.port, arg_17_0.create)

	var_17_0:greet()
	var_17_0:login(arg_17_0.user, arg_17_0.password)

	if arg_17_0.type then
		var_17_0:type(arg_17_0.type)
	end

	var_17_0:pasv()

	local var_17_1 = var_17_0:send(arg_17_0)

	var_17_0:quit()
	var_17_0:close()

	return var_17_1
end

local var_0_12 = {
	scheme = "ftp",
	path = "/"
}

local function var_0_13(arg_18_0)
	local var_18_0 = var_0_4.try(var_0_5.parse(arg_18_0, var_0_12))

	var_0_4.try(var_18_0.scheme == "ftp", "wrong scheme '" .. var_18_0.scheme .. "'")
	var_0_4.try(var_18_0.host, "missing hostname")

	local var_18_1 = "^type=(.)$"

	if var_18_0.params then
		var_18_0.type = var_0_4.skip(2, var_0_2.find(var_18_0.params, var_18_1))

		var_0_4.try(var_18_0.type == "a" or var_18_0.type == "i", "invalid type '" .. var_18_0.type .. "'")
	end

	return var_18_0
end

local function var_0_14(arg_19_0, arg_19_1)
	local var_19_0 = var_0_13(arg_19_0)

	var_19_0.source = var_0_7.source.string(arg_19_1)

	return var_0_11(var_19_0)
end

var_0_8.put = var_0_4.protect(function(arg_20_0, arg_20_1)
	if var_0_0.type(arg_20_0) == "string" then
		return var_0_14(arg_20_0, arg_20_1)
	else
		return var_0_11(arg_20_0)
	end
end)

local function var_0_15(arg_21_0)
	arg_21_0 = var_0_10(arg_21_0)

	var_0_4.try(arg_21_0.host, "missing hostname")

	local var_21_0 = var_0_8.open(arg_21_0.host, arg_21_0.port, arg_21_0.create)

	var_21_0:greet()
	var_21_0:login(arg_21_0.user, arg_21_0.password)

	if arg_21_0.type then
		var_21_0:type(arg_21_0.type)
	end

	var_21_0:pasv()
	var_21_0:receive(arg_21_0)
	var_21_0:quit()

	return var_21_0:close()
end

local function var_0_16(arg_22_0)
	local var_22_0 = var_0_13(arg_22_0)
	local var_22_1 = {}

	var_22_0.sink = var_0_7.sink.table(var_22_1)

	var_0_15(var_22_0)

	return var_0_1.concat(var_22_1)
end

var_0_8.command = var_0_4.protect(function(arg_23_0)
	arg_23_0 = var_0_10(arg_23_0)

	var_0_4.try(arg_23_0.host, "missing hostname")
	var_0_4.try(arg_23_0.command, "missing command")

	local var_23_0 = open(arg_23_0.host, arg_23_0.port, arg_23_0.create)

	var_23_0:greet()
	var_23_0:login(arg_23_0.user, arg_23_0.password)
	var_23_0.try(var_23_0.tp:command(arg_23_0.command, arg_23_0.argument))

	if arg_23_0.check then
		var_23_0.try(var_23_0.tp:check(arg_23_0.check))
	end

	var_23_0:quit()

	return var_23_0:close()
end)
var_0_8.get = var_0_4.protect(function(arg_24_0)
	if var_0_0.type(arg_24_0) == "string" then
		return var_0_16(arg_24_0)
	else
		return var_0_15(arg_24_0)
	end
end)

return var_0_8
