local var_0_0 = class("VIPForm", BaseForm)
local var_0_1 = cc.size(980, 648)
local var_0_2 = cc.size(246, 474)
local var_0_3 = 1000

function var_0_0.create()
	local var_1_0 = ClientView._resExchangeForms[Data.ResType.ingot]

	if var_1_0 then
		var_1_0:switchMode()
	else
		var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

		var_1_0:init()

		ClientView._resExchangeForms[Data.ResType.ingot] = var_1_0
	end

	return var_1_0
end

function var_0_0.init(arg_2_0)
	local var_2_0 = Str(STR.RECHARGE)

	var_0_0.super.init(arg_2_0, var_0_1, var_2_0, bor(BaseForm.FLAG.ADVANCE_TITLE_BG, BaseForm.FLAG.PAPER_BG, BaseForm.FLAG.BOTTOM_AREA, BaseForm.FLAG.SCROLL_H))

	if ClientData.getAppStoreReviewingType() == 3 then
		arg_2_0._frame:removeFromParent()

		arg_2_0._frame = lc.createSprite({
			_name = "city_3_charge_bg",
			_crect = cc.rect(365, 288, 2, 1),
			_size = var_0_1
		})

		lc.addChildToCenter(arg_2_0, arg_2_0._frame)
		arg_2_0._titleFrame:setVisible(false)
		arg_2_0._btnBack:setVisible(false)

		local var_2_1 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_2_0)

		var_2_1:setColor(ClientView.COLOR_TEXT_LIGHT)
		var_2_1:setPosition(lc.cw(arg_2_0._frame) - 350, lc.h(arg_2_0._frame) - 40)
		arg_2_0._frame:addChild(var_2_1, 20)

		local var_2_2 = ClientView.createShaderButton("city_3_charge_close", function(arg_3_0)
			arg_2_0:hide()
		end)

		var_2_2:setPosition(lc.w(arg_2_0._frame) - 24, lc.h(arg_2_0._frame) - 56)
		var_2_2:setZoomScale(0)
		var_2_2:setTouchRect(cc.rect(0, 0, lc.w(var_2_2) + 30, lc.h(var_2_2) + 30))
		arg_2_0._frame:addChild(var_2_2, 20)
	end

	arg_2_0._isShowResourceUI = true
end

