local var_0_0 = class("CumulativeArea", lc.ExtendCCNode)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_0)
	var_1_0:init(arg_1_1)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		elseif arg_2_0 == "cleanup" then
			var_1_0:onCleanup()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._index = arg_3_1
	arg_3_0._activityType = Data.ActivityType.cumulative_newbie_start + arg_3_1 - 1
	arg_3_0._bonuses = P._playerBonus._bonusCumulativeNewBie[arg_3_1]

	local var_3_0 = ClientData.getValidActivityByType(arg_3_0._activityType)

	arg_3_0._activityInfo = var_3_0

	local var_3_1 = var_3_0._img

	if ClientData.isAnotherSkin2() and lc.File:isFileExist(lc.formatJpg(var_3_1 .. "_3")) then
		var_3_1 = var_3_1 .. "_3"
	end

	arg_3_0._imgName = var_3_1

	local var_3_2 = lc.createSprite(lc.formatJpg(var_3_1))

	lc.addChildToCenter(arg_3_0, var_3_2)

	arg_3_0._adSpr = var_3_2

	local var_3_3 = ClientData.getActivityDurationStr(var_3_0)
	local var_3_4 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_3_3)

	var_3_4:setAnchorPoint(0.5, 0.5)
	var_3_4:setVisible(false)
	lc.addChildToPos(var_3_2, var_3_4, cc.p(lc.cw(var_3_2) + 115, lc.ch(var_3_2) + 280))

	arg_3_0._chargetCount = #arg_3_0._bonuses

	local var_3_5 = arg_3_0._bonuses[1]._value

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._bonuses) do
		arg_3_0._defaultIndex = iter_3_0
		arg_3_0._bonusInfo = iter_3_1._info

		if iter_3_1._value < iter_3_1._info._val then
			break
		end
	end

	arg_3_0:setCurIndex(arg_3_0._defaultIndex)

	arg_3_0._iconNode = lc.createNode()

	lc.addChildToPos(var_3_2, arg_3_0._iconNode, cc.p(lc.cw(var_3_2) + 115, 270))

	local var_3_6 = ClientView.createArrowButton(true, cc.size(100, 100), function(arg_4_0)
		arg_3_0:onBtnArrow(arg_4_0)
	end)

	var_3_6:setVisible(false)
	lc.addChildToPos(var_3_2, var_3_6, cc.p(lc.cw(var_3_2) - 400 + 115, lc.y(arg_3_0._iconNode)))

	arg_3_0._btnArrowLeft = var_3_6

	local var_3_7 = ClientView.createArrowButton(false, cc.size(100, 100), function(arg_5_0)
		arg_3_0:onBtnArrow(arg_5_0)
	end)

	lc.addChildToPos(var_3_2, var_3_7, cc.p(math.min(lc.cw(var_3_2) + 360, lc.cw(var_3_2) + 400 + 115), lc.y(arg_3_0._iconNode)))

	arg_3_0._btnArrowRight = var_3_7

	local var_3_8 = ClientView.createShaderButton("img_btn_recharge_1", function()
		ClientView.startIAP(arg_3_0._purchaseType)
	end)

	lc.addChildToPos(var_3_2, var_3_8, cc.p(lc.cw(var_3_2) + 115, 126))
	var_3_8:setDisabledShader(ClientView.SHADER_DISABLE)
	var_3_8:addLabel(Str(STR.BUY_NOW))

	arg_3_0._rechargeBtn = var_3_8

	arg_3_0:refreshIcons()
end

function var_0_0.setCurIndex(arg_7_0, arg_7_1)
	arg_7_0._curIndex = arg_7_1
	arg_7_0._curBonusInfo = arg_7_0._bonuses[arg_7_1]._info
end

