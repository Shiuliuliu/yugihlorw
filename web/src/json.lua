local var_0_0 = require("math")
local var_0_1 = require("string")
local var_0_2 = require("table")
local var_0_3 = _G

module("json")

local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8
local var_0_9
local var_0_10
local var_0_11
local var_0_12
local var_0_13

function encode(arg_1_0)
	if arg_1_0 == nil then
		return "null"
	end

	local var_1_0 = var_0_3.type(arg_1_0)

	if var_1_0 == "string" then
		return "\"" .. var_0_11(arg_1_0) .. "\""
	end

	if var_1_0 == "number" or var_1_0 == "boolean" then
		return var_0_3.tostring(arg_1_0)
	end

	if var_1_0 == "table" then
		local var_1_1 = {}
		local var_1_2, var_1_3 = var_0_12(arg_1_0)

		if var_1_2 then
			for iter_1_0 = 1, var_1_3 do
				var_0_2.insert(var_1_1, encode(arg_1_0[iter_1_0]))
			end
		else
			for iter_1_1, iter_1_2 in var_0_3.pairs(arg_1_0) do
				if var_0_13(iter_1_1) and var_0_13(iter_1_2) then
					var_0_2.insert(var_1_1, "\"" .. var_0_11(iter_1_1) .. "\":" .. encode(iter_1_2))
				end
			end
		end

		if var_1_2 then
			return "[" .. var_0_2.concat(var_1_1, ",") .. "]"
		else
			return "{" .. var_0_2.concat(var_1_1, ",") .. "}"
		end
	end

	if var_1_0 == "function" and arg_1_0 == null then
		return "null"
	end

	var_0_3.assert(false, "encode attempt to encode unsupported type " .. var_1_0 .. ":" .. var_0_3.tostring(arg_1_0))
end

