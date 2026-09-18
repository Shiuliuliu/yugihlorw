local var_0_0 = class("CumulativeRechargeForm", BaseForm)
local var_0_1 = cc.size(800, 670)
local var_0_2 = 140
local var_0_3 = 20
local var_0_4 = 0
local var_0_5 = 150

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	local var_2_0 = ClientData.getValidActivityByType(603)

	arg_2_0._activityInfo = var_2_0

	var_0_0.super.init(arg_2_0, var_0_1, var_2_0 and Str(var_2_0._nameSid) or "", bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	arg_2_0._imgName = var_2_0._img

	local var_2_1 = "res/jpg/" .. arg_2_0._imgName .. ".jpg"
	local var_2_2 = lc.createSprite(var_2_1)

	ClientView.setMaxSize(var_2_2, var_0_1.width - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, var_0_1.height - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM)
	lc.addChildToCenter(arg_2_0._frame, var_2_2, -1)

	arg_2_0._adSpr = var_2_2

	local var_2_3 = ClientData.getActivityDurationStr(var_2_0)
	local var_2_4 = ClientView.createBMFont(ClientView.BMFont.huali_32, var_2_3)

	var_2_4:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_2_2, var_2_4, cc.p(330, 490))

	local var_2_5 = P._playerActivity._chargeIngot
	local var_2_6 = var_2_0._param

	arg_2_0._bonusIds = var_2_6

	for iter_2_0, iter_2_1 in ipairs(var_2_6) do
		arg_2_0._defaultIndex = iter_2_0
		arg_2_0._bonusInfo = Data._bonusInfo[iter_2_1]

		if var_2_5 < arg_2_0._bonusInfo._val then
			break
		end
	end

	arg_2_0._curIndex = arg_2_0._defaultIndex
	arg_2_0._iconNode = lc.createNode()

	lc.addChildToPos(arg_2_0._form, arg_2_0._iconNode, cc.p(lc.cw(arg_2_0._form), 275))

	local var_2_7 = ClientView.createArrowButton(true, cc.size(100, 100), function(arg_3_0)
		arg_2_0:onBtnArrow(arg_3_0)
	end)

	var_2_7:setVisible(false)
	lc.addChildToPos(arg_2_0._form, var_2_7, cc.p(100, 290))

	arg_2_0._btnArrowLeft = var_2_7

	local var_2_8 = ClientView.createArrowButton(false, cc.size(100, 100), function(arg_4_0)
		arg_2_0:onBtnArrow(arg_4_0)
	end)

	lc.addChildToPos(arg_2_0._form, var_2_8, cc.p(var_0_1.width - 100, 290))

	arg_2_0._btnArrowRight = var_2_8

	arg_2_0:refreshIcons()

	local var_2_9 = ClientView.createLabelProgressBar(var_0_1.width - 300, nil, ClientView.COLOR_TEXT_WHITE, ClientView.COLOR_TEXT_BLUE)

	lc.addChildToPos(arg_2_0._form, var_2_9, cc.p(ClientView.FRAME_INNER_LEFT + 30 + lc.cw(var_2_9), 100))
	var_2_9._bar:setPercent(var_2_5 / arg_2_0._bonusInfo._val * 100)
	var_2_9:setLabel(var_2_5, arg_2_0._bonusInfo._val)

	arg_2_0._progressBar = var_2_9

	local var_2_10 = ClientView.createScale9ShaderButton("img_btn_3", function()
		lc.pushScene(require("RechargeScene").create())
		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, 150)

	lc.addChildToPos(arg_2_0._form, var_2_10, cc.p(lc.right(var_2_9) + 120, lc.y(var_2_9) + 15))
	var_2_10:addLabel(Str(STR.RECHARGE))

	local var_2_11 = arg_2_0:createVipTip()

	lc.addChildToPos(arg_2_0._form, var_2_11, cc.p(lc.x(var_2_9), 150))

	arg_2_0._tip = var_2_11

	local var_2_12 = lc.createSprite("wait_text_bg")

	var_2_12:setScale(450 / lc.w(var_2_12), 50 / lc.h(var_2_12))
	lc.addChildToCenter(arg_2_0._tip, var_2_12, -1)

	if arg_2_0._activityInfo._img == "cumulative_recharge_bg_3" then
		lc.offset(var_2_4, 0, -70)
		lc.offset(arg_2_0._iconNode, 0, -60)
		lc.offset(var_2_7, 0, -60)
		lc.offset(var_2_8, 0, -60)
		lc.offset(var_2_11, 0, -50)
		lc.offset(var_2_9, 0, -40)
		lc.offset(var_2_10, 0, -40)
	end
end

