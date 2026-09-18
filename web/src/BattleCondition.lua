local var_0_0 = class("BattleCondition")

BattleCondition = var_0_0

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._player = arg_1_1
	arg_1_0._conditions = {}

	if next(arg_1_2) ~= nil then
		for iter_1_0 = 1, #arg_1_2._conditionIds do
			local var_1_0 = Data._conditionInfo[arg_1_2._conditionIds[iter_1_0]]

			if var_1_0 ~= nil then
				local var_1_1 = {
					_id = var_1_0._id,
					_info = var_1_0,
					_value = arg_1_2._conditionValues[iter_1_0]
				}

				table.insert(arg_1_0._conditions, var_1_1)
			end
		end
	end
end

function var_0_0.reset(arg_2_0)
	arg_2_0._results = {}
end

function var_0_0.getTaskResult(arg_3_0)
	if next(arg_3_0._results) == nil then
		for iter_3_0 = 1, #arg_3_0._conditions do
			local var_3_0 = arg_3_0._conditions[iter_3_0]
			local var_3_1 = arg_3_0:castCondition(var_3_0._id, var_3_0._value)

			table.insert(arg_3_0._results, var_3_1)
		end
	end

	return arg_3_0._results
end

function var_0_0.isAllSatisfied(arg_4_0)
	local var_4_0 = arg_4_0:getTaskResult()

	for iter_4_0 = 1, #var_4_0 do
		if not var_4_0[iter_4_0] then
			return false
		end
	end

	return true
end

function var_0_0.getIsWin(arg_5_0)
	for iter_5_0 = 1, #arg_5_0._conditions do
		local var_5_0 = arg_5_0._conditions[iter_5_0]

		if var_5_0._id == 15 and arg_5_0._player._macroStatus == BattleData.Status.round_begin and arg_5_0._player._round > var_5_0._value then
			return true
		elseif var_5_0._id == 28 and arg_5_0:castCondition(var_5_0._id, var_5_0._value) then
			return true
		end
	end

	return false
end

