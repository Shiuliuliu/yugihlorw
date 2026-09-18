local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Battle_pb")

BATTLETYPE = var_0_0.EnumDescriptor()

local var_0_3 = {
	PB_BATTLE_PLAYER = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_CHAPTER = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_NPC = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_CITY = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_ELITE = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_COMMANDER = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_EXPEDITION = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_GOLD = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_FRIEND = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_UNION = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_EXP = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_RESCUE = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_WORLD = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_UNION_BOSS = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_WORLD_BOSS = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_WORLD_LADDER = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_WORLD_LADDER_EX = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_EXPEDITION_EX = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_EXPEDITION_EX_BOSS = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_MATCH = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_MASSWAR_MULTIPLE = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_DARK = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_SURVIVAL = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_SURVIVAL_EX = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_WORLD_LEGEND = var_0_0.EnumValueDescriptor()
}

BATTLEENDTYPE = var_0_0.EnumDescriptor()

local var_0_4 = {
	PB_BATTLE_END_LOSE = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_END_WIN = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_END_DRAW = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_END_TERMINAL = var_0_0.EnumValueDescriptor()
}

DARKDUELBATTLEENDTYPE = var_0_0.EnumDescriptor()

local var_0_5 = {
	PB_BATTLE_DDEND_TWOONE_WIN = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_DDEND_ONETWO_LOSE = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_DDEND_TWOZERO_WIN = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_DDEND_ZEROTWO_LOSE = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_DDEND_ONEZERO_WIN = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_DDEND_ZEROONE_LOSE = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_DDEND_DRAW = var_0_0.EnumValueDescriptor(),
	PB_BATTLE_DDNOTEND = var_0_0.EnumValueDescriptor()
}

BATTLEEXPEND = var_0_0.Descriptor()

local var_0_6 = {
	HERO_FIELD = var_0_0.FieldDescriptor(),
	HORSE_FIELD = var_0_0.FieldDescriptor(),
	BOOK_FIELD = var_0_0.FieldDescriptor(),
	SOLDIER_FIELD = var_0_0.FieldDescriptor()
}

BATTLELOG = var_0_0.Descriptor()

local var_0_7 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	PLAYER_INFO_FIELD = var_0_0.FieldDescriptor(),
	OPPONENT_INFO_FIELD = var_0_0.FieldDescriptor(),
	REPLAY_ID_FIELD = var_0_0.FieldDescriptor(),
	RESULT_TYPE_FIELD = var_0_0.FieldDescriptor(),
	IS_AVAILABLE_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	LOOT_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor(),
	CITY_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_TYPE_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_EX_FIELD = var_0_0.FieldDescriptor(),
	CREATOR_FIELD = var_0_0.FieldDescriptor()
}

BATTLESHARE = var_0_0.Descriptor()

local var_0_8 = {
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	LOG_FIELD = var_0_0.FieldDescriptor(),
	IS_ATTACK_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	TEXT_FIELD = var_0_0.FieldDescriptor(),
	ROUND_FIELD = var_0_0.FieldDescriptor(),
	THUMBS_UP_FIELD = var_0_0.FieldDescriptor(),
	WATCHED_FIELD = var_0_0.FieldDescriptor()
}

BATTLEBOSS = var_0_0.Descriptor()

local var_0_9 = {
	DAMAGE_FIELD = var_0_0.FieldDescriptor(),
	HP_FIELD = var_0_0.FieldDescriptor(),
	EXTRA_GOLD_FIELD = var_0_0.FieldDescriptor(),
	ASSISTANT_DAMAGE_FIELD = var_0_0.FieldDescriptor()
}

BATTLETUTORIAL = var_0_0.Descriptor()

local var_0_10 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	CITY_CHAPTER_ID_FIELD = var_0_0.FieldDescriptor(),
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	REPLAY_ID_FIELD = var_0_0.FieldDescriptor(),
	POWER_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

BATTLESHAREEVENT = var_0_0.Descriptor()

local var_0_11 = {
	LOG_ID_FIELD = var_0_0.FieldDescriptor(),
	USER_ID_FIELD = var_0_0.FieldDescriptor()
}

BATTLESHAREREQ = var_0_0.Descriptor()

local var_0_12 = {
	LOG_ID_FIELD = var_0_0.FieldDescriptor(),
	TEXT_FIELD = var_0_0.FieldDescriptor()
}

BATTLELOGRESP = var_0_0.Descriptor()

local var_0_13 = {
	ATTACK_LOG_FIELD = var_0_0.FieldDescriptor(),
	DEFEND_LOG_FIELD = var_0_0.FieldDescriptor()
}

DARKDUELBATTLEENDRESP = var_0_0.Descriptor()

local var_0_14 = {
	SCORE_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_END_TYPE_FIELD = var_0_0.FieldDescriptor(),
	WIN_FIELD = var_0_0.FieldDescriptor(),
	LOSE_FIELD = var_0_0.FieldDescriptor(),
	INNING_FIELD = var_0_0.FieldDescriptor(),
	LOCAL_ID_FIELD = var_0_0.FieldDescriptor()
}

BATTLEENDRESP = var_0_0.Descriptor()

local var_0_15 = {
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	RESOURCE_FIELD = var_0_0.FieldDescriptor(),
	LOG_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor(),
	CITY_FIELD = var_0_0.FieldDescriptor(),
	ATK_EXPEND_FIELD = var_0_0.FieldDescriptor(),
	DEF_EXPEND_FIELD = var_0_0.FieldDescriptor(),
	TASK_RESULT_FIELD = var_0_0.FieldDescriptor(),
	RANK1_FIELD = var_0_0.FieldDescriptor(),
	RANK2_FIELD = var_0_0.FieldDescriptor(),
	BOSS_FIELD = var_0_0.FieldDescriptor(),
	SCORE_FIELD = var_0_0.FieldDescriptor(),
	GRADE_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_EX_FIELD = var_0_0.FieldDescriptor(),
	PARAM_FIELD = var_0_0.FieldDescriptor(),
	LADDER_EX_WIN_FIELD = var_0_0.FieldDescriptor(),
	STAT_FIELD = var_0_0.FieldDescriptor(),
	MASS_WAR_SCORE_FIELD = var_0_0.FieldDescriptor(),
	DARK_DUEL_END_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_PASS_FIELD = var_0_0.FieldDescriptor()
}

BATTLELADDERRESP = var_0_0.Descriptor()

local var_0_16 = {
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	PVP_ID_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_ID_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_TYPE_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor(),
	MASS_WAR_SCORE_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_UP_FIELD = var_0_0.FieldDescriptor()
}

BATTLELOGEXRESP = var_0_0.Descriptor()

local var_0_17 = {
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	LOGS_FIELD = var_0_0.FieldDescriptor()
}

SGLBATTLEMSG = var_0_0.Descriptor()

