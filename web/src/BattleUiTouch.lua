local var_0_0 = BattleUi

function var_0_0.onTouchBegan(arg_1_0, arg_1_1)
	if arg_1_0._choicePosDialog then
		return arg_1_0._choicePosDialog:onTouchBegan(arg_1_1)
	end

	if not arg_1_0:isVisible() or arg_1_0._isTouching or arg_1_1:getId() ~= 0 then
		return false
	end

	if P._guideID < 20 then
		return false
	end

	if arg_1_0._dropLayer then
		arg_1_0._isTouching = arg_1_0._dropLayer:onTouchBegan(arg_1_1)

		return arg_1_0._isTouching
	end

	if arg_1_0._playerUi._isGuideSkill or arg_1_0._opponentUi._isGuideSkill then
		return false
	end

	local var_1_0 = arg_1_0:getTouchedCard(arg_1_1)

	if var_1_0 then
		if var_1_0._status == CardSprite.Status.back and var_1_0._card._status ~= BattleData.CardStatus.cover and var_1_0._card._status ~= BattleData.CardStatus.show and var_1_0._card._status ~= BattleData.CardStatus.field and var_1_0._card._status ~= BattleData.CardStatus.dead then
			if var_1_0._card._status == BattleData.CardStatus.hand then
				if not var_1_0._ownerUi._isController and var_1_0._ownerUi._player._isHandVisible then
					var_1_0:sendEvent(CardSprite.EventType.show_hand_list)
				elseif var_1_0._ownerUi._isController then
					var_1_0._ownerUi:sendEvent(PlayerUi.EventType.dialog_attacker_hand_cards)
				else
					var_1_0._ownerUi:sendEvent(PlayerUi.EventType.dialog_defender_hand_cards)
				end
			elseif var_1_0._card._status == BattleData.CardStatus.rare and not var_1_0._ownerUi._isController and var_1_0._ownerUi._player._isRareVisible then
				var_1_0:sendEvent(CardSprite.EventType.show_rare_list)
			end

			return false
		else
			arg_1_0._isTouching = true
			arg_1_0._touchCard = var_1_0

			var_1_0:onTouchBegan(arg_1_1)

			var_1_0._targetCard = nil

			local var_1_1 = var_1_0._card
			local var_1_2 = var_1_0._card._owner

			if var_1_0._isController and var_1_1._status == BattleData.CardStatus.board and var_1_1:canAction() then
				arg_1_0._arrow = BattleLine.create(var_1_0:convertToWorldSpace3D(cc.p(0, 0), ClientData._camera3D))
				arg_1_0._layer:addChild(arg_1_0._arrow)
			end

			return true
		end
	end

	return false
end

