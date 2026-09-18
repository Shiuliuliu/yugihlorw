local var_0_0 = "127.0.0.1"
local var_0_1 = 9900
local var_0_2 = ".vscode/launch.json"
local var_0_3 = io.open(var_0_2, "r")

if var_0_3 then
	local var_0_4 = ""
	local var_0_5 = {}

	for iter_0_0 in io.lines(var_0_2) do
		if not string.find(iter_0_0, "//") then
			var_0_5[#var_0_5 + 1] = iter_0_0
		end
	end

	local var_0_6 = table.concat(var_0_5)
	local var_0_7 = require("cjson").decode(var_0_6)

	for iter_0_1, iter_0_2 in ipairs(var_0_7.configurations) do
		if iter_0_2.type == "emmylua_new" then
			print("[LuaDebug Host Port]", iter_0_2.host, iter_0_2.port)

			var_0_0 = iter_0_2.host or var_0_0
			var_0_1 = iter_0_2.port or var_0_1
		end
	end

	io.close(var_0_3)
end

xpcall(function()
	print("[LuaDebug] LuaDebug HOST PORT", var_0_0, var_0_1)

	package.cpath = string.format("%s;%s", package.cpath, "../../../?.dll")

	local var_1_0 = require("emmy_core")

	var_1_0.tcpConnect(var_0_0, var_0_1)
	var_1_0.tcpConnect(var_0_0, var_0_1)
	print("[LuaDebug] LuaDebug server connect success")
end, function(arg_2_0)
	print("[LuaDebug] LuaDebug server connect failed: \n" .. arg_2_0)
end)
