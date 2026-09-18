local var_0_0 = class("ExchangePackagePanel", require("BasePanel"))
local var_0_1 = require("CardInfoPanel")

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, true, false)

	arg_2_0._isShowResourceUI = true

	local var_2_0 = lc.createSprite("res/jpg/god_pump_bg.jpg")

	lc.addChildToCenter(arg_2_0, var_2_0)
	arg_2_0:addChild(arg_2_0:createTopArea())

	arg_2_0._exchangeIds = arg_2_1

	arg_2_0:addExchangeArea()

	local var_2_1 = Data._exchangeInfo[arg_2_1[1]]

	if #var_2_1._showRes > 1 then
		ClientView.getResourceUI():setMode(nil, nil, var_2_1._showRes)
	end

	arg_2_0:refreshList()
end

function var_0_0.createTopArea(arg_3_0)
	local function var_3_0(arg_4_0)
		ClientView.showHelpForm(Str(STR.EXCHANGE_PACKAGE), Data.HelpType.tavern_god_pump)
	end

	local var_3_1 = ClientView.createTitleArea(Str(STR.EXCHANGE_PACKAGE), function()
		arg_3_0:hide()
	end, var_3_0)

	arg_3_0._topArea = var_3_1

	return var_3_1
end

function var_0_0.addExchangeArea(arg_6_0)
	local var_6_0 = lc.List.createH(cc.size(lc.w(arg_6_0), 500), 10, -15)

	var_6_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_6_0, var_6_0)
	var_6_0:setClippingEnabled(false)

	arg_6_0._list = var_6_0
end

