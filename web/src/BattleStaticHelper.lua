local var_0_0 = PlayerBattle

function var_0_0.createCard(arg_1_0, arg_1_1)
	local var_1_0 = BattleCard.new(arg_1_0, arg_1_1)

	var_1_0:resetOnce()

	var_1_0._status = BattleData.CardStatus.leave

	return var_1_0
end

function var_0_0.createCardByCopy(arg_2_0, arg_2_1)
	local var_2_0 = BattleCard.new(arg_2_0._infoId, arg_2_1, arg_2_0._owner)

	var_2_0:resetOnce()

	var_2_0._status = BattleData.CardStatus.leave

	return var_2_0
end

function var_0_0.createCardByEvent(arg_3_0)
	local var_3_0 = {
		_infoId = arg_3_0.c.id,
		_level = arg_3_0.c.lv or 1
	}

	if arg_3_0.w then
		var_3_0._weapon = {
			_infoId = arg_3_0.w.id,
			_level = arg_3_0.w.lv or 1,
			_newSkillId = arg_3_0.w.si or 0,
			_newSkillLevel = arg_3_0.w.sa or 1,
			_relation = {
				false,
				false,
				false
			}
		}
	end

	if arg_3_0.a then
		var_3_0._armor = {
			_infoId = arg_3_0.a.id,
			_level = arg_3_0.a.lv or 1,
			_newSkillId = arg_3_0.a.si or 0,
			_newSkillLevel = arg_3_0.a.sa or 1,
			_relation = {
				false,
				false,
				false
			}
		}
	end

	local var_3_1 = var_0_0.createCardByCopy(var_3_0, var_3_0._level, true, false)

	var_3_1._isFromEvent = true

	if arg_3_0.p then
		var_3_1._eventId = arg_3_0.p.p1 or 0
	end

	var_3_1._eventHero = arg_3_0.c.ti or 0

	return var_3_1
end