local var_0_18 = {
	BATTLE_END_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_USECARD_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_OP_USECARD_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_REPLAY_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_START_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_SHARE_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_CHAT_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_TUTORIAL_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_LOG_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_AGAIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_REPLAY_TUTORIAL_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_THUMBS_UP_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_REPLAY_SHARE_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_LOG_EX_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_SET_MATCH_HP_REQ_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_END_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_LOG_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_REPLAY_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_SHARE_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_RECOVER_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_OP_USECARD_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_CHAT_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_TUTORIAL_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_THUMBS_UP_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_SHARE_WATCH_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_LOG_EX_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_LADDER_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.PB_BATTLE_PLAYER.name = "PB_BATTLE_PLAYER"
var_0_3.PB_BATTLE_PLAYER.index = 0
var_0_3.PB_BATTLE_PLAYER.number = 1
var_0_3.PB_BATTLE_CHAPTER.name = "PB_BATTLE_CHAPTER"
var_0_3.PB_BATTLE_CHAPTER.index = 1
var_0_3.PB_BATTLE_CHAPTER.number = 2
var_0_3.PB_BATTLE_NPC.name = "PB_BATTLE_NPC"
var_0_3.PB_BATTLE_NPC.index = 2
var_0_3.PB_BATTLE_NPC.number = 3
var_0_3.PB_BATTLE_CITY.name = "PB_BATTLE_CITY"
var_0_3.PB_BATTLE_CITY.index = 3
var_0_3.PB_BATTLE_CITY.number = 4
var_0_3.PB_BATTLE_ELITE.name = "PB_BATTLE_ELITE"
var_0_3.PB_BATTLE_ELITE.index = 4
var_0_3.PB_BATTLE_ELITE.number = 5
var_0_3.PB_BATTLE_COMMANDER.name = "PB_BATTLE_COMMANDER"
var_0_3.PB_BATTLE_COMMANDER.index = 5
var_0_3.PB_BATTLE_COMMANDER.number = 6
var_0_3.PB_BATTLE_EXPEDITION.name = "PB_BATTLE_EXPEDITION"
var_0_3.PB_BATTLE_EXPEDITION.index = 6
var_0_3.PB_BATTLE_EXPEDITION.number = 7
var_0_3.PB_BATTLE_GOLD.name = "PB_BATTLE_GOLD"
var_0_3.PB_BATTLE_GOLD.index = 7
var_0_3.PB_BATTLE_GOLD.number = 8
var_0_3.PB_BATTLE_FRIEND.name = "PB_BATTLE_FRIEND"
var_0_3.PB_BATTLE_FRIEND.index = 8
var_0_3.PB_BATTLE_FRIEND.number = 9
var_0_3.PB_BATTLE_UNION.name = "PB_BATTLE_UNION"
var_0_3.PB_BATTLE_UNION.index = 9
var_0_3.PB_BATTLE_UNION.number = 10
var_0_3.PB_BATTLE_EXP.name = "PB_BATTLE_EXP"
var_0_3.PB_BATTLE_EXP.index = 10
var_0_3.PB_BATTLE_EXP.number = 11
var_0_3.PB_BATTLE_RESCUE.name = "PB_BATTLE_RESCUE"
var_0_3.PB_BATTLE_RESCUE.index = 11
var_0_3.PB_BATTLE_RESCUE.number = 12
var_0_3.PB_BATTLE_WORLD.name = "PB_BATTLE_WORLD"
var_0_3.PB_BATTLE_WORLD.index = 12
var_0_3.PB_BATTLE_WORLD.number = 13
var_0_3.PB_BATTLE_UNION_BOSS.name = "PB_BATTLE_UNION_BOSS"
var_0_3.PB_BATTLE_UNION_BOSS.index = 13
var_0_3.PB_BATTLE_UNION_BOSS.number = 14
var_0_3.PB_BATTLE_WORLD_BOSS.name = "PB_BATTLE_WORLD_BOSS"
var_0_3.PB_BATTLE_WORLD_BOSS.index = 14
var_0_3.PB_BATTLE_WORLD_BOSS.number = 15
var_0_3.PB_BATTLE_WORLD_LADDER.name = "PB_BATTLE_WORLD_LADDER"
var_0_3.PB_BATTLE_WORLD_LADDER.index = 15
var_0_3.PB_BATTLE_WORLD_LADDER.number = 16
var_0_3.PB_BATTLE_WORLD_LADDER_EX.name = "PB_BATTLE_WORLD_LADDER_EX"
var_0_3.PB_BATTLE_WORLD_LADDER_EX.index = 16
var_0_3.PB_BATTLE_WORLD_LADDER_EX.number = 17
var_0_3.PB_BATTLE_EXPEDITION_EX.name = "PB_BATTLE_EXPEDITION_EX"
var_0_3.PB_BATTLE_EXPEDITION_EX.index = 17
var_0_3.PB_BATTLE_EXPEDITION_EX.number = 18
var_0_3.PB_BATTLE_EXPEDITION_EX_BOSS.name = "PB_BATTLE_EXPEDITION_EX_BOSS"
var_0_3.PB_BATTLE_EXPEDITION_EX_BOSS.index = 18
var_0_3.PB_BATTLE_EXPEDITION_EX_BOSS.number = 19
var_0_3.PB_BATTLE_MATCH.name = "PB_BATTLE_MATCH"
var_0_3.PB_BATTLE_MATCH.index = 19
var_0_3.PB_BATTLE_MATCH.number = 20
var_0_3.PB_BATTLE_MASSWAR_MULTIPLE.name = "PB_BATTLE_MASSWAR_MULTIPLE"
var_0_3.PB_BATTLE_MASSWAR_MULTIPLE.index = 20
var_0_3.PB_BATTLE_MASSWAR_MULTIPLE.number = 21
var_0_3.PB_BATTLE_DARK.name = "PB_BATTLE_DARK"
var_0_3.PB_BATTLE_DARK.index = 21
var_0_3.PB_BATTLE_DARK.number = 22
var_0_3.PB_BATTLE_SURVIVAL.name = "PB_BATTLE_SURVIVAL"
var_0_3.PB_BATTLE_SURVIVAL.index = 22
var_0_3.PB_BATTLE_SURVIVAL.number = 23
var_0_3.PB_BATTLE_SURVIVAL_EX.name = "PB_BATTLE_SURVIVAL_EX"
var_0_3.PB_BATTLE_SURVIVAL_EX.index = 23
var_0_3.PB_BATTLE_SURVIVAL_EX.number = 24
var_0_3.PB_BATTLE_WORLD_LEGEND.name = "PB_BATTLE_WORLD_LEGEND"
var_0_3.PB_BATTLE_WORLD_LEGEND.index = 24
var_0_3.PB_BATTLE_WORLD_LEGEND.number = 25
BATTLETYPE.name = "BattleType"
BATTLETYPE.full_name = ".sgland.BattleType"
BATTLETYPE.values = {
	var_0_3.PB_BATTLE_PLAYER,
	var_0_3.PB_BATTLE_CHAPTER,
	var_0_3.PB_BATTLE_NPC,
	var_0_3.PB_BATTLE_CITY,
	var_0_3.PB_BATTLE_ELITE,
	var_0_3.PB_BATTLE_COMMANDER,
	var_0_3.PB_BATTLE_EXPEDITION,
	var_0_3.PB_BATTLE_GOLD,
	var_0_3.PB_BATTLE_FRIEND,
	var_0_3.PB_BATTLE_UNION,
	var_0_3.PB_BATTLE_EXP,
	var_0_3.PB_BATTLE_RESCUE,
	var_0_3.PB_BATTLE_WORLD,
	var_0_3.PB_BATTLE_UNION_BOSS,
	var_0_3.PB_BATTLE_WORLD_BOSS,
	var_0_3.PB_BATTLE_WORLD_LADDER,
	var_0_3.PB_BATTLE_WORLD_LADDER_EX,
	var_0_3.PB_BATTLE_EXPEDITION_EX,
	var_0_3.PB_BATTLE_EXPEDITION_EX_BOSS,
	var_0_3.PB_BATTLE_MATCH,
	var_0_3.PB_BATTLE_MASSWAR_MULTIPLE,
	var_0_3.PB_BATTLE_DARK,
	var_0_3.PB_BATTLE_SURVIVAL,
	var_0_3.PB_BATTLE_SURVIVAL_EX,
	var_0_3.PB_BATTLE_WORLD_LEGEND
}
var_0_4.PB_BATTLE_END_LOSE.name = "PB_BATTLE_END_LOSE"
var_0_4.PB_BATTLE_END_LOSE.index = 0
var_0_4.PB_BATTLE_END_LOSE.number = -1
var_0_4.PB_BATTLE_END_WIN.name = "PB_BATTLE_END_WIN"
var_0_4.PB_BATTLE_END_WIN.index = 1
var_0_4.PB_BATTLE_END_WIN.number = 1
var_0_4.PB_BATTLE_END_DRAW.name = "PB_BATTLE_END_DRAW"
var_0_4.PB_BATTLE_END_DRAW.index = 2
var_0_4.PB_BATTLE_END_DRAW.number = 0
var_0_4.PB_BATTLE_END_TERMINAL.name = "PB_BATTLE_END_TERMINAL"
var_0_4.PB_BATTLE_END_TERMINAL.index = 3
var_0_4.PB_BATTLE_END_TERMINAL.number = 2
BATTLEENDTYPE.name = "BattleEndType"
BATTLEENDTYPE.full_name = ".sgland.BattleEndType"
BATTLEENDTYPE.values = {
	var_0_4.PB_BATTLE_END_LOSE,
	var_0_4.PB_BATTLE_END_WIN,
	var_0_4.PB_BATTLE_END_DRAW,
	var_0_4.PB_BATTLE_END_TERMINAL
}
var_0_5.PB_BATTLE_DDEND_TWOONE_WIN.name = "PB_BATTLE_DDEND_TWOONE_WIN"
var_0_5.PB_BATTLE_DDEND_TWOONE_WIN.index = 0
var_0_5.PB_BATTLE_DDEND_TWOONE_WIN.number = 1
var_0_5.PB_BATTLE_DDEND_ONETWO_LOSE.name = "PB_BATTLE_DDEND_ONETWO_LOSE"
var_0_5.PB_BATTLE_DDEND_ONETWO_LOSE.index = 1
var_0_5.PB_BATTLE_DDEND_ONETWO_LOSE.number = 2
var_0_5.PB_BATTLE_DDEND_TWOZERO_WIN.name = "PB_BATTLE_DDEND_TWOZERO_WIN"
var_0_5.PB_BATTLE_DDEND_TWOZERO_WIN.index = 2
var_0_5.PB_BATTLE_DDEND_TWOZERO_WIN.number = 3
var_0_5.PB_BATTLE_DDEND_ZEROTWO_LOSE.name = "PB_BATTLE_DDEND_ZEROTWO_LOSE"
var_0_5.PB_BATTLE_DDEND_ZEROTWO_LOSE.index = 3
var_0_5.PB_BATTLE_DDEND_ZEROTWO_LOSE.number = 4
var_0_5.PB_BATTLE_DDEND_ONEZERO_WIN.name = "PB_BATTLE_DDEND_ONEZERO_WIN"
var_0_5.PB_BATTLE_DDEND_ONEZERO_WIN.index = 4
var_0_5.PB_BATTLE_DDEND_ONEZERO_WIN.number = 5
var_0_5.PB_BATTLE_DDEND_ZEROONE_LOSE.name = "PB_BATTLE_DDEND_ZEROONE_LOSE"
var_0_5.PB_BATTLE_DDEND_ZEROONE_LOSE.index = 5
var_0_5.PB_BATTLE_DDEND_ZEROONE_LOSE.number = 6
var_0_5.PB_BATTLE_DDEND_DRAW.name = "PB_BATTLE_DDEND_DRAW"
var_0_5.PB_BATTLE_DDEND_DRAW.index = 6
var_0_5.PB_BATTLE_DDEND_DRAW.number = 7
var_0_5.PB_BATTLE_DDNOTEND.name = "PB_BATTLE_DDNOTEND"
var_0_5.PB_BATTLE_DDNOTEND.index = 7
var_0_5.PB_BATTLE_DDNOTEND.number = 8
DARKDUELBATTLEENDTYPE.name = "DarkDuelBattleEndType"
DARKDUELBATTLEENDTYPE.full_name = ".sgland.DarkDuelBattleEndType"
DARKDUELBATTLEENDTYPE.values = {
	var_0_5.PB_BATTLE_DDEND_TWOONE_WIN,
	var_0_5.PB_BATTLE_DDEND_ONETWO_LOSE,
	var_0_5.PB_BATTLE_DDEND_TWOZERO_WIN,
	var_0_5.PB_BATTLE_DDEND_ZEROTWO_LOSE,
	var_0_5.PB_BATTLE_DDEND_ONEZERO_WIN,
	var_0_5.PB_BATTLE_DDEND_ZEROONE_LOSE,
	var_0_5.PB_BATTLE_DDEND_DRAW,
	var_0_5.PB_BATTLE_DDNOTEND
}
var_0_6.HERO_FIELD.name = "hero"
var_0_6.HERO_FIELD.full_name = ".sgland.BattleExpend.hero"
var_0_6.HERO_FIELD.number = 1
var_0_6.HERO_FIELD.index = 0
var_0_6.HERO_FIELD.label = 3
var_0_6.HERO_FIELD.has_default_value = false
var_0_6.HERO_FIELD.default_value = {}
var_0_6.HERO_FIELD.type = 5
var_0_6.HERO_FIELD.cpp_type = 1
var_0_6.HORSE_FIELD.name = "horse"
var_0_6.HORSE_FIELD.full_name = ".sgland.BattleExpend.horse"
var_0_6.HORSE_FIELD.number = 2
var_0_6.HORSE_FIELD.index = 1
var_0_6.HORSE_FIELD.label = 3
var_0_6.HORSE_FIELD.has_default_value = false
var_0_6.HORSE_FIELD.default_value = {}
var_0_6.HORSE_FIELD.type = 5
var_0_6.HORSE_FIELD.cpp_type = 1
var_0_6.BOOK_FIELD.name = "book"
var_0_6.BOOK_FIELD.full_name = ".sgland.BattleExpend.book"
var_0_6.BOOK_FIELD.number = 3
var_0_6.BOOK_FIELD.index = 2
var_0_6.BOOK_FIELD.label = 3
var_0_6.BOOK_FIELD.has_default_value = false
var_0_6.BOOK_FIELD.default_value = {}
var_0_6.BOOK_FIELD.type = 5
var_0_6.BOOK_FIELD.cpp_type = 1
var_0_6.SOLDIER_FIELD.name = "soldier"
var_0_6.SOLDIER_FIELD.full_name = ".sgland.BattleExpend.soldier"
var_0_6.SOLDIER_FIELD.number = 4
var_0_6.SOLDIER_FIELD.index = 3
var_0_6.SOLDIER_FIELD.label = 3
var_0_6.SOLDIER_FIELD.has_default_value = false
var_0_6.SOLDIER_FIELD.default_value = {}
var_0_6.SOLDIER_FIELD.type = 5
var_0_6.SOLDIER_FIELD.cpp_type = 1
BATTLEEXPEND.name = "BattleExpend"
BATTLEEXPEND.full_name = ".sgland.BattleExpend"
BATTLEEXPEND.nested_types = {}
BATTLEEXPEND.enum_types = {}
BATTLEEXPEND.fields = {
	var_0_6.HERO_FIELD,
	var_0_6.HORSE_FIELD,
	var_0_6.BOOK_FIELD,
	var_0_6.SOLDIER_FIELD
}
BATTLEEXPEND.is_extendable = false
BATTLEEXPEND.extensions = {}
var_0_7.ID_FIELD.name = "id"
var_0_7.ID_FIELD.full_name = ".sgland.BattleLog.id"
var_0_7.ID_FIELD.number = 1
var_0_7.ID_FIELD.index = 0
var_0_7.ID_FIELD.label = 2
var_0_7.ID_FIELD.has_default_value = false
var_0_7.ID_FIELD.default_value = 0
var_0_7.ID_FIELD.type = 3
var_0_7.ID_FIELD.cpp_type = 2
var_0_7.PLAYER_INFO_FIELD.name = "player_info"
var_0_7.PLAYER_INFO_FIELD.full_name = ".sgland.BattleLog.player_info"
var_0_7.PLAYER_INFO_FIELD.number = 2
var_0_7.PLAYER_INFO_FIELD.index = 1
var_0_7.PLAYER_INFO_FIELD.label = 2
var_0_7.PLAYER_INFO_FIELD.has_default_value = false
var_0_7.PLAYER_INFO_FIELD.default_value = nil
var_0_7.PLAYER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_7.PLAYER_INFO_FIELD.type = 11
var_0_7.PLAYER_INFO_FIELD.cpp_type = 10
var_0_7.OPPONENT_INFO_FIELD.name = "opponent_info"
var_0_7.OPPONENT_INFO_FIELD.full_name = ".sgland.BattleLog.opponent_info"
var_0_7.OPPONENT_INFO_FIELD.number = 3
var_0_7.OPPONENT_INFO_FIELD.index = 2
var_0_7.OPPONENT_INFO_FIELD.label = 2
var_0_7.OPPONENT_INFO_FIELD.has_default_value = false
var_0_7.OPPONENT_INFO_FIELD.default_value = nil
var_0_7.OPPONENT_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_7.OPPONENT_INFO_FIELD.type = 11
var_0_7.OPPONENT_INFO_FIELD.cpp_type = 10
var_0_7.REPLAY_ID_FIELD.name = "replay_id"
var_0_7.REPLAY_ID_FIELD.full_name = ".sgland.BattleLog.replay_id"
var_0_7.REPLAY_ID_FIELD.number = 4
var_0_7.REPLAY_ID_FIELD.index = 3
var_0_7.REPLAY_ID_FIELD.label = 2
var_0_7.REPLAY_ID_FIELD.has_default_value = false
var_0_7.REPLAY_ID_FIELD.default_value = 0
var_0_7.REPLAY_ID_FIELD.type = 3
var_0_7.REPLAY_ID_FIELD.cpp_type = 2
var_0_7.RESULT_TYPE_FIELD.name = "result_type"
var_0_7.RESULT_TYPE_FIELD.full_name = ".sgland.BattleLog.result_type"
var_0_7.RESULT_TYPE_FIELD.number = 5
var_0_7.RESULT_TYPE_FIELD.index = 4
var_0_7.RESULT_TYPE_FIELD.label = 2
var_0_7.RESULT_TYPE_FIELD.has_default_value = false
var_0_7.RESULT_TYPE_FIELD.default_value = 0
var_0_7.RESULT_TYPE_FIELD.type = 5
var_0_7.RESULT_TYPE_FIELD.cpp_type = 1
var_0_7.IS_AVAILABLE_FIELD.name = "is_available"
var_0_7.IS_AVAILABLE_FIELD.full_name = ".sgland.BattleLog.is_available"
var_0_7.IS_AVAILABLE_FIELD.number = 6
var_0_7.IS_AVAILABLE_FIELD.index = 5
var_0_7.IS_AVAILABLE_FIELD.label = 2
var_0_7.IS_AVAILABLE_FIELD.has_default_value = false
var_0_7.IS_AVAILABLE_FIELD.default_value = false
var_0_7.IS_AVAILABLE_FIELD.type = 8
var_0_7.IS_AVAILABLE_FIELD.cpp_type = 7
var_0_7.TIMESTAMP_FIELD.name = "timestamp"
var_0_7.TIMESTAMP_FIELD.full_name = ".sgland.BattleLog.timestamp"
var_0_7.TIMESTAMP_FIELD.number = 7
var_0_7.TIMESTAMP_FIELD.index = 6
var_0_7.TIMESTAMP_FIELD.label = 2
var_0_7.TIMESTAMP_FIELD.has_default_value = false
var_0_7.TIMESTAMP_FIELD.default_value = 0
var_0_7.TIMESTAMP_FIELD.type = 3
var_0_7.TIMESTAMP_FIELD.cpp_type = 2
var_0_7.LOOT_FIELD.name = "loot"
var_0_7.LOOT_FIELD.full_name = ".sgland.BattleLog.loot"
var_0_7.LOOT_FIELD.number = 8
var_0_7.LOOT_FIELD.index = 7
var_0_7.LOOT_FIELD.label = 1
var_0_7.LOOT_FIELD.has_default_value = false
var_0_7.LOOT_FIELD.default_value = 0
var_0_7.LOOT_FIELD.type = 5
var_0_7.LOOT_FIELD.cpp_type = 1
var_0_7.TROPHY_FIELD.name = "trophy"
var_0_7.TROPHY_FIELD.full_name = ".sgland.BattleLog.trophy"
var_0_7.TROPHY_FIELD.number = 9
var_0_7.TROPHY_FIELD.index = 8
var_0_7.TROPHY_FIELD.label = 1
var_0_7.TROPHY_FIELD.has_default_value = false
var_0_7.TROPHY_FIELD.default_value = 0
var_0_7.TROPHY_FIELD.type = 5
var_0_7.TROPHY_FIELD.cpp_type = 1
var_0_7.CITY_FIELD.name = "city"
var_0_7.CITY_FIELD.full_name = ".sgland.BattleLog.city"
var_0_7.CITY_FIELD.number = 10
var_0_7.CITY_FIELD.index = 9
var_0_7.CITY_FIELD.label = 1
var_0_7.CITY_FIELD.has_default_value = false
var_0_7.CITY_FIELD.default_value = 0
var_0_7.CITY_FIELD.type = 5
var_0_7.CITY_FIELD.cpp_type = 1
var_0_7.BATTLE_TYPE_FIELD.name = "battle_type"
var_0_7.BATTLE_TYPE_FIELD.full_name = ".sgland.BattleLog.battle_type"
var_0_7.BATTLE_TYPE_FIELD.number = 11
var_0_7.BATTLE_TYPE_FIELD.index = 10
var_0_7.BATTLE_TYPE_FIELD.label = 2
var_0_7.BATTLE_TYPE_FIELD.has_default_value = false
var_0_7.BATTLE_TYPE_FIELD.default_value = 0
var_0_7.BATTLE_TYPE_FIELD.type = 5
var_0_7.BATTLE_TYPE_FIELD.cpp_type = 1
var_0_7.TROPHY_EX_FIELD.name = "trophy_ex"
var_0_7.TROPHY_EX_FIELD.full_name = ".sgland.BattleLog.trophy_ex"
var_0_7.TROPHY_EX_FIELD.number = 12
var_0_7.TROPHY_EX_FIELD.index = 11
var_0_7.TROPHY_EX_FIELD.label = 1
var_0_7.TROPHY_EX_FIELD.has_default_value = false
var_0_7.TROPHY_EX_FIELD.default_value = 0
var_0_7.TROPHY_EX_FIELD.type = 5
var_0_7.TROPHY_EX_FIELD.cpp_type = 1
var_0_7.CREATOR_FIELD.name = "creator"
var_0_7.CREATOR_FIELD.full_name = ".sgland.BattleLog.creator"
var_0_7.CREATOR_FIELD.number = 13
var_0_7.CREATOR_FIELD.index = 12
var_0_7.CREATOR_FIELD.label = 1
var_0_7.CREATOR_FIELD.has_default_value = false
var_0_7.CREATOR_FIELD.default_value = 0
var_0_7.CREATOR_FIELD.type = 3
var_0_7.CREATOR_FIELD.cpp_type = 2
BATTLELOG.name = "BattleLog"
BATTLELOG.full_name = ".sgland.BattleLog"
BATTLELOG.nested_types = {}
BATTLELOG.enum_types = {}
BATTLELOG.fields = {
	var_0_7.ID_FIELD,
	var_0_7.PLAYER_INFO_FIELD,
	var_0_7.OPPONENT_INFO_FIELD,
	var_0_7.REPLAY_ID_FIELD,
	var_0_7.RESULT_TYPE_FIELD,
	var_0_7.IS_AVAILABLE_FIELD,
	var_0_7.TIMESTAMP_FIELD,
	var_0_7.LOOT_FIELD,
	var_0_7.TROPHY_FIELD,
	var_0_7.CITY_FIELD,
	var_0_7.BATTLE_TYPE_FIELD,
	var_0_7.TROPHY_EX_FIELD,
	var_0_7.CREATOR_FIELD
}
BATTLELOG.is_extendable = false
BATTLELOG.extensions = {}
var_0_8.USER_INFO_FIELD.name = "user_info"
var_0_8.USER_INFO_FIELD.full_name = ".sgland.BattleShare.user_info"
var_0_8.USER_INFO_FIELD.number = 1
var_0_8.USER_INFO_FIELD.index = 0
var_0_8.USER_INFO_FIELD.label = 1
var_0_8.USER_INFO_FIELD.has_default_value = false
var_0_8.USER_INFO_FIELD.default_value = nil
var_0_8.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_8.USER_INFO_FIELD.type = 11
var_0_8.USER_INFO_FIELD.cpp_type = 10
var_0_8.LOG_FIELD.name = "log"
var_0_8.LOG_FIELD.full_name = ".sgland.BattleShare.log"
var_0_8.LOG_FIELD.number = 2
var_0_8.LOG_FIELD.index = 1
var_0_8.LOG_FIELD.label = 2
var_0_8.LOG_FIELD.has_default_value = false
var_0_8.LOG_FIELD.default_value = nil
var_0_8.LOG_FIELD.message_type = BATTLELOG
var_0_8.LOG_FIELD.type = 11
var_0_8.LOG_FIELD.cpp_type = 10
var_0_8.IS_ATTACK_FIELD.name = "is_attack"
var_0_8.IS_ATTACK_FIELD.full_name = ".sgland.BattleShare.is_attack"
var_0_8.IS_ATTACK_FIELD.number = 3
var_0_8.IS_ATTACK_FIELD.index = 2
var_0_8.IS_ATTACK_FIELD.label = 1
var_0_8.IS_ATTACK_FIELD.has_default_value = false
var_0_8.IS_ATTACK_FIELD.default_value = false
var_0_8.IS_ATTACK_FIELD.type = 8
var_0_8.IS_ATTACK_FIELD.cpp_type = 7
var_0_8.TIMESTAMP_FIELD.name = "timestamp"
var_0_8.TIMESTAMP_FIELD.full_name = ".sgland.BattleShare.timestamp"
var_0_8.TIMESTAMP_FIELD.number = 4
var_0_8.TIMESTAMP_FIELD.index = 3
var_0_8.TIMESTAMP_FIELD.label = 2
var_0_8.TIMESTAMP_FIELD.has_default_value = false
var_0_8.TIMESTAMP_FIELD.default_value = 0
var_0_8.TIMESTAMP_FIELD.type = 3
var_0_8.TIMESTAMP_FIELD.cpp_type = 2
var_0_8.TEXT_FIELD.name = "text"
var_0_8.TEXT_FIELD.full_name = ".sgland.BattleShare.text"
var_0_8.TEXT_FIELD.number = 5
var_0_8.TEXT_FIELD.index = 4
var_0_8.TEXT_FIELD.label = 1
var_0_8.TEXT_FIELD.has_default_value = false
var_0_8.TEXT_FIELD.default_value = ""
var_0_8.TEXT_FIELD.type = 9
var_0_8.TEXT_FIELD.cpp_type = 9
var_0_8.ROUND_FIELD.name = "round"
var_0_8.ROUND_FIELD.full_name = ".sgland.BattleShare.round"
var_0_8.ROUND_FIELD.number = 6
var_0_8.ROUND_FIELD.index = 5
var_0_8.ROUND_FIELD.label = 1
var_0_8.ROUND_FIELD.has_default_value = false
var_0_8.ROUND_FIELD.default_value = 0
var_0_8.ROUND_FIELD.type = 5
var_0_8.ROUND_FIELD.cpp_type = 1
var_0_8.THUMBS_UP_FIELD.name = "thumbs_up"
var_0_8.THUMBS_UP_FIELD.full_name = ".sgland.BattleShare.thumbs_up"
var_0_8.THUMBS_UP_FIELD.number = 7
var_0_8.THUMBS_UP_FIELD.index = 6
var_0_8.THUMBS_UP_FIELD.label = 3
var_0_8.THUMBS_UP_FIELD.has_default_value = false
var_0_8.THUMBS_UP_FIELD.default_value = {}
var_0_8.THUMBS_UP_FIELD.type = 9
var_0_8.THUMBS_UP_FIELD.cpp_type = 9
var_0_8.WATCHED_FIELD.name = "watched"
var_0_8.WATCHED_FIELD.full_name = ".sgland.BattleShare.watched"
var_0_8.WATCHED_FIELD.number = 8
var_0_8.WATCHED_FIELD.index = 7
var_0_8.WATCHED_FIELD.label = 3
var_0_8.WATCHED_FIELD.has_default_value = false
var_0_8.WATCHED_FIELD.default_value = {}
var_0_8.WATCHED_FIELD.type = 9
var_0_8.WATCHED_FIELD.cpp_type = 9
BATTLESHARE.name = "BattleShare"
BATTLESHARE.full_name = ".sgland.BattleShare"
BATTLESHARE.nested_types = {}
BATTLESHARE.enum_types = {}
BATTLESHARE.fields = {
	var_0_8.USER_INFO_FIELD,
	var_0_8.LOG_FIELD,
	var_0_8.IS_ATTACK_FIELD,
	var_0_8.TIMESTAMP_FIELD,
	var_0_8.TEXT_FIELD,
	var_0_8.ROUND_FIELD,
	var_0_8.THUMBS_UP_FIELD,
	var_0_8.WATCHED_FIELD
}
BATTLESHARE.is_extendable = false
BATTLESHARE.extensions = {}
var_0_9.DAMAGE_FIELD.name = "damage"
var_0_9.DAMAGE_FIELD.full_name = ".sgland.BattleBoss.damage"
var_0_9.DAMAGE_FIELD.number = 1
var_0_9.DAMAGE_FIELD.index = 0
var_0_9.DAMAGE_FIELD.label = 2
var_0_9.DAMAGE_FIELD.has_default_value = false
var_0_9.DAMAGE_FIELD.default_value = 0
var_0_9.DAMAGE_FIELD.type = 5
var_0_9.DAMAGE_FIELD.cpp_type = 1
var_0_9.HP_FIELD.name = "hp"
var_0_9.HP_FIELD.full_name = ".sgland.BattleBoss.hp"
var_0_9.HP_FIELD.number = 2
var_0_9.HP_FIELD.index = 1
var_0_9.HP_FIELD.label = 2
var_0_9.HP_FIELD.has_default_value = false
var_0_9.HP_FIELD.default_value = 0
var_0_9.HP_FIELD.type = 5
var_0_9.HP_FIELD.cpp_type = 1
var_0_9.EXTRA_GOLD_FIELD.name = "extra_gold"
var_0_9.EXTRA_GOLD_FIELD.full_name = ".sgland.BattleBoss.extra_gold"
var_0_9.EXTRA_GOLD_FIELD.number = 3
var_0_9.EXTRA_GOLD_FIELD.index = 2
var_0_9.EXTRA_GOLD_FIELD.label = 2
var_0_9.EXTRA_GOLD_FIELD.has_default_value = false
var_0_9.EXTRA_GOLD_FIELD.default_value = 0
var_0_9.EXTRA_GOLD_FIELD.type = 5
var_0_9.EXTRA_GOLD_FIELD.cpp_type = 1
var_0_9.ASSISTANT_DAMAGE_FIELD.name = "assistant_damage"
var_0_9.ASSISTANT_DAMAGE_FIELD.full_name = ".sgland.BattleBoss.assistant_damage"
var_0_9.ASSISTANT_DAMAGE_FIELD.number = 4
var_0_9.ASSISTANT_DAMAGE_FIELD.index = 3
var_0_9.ASSISTANT_DAMAGE_FIELD.label = 3
var_0_9.ASSISTANT_DAMAGE_FIELD.has_default_value = false
var_0_9.ASSISTANT_DAMAGE_FIELD.default_value = {}
var_0_9.ASSISTANT_DAMAGE_FIELD.type = 5
var_0_9.ASSISTANT_DAMAGE_FIELD.cpp_type = 1
BATTLEBOSS.name = "BattleBoss"
BATTLEBOSS.full_name = ".sgland.BattleBoss"
BATTLEBOSS.nested_types = {}
BATTLEBOSS.enum_types = {}
BATTLEBOSS.fields = {
	var_0_9.DAMAGE_FIELD,
	var_0_9.HP_FIELD,
	var_0_9.EXTRA_GOLD_FIELD,
	var_0_9.ASSISTANT_DAMAGE_FIELD
}
BATTLEBOSS.is_extendable = false
BATTLEBOSS.extensions = {}
var_0_10.ID_FIELD.name = "id"
var_0_10.ID_FIELD.full_name = ".sgland.BattleTutorial.id"
var_0_10.ID_FIELD.number = 1
var_0_10.ID_FIELD.index = 0
var_0_10.ID_FIELD.label = 2
var_0_10.ID_FIELD.has_default_value = false
var_0_10.ID_FIELD.default_value = 0
var_0_10.ID_FIELD.type = 3
var_0_10.ID_FIELD.cpp_type = 2
var_0_10.CITY_CHAPTER_ID_FIELD.name = "city_chapter_id"
var_0_10.CITY_CHAPTER_ID_FIELD.full_name = ".sgland.BattleTutorial.city_chapter_id"
var_0_10.CITY_CHAPTER_ID_FIELD.number = 2
var_0_10.CITY_CHAPTER_ID_FIELD.index = 1
var_0_10.CITY_CHAPTER_ID_FIELD.label = 2
var_0_10.CITY_CHAPTER_ID_FIELD.has_default_value = false
var_0_10.CITY_CHAPTER_ID_FIELD.default_value = 0
var_0_10.CITY_CHAPTER_ID_FIELD.type = 5
var_0_10.CITY_CHAPTER_ID_FIELD.cpp_type = 1
var_0_10.USER_INFO_FIELD.name = "user_info"
var_0_10.USER_INFO_FIELD.full_name = ".sgland.BattleTutorial.user_info"
var_0_10.USER_INFO_FIELD.number = 3
var_0_10.USER_INFO_FIELD.index = 2
var_0_10.USER_INFO_FIELD.label = 2
var_0_10.USER_INFO_FIELD.has_default_value = false
var_0_10.USER_INFO_FIELD.default_value = nil
var_0_10.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_10.USER_INFO_FIELD.type = 11
var_0_10.USER_INFO_FIELD.cpp_type = 10
var_0_10.REPLAY_ID_FIELD.name = "replay_id"
var_0_10.REPLAY_ID_FIELD.full_name = ".sgland.BattleTutorial.replay_id"
var_0_10.REPLAY_ID_FIELD.number = 4
var_0_10.REPLAY_ID_FIELD.index = 3
var_0_10.REPLAY_ID_FIELD.label = 2
var_0_10.REPLAY_ID_FIELD.has_default_value = false
var_0_10.REPLAY_ID_FIELD.default_value = 0
var_0_10.REPLAY_ID_FIELD.type = 3
var_0_10.REPLAY_ID_FIELD.cpp_type = 2
var_0_10.POWER_FIELD.name = "power"
var_0_10.POWER_FIELD.full_name = ".sgland.BattleTutorial.power"
var_0_10.POWER_FIELD.number = 5
var_0_10.POWER_FIELD.index = 4
var_0_10.POWER_FIELD.label = 2
var_0_10.POWER_FIELD.has_default_value = false
var_0_10.POWER_FIELD.default_value = 0
var_0_10.POWER_FIELD.type = 5
var_0_10.POWER_FIELD.cpp_type = 1
var_0_10.TIMESTAMP_FIELD.name = "timestamp"
var_0_10.TIMESTAMP_FIELD.full_name = ".sgland.BattleTutorial.timestamp"
var_0_10.TIMESTAMP_FIELD.number = 6
var_0_10.TIMESTAMP_FIELD.index = 5
var_0_10.TIMESTAMP_FIELD.label = 2
var_0_10.TIMESTAMP_FIELD.has_default_value = false
var_0_10.TIMESTAMP_FIELD.default_value = 0
var_0_10.TIMESTAMP_FIELD.type = 3
var_0_10.TIMESTAMP_FIELD.cpp_type = 2
BATTLETUTORIAL.name = "BattleTutorial"
BATTLETUTORIAL.full_name = ".sgland.BattleTutorial"
BATTLETUTORIAL.nested_types = {}
BATTLETUTORIAL.enum_types = {}
BATTLETUTORIAL.fields = {
	var_0_10.ID_FIELD,
	var_0_10.CITY_CHAPTER_ID_FIELD,
	var_0_10.USER_INFO_FIELD,
	var_0_10.REPLAY_ID_FIELD,
	var_0_10.POWER_FIELD,
	var_0_10.TIMESTAMP_FIELD
}
BATTLETUTORIAL.is_extendable = false
BATTLETUTORIAL.extensions = {}
var_0_11.LOG_ID_FIELD.name = "log_id"
var_0_11.LOG_ID_FIELD.full_name = ".sgland.BattleShareEvent.log_id"
var_0_11.LOG_ID_FIELD.number = 1
var_0_11.LOG_ID_FIELD.index = 0
var_0_11.LOG_ID_FIELD.label = 2
var_0_11.LOG_ID_FIELD.has_default_value = false
var_0_11.LOG_ID_FIELD.default_value = 0
var_0_11.LOG_ID_FIELD.type = 3
var_0_11.LOG_ID_FIELD.cpp_type = 2
var_0_11.USER_ID_FIELD.name = "user_id"
var_0_11.USER_ID_FIELD.full_name = ".sgland.BattleShareEvent.user_id"
var_0_11.USER_ID_FIELD.number = 2
var_0_11.USER_ID_FIELD.index = 1
var_0_11.USER_ID_FIELD.label = 2
var_0_11.USER_ID_FIELD.has_default_value = false
var_0_11.USER_ID_FIELD.default_value = ""
var_0_11.USER_ID_FIELD.type = 9
var_0_11.USER_ID_FIELD.cpp_type = 9
BATTLESHAREEVENT.name = "BattleShareEvent"
BATTLESHAREEVENT.full_name = ".sgland.BattleShareEvent"
BATTLESHAREEVENT.nested_types = {}
BATTLESHAREEVENT.enum_types = {}
BATTLESHAREEVENT.fields = {
	var_0_11.LOG_ID_FIELD,
	var_0_11.USER_ID_FIELD
}
BATTLESHAREEVENT.is_extendable = false
BATTLESHAREEVENT.extensions = {}
var_0_12.LOG_ID_FIELD.name = "log_id"
var_0_12.LOG_ID_FIELD.full_name = ".sgland.BattleShareReq.log_id"
var_0_12.LOG_ID_FIELD.number = 1
var_0_12.LOG_ID_FIELD.index = 0
var_0_12.LOG_ID_FIELD.label = 2
var_0_12.LOG_ID_FIELD.has_default_value = false
var_0_12.LOG_ID_FIELD.default_value = 0
var_0_12.LOG_ID_FIELD.type = 3
var_0_12.LOG_ID_FIELD.cpp_type = 2
var_0_12.TEXT_FIELD.name = "text"
var_0_12.TEXT_FIELD.full_name = ".sgland.BattleShareReq.text"
var_0_12.TEXT_FIELD.number = 2
var_0_12.TEXT_FIELD.index = 1
var_0_12.TEXT_FIELD.label = 2
var_0_12.TEXT_FIELD.has_default_value = false
var_0_12.TEXT_FIELD.default_value = ""
var_0_12.TEXT_FIELD.type = 9
var_0_12.TEXT_FIELD.cpp_type = 9
BATTLESHAREREQ.name = "BattleShareReq"
BATTLESHAREREQ.full_name = ".sgland.BattleShareReq"
BATTLESHAREREQ.nested_types = {}
BATTLESHAREREQ.enum_types = {}
BATTLESHAREREQ.fields = {
	var_0_12.LOG_ID_FIELD,
	var_0_12.TEXT_FIELD
}
BATTLESHAREREQ.is_extendable = false
BATTLESHAREREQ.extensions = {}
var_0_13.ATTACK_LOG_FIELD.name = "attack_log"
var_0_13.ATTACK_LOG_FIELD.full_name = ".sgland.BattleLogResp.attack_log"
var_0_13.ATTACK_LOG_FIELD.number = 1
var_0_13.ATTACK_LOG_FIELD.index = 0
var_0_13.ATTACK_LOG_FIELD.label = 3
var_0_13.ATTACK_LOG_FIELD.has_default_value = false
var_0_13.ATTACK_LOG_FIELD.default_value = {}
var_0_13.ATTACK_LOG_FIELD.message_type = BATTLELOG
var_0_13.ATTACK_LOG_FIELD.type = 11
var_0_13.ATTACK_LOG_FIELD.cpp_type = 10
var_0_13.DEFEND_LOG_FIELD.name = "defend_log"
var_0_13.DEFEND_LOG_FIELD.full_name = ".sgland.BattleLogResp.defend_log"
var_0_13.DEFEND_LOG_FIELD.number = 2
var_0_13.DEFEND_LOG_FIELD.index = 1
var_0_13.DEFEND_LOG_FIELD.label = 3
var_0_13.DEFEND_LOG_FIELD.has_default_value = false
var_0_13.DEFEND_LOG_FIELD.default_value = {}
var_0_13.DEFEND_LOG_FIELD.message_type = BATTLELOG
var_0_13.DEFEND_LOG_FIELD.type = 11
var_0_13.DEFEND_LOG_FIELD.cpp_type = 10
BATTLELOGRESP.name = "BattleLogResp"
BATTLELOGRESP.full_name = ".sgland.BattleLogResp"
BATTLELOGRESP.nested_types = {}
BATTLELOGRESP.enum_types = {}
BATTLELOGRESP.fields = {
	var_0_13.ATTACK_LOG_FIELD,
	var_0_13.DEFEND_LOG_FIELD
}
BATTLELOGRESP.is_extendable = false
BATTLELOGRESP.extensions = {}
var_0_14.SCORE_FIELD.name = "score"
var_0_14.SCORE_FIELD.full_name = ".sgland.DarkDuelBattleEndResp.score"
var_0_14.SCORE_FIELD.number = 1
var_0_14.SCORE_FIELD.index = 0
var_0_14.SCORE_FIELD.label = 2
var_0_14.SCORE_FIELD.has_default_value = false
var_0_14.SCORE_FIELD.default_value = 0
var_0_14.SCORE_FIELD.type = 5
var_0_14.SCORE_FIELD.cpp_type = 1
var_0_14.BATTLE_END_TYPE_FIELD.name = "battle_end_type"
var_0_14.BATTLE_END_TYPE_FIELD.full_name = ".sgland.DarkDuelBattleEndResp.battle_end_type"
var_0_14.BATTLE_END_TYPE_FIELD.number = 2
var_0_14.BATTLE_END_TYPE_FIELD.index = 1
var_0_14.BATTLE_END_TYPE_FIELD.label = 2
var_0_14.BATTLE_END_TYPE_FIELD.has_default_value = false
var_0_14.BATTLE_END_TYPE_FIELD.default_value = nil
var_0_14.BATTLE_END_TYPE_FIELD.enum_type = DARKDUELBATTLEENDTYPE
var_0_14.BATTLE_END_TYPE_FIELD.type = 14
var_0_14.BATTLE_END_TYPE_FIELD.cpp_type = 8
var_0_14.WIN_FIELD.name = "win"
var_0_14.WIN_FIELD.full_name = ".sgland.DarkDuelBattleEndResp.win"
var_0_14.WIN_FIELD.number = 3
var_0_14.WIN_FIELD.index = 2
var_0_14.WIN_FIELD.label = 2
var_0_14.WIN_FIELD.has_default_value = false
var_0_14.WIN_FIELD.default_value = 0
var_0_14.WIN_FIELD.type = 5
var_0_14.WIN_FIELD.cpp_type = 1
var_0_14.LOSE_FIELD.name = "lose"
var_0_14.LOSE_FIELD.full_name = ".sgland.DarkDuelBattleEndResp.lose"
var_0_14.LOSE_FIELD.number = 4
var_0_14.LOSE_FIELD.index = 3
var_0_14.LOSE_FIELD.label = 2
var_0_14.LOSE_FIELD.has_default_value = false
var_0_14.LOSE_FIELD.default_value = 0
var_0_14.LOSE_FIELD.type = 5
var_0_14.LOSE_FIELD.cpp_type = 1
var_0_14.INNING_FIELD.name = "inning"
var_0_14.INNING_FIELD.full_name = ".sgland.DarkDuelBattleEndResp.inning"
var_0_14.INNING_FIELD.number = 5
var_0_14.INNING_FIELD.index = 4
var_0_14.INNING_FIELD.label = 2
var_0_14.INNING_FIELD.has_default_value = false
var_0_14.INNING_FIELD.default_value = 0
var_0_14.INNING_FIELD.type = 5
var_0_14.INNING_FIELD.cpp_type = 1
var_0_14.LOCAL_ID_FIELD.name = "local_id"
var_0_14.LOCAL_ID_FIELD.full_name = ".sgland.DarkDuelBattleEndResp.local_id"
var_0_14.LOCAL_ID_FIELD.number = 6
var_0_14.LOCAL_ID_FIELD.index = 5
var_0_14.LOCAL_ID_FIELD.label = 2
var_0_14.LOCAL_ID_FIELD.has_default_value = false
var_0_14.LOCAL_ID_FIELD.default_value = 0
var_0_14.LOCAL_ID_FIELD.type = 3
var_0_14.LOCAL_ID_FIELD.cpp_type = 2
DARKDUELBATTLEENDRESP.name = "DarkDuelBattleEndResp"
DARKDUELBATTLEENDRESP.full_name = ".sgland.DarkDuelBattleEndResp"
DARKDUELBATTLEENDRESP.nested_types = {}
DARKDUELBATTLEENDRESP.enum_types = {}
DARKDUELBATTLEENDRESP.fields = {
	var_0_14.SCORE_FIELD,
	var_0_14.BATTLE_END_TYPE_FIELD,
	var_0_14.WIN_FIELD,
	var_0_14.LOSE_FIELD,
	var_0_14.INNING_FIELD,
	var_0_14.LOCAL_ID_FIELD
}
DARKDUELBATTLEENDRESP.is_extendable = false
DARKDUELBATTLEENDRESP.extensions = {}
var_0_15.TYPE_FIELD.name = "type"
var_0_15.TYPE_FIELD.full_name = ".sgland.BattleEndResp.type"
var_0_15.TYPE_FIELD.number = 1
var_0_15.TYPE_FIELD.index = 0
var_0_15.TYPE_FIELD.label = 2
var_0_15.TYPE_FIELD.has_default_value = false
var_0_15.TYPE_FIELD.default_value = nil
var_0_15.TYPE_FIELD.enum_type = BATTLEENDTYPE
var_0_15.TYPE_FIELD.type = 14
var_0_15.TYPE_FIELD.cpp_type = 8
var_0_15.RESOURCE_FIELD.name = "resource"
var_0_15.RESOURCE_FIELD.full_name = ".sgland.BattleEndResp.resource"
var_0_15.RESOURCE_FIELD.number = 2
var_0_15.RESOURCE_FIELD.index = 1
var_0_15.RESOURCE_FIELD.label = 3
var_0_15.RESOURCE_FIELD.has_default_value = false
var_0_15.RESOURCE_FIELD.default_value = {}
var_0_15.RESOURCE_FIELD.message_type = var_0_2.RESOURCE
var_0_15.RESOURCE_FIELD.type = 11
var_0_15.RESOURCE_FIELD.cpp_type = 10
var_0_15.LOG_FIELD.name = "log"
var_0_15.LOG_FIELD.full_name = ".sgland.BattleEndResp.log"
var_0_15.LOG_FIELD.number = 3
var_0_15.LOG_FIELD.index = 2
var_0_15.LOG_FIELD.label = 1
var_0_15.LOG_FIELD.has_default_value = false
var_0_15.LOG_FIELD.default_value = nil
var_0_15.LOG_FIELD.message_type = BATTLELOG
var_0_15.LOG_FIELD.type = 11
var_0_15.LOG_FIELD.cpp_type = 10
var_0_15.TIMESTAMP_FIELD.name = "timestamp"
var_0_15.TIMESTAMP_FIELD.full_name = ".sgland.BattleEndResp.timestamp"
var_0_15.TIMESTAMP_FIELD.number = 4
var_0_15.TIMESTAMP_FIELD.index = 3
var_0_15.TIMESTAMP_FIELD.label = 2
var_0_15.TIMESTAMP_FIELD.has_default_value = false
var_0_15.TIMESTAMP_FIELD.default_value = 0
var_0_15.TIMESTAMP_FIELD.type = 3
var_0_15.TIMESTAMP_FIELD.cpp_type = 2
var_0_15.TROPHY_FIELD.name = "trophy"
var_0_15.TROPHY_FIELD.full_name = ".sgland.BattleEndResp.trophy"
var_0_15.TROPHY_FIELD.number = 5
var_0_15.TROPHY_FIELD.index = 4
var_0_15.TROPHY_FIELD.label = 1
var_0_15.TROPHY_FIELD.has_default_value = false
var_0_15.TROPHY_FIELD.default_value = 0
var_0_15.TROPHY_FIELD.type = 5
var_0_15.TROPHY_FIELD.cpp_type = 1
var_0_15.CITY_FIELD.name = "city"
var_0_15.CITY_FIELD.full_name = ".sgland.BattleEndResp.city"
var_0_15.CITY_FIELD.number = 6
var_0_15.CITY_FIELD.index = 5
var_0_15.CITY_FIELD.label = 1
var_0_15.CITY_FIELD.has_default_value = false
var_0_15.CITY_FIELD.default_value = 0
var_0_15.CITY_FIELD.type = 5
var_0_15.CITY_FIELD.cpp_type = 1
var_0_15.ATK_EXPEND_FIELD.name = "atk_expend"
var_0_15.ATK_EXPEND_FIELD.full_name = ".sgland.BattleEndResp.atk_expend"
var_0_15.ATK_EXPEND_FIELD.number = 7
var_0_15.ATK_EXPEND_FIELD.index = 6
var_0_15.ATK_EXPEND_FIELD.label = 1
var_0_15.ATK_EXPEND_FIELD.has_default_value = false
var_0_15.ATK_EXPEND_FIELD.default_value = nil
var_0_15.ATK_EXPEND_FIELD.message_type = BATTLEEXPEND
var_0_15.ATK_EXPEND_FIELD.type = 11
var_0_15.ATK_EXPEND_FIELD.cpp_type = 10
var_0_15.DEF_EXPEND_FIELD.name = "def_expend"
var_0_15.DEF_EXPEND_FIELD.full_name = ".sgland.BattleEndResp.def_expend"
var_0_15.DEF_EXPEND_FIELD.number = 8
var_0_15.DEF_EXPEND_FIELD.index = 7
var_0_15.DEF_EXPEND_FIELD.label = 1
var_0_15.DEF_EXPEND_FIELD.has_default_value = false
var_0_15.DEF_EXPEND_FIELD.default_value = nil
var_0_15.DEF_EXPEND_FIELD.message_type = BATTLEEXPEND
var_0_15.DEF_EXPEND_FIELD.type = 11
var_0_15.DEF_EXPEND_FIELD.cpp_type = 10
var_0_15.TASK_RESULT_FIELD.name = "task_result"
var_0_15.TASK_RESULT_FIELD.full_name = ".sgland.BattleEndResp.task_result"
var_0_15.TASK_RESULT_FIELD.number = 9
var_0_15.TASK_RESULT_FIELD.index = 8
var_0_15.TASK_RESULT_FIELD.label = 3
var_0_15.TASK_RESULT_FIELD.has_default_value = false
var_0_15.TASK_RESULT_FIELD.default_value = {}
var_0_15.TASK_RESULT_FIELD.type = 8
var_0_15.TASK_RESULT_FIELD.cpp_type = 7
var_0_15.RANK1_FIELD.name = "rank1"
var_0_15.RANK1_FIELD.full_name = ".sgland.BattleEndResp.rank1"
var_0_15.RANK1_FIELD.number = 10
var_0_15.RANK1_FIELD.index = 9
var_0_15.RANK1_FIELD.label = 1
var_0_15.RANK1_FIELD.has_default_value = false
var_0_15.RANK1_FIELD.default_value = 0
var_0_15.RANK1_FIELD.type = 5
var_0_15.RANK1_FIELD.cpp_type = 1
var_0_15.RANK2_FIELD.name = "rank2"
var_0_15.RANK2_FIELD.full_name = ".sgland.BattleEndResp.rank2"
var_0_15.RANK2_FIELD.number = 11
var_0_15.RANK2_FIELD.index = 10
var_0_15.RANK2_FIELD.label = 1
var_0_15.RANK2_FIELD.has_default_value = false
var_0_15.RANK2_FIELD.default_value = 0
var_0_15.RANK2_FIELD.type = 5
var_0_15.RANK2_FIELD.cpp_type = 1
var_0_15.BOSS_FIELD.name = "boss"
var_0_15.BOSS_FIELD.full_name = ".sgland.BattleEndResp.boss"
var_0_15.BOSS_FIELD.number = 12
var_0_15.BOSS_FIELD.index = 11
var_0_15.BOSS_FIELD.label = 1
var_0_15.BOSS_FIELD.has_default_value = false
var_0_15.BOSS_FIELD.default_value = nil
var_0_15.BOSS_FIELD.message_type = BATTLEBOSS
var_0_15.BOSS_FIELD.type = 11
var_0_15.BOSS_FIELD.cpp_type = 10
var_0_15.SCORE_FIELD.name = "score"
var_0_15.SCORE_FIELD.full_name = ".sgland.BattleEndResp.score"
var_0_15.SCORE_FIELD.number = 13
var_0_15.SCORE_FIELD.index = 12
var_0_15.SCORE_FIELD.label = 1
var_0_15.SCORE_FIELD.has_default_value = false
var_0_15.SCORE_FIELD.default_value = 0
var_0_15.SCORE_FIELD.type = 5
var_0_15.SCORE_FIELD.cpp_type = 1
var_0_15.GRADE_FIELD.name = "grade"
var_0_15.GRADE_FIELD.full_name = ".sgland.BattleEndResp.grade"
var_0_15.GRADE_FIELD.number = 14
var_0_15.GRADE_FIELD.index = 13
var_0_15.GRADE_FIELD.label = 1
var_0_15.GRADE_FIELD.has_default_value = false
var_0_15.GRADE_FIELD.default_value = 0
var_0_15.GRADE_FIELD.type = 5
var_0_15.GRADE_FIELD.cpp_type = 1
var_0_15.TROPHY_EX_FIELD.name = "trophy_ex"
var_0_15.TROPHY_EX_FIELD.full_name = ".sgland.BattleEndResp.trophy_ex"
var_0_15.TROPHY_EX_FIELD.number = 15
var_0_15.TROPHY_EX_FIELD.index = 14
var_0_15.TROPHY_EX_FIELD.label = 1
var_0_15.TROPHY_EX_FIELD.has_default_value = false
var_0_15.TROPHY_EX_FIELD.default_value = 0
var_0_15.TROPHY_EX_FIELD.type = 5
var_0_15.TROPHY_EX_FIELD.cpp_type = 1
var_0_15.PARAM_FIELD.name = "param"
var_0_15.PARAM_FIELD.full_name = ".sgland.BattleEndResp.param"
var_0_15.PARAM_FIELD.number = 16
var_0_15.PARAM_FIELD.index = 15
var_0_15.PARAM_FIELD.label = 1
var_0_15.PARAM_FIELD.has_default_value = false
var_0_15.PARAM_FIELD.default_value = 0
var_0_15.PARAM_FIELD.type = 5
var_0_15.PARAM_FIELD.cpp_type = 1
var_0_15.LADDER_EX_WIN_FIELD.name = "ladder_ex_win"
var_0_15.LADDER_EX_WIN_FIELD.full_name = ".sgland.BattleEndResp.ladder_ex_win"
var_0_15.LADDER_EX_WIN_FIELD.number = 17
var_0_15.LADDER_EX_WIN_FIELD.index = 16
var_0_15.LADDER_EX_WIN_FIELD.label = 1
var_0_15.LADDER_EX_WIN_FIELD.has_default_value = false
var_0_15.LADDER_EX_WIN_FIELD.default_value = 0
var_0_15.LADDER_EX_WIN_FIELD.type = 5
var_0_15.LADDER_EX_WIN_FIELD.cpp_type = 1
var_0_15.STAT_FIELD.name = "stat"
var_0_15.STAT_FIELD.full_name = ".sgland.BattleEndResp.stat"
var_0_15.STAT_FIELD.number = 18
var_0_15.STAT_FIELD.index = 17
var_0_15.STAT_FIELD.label = 3
var_0_15.STAT_FIELD.has_default_value = false
var_0_15.STAT_FIELD.default_value = {}
var_0_15.STAT_FIELD.type = 5
var_0_15.STAT_FIELD.cpp_type = 1
var_0_15.MASS_WAR_SCORE_FIELD.name = "mass_war_score"
var_0_15.MASS_WAR_SCORE_FIELD.full_name = ".sgland.BattleEndResp.mass_war_score"
var_0_15.MASS_WAR_SCORE_FIELD.number = 19
var_0_15.MASS_WAR_SCORE_FIELD.index = 18
var_0_15.MASS_WAR_SCORE_FIELD.label = 1
var_0_15.MASS_WAR_SCORE_FIELD.has_default_value = false
var_0_15.MASS_WAR_SCORE_FIELD.default_value = 0
var_0_15.MASS_WAR_SCORE_FIELD.type = 5
var_0_15.MASS_WAR_SCORE_FIELD.cpp_type = 1
var_0_15.DARK_DUEL_END_RESP_FIELD.name = "dark_duel_end_resp"
var_0_15.DARK_DUEL_END_RESP_FIELD.full_name = ".sgland.BattleEndResp.dark_duel_end_resp"
var_0_15.DARK_DUEL_END_RESP_FIELD.number = 20
var_0_15.DARK_DUEL_END_RESP_FIELD.index = 19
var_0_15.DARK_DUEL_END_RESP_FIELD.label = 1
var_0_15.DARK_DUEL_END_RESP_FIELD.has_default_value = false
var_0_15.DARK_DUEL_END_RESP_FIELD.default_value = nil
var_0_15.DARK_DUEL_END_RESP_FIELD.message_type = DARKDUELBATTLEENDRESP
var_0_15.DARK_DUEL_END_RESP_FIELD.type = 11
var_0_15.DARK_DUEL_END_RESP_FIELD.cpp_type = 10
var_0_15.BATTLE_PASS_FIELD.name = "battle_pass"
var_0_15.BATTLE_PASS_FIELD.full_name = ".sgland.BattleEndResp.battle_pass"
var_0_15.BATTLE_PASS_FIELD.number = 21
var_0_15.BATTLE_PASS_FIELD.index = 20
var_0_15.BATTLE_PASS_FIELD.label = 3
var_0_15.BATTLE_PASS_FIELD.has_default_value = false
var_0_15.BATTLE_PASS_FIELD.default_value = {}
var_0_15.BATTLE_PASS_FIELD.type = 5
var_0_15.BATTLE_PASS_FIELD.cpp_type = 1
BATTLEENDRESP.name = "BattleEndResp"
BATTLEENDRESP.full_name = ".sgland.BattleEndResp"
BATTLEENDRESP.nested_types = {}
BATTLEENDRESP.enum_types = {}
BATTLEENDRESP.fields = {
	var_0_15.TYPE_FIELD,
	var_0_15.RESOURCE_FIELD,
	var_0_15.LOG_FIELD,
	var_0_15.TIMESTAMP_FIELD,
	var_0_15.TROPHY_FIELD,
	var_0_15.CITY_FIELD,
	var_0_15.ATK_EXPEND_FIELD,
	var_0_15.DEF_EXPEND_FIELD,
	var_0_15.TASK_RESULT_FIELD,
	var_0_15.RANK1_FIELD,
	var_0_15.RANK2_FIELD,
	var_0_15.BOSS_FIELD,
	var_0_15.SCORE_FIELD,
	var_0_15.GRADE_FIELD,
	var_0_15.TROPHY_EX_FIELD,
	var_0_15.PARAM_FIELD,
	var_0_15.LADDER_EX_WIN_FIELD,
	var_0_15.STAT_FIELD,
	var_0_15.MASS_WAR_SCORE_FIELD,
	var_0_15.DARK_DUEL_END_RESP_FIELD,
	var_0_15.BATTLE_PASS_FIELD
}
BATTLEENDRESP.is_extendable = false
BATTLEENDRESP.extensions = {}
var_0_16.USER_ID_FIELD.name = "user_id"
var_0_16.USER_ID_FIELD.full_name = ".sgland.BattleLadderResp.user_id"
var_0_16.USER_ID_FIELD.number = 1
var_0_16.USER_ID_FIELD.index = 0
var_0_16.USER_ID_FIELD.label = 2
var_0_16.USER_ID_FIELD.has_default_value = false
var_0_16.USER_ID_FIELD.default_value = 0
var_0_16.USER_ID_FIELD.type = 3
var_0_16.USER_ID_FIELD.cpp_type = 2
var_0_16.PVP_ID_FIELD.name = "pvp_id"
var_0_16.PVP_ID_FIELD.full_name = ".sgland.BattleLadderResp.pvp_id"
var_0_16.PVP_ID_FIELD.number = 2
var_0_16.PVP_ID_FIELD.index = 1
var_0_16.PVP_ID_FIELD.label = 2
var_0_16.PVP_ID_FIELD.has_default_value = false
var_0_16.PVP_ID_FIELD.default_value = 0
var_0_16.PVP_ID_FIELD.type = 5
var_0_16.PVP_ID_FIELD.cpp_type = 1
var_0_16.BATTLE_ID_FIELD.name = "battle_id"
var_0_16.BATTLE_ID_FIELD.full_name = ".sgland.BattleLadderResp.battle_id"
var_0_16.BATTLE_ID_FIELD.number = 3
var_0_16.BATTLE_ID_FIELD.index = 2
var_0_16.BATTLE_ID_FIELD.label = 2
var_0_16.BATTLE_ID_FIELD.has_default_value = false
var_0_16.BATTLE_ID_FIELD.default_value = 0
var_0_16.BATTLE_ID_FIELD.type = 3
var_0_16.BATTLE_ID_FIELD.cpp_type = 2
var_0_16.BATTLE_TYPE_FIELD.name = "battle_type"
var_0_16.BATTLE_TYPE_FIELD.full_name = ".sgland.BattleLadderResp.battle_type"
var_0_16.BATTLE_TYPE_FIELD.number = 4
var_0_16.BATTLE_TYPE_FIELD.index = 3
var_0_16.BATTLE_TYPE_FIELD.label = 1
var_0_16.BATTLE_TYPE_FIELD.has_default_value = false
var_0_16.BATTLE_TYPE_FIELD.default_value = nil
var_0_16.BATTLE_TYPE_FIELD.enum_type = BATTLETYPE
var_0_16.BATTLE_TYPE_FIELD.type = 14
var_0_16.BATTLE_TYPE_FIELD.cpp_type = 8
var_0_16.TROPHY_FIELD.name = "trophy"
var_0_16.TROPHY_FIELD.full_name = ".sgland.BattleLadderResp.trophy"
var_0_16.TROPHY_FIELD.number = 5
var_0_16.TROPHY_FIELD.index = 4
var_0_16.TROPHY_FIELD.label = 1
var_0_16.TROPHY_FIELD.has_default_value = false
var_0_16.TROPHY_FIELD.default_value = 0
var_0_16.TROPHY_FIELD.type = 5
var_0_16.TROPHY_FIELD.cpp_type = 1
var_0_16.MASS_WAR_SCORE_FIELD.name = "mass_war_score"
var_0_16.MASS_WAR_SCORE_FIELD.full_name = ".sgland.BattleLadderResp.mass_war_score"
var_0_16.MASS_WAR_SCORE_FIELD.number = 6
var_0_16.MASS_WAR_SCORE_FIELD.index = 5
var_0_16.MASS_WAR_SCORE_FIELD.label = 1
var_0_16.MASS_WAR_SCORE_FIELD.has_default_value = false
var_0_16.MASS_WAR_SCORE_FIELD.default_value = 0
var_0_16.MASS_WAR_SCORE_FIELD.type = 5
var_0_16.MASS_WAR_SCORE_FIELD.cpp_type = 1
var_0_16.TROPHY_UP_FIELD.name = "trophy_up"
var_0_16.TROPHY_UP_FIELD.full_name = ".sgland.BattleLadderResp.trophy_up"
var_0_16.TROPHY_UP_FIELD.number = 7
var_0_16.TROPHY_UP_FIELD.index = 6
var_0_16.TROPHY_UP_FIELD.label = 1
var_0_16.TROPHY_UP_FIELD.has_default_value = false
var_0_16.TROPHY_UP_FIELD.default_value = false
var_0_16.TROPHY_UP_FIELD.type = 8
var_0_16.TROPHY_UP_FIELD.cpp_type = 7
BATTLELADDERRESP.name = "BattleLadderResp"
BATTLELADDERRESP.full_name = ".sgland.BattleLadderResp"
BATTLELADDERRESP.nested_types = {}
BATTLELADDERRESP.enum_types = {}
BATTLELADDERRESP.fields = {
	var_0_16.USER_ID_FIELD,
	var_0_16.PVP_ID_FIELD,
	var_0_16.BATTLE_ID_FIELD,
	var_0_16.BATTLE_TYPE_FIELD,
	var_0_16.TROPHY_FIELD,
	var_0_16.MASS_WAR_SCORE_FIELD,
	var_0_16.TROPHY_UP_FIELD
}
BATTLELADDERRESP.is_extendable = false
BATTLELADDERRESP.extensions = {}
var_0_17.TYPE_FIELD.name = "type"
var_0_17.TYPE_FIELD.full_name = ".sgland.BattleLogExResp.type"
var_0_17.TYPE_FIELD.number = 1
var_0_17.TYPE_FIELD.index = 0
var_0_17.TYPE_FIELD.label = 2
var_0_17.TYPE_FIELD.has_default_value = false
var_0_17.TYPE_FIELD.default_value = 0
var_0_17.TYPE_FIELD.type = 5
var_0_17.TYPE_FIELD.cpp_type = 1
var_0_17.LOGS_FIELD.name = "logs"
var_0_17.LOGS_FIELD.full_name = ".sgland.BattleLogExResp.logs"
var_0_17.LOGS_FIELD.number = 2
var_0_17.LOGS_FIELD.index = 1
var_0_17.LOGS_FIELD.label = 3
var_0_17.LOGS_FIELD.has_default_value = false
var_0_17.LOGS_FIELD.default_value = {}
var_0_17.LOGS_FIELD.message_type = BATTLELOG
var_0_17.LOGS_FIELD.type = 11
var_0_17.LOGS_FIELD.cpp_type = 10
BATTLELOGEXRESP.name = "BattleLogExResp"
BATTLELOGEXRESP.full_name = ".sgland.BattleLogExResp"
BATTLELOGEXRESP.nested_types = {}
BATTLELOGEXRESP.enum_types = {}
BATTLELOGEXRESP.fields = {
	var_0_17.TYPE_FIELD,
	var_0_17.LOGS_FIELD
}
BATTLELOGEXRESP.is_extendable = false
BATTLELOGEXRESP.extensions = {}
var_0_18.BATTLE_END_REQ_FIELD.name = "battle_end_req"
var_0_18.BATTLE_END_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_end_req"
var_0_18.BATTLE_END_REQ_FIELD.number = 700
var_0_18.BATTLE_END_REQ_FIELD.index = 0
var_0_18.BATTLE_END_REQ_FIELD.label = 1
var_0_18.BATTLE_END_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_END_REQ_FIELD.default_value = nil
var_0_18.BATTLE_END_REQ_FIELD.enum_type = BATTLEENDTYPE
var_0_18.BATTLE_END_REQ_FIELD.type = 14
var_0_18.BATTLE_END_REQ_FIELD.cpp_type = 8
var_0_18.BATTLE_USECARD_REQ_FIELD.name = "battle_usecard_req"
var_0_18.BATTLE_USECARD_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_usecard_req"
var_0_18.BATTLE_USECARD_REQ_FIELD.number = 701
var_0_18.BATTLE_USECARD_REQ_FIELD.index = 1
var_0_18.BATTLE_USECARD_REQ_FIELD.label = 3
var_0_18.BATTLE_USECARD_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_USECARD_REQ_FIELD.default_value = {}
var_0_18.BATTLE_USECARD_REQ_FIELD.type = 5
var_0_18.BATTLE_USECARD_REQ_FIELD.cpp_type = 1
var_0_18.BATTLE_OP_USECARD_REQ_FIELD.name = "battle_op_usecard_req"
var_0_18.BATTLE_OP_USECARD_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_op_usecard_req"
var_0_18.BATTLE_OP_USECARD_REQ_FIELD.number = 702
var_0_18.BATTLE_OP_USECARD_REQ_FIELD.index = 2
var_0_18.BATTLE_OP_USECARD_REQ_FIELD.label = 3
var_0_18.BATTLE_OP_USECARD_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_OP_USECARD_REQ_FIELD.default_value = {}
var_0_18.BATTLE_OP_USECARD_REQ_FIELD.type = 5
var_0_18.BATTLE_OP_USECARD_REQ_FIELD.cpp_type = 1
var_0_18.BATTLE_REPLAY_REQ_FIELD.name = "battle_replay_req"
var_0_18.BATTLE_REPLAY_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_replay_req"
var_0_18.BATTLE_REPLAY_REQ_FIELD.number = 703
var_0_18.BATTLE_REPLAY_REQ_FIELD.index = 3
var_0_18.BATTLE_REPLAY_REQ_FIELD.label = 1
var_0_18.BATTLE_REPLAY_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_REPLAY_REQ_FIELD.default_value = 0
var_0_18.BATTLE_REPLAY_REQ_FIELD.type = 3
var_0_18.BATTLE_REPLAY_REQ_FIELD.cpp_type = 2
var_0_18.BATTLE_START_REQ_FIELD.name = "battle_start_req"
var_0_18.BATTLE_START_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_start_req"
var_0_18.BATTLE_START_REQ_FIELD.number = 704
var_0_18.BATTLE_START_REQ_FIELD.index = 4
var_0_18.BATTLE_START_REQ_FIELD.label = 1
var_0_18.BATTLE_START_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_START_REQ_FIELD.default_value = 0
var_0_18.BATTLE_START_REQ_FIELD.type = 5
var_0_18.BATTLE_START_REQ_FIELD.cpp_type = 1
var_0_18.BATTLE_SHARE_REQ_FIELD.name = "battle_share_req"
var_0_18.BATTLE_SHARE_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_share_req"
var_0_18.BATTLE_SHARE_REQ_FIELD.number = 705
var_0_18.BATTLE_SHARE_REQ_FIELD.index = 5
var_0_18.BATTLE_SHARE_REQ_FIELD.label = 1
var_0_18.BATTLE_SHARE_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_SHARE_REQ_FIELD.default_value = nil
var_0_18.BATTLE_SHARE_REQ_FIELD.message_type = BATTLESHAREREQ
var_0_18.BATTLE_SHARE_REQ_FIELD.type = 11
var_0_18.BATTLE_SHARE_REQ_FIELD.cpp_type = 10
var_0_18.BATTLE_CHAT_REQ_FIELD.name = "battle_chat_req"
var_0_18.BATTLE_CHAT_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_chat_req"
var_0_18.BATTLE_CHAT_REQ_FIELD.number = 706
var_0_18.BATTLE_CHAT_REQ_FIELD.index = 6
var_0_18.BATTLE_CHAT_REQ_FIELD.label = 1
var_0_18.BATTLE_CHAT_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_CHAT_REQ_FIELD.default_value = ""
var_0_18.BATTLE_CHAT_REQ_FIELD.type = 9
var_0_18.BATTLE_CHAT_REQ_FIELD.cpp_type = 9
var_0_18.BATTLE_TUTORIAL_REQ_FIELD.name = "battle_tutorial_req"
var_0_18.BATTLE_TUTORIAL_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_tutorial_req"
var_0_18.BATTLE_TUTORIAL_REQ_FIELD.number = 707
var_0_18.BATTLE_TUTORIAL_REQ_FIELD.index = 7
var_0_18.BATTLE_TUTORIAL_REQ_FIELD.label = 1
var_0_18.BATTLE_TUTORIAL_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_TUTORIAL_REQ_FIELD.default_value = 0
var_0_18.BATTLE_TUTORIAL_REQ_FIELD.type = 5
var_0_18.BATTLE_TUTORIAL_REQ_FIELD.cpp_type = 1
var_0_18.BATTLE_LOG_REQ_FIELD.name = "battle_log_req"
var_0_18.BATTLE_LOG_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_log_req"
var_0_18.BATTLE_LOG_REQ_FIELD.number = 708
var_0_18.BATTLE_LOG_REQ_FIELD.index = 8
var_0_18.BATTLE_LOG_REQ_FIELD.label = 1
var_0_18.BATTLE_LOG_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_LOG_REQ_FIELD.default_value = ""
var_0_18.BATTLE_LOG_REQ_FIELD.type = 9
var_0_18.BATTLE_LOG_REQ_FIELD.cpp_type = 9
var_0_18.BATTLE_AGAIN_REQ_FIELD.name = "battle_again_req"
var_0_18.BATTLE_AGAIN_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_again_req"
var_0_18.BATTLE_AGAIN_REQ_FIELD.number = 709
var_0_18.BATTLE_AGAIN_REQ_FIELD.index = 9
var_0_18.BATTLE_AGAIN_REQ_FIELD.label = 1
var_0_18.BATTLE_AGAIN_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_AGAIN_REQ_FIELD.default_value = 0
var_0_18.BATTLE_AGAIN_REQ_FIELD.type = 5
var_0_18.BATTLE_AGAIN_REQ_FIELD.cpp_type = 1
var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD.name = "battle_replay_tutorial_req"
var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_replay_tutorial_req"
var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD.number = 710
var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD.index = 10
var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD.label = 1
var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD.default_value = 0
var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD.type = 3
var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD.cpp_type = 2
var_0_18.BATTLE_THUMBS_UP_REQ_FIELD.name = "battle_thumbs_up_req"
var_0_18.BATTLE_THUMBS_UP_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_thumbs_up_req"
var_0_18.BATTLE_THUMBS_UP_REQ_FIELD.number = 711
var_0_18.BATTLE_THUMBS_UP_REQ_FIELD.index = 11
var_0_18.BATTLE_THUMBS_UP_REQ_FIELD.label = 1
var_0_18.BATTLE_THUMBS_UP_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_THUMBS_UP_REQ_FIELD.default_value = 0
var_0_18.BATTLE_THUMBS_UP_REQ_FIELD.type = 3
var_0_18.BATTLE_THUMBS_UP_REQ_FIELD.cpp_type = 2
var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD.name = "battle_replay_share_req"
var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_replay_share_req"
var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD.number = 712
var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD.index = 12
var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD.label = 1
var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD.default_value = 0
var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD.type = 3
var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD.cpp_type = 2
var_0_18.BATTLE_LOG_EX_REQ_FIELD.name = "battle_log_ex_req"
var_0_18.BATTLE_LOG_EX_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_log_ex_req"
var_0_18.BATTLE_LOG_EX_REQ_FIELD.number = 713
var_0_18.BATTLE_LOG_EX_REQ_FIELD.index = 13
var_0_18.BATTLE_LOG_EX_REQ_FIELD.label = 1
var_0_18.BATTLE_LOG_EX_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_LOG_EX_REQ_FIELD.default_value = 0
var_0_18.BATTLE_LOG_EX_REQ_FIELD.type = 5
var_0_18.BATTLE_LOG_EX_REQ_FIELD.cpp_type = 1
var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD.name = "battle_set_match_hp_req"
var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD.full_name = ".sgland.SglBattleMsg.battle_set_match_hp_req"
var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD.number = 714
var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD.index = 14
var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD.label = 1
var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD.has_default_value = false
var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD.default_value = 0
var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD.type = 5
var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD.cpp_type = 1
var_0_18.BATTLE_END_RESP_FIELD.name = "battle_end_resp"
var_0_18.BATTLE_END_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_end_resp"
var_0_18.BATTLE_END_RESP_FIELD.number = 700
var_0_18.BATTLE_END_RESP_FIELD.index = 15
var_0_18.BATTLE_END_RESP_FIELD.label = 1
var_0_18.BATTLE_END_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_END_RESP_FIELD.default_value = nil
var_0_18.BATTLE_END_RESP_FIELD.message_type = BATTLEENDRESP
var_0_18.BATTLE_END_RESP_FIELD.type = 11
var_0_18.BATTLE_END_RESP_FIELD.cpp_type = 10
var_0_18.BATTLE_LOG_RESP_FIELD.name = "battle_log_resp"
var_0_18.BATTLE_LOG_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_log_resp"
var_0_18.BATTLE_LOG_RESP_FIELD.number = 701
var_0_18.BATTLE_LOG_RESP_FIELD.index = 16
var_0_18.BATTLE_LOG_RESP_FIELD.label = 1
var_0_18.BATTLE_LOG_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_LOG_RESP_FIELD.default_value = nil
var_0_18.BATTLE_LOG_RESP_FIELD.message_type = BATTLELOGRESP
var_0_18.BATTLE_LOG_RESP_FIELD.type = 11
var_0_18.BATTLE_LOG_RESP_FIELD.cpp_type = 10
var_0_18.BATTLE_REPLAY_RESP_FIELD.name = "battle_replay_resp"
var_0_18.BATTLE_REPLAY_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_replay_resp"
var_0_18.BATTLE_REPLAY_RESP_FIELD.number = 702
var_0_18.BATTLE_REPLAY_RESP_FIELD.index = 17
var_0_18.BATTLE_REPLAY_RESP_FIELD.label = 1
var_0_18.BATTLE_REPLAY_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_REPLAY_RESP_FIELD.default_value = nil
var_0_18.BATTLE_REPLAY_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_18.BATTLE_REPLAY_RESP_FIELD.type = 11
var_0_18.BATTLE_REPLAY_RESP_FIELD.cpp_type = 10
var_0_18.BATTLE_SHARE_RESP_FIELD.name = "battle_share_resp"
var_0_18.BATTLE_SHARE_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_share_resp"
var_0_18.BATTLE_SHARE_RESP_FIELD.number = 703
var_0_18.BATTLE_SHARE_RESP_FIELD.index = 18
var_0_18.BATTLE_SHARE_RESP_FIELD.label = 3
var_0_18.BATTLE_SHARE_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_SHARE_RESP_FIELD.default_value = {}
var_0_18.BATTLE_SHARE_RESP_FIELD.message_type = BATTLESHARE
var_0_18.BATTLE_SHARE_RESP_FIELD.type = 11
var_0_18.BATTLE_SHARE_RESP_FIELD.cpp_type = 10
var_0_18.BATTLE_RECOVER_RESP_FIELD.name = "battle_recover_resp"
var_0_18.BATTLE_RECOVER_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_recover_resp"
var_0_18.BATTLE_RECOVER_RESP_FIELD.number = 704
var_0_18.BATTLE_RECOVER_RESP_FIELD.index = 19
var_0_18.BATTLE_RECOVER_RESP_FIELD.label = 1
var_0_18.BATTLE_RECOVER_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_RECOVER_RESP_FIELD.default_value = nil
var_0_18.BATTLE_RECOVER_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_18.BATTLE_RECOVER_RESP_FIELD.type = 11
var_0_18.BATTLE_RECOVER_RESP_FIELD.cpp_type = 10
var_0_18.BATTLE_OP_USECARD_RESP_FIELD.name = "battle_op_usecard_resp"
var_0_18.BATTLE_OP_USECARD_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_op_usecard_resp"
var_0_18.BATTLE_OP_USECARD_RESP_FIELD.number = 705
var_0_18.BATTLE_OP_USECARD_RESP_FIELD.index = 20
var_0_18.BATTLE_OP_USECARD_RESP_FIELD.label = 3
var_0_18.BATTLE_OP_USECARD_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_OP_USECARD_RESP_FIELD.default_value = {}
var_0_18.BATTLE_OP_USECARD_RESP_FIELD.type = 5
var_0_18.BATTLE_OP_USECARD_RESP_FIELD.cpp_type = 1
var_0_18.BATTLE_CHAT_RESP_FIELD.name = "battle_chat_resp"
var_0_18.BATTLE_CHAT_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_chat_resp"
var_0_18.BATTLE_CHAT_RESP_FIELD.number = 706
var_0_18.BATTLE_CHAT_RESP_FIELD.index = 21
var_0_18.BATTLE_CHAT_RESP_FIELD.label = 1
var_0_18.BATTLE_CHAT_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_CHAT_RESP_FIELD.default_value = ""
var_0_18.BATTLE_CHAT_RESP_FIELD.type = 9
var_0_18.BATTLE_CHAT_RESP_FIELD.cpp_type = 9
var_0_18.BATTLE_TUTORIAL_RESP_FIELD.name = "battle_tutorial_resp"
var_0_18.BATTLE_TUTORIAL_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_tutorial_resp"
var_0_18.BATTLE_TUTORIAL_RESP_FIELD.number = 707
var_0_18.BATTLE_TUTORIAL_RESP_FIELD.index = 22
var_0_18.BATTLE_TUTORIAL_RESP_FIELD.label = 3
var_0_18.BATTLE_TUTORIAL_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_TUTORIAL_RESP_FIELD.default_value = {}
var_0_18.BATTLE_TUTORIAL_RESP_FIELD.message_type = BATTLETUTORIAL
var_0_18.BATTLE_TUTORIAL_RESP_FIELD.type = 11
var_0_18.BATTLE_TUTORIAL_RESP_FIELD.cpp_type = 10
var_0_18.BATTLE_THUMBS_UP_RESP_FIELD.name = "battle_thumbs_up_resp"
var_0_18.BATTLE_THUMBS_UP_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_thumbs_up_resp"
var_0_18.BATTLE_THUMBS_UP_RESP_FIELD.number = 708
var_0_18.BATTLE_THUMBS_UP_RESP_FIELD.index = 23
var_0_18.BATTLE_THUMBS_UP_RESP_FIELD.label = 1
var_0_18.BATTLE_THUMBS_UP_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_THUMBS_UP_RESP_FIELD.default_value = nil
var_0_18.BATTLE_THUMBS_UP_RESP_FIELD.message_type = BATTLESHAREEVENT
var_0_18.BATTLE_THUMBS_UP_RESP_FIELD.type = 11
var_0_18.BATTLE_THUMBS_UP_RESP_FIELD.cpp_type = 10
var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD.name = "battle_share_watch_resp"
var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_share_watch_resp"
var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD.number = 709
var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD.index = 24
var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD.label = 1
var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD.default_value = nil
var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD.message_type = BATTLESHAREEVENT
var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD.type = 11
var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD.cpp_type = 10
var_0_18.BATTLE_LOG_EX_RESP_FIELD.name = "battle_log_ex_resp"
var_0_18.BATTLE_LOG_EX_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_log_ex_resp"
var_0_18.BATTLE_LOG_EX_RESP_FIELD.number = 710
var_0_18.BATTLE_LOG_EX_RESP_FIELD.index = 25
var_0_18.BATTLE_LOG_EX_RESP_FIELD.label = 1
var_0_18.BATTLE_LOG_EX_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_LOG_EX_RESP_FIELD.default_value = nil
var_0_18.BATTLE_LOG_EX_RESP_FIELD.message_type = BATTLELOGEXRESP
var_0_18.BATTLE_LOG_EX_RESP_FIELD.type = 11
var_0_18.BATTLE_LOG_EX_RESP_FIELD.cpp_type = 10
var_0_18.BATTLE_LADDER_RESP_FIELD.name = "battle_ladder_resp"
var_0_18.BATTLE_LADDER_RESP_FIELD.full_name = ".sgland.SglBattleMsg.battle_ladder_resp"
var_0_18.BATTLE_LADDER_RESP_FIELD.number = 711
var_0_18.BATTLE_LADDER_RESP_FIELD.index = 26
var_0_18.BATTLE_LADDER_RESP_FIELD.label = 1
var_0_18.BATTLE_LADDER_RESP_FIELD.has_default_value = false
var_0_18.BATTLE_LADDER_RESP_FIELD.default_value = nil
var_0_18.BATTLE_LADDER_RESP_FIELD.message_type = BATTLELADDERRESP
var_0_18.BATTLE_LADDER_RESP_FIELD.type = 11
var_0_18.BATTLE_LADDER_RESP_FIELD.cpp_type = 10
SGLBATTLEMSG.name = "SglBattleMsg"
SGLBATTLEMSG.full_name = ".sgland.SglBattleMsg"
SGLBATTLEMSG.nested_types = {}
SGLBATTLEMSG.enum_types = {}
SGLBATTLEMSG.fields = {}
SGLBATTLEMSG.is_extendable = false
SGLBATTLEMSG.extensions = {
	var_0_18.BATTLE_END_REQ_FIELD,
	var_0_18.BATTLE_USECARD_REQ_FIELD,
	var_0_18.BATTLE_OP_USECARD_REQ_FIELD,
	var_0_18.BATTLE_REPLAY_REQ_FIELD,
	var_0_18.BATTLE_START_REQ_FIELD,
	var_0_18.BATTLE_SHARE_REQ_FIELD,
	var_0_18.BATTLE_CHAT_REQ_FIELD,
	var_0_18.BATTLE_TUTORIAL_REQ_FIELD,
	var_0_18.BATTLE_LOG_REQ_FIELD,
	var_0_18.BATTLE_AGAIN_REQ_FIELD,
	var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD,
	var_0_18.BATTLE_THUMBS_UP_REQ_FIELD,
	var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD,
	var_0_18.BATTLE_LOG_EX_REQ_FIELD,
	var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD,
	var_0_18.BATTLE_END_RESP_FIELD,
	var_0_18.BATTLE_LOG_RESP_FIELD,
	var_0_18.BATTLE_REPLAY_RESP_FIELD,
	var_0_18.BATTLE_SHARE_RESP_FIELD,
	var_0_18.BATTLE_RECOVER_RESP_FIELD,
	var_0_18.BATTLE_OP_USECARD_RESP_FIELD,
	var_0_18.BATTLE_CHAT_RESP_FIELD,
	var_0_18.BATTLE_TUTORIAL_RESP_FIELD,
	var_0_18.BATTLE_THUMBS_UP_RESP_FIELD,
	var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD,
	var_0_18.BATTLE_LOG_EX_RESP_FIELD,
	var_0_18.BATTLE_LADDER_RESP_FIELD
}
BattleBoss = var_0_0.Message(BATTLEBOSS)
BattleEndResp = var_0_0.Message(BATTLEENDRESP)
BattleExpend = var_0_0.Message(BATTLEEXPEND)
BattleLadderResp = var_0_0.Message(BATTLELADDERRESP)
BattleLog = var_0_0.Message(BATTLELOG)
BattleLogExResp = var_0_0.Message(BATTLELOGEXRESP)
BattleLogResp = var_0_0.Message(BATTLELOGRESP)
BattleShare = var_0_0.Message(BATTLESHARE)
BattleShareEvent = var_0_0.Message(BATTLESHAREEVENT)
BattleShareReq = var_0_0.Message(BATTLESHAREREQ)
BattleTutorial = var_0_0.Message(BATTLETUTORIAL)
DarkDuelBattleEndResp = var_0_0.Message(DARKDUELBATTLEENDRESP)
PB_BATTLE_CHAPTER = 2
PB_BATTLE_CITY = 4
PB_BATTLE_COMMANDER = 6
PB_BATTLE_DARK = 22
PB_BATTLE_DDEND_DRAW = 7
PB_BATTLE_DDEND_ONETWO_LOSE = 2
PB_BATTLE_DDEND_ONEZERO_WIN = 5
PB_BATTLE_DDEND_TWOONE_WIN = 1
PB_BATTLE_DDEND_TWOZERO_WIN = 3
PB_BATTLE_DDEND_ZEROONE_LOSE = 6
PB_BATTLE_DDEND_ZEROTWO_LOSE = 4
PB_BATTLE_DDNOTEND = 8
PB_BATTLE_ELITE = 5
PB_BATTLE_END_DRAW = 0
PB_BATTLE_END_LOSE = -1
PB_BATTLE_END_TERMINAL = 2
PB_BATTLE_END_WIN = 1
PB_BATTLE_EXP = 11
PB_BATTLE_EXPEDITION = 7
PB_BATTLE_EXPEDITION_EX = 18
PB_BATTLE_EXPEDITION_EX_BOSS = 19
PB_BATTLE_FRIEND = 9
PB_BATTLE_GOLD = 8
PB_BATTLE_MASSWAR_MULTIPLE = 21
PB_BATTLE_MATCH = 20
PB_BATTLE_NPC = 3
PB_BATTLE_PLAYER = 1
PB_BATTLE_RESCUE = 12
PB_BATTLE_SURVIVAL = 23
PB_BATTLE_SURVIVAL_EX = 24
PB_BATTLE_UNION = 10
PB_BATTLE_UNION_BOSS = 14
PB_BATTLE_WORLD = 13
PB_BATTLE_WORLD_BOSS = 15
PB_BATTLE_WORLD_LADDER = 16
PB_BATTLE_WORLD_LADDER_EX = 17
PB_BATTLE_WORLD_LEGEND = 25
SglBattleMsg = var_0_0.Message(SGLBATTLEMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_END_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_USECARD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_OP_USECARD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_REPLAY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_START_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_SHARE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_CHAT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_TUTORIAL_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_LOG_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_AGAIN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_REPLAY_TUTORIAL_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_THUMBS_UP_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_REPLAY_SHARE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_LOG_EX_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.BATTLE_SET_MATCH_HP_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_END_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_LOG_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_REPLAY_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_SHARE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_RECOVER_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_OP_USECARD_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_CHAT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_TUTORIAL_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_THUMBS_UP_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_SHARE_WATCH_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_LOG_EX_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BATTLE_LADDER_RESP_FIELD)
