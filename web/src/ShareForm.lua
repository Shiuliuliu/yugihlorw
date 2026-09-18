local var_0_0 = class("ShareForm", BaseForm)
local var_0_1 = require("PlayerLog")
local var_0_2 = cc.size(640, 280)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._logId = arg_2_1

	var_0_0.super.init(arg_2_0, var_0_2, Str(STR.SHARE), 0)

	local var_2_0 = arg_2_0._form
	local var_2_1, var_2_2 = P:isAllowChat()
	local var_2_3 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(500, 60), var_2_1 and Str(STR.INPUT_SHARE_TEXT) or string.gsub(var_2_2, "|", ""), true)

	lc.addChildToPos(var_2_0, var_2_3, cc.p(lc.w(var_2_0) / 2, lc.bottom(arg_2_0._titleFrame) - 20 - lc.h(var_2_3) / 2))

	arg_2_0._editor = var_2_3

	if not var_2_1 then
		var_2_3:setEnabled(false)
	end

	local var_2_4 = ClientView.createScale9ShaderButton("img_btn_2", function()
		arg_2_0:share()
	end, ClientView.CRECT_BUTTON, 120)

	var_2_4:addLabel(Str(STR.SHARE))
	lc.addChildToPos(var_2_0, var_2_4, cc.p(lc.right(var_2_3) - lc.w(var_2_4) / 2, 80))

	arg_2_0._btnShare = var_2_4

	if P._nextShareBattle - ClientData.getCurrentTime() > 0 then
		arg_2_0:scheduleUpdateWithPriorityLua(function(arg_4_0)
			local var_4_0 = P._nextShareBattle - ClientData.getCurrentTime()

			if var_4_0 < 0 then
				arg_2_0:updateTip("")
				arg_2_0:unscheduleUpdate()
			else
				local var_4_1 = string.format(Str(STR.SHARE_TIME), ClientData.formatPeriod(var_4_0))

				arg_2_0:updateTip(var_4_1)
			end
		end, 0)
	end
end

function var_0_0.updateTip(arg_5_0, arg_5_1)
	if arg_5_0._tip then
		arg_5_0._tip:removeFromParent()

		arg_5_0._tip = nil
	end

	local var_5_0 = ClientView.createBoldRichText(arg_5_1, ClientView.RICHTEXT_PARAM_DARK_S1)

	lc.addChildToPos(arg_5_0._form, var_5_0, cc.p(lc.left(arg_5_0._editor) + lc.w(var_5_0) / 2, lc.y(arg_5_0._btnShare)))

	arg_5_0._tip = var_5_0
end

function var_0_0.share(arg_6_0)
	if P._chatBanList[P._id] then
		arg_6_0._editor:setText("")
		ToastManager.push(Str(STR.CHAT_BAN_TIP))

		return
	end

	local var_6_0 = arg_6_0._logId
	local var_6_1 = arg_6_0._editor:getText()
	local var_6_2 = P._nextShareBattle - ClientData.getCurrentTime()
	local var_6_3, var_6_4 = P:isAllowChat()

	if #var_6_1 > 0 and not var_6_3 then
		return ToastManager.push(var_6_4)
	end

	if var_6_2 > 0 then
		ToastManager.push(string.format(Str(STR.SHARE_TIME), ClientData.formatPeriod(var_6_2)))
	elseif lc.utf8len(var_6_1) > ClientData.MAX_INPUT_LEN then
		ToastManager.push(Str(STR.MESSAGE) .. string.format(Str(STR.CANNOT_MORE_THAN), ClientData.MAX_INPUT_LEN))
	else
		ClientView.getActiveIndicator():show(Str(STR.WAITING), nil, arg_6_0)

		arg_6_0._isWaitingShare = true

		ClientData.sendBattleShare(var_6_0, var_6_1)
	end
end

function var_0_0.onEnter(arg_7_0)
	var_0_0.super.onEnter(arg_7_0)

	arg_7_0._listeners = {}

	table.insert(arg_7_0._listeners, lc.addEventListener(Data.Event.log_dirty, function(arg_8_0)
		arg_7_0:onLogEvent(arg_8_0)
	end))
	table.insert(arg_7_0._listeners, lc.addEventListener(Data.Event.log_shared, function(arg_9_0)
		arg_7_0:onLogEvent(arg_9_0)
	end))
end

function var_0_0.onExit(arg_10_0)
	var_0_0.super.onExit(arg_10_0)

	for iter_10_0 = 1, #arg_10_0._listeners do
		lc.Dispatcher:removeEventListener(arg_10_0._listeners[iter_10_0])
	end
end

function var_0_0.onLogEvent(arg_11_0, arg_11_1)
	local var_11_0 = ClientView.getActiveIndicator()

	if not arg_11_0._isWaitingShare or arg_11_1._logId ~= arg_11_0._logId then
		return
	end

	var_11_0:hide()

	if arg_11_1._event == var_0_1.Event.log_item_dirty then
		P._nextShareBattle = ClientData.getCurrentTime() + Data._globalInfo._battleShareCD * 60

		ToastManager.push(Str(STR.SHARE_SUCCESS))
	elseif arg_11_1._event == var_0_1.Event.log_already_shared then
		ToastManager.push(Str(STR.BATTLE_SHARED))
	end

	arg_11_0:hide()
end

return var_0_0
