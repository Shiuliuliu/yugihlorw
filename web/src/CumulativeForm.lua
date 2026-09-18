local var_0_0 = class("AchieveForm", BaseForm)
local var_0_1 = cc.size(1040, 660)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	arg_2_0._isShowResourceUI = true

	arg_2_0._frame:setVisible(false)

	arg_2_0._activityInfo = ClientData.getValidActivityByType(603)
	arg_2_0._data = {}

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(P._playerMarket._cumulativeExchanges) do
		print("+++++++++++++++++++++++1", iter_2_0, iter_2_1[1])

		local var_2_1 = Data._exchangeInfo[iter_2_1[1]]._activityId

		print("+++++++++++++++++++++++2", iter_2_1[1], var_2_1)

		local var_2_2 = ClientData.getActivityByType(var_2_1)
		local var_2_3, var_2_4 = ClientData.getActivityDurationStr(var_2_2, true, false, true)

		arg_2_0._data[iter_2_0] = {
			_actInfo = var_2_2,
			_exchangeIds = iter_2_1,
			_beginStr = var_2_3,
			_endStr = var_2_4
		}
		var_2_0[iter_2_0] = {
			_width = 100,
			_labelStr = var_2_3,
			_tag = iter_2_0,
			_handler = function(arg_3_0)
				arg_2_0:showTab(arg_3_0)
			end
		}
	end

	var_2_0[#var_2_0 + 1] = {
		_width = 100,
		_labelStr = Str(STR.HELP),
		_tag = #var_2_0 + 1,
		_handler = function(arg_4_0)
			arg_2_0:showTab(arg_4_0)
		end
	}
	var_2_0[1]._left = 50
	var_2_0[1]._gap = 2

	arg_2_0:updateData()

	local var_2_5 = ClientView.createHorizontalContentTab(cc.size(var_0_1.width, var_0_1.height), var_2_0)

	lc.addChildToPos(arg_2_0._form, var_2_5, cc.p(var_0_1.width / 2, lc.h(var_2_5) / 2))

	arg_2_0._contentBg = var_2_5

	local var_2_6 = ClientView.createFrameBox(cc.size(lc.w(arg_2_0._contentBg), 275))

	var_2_6._bg:removeFromParent()
	lc.addChildToPos(arg_2_0._contentBg, var_2_6, cc.p(lc.cw(var_2_6), lc.h(var_2_5) - lc.ch(var_2_6)))

	arg_2_0._box1 = var_2_6

	local var_2_7 = lc.createSprite("res/jpg/cumulative_bg.jpg")

	lc.addChildToCenter(var_2_5, var_2_7, -1)
	lc.offset(var_2_7, 0, 0)

	arg_2_0._bg = var_2_7

	local var_2_8 = ClientView.createTTF("", ClientView.FontSize.S3)

	var_2_8:setAnchorPoint(1, 0.5)
	lc.addChildToPos(var_2_7, var_2_8, cc.p(lc.w(var_2_7) - 100, lc.h(var_2_7) - 40))

	arg_2_0._exchangeTimeLabel = var_2_8

	local var_2_9 = lc.createNode(cc.size(650, 145))

	lc.addChildToPos(var_2_7, var_2_9, cc.p(390, 475))

	arg_2_0._exchangeRewardArea = var_2_9

	local var_2_10 = ClientView.createTTF("", ClientView.FontSize.S3)

	lc.addChildToPos(var_2_7, var_2_10, cc.p(lc.left(var_2_9) - lc.cw(var_2_10) - 20, 510))

	arg_2_0._exchangeIndexLabel = var_2_10

	local var_2_11 = ClientView.createArrowButton(true, cc.size(100, 100), function(arg_5_0)
		arg_2_0:onExchangeBtnArrow(arg_5_0)
	end)

	lc.addChildToPos(var_2_7, var_2_11, cc.p(lc.left(var_2_9) - 15, lc.y(var_2_9)))

	arg_2_0._exchangeBtnArrowLeft = var_2_11

	local var_2_12 = ClientView.createArrowButton(false, cc.size(100, 100), function(arg_6_0)
		arg_2_0:onExchangeBtnArrow(arg_6_0)
	end)

	lc.addChildToPos(var_2_7, var_2_12, cc.p(lc.right(var_2_9) + 25, lc.y(var_2_9)))

	arg_2_0._exchangeBtnArrowRight = var_2_12

	local var_2_13 = ClientView.createScale9ShaderButton("img_btn_1", nil, ClientView.CRECT_BUTTON, 150)

	var_2_13:setDisabledShader(ClientView.SHADER_DISABLE)
	var_2_13:addLabel(Str(STR.EXCHANGE))
	lc.addChildToPos(var_2_7, var_2_13, cc.p(lc.right(var_2_9) + 150, lc.bottom(var_2_9) + lc.ch(var_2_13) + 5))

	arg_2_0._exchangeBtn = var_2_13

	local var_2_14 = ClientView.createTTF("", ClientView.FontSize.S3)

	var_2_14:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_2_13, var_2_14, cc.p(lc.cw(var_2_13), lc.h(var_2_13) + 25))

	arg_2_0._exchangePriceLabel = var_2_14

	local var_2_15 = ClientData.getIconName(Data.PropsId.cumulative_exchange_token, false)
	local var_2_16 = lc.createSprite(var_2_15)

	lc.addChildToPos(var_2_13, var_2_16, cc.p(lc.left(var_2_14) - 10 - lc.cw(var_2_16), lc.y(var_2_14)))

	local var_2_17 = ClientView.createFrameBox(cc.size(lc.w(arg_2_0._contentBg), 410))

	var_2_17._bg:removeFromParent()
	lc.addChildToPos(arg_2_0._contentBg, var_2_17, cc.p(lc.cw(var_2_17), lc.ch(var_2_17)))

	arg_2_0._box2 = var_2_17

	local var_2_18 = ClientView.createTTF("", ClientView.FontSize.S3)

	var_2_18:setAnchorPoint(1, 0.5)
	lc.addChildToPos(var_2_7, var_2_18, cc.p(lc.w(var_2_7) - 100, 330))

	arg_2_0._cumulativeTimeLabel = var_2_18

	local var_2_19 = ClientView.createTTF("", ClientView.FontSize.S3)

	lc.addChildToPos(var_2_7, var_2_19, cc.p(lc.x(arg_2_0._exchangeIndexLabel), 236))

	arg_2_0._cumulativeIndexLabel = var_2_19

	local var_2_20 = lc.createNode(cc.size(650, 140))

	lc.addChildToPos(var_2_7, var_2_20, cc.p(390, 180))

	arg_2_0._cumulativeRewardArea = var_2_20

	local var_2_21 = ClientView.createArrowButton(true, cc.size(100, 100), function(arg_7_0)
		arg_2_0:onBtnArrow(arg_7_0)
	end)

	lc.addChildToPos(var_2_7, var_2_21, cc.p(lc.left(var_2_20) - 15, lc.y(var_2_20)))

	arg_2_0._btnArrowLeft = var_2_21

	local var_2_22 = ClientView.createArrowButton(false, cc.size(100, 100), function(arg_8_0)
		arg_2_0:onBtnArrow(arg_8_0)
	end)

	lc.addChildToPos(var_2_7, var_2_22, cc.p(lc.right(var_2_20) + 25, lc.y(var_2_20)))

	arg_2_0._btnArrowRight = var_2_22

	local var_2_23 = ClientView.createScale9ShaderButton("img_btn_3", function()
		ClientView.showResExchangeForm(Data.ResType.ingot)
	end, ClientView.CRECT_BUTTON, 150)

	var_2_23:addLabel(Str(STR.RECHARGE))
	lc.addChildToPos(var_2_7, var_2_23, cc.p(lc.right(var_2_20) + 150, lc.bottom(var_2_20) - lc.ch(var_2_23) - 10))

	arg_2_0._cumulativeBtn = var_2_23

	local var_2_24 = ClientView.createLabelProgressBar(550, nil, ClientView.COLOR_TEXT_WHITE, ClientView.COLOR_TEXT_BLUE)

	lc.addChildToPos(var_2_7, var_2_24, cc.p(lc.cw(var_2_24) + 50, lc.y(var_2_23) - 30))

	arg_2_0._progressBar = var_2_24

	local var_2_25 = Data.HelpType.month_cumulative
	local var_2_26 = Data.getHelpStrsByType(var_2_25)
	local var_2_27 = arg_2_0:createTextsList(var_2_7:getContentSize(), var_2_26)

	lc.addChildToPos(arg_2_0._contentBg, var_2_27, cc.p(var_2_7:getPosition()))

	arg_2_0._helpArea = var_2_27

	local var_2_28 = ClientData.getValidActivityByType(Data.ActivityType.exchange_ex)

	if var_2_28 then
		local var_2_29 = arg_2_0._cumulativeRewardArea
		local var_2_30 = ClientView.createScale9ShaderButton("img_btn_1", function()
			require("ActivityExchangeForm").create(var_2_28._param1[1]):show()
		end, ClientView.CRECT_BUTTON, 150)

		var_2_30:addLabel(Str(STR.EXCHANGE_EX))
		lc.addChildToPos(var_2_7, var_2_30, cc.p(lc.right(var_2_29) + 150, lc.y(var_2_29)))

		arg_2_0._cumulativeExBtn = var_2_30
	end

	arg_2_0._form:setContentSize(lc.w(arg_2_0._form), lc.h(arg_2_0._form) + 100)