function var_0_0.refreshIcons(arg_6_0)
	local var_6_0 = arg_6_0._iconNode

	var_6_0:removeAllChildren()

	local var_6_1 = arg_6_0._bonusIds[arg_6_0._curIndex]

	arg_6_0._curBonusInfo = Data._bonusInfo[var_6_1]

	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._curBonusInfo._rid) do
		local var_6_3 = IconWidget.create({
			_infoId = iter_6_1,
			_count = arg_6_0._curBonusInfo._count[iter_6_0]
		})

		var_6_3._name:setColor(ClientView.COLOR_TEXT_WHITE)
		table.insert(var_6_2, var_6_3)
	end

	lc.addNodesToCenter(var_6_0, var_6_2, 20)
	arg_6_0._btnArrowLeft:setVisible(arg_6_0._curIndex > arg_6_0._defaultIndex)
	arg_6_0._btnArrowRight:setVisible(arg_6_0._curIndex < math.min(arg_6_0._defaultIndex + 2, #arg_6_0._bonusIds))
end

function var_0_0.refreshProgress(arg_7_0)
	local var_7_0 = arg_7_0._bonusIds[arg_7_0._curIndex]

	arg_7_0._curBonusInfo = Data._bonusInfo[var_7_0]

	local var_7_1 = P._playerActivity._chargeIngot
	local var_7_2 = arg_7_0._progressBar

	var_7_2._bar:setPercent(var_7_1 / arg_7_0._curBonusInfo._val * 100)
	var_7_2:setLabel(var_7_1, arg_7_0._curBonusInfo._val)
	arg_7_0._tip:removeFromParent()

	arg_7_0._tip = arg_7_0:createVipTip()

	lc.addChildToPos(arg_7_0._form, arg_7_0._tip, cc.p(lc.x(var_7_2), 150))

	if arg_7_0._activityInfo._img == "cumulative_recharge_bg_3" then
		lc.offset(arg_7_0._tip, 0, -50)
	end

	local var_7_3 = lc.createSprite("wait_text_bg")

	var_7_3:setScale(450 / lc.w(var_7_3), 50 / lc.h(var_7_3))
	lc.addChildToCenter(arg_7_0._tip, var_7_3, -1)
end

function var_0_0.onBtnArrow(arg_8_0, arg_8_1)
	if arg_8_1 == arg_8_0._btnArrowLeft then
		if arg_8_0._curIndex <= arg_8_0._defaultIndex then
			return
		end

		arg_8_0._curIndex = arg_8_0._curIndex - 1
	else
		if arg_8_0._curIndex >= math.min(arg_8_0._defaultIndex + 2, #arg_8_0._bonusIds) then
			return
		end

		arg_8_0._curIndex = arg_8_0._curIndex + 1
	end

	arg_8_0:refreshIcons()
	arg_8_0:refreshProgress()
end

function var_0_0.createVipTip(arg_9_0)
	local var_9_0 = arg_9_0._bonusIds[arg_9_0._curIndex]

	arg_9_0._curBonusInfo = Data._bonusInfo[var_9_0]

	local var_9_1 = P._playerActivity._chargeIngot
	local var_9_2 = arg_9_0._curBonusInfo._val
	local var_9_3 = ccui.RichTextEx:create()

	if var_9_1 < var_9_2 then
		var_9_3:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(STR.RECHARGE_AGAIN), ClientView.TTF_FONT, ClientView.FontSize.S1))
		var_9_3:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_INGOT, 255, string.format(" %d ", var_9_2 - var_9_1), ClientView.TTF_FONT, ClientView.FontSize.S1))
		var_9_3:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, lc.createSprite(string.format("img_icon_res%d_s", Data.ResType.ingot))))
		var_9_3:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, " " .. Str(STR.CAN_CLAIM), ClientView.TTF_FONT, ClientView.FontSize.S1))
	else
		var_9_3:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(STR.ALL_CLAIMED), ClientView.TTF_FONT, ClientView.FontSize.S1))
	end

	var_9_3:formatText()

	return var_9_3
end

function var_0_0.onEnter(arg_10_0)
	var_0_0.super.onEnter(arg_10_0)

	arg_10_0._listeners = {}
end

function var_0_0.onExit(arg_11_0)
	var_0_0.super.onExit(arg_11_0)

	for iter_11_0 = 1, #arg_11_0._listeners do
		lc.Dispatcher:removeEventListener(arg_11_0._listeners[iter_11_0])
	end
end

function var_0_0.onCleanup(arg_12_0)
	lc.TextureCache:removeTextureForKey("res/jpg/cumulative_recharge_bg.jpg")
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename(lc.formatJpg(arg_12_0._imgName)))
end

return var_0_0