function var_0_0.switchMode(arg_4_0)
	local var_4_0 = arg_4_0._purchaseList

	if not var_4_0 then
		if ClientData.getAppStoreReviewingType() == 3 then
			var_4_0 = lc.List.createH(cc.size(lc.w(arg_4_0._frame) - 38, lc.h(arg_4_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - lc.h(arg_4_0._frameBottomBg)), 20, 20)

			var_4_0:setAnchorPoint(0.5, 0.5)
			lc.addChildToPos(arg_4_0._frame, var_4_0, cc.p(lc.w(arg_4_0._frame) / 2, lc.h(arg_4_0._frame) - 84 - lc.h(var_4_0) / 2))
		else
			var_4_0 = lc.List.createH(cc.size(lc.w(arg_4_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_4_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - lc.h(arg_4_0._frameBottomBg)), 20, 20)

			var_4_0:setAnchorPoint(0.5, 0.5)
			lc.addChildToPos(arg_4_0._frame, var_4_0, cc.p(lc.w(arg_4_0._frame) / 2, lc.h(arg_4_0._frame) - 48 - lc.h(var_4_0) / 2))
		end

		arg_4_0._purchaseList = var_4_0

		local var_4_1 = {
			Data.PurchaseType.product_1,
			Data.PurchaseType.product_2,
			Data.PurchaseType.product_3,
			Data.PurchaseType.product_4,
			Data.PurchaseType.product_5,
			Data.PurchaseType.product_6,
			Data.PurchaseType.month_card_1,
			Data.PurchaseType.month_card_2,
			Data.PurchaseType.fund,
			Data.PurchaseType.package_1,
			Data.PurchaseType.package_2,
			Data.PurchaseType.package_3
		}

		if lc.App:getChannelName() == "FACEBOOK" then
			if lc.PLATFORM == cc.PLATFORM_OS_ANDROID then
				table.insert(var_4_1, Data.PurchaseType.product_7)
			end
		elseif lc.PLATFORM ~= cc.PLATFORM_OS_IPHONE and lc.PLATFORM ~= cc.PLATFORM_OS_IPAD then
			table.insert(var_4_1, Data.PurchaseType.product_7)
			table.insert(var_4_1, Data.PurchaseType.product_8)
		end

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			local var_4_2 = arg_4_0:createPurchaseItem(iter_4_1)

			var_4_0:pushBackCustomItem(var_4_2)
		end
	end

	var_4_0:setVisible(true)
	arg_4_0._titleLabel:setString(Str(STR.RECHARGE))
	arg_4_0:updatePurchaseItems()
end

function var_0_0.createPurchaseItem(arg_5_0, arg_5_1)
	local var_5_0 = ccui.Widget:create()

	var_5_0:setContentSize(var_0_2)

	local var_5_1 = var_0_2.width
	local var_5_2 = var_0_2.height
	local var_5_3 = arg_5_1 == Data.PurchaseType.month_card_2
	local var_5_4 = cc.LayerGradient:create(cc.c4b(60, 140, 170, 255), cc.c4b(10, 20, 30, 255))

	var_5_4:setContentSize(var_5_1 - 32, var_5_2 - 32)
	lc.addChildToCenter(var_5_0, var_5_4)

	local var_5_5

	if ClientData.getAppStoreReviewingType() == 3 then
		var_5_5 = lc.createSprite("city_3_charge_item_bg")

		var_5_5:setScale(1.3)
	else
		var_5_5 = lc.createSprite("img_com_bg_31")
	end

	lc.addChildToCenter(var_5_0, var_5_5)

	local var_5_6 = lc.createSprite("img_glow")

	var_5_6:setScale(0.75)
	var_5_6:runAction(lc.rep(lc.spawn(lc.rotateBy(4, 10), {
		lc.scaleTo(2, 0.7),
		lc.scaleTo(2, 0.8)
	})))
	lc.addChildToPos(var_5_0, var_5_6, cc.p(var_5_1 / 2, var_5_2 / 2 + 30))

	local var_5_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, ClientData.getProductTitle(arg_5_1))

	var_5_7:setColor(ClientView.COLOR_TEXT_INGOT)

	if arg_5_1 == Data.PurchaseType.month_card_1 or var_5_3 then
		if not ClientData.isAppStoreReviewing() then
			local var_5_8 = var_5_3 and P._monthCardDay2 or P._monthCardDay1
			local var_5_9 = cc.Label:createWithTTF(Str(STR.REMAIN_DAY) .. " : " .. string.format("%d", var_5_8), ClientView.TTF_FONT, ClientView.FontSize.S2)

			var_5_9:setColor(ClientView.COLOR_TEXT_GREEN)
			var_5_9:setVisible(var_5_8 > 0)
			lc.addChildToPos(var_5_0, var_5_9, cc.p(var_5_1 / 2, var_5_2 - 50 - lc.h(var_5_7) / 2))

			if var_5_3 then
				arg_5_0._labelMonthCard2 = var_5_9
			else
				arg_5_0._labelMonthCard1 = var_5_9
			end
		end
	elseif arg_5_1 == Data.PurchaseType.fund and not ClientData.isAppStoreReviewing() then
		local var_5_10 = {
			_normalClr = ClientView.COLOR_TEXT_GREEN,
			_boldClr = lc.Color3B.white,
			_fontSize = ClientView.FontSize.S2
		}
		local var_5_11 = ClientView.createBoldRichText(string.format(Str(STR.CAN_GET_X), ClientData.getNameByInfoId(Data.PropsId.union_fund)), var_5_10)

		var_5_11:setVisible(ClientData.isRecharged(Data.PurchaseType.fund))
		lc.addChildToPos(var_5_0, var_5_11, cc.p(var_5_1 / 2, var_5_2 - 50 - lc.h(var_5_7) / 2))

		arg_5_0._labelFund = var_5_11
	end

	lc.addChildToPos(var_5_0, var_5_7, cc.p(var_5_1 / 2, var_5_2 - 20 - lc.h(var_5_7) / 2))

	if ClientData.getAppStoreReviewingType() == 3 then
		lc.offset(var_5_7, 0, -4)
	end

	if ClientData.getAppStoreReviewingType() == 3 and lc.FrameCache:getSpriteFrame("city_3_charge_item_" .. arg_5_1) ~= nil then
		local var_5_12 = lc.createSprite("city_3_charge_item_" .. arg_5_1)

		lc.addChildToPos(var_5_0, var_5_12, cc.p(var_5_1 / 2, lc.y(var_5_6)))
	else
		local var_5_13 = DragonBones.create(arg_5_1 < Data.PurchaseType.package_1 and (arg_5_1 < Data.PurchaseType.month_card_1 and "baoshi" or "jinbi") or "lihe")
		local var_5_14 = arg_5_1

		if arg_5_1 == Data.PurchaseType.month_card_1 then
			var_5_14 = ClientData.isAppStoreReviewing() and 12 or 9
		elseif var_5_3 then
			var_5_14 = ClientData.isAppStoreReviewing() and 13 or 10
		elseif arg_5_1 == Data.PurchaseType.fund then
			var_5_14 = ClientData.isAppStoreReviewing() and 14 or 11
		end

		var_5_13:gotoAndPlay("effect" .. var_5_14)
		lc.addChildToPos(var_5_0, var_5_13, cc.p(var_5_1 / 2, lc.y(var_5_6)))
	end

	local var_5_15 = ClientView.createScale9ShaderButton(ClientData.getAppStoreReviewingType() == 3 and "city_3_charge_btn_1" or "img_btn_1_s", function(arg_6_0)
		arg_5_0:onBuyIngot(arg_5_1)
	end, ClientData.getAppStoreReviewingType() == 3 and cc.rect(65, 20, 2, 2) or ClientView.CRECT_BUTTON_S, 190, 60)

	var_5_15:setDisabledShader(ClientView.SHADER_DISABLE)
	var_5_15:addLabel(ClientData.getDisplayPrice(arg_5_1))
	lc.addChildToPos(var_5_0, var_5_15, cc.p(var_5_1 / 2, 20 + lc.h(var_5_15) / 2))

	if arg_5_1 == Data.PurchaseType.month_card_1 or var_5_3 then
		if not ClientData.isAppStoreReviewing() then
			local var_5_16 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_7_0)
				arg_5_0:hide()

				if ClientView._checkinForm then
					ClientView._checkinForm:showTab(4)
				else
					require("CheckinForm").create(4):show()
				end
			end, ClientView.CRECT_BUTTON_S, 190)

			var_5_16:addLabel(Str(STR.GIFT_DETAIL))
			lc.addChildToPos(var_5_0, var_5_16, cc.p(var_5_1 / 2, lc.top(var_5_15) + lc.h(var_5_16) / 2 + 6))
		else
			local var_5_17 = ClientView.createBoldRichText((var_5_3 and "10000" or "4000") .. Str(STR.SID_RES_NAME_1), ClientView.RICHTEXT_PARAM_LIGHT_S2)

			var_5_17:setPosition(var_5_1 / 2, lc.top(var_5_15) + lc.h(var_5_17) / 2 + 16)
			var_5_0:addChild(var_5_17)
		end
	elseif arg_5_1 == Data.PurchaseType.fund then
		if not ClientData.isAppStoreReviewing() then
			local var_5_18 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_8_0)
				arg_5_0:hide()

				if ClientView._fundForm == nil then
					require("FundForm").create():show()
				end
			end, ClientView.CRECT_BUTTON_S, 190)

			var_5_18:addLabel(Str(STR.FUND) .. Str(STR.DETAIL))
			lc.addChildToPos(var_5_0, var_5_18, cc.p(var_5_1 / 2, lc.top(var_5_15) + lc.h(var_5_18) / 2 + 6))
		else
			local var_5_19 = ClientView.createBoldRichText("14000" .. Str(STR.SID_RES_NAME_1), ClientView.RICHTEXT_PARAM_LIGHT_S2)

			var_5_19:setPosition(var_5_1 / 2, lc.top(var_5_15) + lc.h(var_5_19) / 2 + 16)
			var_5_0:addChild(var_5_19)
		end
	elseif arg_5_1 >= Data.PurchaseType.package_1 then
		local var_5_20 = ClientView.createScale9ShaderButton(ClientData.getAppStoreReviewingType() == 3 and "city_3_charge_btn_2" or "img_btn_2_s", function(arg_9_0)
			local var_9_0 = arg_5_1 - Data.PurchaseType.package_1 + 7017
			local var_9_1 = Data._bonusInfo[var_9_0]

			ClientData.modifyPackageBonus(var_9_1, arg_5_1)
			require("PackageDetailForm").create(var_9_1, ClientData.getProductTitle(arg_5_1)):show()
		end, ClientData.getAppStoreReviewingType() == 3 and cc.rect(65, 20, 2, 2) or ClientView.CRECT_BUTTON_S, 190, 60)

		var_5_20:addLabel(Str(STR.PACKAGE_DETAIL))
		lc.addChildToPos(var_5_0, var_5_20, cc.p(var_5_1 / 2, lc.top(var_5_15) + lc.h(var_5_20) / 2 + 6))
	end

	var_5_0._index = arg_5_1

	return var_5_0