end

function var_0_0.createTextsList(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = lc.List.createV(arg_11_1, 40, 30)

	var_11_0:setAnchorPoint(0.5, 0.5)

	for iter_11_0 = 1, #arg_11_2 do
		local var_11_1 = ccui.Widget:create()

		var_11_1:setContentSize(lc.w(var_11_0) - 80, 0)

		local var_11_2 = ClientView.createTTF(arg_11_2[iter_11_0] .. "\n", ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(lc.w(var_11_1) - 60, 0))

		var_11_1:addChild(var_11_2)
		var_11_1:setContentSize(lc.w(var_11_1), lc.h(var_11_2))
		var_11_2:setPosition(lc.w(var_11_2) / 2 + 40, lc.h(var_11_1) / 2)

		if iter_11_0 < #arg_11_2 then
			local var_11_3 = ClientView.createDividingLine(lc.w(var_11_1), ClientView.COLOR_DIVIDING_LINE_LIGHT)

			var_11_3:setPosition(lc.w(var_11_1) / 2, -12)
			var_11_3:setOpacity(128)
			var_11_1:addChild(var_11_3)
		end

		var_11_0:pushBackCustomItem(var_11_1)
	end

	return var_11_0
end

function var_0_0.onBtnArrow(arg_12_0, arg_12_1)
	if arg_12_1 == arg_12_0._btnArrowLeft then
		if arg_12_0._curCumulativeIndex <= arg_12_0._cumulativeIndex then
			return
		end

		arg_12_0._curCumulativeIndex = arg_12_0._curCumulativeIndex - 1
	else
		if arg_12_0._curCumulativeIndex >= #arg_12_0._bonusIds then
			return
		end

		arg_12_0._curCumulativeIndex = arg_12_0._curCumulativeIndex + 1
	end

	arg_12_0:refreshCumulative()
end

function var_0_0.onExchangeBtnArrow(arg_13_0, arg_13_1)
	if arg_13_1 == arg_13_0._exchangeBtnArrowLeft then
		if arg_13_0._curExchangeIndex <= arg_13_0._exchangeIndex then
			return
		end

		arg_13_0._curExchangeIndex = arg_13_0._curExchangeIndex - 1
	else
		if arg_13_0._curExchangeIndex >= #arg_13_0._exchangeIds then
			return
		end

		arg_13_0._curExchangeIndex = arg_13_0._curExchangeIndex + 1
	end

	arg_13_0:refreshExchange()
end

function var_0_0.updateData(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._data) do
		local var_14_0 = iter_14_1._actInfo

		if ClientData.isActivityValid(var_14_0) then
			arg_14_0._tabIndex = iter_14_0
		end

		iter_14_1._index = nil

		for iter_14_2, iter_14_3 in ipairs(iter_14_1._exchangeIds) do
			if not iter_14_1._index and not P._playerMarket._exchangeMap[iter_14_3] then
				iter_14_1._index = iter_14_2

				break
			end
		end

		if not iter_14_1._index then
			iter_14_1._index = #iter_14_1._exchangeIds
		end
	end
end

function var_0_0.refreshView(arg_15_0, arg_15_1)
	if arg_15_0._focusTabIndex <= #arg_15_0._data then
		arg_15_0:refreshCumulative(arg_15_1)
		arg_15_0:refreshExchange(arg_15_1)
		arg_15_0._bg:setVisible(true)
		arg_15_0._helpArea:setVisible(false)
		arg_15_0._box1:setVisible(true)
		arg_15_0._box2:setVisible(true)
	else
		arg_15_0._bg:setVisible(false)
		arg_15_0._helpArea:setVisible(true)
		arg_15_0._box1:setVisible(false)
		arg_15_0._box2:setVisible(false)
	end
end

function var_0_0.refreshCumulative(arg_16_0, arg_16_1)
	local var_16_0 = ClientData.getActivityDurationStr(arg_16_0._activityInfo)

	arg_16_0._cumulativeTimeLabel:setString(var_16_0)

	local var_16_1 = P._playerActivity._chargeIngot
	local var_16_2 = arg_16_0._activityInfo._param

	arg_16_0._bonusIds = var_16_2

	for iter_16_0, iter_16_1 in ipairs(var_16_2) do
		arg_16_0._cumulativeIndex = iter_16_0
		arg_16_0._bonusInfo = Data._bonusInfo[iter_16_1]

		if var_16_1 < arg_16_0._bonusInfo._val then
			break
		end
	end

	if arg_16_1 then
		arg_16_0._curCumulativeIndex = arg_16_0._cumulativeIndex
	end

	local var_16_3 = arg_16_0._bonusIds[arg_16_0._curCumulativeIndex]

	arg_16_0._curBonusInfo = Data._bonusInfo[var_16_3]

	arg_16_0._cumulativeIndexLabel:setString(string.format(Str(STR.NO_STAGE), arg_16_0._curCumulativeIndex))
	arg_16_0._cumulativeRewardArea:removeAllChildren()

	local var_16_4 = arg_16_0._bonusIds[arg_16_0._curCumulativeIndex]
	local var_16_5 = Data._bonusInfo[var_16_4]
	local var_16_6 = {}

	for iter_16_2, iter_16_3 in ipairs(var_16_5._rid) do
		local var_16_7 = IconWidget.create({
			_infoId = iter_16_3,
			_count = var_16_5._count[iter_16_2]
		})

		var_16_7._name:setColor(ClientView.COLOR_TEXT_WHITE)
		table.insert(var_16_6, var_16_7)
	end

	lc.addNodesToCenter(arg_16_0._cumulativeRewardArea, var_16_6, 10)
	arg_16_0._progressBar._bar:setPercent(var_16_1 / arg_16_0._curBonusInfo._val * 100)
	arg_16_0._progressBar:setLabel(var_16_1, arg_16_0._curBonusInfo._val)

	if arg_16_0._tip then
		arg_16_0._tip:removeFromParent()
	end

	local var_16_8 = arg_16_0:createVipTip()

	lc.addChildToPos(arg_16_0._bg, var_16_8, cc.p(lc.x(arg_16_0._progressBar), lc.top(arg_16_0._progressBar) + 30))

	arg_16_0._tip = var_16_8

	arg_16_0._btnArrowLeft:setVisible(arg_16_0._curCumulativeIndex > arg_16_0._cumulativeIndex)
	arg_16_0._btnArrowRight:setVisible(arg_16_0._curCumulativeIndex < math.min(#var_16_2, arg_16_0._cumulativeIndex + 2))
end

function var_0_0.createVipTip(arg_17_0)
	local var_17_0 = P._playerActivity._chargeIngot
	local var_17_1 = arg_17_0._curBonusInfo._val
	local var_17_2 = ccui.RichTextEx:create()

	if var_17_0 < var_17_1 then
		var_17_2:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_DARK, 255, Str(STR.RECHARGE_AGAIN), ClientView.TTF_FONT, ClientView.FontSize.S1))
		var_17_2:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_BLUE_DARK, 255, string.format(" %d ", var_17_1 - var_17_0), ClientView.TTF_FONT, ClientView.FontSize.S1))
		var_17_2:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, lc.createSprite(string.format("img_icon_res%d_s", Data.ResType.ingot))))
		var_17_2:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_DARK, 255, " " .. Str(STR.CAN_CLAIM), ClientView.TTF_FONT, ClientView.FontSize.S1))
	else
		var_17_2:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_DARK, 255, Str(STR.ALL_CLAIMED), ClientView.TTF_FONT, ClientView.FontSize.S1))
	end

	var_17_2:formatText()

	return var_17_2
