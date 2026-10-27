local var_0_0 = class("ExchangeCodeForm", BaseForm)
local var_0_1 = cc.size(640, 360)
local var_0_2 = 32

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local formW = lc.w(arg_2_0._form)
	local formH = lc.h(arg_2_0._form)

	local var_2_0 = cc.Label:createWithTTF(Str(STR.INPUT_EXCHANGE_CODE) .. ":", ClientView.TTF_FONT, ClientView.FontSize.S1)
	var_2_0:setColor(ClientView.COLOR_TEXT_LIGHT)
	var_2_0:setAnchorPoint(0, 0.5)
	var_2_0:setPosition(formW / 2 - 220, formH - var_0_0.TOP_MARGIN - 50)
	arg_2_0._form:addChild(var_2_0)
	arg_2_0._label = var_2_0

	local var_2_1 = cc.size(440, 60)
	local placeholder = "Nhập mã quà tặng..."
	local var_2_2 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, var_2_1, placeholder, true, var_0_2)
	var_2_2:setPosition(formW / 2, formH / 2 + 10)
	arg_2_0._form:addChild(var_2_2)
	arg_2_0._editor = var_2_2

	if var_2_2.setDelegate then
		var_2_2:setDelegate({
			editBoxReturn = function()
				arg_2_0:onExchange()
			end
		})
	end

	local var_2_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_3_0)
		arg_2_0:onExchange()
	end, ClientView.CRECT_BUTTON, ClientView.PANEL_BTN_WIDTH)

	var_2_3:addLabel(Str(STR.EXCHANGE))
	lc.addChildToPos(arg_2_0._form, var_2_3, cc.p(formW / 2, var_0_0.FRAME_THICK_BOTTOM + 30 + lc.h(var_2_3) / 2))
	arg_2_0._btnOk = var_2_3
end

function var_0_0.onEnter(arg_4_0)
	var_0_0.super.onEnter(arg_4_0)
	ClientData.addMsgListener(arg_4_0, function(arg_5_0)
		return arg_4_0:onMsg(arg_5_0)
	end, 0)
end

function var_0_0.onExit(arg_6_0)
	var_0_0.super.onExit(arg_6_0)
	ClientData.removeMsgListener(arg_6_0)
end

function var_0_0.onMsg(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.type

	if var_7_0 == (SglMsgType_pb and SglMsgType_pb.PB_TYPE_USER_CLAIM_GIFT or 313) then
		ClientView.getActiveIndicator():hide()
		arg_7_0:hide()
		local rewards = arg_7_1.rewards or (arg_7_1.Extensions and (
			arg_7_1.Extensions["user_claim_gift_resp"] or 
			arg_7_1.Extensions[305] or 
			(User_pb and User_pb.SglUserMsg and User_pb.SglUserMsg.user_claim_gift_resp and arg_7_1.Extensions[User_pb.SglUserMsg.user_claim_gift_resp])
		))
		if rewards and type(rewards) == "table" and #rewards > 0 then
			pcall(function()
				local rp = require("RewardPanel")
				rp.create(rewards, rp.MODE_EXCHANGE):show()
			end)
		end

		return true
	end

	return false
end

function var_0_0.onExchange(arg_8_0)
	local raw = arg_8_0._editor and arg_8_0._editor:getText() or ""
	local var_8_0 = string.trim(raw)

	if var_8_0 == "" or var_8_0 == "Nhập mã quà tặng..." then
		ToastManager.push(Str(STR.INPUT_EXCHANGE_CODE))
	elseif #var_8_0 > var_0_2 then
		ToastManager.push(string.format(Str(STR.CANNOT_MORE_THAN), var_0_2))
	else
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
		pcall(function()
			if lc and lc.Director and lc.Director.getScheduler then
				local entry
				entry = lc.Director:getScheduler():scheduleScriptFunc(function()
					if entry then lc.Director:getScheduler():unscheduleScriptEntry(entry) end
					pcall(function() ClientView.getActiveIndicator():hide() end)
				end, 6.0, false)
			end
		end)
		ClientData.sendUserGiftExchange(var_8_0, arg_8_0)
	end
end

return var_0_0