end

function var_0_0.updatePurchaseItems(arg_10_0)
	if arg_10_0._purchaseList == nil then
		return
	end

	local var_10_0 = arg_10_0._purchaseList:getItems()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = iter_10_1._index

		if var_10_1 < Data.PurchaseType.month_card_1 then
			iter_10_1:removeChildrenByTag(var_0_3)

			local var_10_2, var_10_3 = ClientData.getIngot(var_10_1, true)
			local var_10_4 = ClientView.createBoldRichText(string.format(Str(STR.CHARGE_BONUS_INGOT), var_10_3), ClientView.RICHTEXT_PARAM_LIGHT_S2)

			var_10_4:setPosition(lc.w(iter_10_1) / 2, 120)
			var_10_4:setVisible(var_10_3 > 0)
			iter_10_1:addChild(var_10_4, 0, var_0_3)

			if P._playerActivity._actChargeBonus then
				local var_10_5 = lc.createSpriteWithMask("res/jpg/vip_ingot_bonus.jpg")

				lc.addChildToPos(iter_10_1, var_10_5, cc.p(lc.w(iter_10_1) - lc.w(var_10_5) / 2, lc.h(iter_10_1) - lc.h(var_10_5) / 2 + 3), 0, var_0_3)
			end
		end
	end
end

