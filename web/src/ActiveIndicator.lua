local var_0_0 = class("ActiveIndicator", require("BasePanel"))
local var_0_1 = 30

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, true, true)

	arg_2_0._ignoreBlur = true
	arg_2_0.Label = ccui.Text:create("", ClientView.TTF_FONT, ClientView.FontSize.M2)

	arg_2_0.Label:setColor(cc.c3b(18, 186, 255))
	arg_2_0:addChild(arg_2_0.Label)
end

function var_0_0.show(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._userData = arg_3_3
	arg_3_0._isShowing = true

	if arg_3_0:getParent() == nil then
		if arg_3_1 == nil then
			arg_3_0._isNeedTransparent = true
		end

		lc._runningScene._scene:addChild(arg_3_0, ClientData.ZOrder.indicator)
	end

	if arg_3_0.Bones == nil then
		arg_3_0.Bones = cc.DragonBonesNode:createWithDecrypt("res/effects/ddlj.lcres", "ddlj", "ddlj")

		arg_3_0:addChild(arg_3_0.Bones)
		arg_3_0.Bones:setPosition(lc.w(arg_3_0) / 2, lc.h(arg_3_0) / 2 + 80)
	end

	arg_3_0.Label:setVisible(false)
	arg_3_0.Bones:setVisible(false)
	arg_3_0:setBackGroundColorOpacity(0)

	arg_3_0._timestamp = lc.Director:getCurrentTime()

	arg_3_0:stopAllActions()

	if arg_3_1 == nil then
		return
	end

	arg_3_0.Label:setPosition(lc.w(arg_3_0) / 2, lc.h(arg_3_0) / 2 - 60)
	arg_3_0.Label:setString(arg_3_1)

	local var_3_0 = arg_3_2 or 0

	arg_3_0:runAction(lc.sequence(var_3_0, function()
		arg_3_0.Label:setVisible(true)
		arg_3_0.Bones:setVisible(true)
		arg_3_0.Bones:gotoAndPlay("effect")
		arg_3_0:setBackGroundColorOpacity(var_0_0.DEFAULT_MASK_OPACITY)
	end))
end

function var_0_0.onEnter(arg_5_0)
	local var_5_0 = timeoutDuration or var_0_1

	arg_5_0._schedule = lc.Scheduler:scheduleScriptFunc(function(arg_6_0)
		lc.log("-------------------ActiveIndicator TimeOut")

		if arg_5_0._schedule then
			lc.Scheduler:unscheduleScriptEntry(arg_5_0._schedule)

			arg_5_0._schedule = nil
		end

		local var_6_0 = lc._runningScene

		if var_6_0 and var_6_0._reloadDialog == nil then
			var_6_0:showReloadDialog(Str(STR.DISCONNECT), msgStatus)
		end
	end, var_5_0, false)
end

function var_0_0.onExit(arg_7_0)
	if arg_7_0._schedule then
		lc.Scheduler:unscheduleScriptEntry(arg_7_0._schedule)

		arg_7_0._schedule = nil
	end
end

function var_0_0.hide(arg_8_0)
	local var_8_0 = arg_8_0._userData

	arg_8_0._userData = nil
	arg_8_0._isShowing = false

	if arg_8_0:getParent() ~= nil then
		arg_8_0:removeFromParent(false)
	end

	if arg_8_0.Bones ~= nil then
		arg_8_0.Bones:removeFromParent()

		arg_8_0.Bones = nil

		cc.DragonBonesNode:removeTextureAtlas("loading")
		lc.TextureCache:removeTextureForKey("loading.png")
	end

	arg_8_0:stopAllActions()

	return var_8_0
end

function var_0_0.getDuration(arg_9_0)
	return lc.Director:getCurrentTime() - arg_9_0._timestamp
end

return var_0_0
