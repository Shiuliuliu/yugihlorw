local var_0_0 = class("BattleCardSelectForm", BaseForm)
local var_0_1 = require("CardInfoPanel")
local var_0_2 = 30
local var_0_3 = 100
local var_0_4 = 100
local var_0_5 = 26
local var_0_6 = 120
local var_0_7 = 60
local var_0_8 = 60
local var_0_9 = 40
local var_0_10 = 8
local var_0_11 = 150
local var_0_12 = 130
local var_0_13 = {
	_N = 137,
	_F = 129,
	_UP = 28,
	_I = 132,
	_5 = 81,
	_0 = 76,
	_G = 130,
	_3 = 79,
	_1 = 77,
	_H = 131,
	_Z = 149,
	_BACKSPACE = 7,
	_2 = 78,
	_4 = 80,
	_DOWN = 29,
	_Y = 148,
	_E = 128,
	_DELETE = 23,
	_W = 146,
	_C = 126,
	_ESC = 6,
	_X = 147,
	_D = 127,
	_V = 145,
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
	_SPACE = 59,
	_LEFT = 26,
	_M = 136,
	_9 = 85,
	_RIGHT = 27,
	_K = 134,
	_7 = 83,
	_L = 135,
	_8 = 84,
	_J = 133,
	_6 = 82
}
local var_0_14 = {
	_SKILL_ID = 5,
	_KEYWORD = 11,
	_CARD_TRAP_ID = 3,
	_CATEGORY = 10,
	_DEFEND = 7,
	_CARD_MAGIC_ID = 2,
	_ATK = 6,
	_NATURE = 9,
	_CARD_MONSTER_ID = 1,
	_PINYIN = 8,
	_CARD_RARE_ID = 4
}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = lc.Director:getVisibleSize()

	var_0_0.super.init(arg_2_0, cc.size(var_2_0.width - (16 + ClientView.FRAME_TAB_WIDTH) * 2, 680), Str(STR.BATTLE_TEST_SELECT_CARD), bor(0))

	arg_2_0._hideBg = true
	arg_2_0._callback = arg_2_2
	arg_2_0._searchContent = ""

	arg_2_0:resetIcons()
	arg_2_0._form:setTouchEnabled(false)
	arg_2_0:createSearchArea()
	arg_2_0:createCardArea(arg_2_1, arg_2_3)
end

function var_0_0.onCleanup(arg_3_0)
	var_0_0.super.onCleanup(arg_3_0)
	arg_3_0:resetIcons()

	var_0_1._operateType = var_0_1.OperateType.na
end

function var_0_0.onEnter(arg_4_0)
	var_0_0.super.onEnter(arg_4_0)

	arg_4_0._keyListener = lc.addEventListener(Data.Event.unitest, function(arg_5_0)
		arg_4_0:onKeyEvent(arg_5_0)
	end)
end

function var_0_0.onExit(arg_6_0)
	var_0_0.super.onExit(arg_6_0)
	lc.Dispatcher:removeEventListener(arg_6_0._keyListener)
end

