local var_0_0 = PlayerUi

function var_0_0.removeCardFromLeave(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:createCardSprite(arg_1_1)

	var_1_0:setPosition(-100, ClientView.SCR_CH + (arg_1_0._isController and -200 or 200))
	arg_1_0._battleUi:addChild(var_1_0)

	return var_1_0
end

function var_0_0.removeCardFromPile(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:createCardSprite(arg_2_1)

	var_2_0:setPosition(ClientView.SCR_W + 100, ClientView.SCR_CH + (arg_2_0._isController and -200 or 200))
	arg_2_0._battleUi:addChild(var_2_0)
	arg_2_0:sendEvent(var_0_0.EventType.update_card_pile_count)

	return var_2_0
end

function var_0_0.removeCardFromHand(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = arg_3_0:getHandCardSprite(arg_3_1)

	table.remove(arg_3_0._pHandCards, var_3_1)
end

function var_0_0.removeCardFromBoard(arg_4_0, arg_4_1)
	if arg_4_1:isMonsterRare() then
		local var_4_0, var_4_1 = arg_4_0:getBoardCardSprite(arg_4_1)

		arg_4_0._pBoardCards[var_4_1] = nil

		if arg_4_1:isV12() and #arg_4_1._owner:getBattleCardsByInfoId("B", arg_4_1._infoId) + #arg_4_1._owner._opponent:getBattleCardsByInfoId("B", arg_4_1._infoId) == 0 then
			lc.Audio.playAudio(AUDIO.M_BATTLE1)
		end

		if arg_4_1:isLink() then
			arg_4_0:switchBoard(not arg_4_0._player:hasEx())
		end
	end
end

function var_0_0.removeCardFromGrave(arg_5_0, arg_5_1)
	local var_5_0, var_5_1 = arg_5_0:getGraveCardSprite(arg_5_1)

	if var_5_0 == nil then
		var_5_0, var_5_1 = arg_5_0._opponentUi:getGraveCardSprite(arg_5_1)

		if var_5_0 ~= nil then
			table.remove(arg_5_0._opponentUi._pGraveCards, var_5_1)
			var_5_0:setVisible(false)
			arg_5_0._opponentUi:updateGraveArea()
		end
	else
		table.remove(arg_5_0._pGraveCards, var_5_1)
		var_5_0:setVisible(false)
		arg_5_0:updateGraveArea()
	end
end

function var_0_0.removeCardFromRare(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = arg_6_0:getRareCardSprite(arg_6_1)

	table.remove(arg_6_0._pRareCards, var_6_1)
	var_6_0:setVisible(true)
	var_6_0:setScale(1 / CardSprite.Scale.normal)
	var_6_0:updateZOrder(true)
	arg_6_0:updateRareArea(#arg_6_0._pGraveCards)
end

function var_0_0.removeCardFromCover(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getCardSprite(arg_7_1)

	for iter_7_0 = 1, Data.MAX_CARD_COUNT_ON_COVER do
		if arg_7_0._pCoverCards[iter_7_0] == var_7_0 then
			arg_7_0._pCoverCards[iter_7_0] = nil

			break
		end
	end
end

function var_0_0.removeCardFromShow(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getCardSprite(arg_8_1)

	for iter_8_0 = 1, Data.MAX_CARD_COUNT_ON_COVER do
		if arg_8_0._pShowCards[iter_8_0] == var_8_0 then
			arg_8_0._pShowCards[iter_8_0] = nil

			break
		end
	end

	arg_8_1._mark7376 = nil

	if var_8_0._natureIcon then
		var_8_0._natureIcon:removeFromParent()

		var_8_0._natureIcon = nil
	end

	if var_8_0._categoryLabel then
		var_8_0._categoryLabel:removeFromParent()

		var_8_0._categoryLabel = nil
	end
end

function var_0_0.removeCardFromField(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getCardSprite(arg_9_1)

	if arg_9_0._pFieldCard == var_9_0 then
		arg_9_0._pFieldCard = nil
	end
end

function var_0_0.addCardToLeave(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:getCardSprite(arg_10_1)

	if arg_10_1._sourceStatus == BattleData.CardStatus.board then
		arg_10_3 = var_10_0:playBoardToLeave(arg_10_3)
	elseif arg_10_1._sourceStatus == BattleData.CardStatus.cover or arg_10_1._sourceStatus == BattleData.CardStatus.show or arg_10_1._sourceStatus == BattleData.CardStatus.field then
		arg_10_3 = var_10_0:playBoardToLeave(arg_10_3)
	elseif arg_10_1._sourceStatus == BattleData.CardStatus.grave then
		arg_10_3 = var_10_0:playRetrievToLeave(arg_10_3)
	elseif arg_10_1._sourceStatus == BattleData.CardStatus.rare and arg_10_1:hasSkillFast(13354) then
		arg_10_0:hideCardSprite(var_10_0)
	elseif arg_10_1._statusVal == BattleData.CardStatusVal.h2l_show or arg_10_1._statusVal == BattleData.CardStatusVal.p2l_show then
		arg_10_3 = var_10_0:playToLeave(arg_10_3, true)
	else
		arg_10_3 = var_10_0:playToLeave(arg_10_3, false)
	end

	return arg_10_3, arg_10_3
end

function var_0_0.addCardToPile(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:getCardSprite(arg_11_1)

	arg_11_0:sendEvent(var_0_0.EventType.update_card_pile_count)

	if arg_11_1._statusVal == BattleData.CardStatusVal.e2x_fast or arg_11_1._statusVal == BattleData.CardStatusVal.g2p_fast then
		arg_11_3 = var_11_0:fastToPile(arg_11_3)
	elseif arg_11_1._sourceStatus == BattleData.CardStatus.board then
		arg_11_3 = var_11_0:playBoardRetriev(arg_11_3)
		arg_11_3 = var_11_0:playRetrievToPile(arg_11_3)
	elseif arg_11_1._sourceStatus == BattleData.CardStatus.grave then
		arg_11_3 = var_11_0:playGraveRetriev(arg_11_3)
		arg_11_3 = var_11_0:playRetrievToPile(arg_11_3)
	elseif arg_11_1._sourceStatus == BattleData.CardStatus.cover or arg_11_1._sourceStatus == BattleData.CardStatus.show or arg_11_1._sourceStatus == BattleData.CardStatus.field then
		arg_11_3 = var_11_0:playCoverRetriev(arg_11_3)
		arg_11_3 = var_11_0:playRetrievToPile(arg_11_3)
	elseif arg_11_1._sourceStatus == BattleData.CardStatus.leave then
		var_11_0:setPosition(cc.p(ClientView.SCR_CW, ClientView.SCR_CH))

		arg_11_3 = var_11_0:playToPile(arg_11_3)
	else
		arg_11_3 = var_11_0:playToPile(arg_11_3)
	end

	return arg_11_3, arg_11_3
end

function var_0_0.addCardToHand(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:getCardSprite(arg_12_1) or arg_12_0._opponentUi:getCardSprite(arg_12_1)

	arg_12_0._pHandCards[arg_12_1._pos] = var_12_0

	arg_12_0:calHandCardPosAndRot(var_12_0)

	if arg_12_1._statusVal == BattleData.CardStatusVal.e2x_fast then
		arg_12_3 = var_12_0:fastToHand(arg_12_3, false)
	elseif arg_12_1._sourceStatus == BattleData.CardStatus.board then
		arg_12_3 = var_12_0:playBoardRetriev(arg_12_3)
		arg_12_3 = var_12_0:playRetrievToHand(arg_12_3)
		arg_12_2 = arg_12_3
	elseif arg_12_1._sourceStatus == BattleData.CardStatus.grave then
		arg_12_3 = var_12_0:playGraveRetriev(arg_12_3)
		arg_12_3 = var_12_0:playRetrievToHand(arg_12_3)
		arg_12_2 = arg_12_3
	elseif arg_12_1._sourceStatus == BattleData.CardStatus.cover or arg_12_1._sourceStatus == BattleData.CardStatus.show or arg_12_1._sourceStatus == BattleData.CardStatus.field then
		arg_12_3 = var_12_0:playCoverRetriev(arg_12_3)
		arg_12_3 = var_12_0:playRetrievToHand(arg_12_3)
		arg_12_2 = arg_12_3
	elseif arg_12_1._sourceStatus == BattleData.CardStatus.leave then
		var_12_0:setPosition(cc.p(ClientView.SCR_CW, ClientView.SCR_CH))
		var_12_0:setScale(1 / CardSprite.Scale.normal)

		arg_12_2, arg_12_3 = var_12_0:playRetrievToHand(arg_12_3)
	elseif arg_12_1._statusVal == BattleData.CardStatusVal.p2h_show or arg_12_1._statusVal == BattleData.CardStatusVal.p2h_deal_show then
		arg_12_2, arg_12_3 = var_12_0:playToHand(arg_12_3, true)
	else
		arg_12_2, arg_12_3 = var_12_0:playToHand(arg_12_3, false)
	end

	return arg_12_2, arg_12_3
end

function var_0_0.addCardToBoard(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:getCardSprite(arg_13_1)

	if arg_13_1:isMonsterRare() then
		arg_13_0._pBoardCards[arg_13_1._pos] = var_13_0

		arg_13_0:calBoardCardPos(var_13_0)

		if arg_13_1:isV12() then
			lc.Audio.playAudio(AUDIO.M_BATTLE2)
		end

		if arg_13_1:isLink() then
			arg_13_0:switchBoard(not arg_13_0._player:hasEx())
		end
	end

	if arg_13_1._statusVal == BattleData.CardStatusVal.e2x_fast or arg_13_1._statusVal == BattleData.CardStatusVal.e2x_fast_def then
		arg_13_3 = var_13_0:fastToBoard(arg_13_3)
	elseif arg_13_1._sourceStatus == BattleData.CardStatus.leave then
		arg_13_3 = var_13_0:playEmptyToBoard(arg_13_3)
	elseif arg_13_1._sourceStatus == BattleData.CardStatus.rare then
		arg_13_3 = var_13_0:playToBoard(arg_13_3)
	elseif arg_13_1._sourceStatus == BattleData.CardStatus.grave then
		var_13_0:setScale(1)
		arg_13_3 = var_13_0:playGraveRetriev(arg_13_3)
		arg_13_3 = var_13_0:playToBoard(arg_13_3)
	elseif arg_13_1._sourceStatus == BattleData.CardStatus.board then
		arg_13_3 = var_13_0:playBoardToBoard(arg_13_3)
	else
		arg_13_3 = var_13_0:playToBoard(arg_13_3)
	end

	return arg_13_3, arg_13_3
end

function var_0_0.addCardToGrave(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:getCardSprite(arg_14_1)

	table.insert(arg_14_0._pGraveCards, var_14_0)

	if arg_14_1._statusVal == BattleData.CardStatusVal.e2x_fast or arg_14_1._statusVal == BattleData.CardStatusVal.p2g_fast then
		arg_14_3 = var_14_0:fastToGrave(arg_14_3)
	elseif arg_14_1._sourceStatus == BattleData.CardStatus.board then
		arg_14_3 = var_14_0:playBoardToGrave(arg_14_3)
	elseif arg_14_1._sourceStatus == BattleData.CardStatus.cover or arg_14_1._sourceStatus == BattleData.CardStatus.show or arg_14_1._sourceStatus == BattleData.CardStatus.field then
		arg_14_3 = var_14_0:playBoardToGrave(arg_14_3)
	elseif arg_14_1._sourceStatus == BattleData.CardStatus.hand or arg_14_1._sourceStatus == BattleData.CardStatus.pile then
		if arg_14_1._statusVal == BattleData.CardStatusVal.h2g_magic then
			arg_14_0:replaceHandCards(arg_14_3)
			arg_14_0:addGraveCard(var_14_0)
			var_14_0:updateZOrder()
		else
			arg_14_3 = var_14_0:playToGrave(arg_14_3)
		end
	else
		arg_14_0:addGraveCard(var_14_0)
		var_14_0:updateZOrder()
	end

	return arg_14_3, arg_14_3
end

function var_0_0.addCardToRare(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0:getCardSprite(arg_15_1)

	table.insert(arg_15_0._pRareCards, var_15_0)

	if arg_15_1._statusVal == BattleData.CardStatusVal.e2x_fast and var_15_0.fastToRare then
		arg_15_3 = var_15_0:fastToRare(arg_15_3)
	else
		arg_15_3 = var_15_0:playToRare(arg_15_3)
	end

	return arg_15_3, arg_15_3
end

function var_0_0.addCardToCover(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0:getCardSprite(arg_16_1)

	if arg_16_1._type == Data.CardType.trap then
		arg_16_0._pCoverCards[arg_16_1._pos] = var_16_0
		var_16_0._default._position = arg_16_0._coverPos[arg_16_1._pos]
	end

	if arg_16_1._statusVal == BattleData.CardStatusVal.e2x_fast then
		arg_16_3 = var_16_0:fastToCover(arg_16_3)
	else
		arg_16_3 = var_16_0:playToCover(arg_16_3)
	end

	return arg_16_3, arg_16_3
end

function var_0_0.addCardToShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0:getCardSprite(arg_17_1)

	if arg_17_1._type == Data.CardType.trap or arg_17_1._type == Data.CardType.magic then
		arg_17_0._pShowCards[arg_17_1._pos] = var_17_0
		var_17_0._default._position = arg_17_0._coverPos[arg_17_1._pos]
	end

	if arg_17_1._statusVal == BattleData.CardStatusVal.e2x_fast then
		arg_17_3 = var_17_0:fastToShow(arg_17_3)
	elseif arg_17_1._sourceStatus == BattleData.CardStatus.hand then
		arg_17_3 = var_17_0:playToShow(arg_17_3)
	elseif arg_17_1._sourceStatus == BattleData.CardStatus.cover then
		arg_17_3 = var_17_0:playCoverToShow(arg_17_3)
	elseif arg_17_1._sourceStatus == BattleData.CardStatus.grave then
		arg_17_3 = var_17_0:playToShow(arg_17_3)
	else
		arg_17_3 = var_17_0:playToShow(arg_17_3)
	end

	return arg_17_3, arg_17_3
end

function var_0_0.addCardToField(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0:getCardSprite(arg_18_1)

	arg_18_0._pFieldCard = var_18_0
	var_18_0._default._position = arg_18_0._coverPos[Data.MAX_CARD_COUNT_ON_COVER + 1]

	if arg_18_1._statusVal == BattleData.CardStatusVal.e2x_fast then
		arg_18_3 = var_18_0:fastToField(arg_18_3)
	else
		arg_18_3 = var_18_0:playToField(arg_18_3)
	end

	return arg_18_3, arg_18_3
end

function var_0_0.accountHalo(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_3._owner._isAttacker == arg_19_0._isAttacker and arg_19_0 or arg_19_0._opponentUi

	if arg_19_3:isMonsterRare() and not arg_19_3._negativeStatus[BattleData.NegativeType.haloSkillFrozen] and (arg_19_3._sourceStatus == BattleData.CardStatus.leave or arg_19_3._sourceStatus == BattleData.CardStatus.pile or arg_19_3._sourceStatus == BattleData.CardStatus.hand or arg_19_3._sourceStatus == BattleData.CardStatus.grave) and arg_19_3._destStatus == BattleData.CardStatus.board then
		local var_19_1 = var_19_0:getCardSprite(arg_19_3)

		for iter_19_0 = 1, #arg_19_3._skills do
			local var_19_2 = arg_19_3._skills[iter_19_0]

			if B.skillHasMode(var_19_2, Data.SkillMode.halo) then
				local var_19_3, var_19_4 = var_19_0:castSkillAction(var_19_1, arg_19_2, var_19_2, Data.SkillMode.halo)

				if arg_19_1 < var_19_3 then
					arg_19_1 = var_19_3
				end
			end
		end
	end

	return arg_19_1
end

function var_0_0.accountStatus(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2
	local var_20_1 = arg_20_0:getCardSprite(arg_20_1) or arg_20_0._opponentUi:getCardSprite(arg_20_1)

	if var_20_1 ~= nil and var_20_1 == arg_20_0._battleUi._touchCard then
		arg_20_0._battleUi:onTouchCanceled()
	end

	local var_20_2 = arg_20_1._sourceStatus
	local var_20_3 = arg_20_1._destStatus

	if var_20_2 == BattleData.CardStatus.leave then
		var_20_1 = (var_20_1 and var_20_1._ownerUi or arg_20_0):removeCardFromLeave(arg_20_1)
	elseif var_20_2 == BattleData.CardStatus.pile then
		var_20_1 = arg_20_0:removeCardFromPile(arg_20_1)
	elseif var_20_2 == BattleData.CardStatus.hand then
		var_20_1._ownerUi:removeCardFromHand(arg_20_1)
	elseif var_20_2 == BattleData.CardStatus.board then
		var_20_1._ownerUi:removeCardFromBoard(arg_20_1)
	elseif var_20_2 == BattleData.CardStatus.grave then
		var_20_1._ownerUi:removeCardFromGrave(arg_20_1)
	elseif var_20_2 == BattleData.CardStatus.rare then
		var_20_1._ownerUi:removeCardFromRare(arg_20_1)
	elseif var_20_2 == BattleData.CardStatus.cover then
		var_20_1._ownerUi:removeCardFromCover(arg_20_1)
	elseif var_20_2 == BattleData.CardStatus.show then
		var_20_1._ownerUi:removeCardFromShow(arg_20_1)
	elseif var_20_2 == BattleData.CardStatus.field then
		var_20_1._ownerUi:removeCardFromField(arg_20_1)
	end

	if var_20_1 and var_20_1._ownerUi._player ~= arg_20_1._owner then
		var_20_1._ownerUi:removeCardToOppo(var_20_1)
	end

	if var_20_3 == BattleData.CardStatus.leave then
		var_20_0, arg_20_2 = arg_20_0:addCardToLeave(arg_20_1, var_20_0, arg_20_2)
	elseif var_20_3 == BattleData.CardStatus.pile then
		var_20_0, arg_20_2 = arg_20_0:addCardToPile(arg_20_1, var_20_0, arg_20_2)
	elseif var_20_3 == BattleData.CardStatus.hand then
		var_20_0, arg_20_2 = arg_20_0:addCardToHand(arg_20_1, var_20_0, arg_20_2)
	elseif var_20_3 == BattleData.CardStatus.board then
		var_20_0, arg_20_2 = arg_20_0:addCardToBoard(arg_20_1, var_20_0, arg_20_2)
	elseif var_20_3 == BattleData.CardStatus.grave then
		var_20_0, arg_20_2 = arg_20_0:addCardToGrave(arg_20_1, var_20_0, arg_20_2)
	elseif var_20_3 == BattleData.CardStatus.cover then
		var_20_0, arg_20_2 = arg_20_0:addCardToCover(arg_20_1, var_20_0, arg_20_2)
	elseif var_20_3 == BattleData.CardStatus.show then
		var_20_0, arg_20_2 = arg_20_0:addCardToShow(arg_20_1, var_20_0, arg_20_2)
	elseif var_20_3 == BattleData.CardStatus.field then
		var_20_0, arg_20_2 = arg_20_0:addCardToField(arg_20_1, var_20_0, arg_20_2)
	elseif var_20_3 == BattleData.CardStatus.rare then
		var_20_0, arg_20_2 = arg_20_0:addCardToRare(arg_20_1, var_20_0, arg_20_2)
	end

	if var_20_2 == BattleData.CardStatus.hand and var_20_3 == BattleData.CardStatus.board then
		arg_20_0:updateGem()
	end

	if arg_20_0._player._saved and arg_20_0._player._saved._cardStatusToChange and #arg_20_0._player._saved._cardStatusToChange > 0 or arg_20_0._player._opponent._saved and arg_20_0._player._opponent._saved._cardStatusToChange and #arg_20_0._player._opponent._saved._cardStatusToChange > 0 then
		arg_20_2 = var_20_0
	end

	arg_20_0:updateBoardCardsInitialSkills()

	return arg_20_2
end

function var_0_0.accountAction(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_0._player:getAllCards()
	local var_21_1 = 0

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if next(iter_21_1._castedSkills) ~= nil then
			local var_21_2 = iter_21_1._owner._isAttacker == arg_21_0._isAttacker and arg_21_0 or arg_21_0._opponentUi
			local var_21_3 = arg_21_0:getCardSprite(iter_21_1) or arg_21_0._opponentUi:getCardSprite(iter_21_1)

			if iter_21_1._type == Data.CardType.magic and var_21_3 == nil and iter_21_1._statagemTarget == nil then
				var_21_3 = {
					_card = iter_21_1,
					_playerUi = var_21_2
				}
			end

			if var_21_3 == nil then
				var_21_3 = {
					_card = iter_21_1,
					_playerUi = var_21_2
				}
			end

			local var_21_4 = iter_21_1._castedSkills or {}

			iter_21_1._castedSkills = {}

			for iter_21_2, iter_21_3 in ipairs(var_21_4) do
				if iter_21_3._id == 0 then
					local var_21_5 = arg_21_3._atkTargets[1]

					if arg_21_3._type == Data.CardType.boss then
						if var_21_5._type == Data.CardType.fortress or var_21_5._type == Data.CardType.boss then
							arg_21_1, var_21_1 = var_21_2:playAction(nil, var_0_0.Action.boss_attack_fortress, arg_21_1, var_21_5)
						else
							arg_21_1, var_21_1 = var_21_2:playAction(nil, var_0_0.Action.boss_attack_card, arg_21_1, var_21_5)
						end
					elseif var_21_5._type == Data.CardType.fortress then
						arg_21_1, var_21_1 = var_21_2:playAction(var_21_3, var_0_0.Action.attack_fortress, arg_21_1, var_21_5)
					elseif var_21_5._type == Data.CardType.boss then
						arg_21_1, var_21_1 = var_21_2:playAction(var_21_3, var_0_0.Action.attack_boss, arg_21_1, var_21_5)
					else
						arg_21_1, var_21_1 = var_21_2:playAction(var_21_3, var_0_0.Action.attack_card, arg_21_1, var_21_5)
					end
				else
					arg_21_1, var_21_1 = var_21_2:castSkillAction(var_21_3, arg_21_2, iter_21_3, Data.SkillMode.spelling)
				end
			end
		end
	end

	for iter_21_4, iter_21_5 in ipairs(var_21_0) do
		local var_21_6 = iter_21_5._owner._isAttacker == arg_21_0._isAttacker and arg_21_0 or arg_21_0._opponentUi
		local var_21_7 = arg_21_0:getCardSprite(iter_21_5) or arg_21_0._opponentUi:getCardSprite(iter_21_5)

		if next(iter_21_5._changed) ~= nil then
			for iter_21_6, iter_21_7 in pairs(iter_21_5._changed) do
				if iter_21_6 == "_damage" then
					if iter_21_5._type == Data.CardType.fortress then
						var_21_6:playAction(nil, var_0_0.Action.fortress_hurt, arg_21_1, iter_21_7)
					elseif iter_21_5._type == Data.CardType.boss then
						var_21_6:playAction(nil, var_0_0.Action.boss_hurt, arg_21_1, iter_21_7)
					else
						var_21_6:playAction(var_21_7, var_0_0.Action.card_hurt, arg_21_1, iter_21_7)
					end
				elseif iter_21_6 == "_hp" then
					if iter_21_5._type == Data.CardType.fortress or iter_21_5._type == Data.CardType.boss then
						var_21_6:playAction(nil, iter_21_7 > 0 and var_0_0.Action.fortress_hp_inc or var_0_0.Action.fortress_hp_dec, arg_21_1, iter_21_7)
					else
						var_21_6:playAction(var_21_7, iter_21_7 > 0 and var_0_0.Action.hp_inc or var_0_0.Action.hp_dec, arg_21_1, iter_21_7)
					end
				elseif iter_21_6 == "_atk" then
					if iter_21_5._type == Data.CardType.boss then
						var_21_6:playAction(nil, iter_21_7 > 0 and var_0_0.Action.fortress_atk_inc or var_0_0.Action.fortress_atk_dec, arg_21_1, iter_21_7)
					else
						var_21_6:playAction(var_21_7, iter_21_7 > 0 and var_0_0.Action.atk_inc or var_0_0.Action.atk_dec, arg_21_1, iter_21_7)
					end
				elseif iter_21_6 == "_nature" then
					var_21_6:playAction(var_21_7, var_0_0.Action.change_nature, arg_21_1, iter_21_7)
				elseif iter_21_6 == "_atkCount" then
					-- block empty
				elseif iter_21_6 == "_actionCount" then
					var_21_7:updateBoardActive()
				elseif iter_21_6 == "_skillLevelInc" then
					-- block empty
				elseif iter_21_6 == "_positiveStatus" then
					var_21_6:playAction(var_21_7, var_0_0.Action.update_positive_status, arg_21_1)
				elseif iter_21_6 == "_negativeStatus" then
					var_21_6:playAction(var_21_7, var_0_0.Action.update_negative_status, arg_21_1)
				elseif iter_21_6 == "_gemInc" or iter_21_6 == "_gemFrozen" then
					var_21_6:updateGem()
					var_21_6:updateCardsActive()
				elseif iter_21_6 == "_rebirth" then
					-- block empty
				elseif iter_21_6 == "_bind" then
					var_21_6:playAction(var_21_7, var_0_0.Action.update_bind, arg_21_1)
				elseif iter_21_6 == "_posChange" then
					for iter_21_8 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
						if var_21_6._pBoardCards[iter_21_8] ~= nil and var_21_6._pBoardCards[iter_21_8]._card._pos ~= iter_21_8 then
							local var_21_8 = var_21_6._pBoardCards[iter_21_8]._card._pos
							local var_21_9 = var_21_6._pBoardCards[iter_21_8]

							var_21_6._pBoardCards[iter_21_8] = nil
							var_21_6._pBoardCards[var_21_8] = var_21_9
						end
					end

					var_21_6:updateBoardCardsPos()
				else
					lc.log("[BATTLE] !!!!!!!!!!!!!!! unhandled property change: %s", iter_21_6)
				end
			end

			lc.clearTable(iter_21_5._changed)
		end
	end

	if arg_21_2 == BattleData.Status.attacking or arg_21_2 == BattleData.Status.spelling then
		arg_21_0._actionDelay = var_21_1
	elseif arg_21_2 == BattleData.Status.account_attack or arg_21_2 == BattleData.Status.account_spell then
		arg_21_1 = arg_21_1 + (arg_21_0._actionDelay or 0)
		arg_21_0._actionDelay = 0
	elseif arg_21_2 == BattleData.Status.under_spell_damage or arg_21_2 == BattleData.Status.under_attack or arg_21_2 == BattleData.Status.under_attack_damage or arg_21_2 == BattleData.Status.ac_under_attack_damage then
		arg_21_1 = 0

		if var_21_1 > arg_21_0._actionDelay then
			arg_21_0._actionDelay = var_21_1
		end
	else
		arg_21_1 = var_21_1 + arg_21_1
	end

	if not arg_21_0._boss then
		local var_21_10 = arg_21_0._opponentUi._boss
	end

	arg_21_0:updateBoardCardsInitialSkills()

	return arg_21_1
end

function var_0_0.accountEvent(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._player
	local var_22_1 = var_22_0._actionEvent
	local var_22_2, var_22_3 = var_22_0:getActionEffect(var_22_1, var_22_0._eventIndex)
	local var_22_4 = var_22_1._owner == arg_22_0._player and arg_22_0 or arg_22_0._opponentUi

	if var_22_0._effectIndex == 0 then
		-- block empty
	elseif var_22_0._effectIndex == 1 then
		local var_22_5 = var_22_0:getActionStory(var_22_1, var_22_0._eventIndex)

		if arg_22_0._battleUi._isSkipStory then
			arg_22_1 = 0
		elseif var_22_5 ~= nil and var_22_5[1] ~= 0 then
			arg_22_0:castEventStory(var_22_1, var_22_5)

			arg_22_1 = nil
		end
	elseif var_22_0._effectIndex == 2 then
		arg_22_1 = var_22_4:castEventAction(var_22_1, var_22_2, var_22_3)
	end

	return arg_22_1
end

function var_0_0.castEventStory(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._battleUi:showEvent(BattleEventDialog.Type.story, arg_23_2)
end

function var_0_0.castEventAction(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = 0
	local var_24_1 = arg_24_3 or {}
	local var_24_2 = arg_24_0._player:getActionCard()

	if arg_24_2 >= 1 and arg_24_2 <= 6 or arg_24_2 == 8 or arg_24_2 == 12 or arg_24_2 == 17 then
		var_24_0 = 0
	elseif arg_24_2 == 7 then
		local var_24_3 = arg_24_0:getBoardCardSpriteByInfoId(var_24_1.id, true)

		if var_24_3 ~= nil then
			arg_24_0:efcDragonBones(var_24_3, "jinu", cc.p(0, -10), true, false, "effect", 1.8)

			var_24_0 = 1
		end
	elseif arg_24_2 == 9 then
		arg_24_0._battleUi:showEvent(BattleEventDialog.Type.info_help)

		var_24_0 = nil
	elseif arg_24_2 == 10 then
		local var_24_4 = arg_24_0:getHandCardSpriteByInfoId(var_24_1.id, false)
		local var_24_5 = var_24_1.ti and arg_24_0:getBoardCardSpriteByInfoId(var_24_1.ti, false) or nil

		if var_24_4 then
			arg_24_0._battleUi:showEvent(BattleEventDialog.Type.guide_drag_to_pos, {
				var_24_4,
				var_24_5
			}, var_24_1.df ~= nil)

			var_24_0 = 0
		end
	elseif arg_24_2 == 11 then
		arg_24_0._battleUi:showEvent(BattleEventDialog.Type.guide_tap, arg_24_0._battleUi._btnEndRound, var_24_1.df ~= nil)

		var_24_0 = 0
	elseif arg_24_2 == 13 then
		-- block empty
	elseif arg_24_2 == 14 then
		local var_24_6 = arg_24_0:getBoardCardSpriteByInfoId(var_24_1.id, false)
		local var_24_7 = var_24_1.ti and arg_24_0._opponentUi:getBoardCardSpriteByInfoId(var_24_1.ti, false) or nil

		if var_24_6 then
			arg_24_0._battleUi:showEvent(BattleEventDialog.Type.guide_drag_to_attack, {
				var_24_6,
				var_24_7
			}, var_24_1.df ~= nil, arg_24_2)

			var_24_0 = 0
		end
	elseif arg_24_2 == 15 then
		arg_24_0._battleUi:hideEvent()

		var_24_0 = nil
	elseif arg_24_2 == 16 then
		arg_24_0._battleUi:exitScene()

		var_24_0 = nil
	elseif arg_24_2 == 18 then
		arg_24_0:playAction(nil, var_0_0.Action.fortress_hp_inc, 0, var_24_1.hp)

		var_24_0 = 1
	elseif arg_24_2 == 19 then
		if arg_24_0._battleUi._battleType == Data.BattleType.sweep then
			var_24_0 = 0
		else
			arg_24_0._battleUi:showTip(var_24_1)

			if var_24_1.t.touch == 1 then
				var_24_0 = nil
			else
				var_24_0 = 0
			end
		end
	elseif arg_24_2 == 20 then
		arg_24_0._battleUi:showEvent(BattleEventDialog.Type.guide_tap, ui._btnAuto, var_24_1.df ~= nil)

		var_24_0 = 0
	elseif arg_24_2 == 21 then
		local var_24_8 = arg_24_0:getHandCardSpriteByInfoId(var_24_1.id, false)

		if var_24_8 then
			arg_24_0._battleUi:showEvent(BattleEventDialog.Type.guide_drag, var_24_8, var_24_1.df ~= nil)

			var_24_0 = 0
		end
	elseif arg_24_2 == 22 then
		local var_24_9 = arg_24_0:getBoardCardSpriteByInfoId(var_24_1.id, false)
		local var_24_10 = arg_24_0:getBoardCardSpriteByInfoId(var_24_1.ti, false)

		if var_24_9 and var_24_10 then
			arg_24_0._battleUi:showEvent(BattleEventDialog.Type.guide_drag_to_card, {
				var_24_9,
				var_24_10
			}, var_24_1.df ~= nil)

			var_24_0 = 0
		end
	elseif arg_24_2 == 23 then
		local var_24_11 = arg_24_0:getBoardCardSpriteByInfoId(var_24_1.id, false)

		if var_24_11 then
			arg_24_0._battleUi:showEvent(BattleEventDialog.Type.guide_drag_to_defend, {
				var_24_11
			}, var_24_1.df ~= nil)

			var_24_0 = 0
		end
	elseif arg_24_2 == 51 then
		-- block empty
	elseif arg_24_2 == 52 then
		-- block empty
	elseif arg_24_2 == 53 then
		arg_24_0._battleUi:showTask()

		var_24_0 = nil
	elseif arg_24_2 == 54 then
		local var_24_12 = arg_24_0:getHandCardSpriteByInfoId(var_24_1.id, false)

		if var_24_12 then
			arg_24_0._isGuideSkill = true

			arg_24_0._battleUi:onTouchCanceled()

			arg_24_0._isTouching = false

			var_24_12:onTouchEnded()
			var_24_12:onTouchBegan()
			var_24_12:setPositionX(ClientView.SCR_CW)

			var_24_0 = 0
		end
	elseif arg_24_2 == 55 then
		local var_24_13 = arg_24_0:getHandCardSpriteByInfoId(var_24_1.id, false)

		if var_24_13 then
			arg_24_0._isGuideSkill = nil

			var_24_13:onTouchEnded()
			arg_24_0:playAction(var_24_13, var_0_0.Action.replace_hand_card, 0, 1)

			var_24_0 = 0
		end
	elseif arg_24_2 == 71 then
		lc.Audio.playAudio(AUDIO.M_GUIDE1)
	end

	return var_24_0
end

function var_0_0.playAction(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if arg_25_3 == nil then
		arg_25_3 = 0
	end

	local var_25_0 = arg_25_1 ~= nil and arg_25_1._card or nil

	if arg_25_2 == var_0_0.Action.replace_hand_card then
		local var_25_1 = arg_25_1._default._position
		local var_25_2 = arg_25_1._default._rotation

		if cc.p(arg_25_1:getPosition()).x == var_25_1.x and cc.p(arg_25_1:getPosition()).y == var_25_1.y and arg_25_1:getRotation() == var_25_2 and arg_25_1:getScale() == 1 then
			return arg_25_3
		end

		local var_25_3 = 0.2 * arg_25_4 / Data.MAX_CARD_COUNT_IN_HAND

		arg_25_1:runAction(lc.sequence(lc.delay(arg_25_3 + var_25_3), lc.call(function()
			arg_25_1:updateZOrder()
		end), cc.EaseOut:create(lc.spawn(lc.moveTo(0.4, var_25_1), lc.rotateTo(0.4, var_25_2), lc.scaleTo(0.4, 1)), 2.5)))

		return arg_25_3 + 0.4
	elseif arg_25_2 == var_0_0.Action.replace_board_card then
		local var_25_4 = arg_25_1._default._position

		if arg_25_1:getPosition() == var_25_4 and arg_25_1:getRotation() == 0 and arg_25_1:getScale() == 1 then
			return arg_25_3
		end

		arg_25_1:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
			arg_25_1:updateZOrder()
		end), cc.EaseOut:create(lc.spawn(lc.moveTo(0.5, var_25_4), lc.rotateTo(0.5, 0), lc.scaleTo(0.5, 1)), 2.5)))

		return arg_25_3 + 0.5
	elseif arg_25_2 == var_0_0.Action.attack_card or arg_25_2 == var_0_0.Action.attack_boss then
		local var_25_5 = arg_25_1._pFrame._bones or arg_25_1._pFrame._image
		local var_25_6 = var_25_5:getParent()
		local var_25_7 = arg_25_4._owner._isAttacker == arg_25_0._isAttacker and arg_25_0 or arg_25_0._opponentUi
		local var_25_8 = cc.p(var_25_5:getPosition())
		local var_25_9

		if arg_25_2 == var_0_0.Action.attack_boss then
			var_25_9 = var_0_0.Pos.boss
			var_25_9 = var_25_5:getParent():convertToNodeSpace(var_0_0.Pos.boss)
		else
			local var_25_10 = var_25_7._pBoardCards[arg_25_4._pos]._pFrame._image

			var_25_9 = var_25_5:getParent():convertToNodeSpace(var_25_10:getParent():convertToWorldSpace(cc.p(var_25_10:getPosition())))
		end

		local var_25_11 = arg_25_1:getEffectByType(Data.SkinEffectType.attack)
		local var_25_12, var_25_13 = arg_25_0:calLengthAndAngle(var_25_8, var_25_9)

		print("attack_card angle", var_25_13)
		print("attack_card angle", 90 - var_25_13)

		local var_25_14

		if ClientData._cfg and ClientData._cfg.testEffects then
			if ClientData._cfg.testEffects == true then
				local var_25_15 = {
					"busigongji11",
					"emogongji11",
					"jixiegongji11",
					"longzugongji11",
					"mofashigongji11",
					"niandongligongji11",
					"niaoshougongji11",
					"tianshigongji11",
					"yanshigongji11",
					"yanzugongji11",
					"shuigongji11"
				}

				Data._gongjiIndex = Data._gongjiIndex or 0
				Data._gongjiIndex = (Data._gongjiIndex + 1) % #var_25_15 + 1

				if Data._gongjiIndex == 9 or Data._gongjiIndex == 11 then
					local var_25_16
					local var_25_17 = true
					local var_25_18 = false
					local var_25_19 = false
					local var_25_20 = "effect2"
					local var_25_21 = 1

					var_25_14 = arg_25_1:efcDragonBones2(var_25_15[Data._gongjiIndex], var_25_16, var_25_17, var_25_18, var_25_20, var_25_21)
				end
			elseif ClientData._cfg.testEffects.attack then
				local var_25_22
				local var_25_23 = true
				local var_25_24 = false
				local var_25_25 = false
				local var_25_26 = "effect2"
				local var_25_27 = 1

				var_25_14 = arg_25_1:efcDragonBones2(ClientData._cfg.testEffects.attack, var_25_22, var_25_23, var_25_24, var_25_26, var_25_27)
			end
		end

		if var_25_14 then
			var_25_14:setRotation(90 - var_25_13)
		end

		arg_25_1:updateZOrder(true)
		var_25_5:stopAllActions()
		var_25_5:runAction(lc.sequence(arg_25_3, lc.ease(lc.moveTo(0.2, var_25_9), "I", 2.5), function()
			arg_25_0:sendEvent(var_0_0.EventType.efc_screen_attack_card, {
				_startPos = var_25_8,
				_endPos = var_25_9
			})

			if arg_25_2 == var_0_0.Action.attack_card then
				arg_25_0:efcCardHurt(var_25_7._pBoardCards[arg_25_4._pos], nil, var_25_11)
			end

			arg_25_0._audioEngine:playEffect("e_card_hurt")
		end, lc.ease(lc.moveTo(0.2, var_25_8), "BackO", 2.5), function()
			var_25_5:startFloat()
			arg_25_1:updateZOrder()
			arg_25_0:updateBoardCardsActive()
		end))

		return arg_25_3 + 0.4, 0.4
	elseif arg_25_2 == var_0_0.Action.attack_fortress then
		local var_25_28 = arg_25_1._pFrame._image:getOpacity() ~= 0 and arg_25_1._pFrame._image or arg_25_1._pFrame._bones
		local var_25_29 = var_25_28:getParent()
		local var_25_30 = arg_25_4._owner == arg_25_0._player and arg_25_0 or arg_25_0._opponentUi
		local var_25_31

		if not arg_25_0._battleUi._isReverse then
			var_25_31 = var_25_30._isController and var_0_0.Pos.attacker_fortress or var_0_0.Pos.defender_fortress
		else
			var_25_31 = var_25_30._isController and var_0_0.Pos.defender_fortress or var_0_0.Pos.attacker_fortress
		end

		if var_25_0._owner == arg_25_4._owner then
			if not arg_25_0._battleUi._isReverse then
				var_25_31 = var_25_30._isController and cc.p(0, 0) or cc.p(ClientView.SCR_W, ClientView.SCR_H)
			else
				var_25_31 = var_25_30._isController and cc.p(ClientView.SCR_W, ClientView.SCR_H) or cc.p(0, 0)
			end
		end

		local var_25_32 = cc.p(var_25_28:getPosition())
		local var_25_33 = var_25_29:convertToNodeSpace3D(var_25_31, ClientData._camera3D)

		arg_25_1:updateZOrder(true)
		var_25_28:stopAllActions()
		var_25_28:runAction(lc.sequence(arg_25_3 + 0.4, lc.ease(lc.moveTo(0.2, var_25_33), "I", 2.5), function()
			arg_25_0:sendEvent(var_0_0.EventType.efc_screen_fortress_hurt)
			arg_25_0._audioEngine:playEffect("e_card_hurt")
		end, lc.ease(lc.moveTo(0.2, var_25_32), "BackO", 2.5), function()
			var_25_28:startFloat()
			arg_25_1:updateZOrder()
			arg_25_0:updateBoardCardsActive()
		end))

		return arg_25_3 + 0.6, 0.4
	elseif arg_25_2 == var_0_0.Action.boss_attack_fortress or arg_25_2 == var_0_0.Action.boss_attack_card then
		local var_25_34 = arg_25_2 == var_0_0.Action.boss_attack_card and "attack" or "attack_fortress"
		local var_25_35 = arg_25_0._boss:getAnimationDuration(var_25_34)
		local var_25_36 = 0
		local var_25_37 = cc.p(var_0_0.Pos.boss.x, var_0_0.Pos.boss.y)
		local var_25_38 = cc.p(ClientView.SCR_CW, var_0_0.Pos.attacker_fortress.y)
		local var_25_39 = lc.sequence(arg_25_3, function()
			arg_25_0:efcBossDragonBones(var_25_34)
		end, var_25_36, function()
			arg_25_0:sendEvent(var_0_0.EventType.efc_screen_attack_card, {
				_startPos = var_25_37,
				_endPos = var_25_38
			})
			arg_25_0._audioEngine:playEffect("e_card_hurt")
		end)
		local var_25_40 = 10002

		var_25_39:setTag(var_25_40)
		arg_25_0._battleUi:stopActionByTag(var_25_40)
		arg_25_0._battleUi:runAction(var_25_39)

		return arg_25_3 + var_25_36, var_25_35
	elseif arg_25_2 == var_0_0.Action.fortress_hurt then
		arg_25_0:playAction(arg_25_1, var_0_0.Action.fortress_hp_update, arg_25_3)
		arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
			arg_25_0:efcFortressHurt(arg_25_4)
		end)))

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.boss_hurt then
		arg_25_0:playAction(arg_25_1, var_0_0.Action.fortress_hp_update, arg_25_3)
		arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
			arg_25_0:efcBossHurt(arg_25_4)
		end)))

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.card_hurt then
		local var_25_41 = arg_25_0._isController and -1 or 1

		arg_25_0:playAction(arg_25_1, var_0_0.Action.hp_update, arg_25_3)
		arg_25_1:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
			arg_25_0:efcCardHurt(arg_25_1, arg_25_4)
			arg_25_1:updateZOrder()
		end), cc.MoveBy:create(0.12, cc.p(0, 15 * var_25_41)), cc.MoveBy:create(0.12, cc.p(0, -15 * var_25_41))))

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.fortress_die then
		arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
			arg_25_0:efcFortressDie()
		end)))

		return arg_25_3 + 2
	elseif arg_25_2 == var_0_0.Action.boss_die then
		arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
			arg_25_0:efcBossDie()
		end)))

		return arg_25_3 + 2
	elseif arg_25_2 == var_0_0.Action.fortress_hp_update then
		if arg_25_0._player._fortressHp == 0 then
			return arg_25_3
		end

		local var_25_42 = arg_25_0._pHpLabel
		local var_25_43 = arg_25_0:getLabelColor(arg_25_0._player._fortress._hp, arg_25_0._player._fortress._maxHp)
		local var_25_44 = lc.Color3B.white

		if arg_25_0._player._fortress._hp > tonumber(var_25_42:getString()) then
			var_25_44 = lc.Color3B.green
		elseif arg_25_0._player._fortress._hp < tonumber(var_25_42:getString()) then
			var_25_44 = lc.Color3B.red
		end

		var_25_42:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
			var_25_42:setColor(var_25_44)
			arg_25_0:updateFortressHp()
		end), lc.scaleTo(0.16, 0.8), lc.scaleTo(0.12, 1.1), lc.scaleTo(0.08, 0.9), lc.scaleTo(0.04, 1), cc.TintTo:create(1, var_25_43.r, var_25_43.g, var_25_43.b)))

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.fortress_atk_update then
		local var_25_45 = arg_25_0._pAtkLabel
		local var_25_46 = arg_25_0:getLabelColor(arg_25_0._player._fortress._atk, arg_25_0._player._fortress._maxAtk)
		local var_25_47 = lc.Color3B.white

		if arg_25_0._player._fortress._atk > tonumber(var_25_45:getString()) then
			var_25_47 = lc.Color3B.green
		elseif arg_25_0._player._fortress._atk < tonumber(var_25_45:getString()) then
			var_25_47 = lc.Color3B.red
		end

		var_25_45:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
			var_25_45:setColor(var_25_47)
			arg_25_0:updateFortressAtk()
		end), lc.scaleTo(0.16, 0.8), lc.scaleTo(0.12, 1.1), lc.scaleTo(0.08, 0.9), lc.scaleTo(0.04, 1), cc.TintTo:create(1, var_25_46.r, var_25_46.g, var_25_46.b)))

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.atk_update then
		if arg_25_1._pAtkSpr ~= nil then
			local var_25_48 = arg_25_1._status == CardSprite.Status.fight and 2 or 1.2

			arg_25_1._pAtkSpr:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
				arg_25_1:updateAtkHp()
			end)))
			arg_25_1._pAtkSpr:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
				arg_25_1._pAtkSpr:setScale(var_25_48)
			end), lc.scaleTo(0.16, var_25_48 * 0.8), lc.scaleTo(0.12, var_25_48 * 1.2), lc.scaleTo(0.08, var_25_48 * 0.9), lc.scaleTo(0.04, var_25_48)))
		end

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.hp_update then
		if arg_25_1._pHpSpr ~= nil then
			local var_25_49 = arg_25_1._status == CardSprite.Status.fight and 2 or 1.2

			arg_25_1._pHpSpr:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
				arg_25_1:updateAtkHp()
			end)))
			arg_25_1._pHpSpr:runAction(lc.sequence(lc.delay(arg_25_3), lc.scaleTo(0.16, var_25_49 * 0.8), lc.scaleTo(0.12, var_25_49 * 1.2), lc.scaleTo(0.08, var_25_49 * 0.9), lc.scaleTo(0.04, var_25_49)))
		end

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.times_update then
		arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
			arg_25_1:updateTimes()
		end)))

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.fortress_hp_inc or arg_25_2 == var_0_0.Action.fortress_hp_dec then
		arg_25_0:playAction(arg_25_1, var_0_0.Action.fortress_hp_update, arg_25_3)

		if arg_25_4 ~= 0 then
			arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
				arg_25_0:efcFortressHpLabel(arg_25_4)
			end)))
		end

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.fortress_atk_inc or arg_25_2 == var_0_0.Action.fortress_atk_dec then
		arg_25_0:playAction(arg_25_1, var_0_0.Action.fortress_atk_update, arg_25_3)

		if arg_25_4 ~= 0 then
			arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
				arg_25_0:efcFortressAtkLabel(arg_25_4)
			end)))
		end

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.hp_inc or arg_25_2 == var_0_0.Action.hp_dec then
		if arg_25_1 and arg_25_1._pHpSpr ~= nil then
			arg_25_0:playAction(arg_25_1, var_0_0.Action.hp_update, arg_25_3)
			arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
				arg_25_0:efcCardHpLabel(arg_25_1, arg_25_4)
			end)))
		end

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.atk_inc or arg_25_2 == var_0_0.Action.atk_dec then
		if arg_25_1 and arg_25_1._pAtkSpr ~= nil then
			arg_25_0:playAction(arg_25_1, var_0_0.Action.atk_update, arg_25_3)
			arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
				arg_25_0:efcCardAtkLabel(arg_25_1, arg_25_4)
			end)))
		end

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.change_nature then
		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.update_positive_status then
		if arg_25_1 ~= nil then
			arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
				if arg_25_1._card:isMonsterRare() or arg_25_1._card._type == Data.CardType.magic or arg_25_1._card._type == Data.CardType.trap then
					arg_25_1:updatePositiveStatus()
				elseif arg_25_1._card._type == Data.CardType.boss and arg_25_1._card._info._isDeamon == 1 then
					arg_25_0:efcBossPositiveStatus(arg_25_1, arg_25_1._card)
				end
			end)))
		else
			arg_25_0:efcFortressPositiveStatus(arg_25_0._avatarFrame, arg_25_0._player._fortress)
		end

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.update_negative_status then
		if arg_25_1 ~= nil and arg_25_1._card._type ~= Data.CardType.boss then
			arg_25_0._battleUi:runAction(lc.sequence(lc.delay(arg_25_3), lc.call(function()
				arg_25_1:updateNegativeStatus()
			end)))
		else
			arg_25_0:efcFortressNegativeStatus(arg_25_0._avatarFrame, arg_25_0._player._fortress)
		end

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.avoid_attack then
		local var_25_50 = arg_25_0._isController and -1 or 1

		arg_25_1:runAction(lc.sequence(cc.EaseOut:create(lc.spawn(cc.MoveBy:create(0.2, cc.p(-50 * var_25_50, 30 * var_25_50)), cc.RotateBy:create(0.2, -10 * var_25_50)), 3), cc.EaseIn:create(lc.spawn(cc.MoveBy:create(0.1, cc.p(50 * var_25_50, -30 * var_25_50)), cc.RotateBy:create(0.1, 10 * var_25_50)), 3)))
		arg_25_1._pShadowArea:runAction(lc.sequence(cc.EaseOut:create(cc.MoveBy:create(0.2, cc.p(-60, -30)), 3), cc.EaseOut:create(cc.MoveBy:create(0.1, cc.p(60, 30)), 3)))

		return arg_25_3
	elseif arg_25_2 == var_0_0.Action.update_bind then
		-- block empty
	else
		lc.log("[PLAYER UI] UNHANDLED ACTION!!!")

		return arg_25_3
	end
