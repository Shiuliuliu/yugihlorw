local var_0_0 = class("BattleTestInputForm", BaseForm)
local var_0_1 = cc.size(720, 280)
local var_0_2 = {
	Str(STR.SEND),
	Str(STR.CHANGE),
	Str(STR.SEND)
}
local var_0_3 = {
	_F = 129,
	_1 = 77,
	_4 = 80,
	_I = 132,
	_5 = 81,
	_V = 145,
	_G = 130,
	_3 = 79,
	_Z = 149,
	_H = 131,
	_ESC = 6,
	_BACKSPACE = 7,
	_2 = 78,
	_SHORT_LINE = 73,
	_Y = 148,
	_E = 128,
	_DELETE = 23,
	_W = 146,
	_C = 126,
	_X = 147,
	_D = 127,
	_0 = 76,
	_B = 125,
	_U = 144,
	_A = 124,
	_S = 142,
	_ENTER = 35,
	_T = 143,
	_R = 141,
	_Q = 140,
	_O = 138,
	_P = 139,
	_N = 137,
	_M = 136,
	_9 = 85,
	_K = 134,
	_7 = 83,
	_L = 135,
	_8 = 84,
	_J = 133,
	_6 = 82
}

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.init(arg_2_0, var_0_1, "input", 0)

	arg_2_0._callback = arg_2_1
	arg_2_0._opType = arg_2_2
	arg_2_0._hideBg = true

	local var_2_0 = arg_2_0._form
	local var_2_1 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(600, 60), Str(STR.INPUT_SHARE_TEXT))

	lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.w(var_2_0) / 2, lc.bottom(arg_2_0._titleFrame) - 20 - lc.h(var_2_1) / 2))

	arg_2_0._editor = var_2_1

	arg_2_0._editor:setTouchEnabled(false)
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	arg_3_0._inputContent = ""
	arg_3_0._keyListener = lc.addEventListener(Data.Event.unitest, function(arg_4_0)
		arg_3_0:onKeyEvent(arg_4_0)
	end)
end

function var_0_0.onExit(arg_5_0)
	var_0_0.super.onExit(arg_5_0)
	lc.Dispatcher:removeEventListener(arg_5_0._keyListener)
end

