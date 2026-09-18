local var_0_0 = BattleTestUi
local var_0_1 = ClientView.SCR_H / 768
local var_0_2 = 11 * var_0_1
local var_0_3 = 130 * var_0_1
local var_0_4 = 180 * var_0_1
local var_0_5 = var_0_3 + var_0_2
local var_0_6 = ClientView.SCR_CW - var_0_3 / 2 - 22 * var_0_1
local var_0_7 = {
	var_0_6,
	var_0_6 + var_0_5,
	var_0_6 - var_0_5,
	var_0_6 + var_0_5 * 2,
	var_0_6 - var_0_5 * 2,
	var_0_6 + var_0_5
}
local var_0_8 = ClientView.SCR_CH - 22 * var_0_1
local var_0_9 = ClientView.SCR_CH + 22 * var_0_1
local var_0_10 = ClientView.SCR_CH - 8 * var_0_1
local var_0_11 = ClientView.SCR_CH + 8 * var_0_1
local var_0_12 = ClientView.SCR_CW - 458 * var_0_1
local var_0_13 = 75 * var_0_1
local var_0_14 = 106 * var_0_1
local var_0_15 = ClientView.SCR_CW - 533 * var_0_1
local var_0_16 = var_0_10 - var_0_14 - 5 * var_0_1
local var_0_17 = var_0_11 + var_0_14 + 5 * var_0_1
local var_0_18 = var_0_12
local var_0_19 = var_0_13
local var_0_20 = var_0_14
local var_0_21 = 60 * var_0_1
local var_0_22 = var_0_21
local var_0_23 = ClientView.SCR_CW + 338 * var_0_1
local var_0_24 = 10 * var_0_1
local var_0_25 = ClientView.SCR_CH - 17 * var_0_1
local var_0_26 = ClientView.SCR_CH + 17 * var_0_1
local var_0_27 = {
	var_0_23,
	var_0_23 + var_0_21 + var_0_24,
	var_0_23,
	var_0_23 + var_0_21 + var_0_24,
	var_0_23
}
local var_0_28 = {
	var_0_25,
	var_0_25,
	var_0_25 - var_0_22 - var_0_24,
	var_0_25 - var_0_22 - var_0_24,
	var_0_25 - var_0_22 * 2 - var_0_24 * 2
}
local var_0_29 = {
	var_0_26,
	var_0_26,
	var_0_26 + var_0_22 + var_0_24,
	var_0_26 + var_0_22 + var_0_24,
	var_0_26 + var_0_22 * 2 + var_0_24 * 2
}
local var_0_30 = {
	PLAYER_LEFT = ClientView.SCR_CW + 575 * var_0_1,
	PLAYER_RIGHT = ClientView.SCR_CW + 670 * var_0_1,
	PLAYER_TOP = ClientView.SCR_CH - 317 * var_0_1,
	PLAYER_BOTTOM = ClientView.SCR_CH - 369 * var_0_1,
	OPPONENT_RIGHT = ClientView.SCR_CW - 575 * var_0_1,
	OPPONENT_LEFT = ClientView.SCR_CW - 670 * var_0_1,
	OPPONENT_BOTTOM = ClientView.SCR_CH + 317 * var_0_1,
	OPPONENT_TOP = ClientView.SCR_CH + 369 * var_0_1
}
local var_0_31 = {
	LEFT = ClientView.SCR_CW - 304 * var_0_1,
	RIGHT = ClientView.SCR_CW + 308 * var_0_1,
	PLAYER_TOP = 138 * var_0_1,
	OPPONENT_BOTTOM = ClientView.SCR_H - 138 * var_0_1
}
local var_0_32 = 7
local var_0_33 = 5

CARD_BLOCK = {
	PLAYER_LEAVE = 7,
	PLAYER_HAND = 5,
	PLAYER_MAGIC_TRAP = 4,
	OPPONENT_GRAVE = 12,
	OPPONENT_MAGIC_TRAP = 14,
	OPPONENT_HAND = 15,
	OPPONENT_LEAVE = 17,
	OPPONENT_BOARD = 11,
	PLAYER_BOARD = 1,
	OPPONENT_PILE = 16,
	PLAYER_PILE = 6,
	OPPONENT_RARE = 13,
	PLAYER_RARE = 3,
	PLAYER_GRAVE = 2
}
_SELECT_CARD_TYPE = {
	MONSTER = 1,
	TRAP = 3,
	MAGIC = 2,
	RARE = 4
}
HP_OWNER = {
	OPPONENT = 2,
	PLAYER = 1
}

local var_0_34 = 0
local var_0_35 = 0
local var_0_36 = 0
local var_0_37 = true
local var_0_38 = {
	isValid = true,
	isPlayer = true,
	pos = 0,
	isDown = true,
	location = {
		beganY = 0,
		endedY = 0
	}
}

function var_0_0.onTouchBegan(arg_1_0, arg_1_1)
	lc.log("onTouchBegan")

	var_0_34 = os.clock()
	var_0_38.location.beganY = arg_1_1:getLocation().y

	if arg_1_0:isInPlayerBoard(arg_1_1) ~= 0 then
		var_0_38.isValid = true
		var_0_38.isPlayer = true
		var_0_38.pos = arg_1_0:isInPlayerBoard(arg_1_1)
	elseif arg_1_0:isInOpponentBoard(arg_1_1) ~= 0 then
		var_0_38.isValid = true
		var_0_38.isPlayer = false
		var_0_38.pos = arg_1_0:isInOpponentBoard(arg_1_1)
	else
		var_0_38.isValid = false
	end

	return true
end

function var_0_0.onTouchMoved(arg_2_0, arg_2_1)
	lc.log("onTouchMoved")
end

