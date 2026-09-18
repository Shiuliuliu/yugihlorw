local var_0_0 = class("SelectCountWidget", lc.ExtendCCNode)

var_0_0.HEIGHT = 56

local var_0_1 = 6
local var_0_2 = 320 + var_0_1 * 4

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_2 = arg_2_2 or 100

	local var_2_0 = cc.size(var_0_2 + arg_2_2, var_0_0.HEIGHT)

	arg_2_0:setContentSize(var_2_0)

	arg_2_0._max = arg_2_3
	arg_2_0._min = arg_2_4 or 1
	arg_2_0._callback = arg_2_1

	local var_2_1 = var_0_0.HEIGHT / 2
	local var_2_2 = lc.createSprite({
		_name = "img_com_bg_3",
		_crect = ClientView.CRECT_COM_BG3,
		_size = cc.size(arg_2_2, var_0_0.HEIGHT)
	})

	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.w(arg_2_0) / 2, var_2_1))

	local var_2_3 = ClientView.createTTF("1", ClientView.FontSize.M1, ClientView.COLOR_TEXT_DARK)

	lc.addChildToPos(var_2_2, var_2_3, cc.p(lc.w(var_2_2) / 2, lc.h(var_2_2) / 2 + 2))

	arg_2_0._countVal = var_2_3

	local function var_2_4(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0._icon

		lc.offset(var_3_0, -18)

		local var_3_1 = ClientView.createBMFont(ClientView.BMFont.huali_32, tostring(arg_3_1))

		lc.addChildToPos(arg_3_0, var_3_1, cc.p(lc.right(var_3_0) + 2 + lc.w(var_3_1) / 2, lc.y(var_3_0) + 2))
	end

	local var_2_5 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:changeCount(-10)
	end, ClientView.CRECT_BUTTON_S, 100)

	var_2_5:addIcon("img_icon_minus")
	lc.addChildToPos(arg_2_0, var_2_5, cc.p(lc.w(var_2_5) / 2, var_2_1))
	var_2_4(var_2_5, 10)

	arg_2_0._btnReduceTen = var_2_5

	local var_2_6 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:changeCount(-1)
	end, ClientView.CRECT_BUTTON_S, 60)

	var_2_6:addIcon("img_icon_minus")
	lc.addChildToPos(arg_2_0, var_2_6, cc.p(lc.right(var_2_5) + 6 + lc.w(var_2_6) / 2, var_2_1))

	arg_2_0._btnReduceOne = var_2_6

	local var_2_7 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:changeCount(1)
	end, ClientView.CRECT_BUTTON_S, 60)

	var_2_7:addIcon("img_icon_add")
	lc.addChildToPos(arg_2_0, var_2_7, cc.p(lc.right(var_2_2) + 6 + lc.w(var_2_7) / 2, var_2_1))

	arg_2_0._btnAddOne = var_2_7

	local var_2_8 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:changeCount(10)
	end, ClientView.CRECT_BUTTON_S, 100)

	var_2_8:addIcon("img_icon_add")
	lc.addChildToPos(arg_2_0, var_2_8, cc.p(lc.right(var_2_7) + 6 + lc.w(var_2_8) / 2, var_2_1))
	var_2_4(var_2_8, 10)

	arg_2_0._btnAddTen = var_2_8
end

function var_0_0.changeCount(arg_8_0, arg_8_1)
	local var_8_0 = tonumber(arg_8_0._countVal:getString()) + arg_8_1

	if var_8_0 < arg_8_0._min then
		var_8_0 = arg_8_0._min
	elseif arg_8_0._max and var_8_0 > arg_8_0._max then
		var_8_0 = arg_8_0._max
	end

	arg_8_0._countVal:setString(tostring(var_8_0))

	if arg_8_0._callback then
		arg_8_0._callback(var_8_0)
	end
end

function var_0_0.getCount(arg_9_0)
	return tonumber(arg_9_0._countVal:getString())
end

return var_0_0