function var_0_0.createSkill(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Data._skillInfo[arg_4_0]

	return {
		_totalCastedTimes = 0,
		_castTimes = 0,
		_id = arg_4_0,
		_level = arg_4_1,
		_maxLevel = math.min(arg_4_1, CardHelper.getSkillMaxLevel(arg_4_0)),
		_modes = var_4_0._modes,
		_priority = var_4_0._priority,
		_count = var_4_0._count,
		_owner = arg_4_2
	}
end

function var_0_0.skillHasMode(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_0._modes do
		if arg_5_0._modes[iter_5_0] == arg_5_1 then
			return true
		end
	end

	if arg_5_1 == Data.SkillMode.bcs2gl or arg_5_1 == Data.SkillMode.sacrifice then
		return var_0_0.skillHasMode(arg_5_0, Data.SkillMode.bcs2_)
	elseif arg_5_1 == Data.SkillMode.g2b then
		return var_0_0.skillHasMode(arg_5_0, Data.SkillMode.using)
	elseif arg_5_1 == Data.SkillMode.g2h then
		return var_0_0.skillHasMode(arg_5_0, Data.SkillMode._2h)
	elseif arg_5_1 == Data.SkillMode.g2l_by_self or arg_5_1 == Data.SkillMode.g2l_by_oppo or arg_5_1 == Data.SkillMode.g2p then
		return var_0_0.skillHasMode(arg_5_0, Data.SkillMode.g2notbh)
	else
		return false
	end
end

function var_0_0.skillInfoHasMode(arg_6_0, arg_6_1)
	for iter_6_0 = 1, #arg_6_0._modes do
		if arg_6_0._modes[iter_6_0] == arg_6_1 then
			return true
		end
	end

	if arg_6_1 == Data.SkillMode.bcs2gl or arg_6_1 == Data.SkillMode.sacrifice then
		return var_0_0.skillInfoHasMode(arg_6_0, Data.SkillMode.bcs2_)
	elseif arg_6_1 == Data.SkillMode.g2b then
		return var_0_0.skillInfoHasMode(arg_6_0, Data.SkillMode.using)
	elseif arg_6_1 == Data.SkillMode.g2h then
		return var_0_0.skillInfoHasMode(arg_6_0, Data.SkillMode._2h)
	elseif arg_6_1 == Data.SkillMode.g2l_by_self or arg_6_1 == Data.SkillMode.g2l_by_oppo or arg_6_1 == Data.SkillMode.g2p then
		return var_0_0.skillInfoHasMode(arg_6_0, Data.SkillMode.g2notbh)
	else
		return false
	end
end

function var_0_0.skillInfoHasRemoveMode(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0._removeMode do
		if arg_7_0._removeMode[iter_7_0] == arg_7_1 then
			return true
		end
	end

	return false
end

function var_0_0.rareHasChoiceSkill(arg_8_0)
	local var_8_0 = Data._rareInfo[arg_8_0]

	for iter_8_0 = 1, #var_8_0._skillId do
		local var_8_1 = var_8_0._skillId[iter_8_0]

		if var_8_1 == 0 then
			break
		end

		local var_8_2 = Data._skillInfo[var_8_1]

		for iter_8_1 = 1, #var_8_2._modes do
			if var_8_2._modes[iter_8_1] == Data.SkillMode.choice then
				return true, var_8_1
			end
		end
	end

	return false
end

function var_0_0.isSkillChoiceSkill(arg_9_0)
	if arg_9_0._id == 3208 then
		return #arg_9_0._owner._owner._opponent:getBoardCards() > 0
	end

	return arg_9_0._id == 3037 or arg_9_0._id == 3098 or arg_9_0._id == 3108 or arg_9_0._id == 3119 or arg_9_0._id == 3491 or arg_9_0._id == 3592 or arg_9_0._id == 3612 or arg_9_0._id == 3635 or arg_9_0._id == 3651 or arg_9_0._id == 3778 or arg_9_0._id == 3825 or arg_9_0._id == 3865 or arg_9_0._id == 6810 or arg_9_0._id == 6812 or arg_9_0._id == 4081 or arg_9_0._id == 4199 or arg_9_0._id == 4271 or arg_9_0._id == 4377 or arg_9_0._id == 4388 or arg_9_0._id == 4399 or arg_9_0._id == 4496 or arg_9_0._id == 4534 or arg_9_0._id == 4576 or arg_9_0._id == 4602 or arg_9_0._id == 4739 or arg_9_0._id == 4762 or arg_9_0._id == 4953 or arg_9_0._id == 5069 or arg_9_0._id == 5081 or arg_9_0._id == 5118 or arg_9_0._id == 5302 or arg_9_0._id == 5378 or arg_9_0._id == 5396 or arg_9_0._id == 6724 or arg_9_0._id == 6911 or arg_9_0._id == 7641 or arg_9_0._id == 7655 or arg_9_0._id == 2191 or arg_9_0._id == 2193 or arg_9_0._id == 2383 or arg_9_0._id == 2499 or arg_9_0._id == 9479 or arg_9_0._id == 9854 or arg_9_0._id == 13043 or arg_9_0._id == 13913
end

function var_0_0.isSkillSiege(arg_10_0, arg_10_1)
	if not arg_10_1:canCastMonsterSkill(Data.SkillMode.before_attack) then
		return false
	end

	if arg_10_0 == 1005 or arg_10_0 == 1034 or arg_10_0 == 1038 or arg_10_0 == 1075 then
		return true
	end

	if arg_10_0 == 6136 or arg_10_0 == 6137 then
		local var_10_0 = Data._skillInfo[arg_10_0]
		local var_10_1 = arg_10_1._owner:getBattleCardsByInfoId("SD", var_10_0._refCards[2])
		local var_10_2 = arg_10_1._owner._opponent:getBattleCardsByKeyword("B", var_10_0._refCards[1])

		if (arg_10_0 == 6137 or #var_10_1 > 0) and #var_10_2 == 0 then
			return true
		end
	elseif arg_10_0 == 6553 then
		local var_10_3 = B.getMinAtkCard(arg_10_1._owner._opponent:getBoardCards())

		if var_10_3 ~= nil and var_10_3._atk >= arg_10_1._atk then
			return true
		end
	end

	return false
end

function var_0_0.isSkillCeremony(arg_11_0)
	return arg_11_0 == 4167 or arg_11_0 == 4168 or arg_11_0 == 4195 or arg_11_0 == 4196 or arg_11_0 == 4199 or arg_11_0 == 4203 or arg_11_0 == 4204 or arg_11_0 == 4214 or arg_11_0 == 4216 or arg_11_0 == 4218 or arg_11_0 == 4230 or arg_11_0 == 4231 or arg_11_0 == 4242 or arg_11_0 == 4299 or arg_11_0 == 4363 or arg_11_0 == 4382 or arg_11_0 == 4386 or arg_11_0 == 4388 or arg_11_0 == 4392 or arg_11_0 == 4393 or arg_11_0 == 4395 or arg_11_0 == 4460 or arg_11_0 == 4494 or arg_11_0 == 4498 or arg_11_0 == 4504 or arg_11_0 == 4528 or arg_11_0 == 4573 or arg_11_0 == 4576 or arg_11_0 == 4585 or arg_11_0 == 4597 or arg_11_0 == 4646 or arg_11_0 == 4648 or arg_11_0 == 4741 or arg_11_0 == 4956 or arg_11_0 == 7576
end

function var_0_0.throwCoin(arg_12_0)
	local var_12_0 = arg_12_0._owner
	local var_12_1 = 0.5

	if var_12_0._status ~= BattleData.Status.round_end and var_12_0:hasBattleCardsBySkillFast("S", 7078) then
		var_12_1 = 0.75
	end

	return var_12_1 >= var_12_0:getRandom() and 1 or 0
end

function var_0_0.throwCoins(arg_13_0, arg_13_1)
	local var_13_0 = 0

	for iter_13_0 = 1, arg_13_1 do
		var_13_0 = var_13_0 * 2 + B.throwCoin(arg_13_0)
	end

	return var_13_0
end

function var_0_0.getCoinsFaceCount(arg_14_0)
	local var_14_0 = 0

	for iter_14_0 = 1, 255 do
		local var_14_1 = 2^(iter_14_0 - 1)

		if band(arg_14_0, var_14_1) ~= 0 then
			var_14_0 = var_14_0 + 1
		end

		if arg_14_0 < var_14_1 then
			break
		end
	end

	return var_14_0
end

function var_0_0.throwDice(arg_15_0)
	local var_15_0 = {
		1,
		2,
		3,
		4,
		5,
		6
	}

	if arg_15_0._owner:hasBattleCardsBySkillFast("S", 8141) or arg_15_0._owner._opponent:hasBattleCardsBySkillFast("S", 8141) then
		var_15_0 = {
			1,
			6
		}
	end

	return arg_15_0._owner:randomOne(var_15_0)
end

function var_0_0.throwDices(arg_16_0, arg_16_1)
	local var_16_0 = 0

	for iter_16_0 = 1, arg_16_1 do
		var_16_0 = var_16_0 * 10 + B.throwDice(arg_16_0)
	end

	return var_16_0
end

function var_0_0.getDicesResult(arg_17_0)
	local var_17_0 = {}

	for iter_17_0 = 1, 255 do
		local var_17_1 = arg_17_0 % 10

		var_17_0[#var_17_0 + 1] = var_17_1
		arg_17_0 = math.floor(arg_17_0 / 10)

		if arg_17_0 == 0 then
			break
		end
	end

	return var_17_0
end

function var_0_0.getShieldTypeBySkillId(arg_18_0, arg_18_1)
	local var_18_0

	if arg_18_0 == 12006 then
		var_18_0 = arg_18_1 and BattleData.PositiveType.shieldHaloDestroy or BattleData.PositiveType.shieldDestroy
	elseif arg_18_0 == 12007 then
		var_18_0 = arg_18_1 and BattleData.PositiveType.shieldHaloEffectDestroy or BattleData.PositiveType.shieldEffectDestroy
	elseif arg_18_0 >= 12008 then
		var_18_0 = (arg_18_1 and BattleData.PositiveType.shieldHaloOppoMonster or BattleData.PositiveType.shieldOppoMonster) + arg_18_0 - 12008
	else
		var_18_0 = arg_18_0 < 12000 and BattleData.PositiveType.shieldBegin + arg_18_0 - 11001 or (arg_18_1 and BattleData.PositiveType.shieldHaloBegin or BattleData.PositiveType.shieldExBegin) + arg_18_0 - 12001
	end

	return var_18_0
end

function var_0_0.getSkillIdByShieldType(arg_19_0)
	if arg_19_0 == BattleData.PositiveType.shieldDestroy or shiledType == BattleData.PositiveType.shieldHaloDestroy then
		return 12006
	elseif arg_19_0 == BattleData.PositiveType.shieldEffectDestroy or shiledType == BattleData.PositiveType.shieldHaloEffectDestroy then
		return 12007
	elseif arg_19_0 == BattleData.PositiveType.shieldOppoMonster or shiledType == BattleData.PositiveType.shieldHaloOppoMonster then
		return 12008
	elseif arg_19_0 == BattleData.PositiveType.shieldOppoMagic or shiledType == BattleData.PositiveType.shieldHaloOppoMagic then
		return 12009
	elseif arg_19_0 == BattleData.PositiveType.shieldOppoTrap or shiledType == BattleData.PositiveType.shieldHaloOppoTrap then
		return 12010
	elseif arg_19_0 >= BattleData.PositiveType.shieldBegin and arg_19_0 <= BattleData.PositiveType.shieldEnd then
		return 11001 + arg_19_0 - BattleData.PositiveType.shieldBegin
	elseif arg_19_0 >= BattleData.PositiveType.shieldExBegin and arg_19_0 <= BattleData.PositiveType.shieldExEnd then
		return 12001 + arg_19_0 - BattleData.PositiveType.shieldExBegin
	elseif arg_19_0 >= BattleData.PositiveType.shieldHaloBegin and arg_19_0 <= BattleData.PositiveType.shieldHaloEnd then
		return 12001 + arg_19_0 - BattleData.PositiveType.shieldHaloBegin
	end
end

function var_0_0.isAlive(arg_20_0)
	return arg_20_0 ~= nil and arg_20_0:isAlive() or false
end

function var_0_0.getMaxHpCard(arg_21_0)
	local var_21_0
	local var_21_1 = -1

	for iter_21_0 = 1, #arg_21_0 do
		local var_21_2 = arg_21_0[iter_21_0]

		if var_21_2._hp ~= nil and var_21_1 < var_21_2._hp then
			var_21_0 = var_21_2
			var_21_1 = var_21_2._hp
		end
	end

	return var_21_0
end

function var_0_0.getMinHpCard(arg_22_0, arg_22_1)
	local var_22_0
	local var_22_1 = 2147483647

	for iter_22_0 = 1, #arg_22_0 do
		local var_22_2 = arg_22_0[iter_22_0]

		if var_22_2._hp ~= nil and var_22_1 > var_22_2._hp and (not arg_22_1 or var_22_2._hp < var_22_2._maxHp + var_22_2._haloedMaxHpInc) then
			var_22_0 = var_22_2
			var_22_1 = var_22_2._hp
		end
	end

	return var_22_0
end

function var_0_0.getMaxAtkCard(arg_23_0)
	local var_23_0
	local var_23_1 = -1

	for iter_23_0 = 1, #arg_23_0 do
		local var_23_2 = arg_23_0[iter_23_0]

		if var_23_2._atk ~= nil and var_23_1 < var_23_2._atk then
			var_23_0 = var_23_2
			var_23_1 = var_23_2._atk
		end
	end

	return var_23_0
end

function var_0_0.getMinAtkCard(arg_24_0)
	local var_24_0
	local var_24_1 = 2147483647

	for iter_24_0 = 1, #arg_24_0 do
		local var_24_2 = arg_24_0[iter_24_0]

		if var_24_2._atk ~= nil and var_24_1 > var_24_2._atk then
			var_24_0 = var_24_2
			var_24_1 = var_24_2._atk
		end
	end

	return var_24_0
end

function var_0_0.getMaxOriginAtkCard(arg_25_0)
	local var_25_0
	local var_25_1 = -1

	for iter_25_0 = 1, #arg_25_0 do
		local var_25_2 = arg_25_0[iter_25_0]

		if var_25_2._maxAtk ~= nil and var_25_1 < var_25_2._maxAtk then
			var_25_0 = var_25_2
			var_25_1 = var_25_2._maxAtk
		end
	end

	return var_25_0
end

function var_0_0.getMaxPositiveCard(arg_26_0)
	local var_26_0
	local var_26_1 = 0

	for iter_26_0 = 1, #arg_26_0 do
		local var_26_2 = arg_26_0[iter_26_0]
		local var_26_3 = math.max(0, math.max(var_26_2._maxHpInc, var_26_2._maxAtkInc))

		for iter_26_1 = BattleData.PositiveType.shieldBegin, BattleData.PositiveType.shieldEnd do
			var_26_3 = math.max(var_26_3, var_26_2:getBuffValue(true, iter_26_1) * 10)
		end

		if var_26_1 < var_26_3 then
			var_26_0 = var_26_2
			var_26_1 = var_26_3
		end
	end

	return var_26_0, var_26_1
end

function var_0_0.getMaxStarCard(arg_27_0)
	local var_27_0
	local var_27_1 = -1

	for iter_27_0 = 1, #arg_27_0 do
		local var_27_2 = arg_27_0[iter_27_0]
		local var_27_3 = var_27_2:getStar()

		if var_27_3 ~= nil and var_27_1 < var_27_3 then
			var_27_0 = var_27_2
			var_27_1 = var_27_3
		end
	end

	return var_27_0
end

function var_0_0.getMinStarCard(arg_28_0)
	local var_28_0
	local var_28_1 = 255

	for iter_28_0 = 1, #arg_28_0 do
		local var_28_2 = arg_28_0[iter_28_0]
		local var_28_3 = var_28_2:getStar()

		if var_28_3 ~= nil and var_28_3 < var_28_1 then
			var_28_0 = var_28_2
			var_28_1 = var_28_3
		end
	end

	return var_28_0
end

function var_0_0.getMaxXYZStarCard(arg_29_0)
	local var_29_0
	local var_29_1 = -1

	for iter_29_0 = 1, #arg_29_0 do
		local var_29_2 = arg_29_0[iter_29_0]
		local var_29_3 = var_29_2._info._star

		if var_29_3 ~= nil and var_29_1 < var_29_3 then
			var_29_0 = var_29_2
			var_29_1 = var_29_3
		end
	end

	return var_29_0
end

function var_0_0.getNatureCount(arg_30_0)
	local var_30_0 = 0
	local var_30_1 = {}

	for iter_30_0 = 1, #arg_30_0 do
		local var_30_2 = arg_30_0[iter_30_0]._info._nature

		if var_30_2 ~= nil and var_30_1[var_30_2] == nil then
			var_30_0 = var_30_0 + 1
			var_30_1[var_30_2] = true
		end
	end

	return var_30_0
end

function var_0_0.getMaxSameNameCardsCount(arg_31_0)
	local var_31_0 = 0

	for iter_31_0 = 1, #arg_31_0 do
		local var_31_1 = B.filterSameNameCards(arg_31_0, arg_31_0[iter_31_0])

		if var_31_0 < #var_31_1 then
			var_31_0 = #var_31_1
		end
	end

	return var_31_0
end

function var_0_0.getMaxQualityCard(arg_32_0)
	local var_32_0
	local var_32_1 = -1

	for iter_32_0 = 1, #arg_32_0 do
		local var_32_2 = arg_32_0[iter_32_0]

		if var_32_2._info._quality ~= nil and var_32_1 < var_32_2._info._quality then
			var_32_0 = var_32_2
			var_32_1 = var_32_2._info._quality
		end
	end

	return var_32_0 or arg_32_0[1]
end

function var_0_0.sortCardsByAtk(arg_33_0)
	local var_33_0 = {}

	for iter_33_0 = 1, #arg_33_0 do
		var_33_0[#var_33_0 + 1] = arg_33_0[iter_33_0]
	end

	table.sort(var_33_0, function(arg_34_0, arg_34_1)
		if arg_34_0._atk ~= nil and arg_34_1._atk == nil then
			return true
		elseif arg_34_0._atk == nil and arg_34_1._atk ~= nil then
			return false
		elseif arg_34_0._atk == nil and arg_34_1._atk == nil then
			return arg_34_0._id < arg_34_1._id
		elseif arg_34_0._atk > arg_34_1._atk then
			return true
		elseif arg_34_0._atk < arg_34_1._atk then
			return false
		elseif arg_34_0._hp > arg_34_1._hp then
			return true
		elseif arg_34_0._hp < arg_34_1._hp then
			return false
		else
			return arg_34_0._id < arg_34_1._id
		end
	end)

	return var_33_0
end

function var_0_0.sortCardsByStar(arg_35_0)
	local var_35_0 = {}

	for iter_35_0 = 1, #arg_35_0 do
		if arg_35_0[iter_35_0]:getStar() ~= Data.XYZ_STAR and arg_35_0[iter_35_0]:getStar() > 0 then
			var_35_0[#var_35_0 + 1] = arg_35_0[iter_35_0]
		end
	end

	table.sort(var_35_0, function(arg_36_0, arg_36_1)
		local var_36_0 = arg_36_0:getStar()
		local var_36_1 = arg_36_1:getStar()

		if var_36_1 < var_36_0 then
			return true
		elseif var_36_0 < var_36_1 then
			return false
		elseif arg_36_0._atk > arg_36_1._atk then
			return true
		elseif arg_36_0._atk < arg_36_1._atk then
			return false
		elseif arg_36_0._hp > arg_36_1._hp then
			return true
		elseif arg_36_0._hp < arg_36_1._hp then
			return false
		else
			return arg_36_0._id < arg_36_1._id
		end
	end)

	return var_35_0
end

function var_0_0.sortCardsByBoardPos(arg_37_0)
	local var_37_0 = {}

	for iter_37_0 = 1, #arg_37_0 do
		var_37_0[#var_37_0 + 1] = arg_37_0[iter_37_0]
	end

	local var_37_1 = arg_37_0[1] and arg_37_0[1]._owner._isAttacker == B._isAttackerController and {
		3,
		4,
		2,
		5,
		1,
		6
	} or {
		3,
		2,
		4,
		1,
		5,
		6
	}

	table.sort(var_37_0, function(arg_38_0, arg_38_1)
		if arg_38_0._status == arg_38_1._status then
			if arg_38_0._status == BattleData.CardStatus.board then
				return var_37_1[arg_38_0._pos] < var_37_1[arg_38_1._pos]
			elseif arg_38_0._status == BattleData.CardStatus.pile or arg_38_0._status == BattleData.CardStatus.leave then
				if arg_38_0._infoId == arg_38_1._infoId then
					return arg_38_0._id < arg_38_1._id
				else
					return arg_38_0._infoId < arg_38_1._infoId
				end

				return arg_38_0._pos < arg_38_1._pos
			else
				return arg_38_0._pos < arg_38_1._pos
			end
		elseif arg_38_0._status == BattleData.CardStatus.grave then
			return true
		elseif arg_38_1._status == BattleData.CardStatus.grave then
			return false
		elseif arg_38_0._status == BattleData.CardStatus.pile then
			return true
		elseif arg_38_1._status == BattleData.CardStatus.pile then
			return false
		elseif arg_38_0._status == BattleData.CardStatus.hand then
			return true
		elseif arg_38_1._status == BattleData.CardStatus.hand then
			return false
		elseif arg_38_0._status == BattleData.CardStatus.show then
			return true
		elseif arg_38_1._status == BattleData.CardStatus.show then
			return false
		elseif arg_38_0._status == BattleData.CardStatus.field then
			return true
		elseif arg_38_1._status == BattleData.CardStatus.field then
			return false
		elseif arg_38_0._status == BattleData.CardStatus.cover then
			return true
		elseif arg_38_1._status == BattleData.CardStatus.cover then
			return false
		elseif arg_38_0._status == BattleData.CardStatus.leave then
			return true
		elseif arg_38_1._status == BattleData.CardStatus.leave then
			return false
		end
	end)

	return var_37_0
end

function var_0_0.sortCardsByOwnerAndBoardPos(arg_39_0, arg_39_1)
	local var_39_0 = {}

	for iter_39_0 = 1, #arg_39_0 do
		var_39_0[#var_39_0 + 1] = arg_39_0[iter_39_0]
	end

	local var_39_1 = arg_39_0[1] and arg_39_0[1]._owner._isAttacker == B._isAttackerController and {
		3,
		4,
		2,
		5,
		1,
		6
	} or {
		3,
		2,
		4,
		1,
		5,
		6
	}

	table.sort(var_39_0, function(arg_40_0, arg_40_1)
		if arg_40_0._owner._isAttacker and not arg_40_1._owner._isAttacker then
			return arg_39_1
		elseif not arg_40_0._owner._isAttacker and arg_40_1._owner._isAttacker then
			return not arg_39_1
		elseif arg_40_0._status == arg_40_1._status then
			if arg_40_0._status == BattleData.CardStatus.board then
				return var_39_1[arg_40_0._pos] < var_39_1[arg_40_1._pos]
			elseif arg_40_0._status == BattleData.CardStatus.pile or arg_40_0._status == BattleData.CardStatus.leave then
				if arg_40_0._infoId == arg_40_1._infoId then
					return arg_40_0._id < arg_40_1._id
				else
					return arg_40_0._infoId < arg_40_1._infoId
				end

				return arg_40_0._pos < arg_40_1._pos
			else
				return arg_40_0._pos < arg_40_1._pos
			end
		elseif arg_40_0._status == BattleData.CardStatus.grave then
			return true
		elseif arg_40_1._status == BattleData.CardStatus.grave then
			return false
		elseif arg_40_0._status == BattleData.CardStatus.pile then
			return true
		elseif arg_40_1._status == BattleData.CardStatus.pile then
			return false
		elseif arg_40_0._status == BattleData.CardStatus.hand then
			return true
		elseif arg_40_1._status == BattleData.CardStatus.hand then
			return false
		elseif arg_40_0._status == BattleData.CardStatus.show then
			return true
		elseif arg_40_1._status == BattleData.CardStatus.show then
			return false
		elseif arg_40_0._status == BattleData.CardStatus.field then
			return true
		elseif arg_40_1._status == BattleData.CardStatus.field then
			return false
		elseif arg_40_0._status == BattleData.CardStatus.cover then
			return true
		elseif arg_40_1._status == BattleData.CardStatus.cover then
			return false
		elseif arg_40_0._status == BattleData.CardStatus.leave then
			return true
		elseif arg_40_1._status == BattleData.CardStatus.leave then
			return false
		end
	end)

	return var_39_0
end

function var_0_0.splitCardsByCategory(arg_41_0)
	local var_41_0 = {}

	for iter_41_0 = 1, #arg_41_0 do
		local var_41_1 = arg_41_0[iter_41_0]
		local var_41_2 = var_41_1._info._category

		if var_41_0[var_41_2] ~= nil then
			var_41_0[var_41_2][#var_41_0[var_41_2] + 1] = var_41_1
		else
			var_41_0[var_41_2] = {
				var_41_1
			}
		end
	end

	return var_41_0
end

function var_0_0.filterInInfoIdCards(arg_42_0, arg_42_1)
	local var_42_0 = {}

	for iter_42_0 = 1, #arg_42_0 do
		local var_42_1 = arg_42_0[iter_42_0]

		if var_42_1:isInfoId(arg_42_1) then
			var_42_0[#var_42_0 + 1] = var_42_1
		end
	end

	return var_42_0
end

function var_0_0.filterInInfoIdGroupCards(arg_43_0, arg_43_1)
	local var_43_0 = {}

	for iter_43_0 = 1, #arg_43_0 do
		local var_43_1 = arg_43_0[iter_43_0]

		if var_43_1:isInInfoIdGroup(arg_43_1) then
			var_43_0[#var_43_0 + 1] = var_43_1
		end
	end

	return var_43_0
end

function var_0_0.filterInTypeCards(arg_44_0, arg_44_1)
	local var_44_0 = {}

	for iter_44_0 = 1, #arg_44_0 do
		local var_44_1 = arg_44_0[iter_44_0]

		if var_44_1._type == arg_44_1 then
			var_44_0[#var_44_0 + 1] = var_44_1
		end
	end

	return var_44_0
end

function var_0_0.filterInTypeGroupCards(arg_45_0, arg_45_1)
	local var_45_0 = {}

	for iter_45_0 = 1, #arg_45_0 do
		local var_45_1 = arg_45_0[iter_45_0]

		for iter_45_1 = 1, #arg_45_1 do
			if var_45_1._type == arg_45_1[iter_45_1] then
				var_45_0[#var_45_0 + 1] = var_45_1

				break
			end
		end
	end

	return var_45_0
end

function var_0_0.filterInCategoryCards(arg_46_0, arg_46_1)
	local var_46_0 = {}

	for iter_46_0 = 1, #arg_46_0 do
		local var_46_1 = arg_46_0[iter_46_0]

		if var_46_1._info._category == arg_46_1 then
			var_46_0[#var_46_0 + 1] = var_46_1
		end
	end

	return var_46_0
end

function var_0_0.filterInCategoryGroupCards(arg_47_0, arg_47_1)
	local var_47_0 = {}

	for iter_47_0 = 1, #arg_47_0 do
		local var_47_1 = arg_47_0[iter_47_0]

		for iter_47_1 = 1, #arg_47_1 do
			if var_47_1._info._category == arg_47_1[iter_47_1] then
				var_47_0[#var_47_0 + 1] = var_47_1

				break
			end
		end
	end

	return var_47_0
end

function var_0_0.filterNotInCategoryCards(arg_48_0, arg_48_1)
	local var_48_0 = {}

	for iter_48_0 = 1, #arg_48_0 do
		local var_48_1 = arg_48_0[iter_48_0]

		if var_48_1._info._category ~= arg_48_1 then
			var_48_0[#var_48_0 + 1] = var_48_1
		end
	end

	return var_48_0
end

function var_0_0.filterInNatureCards(arg_49_0, arg_49_1)
	local var_49_0 = {}

	for iter_49_0 = 1, #arg_49_0 do
		local var_49_1 = arg_49_0[iter_49_0]

		if var_49_1:isNature(arg_49_1) then
			var_49_0[#var_49_0 + 1] = var_49_1
		end
	end

	return var_49_0
end

function var_0_0.filterInNatureGroupCards(arg_50_0, arg_50_1)
	local var_50_0 = {}

	for iter_50_0 = 1, #arg_50_0 do
		local var_50_1 = arg_50_0[iter_50_0]

		if var_50_1:isNatureGroup(arg_50_1) then
			var_50_0[#var_50_0 + 1] = var_50_1
		end
	end

	return var_50_0
end

function var_0_0.filterNotInNatureCards(arg_51_0, arg_51_1)
	local var_51_0 = {}

	for iter_51_0 = 1, #arg_51_0 do
		local var_51_1 = arg_51_0[iter_51_0]

		if not var_51_1:isNature(arg_51_1) then
			var_51_0[#var_51_0 + 1] = var_51_1
		end
	end

	return var_51_0
end

function var_0_0.filterSameNatureCards(arg_52_0, arg_52_1)
	local var_52_0 = {}

	for iter_52_0 = 1, #arg_52_0 do
		local var_52_1 = arg_52_0[iter_52_0]

		if var_52_1:isSameNatureWith(arg_52_1) then
			var_52_0[#var_52_0 + 1] = var_52_1
		end
	end

	return var_52_0
end

function var_0_0.filterNotSameNatureCardsMulti(arg_53_0, arg_53_1)
	local var_53_0 = {}

	for iter_53_0 = 1, #arg_53_0 do
		local var_53_1 = arg_53_0[iter_53_0]
		local var_53_2 = false

		for iter_53_1 = 1, #arg_53_1 do
			if var_53_1:isSameNatureWith(arg_53_1[iter_53_1]) then
				var_53_2 = true

				break
			end
		end

		if not var_53_2 then
			var_53_0[#var_53_0 + 1] = var_53_1
		end
	end

	return var_53_0
end

function var_0_0.filterInKeywordCards(arg_54_0, arg_54_1)
	local var_54_0 = {}

	for iter_54_0 = 1, #arg_54_0 do
		local var_54_1 = arg_54_0[iter_54_0]

		if var_54_1:isKeyword(arg_54_1) then
			var_54_0[#var_54_0 + 1] = var_54_1
		end
	end

	return var_54_0
end

function var_0_0.filterInKeywordGroupCards(arg_55_0, arg_55_1)
	local var_55_0 = {}

	for iter_55_0 = 1, #arg_55_0 do
		local var_55_1 = arg_55_0[iter_55_0]

		if var_55_1:isKeywordGroup(arg_55_1) then
			var_55_0[#var_55_0 + 1] = var_55_1
		end
	end

	return var_55_0
end

function var_0_0.filterNotInKeywordCards(arg_56_0, arg_56_1)
	local var_56_0 = {}

	for iter_56_0 = 1, #arg_56_0 do
		local var_56_1 = arg_56_0[iter_56_0]

		if not var_56_1:isKeyword(arg_56_1) then
			var_56_0[#var_56_0 + 1] = var_56_1
		end
	end

	return var_56_0
end

function var_0_0.filterInStarCards(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = {}

	for iter_57_0 = 1, #arg_57_0 do
		local var_57_1 = arg_57_0[iter_57_0]

		if var_57_1 ~= arg_57_2 and var_57_1:getStar() == arg_57_1 then
			var_57_0[#var_57_0 + 1] = var_57_1
		end
	end

	return var_57_0
end

function var_0_0.filterNotInStarCards(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = {}

	for iter_58_0 = 1, #arg_58_0 do
		local var_58_1 = arg_58_0[iter_58_0]

		if var_58_1 ~= arg_58_2 and var_58_1:getStar() ~= arg_58_1 then
			var_58_0[#var_58_0 + 1] = var_58_1
		end
	end

	return var_58_0
end

function var_0_0.filterLessThanStarCards(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = {}

	for iter_59_0 = 1, #arg_59_0 do
		local var_59_1 = arg_59_0[iter_59_0]

		if var_59_1 ~= arg_59_2 and arg_59_1 >= var_59_1:getStar() then
			var_59_0[#var_59_0 + 1] = var_59_1
		end
	end

	return var_59_0
end

function var_0_0.filterMoreThanStarCards(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = {}

	for iter_60_0 = 1, #arg_60_0 do
		local var_60_1 = arg_60_0[iter_60_0]

		if var_60_1 ~= arg_60_2 and var_60_1:getStar() ~= Data.XYZ_STAR and arg_60_1 <= var_60_1:getStar() then
			var_60_0[#var_60_0 + 1] = var_60_1
		end
	end

	return var_60_0
end

function var_0_0.filterUniqueStarCards(arg_61_0, arg_61_1)
	local var_61_0 = {}
	local var_61_1 = {}

	for iter_61_0 = 1, #arg_61_0 do
		local var_61_2 = arg_61_0[iter_61_0]
		local var_61_3 = var_61_2:getStar()

		if var_61_2 ~= arg_61_1 and var_61_3 ~= Data.XYZ_STAR and var_61_1[var_61_3] == nil then
			var_61_1[var_61_3] = true
			var_61_0[#var_61_0 + 1] = var_61_2
		end
	end

	return var_61_0
end

function var_0_0.filterInStatusCards(arg_62_0, arg_62_1)
	local var_62_0 = {}

	for iter_62_0 = 1, #arg_62_0 do
		local var_62_1 = arg_62_0[iter_62_0]

		if var_62_1._status == arg_62_1 then
			var_62_0[#var_62_0 + 1] = var_62_1
		end
	end

	return var_62_0
end

function var_0_0.filterNotInStatusCards(arg_63_0, arg_63_1)
	local var_63_0 = {}

	for iter_63_0 = 1, #arg_63_0 do
		local var_63_1 = arg_63_0[iter_63_0]

		if var_63_1._status ~= arg_63_1 then
			var_63_0[#var_63_0 + 1] = var_63_1
		end
	end

	return var_63_0
end

function var_0_0.filterInSuperIdCards(arg_64_0, arg_64_1)
	local var_64_0 = {}

	for iter_64_0 = 1, #arg_64_0 do
		local var_64_1 = arg_64_0[iter_64_0]

		if var_64_1:isSuperId(arg_64_1) then
			var_64_0[#var_64_0 + 1] = var_64_1
		end
	end

	return var_64_0
end

function var_0_0.filterNotInSuperIdCards(arg_65_0, arg_65_1)
	local var_65_0 = {}

	for iter_65_0 = 1, #arg_65_0 do
		local var_65_1 = arg_65_0[iter_65_0]

		if not var_65_1:isSuperId(arg_65_1) then
			var_65_0[#var_65_0 + 1] = var_65_1
		end
	end

	return var_65_0
end

function var_0_0.filterAtkEqualCards(arg_66_0, arg_66_1)
	local var_66_0 = {}

	for iter_66_0 = 1, #arg_66_0 do
		local var_66_1 = arg_66_0[iter_66_0]

		if var_66_1._atk == arg_66_1 then
			var_66_0[#var_66_0 + 1] = var_66_1
		end
	end

	return var_66_0
end

function var_0_0.filterDefEqualCards(arg_67_0, arg_67_1)
	local var_67_0 = {}

	for iter_67_0 = 1, #arg_67_0 do
		local var_67_1 = arg_67_0[iter_67_0]

		if not var_67_1:isLink() and var_67_1._hp == arg_67_1 then
			var_67_0[#var_67_0 + 1] = var_67_1
		end
	end

	return var_67_0
end

function var_0_0.filterAtkOrDefEqualCards(arg_68_0, arg_68_1)
	local var_68_0 = {}

	for iter_68_0 = 1, #arg_68_0 do
		local var_68_1 = arg_68_0[iter_68_0]

		if var_68_1._atk == arg_68_1 or var_68_1._hp == arg_68_1 then
			var_68_0[#var_68_0 + 1] = var_68_1
		end
	end

	return var_68_0
end

function var_0_0.filterAtkLessThanCards(arg_69_0, arg_69_1)
	local var_69_0 = {}

	for iter_69_0 = 1, #arg_69_0 do
		local var_69_1 = arg_69_0[iter_69_0]

		if var_69_1._atk ~= nil and arg_69_1 >= var_69_1._atk then
			var_69_0[#var_69_0 + 1] = var_69_1
		end
	end

	return var_69_0
end

function var_0_0.filterDefLessThanCards(arg_70_0, arg_70_1)
	local var_70_0 = {}

	for iter_70_0 = 1, #arg_70_0 do
		local var_70_1 = arg_70_0[iter_70_0]

		if not var_70_1:isLink() and var_70_1._hp ~= nil and arg_70_1 >= var_70_1._hp then
			var_70_0[#var_70_0 + 1] = var_70_1
		end
	end

	return var_70_0
end

function var_0_0.filterOriginAtkLessThanCards(arg_71_0, arg_71_1)
	local var_71_0 = {}

	for iter_71_0 = 1, #arg_71_0 do
		local var_71_1 = arg_71_0[iter_71_0]

		if not var_71_1:isAtkHide() and var_71_1._maxAtk ~= nil and arg_71_1 >= var_71_1._maxAtk then
			var_71_0[#var_71_0 + 1] = var_71_1
		end
	end

	return var_71_0
end

function var_0_0.filterOriginDefLessThanCards(arg_72_0, arg_72_1)
	local var_72_0 = {}

	for iter_72_0 = 1, #arg_72_0 do
		local var_72_1 = arg_72_0[iter_72_0]

		if not var_72_1:isLink() and not var_72_1:isDefHide() and var_72_1._maxHp ~= nil and arg_72_1 >= var_72_1._maxHp then
			var_72_0[#var_72_0 + 1] = var_72_1
		end
	end

	return var_72_0
end

function var_0_0.filterAtkMoreDefLessCards(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = {}

	for iter_73_0 = 1, #arg_73_0 do
		local var_73_1 = arg_73_0[iter_73_0]

		if not var_73_1:isLink() and not var_73_1:isAtkHide() and var_73_1._maxAtk ~= nil and arg_73_1 <= var_73_1._maxAtk and not var_73_1:isDefHide() and var_73_1._maxHp ~= nil and arg_73_2 >= var_73_1._maxHp then
			var_73_0[#var_73_0 + 1] = var_73_1
		end
	end

	return var_73_0
end

function var_0_0.filterDifAtkMaxAtkCards(arg_74_0)
	local var_74_0 = {}

	for iter_74_0 = 1, #arg_74_0 do
		local var_74_1 = arg_74_0[iter_74_0]

		if var_74_1._atk ~= var_74_1._maxAtk then
			var_74_0[#var_74_0 + 1] = var_74_1
		end
	end

	return var_74_0
end

function var_0_0.filterOriginAtkLessThanAtkCards(arg_75_0)
	local var_75_0 = {}

	for iter_75_0 = 1, #arg_75_0 do
		local var_75_1 = arg_75_0[iter_75_0]

		if not var_75_1:isAtkHide() and var_75_1._maxAtk ~= nil and var_75_1._maxAtk < var_75_1._atk then
			var_75_0[#var_75_0 + 1] = var_75_1
		end
	end

	return var_75_0
end

function var_0_0.filterAtkHideCards(arg_76_0, arg_76_1)
	local var_76_0 = {}

	for iter_76_0 = 1, #arg_76_0 do
		local var_76_1 = arg_76_0[iter_76_0]

		if var_76_1:isAtkHide() == arg_76_1 then
			var_76_0[#var_76_0 + 1] = var_76_1
		end
	end

	return var_76_0
end

function var_0_0.filterBindedCards(arg_77_0)
	local var_77_0 = {}

	for iter_77_0 = 1, #arg_77_0 do
		local var_77_1 = arg_77_0[iter_77_0]

		if #var_77_1._binds > 0 then
			var_77_0[#var_77_0 + 1] = var_77_1
		end
	end

	return var_77_0
end

function var_0_0.filterNotBindedCards(arg_78_0, arg_78_1, arg_78_2)
	local var_78_0 = {}

	for iter_78_0 = 1, #arg_78_0 do
		local var_78_1 = arg_78_0[iter_78_0]

		if (not arg_78_2 or not var_78_1:hasShieldInType(BattleData.PositiveType.shieldMagic, true) and not var_78_1:hasSkills({
			6009
		})) and not var_78_1:isBinded(arg_78_1) then
			var_78_0[#var_78_0 + 1] = var_78_1
		end
	end

	return var_78_0
end

function var_0_0.filterNotBindedInfoIdGroupCards(arg_79_0, arg_79_1, arg_79_2)
	local var_79_0 = {}

	for iter_79_0 = 1, #arg_79_0 do
		local var_79_1 = arg_79_0[iter_79_0]

		if (not arg_79_2 or not var_79_1:hasShieldInType(BattleData.PositiveType.shieldMagic, true) and not var_79_1:hasSkills({
			6009
		})) and not var_79_1:isBindedInfoIdGroup(arg_79_1) then
			var_79_0[#var_79_0 + 1] = var_79_1
		end
	end

	return var_79_0
end

function var_0_0.filterNotBindedAllInfoIdGroupCards(arg_80_0, arg_80_1, arg_80_2)
	local var_80_0 = {}

	for iter_80_0 = 1, #arg_80_0 do
		local var_80_1 = arg_80_0[iter_80_0]

		if (not arg_80_2 or not var_80_1:hasShieldInType(BattleData.PositiveType.shieldMagic, true) and not var_80_1:hasSkills({
			6009
		})) and not var_80_1:isBindedAllInfoIdGroup(arg_80_1) then
			var_80_0[#var_80_0 + 1] = var_80_1
		end
	end

	return var_80_0
end

function var_0_0.filterNotBindedSameNameCards(arg_81_0, arg_81_1, arg_81_2)
	local var_81_0 = {}

	for iter_81_0 = 1, #arg_81_0 do
		local var_81_1 = arg_81_0[iter_81_0]

		if (not arg_81_2 or not var_81_1:hasShieldInType(BattleData.PositiveType.shieldMagic, true) and not var_81_1:hasSkills({
			6009
		})) and not var_81_1:isBindedSameNameCard(arg_81_1) then
			var_81_0[#var_81_0 + 1] = var_81_1
		end
	end

	return var_81_0
end

function var_0_0.filterBindedKeywordEquipCards(arg_82_0, arg_82_1)
	local var_82_0 = {}

	for iter_82_0 = 1, #arg_82_0 do
		local var_82_1 = arg_82_0[iter_82_0]

		if var_82_1:isBindedKeywordEquip(arg_82_1) then
			var_82_0[#var_82_0 + 1] = var_82_1
		end
	end

	return var_82_0
end

function var_0_0.filterNotBindedAllyEquipCards(arg_83_0, arg_83_1)
	local var_83_0 = {}

	for iter_83_0 = 1, #arg_83_0 do
		local var_83_1 = arg_83_0[iter_83_0]

		if (not arg_83_1 or not var_83_1:hasShieldInType(BattleData.PositiveType.shieldMagic) and not var_83_1:hasSkills({
			6009
		})) and not var_83_1:isBindedAllyEquip() then
			var_83_0[#var_83_0 + 1] = var_83_1
		end
	end

	return var_83_0
end

function var_0_0.filterCanBindMagicCards(arg_84_0, arg_84_1)
	local var_84_0 = {}

	for iter_84_0 = 1, #arg_84_0 do
		local var_84_1 = arg_84_0[iter_84_0]._infoId

		if not arg_84_1:isBinded(var_84_1) and (not arg_84_0[iter_84_0]:hasSkillFast(7156) or not (#arg_84_0[iter_84_0]._owner:getBattleCardsByInfoId("S", var_84_1) > 0)) then
			var_84_0[#var_84_0 + 1] = arg_84_0[iter_84_0]
		end
	end

	return var_84_0
end

function var_0_0.filterHasAlterMagicCards(arg_85_0)
	local var_85_0 = {}

	for iter_85_0 = 1, #arg_85_0 do
		if arg_85_0[iter_85_0]:getAlterMagicInfoId() ~= nil then
			var_85_0[#var_85_0 + 1] = arg_85_0[iter_85_0]
		end
	end

	return var_85_0
end

function var_0_0.filterNotHasAlterMagicCards(arg_86_0)
	local var_86_0 = {}

	for iter_86_0 = 1, #arg_86_0 do
		if arg_86_0[iter_86_0]:getAlterMagicInfoId() == nil then
			var_86_0[#var_86_0 + 1] = arg_86_0[iter_86_0]
		end
	end

	return var_86_0
end

function var_0_0.filterCanBindAlterMagicCards(arg_87_0, arg_87_1)
	local var_87_0 = {}

	if arg_87_1._owner:getEmptyGroundPos() == nil then
		return var_87_0
	end

	for iter_87_0 = 1, #arg_87_0 do
		local var_87_1 = arg_87_0[iter_87_0]:getAlterMagicInfoId()

		if not arg_87_1:isBinded(var_87_1) then
			var_87_0[#var_87_0 + 1] = arg_87_0[iter_87_0]
		end
	end

	return var_87_0
end

function var_0_0.filterCanBindAlterMagicCardsEx(arg_88_0, arg_88_1)
	local var_88_0 = {}

	if #arg_88_1 == 0 or arg_88_1[1]._owner:getEmptyGroundPos() == nil then
		return var_88_0
	end

	for iter_88_0 = 1, #arg_88_0 do
		local var_88_1 = arg_88_0[iter_88_0]:getAlterMagicInfoId()
		local var_88_2 = false

		for iter_88_1 = 1, #arg_88_1 do
			if not arg_88_1[iter_88_1]:isBinded(var_88_1) then
				var_88_2 = true

				break
			end
		end

		if var_88_2 then
			var_88_0[#var_88_0 + 1] = arg_88_0[iter_88_0]
		end
	end

	return var_88_0
end

function var_0_0.filterCanSummonAlterMonsterCards(arg_89_0)
	local var_89_0 = {}

	for iter_89_0 = 1, #arg_89_0 do
		local var_89_1 = arg_89_0[iter_89_0]
		local var_89_2 = var_89_1:getAlterMonsterInfoId()
		local var_89_3 = var_89_1._owner:getTempLeaveCardByInfoId(var_89_2, false)

		if var_89_3 ~= nil and var_89_1._owner:getEmptyBoardPos(var_89_3) and var_89_1._owner:canSpecialSummon(var_89_3) then
			var_89_0[#var_89_0 + 1] = var_89_1
		end
	end

	return var_89_0
end

function var_0_0.filterCanActionCards(arg_90_0)
	local var_90_0 = {}

	for iter_90_0 = 1, #arg_90_0 do
		local var_90_1 = arg_90_0[iter_90_0]

		if var_90_1:canAction() then
			var_90_0[#var_90_0 + 1] = var_90_1
		end
	end

	return var_90_0
end

function var_0_0.filterCannotActionCards(arg_91_0)
	local var_91_0 = {}

	for iter_91_0 = 1, #arg_91_0 do
		local var_91_1 = arg_91_0[iter_91_0]

		if not var_91_1:canAction() then
			var_91_0[#var_91_0 + 1] = var_91_1
		end
	end

	return var_91_0
end

function var_0_0.filterNotActionedCards(arg_92_0)
	local var_92_0 = {}

	for iter_92_0 = 1, #arg_92_0 do
		local var_92_1 = arg_92_0[iter_92_0]

		if not var_92_1:actioned() then
			var_92_0[#var_92_0 + 1] = var_92_1
		end
	end

	return var_92_0
end

function var_0_0.filterNotActionedCardWhenRoundEnd(arg_93_0)
	local var_93_0 = {}

	for iter_93_0 = 1, #arg_93_0 do
		local var_93_1 = arg_93_0[iter_93_0]

		if var_93_1._mark7384 then
			var_93_0[#var_93_0 + 1] = var_93_1
		end
	end

	return var_93_0
end

function var_0_0.filterMergeCards(arg_94_0)
	local var_94_0 = {}

	for iter_94_0 = 1, #arg_94_0 do
		local var_94_1 = arg_94_0[iter_94_0]

		if var_94_1:canMergeFrom() then
			var_94_0[#var_94_0 + 1] = var_94_1
		end
	end

	return var_94_0
end

function var_0_0.filterHasSameInGraveCards(arg_95_0)
	local var_95_0 = {}

	for iter_95_0 = 1, #arg_95_0 do
		local var_95_1 = arg_95_0[iter_95_0]

		if #var_95_1._owner:getBattleCards("G", var_95_1._infoId) + #var_95_1._owner._opponent:getBattleCards("G", var_95_1._infoId) > 0 then
			var_95_0[#var_95_0 + 1] = var_95_1
		end
	end

	return var_95_0
end

function var_0_0.filterInMagicTrapTypeCards(arg_96_0, arg_96_1)
	local var_96_0 = {}

	for iter_96_0 = 1, #arg_96_0 do
		local var_96_1 = arg_96_0[iter_96_0]

		if var_96_1._info._type == arg_96_1 then
			var_96_0[#var_96_0 + 1] = var_96_1
		end
	end

	return var_96_0
end

function var_0_0.filterSustainableMagicCards(arg_97_0)
	local var_97_0 = {}

	for iter_97_0 = 1, #arg_97_0 do
		local var_97_1 = arg_97_0[iter_97_0]

		if var_97_1:isSustainableMagic() then
			var_97_0[#var_97_0 + 1] = var_97_1
		end
	end

	return var_97_0
end

function var_0_0.filterSustainableTrapCards(arg_98_0)
	local var_98_0 = {}

	for iter_98_0 = 1, #arg_98_0 do
		local var_98_1 = arg_98_0[iter_98_0]

		if var_98_1:isSustainableTrap() then
			var_98_0[#var_98_0 + 1] = var_98_1
		end
	end

	return var_98_0
end

function var_0_0.filterDefPostureCards(arg_99_0, arg_99_1)
	local var_99_0 = {}

	for iter_99_0 = 1, #arg_99_0 do
		local var_99_1 = arg_99_0[iter_99_0]

		if arg_99_1 == var_99_1:hasBuff(true, BattleData.PositiveType.defendPosture) then
			var_99_0[#var_99_0 + 1] = var_99_1
		end
	end

	return var_99_0
end

function var_0_0.filterAtkBiggerCards(arg_100_0, arg_100_1)
	local var_100_0 = {}

	for iter_100_0 = 1, #arg_100_0 do
		local var_100_1 = arg_100_0[iter_100_0]

		if not var_100_1:isLink() and (arg_100_1 and var_100_1._atk > var_100_1._hp or not arg_100_1 and var_100_1._atk < var_100_1._hp) then
			var_100_0[#var_100_0 + 1] = var_100_1
		end
	end

	return var_100_0
end

function var_0_0.filterCanSpecialSummonCards(arg_101_0, arg_101_1, arg_101_2)
	local var_101_0 = {}

	for iter_101_0 = 1, #arg_101_0 do
		local var_101_1 = arg_101_0[iter_101_0]

		if var_101_1._owner:canSpecialSummon(var_101_1, arg_101_1, arg_101_2) then
			var_101_0[#var_101_0 + 1] = var_101_1
		end
	end

	return var_101_0
end

function var_0_0.filterTrapInTypeCards(arg_102_0, arg_102_1)
	local var_102_0 = {}

	for iter_102_0 = 1, #arg_102_0 do
		local var_102_1 = arg_102_0[iter_102_0]

		if Data._trapInfo[var_102_1._infoId]._type == arg_102_1 then
			var_102_0[#var_102_0 + 1] = var_102_1
		end
	end

	return var_102_0
end

function var_0_0.filterTrapNotInTypeCards(arg_103_0, arg_103_1)
	local var_103_0 = {}

	for iter_103_0 = 1, #arg_103_0 do
		local var_103_1 = arg_103_0[iter_103_0]

		if Data._trapInfo[var_103_1._infoId]._type ~= arg_103_1 then
			var_103_0[#var_103_0 + 1] = var_103_1
		end
	end

	return var_103_0
end

function var_0_0.filterCanMergeToCards(arg_104_0)
	local var_104_0 = {}

	for iter_104_0 = 1, #arg_104_0 do
		local var_104_1 = arg_104_0[iter_104_0]

		if var_104_1:canMergeTo() then
			var_104_0[#var_104_0 + 1] = var_104_1
		end
	end

	return var_104_0
end

function var_0_0.filterComposeMaterialCards(arg_105_0)
	local var_105_0 = {}

	for iter_105_0 = 1, #arg_105_0 do
		local var_105_1 = arg_105_0[iter_105_0]

		if var_105_1._isComposeMaterial then
			var_105_0[#var_105_0 + 1] = var_105_1
		end
	end

	return var_105_0
end

function var_0_0.filterDyingCards(arg_106_0, arg_106_1)
	local var_106_0 = {}

	for iter_106_0 = 1, #arg_106_0 do
		local var_106_1 = arg_106_0[iter_106_0]

		if var_106_1:isDying() == arg_106_1 then
			var_106_0[#var_106_0 + 1] = var_106_1
		end
	end

	return var_106_0
end

function var_0_0.filterLeavingCards(arg_107_0, arg_107_1)
	local var_107_0 = {}

	for iter_107_0 = 1, #arg_107_0 do
		local var_107_1 = arg_107_0[iter_107_0]

		if var_107_1:isLeaving() == arg_107_1 then
			var_107_0[#var_107_0 + 1] = var_107_1
		end
	end

	return var_107_0
end

function var_0_0.filterUsingCards(arg_108_0, arg_108_1)
	local var_108_0 = {}

	for iter_108_0 = 1, #arg_108_0 do
		local var_108_1 = arg_108_0[iter_108_0]

		if var_108_1:isUsing() == arg_108_1 then
			var_108_0[#var_108_0 + 1] = var_108_1
		end
	end

	return var_108_0
end

function var_0_0.filterHandingCards(arg_109_0, arg_109_1)
	local var_109_0 = {}

	for iter_109_0 = 1, #arg_109_0 do
		local var_109_1 = arg_109_0[iter_109_0]

		if var_109_1:isHanding() == arg_109_1 then
			var_109_0[#var_109_0 + 1] = var_109_1
		end
	end

	return var_109_0
end

function var_0_0.filterIsChangingFromToCards(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0 = {}

	for iter_110_0 = 1, #arg_110_0 do
		local var_110_1 = arg_110_0[iter_110_0]

		if var_110_1:isChangingFromTo(arg_110_1, arg_110_2) then
			var_110_0[#var_110_0 + 1] = var_110_1
		end
	end

	return var_110_0
end

function var_0_0.filterNotHasChangeStatusUnderSkillCards(arg_111_0, arg_111_1)
	local var_111_0 = {}

	for iter_111_0 = 1, #arg_111_0 do
		local var_111_1 = arg_111_0[iter_111_0]

		if not var_111_1:hasChangeStatusUnderSkill(arg_111_1) then
			var_111_0[#var_111_0 + 1] = var_111_1
		end
	end

	return var_111_0
end

function var_0_0.filterToOppoBoardCards(arg_112_0, arg_112_1)
	local var_112_0 = {}

	for iter_112_0 = 1, #arg_112_0 do
		local var_112_1 = arg_112_0[iter_112_0]

		if var_112_1:isToOppoBoard() == arg_112_1 then
			var_112_0[#var_112_0 + 1] = var_112_1
		end
	end

	return var_112_0
end

function var_0_0.filterNoSkillCards(arg_113_0, arg_113_1)
	local var_113_0 = {}

	for iter_113_0 = 1, #arg_113_0 do
		local var_113_1 = arg_113_0[iter_113_0]

		if arg_113_1 ~= nil then
			if not var_113_1:hasSkillFast(arg_113_1) then
				var_113_0[#var_113_0 + 1] = var_113_1
			end
		elseif var_113_1:isNormalMonster() then
			var_113_0[#var_113_0 + 1] = var_113_1
		end
	end

	return var_113_0
end

function var_0_0.filterNoSkillsCards(arg_114_0, arg_114_1)
	local var_114_0 = {}

	for iter_114_0 = 1, #arg_114_0 do
		local var_114_1 = arg_114_0[iter_114_0]

		if not var_114_1:hasSkills(arg_114_1) then
			var_114_0[#var_114_0 + 1] = var_114_1
		end
	end

	return var_114_0
end

function var_0_0.filterHasSkillCards(arg_115_0, arg_115_1)
	local var_115_0 = {}

	for iter_115_0 = 1, #arg_115_0 do
		local var_115_1 = arg_115_0[iter_115_0]

		if arg_115_1 ~= nil then
			if var_115_1:hasSkillFast(arg_115_1) then
				var_115_0[#var_115_0 + 1] = var_115_1
			end
		elseif #var_115_1._skills ~= 0 then
			var_115_0[#var_115_0 + 1] = var_115_1
		end
	end

	return var_115_0
end

function var_0_0.filterSameNameCards(arg_116_0, arg_116_1)
	local var_116_0 = {}

	for iter_116_0 = 1, #arg_116_0 do
		local var_116_1 = arg_116_0[iter_116_0]

		if var_116_1:isSameNameWith(arg_116_1) then
			var_116_0[#var_116_0 + 1] = var_116_1
		end
	end

	return var_116_0
end

function var_0_0.filterHasSameNameCardCards(arg_117_0)
	local var_117_0 = {}
	local var_117_1 = {}

	for iter_117_0 = 1, #arg_117_0 do
		if not var_117_1[iter_117_0] then
			local var_117_2 = arg_117_0[iter_117_0]

			for iter_117_1 = iter_117_0 + 1, #arg_117_0 do
				if var_117_2:isSameNameWith(arg_117_0[iter_117_1]) then
					var_117_1[iter_117_0] = true
					var_117_1[iter_117_1] = true
				end
			end
		end
	end

	for iter_117_2 = 1, #arg_117_0 do
		if var_117_1[iter_117_2] then
			var_117_0[#var_117_0 + 1] = arg_117_0[iter_117_2]
		end
	end

	return var_117_0
end

function var_0_0.filterNotSameNameCards(arg_118_0, arg_118_1)
	local var_118_0 = {}

	for iter_118_0 = 1, #arg_118_0 do
		local var_118_1 = arg_118_0[iter_118_0]

		if not var_118_1:isSameNameWith(arg_118_1) then
			var_118_0[#var_118_0 + 1] = var_118_1
		end
	end

	return var_118_0
end

function var_0_0.filterNotSameNamesCards(arg_119_0, arg_119_1)
	local var_119_0 = {}

	for iter_119_0 = 1, #arg_119_0 do
		local var_119_1 = arg_119_0[iter_119_0]
		local var_119_2 = true

		for iter_119_1 = 1, #arg_119_1 do
			if var_119_1:isSameNameWith(arg_119_1[iter_119_1]) then
				var_119_2 = false

				break
			end
		end

		if var_119_2 then
			var_119_0[#var_119_0 + 1] = var_119_1
		end
	end

	return var_119_0
end

function var_0_0.filterEqualInfoIdCards(arg_120_0, arg_120_1)
	local var_120_0 = {}

	for iter_120_0 = 1, #arg_120_0 do
		local var_120_1 = arg_120_0[iter_120_0]

		if var_120_1:isInfoId(arg_120_1) then
			var_120_0[#var_120_0 + 1] = var_120_1
		end
	end

	return var_120_0
end

function var_0_0.filterNotEqualInfoIdCards(arg_121_0, arg_121_1)
	local var_121_0 = {}

	for iter_121_0 = 1, #arg_121_0 do
		local var_121_1 = arg_121_0[iter_121_0]

		if not var_121_1:isInfoId(arg_121_1) then
			var_121_0[#var_121_0 + 1] = var_121_1
		end
	end

	return var_121_0
end

function var_0_0.filterNotEqualInfoIdGroupCards(arg_122_0, arg_122_1)
	local var_122_0 = {}

	for iter_122_0 = 1, #arg_122_0 do
		local var_122_1 = arg_122_0[iter_122_0]

		if not var_122_1:isInInfoIdGroup(arg_122_1) then
			var_122_0[#var_122_0 + 1] = var_122_1
		end
	end

	return var_122_0
end

function var_0_0.filterNotEqualInfoIdExCards(arg_123_0, arg_123_1)
	local var_123_0 = {}

	for iter_123_0 = 1, #arg_123_0 do
		local var_123_1 = arg_123_0[iter_123_0]

		if var_123_1._infoId ~= arg_123_1 then
			var_123_0[#var_123_0 + 1] = var_123_1
		end
	end

	return var_123_0
end

function var_0_0.filterUniqueInfoIdCards(arg_124_0)
	local var_124_0 = {}
	local var_124_1 = {}

	for iter_124_0 = 1, #arg_124_0 do
		local var_124_2 = arg_124_0[iter_124_0]
		local var_124_3 = var_124_2._infoId

		if var_124_1[var_124_3] == nil then
			var_124_1[var_124_3] = var_124_2
			var_124_0[#var_124_0 + 1] = var_124_2
		end
	end

	return var_124_0
end

function var_0_0.filterUniqueIdCards(arg_125_0)
	local var_125_0 = {}
	local var_125_1 = {}

	for iter_125_0 = 1, #arg_125_0 do
		local var_125_2 = arg_125_0[iter_125_0]
		local var_125_3 = var_125_2._id

		if var_125_1[var_125_3] == nil then
			var_125_1[var_125_3] = var_125_2
			var_125_0[#var_125_0 + 1] = var_125_2
		end
	end

	return var_125_0
end

function var_0_0.filterUniqueNatureCards(arg_126_0)
	local var_126_0 = {}
	local var_126_1 = {}

	for iter_126_0 = 1, #arg_126_0 do
		local var_126_2 = arg_126_0[iter_126_0]
		local var_126_3 = false

		for iter_126_1 = 1, #var_126_0 do
			if var_126_2:isSameNatureWith(var_126_0[iter_126_1]) then
				var_126_3 = true

				break
			end
		end

		if not var_126_3 then
			var_126_0[#var_126_0 + 1] = var_126_2
		end
	end

	return var_126_0
end

function var_0_0.filterUniqueCategoryCards(arg_127_0)
	local var_127_0 = {}
	local var_127_1 = {}

	for iter_127_0 = 1, #arg_127_0 do
		local var_127_2 = arg_127_0[iter_127_0]
		local var_127_3 = var_127_2._info._category

		if var_127_1[var_127_3] == nil then
			var_127_1[var_127_3] = var_127_2
			var_127_0[#var_127_0 + 1] = var_127_2
		end
	end

	return var_127_0
end

function var_0_0.filterUniquePropCards(arg_128_0, arg_128_1)
	if arg_128_1 == "N" then
		return B.filterUniqueNatureCards(arg_128_0)
	elseif arg_128_1 == "C" then
		return B.filterUniqueCategoryCards(arg_128_0)
	elseif arg_128_1 == "D" then
		return B.filterUniqueInfoIdCards(arg_128_0)
	elseif arg_128_1 == "S" then
		return B.filterUniqueStarCards(arg_128_0)
	else
		print("#### unique", arg_128_1, "is not supported")

		return {}
	end
end

function var_0_0.filterCanSacrificeCards(arg_129_0, arg_129_1, arg_129_2)
	local var_129_0 = {}

	for iter_129_0 = 1, #arg_129_0 do
		local var_129_1 = arg_129_0[iter_129_0]

		if arg_129_1:canSacrificeWith(var_129_1, arg_129_2) then
			var_129_0[#var_129_0 + 1] = var_129_1
		end
	end

	return var_129_0
end

function var_0_0.filterNotEqualSacrificeCountCards(arg_130_0, arg_130_1)
	local var_130_0 = {}

	for iter_130_0 = 1, #arg_130_0 do
		local var_130_1 = arg_130_0[iter_130_0]

		if var_130_1:getSacrificeCount() ~= arg_130_1 then
			var_130_0[#var_130_0 + 1] = var_130_1
		end
	end

	return var_130_0
end

function var_0_0.filterNoShieldCards(arg_131_0, arg_131_1, arg_131_2)
	local var_131_0 = {}

	for iter_131_0 = 1, #arg_131_0 do
		local var_131_1 = arg_131_0[iter_131_0]

		if not var_131_1:hasShieldInType(arg_131_1, arg_131_2) then
			var_131_0[#var_131_0 + 1] = var_131_1
		end
	end

	return var_131_0
end

function var_0_0.filterNoShieldExCards(arg_132_0, arg_132_1, arg_132_2)
	local var_132_0 = {}

	for iter_132_0 = 1, #arg_132_0 do
		local var_132_1 = arg_132_0[iter_132_0]

		if not var_132_1:hasShieldExInType(arg_132_1, arg_132_2) then
			var_132_0[#var_132_0 + 1] = var_132_1
		end
	end

	return var_132_0
end

function var_0_0.filterNoShieldDestroyCards(arg_133_0, arg_133_1)
	local var_133_0 = {}

	for iter_133_0 = 1, #arg_133_0 do
		local var_133_1 = arg_133_0[iter_133_0]

		if not var_133_1:hasBuff(true, BattleData.PositiveType.shieldDestroy) and not var_133_1:hasBuff(true, BattleData.PositiveType.shieldEffectDestroy) and (arg_133_1 ~= true or not var_133_1:hasBuff(true, BattleData.PositiveType.shieldHaloDestroy)) and (arg_133_1 ~= true or not var_133_1:hasBuff(true, BattleData.PositiveType.shieldHaloEffectDestroy)) then
			var_133_0[#var_133_0 + 1] = var_133_1
		end
	end

	return var_133_0
end

function var_0_0.filterPlayerNoShieldCards(arg_134_0, arg_134_1, arg_134_2, arg_134_3)
	local var_134_0 = {}

	for iter_134_0 = 1, #arg_134_0 do
		local var_134_1 = arg_134_0[iter_134_0]

		if var_134_1._owner ~= arg_134_1 or not var_134_1:hasShieldInType(arg_134_2, arg_134_3) then
			var_134_0[#var_134_0 + 1] = var_134_1
		end
	end

	return var_134_0
end

function var_0_0.filterNotViewedCards(arg_135_0)
	local var_135_0 = {}

	for iter_135_0 = 1, #arg_135_0 do
		local var_135_1 = arg_135_0[iter_135_0]

		if not var_135_1._trapViewed then
			var_135_0[#var_135_0 + 1] = var_135_1
		end
	end

	return var_135_0
end

function var_0_0.filterSameAtkCards(arg_136_0)
	local var_136_0 = {}
	local var_136_1 = {}

	for iter_136_0 = 1, #arg_136_0 do
		local var_136_2 = arg_136_0[iter_136_0]
		local var_136_3 = var_136_2._atk

		if var_136_3 ~= nil then
			if var_136_1[var_136_3] == nil then
				var_136_1[var_136_3] = {
					var_136_2
				}
			else
				var_136_1[var_136_3][#var_136_1[var_136_3] + 1] = var_136_2
			end
		end
	end

	for iter_136_1, iter_136_2 in pairs(var_136_1) do
		if #iter_136_2 > 1 then
			for iter_136_3 = 1, #iter_136_2 do
				var_136_0[#var_136_0 + 1] = iter_136_2[iter_136_3]
			end
		end
	end

	return var_136_0
end

function var_0_0.filterTokenCards(arg_137_0, arg_137_1)
	local var_137_0 = {}

	for iter_137_0 = 1, #arg_137_0 do
		local var_137_1 = arg_137_0[iter_137_0]

		if arg_137_1 and var_137_1:isToken() or not arg_137_1 and not var_137_1:isToken() then
			var_137_0[#var_137_0 + 1] = var_137_1
		end
	end

	return var_137_0
end

function var_0_0.filterStarLessThanSumOfOthers(arg_138_0, arg_138_1)
	local var_138_0 = {}

	for iter_138_0 = 1, #arg_138_0 do
		local var_138_1 = arg_138_0[iter_138_0]
		local var_138_2 = 0

		for iter_138_1 = 1, #arg_138_1 do
			if arg_138_1[iter_138_1] ~= var_138_1 then
				var_138_2 = var_138_2 + arg_138_1[iter_138_1]:getStar()
			end
		end

		if var_138_2 >= var_138_1:getStar() then
			var_138_0[#var_138_0 + 1] = var_138_1
		end
	end

	return var_138_0
end

function var_0_0.filterXYZStarCards(arg_139_0, arg_139_1)
	local var_139_0 = {}

	for iter_139_0 = 1, #arg_139_0 do
		local var_139_1 = arg_139_0[iter_139_0]

		if var_139_1._info._star == arg_139_1 then
			var_139_0[#var_139_0 + 1] = var_139_1
		end
	end

	return var_139_0
end

function var_0_0.filterXYZStarBetweenCards(arg_140_0, arg_140_1, arg_140_2)
	local var_140_0 = {}

	for iter_140_0 = 1, #arg_140_0 do
		local var_140_1 = arg_140_0[iter_140_0]

		if arg_140_1 <= var_140_1._info._star and arg_140_2 >= var_140_1._info._star then
			var_140_0[#var_140_0 + 1] = var_140_1
		end
	end

	return var_140_0
end

function var_0_0.filterSummonByNormalCards(arg_141_0, arg_141_1)
	local var_141_0 = {}

	for iter_141_0 = 1, #arg_141_0 do
		local var_141_1 = arg_141_0[iter_141_0]

		if var_141_1._summonByNormal == arg_141_1 then
			var_141_0[#var_141_0 + 1] = var_141_1
		end
	end

	return var_141_0
end

function var_0_0.filterSummonBySacrificeCards(arg_142_0)
	local var_142_0 = {}

	for iter_142_0 = 1, #arg_142_0 do
		local var_142_1 = arg_142_0[iter_142_0]

		if var_142_1:isSummonedBySacrifice() then
			var_142_0[#var_142_0 + 1] = var_142_1
		end
	end

	return var_142_0
end

function var_0_0.filterSummonByMergeCards(arg_143_0)
	local var_143_0 = {}

	for iter_143_0 = 1, #arg_143_0 do
		local var_143_1 = arg_143_0[iter_143_0]

		if var_143_1._summonByMerge then
			var_143_0[#var_143_0 + 1] = var_143_1
		end
	end

	return var_143_0
end

function var_0_0.filterSummonByCeremonyCards(arg_144_0)
	local var_144_0 = {}

	for iter_144_0 = 1, #arg_144_0 do
		local var_144_1 = arg_144_0[iter_144_0]

		if var_144_1._summonByCeremony then
			var_144_0[#var_144_0 + 1] = var_144_1
		end
	end

	return var_144_0
end

function var_0_0.filterSummonedByMergeCards(arg_145_0)
	local var_145_0 = {}

	for iter_145_0 = 1, #arg_145_0 do
		local var_145_1 = arg_145_0[iter_145_0]

		if var_145_1._summonedByMerge then
			var_145_0[#var_145_0 + 1] = var_145_1
		end
	end

	return var_145_0
end

function var_0_0.filterSummonedBySyncCards(arg_146_0)
	local var_146_0 = {}

	for iter_146_0 = 1, #arg_146_0 do
		local var_146_1 = arg_146_0[iter_146_0]

		if var_146_1._summonedBySync then
			var_146_0[#var_146_0 + 1] = var_146_1
		end
	end

	return var_146_0
end

function var_0_0.filterSummonByXYZCards(arg_147_0)
	local var_147_0 = {}

	for iter_147_0 = 1, #arg_147_0 do
		local var_147_1 = arg_147_0[iter_147_0]

		if var_147_1._summonByXYZ then
			var_147_0[#var_147_0 + 1] = var_147_1
		end
	end

	return var_147_0
end

function var_0_0.filterNoBuffCards(arg_148_0, arg_148_1, arg_148_2)
	local var_148_0 = {}

	for iter_148_0 = 1, #arg_148_0 do
		local var_148_1 = arg_148_0[iter_148_0]

		if not var_148_1:hasBuff(arg_148_1, arg_148_2) then
			var_148_0[#var_148_0 + 1] = var_148_1
		end
	end

	return var_148_0
end

function var_0_0.filterHasBuffCards(arg_149_0, arg_149_1, arg_149_2)
	local var_149_0 = {}

	for iter_149_0 = 1, #arg_149_0 do
		local var_149_1 = arg_149_0[iter_149_0]

		if var_149_1:hasBuff(arg_149_1, arg_149_2) then
			var_149_0[#var_149_0 + 1] = var_149_1
		end
	end

	return var_149_0
end

function var_0_0.filterHasOppoShieldCards(arg_150_0)
	local var_150_0 = {}

	for iter_150_0 = 1, #arg_150_0 do
		local var_150_1 = arg_150_0[iter_150_0]

		if var_150_1:hasBuff(true, BattleData.PositiveType.shieldOppoMonster) or var_150_1:hasBuff(true, BattleData.PositiveType.shieldHaloOppoMonster) or var_150_1:hasBuff(true, BattleData.PositiveType.shieldOppoMagic) or var_150_1:hasBuff(true, BattleData.PositiveType.shieldHaloOppoMagic) or var_150_1:hasBuff(true, BattleData.PositiveType.shieldOppoTrap) or var_150_1:hasBuff(true, BattleData.PositiveType.shieldHaloOppoTrap) then
			var_150_0[#var_150_0 + 1] = var_150_1
		end
	end

	return var_150_0
end

function var_0_0.filterDieRoundCards(arg_151_0, arg_151_1)
	local var_151_0 = {}

	for iter_151_0 = 1, #arg_151_0 do
		local var_151_1 = arg_151_0[iter_151_0]

		if var_151_1._dieRound[1] == arg_151_1 then
			var_151_0[#var_151_0 + 1] = var_151_1
		end
	end

	return var_151_0
end

function var_0_0.filterDieByEffectCards(arg_152_0, arg_152_1)
	local var_152_0 = {}

	for iter_152_0 = 1, #arg_152_0 do
		local var_152_1 = arg_152_0[iter_152_0]

		if var_152_1._dieByEffect == arg_152_1 then
			var_152_0[#var_152_0 + 1] = var_152_1
		end
	end

	return var_152_0
end

function var_0_0.filterDieByAttackOrEffectCards(arg_153_0)
	local var_153_0 = {}

	for iter_153_0 = 1, #arg_153_0 do
		local var_153_1 = arg_153_0[iter_153_0]

		if var_153_1._dieByAttack or var_153_1._dieByEffect then
			var_153_0[#var_153_0 + 1] = var_153_1
		end
	end

	return var_153_0
end

function var_0_0.filterFirstCards(arg_154_0, arg_154_1)
	local var_154_0 = {}

	for iter_154_0 = 1, math.min(arg_154_1, #arg_154_0) do
		local var_154_1 = arg_154_0[iter_154_0]

		var_154_0[#var_154_0 + 1] = var_154_1
	end

	return var_154_0
end

function var_0_0.filterBoardCards(arg_155_0, arg_155_1)
	local var_155_0 = {}

	for iter_155_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_155_1 = arg_155_0[iter_155_0]

		if var_155_1 ~= nil and not B.tableContain(arg_155_1, var_155_1) then
			var_155_0[iter_155_0] = var_155_1
		end
	end

	return var_155_0
end

function var_0_0.filterCanBeSacrificedCards(arg_156_0, arg_156_1, arg_156_2)
	local var_156_0 = {}

	for iter_156_0 = 1, #arg_156_0 do
		local var_156_1 = arg_156_0[iter_156_0]

		if var_156_1._status ~= BattleData.CardStatus.board or var_156_1:canBeSacrificed(arg_156_1, arg_156_2) then
			var_156_0[#var_156_0 + 1] = var_156_1
		end
	end

	return var_156_0
end

function var_0_0.filterCanBeCeremonyedCards(arg_157_0, arg_157_1)
	local var_157_0 = {}

	for iter_157_0 = 1, #arg_157_0 do
		local var_157_1 = arg_157_0[iter_157_0]

		if var_157_1:canBeCeremonyed(arg_157_1) then
			var_157_0[#var_157_0 + 1] = var_157_1
		end
	end

	return var_157_0
end

function var_0_0.filterCanBeSyncedCards(arg_158_0, arg_158_1)
	local var_158_0 = {}

	for iter_158_0 = 1, #arg_158_0 do
		local var_158_1 = arg_158_0[iter_158_0]

		if var_158_1:canBeSynced(arg_158_1) then
			var_158_0[#var_158_0 + 1] = var_158_1
		end
	end

	return var_158_0
end

function var_0_0.filterCanBeXYZedCards(arg_159_0, arg_159_1)
	local var_159_0 = {}

	for iter_159_0 = 1, #arg_159_0 do
		local var_159_1 = arg_159_0[iter_159_0]

		if var_159_1:canBeXYZed(arg_159_1) then
			var_159_0[#var_159_0 + 1] = var_159_1
		end
	end

	return var_159_0
end

function var_0_0.filterCanBeLinkedCards(arg_160_0, arg_160_1, arg_160_2)
	local var_160_0 = {}

	for iter_160_0 = 1, #arg_160_0 do
		local var_160_1 = arg_160_0[iter_160_0]

		if var_160_1:canBeLinked(arg_160_1, arg_160_2) then
			var_160_0[#var_160_0 + 1] = var_160_1
		end
	end

	return var_160_0
end

function var_0_0.filterNormalCards(arg_161_0)
	local var_161_0 = {}

	for iter_161_0 = 1, #arg_161_0 do
		local var_161_1 = arg_161_0[iter_161_0]

		if var_161_1:isNormalMonster() then
			var_161_0[#var_161_0 + 1] = var_161_1
		end
	end

	return var_161_0
end

function var_0_0.filterEffectCards(arg_162_0)
	local var_162_0 = {}

	for iter_162_0 = 1, #arg_162_0 do
		local var_162_1 = arg_162_0[iter_162_0]

		if var_162_1:isEffectMonster() then
			var_162_0[#var_162_0 + 1] = var_162_1
		end
	end

	return var_162_0
end

function var_0_0.filterSpiritCards(arg_163_0)
	local var_163_0 = {}

	for iter_163_0 = 1, #arg_163_0 do
		local var_163_1 = arg_163_0[iter_163_0]

		if var_163_1:isSpirit() then
			var_163_0[#var_163_0 + 1] = var_163_1
		end
	end

	return var_163_0
end

function var_0_0.filterDualCards(arg_164_0)
	local var_164_0 = {}

	for iter_164_0 = 1, #arg_164_0 do
		local var_164_1 = arg_164_0[iter_164_0]

		if var_164_1:isDual() then
			var_164_0[#var_164_0 + 1] = var_164_1
		end
	end

	return var_164_0
end

function var_0_0.filterAdjustCards(arg_165_0, arg_165_1)
	local var_165_0 = {}

	for iter_165_0 = 1, #arg_165_0 do
		local var_165_1 = arg_165_0[iter_165_0]

		if arg_165_1 and var_165_1:isAdjust() or not arg_165_1 and var_165_1:isNotAdjust() then
			var_165_0[#var_165_0 + 1] = var_165_1
		end
	end

	return var_165_0
end

function var_0_0.filterAllyMonsterCards(arg_166_0)
	local var_166_0 = {}

	for iter_166_0 = 1, #arg_166_0 do
		local var_166_1 = arg_166_0[iter_166_0]

		if var_166_1:isAllyMonster() then
			var_166_0[#var_166_0 + 1] = var_166_1
		end
	end

	return var_166_0
end

function var_0_0.filterCeremonyMonsterCards(arg_167_0)
	local var_167_0 = {}

	for iter_167_0 = 1, #arg_167_0 do
		local var_167_1 = arg_167_0[iter_167_0]

		if var_167_1:isCeremonyMonster() then
			var_167_0[#var_167_0 + 1] = var_167_1
		end
	end

	return var_167_0
end

function var_0_0.filterSyncCards(arg_168_0, arg_168_1)
	local var_168_0 = {}

	for iter_168_0 = 1, #arg_168_0 do
		local var_168_1 = arg_168_0[iter_168_0]

		if var_168_1:isSync() == arg_168_1 then
			var_168_0[#var_168_0 + 1] = var_168_1
		end
	end

	return var_168_0
end

function var_0_0.filterXYZCards(arg_169_0, arg_169_1)
	local var_169_0 = {}

	for iter_169_0 = 1, #arg_169_0 do
		local var_169_1 = arg_169_0[iter_169_0]

		if var_169_1:isXYZ() == arg_169_1 then
			var_169_0[#var_169_0 + 1] = var_169_1
		end
	end

	return var_169_0
end

function var_0_0.filterPendulumCards(arg_170_0, arg_170_1)
	local var_170_0 = {}

	for iter_170_0 = 1, #arg_170_0 do
		local var_170_1 = arg_170_0[iter_170_0]

		if var_170_1:isPendulum() == arg_170_1 then
			var_170_0[#var_170_0 + 1] = var_170_1
		end
	end

	return var_170_0
end

function var_0_0.filterLinkCards(arg_171_0, arg_171_1)
	local var_171_0 = {}

	for iter_171_0 = 1, #arg_171_0 do
		local var_171_1 = arg_171_0[iter_171_0]

		if var_171_1:isLink() == arg_171_1 then
			var_171_0[#var_171_0 + 1] = var_171_1
		end
	end

	return var_171_0
end

function var_0_0.filterLinkCardsByLink(arg_172_0, arg_172_1)
	local var_172_0 = {}

	for iter_172_0 = 1, #arg_172_0 do
		local var_172_1 = arg_172_0[iter_172_0]

		if var_172_1:isLink() and #var_172_1._info._link == arg_172_1 then
			var_172_0[#var_172_0 + 1] = var_172_1
		end
	end

	return var_172_0
end

function var_0_0.filterLinkCardsByMinLink(arg_173_0, arg_173_1)
	local var_173_0 = {}

	for iter_173_0 = 1, #arg_173_0 do
		local var_173_1 = arg_173_0[iter_173_0]

		if var_173_1:isLink() and arg_173_1 <= #var_173_1._info._link then
			var_173_0[#var_173_0 + 1] = var_173_1
		end
	end

	return var_173_0
end

function var_0_0.filterLinkCardsByMaxLink(arg_174_0, arg_174_1)
	local var_174_0 = {}

	for iter_174_0 = 1, #arg_174_0 do
		local var_174_1 = arg_174_0[iter_174_0]

		if var_174_1:isLink() and arg_174_1 >= #var_174_1._info._link then
			var_174_0[#var_174_0 + 1] = var_174_1
		end
	end

	return var_174_0
end

function var_0_0.filterLinkPosCards(arg_175_0, arg_175_1)
	local var_175_0 = {}

	for iter_175_0 = 1, #arg_175_0 do
		local var_175_1 = arg_175_0[iter_175_0]

		if (var_175_1._status == BattleData.CardStatus.board and var_175_1._owner._linkPos[var_175_1._pos] or false) == arg_175_1 then
			var_175_0[#var_175_0 + 1] = var_175_1
		end
	end

	return var_175_0
end

function var_0_0.filterNormalMagicCards(arg_176_0)
	local var_176_0 = {}

	for iter_176_0 = 1, #arg_176_0 do
		local var_176_1 = arg_176_0[iter_176_0]

		if var_176_1:isNormalMagic() then
			var_176_0[#var_176_0 + 1] = var_176_1
		end
	end

	return var_176_0
end

function var_0_0.filterEquipMagicCards(arg_177_0)
	local var_177_0 = {}

	for iter_177_0 = 1, #arg_177_0 do
		local var_177_1 = arg_177_0[iter_177_0]

		if var_177_1:isEquipMagic() then
			var_177_0[#var_177_0 + 1] = var_177_1
		end
	end

	return var_177_0
end

function var_0_0.filterCeremonyMagicCards(arg_178_0)
	local var_178_0 = {}

	for iter_178_0 = 1, #arg_178_0 do
		local var_178_1 = arg_178_0[iter_178_0]

		if var_178_1:isCeremonyMagic() then
			var_178_0[#var_178_0 + 1] = var_178_1
		end
	end

	return var_178_0
end

function var_0_0.filterFieldMagicCards(arg_179_0)
	local var_179_0 = {}

	for iter_179_0 = 1, #arg_179_0 do
		local var_179_1 = arg_179_0[iter_179_0]

		if var_179_1:isFieldMagic() then
			var_179_0[#var_179_0 + 1] = var_179_1
		end
	end

	return var_179_0
end

function var_0_0.filterHasStarCards(arg_180_0)
	local var_180_0 = {}

	for iter_180_0 = 1, #arg_180_0 do
		local var_180_1 = arg_180_0[iter_180_0]

		if not var_180_1:isXYZ() and not var_180_1:isLink() then
			var_180_0[#var_180_0 + 1] = var_180_1
		end
	end

	return var_180_0
end

function var_0_0.filterNoMark4814Cards(arg_181_0)
	local var_181_0 = {}

	if arg_181_0 == nil then
		return var_181_0
	end

	for iter_181_0 = 1, #arg_181_0 do
		local var_181_1 = arg_181_0[iter_181_0]

		if not var_181_1._mark4814 then
			var_181_0[#var_181_0 + 1] = var_181_1
		end
	end

	return var_181_0
end

function var_0_0.filterNoMark5426Cards(arg_182_0)
	local var_182_0 = {}

	if arg_182_0 == nil then
		return var_182_0
	end

	for iter_182_0 = 1, #arg_182_0 do
		local var_182_1 = arg_182_0[iter_182_0]

		if not var_182_1._mark5426 then
			var_182_0[#var_182_0 + 1] = var_182_1
		end
	end

	return var_182_0
end

function var_0_0.filterNoMark6140Cards(arg_183_0)
	local var_183_0 = {}

	if arg_183_0 == nil then
		return var_183_0
	end

	for iter_183_0 = 1, #arg_183_0 do
		local var_183_1 = arg_183_0[iter_183_0]

		if not var_183_1._mark6140 then
			var_183_0[#var_183_0 + 1] = var_183_1
		end
	end

	return var_183_0
end

function var_0_0.filterNotDisablePostureCards(arg_184_0)
	local var_184_0 = {}

	for iter_184_0 = 1, #arg_184_0 do
		local var_184_1 = arg_184_0[iter_184_0]

		if not var_184_1:isDisablePosture() then
			var_184_0[#var_184_0 + 1] = var_184_1
		end
	end

	return var_184_0
end

function var_0_0.filterHasSyncComponentsCards(arg_185_0)
	local var_185_0 = {}

	for iter_185_0 = 1, #arg_185_0 do
		local var_185_1 = arg_185_0[iter_185_0]

		if var_185_1._syncComponents ~= nil and #var_185_1._syncComponents > 0 then
			var_185_0[#var_185_0 + 1] = var_185_1
		end
	end

	return var_185_0
end

function var_0_0.filterNoMark6368Cards(arg_186_0)
	local var_186_0 = {}

	for iter_186_0 = 1, #arg_186_0 do
		local var_186_1 = arg_186_0[iter_186_0]

		if var_186_1._mark6368 == nil then
			var_186_0[#var_186_0 + 1] = var_186_1
		end
	end

	return var_186_0
end

function var_0_0.filterCanEffectTrapCards(arg_187_0)
	local var_187_0 = {}

	for iter_187_0 = 1, #arg_187_0 do
		local var_187_1 = arg_187_0[iter_187_0]

		if var_187_1._type == Data.CardType.trap and var_187_1._owner:canTrapEffect(var_187_1) then
			var_187_0[#var_187_0 + 1] = var_187_1
		end
	end

	return var_187_0
end

function var_0_0.filterQualityLessThanCards(arg_188_0, arg_188_1)
	local var_188_0 = {}

	for iter_188_0 = 1, #arg_188_0 do
		local var_188_1 = arg_188_0[iter_188_0]

		if var_188_1._info._quality and arg_188_1 >= var_188_1._info._quality then
			var_188_0[#var_188_0 + 1] = var_188_1
		end
	end

	return var_188_0
end

function var_0_0.filter4428Cards(arg_189_0, arg_189_1)
	local var_189_0 = {}

	for iter_189_0 = 1, #arg_189_0 do
		local var_189_1 = arg_189_0[iter_189_0]

		if var_189_1._onBoardRound == arg_189_1._round and arg_189_1:filterCanChangeToHandCards(arg_189_1:getBattleCardsByInfoId("PG", var_189_1._infoId)) then
			var_189_0[#var_189_0 + 1] = var_189_1
		end
	end

	return var_189_0
end

function var_0_0.filter4431Cards(arg_190_0, arg_190_1)
	local var_190_0 = {}

	for iter_190_0 = 1, #arg_190_0 do
		local var_190_1 = arg_190_0[iter_190_0]

		if not var_190_1:isNature(Data.CardNature.god) and arg_190_1:canUseMonsterNormal(var_190_1, false, false, -2) then
			var_190_0[#var_190_0 + 1] = var_190_1
		end
	end

	return var_190_0
end

function var_0_0.filter5527Cards(arg_191_0, arg_191_1)
	local var_191_0 = {}

	for iter_191_0 = 1, #arg_191_0 do
		local var_191_1 = arg_191_0[iter_191_0]

		if var_191_1._maxAtk >= 2400 and var_191_1._hp == 1000 then
			local var_191_2 = arg_191_1._normalSummonedCards

			arg_191_1._normalSummonedCards = {}

			if arg_191_1:canUseMonsterNormal(var_191_1, false, false, -2) then
				var_191_0[#var_191_0 + 1] = var_191_1
			end

			arg_191_1._normalSummonedCards = var_191_2
		end
	end

	return var_191_0
end

function var_0_0.filterNormalTrapCards(arg_192_0)
	local var_192_0 = {}

	for iter_192_0 = 1, #arg_192_0 do
		local var_192_1 = arg_192_0[iter_192_0]

		if var_192_1:isNormalTrap() then
			var_192_0[#var_192_0 + 1] = var_192_1
		end
	end

	return var_192_0
end

function var_0_0.filterCounterTrapCards(arg_193_0)
	local var_193_0 = {}

	for iter_193_0 = 1, #arg_193_0 do
		local var_193_1 = arg_193_0[iter_193_0]

		if var_193_1:isCounterTrap() then
			var_193_0[#var_193_0 + 1] = var_193_1
		end
	end

	return var_193_0
end

function var_0_0.filterExcludeCards(arg_194_0, arg_194_1)
	local var_194_0 = {}

	for iter_194_0 = 1, #arg_194_0 do
		local var_194_1 = arg_194_0[iter_194_0]
		local var_194_2 = true

		for iter_194_1 = 1, #arg_194_1 do
			if var_194_1 == arg_194_1[iter_194_1] then
				var_194_2 = false
			end
		end

		if var_194_2 then
			var_194_0[#var_194_0 + 1] = var_194_1
		end
	end

	return var_194_0
end

function var_0_0.filterLessThanSyncStarCards(arg_195_0, arg_195_1, arg_195_2)
	local var_195_0 = {}

	for iter_195_0 = 1, #arg_195_0 do
		local var_195_1 = arg_195_0[iter_195_0]

		if arg_195_2 >= var_195_1:getSyncStar(arg_195_1) then
			var_195_0[#var_195_0 + 1] = var_195_1
		end
	end

	return var_195_0
end

function var_0_0.filterFromStatusCards(arg_196_0, arg_196_1)
	local var_196_0 = {}

	for iter_196_0 = 1, #arg_196_0 do
		local var_196_1 = arg_196_0[iter_196_0]

		if var_196_1._onBoardFrom == arg_196_1 then
			var_196_0[#var_196_0 + 1] = var_196_1
		end
	end

	return var_196_0
end

function var_0_0.filterCeremonyComponentToGraveCards(arg_197_0)
	local var_197_0 = {}

	for iter_197_0 = 1, #arg_197_0 do
		local var_197_1 = arg_197_0[iter_197_0]

		if var_197_1._markCeremonyComponentToGrave then
			var_197_0[#var_197_0 + 1] = var_197_1
		end
	end

	return var_197_0
end

function var_0_0.filterOnBoardRoundCards(arg_198_0, arg_198_1)
	local var_198_0 = {}

	for iter_198_0 = 1, #arg_198_0 do
		local var_198_1 = arg_198_0[iter_198_0]

		if var_198_1._onBoardRound == arg_198_1 then
			var_198_0[#var_198_0 + 1] = var_198_1
		end
	end

	return var_198_0
end

function var_0_0.filterOnGraveRoundCards(arg_199_0, arg_199_1)
	local var_199_0 = {}

	for iter_199_0 = 1, #arg_199_0 do
		local var_199_1 = arg_199_0[iter_199_0]

		if var_199_1._onGraveRound == arg_199_1 then
			var_199_0[#var_199_0 + 1] = var_199_1
		end
	end

	return var_199_0
end

function var_0_0.filterOnGraveEndRoundCards(arg_200_0, arg_200_1)
	local var_200_0 = {}

	for iter_200_0 = 1, #arg_200_0 do
		local var_200_1 = arg_200_0[iter_200_0]

		if var_200_1._onGraveEndRound == arg_200_1 then
			var_200_0[#var_200_0 + 1] = var_200_1
		end
	end

	return var_200_0
end

function var_0_0.filterSelfCards(arg_201_0)
	local var_201_0 = {}

	for iter_201_0 = 1, #arg_201_0 do
		local var_201_1 = arg_201_0[iter_201_0]

		if var_201_1._originOwner == var_201_1._owner then
			var_201_0[#var_201_0 + 1] = var_201_1
		end
	end

	return var_201_0
end

function var_0_0.filterOppoCards(arg_202_0)
	local var_202_0 = {}

	for iter_202_0 = 1, #arg_202_0 do
		local var_202_1 = arg_202_0[iter_202_0]

		if var_202_1._originOwner ~= var_202_1._owner then
			var_202_0[#var_202_0 + 1] = var_202_1
		end
	end

	return var_202_0
end

function var_0_0.filterSameOwnerCards(arg_203_0, arg_203_1)
	local var_203_0 = {}

	for iter_203_0 = 1, #arg_203_0 do
		local var_203_1 = arg_203_0[iter_203_0]

		if var_203_1._owner == arg_203_1._owner then
			var_203_0[#var_203_0 + 1] = var_203_1
		end
	end

	return var_203_0
end

function var_0_0.filterIdMapCards(arg_204_0, arg_204_1, arg_204_2)
	local var_204_0 = {}

	for iter_204_0 = 1, #arg_204_0 do
		local var_204_1 = arg_204_0[iter_204_0]

		if arg_204_2 and arg_204_1 and arg_204_1[var_204_1._id] or not arg_204_2 and (not arg_204_1 or arg_204_1[var_204_1._id] == nil) then
			var_204_0[#var_204_0 + 1] = var_204_1
		end
	end

	return var_204_0
end

function var_0_0.filterNotInGroundCards(arg_205_0)
	local var_205_0 = {}

	for iter_205_0 = 1, #arg_205_0 do
		local var_205_1 = arg_205_0[iter_205_0]

		if #var_205_1._owner:getBattleCardsByInfoId("CSD", var_205_1._infoId) == 0 then
			var_205_0[#var_205_0 + 1] = var_205_1
		end
	end

	return var_205_0
end

function var_0_0.filterMarkLinkComponentToGraveCards(arg_206_0)
	local var_206_0 = {}

	for iter_206_0 = 1, #arg_206_0 do
		local var_206_1 = arg_206_0[iter_206_0]

		if var_206_1._markLinkComponentToGrave then
			var_206_0[#var_206_0 + 1] = var_206_1
		end
	end

	return var_206_0
end

function var_0_0.filterHasSkillInModeCards(arg_207_0, arg_207_1)
	local var_207_0 = {}

	for iter_207_0 = 1, #arg_207_0 do
		local var_207_1 = arg_207_0[iter_207_0]

		if var_207_1:hasSkillInMode(arg_207_1) then
			var_207_0[#var_207_0 + 1] = var_207_1
		end
	end

	return var_207_0
end

function var_0_0.filterNewLiveCards(arg_208_0, arg_208_1)
	local var_208_0 = {}

	for iter_208_0 = 1, #arg_208_0 do
		local var_208_1 = arg_208_0[iter_208_0]

		if (var_208_1:isNewLive1() or var_208_1:isNewLive2()) == arg_208_1 then
			var_208_0[#var_208_0 + 1] = var_208_1
		end
	end

	return var_208_0
end

function var_0_0.filterNewLive2Cards(arg_209_0, arg_209_1)
	local var_209_0 = {}

	for iter_209_0 = 1, #arg_209_0 do
		local var_209_1 = arg_209_0[iter_209_0]

		if var_209_1:isNewLive2() == arg_209_1 then
			var_209_0[#var_209_0 + 1] = var_209_1
		end
	end

	return var_209_0
end

function var_0_0.filterNoSkillInfoIds(arg_210_0, arg_210_1)
	local var_210_0 = {}

	for iter_210_0 = 1, #arg_210_0 do
		local var_210_1 = arg_210_0[iter_210_0]
		local var_210_2 = false
		local var_210_3 = Data.getInfo(var_210_1)

		if var_210_3 and var_210_3._skillId then
			for iter_210_1 = 1, #var_210_3._skillId do
				if var_210_3._skillId[iter_210_1] == arg_210_1 then
					var_210_2 = true

					break
				end
			end
		end

		if not var_210_2 then
			var_210_0[#var_210_0 + 1] = var_210_1
		end
	end

	return var_210_0
end

function var_0_0.filterUniqueInfoIds(arg_211_0)
	local var_211_0 = {}
	local var_211_1 = {}

	for iter_211_0 = 1, #arg_211_0 do
		local var_211_2 = arg_211_0[iter_211_0]

		if var_211_1[var_211_2] == nil then
			var_211_1[var_211_2] = true
			var_211_0[#var_211_0 + 1] = var_211_2
		end
	end

	return var_211_0
end

function var_0_0.getSameNumberHigherInfoId(arg_212_0)
	local var_212_0 = Data._skillInfo[4554]

	for iter_212_0 = 2, #var_212_0._refCards, 2 do
		if var_212_0._refCards[iter_212_0] == arg_212_0 then
			return var_212_0._refCards[iter_212_0 + 1]
		end
	end
end

function var_0_0.cardsHaveSkillId(arg_213_0, arg_213_1)
	for iter_213_0 = 1, #arg_213_0 do
		if arg_213_0[iter_213_0]:hasCanCastMonsterSkillFast(arg_213_1) then
			return true
		end
	end

	return false
end

function var_0_0.cardsNotHaveSkillId(arg_214_0, arg_214_1)
	for iter_214_0 = 1, #arg_214_0 do
		if not arg_214_0[iter_214_0]:hasCanCastMonsterSkillFast(arg_214_1) then
			return true
		end
	end

	return false
end

function var_0_0.isSummon(arg_215_0)
	return arg_215_0:isMonsterRare() and arg_215_0._destStatus == BattleData.CardStatus.board and not arg_215_0:isStatusValNotSummon()
end

function var_0_0.isNormalSummon(arg_216_0)
	return B.isSummon(arg_216_0) and arg_216_0:isStatusValNormalSummon()
end

function var_0_0.isSpecialSummon(arg_217_0)
	return B.isSummon(arg_217_0) and not arg_217_0:isStatusValNormalSummon()
end

function var_0_0.isOppoSummon(arg_218_0, arg_218_1)
	return arg_218_0._owner ~= arg_218_1._owner and B.isSummon(arg_218_1) and not arg_218_1._mark6387 and not arg_218_1._owner._mark4595 and (not B.isSpecialSummon(arg_218_1) or not arg_218_1:hasSkillFast(9031))
end

function var_0_0.isOppoNormalSummon(arg_219_0, arg_219_1)
	return arg_219_0._owner ~= arg_219_1._owner and B.isNormalSummon(arg_219_1) and not arg_219_1._mark6387 and not arg_219_1._owner._mark4595
end

function var_0_0.isOppoSpecialSummon(arg_220_0, arg_220_1)
	return arg_220_0._owner ~= arg_220_1._owner and B.isSpecialSummon(arg_220_1) and not arg_220_1._mark6387 and not arg_220_1._owner._mark4595 and not arg_220_1:hasSkillFast(9031)
end

function var_0_0.isDeal(arg_221_0)
	return arg_221_0._sourceStatus == BattleData.CardStatus.pile and arg_221_0._destStatus == BattleData.CardStatus.hand
end

function var_0_0.isOppoDeal(arg_222_0, arg_222_1)
	return arg_222_0._owner ~= arg_222_1._owner and B.isDeal(arg_222_1)
end

function var_0_0.isToHand(arg_223_0)
	return arg_223_0._destStatus == BattleData.CardStatus.hand
end

function var_0_0.isOppoToHand(arg_224_0, arg_224_1)
	return arg_224_0._owner ~= arg_224_1._owner and B.isToHand(arg_224_1)
end

function var_0_0.isTrapIngoreDefend(arg_225_0)
	local var_225_0 = Data._skillInfo[arg_225_0._skills[1]._id]

	if var_225_0 and (var_225_0._isIgnoreDefend == 2 or var_225_0._isIgnoreDefend == 4 or var_225_0._isIgnoreDefend == 9 or var_225_0._isIgnoreDefend == 10) then
		return true
	end

	if arg_225_0._owner._mark4615 then
		return true
	end

	if arg_225_0:isKeyword(Data._skillInfo[7816]._refCards[1]) and arg_225_0._owner:hasBattleCardsByCanCastMagicSkillFast("D", 7816) then
		return true
	end

	return false
end

function var_0_0.isTrapTriggering(arg_226_0)
	return arg_226_0._type == Data.CardType.trap and (arg_226_0._destStatus == BattleData.CardStatus.show or arg_226_0._statusVal == BattleData.CardStatusVal.h2g_trap)
end

function var_0_0.isOppoTrapTriggering(arg_227_0, arg_227_1)
	return arg_227_0._owner ~= arg_227_1._owner and B.isTrapTriggering(arg_227_1) and not B.isTrapIngoreDefend(arg_227_1)
end

function var_0_0.isOppoTrapTriggeringOnSelfMonster(arg_228_0, arg_228_1)
	if not B.isOppoTrapTriggering(arg_228_0, arg_228_1) then
		return false
	end

	local var_228_0 = arg_228_1:getActionCardTrapTarget()

	return var_228_0 ~= nil and var_228_0:isMonsterRare() and var_228_0._owner == arg_228_0._owner, var_228_0
end

function var_0_0.isOppoTrapTriggeringOnOppoMonster(arg_229_0, arg_229_1)
	if not B.isOppoTrapTriggering(arg_229_0, arg_229_1) then
		return false
	end

	local var_229_0 = arg_229_1:getActionCardTrapTarget()

	return var_229_0 ~= nil and var_229_0:isMonsterRare() and var_229_0._owner == arg_229_1._owner, var_229_0
end

function var_0_0.isMagicIngoreDefend(arg_230_0)
	local var_230_0 = Data._skillInfo[arg_230_0._skills[1]._id]

	if var_230_0 and (var_230_0._isIgnoreDefend == 2 or var_230_0._isIgnoreDefend == 4 or var_230_0._isIgnoreDefend == 9 or var_230_0._isIgnoreDefend == 10) then
		return true
	end

	if arg_230_0._owner._mark4615 then
		return true
	end

	if arg_230_0:isKeyword(Data._skillInfo[2325]._refCards[1]) and arg_230_0._owner:hasBattleCardsByCanCastMonsterSkillFast("B", 2325) then
		return true
	end

	if arg_230_0:isInfoId(Data._skillInfo[7584]._refCards[1]) and arg_230_0._owner:hasBattleCardsByCanCastMagicSkillFast("S", 7584) then
		return true
	end

	if arg_230_0:isKeyword(Data._skillInfo[7816]._refCards[1]) and arg_230_0._owner:hasBattleCardsByCanCastMagicSkillFast("D", 7816) then
		return true
	end

	return false
end

function var_0_0.isMagicCasting(arg_231_0)
	return arg_231_0._type == Data.CardType.magic and (arg_231_0._destStatus == BattleData.CardStatus.show or arg_231_0._destStatus == BattleData.CardStatus.field or arg_231_0._statusVal == BattleData.CardStatusVal.h2g_magic) and (arg_231_0._skills[1] == nil or not Data._skillInfo[arg_231_0._skills[1]._id] or Data._skillInfo[arg_231_0._skills[1]._id]._isIgnoreDefend ~= 5 and Data._skillInfo[arg_231_0._skills[1]._id]._isIgnoreDefend ~= 6 and Data._skillInfo[arg_231_0._skills[1]._id]._isIgnoreDefend ~= 11 and (arg_231_0._skills[1]._id ~= 4861 or not (#arg_231_0._owner:getBattleCardsByInfoIdGroup("B", Data._skillInfo[4861]._refCards) > 0)))
end

function var_0_0.isSelfMagicCasting(arg_232_0, arg_232_1)
	return arg_232_0._owner == arg_232_1._owner and B.isMagicCasting(arg_232_1) and not B.isMagicIngoreDefend(arg_232_1)
end

function var_0_0.isOppoMagicCasting(arg_233_0, arg_233_1)
	return arg_233_0._owner ~= arg_233_1._owner and B.isMagicCasting(arg_233_1) and not B.isMagicIngoreDefend(arg_233_1)
end

function var_0_0.isOppoMagicCastingOnSelfMonster(arg_234_0, arg_234_1)
	if not B.isOppoMagicCasting(arg_234_0, arg_234_1) then
		return false
	end

	local var_234_0 = arg_234_1:getActionCardMagicTarget()

	return var_234_0 ~= nil and var_234_0:isMonsterRare() and var_234_0._owner == arg_234_0._owner, var_234_0
end

function var_0_0.isOppoMagicCastingOnOppoMonster(arg_235_0, arg_235_1)
	return B.isOppoMagicCasting(arg_235_0, arg_235_1) and arg_235_1._magicTarget ~= nil and arg_235_1._magicTarget:isMonsterRare() and arg_235_1._magicTarget._owner == arg_235_1._owner, arg_235_1._magicTarget
end

function var_0_0.isMonsterLeftBoard(arg_236_0)
	return arg_236_0:isMonsterRare() and arg_236_0._sourceStatus == BattleData.CardStatus.board and arg_236_0._destStatus ~= BattleData.CardStatus.board
end

function var_0_0.isSelfMonsterLeftBoard(arg_237_0, arg_237_1)
	return arg_237_0._owner == arg_237_1._owner and B.isMonsterLeftBoard(arg_237_1)
end

function var_0_0.isMonsterDestroyed(arg_238_0)
	return B.isMonsterLeftBoard(arg_238_0) and not arg_238_0:isStatusValSacrifice() and not arg_238_0:isStatusValCost() and not arg_238_0:isStatusValLeaveTemp() and (arg_238_0._destStatus == BattleData.CardStatus.grave or arg_238_0._destStatus == BattleData.CardStatus.leave or arg_238_0._destStatus == BattleData.CardStatus.pile and arg_238_0._statusVal == BattleData.CardStatusVal.b2g_kill_by_attack)
end

function var_0_0.isSelfMonsterDestroyed(arg_239_0, arg_239_1)
	return arg_239_0._owner == arg_239_1._owner and B.isMonsterDestroyed(arg_239_1)
end

function var_0_0.isOppoMonsterDestroyed(arg_240_0, arg_240_1)
	return arg_240_0._owner ~= arg_240_1._owner and B.isMonsterDestroyed(arg_240_1)
end

function var_0_0.isMagicLeftBoard(arg_241_0)
	return arg_241_0._type == Data.CardType.magic and (arg_241_0._sourceStatus == BattleData.CardStatus.show and arg_241_0._destStatus ~= BattleData.CardStatus.show or arg_241_0._sourceStatus == BattleData.CardStatus.field and arg_241_0._destStatus ~= BattleData.CardStatus.field)
end

function var_0_0.isMagicDestroyed(arg_242_0)
	return B.isMagicLeftBoard(arg_242_0) and (arg_242_0._destStatus == BattleData.CardStatus.grave or arg_242_0._destStatus == BattleData.CardStatus.leave)
end

function var_0_0.isTrapLeftBoard(arg_243_0)
	return arg_243_0._type == Data.CardType.trap and (arg_243_0._sourceStatus == BattleData.CardStatus.show or arg_243_0._sourceStatus == BattleData.CardStatus.cover) and arg_243_0._destStatus ~= BattleData.CardStatus.show and arg_243_0._destStatus ~= BattleData.CardStatus.cover
end

function var_0_0.isTrapDestroyed(arg_244_0)
	return B.isTrapLeftBoard(arg_244_0) and (arg_244_0._destStatus == BattleData.CardStatus.grave or arg_244_0._destStatus == BattleData.CardStatus.leave)
end

function var_0_0.isCardLeftBoard(arg_245_0)
	return B.isMonsterLeftBoard(arg_245_0) or B.isMagicLeftBoard(arg_245_0) or B.isTrapLeftBoard(arg_245_0)
end

function var_0_0.isCardDestroyed(arg_246_0)
	return B.isMonsterDestroyed(arg_246_0) or B.isMagicDestroyed(arg_246_0) or B.isTrapDestroyed(arg_246_0)
end

function var_0_0.isSelfCardDestroyed(arg_247_0, arg_247_1)
	return arg_247_0._owner == arg_247_1._owner and B.isCardDestroyed(arg_247_1)
end

function var_0_0.isCardToLeave(arg_248_0)
	return arg_248_0._destStatus == BattleData.CardStatus.leave
end

function var_0_0.isSelfCardToLeave(arg_249_0, arg_249_1)
	return arg_249_0._owner == arg_249_1._owner and B.isCardToLeave(arg_249_1)
end

function var_0_0.isFortressDamaged(arg_250_0)
	return arg_250_0._type == Data.CardType.fortress and arg_250_0._sourceStatus == BattleData.CardStatus.fortress and arg_250_0._destStatus == BattleData.CardStatus.fortress and arg_250_0._statusVal == BattleData.CardStatusVal.f2f_fortress_damaged
end

function var_0_0.isSelfFortressDamaged(arg_251_0, arg_251_1)
	return arg_251_0._owner == arg_251_1._owner and B.isFortressDamaged(arg_251_1)
end

function var_0_0.isFortressHpAdded(arg_252_0)
	return arg_252_0._type == Data.CardType.fortress and arg_252_0._sourceStatus == BattleData.CardStatus.fortress and arg_252_0._destStatus == BattleData.CardStatus.fortress and arg_252_0._statusVal == BattleData.CardStatusVal.f2f_fortress_hp_added
end

function var_0_0.isOppoFortressHpAdded(arg_253_0, arg_253_1)
	return arg_253_0._owner ~= arg_253_1._owner and B.isFortressHpAdded(arg_253_1)
end

function var_0_0.mergeTable(arg_254_0)
	local var_254_0 = {}

	for iter_254_0 = 1, #arg_254_0 do
		for iter_254_1 = 1, #arg_254_0[iter_254_0] do
			var_254_0[#var_254_0 + 1] = arg_254_0[iter_254_0][iter_254_1]
		end
	end

	return var_254_0
end

function var_0_0.appendTable(arg_255_0, arg_255_1)
	if #arg_255_1 == 0 then
		return
	end

	for iter_255_0 = 1, #arg_255_1 do
		arg_255_0[#arg_255_0 + 1] = arg_255_1[iter_255_0]
	end
end

function var_0_0.reverseTable(arg_256_0)
	local var_256_0 = {}

	for iter_256_0 = #arg_256_0, 1, -1 do
		var_256_0[#var_256_0 + 1] = arg_256_0[iter_256_0]
	end

	return var_256_0
end

function var_0_0.tableCount(arg_257_0)
	local var_257_0 = next(arg_257_0)
	local var_257_1 = 0

	while var_257_0 do
		var_257_1 = var_257_1 + 1
		var_257_0 = next(arg_257_0, var_257_0)
	end

	return var_257_1
end

function var_0_0.combinateTable(arg_258_0, arg_258_1, arg_258_2)
	if arg_258_1 > #arg_258_0 then
		return
	end

	if B._combination[#arg_258_0] == nil then
		return
	end

	local var_258_0 = B._combination[#arg_258_0][arg_258_1][arg_258_2]

	if var_258_0 == nil then
		return
	end

	local var_258_1 = {}

	for iter_258_0 = 1, #var_258_0 do
		var_258_1[iter_258_0] = arg_258_0[var_258_0[iter_258_0]]
	end

	return var_258_1
end

function var_0_0.tableContain(arg_259_0, arg_259_1)
	if arg_259_0 == nil or #arg_259_0 == 0 then
		return false
	end

	for iter_259_0 = 1, #arg_259_0 do
		if arg_259_0[iter_259_0] == arg_259_1 then
			return true
		end
	end

	return false
end

function var_0_0.isValidMergeComponent(arg_260_0, arg_260_1, arg_260_2)
	if arg_260_0 > Data.INFO_ID_GROUP_SIZE_LARGE then
		if arg_260_0 == 10004 and arg_260_2._infoId == 40494 then
			return arg_260_1:isInfoId(arg_260_0) or arg_260_1:isInfoId(10006) or arg_260_1:hasSkills({
				3072
			}) and not arg_260_2:hasSkills({
				3087
			})
		else
			return arg_260_1:isInfoId(arg_260_0) or arg_260_1:hasSkills({
				3072
			}) and not arg_260_2:hasSkills({
				3087
			})
		end
	end

	local var_260_0 = Data.getType(arg_260_0)
	local var_260_1 = arg_260_0 % Data.INFO_ID_GROUP_SIZE
	local var_260_2 = arg_260_0 % Data.INFO_ID_GROUP_SIZE_SMALL

	if var_260_0 == Data.CardType.nature then
		if arg_260_0 == 1002 and arg_260_2._infoId == 40470 then
			return arg_260_1:isNature(var_260_1) and arg_260_1._info._category == Data.CardCategory.angle
		else
			return arg_260_1:isNature(var_260_1)
		end
	elseif var_260_0 == Data.CardType.category then
		if arg_260_0 == 2004 and arg_260_2._infoId == 40364 then
			return arg_260_1._info._category == var_260_1 and arg_260_1:getStar() >= 6
		elseif arg_260_0 == 2006 and arg_260_2._infoId == 40400 then
			return arg_260_1._info._category == var_260_1 and arg_260_1:isNature(Data.CardNature.earth) and arg_260_1:isSync()
		elseif arg_260_0 == 2002 and arg_260_2._infoId == 40495 then
			return arg_260_1._info._category == var_260_1 and arg_260_1:isEffectMonster() or arg_260_1:isInfoId(10086) or arg_260_1:hasSkills({
				3072
			}) and not arg_260_2:hasSkills({
				3087
			})
		elseif arg_260_0 == 2002 and (arg_260_2._infoId == 40056 or arg_260_2._infoId == 40539) then
			if #arg_260_2._owner:getBattleCardsByInfoId("B", 40535) > 0 then
				return arg_260_1._info._category == var_260_1 or arg_260_1._owner ~= arg_260_2._owner
			else
				return arg_260_1._info._category == var_260_1
			end
		elseif arg_260_0 == 2006 and arg_260_2._infoId == 40640 then
			return arg_260_1._info._category == var_260_1 and arg_260_1:isNature(Data.CardNature.light)
		else
			return arg_260_1._info._category == var_260_1
		end
	elseif var_260_0 == Data.CardType.keyword then
		if arg_260_0 == 3003 and arg_260_2._infoId == 40033 then
			return arg_260_1:isKeyword(var_260_1) and arg_260_1:getStar() == 6 and arg_260_1:isNormalMonster()
		elseif arg_260_0 == 3008 and arg_260_2._infoId == 40033 then
			return arg_260_1:isKeyword(var_260_1) and arg_260_1:isNormalMonster()
		elseif arg_260_0 == 3104 and arg_260_2:isInInfoIdGroup({
			40272,
			40276
		}) then
			return arg_260_1:isKeyword(var_260_1) and arg_260_1:isNormalMonster()
		elseif arg_260_0 == 3103 and arg_260_2._infoId == 40534 then
			return arg_260_1:isKeyword(var_260_1) or arg_260_1:isKeyword(Data._skillInfo[13046]._refCards[1])
		elseif arg_260_0 == 3104 and arg_260_2._infoId == 40658 then
			return arg_260_1:isKeyword(var_260_1) and arg_260_1:canMergeFrom()
		elseif arg_260_0 == 3906 and arg_260_2._infoId == 40662 then
			return arg_260_1:isKeyword(var_260_1 - 900) and arg_260_1:isMerge()
		else
			return arg_260_1:isKeyword(var_260_1)
		end
	elseif var_260_0 == Data.CardType.flag then
		local var_260_3 = 2^(var_260_1 - 1)

		if var_260_3 == Data.MonsterOption.is_sync and arg_260_2._infoId == 40116 then
			return arg_260_1:hasMonsterOption(var_260_3) and arg_260_1._info._category == 23
		elseif var_260_3 == Data.MonsterOption.is_merge and arg_260_2._infoId == 40168 then
			return arg_260_1:hasMonsterOption(var_260_3) and arg_260_1:isKeyword(103)
		elseif var_260_3 == Data.MonsterOption.is_normal then
			return arg_260_1:isNormalMonster()
		elseif var_260_3 == Data.MonsterOption.is_effect then
			if arg_260_2._infoId == 40274 then
				return arg_260_1:isEffectMonster() and arg_260_1:getStar() <= 4
			end

			return arg_260_1:isEffectMonster()
		else
			return arg_260_1:hasMonsterOption(var_260_3)
		end
	elseif var_260_0 == Data.CardType.star then
		return not arg_260_1:isXYZ() and not arg_260_1:isLink() and arg_260_1:getStar() == var_260_2
	elseif var_260_0 == Data.CardType.min_star then
		if arg_260_0 == 305 and arg_260_2._infoId == 40424 then
			return not arg_260_1:isXYZ() and not arg_260_1:isLink() and var_260_2 <= arg_260_1:getStar() and arg_260_1:isKeyword(158)
		else
			return not arg_260_1:isXYZ() and not arg_260_1:isLink() and var_260_2 <= arg_260_1:getStar()
		end
	elseif var_260_0 == Data.CardType.card_type then
		return arg_260_1._type == var_260_2
	elseif var_260_0 == Data.CardType.max_quality then
		return arg_260_1:isMonsterRare() and var_260_2 >= arg_260_1._info._quality
	elseif var_260_0 == Data.CardType.max_star then
		if arg_260_0 == 306 and arg_260_2._infoId == 40646 then
			return var_260_2 >= arg_260_1:getStar() and arg_260_1:isKeyword(104)
		else
			return var_260_2 >= arg_260_1:getStar()
		end
	end

	return false
end

function var_0_0.isValidSyncAdjustComponent(arg_261_0, arg_261_1, arg_261_2, arg_261_3)
	if arg_261_0 > Data.INFO_ID_GROUP_SIZE_LARGE then
		if arg_261_2:isInfoId(arg_261_0) then
			return true
		end

		local var_261_0 = Data.getInfo(arg_261_0)

		if var_261_0._keyword == Data._skillInfo[3893]._refCards[1] and arg_261_2:hasSkillFast(3893) then
			return true
		end

		if var_261_0._keyword == Data._skillInfo[2302]._refCards[1] and arg_261_2:hasSkillFast(2302) then
			return true
		end

		if arg_261_0 == Data._skillInfo[2613]._refCards[1] and arg_261_2:hasSkillFast(2613) then
			return true
		end

		return false
	else
		if arg_261_2:isSuperId(arg_261_0) then
			for iter_261_0 = 1, #arg_261_1 do
				local var_261_1 = arg_261_1[iter_261_0]

				if var_261_1 ~= 0 then
					if var_261_1 > Data.INFO_ID_GROUP_SIZE_LARGE then
						if not arg_261_2:isInfoId(var_261_1) then
							return false
						end
					elseif not arg_261_2:isSuperId(var_261_1) then
						return false
					end
				end
			end
		end

		return true
	end
end

function var_0_0.isValidNotAdjustCards(arg_262_0, arg_262_1, arg_262_2, arg_262_3, arg_262_4, arg_262_5, arg_262_6)
	local var_262_0 = arg_262_0:getStar()
	local var_262_1 = false
	local var_262_2 = false
	local var_262_3

	if arg_262_0._infoId == 40315 and #B.filterEqualInfoIdCards(arg_262_2, 40122) == 0 then
		return false
	end

	for iter_262_0 = 1, #arg_262_1 do
		var_262_0 = var_262_0 - arg_262_1[iter_262_0]:getSyncStar(arg_262_0)

		if arg_262_1[iter_262_0]._status == BattleData.CardStatus.board then
			var_262_1 = true
		end

		if arg_262_1[iter_262_0]:hasSkillFast(6713) then
			var_262_3 = Data._skillInfo[6713]._refCards[1]
		elseif arg_262_1[iter_262_0]:hasSkillFast(2567) then
			var_262_3 = Data._skillInfo[2567]._refCards[1]
		end
	end

	if var_262_0 <= 0 then
		return false
	end

	if var_262_3 and #B.filterInKeywordCards(arg_262_1, var_262_3) ~= #arg_262_1 then
		return false
	end

	if arg_262_5 then
		if var_262_3 and #B.filterInKeywordCards(arg_262_2, var_262_3) ~= #arg_262_2 then
			return false
		end

		local var_262_4 = 0

		for iter_262_1 = 1, #arg_262_2 do
			var_262_4 = var_262_4 + arg_262_2[iter_262_1]:getSyncStar(arg_262_0)

			if arg_262_2[iter_262_1]._status == BattleData.CardStatus.board then
				var_262_2 = true
			end
		end

		if var_262_4 == var_262_0 and (var_262_1 or var_262_2 or not arg_262_4) then
			return true, arg_262_2
		else
			return false
		end
	end

	arg_262_2 = B.filterLessThanSyncStarCards(arg_262_2, arg_262_0, var_262_0)

	if var_262_3 then
		arg_262_2 = B.filterInKeywordCards(arg_262_2, var_262_3)
	end

	if arg_262_3 > #arg_262_2 then
		return false
	end

	if arg_262_0._infoId == 40315 and #B.filterEqualInfoIdCards(arg_262_2, 40122) == 0 then
		return false
	end

	local var_262_5 = {}
	local var_262_6 = 0

	for iter_262_2 = 1, #arg_262_2 do
		var_262_5[iter_262_2] = arg_262_2[iter_262_2]:getSyncStar(arg_262_0)
		var_262_6 = var_262_6 + var_262_5[iter_262_2]
	end

	if var_262_6 < var_262_0 then
		return false
	end

	if not arg_262_6 and arg_262_3 == 1 and (var_262_1 or not arg_262_4) then
		if var_262_6 == var_262_0 then
			return true
		end

		table.sort(var_262_5, function(arg_263_0, arg_263_1)
			return arg_263_0 < arg_263_1
		end)

		local var_262_7 = 0

		for iter_262_3 = 1, #var_262_5 do
			local var_262_8 = var_262_5[iter_262_3]

			if var_262_8 == var_262_0 or var_262_6 - var_262_8 == var_262_0 then
				return true
			elseif var_262_0 < var_262_8 then
				break
			end
		end

		local var_262_9 = 0

		if #var_262_5 >= 2 then
			for iter_262_4 = 1, #var_262_5 - 1 do
				for iter_262_5 = iter_262_4 + 1, #var_262_5 do
					var_262_9 = var_262_5[iter_262_4] + var_262_5[iter_262_5]

					if var_262_9 == var_262_0 or var_262_6 - var_262_9 == var_262_0 then
						return true
					elseif var_262_0 < var_262_9 then
						break
					end
				end

				if var_262_0 < var_262_9 then
					break
				end
			end
		end

		local var_262_10 = 0

		if #var_262_5 >= 3 then
			for iter_262_6 = 1, #var_262_5 - 2 do
				for iter_262_7 = iter_262_6 + 1, #var_262_5 - 1 do
					for iter_262_8 = iter_262_7 + 1, #var_262_5 do
						var_262_10 = var_262_5[iter_262_6] + var_262_5[iter_262_7] + var_262_5[iter_262_8]

						if var_262_10 == var_262_0 or var_262_6 - var_262_10 == var_262_0 then
							return true
						elseif var_262_0 < var_262_10 then
							break
						end
					end

					if var_262_0 < var_262_10 then
						break
					end
				end

				if var_262_0 < var_262_10 then
					break
				end
			end
		end

		if #var_262_5 <= 3 then
			return false
		end
	end

	if #arg_262_2 > #B._combination then
		return true, nil
	end

	for iter_262_9 = arg_262_3, #arg_262_2 do
		local var_262_11 = 65535
		local var_262_12 = 1

		while true do
			local var_262_13 = B.combinateTable(arg_262_2, iter_262_9, var_262_12)

			if var_262_13 == nil then
				break
			end

			local var_262_14 = 0
			local var_262_15 = false

			for iter_262_10 = 1, #var_262_13 do
				var_262_14 = var_262_14 + var_262_13[iter_262_10]:getSyncStar(arg_262_0)

				if var_262_14 < var_262_11 then
					var_262_11 = var_262_14
				end

				if var_262_13[iter_262_10]._status == BattleData.CardStatus.board then
					var_262_15 = true
				end

				if var_262_14 == var_262_0 and (var_262_1 or var_262_15 or not arg_262_4) then
					return true, var_262_13
				end
			end

			var_262_12 = var_262_12 + 1
		end

		if var_262_0 < var_262_11 then
			break
		end
	end

	return false
end

function var_0_0.getChoiceByCandidatePos(arg_264_0, arg_264_1)
	local var_264_0 = 0
	local var_264_1 = 1

	for iter_264_0 = 1, #arg_264_0 do
		arg_264_0[iter_264_0]._tempIndex = var_264_1
		var_264_1 = var_264_1 + 1
	end

	for iter_264_1 = 1, #arg_264_1 do
		var_264_0 = var_264_0 + 2^(arg_264_1[iter_264_1]._tempIndex - 1)
	end

	for iter_264_2 = 1, #arg_264_0 do
		arg_264_0[iter_264_2]._tempIndex = nil
	end

	return var_264_0
end

function var_0_0.getToBoardPos(arg_265_0, arg_265_1)
	if arg_265_0 == nil then
		return nil
	end

	local var_265_0 = arg_265_0[BattleData.ExtraType.pos]

	if var_265_0 == nil then
		return nil
	end

	for iter_265_0 = 1, #var_265_0 do
		if var_265_0[iter_265_0] % 10000 == arg_265_1 then
			return math.floor(var_265_0[iter_265_0] / 10000)
		end
	end

	return nil
end

function var_0_0.getSumLink(arg_266_0)
	local var_266_0 = 0

	for iter_266_0 = 1, #arg_266_0 do
		var_266_0 = var_266_0 + arg_266_0[iter_266_0]:getLink()
	end

	return var_266_0
end

function var_0_0.getMaxLink(arg_267_0)
	local var_267_0 = 0

	for iter_267_0 = 1, #arg_267_0 do
		local var_267_1 = arg_267_0[iter_267_0]:getLink()

		if var_267_0 < var_267_1 then
			var_267_0 = var_267_1
		end
	end

	return var_267_0
end

function var_0_0.isMark(arg_268_0)
	return arg_268_0 == BattleData.PositiveType.magicMark or arg_268_0 == BattleData.PositiveType.pumpkinMark or arg_268_0 == BattleData.PositiveType.dinosaurMark or arg_268_0 == BattleData.PositiveType.sugarMark or arg_268_0 == BattleData.PositiveType.sugarMark2 or arg_268_0 == BattleData.PositiveType.deathMark or arg_268_0 == BattleData.PositiveType.satelliteMark or arg_268_0 == BattleData.PositiveType.oceanMark or arg_268_0 == BattleData.PositiveType.snowMark or arg_268_0 == BattleData.PositiveType.wasteMark or arg_268_0 == BattleData.PositiveType.boxMark or arg_268_0 == BattleData.PositiveType.stormMark or arg_268_0 == BattleData.PositiveType.shieldMark or arg_268_0 == BattleData.PositiveType.samuraiMark or arg_268_0 == BattleData.PositiveType.phoenixMark or arg_268_0 == BattleData.PositiveType.soulMark or arg_268_0 == BattleData.PositiveType.foreverFireMark or arg_268_0 == BattleData.PositiveType.cjMark or arg_268_0 == BattleData.PositiveType.forestMark or arg_268_0 == BattleData.PositiveType.techMark or arg_268_0 == BattleData.PositiveType.syncMark or arg_268_0 == BattleData.PositiveType.resonateMark or arg_268_0 == BattleData.PositiveType.gustoMark or arg_268_0 == BattleData.PositiveType.sunFlowerMark or arg_268_0 == BattleData.PositiveType.deedMark or arg_268_0 == BattleData.PositiveType.featherMark or arg_268_0 == BattleData.PositiveType.weddingMark or arg_268_0 == BattleData.PositiveType.revolverMark or arg_268_0 == BattleData.PositiveType.plantMark or arg_268_0 == BattleData.PositiveType.dMark or arg_268_0 == BattleData.PositiveType.ironMark or arg_268_0 == BattleData.PositiveType.xyzMark or arg_268_0 == BattleData.PositiveType.puppetMark or arg_268_0 == BattleData.PositiveType.fateMark or arg_268_0 == BattleData.PositiveType.potMark or arg_268_0 == BattleData.PositiveType.ylyMark or arg_268_0 == BattleData.PositiveType.sideEffectMark or arg_268_0 == BattleData.PositiveType.lineMark or arg_268_0 == BattleData.PositiveType.universeMark or arg_268_0 == BattleData.PositiveType.hsjMark or arg_268_0 == BattleData.PositiveType.bigSunMark or arg_268_0 == BattleData.PositiveType.digMark or arg_268_0 == BattleData.PositiveType.allyMark or arg_268_0 == BattleData.PositiveType.ddMark or arg_268_0 == BattleData.PositiveType.sacriMark or arg_268_0 == BattleData.PositiveType.fireStarMark or arg_268_0 == BattleData.PositiveType.koiMark or arg_268_0 == BattleData.PositiveType.godMark or arg_268_0 == BattleData.PositiveType.summonMark or arg_268_0 == BattleData.PositiveType.dessertMark or arg_268_0 == BattleData.PositiveType.yiguaiMark or arg_268_0 == BattleData.PositiveType.crystalMark or arg_268_0 == BattleData.PositiveType.magicCardMark or arg_268_0 == BattleData.PositiveType.trapCardMark or arg_268_0 == BattleData.PositiveType.guangboMark or arg_268_0 == BattleData.PositiveType.yingyiMark or arg_268_0 == BattleData.PositiveType.bianMark or arg_268_0 == BattleData.PositiveType.sixFlowerMark or arg_268_0 == BattleData.PositiveType.huanmoMark or arg_268_0 == BattleData.PositiveType.gunMark or arg_268_0 == BattleData.PositiveType.bjjMark or arg_268_0 == BattleData.PositiveType.newLiveMark
end

function var_0_0.isStatusChange(arg_269_0, arg_269_1, arg_269_2, arg_269_3, arg_269_4)
	for iter_269_0 = 1, arg_269_0 do
		if arg_269_1[iter_269_0] ~= arg_269_3[iter_269_0] then
			return true
		end

		if type(arg_269_2[iter_269_0]) ~= type(arg_269_4[iter_269_0]) then
			return true
		end

		if type(arg_269_2[iter_269_0]) == "number" and arg_269_2[iter_269_0] ~= arg_269_4[iter_269_0] then
			return true
		end

		if type(arg_269_2[iter_269_0]) == "table" then
			if #arg_269_2[iter_269_0] ~= #arg_269_4[iter_269_0] then
				return true
			end

			local var_269_0 = 0
			local var_269_1 = 0

			for iter_269_1 = 1, #arg_269_2[iter_269_0] do
				var_269_0 = var_269_0 + arg_269_2[iter_269_0][iter_269_1]
				var_269_1 = var_269_1 + arg_269_4[iter_269_0][iter_269_1]
			end

			if var_269_0 ~= var_269_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.parseOperations(arg_270_0, arg_270_1, arg_270_2)
	local var_270_0 = arg_270_2 and 3 or 4
	local var_270_1 = {
		_totalCostedTime = 0
	}

	if var_270_0 <= #arg_270_1 then
		local var_270_2 = 1

		while var_270_2 <= #arg_270_1 do
			if not arg_270_1[var_270_2] or not arg_270_1[var_270_2 + 1] then break end
			local var_270_3 = {
				_card = arg_270_1[var_270_2] % 10000,
				_cardInfoId = math.floor(arg_270_1[var_270_2] / 10000),
				_target = arg_270_1[var_270_2 + 1] % 10000,
				_extraCount = math.floor(arg_270_1[var_270_2 + 1] / 10000),
				_choice = arg_270_1[var_270_2 + 2],
				_timestamp = arg_270_2 and 0 or arg_270_1[var_270_2 + 3]
			}
			local var_270_4 = arg_270_2 and 3 or 4

			if var_270_3._card == BattleData.UseCardId.round then
				var_270_4 = (not arg_270_2 and (var_270_2 + 6 <= #arg_270_1)) and 7 or (arg_270_2 and 3 or 4)
				var_270_3._timestamp2 = arg_270_2 and 0 or arg_270_1[var_270_2 + 4]

				if ClientData then
					ClientData.saveBattleTimingInfo(var_270_3, arg_270_0)

					if not arg_270_2 then
						var_270_1._attackerSurvialTime = arg_270_1[var_270_2 + 5] or 0
						var_270_1._defenderSurvialTime = arg_270_1[var_270_2 + 6] or 0
					end
				end
			end

			var_270_2 = var_270_2 + var_270_4

			if var_270_3._extraCount > 0 then
				var_270_3._extra = {}

				for iter_270_0 = 1, var_270_3._extraCount do
					local var_270_5 = arg_270_1[var_270_2]

					if var_270_5 ~= nil then
						var_270_3._extra[var_270_5] = {}

						local var_270_6 = arg_270_1[var_270_2 + 1] or 0

						for iter_270_1 = 1, var_270_6 do
							var_270_3._extra[var_270_5][iter_270_1] = arg_270_1[var_270_2 + 1 + iter_270_1]
						end

						var_270_2 = var_270_2 + 2 + var_270_6
					else
						break
					end
				end
			end

			if var_270_3._card == BattleData.UseCardId.round and var_270_3._target == 0 then
				-- block empty
			else
				local is_dup = false
				local prev_op = var_270_1[#var_270_1]
				if prev_op and prev_op._card == var_270_3._card and prev_op._target == var_270_3._target and prev_op._choice == var_270_3._choice and prev_op._timestamp == var_270_3._timestamp and (var_270_3._timestamp and var_270_3._timestamp > 0) then
					is_dup = true
				end
				if not is_dup then
					table.insert(var_270_1, var_270_3)
				end
			end
		end
	end

	return var_270_1
end

function var_0_0.extendId(arg_271_0, arg_271_1)
	if arg_271_1 >= BattleData.UseCardId.attacker_base or arg_271_1 < BattleData.UseCardId.id_group then
		local var_271_0 = arg_271_0:getCardById(arg_271_1)

		if var_271_0 ~= nil then
			arg_271_1 = var_271_0._infoId * 10000 + arg_271_1
		end
	end

	return arg_271_1
end

function var_0_0.initProfile(arg_272_0)
	B._totalTime = {}
	B._startTime = {}
	B._profileCount = {}
	B._profileLevel = arg_272_0
end

function var_0_0.beginProfile(arg_273_0, arg_273_1)
	if arg_273_1 <= B._profileLevel then
		B._startTime[arg_273_0] = os.clock()
		B._profileCount[arg_273_0] = (B._profileCount[arg_273_0] or 0) + 1
	end
end

function var_0_0.endProfile(arg_274_0)
	if not B._startTime then
		return
	end

	if B._startTime[arg_274_0] then
		B._totalTime[arg_274_0] = (B._totalTime[arg_274_0] or 0) + os.clock() - B._startTime[arg_274_0]
		B._startTime[arg_274_0] = nil
	end
end

function var_0_0.dumpProfile()
	if not B._totalTime then
		return
	end

	if B._totalTime.battle then
		print(string.format("%6.3f  %6.2f%%  Total", B._totalTime.battle, B._totalTime.battle * 100 / B._totalTime.battle))
		print("-------------------------------------")
	end

	for iter_275_0, iter_275_1 in pairs(B._totalTime) do
		if iter_275_0 ~= "battle" then
			print(string.format("%6.3f  %6.2f%%  %7d  %s", iter_275_1, iter_275_1 * 100 / B._totalTime.battle, B._profileCount[iter_275_0], iter_275_0))
		end
	end
end

function var_0_0.splitStringWithParenthesis(arg_276_0, arg_276_1)
	if string.find(arg_276_0, arg_276_1) == nil then
		return {
			arg_276_0
		}, {}
	end

	local var_276_0 = 0
	local var_276_1 = 1
	local var_276_2 = 1
	local var_276_3 = {}
	local var_276_4 = {}

	while var_276_2 <= #arg_276_0 do
		local var_276_5 = string.sub(arg_276_0, var_276_2, var_276_2)

		if var_276_5 == "(" then
			var_276_0 = var_276_0 + 1
		elseif var_276_5 == ")" then
			var_276_0 = var_276_0 - 1
		elseif var_276_0 == 0 and var_276_1 < var_276_2 then
			local var_276_6, var_276_7 = string.find(string.sub(arg_276_0, var_276_2), arg_276_1)

			if var_276_6 == 1 then
				var_276_3[#var_276_3 + 1] = string.sub(arg_276_0, var_276_1, var_276_2 - 1)
				var_276_4[#var_276_4 + 1] = string.sub(arg_276_0, var_276_2, var_276_2 + var_276_7 - var_276_6)
				var_276_2 = var_276_2 + var_276_7 - var_276_6
				var_276_1 = var_276_2 + 1
			elseif var_276_6 == nil then
				var_276_2 = #arg_276_0 + 1

				break
			end
		end

		var_276_2 = var_276_2 + 1
	end

	var_276_3[#var_276_3 + 1] = string.sub(arg_276_0, var_276_1, var_276_2 - 1)

	return var_276_3, var_276_4
end

function var_0_0.getSmallRound(arg_277_0, arg_277_1)
	local var_277_0 = arg_277_1 * 2

	if arg_277_0 then
		var_277_0 = var_277_0 - 1
	end

	return var_277_0
end
