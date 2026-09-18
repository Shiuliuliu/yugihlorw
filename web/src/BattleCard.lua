local var_0_0 = class("BattleCard")

BattleCard = var_0_0
var_0_0.LEFT_POS_DEAMON = {
	0,
	1,
	0,
	0,
	0,
	2
}
var_0_0.RIGHT_POS_DEAMON = {
	2,
	6,
	0,
	0,
	0,
	0
}

function var_0_0.ctor(arg_1_0, ...)
	arg_1_0:init(...)
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = false
	local var_2_1 = false
	local var_2_2 = 0

	arg_2_0._srcInfoId = arg_2_1

	local var_2_3, var_2_4, var_2_5

	arg_2_1, var_2_3, var_2_4, var_2_5 = Data.removeAdditional(arg_2_1)
	arg_2_0._infoId = arg_2_1
	arg_2_0._isGold = var_2_4
	arg_2_0._extraSid = var_2_5
	arg_2_0._level = arg_2_2
	arg_2_0._type = Data.getType(arg_2_1)
	arg_2_0._owner = arg_2_3
	arg_2_0._underSkills = {}
	arg_2_0._castedTargets = {}

	if arg_2_0._type == Data.CardType.monster then
		arg_2_0:initMonster()
	elseif arg_2_0._type == Data.CardType.magic then
		arg_2_0:initMagic()
	elseif arg_2_0._type == Data.CardType.trap then
		arg_2_0:initTrap()
	elseif arg_2_0._type == Data.CardType.rare then
		arg_2_0:initRare()
	elseif arg_2_0._type == Data.CardType.boss then
		arg_2_0:initBoss()
	end
end

function var_0_0.initMonster(arg_3_0)
	arg_3_0._originInfoId = arg_3_0._infoId
	arg_3_0._info = Data._monsterInfo[arg_3_0._infoId]
	arg_3_0._mark14157 = nil
end

function var_0_0.initMagic(arg_4_0)
	arg_4_0._info = Data._magicInfo[arg_4_0._infoId]
end

function var_0_0.initTrap(arg_5_0)
	arg_5_0._info = Data._trapInfo[arg_5_0._infoId]
end

function var_0_0.initRare(arg_6_0)
	arg_6_0._originInfoId = arg_6_0._infoId
	arg_6_0._info = Data._rareInfo[arg_6_0._infoId]

	if arg_6_0:isLink() then
		arg_6_0._linkCountNode = BoolNode.compile(arg_6_0._info._linkCount, arg_6_0)

		if arg_6_0._info._linkCandidate ~= "0" and arg_6_0._info._linkCandidate ~= "0.0" then
			arg_6_0._linkCandidateNode = BoolNode.compile(arg_6_0._info._linkCandidate, arg_6_0)
		end

		if arg_6_0._info._linkAllCandidates ~= "0" and arg_6_0._info._linkAllCandidates ~= "0.0" then
			arg_6_0._linkAllCandidatesNode = BoolNode.compile(arg_6_0._info._linkAllCandidates, arg_6_0)
		end

		if arg_6_0._info._linkSelectedCandidates ~= "0" and arg_6_0._info._linkSelectedCandidates ~= "0.0" then
			arg_6_0._linkSelectedCandidatesNode = BoolNode.compile(arg_6_0._info._linkSelectedCandidates, arg_6_0)
		end
	end
end

function var_0_0.initBoss(arg_7_0)
	arg_7_0._info = Data._bossInfo[arg_7_0._infoId]
end

function var_0_0.resetOnce(arg_8_0)
	arg_8_0._skillMaxLevelInc = {}
	arg_8_0._dieCount = 0
	arg_8_0._boardCount = 0
	arg_8_0._summonedByMerge = nil
	arg_8_0._summonedBySync = nil
	arg_8_0._summonedByXYZ = nil
	arg_8_0._summonedByLink = nil
	arg_8_0._saved = {}
	arg_8_0._castedSkills = {}
	arg_8_0._underSkills = {}
	arg_8_0._binds = {}
	arg_8_0._changed = {}
	arg_8_0._old = {
		_positiveStatus = {},
		_positiveValues = {},
		_negativeStatus = {},
		_negativeValues = {}
	}

	arg_8_0:reset()
end

function var_0_0.baseReset(arg_9_0, arg_9_1)
	arg_9_0._skills = {}

	if arg_9_0._type == Data.CardType.monster then
		arg_9_0:baseResetMonsterRare(arg_9_1)
	elseif arg_9_0._type == Data.CardType.magic then
		arg_9_0:baseResetMagic()
	elseif arg_9_0._type == Data.CardType.trap then
		arg_9_0:baseResetTrap()
	elseif arg_9_0._type == Data.CardType.rare then
		arg_9_0:baseResetMonsterRare()
	elseif arg_9_0._type == Data.CardType.boss then
		arg_9_0:baseResetBoss()
	elseif arg_9_0._type == Data.CardType.fortress then
		arg_9_0:baseResetFortress()
	end

	arg_9_0:testSkills()
end

function var_0_0.baseResetMonsterRare(arg_10_0, arg_10_1)
	if arg_10_1 ~= nil and arg_10_1 > 0 and Data._monsterInfo[Data.getRebirthId(arg_10_0._originInfoId, arg_10_1)] ~= nil then
		arg_10_0._rebirth = arg_10_1
		arg_10_0._infoId = Data.getRebirthId(arg_10_0._originInfoId, arg_10_1)
	else
		arg_10_0._rebirth = 0
		arg_10_0._infoId = arg_10_0._originInfoId
	end

	arg_10_0._info = arg_10_0._type == Data.CardType.monster and Data._monsterInfo[arg_10_0._infoId] or Data._rareInfo[arg_10_0._infoId]
	arg_10_0._maxAtk = arg_10_0._info._atk[arg_10_0._level]
	arg_10_0._maxHp = arg_10_0._info._hp[arg_10_0._level]

	arg_10_0:baseResetSkills()
end

function var_0_0.baseResetMagic(arg_11_0)
	arg_11_0:baseResetSkills()
end

function var_0_0.baseResetTrap(arg_12_0)
	arg_12_0:baseResetSkills()
end

function var_0_0.baseResetBoss(arg_13_0)
	arg_13_0._maxAtk = arg_13_0._info._atk
	arg_13_0._maxHp = arg_13_0._info._hp

	for iter_13_0 = 1, #arg_13_0._info._skillId do
		local var_13_0 = arg_13_0._info._skillId[iter_13_0]

		if var_13_0 == 0 then
			break
		end

		local var_13_1 = Data._skillInfo[var_13_0]
		local var_13_2 = {
			_id = var_13_0,
			_maxLevel = arg_13_0._info._skillLevelSeq[iter_13_0],
			_modes = var_13_1._modes,
			_priority = var_13_1._priority,
			_count = var_13_1._count,
			_owner = arg_13_0,
			_stepRound = arg_13_0._info._stepRound[iter_13_0] or 0,
			_startRound = arg_13_0._info._startRound[iter_13_0] or 0
		}

		table.insert(arg_13_0._skills, var_13_2)
	end
end

function var_0_0.baseResetFortress(arg_14_0)
	arg_14_0._maxHp = arg_14_0._updateInitHp or 99999999
	arg_14_0._status = BattleData.CardStatus.fortress
end

function var_0_0.reset(arg_15_0)
	arg_15_0:baseReset()
	arg_15_0:resetByType()
end

function var_0_0.resetByType(arg_16_0)
	lc.clearTable(arg_16_0._castedSkills)
	lc.clearTable(arg_16_0._underSkills)
	lc.clearTable(arg_16_0._binds)
	lc.clearTable(arg_16_0._changed)

	if arg_16_0._type == Data.CardType.monster then
		arg_16_0:resetMonster()
	elseif arg_16_0._type == Data.CardType.magic then
		arg_16_0:resetMagic()
	elseif arg_16_0._type == Data.CardType.trap then
		arg_16_0:resetTrap()
	elseif arg_16_0._type == Data.CardType.rare then
		arg_16_0:resetRare()
	elseif arg_16_0._type == Data.CardType.boss then
		arg_16_0:resetBoss()
	elseif arg_16_0._type == Data.CardType.fortress then
		arg_16_0:resetFortress()
	end

	arg_16_0._mark2267 = nil
	arg_16_0._mark2694 = nil
	arg_16_0._mark2702 = nil
	arg_16_0._mark2704 = nil
	arg_16_0._mark2732 = nil
	arg_16_0._mark3642 = nil
end

function var_0_0.resetMonster(arg_17_0)
	arg_17_0:resetHp()
	arg_17_0:resetAtk()

	arg_17_0._actionCount = 1
	arg_17_0._actionIndex = 1
	arg_17_0._roundBeginActionCount = 1
	arg_17_0._roundBeginActionIndex = 1
	arg_17_0._atkCount = 1
	arg_17_0._isBorrowed = false

	arg_17_0:resetBuff()

	arg_17_0._monsterTarget = nil

	arg_17_0:resetSkills()

	arg_17_0._skillLevelInc = 0
	arg_17_0._mark3521 = nil
end

function var_0_0.resetMagic(arg_18_0)
	arg_18_0._actionCount = 1
	arg_18_0._actionIndex = 1
	arg_18_0._roundBeginActionCount = 1
	arg_18_0._roundBeginActionIndex = 1

	arg_18_0:resetBuff()

	arg_18_0._magicTarget = nil

	arg_18_0:resetSkills()

	arg_18_0._skillLevelInc = 0
end

function var_0_0.resetTrap(arg_19_0)
	arg_19_0._actionCount = 1
	arg_19_0._actionIndex = 1
	arg_19_0._roundBeginActionCount = 1
	arg_19_0._roundBeginActionIndex = 1

	arg_19_0:resetBuff()

	arg_19_0._trapTarget = nil

	arg_19_0:resetSkills()

	arg_19_0._skillLevelInc = 0
end

function var_0_0.resetRare(arg_20_0)
	arg_20_0:resetMonster()
end

function var_0_0.resetBoss(arg_21_0)
	arg_21_0:resetMonster()
end

function var_0_0.resetFortress(arg_22_0)
	arg_22_0:resetHp()
	arg_22_0:resetBuff()
end

function var_0_0.saveAndReset(arg_23_0)
	local var_23_0 = arg_23_0:saveExtraSkills()
	local var_23_1 = arg_23_0:saveSkillCastTimes()

	arg_23_0:reset()
	arg_23_0:loadSkillCastTimes(var_23_1)
	arg_23_0:loadExtraSkills(var_23_0)
end

function var_0_0.resetCardWhenRoundBegin(arg_24_0)
	if arg_24_0._mark5127 or arg_24_0._mark5207 or arg_24_0._mark3832 or arg_24_0._mark3921 or arg_24_0._mark6222 or arg_24_0._mark6346 or arg_24_0._mark6368 or arg_24_0._mark9226 or arg_24_0._mark1142 or arg_24_0._mark14145 or arg_24_0._isCardSkillDisabledInRound or arg_24_0:hasSkills({
		6177,
		6178,
		6179,
		6381,
		2368,
		7190,
		7202
	}) then
		B._lastAccount = nil
	end

	arg_24_0._isCardSkillDisabledInRound = nil
	arg_24_0._canNotBeLinked = nil
	arg_24_0._option2016 = nil
	arg_24_0._option2017 = {}
	arg_24_0._mark1080 = nil
	arg_24_0._mark1099 = nil
	arg_24_0._mark1102 = nil
	arg_24_0._mark1104 = nil
	arg_24_0._mark1123 = nil
	arg_24_0._mark1123_2 = nil
	arg_24_0._mark1142 = nil
	arg_24_0._mark2093 = nil
	arg_24_0._mark2480 = nil
	arg_24_0._mark3447 = nil
	arg_24_0._mark3491 = nil
	arg_24_0._mark3515 = nil
	arg_24_0._mark3592 = nil
	arg_24_0._mark3667 = nil
	arg_24_0._mark3748 = nil
	arg_24_0._mark3832 = nil
	arg_24_0._mark3921 = nil
	arg_24_0._mark3921_2 = nil
	arg_24_0._mark3923 = nil
	arg_24_0._mark3930 = nil
	arg_24_0._mark3937 = nil
	arg_24_0._mark3977 = nil
	arg_24_0._mark3990 = nil
	arg_24_0._mark4191 = nil
	arg_24_0._mark4202 = nil
	arg_24_0._mark4224 = nil
	arg_24_0._mark4282 = nil
	arg_24_0._mark4329 = nil
	arg_24_0._mark4400 = nil
	arg_24_0._mark4415 = nil
	arg_24_0._mark4419 = nil
	arg_24_0._mark4493 = nil
	arg_24_0._mark4513 = nil
	arg_24_0._mark4515 = nil
	arg_24_0._mark4532 = nil
	arg_24_0._mark4814 = nil
	arg_24_0._mark4873 = nil
	arg_24_0._mark4990 = nil
	arg_24_0._mark4999 = nil
	arg_24_0._mark5127 = nil
	arg_24_0._mark5179 = {}
	arg_24_0._mark5198 = nil
	arg_24_0._mark5207 = nil
	arg_24_0._mark5260 = nil
	arg_24_0._mark5272 = nil
	arg_24_0._mark5426 = nil
	arg_24_0._mark5458 = nil
	arg_24_0._mark5531 = nil
	arg_24_0._mark5574 = nil
	arg_24_0._mark8011 = nil
	arg_24_0._mark8132 = nil
	arg_24_0._mark6190 = nil
	arg_24_0._mark6219 = nil
	arg_24_0._mark6222 = nil
	arg_24_0._mark6243 = nil
	arg_24_0._mark6346 = nil
	arg_24_0._mark6353 = nil
	arg_24_0._mark6368 = nil
	arg_24_0._mark6377 = nil
	arg_24_0._mark6387 = nil
	arg_24_0._mark6413 = nil
	arg_24_0._mark6420 = nil
	arg_24_0._mark6431 = nil
	arg_24_0._mark6474 = nil
	arg_24_0._mark6485 = nil
	arg_24_0._mark6509 = nil
	arg_24_0._mark6514 = nil
	arg_24_0._mark6516 = nil
	arg_24_0._mark6564 = nil
	arg_24_0._mark6572 = nil
	arg_24_0._mark6578 = nil
	arg_24_0._mark6612 = nil
	arg_24_0._mark6619 = nil
	arg_24_0._mark6637 = nil
	arg_24_0._mark6681 = nil
	arg_24_0._mark6720 = nil
	arg_24_0._mark6745 = nil
	arg_24_0._mark6747 = nil
	arg_24_0._mark6822 = nil
	arg_24_0._mark6863 = nil
	arg_24_0._mark6896 = nil
	arg_24_0._mark6901 = nil
	arg_24_0._mark6944 = nil
	arg_24_0._mark2118 = nil
	arg_24_0._mark2190 = nil
	arg_24_0._mark2194 = nil
	arg_24_0._mark2292 = nil
	arg_24_0._mark2343 = nil
	arg_24_0._mark2373 = nil
	arg_24_0._mark2379 = nil
	arg_24_0._mark2456 = nil
	arg_24_0._mark2484 = nil
	arg_24_0._mark2495 = nil
	arg_24_0._mark2517 = nil
	arg_24_0._mark2517_2 = nil
	arg_24_0._mark2541 = nil
	arg_24_0._mark2556 = nil
	arg_24_0._mark2582 = nil
	arg_24_0._mark2607 = nil
	arg_24_0._mark2608 = nil
	arg_24_0._mark2734 = nil
	arg_24_0._mark2752 = nil
	arg_24_0._mark2791 = nil
	arg_24_0._mark2849 = nil
	arg_24_0._mark2850 = nil
	arg_24_0._mark2858 = nil
	arg_24_0._mark2904 = nil
	arg_24_0._mark2990 = nil
	arg_24_0._mark9012 = nil
	arg_24_0._mark9013 = nil
	arg_24_0._mark9039 = nil
	arg_24_0._mark9061 = nil
	arg_24_0._mark9062 = nil
	arg_24_0._mark9076 = nil
	arg_24_0._mark9098 = nil
	arg_24_0._mark9197 = nil
	arg_24_0._mark9202 = nil
	arg_24_0._mark9203 = nil
	arg_24_0._mark9249 = nil
	arg_24_0._mark9349 = nil
	arg_24_0._mark9376 = nil
	arg_24_0._mark9396 = nil
	arg_24_0._mark9396_2 = nil
	arg_24_0._mark9450 = nil
	arg_24_0._mark9451 = nil
	arg_24_0._mark9497 = nil
	arg_24_0._mark9516 = nil
	arg_24_0._mark9552 = nil
	arg_24_0._mark9569 = nil
	arg_24_0._mark9585 = nil
	arg_24_0._mark9594 = nil
	arg_24_0._mark9647 = nil
	arg_24_0._mark9717 = nil
	arg_24_0._mark9787 = nil
	arg_24_0._mark9794 = nil
	arg_24_0._mark9833 = nil
	arg_24_0._mark9838 = nil
	arg_24_0._mark9854 = nil
	arg_24_0._mark9873 = nil
	arg_24_0._mark9877 = nil
	arg_24_0._mark9897 = nil
	arg_24_0._mark9967 = nil
	arg_24_0._mark7112 = nil
	arg_24_0._mark7113_1 = nil
	arg_24_0._mark7113_2 = {}
	arg_24_0._mark7231 = nil
	arg_24_0._mark7262 = nil
	arg_24_0._mark7280 = nil
	arg_24_0._mark7341 = nil
	arg_24_0._mark7360 = nil
	arg_24_0._mark7364 = nil
	arg_24_0._mark7411 = nil
	arg_24_0._mark7438 = nil
	arg_24_0._mark7442 = nil
	arg_24_0._mark7448 = {}
	arg_24_0._mark7465 = nil
	arg_24_0._mark7495 = nil
	arg_24_0._mark7507 = nil
	arg_24_0._mark7512 = nil
	arg_24_0._mark7535 = nil
	arg_24_0._mark7600 = nil
	arg_24_0._mark7612 = nil
	arg_24_0._mark7613 = nil
	arg_24_0._mark7670 = nil
	arg_24_0._mark7711 = nil
	arg_24_0._mark7738 = nil
	arg_24_0._mark7740 = nil
	arg_24_0._mark7756 = nil
	arg_24_0._mark7757 = nil
	arg_24_0._mark13159 = nil
	arg_24_0._mark13246 = nil
	arg_24_0._mark13363 = nil
	arg_24_0._mark13369 = nil
	arg_24_0._mark13530 = nil
	arg_24_0._mark13537 = nil
	arg_24_0._mark13562 = nil
	arg_24_0._mark13617 = nil
	arg_24_0._mark13680 = nil
	arg_24_0._mark13956 = nil
	arg_24_0._mark14122 = nil
	arg_24_0._mark14147 = nil
	arg_24_0._mark14199 = nil
	arg_24_0._mark14203 = nil
	arg_24_0._mark14253 = nil
	arg_24_0._mark14511 = nil
	arg_24_0._mark14525 = nil
	arg_24_0._mark14527 = nil
	arg_24_0._mark14531 = nil
	arg_24_0._mark14579 = nil
	arg_24_0._castedTargets = {}

	if arg_24_0._mark9226 == arg_24_0._owner then
		arg_24_0._mark9226 = nil
	end

	arg_24_0._markInfoId = nil
end

function var_0_0.resetCardWhenOppoRoundBegin(arg_25_0)
	if arg_25_0._mark5127 or arg_25_0._mark5207 or arg_25_0._mark3832 or arg_25_0._mark3921 or arg_25_0._mark6222 or arg_25_0._mark6346 or arg_25_0._mark6368 or arg_25_0._mark9226 or arg_25_0._mark9617 or arg_25_0._isCardSkillDisabledInRound or arg_25_0._mark2481 or arg_25_0:hasSkills({
		6177,
		6178,
		6179,
		6381,
		2368,
		7190,
		7202
	}) then
		B._lastAccount = nil
	end

	arg_25_0._canNotBeLinked = nil
	arg_25_0._option2016 = nil
	arg_25_0._option2017 = {}
	arg_25_0._mark1080 = nil
	arg_25_0._mark1099 = nil
	arg_25_0._mark1102 = nil
	arg_25_0._mark1104 = nil
	arg_25_0._mark1123 = nil
	arg_25_0._mark1123_2 = nil
	arg_25_0._mark1142 = nil
	arg_25_0._mark2093 = nil
	arg_25_0._mark2480 = nil
	arg_25_0._mark3447 = nil
	arg_25_0._mark3491 = nil
	arg_25_0._mark3592 = nil
	arg_25_0._mark3667 = nil
	arg_25_0._mark3748 = nil
	arg_25_0._mark3832 = nil
	arg_25_0._mark3921 = nil
	arg_25_0._mark3921_2 = nil
	arg_25_0._mark3923 = nil
	arg_25_0._mark3930 = nil
	arg_25_0._mark3937 = nil
	arg_25_0._mark3977 = nil
	arg_25_0._mark3990 = nil
	arg_25_0._mark4191 = nil
	arg_25_0._mark4493 = nil
	arg_25_0._mark4202 = nil
	arg_25_0._mark4224 = nil
	arg_25_0._mark4329 = nil
	arg_25_0._mark4400 = nil
	arg_25_0._mark4415 = nil
	arg_25_0._mark4419 = nil
	arg_25_0._mark4513 = nil
	arg_25_0._mark4515 = nil
	arg_25_0._mark4532 = nil
	arg_25_0._mark5127 = nil
	arg_25_0._mark5179 = {}
	arg_25_0._mark5198 = nil
	arg_25_0._mark5207 = nil
	arg_25_0._mark5272 = nil
	arg_25_0._mark5426 = nil
	arg_25_0._mark8011 = nil
	arg_25_0._mark6190_2 = nil
	arg_25_0._mark6219 = nil
	arg_25_0._mark6222 = nil
	arg_25_0._mark6243 = nil
	arg_25_0._mark6346 = nil
	arg_25_0._mark6353 = nil
	arg_25_0._mark6368 = nil
	arg_25_0._mark6377 = nil
	arg_25_0._mark6387 = nil
	arg_25_0._mark6413 = nil
	arg_25_0._mark6420 = nil
	arg_25_0._mark6431 = nil
	arg_25_0._mark6474 = nil
	arg_25_0._mark6485 = nil
	arg_25_0._mark6509 = nil
	arg_25_0._mark6514 = nil
	arg_25_0._mark6516 = nil
	arg_25_0._mark6564 = nil
	arg_25_0._mark6572 = nil
	arg_25_0._mark6578 = nil
	arg_25_0._mark6612 = nil
	arg_25_0._mark6619 = nil
	arg_25_0._mark6637 = nil
	arg_25_0._mark6681 = nil
	arg_25_0._mark6745 = nil
	arg_25_0._mark6747 = nil
	arg_25_0._mark6822 = nil
	arg_25_0._mark6896 = nil
	arg_25_0._mark6901 = nil
	arg_25_0._mark6944 = nil
	arg_25_0._mark2118 = nil
	arg_25_0._mark2190 = nil
	arg_25_0._mark2194 = nil
	arg_25_0._mark2292 = nil
	arg_25_0._mark2373 = nil
	arg_25_0._mark2379 = nil
	arg_25_0._mark2456 = nil
	arg_25_0._mark2481 = nil
	arg_25_0._mark2484 = nil
	arg_25_0._mark2495 = nil
	arg_25_0._mark2517 = nil
	arg_25_0._mark2517_2 = nil
	arg_25_0._mark2541 = nil
	arg_25_0._mark2556 = nil
	arg_25_0._mark2582 = nil
	arg_25_0._mark2607 = nil
	arg_25_0._mark2608 = nil
	arg_25_0._mark2734 = nil
	arg_25_0._mark2752 = nil
	arg_25_0._mark2791 = nil
	arg_25_0._mark2849 = nil
	arg_25_0._mark2850 = nil
	arg_25_0._mark2858 = nil
	arg_25_0._mark2904 = nil
	arg_25_0._mark2990 = nil
	arg_25_0._mark9039 = nil
	arg_25_0._mark9061 = nil
	arg_25_0._mark9062 = nil
	arg_25_0._mark9249 = nil
	arg_25_0._mark9516 = nil
	arg_25_0._mark9594 = nil
	arg_25_0._mark9617 = nil
	arg_25_0._mark9833 = nil
	arg_25_0._mark9873 = nil
	arg_25_0._mark7112 = nil
	arg_25_0._mark7231 = nil
	arg_25_0._mark7262 = nil
	arg_25_0._mark7280 = nil
	arg_25_0._mark7341 = nil
	arg_25_0._mark7360 = nil
	arg_25_0._mark7364 = nil
	arg_25_0._mark7411 = nil
	arg_25_0._mark7711 = nil
	arg_25_0._mark7738 = nil
	arg_25_0._mark7740 = nil
	arg_25_0._mark7756 = nil
	arg_25_0._mark7757 = nil
	arg_25_0._mark7778 = nil
	arg_25_0._mark13530 = nil
	arg_25_0._mark13562 = nil
	arg_25_0._mark13680 = nil
	arg_25_0._mark13956 = nil
	arg_25_0._mark14122 = nil
	arg_25_0._mark14199 = nil
	arg_25_0._mark14203 = nil
	arg_25_0._mark14253 = nil
	arg_25_0._mark14511 = nil
	arg_25_0._mark14525 = nil
	arg_25_0._mark14527 = nil
	arg_25_0._mark14531 = nil
	arg_25_0._mark14579 = nil
	arg_25_0._mark7448 = {}
	arg_25_0._castedTargets = {}
	arg_25_0._isCardSkillDisabledInRound = nil

	if arg_25_0._mark9226 == arg_25_0._owner._opponent then
		arg_25_0._mark9226 = nil
	end

	arg_25_0._markInfoId = nil

	if arg_25_0._infoId == 40387 then
		arg_25_0._mark9070 = arg_25_0:getStar()
	end

	if arg_25_0._mark9970 then
		for iter_25_0 = 1, #arg_25_0._mark9970 do
			arg_25_0:removeSkill(arg_25_0._mark9970[iter_25_0], BattleData.SkillProvider.extra)
		end

		arg_25_0._mark9970 = nil
	end

	if arg_25_0._mark13577 then
		for iter_25_1 = 1, #arg_25_0._mark13577 do
			arg_25_0:removeSkill(arg_25_0._mark13577[iter_25_1], BattleData.SkillProvider.extra)
		end

		arg_25_0._mark13577 = nil
	end

	arg_25_0:removeSkill(9734, BattleData.SkillProvider.given)
end

function var_0_0.resetCardWhenUse(arg_26_0)
	arg_26_0._mark2933 = nil
	arg_26_0._mark2934 = nil
	arg_26_0._mark2935 = nil
	arg_26_0._mark2936 = nil
	arg_26_0._mark2937 = nil
	arg_26_0._mark5482 = nil
	arg_26_0._mark8098 = nil
	arg_26_0._mark9407_2 = nil
	arg_26_0._mark9412 = nil
	arg_26_0._mark13227 = nil
	arg_26_0._mark13337 = nil
end

function var_0_0.rebirth(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getSkillsByProvider(BattleData.SkillProvider.copy)[1]
	local var_27_1 = {}

	for iter_27_0 = 1, #arg_27_0._underSkills do
		local var_27_2 = arg_27_0._underSkills[iter_27_0]

		if var_27_2._mode == Data.SkillMode.halo and (var_27_2._positiveType or var_27_2._negativeType) and not arg_27_0:isUnderSkillHaloedBySelfExtraSkill(var_27_2) then
			table.insert(var_27_1, var_27_2)
		end
	end

	local var_27_3 = arg_27_0._isBorrowed
	local var_27_4 = arg_27_0._isBorrowed and arg_27_0._saved._pos

	arg_27_0:baseReset(arg_27_1)

	if arg_27_0._type == Data.CardType.monster then
		arg_27_0:resetMonster()
	elseif arg_27_0._type == Data.CardType.rare then
		arg_27_0:resetRare()
	end

	if var_27_0 ~= nil then
		arg_27_0:addSkill(var_27_0._id, var_27_0._maxLevel, BattleData.SkillProvider.copy)
	end

	for iter_27_1 = 1, #var_27_1 do
		table.insert(arg_27_0._underSkills, var_27_1[iter_27_1])
	end

	arg_27_0._isBorrowed = var_27_3
	arg_27_0._saved._pos = var_27_4

	if arg_27_0._underSkills then
		local var_27_5 = 1

		while true do
			local var_27_6 = arg_27_0._underSkills[var_27_5]

			if var_27_6 == nil then
				break
			end

			if var_27_6._mode ~= Data.SkillMode.halo or arg_27_0:isUnderSkillHaloedBySelfExtraSkill(var_27_6) then
				table.remove(arg_27_0._underSkills, var_27_5)
			else
				var_27_5 = var_27_5 + 1
			end
		end
	end
end

function var_0_0.resetHp(arg_28_0)
	arg_28_0._hp = arg_28_0._maxHp
	arg_28_0._maxHpInc = 0
	arg_28_0._hpInc = 0

	if arg_28_0._updateInitHp ~= nil then
		arg_28_0._hp = math.min(arg_28_0._hp, arg_28_0._updateInitHp)
		arg_28_0._hpInc = arg_28_0._hp - arg_28_0._maxHp

		if arg_28_0._hpInc > 0 then
			arg_28_0._maxHpInc = arg_28_0._hpInc
		end
	end

	if arg_28_0._updateHp ~= nil then
		arg_28_0._hp = math.min(arg_28_0._hp, arg_28_0._updateHp)
		arg_28_0._hpInc = arg_28_0._hp - arg_28_0._maxHp

		if arg_28_0._hpInc > 0 then
			arg_28_0._maxHpInc = arg_28_0._hpInc
		end

		arg_28_0._updateHp = nil
	end

	arg_28_0._haloedMaxHpInc = arg_28_0._maxHpInc
end

function var_0_0.resetAtk(arg_29_0)
	arg_29_0._atk = arg_29_0._maxAtk
	arg_29_0._maxAtkInc = 0
	arg_29_0._atkInc = 0

	if arg_29_0._updateInitAtk ~= nil then
		arg_29_0._atk = math.min(arg_29_0._atk, arg_29_0._updateInitAtk)
		arg_29_0._atkInc = sekf._atk - arg_29_0._maxAtk

		if arg_29_0._atkInc > 0 then
			arg_29_0._maxAtkInc = arg_29_0._atkInc
		end
	end

	if arg_29_0._updateAtk ~= nil then
		arg_29_0._atk = arg_29_0._updateAtk
		arg_29_0._atkInc = arg_29_0._atk - arg_29_0._maxAtk

		if arg_29_0._atkInc > 0 then
			arg_29_0._maxAtkInc = arg_29_0._atkInc
		end

		arg_29_0._updateAtk = nil
	end

	arg_29_0._haloedMaxAtkInc = arg_29_0._maxAtkInc
end

function var_0_0.resetBuff(arg_30_0, arg_30_1)
	if arg_30_1 == nil then
		arg_30_0._positiveStatus = {}
		arg_30_0._positiveValues = {}
		arg_30_0._negativeStatus = {}
		arg_30_0._negativeValues = {}

		arg_30_0:resetBuff(true)
		arg_30_0:resetBuff(false)
	else
		local var_30_0 = arg_30_1 and BattleData.PositiveType.count or BattleData.NegativeType.count

		for iter_30_0 = 1, var_30_0 do
			arg_30_0:resetBuffByType(arg_30_1, iter_30_0)
		end
	end
end

function var_0_0.resetBuffByType(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1 and arg_31_0._positiveStatus or arg_31_0._negativeStatus
	local var_31_1 = arg_31_1 and arg_31_0._positiveValues or arg_31_0._negativeValues

	var_31_0[arg_31_2] = false
	var_31_1[arg_31_2] = 0

	local var_31_2 = 1

	while true do
		local var_31_3 = arg_31_0._underSkills[var_31_2]

		if var_31_3 == nil then
			break
		end

		if arg_31_1 and var_31_3._positiveType == arg_31_2 or not arg_31_1 and var_31_3._negativeType == arg_31_2 then
			table.remove(arg_31_0._underSkills, var_31_2)
		else
			var_31_2 = var_31_2 + 1
		end
	end
end

function var_0_0.accountBuffValue(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1 or not arg_32_0._positiveStatus then
		local var_32_0 = arg_32_0._negativeStatus
	end

	local var_32_1 = arg_32_1 and arg_32_0._positiveValues or arg_32_0._negativeValues
	local var_32_2 = 0
	local var_32_3

	for iter_32_0 = 1, #arg_32_0._underSkills do
		local var_32_4 = arg_32_0._underSkills[iter_32_0]

		if var_32_4._disabled ~= true and (arg_32_1 and var_32_4._positiveType == arg_32_2 or not arg_32_1 and var_32_4._negativeType == arg_32_2) then
			if var_32_3 == nil then
				var_32_3 = var_32_4._aggregateType
				var_32_2 = var_32_3 == Data.AggregateType.table and {} or 0
			end

			if var_32_3 == Data.AggregateType.sum then
				var_32_2 = var_32_2 + var_32_4._value
			elseif var_32_3 == Data.AggregateType.max then
				var_32_2 = math.max(var_32_2, var_32_4._value)
			elseif var_32_3 == Data.AggregateType.min then
				var_32_2 = math.min(var_32_2, var_32_4._value)
			elseif var_32_3 == Data.AggregateType.table then
				local var_32_5 = false

				for iter_32_1 = 1, #var_32_2 do
					if var_32_2[iter_32_1] == var_32_4._negativeValues then
						var_32_5 = true

						break
					end
				end

				if not var_32_5 then
					table.insert(var_32_2, var_32_4._value)
				end
			end
		end
	end

	var_32_1[arg_32_2] = var_32_2
end

function var_0_0.getBuffValue(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1 and arg_33_0._positiveValues or arg_33_0._negativeValues

	return var_33_0 and var_33_0[arg_33_2] or 0
end

function var_0_0.modifyBuffValue(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	for iter_34_0 = 1, #arg_34_0._underSkills do
		local var_34_0 = arg_34_0._underSkills[iter_34_0]

		if arg_34_1 and var_34_0._positiveType == arg_34_2 or not arg_34_1 and var_34_0._negativeType == arg_34_2 then
			var_34_0._value = arg_34_3
		end
	end

	arg_34_0:accountBuffValue(arg_34_1, arg_34_2)
end

function var_0_0.removeTableBuffValue(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	for iter_35_0 = 1, #arg_35_0._underSkills do
		local var_35_0 = arg_35_0._underSkills[iter_35_0]

		if arg_35_1 and var_35_0._positiveType == arg_35_2 or not arg_35_1 and var_35_0._negativeType == arg_35_2 and var_35_0._value == arg_35_3 then
			table.remove(arg_35_0._underSkills, iter_35_0)

			break
		end
	end

	arg_35_0:accountBuffValue(arg_35_1, arg_35_2)
end

function var_0_0.hasBuff(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1 and arg_36_0._positiveStatus or arg_36_0._negativeStatus

	if var_36_0 == nil then
		return false
	end

	local var_36_1 = arg_36_1 and BattleData.PositiveType.count or BattleData.NegativeType.count

	for iter_36_0 = 1, var_36_1 do
		if (arg_36_2 == nil or arg_36_2 == iter_36_0) and var_36_0[iter_36_0] == true then
			return true
		end
	end

	return false
end

function var_0_0.resetBuffAfterRemove(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = 1
	local var_37_1 = true

	while true do
		local var_37_2 = arg_37_0._underSkills[var_37_0]

		if var_37_2 == nil then
			break
		end

		if arg_37_1 and var_37_2._positiveType == arg_37_2 or not arg_37_1 and var_37_2._negativeType == arg_37_2 then
			var_37_1 = false

			break
		end

		var_37_0 = var_37_0 + 1
	end

	if var_37_1 then
		if arg_37_1 then
			arg_37_0._owner:decPositiveStatus(arg_37_0, {
				arg_37_2
			}, false, arg_37_0._id, 0, Data.SkillMode.once)
		else
			arg_37_0._owner:decNegativeStatus(arg_37_0, {
				arg_37_2
			}, false, arg_37_0._id, 0, Data.SkillMode.once)
		end
	else
		arg_37_0:accountBuffValue(arg_37_1, arg_37_2)
	end
end

function var_0_0.getShieldValue(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getBuffValue(true, arg_38_1)

	if type(var_38_0) ~= "table" then
		return 0
	end

	local var_38_1 = 0
	local var_38_2 = true

	for iter_38_0 = 1, #var_38_0 do
		var_38_1 = math.max(var_38_1, var_38_0[iter_38_0] % 65536)

		if var_38_0[iter_38_0] < 65536 then
			var_38_2 = false
		end
	end

	return var_38_1, var_38_2
end

function var_0_0.hasShield(arg_39_0)
	for iter_39_0 = BattleData.PositiveType.shieldHaloBegin, BattleData.PositiveType.shieldExEnd do
		if arg_39_0:hasBuff(true, iter_39_0) then
			return true
		end
	end

	return false
end

function var_0_0.hasShieldInType(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_0:hasBuff(true, arg_40_1) or arg_40_0:hasBuff(true, arg_40_1 - BattleData.PositiveType.shieldBegin + BattleData.PositiveType.shieldHaloBegin) or arg_40_0:hasBuff(true, arg_40_1 - BattleData.PositiveType.shieldBegin + BattleData.PositiveType.shieldExBegin) then
		return true
	end

	if not arg_40_2 and arg_40_1 >= BattleData.PositiveType.shieldMonster and arg_40_1 <= BattleData.PositiveType.shieldTrap and (arg_40_0:hasBuff(true, arg_40_1 - BattleData.PositiveType.shieldMonster + BattleData.PositiveType.shieldOppoMonster) or arg_40_0:hasBuff(true, arg_40_1 - BattleData.PositiveType.shieldMonster + BattleData.PositiveType.shieldHaloOppoMonster)) then
		return true
	end

	return false
end

function var_0_0.hasShieldExInType(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_0:hasBuff(true, arg_41_1 - BattleData.PositiveType.shieldBegin + BattleData.PositiveType.shieldHaloBegin) or arg_41_0:hasBuff(true, arg_41_1 - BattleData.PositiveType.shieldBegin + BattleData.PositiveType.shieldExBegin) then
		return true
	end

	if not arg_41_2 and arg_41_1 >= BattleData.PositiveType.shieldMonster and arg_41_1 <= BattleData.PositiveType.shieldTrap and (arg_41_0:hasBuff(true, arg_41_1 - BattleData.PositiveType.shieldMonster + BattleData.PositiveType.shieldOppoMonster) or arg_41_0:hasBuff(true, arg_41_1 - BattleData.PositiveType.shieldMonster + BattleData.PositiveType.shieldHaloOppoMonster)) then
		return true
	end

	return false
end

function var_0_0.decShieldWhenRoundBegin(arg_42_0)
	for iter_42_0 = BattleData.PositiveType.shieldBegin, BattleData.PositiveType.shieldExEnd do
		if arg_42_0:hasBuff(true, iter_42_0) then
			arg_42_0:removeSingleRoundShield(iter_42_0)
		end
	end

	for iter_42_1 = BattleData.PositiveType.shieldDestroy, BattleData.PositiveType.shieldDestroy do
		if arg_42_0:hasBuff(true, iter_42_1) then
			arg_42_0:removeSingleRoundShield(iter_42_1)
		end
	end

	for iter_42_2 = BattleData.PositiveType.shieldOppoMonster, BattleData.PositiveType.shieldOppoTrap do
		if arg_42_0:hasBuff(true, iter_42_2) then
			arg_42_0:removeSingleRoundShield(iter_42_2)
		end
	end
end

function var_0_0.removeSingleRoundShield(arg_43_0, arg_43_1)
	local var_43_0 = false
	local var_43_1 = 1

	while true do
		local var_43_2 = arg_43_0._underSkills[var_43_1]

		if var_43_2 == nil then
			break
		end

		if var_43_2._positiveType == arg_43_1 and (var_43_2._value >= 65536 or arg_43_1 == BattleData.PositiveType.shieldExHp and arg_43_0._mark5338 == arg_43_0._owner._round) then
			table.remove(arg_43_0._underSkills, var_43_1)

			var_43_0 = true

			break
		else
			var_43_1 = var_43_1 + 1
		end
	end

	if var_43_0 then
		arg_43_0:resetBuffAfterRemove(true, arg_43_1)
	end
end

function var_0_0.addMagicMark(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
	if arg_44_0:hasSkills({
		6055,
		6078,
		6123,
		6169,
		6172,
		7205
	}) then
		arg_44_0._owner:setCardStatus(arg_44_0._owner._fortress, BattleData.CardStatus.fortress, arg_44_3, arg_44_4, arg_44_5, BattleData.CardStatusVal.f2f_halo)
	end

	local var_44_0 = arg_44_1

	if arg_44_0:hasSkills({
		6001,
		6002
	}) then
		local var_44_1 = arg_44_0:getBuffValue(true, BattleData.PositiveType.magicMark)
		local var_44_2 = arg_44_0._owner:getBattleCardsByInfoId("GPH", Data._skillInfo[arg_44_0._skills[1]._id]._refCards[1])[1]

		if var_44_2 ~= nil and var_44_1 + arg_44_1 >= 3 and arg_44_0._owner:canSpecialSummon(var_44_2) then
			arg_44_0._owner:setCardStatus(arg_44_0, BattleData.CardStatus.grave, arg_44_3, arg_44_4, arg_44_5)

			if arg_44_2._info._type == Data.MagicTrapType.show_equip and arg_44_2._magicTarget == arg_44_0 then
				arg_44_0._owner:setCardStatus(arg_44_2, BattleData.CardStatus.grave, arg_44_3, arg_44_4, arg_44_5)
			end

			arg_44_0._owner:setCardStatus(var_44_2, BattleData.CardStatus.board, arg_44_3, arg_44_4, arg_44_5)

			return true
		elseif var_44_1 < 3 then
			var_44_0 = math.min(arg_44_1, 3 - var_44_1)
		else
			var_44_0 = 0
		end
	elseif arg_44_0:hasSkills({
		6025
	}) then
		local var_44_3 = arg_44_0:getBuffValue(true, BattleData.PositiveType.magicMark)

		if var_44_3 < 3 then
			var_44_0 = math.min(arg_44_1, 3 - var_44_3)
		else
			var_44_0 = 0
		end
	elseif arg_44_0:hasSkills({
		6026
	}) then
		local var_44_4 = arg_44_0:getBuffValue(true, BattleData.PositiveType.magicMark)

		if var_44_4 < 1 then
			var_44_0 = math.min(arg_44_1, 1 - var_44_4)
		else
			var_44_0 = 0
		end
	elseif arg_44_0:hasSkills({
		7137
	}) then
		local var_44_5 = arg_44_0:getBuffValue(true, BattleData.PositiveType.magicMark)

		if var_44_5 < 6 then
			var_44_0 = math.min(arg_44_1, 6 - var_44_5)
		else
			var_44_0 = 0
		end
	elseif arg_44_0:hasSkills({
		6172
	}) then
		local var_44_6 = arg_44_0:getBuffValue(true, BattleData.PositiveType.magicMark)

		if var_44_6 < 5 then
			var_44_0 = math.min(arg_44_1, 5 - var_44_6)
		else
			var_44_0 = 0
		end
	elseif arg_44_0:hasSkills({
		6354
	}) then
		local var_44_7 = arg_44_0:getBuffValue(true, BattleData.PositiveType.magicMark)

		if var_44_7 < 2 then
			var_44_0 = math.min(arg_44_1, 2 - var_44_7)
		else
			var_44_0 = 0
		end
	elseif arg_44_0:hasSkills({
		7241
	}) then
		local var_44_8 = arg_44_0:getBuffValue(true, BattleData.PositiveType.magicMark)

		if var_44_8 < 4 then
			var_44_0 = math.min(arg_44_1, 4 - var_44_8)
		else
			var_44_0 = 0
		end
	elseif arg_44_0:hasSkills({
		8022
	}) then
		local var_44_9 = arg_44_0:getBuffValue(true, BattleData.PositiveType.magicMark)

		if var_44_9 < 4 then
			var_44_0 = math.min(arg_44_1, 4 - var_44_9)

			if var_44_9 + var_44_0 >= 4 then
				arg_44_0._owner:setCardStatus(arg_44_0, BattleData.CardStatus.grave, arg_44_3, arg_44_4, arg_44_5)
				arg_44_2._owner:addDamage(arg_44_2._owner._fortress, arg_44_2._owner:calcFortressCost(Data._skillInfo[8022]._val[1]), arg_44_3, arg_44_4, arg_44_5)
			end
		else
			var_44_0 = 0
		end
	end

	if var_44_0 > 0 then
		for iter_44_0 = 1, var_44_0 do
			arg_44_0._owner:incPositiveStatus(arg_44_0, {
				BattleData.PositiveType.magicMark
			}, false, arg_44_3, arg_44_4, arg_44_5)
			arg_44_0._owner:incPositiveValue(arg_44_0, BattleData.PositiveType.magicMark, 1, Data.AggregateType.sum, arg_44_3, arg_44_4, arg_44_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addRoundMark(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
	local var_45_0 = arg_45_1
	local var_45_1 = arg_45_0:getBuffValue(true, BattleData.PositiveType.roundMark)

	if arg_45_0:hasSkills({
		3046
	}) then
		if var_45_1 < 4 then
			var_45_0 = math.min(arg_45_1, 4 - var_45_1)
		else
			var_45_0 = 0
		end
	end

	if var_45_0 > 0 then
		for iter_45_0 = 1, var_45_0 do
			arg_45_0._owner:incPositiveStatus(arg_45_0, {
				BattleData.PositiveType.roundMark
			}, false, arg_45_3, arg_45_4, arg_45_5)
			arg_45_0._owner:incPositiveValue(arg_45_0, BattleData.PositiveType.roundMark, 1, Data.AggregateType.sum, arg_45_3, arg_45_4, arg_45_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSugarMark(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	if arg_46_0:hasSkills({
		6508
	}) then
		arg_46_0._owner:setCardStatus(arg_46_0._owner._fortress, BattleData.CardStatus.fortress, arg_46_3, arg_46_4, arg_46_5, BattleData.CardStatusVal.f2f_halo)
	end

	local var_46_0 = arg_46_1
	local var_46_1 = arg_46_0:getBuffValue(true, BattleData.PositiveType.sugarMark)

	if not arg_46_0:hasSkills({
		6505
	}) then
		if var_46_1 < 1 then
			var_46_0 = math.min(arg_46_1, 1 - var_46_1)
		else
			var_46_0 = 0
		end
	end

	if var_46_0 > 0 then
		for iter_46_0 = 1, var_46_0 do
			arg_46_0._owner:incPositiveStatus(arg_46_0, {
				BattleData.PositiveType.sugarMark
			}, false, arg_46_3, arg_46_4, arg_46_5)
			arg_46_0._owner:incPositiveValue(arg_46_0, BattleData.PositiveType.sugarMark, 1, Data.AggregateType.sum, arg_46_3, arg_46_4, arg_46_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSugarMark2(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4, arg_47_5)
	local var_47_0 = arg_47_1

	if var_47_0 > 0 then
		for iter_47_0 = 1, var_47_0 do
			arg_47_0._owner:incPositiveStatus(arg_47_0, {
				BattleData.PositiveType.sugarMark2
			}, false, arg_47_3, arg_47_4, arg_47_5)
			arg_47_0._owner:incPositiveValue(arg_47_0, BattleData.PositiveType.sugarMark2, 1, Data.AggregateType.sum, arg_47_3, arg_47_4, arg_47_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addDeathMark(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5)
	if arg_48_0:hasSkills({
		6105
	}) then
		arg_48_0._owner:setCardStatus(arg_48_0._owner._fortress, BattleData.CardStatus.fortress, arg_48_3, arg_48_4, arg_48_5, BattleData.CardStatusVal.f2f_halo)
	end

	local var_48_0 = arg_48_1
	local var_48_1 = arg_48_0:getBuffValue(true, BattleData.PositiveType.deathMark)

	if var_48_1 < 2 then
		var_48_0 = math.min(arg_48_1, 2 - var_48_1)
	else
		var_48_0 = 0
	end

	if var_48_0 > 0 then
		for iter_48_0 = 1, var_48_0 do
			arg_48_0._owner:incPositiveStatus(arg_48_0, {
				BattleData.PositiveType.deathMark
			}, false, arg_48_3, arg_48_4, arg_48_5)
			arg_48_0._owner:incPositiveValue(arg_48_0, BattleData.PositiveType.deathMark, 1, Data.AggregateType.sum, arg_48_3, arg_48_4, arg_48_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSatelliteMark(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4, arg_49_5)
	if arg_49_0:hasSkills({
		3400
	}) then
		arg_49_0._owner:setCardStatus(arg_49_0._owner._fortress, BattleData.CardStatus.fortress, arg_49_3, arg_49_4, arg_49_5, BattleData.CardStatusVal.f2f_halo)
	end

	local var_49_0 = arg_49_1
	local var_49_1 = arg_49_0:getBuffValue(true, BattleData.PositiveType.satelliteMark)

	if var_49_0 > 0 then
		for iter_49_0 = 1, var_49_0 do
			arg_49_0._owner:incPositiveStatus(arg_49_0, {
				BattleData.PositiveType.satelliteMark
			}, false, arg_49_3, arg_49_4, arg_49_5)
			arg_49_0._owner:incPositiveValue(arg_49_0, BattleData.PositiveType.satelliteMark, 1, Data.AggregateType.sum, arg_49_3, arg_49_4, arg_49_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addOceanMark(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5)
	local var_50_0 = arg_50_1
	local var_50_1 = arg_50_0:getBuffValue(true, BattleData.PositiveType.oceanMark)

	if var_50_0 > 0 then
		for iter_50_0 = 1, var_50_0 do
			arg_50_0._owner:incPositiveStatus(arg_50_0, {
				BattleData.PositiveType.oceanMark
			}, false, arg_50_3, arg_50_4, arg_50_5)
			arg_50_0._owner:incPositiveValue(arg_50_0, BattleData.PositiveType.oceanMark, 1, Data.AggregateType.sum, arg_50_3, arg_50_4, arg_50_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSnowMark(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4, arg_51_5)
	if arg_51_0:hasSkills({
		6127
	}) then
		arg_51_0._owner:setCardStatus(arg_51_0._owner._fortress, BattleData.CardStatus.fortress, arg_51_3, arg_51_4, arg_51_5, BattleData.CardStatusVal.f2f_halo)
	end

	local var_51_0 = arg_51_1
	local var_51_1 = arg_51_0:getBuffValue(true, BattleData.PositiveType.snowMark)

	if var_51_1 < 5 then
		var_51_0 = math.min(arg_51_1, 5 - var_51_1)
	else
		var_51_0 = 0
	end

	if var_51_0 > 0 then
		for iter_51_0 = 1, var_51_0 do
			arg_51_0._owner:incPositiveStatus(arg_51_0, {
				BattleData.PositiveType.snowMark
			}, false, arg_51_3, arg_51_4, arg_51_5)
			arg_51_0._owner:incPositiveValue(arg_51_0, BattleData.PositiveType.snowMark, 1, Data.AggregateType.sum, arg_51_3, arg_51_4, arg_51_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addBoxMark(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	local var_52_0 = arg_52_1

	if var_52_0 > 0 then
		for iter_52_0 = 1, var_52_0 do
			arg_52_0._owner:incPositiveStatus(arg_52_0, {
				BattleData.PositiveType.boxMark
			}, false, arg_52_3, arg_52_4, arg_52_5)
			arg_52_0._owner:incPositiveValue(arg_52_0, BattleData.PositiveType.boxMark, 1, Data.AggregateType.sum, arg_52_3, arg_52_4, arg_52_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addStormMark(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5)
	local var_53_0 = arg_53_1
	local var_53_1 = arg_53_0:getBuffValue(true, BattleData.PositiveType.stormMark)

	if var_53_1 < 1 then
		var_53_0 = math.min(arg_53_1, 1 - var_53_1)
	else
		var_53_0 = 0
	end

	if var_53_0 > 0 then
		arg_53_0._owner:setCardStatus(arg_53_0._owner._fortress, BattleData.CardStatus.fortress, arg_53_3, arg_53_4, arg_53_5, BattleData.CardStatusVal.f2f_halo)

		for iter_53_0 = 1, var_53_0 do
			arg_53_0._owner:incPositiveStatus(arg_53_0, {
				BattleData.PositiveType.stormMark
			}, false, arg_53_3, arg_53_4, arg_53_5)
			arg_53_0._owner:incPositiveValue(arg_53_0, BattleData.PositiveType.stormMark, 1, Data.AggregateType.sum, arg_53_3, arg_53_4, arg_53_5)

			arg_53_2._stormMarkTarget = arg_53_0
		end

		return true
	else
		return false
	end
end

function var_0_0.addShiledMark(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5)
	local var_54_0 = arg_54_1
	local var_54_1 = arg_54_0:getBuffValue(true, BattleData.PositiveType.shieldMark)

	if var_54_1 < 4 then
		var_54_0 = math.min(arg_54_1, 4 - var_54_1)
	else
		var_54_0 = 0
	end

	if var_54_0 > 0 then
		arg_54_0._owner:setCardStatus(arg_54_0._owner._fortress, BattleData.CardStatus.fortress, arg_54_3, arg_54_4, arg_54_5, BattleData.CardStatusVal.f2f_halo)

		for iter_54_0 = 1, var_54_0 do
			arg_54_0._owner:incPositiveStatus(arg_54_0, {
				BattleData.PositiveType.shieldMark
			}, false, arg_54_3, arg_54_4, arg_54_5)
			arg_54_0._owner:incPositiveValue(arg_54_0, BattleData.PositiveType.shieldMark, 1, Data.AggregateType.sum, arg_54_3, arg_54_4, arg_54_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSamuraiMark(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4, arg_55_5)
	local var_55_0 = arg_55_1

	if arg_55_0:hasSkillFast(7176) then
		local var_55_1 = arg_55_0:getBuffValue(true, BattleData.PositiveType.samuraiMark)

		if var_55_1 < 2 then
			var_55_0 = math.min(arg_55_1, 2 - var_55_1)
		else
			var_55_0 = 0
		end
	elseif arg_55_0:hasSkillFast(9053) then
		local var_55_2 = arg_55_0:getBuffValue(true, BattleData.PositiveType.samuraiMark)

		if var_55_2 < 1 then
			var_55_0 = math.min(arg_55_1, 1 - var_55_2)
		else
			var_55_0 = 0
		end
	end

	if var_55_0 > 0 then
		if arg_55_0:hasSkills({
			7174,
			9053
		}) then
			arg_55_0._owner:setCardStatus(arg_55_0._owner._fortress, BattleData.CardStatus.fortress, arg_55_3, arg_55_4, arg_55_5, BattleData.CardStatusVal.f2f_halo)
		end

		for iter_55_0 = 1, var_55_0 do
			arg_55_0._owner:incPositiveStatus(arg_55_0, {
				BattleData.PositiveType.samuraiMark
			}, false, arg_55_3, arg_55_4, arg_55_5)
			arg_55_0._owner:incPositiveValue(arg_55_0, BattleData.PositiveType.samuraiMark, 1, Data.AggregateType.sum, arg_55_3, arg_55_4, arg_55_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addPhoenixMark(arg_56_0, arg_56_1, arg_56_2, arg_56_3, arg_56_4, arg_56_5)
	local var_56_0 = arg_56_1

	if var_56_0 > 0 then
		for iter_56_0 = 1, var_56_0 do
			arg_56_0._owner:incPositiveStatus(arg_56_0, {
				BattleData.PositiveType.phoenixMark
			}, false, arg_56_3, arg_56_4, arg_56_5)
			arg_56_0._owner:incPositiveValue(arg_56_0, BattleData.PositiveType.phoenixMark, 1, Data.AggregateType.sum, arg_56_3, arg_56_4, arg_56_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSoulMark(arg_57_0, arg_57_1, arg_57_2, arg_57_3, arg_57_4, arg_57_5)
	local var_57_0 = arg_57_1

	if var_57_0 > 0 then
		for iter_57_0 = 1, var_57_0 do
			arg_57_0._owner:incPositiveStatus(arg_57_0, {
				BattleData.PositiveType.soulMark
			}, false, arg_57_3, arg_57_4, arg_57_5)
			arg_57_0._owner:incPositiveValue(arg_57_0, BattleData.PositiveType.soulMark, 1, Data.AggregateType.sum, arg_57_3, arg_57_4, arg_57_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addForeverFireMark(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4, arg_58_5)
	local var_58_0 = arg_58_1

	if var_58_0 > 0 then
		for iter_58_0 = 1, var_58_0 do
			arg_58_0._owner:incPositiveStatus(arg_58_0, {
				BattleData.PositiveType.foreverFireMark
			}, false, arg_58_3, arg_58_4, arg_58_5)
			arg_58_0._owner:incPositiveValue(arg_58_0, BattleData.PositiveType.foreverFireMark, 1, Data.AggregateType.sum, arg_58_3, arg_58_4, arg_58_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addCjMark(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4, arg_59_5)
	local var_59_0 = arg_59_1

	if var_59_0 > 0 then
		for iter_59_0 = 1, var_59_0 do
			arg_59_0._owner:incPositiveStatus(arg_59_0, {
				BattleData.PositiveType.cjMark
			}, false, arg_59_3, arg_59_4, arg_59_5)
			arg_59_0._owner:incPositiveValue(arg_59_0, BattleData.PositiveType.cjMark, 1, Data.AggregateType.sum, arg_59_3, arg_59_4, arg_59_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addForestMark(arg_60_0, arg_60_1, arg_60_2, arg_60_3, arg_60_4, arg_60_5)
	local var_60_0 = arg_60_1
	local var_60_1 = arg_60_0:getBuffValue(true, BattleData.PositiveType.forestMark)

	if var_60_1 < 1 then
		var_60_0 = math.min(arg_60_1, 1 - var_60_1)
	else
		var_60_0 = 0
	end

	if var_60_0 > 0 then
		for iter_60_0 = 1, var_60_0 do
			arg_60_0._owner:incPositiveStatus(arg_60_0, {
				BattleData.PositiveType.forestMark
			}, false, arg_60_3, arg_60_4, arg_60_5)
			arg_60_0._owner:incPositiveValue(arg_60_0, BattleData.PositiveType.forestMark, 1, Data.AggregateType.sum, arg_60_3, arg_60_4, arg_60_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addTechMark(arg_61_0, arg_61_1, arg_61_2, arg_61_3, arg_61_4, arg_61_5)
	local var_61_0 = arg_61_1

	if var_61_0 > 0 then
		for iter_61_0 = 1, var_61_0 do
			arg_61_0._owner:incPositiveStatus(arg_61_0, {
				BattleData.PositiveType.techMark
			}, false, arg_61_3, arg_61_4, arg_61_5)
			arg_61_0._owner:incPositiveValue(arg_61_0, BattleData.PositiveType.techMark, 1, Data.AggregateType.sum, arg_61_3, arg_61_4, arg_61_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSyncMark(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4, arg_62_5)
	local var_62_0 = arg_62_1

	if var_62_0 > 0 then
		for iter_62_0 = 1, var_62_0 do
			arg_62_0._owner:incPositiveStatus(arg_62_0, {
				BattleData.PositiveType.syncMark
			}, false, arg_62_3, arg_62_4, arg_62_5)
			arg_62_0._owner:incPositiveValue(arg_62_0, BattleData.PositiveType.syncMark, 1, Data.AggregateType.sum, arg_62_3, arg_62_4, arg_62_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addResonateMark(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
	local var_63_0 = arg_63_1

	if var_63_0 > 0 then
		for iter_63_0 = 1, var_63_0 do
			arg_63_0._owner:incPositiveStatus(arg_63_0, {
				BattleData.PositiveType.resonateMark
			}, false, arg_63_3, arg_63_4, arg_63_5)
			arg_63_0._owner:incPositiveValue(arg_63_0, BattleData.PositiveType.resonateMark, 1, Data.AggregateType.sum, arg_63_3, arg_63_4, arg_63_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addGustoMark(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4, arg_64_5)
	local var_64_0 = arg_64_1

	if var_64_0 > 0 then
		if arg_64_0:hasSkills({
			7226
		}) then
			arg_64_0._owner:setCardStatus(arg_64_0._owner._fortress, BattleData.CardStatus.fortress, arg_64_3, arg_64_4, arg_64_5, BattleData.CardStatusVal.f2f_halo)
		end

		for iter_64_0 = 1, var_64_0 do
			arg_64_0._owner:incPositiveStatus(arg_64_0, {
				BattleData.PositiveType.gustoMark
			}, false, arg_64_3, arg_64_4, arg_64_5)
			arg_64_0._owner:incPositiveValue(arg_64_0, BattleData.PositiveType.gustoMark, 1, Data.AggregateType.sum, arg_64_3, arg_64_4, arg_64_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSunFlowerMark(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4, arg_65_5)
	local var_65_0 = arg_65_1

	if var_65_0 > 0 then
		for iter_65_0 = 1, var_65_0 do
			arg_65_0._owner:incPositiveStatus(arg_65_0, {
				BattleData.PositiveType.sunFlowerMark
			}, false, arg_65_3, arg_65_4, arg_65_5)
			arg_65_0._owner:incPositiveValue(arg_65_0, BattleData.PositiveType.sunFlowerMark, 1, Data.AggregateType.sum, arg_65_3, arg_65_4, arg_65_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addDeedMark(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4, arg_66_5)
	local var_66_0 = arg_66_1
	local var_66_1 = arg_66_0:getBuffValue(true, BattleData.PositiveType.deedMark)

	if var_66_1 < 1 then
		var_66_0 = math.min(arg_66_1, 1 - var_66_1)
	else
		var_66_0 = 0
	end

	if var_66_0 > 0 then
		for iter_66_0 = 1, var_66_0 do
			arg_66_0._owner:incPositiveStatus(arg_66_0, {
				BattleData.PositiveType.deedMark
			}, false, arg_66_3, arg_66_4, arg_66_5)
			arg_66_0._owner:incPositiveValue(arg_66_0, BattleData.PositiveType.deedMark, 1, Data.AggregateType.sum, arg_66_3, arg_66_4, arg_66_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addFeatherMark(arg_67_0, arg_67_1, arg_67_2, arg_67_3, arg_67_4, arg_67_5)
	local var_67_0 = arg_67_1

	if var_67_0 > 0 then
		for iter_67_0 = 1, var_67_0 do
			arg_67_0._owner:incPositiveStatus(arg_67_0, {
				BattleData.PositiveType.featherMark
			}, false, arg_67_3, arg_67_4, arg_67_5)
			arg_67_0._owner:incPositiveValue(arg_67_0, BattleData.PositiveType.featherMark, 1, Data.AggregateType.sum, arg_67_3, arg_67_4, arg_67_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addWeddingMark(arg_68_0, arg_68_1, arg_68_2, arg_68_3, arg_68_4, arg_68_5)
	local var_68_0 = arg_68_1

	if var_68_0 > 0 then
		for iter_68_0 = 1, var_68_0 do
			arg_68_0._owner:incPositiveStatus(arg_68_0, {
				BattleData.PositiveType.weddingMark
			}, false, arg_68_3, arg_68_4, arg_68_5)
			arg_68_0._owner:incPositiveValue(arg_68_0, BattleData.PositiveType.weddingMark, 1, Data.AggregateType.sum, arg_68_3, arg_68_4, arg_68_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addRevolverMark(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4, arg_69_5)
	local var_69_0 = arg_69_1

	if var_69_0 > 0 then
		for iter_69_0 = 1, var_69_0 do
			arg_69_0._owner:incPositiveStatus(arg_69_0, {
				BattleData.PositiveType.revolverMark
			}, false, arg_69_3, arg_69_4, arg_69_5)
			arg_69_0._owner:incPositiveValue(arg_69_0, BattleData.PositiveType.revolverMark, 1, Data.AggregateType.sum, arg_69_3, arg_69_4, arg_69_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addPlantMark(arg_70_0, arg_70_1, arg_70_2, arg_70_3, arg_70_4, arg_70_5)
	local var_70_0 = arg_70_1
	local var_70_1 = arg_70_0:getBuffValue(true, BattleData.PositiveType.plantMark)

	if var_70_1 < 5 then
		var_70_0 = math.min(arg_70_1, 5 - var_70_1)
	else
		var_70_0 = 0
	end

	if var_70_0 > 0 then
		for iter_70_0 = 1, var_70_0 do
			arg_70_0._owner:incPositiveStatus(arg_70_0, {
				BattleData.PositiveType.plantMark
			}, false, arg_70_3, arg_70_4, arg_70_5)
			arg_70_0._owner:incPositiveValue(arg_70_0, BattleData.PositiveType.plantMark, 1, Data.AggregateType.sum, arg_70_3, arg_70_4, arg_70_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addDMark(arg_71_0, arg_71_1, arg_71_2, arg_71_3, arg_71_4, arg_71_5)
	local var_71_0 = arg_71_1

	if var_71_0 > 0 then
		for iter_71_0 = 1, var_71_0 do
			arg_71_0._owner:incPositiveStatus(arg_71_0, {
				BattleData.PositiveType.dMark
			}, false, arg_71_3, arg_71_4, arg_71_5)
			arg_71_0._owner:incPositiveValue(arg_71_0, BattleData.PositiveType.dMark, 1, Data.AggregateType.sum, arg_71_3, arg_71_4, arg_71_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addIronMark(arg_72_0, arg_72_1, arg_72_2, arg_72_3, arg_72_4, arg_72_5)
	local var_72_0 = arg_72_1

	if var_72_0 > 0 then
		for iter_72_0 = 1, var_72_0 do
			arg_72_0._owner:incPositiveStatus(arg_72_0, {
				BattleData.PositiveType.ironMark
			}, false, arg_72_3, arg_72_4, arg_72_5)
			arg_72_0._owner:incPositiveValue(arg_72_0, BattleData.PositiveType.ironMark, 1, Data.AggregateType.sum, arg_72_3, arg_72_4, arg_72_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addXYZMark(arg_73_0, arg_73_1, arg_73_2, arg_73_3, arg_73_4, arg_73_5)
	if arg_73_0._mark5536 and (arg_73_5 == Data.SkillMode.using or arg_73_5 == Data.SkillMode.g2b or arg_73_5 == Data.SkillMode.cost) then
		return false
	end

	local var_73_0 = arg_73_1

	if var_73_0 > 0 then
		if arg_73_0:hasSkillFast(9131) then
			arg_73_0._owner:setCardStatus(arg_73_0._owner._fortress, BattleData.CardStatus.fortress, arg_73_3, arg_73_4, arg_73_5, BattleData.CardStatusVal.f2f_halo)
		end

		for iter_73_0 = 1, var_73_0 do
			arg_73_0._owner:incPositiveStatus(arg_73_0, {
				BattleData.PositiveType.xyzMark
			}, false, arg_73_3, arg_73_4, arg_73_5)
			arg_73_0._owner:incPositiveValue(arg_73_0, BattleData.PositiveType.xyzMark, 1, Data.AggregateType.sum, arg_73_3, arg_73_4, arg_73_5)

			arg_73_0._xyzMarkProviders[#arg_73_0._xyzMarkProviders + 1] = arg_73_2
		end

		return true
	else
		return false
	end
end

function var_0_0.addPuppetMark(arg_74_0, arg_74_1, arg_74_2, arg_74_3, arg_74_4, arg_74_5)
	local var_74_0 = arg_74_1

	if var_74_0 > 0 then
		for iter_74_0 = 1, var_74_0 do
			arg_74_0._owner:incPositiveStatus(arg_74_0, {
				BattleData.PositiveType.puppetMark
			}, false, arg_74_3, arg_74_4, arg_74_5)
			arg_74_0._owner:incPositiveValue(arg_74_0, BattleData.PositiveType.puppetMark, 1, Data.AggregateType.sum, arg_74_3, arg_74_4, arg_74_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addFateMark(arg_75_0, arg_75_1, arg_75_2, arg_75_3, arg_75_4, arg_75_5)
	local var_75_0 = arg_75_1

	if var_75_0 > 0 then
		for iter_75_0 = 1, var_75_0 do
			arg_75_0._owner:incPositiveStatus(arg_75_0, {
				BattleData.PositiveType.fateMark
			}, false, arg_75_3, arg_75_4, arg_75_5)
			arg_75_0._owner:incPositiveValue(arg_75_0, BattleData.PositiveType.fateMark, 1, Data.AggregateType.sum, arg_75_3, arg_75_4, arg_75_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addPotMark(arg_76_0, arg_76_1, arg_76_2, arg_76_3, arg_76_4, arg_76_5)
	local var_76_0 = arg_76_1
	local var_76_1 = arg_76_0:getBuffValue(true, BattleData.PositiveType.potMark)

	if var_76_0 > 0 then
		for iter_76_0 = 1, var_76_0 do
			arg_76_0._owner:incPositiveStatus(arg_76_0, {
				BattleData.PositiveType.potMark
			}, false, arg_76_3, arg_76_4, arg_76_5)
			arg_76_0._owner:incPositiveValue(arg_76_0, BattleData.PositiveType.potMark, 1, Data.AggregateType.sum, arg_76_3, arg_76_4, arg_76_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addYLYMark(arg_77_0, arg_77_1, arg_77_2, arg_77_3, arg_77_4, arg_77_5)
	local var_77_0 = arg_77_1
	local var_77_1 = arg_77_0:getBuffValue(true, BattleData.PositiveType.ylyMark)

	if var_77_0 > 0 then
		for iter_77_0 = 1, var_77_0 do
			arg_77_0._owner:incPositiveStatus(arg_77_0, {
				BattleData.PositiveType.ylyMark
			}, false, arg_77_3, arg_77_4, arg_77_5)
			arg_77_0._owner:incPositiveValue(arg_77_0, BattleData.PositiveType.ylyMark, 1, Data.AggregateType.sum, arg_77_3, arg_77_4, arg_77_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSideEffectMark(arg_78_0, arg_78_1, arg_78_2, arg_78_3, arg_78_4, arg_78_5)
	local var_78_0 = arg_78_1
	local var_78_1 = arg_78_0:getBuffValue(true, BattleData.PositiveType.sideEffectMark)

	if var_78_0 > 0 then
		for iter_78_0 = 1, var_78_0 do
			arg_78_0._owner:incPositiveStatus(arg_78_0, {
				BattleData.PositiveType.sideEffectMark
			}, false, arg_78_3, arg_78_4, arg_78_5)
			arg_78_0._owner:incPositiveValue(arg_78_0, BattleData.PositiveType.sideEffectMark, 1, Data.AggregateType.sum, arg_78_3, arg_78_4, arg_78_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addLineMark(arg_79_0, arg_79_1, arg_79_2, arg_79_3, arg_79_4, arg_79_5)
	local var_79_0 = arg_79_1

	if var_79_0 > 0 then
		for iter_79_0 = 1, var_79_0 do
			arg_79_0._owner:incPositiveStatus(arg_79_0, {
				BattleData.PositiveType.lineMark
			}, false, arg_79_3, arg_79_4, arg_79_5)
			arg_79_0._owner:incPositiveValue(arg_79_0, BattleData.PositiveType.lineMark, 1, Data.AggregateType.sum, arg_79_3, arg_79_4, arg_79_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addUniverseMark(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4, arg_80_5)
	local var_80_0 = arg_80_1

	if var_80_0 > 0 then
		for iter_80_0 = 1, var_80_0 do
			arg_80_0._owner:incPositiveStatus(arg_80_0, {
				BattleData.PositiveType.universeMark
			}, false, arg_80_3, arg_80_4, arg_80_5)
			arg_80_0._owner:incPositiveValue(arg_80_0, BattleData.PositiveType.universeMark, 1, Data.AggregateType.sum, arg_80_3, arg_80_4, arg_80_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addHsjMark(arg_81_0, arg_81_1, arg_81_2, arg_81_3, arg_81_4, arg_81_5)
	local var_81_0 = arg_81_1

	if var_81_0 > 0 then
		for iter_81_0 = 1, var_81_0 do
			arg_81_0._owner:incPositiveStatus(arg_81_0, {
				BattleData.PositiveType.hsjMark
			}, false, arg_81_3, arg_81_4, arg_81_5)
			arg_81_0._owner:incPositiveValue(arg_81_0, BattleData.PositiveType.hsjMark, 1, Data.AggregateType.sum, arg_81_3, arg_81_4, arg_81_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addBigSunMark(arg_82_0, arg_82_1, arg_82_2, arg_82_3, arg_82_4, arg_82_5)
	local var_82_0 = arg_82_1

	if var_82_0 > 0 then
		for iter_82_0 = 1, var_82_0 do
			arg_82_0._owner:incPositiveStatus(arg_82_0, {
				BattleData.PositiveType.bigSunMark
			}, false, arg_82_3, arg_82_4, arg_82_5)
			arg_82_0._owner:incPositiveValue(arg_82_0, BattleData.PositiveType.bigSunMark, 1, Data.AggregateType.sum, arg_82_3, arg_82_4, arg_82_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addDigMark(arg_83_0, arg_83_1, arg_83_2, arg_83_3, arg_83_4, arg_83_5)
	local var_83_0 = arg_83_1

	if var_83_0 > 0 then
		for iter_83_0 = 1, var_83_0 do
			arg_83_0._owner:incPositiveStatus(arg_83_0, {
				BattleData.PositiveType.digMark
			}, false, arg_83_3, arg_83_4, arg_83_5)
			arg_83_0._owner:incPositiveValue(arg_83_0, BattleData.PositiveType.digMark, 1, Data.AggregateType.sum, arg_83_3, arg_83_4, arg_83_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addAllyMark(arg_84_0, arg_84_1, arg_84_2, arg_84_3, arg_84_4, arg_84_5)
	local var_84_0 = arg_84_1

	if var_84_0 > 0 then
		for iter_84_0 = 1, var_84_0 do
			arg_84_0._owner:incPositiveStatus(arg_84_0, {
				BattleData.PositiveType.allyMark
			}, false, arg_84_3, arg_84_4, arg_84_5)
			arg_84_0._owner:incPositiveValue(arg_84_0, BattleData.PositiveType.allyMark, 1, Data.AggregateType.sum, arg_84_3, arg_84_4, arg_84_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addDDMark(arg_85_0, arg_85_1, arg_85_2, arg_85_3, arg_85_4, arg_85_5)
	local var_85_0 = arg_85_1

	if var_85_0 > 0 then
		for iter_85_0 = 1, var_85_0 do
			arg_85_0._owner:incPositiveStatus(arg_85_0, {
				BattleData.PositiveType.ddMark
			}, false, arg_85_3, arg_85_4, arg_85_5)
			arg_85_0._owner:incPositiveValue(arg_85_0, BattleData.PositiveType.ddMark, 1, Data.AggregateType.sum, arg_85_3, arg_85_4, arg_85_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSacriMark(arg_86_0, arg_86_1, arg_86_2, arg_86_3, arg_86_4, arg_86_5)
	local var_86_0 = arg_86_1

	if var_86_0 > 0 then
		for iter_86_0 = 1, var_86_0 do
			arg_86_0._owner:incPositiveStatus(arg_86_0, {
				BattleData.PositiveType.sacriMark
			}, false, arg_86_3, arg_86_4, arg_86_5)
			arg_86_0._owner:incPositiveValue(arg_86_0, BattleData.PositiveType.sacriMark, 1, Data.AggregateType.sum, arg_86_3, arg_86_4, arg_86_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addFireStarMark(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4, arg_87_5)
	local var_87_0 = arg_87_1

	if var_87_0 > 0 then
		for iter_87_0 = 1, var_87_0 do
			arg_87_0._owner:incPositiveStatus(arg_87_0, {
				BattleData.PositiveType.fireStarMark
			}, false, arg_87_3, arg_87_4, arg_87_5)
			arg_87_0._owner:incPositiveValue(arg_87_0, BattleData.PositiveType.fireStarMark, 1, Data.AggregateType.sum, arg_87_3, arg_87_4, arg_87_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addKoiMark(arg_88_0, arg_88_1, arg_88_2, arg_88_3, arg_88_4, arg_88_5)
	local var_88_0 = arg_88_1

	if var_88_0 > 0 then
		for iter_88_0 = 1, var_88_0 do
			arg_88_0._owner:incPositiveStatus(arg_88_0, {
				BattleData.PositiveType.koiMark
			}, false, arg_88_3, arg_88_4, arg_88_5)
			arg_88_0._owner:incPositiveValue(arg_88_0, BattleData.PositiveType.koiMark, 1, Data.AggregateType.sum, arg_88_3, arg_88_4, arg_88_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addGodMark(arg_89_0, arg_89_1, arg_89_2, arg_89_3, arg_89_4, arg_89_5)
	local var_89_0 = arg_89_1

	if var_89_0 > 0 then
		for iter_89_0 = 1, var_89_0 do
			arg_89_0._owner:incPositiveStatus(arg_89_0, {
				BattleData.PositiveType.godMark
			}, false, arg_89_3, arg_89_4, arg_89_5)
			arg_89_0._owner:incPositiveValue(arg_89_0, BattleData.PositiveType.godMark, 1, Data.AggregateType.sum, arg_89_3, arg_89_4, arg_89_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSummonMark(arg_90_0, arg_90_1, arg_90_2, arg_90_3, arg_90_4, arg_90_5)
	local var_90_0 = arg_90_1

	if var_90_0 > 0 then
		for iter_90_0 = 1, var_90_0 do
			arg_90_0._owner:incPositiveStatus(arg_90_0, {
				BattleData.PositiveType.summonMark
			}, false, arg_90_3, arg_90_4, arg_90_5)
			arg_90_0._owner:incPositiveValue(arg_90_0, BattleData.PositiveType.summonMark, 1, Data.AggregateType.sum, arg_90_3, arg_90_4, arg_90_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addDessertMark(arg_91_0, arg_91_1, arg_91_2, arg_91_3, arg_91_4, arg_91_5)
	local var_91_0 = arg_91_1

	if var_91_0 > 0 then
		for iter_91_0 = 1, var_91_0 do
			arg_91_0._owner:incPositiveStatus(arg_91_0, {
				BattleData.PositiveType.dessertMark
			}, false, arg_91_3, arg_91_4, arg_91_5)
			arg_91_0._owner:incPositiveValue(arg_91_0, BattleData.PositiveType.dessertMark, 1, Data.AggregateType.sum, arg_91_3, arg_91_4, arg_91_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addYiguaiMark(arg_92_0, arg_92_1, arg_92_2, arg_92_3, arg_92_4, arg_92_5)
	local var_92_0 = arg_92_1

	if var_92_0 > 0 then
		for iter_92_0 = 1, var_92_0 do
			arg_92_0._owner:incPositiveStatus(arg_92_0, {
				BattleData.PositiveType.yiguaiMark
			}, false, arg_92_3, arg_92_4, arg_92_5)
			arg_92_0._owner:incPositiveValue(arg_92_0, BattleData.PositiveType.yiguaiMark, 1, Data.AggregateType.sum, arg_92_3, arg_92_4, arg_92_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addCrystalMark(arg_93_0, arg_93_1, arg_93_2, arg_93_3, arg_93_4, arg_93_5)
	local var_93_0 = arg_93_1

	if var_93_0 > 0 then
		for iter_93_0 = 1, var_93_0 do
			arg_93_0._owner:incPositiveStatus(arg_93_0, {
				BattleData.PositiveType.crystalMark
			}, false, arg_93_3, arg_93_4, arg_93_5)
			arg_93_0._owner:incPositiveValue(arg_93_0, BattleData.PositiveType.crystalMark, 1, Data.AggregateType.sum, arg_93_3, arg_93_4, arg_93_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addMagicCardMark(arg_94_0, arg_94_1, arg_94_2, arg_94_3, arg_94_4, arg_94_5)
	local var_94_0 = arg_94_1

	if var_94_0 > 0 then
		for iter_94_0 = 1, var_94_0 do
			arg_94_0._owner:incPositiveStatus(arg_94_0, {
				BattleData.PositiveType.magicCardMark
			}, false, arg_94_3, arg_94_4, arg_94_5)
			arg_94_0._owner:incPositiveValue(arg_94_0, BattleData.PositiveType.magicCardMark, 1, Data.AggregateType.sum, arg_94_3, arg_94_4, arg_94_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addTrapCardMark(arg_95_0, arg_95_1, arg_95_2, arg_95_3, arg_95_4, arg_95_5)
	local var_95_0 = arg_95_1

	if var_95_0 > 0 then
		for iter_95_0 = 1, var_95_0 do
			arg_95_0._owner:incPositiveStatus(arg_95_0, {
				BattleData.PositiveType.trapCardMark
			}, false, arg_95_3, arg_95_4, arg_95_5)
			arg_95_0._owner:incPositiveValue(arg_95_0, BattleData.PositiveType.trapCardMark, 1, Data.AggregateType.sum, arg_95_3, arg_95_4, arg_95_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addGuangboMark(arg_96_0, arg_96_1, arg_96_2, arg_96_3, arg_96_4, arg_96_5)
	local var_96_0 = arg_96_1

	if var_96_0 > 0 then
		for iter_96_0 = 1, var_96_0 do
			arg_96_0._owner:incPositiveStatus(arg_96_0, {
				BattleData.PositiveType.guangboMark
			}, false, arg_96_3, arg_96_4, arg_96_5)
			arg_96_0._owner:incPositiveValue(arg_96_0, BattleData.PositiveType.guangboMark, 1, Data.AggregateType.sum, arg_96_3, arg_96_4, arg_96_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addYingyiMark(arg_97_0, arg_97_1, arg_97_2, arg_97_3, arg_97_4, arg_97_5)
	local var_97_0 = arg_97_1
	local var_97_1 = arg_97_0:getBuffValue(true, BattleData.PositiveType.yingyiMark)

	if arg_97_0:isMonsterRare() then
		if var_97_1 < 1 then
			var_97_0 = math.min(arg_97_1, 1 - var_97_1)
		else
			var_97_0 = 0
		end
	end

	if var_97_0 > 0 then
		for iter_97_0 = 1, var_97_0 do
			arg_97_0._owner:incPositiveStatus(arg_97_0, {
				BattleData.PositiveType.yingyiMark
			}, false, arg_97_3, arg_97_4, arg_97_5)
			arg_97_0._owner:incPositiveValue(arg_97_0, BattleData.PositiveType.yingyiMark, 1, Data.AggregateType.sum, arg_97_3, arg_97_4, arg_97_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addBianMark(arg_98_0, arg_98_1, arg_98_2, arg_98_3, arg_98_4, arg_98_5)
	local var_98_0 = arg_98_1
	local var_98_1 = arg_98_0:getBuffValue(true, BattleData.PositiveType.bianMark)

	if var_98_0 > 0 then
		for iter_98_0 = 1, var_98_0 do
			arg_98_0._owner:incPositiveStatus(arg_98_0, {
				BattleData.PositiveType.bianMark
			}, false, arg_98_3, arg_98_4, arg_98_5)
			arg_98_0._owner:incPositiveValue(arg_98_0, BattleData.PositiveType.bianMark, 1, Data.AggregateType.sum, arg_98_3, arg_98_4, arg_98_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addSixFlowerMark(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4, arg_99_5)
	local var_99_0 = arg_99_1
	local var_99_1 = arg_99_0:getBuffValue(true, BattleData.PositiveType.sixFlowerMark)

	if var_99_0 > 0 then
		for iter_99_0 = 1, var_99_0 do
			arg_99_0._owner:incPositiveStatus(arg_99_0, {
				BattleData.PositiveType.sixFlowerMark
			}, false, arg_99_3, arg_99_4, arg_99_5)
			arg_99_0._owner:incPositiveValue(arg_99_0, BattleData.PositiveType.sixFlowerMark, 1, Data.AggregateType.sum, arg_99_3, arg_99_4, arg_99_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addHuanmoMark(arg_100_0, arg_100_1, arg_100_2, arg_100_3, arg_100_4, arg_100_5)
	local var_100_0 = arg_100_1
	local var_100_1 = arg_100_0:getBuffValue(true, BattleData.PositiveType.huanmoMark)

	if var_100_0 > 0 then
		for iter_100_0 = 1, var_100_0 do
			arg_100_0._owner:incPositiveStatus(arg_100_0, {
				BattleData.PositiveType.huanmoMark
			}, false, arg_100_3, arg_100_4, arg_100_5)
			arg_100_0._owner:incPositiveValue(arg_100_0, BattleData.PositiveType.huanmoMark, 1, Data.AggregateType.sum, arg_100_3, arg_100_4, arg_100_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addGunMark(arg_101_0, arg_101_1, arg_101_2, arg_101_3, arg_101_4, arg_101_5)
	local var_101_0 = arg_101_1
	local var_101_1 = arg_101_0:getBuffValue(true, BattleData.PositiveType.gunMark)

	if var_101_0 > 0 then
		for iter_101_0 = 1, var_101_0 do
			arg_101_0._owner:incPositiveStatus(arg_101_0, {
				BattleData.PositiveType.gunMark
			}, false, arg_101_3, arg_101_4, arg_101_5)
			arg_101_0._owner:incPositiveValue(arg_101_0, BattleData.PositiveType.gunMark, 1, Data.AggregateType.sum, arg_101_3, arg_101_4, arg_101_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addBjjMark(arg_102_0, arg_102_1, arg_102_2, arg_102_3, arg_102_4, arg_102_5)
	local var_102_0 = arg_102_1
	local var_102_1 = arg_102_0:getBuffValue(true, BattleData.PositiveType.bjjMark)

	if var_102_0 > 0 then
		for iter_102_0 = 1, var_102_0 do
			arg_102_0._owner:incPositiveStatus(arg_102_0, {
				BattleData.PositiveType.bjjMark
			}, false, arg_102_3, arg_102_4, arg_102_5)
			arg_102_0._owner:incPositiveValue(arg_102_0, BattleData.PositiveType.bjjMark, 1, Data.AggregateType.sum, arg_102_3, arg_102_4, arg_102_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.addNewLiveMark(arg_103_0, arg_103_1, arg_103_2, arg_103_3, arg_103_4, arg_103_5)
	local var_103_0 = arg_103_1
	local var_103_1 = arg_103_0:getBuffValue(true, BattleData.PositiveType.newLiveMark)

	if var_103_0 > 0 then
		for iter_103_0 = 1, var_103_0 do
			arg_103_0._owner:incPositiveStatus(arg_103_0, {
				BattleData.PositiveType.newLiveMark
			}, false, arg_103_3, arg_103_4, arg_103_5)
			arg_103_0._owner:incPositiveValue(arg_103_0, BattleData.PositiveType.newLiveMark, 1, Data.AggregateType.sum, arg_103_3, arg_103_4, arg_103_5)
		end

		return true
	else
		return false
	end
end

function var_0_0.removeMark(arg_104_0, arg_104_1, arg_104_2, arg_104_3)
	local var_104_0 = arg_104_0:getBuffValue(true, arg_104_1)

	if not arg_104_3 and var_104_0 <= 0 then
		return 0
	end

	if arg_104_1 == BattleData.PositiveType.magicMark and arg_104_0:hasSkills({
		6055,
		6078,
		6123
	}) or arg_104_1 == BattleData.PositiveType.deathMark and arg_104_0:hasSkills({
		6105
	}) or arg_104_1 == BattleData.PositiveType.satelliteMark and arg_104_0:hasSkills({
		3400
	}) or arg_104_1 == BattleData.PositiveType.snowMark and arg_104_0:hasSkills({
		6127
	}) or arg_104_1 == BattleData.PositiveType.stormMark or arg_104_1 == BattleData.PositiveType.xyzMark and arg_104_0:hasSkillFast(13212) then
		arg_104_0._owner:setCardStatus(arg_104_0._owner._fortress, BattleData.CardStatus.fortress, cid, id, mode, BattleData.CardStatusVal.f2f_halo)
	end

	local var_104_1 = 0
	local var_104_2 = 1

	while true do
		local var_104_3 = arg_104_0._underSkills[var_104_2]

		if var_104_3 == nil then
			break
		end

		if var_104_3._positiveType == arg_104_1 then
			table.remove(arg_104_0._underSkills, var_104_2)

			var_104_1 = var_104_1 + 1

			if var_104_1 == arg_104_2 then
				break
			end

			var_104_2 = var_104_2 - 1
		end

		var_104_2 = var_104_2 + 1
	end

	if arg_104_3 and var_104_1 < arg_104_2 and arg_104_0._owner._fieldCard ~= nil then
		local var_104_4 = arg_104_0._owner._fieldCard:removeMark(arg_104_1, arg_104_2 - var_104_1)

		if var_104_4 > 0 then
			arg_104_0._owner._usedFieldMark = true
		end

		var_104_1 = var_104_1 + var_104_4
	end

	return var_104_1
end

function var_0_0.hasXYZMarkProviderInKeyword(arg_105_0, arg_105_1)
	return #B.filterInKeywordCards(arg_105_0._xyzMarkProviders or {}, arg_105_1) > 0
end

function var_0_0.hasXYZMarkProviderInXYZ(arg_106_0)
	return #B.filterXYZCards(arg_106_0._xyzMarkProviders or {}, true) > 0
end

function var_0_0.hasXYZMarkProviderInKeywordAndXYZ(arg_107_0, arg_107_1)
	return #B.filterXYZCards(B.filterInKeywordCards(arg_107_0._xyzMarkProviders or {}, arg_107_1), true) > 0
end

function var_0_0.hasXYZMarkProviderInInfoId(arg_108_0, arg_108_1)
	if #B.filterEqualInfoIdCards(arg_108_0._xyzMarkProviders or {}, arg_108_1) > 0 then
		return true
	end

	if arg_108_1 == Data._skillInfo[9975]._refCards[1] then
		for iter_108_0 = 1, #arg_108_0._xyzMarkProviders do
			if arg_108_0._xyzMarkProviders[iter_108_0]._mark9962 then
				return true
			end
		end
	end

	return false
end

function var_0_0.baseResetSkills(arg_109_0, arg_109_1)
	if not arg_109_0._info then
		return
	end

	if arg_109_0._is5078Card then
		return
	end

	local var_109_0 = {}

	for iter_109_0 = 1, #arg_109_0._info._skillId do
		local var_109_1 = arg_109_0._info._skillId[iter_109_0]

		if var_109_1 ~= 0 then
			var_109_0[#var_109_0 + 1] = var_109_1
		end
	end

	if arg_109_0._extraSid and arg_109_0._extraSid > 0 then
		var_109_0[#var_109_0 + 1] = arg_109_0._extraSid
	end

	if arg_109_0._owner and arg_109_0._owner._extraSkills then
		for iter_109_1, iter_109_2 in ipairs(arg_109_0._owner._extraSkills) do
			if iter_109_2.card == arg_109_0._infoId then
				for iter_109_3, iter_109_4 in ipairs(iter_109_2.skills) do
					var_109_0[#var_109_0 + 1] = math.floor(iter_109_4 / Data.INFO_ID_FRAGMENT_SIZE_LARGE)
				end
			end
		end
	end

	if arg_109_0._extraSkillId ~= nil then
		var_109_0[#var_109_0 + 1] = arg_109_0._extraSkillId
	end

	for iter_109_5 = 1, #var_109_0 do
		local var_109_2 = var_109_0[iter_109_5]

		if var_109_2 == 0 then
			break
		end

		local var_109_3 = Data._skillInfo[var_109_2]

		if not arg_109_1 or not B.skillInfoHasMode(var_109_3, Data.SkillMode.bcs2gl) then
			local var_109_4 = {
				_id = var_109_2,
				_maxLevel = math.min(CardHelper.getSkillMaxLevel(var_109_2), arg_109_0:getSkillLevel(iter_109_5) + (arg_109_0._skillMaxLevelInc[var_109_2] or 0)),
				_modes = var_109_3._modes,
				_priority = var_109_3._priority,
				_count = var_109_3._count,
				_owner = arg_109_0
			}

			table.insert(arg_109_0._skills, var_109_4)
		end
	end

	local var_109_5

	if arg_109_0:isSync() then
		var_109_5 = 3851
	elseif arg_109_0:isXYZ() then
		var_109_5 = 6753
	elseif arg_109_0:isLink() then
		var_109_5 = 9298
	end

	if var_109_5 ~= nil then
		local var_109_6 = Data._skillInfo[var_109_5]
		local var_109_7 = {
			_id = var_109_5,
			_maxLevel = math.min(CardHelper.getSkillMaxLevel(var_109_5), arg_109_0:getSkillLevel(i) + (arg_109_0._skillMaxLevelInc[var_109_5] or 0)),
			_modes = var_109_6._modes,
			_priority = var_109_6._priority,
			_count = var_109_6._count,
			_owner = arg_109_0
		}

		table.insert(arg_109_0._skills, var_109_7)
	end
end

function var_0_0.resetSkills(arg_110_0)
	for iter_110_0, iter_110_1 in ipairs(arg_110_0._skills) do
		iter_110_1._level = iter_110_1._maxLevel
		iter_110_1._castTimes = 0
		iter_110_1._totalCastedTimes = 0
	end
end

function var_0_0.addSkill(arg_111_0, arg_111_1, arg_111_2, arg_111_3)
	for iter_111_0 = 1, #arg_111_0._skills do
		local var_111_0 = arg_111_0._skills[iter_111_0]

		if var_111_0._id == arg_111_1 then
			if arg_111_2 > var_111_0._maxLevel then
				if var_111_0._saved == nil then
					var_111_0._saved = {
						_maxLevel = var_111_0._maxLevel,
						_provider = var_111_0._provider
					}
				end

				var_111_0._maxLevel = math.min(arg_111_2, CardHelper.getSkillMaxLevel(arg_111_1))
				var_111_0._provider = arg_111_3

				arg_111_0:updateSkillLevel()
			end

			return var_111_0
		end
	end

	local var_111_1 = B.createSkill(arg_111_1, arg_111_2, arg_111_0)

	var_111_1._provider = arg_111_3

	table.insert(arg_111_0._skills, var_111_1)

	return var_111_1
end

function var_0_0.removeSkillById(arg_112_0, arg_112_1)
	for iter_112_0 = 1, #arg_112_0._skills do
		local var_112_0 = arg_112_0._skills[iter_112_0]

		if var_112_0._id == arg_112_1 then
			if var_112_0._saved ~= nil then
				var_112_0._maxLevel = var_112_0._saved._maxLevel
				var_112_0._provider = var_112_0._saved._provider
				var_112_0._saved = nil

				arg_112_0:updateSkillLevel()
			else
				table.remove(arg_112_0._skills, iter_112_0)
			end

			return
		end
	end
end

function var_0_0.removeSkill(arg_113_0, arg_113_1, arg_113_2)
	for iter_113_0 = 1, #arg_113_0._skills do
		local var_113_0 = arg_113_0._skills[iter_113_0]

		if var_113_0._id == arg_113_1 and var_113_0._provider == arg_113_2 then
			if var_113_0._saved ~= nil then
				var_113_0._maxLevel = var_113_0._saved._maxLevel
				var_113_0._provider = var_113_0._saved._provider
				var_113_0._saved = nil

				arg_113_0:updateSkillLevel()
			else
				table.remove(arg_113_0._skills, iter_113_0)
			end

			return
		end
	end
end

function var_0_0.removeSkills(arg_114_0, arg_114_1)
	local var_114_0 = {}
	local var_114_1 = 1

	while true do
		local var_114_2 = arg_114_0._skills[var_114_1]

		if var_114_2 == nil then
			break
		end

		if var_114_2._provider == arg_114_1 then
			var_114_0[var_114_2._id] = var_114_2._totalCastedTimes

			if var_114_2._saved ~= nil then
				var_114_2._maxLevel = var_114_2._saved._maxLevel
				var_114_2._provider = nil
				var_114_2._saved = nil

				arg_114_0:updateSkillLevel()

				var_114_1 = var_114_1 + 1
			else
				table.remove(arg_114_0._skills, var_114_1)
			end
		else
			var_114_1 = var_114_1 + 1
		end
	end

	return var_114_0
end

function var_0_0.getSkillsByProvider(arg_115_0, arg_115_1)
	local var_115_0 = {}

	for iter_115_0 = 1, #arg_115_0._skills do
		local var_115_1 = arg_115_0._skills[iter_115_0]

		if var_115_1._provider == arg_115_1 then
			table.insert(var_115_0, var_115_1)
		end
	end

	return var_115_0
end

function var_0_0.accountExtraSkill(arg_116_0)
	local var_116_0 = arg_116_0:removeSkills(BattleData.SkillProvider.extra)
	local var_116_1 = arg_116_0:getBuffValue(true, BattleData.PositiveType.extraSkill)

	if var_116_1 ~= nil and type(var_116_1) == "table" and #var_116_1 > 0 then
		for iter_116_0 = 1, #var_116_1 do
			local var_116_2 = var_116_1[iter_116_0] % 65536
			local var_116_3 = math.floor(var_116_1[iter_116_0] / 65536)
			local var_116_4 = arg_116_0:addSkill(var_116_2, var_116_3, BattleData.SkillProvider.extra)

			if var_116_0[var_116_2] ~= nil then
				var_116_4._totalCastedTimes = var_116_0[var_116_2]
			end
		end
	end
end

function var_0_0.updateSkillLevel(arg_117_0)
	local var_117_0 = arg_117_0._skillLevelInc

	for iter_117_0 = 1, #arg_117_0._underSkills do
		local var_117_1 = arg_117_0._underSkills[iter_117_0]

		if var_117_1._disabled ~= true and var_117_1._skillLevelInc ~= nil then
			var_117_0 = var_117_0 + var_117_1._skillLevelInc
		end
	end

	for iter_117_1 = 1, #arg_117_0._skills do
		local var_117_2 = arg_117_0._skills[iter_117_1]

		var_117_2._level = math.min(var_117_2._maxLevel + var_117_0, CardHelper.getSkillMaxLevel(var_117_2._id))
	end
end

local var_0_1 = {
	2010,
	2012,
	2013,
	2020,
	2025,
	2027,
	2028,
	2029,
	2031,
	2035,
	2038,
	2040,
	2041,
	2042,
	2048,
	2059,
	2066,
	2070,
	2072,
	2077,
	2078,
	2079,
	2089,
	2121,
	2427,
	2446,
	2468,
	2511,
	2547,
	2603,
	2679,
	2851,
	2860,
	2861,
	2862,
	2863,
	2864,
	2865,
	2866,
	2941,
	2943,
	9016,
	9293,
	9329,
	9355,
	9405,
	13041,
	13050,
	13227,
	13470,
	13543,
	13544,
	13669,
	13974,
	14253,
	14442,
	14445
}
local var_0_2 = {
	1138,
	1143,
	1146,
	1152,
	1156,
	1164,
	2015,
	2016,
	2017,
	2018,
	2021,
	2023,
	2024,
	2026,
	2032,
	2034,
	2036,
	2043,
	2044,
	2045,
	2046,
	2050,
	2052,
	2053,
	2064,
	2071,
	2073,
	2080,
	2083,
	2084,
	2086,
	2087,
	2197,
	2397,
	2428,
	2478,
	2485,
	2493,
	2702,
	2815,
	3785,
	3786,
	3944,
	4285,
	4287,
	9176,
	9272,
	13557,
	13659,
	13919
}

function var_0_0.getSkillsByMode(arg_118_0, arg_118_1, arg_118_2)
	local var_118_0 = {}
	local var_118_1 = arg_118_0._owner._actionCard or arg_118_0._owner._opponent._actionCard

	if arg_118_1 == Data.SkillMode.initiative_bcs or arg_118_1 == Data.SkillMode.initiative_grave or arg_118_1 == Data.SkillMode.initiative_rare or arg_118_1 == Data.SkillMode.initiative_hand or arg_118_1 == Data.SkillMode.initiative_leave then
		local var_118_2 = arg_118_0._choice and math.floor(arg_118_0._choice / BattleData.ChoiceId.stage_3) % BattleData.ChoiceId.stage_size_3 or 0

		var_118_0 = {
			arg_118_0._skills[var_118_2]
		}

		if arg_118_1 == Data.SkillMode.initiative_hand then
			local var_118_3 = arg_118_0._owner._opponent:getBattleCardsByInfoId("G", 12232)

			for iter_118_0 = 1, #var_118_3 do
				table.insert(var_118_0, var_118_3[iter_118_0]:getSkillById(14207))
			end
		end

		return var_118_0
	end

	if arg_118_0:isMonsterRare() then
		for iter_118_1 = 1, #arg_118_0._skills do
			local var_118_4 = arg_118_0._skills[iter_118_1]

			if B.skillHasMode(var_118_4, arg_118_1) then
				table.insert(var_118_0, var_118_4)
			end
		end

		if arg_118_0._owner._fortressSkill ~= nil and B.skillHasMode(arg_118_0._owner._fortressSkill, arg_118_1) then
			table.insert(var_118_0, arg_118_0._owner._fortressSkill)
		end

		for iter_118_2 = BattleData.PositiveType.shieldBegin, BattleData.PositiveType.shieldEnd do
			if arg_118_0:hasBuff(true, iter_118_2) then
				local var_118_5 = Data._skillInfo[iter_118_2 - BattleData.PositiveType.shieldBegin + 11001]
				local var_118_6 = {
					_maxLevel = 1,
					_totalCastedTimes = 0,
					_id = var_118_5._id,
					_level = arg_118_0._level,
					_modes = var_118_5._modes,
					_priority = var_118_5._priority,
					_count = var_118_5._count,
					_owner = arg_118_0
				}

				if B.skillHasMode(var_118_6, arg_118_1) then
					table.insert(var_118_0, var_118_6)
				end
			end
		end

		for iter_118_3 = 0, BattleData.PositiveType.shieldExEnd - BattleData.PositiveType.shieldExBegin do
			if arg_118_0:hasBuff(true, BattleData.PositiveType.shieldExBegin + iter_118_3) or arg_118_0:hasBuff(true, BattleData.PositiveType.shieldHaloBegin + iter_118_3) then
				local var_118_7 = Data._skillInfo[iter_118_3 + 12001]
				local var_118_8 = {
					_maxLevel = 1,
					_totalCastedTimes = 0,
					_id = var_118_7._id,
					_level = arg_118_0._level,
					_modes = var_118_7._modes,
					_priority = var_118_7._priority,
					_count = var_118_7._count,
					_owner = arg_118_0
				}

				if B.skillHasMode(var_118_8, arg_118_1) then
					table.insert(var_118_0, var_118_8)
				end
			end
		end

		for iter_118_4 = BattleData.PositiveType.shieldDestroy, BattleData.PositiveType.shieldHaloEffectDestroy do
			if arg_118_0:hasBuff(true, iter_118_4) then
				local var_118_9 = Data._skillInfo[(iter_118_4 == BattleData.PositiveType.shieldEffectDestroy or iter_118_4 == BattleData.PositiveType.shieldHaloEffectDestroy) and 12007 or 12006]
				local var_118_10 = {
					_maxLevel = 1,
					_totalCastedTimes = 0,
					_id = var_118_9._id,
					_level = arg_118_0._level,
					_modes = var_118_9._modes,
					_priority = var_118_9._priority,
					_count = var_118_9._count,
					_owner = arg_118_0
				}

				if B.skillHasMode(var_118_10, arg_118_1) then
					table.insert(var_118_0, var_118_10)
				end
			end
		end

		for iter_118_5 = BattleData.PositiveType.shieldOppoMonster, BattleData.PositiveType.shieldOppoTrap do
			if arg_118_0:hasBuff(true, iter_118_5) then
				local var_118_11 = Data._skillInfo[12008 + iter_118_5 - BattleData.PositiveType.shieldOppoMonster]
				local var_118_12 = {
					_maxLevel = 1,
					_totalCastedTimes = 0,
					_id = var_118_11._id,
					_level = arg_118_0._level,
					_modes = var_118_11._modes,
					_priority = var_118_11._priority,
					_count = var_118_11._count,
					_owner = arg_118_0
				}

				if B.skillHasMode(var_118_12, arg_118_1) then
					table.insert(var_118_0, var_118_12)
				end
			end
		end

		for iter_118_6 = BattleData.PositiveType.shieldHaloOppoMonster, BattleData.PositiveType.shieldHaloOppoTrap do
			if arg_118_0:hasBuff(true, iter_118_6) then
				local var_118_13 = Data._skillInfo[12008 + iter_118_6 - BattleData.PositiveType.shieldHaloOppoMonster]
				local var_118_14 = {
					_maxLevel = 1,
					_totalCastedTimes = 0,
					_id = var_118_13._id,
					_level = arg_118_0._level,
					_modes = var_118_13._modes,
					_priority = var_118_13._priority,
					_count = var_118_13._count,
					_owner = arg_118_0
				}

				if B.skillHasMode(var_118_14, arg_118_1) then
					table.insert(var_118_0, var_118_14)
				end
			end
		end

		if arg_118_0._mark5272 then
			local var_118_15 = Data._skillInfo[12006]
			local var_118_16 = {
				_maxLevel = 1,
				_totalCastedTimes = 0,
				_id = var_118_15._id,
				_level = arg_118_0._level,
				_modes = var_118_15._modes,
				_priority = var_118_15._priority,
				_count = var_118_15._count,
				_owner = arg_118_0
			}

			if B.skillHasMode(var_118_16, arg_118_1) then
				table.insert(var_118_0, var_118_16)
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[2092]._refCards[1]) then
			local var_118_17, var_118_18 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2092
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_7 = 1, #var_118_18 do
				table.insert(var_118_0, var_118_18[iter_118_7])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0._info._category == Data._skillInfo[6026]._refCards[1] then
			local var_118_19, var_118_20 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6026
			})

			for iter_118_8 = 1, #var_118_20 do
				table.insert(var_118_0, var_118_20[iter_118_8])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0._info._category == Data._skillInfo[4144]._refCards[1] then
			local var_118_21, var_118_22 = arg_118_0._owner:getBattleCardsBySkills("G", {
				4144
			})

			for iter_118_9 = 1, #var_118_22 do
				table.insert(var_118_0, var_118_22[iter_118_9])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0:isKeyword(Data._skillInfo[4663]._refCards[1]) and arg_118_0:isXYZ() then
			local var_118_23, var_118_24 = arg_118_0._owner:getBattleCardsBySkills("G", {
				4663
			})

			for iter_118_10 = 1, #var_118_24 do
				table.insert(var_118_0, var_118_24[iter_118_10])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0._info._category == Data._skillInfo[6106]._refCards[1] then
			local var_118_25, var_118_26 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6106
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_11 = 1, #var_118_26 do
				if not var_118_26[iter_118_11]._owner:hasChangeStatusUnderSkill({
					BattleData.CardStatus.grave,
					BattleData.CardStatus.leave
				}) then
					table.insert(var_118_0, var_118_26[iter_118_11])
				end
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0._info._category == Data._skillInfo[5111]._refCards[1] and arg_118_0._summonByNormal and arg_118_0:getStar() ~= Data.XYZ_STAR and arg_118_0:getStar() >= Data._skillInfo[5111]._val[1] then
			local var_118_27, var_118_28 = arg_118_0._owner:getBattleCardsBySkills("S", {
				5111
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_12 = 1, #var_118_28 do
				if not var_118_28[iter_118_12]._owner:hasChangeStatusUnderSkill({
					BattleData.CardStatus.grave,
					BattleData.CardStatus.leave
				}) then
					table.insert(var_118_0, var_118_28[iter_118_12])
				end
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._info._category == Data._skillInfo[6119]._refCards[1] then
			local var_118_29, var_118_30 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6119
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_13 = 1, #var_118_30 do
				if not var_118_30[iter_118_13]._owner:hasBuff(true, BattleData.PositiveType.defendPosture) then
					table.insert(var_118_0, var_118_30[iter_118_13])
				end
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[6146]._refCards[1]) then
			local var_118_31, var_118_32 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6146
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_14 = 1, #var_118_32 do
				table.insert(var_118_0, var_118_32[iter_118_14])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._info._category == Data._skillInfo[6155]._refCards[1] then
			local var_118_33, var_118_34 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6155
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_15 = 1, #var_118_34 do
				table.insert(var_118_0, var_118_34[iter_118_15])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._info._category == Data._skillInfo[6157]._refCards[1] then
			local var_118_35, var_118_36 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6157
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_16 = 1, #var_118_36 do
				table.insert(var_118_0, var_118_36[iter_118_16])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_37, var_118_38 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6173
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_17 = 1, #var_118_38 do
				table.insert(var_118_0, var_118_38[iter_118_17])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._mark3521 then
			local var_118_39, var_118_40 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6174
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_18 = 1, #var_118_40 do
				table.insert(var_118_0, var_118_40[iter_118_18])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[6184]._refCards[2]) then
			local var_118_41, var_118_42 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6184
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_19 = 1, #var_118_42 do
				table.insert(var_118_0, var_118_42[iter_118_19])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isProtectedBy6189() then
			local var_118_43, var_118_44 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6189
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_20 = 1, #var_118_44 do
				table.insert(var_118_0, var_118_44[iter_118_20])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_45, var_118_46 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6190
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_21 = 1, #var_118_46 do
				table.insert(var_118_0, var_118_46[iter_118_21])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_47, var_118_48 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6215
			})

			for iter_118_22 = 1, #var_118_48 do
				table.insert(var_118_0, var_118_48[iter_118_22])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[6283]._refCards[1]) and arg_118_0._owner:checkHandCardsYongHuo() then
			local var_118_49, var_118_50 = arg_118_0._owner:getBattleCardsBySkills("G", {
				6283
			})

			for iter_118_23 = 1, #var_118_50 do
				table.insert(var_118_0, var_118_50[iter_118_23])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._info._category == Data._skillInfo[6297]._refCards[1] then
			local var_118_51, var_118_52 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6297
			})

			for iter_118_24 = 1, #var_118_52 do
				table.insert(var_118_0, var_118_52[iter_118_24])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_53, var_118_54 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6325
			})

			for iter_118_25 = 1, #var_118_54 do
				table.insert(var_118_0, var_118_54[iter_118_25])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[6366]._refCards[1]) then
			local var_118_55, var_118_56 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6366
			})

			for iter_118_26 = 1, #var_118_56 do
				table.insert(var_118_0, var_118_56[iter_118_26])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0:isAdjust() then
			local var_118_57, var_118_58 = arg_118_0._owner:getBattleCardsBySkills("H", {
				6411
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_27 = 1, #var_118_58 do
				table.insert(var_118_0, var_118_58[iter_118_27])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and (var_118_1 == nil or not var_118_1:isMonsterRare() or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldMonster)) and (var_118_1 == nil or var_118_1._type ~= Data.CardType.magic or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldMagic)) and (var_118_1 == nil or var_118_1._type ~= Data.CardType.trap or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldTrap)) then
			local var_118_59, var_118_60 = arg_118_0._owner:getBattleCardsBySkills("GH", {
				6413
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_28 = 1, #var_118_60 do
				table.insert(var_118_0, var_118_60[iter_118_28])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0:isKeyword(Data._skillInfo[6483]._refCards[1]) and not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldAttack) then
			local var_118_61, var_118_62 = arg_118_0._owner:getBattleCardsBySkills("H", {
				6483
			})

			for iter_118_29 = 1, #var_118_62 do
				table.insert(var_118_0, var_118_62[iter_118_29])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[6492]._refCards[1]) then
			local var_118_63, var_118_64 = arg_118_0._owner:getBattleCardsBySkills("G", {
				6492
			})

			for iter_118_30 = 1, #var_118_64 do
				table.insert(var_118_0, var_118_64[iter_118_30])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_65, var_118_66 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6542
			})

			for iter_118_31 = 1, #var_118_66 do
				table.insert(var_118_0, var_118_66[iter_118_31])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isInfoId(Data._skillInfo[6607]._refCards[1]) and not arg_118_0:hasSkillFast(6607) then
			local var_118_67, var_118_68 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6607
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_32 = 1, #var_118_68 do
				table.insert(var_118_0, var_118_68[iter_118_32])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[6645]._refCards[1]) and (var_118_1 == nil or not var_118_1:isMonsterRare() or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldMonster)) and (var_118_1 == nil or var_118_1._type ~= Data.CardType.magic or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldMagic)) and (var_118_1 == nil or var_118_1._type ~= Data.CardType.trap or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldTrap)) then
			local var_118_69, var_118_70 = arg_118_0._owner:getBattleCardsBySkills("H", {
				6645
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_33 = 1, #var_118_70 do
				table.insert(var_118_0, var_118_70[iter_118_33])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0:isKeyword(Data._skillInfo[6645]._refCards[1]) and (var_118_1 == nil or not var_118_1:isMonsterRare() or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldAttack)) then
			local var_118_71, var_118_72 = arg_118_0._owner:getBattleCardsBySkills("H", {
				6645
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_34 = 1, #var_118_72 do
				table.insert(var_118_0, var_118_72[iter_118_34])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0:isKeyword(Data._skillInfo[6687]._refCards[1]) then
			local var_118_73, var_118_74 = arg_118_0._owner:getBattleCardsBySkills("G", {
				6687
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_35 = 1, #var_118_74 do
				table.insert(var_118_0, var_118_74[iter_118_35])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[6825]._refCards[1]) then
			local var_118_75, var_118_76 = arg_118_0._owner:getBattleCardsBySkills("H", {
				6825
			})

			for iter_118_36 = 1, #var_118_76 do
				table.insert(var_118_0, var_118_76[iter_118_36])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0._info._category == Data._skillInfo[6851]._refCards[2] then
			local var_118_77, var_118_78 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6851
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_37 = 1, #var_118_78 do
				table.insert(var_118_0, var_118_78[iter_118_37])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[6904]._refCards[1]) then
			local var_118_79, var_118_80 = arg_118_0._owner:getBattleCardsBySkills("G", {
				6904
			})

			for iter_118_38 = 1, #var_118_80 do
				table.insert(var_118_0, var_118_80[iter_118_38])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[6918]._refCards[1]) and arg_118_0._info._category == Data._skillInfo[6918]._refCards[2] then
			local var_118_81, var_118_82 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6918
			})

			for iter_118_39 = 1, #var_118_82 do
				table.insert(var_118_0, var_118_82[iter_118_39])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._info._category == Data._skillInfo[6936]._refCards[1] and var_118_1 ~= nil and var_118_1._owner ~= arg_118_0._owner and (var_118_1:isMonsterRare() or var_118_1._type == Data.CardType.magic and var_118_1._info._targetType == 1 and var_118_1:getActionCardMagicTarget() == arg_118_0 or var_118_1._type == Data.CardType.trap and var_118_1._info._targetType == 1 and var_118_1:getActionCardTrapTarget() == arg_118_0) then
			local var_118_83, var_118_84 = arg_118_0._owner:getBattleCardsBySkills("HG", {
				6936
			})

			for iter_118_40 = 1, #var_118_84 do
				table.insert(var_118_0, var_118_84[iter_118_40])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._info._category == Data._skillInfo[6937]._refCards[1] and arg_118_0:getStar() ~= Data.XYZ_STAR and arg_118_0:getStar() >= Data._skillInfo[6937]._val[1] then
			local var_118_85, var_118_86 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6937
			})

			for iter_118_41 = 1, #var_118_86 do
				table.insert(var_118_0, var_118_86[iter_118_41])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[2201]._refCards[1]) then
			local var_118_87, var_118_88 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2201
			})

			for iter_118_42 = 1, #var_118_88 do
				table.insert(var_118_0, var_118_88[iter_118_42])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[2289]._refCards[1]) then
			local var_118_89, var_118_90 = arg_118_0._owner:getBattleCardsBySkills("GB", {
				2289
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_43 = 1, #var_118_90 do
				table.insert(var_118_0, var_118_90[iter_118_43])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0._info._category == Data._skillInfo[2442]._refCards[1] then
			local var_118_91, var_118_92 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2442
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_44 = 1, #var_118_92 do
				table.insert(var_118_0, var_118_92[iter_118_44])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_93, var_118_94 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2502
			})

			for iter_118_45 = 1, #var_118_94 do
				table.insert(var_118_0, var_118_94[iter_118_45])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[2601]._refCards[1]) then
			local var_118_95, var_118_96 = arg_118_0._owner:getBattleCardsBySkills("H", {
				2601
			})

			for iter_118_46 = 1, #var_118_96 do
				table.insert(var_118_0, var_118_96[iter_118_46])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[2623]._refCards[1]) then
			local var_118_97, var_118_98 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2623
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_47 = 1, #var_118_98 do
				table.insert(var_118_0, var_118_98[iter_118_47])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[2650]._refCards[1]) and arg_118_0:isCeremonyMonster() then
			local var_118_99, var_118_100 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2650
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_48 = 1, #var_118_100 do
				table.insert(var_118_0, var_118_100[iter_118_48])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isNature(Data._skillInfo[4389]._refCards[1]) then
			local var_118_101, var_118_102 = arg_118_0._owner:getBattleCardsBySkills("G", {
				4389
			})

			for iter_118_49 = 1, #var_118_102 do
				table.insert(var_118_0, var_118_102[iter_118_49])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isCeremonyMonster() then
			local var_118_103, var_118_104 = arg_118_0._owner:getBattleCardsBySkills("G", {
				4647
			})

			for iter_118_50 = 1, #var_118_104 do
				table.insert(var_118_0, var_118_104[iter_118_50])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[7168]._refCards[1]) then
			local var_118_105, var_118_106 = arg_118_0._owner:getBattleCardsBySkills("D", {
				7168
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_51 = 1, #var_118_106 do
				table.insert(var_118_0, var_118_106[iter_118_51])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and (arg_118_0._info._category == Data._skillInfo[7215]._refCards[1] or arg_118_0._info._category == Data._skillInfo[7215]._refCards[2] or arg_118_0._info._category == Data._skillInfo[7215]._refCards[3]) then
			local var_118_107, var_118_108 = arg_118_0._owner:getBattleCardsBySkills("S", {
				7215
			})

			for iter_118_52 = 1, #var_118_108 do
				table.insert(var_118_0, var_118_108[iter_118_52])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and (arg_118_0:isKeyword(Data._skillInfo[7277]._refCards[1]) or arg_118_0:isKeyword(Data._skillInfo[7277]._refCards[2])) then
			local var_118_109, var_118_110 = arg_118_0._owner:getBattleCardsBySkills("S", {
				7277
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_53 = 1, #var_118_110 do
				table.insert(var_118_0, var_118_110[iter_118_53])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0._info._star >= Data._skillInfo[7327]._val[1] then
			local var_118_111, var_118_112 = arg_118_0._owner:getBattleCardsBySkills("D", {
				7327
			})

			for iter_118_54 = 1, #var_118_112 do
				table.insert(var_118_0, var_118_112[iter_118_54])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0:isKeyword(Data._skillInfo[7392]._refCards[1]) then
			local var_118_113, var_118_114 = arg_118_0._owner:getBattleCardsBySkills("D", {
				7392
			})

			for iter_118_55 = 1, #var_118_114 do
				table.insert(var_118_0, var_118_114[iter_118_55])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[7426]._refCards[1]) then
			local var_118_115, var_118_116 = arg_118_0._owner:getBattleCardsBySkills("D", {
				7426
			})

			for iter_118_56 = 1, #var_118_116 do
				table.insert(var_118_0, var_118_116[iter_118_56])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldAttack) then
			local var_118_117, var_118_118 = arg_118_0._owner:getBattleCardsBySkills("G", {
				3895
			})

			for iter_118_57 = 1, #var_118_118 do
				table.insert(var_118_0, var_118_118[iter_118_57])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[9107]._refCards[1]) then
			local var_118_119, var_118_120 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9107
			})

			for iter_118_58 = 1, #var_118_120 do
				table.insert(var_118_0, var_118_120[iter_118_58])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_121, var_118_122 = arg_118_0._owner:getBattleCardsBySkills("B", {
				13822
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_59 = 1, #var_118_122 do
				table.insert(var_118_0, var_118_122[iter_118_59])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage or arg_118_1 == Data.SkillMode.before_attack or arg_118_1 == Data.SkillMode.after_attack then
			for iter_118_60 = 1, #arg_118_0._binds do
				local var_118_123 = arg_118_0._binds[iter_118_60]

				for iter_118_61 = 1, #var_118_123._skills do
					local var_118_124 = var_118_123._skills[iter_118_61]

					if B.skillHasMode(var_118_124, arg_118_1) then
						table.insert(var_118_0, var_118_124)
					end
				end
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() then
			local var_118_125, var_118_126 = arg_118_0._atkTargets[1]:hasSkills(var_0_1)

			if var_118_125 then
				for iter_118_62 = 1, #var_118_126 do
					table.insert(var_118_0, var_118_126[iter_118_62])
				end
			end

			if arg_118_0._atkTargets[1]:isKeyword(Data._skillInfo[8045]._refCards[1]) and arg_118_0._atkTargets[1]:getStar() <= Data._skillInfo[8045]._val[1] then
				local var_118_127, var_118_128 = arg_118_0._owner._opponent:getBattleCardsBySkills("S", {
					8045
				})

				for iter_118_63 = 1, #var_118_128 do
					table.insert(var_118_0, var_118_128[iter_118_63])
				end
			end

			if arg_118_0._atkTargets[1]:isKeyword(Data._skillInfo[6479]._refCards[1]) then
				local var_118_129, var_118_130 = arg_118_0._owner._opponent:getBattleCardsBySkills("B", {
					6479
				})

				for iter_118_64 = 1, #var_118_130 do
					table.insert(var_118_0, var_118_130[iter_118_64])
				end
			end

			if arg_118_0:isKeyword(Data._skillInfo[6495]._refCards[1]) then
				local var_118_131, var_118_132 = arg_118_0._owner:getBattleCardsBySkills("B", {
					6495
				}, Data.CARD_MAX_LEVEL, arg_118_0)

				for iter_118_65 = 1, #var_118_132 do
					table.insert(var_118_0, var_118_132[iter_118_65])
				end
			end

			if arg_118_0._atkTargets[1]:isCeremonyMonster() then
				local var_118_133, var_118_134 = arg_118_0._owner._opponent:getBattleCardsBySkills("B", {
					6538
				})

				for iter_118_66 = 1, #var_118_134 do
					table.insert(var_118_0, var_118_134[iter_118_66])
				end
			end

			if arg_118_0._atkTargets[1]:isKeyword(Data._skillInfo[6740]._refCards[1]) then
				local var_118_135, var_118_136 = arg_118_0._owner._opponent:getBattleCardsBySkills("B", {
					6740
				})

				for iter_118_67 = 1, #var_118_136 do
					table.insert(var_118_0, var_118_136[iter_118_67])
				end
			end

			if arg_118_0._atkTargets[1]:hasBuff(true, BattleData.PositiveType.defendPosture) then
				local var_118_137, var_118_138 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("B", {
					6925
				})

				for iter_118_68 = 1, #var_118_138 do
					table.insert(var_118_0, var_118_138[iter_118_68])
				end
			end

			local var_118_139, var_118_140 = arg_118_0._owner._opponent:getBattleCardsBySkills("B", {
				2686
			})

			for iter_118_69 = 1, #var_118_140 do
				table.insert(var_118_0, var_118_140[iter_118_69])
			end

			if arg_118_0._atkTargets[1]:isKeyword(Data._skillInfo[5381]._refCards[1]) then
				local var_118_141, var_118_142 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("H", {
					5381
				})

				for iter_118_70 = 1, #var_118_142 do
					table.insert(var_118_0, var_118_142[iter_118_70])
				end
			end

			if arg_118_0._atkTargets[1]:isAlive() and arg_118_0._atkTargets[1]:isKeyword(Data._skillInfo[5520]._refCards[1]) and not arg_118_0._atkTargets[1]:hasBuff(true, BattleData.PositiveType.defendPosture) then
				local var_118_143, var_118_144 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("H", {
					5520
				})

				for iter_118_71 = 1, #var_118_144 do
					table.insert(var_118_0, var_118_144[iter_118_71])
				end
			end
		elseif arg_118_1 == Data.SkillMode.after_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() then
			local var_118_145, var_118_146 = arg_118_0._atkTargets[1]:hasSkills(var_0_2)

			if var_118_145 then
				table.insert(var_118_0, var_118_146[1])
			end
		elseif arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._type == Data.CardType.fortress then
			local var_118_147, var_118_148 = arg_118_0._owner._opponent:getBattleCardsBySkills("H", {
				6570
			})

			for iter_118_72 = 1, #var_118_148 do
				table.insert(var_118_0, var_118_148[iter_118_72])
			end

			local var_118_149, var_118_150 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				5454
			})

			for iter_118_73 = 1, #var_118_150 do
				table.insert(var_118_0, var_118_150[iter_118_73])
			end

			if arg_118_0:isKeyword(Data._skillInfo[6495]._refCards[1]) then
				local var_118_151, var_118_152 = arg_118_0._owner:getBattleCardsBySkills("B", {
					6495
				}, Data.CARD_MAX_LEVEL, arg_118_0)

				for iter_118_74 = 1, #var_118_152 do
					table.insert(var_118_0, var_118_152[iter_118_74])
				end
			end

			if #B.filterInKeywordCards(arg_118_0._atkTargets[1]._owner:getBattleCardsByType("G", Data.CardType.monster), Data._skillInfo[5524]._refCards[1]) > 0 then
				local var_118_153, var_118_154 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("G", {
					5524
				})

				for iter_118_75 = 1, #var_118_154 do
					table.insert(var_118_0, var_118_154[iter_118_75])
				end
			end
		elseif arg_118_1 == Data.SkillMode.after_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._type == Data.CardType.fortress then
			local var_118_155, var_118_156 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				6490
			})

			for iter_118_76 = 1, #var_118_156 do
				table.insert(var_118_0, var_118_156[iter_118_76])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldMonster) then
			local var_118_157, var_118_158 = arg_118_0._owner._opponent:getBattleCardsBySkills("B", {
				6418
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_77 = 1, #var_118_158 do
				table.insert(var_118_0, var_118_158[iter_118_77])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_159, var_118_160 = arg_118_0._owner._opponent:getBattleCardsBySkills("GH", {
				2136
			})

			for iter_118_78 = 1, #var_118_160 do
				table.insert(var_118_0, var_118_160[iter_118_78])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_161, var_118_162 = arg_118_0._owner._opponent:getBattleCardsBySkills("HB", {
				2227
			})

			for iter_118_79 = 1, #var_118_162 do
				table.insert(var_118_0, var_118_162[iter_118_79])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_163, var_118_164 = arg_118_0._owner._opponent:getBattleCardsBySkills("H", {
				2350
			})

			for iter_118_80 = 1, #var_118_164 do
				table.insert(var_118_0, var_118_164[iter_118_80])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_165, var_118_166 = arg_118_0._owner._opponent:getBattleCardsBySkills("H", {
				2432
			})

			for iter_118_81 = 1, #var_118_166 do
				table.insert(var_118_0, var_118_166[iter_118_81])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_167, var_118_168 = arg_118_0._owner._opponent:getBattleCardsBySkills("B", {
				2740
			})

			for iter_118_82 = 1, #var_118_168 do
				table.insert(var_118_0, var_118_168[iter_118_82])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_169, var_118_170 = arg_118_0._owner._opponent:getBattleCardsBySkills("H", {
				2898
			})

			for iter_118_83 = 1, #var_118_170 do
				table.insert(var_118_0, var_118_170[iter_118_83])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0:isBindedSkill(7027) then
			local var_118_171 = Data._skillInfo[7027]
			local var_118_172 = {
				_maxLevel = 1,
				_totalCastedTimes = 0,
				_id = var_118_171._id,
				_level = arg_118_0._level,
				_modes = var_118_171._modes,
				_priority = var_118_171._priority,
				_count = var_118_171._count,
				_owner = arg_118_0
			}

			table.insert(var_118_0, var_118_172)
		end

		if arg_118_1 == Data.SkillMode.before_attack and not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldTrap) then
			local var_118_173, var_118_174 = arg_118_0._owner._opponent:getBattleCardsBySkills("S", {
				8063
			})

			for iter_118_84 = 1, #var_118_174 do
				table.insert(var_118_0, var_118_174[iter_118_84])
			end
		end

		if arg_118_1 == Data.SkillMode.after_attack and arg_118_0:isKeyword(Data._skillInfo[3664]._refCards[1]) and not arg_118_0:hasSkillFast(3664) then
			local var_118_175, var_118_176 = arg_118_0._owner:getBattleCardsBySkills("B", {
				3664
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_85 = 1, #var_118_176 do
				table.insert(var_118_0, var_118_176[iter_118_85])
			end
		end

		if arg_118_1 == Data.SkillMode.after_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._owner ~= arg_118_0._owner and arg_118_0._atkTargets[1]._type == Data.CardType.fortress then
			local var_118_177, var_118_178 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("H", {
				3889
			})

			for iter_118_86 = 1, #var_118_178 do
				table.insert(var_118_0, var_118_178[iter_118_86])
			end
		end

		if arg_118_1 == Data.SkillMode.after_attack and arg_118_0._owner._fortress._hp > arg_118_0._owner._opponent._fortress._hp then
			local var_118_179, var_118_180 = arg_118_0._owner._opponent:getBattleCardsBySkills("S", {
				4561
			})

			for iter_118_87 = 1, #var_118_180 do
				table.insert(var_118_0, var_118_180[iter_118_87])
			end
		end

		if arg_118_1 == Data.SkillMode.using and arg_118_0._mark4735 then
			table.insert(var_118_0, arg_118_0._mark4735:getSkillById(4735))
		end

		if arg_118_1 == Data.SkillMode.under_attack and arg_118_0:isKeyword(Data._skillInfo[4831]._refCards[1]) and arg_118_0:hasChangeStatusUnderSkill({
			BattleData.CardStatus.grave,
			BattleData.CardStatus.leave
		}) then
			local var_118_181, var_118_182 = arg_118_0._owner:getBattleCardsBySkills("D", {
				4831
			})

			for iter_118_88 = 1, #var_118_182 do
				table.insert(var_118_0, var_118_182[iter_118_88])
			end
		end

		if arg_118_1 == Data.SkillMode.using and arg_118_0._mark5391 then
			table.insert(var_118_0, arg_118_0._mark5391:getSkillById(5391))
		end

		if arg_118_1 == Data.SkillMode.after_attack then
			if arg_118_0:isKeyword(Data._skillInfo[8080]._refCards[1]) then
				local var_118_183, var_118_184 = arg_118_0._owner:getBattleCardsBySkills("S", {
					8080
				})

				for iter_118_89 = 1, #var_118_184 do
					table.insert(var_118_0, var_118_184[iter_118_89])
				end
			end

			if arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._owner ~= arg_118_0._owner and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._atkTargets[1]:isKeyword(Data._skillInfo[8080]._refCards[1]) then
				local var_118_185, var_118_186 = arg_118_0._owner._opponent:getBattleCardsBySkills("S", {
					8080
				})

				for iter_118_90 = 1, #var_118_186 do
					table.insert(var_118_0, var_118_186[iter_118_90])
				end
			end
		end

		if arg_118_1 == Data.SkillMode.round_end and arg_118_0._mark4202 then
			local var_118_187 = Data._skillInfo[3512]
			local var_118_188 = {
				_maxLevel = 1,
				_totalCastedTimes = 0,
				_id = var_118_187._id,
				_level = arg_118_0._level,
				_modes = var_118_187._modes,
				_priority = var_118_187._priority,
				_count = var_118_187._count,
				_owner = arg_118_0
			}

			table.insert(var_118_0, var_118_188)
		end

		if arg_118_1 == Data.SkillMode.using then
			if arg_118_0._mark2022 then
				table.insert(var_118_0, arg_118_0._mark2022:getSkillById(2022))
			end

			if arg_118_0._mark4449 then
				table.insert(var_118_0, arg_118_0._mark4449._skills[3])
			end

			if arg_118_0._mark4450 then
				table.insert(var_118_0, arg_118_0._mark4450._skills[1])
			end
		end

		if arg_118_1 == Data.SkillMode.g2b and arg_118_0._statusVal == BattleData.CardStatusVal.g2b_3936 then
			table.insert(var_118_0, arg_118_0._triggerCard._skills[1])
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[9058]._refCards[1]) then
			local var_118_189, var_118_190 = arg_118_0._owner:getBattleCardsBySkills("G", {
				9058
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_91 = 1, #var_118_190 do
				table.insert(var_118_0, var_118_190[iter_118_91])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_191 = Data._skillInfo[9109]

			if arg_118_0:isKeyword(var_118_191._refCards[1]) and arg_118_0._atk < arg_118_0._atkTargets[1]._atk then
				local var_118_192 = B.filterHasBuffCards(arg_118_0._owner:getBattleCardsBySkillFast("B", 9109), true, BattleData.PositiveType.xyzMark)[1]

				if var_118_192 ~= nil then
					table.insert(var_118_0, var_118_192:getSkillById(9109))
				end
			elseif arg_118_0._atkTargets[1]:isKeyword(var_118_191._refCards[1]) and arg_118_0._atk > arg_118_0._atkTargets[1]._atk then
				local var_118_193 = B.filterHasBuffCards(arg_118_0._atkTargets[1]._owner:getBattleCardsBySkillFast("B", 9109), true, BattleData.PositiveType.xyzMark)[1]

				if var_118_193 ~= nil then
					table.insert(var_118_0, var_118_193:getSkillById(9109))
				end
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_194, var_118_195 = arg_118_0._owner._opponent:getBattleCardsBySkills("B", {
				9169
			})

			for iter_118_92 = 1, #var_118_195 do
				table.insert(var_118_0, var_118_195[iter_118_92])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and #arg_118_0._owner._opponent:getBattleCards("BCSD") == 0 then
			local var_118_196, var_118_197 = arg_118_0._owner._opponent:getBattleCardsBySkills("H", {
				9185
			})

			for iter_118_93 = 1, #var_118_197 do
				table.insert(var_118_0, var_118_197[iter_118_93])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isDual() then
			local var_118_198, var_118_199 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9263
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_94 = 1, #var_118_199 do
				table.insert(var_118_0, var_118_199[iter_118_94])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_200, var_118_201 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9279
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_95 = 1, #var_118_201 do
				table.insert(var_118_0, var_118_201[iter_118_95])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner and arg_118_0._atk > arg_118_0._atkTargets[1]._atk and arg_118_0._atkTargets[1]:isKeyword(Data._skillInfo[9346]._refCards[1]) and not arg_118_0._atkTargets[1]:hasBuff(true, BattleData.PositiveType.defendPosture) then
			local var_118_202, var_118_203 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("H", {
				9346
			})

			for iter_118_96 = 1, #var_118_203 do
				table.insert(var_118_0, var_118_203[iter_118_96])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner and arg_118_0._atkTargets[1]:isKeyword(Data._skillInfo[9385]._refCards[1]) and not arg_118_0._atkTargets[1]:hasBuff(true, BattleData.PositiveType.defendPosture) then
			local var_118_204, var_118_205 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("HB", {
				9385
			}, Data.CARD_MAX_LEVEL, arg_118_0._atkTargets[1])

			for iter_118_97 = 1, #var_118_205 do
				table.insert(var_118_0, var_118_205[iter_118_97])
			end
		end

		if arg_118_1 == Data.SkillMode.g2b or arg_118_1 == Data.SkillMode.using then
			local var_118_206 = arg_118_0._owner._mark9407

			if var_118_206 ~= nil then
				local var_118_207 = var_118_206:getSkillById(9407)

				if var_118_207 ~= nil then
					table.insert(var_118_0, var_118_207)
				end
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[9618]._refCards[1]) then
			local var_118_208, var_118_209 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9618
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_98 = 1, #var_118_209 do
				table.insert(var_118_0, var_118_209[iter_118_98])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[9626]._refCards[1]) then
			local var_118_210, var_118_211 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9626
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_99 = 1, #var_118_211 do
				table.insert(var_118_0, var_118_211[iter_118_99])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_212, var_118_213 = arg_118_0._owner._opponent:getBattleCardsBySkills("S", {
				7447
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_100 = 1, #var_118_213 do
				table.insert(var_118_0, var_118_213[iter_118_100])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0._info._category == Data._skillInfo[5500]._refCards[1] and arg_118_0:isXYZ() then
			local var_118_214, var_118_215 = arg_118_0._owner:getBattleCardsBySkills("S", {
				5500
			})

			for iter_118_101 = 1, #var_118_215 do
				table.insert(var_118_0, var_118_215[iter_118_101])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0:isLink() and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_216, var_118_217 = arg_118_0._owner:getBattleCardsBySkills("S", {
				8115
			})

			for iter_118_102 = 1, #var_118_217 do
				table.insert(var_118_0, var_118_217[iter_118_102])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner and arg_118_0._atkTargets[1]:isLink() then
			local var_118_218, var_118_219 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("S", {
				8115
			})

			for iter_118_103 = 1, #var_118_219 do
				table.insert(var_118_0, var_118_219[iter_118_103])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0:isNature(Data._skillInfo[7448]._refCards[1]) and arg_118_0._info._category == Data._skillInfo[7448]._refCards[2] then
			local var_118_220, var_118_221 = arg_118_0._owner:getBattleCardsBySkills("D", {
				7448
			})

			for iter_118_104 = 1, #var_118_221 do
				table.insert(var_118_0, var_118_221[iter_118_104])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner and arg_118_0._atkTargets[1]:hasBuff(true, BattleData.PositiveType.defendPosture) then
			local var_118_222, var_118_223 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("HG", {
				9689
			})

			for iter_118_105 = 1, #var_118_223 do
				table.insert(var_118_0, var_118_223[iter_118_105])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._type == Data.CardType.fortress and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_224, var_118_225 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("GL", {
				9691
			})

			for iter_118_106 = 1, #var_118_225 do
				table.insert(var_118_0, var_118_225[iter_118_106])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._mark9690 then
			table.insert(var_118_0, arg_118_0._mark9690[1]:getSkillById(9690))
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._atkTargets[1]._mark9690 then
			table.insert(var_118_0, arg_118_0._atkTargets[1]._mark9690[1]:getSkillById(9690))
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[9693]._refCards[1]) then
			local var_118_226, var_118_227 = arg_118_0._owner:getBattleCardsBySkills("G", {
				9693
			})

			for iter_118_107 = 1, #var_118_227 do
				table.insert(var_118_0, var_118_227[iter_118_107])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._type == Data.CardType.fortress and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_228, var_118_229 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("G", {
				9695
			})

			for iter_118_108 = 1, #var_118_229 do
				table.insert(var_118_0, var_118_229[iter_118_108])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_230, var_118_231 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("H", {
				9751
			})

			for iter_118_109 = 1, #var_118_231 do
				table.insert(var_118_0, var_118_231[iter_118_109])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isInfoId(Data._skillInfo[9810]._refCards[1]) then
			local var_118_232, var_118_233 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9810
			})

			for iter_118_110 = 1, #var_118_233 do
				table.insert(var_118_0, var_118_233[iter_118_110])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and not arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_234, var_118_235 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("G", {
				9929
			})

			for iter_118_111 = 1, #var_118_235 do
				table.insert(var_118_0, var_118_235[iter_118_111])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and not arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_236, var_118_237 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("H", {
				9936
			})

			for iter_118_112 = 1, #var_118_237 do
				table.insert(var_118_0, var_118_237[iter_118_112])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_238, var_118_239 = arg_118_0._owner._opponent:getBattleCardsBySkills("B", {
				9980
			})

			for iter_118_113 = 1, #var_118_239 do
				table.insert(var_118_0, var_118_239[iter_118_113])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0._owner._linkPos[arg_118_0._pos] then
			local var_118_240, var_118_241 = arg_118_0._owner:getBattleCardsBySkills("G", {
				13024
			})

			for iter_118_114 = 1, #var_118_241 do
				table.insert(var_118_0, var_118_241[iter_118_114])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0:isKeywordGroup(Data._skillInfo[13083]._refCards) then
			local var_118_242, var_118_243 = arg_118_0._owner:getBattleCardsBySkills("H", {
				13083
			})

			for iter_118_115 = 1, #var_118_243 do
				table.insert(var_118_0, var_118_243[iter_118_115])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[5542]._refCards[1]) then
			local var_118_244, var_118_245 = arg_118_0._owner:getBattleCardsBySkills("G", {
				5542
			})

			for iter_118_116 = 1, #var_118_245 do
				table.insert(var_118_0, var_118_245[iter_118_116])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and not arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_246, var_118_247 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("H", {
				13151
			})

			for iter_118_117 = 1, #var_118_247 do
				table.insert(var_118_0, var_118_247[iter_118_117])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_248, var_118_249 = arg_118_0._owner:getBattleCardsBySkills("H", {
				13174
			})

			for iter_118_118 = 1, #var_118_249 do
				table.insert(var_118_0, var_118_249[iter_118_118])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0._info._category == Data._skillInfo[13202]._refCards[1] then
			local var_118_250, var_118_251 = arg_118_0._owner:getBattleCardsBySkills("B", {
				13202
			})

			for iter_118_119 = 1, #var_118_251 do
				table.insert(var_118_0, var_118_251[iter_118_119])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isInfoId(Data._skillInfo[13225]._refCards[1]) and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_252, var_118_253 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("H", {
				13225
			})

			for iter_118_120 = 1, #var_118_253 do
				table.insert(var_118_0, var_118_253[iter_118_120])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:getStar() <= Data._skillInfo[13233]._val[1] and arg_118_0._info._category == Data._skillInfo[13233]._refCards[1] then
			local var_118_254, var_118_255 = arg_118_0._owner:getBattleCardsBySkills("H", {
				13233
			})

			for iter_118_121 = 1, #var_118_255 do
				table.insert(var_118_0, var_118_255[iter_118_121])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and (#arg_118_0._owner._opponent:getBoardCards() == 0 or #arg_118_0._owner._opponent:getBattleCardsByInfoId("B", Data._skillInfo[6651]._refCards[2]) > 0) then
			local var_118_256, var_118_257 = arg_118_0._owner._opponent:getBattleCardsBySkills("H", {
				6651
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_122 = 1, #var_118_257 do
				table.insert(var_118_0, var_118_257[iter_118_122])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and (arg_118_0:isKeyword(Data._skillInfo[8137]._refCards[1]) or arg_118_0:getStar() == Data._skillInfo[8137]._val[1] and arg_118_0:isNature(Data._skillInfo[8137]._refCards[2]) and arg_118_0._info._category == Data._skillInfo[8137]._refCards[3] and arg_118_0:isSync()) then
			local var_118_258, var_118_259 = arg_118_0._owner:getBattleCardsBySkills("S", {
				8137
			})

			for iter_118_123 = 1, #var_118_259 do
				table.insert(var_118_0, var_118_259[iter_118_123])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[7565]._refCards[1]) and arg_118_0._info._category == Data._skillInfo[7565]._refCards[2] then
			local var_118_260, var_118_261 = arg_118_0._owner:getBattleCardsBySkills("S", {
				7565
			})

			for iter_118_124 = 1, #var_118_261 do
				table.insert(var_118_0, var_118_261[iter_118_124])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._type == Data.CardType.fortress then
			local var_118_262, var_118_263 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				13337
			})

			for iter_118_125 = 1, #var_118_263 do
				table.insert(var_118_0, var_118_263[iter_118_125])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0:isKeyword(Data._skillInfo[13340]._refCards[1]) and arg_118_0._info._category == Data._skillInfo[13340]._refCards[2] then
			local var_118_264, var_118_265 = arg_118_0._owner:getBattleCardsBySkills("H", {
				13340
			})

			for iter_118_126 = 1, #var_118_265 do
				table.insert(var_118_0, var_118_265[iter_118_126])
			end
		end

		if (arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage) and arg_118_0._type == Data.CardType.rare then
			local var_118_266, var_118_267 = arg_118_0._owner:getBattleCardsBySkills("G", {
				13413
			})

			for iter_118_127 = 1, #var_118_267 do
				table.insert(var_118_0, var_118_267[iter_118_127])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._type == Data.CardType.fortress then
			local var_118_268, var_118_269 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				13436
			})

			for iter_118_128 = 1, #var_118_269 do
				table.insert(var_118_0, var_118_269[iter_118_128])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._type == Data.CardType.fortress and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_270, var_118_271 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("H", {
				5596
			})

			for iter_118_129 = 1, #var_118_271 do
				table.insert(var_118_0, var_118_271[iter_118_129])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._type == Data.CardType.fortress and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_272, var_118_273 = arg_118_0._atkTargets[1]._owner:getBattleCardsBySkills("G", {
				13519
			})

			for iter_118_130 = 1, #var_118_273 do
				table.insert(var_118_0, var_118_273[iter_118_130])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_274, var_118_275 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				13583
			})

			for iter_118_131 = 1, #var_118_275 do
				table.insert(var_118_0, var_118_275[iter_118_131])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner then
			local var_118_276, var_118_277 = arg_118_0._owner:getBattleCardsBySkills("S", {
				8148
			})

			for iter_118_132 = 1, #var_118_277 do
				table.insert(var_118_0, var_118_277[iter_118_132])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]:isMonsterRare() and arg_118_0._owner ~= arg_118_0._atkTargets[1]._owner and arg_118_0._atkTargets[1]:isNature(Data._skillInfo[13649]._refCards[1]) and arg_118_0._atkTargets[1]._info._category == Data._skillInfo[13649]._refCards[2] then
			local var_118_278, var_118_279 = arg_118_0._owner._opponent:getBattleCardsBySkills("H", {
				13649
			})

			for iter_118_133 = 1, #var_118_279 do
				table.insert(var_118_0, var_118_279[iter_118_133])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_280, var_118_281 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				13738
			})

			for iter_118_134 = 1, #var_118_281 do
				table.insert(var_118_0, var_118_281[iter_118_134])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._type == Data.CardType.fortress then
			local var_118_282, var_118_283 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				13848
			})

			for iter_118_135 = 1, #var_118_283 do
				table.insert(var_118_0, var_118_283[iter_118_135])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_284, var_118_285 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				5633
			})

			for iter_118_136 = 1, #var_118_285 do
				table.insert(var_118_0, var_118_285[iter_118_136])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_286, var_118_287 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				7712
			})

			for iter_118_137 = 1, #var_118_287 do
				table.insert(var_118_0, var_118_287[iter_118_137])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_288, var_118_289 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				7764
			})

			for iter_118_138 = 1, #var_118_289 do
				table.insert(var_118_0, var_118_289[iter_118_138])
			end
		end

		if (arg_118_1 == Data.SkillMode.using or arg_118_1 == Data.SkillMode.g2b) and arg_118_0._owner._mark13878 and arg_118_0:isAdjust() then
			table.insert(var_118_0, arg_118_0._owner._mark13878:getSkillById(13878))
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_290, var_118_291 = arg_118_0._owner._opponent:getBattleCardsBySkills("H", {
				13942
			})

			for iter_118_139 = 1, #var_118_291 do
				table.insert(var_118_0, var_118_291[iter_118_139])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_292, var_118_293 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				13971
			})

			for iter_118_140 = 1, #var_118_293 do
				table.insert(var_118_0, var_118_293[iter_118_140])
			end
		end

		if arg_118_1 == Data.SkillMode.after_attack then
			local var_118_294, var_118_295 = arg_118_0._owner:getBattleCardsBySkills("H", {
				14035
			})

			for iter_118_141 = 1, #var_118_295 do
				table.insert(var_118_0, var_118_295[iter_118_141])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack and arg_118_0._atkTargets[1] ~= nil and arg_118_0._atkTargets[1]._type == Data.CardType.fortress then
			local var_118_296, var_118_297 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				14043
			})

			for iter_118_142 = 1, #var_118_297 do
				table.insert(var_118_0, var_118_297[iter_118_142])
			end
		end

		if arg_118_1 == Data.SkillMode._2h and arg_118_0._sourceStatus == BattleData.CardStatus.pile and arg_118_0._fromPilePos == 1 then
			local var_118_298 = arg_118_0._owner._mark14055_1

			if var_118_298 ~= nil then
				local var_118_299 = var_118_298:getSkillById(14055)

				if var_118_299 ~= nil then
					table.insert(var_118_0, var_118_299)
				end
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_300, var_118_301 = arg_118_0._owner._opponent:getBattleCardsBySkills("H", {
				14067
			})

			for iter_118_143 = 1, #var_118_301 do
				table.insert(var_118_0, var_118_301[iter_118_143])
			end
		end

		if arg_118_1 == Data.SkillMode.using and arg_118_0:isLink() and arg_118_0:isKeyword(Data._skillInfo[14194]._refCards[1]) then
			local var_118_302, var_118_303 = arg_118_0._owner:getBattleCardsBySkills("P", {
				14194
			})

			for iter_118_144 = 1, #var_118_303 do
				table.insert(var_118_0, var_118_303[iter_118_144])
			end
		end

		if arg_118_1 == Data.SkillMode.using and arg_118_0._summonByNormal and arg_118_0:isNature(Data._skillInfo[14566]._refCards[1]) then
			local var_118_304, var_118_305 = arg_118_0._owner:getBattleCardsBySkills("P", {
				14566
			})

			for iter_118_145 = 1, #var_118_305 do
				table.insert(var_118_0, var_118_305[iter_118_145])
			end
		end

		if arg_118_1 == Data.SkillMode.using and arg_118_0._summonByNormal and arg_118_0:isNature(Data._skillInfo[14577]._refCards[1]) then
			local var_118_306, var_118_307 = arg_118_0._owner:getBattleCardsBySkills("P", {
				14577
			})

			for iter_118_146 = 1, #var_118_307 do
				table.insert(var_118_0, var_118_307[iter_118_146])
			end
		end

		if (arg_118_1 == Data.SkillMode.using or arg_118_1 == Data.SkillMode.g2b) and arg_118_0._type == Data.CardType.monster and arg_118_0:getStar() ~= Data.XYZ_STAR and not arg_118_0:isLink() and not arg_118_0:isStatusValNormalSummon() and arg_118_0._owner._mark14250_1 and arg_118_0._owner._mark14250_2 ~= arg_118_0 then
			table.insert(var_118_0, arg_118_0._owner._mark14250_1:getSkillById(14250))
		end

		if arg_118_1 == Data.SkillMode.using and arg_118_0._summonByNormal and arg_118_0:isNature(Data._skillInfo[14587]._refCards[1]) then
			local var_118_308, var_118_309 = arg_118_0._owner:getBattleCardsBySkills("P", {
				14587
			})

			for iter_118_147 = 1, #var_118_309 do
				table.insert(var_118_0, var_118_309[iter_118_147])
			end
		end

		if arg_118_1 == Data.SkillMode.using and arg_118_0._summonByNormal and arg_118_0:isNature(Data._skillInfo[14594]._refCards[1]) then
			local var_118_310, var_118_311 = arg_118_0._owner:getBattleCardsBySkills("P", {
				14594
			})

			for iter_118_148 = 1, #var_118_311 do
				table.insert(var_118_0, var_118_311[iter_118_148])
			end
		end

		if arg_118_1 == Data.SkillMode.using and arg_118_0._summonByNormal and arg_118_0._info._category == Data._skillInfo[14601]._refCards[1] then
			local var_118_312, var_118_313 = arg_118_0._owner:getBattleCardsBySkills("P", {
				14601
			})

			for iter_118_149 = 1, #var_118_313 do
				table.insert(var_118_0, var_118_313[iter_118_149])
			end
		end

		if arg_118_0._status == BattleData.CardStatus.leave and (arg_118_1 == Data.SkillMode.bcs2gl or arg_118_1 == Data.SkillMode.g2l_by_self or arg_118_1 == Data.SkillMode.g2l_by_oppo or arg_118_1 == Data.SkillMode.h2gl_by_self or arg_118_1 == Data.SkillMode.h2gl_by_oppo or arg_118_1 == Data.SkillMode.p2gl_by_self or arg_118_1 == Data.SkillMode.p2gl_by_oppo) then
			local var_118_314 = arg_118_0._owner._opponent:getBattleCardsByInfoId("G", 12233)

			for iter_118_150 = 1, #var_118_314 do
				table.insert(var_118_0, var_118_314[iter_118_150]:getSkillById(14208))
			end
		end

		if arg_118_1 == Data.SkillMode._2h and not arg_118_0:isStatusValDeal() and (arg_118_0:isNormalMonster() or arg_118_0:isDual()) then
			local var_118_315, var_118_316 = arg_118_0._owner._opponent:getBattleCardsBySkills("P", {
				14279
			})

			for iter_118_151 = 1, #var_118_316 do
				table.insert(var_118_0, var_118_316[iter_118_151])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_317, var_118_318 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				5655
			})

			for iter_118_152 = 1, #var_118_318 do
				table.insert(var_118_0, var_118_318[iter_118_152])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_319, var_118_320 = arg_118_0._owner._opponent:getBattleCardsBySkills("H", {
				14304
			})

			for iter_118_153 = 1, #var_118_320 do
				table.insert(var_118_0, var_118_320[iter_118_153])
			end
		end

		if arg_118_1 == Data.SkillMode.before_attack then
			local var_118_321, var_118_322 = arg_118_0._owner._opponent:getBattleCardsBySkills("G", {
				14305
			})

			for iter_118_154 = 1, #var_118_322 do
				table.insert(var_118_0, var_118_322[iter_118_154])
			end
		end

		if (arg_118_1 == Data.SkillMode.using or arg_118_1 == Data.SkillMode.g2b) and arg_118_0._owner._mark14306 then
			table.insert(var_118_0, arg_118_0._owner._mark14306:getSkillById(14306))
		end
	elseif arg_118_0._type == Data.CardType.boss then
		for iter_118_155 = 1, #arg_118_0._skills do
			local var_118_323 = arg_118_0._skills[iter_118_155]
			local var_118_324 = var_118_323._stepRound or 0
			local var_118_325 = var_118_323._startRound or 0
			local var_118_326 = math.max(arg_118_0._owner._round, arg_118_0._owner._opponent._round)

			if B.skillHasMode(var_118_323, arg_118_1) and var_118_325 <= var_118_326 and (var_118_326 - var_118_325) % (var_118_324 + 1) == 0 then
				table.insert(var_118_0, var_118_323)
			end
		end
	elseif arg_118_0._type == Data.CardType.magic then
		for iter_118_156 = 1, #arg_118_0._skills do
			local var_118_327 = arg_118_0._skills[iter_118_156]

			if B.skillHasMode(var_118_327, arg_118_1) then
				table.insert(var_118_0, var_118_327)
			end
		end

		if (arg_118_1 == Data.SkillMode.round_begin or arg_118_1 == Data.SkillMode.round_end) and arg_118_0._owner._fortressSkill ~= nil and B.skillHasMode(arg_118_0._owner._fortressSkill, arg_118_1) then
			table.insert(var_118_0, arg_118_0._owner._fortressSkill)
		end

		for iter_118_157 = BattleData.PositiveType.shieldDestroy, BattleData.PositiveType.shieldHaloEffectDestroy do
			if arg_118_0:hasBuff(true, iter_118_157) then
				local var_118_328 = Data._skillInfo[(iter_118_157 == BattleData.PositiveType.shieldEffectDestroy or iter_118_157 == BattleData.PositiveType.shieldHaloEffectDestroy) and 12007 or 12006]
				local var_118_329 = {
					_maxLevel = 1,
					_totalCastedTimes = 0,
					_id = var_118_328._id,
					_level = arg_118_0._level,
					_modes = var_118_328._modes,
					_priority = var_118_328._priority,
					_count = var_118_328._count,
					_owner = arg_118_0
				}

				if B.skillHasMode(var_118_329, arg_118_1) then
					table.insert(var_118_0, var_118_329)
				end
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and (arg_118_0._status == BattleData.CardStatus.show or arg_118_0._status == BattleData.CardStatus.field) then
			local var_118_330, var_118_331 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6190
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_158 = 1, #var_118_331 do
				table.insert(var_118_0, var_118_331[iter_118_158])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_332, var_118_333 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6542
			})

			for iter_118_159 = 1, #var_118_333 do
				table.insert(var_118_0, var_118_333[iter_118_159])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and (arg_118_0._status == BattleData.CardStatus.show or arg_118_0._status == BattleData.CardStatus.field) then
			local var_118_334, var_118_335 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6603
			})

			for iter_118_160 = 1, #var_118_335 do
				table.insert(var_118_0, var_118_335[iter_118_160])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and (arg_118_0._status == BattleData.CardStatus.show or arg_118_0._status == BattleData.CardStatus.field) then
			local var_118_336, var_118_337 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2502
			})

			for iter_118_161 = 1, #var_118_337 do
				table.insert(var_118_0, var_118_337[iter_118_161])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[2623]._refCards[1]) then
			local var_118_338, var_118_339 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2623
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_162 = 1, #var_118_339 do
				table.insert(var_118_0, var_118_339[iter_118_162])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_340, var_118_341 = arg_118_0._owner:getBattleCardsBySkills("H", {
				2882
			})

			for iter_118_163 = 1, #var_118_341 do
				table.insert(var_118_0, var_118_341[iter_118_163])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isEquipMagic() and arg_118_0:isKeyword(Data._skillInfo[2950]._refCards[1]) then
			local var_118_342, var_118_343 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2950
			})

			for iter_118_164 = 1, #var_118_343 do
				table.insert(var_118_0, var_118_343[iter_118_164])
			end
		end

		if arg_118_0:isKeyword(Data._skillInfo[6645]._refCards[1]) and (var_118_1 == nil or not var_118_1:isMonsterRare() or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldMonster)) and (var_118_1 == nil or var_118_1._type ~= Data.CardType.magic or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldMagic)) and (var_118_1 == nil or var_118_1._type ~= Data.CardType.trap or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldTrap)) then
			local var_118_344, var_118_345 = arg_118_0._owner:getBattleCardsBySkills("H", {
				6645
			})

			for iter_118_165 = 1, #var_118_345 do
				table.insert(var_118_0, var_118_345[iter_118_165])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._owner._mark8088 then
			table.insert(var_118_0, arg_118_0._owner._mark8088:getSkillById(8088))
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[8092]._refCards[1]) then
			local var_118_346, var_118_347 = arg_118_0._owner:getBattleCardsBySkills("S", {
				8092
			})

			for iter_118_166 = 1, #var_118_347 do
				table.insert(var_118_0, var_118_347[iter_118_166])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[9195]._refCards[1]) then
			local var_118_348, var_118_349 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9195
			})

			for iter_118_167 = 1, #var_118_349 do
				table.insert(var_118_0, var_118_349[iter_118_167])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_350, var_118_351 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9279
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_168 = 1, #var_118_351 do
				table.insert(var_118_0, var_118_351[iter_118_168])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[9574]._refCards[1]) then
			local var_118_352, var_118_353 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9574
			})

			for iter_118_169 = 1, #var_118_353 do
				table.insert(var_118_0, var_118_353[iter_118_169])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isFieldMagic() then
			local var_118_354, var_118_355 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9596
			})

			for iter_118_170 = 1, #var_118_355 do
				table.insert(var_118_0, var_118_355[iter_118_170])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_356, var_118_357 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9842
			})

			for iter_118_171 = 1, #var_118_357 do
				table.insert(var_118_0, var_118_357[iter_118_171])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_358, var_118_359 = arg_118_0._owner:getBattleCardsBySkills("S", {
				7488
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_172 = 1, #var_118_359 do
				table.insert(var_118_0, var_118_359[iter_118_172])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeywordGroup(Data._skillInfo[9976]._refCards) then
			local var_118_360, var_118_361 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9976
			})

			for iter_118_173 = 1, #var_118_361 do
				table.insert(var_118_0, var_118_361[iter_118_173])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isInfoId(Data._skillInfo[4988]._refCards[1]) then
			local var_118_362, var_118_363 = arg_118_0._owner:getBattleCardsBySkills("G", {
				4988
			})

			for iter_118_174 = 1, #var_118_363 do
				table.insert(var_118_0, var_118_363[iter_118_174])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[13325]._refCards[1]) then
			local var_118_364, var_118_365 = arg_118_0._owner:getBattleCardsBySkills("B", {
				13325
			})

			for iter_118_175 = 1, #var_118_365 do
				table.insert(var_118_0, var_118_365[iter_118_175])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._owner._mark4615 then
			local var_118_366 = Data._skillInfo[12007]
			local var_118_367 = {
				_maxLevel = 1,
				_totalCastedTimes = 0,
				_id = var_118_366._id,
				_level = arg_118_0._level,
				_modes = var_118_366._modes,
				_priority = var_118_366._priority,
				_count = var_118_366._count,
				_owner = arg_118_0
			}

			table.insert(var_118_0, var_118_367)
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[7639]._refCards[1]) then
			local var_118_368, var_118_369 = arg_118_0._owner:getBattleCardsBySkills("D", {
				7639
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_176 = 1, #var_118_369 do
				table.insert(var_118_0, var_118_369[iter_118_176])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[7680]._refCards[1]) then
			local var_118_370, var_118_371 = arg_118_0._owner:getBattleCardsBySkills("S", {
				7680
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_177 = 1, #var_118_371 do
				table.insert(var_118_0, var_118_371[iter_118_177])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_372, var_118_373 = arg_118_0._owner:getBattleCardsBySkills("B", {
				13822
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_178 = 1, #var_118_373 do
				table.insert(var_118_0, var_118_373[iter_118_178])
			end
		end

		if arg_118_1 == Data.SkillMode._2h and arg_118_0._sourceStatus == BattleData.CardStatus.pile and arg_118_0._fromPilePos == 1 then
			local var_118_374 = arg_118_0._owner._mark14055_1

			if var_118_374 ~= nil then
				local var_118_375 = var_118_374:getSkillById(14055)

				if var_118_375 ~= nil then
					table.insert(var_118_0, var_118_375)
				end
			end
		end
	elseif arg_118_0._type == Data.CardType.trap then
		for iter_118_179 = 1, #arg_118_0._skills do
			local var_118_376 = arg_118_0._skills[iter_118_179]

			if B.skillHasMode(var_118_376, arg_118_1) then
				table.insert(var_118_0, var_118_376)
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and (arg_118_0._status == BattleData.CardStatus.cover or arg_118_0._status == BattleData.CardStatus.show) then
			local var_118_377, var_118_378 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6190
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_180 = 1, #var_118_378 do
				table.insert(var_118_0, var_118_378[iter_118_180])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_379, var_118_380 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6542
			})

			for iter_118_181 = 1, #var_118_380 do
				table.insert(var_118_0, var_118_380[iter_118_181])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_381, var_118_382 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6603
			})

			for iter_118_182 = 1, #var_118_382 do
				table.insert(var_118_0, var_118_382[iter_118_182])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and (var_118_1 == nil or var_118_1 ~= arg_118_0) then
			local var_118_383, var_118_384 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2502
			})

			for iter_118_183 = 1, #var_118_384 do
				table.insert(var_118_0, var_118_384[iter_118_183])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[2623]._refCards[1]) then
			local var_118_385, var_118_386 = arg_118_0._owner:getBattleCardsBySkills("B", {
				2623
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_184 = 1, #var_118_386 do
				table.insert(var_118_0, var_118_386[iter_118_184])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_387, var_118_388 = arg_118_0._owner:getBattleCardsBySkills("H", {
				2882
			})

			for iter_118_185 = 1, #var_118_388 do
				table.insert(var_118_0, var_118_388[iter_118_185])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._status == BattleData.CardStatus.cover and arg_118_0._owner._isCoverTrapProtected then
			local var_118_389 = Data._skillInfo[12007]
			local var_118_390 = {
				_maxLevel = 1,
				_totalCastedTimes = 0,
				_id = var_118_389._id,
				_level = arg_118_0._level,
				_modes = var_118_389._modes,
				_priority = var_118_389._priority,
				_count = var_118_389._count,
				_owner = arg_118_0._owner._isCoverTrapProtected
			}

			table.insert(var_118_0, var_118_390)
		end

		if arg_118_0:isKeyword(Data._skillInfo[6645]._refCards[1]) and (var_118_1 == nil or not var_118_1:isMonsterRare() or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldMonster)) and (var_118_1 == nil or var_118_1._type ~= Data.CardType.magic or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldMagic)) and (var_118_1 == nil or var_118_1._type ~= Data.CardType.trap or not arg_118_0:hasShieldInType(BattleData.PositiveType.shieldTrap)) then
			local var_118_391, var_118_392 = arg_118_0._owner:getBattleCardsBySkills("H", {
				6645
			})

			for iter_118_186 = 1, #var_118_392 do
				table.insert(var_118_0, var_118_392[iter_118_186])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._status == BattleData.CardStatus.show and arg_118_0._owner._mark8088 then
			table.insert(var_118_0, arg_118_0._owner._mark8088:getSkillById(8088))
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[8092]._refCards[1]) then
			local var_118_393, var_118_394 = arg_118_0._owner:getBattleCardsBySkills("S", {
				8092
			})

			for iter_118_187 = 1, #var_118_394 do
				table.insert(var_118_0, var_118_394[iter_118_187])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[9195]._refCards[1]) then
			local var_118_395, var_118_396 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9195
			})

			for iter_118_188 = 1, #var_118_396 do
				table.insert(var_118_0, var_118_396[iter_118_188])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_397, var_118_398 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9279
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_189 = 1, #var_118_398 do
				table.insert(var_118_0, var_118_398[iter_118_189])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[9574]._refCards[1]) then
			local var_118_399, var_118_400 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9574
			})

			for iter_118_190 = 1, #var_118_400 do
				table.insert(var_118_0, var_118_400[iter_118_190])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_401, var_118_402 = arg_118_0._owner:getBattleCardsBySkills("S", {
				7488
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_191 = 1, #var_118_402 do
				table.insert(var_118_0, var_118_402[iter_118_191])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeywordGroup(Data._skillInfo[9976]._refCards) then
			local var_118_403, var_118_404 = arg_118_0._owner:getBattleCardsBySkills("B", {
				9976
			})

			for iter_118_192 = 1, #var_118_404 do
				table.insert(var_118_0, var_118_404[iter_118_192])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[13325]._refCards[1]) then
			local var_118_405, var_118_406 = arg_118_0._owner:getBattleCardsBySkills("B", {
				13325
			})

			for iter_118_193 = 1, #var_118_406 do
				table.insert(var_118_0, var_118_406[iter_118_193])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._owner._mark4615 then
			local var_118_407 = Data._skillInfo[12007]
			local var_118_408 = {
				_maxLevel = 1,
				_totalCastedTimes = 0,
				_id = var_118_407._id,
				_level = arg_118_0._level,
				_modes = var_118_407._modes,
				_priority = var_118_407._priority,
				_count = var_118_407._count,
				_owner = arg_118_0
			}

			table.insert(var_118_0, var_118_408)
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[7639]._refCards[1]) then
			local var_118_409, var_118_410 = arg_118_0._owner:getBattleCardsBySkills("D", {
				7639
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_194 = 1, #var_118_410 do
				table.insert(var_118_0, var_118_410[iter_118_194])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0:isKeyword(Data._skillInfo[7680]._refCards[1]) then
			local var_118_411, var_118_412 = arg_118_0._owner:getBattleCardsBySkills("S", {
				7680
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_195 = 1, #var_118_412 do
				table.insert(var_118_0, var_118_412[iter_118_195])
			end
		end

		if arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_413, var_118_414 = arg_118_0._owner:getBattleCardsBySkills("B", {
				13822
			}, Data.CARD_MAX_LEVEL, arg_118_0)

			for iter_118_196 = 1, #var_118_414 do
				table.insert(var_118_0, var_118_414[iter_118_196])
			end
		end

		if arg_118_1 == Data.SkillMode._2h and arg_118_0._sourceStatus == BattleData.CardStatus.pile and arg_118_0._fromPilePos == 1 then
			local var_118_415 = arg_118_0._owner._mark14055_1

			if var_118_415 ~= nil then
				local var_118_416 = var_118_415:getSkillById(14055)

				if var_118_416 ~= nil then
					table.insert(var_118_0, var_118_416)
				end
			end
		end
	elseif arg_118_0._type == Data.CardType.fortress then
		if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._owner:accountDamage(arg_118_0) > 0 then
			local var_118_417, var_118_418 = arg_118_0._owner:getBattleCardsBySkills("B", {
				6499,
				2731
			})

			if #var_118_418 > 0 then
				for iter_118_197 = 1, #var_118_418 do
					table.insert(var_118_0, var_118_418[iter_118_197])
				end
			end
		end

		if (arg_118_1 == Data.SkillMode.under_spell_damage or arg_118_1 == Data.SkillMode.under_attack_damage) and arg_118_0._owner:accountDamage(arg_118_0) > 0 then
			local var_118_419, var_118_420 = arg_118_0._owner:getBattleCardsBySkills("H", {
				9232
			})

			if #var_118_420 > 0 then
				for iter_118_198 = 1, #var_118_420 do
					table.insert(var_118_0, var_118_420[iter_118_198])
				end
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0._owner:accountDamage(arg_118_0) > 0 then
			local var_118_421, var_118_422 = arg_118_0._owner:getBattleCardsBySkills("G", {
				9233
			})

			if #var_118_422 > 0 then
				for iter_118_199 = 1, #var_118_422 do
					table.insert(var_118_0, var_118_422[iter_118_199])
				end
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage then
			local var_118_423, var_118_424 = arg_118_0._owner:getBattleCardsBySkills("B", {
				13229
			})

			if #var_118_424 > 0 then
				for iter_118_200 = 1, #var_118_424 do
					table.insert(var_118_0, var_118_424[iter_118_200])
				end
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_425, var_118_426 = arg_118_0._owner:getBattleCardsBySkills("D", {
				7604
			})

			if #var_118_426 > 0 then
				for iter_118_201 = 1, #var_118_426 do
					table.insert(var_118_0, var_118_426[iter_118_201])
				end
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage or arg_118_1 == Data.SkillMode.under_spell_damage then
			local var_118_427, var_118_428 = arg_118_0._owner:getBattleCardsBySkills("GL", {
				13698
			})

			for iter_118_202 = 1, #var_118_428 do
				table.insert(var_118_0, var_118_428[iter_118_202])
			end
		end

		if arg_118_1 == Data.SkillMode.under_attack_damage and arg_118_0._owner:accountDamage(arg_118_0) > 0 then
			local var_118_429, var_118_430 = arg_118_0._owner:getBattleCardsBySkills("G", {
				14235
			})

			if #var_118_430 > 0 then
				for iter_118_203 = 1, #var_118_430 do
					table.insert(var_118_0, var_118_430[iter_118_203])
				end
			end
		end
	end

	if arg_118_1 == Data.SkillMode.under_spell_damage and (arg_118_0._status == BattleData.CardStatus.hand or arg_118_0._status == BattleData.CardStatus.pile) then
		local var_118_431, var_118_432 = arg_118_0._owner:getBattleCardsBySkills("H", {
			9160
		}, Data.CARD_MAX_LEVEL, arg_118_0)

		for iter_118_204 = 1, #var_118_432 do
			table.insert(var_118_0, var_118_432[iter_118_204])
		end
	end

	if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._status == BattleData.CardStatus.hand then
		local var_118_433, var_118_434 = arg_118_0._owner:getBattleCardsBySkills("H", {
			2881,
			9467,
			13257,
			13928,
			7541,
			7595,
			13953,
			14516
		}, Data.CARD_MAX_LEVEL, arg_118_0)

		for iter_118_205 = 1, #var_118_434 do
			table.insert(var_118_0, var_118_434[iter_118_205])
		end
	end

	if arg_118_1 == Data.SkillMode.before_attack then
		local var_118_435, var_118_436 = arg_118_0._owner._opponent:getBattleCardsBySkills("B", {
			9547
		})

		for iter_118_206 = 1, #var_118_436 do
			table.insert(var_118_0, var_118_436[iter_118_206])
		end
	end

	if arg_118_1 == Data.SkillMode.under_spell_damage then
		local var_118_437, var_118_438 = arg_118_0._owner:getBattleCardsBySkills("B", {
			9553
		}, Data.CARD_MAX_LEVEL, arg_118_0)

		for iter_118_207 = 1, #var_118_438 do
			table.insert(var_118_0, var_118_438[iter_118_207])
		end
	end

	if arg_118_1 == Data.SkillMode.before_attack then
		local var_118_439, var_118_440 = arg_118_0._owner._opponent:getBattleCardsBySkills("B", {
			9554
		})

		for iter_118_208 = 1, #var_118_440 do
			table.insert(var_118_0, var_118_440[iter_118_208])
		end
	end

	if arg_118_1 == Data.SkillMode.under_spell_damage and arg_118_0._status == BattleData.CardStatus.hand then
		local var_118_441, var_118_442 = arg_118_0._owner:getBattleCardsBySkills("H", {
			5474
		})

		for iter_118_209 = 1, #var_118_442 do
			table.insert(var_118_0, var_118_442[iter_118_209])
		end
	end

	local var_118_443 = {}

	if arg_118_1 == Data.SkillMode.magic then
		var_118_443[1] = Data.SkillMode.magic_casted
	elseif arg_118_1 == Data.SkillMode.trap then
		var_118_443[1] = Data.SkillMode.trap_casted
	elseif arg_118_1 == Data.SkillMode.fortress_damaged then
		var_118_443[1] = Data.SkillMode.fortress_damaged
	elseif arg_118_1 == Data.SkillMode.fortress_hp_added then
		var_118_443[1] = Data.SkillMode.fortress_hp_added
	elseif arg_118_1 == Data.SkillMode.bcs2gl then
		var_118_443[1] = Data.SkillMode.halo_bcs2gl
		var_118_443[2] = Data.SkillMode.halo_bcs2_
	elseif arg_118_1 == Data.SkillMode.bcs2_ then
		var_118_443[1] = Data.SkillMode.halo_bcs2_

		if arg_118_0._owner and var_118_1 ~= nil and var_118_1._destStatus == BattleData.CardStatus.hand then
			var_118_443[2] = Data.SkillMode.halo__2h
		end
	elseif arg_118_1 == Data.SkillMode.sacrifice then
		var_118_443[1] = Data.SkillMode.halo_sacrifice
		var_118_443[2] = Data.SkillMode.halo_bcs2_
	elseif arg_118_1 == Data.SkillMode.h2gl_by_self or arg_118_1 == Data.SkillMode.h2gl_by_oppo then
		var_118_443[1] = Data.SkillMode.halo_h2gl
	elseif arg_118_1 == Data.SkillMode.h2p_by_self or arg_118_1 == Data.SkillMode.h2p_by_oppo then
		var_118_443[1] = Data.SkillMode.halo_h2p
	elseif arg_118_1 == Data.SkillMode.p2gl_by_self or arg_118_1 == Data.SkillMode.p2gl_by_oppo then
		var_118_443[1] = Data.SkillMode.halo_p2gl
	elseif arg_118_1 == Data.SkillMode.r2gl_by_self or arg_118_1 == Data.SkillMode.r2gl_by_oppo then
		var_118_443[1] = Data.SkillMode.halo_r2gl
	elseif arg_118_1 == Data.SkillMode.cost then
		var_118_443[1] = Data.SkillMode.halo_cost
	elseif arg_118_1 == Data.SkillMode.using then
		var_118_443[1] = Data.SkillMode.halo_using
	elseif arg_118_1 == Data.SkillMode.g2b then
		var_118_443[1] = Data.SkillMode.halo_g2b
		var_118_443[2] = Data.SkillMode.halo_using
	elseif arg_118_1 == Data.SkillMode.g2h then
		var_118_443[1] = Data.SkillMode.halo_g2h
		var_118_443[2] = Data.SkillMode.halo__2h
	elseif arg_118_1 == Data.SkillMode.g2notbh then
		var_118_443[1] = Data.SkillMode.halo_g2notbh
	elseif arg_118_1 == Data.SkillMode.g2l_by_self then
		var_118_443[1] = Data.SkillMode.halo_g2l_by_self
		var_118_443[2] = Data.SkillMode.halo_g2notbh
	elseif arg_118_1 == Data.SkillMode.g2l_by_oppo then
		var_118_443[1] = Data.SkillMode.halo_g2l_by_oppo
		var_118_443[2] = Data.SkillMode.halo_g2notbh
	elseif arg_118_1 == Data.SkillMode.g2p then
		var_118_443[1] = Data.SkillMode.halo_g2p
		var_118_443[2] = Data.SkillMode.halo_g2notbh
	elseif arg_118_1 == Data.SkillMode.g2r then
		var_118_443[1] = Data.SkillMode.halo_g2r
		var_118_443[2] = Data.SkillMode.halo_g2notbh
	elseif arg_118_1 == Data.SkillMode._2h then
		var_118_443[1] = Data.SkillMode.halo__2h
	elseif arg_118_1 == Data.SkillMode.before_magic_trap then
		var_118_443[1] = Data.SkillMode.halo_before_magic_trap
	elseif arg_118_1 == Data.SkillMode.h2l_temp_by_self or arg_118_1 == Data.SkillMode.h2l_temp_by_oppo then
		var_118_443[1] = Data.SkillMode.halo_h2l_temp
	end

	for iter_118_210 = 1, #var_118_443 do
		local var_118_444 = var_118_443[iter_118_210]

		arg_118_0._haloSkills = arg_118_0._haloSkills or {}

		if arg_118_2 == 0 then
			arg_118_0._haloSkills[var_118_444] = B.mergeTable({
				arg_118_0._owner:getHaloModeSkills(var_118_444),
				arg_118_0._owner._opponent:getHaloModeSkills(var_118_444 + 1)
			})
		end

		local var_118_445 = arg_118_0._haloSkills[var_118_444] or {}

		for iter_118_211 = 1, #var_118_445 do
			table.insert(var_118_0, var_118_445[iter_118_211])
		end
	end

	if (arg_118_1 == Data.SkillMode.cost or arg_118_1 == Data.SkillMode.using) and arg_118_0._mark6387 then
		for iter_118_212 = #var_118_0, 1, -1 do
			local var_118_446 = var_118_0[iter_118_212]

			if var_118_446._owner._owner ~= arg_118_0._owner and var_118_446._id ~= 9407 then
				table.remove(var_118_0, iter_118_212)
			end
		end
	end

	table.sort(var_118_0, function(arg_119_0, arg_119_1)
		if arg_119_0._id == 6358 and arg_119_1._id ~= 6358 then
			return true
		elseif arg_119_0._id ~= 6358 and arg_119_1._id == 6358 then
			return false
		elseif arg_119_0._id == 2239 and arg_119_1._id ~= 2239 then
			return true
		elseif arg_119_0._id ~= 2239 and arg_119_1._id == 2239 then
			return false
		elseif arg_119_0._id == 2309 and arg_119_1._id ~= 2309 then
			return true
		elseif arg_119_0._id ~= 2309 and arg_119_1._id == 2309 then
			return false
		elseif arg_119_0._id == 2350 and arg_119_1._id ~= 2350 then
			return true
		elseif arg_119_0._id ~= 2350 and arg_119_1._id == 2350 then
			return false
		elseif arg_119_0._id == 9355 and arg_119_1._id ~= 9355 then
			return true
		elseif arg_119_0._id ~= 9355 and arg_119_1._id == 9355 then
			return false
		elseif arg_119_0._id == 4877 and arg_119_1._id ~= 4877 then
			return true
		elseif arg_119_0._id ~= 4877 and arg_119_1._id == 4877 then
			return false
		elseif arg_119_0._id == 13161 and arg_119_1._id ~= 13161 then
			return true
		elseif arg_119_0._id ~= 13161 and arg_119_1._id == 13161 then
			return false
		elseif arg_119_0._modes[2] == 135 and arg_119_1._modes[2] ~= 135 then
			return true
		elseif arg_119_0._modes[2] ~= 135 and arg_119_1._modes[2] == 135 then
			return false
		elseif arg_119_0._priority < arg_119_1._priority then
			return true
		elseif arg_119_0._priority > arg_119_1._priority then
			return false
		elseif arg_119_0._id < arg_119_1._id then
			return true
		elseif arg_119_0._id > arg_119_1._id then
			return false
		elseif arg_119_0._owner == arg_118_0 and arg_119_1._owner ~= arg_118_0 then
			return true
		elseif arg_119_0._owner ~= arg_118_0 and arg_119_1._owner == arg_118_0 then
			return false
		else
			return arg_119_0._owner._id < arg_119_1._owner._id
		end
	end)

	return var_118_0
end

function var_0_0.getSkillByMode(arg_120_0, arg_120_1, arg_120_2)
	return arg_120_0:getSkillsByMode(arg_120_1, arg_120_2)[arg_120_2]
end

function var_0_0.getSkillIndex(arg_121_0, arg_121_1)
	for iter_121_0 = 1, #arg_121_0._skills do
		if arg_121_0._skills[iter_121_0] == arg_121_1 then
			return iter_121_0
		end
	end

	return 0
end

function var_0_0.getSkillById(arg_122_0, arg_122_1)
	for iter_122_0 = 1, #arg_122_0._skills do
		if arg_122_0._skills[iter_122_0]._id == arg_122_1 then
			return arg_122_0._skills[iter_122_0]
		end
	end
end

function var_0_0.getSkillIndexById(arg_123_0, arg_123_1)
	for iter_123_0 = 1, #arg_123_0._skills do
		if arg_123_0._skills[iter_123_0]._id == arg_123_1 then
			return iter_123_0
		end
	end

	return 0
end

function var_0_0.saveSkillCastTimes(arg_124_0)
	local var_124_0 = {}

	if arg_124_0:isMonsterRare() then
		for iter_124_0, iter_124_1 in ipairs(arg_124_0._skills) do
			var_124_0[iter_124_0] = iter_124_1._castTimes
		end
	end

	return var_124_0
end

function var_0_0.loadSkillCastTimes(arg_125_0, arg_125_1)
	if next(arg_125_1) ~= nil then
		for iter_125_0, iter_125_1 in ipairs(arg_125_0._skills) do
			iter_125_1._castTimes = arg_125_1[iter_125_0] or 0
		end
	end
end

function var_0_0.hasSkills(arg_126_0, arg_126_1, arg_126_2)
	local var_126_0 = {}

	if arg_126_0._skills == nil then
		return false, var_126_0
	end

	for iter_126_0 = 1, #arg_126_0._skills do
		local var_126_1 = arg_126_0._skills[iter_126_0]._id

		for iter_126_1 = 1, #arg_126_1 do
			if var_126_1 == arg_126_1[iter_126_1] then
				if arg_126_2 == true then
					local var_126_2 = math.floor(var_126_1 / Data.INFO_ID_GROUP_SIZE) + BattleData.NegativeType.skillFrozenBegin - 1

					if not arg_126_0._negativeStatus[var_126_2] then
						var_126_0[#var_126_0 + 1] = arg_126_0._skills[iter_126_0]

						break
					end
				else
					var_126_0[#var_126_0 + 1] = arg_126_0._skills[iter_126_0]

					break
				end
			end
		end
	end

	return #var_126_0 > 0, var_126_0
end

function var_0_0.hasSkillFast(arg_127_0, arg_127_1)
	if arg_127_0._skills == nil then
		return false
	end

	for iter_127_0 = 1, #arg_127_0._skills do
		if arg_127_0._skills[iter_127_0]._id == arg_127_1 then
			return true
		end
	end

	return false
end

function var_0_0.hasCanCastMonsterSkills(arg_128_0, arg_128_1)
	for iter_128_0 = 1, #arg_128_1 do
		if arg_128_0:hasCanCastMonsterSkillFast(arg_128_1[iter_128_0]) then
			return true
		end
	end

	return false
end

function var_0_0.hasCanCastMonsterSkillFast(arg_129_0, arg_129_1)
	if not arg_129_0:hasSkillFast(arg_129_1) then
		return false
	end

	return arg_129_0:canCastMonsterSkill()
end

function var_0_0.hasCanCastMagicSkillFast(arg_130_0, arg_130_1)
	if not arg_130_0:hasSkillFast(arg_130_1) then
		return false
	end

	return not arg_130_0._owner:isMagicDisabled(arg_130_0)
end

function var_0_0.hasCanCastTrapSkillFast(arg_131_0, arg_131_1)
	if not arg_131_0:hasSkillFast(arg_131_1) then
		return false
	end

	return arg_131_0._owner:canTrapEffect(arg_131_0)
end

function var_0_0.isSkillAtIndex(arg_132_0, arg_132_1, arg_132_2)
	if arg_132_0._skills == nil then
		return false
	end

	local var_132_0 = arg_132_0._skills[arg_132_2]

	if var_132_0 == nil then
		return false
	end

	return var_132_0._id == arg_132_1
end

function var_0_0.hasSkillInMode(arg_133_0, arg_133_1)
	local var_133_0 = {}

	for iter_133_0 = 1, #arg_133_0._skills do
		local var_133_1 = arg_133_0._skills[iter_133_0]

		if B.skillHasMode(var_133_1, arg_133_1) then
			var_133_0[#var_133_0 + 1] = var_133_1
		end
	end

	return #var_133_0 > 0, var_133_0
end

function var_0_0.hasSkillInModes(arg_134_0, arg_134_1)
	local var_134_0 = {}

	for iter_134_0 = 1, #arg_134_0._skills do
		local var_134_1 = arg_134_0._skills[iter_134_0]
		local var_134_2 = true

		for iter_134_1 = 1, #arg_134_1 do
			if not B.skillHasMode(var_134_1, arg_134_1[iter_134_1]) then
				var_134_2 = false
			end
		end

		if var_134_2 then
			var_134_0[#var_134_0 + 1] = var_134_1
		end
	end

	return #var_134_0 > 0, var_134_0
end

function var_0_0.hasChoiceSkill(arg_135_0)
	for iter_135_0 = 1, #arg_135_0._skills do
		local var_135_0 = arg_135_0._skills[iter_135_0]

		if B.skillHasMode(var_135_0, Data.SkillMode.choice) then
			return true, var_135_0
		end
	end

	return false
end

function var_0_0.hasNoGemSkill(arg_136_0)
	for iter_136_0 = 1, #arg_136_0._skills do
		local var_136_0 = arg_136_0._skills[iter_136_0]

		if Data._skillInfo[var_136_0._id]._needNoGem == 1 then
			return true, var_136_0
		end
	end

	return false
end

function var_0_0.hasBetraySkill(arg_137_0)
	return false
end

function var_0_0.hasNeedExtraGemSkill(arg_138_0)
	for iter_138_0 = 1, #arg_138_0._skills do
		local var_138_0 = arg_138_0._skills[iter_138_0]

		if Data._skillInfo[var_138_0._id]._needExtraGem == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasDefendRuseSkill(arg_139_0)
	return false
end

function var_0_0.hasTargetUsingSkill(arg_140_0)
	for iter_140_0 = 1, #arg_140_0._skills do
		local var_140_0 = arg_140_0._skills[iter_140_0]

		if Data._skillInfo[var_140_0._id]._targetType ~= 0 then
			return true, var_140_0
		end
	end

	return false
end

function var_0_0.hasPowerSacrificeSkill(arg_141_0, arg_141_1)
	for iter_141_0 = 1, #arg_141_0._skills do
		local var_141_0 = arg_141_0._skills[iter_141_0]
		local var_141_1 = Data._skillInfo[var_141_0._id]

		if arg_141_1:isNature(var_141_1._refCards[1]) then
			if var_141_1._id == 6005 or var_141_1._id == 6017 or var_141_1._id == 6049 or var_141_1._id == 6099 then
				return true, var_141_1
			elseif var_141_1._id == 6047 and arg_141_1:isNormalMonster() then
				return true, var_141_1
			elseif var_141_1._id == 6051 and var_141_1._refCards[2] == arg_141_1._info._category then
				return true, var_141_1
			end
		end

		if var_141_1._refCards[1] == arg_141_1._info._category and (var_141_1._id == 6120 or var_141_1._id == 6328 or var_141_1._id == 6768 or var_141_1._id == 9817) then
			return true, var_141_1
		end

		if arg_141_1:isKeyword(var_141_1._refCards[1]) and (var_141_1._id == 6093 or var_141_1._id == 6193) then
			return true, var_141_1
		end

		if var_141_1._id == 6140 or var_141_1._id == 2492 then
			return true, var_141_1
		end
	end

	if arg_141_1:hasSkillFast(6072) and arg_141_0._info._category == Data._skillInfo[6072]._refCards[1] then
		return true, Data._skillInfo[6072]
	elseif arg_141_1:hasSkillFast(6084) and arg_141_0._info._category == Data._skillInfo[6084]._refCards[1] then
		return true, Data._skillInfo[6084]
	elseif arg_141_1:hasSkillFast(6030) and arg_141_0:isSummonedBySacrifice() then
		return true, Data._skillInfo[6030]
	elseif arg_141_1:hasSkillFast(6192) and arg_141_0._info._category == Data._skillInfo[6192]._refCards[2] and arg_141_0:isKeyword(Data._skillInfo[6192]._refCards[1]) then
		return true, Data._skillInfo[6192]
	elseif arg_141_1:hasSkillFast(6230) and arg_141_0:isKeyword(Data._skillInfo[6230]._refCards[1]) then
		return true, Data._skillInfo[6230]
	elseif arg_141_1:hasSkillFast(6233) and arg_141_0:isKeyword(Data._skillInfo[6233]._refCards[1]) then
		return true, Data._skillInfo[6233]
	elseif arg_141_1:hasSkillFast(6260) and arg_141_0._info._category == Data._skillInfo[6260]._refCards[1] then
		return true, Data._skillInfo[6260]
	elseif arg_141_1:hasSkillFast(6600) and arg_141_0._info._category == Data._skillInfo[6600]._refCards[1] then
		return true, Data._skillInfo[6600]
	elseif arg_141_1:hasSkillFast(3378) then
		local var_141_2 = Data._skillInfo[3378]

		if arg_141_0:isNature(var_141_2._refCards[1]) and #B.filterUniqueInfoIdCards(arg_141_1._owner:getBattleCardsByNature("G", var_141_2._refCards[1])) >= 4 then
			return true, var_141_2
		end
	elseif arg_141_1:hasSkillFast(2876) and arg_141_0:getStar() ~= Data.XYZ_STAR and arg_141_0:getStar() >= 5 then
		return true, Data._skillInfo[2876]
	elseif arg_141_1:hasSkillFast(9700) and arg_141_0:isKeyword(Data._skillInfo[9700]._refCards[1]) then
		return true, Data._skillInfo[9700]
	end

	if arg_141_0:getStar() >= 5 and arg_141_1:getStar() >= 7 and not arg_141_1:hasSkillFast(3131) and arg_141_0._owner:hasBattleCardsBySkillFast("S", 7464) then
		return true, Data._skillInfo[7464]
	end

	return false
end

function var_0_0.hasSiegeSkill(arg_142_0)
	for iter_142_0 = 1, #arg_142_0._skills do
		if B.isSkillSiege(arg_142_0._skills[iter_142_0]._id, arg_142_0) then
			return true
		end
	end

	return false
end

function var_0_0.hasDisableMonsterBeforeAttackSkills(arg_143_0, arg_143_1)
	if arg_143_1 then
		return arg_143_0:hasCanCastMonsterSkills({
			1045,
			1056,
			1064,
			1164
		}) or arg_143_0:isBindedSkill(7532)
	else
		return arg_143_0:hasSkills({
			1045,
			1056,
			1064,
			1164
		}) or arg_143_0:isBindedSkill(7532)
	end
end

function var_0_0.hasDisableMagicBeforeAttackSkills(arg_144_0, arg_144_1)
	if arg_144_1 then
		return arg_144_0:hasCanCastMonsterSkills({
			1045,
			1056,
			1065
		}) or arg_144_0:isBindedSkill(7532)
	else
		return arg_144_0:hasSkills({
			1045,
			1056,
			1065
		}) or arg_144_0:isBindedSkill(7532)
	end
end

function var_0_0.hasDisableTrapBeforeAttackSkills(arg_145_0, arg_145_1)
	if arg_145_1 then
		return arg_145_0:hasCanCastMonsterSkills({
			1038,
			1045,
			1056,
			1065,
			1097
		}) or arg_145_0:isBindedSkill(7532)
	else
		return arg_145_0:hasSkills({
			1038,
			1045,
			1056,
			1065,
			1097
		}) or arg_145_0:isBindedSkill(7532)
	end
end

local var_0_3 = {
	3763,
	3765,
	3767,
	3769,
	3776,
	3830,
	3838,
	3840,
	3951,
	3952,
	3953,
	3956,
	3959,
	3961,
	3964,
	3967,
	3968,
	3969,
	3970,
	4641,
	4642,
	5355,
	5356,
	5357,
	5358,
	5424,
	5486,
	6336,
	6337,
	6369,
	6395,
	6869,
	2665,
	2712,
	2713,
	2825,
	2826,
	2827,
	2828,
	2829,
	2830,
	2831,
	2832,
	2833,
	2834,
	2835,
	2836,
	2837,
	2939,
	2940,
	9135,
	9136,
	9137,
	9138,
	9139,
	9140,
	9141,
	9179,
	9199,
	9201,
	9420,
	9421,
	9422,
	9436,
	9645,
	9705,
	9706,
	9707,
	9708,
	9711,
	9748,
	9894,
	9899,
	9900,
	9901,
	9902,
	9903,
	9904,
	9905,
	9906,
	9907,
	9992,
	13011,
	13055,
	13056,
	13057,
	13070,
	13071,
	13193,
	13194,
	13195
}
local var_0_4 = {
	4253,
	4255,
	4256,
	4257,
	4259,
	4281,
	4283,
	4284,
	4307,
	4308,
	4309,
	4310,
	4311,
	4312,
	4313,
	4314,
	4315,
	4316,
	4317,
	4342,
	4343,
	4348,
	4352,
	4472,
	4473,
	4704,
	4705,
	4706,
	4707,
	4707,
	4708,
	4709,
	4710,
	4711,
	4712,
	4713,
	4714,
	4715,
	4716,
	4745,
	4746,
	4786,
	4787,
	4788,
	4789,
	4790,
	4791,
	4792,
	4801,
	4817,
	4818,
	4844,
	4845,
	4846,
	4864,
	4874,
	4879,
	4880,
	4881,
	4882,
	4883,
	4886,
	4923,
	4924,
	4925,
	4926,
	4927,
	4928,
	4929,
	4930,
	4931,
	4932,
	4950,
	4951,
	4965,
	4966,
	4967,
	4972,
	4973,
	4995,
	4996,
	4997,
	7563,
	7652
}

function var_0_0.getAlterMagicInfoId(arg_146_0)
	local var_146_0, var_146_1 = arg_146_0:hasSkills(var_0_3)

	if var_146_0 then
		return Data._skillInfo[var_146_1[1]._id]._refCards[1]
	end

	return nil
end

function var_0_0.getAlterMonsterInfoId(arg_147_0)
	local var_147_0, var_147_1 = arg_147_0:hasSkills(var_0_4)

	if var_147_0 then
		return Data._skillInfo[var_147_1[1]._id]._refCards[1]
	end

	return nil
end

function var_0_0.isAlterMonsterSkill(arg_148_0, arg_148_1)
	return B.tableContain(var_0_4, arg_148_1)
end

function var_0_0.getSkillVal(arg_149_0, arg_149_1)
	if arg_149_0:isMonsterRare() or arg_149_0._type == Data.CardType.boss then
		for iter_149_0 = 1, #arg_149_0._skills do
			if arg_149_1 == arg_149_0._skills[iter_149_0]._id then
				return Data._skillInfo[arg_149_1]._val[arg_149_0._skills[iter_149_0]._level]
			end
		end
	end

	return 0
end

function var_0_0.incSkillMaxLevel(arg_150_0, arg_150_1, arg_150_2)
	local var_150_0 = (arg_150_0._skillMaxLevelInc[arg_150_1] or 0) + arg_150_2

	arg_150_0._skillMaxLevelInc[arg_150_1] = var_150_0
end

function var_0_0.getUnderSkillIndex(arg_151_0, arg_151_1)
	local var_151_0 = math.floor(arg_151_1 / Data.INFO_ID_GROUP_SIZE)
	local var_151_1 = {}

	for iter_151_0 = 1, #arg_151_0._underSkills do
		local var_151_2 = arg_151_0._underSkills[iter_151_0]
		local var_151_3 = math.floor(var_151_2._sid / Data.INFO_ID_GROUP_SIZE)

		if not var_151_2._disabled and var_151_3 == var_151_0 then
			local var_151_4 = false

			for iter_151_1 = 1, #var_151_1 do
				if var_151_1[iter_151_1] == var_151_2._sid then
					var_151_4 = true

					break
				end
			end

			if not var_151_4 then
				var_151_1[#var_151_1 + 1] = var_151_2._sid
			end
		end
	end

	local var_151_5 = 1

	for iter_151_2 = 1, #var_151_1 do
		if var_151_1[iter_151_2] == arg_151_1 then
			var_151_5 = iter_151_2

			break
		end
	end

	return var_151_5
end

function var_0_0.saveExtraSkills(arg_152_0)
	local var_152_0 = {}

	if arg_152_0:isMonsterRare() then
		for iter_152_0, iter_152_1 in ipairs(arg_152_0._skills) do
			if iter_152_1._provider == BattleData.SkillProvider.extra or iter_152_1._provider == BattleData.SkillProvider.copy or iter_152_1._provider == BattleData.SkillProvider.given then
				if (arg_152_0._sourceStatus == BattleData.CardStatus.board or arg_152_0._sourceStatus == BattleData.CardStatus.hand) and (arg_152_0._destStatus == BattleData.CardStatus.grave or arg_152_0._destStatus == BattleData.CardStatus.leave or arg_152_0._destStatus == BattleData.CardStatus.rare) then
					if B.skillHasMode(iter_152_1, Data.SkillMode.bcs2gl) or B.skillHasMode(iter_152_1, Data.SkillMode.initiative_grave) or B.skillHasMode(iter_152_1, Data.SkillMode.initiative_leave) or B.skillHasMode(iter_152_1, Data.SkillMode.after_attack) or iter_152_1._id == 3067 or iter_152_1._id == 6045 or iter_152_1._id == 4172 then
						var_152_0[#var_152_0 + 1] = iter_152_1
					end
				elseif arg_152_0._sourceStatus == BattleData.CardStatus.board and (arg_152_0._destStatus == BattleData.CardStatus.hand or arg_152_0._destStatus == BattleData.CardStatus.pile) then
					if B.skillHasMode(iter_152_1, Data.SkillMode.bcs2_) then
						var_152_0[#var_152_0 + 1] = iter_152_1
					end
				elseif arg_152_0._statusVal == BattleData.CardStatusVal.g2b_5096 then
					var_152_0[#var_152_0 + 1] = iter_152_1
				elseif arg_152_0._sourceStatus == BattleData.CardStatus.board and arg_152_0._destStatus == BattleData.CardStatus.grave and iter_152_1._id == 6341 then
					var_152_0[#var_152_0 + 1] = iter_152_1
				elseif arg_152_0._sourceStatus == BattleData.CardStatus.hand and arg_152_0._destStatus == BattleData.CardStatus.board and (iter_152_1._id == 3210 or iter_152_1._id == 13975) then
					var_152_0[#var_152_0 + 1] = iter_152_1
				elseif arg_152_0._sourceStatus == BattleData.CardStatus.hand and arg_152_0._destStatus == BattleData.CardStatus.board and iter_152_1._id == 2165 then
					var_152_0[#var_152_0 + 1] = iter_152_1
				end
			end
		end
	elseif arg_152_0._type == Data.CardType.magic then
		for iter_152_2, iter_152_3 in ipairs(arg_152_0._skills) do
			if arg_152_0._status == BattleData.CardStatus.hand and (iter_152_3._id == 4325 or iter_152_3._id == 4549) and not B.tableContain(arg_152_0._info._skillId, iter_152_3._id) or iter_152_3._id == 4339 or iter_152_3._id == 4593 or iter_152_3._id == 4639 or iter_152_3._id == 4774 and arg_152_0._destStatus ~= BattleData.CardStatus.pile or iter_152_3._id == 3210 and arg_152_0._mark7750 then
				var_152_0[#var_152_0 + 1] = iter_152_3
			end
		end
	elseif arg_152_0._type == Data.CardType.trap then
		for iter_152_4, iter_152_5 in ipairs(arg_152_0._skills) do
			if iter_152_5._provider == BattleData.SkillProvider.extra or iter_152_5._provider == BattleData.SkillProvider.copy or iter_152_5._provider == BattleData.SkillProvider.given then
				if B.skillHasMode(iter_152_5, Data.SkillMode.bcs2_) then
					if (arg_152_0._sourceStatus == BattleData.CardStatus.cover or arg_152_0._sourceStatus == BattleData.CardStatus.show) and arg_152_0._destStatus ~= BattleData.CardStatus.cover and arg_152_0._destStatus ~= BattleData.CardStatus.show then
						var_152_0[#var_152_0 + 1] = iter_152_5
					elseif iter_152_5._id == 5220 or iter_152_5._id == 5526 then
						var_152_0[#var_152_0 + 1] = iter_152_5
					end
				elseif B.skillHasMode(iter_152_5, Data.SkillMode.bcs2gl) or B.skillHasMode(iter_152_5, Data.SkillMode.initiative_grave) then
					if (arg_152_0._sourceStatus == BattleData.CardStatus.cover or arg_152_0._sourceStatus == BattleData.CardStatus.show) and (arg_152_0._destStatus == BattleData.CardStatus.grave or arg_152_0._destStatus == BattleData.CardStatus.leave) then
						var_152_0[#var_152_0 + 1] = iter_152_5
					end
				elseif B.skillHasMode(iter_152_5, Data.SkillMode.initiative_leave) and arg_152_0._sourceStatus ~= BattleData.CardStatus.leave and arg_152_0._destStatus == BattleData.CardStatus.leave then
					var_152_0[#var_152_0 + 1] = iter_152_5
				end
			end

			if arg_152_0._status == BattleData.CardStatus.hand and iter_152_5._id == 5007 or iter_152_5._id == 5341 then
				var_152_0[#var_152_0 + 1] = iter_152_5
			end

			if (arg_152_0._sourceStatus == BattleData.CardStatus.hand or arg_152_0._sourceStatus == BattleData.CardStatus.trap or arg_152_0._sourceStatus == BattleData.CardStatus.show) and iter_152_5._id == 5540 then
				var_152_0[#var_152_0 + 1] = iter_152_5
			end
		end
	end

	return var_152_0
end

function var_0_0.loadExtraSkills(arg_153_0, arg_153_1)
	if #arg_153_1 ~= 0 then
		for iter_153_0 = 1, #arg_153_1 do
			arg_153_0._skills[#arg_153_0._skills + 1] = arg_153_1[iter_153_0]
		end
	end

	if arg_153_0._mark5052 then
		for iter_153_1 = #arg_153_0._skills, 1, -1 do
			if B.skillHasMode(arg_153_0._skills[iter_153_1], Data.SkillMode.bcs2gl) then
				table.remove(arg_153_0._skills, iter_153_1)
			end
		end

		arg_153_0._mark5052 = nil
	end
end

function var_0_0.getInitiativeSkill(arg_154_0, arg_154_1)
	local var_154_0 = {}

	for iter_154_0 = 1, #arg_154_0._skills do
		local var_154_1 = arg_154_0._skills[iter_154_0]

		if B.skillHasMode(var_154_1, arg_154_1) then
			var_154_0[#var_154_0 + 1] = var_154_1
		end
	end

	return var_154_0
end

function var_0_0.canCastInitiativeSkill(arg_155_0)
	local var_155_0

	if arg_155_0._status == BattleData.CardStatus.board or arg_155_0._status == BattleData.CardStatus.show or arg_155_0._status == BattleData.CardStatus.field then
		var_155_0 = arg_155_0:getInitiativeSkill(Data.SkillMode.initiative_bcs)
	elseif arg_155_0._status == BattleData.CardStatus.grave then
		var_155_0 = arg_155_0:getInitiativeSkill(Data.SkillMode.initiative_grave)
	elseif arg_155_0._status == BattleData.CardStatus.rare then
		var_155_0 = arg_155_0:getInitiativeSkill(Data.SkillMode.initiative_rare)
	elseif arg_155_0._status == BattleData.CardStatus.hand then
		var_155_0 = arg_155_0:getInitiativeSkill(Data.SkillMode.initiative_hand)
	elseif arg_155_0._status == BattleData.CardStatus.leave then
		var_155_0 = arg_155_0:getInitiativeSkill(Data.SkillMode.initiative_leave)
	end

	local var_155_1 = {}

	if var_155_0 ~= nil then
		for iter_155_0 = 1, #var_155_0 do
			if arg_155_0._owner:canUseInitiativeSkill(arg_155_0, var_155_0[iter_155_0]) then
				var_155_1[#var_155_1 + 1] = var_155_0[iter_155_0]
			end
		end
	end

	return #var_155_1 > 0, var_155_1
end

function var_0_0.canCastMonsterSkill(arg_156_0, arg_156_1, arg_156_2)
	if arg_156_0._owner._isMonsterSkillDisabled then
		return false
	end

	if arg_156_0:hasBuff(false, BattleData.NegativeType.skillFrozenHalo) then
		return false
	end

	if arg_156_0._mark5127 or arg_156_0._mark3832 or arg_156_0._mark3921 or arg_156_0._mark6346 or arg_156_0._mark9226 or arg_156_0._mark14157 then
		return false
	end

	if (arg_156_0._mark2207 or arg_156_0._mark3940_2) and arg_156_0._status == BattleData.CardStatus.board then
		return false
	end

	if arg_156_0._mark5249 then
		return false
	end

	if arg_156_0._owner._mark5533 and arg_156_0._status == BattleData.CardStatus.grave and (arg_156_1 ~= Data.SkillMode.cost or not Data._skillInfo[arg_156_2] or not B.skillInfoHasMode(Data._skillInfo[arg_156_2], Data.SkillMode.in_gl)) then
		return false
	end

	if arg_156_0._mark4513 and arg_156_0._status == BattleData.CardStatus.grave then
		return false
	end

	if arg_156_0._mark13530 and (arg_156_0._status == BattleData.CardStatus.grave or arg_156_0._status == BattleData.CardStatus.hand) then
		return false
	end

	if arg_156_0._mark7711 and arg_156_0._status == BattleData.CardStatus.hand then
		return false
	end

	if arg_156_0._mark2343 then
		return false
	end

	if arg_156_0._isCardSkillDisabledInRound then
		return false
	end

	if arg_156_0._mark2481 then
		return false
	end

	if arg_156_0._mark9617 then
		return false
	end

	if arg_156_0._owner._disableSkillByOwnerInfoId[arg_156_0._infoId] then
		return false
	end

	if arg_156_0._owner._mark2548 and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMonster) and arg_156_0._status ~= BattleData.CardStatus.pile and arg_156_0._status ~= BattleData.CardStatus.leave then
		return false
	end

	if arg_156_0:hasBuff(false, BattleData.NegativeType.boardMonsterSkillFrozen) and arg_156_0._status == BattleData.CardStatus.board then
		return false
	end

	if arg_156_0._owner._opponent._mark2819 and arg_156_0._status == BattleData.CardStatus.board and arg_156_0._onBoardFrom == BattleData.CardStatus.rare and (arg_156_1 ~= Data.SkillMode.cost or arg_156_2 == 9003) and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMonster) then
		return false
	end

	if arg_156_0._status == BattleData.CardStatus.board and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMonster) and arg_156_1 ~= Data.SkillMode.cost and not arg_156_0:isInfoId(Data._skillInfo[6464]._refCards[1]) and (arg_156_0._owner:hasBattleCardsBySkillFast("B", 6464, Data.CARD_MAX_LEVEL, arg_156_0) or arg_156_0._owner._opponent:hasBattleCardsBySkillFast("B", 6464)) then
		return false
	end

	if (arg_156_0._status == BattleData.CardStatus.board or arg_156_1 == Data.SkillMode.bcs2gl or arg_156_1 == Data.SkillMode.bcs2_ or arg_156_1 == Data.SkillMode.sacrifice) and arg_156_0._status ~= BattleData.CardStatus.hand and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMonster) and (arg_156_1 ~= Data.SkillMode.cost or arg_156_2 == 9003 or arg_156_2 == 13655 or arg_156_2 == 13654 or arg_156_2 == 14316) and arg_156_0._owner._opponent:hasBattleCardsBySkillFast("B", 6693) then
		return false
	end

	if arg_156_0._status == BattleData.CardStatus.board and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMonster) and arg_156_1 ~= Data.SkillMode.cost and not arg_156_0._summonByNormal and arg_156_0:getStar() ~= Data.XYZ_STAR and arg_156_0:getStar() >= Data._skillInfo[2284]._val[1] and (arg_156_0._owner:hasBattleCardsBySkillFast("B", 2284) or arg_156_0._owner._opponent:hasBattleCardsBySkillFast("B", 2284)) then
		return false
	end

	if arg_156_0._status == BattleData.CardStatus.board and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMonster) and (arg_156_1 ~= Data.SkillMode.cost or arg_156_2 == 9003 or arg_156_2 == 9040) and arg_156_0._onBoardFrom == BattleData.CardStatus.rare and arg_156_0._owner._opponent:hasBattleCardsBySkillFast("B", 2339) then
		return false
	end

	if arg_156_0._status == BattleData.CardStatus.board and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMagic) and arg_156_1 ~= Data.SkillMode.cost and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMagic) and (arg_156_0._owner:hasBattleCardsBySkillFast("D", 7261) or arg_156_0._owner._opponent:hasBattleCardsBySkillFast("D", 7261)) and #arg_156_0._owner:getBoardCards() > #arg_156_0._owner._opponent:getBoardCards() and #arg_156_0._owner._opponent:getBoardCards() > 0 then
		return false
	end

	if (arg_156_0._status == BattleData.CardStatus.board or arg_156_1 == Data.SkillMode.bcs2gl or arg_156_1 == Data.SkillMode.bcs2_ or arg_156_1 == Data.SkillMode.sacrifice) and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMagic) and arg_156_1 ~= Data.SkillMode.cost and (arg_156_0._owner:hasBattleCardsBySkillFast("S", 7282) or arg_156_0._owner._opponent:hasBattleCardsBySkillFast("S", 7282)) and not arg_156_0._summonByNormal and arg_156_0._onBoardFrom == BattleData.CardStatus.pile then
		return false
	end

	if (arg_156_0._status == BattleData.CardStatus.board or arg_156_1 == Data.SkillMode.bcs2gl or arg_156_1 == Data.SkillMode.bcs2_ or arg_156_1 == Data.SkillMode.sacrifice) and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldTrap) and arg_156_1 ~= Data.SkillMode.cost and not arg_156_0:isSummonedBySacrifice() and (arg_156_0._owner:hasBattleCardsByCanCastTrapSkillFast("S", 8078) or arg_156_0._owner._opponent:hasBattleCardsByCanCastTrapSkillFast("S", 8078)) then
		return false
	end

	if (arg_156_0._status == BattleData.CardStatus.board or arg_156_0._status == BattleData.CardStatus.grave or arg_156_1 == Data.SkillMode.bcs2gl or arg_156_1 == Data.SkillMode.bcs2_ or arg_156_1 == Data.SkillMode.sacrifice) and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldTrap, true) and arg_156_1 ~= Data.SkillMode.cost and arg_156_0:isNature(Data._skillInfo[8079]._refCards[1]) and arg_156_0._owner:hasBattleCardsBySkillFast("S", 8079) then
		return false
	end

	if (arg_156_0._status == BattleData.CardStatus.board or arg_156_0._status == BattleData.CardStatus.grave or arg_156_1 == Data.SkillMode.bcs2gl or arg_156_1 == Data.SkillMode.bcs2_ or arg_156_1 == Data.SkillMode.sacrifice) and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldTrap) and arg_156_1 ~= Data.SkillMode.cost and arg_156_0:isNature(Data._skillInfo[8079]._refCards[1]) and arg_156_0._owner._opponent:hasBattleCardsBySkillFast("S", 8079) then
		return false
	end

	if (arg_156_0._status == BattleData.CardStatus.board or arg_156_0._status == BattleData.CardStatus.grave or arg_156_1 == Data.SkillMode.bcs2gl or arg_156_1 == Data.SkillMode.bcs2_ or arg_156_1 == Data.SkillMode.sacrifice) and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldTrap, true) and arg_156_1 ~= Data.SkillMode.cost and arg_156_0:isNature(Data._skillInfo[8120]._refCards[1]) and arg_156_0._owner:hasBattleCardsBySkillFast("S", 8120) then
		return false
	end

	if (arg_156_0._status == BattleData.CardStatus.board or arg_156_0._status == BattleData.CardStatus.grave or arg_156_1 == Data.SkillMode.bcs2gl or arg_156_1 == Data.SkillMode.bcs2_ or arg_156_1 == Data.SkillMode.sacrifice) and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldTrap) and arg_156_1 ~= Data.SkillMode.cost and arg_156_0:isNature(Data._skillInfo[8120]._refCards[1]) and arg_156_0._owner._opponent:hasBattleCardsBySkillFast("S", 8120) then
		return false
	end

	if arg_156_0._owner._mark6599 ~= nil and arg_156_0._owner._mark6599 ~= arg_156_0 and arg_156_0._status == BattleData.CardStatus.board then
		return false
	end

	if arg_156_0._owner._mark9105 and not arg_156_0:isKeyword(Data._skillInfo[9105]._refCards[2]) then
		return false
	end

	if arg_156_0._owner._mark9598 and arg_156_0._status == BattleData.CardStatus.board and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMonster) and (arg_156_1 ~= Data.SkillMode.cost or arg_156_2 == 9003) and arg_156_0:getStarOrLevel() > arg_156_0._owner._mark9598 then
		return false
	end

	if arg_156_0._owner._mark9600 and arg_156_0._info._category ~= arg_156_0._owner._mark9600 then
		return false
	end

	if arg_156_0._owner._mark13445 and not arg_156_0:isNature(arg_156_0._owner._mark13445) then
		return false
	end

	if arg_156_1 ~= Data.SkillMode.halo and arg_156_1 ~= Data.SkillMode.cost and arg_156_0._status == BattleData.CardStatus.board and not arg_156_0:hasBuff(true, BattleData.PositiveType.defendPosture) and not arg_156_0:hasShieldInType(BattleData.PositiveType.shieldMonster) and arg_156_0._owner._opponent:hasBattleCardsBySkillFast("B", 6672) then
		return false
	end

	if arg_156_0._status == BattleData.CardStatus.grave and arg_156_0._owner._opponent:hasBattleCardsBySkillFast("S", 7523) then
		return false
	end

	return true
end

function var_0_0.isProtectedBy6189(arg_157_0)
	return arg_157_0:isMonsterRare() and not arg_157_0:hasSkillFast(6189) and arg_157_0._atk < Data._skillInfo[6189]._val[1] and arg_157_0._owner:hasBattleCardsBySkillFast("B", 6189) and #arg_157_0._owner:getBattleCardsByKeyword("B", Data._skillInfo[6189]._refCards[1]) > 1
end

function var_0_0.disableUnderSkill(arg_158_0, arg_158_1, arg_158_2, arg_158_3, arg_158_4)
	if arg_158_1._ignoreDisable == true then
		return false
	end

	local var_158_0 = arg_158_0._owner:getCardById(arg_158_1._cid)
	local var_158_1 = Data._skillInfo[arg_158_1._sid]

	if var_158_0 ~= nil and var_158_0._owner == arg_158_0._owner and var_158_1 ~= nil and (var_158_1._isIgnoreDefend == 3 or var_158_1._isIgnoreDefend == 4 or var_158_1._isIgnoreDefend == 6 or var_158_1._isIgnoreDefend == 8) then
		return false
	end

	table.insert(arg_158_0._underSkills, {
		_cid = arg_158_2,
		_sid = arg_158_3,
		_mode = arg_158_4,
		_toggle = arg_158_1
	})

	arg_158_1._disabled = true

	if arg_158_1._trigger ~= nil then
		arg_158_1._trigger._disabled = true

		if arg_158_1._trigger._trigger ~= nil then
			arg_158_1._trigger._trigger._disabled = true
		end
	end

	if arg_158_1._toggle ~= nil then
		arg_158_1._toggle._disabled = false

		if arg_158_1._toggle._trigger ~= nil then
			arg_158_1._toggle._trigger._disabled = false
		end
	end

	if arg_158_1._bind ~= nil and (arg_158_1._bind._type == Data.CardType.magic or arg_158_1._bind._type == Data.CardType.trap) then
		arg_158_0._owner:setCardStatus(arg_158_1._bind, BattleData.CardStatus.grave, arg_158_2, arg_158_3, arg_158_4)
	end

	return true
end

function var_0_0.disableUnderSkillByIds(arg_159_0, arg_159_1, arg_159_2, arg_159_3, arg_159_4, arg_159_5)
	local var_159_0 = false

	for iter_159_0 = 1, #arg_159_0._underSkills do
		local var_159_1 = arg_159_0._underSkills[iter_159_0]

		if var_159_1._disabled ~= true then
			for iter_159_1 = 1, #arg_159_1 do
				if var_159_1._sid == arg_159_1[iter_159_1] and (arg_159_2 == nil or arg_159_2 == var_159_1._mode) then
					if arg_159_0:disableUnderSkill(var_159_1, arg_159_3, arg_159_4, arg_159_5) then
						var_159_0 = true
					end

					break
				end
			end
		end
	end

	return var_159_0
end

function var_0_0.disableUnderSkillByType(arg_160_0, arg_160_1, arg_160_2, arg_160_3, arg_160_4)
	local var_160_0 = false

	for iter_160_0 = 1, #arg_160_0._underSkills do
		local var_160_1 = arg_160_0._underSkills[iter_160_0]

		if var_160_1._disabled ~= true and math.floor(var_160_1._sid / Data.INFO_ID_GROUP_SIZE) == arg_160_1 and var_160_1._mode ~= Data.SkillMode.halo and var_160_1._mode ~= Data.SkillMode.under_attack and var_160_1._mode ~= Data.SkillMode.under_attack_damage and var_160_1._mode ~= Data.SkillMode.under_spell_damage and arg_160_0:disableUnderSkill(var_160_1, arg_160_2, arg_160_3, arg_160_4) then
			var_160_0 = true
		end
	end

	if (arg_160_1 == Data.SkillType.trapSpell or arg_160_1 == Data.SkillType.trapHalo) and arg_160_0._mark5249 then
		arg_160_0._mark5249 = nil
		var_160_0 = true
	end

	return var_160_0
end

function var_0_0.disableUnderSkillByOppoType(arg_161_0, arg_161_1, arg_161_2, arg_161_3, arg_161_4)
	local var_161_0 = false

	for iter_161_0 = 1, #arg_161_0._underSkills do
		local var_161_1 = arg_161_0._underSkills[iter_161_0]
		local var_161_2 = arg_161_0._owner:getCardById(var_161_1._cid)
		local var_161_3 = Data._skillInfo[var_161_1._sid]

		if var_161_1._disabled ~= true and math.floor(var_161_1._sid / Data.INFO_ID_GROUP_SIZE) == arg_161_1 and arg_161_0._owner ~= var_161_2._owner and (var_161_3 == nil or var_161_3._isIgnoreDefend ~= 7 and var_161_3._isIgnoreDefend ~= 8 and var_161_3._isIgnoreDefend ~= 10 and var_161_3._isIgnoreDefend ~= 11) and var_161_1._mode ~= Data.SkillMode.halo and var_161_1._mode ~= Data.SkillMode.under_attack and var_161_1._mode ~= Data.SkillMode.under_attack_damage and var_161_1._mode ~= Data.SkillMode.under_spell_damage and arg_161_0:disableUnderSkill(var_161_1, arg_161_2, arg_161_3, arg_161_4) then
			var_161_0 = true
		end
	end

	if (arg_161_1 == Data.SkillType.trapSpell or arg_161_1 == Data.SkillType.trapHalo) and arg_161_0._mark5249 then
		arg_161_0._mark5249 = nil
		var_161_0 = true
	end

	return var_161_0
end

function var_0_0.disableUnderSkillByOppoTypeAndCheckShield(arg_162_0, arg_162_1, arg_162_2, arg_162_3, arg_162_4, arg_162_5)
	local var_162_0 = false
	local var_162_1

	for iter_162_0 = 1, #arg_162_0._underSkills do
		local var_162_2 = arg_162_0._underSkills[iter_162_0]
		local var_162_3 = arg_162_0._owner:getCardById(var_162_2._cid)
		local var_162_4 = Data._skillInfo[var_162_2._sid]

		if var_162_2._disabled ~= true and math.floor(var_162_2._sid / Data.INFO_ID_GROUP_SIZE) == arg_162_1 and arg_162_0._owner ~= var_162_3._owner and not var_162_3:hasShieldInType(arg_162_5) and (var_162_4 == nil or var_162_4._isIgnoreDefend ~= 7 and var_162_4._isIgnoreDefend ~= 8 and var_162_4._isIgnoreDefend ~= 10 and var_162_4._isIgnoreDefend ~= 11) and var_162_2._mode ~= Data.SkillMode.halo and var_162_2._mode ~= Data.SkillMode.under_attack and var_162_2._mode ~= Data.SkillMode.under_attack_damage and var_162_2._mode ~= Data.SkillMode.under_spell_damage and arg_162_0:disableUnderSkill(var_162_2, arg_162_2, arg_162_3, arg_162_4) then
			var_162_0 = true
			var_162_1 = var_162_3
		end
	end

	return var_162_0, var_162_1
end

function var_0_0.disableUnderSkillByOppo(arg_163_0, arg_163_1, arg_163_2, arg_163_3)
	local var_163_0 = false

	for iter_163_0 = 1, #arg_163_0._underSkills do
		local var_163_1 = arg_163_0._underSkills[iter_163_0]
		local var_163_2 = arg_163_0._owner:getCardById(var_163_1._cid)

		if var_163_1._disabled ~= true and arg_163_0._owner ~= var_163_2._owner and var_163_1._mode ~= Data.SkillMode.halo and arg_163_0:disableUnderSkill(var_163_1, arg_163_1, arg_163_2, arg_163_3) then
			var_163_0 = true
		end
	end

	return var_163_0
end

function var_0_0.disableUnderSkillByOppoAndCheckShield(arg_164_0, arg_164_1, arg_164_2, arg_164_3, arg_164_4)
	local var_164_0 = false
	local var_164_1

	for iter_164_0 = 1, #arg_164_0._underSkills do
		local var_164_2 = arg_164_0._underSkills[iter_164_0]
		local var_164_3 = arg_164_0._owner:getCardById(var_164_2._cid)

		if not var_164_3:hasShieldInType(arg_164_4) and var_164_2._disabled ~= true and arg_164_0._owner ~= var_164_3._owner and var_164_2._mode ~= Data.SkillMode.halo and arg_164_0:disableUnderSkill(var_164_2, arg_164_1, arg_164_2, arg_164_3) then
			var_164_0 = true
			var_164_1 = var_164_3
		end
	end

	return var_164_0, var_164_1
end

function var_0_0.disableUnderSkillByOppoTriggerCard(arg_165_0, arg_165_1, arg_165_2, arg_165_3, arg_165_4)
	local var_165_0 = false

	for iter_165_0 = 1, #arg_165_0._underSkills do
		local var_165_1 = arg_165_0._underSkills[iter_165_0]

		if var_165_1._disabled ~= true and var_165_1._cid == arg_165_1._id and arg_165_0._owner ~= arg_165_1._owner and var_165_1._mode ~= Data.SkillMode.halo and arg_165_0:disableUnderSkill(var_165_1, arg_165_2, arg_165_3, arg_165_4) then
			var_165_0 = true
		end
	end

	for iter_165_1 = 1, #arg_165_0._underSkills do
		local var_165_2 = arg_165_0._underSkills[iter_165_1]

		if var_165_2._disabled ~= true and var_165_2._sid == 6651 and var_165_2._status == BattleData.CardStatus.grave then
			local var_165_3 = arg_165_0._owner:getCardById(var_165_2._cid)

			if arg_165_0._owner ~= var_165_3._owner and arg_165_0:disableUnderSkill(var_165_2, arg_165_2, arg_165_3, arg_165_4) then
				var_165_0 = true
			end
		end
	end

	for iter_165_2 = 1, #arg_165_0._underSkills do
		local var_165_4 = arg_165_0._underSkills[iter_165_2]

		if var_165_4._disabled ~= true and var_165_4._sid == 2042 and var_165_4._status == BattleData.CardStatus.hand then
			local var_165_5 = arg_165_0._owner:getCardById(var_165_4._cid)

			if arg_165_0._owner ~= var_165_5._owner and arg_165_0:disableUnderSkill(var_165_4, arg_165_2, arg_165_3, arg_165_4) then
				var_165_0 = true
			end
		end
	end

	return var_165_0
end

function var_0_0.disableUnderSkillBySkillId(arg_166_0, arg_166_1, arg_166_2, arg_166_3)
	for iter_166_0 = 1, #arg_166_0._underSkills do
		local var_166_0 = arg_166_0._underSkills[iter_166_0]

		if var_166_0._disabled ~= true and var_166_0._mode ~= Data.SkillMode.halo then
			local var_166_1 = arg_166_0._owner:getCardById(var_166_0._cid)

			if var_166_1 ~= nil and arg_166_2 == 2063 and arg_166_0._owner ~= var_166_1._owner and var_166_1:isMonsterRare() and not var_166_1:isCeremonyMonster() and arg_166_0:disableUnderSkill(var_166_0, arg_166_1, arg_166_2, arg_166_3) then
				disabled = true
			end
		end
	end

	return disabled
end

function var_0_0.disableUnderSkillByDestroy(arg_167_0, arg_167_1, arg_167_2, arg_167_3, arg_167_4, arg_167_5, arg_167_6)
	local var_167_0 = false
	local var_167_1

	for iter_167_0 = 1, #arg_167_0._underSkills do
		local var_167_2 = arg_167_0._underSkills[iter_167_0]
		local var_167_3 = true

		if var_167_2._sid and Data._skillInfo[var_167_2._sid] and (Data._skillInfo[var_167_2._sid]._isIgnoreDefend == 2 or Data._skillInfo[var_167_2._sid]._isIgnoreDefend == 9 or Data._skillInfo[var_167_2._sid]._isIgnoreDefend == 10) then
			var_167_3 = false
		end

		if var_167_3 and (var_167_2._sid == 5030 or var_167_2._sid == 5219) then
			var_167_3 = false
		end

		if var_167_3 and arg_167_2 == 7488 and var_167_2._cid == arg_167_0._id then
			var_167_3 = false
		end

		if var_167_3 and arg_167_4 then
			var_167_1 = arg_167_0._owner:getCardById(var_167_2._cid)

			if var_167_1 ~= nil and var_167_1._owner == arg_167_0._owner and var_167_1._infoId ~= 20644 then
				var_167_3 = false
			end

			if arg_167_5 and var_167_1 ~= nil and var_167_1:isMonsterRare() and not arg_167_0:isSameNatureWith(var_167_1) then
				var_167_3 = false
			end
		end

		if var_167_3 and arg_167_6 then
			var_167_1 = var_167_1 or arg_167_0._owner:getCardById(var_167_2._cid)

			if var_167_1:hasShieldInType(arg_167_6) then
				var_167_3 = false
			end
		end

		if var_167_3 and var_167_2._disabled ~= true and var_167_2._status ~= nil and ((var_167_2._status == BattleData.CardStatus.grave or var_167_2._status == BattleData.CardStatus.leave) and var_167_2._statusVal ~= BattleData.CardStatusVal.b2g_sacrifice and var_167_2._statusVal ~= BattleData.CardStatusVal.b2g_oppo_sacrifice and var_167_2._statusVal ~= BattleData.CardStatusVal.b2g_sync_sacrifice and var_167_2._statusVal ~= BattleData.CardStatusVal.b2g_link_sacrifice and var_167_2._statusVal ~= BattleData.CardStatusVal.b2g_summon_sacrifice and var_167_2._statusVal ~= BattleData.CardStatusVal.x2gl_cost and var_167_2._statusVal ~= BattleData.CardStatusVal.x2gl_oppo_cost and var_167_2._statusVal ~= BattleData.CardStatusVal.h2l_temp and var_167_2._statusVal ~= BattleData.CardStatusVal.x2l_temp_oppo or var_167_2._statusVal == BattleData.CardStatusVal.b2g_kill_by_attack) and arg_167_0:disableUnderSkill(var_167_2, arg_167_1, arg_167_2, arg_167_3) then
			var_167_0 = true
			var_167_1 = arg_167_0._owner:getCardById(var_167_2._cid)
		end
	end

	return var_167_0, var_167_1
end

function var_0_0.disableUnderSkillByLeftBoard(arg_168_0, arg_168_1, arg_168_2, arg_168_3)
	local var_168_0 = false

	for iter_168_0 = 1, #arg_168_0._underSkills do
		local var_168_1 = arg_168_0._underSkills[iter_168_0]

		if var_168_1._disabled ~= true and var_168_1._status ~= nil and (var_168_1._status ~= BattleData.CardStatus.board and var_168_1._statusVal ~= BattleData.CardStatusVal.b2g_sacrifice and var_168_1._statusVal ~= BattleData.CardStatusVal.b2g_oppo_sacrifice and var_168_1._statusVal ~= BattleData.CardStatusVal.b2g_sync_sacrifice and var_168_1._statusVal ~= BattleData.CardStatusVal.b2g_link_sacrifice and var_168_1._statusVal ~= BattleData.CardStatusVal.b2g_summon_sacrifice and var_168_1._statusVal ~= BattleData.CardStatusVal.x2gl_cost and var_168_1._statusVal ~= BattleData.CardStatusVal.x2gl_oppo_cost or var_168_1._statusVal == BattleData.CardStatusVal.b2g_kill_by_attack) and arg_168_0:disableUnderSkill(var_168_1, arg_168_1, arg_168_2, arg_168_3) then
			var_168_0 = true
		end
	end

	return var_168_0
end

function var_0_0.disableUnderSkillByLeftBoardEx(arg_169_0, arg_169_1, arg_169_2, arg_169_3)
	local var_169_0 = false

	for iter_169_0 = 1, #arg_169_0._underSkills do
		local var_169_1 = arg_169_0._underSkills[iter_169_0]

		if var_169_1._disabled ~= true and var_169_1._status ~= nil and var_169_1._status ~= BattleData.CardStatus.board and arg_169_0:disableUnderSkill(var_169_1, arg_169_1, arg_169_2, arg_169_3) then
			var_169_0 = true
		end
	end

	return var_169_0
end

function var_0_0.disableUnderSkillByToOppo(arg_170_0, arg_170_1, arg_170_2, arg_170_3)
	local var_170_0 = false

	for iter_170_0 = 1, #arg_170_0._underSkills do
		local var_170_1 = arg_170_0._underSkills[iter_170_0]

		if var_170_1._disabled ~= true and var_170_1._status ~= nil and (var_170_1._statusVal == BattleData.CardStatusVal.b2b_oppo_once or var_170_1._statusVal == BattleData.CardStatusVal.b2b_oppo_once_attack_frozen or var_170_1._statusVal == BattleData.CardStatusVal.b2b_oppo_forever or var_170_1._statusVal == BattleData.CardStatusVal.b2b_oppo_forever_attack_frozen or var_170_1._statusVal == BattleData.CardStatusVal.b2b_oppo_forever_using) and arg_170_0:disableUnderSkill(var_170_1, arg_170_1, arg_170_2, arg_170_3) then
			var_170_0 = true
		end
	end

	return var_170_0
end

function var_0_0.removeUnderSkillByRemoveMode(arg_171_0, arg_171_1)
	local var_171_0 = 1

	while true do
		local var_171_1 = arg_171_0._underSkills[var_171_0]

		if var_171_1 == nil then
			break
		end

		if var_171_1._sid ~= 0 and var_171_1._mode ~= Data.SkillMode.halo and B.skillInfoHasRemoveMode(Data._skillInfo[var_171_1._sid], arg_171_1) and (var_171_1._sid ~= 3599 or var_171_1._positiveType ~= BattleData.PositiveType.magicMark) and (var_171_1._sid ~= 5460 or not arg_171_0:isInfoId(Data._skillInfo[var_171_1._sid]._refCards[3])) and (var_171_1._sid ~= 5467 or not arg_171_0:isInfoId(Data._skillInfo[var_171_1._sid]._refCards[2])) and (var_171_1._sid ~= 6698 or var_171_1._positiveType == BattleData.PositiveType.extraSkill) and (var_171_1._sid ~= 2588 or var_171_1._atkInc == nil or arg_171_1 ~= (arg_171_0._owner:getCardById(var_171_1._cid)._owner == arg_171_0._owner and 42 or 44)) and (var_171_1._sid ~= 13180 or var_171_1._positiveType ~= BattleData.PositiveType.sixFlowerMark) and (var_171_1._sid ~= 13249 or var_171_1._positiveType ~= BattleData.PositiveType.extraSkill) and (var_171_1._sid ~= 1159 or var_171_1._value ~= 79511 and (var_171_1._follower == nil or var_171_1._follower._value ~= 79511)) then
			table.remove(arg_171_0._underSkills, var_171_0)
		else
			var_171_0 = var_171_0 + 1
		end
	end
end

function var_0_0.removeUnderSkillByExtraSkill(arg_172_0)
	local var_172_0 = 1

	while true do
		local var_172_1 = arg_172_0._underSkills[var_172_0]

		if var_172_1 == nil then
			break
		end

		if var_172_1._incPositive and var_172_1._incPositive[1] == BattleData.PositiveType.extraSkill or var_172_1._positiveType == BattleData.PositiveType.extraSkill then
			table.remove(arg_172_0._underSkills, var_172_0)
		else
			var_172_0 = var_172_0 + 1
		end
	end
end

function var_0_0.removeUnderSkillByStatus(arg_173_0, arg_173_1)
	local var_173_0 = 1

	while true do
		local var_173_1 = arg_173_0._underSkills[var_173_0]

		if var_173_1 == nil then
			break
		end

		if var_173_1._status == arg_173_1 then
			table.remove(arg_173_0._underSkills, var_173_0)
		else
			var_173_0 = var_173_0 + 1
		end
	end
end

function var_0_0.removeUnderSkillByBeforeAttack(arg_174_0, arg_174_1)
	local var_174_0 = 1

	while true do
		local var_174_1 = arg_174_0._underSkills[var_174_0]

		if var_174_1 == nil then
			break
		elseif var_174_1._mode == Data.SkillMode.before_attack and var_174_1._sid ~= 1145 and var_174_1._sid ~= 1148 and var_174_1._sid ~= 2089 and var_174_1._sid ~= 2121 and var_174_1._sid ~= 2427 and var_174_1._sid ~= 2679 and var_174_1._sid ~= 2740 and var_174_1._sid ~= 5520 and var_174_1._sid ~= 5524 and var_174_1._sid ~= 9346 and var_174_1._sid ~= 9385 and var_174_1._sid ~= 13225 and var_174_1._sid ~= 13227 and var_174_1._sid ~= 13583 then
			table.remove(arg_174_0._underSkills, var_174_0)

			arg_174_1._needAccount = true
		else
			var_174_0 = var_174_0 + 1
		end
	end
end

function var_0_0.removeUnderSkillByDamage(arg_175_0)
	local var_175_0 = 1

	while true do
		local var_175_1 = arg_175_0._underSkills[var_175_0]

		if var_175_1 == nil then
			break
		elseif var_175_1._damage ~= nil then
			table.remove(arg_175_0._underSkills, var_175_0)
		else
			var_175_0 = var_175_0 + 1
		end
	end
end

function var_0_0.underSkillHasMode(arg_176_0, arg_176_1)
	for iter_176_0 = 1, #arg_176_0._underSkills do
		local var_176_0 = arg_176_0._underSkills[iter_176_0]

		if var_176_0._mode == arg_176_1 and (var_176_0._mode ~= Data.SkillMode.before_attack or var_176_0._sid ~= 1145 and var_176_0._sid ~= 1148 and var_176_0._sid ~= 2089 and var_176_0._sid ~= 2121 and var_176_0._sid ~= 2427 and var_176_0._sid ~= 2679 and var_176_0._sid ~= 2740 and var_176_0._sid ~= 5520 and var_176_0._sid ~= 5524 and var_176_0._sid ~= 9346 and var_176_0._sid ~= 9385 and var_176_0._sid ~= 13225 and var_176_0._sid ~= 13227 and var_176_0._sid ~= 13583) then
			return true
		end
	end

	return false
end

function var_0_0.underSkillHasType(arg_177_0, arg_177_1)
	for iter_177_0 = 1, #arg_177_0._underSkills do
		local var_177_0 = arg_177_0._underSkills[iter_177_0]

		if math.floor(var_177_0._sid / Data.INFO_ID_GROUP_SIZE) == arg_177_1 then
			return true
		end
	end

	return false
end

function var_0_0.isUnderSkillHaloedBySelfExtraSkill(arg_178_0, arg_178_1)
	if arg_178_1._cid ~= arg_178_0._id or arg_178_1._mode ~= Data.SkillMode.halo then
		return false
	end

	for iter_178_0 = 1, #arg_178_0._skills do
		local var_178_0 = arg_178_0._skills[iter_178_0]

		if arg_178_1._sid == var_178_0._id and (var_178_0._provider == nil or var_178_0._provider == BattleData.SkillProvider.horse or var_178_0._provider == BattleData.SkillProvider.copy or var_178_0._saved and (var_178_0._saved._provider == nil or var_178_0._saved._provider == BattleData.SkillProvider.horse or var_178_0._saved._provider == BattleData.SkillProvider.copy)) then
			return false
		end
	end

	return true
end

function var_0_0.advanceLastUnderSkill(arg_179_0, arg_179_1)
	local var_179_0 = arg_179_0._underSkills[#arg_179_0._underSkills]

	if var_179_0 ~= nil then
		var_179_0._advance = arg_179_1
	end
end

function var_0_0.hasAdvanceUnderSkill(arg_180_0)
	for iter_180_0 = 1, #arg_180_0._underSkills do
		if arg_180_0._underSkills[iter_180_0]._advance ~= nil then
			return true
		end
	end

	return false
end

function var_0_0.getActionCardMagicTarget(arg_181_0)
	local var_181_0

	if arg_181_0:hasSkills({
		4129,
		4142,
		4364,
		4475
	}) then
		local var_181_1 = arg_181_0._choice and math.floor(arg_181_0._choice / BattleData.ChoiceId.stage_2) % BattleData.ChoiceId.stage_size_2 or 0

		var_181_0 = arg_181_0._owner:getCardById(var_181_1)
	elseif arg_181_0:hasSkills({
		4169,
		4205
	}) then
		local var_181_2 = arg_181_0._choice and math.floor(arg_181_0._choice / BattleData.ChoiceId.stage_2) % BattleData.ChoiceId.stage_size_2 or 0

		var_181_0 = arg_181_0._owner:getCardById(var_181_2 % BattleData.UseCardId.id_group)
	elseif arg_181_0:hasSkills({
		7057
	}) then
		var_181_0 = B.getMaxAtkCard(arg_181_0._owner._opponent:getBoardCards())
	elseif arg_181_0:hasSkills({
		7090
	}) then
		return arg_181_0._target2020
	elseif arg_181_0:hasSkills({
		7186
	}) then
		return arg_181_0._target2041
	else
		var_181_0 = arg_181_0._magicTarget
	end

	return var_181_0
end

function var_0_0.getActionCardTrapTarget(arg_182_0)
	if arg_182_0:hasSkills({
		5049,
		5156,
		5193,
		5200,
		8056
	}) then
		local var_182_0 = (arg_182_0._choice and math.floor(arg_182_0._choice / BattleData.ChoiceId.stage_2) % BattleData.ChoiceId.stage_size_2 or 0) % BattleData.UseCardId.id_group

		return arg_182_0._owner:getCardById(var_182_0)
	elseif arg_182_0:hasSkills({
		5058
	}) then
		return arg_182_0._trapTarget and arg_182_0._trapTarget._triggerCard
	end

	return arg_182_0:hasSkills({
		5050,
		5094,
		5097,
		5158,
		5469
	}) and arg_182_0._trapTarget2 or arg_182_0._trapTarget
end

function var_0_0.addBind(arg_183_0, arg_183_1)
	for iter_183_0 = 1, #arg_183_0._binds do
		if arg_183_0._binds[iter_183_0] == arg_183_1 then
			return
		end
	end

	arg_183_0._binds[#arg_183_0._binds + 1] = arg_183_1
end

function var_0_0.removeBind(arg_184_0, arg_184_1)
	for iter_184_0 = 1, #arg_184_0._binds do
		if arg_184_0._binds[iter_184_0] == arg_184_1 then
			table.remove(arg_184_0._binds, iter_184_0)

			break
		end
	end
end

function var_0_0.removeBinds(arg_185_0)
	arg_185_0._binds = {}
end

function var_0_0.isBinded(arg_186_0, arg_186_1)
	for iter_186_0 = 1, #arg_186_0._binds do
		if arg_186_0._binds[iter_186_0]:isInfoId(arg_186_1) then
			return true
		end
	end

	return false
end

function var_0_0.isBindedInfoIdGroup(arg_187_0, arg_187_1)
	for iter_187_0 = 1, #arg_187_1 do
		if arg_187_0:isBinded(arg_187_1[iter_187_0]) then
			return true
		end
	end

	return false
end

function var_0_0.isBindedAllInfoIdGroup(arg_188_0, arg_188_1)
	for iter_188_0 = 1, #arg_188_1 do
		if not arg_188_0:isBinded(arg_188_1[iter_188_0]) then
			return false
		end
	end

	return true
end

function var_0_0.isBindedSameNameCard(arg_189_0, arg_189_1)
	for iter_189_0 = 1, #arg_189_0._binds do
		if arg_189_0._binds[iter_189_0]:isSameNameWith(arg_189_1) then
			return true
		end
	end

	return false
end

function var_0_0.isBindedSkill(arg_190_0, arg_190_1)
	for iter_190_0 = 1, #arg_190_0._binds do
		if arg_190_0._binds[iter_190_0]:hasSkills({
			arg_190_1
		}) then
			return true, arg_190_0._binds[iter_190_0]
		end
	end

	return false
end

function var_0_0.isBindedAllyEquip(arg_191_0)
	for iter_191_0 = 1, #arg_191_0._binds do
		if arg_191_0._binds[iter_191_0]:isAllyEquip() then
			return true
		end
	end

	return false
end

function var_0_0.isBindedKeywordEquip(arg_192_0, arg_192_1)
	for iter_192_0 = 1, #arg_192_0._binds do
		if arg_192_0._binds[iter_192_0]:isKeyword(arg_192_1) then
			return true
		end
	end

	return false
end

function var_0_0.getBindedEquipsByKeyword(arg_193_0, arg_193_1)
	local var_193_0 = {}

	for iter_193_0 = 1, #arg_193_0._binds do
		if arg_193_0._binds[iter_193_0]:isKeyword(arg_193_1) then
			var_193_0[#var_193_0 + 1] = arg_193_0._binds[iter_193_0]
		end
	end

	return var_193_0
end

function var_0_0.getBindedEquipsByType(arg_194_0, arg_194_1)
	local var_194_0 = {}

	for iter_194_0 = 1, #arg_194_0._binds do
		if arg_194_0._binds[iter_194_0]._type == arg_194_1 then
			var_194_0[#var_194_0 + 1] = arg_194_0._binds[iter_194_0]
		end
	end

	return var_194_0
end

function var_0_0.canMergeTo(arg_195_0, arg_195_1)
	if arg_195_0._info._joinResult ~= nil and arg_195_0._info._joinResult[1] ~= 0 then
		if not arg_195_1 then
			return true
		end

		for iter_195_0 = 1, #arg_195_0._info._joinResult do
			arg_195_1[arg_195_0._info._joinResult[iter_195_0]] = true
		end
	end

	local var_195_0 = arg_195_0:getExtraInfoIds()

	for iter_195_1 = 1, #var_195_0 do
		local var_195_1 = Data._monsterInfo[var_195_0[iter_195_1]]

		if var_195_1 and var_195_1._joinResult and var_195_1._joinResult[1] ~= 0 then
			if not arg_195_1 then
				return true
			end

			for iter_195_2 = 1, #var_195_1._joinResult do
				arg_195_1[var_195_1._joinResult[iter_195_2]] = true
			end
		end
	end

	if not arg_195_1 then
		return false
	end

	return next(arg_195_1) ~= nil
end

function var_0_0.canMergeFrom(arg_196_0)
	return arg_196_0:isMerge()
end

function var_0_0.canMergeFromSuperId(arg_197_0)
	return arg_197_0:canMergeFrom() and Data.canMergeFromSuperId(arg_197_0._info)
end

function var_0_0.canMergeFromInfoId(arg_198_0)
	return arg_198_0:canMergeFrom() and Data.canMergeFromInfoId(arg_198_0._info)
end

function var_0_0.hasJoinComponent(arg_199_0, arg_199_1)
	if arg_199_0._info._joinComponent == nil then
		return false
	end

	for iter_199_0 = 1, #arg_199_0._info._joinComponent do
		if arg_199_0._info._joinComponent[iter_199_0] == arg_199_1 then
			return true
		end
	end

	return false
end

function var_0_0.isBoardCard(arg_200_0)
	return arg_200_0._type ~= Data.CardType.fortress and (arg_200_0._type ~= Data.CardType.boss or arg_200_0._info._isDeamon == 1)
end

function var_0_0.isAlive(arg_201_0)
	if arg_201_0:isMonsterRare() or arg_201_0._type == Data.CardType.boss and arg_201_0._info._isDeamon == 1 then
		return arg_201_0._status == BattleData.CardStatus.board
	elseif arg_201_0._type == Data.CardType.fortress or arg_201_0._type == Data.CardType.boss then
		return arg_201_0._hp > 0
	elseif arg_201_0._type == Data.CardType.magic then
		return arg_201_0._status == BattleData.CardStatus.show or arg_201_0._status == BattleData.CardStatus.field or arg_201_0._statusVal == BattleData.CardStatusVal.h2g_magic
	elseif arg_201_0._type == Data.CardType.trap then
		return arg_201_0._status == BattleData.CardStatus.cover or arg_201_0._status == BattleData.CardStatus.show or arg_201_0._statusVal == BattleData.CardStatusVal.h2g_trap
	end

	return false
end

function var_0_0.hasChangeStatusUnderSkill(arg_202_0, arg_202_1)
	for iter_202_0 = 1, #arg_202_0._underSkills do
		local var_202_0 = arg_202_0._underSkills[iter_202_0]

		for iter_202_1 = 1, #arg_202_1 do
			if not var_202_0._disabled and var_202_0._status == arg_202_1[iter_202_1] then
				return true
			end
		end
	end

	return false
end

function var_0_0.isDying(arg_203_0)
	return arg_203_0:isChangingToStatus({
		BattleData.CardStatus.grave,
		BattleData.CardStatus.leave
	})
end

function var_0_0.isLeaving(arg_204_0)
	return arg_204_0:isChangingToStatus({
		BattleData.CardStatus.leave
	})
end

function var_0_0.isUsing(arg_205_0)
	return arg_205_0:isChangingToStatus({
		BattleData.CardStatus.board
	})
end

function var_0_0.isHanding(arg_206_0)
	return arg_206_0:isChangingToStatus({
		BattleData.CardStatus.hand,
		BattleData.CardStatus.rare
	})
end

function var_0_0.isToOppoBoard(arg_207_0)
	return arg_207_0:isChangingWithStatusVal({
		BattleData.CardStatusVal.b2b_oppo_once,
		BattleData.CardStatusVal.b2b_oppo_once_attack_frozen,
		BattleData.CardStatusVal.b2b_oppo_forever,
		BattleData.CardStatusVal.b2b_oppo_forever_attack_frozen,
		BattleData.CardStatusVal.b2b_oppo_forever_using
	})
end

function var_0_0.isChangingToStatus(arg_208_0, arg_208_1)
	if arg_208_0._owner == nil then
		return false
	end

	local var_208_0 = arg_208_0._owner:getActionPlayer()

	while true do
		if var_208_0 == nil then
			break
		end

		local var_208_1 = var_208_0._cardStatusToChange

		if var_208_1 == nil then
			break
		end

		for iter_208_0 = 1, #var_208_1 do
			local var_208_2 = var_208_1[iter_208_0]

			for iter_208_1 = 1, #arg_208_1 do
				if var_208_2._card == arg_208_0 and var_208_2._destStatus == arg_208_1[iter_208_1] then
					return true
				end
			end
		end

		var_208_0 = var_208_0._saved
	end

	return false
end

function var_0_0.isChangingFromTo(arg_209_0, arg_209_1, arg_209_2)
	local var_209_0 = arg_209_0._owner:getActionPlayer()

	while true do
		if var_209_0 == nil then
			break
		end

		local var_209_1 = var_209_0._cardStatusToChange

		if var_209_1 == nil then
			break
		end

		for iter_209_0 = 1, #var_209_1 do
			local var_209_2 = var_209_1[iter_209_0]

			if var_209_2._card == arg_209_0 and var_209_2._sourceStatus == arg_209_1 and var_209_2._destStatus == arg_209_2 then
				return true
			end
		end

		var_209_0 = var_209_0._saved
	end

	return false
end

function var_0_0.isChangingWithStatusVal(arg_210_0, arg_210_1)
	local var_210_0 = arg_210_0._owner:getActionPlayer()

	while true do
		if var_210_0 == nil then
			break
		end

		local var_210_1 = var_210_0._cardStatusToChange

		if var_210_1 == nil then
			break
		end

		for iter_210_0 = 1, #var_210_1 do
			local var_210_2 = var_210_1[iter_210_0]

			for iter_210_1 = 1, #arg_210_1 do
				if var_210_2._card == arg_210_0 and var_210_2._statusVal == arg_210_1[iter_210_1] then
					return true
				end
			end
		end

		var_210_0 = var_210_0._saved
	end

	return false
end

function var_0_0.getNeighbors(arg_211_0, arg_211_1)
	local var_211_0 = {}

	if arg_211_0._type == Data.CardType.boss and arg_211_0._info._isDeamon == 0 then
		if not arg_211_1 then
			table.insert(var_211_0, arg_211_0)
		end

		return var_211_0
	end

	local var_211_1 = arg_211_0._status == BattleData.CardStatus.board and arg_211_0._pos or arg_211_0._prevBoardPos
	local var_211_2 = {
		var_211_1 - 1,
		var_211_1,
		var_211_1 + 1
	}

	if arg_211_0._owner._isDeamon then
		var_211_2[1] = var_0_0.LEFT_POS_DEAMON[var_211_1]
		var_211_2[3] = var_0_0.RIGHT_POS_DEAMON[var_211_1]
	end

	for iter_211_0 = 1, #var_211_2, arg_211_1 and 2 or 1 do
		local var_211_3 = arg_211_0._owner._boardCards[var_211_2[iter_211_0]]

		if B.isAlive(var_211_3) then
			table.insert(var_211_0, var_211_3)
		end
	end

	return var_211_0
end

function var_0_0.getLeftNeighbor(arg_212_0)
	if arg_212_0._type == Data.CardType.boss and arg_212_0._info._isDeamon == 0 then
		return nil
	end

	local var_212_0 = arg_212_0._status == BattleData.CardStatus.board and arg_212_0._pos or arg_212_0._prevBoardPos
	local var_212_1 = arg_212_0._owner._isDeamon and var_0_0.LEFT_POS_DEAMON[var_212_0] or var_212_0 - 1
	local var_212_2 = arg_212_0._owner._boardCards[var_212_1]

	return B.isAlive(var_212_2) and var_212_2 or nil
end

function var_0_0.canAction(arg_213_0)
	if arg_213_0._mark2517_2 then
		return true
	end

	if arg_213_0._owner._mark9925 and arg_213_0 == arg_213_0._owner._mark9925 and arg_213_0._actionIndex > 1 then
		return false
	end

	if arg_213_0:hasCanCastMonsterSkillFast(1080) then
		local var_213_0 = B.filterDyingCards(arg_213_0._owner._opponent:getBoardCards(), false)

		for iter_213_0 = 1, #var_213_0 do
			if var_213_0[iter_213_0]._mark1080 == nil or not B.tableContain(var_213_0[iter_213_0]._mark1080, arg_213_0._id) then
				return true
			end
		end
	end

	if (arg_213_0:isNewLive1() or arg_213_0:isNewLive2()) and arg_213_0:isLink() and arg_213_0:isBindedSkill(7600) and not arg_213_0:hasSiegeSkill() and #B.filterDyingCards(arg_213_0._owner._opponent:getBoardCards(), false) > 0 and (arg_213_0._mark7600 or 0) < arg_213_0:getLink() then
		return true
	end

	if arg_213_0:hasCanCastMonsterSkillFast(1123) then
		local var_213_1 = B.filterDyingCards(B.filterSummonByNormalCards(arg_213_0._owner._opponent:getBoardCards(), false), false)

		for iter_213_1 = 1, #var_213_1 do
			if var_213_1[iter_213_1]._mark1123 ~= arg_213_0._id then
				return true
			end
		end
	end

	if arg_213_0:hasCanCastMonsterSkillFast(3616) then
		return arg_213_0._actionIndex <= 3
	end

	if arg_213_0:hasCanCastMonsterSkillFast(6578) and arg_213_0._mark6578 and not arg_213_0:hasCanCastMonsterSkillFast(3616) and not arg_213_0:hasCanCastMonsterSkillFast(3191) and #arg_213_0._owner._opponent:getBoardCards() == 0 then
		return false
	end

	if arg_213_0:hasCanCastMonsterSkillFast(9549) and arg_213_0._mark9549 ~= nil then
		return arg_213_0._actionIndex <= arg_213_0._mark9549
	end

	if arg_213_0:hasCanCastMonsterSkillFast(9552) and arg_213_0._mark9552 ~= nil then
		return arg_213_0._actionIndex <= arg_213_0._mark9552
	end

	local var_213_2 = arg_213_0._actionCount
	local var_213_3 = arg_213_0:hasSkills({
		3191,
		6578
	}) and arg_213_0:canCastMonsterSkill()

	if arg_213_0:hasBuff(true, BattleData.PositiveType.actionCraze) or var_213_3 then
		var_213_2 = var_213_2 + 1
	end

	if var_213_3 then
		var_213_2 = math.min(2, var_213_2)
	end

	if arg_213_0:isBindedSkill(7315) then
		return arg_213_0._actionIndex <= #B.filterInKeywordCards(arg_213_0._owner:getBattleCardsByType("G", Data.CardType.monster), Data._skillInfo[7315]._refCards[1])
	end

	if arg_213_0:hasCanCastMonsterSkillFast(2558) then
		return arg_213_0._actionIndex <= math.max(var_213_2, arg_213_0:getBuffValue(true, BattleData.PositiveType.xyzMark))
	end

	if arg_213_0:hasCanCastMonsterSkillFast(9845) and #arg_213_0._owner._opponent:getBoardCards() > 0 then
		return arg_213_0._actionIndex <= math.max(var_213_2, arg_213_0:getBuffValue(true, BattleData.PositiveType.xyzMark) + 1)
	end

	if arg_213_0:hasCanCastMonsterSkillFast(13653) then
		return arg_213_0._actionIndex <= #B.filterSyncCards(arg_213_0._owner:getBattleCardsByKeyword("G", Data._skillInfo[13653]._refCards[1]), true) + 1
	end

	if arg_213_0:hasCanCastMonsterSkillFast(13776) and arg_213_0._mark13776 and arg_213_0._owner._round == arg_213_0._onBoardRound then
		return arg_213_0._actionIndex <= math.max(var_213_2, #arg_213_0._owner._opponent:getBattleCards("SD"))
	end

	return var_213_2 >= arg_213_0._actionIndex
end

function var_0_0.actioned(arg_214_0)
	return arg_214_0._actionIndex > 1
end

function var_0_0.canAttack(arg_215_0, arg_215_1)
	if arg_215_1 and not arg_215_0:canAction() then
		return false
	end

	if arg_215_0:hasCanCastMonsterSkillFast(1080) then
		local var_215_0 = B.filterDyingCards(arg_215_0._owner._opponent:getBoardCards(), false)
		local var_215_1 = false

		for iter_215_0 = 1, #var_215_0 do
			if var_215_0[iter_215_0]._mark1080 == nil or not B.tableContain(var_215_0[iter_215_0]._mark1080, arg_215_0._id) then
				var_215_1 = true
			end
		end

		if not var_215_1 then
			return false
		end
	end

	if arg_215_0:hasCanCastMonsterSkillFast(1123) and arg_215_0._mark1123_2 then
		local var_215_2 = B.filterDyingCards(B.filterSummonByNormalCards(arg_215_0._owner._opponent:getBoardCards(), false), false)
		local var_215_3 = false

		for iter_215_1 = 1, #var_215_2 do
			if var_215_2[iter_215_1]._mark1123 ~= arg_215_0._id then
				var_215_3 = true
			end
		end

		if not var_215_3 then
			return false
		end
	end

	if not arg_215_0._canAttack then
		return false
	end

	if arg_215_0._owner._frozenAttackRounds[arg_215_0._owner._round] then
		return false
	end

	if arg_215_0._owner._mark4274_3 and not arg_215_0:hasSkills({
		1080
	}) then
		return false
	end

	if arg_215_0._owner._mark4282_2 and not arg_215_0._mark4282 then
		return false
	end

	if arg_215_0._owner._mark4321 and arg_215_0 ~= arg_215_0._owner._mark4321 then
		return false
	end

	if arg_215_0._owner._mark4521 and arg_215_0 ~= arg_215_0._owner._mark4521 then
		return false
	end

	if arg_215_0._owner._mark4522 and arg_215_0 ~= arg_215_0._owner._mark4522 then
		return false
	end

	if arg_215_0._owner._mark4685 and arg_215_0 ~= arg_215_0._owner._mark4685 then
		return false
	end

	if arg_215_0._owner._mark5376 and arg_215_0 ~= arg_215_0._owner._mark5376 then
		return false
	end

	if arg_215_0._owner._mark6425 and arg_215_0 ~= arg_215_0._owner._mark6425 then
		return false
	end

	if arg_215_0._owner._mark6457 and arg_215_0 ~= arg_215_0._owner._mark6457 then
		return false
	end

	if arg_215_0._owner._mark6905 and arg_215_0 ~= arg_215_0._owner._mark6905 then
		return false
	end

	if arg_215_0._owner._mark2185 and arg_215_0 ~= arg_215_0._owner._mark2185 then
		return false
	end

	if arg_215_0._owner._mark2205 and arg_215_0 ~= arg_215_0._owner._mark2205 then
		return false
	end

	if arg_215_0._owner._mark2450 and arg_215_0._info._category ~= arg_215_0._owner._mark2450 then
		return false
	end

	if arg_215_0._owner._mark2989 and not arg_215_0:isKeywordGroup(Data._skillInfo[2989]._refCards) then
		return false
	end

	if arg_215_0._owner._mark9212 and arg_215_0._info._category ~= arg_215_0._owner._mark9212 then
		return false
	end

	if arg_215_0._owner._mark9290 and arg_215_0 ~= arg_215_0._owner._mark9290 then
		return false
	end

	if arg_215_0._owner._opponent._mark9290 then
		return false
	end

	if arg_215_0._owner._mark9545 and arg_215_0._atk <= Data._skillInfo[9545]._val[1] then
		return false
	end

	if arg_215_0._owner._mark9598 and arg_215_0:getStarOrLevel() > arg_215_0._owner._mark9598 then
		return false
	end

	if arg_215_0._owner._mark9830 and not arg_215_0:isXYZ() then
		return false
	end

	if arg_215_0._owner._mark9844 and arg_215_0 ~= arg_215_0._owner._mark9844 then
		return false
	end

	if arg_215_0._owner._mark9925 and arg_215_0 ~= arg_215_0._owner._mark9925 then
		return false
	end

	if arg_215_0._owner._mark6695 and not arg_215_0:isKeyword(arg_215_0._owner._mark6695) then
		return false
	end

	if arg_215_0._owner._mark7441 and not arg_215_0:isKeyword(arg_215_0._owner._mark7441) then
		return false
	end

	if arg_215_0._owner._mark7548 and arg_215_0._infoId ~= Data._skillInfo[7548]._refCards[1] and arg_215_0._infoId ~= Data._skillInfo[7548]._refCards[2] then
		return false
	end

	if arg_215_0._owner._mark4912 and arg_215_0._info._category ~= arg_215_0._owner._mark4912 then
		return false
	end

	if arg_215_0._owner._mark4916 and not arg_215_0:isKeyword(arg_215_0._owner._mark4916) then
		return false
	end

	if arg_215_0._owner._mark13339 and not arg_215_0:isKeyword(arg_215_0._owner._mark13339) then
		return false
	end

	if arg_215_0._owner._mark14068 and arg_215_0._atk <= arg_215_0._owner._mark14068 then
		return false
	end

	if arg_215_0._owner._mark14305 and arg_215_0._atk ~= arg_215_0._owner._mark14305 then
		return false
	end

	if arg_215_0:hasBuff(false, BattleData.NegativeType.atkFrozen) or arg_215_0:hasBuff(false, BattleData.NegativeType.atkFrozenHalo) or arg_215_0:hasBuff(false, BattleData.NegativeType.atkFrozenForever) then
		return false
	end

	if arg_215_0:hasSkills({
		1060
	}) and not arg_215_0._mark1060 and arg_215_0._owner._fortress._hp <= Data._skillInfo[1060]._val[1] then
		return false
	end

	if arg_215_0:hasSkills({
		3295
	}) then
		return false
	end

	if arg_215_0:hasSkills({
		6022
	}) and #arg_215_0._owner:getBattleCards("H") > 0 then
		return false
	end

	if arg_215_0:hasSkills({
		1123,
		6045
	}) and #arg_215_0._owner._opponent:getBoardCards() == 0 then
		return false
	end

	if arg_215_0:hasCanCastMonsterSkillFast(1080) and #arg_215_0._owner._opponent:getBoardCards() == 0 then
		return false
	end

	if arg_215_0:isDisablePosture() and arg_215_0:hasBuff(true, BattleData.PositiveType.defendPosture) then
		return false
	end

	if (#arg_215_0._owner._attackedMonsters > 1 or arg_215_0._owner._attackedMonsters[1] ~= nil and arg_215_0._owner._attackedMonsters[1] ~= arg_215_0._id) and (arg_215_0._owner:hasBattleCardsBySkillFast("S", 7323) or arg_215_0._owner._opponent:hasBattleCardsBySkillFast("S", 7323) or arg_215_0._owner._opponent:hasBattleCardsBySkillFast("B", 2706)) then
		return false
	end

	if arg_215_0._owner._roundAttackIndex > 0 and arg_215_0._owner._opponent:hasBattleCardsByCanCastMonsterSkillFast("B", 9444) then
		return false
	end

	if arg_215_0._owner._mark5531 and arg_215_0._onBoardRound == arg_215_0._owner._round and not arg_215_0._mark5531 then
		return false
	end

	if arg_215_0:hasSkillFast(13131) then
		return false
	end

	if arg_215_0:hasSkillFast(9838) and not arg_215_0._mark9838 then
		return false
	end

	if arg_215_0._owner._opponent._mark2819 and arg_215_0._onBoardFrom == BattleData.CardStatus.rare then
		return false
	end

	return true
end

function var_0_0.canDefend(arg_216_0, arg_216_1)
	if arg_216_1 and not arg_216_0:canAction() then
		return false
	end

	if arg_216_0:isDisablePosture() and not arg_216_0:hasBuff(true, BattleData.PositiveType.defendPosture) then
		return false
	end

	return true
end

function var_0_0.canChangeToAttack(arg_217_0)
	if not arg_217_0:hasBuff(true, BattleData.PositiveType.defendPosture) then
		return false
	end

	if not arg_217_0:canAction() then
		return false
	end

	if arg_217_0:isDisablePosture() then
		return false
	end

	return true
end

function var_0_0.canChangeToDefend(arg_218_0)
	if arg_218_0:hasBuff(true, BattleData.PositiveType.defendPosture) then
		return false
	end

	if not arg_218_0:canAction() then
		return false
	end

	if arg_218_0:isDisablePosture() then
		return false
	end

	return true
end

function var_0_0.isDisablePosture(arg_219_0)
	return arg_219_0:hasBuff(false, BattleData.NegativeType.disablePosture) or arg_219_0:hasBuff(false, BattleData.NegativeType.disablePostureEx) or arg_219_0:hasBuff(false, BattleData.NegativeType.disablePostureHalo) or arg_219_0:isLink()
end

function var_0_0.isHurt(arg_220_0)
	return arg_220_0._hp < arg_220_0._maxHp + arg_220_0._haloedMaxHpInc
end

function var_0_0.isAtkHide(arg_221_0)
	return arg_221_0._type == Data.CardType.monster and band(arg_221_0._info._option, Data.MonsterOption.hide_atk) > 0
end

function var_0_0.isDefHide(arg_222_0)
	return arg_222_0._type == Data.CardType.monster and band(arg_222_0._info._option, Data.MonsterOption.hide_def) > 0
end

function var_0_0.check3520(arg_223_0)
	return arg_223_0:hasSkillFast(3520) and (arg_223_0._status == BattleData.CardStatus.grave or arg_223_0._status == BattleData.CardStatus.board and arg_223_0._mark3521 == nil) and true or false
end

function var_0_0.check3736(arg_224_0)
	return arg_224_0:hasSkillFast(3736) and arg_224_0._status == BattleData.CardStatus.board and not arg_224_0:isBindedKeywordEquip(Data._skillInfo[3736]._refCards[1]) and true or false
end

function var_0_0.check3843(arg_225_0)
	return arg_225_0:hasSkillFast(3843) and (arg_225_0._status == BattleData.CardStatus.grave or arg_225_0._status == BattleData.CardStatus.hand) and true or false
end

function var_0_0.check13663(arg_226_0)
	return arg_226_0:hasSkillFast(13663) and (arg_226_0._status == BattleData.CardStatus.hand or arg_226_0._status == BattleData.CardStatus.pile) and true or false
end

function var_0_0.check13708(arg_227_0)
	return arg_227_0:hasSkillFast(13708) and (arg_227_0._status == BattleData.CardStatus.hand or arg_227_0._status == BattleData.CardStatus.board) and true or false
end

function var_0_0.hasMonsterOption(arg_228_0, arg_228_1)
	return arg_228_0:isMonsterRare() and band(arg_228_0._info._option, arg_228_1) > 0
end

function var_0_0.isNormalMonster(arg_229_0)
	return arg_229_0:hasMonsterOption(Data.MonsterOption.is_normal) or arg_229_0:check3520() or arg_229_0:check3736() or arg_229_0:check3843() or arg_229_0:check13663() or arg_229_0:check13708()
end

function var_0_0.isEffectMonster(arg_230_0)
	return arg_230_0:hasMonsterOption(Data.MonsterOption.is_effect) and not arg_230_0:check3520() and not arg_230_0:check3736() and not arg_230_0:check3843() and not arg_230_0:check13663() and not arg_230_0:check13708()
end

function var_0_0.isSpirit(arg_231_0)
	return arg_231_0:hasMonsterOption(Data.MonsterOption.is_spirit)
end

function var_0_0.isDual(arg_232_0)
	return arg_232_0:hasMonsterOption(Data.MonsterOption.is_dual)
end

function var_0_0.isAdjust(arg_233_0)
	if arg_233_0._mark2294 then
		return false
	end

	return arg_233_0:hasMonsterOption(Data.MonsterOption.is_adjust) or arg_233_0._status == BattleData.CardStatus.board and arg_233_0:hasSkillFast(6318)
end

function var_0_0.isNotAdjust(arg_234_0)
	if arg_234_0._mark2294 then
		return true
	end

	return not arg_234_0:hasMonsterOption(Data.MonsterOption.is_adjust) and not arg_234_0:hasMonsterOption(Data.MonsterOption.is_xyz) and (arg_234_0._status ~= BattleData.CardStatus.board or not arg_234_0:hasSkillFast(6318))
end

function var_0_0.isAllyMonster(arg_235_0)
	return arg_235_0:hasMonsterOption(Data.MonsterOption.is_ally_monster)
end

function var_0_0.isCeremonyMonster(arg_236_0)
	return arg_236_0:hasMonsterOption(Data.MonsterOption.is_ceremony)
end

function var_0_0.isMerge(arg_237_0)
	return arg_237_0:hasMonsterOption(Data.MonsterOption.is_merge)
end

function var_0_0.isSync(arg_238_0)
	return arg_238_0:hasMonsterOption(Data.MonsterOption.is_sync)
end

function var_0_0.isXYZ(arg_239_0)
	return arg_239_0:hasMonsterOption(Data.MonsterOption.is_xyz)
end

function var_0_0.isPendulum(arg_240_0)
	return arg_240_0:hasMonsterOption(Data.MonsterOption.is_pendulum)
end

function var_0_0.isLink(arg_241_0)
	return arg_241_0:hasMonsterOption(Data.MonsterOption.is_link)
end

function var_0_0.isToken(arg_242_0)
	return arg_242_0:hasMonsterOption(Data.MonsterOption.is_token)
end

function var_0_0.isAllyEquip(arg_243_0)
	return arg_243_0._type == Data.CardType.magic and band(arg_243_0._info._option, Data.MagicOption.is_ally_equip) > 0
end

function var_0_0.isNormalMagic(arg_244_0)
	return arg_244_0._type == Data.CardType.magic and band(arg_244_0._info._option, Data.MagicOption.is_normal) > 0
end

function var_0_0.isEquipMagic(arg_245_0)
	return arg_245_0._type == Data.CardType.magic and band(arg_245_0._info._option, Data.MagicOption.is_equipment) > 0
end

function var_0_0.isCeremonyMagic(arg_246_0)
	return arg_246_0._type == Data.CardType.magic and band(arg_246_0._info._option, Data.MagicOption.is_ceremony) > 0
end

function var_0_0.isFieldMagic(arg_247_0)
	return arg_247_0._type == Data.CardType.magic and band(arg_247_0._info._option, Data.MagicOption.is_field) > 0
end

function var_0_0.isSustainableMagic(arg_248_0)
	return arg_248_0._type == Data.CardType.magic and band(arg_248_0._info._option, Data.MagicOption.is_sustainable) > 0
end

function var_0_0.isAlterMagic(arg_249_0)
	return arg_249_0._type == Data.CardType.magic and band(arg_249_0._info._option, Data.MagicOption.is_alter) > 0
end

function var_0_0.isNormalTrap(arg_250_0)
	return arg_250_0._type == Data.CardType.trap and band(arg_250_0._info._option, Data.TrapOption.is_normal) > 0
end

function var_0_0.isCounterTrap(arg_251_0)
	return arg_251_0._type == Data.CardType.trap and band(arg_251_0._info._option, Data.TrapOption.is_counter) > 0
end

function var_0_0.isSustainableTrap(arg_252_0)
	return arg_252_0._type == Data.CardType.trap and band(arg_252_0._info._option, Data.TrapOption.is_sustainable) > 0
end

function var_0_0.isNewLive1(arg_253_0)
	return arg_253_0._isNewLive1
end

function var_0_0.isNewLive2(arg_254_0)
	return arg_254_0._isNewLive2
end

function var_0_0.getRareOption(arg_255_0)
	local var_255_0

	if arg_255_0:isMerge() then
		var_255_0 = Data.MonsterOption.is_merge
	elseif arg_255_0:isSync() then
		var_255_0 = Data.MonsterOption.is_sync
	elseif arg_255_0:isXYZ() then
		var_255_0 = Data.MonsterOption.is_xyz
	elseif arg_255_0:isLink() then
		var_255_0 = Data.MonsterOption.is_link
	end

	return var_255_0
end

function var_0_0.canAttackTarget(arg_256_0, arg_256_1, arg_256_2)
	if not arg_256_0:canAttack(arg_256_2) then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(6052) and #arg_256_1._owner:getBoardCards() > 1 then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(6152) and #arg_256_1._owner:getBoardCards() ~= #arg_256_1._owner:getBattleCardsByInfoId("B", arg_256_1._infoId) then
		return false
	end

	if arg_256_0:hasCanCastMonsterSkillFast(6138) and arg_256_1:isMonsterRare() and #arg_256_1._owner:getBattleCardsByKeyword("B", Data._skillInfo[6138]._refCards[1]) > 0 and not arg_256_1:isKeyword(Data._skillInfo[6138]._refCards[1]) then
		return false
	end

	if arg_256_0:hasCanCastMonsterSkillFast(1080) and arg_256_1._mark1080 ~= nil and B.tableContain(arg_256_1._mark1080, arg_256_0._id) then
		return false
	end

	if arg_256_0:hasSkillFast(1086) and (not arg_256_1:isBoardCard() or not arg_256_1:hasBuff(true, BattleData.PositiveType.defendPosture)) then
		return false
	end

	if arg_256_0:hasSkillFast(1123) and arg_256_0._mark1123_2 and (arg_256_1._summonByNormal or arg_256_1._mark1123 == arg_256_0._id) then
		return false
	end

	if arg_256_1._owner:hasBattleCardsBySkillFast("B", 6798) and arg_256_1._infoId ~= Data._skillInfo[6798]._refCards[1] then
		return false
	end

	if arg_256_1:isProtectedBy6189() then
		return false
	end

	if arg_256_0:hasSkillFast(2374) and arg_256_1:isMonsterRare() and arg_256_1:getStar() ~= Data.XYZ_STAR and arg_256_1:getStar() <= arg_256_0:getStar() then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(9104) and #arg_256_1._owner:getBattleCardsByKeyword("B", Data._skillInfo[9104]._refCards[1], Data.CARD_MAX_LEVEL, arg_256_1) > 0 then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(9242) and #B.filterTokenCards(arg_256_1._owner:getBoardCards(), true) > 0 then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(9294) and (arg_256_1._pos == 4 or arg_256_1._pos == 5) and arg_256_0._atk <= arg_256_1._hp then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(9394) then
		return false
	end

	if arg_256_1:isDual() and #B.filterHasBuffCards(arg_256_1._owner:getBattleCardsByCanCastMonsterSkillFast("B", 9449), true, BattleData.PositiveType.xyzMark) > 0 then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(9460) and #B.filterNotEqualInfoIdCards(B.filterNotEqualInfoIdCards(arg_256_1._owner:getBoardCards(), Data._skillInfo[9460]._refCards[1]), Data._skillInfo[9460]._refCards[2]) > 0 then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(9483) and #arg_256_1._owner:getBattleCardsByKeyword("B", Data._skillInfo[9483]._refCards[1]) > 0 then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(13162) and #B.filterInKeywordGroupCards(arg_256_1._owner:getBoardCards(), Data._skillInfo[13162]._refCards) == #arg_256_1._owner:getBoardCards() then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(13372) and #arg_256_1._owner:getBattleCardsByKeyword("B", Data._skillInfo[13372]._refCards[1], Data.CARD_MAX_LEVEL, arg_256_1) > 0 then
		return false
	end

	if arg_256_1:isMonsterRare() and not arg_256_1:isInfoId(Data._skillInfo[13390]._refCards[1]) and arg_256_1:isKeyword(Data._skillInfo[13390]._refCards[2]) and arg_256_1._owner:hasBattleCardsByCanCastMonsterSkillFast("B", 13390) then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(13508) and #B.filterInKeywordCards(arg_256_1._owner:getBattleCardsByNature("B", Data._skillInfo[13508]._refCards[1], Data.CARD_MAX_LEVEL, arg_256_1), Data._skillInfo[13508]._refCards[2]) > 0 then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(13923) and #arg_256_1._owner:getBattleCardsByKeyword("B", Data._skillInfo[13923]._refCards[1], Data.CARD_MAX_LEVEL, arg_256_1) > 0 then
		return false
	end

	if arg_256_1:hasCanCastMonsterSkillFast(14244) and #arg_256_1._owner:getBattleCardsByKeyword("B", Data._skillInfo[14244]._refCards[1], Data.CARD_MAX_LEVEL, arg_256_1) > 0 then
		return false
	end

	if arg_256_1._type == Data.CardType.fortress and arg_256_0:hasSkillFast(6578) and arg_256_0._mark6578 and not arg_256_0:hasSkillFast(3616) and not arg_256_0:hasSkillFast(3191) then
		return false
	end

	local var_256_0 = arg_256_0._owner._opponent
	local var_256_1 = var_256_0:getBoardCards()

	if arg_256_1._type == Data.CardType.fortress then
		return #var_256_1 == 0
	end

	local var_256_2 = var_256_0:getBattleCards("B", Data.CARD_MAX_LEVEL, arg_256_1)
	local var_256_3 = 0
	local var_256_4 = {}
	local var_256_5 = {}
	local var_256_6 = {}
	local var_256_7 = {}

	for iter_256_0 = 1, #var_256_2 do
		local var_256_8 = var_256_2[iter_256_0]

		if var_256_8:hasBuff(true, BattleData.PositiveType.irony) then
			local var_256_9 = var_256_8:getBuffValue(true, BattleData.PositiveType.irony)

			if var_256_9 == 0 then
				var_256_3 = var_256_3 + 1
			elseif var_256_9 < 65536 then
				var_256_4[var_256_9] = (var_256_4[var_256_9] or 0) + 1
			elseif var_256_9 < 131072 then
				local var_256_10 = var_256_9 - 65536

				if var_256_10 < 200 then
					var_256_5[var_256_10] = (var_256_5[var_256_10] or 0) + 1
				else
					local var_256_11 = var_256_10 % 200
					local var_256_12 = math.floor(var_256_10 / 200)

					var_256_5[var_256_11] = (var_256_5[var_256_11] or 0) + 1
					var_256_5[var_256_12] = (var_256_5[var_256_12] or 0) + 1
				end
			elseif var_256_9 < 196608 then
				var_256_6[var_256_9 - 131072] = var_256_8._infoId
			else
				local var_256_13 = var_256_9 - 196608

				var_256_7[var_256_13] = (var_256_7[var_256_13] or 0) + 1
			end
		end
	end

	if var_256_3 > 0 then
		return false
	end

	if var_256_4[arg_256_1._info._category] then
		return false
	end

	for iter_256_1, iter_256_2 in pairs(var_256_5) do
		if arg_256_1:isKeyword(iter_256_1) then
			return false
		end
	end

	for iter_256_3, iter_256_4 in pairs(var_256_6) do
		if arg_256_1:isKeyword(iter_256_3) and not arg_256_1:isInfoId(iter_256_4) then
			return false
		end
	end

	for iter_256_5, iter_256_6 in pairs(var_256_7) do
		if not arg_256_1:isInfoId(iter_256_5) then
			return false
		end
	end

	return true
end

function var_0_0.canSacrificeWith(arg_257_0, arg_257_1, arg_257_2)
	if not arg_257_2 and arg_257_1._owner == arg_257_0._owner and arg_257_1:actioned() then
		return false
	end

	if not arg_257_1:canBeSacrificed() then
		return false
	end

	if arg_257_0:hasSkillFast(3102) and arg_257_1._info._category ~= Data._skillInfo[3102]._refCards[1] then
		return false
	end

	if arg_257_1:hasSkillFast(3243) and arg_257_0._info._category ~= Data._skillInfo[3243]._refCards[1] then
		return false
	end

	if arg_257_1:hasSkillFast(3288) and arg_257_0:isKeyword(Data._skillInfo[3288]._refCards[1]) then
		return false
	end

	if arg_257_1:hasSkillFast(3674) and not arg_257_0:isKeyword(Data._skillInfo[3674]._refCards[1]) then
		return false
	end

	if arg_257_0:hasSkillFast(3790) and not arg_257_1:isKeyword(Data._skillInfo[3790]._refCards[1]) then
		return false
	end

	if arg_257_1:hasSkillFast(3793) and not arg_257_0:isKeyword(Data._skillInfo[3793]._refCards[1]) then
		return false
	end

	if arg_257_1:hasSkillFast(3797) and not arg_257_0:isInfoId(Data._skillInfo[3797]._refCards[1]) and not arg_257_0:isInfoId(Data._skillInfo[3797]._refCards[2]) and not arg_257_0:isInfoId(Data._skillInfo[3797]._refCards[3]) then
		return false
	end

	if arg_257_1:hasSkillFast(9348) then
		return false
	end

	return true
end

function var_0_0.canBeSacrificed(arg_258_0, arg_258_1, arg_258_2)
	if not arg_258_0:isMonsterRare() then
		return false
	end

	if arg_258_0:hasSkillFast(3146) or arg_258_0:hasSkillFast(3295) or arg_258_0:hasSkillFast(13131) then
		return false
	end

	if arg_258_0._onBoardRound == arg_258_0._owner._round and arg_258_0:hasSkillFast(13017) then
		return false
	end

	if not arg_258_1 and not arg_258_2 and arg_258_0:hasSkillFast(6804) then
		return false
	end

	if not arg_258_1 and not arg_258_2 and arg_258_0:hasSkillFast(13033) then
		return false
	end

	if not arg_258_1 and not arg_258_2 and arg_258_0._onBoardRound == arg_258_0._owner._round and arg_258_0:hasSkillFast(2610) then
		return false
	end

	if (arg_258_1 or arg_258_2) and arg_258_0:hasSkillFast(6670) then
		return false
	end

	if arg_258_1 and arg_258_0:hasSkillFast(2140) then
		return false
	end

	if arg_258_1 and arg_258_0:hasSkillFast(9601) then
		return false
	end

	if arg_258_1 and arg_258_0:hasSkillFast(9819) then
		return false
	end

	if arg_258_1 and arg_258_0:hasSkillFast(13546) then
		return false
	end

	if arg_258_2 and arg_258_0:hasSkillFast(13546) and not arg_258_0:isKeyword(Data._skillInfo[13546]._refCards[1]) then
		return false
	end

	if not arg_258_2 and arg_258_0:hasSkillFast(2794) then
		return false
	end

	return true
end

function var_0_0.canBeCeremonyed(arg_259_0, arg_259_1)
	if arg_259_0:isLink() then
		return false
	end

	if arg_259_1:hasSkillFast(2331) and arg_259_1:isSameNameWith(arg_259_0) then
		return false
	end

	if arg_259_1:hasSkillFast(2332) and arg_259_1:getStar() == arg_259_0:getStar() then
		return false
	end

	if arg_259_0:hasSkillFast(13546) then
		return false
	end

	return true
end

function var_0_0.canBeSynced(arg_260_0, arg_260_1)
	if arg_260_0:isXYZ() or arg_260_0:isLink() then
		return false
	end

	if arg_260_0:hasSkillFast(6247) and not arg_260_1:isKeyword(Data._skillInfo[6247]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(6367) and not arg_260_1:isKeyword(Data._skillInfo[6367]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(6717) and not arg_260_1:isKeyword(Data._skillInfo[6717]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(6953) and not arg_260_1:isKeyword(Data._skillInfo[6953]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(2295) and not arg_260_1:isKeyword(Data._skillInfo[2295]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(2848) and not arg_260_1:isKeyword(Data._skillInfo[2848]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(2870) and not arg_260_1:isKeyword(Data._skillInfo[2870]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(9468) and not arg_260_1:isKeyword(Data._skillInfo[9468]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(13803) and not arg_260_1:isKeyword(Data._skillInfo[13803]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(6273) and arg_260_1._info._category ~= Data._skillInfo[6273]._refCards[1] then
		return false
	end

	if arg_260_0:hasSkillFast(6389) and arg_260_1._info._category ~= Data._skillInfo[6389]._refCards[1] then
		return false
	end

	if arg_260_0:hasSkillFast(6590) and arg_260_1._info._category ~= Data._skillInfo[6590]._refCards[1] then
		return false
	end

	if arg_260_0:hasSkillFast(9211) and arg_260_1._info._category ~= Data._skillInfo[9211]._refCards[1] then
		return false
	end

	if arg_260_0:hasSkillFast(6827) and not arg_260_1:isNature(Data._skillInfo[6827]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(3893) and (arg_260_1._info._joinComponent[1] == nil or not (arg_260_1._info._joinComponent[1] > Data.INFO_ID_GROUP_SIZE_LARGE) or Data._monsterInfo[arg_260_1._info._joinComponent[1]]._keyword ~= Data._skillInfo[3893]._refCards[1]) then
		return false
	end

	if arg_260_0:hasSkillFast(6477) and arg_260_0._status == BattleData.CardStatus.board then
		return false
	end

	if arg_260_1:hasSkillFast(6494) and arg_260_0:actioned() then
		return false
	end

	if arg_260_0:hasSkillFast(6779) then
		return false
	end

	if arg_260_0:hasSkillFast(9601) then
		return false
	end

	if arg_260_0:hasSkillFast(9819) then
		return false
	end

	if arg_260_0:hasSkillFast(13131) then
		return false
	end

	if arg_260_0:hasSkillFast(13546) and not arg_260_1:isKeyword(Data._skillInfo[13546]._refCards[1]) then
		return false
	end

	return true
end

function var_0_0.canBeXYZed(arg_261_0, arg_261_1)
	if arg_261_0:isToken() then
		return false
	end

	if arg_261_0:hasSkillFast(3295) then
		return false
	end

	if arg_261_0:hasSkillFast(6764) then
		return false
	end

	if arg_261_0:hasSkillFast(6910) and not arg_261_1:isKeyword(Data._skillInfo[6910]._refCards[1]) then
		return false
	end

	if arg_261_0:hasSkillFast(2222) and not arg_261_1:isKeyword(Data._skillInfo[2222]._refCards[1]) then
		return false
	end

	if arg_261_0:hasSkillFast(13803) and not arg_261_1:isKeyword(Data._skillInfo[13803]._refCards[1]) then
		return false
	end

	if arg_261_0:hasSkillFast(2184) and arg_261_1._info._nature ~= Data._skillInfo[2184]._refCards[1] then
		return false
	end

	if arg_261_0:hasSkillFast(9211) and arg_261_1._info._category ~= Data._skillInfo[9211]._refCards[1] then
		return false
	end

	if arg_261_0:hasSkillFast(13752) and arg_261_1._info._category ~= Data._skillInfo[13752]._refCards[1] then
		return false
	end

	if arg_261_0:hasSkillFast(9601) then
		return false
	end

	if arg_261_0:hasSkillFast(9819) then
		return false
	end

	if arg_261_0:hasSkillFast(13131) then
		return false
	end

	if arg_261_0:hasSkillFast(13546) then
		return false
	end

	return true
end

function var_0_0.canBeLinked(arg_262_0, arg_262_1, arg_262_2)
	if arg_262_0._canNotBeLinked then
		return false
	end

	if not arg_262_2 and (arg_262_0:isMerge() and not arg_262_0:hasSkillFast(14389) or arg_262_0:isSync() or arg_262_0:isXYZ()) then
		return false
	end

	if arg_262_0:hasSkillFast(3295) then
		return false
	end

	if arg_262_0:hasSkillFast(9648) then
		return false
	end

	if arg_262_0:hasSkillFast(9819) then
		return false
	end

	if arg_262_0:hasSkillFast(13131) then
		return false
	end

	if arg_262_0:hasSkillFast(13546) then
		return false
	end

	if arg_262_0:hasSkillFast(13803) and not arg_262_1:isKeyword(Data._skillInfo[13803]._refCards[1]) then
		return false
	end

	if arg_262_0:actioned() then
		return false
	end

	return true
end

function var_0_0.isTriggerByOppo(arg_263_0)
	return arg_263_0._triggerCard ~= nil and (arg_263_0._triggerCard._owner ~= arg_263_0._owner or arg_263_0._triggerCard._infoId == 20644)
end

function var_0_0.setDieStat(arg_264_0)
	arg_264_0._prevBoardPos = arg_264_0._pos
	arg_264_0._dieRound = {
		arg_264_0._owner._round,
		arg_264_0._owner._opponent._round
	}
	arg_264_0._dieByAttack = arg_264_0._statusVal == BattleData.CardStatusVal.b2g_kill_by_attack
	arg_264_0._dieByEffect = arg_264_0._statusVal ~= BattleData.CardStatusVal.b2g_kill_by_attack and not arg_264_0:isStatusValSacrifice() and not arg_264_0:isStatusValCost() and not arg_264_0:isStatusValLeaveTemp() and arg_264_0._statusVal ~= BattleData.CardStatusVal.h2g_drop
	arg_264_0._dieBySacrifice = arg_264_0:isStatusValSacrifice()
	arg_264_0._dieBySyncSacrifice = arg_264_0._statusVal == BattleData.CardStatusVal.b2g_sync_sacrifice
	arg_264_0._dieByLinkSacrifice = arg_264_0._statusVal == BattleData.CardStatusVal.b2g_link_sacrifice
	arg_264_0._dieBySummonSacrifice = arg_264_0._statusVal == BattleData.CardStatusVal.b2g_summon_sacrifice
	arg_264_0._dieByEffectSacrifice = arg_264_0:isStatusValSacrifice() and arg_264_0._statusVal ~= BattleData.CardStatusVal.b2g_summon_sacrifice
	arg_264_0._dieCount = arg_264_0._dieCount + 1
	arg_264_0._dieByCard = arg_264_0._triggerCard
	arg_264_0._dieByOppo = arg_264_0:isTriggerByOppo()
	arg_264_0._dieFromStatus = arg_264_0._sourceStatus
	arg_264_0._dieByCastTrap = arg_264_0._statusVal == BattleData.CardStatusVal.h2g_trap
end

local var_0_5 = {
	3143,
	3455,
	3993,
	3997,
	3998,
	3999,
	4304,
	4471,
	4613,
	4693,
	4729,
	4731,
	4733,
	4759,
	4851,
	4885,
	4893,
	4947,
	7727,
	5371,
	6236,
	6237,
	6271,
	6622,
	6808,
	6826,
	6875,
	2200,
	2370,
	2411,
	2574,
	2576,
	2662,
	2668,
	2671,
	2675,
	2873,
	2875,
	2883,
	2905,
	9030,
	9047,
	9097,
	9122,
	9315,
	9521,
	9522,
	9571,
	9678,
	9798,
	9799,
	9803,
	9805,
	9985,
	9993,
	9994,
	9995,
	9996,
	9997,
	7200,
	8067,
	13107,
	13230,
	13235,
	13302,
	13641,
	13816,
	13819,
	14572
}
local var_0_6 = {
	3113,
	3308,
	3533,
	3654,
	3656,
	3712,
	3859,
	3872,
	3932,
	4172,
	6298,
	6602,
	6632,
	6668,
	2122,
	2399,
	9496,
	9962,
	13063,
	13242,
	13900,
	14017,
	14464
}
local var_0_7 = {
	7308,
	7486,
	8075
}
local var_0_8 = {
	3113,
	3533,
	3609,
	3654,
	3656,
	3712,
	6602,
	6632,
	6644,
	7486,
	2122,
	9496,
	13063,
	13900,
	14017,
	14464
}
local var_0_9 = {
	6644
}

function var_0_0.getExtraInfoIds(arg_265_0, arg_265_1)
	arg_265_1 = arg_265_1 or arg_265_0._status

	local var_265_0 = {}

	for iter_265_0 = 1, #var_0_5 do
		local var_265_1 = var_0_5[iter_265_0]

		if arg_265_0:hasSkillFast(var_265_1) then
			var_265_0[#var_265_0 + 1] = Data._skillInfo[var_265_1]._refCards[1]
		end
	end

	if arg_265_1 == BattleData.CardStatus.board then
		for iter_265_1 = 1, #var_0_6 do
			local var_265_2 = var_0_6[iter_265_1]

			if arg_265_0:hasSkillFast(var_265_2) then
				var_265_0[#var_265_0 + 1] = Data._skillInfo[var_265_2]._refCards[1]
			end
		end

		if arg_265_0._markInfoId then
			var_265_0[#var_265_0 + 1] = arg_265_0._markInfoId
		end
	elseif arg_265_1 == BattleData.CardStatus.show then
		for iter_265_2 = 1, #var_0_7 do
			local var_265_3 = var_0_7[iter_265_2]

			if arg_265_0:hasSkillFast(var_265_3) then
				var_265_0[#var_265_0 + 1] = Data._skillInfo[var_265_3]._refCards[1]
			end
		end
	elseif arg_265_1 == BattleData.CardStatus.grave then
		for iter_265_3 = 1, #var_0_8 do
			local var_265_4 = var_0_8[iter_265_3]

			if arg_265_0:hasSkillFast(var_265_4) then
				var_265_0[#var_265_0 + 1] = Data._skillInfo[var_265_4]._refCards[1]
			end
		end
	elseif arg_265_1 == BattleData.CardStatus.hand then
		for iter_265_4 = 1, #var_0_9 do
			local var_265_5 = var_0_9[iter_265_4]

			if arg_265_0:hasSkillFast(var_265_5) then
				var_265_0[#var_265_0 + 1] = Data._skillInfo[var_265_5]._refCards[1]
			end
		end

		if arg_265_0._markInfoId then
			var_265_0[#var_265_0 + 1] = arg_265_0._markInfoId
		end
	end

	return var_265_0
end

function var_0_0.isExtraInfoId(arg_266_0, arg_266_1, arg_266_2)
	arg_266_2 = arg_266_2 or arg_266_0._status

	for iter_266_0 = 1, #var_0_5 do
		local var_266_0 = var_0_5[iter_266_0]

		if arg_266_1 == Data._skillInfo[var_266_0]._refCards[1] and arg_266_0:hasSkillFast(var_266_0) then
			return true
		end
	end

	if arg_266_2 == BattleData.CardStatus.board then
		for iter_266_1 = 1, #var_0_6 do
			local var_266_1 = var_0_6[iter_266_1]

			if arg_266_1 == Data._skillInfo[var_266_1]._refCards[1] and arg_266_0:hasSkillFast(var_266_1) then
				return true
			end
		end

		if arg_266_0._markInfoId == arg_266_1 then
			return true
		end
	elseif arg_266_2 == BattleData.CardStatus.show then
		for iter_266_2 = 1, #var_0_7 do
			local var_266_2 = var_0_7[iter_266_2]

			if arg_266_1 == Data._skillInfo[var_266_2]._refCards[1] and arg_266_0:hasSkillFast(var_266_2) then
				return true
			end
		end
	elseif arg_266_2 == BattleData.CardStatus.grave then
		for iter_266_3 = 1, #var_0_8 do
			local var_266_3 = var_0_8[iter_266_3]

			if arg_266_1 == Data._skillInfo[var_266_3]._refCards[1] and arg_266_0:hasSkillFast(var_266_3) then
				return true
			end
		end
	elseif arg_266_2 == BattleData.CardStatus.hand then
		for iter_266_4 = 1, #var_0_9 do
			local var_266_4 = var_0_9[iter_266_4]

			if arg_266_1 == Data._skillInfo[var_266_4]._refCards[1] and arg_266_0:hasSkillFast(var_266_4) then
				return true
			end
		end

		if arg_266_0._markInfoId == arg_266_1 then
			return true
		end
	end

	return false
end

function var_0_0.isExtraKeyword(arg_267_0, arg_267_1, arg_267_2)
	arg_267_2 = arg_267_2 or arg_267_0._status

	for iter_267_0 = 1, #var_0_5 do
		local var_267_0 = var_0_5[iter_267_0]

		if arg_267_1 == Data.getInfo(Data._skillInfo[var_267_0]._refCards[1])._keyword and arg_267_0:hasSkillFast(var_267_0) then
			return true
		end
	end

	if arg_267_2 == BattleData.CardStatus.board then
		for iter_267_1 = 1, #var_0_6 do
			local var_267_1 = var_0_6[iter_267_1]

			if arg_267_1 == Data.getInfo(Data._skillInfo[var_267_1]._refCards[1])._keyword and arg_267_0:hasSkillFast(var_267_1) then
				return true
			end
		end

		if arg_267_0._markInfoId and arg_267_1 == Data.getInfo(arg_267_0._markInfoId)._keyword then
			return true
		end
	elseif arg_267_2 == BattleData.CardStatus.show then
		for iter_267_2 = 1, #var_0_7 do
			local var_267_2 = var_0_7[iter_267_2]

			if arg_267_1 == Data.getInfo(Data._skillInfo[var_267_2]._refCards[1])._keyword and arg_267_0:hasSkillFast(var_267_2) then
				return true
			end
		end
	elseif arg_267_2 == BattleData.CardStatus.grave then
		for iter_267_3 = 1, #var_0_8 do
			local var_267_3 = var_0_8[iter_267_3]

			if arg_267_1 == Data.getInfo(Data._skillInfo[var_267_3]._refCards[1])._keyword and arg_267_0:hasSkillFast(var_267_3) then
				return true
			end
		end
	elseif arg_267_2 == BattleData.CardStatus.hand then
		for iter_267_4 = 1, #var_0_9 do
			local var_267_4 = var_0_9[iter_267_4]

			if arg_267_1 == Data.getInfo(Data._skillInfo[var_267_4]._refCards[1])._keyword and arg_267_0:hasSkillFast(var_267_4) then
				return true
			end
		end

		if arg_267_0._markInfoId and arg_267_1 == Data.getInfo(arg_267_0._markInfoId)._keyword then
			return true
		end
	end

	return false
end

function var_0_0.isInfoId(arg_268_0, arg_268_1)
	if arg_268_0._infoId == arg_268_1 then
		return true
	end

	return arg_268_0:isExtraInfoId(arg_268_1)
end

function var_0_0.isInInfoIdGroup(arg_269_0, arg_269_1)
	for iter_269_0 = 1, #arg_269_1 do
		if arg_269_0:isInfoId(arg_269_1[iter_269_0]) then
			return true
		end
	end

	return false
end

local var_0_10 = {
	2102,
	2211,
	2230,
	2261,
	2448,
	2604,
	2636,
	2637,
	2718,
	2765,
	2919,
	2987,
	3600,
	3605,
	3617,
	3630,
	3794,
	3860,
	3886,
	3945,
	4447,
	4503,
	4553,
	4700,
	7730,
	5286,
	5579,
	5658,
	6310,
	6726,
	6756,
	6761,
	6791,
	6811,
	9068,
	9191,
	9524,
	9525,
	9526,
	9527,
	9597,
	9681,
	9915,
	9951,
	9962,
	13026,
	13060,
	13104,
	13107,
	13216,
	13252,
	13303,
	13306,
	13515,
	13643,
	13677,
	13683,
	13849,
	13853,
	13906,
	13907,
	13922,
	13936,
	13952,
	13961,
	13968,
	13969,
	13983,
	13984,
	14045,
	14046,
	14060,
	14061,
	14062,
	14078,
	14124,
	14178,
	14188,
	14189,
	14284,
	14295,
	14309,
	14310,
	14311,
	14318,
	14319,
	14334,
	14335,
	14344,
	14365,
	14366,
	14367,
	14372,
	14373,
	14374,
	14408,
	14409,
	14426,
	14427,
	14446,
	14447,
	14468,
	14469,
	14472,
	14473,
	14502,
	14503,
	14504,
	14513
}

function var_0_0.isKeyword(arg_270_0, arg_270_1, arg_270_2)
	if arg_270_0._info._keyword == arg_270_1 then
		return true
	end

	if arg_270_0._mark13329 and arg_270_1 == Data._skillInfo[13329]._refCards[1] then
		return true
	end

	if arg_270_1 == Data.CardKeyword.cartoon and arg_270_0._info._option ~= nil and band(arg_270_0._info._option, Data.MonsterOption.is_cartoon) > 0 then
		return true
	end

	if arg_270_1 == Data.CardKeyword.hero then
		return arg_270_0:isKeyword(Data.CardKeyword.ysyx, arg_270_2) or arg_270_0:isKeyword(Data.CardKeyword.myyx, arg_270_2) or arg_270_0:isKeyword(Data.CardKeyword.hyyx, arg_270_2) or arg_270_0:isKeyword(Data.CardKeyword.xxyx, arg_270_2) or arg_270_0:isKeyword(Data.CardKeyword.jmyx, arg_270_2) or arg_270_0:isKeyword(Data.CardKeyword.tyyx, arg_270_2)
	end

	for iter_270_0 = 1, #var_0_10 do
		local var_270_0 = var_0_10[iter_270_0]
		local var_270_1 = Data._skillInfo[var_270_0]._refCards

		if (var_270_1[1] == arg_270_1 or var_270_1[2] == arg_270_1 or var_270_1[3] == arg_270_1) and arg_270_0:hasSkillFast(var_270_0) then
			return true
		end
	end

	for iter_270_1 = 9653, 9664 do
		local var_270_2 = Data._skillInfo[iter_270_1]._refCards

		if (var_270_2[1] == arg_270_1 or var_270_2[2] == arg_270_1) and arg_270_0:hasSkillFast(iter_270_1) then
			return true
		end
	end

	for iter_270_2 = 9666, 9677 do
		local var_270_3 = Data._skillInfo[iter_270_2]._refCards

		if (var_270_3[1] == arg_270_1 or var_270_3[2] == arg_270_1) and arg_270_0:hasSkillFast(iter_270_2) then
			return true
		end
	end

	if arg_270_0._status == BattleData.CardStatus.board and arg_270_0:hasSkillFast(6991) and Data._skillInfo[6991]._refCards[1] == arg_270_1 then
		return true
	end

	if arg_270_0:isExtraKeyword(arg_270_1, arg_270_2) then
		return true
	end

	if arg_270_1 == Data.CardKeyword.ys then
		return arg_270_0:isKeyword(Data.CardKeyword.ysnl)
	end

	return false
end

function var_0_0.isKeywordGroup(arg_271_0, arg_271_1, arg_271_2)
	for iter_271_0 = 1, #arg_271_1 do
		if arg_271_0:isKeyword(arg_271_1[iter_271_0], arg_271_2) then
			return true
		end
	end

	return false
end

local var_0_11 = {
	3633,
	9163,
	9311,
	9603,
	9604,
	9605,
	9665
}

function var_0_0.isNature(arg_272_0, arg_272_1)
	if arg_272_0._info._nature == arg_272_1 then
		return true
	end

	for iter_272_0 = 1, #var_0_11 do
		local var_272_0 = var_0_11[iter_272_0]
		local var_272_1 = Data._skillInfo[var_272_0]._refCards

		if (var_272_1[1] == arg_272_1 or var_272_1[2] == arg_272_1) and arg_272_0:hasSkillFast(var_272_0) then
			return true
		end
	end

	if arg_272_0:hasSkillFast(6840) and arg_272_0:isBindedKeywordEquip(Data._skillInfo[6840]._refCards[1]) and Data._skillInfo[6840]._refCards[2] == arg_272_1 then
		return true
	end

	if arg_272_0._status == BattleData.CardStatus.board and arg_272_0:hasSkillFast(9494) then
		local var_272_2 = Data._skillInfo[9494]._refCards

		for iter_272_1 = 1, #var_272_2 do
			if var_272_2[iter_272_1] == arg_272_1 then
				return true
			end
		end
	end

	if arg_272_0._status == BattleData.CardStatus.board and arg_272_0:hasSkillFast(14349) and Data._skillInfo[14349]._refCards[1] == arg_272_1 then
		return true
	end

	if (arg_272_0._status == BattleData.CardStatus.board or arg_272_0._status == BattleData.CardStatus.grave) and arg_272_0:isKeyword(Data._skillInfo[7390]._refCards[1]) and arg_272_0._owner:hasBattleCardsBySkillFast("D", 7390) and Data._skillInfo[7390]._refCards[2] == arg_272_1 then
		return true
	end

	if arg_272_0._mark9062 == arg_272_1 then
		return true
	end

	if arg_272_0:isBindedSkill(7530) then
		local var_272_3 = Data._skillInfo[7530]._refCards

		for iter_272_2 = 2, #var_272_3 do
			if var_272_3[iter_272_2] == arg_272_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.isNatureGroup(arg_273_0, arg_273_1)
	for iter_273_0 = 1, #arg_273_1 do
		if arg_273_0:isNature(arg_273_1[iter_273_0]) then
			return true
		end
	end

	return false
end

function var_0_0.isCategoryGroup(arg_274_0, arg_274_1)
	for iter_274_0 = 1, #arg_274_1 do
		if arg_274_0._info._category == arg_274_1[iter_274_0] then
			return true
		end
	end

	return false
end

function var_0_0.isSameNameWith(arg_275_0, arg_275_1)
	if arg_275_0._mark5504 == arg_275_1._infoId or arg_275_1._mark5504 == arg_275_0._infoId then
		return true
	end

	if arg_275_0:isInfoId(arg_275_1._infoId) or arg_275_1:isInfoId(arg_275_0._infoId) then
		return true
	end

	local var_275_0 = arg_275_1:getExtraInfoIds()

	for iter_275_0 = 1, #var_275_0 do
		if arg_275_0:isInfoId(var_275_0[iter_275_0]) then
			return true
		end
	end

	local var_275_1 = arg_275_0:getExtraInfoIds()

	for iter_275_1 = 1, #var_275_1 do
		if arg_275_1:isInfoId(var_275_1[iter_275_1]) then
			return true
		end
	end

	return false
end

function var_0_0.isSameNatureWith(arg_276_0, arg_276_1)
	for iter_276_0 = 1, Data.CardNature.count do
		if arg_276_1:isNature(iter_276_0) and arg_276_0:isNature(iter_276_0) then
			return true
		end
	end

	return false
end

function var_0_0.isNotSameKeywordWith(arg_277_0, arg_277_1, arg_277_2)
	for iter_277_0 = 1, #arg_277_2 do
		local var_277_0 = arg_277_2[iter_277_0]

		if arg_277_1:isKeyword(var_277_0) ~= arg_277_0:isKeyword(var_277_0) then
			return true
		end
	end

	return false
end

function var_0_0.isSuperId(arg_278_0, arg_278_1)
	local var_278_0 = Data.getType(arg_278_1)
	local var_278_1 = arg_278_1 % Data.INFO_ID_GROUP_SIZE
	local var_278_2 = arg_278_1 % Data.INFO_ID_GROUP_SIZE_SMALL

	if var_278_0 == Data.CardType.nature then
		return arg_278_0:isNature(var_278_1)
	elseif var_278_0 == Data.CardType.category then
		if var_278_1 < 100 then
			return arg_278_0._info._category == var_278_1
		else
			return arg_278_0._info._category ~= var_278_1 - 100
		end
	elseif var_278_0 == Data.CardType.keyword then
		return arg_278_0:isMonsterRare() and arg_278_0:isKeyword(var_278_1)
	elseif var_278_0 == Data.CardType.flag then
		local var_278_3 = 2^(var_278_1 - 1)

		if var_278_3 == Data.MonsterOption.is_normal then
			return arg_278_0:isNormalMonster()
		elseif var_278_3 == Data.MonsterOption.is_effect then
			return arg_278_0:isEffectMonster()
		elseif var_278_3 == Data.MonsterOption.is_dual then
			return arg_278_0:isDual()
		elseif var_278_3 == Data.MonsterOption.is_adjust then
			return arg_278_0:isAdjust()
		elseif var_278_3 == Data.MonsterOption.is_sync then
			return arg_278_0:isSync()
		elseif var_278_3 == Data.MonsterOption.is_link then
			return arg_278_0:isLink()
		end
	elseif var_278_0 == Data.CardType.not_flag then
		local var_278_4 = 2^(var_278_1 - 1)

		if var_278_4 == Data.MonsterOption.is_adjust then
			return arg_278_0:isNotAdjust()
		elseif var_278_4 == Data.MonsterOption.is_sync then
			return not arg_278_0:isSync()
		elseif var_278_4 == Data.MonsterOption.is_link then
			return not arg_278_0:isLink()
		end
	elseif var_278_0 == Data.CardType.star then
		return not arg_278_0:isXYZ() and not arg_278_0:isLink() and arg_278_0:getStar() == var_278_2
	elseif var_278_0 == Data.CardType.min_star then
		return not arg_278_0:isXYZ() and not arg_278_0:isLink() and var_278_2 <= arg_278_0:getStar()
	elseif var_278_0 == Data.CardType.max_quality then
		return arg_278_0:isMonsterRare() and var_278_2 >= arg_278_0._info._quality
	elseif var_278_0 == Data.CardType.max_star then
		return var_278_2 >= arg_278_0:getStar()
	elseif var_278_0 == Data.CardType.card_type then
		return arg_278_0._type == var_278_2
	end

	return false
end

function var_0_0.getQuality(arg_279_0)
	return CardHelper.getCardQuality(arg_279_0)
end

function var_0_0.getCost(arg_280_0)
	return CardHelper.getCardCost(arg_280_0)
end

function var_0_0.getSkillLevel(arg_281_0, arg_281_1)
	return arg_281_0._level
end

function var_0_0.getAtk(arg_282_0)
	return arg_282_0._atk
end

function var_0_0.getHp(arg_283_0)
	return arg_283_0._hp
end

function var_0_0.getFrameId(arg_284_0)
	return CardHelper.getCardFrameId(arg_284_0)
end

function var_0_0.getBaseStar(arg_285_0)
	return arg_285_0._info._star or 0
end

function var_0_0.getStar(arg_286_0)
	if arg_286_0:isMonsterRare() then
		if arg_286_0:isXYZ() or arg_286_0:isLink() then
			return Data.XYZ_STAR
		end

		local var_286_0 = arg_286_0:getBaseStar() + arg_286_0:getBuffValue(true, BattleData.PositiveType.extraStarHalo) + arg_286_0:getBuffValue(true, BattleData.PositiveType.extraStar)

		if arg_286_0._status == BattleData.CardStatus.hand then
			if arg_286_0._info._quality <= 4 then
				var_286_0 = var_286_0 + (arg_286_0._owner._mark4068 or 0)
			end

			var_286_0 = var_286_0 + (arg_286_0._mark4419 or 0)
			var_286_0 = var_286_0 + (arg_286_0._owner._fieldCard ~= nil and arg_286_0._owner._fieldCard._infoId == 20753 and arg_286_0:isNature(Data._skillInfo[7363]._refCards[1]) and -1 or 0)
			var_286_0 = var_286_0 + (arg_286_0._owner._opponent._fieldCard ~= nil and arg_286_0._owner._opponent._fieldCard._infoId == 20753 and arg_286_0:isNature(Data._skillInfo[7363]._refCards[1]) and -1 or 0)
		end

		local var_286_1 = var_286_0 + (arg_286_0._mark2734 or 0)

		return math.min(12, math.max(1, var_286_1))
	else
		return 0
	end
end

function var_0_0.getStarOrLevel(arg_287_0)
	if arg_287_0:isXYZ() then
		return arg_287_0._info._star
	elseif arg_287_0:isLink() then
		return 0
	else
		return arg_287_0:getStar()
	end
end

function var_0_0.getSyncStar(arg_288_0, arg_288_1)
	local var_288_0 = arg_288_0:getStar()

	if arg_288_0:hasSkillFast(3987) and not arg_288_1:isInfoId(Data._skillInfo[3987]._refCards[1]) then
		var_288_0 = var_288_0 - Data._skillInfo[3987]._val[1]
	elseif arg_288_1:hasSkillFast(9101) and arg_288_0:isKeyword(Data._skillInfo[9101]._refCards[1]) and arg_288_0:isAdjust() then
		var_288_0 = Data._skillInfo[9101]._val[1]
	elseif arg_288_1:hasSkillFast(9344) and arg_288_0:isKeyword(Data._skillInfo[9344]._refCards[1]) then
		var_288_0 = Data._skillInfo[9344]._val[1]
	elseif arg_288_1:hasSkillFast(13080) and arg_288_0:isKeyword(Data._skillInfo[13080]._refCards[1]) then
		var_288_0 = Data._skillInfo[13080]._val[1]
	end

	return var_288_0
end

function var_0_0.getCeremonyStar(arg_289_0, arg_289_1)
	if arg_289_1:isNature(Data._skillInfo[2165]._refCards[1]) and arg_289_0:hasSkillFast(2165) then
		return arg_289_1:getStar()
	end

	if arg_289_1:isKeyword(Data._skillInfo[2335]._refCards[1]) and arg_289_0:hasSkillFast(2335) then
		return arg_289_1:getStar()
	end

	return arg_289_0:getStar()
end

function var_0_0.getSacrificeCount(arg_290_0)
	if arg_290_0._owner._mark7415 and arg_290_0:isDual() then
		return 0
	end

	if arg_290_0._info._category == Data._skillInfo[7064]._refCards[1] and arg_290_0._owner:hasBattleCardsBySkillFast("S", 7064) then
		return 0
	end

	if arg_290_0._info._category == Data._skillInfo[8049]._refCards[1] and arg_290_0._owner:hasBattleCardsBySkillFast("S", 8049) then
		return 0
	end

	if arg_290_0:hasSkills({
		3231,
		3541,
		2564,
		9832
	}) then
		return 0
	end

	if arg_290_0:hasSkillFast(3226) and #arg_290_0._owner._opponent:getBoardCards() >= 2 then
		return 0
	end

	if arg_290_0:hasSkillFast(3299) and #arg_290_0._owner:getBattleCardsByNature("B", Data._skillInfo[3299]._refCards[1]) > 0 then
		return 0
	end

	if arg_290_0:hasSkills({
		3327,
		3692
	}) and #arg_290_0._owner:getBoardCards() == 0 then
		return 0
	end

	if arg_290_0:hasSkillFast(3627) and #arg_290_0._owner:getBoardCards() < #arg_290_0._owner._opponent:getBoardCards() then
		return 0
	end

	if arg_290_0:hasSkills({
		3711,
		3740
	}) and #arg_290_0._owner:getBoardCards() == 0 and #arg_290_0._owner._opponent:getBoardCards() > 0 then
		return 0
	end

	if arg_290_0:hasSkillFast(6471) and #arg_290_0._owner:getBattleCardsByKeyword("B", Data._skillInfo[6471]._refCards[1]) > 0 then
		return 0
	end

	if arg_290_0:hasSkillFast(6513) and #arg_290_0._owner:getBattleCardsByCategory("B", Data._skillInfo[6513]._refCards[1]) > 0 then
		return 0
	end

	if arg_290_0:hasSkillFast(2619) and #arg_290_0._owner:getBattleCardsByKeyword("BCSD", Data._skillInfo[2619]._refCards[1]) > 0 then
		return 0
	end

	if arg_290_0:hasSkillFast(2634) and #arg_290_0._owner:getBattleCardsByKeywordGroup("B", Data._skillInfo[2634]._refCards) > 0 then
		return 0
	end

	if arg_290_0:hasSkillFast(2885) and #arg_290_0._owner:getBattleCards("H") >= Data._skillInfo[2885]._val[1] then
		return 0
	end

	if arg_290_0:hasSkillFast(2921) and #arg_290_0._owner._opponent:getBoardCards() > 0 then
		return 0
	end

	if arg_290_0:hasSkillFast(9268) and #arg_290_0._owner:getBattleCardsByCategory("B", Data._skillInfo[9268]._refCards[1]) > 0 then
		return 0
	end

	if arg_290_0:hasSkillFast(9388) and #arg_290_0._owner:getBattleCards("BSD") == 0 then
		return 0
	end

	if arg_290_0:isKeyword(Data._skillInfo[9613]._refCards[1]) and arg_290_0._owner:hasBattleCardsBySkillFast("B", 9613) then
		return 0
	end

	if arg_290_0:hasSkillFast(9891) then
		local var_290_0 = {}
		local var_290_1 = 0
		local var_290_2 = arg_290_0._owner._opponent:getBoardCards()

		for iter_290_0 = 1, #var_290_2 do
			local var_290_3 = var_290_2[iter_290_0]._info._category

			var_290_0[var_290_3] = (var_290_0[var_290_3] or 0) + 1

			if var_290_1 < var_290_0[var_290_3] then
				var_290_1 = var_290_0[var_290_3]
			end
		end

		if var_290_1 >= Data._skillInfo[9891]._val[1] then
			return 0
		end
	end

	if arg_290_0._mark3515 then
		return 0
	end

	if arg_290_0._mark4814 then
		return 0
	end

	if arg_290_0:hasSkills({
		3131,
		3799
	}) then
		return 3
	end

	local var_290_4 = arg_290_0:getStar()
	local var_290_5 = 0
	local var_290_6 = var_290_4 <= 4 and 0 or var_290_4 <= 6 and 1 or var_290_4 <= 8 and 2 or 2

	if var_290_6 > 0 and arg_290_0._owner._mark2280 ~= nil and arg_290_0:isKeyword(Data._skillInfo[2280]._refCards[1]) then
		var_290_6 = var_290_6 - 1
	end

	return var_290_6
end

function var_0_0.getOriginOwner(arg_291_0)
	return arg_291_0._isBorrowed == true and arg_291_0._owner._opponent or arg_291_0._owner
end

function var_0_0.isMonsterRare(arg_292_0)
	return arg_292_0._type == Data.CardType.monster or arg_292_0._type == Data.CardType.rare
end

function var_0_0.isV12(arg_293_0)
	return arg_293_0:isInfoId(10407) or arg_293_0:isInfoId(12142)
end

function var_0_0.isV13(arg_294_0)
	return arg_294_0:isInfoId(10446)
end

function var_0_0.isSummonedBySacrifice(arg_295_0)
	return arg_295_0._summonByNormal and arg_295_0._sacrificedCards ~= nil
end

function var_0_0.isStatusValNormalSummon(arg_296_0)
	return arg_296_0._statusVal == BattleData.CardStatusVal.h2b_normal or arg_296_0._statusVal == BattleData.CardStatusVal.h2b_oppo_normal
end

function var_0_0.isStatusValComposeSummon(arg_297_0)
	return arg_297_0._statusVal == BattleData.CardStatusVal.r2b_compose or arg_297_0._statusVal == BattleData.CardStatusVal.r2b_compose_ex
end

function var_0_0.isStatusValCeremonySummon(arg_298_0)
	return arg_298_0._statusVal == BattleData.CardStatusVal.h2b_ceremony or arg_298_0._statusVal == BattleData.CardStatusVal.h2b_ceremony_frozen
end

function var_0_0.isStatusValSyncSummon(arg_299_0)
	return arg_299_0._statusVal == BattleData.CardStatusVal.r2b_sync or arg_299_0._statusVal == BattleData.CardStatusVal.r2b_sync_attack_frozen
end

function var_0_0.isStatusValXYZSummon(arg_300_0)
	return arg_300_0._statusVal == BattleData.CardStatusVal.r2b_xyz or arg_300_0._statusVal == BattleData.CardStatusVal.r2b_xyz_attack_frozen
end

function var_0_0.isStatusValLinkSummon(arg_301_0)
	return arg_301_0._statusVal == BattleData.CardStatusVal.r2b_link
end

function var_0_0.isStatusValNotSummon(arg_302_0)
	return arg_302_0._statusVal == BattleData.CardStatusVal.b2b_oppo_forever or arg_302_0._statusVal == BattleData.CardStatusVal.b2b_oppo_forever_attack_frozen or arg_302_0._statusVal == BattleData.CardStatusVal.b2b_oppo_forever_using or arg_302_0._statusVal == BattleData.CardStatusVal.b2b_oppo_once or arg_302_0._statusVal == BattleData.CardStatusVal.b2b_oppo_once_attack_frozen or arg_302_0._statusVal == BattleData.CardStatusVal.e2b_5039 or arg_302_0._statusVal == BattleData.CardStatusVal.l2b_2281 or arg_302_0._statusVal == BattleData.CardStatusVal.e2b_from_temp_leave or arg_302_0._statusVal == BattleData.CardStatusVal.e2b_from_temp_leave_def
end

function var_0_0.isStatusValSacrifice(arg_303_0)
	return arg_303_0._statusVal == BattleData.CardStatusVal.b2g_sacrifice or arg_303_0._statusVal == BattleData.CardStatusVal.b2g_oppo_sacrifice or arg_303_0._statusVal == BattleData.CardStatusVal.b2g_sync_sacrifice or arg_303_0._statusVal == BattleData.CardStatusVal.b2g_link_sacrifice or arg_303_0._statusVal == BattleData.CardStatusVal.b2g_summon_sacrifice
end

function var_0_0.isStatusValOppoSacrifice(arg_304_0)
	return arg_304_0._statusVal == BattleData.CardStatusVal.b2g_oppo_sacrifice
end

function var_0_0.isStatusValSummonSacrifice(arg_305_0)
	return arg_305_0._statusVal == BattleData.CardStatusVal.b2g_summon_sacrifice
end

function var_0_0.isStatusValSyncSacrifice(arg_306_0)
	return arg_306_0._statusVal == BattleData.CardStatusVal.b2g_sync_sacrifice
end

function var_0_0.isStatusValLinkSacrifice(arg_307_0)
	return arg_307_0._statusVal == BattleData.CardStatusVal.b2g_link_sacrifice
end

function var_0_0.isStatusValCost(arg_308_0)
	return arg_308_0._statusVal == BattleData.CardStatusVal.x2gl_cost or arg_308_0._statusVal == BattleData.CardStatusVal.x2gl_oppo_cost
end

function var_0_0.isStatusValDeal(arg_309_0)
	return arg_309_0._statusVal == BattleData.CardStatusVal.p2h_deal or arg_309_0._statusVal == BattleData.CardStatusVal.p2h_deal_show
end

function var_0_0.isStatusValLeaveTemp(arg_310_0)
	return arg_310_0._statusVal == BattleData.CardStatusVal.h2l_temp or arg_310_0._statusVal == BattleData.CardStatusVal.x2l_temp_oppo
end

function var_0_0.statusValToStr(arg_311_0)
	if arg_311_0:isStatusValCost() then
		return "[1]"
	elseif arg_311_0:isStatusValSacrifice() then
		return "[2]"
	end

	return ""
end

function var_0_0.needCostHpNianLi(arg_312_0)
	return not arg_312_0:isBindedSkill(7222)
end

local var_0_12 = {
	{
		10722,
		10723,
		10724,
		10725
	},
	{
		10777,
		10776,
		10775
	},
	{
		10817,
		10816
	},
	{
		10886,
		10885,
		10884
	},
	{
		10937,
		10936,
		10935
	},
	{
		10984,
		10983,
		10982
	}
}

function var_0_0.getLVInfo(arg_313_0)
	for iter_313_0 = 1, #var_0_12 do
		local var_313_0 = var_0_12[iter_313_0]

		for iter_313_1 = 1, #var_313_0 do
			if arg_313_0._infoId == var_313_0[iter_313_1] then
				return iter_313_0, iter_313_1
			end
		end
	end
end

local var_0_13 = {
	[20652] = 40299,
	[30001] = 40297,
	[30356] = 40298
}

function var_0_0.get4620InfoId(arg_314_0)
	return var_0_13[arg_314_0._infoId]
end

function var_0_0.getLink(arg_315_0)
	return arg_315_0._info._link and #arg_315_0._info._link or 1
end

function var_0_0.getCardLinkPos(arg_316_0)
	if arg_316_0._info._link == nil or arg_316_0._info._link[1] == 0 then
		return
	end

	for iter_316_0 = 1, #arg_316_0._info._link do
		local var_316_0 = BattleData.LINK_POS[arg_316_0._pos][arg_316_0._info._link[iter_316_0]]

		if var_316_0 > 0 then
			return var_316_0
		end
	end
end

function var_0_0.getCardEmptyLinkPosCount(arg_317_0)
	if arg_317_0._info._link == nil or arg_317_0._info._link[1] == 0 then
		return 0
	end

	local var_317_0 = 0

	for iter_317_0 = 1, #arg_317_0._info._link do
		local var_317_1 = BattleData.LINK_POS[arg_317_0._pos][arg_317_0._info._link[iter_317_0]]

		if var_317_1 > 0 and arg_317_0._owner:isLinkPosEmpty(var_317_1) then
			var_317_0 = var_317_0 + 1
		end
	end

	return var_317_0
end

function var_0_0.getCardEmptyLinkPos(arg_318_0)
	if arg_318_0._info._link == nil or arg_318_0._info._link[1] == 0 then
		return
	end

	for iter_318_0 = 1, #arg_318_0._info._link do
		local var_318_0 = BattleData.LINK_POS[arg_318_0._pos][arg_318_0._info._link[iter_318_0]]

		if var_318_0 > 0 and arg_318_0._owner:isLinkPosEmpty(var_318_0) then
			return var_318_0
		end
	end
end

function var_0_0.getCardEmptyOppoLinkPosCount(arg_319_0)
	if arg_319_0._info._link == nil or arg_319_0._info._link[1] == 0 then
		return 0
	end

	local var_319_0 = 0

	for iter_319_0 = 1, #arg_319_0._info._link do
		local var_319_1 = BattleData.LINK_POS[arg_319_0._pos][arg_319_0._info._link[iter_319_0]]

		if var_319_1 < 0 and arg_319_0._owner._opponent:isLinkPosEmpty(-var_319_1) then
			var_319_0 = var_319_0 + 1
		end
	end

	return var_319_0
end

function var_0_0.getCardEmptyOppoLinkPos(arg_320_0)
	if arg_320_0._info._link == nil or arg_320_0._info._link[1] == 0 then
		return
	end

	for iter_320_0 = 1, #arg_320_0._info._link do
		local var_320_0 = BattleData.LINK_POS[arg_320_0._pos][arg_320_0._info._link[iter_320_0]]

		if var_320_0 < 0 and arg_320_0._owner._opponent:isLinkPosEmpty(-var_320_0) then
			return -var_320_0
		end
	end
end

function var_0_0.isCardLinkPos(arg_321_0, arg_321_1)
	if arg_321_0._info._link == nil or arg_321_0._info._link[1] == 0 then
		return false
	end

	for iter_321_0 = 1, #arg_321_0._info._link do
		if BattleData.LINK_POS[arg_321_0._pos][arg_321_0._info._link[iter_321_0]] == arg_321_1 then
			return true
		end
	end

	return false
end

function var_0_0.isCardEmptyLinkPos(arg_322_0, arg_322_1)
	if arg_322_0._info._link == nil or arg_322_0._info._link[1] == 0 then
		return false
	end

	for iter_322_0 = 1, #arg_322_0._info._link do
		local var_322_0 = BattleData.LINK_POS[arg_322_0._pos][arg_322_0._info._link[iter_322_0]]

		if var_322_0 > 0 and var_322_0 == arg_322_1 and arg_322_0._owner:isLinkPosEmpty(var_322_0) then
			return true
		end

		if var_322_0 < 0 and var_322_0 == arg_322_1 and arg_322_0._owner._opponent:isLinkPosEmpty(-var_322_0) then
			return true
		end
	end

	return false
end

function var_0_0.getLinkedCards(arg_323_0, arg_323_1)
	local var_323_0 = {}

	if arg_323_0._info._link == nil or arg_323_0._info._link[1] == 0 then
		return var_323_0
	end

	arg_323_1 = arg_323_1 or 1

	for iter_323_0 = 1, #arg_323_0._info._link do
		local var_323_1 = BattleData.LINK_POS[arg_323_0._pos][arg_323_0._info._link[iter_323_0]]

		if (arg_323_1 == 1 or arg_323_1 == 3) and var_323_1 > 0 and arg_323_0._owner._boardCards[var_323_1] ~= nil then
			var_323_0[#var_323_0 + 1] = arg_323_0._owner._boardCards[var_323_1]
		end

		if (arg_323_1 == 2 or arg_323_1 == 3) and var_323_1 < 0 and arg_323_0._owner._opponent._boardCards[-var_323_1] ~= nil then
			var_323_0[#var_323_0 + 1] = arg_323_0._owner._opponent._boardCards[-var_323_1]
		end
	end

	return var_323_0
end

function var_0_0.getDoubleLinkedCards(arg_324_0, arg_324_1)
	local var_324_0 = {}

	if arg_324_0._info._link == nil or arg_324_0._info._link[1] == 0 then
		return var_324_0
	end

	arg_324_1 = arg_324_1 or 1

	for iter_324_0 = 1, #arg_324_0._info._link do
		local var_324_1 = BattleData.LINK_POS[arg_324_0._pos][arg_324_0._info._link[iter_324_0]]

		if (arg_324_1 == 1 or arg_324_1 == 3) and var_324_1 > 0 and arg_324_0._owner._boardCards[var_324_1] ~= nil and arg_324_0._owner._boardCards[var_324_1]:isCardLinkPos(arg_324_0._pos) then
			var_324_0[#var_324_0 + 1] = arg_324_0._owner._boardCards[var_324_1]
		end

		if (arg_324_1 == 2 or arg_324_1 == 3) and var_324_1 < 0 and arg_324_0._owner._opponent._boardCards[-var_324_1] ~= nil and arg_324_0._owner._opponent._boardCards[-var_324_1]:isCardLinkPos(-arg_324_0._pos) then
			var_324_0[#var_324_0 + 1] = arg_324_0._owner._opponent._boardCards[-var_324_1]
		end
	end

	return var_324_0
end

function var_0_0.isLinkedCard(arg_325_0, arg_325_1)
	if arg_325_1._info._link == nil or arg_325_1._info._link[1] == 0 then
		return false
	end

	for iter_325_0 = 1, #arg_325_1._info._link do
		local var_325_0 = BattleData.LINK_POS[arg_325_1._pos][arg_325_1._info._link[iter_325_0]]

		if var_325_0 > 0 and arg_325_1._owner == arg_325_0._owner and arg_325_1._owner._boardCards[var_325_0] == arg_325_0 then
			return true
		end

		if var_325_0 < 0 and arg_325_1._owner ~= arg_325_0._owner and arg_325_1._owner._opponent._boardCards[-var_325_0] == arg_325_0 then
			return true
		end
	end
end

function var_0_0.getDoubleLinkedCardsEmptyLinkPosCount(arg_326_0)
	local var_326_0 = 0
	local var_326_1 = arg_326_0:getDoubleLinkedCards()

	for iter_326_0 = 1, #var_326_1 do
		var_326_0 = var_326_0 + var_326_1[iter_326_0]:getCardEmptyLinkPosCount()
	end

	return var_326_0
end

function var_0_0.getDoubleLinkedCardsEmptyLinkPos(arg_327_0)
	local var_327_0 = arg_327_0:getDoubleLinkedCards()

	for iter_327_0 = 1, #var_327_0 do
		local var_327_1 = var_327_0[iter_327_0]:getCardEmptyLinkPos()

		if var_327_1 ~= nil then
			return var_327_1
		end
	end
end

function var_0_0.getDoubleLinkedCardsEmptyOppoLinkPosCount(arg_328_0)
	local var_328_0 = 0
	local var_328_1 = arg_328_0:getDoubleLinkedCards()

	for iter_328_0 = 1, #var_328_1 do
		var_328_0 = var_328_0 + var_328_1[iter_328_0]:getCardEmptyOppoLinkPosCount()
	end

	return var_328_0
end

function var_0_0.getDoubleLinkedCardsEmptyOppoLinkPos(arg_329_0)
	local var_329_0 = arg_329_0:getDoubleLinkedCards()

	for iter_329_0 = 1, #var_329_0 do
		local var_329_1 = var_329_0[iter_329_0]:getCardEmptyOppoLinkPos()

		if var_329_1 ~= nil then
			return var_329_1
		end
	end
end

function var_0_0.testSkills(arg_330_0)
	local var_330_0 = {}

	if arg_330_0:isMonsterRare() then
		var_330_0 = {}
	elseif arg_330_0._type == Data.CardType.magic then
		var_330_0 = {}
	elseif arg_330_0._type == Data.CardType.trap then
		var_330_0 = {}
	end

	for iter_330_0, iter_330_1 in ipairs(var_330_0) do
		local var_330_1 = false

		for iter_330_2 = 1, #arg_330_0._skills do
			if arg_330_0._skills[iter_330_2]._id == iter_330_1 then
				var_330_1 = true

				break
			end
		end

		if not var_330_1 then
			local var_330_2 = Data._skillInfo[iter_330_1]
			local var_330_3 = {
				_id = iter_330_1,
				_maxLevel = CardHelper.getSkillMaxLevel(iter_330_1),
				_modes = var_330_2._modes,
				_priority = var_330_2._priority,
				_count = var_330_2._count,
				_owner = arg_330_0
			}

			table.insert(arg_330_0._skills, var_330_3)
		end
	end
end

return var_0_0
