local var_0_0 = class("RechargeSkillTokenScene", require("BaseUIScene"))
local var_0_1 = ClientView.SCR_CW + 120 * ((ClientView.SCR_W - 1024) / 342)

function var_0_0.create(...)
	return lc.createScene(var_0_0, ...)
end

function var_0_0.init(arg_2_0)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.recharge, STR.RECHARGE, require("BaseUIScene").STYLE_TAB, false) then
		return false
	end

	arg_2_0._bg:setTexture("res/jpg/recharge_bg.jpg")

	local var_2_0 = "girl_recharge"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_2_0 .. "_2")) then
		var_2_0 = var_2_0 .. "_2"
	end

	local var_2_1 = lc.createSpriteWithMask(lc.formatJpg(var_2_0))

	lc.addChildToPos(arg_2_0._bg, var_2_1, cc.p(lc.cw(arg_2_0._bg) - ClientView.SCR_CW + lc.cw(var_2_1) - 100, ClientView.SCR_CH - 40))

	local var_2_2 = lc.List.createH(cc.size(ClientView.SCR_W, ClientView.SCR_H - 80))

	var_2_2:setBoundMargin(math.min(450, ClientView.SCR_W - 634), 0)
	lc.addChildToPos(arg_2_0, var_2_2, cc.p(0, 0))

	arg_2_0._list = var_2_2

	arg_2_0:initPurchase()

	if ClientData.isAndroidTest0602() then
		local var_2_3 = ClientView.createTTF(Str(STR.ANDROID_TEST_TIP_1), ClientView.FontSize.S)

		lc.addChildToPos(arg_2_0, var_2_3, cc.p(lc.cw(arg_2_0), lc.ch(var_2_3) + 10))
	end

	return true
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)
	V.getResourceUI():setMode(Data.PropsId.skill_item_token)
end

function var_0_0.onExit(arg_4_0)
	var_0_0.super.onExit(arg_4_0)
end

function var_0_0.onCleanup(arg_5_0)
	var_0_0.super.onCleanup(arg_5_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/recharge_bg.jpg"))
end

function var_0_0.initPurchase(arg_6_0)
	local var_6_0 = {
		Data.PurchaseType.skill_1,
		Data.PurchaseType.skill_2,
		Data.PurchaseType.skill_3
	}
	local var_6_1 = 20
	local var_6_2 = 50
	local var_6_3 = ccui.Widget:create()

	var_6_3:setContentSize(cc.size(#var_6_0 / 2 * 325, 540))

	arg_6_0._purchaseItems = {}

	for iter_6_0 = 1, #var_6_0 do
		local var_6_4 = var_6_0[iter_6_0]
		local var_6_5 = arg_6_0:createPurchaseItem(var_6_4)
		local var_6_6 = cc.p(162 + math.floor((iter_6_0 - 1) / 2) * 325, lc.ch(var_6_3) + (iter_6_0 % 2 - 0.5) * (lc.h(var_6_5) + var_6_2))

		lc.addChildToPos(var_6_3, var_6_5, var_6_6)

		arg_6_0._purchaseItems[iter_6_0] = var_6_5
	end

	if false then
		lc.addChildToPos(arg_6_0, var_6_3, cc.p(lc.w(arg_6_0) - lc.cw(var_6_3) - math.min(100, (ClientView.SCR_W - lc.w(var_6_3)) / 2), lc.ch(var_6_3)))
	else
		arg_6_0._list:pushBackCustomItem(var_6_3)
	end

	arg_6_0:updatePurchaseItems()
end

function var_0_0.createPurchaseItem(arg_7_0, arg_7_1)
	local var_7_0 = P._playerBonus:getBonusByPurchaseType(arg_7_1)
	local var_7_1 = ClientView.createShaderButton("img_recharge_bg", function()
		arg_7_0:onBuyIngot(arg_7_1)
	end)
	local var_7_2 = lc.createSprite("recharge_skill_" .. arg_7_1 - Data.PurchaseType.skill_1 + 1)

	lc.addChildToCenter(var_7_1, var_7_2)
	lc.offset(var_7_2, 0, 20)

	local var_7_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.RMB))

	lc.addChildToPos(var_7_1, var_7_3, cc.p(lc.cw(var_7_3) + 20, lc.ch(var_7_3) + 28))

	local var_7_4 = ClientData.getPrice(arg_7_1)
	local var_7_5 = ClientView.createBMFont(ClientView.BMFont.huali_32, var_7_4)

	lc.addChildToPos(var_7_1, var_7_5, cc.p(lc.cw(var_7_5) + 20 + lc.w(var_7_3), lc.ch(var_7_5) + 26))

	local var_7_6, var_7_7 = ClientData.getIngot(arg_7_1, false)
	local var_7_8 = var_7_0._info._count[2]
	local var_7_9 = ClientView.createBMFont(ClientView.BMFont.num_48, var_7_8)

	lc.addChildToPos(var_7_1, var_7_9, cc.p(lc.w(var_7_1) - lc.cw(var_7_9) - 70, lc.ch(var_7_9) + 14))

	local var_7_10 = ClientData.getIconName(Data.PropsId.skill_item_token)
	local var_7_11 = lc.createSprite(var_7_10)

	lc.addChildToPos(var_7_1, var_7_11, cc.p(lc.w(var_7_1) - lc.cw(var_7_11) - 24, lc.ch(var_7_11) + 22))

	local var_7_12 = lc.createSprite("img_recharge_gift")

	lc.addChildToPos(var_7_1, var_7_12, cc.p(lc.w(var_7_1) - 40, lc.h(var_7_1) - 20))

	local var_7_13 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_7_4 * 10)

	lc.addChildToPos(var_7_12, var_7_13, cc.p(lc.cw(var_7_12) + 6, lc.ch(var_7_12) - 8))

	var_7_1._giftLabel = var_7_13

	function var_7_1.update()
		return
	end

	return var_7_1
end

function var_0_0.updatePurchaseItems(arg_10_0)
	for iter_10_0 = 1, #arg_10_0._purchaseItems do
		arg_10_0._purchaseItems[iter_10_0]:update()
	end
end

function var_0_0.onBuyIngot(arg_11_0, arg_11_1, arg_11_2)
	ClientView.startIAP(arg_11_1)
end

return var_0_0