end

function var_0_0.refreshExchange(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._data[arg_18_0._focusTabIndex]

	arg_18_0._exchangeIndex = var_18_0._index

	local var_18_1 = var_18_0._exchangeIds

	arg_18_0._exchangeIds = var_18_1

	if arg_18_1 then
		arg_18_0._curExchangeIndex = var_18_0._index
	end

	local var_18_2 = arg_18_0._curExchangeIndex
	local var_18_3 = var_18_1[var_18_2]
	local var_18_4 = Data._exchangeInfo[var_18_3]
	local var_18_5 = var_18_4._item
	local var_18_6 = var_18_4._reward
	local var_18_7 = Data._bonusInfo[var_18_6]
	local var_18_8 = P._playerMarket._exchangeMap[var_18_4._id] or 0
	local var_18_9 = true

	for iter_18_0, iter_18_1 in ipairs(var_18_5) do
		if P:getItemCount(iter_18_1) < var_18_4._number[iter_18_0] then
			var_18_9 = false

			break
		end
	end

	arg_18_0._exchangePriceLabel:setString(var_18_4._number[1])

	function arg_18_0._exchangeBtn._callback()
		local function var_19_0()
			local var_20_0 = P._playerMarket._exchangeMap[var_18_4._id] or 0
			local var_20_1 = true

			for iter_20_0, iter_20_1 in ipairs(var_18_5) do
				if P:getItemCount(iter_20_1) < var_18_4._number[iter_20_0] then
					var_20_1 = false

					break
				end
			end

			if var_20_1 then
				if var_18_4._time ~= 0 and var_18_4._time - var_20_0 <= 0 then
					return ToastManager.push(Str(STR.EXCHANGED))
				end

				P._playerMarket:exchangeProp(var_18_4)

				local var_20_2 = require("RewardPanel")

				var_20_2.create({
					_info = var_18_7
				}, var_20_2.MODE_CLAIM):show()
				arg_18_0:updateData()
				arg_18_0:refreshExchange(true)
			else
				return ToastManager.push(Str(STR.EXCHANGE_ITEM_NOT_ENOUGH))
			end
		end

		require("Dialog").showDialog(Str(STR.SURE_TO_BUY), var_19_0)
	end

	local var_18_10 = arg_18_0._exchangeBtn

	if var_18_4._time ~= 0 then
		if arg_18_0._focusTabIndex <= arg_18_0._tabIndex then
			if var_18_4._time - var_18_8 <= 0 then
				var_18_10._label:setString(Str(STR.EXCHANGED))
				var_18_10:setEnabled(false)
			else
				var_18_10._label:setString(Str(STR.EXCHANGE))
				var_18_10:setEnabled(true)
			end
		else
			var_18_10:setEnabled(false)
		end

		if arg_18_0._curExchangeIndex > arg_18_0._exchangeIndex then
			var_18_10:setEnabled(false)
		end
	end

	var_18_10._label:setColor(var_18_9 and ClientView.COLOR_TEXT_WHITE or ClientView.COLOR_TEXT_RED_DARK)
	arg_18_0._exchangeTimeLabel:setString(var_18_0._beginStr .. " - " .. var_18_0._endStr)
	arg_18_0._exchangeIndexLabel:setString(string.format(Str(STR.NO_STAGE), var_18_2))
	arg_18_0._exchangeRewardArea:removeAllChildren()

	local var_18_11 = {}

	for iter_18_2, iter_18_3 in ipairs(var_18_7._rid) do
		local var_18_12 = var_18_7._count[iter_18_2]
		local var_18_13 = IconWidget.create({
			_infoId = iter_18_3,
			_count = var_18_12
		})

		var_18_13._name:setColor(ClientView.COLOR_TEXT_WHITE)

		var_18_11[#var_18_11 + 1] = var_18_13
	end

	lc.addNodesToCenter(arg_18_0._exchangeRewardArea, var_18_11, 10)
	arg_18_0._exchangeBtnArrowLeft:setVisible(arg_18_0._curExchangeIndex > arg_18_0._exchangeIndex)
	arg_18_0._exchangeBtnArrowRight:setVisible(arg_18_0._curExchangeIndex < math.min(#var_18_1, arg_18_0._exchangeIndex + 2))
end

function var_0_0.showTab(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0._focusTabIndex = arg_21_1

	arg_21_0:refreshView(true)
end

function var_0_0.onEnter(arg_22_0)
	var_0_0.super.onEnter(arg_22_0)
	ClientView.getResourceUI():setMode(Data.PropsId.cumulative_exchange_token)

	arg_22_0._listeners = {}
	arg_22_0._listeners[#arg_22_0._listeners + 1] = lc.addEventListener(Data.Event.fund_dirty, function()
		arg_22_0:updateData()
		arg_22_0:refreshView(true)
	end)

	arg_22_0._contentBg:showTab(arg_22_0._tabIndex, true)
end

function var_0_0.onExchangeScene(arg_24_0)
	ClientView.getResourceUI():setMode(Data.PropsId.cumulative_exchange_token)
end

function var_0_0.onExit(arg_25_0)
	var_0_0.super.onExit(arg_25_0)

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_25_1)
	end
end

return var_0_0
