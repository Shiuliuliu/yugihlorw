local var_0_0 = class("PlayerFindSurvivalEx")

var_0_0.MAX_TROOP_COUNT = 40
var_0_0.MAX_TROOP_COUNT_EX = 15
var_0_0.MAX_BATTLE_COUNT = 12
var_0_0.MAX_LOSE_COUNT = 3
var_0_0.TOTAL_CARD_COUNT = 5
var_0_0.SELECT_CARD_COUNT = 2

local var_0_1 = 1305

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()

	arg_1_0._privilegeStamp = 0

	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._hasTicket = false
	arg_3_0._isInHall = false
	arg_3_0._step = 0
	arg_3_0._characterId = 0
	arg_3_0._cardsPool = {}
	arg_3_0._characters = {}
	arg_3_0._troopCards = {}
	arg_3_0._troopCardsEx = {}
	arg_3_0._selected = {}
	arg_3_0._captures = {}
	arg_3_0._capturesEx = {}
	arg_3_0._skills = {}

	arg_3_0:clearFind()

	arg_3_0._lose = 0
	arg_3_0._win = 0

	arg_3_0:setTrophy(Data._globalInfo._SurvivalExInitTrophy)

	arg_3_0._rollTimes = 0

	print("+++++++++++++++++ Clear Find SurvialEx")
end

function var_0_0.clearFind(arg_4_0)
	arg_4_0._openTimestamp = 0
	arg_4_0._dieTimeStamp = 0
	arg_4_0._hallUserNum = 1
end

function var_0_0.clearBonus(arg_5_0)
	arg_5_0._rewards = nil
	arg_5_0._rank = nil
	arg_5_0._getSeconds = nil
end

function var_0_0.sortFunc(arg_6_0, arg_6_1)
	local var_6_0 = Data.getOriginId(arg_6_0._infoId)
	local var_6_1 = Data.getOriginId(arg_6_1._infoId)

	if var_6_0 < var_6_1 then
		return true
	elseif var_6_1 < var_6_0 then
		return false
	else
		return arg_6_0._infoId < arg_6_1._infoId
	end
end

function var_0_0.init(arg_7_0, arg_7_1)
	arg_7_0:clear()

	arg_7_0._hasTicket = arg_7_1.has_ticket
	arg_7_0._characterId = arg_7_1:HasField("char_id") and arg_7_1.char_id or 0
	arg_7_0._step = arg_7_1.step

	for iter_7_0 = 1, #arg_7_1.pool do
		arg_7_0._cardsPool[iter_7_0] = arg_7_1.pool[iter_7_0]
	end

	for iter_7_1 = 1, #arg_7_1.cards do
		local var_7_0 = arg_7_1.cards[iter_7_1]

		arg_7_0:addToTroop(var_7_0.info_id, var_7_0.num)
	end

	table.sort(arg_7_0._troopCards, var_0_0.sortFunc)
	table.sort(arg_7_0._troopCardsEx, var_0_0.sortFunc)

	for iter_7_2 = 1, #arg_7_1.captures do
		local var_7_1 = arg_7_1.captures[iter_7_2]

		arg_7_0:addToCaptures(var_7_1.info_id, var_7_1.num)
	end

	table.sort(arg_7_0._captures, var_0_0.sortFunc)
	table.sort(arg_7_0._capturesEx, var_0_0.sortFunc)

	for iter_7_3 = 1, #arg_7_1.capture_skills do
		local var_7_2 = arg_7_1.capture_skills[iter_7_3].card
		local var_7_3 = arg_7_1.capture_skills[iter_7_3].skills

		arg_7_0._skills[var_7_2] = {}

		for iter_7_4, iter_7_5 in ipairs(var_7_3) do
			arg_7_0._skills[var_7_2][iter_7_4] = iter_7_5
		end
	end

	arg_7_0._skills[0] = arg_7_0._skills[0] or {}
	arg_7_0._skills[1] = arg_7_0._skills[1] or {}
	arg_7_0._characters = {}

	for iter_7_6 = 1, #arg_7_1.chars do
		arg_7_0._characters[iter_7_6] = arg_7_1.chars[iter_7_6]
	end

	arg_7_0._selected = {}

	for iter_7_7 = 1, #arg_7_1.selected do
		arg_7_0._selected[iter_7_7] = arg_7_1.selected[iter_7_7] + 1
	end

	arg_7_0._privilegeStamp = arg_7_1.privilege_stamp / 1000
	arg_7_0._lose = arg_7_1.lose
	arg_7_0._win = arg_7_1.win

	arg_7_0:setTrophy(arg_7_1.trophy)

	arg_7_0._rollTimes = arg_7_1.roll_times