function var_0_0.onKeyEvent(arg_7_0, arg_7_1)
	local var_7_0 = tonumber(arg_7_1._key)

	if var_7_0 == var_0_13._LEFT then
		if #arg_7_0._icons > 1 and arg_7_0._selected > 1 then
			arg_7_0._selected = arg_7_0._selected - 1

			arg_7_0:updateView()
		end
	elseif var_7_0 == var_0_13._RIGHT then
		if #arg_7_0._icons > 1 and arg_7_0._selected < #arg_7_0._icons then
			arg_7_0._selected = arg_7_0._selected + 1

			arg_7_0:updateView()
		end
	elseif var_7_0 == var_0_13._UP then
		if #arg_7_0._icons > 9 and arg_7_0._selected > var_0_10 then
			arg_7_0._selected = arg_7_0._selected - var_0_10

			arg_7_0:updateView()
		end
	elseif var_7_0 == var_0_13._DOWN then
		if #arg_7_0._icons > 9 and arg_7_0._selected + var_0_10 <= #arg_7_0._icons then
			arg_7_0._selected = arg_7_0._selected + var_0_10

			arg_7_0:updateView()
		end
	elseif var_7_0 == var_0_13._ENTER then
		if #arg_7_0._icons > 0 then
			arg_7_0:hide()

			if arg_7_0._callback and #arg_7_0._icons > 0 then
				local var_7_1 = arg_7_0._icons[arg_7_0._selected]

				arg_7_0._callback(var_7_1._data._infoId, false)
			end
		end
	elseif var_7_0 == var_0_13._ESC then
		arg_7_0:hide()
	elseif var_7_0 == var_0_13._BACKSPACE then
		if arg_7_0._searchContent ~= "" then
			arg_7_0._searchContent = string.sub(arg_7_0._searchContent, 1, #arg_7_0._searchContent - 1)
		end

		arg_7_0._editor:setText(arg_7_0._searchContent)
		arg_7_0:search()
	else
		arg_7_0._searchContent = arg_7_0._searchContent .. arg_7_0:parseKey(var_7_0)

		arg_7_0._editor:setText(arg_7_0._searchContent)
		arg_7_0:search()
	end

	print("[UNITTEST] searching: ", arg_7_0._searchContent)
end

function var_0_0.search(arg_8_0)
	arg_8_0._selected = nil

	arg_8_0:resetIcons()
	arg_8_0:filter(arg_8_0._searchContent)
	arg_8_0:insertCards()
	arg_8_0:updateView()
end

function var_0_0.parseKey(arg_9_0, arg_9_1)
	if arg_9_1 == var_0_13._0 then
		return "0"
	elseif arg_9_1 == var_0_13._1 then
		return "1"
	elseif arg_9_1 == var_0_13._2 then
		return "2"
	elseif arg_9_1 == var_0_13._3 then
		return "3"
	elseif arg_9_1 == var_0_13._4 then
		return "4"
	elseif arg_9_1 == var_0_13._5 then
		return "5"
	elseif arg_9_1 == var_0_13._6 then
		return "6"
	elseif arg_9_1 == var_0_13._7 then
		return "7"
	elseif arg_9_1 == var_0_13._8 then
		return "8"
	elseif arg_9_1 == var_0_13._9 then
		return "9"
	elseif arg_9_1 == var_0_13._A then
		return "A"
	elseif arg_9_1 == var_0_13._B then
		return "B"
	elseif arg_9_1 == var_0_13._C then
		return "C"
	elseif arg_9_1 == var_0_13._D then
		return "D"
	elseif arg_9_1 == var_0_13._E then
		return "E"
	elseif arg_9_1 == var_0_13._F then
		return "F"
	elseif arg_9_1 == var_0_13._G then
		return "G"
	elseif arg_9_1 == var_0_13._H then
		return "H"
	elseif arg_9_1 == var_0_13._I then
		return "I"
	elseif arg_9_1 == var_0_13._J then
		return "J"
	elseif arg_9_1 == var_0_13._K then
		return "K"
	elseif arg_9_1 == var_0_13._L then
		return "L"
	elseif arg_9_1 == var_0_13._M then
		return "M"
	elseif arg_9_1 == var_0_13._N then
		return "N"
	elseif arg_9_1 == var_0_13._O then
		return "O"
	elseif arg_9_1 == var_0_13._P then
		return "P"
	elseif arg_9_1 == var_0_13._Q then
		return "Q"
	elseif arg_9_1 == var_0_13._R then
		return "R"
	elseif arg_9_1 == var_0_13._S then
		return "S"
	elseif arg_9_1 == var_0_13._T then
		return "T"
	elseif arg_9_1 == var_0_13._U then
		return "U"
	elseif arg_9_1 == var_0_13._V then
		return "V"
	elseif arg_9_1 == var_0_13._W then
		return "W"
	elseif arg_9_1 == var_0_13._X then
		return "X"
	elseif arg_9_1 == var_0_13._Y then
		return "Y"
	elseif arg_9_1 == var_0_13._Z then
		return "Z"
	elseif arg_9_1 == var_0_13._SPACE then
		return "_"
	end

	return ""
end

function var_0_0.createSearchArea(arg_10_0, arg_10_1)
	local var_10_0 = lc.w(arg_10_0._frame) - var_0_7 - var_0_8 - var_0_11 * 2
	local var_10_1 = var_0_6 - 45
	local var_10_2 = lc.w(arg_10_0._frame) - var_0_7 - var_0_8
	local var_10_3 = var_0_6
	local var_10_4 = ccui.Layout:create()

	var_10_4:setContentSize(var_10_2, var_10_3)

	local var_10_5 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(var_10_0, var_10_1), Str(STR.INPUT_CARDID_SKILLID_ATTACK_DEFEND_PINYIN))

	var_10_5:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_10_4, var_10_5, cc.p(0, lc.h(var_10_4) / 2), 10)

	arg_10_0._editor = var_10_5

	arg_10_0._editor:setTouchEnabled(false)

	local var_10_6 = ClientView.createScale9ShaderButton("img_btn_1", nil, ClientView.CRECT_BUTTON, var_0_11)

	var_10_6:addLabel(string.format(Str(STR.GEN_N_CARDS), 2))
	var_10_6:setAnchorPoint(0, 0)

	function var_10_6._callback(arg_11_0)
		arg_10_0:genCards(2)
	end

	lc.addChildToPos(var_10_4, var_10_6, cc.p(lc.right(arg_10_0._editor) + 10, ClientView.FRAME_INNER_BOTTOM - 5))

	arg_10_0._btn2Cards = var_10_6

	local var_10_7 = ClientView.createScale9ShaderButton("img_btn_1", nil, ClientView.CRECT_BUTTON, var_0_11)

	var_10_7:addLabel(string.format(Str(STR.GEN_N_CARDS), 5))
	var_10_7:setAnchorPoint(0, 0)

	function var_10_7._callback(arg_12_0)
		arg_10_0:genCards(5)
	end

	lc.addChildToPos(var_10_4, var_10_7, cc.p(lc.right(arg_10_0._btn2Cards) + 10, ClientView.FRAME_INNER_BOTTOM - 5))

	arg_10_0._bbtn5Cards = var_10_7

	var_10_4:setAnchorPoint(0, 1)
	lc.addChildToPos(arg_10_0._frame, var_10_4, cc.p(var_0_7, lc.h(arg_10_0._frame) - var_0_9), 20)