end

function var_0_0.showHandCards(arg_51_0)
	local var_51_0 = #arg_51_0._pHandCards
	local var_51_1 = 130 + (8 - var_51_0) * 15

	if arg_51_0._isController then
		for iter_51_0, iter_51_1 in ipairs(arg_51_0._pHandCards) do
			local var_51_2 = cc.p(ClientView.SCR_CW + (iter_51_0 - (var_51_0 / 2 + 0.5)) * var_51_1, var_0_0.Pos.attacker_board_y - 150)
			local var_51_3 = iter_51_1._default._position
			local var_51_4 = iter_51_1._default._rotation

			iter_51_1:runAction(lc.sequence(lc.delay(iter_51_0 * 0.2), lc.call(function()
				iter_51_1:updateZOrder(true)
			end), cc.EaseBackOut:create(lc.spawn(lc.moveTo(0.3, var_51_2), lc.rotateTo(0.3, 0), lc.scaleTo(0.3, 1.3))), lc.delay((var_51_0 - iter_51_0) * 0.2 + 1), cc.EaseBackOut:create(lc.spawn(lc.moveTo(0.3, var_51_3), lc.rotateTo(0.3, var_51_4), lc.scaleTo(0.3, 1))), lc.call(function()
				iter_51_1:updateZOrder()
			end)))
		end

		return var_51_0 * 0.2 + 1.8
	else
		for iter_51_2, iter_51_3 in ipairs(arg_51_0._pHandCards) do
			local var_51_5 = cc.p(ClientView.SCR_CW + (iter_51_2 - (var_51_0 / 2 + 0.5)) * var_51_1, var_0_0.Pos.defender_board_y + 35)
			local var_51_6 = iter_51_3._default._position
			local var_51_7 = iter_51_3._default._rotation

			iter_51_3:runAction(lc.sequence(lc.delay(iter_51_2 * 0.2), lc.call(function()
				iter_51_3:updateZOrder(true)
			end), cc.EaseBackOut:create(lc.spawn(lc.moveTo(0.3, var_51_5), lc.rotateTo(0.3, 0), lc.scaleTo(0.3, 1.3))), cc.RotateBy:create(0.2, {
				z = 0,
				x = 0,
				y = 90
			}), lc.call(function()
				iter_51_3:initNormal()
				iter_51_3:setRotation3D({
					z = 0,
					x = 0,
					y = -90
				})
			end), cc.RotateBy:create(0.2, {
				z = 0,
				x = 0,
				y = 90
			}), lc.delay((var_51_0 - iter_51_2) * 0.2 + 1.4), cc.RotateBy:create(0.2, {
				z = 0,
				x = 0,
				y = 90
			}), lc.call(function()
				iter_51_3:initBack()
				iter_51_3:setRotation3D({
					z = 0,
					x = 0,
					y = -90
				})
			end), cc.RotateBy:create(0.2, {
				z = 0,
				x = 0,
				y = 90
			}), cc.EaseBackOut:create(lc.spawn(lc.moveTo(0.3, var_51_6), lc.rotateTo(0.3, var_51_7), lc.scaleTo(0.3, 1))), lc.call(function()
				iter_51_3:updateZOrder()
			end)))
		end

		return var_51_0 * 0.2 + 3
	end
