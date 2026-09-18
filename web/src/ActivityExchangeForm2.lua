local var_0_0 = class("ActivityExchangeForm2", BaseForm)
local var_0_1 = cc.size(970, 635)
local var_0_2 = 170
local var_0_3 = 20
local var_0_4 = 0
local var_0_5 = 170

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._isShowResourceUI = true
	arg_2_0._resNames = ClientData.loadLCRes("res/activity.lcres")

	local var_2_0 = {
		Str(STR.ACTIVITY),
		Str(STR.EXCHANGE),
		Str(STR.RULE)
	}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = {
			_tag = iter_2_0,
			_labelStr = var_2_0[iter_2_0],
			_width = var_0_2,
			_handler = function(arg_3_0)
				arg_2_0:showTab(arg_3_0)
			end
		}

		table.insert(var_2_1, var_2_2)
	end

	arg_2_0._frame:setVisible(false)

	local var_2_3 = ClientView.createHorizontalContentTab(cc.size(var_0_1.width, var_0_1.height), var_2_1)

	lc.addChildToPos(arg_2_0._form, var_2_3, cc.p(var_0_1.width / 2, lc.h(var_2_3) / 2))

	arg_2_0._contentBg = var_2_3

	arg_2_0:createAd()
	arg_2_0:addExchangeArea()
	arg_2_0:addRuleArea()
	var_2_3:showTab(1, true)
	arg_2_0._form:setContentSize(cc.size(var_0_1.width, var_0_1.height + 60))
end

function var_0_0.createAd(arg_4_0)
	local var_4_0 = lc.createSprite("res/jpg/activity_limit_large_07.jpg")

	ClientView.setMaxSize(var_4_0, var_0_1.width - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, var_0_1.height - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM)
	lc.addChildToCenter(arg_4_0._contentBg, var_4_0, -1)

	arg_4_0._adSpr = var_4_0
end

function var_0_0.onBuy(arg_5_0, arg_5_1)
	ClientView.startIAP(arg_5_1)
	arg_5_0:hide()
end

function var_0_0.addRuleArea(arg_6_0)
	local var_6_0 = Data.getHelpStrsByType(Data.HelpType.activity_3)
	local var_6_1 = arg_6_0:createTextsList(arg_6_0._exchangeArea:getContentSize(), var_6_0)

	lc.addChildToPos(arg_6_0._contentBg, var_6_1, cc.p(arg_6_0._exchangeArea:getPosition()), -1)

	arg_6_0._ruleList1 = var_6_1
end