function var_0_0.refreshList(arg_7_0)
	local var_7_0 = arg_7_0._exchangeIds
	local var_7_1 = arg_7_0._list

	arg_7_0._list:bindData(var_7_0, function(...)
		arg_7_0:setOrCreateItem(...)
	end, math.min(10, #var_7_0))

	for iter_7_0 = 1, arg_7_0._list._cacheCount do
		arg_7_0._list:pushBackCustomItem(arg_7_0:setOrCreateItem(nil, var_7_0[iter_7_0], iter_7_0))
	end

	var_7_1:setContentSize(cc.size(math.min(ClientView.SCR_W, #var_7_0 * 250), lc.h(var_7_1)))
end

function var_0_0.setOrCreateItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = 0.6

	if not arg_9_1 then
		arg_9_1 = ccui.Widget:create()

		local var_9_1 = Data._exchangeInfo[arg_9_2]
		local var_9_2 = var_9_1._item
		local var_9_3 = var_9_1._reward
		local var_9_4 = Data._bonusInfo[var_9_3]._rid[1]
		local var_9_5 = ClientView.createShaderButton(nil, function()
			var_0_1.create(var_9_4, 1, var_0_1.OperateType.view):show()
		end)
		local var_9_6 = require("CardThumbnail").create(var_9_4, 1)

		var_9_6:setScale(var_9_0)
		var_9_5:setContentSize(lc.w(var_9_6) * var_9_0, lc.h(var_9_6) * var_9_0)
		lc.addChildToCenter(var_9_5, var_9_6)

		local var_9_7 = lc.createSprite("exchange_stage")

		arg_9_1:setContentSize(lc.w(var_9_7), lc.h(var_9_7))
		lc.addChildToPos(arg_9_1, var_9_7, cc.p(lc.cw(arg_9_1), lc.ch(var_9_7)))
		lc.addChildToPos(arg_9_1, var_9_5, cc.p(lc.cw(arg_9_1), lc.h(arg_9_1) - lc.ch(var_9_5) + 50))

		local var_9_8 = ClientView.createShaderButton("god_pump_btn", function(arg_11_0)
			arg_9_0:onExchange(arg_9_1._exchangeId)
		end)

		var_9_8:setDisabledShader(ClientView.SHADER_DISABLE)
		lc.addChildToPos(arg_9_1, var_9_8, cc.p(lc.cw(arg_9_1), lc.ch(var_9_8)))
		var_9_8:addLabel(Str(STR.EXCHANGE))

		arg_9_1._exchangeBtn = var_9_8
		arg_9_1._icons = {}

		function arg_9_1.update(arg_12_0, arg_12_1)
			local var_12_0 = arg_9_0:getParams(arg_12_0)

			arg_9_1._exchangeId = arg_12_0

			local var_12_1 = Data._exchangeInfo[arg_12_0]
			local var_12_2 = var_12_1._item
			local var_12_3 = var_12_1._number
			local var_12_4 = var_12_1._reward
			local var_12_5 = Data._bonusInfo[var_12_4]
			local var_12_6 = var_12_5._rid[1]
			local var_12_7 = var_12_5._count[1]

			var_9_6:updateComponent(var_12_6)

			if arg_9_1._countSpr then
				arg_9_1._countSpr:removeFromParent()

				arg_9_1._countSpr = nil
			end

			if var_12_7 > 1 then
				local var_12_8 = lc.createSprite("critical_num_" .. var_12_7)

				var_12_8:setRotation(-10)
				var_12_8:setScale(0.5)
				lc.addChildToPos(var_9_5, var_12_8, cc.p(lc.cw(var_9_5) + 60, 50 + lc.sh(var_12_8) / 2))

				arg_9_1._countSpr = var_12_8
			end

			for iter_12_0 = 1, #var_12_2 do
				local var_12_9 = var_12_2[iter_12_0]
				local var_12_10 = var_12_3[iter_12_0]

				if not arg_9_1._icons[iter_12_0] then
					arg_9_1._icons[iter_12_0] = IconWidget.create({
						_infoId = var_12_9,
						_count = var_12_10
					}, IconWidget.DisplayFlag.ITEM_NO_NAME)

					arg_9_1._icons[iter_12_0]:setScale(var_9_0)
					arg_9_1:addChild(arg_9_1._icons[iter_12_0])
				else
					arg_9_1._icons[iter_12_0]:resetData({
						_infoId = var_12_9
					})
				end

				arg_9_1._icons[iter_12_0]:setGray(var_12_10 > P:getItemCount(var_12_9, var_12_0))
			end

			lc.setNodesToCenter(arg_9_1, arg_9_1._icons, 10, lc.ch(arg_9_1) - 80)

			local var_12_11 = P._playerMarket._exchangeMap[arg_12_0] or 0

			if var_12_1._time ~= 0 then
				if var_12_1._time - var_12_11 <= 0 then
					var_9_8._label:setString(Str(STR.EXCHANGED))
					var_9_8:setEnabled(false)
				else
					var_9_8._label:setString(Str(STR.EXCHANGE))
					var_9_8:setEnabled(true)
				end
			else
				var_9_8._label:setString(Str(STR.EXCHANGE))
			end
		end
	end

	arg_9_1.update(arg_9_2, arg_9_3)

	return arg_9_1
end

function var_0_0.onExchange(arg_13_0, arg_13_1)
	require("Dialog").showDialog(Str(STR.CONFIRM_EXCHANGE), function()
		arg_13_0:doExchange(arg_13_1)
	end)
end

function var_0_0.doExchange(arg_15_0, arg_15_1)
	local var_15_0 = Data._exchangeInfo[arg_15_1]
	local var_15_1 = arg_15_0:getParams(arg_15_1)
	local var_15_2, var_15_3 = P._playerMarket:checkExchangeProp(var_15_0, 1, var_15_1)

	local function var_15_4()
		if var_15_2 == Data.ErrorType.need_more_count then
			return ToastManager.push(Str(STR.EXCHANGED))
		elseif var_15_2 == Data.ErrorType.need_more_ingot then
			return ToastManager.push(Str(STR.EXCHANGE_ITEM_NOT_ENOUGH))
		elseif var_15_2 == Data.ErrorType.ok then
			local var_16_0, var_16_1 = P._playerMarket:exchangeProp(var_15_0, nil, var_15_1)
			local var_16_2 = require("RewardPanel")

			var_16_2.create({
				_resMap = var_16_1
			}, var_16_2.MODE_EXCHANGE):show()
			arg_15_0._list:refreshItems()
		end
	end

	local var_15_5 = {}

	if var_15_3 then
		for iter_15_0, iter_15_1 in pairs(var_15_3) do
			if iter_15_1 > P:getItemCount(iter_15_0) then
				var_15_5[#var_15_5 + 1] = iter_15_0
			end
		end
	end

	if #var_15_5 > 0 then
		local var_15_6 = ""

		for iter_15_2, iter_15_3 in ipairs(var_15_5) do
			var_15_6 = var_15_6 .. ClientData.getNameByInfoId(iter_15_3)

			if iter_15_2 ~= #var_15_5 then
				var_15_6 = var_15_6 .. Str(STR.COLON)
			end
		end

		require("Dialog").showDialog(string.format(Str(STR.CONFIRM_COST_EXTRA_CARD), var_15_6), var_15_4)
	else
		var_15_4()
	end
end

function var_0_0.getParams(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(Data._exchangeInfo[arg_17_1]._item) do
		local var_17_0, var_17_1, var_17_2 = Data.removeAdditional(iter_17_1)

		if var_17_2 then
			return {
				_costExtra = false
			}
		end
	end

	return {
		_costExtra = true
	}
end

return var_0_0