function var_0_0.onKeyEvent(arg_6_0, arg_6_1)
	local var_6_0 = tonumber(arg_6_1._key)

	if var_6_0 == var_0_3._ENTER then
		arg_6_0:confirm()
	elseif var_6_0 == var_0_3._DELETE then
		arg_6_0._inputContent = ""
	elseif var_6_0 == var_0_3._BACKSPACE then
		if arg_6_0._inputContent ~= "" then
			arg_6_0._inputContent = string.sub(arg_6_0._inputContent, 1, #arg_6_0._inputContent - 1)
		end
	elseif var_6_0 == var_0_3._ESC then
		arg_6_0:hide()
	else
		arg_6_0._inputContent = arg_6_0._inputContent .. arg_6_0:parseKey(var_6_0)
	end

	if arg_6_0._opType == BattleTestData.OperationType._export then
		arg_6_0._inputContent = string.lower(arg_6_0._inputContent)
	end

	arg_6_0._editor:setText(arg_6_0._inputContent)
end

function var_0_0.parseKey(arg_7_0, arg_7_1)
	if arg_7_1 == var_0_3._0 then
		return "0"
	elseif arg_7_1 == var_0_3._1 then
		return "1"
	elseif arg_7_1 == var_0_3._2 then
		return "2"
	elseif arg_7_1 == var_0_3._3 then
		return "3"
	elseif arg_7_1 == var_0_3._4 then
		return "4"
	elseif arg_7_1 == var_0_3._5 then
		return "5"
	elseif arg_7_1 == var_0_3._6 then
		return "6"
	elseif arg_7_1 == var_0_3._7 then
		return "7"
	elseif arg_7_1 == var_0_3._8 then
		return "8"
	elseif arg_7_1 == var_0_3._9 then
		return "9"
	end

	if arg_7_0._opType == BattleTestData.OperationType._export then
		if arg_7_1 == var_0_3._A then
			return "A"
		elseif arg_7_1 == var_0_3._B then
			return "B"
		elseif arg_7_1 == var_0_3._C then
			return "C"
		elseif arg_7_1 == var_0_3._D then
			return "D"
		elseif arg_7_1 == var_0_3._E then
			return "E"
		elseif arg_7_1 == var_0_3._F then
			return "F"
		elseif arg_7_1 == var_0_3._G then
			return "G"
		elseif arg_7_1 == var_0_3._H then
			return "H"
		elseif arg_7_1 == var_0_3._I then
			return "I"
		elseif arg_7_1 == var_0_3._J then
			return "J"
		elseif arg_7_1 == var_0_3._K then
			return "K"
		elseif arg_7_1 == var_0_3._L then
			return "L"
		elseif arg_7_1 == var_0_3._M then
			return "M"
		elseif arg_7_1 == var_0_3._N then
			return "N"
		elseif arg_7_1 == var_0_3._O then
			return "O"
		elseif arg_7_1 == var_0_3._P then
			return "P"
		elseif arg_7_1 == var_0_3._Q then
			return "Q"
		elseif arg_7_1 == var_0_3._R then
			return "R"
		elseif arg_7_1 == var_0_3._S then
			return "S"
		elseif arg_7_1 == var_0_3._T then
			return "T"
		elseif arg_7_1 == var_0_3._U then
			return "U"
		elseif arg_7_1 == var_0_3._V then
			return "V"
		elseif arg_7_1 == var_0_3._W then
			return "W"
		elseif arg_7_1 == var_0_3._X then
			return "X"
		elseif arg_7_1 == var_0_3._Y then
			return "Y"
		elseif arg_7_1 == var_0_3._Z then
			return "Z"
		elseif arg_7_1 == var_0_3._SHORT_LINE then
			return "-"
		end
	end

	return ""
end

function var_0_0.confirm(arg_8_0)
	local var_8_0 = arg_8_0._editor:getText()
	local var_8_1 = 5

	if arg_8_0._opType == BattleTestData.OperationType._modifyHp then
		var_8_1 = 5
	elseif arg_8_0._opType == BattleTestData.OperationType._addSkill then
		var_8_1 = 5
	elseif arg_8_0._opType == BattleTestData.OperationType._export then
		var_8_1 = 12
	end

	if var_8_1 < lc.utf8len(var_8_0) then
		ToastManager.push(Str(STR.MESSAGE) .. string.format(Str(STR.CANNOT_MORE_THAN), var_8_1))

		return
	elseif lc.utf8len(var_8_0) == 0 then
		if arg_8_0._opType == BattleTestData.OperationType._addSkill then
			if arg_8_0._callback ~= nil then
				arg_8_0._callback(var_8_0)
			end

			arg_8_0:hide()
		else
			ToastManager.push(Str(STR.INPUT_MESSAGE))
		end

		return
	elseif arg_8_0._opType == BattleTestData.OperationType._modifyHp then
		if tonumber(var_8_0) == nil then
			ToastManager.push(string.format(Str(STR.INPUT_NUMBER), 400))
		else
			if arg_8_0._callback ~= nil then
				arg_8_0._callback(var_8_0)
			end

			arg_8_0:hide()
		end
	elseif arg_8_0._opType == BattleTestData.OperationType._addSkill then
		if tonumber(var_8_0) == nil then
			ToastManager.push(string.format(Str(STR.INPUT_NUMBER), 400))
		else
			if arg_8_0._callback ~= nil then
				arg_8_0._callback(var_8_0)
			end

			arg_8_0:hide()
		end
	elseif arg_8_0._opType == BattleTestData.OperationType._export then
		if not string.find(var_8_0, "\\") and not string.find(var_8_0, "/") and not string.find(var_8_0, ":") then
			if arg_8_0._callback ~= nil then
				arg_8_0._callback(var_8_0)
			end

			arg_8_0:hide()
		else
			ToastManager.push(string.format(Str(STR.CANNOT_CONTAIN_SPECIAL_SYMBOL), "\\, /, :"))
		end
	end
end

function var_0_0.hide(arg_9_0, arg_9_1)
	var_0_0.super.hide(arg_9_0, arg_9_1)
end

return var_0_0