function var_0_0.onTouchMoved(arg_2_0, arg_2_1)
	if arg_2_0._choicePosDialog then
		return arg_2_0._choicePosDialog:onTouchMoved(arg_2_1)
	end

	if not arg_2_0._isTouching then
		return
	end

	if arg_2_0._dropLayer then
		return arg_2_0._dropLayer:onTouchMoved(arg_2_1)
	end

	if arg_2_0._playerUi._isGuideSkill or arg_2_0._opponentUi._isGuideSkill then
		return false
	end

	if not arg_2_0._touchCard then
		return
	end

	local var_2_0 = arg_2_1:getStartLocation()
	local var_2_1 = arg_2_1:getLocation()

	if cc.pGetDistance(var_2_0, var_2_1) <= lc.Gesture.BUDGE_LIMIT then
		return
	end

	local var_2_2 = arg_2_0._touchCard
	local var_2_3 = var_2_2._card
	local var_2_4 = var_2_3._owner
	local var_2_5 = var_2_2._ownerUi

	if arg_2_0._guideTipVals and arg_2_0._guideTipVals.t.touch == 0 or arg_2_0._freeTip then
		arg_2_0:hideTip()
	end

	if arg_2_0._selectTargetLayer then
		return arg_2_0._selectTargetLayer:onTouchMoved(arg_2_1)
	end

	var_2_2:onTouchMoved(arg_2_1)

	if arg_2_0._isOperating then
		if var_2_2._touchEvent._touchCardType == CardSprite.TouchCardType.self_hand_card then
			local var_2_6 = false

			if arg_2_0._isAddingBoardCard then
				var_2_6 = true

				var_2_5:sendEvent(PlayerUi.EventType.dialog_adding_board_card)
			elseif var_2_3:isMonsterRare() then
				if not var_2_4:canUseMonster(var_2_3, false) then
					var_2_6 = true

					var_2_5:sendEvent(PlayerUi.EventType.dialog_not_enough_gem)
				end
			elseif var_2_3._type == Data.CardType.magic then
				if not var_2_4:canUseMagic(var_2_3, false) then
					var_2_6 = true

					var_2_5:sendEvent(PlayerUi.EventType.dialog_cannot_effect, var_2_3._type)
				end
			elseif var_2_3._type == Data.CardType.trap then
				local var_2_7, var_2_8 = var_2_4:canUseTrap(var_2_3, false)

				if not var_2_7 then
					var_2_6 = true

					var_2_5:sendEvent(var_2_8 == "existed" and PlayerUi.EventType.dialog_trap_existed or PlayerUi.EventType.dialog_cannot_effect, var_2_3._type)
				end
			end

			if var_2_6 then
				arg_2_0:hidePreview(var_2_2)
				var_2_2:onTouchEnded(arg_2_1)

				arg_2_0._touchCard = nil

				var_2_5:playAction(var_2_2, PlayerUi.Action.replace_hand_card, 0, 1)

				return
			end

			local var_2_9, var_2_10 = var_2_3:hasTargetUsingSkill()

			if var_2_9 then
				if var_2_3._type == Data.CardType.monster then
					local var_2_11, var_2_12, var_2_13 = var_2_4:canUseMonsterSpecific(var_2_3, true)
					local var_2_14, var_2_15, var_2_16 = var_2_4:canUseMonsterNormal(var_2_3, true, true)

					if var_2_12 ~= nil or var_2_15 ~= nil then
						arg_2_0:showSelectTarget(var_2_2, var_2_10, arg_2_1)

						return
					end
				else
					arg_2_0:showSelectTarget(var_2_2, var_2_10, arg_2_1)

					return
				end
			end

			if var_2_3._type == Data.CardType.monster then
				local var_2_17 = arg_2_0:getTouchedBoardCard(arg_2_1, var_2_2, true, var_2_5)
				local var_2_18, var_2_19 = arg_2_0:getEventDragTo()

				if var_2_19 == BattleEventDialog.Type.guide_drag_to_card and var_2_18 ~= nil and var_2_18 ~= var_2_17 or (var_2_19 == BattleEventDialog.Type.guide_drag_to_pos or var_2_19 == BattleEventDialog.Type.guide_drag_to_attack or var_2_19 == BattleEventDialog.Type.guide_drag_to_defend) and var_2_18 ~= var_2_17 then
					var_2_17 = nil
				end

				if var_2_17 ~= nil and var_2_17 ~= var_2_2._targetCard then
					arg_2_0:hidePreview(var_2_2)
					arg_2_0:preview(var_2_2, var_2_17)
				elseif var_2_17 == nil then
					arg_2_0:hidePreview(var_2_2)
				end
			end
		elseif not arg_2_0._isAddingBoardCard and var_2_3._owner._macroStatus == BattleData.Status.use and var_2_2._touchEvent._touchCardType == CardSprite.TouchCardType.board_card then
			if var_2_3:canAction() then
				local var_2_20 = arg_2_0:getTouchedBoardCard(arg_2_1, var_2_2, false, var_2_5._opponentUi)

				if var_2_20 ~= nil and not var_2_3:canAttackTarget(var_2_20._card, true) then
					var_2_20 = nil
				end

				local var_2_21, var_2_22 = arg_2_0:getEventDragTo()

				if var_2_22 == BattleEventDialog.Type.guide_drag_to_card and var_2_21 ~= nil and var_2_21 ~= var_2_20 or (var_2_22 == BattleEventDialog.Type.guide_drag_to_pos or var_2_22 == BattleEventDialog.Type.guide_drag_to_attack or var_2_22 == BattleEventDialog.Type.guide_drag_to_defend) and var_2_21 ~= var_2_20 then
					var_2_20 = nil
				end

				var_2_2._targetCard = var_2_20

				if var_2_20 ~= nil then
					if arg_2_0._arrow then
						local targetPos = arg_2_0._layer:convertToNodeSpace(var_2_20:convertToWorldSpace3D(cc.p(0, 0), ClientData._camera3D))
						arg_2_0._arrow:directTo(targetPos, var_2_20)
					end

					arg_2_0._playerUi:updateFortressActive(false)
					var_2_2:updateBubble("atk")
				else
					if arg_2_0._arrow then
						arg_2_0._arrow:directTo(arg_2_0._layer:convertToNodeSpace(arg_2_1:getLocation()), nil)
					end

					if arg_2_1:getLocation().y >= PlayerUi.Pos.attack_fortress_area then
						if var_2_3:canAttackTarget(var_2_4._opponent._fortress, true) then
							arg_2_0._opponentUi:updateFortressActive(true)
							var_2_2:updateBubble("atk")
						elseif not var_2_3:canAttack() and var_2_3:hasBuff(true, BattleData.PositiveType.defendPosture) then
							arg_2_0._opponentUi:updateFortressActive(false)
							var_2_2:updateBubble("switch_atk")
						else
							arg_2_0._opponentUi:updateFortressActive(false)
							var_2_2:updateBubble("")
						end
					else
						arg_2_0._opponentUi:updateFortressActive(false)

						if not var_2_3:hasBuff(true, BattleData.PositiveType.defendPosture) and var_2_22 ~= BattleEventDialog.Type.guide_drag_to_attack then
							var_2_2:updateBubble(arg_2_1:getLocation().y <= PlayerUi.Pos.defend_fortress_area and "def" or "")
						else
							var_2_2:updateBubble("")
						end
					end
				end
			end

			if #var_2_3._binds > 0 and not arg_2_0._icons then
				arg_2_0._icons = {}

				for iter_2_0, iter_2_1 in ipairs(var_2_3._binds) do
					local var_2_23 = (arg_2_0._playerUi:getCardSprite(iter_2_1) or arg_2_0._opponentUi:getCardSprite(iter_2_1))._default._position
					local var_2_24 = lc.createSprite("card_ico_equip")

					var_2_24:setCameraMask(ClientData.CAMERA_3D_FLAG)
					lc.addChildToPos(arg_2_0, var_2_24, var_2_23, BattleUi.ZOrder.effect)
					var_2_24:runAction(lc.fadeTo(0.5, 150))

					arg_2_0._icons[#arg_2_0._icons + 1] = var_2_24
				end
			end
		end
	elseif var_2_2._touchEvent._touchCardType == CardSprite.TouchCardType.self_hand_card and arg_2_1:getLocation().y >= PlayerUi.Pos.use_area and arg_2_1:getPreviousLocation().y < PlayerUi.Pos.use_area then
		if var_2_4:getActionPlayer() == var_2_4 then
			var_2_5:sendEvent(PlayerUi.EventType.dialog_adding_board_card)
		else
			var_2_5:sendEvent(PlayerUi.EventType.dialog_not_your_round)
		end

		var_2_2:onTouchEnded(arg_2_1)

		arg_2_0._touchCard = nil

		var_2_5:playAction(var_2_2, PlayerUi.Action.replace_hand_card, 0, 1)
	end
end

function var_0_0.onTouchEnded(arg_3_0, arg_3_1)
	if arg_3_0._choicePosDialog then
		return arg_3_0._choicePosDialog:onTouchEnded(arg_3_1)
	end

	if not arg_3_0._isTouching then
		return
	end

	if arg_3_0._dropLayer then
		arg_3_0._isTouching = false

		return arg_3_0._dropLayer:onTouchEnded(arg_3_1)
	end

	if arg_3_0._playerUi._isGuideSkill or arg_3_0._opponentUi._isGuideSkill then
		return false
	end

	if arg_3_0._icons then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._icons) do
			iter_3_1:removeFromParent()
		end

		arg_3_0._icons = nil
	end

	arg_3_0._isTouching = false

	if arg_3_0._touchCard then
		local var_3_0 = arg_3_0._touchCard
		local var_3_1 = var_3_0._card
		local var_3_2 = var_3_1._owner
		local var_3_3 = var_3_0._ownerUi

		var_3_0:onTouchEnded(arg_3_1)

		arg_3_0._touchCard = nil

		if arg_3_0._isOperating then
			if var_3_0._touchEvent._touchCardType == CardSprite.TouchCardType.self_hand_card then
				if arg_3_0._selectTargetLayer then
					return arg_3_0._selectTargetLayer:onTouchEnded(arg_3_1)
				end

				local var_3_4 = var_3_0._targetCard

				arg_3_0:hidePreview(var_3_0)

				local var_3_5 = false

				if arg_3_0._isAddingBoardCard then
					var_3_5 = true
				elseif var_3_1:isMonsterRare() then
					if not var_3_2:canUseMonster(var_3_1, false) then
						var_3_5 = true
					end
				elseif var_3_1._type == Data.CardType.magic then
					if not var_3_2:canUseMagic(var_3_1, false) then
						var_3_5 = true
					end
				elseif var_3_1._type == Data.CardType.trap then
					local var_3_6, var_3_7 = var_3_2:canUseTrap(var_3_1, false)

					if not var_3_6 then
						var_3_5 = true
					end
				end

				if var_3_5 then
					var_3_3:playAction(var_3_0, PlayerUi.Action.replace_hand_card, 0, 1)

					return
				end

				if not arg_3_0._isAddingBoardCard and arg_3_1:getLocation().y >= PlayerUi.Pos.use_area then
					local var_3_8 = arg_3_0:getEventDrag()

					if var_3_8 ~= nil and var_3_8 ~= var_3_0 then
						var_3_3:playAction(var_3_0, PlayerUi.Action.replace_hand_card, 0, 1)

						return
					end

					local var_3_9, var_3_10 = arg_3_0:getEventDragTo()

					if (var_3_10 == BattleEventDialog.Type.guide_drag_to_pos or var_3_10 == BattleEventDialog.Type.guide_drag_to_attack or var_3_10 == BattleEventDialog.Type.guide_drag_to_defend) and var_3_9 ~= var_3_4 then
						var_3_3:sendEvent(PlayerUi.EventType.dialog_card_need_aim, 0)
						var_3_3:playAction(var_3_0, PlayerUi.Action.replace_hand_card, 0, 1)

						return
					end

					if var_3_2:canUseCard(var_3_1, var_3_4 and var_3_4._card or nil) then
						if var_3_1._type == Data.CardType.monster then
							local var_3_11
							local var_3_12
							local var_3_13

							if var_3_1._skills[1] ~= nil and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_bcs) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_grave) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_rare) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_hand) and var_3_1._skills[1]._id ~= 3002 and var_3_1._skills[1]._id ~= 3003 and var_3_1._skills[1]._id ~= 3177 and var_3_1._skills[1]._id ~= 3188 and var_3_1._skills[1]._id ~= 3250 and var_3_1._skills[1]._id ~= 3264 and var_3_1._skills[1]._id ~= 3268 and var_3_1._skills[1]._id ~= 3309 and var_3_1._skills[1]._id ~= 3340 and var_3_1._skills[1]._id ~= 3351 and var_3_1._skills[1]._id ~= 3357 and var_3_1._skills[1]._id ~= 3377 and var_3_1._skills[1]._id ~= 3385 and var_3_1._skills[1]._id ~= 3430 and var_3_1._skills[1]._id ~= 3432 and var_3_1._skills[1]._id ~= 3537 and var_3_1._skills[1]._id ~= 3570 and var_3_1._skills[1]._id ~= 3606 and var_3_1._skills[1]._id ~= 3680 and var_3_1._skills[1]._id ~= 3746 and var_3_1._skills[1]._id ~= 3820 and var_3_1._skills[1]._id ~= 3824 and var_3_1._skills[1]._id ~= 3829 and var_3_1._skills[1]._id ~= 3892 and var_3_1._skills[1]._id ~= 3954 and var_3_1._skills[1]._id ~= 3962 and var_3_1._skills[1]._id ~= 6265 and var_3_1._skills[1]._id ~= 6268 and var_3_1._skills[1]._id ~= 6285 and var_3_1._skills[1]._id ~= 6340 and var_3_1._skills[1]._id ~= 6526 and var_3_1._skills[1]._id ~= 6550 and var_3_1._skills[1]._id ~= 6555 and var_3_1._skills[1]._id ~= 6556 and var_3_1._skills[1]._id ~= 6596 and var_3_1._skills[1]._id ~= 6597 and var_3_1._skills[1]._id ~= 6675 and var_3_1._skills[1]._id ~= 6705 and var_3_1._skills[1]._id ~= 6714 and var_3_1._skills[1]._id ~= 6766 and var_3_1._skills[1]._id ~= 6831 and var_3_1._skills[1]._id ~= 6846 and var_3_1._skills[1]._id ~= 6853 and var_3_1._skills[1]._id ~= 6854 and var_3_1._skills[1]._id ~= 6857 and (var_3_1._skills[1]._id ~= 3896 or not var_3_1._owner:canUseMonsterSpecial(var_3_1)) then
								var_3_11, var_3_12, var_3_13 = var_3_1._owner:isGraveSkill(var_3_1._skills[1], nil, false)
							end

							if not var_3_11 and var_3_1._skills[2] ~= nil and (var_3_1._skills[2]._id == 3456 or var_3_1._skills[2]._id == 3645) then
								var_3_11, var_3_12, var_3_13 = var_3_1._owner:isGraveSkill(var_3_1._skills[2], nil, false)
							end

							if var_3_11 then
								var_3_3:showChoiceGrave(var_3_0, var_3_4, var_3_12, var_3_13)
							else
								var_3_3:showChoiceSummon(var_3_0, var_3_4)
							end
						elseif var_3_1._type == Data.CardType.magic then
							if var_3_1:hasSkills({
								4048,
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
								4979
							}) or var_3_1:hasSkillFast(7544) and var_3_1._status == BattleData.CardStatus.hand or var_3_1:hasSkillFast(7579) and var_3_1._status == BattleData.CardStatus.hand or var_3_1:hasSkillFast(7622) and var_3_1._status == BattleData.CardStatus.hand or var_3_1:hasSkillFast(7631) and var_3_1._status == BattleData.CardStatus.hand or var_3_1:hasSkillFast(7693) and var_3_1._status == BattleData.CardStatus.hand or var_3_1:hasSkillFast(7731) and var_3_1._status == BattleData.CardStatus.hand or var_3_1:hasSkillFast(7753) and var_3_1._status == BattleData.CardStatus.hand then
								var_3_3:showChoiceMerge(var_3_0, var_3_4)
							elseif B.isSkillCeremony(var_3_1._skills[1]._id) then
								var_3_3:showChoiceCeremony(var_3_0, var_3_4, 0)
							else
								local var_3_14
								local var_3_15
								local var_3_16

								if var_3_1._skills[1] ~= nil and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_bcs) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_grave) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_rare) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_hand) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_leave) then
									var_3_14, var_3_15, var_3_16 = var_3_1._owner:isGraveSkill(var_3_1._skills[1], nil, false)
								end

								if var_3_14 then
									var_3_3:showChoiceGrave(var_3_0, var_3_4, var_3_15, var_3_16)
								elseif var_3_1:hasSkillFast(7655) then
									var_3_3:sendEvent(PlayerUi.EventType.send_use_card, {
										_choice = 0,
										_card = var_3_0._card
									})
								else
									var_3_3:showChoiceSkill(var_3_0, var_3_4, nil, 0)
								end
							end
						elseif var_3_1:hasSkills({
							5244,
							5280,
							5298
						}) then
							var_3_3:showChoiceMerge(var_3_0, var_3_4)
						elseif var_3_1:hasSkills({
							5069,
							5118,
							6724
						}) then
							var_3_3:sendEvent(PlayerUi.EventType.send_use_card, {
								_choice = 0,
								_card = var_3_0._card
							})
						elseif var_3_1:hasSkillFast(5456) then
							var_3_3:showChoiceNumber(var_3_0, var_3_4, 1, math.floor((var_3_1._owner._fortress._hp - 1) / 1000), 0)
						else
							local var_3_17
							local var_3_18
							local var_3_19

							if var_3_1._skills[1] ~= nil and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_bcs) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_grave) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_rare) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_hand) and not B.skillHasMode(var_3_1._skills[1], Data.SkillMode.initiative_leave) then
								var_3_17, var_3_18, var_3_19 = var_3_1._owner:isGraveSkill(var_3_1._skills[1], nil, false)
							end

							if var_3_17 then
								var_3_3:showChoiceGrave(var_3_0, var_3_4, var_3_18, var_3_19)
							else
								var_3_3:showChoiceSkill(var_3_0, var_3_4, nil, 0)
							end
						end
					else
						var_3_3:playAction(var_3_0, PlayerUi.Action.replace_hand_card, 0, 1)
					end
				else
					var_3_3:playAction(var_3_0, PlayerUi.Action.replace_hand_card, 0, 1)
				end
			elseif var_3_1._owner._macroStatus == BattleData.Status.use and var_3_0._touchEvent._touchCardType == CardSprite.TouchCardType.board_card and var_3_1:canAction() then
				local var_3_20 = var_3_0._targetCard and var_3_0._targetCard._card or arg_3_1:getLocation().y >= PlayerUi.Pos.attack_fortress_area and arg_3_0._opponentUi._player._fortress or nil

				var_3_0._targetCard = nil

				arg_3_0:removeExchangeArrow()
				arg_3_0._opponentUi:updateFortressActive(false)
				var_3_0:updateBubble("")

				if not arg_3_0._isAddingBoardCard then
					local var_3_21 = arg_3_0:getEventDrag()

					if var_3_21 ~= nil and var_3_21 ~= var_3_0 then
						return
					end

					local var_3_22, var_3_23 = arg_3_0:getEventDragTo()

					if var_3_20 and var_3_1:canAttackTarget(var_3_20, true) then
						var_3_3:sendEvent(PlayerUi.EventType.send_use_card, {
							_card = var_3_1,
							_target = var_3_20
						})
					else
						if var_3_0._card:canAttack(true) and arg_3_0:getTouchedBoardCard(arg_3_1, var_3_0, false, var_3_3._opponentUi) then
							var_3_3:sendEvent(PlayerUi.EventType.dialog_target_unattackable, 0)
						end

						if arg_3_1:getLocation().y >= PlayerUi.Pos.attack_fortress_area then
							if var_3_1:hasBuff(true, BattleData.PositiveType.defendPosture) then
								if not var_3_1:canAttack() and var_3_0._card:canChangeToAttack(true) then
									var_3_3:sendEvent(var_3_3.EventType.send_use_card, {
										_card = var_3_0._card,
										_target = var_3_0._card
									})
								elseif not var_3_1:canAttack() then
									var_3_3:sendEvent(PlayerUi.EventType.dialog_cannot_change_posture, 0)
								end
							elseif not var_3_0._card:canAttack(true) then
								var_3_3:sendEvent(PlayerUi.EventType.dialog_cannot_attack, 0)
							end
						elseif arg_3_1:getLocation().y <= PlayerUi.Pos.defend_fortress_area and var_3_23 ~= BattleEventDialog.Type.guide_drag_to_attack then
							if var_3_1:hasBuff(true, BattleData.PositiveType.defendPosture) then
								var_3_3:sendEvent(PlayerUi.EventType.dialog_cannot_change_posture, 1)
							elseif not var_3_0._card:canChangeToDefend(true) then
								var_3_3:sendEvent(PlayerUi.EventType.dialog_cannot_change_posture, 0)
							else
								var_3_3:sendEvent(var_3_3.EventType.send_use_card, {
									_card = var_3_0._card,
									_target = var_3_0._card
								})
							end
						end
					end
				end
			end
		elseif not arg_3_0._isOperating and var_3_0._touchEvent._touchCardType == CardSprite.TouchCardType.self_hand_card then
			var_3_3:playAction(var_3_0, PlayerUi.Action.replace_hand_card, 0, 1)
		end
	end
