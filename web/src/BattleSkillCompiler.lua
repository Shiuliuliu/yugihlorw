local var_0_0 = PlayerBattle

BaseNode = class("BaseNode")

function BaseNode.ctor(arg_1_0, arg_1_1)
	arg_1_0._card = arg_1_1
	arg_1_0._type = 0
	arg_1_0._subNodes = {}
end

BoolNode = class("BoolNode", BaseNode)
FuncNode = class("FuncNode", BaseNode)
NumberNode = class("NumberNode", BaseNode)
PropNode = class("PropNode", BaseNode)

local var_0_1 = {
	B = BoolNode,
	F = FuncNode,
	N = NumberNode,
	P = PropNode
}

BoolNode.TYPE_COMPARE = 1
BoolNode.TYPE_BOOLS = 2

function BoolNode.ctor(arg_2_0, arg_2_1)
	BoolNode.super.ctor(arg_2_0, arg_2_1)

	arg_2_0._compareOp = nil
	arg_2_0._boolOps = {}
end

function BoolNode.value(arg_3_0, arg_3_1)
	if arg_3_0._type == BoolNode.TYPE_COMPARE then
		if arg_3_0._subNodes[1]._subNodes[1] ~= nil and arg_3_0._subNodes[1]._subNodes[1]._type == "K" then
			if arg_3_0._compareOp == "==" then
				arg_3_0._value = arg_3_1:isKeyword(arg_3_0._subNodes[2]:value(arg_3_1))
			elseif arg_3_0._compareOp == "!=" then
				arg_3_0._value = not arg_3_1:isKeyword(arg_3_0._subNodes[2]:value(arg_3_1))
			end
		elseif arg_3_0._subNodes[1]._subNodes[1] ~= nil and arg_3_0._subNodes[1]._subNodes[1]._type == "N" then
			if arg_3_0._compareOp == "==" then
				arg_3_0._value = arg_3_1:isNature(arg_3_0._subNodes[2]:value(arg_3_1))
			elseif arg_3_0._compareOp == "!=" then
				arg_3_0._value = not arg_3_1:isNature(arg_3_0._subNodes[2]:value(arg_3_1))
			end
		elseif arg_3_0._subNodes[1]._subNodes[1] ~= nil and arg_3_0._subNodes[1]._subNodes[1]._type == "E" then
			if arg_3_0._compareOp == "==" then
				if arg_3_0._subNodes[2]:value(arg_3_1) == 0 then
					arg_3_0._value = arg_3_1:isNormalMonster()
				else
					arg_3_0._value = arg_3_1:isEffectMonster()
				end
			elseif arg_3_0._compareOp == "!=" then
				if arg_3_0._subNodes[2]:value(arg_3_1) == 0 then
					arg_3_0._value = arg_3_1:isEffectMonster()
				else
					arg_3_0._value = arg_3_1:isNormalMonster()
				end
			end
		else
			arg_3_0._value = BoolNode.calCompare(arg_3_0._subNodes[1]:value(arg_3_1), arg_3_0._compareOp, arg_3_0._subNodes[2]:value(arg_3_1))
		end
	elseif arg_3_0._type == BoolNode.TYPE_BOOLS then
		arg_3_0._value = arg_3_0._subNodes[1]:value(arg_3_1)

		for iter_3_0 = 1, #arg_3_0._boolOps do
			arg_3_0._value = BoolNode.calBool(arg_3_0._value, arg_3_0._boolOps[iter_3_0], arg_3_0._subNodes[iter_3_0 + 1]:value(arg_3_1))
		end
	end

	return arg_3_0._value
end

