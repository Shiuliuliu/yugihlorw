local var_0_0 = class("ProductWidget", lc.ExtendUIWidget)

var_0_0.PRODUCT_ITEM_SIZE = cc.size(194, 260)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(var_0_0.PRODUCT_ITEM_SIZE)
	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.onEnter(arg_2_0)
	arg_2_0._listeners = {}

	table.insert(arg_2_0._listeners, lc.addEventListener(Data.Event.product_dirty, function(arg_3_0)
		if arg_2_0._product._resType == arg_3_0._data._resType then
			arg_2_0:updateBuyButton()
		end
	end))
	table.insert(arg_2_0._listeners, lc.addEventListener(Data.Event.gold_dirty, function(arg_4_0)
		if arg_2_0._product._resType == Data.ResType.gold then
			arg_2_0:updateBuyButton()
		end
	end))
	table.insert(arg_2_0._listeners, lc.addEventListener(Data.Event.ingot_dirty, function(arg_5_0)
		if arg_2_0._product._resType == Data.ResType.ingot then
			arg_2_0:updateBuyButton()
		end
	end))
	arg_2_0:updateBuyButton()
end

function var_0_0.onExit(arg_6_0)
	for iter_6_0 = 1, #arg_6_0._listeners do
		lc.Dispatcher:removeEventListener(arg_6_0._listeners[iter_6_0])
	end
end

function var_0_0.init(arg_7_0, arg_7_1)
	arg_7_0._product = arg_7_1

	local var_7_0 = ccui.Scale9Sprite:createWithSpriteFrameName("img_product_bg", cc.rect(45, 120, 2, 2))

	var_7_0:setContentSize(var_0_0.PRODUCT_ITEM_SIZE)
	lc.addChildToCenter(arg_7_0, var_7_0)

	local var_7_1 = ClientData.getNameByInfoId(arg_7_1._infoId)
	local var_7_2 = cc.Label:createWithTTF(var_7_1, ClientView.TTF_FONT, ClientView.FontSize.M1)

	var_7_2:setScale(0.7)
	var_7_2:setColor(ClientView.COLOR_TEXT_LIGHT)
	lc.addChildToPos(arg_7_0, var_7_2, cc.p(lc.w(arg_7_0) / 2, lc.h(arg_7_0) - 26))

	arg_7_0._name = var_7_2

	local var_7_3 = IconWidget.create(arg_7_1, IconWidgetFlag.ITEM_NO_NAME)

	lc.addChildToPos(arg_7_0, var_7_3, cc.p(lc.w(arg_7_0) / 2, lc.h(arg_7_0) / 2 + 24))

	arg_7_0._icon = var_7_3

	local var_7_4 = arg_7_1._info
	local var_7_5 = lc.createSprite("img_com_bg_19")

	lc.addChildToPos(arg_7_0, var_7_5, cc.p(lc.w(arg_7_0) / 2, 6))

	local var_7_6 = ClientView.createTTF("0", ClientView.FontSize.S3)

	lc.addChildToPos(var_7_5, var_7_6, cc.p(lc.w(var_7_5) / 2, 24))

	var_7_5._value = var_7_6

	var_7_5:setVisible(arg_7_1._buyCountMax ~= nil)

	arg_7_0._remainCount = var_7_5

	local var_7_7 = ClientView.createScale9ShaderButton("img_btn_1", function()
		if arg_7_0._callback then
			arg_7_0._callback(arg_7_0)
		end
	end, ClientView.CRECT_BUTTON, 152)

	var_7_7:setDisabledShader(ClientView.SHADER_DISABLE)
	lc.addChildToPos(arg_7_0, var_7_7, cc.p(lc.w(arg_7_0) / 2, 58))

	arg_7_0._btnBuy = var_7_7

	arg_7_0:updateProduct(arg_7_1)
end

function var_0_0.registerCallback(arg_9_0, arg_9_1)
	arg_9_0._callback = arg_9_1
end

