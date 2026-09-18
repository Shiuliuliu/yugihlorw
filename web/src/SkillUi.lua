local var_0_0 = PlayerUi

function var_0_0.castSkillAction(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = arg_1_3._id
	local var_1_1 = {
		0.4,
		0.4
	}

	if var_1_0 == 6222 or var_1_0 == 6353 or var_1_0 == 6938 or var_1_0 == 3210 or var_1_0 == 13975 or var_1_0 == 3114 or var_1_0 == 3501 or var_1_0 == 4990 or var_1_0 == 4493 or var_1_0 == 5584 or var_1_0 == 5588 or var_1_0 == 9008 or var_1_0 == 9250 or var_1_0 == 9349 or var_1_0 == 9407 or var_1_0 == 9567 or var_1_0 == 9580 or var_1_0 == 9581 or var_1_0 == 9582 or var_1_0 == 9585 or var_1_0 == 9594 or var_1_0 == 9800 or var_1_0 == 9833 or var_1_0 == 9933 or var_1_0 == 7375 or var_1_0 == 7438 or var_1_0 == 7439 or var_1_0 == 7440 or var_1_0 == 7442 or var_1_0 == 7443 or var_1_0 == 7446 or var_1_0 == 7554 or var_1_0 == 7557 or var_1_0 == 7586 or var_1_0 == 7660 or var_1_0 == 7661 or var_1_0 == 7662 or var_1_0 == 7670 or var_1_0 == 7713 or var_1_0 == 7714 or var_1_0 == 7726 or var_1_0 == 7765 or var_1_0 == 7766 or var_1_0 == 7777 or var_1_0 == 8133 or var_1_0 == 8150 or var_1_0 == 13200 or var_1_0 == 13201 or var_1_0 == 13206 or var_1_0 == 13265 or var_1_0 == 13266 or var_1_0 == 13310 or var_1_0 == 13315 or var_1_0 == 13322 or var_1_0 == 13354 or var_1_0 == 13384 or var_1_0 == 13385 or var_1_0 == 13386 or var_1_0 == 13414 or var_1_0 == 13601 or var_1_0 == 13634 or var_1_0 == 13855 or var_1_0 == 14200 or var_1_0 == 14207 or var_1_0 == 14208 or var_1_0 == 14218 or var_1_0 == 1153 or var_1_0 == 2257 or var_1_0 == 2990 or var_1_0 == 2991 or var_1_0 == 2994 then
		return 0, 0
	end

	if var_1_0 == 11005 or var_1_0 == 12005 or var_1_0 == 3244 then
		return var_1_1[1], var_1_1[2]
	end

	local var_1_2 = math.floor(var_1_0 / Data.INFO_ID_GROUP_SIZE)
	local var_1_3 = arg_1_1._card
	local var_1_4 = {}
	local var_1_5 = arg_1_0._player:getUnderAttackCard()
	local var_1_6 = arg_1_0._player:getActionCard()

	if arg_1_2 == BattleData.Status.after_spell then
		var_1_4 = arg_1_0._player:getUnderChangedCards()
	else
		var_1_4 = arg_1_0._player:getUnderSkillCards(var_1_3._id, var_1_0)
	end

	if var_1_3._type == Data.CardType.boss then
		arg_1_0:efcBossCardSkill(arg_1_1, var_1_0)
	elseif (var_1_2 >= Data.SkillType.monsterHalo and var_1_2 <= Data.SkillType.monster2Halo or var_1_2 == Data.SkillType.monster3Halo or var_1_2 == Data.SkillType.monster4Halo) and arg_1_4 ~= Data.SkillMode.halo then
		local var_1_7 = arg_1_0:getCardSprite(arg_1_3._owner) or arg_1_0._opponentUi:getCardSprite(arg_1_3._owner)

		if var_1_7 == nil then
			var_1_7 = {
				_card = arg_1_3._owner,
				_playerUi = arg_1_0
			}
		end

		arg_1_0:efcSkillShow(var_1_7)
	elseif arg_1_2 == BattleData.Status.spelling or arg_1_2 == BattleData.Status.before_attack then
		if var_1_0 ~= 5081 and (var_1_0 ~= 5137 or var_1_3._status ~= BattleData.CardStatus.cover) then
			arg_1_0:efcSkillShow(arg_1_1)
		end
	elseif arg_1_2 == BattleData.Status.under_spell_damage or arg_1_2 == BattleData.Status.under_attack or arg_1_2 == BattleData.Status.under_attack_damage or arg_1_2 == BattleData.Status.ac_under_attack_damage or arg_1_2 == BattleData.Status.after_spell then
		arg_1_0:efcSkillShow(arg_1_1)
	end

	if var_1_0 == 1001 then
		for iter_1_0 = 1, #var_1_4 do
			local var_1_8 = arg_1_0:getCardSprite(var_1_4[iter_1_0]) or arg_1_0._opponentUi:getCardSprite(var_1_4[iter_1_0])

			if var_1_8 ~= nil then
				arg_1_0:efcDragonBones3("jdgj", "effect", 2, true, var_1_8, false, cc.p(0, 20))
			end
		end
	elseif var_1_0 == 1002 or var_1_0 == 1004 or var_1_0 == 1013 or var_1_0 == 3040 then
		arg_1_0:efcDragonBones3("tssh", "effect", 2.4, true, arg_1_1, false, cc.p(0, 20))
	elseif var_1_0 == 1003 then
		arg_1_0:efcDragonBones3("blzz", "effect01", 1, true, arg_1_1, false, cc.p(0, 0))

		local var_1_9 = arg_1_0:getCardSprite(var_1_5) or arg_1_0._opponentUi:getCardSprite(var_1_5)

		if var_1_9 ~= nil and var_1_9._pFrameIcon ~= nil then
			local var_1_10 = arg_1_0:efcDragonBones2("blzz", "effect02", 1, true)

			lc.addChildToCenter(var_1_9._pFrameIcon, var_1_10)
		end
	elseif var_1_0 == 1015 then
		local var_1_11 = arg_1_0._isController and 180 or 0

		arg_1_0:efcDragonBones3("guanchuan", "effect2", 1, true, arg_1_1, true, cc.p(0, 20)):setRotation(var_1_11)
	elseif var_1_0 == 2002 or var_1_0 == 2006 or var_1_0 == 9718 then
		arg_1_0:efcDragonBones3("wlfy", "effect", 2.4, true, arg_1_1, false, cc.p(0, -10))
	elseif var_1_0 == 1095 or var_1_0 == 2013 or var_1_0 == 3001 or var_1_0 == 3100 or var_1_0 >= 3279 and var_1_0 <= 3287 or var_1_0 == 3918 or var_1_0 == 6343 or var_1_0 == 8063 or var_1_0 == 8146 or var_1_0 == 9821 or var_1_0 == 13509 or var_1_0 == 2036 and var_1_3._lastCount ~= nil then
		local var_1_12 = "effect"
		local var_1_13 = var_1_3._lastCount == 0 and "back" or "positive"
		local var_1_14 = arg_1_0:efcDragonBones(nil, "touyingbi", cc.p(ClientView.SCR_CW, lc.h(arg_1_0._battleUi) / 2), false, false, var_1_12, 1)
		local var_1_15 = var_1_14:getAnimationDuration(var_1_12)
		local var_1_16 = var_1_14:getAnimationDuration(var_1_13)

		var_1_14:runAction(lc.sequence(var_1_15, function()
			var_1_14:gotoAndPlay(var_1_13)
		end, var_1_16, lc.remove()))

		var_1_1 = {
			var_1_15 + var_1_16,
			0
		}

		if var_1_0 == 2013 then
			arg_1_1:updateBoardActive()
		end
	elseif var_1_0 == 2020 or var_1_0 == 6651 then
		arg_1_1._ownerUi._opponentUi:updateBoardCardsActive()
	elseif var_1_0 == 3129 then
		for iter_1_1 = 1, #var_1_4 do
			local var_1_17 = arg_1_0:getCardSprite(var_1_4[iter_1_1]) or arg_1_0._opponentUi:getCardSprite(var_1_4[iter_1_1])

			if var_1_17 ~= nil then
				arg_1_0:efcDragonBones3("tsgf", "effect", 1, true, var_1_17, false, cc.p(0, 80))
			end
		end
	elseif var_1_0 == 3004 or var_1_0 == 3027 then
		for iter_1_2 = 1, #var_1_4 do
			local var_1_18 = arg_1_0:getCardSprite(var_1_4[iter_1_2]) or arg_1_0._opponentUi:getCardSprite(var_1_4[iter_1_2])

			if var_1_18 ~= nil then
				arg_1_0:efcDragonBones3("jdgj", "effect", 2, true, var_1_18, false, cc.p(0, 0))
			end
		end
	elseif var_1_0 == 3346 or var_1_0 == 4058 or var_1_0 == 4068 then
		arg_1_0:updateCardsActive()
	elseif var_1_0 == 3015 then
		local var_1_19 = arg_1_0._battleUi._layer:convertToNodeSpace(arg_1_1:convertToWorldSpace(cc.p(0, 0)))
		local var_1_20 = cc.p(arg_1_0._avatarFrame:getPosition())
		local var_1_21 = cc.p(var_1_20.x + (arg_1_0._isController and 50 or -50), var_1_20.y + (arg_1_0._isController and 50 or -50))
		local var_1_22, var_1_23 = arg_1_0:calLengthAndAngle(var_1_19, var_1_21)
		local var_1_24 = 270 - var_1_23
		local var_1_25 = cc.Node:create()

		lc.addChildToPos(arg_1_0._battleUi._layer, var_1_25, var_1_19, 4)
		var_1_25:setRotation(var_1_24)

		local var_1_26 = Particle.create("par_liziqiu")

		lc.addChildToCenter(var_1_25, var_1_26)
		var_1_25:runAction(lc.sequence(lc.delay(0.6), lc.moveTo(0.8, var_1_21), function()
			var_1_25:removeFromParent()

			local var_3_0 = Particle.create("par_liziqiu_jz")

			lc.addChildToPos(arg_1_0._battleUi._layer, var_3_0, var_1_21, 4)
		end))

		var_1_1 = {
			1.4,
			0.6
		}
	elseif var_1_0 == 3036 then
		local var_1_27 = 0

		for iter_1_3 = 1, #var_1_4 do
			local var_1_28 = arg_1_0:getCardSprite(var_1_4[iter_1_3]) or arg_1_0._opponentUi:getCardSprite(var_1_4[iter_1_3])

			if var_1_28 ~= nil and var_1_4[iter_1_3]._owner ~= var_1_3._owner then
				local var_1_29 = cc.p(arg_1_1:getPosition())
				local var_1_30 = cc.p(var_1_28:getPosition())
				local var_1_31 = cc.p(var_1_30.x, var_1_30.y > var_1_29.y and var_1_30.y - 30 or var_1_30.y + 20)
				local var_1_32, var_1_33 = arg_1_0:calLengthAndAngle(var_1_29, var_1_31)
				local var_1_34 = 90 - var_1_33

				var_1_27 = math.sqrt(var_1_32) / 90

				arg_1_0:efcDragonBones(arg_1_1, "gqbb", cc.p(0, -10), true, false, "atk", 2.6):setRotation(var_1_34)
				arg_1_0:efcCamera3DSprite("efc_gqbb", var_1_29, var_1_34, false):runAction(lc.sequence(0.7, lc.show(), lc.moveTo(var_1_27, var_1_31), lc.remove()))
				arg_1_0._battleUi:runAction(lc.sequence(0.7 + var_1_27 - 0.1, function()
					arg_1_0:efcDragonBones(nil, "gqbb", cc.p(var_1_31.x, var_1_31.y - 10), true, false, "def", 2.6):setRotation(var_1_34)
				end))
			end
		end

		var_1_1 = {
			var_1_27 + 0.7,
			0.7
		}
	elseif var_1_0 == 3136 or var_1_0 == 3138 then
		if ClientData.isYYB() then
			local var_1_35 = arg_1_0:efcDragonBones2("shendeng", "effect1", 1, true)

			lc.addChildToCenter(arg_1_0._battleUi:getParent(), var_1_35, BattleUi.ZOrder.effect)
		else
			local var_1_36 = Particle.create("xuwang1")

			lc.addChildToCenter(arg_1_0._battleUi._layer, var_1_36, CardSprite.ZOrder.efc)

			local var_1_37 = Particle.create("xuwang2")

			lc.addChildToCenter(arg_1_0._battleUi._layer, var_1_37, CardSprite.ZOrder.efc)
		end
	elseif var_1_0 == 4004 then
		local var_1_38 = arg_1_0:getCardSprite(var_1_3._magicTarget)

		if var_1_38 then
			local var_1_39 = cc.p(var_1_38:getPosition())
			local var_1_40 = cc.p(ClientView.SCR_CW, arg_1_0._isController and var_0_0.Pos.defender_board_y or var_0_0.Pos.attacker_board_y)
			local var_1_41 = lc.createSprite("efc_cmdlbz")

			lc.addChildToPos(arg_1_0._battleUi, var_1_41, var_1_39, BattleUi.ZOrder.effect)
			arg_1_0:efcDragonBones(nil, "cmdlbz", var_1_39, true, false, "effect01", 5)
			var_1_41:setVisible(false)
			var_1_41:runAction(lc.sequence(lc.delay(0.8), lc.show(), lc.moveTo(0.2, var_1_40), lc.call(function()
				arg_1_0:efcDragonBones(nil, "cmdlbz", var_1_40, true, false, "effect02", 5)
			end), lc.remove()))
		end

		var_1_1 = {
			1.2,
			0.6
		}
	elseif var_1_0 == 4043 then
		local var_1_42 = arg_1_0:efcDragonBones2("qbd", "effect", 1, true)

		lc.addChildToCenter(arg_1_0._battleUi, var_1_42)
		var_1_42:setRotation(arg_1_0._isController and 0 or 180)
	elseif var_1_0 == 4048 or var_1_0 == 4171 or var_1_0 == 4186 or var_1_0 == 4207 or var_1_0 == 4290 or var_1_0 == 4305 or var_1_0 == 4454 or var_1_0 == 4497 or var_1_0 == 4511 or var_1_0 == 4514 or var_1_0 == 4521 or var_1_0 == 4526 or var_1_0 == 4530 or var_1_0 == 4735 or var_1_0 == 4736 or var_1_0 == 4740 or var_1_0 == 4748 or var_1_0 == 4836 or var_1_0 == 4861 or var_1_0 == 4957 or var_1_0 == 4978 or var_1_0 == 4979 or var_1_0 == 4980 or var_1_0 == 5244 or var_1_0 == 5280 or var_1_0 == 5298 or var_1_0 == 5430 or var_1_0 == 5431 or var_1_0 == 5452 or var_1_0 == 5470 or var_1_0 == 5485 or var_1_0 == 5544 or var_1_0 == 5549 or var_1_0 == 7144 or var_1_0 == 7373 or var_1_0 == 7544 or var_1_0 == 7579 or var_1_0 == 7622 or var_1_0 == 7631 or var_1_0 == 7673 or var_1_0 == 7674 or var_1_0 == 7693 or var_1_0 == 7731 or var_1_0 == 7732 or var_1_0 == 7753 or var_1_0 == 7785 or var_1_0 == 7831 or var_1_0 == 9796 or var_1_0 == 9868 then
		local var_1_43 = cc.Node:create()

		lc.addChildToCenter(arg_1_0._battleUi, var_1_43, BattleUi.ZOrder.effect)
		var_1_43:runAction(lc.sequence(lc.delay(3), lc.remove()))
		var_1_43:setScale(3)

		local var_1_44 = Particle.create("par_ronghe01")

		lc.addChildToCenter(var_1_43, var_1_44)

		local var_1_45 = Particle.create("par_ronghe02")

		lc.addChildToCenter(arg_1_0._battleUi, var_1_45, BattleUi.ZOrder.effect)

		local var_1_46 = Particle.create("par_ronghe03")

		lc.addChildToCenter(arg_1_0._battleUi, var_1_46, BattleUi.ZOrder.effect)

		var_1_1 = {
			0.2,
			0
		}
	elseif var_1_0 == 2055 or var_1_0 == 2056 or var_1_0 == 2057 or var_1_0 == 3077 or var_1_0 == 3193 or var_1_0 == 3194 or var_1_0 == 3419 or var_1_0 == 3669 or var_1_0 == 4066 or var_1_0 == 4121 or var_1_0 == 5080 or var_1_0 == 7588 or var_1_0 == 7589 or var_1_0 == 7725 or var_1_0 == 9815 or var_1_0 == 14033 or var_1_0 == 14034 or var_1_0 == 14036 or var_1_0 == 14037 then
		local var_1_47 = "effect"
		local var_1_48 = "" .. var_1_3._lastCount
		local var_1_49 = arg_1_0:efcDragonBones(nil, "yaosaizi", cc.p(ClientView.SCR_CW, lc.h(arg_1_0._battleUi) / 2), false, false, var_1_47, 1)
		local var_1_50 = var_1_49:getAnimationDuration(var_1_47)
		local var_1_51 = var_1_49:getAnimationDuration(var_1_48)

		var_1_49:runAction(lc.sequence(var_1_50, function()
			var_1_49:gotoAndPlay(var_1_48)
		end, var_1_51, lc.remove()))

		var_1_1 = {
			var_1_50 + var_1_51,
			0
		}
	elseif var_1_0 == 6565 or var_1_0 == 5589 then
		local var_1_52 = B.getDicesResult(var_1_3._lastCount)

		for iter_1_4 = 1, 3 do
			local var_1_53 = "effect"
			local var_1_54 = "" .. var_1_52[iter_1_4]
			local var_1_55 = arg_1_0:efcDragonBones(nil, "yaosaizi", cc.p(ClientView.SCR_CW - 200 + iter_1_4 * 100, lc.h(arg_1_0._battleUi) / 2), false, false, var_1_53, 1)
			local var_1_56 = var_1_55:getAnimationDuration(var_1_53)
			local var_1_57 = var_1_55:getAnimationDuration(var_1_54)

			var_1_55:runAction(lc.sequence(var_1_56, function()
				var_1_55:gotoAndPlay(var_1_54)
			end, var_1_57, lc.remove()))

			var_1_1 = {
				var_1_56 + var_1_57,
				0
			}
		end
	elseif var_1_0 == 3403 or var_1_0 == 4277 then
		for iter_1_5 = 1, 2 do
			local var_1_58 = "effect"
			local var_1_59 = band(var_1_3._lastCount, 2^(iter_1_5 - 1)) == 0 and "back" or "positive"
			local var_1_60 = arg_1_0:efcDragonBones(nil, "touyingbi", cc.p(ClientView.SCR_CW - 200 + iter_1_5 * 100, lc.h(arg_1_0._battleUi) / 2), false, false, var_1_58, 1)
			local var_1_61 = var_1_60:getAnimationDuration(var_1_58)
			local var_1_62 = var_1_60:getAnimationDuration(var_1_59)

			var_1_60:runAction(lc.sequence(var_1_61, function()
				var_1_60:gotoAndPlay(var_1_59)
			end, var_1_62, lc.remove()))

			var_1_1 = {
				var_1_61 + var_1_62,
				0
			}
		end
	elseif var_1_0 == 3201 or var_1_0 == 3398 or var_1_0 == 3452 or var_1_0 == 3453 or var_1_0 == 3472 or var_1_0 == 6567 then
		for iter_1_6 = 1, 3 do
			local var_1_63 = "effect"
			local var_1_64 = band(var_1_3._lastCount, 2^(iter_1_6 - 1)) == 0 and "back" or "positive"
			local var_1_65 = arg_1_0:efcDragonBones(nil, "touyingbi", cc.p(ClientView.SCR_CW - 200 + iter_1_6 * 100, lc.h(arg_1_0._battleUi) / 2), false, false, var_1_63, 1)
			local var_1_66 = var_1_65:getAnimationDuration(var_1_63)
			local var_1_67 = var_1_65:getAnimationDuration(var_1_64)

			var_1_65:runAction(lc.sequence(var_1_66, function()
				var_1_65:gotoAndPlay(var_1_64)
			end, var_1_67, lc.remove()))

			var_1_1 = {
				var_1_66 + var_1_67,
				0
			}
		end
	elseif var_1_0 == 3103 then
		for iter_1_7 = 1, #var_1_4 do
			local var_1_68 = arg_1_0:getCardSprite(var_1_4[iter_1_7]) or arg_1_0._opponentUi:getCardSprite(var_1_4[iter_1_7])

			if var_1_68 ~= nil then
				arg_1_0:efcDragonBones3("tsgj", "effect", 2.4, true, var_1_68, false, cc.p(0, 20))
			end
		end
	elseif var_1_0 == 3042 or var_1_0 == 4002 or var_1_0 == 4003 then
		local var_1_69

		if var_1_0 == 3042 then
			var_1_69 = arg_1_0._opponentUi._avatarFrame:convertToNodeSpace(arg_1_1:getParent():convertToWorldSpace(cc.p(arg_1_1:getPosition())))
		else
			var_1_69 = arg_1_0._opponentUi._avatarFrame:convertToNodeSpace(arg_1_0._avatarFrame:convertToWorldSpace(arg_1_0._avatarFrame._avatarPos))
		end

		local var_1_70 = cc.p(lc.w(arg_1_0._opponentUi._avatarFrame) / 2, lc.h(arg_1_0._opponentUi._avatarFrame) / 2)
		local var_1_71, var_1_72 = arg_1_0:calLengthAndAngle(var_1_69, var_1_70)
		local var_1_73 = 270 - var_1_72
		local var_1_74 = cc.Node:create()

		lc.addChildToPos(arg_1_0._opponentUi._avatarFrame, var_1_74, var_1_69, 4)
		var_1_74:setRotation(var_1_73)

		local var_1_75 = Particle.create("par_huoqiu")

		lc.addChildToCenter(var_1_74, var_1_75)
		var_1_74:runAction(lc.sequence(lc.delay(0.6), lc.moveTo(1, var_1_70), function()
			var_1_74:removeFromParent()

			local var_10_0 = Particle.create("par_huoqiu_jz")

			lc.addChildToPos(arg_1_0._opponentUi._avatarFrame, var_10_0, var_1_70, 4)
			arg_1_0._audioEngine:playEffect("e_fireball_hit")
		end))

		var_1_1 = {
			1.6,
			0.6
		}
	elseif var_1_0 == 1080 or var_1_0 == 1109 or var_1_0 == 1123 or var_1_0 == 1153 or var_1_0 == 3604 or var_1_0 == 4064 or var_1_0 == 4192 or var_1_0 == 4274 or var_1_0 == 4282 or var_1_0 == 4319 or var_1_0 == 4321 or var_1_0 == 4550 or var_1_0 == 4685 or var_1_0 == 4916 or var_1_0 == 5266 or var_1_0 == 5317 or var_1_0 == 5458 or var_1_0 == 5518 or var_1_0 == 7323 or var_1_0 == 7441 or var_1_0 == 7548 or var_1_0 == 7600 or var_1_0 == 6425 or var_1_0 == 6457 or var_1_0 == 6497 or var_1_0 == 6701 or var_1_0 == 6695 or var_1_0 == 6781 or var_1_0 == 6905 or var_1_0 == 6932 or var_1_0 == 2235 or var_1_0 == 2310 or var_1_0 == 2450 or var_1_0 == 2517 or var_1_0 == 2521 or var_1_0 == 2541 or var_1_0 == 2752 or var_1_0 == 2989 or var_1_0 == 9290 or var_1_0 == 9341 or var_1_0 == 9552 or var_1_0 == 9598 or var_1_0 == 9830 or var_1_0 == 9831 or var_1_0 == 9838 or var_1_0 == 9844 or var_1_0 == 9845 or var_1_0 == 9848 or var_1_0 == 9925 or var_1_0 == 13339 then
		arg_1_0:updateBoardCardsActive()
	elseif var_1_0 == 5449 or var_1_0 == 5534 or var_1_0 == 5633 or var_1_0 == 6669 or var_1_0 == 6693 or var_1_0 == 7712 or var_1_0 == 2350 or var_1_0 == 9093 or var_1_0 == 9545 or var_1_0 == 9546 or var_1_0 == 9547 or var_1_0 == 9929 then
		arg_1_0._opponentUi:updateBoardCardsActive()
	elseif var_1_0 == 2502 or var_1_0 == 9107 or var_1_0 == 9626 or var_1_0 == 7426 then
		arg_1_1:updatePositiveStatus()
	elseif var_1_0 == 11011 or var_1_0 == 12011 then
		arg_1_0:playAction(arg_1_1, var_0_0.Action.avoid_attack, 0)
	elseif var_1_0 == 13190 or var_1_0 == 13191 then
		arg_1_0:replaceHandCards(0, arg_1_1._card)
		arg_1_0._opponentUi:replaceHandCards(0, arg_1_1._card)
	end

	arg_1_0._audioEngine:playSkillAudio(var_1_0, arg_1_1._card, var_1_1[1])

	return var_1_1[1], var_1_1[2]
end

function var_0_0.efcCyclone(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1:runAction(lc.sequence(arg_11_2 or 0, function()
		arg_11_0:efcDragonBones(arg_11_1, "jufeng2", cc.p(-30, 0), true, false, "single", 2.4)
	end, 0.4, lc.moveBy(0.04, 10, 0), lc.moveBy(0.06, -10, 10), lc.moveBy(0.08, 20, -20), lc.moveBy(0.08, -20, 20), lc.moveBy(0.06, 10, -10), lc.moveBy(0.04, -10, 0)))
end

function var_0_0.efcFortressDieRemove(arg_13_0)
	if arg_13_0._finishEfcLayer ~= nil then
		arg_13_0._finishEfcLayer:removeFromParent()

		arg_13_0._finishEfcLayer = nil
	end
end

function var_0_0.efcFortressDie(arg_14_0)
	if arg_14_0._player._opponent._winBy3190 then
		local var_14_0 = DragonBones.create("aikezuodiya")

		lc.addChildToCenter(arg_14_0._scene, var_14_0, BattleUi.ZOrder.effect)
		lc.offset(var_14_0, 0, 16)

		local var_14_1 = var_14_0:getAnimationDuration("effect1")
		local var_14_2 = var_14_0:getAnimationDuration("effect2")
		local var_14_3 = var_14_0:getAnimationDuration("effect3")

		var_14_0:gotoAndPlay("effect1")
		var_14_0:runAction(lc.sequence(var_14_1, function()
			var_14_0:gotoAndPlay("effect2")
		end, var_14_2, function()
			var_14_0:gotoAndPlay("effect3")
		end, var_14_3, lc.remove()))
	elseif arg_14_0._player._opponent._winBy3798 then
		local var_14_4 = DragonBones.create("guangzhichuangzaoshen")

		var_14_4:gotoAndPlay("effect")

		local var_14_5 = var_14_4:getAnimationDuration("effect")

		lc.addChildToCenter(arg_14_0._scene, var_14_4, BattleUi.ZOrder.effect)
		var_14_4:runAction(lc.sequence(var_14_5, lc.remove()))
	elseif arg_14_0._player._opponent._winBy2234 or arg_14_0._player._opponent._winBy2237 then
		local var_14_6 = DragonBones.create("jiguankuilei")

		var_14_6:gotoAndPlay("effect")

		local var_14_7 = var_14_6:getAnimationDuration("effect")

		lc.addChildToCenter(arg_14_0._scene, var_14_6, BattleUi.ZOrder.effect)
		var_14_6:runAction(lc.sequence(var_14_7, lc.remove()))
	end

	local var_14_8 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH + (arg_14_0._isController and -150 or 150))
	local var_14_9 = DragonBones.create("wjsw")

	lc.addChildToPos(arg_14_0._battleUi, var_14_9, var_14_8, BattleUi.ZOrder.effect, BattleUi.Tag.remove_when_reset)
	var_14_9:setRotation3D({
		z = 0,
		y = 0,
		x = ClientView.BATTLE_ROTATION_X
	})
	var_14_9:gotoAndPlay("effect")

	if arg_14_0._isController then
		var_14_9:setRotation(180)
	end

	arg_14_0._finishEfcLayer = var_14_9

	arg_14_0._scene:seenByCamera3D(var_14_9)
	arg_14_0:sendEvent(var_0_0.EventType.efc_screen_fortress_die)
	arg_14_0._audioEngine:playEffect("e_fortress_explode")
end

function var_0_0.efcBossDie(arg_17_0)
	local var_17_0 = cc.p(var_0_0.Pos.boss.x, var_0_0.Pos.boss.y + 100)

	arg_17_0._boss:gotoAndPlay("dead")
	arg_17_0:sendEvent(var_0_0.EventType.efc_screen_fortress_die)
end

function var_0_0.efcCardDie(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1._card

	if var_18_0:isMonsterRare() then
		local var_18_1 = arg_18_1._default._position
		local var_18_2 = "kapaisiwang"
		local var_18_3 = "effect_monster"

		if var_18_0._type == Data.CardType.trap then
			var_18_3 = "effect_trap"
		end

		arg_18_1:runAction(cc.Sequence:create(cc.MoveBy:create(0.03, cc.p(0, 5)), cc.MoveBy:create(0.03, cc.p(5, -10)), cc.MoveBy:create(0.06, cc.p(-10, 10)), cc.MoveBy:create(0.03, cc.p(10, 0)), cc.MoveBy:create(0.03, cc.p(-5, -5)), cc.CallFunc:create(function()
			arg_18_1:removeAllStatus()
			arg_18_1:setOpacity(0)
			arg_18_0:efcDragonBones(arg_18_1, var_18_2, cc.p(0, 0), true, false, var_18_3, CardSprite.Scale.normal * 4)
			arg_18_0:efcParticle("par_kapaisiwang_1", var_18_1, false, true)
			arg_18_0:efcParticle("par_kapaisiwang_2", var_18_1, false, true)
			arg_18_0._audioEngine:playEffect("e_card_die")
		end)))
		arg_18_0._audioEngine:playHeroAudio(var_18_0._infoId, true)
	elseif var_18_0._type == Data.CardType.magic or var_18_0._type == Data.CardType.trap then
		local var_18_4 = arg_18_1._default._position
		local var_18_5 = "kapaisiwang"
		local var_18_6 = "effect_trap"

		arg_18_0:efcDragonBones(arg_18_1, var_18_5, cc.p(0, 0), true, false, var_18_6, 2)
		arg_18_0:efcParticle("par_kapaisiwang_1", var_18_4, false, true)
		arg_18_0:efcParticle("par_kapaisiwang_2", var_18_4, false, true)
	end
end

function var_0_0.efcCardEmpty(arg_20_0, arg_20_1)
	arg_20_0:efcDragonBones(arg_20_1, "kapaisiwang", cc.p(0, 0), true, false, "effect_monster", CardSprite.Scale.normal * 2)
	arg_20_0._audioEngine:playEffect("e_card_leave")
end

function var_0_0.efcCardLeave(arg_21_0, arg_21_1)
	arg_21_0:efcDragonBones(arg_21_1, "kapaisiwang", cc.p(0, 0), true, false, "effect_monster", CardSprite.Scale.normal * 2)
	arg_21_0._audioEngine:playEffect("e_card_die")
end

function var_0_0.efcNormalCardDie(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:efcDragonBones(arg_22_1, "spsw", cc.p(0, 0), true, false, "effect", CardSprite.Scale.normal * 2)
	arg_22_0._audioEngine:playEffect(arg_22_2 and "e_card_die" or "e_card_board")
end

function var_0_0.efcCardFlip(arg_23_0, arg_23_1)
	if arg_23_1._card._type == Data.CardType.trap then
		local var_23_0 = arg_23_1:getScaleY()

		arg_23_1:runAction(cc.Sequence:create(lc.scaleTo(0.2, 0, var_23_0), lc.call(function()
			arg_23_1:initShow()
			arg_23_1:setRotation3D({
				z = 0,
				x = 0,
				y = 0
			})
		end), lc.scaleTo(0.2, var_23_0, var_23_0)))
	end
end

function var_0_0.efcSkillShow(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_1._card
	local var_25_1 = cc.p(ClientView.SCR_CW + 440, ClientView.SCR_CH)
	local var_25_2 = CardSprite.create(var_25_0, arg_25_1._ownerUi or arg_25_0._isController and arg_25_0 or arg_25_0._opponentUi)

	var_25_2:initNormal()
	lc.addChildToPos(arg_25_0._battleUi, var_25_2, var_25_1, BattleUi.ZOrder.skill_label)
	var_25_2:setScale(0)
	var_25_2:runAction(lc.sequence(lc.ease(lc.scaleTo(0.2, 1 / CardSprite.Scale.normal), "BackO"), lc.moveBy(0.5, cc.p(3, 5)), lc.moveBy(0.5, cc.p(-3, -5)), lc.scaleTo(0.2, 0), lc.remove()))
	var_25_2._pShadowArea:runAction(lc.spawn(lc.moveTo(0.2, cc.p(-100, -50)), lc.scaleTo(0.2, 0.6)))

	local var_25_3 = lc.createNode()

	lc.addChildToCenter(var_25_2._pFrame, var_25_3, -1)
	var_25_3:setScale(1)
	arg_25_0._battleUi:createDragonBones("szkp", cc.p(5, 8), var_25_3, "effect1", false, 1)

	if var_25_0:isMonsterRare() and arg_25_1._status == CardSprite.Status.fight then
		local var_25_4 = Particle.create("par_gwsf")

		lc.addChildToPos(arg_25_1._pEffectArea, var_25_4, cc.p(0, -70))
	end

	arg_25_0._scene:seenByCamera3D(var_25_2)
end

function var_0_0.efcCardSkill(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = cc.p(arg_26_1:getPosition())
	local var_26_1 = arg_26_1._card
	local var_26_2 = math.floor(arg_26_2 / Data.INFO_ID_GROUP_SIZE)
	local var_26_3 = "efc_glow_bottom"
	local var_26_4 = cc.Sprite:createWithSpriteFrameName(var_26_3)

	var_26_4:setScale(1.1)
	var_26_4:setPosition(-5, 0)
	arg_26_1._pBottomEffectArea:addChild(var_26_4)
	var_26_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.9), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
		var_26_4:removeFromParent()
	end)))
	arg_26_0._scene:seenByCamera3D(var_26_4)

	local var_26_5 = cc.Node:create()
	local var_26_6 = arg_26_1._card:getUnderSkillIndex(arg_26_2)

	var_26_5:setPosition(0, -70 - var_26_6 * 30)
	arg_26_1._pEffectArea:setVisible(true)
	arg_26_1._pEffectArea:setOpacity(255)
	arg_26_1._pEffectArea:addChild(var_26_5, CardSprite.ZOrder.skill_label)

	local var_26_7 = cc.Label:createWithTTF(Str(Data._skillInfo[arg_26_2]._nameSid), ClientView.TTF_FONT, ClientView.FontSize.M1)

	var_26_7:enableOutline(lc.Color4B.red, 1)
	var_26_5:addChild(var_26_7)
	var_26_7:runAction(cc.Sequence:create(cc.DelayTime:create(0.9), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
		var_26_5:removeFromParent()
	end)))
	arg_26_0._scene:seenByCamera3D(var_26_5)
