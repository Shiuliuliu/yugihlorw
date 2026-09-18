local var_0_0 = class("RechargeScene", require("BaseUIScene"))
local var_0_1 = 5
local var_0_2 = ClientView.SCR_CW + 120 * ((ClientView.SCR_W - 1024) / 342)

local function var_0_3()
	return #Data._globalInfo._vipIngot - 2
end

function var_0_0.create(...)
	return lc.createScene(var_0_0, ...)
end

function var_0_0.init(arg_3_0)
	if not var_0_0.super.init(arg_3_0, ClientData.SceneId.recharge, STR.RECHARGE, require("BaseUIScene").STYLE_TAB, false) then
		return false
	end

	arg_3_0._bg:setTexture("res/jpg/recharge_bg.jpg")

	local var_3_0 = "girl_recharge"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_3_0 .. "_2")) then
		var_3_0 = var_3_0 .. "_2"
	end

	local var_3_1 = lc.createSpriteWithMask(lc.formatJpg(var_3_0))

	lc.addChildToPos(arg_3_0._bg, var_3_1, cc.p(lc.cw(arg_3_0._bg) - ClientView.SCR_CW + lc.cw(var_3_1) - 100, ClientView.SCR_CH - 40))

	if ClientView.SCR_W > 1366 then
		-- block empty
	else
		local var_3_2 = lc.List.createH(cc.size(ClientView.SCR_W, 540))

		var_3_2:setBoundMargin(math.min(450, ClientView.SCR_W - 1000), 0)
		lc.addChildToPos(arg_3_0, var_3_2, cc.p(0, 0))

		arg_3_0._list = var_3_2
	end

	arg_3_0:initPurchase()
	arg_3_0:initVip()

	if ClientData.isAndroidTest0602() then
		local var_3_3 = ClientView.createTTF(Str(STR.ANDROID_TEST_TIP_1), ClientView.FontSize.S)

		lc.addChildToPos(arg_3_0, var_3_3, cc.p(lc.cw(arg_3_0), lc.ch(var_3_3) + 10))
	end

	return true
end

function var_0_0.onEnter(arg_4_0)
	var_0_0.super.onEnter(arg_4_0)

	local var_4_0 = {
		Data.Event.vip_dirty,
		Data.Event.vip_exp_dirty
	}

	arg_4_0._listeners = {}

	for iter_4_0 = 1, #var_4_0 do
		local var_4_1 = lc.addEventListener(var_4_0[iter_4_0], function(arg_5_0)
			arg_4_0:onEvent(var_4_0[iter_4_0])
		end)

		table.insert(arg_4_0._listeners, var_4_1)
	end
end

function var_0_0.onExit(arg_6_0)
	var_0_0.super.onExit(arg_6_0)

	for iter_6_0 = 1, #arg_6_0._listeners do
		lc.Dispatcher:removeEventListener(arg_6_0._listeners[iter_6_0])
	end

	ClientView.getMenuUI():updateActivityFlag()
end

