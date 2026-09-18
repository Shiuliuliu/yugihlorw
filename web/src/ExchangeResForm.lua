local var_0_0 = class("ExchangeResForm", BaseForm)
local var_0_1 = cc.size(700, 520)
local var_0_2 = cc.size(580, 300)
local var_0_3 = {
	[7129] = 4,
	[7158] = 1,
	[7122] = 2,
	[Data.PropsId.avatar_skin_crystal] = 3,
	[Data.PropsId.yubi] = 5,
	[Data.PropsId.vote_shop_token] = 6,
	[Data.PropsId.void_diamond_2] = 7,
	[Data.PropsId.lottery_token] = 8
}

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	ClientView._resExchangeForms[arg_1_0] = var_1_0

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	if arg_2_1 ~= Data.ResType.gold and arg_2_1 ~= Data.ResType.grain and arg_2_1 ~= Data.PropsId.dust_monster and arg_2_1 ~= Data.PropsId.dust_magic and arg_2_1 ~= Data.PropsId.dust_rare and arg_2_1 ~= Data.PropsId.dimension_bottle and arg_2_1 ~= Data.PropsId.skin_crystal and arg_2_1 ~= Data.PropsId.times_package_ticket and not var_0_3[arg_2_1] then
		return
	end

	arg_2_0._resType = arg_2_1

	local var_2_0 = cc.size(var_0_1.width, var_0_1.height)
	local var_2_1 = cc.size(var_0_2.width, var_0_2.height)

	if arg_2_1 == Data.ResType.grain then
		var_2_0.height = var_2_0.height - 200
		var_2_1.height = var_2_1.height - 200
	end

	var_0_0.super.init(arg_2_0, var_2_0, nil, 0)

	arg_2_0._isShowResourceUI = true

	local var_2_2 = ClientData._player
	local var_2_3 = arg_2_0._form
	local var_2_4 = IconWidget.create({
		_infoId = arg_2_1
	}, 0)

	lc.addChildToPos(var_2_3, var_2_4, cc.p(120, var_2_0.height - var_0_0.FRAME_THICK_TOP - 30 - lc.h(var_2_4) / 2), 1)

	arg_2_0._icon = var_2_4

	local var_2_5 = ClientView.createTTF(ClientData.getNameByInfoId(arg_2_1), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)
	local var_2_6 = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = ClientView.CRECT_COM_BG2,
		_size = cc.size(320, 40)
	})

	var_2_6:setColor(lc.Color3B.black)
	var_2_6:setOpacity(100)
	lc.addChildToPos(var_2_6, var_2_5, cc.p(30 + lc.w(var_2_5) / 2, lc.h(var_2_6) / 2 - 1))
	lc.addChildToPos(var_2_3, var_2_6, cc.p(lc.right(var_2_4) - 10 + lc.w(var_2_6) / 2, lc.top(var_2_4) - lc.h(var_2_6) / 2 - 10))
	arg_2_0:updateBuyTimes()

	local var_2_7 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = var_2_1
	})

	lc.addChildToPos(var_2_3, var_2_7, cc.p(lc.w(var_2_3) / 2, lc.bottom(var_2_4) - 10 - lc.h(var_2_7) / 2))

	local function var_2_8(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = ClientData.getIconName(arg_3_0)
		local var_3_1 = lc.createSprite(var_3_0)

		var_3_1:setAnchorPoint(arg_3_1, 0.5)
		lc.addChildToPos(var_2_7, var_3_1, cc.p(0, arg_3_2))

		local var_3_2 = ClientView.createBMFont(ClientView.BMFont.huali_32, "")

		var_3_2:setAnchorPoint(arg_3_1, 0.5)
		lc.addChildToPos(var_2_7, var_3_2, cc.p(0, arg_3_2))

		return var_3_1, var_3_2
	end

	arg_2_0._line = arg_2_1 == Data.ResType.grain and 1 or 3
	arg_2_0._arrows = {}

	local var_2_9 = var_2_1.height / 2 + (arg_2_1 == Data.ResType.grain and 0 or 90)

	for iter_2_0 = 1, arg_2_0._line do
		local var_2_10 = lc.createSprite("img_arrow_right")

		var_2_10:setColor(ClientView.COLOR_TEXT_GREEN)
		lc.addChildToPos(var_2_7, var_2_10, cc.p(var_2_1.width / 2 - 106, var_2_9))

		var_2_9 = var_2_9 - 90
		arg_2_0._arrows[iter_2_0] = var_2_10
	end

	arg_2_0._ingotIcons, arg_2_0._ingotVals, arg_2_0._resIcons, arg_2_0._resVals = {}, {}, {}, {}
	arg_2_0._fromRes = {}
	arg_2_0._exchanges = {}

	if var_0_3[arg_2_1] then
		for iter_2_1 = 1, table.maxn(Data._exchangeInfo) do
			local var_2_11 = Data._exchangeInfo[iter_2_1]

			if var_2_11 and var_2_11._activityId == var_0_3[arg_2_1] then
				table.insert(arg_2_0._exchanges, var_2_11)
				table.insert(arg_2_0._fromRes, var_2_11._item[1])
			end
		end
	else
		arg_2_0._fromRes = {
			Data.ResType.ingot,
			Data.ResType.ingot,
			Data.ResType.ingot
		}
	end

	for iter_2_2 = 1, arg_2_0._line do
		arg_2_0._ingotIcons[iter_2_2], arg_2_0._ingotVals[iter_2_2] = var_2_8(arg_2_0._fromRes[iter_2_2], 1, lc.y(arg_2_0._arrows[iter_2_2]))
		arg_2_0._resIcons[iter_2_2], arg_2_0._resVals[iter_2_2] = var_2_8(arg_2_1, 0, lc.y(arg_2_0._arrows[iter_2_2]))

		local var_2_12 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
			arg_2_0:exchange(iter_2_2)
		end, ClientView.CRECT_BUTTON_S, 150)

		var_2_12:addLabel(Str(STR.EXCHANGE))
		lc.addChildToPos(var_2_7, var_2_12, cc.p(lc.x(arg_2_0._arrows[iter_2_2]) + 290, lc.y(arg_2_0._arrows[iter_2_2]) - 2))
	end

	arg_2_0:updateExchange()