end

function var_0_0.efcBossCardSkill(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = cc.p(arg_29_1:getPosition())
	local var_29_1 = cc.Node:create()

	var_29_1:setPosition(0, -20)
	arg_29_1:addChild(var_29_1, CardSprite.ZOrder.skill_label)

	local var_29_2 = cc.Label:createWithTTF(Str(Data._skillInfo[arg_29_2]._nameSid), ClientView.TTF_FONT, ClientView.FontSize.M1)

	var_29_2:enableOutline(lc.Color4B.red, 1)
	var_29_1:addChild(var_29_2)
	var_29_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.9), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
		var_29_1:removeFromParent()
	end)))
	arg_29_0._scene:seenByCamera3D(var_29_1)
end

function var_0_0.efcFortressHurt(arg_31_0, arg_31_1)
	if arg_31_0._player._fortressHp == 0 then
		arg_31_1 = 0
	end

	local var_31_0 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH + (arg_31_0._isController and -200 or 200))
	local var_31_1 = arg_31_0._battleUi._layer:convertToNodeSpace(arg_31_0._battleUi:convertToWorldSpace(var_31_0))
	local var_31_2 = arg_31_0._battleUi._layer:convertToNodeSpace(arg_31_0._pHpLabel:convertToWorldSpace(cc.p(0, 0)))
	local var_31_3 = cc.Label:createWithBMFont(ClientView.BMFont.num_48, "-" .. arg_31_1)

	lc.addChildToPos(arg_31_0._battleUi._layer, var_31_3, var_31_1)
	var_31_3:setColor(lc.Color3B.red)
	var_31_3:setScale(1.4)
	var_31_3:runAction(lc.sequence(lc.spawn(lc.fadeIn(0.1), lc.scaleTo(0.1, 1.6)), lc.scaleTo(0.04, 1), lc.scaleTo(0.01, 1.2), lc.delay(0.2), lc.spawn(lc.moveTo(0.3, var_31_2), lc.rotateTo(0.3, 20)), lc.spawn(lc.fadeOut(0.2), lc.scaleTo(0.2, 1.5)), function()
		var_31_3:removeFromParent()
	end))
	arg_31_0:efcDragonBones(nil, arg_31_1 >= 2500 and "dalian01" or "dalian01", var_31_0, true, false, "effect", 1.33):setRotation(arg_31_0._isController and 0 or 180)
	arg_31_0:efcDragonBones(nil, "dalian03", var_31_0, true, false, "effect", 1.33):setRotation(arg_31_0._isController and 0 or 180)
