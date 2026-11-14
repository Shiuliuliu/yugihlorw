function var_0_0.showChoiceGrave(arg_85_0, arg_85_1, arg_85_2, arg_85_3, arg_85_4, arg_85_5, arg_85_6)
	local var_85_0
	local var_85_1
	local var_85_2

	if arg_85_1._card:hasSkills({
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
	}) or arg_85_1._card._status == BattleData.CardStatus.rare and arg_85_1._card:hasSkills({
		3874,
		3885,
		2375
	}) or arg_85_1._card._status == BattleData.CardStatus.board and arg_85_1._card:hasSkills({
		2243,
		2318
	}) or arg_85_1._card._status == BattleData.CardStatus.grave and arg_85_1._card:hasSkills({
		2985
	}) or arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkills({
		2982,
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
	}) and (arg_85_5 == nil or not arg_85_1._card:isSkillAtIndex(7733, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3705, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3850, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2324, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4978, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4980, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5430, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5431, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5452, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5470, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5485, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5544, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5549, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7673, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7674, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7732, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7785, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7831, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9796, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9868, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13119, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13259, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13264, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13292, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13348, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13718, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13736, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13850, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13920, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13989, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14390, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14487, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14519, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14541, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14555, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.merge
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_MERGE_COMPONENT), arg_85_4)
	elseif arg_85_1._card._status == BattleData.CardStatus.rare and arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3851, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_1._card:getStar())
	elseif arg_85_1._card:hasSkills({
		2437,
		2560,
		2781,
		3940,
		6349,
		9453,
		9462
	}) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2611, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9507, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9685, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13007, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7824, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.sync
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_SYNC_COMPONENT), arg_85_6:getStar())
	elseif arg_85_1._card._status == BattleData.CardStatus.rare and arg_85_1._card:isSkillAtIndex(6753, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.xyz

		local var_85_3 = arg_85_1._card._info._joinComponent[1]
		local var_85_4 = #arg_85_1._card._info._joinComponent

		if var_85_3 ~= 0 then
			var_85_1 = string.format(Str(STR.CHOICE_TITLE_XYZ_COMPONENT), var_85_4, var_85_3)
		else
			var_85_1 = string.format(Str(STR.CHOICE_TITLE_XYZ_COMPONENT_IGNORE_STAR), var_85_4)
		end
	elseif arg_85_1._card._status == BattleData.CardStatus.rare and arg_85_1._card:isSkillAtIndex(9298, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.link
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_LINK_COMPONENT), arg_85_1._card:getLink(), Str(arg_85_1._card._info._descSid))
	elseif arg_85_1._card._status == BattleData.CardStatus.hand and B.isSkillCeremony(arg_85_1._card._skills[1]._id) then
		var_85_0 = BattleListDialog.Mode.ceremony
		var_85_1 = Str(arg_85_1._card._skills[1]._id ~= 4382 and STR.CHOICE_TITLE_CEREMONY_COMPONENT or STR.CHOICE_TITLE_CHOICE_0)
	elseif arg_85_1._card:hasSkills({
		3034,
		3035,
		3127,
		3247,
		3473,
		3474,
		3484
	}) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3034_1 or STR.CHOICE_TITLE_3034_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3320, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3320_1 or STR.CHOICE_TITLE_3320_2)
	elseif arg_85_1._card:hasSkills({
		3538
	}) and arg_85_5 ~= nil and arg_85_5 % BattleData.ChoiceId.stage_size_1 == 2 then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3538_1 or STR.CHOICE_TITLE_3538_2)
	elseif arg_85_1._card:hasSkills({
		3540
	}) and arg_85_1._card._status == BattleData.CardStatus.grave then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3538_1 or STR.CHOICE_TITLE_3538_2)
	elseif arg_85_1._card:hasSkills({
		3555
	}) and arg_85_1._card._status == BattleData.CardStatus.board then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3555_1 or STR.CHOICE_TITLE_3555_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3714, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3714_1 or STR.CHOICE_TITLE_3714_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3737, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3737_1 or STR.CHOICE_TITLE_3737_2)
	elseif arg_85_1._card:hasSkills({
		3835
	}) and arg_85_1._card._status == BattleData.CardStatus.board then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3835_1 or STR.CHOICE_TITLE_3835_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3950, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3950_1 or STR.CHOICE_TITLE_3950_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3957, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3957_1 or STR.CHOICE_TITLE_3957_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(3974, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_3974_1 or STR.CHOICE_TITLE_3974_2)
	elseif arg_85_1._card:hasSkills({
		4411
	}) and arg_85_1._card._status == BattleData.CardStatus.field then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4411_1 or STR.CHOICE_TITLE_4411_2)
	elseif arg_85_1._card:hasSkills({
		4431
	}) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4431_1 or STR.CHOICE_TITLE_4431_2)
	elseif arg_85_1._card:hasSkills({
		4095,
		4318
	}) then
		var_85_0 = BattleListDialog.Mode.exchange
		var_85_1 = Str(STR.CHOICE_TITLE_EXCHANGE)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4465, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4465_1 or STR.CHOICE_TITLE_4465_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4798, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4465_1 or STR.CHOICE_TITLE_4465_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4486, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4486_1 or STR.CHOICE_TITLE_4486_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4529, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4529_1 or STR.CHOICE_TITLE_4529_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4572, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4572_1 or STR.CHOICE_TITLE_4572_2)
	elseif arg_85_1._card:hasSkillFast(4589) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4589_1 or STR.CHOICE_TITLE_4589_2)
	elseif arg_85_1._card:hasSkillFast(4594) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4594_1 or STR.CHOICE_TITLE_4594_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4596, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4596_1 or STR.CHOICE_TITLE_4596_2)
	elseif arg_85_1._card:hasSkillFast(4628) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4628_1 or STR.CHOICE_TITLE_4628_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4631, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4631_1 or STR.CHOICE_TITLE_4631_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4633, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4633_1 or STR.CHOICE_TITLE_4633_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4678, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4678_1 or STR.CHOICE_TITLE_4678_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4728, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice

		local var_85_5 = Data._skillInfo[4728]
		local var_85_6 = B.filterFirstCards(arg_85_0._player._pileCards, 3)
		local var_85_7 = arg_85_0._player:filterCanChangeToHandCards(B.mergeTable({
			B.filterEqualInfoIdCards(var_85_6, var_85_5._refCards[2]),
			B.filterInKeywordCards(B.filterInTypeGroupCards(var_85_6, {
				Data.CardType.magic,
				Data.CardType.trap
			}), var_85_5._refCards[1])
		}))

		var_85_1 = Str(arg_85_6 == nil and (#var_85_7 > 0 and STR.CHOICE_TITLE_4728_1_1 or STR.CHOICE_TITLE_4728_1_2) or STR.CHOICE_TITLE_4728_2)
	elseif arg_85_1._card:hasSkillFast(4753) then
		var_85_0 = BattleListDialog.Mode.choice

		local var_85_8 = Data._skillInfo[4753]

		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4753_1 or arg_85_0._player:getCardById(arg_85_6)._info._category == var_85_8._refCards[1] and STR.CHOICE_TITLE_4753_2_1 or STR.CHOICE_TITLE_4753_2_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4804, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4804_1 or STR.CHOICE_TITLE_4804_2)
	elseif arg_85_1._card:hasSkillFast(4816) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4816_1 or STR.CHOICE_TITLE_4816_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4821, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_4821)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4827, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4827_1 or STR.CHOICE_TITLE_4827_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4840, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4840_1 or STR.CHOICE_TITLE_4840_2)
	elseif arg_85_1._card:hasSkillFast(4872) then
		var_85_0 = BattleListDialog.Mode.choice

		if arg_85_6 == nil then
			var_85_1 = Str(STR.CHOICE_TITLE_4872_1)
		else
			var_85_1 = string.format(Str(STR.CHOICE_TITLE_4872_2), arg_85_0._player:getCardById(arg_85_6):getStar())
		end
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4941, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4941_1 or STR.CHOICE_TITLE_4941_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4942, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4942_1 or STR.CHOICE_TITLE_4942_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4944, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4944_1 or STR.CHOICE_TITLE_4944_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4983, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4983_1 or STR.CHOICE_TITLE_4983_2)
	elseif arg_85_1._card:hasSkillFast(4984) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_2 == nil and STR.CHOICE_TITLE_4984_1 or STR.CHOICE_TITLE_4984_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4991, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4991_1 or STR.CHOICE_TITLE_4991_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4993, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4993_1 or STR.CHOICE_TITLE_4993_2)
	elseif arg_85_1._card:hasSkills({
		5118
	}) and arg_85_5 ~= nil and arg_85_5 % BattleData.ChoiceId.stage_size_1 == 1 then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5118_1 or STR.CHOICE_TITLE_5118_2)
	elseif arg_85_1._card:hasSkillFast(5232) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5232_1 or STR.CHOICE_TITLE_5232_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5285, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5285_1 or STR.CHOICE_TITLE_5285_2)
	elseif arg_85_1._card:hasSkillFast(5332) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5332_1 or STR.CHOICE_TITLE_5332_2)
	elseif arg_85_1._card:hasSkillFast(5343) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5343_1 or STR.CHOICE_TITLE_5343_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5440, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5440_1 or STR.CHOICE_TITLE_5440_2)
	elseif arg_85_1._card:hasSkillFast(5445) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5445_1 or STR.CHOICE_TITLE_5445_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5450, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and (arg_85_2 == nil and STR.CHOICE_TITLE_5450_1 or STR.CHOICE_TITLE_5450_2) or STR.CHOICE_TITLE_5450_3)
	elseif arg_85_1._card:hasSkillFast(5461) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5461_1 or STR.CHOICE_TITLE_5461_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5463, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5463_1 or STR.CHOICE_TITLE_5463_2)
	elseif arg_85_1._card:hasSkillFast(5472) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5472_1 or STR.CHOICE_TITLE_5472_2)
	elseif arg_85_1._card:hasSkillFast(5476) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5476_1 or STR.CHOICE_TITLE_5476_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5502, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5502_1 or STR.CHOICE_TITLE_5502_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5505, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_4821)
	elseif arg_85_1._card:hasSkillFast(5508) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5508_1 or STR.CHOICE_TITLE_5508_2)
	elseif arg_85_1._card:hasSkillFast(5517) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5517_1 or STR.CHOICE_TITLE_5517_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5539, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5539_1 or STR.CHOICE_TITLE_5539_2)
	elseif arg_85_1._card:hasSkillFast(5543) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5543_1 or STR.CHOICE_TITLE_5543_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5561, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5561_1 or STR.CHOICE_TITLE_5561_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5566, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5566_1 or STR.CHOICE_TITLE_5566_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5571, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5571_1 or STR.CHOICE_TITLE_5571_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5572, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5572_1 or STR.CHOICE_TITLE_5572_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5597, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5597_1 or STR.CHOICE_TITLE_5597_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5603, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5603_1 or STR.CHOICE_TITLE_5603_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5605, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5605_1 or STR.CHOICE_TITLE_5605_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5614, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5614_1 or STR.CHOICE_TITLE_5614_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5617, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5617_1 or STR.CHOICE_TITLE_5617_2)
	elseif arg_85_1._card:hasSkillFast(5622) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5622_1 or STR.CHOICE_TITLE_5622_2)
	elseif arg_85_1._card:hasSkillFast(5624) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = arg_85_2 == nil and Str(STR.CHOICE_TITLE_5624_1) or string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5646, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5646_1 or STR.CHOICE_TITLE_5646_2)
	elseif arg_85_1._card:hasSkills({
		6265
	}) and arg_85_5 ~= nil and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6265_1 or STR.CHOICE_TITLE_6265_2)
	elseif arg_85_1._card:hasSkills({
		6286
	}) and arg_85_1._card._status == BattleData.CardStatus.board then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6286_1 or STR.CHOICE_TITLE_6286_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6365, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6365_1 or STR.CHOICE_TITLE_6365_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6396, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6396_1 or STR.CHOICE_TITLE_6396_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6507, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6507_1 or STR.CHOICE_TITLE_6507_2)
	elseif arg_85_1._card:hasSkills({
		6616
	}) and arg_85_1._card._status == BattleData.CardStatus.grave then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6616_1 or STR.CHOICE_TITLE_6616_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6618, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6618_1 or STR.CHOICE_TITLE_6618_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6619, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6619_1 or STR.CHOICE_TITLE_6619_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6679, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6679_1 or STR.CHOICE_TITLE_6679_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6732, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6732_1 or STR.CHOICE_TITLE_6732_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6733, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6733_1 or STR.CHOICE_TITLE_6733_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6735, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6735_1 or STR.CHOICE_TITLE_6735_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6746, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6746_1 or STR.CHOICE_TITLE_6746_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6772, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6772_1 or STR.CHOICE_TITLE_6772_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6795, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6795_1 or STR.CHOICE_TITLE_6795_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6841, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6841_1 or STR.CHOICE_TITLE_6841_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6848, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6848_1 or STR.CHOICE_TITLE_6848_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6921, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6921_1 or STR.CHOICE_TITLE_6921_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6964, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6964_1 or STR.CHOICE_TITLE_6964_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6978, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6978_1 or STR.CHOICE_TITLE_6978_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6982, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_6982_1 or STR.CHOICE_TITLE_6982_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2111, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2111_1 or STR.CHOICE_TITLE_2111_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2112, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2112_1 or STR.CHOICE_TITLE_2112_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2117, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2117_1 or STR.CHOICE_TITLE_2117_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2135, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2135_1 or STR.CHOICE_TITLE_2135_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2155, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2155_1 or STR.CHOICE_TITLE_2155_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2196, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2196_1 or STR.CHOICE_TITLE_2196_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2203, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2203_1 or STR.CHOICE_TITLE_2203_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2209, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2209_1 or STR.CHOICE_TITLE_2209_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2212, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2212_1 or STR.CHOICE_TITLE_2212_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2279, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2279_1 or STR.CHOICE_TITLE_2279_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2320, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2320_1 or STR.CHOICE_TITLE_2320_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2341, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2341_1 or STR.CHOICE_TITLE_2341_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2359, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2359_1 or STR.CHOICE_TITLE_2359_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2389, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2389_1 or STR.CHOICE_TITLE_2389_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2392, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2392_1 or STR.CHOICE_TITLE_2392_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2400, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2400_1 or STR.CHOICE_TITLE_2400_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2409, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2409_1 or STR.CHOICE_TITLE_2409_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2429, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2429_1 or STR.CHOICE_TITLE_2429_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2430, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2430_1 or STR.CHOICE_TITLE_2430_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2434, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2434_1 or STR.CHOICE_TITLE_2434_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2441, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2441_1 or STR.CHOICE_TITLE_2441_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2449, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2449_1 or STR.CHOICE_TITLE_2449_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2450, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2450_1 or STR.CHOICE_TITLE_2450_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2486, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2486_1 or STR.CHOICE_TITLE_2486_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2487, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2487_1 or STR.CHOICE_TITLE_2487_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2534, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2534_1 or STR.CHOICE_TITLE_2534_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2562, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2562_1 or STR.CHOICE_TITLE_2562_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2578, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2578_1 or STR.CHOICE_TITLE_2578_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2585, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2585_1 or STR.CHOICE_TITLE_2585_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2586, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2586_1 or STR.CHOICE_TITLE_2586_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2587, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2585_1 or STR.CHOICE_TITLE_2585_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2588, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2588_1 or STR.CHOICE_TITLE_2588_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2598, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2598_1 or STR.CHOICE_TITLE_2598_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2599, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2599_1 or STR.CHOICE_TITLE_2599_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2602, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2598_1 or STR.CHOICE_TITLE_2598_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2615, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2615_1 or STR.CHOICE_TITLE_2615_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2739, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2739_1 or STR.CHOICE_TITLE_2739_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2750, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2750_1 or STR.CHOICE_TITLE_2750_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2772, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2772_1 or STR.CHOICE_TITLE_2772_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2774, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2774_1 or STR.CHOICE_TITLE_2774_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2776, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2776_1 or STR.CHOICE_TITLE_2776_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2785, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2785_1 or STR.CHOICE_TITLE_2785_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2787, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2787_1 or STR.CHOICE_TITLE_2787_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2789, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2789_1 or STR.CHOICE_TITLE_2789_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2806, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2806_1 or STR.CHOICE_TITLE_2806_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2811, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2811_1 or STR.CHOICE_TITLE_2811_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2813, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2813_1 or STR.CHOICE_TITLE_2813_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2838, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2838_1 or STR.CHOICE_TITLE_2838_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2867, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2867_1 or STR.CHOICE_TITLE_2867_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2886, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2886_1 or STR.CHOICE_TITLE_2886_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2915, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2915_1 or STR.CHOICE_TITLE_2915_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2928, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2928_1 or STR.CHOICE_TITLE_2928_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2930, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2930_1 or STR.CHOICE_TITLE_2930_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2942, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2942_1 or STR.CHOICE_TITLE_2942_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2951, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2951_1 or STR.CHOICE_TITLE_2951_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2959, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2959_1 or STR.CHOICE_TITLE_2959_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2963, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2963_1 or STR.CHOICE_TITLE_2963_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2969, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2969_1 or STR.CHOICE_TITLE_2969_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2986, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_2986_1 or STR.CHOICE_TITLE_2986_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9009, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9009_1 or STR.CHOICE_TITLE_9009_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9034, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9034_1 or STR.CHOICE_TITLE_9034_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9051, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9051_1 or STR.CHOICE_TITLE_9051_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9052, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9051_1 or STR.CHOICE_TITLE_9051_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9072, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9072_1 or STR.CHOICE_TITLE_9072_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9092, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9092_1 or STR.CHOICE_TITLE_9092_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9124, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9124_1 or STR.CHOICE_TITLE_9124_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9168, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9168_1 or STR.CHOICE_TITLE_9168_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9189, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9189_1 or STR.CHOICE_TITLE_9189_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9198, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9198_1 or STR.CHOICE_TITLE_9198_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9204, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9204_1 or STR.CHOICE_TITLE_9204_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9213, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9213_1 or STR.CHOICE_TITLE_9213_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9214, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9214_1 or STR.CHOICE_TITLE_9214_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9218, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9218_1 or STR.CHOICE_TITLE_9218_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9220, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9220_1 or STR.CHOICE_TITLE_9220_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9230, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9230_1 or STR.CHOICE_TITLE_9230_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9258, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9258_1 or STR.CHOICE_TITLE_9258_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9260, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9260_1 or STR.CHOICE_TITLE_9260_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9269, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9269_1 or STR.CHOICE_TITLE_9269_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9282, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9282_1 or STR.CHOICE_TITLE_9282_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9305, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9305_1 or STR.CHOICE_TITLE_9305_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9306, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9306_1 or STR.CHOICE_TITLE_9306_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9314, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9314_1 or STR.CHOICE_TITLE_9314_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9320, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9320_1 or STR.CHOICE_TITLE_9320_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9373, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9373_1 or STR.CHOICE_TITLE_9373_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9375, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9375_1 or STR.CHOICE_TITLE_9375_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9378, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9378_1 or STR.CHOICE_TITLE_9378_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9392, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9378_1 or STR.CHOICE_TITLE_9378_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9382, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9382_1 or STR.CHOICE_TITLE_9382_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9396, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9396_1 or STR.CHOICE_TITLE_9396_2)
	elseif arg_85_5 ~= nil and (arg_85_1._card:isSkillAtIndex(9480, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_1._card:isSkillAtIndex(9481, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3))) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9480_1 or STR.CHOICE_TITLE_9480_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9485, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9485_1 or STR.CHOICE_TITLE_9485_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9489, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.check
		var_85_1 = Str(STR.CHOICE_TITLE_9489)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9497, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9497_1 or STR.CHOICE_TITLE_9497_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9518, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9518_1 or STR.CHOICE_TITLE_9518_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9523, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9523_1 or STR.CHOICE_TITLE_9523_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9552, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.check_ignore_cancel
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_9552), #B.filterAdjustCards(arg_85_3, true))
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9556, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9556_1 or STR.CHOICE_TITLE_9556_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9563, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9563_1 or STR.CHOICE_TITLE_9563_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9593, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9593_1 or STR.CHOICE_TITLE_9593_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9600, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9600_1 or STR.CHOICE_TITLE_9600_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9614, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9614_1 or STR.CHOICE_TITLE_9614_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9615, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9615_1 or STR.CHOICE_TITLE_9615_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9638, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9638_1 or STR.CHOICE_TITLE_9638_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9712, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9712_1 or STR.CHOICE_TITLE_9712_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9721, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9721_1 or STR.CHOICE_TITLE_9721_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9733, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9733_1 or STR.CHOICE_TITLE_9733_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9739, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9739_1 or STR.CHOICE_TITLE_9739_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9763, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_2 == nil and STR.CHOICE_TITLE_9763_1 or STR.CHOICE_TITLE_9763_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9768, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = string.format(Str(STR.CHOICE_TITLE_9768), Data._skillInfo[9768]._val[1])
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9785, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9785_1 or STR.CHOICE_TITLE_9785_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9786, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9786_1 or STR.CHOICE_TITLE_9786_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9815, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9815_1 or STR.CHOICE_TITLE_9815_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9841, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9841_1 or STR.CHOICE_TITLE_9841_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9851, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9851_1 or STR.CHOICE_TITLE_9851_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9867, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9867_1 or STR.CHOICE_TITLE_9867_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9916, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9916_1 or STR.CHOICE_TITLE_9916_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9917, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9917_1 or STR.CHOICE_TITLE_9917_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9918, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9918_1 or STR.CHOICE_TITLE_9918_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9934, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9934_1 or STR.CHOICE_TITLE_9934_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9944, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		local var_85_9 = Data._skillInfo[9944]

		var_85_0 = BattleListDialog.Mode.choice

		if #B.filterInNatureCards(arg_85_3, var_85_9._refCards[1]) > 0 or #B.filterInNatureCards(arg_85_3, var_85_9._refCards[2]) > 0 then
			var_85_1 = Str(STR.CHOICE_TITLE_9944_1)
		else
			var_85_1 = Str(STR.CHOICE_TITLE_9944_2)
			var_85_2 = true
		end
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9956, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9956_1 or STR.CHOICE_TITLE_9956_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9965, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9965_1 or STR.CHOICE_TITLE_9965_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9960, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9960_1 or STR.CHOICE_TITLE_9960_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9983, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9983_1 or STR.CHOICE_TITLE_9983_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9984, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_9984_1 or STR.CHOICE_TITLE_9984_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13002, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13002_1 or STR.CHOICE_TITLE_13002_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13039, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5539_1 or STR.CHOICE_TITLE_5539_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13044, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_4821)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13045, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_4821)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13054, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13054_1 or STR.CHOICE_TITLE_13054_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13068, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13068_1 or STR.CHOICE_TITLE_13068_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13072, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13072_1 or STR.CHOICE_TITLE_13072_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13155, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13155_1 or STR.CHOICE_TITLE_13155_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13156, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13156_1 or STR.CHOICE_TITLE_13156_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13157, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13157_1 or STR.CHOICE_TITLE_13157_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13165, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13165_1 or STR.CHOICE_TITLE_13165_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13168, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13168_1 or STR.CHOICE_TITLE_13168_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13185, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13185_1 or STR.CHOICE_TITLE_13185_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13218, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13218_1 or STR.CHOICE_TITLE_13218_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13220, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13220_1 or STR.CHOICE_TITLE_13220_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13221, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13220_1 or STR.CHOICE_TITLE_13220_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13275, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) or arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13276, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.exchange
		var_85_1 = Str(STR.CHOICE_TITLE_EXCHANGE)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13296, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13296_1 or STR.CHOICE_TITLE_13296_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13318, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13318_1 or STR.CHOICE_TITLE_13318_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13321, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13321_1 or STR.CHOICE_TITLE_13321_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13330, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13330_1 or STR.CHOICE_TITLE_13330_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13332, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13332_1 or STR.CHOICE_TITLE_13332_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13365, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13365_1 or STR.CHOICE_TITLE_13365_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13367, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13367_1 or STR.CHOICE_TITLE_13367_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13373, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13373_1 or STR.CHOICE_TITLE_13373_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13380, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13380_1 or STR.CHOICE_TITLE_13380_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13398, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13398_1 or STR.CHOICE_TITLE_13398_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13401, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13401_1 or STR.CHOICE_TITLE_13401_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13405, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13405_1 or STR.CHOICE_TITLE_13405_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13408, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13408_1 or STR.CHOICE_TITLE_13408_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13411, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13411_1 or STR.CHOICE_TITLE_13411_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13430, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13430_1 or STR.CHOICE_TITLE_13430_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13432, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13432_1 or STR.CHOICE_TITLE_13432_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13452, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13452_1 or STR.CHOICE_TITLE_13452_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13468, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13468_1 or STR.CHOICE_TITLE_13468_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13538, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13538_1 or STR.CHOICE_TITLE_13538_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13552, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13552_1 or STR.CHOICE_TITLE_13552_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13553, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13553_1 or STR.CHOICE_TITLE_13553_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13572, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13572_1 or STR.CHOICE_TITLE_13572_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13602, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13602_1 or STR.CHOICE_TITLE_13602_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13607, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13607_1 or STR.CHOICE_TITLE_13607_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13576, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice

		local var_85_10 = Data._skillInfo[13576]
		local var_85_11 = B.filterFirstCards(arg_85_0._player._pileCards, 3)
		local var_85_12 = arg_85_0._player:filterCanChangeToHandCards(B.filterInKeywordCards(var_85_11, var_85_10._refCards[2]))

		var_85_1 = Str(arg_85_6 == nil and (#var_85_12 > 0 and STR.CHOICE_TITLE_4728_1_1 or STR.CHOICE_TITLE_4728_1_2) or STR.CHOICE_TITLE_4728_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13618, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13618_1 or STR.CHOICE_TITLE_13618_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13626, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13626_1 or STR.CHOICE_TITLE_13626_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13697, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_4821)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13703, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13703_1 or STR.CHOICE_TITLE_13703_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13710, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13710_1 or STR.CHOICE_TITLE_13710_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13719, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.exchange
		var_85_1 = Str(STR.CHOICE_TITLE_EXCHANGE)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13764, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13764_1 or STR.CHOICE_TITLE_13764_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13766, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13766_1 or STR.CHOICE_TITLE_13766_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13767, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13767_1 or STR.CHOICE_TITLE_13767_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13792, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13792_1 or STR.CHOICE_TITLE_13792_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13793, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13793_1 or STR.CHOICE_TITLE_13793_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13847, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13847_1 or STR.CHOICE_TITLE_13847_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13959, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13959_1 or STR.CHOICE_TITLE_13959_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13995, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_13995_1 or STR.CHOICE_TITLE_13995_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14020, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14020_1 or STR.CHOICE_TITLE_14020_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14047, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14047_1 or STR.CHOICE_TITLE_14047_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14163, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14163_1 or STR.CHOICE_TITLE_14163_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14176, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14176_1 or STR.CHOICE_TITLE_14176_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14185, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14185_1 or STR.CHOICE_TITLE_14185_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14337, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14337_1 or STR.CHOICE_TITLE_14337_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14411, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14411_1 or STR.CHOICE_TITLE_14411_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14441, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14441_1 or STR.CHOICE_TITLE_14441_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14474, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14474_1 or STR.CHOICE_TITLE_14474_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14534, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14534_1 or STR.CHOICE_TITLE_14534_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14561, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14561_1 or STR.CHOICE_TITLE_14561_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14570, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14570_1 or STR.CHOICE_TITLE_14570_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14579, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14579_1 or STR.CHOICE_TITLE_14579_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14588, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14588_1 or STR.CHOICE_TITLE_14588_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14598, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14598_1 or STR.CHOICE_TITLE_14598_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14604, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_14604_1 or STR.CHOICE_TITLE_14604_2)
	elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkills({
		4100
	}) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4100_1 or STR.CHOICE_TITLE_4100_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9694, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(STR.CHOICE_TITLE_9694)
	elseif arg_85_1._card._status == BattleData.CardStatus.grave and arg_85_1._card:hasSkills({
		4157
	}) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_4157_1 or STR.CHOICE_TITLE_4157_2)
	elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkills({
		5104
	}) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_5104_1 or STR.CHOICE_TITLE_5104_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7234, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7234_1 or STR.CHOICE_TITLE_7234_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7244, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7244_1 or STR.CHOICE_TITLE_7244_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7309, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7309_1 or STR.CHOICE_TITLE_7309_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7310, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7310_1 or STR.CHOICE_TITLE_7310_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7328, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7328_1 or STR.CHOICE_TITLE_7328_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7336, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7336_1 or STR.CHOICE_TITLE_7336_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7337, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7337_1 or STR.CHOICE_TITLE_7337_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7338, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7338_1 or STR.CHOICE_TITLE_7338_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7365, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7365_1 or STR.CHOICE_TITLE_7365_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7374, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7374_1 or STR.CHOICE_TITLE_7374_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7380, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7380_1 or STR.CHOICE_TITLE_7380_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7404, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7404_1 or STR.CHOICE_TITLE_7404_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7408, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7408_1 or STR.CHOICE_TITLE_7408_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7429, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7429_1 or STR.CHOICE_TITLE_7429_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7433, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7433_1 or STR.CHOICE_TITLE_7433_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7454, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7454_1 or STR.CHOICE_TITLE_7454_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7534, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7534_1 or STR.CHOICE_TITLE_7534_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7551, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7551_1 or STR.CHOICE_TITLE_7551_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7566, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7566_1 or STR.CHOICE_TITLE_7566_2)
	elseif arg_85_1._card:hasSkillFast(7574) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7574_1 or STR.CHOICE_TITLE_7574_2)
	elseif arg_85_1._card:hasSkillFast(7578) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7578_1 or STR.CHOICE_TITLE_7578_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7582, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7582_1 or STR.CHOICE_TITLE_7582_2)
	elseif arg_85_1._card:hasSkillFast(7628) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_2 == nil and STR.CHOICE_TITLE_7628_1 or STR.CHOICE_TITLE_7628_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7635, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7635_1 or STR.CHOICE_TITLE_7635_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7640, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7640_1 or STR.CHOICE_TITLE_7640_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7646, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7646_1 or STR.CHOICE_TITLE_7646_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7669, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7669_1 or STR.CHOICE_TITLE_7669_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7686, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7686_1 or STR.CHOICE_TITLE_7686_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7687, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7687_1 or STR.CHOICE_TITLE_7687_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7705, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7705_1 or STR.CHOICE_TITLE_7705_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7706, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7706_1 or STR.CHOICE_TITLE_7706_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7722, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7722_1 or STR.CHOICE_TITLE_7722_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7733, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7733_1 or STR.CHOICE_TITLE_7733_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7742, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7742_1 or STR.CHOICE_TITLE_7742_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7772, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7772_1 or STR.CHOICE_TITLE_7772_2)
	elseif arg_85_1._card:hasSkillFast(7774) and arg_85_1._card._status == BattleData.CardStatus.hand then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_2 == nil and STR.CHOICE_TITLE_7774_1 or STR.CHOICE_TITLE_7774_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7792, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7792_1 or STR.CHOICE_TITLE_7792_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7794, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7794_1 or STR.CHOICE_TITLE_7794_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7818, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7818_1 or STR.CHOICE_TITLE_7818_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7819, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7819_1 or STR.CHOICE_TITLE_7819_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7828, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_7828_1 or STR.CHOICE_TITLE_7828_2)
	elseif arg_85_1._card:hasSkills({
		8056
	}) and arg_85_1._card._status == BattleData.CardStatus.show then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8056_1 or STR.CHOICE_TITLE_8056_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8077, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8077_1 or STR.CHOICE_TITLE_8077_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8082, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8082_1 or STR.CHOICE_TITLE_8082_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8083, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8083_1 or STR.CHOICE_TITLE_8083_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8084, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8084_1 or STR.CHOICE_TITLE_8084_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8094, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8094_1 or STR.CHOICE_TITLE_8094_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8145, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8094_1 or STR.CHOICE_TITLE_8094_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8111, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8111_1 or STR.CHOICE_TITLE_8111_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8123, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8123_1 or STR.CHOICE_TITLE_8123_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8124, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8124_1 or STR.CHOICE_TITLE_8124_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8126, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8126_1 or STR.CHOICE_TITLE_8126_2)
	elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(8131, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
		var_85_0 = BattleListDialog.Mode.choice
		var_85_1 = Str(arg_85_6 == nil and STR.CHOICE_TITLE_8131_1 or STR.CHOICE_TITLE_8131_2)
	else
		local var_85_13, var_85_14 = arg_85_1._card:hasSkills({
			3073,
			3248,
			3331,
			3344,
			3365,
			3406,
			3428,
			3480,
			3573,
			3594,
			3707,
			3726,
			3735,
			3741,
			3768,
			3774,
			3775,
			3901,
			3912,
			3935,
			3937,
			3943,
			4117,
			4169,
			4170,
			4174,
			4205,
			4213,
			4238,
			4262,
			4263,
			4288,
			4302,
			4367,
			4413,
			4416,
			4430,
			4436,
			4443,
			4445,
			4463,
			4464,
			4490,
			4495,
			4507,
			4519,
			4532,
			4534,
			4559,
			4644,
			4645,
			4653,
			4655,
			4665,
			4674,
			4684,
			4723,
			4747,
			4750,
			4771,
			4783,
			4816,
			5049,
			5067,
			5107,
			5127,
			5156,
			5191,
			5193,
			5237,
			5363,
			5382,
			5403,
			5410,
			5443,
			6274,
			6338,
			6436,
			6437,
			6440,
			6451,
			6452,
			6454,
			6465,
			6476,
			6509,
			6510,
			6511,
			6549,
			6579,
			6598,
			6631,
			6673,
			6675,
			6707,
			6810,
			6894,
			6923,
			6934,
			6946,
			7192,
			7235,
			8018,
			8019,
			8046
		})

		if var_85_13 then
			var_85_0 = BattleListDialog.Mode.choice
			var_85_1 = Str(STR["CHOICE_TITLE_" .. var_85_14[1]._id .. (arg_85_6 == nil and "_1" or "_2")])
		else
			var_85_0 = BattleListDialog.Mode.choice

			if arg_85_4 == 0 then
				var_85_1 = Str(STR.CHOICE_TITLE_CHOICE_0)
			elseif arg_85_1._card:hasSkillFast(4722) then
				var_85_1 = string.format(Str(arg_85_4 == 2 and STR.CHOICE_TITLE_4722_1 or STR.CHOICE_TITLE_4722_2))
			elseif arg_85_1._card:hasSkills({
				3866,
				4350,
				4384,
				4390,
				4408,
				4424,
				4425,
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
				5267,
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
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4458, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(4797, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5283, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkills({
				5284,
				6833
			}) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5285, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) and arg_85_4 == 2 then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkills({
				5324
			}) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
				var_85_2 = true
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5393, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5447, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(5517) and arg_85_4 == 2 then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5570, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(5595) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5641, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(5642) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5650, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5651, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(5652) and arg_85_4 == 2 then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(5653, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(5656) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6468, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.board and arg_85_1._card:hasSkills({
				6497,
				6605
			}) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6860, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_4 == 2 and arg_85_1._card:hasSkills({
				6558
			}) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(6984, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7555, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7556, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(7644) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7681, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7682, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7735, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7736, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_1._card._status == BattleData.CardStatus.hand and arg_85_1._card:hasSkillFast(7737) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7744, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX_7744), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7767, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7776, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(7822, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2113, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2142, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2310, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2807, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2879, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2929, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(2966, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9287, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9288, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9289, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9330, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9343, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9287, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9288, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9289, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9419, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9578, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9580, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9581, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9701, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9757, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9758, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9865, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(9886, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13009, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13094, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13103, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13106, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13138, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13147, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13149, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13178, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13182, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13301, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13311, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13370, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13371, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13444, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13465, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13596, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13599, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13614, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13619, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13635, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13661, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13662, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13701, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13702, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13733, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13815, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13838, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13868, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13870, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13886, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13917, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13925, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13926, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13933, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13962, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(13994, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14001, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14010, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14015, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14018, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14097, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14098, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14125, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14143, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14154, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14158, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14174, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14201, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14202, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14224, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14251, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14260, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14261, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14302, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14308, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14412, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14418, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14452, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14489, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14528, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			elseif arg_85_5 ~= nil and arg_85_1._card:isSkillAtIndex(14591, math.floor(arg_85_5 / BattleData.ChoiceId.stage_3)) then
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE_MAX), arg_85_4)
			else
				var_85_1 = string.format(Str(STR.CHOICE_TITLE_CHOICE), arg_85_4)
			end
		end
	end

	if arg_85_1._card:hasSkills({
		6401
	}) and arg_85_1._card._status == BattleData.CardStatus.board then
		arg_85_3 = arg_85_0:uiRandomTable(arg_85_3, #arg_85_3)
	end

	local var_85_15 = BattleListDialog.create(arg_85_0._battleUi, arg_85_3, var_85_0, var_85_1, arg_85_0, arg_85_1._card)

	var_85_15._choiceBase = arg_85_5 or arg_85_1._card:hasSkills({
		3202,
		3361,
		3363,
		3368,
		3391,
		3456,
		3468,
		3470,
		3481,
		3670,
		3809,
		3822,
		3834,
		3914,
		3919,
		6321,
		6333,
		6484,
		6559,
		6598,
		6650,
		6691,
		6692,
		6754,
		6882,
		6883,
		6897,
		2406
	}) and 3 or arg_85_1._card:hasSkills({
		3492,
		3606,
		3892
	}) and 2 or 1
	var_85_15._choiceParam = arg_85_6
	var_85_15._alreadySatisfied = var_85_2

	var_85_15:setChoiceFunction(function(arg_86_0)
		return arg_85_0:checkChoiceGrave(arg_86_0, arg_85_1, arg_85_2, arg_85_4)
	end, function(arg_87_0)
		return arg_85_0:onChoiceGrave(arg_87_0, arg_85_1, arg_85_2)
	end, function(arg_88_0)
		return arg_85_0:cancelChoiceGrave(arg_88_0, arg_85_1, arg_85_2)
	end)
	var_85_15:show()

	arg_85_0._battleUi._choiceGraveDialog = var_85_15
end