function var_0_0.onTouchEnded(arg_3_0, arg_3_1)
	var_0_38.location.endedY = arg_3_1:getLocation().y

	if arg_3_0:isValidPull() then
		local var_3_0

		if var_0_38.isPlayer then
			print("player", var_0_38.pos)

			var_3_0 = arg_3_0._playerUi._pBoardCards[var_0_38.pos]
		else
			print("opponent", var_0_38.pos)

			var_3_0 = arg_3_0._opponentUi._pBoardCards[var_0_38.pos]
		end

		if var_3_0 and not var_3_0._card:isLink() then
			if var_0_38.isDown then
				var_3_0._card._positiveStatus[BattleData.PositiveType.defendPosture] = true
				var_3_0._isDefence = false
			else
				var_3_0._card._positiveStatus[BattleData.PositiveType.defendPosture] = false
				var_3_0._isDefence = true
			end

			var_3_0:updateDefendPosture(true)

			return false
		end
	end

	if arg_3_0:isInPlayerBoard(arg_3_1) ~= 0 then
		local var_3_1 = arg_3_0:isInPlayerBoard(arg_3_1)
		local var_3_2 = {
			_SELECT_CARD_TYPE.MONSTER,
			_SELECT_CARD_TYPE.RARE
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._player._boardCards ~= nil and arg_3_0._player._boardCards[var_3_1] then
				require("BattleTestInputForm").create(function(arg_4_0)
					if arg_4_0 == "" then
						arg_3_0:removeCard(CARD_BLOCK.PLAYER_BOARD, var_3_1)
					else
						arg_3_0:onAddSkill(CARD_BLOCK.PLAYER_BOARD, var_3_1, arg_4_0)
					end
				end, BattleTestData.OperationType._addSkill):show()
			else
				ToastManager.push(Str(STR.SHORT_CLICK_TO_ADD_CARD), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_2, function(arg_5_0, arg_5_1)
				arg_3_0:onCardSelect(arg_5_0, CARD_BLOCK.PLAYER_BOARD, arg_5_1, var_3_1)
			end):show()
			lc.log("isInPlayerBoard -- " .. arg_3_0:isInPlayerBoard(arg_3_1))
		end
	elseif arg_3_0:isInOpponentBoard(arg_3_1) ~= 0 then
		local var_3_3 = arg_3_0:isInOpponentBoard(arg_3_1)
		local var_3_4 = {
			_SELECT_CARD_TYPE.MONSTER,
			_SELECT_CARD_TYPE.RARE
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._opponent._boardCards ~= nil and arg_3_0._opponent._boardCards[var_3_3] then
				require("BattleTestInputForm").create(function(arg_6_0)
					if arg_6_0 == "" then
						arg_3_0:removeCard(CARD_BLOCK.OPPONENT_BOARD, var_3_3)
					else
						arg_3_0:onAddSkill(CARD_BLOCK.OPPONENT_BOARD, var_3_3, arg_6_0)
					end
				end, BattleTestData.OperationType._addSkill):show()
			else
				ToastManager.push(Str(STR.SHORT_CLICK_TO_ADD_CARD), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_4, function(arg_7_0, arg_7_1)
				arg_3_0:onCardSelect(arg_7_0, CARD_BLOCK.OPPONENT_BOARD, arg_7_1, var_3_3)
			end):show()
			lc.log("isInOpponentBoard -- " .. arg_3_0:isInOpponentBoard(arg_3_1))
		end
	elseif arg_3_0:isInPlayerGrave(arg_3_1) then
		local var_3_5 = {
			_SELECT_CARD_TYPE.MONSTER,
			_SELECT_CARD_TYPE.MAGIC,
			_SELECT_CARD_TYPE.TRAP,
			_SELECT_CARD_TYPE.RARE
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._player._graveCards ~= nil and #arg_3_0._player._graveCards > 0 then
				BattleTestListDialog.create(arg_3_0, arg_3_0._player._graveCards, BattleTestListDialog.Mode.single_choice, lc.str(STR.BATTLE_GRAVE), var_0_0.TouchTarget.player_grave):show()
			else
				ToastManager.push(Str(STR.ADD_GRAVE_CARD_FIRST), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_5, function(arg_8_0, arg_8_1)
				arg_3_0:onCardSelect(arg_8_0, CARD_BLOCK.PLAYER_GRAVE, arg_8_1)
			end):show()
			lc.log("isInPlayerGrave")
		end
	elseif arg_3_0:isInOpponentGrave(arg_3_1) then
		local var_3_6 = {
			_SELECT_CARD_TYPE.MONSTER,
			_SELECT_CARD_TYPE.MAGIC,
			_SELECT_CARD_TYPE.TRAP,
			_SELECT_CARD_TYPE.RARE
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._opponent._graveCards ~= nil and #arg_3_0._opponent._graveCards > 0 then
				BattleTestListDialog.create(arg_3_0, arg_3_0._opponent._graveCards, BattleTestListDialog.Mode.single_choice, lc.str(STR.BATTLE_GRAVE), var_0_0.TouchTarget.opponent_grave):show()
			else
				ToastManager.push(Str(STR.ADD_GRAVE_CARD_FIRST), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_6, function(arg_9_0, arg_9_1)
				arg_3_0:onCardSelect(arg_9_0, CARD_BLOCK.OPPONENT_GRAVE, arg_9_1)
			end):show()
			lc.log("isInOpponentGrave")
		end
	elseif arg_3_0:isInPlayerLeave(arg_3_1) then
		local var_3_7 = {
			_SELECT_CARD_TYPE.MONSTER,
			_SELECT_CARD_TYPE.MAGIC,
			_SELECT_CARD_TYPE.TRAP,
			_SELECT_CARD_TYPE.RARE
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._player._leaveCards ~= nil and #arg_3_0._player._leaveCards > 0 then
				BattleTestListDialog.create(arg_3_0, arg_3_0._player._leaveCards, BattleTestListDialog.Mode.single_choice, lc.str(STR.BATTLE_LEAVE), var_0_0.TouchTarget.player_leave):show()
			else
				ToastManager.push(Str(STR.ADD_LEAVE_CARD_FIRST), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_7, function(arg_10_0, arg_10_1)
				arg_3_0:onCardSelect(arg_10_0, CARD_BLOCK.PLAYER_LEAVE, arg_10_1)
			end):show()
			lc.log("isInPlayerLeave")
		end
	elseif arg_3_0:isInOpponentLeave(arg_3_1) then
		local var_3_8 = {
			_SELECT_CARD_TYPE.MONSTER,
			_SELECT_CARD_TYPE.MAGIC,
			_SELECT_CARD_TYPE.TRAP,
			_SELECT_CARD_TYPE.RARE
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._opponent._leaveCards ~= nil and #arg_3_0._opponent._leaveCards > 0 then
				BattleTestListDialog.create(arg_3_0, arg_3_0._opponent._leaveCards, BattleTestListDialog.Mode.single_choice, lc.str(STR.BATTLE_LEAVE), var_0_0.TouchTarget.opponent_leave):show()
			else
				ToastManager.push(Str(STR.ADD_LEAVE_CARD_FIRST), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_8, function(arg_11_0, arg_11_1)
				arg_3_0:onCardSelect(arg_11_0, CARD_BLOCK.OPPONENT_LEAVE, arg_11_1)
			end):show()
			lc.log("isInOpponentLeave")
		end
	elseif arg_3_0:isInPlayerRareArea(arg_3_1) then
		local var_3_9 = {
			_SELECT_CARD_TYPE.RARE
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._player._rareCards ~= nil and #arg_3_0._player._rareCards > 0 then
				BattleTestListDialog.create(arg_3_0, arg_3_0._player._rareCards, BattleTestListDialog.Mode.single_choice, lc.str(STR.BATTLE_EXCARD_LIST), var_0_0.TouchTarget.player_rare):show()
			else
				ToastManager.push(Str(STR.ADD_RARE_CARD_FIRST), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_9, function(arg_12_0, arg_12_1)
				arg_3_0:onCardSelect(arg_12_0, CARD_BLOCK.PLAYER_RARE, arg_12_1)
			end):show()
			lc.log("isInPlayererRareArea")
		end
	elseif arg_3_0:isInOpponentRareArea(arg_3_1) then
		local var_3_10 = {
			_SELECT_CARD_TYPE.RARE
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._opponent._rareCards ~= nil and #arg_3_0._opponent._rareCards > 0 then
				BattleTestListDialog.create(arg_3_0, arg_3_0._opponent._rareCards, BattleTestListDialog.Mode.single_choice, lc.str(STR.BATTLE_EXCARD_LIST), var_0_0.TouchTarget.opponent_rare):show()
			else
				ToastManager.push(Str(STR.ADD_RARE_CARD_FIRST), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_10, function(arg_13_0, arg_13_1)
				arg_3_0:onCardSelect(arg_13_0, CARD_BLOCK.OPPONENT_RARE, arg_13_1)
			end):show()
			lc.log("isInOpponentRareArea")
		end
	elseif arg_3_0:isInPlayerMagicArea(arg_3_1) ~= 0 then
		local var_3_11 = arg_3_0:isInPlayerMagicArea(arg_3_1)
		local var_3_12 = {
			_SELECT_CARD_TYPE.MAGIC,
			_SELECT_CARD_TYPE.TRAP
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._player._showCards ~= nil and arg_3_0._player._showCards[var_3_11] then
				require("BattleTestInputForm").create(function(arg_14_0)
					if arg_14_0 == "" then
						arg_3_0:removeCard(CARD_BLOCK.PLAYER_MAGIC_TRAP, var_3_11)
					else
						arg_3_0:onAddSkill(CARD_BLOCK.PLAYER_MAGIC_TRAP, var_3_11, arg_14_0)
					end
				end, BattleTestData.OperationType._addSkill):show()
			else
				ToastManager.push(Str(STR.ADD_MAGIC_TRAP_CARD_FIRST), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_12, function(arg_15_0, arg_15_1)
				arg_3_0:onCardSelect(arg_15_0, CARD_BLOCK.PLAYER_MAGIC_TRAP, arg_15_1, var_3_11)
			end, true):show()
			lc.log("isInPlayerMagicArea -- " .. arg_3_0:isInPlayerMagicArea(arg_3_1))
		end
	elseif arg_3_0:isInOpponentMagicArea(arg_3_1) ~= 0 then
		local var_3_13 = arg_3_0:isInOpponentMagicArea(arg_3_1)
		local var_3_14 = {
			_SELECT_CARD_TYPE.MAGIC,
			_SELECT_CARD_TYPE.TRAP
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._opponent._showCards ~= nil and arg_3_0._opponent._showCards[var_3_13] then
				require("BattleTestInputForm").create(function(arg_16_0)
					if arg_16_0 == "" then
						arg_3_0:removeCard(CARD_BLOCK.OPPONENT_MAGIC_TRAP, var_3_13)
					else
						arg_3_0:onAddSkill(CARD_BLOCK.OPPONENT_MAGIC_TRAP, var_3_13, arg_16_0)
					end
				end, BattleTestData.OperationType._addSkill):show()
			else
				ToastManager.push(Str(STR.ADD_MAGIC_TRAP_CARD_FIRST), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_14, function(arg_17_0, arg_17_1)
				arg_3_0:onCardSelect(arg_17_0, CARD_BLOCK.OPPONENT_MAGIC_TRAP, arg_17_1, var_3_13)
			end, true):show()
			lc.log("isInOpponentMagicArea -- " .. arg_3_0:isInOpponentMagicArea(arg_3_1))
		end
	elseif arg_3_0:isInPlayerPileArea(arg_3_1) then
		local var_3_15 = {
			_SELECT_CARD_TYPE.MONSTER,
			_SELECT_CARD_TYPE.MAGIC,
			_SELECT_CARD_TYPE.TRAP
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._player._pileCards ~= nil and #arg_3_0._player._pileCards > 0 then
				BattleTestListDialog.create(arg_3_0, arg_3_0._player._pileCards, BattleTestListDialog.Mode.single_choice, lc.str(STR.BATTLE_PILE), var_0_0.TouchTarget.player_pile):show()
			else
				ToastManager.push(Str(STR.ADD_PILE_CARD_FIRST), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_15, function(arg_18_0, arg_18_1)
				arg_3_0:onCardSelect(arg_18_0, CARD_BLOCK.PLAYER_PILE, arg_18_1)
			end):show()
			lc.log("in attackerDealArea")
		end
	elseif arg_3_0:isInOpponentPileArea(arg_3_1) then
		local var_3_16 = {
			_SELECT_CARD_TYPE.MONSTER,
			_SELECT_CARD_TYPE.MAGIC,
			_SELECT_CARD_TYPE.TRAP
		}

		if arg_3_0:isLongClick() then
			if arg_3_0._opponent._pileCards ~= nil and #arg_3_0._opponent._pileCards > 0 then
				BattleTestListDialog.create(arg_3_0, arg_3_0._opponent._pileCards, BattleTestListDialog.Mode.single_choice, lc.str(STR.BATTLE_PILE), var_0_0.TouchTarget.opponent_pile):show()
			else
				ToastManager.push(Str(STR.ADD_PILE_CARD_FIRST), 1)
			end
		else
			require("BattleTestCardSelectForm").create(var_3_16, function(arg_19_0, arg_19_1)
				arg_3_0:onCardSelect(arg_19_0, CARD_BLOCK.OPPONENT_PILE, arg_19_1)
			end):show()
			lc.log("in defenderdeal area")
		end
	elseif arg_3_0:isInPlayerHpArea(arg_3_1) then
		lc.log("in palyer hp")
		require("BattleTestInputForm").create(function(arg_20_0)
			arg_3_0:onHpSet(arg_20_0, HP_OWNER.PLAYER)
		end, BattleTestData.OperationType._modifyHp):show()
	elseif arg_3_0:isInOpponentHpArea(arg_3_1) then
		lc.log("in op hp")
		require("BattleTestInputForm").create(function(arg_21_0)
			arg_3_0:onHpSet(arg_21_0, HP_OWNER.OPPONENT)
		end, BattleTestData.OperationType._modifyHp):show()
	elseif arg_3_0:isInPlayerHandArea(arg_3_1) then
		lc.log("isInPlayerHandArea")

		local var_3_17 = arg_3_0._player._handCards

		if arg_3_0:isLongClick() then
			if var_3_17 ~= nil and #var_3_17 > 0 then
				BattleTestListDialog.create(arg_3_0, var_3_17, BattleTestListDialog.Mode.single_choice, lc.str(STR.BATTLE_HAND), var_0_0.TouchTarget.player_hand):show()
			else
				ToastManager.push(Str(STR.ADD_HAND_CARD_FIRST), 1)
			end
		elseif var_3_17 ~= nil and #var_3_17 >= var_0_32 then
			ToastManager.push(Str(STR.DELETE_HAND_CARDS_WHEN_MAX), 1)
		else
			local var_3_18 = {
				_SELECT_CARD_TYPE.MONSTER,
				_SELECT_CARD_TYPE.MAGIC,
				_SELECT_CARD_TYPE.TRAP
			}

			require("BattleTestCardSelectForm").create(var_3_18, function(arg_22_0, arg_22_1)
				arg_3_0:onCardSelect(arg_22_0, CARD_BLOCK.PLAYER_HAND, arg_22_1)
			end):show()
		end
	elseif arg_3_0:isInOpponentHandArea(arg_3_1) then
		lc.log("isInOpponentHandArea")

		local var_3_19 = arg_3_0._opponent._handCards

		if arg_3_0:isLongClick() then
			if var_3_19 ~= nil and #var_3_19 > 0 then
				BattleTestListDialog.create(arg_3_0, var_3_19, BattleTestListDialog.Mode.single_choice, lc.str(STR.BATTLE_HAND), var_0_0.TouchTarget.opponent_hand):show()
			else
				ToastManager.push(Str(STR.ADD_HAND_CARD_FIRST), 1)
			end
		elseif var_3_19 ~= nil and #var_3_19 >= var_0_32 then
			ToastManager.push(Str(STR.DELETE_HAND_CARDS_WHEN_MAX), 1)
		else
			local var_3_20 = {
				_SELECT_CARD_TYPE.MONSTER,
				_SELECT_CARD_TYPE.MAGIC,
				_SELECT_CARD_TYPE.TRAP
			}

			require("BattleTestCardSelectForm").create(var_3_20, function(arg_23_0, arg_23_1)
				arg_3_0:onCardSelect(arg_23_0, CARD_BLOCK.OPPONENT_HAND, arg_23_1)
			end):show()
		end
	end

	return false
end

function var_0_0.hasCards(arg_24_0, arg_24_1)
	for iter_24_0 = 1, var_0_33 do
		if arg_24_1[iter_24_0] ~= nil then
			return true
		end
	end

	return false
end

function var_0_0.isInPlayerBoard(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1:getLocation().x
	local var_25_1 = arg_25_1:getLocation().y
	local var_25_2 = 0

	for iter_25_0, iter_25_1 in ipairs(var_0_7) do
		if iter_25_1 <= var_25_0 and var_25_0 < iter_25_1 + var_0_3 then
			var_25_2 = iter_25_0

			break
		end
	end

	if var_25_1 < var_0_8 and var_25_1 > var_0_8 - var_0_4 then
		-- block empty
	else
		var_25_2 = var_25_1 >= var_0_8 and var_25_1 <= var_0_9 and (var_25_2 == 2 and 6 or 0) or 0
	end

	return var_25_2
end

function var_0_0.isInOpponentBoard(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1:getLocation().x
	local var_26_1 = arg_26_1:getLocation().y
	local var_26_2 = 0

	for iter_26_0, iter_26_1 in ipairs(var_0_7) do
		if iter_26_1 <= var_26_0 and var_26_0 < iter_26_1 + var_0_3 then
			if iter_26_0 == 2 or iter_26_0 == 3 then
				var_26_2 = 5 - iter_26_0

				break
			end

			if iter_26_0 == 4 or iter_26_0 == 5 then
				var_26_2 = 9 - iter_26_0

				break
			end

			var_26_2 = iter_26_0

			break
		end
	end

	if var_26_1 > var_0_9 and var_26_1 < var_0_9 + var_0_4 then
		-- block empty
	else
		var_26_2 = var_26_1 >= var_0_8 and var_26_1 <= var_0_9 and (var_26_2 == 2 and 6 or 0) or 0
	end

	return var_26_2
end

function var_0_0.isInPlayerGrave(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:getLocation().x
	local var_27_1 = arg_27_1:getLocation().y

	lc.log("touch:(" .. tostring(var_27_0) .. "," .. tostring(var_27_1) .. ")")
	lc.log("grave:(" .. tostring(PlayerUi.Pos.attacker_grave.x) .. "," .. tostring(PlayerUi.Pos.attacker_grave.y) .. ")")

	if var_27_0 > var_0_12 and var_27_0 < var_0_12 + var_0_13 and var_27_1 < var_0_10 and var_27_1 > var_0_10 - var_0_14 then
		return true
	end

	return false
end

function var_0_0.isInOpponentGrave(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1:getLocation().x
	local var_28_1 = arg_28_1:getLocation().y

	lc.log("touch:(" .. tostring(var_28_0) .. "," .. tostring(var_28_1) .. ")")

	if var_28_0 > var_0_12 and var_28_0 < var_0_12 + var_0_13 and var_28_1 > var_0_11 and var_28_1 < var_0_11 + var_0_14 then
		return true
	end

	return false
end

function var_0_0.isInPlayerLeave(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1:getLocation().x
	local var_29_1 = arg_29_1:getLocation().y

	lc.log("touch:(" .. tostring(var_29_0) .. "," .. tostring(var_29_1) .. ")")

	if var_29_0 > var_0_15 and var_29_0 < var_0_15 + var_0_13 and var_29_1 < var_0_10 and var_29_1 > var_0_10 - var_0_14 then
		return true
	end

	return false
end

function var_0_0.isInOpponentLeave(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1:getLocation().x
	local var_30_1 = arg_30_1:getLocation().y

	lc.log("touch:(" .. tostring(var_30_0) .. "," .. tostring(var_30_1) .. ")")

	if var_30_0 > var_0_15 and var_30_0 < var_0_12 + var_0_13 and var_30_1 > var_0_11 and var_30_1 < var_0_11 + var_0_14 then
		return true
	end

	return false
end

function var_0_0.isInPlayerRareArea(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1:getLocation().x
	local var_31_1 = arg_31_1:getLocation().y

	lc.log("touch:(" .. tostring(var_31_0) .. "," .. tostring(var_31_1) .. ")")

	if var_31_0 > var_0_18 and var_31_0 < var_0_18 + var_0_19 and var_31_1 < var_0_16 and var_31_1 > var_0_16 - var_0_20 then
		return true
	end

	return false
end

function var_0_0.isInOpponentRareArea(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1:getLocation().x
	local var_32_1 = arg_32_1:getLocation().y

	lc.log("touch:(" .. tostring(var_32_0) .. "," .. tostring(var_32_1) .. ")")

	if var_32_0 > var_0_18 and var_32_0 < var_0_18 + var_0_19 and var_32_1 > var_0_17 and var_32_1 < var_0_17 + var_0_14 then
		return true
	end

	return false
end

function var_0_0.isInPlayerMagicArea(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1:getLocation().x
	local var_33_1 = arg_33_1:getLocation().y
	local var_33_2 = 0

	for iter_33_0 = 1, 5 do
		if var_33_0 >= var_0_27[iter_33_0] and var_33_0 < var_0_27[iter_33_0] + var_0_21 and var_33_1 <= var_0_28[iter_33_0] and var_33_1 > var_0_28[iter_33_0] - var_0_22 then
			var_33_2 = iter_33_0

			break
		end
	end

	return var_33_2
end

function var_0_0.isInOpponentMagicArea(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1:getLocation().x
	local var_34_1 = arg_34_1:getLocation().y
	local var_34_2 = 0

	for iter_34_0 = 1, 5 do
		if var_34_0 >= var_0_27[iter_34_0] and var_34_0 < var_0_27[iter_34_0] + var_0_21 and var_34_1 >= var_0_29[iter_34_0] and var_34_1 < var_0_29[iter_34_0] + var_0_22 then
			var_34_2 = iter_34_0

			break
		end
	end

	return var_34_2
end

function var_0_0.isInPlayerPileArea(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1:getLocation().x
	local var_35_1 = arg_35_1:getLocation().y

	lc.log("touch:(" .. tostring(var_35_0) .. "," .. tostring(var_35_1) .. ")")

	if var_35_0 > var_0_30.PLAYER_LEFT and var_35_0 < var_0_30.PLAYER_RIGHT and var_35_1 > var_0_30.PLAYER_BOTTOM and var_35_1 < var_0_30.PLAYER_TOP then
		return true
	end

	return false
end

function var_0_0.isInOpponentPileArea(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1:getLocation().x
	local var_36_1 = arg_36_1:getLocation().y

	lc.log("touch:(" .. tostring(var_36_0) .. "," .. tostring(var_36_1) .. ")")

	if var_36_0 > var_0_30.OPPONENT_LEFT and var_36_0 < var_0_30.OPPONENT_RIGHT and var_36_1 > var_0_30.OPPONENT_BOTTOM and var_36_1 < var_0_30.OPPONENT_TOP then
		return true
	end

	return false
end

function var_0_0.isInPlayerHpArea(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1:getLocation().x
	local var_37_1 = arg_37_1:getLocation().y
	local var_37_2 = 0.25 * var_37_0 + var_37_1

	if var_37_2 > 109 * var_0_1 and var_37_2 < 150 * var_0_1 and var_37_0 < 148 * var_0_1 then
		return true
	end

	return false
end

function var_0_0.isInOpponentHpArea(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1:getLocation().x
	local var_38_1 = arg_38_1:getLocation().y
	local var_38_2 = 2 * ClientView.SCR_CW - var_38_0
	local var_38_3 = 2 * ClientView.SCR_CH - var_38_1
	local var_38_4 = 0.25 * var_38_2 + var_38_3

	if var_38_4 > 109 and var_38_4 < 150 and var_38_2 < 148 then
		return true
	end

	return false
end

function var_0_0.isInPlayerHandArea(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1:getLocation().x
	local var_39_1 = arg_39_1:getLocation().y

	if var_39_0 > var_0_31.LEFT and var_39_0 < var_0_31.RIGHT and var_39_1 < var_0_31.PLAYER_TOP then
		return true
	end

	return flase
end

function var_0_0.isInOpponentHandArea(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1:getLocation().x
	local var_40_1 = arg_40_1:getLocation().y

	if var_40_0 > var_0_31.LEFT and var_40_0 < var_0_31.RIGHT and var_40_1 > var_0_31.OPPONENT_BOTTOM then
		return true
	end

	return flase
end

function var_0_0.isLongClick(arg_41_0)
	local var_41_0 = os.clock() - var_0_34

	lc.log("touch duration " .. var_41_0)

	if var_41_0 < 0.3 then
		lc.log("single click")

		return false
	else
		lc.log("isLongClick")

		return true
	end
end

function var_0_0.isValidPull(arg_42_0)
	if not var_0_38.isValid then
		return false
	end

	local var_42_0 = var_0_38.location.beganY
	local var_42_1 = var_0_38.location.endedY
	local var_42_2 = var_42_0 - var_42_1

	if var_42_0 > 0 and var_42_1 > 0 and var_42_2 > 40 then
		var_0_38.isDown = true
		var_0_38.isValid = true
	elseif var_42_0 > 0 and var_42_1 > 0 and var_42_2 < -40 then
		var_0_38.isDown = false
		var_0_38.isValid = true
	else
		var_0_38.isValid = false
	end

	return var_0_38.isValid
end

function var_0_0.onCardSelect(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	if arg_43_3 ~= true then
		arg_43_0:removeCard(arg_43_2, arg_43_4)
	end

	if arg_43_2 == CARD_BLOCK.PLAYER_BOARD then
		local var_43_0 = require("BattleCard").new(arg_43_1, 1, arg_43_0._player)

		if arg_43_4 == 6 and not var_43_0:isLink() then
			return
		end

		var_43_0:resetOnce()

		if arg_43_3 then
			local var_43_1 = 0

			for iter_43_0 = 1, var_0_33 do
				if not arg_43_0._player._boardCards[iter_43_0] then
					var_43_1 = iter_43_0

					break
				end
			end

			if var_43_1 > 0 then
				arg_43_4 = var_43_1
				var_43_0._pos = arg_43_4
			else
				return
			end
		elseif arg_43_4 then
			var_43_0._pos = arg_43_4
		end

		arg_43_0._player._boardCards[arg_43_4] = var_43_0

		arg_43_0._player:addCardToCards(var_43_0)

		local var_43_2 = arg_43_0._playerUi:createCardSprite(var_43_0)

		arg_43_0:addChild(var_43_2)
		arg_43_0._playerUi:addCardToBoardFast(var_43_0)
	elseif arg_43_2 == CARD_BLOCK.OPPONENT_BOARD then
		local var_43_3 = require("BattleCard").new(arg_43_1, 1, arg_43_0._opponent)

		if arg_43_4 == 6 and not var_43_3:isLink() then
			return
		end

		var_43_3:resetOnce()

		if arg_43_3 then
			local var_43_4 = 0

			for iter_43_1 = 1, var_0_33 do
				if not arg_43_0._opponent._boardCards[iter_43_1] then
					var_43_4 = iter_43_1

					break
				end
			end

			if var_43_4 > 0 then
				arg_43_4 = var_43_4
				var_43_3._pos = arg_43_4
			else
				return
			end
		elseif arg_43_4 then
			var_43_3._pos = arg_43_4
		end

		arg_43_0._opponent._boardCards[arg_43_4] = var_43_3

		arg_43_0._opponent:addCardToCards(var_43_3)

		local var_43_5 = arg_43_0._opponentUi:createCardSprite(var_43_3)

		arg_43_0:addChild(var_43_5)
		arg_43_0._opponentUi:addCardToBoardFast(var_43_3)
	elseif arg_43_2 == CARD_BLOCK.PLAYER_GRAVE then
		local var_43_6 = require("BattleCard").new(arg_43_1, 1, arg_43_0._player)

		var_43_6:resetOnce()
		arg_43_0._player:addCardToCards(var_43_6)
		arg_43_0._player:addCardToGrave(var_43_6)

		local var_43_7 = arg_43_0._playerUi:createCardSprite(var_43_6)

		arg_43_0:addChild(var_43_7)
		arg_43_0._playerUi:addCardToGrave(var_43_6, 0, 0)
	elseif arg_43_2 == CARD_BLOCK.OPPONENT_GRAVE then
		local var_43_8 = require("BattleCard").new(arg_43_1, 1, arg_43_0._opponent)

		var_43_8:resetOnce()
		arg_43_0._opponent:addCardToCards(var_43_8)
		arg_43_0._opponent:addCardToGrave(var_43_8)

		local var_43_9 = arg_43_0._opponentUi:createCardSprite(var_43_8)

		arg_43_0:addChild(var_43_9)
		arg_43_0._opponentUi:addCardToGrave(var_43_8, 0, 0)
	elseif arg_43_2 == CARD_BLOCK.PLAYER_LEAVE then
		local var_43_10 = require("BattleCard").new(arg_43_1, 1, arg_43_0._player)

		var_43_10:resetOnce()
		arg_43_0._player:addCardToCards(var_43_10)
		arg_43_0._player:addCardToLeave(var_43_10)

		local var_43_11 = arg_43_0._playerUi:createCardSprite(var_43_10)

		arg_43_0:addChild(var_43_11)
		arg_43_0._playerUi:addCardToLeave(var_43_10, 0, 0)
	elseif arg_43_2 == CARD_BLOCK.OPPONENT_LEAVE then
		local var_43_12 = require("BattleCard").new(arg_43_1, 1, arg_43_0._opponent)

		var_43_12:resetOnce()
		arg_43_0._opponent:addCardToCards(var_43_12)
		arg_43_0._opponent:addCardToLeave(var_43_12)

		local var_43_13 = arg_43_0._opponentUi:createCardSprite(var_43_12)

		arg_43_0:addChild(var_43_13)
		arg_43_0._opponentUi:addCardToLeave(var_43_12, 0, 0)
	elseif arg_43_2 == CARD_BLOCK.PLAYER_RARE then
		local var_43_14 = require("BattleCard").new(arg_43_1, 1, arg_43_0._player)

		var_43_14:resetOnce()
		arg_43_0._player:addCardToCards(var_43_14)
		arg_43_0._player:addCardToRare(var_43_14)

		local var_43_15 = arg_43_0._playerUi:createCardSprite(var_43_14)

		arg_43_0:addChild(var_43_15)
		arg_43_0._playerUi:addCardToRareFast(var_43_14)
	elseif arg_43_2 == CARD_BLOCK.OPPONENT_RARE then
		local var_43_16 = require("BattleCard").new(arg_43_1, 1, arg_43_0._opponent)

		var_43_16:resetOnce()
		arg_43_0._opponent:addCardToCards(var_43_16)
		arg_43_0._opponent:addCardToRare(var_43_16)

		local var_43_17 = arg_43_0._opponentUi:createCardSprite(var_43_16)

		arg_43_0:addChild(var_43_17)
		arg_43_0._opponentUi:addCardToRareFast(var_43_16)
	elseif arg_43_2 == CARD_BLOCK.PLAYER_MAGIC_TRAP then
		local var_43_18 = require("BattleCard").new(arg_43_1, 1, arg_43_0._player)

		var_43_18:resetOnce()

		var_43_18._sourceStatus = BattleData.CardStatus.hand

		if arg_43_3 then
			local var_43_19 = 0

			for iter_43_2 = 1, var_0_33 do
				if not arg_43_0._player._showCards[iter_43_2] then
					var_43_19 = iter_43_2

					break
				end
			end

			if var_43_19 > 0 then
				arg_43_4 = var_43_19
				var_43_18._pos = arg_43_4
			else
				return
			end
		elseif arg_43_4 then
			var_43_18._pos = arg_43_4
		end

		arg_43_0._player._showCards[arg_43_4] = var_43_18

		arg_43_0._player:addCardToCards(var_43_18)

		local var_43_20 = arg_43_0._playerUi:createCardSprite(var_43_18)

		arg_43_0:addChild(var_43_20)
		arg_43_0._playerUi:addCardToShowFast(var_43_18)
	elseif arg_43_2 == CARD_BLOCK.OPPONENT_MAGIC_TRAP then
		local var_43_21 = require("BattleCard").new(arg_43_1, 1, arg_43_0._opponent)

		var_43_21:resetOnce()

		var_43_21._sourceStatus = BattleData.CardStatus.hand

		if arg_43_3 then
			local var_43_22 = 0

			for iter_43_3 = 1, var_0_33 do
				if not arg_43_0._opponent._showCards[iter_43_3] then
					var_43_22 = iter_43_3

					break
				end
			end

			if var_43_22 > 0 then
				arg_43_4 = var_43_22
				var_43_21._pos = arg_43_4
			else
				return
			end
		elseif arg_43_4 then
			var_43_21._pos = arg_43_4
		end

		arg_43_0._opponent._showCards[arg_43_4] = var_43_21

		arg_43_0._opponent:addCardToCards(var_43_21)

		local var_43_23 = arg_43_0._opponentUi:createCardSprite(var_43_21)

		arg_43_0:addChild(var_43_23)
		arg_43_0._opponentUi:addCardToShowFast(var_43_21)
	elseif arg_43_2 == CARD_BLOCK.PLAYER_HAND then
		if #arg_43_0._player._handCards >= var_0_32 then
			return
		end

		local var_43_24 = require("BattleCard").new(arg_43_1, 1, arg_43_0._player)

		arg_43_4 = 1

		if arg_43_0._player._handCards ~= nil then
			arg_43_4 = #arg_43_0._player._handCards + 1
		end

		var_43_24._pos = arg_43_4

		var_43_24:resetOnce()
		arg_43_0._player:addCardToCards(var_43_24)
		arg_43_0._player:addCardToHand(var_43_24)

		local var_43_25 = arg_43_0._playerUi:createCardSprite(var_43_24)

		arg_43_0:addChild(var_43_25)
		arg_43_0._playerUi:addCardToHandFast(var_43_24)
	elseif arg_43_2 == CARD_BLOCK.OPPONENT_HAND then
		if #arg_43_0._opponent._handCards >= var_0_32 then
			return
		end

		local var_43_26 = require("BattleCard").new(arg_43_1, 1, arg_43_0._opponent)

		arg_43_4 = 1

		if arg_43_0._opponent._handCards ~= nil then
			arg_43_4 = #arg_43_0._opponent._handCards + 1
		end

		var_43_26._pos = arg_43_4

		var_43_26:resetOnce()
		arg_43_0._opponent:addCardToCards(var_43_26)
		arg_43_0._opponent:addCardToHand(var_43_26)

		local var_43_27 = arg_43_0._opponentUi:createCardSprite(var_43_26)

		arg_43_0:addChild(var_43_27)
		arg_43_0._opponentUi:addCardToHandFast(var_43_26)
	elseif arg_43_2 == CARD_BLOCK.PLAYER_PILE then
		local var_43_28 = require("BattleCard").new(arg_43_1, 1, arg_43_0._player)

		var_43_28:resetOnce()
		arg_43_0._player:addCardToCards(var_43_28)

		var_43_28._saved._pos = #arg_43_0._player._pileCards + 1

		arg_43_0._player:addCardToPile(var_43_28)

		local var_43_29 = arg_43_0._playerUi:createCardSprite(var_43_28)

		arg_43_0:addChild(var_43_29)
		arg_43_0._playerUi:addCardToPileFast(var_43_28, 0, 0)
		arg_43_0:updatePile(arg_43_0._playerUi)
	elseif arg_43_2 == CARD_BLOCK.OPPONENT_PILE then
		local var_43_30 = require("BattleCard").new(arg_43_1, 1, arg_43_0._opponent)

		var_43_30:resetOnce()
		arg_43_0._opponent:addCardToCards(var_43_30)

		var_43_30._saved._pos = #arg_43_0._opponent._pileCards + 1

		arg_43_0._opponent:addCardToPile(var_43_30)

		local var_43_31 = arg_43_0._opponentUi:createCardSprite(var_43_30)

		arg_43_0:addChild(var_43_31)
		arg_43_0._opponentUi:addCardToPileFast(var_43_30, 0, 0)
		arg_43_0:updatePile(arg_43_0._opponentUi)
	end
end

function var_0_0.removeCard(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_1 == CARD_BLOCK.PLAYER_BOARD then
		local var_44_0 = arg_44_0._player._boardCards[arg_44_2]

		if var_44_0 then
			local var_44_1 = arg_44_0._playerUi:getCardSprite(var_44_0)

			arg_44_0._player:removeCardFromCards(var_44_0)
			arg_44_0._player:removeCardFromBoard(var_44_0)
			arg_44_0._playerUi:removeCardFromBoard(var_44_0)
			arg_44_0._playerUi:removeCardFromSprites(var_44_1)
			var_44_1:removeFromParent()
		end
	elseif arg_44_1 == CARD_BLOCK.OPPONENT_BOARD then
		local var_44_2 = arg_44_0._opponent._boardCards[arg_44_2]

		if var_44_2 then
			local var_44_3 = arg_44_0._opponentUi:getCardSprite(var_44_2)

			arg_44_0._opponent:removeCardFromCards(var_44_2)
			arg_44_0._opponent:removeCardFromBoard(var_44_2)
			arg_44_0._opponentUi:removeCardFromBoard(var_44_2)
			arg_44_0._opponentUi:removeCardFromSprites(var_44_3)
			var_44_3:removeFromParent()
		end
	elseif arg_44_1 == CARD_BLOCK.PLAYER_MAGIC_TRAP then
		local var_44_4 = arg_44_0._player._showCards[arg_44_2]

		if var_44_4 then
			local var_44_5 = arg_44_0._playerUi:getCardSprite(var_44_4)

			arg_44_0._player:removeCardFromCards(var_44_4)
			arg_44_0._player:removeCardFromShow(var_44_4)
			arg_44_0._playerUi:removeCardFromBoard(var_44_4)
			arg_44_0._playerUi:removeCardFromSprites(var_44_5)
			var_44_5:removeFromParent()
		end
	elseif arg_44_1 == CARD_BLOCK.OPPONENT_MAGIC_TRAP then
		local var_44_6 = arg_44_0._opponent._showCards[arg_44_2]

		if var_44_6 then
			local var_44_7 = arg_44_0._opponentUi:getCardSprite(var_44_6)

			arg_44_0._opponent:removeCardFromCards(var_44_6)
			arg_44_0._opponent:removeCardFromShow(var_44_6)
			arg_44_0._opponentUi:removeCardFromBoard(var_44_6)
			arg_44_0._opponentUi:removeCardFromSprites(var_44_7)
			var_44_7:removeFromParent()
		end
	end
end

function var_0_0.reset(arg_45_0)
	for iter_45_0 = 1, var_0_33 do
		arg_45_0:removeCard(CARD_BLOCK.PLAYER_BOARD, iter_45_0)
		arg_45_0:removeCard(CARD_BLOCK.OPPONENT_BOARD, iter_45_0)
		arg_45_0:removeCard(CARD_BLOCK.PLAYER_MAGIC_TRAP, iter_45_0)
		arg_45_0:removeCard(CARD_BLOCK.OPPONENT_MAGIC_TRAP, iter_45_0)
	end

	arg_45_0:removeCard(CARD_BLOCK.PLAYER_BOARD, var_0_33 + 1)
	arg_45_0:removeCard(CARD_BLOCK.OPPONENT_BOARD, var_0_33 + 1)

	for iter_45_1 = #arg_45_0._player._rareCards, 1, -1 do
		local var_45_0 = arg_45_0._player._rareCards[iter_45_1]
		local var_45_1 = arg_45_0._playerUi:getCardSprite(var_45_0)

		arg_45_0._player:removeCardFromRare(var_45_0)
		arg_45_0._player:removeCardFromCards(var_45_0)
		arg_45_0._playerUi:removeCardFromRare(var_45_0)
		arg_45_0._playerUi:removeCardFromSprites(var_45_1)
		var_45_1:removeFromParent()
	end

	for iter_45_2 = #arg_45_0._opponent._rareCards, 1, -1 do
		local var_45_2 = arg_45_0._opponent._rareCards[iter_45_2]
		local var_45_3 = arg_45_0._opponentUi:getCardSprite(var_45_2)

		arg_45_0._opponent:removeCardFromRare(var_45_2)
		arg_45_0._opponent:removeCardFromCards(var_45_2)
		arg_45_0._opponentUi:removeCardFromRare(var_45_2)
		arg_45_0._opponentUi:removeCardFromSprites(var_45_3)
		var_45_3:removeFromParent()
	end

	for iter_45_3 = #arg_45_0._player._graveCards, 1, -1 do
		local var_45_4 = arg_45_0._player._graveCards[iter_45_3]
		local var_45_5 = arg_45_0._playerUi:getCardSprite(var_45_4)

		arg_45_0._player:removeCardFromGrave(var_45_4)
		arg_45_0._player:removeCardFromCards(var_45_4)
		arg_45_0._playerUi:removeCardFromGrave(var_45_4)
		arg_45_0._playerUi:removeCardFromSprites(var_45_5)
		var_45_5:removeFromParent()
	end

	for iter_45_4 = #arg_45_0._opponent._graveCards, 1, -1 do
		local var_45_6 = arg_45_0._opponent._graveCards[iter_45_4]
		local var_45_7 = arg_45_0._opponentUi:getCardSprite(var_45_6)

		arg_45_0._opponent:removeCardFromGrave(var_45_6)
		arg_45_0._opponent:removeCardFromCards(var_45_6)
		arg_45_0._opponentUi:removeCardFromGrave(var_45_6)
		arg_45_0._opponentUi:removeCardFromSprites(var_45_7)
		var_45_7:removeFromParent()
	end

	for iter_45_5 = #arg_45_0._player._leaveCards, 1, -1 do
		local var_45_8 = arg_45_0._player._leaveCards[iter_45_5]
		local var_45_9 = arg_45_0._playerUi:getCardSprite(var_45_8)

		arg_45_0._player:removeCardFromLeave(var_45_8)
		arg_45_0._player:removeCardFromCards(var_45_8)
		arg_45_0._playerUi:removeCardFromSprites(var_45_9)
		var_45_9:removeFromParent()
	end

	for iter_45_6 = #arg_45_0._opponent._leaveCards, 1, -1 do
		local var_45_10 = arg_45_0._opponent._leaveCards[iter_45_6]
		local var_45_11 = arg_45_0._opponentUi:getCardSprite(var_45_10)

		arg_45_0._opponent:removeCardFromLeave(var_45_10)
		arg_45_0._opponent:removeCardFromCards(var_45_10)
		arg_45_0._opponentUi:removeCardFromSprites(var_45_11)
		var_45_11:removeFromParent()
	end

	for iter_45_7 = #arg_45_0._player._handCards, 1, -1 do
		local var_45_12 = arg_45_0._player._handCards[iter_45_7]
		local var_45_13 = arg_45_0._playerUi:getCardSprite(var_45_12)

		arg_45_0._player:removeCardFromHand(var_45_12)
		arg_45_0._player:removeCardFromCards(var_45_12)
		arg_45_0._playerUi:removeCardFromHand(var_45_12)
		arg_45_0._playerUi:removeCardFromSprites(var_45_13)
		var_45_13:removeFromParent()
		arg_45_0._playerUi:replaceHandCards(0)
	end

	for iter_45_8 = #arg_45_0._opponent._handCards, 1, -1 do
		local var_45_14 = arg_45_0._opponent._handCards[iter_45_8]
		local var_45_15 = arg_45_0._opponentUi:getCardSprite(var_45_14)

		arg_45_0._opponent:removeCardFromHand(var_45_14)
		arg_45_0._opponent:removeCardFromCards(var_45_14)
		arg_45_0._opponentUi:removeCardFromHand(var_45_14)
		arg_45_0._opponentUi:removeCardFromSprites(var_45_15)
		var_45_15:removeFromParent()
		arg_45_0._opponentUi:replaceHandCards(0)
	end

	for iter_45_9 = #arg_45_0._player._pileCards, 1, -1 do
		local var_45_16 = arg_45_0._player._pileCards[iter_45_9]
		local var_45_17 = arg_45_0._playerUi:getCardSprite(var_45_16)

		arg_45_0._player:removeCardFromPile(var_45_16)
		arg_45_0._player:removeCardFromCards(var_45_16)
		arg_45_0._playerUi:removeCardFromSprites(var_45_17)
		arg_45_0:updatePile(arg_45_0._playerUi)
	end

	for iter_45_10 = #arg_45_0._opponent._pileCards, 1, -1 do
		local var_45_18 = arg_45_0._opponent._pileCards[iter_45_10]
		local var_45_19 = arg_45_0._opponentUi:getCardSprite(var_45_18)

		arg_45_0._opponent:removeCardFromPile(var_45_18)
		arg_45_0._opponent:removeCardFromCards(var_45_18)
		arg_45_0._opponentUi:removeCardFromSprites(var_45_19)
		arg_45_0:updatePile(arg_45_0._opponentUi)
	end

	arg_45_0._playerUi:setFortressHp(8000)
	arg_45_0._opponentUi:setFortressHp(8000)
end

function var_0_0.onHpSet(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_1 ~= nil and tonumber(arg_46_1) ~= nil then
		if arg_46_2 == HP_OWNER.PLAYER then
			arg_46_0._playerUi:setFortressHp(arg_46_1)
		elseif arg_46_2 == HP_OWNER.OPPONENT then
			arg_46_0._opponentUi:setFortressHp(arg_46_1)
		end
	end
end

function var_0_0.onAddSkill(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0

	if arg_47_1 == CARD_BLOCK.PLAYER_BOARD then
		var_47_0 = arg_47_0._player._boardCards[arg_47_2]
	elseif arg_47_1 == CARD_BLOCK.OPPONENT_BOARD then
		var_47_0 = arg_47_0._opponent._boardCards[arg_47_2]
	elseif arg_47_1 == CARD_BLOCK.PLAYER_MAGIC_TRAP then
		var_47_0 = arg_47_0._player._showCards[arg_47_2]
	elseif arg_47_1 == CARD_BLOCK.OPPONENT_MAGIC_TRAP then
		var_47_0 = arg_47_0._opponent._showCards[arg_47_2]
	end

	if var_47_0 then
		var_47_0._extraSkillId = tonumber(arg_47_3)
	end
end

function var_0_0.onTouchCanceled(arg_48_0)
	if not arg_48_0._isTouching then
		return
	end

	arg_48_0._isTouching = false

	if arg_48_0._dropLayer then
		return arg_48_0._dropLayer:onTouchCanceled()
	end

	if arg_48_0._touchCard then
		local var_48_0 = arg_48_0._touchCard
		local var_48_1 = var_48_0._card._owner
		local var_48_2 = var_48_0._ownerUi

		var_48_0:onTouchCanceled()

		arg_48_0._touchCard = nil

		if arg_48_0._selectTargetLayer then
			return arg_48_0._selectTargetLayer:onTouchCanceled()
		end

		if var_48_0._touchEvent._touchCardType == CardSprite.TouchCardType.self_hand_card then
			if arg_48_0._isOperating then
				arg_48_0:hidePreview(var_48_0)
				var_48_2:playAction(var_48_0, PlayerUi.Action.replace_hand_card, 0, 1)
			else
				var_48_2:playAction(var_48_0, PlayerUi.Action.replace_hand_card, 0, 1)
			end
		elseif var_48_0._touchEvent._touchCardType == CardSprite.TouchCardType.board_card then
			arg_48_0:hidePreview(var_48_0)
			arg_48_0:removeExchangeArrow()
		end
	end
end
