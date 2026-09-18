local var_0_0 = PlayerBattle

function var_0_0.resetWhenBattleStart(arg_1_0)
	arg_1_0._battleCondition:reset()
	arg_1_0._battleEvent:reset()

	arg_1_0._resultType = Data.BattleResult.draw
	arg_1_0._isFinished = false
	arg_1_0._isSkipped = false
	arg_1_0._isForwarding = false
	arg_1_0._isPaused = false
	arg_1_0._pausedStatus = nil
	arg_1_0._isRetreat = false
	arg_1_0._isCheating = false
	arg_1_0._isUseCardFinish = false
	arg_1_0._isRemainUnusable = false
	arg_1_0._isInitialDealed = false
	arg_1_0._isUsedCard = false
	arg_1_0._isDealDisabled = false
	arg_1_0._roundAttackIndex = 0
	arg_1_0._isSpecialSummonDisabledByMaxStar = nil
	arg_1_0._rareSummonCountInRound = 0
	arg_1_0._cardIdBase = arg_1_0._isAttacker and BattleData.UseCardId.attacker_base or BattleData.UseCardId.defender_base
	arg_1_0._cards = {}
	arg_1_0._leaveCards = {}
	arg_1_0._rareCards = {}
	arg_1_0._pileCards = {}
	arg_1_0._handCards = {}
	arg_1_0._boardCards = {}
	arg_1_0._graveCards = {}
	arg_1_0._coverCards = {}
	arg_1_0._showCards = {}
	arg_1_0._fieldCard = nil
	arg_1_0._result = {}
	arg_1_0._gemUnderSkills = {}
	arg_1_0._tempLeaveCards = {}
	arg_1_0._delaySkillCards = {}
	arg_1_0._frozenAttackRounds = {}
	arg_1_0._frozenGraveInitialSkillRounds = {}
	arg_1_0._isNormalSummonedInRound = {}
	arg_1_0._isSpecialSummonedInRound = {}
	arg_1_0._forbidMagicCards = {}
	arg_1_0._linkPos = {}
	arg_1_0._linkPos[Data.MAX_CARD_COUNT_ON_BOARD + 1] = true
	arg_1_0._castedSkillCounts = {}
	arg_1_0._summonedMonsterCounts = {}
	arg_1_0._isSummonDisabledByInfoId = nil
	arg_1_0._isSummonDisabledBySelfStar = {}
	arg_1_0._isSummonDisabledByOppoStar = {}
	arg_1_0._isSummonDisabledBy1143 = nil
	arg_1_0._isSpecialSummonDisabledByNature = {}
	arg_1_0._isSpecialSummonDisabledByExcludeKeyword = {}
	arg_1_0._isSpecialSummonDisabledBy4454 = nil
	arg_1_0._isSpecialSummonDisabledBy4812 = nil
	arg_1_0._isSpecialSummonDisabledBy4847 = nil
	arg_1_0._isSpecialSummonDisabledBy5288 = nil
	arg_1_0._isSpecialSummonDisabledBy5400 = nil
	arg_1_0._isSpecialSummonDisabledBy6706 = nil
	arg_1_0._isSpecialSummonDisabledBy7397 = nil
	arg_1_0._isSpecialSummonDisabledBy2123 = nil
	arg_1_0._isSpecialSummonDisabledBy2562 = nil
	arg_1_0._isSpecialSummonDisabledBy2872 = nil
	arg_1_0._isSpecialSummonDisabledBy9094 = nil
	arg_1_0._isSpecialSummonDisabledBy9223 = nil
	arg_1_0._isSpecialSummonDisabledBy9314 = nil
	arg_1_0._isSpecialSummonDisabledBy9687 = nil
	arg_1_0._specialSummonedMonsterIdCountsInRound = {}
	arg_1_0._specialSummonedMonsterInfoIdCountsInRound = {}
	arg_1_0._normalSummonedCards = {}
	arg_1_0._specialSummonedCards = {}
	arg_1_0._extraKeywordSummonCount = {}
	arg_1_0._extraNatureSummonCount = {}
	arg_1_0._extraCategorySummonCount = {}
	arg_1_0._toGraveCardsInRound = {}
	arg_1_0._attackedMonsters = {}
	arg_1_0._skillTotalCastedTimes = {}
	arg_1_0._disableSkillByOwnerInfoId = {}
	arg_1_0._fortressSkill = nil

	if arg_1_0._fortressSkillInfo and arg_1_0._fortressSkillInfo._id and arg_1_0._fortressSkillInfo._level and arg_1_0._fortressSkillInfo._id == 9999 then
		arg_1_0._fortressSkill = B.createSkill(arg_1_0._fortressSkillInfo._id, arg_1_0._fortressSkillInfo._level)
	end

	arg_1_0._replayIndex = 1
	arg_1_0._stepStatus = BattleData.Status.default
	arg_1_0._macroStatus = BattleData.Status.default
	arg_1_0._normalStatus = BattleData.Status.default
	arg_1_0._round = -arg_1_0._storyRound
	arg_1_0._endRound = 0
	arg_1_0._gem = 0
	arg_1_0._ghostCard = nil
	arg_1_0._fortress = BattleCard.new(arg_1_0._bossId, 1, arg_1_0)

	local fHp = (arg_1_0._fortressHp and arg_1_0._fortressHp > 0) and arg_1_0._fortressHp or 8000
	arg_1_0._fortress._updateInitHp = fHp
	arg_1_0._fortress._hp = fHp
	arg_1_0._fortress._maxHp = fHp

	arg_1_0._fortress:resetOnce()

	arg_1_0._fortress._owner = arg_1_0
	arg_1_0._fortress._id = arg_1_0._isAttacker and BattleData.UseCardId.attacker_base or BattleData.UseCardId.defender_base

	if arg_1_0._bossId ~= 0 and arg_1_0._fortress._info._isDeamon == 1 then
		arg_1_0._isDeamon = true
		arg_1_0._boardCards[2] = arg_1_0._fortress
		arg_1_0._fortress._status = BattleData.CardStatus.board
		arg_1_0._fortress._pos = 2
	end

	local var_1_0 = {}

	for iter_1_0 = 1, #arg_1_0._troopLevels do
		local var_1_1 = arg_1_0._troopLevels[iter_1_0]
		if type(var_1_1) == "table" and var_1_1.info_id then
			var_1_0[var_1_1.info_id] = var_1_1.level or 1
		elseif type(var_1_1) == "number" then
			var_1_0[var_1_1] = 1
		end
	end

	local var_1_2 = {}
	local var_1_3 = {}

	if arg_1_0._isClient and arg_1_0._troopSkins then
		for iter_1_1, iter_1_2 in ipairs(arg_1_0._troopSkins) do
			local var_1_4 = iter_1_2.info_id

			var_1_2[var_1_4] = iter_1_2.skin_id

			local var_1_5 = {}

			var_1_3[var_1_4] = var_1_5

			local var_1_6 = iter_1_2.effect_ids

			for iter_1_3, iter_1_4 in ipairs(var_1_6) do
				var_1_5[iter_1_3] = iter_1_4
			end
		end
	end

	arg_1_0._skins = var_1_2
	arg_1_0._effects = var_1_3

	local var_1_7 = {}
	local var_1_8 = 1

	for iter_1_5, iter_1_6 in ipairs(arg_1_0._troopCards) do
		local cId = (type(iter_1_6) == "table" and iter_1_6.info_id) or (type(iter_1_6) == "number" and iter_1_6) or 10001
		local cNum = (type(iter_1_6) == "table" and iter_1_6.num) or 1
		for iter_1_7 = 1, cNum do
			local var_1_9 = {
				_id = var_1_8,
				_infoId = cId,
				_level = var_1_0[cId] or 1
			}

			table.insert(var_1_7, var_1_9)

			var_1_8 = var_1_8 + 1

			if var_1_9._id < 0 then
				arg_1_0._hasHiredHero = true
			end
		end
	end

	for iter_1_8 = 1, #var_1_7 do
		local var_1_10 = var_1_7[iter_1_8]
		local var_1_11 = BattleCard.new(var_1_10._infoId, var_1_10._level, arg_1_0)

		var_1_11._isTroopCard = true

		arg_1_0:addCardToCards(var_1_11)
	end

	arg_1_0._assistant = {}

	if arg_1_0._bossId ~= 0 then
		local var_1_12 = Data._bossInfo[arg_1_0._bossId]

		for iter_1_9 = 1, #var_1_12._assistant do
			if var_1_12._assistant[iter_1_9] ~= 0 then
				local var_1_13 = BattleCard.new(var_1_12._assistant[iter_1_9], 1, arg_1_0)

				if arg_1_0._assistantHp and arg_1_0._assistantHp[iter_1_9] then
					var_1_13._updateInitHp = arg_1_0._assistantHp[iter_1_9]
				end

				table.insert(arg_1_0._assistant, var_1_13)
				arg_1_0:addCardToCards(var_1_13)
			end
		end
	end

	local var_1_14 = {}

	for iter_1_10 = 1, #arg_1_0._cards do
		local var_1_15 = arg_1_0._cards[iter_1_10]

		if var_1_15._type == Data.CardType.monster or var_1_15._type == Data.CardType.magic or var_1_15._type == Data.CardType.trap then
			var_1_15._status = BattleData.CardStatus.pile

			table.insert(var_1_14, iter_1_10)
		end
	end

	for iter_1_11 = 1, #var_1_14 do
		local var_1_16 = math.floor(arg_1_0:getRandom() * (#var_1_14 - iter_1_11 + 1)) + iter_1_11
		local var_1_17 = var_1_14[var_1_16]

		var_1_14[var_1_16] = var_1_14[iter_1_11]

		local var_1_18 = arg_1_0._cards[var_1_17]

		arg_1_0._pileCards[#arg_1_0._pileCards + 1] = var_1_18
		var_1_18._pos = #arg_1_0._pileCards
	end

	if arg_1_0._isNpc then
		local var_1_19 = arg_1_0:getAllMergeResultInfoIds()

		for iter_1_12 = 1, #var_1_19 do
			local var_1_20 = var_1_19[iter_1_12]

			if var_1_20 == 40025 then
				local var_1_21 = BattleCard.new(var_1_20, 1, arg_1_0)

				var_1_21._isTroopCard = true

				arg_1_0:addCardToCards(var_1_21)
			end
		end
	elseif arg_1_0._battleType ~= Data.BattleType.PVP_ladder and arg_1_0._battleType ~= Data.BattleType.PVP_ladder_npc and arg_1_0._battleType ~= Data.BattleType.PVP_survival and arg_1_0._battleType == Data.BattleType.PVP_survival_ex then
		-- block empty
	end

	for iter_1_13 = 1, #arg_1_0._cards do
		local var_1_22 = arg_1_0._cards[iter_1_13]

		if var_1_22._type == Data.CardType.rare then
			var_1_22._status = BattleData.CardStatus.rare

			table.insert(arg_1_0._rareCards, var_1_22)

			var_1_22._pos = #arg_1_0._rareCards
		end
	end

	for iter_1_14 = 1, #arg_1_0._cards do
		arg_1_0._cards[iter_1_14]:resetOnce()
	end

	arg_1_0._cardStatusToChange = {}
	arg_1_0._eventToChange = {}
	arg_1_0._saved = {}
	arg_1_0._magicPool = nil
	arg_1_0._winBy2234 = nil
	arg_1_0._winBy2237 = nil
	arg_1_0._winBy3190 = nil
	arg_1_0._winBy3798 = nil
	arg_1_0._disableTrapBy4127 = nil
	arg_1_0._magicTrapCastedCount = 0
	arg_1_0._lockSpecialSummonDefPosture = nil
	arg_1_0._isRareVisible = nil
	arg_1_0._damageScore = {}
	arg_1_0._damageScore[var_0_0.KEY_TOTAL] = 0
	arg_1_0._destroyCardScore = {}
	arg_1_0._destroyCardScore[var_0_0.KEY_TOTAL] = 0
	arg_1_0._destroyHeroScore = {}
	arg_1_0._destroyHeroScore[var_0_0.KEY_TOTAL] = 0
	arg_1_0._destroyMonsterCount = {}
	arg_1_0._destroyMonsterCount[0] = 0
	arg_1_0._totalNormalSummonedMonsterCount4 = 0
	arg_1_0._totalNormalSummonedMonsterCount5 = 0
	arg_1_0._totalSpecialSummonedMonsterCount = 0
	arg_1_0._totalComposeSummonCount = 0
	arg_1_0._totalRareSummonCount = 0
	arg_1_0._summonedMonsterStar = {}
	arg_1_0._summonedMonsterAtk = {}
	arg_1_0._summonedMonsterDef = {}
	arg_1_0._totalCastedMagicCount = 0
	arg_1_0._totalCastedTrapCount = 0
	arg_1_0._battlePass = {}

	local var_1_23 = 0

	for iter_1_15 = 1, #arg_1_0._pileCards do
		if arg_1_0._pileCards[iter_1_15]:getStar() ~= Data.XYZ_STAR and arg_1_0._pileCards[iter_1_15]:getStar() > 4 then
			var_1_23 = var_1_23 + 1
		end
	end

	local var_1_24 = {}
	local var_1_25 = 0
	local var_1_26 = B.filterInTypeCards(arg_1_0._pileCards, Data.CardType.monster)

	B.appendTable(var_1_26, arg_1_0._rareCards)

	for iter_1_16 = 1, #var_1_26 do
		local var_1_27 = var_1_26[iter_1_16]._info._nature

		var_1_24[var_1_27] = (var_1_24[var_1_27] or 0) + 1

		if var_1_24[var_1_27] >= 20 then
			var_1_25 = var_1_25 + 1
		end
	end

	arg_1_0._battlePass[1002] = #B.filterInTypeCards(arg_1_0._pileCards, Data.CardType.monster) == #arg_1_0._pileCards and 1 or 0
	arg_1_0._battlePass[1021] = #B.filterInTypeCards(arg_1_0._pileCards, Data.CardType.monster) <= 15 and 1 or 0
	arg_1_0._battlePass[1022] = var_1_25 > 0 and 1 or 0
	arg_1_0._battlePass[1027] = var_1_23 == 0 and 1 or 0
	B._lastAccount = nil
	arg_1_0._isBoardDirty = true
	arg_1_0._curBoardCards = {}
	B._mark9972 = nil
end

function var_0_0.resetWhenRoundBegin(arg_2_0)
	arg_2_0._round = arg_2_0._round + 1
	arg_2_0._eventDone = false
	arg_2_0._haloDone = false
	arg_2_0._trapDone = false

	lc.clearTable(arg_2_0._saved)
	lc.clearTable(arg_2_0._cardStatusToChange)
	lc.clearTable(arg_2_0._eventToChange)
	lc.clearTable(arg_2_0._normalSummonedCards)
	lc.clearTable(arg_2_0._specialSummonedCards)
	lc.clearTable(arg_2_0._opponent._normalSummonedCards)
	lc.clearTable(arg_2_0._opponent._specialSummonedCards)
	lc.clearTable(arg_2_0._extraKeywordSummonCount)
	lc.clearTable(arg_2_0._extraNatureSummonCount)
	lc.clearTable(arg_2_0._extraCategorySummonCount)
	lc.clearTable(arg_2_0._toGraveCardsInRound)
	lc.clearTable(arg_2_0._opponent._toGraveCardsInRound)
	lc.clearTable(arg_2_0._attackedMonsters)
	arg_2_0:removeGemUnderSkillsByRound()

	local var_2_0 = arg_2_0:getAllCards()

	for iter_2_0 = 1, #var_2_0 do
		local var_2_1 = var_2_0[iter_2_0]

		if var_2_1._owner == arg_2_0 then
			var_2_1:resetCardWhenRoundBegin()
		elseif var_2_1._owner == arg_2_0._opponent then
			var_2_1:resetCardWhenOppoRoundBegin()
		end
	end

	local var_2_2 = B.mergeTable({
		arg_2_0:getBattleCards("BCSD"),
		arg_2_0._opponent:getBattleCards("BCSD")
	})

	for iter_2_1 = 1, #var_2_2 do
		var_2_2[iter_2_1]._actionIndex = 1
		var_2_2[iter_2_1]._actionCount = 1
		var_2_2[iter_2_1]._roundBeginActionIndex = 1
		var_2_2[iter_2_1]._roundBeginActionCount = 1
		var_2_2[iter_2_1]._canAttack = true
	end

	local var_2_3 = arg_2_0:getBattleCardsBySkillModes("G", {
		Data.SkillMode.in_grave,
		Data.SkillMode.round_begin
	})
	local var_2_4 = arg_2_0._opponent:getBattleCardsBySkillModes("G", {
		Data.SkillMode.in_grave,
		Data.SkillMode.oppo_round_begin
	})
	local var_2_5 = arg_2_0:getBattleCardsBySkillModes("GL", {
		Data.SkillMode.in_gl,
		Data.SkillMode.round_begin
	})
	local var_2_6 = arg_2_0._opponent:getBattleCardsBySkillModes("GL", {
		Data.SkillMode.in_gl,
		Data.SkillMode.oppo_round_begin
	})
	local var_2_7 = arg_2_0:getBattleCardsBySkillModes("H", {
		Data.SkillMode.in_hand,
		Data.SkillMode.round_begin
	})
	local var_2_8 = arg_2_0._opponent:getBattleCardsBySkillModes("H", {
		Data.SkillMode.in_hand,
		Data.SkillMode.oppo_round_begin
	})
	local var_2_9 = arg_2_0:getBattleCardsByInfoIdGroup("R", {
		40651,
		40652
	})
	local var_2_10 = arg_2_0._opponent:getBattleCardsByInfoIdGroup("R", {
		40651,
		40652
	})
	local var_2_11 = B.mergeTable({
		var_2_3,
		var_2_4,
		var_2_5,
		var_2_6,
		var_2_7,
		var_2_8,
		var_2_9,
		var_2_10
	})

	if arg_2_0._round == 1 then
		local var_2_12 = arg_2_0:getBattleCardsBySkillFast("R", 13354)

		B.appendTable(var_2_11, var_2_12)
	end

	if arg_2_0._round == (arg_2_0._battleType == Data.BattleType.PVP_room and 2 or 1) then
		local var_2_13 = arg_2_0:getBattleCardsBySkillFast("R", 13634)

		B.appendTable(var_2_11, var_2_13)
	end

	for iter_2_2 = 1, #var_2_11 do
		var_2_11[iter_2_2]._actionIndex = 1
		var_2_11[iter_2_2]._actionCount = 1
		var_2_11[iter_2_2]._roundBeginActionIndex = 1
		var_2_11[iter_2_2]._roundBeginActionCount = 1
	end

	if arg_2_0._fortress._type == Data.CardType.boss then
		arg_2_0._fortress._actionIndex = 1
		arg_2_0._fortress._actionCount = 1
		arg_2_0._fortress._roundBeginActionIndex = 1
		arg_2_0._fortress._roundBeginActionCount = 1
	end

	arg_2_0._cardInAction = nil

	if arg_2_0._round <= 0 then
		arg_2_0._gem = 0
	else
		arg_2_0._gem = math.min(Data.MAX_GEM_COUNT, math.max(arg_2_0._round, arg_2_0._opponent._round))
	end

	arg_2_0._roundUseCardCount = 0

	if arg_2_0._isSkillDisabled or arg_2_0._isMonsterSkillDisabled or arg_2_0._opponent._isMonsterSkillDisabled or arg_2_0._mark6599 or arg_2_0._opponent._mark6599 or arg_2_0._mark9105 or arg_2_0._opponent._mark9105 or arg_2_0._mark9517 or arg_2_0._opponent._mark9517 or arg_2_0._mark2548 or arg_2_0._opponent._mark2548 or arg_2_0._opponent._mark9598 then
		B._lastAccount = nil
	end

	arg_2_0._isSummoned = false
	arg_2_0._isNormalSummoned = false
	arg_2_0._opponent._isNormalSummoned = false
	arg_2_0._isSpecialSummoned = false
	arg_2_0._opponent._isSpecialSummoned = false
	arg_2_0._extraNormalSummonCount = 0
	arg_2_0._extraSpiritSummonCount = 0
	arg_2_0._extraSacrificeSummonCount = 0
	arg_2_0._extraPlantSummonCount = 0
	arg_2_0._extraInvadeDeamonSummonCount = 0
	arg_2_0._extraInfatuatedSummonCount = 0
	arg_2_0._extraRedEyeSummonCount = 0
	arg_2_0._extraDualSummonCount = 0
	arg_2_0._extraWindNiaoShouSummonCount = 0
	arg_2_0._isSummonDisabled = false
	arg_2_0._isSummonDisabledEx = false
	arg_2_0._isNormalSummonDisabled = false
	arg_2_0._isSpecialSummonDisabled = false
	arg_2_0._opponent._isSpecialSummonDisabled = false
	arg_2_0._isSummonedFromRare = false
	arg_2_0._isSummonedNotFromSync = false
	arg_2_0._isSummonFromRareDisabled = false
	arg_2_0._opponent._isSummonFromRareDisabled = false
	arg_2_0._isSummonedByMerge = false
	arg_2_0._isSummonedBySync = false
	arg_2_0._isSummonedByXYZ = false
	arg_2_0._isSummonedByLink = false
	arg_2_0._isSummonedByCeremony = false
	arg_2_0._isSummonByMergeDisabled = false
	arg_2_0._isRareSummonExcludeMergeDisabled = false
	arg_2_0._isRareSummonExcludeSyncDisabled = false
	arg_2_0._isRareSummonExcludeXYZDisabled = false
	arg_2_0._isSummonExcludeSyncDisabled = false
	arg_2_0._isSkillDisabled = false
	arg_2_0._isMonsterSkillDisabled = false
	arg_2_0._opponent._isMonsterSkillDisabled = false
	arg_2_0._isMagicTrapDisabled = false
	arg_2_0._isMagicTrapDisabledBy3274 = nil
	arg_2_0._opponent._isMagicTrapDisabledBy3274 = nil
	arg_2_0._opponent._isMagicTrapDisabledBy5226 = nil
	arg_2_0._magicTrapCastedCount = 0
	arg_2_0._skillCasted = false
	arg_2_0._roundAttackIndex = 0
	arg_2_0._usedFieldMark = nil
	arg_2_0._isAnyMonsterActioned = false
	arg_2_0._isUseHandCardDisabled = false
	arg_2_0._isTrapTriggerDisabled = false
	arg_2_0._opponent._isTrapTriggerDisabled = false
	arg_2_0._isSpecialSummonDisabledByMaxStar = nil
	arg_2_0._isSpecialSummonExcludeCeremony = false
	arg_2_0._lockSpecialSummonDefPosture = nil
	arg_2_0._isCoverTrapProtected = nil
	arg_2_0._isHandVisible = false
	arg_2_0._rareSummonCountInRound = 0
	arg_2_0._opponent._rareSummonCountInRound = 0
	arg_2_0._castedSkillCounts = {}
	arg_2_0._opponent._castedSkillCounts[1146] = nil
	arg_2_0._opponent._castedSkillCounts[2058] = nil
	arg_2_0._opponent._castedSkillCounts[2213] = nil
	arg_2_0._opponent._castedSkillCounts[3610] = nil
	arg_2_0._opponent._castedSkillCounts[4250] = nil
	arg_2_0._opponent._castedSkillCounts[4462] = nil
	arg_2_0._opponent._castedSkillCounts[4488] = nil
	arg_2_0._opponent._castedSkillCounts[4489] = nil
	arg_2_0._opponent._castedSkillCounts[5132] = nil
	arg_2_0._opponent._castedSkillCounts[5408] = nil
	arg_2_0._opponent._castedSkillCounts[5409] = nil
	arg_2_0._opponent._castedSkillCounts[5434] = nil
	arg_2_0._opponent._castedSkillCounts[5562] = nil
	arg_2_0._opponent._castedSkillCounts[5575] = nil
	arg_2_0._opponent._castedSkillCounts[5593] = nil
	arg_2_0._opponent._castedSkillCounts[5594] = nil
	arg_2_0._opponent._castedSkillCounts[5604] = nil
	arg_2_0._opponent._castedSkillCounts[5606] = nil
	arg_2_0._opponent._castedSkillCounts[5627] = nil
	arg_2_0._opponent._castedSkillCounts[5636] = nil
	arg_2_0._opponent._castedSkillCounts[5649] = nil
	arg_2_0._opponent._castedSkillCounts[5661] = nil
	arg_2_0._opponent._castedSkillCounts[5663] = nil
	arg_2_0._opponent._castedSkillCounts[5664] = nil
	arg_2_0._opponent._castedSkillCounts[5666] = nil
	arg_2_0._opponent._castedSkillCounts[6185] = nil
	arg_2_0._opponent._castedSkillCounts[6317] = nil
	arg_2_0._opponent._castedSkillCounts[6358] = nil
	arg_2_0._opponent._castedSkillCounts[6769] = nil
	arg_2_0._opponent._castedSkillCounts[2128] = nil
	arg_2_0._opponent._castedSkillCounts[2150] = nil
	arg_2_0._opponent._castedSkillCounts[2161] = nil
	arg_2_0._opponent._castedSkillCounts[2162] = nil
	arg_2_0._opponent._castedSkillCounts[2239] = nil
	arg_2_0._opponent._castedSkillCounts[2252] = nil
	arg_2_0._opponent._castedSkillCounts[2253] = nil
	arg_2_0._opponent._castedSkillCounts[2272] = nil
	arg_2_0._opponent._castedSkillCounts[2273] = nil
	arg_2_0._opponent._castedSkillCounts[2274] = nil
	arg_2_0._opponent._castedSkillCounts[2275] = nil
	arg_2_0._opponent._castedSkillCounts[2288] = nil
	arg_2_0._opponent._castedSkillCounts[2289] = nil
	arg_2_0._opponent._castedSkillCounts[2381] = nil
	arg_2_0._opponent._castedSkillCounts[2404] = nil
	arg_2_0._opponent._castedSkillCounts[2405] = nil
	arg_2_0._opponent._castedSkillCounts[2565] = nil
	arg_2_0._opponent._castedSkillCounts[2569] = nil
	arg_2_0._opponent._castedSkillCounts[2679] = nil
	arg_2_0._opponent._castedSkillCounts[2753] = nil
	arg_2_0._opponent._castedSkillCounts[2792] = nil
	arg_2_0._opponent._castedSkillCounts[2884] = nil
	arg_2_0._opponent._castedSkillCounts[2935] = nil
	arg_2_0._opponent._castedSkillCounts[2936] = nil
	arg_2_0._opponent._castedSkillCounts[2937] = nil
	arg_2_0._opponent._castedSkillCounts[9038] = nil
	arg_2_0._opponent._castedSkillCounts[9039] = nil
	arg_2_0._opponent._castedSkillCounts[9040] = nil
	arg_2_0._opponent._castedSkillCounts[9109] = nil
	arg_2_0._opponent._castedSkillCounts[9158] = nil
	arg_2_0._opponent._castedSkillCounts[9159] = nil
	arg_2_0._opponent._castedSkillCounts[9172] = nil
	arg_2_0._opponent._castedSkillCounts[9205] = nil
	arg_2_0._opponent._castedSkillCounts[9229] = nil
	arg_2_0._opponent._castedSkillCounts[9243] = nil
	arg_2_0._opponent._castedSkillCounts[9263] = nil
	arg_2_0._opponent._castedSkillCounts[9264] = nil
	arg_2_0._opponent._castedSkillCounts[9293] = nil
	arg_2_0._opponent._castedSkillCounts[9350] = nil
	arg_2_0._opponent._castedSkillCounts[9353] = nil
	arg_2_0._opponent._castedSkillCounts[9384] = nil
	arg_2_0._opponent._castedSkillCounts[9385] = nil
	arg_2_0._opponent._castedSkillCounts[9387] = nil
	arg_2_0._opponent._castedSkillCounts[9432] = nil
	arg_2_0._opponent._castedSkillCounts[9443] = nil
	arg_2_0._opponent._castedSkillCounts[9445] = nil
	arg_2_0._opponent._castedSkillCounts[9456] = nil
	arg_2_0._opponent._castedSkillCounts[9457] = nil
	arg_2_0._opponent._castedSkillCounts[9477] = nil
	arg_2_0._opponent._castedSkillCounts[9484] = nil
	arg_2_0._opponent._castedSkillCounts[9548] = nil
	arg_2_0._opponent._castedSkillCounts[9553] = nil
	arg_2_0._opponent._castedSkillCounts[9595] = nil
	arg_2_0._opponent._castedSkillCounts[9618] = nil
	arg_2_0._opponent._castedSkillCounts[9621] = nil
	arg_2_0._opponent._castedSkillCounts[9638] = nil
	arg_2_0._opponent._castedSkillCounts[9639] = nil
	arg_2_0._opponent._castedSkillCounts[9640] = nil
	arg_2_0._opponent._castedSkillCounts[9641] = nil
	arg_2_0._opponent._castedSkillCounts[9782] = nil
	arg_2_0._opponent._castedSkillCounts[9946] = nil
	arg_2_0._opponent._castedSkillCounts[7161] = nil
	arg_2_0._opponent._castedSkillCounts[7219] = nil
	arg_2_0._opponent._castedSkillCounts[7262] = nil
	arg_2_0._opponent._castedSkillCounts[7273] = nil
	arg_2_0._opponent._castedSkillCounts[7280] = nil
	arg_2_0._opponent._castedSkillCounts[7327] = nil
	arg_2_0._opponent._castedSkillCounts[7375] = nil
	arg_2_0._opponent._castedSkillCounts[7377] = nil
	arg_2_0._opponent._castedSkillCounts[7378] = nil
	arg_2_0._opponent._castedSkillCounts[7431] = nil
	arg_2_0._opponent._castedSkillCounts[7489] = nil
	arg_2_0._opponent._castedSkillCounts[7497] = nil
	arg_2_0._opponent._castedSkillCounts[7533] = nil
	arg_2_0._opponent._castedSkillCounts[7541] = nil
	arg_2_0._opponent._castedSkillCounts[7580] = nil
	arg_2_0._opponent._castedSkillCounts[7595] = nil
	arg_2_0._opponent._castedSkillCounts[7603] = nil
	arg_2_0._opponent._castedSkillCounts[7610] = nil
	arg_2_0._opponent._castedSkillCounts[7611] = nil
	arg_2_0._opponent._castedSkillCounts[7679] = nil
	arg_2_0._opponent._castedSkillCounts[7691] = nil
	arg_2_0._opponent._castedSkillCounts[7743] = nil
	arg_2_0._opponent._castedSkillCounts[7750] = nil
	arg_2_0._opponent._castedSkillCounts[7803] = nil
	arg_2_0._opponent._castedSkillCounts[8098] = nil
	arg_2_0._opponent._castedSkillCounts[13012] = nil
	arg_2_0._opponent._castedSkillCounts[13020] = nil
	arg_2_0._opponent._castedSkillCounts[13021] = nil
	arg_2_0._opponent._castedSkillCounts[13024] = nil
	arg_2_0._opponent._castedSkillCounts[13025] = nil
	arg_2_0._opponent._castedSkillCounts[13038] = nil
	arg_2_0._opponent._castedSkillCounts[13042] = nil
	arg_2_0._opponent._castedSkillCounts[13049] = nil
	arg_2_0._opponent._castedSkillCounts[13075] = nil
	arg_2_0._opponent._castedSkillCounts[13130] = nil
	arg_2_0._opponent._castedSkillCounts[13133] = nil
	arg_2_0._opponent._castedSkillCounts[13137] = nil
	arg_2_0._opponent._castedSkillCounts[13146] = nil
	arg_2_0._opponent._castedSkillCounts[13161] = nil
	arg_2_0._opponent._castedSkillCounts[13163] = nil
	arg_2_0._opponent._castedSkillCounts[13177] = nil
	arg_2_0._opponent._castedSkillCounts[13181] = nil
	arg_2_0._opponent._castedSkillCounts[13222] = nil
	arg_2_0._opponent._castedSkillCounts[13225] = nil
	arg_2_0._opponent._castedSkillCounts[13234] = nil
	arg_2_0._opponent._castedSkillCounts[13238] = nil
	arg_2_0._opponent._castedSkillCounts[13247] = nil
	arg_2_0._opponent._castedSkillCounts[13250] = nil
	arg_2_0._opponent._castedSkillCounts[13256] = nil
	arg_2_0._opponent._castedSkillCounts[13257] = nil
	arg_2_0._opponent._castedSkillCounts[13270] = nil
	arg_2_0._opponent._castedSkillCounts[13317] = nil
	arg_2_0._opponent._castedSkillCounts[13324] = nil
	arg_2_0._opponent._castedSkillCounts[13326] = nil
	arg_2_0._opponent._castedSkillCounts[13333] = nil
	arg_2_0._opponent._castedSkillCounts[13334] = nil
	arg_2_0._opponent._castedSkillCounts[13340] = nil
	arg_2_0._opponent._castedSkillCounts[13345] = nil
	arg_2_0._opponent._castedSkillCounts[13355] = nil
	arg_2_0._opponent._castedSkillCounts[13356] = nil
	arg_2_0._opponent._castedSkillCounts[13366] = nil
	arg_2_0._opponent._castedSkillCounts[13375] = nil
	arg_2_0._opponent._castedSkillCounts[13391] = nil
	arg_2_0._opponent._castedSkillCounts[13392] = nil
	arg_2_0._opponent._castedSkillCounts[13400] = nil
	arg_2_0._opponent._castedSkillCounts[13407] = nil
	arg_2_0._opponent._castedSkillCounts[13413] = nil
	arg_2_0._opponent._castedSkillCounts[13415] = nil
	arg_2_0._opponent._castedSkillCounts[13423] = nil
	arg_2_0._opponent._castedSkillCounts[13435] = nil
	arg_2_0._opponent._castedSkillCounts[13450] = nil
	arg_2_0._opponent._castedSkillCounts[13493] = nil
	arg_2_0._opponent._castedSkillCounts[13499] = nil
	arg_2_0._opponent._castedSkillCounts[13500] = nil
	arg_2_0._opponent._castedSkillCounts[13512] = nil
	arg_2_0._opponent._castedSkillCounts[13517] = nil
	arg_2_0._opponent._castedSkillCounts[13524] = nil
	arg_2_0._opponent._castedSkillCounts[13525] = nil
	arg_2_0._opponent._castedSkillCounts[13532] = nil
	arg_2_0._opponent._castedSkillCounts[13536] = nil
	arg_2_0._opponent._castedSkillCounts[13559] = nil
	arg_2_0._opponent._castedSkillCounts[13568] = nil
	arg_2_0._opponent._castedSkillCounts[13574] = nil
	arg_2_0._opponent._castedSkillCounts[13604] = nil
	arg_2_0._opponent._castedSkillCounts[13624] = nil
	arg_2_0._opponent._castedSkillCounts[13627] = nil
	arg_2_0._opponent._castedSkillCounts[13628] = nil
	arg_2_0._opponent._castedSkillCounts[13631] = nil
	arg_2_0._opponent._castedSkillCounts[13632] = nil
	arg_2_0._opponent._castedSkillCounts[13654] = nil
	arg_2_0._opponent._castedSkillCounts[13655] = nil
	arg_2_0._opponent._castedSkillCounts[13738] = nil
	arg_2_0._opponent._castedSkillCounts[13741] = nil
	arg_2_0._opponent._castedSkillCounts[13745] = nil
	arg_2_0._opponent._castedSkillCounts[13773] = nil
	arg_2_0._opponent._castedSkillCounts[13776] = nil
	arg_2_0._opponent._castedSkillCounts[13780] = nil
	arg_2_0._opponent._castedSkillCounts[13784] = nil
	arg_2_0._opponent._castedSkillCounts[13801] = nil
	arg_2_0._opponent._castedSkillCounts[13808] = nil
	arg_2_0._opponent._castedSkillCounts[13811] = nil
	arg_2_0._opponent._castedSkillCounts[13829] = nil
	arg_2_0._opponent._castedSkillCounts[13835] = nil
	arg_2_0._opponent._castedSkillCounts[13842] = nil
	arg_2_0._opponent._castedSkillCounts[13864] = nil
	arg_2_0._opponent._castedSkillCounts[13887] = nil
	arg_2_0._opponent._castedSkillCounts[13890] = nil
	arg_2_0._opponent._castedSkillCounts[13893] = nil
	arg_2_0._opponent._castedSkillCounts[13901] = nil
	arg_2_0._opponent._castedSkillCounts[13905] = nil
	arg_2_0._opponent._castedSkillCounts[13908] = nil
	arg_2_0._opponent._castedSkillCounts[13919] = nil
	arg_2_0._opponent._castedSkillCounts[13942] = nil
	arg_2_0._opponent._castedSkillCounts[13945] = nil
	arg_2_0._opponent._castedSkillCounts[13953] = nil
	arg_2_0._opponent._castedSkillCounts[13955] = nil
	arg_2_0._opponent._castedSkillCounts[13964] = nil
	arg_2_0._opponent._castedSkillCounts[13967] = nil
	arg_2_0._opponent._castedSkillCounts[13976] = nil
	arg_2_0._opponent._castedSkillCounts[13981] = nil
	arg_2_0._opponent._castedSkillCounts[14000] = nil
	arg_2_0._opponent._castedSkillCounts[14035] = nil
	arg_2_0._opponent._castedSkillCounts[14038] = nil
	arg_2_0._opponent._castedSkillCounts[14039] = nil
	arg_2_0._opponent._castedSkillCounts[14050] = nil
	arg_2_0._opponent._castedSkillCounts[14054] = nil
	arg_2_0._opponent._castedSkillCounts[14055] = nil
	arg_2_0._opponent._castedSkillCounts[14087] = nil
	arg_2_0._opponent._castedSkillCounts[14101] = nil
	arg_2_0._opponent._castedSkillCounts[14111] = nil
	arg_2_0._opponent._castedSkillCounts[14119] = nil
	arg_2_0._opponent._castedSkillCounts[14128] = nil
	arg_2_0._opponent._castedSkillCounts[14135] = nil
	arg_2_0._opponent._castedSkillCounts[14151] = nil
	arg_2_0._opponent._castedSkillCounts[14165] = nil
	arg_2_0._opponent._castedSkillCounts[14166] = nil
	arg_2_0._opponent._castedSkillCounts[14194] = nil
	arg_2_0._opponent._castedSkillCounts[14195] = nil
	arg_2_0._opponent._castedSkillCounts[14211] = nil
	arg_2_0._opponent._castedSkillCounts[14236] = nil
	arg_2_0._opponent._castedSkillCounts[14243] = nil
	arg_2_0._opponent._castedSkillCounts[14249] = nil
	arg_2_0._opponent._castedSkillCounts[14250] = nil
	arg_2_0._opponent._castedSkillCounts[14255] = nil
	arg_2_0._opponent._castedSkillCounts[14256] = nil
	arg_2_0._opponent._castedSkillCounts[14259] = nil
	arg_2_0._opponent._castedSkillCounts[14279] = nil
	arg_2_0._opponent._castedSkillCounts[14280] = nil
	arg_2_0._opponent._castedSkillCounts[14405] = nil
	arg_2_0._opponent._castedSkillCounts[14413] = nil
	arg_2_0._opponent._castedSkillCounts[14415] = nil
	arg_2_0._opponent._castedSkillCounts[14422] = nil
	arg_2_0._opponent._castedSkillCounts[14423] = nil
	arg_2_0._opponent._castedSkillCounts[14431] = nil
	arg_2_0._opponent._castedSkillCounts[14453] = nil
	arg_2_0._opponent._castedSkillCounts[14481] = nil
	arg_2_0._opponent._castedSkillCounts[14494] = nil
	arg_2_0._opponent._castedSkillCounts[14497] = nil
	arg_2_0._opponent._castedSkillCounts[14550] = nil
	arg_2_0._opponent._castedSkillCounts[14552] = nil
	arg_2_0._opponent._castedSkillCounts[14558] = nil
	arg_2_0._opponent._castedSkillCounts[14563] = nil
	arg_2_0._opponent._castedSkillCounts[14566] = nil
	arg_2_0._opponent._castedSkillCounts[14577] = nil
	arg_2_0._opponent._castedSkillCounts[14582] = nil
	arg_2_0._opponent._castedSkillCounts[14587] = nil
	arg_2_0._opponent._castedSkillCounts[14594] = nil
	arg_2_0._opponent._castedSkillCounts[14600] = nil
	arg_2_0._opponent._castedSkillCounts[14601] = nil
	arg_2_0._opponent._castedSkillCounts[3] = nil
	arg_2_0._summonedMonsterCounts = {}
	arg_2_0._isSummonDisabledByInfoId = nil
	arg_2_0._isSummonDisabledBySelfStar = {}
	arg_2_0._opponent._isSummonDisabledByOppoStar = {}
	arg_2_0._isSpecialSummonDisabledByNature = {}
	arg_2_0._opponent._isSpecialSummonDisabledByNature = {}
	arg_2_0._isSpecialSummonDisabledByExcludeKeyword = {}
	arg_2_0._opponent._isSpecialSummonDisabledByExcludeKeyword = {}
	arg_2_0._isSummonDisabledBy4659 = nil
	arg_2_0._opponent._isSummonDisabledBy4659 = nil
	arg_2_0._isSpecialSummonDisabledBy4454 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy4454 = nil
	arg_2_0._isSummonDisabledBy4674 = nil
	arg_2_0._opponent._isSummonDisabledBy4674 = nil
	arg_2_0._isSpecialSummonDisabledBy4812 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy4812 = nil
	arg_2_0._isSummonDisabledBy4825 = nil
	arg_2_0._opponent._isSummonDisabledBy4825 = nil
	arg_2_0._isSummonDisabledBy4941 = nil
	arg_2_0._opponent._isSummonDisabledBy4941 = nil
	arg_2_0._isSummonDisabledBy7773 = nil
	arg_2_0._opponent._isSummonDisabledBy7773 = nil
	arg_2_0._isSummonDisabledBy9480 = nil
	arg_2_0._opponent._isSummonDisabledBy9480 = nil
	arg_2_0._isSummonDisabledBy9699 = nil
	arg_2_0._opponent._isSummonDisabledBy9699 = nil
	arg_2_0._isSpecialSummonDisabledBy4847 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy4847 = nil
	arg_2_0._isSpecialSummonDisabledBy4943 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy4943 = nil
	arg_2_0._isSummonDisabledBy2723 = nil
	arg_2_0._opponent._isSummonDisabledBy2723 = nil
	arg_2_0._isSpecialSummonDisabledBy3153 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy3153 = nil
	arg_2_0._isSpecialSummonDisabledBy5288 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy5288 = nil
	arg_2_0._isSpecialSummonDisabledBy5400 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy5400 = nil
	arg_2_0._isSpecialSummonDisabledBy5582 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy5582 = nil
	arg_2_0._isSpecialSummonDisabledBy5592 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy5592 = nil
	arg_2_0._isSpecialSummonDisabledBy5611 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy5611 = nil
	arg_2_0._isSpecialSummonDisabledBy5618 = nil
	arg_2_0._isSpecialSummonDisabledBy5634 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy5634 = nil
	arg_2_0._isSpecialSummonDisabledBy6706 = nil
	arg_2_0._isSpecialSummonDisabledBy2123 = nil
	arg_2_0._isSpecialSummonDisabledBy2521 = nil
	arg_2_0._isSpecialSummonDisabledBy2534 = nil
	arg_2_0._isSpecialSummonDisabledBy2562 = nil
	arg_2_0._isSpecialSummonDisabledBy2779 = nil
	arg_2_0._isSpecialSummonDisabledBy2872 = nil
	arg_2_0._isSpecialSummonDisabledBy2980 = nil
	arg_2_0._isSpecialSummonDisabledBy9094 = nil
	arg_2_0._isSpecialSummonDisabledBy9223 = nil
	arg_2_0._isSpecialSummonDisabledBy9314 = nil
	arg_2_0._isSpecialSummonDisabledBy9541 = nil
	arg_2_0._isSpecialSummonDisabledBy9561 = nil
	arg_2_0._isSpecialSummonDisabledBy9598 = nil
	arg_2_0._isSpecialSummonDisabledBy9634 = nil
	arg_2_0._isSpecialSummonDisabledBy9687 = nil
	arg_2_0._isSpecialSummonDisabledBy9758 = nil
	arg_2_0._isSpecialSummonDisabledBy9785 = nil
	arg_2_0._isSpecialSummonDisabledBy9824 = nil
	arg_2_0._isSpecialSummonDisabledBy9858 = nil
	arg_2_0._isSpecialSummonDisabledBy9861 = nil
	arg_2_0._isSpecialSummonDisabledBy9864 = nil
	arg_2_0._isSpecialSummonDisabledBy9954 = nil
	arg_2_0._isSpecialSummonDisabledBy4594 = nil
	arg_2_0._isSpecialSummonDisabledBy7397 = nil
	arg_2_0._isSpecialSummonDisabledBy7549 = nil
	arg_2_0._isSpecialSummonDisabledBy7608 = nil
	arg_2_0._isSpecialSummonDisabledBy7621 = nil
	arg_2_0._isSpecialSummonDisabledBy7681 = nil
	arg_2_0._isSpecialSummonDisabledBy7752 = nil
	arg_2_0._isSpecialSummonDisabledBy7812 = nil
	arg_2_0._isSpecialSummonDisabledBy7825 = nil
	arg_2_0._isSpecialSummonDisabledBy7830 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy7681 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy7752 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy7812 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy7825 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy7830 = nil
	arg_2_0._isSpecialSummonDisabledBy8116 = nil
	arg_2_0._isSpecialSummonDisabledBy13096 = nil
	arg_2_0._isSpecialSummonDisabledBy13098 = nil
	arg_2_0._isSpecialSummonDisabledBy13118 = nil
	arg_2_0._isSpecialSummonDisabledBy13153 = nil
	arg_2_0._isSpecialSummonDisabledBy13156 = nil
	arg_2_0._isSpecialSummonDisabledBy13164 = nil
	arg_2_0._isSpecialSummonDisabledBy13167 = nil
	arg_2_0._isSpecialSummonDisabledBy13170 = nil
	arg_2_0._isSpecialSummonDisabledBy13184 = nil
	arg_2_0._isSpecialSummonDisabledBy13190 = nil
	arg_2_0._isSpecialSummonDisabledBy13191 = nil
	arg_2_0._isSpecialSummonDisabledBy13307 = nil
	arg_2_0._isSpecialSummonDisabledBy13335 = nil
	arg_2_0._isSpecialSummonDisabledBy13345 = nil
	arg_2_0._isSpecialSummonDisabledBy13347 = nil
	arg_2_0._isSpecialSummonDisabledBy13350 = nil
	arg_2_0._isSpecialSummonDisabledBy13409 = nil
	arg_2_0._isSpecialSummonDisabledBy13420 = nil
	arg_2_0._isSpecialSummonDisabledBy13423 = nil
	arg_2_0._isSpecialSummonDisabledBy13480 = nil
	arg_2_0._isSpecialSummonDisabledBy13481 = nil
	arg_2_0._isSpecialSummonDisabledBy13482 = nil
	arg_2_0._isSpecialSummonDisabledBy13485 = nil
	arg_2_0._isSpecialSummonDisabledBy13496 = nil
	arg_2_0._isSpecialSummonDisabledBy13524 = nil
	arg_2_0._isSpecialSummonDisabledBy13530 = nil
	arg_2_0._isSpecialSummonDisabledBy13539 = nil
	arg_2_0._isSpecialSummonDisabledBy13561 = nil
	arg_2_0._isSpecialSummonDisabledBy13586 = nil
	arg_2_0._isSpecialSummonDisabledBy13588 = nil
	arg_2_0._isSpecialSummonDisabledBy13590 = nil
	arg_2_0._isSpecialSummonDisabledBy13618 = nil
	arg_2_0._isSpecialSummonDisabledBy13626 = nil
	arg_2_0._isSpecialSummonDisabledBy13661 = nil
	arg_2_0._isSpecialSummonDisabledBy13666 = nil
	arg_2_0._isSpecialSummonDisabledBy13727 = nil
	arg_2_0._isSpecialSummonDisabledBy13777 = nil
	arg_2_0._isSpecialSummonDisabledBy13844 = nil
	arg_2_0._isSpecialSummonDisabledBy13868 = nil
	arg_2_0._isSpecialSummonDisabledBy13949 = nil
	arg_2_0._isSpecialSummonDisabledBy13956 = nil
	arg_2_0._isSpecialSummonDisabledBy14016 = nil
	arg_2_0._isSpecialSummonDisabledBy14018 = nil
	arg_2_0._isSpecialSummonDisabledBy14038 = nil
	arg_2_0._isSpecialSummonDisabledBy14039 = nil
	arg_2_0._isSpecialSummonDisabledBy14044 = nil
	arg_2_0._isSpecialSummonDisabledBy14123 = nil
	arg_2_0._isSpecialSummonDisabledBy14140 = nil
	arg_2_0._isSpecialSummonDisabledBy14201 = nil
	arg_2_0._isSpecialSummonDisabledBy14202 = nil
	arg_2_0._isSpecialSummonDisabledBy14220 = nil
	arg_2_0._isSpecialSummonDisabledBy14288 = nil
	arg_2_0._isSpecialSummonDisabledBy14412 = nil
	arg_2_0._isSpecialSummonDisabledBy14458 = nil
	arg_2_0._isSpecialSummonDisabledBy14470 = nil
	arg_2_0._isSpecialSummonDisabledBy14489 = nil
	arg_2_0._isSpecialSummonDisabledBy14534 = nil
	arg_2_0._isSpecialSummonDisabledBy14543 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy6706 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy7608 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy7621 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy2123 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy2521 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy2534 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy2562 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy2779 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy2872 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy2980 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9094 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9223 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9541 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9561 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9598 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9634 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9687 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9758 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9785 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9824 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9858 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9861 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9864 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy9954 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy4594 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy7397 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy7549 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy8116 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13096 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13098 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13118 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13153 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13156 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13164 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13167 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13170 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13184 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13190 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13191 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13307 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13335 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13345 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13347 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13350 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13409 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13420 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13423 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13480 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13481 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13482 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13485 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13496 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13524 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13530 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13539 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13561 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13586 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13588 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13590 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13618 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13626 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13661 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13666 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13727 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13777 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13844 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13868 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13949 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy13956 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14016 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14018 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14038 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14039 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14044 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14123 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14140 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14201 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14202 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14220 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14288 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14412 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14458 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14470 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14489 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14534 = nil
	arg_2_0._opponent._isSpecialSummonDisabledBy14543 = nil
	arg_2_0._specialSummonedMonsterIdCountsInRound = {}
	arg_2_0._specialSummonedMonsterInfoIdCountsInRound = {}
	arg_2_0._opponent._specialSummonedMonsterIdCountsInRound = {}
	arg_2_0._opponent._specialSummonedMonsterInfoIdCountsInRound = {}
	arg_2_0._mark3650 = nil
	arg_2_0._mark3664 = nil
	arg_2_0._mark4274_3 = nil
	arg_2_0._mark4282_2 = nil
	arg_2_0._mark4319 = nil
	arg_2_0._opponent._mark4319 = nil
	arg_2_0._mark4321 = nil
	arg_2_0._mark4521 = nil
	arg_2_0._mark4522 = nil
	arg_2_0._mark4595 = nil
	arg_2_0._mark4615 = nil
	arg_2_0._mark4685 = nil
	arg_2_0._mark4912 = nil
	arg_2_0._mark4916 = nil
	arg_2_0._mark5036 = nil
	arg_2_0._mark5197 = nil
	arg_2_0._mark5317 = nil
	arg_2_0._mark5376 = nil
	arg_2_0._mark5531 = nil
	arg_2_0._opponent._mark5531 = nil
	arg_2_0._mark5608 = nil
	arg_2_0._opponent._mark5608 = nil
	arg_2_0._mark5635 = nil
	arg_2_0._opponent._mark5635 = nil
	arg_2_0._mark8119 = nil
	arg_2_0._mark6209 = nil
	arg_2_0._opponent._mark6209 = nil
	arg_2_0._mark13529 = nil
	arg_2_0._opponent._mark13529 = nil
	arg_2_0._mark6365 = nil
	arg_2_0._mark6423 = nil
	arg_2_0._mark6425 = nil
	arg_2_0._mark6457 = nil
	arg_2_0._mark6599 = nil
	arg_2_0._mark6695 = nil
	arg_2_0._mark6905 = nil
	arg_2_0._mark7415 = nil
	arg_2_0._mark7441 = nil
	arg_2_0._mark7465_3 = nil
	arg_2_0._mark7548 = nil
	arg_2_0._mark2185 = nil
	arg_2_0._mark2205 = nil
	arg_2_0._mark2280 = nil
	arg_2_0._mark2413 = {}
	arg_2_0._mark2450 = nil
	arg_2_0._mark2530 = nil
	arg_2_0._mark2548 = nil
	arg_2_0._mark2819 = nil
	arg_2_0._mark2959 = nil
	arg_2_0._mark2971 = nil
	arg_2_0._mark2989 = nil
	arg_2_0._mark9105 = nil
	arg_2_0._mark9172 = nil
	arg_2_0._mark9212 = nil
	arg_2_0._mark9290 = nil
	arg_2_0._mark9407 = nil
	arg_2_0._mark9517 = nil
	arg_2_0._mark9545 = nil
	arg_2_0._mark9600 = nil
	arg_2_0._mark9830 = nil
	arg_2_0._mark9844 = nil
	arg_2_0._mark9925 = nil
	arg_2_0._mark9950 = nil
	arg_2_0._mark13019 = nil
	arg_2_0._mark13339 = nil
	arg_2_0._mark13445 = nil
	arg_2_0._mark13790 = nil
	arg_2_0._mark13840 = nil
	arg_2_0._mark14055_1 = nil
	arg_2_0._mark14055_2 = nil
	arg_2_0._mark14068 = nil
	arg_2_0._mark14222 = nil
	arg_2_0._mark14250_1 = nil
	arg_2_0._mark14250_2 = nil
	arg_2_0._mark14255 = nil
	arg_2_0._mark14256 = nil
	arg_2_0._mark14305 = nil
	arg_2_0._mark14429 = nil
	arg_2_0._opponent._mark4595 = nil
	arg_2_0._opponent._mark8119 = nil
	arg_2_0._opponent._mark6599 = nil
	arg_2_0._opponent._mark6365 = nil
	arg_2_0._opponent._mark6423 = nil
	arg_2_0._opponent._mark6905 = nil
	arg_2_0._opponent._mark2185 = nil
	arg_2_0._opponent._mark2205 = nil
	arg_2_0._opponent._mark2280 = nil
	arg_2_0._opponent._mark2413 = {}
	arg_2_0._opponent._mark2450 = nil
	arg_2_0._opponent._mark2530 = nil
	arg_2_0._opponent._mark2548 = nil
	arg_2_0._opponent._mark2959 = nil
	arg_2_0._opponent._mark2971 = nil
	arg_2_0._opponent._mark2989 = nil
	arg_2_0._opponent._mark9105 = nil
	arg_2_0._opponent._mark9172 = nil
	arg_2_0._opponent._mark9290 = nil
	arg_2_0._opponent._mark9407 = nil
	arg_2_0._opponent._mark9517 = nil
	arg_2_0._opponent._mark9545 = nil
	arg_2_0._opponent._mark9600 = nil
	arg_2_0._opponent._mark9830 = nil
	arg_2_0._opponent._mark9950 = nil
	arg_2_0._mark7026 = nil
	arg_2_0._opponent._mark7026 = nil
	arg_2_0._mark7143 = nil
	arg_2_0._opponent._mark7143 = nil
	arg_2_0._mark4068 = nil
	arg_2_0._opponent._mark4068 = nil
	arg_2_0._mark8088 = nil
	arg_2_0._opponent._mark8088 = nil
	arg_2_0._opponent._mark5533 = nil
	arg_2_0._opponent._mark9598 = nil
	arg_2_0._opponent._mark13019 = nil
	arg_2_0._opponent._mark13445 = nil
	arg_2_0._opponent._mark13790 = nil
	arg_2_0._opponent._mark13840 = nil
	arg_2_0._opponent._mark13878 = nil
	arg_2_0._opponent._mark13878_2 = nil
	arg_2_0._opponent._mark13941 = nil
	arg_2_0._opponent._mark14055_1 = nil
	arg_2_0._opponent._mark14055_2 = nil
	arg_2_0._opponent._mark14068 = nil
	arg_2_0._opponent._mark14250_1 = nil
	arg_2_0._opponent._mark14250_2 = nil
	arg_2_0._opponent._mark14255 = nil
	arg_2_0._opponent._mark14256 = nil
	arg_2_0._opponent._mark14305 = nil
	arg_2_0._opponent._mark14306 = nil
	arg_2_0._opponent._mark14429 = nil
	arg_2_0._mark14000 = nil
	arg_2_0._opponent._mark14000 = nil
end

function var_0_0.resetWhenInitialDeal(arg_3_0)
	arg_3_0._graveCards = {}

	if arg_3_0._bossId == 0 then
		arg_3_0._fortress:reset()
	end
end

function var_0_0.resetActionCard(arg_4_0)
	local var_4_0 = arg_4_0._actionCard

	arg_4_0._opponent._actionCard = nil
	var_4_0._needAccount = false
	var_4_0._spellingSkill = nil
end

function var_0_0.resetAccount(arg_5_0)
	local var_5_0 = arg_5_0:getAllCards()

	for iter_5_0 = 1, #var_5_0 do
		local var_5_1 = var_5_0[iter_5_0]

		lc.clearTable(var_5_1._castedSkills)
		lc.clearTable(var_5_1._changed)
	end

	local var_5_2 = arg_5_0._actionCard or arg_5_0._opponent._actionCard

	if var_5_2 ~= nil then
		var_5_2._needAccount = false
	end
end

function var_0_0.beginForward(arg_6_0, arg_6_1)
	arg_6_0._isForwarding = true
	arg_6_0._isReviewing = true
	arg_6_0._forwardToRound = arg_6_1
end

function var_0_0.endForward(arg_7_0)
	arg_7_0._isForwarding = false
	arg_7_0._isReviewing = arg_7_0._reviewType ~= 0
	arg_7_0._forwardToRound = nil
end

function var_0_0.retreat(arg_8_0)
	arg_8_0._isRetreat = true

	local var_8_0 = arg_8_0:getActionPlayer()

	if var_8_0:checkFinish() then
		var_8_0._stepStatus = BattleData.Status.battle_end

		return var_8_0:step()
	end
end

function var_0_0.useCardFinish(arg_9_0)
	arg_9_0._isUseCardFinish = true

	local var_9_0 = arg_9_0:getActionPlayer()

	var_9_0._stepStatus = BattleData.Status.battle_end

	return var_9_0:step()
end

function var_0_0.skip(arg_10_0)
	arg_10_0._isSkipped = true

	arg_10_0:pause()
	arg_10_0._opponent:pause()
end

function var_0_0.pause(arg_11_0)
	arg_11_0._isPaused = true
end

function var_0_0.resume(arg_12_0)
	arg_12_0._isPaused = false

	if arg_12_0._pausedStatus ~= nil then
		arg_12_0._pausedStatus = nil

		arg_12_0:step()
	end
end

function var_0_0.checkFinish(arg_13_0)
	if arg_13_0._isClient and ClientData._isAutoTesting then
		return false
	end

	if arg_13_0._isClient and (arg_13_0._battleType == Data.BattleType.unittest or arg_13_0._battleType == Data.BattleType.teach) and arg_13_0._isAttacker and arg_13_0._round == 1 and arg_13_0._macroStatus == BattleData.Status.round_begin then
		return false
	end

	if arg_13_0._isFinished or arg_13_0._opponent._isFinished then
		return true
	end

	local var_13_0 = false

	if arg_13_0._isAttacker then
		var_13_0 = arg_13_0:getIsLose() or arg_13_0._opponent:getIsLose()
	else
		var_13_0 = arg_13_0._opponent:getIsLose() or arg_13_0:getIsLose()
	end

	var_13_0 = var_13_0 or arg_13_0:getIsWin() or arg_13_0._opponent:getIsWin()

	return var_13_0
end

function var_0_0.getIsWin(arg_14_0)
	return arg_14_0._battleCondition:getIsWin()
end

function var_0_0.getIsLose(arg_15_0)
	if arg_15_0._fortress._type == Data.CardType.boss then
		if arg_15_0._fortress._info._isDeamon == 1 then
			return not B.isAlive(arg_15_0._fortress)
		else
			return arg_15_0:getIsFortressDied()
		end
	end

	if arg_15_0._isRetreat then
		return true
	end

	if arg_15_0:getIsRoundExceed() then
		return true
	end

	if arg_15_0:getIsFortressDied() then
		return true
	end

	if arg_15_0:getIsAllCardsDied() then
		return true
	end

	if arg_15_0._macroStatus == BattleData.Status.round_begin and arg_15_0:getIsPileEmpty() and arg_15_0._battleType ~= Data.BattleType.teach then
		return true
	end

	if #arg_15_0._opponent:getBattleCardsBySkillFast("H", 3190) > 0 then
		local var_15_0 = Data._skillInfo[3190]
		local var_15_1 = 0
		local var_15_2 = {}
		local var_15_3 = arg_15_0._opponent:getBattleCardsByType("H", Data.CardType.monster)

		for iter_15_0 = 1, #var_15_3 do
			local var_15_4 = var_15_3[iter_15_0]._infoId

			for iter_15_1 = 1, #var_15_0._refCards do
				if var_15_4 == var_15_0._refCards[iter_15_1] and var_15_2[iter_15_1] == nil then
					var_15_2[iter_15_1] = true
					var_15_1 = var_15_1 + 1
				end
			end
		end

		if var_15_1 == #var_15_0._refCards then
			arg_15_0._opponent._winBy3190 = true

			return true
		end
	end

	if arg_15_0._opponent:hasBattleCardsBySkillFast("PH", 3798) then
		local var_15_5 = Data._skillInfo[3798]._refCards
		local var_15_6 = true

		for iter_15_2 = 1, #var_15_5 do
			if #arg_15_0._opponent:getBattleCardsByInfoId("B", var_15_5[iter_15_2]) == 0 then
				var_15_6 = false

				break
			end
		end

		if var_15_6 then
			arg_15_0._opponent._winBy3798 = true

			return true
		end
	end

	if arg_15_0._opponent._macroStatus == BattleData.Status.round_end then
		local var_15_7 = arg_15_0._opponent:getBattleCardsBySkillFast("B", 2234)

		for iter_15_3 = 1, #var_15_7 do
			if var_15_7[iter_15_3]:getBuffValue(true, BattleData.PositiveType.xyzMark) == 0 and arg_15_0._fortress._hp <= Data._skillInfo[2234]._val[1] then
				arg_15_0._opponent._winBy2234 = true

				return true
			end
		end
	end

	local var_15_8 = arg_15_0._opponent:getBattleCardsBySkillFast("B", 2237)

	for iter_15_4 = 1, #var_15_8 do
		if var_15_8[iter_15_4]:getBuffValue(true, BattleData.PositiveType.fateMark) >= Data._skillInfo[2237]._val[1] then
			arg_15_0._opponent._winBy2237 = true

			return true
		end
	end

	return false
end

function var_0_0.getIsPileEmpty(arg_16_0)
	return #arg_16_0._pileCards == 0 and (arg_16_0._baseBattleType ~= Data.BattleType.base_PVE or not not arg_16_0._isAttacker) and (not arg_16_0._isClient or not ClientData._isTesting and not (P._guideID < 100))
end

function var_0_0.getIsRoundExceed(arg_17_0)
	local var_17_0 = arg_17_0._round >= arg_17_0._maxRound and arg_17_0._opponent._round >= arg_17_0._maxRound and (arg_17_0._macroStatus == BattleData.Status.round_end or arg_17_0._macroStatus == BattleData.Status.battle_end) and (arg_17_0._opponent._macroStatus == BattleData.Status.round_end or arg_17_0._opponent._macroStatus == BattleData.Status.battle_end)

	if arg_17_0._isOnlinePvp then
		return var_17_0
	else
		return arg_17_0._isAttacker and var_17_0
	end
end

function var_0_0.getIsFortressDied(arg_18_0)
	return arg_18_0._fortress._hp <= 0
end

function var_0_0.getIsAllCardsDied(arg_19_0)
	if #arg_19_0._pileCards > 0 then
		return false
	end

	if #arg_19_0:getBoardCards() > 0 then
		return false
	end

	for iter_19_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		local var_19_0 = arg_19_0._opponent._boardCards[iter_19_0]

		if B.isAlive(var_19_0) and var_19_0._isBorrowed then
			return false
		end
	end

	for iter_19_1 = 1, #arg_19_0._handCards do
		local var_19_1 = arg_19_0._handCards[iter_19_1]

		if var_19_1:isMonsterRare() then
			return false
		elseif var_19_1._type == Data.CardType.magic and (arg_19_0:canUseMagic(var_19_1, false) or arg_19_0:canUseMagicLater(var_19_1)) then
			return false
		elseif var_19_1._type == Data.CardType.trap and (arg_19_0:canUseTrap(var_19_1, false) or arg_19_0:canUseTrapLater(var_19_1)) then
			return false
		end
	end

	if #arg_19_0:getBattleCards("CS") > 0 then
		return false
	end

	if #arg_19_0._handCards > 0 then
		arg_19_0._isRemainUnusable = true
	end

	return true
end

function var_0_0.genResult(arg_20_0, arg_20_1)
	arg_20_0._isFinished = true
	arg_20_0._opponent._isFinished = true
	arg_20_0._resultType = arg_20_1
	arg_20_0._opponent._resultType = (arg_20_1 == Data.BattleResult.draw or arg_20_1 == Data.BattleResult.illegal) and arg_20_1 or -arg_20_1
end

function var_0_0.getResult(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = 0

	for iter_21_0 = 1, #arg_21_0._summonedMonsterStar do
		local var_21_2 = arg_21_0._summonedMonsterStar[iter_21_0]

		var_21_0[var_21_2] = (var_21_0[var_21_2] or 0) + 1

		if var_21_2 ~= Data.XYZ_STAR and var_21_2 >= 7 then
			var_21_1 = var_21_1 + 1
		end
	end

	local var_21_3 = 0
	local var_21_4 = 0
	local var_21_5 = 0

	for iter_21_1 = 1, #arg_21_0._summonedMonsterAtk do
		if arg_21_0._summonedMonsterAtk[iter_21_1] >= 2500 then
			var_21_3 = var_21_3 + 1
		elseif arg_21_0._summonedMonsterAtk[iter_21_1] <= 1000 then
			var_21_4 = var_21_4 + 1
		end

		if arg_21_0._summonedMonsterDef[iter_21_1] >= 2100 then
			var_21_5 = var_21_5 + 1
		end
	end

	if arg_21_0._resultType == Data.BattleResult.win and not arg_21_0._opponent._isRetreat then
		arg_21_0._battlePass[1001] = arg_21_0._winBy3190 and 1 or 0
		arg_21_0._battlePass[1006] = arg_21_0._totalComposeSummonCount >= 3 and 1 or 0
		arg_21_0._battlePass[1007] = arg_21_0._totalRareSummonCount == 0 and 1 or 0
		arg_21_0._battlePass[1011] = arg_21_0._destroyMonsterCount[0] >= 8 and 1 or 0
		arg_21_0._battlePass[1012] = arg_21_0._destroyMonsterCount[0] == 0 and 1 or 0
		arg_21_0._battlePass[1016] = not arg_21_0._isNormalSummonedInRound[1] and not arg_21_0._isNormalSummonedInRound[2] and not arg_21_0._isNormalSummonedInRound[3] and 1 or 0
		arg_21_0._battlePass[1017] = not arg_21_0._isSpecialSummonedInRound[1] and not arg_21_0._isSpecialSummonedInRound[2] and not arg_21_0._isSpecialSummonedInRound[3] and not arg_21_0._isSpecialSummonedInRound[4] and not arg_21_0._isSpecialSummonedInRound[5] and 1 or 0
		arg_21_0._battlePass[1026] = arg_21_0._opponent._destroyMonsterCount[0] == 0 and 1 or 0
		arg_21_0._battlePass[1031] = arg_21_0._round <= 3 and 1 or 0
		arg_21_0._battlePass[1032] = (arg_21_0._damageScore["R" .. math.max(arg_21_0._round, arg_21_0._opponent._round)] or 0) >= 8000 and 1 or 0
		arg_21_0._battlePass[1035] = arg_21_0._opponent._destroyHeroScore[var_0_0.KEY_TOTAL] == 0 and 1 or 0
	else
		arg_21_0._battlePass[1001] = 0
		arg_21_0._battlePass[1002] = 0
		arg_21_0._battlePass[1006] = 0
		arg_21_0._battlePass[1007] = 0
		arg_21_0._battlePass[1011] = 0
		arg_21_0._battlePass[1012] = 0
		arg_21_0._battlePass[1016] = 0
		arg_21_0._battlePass[1017] = 0
		arg_21_0._battlePass[1021] = 0
		arg_21_0._battlePass[1022] = 0
		arg_21_0._battlePass[1026] = 0
		arg_21_0._battlePass[1027] = 0
		arg_21_0._battlePass[1031] = 0
		arg_21_0._battlePass[1032] = 0
		arg_21_0._battlePass[1035] = 0
	end

	arg_21_0._battlePass[1003] = arg_21_0._totalNormalSummonedMonsterCount4
	arg_21_0._battlePass[1004] = arg_21_0._totalSpecialSummonedMonsterCount
	arg_21_0._battlePass[1008] = arg_21_0._totalNormalSummonedMonsterCount5
	arg_21_0._battlePass[1013] = arg_21_0._totalCastedMagicCount + arg_21_0._totalCastedTrapCount
	arg_21_0._battlePass[1015] = arg_21_0._totalSpecialSummonedMonsterCount
	arg_21_0._battlePass[1018] = arg_21_0._destroyMonsterCount[0]
	arg_21_0._battlePass[1019] = var_21_0[1] and var_21_0[2] and var_21_0[3] and var_21_0[4] and var_21_0[5] and var_21_0[6] and var_21_0[7] and var_21_0[8] and 1 or 0
	arg_21_0._battlePass[1020] = var_21_3
	arg_21_0._battlePass[1023] = var_21_1
	arg_21_0._battlePass[1024] = var_21_5
	arg_21_0._battlePass[1025] = arg_21_0._totalCastedMagicCount + arg_21_0._totalCastedTrapCount
	arg_21_0._battlePass[1029] = var_21_4
	arg_21_0._battlePass[1033] = arg_21_0._totalSpecialSummonedMonsterCount
	arg_21_0._battlePass[1034] = arg_21_0._damageScore[var_0_0.KEY_TOTAL]

	return arg_21_0._resultType
end

function var_0_0.step(arg_22_0)
	if arg_22_0._isPaused then
		if arg_22_0._pausedStatus == nil then
			arg_22_0._pausedStatus = arg_22_0._stepStatus
		end

		return
	end

	if arg_22_0._stepStatus == BattleData.Status.battle_start then
		return arg_22_0:start()
	elseif arg_22_0._stepStatus == BattleData.Status.battle_end then
		return arg_22_0:finish()
	elseif arg_22_0._stepStatus == BattleData.Status.round_begin then
		return arg_22_0:roundBegin()
	elseif arg_22_0._stepStatus == BattleData.Status.deal then
		return arg_22_0:deal()
	elseif arg_22_0._stepStatus == BattleData.Status.use then
		return arg_22_0:use()
	elseif arg_22_0._stepStatus == BattleData.Status.action then
		return arg_22_0:action()
	elseif arg_22_0._stepStatus == BattleData.Status.round_end then
		return arg_22_0:roundEnd()
	elseif arg_22_0._stepStatus == BattleData.Status.initial_deal then
		return arg_22_0:initialDeal()
	elseif arg_22_0._stepStatus == BattleData.Status.drop then
		return arg_22_0:drop()
	elseif arg_22_0._stepStatus == BattleData.Status.before_account_status then
		return arg_22_0:beforeAccountStatus()
	elseif arg_22_0._stepStatus == BattleData.Status.after_account_status then
		return arg_22_0:afterAccountStatus()
	elseif arg_22_0._stepStatus == BattleData.Status.before_account_halo then
		return arg_22_0:beforeAccountHalo()
	elseif arg_22_0._stepStatus == BattleData.Status.after_account_halo then
		return arg_22_0:afterAccountHalo()
	elseif arg_22_0._stepStatus == BattleData.Status.before_account_spell then
		return arg_22_0:beforeAccountSpell()
	elseif arg_22_0._stepStatus == BattleData.Status.after_account_spell then
		return arg_22_0:afterAccountSpell()
	elseif arg_22_0._stepStatus == BattleData.Status.before_account_attack then
		return arg_22_0:beforeAccountAttack()
	elseif arg_22_0._stepStatus == BattleData.Status.after_account_attack then
		return arg_22_0:afterAccountAttack()
	elseif arg_22_0._stepStatus == BattleData.Status.before_account_event then
		return arg_22_0:beforeAccountEvent()
	elseif arg_22_0._stepStatus == BattleData.Status.after_account_event then
		return arg_22_0:afterAccountEvent()
	elseif arg_22_0._stepStatus == BattleData.Status.before_account_finish then
		return arg_22_0:beforeAccountFinish()
	elseif arg_22_0._stepStatus == BattleData.Status.after_account_finish then
		return arg_22_0:afterAccountFinish()
	elseif arg_22_0._stepStatus == BattleData.Status.before_account_trap then
		return arg_22_0:beforeAccountTrap()
	elseif arg_22_0._stepStatus == BattleData.Status.after_account_trap then
		return arg_22_0:afterAccountTrap()
	elseif arg_22_0._stepStatus == BattleData.Status.before_account_trap_when_attack then
		return arg_22_0:beforeAccountTrapWhenAttack()
	elseif arg_22_0._stepStatus == BattleData.Status.after_account_trap_when_attack then
		return arg_22_0:afterAccountTrapWhenAttack()
	elseif arg_22_0._stepStatus == BattleData.Status.account_status then
		return arg_22_0:accountStatus()
	elseif arg_22_0._stepStatus == BattleData.Status.account_halo then
		return arg_22_0:accountHalo()
	elseif arg_22_0._stepStatus == BattleData.Status.account_trap then
		return arg_22_0:accountTrap()
	elseif arg_22_0._stepStatus == BattleData.Status.account_trap_when_attack then
		return arg_22_0:accountTrapWhenAttack()
	elseif arg_22_0._stepStatus == BattleData.Status.spelling then
		return arg_22_0:spelling()
	elseif arg_22_0._stepStatus == BattleData.Status.under_spell_damage then
		return arg_22_0:underSpellDamage()
	elseif arg_22_0._stepStatus == BattleData.Status.account_spell then
		return arg_22_0:accountSpell()
	elseif arg_22_0._stepStatus == BattleData.Status.after_spell then
		return arg_22_0:afterSpell()
	elseif arg_22_0._stepStatus == BattleData.Status.end_spell then
		return arg_22_0:endSpell()
	elseif arg_22_0._stepStatus == BattleData.Status.before_attack then
		return arg_22_0:beforeAttack()
	elseif arg_22_0._stepStatus == BattleData.Status.attacking then
		return arg_22_0:attacking()
	elseif arg_22_0._stepStatus == BattleData.Status.under_attack then
		return arg_22_0:underAttack()
	elseif arg_22_0._stepStatus == BattleData.Status.under_attack_damage then
		return arg_22_0:underAttackDamage()
	elseif arg_22_0._stepStatus == BattleData.Status.ac_under_attack_damage then
		return arg_22_0:acUnderAttackDamage()
	elseif arg_22_0._stepStatus == BattleData.Status.account_attack then
		return arg_22_0:accountAttack()
	elseif arg_22_0._stepStatus == BattleData.Status.end_attack then
		return arg_22_0:endAttack()
	elseif arg_22_0._stepStatus == BattleData.Status.account_event then
		return arg_22_0:accountEvent()
	elseif arg_22_0._stepStatus == BattleData.Status.account_finish then
		return arg_22_0:accountFinish()
	elseif arg_22_0._stepStatus == BattleData.Status.try_use_card then
		return arg_22_0:tryUseCard()
	elseif arg_22_0._stepStatus == BattleData.Status.do_use_card then
		return arg_22_0:doUseCard()
	elseif arg_22_0._stepStatus == BattleData.Status.wait_oppo_use_card then
		return arg_22_0:waitOppoUseCard()
	elseif arg_22_0._stepStatus == BattleData.Status.wait_observe_use_card then
		return arg_22_0:waitObserveUseCard()
	end
end

function var_0_0.start(arg_23_0)
	if arg_23_0._macroStatus ~= BattleData.Status.battle_start then
		arg_23_0:battleLog("[BATTLE] ==================================")
		B.initProfile(2)
		B.beginProfile("battle", 1)

		if arg_23_0._isClient and arg_23_0._isReviewing then
			B.beginProfile("review", 2)
		end

		arg_23_0._macroStatus = BattleData.Status.battle_start
		arg_23_0._stepStatus = BattleData.Status.battle_start
		arg_23_0._opponent._stepStatus = BattleData.Status.wait_opponent

		local var_23_0 = BattleEvent.EventType.battle_start
		local var_23_1 = arg_23_0:getEvents(var_23_0)

		for iter_23_0 = 1, #var_23_1 do
			local var_23_2 = var_23_1[iter_23_0]

			arg_23_0:changeEvent(var_23_2, var_23_0)
		end

		if not arg_23_0._isReviewing then
			return arg_23_0:sendEvent(BattleData.Status.battle_start)
		end
	end

	if next(arg_23_0._eventToChange) ~= nil then
		arg_23_0._stepStatus = BattleData.Status.before_account_event

		return arg_23_0:step()
	end

	arg_23_0._stepStatus = not arg_23_0._isInitialDealed and arg_23_0._round == 0 and BattleData.Status.initial_deal or BattleData.Status.round_begin

	return arg_23_0:step()
end

function var_0_0.finish(arg_24_0)
	if arg_24_0._macroStatus ~= BattleData.Status.battle_end then
		arg_24_0:battleLog("[BATTLE] ==================================")

		if arg_24_0._isClient and arg_24_0._isReviewing then
			B.endProfile("review")
		end

		B.endProfile("battle")
		B.dumpProfile()

		if arg_24_0._isClient then
			print(arg_24_0._name, "is cheating: ", arg_24_0:getIsCheating())
			print(arg_24_0._opponent._name, "is cheating: ", arg_24_0:getIsCheating())
		end

		local var_24_0 = Data.BattleResult.draw
		local var_24_1 = arg_24_0:getIsLose()

		if var_24_1 ~= arg_24_0._opponent:getIsLose() then
			var_24_0 = var_24_1 and Data.BattleResult.lose or Data.BattleResult.win
		elseif var_24_1 then
			if arg_24_0._isOnlinePvp ~= true then
				if arg_24_0._fortress._hp <= 0 and arg_24_0._opponent._fortress._hp <= 0 then
					var_24_0 = Data.BattleResult.win
				else
					var_24_0 = arg_24_0._isAttacker and Data.BattleResult.lose or Data.BattleResult.win
				end
			end
		elseif arg_24_0._isOnlinePvp ~= true then
			var_24_0 = arg_24_0._isAttacker and Data.BattleResult.win or Data.BattleResult.lose
		end

		if arg_24_0._isUseCardFinish or arg_24_0._opponent._isUseCardFinish then
			var_24_0 = Data.BattleResult.illegal
		end

		print("+++++++++++++++battle result", var_24_0)

		arg_24_0._macroStatus = BattleData.Status.battle_end

		arg_24_0:genResult(var_24_0)

		local var_24_2 = BattleEvent.EventType.battle_end
		local var_24_3 = arg_24_0:getEvents(var_24_2)

		for iter_24_0 = 1, #var_24_3 do
			local var_24_4 = var_24_3[iter_24_0]

			arg_24_0:changeEvent(var_24_4, var_24_2)
		end

		if not arg_24_0._isReviewing then
			return arg_24_0:sendEvent(BattleData.Status.battle_end)
		end
	end

	if next(arg_24_0._eventToChange) ~= nil then
		arg_24_0._stepStatus = BattleData.Status.before_account_event

		return arg_24_0:step()
	end

	if arg_24_0._battleType == Data.BattleType.unittest then
		BattleTestData.dealTestResult()
	elseif not arg_24_0._isReviewing then
		return arg_24_0:sendEvent(BattleData.Status.send_battle_end)
	end
end

function var_0_0.initialDeal(arg_25_0)
	if arg_25_0._macroStatus ~= BattleData.Status.initial_deal then
		arg_25_0:battleLog("")
		arg_25_0:battleLog("[BATTLE] <INITIAL DEAL>")

		arg_25_0._isInitialDealed = true
		arg_25_0._macroStatus = BattleData.Status.initial_deal
		arg_25_0._normalStatus = BattleData.Status.default
		arg_25_0._initialDealIndex = 0

		arg_25_0:resetWhenInitialDeal()
		arg_25_0._opponent:resetWhenInitialDeal()
	end

	if arg_25_0._isForwarding and arg_25_0._forwardToRound == 1 then
		return
	end

	if next(arg_25_0._cardStatusToChange) ~= nil then
		arg_25_0._stepStatus = BattleData.Status.before_account_status

		return arg_25_0:step()
	end

	if arg_25_0._initialDealIndex == 0 then
		arg_25_0._initialDealIndex = not arg_25_0._isAttacker and arg_25_0._baseBattleType ~= Data.BattleType.base_PVP and 1 or 3

		if not arg_25_0._isReviewing and not arg_25_0._opponent._isInitialDealed then
			return arg_25_0:sendEvent(BattleData.Status.initial_deal)
		end
	elseif arg_25_0._initialDealIndex <= 2 then
		arg_25_0._initialDealIndex = arg_25_0._initialDealIndex + 1
	elseif arg_25_0._initialDealIndex == 3 then
		arg_25_0._initialDealIndex = arg_25_0._initialDealIndex + 1

		local var_25_0 = math.min(arg_25_0._isClient and P._guideID == 11 and 0 or arg_25_0._isAttacker and Data.CARD_COUNT_OF_INITIAL_DEAL - 1 or Data.CARD_COUNT_OF_INITIAL_DEAL, math.min(#arg_25_0._pileCards, Data.MAX_CARD_COUNT_IN_HAND - #arg_25_0._handCards))

		for iter_25_0 = 1, var_25_0 do
			local var_25_1 = arg_25_0._pileCards[iter_25_0]

			arg_25_0:changeCardStatus(var_25_1, BattleData.CardStatus.pile, BattleData.CardStatus.hand)
		end

		if #arg_25_0._assistant > 0 then
			arg_25_0._actionCard = arg_25_0:getBoardCards()[1]

			if arg_25_0._actionCard ~= nil then
				arg_25_0:removeDeadCards()
			end
		end
	elseif arg_25_0._initialDealIndex == 4 then
		if arg_25_0._opponent._isInitialDealed then
			arg_25_0._opponent._stepStatus = BattleData.Status.round_begin
			arg_25_0._stepStatus = BattleData.Status.wait_opponent

			return arg_25_0._opponent:step()
		else
			arg_25_0._opponent._stepStatus = BattleData.Status.initial_deal
			arg_25_0._stepStatus = BattleData.Status.wait_opponent

			return arg_25_0._opponent:step()
		end
	end

	return arg_25_0:step()
end

function var_0_0.roundBegin(arg_26_0)
	if arg_26_0._macroStatus ~= BattleData.Status.round_begin then
		arg_26_0._macroStatus = BattleData.Status.round_begin
		arg_26_0._normalStatus = BattleData.Status.default
		arg_26_0._fortressSkillDone = arg_26_0._round <= 0
		arg_26_0._haloDone = false

		arg_26_0:resetWhenRoundBegin()

		local var_26_0 = arg_26_0._isAttacker and arg_26_0 or arg_26_0._opponent
		local var_26_1 = arg_26_0._isAttacker and arg_26_0._opponent or arg_26_0

		arg_26_0:battleLog("")
		arg_26_0:battleLog("[BATTLE] <BEGIN>")
		arg_26_0:battleLog("[BATTLE] %s ROUND %02d, P%d, H%d, B%d, HP %d", Str(arg_26_0._isAttacker and STR.SELF or STR.OPPONENT), arg_26_0._round, #arg_26_0._pileCards, #arg_26_0._handCards, #arg_26_0:getBoardCards(), arg_26_0._fortress._hp)

		local var_26_2 = "[BATTLE] [H] "

		for iter_26_0 = 1, #var_26_1._handCards do
			var_26_2 = var_26_2 .. arg_26_0:cardName(var_26_1._handCards[iter_26_0]) .. "\t"
		end

		arg_26_0:battleLog(var_26_2)

		local var_26_3 = "[BATTLE] [C] "

		for iter_26_1 = 1, Data.MAX_CARD_COUNT_ON_COVER do
			if var_26_1._coverCards[iter_26_1] ~= nil then
				var_26_3 = var_26_3 .. arg_26_0:cardName(var_26_1._coverCards[iter_26_1]) .. "\t"
			end

			if var_26_1._showCards[iter_26_1] ~= nil then
				var_26_3 = var_26_3 .. arg_26_0:cardName(var_26_1._showCards[iter_26_1]) .. "\t"
			end
		end

		arg_26_0:battleLog(var_26_3)

		local var_26_4 = "[BATTLE] [B] "

		for iter_26_2 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
			if var_26_1._boardCards[iter_26_2] ~= nil then
				var_26_4 = var_26_4 .. arg_26_0:cardName(var_26_1._boardCards[iter_26_2]) .. "\t"
			end
		end

		arg_26_0:battleLog(var_26_4)

		local var_26_5 = "[BATTLE] [B] "

		for iter_26_3 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
			if var_26_0._boardCards[iter_26_3] ~= nil then
				var_26_5 = var_26_5 .. arg_26_0:cardName(var_26_0._boardCards[iter_26_3]) .. "\t"
			end
		end

		arg_26_0:battleLog(var_26_5)

		local var_26_6 = "[BATTLE] [C] "

		for iter_26_4 = 1, Data.MAX_CARD_COUNT_ON_COVER do
			if var_26_0._coverCards[iter_26_4] ~= nil then
				var_26_6 = var_26_6 .. arg_26_0:cardName(var_26_0._coverCards[iter_26_4]) .. "\t"
			end

			if var_26_0._showCards[iter_26_4] ~= nil then
				var_26_6 = var_26_6 .. arg_26_0:cardName(var_26_0._showCards[iter_26_4]) .. "\t"
			end
		end

		arg_26_0:battleLog(var_26_6)

		local var_26_7 = "[BATTLE] [H] "

		for iter_26_5 = 1, #var_26_0._handCards do
			var_26_7 = var_26_7 .. arg_26_0:cardName(var_26_0._handCards[iter_26_5]) .. "\t"
		end

		arg_26_0:battleLog(var_26_7)

		if arg_26_0._round > 0 then
			arg_26_0._actionCard = arg_26_0:getBoardCards()[1] or arg_26_0:getGhostCard()

			if arg_26_0._actionCard ~= nil then
				arg_26_0:resetActionCard()
				arg_26_0:resetAccount()

				local var_26_8 = arg_26_0:getBattleCards("BC")

				for iter_26_6 = 1, #var_26_8 do
					local var_26_9 = var_26_8[iter_26_6]

					arg_26_0:decNegativeStatus(var_26_9, BattleData.NEGATIVE_CLEAR_WHEN_ROUND_BEGIN, false, var_26_9._id, 0, Data.SkillMode.once)
					var_26_9:decShieldWhenRoundBegin()
				end

				arg_26_0._fortress:decShieldWhenRoundBegin()

				local var_26_10 = arg_26_0:getBoardCards()

				for iter_26_7 = 1, #var_26_10 do
					var_26_10[iter_26_7]:removeUnderSkillByRemoveMode(Data.SkillMode.round_begin)
				end

				local var_26_11 = arg_26_0._opponent:getBoardCards()

				for iter_26_8 = 1, #var_26_11 do
					var_26_11[iter_26_8]:removeUnderSkillByRemoveMode(Data.SkillMode.oppo_round_begin)
				end

				arg_26_0:account()
				arg_26_0:removeDeadCards()
			end
		end

		for iter_26_9 = 1, Data.MAX_CARD_COUNT_ON_COVER do
			local var_26_12 = arg_26_0._coverCards[iter_26_9]

			if B.isAlive(var_26_12) and var_26_12._owner:canTriggerTrapWhenRoundBegin(var_26_12) then
				arg_26_0:changeCardStatus(var_26_12, BattleData.CardStatus.cover, BattleData.CardStatus.show)
			end
		end

		for iter_26_10 = 1, Data.MAX_CARD_COUNT_ON_COVER do
			local var_26_13 = arg_26_0._opponent._coverCards[iter_26_10]

			if B.isAlive(var_26_13) and var_26_13._owner:canTriggerTrapWhenOppoRoundBegin(var_26_13) then
				arg_26_0:changeCardStatus(var_26_13, BattleData.CardStatus.cover, BattleData.CardStatus.show)
			end
		end

		local var_26_14 = BattleEvent.EventType.round_begin
		local var_26_15 = arg_26_0:getEvents(var_26_14)

		for iter_26_11 = 1, #var_26_15 do
			local var_26_16 = var_26_15[iter_26_11]

			arg_26_0:changeEvent(var_26_16, var_26_14)
		end

		if arg_26_0._isClient and arg_26_0._isOnlinePvp and arg_26_0._playerType ~= BattleData.PlayerType.replay then
			arg_26_0:sendEvent(BattleData.Status.pvp_timing_begin)
		end

		if not arg_26_0._isReviewing then
			return arg_26_0:sendEvent(BattleData.Status.round_begin)
		end
	end

	if arg_26_0._isForwarding and arg_26_0._round == arg_26_0._forwardToRound then
		arg_26_0:sendEvent(BattleData.Status.round_begin)

		return
	end

	if ClientData and ClientData._cfg and ClientData._cfg.testBattleDebug then
		local var_26_17 = (nil).b
	end

	if arg_26_0:checkFinish() then
		arg_26_0._stepStatus = BattleData.Status.before_account_finish

		return arg_26_0:step()
	end

	if next(arg_26_0._cardStatusToChange) ~= nil then
		arg_26_0._stepStatus = BattleData.Status.before_account_status

		return arg_26_0:step()
	end

	if next(arg_26_0._eventToChange) ~= nil then
		arg_26_0._stepStatus = BattleData.Status.before_account_event

		return arg_26_0:step()
	end

	if not arg_26_0._fortressSkillDone and arg_26_0._fortressSkill ~= nil then
		arg_26_0._fortressSkillDone = true
		arg_26_0._actionCard = arg_26_0:getGhostCard()

		arg_26_0:resetActionCard()
		arg_26_0:resetAccount()

		arg_26_0._spellType = Data.SkillMode.round_begin
		arg_26_0._stepStatus = BattleData.Status.before_account_spell

		return arg_26_0:step()
	end

	if not B.isAlive(arg_26_0._cardInAction) then
		arg_26_0._cardInAction = nil
	end

	local var_26_18 = arg_26_0._cardInAction

	if var_26_18 == nil then
		local var_26_19 = B.mergeTable({
			arg_26_0:getBattleCards("BCSD"),
			arg_26_0._opponent:getBattleCards("BCSD")
		})

		for iter_26_12 = 1, #var_26_19 do
			local var_26_20 = var_26_19[iter_26_12]

			if B.isAlive(var_26_20) and var_26_20._roundBeginActionIndex ~= nil and var_26_20._roundBeginActionIndex <= var_26_20._roundBeginActionCount then
				var_26_18 = var_26_20

				break
			end
		end
	end

	if var_26_18 == nil then
		local var_26_21 = arg_26_0:getBattleCardsBySkillModes("G", {
			Data.SkillMode.in_grave,
			Data.SkillMode.round_begin
		})
		local var_26_22 = arg_26_0._opponent:getBattleCardsBySkillModes("G", {
			Data.SkillMode.in_grave,
			Data.SkillMode.oppo_round_begin
		})
		local var_26_23 = arg_26_0:getBattleCardsBySkillModes("GL", {
			Data.SkillMode.in_gl,
			Data.SkillMode.round_begin
		})
		local var_26_24 = arg_26_0._opponent:getBattleCardsBySkillModes("GL", {
			Data.SkillMode.in_gl,
			Data.SkillMode.oppo_round_begin
		})
		local var_26_25 = arg_26_0:getBattleCardsBySkillModes("H", {
			Data.SkillMode.in_hand,
			Data.SkillMode.round_begin
		})
		local var_26_26 = arg_26_0._opponent:getBattleCardsBySkillModes("H", {
			Data.SkillMode.in_hand,
			Data.SkillMode.oppo_round_begin
		})
		local var_26_27 = arg_26_0:getBattleCardsByInfoIdGroup("R", {
			40651,
			40652
		})
		local var_26_28 = arg_26_0._opponent:getBattleCardsByInfoIdGroup("R", {
			40651,
			40652
		})
		local var_26_29 = B.mergeTable({
			var_26_21,
			var_26_22,
			var_26_23,
			var_26_24,
			var_26_25,
			var_26_26,
			var_26_27,
			var_26_28
		})

		if arg_26_0._round == 1 then
			local var_26_30 = arg_26_0:getBattleCardsBySkillFast("R", 13354)

			B.appendTable(var_26_29, var_26_30)
		end

		if arg_26_0._round == (arg_26_0._battleType == Data.BattleType.PVP_room and 2 or 1) then
			local var_26_31 = arg_26_0:getBattleCardsBySkillFast("R", 13634)

			B.appendTable(var_26_29, var_26_31)

			local var_26_32 = arg_26_0._opponent:getBattleCardsBySkillFast("R", 13634)

			B.appendTable(var_26_29, var_26_32)
		end

		for iter_26_13 = 1, #var_26_29 do
			local var_26_33 = var_26_29[iter_26_13]

			if var_26_33._roundBeginActionIndex ~= nil and var_26_33._roundBeginActionIndex <= var_26_33._roundBeginActionCount then
				var_26_18 = var_26_33

				break
			end
		end
	end

	if var_26_18 ~= nil then
		if var_26_18._roundBeginActionIndex <= var_26_18._roundBeginActionCount then
			arg_26_0._cardInAction = var_26_18
			arg_26_0._actionCard = var_26_18
			arg_26_0._spellType = var_26_18._owner == arg_26_0 and Data.SkillMode.round_begin or Data.SkillMode.oppo_round_begin
			arg_26_0._stepStatus = BattleData.Status.before_account_spell
			var_26_18._roundBeginActionIndex = var_26_18._roundBeginActionIndex + 1

			return arg_26_0:step()
		else
			arg_26_0._cardInAction = nil
			arg_26_0._actionCard = nil
			arg_26_0._stepStatus = BattleData.Status.round_begin

			return arg_26_0:step()
		end
	end

	arg_26_0._cardInAction = nil

	if not arg_26_0._haloDone then
		arg_26_0._haloDone = true
		arg_26_0._stepStatus = BattleData.Status.before_account_halo

		return arg_26_0:step()
	end

	arg_26_0._stepStatus = BattleData.Status.deal

	return arg_26_0:step()
end

function var_0_0.deal(arg_27_0)
	if arg_27_0._macroStatus ~= BattleData.Status.deal then
		arg_27_0:battleLog("")
		arg_27_0:battleLog("[BATTLE] <DEAL>")

		arg_27_0._macroStatus = BattleData.Status.deal
		arg_27_0._normalStatus = BattleData.Status.default

		local var_27_0 = 1

		while true do
			local var_27_1 = arg_27_0._tempLeaveCards[var_27_0]

			if var_27_1 == nil then
				break
			end

			if var_27_1._returnRound == arg_27_0._round and arg_27_0:returnCard(var_27_1) then
				table.remove(arg_27_0._tempLeaveCards, var_27_0)
			else
				var_27_0 = var_27_0 + 1
			end
		end

		local var_27_2 = 1

		while true do
			local var_27_3 = arg_27_0._opponent._tempLeaveCards[var_27_2]

			if var_27_3 == nil then
				break
			end

			if var_27_3._oppoReturnRound == arg_27_0._round and arg_27_0._opponent:returnCard(var_27_3) then
				table.remove(arg_27_0._opponent._tempLeaveCards, var_27_2)
			else
				var_27_2 = var_27_2 + 1
			end
		end

		if not arg_27_0._isDealDisabled and arg_27_0._round > 0 and #arg_27_0._pileCards > 0 and (not arg_27_0._isClient or arg_27_0._battleType ~= Data.BattleType.unittest and arg_27_0._battleType ~= Data.BattleType.teach or not arg_27_0._isAttacker or not (arg_27_0._round <= 1)) then
			if arg_27_0._battleType == Data.BattleType.PVP_room and arg_27_0._round == 1 then
				local var_27_4 = B.createCard(20236, 1)

				arg_27_0:addCardToCards(var_27_4)
				arg_27_0:changeCardStatus(var_27_4, BattleData.CardStatus.leave, BattleData.CardStatus.hand)
			else
				local var_27_5 = Data.CARD_COUNT_OF_ROUND_DEAL

				if #arg_27_0:getBattleCards("H") == 0 and #arg_27_0:getCanEffectTrapCardsBySkills("S", {
					8023
				}) + #arg_27_0._opponent:getCanEffectTrapCardsBySkills("S", {
					8023
				}) > 0 then
					var_27_5 = var_27_5 + 1
				end

				if arg_27_0._mark13700 then
					arg_27_0._mark13700 = nil
					var_27_5 = var_27_5 + 1
				end

				if arg_27_0._mark13953 then
					var_27_5 = var_27_5 + arg_27_0._mark13953
					arg_27_0._mark13953 = nil
				end

				local var_27_6 = math.min(var_27_5, math.min(#arg_27_0._pileCards, Data.MAX_CARD_COUNT_IN_HAND - #arg_27_0._handCards))

				for iter_27_0 = 1, var_27_6 do
					local var_27_7 = arg_27_0._pileCards[iter_27_0]

					if var_27_7:isNormalMonster() and arg_27_0:hasBattleCardsBySkillFast("S", 7047) then
						local var_27_8 = arg_27_0._pileCards[iter_27_0 + 1]

						if var_27_8 ~= nil and #arg_27_0:filterCanChangeToHandCards({
							var_27_8
						}) > 0 then
							arg_27_0:changeCardStatus(var_27_7, BattleData.CardStatus.pile, BattleData.CardStatus.hand, BattleData.CardStatusVal.p2h_deal_show)
							arg_27_0:changeCardStatus(var_27_8, BattleData.CardStatus.pile, BattleData.CardStatus.hand)
						else
							arg_27_0:changeCardStatus(var_27_7, BattleData.CardStatus.pile, BattleData.CardStatus.hand, BattleData.CardStatusVal.p2h_deal)
						end
					else
						arg_27_0:changeCardStatus(var_27_7, BattleData.CardStatus.pile, BattleData.CardStatus.hand, BattleData.CardStatusVal.p2h_deal)
					end
				end
			end
		end

		arg_27_0._isDealDisabled = false

		if not arg_27_0._isReviewing then
			return arg_27_0:sendEvent(BattleData.Status.deal)
		end
	end

	if arg_27_0:checkFinish() then
		arg_27_0._stepStatus = BattleData.Status.before_account_finish

		return arg_27_0:step()
	end

	if next(arg_27_0._cardStatusToChange) ~= nil then
		arg_27_0._stepStatus = BattleData.Status.before_account_status

		return arg_27_0:step()
	end

	arg_27_0._stepStatus = BattleData.Status.use

	return arg_27_0:step()
end

function var_0_0.use(arg_28_0)
	if arg_28_0._macroStatus ~= BattleData.Status.use then
		arg_28_0:battleLog("")
		arg_28_0:battleLog("[BATTLE] <USE>")

		arg_28_0._macroStatus = BattleData.Status.use
		arg_28_0._normalStatus = BattleData.Status.default

		local var_28_0 = arg_28_0:getBoardCards()

		for iter_28_0 = 1, #var_28_0 do
			var_28_0[iter_28_0]._actionIndex = 1
			var_28_0[iter_28_0]._actionCount = 1
		end

		if not arg_28_0._isReviewing then
			return arg_28_0:sendEvent(BattleData.Status.use)
		end
	end

	if arg_28_0:checkFinish() then
		arg_28_0._stepStatus = BattleData.Status.before_account_finish

		return arg_28_0:step()
	end

	if arg_28_0._round <= 0 then
		return arg_28_0:startAction()
	end

	if next(arg_28_0._cardStatusToChange) ~= nil then
		arg_28_0._stepStatus = BattleData.Status.before_account_status

		return arg_28_0:step()
	end

	local var_28_1
	local var_28_2
	local var_28_3
	local var_28_4
	local var_28_5

	if arg_28_0._isForwarding or arg_28_0._playerType == BattleData.PlayerType.replay or arg_28_0._playerType == BattleData.PlayerType.observe or arg_28_0._playerType == BattleData.PlayerType.opponent or arg_28_0._playerType == BattleData.PlayerType.mix then
		local var_28_6

		var_28_1, var_28_2, var_28_3, var_28_4, var_28_6 = arg_28_0:replayUseCard()

		if arg_28_0._playerType == BattleData.PlayerType.replay and var_28_1 ~= nil then
			arg_28_0:battleLog("")

			if var_28_1._status == BattleData.CardStatus.hand then
				if var_28_2 ~= nil then
					arg_28_0:battleLog("[BATTLE] <REPLAY>\t%s  ^  %s", arg_28_0:cardName(var_28_1), arg_28_0:cardName(var_28_2))
				else
					arg_28_0:battleLog("[BATTLE] <REPLAY>\t%s", arg_28_0:cardName(var_28_1))
				end
			elseif var_28_2 ~= nil then
				arg_28_0:battleLog("[BATTLE] <REPLAY>\t%s <-> %s", arg_28_0:cardName(var_28_1), arg_28_0:cardName(var_28_2))
			else
				arg_28_0:battleLog("[BATTLE] <REPLAY>\t%s", arg_28_0:cardName(var_28_1))
			end
		end

		if var_28_6 == BattleData.UseCardId.retreat then
			if var_28_2 == true then
				return arg_28_0:retreat()
			else
				return arg_28_0._opponent:retreat()
			end
		elseif var_28_6 == BattleData.UseCardId.round then
			-- block empty
		elseif var_28_6 == BattleData.UseCardId.finish then
			arg_28_0:useCardFinish()
		elseif var_28_1 == nil then
			if arg_28_0._isSkipped then
				var_28_1, var_28_2, var_28_3, var_28_4 = arg_28_0:aiUseCard()
			elseif arg_28_0._isForwarding then
				return
			elseif arg_28_0._playerType == BattleData.PlayerType.replay then
				var_28_1, var_28_2, var_28_3, var_28_4 = arg_28_0:aiUseCard()
			elseif arg_28_0._playerType == BattleData.PlayerType.observe then
				return arg_28_0:waitObserveUseCard()
			elseif arg_28_0._playerType == BattleData.PlayerType.opponent then
				return arg_28_0:waitOppoUseCard()
			elseif arg_28_0._playerType == BattleData.PlayerType.mix then
				if ClientData._isOppoOnline then
					return arg_28_0:waitOppoUseCard()
				else
					var_28_1, var_28_2, var_28_3, var_28_4 = arg_28_0:aiUseCard()
				end
			end
		end
	elseif arg_28_0._playerType == BattleData.PlayerType.player then
		local var_28_7

		var_28_1, var_28_2, var_28_3, var_28_4, var_28_7 = arg_28_0:replayUseCard()

		if var_28_1 == nil and var_28_7 == nil then
			if arg_28_0._isSkipped then
				var_28_1, var_28_2, var_28_3, var_28_4 = arg_28_0:aiUseCard()
			else
				return arg_28_0:tryUseCard()
			end
		end
	elseif arg_28_0._playerType == BattleData.PlayerType.enviroment then
		if arg_28_0._ops and arg_28_0._ops[arg_28_0._replayIndex] then
			var_28_1, var_28_2, var_28_3, var_28_4 = arg_28_0:replayUseCard()
		else
			var_28_1, var_28_2, var_28_3, var_28_4 = arg_28_0:aiUseCard()
		end
	end

	if var_28_1 ~= nil then
		return arg_28_0:useCard(var_28_1, var_28_2, var_28_3, var_28_4)
	else
		return arg_28_0:startAction()
	end
end

function var_0_0.action(arg_29_0)
	if arg_29_0._macroStatus ~= BattleData.Status.action then
		arg_29_0:battleLog("")
		arg_29_0:battleLog("[BATTLE] <ACTION>")

		arg_29_0._macroStatus = BattleData.Status.action
		arg_29_0._normalStatus = BattleData.Status.default

		for iter_29_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD * 2 do
			local var_29_0 = iter_29_0 <= Data.MAX_CARD_COUNT_ON_BOARD and arg_29_0._boardCards[iter_29_0] or arg_29_0._opponent._boardCards[iter_29_0 - Data.MAX_CARD_COUNT_ON_BOARD]

			if B.isAlive(var_29_0) then
				var_29_0._actionIndex = 1
				var_29_0._actionCount = 1
			end
		end

		if arg_29_0._fortress._type == Data.CardType.boss then
			arg_29_0._fortress._actionIndex = 1
			arg_29_0._fortress._actionCount = 1
		end

		arg_29_0._cardInAction = nil
		arg_29_0._actionStep = 1

		if not arg_29_0._isReviewing then
			return arg_29_0:sendEvent(BattleData.Status.action)
		end
	end

	if arg_29_0:checkFinish() then
		arg_29_0._stepStatus = BattleData.Status.before_account_finish

		return arg_29_0:step()
	end

	local var_29_1 = arg_29_0._cardInAction

	if var_29_1 == nil then
		for iter_29_1 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
			local var_29_2 = arg_29_0._boardCards[iter_29_1]

			if B.isAlive(var_29_2) and var_29_2._actionIndex <= var_29_2._actionCount then
				var_29_1 = var_29_2

				break
			end
		end

		if var_29_1 == nil and arg_29_0._fortress._type == Data.CardType.boss and arg_29_0._fortress._actionIndex <= arg_29_0._fortress._actionCount then
			var_29_1 = arg_29_0._fortress
		end
	end

	if var_29_1 ~= nil then
		if arg_29_0._actionStep == 1 then
			arg_29_0._actionStep = arg_29_0._actionStep + 1
			arg_29_0._cardInAction = var_29_1
			arg_29_0._actionCard = var_29_1
			arg_29_0._spellType = Data.SkillMode.spelling
			arg_29_0._stepStatus = BattleData.Status.before_account_spell

			return arg_29_0:step()
		elseif arg_29_0._actionStep == 2 then
			arg_29_0._actionStep = arg_29_0._actionStep + 1
			arg_29_0._actionCard = var_29_1
			arg_29_0._stepStatus = BattleData.Status.before_account_attack
			var_29_1._atkCount = 1

			return arg_29_0:step()
		elseif arg_29_0._actionStep == 3 then
			arg_29_0._actionStep = 1
			var_29_1._actionIndex = var_29_1._actionIndex + 1
			arg_29_0._cardInAction = nil
			arg_29_0._actionCard = nil
			arg_29_0._stepStatus = BattleData.Status.action

			return arg_29_0:step()
		end
	end

	arg_29_0._cardInAction = nil
	arg_29_0._stepStatus = BattleData.Status.round_end

	return arg_29_0:step()
end

function var_0_0.roundEnd(arg_30_0)
	if arg_30_0._macroStatus ~= BattleData.Status.round_end then
		arg_30_0._macroStatus = BattleData.Status.round_end
		arg_30_0._normalStatus = BattleData.Status.default
		arg_30_0._eventDone = false
		arg_30_0._haloDone = false
		arg_30_0._fortressSkillDone = arg_30_0._round < 0
		arg_30_0._isSummonDisabled = false
		arg_30_0._isUseHandCardDisabled = false
		arg_30_0._endRound = arg_30_0._round
		arg_30_0._opponent._disableTrapBy4127 = nil

		if next(arg_30_0._disableSkillByOwnerInfoId) ~= nil then
			B._lastAccount = nil
		end

		arg_30_0._disableSkillByOwnerInfoId = {}
		arg_30_0._mark9359 = nil

		if arg_30_0._battleType == Data.BattleType.PVP_room and arg_30_0._round == 1 then
			local var_30_0 = arg_30_0:getBattleCardsByInfoId("H", 20236)[1]

			if var_30_0 ~= nil then
				arg_30_0:setCardStatus(var_30_0, BattleData.CardStatus.leave, cid, id, mode)
				arg_30_0:account()
			end
		end

		if arg_30_0._battleType ~= Data.BattleType.unittest and #arg_30_0._handCards > Data.MAX_CARD_COUNT_IN_HAND_AFTER_DROP then
			for iter_30_0 = #arg_30_0._handCards, Data.MAX_CARD_COUNT_IN_HAND_AFTER_DROP + 1, -1 do
				arg_30_0:setCardStatus(arg_30_0._handCards[iter_30_0], BattleData.CardStatus.grave, cid, id, mode, BattleData.CardStatusVal.h2g_drop)
				arg_30_0:account()
			end
		end

		local var_30_1 = B.mergeTable({
			arg_30_0:getBattleCards("BS"),
			arg_30_0._opponent:getBattleCards("BS")
		})

		for iter_30_1 = 1, #var_30_1 do
			var_30_1[iter_30_1]._mark7384 = not var_30_1[iter_30_1]:actioned()
			var_30_1[iter_30_1]._actionIndex = 1
			var_30_1[iter_30_1]._actionCount = 1
		end

		if arg_30_0._fortress._type == Data.CardType.boss then
			arg_30_0._fortress._actionIndex = 1
			arg_30_0._fortress._actionCount = 1
		end

		for iter_30_2 = 1, #arg_30_0._delaySkillCards do
			local var_30_2 = arg_30_0._delaySkillCards[iter_30_2]

			var_30_2._actionIndex = 1
			var_30_2._actionCount = 1
		end

		for iter_30_3 = 1, #arg_30_0._opponent._delaySkillCards do
			local var_30_3 = arg_30_0._opponent._delaySkillCards[iter_30_3]

			var_30_3._actionIndex = 1
			var_30_3._actionCount = 1
		end

		arg_30_0._cardInAction = nil

		local var_30_4 = B.mergeTable({
			arg_30_0:getBattleCards("BS"),
			arg_30_0._opponent:getBattleCards("BS")
		})

		if #var_30_4 > 0 then
			arg_30_0._actionCard = var_30_4[1]

			arg_30_0:resetActionCard()
			arg_30_0:resetAccount()

			local var_30_5 = 0
			local var_30_6 = 0

			for iter_30_4 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
				if arg_30_0._opponent:isBoardPosEmpty(iter_30_4) then
					var_30_5 = var_30_5 + 1
				end
			end

			for iter_30_5 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
				local var_30_7 = arg_30_0._boardCards[iter_30_5]

				if B.isAlive(var_30_7) then
					var_30_7._atkCount = 1
					var_30_7._actionCount = 1

					arg_30_0:decPositiveStatus(var_30_7, BattleData.POSITIVE_CLEAR_WHEN_ROUND_END, false, var_30_7._id, 0, Data.SkillMode.once)

					if var_30_7._isBorrowed then
						if var_30_6 < var_30_5 then
							arg_30_0:changeCardStatus(var_30_7, BattleData.CardStatus.board, BattleData.CardStatus.board, BattleData.CardStatusVal.b2b_oppo_once)

							var_30_6 = var_30_6 + 1
						else
							var_30_7._isBorrowed = false
						end
					else
						arg_30_0:decNegativeStatus(var_30_7, BattleData.NEGATIVE_CLEAR_WHEN_ROUND_END, false, var_30_7._id, 0, Data.SkillMode.once)

						if var_30_7._negativeStatus[BattleData.NegativeType.haloSkillFrozen] then
							arg_30_0._haloDone = false
						end

						if var_30_7:hasBuff(false, BattleData.NegativeType.atkFrozen) then
							local var_30_8 = var_30_7:getBuffValue(false, BattleData.NegativeType.atkFrozen)

							if var_30_8 <= 1 then
								arg_30_0:decNegativeStatus(var_30_7, {
									BattleData.NegativeType.atkFrozen
								}, false, var_30_7._id, 0, Data.SkillMode.once)
							else
								var_30_7:modifyBuffValue(false, BattleData.NegativeType.atkFrozen, var_30_8 - 1)
							end
						end

						if var_30_7:hasBuff(false, BattleData.NegativeType.disablePosture) then
							local var_30_9 = var_30_7:getBuffValue(false, BattleData.NegativeType.disablePosture)

							if var_30_9 <= 1 then
								arg_30_0:decNegativeStatus(var_30_7, {
									BattleData.NegativeType.disablePosture
								}, false, var_30_7._id, 0, Data.SkillMode.once)
							else
								var_30_7:modifyBuffValue(false, BattleData.NegativeType.disablePosture, var_30_9 - 1)
							end
						end
					end

					var_30_7:removeUnderSkillByRemoveMode(Data.SkillMode.round_end)
				end

				local var_30_10 = arg_30_0._opponent._boardCards[iter_30_5]

				if B.isAlive(var_30_10) then
					var_30_10:removeUnderSkillByRemoveMode(Data.SkillMode.oppo_round_end)
				end
			end

			local var_30_11 = arg_30_0:getBattleCards("SD")

			for iter_30_6 = 1, #var_30_11 do
				var_30_11[iter_30_6]:removeUnderSkillByRemoveMode(Data.SkillMode.round_end)

				if var_30_11[iter_30_6]:hasBuff(false, BattleData.NegativeType.disableMagicTrap) then
					B._lastAccount = nil
				end

				arg_30_0:decNegativeStatus(var_30_11[iter_30_6], BattleData.NEGATIVE_CLEAR_WHEN_ROUND_END, false, var_30_11[iter_30_6]._id, 0, Data.SkillMode.once)
			end

			local var_30_12 = arg_30_0._opponent:getBattleCards("SD")

			for iter_30_7 = 1, #var_30_12 do
				var_30_12[iter_30_7]:removeUnderSkillByRemoveMode(Data.SkillMode.oppo_round_end)

				if var_30_12[iter_30_7]:hasBuff(false, BattleData.NegativeType.disableMagicTrap) then
					B._lastAccount = nil
				end

				arg_30_0:decNegativeStatus(var_30_12[iter_30_7], BattleData.NEGATIVE_CLEAR_WHEN_OPPO_ROUND_END, false, var_30_12[iter_30_7]._id, 0, Data.SkillMode.once)
			end

			arg_30_0._fortress._atkCount = 1
			arg_30_0._fortress._actionCount = 1

			arg_30_0:decPositiveStatus(arg_30_0._fortress, BattleData.POSITIVE_CLEAR_WHEN_ROUND_END, false, arg_30_0._fortress._id, 0, Data.SkillMode.once)
			arg_30_0:decNegativeStatus(arg_30_0._fortress, BattleData.NEGATIVE_CLEAR_WHEN_ROUND_END, false, arg_30_0._fortress._id, 0, Data.SkillMode.once)

			local var_30_13 = arg_30_0:getBattleCardsBySkillFast("H", 9572)

			for iter_30_8 = 1, #var_30_13 do
				var_30_13[iter_30_8]:removeSkillById(9572)
			end

			local var_30_14 = arg_30_0:getBattleCardsBySkillFast("H", 9784)

			for iter_30_9 = 1, #var_30_14 do
				var_30_14[iter_30_9]:removeSkillById(9784)
			end

			local var_30_15 = arg_30_0:getBattleCardsBySkillFast("B", 9783)

			for iter_30_10 = 1, #var_30_15 do
				var_30_15[iter_30_10]:removeSkillById(9783)
			end

			local var_30_16 = arg_30_0:getBattleCardsBySkillFast("G", 9840)

			for iter_30_11 = 1, #var_30_16 do
				var_30_16[iter_30_11]:removeSkillById(9840)
			end

			local var_30_17 = arg_30_0:getBattleCardsBySkillFast("B", 13677)

			for iter_30_12 = 1, #var_30_17 do
				var_30_17[iter_30_12]:removeSkillById(13677)
			end

			local var_30_18 = arg_30_0:getBattleCardsBySkillFast("H", 14068)

			for iter_30_13 = 1, #var_30_18 do
				var_30_18[iter_30_13]:removeSkillById(14068)
			end

			arg_30_0:account()
			arg_30_0:removeDeadCards()
		elseif arg_30_0._fortress:hasBuff(false, BattleData.NegativeType.boardLock) then
			arg_30_0:resetAccount()

			arg_30_0._fortress._actionCount = 1

			arg_30_0:decNegativeStatus(arg_30_0._fortress, {
				BattleData.NegativeType.boardLock
			}, false, arg_30_0._fortress._id, 0, Data.SkillMode.once)
			arg_30_0:account()
		end

		if not arg_30_0._isReviewing then
			return arg_30_0:sendEvent(BattleData.Status.round_end)
		end
	end

	if arg_30_0:checkFinish() then
		arg_30_0._stepStatus = BattleData.Status.before_account_finish

		return arg_30_0:step()
	end

	if not arg_30_0._haloDone then
		arg_30_0._haloDone = true
		arg_30_0._stepStatus = BattleData.Status.before_account_halo

		return arg_30_0:step()
	end

	if next(arg_30_0._cardStatusToChange) ~= nil then
		arg_30_0._stepStatus = BattleData.Status.before_account_status

		return arg_30_0:step()
	end

	if not arg_30_0._eventDone then
		arg_30_0._eventDone = true

		local var_30_19 = BattleEvent.EventType.round_end
		local var_30_20 = arg_30_0:getEvents(var_30_19)

		for iter_30_14, iter_30_15 in ipairs(var_30_20) do
			arg_30_0:changeEvent(iter_30_15, var_30_19)
		end
	end

	if next(arg_30_0._eventToChange) ~= nil then
		arg_30_0._stepStatus = BattleData.Status.before_account_event

		return arg_30_0:step()
	end

	if not arg_30_0._fortressSkillDone and arg_30_0._fortressSkill ~= nil then
		arg_30_0._fortressSkillDone = true
		arg_30_0._actionCard = arg_30_0:getGhostCard()

		arg_30_0:resetActionCard()
		arg_30_0:resetAccount()

		arg_30_0._spellType = Data.SkillMode.round_end
		arg_30_0._stepStatus = BattleData.Status.before_account_spell

		return arg_30_0:step()
	end

	local var_30_21 = arg_30_0._cardInAction

	if var_30_21 == nil then
		local var_30_22 = B.mergeTable({
			arg_30_0:getBattleCards("BSD"),
			arg_30_0._opponent:getBattleCards("BSD")
		})

		for iter_30_16 = 1, #var_30_22 do
			local var_30_23 = var_30_22[iter_30_16]

			if B.isAlive(var_30_23) and var_30_23._actionIndex <= var_30_23._actionCount then
				var_30_21 = var_30_23

				break
			end
		end

		if var_30_21 == nil then
			for iter_30_17 = 1, #arg_30_0._delaySkillCards do
				local var_30_24 = arg_30_0._delaySkillCards[iter_30_17]

				if var_30_24:hasSkillInMode(Data.SkillMode.round_end) and var_30_24._actionIndex <= var_30_24._actionCount then
					var_30_21 = var_30_24

					table.remove(arg_30_0._delaySkillCards, iter_30_17)

					break
				end
			end
		end

		if var_30_21 == nil then
			for iter_30_18 = 1, #arg_30_0._opponent._delaySkillCards do
				local var_30_25 = arg_30_0._opponent._delaySkillCards[iter_30_18]

				if var_30_25:hasSkillInMode(Data.SkillMode.oppo_round_end) and var_30_25._actionIndex <= var_30_25._actionCount then
					var_30_21 = var_30_25

					table.remove(arg_30_0._opponent._delaySkillCards, iter_30_18)

					break
				end
			end
		end
	end

	if var_30_21 ~= nil then
		if var_30_21._actionIndex <= var_30_21._actionCount then
			arg_30_0._cardInAction = var_30_21
			arg_30_0._actionCard = var_30_21
			arg_30_0._spellType = var_30_21._owner == arg_30_0 and Data.SkillMode.round_end or Data.SkillMode.oppo_round_end
			arg_30_0._stepStatus = BattleData.Status.before_account_spell
			var_30_21._actionIndex = var_30_21._actionIndex + 1

			return arg_30_0:step()
		else
			arg_30_0._cardInAction = nil
			arg_30_0._actionCard = nil
			arg_30_0._stepStatus = BattleData.Status.round_end

			return arg_30_0:step()
		end
	end

	arg_30_0._cardInAction = nil

	arg_30_0:battleLog("----------------------------------------------------------------\n\n")

	arg_30_0._opponent._stepStatus = not arg_30_0._opponent._isInitialDealed and arg_30_0._opponent._round == 0 and BattleData.Status.initial_deal or BattleData.Status.round_begin
	arg_30_0._stepStatus = BattleData.Status.wait_opponent

	return arg_30_0._opponent:step()
end

function var_0_0.drop(arg_31_0)
	if arg_31_0._macroStatus ~= BattleData.Status.drop then
		arg_31_0:battleLog("")
		arg_31_0:battleLog("[BATTLE] <DROP>")

		arg_31_0._macroStatus = BattleData.Status.drop
		arg_31_0._normalStatus = BattleData.Status.default

		if arg_31_0:getIsNeedDrop() then
			for iter_31_0 = 1, #arg_31_0._handCards - Data.MAX_CARD_COUNT_IN_HAND_AFTER_DROP do
				arg_31_0:changeCardStatus(arg_31_0._handCards[iter_31_0], BattleData.CardStatus.hand, BattleData.CardStatus.grave, BattleData.CardStatusVal.h2g_drop)
			end
		end

		if not arg_31_0._isReviewing then
			return arg_31_0:sendEvent(BattleData.Status.drop)
		end
	end

	if next(arg_31_0._cardStatusToChange) ~= nil then
		arg_31_0._stepStatus = BattleData.Status.before_account_status

		return arg_31_0:step()
	end

	arg_31_0:battleLog("----------------------------------------------------------------\n\n")

	arg_31_0._opponent._stepStatus = not arg_31_0._opponent._isInitialDealed and arg_31_0._opponent._round == 0 and BattleData.Status.initial_deal or BattleData.Status.round_begin
	arg_31_0._stepStatus = BattleData.Status.wait_opponent

	return arg_31_0._opponent:step()
end

function var_0_0.beforeAccountStatus(arg_32_0)
	local var_32_0 = arg_32_0._cardStatusToChange[1]

	table.remove(arg_32_0._cardStatusToChange, 1)

	if not var_32_0 or not var_32_0._card then
		arg_32_0._stepStatus = BattleData.Status.account_status
		arg_32_0._normalStatus = BattleData.Status.default
		return arg_32_0:step()
	end

	local var_32_1 = var_32_0._card

	var_32_1._sourceStatus = var_32_0._sourceStatus
	var_32_1._destStatus = var_32_0._destStatus
	var_32_1._statusVal = var_32_0._statusVal
	var_32_1._triggerCard = var_32_0._triggerCard

	arg_32_0:saveStatus()

	arg_32_0._actionCard = var_32_1

	arg_32_0:resetActionCard()

	if var_32_1._sourceStatus ~= var_32_1._status then
		arg_32_0._stepStatus = BattleData.Status.after_account_status

		return arg_32_0:step()
	end

	arg_32_0._stepStatus = BattleData.Status.account_status
	arg_32_0._normalStatus = BattleData.Status.default

	return arg_32_0:step()
end

function var_0_0.afterAccountStatus(arg_33_0)
	if arg_33_0._normalStatus ~= BattleData.Status.after_account_status then
		arg_33_0._normalStatus = BattleData.Status.after_account_status
		arg_33_0._eventDone = false
		arg_33_0._costSpellDone = false
		arg_33_0._beforeMagicTrapSpellDone = false
		arg_33_0._spellDone = false
		arg_33_0._trapDone = false

		local var_33_0 = arg_33_0._actionCard
		local var_33_1 = var_33_0._sourceStatus
		local var_33_2 = var_33_0._destStatus

		arg_33_0._haloDone = false

		if var_33_0:isMonsterRare() and (var_33_2 == BattleData.CardStatus.board or var_33_1 == BattleData.CardStatus.board or var_33_2 == BattleData.CardStatus.grave or var_33_1 == BattleData.CardStatus.grave) or (var_33_0._type == Data.CardType.magic or var_33_0._type == Data.CardType.trap) and (var_33_2 == BattleData.CardStatus.show or var_33_1 == BattleData.CardStatus.show or var_33_2 == BattleData.CardStatus.field or var_33_1 == BattleData.CardStatus.field or var_33_2 == BattleData.CardStatus.grave or var_33_1 == BattleData.CardStatus.grave) then
			arg_33_0._stepStatus = BattleData.Status.before_account_halo

			return arg_33_0:step()
		end
	end

	local var_33_3 = arg_33_0._actionCard

	if not arg_33_0._costSpellDone then
		arg_33_0._costSpellDone = true

		local var_33_4 = var_33_3._sourceStatus
		local var_33_5 = var_33_3._destStatus

		if var_33_3:isMonsterRare() then
			if var_33_4 ~= BattleData.CardStatus.board and var_33_5 == BattleData.CardStatus.board and var_33_3._statusVal ~= BattleData.CardStatusVal.g2b_5096 then
				arg_33_0._spellType = Data.SkillMode.cost
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			end
		elseif var_33_3._type == Data.CardType.trap and var_33_4 == BattleData.CardStatus.hand and var_33_5 == BattleData.CardStatus.cover then
			arg_33_0._spellType = Data.SkillMode.cost
			arg_33_0._stepStatus = BattleData.Status.before_account_spell

			return arg_33_0:step()
		end
	end

	if not arg_33_0._beforeMagicTrapSpellDone then
		arg_33_0._beforeMagicTrapSpellDone = true

		local var_33_6 = var_33_3._sourceStatus
		local var_33_7 = var_33_3._destStatus

		if B.isMagicCasting(var_33_3) or B.isTrapTriggering(var_33_3) then
			arg_33_0._spellType = Data.SkillMode.before_magic_trap
			arg_33_0._stepStatus = BattleData.Status.before_account_spell

			return arg_33_0:step()
		end
	end

	if not arg_33_0._trapDone then
		arg_33_0._trapDone = true
		arg_33_0._stepStatus = BattleData.Status.before_account_trap

		return arg_33_0:step()
	end

	if not arg_33_0._spellDone then
		arg_33_0._spellDone = true

		local var_33_8 = var_33_3._sourceStatus
		local var_33_9 = var_33_3._destStatus
		local var_33_10 = var_33_3._triggerCard

		if var_33_3:isMonsterRare() then
			if var_33_8 == BattleData.CardStatus.grave and var_33_9 == BattleData.CardStatus.board and var_33_3._statusVal ~= BattleData.CardStatusVal.g2b_5096 then
				arg_33_0._spellType = Data.SkillMode.g2b
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 ~= BattleData.CardStatus.board and var_33_9 == BattleData.CardStatus.board and var_33_3._statusVal ~= BattleData.CardStatusVal.g2b_5096 or var_33_3._statusVal == BattleData.CardStatusVal.b2b_oppo_forever_using then
				arg_33_0._spellType = Data.SkillMode.using
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.board and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave or var_33_3._statusVal == BattleData.CardStatusVal.b2g_kill_by_attack) and var_33_3._statusVal ~= BattleData.CardStatusVal.h2l_temp and var_33_3._statusVal ~= BattleData.CardStatusVal.x2l_temp_oppo and not var_33_3:isStatusValCost() then
				arg_33_0._spellType = not var_33_3:isStatusValSacrifice() and Data.SkillMode.bcs2gl or Data.SkillMode.sacrifice
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.board and var_33_9 ~= BattleData.CardStatus.board and var_33_3._statusVal ~= BattleData.CardStatusVal.h2l_temp and var_33_3._statusVal ~= BattleData.CardStatusVal.x2l_temp_oppo and not var_33_3:isStatusValCost() then
				arg_33_0._spellType = Data.SkillMode.bcs2_
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.board and var_33_9 == BattleData.CardStatus.board and (var_33_3._statusVal == BattleData.CardStatusVal.b2b_oppo_forever or var_33_3._statusVal == BattleData.CardStatusVal.b2b_oppo_forever_using or var_33_3._statusVal == BattleData.CardStatusVal.b2b_oppo_once) then
				arg_33_0._spellType = Data.SkillMode.b2b_oppo
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.hand and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) and var_33_3._statusVal ~= BattleData.CardStatusVal.b2g_sacrifice and var_33_3._statusVal ~= BattleData.CardStatusVal.h2g_drop and not var_33_3:isStatusValCost() then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.h2gl_by_oppo or Data.SkillMode.h2gl_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.hand and var_33_9 == BattleData.CardStatus.pile and not var_33_3:isStatusValCost() then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.h2p_by_oppo or Data.SkillMode.h2p_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.hand and var_33_9 == BattleData.CardStatus.hand and var_33_3._statusVal == BattleData.CardStatusVal.h2h_oppo then
				arg_33_0._spellType = Data.SkillMode.h2h
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.pile and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) and not var_33_3:isStatusValCost() then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.p2gl_by_oppo or Data.SkillMode.p2gl_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.rare and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.r2gl_by_oppo or Data.SkillMode.r2gl_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.grave and var_33_9 == BattleData.CardStatus.leave then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.g2l_by_oppo or Data.SkillMode.g2l_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.grave and var_33_9 == BattleData.CardStatus.hand then
				arg_33_0._spellType = Data.SkillMode.g2h
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.grave and var_33_9 == BattleData.CardStatus.pile then
				arg_33_0._spellType = Data.SkillMode.g2p
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.grave and var_33_9 == BattleData.CardStatus.rare then
				arg_33_0._spellType = Data.SkillMode.g2r
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 ~= BattleData.CardStatus.hand and var_33_9 == BattleData.CardStatus.hand and arg_33_0._round > 0 and (arg_33_0._battleType ~= Data.BattleType.PVP_room or arg_33_0._round ~= 1) then
				arg_33_0._spellType = Data.SkillMode._2h
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.grave and var_33_9 ~= BattleData.CardStatus.grave then
				arg_33_0._spellType = Data.SkillMode.g2notbh
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_3._statusVal == BattleData.CardStatusVal.h2l_temp or var_33_3._statusVal == BattleData.CardStatusVal.x2l_temp_oppo then
				arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.h2l_temp_by_oppo or Data.SkillMode.h2l_temp_by_self
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			end
		elseif var_33_3._type == Data.CardType.magic then
			if var_33_8 == BattleData.CardStatus.hand and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) and var_33_3._statusVal == BattleData.CardStatusVal.h2g_magic or var_33_9 == BattleData.CardStatus.show or var_33_9 == BattleData.CardStatus.field then
				var_33_3._owner._totalCastedMagicCount = var_33_3._owner._totalCastedMagicCount + 1
				arg_33_0._spellType = Data.SkillMode.magic
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif (var_33_8 == BattleData.CardStatus.show or var_33_8 == BattleData.CardStatus.field) and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) and not var_33_3:isStatusValSacrifice() and var_33_3._statusVal ~= BattleData.CardStatusVal.d2g_replace and not var_33_3:isStatusValCost() then
				arg_33_0._spellType = Data.SkillMode.bcs2gl
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif (var_33_8 == BattleData.CardStatus.show or var_33_8 == BattleData.CardStatus.field) and var_33_9 ~= BattleData.CardStatus.show and not var_33_3:isStatusValSacrifice() and var_33_3._statusVal ~= BattleData.CardStatusVal.d2g_replace and (not var_33_3:isStatusValCost() or var_33_3:isAlterMagic() or var_33_3._infoId == 20103) then
				arg_33_0._spellType = Data.SkillMode.bcs2_
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.hand and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) and var_33_3._statusVal ~= BattleData.CardStatusVal.h2g_magic and not var_33_3:isStatusValCost() then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.h2gl_by_oppo or Data.SkillMode.h2gl_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.hand and var_33_9 == BattleData.CardStatus.pile and not var_33_3:isStatusValCost() then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.h2p_by_oppo or Data.SkillMode.h2p_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.hand and var_33_9 == BattleData.CardStatus.hand and var_33_3._statusVal == BattleData.CardStatusVal.h2h_oppo then
				arg_33_0._spellType = Data.SkillMode.h2h
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.pile and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) and not var_33_3:isStatusValCost() then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.p2gl_by_oppo or Data.SkillMode.p2gl_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.grave and var_33_9 == BattleData.CardStatus.hand then
				arg_33_0._spellType = Data.SkillMode.g2h
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 ~= BattleData.CardStatus.hand and var_33_9 == BattleData.CardStatus.hand and arg_33_0._round > 0 and (arg_33_0._battleType ~= Data.BattleType.PVP_room or arg_33_0._round ~= 1) then
				arg_33_0._spellType = Data.SkillMode._2h
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.grave and var_33_9 == BattleData.CardStatus.pile then
				arg_33_0._spellType = Data.SkillMode.g2p
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			end
		elseif var_33_3._type == Data.CardType.trap then
			if var_33_8 == BattleData.CardStatus.cover and var_33_9 == BattleData.CardStatus.show or var_33_8 == BattleData.CardStatus.hand and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) and var_33_3._statusVal == BattleData.CardStatusVal.h2g_trap then
				var_33_3._owner._totalCastedTrapCount = var_33_3._owner._totalCastedTrapCount + 1
				arg_33_0._spellType = Data.SkillMode.trap
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 ~= BattleData.CardStatus.cover and var_33_9 == BattleData.CardStatus.cover then
				arg_33_0._spellType = Data.SkillMode.using
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif (var_33_8 == BattleData.CardStatus.cover or var_33_8 == BattleData.CardStatus.show) and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) and not var_33_3:isStatusValSacrifice() and not var_33_3:isStatusValCost() then
				arg_33_0._spellType = Data.SkillMode.bcs2gl
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif (var_33_8 == BattleData.CardStatus.cover or var_33_8 == BattleData.CardStatus.show) and var_33_9 ~= BattleData.CardStatus.cover and var_33_9 ~= BattleData.CardStatus.show and not var_33_3:isStatusValSacrifice() and not var_33_3:isStatusValCost() then
				arg_33_0._spellType = Data.SkillMode.bcs2_
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.hand and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) and var_33_3._statusVal ~= BattleData.CardStatusVal.h2g_trap and not var_33_3:isStatusValCost() then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.h2gl_by_oppo or Data.SkillMode.h2gl_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.hand and var_33_9 == BattleData.CardStatus.pile and not var_33_3:isStatusValCost() then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.h2p_by_oppo or Data.SkillMode.h2p_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.hand and var_33_9 == BattleData.CardStatus.hand and var_33_3._statusVal == BattleData.CardStatusVal.h2h_oppo then
				arg_33_0._spellType = Data.SkillMode.h2h
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.pile and (var_33_9 == BattleData.CardStatus.grave or var_33_9 == BattleData.CardStatus.leave) and not var_33_3:isStatusValCost() then
				if var_33_10 ~= nil then
					arg_33_0._spellType = var_33_3:isTriggerByOppo() and Data.SkillMode.p2gl_by_oppo or Data.SkillMode.p2gl_by_self
					arg_33_0._stepStatus = BattleData.Status.before_account_spell

					return arg_33_0:step()
				end
			elseif var_33_8 == BattleData.CardStatus.grave and var_33_9 == BattleData.CardStatus.hand then
				arg_33_0._spellType = Data.SkillMode.g2h
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 ~= BattleData.CardStatus.hand and var_33_9 == BattleData.CardStatus.hand and arg_33_0._round > 0 and (arg_33_0._battleType ~= Data.BattleType.PVP_room or arg_33_0._round ~= 1) then
				arg_33_0._spellType = Data.SkillMode._2h
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_8 == BattleData.CardStatus.grave and var_33_9 == BattleData.CardStatus.pile then
				arg_33_0._spellType = Data.SkillMode.g2p
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			end
		elseif var_33_3._type == Data.CardType.fortress then
			if var_33_3._statusVal == BattleData.CardStatusVal.f2f_fortress_damaged then
				arg_33_0._spellType = Data.SkillMode.fortress_damaged
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			elseif var_33_3._statusVal == BattleData.CardStatusVal.f2f_halo then
				arg_33_0._haloDone = false
			elseif var_33_3._statusVal == BattleData.CardStatusVal.f2f_fortress_hp_added then
				arg_33_0._spellType = Data.SkillMode.fortress_hp_added
				arg_33_0._stepStatus = BattleData.Status.before_account_spell

				return arg_33_0:step()
			end
		end
	end

	if not arg_33_0._haloDone then
		arg_33_0._haloDone = true
		arg_33_0._stepStatus = BattleData.Status.before_account_halo

		return arg_33_0:step()
	end

	if not arg_33_0._eventDone then
		arg_33_0._eventDone = true

		local var_33_11 = BattleEvent.EventType.after_status_change

		if var_33_11 ~= nil then
			local var_33_12 = arg_33_0:getEvents(var_33_11)

			for iter_33_0, iter_33_1 in ipairs(var_33_12) do
				arg_33_0:changeEvent(iter_33_1, var_33_11)
			end
		end
	end

	if next(arg_33_0._eventToChange) ~= nil then
		arg_33_0._stepStatus = BattleData.Status.before_account_event

		return arg_33_0:step()
	end

	var_33_3._sourceStatus, var_33_3._destStatus, var_33_3._statusVal, var_33_3._triggerCard = nil
	arg_33_0._normalStatus = BattleData.Status.default

	return arg_33_0:loadStatus()
