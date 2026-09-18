local var_0_0 = class("PlayerCard")
local var_0_1 = require("Skin")
local var_0_2 = require("json")

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._monsters = {}
	arg_3_0._magics = {}
	arg_3_0._traps = {}
	arg_3_0._rares = {}
	arg_3_0._cards = {
		[Data.CardType.monster] = arg_3_0._monsters,
		[Data.CardType.magic] = arg_3_0._magics,
		[Data.CardType.trap] = arg_3_0._traps,
		[Data.CardType.rare] = arg_3_0._rares
	}
	arg_3_0._levels = {}
	arg_3_0._unlocked = {}
	arg_3_0._collected = {}
	arg_3_0._skins = {}
	arg_3_0._troops = setmetatable({}, { __index = function(t, k) rawset(t, k, {}); return t[k] end })
	arg_3_0._guardSlots = {}
	arg_3_0._groupMonsters = {}
	arg_3_0._groupMagics = {}
	arg_3_0._groupTraps = {}
	arg_3_0._groupRares = {}
	arg_3_0._groupCards = {
		[Data.CardType.monster] = arg_3_0._groupMonsters,
		[Data.CardType.magic] = arg_3_0._groupMagics,
		[Data.CardType.trap] = arg_3_0._groupTraps,
		[Data.CardType.rare] = arg_3_0._groupRares
	}
	arg_3_0._cardFragment = {}
	arg_3_0._recommendTroops = {}
	arg_3_0._systemRecommendTroops = {}
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0._extraTroopCount = arg_4_1.extra_troop_count

	for iter_4_0 = 1, #arg_4_1.levels do
		local var_4_0 = arg_4_1.levels[iter_4_0]
		local var_4_1 = var_4_0.info_id

		arg_4_0._levels[var_4_1] = var_4_0.level

		local var_4_2 = Data.getType(var_4_1)

		if not arg_4_0._cards[var_4_2] then
			var_4_2 = Data.getType(var_4_1)
		end

		arg_4_0._cards[var_4_2][var_4_1] = 0
	end

	for iter_4_1 = 1, #arg_4_1.cards do
		local var_4_3 = arg_4_1.cards[iter_4_1].info_id
		local var_4_4 = Data.getType(var_4_3)

		if not arg_4_0._cards[var_4_4] then
			local var_4_5

			Data.getType(var_4_3)
		end

		arg_4_0._cards[var_4_4][var_4_3] = arg_4_1.cards[iter_4_1].num
		arg_4_0._levels[var_4_3] = 1
	end

	for iter_4_2 = 1, #arg_4_1.unlocked do
		if arg_4_0:getCardCount(arg_4_1.unlocked[iter_4_2]) > 0 then
			arg_4_0._unlocked[arg_4_1.unlocked[iter_4_2]] = true
		end
	end

	for iter_4_3 = 1, #arg_4_1.collected do
		arg_4_0._collected[arg_4_1.collected[iter_4_3]] = true
	end

	for iter_4_4 = 1, #arg_4_1.skin do
		local var_4_6 = arg_4_1.skin[iter_4_4]
		local var_4_7 = var_0_1.createWithPb(var_4_6)

		arg_4_0._skins[var_4_6.info_id] = var_4_7
	end

	for iter_4_5 = 1, #arg_4_1.dark_troops do
		print("@@@@@@@@ DARK TROOP", iter_4_5)

		local var_4_8 = arg_4_1.dark_troops[iter_4_5]
		local var_4_9 = {}

		for iter_4_6 = 1, #var_4_8.troop_item do
			var_4_9[iter_4_6] = Data.pb2Resource(var_4_8.troop_item[iter_4_6])

			print("         ", iter_4_6, var_4_9[iter_4_6]._infoId, "x", var_4_9[iter_4_6]._num)
		end

		local var_4_10 = Data.TroopIndex.dark_battle1 + iter_4_5 - 1

		arg_4_0._troops[var_4_10] = var_4_9
	end

	for iter_4_7 = 1, #arg_4_1.room_dark_troops do
		print("@@@@@@@@ ROOM DARK TROOP", iter_4_7)

		local var_4_11 = arg_4_1.room_dark_troops[iter_4_7]
		local var_4_12 = {}

		for iter_4_8 = 1, #var_4_11.troop_item do
			var_4_12[iter_4_8] = Data.pb2Resource(var_4_11.troop_item[iter_4_8])

			print("         ", iter_4_8, var_4_12[iter_4_8]._infoId, "x", var_4_12[iter_4_8]._num)
		end

		local var_4_13 = Data.TroopIndex.room_dark_battle1 + iter_4_7 - 1

		arg_4_0._troops[var_4_13] = var_4_12
	end

	for iter_4_9 = 1, #arg_4_1.troops do
		print("@@@@@@@@ TROOP", iter_4_9)

		local var_4_14 = arg_4_1.troops[iter_4_9]
		local var_4_15 = {}

		for iter_4_10 = 1, #var_4_14.troop_item do
			var_4_15[iter_4_10] = Data.pb2Resource(var_4_14.troop_item[iter_4_10])

			print("         ", iter_4_10, var_4_15[iter_4_10]._infoId, "x", var_4_15[iter_4_10]._num)
		end

		arg_4_0._troops[iter_4_9] = var_4_15
	end

	for iter_4_11 = #arg_4_1.troops + 1, P:getMaxTroopCount() do
		arg_4_0._troops[iter_4_11] = {}
	end

	for iter_4_12, iter_4_13 in ipairs(arg_4_1.fragments) do
		local var_4_16 = iter_4_13.info_id

		arg_4_0._cardFragment[var_4_16] = iter_4_13.num
	end

	for iter_4_14 = 1, 8 do
		arg_4_0._guardSlots[#arg_4_0._guardSlots + 1] = {
			_level = 1,
			_id = iter_4_14
		}
	end

	for iter_4_15 = 1, #arg_4_1.slots do
		local var_4_17 = arg_4_1.slots[iter_4_15]
		local var_4_18 = arg_4_0._guardSlots[var_4_17.id]

		var_4_18._level = var_4_17.level

		if var_4_17:HasField("guard") then
			local var_4_19 = var_4_17.guard

			var_4_18._guard = {
				_infoId = var_4_19.info_id,
				_timestamp = var_4_19.timestamp / 1000,
				_span = var_4_19.span / 1000
			}
		end
	end

	for iter_4_16 = 1, 8 do
		local var_4_20 = arg_4_0._guardSlots[iter_4_16]

		print("@@@@@@@@ GUARD", var_4_20._id, var_4_20._level, var_4_20._guard and var_4_20._guard._infoId)
	end

	arg_4_0:initSystemRecommendTroops()