end

function var_0_0.efcBossHurt(arg_33_0, arg_33_1)
	local var_33_0 = var_0_0.Pos.boss

	arg_33_0:efcDragonBones(nil, "beiji", var_33_0, true, false, "effect", 1.2)

	local var_33_1 = cc.Node:create()

	var_33_1:setPosition(var_33_0)
	arg_33_0._battleUi:addChild(var_33_1, BattleUi.ZOrder.label)

	local var_33_2 = cc.Label:createWithBMFont(ClientView.BMFont.num_48, "-" .. arg_33_1)

	var_33_1:addChild(var_33_2)
	var_33_2:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.1), cc.ScaleTo:create(0.1, 1.6)), cc.ScaleTo:create(0.04, 0.8), cc.ScaleTo:create(0.01, 1), cc.DelayTime:create(0.7), cc.Spawn:create(cc.FadeOut:create(0.2), cc.ScaleTo:create(0.2, 1.5)), cc.CallFunc:create(function()
		var_33_1:removeFromParent()
	end)))
	arg_33_0:efcBossDragonBones("hurt")
	arg_33_0._scene:seenByCamera3D(var_33_1)
end

function var_0_0.efcFortressHpLabel(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0._isController and var_0_0.Pos.attacker_fortress or var_0_0.Pos.defender_fortress
	local var_35_1 = arg_35_0._battleUi._layer:convertToNodeSpace(arg_35_0._battleUi:convertToWorldSpace(var_35_0))
	local var_35_2 = cc.Node:create()

	lc.addChildToPos(arg_35_0._battleUi._layer, var_35_2, var_35_1)

	local var_35_3 = cc.Label:createWithBMFont(ClientView.BMFont.num_48, (arg_35_1 > 0 and "+" or "") .. arg_35_1)

	var_35_2:addChild(var_35_3)
	var_35_3:runAction(lc.sequence(lc.scaleTo(0.16, 0.9), lc.scaleTo(0.12, 1.2), lc.scaleTo(0.08, 1), lc.scaleTo(0.04, 1.1), lc.delay(0.4), lc.fadeOut(0.3), lc.call(function()
		var_35_2:removeFromParent()
	end)))
end

function var_0_0.efcFortressAtkLabel(arg_37_0, arg_37_1)
	local var_37_0 = var_0_0.Pos.boss
	local var_37_1 = cc.Node:create()

	var_37_1:setPosition(var_37_0)
	arg_37_0._battleUi:addChild(var_37_1, BattleUi.ZOrder.label)

	local var_37_2 = cc.Label:createWithBMFont(ClientView.BMFont.huali_32, (arg_37_1 > 0 and "+" or "") .. arg_37_1)

	var_37_1:addChild(var_37_2)
	var_37_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.16, 0.9), cc.ScaleTo:create(0.12, 1.2), cc.ScaleTo:create(0.08, 1), cc.ScaleTo:create(0.04, 1.1), cc.DelayTime:create(0.4), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
		var_37_1:removeFromParent()
	end)))
	arg_37_0._scene:seenByCamera3D(var_37_1)
