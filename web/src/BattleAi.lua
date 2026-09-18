local var_0_0 = class("BattleAi")

BattleAi = var_0_0
var_0_0.ResultType = {
	destroy_card = 41,
	win_battle = 1,
	hit_fortress = 31,
	monster_effect = 51,
	sacrifice_success = 14,
	sync_success = 11,
	link_success = 13,
	be_destroyed = 61,
	not_effect = 71,
	xyz_success = 12,
	not_viable = 81,
	magic_trap_effect = 21
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._player = arg_1_1
	arg_1_0._isLog = false
end

function var_0_0.reset(arg_2_0)
	arg_2_0._opponent = arg_2_0._player._opponent
	arg_2_0._oppo = {}

	local var_2_0 = {
		arg_2_0._player,
		arg_2_0._opponent
	}
	local var_2_1 = {
		arg_2_0,
		arg_2_0._oppo
	}

	for iter_2_0 = 1, 2 do
		local var_2_2 = var_2_0[iter_2_0]
		local var_2_3 = var_2_1[iter_2_0]

		var_2_3._aliveCardCount = 0
		var_2_3._aliveHeroCount = 0
		var_2_3._aliveHeroInCountryCount = {}
		var_2_3._aliveHeroOnHorseCount = 0
		var_2_3._nodrCardCount = 0
		var_2_3._nodrHeroCount = 0
		var_2_3._nodrHeroInCountryCount = {}
		var_2_3._nodrHeroOnHorseCount = 0
		var_2_3._nogbCardCount = 0
		var_2_3._graveMonsterCount = 0
		var_2_3._skills = {}

		for iter_2_1 = Data.CardCountry.wei, Data.CardCountry.count do
			var_2_3._aliveHeroInCountryCount[iter_2_1] = 0
			var_2_3._nodrHeroInCountryCount[iter_2_1] = 0
		end

		for iter_2_2 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
			local var_2_4 = var_2_2._boardCards[iter_2_2]

			if B.isAlive(var_2_4) then
				local var_2_5 = not var_2_4:hasDefendRuseSkill()
				local var_2_6 = not var_2_4:hasSkills({
					2039
				}, true)

				var_2_3._aliveCardCount = var_2_3._aliveCardCount + 1

				if var_2_5 then
					var_2_3._nodrCardCount = var_2_3._nodrCardCount + 1
				end

				if var_2_6 then
					var_2_3._nogbCardCount = var_2_3._nogbCardCount + 1
				end

				for iter_2_3 = 1, #var_2_4._skills do
					local var_2_7 = var_2_4._skills[iter_2_3]._id

					var_2_3._skills[var_2_7] = (var_2_3._skills[var_2_7] or 0) + 1
				end
			end
		end

		for iter_2_4 = 1, #var_2_2._graveCards do
			if var_2_2._graveCards[iter_2_4]._type == Data.CardType.monster then
				var_2_3._graveMonsterCount = var_2_3._graveMonsterCount + 1
			end
		end
	end
end

function var_0_0.useCard(arg_3_0)
	local var_3_0 = arg_3_0._player

	arg_3_0:reset()

	if var_3_0._roundUseCardCount > 20 then
		return nil
	end

	local var_3_1
	local var_3_2
	local var_3_3
	local var_3_4
	local var_3_5

	for iter_3_0 = 1, 4 do
		local var_3_6
		local var_3_7
		local var_3_8
		local var_3_9
		local var_3_10

		if iter_3_0 == 1 then
			var_3_6, var_3_7, var_3_8, var_3_9, var_3_10 = arg_3_0:useRare()
		elseif iter_3_0 == 2 then
			var_3_6, var_3_7, var_3_8, var_3_9, var_3_10 = arg_3_0:useMonster()
		elseif iter_3_0 == 3 then
			var_3_6, var_3_7, var_3_8, var_3_9, var_3_10 = arg_3_0:useMagic()
		elseif iter_3_0 == 4 then
			var_3_6, var_3_7, var_3_8, var_3_9, var_3_10 = arg_3_0:useTrap()
		end

		if var_3_4 == nil or var_3_9 ~= nil and var_3_9 < var_3_4 or var_3_9 == var_3_4 and var_3_5 < var_3_10 then
			var_3_1, var_3_2, var_3_3, var_3_4, var_3_5 = var_3_6, var_3_7, var_3_8, var_3_9, var_3_10
		end
	end

	if var_3_1 ~= nil then
		var_3_1._opInfoId = var_3_1._infoId

		return var_3_1, var_3_2, var_3_3 or 1
	end

	if var_3_0._fortress._type == Data.CardType.boss and var_3_0._fortress._actionIndex <= var_3_0._fortress._actionCount then
		return var_3_0._fortress, nil, var_3_3 or 1
	end

	if var_3_0:getIsNeedDrop() then
		return arg_3_0:dropCard()
	end

	return nil
end

function var_0_0.dropCard(arg_4_0)
	local var_4_0 = arg_4_0._player._handCards[#arg_4_0._player._handCards]

	var_4_0._opInfoId = var_4_0._infoId

	return var_4_0, nil, BattleData.ChoiceId.drop
end

function var_0_0.useRare(arg_5_0)
	local var_5_0
	local var_5_1
	local var_5_2
	local var_5_3
	local var_5_4
	local var_5_5 = arg_5_0._player:getEmptyGroundPos()
	local var_5_6 = B.filterSyncCards(arg_5_0._player:getBattleCards("R"), true)

	for iter_5_0 = 1, #var_5_6 do
		local var_5_7 = var_5_6[iter_5_0]
		local var_5_8, var_5_9, var_5_10, var_5_11 = arg_5_0:syncResult(var_5_7)

		if var_5_8 ~= var_0_0.ResultType.not_viable and var_5_8 ~= var_0_0.ResultType.not_effect and (var_5_0 == nil or var_5_8 < var_5_3 or var_5_8 == miniResult and (var_5_4 == nil or var_5_4 < var_5_9)) then
			var_5_0, var_5_1, var_5_2, var_5_3, var_5_4 = var_5_7, var_5_10, var_5_11, var_5_8, var_5_9
		end
	end

	if var_5_0 ~= nil then
		return var_5_0, var_5_1, var_5_2, var_5_3, var_5_4
	end

	local var_5_12 = B.filterXYZCards(arg_5_0._player:getBattleCards("R"), true)

	for iter_5_1 = 1, #var_5_12 do
		local var_5_13 = var_5_12[iter_5_1]
		local var_5_14, var_5_15, var_5_16, var_5_17 = arg_5_0:xyzResult(var_5_13)

		if var_5_14 ~= var_0_0.ResultType.not_viable and var_5_14 ~= var_0_0.ResultType.not_effect and (var_5_0 == nil or var_5_14 < var_5_3 or var_5_14 == miniResult and (var_5_4 == nil or var_5_4 < var_5_15)) then
			var_5_0, var_5_1, var_5_2, var_5_3, var_5_4 = var_5_13, var_5_16, var_5_17, var_5_14, var_5_15
		end
	end

	if useCard ~= nil then
		return var_5_0, var_5_1, var_5_2, var_5_3, var_5_4
	end

	local var_5_18 = B.filterLinkCards(arg_5_0._player:getBattleCards("R"), true)

	for iter_5_2 = 1, #var_5_18 do
		local var_5_19 = var_5_18[iter_5_2]
		local var_5_20, var_5_21, var_5_22, var_5_23 = arg_5_0:linkResult(var_5_19)

		if var_5_20 ~= var_0_0.ResultType.not_viable and var_5_20 ~= var_0_0.ResultType.not_effect and (var_5_0 == nil or var_5_20 < var_5_3 or var_5_20 == miniResult and (var_5_4 == nil or var_5_4 < var_5_21)) then
			var_5_0, var_5_1, var_5_2, var_5_3, var_5_4 = var_5_19, var_5_22, var_5_23, var_5_20, var_5_21
		end
	end

	return var_5_0, var_5_1, var_5_2, var_5_3, var_5_4
end

function var_0_0.useMonster(arg_6_0)
	local var_6_0
	local var_6_1
	local var_6_2
	local var_6_3
	local var_6_4
	local var_6_5 = {}

	if arg_6_0._player:getEmptyBoardPos() ~= nil then
		for iter_6_0 = 1, #arg_6_0._player._handCards do
			local var_6_6 = arg_6_0._player._handCards[iter_6_0]

			if var_6_6._type == Data.CardType.monster then
				local var_6_7, var_6_8, var_6_9 = arg_6_0._player:canUseMonster(var_6_6, true)

				if var_6_7 then
					if var_6_6:getSacrificeCount() > 0 then
						local var_6_10 = var_6_9 % BattleData.ChoiceId.stage_size_1
						local var_6_11 = var_6_10 == 4 and arg_6_0._player._opponent:getSacrificedCards(var_6_9) or arg_6_0._player:getSacrificedCards(var_6_9)
						local var_6_12 = true

						for iter_6_1 = 1, #var_6_11 do
							if var_6_10 == 1 and math.max(var_6_11[iter_6_1]._atk, var_6_11[iter_6_1]._hp) >= math.max(var_6_6._atk, var_6_6._hp) then
								var_6_12 = false
							end
						end

						if var_6_12 then
							table.insert(var_6_5, {
								_card = var_6_6,
								_target = var_6_8,
								_choice = var_6_9,
								_result = var_0_0.ResultType.sacrifice_success,
								_val = var_6_6._hp + var_6_6._atk
							})
						end
					else
						table.insert(var_6_5, {
							_card = var_6_6,
							_target = var_6_8,
							_choice = var_6_9,
							_result = var_0_0.ResultType.monster_effect,
							_val = var_6_6._hp + var_6_6._atk
						})
					end
				end
			end
		end
	end

	local var_6_13 = arg_6_0._player:getBoardCards()

	if #var_6_13 > 0 then
		for iter_6_2 = 1, #var_6_13 do
			local var_6_14 = var_6_13[iter_6_2]

			if var_6_14:canChangeToDefend() and var_6_14._hp >= var_6_14._atk then
				if arg_6_0._isLog then
					lc.log("[AI] %s DEF: result: %d, value: %d", Str(var_6_14._info._nameSid), var_0_0.ResultType.monster_effect, var_6_14._hp)
				end

				table.insert(var_6_5, {
					_card = var_6_14,
					_target = var_6_14,
					_result = var_0_0.ResultType.monster_effect,
					_val = var_6_14._hp
				})
			end

			if var_6_14:canAttack(true) then
				local var_6_15 = arg_6_0._player._opponent:getBoardCards()

				if #var_6_15 > 0 then
					for iter_6_3 = 1, #var_6_15 do
						local var_6_16 = var_6_15[iter_6_3]

						result, val, target = arg_6_0:monsterAttack(var_6_14, var_6_16)

						if result ~= var_0_0.ResultType.not_viable and result ~= var_0_0.ResultType.not_effect then
							table.insert(var_6_5, {
								_card = var_6_14,
								_target = target,
								_result = result,
								_val = val
							})
						end
					end
				else
					result, val, target = arg_6_0:monsterAttack(var_6_14, arg_6_0._player._opponent._fortress)

					if result ~= var_0_0.ResultType.not_viable and result ~= var_0_0.ResultType.not_effect then
						table.insert(var_6_5, {
							_card = var_6_14,
							_target = target,
							_result = result,
							_val = val
						})
					end
				end
			end
		end
	end

	for iter_6_4 = 1, #var_6_5 do
		local var_6_17 = var_6_5[iter_6_4]._card
		local var_6_18 = var_6_5[iter_6_4]._target
		local var_6_19 = var_6_5[iter_6_4]._choice
		local var_6_20 = var_6_5[iter_6_4]._result
		local var_6_21 = var_6_5[iter_6_4]._val

		if var_6_0 == nil or var_6_20 < var_6_3 then
			var_6_0, var_6_1, var_6_2, var_6_3, var_6_4 = var_6_17, var_6_18, var_6_19, var_6_20, var_6_21
		elseif var_6_20 == var_6_3 and (var_6_20 == var_0_0.ResultType.destroy_card or var_6_20 == var_0_0.ResultType.be_destroyed or var_6_20 == var_0_0.ResultType.monster_effect) and (var_6_4 == nil or var_6_4 < var_6_21 or var_6_21 == var_6_4 and var_6_17._status ~= BattleData.CardStatus.board and (arg_6_0._aliveCardCount >= arg_6_0._oppo._aliveCardCount and var_6_17._atk > var_6_0._atk or arg_6_0._aliveCardCount < arg_6_0._oppo._aliveCardCount and var_6_17._hp > var_6_0._hp)) then
			var_6_0, var_6_1, var_6_2, var_6_3, var_6_4 = var_6_17, var_6_18, var_6_19, var_6_20, var_6_21
		end
	end

	if var_6_0 ~= nil and var_6_0._status == BattleData.CardStatus.board and var_6_1 == nil then
		return nil, nil, nil, nil, nil
	end

	return var_6_0, var_6_1, var_6_2, var_6_3, var_6_4
end

function var_0_0.useMagic(arg_7_0)
	local var_7_0
	local var_7_1
	local var_7_2
	local var_7_3
	local var_7_4
	local var_7_5 = arg_7_0._player:getEmptyGroundPos()

	for iter_7_0 = 1, #arg_7_0._player._handCards do
		local var_7_6 = arg_7_0._player._handCards[iter_7_0]

		if var_7_6._info._type == Data.MagicTrapType.once or var_7_5 ~= nil then
			local var_7_7, var_7_8, var_7_9, var_7_10 = arg_7_0:magicResult(var_7_6)

			if var_7_7 ~= var_0_0.ResultType.not_viable and var_7_7 ~= var_0_0.ResultType.not_effect and (var_7_0 == nil or var_7_7 < var_7_3 or var_7_7 == miniResult and (var_7_4 == nil or var_7_4 < var_7_8)) then
				var_7_0, var_7_1, var_7_2, var_7_3, var_7_4 = var_7_6, var_7_9, var_7_10, var_7_7, var_7_8
			end
		end
	end

	return var_7_0, var_7_1, var_7_2, var_7_3, var_7_4
end

function var_0_0.useTrap(arg_8_0)
	local var_8_0
	local var_8_1
	local var_8_2
	local var_8_3
	local var_8_4

	if arg_8_0._player:getEmptyGroundPos() ~= nil then
		for iter_8_0 = 1, #arg_8_0._player._handCards do
			local var_8_5 = arg_8_0._player._handCards[iter_8_0]
			local var_8_6, var_8_7, var_8_8, var_8_9 = arg_8_0:trapResult(var_8_5)

			if var_8_6 ~= var_0_0.ResultType.not_viable and var_8_6 ~= var_0_0.ResultType.not_effect and (var_8_0 == nil or var_8_6 < var_8_3 or var_8_6 == miniResult and (var_8_4 == nil or var_8_4 < var_8_7)) then
				var_8_0, var_8_1, var_8_2, var_8_3, var_8_4 = var_8_5, var_8_8, var_8_9, var_8_6, var_8_7
			end
		end
	end

	return var_8_0, var_8_1, var_8_2, var_8_3, var_8_4
end

function var_0_0.syncResult(arg_9_0, arg_9_1)
	local var_9_0, var_9_1, var_9_2, var_9_3 = arg_9_0._player:canUseSyncCard(arg_9_1, true)

	if var_9_0 and var_9_2 ~= nil then
		local var_9_4 = true

		for iter_9_0 = 1, #var_9_3 do
			if math.max(var_9_3[iter_9_0]._atk, var_9_3[iter_9_0]._hp) >= math.max(arg_9_1._atk, arg_9_1._hp) then
				var_9_4 = false
			end
		end

		if var_9_4 then
			if arg_9_0._isLog then
				lc.log("[AI] %s: result: %d, value: %d", Str(arg_9_1._info._nameSid), var_0_0.ResultType.sync_success, arg_9_1._hp + arg_9_1._atk)
			end

			return var_0_0.ResultType.sync_success, arg_9_1._hp + arg_9_1._atk, var_9_1, var_9_2
		end
	end

	return var_0_0.ResultType.not_viable
end

function var_0_0.xyzResult(arg_10_0, arg_10_1)
	local var_10_0, var_10_1, var_10_2, var_10_3 = arg_10_0._player:canUseXYZCard(arg_10_1, true)

	if var_10_0 then
		local var_10_4 = true

		for iter_10_0 = 1, #var_10_3 do
			if math.max(var_10_3[iter_10_0]._atk, var_10_3[iter_10_0]._hp) >= math.max(arg_10_1._atk, arg_10_1._hp) then
				var_10_4 = false
			end
		end

		if var_10_4 then
			if arg_10_0._isLog then
				lc.log("[AI] %s: result: %d, value: %d", Str(arg_10_1._info._nameSid), var_0_0.ResultType.xyz_success, arg_10_1._hp + arg_10_1._atk)
			end

			return var_0_0.ResultType.xyz_success, arg_10_1._hp + arg_10_1._atk, var_10_1, var_10_2
		end
	end

	return var_0_0.ResultType.not_viable
end

function var_0_0.linkResult(arg_11_0, arg_11_1)
	local var_11_0, var_11_1, var_11_2, var_11_3 = arg_11_0._player:canUseLinkCard(arg_11_1, true)

	if var_11_0 then
		local var_11_4 = true

		for iter_11_0 = 1, #var_11_3 do
			if math.max(var_11_3[iter_11_0]._atk, var_11_3[iter_11_0]._hp) >= math.max(arg_11_1._atk, arg_11_1._hp) then
				-- block empty
			end
		end

		if var_11_4 then
			if arg_11_0._isLog then
				lc.log("[AI] %s: result: %d, value: %d", Str(arg_11_1._info._nameSid), var_0_0.ResultType.link_success, arg_11_1._hp + arg_11_1._atk)
			end

			return var_0_0.ResultType.link_success, arg_11_1._hp + arg_11_1._atk, var_11_1, var_11_2
		end
	end

	return var_0_0.ResultType.not_viable
end

function var_0_0.monsterAttack(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = 0

	if not arg_12_1:canAttackTarget(arg_12_2, true) or arg_12_1._infoId == 11338 and arg_12_2._infoId == 11338 then
		return var_0_0.ResultType.not_viable
	end

	if arg_12_1._atk == (arg_12_2:hasBuff(true, BattleData.PositiveType.defendPosture) and arg_12_2._hp or arg_12_2._atk) and arg_12_2:hasShieldInType(BattleData.PositiveType.shieldAttack) then
		return var_0_0.ResultType.not_viable
	end

	if arg_12_2._type == Data.CardType.fortress or arg_12_1:hasSiegeSkill() then
		if arg_12_0._player._opponent._fortress._hp <= arg_12_1._atk then
			local var_12_1 = arg_12_1._atk

			if arg_12_0._isLog then
				lc.log("[AI] %s -> %s: result: %d, value: %d", Str(arg_12_1._info._nameSid), Str(STR.FORTRESS), var_0_0.ResultType.win_battle, var_12_1)
			end

			return var_0_0.ResultType.win_battle, var_12_1, arg_12_2
		else
			local var_12_2 = arg_12_1._atk

			if arg_12_0._isLog then
				lc.log("[AI] %s -> %s: result: %d, value: %d", Str(arg_12_1._info._nameSid), Str(STR.FORTRESS), var_0_0.ResultType.hit_fortress, var_12_2)
			end

			return var_0_0.ResultType.hit_fortress, var_12_2, arg_12_2
		end
	end

	local var_12_3 = arg_12_2:hasBuff(true, BattleData.PositiveType.defendPosture) and arg_12_2._hp or arg_12_2._atk

	if arg_12_2:hasBuff(true, BattleData.PositiveType.defendPosture) and var_12_3 < arg_12_1._atk or not arg_12_2:hasBuff(true, BattleData.PositiveType.defendPosture) and var_12_3 <= arg_12_1._atk then
		if not arg_12_2:hasBuff(true, BattleData.PositiveType.defendPosture) and arg_12_1._atk - var_12_3 >= arg_12_2._owner._fortress._hp then
			local var_12_4 = arg_12_1._atk - var_12_3

			if arg_12_0._isLog then
				lc.log("[AI] %s -> %s: result: %d, value: %d", Str(arg_12_1._info._nameSid), Str(STR.FORTRESS), var_0_0.ResultType.win_battle, var_12_4)
			end

			return var_0_0.ResultType.win_battle, var_12_4, arg_12_2
		end

		local var_12_5 = arg_12_2._atk + arg_12_2._hp + (arg_12_2:hasBuff(true, BattleData.PositiveType.defendPosture) and 0 or arg_12_1._atk - var_12_3)

		if arg_12_0._isLog then
			lc.log("[AI] %s -> %s: result: %d, value: %d", Str(arg_12_1._info._nameSid), Str(arg_12_2._info._nameSid), var_0_0.ResultType.destroy_card, var_12_5)
		end

		return var_0_0.ResultType.destroy_card, var_12_5, arg_12_2
	else
		local var_12_6 = -(arg_12_1._atk + arg_12_1._hp) - (var_12_3 - arg_12_1._atk)

		if arg_12_0._isLog then
			lc.log("[AI] %s -> %s: result: %d, value: %d", Str(arg_12_1._info._nameSid), Str(arg_12_2._info._nameSid), var_0_0.ResultType.be_destroyed, var_12_6)
		end

		return var_0_0.ResultType.not_effect, var_12_6, arg_12_2
	end
end

function var_0_0.magicResult(arg_13_0, arg_13_1)
	if arg_13_1._type ~= Data.CardType.magic then
		return var_0_0.ResultType.not_viable
	end

	local var_13_0, var_13_1, var_13_2 = arg_13_0._player:canUseMagic(arg_13_1, true)

	if var_13_0 then
		local var_13_3 = Data._skillInfo[arg_13_1._skills[1]._id]

		if arg_13_0._isLog then
			lc.log("[AI] %s: result: %d, value: %d", Str(arg_13_1._info._nameSid), var_0_0.ResultType.magic_trap_effect, var_13_3._quality)
		end

		return var_0_0.ResultType.magic_trap_effect, var_13_3._quality, var_13_1, var_13_2
	else
		return var_0_0.ResultType.not_viable
	end
end

function var_0_0.trapResult(arg_14_0, arg_14_1)
	if arg_14_1._type ~= Data.CardType.trap then
		return var_0_0.ResultType.not_viable
	end

	local var_14_0, var_14_1, var_14_2 = arg_14_0._player:canUseTrap(arg_14_1, true)

	if var_14_0 then
		local var_14_3 = Data._skillInfo[arg_14_1._skills[1]._id]

		if arg_14_0._isLog then
			lc.log("[AI] %s: result: %d, value: %d", Str(arg_14_1._info._nameSid), var_0_0.ResultType.magic_trap_effect, var_14_3._quality)
		end

		return var_0_0.ResultType.magic_trap_effect, var_14_3._quality, var_14_1, var_14_2
	else
		return var_0_0.ResultType.not_viable
	end
end

function var_0_0.getAgainstSkill(arg_15_0, arg_15_1)
	local var_15_0
	local var_15_1 = {}

	if arg_15_1._type == Data.CardType.monster then
		for iter_15_0 = 1, #arg_15_1._skills do
			table.insert(var_15_1, Data._skillInfo[arg_15_1._skills[iter_15_0]._id])
		end
	else
		table.insert(var_15_1, Data._skillInfo[arg_15_1._info._skillId[1]])
	end

	for iter_15_1 = 1, #var_15_1 do
		for iter_15_2, iter_15_3 in ipairs(var_15_1[iter_15_1]._against) do
			if iter_15_3 ~= 0 and arg_15_0._oppo._skills[iter_15_3] ~= nil then
				local var_15_2 = Data._skillInfo[iter_15_3]

				if var_15_0 == nil or var_15_2._quality > var_15_0._quality then
					var_15_0 = var_15_2
				end
			end
		end
	end

	return var_15_0
end

function var_0_0.getUsingSkillValue(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._opponent._boardCards[arg_16_2]
	local var_16_1

	var_16_1 = var_16_0 ~= nil and not var_16_0:hasDefendRuseSkill()

	local var_16_2 = 0
	local var_16_3 = (arg_16_0._aliveCardCount > 0 and 1 or 0) + (B.isAlive(arg_16_0._player._boardCards[arg_16_2]) and arg_16_2 > 1 and 1 or 0)

	for iter_16_0 = 1, #arg_16_1._skills do
		local var_16_4 = arg_16_1._skills[iter_16_0]
		local var_16_5 = Data._skillInfo[var_16_4._id]

		if not var_16_5._val[math.min(var_16_4._level, #var_16_5._val)] then
			local var_16_6 = 0
		end

		var_16_2 = var_16_2 + (var_16_5._effectVal[math.min(var_16_4._level, #var_16_5._effectVal)] or 0)
	end

	return var_16_2
end

return var_0_0