end

function var_0_0.exchange(arg_5_0, arg_5_1)
	local var_5_0 = Data.ErrorType.ok

	if arg_5_0._resType == Data.ResType.gold then
		var_5_0 = ClientData._player:buyGold(arg_5_1)
	elseif arg_5_0._resType == Data.ResType.grain then
		var_5_0 = ClientData._player:buyGrain()
	elseif var_0_3[arg_5_0._resType] then
		var_5_0 = P._playerMarket:exchangeProp(arg_5_0._exchanges[arg_5_1])
	else
		var_5_0 = ClientData._player:buyDust(arg_5_0._resType, arg_5_1)
	end

	if var_5_0 == Data.ErrorType.ok then
		arg_5_0:updateExchange()
		ClientView.showResChangeText(arg_5_0, arg_5_0._resType, tonumber(arg_5_0._resVals[arg_5_1]:getString()))

		if arg_5_0._resType == Data.PropsId.avatar_skin_crystal then
			local var_5_1 = Data.PropsId.lottery_package_token
			local var_5_2 = math.floor(tonumber(arg_5_0._resVals[arg_5_1]:getString()) / 10)

			ToastManager.push(string.format(Str(STR.GET_BONUS_EXTRA), ClientData.getNameByInfoId(var_5_1), var_5_2))
		elseif arg_5_0._resType == 7129 then
			local var_5_3 = 7198
			local var_5_4 = math.floor(tonumber(arg_5_0._resVals[arg_5_1]:getString()) * 30)

			ToastManager.push(string.format(Str(STR.GET_BONUS_EXTRA), ClientData.getNameByInfoId(var_5_3), var_5_4))
		elseif arg_5_0._resType == Data.PropsId.yubi then
			local var_5_5 = Data.PropsId.week_lottery_token
			local var_5_6 = tonumber(arg_5_0._resVals[arg_5_1]:getString())

			ToastManager.push(string.format(Str(STR.GET_BONUS_EXTRA), ClientData.getNameByInfoId(var_5_5), var_5_6))
		elseif arg_5_0._resType == Data.PropsId.lottery_token then
			local var_5_7 = Data.PropsId.clash_ex_ticket
			local var_5_8 = tonumber(arg_5_0._resVals[arg_5_1]:getString())

			ToastManager.push(string.format(Str(STR.GET_BONUS_EXTRA), ClientData.getNameByInfoId(var_5_7), var_5_8))
		end

		if arg_5_0._resType == Data.ResType.gold then
			ClientData.sendBuyGold(arg_5_1)
		elseif arg_5_0._resType == Data.ResType.grain then
			ClientData.sendBuyGrain()
		elseif not var_0_3[arg_5_0._resType] then
			ClientData.sendBuyDust(arg_5_0._resType, arg_5_1)
		end
	elseif var_5_0 == Data.ErrorType.need_more_ingot then
		if ClientData.isHideCharge() or var_0_3[arg_5_0._resType] then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(arg_5_0._fromRes[arg_5_1])))
		else
			require("PromptForm").ConfirmBuyIngot.create():show()
		end
	elseif var_5_0 == Data.ErrorType.need_more_daily_buy_gold or var_5_0 == Data.ErrorType.need_more_daily_buy_grain then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH_BUY_TIMES), Str(STR.BUY) .. ClientData.getNameByInfoId(arg_5_0._resType)))
	end