end

function var_0_0.efcCardHurt(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = arg_39_0._player:getActionPlayer()
	local var_39_1 = arg_39_1._card
	local var_39_2

	var_39_2 = arg_39_0._isController and -1 or 1

	if ClientData._cfg and ClientData._cfg.testEffects then
		if ClientData._cfg.testEffects == true then
			local var_39_3 = {
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

			Data._jizhongIndex = Data._jizhongIndex or 0
			Data._jizhongIndex = (Data._jizhongIndex + 1) % #var_39_3 + 1

			local var_39_4 = cc.p(0, 0)
			local var_39_5 = true
			local var_39_6 = false
			local var_39_7 = false
			local var_39_8 = "effect"
			local var_39_9 = 1
			local var_39_10 = arg_39_1:efcDragonBones(var_39_3[Data._jizhongIndex], var_39_4, var_39_5, var_39_6, var_39_8, var_39_9)
		elseif ClientData._cfg.testEffects.attacked then
			local var_39_11
			local var_39_12 = true
			local var_39_13 = false
			local var_39_14 = false
			local var_39_15 = "effect"
			local var_39_16 = 1

			arg_39_1:efcDragonBones2(ClientData._cfg.testEffects.attacked, var_39_11, var_39_12, var_39_13, var_39_15, var_39_16)
		end
	elseif arg_39_3 then
		arg_39_1:efcSkinEffect(arg_39_3)
	else
		arg_39_1:efcDragonBones("beiji", cc.p(0, 0), true, false, "effect", 1.2)
	end

	local var_39_17 = cc.Node:create()

	lc.addChildToPos(arg_39_0._battleUi, var_39_17, cc.p(arg_39_1:getPosition()), BattleUi.ZOrder.label)
	var_39_17:setRotation3D({
		z = 0,
		y = 0,
		x = ClientView.BATTLE_ROTATION_X
	})

	if arg_39_2 ~= nil and arg_39_2 > 0 then
		local var_39_18 = cc.Label:createWithBMFont(ClientView.BMFont.num_48, "-" .. arg_39_2)

		var_39_17:addChild(var_39_18)
		var_39_18:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.1), cc.ScaleTo:create(0.1, 1.6)), cc.ScaleTo:create(0.04, 0.8), cc.ScaleTo:create(0.01, 1), cc.DelayTime:create(0.7), cc.Spawn:create(cc.FadeOut:create(0.2), cc.ScaleTo:create(0.2, 1.5)), cc.CallFunc:create(function()
			var_39_17:removeFromParent()
		end)))
		arg_39_0._scene:seenByCamera3D(var_39_17)
	end