end

function var_0_0.beforeAccountHalo(arg_34_0)
	arg_34_0:saveStatus()

	local var_34_0 = arg_34_0._actionCard

	if var_34_0 == nil then
		var_34_0 = nil

		for iter_34_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD * 2 do
			local var_34_1 = iter_34_0 <= Data.MAX_CARD_COUNT_ON_BOARD and arg_34_0._boardCards[iter_34_0] or arg_34_0._opponent._boardCards[iter_34_0 - Data.MAX_CARD_COUNT_ON_BOARD]

			if B.isAlive(var_34_1) then
				var_34_0 = var_34_1

				break
			end
		end
	end

	if var_34_0 == nil then
		arg_34_0._stepStatus = BattleData.Status.after_account_halo

		return arg_34_0:step()
	end

	arg_34_0._actionCard = var_34_0

	arg_34_0:resetActionCard()

	arg_34_0._normalStatus = BattleData.Status.default
	arg_34_0._stepStatus = BattleData.Status.account_halo

	return arg_34_0:step()
end

function var_0_0.afterAccountHalo(arg_35_0)
	arg_35_0._normalStatus = BattleData.Status.default

	return arg_35_0:loadStatus()
end

function var_0_0.beforeAccountSpell(arg_36_0)
	arg_36_0:saveStatus()
	arg_36_0:resetActionCard()

	arg_36_0._spellIndex = 0
	arg_36_0._spellCountIndex = 0
	arg_36_0._stepStatus = BattleData.Status.spelling
	arg_36_0._normalStatus = BattleData.Status.default

	return arg_36_0:step()
