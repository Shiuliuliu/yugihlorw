local var_0_0 = require("BasePanel")
local var_0_1 = class("ShopPanel", var_0_0)

function var_0_1.create(...)
	local var_1_0 = var_0_1.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1)
	arg_2_0._isShowResourceUI = true

	var_0_1.super.init(arg_2_0, true)

	local var_2_0 = ClientView.createTitleArea(Str(STR.COLLECT_SHOP), function()
		if arg_2_0._floatChapter then
			arg_2_0:onUnselectChapter(arg_2_0._floatChapter)
		else
			arg_2_0:hide()
		end
	end)

	arg_2_0:addChild(var_2_0, 1)

	arg_2_0._titleArea = var_2_0

	local var_2_1 = require("CollectShopArea").create(lc.w(arg_2_0) - 200, lc.bottom(var_2_0), arg_2_1)

	lc.addChildToPos(arg_2_0, var_2_1, cc.p(lc.cw(arg_2_0), lc.ch(var_2_1) - 20))
end

function var_0_1.onEnter(arg_4_0)
	var_0_1.super.onEnter(arg_4_0)
	ClientView.getResourceUI():setMode(Data.PropsId.collect_shop_token)

	arg_4_0._listeners = {}
end

function var_0_1.onExit(arg_5_0)
	var_0_1.super.onExit(arg_5_0)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_5_1)
	end
end

function var_0_1.onCleanup(arg_6_0)
	var_0_1.super.onCleanup(arg_6_0)
end

return var_0_1
