local var_0_0 = class("BattleDialog", function()
	return cc.Node:create()
end)

BattleDialog = var_0_0
var_0_0.Type = {
	chat_dialog = 31,
	oppo_gem = 204,
	oppo_card_pile = 202,
	your_gem = 203,
	fortress_skill = 41,
	your_card_pile = 201,
	initial_deal = 4,
	your_grave = 205,
	trap_existed = 110,
	inning = 5,
	your_round = 1,
	dialog_start = 100,
	adding_board_card = 108,
	defender_hand_cards = 101,
	cannot_attack = 112,
	exchange = 51,
	dialog_end = 200,
	tip_start = 300,
	special_summon_invalid = 107,
	board_card_full = 103,
	card_need_aim = 105,
	oppo_round = 2,
	round_info = 207,
	target_unattackable = 111,
	remain_round = 3,
	card_need_target = 106,
	cannot_change_posture = 113,
	oppo_grave = 206,
	cannot_effect = 109,
	attacker_hand_cards = 114,
	oppo_chat_dialog = 32,
	not_enough_gem = 102,
	not_your_round = 104
}

function var_0_0.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.new()

	var_2_0:init(arg_2_0, arg_2_1, arg_2_2)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._battleUi = arg_3_1

	local var_3_0 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH)

	if arg_3_2 == var_0_0.Type.your_round or arg_3_2 == var_0_0.Type.oppo_round or arg_3_2 == var_0_0.Type.remain_round or arg_3_2 == var_0_0.Type.initial_deal or arg_3_2 == var_0_0.Type.inning then
		local var_3_1 = Particle.create("par_round_explode")

		var_3_1:setPosition(var_3_0.x, var_3_0.y + 60)
		arg_3_0:addChild(var_3_1, -2)

		local var_3_2 = ""
		local var_3_3 = ""

		if arg_3_2 == var_0_0.Type.your_round then
			var_3_3 = "effect02"
		elseif arg_3_2 == var_0_0.Type.oppo_round then
			var_3_3 = "effect01"
		elseif arg_3_2 == var_0_0.Type.remain_round then
			var_3_2 = arg_3_3
			var_3_3 = "effect04"
		elseif arg_3_2 == var_0_0.Type.initial_deal then
			var_3_3 = "effect03"
		elseif arg_3_2 == var_0_0.Type.inning then
			var_3_2 = arg_3_3
			var_3_3 = "effect05"
		end

		local var_3_4 = DragonBones.create("hhdb")

		var_3_4:gotoAndPlay(var_3_3)

		local var_3_5 = var_3_4:getAnimationDuration(var_3_3)

		lc.addChildToPos(arg_3_0, var_3_4, cc.p(var_3_0.x, var_3_0.y + 50), BattleScene.ZOrder.dialog + 1)
		arg_3_0._battleUi._audioEngine:playEffect("e_round")

		local var_3_6 = ClientView.FontSize.B1
		local var_3_7 = cc.c3b(90, 255, 255)
		local var_3_8 = cc.p(var_3_4:getContentSize().width / 2, var_3_4:getContentSize().height / 2 - 4)

		if arg_3_2 == var_0_0.Type.inning then
			var_3_8 = cc.p(var_3_4:getContentSize().width / 2, var_3_4:getContentSize().height / 2 - 4)
		end

		if arg_3_2 == var_0_0.Type.remain_round or arg_3_2 == var_0_0.Type.inning then
			local var_3_9 = cc.Label:createWithTTF(var_3_2, ClientView.TTF_FONT, var_3_6)

			var_3_9:setColor(var_3_7)
			var_3_9:setVisible(false)
			var_3_9:setPosition(var_3_8)
			var_3_4:addChild(var_3_9)
			var_3_9:runAction(lc.sequence(0.4, lc.show(), 1.6, lc.hide()))
		end

		var_3_4:runAction(lc.sequence(0.7, lc.moveBy(0.5, cc.p(0, 10)), lc.moveBy(0.6, cc.p(0, -20)), lc.moveBy(0.5, cc.p(0, 10)), var_3_5 - 2.3, function()
			local var_4_0 = Particle.create("par_huihe")

			var_4_0:setPosition(var_3_0.x, var_3_0.y + 60)
			arg_3_0:addChild(var_4_0)
		end, lc.remove()))
	elseif arg_3_2 > var_0_0.Type.dialog_start and arg_3_2 < var_0_0.Type.dialog_end then
		local var_3_10 = ""
		local var_3_11 = cc.p(ClientView.SCR_CW + 180, ClientView.SCR_CH - 100)

		if arg_3_2 == var_0_0.Type.defender_hand_cards then
			var_3_10 = string.format(Str(STR.BATTLE_DIALOG_HAND_CARDS), #arg_3_0._battleUi._opponentUi._pHandCards)
			var_3_11.y = ClientView.SCR_CH + (arg_3_1._isReverse and -150 or 340)
		elseif arg_3_2 == var_0_0.Type.attacker_hand_cards then
			var_3_10 = string.format(Str(STR.BATTLE_DIALOG_HAND_CARDS), #arg_3_0._battleUi._opponentUi._pHandCards)
			var_3_11.y = ClientView.SCR_CH + (arg_3_1._isReverse and 340 or -150)
		elseif arg_3_2 == var_0_0.Type.not_enough_gem then
			var_3_10 = Str(STR.BATTLE_DIALOG_NOT_ENOUGH_GEM)
		elseif arg_3_2 == var_0_0.Type.board_card_full then
			var_3_10 = string.format(Str(STR.BATTLE_DIALOG_BOARD_FULL), Data.MAX_CARD_COUNT_ON_BOARD)
		elseif arg_3_2 == var_0_0.Type.adding_board_card then
			var_3_10 = Str(STR.BATTLE_DIALOG_ADDING_CARD)
		elseif arg_3_2 == var_0_0.Type.card_need_aim then
			var_3_10 = Str(arg_3_3 == 0 and STR.BATTLE_DIALOG_CARD_NEED_AIM or STR.BATTLE_DIALOG_CARD_NEED_JCTQ_TARGET)
		elseif arg_3_2 == var_0_0.Type.card_need_target then
			var_3_10 = Str(STR.BATTLE_DIALOG_CARD_NEED_TARGET)
		elseif arg_3_2 == var_0_0.Type.special_summon_invalid then
			var_3_10 = Str(STR.BATTLE_DIALOG_SPECIAL_SUMMON_INVALID)
		elseif arg_3_2 == var_0_0.Type.not_your_round then
			var_3_10 = Str(STR.BATTLE_DIALOG_NOT_YOUR_ROUND)
		elseif arg_3_2 == var_0_0.Type.cannot_effect then
			var_3_10 = string.format(Str(STR.BATTLE_DIALOG_CANNOT_EFFECT), ClientData.getStrByCardType(arg_3_3))
		elseif arg_3_2 == var_0_0.Type.trap_existed then
			var_3_10 = Str(STR.BATTLE_DIALOG_TRAP_EXISTED)
		elseif arg_3_2 == var_0_0.Type.target_unattackable then
			var_3_10 = Str(STR.BATTLE_DIALOG_TARGET_UNATTACKABLE)
		elseif arg_3_2 == var_0_0.Type.cannot_attack then
			var_3_10 = Str(STR.BATTLE_DIALOG_CANNOT_ATTACK)
		elseif arg_3_2 == var_0_0.Type.cannot_change_posture then
			var_3_10 = Str(arg_3_3 == 0 and STR.BATTLE_DIALOG_CANNOT_CHANGE_POSTURE or STR.BATTLE_DIALOG_ALREADY_IN_DEFEND_POSTURE)
		end

		local var_3_12 = ccui.Scale9Sprite:createWithSpriteFrameName("bat_dlg_bg2", cc.rect(42, 26, 1, 1))

		var_3_12:setContentSize(cc.size(string.len(var_3_10) / 3 * 24 + 70, 60))
		var_3_12:setPosition(var_3_11)
		var_3_12:setCascadeOpacityEnabled(true)
		arg_3_0:addChild(var_3_12)

		local var_3_13 = cc.Label:createWithTTF(var_3_10, ClientView.TTF_FONT, ClientView.FontSize.S1)

		var_3_13:setColor(lc.Color3B.black)
		var_3_13:setAnchorPoint(0, 0.5)
		var_3_13:setPosition(50, 30)
		var_3_12:addChild(var_3_13)
		var_3_12:setContentSize(cc.size(var_3_13:getContentSize().width + 70, 60))
		var_3_12:runAction(cc.Sequence:create(cc.ScaleTo:create(lc.absTime(0.1), 1.2), cc.ScaleTo:create(lc.absTime(0.1), 1), cc.DelayTime:create(lc.absTime(1.5)), cc.FadeOut:create(lc.absTime(1)), cc.CallFunc:create(function()
			arg_3_0:hide()
		end)))
		arg_3_0._battleUi._audioEngine:playEffect("e_dialog")
	elseif arg_3_2 > var_0_0.Type.tip_start and arg_3_2 < var_0_0.Type.tip_end then
		local var_3_14 = ""
		local var_3_15 = cc.p(var_3_0.x, var_3_0.y)

		if arg_3_2 == var_0_0.Type.your_card_pile then
			var_3_14 = string.format(Str(STR.BATTLE_DIALOG_CARD_PILE), arg_3_0._battleUi._atkPile._label:getString())
			var_3_15 = cc.p(ClientView.SCR_W - 280, 60)
		elseif arg_3_2 == var_0_0.Type.oppo_card_pile then
			var_3_14 = string.format(Str(STR.BATTLE_DIALOG_CARD_PILE), arg_3_0._battleUi._defPile._label:getString())
			var_3_15 = cc.p(ClientView.SCR_W - 280, ClientView.SCR_H - 60)
		elseif arg_3_2 == var_0_0.Type.round_info then
			var_3_14 = string.format(Str(STR.BATTLE_DIALOG_ROUND), arg_3_0._battleUi._pRoundLabel:getString())
			var_3_15 = cc.p(var_3_15.x + 320, var_3_15.y + 60)
		elseif arg_3_2 == var_0_0.Type.your_gem then
			var_3_14 = string.format(Str(STR.BATTLE_DIALOG_GEM), arg_3_0._battleUi._player._gem or 0)
			var_3_15 = cc.p(var_3_15.x + 290, var_3_15.y + (arg_3_1._isReverse and 250 or -100))
		elseif arg_3_2 == var_0_0.Type.oppo_gem then
			var_3_14 = string.format(Str(STR.BATTLE_DIALOG_GEM), arg_3_0._battleUi._opponent._gem or 0)
			var_3_15 = cc.p(var_3_15.x + 290, var_3_15.y + (arg_3_1._isReverse and -100 or 250))
		elseif arg_3_2 == var_0_0.Type.your_grave then
			var_3_14 = string.format(Str(STR.BATTLE_DIALOG_GRAVE), arg_3_0._battleUi._atkGraveLabel:getString())
			var_3_15 = cc.p(var_3_15.x - 330, var_3_15.y + (arg_3_1._isReverse and 240 or -100))
		elseif arg_3_2 == var_0_0.Type.oppo_grave then
			var_3_14 = string.format(Str(STR.BATTLE_DIALOG_GRAVE), arg_3_0._battleUi._defGraveLabel:getString())
			var_3_15 = cc.p(var_3_15.x - 330, var_3_15.y + (arg_3_1._isReverse and -100 or 240))
		end

		local var_3_16 = ccui.Scale9Sprite:createWithSpriteFrameName("bat_dlg_bg3", cc.rect(26, 22, 1, 1))

		var_3_16:setPosition(var_3_15)
		var_3_16:setCascadeOpacityEnabled(true)
		arg_3_0:addChild(var_3_16)

		local var_3_17 = cc.Label:createWithTTF(var_3_14, ClientView.TTF_FONT, ClientView.FontSize.S1)

		var_3_17:setAnchorPoint(0, 0.5)
		var_3_17:setPosition(25, 30)
		var_3_16:addChild(var_3_17)
		var_3_16:setContentSize(cc.size(var_3_17:getContentSize().width + 50, 60))
		var_3_16:runAction(cc.Sequence:create(cc.ScaleTo:create(lc.absTime(0.1), 1.2), cc.ScaleTo:create(lc.absTime(0.1), 1), cc.DelayTime:create(lc.absTime(1.5)), cc.FadeOut:create(lc.absTime(1)), cc.CallFunc:create(function()
			arg_3_0:hide()
		end)))
	elseif arg_3_2 == var_0_0.Type.chat_dialog or arg_3_2 == var_0_0.Type.oppo_chat_dialog then
		local var_3_18 = arg_3_2 == var_0_0.Type.oppo_chat_dialog
		local var_3_19 = cc.Node:create()

		if arg_3_1._isReverse then
			lc.addChildToPos(arg_3_0, var_3_19, cc.p(not var_3_18 and ClientView.SCR_W - 230 or 230, ClientView.SCR_CH + (not var_3_18 and 200 or -200)))
		else
			lc.addChildToPos(arg_3_0, var_3_19, cc.p(var_3_18 and ClientView.SCR_W - 230 or 230, ClientView.SCR_CH + (var_3_18 and 200 or -200)))
		end

		local var_3_20 = ClientView.createTTF(arg_3_3, ClientView.FontSize.M1, ClientView.COLOR_TEXT_DARK)

		lc.addChildToCenter(var_3_19, var_3_20)

		local var_3_21 = ccui.Scale9Sprite:createWithSpriteFrameName("img_tip_bg", ClientView.CRECT_TIP_BG)

		var_3_21:setContentSize(cc.size(math.max(250, lc.w(var_3_20) + 100), 130))

		if not arg_3_1._isReverse then
			var_3_21:setFlippedY(var_3_18)
			var_3_21:setFlippedX(not var_3_18)
			lc.addChildToPos(var_3_19, var_3_21, cc.p(0, var_3_18 and 15 or -20), -1)
		else
			var_3_21:setFlippedY(not var_3_18)
			var_3_21:setFlippedX(var_3_18)
			lc.addChildToPos(var_3_19, var_3_21, cc.p(0, not var_3_18 and 15 or -20), -1)
		end

		var_3_19:setScale(0.2)
		var_3_19:runAction(lc.sequence(lc.ease(lc.scaleTo(lc.absTime(0.4), 1), "BackO"), lc.delay(lc.absTime(2)), lc.scaleTo(lc.absTime(0.3), 0), lc.remove()))
	elseif arg_3_2 == var_0_0.Type.fortress_skill then
		if arg_3_3._player._fortressSkill then
			if not arg_3_1._isReverse then
				arg_3_0:addSkillItem(arg_3_3._player, arg_3_3._player._fortressSkill, cc.p(var_3_0.x + 240, arg_3_3._isController and var_3_0.y - 36 or var_3_0.y + 180))
			else
				arg_3_0:addSkillItem(arg_3_3._player, arg_3_3._player._fortressSkill, cc.p(var_3_0.x + 240, not arg_3_3._isController and var_3_0.y - 36 or var_3_0.y + 180))
			end
		end
	elseif arg_3_2 == var_0_0.Type.exchange then
		local var_3_22 = Str(STR.BATTLE_DIALOG_EXCHANGE_TIP)
		local var_3_23 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 100)
		local var_3_24 = ccui.Scale9Sprite:createWithSpriteFrameName("bat_dlg_bg2", cc.rect(42, 26, 1, 1))

		var_3_24:setContentSize(cc.size(string.len(var_3_22) / 3 * 24 + 70, 60))
		var_3_24:setPosition(var_3_23)
		var_3_24:setCascadeOpacityEnabled(true)
		arg_3_0:addChild(var_3_24)

		local var_3_25 = cc.Label:createWithTTF(var_3_22, ClientView.TTF_FONT, ClientView.FontSize.S1)

		var_3_25:setColor(lc.Color3B.black)
		var_3_25:setAnchorPoint(0, 0.5)
		var_3_25:setPosition(50, 30)
		var_3_24:addChild(var_3_25)
		var_3_24:setContentSize(cc.size(var_3_25:getContentSize().width + 70, 60))
		var_3_24:runAction(cc.Sequence:create(cc.ScaleTo:create(lc.absTime(0.1), 1.2), cc.ScaleTo:create(lc.absTime(0.1), 1)))
	end
end

function var_0_0.hide(arg_7_0)
	arg_7_0:removeFromParent()
end

function var_0_0.addSkillItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = ClientView.createBattleSkillItem(arg_8_1, arg_8_2, arg_8_3)

	arg_8_0:addChild(var_8_0)

	local var_8_1 = cc.Sprite:createWithSpriteFrameName("card_dl_from_5")

	lc.addChildToPos(var_8_0, var_8_1, cc.p(lc.w(var_8_0) - lc.w(var_8_1) / 2 - 16, lc.h(var_8_0) - lc.h(var_8_1) / 2 - 16))
	var_8_0:runAction(cc.Sequence:create(cc.ScaleTo:create(lc.absTime(0.1), 1.2), cc.ScaleTo:create(lc.absTime(0.1), 1), cc.DelayTime:create(lc.absTime(2)), cc.FadeOut:create(lc.absTime(1)), cc.CallFunc:create(function()
		arg_8_0:hide()
	end)))
end

return var_0_0