end

function var_0_0.replaceHandCards(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = 0

	for iter_58_0, iter_58_1 in ipairs(arg_58_0._pHandCards) do
		if iter_58_1 and iter_58_1._card ~= arg_58_2 then
			arg_58_0:calHandCardPosAndRot(iter_58_1)

			if iter_58_1._status ~= CardSprite.Status.large and iter_58_1._status ~= CardSprite.Status.info then
				local var_58_1 = cc.p(iter_58_1:getPosition())
				local var_58_2 = iter_58_1._default._position

				if var_58_1.x ~= var_58_2.x or var_58_1.y ~= var_58_2.y then
					iter_58_1:stopAllActions()

					var_58_0 = arg_58_0:playAction(iter_58_1, var_0_0.Action.replace_hand_card, arg_58_1, iter_58_0)
				end
			end
		end
	end

	return arg_58_1 + var_58_0
end

function var_0_0.replaceBoardCards(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = 0

	if arg_59_1 == nil then
		arg_59_1 = 0
	end

	for iter_59_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		local var_59_1 = arg_59_0._pBoardCards[iter_59_0]

		if var_59_1 and var_59_1._card ~= arg_59_2 then
			arg_59_0:calBoardCardPos(var_59_1)

			local var_59_2 = cc.p(var_59_1:getPosition())
			local var_59_3 = var_59_1._default._position

			if var_59_2.x ~= var_59_3.x or var_59_2.y ~= var_59_3.y then
				var_59_1:stopAllActions()

				var_59_0 = arg_59_0:playAction(var_59_1, var_0_0.Action.replace_board_card, arg_59_1, iter_59_0)
			end
		end
	end

	return arg_59_1 + var_59_0
end

function var_0_0.addGraveCard(arg_60_0, arg_60_1)
	arg_60_1:stopAllActions()
	arg_60_1:setVisible(true)
	arg_60_1:setOpacity(255)
	arg_60_1:setRotation(0)
	arg_60_1:setScale(0.75)
	arg_60_1:setPosition(27, 27)
	arg_60_1._pShadowArea:stopAllActions()
	arg_60_1._pShadowArea:setPosition(0, 0)
	arg_60_1._pShadowArea:setRotation(0)
	arg_60_0:resetCard(arg_60_1)
	arg_60_1:initDead()
	arg_60_1:setTag(1)
	arg_60_1._pEffectArea:removeAllChildren()
	arg_60_1._pBottomEffectArea:removeAllChildren()
	arg_60_1:setPosition(arg_60_0._isController and var_0_0.Pos.attacker_grave or var_0_0.Pos.defender_grave)
	arg_60_0:updateGraveArea()
end

function var_0_0.addRareCard(arg_61_0, arg_61_1)
	arg_61_1:stopAllActions()
	arg_61_1:setVisible(true)
	arg_61_1:setOpacity(255)
	arg_61_1:setRotation(0)
	arg_61_1:setScale(0.75)
	arg_61_1:setPosition(27, 27)
	arg_61_1._pShadowArea:stopAllActions()
	arg_61_1._pShadowArea:setPosition(0, 0)
	arg_61_1._pShadowArea:setRotation(0)
	arg_61_0:resetCard(arg_61_1)

	if arg_61_0._isController or arg_61_0._battleUi._isObserver and not arg_61_0._hideHandCards then
		arg_61_1:initDead()
	else
		arg_61_1:initBack()
		arg_61_1:setRotation3D({
			z = 0,
			x = 0,
			y = 0
		})
	end

	arg_61_1:setTag(1)
	arg_61_1._pEffectArea:removeAllChildren()
	arg_61_1._pBottomEffectArea:removeAllChildren()
	arg_61_1:setPosition(arg_61_0._isController and var_0_0.Pos.attacker_rare or var_0_0.Pos.defender_rare)
	arg_61_0:updateRareArea(#arg_61_0._pGraveCards)
end

function var_0_0.addCoverCard(arg_62_0, arg_62_1)
	arg_62_1._pFrame:setTag(321)
	arg_62_1:stopAllActions()
	arg_62_1:setVisible(true)
	arg_62_1:setOpacity(255)
	arg_62_1:initCover()
	arg_62_1:setRotation(0)
	arg_62_1:setScale(1)
	arg_62_1:runAction(lc.moveTo(0.3, arg_62_1._default._position))
	arg_62_1._pShadowArea:stopAllActions()
	arg_62_1._pShadowArea:setPosition(0, 0)
	arg_62_1._pShadowArea:setRotation(0)
end

function var_0_0.addShowCard(arg_63_0, arg_63_1)
	arg_63_1:stopAllActions()
	arg_63_1:setVisible(true)
	arg_63_1:setOpacity(255)
	arg_63_1:initShow()
	arg_63_1:setRotation(0)
	arg_63_1:setScale(1)
	arg_63_1:runAction(lc.moveTo(0.3, arg_63_1._default._position))
	arg_63_1._pShadowArea:stopAllActions()
	arg_63_1._pShadowArea:setPosition(0, 0)
	arg_63_1._pShadowArea:setRotation(0)

	if arg_63_1._card:isInInfoIdGroup(Data._skillInfo[13065]._refCards) then
		local var_63_0 = arg_63_1._card._targetOppoOrigin._info._nature
		local var_63_1 = lc.createSprite("card_nature_0" .. var_63_0)

		lc.addChildToPos(arg_63_1._pFrameIcon, var_63_1, cc.p(-20, -160), 1)
		arg_63_0._scene:seenByCamera3D(var_63_1)

		arg_63_1._natureIcon = var_63_1

		local var_63_2 = arg_63_1._card._targetOppoOrigin._info._category
		local var_63_3 = ClientView.createTTF(Str(STR.CARD_CATEGORY_BEGIN + var_63_2), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)

		var_63_3:enableOutline(lc.Color4B.black, 1)
		var_63_3:setScale(0.8)
		var_63_3:setAnchorPoint(0, 0)
		lc.addChildToPos(arg_63_1._pFrameIcon, var_63_3, cc.p(-4, -4), 1)
		arg_63_0._scene:seenByCamera3D(var_63_3)

		arg_63_1._categoryLabel = var_63_3
	end
end

function var_0_0.addFieldCard(arg_64_0, arg_64_1)
	arg_64_1:stopAllActions()
	arg_64_1:setVisible(true)
	arg_64_1:setOpacity(255)
	arg_64_1:initField()
	arg_64_1:setRotation(0)
	arg_64_1:setScale(1)
	arg_64_1:runAction(lc.moveTo(0.3, arg_64_1._default._position))
	arg_64_1._pShadowArea:stopAllActions()
	arg_64_1._pShadowArea:setPosition(0, 0)
	arg_64_1._pShadowArea:setRotation(0)
end

function var_0_0.removeCardToOppo(arg_65_0, arg_65_1)
	arg_65_0:removeCardFromSprites(arg_65_1)
	arg_65_0._opponentUi:addCardToSprites(arg_65_1)
	arg_65_1:setPlayerUi(arg_65_0._opponentUi)

	local var_65_0 = arg_65_1._card

	if var_65_0:isMonsterRare() and var_65_0._status == BattleData.CardStatus.board then
		arg_65_1:reloadAllStatus()
	end
end

function var_0_0.removeCardFromSprites(arg_66_0, arg_66_1)
	if arg_66_1 == nil then
		return
	end

	local var_66_0 = arg_66_1._card

	arg_66_0._cardSprites[var_66_0._id] = nil
end

function var_0_0.addCardToSprites(arg_67_0, arg_67_1)
	if arg_67_1 == nil then
		return
	end

	local var_67_0 = arg_67_1._card

	arg_67_0._cardSprites[var_67_0._id] = arg_67_1
	arg_67_1._isAttacker = arg_67_0._battleUi._isAttacker
	arg_67_1._isController = arg_67_0._isAttacker == arg_67_0._battleUi._isAttacker

	if arg_67_1._pHorse ~= nil then
		arg_67_0:addCardToSprites(arg_67_1._pHorse)
	end
end

function var_0_0.doReorderHand(arg_68_0)
	for iter_68_0, iter_68_1 in ipairs(arg_68_0._pHandCards) do
		local var_68_0, var_68_1 = arg_68_0:calHandCardPosAndRot(iter_68_1)

		iter_68_1:setPosition(var_68_0)
		iter_68_1:setRotation3D(var_68_1)
	end
end

function var_0_0.doReorderBoard(arg_69_0)
	for iter_69_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
		local var_69_0 = arg_69_0._pBoardCards[iter_69_0]

		if var_69_0 ~= nil then
			local var_69_1 = arg_69_0:calBoardCardPos(var_69_0)

			var_69_0:setPosition(var_69_1)
		end
	end
end