function var_0_0.onCleanup(arg_7_0)
	var_0_0.super.onCleanup(arg_7_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/recharge_bg.jpg"))
end

function var_0_0.initPurchase(arg_8_0)
	local var_8_0 = {
		Data.PurchaseType.product_1,
		Data.PurchaseType.product_2,
		Data.PurchaseType.product_3,
		Data.PurchaseType.product_4,
		Data.PurchaseType.product_5,
		Data.PurchaseType.product_6
	}

	if lc.PLATFORM == cc.PLATFORM_OS_ANDROID or ClientData.isDEV() or ClientData.isYuGiOhExt() then
		table.insert(var_8_0, Data.PurchaseType.product_7)
		table.insert(var_8_0, Data.PurchaseType.product_8)
	end

	local var_8_1 = 20
	local var_8_2 = 50
	local var_8_3 = ccui.Widget:create()

	var_8_3:setContentSize(cc.size(#var_8_0 / 2 * 325, 540))

	arg_8_0._purchaseItems = {}

	for iter_8_0 = 1, #var_8_0 do
		local var_8_4 = var_8_0[iter_8_0]
		local var_8_5 = arg_8_0:createPurchaseItem(var_8_4)
		local var_8_6 = cc.p(162 + math.floor((iter_8_0 - 1) / 2) * 325, lc.ch(var_8_3) + (iter_8_0 % 2 - 0.5) * (lc.h(var_8_5) + var_8_2))

		lc.addChildToPos(var_8_3, var_8_5, var_8_6)

		arg_8_0._purchaseItems[iter_8_0] = var_8_5
	end

	if ClientView.SCR_W > 1366 then
		lc.addChildToPos(arg_8_0, var_8_3, cc.p(lc.w(arg_8_0) - lc.cw(var_8_3) - math.min(100, (ClientView.SCR_W - lc.w(var_8_3)) / 2), lc.ch(var_8_3)))
	else
		arg_8_0._list:pushBackCustomItem(var_8_3)
	end

	arg_8_0:updatePurchaseItems()
end

function var_0_0.createPurchaseItem(arg_9_0, arg_9_1)
	local var_9_0 = ClientView.createShaderButton("img_recharge_bg", function()
		arg_9_0:onBuyIngot(arg_9_1)
	end)
	local var_9_1 = DragonBones.create("baoshi")

	lc.addChildToPos(var_9_0, var_9_1, cc.p(lc.cw(var_9_0), lc.ch(var_9_0) + 44))
	var_9_1:gotoAndPlay("effect" .. arg_9_1)

	local var_9_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.RMB))

	lc.addChildToPos(var_9_0, var_9_2, cc.p(lc.cw(var_9_2) + 20, lc.ch(var_9_2) + 28))

	local var_9_3 = ClientData.getPrice(arg_9_1)
	local var_9_4 = ClientView.createBMFont(ClientView.BMFont.huali_32, var_9_3)

	lc.addChildToPos(var_9_0, var_9_4, cc.p(lc.cw(var_9_4) + 20 + lc.w(var_9_2), lc.ch(var_9_4) + 26))

	local var_9_5, var_9_6 = ClientData.getIngot(arg_9_1, false)
	local var_9_7 = ClientView.createBMFont(ClientView.BMFont.num_48, var_9_5)

	lc.addChildToPos(var_9_0, var_9_7, cc.p(lc.w(var_9_0) - lc.cw(var_9_7) - 56, lc.ch(var_9_7) + 14))

	local var_9_8 = lc.createSprite("img_icon_res3_s")

	lc.addChildToPos(var_9_0, var_9_8, cc.p(lc.w(var_9_0) - lc.cw(var_9_8) - 24, lc.ch(var_9_8) + 22))

	local var_9_9 = lc.createSprite("img_recharge_gift")

	lc.addChildToPos(var_9_0, var_9_9, cc.p(lc.w(var_9_0) - 40, lc.h(var_9_0) - 20))

	local var_9_10 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_9_6)

	lc.addChildToPos(var_9_9, var_9_10, cc.p(lc.cw(var_9_9) + 6, lc.ch(var_9_9) - 8))

	var_9_0._giftLabel = var_9_10

	local var_9_11 = Data.PropsId.cumulative_exchange_token
	local var_9_12 = 0

	if P._playerActivity._actChargeGift then
		var_9_12 = var_9_5 / 10
	end

	if var_9_12 > 0 then
		local var_9_13 = lc.createSprite("img_recharge_gift_2")

		lc.addChildToPos(var_9_0, var_9_13, cc.p(lc.w(var_9_0) - 50, lc.bottom(var_9_9) - lc.ch(var_9_13) - 20))

		local var_9_14 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_9_12)

		lc.addChildToPos(var_9_13, var_9_14, cc.p(lc.cw(var_9_9) + 46, lc.ch(var_9_9) - 20))

		var_9_0._giftLabel2 = var_9_14
	end

	local var_9_15 = lc.createSprite(not ClientData.isAndroidTest0602() and "img_recharge_double" or "img_recharge_double_test")

	lc.addChildToPos(var_9_0, var_9_15, cc.p(lc.w(var_9_0) - 40, lc.h(var_9_0) - 20))

	function var_9_0.update()
		local var_11_0, var_11_1 = ClientData.getIngot(arg_9_1, false)

		if not ClientData.isAndroidTest0602() then
			var_9_15:setVisible(var_11_0 == var_11_1 and ClientData.isRechargeDouble(arg_9_1))
			var_9_9:setVisible(var_11_1 > 0)
			var_9_10:setString(var_11_1)
		else
			var_9_15:setVisible(true)
			var_9_9:setVisible(false)
		end
	end

	return var_9_0
end

function var_0_0.updatePurchaseItems(arg_12_0)
	for iter_12_0 = 1, #arg_12_0._purchaseItems do
		arg_12_0._purchaseItems[iter_12_0]:update()
	end
end