end

function var_0_0.createCardArea(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = lc.w(arg_13_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT
	local var_13_1 = lc.h(arg_13_0._frame) - ClientView.FRAME_INNER_BOTTOM - ClientView.FRAME_INNER_BOTTOM - var_0_6
	local var_13_2 = lc.List.createV(cc.size(var_13_0, var_13_1), 10, 10)

	var_13_2:setAnchorPoint(0.5, 0)
	lc.addChildToPos(arg_13_0._frame, var_13_2, cc.p(lc.w(arg_13_0._frame) / 2, ClientView.FRAME_INNER_BOTTOM), 10)

	arg_13_0._list = var_13_2
	arg_13_0._cardCountInRow = math.floor(lc.w(var_13_2) / (var_0_4 + var_0_5))
	arg_13_0._data = {
		{},
		{},
		{},
		{}
	}

	for iter_13_0 = 1, #arg_13_1 do
		if arg_13_1[iter_13_0] == _SELECT_CARD_TYPE.MONSTER then
			local var_13_3 = arg_13_0._data[1]

			for iter_13_1, iter_13_2 in pairs(Data._monsterInfo) do
				if Data.isUserVisible(iter_13_1) then
					var_13_3[#var_13_3 + 1] = iter_13_2
				end
			end

			table.sort(var_13_3, function(arg_14_0, arg_14_1)
				return arg_14_0._id < arg_14_1._id
			end)
		elseif arg_13_1[iter_13_0] == _SELECT_CARD_TYPE.MAGIC then
			local var_13_4 = arg_13_0._data[2]

			for iter_13_3, iter_13_4 in pairs(Data._magicInfo) do
				if Data.isUserVisible(iter_13_3) then
					if arg_13_2 and iter_13_4._type ~= 11 then
						var_13_4[#var_13_4 + 1] = iter_13_4
					elseif arg_13_2 == nil then
						var_13_4[#var_13_4 + 1] = iter_13_4
					end
				end
			end

			table.sort(var_13_4, function(arg_15_0, arg_15_1)
				return arg_15_0._id < arg_15_1._id
			end)
		elseif arg_13_1[iter_13_0] == _SELECT_CARD_TYPE.TRAP then
			local var_13_5 = arg_13_0._data[3]

			for iter_13_5, iter_13_6 in pairs(Data._trapInfo) do
				if Data.isUserVisible(iter_13_5) then
					if arg_13_2 and iter_13_6._type ~= 11 then
						var_13_5[#var_13_5 + 1] = iter_13_6
					elseif arg_13_2 == nil then
						var_13_5[#var_13_5 + 1] = iter_13_6
					end
				end
			end

			table.sort(var_13_5, function(arg_16_0, arg_16_1)
				return arg_16_0._id > arg_16_1._id
			end)
		elseif arg_13_1[iter_13_0] == _SELECT_CARD_TYPE.RARE then
			local var_13_6 = arg_13_0._data[4]

			for iter_13_7, iter_13_8 in pairs(Data._rareInfo) do
				if Data.isUserVisible(iter_13_7) then
					var_13_6[#var_13_6 + 1] = iter_13_8
				end
			end

			table.sort(var_13_6, function(arg_17_0, arg_17_1)
				return arg_17_0._id < arg_17_1._id
			end)
		end
	end
end

function var_0_0.filter(arg_18_0, arg_18_1)
	arg_18_0._searchKey = nil
	arg_18_0._searchType = nil

	local var_18_0
	local var_18_1 = string.lower(arg_18_1)
	local var_18_2 = string.trim(var_18_1)

	if tonumber(var_18_2) == nil and var_18_2 ~= "" then
		local var_18_3 = string.sub(var_18_2, 1, 1)
		local var_18_4 = string.sub(var_18_2, 1, 2)
		local var_18_5 = string.sub(var_18_2, 3)
		local var_18_6 = string.sub(var_18_2, 2)
		local var_18_7 = tonumber(var_18_6)

		arg_18_0._searchKey = {}

		if var_18_4 == "n_" then
			lc.log("n empty {" .. var_18_5)

			if var_18_5 == nil or var_18_5 == "" then
				-- block empty
			else
				if string.find("guang", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 1)

					arg_18_0._searchType = var_0_14._NATURE
				end

				if string.find("an", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 2)

					arg_18_0._searchType = var_0_14._NATURE
				end

				if string.find("di", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 3)

					arg_18_0._searchType = var_0_14._NATURE
				end

				if string.find("yan", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 4)

					arg_18_0._searchType = var_0_14._NATURE
				end

				if string.find("shui", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 5)

					arg_18_0._searchType = var_0_14._NATURE
				end

				if string.find("feng", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 6)

					arg_18_0._searchType = var_0_14._NATURE
				end

				if string.find("shen", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 7)

					arg_18_0._searchType = var_0_14._NATURE
				end

				if tonumber(var_18_5) then
					table.insert(arg_18_0._searchKey, tonumber(var_18_5))

					arg_18_0._searchType = var_0_14._NATURE
				end
			end
		elseif var_18_4 == "c_" then
			lc.log("c empty {" .. var_18_5)

			if var_18_5 == nil or var_18_5 == "" then
				-- block empty
			else
				if string.find("mofashi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 1)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("long", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 2)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("jixie", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 3)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("emo", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 4)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("shou", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 5)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("zhanshi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 6)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("yanshi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 7)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("shui", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 8)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("hailong", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 9)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("pachong", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 10)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("shouzhanshi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 11)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("konglong", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 12)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("niaoshou", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 13)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("tianshi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 14)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("kunchong", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 15)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("yu", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 16)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("busi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 17)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("zhiwu", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 18)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("yan", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 19)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if string.find("huanshen", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 20)

					arg_18_0._searchType = var_0_14._CATEGORY
				end

				if tonumber(var_18_5) then
					table.insert(arg_18_0._searchKey, tonumber(var_18_5))

					arg_18_0._searchType = var_0_14._CATEGORY
				end
			end
		elseif var_18_4 == "k_" then
			lc.log("k empty {" .. var_18_5)

			if var_18_5 == nil or var_18_5 == "" then
				-- block empty
			else
				if string.find("heimofashi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 1)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("qingyanbailong", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 2)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("emo", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 3)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("cishizhanshi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 4)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("liziqiu", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 5)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("yamaxun", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 6)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("yingshen", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 7)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("zhenhongyan", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 8)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("jinglingjianshi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 9)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("shengke", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 10)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("duotianshi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 11)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("shouhuzhe", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 12)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("shengqishi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 13)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("yuansuyingxiong", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 14)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("yingshennvlang", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 15)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("ziran", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 55)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if string.find("yishi", var_18_5) == 1 then
					table.insert(arg_18_0._searchKey, 52)

					arg_18_0._searchType = var_0_14._KEYWORD
				end

				if tonumber(var_18_5) then
					table.insert(arg_18_0._searchKey, tonumber(var_18_5))

					arg_18_0._searchType = var_0_14._KEYWORD
				end
			end
		elseif var_18_7 == nil then
			arg_18_0._searchKey = var_18_2
			arg_18_0._searchType = var_0_14._PINYIN

			lc.log("pinyin -- " .. var_18_2)
		elseif var_18_3 == "a" then
			local var_18_8 = string.sub(var_18_2, 2)
			local var_18_9 = tonumber(var_18_8)

			if var_18_9 ~= nil then
				lc.log("atk -- " .. var_18_8)

				arg_18_0._searchKey = var_18_9
				arg_18_0._searchType = var_0_14._ATK
			end
		elseif var_18_3 == "d" then
			local var_18_10 = string.sub(var_18_2, 2)
			local var_18_11 = tonumber(var_18_10)

			if var_18_11 ~= nil then
				lc.log("def -- " .. var_18_10)

				arg_18_0._searchKey = var_18_11
				arg_18_0._searchType = var_0_14._DEFEND
			end
		end
	elseif var_18_2 ~= "" then
		local var_18_12 = tonumber(var_18_2)

		if var_18_12 > 10000 and var_18_12 < 13000 then
			arg_18_0._searchKey = var_18_12
			arg_18_0._searchType = var_0_14._CARD_MONSTER_ID

			lc.log("monster id " .. var_18_12)
		elseif var_18_12 > 20000 and var_18_12 < 30000 then
			arg_18_0._searchKey = var_18_12
			arg_18_0._searchType = var_0_14._CARD_MAGIC_ID

			lc.log("magic id " .. var_18_12)
		elseif var_18_12 > 30000 and var_18_12 < 40000 then
			arg_18_0._searchKey = var_18_12
			arg_18_0._searchType = var_0_14._CARD_TRAP_ID

			lc.log("trap id " .. var_18_12)
		elseif var_18_12 > 40000 and var_18_12 < 50000 then
			arg_18_0._searchKey = var_18_12
			arg_18_0._searchType = var_0_14._CARD_RARE_ID

			lc.log("rare id " .. var_18_12)
		elseif var_18_12 > 0 and var_18_12 < 10000 or var_18_12 > 13000 and var_18_12 < 20000 then
			arg_18_0._searchKey = var_18_12
			arg_18_0._searchType = var_0_14._SKILL_ID

			lc.log("skill id " .. var_18_12)
		end
	end

	arg_18_0._filterData = {}

	if arg_18_0._searchType == nil or arg_18_0._searchKey == nil then
		return
	end

	if arg_18_0._searchType <= var_0_14._CARD_RARE_ID then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._data[arg_18_0._searchType]) do
			if arg_18_0._searchKey == iter_18_1._id then
				table.insert(arg_18_0._filterData, iter_18_1)
				lc.log("add card id -- " .. tostring(iter_18_1._id))
			end
		end
	elseif arg_18_0._searchType == var_0_14._SKILL_ID then
		for iter_18_2 = 1, #arg_18_0._data do
			local var_18_13 = arg_18_0._data[iter_18_2]

			for iter_18_3, iter_18_4 in ipairs(var_18_13) do
				local var_18_14 = iter_18_4._skillId

				for iter_18_5, iter_18_6 in ipairs(var_18_14) do
					if arg_18_0._searchKey == iter_18_6 then
						table.insert(arg_18_0._filterData, iter_18_4)
						lc.log("add skill id -- " .. tostring(iter_18_6))

						break
					end
				end
			end
		end
	elseif arg_18_0._searchType == var_0_14._ATK then
		local var_18_15 = arg_18_0._data[var_0_14._CARD_MONSTER_ID]

		for iter_18_7, iter_18_8 in ipairs(var_18_15) do
			if arg_18_0._searchKey == iter_18_8._atk[1] then
				table.insert(arg_18_0._filterData, iter_18_8)
				lc.log("add attack -- " .. tostring(iter_18_8._atk[1]))
			end
		end

		local var_18_16 = arg_18_0._data[var_0_14._CARD_RARE_ID]

		for iter_18_9, iter_18_10 in ipairs(var_18_16) do
			if arg_18_0._searchKey == iter_18_10._atk[1] then
				table.insert(arg_18_0._filterData, iter_18_10)
				lc.log("add attack -- " .. tostring(iter_18_10._atk[1]))
			end
		end
	elseif arg_18_0._searchType == var_0_14._DEFEND then
		local var_18_17 = arg_18_0._data[var_0_14._CARD_MONSTER_ID]

		for iter_18_11, iter_18_12 in ipairs(var_18_17) do
			if arg_18_0._searchKey == iter_18_12._hp[1] then
				table.insert(arg_18_0._filterData, iter_18_12)
				lc.log("add defend -- " .. tostring(iter_18_12._hp[1]))
			end
		end

		local var_18_18 = arg_18_0._data[var_0_14._CARD_RARE_ID]

		for iter_18_13, iter_18_14 in ipairs(var_18_18) do
			if arg_18_0._searchKey == iter_18_14._hp[1] then
				table.insert(arg_18_0._filterData, iter_18_14)
				lc.log("add defend -- " .. tostring(iter_18_14._hp[1]))
			end
		end
	elseif arg_18_0._searchType == var_0_14._PINYIN then
		for iter_18_15 = 1, #arg_18_0._data do
			local var_18_19 = arg_18_0._data[iter_18_15]

			for iter_18_16, iter_18_17 in ipairs(var_18_19) do
				local var_18_20, var_18_21 = string.find(iter_18_17._py, arg_18_0._searchKey)

				if var_18_20 == 1 then
					lc.log(type(result))
					table.insert(arg_18_0._filterData, iter_18_17)
					lc.log("add pinyin -- " .. iter_18_17._py)
				end
			end
		end
	elseif arg_18_0._searchType == var_0_14._NATURE then
		for iter_18_18 = 1, #arg_18_0._data do
			local var_18_22 = arg_18_0._data[iter_18_18]

			for iter_18_19, iter_18_20 in ipairs(var_18_22) do
				local var_18_23 = iter_18_20._nature

				for iter_18_21 = 1, #arg_18_0._searchKey do
					if var_18_23 == arg_18_0._searchKey[iter_18_21] then
						table.insert(arg_18_0._filterData, iter_18_20)

						break
					end
				end
			end
		end
	elseif arg_18_0._searchType == var_0_14._CATEGORY then
		for iter_18_22 = 1, #arg_18_0._data do
			local var_18_24 = arg_18_0._data[iter_18_22]

			for iter_18_23, iter_18_24 in ipairs(var_18_24) do
				local var_18_25 = iter_18_24._category

				for iter_18_25 = 1, #arg_18_0._searchKey do
					if var_18_25 == arg_18_0._searchKey[iter_18_25] then
						table.insert(arg_18_0._filterData, iter_18_24)

						break
					end
				end
			end
		end
	elseif arg_18_0._searchType == var_0_14._KEYWORD then
		for iter_18_26 = 1, #arg_18_0._data do
			local var_18_26 = arg_18_0._data[iter_18_26]

			for iter_18_27, iter_18_28 in ipairs(var_18_26) do
				local var_18_27 = iter_18_28._keyword

				for iter_18_29 = 1, #arg_18_0._searchKey do
					if var_18_27 == arg_18_0._searchKey[iter_18_29] then
						table.insert(arg_18_0._filterData, iter_18_28)

						break
					end
				end
			end
		end
	end
end

function var_0_0.filterSelectedCard(arg_19_0, arg_19_1)
	lc.log("filterSelectedCard")

	if arg_19_0._filterData then
		lc.log("filterdata not null")
		lc.log("filteData type is " .. type(arg_19_0._filterData))
		lc.dumpTable(arg_19_0._filterData)

		for iter_19_0, iter_19_1 in ipairs(arg_19_0._filterData) do
			lc.log("filter card id is " .. tostring(iter_19_1._id))

			if iter_19_1._id == arg_19_1 then
				lc.log("insert " .. arg_19_1)
				table.insert(arg_19_0._selectedData, iter_19_1)
			end
		end
	end
end

function var_0_0.insertCards(arg_20_0)
	local var_20_0 = arg_20_0:addCards(arg_20_0._filterData)
	local var_20_1 = arg_20_0._list

	lc.log("list type : " .. type(var_20_1))

	arg_20_0._icons = {}

	if var_20_1 ~= nil then
		var_20_1:removeAllItems()

		if var_20_0 then
			var_20_1:bindData(var_20_0, function(arg_21_0, arg_21_1)
				arg_20_0:setOrCreateItem(arg_21_0, arg_21_1)
			end, math.min(8, #var_20_0), 1)

			for iter_20_0 = 1, var_20_1._cacheCount do
				local var_20_2 = var_20_0[iter_20_0]
				local var_20_3 = arg_20_0:setOrCreateItem(nil, var_20_2)

				var_20_1:pushBackCustomItem(var_20_3)
			end

			var_20_1:jumpToTop()
		end
	end
end

function var_0_0.genCards(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or 1

	local var_22_0 = {}

	for iter_22_0 = 1, #arg_22_0._data do
		for iter_22_1 = 1, #arg_22_0._data[iter_22_0] do
			local var_22_1 = arg_22_0._data[iter_22_0][iter_22_1]

			table.insert(var_22_0, var_22_1._id)
		end
	end

	lc.log("num is " .. arg_22_1)

	for iter_22_2 = 1, arg_22_1 do
		local var_22_2 = math.random(#var_22_0)

		lc.log("======================genCard" .. var_22_0[var_22_2])
		arg_22_0._callback(var_22_0[var_22_2], true)
	end

	ToastManager.push("DONE!")
end

function var_0_0.getCardId(arg_23_0, arg_23_1)
	return
end

function var_0_0.addCards(arg_24_0, arg_24_1)
	if arg_24_1 == nil or #arg_24_1 == 0 then
		return nil
	end

	local var_24_0 = {}
	local var_24_1 = arg_24_1[1]
	local var_24_2 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		table.insert(var_24_2, iter_24_1)

		if #var_24_2 == arg_24_0._cardCountInRow then
			table.insert(var_24_0, var_24_2)

			var_24_2 = {}
		end
	end

	if #var_24_2 > 0 then
		table.insert(var_24_0, var_24_2)
	end

	if type(var_24_0[#var_24_0]) == "number" then
		table.remove(var_24_0)
	end

	return var_24_0
end

function var_0_0.setOrCreateItem(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 == nil then
		arg_25_1 = ccui.Widget:create()
	end

	arg_25_1:removeAllChildren()

	if type(arg_25_2) == "number" then
		-- block empty
	else
		local var_25_0 = (var_0_4 + var_0_5) * arg_25_0._cardCountInRow - var_0_5

		arg_25_1:setContentSize(var_25_0, 130)

		local var_25_1 = cc.p(var_0_4 / 2, lc.h(arg_25_1) / 2)

		for iter_25_0, iter_25_1 in ipairs(arg_25_2) do
			local var_25_2 = IconWidget.create({
				_infoId = iter_25_1._id
			})
			local var_25_3 = ClientView.createBMFont(ClientView.BMFont.huali_20, "")

			var_25_3:setScale(0.7)
			lc.addChildToPos(var_25_2._frame, var_25_3, cc.p(lc.w(var_25_2._frame) - lc.w(var_25_3) / 2 - 20, lc.h(var_25_3) / 2 + 25))
			var_25_3:setString(iter_25_1._star)

			local var_25_4 = lc.createSprite("card_quality")

			var_25_4:setScale(0.7)
			lc.addChildToPos(var_25_2._frame, var_25_4, cc.p(lc.left(var_25_3) - lc.w(var_25_4) / 2, lc.h(var_25_4) / 2 + 10))
			var_25_2._name:setColor(ClientView.COLOR_BMFONT)

			function var_25_2._callback(arg_26_0)
				ToastManager.push("DONE!")

				if arg_25_0._callback then
					arg_25_0._callback(arg_26_0._data._infoId, false)
				end
			end

			lc.addChildToPos(arg_25_1, var_25_2, var_25_1)
			table.insert(arg_25_0._icons, var_25_2)

			var_25_1.x = var_25_1.x + var_0_4 + var_0_5
		end
	end

	return arg_25_1
end

function var_0_0.updateView(arg_27_0)
	if not arg_27_0._selected and #arg_27_0._icons >= 1 then
		arg_27_0._selected = 1
	end
end

function var_0_0.resetIcons(arg_28_0)
	if not arg_28_0._icons then
		arg_28_0._icons = {}

		return
	end

	for iter_28_0 = #arg_28_0._icons, 1, -1 do
		if arg_28_0._icons[iter_28_0] then
			table.remove(arg_28_0._icons, iter_28_0)
		end
	end
end

return var_0_0
