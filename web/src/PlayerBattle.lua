local var_0_0 = class("PlayerBattle")

PlayerBattle = var_0_0
B = PlayerBattle
var_0_0.EVENT = "BATTLE_EVENT"
var_0_0.KEY_TOTAL = "TOTAL"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._isClient = arg_1_1._isClient
	arg_1_0._isAttacker = arg_1_1._isAttacker
	arg_1_0._fortressHp = (arg_1_1._fortressHp and arg_1_1._fortressHp > 0) and arg_1_1._fortressHp or 8000
	arg_1_0._troopCards = arg_1_1._troopCards
	arg_1_0._troopLevels = arg_1_1._troopLevels
	arg_1_0._extraSkills = arg_1_1._extraSkills
	arg_1_0._troopSkins = arg_1_1._troopSkins
	arg_1_0._battleType = arg_1_1._battleType
	arg_1_0._baseBattleType = math.floor(arg_1_0._battleType / 100)
	local isOppNpc = (arg_1_1 and (arg_1_1._isNpc or (arg_1_1._opponent and arg_1_1._opponent._isNpc)))
	local isOffline = (arg_1_1 and (arg_1_1._offlineMode == true or arg_1_1._isOppoOnline == false))
	local hasMatchId = (ClientData._currentMatchId ~= nil and ClientData._currentMatchId ~= "" and not string.find(tostring(ClientData._currentMatchId), "bot_"))
	if isOffline or isOppNpc or not ClientData._isOppoOnline or not hasMatchId then
		arg_1_0._isOnlinePvp = false
	else
		arg_1_0._isOnlinePvp = (arg_1_1 and arg_1_1._isOnlinePvp == true) or false
	end
	arg_1_0._maxRound = arg_1_0._isOnlinePvp and 30 or arg_1_0:getMaxRound(arg_1_1._atkLevel)
	arg_1_0._isNpc = arg_1_1._isNpc
	arg_1_0._reviewType = arg_1_1._reviewType
	arg_1_0._isReviewing = arg_1_0._reviewType ~= 0

	if arg_1_0._battleType == Data.BattleType.PVP_survival or arg_1_0._battleType == Data.BattleType.PVP_survival_ex then
		arg_1_0._survivalTimeStamp = arg_1_1._survivalTimeStamp
	end

	var_0_0._originRandomSeed = arg_1_1._randomSeed
	arg_1_0._bossId = arg_1_1._bossId or 0
	arg_1_0._bossLevel = arg_1_1._bossLevel or 1
	arg_1_0._assistantHp = arg_1_1._assistantHp
	arg_1_0._battleCondition = BattleCondition.new(arg_1_0, arg_1_1._conditions)

	arg_1_0:loadUsedCards(arg_1_1._usedCards)

	arg_1_0._storyRound = arg_1_1._storyRound

	local var_1_0 = arg_1_0._battleType == Data.BattleType.PVP_trophy or arg_1_0._battleType == Data.BattleType.PVP_revenge or arg_1_0._battleType == Data.BattleType.PVP_rescue

	arg_1_0._enhanceLevel = arg_1_0._isAttacker and (var_1_0 and -1 or 0) or var_1_0 and 1 or 0

	if arg_1_0._isClient and arg_1_0._isAttacker and (arg_1_0._battleType == Data.BattleType.unittest or arg_1_0._battleType == Data.BattleType.teach) then
		table.insert(arg_1_1._events, 65101)
	end

	arg_1_0._battleEvent = BattleEvent.new(arg_1_0, arg_1_1._events)

	if arg_1_0._isClient and ClientData._isAutoTesting then
		arg_1_1._fortressSkill = {
			_level = 20,
			_id = 9999
		}
	end

	arg_1_0._fortressSkillInfo = arg_1_1._fortressSkill
	arg_1_0._ai = BattleAi.new(arg_1_0)
	arg_1_0._dragonDebuffVal = 0
	arg_1_0._has40743 = 0

	if #arg_1_0._ops > 0 then
		arg_1_0:battleLog("")
		arg_1_0:battleLog("[BATTLE] <USED CARDS>")

		local var_1_1 = {}

		for iter_1_0 = 1, #arg_1_0._ops do
			local var_1_2 = arg_1_0._ops[iter_1_0]

			table.insert(var_1_1, var_1_2)

			if var_1_2._card < Data.INFO_ID_GROUP_SIZE then
				local var_1_3 = ""

				for iter_1_1 = 1, #var_1_1 do
					local var_1_4 = var_1_1[iter_1_1]

					var_1_3 = var_1_3 .. "(" .. var_1_4._card .. "[" .. (var_1_4._cardInfoId or 0) .. "]," .. var_1_4._target .. "," .. var_1_4._choice .. "," .. var_1_4._timestamp .. ") "
				end

				arg_1_0:battleLog("[BATTLE] %s", var_1_3)

				var_1_1 = {}
			end
		end
	end

	arg_1_0._idInRoom = arg_1_1._idInRoom
	arg_1_0._isNewRound = arg_1_0._isOnlinePvp and arg_1_1._isNewRound and arg_1_0._battleType ~= Data.BattleType.PVP_clash_ex and arg_1_0._battleType ~= Data.BattleType.PVP_survival and arg_1_0._battleType ~= Data.BattleType.PVP_survival_ex

	if arg_1_0._isNewRound then
		arg_1_0._roundTimeInit = arg_1_1._roundTimeInit
		arg_1_0._roundTimeMax = arg_1_1._roundTimeMax
		arg_1_0._roundTimeDelta = arg_1_1._roundTimeDelta
		arg_1_0._roundTimeInit1 = arg_1_1._roundTimeInit + 5
		arg_1_0._roundTimeMax1 = arg_1_1._roundTimeMax + 5
		arg_1_0._roundTimeDelta1 = arg_1_1._roundTimeDelta
		arg_1_0._monthCardType = arg_1_1._monthCardType

		if arg_1_0._isClient and arg_1_0._monthCardType then
			if band(arg_1_0._monthCardType, BattleData.RoundFlag.month_card1) > 0 then
				arg_1_0._roundTimeInit1 = arg_1_0._roundTimeInit1 + 5
				arg_1_0._roundTimeMax1 = arg_1_0._roundTimeMax1 + 5
				arg_1_0._roundTimeDelta1 = arg_1_0._roundTimeDelta1 + 1
			end

			if band(arg_1_0._monthCardType, BattleData.RoundFlag.month_card2) > 0 then
				arg_1_0._roundTimeInit1 = arg_1_0._roundTimeInit1 + 5
				arg_1_0._roundTimeMax1 = arg_1_0._roundTimeMax1 + 5
				arg_1_0._roundTimeDelta1 = arg_1_0._roundTimeDelta1 + 1
			end

			if band(arg_1_0._monthCardType, BattleData.RoundFlag.month_card3) > 0 then
				arg_1_0._roundTimeInit1 = arg_1_0._roundTimeInit1 + 10
				arg_1_0._roundTimeMax1 = arg_1_0._roundTimeMax1 + 10
				arg_1_0._roundTimeDelta1 = arg_1_0._roundTimeDelta1 + 0
			end

			if band(arg_1_0._monthCardType, BattleData.RoundFlag.achieve) > 0 then
				arg_1_0._roundTimeInit1 = arg_1_0._roundTimeInit1 + 10
				arg_1_0._roundTimeMax1 = arg_1_0._roundTimeMax1 + 10
				arg_1_0._roundTimeDelta1 = arg_1_0._roundTimeDelta1 + 0
			end

			if band(arg_1_0._monthCardType, BattleData.RoundFlag.month_card4) > 0 then
				arg_1_0._roundTimeInit1 = arg_1_0._roundTimeInit1 + 10
				arg_1_0._roundTimeMax1 = arg_1_0._roundTimeMax1 + 10
				arg_1_0._roundTimeDelta1 = arg_1_0._roundTimeDelta1 + 0
			end

			if band(arg_1_0._monthCardType, BattleData.RoundFlag.month_card5) > 0 then
				arg_1_0._roundTimeInit1 = arg_1_0._roundTimeInit1 + 10
				arg_1_0._roundTimeMax1 = arg_1_0._roundTimeMax1 + 10
				arg_1_0._roundTimeDelta1 = arg_1_0._roundTimeDelta1 + 0
			end

			if band(arg_1_0._monthCardType, BattleData.RoundFlag.month_card6) > 0 then
				arg_1_0._roundTimeInit1 = arg_1_0._roundTimeInit1 + 10
				arg_1_0._roundTimeMax1 = arg_1_0._roundTimeMax1 + 10
				arg_1_0._roundTimeDelta1 = arg_1_0._roundTimeDelta1 + 0
			end
		end
	end
end