function var_0_0.initVip(arg_13_0)
	local var_13_0 = cc.p(var_0_2, ClientView.SCR_CH + 220)
	local var_13_1 = lc.createSprite({
		_name = "img_com_bg_46",
		_crect = ClientView.CRECT_COM_BG46,
		_size = cc.size(810, 118)
	})

	lc.addChildToPos(arg_13_0, var_13_1, var_13_0)

	local var_13_2 = lc.createSprite("img_recharge_vip")

	lc.addChildToPos(arg_13_0, var_13_2, cc.p(var_13_0.x - 300, var_13_0.y + 4))

	local var_13_3 = ClientView.createBMFont(ClientView.BMFont.huali_32, 0)

	lc.addChildToPos(var_13_2, var_13_3, cc.p(lc.cw(var_13_2), lc.ch(var_13_2) - 24))

	arg_13_0._vip = var_13_3

	local var_13_4 = ClientView.createLabelProgressBar(440)

	lc.addChildToPos(arg_13_0, var_13_4, cc.p(var_13_0.x, var_13_0.y - 24))

	arg_13_0._progress = var_13_4

	local var_13_5 = ClientView.createTTF("", ClientView.FontSize.B2)

	lc.addChildToPos(arg_13_0, var_13_5, cc.p(0, 0))
	var_13_5:setColor(ClientView.COLOR_TEXT_VIP)

	arg_13_0._nextVip = var_13_5

	local var_13_6 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_14_0)
		require("VIPInfoForm").create():show()
	end, ClientView.CRECT_BUTTON_S, 120)

	lc.addChildToPos(arg_13_0, var_13_6, cc.p(var_13_0.x + 306, var_13_0.y))
	var_13_6:addLabel(Str(STR.PRIVILEGE))
	arg_13_0:updateVip()
end

function var_0_0.updateVip(arg_15_0)
	arg_15_0._vip:setString(P._vip)
	arg_15_0._nextVip:setString(string.format("VIP%d", P._vip + 1))
	arg_15_0._progress._bar:setPercent(P._vip < var_0_3() and P._vipExp * 100 / P:getVIPupExp() or 0)

	if arg_15_0._vipTip then
		arg_15_0._vipTip:removeFromParent()
	end

	arg_15_0._vipTip = arg_15_0:createVipTip()

	lc.addChildToPos(arg_15_0, arg_15_0._vipTip, cc.p(lc.left(arg_15_0._progress) + lc.cw(arg_15_0._vipTip) + 10, lc.y(arg_15_0._progress) + 44))
	arg_15_0._nextVip:setPosition(cc.p(lc.right(arg_15_0._vipTip) + lc.cw(arg_15_0._nextVip) + 10, lc.y(arg_15_0._vipTip) - 2))
	arg_15_0._nextVip:setVisible(P._vip < var_0_3())
end

function var_0_0.createVipTip(arg_16_0, arg_16_1)
	local var_16_0 = ccui.RichTextEx:create()

	if P._vip < var_0_3() then
		var_16_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(STR.RECHARGE_AGAIN), ClientView.TTF_FONT, ClientView.FontSize.S1))
		var_16_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_INGOT, 255, string.format(" %d ", P:getVIPupExp() - P._vipExp), ClientView.TTF_FONT, ClientView.FontSize.S1))
		var_16_0:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, lc.createSprite(string.format("img_icon_res%d_s", Data.ResType.ingot))))
		var_16_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, " " .. Str(STR.CAN_ARRIVE), ClientView.TTF_FONT, ClientView.FontSize.S1))
	else
		var_16_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(STR.VIP_MAX), ClientView.TTF_FONT, ClientView.FontSize.S1))

		local var_16_1 = ClientView.createBMFont(ClientView.BMFont.huali_26, string.format(" VIP %d", var_0_3()))

		var_16_1:setColor(ClientView.COLOR_TEXT_VIP)
		var_16_0:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, var_16_1))
	end

	var_16_0:formatText()

	return var_16_0
end

function var_0_0.onBuyIngot(arg_17_0, arg_17_1, arg_17_2)
	if ClientData.isAppStore() and not ClientData.isAppStoreReviewing() and P._playerBonus:getIapCount(arg_17_1) >= var_0_1 then
		require("Dialog").showDialog(string.format(Str(STR.SMALL_IAP_COUNT_EXCEED), var_0_1), nil, true)

		return
	end

	ClientView.startIAP(arg_17_1)
end

function var_0_0.onEvent(arg_18_0, arg_18_1)
	if arg_18_1 == Data.Event.vip_dirty or arg_18_1 == Data.Event.vip_exp_dirty then
		arg_18_0:updateVip()
		arg_18_0:updatePurchaseItems()
	end
end

return var_0_0
