local var_0_0 = class("ActivityExchangeForm", BaseForm)
local var_0_1 = cc.size(970, 640)
local var_0_2 = 170
local var_0_3 = 20
local var_0_4 = 0
local var_0_5 = 170

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._type = arg_2_1

	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._resNames = ClientData.loadLCRes("res/activity.lcres")

	local var_2_0
	local var_2_1

	if arg_2_0._type then
		var_2_0, var_2_1 = {
			Str(STR.EXCHANGE)
		}, {}
	else
		var_2_0, var_2_1 = {
			Str(STR.ACTIVITY),
			Str(STR.EXCHANGE),
			Str(STR.HELP)
		}, {}
	end

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

	arg_2_0:addExchangeList()

	if not arg_2_0._type then
		arg_2_0:createAd()
		arg_2_0:addRuleArea()
	end

	arg_2_0:refreshExchangeList()
	var_2_3:showTab(1, true)
	arg_2_0._form:setContentSize(cc.size(var_0_1.width, var_0_1.height + 60))
end

function var_0_0.createAd(arg_4_0)
	local var_4_0 = lc.createSprite("res/jpg/exchange_bg2.jpg")

	ClientView.setMaxSize(var_4_0, var_0_1.width - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, var_0_1.height - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM)
	lc.addChildToCenter(arg_4_0._contentBg, var_4_0, -1)

	arg_4_0._adSpr = var_4_0

	local var_4_1 = ClientData.getValidActivityByType(803)

	arg_4_0._actInfo = var_4_1

	if var_4_1 and #var_4_1._img > 0 then
		var_4_0:setTexture(string.format("res/jpg/%s.jpg", var_4_1._img))

		local var_4_2 = arg_4_0._actInfo._img

		arg_4_0._actType = tonumber(string.sub(var_4_2, -1))
	end

	local var_4_3 = ClientData.getValidActivityByType(531)

	if var_4_3 then
		local var_4_4 = Data._bonusInfo[var_4_3._bonusId[1]]
		local var_4_5

		if var_4_3._param[1] == Data.PurchaseType.privilege_2 then
			var_4_5 = ClientView.createTTF(Str(STR.TWO_2) .. " " .. var_4_4._count[1] .. ClientData.getNameByInfoId(var_4_4._rid[1]), ClientView.FontSize.S3)
		else
			var_4_5 = ClientView.createTTF(Str(STR.ACTIVITY_DESC_EXCHANGE), ClientView.FontSize.S3)
		end

		var_4_5:enableOutline(lc.Color4B.black, 1)

		local var_4_6 = 40
		local var_4_7 = lc.createSprite({
			_name = "img_com_bg_46",
			_crect = ClientView.CRECT_COM_BG46,
			_size = cc.size(math.max(lc.w(var_4_5) + 50, lc.cw(var_4_0) + 2 * var_4_6), 80)
		})

		lc.addChildToPos(var_4_0, var_4_7, cc.p(lc.w(var_4_0) - lc.cw(var_4_7), 150))

		local var_4_8 = lc.createSprite(var_4_3._param[1] == Data.PurchaseType.privilege_1 and "activity_privilege_1" or "activity_privilege_2")

		lc.addChildToPos(var_4_7, var_4_8, cc.p(lc.cw(var_4_7) - 30, lc.h(var_4_7) + lc.ch(var_4_8)))

		local var_4_9 = ClientView.createTTF(Str(STR.ONE_2) .. " " .. Str(var_4_3._descSid), ClientView.FontSize.S3, ClientView.COLOR_TEXT_WHITE, cc.size(lc.w(var_4_7), 0))

		var_4_9:enableOutline(lc.Color4B.black, 1)
		var_4_9:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_4_7, var_4_9, cc.p(var_4_6, lc.h(var_4_7) - lc.ch(var_4_9) - 10))
		var_4_5:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_4_7, var_4_5, cc.p(var_4_6, lc.ch(var_4_5) + 10))
		arg_4_0:runAction(lc.rep(lc.sequence(function()
			local var_5_0 = P._playerActivity:getPrivilegeTimeStr()
			local var_5_1 = arg_4_0._tip

			if var_5_1 then
				var_5_1:removeFromParent()
			end

			if var_5_0 then
				local var_5_2 = ClientView.createBoldRichText(var_5_0, {
					_boldClr = ClientView.COLOR_TEXT_BLUE_DARK
				})

				var_5_2:setAnchorPoint(cc.p(0.5, 0.5))
				lc.addChildToPos(var_4_0, var_5_2, cc.p(lc.x(var_4_7) - 110, 60))

				arg_4_0._tip = var_5_2
			end
		end, 1)))

		if not P._playerActivity:getPrivilegeTimeStr() then
			local var_4_10 = lc.createSprite(var_4_3._param[1] == Data.PurchaseType.privilege_1 and "activity_rmb_30" or "activity_rmb_6")

			lc.addChildToPos(var_4_0, var_4_10, cc.p(lc.x(var_4_7) - 30, 85))

			local var_4_11 = ClientView.createShaderButton("img_btn_recharge_1", function()
				arg_4_0:onBuy(var_4_3._param[1])
			end)

			var_4_11:addLabel(Str(STR.BUY))
			lc.addChildToPos(var_4_0, var_4_11, cc.p(lc.x(var_4_7) - 30, lc.bottom(var_4_10) - lc.ch(var_4_11) - 10))
		end
	end