function decode(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 and arg_2_1 or 1
	arg_2_1 = var_0_10(arg_2_0, arg_2_1)

	var_0_3.assert(arg_2_1 <= var_0_1.len(arg_2_0), "Unterminated JSON encoded object found at position in [" .. arg_2_0 .. "]")

	local var_2_0 = var_0_1.sub(arg_2_0, arg_2_1, arg_2_1)

	if var_2_0 == "{" then
		return var_0_8(arg_2_0, arg_2_1)
	end

	if var_2_0 == "[" then
		return var_0_4(arg_2_0, arg_2_1)
	end

	if var_0_1.find("+-0123456789.e", var_2_0, 1, true) then
		return var_0_7(arg_2_0, arg_2_1)
	end

	if var_2_0 == "\"" or var_2_0 == "'" then
		return var_0_9(arg_2_0, arg_2_1)
	end

	if var_0_1.sub(arg_2_0, arg_2_1, arg_2_1 + 1) == "/*" then
		return decode(arg_2_0, var_0_5(arg_2_0, arg_2_1))
	end

	return var_0_6(arg_2_0, arg_2_1)
end

function null()
	return null
end

function var_0_4(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = var_0_1.len(arg_4_0)

	var_0_3.assert(var_0_1.sub(arg_4_0, arg_4_1, arg_4_1) == "[", "decode_scanArray called but array does not start at position " .. arg_4_1 .. " in string:\n" .. arg_4_0)

	arg_4_1 = arg_4_1 + 1

	repeat
		arg_4_1 = var_0_10(arg_4_0, arg_4_1)

		var_0_3.assert(arg_4_1 <= var_4_1, "JSON String ended unexpectedly scanning array.")

		local var_4_2 = var_0_1.sub(arg_4_0, arg_4_1, arg_4_1)

		if var_4_2 == "]" then
			return var_4_0, arg_4_1 + 1
		end

		if var_4_2 == "," then
			arg_4_1 = var_0_10(arg_4_0, arg_4_1 + 1)
		end

		var_0_3.assert(arg_4_1 <= var_4_1, "JSON String ended unexpectedly scanning array.")

		object, arg_4_1 = decode(arg_4_0, arg_4_1)

		var_0_2.insert(var_4_0, object)
	until false
end

function var_0_5(arg_5_0, arg_5_1)
	var_0_3.assert(var_0_1.sub(arg_5_0, arg_5_1, arg_5_1 + 1) == "/*", "decode_scanComment called but comment does not start at position " .. arg_5_1)

	local var_5_0 = var_0_1.find(arg_5_0, "*/", arg_5_1 + 2)

	var_0_3.assert(var_5_0 ~= nil, "Unterminated comment in string at " .. arg_5_1)

	return var_5_0 + 2
end

function var_0_6(arg_6_0, arg_6_1)
	local var_6_0 = {
		["false"] = false,
		["true"] = true
	}
	local var_6_1 = {
		"true",
		"false",
		"null"
	}

	for iter_6_0, iter_6_1 in var_0_3.pairs(var_6_1) do
		if var_0_1.sub(arg_6_0, arg_6_1, arg_6_1 + var_0_1.len(iter_6_1) - 1) == iter_6_1 then
			return var_6_0[iter_6_1], arg_6_1 + var_0_1.len(iter_6_1)
		end
	end

	var_0_3.assert(nil, "Failed to scan constant from string " .. arg_6_0 .. " at starting position " .. arg_6_1)
end

function var_0_7(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 + 1
	local var_7_1 = var_0_1.len(arg_7_0)
	local var_7_2 = "+-0123456789.e"

	while var_0_1.find(var_7_2, var_0_1.sub(arg_7_0, var_7_0, var_7_0), 1, true) and var_7_0 <= var_7_1 do
		var_7_0 = var_7_0 + 1
	end

	local var_7_3 = "return " .. var_0_1.sub(arg_7_0, arg_7_1, var_7_0 - 1)
	local var_7_4 = var_0_3.loadstring(var_7_3)

	var_0_3.assert(var_7_4, "Failed to scan number [ " .. var_7_3 .. "] in JSON string at position " .. arg_7_1 .. " : " .. var_7_0)

	return var_7_4(), var_7_0
end

function var_0_8(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = var_0_1.len(arg_8_0)
	local var_8_2
	local var_8_3

	var_0_3.assert(var_0_1.sub(arg_8_0, arg_8_1, arg_8_1) == "{", "decode_scanObject called but object does not start at position " .. arg_8_1 .. " in string:\n" .. arg_8_0)

	arg_8_1 = arg_8_1 + 1

	repeat
		arg_8_1 = var_0_10(arg_8_0, arg_8_1)

		var_0_3.assert(arg_8_1 <= var_8_1, "JSON string ended unexpectedly while scanning object.")

		local var_8_4 = var_0_1.sub(arg_8_0, arg_8_1, arg_8_1)

		if var_8_4 == "}" then
			return var_8_0, arg_8_1 + 1
		end

		if var_8_4 == "," then
			arg_8_1 = var_0_10(arg_8_0, arg_8_1 + 1)
		end

		var_0_3.assert(arg_8_1 <= var_8_1, "JSON string ended unexpectedly scanning object.")

		local var_8_5

		var_8_5, arg_8_1 = decode(arg_8_0, arg_8_1)

		var_0_3.assert(arg_8_1 <= var_8_1, "JSON string ended unexpectedly searching for value of key " .. var_8_5)

		arg_8_1 = var_0_10(arg_8_0, arg_8_1)

		var_0_3.assert(arg_8_1 <= var_8_1, "JSON string ended unexpectedly searching for value of key " .. var_8_5)
		var_0_3.assert(var_0_1.sub(arg_8_0, arg_8_1, arg_8_1) == ":", "JSON object key-value assignment mal-formed at " .. arg_8_1)

		arg_8_1 = var_0_10(arg_8_0, arg_8_1 + 1)

		var_0_3.assert(arg_8_1 <= var_8_1, "JSON string ended unexpectedly searching for value of key " .. var_8_5)

		var_8_0[var_8_5], arg_8_1 = decode(arg_8_0, arg_8_1)
	until false
end

function var_0_9(arg_9_0, arg_9_1)
	var_0_3.assert(arg_9_1, "decode_scanString(..) called without start position")

	local var_9_0 = var_0_1.sub(arg_9_0, arg_9_1, arg_9_1)

	var_0_3.assert(var_9_0 == "'" or var_9_0 == "\"", "decode_scanString called for a non-string")

	local var_9_1 = false
	local var_9_2 = arg_9_1 + 1
	local var_9_3 = false
	local var_9_4 = var_0_1.len(arg_9_0)

	repeat
		local var_9_5 = var_0_1.sub(arg_9_0, var_9_2, var_9_2)

		if not var_9_1 then
			if var_9_5 == "\\" then
				var_9_1 = true
			else
				var_9_3 = var_9_5 == var_9_0
			end
		else
			var_9_1 = false
		end

		var_9_2 = var_9_2 + 1

		var_0_3.assert(var_9_2 <= var_9_4 + 1, "String decoding failed: unterminated string at position " .. var_9_2)
	until var_9_3

	local var_9_6 = "return " .. var_0_1.sub(arg_9_0, arg_9_1, var_9_2 - 1)
	local var_9_7 = var_0_3.loadstring(var_9_6)

	var_0_3.assert(var_9_7, "Failed to load string [ " .. var_9_6 .. "] in JSON4Lua.decode_scanString at position " .. arg_9_1 .. " : " .. var_9_2)

	return var_9_7(), var_9_2
end

function var_0_10(arg_10_0, arg_10_1)
	local var_10_0 = " \n\r\t"
	local var_10_1 = var_0_1.len(arg_10_0)

	while var_0_1.find(var_10_0, var_0_1.sub(arg_10_0, arg_10_1, arg_10_1), 1, true) and arg_10_1 <= var_10_1 do
		arg_10_1 = arg_10_1 + 1
	end

	return arg_10_1
end

function var_0_11(arg_11_0)
	arg_11_0 = var_0_1.gsub(arg_11_0, "\\", "\\\\")
	arg_11_0 = var_0_1.gsub(arg_11_0, "\"", "\\\"")
	arg_11_0 = var_0_1.gsub(arg_11_0, "'", "\\'")
	arg_11_0 = var_0_1.gsub(arg_11_0, "\n", "\\n")
	arg_11_0 = var_0_1.gsub(arg_11_0, "\t", "\\t")

	return arg_11_0
end

function var_0_12(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in var_0_3.pairs(arg_12_0) do
		if var_0_3.type(iter_12_0) == "number" and var_0_0.floor(iter_12_0) == iter_12_0 and iter_12_0 >= 1 then
			if not var_0_13(iter_12_1) then
				return false
			end

			var_12_0 = var_0_0.max(var_12_0, iter_12_0)
		elseif iter_12_0 == "n" then
			if iter_12_1 ~= var_0_2.getn(arg_12_0) then
				return false
			end
		elseif var_0_13(iter_12_1) then
			return false
		end
	end

	return true, var_12_0
end

function var_0_13(arg_13_0)
	local var_13_0 = var_0_3.type(arg_13_0)

	return var_13_0 == "string" or var_13_0 == "boolean" or var_13_0 == "number" or var_13_0 == "nil" or var_13_0 == "table" or var_13_0 == "function" and arg_13_0 == null
end