function var_0_0.castCondition(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = false
	local var_6_1 = arg_6_0._player
	local var_6_2 = arg_6_0._player._opponent

	if arg_6_1 == 1 then
		if var_6_1:getResult() == Data.BattleResult.win then
			var_6_0 = true
		end
	elseif arg_6_1 == 2 then
		if #var_6_2._pileCards == 0 and #var_6_2:getBoardCards() == 0 then
			local var_6_3 = 0

			for iter_6_0 = 1, #var_6_2._handCards do
				local var_6_4 = var_6_2._handCards[iter_6_0]

				if var_6_4 ~= nil and var_6_4._type == Data.CardType.monster then
					var_6_3 = var_6_3 + 1
				end
			end

			if var_6_3 == 0 then
				var_6_0 = true
			end
		end
	elseif arg_6_1 == 3 then
		local var_6_5 = math.max(var_6_1._round, var_6_2._round)

		if var_6_1:getResult() == Data.BattleResult.win and var_6_5 <= arg_6_2 then
			var_6_0 = true
		end
	elseif arg_6_1 == 4 then
		if var_6_1:getResult() == Data.BattleResult.win and arg_6_2 >= #var_6_1._graveCards then
			var_6_0 = true
		end
	elseif arg_6_1 == 5 then
		if var_6_1:getResult() == Data.BattleResult.win and var_6_1._fortress._hp / var_6_1._fortress._maxHp >= arg_6_2 / 100 then
			var_6_0 = true
		end
	elseif arg_6_1 == 6 then
		if arg_6_2 <= arg_6_0:getCardCountByType() then
			var_6_0 = true
		end
	elseif arg_6_1 >= 7 and arg_6_1 <= 9 then
		if arg_6_2 <= arg_6_0:getCardCountByType(arg_6_1 - 6) then
			var_6_0 = true
		end
	elseif arg_6_1 == 10 then
		if arg_6_0:getCardCountByMinStar(arg_6_2) == 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 11 then
		if arg_6_0:getCardCountByNature(arg_6_2) == 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 12 then
		-- block empty
	elseif arg_6_1 == 13 then
		-- block empty
	elseif arg_6_1 == 14 then
		local var_6_6 = var_6_1._battleEvent:getEventById(arg_6_2) or var_6_2._battleEvent:getEventById(arg_6_2)

		if var_6_6 ~= nil and var_6_6._isCasted then
			var_6_0 = true
		end
	elseif arg_6_1 == 15 then
		if arg_6_2 <= var_6_1._round then
			var_6_0 = true
		end
	elseif arg_6_1 == 16 then
		if arg_6_2 >= arg_6_0:getCardCountByType() then
			var_6_0 = true
		end
	elseif arg_6_1 >= 17 and arg_6_1 <= 19 then
		if arg_6_2 >= arg_6_0:getCardCountByType(arg_6_1 - 16) then
			var_6_0 = true
		end
	elseif arg_6_1 == 21 then
		if var_6_2._cards[arg_6_2] ~= nil and B.isAlive(var_6_2._cards[arg_6_2]) then
			var_6_0 = true
		end
	elseif arg_6_1 >= 22 and arg_6_1 <= 25 then
		-- block empty
	elseif arg_6_1 == 26 then
		-- block empty
	elseif arg_6_1 == 27 then
		if var_6_2._fortress._hp <= 0 then
			var_6_0 = true
		end
	elseif arg_6_1 == 28 then
		if arg_6_0._player._isAttacker and arg_6_2 <= (arg_6_0._player._destroyMonsterCount[0] or 0) then
			var_6_0 = true
		end
	elseif arg_6_1 == 29 then
		local var_6_7 = arg_6_2 % 100000
		local var_6_8 = math.floor(arg_6_2 / 100000)

		if arg_6_0._player._isAttacker and var_6_8 <= (arg_6_0._player._destroyMonsterCount[var_6_7] or 0) then
			var_6_0 = true
		end
	end

	return var_6_0
end

function var_0_0.getCardCountByType(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0 = 1, #arg_7_0._player._troopCards do
		local var_7_1 = arg_7_0._player._troopCards[iter_7_0]
		local var_7_2 = Data.getType(var_7_1.info_id)

		if arg_7_1 ~= nil and var_7_2 == arg_7_1 or arg_7_1 == nil and var_7_2 ~= Data.CardType.rare then
			var_7_0 = var_7_0 + var_7_1.num
		end
	end

	return var_7_0
end

function var_0_0.getCardCountByMinStar(arg_8_0, arg_8_1)
	local var_8_0 = 0

	for iter_8_0 = 1, #arg_8_0._player._troopCards do
		local var_8_1 = arg_8_0._player._troopCards[iter_8_0]
		local var_8_2, var_8_3 = Data.getInfo(var_8_1.info_id)

		if var_8_3 == Data.CardType.monster and arg_8_1 <= var_8_2._star then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_0.getCardCountByNature(arg_9_0, arg_9_1)
	local var_9_0 = 0

	for iter_9_0 = 1, #arg_9_0._player._troopCards do
		local var_9_1 = arg_9_0._player._troopCards[iter_9_0]
		local var_9_2, var_9_3 = Data.getInfo(var_9_1.info_id)

		if var_9_3 == Data.CardType.monster and var_9_2._nature == arg_9_1 then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function var_0_0.getConditionDesc(arg_10_0)
	if arg_10_0._desc == nil then
		local var_10_0 = {}

		for iter_10_0 = 1, #arg_10_0._conditions do
			local var_10_1 = arg_10_0._conditions[iter_10_0]
			local var_10_2 = string.format("%s", Str(var_10_1._info._descSid))
			local var_10_3, var_10_4, var_10_5 = string.find(var_10_2, "%[(.-)%]")

			if var_10_1._value ~= nil and var_10_3 ~= nil and var_10_4 ~= nil and var_10_5 ~= nil then
				local var_10_6
				local var_10_7 = ""

				if var_10_1._id == 11 then
					var_10_6 = Str(STR.NATURE_NONE + var_10_1._value)
				elseif var_10_1._id == 13 then
					local var_10_8 = Data._monsterInfo[var_10_1._value] or Data._bookInfo[var_10_1._value] or Data._horseInfo[var_10_1._value]

					var_10_6 = Str(var_10_8._nameSid)
				elseif var_10_1._id == 14 then
					var_10_6 = Str(Data._eventInfo[var_10_1._value]._nameSid)
				elseif var_10_1._id == 29 then
					local var_10_9 = var_10_1._value % 100000
					local var_10_10 = math.floor(var_10_1._value / 100000)

					var_10_6 = "" .. var_10_10

					local var_10_11 = Data.getInfo(var_10_9)

					var_10_7 = Str(var_10_11._nameSid)
				else
					var_10_6 = var_10_1._value
				end

				var_10_2 = string.gsub(var_10_2, "%[" .. var_10_5 .. "%]", var_10_6) .. var_10_7
			end

			table.insert(var_10_0, var_10_2)
		end

		arg_10_0._desc = var_10_0
	end

	return arg_10_0._desc
end

return var_0_0