end

function var_0_0.onBuy(arg_7_0, arg_7_1)
	ClientView.startIAP(arg_7_1)
	arg_7_0:hide()
end

function var_0_0.addRuleArea(arg_8_0)
	local var_8_0 = Data.HelpType.activity_1 + arg_8_0._actType - 1
	local var_8_1 = Data.getHelpStrsByType(var_8_0)
	local var_8_2 = arg_8_0:createTextsList(arg_8_0._exchangeList:getContentSize(), var_8_1)

	lc.addChildToPos(arg_8_0._contentBg, var_8_2, cc.p(arg_8_0._exchangeList:getPosition()), -1)

	arg_8_0._ruleList1 = var_8_2
end

function var_0_0.addRuleArea2(arg_9_0)
	local var_9_0 = Data.getHelpStrsByType(Data.HelpType.activity_2)
	local var_9_1 = arg_9_0:createTextsList(arg_9_0._exchangeList:getContentSize(), var_9_0)

	lc.addChildToPos(arg_9_0._contentBg, var_9_1, cc.p(arg_9_0._exchangeList:getPosition()), -1)

	arg_9_0._ruleList2 = var_9_1
end

function var_0_0.createTextsList(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = lc.List.createV(arg_10_1, 40, 30)

	var_10_0:setAnchorPoint(0.5, 0.5)

	for iter_10_0 = 1, #arg_10_2 do
		local var_10_1 = ccui.Widget:create()

		var_10_1:setContentSize(lc.w(var_10_0) - 80, 0)

		local var_10_2 = ClientView.createTTF(arg_10_2[iter_10_0] .. "\n", ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(lc.w(var_10_1) - 60, 0))

		var_10_1:addChild(var_10_2)
		var_10_1:setContentSize(lc.w(var_10_1), lc.h(var_10_2))
		var_10_2:setPosition(lc.w(var_10_2) / 2 + 40, lc.h(var_10_1) / 2)

		if iter_10_0 < #arg_10_2 then
			local var_10_3 = ClientView.createDividingLine(lc.w(var_10_1), ClientView.COLOR_DIVIDING_LINE_LIGHT)

			var_10_3:setPosition(lc.w(var_10_1) / 2, -12)
			var_10_3:setOpacity(128)
			var_10_1:addChild(var_10_3)
		end

		var_10_0:pushBackCustomItem(var_10_1)
	end

	return var_10_0
end

function var_0_0.addExchangeList(arg_11_0)
	local var_11_0 = lc.List.createV(cc.size(lc.w(arg_11_0._contentBg) - 40, lc.h(arg_11_0._contentBg) - 40), 30, 0)

	var_11_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_11_0._contentBg, var_11_0, cc.p(lc.cw(var_11_0) + 30, lc.ch(var_11_0) + 20), -1)

	arg_11_0._exchangeList = var_11_0
