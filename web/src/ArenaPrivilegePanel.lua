local var_0_0 = class("ArenaPrivilegePanel", BasePanel)

var_0_0.Mode = {
	arena = 1,
	survival = 2
}
var_0_0.Defs = {}
var_0_0.Defs[var_0_0.Mode.arena] = {
	_bgs = {
		"arena_ad_1",
		"arena_ad_2"
	},
	_purchaseTypes = {
		Data.PurchaseType.arena_privilege_1,
		Data.PurchaseType.arena_privilege_2
	},
	_tips1 = {
		Str(STR.ARENA_PRIVILEGE_SILVER_TIP_1),
		Str(STR.ARENA_PRIVILEGE_GOLD_TIP_1)
	},
	_tips2 = {
		Str(STR.ARENA_PRIVILEGE_SILVER_TIP_2),
		Str(STR.ARENA_PRIVILEGE_GOLD_TIP_2)
	},
	_tips3 = {
		nil,
		Str(STR.ARENA_PRIVILEGE_GOLD_TIP_3)
	}
}
var_0_0.Defs[var_0_0.Mode.survival] = {
	_bgs = {
		"survival_ad_1",
		"survival_ad_2"
	},
	_purchaseTypes = {
		Data.PurchaseType.survival_privilege_1,
		Data.PurchaseType.survival_privilege_2
	},
	_tips1 = {
		Str(STR.SURVIVAL_PRIVILEGE_SILVER_TIP_1),
		Str(STR.SURVIVAL_PRIVILEGE_GOLD_TIP_1)
	},
	_tips2 = {
		Str(STR.SURVIVAL_PRIVILEGE_SILVER_TIP_2),
		Str(STR.SURVIVAL_PRIVILEGE_GOLD_TIP_2)
	},
	_tips3 = {
		nil,
		Str(STR.SURVIVAL_PRIVILEGE_GOLD_TIP_3)
	}
}

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, false)

	arg_2_1 = arg_2_1 or var_0_0.Mode.arena
	arg_2_0._mode = arg_2_1

	local var_2_0 = lc.createNode()

	var_2_0:setContentSize(arg_2_0:getContentSize())
	lc.addChildToCenter(arg_2_0, var_2_0)

	arg_2_0._layout = var_2_0

	local var_2_1 = var_0_0.Defs[arg_2_0._mode]._purchaseTypes
	local var_2_2 = var_0_0.Defs[arg_2_0._mode]._tips1
	local var_2_3 = var_0_0.Defs[arg_2_0._mode]._tips2
	local var_2_4 = var_0_0.Defs[arg_2_0._mode]._tips3
	local var_2_5 = var_0_0.Defs[arg_2_0._mode]._bgs

	for iter_2_0 = 1, #var_2_1 do
		local var_2_6 = var_2_1[iter_2_0]
		local var_2_7 = cc.p(lc.cw(var_2_0) + (iter_2_0 == 1 and -300 or 300), lc.ch(var_2_0))
		local var_2_8 = ClientData.getPrice(var_2_6)
		local var_2_9 = P._playerBonus:getBonusIdByPurchaseType(var_2_6)
		local var_2_10 = P._playerBonus._bonuses[var_2_9]
		local var_2_11 = var_2_10._value
		local var_2_12 = var_2_10._info
		local var_2_13 = lc.createSpriteWithMask(lc.formatJpg(var_2_5[iter_2_0]))

		lc.addChildToPos(var_2_0, var_2_13, var_2_7)

		local var_2_14 = ClientView.createTTF(var_2_2[iter_2_0], ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE, cc.size(380, 0), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

		var_2_14:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_2_13, var_2_14, cc.p(25, 200 - lc.ch(var_2_14)))

		local var_2_15 = ClientView.createTTF(var_2_3[iter_2_0], ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE, cc.size(380, 0), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

		var_2_15:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_2_13, var_2_15, cc.p(25, lc.bottom(var_2_14) - 5 - lc.ch(var_2_15)))

		if var_2_4[iter_2_0] then
			local var_2_16 = ClientView.createTTF(var_2_4[iter_2_0], ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE, cc.size(380, 0), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

			var_2_16:setAnchorPoint(0, 0.5)
			lc.addChildToPos(var_2_13, var_2_16, cc.p(25, lc.bottom(var_2_15) - 5 - lc.ch(var_2_16)))
		end

		local var_2_17 = ClientView.createScale9ShaderButton("img_btn_3", nil, ClientView.CRECT_BUTTON, 200)

		lc.addChildToPos(var_2_13, var_2_17, cc.p(lc.cw(var_2_13), 10))
		var_2_17:setDisabledShader(ClientView.SHADER_DISABLE)

		local var_2_18 = P._playerActivity:getPurchaseRemainDay(var_2_6)

		if var_2_18 > 0 then
			var_2_17:addLabel(string.format(Str(STR.REMAIN_DAYS), var_2_18))
			var_2_17:setEnabled(false)
		else
			var_2_17:addLabel(Str(STR.BUY))

			function var_2_17._callback(arg_3_0)
				arg_2_0:onBuy(var_2_6)
			end
		end
	end

	var_2_0:setScale(0.5)
	var_2_0:runAction(lc.scaleTo(0.2, 1))
	arg_2_0:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 == ccui.TouchEventType.ended and not arg_2_0._isForce then
			var_2_0:runAction(lc.sequence(lc.scaleTo(0.2, 0.5), lc.call(function()
				arg_2_0:hide()
			end)))
		end
	end)
end

function var_0_0.onEnter(arg_6_0)
	var_0_0.super.onEnter(arg_6_0)
end

function var_0_0.onBuy(arg_7_0, arg_7_1)
	ClientView.startIAP(arg_7_1)
	arg_7_0:hide()
end

function var_0_0.onCleanup(arg_8_0)
	var_0_0.super.onCleanup(arg_8_0)
	lc.TextureCache:removeTextureForKey("res/jpg/arena_ad_1.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/arena_ad_2.jpg")
end

return var_0_0