end

function var_0_0.onMsg(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.type

	if var_8_0 == SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX then
		local var_8_1 = arg_8_1.Extensions[World_pb.SglWorldMsg.world_buy_ticket_resp]

		arg_8_0._characters = {}

		for iter_8_0 = 1, #var_8_1 do
			arg_8_0._characters[iter_8_0] = var_8_1[iter_8_0]
		end
	elseif var_8_0 == SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX then
		local var_8_2 = arg_8_1.Extensions[World_pb.SglWorldMsg.world_select_char_resp]

		arg_8_0._cardsPool = {}

		for iter_8_1 = 1, #var_8_2 do
			arg_8_0._cardsPool[iter_8_1] = var_8_2[iter_8_1]
		end
	elseif var_8_0 == SglMsgType_pb.PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX then
		local var_8_3 = arg_8_1.Extensions[World_pb.SglWorldMsg.world_roll_char_resp]

		arg_8_0._characters = {}

		for iter_8_2 = 1, #var_8_3 do
			arg_8_0._characters[iter_8_2] = var_8_3[iter_8_2]
		end
	elseif var_8_0 == SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_EX_GAME_OVER then
		local var_8_4 = arg_8_1.Extensions[World_pb.SglWorldMsg.world_survival_ex_end_resp]

		arg_8_0._rank = var_8_4.rank

		local var_8_5 = ClientData.getCurrentTime()

		if arg_8_0._rank == 1 then
			arg_8_0._privilegeStamp = math.max(arg_8_0._privilegeStamp, var_8_5) + Data._globalInfo._SurvivalExPrivilegeTime * 3600
		end

		local var_8_6 = {
			_isInHall = arg_8_0._isInHall
		}

		for iter_8_3 = 1, #var_8_4.resource do
			local var_8_7 = var_8_4.resource[iter_8_3]

			var_8_6[#var_8_6 + 1] = {
				_infoId = var_8_7.info_id,
				_count = var_8_7.num
			}
		end

		if #var_8_6 > 0 then
			arg_8_0._rewards = var_8_6

			P:addResourcesData(var_8_6)
		end

		arg_8_0:clear()
		lc.sendEvent(Data.Event.survival_ex_game_over)
	elseif var_8_0 == SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_EX_HALL_INFO then
		local var_8_8 = arg_8_1.Extensions[World_pb.SglWorldMsg.world_survival_ex_hall_info_resp]

		arg_8_0._hallUserNum = var_8_8.num

		if var_8_8:HasField("gameover_timestamp") and arg_8_0._dieTimeStamp == 0 then
			arg_8_0._dieTimeStamp = var_8_8.gameover_timestamp / 1000

			print("+++++++++++++++++PB_TYPE_WORLD_SURVIVAL_EX_HALL_INFO,_dieTimeStamp", arg_8_0._dieTimeStamp)
		end

		if var_8_8:HasField("start_timestamp") then
			arg_8_0._openTimestamp = var_8_8.start_timestamp / 1000
		end

		print("+++++++++++++++++PB_TYPE_WORLD_SURVIVAL_EX_HALL_INFO,self._isInHall,resp.is_in_hall,self._hallUserNum,self:canFindHall()", arg_8_0._dieTimeStamp, arg_8_0._isInHall, var_8_8.is_in_hall, arg_8_0._hallUserNum, arg_8_0:canFindHall())

		if arg_8_0:canFindHall() and arg_8_0._hallUserNum > 1 then
			if not arg_8_0._isInHall and var_8_8.is_in_hall then
				arg_8_0._isInHall = var_8_8.is_in_hall

				lc._runningScene:onEnterSurvivalExHall()
			end

			arg_8_0._isInHall = var_8_8.is_in_hall
		else
			arg_8_0._isInHall = false
		end

		lc.sendEvent(Data.Event.survival_ex_info_dirty)
	elseif var_8_0 == SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_END then
		local var_8_9 = arg_8_1.Extensions[World_pb.SglWorldMsg.world_survival_ex_explore_resp]

		arg_8_0:parseExploreResp(var_8_9)
	end

	return false
end

function var_0_0.canFindHall(arg_9_0)
	return arg_9_0._hasTicket and arg_9_0._characterId ~= 0 and arg_9_0._step > var_0_0.MAX_TROOP_COUNT
end

function var_0_0.parseExploreResp(arg_10_0, arg_10_1)
	arg_10_0._dieTimeStamp, arg_10_0._getSeconds = arg_10_1.gameover_timestamp / 1000, arg_10_1.gain_time

	print("+++++++++++++++++parseExploreResp,_dieTimeStamp", arg_10_0._dieTimeStamp)

	arg_10_0._captures = {}
	arg_10_0._capturesEx = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.captures) do
		arg_10_0:addToCaptures(iter_10_1.info_id, iter_10_1.num)
	end

	table.sort(arg_10_0._captures, var_0_0.sortFunc)

	arg_10_0._skills[0] = arg_10_0._skills[0] or {}
	arg_10_0._skills[1] = arg_10_0._skills[1] or {}

	print("+++++++++++++++++gainSkillCount", #arg_10_1.gain_skills)

	for iter_10_2 = 1, #arg_10_1.gain_skills do
		arg_10_0._skills[0][iter_10_2] = arg_10_1.gain_skills[iter_10_2]

		print("+++++++++++++++++gainSkill", arg_10_1.gain_skills[iter_10_2])
	end

	arg_10_0._lose = arg_10_1.lose
	arg_10_0._win = arg_10_1.win

	arg_10_0:setTrophy(arg_10_1.trophy)
	lc.sendEvent(Data.Event.survival_ex_explore_end)
end

function var_0_0.addCardToTroop(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._selected[#arg_11_0._selected + 1] = arg_11_2 + math.floor((arg_11_0._step - 1) / var_0_0.SELECT_CARD_COUNT) * var_0_0.TOTAL_CARD_COUNT

	local var_11_0 = arg_11_0._troopCards

	for iter_11_0 = 1, #var_11_0 do
		local var_11_1 = var_11_0[iter_11_0]

		if var_11_1._infoId == arg_11_1 then
			var_11_1._num = var_11_1._num + 1

			return
		end
	end

	var_11_0[#var_11_0 + 1] = {
		_num = 1,
		_infoId = arg_11_1
	}
end

function var_0_0.captures2Troop(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:addToCaptures(arg_12_1, -arg_12_2)
	arg_12_0:addToTroop(arg_12_1, arg_12_2)
end

function var_0_0.addToCaptures(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = Data.getType(arg_13_1) == Data.CardType.rare

	arg_13_0:addToCards(arg_13_0:getCaptures(var_13_0), arg_13_1, arg_13_2)
end

function var_0_0.addToTroop(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = Data.getType(arg_14_1) == Data.CardType.rare

	if not var_14_0 and arg_14_2 > 0 then
		local var_14_1 = math.max(math.min(arg_14_0._step - 1, var_0_0.MAX_TROOP_COUNT), 0)
		local var_14_2 = arg_14_0:getTroopCardCount()

		arg_14_2 = math.min(var_14_1 - var_14_2, arg_14_2)
	end

	arg_14_0:addToCards(arg_14_0:getTroopCards(var_14_0), arg_14_1, arg_14_2)
end

function var_0_0.addToCards(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = false

	for iter_15_0 = 1, #arg_15_1 do
		local var_15_1 = arg_15_1[iter_15_0]

		if var_15_1._infoId == arg_15_2 then
			var_15_1._num = var_15_1._num + arg_15_3

			if var_15_1._num <= 0 then
				table.remove(arg_15_1, iter_15_0)
			end

			var_15_0 = true

			break
		end
	end

	if not var_15_0 and arg_15_3 > 0 then
		arg_15_1[#arg_15_1 + 1] = {
			_infoId = arg_15_2,
			_num = arg_15_3
		}
	end
end

function var_0_0.getTroopCardCount(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getTroopCards(arg_16_2)

	if not arg_16_1 then
		local var_16_1 = 0
		local var_16_2 = 0
		local var_16_3 = 0
		local var_16_4 = 0
		local var_16_5 = 0

		for iter_16_0 = 1, #var_16_0 do
			local var_16_6 = var_16_0[iter_16_0]
			local var_16_7 = Data.getType(var_16_6._infoId)

			var_16_1 = var_16_1 + var_16_6._num

			if var_16_7 == Data.CardType.monster then
				var_16_2 = var_16_2 + var_16_6._num
			elseif var_16_7 == Data.CardType.rare then
				var_16_3 = var_16_3 + var_16_6._num
			elseif var_16_7 == Data.CardType.magic then
				var_16_4 = var_16_4 + var_16_6._num
			elseif var_16_7 == Data.CardType.trap then
				var_16_5 = var_16_5 + var_16_6._num
			end
		end

		return var_16_1, var_16_2, var_16_3, var_16_4, var_16_5
	else
		local var_16_8 = 0

		for iter_16_1 = 1, #var_16_0 do
			local var_16_9 = var_16_0[iter_16_1]

			if var_16_9._infoId == arg_16_1 then
				var_16_8 = var_16_8 + var_16_9._num
			end
		end

		return var_16_8
	end
end

function var_0_0.getSelectCards(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = math.floor((arg_17_0._step - 1) / var_0_0.SELECT_CARD_COUNT) * var_0_0.TOTAL_CARD_COUNT

	for iter_17_0 = 1, var_0_0.TOTAL_CARD_COUNT do
		var_17_0[iter_17_0] = {
			_isValid = true,
			_infoId = arg_17_0._cardsPool[var_17_1 + iter_17_0]
		}
	end

	for iter_17_1 = 1, #arg_17_0._selected do
		local var_17_2 = arg_17_0._selected[iter_17_1] - var_17_1

		if var_17_2 > 0 and var_17_2 <= var_0_0.TOTAL_CARD_COUNT then
			var_17_0[var_17_2]._isValid = false
		end
	end

	return var_17_0
end

function var_0_0.getSelectCardIndex(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getSelectCards()

	for iter_18_0 = 1, #var_18_0 do
		local var_18_1 = var_18_0[iter_18_0]

		if var_18_1._infoId == arg_18_1 and var_18_1._isValid then
			return iter_18_0
		end
	end

	return 0
end

function var_0_0.getSurvivalExDuration()
	local var_19_0
	local var_19_1

	for iter_19_0, iter_19_1 in pairs(Data._activityInfo) do
		if iter_19_1._type[1] == 1306 then
			if iter_19_1._beginTime == "" then
				var_19_0 = iter_19_1
			elseif ClientData.isActivityValid(iter_19_1) then
				var_19_1 = iter_19_1
			end
		end
	end

	return (var_19_1 or var_19_0)._param
end

function var_0_0.getIsValidTime(arg_20_0)
	local var_20_0, var_20_1, var_20_2, var_20_3 = ClientData.getServerDate()
	local var_20_4 = arg_20_0:getSurvivalExDuration()
	local var_20_5 = ClientData.getDayOfWeek()

	var_20_5 = var_20_5 == 0 and 7 or var_20_5

	local var_20_6 = var_20_4[3 * (var_20_5 - 1) + 2]
	local var_20_7 = var_20_4[3 * (var_20_5 - 1) + 3]
	local var_20_8 = 0

	if var_20_0 < var_20_6 then
		var_20_8 = 1
	elseif var_20_7 <= var_20_0 then
		var_20_8 = -1
	end

	return var_20_8
end

function var_0_0.getTimeTip(arg_21_0)
	local var_21_0, var_21_1, var_21_2, var_21_3 = ClientData.getServerDate()
	local var_21_4 = ClientData.getCurrentTime() - ClientData.getExpireTimestamp(0)
	local var_21_5 = arg_21_0:getSurvivalExDuration()
	local var_21_6 = ClientData.getDayOfWeek()

	var_21_6 = var_21_6 == 0 and 7 or var_21_6

	local var_21_7 = var_21_5[3 * (var_21_6 - 1) + 2]
	local var_21_8 = var_21_5[3 * (var_21_6 - 1) + 3]
	local var_21_9 = var_21_7 * 3600 - var_21_4

	if var_21_7 == var_21_8 then
		return Str(STR.FIND_SURVIVAL_EX_CLOSED)
	else
		return string.format(Str(STR.FIND_SURVIVAL_EX_TIME), var_21_7, 0, var_21_8, 0)
	end
end

function var_0_0.isTroopValid(arg_22_0)
	if arg_22_0:getTroopCardCount() ~= var_0_0.MAX_TROOP_COUNT then
		return false
	end

	if arg_22_0:getTroopCardCount(nil, true) > var_0_0.MAX_TROOP_COUNT then
		return false
	end

	return true
end

function var_0_0.isPrivilegeValid(arg_23_0)
	return ClientData.getCurrentTime() < arg_23_0._privilegeStamp
end

function var_0_0.getPrivilegeTimeStr(arg_24_0)
	local var_24_0 = ClientData.getCurrentTime()

	if not arg_24_0:isPrivilegeValid() then
		return
	end

	local var_24_1 = arg_24_0._privilegeStamp - var_24_0
	local var_24_2 = math.floor(var_24_1 / 86400)
	local var_24_3 = var_24_1 % 86400
	local var_24_4 = math.floor(var_24_3 / 3600)
	local var_24_5 = math.floor(var_24_3 % 3600 / 60)

	return string.format(Str(STR.PRIVELEGE_EFFECTING_COUNTDOWN), var_24_2, var_24_4, var_24_5)
end

function var_0_0.selectSkill(arg_25_0, arg_25_1)
	table.remove(arg_25_0._skills[0], 1)
	table.remove(arg_25_0._skills[0], 1)
	table.remove(arg_25_0._skills[0], 1)
	table.insert(arg_25_0._skills[1], arg_25_1)
	ClientData.sendSurvivalExExEquipSkill(1, {
		arg_25_1
	})
end

function var_0_0.equipSkill(arg_26_0, arg_26_1, arg_26_2)
	if not table.contain(arg_26_0:getCouldEquipSkills(arg_26_1), arg_26_2) then
		return
	end

	table.removeByValue(arg_26_0._skills[1], arg_26_2)

	arg_26_0._skills[arg_26_1] = arg_26_0._skills[arg_26_1] or {}

	table.insert(arg_26_0._skills[arg_26_1], arg_26_2)
	lc.sendEvent(Data.Event.card_equip_skill_dirty)
	ClientData.sendSurvivalExExEquipSkill(arg_26_1, arg_26_0._skills[arg_26_1])
end

function var_0_0.setTrophy(arg_27_0, arg_27_1)
	arg_27_0._trophy = arg_27_1

	lc.sendEvent(Data.Event.survial_ex_trophy_dirty)
end

function var_0_0.getCouldEquipSkills(arg_28_0, arg_28_1)
	local var_28_0, var_28_1 = Data.getInfo(arg_28_1)

	if var_28_1 ~= Data.CardType.monster and var_28_1 ~= Data.CardType.rare then
		return {}
	end

	local var_28_2 = Data._cardSkillBlackList[arg_28_1]
	local var_28_3 = P._playerFindSurvivalEx._skills

	var_28_3[1] = var_28_3[1] or {}

	local var_28_4 = var_28_3[arg_28_1] or {}
	local var_28_5 = {
		_isFindSurvival = true
	}

	if #var_28_4 == 0 then
		for iter_28_0, iter_28_1 in ipairs(var_28_3[1]) do
			if (not var_28_2 or not table.contain(var_28_2._cardSkill, iter_28_1 % 10000)) and not table.contain(var_28_4, iter_28_1) and not table.contain(var_28_5, iter_28_1) then
				table.insert(var_28_5, iter_28_1)
			end
		end
	end

	return var_28_5
end

function var_0_0.getTroopCards(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_2 then
		local var_29_0 = {}

		for iter_29_0, iter_29_1 in ipairs(arg_29_0._troopCards) do
			var_29_0[#var_29_0 + 1] = iter_29_1
		end

		for iter_29_2, iter_29_3 in ipairs(arg_29_0._troopCardsEx) do
			var_29_0[#var_29_0 + 1] = iter_29_3
		end

		return var_29_0
	else
		return arg_29_1 and arg_29_0._troopCardsEx or arg_29_0._troopCards
	end
end

function var_0_0.getCaptures(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_2 then
		local var_30_0 = {}

		for iter_30_0, iter_30_1 in ipairs(arg_30_0._captures) do
			var_30_0[#var_30_0 + 1] = iter_30_1
		end

		for iter_30_2, iter_30_3 in ipairs(arg_30_0._capturesEx) do
			var_30_0[#var_30_0 + 1] = iter_30_3
		end

		return var_30_0
	else
		return arg_30_1 and arg_30_0._capturesEx or arg_30_0._captures
	end
end

function var_0_0.initExtraTroop(arg_31_0)
	local var_31_0 = arg_31_0._characterId + 16000
	local var_31_1 = Data._troopInfo[var_31_0]

	for iter_31_0, iter_31_1 in ipairs(var_31_1._infoId) do
		local var_31_2 = var_31_1._num[iter_31_0]

		arg_31_0:addToTroop(iter_31_1, var_31_2)
	end
end

function var_0_0.getRemainRollTimes(arg_32_0)
	if ClientData._cfg and ClientData._cfg.testSurvival then
		return 1
	end

	if P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.survival_privilege_2) > 0 then
		return 2 - arg_32_0._rollTimes
	elseif P._playerActivity:getPurchaseRemainDay(Data.PurchaseType.survival_privilege_1) > 0 then
		return 1 - arg_32_0._rollTimes
	else
		return 0
	end
end

function var_0_0.couldRollCharacter(arg_33_0)
	if arg_33_0:getRemainRollTimes() > 0 then
		return true
	end

	return false
end

return var_0_0