end

function var_0_0.afterAccountSpell(arg_37_0)
	arg_37_0._normalStatus = BattleData.Status.default

	return arg_37_0:loadStatus()
end

function var_0_0.beforeAccountAttack(arg_38_0)
	arg_38_0:saveStatus()
	arg_38_0:resetActionCard()

	arg_38_0._attackIndex = 0
	arg_38_0._trapWhenAttackState = 0
	arg_38_0._actionCard._dieCountBeforeAttack = arg_38_0._actionCard._dieCount
	arg_38_0._normalStatus = BattleData.Status.default
	arg_38_0._stepStatus = BattleData.Status.before_attack

	arg_38_0:step()
end

function var_0_0.afterAccountAttack(arg_39_0)
	arg_39_0._normalStatus = BattleData.Status.default
	arg_39_0._roundAttackIndex = arg_39_0._roundAttackIndex + 1

	if not arg_39_0._isReviewing and arg_39_0._opponent:hasBattleCardsByCanCastMonsterSkillFast("B", 9444) then
		arg_39_0:sendEvent(BattleData.Status.after_account_attack)
	end

	return arg_39_0:loadStatus()
end

function var_0_0.beforeAccountEvent(arg_40_0)
	local var_40_0 = arg_40_0._eventToChange[1]

	table.remove(arg_40_0._eventToChange, 1)

	local var_40_1 = var_40_0._event
	local var_40_2 = var_40_0._type

	arg_40_0:saveStatus()

	if not var_40_1._owner:getIsEventSatisfied(var_40_1) then
		arg_40_0._stepStatus = BattleData.Status.after_account_event

		return arg_40_0:step()
	end

	arg_40_0._actionEvent = var_40_1

	if arg_40_0._actionCard == nil then
		arg_40_0._actionCard = arg_40_0._cards[1] or arg_40_0._opponent._cards[1] or arg_40_0:getGhostCard()
	end

	arg_40_0:resetActionCard()

	arg_40_0._normalStatus = BattleData.Status.default
	arg_40_0._stepStatus = BattleData.Status.account_event

	return arg_40_0:step()
