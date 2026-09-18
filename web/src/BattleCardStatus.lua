local var_0_0 = PlayerBattle

function var_0_0.changeCardStatus(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	if arg_1_1._type == Data.CardType.rare and arg_1_3 ~= BattleData.CardStatus.board and arg_1_3 ~= BattleData.CardStatus.grave and arg_1_3 ~= BattleData.CardStatus.leave then
		arg_1_3 = BattleData.CardStatus.rare
	end

	if arg_1_3 == BattleData.CardStatus.grave and (not arg_1_1._isTroopCard or arg_1_1._owner:hasBattleCardsBySkillFast("B", 6046) or not arg_1_1._owner._opponent._isSkillDisabled and arg_1_1._owner._opponent:hasBattleCardsBySkillFast("B", 6046) or not arg_1_1._owner._opponent._isSkillDisabled and arg_1_1._owner._opponent:hasBattleCardsByCanCastMonsterSkillFast("B", 2707) or arg_1_1:isMonsterRare() and arg_1_1._owner._opponent:hasBattleCardsByCanCastMonsterSkillFast("S", 8129) and #B.filterUniqueInfoIdCards(arg_1_1._owner._opponent:getBattleCardsByInfoIdGroup("B", Data._skillInfo[8129]._refCards)) >= 3) then
		arg_1_3 = BattleData.CardStatus.leave
	elseif arg_1_2 == BattleData.CardStatus.board and (arg_1_3 == BattleData.CardStatus.hand or arg_1_3 == BattleData.CardStatus.pile) and not arg_1_1._isTroopCard then
		arg_1_3 = arg_1_1._type == Data.CardType.rare and BattleData.CardStatus.rare or BattleData.CardStatus.leave
	end

	if (arg_1_4 == BattleData.CardStatusVal.x2gl_cost or arg_1_4 == BattleData.CardStatusVal.x2gl_oppo_cost) and arg_1_2 == BattleData.CardStatus.board and (arg_1_1:hasSkillFast(3210) or arg_1_1:hasSkillFast(13975)) then
		arg_1_3 = BattleData.CardStatus.leave
	end

	if arg_1_2 ~= BattleData.CardStatus.board and arg_1_2 ~= BattleData.CardStatus.leave and arg_1_3 == BattleData.CardStatus.grave and (arg_1_1:hasSkillFast(3210) or arg_1_1:hasSkillFast(13975)) then
		arg_1_3 = BattleData.CardStatus.leave
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

	if var_6_1 or arg_6_1._statusVal == BattleData.CardStatusVal.b2h_oppo or arg_6_1._statusVal == BattleData.CardStatusVal.b2p_oppo or arg_6_1._statusVal == BattleData.CardStatusVal.b2h_oppo_once or arg_6_1._statusVal == BattleData.CardStatusVal.b2g_oppo_sacrifice or arg_6_1._statusVal == BattleData.CardStatusVal.x2g_oppo or arg_6_1._statusVal == BattleData.CardStatusVal.x2l_temp_oppo or arg_6_1._statusVal == BattleData.CardStatusVal.x2gl_oppo_cost then
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
	elseif arg_13_1._triggerCard and (arg_13_1._triggerCard:hasSkillFast(9343) or arg_13_1._triggerCard:hasSkillFast(4853) or arg_13_1._triggerCard:hasSkillFast(8139)) then
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
	if arg_15_1:isMonsterRare() then
		local var_15_0

		if arg_15_1:isStatusValLinkSummon() then
			var_15_0 = arg_15_1._saved._pos and arg_15_0:isLinkPosEmpty(arg_15_1._saved._pos) and arg_15_1._saved._pos or arg_15_0:getEmptyLinkPos(arg_15_1)
		else
			var_15_0 = arg_15_1._saved._pos and arg_15_0:isBoardPosEmpty(arg_15_1._saved._pos) and arg_15_1._saved._pos or arg_15_0:getEmptyBoardPos(arg_15_1)
		end

		arg_15_1._saved._pos = nil

		if var_15_0 ~= nil then
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

			if arg_15_0._isAttacker and arg_15_0._round == (arg_15_0._battleType == Data.BattleType.PVP_room and 2 or 1) and arg_15_0._battleType ~= Data.BattleType.unittest and arg_15_0._battleType ~= Data.BattleType.teach or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_compose_ex or arg_15_1._statusVal == BattleData.CardStatusVal.g2b_decompose or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_sync_attack_frozen or arg_15_1._statusVal == BattleData.CardStatusVal.r2b_xyz_attack_frozen then
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
				arg_15_1._round3273 = arg_15_1._owner._round + 3
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
				local var_15_9 = arg_15_1._statusVal == BattleData.CardStatusVal.h2b_oppo_normal and arg_15_0._opponent or arg_15_0

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
end

function var_0_0.addCardToGrave(arg_16_0, arg_16_1)
	if #arg_16_0._graveCards == Data.MAX_CARD_COUNT_IN_GRAVE or not arg_16_1._isTroopCard and (not arg_16_0._isClient or arg_16_0._round ~= 0 or arg_16_0._battleType ~= Data.BattleType.layout and arg_16_0._battleType ~= Data.BattleType.unittest) then
		arg_16_1._destStatus = BattleData.CardStatus.leave

		arg_16_0:addCardToLeave(arg_16_1)

		return
	end

	if arg_16_0._mark14255 and (arg_16_1._sourceStatus == BattleData.CardStatus.board or arg_16_1._sourceStatus == BattleData.CardStatus.show or arg_16_1._sourceStatus == BattleData.CardStatus.cover or arg_16_1._sourceStatus == BattleData.CardStatus.field) then
		arg_16_1._destStatus = BattleData.CardStatus.leave

		arg_16_0:addCardToLeave(arg_16_1)

		return
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