end

function var_0_0.updateExchange(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}

	arg_6_0._ingots, arg_6_0._values = var_6_0, var_6_1

	if var_0_3[arg_6_0._resType] then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._exchanges) do
			var_6_0[iter_6_0], var_6_1[iter_6_0] = iter_6_1._number[1], Data._bonusInfo[iter_6_1._reward]._count[1]
		end
	else
		for iter_6_2 = 1, arg_6_0._line do
			local var_6_2
			local var_6_3

			if arg_6_0._resType == Data.ResType.gold then
				var_6_0[iter_6_2], var_6_1[iter_6_2] = ClientData._player:getExchangeGold(iter_6_2)
			elseif arg_6_0._resType == Data.ResType.grain then
				var_6_0[iter_6_2], var_6_1[iter_6_2] = ClientData._player:getExchangeGrain()
			else
				var_6_0[iter_6_2], var_6_1[iter_6_2] = ClientData._player:getExchangeDust(arg_6_0._resType, iter_6_2)
			end
		end
	end

	for iter_6_3 = 1, arg_6_0._line do
		arg_6_0._ingotVals[iter_6_3]:setString(tostring(var_6_0[iter_6_3]))
		arg_6_0._ingotVals[iter_6_3]:setPositionX(lc.left(arg_6_0._arrows[iter_6_3]) - 20)
		arg_6_0._ingotIcons[iter_6_3]:setPositionX(lc.left(arg_6_0._ingotVals[iter_6_3]) - 6)
		arg_6_0._ingotVals[iter_6_3]:setColor(var_6_0[iter_6_3] > P:getItemCount(arg_6_0._fromRes[iter_6_3]) and lc.Color3B.red or lc.Color3B.white)
		arg_6_0._resVals[iter_6_3]:setString(tostring(var_6_1[iter_6_3]))
		arg_6_0._resIcons[iter_6_3]:setPositionX(lc.right(arg_6_0._arrows[iter_6_3]) + 20)
		arg_6_0._resVals[iter_6_3]:setPositionX(lc.right(arg_6_0._resIcons[iter_6_3]) + 6)
	end

	arg_6_0:updateBuyTimes()
end

function var_0_0.updateBuyTimes(arg_7_0)
	if arg_7_0._resType ~= Data.ResType.grain then
		return
	end

	if arg_7_0._buyTimes then
		arg_7_0._buyTimes:removeFromParent()
	end

	local var_7_0 = ClientData._player
	local var_7_1
	local var_7_2

	if arg_7_0._resType == Data.ResType.gold then
		var_7_1 = var_7_0:getBuyGoldTimes()
		var_7_2 = var_7_1 + var_7_0._dailyBuyGold
	else
		var_7_1 = ClientData._player:getBuyGrainTimes()
		var_7_2 = var_7_1 + var_7_0._dailyBuyGrain
	end

	local var_7_3 = string.format(Str(STR.DAILY_EXCHANGE_TIMES), var_7_1, var_7_2)
	local var_7_4 = ClientView.createBoldRichText(var_7_3, {
		_normalClr = ClientView.COLOR_TEXT_LIGHT,
		_boldClr = ClientView.COLOR_TEXT_GREEN_DARK,
		_fontSize = ClientView.FontSize.S1
	})

	lc.addChildToPos(arg_7_0._form, var_7_4, cc.p(lc.right(arg_7_0._icon) + 20 + lc.w(var_7_4) / 2, lc.bottom(arg_7_0._icon) + lc.h(var_7_4) / 2 + 10))

	arg_7_0._buyTimes = var_7_4
end

function var_0_0.onEnter(arg_8_0)
	var_0_0.super.onEnter(arg_8_0)

	arg_8_0._listeners = {}

	table.insert(arg_8_0._listeners, lc.addEventListener(Data.Event.vip_dirty, function()
		arg_8_0:updateBuyTimes()
	end))
	table.insert(arg_8_0._listeners, lc.addEventListener(Data.Event.ingot_dirty, function()
		arg_8_0:updateExchange()
	end))
end

function var_0_0.onExit(arg_11_0)
	var_0_0.super.onExit(arg_11_0)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_11_1)
	end
end

function var_0_0.onCleanup(arg_12_0)
	var_0_0.super.onCleanup(arg_12_0)

	ClientView._resExchangeForms[arg_12_0._resType] = nil
end

return var_0_0
