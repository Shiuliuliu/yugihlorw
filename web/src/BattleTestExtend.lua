function CardSprite.fastToBoard(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._ownerUi
	local var_1_1 = var_1_0._battleUi

	arg_1_0:updateActive(false)
	arg_1_0:setScale(1)

	if var_1_0._isController and arg_1_0._status ~= CardSprite.Status.normal then
		arg_1_0:initNormal()
	elseif not var_1_0._isController and arg_1_0._status ~= CardSprite.Status.back then
		arg_1_0:initBack()
	end

	if arg_1_0._card._sourceStatus == BattleData.CardStatus.pile then
		arg_1_0:setPosition(cc.p(ClientView.SCR_CW, ClientView.SCR_CH))
	elseif arg_1_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_1_0:replaceHandCards(0, arg_1_0._card)
	end

	arg_1_0:runAction(lc.sequence(lc.call(function()
		arg_1_0:updateZOrder(true)
	end), lc.call(function()
		var_1_1._audioEngine:playEffect("e_card_using")
		var_1_1._audioEngine:playHeroAudio(arg_1_0._card._infoId, false)

		if arg_1_0._status ~= CardSprite.Status.normal then
			arg_1_0:initNormal()
		end
	end), lc.ease(lc.spawn(lc.moveTo(0, arg_1_0._default._position)), "O", 0.4), lc.call(function()
		var_1_1._audioEngine:playEffect("e_card_board")
		arg_1_0:initFight()
		arg_1_0:updateZOrder()
		var_1_0:updateBoardCardsActive()
	end)))

	return arg_1_1
end

function CardSprite.fastToShow(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._ownerUi
	local var_5_1 = var_5_0._opponentUi
	local var_5_2 = var_5_0._battleUi

	arg_5_0:updateActive(false)

	if arg_5_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_5_0:replaceHandCards(0, arg_5_0._card)
	end

	var_5_0:addShowCardFast(arg_5_0)
	arg_5_0:updateZOrder()

	return arg_5_1
end

function CardSprite.fastToField(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._ownerUi
	local var_6_1 = var_6_0._opponentUi
	local var_6_2 = var_6_0._battleUi

	arg_6_0:updateActive(false)

	if arg_6_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_6_0:replaceHandCards(0, arg_6_0._card)
	end

	var_6_0:addFieldCardFast(arg_6_0)
	arg_6_0:updateZOrder()

	return arg_6_1
end

function CardSprite.fastToCover(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._ownerUi
	local var_7_1 = var_7_0._opponentUi
	local var_7_2 = var_7_0._battleUi

	arg_7_0:updateActive(false)

	if arg_7_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_7_0:replaceHandCards(0, arg_7_0._card)
	end

	var_7_0:addCoverCardFast(arg_7_0)
	arg_7_0:updateZOrder()

	return arg_7_1
end

function CardSprite.fastToHand(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._ownerUi
	local var_8_1 = var_8_0._opponentUi
	local var_8_2 = var_8_0._battleUi

	arg_8_0:updateActive(false)

	for iter_8_0, iter_8_1 in ipairs(var_8_0._pHandCards) do
		if iter_8_1 and iter_8_1._card ~= card then
			var_8_0:calHandCardPosAndRot(iter_8_1)

			if iter_8_1._status ~= CardSprite.Status.large and iter_8_1._status ~= CardSprite.Status.info then
				local var_8_3 = cc.p(iter_8_1:getPosition())
				local var_8_4 = iter_8_1._default._position

				if var_8_3.x ~= var_8_4.x or var_8_3.y ~= var_8_4.y then
					iter_8_1:stopAllActions()

					local var_8_5 = iter_8_1._default._position
					local var_8_6 = iter_8_1._default._rotation

					if cc.p(iter_8_1:getPosition()).x == var_8_5.x and cc.p(iter_8_1:getPosition()).y == var_8_5.y and iter_8_1:getRotation() == var_8_6 and iter_8_1:getScale() == 1 then
						-- block empty
					else
						iter_8_1:runAction(lc.sequence(lc.call(function()
							iter_8_1:updateZOrder()
						end), cc.EaseOut:create(lc.spawn(lc.moveTo(0, var_8_5)), 2.5)))
					end
				end
			end
		end
	end

	if arg_8_2 then
		arg_8_0:initNormal()
	elseif var_8_0._isController and arg_8_0._status ~= CardSprite.Status.normal then
		arg_8_0:initNormal()
	elseif not var_8_0._isController and arg_8_0._status ~= CardSprite.Status.back then
		arg_8_0:initBack()
	end

	return arg_8_1
end

function CardSprite.fastToRare(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._ownerUi
	local var_10_1 = var_10_0._battleUi

	arg_10_0:updateActive(false)

	if arg_10_2 == true then
		var_10_0:addRareCardFast(arg_10_0)
	else
		var_10_0:addRareCard(arg_10_0)
	end

	arg_10_0:updateZOrder(true)

	return arg_10_1
end

function PlayerUi.addCardToPileFast(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getCardSprite(arg_11_1)

	arg_11_0:sendEvent(PlayerUi.EventType.update_card_pile_count)
	var_11_0:fastToPile(0)
end

function PlayerUi.addCardToHandFast(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getCardSprite(arg_12_1) or arg_12_0._opponentUi:getCardSprite(arg_12_1)

	arg_12_0._pHandCards[arg_12_1._pos] = var_12_0

	arg_12_0:calHandCardPosAndRot(var_12_0)
	var_12_0:fastToHand(0, true)
end

function PlayerUi.addCardToBoardFast(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getCardSprite(arg_13_1)

	if arg_13_1:isMonsterRare() then
		arg_13_0._pBoardCards[arg_13_1._pos] = var_13_0

		arg_13_0:calBoardCardPos(var_13_0)
	end

	var_13_0:fastToBoard(0)
end

function PlayerUi.addCardToRareFast(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getCardSprite(arg_14_1)

	table.insert(arg_14_0._pRareCards, var_14_0)
	var_14_0:fastToRare(0, true)
end

function PlayerUi.addCardToShowFast(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getCardSprite(arg_15_1)

	if arg_15_1._type == Data.CardType.trap or arg_15_1._type == Data.CardType.magic then
		arg_15_0._pShowCards[arg_15_1._pos] = var_15_0
		var_15_0._default._position = arg_15_0._coverPos[arg_15_1._pos]
	end

	var_15_0:fastToShow(0)
end

function PlayerUi.addRareCardFast(arg_16_0, arg_16_1)
	arg_16_1:stopAllActions()
	arg_16_1:setVisible(true)
	arg_16_1:setOpacity(255)
	arg_16_1:setRotation(0)
	arg_16_1:setScale(0.75)
	arg_16_1:setPosition(27, 27)
	arg_16_1._pShadowArea:stopAllActions()
	arg_16_1._pShadowArea:setPosition(0, 0)
	arg_16_1._pShadowArea:setRotation(0)
	arg_16_0:resetCard(arg_16_1)

	if arg_16_0._isController then
		arg_16_1:initDead()
	else
		arg_16_1:initNormal()
		arg_16_1:setRotation3D({
			z = 0,
			x = 0,
			y = 0
		})
	end

	arg_16_1:setTag(1)
	arg_16_1._pEffectArea:removeAllChildren()
	arg_16_1._pBottomEffectArea:removeAllChildren()
	arg_16_1:setPosition(arg_16_0._isController and PlayerUi.Pos.attacker_rare or PlayerUi.Pos.defender_rare)
	arg_16_0:updateRareArea(#arg_16_0._pGraveCards)
end

function PlayerUi.addShowCardFast(arg_17_0, arg_17_1)
	arg_17_1:stopAllActions()
	arg_17_1:setVisible(true)
	arg_17_1:setOpacity(255)
	arg_17_1:initShow()
	arg_17_1:setRotation(0)
	arg_17_1:setScale(1)
	arg_17_1:runAction(lc.moveTo(0, arg_17_1._default._position))
	arg_17_1._pShadowArea:stopAllActions()
	arg_17_1._pShadowArea:setPosition(0, 0)
	arg_17_1._pShadowArea:setRotation(0)
end

function PlayerUi.addFieldCardFast(arg_18_0, arg_18_1)
	arg_18_1:stopAllActions()
	arg_18_1:setVisible(true)
	arg_18_1:setOpacity(255)
	arg_18_1:initField()
	arg_18_1:setRotation(0)
	arg_18_1:setScale(1)
	arg_18_1:runAction(lc.moveTo(0, arg_18_1._default._position))
	arg_18_1._pShadowArea:stopAllActions()
	arg_18_1._pShadowArea:setPosition(0, 0)
	arg_18_1._pShadowArea:setRotation(0)
end

function PlayerUi.addCoverCardFast(arg_19_0, arg_19_1)
	arg_19_1._pFrame:setTag(321)
	arg_19_1:stopAllActions()
	arg_19_1:setVisible(true)
	arg_19_1:setOpacity(255)
	arg_19_1:initCover()
	arg_19_1:setRotation(0)
	arg_19_1:setScale(1)
	arg_19_1:runAction(lc.moveTo(0, arg_19_1._default._position))
	arg_19_1._pShadowArea:stopAllActions()
	arg_19_1._pShadowArea:setPosition(0, 0)
	arg_19_1._pShadowArea:setRotation(0)
end

function PlayerUi.swapCardsInGrave(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_2._pos, arg_20_1._pos = arg_20_1._pos, arg_20_2._pos

	if arg_20_3 == BattleTestListDialog.SwapTarget.player then
		arg_20_0._player._graveCards[arg_20_1._pos] = arg_20_1
		arg_20_0._player._graveCards[arg_20_2._pos] = arg_20_2
	elseif arg_20_3 == BattleTestListDialog.SwapTarget.opponent then
		arg_20_0._opponent._graveCards[arg_20_1._pos] = arg_20_1
		arg_20_0._opponent._graveCards[arg_20_2._pos] = arg_20_2
	end

	local var_20_0 = arg_20_0:getCardSprite(arg_20_1)
	local var_20_1 = arg_20_0:getCardSprite(arg_20_2)

	for iter_20_0 = 1, #arg_20_0._pGraveCards do
		if var_20_0 == arg_20_0._pGraveCards[iter_20_0] then
			arg_20_0._pGraveCards[iter_20_0] = var_20_1
		elseif var_20_1 == arg_20_0._pGraveCards[iter_20_0] then
			arg_20_0._pGraveCards[iter_20_0] = var_20_0
		end
	end

	arg_20_0:updateGraveArea()
end

function PlayerUi.swapCardsInRare(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_2._pos, arg_21_1._pos = arg_21_1._pos, arg_21_2._pos

	if arg_21_3 == BattleTestListDialog.SwapTarget.player then
		arg_21_0._player._rareCards[arg_21_1._pos] = arg_21_1
		arg_21_0._player._rareCards[arg_21_2._pos] = arg_21_2
	elseif arg_21_3 == BattleTestListDialog.SwapTarget.opponent then
		arg_21_0._opponent._rareCards[arg_21_1._pos] = arg_21_1
		arg_21_0._opponent._rareCards[arg_21_2._pos] = arg_21_2
	end

	local var_21_0 = arg_21_0:getCardSprite(arg_21_1)
	local var_21_1 = arg_21_0:getCardSprite(arg_21_2)

	for iter_21_0 = 1, #arg_21_0._pRareCards do
		if var_21_0 == arg_21_0._pRareCards[iter_21_0] then
			arg_21_0._pRareCards[iter_21_0] = var_21_1
		elseif var_21_1 == arg_21_0._pRareCards[iter_21_0] then
			arg_21_0._pRareCards[iter_21_0] = var_21_0
		end
	end

	arg_21_0:updateRareArea()
end

function PlayerUi.swapCardsInPile(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_2._pos, arg_22_1._pos = arg_22_1._pos, arg_22_2._pos

	if arg_22_3 == BattleTestListDialog.SwapTarget.player then
		arg_22_0._player._pileCards[arg_22_1._pos] = arg_22_1
		arg_22_0._player._pileCards[arg_22_2._pos] = arg_22_2
	elseif arg_22_3 == BattleTestListDialog.SwapTarget.opponent then
		arg_22_0._opponent._pileCards[arg_22_1._pos] = arg_22_1
		arg_22_0._opponent._pileCards[arg_22_2._pos] = arg_22_2
	end

	arg_22_0._battleUi:updatePile(arg_22_0)
end

function PlayerUi.swapCardsInHand(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_2._pos, arg_23_1._pos = arg_23_1._pos, arg_23_2._pos

	if arg_23_3 == BattleTestListDialog.SwapTarget.player then
		arg_23_0._player._handCards[arg_23_1._pos] = arg_23_1
		arg_23_0._player._handCards[arg_23_2._pos] = arg_23_2
	elseif arg_23_3 == BattleTestListDialog.SwapTarget.opponent then
		arg_23_0._opponent._handCards[arg_23_1._pos] = arg_23_1
		arg_23_0._opponent._handCards[arg_23_2._pos] = arg_23_2
	end

	local var_23_0 = arg_23_0:getCardSprite(arg_23_1)
	local var_23_1 = arg_23_0:getCardSprite(arg_23_2)

	for iter_23_0 = 1, #arg_23_0._pHandCards do
		if var_23_0 == arg_23_0._pHandCards[iter_23_0] then
			arg_23_0._pHandCards[iter_23_0] = var_23_1
		elseif var_23_1 == arg_23_0._pHandCards[iter_23_0] then
			arg_23_0._pHandCards[iter_23_0] = var_23_0
		end
	end

	arg_23_0:replaceHandCards(0)
end

function PlayerUi.setFortressHp(arg_24_0, arg_24_1)
	arg_24_1 = arg_24_1 or arg_24_0._player._fortress._hp

	if arg_24_0._player._fortressHp == 0 then
		arg_24_0._pHpLabel:setString("???")
	else
		arg_24_0._pHpLabel:setString(arg_24_1)
	end
end