function var_0_0.skillCasted(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:battleLog("[BATTLE] %s\t%s", Str(arg_2_1._type ~= Data.CardType.fortress and arg_2_1._info._nameSid or STR.FORTRESS), Str(Data._skillInfo[arg_2_2._id]._nameSid))

	arg_2_0:getActionCard()._needAccount = true

	if arg_2_3 ~= Data.SkillMode.halo then
		table.insert(arg_2_1._castedSkills, arg_2_2)

		if (arg_2_2._id ~= 5064 and arg_2_2._id ~= 5069 and arg_2_2._id ~= 5118 and arg_2_2._id ~= 5259 and arg_2_2._id ~= 5306 and arg_2_2._id ~= 5309 and arg_2_2._id ~= 5471 and arg_2_2._id ~= 8018 and arg_2_2._id ~= 8019 and arg_2_2._id ~= 8020 and arg_2_2._id ~= 8021 and arg_2_2._id ~= 8042 and arg_2_2._id ~= 8046 and arg_2_2._id ~= 8054 and arg_2_2._id ~= 8056 and arg_2_2._id ~= 8059 and arg_2_2._id ~= 8068 and arg_2_2._id ~= 8081 and arg_2_2._id ~= 8083 and arg_2_2._id ~= 8094 and arg_2_2._id ~= 8095 and arg_2_2._id ~= 8102 and arg_2_2._id ~= 8116 and arg_2_2._id ~= 8117 and arg_2_2._id ~= 8124 and arg_2_2._id ~= 8125 and arg_2_2._id ~= 8126 and arg_2_2._id ~= 8130 and arg_2_2._id ~= 8132 or arg_2_3 ~= Data.SkillMode.using) and (arg_2_2._id ~= 3447 and arg_2_2._id ~= 3491 and arg_2_2._id ~= 6420 and arg_2_2._id ~= 6572 and arg_2_2._id ~= 6619 and arg_2_2._id ~= 6745 and arg_2_2._id ~= 2292 and arg_2_2._id ~= 2484 and arg_2_2._id ~= 2517 and arg_2_2._id ~= 2704 or arg_2_3 ~= Data.SkillMode.after_attack) and (arg_2_2._id ~= 7161 and arg_2_2._id ~= 7194 and arg_2_2._id ~= 7219 and arg_2_2._id ~= 7267 and arg_2_2._id ~= 7341 and arg_2_2._id ~= 7417 and arg_2_2._id ~= 7423 or arg_2_3 ~= Data.SkillMode.magic) and (arg_2_2._id ~= 4191 and arg_2_2._id ~= 4532 and arg_2_2._id ~= 4873 and arg_2_2._id ~= 4889 and arg_2_2._id ~= 4990 and arg_2_2._id ~= 7360 and arg_2_2._id ~= 7364 and arg_2_2._id ~= 7411 and arg_2_2._id ~= 7438 and arg_2_2._id ~= 7442 and arg_2_2._id ~= 7465 and arg_2_2._id ~= 7507 and arg_2_2._id ~= 7512 and arg_2_2._id ~= 7612 and arg_2_2._id ~= 7613 and arg_2_2._id ~= 7660 and arg_2_2._id ~= 7661 and arg_2_2._id ~= 7670 and arg_2_2._id ~= 7756 and arg_2_2._id ~= 7757 and arg_2_2._id ~= 7778 and arg_2_2._id ~= 5198 and arg_2_2._id ~= 5260 and arg_2_2._id ~= 5574 and arg_2_2._id ~= 8119 and arg_2_2._id ~= 6896 and arg_2_2._id ~= 2194 and arg_2_2._id ~= 2527 and arg_2_2._id ~= 2541 and arg_2_2._id ~= 2582 and arg_2_2._id ~= 2583 and arg_2_2._id ~= 2584 and arg_2_2._id ~= 2791 and arg_2_2._id ~= 2990 and arg_2_2._id ~= 2991 and arg_2_2._id ~= 2994 and arg_2_2._id ~= 9008 and arg_2_2._id ~= 9039 and arg_2_2._id ~= 9070 and arg_2_2._id ~= 9076 and arg_2_2._id ~= 9098 and arg_2_2._id ~= 9197 and arg_2_2._id ~= 9202 and arg_2_2._id ~= 9203 and arg_2_2._id ~= 9267 and arg_2_2._id ~= 9349 and arg_2_2._id ~= 9516 and arg_2_2._id ~= 9594 and arg_2_2._id ~= 9647 and arg_2_2._id ~= 9787 and arg_2_2._id ~= 9794 and arg_2_2._id ~= 9873 and arg_2_2._id ~= 9967 and arg_2_2._id ~= 13159 and arg_2_2._id ~= 13246 and arg_2_2._id ~= 13369 and arg_2_2._id ~= 13438 and arg_2_2._id ~= 13442 and arg_2_2._id ~= 13617 and arg_2_2._id ~= 13783 and arg_2_2._id ~= 14147 and arg_2_2._id ~= 14199 and arg_2_2._id ~= 14579 or arg_2_3 == Data.SkillMode.initiative_bcs) and (arg_2_2._id ~= 9061 and arg_2_2._id ~= 9376 and arg_2_2._id ~= 9833 and arg_2_2._id ~= 13363 and arg_2_2._id ~= 13537 or arg_2_3 == Data.SkillMode.initiative_hand) and (arg_2_2._id ~= 9249 or arg_2_3 == Data.SkillMode.initiative_hand or arg_2_3 == Data.SkillMode.initiative_grave) and (arg_2_2._id ~= 6720 and arg_2_2._id ~= 2190 and arg_2_2._id ~= 13956 and arg_2_2._id ~= 14525 and arg_2_2._id ~= 14527 and arg_2_2._id ~= 14531 or arg_2_3 == Data.SkillMode.initiative_grave) and (arg_2_2._id ~= 5455 or arg_2_3 == Data.SkillMode.initiative_leave) and (arg_2_2._id ~= 6901 or arg_2_3 == Data.SkillMode.round_end or arg_2_3 == Data.SkillMode.oppo_round_end) and (arg_2_2._id ~= 7280 or arg_2_3 == Data.SkillMode.initiative_bcs or arg_2_2._owner._owner._stepStatus == BattleData.Status.wait_opponent) and (arg_2_2._id ~= 2467 or arg_2_3 == Data.SkillMode.bcs2gl or arg_2_3 == Data.SkillMode.bcs2_) then
			arg_2_0._castedSkillCounts[arg_2_2._id] = (arg_2_0._castedSkillCounts[arg_2_2._id] or 0) + 1

			if arg_2_2._id == 3252 or arg_2_2._id == 6876 or arg_2_2._id == 3333 or arg_2_2._id == 4344 or arg_2_2._id == 4488 or arg_2_2._id == 4489 or arg_2_2._id == 6347 or arg_2_2._id == 6267 or arg_2_2._id == 6270 or arg_2_2._id == 6370 or arg_2_2._id == 6371 or arg_2_2._id == 6401 or arg_2_2._id == 6406 or arg_2_2._id == 6518 or arg_2_2._id == 6519 or arg_2_2._id == 6809 or arg_2_2._id == 6983 or arg_2_2._id == 6984 or arg_2_2._id == 7244 or arg_2_2._id == 7245 or arg_2_2._id == 3626 or arg_2_2._id == 13006 or arg_2_2._id == 3752 or arg_2_2._id == 9998 or arg_2_2._id == 3754 or arg_2_2._id == 13001 or arg_2_2._id == 6889 or arg_2_2._id == 6890 or arg_2_2._id >= 6955 and arg_2_2._id <= 6961 or arg_2_2._id >= 6966 and arg_2_2._id <= 6972 or arg_2_2._id == 2126 or arg_2_2._id == 2127 or arg_2_2._id == 2130 or arg_2_2._id == 2131 or arg_2_2._id == 2173 or arg_2_2._id == 2174 or arg_2_2._id == 2177 or arg_2_2._id == 2179 or arg_2_2._id == 2181 or arg_2_2._id == 2183 or arg_2_2._id == 4537 or arg_2_2._id == 4538 or arg_2_2._id == 4539 or arg_2_2._id == 4540 or arg_2_2._id == 2175 or arg_2_2._id == 2176 or arg_2_2._id == 2242 or arg_2_2._id == 2249 or arg_2_2._id == 2272 or arg_2_2._id == 2273 or arg_2_2._id == 2274 or arg_2_2._id == 2275 or arg_2_2._id == 2288 or arg_2_2._id == 2289 or arg_2_2._id == 2328 or arg_2_2._id == 2329 or arg_2_2._id == 2355 or arg_2_2._id == 2356 or arg_2_2._id == 2562 or arg_2_2._id == 2563 or arg_2_2._id == 2568 or arg_2_2._id == 2573 or arg_2_2._id == 2666 or arg_2_2._id == 2667 or arg_2_2._id == 2839 or arg_2_2._id == 4717 or arg_2_2._id == 2840 or arg_2_2._id == 4718 or arg_2_2._id == 2886 or arg_2_2._id == 9314 or arg_2_2._id == 2933 or arg_2_2._id == 2934 or arg_2_2._id == 2968 or arg_2_2._id == 2969 or arg_2_2._id == 2970 or arg_2_2._id == 4751 or arg_2_2._id == 2977 or arg_2_2._id == 2978 or arg_2_2._id == 3655 or arg_2_2._id == 9123 or arg_2_2._id == 4044 or arg_2_2._id == 4730 or arg_2_2._id == 4100 or arg_2_2._id == 4111 or arg_2_2._id == 4465 or arg_2_2._id == 4798 or arg_2_2._id == 4466 or arg_2_2._id == 4799 or arg_2_2._id == 4467 or arg_2_2._id == 4800 or arg_2_2._id == 4591 or arg_2_2._id == 4592 or arg_2_2._id == 4772 or arg_2_2._id == 4773 or arg_2_2._id == 4808 or arg_2_2._id == 4809 or arg_2_2._id == 4842 or arg_2_2._id == 7417 or arg_2_2._id == 4847 or arg_2_2._id == 7423 or arg_2_2._id == 4859 or arg_2_2._id == 7429 or arg_2_2._id == 4963 or arg_2_2._id == 4964 or arg_2_2._id == 4993 or arg_2_2._id == 5566 or arg_2_2._id == 4998 or arg_2_2._id == 13192 or arg_2_2._id == 5326 or arg_2_2._id == 5327 or arg_2_2._id == 5328 or arg_2_2._id == 5329 or arg_2_2._id == 5335 or arg_2_2._id == 5336 or arg_2_2._id == 5372 or arg_2_2._id == 5373 or arg_2_2._id == 5408 or arg_2_2._id == 5409 or arg_2_2._id == 5418 or arg_2_2._id == 5419 or arg_2_2._id == 5430 or arg_2_2._id == 5431 or arg_2_2._id == 5476 or arg_2_2._id == 5477 or arg_2_2._id == 5538 or arg_2_2._id == 5539 or arg_2_2._id == 5558 or arg_2_2._id == 5559 or arg_2_2._id == 5593 or arg_2_2._id == 5594 or arg_2_2._id == 5623 or arg_2_2._id == 7684 or arg_2_2._id == 5624 or arg_2_2._id == 5324 or arg_2_2._id == 5631 or arg_2_2._id == 5632 or arg_2_2._id == 5637 or arg_2_2._id == 5638 or arg_2_2._id == 5650 or arg_2_2._id == 5651 or arg_2_2._id == 7266 or arg_2_2._id == 7396 or arg_2_2._id == 7369 or arg_2_2._id == 7370 or arg_2_2._id == 7555 or arg_2_2._id == 7556 or arg_2_2._id == 7594 or arg_2_2._id == 7619 or arg_2_2._id == 7606 or arg_2_2._id == 7607 or arg_2_2._id == 7633 or arg_2_2._id == 7634 or arg_2_2._id == 7653 or arg_2_2._id == 7654 or arg_2_2._id == 7660 or arg_2_2._id == 7661 or arg_2_2._id == 7673 or arg_2_2._id == 7674 or arg_2_2._id == 7700 or arg_2_2._id == 7701 or arg_2_2._id == 7705 or arg_2_2._id == 7706 or arg_2_2._id == 7731 or arg_2_2._id == 7732 or arg_2_2._id == 7756 or arg_2_2._id == 7757 or arg_2_2._id == 7830 or arg_2_2._id == 7831 or arg_2_2._id == 8036 or arg_2_2._id == 8066 or arg_2_2._id == 8081 or arg_2_2._id == 8082 or arg_2_2._id == 8094 or arg_2_2._id == 8145 or arg_2_2._id == 9082 or arg_2_2._id == 9083 or arg_2_2._id == 9133 or arg_2_2._id == 9134 or arg_2_2._id == 9287 or arg_2_2._id == 9288 or arg_2_2._id == 9296 or arg_2_2._id == 9297 or arg_2_2._id == 9305 or arg_2_2._id == 9306 or arg_2_2._id == 9469 or arg_2_2._id == 9523 or arg_2_2._id == 9632 or arg_2_2._id == 9633 or arg_2_2._id == 9692 or arg_2_2._id == 9984 or arg_2_2._id == 9721 or arg_2_2._id == 9722 or arg_2_2._id == 9765 or arg_2_2._id == 4888 or arg_2_2._id == 9830 or arg_2_2._id == 9831 or arg_2_2._id == 13061 or arg_2_2._id == 13062 or arg_2_2._id == 13085 or arg_2_2._id == 13086 or arg_2_2._id == 13088 or arg_2_2._id == 13089 or arg_2_2._id == 13091 or arg_2_2._id == 13092 or arg_2_2._id == 13093 or arg_2_2._id == 13094 or arg_2_2._id == 13095 or arg_2_2._id == 13096 or arg_2_2._id == 13098 or arg_2_2._id == 13099 or arg_2_2._id == 13100 or arg_2_2._id == 13101 or arg_2_2._id == 13102 or arg_2_2._id == 13103 or arg_2_2._id == 13160 or arg_2_2._id == 13521 or arg_2_2._id == 13169 or arg_2_2._id == 13170 or arg_2_2._id == 13179 or arg_2_2._id == 13180 or arg_2_2._id == 13220 or arg_2_2._id == 13221 or arg_2_2._id == 13250 or arg_2_2._id == 13251 or arg_2_2._id == 13272 or arg_2_2._id == 13273 or arg_2_2._id == 13275 or arg_2_2._id == 13276 or arg_2_2._id == 13278 or arg_2_2._id == 13279 or arg_2_2._id == 13377 or arg_2_2._id == 13378 or arg_2_2._id == 13416 or arg_2_2._id == 13417 or arg_2_2._id == 13418 or arg_2_2._id == 13419 or arg_2_2._id == 13420 or arg_2_2._id == 13513 or arg_2_2._id == 13425 or arg_2_2._id == 13426 or arg_2_2._id == 13485 or arg_2_2._id == 13486 or arg_2_2._id == 13552 or arg_2_2._id == 13553 or arg_2_2._id == 13627 or arg_2_2._id == 13628 or arg_2_2._id == 13666 or arg_2_2._id == 14044 or arg_2_2._id == 13806 or arg_2_2._id == 13807 or arg_2_2._id == 13949 or arg_2_2._id == 13950 or arg_2_2._id == 14029 or arg_2_2._id == 14030 or arg_2_2._id == 14089 or arg_2_2._id == 14090 or arg_2_2._id == 14099 or arg_2_2._id == 14100 or arg_2_2._id == 14196 or arg_2_2._id == 14197 or arg_2_2._id == 14290 or arg_2_2._id == 14291 or arg_2_2._id == 14340 or arg_2_2._id == 14341 or arg_2_2._id == 14347 or arg_2_2._id == 14348 or arg_2_2._id == 14362 or arg_2_2._id == 14363 or arg_2_2._id == 14573 or arg_2_2._id == 14574 or arg_2_2._id == 14684 or arg_2_2._id == 14685 or arg_2_2._id == 14733 or arg_2_2._id == 14734 then
				local var_2_0 = Data._skillInfo[arg_2_2._id]._refSkills[1]

				arg_2_0._castedSkillCounts[var_2_0] = (arg_2_0._castedSkillCounts[var_2_0] or 0) + 1
			end

			if arg_2_2._id == 7192 or arg_2_2._id == 7198 or arg_2_2._id == 7309 or arg_2_2._id == 7310 or arg_2_2._id == 7735 or arg_2_2._id == 7736 or arg_2_2._id == 4562 or arg_2_2._id == 4563 or arg_2_2._id == 5571 or arg_2_2._id == 5572 or arg_2_2._id == 2404 or arg_2_2._id == 2405 or arg_2_2._id == 9087 or arg_2_2._id == 9115 or arg_2_2._id == 9088 or arg_2_2._id == 9116 or arg_2_2._id == 9614 or arg_2_2._id == 9615 or arg_2_2._id == 13661 or arg_2_2._id == 13662 or arg_2_2._id == 14097 or arg_2_2._id == 14098 then
				local var_2_1 = Data._skillInfo[arg_2_2._id]._refSkills[2]

				arg_2_0._castedSkillCounts[var_2_1] = (arg_2_0._castedSkillCounts[var_2_1] or 0) + 1
			end

			if arg_2_2._id == 6831 or arg_2_2._id == 6832 then
				local var_2_2 = Data._skillInfo[arg_2_2._id]._refSkills[3]

				arg_2_0._castedSkillCounts[var_2_2] = (arg_2_0._castedSkillCounts[var_2_2] or 0) + 1
			end

			if arg_2_2._id == 6929 or arg_2_2._id == 6930 or arg_2_2._id == 6931 or arg_2_2._id == 6988 or arg_2_2._id == 6989 or arg_2_2._id == 6990 or arg_2_2._id == 2582 or arg_2_2._id == 2583 or arg_2_2._id == 2584 or arg_2_2._id == 2800 or arg_2_2._id == 2801 or arg_2_2._id == 2802 or arg_2_2._id == 2809 or arg_2_2._id == 9045 or arg_2_2._id == 9046 or arg_2_2._id == 2935 or arg_2_2._id == 2936 or arg_2_2._id == 2937 or arg_2_2._id == 9038 or arg_2_2._id == 9039 or arg_2_2._id == 9040 or arg_2_2._id == 7336 or arg_2_2._id == 7337 or arg_2_2._id == 7338 or arg_2_2._id == 8068 or arg_2_2._id == 8069 or arg_2_2._id == 8070 or arg_2_2._id == 13155 or arg_2_2._id == 13156 or arg_2_2._id == 13157 or arg_2_2._id == 13813 or arg_2_2._id == 13814 or arg_2_2._id == 13815 then
				for iter_2_0 = 1, 2 do
					local var_2_3 = Data._skillInfo[arg_2_2._id]._refSkills[iter_2_0]

					arg_2_0._castedSkillCounts[var_2_3] = (arg_2_0._castedSkillCounts[var_2_3] or 0) + 1
				end
			end

			if arg_2_2._id == 9638 or arg_2_2._id == 9639 or arg_2_2._id == 9640 or arg_2_2._id == 9641 then
				for iter_2_1 = 1, 3 do
					local var_2_4 = Data._skillInfo[arg_2_2._id]._refSkills[iter_2_1]

					arg_2_0._castedSkillCounts[var_2_4] = (arg_2_0._castedSkillCounts[var_2_4] or 0) + 1
				end
			end
		end
	end

	if arg_2_3 ~= Data.SkillMode.halo and arg_2_2._id ~= 3354 then
		arg_2_1._owner._skillCasted = true

		if arg_2_2._id == 5201 or arg_2_2._id == 5221 then
			arg_2_1._castedTargets[arg_2_1._trapTarget._id] = true
		end
	end

	if arg_2_2._owner:hasSkills({
		6635
	}) and arg_2_3 ~= Data.SkillMode.halo and arg_2_2._owner._status == BattleData.CardStatus.board then
		arg_2_2._owner:addDeedMark(1, arg_2_2._owner, arg_2_2._owner._id, arg_2_2._id, Data.SkillMode.once)
	end
end

function var_0_0.getUnderSkillCards(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getAllCards()
	local var_3_1 = {}

	for iter_3_0 = 1, #var_3_0 do
		local var_3_2 = var_3_0[iter_3_0]

		for iter_3_1 = 1, #var_3_2._underSkills do
			local var_3_3 = var_3_2._underSkills[iter_3_1]

			if var_3_3._cid == arg_3_1 and var_3_3._sid == arg_3_2 and not var_3_3._positiveType and not var_3_3._negativeType then
				table.insert(var_3_1, var_3_2)

				break
			end
		end
	end

	return var_3_1
end

function var_0_0.getUnderAttackCard(arg_4_0)
	local var_4_0 = arg_4_0:getActionCard()

	return var_4_0._atkTargets and var_4_0._atkTargets[1]
end

function var_0_0.getUnderChangedCards(arg_5_0)
	local var_5_0 = arg_5_0:getAllCards()
	local var_5_1 = {}

	for iter_5_0 = 1, #var_5_0 do
		local var_5_2 = var_5_0[iter_5_0]

		if next(var_5_2._changed) ~= nil then
			table.insert(var_5_1, var_5_2)
		end
	end

	return var_5_1
end

function var_0_0.dealCard(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = false
	local var_6_1 = #arg_6_0._handCards

	for iter_6_0 = 1, arg_6_1 do
		if var_6_1 >= Data.MAX_CARD_COUNT_IN_HAND or arg_6_0._pileCards[iter_6_0] == nil then
			break
		end

		local var_6_2 = arg_6_0._pileCards[iter_6_0]

		arg_6_0:setCardStatus(var_6_2, BattleData.CardStatus.hand, arg_6_2, arg_6_3, arg_6_4)

		var_6_1 = var_6_1 + 1
		var_6_0 = true
	end

	return var_6_0
end

function var_0_0.setCardStatus(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	if arg_7_1 == nil then
		return
	end

	-- Xuyên qua tường chắn quái cho KMR-Zio-Ghost (14769 & 14770) va Kiem si diet rong tap su (14784)
	if arg_7_4 == 14769 or arg_7_4 == 14770 or arg_7_4 == 14784 then
		table.insert(arg_7_1._underSkills, {
			_cid = arg_7_3,
			_sid = arg_7_4,
			_mode = arg_7_5,
			_status = arg_7_2,
			_statusVal = arg_7_6,
			_futureSourceStatus = arg_7_7
		})
		return
	end

	-- Totem (30596 / 14801): 1 luot 1 lan, khi quai Minecraft tren san phe ta bi pha huy, bo qua 1 lan pha huy
	if (arg_7_1:isKeyword(304) or (arg_7_1._info and arg_7_1._info._keyword == 304)) and arg_7_1._status == BattleData.CardStatus.board and (arg_7_2 == BattleData.CardStatus.grave or arg_7_2 == BattleData.CardStatus.leave) then
		local isCostOrSac = (arg_7_6 == BattleData.CardStatusVal.sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_sync_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_link_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_summon_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.x2gl_cost
			or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost
			or arg_7_6 == BattleData.CardStatusVal.h2l_temp
			or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo)
		if not isCostOrSac then
			local owner = arg_7_1._owner
			if owner then
				local turnId = (owner._round or 0) * 1000 + (owner._opponent and owner._opponent._round or 0)
				local coverTotems = owner:getBattleCardsByInfoId("C", 30596)
				local showTotems = owner:getBattleCardsByInfoId("S", 30596)
				local totemCard = (#showTotems > 0 and showTotems[1]) or (#coverTotems > 0 and coverTotems[1])
				if totemCard and owner._totemBoardProtectTurn ~= turnId then
					owner._totemBoardProtectTurn = turnId
					if totemCard._status == BattleData.CardStatus.cover then
						owner:setCardStatus(totemCard, BattleData.CardStatus.show, totemCard._id, 14801, Data.SkillMode.using, BattleData.CardStatusVal.c2s_attack)
					end
					if arg_7_1._hp and arg_7_1._hp <= 0 then
						arg_7_1._hp = 1
					end
					return
				end
			end
		end
	end

	-- Ender Dragon (12339 / 14799): Khi bi pha huy, phe ta tang LP bang tong ATK quai doi phuong tren san
	if (arg_7_1:isInfoId(12339) or arg_7_1._infoId == 12339 or arg_7_1:hasSkillFast(14799)) and arg_7_1._status == BattleData.CardStatus.board and (arg_7_2 == BattleData.CardStatus.grave or arg_7_2 == BattleData.CardStatus.leave) then
		local isCostOrSac = (arg_7_6 == BattleData.CardStatusVal.sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_sync_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_link_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.b2g_summon_sacrifice
			or arg_7_6 == BattleData.CardStatusVal.x2gl_cost
			or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost
			or arg_7_6 == BattleData.CardStatusVal.h2l_temp
			or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo)
		if not isCostOrSac then
			local owner = arg_7_1._owner
			local oppo = owner and owner._opponent
			if oppo and owner and owner._fortress then
				local totalAtk = 0
				for _, oppoMon in ipairs(oppo:getBoardCards()) do
					if oppoMon:isMonster() or oppoMon:isMonsterRare() or oppoMon._type == Data.CardType.monster then
						totalAtk = totalAtk + math.max(0, oppoMon._atk or 0)
					end
				end
				if totalAtk > 0 then
					owner:incHp(owner._fortress, totalAtk, false, arg_7_1._id, 14799, Data.SkillMode.using)
				end
			end
		end
	end

		-- Overload ("quá tải") check: khi rời sân bị loại bỏ
	if arg_7_1._overload and (arg_7_1._status == BattleData.CardStatus.board or arg_7_1._status == BattleData.CardStatus.show) and arg_7_2 ~= BattleData.CardStatus.board and arg_7_2 ~= BattleData.CardStatus.show then
		arg_7_2 = BattleData.CardStatus.leave
		arg_7_1._overload = nil
	end

-- Card 40748 (Wither) handled in BattleCardStatus
	-- Card 40535 (Rồng phá giới - Rồng phá hoại) leaves board: decShield from allied Kiếm sĩ diệt rồng
	if (arg_7_1:isInfoId(40535) or arg_7_1._infoId == 40535) and (arg_7_1._status == BattleData.CardStatus.board or arg_7_1._status == BattleData.CardStatus.show) and arg_7_2 ~= BattleData.CardStatus.board and arg_7_2 ~= BattleData.CardStatus.show then
		local owner = arg_7_1._owner
		if owner then
			owner._has40535OnBoard = false
			local allies = owner:getBoardCards()
			for _, c in ipairs(allies) do
				if c ~= arg_7_1 and (c:isKeyword(21) or c:isKeyword(204) or (c._info and (c._info._keyword == 21 or c._info._keyword == 204))) then
					c._positiveStatus[BattleData.PositiveType.shieldOppoMonster] = false
					c._positiveStatus[BattleData.PositiveType.shieldOppoMagic] = false
					c._positiveStatus[BattleData.PositiveType.shieldOppoTrap] = false
					owner:decShield(c, { 12008, 12009, 12010 }, false, c._id, 12008)
				end
			end
		end
	end
	if (arg_7_1._type == Data.CardType.magic or arg_7_1._type == Data.CardType.trap) and arg_7_1._status == BattleData.CardStatus.board and arg_7_2 == BattleData.CardStatus.grave and (arg_7_6 == BattleData.CardStatusVal.b2g_destroy or arg_7_6 == BattleData.CardStatusVal.b2g_cost) then
		if arg_7_1._owner and (arg_7_1._owner:hasBattleCardsBySkillFast("B", 7488) or #arg_7_1._owner:getBattleCardsByInfoId("B", 40737) > 0) then
			if arg_7_4 ~= 0 and arg_7_4 ~= nil and arg_7_1._owner ~= arg_7_0 then
				return
			end
		end
	end
	if (arg_7_1:hasSkillFast(14660) or arg_7_1:isInfoId(12318) or arg_7_1:hasSkillFast(14680) or arg_7_1:isInfoId(40727)) and arg_7_1:canCastMonsterSkill() and arg_7_1._status == BattleData.CardStatus.board and arg_7_2 == BattleData.CardStatus.grave and (arg_7_6 == BattleData.CardStatusVal.b2g_kill_by_attack or arg_7_4 == Data.ATTACKING_SKILL_ID) then
		return
	end

	if (arg_7_1:hasSkillFast(14629) or arg_7_1:isInfoId(12313)) and arg_7_1:canCastMonsterSkill() and arg_7_1._status == BattleData.CardStatus.board and arg_7_2 == BattleData.CardStatus.grave and arg_7_6 ~= BattleData.CardStatusVal.b2g_kill_by_attack and arg_7_4 ~= Data.ATTACKING_SKILL_ID and arg_7_6 ~= BattleData.CardStatusVal.sacrifice and arg_7_6 ~= BattleData.CardStatusVal.x2gl_cost then
		return
	end

	if (arg_7_1:hasSkillFast(14635) or arg_7_1:hasSkillFast(14680) or arg_7_1:isInfoId(12314) or arg_7_1:isInfoId(40727)) and arg_7_1:canCastMonsterSkill() and arg_7_1._status == BattleData.CardStatus.board and (arg_7_2 == BattleData.CardStatus.grave or arg_7_2 == BattleData.CardStatus.leave) then
		local isCostOrSac = (arg_7_6 == BattleData.CardStatusVal.sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_sync_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_link_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_summon_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.x2gl_cost 
			or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost 
			or arg_7_6 == BattleData.CardStatusVal.h2l_temp 
			or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo)
		if not isCostOrSac then
			local owner = arg_7_1._owner
			local oppo = owner and owner._opponent
			local turnId = (owner and owner._round or 0) * 1000 + (oppo and oppo._round or 0)
			if arg_7_1._kcBHTurn ~= turnId then
				arg_7_1._kcBHTurn = turnId
				return
			end
		end
	end

	if (arg_7_1:hasSkillFast(14690) or arg_7_1:isInfoId(12321)) and arg_7_1:canCastMonsterSkill() and arg_7_1._status == BattleData.CardStatus.board and (arg_7_2 == BattleData.CardStatus.grave or arg_7_2 == BattleData.CardStatus.leave) then
		local isCostOrSac = (arg_7_6 == BattleData.CardStatusVal.sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_sync_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_link_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_summon_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.x2gl_cost 
			or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost 
			or arg_7_6 == BattleData.CardStatusVal.h2l_temp 
			or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo)
		if not isCostOrSac then
			local owner = arg_7_1._owner
			local var_hhg_grave = owner and owner:getBattleCardsByInfoId("G", 30592)
			if var_hhg_grave and #var_hhg_grave > 0 then
				local hhg = var_hhg_grave[1]
				owner:setCardStatus(hhg, BattleData.CardStatus.leave, 0, 14690, Data.SkillMode.g2l)
				return
			end
		end
	end

	if (arg_7_1:isInfoId(40728) or arg_7_1:hasSkillFast(14692)) and arg_7_1:canCastMonsterSkill() and arg_7_1._status == BattleData.CardStatus.board and (arg_7_2 == BattleData.CardStatus.grave or arg_7_2 == BattleData.CardStatus.leave) then
		local isCostOrSac = (arg_7_6 == BattleData.CardStatusVal.sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_sync_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_link_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_summon_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.x2gl_cost 
			or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost 
			or arg_7_6 == BattleData.CardStatusVal.h2l_temp 
			or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo)
		if not isCostOrSac and arg_7_1:getBuffValue(true, BattleData.PositiveType.xyzMark) > 0 then
			return
		end
	end

	if (arg_7_1:isInfoId(40728) or arg_7_1:hasSkillFast(14691)) and arg_7_1:canCastMonsterSkill() and arg_7_1._status == BattleData.CardStatus.board then
		local isCostOrSac = (arg_7_6 == BattleData.CardStatusVal.sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_sync_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_link_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_summon_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.x2gl_cost 
			or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost 
			or arg_7_6 == BattleData.CardStatusVal.h2l_temp 
			or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo)
		local owner = arg_7_1._owner
		local oppo = owner and owner._opponent
		local isOppoTarget = false
		if arg_7_6 == BattleData.CardStatusVal.b2b_oppo_forever then
			isOppoTarget = true
		elseif arg_7_2 ~= BattleData.CardStatus.board and not isCostOrSac then
			if oppo and (arg_7_0 == oppo or oppo._macroStatus == BattleData.Status.use) then
				if arg_7_4 ~= Data.ATTACKING_SKILL_ID and arg_7_6 ~= BattleData.CardStatusVal.b2g_kill_by_attack then
					isOppoTarget = true
				end
			end
		end
		if isOppoTarget then
			if owner and owner._fortress then
				arg_7_0:addDamage(owner._fortress, 500, arg_7_3, arg_7_4, arg_7_5)
			end
			return
		end
	end

	local isThacSam = (arg_7_1:isInfoId(40730) or arg_7_1:hasSkillFast(14719) or arg_7_1:hasSkillFast(14720)) and arg_7_1._status == BattleData.CardStatus.board
	if isThacSam then
		local owner = arg_7_1._owner
		local oppo = owner and owner._opponent
		local isAwakened = arg_7_1._tsAwakened or arg_7_1:hasSkillFast(12002) or (arg_7_1:getBuffValue(true, BattleData.PositiveType.xyzMark) or 0) == 0
		local isBattleKill = (arg_7_4 == Data.ATTACKING_SKILL_ID or arg_7_6 == BattleData.CardStatusVal.b2g_kill_by_attack)
		local caster = (arg_7_0.getCardById and arg_7_0:getCardById(arg_7_3)) or arg_7_0._actionCard
		local isFromOppo = (oppo and (arg_7_0 == oppo or oppo._macroStatus == BattleData.Status.use)) or (caster and caster._owner ~= owner)

		if isAwakened then
			if arg_7_2 ~= BattleData.CardStatus.board and not isBattleKill then
				if isFromOppo or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice or arg_7_6 == BattleData.CardStatusVal.b2b_oppo_forever or arg_7_6 == BattleData.CardStatusVal.b2h_oppo or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo then
					return
				end
			end
		elseif (arg_7_1:getBuffValue(true, BattleData.PositiveType.xyzMark) or 0) > 0 then
			local isCostOrSac = (arg_7_6 == BattleData.CardStatusVal.sacrifice 
				or arg_7_6 == BattleData.CardStatusVal.b2g_sacrifice 
				or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice 
				or arg_7_6 == BattleData.CardStatusVal.b2g_sync_sacrifice 
				or arg_7_6 == BattleData.CardStatusVal.b2g_link_sacrifice 
				or arg_7_6 == BattleData.CardStatusVal.b2g_summon_sacrifice 
				or arg_7_6 == BattleData.CardStatusVal.x2gl_cost 
				or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost 
				or arg_7_6 == BattleData.CardStatusVal.h2l_temp 
				or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo)
			local isOppoTarget = false
			if arg_7_6 == BattleData.CardStatusVal.b2b_oppo_forever then
				isOppoTarget = true
			elseif arg_7_2 ~= BattleData.CardStatus.board and not isCostOrSac then
				if oppo and (arg_7_0 == oppo or oppo._macroStatus == BattleData.Status.use) then
					if not isBattleKill then
						isOppoTarget = true
					end
				end
			end
			if isOppoTarget then
				if caster and caster._owner ~= arg_7_1._owner then
					if B.checkThacSamTargetNegate(arg_7_0, arg_7_1, caster) then
						return
					end
				end
			end
		end
	end

	-- Card 40743 (Kiếm sĩ diệt rồng huyền thoại): khi bị phá hủy bởi chiến đấu hoặc hiệu quả, phá hủy tất cả quái tộc rồng đối phương (xuyên 12002, 12008)
	if (arg_7_1:isInfoId(40743) or arg_7_1:hasSkillFast(14777)) and arg_7_1._status == BattleData.CardStatus.board and (arg_7_2 == BattleData.CardStatus.grave or arg_7_2 == BattleData.CardStatus.leave) then
		local isCostOrSac = (arg_7_6 == BattleData.CardStatusVal.sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_oppo_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_sync_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_link_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.b2g_summon_sacrifice 
			or arg_7_6 == BattleData.CardStatusVal.x2gl_cost 
			or arg_7_6 == BattleData.CardStatusVal.x2gl_oppo_cost 
			or arg_7_6 == BattleData.CardStatusVal.h2l_temp 
			or arg_7_6 == BattleData.CardStatusVal.x2l_temp_oppo)
		if not isCostOrSac then
			local owner = arg_7_1._owner
			local oppo = owner and owner._opponent
			if oppo then
				local oppoDragons = {}
				for _, c in ipairs(oppo:getBoardCards()) do
					if (c._type == Data.CardType.monster or c:isMonster()) and (c._info and c._info._category == 2) then
						table.insert(oppoDragons, c)
					end
				end
				for _, target in ipairs(oppoDragons) do
					if target._positiveStatus then
						target._positiveStatus[BattleData.PositiveType.shieldExMonster] = false
						target._positiveStatus[BattleData.PositiveType.shieldOppoMonster] = false
					end
					oppo:setCardStatus(target, BattleData.CardStatus.grave, arg_7_1._id, 14777, Data.SkillMode.kill, BattleData.CardStatusVal.b2g_dead)
				end
			end
		end
	end

	if arg_7_6 == BattleData.CardStatusVal.r2b_sync or arg_7_6 == BattleData.CardStatusVal.r2b_sync_attack_frozen then
		arg_7_1._mark6387 = nil

		if arg_7_1:hasSkills({
			6421,
			6729,
			9173,
			14123
		}) or arg_7_1:isInfoId(40732) then
			arg_7_1._mark6387 = true
			local turnId = (arg_7_0._round or 0) * 1000 + (arg_7_0._opponent and arg_7_0._opponent._round or 0)
			arg_7_1._syncSummonTurn = turnId
			arg_7_1._summonBySync = true
			if arg_7_0._opponent then
				arg_7_0._opponent._isSkillDisabled = true
			end
		end
	elseif arg_7_6 == BattleData.CardStatusVal.r2b_compose then
		arg_7_1._mark6387 = nil

		if arg_7_1:isKeyword(Data._skillInfo[7427]._refCards[1]) and arg_7_1._owner:hasBattleCardsBySkillFast("D", 7427) or arg_7_1:hasSkills({
			14518
		}) then
			arg_7_1._mark6387 = true
		end
	elseif arg_7_6 == BattleData.CardStatusVal.h2b_ceremony or arg_7_6 == BattleData.CardStatusVal.h2b_ceremony_frozen then
		arg_7_1._hasBeenCeremonySummoned = true
	end

	-- KMR-Zio-Ghost (40741): khi đối phương triệu hồi quái từ Bộ bài thêm -> loại bỏ bản thân và quái đối phương vừa triệu hồi
	if arg_7_2 == BattleData.CardStatus.board and (arg_7_1:isMonsterRare() or arg_7_1._status == BattleData.CardStatus.rare or (arg_7_6 and arg_7_6 >= 101 and arg_7_6 <= 109)) then
		local oppo = arg_7_0._opponent
		if oppo then
			local zioGhosts = oppo:getBattleCardsByInfoId("B", 40741)
			if zioGhosts and #zioGhosts > 0 then
				local zg = zioGhosts[1]
				oppo:setCardStatus(zg, BattleData.CardStatus.leave, zg._id, 14769, Data.SkillMode.board)
				arg_7_2 = BattleData.CardStatus.leave
			end
		end
	end

	if (arg_7_1:isInfoId(12331) or arg_7_1:hasSkillFast(14741)) and arg_7_2 == BattleData.CardStatus.board then
		local pOwner = arg_7_1._owner or arg_7_0
		local turnId = (pOwner._round or 0) * 1000 + (pOwner._opponent and pOwner._opponent._round or 0)
		if arg_7_1._zioSummonTurn ~= turnId then
			arg_7_1._zioSummonTurn = turnId
			local cd_cards = pOwner:getBattleCardsByInfoId("P", 21143)
			if #cd_cards > 0 and #pOwner._handCards < Data.MAX_CARD_COUNT_IN_HAND then
				pOwner:setCardStatus(cd_cards[1], BattleData.CardStatus.hand, arg_7_1._id, 14741, Data.SkillMode.using)
			end
		end
	end

	table.insert(arg_7_1._underSkills, {
		_cid = arg_7_3,
		_sid = arg_7_4,
		_mode = arg_7_5,
		_status = arg_7_2,
		_statusVal = arg_7_6,
		_futureSourceStatus = arg_7_7
	})

	if arg_7_0.updateDragonDebuff then
		arg_7_0:updateDragonDebuff()
	end
end

function var_0_0.updateDragonDebuff(arg_0)
	local p1 = arg_0
	local p2 = arg_0 and arg_0._opponent
	if not p1 or not p2 then return end

	local count1 = 0
	for _, c in ipairs(p1:getBoardCards()) do
		if c:isInfoId(40743) or (c.hasSkillFast and c:hasSkillFast(14775)) then
			count1 = count1 + 1
		end
	end

	local count2 = 0
	for _, c in ipairs(p2:getBoardCards()) do
		if c:isInfoId(40743) or (c.hasSkillFast and c:hasSkillFast(14775)) then
			count2 = count2 + 1
		end
	end

	p1._has40743 = count1
	p2._has40743 = count2

	if count1 == 0 and count2 == 0 then
		p1._dragonDebuffVal = 0
		p2._dragonDebuffVal = 0
		return
	end

	local function isDragonCard(c)
		if not c then return false end
		if c:isMonster() or c:isMonsterRare() or c._type == Data.CardType.monster or c._type == Data.CardType.rare then
			local cat = c._category or (c._info and c._info._category)
			if cat == 2 then return true end
			local kw = c._keyword or (c._info and c._info._keyword)
			if kw == 39 or kw == 7 then return true end
		end
		return false
	end

	local dCount = 0
	for _, c in ipairs(p1:getBoardCards()) do
		if isDragonCard(c) then
			dCount = dCount + 1
		end
	end
	for _, c in ipairs(p2:getBoardCards()) do
		if isDragonCard(c) then
			dCount = dCount + 1
		end
	end
	local g1 = p1._graveCards or {}
	for _, c in ipairs(g1) do
		if isDragonCard(c) then
			dCount = dCount + 1
		end
	end
	local g2 = p2._graveCards or {}
	for _, c in ipairs(g2) do
		if isDragonCard(c) then
			dCount = dCount + 1
		end
	end

	p1._dragonDebuffVal = dCount * 200 * count1
	p2._dragonDebuffVal = dCount * 200 * count2
end

function var_0_0.updateWitherDebuff(arg_0)
	local p1 = arg_0
	local p2 = arg_0 and arg_0._opponent
	if not p1 then return end
	p1:account()
	if p2 then p2:account() end
	local scene = ClientData and ClientData._battleScene
	local bUi = scene and (scene._battleUiNormal or scene._battleUi)
	if bUi then
		if bUi._playerUi and bUi._playerUi._pBoardCards then
			for _, spr in pairs(bUi._playerUi._pBoardCards) do
				if spr and spr.updateAtkHp then spr:updateAtkHp() end
			end
		end
		if bUi._opponentUi and bUi._opponentUi._pBoardCards then
			for _, spr in pairs(bUi._opponentUi._pBoardCards) do
				if spr and spr.updateAtkHp then spr:updateAtkHp() end
			end
		end
	end
end

function var_0_0.setCardPosChange(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	table.insert(arg_8_1._underSkills, {
		_cid = arg_8_3,
		_sid = arg_8_4,
		_mode = arg_8_5,
		_posChange = arg_8_2
	})
end

function var_0_0.addDamage(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	if arg_9_1._owner._mark13840 then
		return
	end

	if arg_9_1._type == Data.CardType.fortress and arg_9_2 > 0 then
		local p_owner = arg_9_1._owner
		if p_owner then
			local var_trap_cover = p_owner:getBattleCardsByInfoId("C", 30592)
			if #var_trap_cover > 0 then
				local trap_card = var_trap_cover[1]
				arg_9_0:setCardStatus(trap_card, BattleData.CardStatus.grave, 30592, 14653, Data.SkillMode.trap)
				p_owner._mark13840 = true
				return
			end

			local var_trap_hand = p_owner:getBattleCardsByInfoId("H", 30592)
			if #var_trap_hand > 0 and #p_owner:getBoardCards() == 0 and #p_owner:getBattleCards("CSD") == 0 then
				local is_oppo_damage = false
				local src_card = (arg_9_3 and arg_9_0:getCardById(arg_9_3)) or arg_9_0._actionCard
				if src_card and src_card._owner == p_owner._opponent then
					is_oppo_damage = true
				elseif p_owner._opponent and (p_owner._opponent._macroStatus == BattleData.Status.use or p_owner._round ~= p_owner._opponent._round) then
					is_oppo_damage = true
				end
				if is_oppo_damage then
					local trap_card = var_trap_hand[1]
					arg_9_0:setCardStatus(trap_card, BattleData.CardStatus.grave, 30592, 14666, Data.SkillMode.hand)
					p_owner._mark13840 = true
					return
				end
			end

			if not arg_9_0._inAntiHealLoop and arg_9_4 ~= 14693 and (arg_9_5 == Data.SkillMode.before_attack or arg_9_4 == Data.ATTACKING_SKILL_ID) then
				local actionCard = arg_9_0:getActionCard()
				local targetCard = (actionCard and actionCard._atkTargets and actionCard._atkTargets[1])
				if targetCard and (targetCard:isInfoId(40728) or targetCard:hasSkillFast(14693)) and targetCard:canCastMonsterSkill() and targetCard._status == BattleData.CardStatus.board and targetCard:getBuffValue(true, BattleData.PositiveType.xyzMark) > 0 and targetCard._owner == p_owner then
					targetCard:removeMark(BattleData.PositiveType.xyzMark, 1)
					local healVal = arg_9_2 * 2
					arg_9_0:incHp(p_owner._fortress, healVal, true, arg_9_3, 14693, arg_9_5, true)
					return
				end
			end
		end
	end

	if arg_9_1._type == Data.CardType.fortress and arg_9_2 > 0 and arg_9_0._isClient and ClientData._isAutoTesting then
		arg_9_2 = 1
	end

	if arg_9_2 > 0 then
		-- block empty
	end

	if arg_9_2 > 0 then
		table.insert(arg_9_1._underSkills, {
			_removable = false,
			_cid = arg_9_3,
			_sid = arg_9_4,
			_mode = arg_9_5,
			_damage = arg_9_2
		})
	elseif arg_9_2 < 0 then
		arg_9_0:incHp(arg_9_1, -arg_9_2, false, arg_9_3, id, arg_9_5)
	end
end

function var_0_0.incAtk(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	if arg_10_2 < 0 and (arg_10_1:isInfoId(40728) or arg_10_1:hasSkillFast(14691)) and arg_10_1:canCastMonsterSkill() then
		local caster = arg_10_0:getCardById(arg_10_4)
		if caster and caster._owner ~= arg_10_1._owner then
			local owner = arg_10_1._owner
			if owner and owner._fortress then
				arg_10_0:addDamage(owner._fortress, 500, arg_10_4, arg_10_5, arg_10_6)
			end
			return
		end
	end
	local isIgnore = (arg_10_5 == 14673 or arg_10_5 == 14787 or arg_10_4 == arg_10_1._id)
	table.insert(arg_10_1._underSkills, {
		_cid = arg_10_4,
		_sid = arg_10_5,
		_mode = arg_10_6,
		_atkInc = arg_10_2,
		_removable = arg_10_3,
		_ignoreDisable = isIgnore or nil
	})
	table.insert(arg_10_1._underSkills, {
		_cid = arg_10_4,
		_sid = arg_10_5,
		_mode = arg_10_6,
		_maxAtkInc = arg_10_2,
		_removable = arg_10_3,
		_ignoreDisable = isIgnore or nil
	})
end

function var_0_0.decAtk(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	if (arg_11_1:isInfoId(40728) or arg_11_1:hasSkillFast(14691)) and arg_11_1:canCastMonsterSkill() then
		local caster = arg_11_0:getCardById(arg_11_4)
		if caster and caster._owner ~= arg_11_1._owner then
			local owner = arg_11_1._owner
			if owner and owner._fortress then
				arg_11_0:addDamage(owner._fortress, 500, arg_11_4, arg_11_5, arg_11_6)
			end
			return
		end
	end
	if (arg_11_1:isInfoId(40730) or arg_11_1:hasSkillFast(14720)) and arg_11_1._status == BattleData.CardStatus.board and (arg_11_1:getBuffValue(true, BattleData.PositiveType.xyzMark) or 0) > 0 then
		local caster = (arg_11_0.getCardById and arg_11_0:getCardById(arg_11_4)) or arg_11_0._actionCard
		if caster and caster._owner ~= arg_11_1._owner then
			if B.checkThacSamTargetNegate(arg_11_0, arg_11_1, caster) then
				return
			end
		end
	end
	table.insert(arg_11_1._underSkills, {
		_cid = arg_11_4,
		_sid = arg_11_5,
		_mode = arg_11_6,
		_atkInc = -arg_11_2,
		_removable = arg_11_3
	})
end

function var_0_0.recAtk(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	if arg_12_2 < 0 or arg_12_1._atk >= arg_12_1._maxAtk + arg_12_1._haloedMaxAtkInc then
		return false
	end

	table.insert(arg_12_1._underSkills, {
		_cid = arg_12_3,
		_sid = arg_12_4,
		_mode = arg_12_5,
		_atkInc = math.min(arg_12_2, arg_12_1._maxAtk + arg_12_1._haloedMaxAtkInc - arg_12_1._atk)
	})

	return true
end

function var_0_0.incAtkCount(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	table.insert(arg_13_1._underSkills, {
		_cid = arg_13_3,
		_sid = arg_13_4,
		_mode = arg_13_5,
		_atkCount = arg_13_2
	})
end

function var_0_0.incHp(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7)
	if arg_14_2 < 0 and (arg_14_1:isInfoId(40728) or arg_14_1:hasSkillFast(14691)) and arg_14_1:canCastMonsterSkill() then
		local caster = arg_14_0:getCardById(arg_14_4)
		if caster and caster._owner ~= arg_14_1._owner then
			local owner = arg_14_1._owner
			if owner and owner._fortress then
				arg_14_0:addDamage(owner._fortress, 500, arg_14_4, arg_14_5, arg_14_6)
			end
			return
		end
	end
	if arg_14_1._type == Data.CardType.fortress then
		if arg_14_1._hp == 0 then
			return
		end

		if not arg_14_7 and not arg_14_0._inAntiHealLoop and (arg_14_1._owner._opponent:hasBattleCardsBySkillFast("B", 6160) or #arg_14_1._owner._opponent:getBattleCardsByInfoId("B", 12316) > 0 or arg_14_1._owner._opponent:hasBattleCardsBySkillFast("B", 14648) or #arg_14_1._owner._opponent:getCanEffectTrapCardsBySkills("S", {
			8060
		}) > 0) then
			arg_14_0._inAntiHealLoop = true
			local ret = arg_14_0:addDamage(arg_14_1, arg_14_1._owner:calcFortressDamage(arg_14_2, true), arg_14_4, arg_14_5, arg_14_6)
			arg_14_0._inAntiHealLoop = nil
			return ret
		end
	elseif arg_14_1:isLink() then
		return
	end

	table.insert(arg_14_1._underSkills, {
		_cid = arg_14_4,
		_sid = arg_14_5,
		_mode = arg_14_6,
		_hpInc = arg_14_2,
		_removable = arg_14_3
	})
	table.insert(arg_14_1._underSkills, {
		_cid = arg_14_4,
		_sid = arg_14_5,
		_mode = arg_14_6,
		_maxHpInc = arg_14_2,
		_removable = arg_14_3
	})

	if arg_14_5 ~= 5635 and arg_14_1._type == Data.CardType.fortress and not arg_14_3 and arg_14_1._owner._opponent._mark5635 then
		arg_14_1._owner._opponent:incHp(arg_14_1._owner._opponent._fortress, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	end
end

function var_0_0.incHp2(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	if arg_15_1._type == Data.CardType.fortress then
		if arg_15_1._hp == 0 then
			return
		end
	elseif arg_15_1:isLink() then
		return
	end

	table.insert(arg_15_1._underSkills, {
		_cid = arg_15_4,
		_sid = arg_15_5,
		_mode = arg_15_6,
		_hpInc = arg_15_2,
		_removable = arg_15_3
	})
	table.insert(arg_15_1._underSkills, {
		_cid = arg_15_4,
		_sid = arg_15_5,
		_mode = arg_15_6,
		_maxHpInc = arg_15_2,
		_removable = arg_15_3
	})
end

function var_0_0.decHp(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	if (arg_16_1:isInfoId(40728) or arg_16_1:hasSkillFast(14691)) and arg_16_1:canCastMonsterSkill() then
		local caster = arg_16_0:getCardById(arg_16_4)
		if caster and caster._owner ~= arg_16_1._owner then
			local owner = arg_16_1._owner
			if owner and owner._fortress then
				arg_16_0:addDamage(owner._fortress, 500, arg_16_4, arg_16_5, arg_16_6)
			end
			return
		end
	end
	if (arg_16_1:isInfoId(40730) or arg_16_1:hasSkillFast(14720)) and arg_16_1._status == BattleData.CardStatus.board and (arg_16_1:getBuffValue(true, BattleData.PositiveType.xyzMark) or 0) > 0 then
		local caster = (arg_16_0.getCardById and arg_16_0:getCardById(arg_16_4)) or arg_16_0._actionCard
		if caster and caster._owner ~= arg_16_1._owner then
			if B.checkThacSamTargetNegate(arg_16_0, arg_16_1, caster) then
				return
			end
		end
	end
	table.insert(arg_16_1._underSkills, {
		_cid = arg_16_4,
		_sid = arg_16_5,
		_mode = arg_16_6,
		_hpInc = -arg_16_2,
		_removable = arg_16_3
	})
end

function var_0_0.recHp(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	if arg_17_2 < 0 or arg_17_1._hp >= arg_17_1._maxHp + arg_17_1._haloedMaxHpInc then
		return false
	end

	if arg_17_1:hasBuff(false, BattleData.NegativeType.healFrozen) then
		return false
	end

	table.insert(arg_17_1._underSkills, {
		_cid = arg_17_3,
		_sid = arg_17_4,
		_mode = arg_17_5,
		_hpInc = math.min(arg_17_2, arg_17_1._maxHp + arg_17_1._haloedMaxHpInc - arg_17_1._hp)
	})

	return true
end

function var_0_0.incSkillLevel(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6)
	table.insert(arg_18_1._underSkills, {
		_cid = arg_18_4,
		_sid = arg_18_5,
		_mode = arg_18_6,
		_skillLevelInc = arg_18_2,
		_removable = arg_18_3
	})
end

function var_0_0.incNegativeStatus(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	if (arg_19_1:isInfoId(40728) or arg_19_1:hasSkillFast(14691)) and arg_19_1:canCastMonsterSkill() then
		local caster = arg_19_0:getCardById(arg_19_4)
		if caster and caster._owner ~= arg_19_1._owner then
			local owner = arg_19_1._owner
			if owner and owner._fortress then
				arg_19_0:addDamage(owner._fortress, 500, arg_19_4, arg_19_5, arg_19_6)
			end
			return
		end
	end
	if (arg_19_1:isInfoId(40730) or arg_19_1:hasSkillFast(14720)) and arg_19_1._status == BattleData.CardStatus.board and (arg_19_1:getBuffValue(true, BattleData.PositiveType.xyzMark) or 0) > 0 then
		local caster = (arg_19_0.getCardById and arg_19_0:getCardById(arg_19_4)) or arg_19_0._actionCard
		if caster and caster._owner ~= arg_19_1._owner then
			if B.checkThacSamTargetNegate(arg_19_0, arg_19_1, caster) then
				return
			end
		end
	end
	if arg_19_1:hasBuff(true, BattleData.PositiveType.ignoreNegative) then
		return
	end

	if #arg_19_2 == 0 then
		for iter_19_0 = 1, BattleData.NegativeType.count do
			table.insert(arg_19_2, iter_19_0)
		end
	end

	table.insert(arg_19_1._underSkills, {
		_cid = arg_19_4,
		_sid = arg_19_5,
		_mode = arg_19_6,
		_incNegative = arg_19_2,
		_removable = arg_19_3
	})
end

function var_0_0.decNegativeStatus(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	if #arg_20_2 == 0 then
		for iter_20_0 = 1, BattleData.NegativeType.count do
			table.insert(arg_20_2, iter_20_0)
		end
	end

	table.insert(arg_20_1._underSkills, {
		_cid = arg_20_4,
		_sid = arg_20_5,
		_mode = arg_20_6,
		_decNegative = arg_20_2,
		_removable = arg_20_3
	})
end

function var_0_0.incPositiveStatus(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)
	if #arg_21_2 == 0 then
		for iter_21_0 = 1, BattleData.PositiveType.count do
			table.insert(arg_21_2, iter_21_0)
		end
	end

	for iter_21_1 = 1, #arg_21_2 do
		if arg_21_2[iter_21_1] == BattleData.PositiveType.defendPosture and arg_21_1:isBindedSkill(7027) then
			arg_21_1._owner:setCardStatus(arg_21_1._owner._fortress, BattleData.CardStatus.fortress, arg_21_4, id, arg_21_6, BattleData.CardStatusVal.f2f_halo)
		end
	end

	table.insert(arg_21_1._underSkills, {
		_cid = arg_21_4,
		_sid = arg_21_5,
		_mode = arg_21_6,
		_incPositive = arg_21_2,
		_removable = arg_21_3
	})
end

function var_0_0.decPositiveStatus(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
	if #arg_22_2 == 0 then
		for iter_22_0 = 1, BattleData.PositiveType.count do
			table.insert(arg_22_2, iter_22_0)
		end
	end

	for iter_22_1 = 1, #arg_22_2 do
		if arg_22_2[iter_22_1] == BattleData.PositiveType.defendPosture and arg_22_1:isBindedSkill(7027) then
			arg_22_1._owner:setCardStatus(arg_22_1._owner._fortress, BattleData.CardStatus.fortress, arg_22_4, id, arg_22_6, BattleData.CardStatusVal.f2f_halo)
		end
	end

	table.insert(arg_22_1._underSkills, {
		_cid = arg_22_4,
		_sid = arg_22_5,
		_mode = arg_22_6,
		_decPositive = arg_22_2,
		_removable = arg_22_3
	})
end

function var_0_0.incNegativeValue(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6, arg_23_7, arg_23_8)
	if arg_23_1:hasBuff(true, BattleData.PositiveType.ignoreNegative) then
		return
	end

	table.insert(arg_23_1._underSkills, {
		_removable = true,
		_cid = arg_23_5,
		_sid = arg_23_6,
		_mode = arg_23_7,
		_negativeType = arg_23_2,
		_value = arg_23_3,
		_aggregateType = arg_23_4
	})

	if not arg_23_8 and #arg_23_1._underSkills > 1 then
		local prevSkill = arg_23_1._underSkills[#arg_23_1._underSkills - 1]
		if prevSkill then
			prevSkill._follower = arg_23_1._underSkills[#arg_23_1._underSkills]

			local var_23_0 = prevSkill._incNegative and prevSkill._incNegative[1]

			if var_23_0 and arg_23_7 ~= Data.SkillMode.halo and var_23_0 >= BattleData.NegativeType.haloSkillBegin and var_23_0 <= BattleData.NegativeType.haloSkillEnd then
				prevSkill._ignoreDisable = true
				arg_23_1._underSkills[#arg_23_1._underSkills]._ignoreDisable = true
			end
		end
	end
end

function var_0_0.incPositiveValue(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5, arg_24_6, arg_24_7, arg_24_8)
	table.insert(arg_24_1._underSkills, {
		_removable = true,
		_cid = arg_24_5,
		_sid = arg_24_6,
		_mode = arg_24_7,
		_positiveType = arg_24_2,
		_value = arg_24_3,
		_aggregateType = arg_24_4
	})

	if not arg_24_8 and #arg_24_1._underSkills > 1 then
		local prevSkill = arg_24_1._underSkills[#arg_24_1._underSkills - 1]
		if prevSkill then
			prevSkill._follower = arg_24_1._underSkills[#arg_24_1._underSkills]

			local var_24_0 = prevSkill._incPositive and prevSkill._incPositive[1]

			if var_24_0 and arg_24_7 ~= Data.SkillMode.halo and var_24_0 >= BattleData.PositiveType.haloSkillBegin and var_24_0 <= BattleData.PositiveType.haloSkillEnd then
				prevSkill._ignoreDisable = true
				arg_24_1._underSkills[#arg_24_1._underSkills]._ignoreDisable = true
			end
		end
	end
end

function var_0_0.incShield(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6, arg_25_7)
	for iter_25_0 = 1, #arg_25_2 do
		if arg_25_2[iter_25_0] ~= 12008 and arg_25_2[iter_25_0] ~= 12009 and arg_25_2[iter_25_0] ~= 12010 or not arg_25_1._markIgnoreOppoShield and not arg_25_1._owner._mark9517 and (not arg_25_1._mark1142 or not arg_25_1._mark1142[arg_25_2[iter_25_0]]) then
			local var_25_0 = B.getShieldTypeBySkillId(arg_25_2[iter_25_0], arg_25_4)
			local var_25_1 = (var_25_0 == BattleData.PositiveType.shieldHp or var_25_0 == BattleData.PositiveType.shieldExHp) and arg_25_0._fortress or arg_25_1

			if arg_25_3 ~= true or arg_25_4 ~= false or not var_25_1:hasBuff(true, var_25_0) then
				arg_25_0:incPositiveStatus(var_25_1, {
					var_25_0
				}, arg_25_4, arg_25_5, arg_25_6, arg_25_7)
				arg_25_0:incPositiveValue(var_25_1, var_25_0, (arg_25_3 and 65536 or 0) + 1, Data.AggregateType.table, arg_25_5, arg_25_6, arg_25_7)
			end
		end
	end
end

function var_0_0.decShield(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
	local var_26_0 = {}

	for iter_26_0 = 1, #arg_26_2 do
		local var_26_1 = B.getShieldTypeBySkillId(arg_26_2[iter_26_0], arg_26_3)

		var_26_0[#var_26_0 + 1] = var_26_1
	end

	arg_26_0:decPositiveStatus(arg_26_1, var_26_0, arg_26_3, arg_26_4, id, arg_26_6)
end

function var_0_0.changePosture(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
	if not arg_27_6 and arg_27_1:isDisablePosture() then
		return false
	end

	if arg_27_1:isLink() then
		return false
	end

	if arg_27_2 then
		if not arg_27_6 and arg_27_0._opponent then
			local oppo = arg_27_0._opponent
			local var_mirrorTraps = oppo:getBattleCardsByInfoId("S", 30594)
			if #var_mirrorTraps == 0 then
				var_mirrorTraps = oppo:getBattleCardsBySkillFast("S", 14755)
			end
			if #var_mirrorTraps > 0 then
				local hasAzOrHarpie = false
				for _, c in ipairs(oppo:getBoardCards()) do
					if c:isMonsterRare() and (c:isKeyword(6) or c:isKeyword(15) or c._infoId == 10083 or c._infoId == 10213 or c._infoId == 10287 or c._infoId == 10548 or c._infoId == 40726 or c._infoId == 40736) then
						hasAzOrHarpie = true
						break
					end
				end
				if hasAzOrHarpie then
					return false
				end
			end
		end

		if arg_27_1:hasBuff(true, BattleData.PositiveType.defendPosture) then
			return false
		end

		arg_27_0:incPositiveStatus(arg_27_1, {
			BattleData.PositiveType.defendPosture
		}, false, arg_27_3, arg_27_4, arg_27_5)
	else
		if not arg_27_1:hasBuff(true, BattleData.PositiveType.defendPosture) then
			return false
		end

		arg_27_0:decPositiveStatus(arg_27_1, {
			BattleData.PositiveType.defendPosture
		}, false, arg_27_3, arg_27_4, arg_27_5)
	end

	return true
end

function var_0_0.addGivenSkillToOppo(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	table.insert(arg_28_1._underSkills, {
		_cid = arg_28_3,
		_sid = arg_28_4,
		_mode = arg_28_5,
		_givenSkill = arg_28_2
	})
end

function var_0_0.incGem(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	table.insert(arg_29_1._underSkills, {
		_cid = arg_29_3,
		_sid = arg_29_4,
		_mode = arg_29_5,
		_gemInc = arg_29_2
	})
end

function var_0_0.frozenGem(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5)
	table.insert(arg_30_1._underSkills, {
		_cid = arg_30_3,
		_sid = arg_30_4,
		_mode = arg_30_5,
		_gemFrozen = arg_30_2
	})
end

function var_0_0.setCardRebirth(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	table.insert(arg_31_1._underSkills, {
		_cid = arg_31_3,
		_sid = arg_31_4,
		_mode = arg_31_5,
		_rebirth = arg_31_2
	})
end

function var_0_0.incBookRound(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	table.insert(arg_32_1._underSkills, {
		_cid = arg_32_3,
		_sid = arg_32_4,
		_mode = arg_32_5,
		_incBookRound = arg_32_2
	})
end

function var_0_0.changeCardCountry(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6)
	table.insert(arg_33_1._underSkills, {
		_cid = arg_33_4,
		_sid = arg_33_5,
		_mode = arg_33_6,
		_changeCountry = arg_33_2,
		_removable = arg_33_3
	})
end

function var_0_0.bindCard(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	if (arg_34_2 and (arg_34_2:isInfoId(40730) or arg_34_2:hasSkillFast(14720)) and arg_34_2._status == BattleData.CardStatus.board and (arg_34_2:getBuffValue(true, BattleData.PositiveType.xyzMark) or 0) > 0) then
		if arg_34_1 and arg_34_1._owner ~= arg_34_2._owner then
			if B.checkThacSamTargetNegate(arg_34_0, arg_34_2, arg_34_1) then
				return
			end
		end
	end
	if B.isAlive(arg_34_2) then
		arg_34_1:addBind(arg_34_2)
		arg_34_2:addBind(arg_34_1)
		table.insert(arg_34_1._underSkills, {
			_cid = arg_34_3,
			_sid = arg_34_4,
			_mode = arg_34_5,
			_bind = arg_34_2,
			_removable = removable
		})
		table.insert(arg_34_2._underSkills, {
			_cid = arg_34_3,
			_sid = arg_34_4,
			_mode = arg_34_5,
			_bind = arg_34_1,
			_removable = removable,
			_trigger = arg_34_1._underSkills[#arg_34_1._underSkills]
		})
	else
		arg_34_0:setCardStatus(arg_34_1, BattleData.CardStatus.grave, arg_34_3, arg_34_4, arg_34_5)
	end
end

function var_0_0.addGemUnderSkill(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5, arg_35_6)
	arg_35_0._gemUnderSkills[#arg_35_0._gemUnderSkills + 1] = {
		_cid = arg_35_4,
		_sid = arg_35_5,
		_mode = arg_35_6,
		_val = arg_35_1,
		_singleRound = arg_35_2,
		_count = arg_35_3
	}
end

function var_0_0.removeGemUnderSkillsByRound(arg_36_0)
	local var_36_0 = {}

	for iter_36_0 = 1, #arg_36_0._gemUnderSkills do
		local var_36_1 = arg_36_0._gemUnderSkills[iter_36_0]

		if not var_36_1._singleRound then
			var_36_0[#var_36_0 + 1] = var_36_1
		end
	end

	arg_36_0._gemUnderSkills = var_36_0
end

function var_0_0.account(arg_37_0)
	local var_37_0 = arg_37_0:getAllCards()
	local var_37_1 = {}
	local var_37_2 = {}
	local var_37_3 = {}

	for iter_37_0 = 1, #var_37_0 do
		local var_37_4 = var_37_0[iter_37_0]

		if var_37_4._status == BattleData.CardStatus.board or var_37_4._status == BattleData.CardStatus.show or var_37_4._status == BattleData.CardStatus.field or next(var_37_4._underSkills) ~= nil then
			if var_37_4:isV12() or var_37_4._infoId == 11710 and var_37_4._status ~= BattleData.CardStatus.board or var_37_4:hasCanCastMonsterSkillFast(13722) and var_37_4._status == BattleData.CardStatus.board and not var_37_4:hasChangeStatusUnderSkill({
				BattleData.CardStatus.grave,
				BattleData.CardStatus.leave,
				BattleData.CardStatus.pile,
				BattleData.CardStatus.hand
			}) then
				var_37_3[#var_37_3 + 1] = var_37_4
			elseif var_37_4:hasAdvanceUnderSkill() then
				var_37_1[#var_37_1 + 1] = var_37_4
			else
				var_37_2[#var_37_2 + 1] = var_37_4
			end
		end
	end

	for iter_37_1 = 1, #var_37_1 do
		local var_37_5 = var_37_1[iter_37_1]

		var_37_5._owner:accountTarget(var_37_5)
	end

	for iter_37_2 = 1, #var_37_2 do
		local var_37_6 = var_37_2[iter_37_2]

		var_37_6._owner:accountTarget(var_37_6)
	end

	for iter_37_3 = 1, #var_37_3 do
		local var_37_7 = var_37_3[iter_37_3]

		var_37_7._owner:accountTarget(var_37_7)
	end
end

function var_0_0.accountTarget(arg_38_0, arg_38_1)
	arg_38_1._old._hp = arg_38_1._hp
	arg_38_1._old._atk = arg_38_1._atk
	arg_38_1._old._atkCount = arg_38_1._atkCount
	arg_38_1._old._actionCount = arg_38_1._actionCount
	arg_38_1._old._skillLevelInc = arg_38_1._skillLevelInc

	for iter_38_0 = 1, BattleData.NegativeType.count do
		arg_38_1._old._negativeStatus[iter_38_0] = arg_38_1._negativeStatus and arg_38_1._negativeStatus[iter_38_0]
		arg_38_1._old._negativeValues[iter_38_0] = arg_38_1._negativeValues and arg_38_1._negativeValues[iter_38_0]

		if arg_38_1._negativeStatus and iter_38_0 >= BattleData.NegativeType.haloSkillBegin and iter_38_0 <= BattleData.NegativeType.haloSkillEnd then
			arg_38_1._negativeStatus[iter_38_0] = false
		end
	end

	for iter_38_1 = 1, BattleData.PositiveType.count do
		arg_38_1._old._positiveStatus[iter_38_1] = arg_38_1._positiveStatus and arg_38_1._positiveStatus[iter_38_1]
		arg_38_1._old._positiveValues[iter_38_1] = arg_38_1._positiveValues and arg_38_1._positiveValues[iter_38_1]

		if arg_38_1._positiveStatus and (iter_38_1 >= BattleData.PositiveType.haloSkillBegin and iter_38_1 <= BattleData.PositiveType.haloSkillEnd or iter_38_1 == BattleData.PositiveType.shieldHaloDestroy or iter_38_1 == BattleData.PositiveType.shieldHaloEffectDestroy or iter_38_1 >= BattleData.PositiveType.shieldHaloOppoMonster and iter_38_1 <= BattleData.PositiveType.shieldHaloOppoTrap) then
			arg_38_1._positiveStatus[iter_38_1] = false
		end
	end

	local var_38_0

	for iter_38_2 = 1, #arg_38_1._underSkills do
		local var_38_1 = arg_38_1._underSkills[iter_38_2]

		if var_38_1._disabled ~= true then
			for iter_38_3, iter_38_4 in pairs(var_38_1) do
				if iter_38_3 == "_rebirth" then
					var_38_0 = iter_38_4
				end
			end
		end
	end

	if var_38_0 ~= nil then
		arg_38_1:rebirth(var_38_0)
	end

	local var_38_2 = arg_38_1._maxHpInc
	local var_38_3 = arg_38_1._hpInc
	local var_38_4 = arg_38_1._maxAtkInc
	local var_38_5 = arg_38_1._atkInc
	local var_38_6 = {}
	local var_38_7 = {}
	local var_38_8 = {}
	local var_38_9 = {}
	local var_38_10 = arg_38_1._skillLevelInc
	local var_38_11 = 0
	local var_38_12
	local var_38_13
	local var_38_14 = 0
	local var_38_15 = 0
	local var_38_16 = 0
	local var_38_17 = 0

	local function var_38_18(arg_39_0)
		return arg_39_0 >= BattleData.PositiveType.shieldHaloBegin and arg_39_0 <= BattleData.PositiveType.shieldExEnd and arg_39_0 ~= BattleData.PositiveType.shieldHaloAttack and arg_39_0 ~= BattleData.PositiveType.shieldAttack and arg_39_0 ~= BattleData.PositiveType.shieldExAttack or arg_39_0 >= BattleData.PositiveType.shieldDestroy and arg_39_0 <= BattleData.PositiveType.shieldHaloOppoTrap
	end

	local function var_is_halo_under_skill_dead(arg_under_skill)
		if arg_under_skill._mode ~= Data.SkillMode.halo or arg_under_skill._cid == nil then
			return false
		end

		local var_caster = arg_38_0:getCardById(arg_under_skill._cid)
		if var_caster == nil then
			return true
		end

		if arg_under_skill._sid == 3979 or arg_under_skill._sid == 13558 then
			return var_caster._status ~= BattleData.CardStatus.grave
		end

		if arg_under_skill._sid == 14624 then
			return var_caster._status ~= BattleData.CardStatus.leave
		end

		if var_caster._status == BattleData.CardStatus.board or var_caster._status == BattleData.CardStatus.field or var_caster._status == BattleData.CardStatus.fortress then
			return false
		end

		if var_caster._status == BattleData.CardStatus.show then
			if var_caster:isEquipMagic() or (var_caster.isEquipTrap and var_caster:isEquipTrap()) or #var_caster._binds > 0 then
				if #var_caster._binds == 0 then
					return true
				end
				if not var_caster:isBinded(arg_38_1) and var_caster._binds[1] ~= arg_38_1 and not arg_38_1:isBinded(var_caster) then
					return true
				end
			end
			return false
		end

		return true
	end

	local var_halo_dead_cache = {}

	for iter_38_5 = 1, #arg_38_1._underSkills do
		local var_38_19 = arg_38_1._underSkills[iter_38_5]
		local var_is_halo_dead_19 = var_is_halo_under_skill_dead(var_38_19)
		var_halo_dead_cache[iter_38_5] = var_is_halo_dead_19

		if var_38_19._disabled ~= true and not var_is_halo_dead_19 then
			for iter_38_6, iter_38_7 in pairs(var_38_19) do
				if iter_38_6 == "_incPositive" then
					for iter_38_8, iter_38_9 in ipairs(iter_38_7) do
						if var_38_18(iter_38_9) then
							var_38_8[iter_38_9] = true
						end
					end
				elseif iter_38_6 == "_decPositive" then
					for iter_38_10, iter_38_11 in ipairs(iter_38_7) do
						if var_38_18(iter_38_11) then
							var_38_9[iter_38_11] = true
						end
					end
				end
			end
		end
	end

	if arg_38_1._positiveStatus ~= nil then
		for iter_38_12 = BattleData.PositiveType.shieldHaloBegin, BattleData.PositiveType.shieldHaloOppoTrap do
			if var_38_18(iter_38_12) then
				if var_38_9[iter_38_12] then
					arg_38_1._positiveStatus[iter_38_12] = false
				elseif var_38_8[iter_38_12] then
					arg_38_1._positiveStatus[iter_38_12] = true
				end

				if arg_38_1._positiveStatus[iter_38_12] == false then
					arg_38_1:resetBuffByType(true, iter_38_12)
				elseif arg_38_1._positiveStatus[iter_38_12] == true then
					arg_38_1:accountBuffValue(true, iter_38_12)
				end
			end
		end
	end

	for iter_38_13 = 1, #arg_38_1._underSkills do
		local var_38_20 = arg_38_1._underSkills[iter_38_13]
		local var_is_halo_dead_20 = var_halo_dead_cache[iter_38_13]
		if var_is_halo_dead_20 == nil then
			var_is_halo_dead_20 = var_is_halo_under_skill_dead(var_38_20)
		end

		if var_38_20._disabled ~= true and not var_is_halo_dead_20 and not arg_38_0:isHaloUnderSkillDisabledByShield(arg_38_1, var_38_20) then
			for iter_38_14, iter_38_15 in pairs(var_38_20) do
				if iter_38_14 == "_incNegative" then
					for iter_38_16, iter_38_17 in ipairs(iter_38_15) do
						var_38_6[iter_38_17] = true
					end
				elseif iter_38_14 == "_decNegative" then
					for iter_38_18, iter_38_19 in ipairs(iter_38_15) do
						var_38_7[iter_38_19] = true
					end
				elseif iter_38_14 == "_incPositive" then
					for iter_38_20, iter_38_21 in ipairs(iter_38_15) do
						if not var_38_18(iter_38_21) then
							var_38_8[iter_38_21] = true
						end
					end
				elseif iter_38_14 == "_decPositive" then
					for iter_38_22, iter_38_23 in ipairs(iter_38_15) do
						if not var_38_18(iter_38_23) then
							var_38_9[iter_38_23] = true
						end
					end
				elseif iter_38_14 == "_maxHpInc" then
					var_38_2 = var_38_2 + iter_38_15

					if not var_38_20._removable then
						arg_38_1._maxHpInc = arg_38_1._maxHpInc + iter_38_15
					end
				elseif iter_38_14 == "_hpInc" then
					var_38_3 = var_38_3 + iter_38_15

					if not var_38_20._removable then
						arg_38_1._hpInc = arg_38_1._hpInc + iter_38_15
					end
				elseif iter_38_14 == "_maxAtkInc" then
					var_38_4 = var_38_4 + iter_38_15

					if not var_38_20._removable then
						arg_38_1._maxAtkInc = arg_38_1._maxAtkInc + iter_38_15
					end
				elseif iter_38_14 == "_atkInc" then
					var_38_5 = var_38_5 + iter_38_15

					if not var_38_20._removable then
						arg_38_1._atkInc = arg_38_1._atkInc + iter_38_15
					end
				elseif iter_38_14 == "_skillLevelInc" then
					var_38_10 = var_38_10 + iter_38_15

					if not var_38_20._removable then
						arg_38_1._skillLevelInc = arg_38_1._skillLevelInc + iter_38_15
					end
				elseif iter_38_14 == "_atkCount" then
					arg_38_1._atkCount = arg_38_1._atkCount + iter_38_15
				elseif iter_38_14 == "_actionCount" then
					arg_38_1._actionCount = arg_38_1._actionCount + iter_38_15
				elseif iter_38_14 == "_damage" then
					var_38_11 = var_38_11 + iter_38_15

					if iter_38_15 > 0 then
						var_38_12 = arg_38_0:getCardById(var_38_20._cid)
						var_38_13 = var_38_20._sid
					end
				elseif iter_38_14 == "_gemInc" then
					var_38_14 = var_38_14 + iter_38_15
				elseif iter_38_14 == "_gemFrozen" then
					var_38_15 = var_38_15 + iter_38_15
				elseif iter_38_14 == "_status" then
					arg_38_0:changeCardStatus(arg_38_1, var_38_20._futureSourceStatus or arg_38_1._status, iter_38_15, var_38_20._statusVal, arg_38_0:getCardById(var_38_20._cid))
				elseif iter_38_14 == "_posChange" then
					arg_38_1._owner._boardCards[arg_38_1._pos] = nil
					arg_38_1._pos = iter_38_15
					arg_38_1._owner._boardCards[arg_38_1._pos] = arg_38_1
					var_38_17 = arg_38_1._pos
				elseif iter_38_14 == "_incBookRound" then
					var_38_16 = var_38_16 + iter_38_15
				elseif iter_38_14 == "_changeCountry" then
					country = iter_38_15
				elseif iter_38_14 == "_givenSkill" then
					arg_38_1:removeSkills(BattleData.SkillProvider.given)
					arg_38_1:addSkill(iter_38_15 % 65536, math.floor(iter_38_15 / 65536), BattleData.SkillProvider.given)
				elseif iter_38_14 == "_bind" then
					arg_38_1:addBind(iter_38_15)
				end
			end
		end
	end

	if arg_38_1._negativeStatus ~= nil then
		for iter_38_24 = 1, BattleData.NegativeType.count do
			if var_38_7[iter_38_24] then
				arg_38_1._negativeStatus[iter_38_24] = false
			elseif var_38_6[iter_38_24] then
				arg_38_1._negativeStatus[iter_38_24] = true
			end

			if arg_38_1._negativeStatus[iter_38_24] == false then
				arg_38_1:resetBuffByType(false, iter_38_24)
			elseif arg_38_1._negativeStatus[iter_38_24] == true then
				arg_38_1:accountBuffValue(false, iter_38_24)

				if iter_38_24 == BattleData.NegativeType.chaosFortress or iter_38_24 == BattleData.NegativeType.chaosMonster or iter_38_24 == BattleData.NegativeType.chaos then
					if arg_38_1._negativeStatus[iter_38_24] ~= arg_38_1._old._negativeStatus[iter_38_24] then
						arg_38_1._atkTarget = nil

						arg_38_0:genAttackTarget(arg_38_1)
					end
				elseif iter_38_24 == BattleData.NegativeType.disableDefend then
					var_38_9[BattleData.PositiveType.defendPosture] = true
					var_38_8[BattleData.PositiveType.defendPosture] = false
				end
			end
		end

		if (arg_38_1._infoId == 40730 or arg_38_1:hasSkillFast(14719)) and arg_38_1._status == BattleData.CardStatus.board then
			if not arg_38_1._tsAwakened then
				arg_38_1._negativeStatus[BattleData.NegativeType.manacle] = true
				arg_38_1._negativeStatus[BattleData.NegativeType.atkFrozen] = true
			else
				arg_38_1._negativeStatus[BattleData.NegativeType.manacle] = false
				arg_38_1._negativeStatus[BattleData.NegativeType.atkFrozen] = false
			end
		end
	end

	if arg_38_1._positiveStatus ~= nil then
		for iter_38_25 = 1, BattleData.PositiveType.count do
			if not var_38_18(iter_38_25) then
				if var_38_9[iter_38_25] then
					arg_38_1._positiveStatus[iter_38_25] = false
				elseif var_38_8[iter_38_25] then
					arg_38_1._positiveStatus[iter_38_25] = true
				end

				if arg_38_1._positiveStatus[iter_38_25] == false then
					arg_38_1:resetBuffByType(true, iter_38_25)
				elseif arg_38_1._positiveStatus[iter_38_25] == true then
					arg_38_1:accountBuffValue(true, iter_38_25)

					if B.isMark(iter_38_25) and arg_38_1:getBuffValue(true, iter_38_25) == 0 then
						arg_38_1._positiveStatus[iter_38_25] = false

						arg_38_1:resetBuffByType(true, iter_38_25)
					end
				end

				if iter_38_25 >= BattleData.PositiveType.attackTargetBegan and iter_38_25 <= BattleData.PositiveType.attackTargetEnd then
					if arg_38_1._positiveStatus[iter_38_25] then
						arg_38_1._atkTarget = nil

						arg_38_0:genAttackTarget(arg_38_1)
					end
				elseif iter_38_25 == BattleData.PositiveType.extraSkill then
					arg_38_1:accountExtraSkill()
				elseif iter_38_25 == BattleData.PositiveType.defendPosture and arg_38_1:hasSkills({
					6166
				}) then
					arg_38_1._positiveStatus[BattleData.PositiveType.irony] = arg_38_1._positiveStatus[iter_38_25]
				end
			end
		end
	end

	local var_38_21 = 1

	while true do
		local var_38_22 = arg_38_1._underSkills[var_38_21]

		if var_38_22 == nil then
			break
		end

		local var_is_halo_dead_22 = var_is_halo_under_skill_dead(var_38_22)

		if not var_38_22._removable or var_is_halo_dead_22 then
			if var_38_22._disabled ~= true and var_38_22._follower ~= nil and var_38_22._follower._disabled ~= true then
				var_38_22._follower._ignoreDisable = true
			end

			table.remove(arg_38_1._underSkills, var_38_21)
		else
			var_38_21 = var_38_21 + 1
		end
	end

	if arg_38_1._type == Data.CardType.fortress and (arg_38_0._stepStatus == BattleData.Status.account_attack or arg_38_0._opponent._stepStatus == BattleData.Status.account_attack or arg_38_0._stepStatus == BattleData.Status.account_spell and arg_38_0._spellType == Data.SkillMode.after_attack or arg_38_0._opponent._stepStatus == BattleData.Status.account_spell and arg_38_0._opponent._spellType == Data.SkillMode.after_attack) and arg_38_1._accountedDamage == nil then
		arg_38_1._accountedDamage = var_38_11
	end

	if arg_38_1._type == Data.CardType.fortress and (arg_38_0._stepStatus == BattleData.Status.account_attack or arg_38_0._opponent._stepStatus == BattleData.Status.account_attack) and arg_38_1._accountedAttackDamage == nil then
		arg_38_1._accountedAttackDamage = var_38_11
	end

	local var_38_23 = 0
	local var_38_24 = 0

	if arg_38_1._type == Data.CardType.boss and arg_38_1._info._isDeamon == 1 then
		var_38_11 = math.min(var_38_11, 30000)
	end

	if var_38_11 ~= 0 then
		var_38_3 = var_38_3 - var_38_11
		arg_38_1._hpInc = arg_38_1._hpInc - var_38_11
	end

	if arg_38_1._hp ~= nil then
		if arg_38_1._type == Data.CardType.fortress and arg_38_1._owner._fortressHp == 0 then
			arg_38_1._hp = arg_38_1._maxHp
		else
			local var_38_25 = (arg_38_1:hasBuff(false, BattleData.NegativeType.atkDefSwapHalo) or arg_38_1:hasBuff(false, BattleData.NegativeType.atkDefSwap)) and arg_38_1._maxAtk or arg_38_1._maxHp
			local var_38_26 = var_38_25 + var_38_3

			arg_38_1._hp = math.max(math.min(var_38_26, var_38_25 + var_38_2), var_38_23)
			arg_38_1._hpInc = arg_38_1._hpInc + (arg_38_1._hp - var_38_26)

			if arg_38_1:hasSkillFast(6074) then
				local var_38_27 = 0
				local var_38_28 = B.filterNoSkillCards(B.mergeTable({
					arg_38_0:getBoardCards(),
					arg_38_0._opponent:getBoardCards()
				}), 6074)

				if #var_38_28 > 0 then
					var_38_27 = math.max(B.getMaxAtkCard(var_38_28)._atk, B.getMaxHpCard(var_38_28)._hp)
				end

				arg_38_1._hp = var_38_27 + Data._skillInfo[6074]._val[1]
			elseif arg_38_1:hasCanCastMonsterSkillFast(13722) and not arg_38_1._owner._isSkillDisabled then
				local var_38_29 = 0
				local var_38_30 = B.filterNoSkillCards(B.mergeTable({
					arg_38_0:getBattleCardsByMaxQuality("B", 4),
					arg_38_0._opponent:getBattleCardsByMaxQuality("B", 4)
				}), 13722)

				if #var_38_30 > 0 then
					var_38_29 = math.max(B.getMaxAtkCard(var_38_30)._atk, B.getMaxHpCard(var_38_30)._hp)
				end

				arg_38_1._hp = var_38_29 + Data._skillInfo[13722]._val[1]
			elseif (arg_38_1._infoId == 12326 or arg_38_1:hasSkillFast(14707)) and arg_38_1._status == BattleData.CardStatus.board then
				local marks = arg_38_1:getBuffValue(true, BattleData.PositiveType.godMark) or 0
				local rate = (marks >= 5) and 600 or 300
				local bonus = marks * rate
				arg_38_1._maxHp = 2800
				arg_38_1._hp = math.max(1, 2800 + bonus + var_38_3)
			elseif (arg_38_1._infoId == 40730 or arg_38_1:hasSkillFast(14719)) and arg_38_1._status == BattleData.CardStatus.board then
				if arg_38_1._tsAwakened then
					arg_38_1._maxHp = 16000
					arg_38_1._hp = math.max(1, 16000 + var_38_3)
				else
					arg_38_1._maxHp = 8000
					arg_38_1._hp = math.max(1, 8000 + var_38_3)
				end
			elseif arg_38_1:hasBuff(true, BattleData.PositiveType.lockDef) then
				arg_38_1._hp = arg_38_1:getBuffValue(true, BattleData.PositiveType.lockDef)
			end
		end

		arg_38_1._haloedMaxHpInc = var_38_2
	end

	if arg_38_1._atk ~= nil then
		local var_38_31 = (arg_38_1:hasBuff(false, BattleData.NegativeType.atkDefSwapHalo) or arg_38_1:hasBuff(false, BattleData.NegativeType.atkDefSwap)) and arg_38_1._maxHp or arg_38_1._maxAtk
		local var_38_32 = var_38_31 + var_38_5

		arg_38_1._atk = math.max(math.min(var_38_32, var_38_31 + var_38_4), var_38_24)
		arg_38_1._atkInc = arg_38_1._atkInc + (arg_38_1._atk - var_38_32)

		if (arg_38_1._infoId == 12324 or arg_38_1:hasSkillFast(14700)) and arg_38_1._status == BattleData.CardStatus.board then
			local owner = arg_38_1._owner or arg_38_0
			local ht_val = math.max(0, (owner and owner._fortress and owner._fortress._hp) or arg_38_1._htAtk or 0)
			arg_38_1._htAtk = ht_val
			arg_38_1._maxAtk = 0
			arg_38_1._atk = math.max(0, ht_val + var_38_5)
		elseif (arg_38_1._infoId == 12326 or arg_38_1:hasSkillFast(14707)) and arg_38_1._status == BattleData.CardStatus.board then
			local marks = arg_38_1:getBuffValue(true, BattleData.PositiveType.godMark) or 0
			local rate = (marks >= 5) and 600 or 300
			local bonus = marks * rate
			arg_38_1._maxAtk = 2000
			arg_38_1._atk = math.max(0, 2000 + bonus + var_38_5)
		elseif (arg_38_1._infoId == 40729 or arg_38_1:hasSkillFast(14711)) and arg_38_1._status == BattleData.CardStatus.board then
			local eqCount = 0
			if arg_38_1._binds then
				for _, b in ipairs(arg_38_1._binds) do
					if b and (b:isKeyword(13) or b:isKeyword(61) or (b._info and (b._info._keyword == 13 or b._info._keyword == 61))) then
						eqCount = eqCount + 1
					end
				end
			end
			arg_38_1._maxAtk = 4000
			arg_38_1._atk = math.max(0, 4000 + eqCount * 500 + var_38_5)
		elseif (arg_38_1._infoId == 40730 or arg_38_1:hasSkillFast(14719)) and arg_38_1._status == BattleData.CardStatus.board then
			if arg_38_1._tsAwakened then
				arg_38_1._maxAtk = 16000
				arg_38_1._atk = math.max(0, 16000 + var_38_5)
			else
				arg_38_1._maxAtk = 8000
				arg_38_1._atk = math.max(0, 8000 + var_38_5)
			end
		elseif (arg_38_1._infoId == 40736 or arg_38_1:hasSkillFast(14750)) and arg_38_1._status == BattleData.CardStatus.board then
			local owner = arg_38_1._owner or arg_38_0
			local count = 0
			local graveCards = (owner and (owner._graveCards or (owner.getGraveCards and owner:getGraveCards()))) or {}
			for _, gc in ipairs(graveCards) do
				if gc and (gc:isInfoId(10083) or gc:isKeyword(15) or gc:isKeyword(7) or gc:hasSkillFast(3113) or gc._infoId == 40736) then
					count = count + 1
				end
			end
			local bonus = count * 500
			arg_38_1._maxAtk = 3000 + bonus
			arg_38_1._atk = math.max(0, 3000 + bonus + var_38_5)
		elseif arg_38_1:isV12() then
			arg_38_1._atk = arg_38_1._hp
		elseif arg_38_1:hasCanCastMonsterSkillFast(13722) then
			arg_38_1._atk = arg_38_1._hp
		elseif arg_38_1:hasBuff(true, BattleData.PositiveType.lockAtk) then
			arg_38_1._atk = arg_38_1:getBuffValue(true, BattleData.PositiveType.lockAtk)
		end

		if arg_38_1._status == BattleData.CardStatus.board and (arg_38_1:isMonsterRare() or arg_38_1._type == Data.CardType.monster) then
			local c_cat = arg_38_1._category or (arg_38_1._info and arg_38_1._info._category)
			local c_nat = arg_38_1._nature or (arg_38_1._info and arg_38_1._info._nature)
			if c_cat == 1 and c_nat == 2 then
				local c_owner = arg_38_1._owner or arg_38_0
				local f_card = c_owner and c_owner._fieldCard
				if f_card and f_card._status == BattleData.CardStatus.field and (f_card._infoId == 21134 or f_card:hasSkillFast(7834)) then
					local my_g = #c_owner:getBattleCardsByType("G", Data.CardType.monster)
					local opp_g = (c_owner._opponent and #c_owner._opponent:getBattleCardsByType("G", Data.CardType.monster)) or 0
					local lht_atk = (my_g + opp_g) * 100
					if lht_atk > 0 then
						arg_38_1._atk = arg_38_1._atk + lht_atk
					end
				end
			end

			-- Skill 14775 (Uy Áp): Card 40743 reduces opponent monster ATK by 200 per Dragon on field & grave of both players
			local c_owner = arg_38_1._owner or arg_38_0
			local oppo = c_owner and c_owner._opponent
			if oppo then
				local debuff = oppo._dragonDebuffVal or 0
				if debuff > 0 then
					arg_38_1._atk = math.max(0, arg_38_1._atk - debuff)
				end
			end
		end

		local cardOwner = arg_38_1._owner or arg_38_0
		if B.isWitherOnField(cardOwner) and arg_38_1._status == BattleData.CardStatus.board and (arg_38_1:isMonster() or arg_38_1:isMonsterRare() or arg_38_1._type == Data.CardType.monster) then
			local isUndead = arg_38_1:isCategory(17) or (arg_38_1._info and arg_38_1._info._category == 17)
			if not isUndead then
				arg_38_1._atk = math.floor(arg_38_1._atk / 2)
			end
		end

		-- Cua dia nguc (30597 / 14813): Khi tren san, quai xac song phe ta nhan 500 atk
		if cardOwner and arg_38_1._status == BattleData.CardStatus.board and (arg_38_1:isMonster() or arg_38_1:isMonsterRare() or arg_38_1._type == Data.CardType.monster) then
			local isUndead = arg_38_1:isCategory(17) or (arg_38_1._info and arg_38_1._info._category == 17)
			if isUndead then
				local sCards = cardOwner:getBattleCardsByInfoId("S", 30597)
				local bCards = cardOwner:getBattleCardsByInfoId("B", 30597)
				if #sCards > 0 or #bCards > 0 then
					arg_38_1._atk = arg_38_1._atk + 500
				end
			end
		end

		arg_38_1._haloedMaxAtkInc = var_38_4
	end

	if arg_38_1:isMonsterRare() or arg_38_1._type == Data.CardType.boss and arg_38_1._info._isDeamon == 1 then
		for iter_38_26 = 1, #arg_38_1._skills do
			local var_38_33 = arg_38_1._skills[iter_38_26]

			var_38_33._level = math.min(var_38_33._maxLevel + var_38_10, CardHelper.getSkillMaxLevel(var_38_33._id))
		end
	end

	if var_38_14 ~= 0 then
		if arg_38_0._gem + var_38_14 > 3 then
			genInc = 3 - arg_38_0._gem
			arg_38_0._gem = 3
		else
			arg_38_0._gem = arg_38_0._gem + var_38_14
		end
	end

	if var_38_11 > 0 then
		arg_38_1:getOriginOwner()._opponent:addDamageScore(var_38_11)
	end

	lc.clearTable(arg_38_1._changed)

	if arg_38_1._atk ~= arg_38_1._old._atk then
		arg_38_1._changed._atk = arg_38_1._atk - arg_38_1._old._atk
	end

	if arg_38_1._type ~= Data.CardType.fortress then
		if arg_38_1._hp ~= nil and arg_38_1._hp ~= arg_38_1._old._hp then
			arg_38_1._changed._hp = arg_38_1._hp - arg_38_1._old._hp
		end
	elseif arg_38_1._hp ~= nil and arg_38_1._hp ~= arg_38_1._old._hp and arg_38_1._hp > 0 and arg_38_1._hp ~= arg_38_1._old._hp - var_38_11 then
		arg_38_1._changed._hp = arg_38_1._hp - arg_38_1._old._hp + var_38_11

		if arg_38_1._changed._hp > 0 then
			arg_38_1._hpAdded = arg_38_1._changed._hp

			arg_38_0:changeCardStatus(arg_38_1, arg_38_1._status, arg_38_1._status, BattleData.CardStatusVal.f2f_fortress_hp_added)
		end
	end

	if arg_38_1._type == Data.CardType.fortress then
		arg_38_1._lastAttackDamage = 0
	end

	local fortressHpDropped = arg_38_1._type == Data.CardType.fortress and arg_38_1._old._hp ~= nil and arg_38_1._hp < arg_38_1._old._hp
	if var_38_11 ~= 0 or fortressHpDropped then
		if var_38_11 == 0 and fortressHpDropped then
			var_38_11 = arg_38_1._old._hp - arg_38_1._hp
		end
		arg_38_1._changed._damage = var_38_11

		if arg_38_1._type == Data.CardType.fortress then
			arg_38_1._lastAttackDamage = var_38_11
			arg_38_1._lastDamage = var_38_11
			arg_38_1._lastDamageFromCard = var_38_12
			arg_38_1._lastDamageFromSkillId = var_38_13

			arg_38_0:changeCardStatus(arg_38_1, arg_38_1._status, arg_38_1._status, BattleData.CardStatusVal.f2f_fortress_damaged)
		end
	end

	if arg_38_1._atkCount ~= arg_38_1._old._atkCount then
		arg_38_1._changed._atkCount = arg_38_1._atkCount - arg_38_1._old._atkCount
	end

	if arg_38_1._actionCount ~= arg_38_1._old._actionCount then
		arg_38_1._changed._actionCount = arg_38_1._actionCount - arg_38_1._old._actionCount
	end

	if arg_38_1._skillLevelInc ~= arg_38_1._old._skillLevelInc then
		arg_38_1._changed._skillLevelInc = arg_38_1._skillLevelInc - arg_38_1._old._skillLevelInc
	end

	if var_38_14 ~= 0 then
		arg_38_1._changed._gemInc = var_38_14
	end

	if var_38_15 ~= 0 then
		arg_38_1._changed._gemFrozen = var_38_15
	end

	if var_38_0 ~= nil then
		arg_38_1._changed._rebirth = var_38_0
	end

	if var_38_16 ~= 0 then
		arg_38_1._changed._incBookRound = var_38_16
	end

	if var_38_17 ~= 0 then
		arg_38_1._changed._posChange = var_38_17
	end

	if arg_38_1:isMonsterRare() or arg_38_1._type == Data.CardType.monster or arg_38_1._type == Data.CardType.boss and arg_38_1._info._isDeamon == 1 or arg_38_1._type == Data.CardType.fortress or arg_38_1._type == Data.CardType.magic or arg_38_1._type == Data.CardType.trap then
		if B.isStatusChange(BattleData.NegativeType.count, arg_38_1._negativeStatus, arg_38_1._negativeValues, arg_38_1._old._negativeStatus, arg_38_1._old._negativeValues) then
			arg_38_1._changed._negativeStatus = {}
		end

		if B.isStatusChange(BattleData.PositiveType.count, arg_38_1._positiveStatus, arg_38_1._positiveValues, arg_38_1._old._positiveStatus, arg_38_1._old._positiveValues) then
			arg_38_1._changed._positiveStatus = {}
		end
	end

	if arg_38_1._hp ~= arg_38_1._old._hp then
		arg_38_0:battleLog("[BATTLE] %s\tHP\t%4d -> %4d", Str(arg_38_1._type ~= Data.CardType.fortress and arg_38_1._info._nameSid or STR.FORTRESS), arg_38_1._old._hp, arg_38_1._hp)
	end

	if arg_38_1._atk ~= arg_38_1._old._atk then
		arg_38_0:battleLog("[BATTLE] %s\tATK\t%4d -> %4d", Str(arg_38_1._info._nameSid), arg_38_1._old._atk, arg_38_1._atk)
	end

	return next(arg_38_1._changed) ~= nil
end

function var_0_0.genAttackTarget(arg_40_0, arg_40_1)
	if arg_40_1._atkTarget ~= nil then
		arg_40_1._atkTargets = {
			arg_40_1._atkTarget
		}
		if (arg_40_1._atkTarget:isInfoId(12326) or arg_40_1._atkTarget:hasSkillFast(14708)) and arg_40_1:isMonsterRare() then
			arg_40_1._mark9617 = true
			arg_40_1._isCardSkillDisabledInRound = true
			if arg_40_1.disableUnderSkills then
				arg_40_1:disableUnderSkills()
			end
			arg_40_0:incNegativeStatus(arg_40_1, {
				BattleData.NegativeType.disableSkill
			}, false, arg_40_1._atkTarget._id, 14708, Data.SkillMode.once)
			arg_40_0:incNegativeValue(arg_40_1, BattleData.NegativeType.disableSkill, 2, Data.AggregateType.max, arg_40_1._atkTarget._id, 14708, Data.SkillMode.once)
		end

		return
	end

	if arg_40_0._opponent._isDeamon then
		arg_40_1._atkTargets = {
			arg_40_0._opponent._fortress
		}

		return
	end

	local var_40_0 = arg_40_0._opponent:getBoardCards()

	if arg_40_1._type == Data.CardType.boss and arg_40_1._info._isAttackAll == 1 then
		if #var_40_0 > 0 then
			arg_40_1._atkTargets = var_40_0
		else
			arg_40_1._atkTargets = {
				arg_40_0._opponent._fortress
			}
		end

		return
	end

	if arg_40_1._negativeStatus[BattleData.NegativeType.chaosFortress] then
		arg_40_1._atkTargets = {
			arg_40_0._fortress
		}

		return
	end

	if arg_40_1._negativeStatus[BattleData.NegativeType.chaosMonster] then
		local var_40_1 = arg_40_0:randomOne(arg_40_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_40_1))

		arg_40_1._atkTargets = {
			var_40_1
		}

		return
	end

	if arg_40_1._negativeStatus[BattleData.NegativeType.chaos] then
		local var_40_2 = {}
		local var_40_3 = arg_40_0._opponent:getBoardCards()

		for iter_40_0 = 1, #var_40_3 do
			local var_40_4 = var_40_3[iter_40_0]

			if arg_40_1:canAttackTarget(var_40_4, false) then
				var_40_2[#var_40_2 + 1] = var_40_4
			end
		end

		local var_40_5 = arg_40_0:randomOne(var_40_2)

		arg_40_1._atkTargets = {
			var_40_5
		}

		return
	end

	if arg_40_1._positiveStatus[BattleData.PositiveType.betray] and #selfAliveBoardCards > 0 then
		local var_40_6 = arg_40_0:randomOne(selfAliveBoardCards)

		arg_40_1._atkTargets = {
			var_40_6
		}

		return
	end

	for iter_40_1 = 1, #var_40_0 do
		local var_40_7 = var_40_0[iter_40_1]

		if var_40_7._negativeStatus[BattleData.NegativeType.targeted] then
			arg_40_1._atkTargets = {
				var_40_7
			}

			return
		end
	end

	local var_40_8

	if arg_40_1._positiveStatus[BattleData.PositiveType.hunt] then
		var_40_8 = B.getMinHpCard(arg_40_0._opponent:getBoardCards())
	end

	if var_40_8 == nil and not arg_40_1._positiveStatus[BattleData.PositiveType.ignore_irony] then
		for iter_40_2 = 1, #var_40_0 do
			local var_40_9 = var_40_0[iter_40_2]

			if var_40_9._positiveStatus[BattleData.PositiveType.irony] and var_40_9:getBuffValue(true, BattleData.PositiveType.irony) == 0 then
				var_40_8 = var_40_9

				break
			end
		end
	end

	if var_40_8 == nil and (arg_40_1._positiveStatus[BattleData.PositiveType.siege] or (arg_40_1.canAttackDirectly and arg_40_1:canAttackDirectly())) then
		var_40_8 = arg_40_0._opponent._fortress
	end

	local var_40_10

	if arg_40_1._type == Data.CardType.boss then
		var_40_10 = arg_40_0._opponent:getBoardCards()[1] or arg_40_0._opponent._fortress
	elseif arg_40_1._owner._isDeamon then
		local var_40_11 = arg_40_0._opponent:getBoardCards()

		var_40_10 = arg_40_1._pos == 6 and var_40_11[#var_40_11] or var_40_11[1]

		if var_40_8 == nil and (not B.isAlive(var_40_10) or var_40_10._positiveStatus[BattleData.PositiveType.invisible] and not arg_40_1._positiveStatus[BattleData.PositiveType.ignore_invisible]) then
			var_40_8 = var_40_0[1] or arg_40_0._opponent._fortress
		end
	else
		var_40_10 = arg_40_0._opponent._boardCards[arg_40_1._pos]

		if var_40_8 == nil and (not B.isAlive(var_40_10) or var_40_10._positiveStatus[BattleData.PositiveType.invisible] and not arg_40_1._positiveStatus[BattleData.PositiveType.ignore_invisible]) then
			var_40_8 = var_40_0[1] or arg_40_0._opponent._fortress
		end
	end

	if var_40_8 == nil then
		var_40_8 = var_40_10
	end

	if var_40_8:isMonsterRare() and not arg_40_1._positiveStatus[BattleData.PositiveType.ignore_irony] and not var_40_8._positiveStatus[BattleData.PositiveType.irony] then
		for iter_40_3 = 1, #var_40_0 do
			local var_40_12 = var_40_0[iter_40_3]

			if var_40_12._positiveStatus[BattleData.PositiveType.irony] and var_40_12:getBuffValue(true, BattleData.PositiveType.irony) == var_40_8._info._category then
				var_40_8 = var_40_12

				break
			end
		end
	end

	if var_40_8:isMonsterRare() and not arg_40_1._positiveStatus[BattleData.PositiveType.ignore_irony] and not var_40_8._positiveStatus[BattleData.PositiveType.irony] then
		for iter_40_4 = 1, #var_40_0 do
			local var_40_13 = var_40_0[iter_40_4]

			if var_40_13._positiveStatus[BattleData.PositiveType.irony] and var_40_13:getBuffValue(true, BattleData.PositiveType.irony) == var_40_8._info._keyword + 65536 then
				var_40_8 = var_40_13

				break
			end
		end
	end

	if arg_40_1._negativeStatus[BattleData.NegativeType.mistrust] and arg_40_0:getRandom() * 100 <= arg_40_1._negativeValues[BattleData.NegativeType.mistrust] then
		local var_40_14 = {
			arg_40_0._opponent._fortress
		}

		for iter_40_5 = 1, #var_40_0 do
			table.insert(var_40_14, var_40_0[iter_40_5])
		end

		var_40_8 = arg_40_0:randomOneTryExcept(var_40_14, var_40_8)
	end

	arg_40_1._atkTargets = {
		var_40_8
	}

	if var_40_8 and (var_40_8:isInfoId(12326) or var_40_8:hasSkillFast(14708)) and arg_40_1:isMonsterRare() then
		arg_40_1._mark9617 = true
		arg_40_1._isCardSkillDisabledInRound = true
		if arg_40_1.disableUnderSkills then
			arg_40_1:disableUnderSkills()
		end
		arg_40_0:incNegativeStatus(arg_40_1, {
			BattleData.NegativeType.disableSkill
		}, false, var_40_8._id, 14708, Data.SkillMode.once)
		arg_40_0:incNegativeValue(arg_40_1, BattleData.NegativeType.disableSkill, 2, Data.AggregateType.max, var_40_8._id, 14708, Data.SkillMode.once)
	end
end

function var_0_0.getActionPlayer(arg_41_0)
	return arg_41_0._stepStatus ~= BattleData.Status.wait_opponent and arg_41_0 or arg_41_0._opponent
end

function var_0_0.getActionCard(arg_42_0)
	return arg_42_0._actionCard or arg_42_0._opponent._actionCard
end

function var_0_0.getEvents(arg_43_0, arg_43_1)
	local var_43_0 = {}
	local var_43_1 = arg_43_0._battleEvent:getSatisfiedEvents(arg_43_1)

	for iter_43_0 = 1, #var_43_1 do
		table.insert(var_43_0, var_43_1[iter_43_0])
	end

	if arg_43_1 == BattleEvent.EventType.battle_start or arg_43_1 == BattleEvent.EventType.battle_end or arg_43_1 == BattleEvent.EventType.card_deal or arg_43_1 == BattleEvent.EventType.card_use or arg_43_1 == BattleEvent.EventType.card_die then
		local var_43_2 = arg_43_0._opponent._battleEvent:getSatisfiedEvents(arg_43_1)

		for iter_43_1 = 1, #var_43_2 do
			table.insert(var_43_0, var_43_2[iter_43_1])
		end
	end

	return var_43_0
end

function var_0_0.getIsEventSatisfied(arg_44_0, arg_44_1)
	return arg_44_0._battleEvent:isEventSatisfied(arg_44_1)
end

function var_0_0.getActionEffect(arg_45_0, arg_45_1, arg_45_2)
	return arg_45_1._info._effect[arg_45_2], arg_45_1._info._effectValue[arg_45_2]
end

function var_0_0.getActionStory(arg_46_0, arg_46_1, arg_46_2)
	return arg_46_1._info._storyId[arg_46_2]
end

function var_0_0.getPoisonDamage(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = 0
	local var_47_1 = arg_47_1._owner._opponent:getBoardCards()

	for iter_47_0 = 1, #var_47_1 do
		local var_47_2 = var_47_1[iter_47_0]

		if var_47_2._positiveStatus[BattleData.PositiveType.poisonMaster] then
			var_47_0 = var_47_0 + var_47_2:getBuffValue(true, BattleData.PositiveType.poisonMaster)
		end
	end

	return arg_47_2 + var_47_0
end

function var_0_0.accountDamage(arg_48_0, arg_48_1, arg_48_2)
	if not B.isAlive(arg_48_1) then
		return 0
	end

	local var_48_0 = 0

	for iter_48_0 = 1, #arg_48_1._underSkills do
		local var_48_1 = arg_48_1._underSkills[iter_48_0]

		if var_48_1._disabled ~= true and var_48_1._damage ~= nil then
			local var_48_2 = arg_48_0:getCardById(var_48_1._cid)

			if not arg_48_2 or not var_48_2 or var_48_2._owner ~= arg_48_0 then
				var_48_0 = var_48_0 + var_48_1._damage
			end
		end
	end

	return var_48_0
end

function var_0_0.getHaloSkills(arg_49_0, arg_49_1)
	local var_49_0 = {}
	local var_49_1 = B.mergeTable({
		arg_49_0:getBattleCardsByBuff("BCSD", true, arg_49_1),
		arg_49_0._opponent:getBattleCardsByBuff("BCSD", true, arg_49_1)
	})

	for iter_49_0 = 1, #var_49_1 do
		local var_49_2 = var_49_1[iter_49_0]
		local var_49_3 = var_49_2:getBuffValue(true, arg_49_1)

		for iter_49_1 = 1, #var_49_3 do
			for iter_49_2 = 1, #var_49_2._skills do
				if var_49_2._skills[iter_49_2]._id == var_49_3[iter_49_1] then
					var_49_0[#var_49_0 + 1] = var_49_2._skills[iter_49_2]

					break
				end
			end
		end
	end

	return var_49_0
end

function var_0_0.getHaloModeSkills(arg_50_0, arg_50_1)
	local var_50_0, var_50_1 = arg_50_0:getBattleCardsBySkillMode("BSD", arg_50_1)
	local var_50_2, var_50_3 = arg_50_0:getBattleCardsBySkillModes("G", {
		Data.SkillMode.in_grave,
		arg_50_1
	})
	local var_50_4, var_50_5 = arg_50_0:getBattleCardsBySkillModes("H", {
		Data.SkillMode.in_hand,
		arg_50_1
	})
	local var_50_6, var_50_7 = arg_50_0:getBattleCardsBySkillModes("GL", {
		Data.SkillMode.in_gl,
		arg_50_1
	})
	local var_50_8 = B.mergeTable({
		var_50_1,
		var_50_3,
		var_50_5,
		var_50_7
	})

	if arg_50_1 == Data.SkillMode.halo_cost or arg_50_1 == Data.SkillMode.halo_oppo_cost then
		local var_50_9 = arg_50_0:getBattleCardsByInfoId("R", 40654)[1]

		if var_50_9 ~= nil then
			local var_50_10 = var_50_9:getSkillById(13905)

			var_50_8[#var_50_8 + 1] = var_50_10
		end

		local var_50_11 = arg_50_0:getBattleCardsByInfoId("R", 40688)[1]

		if var_50_11 ~= nil then
			local var_50_12 = var_50_11:getSkillById(13905)

			var_50_8[#var_50_8 + 1] = var_50_12
		end

		if arg_50_1 == Data.SkillMode.halo_cost then
			local var_50_13 = arg_50_0:getBattleCardsByInfoId("R", 40700)[1]

			if var_50_13 ~= nil then
				local var_50_14 = var_50_13:getSkillById(14361)

				var_50_8[#var_50_8 + 1] = var_50_14
			end

			local var_50_15 = arg_50_0:getBattleCardsByInfoId("R", 40707)[1]

			if var_50_15 ~= nil then
				local var_50_16 = var_50_15:getSkillById(14431)

				var_50_8[#var_50_8 + 1] = var_50_16
			end

			local var_50_17 = arg_50_0:getBattleCardsByInfoId("R", 40714)

			for iter_50_0 = 1, #var_50_17 do
				local var_50_18 = var_50_17[iter_50_0]:getSkillById(14521)

				var_50_8[#var_50_8 + 1] = var_50_18
			end
		end
	elseif arg_50_1 == Data.SkillMode.halo_bcs2_ then
		local var_50_19 = arg_50_0:getBattleCardsByInfoId("R", 40679)[1]

		if var_50_19 ~= nil then
			local var_50_20 = var_50_19:getSkillById(14151)

			var_50_8[#var_50_8 + 1] = var_50_20
		end
	elseif arg_50_1 == Data.SkillMode.halo_oppo__2h then
		local var_50_21 = arg_50_0:getBattleCardsByInfoId("R", 40693)[1]

		if var_50_21 ~= nil then
			local var_50_22 = var_50_21:getSkillById(14249)

			var_50_8[#var_50_8 + 1] = var_50_22
		end
	elseif arg_50_1 == Data.SkillMode.halo_oppo_using then
		local var_50_23 = arg_50_0:getBattleCardsByInfoId("R", 40694)[1]

		if var_50_23 ~= nil then
			local var_50_24 = var_50_23:getSkillById(14255)

			var_50_8[#var_50_8 + 1] = var_50_24
		end

		local var_50_kysi = arg_50_0:getBattleCardsByInfoId("R", 40746)[1]

		if var_50_kysi ~= nil then
			local var_50_sk = var_50_kysi:getSkillById(14788)

			if var_50_sk then
				var_50_8[#var_50_8 + 1] = var_50_sk
			end
		end

		local var_50_creepers = arg_50_0:getBattleCardsByInfoId("B", 12337)
		for iter_creeper = 1, #var_50_creepers do
			local var_creeper_sk = var_50_creepers[iter_creeper]:getSkillById(14792)
			if var_creeper_sk then
				var_50_8[#var_50_8 + 1] = var_creeper_sk
			end
		end
	end

	if arg_50_1 == Data.SkillMode.halo_oppo_before_magic_trap and arg_50_0._mark14222 then
		local var_50_25 = arg_50_0._mark14222:getSkillById(14222)

		var_50_8[#var_50_8 + 1] = var_50_25
	end

	return var_50_8
end

function var_0_0.isHaloUnderSkillDisabledByShield(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_2._mode ~= Data.SkillMode.halo then
		return false
	end

	local isThacSamAwakened = (arg_51_1._infoId == 40730) and (arg_51_1._tsAwakened or (arg_51_1:getBuffValue(true, BattleData.PositiveType.xyzMark) or 0) == 0)

	if not isThacSamAwakened and (Data._skillInfo[arg_51_2._sid]._isIgnoreDefend == 1 or Data._skillInfo[arg_51_2._sid]._isIgnoreDefend == 9) then
		return false
	end

	local var_51_0 = arg_51_0:getCardById(arg_51_2._cid)

	if var_51_0 == nil then
		if isThacSamAwakened and (arg_51_1:hasBuff(true, BattleData.PositiveType.shieldOppoMonster) or arg_51_1:hasBuff(true, BattleData.PositiveType.shieldOppoMagic) or arg_51_1:hasBuff(true, BattleData.PositiveType.shieldOppoTrap)) then
			return true
		end
		return false
	end

	if var_51_0 == arg_51_1 or arg_51_2._cid == arg_51_1._id or arg_51_2._sid == 14632 or arg_51_2._sid == 14719 or arg_51_2._sid == 14777 or arg_51_2._sid == 14787 or (arg_51_2._sid >= 14706 and arg_51_2._sid <= 14710) then
		return false
	end

	local isFromOppo = (arg_51_1._owner ~= var_51_0._owner)

	if (arg_51_1:isInfoId(40728) or arg_51_1:hasSkillFast(14691)) and arg_51_1:canCastMonsterSkill() and isFromOppo then
		local owner = arg_51_1._owner
		if owner and owner._fortress then
			arg_51_0:addDamage(owner._fortress, 500, arg_51_2._cid, arg_51_2._sid, arg_51_2._mode)
		end
		return true
	end

	if var_51_0._type == Data.CardType.monster or var_51_0._type == Data.CardType.rare then
		if isFromOppo and arg_51_1:hasBuff(true, BattleData.PositiveType.shieldMonster) then
			return true
		end

		if isFromOppo then
			if arg_51_1:hasBuff(true, BattleData.PositiveType.shieldExMonster) or arg_51_1:hasBuff(true, BattleData.PositiveType.shieldHaloMonster) then
				return true
			end

			if (isThacSamAwakened or (Data._skillInfo[arg_51_2._sid]._isIgnoreDefend ~= 7 and Data._skillInfo[arg_51_2._sid]._isIgnoreDefend ~= 8)) and (arg_51_1:hasBuff(true, BattleData.PositiveType.shieldOppoMonster) or arg_51_1:hasBuff(true, BattleData.PositiveType.shieldHaloOppoMonster)) then
				return true
			end
		end
	elseif var_51_0._type == Data.CardType.magic then
		if arg_51_1:hasBuff(true, BattleData.PositiveType.shieldMagic) then
			return true
		end

		if isFromOppo then
			if arg_51_1:hasBuff(true, BattleData.PositiveType.shieldExMagic) or arg_51_1:hasBuff(true, BattleData.PositiveType.shieldHaloMagic) then
				return true
			end

			if (isThacSamAwakened or (Data._skillInfo[arg_51_2._sid]._isIgnoreDefend ~= 7 and Data._skillInfo[arg_51_2._sid]._isIgnoreDefend ~= 8)) and (arg_51_1:hasBuff(true, BattleData.PositiveType.shieldOppoMagic) or arg_51_1:hasBuff(true, BattleData.PositiveType.shieldHaloOppoMagic)) then
				return true
			end
		end
	elseif var_51_0._type == Data.CardType.trap then
		if arg_51_1:hasBuff(true, BattleData.PositiveType.shieldTrap) then
			return true
		end

		if isFromOppo then
			if arg_51_1:hasBuff(true, BattleData.PositiveType.shieldExTrap) or arg_51_1:hasBuff(true, BattleData.PositiveType.shieldHaloTrap) then
				return true
			end

			if (isThacSamAwakened or (Data._skillInfo[arg_51_2._sid]._isIgnoreDefend ~= 7 and Data._skillInfo[arg_51_2._sid]._isIgnoreDefend ~= 8)) and (arg_51_1:hasBuff(true, BattleData.PositiveType.shieldOppoTrap) or arg_51_1:hasBuff(true, BattleData.PositiveType.shieldHaloOppoTrap)) then
				return true
			end
		end
	end

	if var_51_0._type == Data.CardType.magic and var_51_0._owner ~= arg_51_1._owner and arg_51_1:hasSkills({
		6163
	}) then
		return true
	end

	return false
end

function var_0_0.addRoundDuration(arg_52_0)
	if not arg_52_0._isOnlinePvp or not arg_52_0._isNewRound then
		return
	end

	local var_52_0 = arg_52_0._round == 1 and arg_52_0._roundTimeDelta1 or arg_52_0._roundTimeDelta
	if not var_52_0 or var_52_0 <= 0 then
		var_52_0 = 6
	end

	local var_52_1 = 240

	if ClientData._battleRoundStartInfo then
		local curTotal = ClientData._battleRoundStartInfo._endTime - ClientData._battleRoundStartInfo._beginTime
		local var_52_2 = math.min(var_52_1, curTotal + var_52_0)
		ClientData._battleRoundStartInfo._endTime = ClientData._battleRoundStartInfo._beginTime + var_52_2
	end
end

function var_0_0.getCardFromPile(arg_53_0)
	return arg_53_0._pileCards and arg_53_0._pileCards[1]
end

function var_0_0.getGraveCards(arg_54_0)
	return arg_54_0._graveCards or {}
end

return var_0_0
