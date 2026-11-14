function var_0_0.checkChoiceGrave(arg_91_0, arg_91_1, arg_91_2, arg_91_3, arg_91_4)
	local var_91_0 = arg_91_1:getSelectedCount()

	if arg_91_2._card:isSkillAtIndex(9489, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return false
	end

	if arg_91_2._card:isSkillAtIndex(9552, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return true
	end

	if arg_91_2._card:isSkillAtIndex(9944, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_1._alreadySatisfied then
		return true
	end

	if arg_91_2._card:isSkillAtIndex(3994, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 > 0
	elseif arg_91_2._card:isSkillAtIndex(13275, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 > 0
	elseif arg_91_2._card:isSkillAtIndex(13276, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 > 0
	elseif arg_91_2._card:isSkillAtIndex(13719, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 > 0
	elseif arg_91_2._card:hasSkills({
		4095,
		4318
	}) then
		return var_91_0 > 0
	elseif arg_91_2._card:hasSkills({
		3866,
		4350,
		4384,
		4390,
		4408,
		4424,
		4510,
		4558,
		4689,
		4701,
		4730,
		4853,
		4870,
		4939,
		4943,
		5204,
		5309,
		5400,
		6528,
		6684,
		2352,
		2354,
		2384,
		2404,
		2431,
		2878,
		9067,
		9142,
		7199,
		7305,
		8071
	}) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card:hasSkillFast(4425) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0 and #B.filterNormalCards(arg_91_1:getSelectedCards(), true) > 0
	elseif arg_91_2._card:isSkillAtIndex(4458, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if var_91_0 == 1 then
			return true
		elseif var_91_0 == 2 then
			local var_91_1 = arg_91_1:getSelectedCards()

			return var_91_1[1]:isNotSameKeywordWith(var_91_1[2], Data._skillInfo[4458]._refCards)
		end

		return false
	elseif arg_91_2._card:hasSkillFast(4483) then
		if var_91_0 == 2 then
			local var_91_2 = arg_91_1:getSelectedCards()

			return var_91_2[1]._status ~= var_91_2[2]._status
		end

		return false
	elseif arg_91_2._card:hasSkillFast(5267) then
		if var_91_0 == 1 then
			return true
		elseif var_91_0 == 2 then
			local var_91_3 = arg_91_1:getSelectedCards()

			if var_91_3[1]:isSync() and var_91_3[2]:isAdjust() then
				return true
			elseif var_91_3[2]:isSync() and var_91_3[1]:isAdjust() then
				return true
			end
		end

		return false
	elseif arg_91_2._card:isSkillAtIndex(4797, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card:isSkillAtIndex(5283, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card:isSkillAtIndex(5285, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_4 == 2 then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkills({
		5324
	}) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5517) and arg_91_3 ~= nil then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_2._card:isSkillAtIndex(6468, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.board and arg_91_2._card:hasSkills({
		6497,
		6605
	}) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkills({
		5284,
		6833
	}) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5393, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5447, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5517) and arg_91_4 == 2 then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5570, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5595) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5624) and arg_91_3 ~= nil then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5641, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5642) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5650, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5651, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5652) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(5653, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(5656) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(6860, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(6984, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7555, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_4 = arg_91_1:getSelectedCards()

		return #var_91_4 == 1 or #var_91_4 == 2 and not var_91_4[1]:isSameNameWith(var_91_4[2])
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7556, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_5 = arg_91_1:getSelectedCards()

		return #var_91_5 == 1 or #var_91_5 == 2 and not var_91_5[1]:isSameNameWith(var_91_5[2])
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(7644) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7681, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7682, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7735, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7736, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkillFast(7737) then
		return var_91_0 <= arg_91_4 and var_91_0 >= 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7767, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7776, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7822, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2113, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2142, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2310, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2807, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2879, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2929, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(2966, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9287, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9288, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9289, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9330, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9343, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9419, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9578, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9580, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9581, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9701, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9757, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9758, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9865, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(9886, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13009, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13094, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13103, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13106, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13138, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13149, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13178, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13182, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13301, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13311, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13370, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13371, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13444, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13596, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13599, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13614, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13619, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13635, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13661, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_6 = arg_91_1:getSelectedCards()

		return var_91_0 <= arg_91_4 and var_91_0 > 0 and var_91_6[1]:getStar() + (var_91_6[2] and var_91_6[2]:getStar() or 0) <= arg_91_2._card:getStar()
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13662, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_7 = arg_91_1:getSelectedCards()

		return var_91_0 <= arg_91_4 and var_91_0 > 0 and var_91_7[1]:getStar() + (var_91_7[2] and var_91_7[2]:getStar() or 0) <= arg_91_2._card:getStar()
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13701, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13702, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13733, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13815, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13838, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13868, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13870, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13886, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13917, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13925, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13926, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13933, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13962, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13994, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14001, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14010, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14015, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14018, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14097, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14098, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14125, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14143, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14154, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14158, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14174, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14201, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14202, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14224, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14251, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14260, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14261, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14302, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14308, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14412, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14418, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14452, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14489, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14528, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14591, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_1._choiceBase ~= nil and arg_91_1._choiceParam ~= nil and arg_91_2._card:isSkillAtIndex(2930, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_4 == 2 and arg_91_2._card:hasSkillFast(4445) then
		return var_91_0 <= arg_91_4 and var_91_0 > 0
	elseif arg_91_2._card:hasSkillFast(4722) then
		local var_91_8 = arg_91_1:getSelectedCards()

		return var_91_0 <= arg_91_4 and var_91_0 > 0 and #B.filterEffectCards(var_91_8) == 1
	elseif arg_91_4 == 2 and arg_91_2._card:hasSkillFast(6558) then
		if var_91_0 <= arg_91_4 and var_91_0 > 0 then
			local var_91_9 = arg_91_1:getSelectedCards()
			local var_91_10 = 0

			for iter_91_0 = 1, #var_91_9 do
				var_91_10 = var_91_10 + var_91_9[iter_91_0]:getStar()
			end

			return var_91_10 >= arg_91_2._card:getStar()
		end
	elseif arg_91_4 == 2 and arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkills({
		6853
	}) then
		local var_91_11 = arg_91_1:getSelectedCards()

		return #var_91_11 == 2 and not var_91_11[1]:isNature(var_91_11[2]._info._nature)
	elseif arg_91_4 == 2 and arg_91_2._card._status == BattleData.CardStatus.grave and arg_91_2._card:hasSkills({
		6871
	}) then
		local var_91_12 = arg_91_1:getSelectedCards()

		return #var_91_12 == 2 and not var_91_12[1]:isNature(var_91_12[2]._info._nature)
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13465, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_13 = arg_91_1:getSelectedCards()

		if #var_91_13 == 2 and var_91_13[1]:isSameNameWith(var_91_13[2]) then
			return false
		end

		return var_91_0 <= arg_91_4 and var_91_0 > 0
	end

	if arg_91_2._card._status == BattleData.CardStatus.hand and B.isSkillCeremony(arg_91_2._card._skills[1]._id) or arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(7576, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if selectCount == 0 then
			return false
		end

		local var_91_14 = arg_91_1:getSelectedCards()

		if arg_91_2._card:hasSkillFast(4741) and #B.filterInInfoIdGroupCards(var_91_14, Data._skillInfo[4741]._refCards) == 0 then
			return false
		end

		local var_91_15 = B.filterInStatusCards(var_91_14, BattleData.CardStatus.board)
		local var_91_16 = B.filterInStatusCards(var_91_14, BattleData.CardStatus.hand)
		local var_91_17 = B.filterInStatusCards(var_91_14, BattleData.CardStatus.grave)
		local var_91_18 = B.filterInStatusCards(var_91_14, BattleData.CardStatus.pile)

		if arg_91_2._card:hasSkillFast(4648) and (#var_91_14 ~= 2 or var_91_14[1]._status == var_91_14[2]._status or var_91_14[1]:isNature(var_91_14[2]._info._nature)) then
			return false
		end

		return arg_91_2._card._owner:isValidCeremonyComponents(arg_91_1._choiceParam, B.mergeTable({
			var_91_15,
			var_91_16,
			var_91_17,
			var_91_18
		}))
	elseif arg_91_2._card:isSkillAtIndex(3851, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card:hasSkills({
		2437,
		2560,
		2781,
		3940,
		6349,
		9453,
		9462
	}) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, arg_91_2._card)
	elseif arg_91_2._card:isSkillAtIndex(2611, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_19 = arg_91_1:getSelectedCards()

		if #var_91_19 ~= 2 or var_91_19[1] ~= arg_91_2._card and var_91_19[2] ~= arg_91_2._card then
			return false
		end

		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, arg_91_2._card)
	elseif arg_91_2._card._status == BattleData.CardStatus.rare and arg_91_2._card:isSkillAtIndex(6753, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidXYZComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card._status == BattleData.CardStatus.rare and arg_91_2._card:isSkillAtIndex(9298, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidLinkComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card._status == BattleData.CardStatus.leave and arg_91_2._card:isSkillAtIndex(9507, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card._status == BattleData.CardStatus.board and arg_91_2._card:isSkillAtIndex(9685, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card._status == BattleData.CardStatus.leave and arg_91_2._card:isSkillAtIndex(13007, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card._status == BattleData.CardStatus.grave and arg_91_2._card:isSkillAtIndex(7824, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidSyncComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), true, false, nil)
	elseif arg_91_2._card:isSkillAtIndex(9768, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_20 = arg_91_1:getSelectedCards()
		local var_91_21 = 0

		for iter_91_1 = 1, #var_91_20 do
			var_91_21 = var_91_21 + var_91_20[iter_91_1]:getStar()
		end

		return var_91_21 >= Data._skillInfo[9768]._val[1]
	elseif arg_91_2._card:isSkillAtIndex(9763, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_3 ~= nil then
		local var_91_22 = arg_91_1:getSelectedCards()
		local var_91_23 = 0

		for iter_91_2 = 1, #var_91_22 do
			var_91_23 = var_91_23 + var_91_22[iter_91_2]:getStar()
		end

		return var_91_23 >= arg_91_3._card:getStar()
	elseif arg_91_2._card:isSkillAtIndex(13147, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_24 = arg_91_1:getSelectedCards()
		local var_91_25 = 0

		for iter_91_3 = 1, #var_91_24 do
			var_91_25 = var_91_25 + var_91_24[iter_91_3]:getStar()
		end

		if var_91_25 < arg_91_2._card:getStar() then
			return false
		end

		if arg_91_2._card._owner:getEmptyBoardPos() == nil and #B.filterInStatusCards(var_91_24, BattleData.CardStatus.board) == 0 then
			return false
		end

		return true
	end

	if var_91_0 ~= arg_91_4 then
		return false
	end

	if arg_91_2._card:hasSkillFast(3493) and arg_91_2._card._status == BattleData.CardStatus.grave then
		local var_91_26 = arg_91_1:getSelectedCards()
		local var_91_27 = Data._skillInfo[3493]._refCards

		return var_91_26[1]:isNature(var_91_27[1]) and var_91_26[2]:isNature(var_91_27[2]) or var_91_26[1]:isNature(var_91_27[2]) and var_91_26[2]:isNature(var_91_27[1])
	elseif arg_91_2._card:hasSkills({
		2243
	}) then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), arg_91_2._card, false)
	elseif arg_91_2._card:hasSkillFast(2318) and arg_91_2._card._status == BattleData.CardStatus.board then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), nil, false)
	elseif arg_91_2._card:hasSkillFast(2982) and arg_91_2._card._status == BattleData.CardStatus.hand then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), arg_91_2._card, false)
	elseif arg_91_2._card:hasSkillFast(2985) and arg_91_2._card._status == BattleData.CardStatus.grave then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), arg_91_2._card, false)
	elseif arg_91_2._card:isSkillAtIndex(4978, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_28 = arg_91_1:getSelectedCards()

		if var_91_28[1]._owner ~= arg_91_2._card._owner and var_91_28[2]._owner ~= arg_91_2._card._owner then
			return false
		end

		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, var_91_28, nil, false)
	elseif arg_91_2._card:isSkillAtIndex(4980, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), arg_91_2._card._binds[1], false)
	elseif arg_91_2._card:isSkillAtIndex(13736, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), arg_91_2._card, false)
	elseif arg_91_2._card:hasSkills({
		4048,
		4171,
		4186,
		4207,
		4290,
		4454,
		4497,
		4521,
		4735,
		4736,
		4740,
		4748,
		4836,
		7144,
		7373,
		7693
	}) or arg_91_2._card._status == BattleData.CardStatus.rare and arg_91_2._card:hasSkills({
		3874,
		3885,
		2375
	}) or arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_2._card:hasSkills({
		4305,
		4511,
		4514,
		4526,
		4530,
		4861,
		4957,
		4979,
		5244,
		5280,
		5298,
		7544,
		7579,
		7622,
		7631,
		7731,
		7753
	}) and not arg_91_2._card:isSkillAtIndex(7733, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(3705, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(3850, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(2324, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5430, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5431, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5452, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5470, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5485, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5544, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(5549, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(7673, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(7674, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(7732, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(7785, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(7831, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(9796, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(9868, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13119, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13259, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13264, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13292, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13348, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13718, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13850, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13920, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(13989, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(14390, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(14487, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(14519, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(14541, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(14555, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_29 = (arg_91_2._card:isSkillAtIndex(3705, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(3850, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) or arg_91_2._card:isSkillAtIndex(2324, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3))) and arg_91_2._card or nil

		return arg_91_2._card._owner:isValidMergeComponents(arg_91_1._choiceParam, arg_91_1:getSelectedCards(), var_91_29, false)
	elseif arg_91_2._card:hasSkillFast(4112) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_30 = arg_91_1:getSelectedCards()

		return var_91_30[1]._owner ~= var_91_30[2]._owner
	elseif arg_91_2._card:hasSkillFast(4124) then
		local var_91_31 = arg_91_1:getSelectedCards()
		local var_91_32 = 0

		for iter_91_4 = 1, #var_91_31 do
			if var_91_31[iter_91_4]:isInfoId(Data._skillInfo[4124]._refCards[1]) then
				var_91_32 = var_91_32 + 1
			end
		end

		return var_91_32 == 2
	elseif arg_91_2._card:hasSkillFast(4666) then
		return #B.filterSameOwnerCards(arg_91_1:getSelectedCards(), arg_91_2._card) == 1
	elseif arg_91_2._card:hasSkillFast(4872) and arg_91_1._choiceParam ~= nil then
		local var_91_33 = arg_91_1:getSelectedCards()

		return var_91_33[1]:isAdjust() ~= var_91_33[2]:isAdjust() and var_91_33[1]:getStar() + var_91_33[2]:getStar() == arg_91_0._player:getCardById(arg_91_1._choiceParam):getStar()
	elseif arg_91_2._card:hasSkillFast(4912) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_34 = arg_91_1:getSelectedCards()

		return var_91_34[1]:getStar() ~= var_91_34[2]:getStar()
	elseif arg_91_2._card:hasSkillFast(7615) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_35 = arg_91_1:getSelectedCards()

		return var_91_35[1]._owner ~= var_91_35[2]._owner
	elseif arg_91_2._card:hasSkillFast(7628) and arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_4 == 2 then
		local var_91_36 = arg_91_1:getSelectedCards()

		return not var_91_36[1]:isSameNameWith(var_91_36[2])
	elseif arg_91_2._card:hasSkillFast(7646) and arg_91_2._card._status == BattleData.CardStatus.hand and arg_91_4 == 2 then
		local var_91_37 = arg_91_1:getSelectedCards()

		return var_91_37[1]:isAdjust() ~= var_91_37[2]:isAdjust()
	elseif arg_91_2._card:hasSkills({
		5227,
		5353
	}) then
		local var_91_38 = arg_91_1:getSelectedCards()

		return var_91_38[1]:getStar() == var_91_38[2]:getStar()
	elseif arg_91_2._card:hasSkillFast(5288) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_39 = arg_91_1:getSelectedCards()

		return var_91_39[1]._status ~= var_91_39[2]._status and not var_91_39[1]:isSameNameWith(var_91_39[2])
	elseif arg_91_2._card:hasSkillFast(5545) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_40 = arg_91_1:getSelectedCards()
		local var_91_41 = Data._skillInfo[5545]

		return var_91_40[1]._type == Data.CardType.monster and var_91_40[1]:isKeyword(var_91_41._refCards[2]) and var_91_40[2]:isKeyword(var_91_41._refCards[1]) and not var_91_40[2]:isSameNameWith(arg_91_2._card) or var_91_40[2]._type == Data.CardType.monster and var_91_40[2]:isKeyword(var_91_41._refCards[2]) and var_91_40[1]:isKeyword(var_91_41._refCards[1]) and not var_91_40[1]:isSameNameWith(arg_91_2._card)
	elseif arg_91_2._card:hasSkills({
		6691,
		6692
	}) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_42 = arg_91_1:getSelectedCards()

		return #B.filterInKeywordCards(var_91_42, Data._skillInfo[6691]._refCards[1]) > 0
	elseif arg_91_2._card:isSkillAtIndex(2116, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_43 = arg_91_1:getSelectedCards()

		return #B.filterInStatusCards(var_91_43, BattleData.CardStatus.field) == 1
	elseif arg_91_2._card:isSkillAtIndex(2141, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_44 = arg_91_1:getSelectedCards()

		return var_91_44[1]:isInfoId(Data._skillInfo[2141]._refCards[1]) and var_91_44[1]._owner == arg_91_2._card._owner or var_91_44[2]:isInfoId(Data._skillInfo[2141]._refCards[1]) and var_91_44[2]._owner == arg_91_2._card._owner
	elseif arg_91_2._card:isSkillAtIndex(2215, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_45 = arg_91_1:getSelectedCards()

		return var_91_45[1]._info._nature == var_91_45[2]._info._nature and var_91_45[1]._info._category == var_91_45[2]._info._category and var_91_45[1]:isAdjust() and not var_91_45[2]:isAdjust() or var_91_45[2]:isAdjust() and not var_91_45[1]:isAdjust()
	elseif arg_91_2._card:isSkillAtIndex(2244, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_46 = arg_91_1:getSelectedCards()

		return var_91_46[1]._infoId ~= var_91_46[2]._infoId
	elseif arg_91_2._card:isSkillAtIndex(2711, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_47 = arg_91_1:getSelectedCards()

		return var_91_47[1]._owner ~= var_91_47[2]._owner
	elseif arg_91_2._card:isSkillAtIndex(2745, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_48 = arg_91_1:getSelectedCards()

		return #B.filterUniqueInfoIdCards(var_91_48) == #var_91_48
	elseif arg_91_2._card:isSkillAtIndex(9071, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_49 = arg_91_1:getSelectedCards()

		return #B.filterUniqueInfoIdCards(var_91_49) == #var_91_49
	elseif arg_91_2._card:isSkillAtIndex(9187, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_50 = arg_91_1:getSelectedCards()

		return var_91_50[1]._owner ~= var_91_50[2]._owner
	elseif arg_91_2._card:isSkillAtIndex(9193, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if arg_91_2._card._owner:getEmptyBoardPos() == nil then
			local var_91_51 = arg_91_1:getSelectedCards()

			return var_91_51[1]._status == BattleData.CardStatus.board or var_91_51[2]._status == BattleData.CardStatus.board
		else
			return true
		end
	elseif arg_91_2._card:isSkillAtIndex(9219, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_52 = arg_91_1:getSelectedCards()

		return var_91_52[1]:isMonsterRare() ~= var_91_52[2]:isMonsterRare()
	elseif arg_91_2._card:isSkillAtIndex(9409, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_53 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_53[1]._status == BattleData.CardStatus.board or var_91_53[2]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9454, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_54 = arg_91_1:getSelectedCards()

		return var_91_54[1]:isMonsterRare() ~= var_91_54[2]:isMonsterRare()
	elseif arg_91_2._card:isSkillAtIndex(9480, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_1._choiceParam == nil then
		local var_91_55 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_55[1]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9481, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_1._choiceParam == nil then
		local var_91_56 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_56[1]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9501, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_57 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_57[1]._status == BattleData.CardStatus.board or var_91_57[2]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9513, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return #B.filterUniqueInfoIdCards(arg_91_1:getSelectedCards()) == 3
	elseif arg_91_2._card:isSkillAtIndex(9515, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		return #B.filterUniqueInfoIdCards(arg_91_1:getSelectedCards()) == 3
	elseif arg_91_2._card:isSkillAtIndex(9520, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_58 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_58[1]._status == BattleData.CardStatus.board or var_91_58[2]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9699, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_59 = arg_91_1:getSelectedCards()

		return var_91_59[1]:isSameNameWith(var_91_59[2])
	elseif arg_91_2._card:isSkillAtIndex(9716, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_60 = arg_91_1:getSelectedCards()

		return var_91_60[1]._owner ~= var_91_60[2]._owner
	elseif arg_91_2._card:isSkillAtIndex(9851, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_1._choiceParam == nil then
		local var_91_61 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_61[1]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9852, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_62 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_62[1]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9870, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_63 = arg_91_1:getSelectedCards()

		return var_91_63[1]._infoId ~= var_91_63[2]._infoId and (var_91_63[1]:isInfoId(Data._skillInfo[9870]._refCards[1]) or var_91_63[2]:isInfoId(Data._skillInfo[9870]._refCards[1]))
	elseif arg_91_2._card:isSkillAtIndex(9896, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) and arg_91_1._choiceParam == nil then
		local var_91_64 = arg_91_1:getSelectedCards()

		return arg_91_0._player:getEmptyBoardPos() ~= nil or var_91_64[1]._status == BattleData.CardStatus.board or var_91_64[2]._status == BattleData.CardStatus.board
	elseif arg_91_2._card:isSkillAtIndex(9944, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		if not arg_91_1._alreadySatisfied then
			local var_91_65 = arg_91_1:getSelectedCards()

			return var_91_65[1]:isNature(Data._skillInfo[9944]._refCards[1]) or var_91_65[1]:isNature(Data._skillInfo[9944]._refCards[2])
		end
	elseif arg_91_2._card:isSkillAtIndex(9945, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_66 = arg_91_1:getSelectedCards()

		return not var_91_66[1]:isSameNatureWith(var_91_66[2])
	elseif arg_91_2._card:isSkillAtIndex(9948, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_67 = arg_91_1:getSelectedCards()

		return not var_91_67[1]:isSameNatureWith(var_91_67[2])
	elseif arg_91_2._card:isSkillAtIndex(13283, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_68 = arg_91_1:getSelectedCards()

		return var_91_68[1]:isSameNameWith(var_91_68[2])
	elseif arg_91_2._card:isSkillAtIndex(13293, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_69 = arg_91_1:getSelectedCards()

		return var_91_69[1]._status ~= var_91_69[2]._status
	elseif arg_91_2._card:isSkillAtIndex(13338, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_70 = arg_91_1:getSelectedCards()

		return var_91_70[1]._info._category ~= var_91_70[2]._info._category
	elseif arg_91_2._card:isSkillAtIndex(13474, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_71 = arg_91_1:getSelectedCards()

		return var_91_71[1]._status == BattleData.CardStatus.grave and var_91_71[2]._status ~= BattleData.CardStatus.grave or var_91_71[1]._status ~= BattleData.CardStatus.grave and var_91_71[2]._status == BattleData.CardStatus.grave
	elseif arg_91_2._card:isSkillAtIndex(13503, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_72 = arg_91_1:getSelectedCards()

		return not var_91_72[1]:isNature(var_91_72[2]._info._nature)
	elseif arg_91_2._card:isSkillAtIndex(13545, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_73 = arg_91_1:getSelectedCards()

		return var_91_73[1]._status ~= var_91_73[2]._status
	elseif arg_91_2._card:isSkillAtIndex(13678, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_74 = arg_91_1:getSelectedCards()

		return var_91_74[1]:isKeyword(Data._skillInfo[13678]._refCards[1]) or var_91_74[2]._type == Data.CardType.rare or var_91_74[2]:isKeyword(Data._skillInfo[13678]._refCards[1]) or var_91_74[1]._type == Data.CardType.rare
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(13817, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_75 = arg_91_1:getSelectedCards()

		return var_91_75[1]._info._category ~= var_91_75[2]._info._category
	elseif arg_91_1._choiceBase ~= nil and arg_91_2._card:isSkillAtIndex(14021, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_76 = arg_91_1:getSelectedCards()

		if (not var_91_76[1]:isAdjust() or not var_91_76[1]:isSync() or not var_91_76[2]:isKeyword(Data._skillInfo[14021]._refCards[1])) and (not var_91_76[2]:isAdjust() or not var_91_76[2]:isSync() or not var_91_76[1]:isKeyword(Data._skillInfo[14021]._refCards[1])) then
			return false
		end

		if arg_91_2._card._owner:getEmptyBoardPos() == nil and var_91_76[1]._status ~= BattleData.CardStatus.board and var_91_76[2]._status ~= BattleData.CardStatus.board then
			return false
		end

		return true
	elseif arg_91_2._card:hasSkillFast(5608) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_77 = arg_91_1:getSelectedCards()

		return not var_91_77[1]:isInfoId(var_91_77[2]._infoId) and not var_91_77[1]:isInfoId(var_91_77[3]._infoId) and not var_91_77[2]:isInfoId(var_91_77[3]._infoId)
	elseif arg_91_2._card:hasSkillFast(5634) and arg_91_2._card._status == BattleData.CardStatus.hand then
		local var_91_78 = arg_91_1:getSelectedCards()

		return not var_91_78[1]:isSameNameWith(var_91_78[2])
	elseif arg_91_2._card:isSkillAtIndex(7667, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_79 = arg_91_1:getSelectedCards()

		return var_91_79[1]:isSameNameWith(var_91_79[2])
	elseif arg_91_2._card:isSkillAtIndex(7708, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_80 = arg_91_1:getSelectedCards()

		return var_91_80[1]._type ~= var_91_80[2]._type and (var_91_80[1]:isMonsterRare() or var_91_80[2]:isMonsterRare())
	elseif arg_91_2._card:isSkillAtIndex(14134, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_81 = arg_91_1:getSelectedCards()

		return var_91_81[1]._type ~= var_91_81[2]._type
	elseif arg_91_2._card:isSkillAtIndex(14400, math.floor(arg_91_1._choiceBase / BattleData.ChoiceId.stage_3)) then
		local var_91_82 = arg_91_1:getSelectedCards()

		return var_91_82[1]:getStar() + var_91_82[2]:getStar() == arg_91_2._card:getStar()
	else
		return true
	end
end
