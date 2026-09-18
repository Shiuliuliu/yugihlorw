local var_0_0 = {
	getCardQuality = function(arg_1_0)
		return arg_1_0._info._quality or -1
	end,
	getCardReputation = function(arg_2_0)
		if arg_2_0._type == Data.CardType.weapon or arg_2_0._type == Data.CardType.armor then
			return 0
		end

		return arg_2_0._info._reputation
	end,
	getCardCost = function(arg_3_0)
		if arg_3_0._type == Data.CardType.monster then
			return arg_3_0._info._cost
		else
			return 0
		end
	end,
	getCardFrameId = function(arg_4_0)
		if arg_4_0._type ~= Data.CardType.monster then
			return 0
		end

		if Data.getRebirth(arg_4_0._info._id) > 0 then
			return #Data.EVO_LV_HERO_UNLOCK_SKILLS - 1
		else
			return #Data.EVO_LV_HERO_UNLOCK_SKILLS - 1
		end
	end,
	getSkillFightingFactor = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		local var_5_0 = Data._skillInfo[arg_5_0]

		arg_5_1 = arg_5_1 or 1
		arg_5_1 = var_5_0._val[arg_5_1] > 0 and arg_5_1 or 1
		arg_5_2 = var_5_0._val[arg_5_1] > 0 and arg_5_2 or 2

		if arg_5_3 == Data.CardType.monster then
			return Data.SkillOutputParam * Data.SkillQualityParam[var_5_0._quality] / 5 * (arg_5_1 / arg_5_2)
		else
			return Data.SkillOutputParam * Data.CardQualityParam[arg_5_4] * (arg_5_1 / arg_5_2)
		end
	end,
	getSkillMaxLevel = function(arg_6_0)
		local var_6_0 = Data._skillInfo[arg_6_0]

		for iter_6_0 = 1, #var_6_0._val do
			if var_6_0._val[iter_6_0] == 0 then
				return math.max(1, iter_6_0 - 1)
			end
		end

		return #var_6_0._val
	end,
	getCardsTotalCount = function(arg_7_0)
		local var_7_0 = 0

		for iter_7_0 = 1, #arg_7_0 do
			var_7_0 = var_7_0 + arg_7_0[iter_7_0]._num
		end

		return var_7_0
	end
}

CardHelper = var_0_0

return var_0_0