end

function var_0_0.onTouchCanceled(arg_4_0)
	if arg_4_0._choicePosDialog then
		return arg_4_0._choicePosDialog:onTouchCanceled()
	end

	if not arg_4_0._isTouching then
		return
	end

	arg_4_0._isTouching = false

	if arg_4_0._dropLayer then
		return arg_4_0._dropLayer:onTouchCanceled()
	end

	if arg_4_0._touchCard then
		local var_4_0 = arg_4_0._touchCard
		local var_4_1 = var_4_0._card._owner
		local var_4_2 = var_4_0._ownerUi

		var_4_0:onTouchCanceled()

		arg_4_0._touchCard = nil

		if arg_4_0._selectTargetLayer then
			return arg_4_0._selectTargetLayer:onTouchCanceled()
		end

		if arg_4_0._icons then
			for iter_4_0, iter_4_1 in ipairs(arg_4_0._icons) do
				iter_4_1:removeFromParent()
			end

			arg_4_0._icons = nil
		end

		if var_4_0._touchEvent._touchCardType == CardSprite.TouchCardType.self_hand_card then
			if arg_4_0._isOperating then
				arg_4_0:hidePreview(var_4_0)
				var_4_2:playAction(var_4_0, PlayerUi.Action.replace_hand_card, 0, 1)
			else
				var_4_2:playAction(var_4_0, PlayerUi.Action.replace_hand_card, 0, 1)
			end
		elseif var_4_0._touchEvent._touchCardType == CardSprite.TouchCardType.board_card then
			arg_4_0:hidePreview(var_4_0)
			arg_4_0:removeExchangeArrow()
		end
	end