function BoolNode.compile(arg_4_0, arg_4_1)
	arg_4_0 = var_0_0.trimParenthesis(arg_4_0)

	local var_4_0 = BoolNode.new(arg_4_1)

	var_0_0.dumpCompile("[B]", arg_4_0)

	local var_4_1, var_4_2 = var_0_0.splitStringWithParenthesis(arg_4_0, "[&|][&|]")

	if #var_4_1 > 1 then
		var_4_0._type = BoolNode.TYPE_BOOLS

		for iter_4_0 = 1, #var_4_1 do
			var_4_0._subNodes[#var_4_0._subNodes + 1] = BoolNode.compile(var_4_1[iter_4_0], arg_4_1)
			var_4_0._boolOps[#var_4_0._boolOps + 1] = var_4_2[iter_4_0]
		end
	else
		var_4_0._type = BoolNode.TYPE_COMPARE

		local var_4_3, var_4_4 = var_0_0.splitStringWithParenthesis(arg_4_0, "[=!><]=?")

		if #var_4_3 ~= 2 then
			var_0_0.error("[B] Invalid compare format:", arg_4_0)
		end

		for iter_4_1 = 1, 2 do
			var_4_0._subNodes[#var_4_0._subNodes + 1] = NumberNode.compile(var_4_3[iter_4_1], arg_4_1)
		end

		var_4_0._compareOp = var_4_4[1]
	end

	return var_4_0
end

function BoolNode.calCompare(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0 == nil then
		arg_5_0 = 0
	end

	if arg_5_2 == nil then
		arg_5_2 = 0
	end

	if arg_5_1 == "==" then
		return arg_5_0 == arg_5_2
	elseif arg_5_1 == "!=" then
		return arg_5_0 ~= arg_5_2
	elseif arg_5_1 == ">=" then
		return arg_5_2 <= arg_5_0
	elseif arg_5_1 == "<=" then
		return arg_5_0 <= arg_5_2
	elseif arg_5_1 == "<" then
		return arg_5_0 < arg_5_2
	elseif arg_5_1 == ">" then
		return arg_5_2 < arg_5_0
	end
end

function BoolNode.calBool(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == "&&" then
		return arg_6_0 and arg_6_2
	elseif arg_6_1 == "||" then
		return arg_6_0 or arg_6_2
	end
end

NumberNode.TYPE_DIGITS = 1
NumberNode.TYPE_EQUATION = 2
NumberNode.TYPE_FUNC = 3
NumberNode.TYPE_PROP = 4
NumberNode.TYPE_TRIPLE = 5
NumberNode.TYPE_NIL = 6

function NumberNode.ctor(arg_7_0, arg_7_1)
	NumberNode.super.ctor(arg_7_0, arg_7_1)

	arg_7_0._number = nil
	arg_7_0._calcOps = {}
end

function NumberNode.value(arg_8_0, arg_8_1)
	if arg_8_0._type == NumberNode.TYPE_DIGITS then
		arg_8_0._value = arg_8_0._number
	elseif arg_8_0._type == NumberNode.TYPE_EQUATION then
		local var_8_0 = 0
		local var_8_1 = "+"
		local var_8_2
		local var_8_3

		for iter_8_0 = 1, #arg_8_0._calcOps + 1 do
			local var_8_4 = arg_8_0._calcOps[iter_8_0] or "+"

			if var_8_4 == "+" or var_8_4 == "-" then
				if var_8_3 == nil then
					var_8_0 = NumberNode.calcNumber(var_8_0, var_8_1, arg_8_0._subNodes[iter_8_0]:value(arg_8_1))
				else
					var_8_2 = NumberNode.calcNumber(var_8_2, var_8_3, arg_8_0._subNodes[iter_8_0]:value(arg_8_1))
					var_8_3 = nil
					var_8_0 = NumberNode.calcNumber(var_8_0, var_8_1, var_8_2)
				end

				var_8_1 = var_8_4
			else
				var_8_2 = var_8_3 ~= nil and NumberNode.calcNumber(var_8_2, var_8_3, arg_8_0._subNodes[iter_8_0]:value(arg_8_1)) or arg_8_0._subNodes[iter_8_0]:value(arg_8_1)
				var_8_3 = var_8_4
			end
		end

		arg_8_0._value = var_8_0
	elseif arg_8_0._type == NumberNode.TYPE_TRIPLE then
		arg_8_0._value = NumberNode.calcTriple(arg_8_0._subNodes[1]:value(arg_8_1), arg_8_0._subNodes[2]:value(arg_8_1), arg_8_0._subNodes[3]:value(arg_8_1))
	elseif arg_8_0._type == NumberNode.TYPE_NIL then
		arg_8_0._value = nil
	elseif arg_8_0._type == NumberNode.TYPE_FUNC then
		arg_8_0._value = arg_8_0._subNodes[1]:value(arg_8_1)
	elseif arg_8_0._type == NumberNode.TYPE_PROP then
		arg_8_0._value = arg_8_0._subNodes[1]:value(arg_8_1)
	end

	return arg_8_0._value
end

function NumberNode.compile(arg_9_0, arg_9_1)
	arg_9_0 = var_0_0.trimParenthesis(arg_9_0)

	local var_9_0 = NumberNode.new(arg_9_1)

	var_0_0.dumpCompile("[N]", arg_9_0)

	if arg_9_0 == "nil" then
		var_9_0._type = NumberNode.TYPE_NIL
		var_9_0._value = nil
	else
		local var_9_1, var_9_2 = var_0_0.splitStringWithParenthesis(arg_9_0, "[%?:]")

		if #var_9_1 == 3 then
			var_9_0._type = NumberNode.TYPE_TRIPLE
			var_9_0._subNodes[#var_9_0._subNodes + 1] = BoolNode.compile(var_9_1[1], arg_9_1)
			var_9_0._subNodes[#var_9_0._subNodes + 1] = NumberNode.compile(var_9_1[2], arg_9_1)
			var_9_0._subNodes[#var_9_0._subNodes + 1] = NumberNode.compile(var_9_1[3], arg_9_1)
		elseif #var_9_1 == 1 then
			local var_9_3, var_9_4 = var_0_0.splitStringWithParenthesis(arg_9_0, "[%+%-%*/&]")

			if #var_9_3 > 1 then
				var_9_0._type = NumberNode.TYPE_EQUATION

				for iter_9_0 = 1, #var_9_3 do
					var_9_0._subNodes[#var_9_0._subNodes + 1] = NumberNode.compile(var_9_3[iter_9_0], arg_9_1)
					var_9_0._calcOps[#var_9_0._calcOps + 1] = var_9_4[iter_9_0]
				end
			elseif var_0_0.getFuncType(arg_9_0) ~= nil then
				var_9_0._type = NumberNode.TYPE_FUNC
				var_9_0._subNodes[#var_9_0._subNodes + 1] = FuncNode.compile(arg_9_0, skillNode)
			else
				local var_9_5 = tonumber(arg_9_0)

				if var_9_5 ~= nil then
					var_9_0._type = NumberNode.TYPE_DIGITS
					var_9_0._number = var_9_5
				else
					var_9_0._type = NumberNode.TYPE_PROP
					var_9_0._subNodes[#var_9_0._subNodes + 1] = PropNode.compile(arg_9_0, arg_9_1)
				end
			end
		else
			var_0_0.error("[N] Invalid tripple format:", arg_9_0)
		end
	end

	return var_9_0
end

function NumberNode.calcTriple(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0 and arg_10_1 or arg_10_2
end

function NumberNode.calcNumber(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == "+" then
		return arg_11_0 + arg_11_2
	elseif arg_11_1 == "-" then
		return arg_11_0 - arg_11_2
	elseif arg_11_1 == "*" then
		return arg_11_0 * arg_11_2
	elseif arg_11_1 == "/" then
		return math.floor(arg_11_0 / arg_11_2)
	elseif arg_11_1 == "&" then
		return bit.band(arg_11_0, arg_11_2)
	end
end

function PropNode.ctor(arg_12_0, arg_12_1)
	PropNode.super.ctor(arg_12_0, arg_12_1)
end

function PropNode.value(arg_13_0, arg_13_1)
	if arg_13_0._type == "#" then
		return #arg_13_1
	elseif arg_13_0._type == "C" then
		return arg_13_1._info._category
	elseif arg_13_0._type == "K" then
		return arg_13_1._info._keyword
	elseif arg_13_0._type == "L" then
		return arg_13_1:getLink()
	elseif arg_13_0._type == "N" then
		return arg_13_1._info._nature
	elseif arg_13_0._type == "P" then
		return arg_13_1._info._option
	elseif arg_13_0._type == "S" then
		return arg_13_1:getStar()
	elseif arg_13_0._type == "D" then
		return arg_13_1._infoId
	else
		return 0
	end
end

function PropNode.compile(arg_14_0, arg_14_1)
	arg_14_0 = var_0_0.trimParenthesis(arg_14_0)

	local var_14_0 = PropNode.new(arg_14_1)

	var_0_0.dumpCompile("[P]", arg_14_0)

	var_14_0._type = string.sub(arg_14_0, 1, 1)

	return var_14_0
end

FuncNode.DEF = {
	CNT = "B",
	UNI = "P"
}

function FuncNode.ctor(arg_15_0, arg_15_1)
	FuncNode.super.ctor(arg_15_0, arg_15_1)
end

function FuncNode.value(arg_16_0, arg_16_1)
	if arg_16_0._type == "CNT" then
		local var_16_0 = 0

		for iter_16_0 = 1, #arg_16_1 do
			if arg_16_0._subNodes[1]:value(arg_16_1[iter_16_0]) then
				var_16_0 = var_16_0 + 1
			end
		end

		arg_16_0._value = var_16_0
	elseif arg_16_0._type == "UNI" then
		arg_16_0._value = #B.filterUniquePropCards(arg_16_1, arg_16_0._subNodes[1]._type)
	end

	return arg_16_0._value
end

function FuncNode.compile(arg_17_0, arg_17_1)
	arg_17_0 = var_0_0.trimParenthesis(arg_17_0)

	local var_17_0 = FuncNode.new(arg_17_1)

	var_0_0.dumpCompile("[F]", arg_17_0)

	var_17_0._type, arg_17_0 = var_0_0.getFuncType(arg_17_0)
	arg_17_0 = var_0_0.trimParenthesis(arg_17_0)

	local var_17_1 = var_0_0.splitStringWithParenthesis(arg_17_0, ",")
	local var_17_2 = FuncNode.DEF[var_17_0._type]

	for iter_17_0 = 1, #var_17_1 do
		local var_17_3 = iter_17_0 < #var_17_2 and iter_17_0 + 1 or #var_17_2
		local var_17_4 = string.sub(var_17_2, var_17_3, var_17_3)

		var_17_0._subNodes[iter_17_0] = var_0_1[var_17_4].compile(var_17_1[iter_17_0], arg_17_1)
	end

	return var_17_0
end

function var_0_0.trimParenthesis(arg_18_0)
	local var_18_0, var_18_1 = var_0_0.findParenthesisPair(arg_18_0)

	if var_18_0 == 1 and var_18_1 == #arg_18_0 then
		return var_0_0.trimParenthesis(string.sub(arg_18_0, 2, #arg_18_0 - 1))
	else
		return arg_18_0
	end
end

function var_0_0.findParenthesisPair(arg_19_0)
	local var_19_0 = 0
	local var_19_1 = 0
	local var_19_2 = 0

	for iter_19_0 = 1, #arg_19_0 do
		local var_19_3 = string.sub(arg_19_0, iter_19_0, iter_19_0)

		if var_19_3 == "(" then
			if var_19_2 == 0 then
				var_19_0 = iter_19_0
			end

			var_19_2 = var_19_2 + 1
		elseif var_19_3 == ")" then
			var_19_2 = var_19_2 - 1

			if var_19_2 == 0 then
				var_19_1 = iter_19_0

				break
			end
		end
	end

	return var_19_0, var_19_1
end

function var_0_0.splitStringWithParenthesis(arg_20_0, arg_20_1)
	if string.find(arg_20_0, arg_20_1) == nil then
		return {
			arg_20_0
		}, {}
	end

	local var_20_0 = 0
	local var_20_1 = 1
	local var_20_2 = 1
	local var_20_3 = {}
	local var_20_4 = {}

	while var_20_2 <= #arg_20_0 do
		local var_20_5 = string.sub(arg_20_0, var_20_2, var_20_2)

		if var_20_5 == "(" then
			var_20_0 = var_20_0 + 1
		elseif var_20_5 == ")" then
			var_20_0 = var_20_0 - 1
		elseif var_20_0 == 0 and var_20_1 < var_20_2 then
			local var_20_6, var_20_7 = string.find(string.sub(arg_20_0, var_20_2), arg_20_1)

			if var_20_6 == 1 then
				var_20_3[#var_20_3 + 1] = string.sub(arg_20_0, var_20_1, var_20_2 - 1)
				var_20_4[#var_20_4 + 1] = string.sub(arg_20_0, var_20_2, var_20_2 + var_20_7 - var_20_6)
				var_20_2 = var_20_2 + var_20_7 - var_20_6
				var_20_1 = var_20_2 + 1
			elseif var_20_6 == nil then
				var_20_2 = #arg_20_0 + 1

				break
			end
		end

		var_20_2 = var_20_2 + 1
	end

	var_20_3[#var_20_3 + 1] = string.sub(arg_20_0, var_20_1, var_20_2 - 1)

	return var_20_3, var_20_4
end

function var_0_0.getFuncType(arg_21_0)
	local var_21_0, var_21_1 = string.find(arg_21_0, "^%u+%(")

	if var_21_0 == nil then
		return nil
	end

	return string.sub(arg_21_0, 1, var_21_1 - 1), string.sub(arg_21_0, var_21_1, -1)
end

function var_0_0.error(arg_22_0, arg_22_1)
	print(arg_22_0, arg_22_1)
end

function var_0_0.dumpCompile(arg_23_0, arg_23_1)
	return
end