end

function var_0_0.efcCardHpLabel(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0._player:getActionPlayer()
	local var_41_1 = cc.p(0, -25)
	local var_41_2 = cc.Node:create()

	var_41_2:setPosition(var_41_1)
	arg_41_1._pEffectArea:addChild(var_41_2, CardSprite.ZOrder.label)

	local var_41_3 = cc.Label:createWithBMFont(ClientView.BMFont.huali_26, "DEF" .. (arg_41_2 > 0 and "+" or "") .. arg_41_2)

	var_41_2:addChild(var_41_3)
	var_41_3:runAction(cc.Sequence:create(cc.ScaleTo:create(0.16, 0.8), cc.ScaleTo:create(0.12, 1.1), cc.ScaleTo:create(0.08, 0.9), cc.ScaleTo:create(0.04, 1), cc.DelayTime:create(0.4), cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(0, 15)), cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeOut:create(0.2))), cc.CallFunc:create(function()
		var_41_2:removeFromParent()
	end)))
	arg_41_0._scene:seenByCamera3D(var_41_2)
end

function var_0_0.efcCardAtkLabel(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0._player:getActionPlayer()
	local var_43_1 = cc.p(0, 0)
	local var_43_2 = cc.Node:create()

	var_43_2:setPosition(var_43_1)
	arg_43_1._pEffectArea:addChild(var_43_2, CardSprite.ZOrder.label)

	local var_43_3 = cc.Label:createWithBMFont(ClientView.BMFont.huali_26, "ATK" .. (arg_43_2 > 0 and "+" or "") .. arg_43_2)

	var_43_2:addChild(var_43_3)
	var_43_3:runAction(cc.Sequence:create(cc.ScaleTo:create(0.16, 0.8), cc.ScaleTo:create(0.12, 1.1), cc.ScaleTo:create(0.08, 0.9), cc.ScaleTo:create(0.04, 1), cc.DelayTime:create(0.4), cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(0, 15)), cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeOut:create(0.2))), cc.CallFunc:create(function()
		var_43_2:removeFromParent()
	end)))
	arg_43_0._scene:seenByCamera3D(var_43_2)