end

function var_0_0.getTouchedCard(arg_5_0, arg_5_1)
	if arg_5_0._touchCard and arg_5_0._touchCard:isVisible() and arg_5_0._touchCard:getOpacity() > 0 and arg_5_0._touchCard:containsTouchLocation(arg_5_1:getLocation().x, arg_5_1:getLocation().y) then
		return arg_5_0._touchCard
	end

	for iter_5_0 = 1, 2 do
		local var_5_0 = iter_5_0 == 1 and arg_5_0._playerUi or arg_5_0._opponentUi

		for iter_5_1 = #var_5_0._pHandCards, 1, -1 do
			local var_5_1 = var_5_0._pHandCards[iter_5_1]

			if var_5_1 ~= nil and var_5_1:containsTouchLocation(arg_5_1:getLocation().x, arg_5_1:getLocation().y) then
				return var_5_1
			end
		end

		for iter_5_2 = Data.MAX_CARD_COUNT_ON_BOARD + 1, 1, -1 do
			local var_5_2 = var_5_0._pBoardCards[iter_5_2]

			if var_5_2 ~= nil and var_5_2:containsTouchLocation(arg_5_1:getLocation().x, arg_5_1:getLocation().y) then
				return var_5_2
			end
		end

		for iter_5_3 = 1, Data.MAX_CARD_COUNT_ON_COVER do
			local var_5_3 = var_5_0._pCoverCards[iter_5_3] or var_5_0._pShowCards[iter_5_3]

			if var_5_3 ~= nil and var_5_3:containsTouchLocation(arg_5_1:getLocation().x, arg_5_1:getLocation().y) then
				return var_5_3
			end
		end

		local var_5_4 = var_5_0._pFieldCard

		if var_5_4 ~= nil and var_5_4:containsTouchLocation(arg_5_1:getLocation().x, arg_5_1:getLocation().y) then
			return var_5_4
		end

		for iter_5_4 = #var_5_0._pGraveCards, 1, -1 do
			local var_5_5 = var_5_0._pGraveCards[iter_5_4]

			if var_5_5 ~= nil and var_5_5:containsTouchLocation(arg_5_1:getLocation().x, arg_5_1:getLocation().y) then
				return var_5_5
			end
		end

		for iter_5_5 = #var_5_0._pRareCards, 1, -1 do
			local var_5_6 = var_5_0._pRareCards[iter_5_5]

			if var_5_6 ~= nil and var_5_6:containsTouchLocation(arg_5_1:getLocation().x, arg_5_1:getLocation().y) then
				return var_5_6
			end
		end
	end

	return nil