function var_0_0.updateProduct(arg_10_0, arg_10_1)
	arg_10_0._product = arg_10_1

	if arg_10_1._isAct or arg_10_1._isFixed and arg_10_1._type ~= Data.MarketBuyType.fragment then
		if arg_10_0._tag == nil then
			local var_10_0 = lc.createSprite("img_tag_act")

			var_10_0:setRotation(-10)
			lc.addChildToPos(arg_10_0, var_10_0, cc.p(180, 154))

			arg_10_0._tag = var_10_0
		end

		arg_10_0._tag:setVisible(true)
		arg_10_0._tag:setSpriteFrame(arg_10_1._isAct and "img_tag_act" or "img_tag_long")
	elseif arg_10_0._tag then
		arg_10_0._tag:setVisible(false)
	end

	local var_10_1 = ClientData.getNameByInfoId(arg_10_1._infoId)

	arg_10_0._name:setString(var_10_1)
	arg_10_0._icon:resetData(arg_10_1)
	arg_10_0:updateBuyButton()
end

function var_0_0.updateBuyButton(arg_11_0)
	local var_11_0 = arg_11_0._btnBuy

	var_11_0:setEnabled(true)
	var_11_0:removeAllChildren()

	local var_11_1 = arg_11_0._product

	if var_11_1._isAvailable then
		local var_11_2 = Data.getType(var_11_1._resType)
		local var_11_3 = ClientData.getIconName(var_11_1._resType)
		local var_11_4 = var_11_1._cost

		if var_11_1._isInfo then
			var_11_0:setVisible(false)

			if arg_11_0._infoPriceArea == nil then
				local var_11_5 = ClientView.createItemCountArea(var_11_1._resType, var_11_3, 120, var_11_4)
				local var_11_6, var_11_7 = var_11_0:getPosition()

				lc.addChildToPos(arg_11_0, var_11_5, cc.p(var_11_6, var_11_7 + 8))

				arg_11_0._infoPriceArea = var_11_5
			end
		else
			if var_11_1._type == Data.MarketBuyType.union and P._playerUnion:getMyUnion()._level < var_11_1._info._level then
				arg_11_0._remainCount:setVisible(false)
				var_11_0:addLabel(string.format(Str(STR.UNION_X_LEVEL), var_11_1._info._level))

				return
			end

			if var_11_1._buyCountMax then
				arg_11_0._remainCount._value:setString(string.format(Str(STR.REMAIN_BUY_TIMES), var_11_1._buyCountMax - var_11_1._buyCount))
				arg_11_0._remainCount:setVisible(true)

				if var_11_1._buyCountMax <= var_11_1._buyCount then
					var_11_0:addLabel(Str(STR.SOLD_OUT))
					var_11_0:setEnabled(false)
					var_11_0:setSwallowTouches(false)

					return
				end
			elseif arg_11_0._remainCount then
				arg_11_0._remainCount:setVisible(false)
			end

			local var_11_8

			if var_11_3 then
				var_11_8 = lc.createSprite(var_11_3)
			else
				var_11_8 = IconWidget.create({
					_isFragment = true,
					_infoId = var_11_1._resType
				}, 0)

				var_11_8:setTouchEnabled(false)
				var_11_8:setScale(0.5)
			end

			local var_11_9 = ClientView.createBMFont(ClientView.BMFont.huali_26, string.format("%d", var_11_4))

			if not var_11_1._isInfo then
				if var_11_1._costFragment then
					local var_11_10

					if var_11_2 == Data.CardType.common_fragment then
						var_11_10 = P:getItemCount(var_11_1._resType)
					else
						var_11_10 = P._playerCard:getFragmentNum(var_11_1._resType)
					end

					arg_11_0._isResLack = var_11_10 < var_11_4
				else
					arg_11_0._isResLack = var_11_4 > P:getItemCount(var_11_1._resType)
				end
			end

			var_11_9:setColor(arg_11_0._isResLack and lc.Color3B.red or lc.Color3B.white)
			lc.addNodesToCenter(var_11_0, {
				var_11_8,
				var_11_9
			}, 10, lc.h(var_11_0) / 2 + 2)
		end
	else
		local var_11_11

		if var_11_1._type == Data.MarketBuyType.daily then
			var_11_11 = Str(STR.SOLD_OUT)
		else
			var_11_11 = Str(STR.PURCHASED)
		end

		var_11_0:addLabel(var_11_11)
		var_11_0:setEnabled(false)
	end

	var_11_0:setSwallowTouches(var_11_0:isEnabled())
end

return var_0_0
