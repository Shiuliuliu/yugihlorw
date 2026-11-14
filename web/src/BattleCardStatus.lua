local var_0_0 = PlayerBattle

function var_0_0.changeCardStatus(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	if (arg_1_1._type == Data.CardType.magic or arg_1_1._type == Data.CardType.trap) and arg_1_3 == BattleData.CardStatus.board then
		arg_1_3 = BattleData.CardStatus.grave
	end

	if arg_1_1._type == Data.CardType.rare and arg_1_3 ~= BattleData.CardStatus.board and arg_1_3 ~= BattleData.CardStatus.grave and arg_1_3 ~= BattleData.CardStatus.leave then
		arg_1_3 = BattleData.CardStatus.rare
	end

	if (arg_1_1._infoId == 12324 or arg_1_1:hasSkillFast(14700)) and arg_1_3 ~= BattleData.CardStatus.board then
		arg_1_1._htAtk = nil
		arg_1_1._maxAtk = 0
		arg_1_1._atk = 0
	end

	if arg_1_3 == BattleData.CardStatus.grave and (not arg_1_1._isTroopCard or arg_1_1._owner:hasBattleCardsBySkillFast("B", 6046) or not arg_1_1._owner._opponent._isSkillDisabled and arg_1_1._owner._opponent:hasBattleCardsBySkillFast("B", 6046) or not arg_1_1._owner._opponent._isSkillDisabled and arg_1_1._owner._opponent:hasBattleCardsByCanCastMonsterSkillFast("B", 2707) or arg_1_1:isMonsterRare() and arg_1_1._owner._opponent:hasBattleCardsByCanCastMonsterSkillFast("S", 8129) and #B.filterUniqueInfoIdCards(arg_1_1._owner._opponent:getBattleCardsByInfoIdGroup("B", Data._skillInfo[8129]._refCards)) >= 3) then
		arg_1_3 = BattleData.CardStatus.leave
	elseif arg_1_2 == BattleData.CardStatus.board and (arg_1_3 == BattleData.CardStatus.hand or arg_1_3 == BattleData.CardStatus.pile) and not arg_1_1._isTroopCard then
		arg_1_3 = arg_1_1._type == Data.CardType.rare and BattleData.CardStatus.rare or BattleData.CardStatus.leave
	end

	if (arg_1_4 == BattleData.CardStatusVal.x2gl_cost or arg_1_4 == BattleData.CardStatusVal.x2gl_oppo_cost) and arg_1_2 == BattleData.CardStatus.board and (arg_1_1:hasSkillFast(3210) or arg_1_1:hasSkillFast(13975) or arg_1_1._infoId == 40730 or arg_1_1:hasSkillFast(14719) or arg_1_1._infoId == 12327) then
		arg_1_3 = BattleData.CardStatus.leave
	end

	if arg_1_2 ~= BattleData.CardStatus.leave and arg_1_3 == BattleData.CardStatus.grave and (arg_1_1:hasSkillFast(3210) or arg_1_1:hasSkillFast(13975) or arg_1_1._infoId == 40730 or arg_1_1:hasSkillFast(14719) or arg_1_1._infoId == 12327) then
		arg_1_3 = BattleData.CardStatus.leave
	end

	local has40733 = #arg_1_0:getBattleCardsByInfoId("B", 40733) > 0 or (arg_1_0._opponent and #arg_1_0._opponent:getBattleCardsByInfoId("B", 40733) > 0)
	if has40733 and arg_1_2 == BattleData.CardStatus.grave and arg_1_3 == BattleData.CardStatus.board then
		return
	end

	local isThacSamAwakened = (arg_1_1._infoId == 40730 or arg_1_1:hasSkillFast(14719)) and (arg_1_1._tsAwakened or arg_1_1:hasSkillFast(12002) or (arg_1_1:getBuffValue(true, BattleData.PositiveType.xyzMark) or 0) == 0)
	if isThacSamAwakened and arg_1_2 == BattleData.CardStatus.board and arg_1_3 ~= BattleData.CardStatus.board then
		local isBattleKill = (arg_1_4 == BattleData.CardStatusVal.b2g_kill_by_attack)
		if not isBattleKill then
			local owner = arg_1_1._owner
			local oppo = owner and owner._opponent
			local isOppoAction = (arg_1_0 == oppo) or (arg_1_5 and arg_1_5._owner ~= owner) or (arg_1_4 == BattleData.CardStatusVal.b2g_oppo_sacrifice or arg_1_4 == BattleData.CardStatusVal.b2b_oppo_forever or arg_1_4 == BattleData.CardStatusVal.b2h_oppo or arg_1_4 == BattleData.CardStatusVal.x2gl_oppo_cost or arg_1_4 == BattleData.CardStatusVal.x2l_temp_oppo)
			if isOppoAction then
				return
			end
		end
	end

	-- Hand traps for Kiếm Phá Hủy (11960, 11961, 11959)
	local function isDragonMonsterCard(c)
		if not c then return false end
		if c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare then
			local cat = c._category or (c._info and c._info._category)
			if cat == 2 or cat == Data.CardCategory.dragon then
				return true
			end
			local kw = c._keyword or (c._info and c._info._keyword)
			if kw == 39 then
				return true
			end
		end
		return false
	end

	local function getActiveHandTrap(player, infoId)
		if not player then return nil end
		local hands = player:getBattleCards("H")
		for _, c in ipairs(hands) do
			if c._infoId == infoId and not c:hasChangeStatusUnderSkill({ BattleData.CardStatus.grave, BattleData.CardStatus.leave }) then
				return c
			end
		end
		return nil
	end

	local c_owner = arg_1_1._owner or arg_1_0
	local oppo = c_owner and c_owner._opponent

	if oppo and not oppo._isSkillDisabled then
		-- 1. Card 11960: Opponent summons Dragon from Extra Deck -> discard 11960, banish summoned dragon
		if arg_1_3 == BattleData.CardStatus.board and arg_1_2 ~= BattleData.CardStatus.board and isDragonMonsterCard(arg_1_1) then
			local isExtraDeck = (arg_1_2 == BattleData.CardStatus.rare or arg_1_1:isMonsterRare() or arg_1_1._type == Data.CardType.rare)
			if isExtraDeck then
				local ht11960 = getActiveHandTrap(oppo, 11960)
				if ht11960 then
					oppo:changeCardStatus(ht11960, BattleData.CardStatus.hand, BattleData.CardStatus.grave, BattleData.CardStatusVal.h2g_drop)
					arg_1_3 = BattleData.CardStatus.leave
					arg_1_0:battleLog("[BATTLE] Hand Trap 11960: discarded to grave, banished Extra Deck dragon %d", arg_1_1._infoId)
				end
			end
		end

		-- 2. Card 11961: Opponent summons Dragon -> discard 11961, banish summoned dragon
		if arg_1_3 == BattleData.CardStatus.board and arg_1_2 ~= BattleData.CardStatus.board and isDragonMonsterCard(arg_1_1) then
			local ht11961 = getActiveHandTrap(oppo, 11961)
			if ht11961 then
				oppo:changeCardStatus(ht11961, BattleData.CardStatus.hand, BattleData.CardStatus.grave, BattleData.CardStatusVal.h2g_drop)
				arg_1_3 = BattleData.CardStatus.leave
				if arg_1_2 == BattleData.CardStatus.hand then
					arg_1_4 = BattleData.CardStatusVal.h2l_show
				end
				arg_1_0:battleLog("[BATTLE] Hand Trap 11961: discarded to grave, banished summoned dragon %d", arg_1_1._infoId)
			end
		end

		-- LABRYNTH STOVIE TORBIE (12372 / 20138): Mỗi lượt chỉ 1 lần. Khi bài này nằm trong mộ, khi đối thủ lấy bài vào tay, sẽ loại bỏ bản thân bài này và bài đối thủ vừa lấy được.
		if arg_1_3 == BattleData.CardStatus.hand and arg_1_2 ~= BattleData.CardStatus.hand then
			local isDuelRound = (arg_1_0._round and arg_1_0._round > 0) and (arg_1_0._macroStatus ~= BattleData.Status.initial_deal) and (not arg_1_1.isStatusValDeal or not arg_1_1:isStatusValDeal())
			if isDuelRound and oppo then
				local turnId = (arg_1_0._round or 0) * 1000 + (oppo._round or 0)
				if oppo._stovieBanishTurn ~= turnId and (oppo._castedSkillCounts[20138] or 0) == 0 then
					local stovieCard = nil
					for _, gc in ipairs(oppo:getBattleCards("G")) do
						if (gc:isInfoId(12372) or gc._infoId == 12372 or gc:hasSkillFast(20138)) and gc._status == BattleData.CardStatus.grave and gc:canChangeToLeave() then
							stovieCard = gc
							break
						end
					end
					if stovieCard then
						oppo._stovieBanishTurn = turnId
						oppo._castedSkillCounts[20138] = (oppo._castedSkillCounts[20138] or 0) + 1
						oppo:changeCardStatus(stovieCard, BattleData.CardStatus.grave, BattleData.CardStatus.leave, BattleData.CardStatusVal.g2l_self, stovieCard, 20138, 91)
						arg_1_3 = BattleData.CardStatus.leave
						if arg_1_2 == BattleData.CardStatus.pile then
							arg_1_4 = BattleData.CardStatusVal.p2l_show
						end
						if oppo.checkLabrynthGraveTriggers then
							oppo:checkLabrynthGraveTriggers(stovieCard, 20138)
						end
						arg_1_0:battleLog("[BATTLE] Labrynth Stovie Torbie (12372) banished self from grave and banished opponent added card %d!", arg_1_1._infoId)
					end
				end
			end
		end

		-- 3. Card 11959: Opponent draws Dragon -> discard 11959, banish drawn dragon
		if arg_1_2 == BattleData.CardStatus.pile and arg_1_3 == BattleData.CardStatus.hand and isDragonMonsterCard(arg_1_1) then
			local isDuelRound = (arg_1_0._round and arg_1_0._round > 0) and (arg_1_0._macroStatus ~= BattleData.Status.initial_deal) and (not arg_1_1.isStatusValDeal or not arg_1_1:isStatusValDeal())
			if isDuelRound then
				local ht11959 = getActiveHandTrap(oppo, 11959)
				if ht11959 then
					oppo:changeCardStatus(ht11959, BattleData.CardStatus.hand, BattleData.CardStatus.grave, BattleData.CardStatusVal.h2g_drop)
					arg_1_3 = BattleData.CardStatus.leave
					arg_1_4 = BattleData.CardStatusVal.p2l_show
					arg_1_0:battleLog("[BATTLE] Hand Trap 11959: discarded to grave, banished drawn dragon %d", arg_1_1._infoId)
				end
			end
		end

		-- Fox (12348 / skill 14821): Khi lá bài này trên tay phe ta, đối phương rút được quái "thường" lên tay sẽ kích hoạt: triệu hồi đặc biệt lá bài này lên sân trong thế phòng thủ, đưa lá bài đối phương vừa rút được lên tay phe ta.
		if arg_1_2 == BattleData.CardStatus.pile and arg_1_3 == BattleData.CardStatus.hand and (arg_1_1:isNormalMonster() or (arg_1_1:isMonster() and not arg_1_1:isMonsterRare() and (arg_1_1:isNormal() or (arg_1_1._info and arg_1_1._info._type == Data.MonsterType.normal)))) then
			local isDuelRound = (arg_1_0._round and arg_1_0._round > 0) and (arg_1_0._macroStatus ~= BattleData.Status.initial_deal)
			if isDuelRound and not oppo._isSummonDisabled and not oppo._isSpecialSummonDisabled then
				local fox = getActiveHandTrap(oppo, 12348)
				if fox and oppo:canSpecialSummon(fox) and oppo:getEmptyBoardPos(fox) ~= nil then
					local ePos = oppo:getEmptyBoardPos(fox)
					if ePos then
						fox._saved._pos = ePos
						fox._positiveStatus[BattleData.PositiveType.defendPosture] = true
						fox._actionIndex = 1
						oppo:changeCardStatus(fox, BattleData.CardStatus.hand, BattleData.CardStatus.board, BattleData.CardStatusVal.h2b_def)
						arg_1_1._owner = oppo
						arg_1_0:battleLog("[BATTLE] Fox (12348) intercepted normal monster %d to allied hand!", arg_1_1._infoId)
					end
				end
			end
		end
	end

	local var_1_0 = {
		_card = arg_1_1,
		_sourceStatus = arg_1_2,
		_destStatus = arg_1_3,
		_statusVal = arg_1_4,
		_triggerCard = arg_1_5
	}
	local var_1_1 = arg_1_0:getActionPlayer()

	table.insert(var_1_1._cardStatusToChange, var_1_0)

	-- Shin - buồn ngủ (12368 / 20123): 1 lượt 1 lần, khi đối phương rút bài lên tay, triệu hồi đặc biệt lá bài này lên sân đối phương, đối phương rút 1 lá.
	if arg_1_2 == BattleData.CardStatus.pile and arg_1_3 == BattleData.CardStatus.hand and not arg_1_0._recursingShinNgu and oppo and not oppo._isSkillDisabled then
		local isDuelRound = (arg_1_0._round and arg_1_0._round > 0) and (arg_1_0._macroStatus ~= BattleData.Status.initial_deal)
		if isDuelRound and not oppo._isSummonDisabled and not oppo._isSpecialSummonDisabled then
			local turnId = (arg_1_0._round or 0) * 1000 + (oppo._round or 0)
			if oppo._castedShinNguTurn ~= turnId and #arg_1_0:getBoardCards() < Data.MAX_CARD_COUNT_ON_BOARD then
				local nguCard = getActiveHandTrap(oppo, 12368)
				if nguCard and arg_1_0:getEmptyBoardPos(nguCard) ~= nil then
					oppo._castedShinNguTurn = turnId
					oppo._castedSkillCounts[20123] = 1
					arg_1_0._recursingShinNgu = true
					oppo:changeCardStatus(nguCard, BattleData.CardStatus.hand, BattleData.CardStatus.board, BattleData.CardStatusVal.h2b_oppo_special, nguCard)
					for _, pCard in ipairs(arg_1_0._pileCards or {}) do
						if pCard ~= arg_1_1 and pCard._status == BattleData.CardStatus.pile then
							local alreadyQueued = false
							local actP = arg_1_0:getActionPlayer()
							for _, item in ipairs((actP and actP._cardStatusToChange) or {}) do
								if item._card == pCard then
									alreadyQueued = true
									break
								end
							end
							if not alreadyQueued then
								arg_1_0:changeCardStatus(pCard, BattleData.CardStatus.pile, BattleData.CardStatus.hand, BattleData.CardStatusVal.p2h, nguCard)
								break
							end
						end
					end
					arg_1_0._recursingShinNgu = false
					arg_1_0:battleLog("[BATTLE] Shin - buon ngu (12368) triggered on opponent draw!")
				end
			end
		end
	end

	if arg_1_1:isMonsterRare() and arg_1_2 == BattleData.CardStatus.board and arg_1_3 ~= BattleData.CardStatus.board then
		local var_1_2 = {}

		for iter_1_0 = 1, #arg_1_1._binds do
			var_1_2[#var_1_2 + 1] = arg_1_1._binds[iter_1_0]

			arg_1_1._binds[iter_1_0]:removeBind(arg_1_1)

			if arg_1_1._binds[iter_1_0]:hasSkillFast(7097) then
				arg_1_1._binds[iter_1_0]._mark7097 = arg_1_1
			end

			if arg_1_1._binds[iter_1_0]:hasSkillFast(4690) then
				arg_1_1._binds[iter_1_0]._mark4690 = true
			end

			if arg_1_1._binds[iter_1_0]:hasSkillFast(4842) then
				arg_1_1._binds[iter_1_0]._mark4842 = true
			end

			if arg_1_1._binds[iter_1_0]:hasSkillFast(4847) then
				arg_1_1._binds[iter_1_0]._mark4847 = true
			end
		end

		arg_1_1:removeBinds()

		arg_1_1._prevBindCards = var_1_2

		for iter_1_1 = 1, #var_1_2 do
			local var_1_3 = var_1_2[iter_1_1]

			if B.isAlive(var_1_3) and not var_1_3:hasChangeStatusUnderSkill({
				BattleData.CardStatus.grave,
				BattleData.CardStatus.leave
			}) then
				if ((arg_1_4 == BattleData.CardStatusVal.b2g_sacrifice or arg_1_4 == BattleData.CardStatusVal.b2g_oppo_sacrifice or arg_1_4 == BattleData.CardStatusVal.b2g_sync_sacrifice or arg_1_4 == BattleData.CardStatusVal.b2g_link_sacrifice or arg_1_4 == BattleData.CardStatusVal.b2g_summon_sacrifice) and var_1_3:hasSkillFast(7066) or arg_1_3 == BattleData.CardStatus.hand and var_1_3:hasSkills({
					7108,
					7111
				}) or arg_1_4 == BattleData.CardStatusVal.b2g_sync_sacrifice and var_1_3:hasSkillFast(4477)) and #var_1_3._owner:filterCanChangeToHandCards({
					var_1_3
				}) > 0 then
					arg_1_0:changeCardStatus(var_1_3, var_1_3._status, BattleData.CardStatus.hand)
				else
					arg_1_0:changeCardStatus(var_1_3, var_1_3._status, BattleData.CardStatus.grave)
				end
			end
		end
	elseif (arg_1_1._type == Data.CardType.magic or arg_1_1._type == Data.CardType.trap) and arg_1_2 == BattleData.CardStatus.show and arg_1_3 ~= BattleData.CardStatus.show then
		local var_1_4 = arg_1_1._binds[1]

		if B.isAlive(var_1_4) then
			arg_1_1._prevBindCard = var_1_4

			arg_1_1:removeBind(var_1_4)
			var_1_4:removeBind(arg_1_1)
		else
			arg_1_1._prevBindCard = nil
		end
	elseif arg_1_1._type == Data.CardType.magic and arg_1_3 == BattleData.CardStatus.field then
		if arg_1_1._infoId == 21134 or arg_1_1:hasSkillFast(7836) then
			arg_1_1._mark7836_triggered = nil
		end
		local var_1_5 = arg_1_1._owner._fieldCard

		if var_1_5 ~= nil then
			arg_1_0:changeCardStatus(var_1_5, var_1_5._status, BattleData.CardStatus.grave, BattleData.CardStatusVal.d2g_replace)
		end
	end
end

function var_0_0.changeEvent(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {
		_event = arg_2_1,
		_type = arg_2_2
	}
	local var_2_1 = arg_2_0:getActionPlayer()

	table.insert(var_2_1._eventToChange, var_2_0)
end

function var_0_0.removeCardFromRare(arg_3_0, arg_3_1)
	if arg_3_1._statusVal == BattleData.CardStatusVal.r2b_oppo then
		arg_3_1._owner:removeCardToOppo(arg_3_1)
	end

	table.remove(arg_3_0._rareCards, arg_3_1._pos)

	for iter_3_0 = 1, #arg_3_0._rareCards do
		arg_3_0._rareCards[iter_3_0]._pos = iter_3_0
	end

	arg_3_1:saveAndReset()
end

function var_0_0.removeCardFromPile(arg_4_0, arg_4_1)
	if arg_4_1._statusVal == BattleData.CardStatusVal.x2g_oppo or arg_4_1._statusVal == BattleData.CardStatusVal.x2l_temp_oppo or arg_4_1._statusVal == BattleData.CardStatusVal.x2gl_oppo_cost or arg_4_1._statusVal == BattleData.CardStatusVal.p2h_oppo then
		arg_4_1._owner:removeCardToOppo(arg_4_1)
	end

	arg_4_1._fromPilePos = arg_4_1._pos

	if arg_4_0._pileReorder ~= nil then
		for iter_4_0 = 1, #arg_4_0._pileReorder do
			local var_4_0 = arg_4_0._pileReorder[iter_4_0]

			arg_4_0._pileCards[iter_4_0] = var_4_0
			arg_4_0._pileCards[iter_4_0]._pos = iter_4_0
		end

		arg_4_0._pileReorder = nil
	end

	for iter_4_1 = 1, #arg_4_0._pileCards do
		if arg_4_0._pileCards[iter_4_1]._id == arg_4_1._id then
			table.remove(arg_4_0._pileCards, iter_4_1)

			break
		end
	end

	for iter_4_2 = 1, #arg_4_0._pileCards do
		arg_4_0._pileCards[iter_4_2]._pos = iter_4_2
	end

	arg_4_1:saveAndReset()
end

function var_0_0.removeCardFromHand(arg_5_0, arg_5_1)
	if arg_5_1._statusVal == BattleData.CardStatusVal.h2b_oppo_normal or arg_5_1._statusVal == BattleData.CardStatusVal.h2b_oppo_special or arg_5_1._statusVal == BattleData.CardStatusVal.h2b_oppo_special_def or arg_5_1._statusVal == BattleData.CardStatusVal.h2h_oppo or arg_5_1._statusVal == BattleData.CardStatusVal.h2p_oppo or arg_5_1._statusVal == BattleData.CardStatusVal.x2g_oppo or arg_5_1._statusVal == BattleData.CardStatusVal.x2l_temp_oppo or arg_5_1._statusVal == BattleData.CardStatusVal.x2gl_oppo_cost then
		arg_5_1._owner:removeCardToOppo(arg_5_1)
	end

	table.remove(arg_5_0._handCards, arg_5_1._pos)

	for iter_5_0 = 1, #arg_5_0._handCards do
		arg_5_0._handCards[iter_5_0]._pos = iter_5_0
	end

	arg_5_1._mark13537 = nil
	arg_5_1._mark13680 = nil

	arg_5_1:saveAndReset()

	arg_5_1._mark7750 = nil
	arg_5_1._mark14203 = nil
	arg_5_1._mark14278 = nil
end

function var_0_0.removeCardFromBoard(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1._statusVal == BattleData.CardStatusVal.b2b_oppo_once or arg_6_1._statusVal == BattleData.CardStatusVal.b2b_oppo_once_attack_frozen or arg_6_1._statusVal == BattleData.CardStatusVal.b2h_oppo_once
	local var_6_1 = arg_6_1._statusVal == BattleData.CardStatusVal.b2b_oppo_once or arg_6_1._statusVal == BattleData.CardStatusVal.b2b_oppo_once_attack_frozen or arg_6_1._statusVal == BattleData.CardStatusVal.b2b_oppo_forever or arg_6_1._statusVal == BattleData.CardStatusVal.b2b_oppo_forever_attack_frozen or arg_6_1._statusVal == BattleData.CardStatusVal.b2b_oppo_forever_using

	if var_6_1 or arg_6_1._statusVal == BattleData.CardStatusVal.b2h_oppo or arg_6_1._statusVal == BattleData.CardStatusVal.b2p_oppo or arg_6_1._statusVal == BattleData.CardStatusVal.b2h_oppo_once or arg_6_1._statusVal == BattleData.CardStatusVal.b2g_oppo_sacrifice or arg_6_1._statusVal == BattleData.CardStatusVal.x2g_oppo or arg_6_1._statusVal == BattleData.CardStatusVal.x2l_temp_oppo or arg_6_1._statusVal == BattleData.CardStatusVal.x2gl_oppo_cost or (arg_6_1._originOwner ~= nil and arg_6_1._owner ~= arg_6_1._originOwner and (arg_6_1._destStatus == BattleData.CardStatus.grave or arg_6_1._destStatus == BattleData.CardStatus.leave or arg_6_1._destStatus == BattleData.CardStatus.hand or arg_6_1._destStatus == BattleData.CardStatus.pile or arg_6_1._destStatus == BattleData.CardStatus.rare)) then
		arg_6_1._owner:removeCardToOppo(arg_6_1)
	end

	if var_6_0 then
		if not arg_6_1._isBorrowed then
			if arg_6_0._macroStatus ~= BattleData.Status.use and arg_6_0._opponent._macroStatus ~= BattleData.Status.use then
				arg_6_1._saved._pos = arg_6_1._pos
			end

			arg_6_1._isBorrowed = true
		else
			arg_6_1._isBorrowed = false
		end
	end

	if arg_6_1._statusVal ~= BattleData.CardStatusVal.b2b_oppo_forever then
		arg_6_1._mark13329 = nil
	end

	-- PRINCESS LABRYNTH (12381 / 20192): Khi bài này rời sân trong lượt của đối thủ; trong lượt này, quái vật đối thủ không thể tấn công và đối thủ không thể sử dụng bài trên tay.
	if (arg_6_1:isInfoId(12381) or arg_6_1._infoId == 12381 or arg_6_1:hasSkillFast(20192)) then
		local owner = arg_6_1._owner or (arg_6_1.getOriginOwner and arg_6_1:getOriginOwner())
		local oppo = owner and owner._opponent
		if oppo and oppo._macroStatus == BattleData.Status.use then
			oppo._princessAttackLockedTurn = oppo._round
			oppo._princessHandLockedTurn = oppo._round
		elseif oppo and owner and owner._battle and owner._battle:getActivePlayer() == oppo then
			oppo._princessAttackLockedTurn = oppo._round
			oppo._princessHandLockedTurn = oppo._round
		end
	end

	-- Hayate - Thứ nguyên vệ thần (40781 / 20221): Khi lá bài này vào mộ từ trên sân, phe ta nhận LP bằng số LP hiện tại của đối phương x2.
	if (arg_6_1:isInfoId(40781) or arg_6_1._infoId == 40781 or arg_6_1:hasSkillFast(20221)) and arg_6_1._destStatus == BattleData.CardStatus.grave then
		local owner = arg_6_1._originOwner or arg_6_1._owner or arg_6_0
		local oppo = owner and owner._opponent
		local oppoHp = (oppo and oppo._fortress and oppo._fortress._hp) or 0
		local healVal = oppoHp * 2
		if owner and owner._fortress and healVal > 0 then
			owner:incHp(owner._fortress, healVal, false, arg_6_1._id, 20221, Data.SkillMode.bcs2gl)
		end
	end

	if arg_6_1:isStatusValSacrifice() and arg_6_1:hasSkillFast(3206) then
		arg_6_1._dinosaurMarkValue = arg_6_1:getBuffValue(true, BattleData.PositiveType.dinosaurMark)
	end

	if arg_6_1:hasSkillFast(3426) then
		arg_6_1._oceanMarkValue = arg_6_1:getBuffValue(true, BattleData.PositiveType.oceanMark)
	end

	if arg_6_1:hasSkillFast(6915) or arg_6_1:hasSkillFast(2218) or arg_6_1:hasSkillFast(9368) then
		arg_6_1._xyzMarkValue = arg_6_1:getBuffValue(true, BattleData.PositiveType.xyzMark)
	end

	if B._mark9972 and arg_6_1:hasSkillFast(9972) then
		B._mark9972[arg_6_1._id] = nil
	end

	if arg_6_1._infoId == 40729 or arg_6_1:hasSkillFast(14714) then
		arg_6_1._trigger14714 = nil
	end
	arg_6_1._gokuUi20084Done = nil
	arg_6_1._gokuBlue20082Done = nil
	if arg_6_1._infoId == 40773 or (arg_6_1._info and arg_6_1._info._id == 40773) or arg_6_1:hasSkillFast(20085) then
		local oppo = arg_6_0._opponent
		if oppo then
			local stillHas40773 = false
			if arg_6_0._boardCards then
				for i = 1, Data.MAX_CARD_COUNT_ON_BOARD do
					local bc = arg_6_0._boardCards[i]
					if bc and bc ~= arg_6_1 and (bc._infoId == 40773 or (bc._info and bc._info._id == 40773) or bc:hasSkillFast(20085)) then
						stillHas40773 = true
						break
					end
				end
			end
			if not stillHas40773 then
				oppo._isSummonDisabled = false
				oppo._isSpecialSummonDisabled = false
				if oppo._fortress and oppo._fortress:hasBuff(false, BattleData.NegativeType.boardLock) then
					oppo:decNegativeStatus(oppo._fortress, { BattleData.NegativeType.boardLock }, false, arg_6_1._id, 20085, Data.SkillMode.once)
				end
			end
		end
	end

	arg_6_1._prevAtk = arg_6_1._atk
	arg_6_1._prevMagicMarkCount = arg_6_1:getBuffValue(true, BattleData.PositiveType.magicMark)
	arg_6_1._prevMark5437 = arg_6_1:isEffectMonster()

	if arg_6_1:isMonsterRare() and arg_6_1._pos ~= nil then
		arg_6_0._boardCards[arg_6_1._pos] = nil
		arg_6_0._isBoardDirty = true
	end

	arg_6_1._choice = nil
	arg_6_1._mark2202 = nil
	arg_6_1._mark2294 = nil
	arg_6_1._mark2467 = nil
	arg_6_1._mark2495_2 = nil
	arg_6_1._mark2505 = nil
	arg_6_1._mark2514 = nil
	arg_6_1._mark2517_2 = nil
	arg_6_1._mark2623 = nil
	arg_6_1._mark2630 = nil
	arg_6_1._mark2676 = nil
	arg_6_1._mark2902 = nil
	arg_6_1._mark2956 = nil
	arg_6_1._mark2998 = nil
	arg_6_1._mark4735 = nil
	arg_6_1._mark4795 = nil
	arg_6_1._mark4816 = nil
	arg_6_1._mark4826 = nil
	arg_6_1._mark4977 = nil
	arg_6_1._mark4977_2 = nil
	arg_6_1._mark4990 = nil
	arg_6_1._mark5244 = nil
	arg_6_1._mark5391 = nil
	arg_6_1._mark5391_2 = nil
	arg_6_1._mark5455 = nil
	arg_6_1._mark5504 = nil
	arg_6_1._mark5510 = nil
	arg_6_1._mark5531 = nil
	arg_6_1._mark5536 = nil
	arg_6_1._mark5576 = nil
	arg_6_1._mark5616 = nil
	arg_6_1._mark6387 = nil
	arg_6_1._mark6749 = nil
	arg_6_1._mark6822 = nil
	arg_6_1._mark7462 = nil
	arg_6_1._mark7465_2 = nil
	arg_6_1._mark7535 = nil
	arg_6_1._mark7648 = nil
	arg_6_1._mark7716 = nil
	arg_6_1._mark7775 = nil
	arg_6_1._mark7787 = nil
	arg_6_1._mark7787_2 = nil
	arg_6_1._mark7793 = nil
	arg_6_1._mark7793_2 = nil
	arg_6_1._mark7794 = nil
	arg_6_1._mark7801 = nil
	arg_6_1._mark7805 = nil
	arg_6_1._mark8043 = nil
	arg_6_1._mark8119_2 = nil
	arg_6_1._mark8151 = nil
	arg_6_1._mark9069 = nil
	arg_6_1._mark9106 = nil
	arg_6_1._mark9110 = nil
	arg_6_1._mark9117 = nil
	arg_6_1._mark9118 = nil
	arg_6_1._mark9124 = nil
	arg_6_1._mark9222 = nil
	arg_6_1._mark9407_2 = nil
	arg_6_1._mark9424 = nil
	arg_6_1._mark9549 = nil
	arg_6_1._mark9561 = nil
	arg_6_1._mark9647 = nil
	arg_6_1._mark9690 = nil
	arg_6_1._mark9759 = nil
	arg_6_1._mark9854 = nil
	arg_6_1._mark9873 = nil
	arg_6_1._mark9967 = nil
	arg_6_1._mark9979_1 = nil
	arg_6_1._mark9979_2 = nil
	arg_6_1._mark13088 = nil
	arg_6_1._mark13154 = nil
	arg_6_1._mark13159 = nil
	arg_6_1._mark13199_1 = nil
	arg_6_1._mark13199_2 = nil
	arg_6_1._mark13246 = nil
	arg_6_1._mark13249 = nil
	arg_6_1._mark13363 = nil
	arg_6_1._mark13369 = nil
	arg_6_1._mark13399 = nil
	arg_6_1._mark13438 = nil
	arg_6_1._mark13442 = nil
	arg_6_1._mark13545 = nil
	arg_6_1._mark13562 = nil
	arg_6_1._mark13617 = nil
	arg_6_1._mark13686 = nil
	arg_6_1._mark13689 = nil
	arg_6_1._mark13695 = nil
	arg_6_1._mark13709 = nil
	arg_6_1._mark13755 = nil
	arg_6_1._mark13776 = nil
	arg_6_1._mark13794 = nil
	arg_6_1._mark13939 = nil
	arg_6_1._mark14048 = nil
	arg_6_1._mark14070 = nil
	arg_6_1._mark14091 = nil
	arg_6_1._mark14122 = nil
	arg_6_1._mark14145 = nil
	arg_6_1._mark14147 = nil
	arg_6_1._mark14177 = nil
	arg_6_1._mark14199 = nil
	arg_6_1._mark14204 = nil
	arg_6_1._mark14219 = nil
	arg_6_1._mark14220 = nil
	arg_6_1._mark14221 = nil
	arg_6_1._mark14327 = nil
	arg_6_1._mark14430 = nil
	arg_6_1._mark14434 = nil
	arg_6_1._mark14438 = nil
	arg_6_1._markIgnoreOppoShield = nil
	arg_6_1._isNewLive1 = nil
	arg_6_1._isNewLive2 = nil

	if arg_6_1:isSync() then
		arg_6_1._owner._mark9172 = (arg_6_1._owner._mark9172 or 0) + 1
	end

	if arg_6_1:isLink() then
		arg_6_0:refreshLinkPos()
	end

	if not var_6_1 then
		if arg_6_1._isRemoveSkill then
			arg_6_1._isRemoveSkill = nil

			arg_6_1:baseResetSkills(true)
			arg_6_1:resetSkills()
			arg_6_1:resetByType()

			return
		end

		if (arg_6_1._type ~= Data.CardType.boss or arg_6_1._info._isDeamon ~= 1) and not arg_6_1:hasSkillFast(3338) then
			arg_6_1:saveAndReset()
		end
	end

	if arg_6_1:isInfoId(40748) or arg_6_1._infoId == 40748 or B.isWitherOnField(arg_6_0) then
		if arg_6_0.updateWitherDebuff then
			arg_6_0:updateWitherDebuff()
		end
	end
end

function var_0_0.removeCardFromGrave(arg_7_0, arg_7_1)
	if arg_7_1._statusVal == BattleData.CardStatusVal.g2h_oppo or arg_7_1._statusVal == BattleData.CardStatusVal.g2l_oppo or arg_7_1._statusVal == BattleData.CardStatusVal.g2b_oppo or arg_7_1._statusVal == BattleData.CardStatusVal.g2b_oppo_def or arg_7_1._statusVal == BattleData.CardStatusVal.g2b_oppo_def_disable_posture or arg_7_1._statusVal == BattleData.CardStatusVal.g2p_oppo or arg_7_1._statusVal == BattleData.CardStatusVal.g2g_oppo or arg_7_1._statusVal == BattleData.CardStatusVal.x2g_oppo or arg_7_1._statusVal == BattleData.CardStatusVal.x2l_temp_oppo then
		arg_7_1._owner:removeCardToOppo(arg_7_1)
	end

	table.remove(arg_7_0._graveCards, arg_7_1._pos)

	for iter_7_0 = 1, #arg_7_0._graveCards do
		arg_7_0._graveCards[iter_7_0]._pos = iter_7_0
	end

	if arg_7_1._destStatus ~= BattleData.CardStatus.grave then
		arg_7_1._mark6327 = nil
		arg_7_1._markTrapDisabledToGrave = nil
		arg_7_1._markMergeComponentToGrave = nil
		arg_7_1._markCeremonyComponentToGrave = nil
		arg_7_1._markSyncComponentToGrave = nil
		arg_7_1._markXYZComponentToGrave = nil
		arg_7_1._markLinkComponentToGrave = nil
	end

	arg_7_1._dieFromAlterMagic = nil
	arg_7_1._mark9244_1 = nil
	arg_7_1._mark9244_2 = nil
	arg_7_1._mark9369 = nil
	arg_7_1._mark9840 = nil
	arg_7_1._mark13310 = nil
	arg_7_1._mark13773 = nil
	arg_7_1._mark14525 = nil
	arg_7_1._mark14527 = nil
	arg_7_1._mark14531 = nil
	arg_7_1._owner._opponent._mark14256 = nil

	arg_7_1:saveAndReset()
end

function var_0_0.removeCardFromLeave(arg_8_0, arg_8_1)
	if arg_8_1._statusVal == BattleData.CardStatusVal.l2b_oppo or arg_8_1._statusVal == BattleData.CardStatusVal.g2p_oppo or arg_8_1._statusVal == BattleData.CardStatusVal.x2g_oppo or arg_8_1._statusVal == BattleData.CardStatusVal.l2l_oppo or arg_8_1._statusVal == BattleData.CardStatusVal.x2l_temp_oppo then
		arg_8_1._owner:removeCardToOppo(arg_8_1)
	end

	for iter_8_0 = 1, #arg_8_0._leaveCards do
		if arg_8_0._leaveCards[iter_8_0] == arg_8_1 then
			table.remove(arg_8_0._leaveCards, iter_8_0)
		end
	end

	arg_8_1._invisibleInLeave = nil
	arg_8_1._mark13698_1 = nil
	arg_8_1._mark13698_2 = nil

	arg_8_1:saveAndReset()
end

function var_0_0.removeCardFromCover(arg_9_0, arg_9_1)
	if arg_9_1._statusVal == BattleData.CardStatusVal.x2g_oppo or arg_9_1._statusVal == BattleData.CardStatusVal.x2l_temp_oppo or arg_9_1._statusVal == BattleData.CardStatusVal.x2gl_oppo_cost or arg_9_1._statusVal == BattleData.CardStatusVal.b2p_oppo or arg_9_1._statusVal == BattleData.CardStatusVal.b2h_oppo then
		arg_9_1._owner:removeCardToOppo(arg_9_1)
	end

	arg_9_0._coverCards[arg_9_1._pos] = nil
	arg_9_1._trapViewed = nil

	if arg_9_0._mark8087 == arg_9_1 then
		arg_9_0._mark8087 = nil
	end

	if arg_9_0._opponent._mark8087_oppo == arg_9_1 then
		arg_9_0._opponent._mark8087_oppo = nil
	end

	if arg_9_1._destStatus ~= BattleData.CardStatus.show then
		arg_9_1:saveAndReset()
	end
end

function var_0_0.removeCardFromShow(arg_10_0, arg_10_1)
	if arg_10_1._statusVal == BattleData.CardStatusVal.x2g_oppo or arg_10_1._statusVal == BattleData.CardStatusVal.x2l_temp_oppo or arg_10_1._statusVal == BattleData.CardStatusVal.x2gl_oppo_cost or arg_10_1._statusVal == BattleData.CardStatusVal.b2p_oppo or arg_10_1._statusVal == BattleData.CardStatusVal.b2h_oppo then
		arg_10_1._owner:removeCardToOppo(arg_10_1)
	end

	arg_10_0._showCards[arg_10_1._pos] = nil

	if arg_10_1:hasSkillFast(4139) then
		arg_10_1._4139Count = arg_10_1:getBuffValue(true, BattleData.PositiveType.sugarMark2)
	end

	if arg_10_1._infoId == 30597 or arg_10_1:hasSkillFast(14813) then
		arg_10_0:account()
		if arg_10_0._opponent then arg_10_0._opponent:account() end
	end

	arg_10_1._mark5574 = nil
	arg_10_1._mark7612 = nil
	arg_10_1._mark7613 = nil
	arg_10_1._mark7660 = nil
	arg_10_1._mark7661 = nil
	arg_10_1._mark7670 = nil
	arg_10_1._mark7738 = nil
	arg_10_1._mark7740 = nil
	arg_10_1._mark8011 = nil
	arg_10_1._mark8132 = nil
	arg_10_1._prevMagicMarkCount = arg_10_1:getBuffValue(true, BattleData.PositiveType.magicMark)
	arg_10_1._prevSamuraiMarkCount = arg_10_1:getBuffValue(true, BattleData.PositiveType.samuraiMark)

	arg_10_1:saveAndReset()
end

function var_0_0.removeCardFromField(arg_11_0, arg_11_1)
	if arg_11_1._statusVal == BattleData.CardStatusVal.x2g_oppo or arg_11_1._statusVal == BattleData.CardStatusVal.x2l_temp_oppo or arg_11_1._statusVal == BattleData.CardStatusVal.x2gl_oppo_cost or arg_11_1._statusVal == BattleData.CardStatusVal.b2p_oppo or arg_11_1._statusVal == BattleData.CardStatusVal.b2h_oppo then
		arg_11_1._owner:removeCardToOppo(arg_11_1)
	end

	if arg_11_1 == arg_11_0._fieldCard then
		arg_11_0._fieldCard = nil
	end

	arg_11_1._mark4999 = nil
	arg_11_1._mark7465 = nil
	arg_11_1._mark7507 = nil
	arg_11_1._mark7512 = nil
	arg_11_1._mark7778 = nil

	arg_11_1:saveAndReset()
end

function var_0_0.addCardToRare(arg_12_0, arg_12_1)
	table.insert(arg_12_0._rareCards, arg_12_1)

	arg_12_1._pos = #arg_12_0._rareCards
	arg_12_1._status = BattleData.CardStatus.rare

	lc.clearTable(arg_12_1._saved)
	arg_12_1:setDieStat()
end

function var_0_0.addCardToPile(arg_13_0, arg_13_1)
	if arg_13_1._triggerCard and (arg_13_1._triggerCard:hasSkillFast(9310) or arg_13_1._triggerCard:hasSkillFast(9694) or arg_13_1._triggerCard:hasSkillFast(7405)) then
		arg_13_1._saved._pos = 1
	elseif arg_13_1._triggerCard and (arg_13_1._triggerCard:hasSkillFast(9343) or arg_13_1._triggerCard:hasSkillFast(4853) or arg_13_1._triggerCard:hasSkillFast(8139) or arg_13_1._triggerCard:hasSkillFast(14740) or arg_13_1._triggerCard:isInfoId(12330)) then
		arg_13_1._saved._pos = #arg_13_0._pileCards + 1
	end

	if arg_13_1._saved._pos and type(arg_13_1._saved._pos) == "table" then
		local var_13_0 = arg_13_1._saved._pos

		for iter_13_0 = #var_13_0, 1, -1 do
			local var_13_1 = arg_13_0:getCardById(var_13_0[iter_13_0])

			for iter_13_1 = 1, #arg_13_0._pileCards do
				if arg_13_0._pileCards[iter_13_1] == var_13_1 then
					table.remove(arg_13_0._pileCards, iter_13_1)

					break
				end
			end

			table.insert(arg_13_0._pileCards, 1, var_13_1)
		end
	else
		local var_13_2 = arg_13_1._saved._pos and arg_13_1._saved._pos > 0 and arg_13_1._saved._pos <= #arg_13_0._pileCards + 1 and arg_13_1._saved._pos or math.floor(arg_13_0:getRandom() * (#arg_13_0._pileCards + 1)) + 1

		table.insert(arg_13_0._pileCards, var_13_2, arg_13_1)
	end

	if arg_13_1._statusVal == BattleData.CardStatusVal.b2g_kill_by_attack then
		if arg_13_1._triggerCard and arg_13_1._triggerCard:hasSkillFast(6058) then
			arg_13_0:randomPile()
		end
	elseif arg_13_1._triggerCard and arg_13_1._triggerCard:hasSkillFast(3262) then
		arg_13_0:randomPile()
	else
		for iter_13_2 = 1, #arg_13_0._pileCards do
			arg_13_0._pileCards[iter_13_2]._pos = iter_13_2
		end
	end

	arg_13_1._status = BattleData.CardStatus.pile

	lc.clearTable(arg_13_1._saved)

	if arg_13_1._statusVal == BattleData.CardStatusVal.b2g_kill_by_attack then
		arg_13_1:setDieStat()
	end
end

function var_0_0.addCardToHand(arg_14_0, arg_14_1)
	if #arg_14_0._handCards == Data.MAX_CARD_COUNT_IN_HAND then
		if arg_14_1._type == Data.CardType.rare then
			arg_14_1._destStatus = BattleData.CardStatus.rare

			arg_14_0:addCardToRare(arg_14_1)
		else
			arg_14_1._destStatus = BattleData.CardStatus.grave

			arg_14_0:addCardToGrave(arg_14_1)
		end

		return
	end

	if arg_14_0._mark2512 ~= nil and arg_14_0._round >= arg_14_0._mark2512 and arg_14_0._round <= arg_14_0._mark2512 + 3 and arg_14_1._sourceStatus == BattleData.CardStatus.pile and arg_14_1._atk ~= nil and arg_14_1._atk >= 1500 then
		arg_14_1._destStatus = BattleData.CardStatus.grave

		arg_14_0:addCardToGrave(arg_14_1)

		return
	end

	table.insert(arg_14_0._handCards, arg_14_1)

	arg_14_1._pos = #arg_14_0._handCards

	if arg_14_1._saved._addSkills ~= nil then
		for iter_14_0 = 1, #arg_14_1._saved._addSkills do
			arg_14_1:addSkill(arg_14_1._saved._addSkills[iter_14_0], 1, BattleData.SkillProvider.given)
		end

		arg_14_1._saved._addSkills = nil
	end

	arg_14_1._mark5249 = nil
	arg_14_1._status = BattleData.CardStatus.hand
	arg_14_1._onHandRound = arg_14_0._round
	arg_14_1._onHandCard = arg_14_1._triggerCard

	lc.clearTable(arg_14_1._saved)
end

function var_0_0.addCardToBoard(arg_15_0, arg_15_1)
	if arg_15_1._type == Data.CardType.magic or arg_15_1._type == Data.CardType.trap then
		arg_15_0:addCardToGrave(arg_15_1)
		return
	end

	if arg_15_1:isMonsterRare() then
		local var_15_0

		if arg_15_1._infoId == 40729 or arg_15_1._infoId == 40731 or arg_15_1._infoId == 40776 or (arg_15_1._saved and arg_15_1._saved._bypassLink) then
			var_15_0 = arg_15_1._saved._pos and (arg_15_0:isLinkPosEmpty(arg_15_1._saved._pos) or arg_15_0:isBoardPosEmpty(arg_15_1._saved._pos)) and arg_15_1._saved._pos or (arg_15_0:getEmptyLinkPos(arg_15_1) or arg_15_0:getEmptyBoardPos(arg_15_1))
		elseif arg_15_1:isStatusValLinkSummon() then
			var_15_0 = arg_15_1._saved._pos and arg_15_0:isLinkPosEmpty(arg_15_1._saved._pos) and arg_15_1._saved._pos or arg_15_0:getEmptyLinkPos(arg_15_1)
		else
			local desiredPos = arg_15_1._saved._pos
			local isDesiredEmpty = desiredPos and desiredPos >= 1 and desiredPos <= Data.MAX_CARD_COUNT_ON_BOARD and not arg_15_0:isBoardPosLocked(desiredPos) and (arg_15_0._boardCards[desiredPos] == nil or arg_15_0._boardCards[desiredPos] == arg_15_1 or arg_15_0._boardCards[desiredPos]._destStatus == BattleData.CardStatus.grave or arg_15_0._boardCards[desiredPos]._destStatus == BattleData.CardStatus.leave)
			var_15_0 = isDesiredEmpty and desiredPos or arg_15_0:getEmptyBoardPos(arg_15_1)
		end

		if var_15_0 == nil then
			for iter_pos = 1, Data.MAX_CARD_COUNT_ON_BOARD do
				if not arg_15_0:isBoardPosLocked(iter_pos) then
					local c = arg_15_0._boardCards[iter_pos]
					if c == nil or c == arg_15_1 or c._destStatus == BattleData.CardStatus.grave or c._destStatus == BattleData.CardStatus.leave then
						var_15_0 = iter_pos
						break
					end
				end
			end
		end

		arg_15_1._saved._pos = nil

		if var_15_0 ~= nil then
			if arg_15_0._boardCards[var_15_0] ~= nil and arg_15_0._boardCards[var_15_0] ~= arg_15_1 then
				local oldC = arg_15_0._boardCards[var_15_0]
				arg_15_0:changeCardStatus(oldC, BattleData.CardStatus.board, BattleData.CardStatus.grave, BattleData.CardStatusVal.b2g_sacrifice, arg_15_1)
				arg_15_0._boardCards[var_15_0] = nil
			end
			arg_15_0._boardCards[var_15_0] = arg_15_1
			arg_15_0._isBoardDirty = true
			arg_15_1._pos = var_15_0

			if arg_15_1._saved._bind ~= nil then
				arg_15_1:addBind(arg_15_1._saved._bind)

				arg_15_1._saved._bind = nil
			end

			if arg_15_1._type == Data.CardType.monster then
				arg_15_1._monsterTarget = arg_15_1._saved._monsterTarget
			end

			-- Labrynth Special Summon ATK Boost (20167, 20177, 20186): ATK += ("Labrynth" Traps in GL) * 300
			local isSpSummon1 = (B and B.isSpecialSummon and B.isSpecialSummon(arg_15_1)) or (arg_15_1.isStatusValSpecialSummon and arg_15_1:isStatusValSpecialSummon()) or ((arg_15_1:isMonster() or arg_15_1:isMonsterRare()) and not (arg_15_1.isStatusValNormalSummon and arg_15_1:isStatusValNormalSummon()) and not (arg_15_1.isStatusValNotSummon and arg_15_1:isStatusValNotSummon()))
			if (arg_15_1._infoId == 12379 or arg_15_1._infoId == 12380 or arg_15_1._infoId == 12381) and (isSpSummon1 or arg_15_1._statusVal == BattleData.CardStatusVal.h2b_normal or arg_15_1._statusVal == BattleData.CardStatusVal.p2b_normal or arg_15_1._statusVal == BattleData.CardStatusVal.g2b_normal or arg_15_1._statusVal == BattleData.CardStatusVal.l2b_normal) then
				local trapCount = 0
				for _, c in ipairs(arg_15_0:getBattleCards("G")) do
					if (c:isTrap() or c._type == Data.CardType.trap) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
						trapCount = trapCount + 1
					end
				end
				for _, c in ipairs(arg_15_0:getBattleCards("L")) do
					if (c:isTrap() or c._type == Data.CardType.trap) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
						trapCount = trapCount + 1
					end
				end
				local atkBonus = trapCount * 300
				if atkBonus > 0 then
					arg_15_1._atk = arg_15_1._atk + atkBonus
					if arg_15_1._maxAtk then
						arg_15_1._maxAtk = arg_15_1._maxAtk + atkBonus
					end
				end
			end

			-- LADY LABRYNTH (12379 / 20172): Draw 1 when 8★ Labrynth monster (except Lady) summoned
			if (arg_15_1:isKeyword(308) or (arg_15_1._info and arg_15_1._info._keyword == 308)) and arg_15_1:getStar() == 8 and arg_15_1._infoId ~= 12379 then
				if (arg_15_0._castedSkillCounts[20172] or 0) == 0 and #arg_15_0:getBattleCardsByInfoId("B", 12379) > 0 then
					arg_15_0._castedSkillCounts[20172] = 1
					arg_15_0:drawCards(1)
				end
			end

			-- Hướng dương (12389 / 20244): Khi lên sân: lấy 1 lá <Sun> (21176) từ bộ bài / mộ bài / mộ loại bỏ lên tay
			if arg_15_1._infoId == 12389 or arg_15_1:isInfoId(12389) or arg_15_1:hasSkillFast(20244) then
				local sunCard = nil
				for _, c in ipairs(arg_15_0:filterCanChangeToHandCards(arg_15_0:getBattleCards("P"))) do
					if c._infoId == 21176 or (c.isInfoId and c:isInfoId(21176)) then
						sunCard = c
						break
					end
				end
				if not sunCard then
					for _, c in ipairs(arg_15_0:filterCanChangeToHandCards(arg_15_0:getBattleCards("G"))) do
						if c._infoId == 21176 or (c.isInfoId and c:isInfoId(21176)) then
							sunCard = c
							break
						end
					end
				end
				if not sunCard then
					for _, c in ipairs(arg_15_0:filterCanChangeToHandCards(arg_15_0:getBattleCards("L"))) do
						if c._infoId == 21176 or (c.isInfoId and c:isInfoId(21176)) then
							sunCard = c
							break
						end
					end
				end
				if sunCard then
					local srcVal = (sunCard._status == BattleData.CardStatus.pile) and BattleData.CardStatusVal.p2h_draw
						or ((sunCard._status == BattleData.CardStatus.grave) and BattleData.CardStatusVal.g2h_normal
						or BattleData.CardStatusVal.l2h_normal)
					arg_15_0:setCardStatus(sunCard, BattleData.CardStatus.hand, arg_15_1._id, 20244, Data.SkillMode.once, srcVal)
				end
			end

			if (arg_15_0._battleType == Data.BattleType.PVP_room and arg_15_0._round == 1) or (arg_15_0._isAttacker and arg_15_0._round == (arg_15_0._battleType == Data.BattleType.PVP_room and 2 or 1) and arg_15_0._battleType ~= Data.BattleType.unittest and arg_15_0._battleType ~= Data.BattleType.teach) or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_compose_ex or arg_15_1._statusVal == BattleData.CardStatusVal.g2b_decompose or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_sync_attack_frozen or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_xyz_attack_frozen then
				arg_15_1._canAttack = false
			else
				arg_15_1._canAttack = true
			end

			local var_15_1 = false
			local var_15_2 = false
			local var_15_3 = false
			local var_15_4 = false
			local var_15_5 = false

			if arg_15_1._statusVal == BattleData.CardStatusVal.g2b_attack_frozen_def then
				var_15_4 = true
				var_15_1 = true
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.h2b_attack_frozen or arg_15_1._statusVal == BattleData.CardStatusVal.g2b_attack_frozen or arg_15_1._statusVal == BattleData.CardStatusVal.p2b_attack_frozen or arg_15_1._statusVal == BattleData.CardStatusVal.b2b_oppo_once_attack_frozen and arg_15_1._isBorrowed or arg_15_1._statusVal == BattleData.CardStatusVal.b2b_oppo_forever_attack_frozen then
				var_15_4 = true
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.g2b_def or arg_15_1._statusVal == BattleData.CardStatusVal.g2b_oppo_def or arg_15_1._statusVal == BattleData.CardStatusVal.p2b_def or arg_15_1._statusVal == BattleData.CardStatusVal.h2b_def or arg_15_1._statusVal == BattleData.CardStatusVal.e2b_def or arg_15_1._statusVal == BattleData.CardStatusVal.e2b_5039 or arg_15_1._statusVal == BattleData.CardStatusVal.e2x_fast_def or arg_15_1._statusVal == BattleData.CardStatusVal.e2b_5224 or arg_15_1._statusVal == BattleData.CardStatusVal.e2b_from_temp_leave_def or arg_15_1._statusVal == BattleData.CardStatusVal.h2b_oppo_special_def then
				var_15_1 = true
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.g2b_disable_posture_ex then
				var_15_3 = true
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.g2b_def_disable_posture or arg_15_1._statusVal == BattleData.CardStatusVal.g2b_oppo_def_disable_posture then
				var_15_1 = true
				var_15_2 = true
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.h2b_ceremony_frozen then
				var_15_5 = true
			end

			if arg_15_0._lockSpecialSummonDefPosture and not arg_15_1:isStatusValNotSummon() then
				var_15_1 = true
			end

			if arg_15_0._opponent and not arg_15_1:isStatusValNotSummon() and arg_15_1:isMonsterRare() then
				local var_opp_kybaby = #arg_15_0._opponent:getBattleCardsByInfoId("B", 12315) > 0 or arg_15_0._opponent:hasBattleCardsBySkillFast("B", 14639)
				if var_opp_kybaby then
					var_15_1 = true
					var_15_2 = true
					var_15_kybaby = true
					arg_15_0:incNegativeStatus(arg_15_1, {
						BattleData.NegativeType.disablePosture,
						BattleData.NegativeType.cold
					}, false, arg_15_1._id, 14639, Data.SkillMode.once)
					arg_15_0:incNegativeValue(arg_15_1, BattleData.NegativeType.disablePosture, 2, Data.AggregateType.max, arg_15_1._id, 14639, Data.SkillMode.once)
				end

				local var_opp_dragons = arg_15_0._opponent:getBattleCardsByInfoId("B", 12316)
				if #var_opp_dragons > 0 or arg_15_0._opponent:hasBattleCardsBySkillFast("B", 14648) then
					local dmg = (arg_15_0._fortress._hp > 8000) and 400 or 200
					local dragon_id = #var_opp_dragons > 0 and var_opp_dragons[1]._id or 12316
					arg_15_0._opponent:addDamage(arg_15_0._fortress, dmg, dragon_id, 14648, Data.SkillMode.magic)
				end

				local var_opp_kypham = arg_15_0._opponent:getBattleCardsByInfoId("B", 40727)
				if #var_opp_kypham == 0 then
					var_opp_kypham = arg_15_0._opponent:getBattleCardsBySkillFast("B", 14681)
				end
				if #var_opp_kypham > 0 then
					local opp_star = arg_15_1:getStar() or 0
					if opp_star > 0 then
						local heal_amt = opp_star * 100
						local kp_id = var_opp_kypham[1]._id
						arg_15_0._opponent:incHp(arg_15_0._opponent._fortress, heal_amt, false, kp_id, 14681, Data.SkillMode.once, true)
					end
				end

				local var_opp_loioa = arg_15_0._opponent:getBattleCardsByInfoId("B", 12322)
				if #var_opp_loioa == 0 then
					var_opp_loioa = arg_15_0._opponent:getBattleCardsBySkillFast("B", 14695)
				end
				if #var_opp_loioa > 0 and (arg_15_1:isEffectMonster() or (not arg_15_1:isNormalMonster() and arg_15_1:isMonsterRare())) then
					local loioa = var_opp_loioa[1]
					local owner = loioa._owner
					local oppo = owner and owner._opponent
					local turnId = (owner and owner._round or 0) * 1000 + (oppo and oppo._round or 0)
					if loioa._loioaNegateTurn ~= turnId then
						loioa._loioaNegateTurn = turnId
						arg_15_1._mark9617 = true
						arg_15_1._isCardSkillDisabledInRound = true
						if arg_15_1.disableUnderSkills then
							arg_15_1:disableUnderSkills()
						end
						arg_15_0:incNegativeStatus(arg_15_1, {
							BattleData.NegativeType.disableSkill
						}, false, loioa._id, 14695, Data.SkillMode.once)
						arg_15_0:incNegativeValue(arg_15_1, BattleData.NegativeType.disableSkill, 2, Data.AggregateType.max, loioa._id, 14695, Data.SkillMode.once)
					end
				end

				local var_opp_vl = arg_15_0._opponent:getBattleCardsByInfoId("B", 12326)
				if #var_opp_vl == 0 then
					var_opp_vl = arg_15_0._opponent:getBattleCardsBySkillFast("B", 14710)
				end
				if #var_opp_vl > 0 and var_opp_vl[1]:canCastMonsterSkill() then
					local vl = var_opp_vl[1]
					local vl_marks = vl:getBuffValue(true, BattleData.PositiveType.godMark) or 0
					local targetStar = arg_15_1:getStar() or (arg_15_1._info and (type(arg_15_1._info._star) == "table" and arg_15_1._info._star[1] or arg_15_1._info._star)) or 0
					if vl_marks >= 7 and targetStar <= 4 then
						arg_15_1._isRemoveSkill = true
						arg_15_1._skills = {}
					end
				end
			end

				-- Opponent Special Summon triggers (20174, 20180, 20191)
				local isSpSummon2 = (B and B.isSpecialSummon and B.isSpecialSummon(arg_15_1)) or (arg_15_1.isStatusValSpecialSummon and arg_15_1:isStatusValSpecialSummon()) or ((arg_15_1:isMonster() or arg_15_1:isMonsterRare()) and not (arg_15_1.isStatusValNormalSummon and arg_15_1:isStatusValNormalSummon()) and not (arg_15_1.isStatusValNotSummon and arg_15_1:isStatusValNotSummon()))
				if (isSpSummon2 or arg_15_1._destStatusVal == BattleData.CardStatusVal.h2b_normal or arg_15_1._destStatusVal == BattleData.CardStatusVal.p2b_normal or arg_15_1._destStatusVal == BattleData.CardStatusVal.g2b_normal or arg_15_1._destStatusVal == BattleData.CardStatusVal.l2b_normal) then
					local labOppo = arg_15_0._opponent
					if labOppo and (labOppo._castedSkillCounts[20174] or 0) == 0 and #labOppo:getBattleCardsByInfoId("B", 12379) > 0 then
						labOppo._castedSkillCounts[20174] = 1
						arg_15_0:setCardStatus(arg_15_1, BattleData.CardStatus.grave, 12379, 20174, Data.SkillMode.once, BattleData.CardStatusVal.b2g_destroy)
					elseif labOppo and (labOppo._castedSkillCounts[20180] or 0) == 0 and #labOppo:getBattleCardsByInfoId("B", 12380) > 0 then
						labOppo._castedSkillCounts[20180] = 1
						arg_15_0:changeCardStatus(arg_15_1, arg_15_1._status, BattleData.CardStatus.grave, BattleData.CardStatusVal.x2g_oppo, 12380, 20180, Data.SkillMode.once)
					end

					if labOppo and (labOppo._castedSkillCounts[20191] or 0) == 0 and #labOppo:getBattleCardsByInfoId("B", 12381) > 0 then
						if arg_15_1:isMonsterRare() or arg_15_1._status == BattleData.CardStatus.rare or arg_15_1._destStatusVal == BattleData.CardStatusVal.z2b_normal or arg_15_1._statusVal == BattleData.CardStatusVal.z2b_normal or arg_15_1:isStatusValLinkSummon() then
							labOppo._castedSkillCounts[20191] = 1
							arg_15_0:setCardStatus(arg_15_1, BattleData.CardStatus.grave, 12381, 20191, Data.SkillMode.once, BattleData.CardStatusVal.b2g_destroy)
						end
					end
				end

			if arg_15_1._infoId == 12324 or arg_15_1:hasSkillFast(14700) then
				local cur_lp = math.max(0, (arg_15_0._fortress and arg_15_0._fortress._hp) or arg_15_0._hp or 8000)
				arg_15_1._htAtk = cur_lp
				arg_15_1._maxAtk = 0
				arg_15_1._atk = cur_lp
			end

			if arg_15_1._infoId == 12325 or arg_15_1:hasSkillFast(14705) then
				local has_lht = #arg_15_0:getBattleCardsByInfoId("BCSD", 21134) > 0
				if has_lht then
					arg_15_0:incShield(arg_15_1, { 12008, 12009, 12010 }, false, false, arg_15_1._id, 14705, Data.SkillMode.using)
				end
			end
			if arg_15_1._infoId == 12326 or arg_15_1:hasSkillFast(14706) then
				arg_15_0:incShield(arg_15_1, { 12008, 12009, 12010 }, false, false, arg_15_1._id, 14706, Data.SkillMode.using)
				local curGod = arg_15_1:getBuffValue(true, BattleData.PositiveType.godMark) or 0
				if curGod < 9 then
					arg_15_1:addGodMark(1, false, arg_15_1._id, 14706, Data.SkillMode.using)
				end
				local marks = arg_15_1:getBuffValue(true, BattleData.PositiveType.godMark) or 1
				local rate = (marks >= 5) and 600 or 300
				local bonus = marks * rate
				arg_15_1._atk = 2000 + bonus
				arg_15_1._hp = 2800 + bonus
				arg_15_1._maxAtk = 2000
				arg_15_1._maxHp = 2800
			end
			if arg_15_1._infoId == 12327 or arg_15_1:hasSkillFast(14717) then
				arg_15_0:incShield(arg_15_1, { 12008, 12009, 12010 }, false, false, arg_15_1._id, 14717, Data.SkillMode.using)
			end
			if arg_15_1._infoId == 40731 or arg_15_1:hasSkillFast(14727) then
				arg_15_0:incShield(arg_15_1, { 12008, 12009, 12010 }, false, false, arg_15_1._id, 14727, Data.SkillMode.using)
			end
			if arg_15_1._infoId == 40734 or arg_15_1:hasSkillFast(14394) then
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoMonster] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoMagic] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoTrap] = true
				arg_15_0:incShield(arg_15_1, { 12008, 12009, 12010 }, false, false, arg_15_1._id, 12008, Data.SkillMode.using)
			end
			if arg_15_1._infoId == 40736 or arg_15_1:hasSkillFast(14750) then
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoMonster] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoMagic] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoTrap] = true
				arg_15_0:incShield(arg_15_1, { 12008, 12009, 12010 }, false, false, arg_15_1._id, 14750, Data.SkillMode.using)
			end
			if arg_15_1._infoId == 40737 or arg_15_1:hasSkillFast(14754) then
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldExMonster] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldExMagic] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldExTrap] = true
				arg_15_0:incShield(arg_15_1, { 12002, 12003, 12004 }, false, false, arg_15_1._id, 14754, Data.SkillMode.using)
			end
			if arg_15_1._infoId == 40739 or arg_15_1:hasSkillFast(14764) then
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldExMonster] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldExMagic] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldExTrap] = true
				arg_15_0:incShield(arg_15_1, { 12002, 12003, 12004 }, false, false, arg_15_1._id, 14764, Data.SkillMode.using)
			end
			if (arg_15_1:hasSkillFast(12008) or (arg_15_1._info and B.tableContain(arg_15_1._info._skillId, 12008))) and not arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoMonster] then
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoMonster] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoMagic] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoTrap] = true
				arg_15_0:incShield(arg_15_1, { 12008, 12009, 12010 }, false, false, arg_15_1._id, 12008, Data.SkillMode.using)
			end
			if not (arg_15_1:hasSkillFast(12008) or (arg_15_1._info and B.tableContain(arg_15_1._info._skillId, 12008))) and arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoMonster] and (arg_15_1:isKeyword(21) or arg_15_1:isKeyword(204) or (arg_15_1._info and (arg_15_1._info._keyword == 21 or arg_15_1._info._keyword == 204))) then
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoMonster] = false
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoMagic] = false
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldOppoTrap] = false
				arg_15_0:decShield(arg_15_1, { 12008, 12009, 12010 }, false, arg_15_1._id, 12008)
			end
			if (arg_15_1:hasSkillFast(12002) or (arg_15_1._info and B.tableContain(arg_15_1._info._skillId, 12002)) or arg_15_1._infoId == 40745) and not arg_15_1._positiveStatus[BattleData.PositiveType.shieldExMonster] then
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldExMonster] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldExMagic] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldExTrap] = true
				arg_15_0:incShield(arg_15_1, { 12002, 12003, 12004 }, false, false, arg_15_1._id, 12002, Data.SkillMode.using)
			end
			if arg_15_1._infoId == 40730 or arg_15_1:hasSkillFast(14719) then
				if not arg_15_1._tsAwakened then
					arg_15_1._negativeStatus[BattleData.NegativeType.manacle] = true
					arg_15_1._negativeStatus[BattleData.NegativeType.atkFrozen] = true
					arg_15_1._atk = 8000
					arg_15_1._hp = 8000
					arg_15_1._maxAtk = 8000
					arg_15_1._maxHp = 8000
				else
					arg_15_1._negativeStatus[BattleData.NegativeType.manacle] = false
					arg_15_1._negativeStatus[BattleData.NegativeType.atkFrozen] = false
					arg_15_1._atk = 16000
					arg_15_1._hp = 16000
					arg_15_1._maxAtk = 16000
					arg_15_1._maxHp = 16000
				end
			end

			if arg_15_1._infoId == 21134 then
				local donthiens = arg_15_0:getBattleCardsByInfoId("B", 12325)
				for _, dt in ipairs(donthiens) do
					arg_15_0:incShield(dt, { 12008, 12009, 12010 }, false, false, dt._id, 14705, Data.SkillMode.using)
				end
			end

			if arg_15_1._infoId == 40748 or arg_15_1:isInfoId(40748) then
				arg_15_0:incShield(arg_15_1, { 12007 }, false, false, arg_15_1._id, 12007, Data.SkillMode.using)
			end
			if arg_15_1._infoId == 12338 or arg_15_1:isInfoId(12338) then
				arg_15_0:incShield(arg_15_1, { 12007 }, false, false, arg_15_1._id, 12007, Data.SkillMode.using)
			end
			if arg_15_1._infoId == 40535 or arg_15_1:isInfoId(40535) or arg_15_1:hasSkillFast(14771) then
				arg_15_0._has40535OnBoard = true
				local allies = arg_15_0:getBoardCards()
				for _, c in ipairs(allies) do
					if (c:isMonsterRare() or c._type == Data.CardType.monster) and (c:isKeyword(21) or c:isKeyword(204) or (c._info and (c._info._keyword == 21 or c._info._keyword == 204))) then
						if not c._positiveStatus[BattleData.PositiveType.shieldOppoMonster] then
							c._positiveStatus[BattleData.PositiveType.shieldOppoMonster] = true
							c._positiveStatus[BattleData.PositiveType.shieldOppoMagic] = true
							c._positiveStatus[BattleData.PositiveType.shieldOppoTrap] = true
							arg_15_0:incShield(c, { 12008, 12009, 12010 }, false, false, c._id, 12008, Data.SkillMode.using)
						end
					end
				end
			end

			if var_15_4 then
				arg_15_1._negativeStatus[BattleData.NegativeType.atkFrozen] = true
			end

			if var_15_5 then
				arg_15_1._negativeStatus[BattleData.NegativeType.atkFrozenForever] = true
			end

			if var_15_1 and not arg_15_1:isLink() then
				arg_15_1._positiveStatus[BattleData.PositiveType.defendPosture] = true
			end

			if var_15_2 then
				arg_15_1._negativeStatus[BattleData.NegativeType.disablePosture] = true
				if var_15_kybaby then
					arg_15_1._negativeStatus[BattleData.NegativeType.cold] = true
				end
			end

			if var_15_3 then
				arg_15_1._negativeStatus[BattleData.NegativeType.disablePostureEx] = true
			end

		if arg_15_1._statusVal == BattleData.CardStatusVal.g2b_3347 then
				arg_15_0:incAtk(arg_15_1, 500, false, arg_15_1._id, 3347, Data.SkillMode.once)
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.g2b_5170 then
				arg_15_0:incAtk(arg_15_1, Data._skillInfo[5170]._val[1], false, arg_15_1._id, 5170, Data.SkillMode.once)

				arg_15_1._atk = arg_15_1._atk + arg_15_1._atkInc + Data._skillInfo[5170]._val[1]
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.p2b_4139 then
				if arg_15_1._4139Count ~= nil then
					arg_15_0:incAtk(arg_15_1, arg_15_1._4139Count * Data._skillInfo[4139]._val[1], false, arg_15_1._id, 4139, Data.SkillMode.once)
				end
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.g2b_6323 then
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldExTrap] = true
				arg_15_1._underSkills[#arg_15_1._underSkills + 1] = {
					_sid = 6323,
					_value = 65537,
					_removable = true,
					_cid = arg_15_1._triggerCard._id,
					_mode = Data.SkillMode.once,
					_positiveType = BattleData.PositiveType.shieldExTrap,
					_aggregateType = Data.AggregateType.table
				}

				arg_15_1:accountBuffValue(true, BattleData.PositiveType.shieldExTrap)
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.e2b_5224 then
				arg_15_0:incAtk(arg_15_1, arg_15_0._fortress._lastDamage, false, arg_15_1._id, 5224, Data.SkillMode.once)
				arg_15_0:incHp(arg_15_1, arg_15_0._fortress._lastDamage, false, arg_15_1._id, 5224, Data.SkillMode.once)

				arg_15_1._atk = arg_15_1._atk + arg_15_0._fortress._lastDamage
				arg_15_1._hp = arg_15_1._hp + arg_15_0._fortress._lastDamage
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.p2b_5320 then
				arg_15_0:incAtk(arg_15_1, Data._skillInfo[5320]._val[1], false, arg_15_1._id, 5320, Data.SkillMode.once)

				arg_15_1._atk = arg_15_1._atk + Data._skillInfo[5320]._val[1]
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.l2b_2281 then
				arg_15_0:incAtk(arg_15_1, Data._skillInfo[2281]._val[1], false, arg_15_1._id, 2281, Data.SkillMode.once)

				arg_15_1._atk = arg_15_1._atk + arg_15_1._atkInc + Data._skillInfo[2281]._val[1]
			elseif arg_15_1._triggerCard ~= nil and arg_15_1._triggerCard:hasSkillFast(4597) then
				arg_15_0:incAtk(arg_15_1, -math.floor(arg_15_1._maxAtk / 2), false, arg_15_1._id, 4597, Data.SkillMode.once)

				arg_15_1._atk = arg_15_1._atk + arg_15_1._atkInc - math.floor(arg_15_1._maxAtk / 2)
			elseif arg_15_1._statusVal == BattleData.CardStatusVal.g2b_2491 then
				arg_15_0:incAtk(arg_15_1, arg_15_1._maxAtk, false, arg_15_1._id, 2491, Data.SkillMode.once)

				arg_15_1._atk = arg_15_1._atk + arg_15_1._atkInc + arg_15_1._maxAtk
			elseif arg_15_1._mark2532 then
				arg_15_0:incAtk(arg_15_1, arg_15_1._mark2532 * Data._skillInfo[2532]._val[1], false, arg_15_1._id, 2532, Data.SkillMode.once)

				arg_15_1._atk = arg_15_1._atk + arg_15_1._atkInc + arg_15_1._mark2532 * Data._skillInfo[2532]._val[1]
				arg_15_1._mark2532 = nil
			end

			if arg_15_1._mark13991 then
				local var_15_6 = arg_15_1._atk * (1 - 0.5^arg_15_1._mark13991)

				arg_15_0:decAtk(arg_15_1, var_15_6, false, arg_15_1._id, 13991, Data.SkillMode.once)

				arg_15_1._atk = arg_15_1._atk + arg_15_1._atkInc - var_15_6
				arg_15_1._mark13991 = nil
			end

			arg_15_1._mark2207 = nil
			arg_15_1._mark3940_2 = nil
			arg_15_1._mark5249 = nil
			arg_15_1._mark6344 = nil
			arg_15_1._mark6368 = nil
			arg_15_1._mark6578 = nil
			arg_15_1._mark6896 = nil
			arg_15_1._boardCount = arg_15_1._boardCount + 1

			if arg_15_1:isV12() then
				arg_15_1._round3232 = arg_15_1._owner._round + Data._skillInfo[3232]._val[1] - 1
			end

			if arg_15_1:isV13() and arg_15_1._sourceStatus ~= BattleData.CardStatus.board and not arg_15_1:isStatusValNotSummon() then
				arg_15_1._round3273 = arg_15_1._owner._round + 2
			end

			arg_15_1._onBoardRound = arg_15_0._round
			arg_15_1._onBoardEndRound = arg_15_0._endRound
			arg_15_1._onBoardFrom = arg_15_1._sourceStatus
			arg_15_1._dieByAttack = false
			arg_15_1._dieByEffect = false
			arg_15_1._summonByNormal = false
			arg_15_1._summonByMerge = false
			arg_15_1._summonByCeremony = false
			arg_15_1._summonBySync = false
			arg_15_1._summonByXYZ = false
			arg_15_1._summonByLink = false
			arg_15_1._summonByCard = arg_15_1._triggerCard
			arg_15_1._xyzMarkProviders = {}

			if arg_15_1:isStatusValNormalSummon() and arg_15_1._atk >= 2400 and arg_15_1._hp == 1000 and arg_15_0._mark8119 then
				arg_15_1._isRemoveSkill = true
				arg_15_1._mark8119_2 = true
				arg_15_0._mark8119 = nil
			end

			if arg_15_1._isRemoveSkill then
				arg_15_1._skills = {}
			end

			if arg_15_1._saved._addSkills ~= nil then
				for iter_15_0 = 1, #arg_15_1._saved._addSkills do
					arg_15_1:addSkill(arg_15_1._saved._addSkills[iter_15_0], 1, BattleData.SkillProvider.given)
				end

				arg_15_1._saved._addSkills = nil
			end

			if arg_15_1._mark9600_2 then
				arg_15_1:addSkill(Data._skillInfo[9600]._refSkills[1], 1, BattleData.SkillProvider.given)

				arg_15_1._mark9600_2 = nil
			end

			if arg_15_1._saved._addShields ~= nil then
				for iter_15_1 = 1, #arg_15_1._saved._addShields do
					local var_15_7 = arg_15_1._saved._addShields[iter_15_1]

					arg_15_1._positiveStatus[var_15_7] = true
					arg_15_1._underSkills[#arg_15_1._underSkills + 1] = {
						_sid = 0,
						_value = 0,
						_removable = false,
						_cid = 0,
						_mode = Data.SkillMode.once,
						_positiveType = var_15_7,
						_aggregateType = Data.AggregateType.table
					}

					arg_15_1:accountBuffValue(true, var_15_7)
				end
			end

			if arg_15_1._saved._addSingleRoundShields ~= nil then
				for iter_15_2 = 1, #arg_15_1._saved._addSingleRoundShields do
					local var_15_8 = arg_15_1._saved._addSingleRoundShields[iter_15_2]

					arg_15_1._positiveStatus[var_15_8] = true
					arg_15_1._underSkills[#arg_15_1._underSkills + 1] = {
						_sid = 0,
						_value = 65537,
						_removable = true,
						_cid = 0,
						_mode = Data.SkillMode.once,
						_positiveType = var_15_8,
						_aggregateType = Data.AggregateType.table
					}

					arg_15_1:accountBuffValue(true, var_15_8)
				end
			end

			if arg_15_1._saved._addAtk ~= nil then
				arg_15_0:incAtk(arg_15_1, arg_15_1._saved._addAtk, false, arg_15_1._id, 0, Data.SkillMode.once)

				arg_15_1._atk = math.max(0, arg_15_1._atk + arg_15_1._atkInc + arg_15_1._saved._addAtk)
				arg_15_1._saved._addAtk = nil
			end

			if arg_15_1._saved._addHp ~= nil then
				arg_15_0:incHp(arg_15_1, arg_15_1._saved._addHp, false, arg_15_1._id, 0, Data.SkillMode.once)

				arg_15_1._hp = arg_15_1._hp + arg_15_1._hpInc + arg_15_1._saved._addHp
				arg_15_1._saved._addHp = nil
			end

			if arg_15_1._saved._isDisabelBoardSkill then
				arg_15_0:incNegativeStatus(arg_15_1, {
					BattleData.NegativeType.boardMonsterSkillFrozen
				}, false, arg_15_1._id, 0, Data.SkillMode.once)

				arg_15_1._saved._isDisabelBoardSkill = nil
			end

			if arg_15_1._statusVal == BattleData.CardStatusVal.g2b_3337 then
				arg_15_1._skills[1] = B.createSkill(Data._skillInfo[3337]._refSkills[1], 1, arg_15_1)
			end

			if arg_15_1._saved._addNewLive1 then
				arg_15_1._isNewLive1 = true
			end

			if arg_15_1._saved._addNewLive2 then
				arg_15_1._isNewLive2 = true
			end

			if not arg_15_1:isStatusValNotSummon() then
				local var_15_9 = (arg_15_1._statusVal == BattleData.CardStatusVal.h2b_oppo_normal or arg_15_1._statusVal == BattleData.CardStatusVal.h2b_oppo_special) and arg_15_0._opponent or arg_15_0

				var_15_9._isSummoned = true
				var_15_9._summonedMonsterStar[#var_15_9._summonedMonsterStar + 1] = arg_15_1:getStar()
				var_15_9._summonedMonsterAtk[#var_15_9._summonedMonsterAtk + 1] = arg_15_1._atk
				var_15_9._summonedMonsterDef[#var_15_9._summonedMonsterDef + 1] = arg_15_1._hp

				if arg_15_1._type == Data.CardType.rare and arg_15_1._sourceStatus == BattleData.CardStatus.rare then
					var_15_9._isSummonedFromRare = true
					var_15_9._totalRareSummonCount = var_15_9._totalRareSummonCount + 1
					var_15_9._rareSummonCountInRound = var_15_9._rareSummonCountInRound + 1

					if arg_15_1:isStatusValComposeSummon() then
						var_15_9._isSummonedByMerge = true
						var_15_9._totalComposeSummonCount = var_15_9._totalComposeSummonCount + 1
					elseif arg_15_1:isStatusValSyncSummon() then
						var_15_9._isSummonedBySync = true
					elseif arg_15_1:isStatusValXYZSummon() then
						var_15_9._isSummonedByXYZ = true
					elseif arg_15_1:isStatusValLinkSummon() then
						var_15_9._isSummonedByLink = true
					end
				end

				if arg_15_1:isStatusValCeremonySummon() then
					var_15_9._isSummonedByCeremony = true
				end

				var_15_9._summonedMonsterCounts[arg_15_1._infoId] = (var_15_9._summonedMonsterCounts[arg_15_1._infoId] or 0) + 1

				if not arg_15_1:isStatusValNormalSummon() then
					arg_15_1._summonByMerge = arg_15_1:isStatusValComposeSummon()
					arg_15_1._summonByCeremony = arg_15_1:isStatusValCeremonySummon()
					arg_15_1._summonBySync = arg_15_1:isStatusValSyncSummon()
					arg_15_1._summonByXYZ = arg_15_1:isStatusValXYZSummon()
					arg_15_1._summonByLink = arg_15_1:isStatusValLinkSummon()

					if not arg_15_1._summonBySync then
						var_15_9._isSummonedNotFromSync = true
					end

					if var_15_9._mark13790 then
						local var_15_10 = arg_15_1:getRareOption()

						if var_15_10 ~= nil then
							var_15_9._mark13790[var_15_10] = (var_15_9._mark13790[var_15_10] or 0) + 1
						end
					end

					var_15_9._isSpecialSummoned = true
					var_15_9._isSpecialSummonedInRound[var_15_9._round] = true
					var_15_9._specialSummonedCards[#var_15_9._specialSummonedCards + 1] = arg_15_1
					var_15_9._specialSummonedMonsterIdCountsInRound[arg_15_1._id] = (var_15_9._specialSummonedMonsterIdCountsInRound[arg_15_1._id] or 0) + 1
					var_15_9._specialSummonedMonsterInfoIdCountsInRound[Data.getOriginId(arg_15_1._infoId)] = (var_15_9._specialSummonedMonsterInfoIdCountsInRound[Data.getOriginId(arg_15_1._infoId)] or 0) + 1
					var_15_9._totalSpecialSummonedMonsterCount = var_15_9._totalSpecialSummonedMonsterCount + 1
				else
					arg_15_1._summonByNormal = true

					if arg_15_1._triggerCard == nil or not arg_15_1._triggerCard:hasSkillFast(3687) and not arg_15_1._triggerCard:hasSkillFast(5527) and not arg_15_1._triggerCard:hasSkillFast(13463) and not arg_15_1._triggerCard:hasSkillFast(13464) then
						var_15_9._normalSummonedCards[#var_15_9._normalSummonedCards + 1] = arg_15_1
					end

					var_15_9._isNormalSummoned = true
					var_15_9._isNormalSummonedInRound[var_15_9._round] = true

					if arg_15_1:getStar() <= 4 then
						var_15_9._totalNormalSummonedMonsterCount4 = var_15_9._totalNormalSummonedMonsterCount4 + 1
					else
						var_15_9._totalNormalSummonedMonsterCount5 = var_15_9._totalNormalSummonedMonsterCount5 + 1
					end
				end

				if arg_15_1._statusVal ~= BattleData.CardStatusVal.r2b_compose and arg_15_1._statusVal ~= BattleData.CardStatusVal.r2b_compose_ex and arg_15_1._statusVal ~= BattleData.CardStatusVal.r2b_2244 then
					arg_15_1._mergeComponents = nil
				elseif arg_15_1._statusVal ~= BattleData.CardStatusVal.r2b_2244 then
					arg_15_1._summonedByMerge = true
				end

				if not arg_15_1:isStatusValSyncSummon() then
					arg_15_1._syncComponents = nil
				else
					arg_15_1._summonedBySync = true

					if arg_15_1._mark3940 then
						arg_15_1._mark3940 = nil
						arg_15_1._mark3940_2 = true
					end
				end

				if not arg_15_1:isStatusValXYZSummon() then
					arg_15_1._xyzComponents = nil
					arg_15_1._xyzSkillId = nil
				else
					arg_15_1._summonedByXYZ = true
				end

				if not arg_15_1:isStatusValLinkSummon() then
					arg_15_1._linkComponents = nil
					arg_15_1._linkSkillId = nil
				else
					arg_15_1._summonedByLink = true
				end

				B._mark5532 = nil
			end

			if arg_15_1:isLink() then
				arg_15_0:refreshLinkPos()
			end
		else
			arg_15_1._destStatus = BattleData.CardStatus.grave

			arg_15_0:addCardToGrave(arg_15_1)

			return
		end
	end

	arg_15_1._status = BattleData.CardStatus.board

	if not arg_15_1._isBorrowed then
		lc.clearTable(arg_15_1._saved)
	end

	-- Labrynth Labyrinth (21173 / 20214): Khi co mat: Quai Labrynth len san nhan Khien Chan Quai/Phep/Bay va tang 300 tan cong
	if (arg_15_1:isKeyword(308) or (arg_15_1._info and arg_15_1._info._keyword == 308)) then
		local var_owner = arg_15_1._owner or arg_15_0
		local hasLab21173 = false
		if var_owner then
			if var_owner._fieldCard and (var_owner._fieldCard:isInfoId(21173) or var_owner._fieldCard._infoId == 21173 or var_owner._fieldCard:hasSkillFast(20214)) then
				hasLab21173 = true
			end
			if not hasLab21173 and var_owner._magicCards then
				for _, mc in ipairs(var_owner._magicCards) do
					if mc and (mc:isInfoId(21173) or mc._infoId == 21173 or mc:hasSkillFast(20214)) then
						hasLab21173 = true
						break
					end
				end
			end
			if not hasLab21173 and var_owner.getBattleCards then
				for _, sc in ipairs(var_owner:getBattleCards("C")) do
					if sc and (sc:isInfoId(21173) or sc._infoId == 21173 or sc:hasSkillFast(20214)) then
						hasLab21173 = true
						break
					end
				end
				if not hasLab21173 then
					for _, sc in ipairs(var_owner:getBattleCards("S")) do
						if sc and (sc:isInfoId(21173) or sc._infoId == 21173 or sc:hasSkillFast(20214)) then
							hasLab21173 = true
							break
						end
					end
				end
			end
		end

		if hasLab21173 then
			-- Tang 300 ATK
			arg_15_1._atk = (arg_15_1._atk or arg_15_1._maxAtk or 0) + 300
			arg_15_1._maxAtk = (arg_15_1._maxAtk or 0) + 300
			arg_15_0:incPositiveStatus(arg_15_1, { BattleData.PositiveType.extraAtk }, false, 21173, 20214, Data.SkillMode.using)
			arg_15_0:incPositiveValue(arg_15_1, BattleData.PositiveType.extraAtk, 300, Data.AggregateType.sum, 21173, 20214, Data.SkillMode.using)

			-- Nhan Khien Chan Quai / Phep / Bay
			arg_15_0:incPositiveStatus(arg_15_1, {
				BattleData.PositiveType.shieldMonster,
				BattleData.PositiveType.shieldMagic,
				BattleData.PositiveType.shieldTrap
			}, true, 21173, 20214, Data.SkillMode.using)
			if arg_15_1._positiveStatus then
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldMonster] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldMagic] = true
				arg_15_1._positiveStatus[BattleData.PositiveType.shieldTrap] = true
			end
		end
	end

	if arg_15_1:isInfoId(40748) or arg_15_1._infoId == 40748 or B.isWitherOnField(arg_15_0) then
		if arg_15_0.updateWitherDebuff then
			arg_15_0:updateWitherDebuff()
		end
	end

	if arg_15_1._infoId == 40733 or arg_15_1:hasSkillFast(14737) then
		arg_15_1._mark14737Triggered = nil
	end

	local var_owner = arg_15_1._owner or arg_15_0
	if arg_15_1._infoId == 10120 then
		local var_amazon_monsters = B.filterInTypeCards(var_owner:getBattleCardsByKeyword("B", 6), Data.CardType.monster)
		local var_destroy_count = #var_amazon_monsters
		if var_destroy_count > 0 then
			local var_oppo_st = var_owner._opponent:getBattleCards("CSD")
			if #var_oppo_st > 0 then
				local var_pool = {}
				for iter_p = 1, #var_oppo_st do
					var_pool[iter_p] = var_oppo_st[iter_p]
				end
				local var_n = math.min(#var_pool, var_destroy_count)
				for iter_d = 1, var_n do
					local var_chosen_card, var_chosen_idx = var_owner:randomOne(var_pool)
					if var_chosen_card ~= nil then
						table.remove(var_pool, var_chosen_idx)
						var_owner:changeCardStatus(var_chosen_card, var_chosen_card._status, BattleData.CardStatus.grave, nil, arg_15_1)
					end
				end
				var_owner:account()
			end
		end
	end

	if arg_15_1._type == Data.CardType.monster and arg_15_1:isKeyword(8) then
		local var_mdkh_cards = var_owner:getBattleCardsByInfoId("S", 30124)
		if #var_mdkh_cards > 0 then
			local var_burn_amount = 200 * #var_mdkh_cards
			var_owner._opponent:addDamage(var_owner._opponent._fortress, var_owner._opponent:calcFortressDamage(var_burn_amount), var_mdkh_cards[1], 8038, Data.SkillMode.using)
			var_owner:account()
		end
	end

	if arg_15_0._opponent and arg_15_1:isMonsterRare() and not arg_15_1:isStatusValNotSummon() then
		local var_opp_vl = arg_15_0._opponent:getBattleCardsByInfoId("B", 12326)
		if #var_opp_vl == 0 then
			var_opp_vl = arg_15_0._opponent:getBattleCardsBySkillFast("B", 14710)
		end
		if #var_opp_vl > 0 and var_opp_vl[1]:canCastMonsterSkill() then
			local vl = var_opp_vl[1]
			local vl_marks = vl:getBuffValue(true, BattleData.PositiveType.godMark) or 0
			local targetAtk = arg_15_1._atk or arg_15_1._maxAtk or (arg_15_1._info and (type(arg_15_1._info._atk) == "table" and arg_15_1._info._atk[arg_15_1._level or 1] or arg_15_1._info._atk)) or 0
			if vl_marks >= 9 and targetAtk <= 2000 then
				arg_15_0:changeCardStatus(arg_15_1, BattleData.CardStatus.board, BattleData.CardStatus.grave, BattleData.CardStatusVal.b2g_skill, vl)
				arg_15_0:account()
			end
		end
	end

	-- Piglin Rider (40754 / 13779) / Hat oc cho (12392): Nhan hieu ung Khieu khich (irony) khi len san
	if arg_15_1._infoId == 40754 or arg_15_1._infoId == 12392 or arg_15_1:hasSkillFast(13779) then
		arg_15_0:incPositiveStatus(arg_15_1, { BattleData.PositiveType.irony }, true, arg_15_1._id, 13779, Data.SkillMode.using)
		arg_15_0:incPositiveValue(arg_15_1, BattleData.PositiveType.irony, 0, Data.AggregateType.max, arg_15_1._id, 13779, Data.SkillMode.using)
	end

	-- Warden (12345 / 14814): 1 luot 1 lan, khi doi phuong trieu hoi quai lan 3 trong luot, Warden tren tay kich hoat: dac biet len san, day quai vua trieu hoi ve tay
	if not arg_15_1:isStatusValNotSummon() and not arg_15_1._summonedByWarden14814 and (arg_15_1:isMonster() or arg_15_1:isMonsterRare() or arg_15_1._type == Data.CardType.monster or arg_15_1._type == Data.CardType.rare) then
		local actP = arg_15_0:getActionPlayer() or arg_15_0
		local turnId = (actP._round or 0) * 1000 + (actP._opponent and actP._opponent._round or 0)
		if arg_15_0._turnSummonRoundId ~= turnId then
			arg_15_0._turnSummonRoundId = turnId
			arg_15_0._turnSummonCount = 0
		end
		arg_15_0._turnSummonCount = (arg_15_0._turnSummonCount or 0) + 1

		if arg_15_0._turnSummonCount >= 3 then
			local oppo = arg_15_0._opponent
			if oppo and oppo._wardenHandTriggerTurn ~= turnId and not oppo._isSummonDisabled and not oppo._isSpecialSummonDisabled then
				local wardenCard = nil
				for _, c in ipairs(oppo._handCards) do
					if (c:isInfoId(12345) or c._infoId == 12345) and c:canCastMonsterSkill() then
						wardenCard = c
						break
					end
				end
				if wardenCard then
					local emptyPos = oppo:getEmptyBoardPos(wardenCard)
					if emptyPos ~= nil then
						oppo._wardenHandTriggerTurn = turnId
						wardenCard._saved._pos = emptyPos
						wardenCard._summonedByWarden14814 = true
						oppo:changeCardStatus(wardenCard, BattleData.CardStatus.hand, BattleData.CardStatus.board, BattleData.CardStatusVal.h2b_special, wardenCard)

						if arg_15_1._status == BattleData.CardStatus.board or arg_15_1._pos ~= nil then
							local destStatus = (arg_15_1._type == Data.CardType.rare or arg_15_1._sourceStatus == BattleData.CardStatus.rare) and BattleData.CardStatus.rare or BattleData.CardStatus.hand
							local sVal = (arg_15_1._owner ~= arg_15_1._originOwner) and BattleData.CardStatusVal.b2h_oppo or nil
							arg_15_0:changeCardStatus(arg_15_1, BattleData.CardStatus.board, destStatus, sVal, wardenCard)
						end
					end
				end
			end
		end
	end
	arg_15_1._summonedByWarden14814 = nil

	-- Shin - Ăn vạ (12370 / 20132): khi lá bài này trên sân, phe ta nhận 2000 LP
	if arg_15_1:isInfoId(12370) or arg_15_1._infoId == 12370 then
		local boardOwner = arg_15_1._owner or arg_15_0
		if boardOwner and boardOwner._fortress then
			boardOwner:incHp(boardOwner._fortress, 2000, false, arg_15_1._id, 20132, Data.SkillMode.using)
		end
	end

	-- LABRYNTH KNIGHT (12376 / 20151): Khi lên sân, tăng ATK bằng tổng số quái "Labrynth" trong mộ và mộ bài loại bỏ phe ta x300
	if arg_15_1:isInfoId(12376) or arg_15_1._infoId == 12376 or arg_15_1:hasSkillFast(20151) then
		local boardOwner = arg_15_1._owner or arg_15_0
		if boardOwner then
			local labCount = 0
			for _, c in ipairs(boardOwner:getBattleCards("GL")) do
				if (c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare) and (c:isKeyword(308) or (c._info and c._info._keyword == 308)) then
					labCount = labCount + 1
				end
			end
			if labCount > 0 then
				boardOwner:incAtk(arg_15_1, labCount * 300, false, arg_15_1._id, 20151, Data.SkillMode.entering)
			end
		end
	end

	-- LABRYNTH KNIGHT (12376 / 20150): Khi có mặt, quái 8 sao có từ khóa "Labrynth" phe ta khi lên sân không bị ảnh hưởng bởi Phép/Bẫy đối thủ
	if (arg_15_1:isMonster() or arg_15_1:isMonsterRare() or arg_15_1._type == Data.CardType.monster or arg_15_1._type == Data.CardType.rare) and (arg_15_1:isKeyword(308) or (arg_15_1._info and arg_15_1._info._keyword == 308)) and arg_15_1:getStar() == 8 then
		local boardOwner = arg_15_1._owner or arg_15_0
		if boardOwner and #boardOwner:getBattleCardsByInfoId("B", 12376) > 0 then
			arg_15_1._labKnightShieldProtected = true
			boardOwner:incPositiveStatus(arg_15_1, { BattleData.PositiveType.extraSkill }, false, arg_15_1._id, 20150, Data.SkillMode.entering)
			boardOwner:incPositiveValue(arg_15_1, BattleData.PositiveType.extraSkill, 65536 + 12009, Data.AggregateType.table, arg_15_1._id, 20150, Data.SkillMode.entering)
			boardOwner:incPositiveValue(arg_15_1, BattleData.PositiveType.extraSkill, 65536 + 12010, Data.AggregateType.table, arg_15_1._id, 20150, Data.SkillMode.entering)
		end
	end

	-- Shin - Ngại ngùng (12369 / 20127): 1 lượt 1 lần, khi đối phương triệu hồi quái lên sân, đẩy lá bài đối phương vừa triệu hồi lên sân về tay, triệu hồi đặc biệt lá bài này lên sân đối phương.
	if not arg_15_1:isStatusValNotSummon() and (arg_15_1:isMonster() or arg_15_1:isMonsterRare() or arg_15_1._type == Data.CardType.monster or arg_15_1._type == Data.CardType.rare) and arg_15_1._statusVal ~= BattleData.CardStatusVal.h2b_oppo_special and not (arg_15_1:isKeyword(307) or (arg_15_1._info and arg_15_1._info._keyword == 307)) then
		local turnId = (arg_15_0._round or 0) * 1000 + (arg_15_0._opponent and arg_15_0._opponent._round or 0)
		local oppo = arg_15_0._opponent
		if oppo and oppo._castedShinNgaiNgungTurn ~= turnId and not oppo._isSummonDisabled and not oppo._isSpecialSummonDisabled then
			local ngaiCard = nil
			for _, c in ipairs(oppo._handCards or {}) do
				if (c:isInfoId(12369) or c._infoId == 12369) and c._status == BattleData.CardStatus.hand then
					ngaiCard = c
					break
				end
			end
			if ngaiCard and (arg_15_1._status == BattleData.CardStatus.board or arg_15_1._pos ~= nil) then
				oppo._castedShinNgaiNgungTurn = turnId
				oppo._castedSkillCounts[20127] = 1
				local destStatus = (arg_15_1._type == Data.CardType.rare or (arg_15_1:isMonsterRare() and arg_15_1._sourceStatus == BattleData.CardStatus.rare)) and BattleData.CardStatus.rare or BattleData.CardStatus.hand
				local sVal = (arg_15_1._owner ~= arg_15_1._originOwner) and BattleData.CardStatusVal.b2h_oppo or nil
				arg_15_0:changeCardStatus(arg_15_1, BattleData.CardStatus.board, destStatus, sVal, ngaiCard)
				oppo:changeCardStatus(ngaiCard, BattleData.CardStatus.hand, BattleData.CardStatus.board, BattleData.CardStatusVal.h2b_oppo_special, ngaiCard)
				arg_15_0:battleLog("[BATTLE] Shin - Ngai ngung (12369) bounced summoned monster %d and summoned to opponent board!", arg_15_1._infoId)
			end
		end
	end

	-- Piglin Rider (40754 / 14830): 1 luot 1 lan, doi phuong trieu hoi dac biet quai se kich hoat, bo 1 chi thi xyz, day quai doi phuong ve lai bo bai.
	if not arg_15_1:isStatusValNotSummon() and not arg_15_1:isStatusValNormalSummon() and (arg_15_1:isMonster() or arg_15_1:isMonsterRare() or arg_15_1._type == Data.CardType.monster or arg_15_1._type == Data.CardType.rare) then
		local actP = arg_15_0:getActionPlayer() or arg_15_0
		local turnId = (actP._round or 0) * 1000 + (actP._opponent and actP._opponent._round or 0)
		local oppo = arg_15_0._opponent
		if oppo then
			for _, piglin in ipairs(oppo:getBoardCards()) do
				if (piglin:isInfoId(40754) or piglin:hasSkillFast(14830)) and piglin:canCastMonsterSkill() and piglin._piglinRiderTriggerTurn ~= turnId then
					local marks = (piglin:getBuffValue(true, BattleData.PositiveType.xyzMark) or 0) + (piglin:getBuffValue(true, BattleData.PositiveType.godMark) or 0)
					if marks >= 1 and (arg_15_1._status == BattleData.CardStatus.board or arg_15_1._pos ~= nil) then
						piglin._piglinRiderTriggerTurn = turnId
						oppo._castedSkillCounts[14830] = 1
						if (piglin:getBuffValue(true, BattleData.PositiveType.xyzMark) or 0) >= 1 then
							piglin:removeMark(BattleData.PositiveType.xyzMark, 1)
							piglin:accountBuffValue(true, BattleData.PositiveType.xyzMark)
						else
							piglin:removeMark(BattleData.PositiveType.godMark, 1)
							piglin:accountBuffValue(true, BattleData.PositiveType.godMark)
						end
						
						local targetDest = (arg_15_1._type == Data.CardType.rare or arg_15_1._sourceStatus == BattleData.CardStatus.rare) and BattleData.CardStatus.rare or BattleData.CardStatus.pile
						local sVal = (arg_15_1._owner ~= arg_15_1._originOwner) and BattleData.CardStatusVal.b2p_oppo or nil
						arg_15_0:changeCardStatus(arg_15_1, BattleData.CardStatus.board, targetDest, sVal, piglin)
						break
					end
				end
			end
		end
	end

	-- Dimensional Barrier (30598 / 20117): Khi quái đối thủ triệu hồi 1 trong 4 loại này: Nghi thức, Dung hợp, Đồng bộ hoặc XYZ sẽ kích hoạt.
	-- Trong phần còn lại của lượt này, cả hai người chơi không thể Triệu Hồi Đặc Biệt quái thú thuộc loại đã được kích hoạt, đồng thời vô hiệu hóa hiệu ứng của tất cả quái vật thuộc loại đó khi chúng đang ở trên sân.
	if not arg_15_1:isStatusValNotSummon() and (arg_15_1:isMonster() or arg_15_1:isMonsterRare() or arg_15_1._type == Data.CardType.monster or arg_15_1._type == Data.CardType.rare) then
		local isCeremony = arg_15_1:isCeremonyMonster() or (arg_15_1._info and (arg_15_1._info._option == 7 or arg_15_1._info._category == 7)) or (arg_15_1.hasMonsterOption and arg_15_1:hasMonsterOption(Data.MonsterOption.is_ceremony))
		local isMerge = arg_15_1:isMerge() or (arg_15_1._info and (arg_15_1._info._option == 6 or arg_15_1._info._category == 6)) or (arg_15_1.hasMonsterOption and arg_15_1:hasMonsterOption(Data.MonsterOption.is_merge))
		local isSync = arg_15_1:isSync() or (arg_15_1._info and (arg_15_1._info._option == 5 or arg_15_1._info._category == 5)) or (arg_15_1.hasMonsterOption and arg_15_1:hasMonsterOption(Data.MonsterOption.is_sync))
		local isXYZ = arg_15_1:isXYZ() or (arg_15_1._info and (arg_15_1._info._option == 8 or arg_15_1._info._category == 8)) or (arg_15_1.hasMonsterOption and arg_15_1:hasMonsterOption(Data.MonsterOption.is_xyz))

		local monType = nil
		local monTypeName = ""
		if isCeremony then
			monType = 1
			monTypeName = "Nghi Thức"
		elseif isMerge then
			monType = 2
			monTypeName = "Dung Hợp"
		elseif isSync then
			monType = 3
			monTypeName = "Đồng Bộ"
		elseif isXYZ then
			monType = 4
			monTypeName = "XYZ"
		end

		local monOwner = arg_15_1._owner or arg_15_0
		local oppo = monOwner and monOwner._opponent

		-- Neu Dimensional Barrier da duoc kich hoat truoc do trong luot nay, lap tuc dong bang quai moi vao san neu cung loai
		if monType and monOwner and monOwner._roundDimBarrierType == monType then
			monOwner:incNegativeStatus(arg_15_1, { BattleData.NegativeType.boardMonsterSkillFrozen }, false, 30598, 20117, Data.SkillMode.using)
		end

		if monType and oppo and not oppo._isTrapSkillDisabled and not oppo._isMagicTrapDisabled then
			local actP = arg_15_0:getActionPlayer() or arg_15_0
			local turnId = (actP._round or 0) * 1000 + (actP._opponent and actP._opponent._round or 0)
			if oppo._dbarrierTriggerTurn ~= turnId and (oppo._castedSkillCounts[20117] or 0) == 0 then
				local dBarrierCard = nil
				for _, c in ipairs(oppo:getBattleCards("CS")) do
					if (c:isInfoId(30598) or c._infoId == 30598 or c:hasSkillFast(20117)) and (c._status == BattleData.CardStatus.cover or c._status == BattleData.CardStatus.magic or c._status == BattleData.CardStatus.trap) then
						dBarrierCard = c
						break
					end
				end
				-- Dimensional Barrier (30598): Chi kich hoat tu the bai UP tren san (cover), khong kich hoat tu tay!

				if dBarrierCard then
					oppo._dbarrierTriggerTurn = turnId
					oppo._castedSkillCounts[20117] = 1
					oppo._roundDimBarrierType = monType
					monOwner._roundDimBarrierType = monType

					local prevStatus = dBarrierCard._status
					local sVal = (prevStatus == BattleData.CardStatus.hand) and BattleData.CardStatusVal.h2gl_normal or BattleData.CardStatusVal.x2gl_cost
					oppo:changeCardStatus(dBarrierCard, prevStatus, BattleData.CardStatus.grave, sVal, dBarrierCard)
					oppo:account()

					monOwner:incNegativeStatus(arg_15_1, { BattleData.NegativeType.boardMonsterSkillFrozen }, false, 30598, 20117, Data.SkillMode.using)

					for _, p in ipairs({ monOwner, oppo }) do
						if p then
							for _, m in ipairs(p:getBoardCards()) do
								local match = (monType == 1 and (m:isCeremonyMonster() or (m.isCeremony and m:isCeremony()) or (m._info and (m._info._option == 7 or m._info._category == 7)) or (m.hasMonsterOption and m:hasMonsterOption(Data.MonsterOption.is_ceremony))))
									or (monType == 2 and (m:isMerge() or (m._info and (m._info._option == 6 or m._info._category == 6)) or (m.hasMonsterOption and m:hasMonsterOption(Data.MonsterOption.is_merge))))
									or (monType == 3 and (m:isSync() or (m._info and (m._info._option == 5 or m._info._category == 5)) or (m.hasMonsterOption and m:hasMonsterOption(Data.MonsterOption.is_sync))))
									or (monType == 4 and (m:isXYZ() or (m._info and (m._info._option == 8 or m._info._category == 8)) or (m.hasMonsterOption and m:hasMonsterOption(Data.MonsterOption.is_xyz))))
								if match then
									p:incNegativeStatus(m, { BattleData.NegativeType.boardMonsterSkillFrozen }, false, 30598, 20117, Data.SkillMode.using)
								end
							end
							p:account()
						end
					end
					arg_15_0:battleLog("[BATTLE] Dimensional Barrier (30598) kich hoat khi doi phuong trieu hoi quai %s! Vo hieu hoa toan bo quai %s va cam Trieu Hoi Dac Biet trong luot nay.", monTypeName, monTypeName)
				end
			end
		end
	end

	-- Goku Ultra Instinct (40773 / 20084, 20085): Khi len san
	local isGokuUI = (arg_15_1._infoId == 40773 or (arg_15_1._info and arg_15_1._info._id == 40773) or arg_15_1:hasSkillFast(20084))
	if isGokuUI and arg_15_1._status == BattleData.CardStatus.board and not arg_15_1._gokuUi20084Done then
		arg_15_1._gokuUi20084Done = true
		local pOwner = arg_15_1._owner or arg_15_0
		local oppo = pOwner and pOwner._opponent
		if oppo then
			oppo._milledBy40773 = true
			local movedPileRare = {}
			-- 20084: Dua tat ca bai tren tay, tren san, bo bai chinh va bo bai phu cua doi thu vao mo
			if oppo._pileCards then
				while #oppo._pileCards > 0 do
					local c = table.remove(oppo._pileCards, 1)
					if c.saveAndReset then pcall(function() c:saveAndReset() end) end
					c._status = BattleData.CardStatus.grave
					c._statusVal = BattleData.CardStatusVal.p2g_drop
					oppo:addCardToGrave(c)
					table.insert(movedPileRare, c)
				end
			end
			if oppo._rareCards then
				while #oppo._rareCards > 0 do
					local c = table.remove(oppo._rareCards, 1)
					if c.saveAndReset then pcall(function() c:saveAndReset() end) end
					c._status = BattleData.CardStatus.grave
					c._statusVal = BattleData.CardStatusVal.p2g_drop
					oppo:addCardToGrave(c)
					table.insert(movedPileRare, c)
				end
			end

			-- Sync client UI sprites for directly moved pile/rare cards so grave triggers never nil-crash
			if oppo._isClient and #movedPileRare > 0 then
				pcall(function()
					local bUi = B._currentBattleUi or (lc and lc._runningScene and lc._runningScene._battleUi)
					local oppoUi = bUi and (bUi._player == oppo and bUi._playerUi or (bUi._opponent == oppo and bUi._opponentUi or nil))
					if oppoUi then
						for _, c in ipairs(movedPileRare) do
							local spr = oppoUi:getCardSprite(c) or oppoUi:createCardSprite(c, false)
							if spr then
								if oppoUi._pRareCards then
									for ri = #oppoUi._pRareCards, 1, -1 do
										if oppoUi._pRareCards[ri] == spr then
											table.remove(oppoUi._pRareCards, ri)
										end
									end
								end
								if c._status == BattleData.CardStatus.grave and oppoUi.addGraveCard then
									oppoUi:addGraveCard(spr)
								else
									spr:setVisible(false)
								end
							end
						end
						if oppoUi.updateRareArea then oppoUi:updateRareArea() end
						if oppoUi.updateGraveArea then oppoUi:updateGraveArea() end
						if oppoUi.sendEvent and PlayerUi and PlayerUi.EventType then
							oppoUi:sendEvent(PlayerUi.EventType.update_card_pile_count)
						end
					end
				end)
			end

			local targets = {}
			if oppo._boardCards then
				for i = 1, Data.MAX_CARD_COUNT_ON_BOARD do
					local c = oppo._boardCards[i]
					if c and c ~= arg_15_1 and c._status == BattleData.CardStatus.board then
						table.insert(targets, c)
					end
				end
			end
			if oppo._coverCards then
				for i = 1, #oppo._coverCards do
					local c = oppo._coverCards[i]
					if c then table.insert(targets, c) end
				end
			end
			if oppo._showCards then
				for i = 1, #oppo._showCards do
					local c = oppo._showCards[i]
					if c then table.insert(targets, c) end
				end
			end
			if oppo._fieldCard then
				table.insert(targets, oppo._fieldCard)
			end
			if oppo._handCards then
				for i = 1, #oppo._handCards do
					local c = oppo._handCards[i]
					if c then table.insert(targets, c) end
				end
			end

			for _, c in ipairs(targets) do
				pcall(function()
					if c.removeShieldInType then
						c:removeShieldInType(BattleData.ShieldType.shieldMonster)
						c:removeShieldInType(BattleData.ShieldType.shieldAll)
						c:removeShieldInType(BattleData.ShieldType.shieldMagic)
						c:removeShieldInType(BattleData.ShieldType.shieldTrap)
					end
					if c.removeUnderSkillsById then
						c:removeUnderSkillsById(12008)
						c:removeUnderSkillsById(12009)
						c:removeUnderSkillsById(12010)
						c:removeUnderSkillsById(12006)
						c:removeUnderSkillsById(3043)
					end
				end)
				oppo:changeCardStatus(c, c._status, BattleData.CardStatus.grave, BattleData.CardStatusVal.b2g_oppo_sacrifice, nil)
			end

			-- 20085: Phong toa toan bo 5 o quai thu cua doi phuong (truoc khi account de xu ly _underSkills dong bo)
			if oppo._fortress then
				pOwner:incNegativeStatus(oppo._fortress, {
					BattleData.NegativeType.boardLock
				}, false, arg_15_1._id, 20085, Data.SkillMode.using)
				for pos = 1, 5 do
					pOwner:incNegativeValue(oppo._fortress, BattleData.NegativeType.boardLock, pos, Data.AggregateType.table, arg_15_1._id, 20085, Data.SkillMode.using)
				end
			end
			oppo._isSummonDisabled = true
			oppo._isSpecialSummonDisabled = true

			oppo:account()
			pOwner:account()

			if oppo._isClient then
				pcall(function()
					local bUi = B._currentBattleUi or (lc and lc._runningScene and lc._runningScene._battleUi)
					local oppoUi = bUi and (bUi._player == oppo and bUi._playerUi or (bUi._opponent == oppo and bUi._opponentUi or nil))
					if oppoUi and oppoUi.updateBoardLocks then
						oppoUi:updateBoardLocks()
					end
				end)
			end
		end
	end

	-- Goku SSJ Blue (40772 / 20082, 20083): Khi len san
	local isGokuBlue = (arg_15_1._infoId == 40772 or (arg_15_1._info and arg_15_1._info._id == 40772) or arg_15_1:hasSkillFast(20082))
	if isGokuBlue and arg_15_1._status == BattleData.CardStatus.board and not arg_15_1._gokuBlue20082Done then
		arg_15_1._gokuBlue20082Done = true
		local pOwner = arg_15_1._owner or arg_15_0
		local oppo = pOwner and pOwner._opponent
		if oppo then
			local function getCardAtkVal(c)
				if not c then return 0 end
				if c.getAtk then
					local v = c:getAtk()
					if type(v) == "number" then return v end
				end
				if type(c._atk) == "number" then return c._atk end
				if type(c._atk) == "table" and type(c._atk[1]) == "number" then return c._atk[1] end
				if c._info and c._info._atk then
					if type(c._info._atk) == "number" then return c._info._atk end
					if type(c._info._atk) == "table" and type(c._info._atk[1]) == "number" then return c._info._atk[1] end
				end
				return 0
			end

			-- 20082: Loai bo quai ATK <= 3000 trong bo bai phu doi phuong
			local removedRare = {}
			if oppo._rareCards then
				local newRare = {}
				for _, c in ipairs(oppo._rareCards) do
					if getCardAtkVal(c) <= 3000 then
						if c.saveAndReset then pcall(function() c:saveAndReset() end) end
						c._status = BattleData.CardStatus.leave
						oppo:addCardToLeave(c)
						table.insert(removedRare, c)
					else
						table.insert(newRare, c)
					end
				end
				oppo._rareCards = newRare
			end
			if oppo._isClient and #removedRare > 0 then
				pcall(function()
					local bUi = B._currentBattleUi or (lc and lc._runningScene and lc._runningScene._battleUi)
					local oppoUi = bUi and (bUi._player == oppo and bUi._playerUi or (bUi._opponent == oppo and bUi._opponentUi or nil))
					if oppoUi then
						for _, c in ipairs(removedRare) do
							local spr = oppoUi:getCardSprite(c) or oppoUi:createCardSprite(c, false)
							if spr then
								if oppoUi._pRareCards then
									for ri = #oppoUi._pRareCards, 1, -1 do
										if oppoUi._pRareCards[ri] == spr then
											table.remove(oppoUi._pRareCards, ri)
										end
									end
								end
								spr:setVisible(false)
							end
						end
						if oppoUi.updateRareArea then oppoUi:updateRareArea() end
					end
				end)
			end

			-- 20083: Loai bo quai ATK <= 2000 tren san va tren tay doi thu
			if oppo._boardCards then
				for i = 1, Data.MAX_CARD_COUNT_ON_BOARD do
					local c = oppo._boardCards[i]
					if c and c ~= arg_15_1 and (c:isMonster() or c:isMonsterRare()) then
						if getCardAtkVal(c) <= 2000 then
							pcall(function()
								if c.removeShieldInType then
									c:removeShieldInType(BattleData.ShieldType.shieldMonster)
									c:removeShieldInType(BattleData.ShieldType.shieldAll)
								end
							end)
							oppo:changeCardStatus(c, BattleData.CardStatus.board, BattleData.CardStatus.leave, nil, nil)
						end
					end
				end
			end
			if oppo._handCards then
				local handList = {}
				for _, c in ipairs(oppo._handCards) do table.insert(handList, c) end
				for _, c in ipairs(handList) do
					if (c:isMonster() or c:isMonsterRare()) and getCardAtkVal(c) <= 2000 then
						oppo:changeCardStatus(c, BattleData.CardStatus.hand, BattleData.CardStatus.leave, nil, nil)
					end
				end
			end
			oppo:account()
			pOwner:account()
		end
	end

end

function var_0_0.addCardToGrave(arg_16_0, arg_16_1)
	if #arg_16_0._graveCards == Data.MAX_CARD_COUNT_IN_GRAVE or not arg_16_1._isTroopCard and (not arg_16_0._isClient or arg_16_0._round ~= 0 or arg_16_0._battleType ~= Data.BattleType.layout and arg_16_0._battleType ~= Data.BattleType.unittest) then
		arg_16_1._destStatus = BattleData.CardStatus.leave

		arg_16_0:addCardToLeave(arg_16_1)

		return
	end

	if (arg_16_0._mark14255 or arg_16_0._mark14788) and (arg_16_1._sourceStatus == BattleData.CardStatus.board or arg_16_1._sourceStatus == BattleData.CardStatus.show or arg_16_1._sourceStatus == BattleData.CardStatus.cover or arg_16_1._sourceStatus == BattleData.CardStatus.field) then
		arg_16_1._destStatus = BattleData.CardStatus.leave

		arg_16_0:addCardToLeave(arg_16_1)

		return
	end

		if (arg_16_1._infoId == 12348 or arg_16_1:hasSkillFast(14822)) and arg_16_1._sourceStatus == BattleData.CardStatus.board then
		local oppo = arg_16_0._opponent
		if oppo and #oppo._pileCards > 0 and #oppo._handCards < Data.MAX_CARD_COUNT_IN_HAND then
			local drawCard = oppo._pileCards[1]
			if drawCard then
				oppo:changeCardStatus(drawCard, BattleData.CardStatus.pile, BattleData.CardStatus.hand, BattleData.CardStatusVal.p2h_deal)
			end
		end
	end

	table.insert(arg_16_0._graveCards, arg_16_1)

	if arg_16_1._type == Data.CardType.magic then
		arg_16_1._magicTarget = arg_16_1._saved._magicTarget
	elseif arg_16_1._type == Data.CardType.trap then
		arg_16_1._trapTarget = arg_16_1._saved._trapTarget
	end

	arg_16_1._status = BattleData.CardStatus.grave
	arg_16_1._onGraveRound = arg_16_0._round
	arg_16_1._onGraveEndRound = arg_16_0._endRound

	if arg_16_1._sourceStatus == BattleData.CardStatus.board then
		arg_16_0._opponent._mark2413[#arg_16_0._opponent._mark2413 + 1] = arg_16_1
	end

	if arg_16_1._saved._addSkills ~= nil then
		for iter_16_0 = 1, #arg_16_1._saved._addSkills do
			arg_16_1:addSkill(arg_16_1._saved._addSkills[iter_16_0], 1, BattleData.SkillProvider.given)
		end

		arg_16_1._saved._addSkills = nil
	end

	arg_16_1._isComposeMaterial = nil

	if arg_16_1._triggerCard ~= nil and arg_16_1._triggerCard:hasSkills({
		4048,
		4113,
		4171,
		4186,
		4207,
		4290,
		4305,
		4454,
		4497,
		4511,
		4514,
		4521,
		4526,
		4530,
		4735,
		4736,
		4740,
		4748,
		4836,
		4861,
		4957,
		4978,
		4979,
		4980,
		5244,
		5280,
		5298,
		5430,
		5431,
		5452,
		5470,
		5485,
		5544,
		5549,
		7144,
		7373,
		7544,
		7579,
		7622,
		7631,
		7673,
		7674,
		7693,
		7731,
		14733,
		14734,
		14743,
		7753,
		7831,
		2318,
		2982,
		2985,
		13119,
		13259,
		13264,
		13292,
		13348,
		13718,
		13850,
		13920,
		13989,
		14390,
		14519,
		14555
	}) then
		arg_16_1._isComposeMaterial = true
	end

	arg_16_1._pos = #arg_16_0._graveCards

	lc.clearTable(arg_16_1._saved)
	arg_16_1._ltkkDiscardQueued = nil

	arg_16_0._toGraveCardsInRound[#arg_16_0._toGraveCardsInRound + 1] = arg_16_1

	if arg_16_1._statusVal ~= BattleData.CardStatusVal.g2g_oppo then
		arg_16_1:setDieStat()
	end
end

function var_0_0.addCardToLeave(arg_17_0, arg_17_1)
	arg_17_1._status = BattleData.CardStatus.leave

	if arg_17_1._type == Data.CardType.magic then
		arg_17_1._magicTarget = arg_17_1._saved._magicTarget
	elseif arg_17_1._type == Data.CardType.trap then
		arg_17_1._trapTarget = arg_17_1._saved._trapTarget
	end

	if arg_17_1._saved._addSkills ~= nil then
		for iter_17_0 = 1, #arg_17_1._saved._addSkills do
			arg_17_1:addSkill(arg_17_1._saved._addSkills[iter_17_0], 1, BattleData.SkillProvider.given)
		end

		arg_17_1._saved._addSkills = nil
	end

	arg_17_1._onLeaveRound = arg_17_0._round
	arg_17_1._onLeaveEndRound = arg_17_0._endRound
	arg_17_0._leaveCards[#arg_17_0._leaveCards + 1] = arg_17_1

	if arg_17_1:isStatusValLeaveTemp() then
		arg_17_0._tempLeaveCards[#arg_17_0._tempLeaveCards + 1] = arg_17_1
	end

	lc.clearTable(arg_17_1._saved)

	if arg_17_1._statusVal ~= BattleData.CardStatusVal.l2l_oppo then
		arg_17_1:setDieStat()
	end
end

function var_0_0.addCardToCover(arg_18_0, arg_18_1)
	arg_18_1._status = BattleData.CardStatus.cover

	if arg_18_1:hasSkills({
		8047,
		8052
	}) then
		arg_18_1._trapTarget = arg_18_1._saved._trapTarget
	end

	local var_18_0 = arg_18_1._saved._pos and arg_18_1._saved._pos > 0 and arg_18_1._saved._pos or arg_18_0:getEmptyGroundPos()

	arg_18_1._pos = var_18_0
	arg_18_1._saved._pos = nil

	if arg_18_1._saved._addSkills ~= nil then
		for iter_18_0 = 1, #arg_18_1._saved._addSkills do
			arg_18_1:addSkill(arg_18_1._saved._addSkills[iter_18_0], 1, BattleData.SkillProvider.given)
		end

		arg_18_1._saved._addSkills = nil
	end

	arg_18_0._coverCards[var_18_0] = arg_18_1
end

function var_0_0.addCardToShow(arg_19_0, arg_19_1)
	local var_19_0

	if arg_19_1._saved._pos and arg_19_1._saved._pos > 0 then
		var_19_0 = arg_19_1._saved._pos
	elseif arg_19_1._sourceStatus == BattleData.CardStatus.cover then
		var_19_0 = arg_19_1._pos
	else
		var_19_0 = arg_19_0:getEmptyGroundPos()
	end

	if var_19_0 ~= nil then
		arg_19_1._status = BattleData.CardStatus.show
		arg_19_1._pos = var_19_0
		arg_19_1._saved._pos = nil
		arg_19_0._showCards[var_19_0] = arg_19_1
		arg_19_1._onBoardRound = arg_19_0._round

		if arg_19_1:hasSkillFast(4151) then
			arg_19_1._round4151 = arg_19_1._owner._round + Data._skillInfo[4151]._val[1] - 1
		end

		if arg_19_1._saved._addSkills ~= nil then
			for iter_19_0 = 1, #arg_19_1._saved._addSkills do
				arg_19_1:addSkill(arg_19_1._saved._addSkills[iter_19_0], 1, BattleData.SkillProvider.given)
			end

			arg_19_1._saved._addSkills = nil
		end

		if arg_19_1._saved._bind ~= nil then
			arg_19_1:addBind(arg_19_1._saved._bind)

			arg_19_1._saved._bind = nil
		end

		if arg_19_1._type == Data.CardType.magic then
			arg_19_1._magicTarget = arg_19_1._saved._magicTarget
		end

		if arg_19_1._infoId == 30597 or arg_19_1:hasSkillFast(14813) then
			arg_19_0:account()
			if arg_19_0._opponent then arg_19_0._opponent:account() end
		end
	else
		arg_19_1._destStatus = BattleData.CardStatus.grave

		arg_19_0:addCardToGrave(arg_19_1)
	end
end

function var_0_0.addCardToField(arg_20_0, arg_20_1)
	arg_20_1._status = BattleData.CardStatus.field
	arg_20_1._onBoardRound = arg_20_0._round
	arg_20_0._fieldCard = arg_20_1
end