end

function var_0_0.efcCamera3DSprite(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	if arg_45_4 == nil then
		arg_45_4 = true
	end

	local var_45_0 = cc.Sprite:createWithSpriteFrameName(arg_45_1)

	if arg_45_2 then
		var_45_0:setPosition(arg_45_2)
	end

	if arg_45_3 then
		var_45_0:setRotation(arg_45_3)
	end

	var_45_0:setVisible(arg_45_4)
	arg_45_0._battleUi:addChild(var_45_0, BattleUi.ZOrder.effect)
	arg_45_0._scene:seenByCamera3D(var_45_0)

	return var_45_0
end

function var_0_0.efcParticle(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	local var_46_0 = cc.p(0, 0)

	if arg_46_2 ~= nil then
		var_46_0 = cc.p(var_46_0.x + arg_46_2.x, var_46_0.y + arg_46_2.y)
	end

	if arg_46_4 == nil then
		arg_46_4 = true
	end

	if arg_46_5 == nil then
		arg_46_5 = arg_46_0._battleUi
	end

	local var_46_1 = arg_46_3 and -1 or BattleUi.ZOrder.effect

	return (arg_46_0._battleUi:createParticle(arg_46_1, var_46_0, arg_46_5, arg_46_4, var_46_1))
end

function var_0_0.efcDragonBones2(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	local var_47_0 = DragonBones.create(arg_47_1)

	var_47_0:setScale(arg_47_3)
	var_47_0:gotoAndPlay(arg_47_2)

	if arg_47_4 then
		var_47_0:runAction(lc.sequence(var_47_0:getAnimationDuration(arg_47_2), lc.remove()))
	end

	return var_47_0
end

function var_0_0.efcDragonBones3(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5, arg_48_6, arg_48_7)
	local var_48_0 = arg_48_0:efcDragonBones2(arg_48_1, arg_48_2, arg_48_3, arg_48_4)

	lc.addChildToCenter(arg_48_6 and arg_48_5._pBottomEffectArea or arg_48_5._pEffectArea, var_48_0)
	lc.offset(var_48_0, arg_48_7.x, arg_48_7.y)

	return var_48_0
end

function var_0_0.efcDragonBones(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4, arg_49_5, arg_49_6, arg_49_7)
	local var_49_0 = cc.p(0, 0)

	if arg_49_1 ~= nil then
		var_49_0 = cc.p(arg_49_1:getPosition())
	end

	if arg_49_3 ~= nil then
		var_49_0 = cc.p(var_49_0.x + arg_49_3.x, var_49_0.y + arg_49_3.y)
	end

	if arg_49_6 == nil then
		arg_49_6 = "effect"
	end

	if arg_49_4 == nil then
		arg_49_4 = true
	end

	if arg_49_5 == nil then
		arg_49_5 = false
	end

	if arg_49_7 == nil then
		arg_49_7 = 1
	end

	return (arg_49_0._battleUi:createDragonBones(arg_49_2, var_49_0, arg_49_0._battleUi, arg_49_6, arg_49_4, arg_49_7, arg_49_5 and -1 or BattleUi.ZOrder.effect))
end

function var_0_0.efcBossDragonBones(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0._boss
	local var_50_1 = var_50_0:getAnimationDuration(arg_50_1)

	var_50_0:stopAllActions()
	var_50_0:gotoAndPlay(arg_50_1)
	var_50_0:runAction(lc.sequence(var_50_1, function()
		var_50_0:gotoAndPlay("wait")
	end))

	return var_50_1
end

function var_0_0.efcBossPositiveStatus(arg_52_0, arg_52_1, arg_52_2)
	if arg_52_2._positiveStatus[BattleData.PositiveType.shieldGold] then
		CardSprite.efcShieldBegin(arg_52_1, "shieldAttack")
	else
		CardSprite.efcShieldEnd(arg_52_1, "shieldAttack")
	end
end

function var_0_0.efcFortressPositiveStatus(arg_53_0, arg_53_1, arg_53_2)
	if arg_53_2:hasShieldInType(BattleData.PositiveType.shieldHp) then
		CardSprite.efcShieldBegin(arg_53_1, "shieldHp")

		local var_53_0 = arg_53_1._statusEfc.shieldHp

		var_53_0:setCameraMask(1)
		var_53_0:setPosition(arg_53_1._avatarPos)
		var_53_0:setLocalZOrder(3)
	else
		CardSprite.efcShieldEnd(arg_53_1, "shieldHp")
	end
end

function var_0_0.efcFortressNegativeStatus(arg_54_0, arg_54_1, arg_54_2)
	arg_54_0:updateBoardLocks()
end

function var_0_0.efcBoss106Ghost(arg_55_0, arg_55_1, arg_55_2)
	if not B.isAlive(arg_55_2._owner._assistant[1]) then
		if arg_55_1._ghostParticle1 == nil then
			arg_55_1._ghostParticle1 = arg_55_0:efcParticle("ys_guanghuan", cc.p(-200, 150), false, false, arg_55_1)
		end
	elseif arg_55_1._ghostParticle1 ~= nil then
		arg_55_1._ghostParticle1:removeFromParent()

		arg_55_1._ghostParticle1 = nil
	end

	if not B.isAlive(arg_55_2._owner._assistant[2]) then
		if arg_55_1._ghostParticle2 == nil then
			arg_55_1._ghostParticle2 = arg_55_0:efcParticle("ys_guanghuan", cc.p(200, 150), false, false, arg_55_1)
		end
	elseif arg_55_1._ghostParticle2 ~= nil then
		arg_55_1._ghostParticle2:removeFromParent()

		arg_55_1._ghostParticle2 = nil
	end
end

function var_0_0.getLabelColor(arg_56_0, arg_56_1, arg_56_2)
	if arg_56_1 == nil or arg_56_2 == nil or arg_56_1 == arg_56_2 or arg_56_1 == Data.XYZ_STAR then
		return ClientView.COLOR_TEXT_LIGHT
	elseif arg_56_2 < arg_56_1 then
		return cc.c3b(133, 235, 3)
	else
		return ClientView.COLOR_TEXT_RED
	end
end

function var_0_0.efcIgnoreDefendAttack(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	local var_57_0 = cc.p(arg_57_1:getPosition())
	local var_57_1

	if arg_57_2._type == Data.CardType.boss then
		var_57_1 = var_0_0.Pos.boss
	else
		targetCard = arg_57_0:getBoardCardSprite(arg_57_2) or arg_57_0._opponentUi:getBoardCardSprite(arg_57_2)
		var_57_1 = cc.p(targetCard:getPosition())
	end

	local var_57_2, var_57_3 = arg_57_0:calLengthAndAngle(var_57_0, var_57_1)
	local var_57_4 = arg_57_3 - var_57_3
	local var_57_5 = arg_57_0:efcDragonBones(arg_57_1, "wlws", cc.p(0, -10), true, false, "effect", 2.4)

	var_57_5:setRotation(var_57_4)
	var_57_5:runAction(cc.MoveTo:create(0.1, var_57_1))
end
