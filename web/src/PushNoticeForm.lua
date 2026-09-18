local var_0_0 = class("PushNoticeForm", BaseForm)
local var_0_1 = cc.size(600, 620)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.PUSH_NOTICE), bor(var_0_0.FLAG.PAPER_BG, var_0_0.FLAG.BASE_TITLE_BG, var_0_0.FLAG.SCROLL_V))
	arg_2_0._form:setTouchEnabled(false)

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._bg), lc.h(arg_2_0._bg) - 10 - lc.h(arg_2_0._titleFrame)), 20, 10)

	lc.addChildToPos(arg_2_0._bg, var_2_0, cc.p(4, 12))

	arg_2_0._list = var_2_0

	arg_2_0:addItem(ClientData.ConfigKey.push_grain_noon, STR.PUSH_GRAIN_NOON)
	arg_2_0:addItem(ClientData.ConfigKey.push_grain_night, STR.PUSH_GRAIN_NIGHT)
	arg_2_0:addItem(ClientData.ConfigKey.push_reward_send, STR.PUSH_REWARD_SEND)
	arg_2_0:addItem(ClientData.ConfigKey.push_copy_pvp_unlock, STR.PUSH_COPY_PVP_UNLOCK)
	arg_2_0:addItem(ClientData.ConfigKey.push_union_help, STR.PUSH_UNION_HELP)
	arg_2_0:addItem(ClientData.ConfigKey.push_grain_full, STR.PUSH_GRAIN_FULL)
	arg_2_0:addItem(ClientData.ConfigKey.push_gold_full, STR.PUSH_GOLD_FULL)
	arg_2_0:addItem(ClientData.ConfigKey.push_guard_fragment, STR.PUSH_GUARD_FRAGMENT)
	arg_2_0:addItem(ClientData.ConfigKey.push_palace_task, STR.PUSH_PALACE_TASK)
end

function var_0_0.addItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = lc.UserDefault:getBoolForKey(arg_3_1, true)
	local var_3_1 = ccui.Widget:create()

	var_3_1._isOn = var_3_0

	local function var_3_2(arg_4_0, arg_4_1)
		if arg_4_1 then
			arg_4_0._label:setString(Str(STR.ON))
			arg_4_0:loadTextureNormal("img_btn_1", ccui.TextureResType.plistType)
		else
			arg_4_0._label:setString(Str(STR.OFF))
			arg_4_0:loadTextureNormal("img_btn_2", ccui.TextureResType.plistType)
		end
	end

	local var_3_3 = ClientView.createShaderButton("img_btn_1", function(arg_5_0)
		var_3_1._isOn = not var_3_1._isOn

		lc.UserDefault:setBoolForKey(arg_3_1, var_3_1._isOn)

		if arg_3_1 == ClientData.ConfigKey.push_copy_pvp or arg_3_1 == ClientData.ConfigKey.push_union_help then
			ClientData.syncServerPush()
		end

		var_3_2(arg_5_0, var_3_1._isOn)
	end)

	var_3_1:setContentSize(420, lc.h(var_3_3))
	var_3_3:addLabel("")
	lc.addChildToPos(var_3_1, var_3_3, cc.p(lc.w(var_3_1) - lc.w(var_3_3) / 2, lc.h(var_3_1) / 2))
	var_3_2(var_3_3, var_3_0)

	local var_3_4 = ClientView.createBoldRichText(Str(arg_3_2), ClientView.RICHTEXT_PARAM_DARK_S1)

	lc.addChildToPos(var_3_1, var_3_4, cc.p(lc.w(var_3_4) / 2, lc.h(var_3_1) / 2))
	arg_3_0._list:pushBackCustomItem(var_3_1)

	return var_3_1
end

return var_0_0
