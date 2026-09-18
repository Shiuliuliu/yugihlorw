local var_0_0 = class("NumberWidget", lc.ExtendCCNode)
local var_0_1 = cc.size(310, 60)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setContentSize(var_0_1)
	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		elseif arg_2_0 == "cleanup" then
			var_1_0:onCleanup()
		end
	end)
	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._callback = arg_3_3
	arg_3_1 = arg_3_1 or 1
	arg_3_0._minCount = arg_3_1
	arg_3_0._maxCount = arg_3_2
	arg_3_0._count = arg_3_0._minCount

	local var_3_0 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(100, 60), Str(STR.INPUT_COUNT_TEXT))

	var_3_0:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC)
	var_3_0:setText(tostring(arg_3_0._count))
	lc.addChildToCenter(arg_3_0, var_3_0)

	arg_3_0._editor = var_3_0

	var_3_0:registerScriptEditBoxHandler(function(arg_4_0)
		if arg_4_0 == "changed" then
			local var_4_0 = tonumber(var_3_0:getText()) or arg_3_0._minCount
			local var_4_1 = math.max(arg_3_1, var_4_0)

			if arg_3_2 then
				var_4_1 = math.min(arg_3_2, var_4_0)
			end

			var_3_0:setText(tostring(var_4_1))

			arg_3_0._count = var_4_1

			arg_3_0:onCountChange()
		end
	end)

	local var_3_1 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_5_0)
		arg_3_0:onBtn(arg_5_0)
	end, ClientView.CRECT_BUTTON, 60, 50)

	var_3_1:addLabel("-")
	lc.addChildToPos(arg_3_0, var_3_1, cc.p(lc.left(var_3_0) - 10 - lc.cw(var_3_1), lc.ch(arg_3_0)))

	arg_3_0._btnSub = var_3_1

	local var_3_2 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_6_0)
		arg_3_0:onBtn(arg_6_0)
	end, ClientView.CRECT_BUTTON, 60, 50)

	var_3_2:addLabel("+")
	lc.addChildToPos(arg_3_0, var_3_2, cc.p(lc.right(var_3_0) + 10 + lc.cw(var_3_2), lc.ch(arg_3_0)))

	arg_3_0._btnAdd = var_3_2

	if arg_3_0._maxCount then
		local var_3_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_7_0)
			arg_3_0:onBtn(arg_7_0)
		end, ClientView.CRECT_BUTTON, 60, 50)

		var_3_3:addIcon("img_arrow_1")
		var_3_3._icon:setRotation(90)
		lc.addChildToPos(arg_3_0, var_3_3, cc.p(lc.right(arg_3_0._btnAdd) + 10 + lc.cw(var_3_3), lc.ch(arg_3_0)))

		arg_3_0._btnMax = var_3_3
	end

	arg_3_0:updateView()
end

function var_0_0.onBtn(arg_8_0, arg_8_1)
	if arg_8_1 == arg_8_0._btnAdd then
		arg_8_0._count = arg_8_0._count + 1
	elseif arg_8_1 == arg_8_0._btnSub then
		arg_8_0._count = arg_8_0._count - 1
	elseif arg_8_1 == arg_8_0._btnMax then
		arg_8_0._count = arg_8_0._maxCount
	end

	if arg_8_0._maxCount then
		arg_8_0._count = math.min(arg_8_0._maxCount, arg_8_0._count)
	end

	arg_8_0._editor:setText(tostring(arg_8_0._count))
	arg_8_0:updateView()
end

function var_0_0.getCount(arg_9_0)
	return tonumber(arg_9_0._editor:getText())
end

function var_0_0.onCountChange(arg_10_0)
	if arg_10_0._callback then
		arg_10_0._callback(arg_10_0:getCount())
	end
end

function var_0_0.updateView(arg_11_0)
	arg_11_0._btnAdd:setEnabled(true)
	arg_11_0._btnSub:setEnabled(true)

	if arg_11_0._count <= arg_11_0._minCount then
		arg_11_0._btnSub:setEnabled(false)
	end

	if arg_11_0._maxCount and arg_11_0._count >= arg_11_0._maxCount then
		arg_11_0._btnAdd:setEnabled(false)
	end
end

function var_0_0.onEnter(arg_12_0)
	return
end

function var_0_0.onExit(arg_13_0)
	return
end

function var_0_0.onCleanup(arg_14_0)
	return
end

return var_0_0