end

function var_0_0.initGroupCards(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_1.cards do
		local var_5_0 = arg_5_1.cards[iter_5_0].info_id

		if Data.getExtraSid(var_5_0) > 0 then
			local var_5_1
		end

		local var_5_2 = Data.getType(var_5_0)

		arg_5_0._groupCards[var_5_2][var_5_0] = arg_5_1.cards[iter_5_0].num
	end

	for iter_5_1 = 1, #arg_5_1.troop do
		print("@@@@@@@@ GROUP TROOP", iter_5_1)

		local var_5_3 = arg_5_1.troop[iter_5_1]
		local var_5_4 = {}

		for iter_5_2 = 1, #var_5_3.troop_item do
			if var_5_3.troop_item[iter_5_2].num > 0 then
				var_5_4[#var_5_4 + 1] = Data.pb2Resource(var_5_3.troop_item[iter_5_2])

				print("         ", iter_5_2, var_5_4[#var_5_4]._infoId, "x", var_5_4[#var_5_4]._num)
			end
		end

		arg_5_0._troops[iter_5_1 + Data.TroopIndex.union_battle1 - 1] = var_5_4
	end

	lc.sendEvent(Data.Event.group_cards_dirty)
end

function var_0_0.initRecommendTroops(arg_6_0, arg_6_1)
	arg_6_0._recommendTroops = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = ClientData.genInputFromReplayResp(iter_6_1)

		table.insert(arg_6_0._recommendTroops, var_6_0)
	end

	lc.sendEvent(Data.Event.recommend_troop_dirty)
end

function var_0_0.onMsg(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.type
	local var_7_1 = arg_7_1.status

	if var_7_0 == SglMsgType_pb.PB_TYPE_CITY_GUARD or var_7_0 == SglMsgType_pb.PB_TYPE_CITY_PICK then
		local var_7_2

		if var_7_0 == SglMsgType_pb.PB_TYPE_CITY_GUARD then
			var_7_2 = arg_7_1.Extensions[City_pb.SglCityMsg.city_guard_resp]
		else
			var_7_2 = arg_7_1.Extensions[City_pb.SglCityMsg.city_pick_resp]
		end

		local var_7_3 = var_7_2:HasField("guard") and var_7_2.guard or nil
		local var_7_4 = arg_7_0._guardSlots[var_7_2.id]
		local var_7_5 = var_7_4 and var_7_4._guard

		if var_7_3 ~= nil and var_7_5 ~= nil and var_7_3.info_id == var_7_5._infoId and var_7_5._span == nil then
			var_7_5._timestamp = var_7_3.timestamp / 1000
			var_7_5._span = var_7_3.span / 1000

			lc.sendEvent(Data.Event.guard_confirm, var_7_5)
		end

		return true
	elseif var_7_0 == SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_LOAD_CARDS then
		local var_7_6 = arg_7_1.Extensions[UnionWar_pb.SglUnionWarMsg.masswar_load_cards_resp]

		arg_7_0:initGroupCards(var_7_6)
		ClientView.getActiveIndicator():hide()

		return true
	elseif var_7_0 == SglMsgType_pb.PB_TYPE_WORLD_RECOMMEND_TROOP then
		local var_7_7 = arg_7_1.Extensions[World_pb.SglWorldMsg.recommend_troop_resp]

		arg_7_0:initRecommendTroops(var_7_7)

		return true
	end

	return false
end

function var_0_0.upgradeCard(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._levels[arg_8_1] >= Data.CARD_MAX_LEVEL then
		return Data.ErrorType.card_not_support
	end

	local var_8_0 = arg_8_0:getUpgradeGold(arg_8_1)

	if not P:hasResource(Data.ResType.gold, var_8_0) then
		return Data.ErrorType.need_more_gold
	end

	local var_8_1 = Data.getType(arg_8_1)
	local var_8_2 = arg_8_0:getUpgradeCount(arg_8_1)

	if var_8_2 > arg_8_0._cards[var_8_1][arg_8_1] then
		return Data.ErrorType.need_more_samecard
	end

	local var_8_3, var_8_4 = arg_8_0:getUpgradeStone(arg_8_1)

	if not P._propBag:hasProps(var_8_3, var_8_4) then
		if var_8_3 == Data.PropsId.stone_rare then
			return Data.ErrorType.need_more_stonerare
		else
			return Data.ErrorType.need_more_stonelegend
		end
	end

	if not arg_8_2 then
		arg_8_0._levels[arg_8_1] = arg_8_0._levels[arg_8_1] + 1

		arg_8_0:removeCard(arg_8_1, var_8_2)
		P:changeResource(Data.ResType.gold, -var_8_0)
		P._propBag:changeProps(var_8_3, -var_8_4)
	end

	return Data.ErrorType.ok
end

function var_0_0.composeCard(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0._levels[arg_9_1] == nil or arg_9_0._levels[arg_9_1] == 0 then
		return Data.ErrorType.card_cannot_compose
	end

	local var_9_0 = arg_9_0:getComposeGold(arg_9_1) * arg_9_2

	if not P:hasResource(Data.ResType.gold, var_9_0) then
		return Data.ErrorType.need_more_gold
	end

	local var_9_1, var_9_2 = arg_9_0:getComposeDust(arg_9_1)
	local var_9_3 = var_9_2 * arg_9_2

	if not P._propBag:hasProps(var_9_1, var_9_3) then
		return Data.ErrorType.need_more_dust
	end

	if not arg_9_3 then
		arg_9_0:addCard(arg_9_1, arg_9_2)
		P:changeResource(Data.ResType.gold, -var_9_0)
		P._propBag:changeProps(var_9_1, -var_9_3)
	end

	return Data.ErrorType.ok
end

function var_0_0.composeCardByFragment(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = arg_10_0:convert2FragmentId(arg_10_1)
	local var_10_1 = arg_10_0:convert2CardId(arg_10_1)
	local var_10_2 = arg_10_0:getFragmentCount(arg_10_1)
	local var_10_3 = P:getItemCount(Data.PropsId.common_fragment)
	local var_10_4 = arg_10_2 and P:getItemCount(Data.PropsId.special_common_fragment) or 0
	local var_10_5 = 0
	local var_10_6 = 0
	local var_10_7 = Data.ErrorType.ok

	if var_10_2 + var_10_4 + var_10_3 < P._playerCard:getCardFragmentNeedCount(arg_10_1) then
		var_10_7 = Data.ErrorType.fragment_not_enough
	elseif var_10_2 < P._playerCard:getCardFragmentNeedCount(arg_10_1) then
		var_10_7 = Data.ErrorType.compose_common_fragment

		local var_10_8 = math.max(0, P._playerCard:getCardFragmentNeedCount(arg_10_1) - var_10_2)

		var_10_5 = math.min(var_10_8, var_10_4)
		var_10_6 = var_10_8 - var_10_5
	end

	if not arg_10_3 and var_10_2 + var_10_4 + var_10_3 >= P._playerCard:getCardFragmentNeedCount(arg_10_1) then
		ClientData.sendComposeCard(var_10_1, arg_10_4)
		arg_10_0:addCard(var_10_1, 1)
		P:addResource(Data.PropsId.special_common_fragment, 1, -var_10_5)
		P:addResource(Data.PropsId.common_fragment, 1, -var_10_6)
		arg_10_0:addCard(var_10_0, -P._playerCard:getCardFragmentNeedCount(arg_10_1))
	end

	return var_10_7, var_10_5, var_10_6
end

function var_0_0.decomposeCard(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:getDecomposeGold(arg_11_1) * arg_11_2

	if not P:hasResource(Data.ResType.gold, var_11_0) then
		return Data.ErrorType.need_more_gold
	end

	local var_11_1 = Data.getType(arg_11_1)

	if arg_11_2 > arg_11_0._cards[var_11_1][arg_11_1] then
		return Data.ErrorType.need_more_samecard
	end

	local var_11_2, var_11_3 = arg_11_0:getDecomposeDust(arg_11_1)
	local var_11_4 = var_11_3 * arg_11_2

	if not arg_11_3 then
		arg_11_0:removeCard(arg_11_1, arg_11_2)
		P:changeResource(Data.ResType.gold, -var_11_0)
		P:changeResource(var_11_2, var_11_4)
	end

	return Data.ErrorType.ok, var_11_4
end

function var_0_0.getCanDecomposeCount(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = 0
	local var_12_2 = 0

	for iter_12_0 = Data.CardType.monster, Data.CardType.rare do
		local var_12_3 = arg_12_0._cards[iter_12_0]

		for iter_12_1, iter_12_2 in pairs(var_12_3) do
			if iter_12_2 > 3 then
				iter_12_2 = iter_12_2 - 3

				local var_12_4 = Data.getInfo(iter_12_1)

				if var_12_4._quality == Data.CardQuality.N then
					var_12_1 = var_12_1 + iter_12_2
				elseif var_12_4._quality == Data.CardQuality.R then
					var_12_0 = var_12_0 + iter_12_2
				end
			end
		end
	end

	return var_12_0, var_12_1
end

function var_0_0.decomposeAll(arg_13_0)
	local var_13_0 = 0

	for iter_13_0 = Data.CardType.monster, Data.CardType.rare do
		local var_13_1 = arg_13_0._cards[iter_13_0]

		for iter_13_1, iter_13_2 in pairs(var_13_1) do
			local var_13_2 = Data.getInfo(iter_13_1)

			if iter_13_2 > 3 and var_13_2._quality < Data.CardQuality.SR then
				iter_13_2 = iter_13_2 - 3

				local var_13_3, var_13_4 = arg_13_0:decomposeCard(iter_13_1, iter_13_2)

				var_13_0 = var_13_0 + var_13_4
			end
		end
	end

	return var_13_0
end

function var_0_0.recoveryCard(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = Data.getType(arg_14_1)

	if arg_14_2 > arg_14_0._cards[var_14_0][arg_14_1] then
		return Data.ErrorType.need_more_samecard
	end

	local var_14_1, var_14_2 = arg_14_0:getRecoveryDust(arg_14_4)
	local var_14_3 = var_14_2 * arg_14_2

	if not arg_14_3 then
		arg_14_0:removeCard(arg_14_1, arg_14_2)
		P:addResource(var_14_1, nil, var_14_3)
	end

	return Data.ErrorType.ok, var_14_3
end

function var_0_0.recallCard(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = Data.getType(arg_15_1)

	if arg_15_2 > arg_15_0._cards[var_15_0][arg_15_1] then
		return Data.ErrorType.need_more_samecard
	end

	local var_15_1 = arg_15_0:getRecallDust(arg_15_4, arg_15_2)

	if not arg_15_3 then
		arg_15_0:removeCard(arg_15_1, arg_15_2)

		for iter_15_0, iter_15_1 in pairs(var_15_1) do
			P:addResource(iter_15_0, nil, iter_15_1)
		end

		P._playerMarket._recoveryMap[arg_15_4] = (P._playerMarket._recoveryMap[arg_15_4] or 0) + arg_15_2
	end

	return Data.ErrorType.ok, var_15_1
end

function var_0_0.smeltCard(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = Data.getType(arg_16_1)

	if arg_16_2 > arg_16_0._cards[var_16_0][arg_16_1] then
		return Data.ErrorType.need_more_samecard
	end

	local var_16_1, var_16_2 = arg_16_0:getSmeltDust(arg_16_1)
	local var_16_3 = var_16_2 * arg_16_2

	if not arg_16_3 then
		arg_16_0:removeCard(arg_16_1, arg_16_2)
		P:addResource(var_16_1, nil, var_16_3)
	end

	return Data.ErrorType.ok, var_16_3
end

function var_0_0.getUpgradeCount(arg_17_0, arg_17_1)
	local var_17_0, var_17_1 = Data.getInfo(arg_17_1)
	local var_17_2 = arg_17_0._levels[arg_17_1]

	if var_17_2 == Data.CARD_MAX_LEVEL then
		return 0
	end

	local var_17_3 = (var_17_0._quality - 1) * Data.CARD_MAX_LEVEL + var_17_2

	if var_17_1 == Data.CardType.monster then
		return Data._globalInfo._monsterUpgradeCount[var_17_3]
	elseif var_17_1 == Data.CardType.magic then
		return Data._globalInfo._magicUpgradeCount[var_17_3]
	elseif var_17_1 == Data.CardType.trap then
		return Data._globalInfo._trapUpgradeCount[var_17_3]
	elseif var_17_1 == Data.CardType.rare then
		return Data._globalInfo._rareUpgradeCount[var_17_3]
	end
end

function var_0_0.getUpgradeGold(arg_18_0, arg_18_1)
	local var_18_0, var_18_1 = Data.getInfo(arg_18_1)
	local var_18_2 = arg_18_0._levels[arg_18_1]
	local var_18_3 = (var_18_0._quality - 1) * Data.CARD_MAX_LEVEL + var_18_2

	if var_18_1 == Data.CardType.monster then
		return Data._globalInfo._monsterUpgradeGold[var_18_3]
	elseif var_18_1 == Data.CardType.magic then
		return Data._globalInfo._magicUpgradeGold[var_18_3]
	elseif var_18_1 == Data.CardType.trap then
		return Data._globalInfo._trapUpgradeGold[var_18_3]
	elseif var_18_1 == Data.CardType.rare then
		return Data._globalInfo._rareUpgradeGold[var_18_3]
	end
end

function var_0_0.getUpgradeStone(arg_19_0, arg_19_1)
	local var_19_0, var_19_1 = Data.getInfo(arg_19_1)
	local var_19_2 = arg_19_0._levels[arg_19_1]
	local var_19_3 = (var_19_0._quality - 1) * Data.CARD_MAX_LEVEL + var_19_2

	if var_19_1 == Data.CardType.monster then
		return Data.PropsId.monster_stone_n + var_19_0._quality - 1, Data._globalInfo._monsterUpgradeStone[var_19_3]
	elseif var_19_1 == Data.CardType.magic then
		return Data.PropsId.magic_stone_n + var_19_2 - 1, Data._globalInfo._magicUpgradeStone[var_19_3]
	elseif var_19_1 == Data.CardType.trap then
		return Data.PropsId.trap_stone_n + var_19_2 - 1, Data._globalInfo._trapUpgradeStone[var_19_3]
	elseif var_19_1 == Data.CardType.rare then
		return Data.PropsId.rare_stone_n + var_19_2 - 1, Data._globalInfo._rareUpgradeStone[var_19_3]
	end
end

function var_0_0.getComposeDust(arg_20_0, arg_20_1)
	local var_20_0, var_20_1 = Data.getInfo(arg_20_1)
	local var_20_2 = 1
	local var_20_3 = (var_20_0._quality - 1) * Data.CARD_MAX_LEVEL + var_20_2

	if var_20_1 == Data.CardType.monster then
		return Data.PropsId.dust_monster, Data._globalInfo._monsterComposeDust[var_20_3]
	elseif var_20_1 == Data.CardType.magic then
		return Data.PropsId.dust_magic, Data._globalInfo._magicComposeDust[var_20_3]
	elseif var_20_1 == Data.CardType.trap then
		return Data.PropsId.dust_trap, Data._globalInfo._trapComposeDust[var_20_3]
	elseif var_20_1 == Data.CardType.rare then
		return Data.PropsId.dust_rare, Data._globalInfo._rareComposeDust[var_20_3]
	end
end

function var_0_0.getComposeGold(arg_21_0, arg_21_1)
	local var_21_0, var_21_1 = Data.getInfo(arg_21_1)
	local var_21_2 = 1
	local var_21_3 = (var_21_0._quality - 1) * Data.CARD_MAX_LEVEL + var_21_2

	if var_21_1 == Data.CardType.monster then
		return Data._globalInfo._monsterComposeGold[var_21_3]
	elseif var_21_1 == Data.CardType.magic then
		return Data._globalInfo._magicComposeGold[var_21_3]
	elseif var_21_1 == Data.CardType.trap then
		return Data._globalInfo._trapComposeGold[var_21_3]
	elseif var_21_1 == Data.CardType.rare then
		return Data._globalInfo._rareComposeGold[var_21_3]
	end
end

function var_0_0.getDecomposeDust(arg_22_0, arg_22_1)
	local var_22_0, var_22_1 = Data.getInfo(arg_22_1)
	local var_22_2 = 1
	local var_22_3 = (var_22_0._quality - 1) * Data.CARD_MAX_LEVEL + var_22_2

	if var_22_1 == Data.CardType.monster then
		return Data.ResType.gold, Data._globalInfo._monsterDecomposeDust[var_22_3]
	elseif var_22_1 == Data.CardType.magic then
		return Data.ResType.gold, Data._globalInfo._magicDecomposeDust[var_22_3]
	elseif var_22_1 == Data.CardType.trap then
		return Data.ResType.gold, Data._globalInfo._trapDecomposeDust[var_22_3]
	elseif var_22_1 == Data.CardType.rare then
		return Data.ResType.gold, Data._globalInfo._trapDecomposeDust[var_22_3]
	end
end

function var_0_0.getRecoveryDust(arg_23_0, arg_23_1)
	local var_23_0 = Data._unionProductsExInfo[arg_23_1]._cost
	local var_23_1 = Data._globalInfo._receveryPercent / 100

	return Data.PropsId.yubi, var_23_0 * var_23_1
end

function var_0_0.getRecallDust(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = Data._recallInfo[arg_24_1]
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0._recoverProps) do
		var_24_1[iter_24_1] = (var_24_1[iter_24_1] or 0) + var_24_0._recoverNum[iter_24_0] * arg_24_2
	end

	return var_24_1
end

function var_0_0.getSmeltDust(arg_25_0)
	return Data.PropsId.effect_skin_crystal, Data._globalInfo._cardSmeltDustCount
end

function var_0_0.getDecomposeGold(arg_26_0, arg_26_1)
	local var_26_0, var_26_1 = Data.getInfo(arg_26_1)
	local var_26_2 = 1
	local var_26_3 = (var_26_0._quality - 1) * Data.CARD_MAX_LEVEL + var_26_2

	if var_26_1 == Data.CardType.monster then
		return Data._globalInfo._monsterDecomposeGold[var_26_3]
	elseif var_26_1 == Data.CardType.magic then
		return Data._globalInfo._magicDecomposeGold[var_26_3]
	elseif var_26_1 == Data.CardType.trap then
		return Data._globalInfo._trapDecomposeGold[var_26_3]
	elseif var_26_1 == Data.CardType.rare then
		return Data._globalInfo._rareDecomposeGold[var_26_3]
	end
end

function var_0_0.getCards(arg_27_0, arg_27_1)
	return arg_27_0._cards[arg_27_1]
end

function var_0_0.getGroupCards(arg_28_0, arg_28_1)
	return arg_28_0._groupCards[arg_28_1]
end

function var_0_0.getAllCards(arg_29_0, arg_29_1)
	local var_29_0

	if arg_29_1 == Data.CardType.monster then
		var_29_0 = Data._monsterInfo
	elseif arg_29_1 == Data.CardType.magic then
		var_29_0 = Data._magicInfo
	elseif arg_29_1 == Data.CardType.trap then
		var_29_0 = Data._trapInfo
	elseif arg_29_1 == Data.CardType.rare then
		var_29_0 = Data._rareInfo
	end

	local var_29_1 = {}

	for iter_29_0, iter_29_1 in pairs(var_29_0) do
		var_29_1[iter_29_0] = P._playerCard:getCardCount(iter_29_0)
	end

	return var_29_1
end

function var_0_0.getCardCount(arg_30_0, arg_30_1)
	local var_30_0 = 0
	local var_30_1 = Data.getType(arg_30_1)
	local var_30_2 = arg_30_0._cards[var_30_1]

	if not var_30_2 then
		return var_30_0
	end

	local var_30_3, var_30_4, var_30_5, var_30_6 = Data.removeAdditional(arg_30_1)

	return var_30_2[Data.setAdditional(var_30_3, false, var_30_5, var_30_6)] or 0
end

function var_0_0.getGroupCardCount(arg_31_0, arg_31_1)
	local var_31_0 = 0
	local var_31_1 = Data.getType(arg_31_1)
	local var_31_2 = arg_31_0._groupCards[var_31_1]

	if not var_31_2 then
		return var_31_0
	end

	local var_31_3, var_31_4, var_31_5, var_31_6 = Data.removeAdditional(arg_31_1)

	return var_31_2[Data.setAdditional(var_31_3, false, var_31_5, var_31_6)] or 0
end

function var_0_0.convert2FragmentId(arg_32_0, arg_32_1)
	arg_32_1 = Data.removeAdditional(arg_32_1)

	return Data.setAdditional(arg_32_1, true, false)
end

function var_0_0.convert2CardId(arg_33_0, arg_33_1)
	arg_33_1 = Data.removeAdditional(arg_33_1)

	return arg_33_1
end

function var_0_0.getFragmentCount(arg_34_0, arg_34_1)
	arg_34_1 = arg_34_0:convert2FragmentId(arg_34_1)

	return arg_34_0._cardFragment[arg_34_1] or 0
end

function var_0_0.changeFragmentCount(arg_35_0, arg_35_1, arg_35_2)
	arg_35_1 = arg_35_0:convert2FragmentId(arg_35_1)

	local var_35_0 = arg_35_0:getFragmentCount(arg_35_1)

	arg_35_0._cardFragment[arg_35_1] = math.max(var_35_0 + arg_35_2, 0)

	arg_35_0:sendFragmentDirty()

	return var_35_0 + arg_35_2 > 0
end

function var_0_0.addCard(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0, var_36_1, var_36_2 = Data.removeAdditional(arg_36_1)
	local var_36_3 = Data.getType(arg_36_1)

	if var_36_1 then
		arg_36_0:changeFragmentCount(arg_36_1, arg_36_2)
		arg_36_0:sendFragmentDirty()
	else
		arg_36_0._cards[var_36_3][arg_36_1] = (arg_36_0._cards[var_36_3][arg_36_1] or 0) + arg_36_2

		arg_36_0:sendCardDirty(arg_36_1)

		if arg_36_0:getCardCount(arg_36_1) == 0 then
			arg_36_0:removeUnlocked(arg_36_1)
		end

		if arg_36_0._levels[arg_36_1] == nil or arg_36_0._levels[arg_36_1] == 0 then
			arg_36_0._unlocked[arg_36_1] = true
			arg_36_0._levels[arg_36_1] = 1

			arg_36_0:sendCardAdd(arg_36_1)
			arg_36_0:sendCardFlagDirty(arg_36_1)

			return true
		end

		return false
	end
end

function var_0_0.removeCard(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0, var_37_1, var_37_2 = Data.removeAdditional(arg_37_1)
	local var_37_3 = Data.getType(arg_37_1)

	if var_37_1 then
		arg_37_0._cardFragment[arg_37_1] = math.max(arg_37_0:getFragmentCount(arg_37_1) - arg_37_2, 0)

		arg_37_0:sendFragmentDirty()
	else
		local var_37_4 = arg_37_0._cards[var_37_3][arg_37_1] or 0

		if arg_37_2 <= var_37_4 then
			arg_37_0._cards[var_37_3][arg_37_1] = var_37_4 - arg_37_2
		end

		if arg_37_0:getCardCount(arg_37_1) == 0 then
			arg_37_0:removeUnlocked(arg_37_1)
		end

		arg_37_0:sendCardDirty(arg_37_1)

		if var_37_4 == arg_37_2 then
			arg_37_0:sendCardListDirty(var_37_3)
		end
	end
end

function var_0_0.updateTroop(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0._troops[arg_38_2]

	if var_38_0 ~= nil then
		for iter_38_0 = 1, #var_38_0 do
			if var_38_0[iter_38_0]._infoId == arg_38_1._infoId then
				var_38_0[iter_38_0]._num = var_38_0[iter_38_0]._num + 1

				return
			end
		end

		table.insert(var_38_0, {
			_num = 1,
			_infoId = arg_38_1._infoId
		})
	end
end

function var_0_0.saveTroop(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0._troops[arg_39_2] = {}

	for iter_39_0 = 1, #arg_39_1 do
		arg_39_0._troops[arg_39_2][#arg_39_0._troops[arg_39_2] + 1] = {
			_infoId = arg_39_1[iter_39_0]._infoId,
			_num = arg_39_1[iter_39_0]._num
		}
	end

	return Data.ErrorType.ok
end

function var_0_0.checkTroop(arg_40_0, arg_40_1)
	if not (P._guideID > 172) then
		return true
	end

	if arg_40_0:isTroopEmpty(arg_40_1, true) then
		return false, Str(STR.EMPTY_IN_TROOP)
	end

	if Data.isUnionBattleTroop(arg_40_1) then
		if arg_40_0:getTroopCardCountByType(nil, arg_40_1, true) < Data.MAX_UNION_TROOP_CARD_COUNT then
			return false, string.format(Str(STR.AT_LEAST_ONE_IN_TROOP), Data.MAX_UNION_TROOP_CARD_COUNT)
		end
	elseif (Data.isDarkTroop(arg_40_1) or Data.isRoomDarkTroop(arg_40_1)) and arg_40_0:getTroopCardCountByType(nil, arg_40_1, true) < Data.MIN_TROOP_CARD_COUNT_2 then
		return false, string.format(Str(STR.AT_LEAST_ONE_IN_TROOP), Data.MIN_TROOP_CARD_COUNT_2)
	end

	local var_40_0 = 30
	local var_40_1 = var_40_0 <= P:getTotalCharacterLevel() and Data.MIN_TROOP_CARD_COUNT_2 or Data.MIN_TROOP_CARD_COUNT

	if var_40_1 == Data.MIN_TROOP_CARD_COUNT_2 then
		if var_40_1 > P._playerCard:getTroopCardCountByType(nil, arg_40_1, true) then
			return false, string.format(Str(STR.AT_LEAST_ONE_IN_TROOP_2), var_40_0, var_40_1)
		end
	elseif var_40_1 > P._playerCard:getTroopCardCountByType(nil, arg_40_1, true) then
		return false, string.format(Str(STR.AT_LEAST_ONE_IN_TROOP), var_40_1)
	end

	if arg_40_0:getTroopCardCountByType(Data.CardType.rare, arg_40_1, true) < Data.MIN_RARE_TROOP_CARD_COUNT then
		return false, string.format(Str(STR.LESS_CARD_IN_RARE_TROOP), Data.MIN_RARE_TROOP_CARD_COUNT)
	end

	if arg_40_0:getTroopCardCountByType(Data.CardType.rare, arg_40_1, true) > Data.MAX_RARE_TROOP_CARD_COUNT then
		return false, string.format(Str(STR.MORE_CARD_IN_RARE_TROOP), Data.MAX_RARE_TROOP_CARD_COUNT)
	end

	local var_40_2 = arg_40_0._troops[arg_40_1]

	for iter_40_0, iter_40_1 in ipairs(var_40_2) do
		local var_40_3, var_40_4, var_40_5, var_40_6 = Data.removeAdditional(iter_40_1._infoId)

		if var_40_6 and var_40_6 > 0 and not Data.canSkillRub(var_40_6, var_40_3) then
			return false, string.format(Str(STR.CARD_BANNED_IN_TROOP), Str(Data._skillInfo[var_40_6]._nameSid), ClientData.getNameByInfoId(var_40_3))
		end
	end

	return true
end

function var_0_0.isTroopEmpty(arg_41_0, arg_41_1, arg_41_2)
	return #(arg_41_2 and ClientData._cloneTroops and ClientData._cloneTroops[arg_41_1] or arg_41_0._troops[arg_41_1]) == 0
end

function var_0_0.checkDarkTroops(arg_42_0)
	local cur = (P and P._curTroopIndex) or 1
	local curTroop = arg_42_0._troops[cur]
	for iter_42_0 = Data.TroopIndex.dark_battle1, Data.TroopIndex.dark_battle3 do
		if not arg_42_0._troops[iter_42_0] or #arg_42_0._troops[iter_42_0] == 0 then
			arg_42_0._troops[iter_42_0] = curTroop or {}
		end
	end
	return true, ""
end

function var_0_0.checkRoomDarkTroops(arg_43_0)
	local cur = (P and P._curTroopIndex) or 1
	local curTroop = arg_43_0._troops[cur]
	for iter_43_0 = Data.TroopIndex.room_dark_battle1, Data.TroopIndex.room_dark_battle3 do
		if not arg_43_0._troops[iter_43_0] or #arg_43_0._troops[iter_43_0] == 0 then
			arg_43_0._troops[iter_43_0] = curTroop or {}
		end
	end
	return true, ""
end

function var_0_0.clearTroop(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0._troops[arg_44_1]

	if var_44_0 == nil or #var_44_0 == 0 then
		return
	end

	while #var_44_0 > 0 do
		local var_44_1 = var_44_0[1]

		var_44_1._troopPos[arg_44_1] = 0

		var_44_1:sendCardTroopDirty(arg_44_1)
	end
end

function var_0_0.getTroop(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0

	if arg_45_2 then
		var_45_0 = {}

		for iter_45_0, iter_45_1 in ipairs(arg_45_0._troops[arg_45_1]) do
			table.insert(var_45_0, {
				_infoId = iter_45_1._infoId,
				_num = iter_45_1._num
			})
		end
	else
		var_45_0 = arg_45_0._troops[arg_45_1]
	end

	return var_45_0
end

function var_0_0.getTroopFightingValue(arg_46_0, arg_46_1)
	return 0
end

function var_0_0.getTroopCardCountByType(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = arg_47_3 and ClientData._cloneTroops and ClientData._cloneTroops[arg_47_2] or arg_47_0:getTroop(arg_47_2)
	local var_47_1 = 0

	for iter_47_0 = 1, #var_47_0 do
		local var_47_2 = Data.getType(var_47_0[iter_47_0]._infoId)

		if arg_47_1 ~= nil and var_47_2 == arg_47_1 or arg_47_1 == nil and var_47_2 ~= Data.CardType.rare then
			var_47_1 = var_47_1 + var_47_0[iter_47_0]._num
		end
	end

	return var_47_1
end

function var_0_0.getTroopCardCountByMinStar(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0:getTroop(arg_48_2)
	local var_48_1 = 0

	for iter_48_0 = 1, #var_48_0 do
		local var_48_2, var_48_3 = Data.getInfo(var_48_0[iter_48_0]._infoId)

		if var_48_3 == Data.CardType.monster and arg_48_1 <= var_48_2._star then
			var_48_1 = var_48_1 + var_48_0[iter_48_0]._num
		end
	end

	return var_48_1
end

function var_0_0.getTroopCardCountByNature(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_0:getTroop(arg_49_2)
	local var_49_1 = 0

	for iter_49_0 = 1, #var_49_0 do
		local var_49_2, var_49_3 = Data.getInfo(var_49_0[iter_49_0]._infoId)

		if var_49_3 == Data.CardType.monster and var_49_2._nature == arg_49_1 then
			var_49_1 = var_49_1 + var_49_0[iter_49_0]._num
		end
	end

	return var_49_1
end

function var_0_0.getCardCountInSingleTroop(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	arg_50_3 = arg_50_3 or 0
	arg_50_4 = arg_50_4 or 0

	local var_50_0, var_50_1, var_50_2, var_50_3 = Data.removeAdditional(arg_50_1)
	local var_50_4 = Data.setAdditional(var_50_0, false, var_50_2, var_50_3)
	local var_50_5 = Data.getOriginId(var_50_0)

	for iter_50_0 = 1, #arg_50_2 do
		local var_50_6 = arg_50_2[iter_50_0]

		if var_50_6._infoId == var_50_5 and arg_50_3 < var_50_6._num then
			arg_50_3 = var_50_6._num
		end

		if var_50_6._infoId == var_50_4 and arg_50_4 < var_50_6._num then
			arg_50_4 = var_50_6._num
		end
	end

	return arg_50_3, arg_50_4
end

function var_0_0.getCardCountInDarkTroop(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = 0
	local var_51_1 = 0
	local var_51_2, var_51_3, var_51_4, var_51_5 = Data.removeAdditional(arg_51_1)
	local var_51_6 = Data.setAdditional(var_51_2, false, var_51_4, var_51_5)
	local var_51_7 = Data.getOriginId(var_51_2)

	for iter_51_0 = Data.TroopIndex.dark_battle1, Data.TroopIndex.dark_battle3 do
		local var_51_8 = arg_51_2 and ClientData._cloneTroops and ClientData._cloneTroops[iter_51_0] or P._playerCard._troops[iter_51_0]

		for iter_51_1, iter_51_2 in ipairs(var_51_8 or {}) do
			if iter_51_2._infoId == var_51_7 then
				var_51_0 = var_51_0 + iter_51_2._num
			elseif iter_51_2._infoId == var_51_6 then
				var_51_1 = var_51_1 + iter_51_2._num
			end
		end
	end

	return var_51_0, var_51_1
end

function var_0_0.getCardCountInTroop(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0, var_52_1 = arg_52_0:getCardCountInTroop2(arg_52_1)

	if arg_52_2 then
		local var_52_2, var_52_3 = arg_52_0:getCardCountInTroop2(arg_52_1, true)

		var_52_0, var_52_1 = math.max(var_52_0, var_52_2), math.max(var_52_1, var_52_3)
	end

	return var_52_0, var_52_1
end

function var_0_0.getCardCountInTroop2(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = 0
	local var_53_1 = 0

	for iter_53_0 = 1, #arg_53_0._troops do
		local var_53_2 = arg_53_2 and ClientData._cloneTroops and ClientData._cloneTroops[iter_53_0] or arg_53_0._troops[iter_53_0]

		for iter_53_1 = 1, #var_53_2 do
			var_53_0, var_53_1 = arg_53_0:getCardCountInSingleTroop(arg_53_1, var_53_2, var_53_0, var_53_1)
		end
	end

	local var_53_3, var_53_4 = arg_53_0:getCardCountInDarkTroop(arg_53_1, arg_53_2)
	local var_53_5 = math.max(var_53_0, var_53_3)
	local var_53_6 = math.max(var_53_1, var_53_4)

	return var_53_5, var_53_6
end

function var_0_0.getCardFreeCount(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0:getCardCount(arg_54_1)
	local var_54_1, var_54_2 = arg_54_0:getCardCountInTroop(arg_54_1, true)

	return var_54_0 - var_54_2
end

function var_0_0.sendCardDirty(arg_55_0, arg_55_1)
	local var_55_0 = cc.EventCustom:new(Data.Event.card_dirty)

	var_55_0._infoId = arg_55_1

	lc.Dispatcher:dispatchEvent(var_55_0)
end

function var_0_0.sendFragmentDirty(arg_56_0)
	local var_56_0 = cc.EventCustom:new(Data.Event.fragment_dirty)

	var_56_0._infoId = infoId

	lc.Dispatcher:dispatchEvent(var_56_0)
end

function var_0_0.sendCardAdd(arg_57_0, arg_57_1)
	local var_57_0 = cc.EventCustom:new(Data.Event.card_add)

	var_57_0._infoId = arg_57_1

	lc.Dispatcher:dispatchEvent(var_57_0)
end

function var_0_0.sendCardListDirty(arg_58_0, arg_58_1)
	local var_58_0 = cc.EventCustom:new(Data.Event.card_list_dirty)

	var_58_0._type = arg_58_1

	lc.Dispatcher:dispatchEvent(var_58_0)
	ClientData.setNeedSyncDataForCardListScenes()
end

function var_0_0.sendCardFlagDirty(arg_59_0, arg_59_1)
	local var_59_0 = cc.EventCustom:new(Data.Event.card_flag_dirty)

	var_59_0._infoId = arg_59_1

	lc.Dispatcher:dispatchEvent(var_59_0)
	ClientData.setNeedSyncDataForCardListScenes()
end

function var_0_0.sendCardSelect(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = cc.EventCustom:new(Data.Event.card_select)

	var_60_0._infoId = arg_60_1
	var_60_0._count = arg_60_2

	lc.Dispatcher:dispatchEvent(var_60_0)
end

function var_0_0.getCardFlag(arg_61_0)
	return arg_61_0:getCardFlagByType()
end

function var_0_0.getMonsterFlag(arg_62_0)
	return arg_62_0:getCardFlagByType(Data.CardType.monster)
end

function var_0_0.getTrapFlag(arg_63_0)
	return arg_63_0:getCardFlagByType(Data.CardType.trap)
end

function var_0_0.getMagicFlag(arg_64_0)
	return arg_64_0:getCardFlagByType(Data.CardType.magic)
end

function var_0_0.getRareFlag(arg_65_0)
	return arg_65_0:getCardFlagByType(Data.CardType.rare)
end

function var_0_0.getCardFlagByType(arg_66_0, arg_66_1)
	local var_66_0 = 0

	for iter_66_0, iter_66_1 in pairs(arg_66_0._unlocked) do
		if iter_66_1 and (not arg_66_1 or Data.getType(iter_66_0) == arg_66_1) then
			var_66_0 = var_66_0 + 1
		end
	end

	return var_66_0
end

function var_0_0.removeUnlocked(arg_67_0, arg_67_1)
	arg_67_0._unlocked[arg_67_1] = nil

	arg_67_0:sendCardFlagDirty(arg_67_1)
end

function var_0_0.isUnlocked(arg_68_0, arg_68_1)
	return arg_68_0._unlocked[arg_68_1]
end

function var_0_0.getSkinId(arg_69_0, arg_69_1, arg_69_2)
	arg_69_1 = arg_69_1 and Data.removeAdditional(arg_69_1)
	arg_69_2 = arg_69_2 or Data.SkinEffectType.skin

	local var_69_0 = arg_69_0._skins[arg_69_1]

	if var_69_0 == nil then
		return 0
	end

	return var_69_0:getCurrentId(arg_69_2)
end

function var_0_0.hasSkin(arg_70_0, arg_70_1, arg_70_2)
	if arg_70_1 == 0 then
		return true
	end

	local var_70_0 = Data._skinInfo[arg_70_1]

	if var_70_0 == nil then
		return false
	end

	local var_70_1 = var_70_0._infoId

	return arg_70_0:cardHasSkin(var_70_1, arg_70_1, arg_70_2)
end

function var_0_0.cardHasSkin(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	arg_71_1 = arg_71_1 and Data.removeAdditional(arg_71_1)

	local var_71_0 = arg_71_0._skins[arg_71_1]

	if var_71_0 == nil then
		return false
	end

	return var_71_0:isSkinIdAvailable(arg_71_2, arg_71_3)
end

function var_0_0.setSkinId(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	arg_72_1 = arg_72_1 and Data.removeAdditional(arg_72_1)
	arg_72_3 = arg_72_3 or Data.SkinEffectType.skin

	local var_72_0 = arg_72_0._skins[arg_72_1]

	if arg_72_2 == 0 then
		if var_72_0 ~= nil then
			var_72_0:setCurrentId(arg_72_2, arg_72_3)
		end

		return true
	end

	if var_72_0 == nil then
		return false
	end

	if Data._skinInfo[arg_72_2] == nil then
		return false
	end

	if var_72_0:isSkinIdAvailable(arg_72_2) then
		var_72_0:setCurrentId(arg_72_2, arg_72_3)

		return true
	end

	return false
end

function var_0_0.buySkinId(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	arg_73_3 = arg_73_3 and Data.removeAdditional(arg_73_3)

	local var_73_0 = Data._skinInfo[arg_73_1]

	if var_73_0 == nil then
		return false
	end

	if arg_73_0:hasSkin(arg_73_1, true) then
		return false
	end

	arg_73_3 = arg_73_3 or var_73_0._infoId

	if not arg_73_3 then
		return false
	end

	local var_73_1 = arg_73_0._skins[arg_73_3] or var_0_1.new(arg_73_3)

	arg_73_0._skins[arg_73_3] = var_73_1

	var_73_1:addAvailable(arg_73_1, arg_73_2)
	lc.sendEvent(Data.Event.skin_dirty)

	return true
end

function var_0_0.getRecommendTroops(arg_74_0)
	return arg_74_0._recommendTroops
end

function var_0_0.getSystemRecommendTroops(arg_75_0)
	return arg_75_0._systemRecommendTroops
end

function var_0_0.initSystemRecommendTroops(arg_76_0)
	local var_76_0 = {
		2,
		3,
		4,
		5,
		10,
		12,
		13
	}
	local var_76_1 = 15000
	local var_76_2 = Data._troopInfo

	for iter_76_0, iter_76_1 in ipairs(var_76_0) do
		local var_76_3 = var_76_2[var_76_1 + iter_76_1]

		if var_76_3 then
			local var_76_4 = {}
			local var_76_5 = {}
			local var_76_6 = Str(var_76_3._nameSid)
			local var_76_7 = var_76_3._picId
			local var_76_8 = var_76_3._infoId

			for iter_76_2, iter_76_3 in ipairs(var_76_8) do
				table.insert(var_76_4, {
					info_id = iter_76_3,
					num = var_76_3._num[iter_76_2]
				})
				table.insert(var_76_5, {
					info_id = iter_76_3,
					level = var_76_3._level[iter_76_2]
				})
			end

			local var_76_9 = {
				_level = 30,
				_name = var_76_6,
				_avatar = var_76_7,
				_troopCards = var_76_4,
				_troopLevels = var_76_5,
				_troopSkins = {},
				_fortressHp = var_76_3._fortressHp
			}

			table.insert(arg_76_0._systemRecommendTroops, {
				_isAttacker = true,
				_player = var_76_9
			})
		end
	end
end

function var_0_0.getCardFragmentNeedCount(arg_77_0, arg_77_1)
	local var_77_0 = Data._globalInfo._legendCardMixCount

	if arg_77_1 and arg_77_1 == 10038 then
		var_77_0 = 2500
	end

	return var_77_0
end

function var_0_0.getCanOperateCards(arg_78_0, arg_78_1, arg_78_2)
	local var_78_0 = {}
	local var_78_1 = arg_78_0:getCards(arg_78_1)

	for iter_78_0, iter_78_1 in pairs(var_78_1) do
		if iter_78_1 > 0 and arg_78_0:getCardOperateCount(iter_78_0) > 0 then
			if arg_78_2 == Data.OperateMode.smelt then
				if Data.getInfo(iter_78_0)._quality == 4 then
					var_78_0[#var_78_0 + 1] = iter_78_0
				end
			else
				var_78_0[#var_78_0 + 1] = iter_78_0
			end
		end
	end

	return var_78_0
end

function var_0_0.getCardOperateCount(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0:getCardCount(arg_79_1)
	local var_79_1, var_79_2 = arg_79_0:getCardCountInTroop(arg_79_1, true)

	return math.max(0, var_79_0 - math.max(3, var_79_2))
end

function var_0_0.getCardEffectCount(arg_80_0, arg_80_1)
	local var_80_0 = 0
	local var_80_1 = arg_80_0._skins[arg_80_1]

	if not var_80_1 then
		return var_80_0
	end

	return var_80_1:getEffectCount()
end

function var_0_0.removeCardFromTroops(arg_81_0, arg_81_1)
	for iter_81_0, iter_81_1 in pairs(arg_81_0._troops) do
		if iter_81_0 == 111 then
			local var_81_0
		end

		table.removeByCondition(iter_81_1, function(arg_82_0)
			return arg_82_0._infoId == arg_81_1
		end)
	end
end

function var_0_0.getExtraTroopCount(arg_83_0)
	return arg_83_0._extraTroopCount
end

function var_0_0.unlockTroop(arg_84_0)
	if arg_84_0:getExtraTroopCount() >= P:getCharacterUnlockCount() then
		return
	end

	P:changeResource(Data.ResType.ingot, -Data.TROOP_UNLOCK_INGOT)
	ClientData.sendUnlockTroop()

	arg_84_0._extraTroopCount = arg_84_0._extraTroopCount + 1

	local var_84_0 = P:getMaxTroopCount()

	arg_84_0._troops[var_84_0] = {}
end

function var_0_0.setCollected(arg_85_0, arg_85_1, arg_85_2)
	if arg_85_0._collected[arg_85_1] ~= arg_85_2 then
		arg_85_0._collected[arg_85_1] = arg_85_2

		ClientData.sendCardCollect(arg_85_1)
		arg_85_0:sendCardDirty(arg_85_1)
	end
end

function var_0_0.isCollected(arg_86_0, arg_86_1)
	return arg_86_0._collected[arg_86_1]
end

function var_0_0.equipSkill(arg_87_0, arg_87_1, arg_87_2)
	ClientData.sendRubSkill(arg_87_1, arg_87_2)

	arg_87_2 = Data.getExtraSid(arg_87_2)

	arg_87_0:removeCard(arg_87_1, 1)

	local var_87_0 = Data.setAdditional(arg_87_1, false, Data.isGold(arg_87_1), arg_87_2)

	arg_87_0:addCard(var_87_0, 1)
	lc.sendEvent(Data.Event.card_skill_dirty, {
		_oldId = arg_87_1,
		_newId = var_87_0
	})
end

function var_0_0.unRubSkill(arg_88_0, arg_88_1, arg_88_2)
	if arg_88_2 then
		ClientData.sendRemoveRubSkill(arg_88_1)
	else
		ClientData.sendUnRubSkill(arg_88_1)
	end

	arg_88_0:removeCard(arg_88_1, 1)

	local var_88_0 = Data.setAdditional(arg_88_1, false, Data.isGold(arg_88_1), 0)

	arg_88_0:addCard(var_88_0, 1)
	lc.sendEvent(Data.Event.card_skill_dirty, {
		_oldId = arg_88_1,
		_newId = var_88_0
	})
end

return var_0_0
