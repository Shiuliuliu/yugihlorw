local var_0_0 = class("FundTasksPanel", BasePanel)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.init(arg_2_0, false)

	local var_2_0 = lc.createNode()

	var_2_0:setContentSize(arg_2_0:getContentSize())
	lc.addChildToCenter(arg_2_0, var_2_0)

	arg_2_0._layout = var_2_0

	local var_2_1 = "active_gift_bg"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_2_1 .. "_2")) then
		var_2_1 = var_2_1 .. "_2"
	end

	local var_2_2 = lc.createSprite(lc.formatJpg(var_2_1))

	lc.addChildToCenter(var_2_0, var_2_2)

	local var_2_3 = {
		Data.PurchaseType.active_1,
		Data.PurchaseType.active_2
	}

	for iter_2_0 = 1, #var_2_3 do
		local var_2_4 = var_2_3[iter_2_0]
		local var_2_5 = cc.p(lc.cw(var_2_0) + (iter_2_0 == 1 and -200 or 200), lc.ch(var_2_0))
		local var_2_6 = P._playerBonus._bonusActiveGift[iter_2_0]
		local var_2_7 = var_2_6._value
		local var_2_8 = var_2_6._info
		local var_2_9 = {}

		for iter_2_1 = 1, #var_2_8._rid do
			local var_2_10 = IconWidget.create({
				_infoId = var_2_8._rid[iter_2_1],
				_level = var_2_8._level[iter_2_1],
				_count = var_2_8._count[iter_2_1],
				_isFragment = var_2_8._isFragment[iter_2_1] > 0
			})

			var_2_10._name:setVisible(false)
			var_2_10:setScale(0.8)
			table.insert(var_2_9, var_2_10)
		end

		for iter_2_2 = 1, #var_2_9 do
			local var_2_11 = var_2_9[iter_2_2]
			local var_2_12 = cc.p(var_2_5.x + (lc.w(var_2_11) - 20) * (iter_2_2 - (#var_2_9 + 1) / 2), var_2_5.y - 100)

			lc.addChildToPos(var_2_0, var_2_11, var_2_12)
		end

		local var_2_13 = ClientView.createBMFont(ClientView.BMFont.huali_26, string.format(Str(STR.ACTIVE_GIFT_TIP), var_2_4 == Data.PurchaseType.active_1 and Data.ACTIVE_GIFT_1 or Data.ACTIVE_GIFT_2))

		var_2_13:setScale(0.8)
		var_2_13:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_2_0, var_2_13, cc.p(var_2_5.x - 170, var_2_5.y - 14))

		local var_2_14 = ClientView.createShaderButton("img_btn_recharge_2", function(arg_3_0)
			arg_2_0:onBuy(var_2_4)
		end)

		lc.addChildToPos(var_2_0, var_2_14, cc.p(var_2_5.x + 10, 130))
		var_2_14:setDisabledShader(ClientView.SHADER_DISABLE)

		if var_2_4 == Data.PurchaseType.active_1 and P._dailyActive < Data.ACTIVE_GIFT_1 then
			var_2_14:setEnabled(false)
			var_2_14:addLabel(Str(STR.BUY_NOW))
		elseif var_2_4 == Data.PurchaseType.active_2 and P._dailyActive < Data.ACTIVE_GIFT_2 then
			var_2_14:setEnabled(false)
			var_2_14:addLabel(Str(STR.BUY_NOW))
		elseif var_2_7 > 0 then
			var_2_14:setEnabled(false)
			var_2_14:addLabel(Str(STR.PURCHASED))
		else
			var_2_14:addLabel(Str(STR.BUY_NOW))
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
	lc.TextureCache:removeTextureForKey("res/jpg/active_gift_bg.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/active_gift_bg_2.jpg")
end

return var_0_0
