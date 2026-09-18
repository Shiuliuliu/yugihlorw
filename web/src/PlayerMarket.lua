local var_0_0 = class("PlayerMarket")
local var_0_1 = Data.MarketBuyType

local var_0_2 = {
	__index = function()
		return 1
	end
}

--- Per-tab discount, as a multiplier: MarketScene prints _offs[tab] * 10 as a
-- "N折" badge and shows it only when that is under 10. A shop with no discount
-- event running is at full price, so every tab reads 1 until a server tells it
-- otherwise -- which is also why this is a defaulting table rather than a list:
-- the market grows tabs and none of them may be left nil.
local function newOffs()
	return setmetatable({}, var_0_2)
end

function var_0_0.ctor(arg_1_0)
	arg_1_0._products = {}
	arg_1_0._offs = newOffs()
	arg_1_0._boughtCounts = {}
	arg_1_0._buyLimits = {}
	arg_1_0._rareGoodsMap = {}
	arg_1_0._godGoodsMap = {}
	arg_1_0._exchangeMap = {}
	arg_1_0._recoveryMap = {}
	arg_1_0._cumulativeExchanges = {}
	arg_1_0._refreshingBits = 0

	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	for iter_3_0 in pairs(arg_3_0._products) do
		arg_3_0._products[iter_3_0] = {}
	end

	arg_3_0._offs = newOffs()
	arg_3_0._boughtCounts = {}
	arg_3_0._buyLimits = {}
	arg_3_0._rareGoodsMap = {}
	arg_3_0._godGoodsMap = {}
	arg_3_0._exchangeMap = {}
	arg_3_0._recoveryMap = {}
	arg_3_0._cumulativeExchanges = {}
	arg_3_0._rubbingMap = {}
	arg_3_0._refreshingBits = 0
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0:initRareGoodsMap(arg_4_1.rare_bundles)
	arg_4_0:initGodGoodsMap(arg_4_1.legend_bundles)
	arg_4_0:initExchangeMap(arg_4_1.exchange_prop_limit)
	arg_4_0:initRecoveryMap(arg_4_1.recycle_card_limit)
	arg_4_0:initRubbingMap(arg_4_1.rubbing_limit)
	arg_4_0:initCumulativeExchanges()
end