function var_0_0.onEnter(arg_11_0)
	var_0_0.super.onEnter(arg_11_0)
	arg_11_0:switchMode()

	arg_11_0._listeners = {}

	local var_11_0 = lc.addEventListener(Data.Event.recharge_success, function(arg_12_0)
		if not ClientData.isAppStoreReviewing() then
			if arg_12_0._type == Data.PurchaseType.month_card_1 then
				arg_11_0._labelMonthCard1:setVisible(true)
				arg_11_0._labelMonthCard1:setString(Str(STR.REMAIN_DAY) .. " : " .. string.format("%d", P._monthCardDay1))
			elseif arg_12_0._type == Data.PurchaseType.month_card_2 then
				arg_11_0._labelMonthCard2:setVisible(true)
				arg_11_0._labelMonthCard2:setString(Str(STR.REMAIN_DAY) .. " : " .. string.format("%d", P._monthCardDay2))
			elseif arg_12_0._type == Data.PurchaseType.fund then
				arg_11_0._labelFund:setVisible(true)
			end
		end

		arg_11_0:updatePurchaseItems()
	end)

	table.insert(arg_11_0._listeners, var_11_0)
end

function var_0_0.onExit(arg_13_0)
	var_0_0.super.onExit(arg_13_0)

	for iter_13_0 = 1, #arg_13_0._listeners do
		lc.Dispatcher:removeEventListener(arg_13_0._listeners[iter_13_0])
	end
end

function var_0_0.onCleanup(arg_14_0)
	var_0_0.super.onCleanup(arg_14_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/vip_ingot_double.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/vip_ingot_bonus.jpg"))

	ClientView._resExchangeForms[Data.ResType.ingot] = nil
end

function var_0_0.onBuyIngot(arg_15_0, arg_15_1, arg_15_2)
	if not ClientData.isAppStoreReviewing() and arg_15_1 == Data.PurchaseType.fund and ClientData.isRecharged(arg_15_1) and not arg_15_2 then
		require("PromptForm").ConfirmBuyFund.create(function()
			arg_15_0:onBuyIngot(arg_15_1, true)
		end):show()

		return
	end

	ClientView.startIAP(arg_15_1)
end

return var_0_0
