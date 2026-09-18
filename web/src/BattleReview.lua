json = require("json")

require("protobuf")
require("Data_pb")
require("Battle_pb")
require("extern")
require("Data")
require("CardHelper")
require("BattleData")
require("PlayerBattle")
require("BattleHelper")
require("BattleStaticHelper")
require("BattleSkill")
require("BattleStep")
require("BattleCondition")
require("BattleCard")
require("BattleCardStatus")
require("BattleEvent")
require("BattleAi")
require("BattleSkillCompiler")
require("BattleCombination")

bit = bit or bit32
bor = bit.bor
bnot = bit.bnot
band = bit.band
bxor = bit.bxor
blsh = bit.lshift
brsh = bit.rshift
lc = lc or {}
log = ""

function Str(arg_1_0)
	return arg_1_0 or 0
end

function lc.log(...)
	return
end

function lc.round(arg_3_0)
	return math.floor(arg_3_0 + 0.5)
end

function lc.clearTable(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		arg_4_0[iter_4_0] = nil
	end
end

function printLog(...)
	print("[LUA-print] " .. string.format(...))
end

function appendLog(...)
	log = log .. "[LUA-print] " .. string.format(...) .. "\r\n"
end

STR = {
	OPPONENT = "OPPONENT",
	FORTRESS = "FORTRESS",
	SELF = "SELF"
}
_M = Data
D = Data

function initData(arg_7_0)
	local var_7_0 = {
		"skill.bin",
		"monster.bin",
		"magic.bin",
		"trap.bin",
		"rare.bin",
		"condition.bin",
		"event.bin",
		"boss.bin",
		"level.bin"
	}

	for iter_7_0 = 1, #var_7_0 do
		local var_7_1 = var_7_0[iter_7_0]
		local var_7_2 = io.open(arg_7_0 .. "/res/" .. var_7_1, "rb")
		local var_7_3 = var_7_2:read("*a")

		var_7_2:close()

		local var_7_4 = "_" .. string.sub(var_7_1, 1, #var_7_1 - 4) .. "Info"

		Data[var_7_4] = dataparser.parseData(var_7_3, true)
	end
end

function _M.genInputFromResp(arg_8_0)
	local var_8_0 = {
		_type = arg_8_0.type,
		_timestamp = arg_8_0.timestamp,
		_copyId = arg_8_0.copy_id,
		_levelId = arg_8_0.level_id,
		_isOppoOnline = arg_8_0.is_op_online or false,
		_isAttacker = arg_8_0.is_attacker or false,
		_isWatcher = arg_8_0.is_watcher or false
	}

	var_8_0._player, var_8_0._opponent = {}, {}

	local var_8_1 = arg_8_0.player_troop.info or {}
	local var_8_2 = arg_8_0.opponent_troop.info or {}

	var_8_0._player._name, var_8_0._player._level, var_8_0._player._vip, var_8_0._player._avatar, var_8_0._player._region, var_8_0._player._regionId, var_8_0._player._privilege = var_8_1.name or "", var_8_1.level or 0, var_8_1.vip or 0, var_8_1.avatar or 0, var_8_1.rid, var_8_1.rid, var_8_1.privilege or 0
	var_8_0._player._avatarFrame, var_8_0._player._cardBackId = var_8_1.avatar_frame, var_8_1.card_back == 0 and Data.PropsId.card_back or var_8_1.card_back
	var_8_0._player._isNpc = var_8_1.is_npc
	var_8_0._opponent._name, var_8_0._opponent._level, var_8_0._opponent._vip, var_8_0._opponent._avatar, var_8_0._opponent._region, var_8_0._opponent._privilege = var_8_2.name or "", var_8_2.level or 0, var_8_2.vip or 0, var_8_2.avatar or 0, var_8_2.rid, var_8_2.privilege or 0
	var_8_0._opponent._avatarFrame, var_8_0._opponent._cardBackId = var_8_2.avatar_frame, var_8_2.card_back == 0 and Data.PropsId.card_back or var_8_2.card_back
	var_8_0._opponent._bossId = arg_8_0:HasField("boss_id") and arg_8_0.boss_id or 0
	var_8_0._opponent._isNpc = var_8_2.is_npc
	var_8_0._player._troopCards, var_8_0._opponent._troopCards = arg_8_0.player_troop.cards, arg_8_0.opponent_troop.cards
	var_8_0._player._troopLevels, var_8_0._opponent._troopLevels = arg_8_0.player_troop.levels, arg_8_0.opponent_troop.levels
	var_8_0._player._extraSkills, var_8_0._opponent._extraSkills = arg_8_0.player_troop.card_extra_skills, arg_8_0.opponent_troop.card_extra_skills
	var_8_0._player._troopSkins, var_8_0._opponent._troopSkins = arg_8_0.player_troop.skins, arg_8_0.opponent_troop.skins
	var_8_0._player._fortressHp, var_8_0._opponent._fortressHp = arg_8_0.player_troop.hp, arg_8_0.opponent_troop.hp
	var_8_0._player._trophy = var_8_1.trophy
	var_8_0._opponent._trophy = var_8_2.trophy
	var_8_0._player._idInRoom, var_8_0._opponent._idInRoom = arg_8_0.player_troop.id, arg_8_0.opponent_troop.id
	var_8_0._player._crown = nil

	if var_8_1:HasField("crown") then
		var_8_0._player._crown = {
			_infoId = var_8_1.crown.info_id,
			_num = var_8_1.crown.num
		}
	end

	var_8_0._opponent._crown = nil

	if var_8_2:HasField("crown") then
		var_8_0._opponent._crown = {
			_infoId = var_8_2.crown.info_id,
			_num = var_8_2.crown.num
		}
	end

	var_8_0._player._avatarFrameCount = 0

	if var_8_1:HasField("avatar_frame_count") then
		var_8_0._player._avatarFrameCount = var_8_1.avatar_frame_count
	end

	var_8_0._opponent._avatarFrameCount = 0

	if var_8_2:HasField("avatar_frame_count") then
		var_8_0._opponent._avatarFrameCount = var_8_2.avatar_frame_count
	end

	if #arg_8_0.player_used_cards > 0 then
		var_8_0._player._usedCards = {
			_hasTime = true
		}

		for iter_8_0, iter_8_1 in ipairs(arg_8_0.player_used_cards) do
			var_8_0._player._usedCards[iter_8_0] = iter_8_1
		end
	end

	if #arg_8_0.opponent_used_cards > 0 then
		var_8_0._opponent._usedCards = {
			_hasTime = true
		}

		for iter_8_2, iter_8_3 in ipairs(arg_8_0.opponent_used_cards) do
			var_8_0._opponent._usedCards[iter_8_2] = iter_8_3
		end
	end

	if #arg_8_0.random_seq > 0 then
		var_8_0._randomSeed = arg_8_0.random_seq[1]

		print("BATTLE RANDOM SEED   ", arg_8_0.random_seq[1])
	end

	var_8_0._ruleType = arg_8_0.rule_type

	return var_8_0
end

function _M.genInputFromAttackResp(arg_9_0)
	local var_9_0 = _M.genInputFromResp(arg_9_0)
	local var_9_1 = Data._levelInfo[var_9_0._levelId]

	if arg_9_0.type == Battle_pb.PB_BATTLE_NPC then
		var_9_0._battleType = Data.BattleType.npc
	elseif arg_9_0.type == Battle_pb.PB_BATTLE_PLAYER then
		var_9_0._battleType = Data.BattleType.PVP_revenge
	elseif arg_9_0.type == Battle_pb.PB_BATTLE_RESCUE then
		var_9_0._battleType = Data.BattleType.PVP_rescue
	elseif arg_9_0.type == Battle_pb.PB_BATTLE_MATCH then
		var_9_0._battleType = Data.BattleType.PVP_room
	elseif arg_9_0.type == Battle_pb.PB_BATTLE_MASSWAR_MULTIPLE then
		var_9_0._battleType = Data.BattleType.PVP_group
	elseif arg_9_0.type == Battle_pb.PB_BATTLE_DARK then
		var_9_0._battleType = Data.BattleType.PVP_dark
	elseif arg_9_0.type == Battle_pb.PB_BATTLE_SURVIVAL then
		var_9_0._battleType = Data.BattleType.PVP_survival
	elseif arg_9_0.type == Battle_pb.PB_BATTLE_SURVIVAL_EX then
		var_9_0._battleType = Data.BattleType.PVP_survival_ex
	elseif arg_9_0.type == Battle_pb.PB_BATTLE_WORLD_LEGEND then
		var_9_0._battleType = Data.BattleType.PVP_clash_ex
	else
		if arg_9_0.type == Battle_pb.PB_BATTLE_WORLD_BOSS then
			local var_9_2 = Data._troopInfo[var_9_1._opponentTroopID]
			local var_9_3

			for iter_9_0, iter_9_1 in ipairs(var_9_2._infoId) do
				if Data.getInfo(iter_9_1)._nature == Data.CardCountry.mo then
					var_9_0._worldBossId = iter_9_1

					break
				end
			end

			var_9_0._battleType = Data.BattleType.world_boss
		else
			var_9_0._battleType = Data.BattleType.task
		end

		var_9_0._opponent._name = Str(var_9_1._nameSid)
		var_9_0._opponent._level = 0
		var_9_0._condition = var_9_1._condition
		var_9_0._conditionValues = var_9_1._value
		var_9_0._eventIds = var_9_1._eventId
		var_9_0._oppoEventIds = var_9_1._oppoEventId

		if var_9_1._storyOppoUsedCards[1] > 0 and var_9_0._opponent._usedCards == nil then
			var_9_0._opponent._usedCards = var_9_1._storyOppoUsedCards
		end

		var_9_0._storyRound = var_9_1._storyRound
		var_9_0._storyName = Str(var_9_1._storyName)
	end

	return var_9_0
end

function _M.genInputFromChallengeResp(arg_10_0)
	local var_10_0 = _M.genInputFromResp(arg_10_0)
	local var_10_1 = Data._levelInfo[var_10_0._levelId]

	var_10_0._battleType = Data.BattleType.sweep
	var_10_0._opponent._name = Str(var_10_1._nameSid)
	var_10_0._condition = var_10_1._condition
	var_10_0._conditionValues = var_10_1._value
	var_10_0._eventIds = var_10_1._eventId
	var_10_0._oppoEventIds = var_10_1._oppoEventId
	var_10_0._storyRound = var_10_1._storyRound
	var_10_0._storyName = Str(var_10_1._storyName)

	return var_10_0
end

function _M.genInputFromFindStartResp(arg_11_0)
	local var_11_0 = _M.genInputFromResp(arg_11_0)

	var_11_0._sceneType = arg_11_0.opponent_troop.info.id % 4 + 1

	if arg_11_0:HasField("level_id") then
		var_11_0._battleType = Data.BattleType.PVP_revenge
		var_11_0._levelId = arg_11_0.level_id
	else
		var_11_0._battleType = Data.BattleType.PVP_trophy
	end

	return var_11_0
end

function _M.genInputFromActivityPvpResp(arg_12_0)
	local var_12_0 = _M.genInputFromResp(arg_12_0)

	var_12_0._battleType = arg_12_0.opponent_troop.info.id == 0 and Data.BattleType.PVP_clash_npc or Data.BattleType.PVP_clash

	local var_12_1 = Data._activityTaskInfo._pvp._param[4][1]

	var_12_0._eventIds = {
		var_12_1
	}
	var_12_0._oppoEventIds = {
		var_12_1
	}

	return var_12_0
end

function _M.genInputFromLadderPvpResp(arg_13_0)
	local var_13_0 = _M.genInputFromResp(arg_13_0)

	var_13_0._battleType = arg_13_0.opponent_troop.info.id == 0 and Data.BattleType.PVP_clash_npc or Data.BattleType.PVP_clash

	local var_13_1 = var_13_0._player._trophy
	local var_13_2 = var_13_0._opponent._trophy - var_13_1
	local var_13_3

	if var_13_0._battleType == Data.BattleType.PVP_clash_npc then
		var_13_3 = arg_13_0.npc_type + 1
	else
		var_13_3 = 5
	end

	var_13_0._clashOppoType = var_13_3

	return var_13_0
end

function _M.genInputFromMatchResp(arg_14_0)
	local var_14_0 = _M.genInputFromResp(arg_14_0)

	var_14_0._battleType = Data.BattleType.PVP_room

	return var_14_0
end

function _M.genInputFromSurvivalResp(arg_15_0)
	local var_15_0 = _M.genInputFromResp(arg_15_0)

	var_15_0._player._survivalTimeStamp = arg_15_0.player_timestamp / 1000
	var_15_0._opponent._survivalTimeStamp = arg_15_0.opponent_timestamp / 1000
	var_15_0._battleType = Data.BattleType.PVP_survival

	return var_15_0
end

function _M.genInputFromSurvivalExResp(arg_16_0)
	local var_16_0 = _M.genInputFromResp(arg_16_0)

	var_16_0._player._survivalTimeStamp = arg_16_0.player_timestamp / 1000
	var_16_0._opponent._survivalTimeStamp = arg_16_0.opponent_timestamp / 1000
	var_16_0._battleType = Data.BattleType.PVP_survival_ex

	return var_16_0
end

function _M.genInputFromGroupResp(arg_17_0)
	local var_17_0 = _M.genInputFromResp(arg_17_0)

	var_17_0._battleType = Data.BattleType.PVP_group

	return var_17_0
end

function _M.genInputFromDarkResp(arg_18_0)
	local var_18_0 = _M.genInputFromResp(arg_18_0)

	var_18_0._battleType = Data.BattleType.PVP_dark

	return var_18_0
end

function _M.genInputFromLadderExPvpResp(arg_19_0)
	local var_19_0 = _M.genInputFromResp(arg_19_0)

	var_19_0._battleType = arg_19_0.opponent_troop.info.id == 0 and Data.BattleType.PVP_ladder_npc or Data.BattleType.PVP_ladder

	return var_19_0
end

function _M.genInputFromExpeditionResp(arg_20_0, arg_20_1)
	local var_20_0 = _M.genInputFromResp(arg_20_0)

	var_20_0._battleType = Data.BattleType.copy_expedition

	return var_20_0
end

function _M.genInputFromExpeditionExResp(arg_21_0, arg_21_1)
	local var_21_0 = _M.genInputFromResp(arg_21_0)

	var_21_0._battleType = arg_21_0.type == Battle_pb.PB_BATTLE_EXPEDITION_EX_BOSS and Data.BattleType.expedition_ex_boss or Data.BattleType.expedition_ex

	return var_21_0
end

function _M.genInputFromBossResp(arg_22_0)
	local var_22_0 = _M.genInputFromResp(arg_22_0)
	local var_22_1 = Data._bossInfo[var_22_0._opponent._bossId]

	if var_22_0._opponent._bossId >= 101 and var_22_0._opponent._bossId <= 112 then
		var_22_0._opponent._bossLevel = P:getToadLevel(var_22_0._player._level)
	else
		var_22_0._opponent._bossLevel = 1
		var_22_0._opponent._isUnionBoss = true
		var_22_0._opponent._assistantHp = {}
	end

	var_22_0._opponent._name = Str(var_22_1._nameSid)
	var_22_0._opponent._level = var_22_0._opponent._bossLevel
	var_22_0._battleType = Data.BattleType.boss
	var_22_0._sceneType = var_22_1._sceneType

	_M.setBattleFromSceneId()

	return var_22_0
end

function _M.genInputFromRobExpResp(arg_23_0)
	local var_23_0 = _M.genInputFromResp(arg_23_0)

	var_23_0._battleType = Data.BattleType.copy_boss

	local var_23_1 = Data._copyInfo[var_23_0._copyId]

	var_23_0._opponent._name = Str(STR.TROOP_IMMUNITY_PHY)
	var_23_0._opponent._level = var_23_1._level

	return var_23_0
end

function _M.genInputFromLegendResp(arg_24_0)
	local var_24_0 = _M.genInputFromResp(arg_24_0)

	var_24_0._battleType = Data.BattleType.PVP_clash_ex

	return var_24_0
end

function battleReview(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = os.clock()

	if D._monsterInfo == nil then
		initData(arg_25_1)
	end

	local var_25_1 = Data_pb.BattleSpot()

	var_25_1:ParseFromString(arg_25_2)

	local var_25_2

	if var_25_1.type == Battle_pb.PB_BATTLE_CHAPTER or var_25_1.type == Battle_pb.PB_BATTLE_NPC or var_25_1.type == Battle_pb.PB_BATTLE_WORLD_BOSS then
		var_25_2 = _M.genInputFromAttackResp(var_25_1)
		var_25_2._replayingLog = nil
	elseif var_25_1.type == Battle_pb.PB_BATTLE_CITY then
		var_25_2 = _M.genInputFromChallengeResp(var_25_1)
		var_25_2._replayingLog = nil
	elseif var_25_1.type == Battle_pb.PB_BATTLE_EXP then
		var_25_2 = _M.genInputFromRobExpResp(var_25_1)
		var_25_2._replayingLog = nil
	elseif var_25_1.type == Battle_pb.PB_BATTLE_GOLD or var_25_1.type == Battle_pb.PB_BATTLE_UNION_BOSS then
		var_25_2 = _M.genInputFromBossResp(var_25_1)
		var_25_2._replayingLog = nil
	elseif var_25_1.type == Battle_pb.PB_BATTLE_EXPEDITION then
		var_25_2 = _M.genInputFromExpeditionResp(var_25_1)
		var_25_2._replayingLog = nil
	elseif var_25_1.type == Battle_pb.PB_BATTLE_EXPEDITION_EX or var_25_1.type == Battle_pb.PB_BATTLE_EXPEDITION_EX_BOSS then
		var_25_2 = _M.genInputFromExpeditionExResp(var_25_1)
		var_25_2._replayingLog = nil
	elseif var_25_1.type == Battle_pb.PB_BATTLE_WORLD_LADDER then
		var_25_2 = _M.genInputFromLadderPvpResp(var_25_1)
		var_25_2._replayingLog = _M._replayingLog
	elseif var_25_1.type == Battle_pb.PB_BATTLE_WORLD_LADDER_EX then
		var_25_2 = _M.genInputFromLadderExPvpResp(var_25_1)
		var_25_2._replayingLog = _M._replayingLog
	elseif var_25_1.type == Battle_pb.PB_BATTLE_MATCH then
		var_25_2 = _M.genInputFromMatchResp(var_25_1)
		var_25_2._replayingLog = _M._replayingLog
	elseif var_25_1.type == Battle_pb.PB_BATTLE_SURVIVAL then
		var_25_2 = _M.genInputFromSurvivalResp(var_25_1)
		var_25_2._replayingLog = _M._replayingLog
	elseif var_25_1.type == Battle_pb.PB_BATTLE_SURVIVAL_EX then
		var_25_2 = _M.genInputFromSurvivalExResp(var_25_1)
		var_25_2._replayingLog = _M._replayingLog
	elseif var_25_1.type == Battle_pb.PB_BATTLE_MASSWAR_MULTIPLE then
		var_25_2 = _M.genInputFromGroupResp(var_25_1)
		var_25_2._replayingLog = _M._replayingLog
	elseif var_25_1.type == Battle_pb.PB_BATTLE_DARK then
		var_25_2 = _M.genInputFromDarkResp(var_25_1)
		var_25_2._replayingLog = _M._replayingLog
	elseif var_25_1.type == Battle_pb.PB_BATTLE_WORLD_LEGEND then
		var_25_2 = _M.genInputFromLegendResp(var_25_1)
		var_25_2._replayingLog = _M._replayingLog
	else
		var_25_2 = _M.genInputFromResp(var_25_1)
		var_25_2._battleType = Data.BattleType.PVP_trophy
		var_25_2._sceneType = var_25_1.opponent_troop.info.id % 4 + 1
		var_25_2._replayingLog = _M._replayingLog
	end

	var_25_2._reviewType = arg_25_0

	if arg_25_0 == 1 then
		var_25_2._logFunc = printLog
	elseif arg_25_0 == 4 then
		var_25_2._logFunc = appendLog
	end

	lc.log = var_25_2._logFunc and var_25_2._logFunc or lc.log

	local var_25_3 = {}
	local var_25_4 = {}
	local var_25_5 = var_25_2._isAttacker and var_25_2._player or var_25_2._opponent
	local var_25_6 = var_25_2._isAttacker and var_25_2._opponent or var_25_2._player
	local var_25_7 = {
		_isAttacker = true,
		_randomSeed = var_25_2._randomSeed,
		_usedCards = var_25_5._usedCards or {},
		_fortressHp = var_25_5._fortressHp,
		_bossId = var_25_5._bossId,
		_bossLevel = var_25_5._bossLevel,
		_troopCards = var_25_5._troopCards,
		_troopLevels = var_25_5._troopLevels,
		_extraSkills = var_25_5._extraSkills,
		_events = var_25_2._events or {},
		_conditions = {
			_conditionIds = var_25_2._condition,
			_conditionValues = var_25_2._conditionValues
		},
		_storyRound = var_25_2._storyRound or 0,
		_storyRandom = var_25_3,
		_atkLevel = var_25_5._level,
		_fortressSkill = var_25_5._fortressSkill,
		_pvpSoldier = var_25_5._pvpSoldier,
		_battleType = var_25_2._battleType,
		_isNpc = var_25_5._isNpc
	}
	local var_25_8 = {
		_isAttacker = false,
		_randomSeed = var_25_2._randomSeed,
		_usedCards = var_25_6._usedCards or {},
		_fortressHp = var_25_6._fortressHp,
		_bossId = var_25_6._bossId,
		_bossLevel = var_25_6._bossLevel,
		_assistantHp = var_25_2._assistantHp,
		_troopCards = var_25_6._troopCards,
		_troopLevels = var_25_6._troopLevels,
		_extraSkills = var_25_6._extraSkills,
		_events = var_25_2._oppoEvents or {},
		_conditions = {},
		_storyRound = var_25_2._storyRound or 0,
		_storyRandom = var_25_4,
		_atkLevel = var_25_6._level,
		_fortressSkill = var_25_6._fortressSkill,
		_pvpSoldier = var_25_6._pvpSoldier,
		_battleType = var_25_2._battleType,
		_isNpc = var_25_6._isNpc
	}
	local var_25_9 = PlayerBattle.new(var_25_7)
	local var_25_10 = PlayerBattle.new(var_25_8)

	var_25_9._opponent, var_25_10._opponent = var_25_10, var_25_9
	PlayerBattle._randomSeed = PlayerBattle._originRandomSeed

	var_25_9:resetWhenBattleStart()
	var_25_10:resetWhenBattleStart()

	var_25_9._playerType = BattleData.PlayerType.replay
	var_25_10._playerType = BattleData.PlayerType.replay
	var_25_9._isReviewing = true
	var_25_10._isReviewing = true

	var_25_9:start()

	local var_25_11 = var_25_9:getResult()
	local var_25_12 = Data_pb.BattleResult()
	local var_25_13 = {
		var_25_9:getDestroyMonsterCount(0),
		var_25_9:getNormalSummonedMonsterCountLessThan4(),
		var_25_9:getNormalSummonedMonsterCountLargerThan5(),
		var_25_9:getSpecialSummonedMonsterCount(),
		var_25_9:getCastedMagicCount(),
		var_25_9:getCastedTrapCount(),
		var_25_9:getIsCheating() and 1 or 0,
		var_25_10._isRetreat and 1 or 0,
		var_25_9._isRetreat and 1 or 0
	}
	local var_25_14 = {
		var_25_10:getDestroyMonsterCount(0),
		var_25_10:getNormalSummonedMonsterCountLessThan4(),
		var_25_10:getNormalSummonedMonsterCountLargerThan5(),
		var_25_10:getSpecialSummonedMonsterCount(),
		var_25_10:getCastedMagicCount(),
		var_25_10:getCastedTrapCount(),
		var_25_10:getIsCheating() and 1 or 0,
		var_25_9._isRetreat and 1 or 0,
		var_25_10._isRetreat and 1 or 0
	}
	local var_25_15 = {}
	local var_25_16 = {}
	local var_25_17 = var_25_9:getResult()

	var_25_10:getResult()

	for iter_25_0 = 1001, 1100 do
		var_25_15[iter_25_0 - 1000] = var_25_9._battlePass[iter_25_0] or 0
	end

	for iter_25_1 = 1001, 1100 do
		var_25_16[iter_25_1 - 1000] = var_25_10._battlePass[iter_25_1] or 0
	end

	var_25_12.type = var_25_17
	var_25_12.round = var_25_9:getTotalRound()
	var_25_12.log = log
	var_25_12.damage = 0
	var_25_12.hp = 0
	var_25_12.atk_score = 0
	var_25_12.def_score = 0

	for iter_25_2, iter_25_3 in pairs(var_25_9._battleCondition:getTaskResult()) do
		var_25_12.task_result:append(iter_25_3)
	end

	for iter_25_4, iter_25_5 in ipairs(var_25_13) do
		var_25_12.attacker_stat:append(iter_25_5)
	end

	for iter_25_6, iter_25_7 in ipairs(var_25_14) do
		var_25_12.defender_stat:append(iter_25_7)
	end

	for iter_25_8, iter_25_9 in ipairs(var_25_15) do
		var_25_12.attacker_battle_pass:append(iter_25_9)
	end

	for iter_25_10, iter_25_11 in ipairs(var_25_16) do
		var_25_12.defender_battle_pass:append(iter_25_11)
	end

	print("-----------------------------------------------")
	print(string.format("Battle Review Result:\t%s(%d)", var_25_17 == 0 and "DRAW" or var_25_17 == 1 and "WIN" or "LOSE", var_25_9:getTotalRound()))
	print("Battle Review in Lua:", os.clock() - var_25_0)

	return var_25_12:SerializeToString()
end