function var_0_0.initRareGoodsMap(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0._rareGoodsMap[iter_5_1] = 1
	end
end

function var_0_0.initGodGoodsMap(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0._godGoodsMap[iter_6_1] = 1
	end
end

function var_0_0.initExchangeMap(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = iter_7_1.bundle_id
		local var_7_1 = iter_7_1.limit

		arg_7_0._exchangeMap[var_7_0] = var_7_1
	end
end

function var_0_0.initRecoveryMap(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_0 = iter_8_1.bundle_id
		local var_8_1 = iter_8_1.limit

		arg_8_0._recoveryMap[var_8_0] = var_8_1
	end
end

function var_0_0.initRubbingMap(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = iter_9_1.bundle_id
		local var_9_1 = iter_9_1.limit

		arg_9_0._rubbingMap[var_9_0] = var_9_1
	end
end

function var_0_0.getRubbingBoughtCount(arg_10_0, arg_10_1)
	return arg_10_0._rubbingMap[arg_10_1] or 0
end

function var_0_0.initCumulativeExchanges(arg_11_0)
	local var_11_0 = 8
	local var_11_1 = ClientData.getValidActivityByType(Data.ActivityType.cumulative)

	if var_11_1 then
		local var_11_2 = var_11_1._bonusId

		if var_11_2[1] == 0 then
			return
		end

		local var_11_3 = false

		for iter_11_0 = 1, #var_11_2 do
			local var_11_4 = ClientData.getValidActivityByType(var_11_2[iter_11_0])

			if var_11_3 and not var_11_4 then
				-- block empty
			else
				if var_11_4 then
					var_11_3 = true
				end

				local var_11_5 = {}

				arg_11_0._cumulativeExchanges[#arg_11_0._cumulativeExchanges + 1] = var_11_5

				for iter_11_1, iter_11_2 in pairs(Data._exchangeInfo) do
					if iter_11_2._activityId == var_11_2[iter_11_0] then
						var_11_5[#var_11_5 + 1] = iter_11_1

						if not var_11_5._type then
							var_11_5._type = iter_11_2._activityId
						end
					end
				end
			end
		end

		if var_11_0 < #arg_11_0._cumulativeExchanges then
			local var_11_6 = #arg_11_0._cumulativeExchanges - var_11_0

			for iter_11_3 = 1, var_11_0 do
				arg_11_0._cumulativeExchanges[iter_11_3] = arg_11_0._cumulativeExchanges[iter_11_3 + var_11_6]
			end

			for iter_11_4 = var_11_0 + 1, #arg_11_0._cumulativeExchanges do
				arg_11_0._cumulativeExchanges[iter_11_4] = nil
			end
		end

		while var_11_0 < #arg_11_0._cumulativeExchanges do
			table.remove(arg_11_0._cumulativeExchanges, 1)
		end

		if #arg_11_0._cumulativeExchanges > 0 and var_11_0 > #arg_11_0._cumulativeExchanges then
			local var_11_7 = arg_11_0._cumulativeExchanges[1]._type - 1

			while var_11_0 > #arg_11_0._cumulativeExchanges do
				local var_11_8 = {}

				for iter_11_5, iter_11_6 in pairs(Data._exchangeInfo) do
					if iter_11_6._activityId == var_11_7 then
						var_11_8[#var_11_8 + 1] = iter_11_5

						if not var_11_8._type then
							var_11_8._type = iter_11_6._activityId
						end
					end
				end

				if #var_11_8 > 0 then
					table.insert(arg_11_0._cumulativeExchanges, 1, var_11_8)
				end

				var_11_7 = var_11_7 - 1
			end
		end
	end
end

function var_0_0.scheduler(arg_12_0, arg_12_1)
	return
end

--- Which tab a refresh reply belongs to, or nil if the message is not one.
-- Every refresh sends its own message type and the answer comes back on the
-- same one, so the type is what says which tab has stopped spinning. This is a
-- function rather than a lookup table because MarketBuyType has no entry for
-- the pvp market in this build -- indexing a constructor with nil is an error,
-- and the pvp tab is simply not there to refresh.
local function refreshedTab(arg_100_0)
	local var_100_0 = SglMsgType_pb

	if arg_100_0 == var_100_0.PB_TYPE_SHOP_REFRESH
		or arg_100_0 == var_100_0.PB_TYPE_SHOP_REFRESH_EX then
		return var_0_1.random
	elseif arg_100_0 == var_100_0.PB_TYPE_SHOP_REFRESH_LADDER
		or arg_100_0 == var_100_0.PB_TYPE_SHOP_REFRESH_LADDER_EX then
		return var_0_1.dragon_flag
	elseif arg_100_0 == var_100_0.PB_TYPE_UNION_REFRESH
		or arg_100_0 == var_100_0.PB_TYPE_UNION_REFRESH_EX then
		return var_0_1.union
	end

	return nil
end

--- A refresh that came back refused: the tab is no longer busy.
-- ClientData sends any non-OK status straight to the running scene and never
-- to the data listeners, so onMsg below never sees a refusal -- which would
-- leave the tab marked busy and its list hidden behind an indicator for the
-- rest of the session. MarketScene calls this from its own error handling and
-- redraws whichever tab this names.
function var_0_0.onRefreshFailed(arg_99_0, arg_99_1)
	local var_99_0 = refreshedTab(arg_99_1)

	if var_99_0 == nil then
		return nil
	end

	arg_99_0._refreshingBits = bit.band(arg_99_0._refreshingBits or 0,
		bit.bnot(bit.lshift(1, var_99_0)))

	return var_99_0
end

function var_0_0.onMsg(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.type
	local var_13_1 = arg_13_1.status
	local var_13_2 = refreshedTab(var_13_0)

	if var_13_2 == nil then
		return false
	end

	-- The tab is busy from the moment the button is pressed until the answer
	-- lands, and MarketScene hides the list and shows an indicator while it
	-- is. Clearing the bit here is what puts the list back -- on a refusal as
	-- much as on a success, or a refused refresh would spin for ever.
	arg_13_0._refreshingBits = bit.band(arg_13_0._refreshingBits or 0,
		bit.bnot(bit.lshift(1, var_13_2)))

	-- A refresh puts the rows the player has already bought back on the shelf.
	-- The server states the new counts; where it sends none, nothing on the
	-- shelf changed and neither does anything here.
	local var_13_3 = arg_13_1.Extensions[Shop_pb.SglShopMsg.shop_refresh_resp]

	if var_13_3 then
		for iter_13_0, iter_13_1 in ipairs(var_13_3.bundles or {}) do
			arg_13_0._boughtCounts[iter_13_1.id] = iter_13_1.count or 0
		end
	end

	lc.sendEvent(Data.Event.market_list_dirty, {
		_type = var_13_2
	})

	return true
end

function var_0_0.getExchangeMaxCount(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}
	local var_14_1 = P._playerMarket._exchangeMap[arg_14_1._id] or 0
	local var_14_2 = arg_14_1._time - var_14_1

	if arg_14_1._time == 0 then
		var_14_2 = 4294967295
	end

	local var_14_3 = arg_14_1._item

	for iter_14_0, iter_14_1 in ipairs(var_14_3) do
		var_14_2 = math.min(var_14_2, math.floor(P:getItemCount(iter_14_1, arg_14_2) / arg_14_1._number[iter_14_0]))
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_3) do
		local var_14_4 = arg_14_1._number[iter_14_2]

		var_14_0[iter_14_3] = (var_14_0[iter_14_3] or 0) + var_14_4 * var_14_2
	end

	return var_14_2, var_14_0
end

function var_0_0.isExchangeEnough(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_2 = arg_15_2 or 1

	local var_15_0, var_15_1 = arg_15_0:getExchangeMaxCount(arg_15_1, arg_15_3)

	return arg_15_2 <= var_15_0, var_15_1
end

function var_0_0.checkExchangeProp(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_2 = arg_16_2 or 1

	local var_16_0 = arg_16_0._exchangeMap[arg_16_1._id] or 0
	local var_16_1 = arg_16_1._time - var_16_0

	if arg_16_1._time == 0 then
		var_16_1 = 16777215
	end

	if var_16_1 < arg_16_2 then
		return Data.ErrorType.need_more_count
	end

	local var_16_2, var_16_3 = arg_16_0:isExchangeEnough(arg_16_1, arg_16_2, arg_16_3)

	if not var_16_2 then
		return Data.ErrorType.need_more_ingot
	end

	return Data.ErrorType.ok, var_16_3
end

function var_0_0.exchangeProp(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_2 = arg_17_2 or 1

	local var_17_0 = arg_17_0:checkExchangeProp(arg_17_1, arg_17_2, arg_17_3)

	if var_17_0 ~= Data.ErrorType.ok then
		return var_17_0
	end

	local var_17_1 = {}

	for iter_17_0 = 1, arg_17_2 do
		if not arg_17_4 then
			ClientData.sendActivityExchange(arg_17_1._id)
		end

		arg_17_0._exchangeMap[arg_17_1._id] = (arg_17_0._exchangeMap[arg_17_1._id] or 0) + 1

		local var_17_2 = arg_17_1._item
		local var_17_3 = arg_17_1._reward
		local var_17_4 = Data._bonusInfo[var_17_3]
		local var_17_5 = var_17_4._rid[1]
		local var_17_6 = {}

		for iter_17_1, iter_17_2 in ipairs(var_17_4._count) do
			local var_17_7 = iter_17_2 * (var_17_4._multiple or 1)

			table.insert(var_17_6, var_17_7)

			var_17_1[var_17_4._rid[iter_17_1]] = (var_17_1[var_17_4._rid[iter_17_1]] or 0) + var_17_7
		end

		P:addResources(var_17_4._rid, var_17_4._level, var_17_6, var_17_4._isFragment)

		for iter_17_3, iter_17_4 in ipairs(var_17_2) do
			P:addResource(iter_17_4, 1, -arg_17_1._number[iter_17_3], false, nil, arg_17_3)
		end
	end

	return var_17_0, var_17_1
end

-- ---------------------------------------------------------------------------
-- Reconstructed shop half
--
-- MarketScene, SelectCountForm and MenuPanel call ten methods that are in no
-- recovered artefact: not in this source tree, not in the 1089 decompile, and
-- not in the 1089 LuaJIT bytecode, whose constant table lists every method the
-- shipped class had. class() in base/extern.lua has no __index fallback, so an
-- Android build made from these same sources dies at MarketScene:242 exactly
-- as the web one did.
--
-- What each has to do is fixed by its callers, and every number below is the
-- game's own: a tab's stock is the matching products table, a price is that
-- row's _cost in that row's _resType, and a purchase hands over _uid times
-- _count. The one judgement is which table belongs to which tab, and that is
-- pinned by the callers too - the union tab is the only one whose widget reads
-- _info._level, which only union_products.bin has.
-- ---------------------------------------------------------------------------

--- Which products table stands behind each tab of the market.
local MARKET_TABLES = {
	-- goods.bin, not products.bin: a daily trade is bought with
	-- ClientData.sendBuyGoods, which sends PB_TYPE_BUY_DAILY carrying a
	-- goods id, while products.bin rows are bought with sendProductBuy.
	[Data.MarketBuyType.daily] = "_goodsInfo",
	[Data.MarketBuyType.vip] = "_productsExInfo",
	[Data.MarketBuyType.random] = "_productsInfo",
	[Data.MarketBuyType.union] = "_unionProductsInfo",
	[Data.MarketBuyType.dragon_flag] = "_ladderProductsInfo"
}

--- How many daily trades a player gets.
--
-- This one number is not in any of the game's tables: it is the server's
-- allowance, and the server is where it is enforced (BuyHandlers, PB_TYPE_
-- BUY_DAILY). It is mirrored here because SelectCountForm prints "trades left
-- today, N of M" before it asks the server for anything, and the two have to
-- agree. Change it in both places or not at all.
var_0_0.DAILY_TRADE_LIMIT = 20

--- Turn one row of a products table into the object ProductWidget draws.
local function toProduct(arg_50_0, arg_50_1, arg_50_2)
	-- What a row sells is a bundle, not an item: _uid names a row of
	-- bonus.bin, whose _rid list is what the player actually receives. The
	-- widget draws one icon, so it draws the first of them. A row with no
	-- bundle falls back to naming its item outright, which is what the union
	-- table does.
	local var_50_0 = arg_50_1._uid and Data._bonusInfo and Data._bonusInfo[arg_50_1._uid]
	local var_50_1 = var_50_0 and var_50_0._rid and var_50_0._rid[1]
		or arg_50_1._infoId or arg_50_1._cardId

	if var_50_1 == nil or var_50_1 == 0 then
		return nil
	end

	-- A row whose item this build has no entry for is a discontinued line:
	-- goods.bin still lists 7015 to 7018, which props.bin does not have, and
	-- an unknown id draws as a blank card with a blank name. Leave it off the
	-- shelf rather than on it looking broken.
	if Data.getInfo(var_50_1) == nil then
		return nil
	end

	local var_50_2 = arg_50_0._boughtCounts[arg_50_1._id] or 0

	return {
		_id = arg_50_1._id,
		_type = arg_50_2,
		_info = arg_50_1,
		_infoId = var_50_1,
		_bonus = var_50_0,
		_cost = arg_50_1._cost or 0,
		_resType = arg_50_1._resType or Data.ResType.gold,
		_count = var_50_0 and var_50_0._count and var_50_0._count[1]
			or arg_50_1._count or arg_50_1._num or 1,
		_isFixed = (arg_50_1._isFixed or 0) ~= 0,
		_isAct = false,
		_isAvailable = true,
		_isInfo = false,
		_buyCount = var_50_2,
		_buyCountMax = arg_50_1._count and arg_50_1._count > 0 and arg_50_1._count or nil
	}
end

--- The stock of one tab.
-- The server's rolled stock wins where there is one -- that is what the random
-- tab is -- and the table stands in for the tabs whose stock is fixed.
function var_0_0.getProducts(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0._products[arg_51_1]

	if var_51_0 and #var_51_0 > 0 then
		return var_51_0
	end

	local var_51_1 = MARKET_TABLES[arg_51_1]
	local var_51_2 = var_51_1 and Data[var_51_1]
	local var_51_3 = {}

	if var_51_2 == nil then
		return var_51_3
	end

	local var_51_5, var_51_6, var_51_7 = ClientData.getServerDate()
	local var_51_8 = var_51_5 * 10000 + var_51_6 * 100 + var_51_7

	for iter_51_0, iter_51_1 in pairs(var_51_2) do
		-- a dated offer is on the shelf only until its day has gone
		local var_51_9 = tonumber(iter_51_1._date)

		if var_51_9 == nil or math.floor(var_51_9) >= var_51_8 then
			local var_51_4 = toProduct(arg_51_0, iter_51_1, arg_51_1)

			if var_51_4 then
				var_51_3[#var_51_3 + 1] = var_51_4
			end
		end
	end

	table.sort(var_51_3, function(arg_52_0, arg_52_1)
		return arg_52_0._id < arg_52_1._id
	end)

	return var_51_3
end

--- How many of this product the player may still buy, or nil when unlimited.
-- Two questions through one name, as the callers ask them: with no second
-- argument, how many are left; with one, how many there were to begin with.
function var_0_0.getBuyGoodsNumber(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_0._buyLimits[arg_53_1] or var_0_0.DAILY_TRADE_LIMIT

	if arg_53_2 then
		return var_53_0
	end

	return math.max(0, var_53_0 - (arg_53_0._boughtCounts[arg_53_1] or 0))
end

--- Buy one product: check the price, pay it, take the goods, count the sale.
function var_0_0.buyProduct(arg_54_0, arg_54_1)
	return arg_54_0:buyGoods(arg_54_1, 1)
end

--- The same, a chosen number of times.
function var_0_0.buyGoods(arg_55_0, arg_55_1, arg_55_2)
	arg_55_2 = arg_55_2 or 1

	if arg_55_1 == nil or arg_55_2 < 1 then
		return Data.ErrorType.error
	end

	if arg_55_1._buyCountMax and arg_55_1._buyCountMax < (arg_55_1._buyCount or 0) + arg_55_2 then
		return Data.ErrorType.need_more_count
	end

	local var_55_0 = (arg_55_1._cost or 0) * arg_55_2
	local var_55_1 = arg_55_1._resType

	if var_55_0 > 0 and P:getItemCount(var_55_1) < var_55_0 then
		return Data.ErrorType.need_more_ingot
	end

	if var_55_0 > 0 then
		if var_55_1 == Data.ResType.gold or var_55_1 == Data.ResType.grain
			or var_55_1 == Data.ResType.ingot then
			P:changeResource(var_55_1, -var_55_0)
		else
			P._propBag:changeProps(var_55_1, -var_55_0)
		end
	end

	-- addResource(infoId, level, count, isFragment, silent)
	P:addResource(arg_55_1._infoId, 0, (arg_55_1._count or 1) * arg_55_2, false, true)

	arg_55_1._buyCount = (arg_55_1._buyCount or 0) + arg_55_2
	arg_55_0._boughtCounts[arg_55_1._id] = arg_55_1._buyCount

	return Data.ErrorType.ok
end

--- Whether a refresh of this tab is still in flight.
function var_0_0.isRefreshing(arg_56_0, arg_56_1)
	return bit.band(arg_56_0._refreshingBits or 0, bit.lshift(1, arg_56_1 or 0)) ~= 0
end

--- Ask the server to re-roll a tab, and mark it busy until the answer lands.
function var_0_0.sendRefresh(arg_57_0, arg_57_1, arg_57_2)
	arg_57_0._refreshingBits = bit.bor(arg_57_0._refreshingBits or 0,
		bit.lshift(1, arg_57_1 or 0))

	ClientData.sendProductsRefresh(arg_57_1, arg_57_2)
end

--- The fragment market is a visiting trader, opened by a running event.
-- With no event the honest answer is that it is shut, which is the state the
-- screen already draws: FRAG_MARKET_CLOSE_TIP instead of a countdown.
function var_0_0.isFragMarketClosed(arg_58_0)
	return arg_58_0:getFragMarketRemainTime() <= 0
end

function var_0_0.getFragMarketRemainTime(arg_59_0)
	local var_59_0 = arg_59_0._fragMarketEnd or 0

	return var_59_0 - ClientData.getCurrentTime()
end

--- Whether the VIP tab has anything on it today.
-- products_ex.bin dates every offer, so a row counts only while its day has
-- not passed; MarketScene hides the whole tab when none has.
function var_0_0.hasVipGoods(arg_60_0)
	local var_60_0 = Data._productsExInfo

	if var_60_0 == nil then
		return false
	end

	local var_60_1, var_60_2, var_60_3 = ClientData.getServerDate()
	local var_60_4 = var_60_1 * 10000 + var_60_2 * 100 + var_60_3

	for iter_60_0, iter_60_1 in pairs(var_60_0) do
		local var_60_5 = tonumber(iter_60_1._date)

		if var_60_5 and math.floor(var_60_5) >= var_60_4 then
			return true
		end
	end

	return false
end

--- Whether the limited gift offer has run out, same reasoning as the market.
function var_0_0.isGiftsClosed(arg_61_0)
	return (arg_61_0._giftEnd or 0) <= ClientData.getCurrentTime()
end

return var_0_0