function var_0_0.refreshIcons(arg_8_0)
	local var_8_0 = arg_8_0._bonuses[1]._value
	local var_8_1 = arg_8_0._iconNode

	var_8_1:removeAllChildren()

	local var_8_2 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._curBonusInfo._rid) do
		local var_8_3 = IconWidget.create({
			_infoId = iter_8_1,
			_count = arg_8_0._curBonusInfo._count[iter_8_0]
		}, IconWidget.DisplayFlag.ITEM_NO_NAME)

		var_8_3._name:setColor(ClientView.COLOR_TEXT_WHITE)
		table.insert(var_8_2, var_8_3)
	end

	lc.addNodesToCenter(var_8_1, var_8_2, 20)
	arg_8_0._btnArrowLeft:setVisible(arg_8_0._curIndex > arg_8_0._defaultIndex)
	arg_8_0._btnArrowRight:setVisible(arg_8_0._curIndex < arg_8_0._chargetCount)

	local var_8_4 = arg_8_0._bonusInfo._val
	local var_8_5 = 0
	local var_8_6 = 0
	local var_8_7 = arg_8_0._defaultIndex - 1

	if var_8_7 > 0 then
		var_8_6 = arg_8_0._bonuses[var_8_7]._info._val
	end

	local var_8_8 = math.floor((var_8_4 - var_8_6) / 10)
	local var_8_9

	for iter_8_2 = Data.PurchaseType.product_6, Data.PurchaseType.product_1, -1 do
		local var_8_10 = ClientData.getPrice(iter_8_2)

		if var_8_10 <= var_8_8 then
			var_8_8 = var_8_10
			var_8_9 = iter_8_2

			break
		end
	end

	arg_8_0._purchaseType = Data.PurchaseType.cumulative_newbie_start + (arg_8_0._index - 1) * 10 + var_8_9

	local var_8_11 = ClientView.createBMFont(ClientView.BMFont.level, "RMB " .. var_8_8)

	var_8_11:setScale(0.5)
	lc.addChildToPos(var_8_1, var_8_11, cc.p(0, -80))
	arg_8_0._rechargeBtn:setEnabled(arg_8_0._curIndex == arg_8_0._defaultIndex and var_8_0 < arg_8_0._curBonusInfo._val)
end

function var_0_0.refreshProgress(arg_9_0)
	local var_9_0 = arg_9_0._bonuses[1]._value
	local var_9_1 = arg_9_0._progressBar

	var_9_1._bar:setPercent(var_9_0 / arg_9_0._curBonusInfo._val * 100)
	var_9_1:setLabel(var_9_0, arg_9_0._curBonusInfo._val)

	if arg_9_0._tip then
		arg_9_0._tip:removeFromParent()
	end

	arg_9_0._tip = arg_9_0:createVipTip()

	lc.addChildToPos(arg_9_0._adSpr, arg_9_0._tip, cc.p(lc.x(var_9_1), lc.top(var_9_1) + 30))

	local var_9_2 = lc.createNode(cc.size(450, 50))

	lc.addChildToCenter(arg_9_0._tip, var_9_2, -1)
end

function var_0_0.createVipTip(arg_10_0)
	local var_10_0 = arg_10_0._bonuses[1]._value
	local var_10_1 = arg_10_0._curBonusInfo._val
	local var_10_2 = ccui.RichTextEx:create()

	if var_10_0 < var_10_1 then
		var_10_2:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(STR.RECHARGE_AGAIN), ClientView.TTF_FONT, ClientView.FontSize.S1))
		var_10_2:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_INGOT, 255, string.format(" %d ", var_10_1 - var_10_0), ClientView.TTF_FONT, ClientView.FontSize.S1))

		local var_10_3 = ClientData.getIconName(Data.ResType.ingot)

		var_10_2:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, lc.createSprite(var_10_3)))
		var_10_2:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, " " .. Str(STR.CAN_CLAIM), ClientView.TTF_FONT, ClientView.FontSize.S1))
	else
		var_10_2:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(STR.ALL_CLAIMED), ClientView.TTF_FONT, ClientView.FontSize.S1))
	end

	var_10_2:formatText()

	return var_10_2
end

function var_0_0.onBtnArrow(arg_11_0, arg_11_1)
	if arg_11_1 == arg_11_0._btnArrowLeft then
		if arg_11_0._curIndex <= arg_11_0._defaultIndex then
			return
		end

		arg_11_0:setCurIndex(arg_11_0._curIndex - 1)
	else
		if arg_11_0._curIndex >= arg_11_0._chargetCount then
			return
		end

		arg_11_0:setCurIndex(arg_11_0._curIndex + 1)
	end

	arg_11_0:refreshIcons()
end

function var_0_0.onEnter(arg_12_0)
	return
end

function var_0_0.onExit(arg_13_0)
	return
end

function var_0_0.onCleanup(arg_14_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename(lc.formatJpg(arg_14_0._imgName)))
end

return var_0_0