end

function var_0_0.getTouchedBoardCard(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4._isController and arg_6_1:getLocation().y >= PlayerUi.Pos.attacker_area then
		return nil
	end

	if not arg_6_4._isController and arg_6_1:getLocation().y <= PlayerUi.Pos.attacker_area then
		return nil
	end

	if arg_6_3 then
		-- block empty
	else
		local touchLoc = arg_6_1:getLocation()
		local bestCard = nil
		local bestDist = 999999

		for iter_6_0 = Data.MAX_CARD_COUNT_ON_BOARD + 1, 1, -1 do
			local var_6_0 = arg_6_4._pBoardCards[iter_6_0]

			if var_6_0 ~= nil then
				local isValid = true
				if arg_6_2._card:isMonsterRare() then
					-- block empty
				elseif arg_6_2._card._type == Data.CardType.magic then
					if not arg_6_4._player:canUseMagicOnTarget(arg_6_2._card, var_6_0._card) then
						isValid = false
					end
				elseif arg_6_2._card._type == Data.CardType.trap and not arg_6_4._player:canUseTrapOnTarget(arg_6_2._card, var_6_0._card) then
					isValid = false
				end

				if isValid then
					local isInside = var_6_0:containsTouchLocation(touchLoc.x, touchLoc.y)
					if isInside then
						return var_6_0
					end

					local cardPos = var_6_0:convertToWorldSpace3D(cc.p(0, 0), ClientData._camera3D)
					local dist = cc.pGetDistance(touchLoc, cardPos)
					if dist < 130 and dist < bestDist then
						bestDist = dist
						bestCard = var_6_0
					end
				end
			end
		end

		return bestCard
	end
end

function var_0_0.removeExchangeArrow(arg_7_0)
	if arg_7_0._arrow then
		arg_7_0._arrow:removeFromParent()

		arg_7_0._arrow = nil
	end
end

function var_0_0.previewInsertBoardCard(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= nil then
		local var_8_0 = arg_8_1._ownerUi
		local var_8_1 = arg_8_1._card._pos
		local var_8_2 = var_8_0:calBoardCardStep()

		for iter_8_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
			local var_8_3 = var_8_0._pBoardCards[iter_8_0]

			if var_8_3 ~= nil then
				local var_8_4 = var_8_3._default._position
				local var_8_5 = iter_8_0 < var_8_1 and 0 or var_8_2

				var_8_3:stopAllActions()
				var_8_3:runAction(cc.MoveTo:create(0.2, cc.p(var_8_4.x + var_8_5, var_8_4.y)))
			end
		end
	end

	if arg_8_2 ~= nil then
		arg_8_2:setScale(CardSprite.Scale.normal)
	end
end

function var_0_0.hidePreviewInsertBoardCard(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= nil then
		local var_9_0 = arg_9_1._ownerUi

		for iter_9_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD do
			local var_9_1 = var_9_0._pBoardCards[iter_9_0]

			if var_9_1 ~= nil then
				local var_9_2 = var_9_1._default._position

				var_9_1:stopAllActions()
				var_9_1:runAction(cc.MoveTo:create(0.2, var_9_2))
			end
		end
	end

	if arg_9_2 ~= nil then
		arg_9_2:setScale(CardSprite.Scale.hd)
	end
end

function var_0_0.preview(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1._card._owner

	if arg_10_1._targetCard ~= nil then
		arg_10_0:hidePreviewInsertBoardCard(arg_10_1._targetCard)
	end

	arg_10_1._targetCard = arg_10_2

	arg_10_0:previewInsertBoardCard(arg_10_2, arg_10_1)
end

function var_0_0.hidePreview(arg_11_0, arg_11_1)
	if arg_11_1._targetCard ~= nil then
		local var_11_0 = arg_11_1._card._owner

		arg_11_0:hidePreviewInsertBoardCard(arg_11_1._targetCard, arg_11_1)

		arg_11_1._targetCard = nil
	end
end

function var_0_0.showSelectTarget(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = Data._skillInfo[arg_12_2._id]
	local var_12_1 = arg_12_0
	local var_12_2 = arg_12_0._playerUi
	local var_12_3 = var_12_2._player
	local var_12_4 = arg_12_1._card
	local var_12_5 = lc.createMaskLayer(0, lc.Color3B.black, ClientView.SCR_SIZE)

	lc.addChildToPos(arg_12_0._scene, var_12_5, cc.p(0, 0), BattleScene.ZOrder.form)

	var_12_5._pCard = arg_12_1
	var_12_5._skill = arg_12_2
	arg_12_0._selectTargetLayer = var_12_5

	function var_12_5.onTouchMoved(arg_13_0, arg_13_1)
		local var_13_0
		local var_13_1 = var_12_0._targetType

		if var_13_1 == Data.SkillTargetType.self_board_card then
			var_13_0 = var_12_1:getTouchedBoardCard(arg_13_1, arg_12_1, false, var_12_1._playerUi)
		elseif var_13_1 == Data.SkillTargetType.oppo_board_card then
			var_13_0 = var_12_1:getTouchedBoardCard(arg_13_1, arg_12_1, false, var_12_1._opponentUi)
		elseif var_13_1 == Data.SkillTargetType.board_card then
			var_13_0 = var_12_1:getTouchedBoardCard(arg_13_1, arg_12_1, false, var_12_1._playerUi) or var_12_1:getTouchedBoardCard(arg_13_1, arg_12_1, false, var_12_1._opponentUi)
		end

		if var_13_0 ~= nil and not var_12_3:canUseMonsterOnTarget(var_12_4, var_13_0._card) then
			var_13_0 = nil
		end

		local var_13_2, var_13_3 = var_12_1:getEventDragTo()

		if var_13_3 == BattleEventDialog.Type.guide_drag_to_card and var_13_2 ~= nil and var_13_2 ~= var_13_0 or (var_13_3 == BattleEventDialog.Type.guide_drag_to_pos or var_13_3 == BattleEventDialog.Type.guide_drag_to_attack or var_13_3 == BattleEventDialog.Type.guide_drag_to_defend) and var_13_2 ~= var_13_0 then
			var_13_0 = nil
		end

		arg_12_1._targetCard = var_13_0

		arg_13_0._arrow:directTo(arg_13_1:getLocation(), var_13_0)
	end

	function var_12_5.onTouchEnded(arg_14_0, arg_14_1)
		var_12_1:hideSelectTarget(arg_14_0)

		local var_14_0 = arg_12_1._targetCard

		if var_14_0 and var_12_3:canUseCard(var_12_4, var_14_0._card) then
			if var_12_4._type == Data.CardType.monster then
				var_12_2:showChoiceSummon(arg_12_1, var_14_0)
			elseif var_12_4._type == Data.CardType.magic or var_12_4._type == Data.CardType.trap then
				local var_14_1, var_14_2, var_14_3 = var_12_4._owner:isGraveSkill(var_12_4._skills[1], var_14_0._card, false)

				if var_14_1 then
					var_12_2:showChoiceGrave(arg_12_1, var_14_0, var_14_2, var_14_3)
				elseif var_12_4:hasSkillFast(4796) then
					var_12_2:showChoiceNumber(arg_12_1, var_14_0, 1, 12, 0)
				else
					var_12_2:showChoiceSkill(arg_12_1, var_14_0, nil, 0)
				end
			else
				var_12_2:showChoiceSkill(arg_12_1, var_14_0, nil, 0)
			end
		else
			var_12_1._playerUi:sendEvent(PlayerUi.EventType.dialog_card_need_target, 0)
		end
	end

	function var_12_5.onTouchCanceled(arg_15_0)
		var_12_1:hideSelectTarget(arg_15_0)
	end

	arg_12_1:setPosition(arg_12_1._default._position)
	arg_12_1:hideLargePic()
	arg_12_1:onTouchEnded(arg_12_3)

	local var_12_6 = BattleLine.create(arg_12_1:getParent():convertToWorldSpace3D(cc.p(arg_12_1:getPosition()), ClientData._camera3D))

	var_12_5._arrow = var_12_6

	var_12_5:addChild(var_12_6)
	var_12_6:directTo(arg_12_3:getLocation(), nil)
end

function var_0_0.hideSelectTarget(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1._pCard

	arg_16_0._playerUi:playAction(var_16_0, PlayerUi.Action.replace_hand_card, 0, 1)
	arg_16_1:removeFromParent()

	arg_16_0._selectTargetLayer = nil
end