end

function var_0_0.afterAccountEvent(arg_41_0)
	arg_41_0._normalStatus = BattleData.Status.default

	return arg_41_0:loadStatus()
end

function var_0_0.beforeAccountFinish(arg_42_0)
	arg_42_0:saveStatus()

	arg_42_0._normalStatus = BattleData.Status.default
	arg_42_0._stepStatus = BattleData.Status.account_finish

	return arg_42_0:step()
end

function var_0_0.afterAccountFinish(arg_43_0)
	arg_43_0._normalStatus = BattleData.Status.default

	if arg_43_0:checkFinish() then
		arg_43_0._saved = {}
		arg_43_0._stepStatus = BattleData.Status.battle_end

		return arg_43_0:step()
	else
		return arg_43_0:loadStatus()
	end
end

function var_0_0.beforeAccountTrap(arg_44_0)
	arg_44_0:saveStatus()
	arg_44_0:resetActionCard()

	arg_44_0._stepStatus = BattleData.Status.account_trap
	arg_44_0._normalStatus = BattleData.Status.default

	return arg_44_0:step()
end

function var_0_0.afterAccountTrap(arg_45_0)
	arg_45_0._normalStatus = BattleData.Status.default

	return arg_45_0:loadStatus()
end

function var_0_0.beforeAccountTrapWhenAttack(arg_46_0)
	arg_46_0:saveStatus()
	arg_46_0:resetActionCard()

	arg_46_0._stepStatus = BattleData.Status.account_trap_when_attack
	arg_46_0._normalStatus = BattleData.Status.default

	return arg_46_0:step()