end

function var_0_0.refreshExchangeList(arg_12_0)
	local var_12_0 = arg_12_0._exchangeList
	local var_12_1 = {}
	local var_12_2

	if arg_12_0._type then
		var_12_2 = arg_12_0._type
	else
		print("+++++++++++++++++++++++actType", arg_12_0._actType)

		var_12_2 = 97

		if arg_12_0._actType == 2 then
			var_12_2 = 162
		elseif arg_12_0._actType == 4 then
			var_12_2 = 147
		elseif arg_12_0._actType == 1 then
			var_12_2 = 148
		end
	end

	for iter_12_0, iter_12_1 in pairs(Data._exchangeInfo) do
		if iter_12_1._activityId == var_12_2 then
			table.insert(var_12_1, iter_12_1)
		end
	end

	table.sort(var_12_1, function(arg_13_0, arg_13_1)
		return arg_13_0._id < arg_13_1._id
	end)
	var_12_0:bindData(var_12_1, function(arg_14_0, arg_14_1)
		arg_12_0:setOrCreateItem(arg_14_0, arg_14_1)
	end, math.min(6, #var_12_1))

	for iter_12_2 = 1, var_12_0._cacheCount do
		local var_12_3 = arg_12_0:setOrCreateItem(nil, var_12_1[iter_12_2])

		var_12_0:pushBackCustomItem(var_12_3)
	end
end

function var_0_0.setOrCreateItem(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_1 then
		arg_15_1 = ccui.Widget:create()

		arg_15_1:setContentSize(lc.w(arg_15_0._contentBg), var_0_5)

		arg_15_1._items = {}
		arg_15_1._exchange = arg_15_2

		local var_15_0 = arg_15_2._reward
		local var_15_1 = Data._bonusInfo[var_15_0]

		if not var_15_1 then
			print("+++++++++++++++++No info", var_15_0, arg_15_2._id)
		end

		local var_15_2 = var_15_1._rid[1]
		local var_15_3 = IconWidget.create({
			_infoId = var_15_2,
			_count = var_15_1._count[1]
		})

		lc.addChildToPos(arg_15_1, var_15_3, cc.p(lc.w(arg_15_1) - lc.w(var_15_3), lc.ch(arg_15_1) - 8))

		var_15_3._nameColor = ClientView.COLOR_TEXT_WHITE
		arg_15_1._rewardIcon = var_15_3

		if not P._playerMarket._exchangeMap[arg_15_2._id] then
			local var_15_4 = 0
		end

		local var_15_5 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_16_0)
			local var_16_0 = arg_15_1._exchange
			local var_16_1 = arg_15_1._exchange
			local var_16_2 = var_16_1._item
			local var_16_3 = var_16_1._reward
			local var_16_4 = Data._bonusInfo[var_16_3]
			local var_16_5 = var_16_4._rid[1]

			local function var_16_6(arg_17_0, arg_17_1)
				local var_17_0 = true

				for iter_17_0, iter_17_1 in ipairs(var_16_2) do
					if P:getItemCount(iter_17_1) < var_16_1._number[iter_17_0] then
						var_17_0 = false

						break
					end
				end

				if var_17_0 then
					local var_17_1 = P._playerMarket._exchangeMap[var_16_1._id] or 0

					if var_16_1._time ~= 0 and var_16_1._time - var_17_1 <= 0 then
						return ToastManager.push(Str(STR.EXCHANGED))
					end

					P._playerMarket:exchangeProp(var_16_1)

					if arg_17_1 then
						arg_17_1[var_16_5] = (arg_17_1[var_16_5] or 0) + var_16_4._count[1]
					else
						local var_17_2 = require("RewardPanel")

						var_17_2.create({
							{
								info_id = var_16_5,
								num = var_16_4._count[1]
							}
						}, var_17_2.MODE_EXCHANGE):show()
						arg_15_0._exchangeList:refreshItems()
					end
				else
					return ToastManager.push(Str(STR.EXCHANGE_ITEM_NOT_ENOUGH))
				end
			end

			local var_16_7, var_16_8 = Data.getInfo(var_16_5)

			if var_16_1._visibleType == 1 and not P._playerActivity:isPrivilegeValid() then
				return ToastManager.push(Str(STR.EXCHANGE_FORBID))
			elseif var_16_8 >= Data.CardType.monster and var_16_8 <= Data.CardType.rare and var_16_7._maxCount <= P._playerCard:getCardCount(var_16_5) then
				return require("Dialog").showDialog(Str(STR.EXCHANGE_CARD_LIMIT), var_16_6)
			elseif var_16_5 == Data.ResType.ingot and var_16_2[1] then
				local var_16_9 = Data.getType(var_16_2[1])

				if var_16_9 >= Data.CardType.monster and var_16_9 <= Data.CardType.rare then
					return require("Dialog").showDialog(Str(STR.CONFIRM_EXCHANGE_CARD_INGOT), var_16_6)
				end
			else
				local var_16_10 = P._playerMarket:getExchangeMaxCount(var_16_1)

				if var_16_10 <= 0 then
					return ToastManager.push(Str(STR.EXCHANGE_ITEM_NOT_ENOUGH))
				else
					return require("GetNumberForm").create({
						_maxCount = var_16_10
					}, function(arg_18_0)
						local var_18_0 = {}

						for iter_18_0 = 1, arg_18_0 do
							var_16_6(nil, var_18_0)
						end

						local var_18_1 = {}

						for iter_18_1, iter_18_2 in pairs(var_18_0) do
							var_18_1[#var_18_1 + 1] = {
								info_id = iter_18_1,
								num = iter_18_2
							}
						end

						local var_18_2 = require("RewardPanel")

						var_18_2.create(var_18_1, var_18_2.MODE_EXCHANGE):show()
						arg_15_0._exchangeList:refreshItems()
					end):show()
				end
			end

			return var_16_6()
		end, ClientView.CRECT_BUTTON_S, 110)

		var_15_5:setDisabledShader(ClientView.SHADER_DISABLE)
		lc.addChildToPos(arg_15_1, var_15_5, cc.p(lc.left(var_15_3) - lc.cw(var_15_5) - 16, lc.y(var_15_3)))
		var_15_5:addLabel(Str(STR.EXCHANGE))

		local var_15_6
		local var_15_7 = ClientView.createDividingLine(lc.w(arg_15_0._exchangeList), ClientView.COLOR_DIVIDING_LINE_LIGHT)

		lc.addChildToPos(arg_15_1, var_15_7, cc.p(lc.cw(arg_15_0._exchangeList), lc.ch(var_15_7)))

		arg_15_1._seperator = var_15_7

		function arg_15_1.update(arg_19_0)
			arg_15_1._exchange = arg_19_0

			local var_19_0 = arg_15_0._exchangeList._data

			var_15_7:setVisible(arg_19_0 ~= var_19_0[#var_19_0])

			local var_19_1 = P._playerMarket._exchangeMap[arg_19_0._id] or 0

			if arg_19_0._time ~= 0 then
				if arg_19_0._time - var_19_1 <= 0 then
					var_15_5._label:setString(Str(STR.EXCHANGED))
					var_15_5:setEnabled(false)
				else
					var_15_5._label:setString(Str(STR.EXCHANGE))
					var_15_5:setEnabled(true)
				end
			else
				var_15_5._label:setString(Str(STR.EXCHANGE))
			end

			for iter_19_0, iter_19_1 in ipairs(arg_15_1._items) do
				iter_19_1:setVisible(false)
			end

			local var_19_2 = arg_19_0._item
			local var_19_3 = #var_19_2

			for iter_19_2, iter_19_3 in ipairs(var_19_2) do
				local var_19_4 = arg_15_1._items[iter_19_2]
				local var_19_5 = P:getItemCount(iter_19_3)

				if not var_19_4 then
					var_19_4 = IconWidget.create({
						_infoId = iter_19_3,
						_count = P:getItemCount(iter_19_3)
					})

					var_19_4:setScale(0.9)
					lc.addChildToPos(arg_15_1, var_19_4, cc.p((var_19_3 <= 5 and 30 or 20) + (iter_19_2 - 0.5) * (lc.w(var_19_4) - 10), lc.ch(arg_15_1) - 15))
					var_19_4._name:setColor(ClientView.COLOR_TEXT_WHITE)

					var_19_4._nameColor = ClientView.COLOR_TEXT_WHITE

					table.insert(arg_15_1._items, iter_19_2, var_19_4)
				else
					var_19_4:setPosition(cc.p((var_19_3 <= 5 and 30 or 20) + (iter_19_2 - 0.5) * (lc.w(var_19_4) - 10), lc.ch(arg_15_1) - 15))
					var_19_4:resetData({
						_infoId = iter_19_3,
						_count = P:getItemCount(iter_19_3)
					})
					var_19_4:setVisible(true)
				end

				var_19_4:setGray(var_19_5 <= 0)
				var_19_4._countBg._count:setString(ClientData.formatNum(P:getItemCount(iter_19_3), 9999) .. "/" .. arg_19_0._number[iter_19_2])
			end

			local var_19_6 = arg_19_0._reward
			local var_19_7 = Data._bonusInfo[var_19_6]
			local var_19_8 = var_19_7._rid[1]

			var_15_3:resetData({
				_infoId = var_19_8,
				_count = var_19_7._count[1]
			})

			if var_15_6 then
				var_15_6:removeFromParent()

				var_15_6 = nil
			end

			local var_19_9 = ""

			if arg_19_0._visibleType == 1 then
				var_19_9 = var_19_9 .. Str(STR.EXCHANGE_PRIVILEGE)
			end

			if arg_19_0._time > 0 then
				var_19_9 = var_19_9 .. Str(STR.EXCHANGE_TIP2)
			else
				var_19_9 = var_19_9 .. Str(STR.EXCHANGE_TIP1)
			end

			var_15_6 = ClientView.createBoldRichTextMultiLine(string.format(var_19_9, arg_19_0._time, arg_19_0._time - var_19_1), ClientView.RICHTEXT_PARAM_LIGHT_S2)

			lc.addChildToPos(arg_15_1, var_15_6, cc.p(lc.cw(var_15_6) + 32, 148))
		end
	end

	arg_15_1.update(arg_15_2)

	return arg_15_1
end

function var_0_0.showTab(arg_20_0, arg_20_1)
	if arg_20_0._adSpr then
		arg_20_0._adSpr:setVisible(false)
	end

	if arg_20_0._exchangeList then
		arg_20_0._exchangeList:setVisible(false)
	end

	if arg_20_0._ruleList1 then
		arg_20_0._ruleList1:setVisible(false)
	end

	if arg_20_1 == 1 then
		if arg_20_0._type then
			arg_20_0._exchangeList:setVisible(true)
		else
			arg_20_0._adSpr:setVisible(true)
		end
	elseif arg_20_1 == 2 then
		arg_20_0._exchangeList:setVisible(true)
	elseif arg_20_1 == 3 then
		arg_20_0._ruleList1:setVisible(true)
	elseif arg_20_1 == 4 then
		arg_20_0._ruleList2:setVisible(true)
	end
end

function var_0_0.onEnter(arg_21_0)
	var_0_0.super.onEnter(arg_21_0)

	arg_21_0._listeners = {}
end

function var_0_0.onExit(arg_22_0)
	var_0_0.super.onExit(arg_22_0)

	for iter_22_0 = 1, #arg_22_0._listeners do
		lc.Dispatcher:removeEventListener(arg_22_0._listeners[iter_22_0])
	end
end

function var_0_0.onCleanup(arg_23_0)
	lc.TextureCache:removeTextureForKey("res/jpg/exchange_bg2.jpg")
	ClientData.unloadLCRes(arg_23_0._resNames)
end

return var_0_0