function var_0_0.createTextsList(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = lc.List.createV(arg_7_1, 40, 30)

	var_7_0:setAnchorPoint(0.5, 0.5)

	for iter_7_0 = 1, #arg_7_2 do
		local var_7_1 = ccui.Widget:create()

		var_7_1:setContentSize(lc.w(var_7_0) - 80, 0)

		local var_7_2 = ClientView.createTTF(arg_7_2[iter_7_0] .. "\n", ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(lc.w(var_7_1) - 60, 0))

		var_7_1:addChild(var_7_2)
		var_7_1:setContentSize(lc.w(var_7_1), lc.h(var_7_2))
		var_7_2:setPosition(lc.w(var_7_2) / 2 + 40, lc.h(var_7_1) / 2)

		if iter_7_0 < #arg_7_2 then
			local var_7_3 = ClientView.createDividingLine(lc.w(var_7_1), ClientView.COLOR_DIVIDING_LINE_LIGHT)

			var_7_3:setPosition(lc.w(var_7_1) / 2, -12)
			var_7_3:setOpacity(128)
			var_7_1:addChild(var_7_3)
		end

		var_7_0:pushBackCustomItem(var_7_1)
	end

	return var_7_0
end

function var_0_0.addExchangeArea(arg_8_0)
	local var_8_0 = lc.createNode(cc.size(lc.w(arg_8_0._contentBg) - 40, lc.h(arg_8_0._contentBg) - 40))

	lc.addChildToCenter(arg_8_0._contentBg, var_8_0, -1)

	arg_8_0._exchangeArea = var_8_0

	local var_8_1 = lc.createSprite("res/jpg/exchange_bg.jpg")

	ClientView.setMaxSize(var_8_1, var_0_1.width - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, var_0_1.height - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM)
	lc.addChildToCenter(var_8_0, var_8_1)

	var_8_0._items = {}

	local var_8_2

	for iter_8_0, iter_8_1 in ipairs(Data._exchangeInfo) do
		if iter_8_1._activityId == 28 then
			var_8_2 = iter_8_1

			break
		end
	end

	if var_8_2 then
		local var_8_3 = var_8_2._reward
		local var_8_4 = Data._bonusInfo[var_8_3]
		local var_8_5 = var_8_4._rid[1]
		local var_8_6 = IconWidget.create({
			_infoId = var_8_5,
			_count = var_8_4._count[1]
		})

		var_8_6:setScale(0.8)
		lc.addChildToPos(var_8_0, var_8_6, cc.p(650, 200))

		var_8_6._nameColor = ClientView.COLOR_TEXT_WHITE
		var_8_0._rewardIcon = var_8_6

		if not P._playerMarket._exchangeMap[var_8_2._id] then
			local var_8_7 = 0
		end

		local var_8_8 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_9_0)
			if P._playerMarket:isExchangeEnough(var_8_2) then
				local var_9_0 = P._playerMarket._exchangeMap[var_8_2._id] or 0

				if var_8_2._time ~= 0 and var_8_2._time - var_9_0 <= 0 then
					return ToastManager.push(Str(STR.EXCHANGED))
				end

				P._playerMarket:exchangeProp(var_8_2)

				local var_9_1 = var_8_2._reward
				local var_9_2 = Data._bonusInfo[var_9_1]
				local var_9_3 = var_9_2._rid[1]
				local var_9_4 = require("RewardPanel")

				var_9_4.create({
					{
						info_id = var_9_3,
						num = var_9_2._count[1]
					}
				}, var_9_4.MODE_EXCHANGE):show()
			else
				return ToastManager.push(Str(STR.EXCHANGE_ITEM_NOT_ENOUGH))
			end

			var_8_0.update()
		end, ClientView.CRECT_BUTTON_S, 110)

		var_8_8:setDisabledShader(ClientView.SHADER_DISABLE)
		lc.addChildToPos(var_8_0, var_8_8, cc.p(650, 60))
		var_8_8:addLabel(Str(STR.EXCHANGE))

		local var_8_9 = lc.createSprite("img_icon_props_s7136")

		lc.addChildToPos(var_8_0, var_8_9, cc.p(lc.x(var_8_8) - lc.cw(var_8_9), lc.top(var_8_8) + 30))

		local var_8_10 = ClientView.createTTF(Str(STR.MULTIPY) .. var_8_2._number[1], ClientView.FontSize.S3)

		var_8_10:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_8_0, var_8_10, cc.p(lc.x(var_8_8), lc.y(var_8_9)))

		function var_8_0.update()
			local var_10_0 = P._playerMarket:isExchangeEnough(var_8_2)

			var_8_8._label:setColor(ClientView.COLOR_TEXT_WHITE)
			var_8_10:setColor(var_10_0 and ClientView.COLOR_TEXT_WHITE or ClientView.COLOR_TEXT_RED)

			local var_10_1 = P._playerMarket._exchangeMap[var_8_2._id] or 0

			if var_8_2._time ~= 0 then
				if var_8_2._time - var_10_1 <= 0 then
					var_8_8._label:setString(Str(STR.EXCHANGED))
					var_8_8:setEnabled(false)
				else
					var_8_8._label:setString(Str(STR.EXCHANGE))
					var_8_8:setEnabled(true)

					if not var_10_0 then
						var_8_8._label:setColor(ClientView.COLOR_TEXT_RED)
					end
				end
			else
				var_8_8._label:setString(Str(STR.EXCHANGE))
			end
		end
	end

	var_8_0.update()
end

function var_0_0.showTab(arg_11_0, arg_11_1)
	arg_11_0._adSpr:setVisible(false)
	arg_11_0._exchangeArea:setVisible(false)
	arg_11_0._ruleList1:setVisible(false)

	if arg_11_1 == 1 then
		arg_11_0._adSpr:setVisible(true)
	elseif arg_11_1 == 2 then
		arg_11_0._exchangeArea:setVisible(true)
	elseif arg_11_1 == 3 then
		arg_11_0._ruleList1:setVisible(true)
	end
end

function var_0_0.onEnter(arg_12_0)
	var_0_0.super.onEnter(arg_12_0)
	ClientView.getResourceUI():setMode(Data.PropsId.dragon_man)

	arg_12_0._listeners = {}
end

function var_0_0.onExit(arg_13_0)
	var_0_0.super.onExit(arg_13_0)
	ClientView.getResourceUI():setMode(Data.ResType.gold)

	for iter_13_0 = 1, #arg_13_0._listeners do
		lc.Dispatcher:removeEventListener(arg_13_0._listeners[iter_13_0])
	end
end

function var_0_0.onCleanup(arg_14_0)
	lc.TextureCache:removeTextureForKey("res/jpg/activity_limit_large_07.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/exchange_bg.jpg")
	ClientData.unloadLCRes(arg_14_0._resNames)
end

return var_0_0