end

function var_0_0.afterAccountTrapWhenAttack(arg_47_0)
	arg_47_0._normalStatus = BattleData.Status.default

	return arg_47_0:loadStatus()
end

function var_0_0.tryUseCard(arg_48_0)
	if arg_48_0._isPaused then
		return
	end

	if arg_48_0._normalStatus ~= BattleData.Status.try_use_card then
		arg_48_0._normalStatus = BattleData.Status.try_use_card

		local var_48_0 = BattleEvent.EventType.try_use_card
		local var_48_1 = arg_48_0:getEvents(var_48_0)

		for iter_48_0, iter_48_1 in ipairs(var_48_1) do
			arg_48_0:changeEvent(iter_48_1, var_48_0)
		end
	end

	if next(arg_48_0._eventToChange) ~= nil then
		arg_48_0._stepStatus = BattleData.Status.before_account_event

		return arg_48_0:step()
	end

	arg_48_0._normalStatus = BattleData.Status.default

	return arg_48_0:sendEvent(BattleData.Status.try_use_card)
end

function var_0_0.doUseCard(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	if arg_49_0._isPaused then
		return
	end

	if arg_49_0._normalStatus ~= BattleData.Status.do_use_card then
		arg_49_0._normalStatus = BattleData.Status.do_use_card
		arg_49_0._cardToTryUse = {
			_card = arg_49_1,
			_target = arg_49_2,
			_choice = arg_49_3,
			_extra = arg_49_4
		}

		local var_49_0 = BattleEvent.EventType.do_use_card
		local var_49_1 = arg_49_0:getEvents(var_49_0)

		for iter_49_0, iter_49_1 in ipairs(var_49_1) do
			arg_49_0:changeEvent(iter_49_1, var_49_0)
		end
	end

	if next(arg_49_0._eventToChange) ~= nil then
		arg_49_0._stepStatus = BattleData.Status.before_account_event

		return arg_49_0:step()
	end

	arg_49_0._normalStatus = BattleData.Status.default

	local var_49_2 = arg_49_0._cardToTryUse._card
	local var_49_3 = arg_49_0._cardToTryUse._target
	local var_49_4 = arg_49_0._cardToTryUse._choice
	local var_49_5 = arg_49_0._cardToTryUse._extra

	arg_49_0._cardToTryUse = {}

	if var_49_2 ~= nil then
		return arg_49_0:useCard(var_49_2, var_49_3, var_49_4, var_49_5)
	else
		return arg_49_0:startAction()
	end
end

function var_0_0.waitOppoUseCard(arg_50_0)
	return arg_50_0:sendEvent(BattleData.Status.wait_oppo_use_card)
end

function var_0_0.waitObserveUseCard(arg_51_0)
	return arg_51_0:sendEvent(BattleData.Status.wait_observe_use_card)
end

function var_0_0.useCard(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4)
	arg_52_0._actionCard = arg_52_1

	arg_52_0:resetActionCard()
	arg_52_0:resetAccount()
	arg_52_0:battleLog("[BATTLE] <USE CARD> %d, %d, %d", arg_52_1 and arg_52_1._infoId or 0, arg_52_2 and arg_52_2._infoId or 0, arg_52_3 or 0)

	arg_52_0._roundUseCardCount = arg_52_0._roundUseCardCount + 1
	B._mark5370 = nil
	B._mark5524 = nil
	B._mark9936 = nil
	B._mark14133 = nil
	B._mark14304 = nil
	B._mark14353 = nil
	B._mark14357 = nil
	B._markPrevAtkTarget = nil

	local var_52_0 = arg_52_0:getBattleCards("BSGL")

	for iter_52_0 = 1, #var_52_0 do
		var_52_0[iter_52_0]:resetCardWhenUse()
	end

	local var_52_1 = arg_52_0._opponent:getBattleCards("BSGL")

	for iter_52_1 = 1, #var_52_1 do
		var_52_1[iter_52_1]:resetCardWhenUse()
	end

	if (not arg_52_0._isClient or not GuideManager.isGuideEnabled() and arg_52_0._playerType == BattleData.PlayerType.replay) and not arg_52_0:checkOpInfoId(arg_52_1) then
		arg_52_0._isCheating = true

		return arg_52_0:retreat()
	end

	if arg_52_0._battleType == Data.BattleType.unittest then
		local var_52_2 = arg_52_0._isAttacker and BattleTestData._playerUsedCards or BattleTestData._opponentUsedCards
		local var_52_3 = arg_52_2 and arg_52_2._id or 0

		if arg_52_4 ~= nil then
			var_52_3 = var_52_3 + B.tableCount(arg_52_4) * 10000
		end

		var_52_2[#var_52_2 + 1] = arg_52_1 and arg_52_1._id or 0
		var_52_2[#var_52_2 + 1] = var_52_3
		var_52_2[#var_52_2 + 1] = arg_52_3 or 0

		if arg_52_4 ~= nil then
			for iter_52_2, iter_52_3 in pairs(arg_52_4) do
				var_52_2[#var_52_2 + 1] = iter_52_2
				var_52_2[#var_52_2 + 1] = #iter_52_3

				for iter_52_4 = 1, #iter_52_3 do
					var_52_2[#var_52_2 + 1] = iter_52_3[iter_52_4]
				end
			end
		end
	end

	arg_52_0._useCardTarget = arg_52_2
	arg_52_1._choice = arg_52_3
	arg_52_1._extra = arg_52_4

	local var_52_4 = BattleData.Status.before_account_status

	if arg_52_1._status == BattleData.CardStatus.hand then
		if arg_52_2 ~= nil then
			if arg_52_1._type == Data.CardType.monster then
				arg_52_1._saved._monsterTarget = arg_52_2
			elseif arg_52_1._type == Data.CardType.magic then
				arg_52_1._saved._magicTarget = arg_52_2
			elseif arg_52_1._type == Data.CardType.trap then
				arg_52_1._saved._trapTarget = arg_52_2
			end
		end

		local var_52_5 = arg_52_1._choice and math.floor(arg_52_1._choice / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0

		if var_52_5 > 0 and arg_52_1:hasSkillInMode(Data.SkillMode.initiative_hand) then
			arg_52_0._actionCard = arg_52_1

			local var_52_6 = arg_52_1._skills[var_52_5]

			arg_52_0._spellType = Data.SkillMode.initiative_hand
			var_52_4 = BattleData.Status.before_account_spell
		elseif arg_52_1._choice == BattleData.ChoiceId.drop then
			arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.grave, BattleData.CardStatusVal.h2g_drop)
		elseif arg_52_1._type == Data.CardType.magic then
			if arg_52_1:isFieldMagic() then
				arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.field)
			elseif arg_52_1._info._type == Data.MagicTrapType.once then
				arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.grave, BattleData.CardStatusVal.h2g_magic)
			else
				arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.show)
			end
		elseif arg_52_1._type == Data.CardType.trap then
			if arg_52_1._info._type == Data.MagicTrapType.once then
				arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.grave, BattleData.CardStatusVal.h2g_trap)
			else
				arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.cover)
			end
		else
			local var_52_7 = arg_52_3 % BattleData.ChoiceId.stage_size_1

			if not arg_52_3 or not (math.floor(arg_52_3 / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3) then
				local var_52_8 = 0
			end

			if var_52_7 == 3 then
				if (not arg_52_0._isClient or not GuideManager.isGuideEnabled() and arg_52_0._playerType == BattleData.PlayerType.replay or lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest) and not arg_52_0:canUseMonsterSpecific(arg_52_1) then
					if arg_52_0._isClient and lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest then
						arg_52_0:battleLog("[BATTLE] <CHEATING> canUseMonsterSpecific")
					end

					arg_52_0._isCheating = true

					return arg_52_0:retreat()
				end

				if arg_52_1:hasSkillFast(3919) then
					local var_52_9 = arg_52_3 and math.floor(arg_52_3 / BattleData.ChoiceId.stage_2) % BattleData.ChoiceId.stage_size_2 or 0
					local var_52_10 = arg_52_0:filterSacrificeCards(B.filterTokenCards(arg_52_0:getBoardCards(), false))

					for iter_52_5 = 1, #var_52_10 do
						local var_52_11 = var_52_10[iter_52_5]

						if band(2^(var_52_11._pos + (var_52_11._owner == arg_52_1._owner and 0 or Data.MAX_CARD_COUNT_ON_BOARD) - 1), var_52_9) ~= 0 then
							arg_52_0:changeCardStatus(var_52_11, BattleData.CardStatus.board, BattleData.CardStatus.grave, BattleData.CardStatusVal.b2g_sacrifice)
						end
					end
				elseif arg_52_1:hasSkillFast(6484) then
					local var_52_12 = arg_52_3 and math.floor(arg_52_3 / BattleData.ChoiceId.stage_2) % BattleData.ChoiceId.stage_size_2 or 0
					local var_52_13 = var_52_12 % BattleData.UseCardId.id_group
					local var_52_14 = math.floor(var_52_12 / BattleData.UseCardId.id_group) % BattleData.UseCardId.id_group
					local var_52_15 = arg_52_0:getCardById(var_52_13)
					local var_52_16 = arg_52_0:getCardById(var_52_14)

					if var_52_15 ~= nil and var_52_16 ~= nil then
						arg_52_0:changeCardStatus(var_52_15, BattleData.CardStatus.board, BattleData.CardStatus.leave, BattleData.CardStatusVal.b2g_sacrifice)
						arg_52_0:changeCardStatus(var_52_16, BattleData.CardStatus.board, BattleData.CardStatus.leave, BattleData.CardStatusVal.b2g_sacrifice)
					end
				elseif arg_52_1:hasSkillFast(6691) or arg_52_1:hasSkillFast(6692) then
					local var_52_17 = arg_52_3 and math.floor(arg_52_3 / BattleData.ChoiceId.stage_2) % BattleData.ChoiceId.stage_size_2 or 0
					local var_52_18 = arg_52_0:getBoardCards()

					for iter_52_6 = 1, #var_52_18 do
						local var_52_19 = var_52_18[iter_52_6]

						if band(var_52_17, 2^(var_52_19._pos - 1)) ~= 0 then
							arg_52_0:changeCardStatus(var_52_19, BattleData.CardStatus.board, BattleData.CardStatus.grave, not var_52_19:isToken() and BattleData.CardStatusVal.b2g_sacrifice or nil)
						end
					end
				end

				arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.board)
			elseif var_52_7 == 2 then
				if (not arg_52_0._isClient or not GuideManager.isGuideEnabled() and arg_52_0._playerType == BattleData.PlayerType.replay or lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest) and not arg_52_0:canUseMonsterSpecial(arg_52_1) then
					if arg_52_0._isClient and lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest then
						arg_52_0:battleLog("[BATTLE] <CHEATING> canUseMonsterSpecial")
					end

					arg_52_0._isCheating = true

					return arg_52_0:retreat()
				end

				local var_52_20
				local var_52_21

				for iter_52_7 = 1, #arg_52_0._gemUnderSkills do
					local var_52_22 = arg_52_0._gemUnderSkills[iter_52_7]

					if var_52_22._sid == 3144 then
						if arg_52_1:isKeyword(var_52_22._val) then
							var_52_20, var_52_21 = var_52_22, iter_52_7

							break
						end
					elseif var_52_22._sid == 3161 or var_52_22._sid == 4058 then
						if arg_52_1._info._category == var_52_22._val then
							var_52_20, var_52_21 = var_52_22, iter_52_7

							break
						end
					elseif var_52_22._sid == 3346 then
						if arg_52_1:isKeyword(var_52_22._val) then
							var_52_20, var_52_21 = var_52_22, iter_52_7

							break
						end
					elseif var_52_22._sid == 5061 then
						local var_52_23 = math.floor(var_52_22._val / 65536)
						local var_52_24 = var_52_22._val % 65536

						if arg_52_1._owner._round == var_52_23 and arg_52_1:isKeyword(var_52_24) then
							var_52_20, var_52_21 = var_52_22, iter_52_7

							break
						end
					elseif var_52_22._sid == 7172 and arg_52_1:isDual() and arg_52_1:getStar() <= Data._skillInfo[7172]._val[1] and #arg_52_0:getBoardCards() == 0 and #arg_52_0._opponent:getBoardCards() > 0 then
						var_52_20, var_52_21 = var_52_22, iter_52_7

						break
					end
				end

				if var_52_20 ~= nil then
					if var_52_20._count == 1 then
						table.remove(arg_52_0._gemUnderSkills, var_52_21)
					else
						var_52_20._count = var_52_20._count - 1
					end
				end

				if arg_52_1:hasSkills({
					6705
				}) then
					arg_52_1._sacrificedCards = nil

					arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.board, BattleData.CardStatusVal.h2b_normal)
				else
					arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.board)
				end
			else
				if (not arg_52_0._isClient or not GuideManager.isGuideEnabled() and arg_52_0._playerType == BattleData.PlayerType.replay or lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest) and (var_52_7 == 1 and not arg_52_0:canUseMonsterNormal(arg_52_1) or var_52_7 == 4 and not arg_52_0:canUseMonsterNormalToOppo(arg_52_1)) then
					if arg_52_0._isClient and lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest then
						arg_52_0:battleLog("[BATTLE] <CHEATING> canUseMonsterNormalToOppo")
					end

					arg_52_0._isCheating = true

					return arg_52_0:retreat()
				end

				if (not arg_52_0._isClient or not GuideManager.isGuideEnabled() and arg_52_0._playerType == BattleData.PlayerType.replay or lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest) and var_52_7 == 0 and arg_52_1._status == BattleData.CardStatus.hand and arg_52_1 == arg_52_2 then
					if arg_52_0._isClient and lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest then
						arg_52_0:battleLog("[BATTLE] <CHEATING> change posture on hand")
					end

					arg_52_0._isCheating = true

					return arg_52_0:retreat()
				end

				local var_52_25

				if var_52_7 == 5 then
					if arg_52_1:hasSkills({
						3572,
						6302
					}) then
						var_52_25 = -2
					elseif arg_52_1:hasSkills({
						3811
					}) then
						var_52_25 = -1
					end
				end

				local var_52_26 = math.max(0, arg_52_1:getSacrificeCount() + (var_52_25 or 0))

				arg_52_1._sacrificedCards = nil

				if var_52_26 > 0 then
					local var_52_27 = var_52_7 == 4 and arg_52_0._opponent:getSacrificedCards(arg_52_3) or arg_52_0:getSacrificedCards(arg_52_3)

					if (not arg_52_0._isClient or not GuideManager.isGuideEnabled() and arg_52_0._playerType == BattleData.PlayerType.replay or lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest) and not arg_52_0:checkSacrifice(arg_52_1, var_52_26, var_52_27) then
						if arg_52_0._isClient and lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest then
							arg_52_0:battleLog("[BATTLE] <CHEATING> checkSacrifice")
						end

						arg_52_0._isCheating = true

						return arg_52_0:retreat()
					end

					arg_52_1._sacrificedAtkFor3158 = 0
					arg_52_1._sacrificedCards = var_52_27

					local var_52_28 = false
					local var_52_29 = false
					local var_52_30 = arg_52_0:hasBattleCardsBySkillFast("D", 7251)

					for iter_52_8 = 1, #var_52_27 do
						if var_52_30 or var_52_27[iter_52_8]:hasSkills({
							6140
						}) then
							var_52_27[iter_52_8]._mark6140 = true
						else
							var_52_27[iter_52_8]._mark6140 = nil
						end

						if var_52_27[iter_52_8]:hasSkills({
							6197
						}) then
							var_52_28 = true
						end

						if var_52_27[iter_52_8]:hasSkills({
							6530
						}) then
							var_52_29 = true
						end

						var_52_27[iter_52_8]._summonSacrificedByCard = arg_52_1

						arg_52_0:changeCardStatus(var_52_27[iter_52_8], BattleData.CardStatus.board, BattleData.CardStatus.grave, BattleData.CardStatusVal.b2g_summon_sacrifice, var_52_7 == 4 and arg_52_1 or nil)

						arg_52_1._sacrificedAtkFor3158 = arg_52_1._sacrificedAtkFor3158 + var_52_27[iter_52_8]._info._atk[1]
					end

					local var_52_31 = {}

					if var_52_28 and arg_52_1:isKeyword(Data._skillInfo[6197]._refCards[1]) then
						var_52_31[#var_52_31 + 1] = Data._skillInfo[6197]._refSkills[1]
					end

					if var_52_29 then
						var_52_31[#var_52_31 + 1] = Data._skillInfo[6530]._refSkills[1]
					end

					if #var_52_31 > 0 then
						arg_52_1._saved._addSkills = var_52_31
					end
				end

				arg_52_1._saved._pos = B.getToBoardPos(arg_52_1._extra, arg_52_1._id)

				if var_52_7 == 4 then
					arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.board, BattleData.CardStatusVal.h2b_oppo_normal)
				else
					arg_52_0:changeCardStatus(arg_52_1, BattleData.CardStatus.hand, BattleData.CardStatus.board, BattleData.CardStatusVal.h2b_normal)
				end

				arg_52_1._mark3515 = nil
			end
		end
	elseif arg_52_1._type == Data.CardType.boss or arg_52_1._status == BattleData.CardStatus.board then
		local var_52_32 = arg_52_1._choice and math.floor(arg_52_1._choice / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0

		if var_52_32 > 0 then
			arg_52_0._actionCard = arg_52_1

			local var_52_33 = arg_52_1._skills[var_52_32]

			if (not arg_52_0._isClient or not GuideManager.isGuideEnabled() and arg_52_0._playerType == BattleData.PlayerType.replay or lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest) and not arg_52_0:canUseInitiativeSkill(arg_52_1, var_52_33) then
				if arg_52_0._isClient and lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest then
					arg_52_0:battleLog("[BATTLE] <CHEATING> canUseInitiativeSkill")
				end

				arg_52_0._isCheating = true

				return arg_52_0:retreat()
			end

			arg_52_0._spellType = Data.SkillMode.initiative_bcs
			var_52_4 = BattleData.Status.before_account_spell
		elseif arg_52_1 ~= arg_52_2 then
			if (not arg_52_0._isClient or not GuideManager.isGuideEnabled() and arg_52_0._playerType == BattleData.PlayerType.replay or lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest) and not arg_52_1:canAction() then
				if arg_52_0._isClient and lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and arg_52_0._battleType == Data.BattleType.unittest then
					arg_52_0:battleLog("[BATTLE] <CHEATING> canAction")
				end

				arg_52_0._isCheating = true

				return arg_52_0:retreat()
			end

			arg_52_0._actionCard = arg_52_1

			if not arg_52_1:hasCanCastMonsterSkillFast(6079) and not arg_52_1:hasCanCastMonsterSkillFast(1144) and not arg_52_1:isBindedSkill(7456) then
				arg_52_1._positiveStatus[BattleData.PositiveType.defendPosture] = false

				if arg_52_1:hasSkills({
					6166
				}) then
					arg_52_0:changeCardStatus(arg_52_1._owner._fortress, BattleData.CardStatus.fortress, BattleData.CardStatus.fortress, BattleData.CardStatusVal.f2f_halo)
				end
			end

			arg_52_0._isAnyMonsterActioned = true
			arg_52_1._actionIndex = arg_52_1._actionIndex + 1
			arg_52_1._atkCount = 1
			arg_52_1._atkTarget = arg_52_2
			var_52_4 = BattleData.Status.before_account_attack
		else
			arg_52_0._actionCard = arg_52_1
			arg_52_1._positiveStatus[BattleData.PositiveType.defendPosture] = not arg_52_1:hasBuff(true, BattleData.PositiveType.defendPosture)

			if arg_52_1:isBindedSkill(7027) or arg_52_1:hasSkillFast(6166) or arg_52_0:hasBattleCardsBySkillFast("B", 13770) then
				arg_52_0:changeCardStatus(arg_52_1._owner._fortress, BattleData.CardStatus.fortress, BattleData.CardStatus.fortress, BattleData.CardStatusVal.f2f_halo)
			end

			arg_52_0._isAnyMonsterActioned = true
			arg_52_1._actionIndex = arg_52_1._actionIndex + 1
			var_52_4 = BattleData.Status.use
		end
	elseif arg_52_1._status == BattleData.CardStatus.show or arg_52_1._status == BattleData.CardStatus.field or arg_52_1._status == BattleData.CardStatus.grave or arg_52_1._status == BattleData.CardStatus.rare or arg_52_1._status == BattleData.CardStatus.leave then
		local var_52_34 = arg_52_1._choice and math.floor(arg_52_1._choice / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0

		if var_52_34 > 0 then
			arg_52_0._actionCard = arg_52_1

			local var_52_35 = arg_52_1._skills[var_52_34]

			if B.skillHasMode(var_52_35, Data.SkillMode.initiative_grave) then
				arg_52_0._spellType = Data.SkillMode.initiative_grave
			elseif B.skillHasMode(var_52_35, Data.SkillMode.initiative_rare) then
				arg_52_0._spellType = Data.SkillMode.initiative_rare
			elseif B.skillHasMode(var_52_35, Data.SkillMode.initiative_leave) then
				arg_52_0._spellType = Data.SkillMode.initiative_leave
			else
				arg_52_0._spellType = Data.SkillMode.initiative_bcs
			end

			var_52_4 = BattleData.Status.before_account_spell
		end
	end

	arg_52_0._stepStatus = var_52_4

	if not arg_52_0._isReviewing and not arg_52_0._isSkipped then
		return arg_52_0:sendEvent(BattleData.Status.use_card)
	else
		return arg_52_0:step()
	end
end

function var_0_0.replayUseCard(arg_53_0)
	local var_53_0 = arg_53_0._ops[arg_53_0._replayIndex]
	local var_53_1 = arg_53_0._opponent._ops[arg_53_0._opponent._replayIndex]

	if var_53_1 ~= nil and var_53_1._card == BattleData.UseCardId.retreat and (var_53_0 == nil or var_53_0._card == BattleData.UseCardId.finish or math.abs(var_53_0._timestamp) > math.abs(var_53_1._timestamp)) then
		return nil, false, nil, nil, BattleData.UseCardId.retreat
	end

	if var_53_0 ~= nil then
		arg_53_0._replayIndex = arg_53_0._replayIndex + 1

		if var_53_0._card == BattleData.UseCardId.retreat then
			return nil, true, nil, nil, BattleData.UseCardId.retreat
		elseif var_53_0._card == BattleData.UseCardId.round then
			if var_53_0._target < arg_53_0._round then
				return arg_53_0:replayUseCard()
			end

			return nil, nil, nil, nil, BattleData.UseCardId.round
		elseif var_53_0._card == BattleData.UseCardId.finish then
			return nil, nil, nil, nil, BattleData.UseCardId.finish
		else
			local var_53_2 = arg_53_0:getCardById(var_53_0._card)
			local var_53_3 = var_53_0._target ~= BattleData.UseCardId.none and arg_53_0:getCardById(var_53_0._target) or nil

			var_53_2._opInfoId = var_53_0._cardInfoId

			return var_53_2, var_53_3, var_53_0._choice, var_53_0._extra, nil
		end
	else
		return nil, nil, nil, nil, nil
	end
end

function var_0_0.aiUseCard(arg_54_0)
	return arg_54_0._ai:useCard()
end

function var_0_0.aiDropCard(arg_55_0)
	return arg_55_0._ai:dropCard()
end

function var_0_0.startAction(arg_56_0)
	if arg_56_0._battleType == Data.BattleType.unittest and arg_56_0._round > 0 then
		local var_56_0 = arg_56_0._isAttacker and BattleTestData._playerUsedCards or BattleTestData._opponentUsedCards

		var_56_0[#var_56_0 + 1] = 1
		var_56_0[#var_56_0 + 1] = arg_56_0._round
		var_56_0[#var_56_0 + 1] = 0
	end

	arg_56_0._stepStatus = BattleData.Status.round_end

	if not arg_56_0._isReviewing then
		return arg_56_0:sendEvent(BattleData.Status.start_action)
	else
		return arg_56_0:step()
	end
end

function var_0_0.accountStatus(arg_57_0)
	if arg_57_0._normalStatus ~= BattleData.Status.account_status then
		B._lastAccount = BattleData.Status.account_status
		arg_57_0._normalStatus = BattleData.Status.account_status
		arg_57_0._eventDone = false
	end

	if not arg_57_0._eventDone then
		arg_57_0._eventDone = true

		local var_57_0 = BattleEvent.EventType.before_status_change

		if var_57_0 ~= nil then
			local var_57_1 = arg_57_0:getEvents(var_57_0)

			for iter_57_0, iter_57_1 in ipairs(var_57_1) do
				arg_57_0:changeEvent(iter_57_1, var_57_0)
			end
		end
	end

	if next(arg_57_0._eventToChange) ~= nil then
		arg_57_0._stepStatus = BattleData.Status.before_account_event

		return arg_57_0:step()
	end

	local var_57_2 = arg_57_0._actionCard
	local var_57_3 = {
		"L",
		"P",
		"H",
		"B",
		"G",
		"R",
		"",
		"",
		"C",
		"S",
		"F",
		"D"
	}

	arg_57_0:battleLog("[BATTLE] %s\t%s->%s%s", arg_57_0:cardName(var_57_2), var_57_3[var_57_2._sourceStatus], var_57_3[var_57_2._destStatus], var_57_2:statusValToStr())

	if var_57_2._type == Data.CardType.fortress and var_57_2._statusVal == BattleData.CardStatusVal.f2f_fortress_damaged and arg_57_0:checkFinish() then
		arg_57_0._stepStatus = BattleData.Status.before_account_finish

		return arg_57_0:step()
	end

	if var_57_2._sourceStatus == BattleData.CardStatus.board and (var_57_2._destStatus == BattleData.CardStatus.grave or var_57_2._destStatus == BattleData.CardStatus.leave) and not var_57_2:isStatusValSacrifice() then
		var_57_2:getOriginOwner()._opponent:addDestroyCardScore(var_57_2)
	end

	if var_57_2._sourceStatus == BattleData.CardStatus.pile then
		var_57_2._owner:removeCardFromPile(var_57_2)
	elseif var_57_2._sourceStatus == BattleData.CardStatus.hand then
		var_57_2._owner:removeCardFromHand(var_57_2)
	elseif var_57_2._sourceStatus == BattleData.CardStatus.board then
		var_57_2._owner:removeCardFromBoard(var_57_2)
	elseif var_57_2._sourceStatus == BattleData.CardStatus.grave then
		var_57_2._owner:removeCardFromGrave(var_57_2)
	elseif var_57_2._sourceStatus == BattleData.CardStatus.rare then
		var_57_2._owner:removeCardFromRare(var_57_2)
	elseif var_57_2._sourceStatus == BattleData.CardStatus.leave then
		var_57_2._owner:removeCardFromLeave(var_57_2)
	elseif var_57_2._sourceStatus == BattleData.CardStatus.cover then
		var_57_2._owner:removeCardFromCover(var_57_2)
	elseif var_57_2._sourceStatus == BattleData.CardStatus.show then
		var_57_2._owner:removeCardFromShow(var_57_2)
	elseif var_57_2._sourceStatus == BattleData.CardStatus.field then
		var_57_2._owner:removeCardFromField(var_57_2)
	end

	if var_57_2._destStatus == BattleData.CardStatus.pile then
		var_57_2._owner:addCardToPile(var_57_2)
	elseif var_57_2._destStatus == BattleData.CardStatus.hand then
		var_57_2._owner:addCardToHand(var_57_2)
	elseif var_57_2._destStatus == BattleData.CardStatus.board then
		var_57_2._owner:addCardToBoard(var_57_2)
	elseif var_57_2._destStatus == BattleData.CardStatus.grave then
		var_57_2._owner:addCardToGrave(var_57_2)
	elseif var_57_2._destStatus == BattleData.CardStatus.rare then
		var_57_2._owner:addCardToRare(var_57_2)
	elseif var_57_2._destStatus == BattleData.CardStatus.leave then
		var_57_2._owner:addCardToLeave(var_57_2)
	elseif var_57_2._destStatus == BattleData.CardStatus.cover then
		var_57_2._owner:addCardToCover(var_57_2)
	elseif var_57_2._destStatus == BattleData.CardStatus.show then
		var_57_2._owner:addCardToShow(var_57_2)
	elseif var_57_2._destStatus == BattleData.CardStatus.field then
		var_57_2._owner:addCardToField(var_57_2)
	end

	arg_57_0._stepStatus = BattleData.Status.after_account_status

	if not arg_57_0._isReviewing then
		return arg_57_0:sendEvent(BattleData.Status.account_status)
	else
		return arg_57_0:step()
	end
end

function var_0_0.accountHalo(arg_58_0)
	if B._lastAccount == BattleData.Status.account_halo then
		arg_58_0._stepStatus = BattleData.Status.after_account_halo

		return arg_58_0:step()
	end

	B._lastAccount = BattleData.Status.account_halo

	local var_58_0 = arg_58_0._actionCard
	local var_58_1 = B.mergeTable({
		arg_58_0:getBoardCards(),
		arg_58_0._opponent:getBoardCards(),
		arg_58_0:getBattleCards("CSD"),
		arg_58_0._opponent:getBattleCards("CSD")
	})

	B.appendTable(var_58_1, arg_58_0:getBattleCardsBySkillFast("G", 3979))
	B.appendTable(var_58_1, arg_58_0._opponent:getBattleCardsBySkillFast("G", 3979))
	B.appendTable(var_58_1, arg_58_0:getBattleCardsBySkillFast("G", 13558))
	B.appendTable(var_58_1, arg_58_0._opponent:getBattleCardsBySkillFast("G", 13558))

	for iter_58_0 = 1, #var_58_1 do
		local var_58_2 = var_58_1[iter_58_0]
		local var_58_3 = 1

		while var_58_2._underSkills[var_58_3] ~= nil do
			if var_58_2._underSkills[var_58_3]._mode == Data.SkillMode.halo then
				table.remove(var_58_2._underSkills, var_58_3)

				var_58_0._needAccount = true
			else
				var_58_3 = var_58_3 + 1
			end
		end

		if var_58_2._positiveSkills ~= nil then
			for iter_58_1 = 1, BattleData.PositiveType.count do
				local var_58_4 = 1

				while var_58_2._positiveSkills[iter_58_1][var_58_4] ~= nil do
					if var_58_2._positiveSkills[iter_58_1][var_58_4]._mode == Data.SkillMode.halo then
						table.remove(var_58_2._positiveSkills[iter_58_1], var_58_4)

						var_58_0._needAccount = true
					else
						var_58_4 = var_58_4 + 1
					end
				end
			end
		end

		if var_58_2._negativeSkills ~= nil then
			for iter_58_2 = 1, BattleData.NegativeType.count do
				local var_58_5 = 1

				while var_58_2._negativeSkills[iter_58_2][var_58_5] ~= nil do
					if var_58_2._negativeSkills[iter_58_2][var_58_5]._mode == Data.SkillMode.halo then
						table.remove(var_58_2._negativeSkills[iter_58_2], var_58_5)

						var_58_0._needAccount = true
					else
						var_58_5 = var_58_5 + 1
					end
				end
			end
		end
	end

	local var_58_6 = {}

	for iter_58_3 = 1, #var_58_1 do
		local var_58_7 = var_58_1[iter_58_3]

		if not var_58_7._negativeStatus[BattleData.NegativeType.haloSkillFrozen] then
			local var_58_8 = var_58_7:getSkillsByMode(Data.SkillMode.halo)

			if #var_58_8 > 0 then
				var_58_7._accountHaloSkills = var_58_8
				var_58_7._accountHaloIndex = 1
				var_58_6[#var_58_6 + 1] = var_58_7
			end
		end
	end

	local var_58_9 = 0
	local var_58_10 = 255

	while true do
		for iter_58_4 = 1, #var_58_6 do
			local var_58_11 = var_58_6[iter_58_4]

			while var_58_11._accountHaloIndex <= #var_58_11._accountHaloSkills do
				local var_58_12 = var_58_11._accountHaloSkills[var_58_11._accountHaloIndex]

				if var_58_9 < var_58_12._priority then
					if var_58_10 > var_58_12._priority then
						var_58_10 = var_58_12._priority
					end

					break
				end

				if var_58_12._priority == var_58_9 then
					var_58_11._owner:castSkill(var_58_11, var_58_12, Data.SkillMode.halo)
				end

				var_58_11._accountHaloIndex = var_58_11._accountHaloIndex + 1
			end
		end

		if var_58_10 == 255 then
			break
		end

		var_58_9 = var_58_10
		var_58_10 = 255
	end

	if var_58_0._needAccount then
		arg_58_0:account()
	end

	arg_58_0._stepStatus = BattleData.Status.after_account_halo

	if var_58_0._needAccount and not arg_58_0._isReviewing then
		return arg_58_0:sendEvent(BattleData.Status.account_halo)
	else
		return arg_58_0:step()
	end
end

function var_0_0.spelling(arg_59_0)
	local var_59_0 = arg_59_0._actionCard

	arg_59_0:resetActionCard()
	arg_59_0:resetAccount()

	arg_59_0._spellCountIndex = arg_59_0._spellCountIndex + 1

	local var_59_1 = var_59_0:getSkillByMode(arg_59_0._spellType, arg_59_0._spellIndex)

	if var_59_1 == nil or arg_59_0._spellCountIndex >= var_59_1._count then
		arg_59_0._spellIndex = arg_59_0._spellIndex + 1
		arg_59_0._spellCountIndex = 0
		var_59_1 = var_59_0:getSkillByMode(arg_59_0._spellType, arg_59_0._spellIndex)
	end

	while var_59_1 ~= nil and (arg_59_0._spellType == Data.SkillMode.bcs2gl or arg_59_0._spellType == Data.SkillMode.bcs2_) and var_59_0._dieByAttack and var_59_0._triggerCard ~= nil and var_59_1._owner == var_59_0 and (var_59_0._triggerCard:hasSkills({
		1030,
		1117
	}) or var_59_0._triggerCard:hasSkills({
		6064
	}) and var_59_0:isNature(Data._skillInfo[6064]._refCards[1])) do
		arg_59_0._spellIndex = arg_59_0._spellIndex + 1
		arg_59_0._spellCountIndex = 0
		var_59_1 = var_59_0:getSkillByMode(arg_59_0._spellType, arg_59_0._spellIndex)
	end

	local var_59_2 = true

	if var_59_1 == nil then
		var_59_2 = false
	end

	if var_59_2 and var_59_0:isMonsterRare() and arg_59_0._spellType ~= Data.SkillMode.bcs2gl and arg_59_0._spellType ~= Data.SkillMode.bcs2_ and arg_59_0._spellType ~= Data.SkillMode.sacrifice and arg_59_0._spellType ~= Data.SkillMode.round_begin and arg_59_0._spellType ~= Data.SkillMode.oppo_round_begin and arg_59_0._spellType ~= Data.SkillMode.round_end and arg_59_0._spellType ~= Data.SkillMode.oppo_round_end and arg_59_0._spellType ~= Data.SkillMode.after_attack and arg_59_0._spellType ~= Data.SkillMode.h2gl_by_self and arg_59_0._spellType ~= Data.SkillMode.h2gl_by_oppo and arg_59_0._spellType ~= Data.SkillMode.h2p_by_self and arg_59_0._spellType ~= Data.SkillMode.h2p_by_oppo and arg_59_0._spellType ~= Data.SkillMode.h2l_temp_by_self and arg_59_0._spellType ~= Data.SkillMode.h2l_temp_by_oppo and arg_59_0._spellType ~= Data.SkillMode.h2h and arg_59_0._spellType ~= Data.SkillMode.p2gl_by_self and arg_59_0._spellType ~= Data.SkillMode.p2gl_by_oppo and arg_59_0._spellType ~= Data.SkillMode.r2gl_by_self and arg_59_0._spellType ~= Data.SkillMode.r2gl_by_oppo and arg_59_0._spellType ~= Data.SkillMode.g2l_by_self and arg_59_0._spellType ~= Data.SkillMode.g2l_by_oppo and arg_59_0._spellType ~= Data.SkillMode.g2notbh and arg_59_0._spellType ~= Data.SkillMode.g2h and arg_59_0._spellType ~= Data.SkillMode.g2p and arg_59_0._spellType ~= Data.SkillMode.g2r and arg_59_0._spellType ~= Data.SkillMode._2h and arg_59_0._spellType ~= Data.SkillMode.initiative_grave and arg_59_0._spellType ~= Data.SkillMode.initiative_rare and arg_59_0._spellType ~= Data.SkillMode.initiative_hand and arg_59_0._spellType ~= Data.SkillMode.initiative_leave and not B.isAlive(var_59_0) then
		var_59_2 = false
	end

	if not var_59_2 then
		arg_59_0._stepStatus = BattleData.Status.after_account_spell

		return arg_59_0:step()
	end

	var_59_0._owner:castSkill(var_59_0, var_59_1, arg_59_0._spellType)

	if not var_59_0._needAccount then
		arg_59_0._stepStatus = BattleData.Status.end_spell

		return arg_59_0:step()
	else
		var_59_0._spellingSkill = var_59_1
		arg_59_0._stepStatus = (Data._skillInfo[var_59_1._id]._isIgnoreDefend == 1 or Data._skillInfo[var_59_1._id]._isIgnoreDefend == 9) and BattleData.Status.account_spell or BattleData.Status.under_spell_damage

		if not arg_59_0._isReviewing then
			return arg_59_0:sendEvent(BattleData.Status.spelling)
		else
			return arg_59_0:step()
		end
	end
end

function var_0_0.underSpellDamage(arg_60_0)
	local var_60_0 = arg_60_0._actionCard

	arg_60_0:resetAccount()

	local var_60_1 = arg_60_0:getUnderSkillCards((var_60_0._spellingSkill._owner or var_60_0)._id, var_60_0._spellingSkill._id)

	for iter_60_0 = 1, #var_60_1 do
		local var_60_2 = var_60_1[iter_60_0]

		if var_60_2._type ~= Data.CardType.fortress and (B.isAlive(var_60_2) or var_60_2._status == BattleData.CardStatus.hand or var_60_2._status == BattleData.CardStatus.pile) then
			local var_60_3 = 1

			while true do
				local var_60_4 = var_60_2:getSkillByMode(Data.SkillMode.under_spell_damage, var_60_3)

				if var_60_4 == nil then
					break
				end

				var_60_2._owner:castSkill(var_60_2, var_60_4, Data.SkillMode.under_spell_damage)

				var_60_3 = var_60_3 + 1
			end
		elseif var_60_2._type == Data.CardType.fortress and arg_60_0:accountDamage(var_60_2) > 0 then
			local var_60_5 = 1

			while true do
				local var_60_6 = var_60_2:getSkillByMode(Data.SkillMode.under_spell_damage, var_60_5)

				if var_60_6 == nil then
					break
				end

				var_60_2._owner:castSkill(var_60_2, var_60_6, Data.SkillMode.under_spell_damage)

				var_60_5 = var_60_5 + 1
			end

			if var_60_2:hasBuff(true, BattleData.PositiveType.shieldHp) then
				var_60_2._owner:castSkill(var_60_2, B.createSkill(11005, 1, var_60_2), Data.SkillMode.under_spell_damage)
			end

			if var_60_2:hasBuff(true, BattleData.PositiveType.shieldExHp) or var_60_2:hasBuff(true, BattleData.PositiveType.shieldHaloHp) then
				var_60_2._owner:castSkill(var_60_2, B.createSkill(12005, 1, var_60_2), Data.SkillMode.under_spell_damage)
			end
		end
	end

	if not var_60_0._needAccount then
		arg_60_0._stepStatus = BattleData.Status.account_spell

		return arg_60_0:step()
	else
		arg_60_0._stepStatus = BattleData.Status.account_spell

		if not arg_60_0._isReviewing then
			return arg_60_0:sendEvent(BattleData.Status.under_spell_damage)
		else
			return arg_60_0:step()
		end
	end
end

function var_0_0.accountSpell(arg_61_0)
	if arg_61_0._normalStatus ~= BattleData.Status.account_spell then
		B._lastAccount = BattleData.Status.account_spell
		arg_61_0._normalStatus = BattleData.Status.account_spell
		arg_61_0._haloDone = true

		for iter_61_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD * 2 do
			local var_61_0 = iter_61_0 <= Data.MAX_CARD_COUNT_ON_BOARD and arg_61_0._boardCards[iter_61_0] or arg_61_0._opponent._boardCards[iter_61_0 - Data.MAX_CARD_COUNT_ON_BOARD]

			if var_61_0 ~= nil and var_61_0._underSkills ~= nil and var_61_0._underSkills._disabled ~= true then
				for iter_61_1 = 1, #var_61_0._underSkills do
					local var_61_1 = var_61_0._underSkills[iter_61_1]

					if var_61_1._incNegative ~= nil then
						for iter_61_2, iter_61_3 in ipairs(var_61_1._incNegative) do
							if iter_61_3 == BattleData.NegativeType.haloSkillFrozen then
								arg_61_0._haloDone = false

								break
							end
						end
					end

					if var_61_1._decNegative ~= nil then
						for iter_61_4, iter_61_5 in ipairs(var_61_1._decNegative) do
							if iter_61_5 == BattleData.NegativeType.haloSkillFrozen then
								arg_61_0._haloDone = false

								break
							end
						end
					end
				end

				if not arg_61_0._haloDone then
					break
				end
			end
		end

		arg_61_0:resetAccount()
		arg_61_0:account()
		arg_61_0:removeDeadCards()

		if not arg_61_0._isReviewing then
			return arg_61_0:sendEvent(BattleData.Status.account_spell)
		end
	end

	if not arg_61_0._haloDone then
		arg_61_0._haloDone = true
		arg_61_0._stepStatus = BattleData.Status.before_account_halo

		return arg_61_0:step()
	end

	if next(arg_61_0._cardStatusToChange) ~= nil then
		arg_61_0._stepStatus = BattleData.Status.before_account_status

		return arg_61_0:step()
	end

	arg_61_0._stepStatus = BattleData.Status.after_spell
	arg_61_0._normalStatus = BattleData.Status.default

	return arg_61_0:step()
end

function var_0_0.afterSpell(arg_62_0)
	if arg_62_0._normalStatus ~= BattleData.Status.after_spell then
		arg_62_0._normalStatus = BattleData.Status.after_spell
		arg_62_0._afterSpellIndex = 0
	end

	if next(arg_62_0._cardStatusToChange) ~= nil then
		arg_62_0._stepStatus = BattleData.Status.before_account_status

		return arg_62_0:step()
	end

	local var_62_0 = arg_62_0._actionCard

	arg_62_0:resetAccount()

	arg_62_0._afterSpellIndex = arg_62_0._afterSpellIndex + 1

	local var_62_1 = var_62_0:getSkillByMode(Data.SkillMode.after_spell, arg_62_0._afterSpellIndex)

	if not B.isAlive(var_62_0) or var_62_1 == nil then
		arg_62_0._stepStatus = BattleData.Status.end_spell
		arg_62_0._normalStatus = BattleData.Status.default

		return arg_62_0:step()
	end

	var_62_0._owner:castSkill(var_62_0, var_62_1, Data.SkillMode.after_spell)

	if var_62_0._needAccount then
		arg_62_0:account()
		arg_62_0:removeDeadCards()
	end

	arg_62_0._stepStatus = BattleData.Status.after_spell

	if var_62_0._needAccount and not arg_62_0._isReviewing then
		return arg_62_0:sendEvent(BattleData.Status.after_spell)
	else
		return arg_62_0:step()
	end
end

function var_0_0.endSpell(arg_63_0)
	if arg_63_0._normalStatus ~= BattleData.Status.end_spell then
		arg_63_0._normalStatus = BattleData.Status.end_spell

		if not arg_63_0._isReviewing then
			return arg_63_0:sendEvent(BattleData.Status.end_spell)
		end
	end

	if next(arg_63_0._cardStatusToChange) ~= nil then
		arg_63_0._stepStatus = BattleData.Status.before_account_status
	else
		arg_63_0._stepStatus = BattleData.Status.spelling
	end

	return arg_63_0:step()
end

function var_0_0.beforeAttack(arg_64_0)
	if arg_64_0._normalStatus ~= BattleData.Status.before_attack then
		arg_64_0._normalStatus = BattleData.Status.before_attack
		arg_64_0._spellDone = false

		local var_64_0 = arg_64_0._actionCard

		arg_64_0:resetActionCard()

		arg_64_0._fortress._accountedDamage = nil
		arg_64_0._opponent._fortress._accountedDamage = nil
		arg_64_0._fortress._accountedAttackDamage = nil
		arg_64_0._opponent._fortress._accountedAttackDamage = nil
		var_64_0._mark1060 = nil

		arg_64_0:genAttackTarget(var_64_0)

		arg_64_0._attackIndex = arg_64_0._attackIndex + 1

		local var_64_1 = false

		for iter_64_0 = 1, #arg_64_0._attackedMonsters do
			if arg_64_0._attackedMonsters[iter_64_0] == var_64_0._id then
				var_64_1 = true

				break
			end
		end

		if not var_64_1 then
			arg_64_0._attackedMonsters[#arg_64_0._attackedMonsters + 1] = var_64_0._id
		end

		if not arg_64_0:checkCanAttack(var_64_0) then
			arg_64_0._stepStatus = arg_64_0:needEndAttack(var_64_0) and BattleData.Status.end_attack or BattleData.Status.after_account_attack
			arg_64_0._normalStatus = BattleData.Status.default

			return arg_64_0:step()
		end
	end

	if arg_64_0._trapWhenAttackState == 0 then
		arg_64_0._trapWhenAttackState = 1
		arg_64_0._stepStatus = BattleData.Status.before_account_trap_when_attack

		return arg_64_0:step()
	end

	local var_64_2 = arg_64_0._actionCard

	if not arg_64_0:checkCanAttack(var_64_2) then
		arg_64_0._stepStatus = arg_64_0:needEndAttack(var_64_2) and BattleData.Status.end_attack or BattleData.Status.after_account_attack
		arg_64_0._normalStatus = BattleData.Status.default

		return arg_64_0:step()
	end

	if not arg_64_0._spellDone then
		arg_64_0._spellDone = true
		arg_64_0._spellType = Data.SkillMode.before_attack
		arg_64_0._stepStatus = BattleData.Status.before_account_spell

		return arg_64_0:step()
	end

	if arg_64_0._trapWhenAttackState == 1 then
		arg_64_0._trapWhenAttackState = 2
		arg_64_0._stepStatus = BattleData.Status.before_account_trap_when_attack

		return arg_64_0:step()
	end

	arg_64_0._stepStatus = BattleData.Status.attacking

	return arg_64_0:step()
end

function var_0_0.attacking(arg_65_0)
	local var_65_0 = arg_65_0._actionCard

	arg_65_0:resetAccount()

	local var_65_1 = (var_65_0:hasCanCastMonsterSkillFast(1144) or var_65_0:isBindedSkill(7456)) and var_65_0:hasBuff(true, BattleData.PositiveType.defendPosture) and var_65_0._hp or var_65_0._atk

	var_65_0._attackerAtk = var_65_1

	for iter_65_0 = 1, #var_65_0._atkTargets do
		local var_65_2 = var_65_0._atkTargets[iter_65_0]

		if var_65_2:isMonsterRare() then
			var_65_2._dieCountUnderAttack = var_65_2._dieCount
			var_65_2._atkWhileAttacking = var_65_2._atk

			local var_65_3 = not var_65_0:hasDisableMonsterBeforeAttackSkills()

			if var_65_2:hasBuff(true, BattleData.PositiveType.defendPosture) then
				var_65_2._hpWhileAttacking = var_65_2._hp

				if var_65_1 > var_65_2._hp and (not var_65_3 or not var_65_2:hasSkillFast(2014) or not (var_65_1 >= Data._skillInfo[2014]._val[1])) and (not var_65_3 or not var_65_2:hasSkillFast(2019) or not (var_65_0:getStar() <= Data._skillInfo[2019]._val[1])) and (not var_65_3 or not var_65_2:hasSkillFast(2030) or not (var_65_0:getStar() <= Data._skillInfo[2030]._val[1])) and (not var_65_3 or not var_65_2:hasSkillFast(2039) or var_65_1 ~= var_65_2._atk) and (not var_65_0:hasCanCastMonsterSkills({
					1127,
					2022
				}) or not not var_65_2:hasShieldInType(BattleData.PositiveType.shieldMonster)) and (not var_65_3 or not var_65_2:hasSkillFast(2062) or not not var_65_0:isCeremonyMonster()) and (not var_65_3 or not var_65_2:hasSkillFast(2067) or not var_65_0:isMonsterRare() or not var_65_0:isNature(Data._skillInfo[2067]._refCards[1])) and (not var_65_2:hasSkillFast(5184) or not var_65_0:isKeyword(Data._skillInfo[5184]._refCards[1])) and (not var_65_3 or not var_65_2:hasCanCastMonsterSkillFast(9430) or not (var_65_0:getStar() < var_65_2:getStar())) and (not var_65_3 or not var_65_2:hasCanCastMonsterSkillFast(9795) or not not var_65_0:isNormalMonster()) then
					arg_65_0:setCardStatus(var_65_2, arg_65_0:getDieByAttackDestStatus(var_65_0, var_65_2), var_65_0._id, Data.ATTACKING_SKILL_ID, Data.SkillMode.before_attack, BattleData.CardStatusVal.b2g_kill_by_attack)
				end
			else
				var_65_2._hpWhileAttacking = nil

				if var_65_1 >= var_65_2._atk then
					if (not var_65_3 or not var_65_2:hasSkillFast(2014) or not (var_65_1 >= Data._skillInfo[2014]._val[1])) and (not var_65_3 or not var_65_2:hasSkillFast(2019) or not (var_65_0:getStar() <= Data._skillInfo[2019]._val[1])) and (not var_65_3 or not var_65_2:hasSkillFast(2030) or not (var_65_0:getStar() <= Data._skillInfo[2030]._val[1])) and (not var_65_3 or not var_65_2:hasSkillFast(2039) or var_65_1 ~= var_65_2._atk) and (not var_65_0:hasCanCastMonsterSkills({
						1127,
						2022
					}) or not not var_65_2:hasShieldInType(BattleData.PositiveType.shieldMonster)) and (not var_65_3 or not var_65_2:hasSkillFast(2062) or not not var_65_0:isCeremonyMonster()) and (not var_65_3 or not var_65_2:hasSkillFast(2067) or not var_65_0:isMonsterRare() or not var_65_0:isNature(Data._skillInfo[2067]._refCards[1])) and (not var_65_2:hasSkillFast(5184) or not var_65_0:isKeyword(Data._skillInfo[5184]._refCards[1])) and (not var_65_3 or not var_65_2:hasCanCastMonsterSkillFast(9430) or not (var_65_0:getStar() <= var_65_2:getStar())) and (not var_65_3 or not var_65_2:hasCanCastMonsterSkillFast(9795) or not not var_65_0:isNormalMonster()) then
						arg_65_0:setCardStatus(var_65_2, arg_65_0:getDieByAttackDestStatus(var_65_0, var_65_2), var_65_0._id, Data.ATTACKING_SKILL_ID, Data.SkillMode.before_attack, BattleData.CardStatusVal.b2g_kill_by_attack)
					end

					if var_65_1 > var_65_2._atk then
						if var_65_2._owner._mark13041 then
							var_65_2._owner._mark13041 = nil

							arg_65_0:addDamage(var_65_2._owner._opponent._fortress, var_65_2._owner._opponent:calcFortressDamage(arg_65_0._opponent:getDamageByAttack(var_65_2._owner._opponent._fortress, var_65_1 - var_65_2._atk, var_65_0, var_65_2)), var_65_0._id, Data.ATTACKING_SKILL_ID, Data.SkillMode.before_attack)
						else
							arg_65_0:addDamage(var_65_2._owner._fortress, var_65_2._owner:calcFortressDamage(arg_65_0:getDamageByAttack(var_65_2._owner._fortress, var_65_1 - var_65_2._atk, var_65_0, var_65_2)), var_65_0._id, Data.ATTACKING_SKILL_ID, Data.SkillMode.before_attack)
						end

						if var_65_0:hasCanCastMonsterSkillFast(9475) or var_65_0:isBindedSkill(7473) then
							arg_65_0:addDamage(var_65_2._owner._opponent._fortress, var_65_2._owner._opponent:calcFortressDamage(arg_65_0._opponent:getDamageByAttack(var_65_2._owner._opponent._fortress, var_65_1 - var_65_2._atk, var_65_0, var_65_2)), var_65_0._id, Data.ATTACKING_SKILL_ID, Data.SkillMode.before_attack)
						end
					end
				end
			end
		else
			if var_65_2._owner._mark13041 then
				var_65_2._owner._mark13041 = nil

				arg_65_0:addDamage(var_65_2._owner._opponent._fortress, var_65_2._owner._opponent:calcFortressDamage(arg_65_0._opponent:getDamageByAttack(var_65_2._owner._opponent._fortress, var_65_1, var_65_0, nil)), var_65_0._id, 0, Data.SkillMode.before_attack)
			else
				arg_65_0:addDamage(var_65_2, var_65_2._owner:calcFortressDamage(arg_65_0:getDamageByAttack(var_65_2, var_65_1, var_65_0, nil)), var_65_0._id, 0, Data.SkillMode.before_attack)
			end

			if var_65_0:hasCanCastMonsterSkillFast(9475) or var_65_0:isBindedSkill(7473) then
				arg_65_0:addDamage(var_65_2._owner._opponent._fortress, var_65_2._owner._opponent:calcFortressDamage(arg_65_0._opponent:getDamageByAttack(var_65_2._owner._opponent._fortress, var_65_1, var_65_0, nil)), var_65_0._id, 0, Data.SkillMode.before_attack)
			end

			var_65_0._mark6578 = true
		end

		if var_65_0:isKeyword(Data._skillInfo[2530]._refCards[1]) then
			var_65_0._owner._mark2530 = true
		end

		var_65_0._needAccount = true

		table.insert(var_65_0._castedSkills, {
			_id = 0
		})
		arg_65_0:battleLog("[BATTLE] %s\t%s\t%4d", arg_65_0:cardName(var_65_0), arg_65_0:cardName(var_65_2), var_65_1)
	end

	arg_65_0._stepStatus = BattleData.Status.under_attack

	if not arg_65_0._isReviewing then
		return arg_65_0:sendEvent(BattleData.Status.attacking)
	else
		return arg_65_0:step()
	end
end

function var_0_0.underAttack(arg_66_0)
	local var_66_0 = arg_66_0._actionCard

	arg_66_0:resetAccount()

	var_66_0._atkWhileAttacking = var_66_0._atk

	for iter_66_0 = 1, #var_66_0._atkTargets do
		local var_66_1 = var_66_0._atkTargets[iter_66_0]

		if B.isAlive(var_66_1) and (var_66_1:isMonsterRare() or var_66_1._type == Data.CardType.boss and var_66_1._info._isDeamon == 1) then
			local var_66_2 = 1

			while true do
				local var_66_3 = var_66_1:getSkillByMode(Data.SkillMode.under_attack, var_66_2)

				if var_66_3 == nil then
					break
				end

				var_66_1._owner:castSkill(var_66_1, var_66_3, Data.SkillMode.under_attack)

				var_66_2 = var_66_2 + 1
			end
		elseif var_66_1._type == Data.CardType.fortress and arg_66_0:accountDamage(var_66_1) > 0 then
			if var_66_1:hasBuff(true, BattleData.PositiveType.shieldHp) then
				var_66_1._owner:castSkill(var_66_1, B.createSkill(11005, 1, var_66_1), Data.SkillMode.under_attack)
			end

			if var_66_1:hasBuff(true, BattleData.PositiveType.shieldExHp) or var_66_1:hasBuff(true, BattleData.PositiveType.shieldHaloHp) then
				var_66_1._owner:castSkill(var_66_1, B.createSkill(12005, 1, var_66_1), Data.SkillMode.under_attack)
			end
		end
	end

	if not var_66_0._needAccount then
		arg_66_0._stepStatus = BattleData.Status.under_attack_damage

		return arg_66_0:step()
	else
		arg_66_0._stepStatus = BattleData.Status.under_attack_damage

		if not arg_66_0._isReviewing then
			return arg_66_0:sendEvent(BattleData.Status.under_attack)
		else
			return arg_66_0:step()
		end
	end
end

function var_0_0.underAttackDamage(arg_67_0)
	local var_67_0 = arg_67_0._actionCard

	arg_67_0:resetAccount()

	local var_67_1 = (var_67_0:hasCanCastMonsterSkillFast(1144) or var_67_0:isBindedSkill(7456)) and var_67_0:hasBuff(true, BattleData.PositiveType.defendPosture) and var_67_0._hp or var_67_0._atk

	for iter_67_0 = 1, #var_67_0._atkTargets do
		local var_67_2 = var_67_0._atkTargets[iter_67_0]

		if B.isAlive(var_67_2) and (var_67_2:isMonsterRare() or var_67_2._type == Data.CardType.boss and var_67_2._info._isDeamon == 1) then
			if var_67_0:isMonsterRare() then
				local var_67_3 = var_67_2:hasBuff(true, BattleData.PositiveType.defendPosture) and var_67_2._hp or var_67_2._atk

				if var_67_1 <= var_67_3 then
					if not var_67_2:hasBuff(true, BattleData.PositiveType.defendPosture) and (not var_67_0:hasSkillFast(2014) or not (var_67_2._atk >= Data._skillInfo[2014]._val[1])) and (not var_67_0:hasSkillFast(2019) or not (var_67_2:getStar() <= Data._skillInfo[2019]._val[1])) and (not var_67_0:hasSkillFast(2030) or not (var_67_2:getStar() <= Data._skillInfo[2030]._val[1])) and (not var_67_0:hasSkillFast(2039) or var_67_1 ~= var_67_2._atk) and (not var_67_2:hasCanCastMonsterSkillFast(2022) or not not var_67_0:hasShieldInType(BattleData.PositiveType.shieldMonster)) and (not var_67_0:hasSkillFast(2062) or not not var_67_2:isCeremonyMonster()) and (not var_67_0:hasSkillFast(2067) or not var_67_2:isMonsterRare() or not var_67_2:isNature(Data._skillInfo[2067]._refCards[1])) and (not var_67_0:hasSkillFast(5184) or not var_67_2:isKeyword(Data._skillInfo[5184]._refCards[1])) and (not var_67_0:hasCanCastMonsterSkillFast(9430) or not (var_67_2:getStar() <= var_67_0:getStar())) and (not var_67_0:hasCanCastMonsterSkillFast(9795) or not not var_67_2:isNormalMonster()) then
						arg_67_0:setCardStatus(var_67_0, arg_67_0:getDieByAttackDestStatus(var_67_2, var_67_0), var_67_2._id, Data.ATTACKING_SKILL_ID, Data.SkillMode.under_attack_damage, BattleData.CardStatusVal.b2g_kill_by_attack)
					end

					if var_67_1 < var_67_3 and (not var_67_0:hasSkills({
						1066
					}) or var_67_2:hasShieldInType(BattleData.PositiveType.shieldMonster) or not var_67_2:hasBuff(true, BattleData.PositiveType.defendPosture)) and (not var_67_0:hasSkills({
						1093
					}) or not not var_67_2:hasShieldInType(BattleData.PositiveType.shieldMonster)) then
						arg_67_0:addDamage(var_67_0._owner._fortress, var_67_0._owner:calcFortressDamage(arg_67_0:getDamageByAttack(var_67_0._owner._fortress, var_67_3 - var_67_1, var_67_2, var_67_0)), var_67_2._id, Data.ATTACKING_SKILL_ID, Data.SkillMode.under_attack_damage)

						if var_67_2:hasCanCastMonsterSkillFast(9475) or var_67_2:isBindedSkill(7473) then
							arg_67_0:addDamage(var_67_0._owner._opponent._fortress, var_67_0._owner._opponent:calcFortressDamage(arg_67_0._opponent:getDamageByAttack(var_67_0._owner._opponent._fortress, var_67_3 - var_67_1, var_67_2, var_67_0)), var_67_2._id, Data.ATTACKING_SKILL_ID, Data.SkillMode.under_attack_damage)
						end
					end
				end
			end

			local var_67_4 = 1

			while true do
				local var_67_5 = var_67_2:getSkillByMode(Data.SkillMode.under_attack_damage, var_67_4)

				if var_67_5 == nil then
					break
				end

				var_67_2._owner:castSkill(var_67_2, var_67_5, Data.SkillMode.under_attack_damage)

				var_67_4 = var_67_4 + 1
			end
		elseif var_67_2._type == Data.CardType.fortress then
			local var_67_6 = 1

			while true do
				local var_67_7 = var_67_2:getSkillByMode(Data.SkillMode.under_attack_damage, var_67_6)

				if var_67_7 == nil then
					break
				end

				var_67_2._owner:castSkill(var_67_2, var_67_7, Data.SkillMode.under_spell_damage)

				var_67_6 = var_67_6 + 1
			end
		end
	end

	if not var_67_0._needAccount then
		arg_67_0._stepStatus = BattleData.Status.ac_under_attack_damage

		return arg_67_0:step()
	else
		arg_67_0._stepStatus = BattleData.Status.ac_under_attack_damage

		if not arg_67_0._isReviewing then
			return arg_67_0:sendEvent(BattleData.Status.under_attack_damage)
		else
			return arg_67_0:step()
		end
	end
end

function var_0_0.acUnderAttackDamage(arg_68_0)
	local var_68_0 = arg_68_0._actionCard

	arg_68_0:resetAccount()

	if B.isAlive(var_68_0) and var_68_0:isMonsterRare() then
		local var_68_1 = 1

		while true do
			local var_68_2 = var_68_0:getSkillByMode(Data.SkillMode.under_attack_damage, var_68_1)

			if var_68_2 == nil then
				break
			end

			var_68_0._owner:castSkill(var_68_0, var_68_2, Data.SkillMode.under_attack_damage)

			var_68_1 = var_68_1 + 1
		end
	end

	if not var_68_0._needAccount then
		arg_68_0._stepStatus = BattleData.Status.account_attack

		return arg_68_0:step()
	else
		arg_68_0._stepStatus = BattleData.Status.account_attack

		if not arg_68_0._isReviewing then
			return arg_68_0:sendEvent(BattleData.Status.ac_under_attack_damage)
		else
			return arg_68_0:step()
		end
	end
end

function var_0_0.accountAttack(arg_69_0)
	if arg_69_0._normalStatus ~= BattleData.Status.account_attack then
		arg_69_0._normalStatus = BattleData.Status.account_attack
		arg_69_0._spellDone = false

		arg_69_0:resetAccount()
		arg_69_0:account()
		arg_69_0:removeDeadCards()

		if not arg_69_0._isReviewing then
			return arg_69_0:sendEvent(BattleData.Status.account_attack)
		end
	end

	if next(arg_69_0._cardStatusToChange) ~= nil then
		arg_69_0._stepStatus = BattleData.Status.before_account_status
	elseif not arg_69_0._spellDone then
		arg_69_0._spellDone = true
		arg_69_0._spellType = Data.SkillMode.after_attack
		arg_69_0._stepStatus = BattleData.Status.before_account_spell
	else
		arg_69_0._stepStatus = BattleData.Status.end_attack
		arg_69_0._normalStatus = BattleData.Status.default

		return arg_69_0:step()
	end

	return arg_69_0:step()
end

function var_0_0.endAttack(arg_70_0)
	if arg_70_0._normalStatus ~= BattleData.Status.end_attack then
		arg_70_0._normalStatus = BattleData.Status.end_attack

		local var_70_0 = arg_70_0._actionCard

		arg_70_0:resetAccount()
		var_70_0:removeUnderSkillByBeforeAttack(var_70_0)

		local var_70_1 = var_70_0._atkTargets[1]

		if var_70_1 ~= nil then
			var_70_1:removeUnderSkillByBeforeAttack(var_70_0)
		end

		local var_70_2 = B._mark2066

		if var_70_2 ~= nil then
			B._mark2066 = nil

			var_70_2:removeUnderSkillByBeforeAttack(var_70_0)
		end

		local var_70_3 = B._mark8063

		if var_70_3 ~= nil then
			B._mark8063 = nil

			var_70_3:removeUnderSkillByBeforeAttack(var_70_0)
		end

		local var_70_4 = B._mark9329

		if var_70_4 ~= nil then
			B._mark9329 = nil
			var_70_4._owner._opponent._frozenAttackRounds[var_70_4._owner._opponent._round] = true

			if not arg_70_0._isReviewing then
				arg_70_0:sendEvent(BattleData.Status.update_board_active)
			end
		end

		if var_70_0._mark5629 then
			var_70_0._mark5629 = nil
		end

		if var_70_0:hasBuff(false, BattleData.NegativeType.chaos) then
			arg_70_0:decNegativeStatus(var_70_0, {
				BattleData.NegativeType.chaos
			}, false, cid, id, mode)

			var_70_0._needAccount = true
		end

		if var_70_0._needAccount then
			arg_70_0:account()
			arg_70_0:removeDeadCards()
		end

		if var_70_0._needAccount and not arg_70_0._isReviewing then
			return arg_70_0:sendEvent(BattleData.Status.end_attack)
		end
	end

	if next(arg_70_0._cardStatusToChange) ~= nil then
		arg_70_0._stepStatus = BattleData.Status.before_account_status
	else
		arg_70_0._stepStatus = BattleData.Status.before_attack
	end

	return arg_70_0:step()
end

function var_0_0.accountEvent(arg_71_0)
	if arg_71_0._normalStatus ~= BattleData.Status.account_event then
		arg_71_0:battleLog("")
		arg_71_0:battleLog("[BATTLE] <EVENT>\tid = %d", arg_71_0._actionEvent._info._id)

		arg_71_0._normalStatus = BattleData.Status.account_event
		arg_71_0._eventIndex = 1
		arg_71_0._effectIndex = 0

		if not arg_71_0._isReviewing then
			return arg_71_0:sendEvent(BattleData.Status.account_event)
		end
	end

	if next(arg_71_0._cardStatusToChange) ~= nil then
		arg_71_0._stepStatus = BattleData.Status.before_account_status

		return arg_71_0:step()
	end

	local var_71_0 = arg_71_0._actionEvent
	local var_71_1, var_71_2 = arg_71_0:getActionEffect(var_71_0, arg_71_0._eventIndex)

	if var_71_1 ~= nil then
		if arg_71_0._effectIndex == 0 then
			arg_71_0._effectIndex = arg_71_0._effectIndex + 1
			arg_71_0._stepStatus = BattleData.Status.account_event

			if not arg_71_0._isReviewing then
				return arg_71_0:sendEvent(BattleData.Status.account_event)
			else
				return arg_71_0:step()
			end
		elseif arg_71_0._effectIndex == 1 then
			arg_71_0._effectIndex = arg_71_0._effectIndex + 1

			arg_71_0:resetAccount()
			var_71_0._owner._battleEvent:castEffect(var_71_1, var_71_2, var_71_0)

			if arg_71_0._actionCard._needAccount then
				arg_71_0:account()
			end

			arg_71_0._stepStatus = BattleData.Status.account_event

			if not arg_71_0._isReviewing then
				return arg_71_0:sendEvent(BattleData.Status.account_event)
			else
				return arg_71_0:step()
			end
		elseif arg_71_0._effectIndex == 2 then
			arg_71_0._effectIndex = 0
			arg_71_0._eventIndex = arg_71_0._eventIndex + 1
			arg_71_0._stepStatus = BattleData.Status.account_event

			return arg_71_0:step()
		end
	end

	arg_71_0._stepStatus = BattleData.Status.after_account_event

	return arg_71_0:step()
end

function var_0_0.accountFinish(arg_72_0)
	if arg_72_0._normalStatus ~= BattleData.Status.account_finish then
		arg_72_0._normalStatsu = BattleData.Status.account_finish

		if arg_72_0:getIsFortressDied() then
			local var_72_0 = BattleEvent.EventType.fortress_died
			local var_72_1 = arg_72_0:getEvents(var_72_0)

			for iter_72_0 = 1, #var_72_1 do
				local var_72_2 = var_72_1[iter_72_0]

				arg_72_0:changeEvent(var_72_2, var_72_0)
			end
		end

		if arg_72_0._opponent:getIsFortressDied() then
			local var_72_3 = BattleEvent.EventType.fortress_died
			local var_72_4 = arg_72_0._opponent:getEvents(var_72_3)

			for iter_72_1, iter_72_2 in ipairs(var_72_4) do
				arg_72_0:changeEvent(iter_72_2, var_72_3)
			end
		end

		if arg_72_0:getIsAllCardsDied() then
			local var_72_5 = BattleEvent.EventType.all_cards_died
			local var_72_6 = arg_72_0:getEvents(var_72_5)

			for iter_72_3, iter_72_4 in ipairs(var_72_6) do
				arg_72_0:changeEvent(iter_72_4, var_72_5)
			end
		end

		if arg_72_0._opponent:getIsAllCardsDied() then
			local var_72_7 = BattleEvent.EventType.all_cards_died
			local var_72_8 = arg_72_0._opponent:getEvents(var_72_7)

			for iter_72_5, iter_72_6 in ipairs(var_72_8) do
				arg_72_0:changeEvent(iter_72_6, var_72_7)
			end
		end
	end

	if next(arg_72_0._eventToChange) ~= nil then
		arg_72_0._stepStatus = BattleData.Status.before_account_event

		return arg_72_0:step()
	end

	arg_72_0._stepStatus = BattleData.Status.after_account_finish

	return arg_72_0:step()
end

function var_0_0.accountTrap(arg_73_0)
	if arg_73_0._normalStatus ~= BattleData.Status.account_trap then
		arg_73_0._normalStatus = BattleData.Status.account_trap
	end

	local var_73_0 = B.mergeTable({
		arg_73_0:getBattleCards("C"),
		arg_73_0._opponent:getBattleCards("C")
	})

	for iter_73_0 = 1, #var_73_0 do
		local var_73_1 = var_73_0[iter_73_0]

		if var_73_1._owner:canTriggerTrapWhenStatusChange(var_73_1, arg_73_0._actionCard) then
			var_73_1._trapTarget = arg_73_0._actionCard

			if var_73_1:hasSkills({
				5132
			}) then
				var_73_1._owner._castedSkillCounts[5132] = (var_73_1._owner._castedSkillCounts[5132] or 0) + 1
			end

			arg_73_0:changeCardStatus(var_73_1, var_73_1._status, BattleData.CardStatus.show)

			break
		end
	end

	if next(arg_73_0._cardStatusToChange) ~= nil then
		arg_73_0._stepStatus = BattleData.Status.before_account_status

		return arg_73_0:step()
	end

	arg_73_0._stepStatus = BattleData.Status.after_account_trap

	return arg_73_0:step()
end

function var_0_0.accountTrapWhenAttack(arg_74_0)
	if arg_74_0._normalStatus ~= BattleData.Status.account_trap_when_attack then
		arg_74_0._normalStatus = BattleData.Status.account_trap_when_attack
	end

	local var_74_0 = B.mergeTable({
		arg_74_0:getBattleCards("C"),
		arg_74_0._opponent:getBattleCards("C")
	})

	for iter_74_0 = 1, #var_74_0 do
		local var_74_1 = var_74_0[iter_74_0]

		if var_74_1._owner:canTriggerTrapWhenAttack(var_74_1, arg_74_0._actionCard) then
			var_74_1._trapTarget = arg_74_0._actionCard

			arg_74_0:changeCardStatus(var_74_1, var_74_1._status, BattleData.CardStatus.show, BattleData.CardStatusVal.c2s_attack)

			break
		end
	end

	if next(arg_74_0._cardStatusToChange) ~= nil then
		arg_74_0._stepStatus = BattleData.Status.before_account_status

		return arg_74_0:step()
	end

	arg_74_0._stepStatus = BattleData.Status.after_account_trap_when_attack

	return arg_74_0:step()
end

function var_0_0.saveStatus(arg_75_0)
	arg_75_0._saved = {
		_saved = arg_75_0._saved
	}

	local var_75_0 = arg_75_0._saved

	var_75_0._normalStatus = arg_75_0._normalStatus
	var_75_0._spellType = arg_75_0._spellType
	var_75_0._eventType = arg_75_0._eventType
	var_75_0._cardStatusToChange = arg_75_0._cardStatusToChange
	var_75_0._eventToChange = arg_75_0._eventToChange
	var_75_0._eventDone = arg_75_0._eventDone
	var_75_0._costSpellDone = arg_75_0._costSpellDone
	var_75_0._beforeMagicTrapSpellDone = arg_75_0._beforeMagicTrapSpellDone
	var_75_0._spellDone = arg_75_0._spellDone
	var_75_0._haloDone = arg_75_0._haloDone
	var_75_0._trapDone = arg_75_0._trapDone
	var_75_0._trapWhenAttackState = arg_75_0._trapWhenAttackState
	var_75_0._actionStep = arg_75_0._actionStep
	var_75_0._spellIndex = arg_75_0._spellIndex
	var_75_0._spellCountIndex = arg_75_0._spellCountIndex
	var_75_0._attackIndex = arg_75_0._attackIndex
	var_75_0._afterSpellIndex = arg_75_0._afterSpellIndex
	var_75_0._afterAttackIndex = arg_75_0._afterAttackIndex
	var_75_0._actionStatus = {}

	if arg_75_0._actionCard ~= nil then
		var_75_0._actionCard = arg_75_0._actionCard
		var_75_0._actionStatus._needAccount = arg_75_0._actionCard._needAccount
		var_75_0._actionStatus._spellingSkill = arg_75_0._actionCard._spellingSkill
	end

	if arg_75_0._actionEvent ~= nil then
		var_75_0._actionEvent = arg_75_0._actionEvent
		var_75_0._actionStatus._eventIndex = arg_75_0._eventIndex
		var_75_0._actionStatus._effectIndex = arg_75_0._effectIndex
	end

	arg_75_0._cardStatusToChange = {}
	arg_75_0._eventToChange = {}
end

function var_0_0.loadStatus(arg_76_0)
	assert(arg_76_0._saved ~= nil and next(arg_76_0._saved) ~= nil, "ERROR : can not load empty status")

	local var_76_0 = arg_76_0._saved

	arg_76_0._saved = var_76_0._saved
	arg_76_0._normalStatus = var_76_0._normalStatus
	arg_76_0._spellType = var_76_0._spellType
	arg_76_0._eventType = var_76_0._eventType
	arg_76_0._cardStatusToChange = var_76_0._cardStatusToChange
	arg_76_0._eventToChange = var_76_0._eventToChange
	arg_76_0._eventDone = var_76_0._eventDone
	arg_76_0._costSpellDone = var_76_0._costSpellDone
	arg_76_0._beforeMagicTrapSpellDone = var_76_0._beforeMagicTrapSpellDone
	arg_76_0._spellDone = var_76_0._spellDone
	arg_76_0._haloDone = var_76_0._haloDone
	arg_76_0._trapDone = var_76_0._trapDone
	arg_76_0._trapWhenAttackState = var_76_0._trapWhenAttackState
	arg_76_0._actionStep = var_76_0._actionStep
	arg_76_0._spellIndex = var_76_0._spellIndex
	arg_76_0._spellCountIndex = var_76_0._spellCountIndex
	arg_76_0._attackIndex = var_76_0._attackIndex
	arg_76_0._afterSpellIndex = var_76_0._afterSpellIndex
	arg_76_0._afterAttackIndex = var_76_0._afterAttackIndex

	if var_76_0._actionCard ~= nil then
		arg_76_0._actionCard = var_76_0._actionCard
		arg_76_0._actionCard._needAccount = var_76_0._actionStatus._needAccount
		arg_76_0._actionCard._spellingSkill = var_76_0._actionStatus._spellingSkill
	end

	if var_76_0._actionEvent ~= nil then
		arg_76_0._actionEvent = var_76_0._actionEvent
		arg_76_0._eventIdnex = var_76_0._actionStatus._eventIndex
		arg_76_0._effectIndex = var_76_0._actionStatus._effectIndex
	end

	if arg_76_0._normalStatus == BattleData.Status.after_account_status then
		arg_76_0._stepStatus = BattleData.Status.after_account_status

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.account_status then
		arg_76_0._stepStatus = BattleData.Status.account_status

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.account_spell then
		arg_76_0._stepStatus = BattleData.Status.account_spell

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.after_spell then
		arg_76_0._stepStatus = BattleData.Status.after_spell

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.end_spell then
		arg_76_0._stepStatus = BattleData.Status.end_spell

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.account_attack then
		arg_76_0._stepStatus = BattleData.Status.account_attack

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.before_attack then
		arg_76_0._stepStatus = BattleData.Status.before_attack

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.end_attack then
		arg_76_0._stepStatus = BattleData.Status.end_attack

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.account_event then
		arg_76_0._stepStatus = BattleData.Status.account_event

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.account_finish then
		arg_76_0._stepStatus = BattleData.Status.account_finish

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.account_trap then
		arg_76_0._stepStatus = BattleData.Status.account_trap

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.account_trap_when_attack then
		arg_76_0._stepStatus = BattleData.Status.account_trap_when_attack

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.try_use_card then
		arg_76_0._stepStatus = BattleData.Status.try_use_card

		return arg_76_0:step()
	elseif arg_76_0._normalStatus == BattleData.Status.do_use_card then
		arg_76_0._stepStatus = BattleData.Status.do_use_card

		return arg_76_0:step()
	end

	if arg_76_0._macroStatus == BattleData.Status.battle_start then
		arg_76_0._stepStatus = BattleData.Status.battle_start

		return arg_76_0:step()
	elseif arg_76_0._macroStatus == BattleData.Status.battle_end then
		arg_76_0._stepStatus = BattleData.Status.battle_end

		return arg_76_0:step()
	elseif arg_76_0._macroStatus == BattleData.Status.round_begin then
		arg_76_0._stepStatus = BattleData.Status.round_begin

		return arg_76_0:step()
	elseif arg_76_0._macroStatus == BattleData.Status.deal then
		arg_76_0._stepStatus = BattleData.Status.deal

		return arg_76_0:step()
	elseif arg_76_0._macroStatus == BattleData.Status.use then
		arg_76_0._stepStatus = BattleData.Status.use

		return arg_76_0:step()
	elseif arg_76_0._macroStatus == BattleData.Status.action then
		arg_76_0._stepStatus = BattleData.Status.action

		return arg_76_0:step()
	elseif arg_76_0._macroStatus == BattleData.Status.round_end then
		arg_76_0._stepStatus = BattleData.Status.round_end

		return arg_76_0:step()
	elseif arg_76_0._macroStatus == BattleData.Status.initial_deal then
		arg_76_0._stepStatus = BattleData.Status.initial_deal

		return arg_76_0:step()
	elseif arg_76_0._macroStatus == BattleData.Status.drop then
		arg_76_0._stepStatus = BattleData.Status.drop

		return arg_76_0:step()
	end
end

function var_0_0.removeDeadCards(arg_77_0)
	local var_77_0 = {}
	local var_77_1 = arg_77_0._saved

	while var_77_1 ~= nil and next(var_77_1) ~= nil do
		for iter_77_0 = 1, #var_77_1._cardStatusToChange do
			local var_77_2 = var_77_1._cardStatusToChange[iter_77_0]
			local var_77_3 = var_77_2._card

			if var_77_2._sourceStatus == BattleData.CardStatus.board and var_77_2._destStatus == BattleData.CardStatus.grave then
				table.insert(var_77_0, var_77_3)
			end
		end

		var_77_1 = var_77_1._saved
	end

	local var_77_4 = {}

	for iter_77_1 = 1, Data.MAX_CARD_COUNT_ON_BOARD * 2 do
		local var_77_5

		if iter_77_1 <= Data.MAX_CARD_COUNT_ON_BOARD then
			var_77_5 = arg_77_0._opponent._boardCards[iter_77_1]
		elseif iter_77_1 <= Data.MAX_CARD_COUNT_ON_BOARD * 2 then
			var_77_5 = arg_77_0._boardCards[iter_77_1 - Data.MAX_CARD_COUNT_ON_BOARD]
		end

		if not B.isAlive(var_77_5) then
			table.insert(var_77_4, var_77_5)
		end
	end

	for iter_77_2 = 1, #var_77_4 do
		local var_77_6 = var_77_4[iter_77_2]
		local var_77_7 = false

		for iter_77_3 = 1, #var_77_0 do
			if var_77_0[iter_77_3]._id == var_77_6._id then
				var_77_7 = true

				break
			end
		end

		if not var_77_7 then
			arg_77_0:changeCardStatus(var_77_6, BattleData.CardStatus.board, BattleData.CardStatus.grave)
		end
	end
end

function var_0_0.needEndAttack(arg_78_0, arg_78_1)
	if arg_78_1:underSkillHasMode(Data.SkillMode.before_attack) then
		return true
	end

	local var_78_0 = arg_78_1._atkTargets[1]

	if var_78_0 and var_78_0:underSkillHasMode(Data.SkillMode.before_attack) then
		return true
	end

	local var_78_1 = B._mark2026

	if var_78_1 and var_78_1:underSkillHasMode(Data.SkillMode.before_attack) then
		return true
	end

	local var_78_2 = B._mark8063

	if var_78_2 and var_78_2:underSkillHasMode(Data.SkillMode.before_attack) then
		return true
	end

	if B._mark9329 ~= nil then
		return true
	end

	return false
end
