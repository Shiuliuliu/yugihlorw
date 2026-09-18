local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")
local var_0_3 = require("Battle_pb")

module("World_pb")

WORLDCITY = var_0_0.Descriptor()

local var_0_4 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	CHAPTER_FIELD = var_0_0.FieldDescriptor()
}

WORLDBATTLERESULT = var_0_0.Descriptor()

local var_0_5 = {
	ATK_ID_FIELD = var_0_0.FieldDescriptor(),
	DEF_ID_FIELD = var_0_0.FieldDescriptor(),
	ATK_INFO_FIELD = var_0_0.FieldDescriptor(),
	DEF_INFO_FIELD = var_0_0.FieldDescriptor(),
	ATK_RESP_FIELD = var_0_0.FieldDescriptor(),
	DEF_RESP_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_TYPE_FIELD = var_0_0.FieldDescriptor(),
	PVP_ID_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_ID_FIELD = var_0_0.FieldDescriptor(),
	CREATOR_ID_FIELD = var_0_0.FieldDescriptor(),
	ATK_RID_TEAMID_FIELD = var_0_0.FieldDescriptor(),
	DEF_RID_TEAMID_FIELD = var_0_0.FieldDescriptor()
}

DDRECHEATRESULT = var_0_0.Descriptor()

local var_0_6 = {
	ATK_ID_FIELD = var_0_0.FieldDescriptor(),
	DEF_ID_FIELD = var_0_0.FieldDescriptor(),
	ATK_RESP_FIELD = var_0_0.FieldDescriptor(),
	DEF_RESP_FIELD = var_0_0.FieldDescriptor()
}

WORLDSWEEPRESULT = var_0_0.Descriptor()

local var_0_7 = {
	RESOURCE_FIELD = var_0_0.FieldDescriptor()
}

WORLDATTACKREQ = var_0_0.Descriptor()

local var_0_8 = {
	TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_ID_FIELD = var_0_0.FieldDescriptor()
}

WORLDCHALLENGEREQ = var_0_0.Descriptor()

local var_0_9 = {
	TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	CITY_FIELD = var_0_0.FieldDescriptor()
}

WORLDCHALLENGECOPYREQ = var_0_0.Descriptor()

local var_0_10 = {
	TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	COPY_ID_FIELD = var_0_0.FieldDescriptor()
}

WORLDSOSREQ = var_0_0.Descriptor()

local var_0_11 = {
	CITY_ID_FIELD = var_0_0.FieldDescriptor(),
	MEMBER_ID_FIELD = var_0_0.FieldDescriptor(),
	CONTENT_FIELD = var_0_0.FieldDescriptor()
}

WORLDRESCUEREQ = var_0_0.Descriptor()

local var_0_12 = {
	TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	MAIL_ID_FIELD = var_0_0.FieldDescriptor()
}

WORLDFINDREQ = var_0_0.Descriptor()

local var_0_13 = {
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	MATCH_VALUE_FIELD = var_0_0.FieldDescriptor(),
	IS_ROOKIE_FIELD = var_0_0.FieldDescriptor(),
	RID_FIELD = var_0_0.FieldDescriptor(),
	TEAM_ID_FIELD = var_0_0.FieldDescriptor(),
	TOTAL_LADDER_WIN_FIELD = var_0_0.FieldDescriptor(),
	REG_DAY_FIELD = var_0_0.FieldDescriptor(),
	NPC_TYPE_FIELD = var_0_0.FieldDescriptor()
}

WORLDFINDEXREQ = var_0_0.Descriptor()

local var_0_14 = {
	TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor()
}

WORLDROBGOLDREQ = var_0_0.Descriptor()

local var_0_15 = {
	TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	COPY_ID_FIELD = var_0_0.FieldDescriptor(),
	PROP_ID_FIELD = var_0_0.FieldDescriptor()
}

WORLDSWEEPCOPYREQ = var_0_0.Descriptor()

local var_0_16 = {
	COPY_ID_FIELD = var_0_0.FieldDescriptor(),
	PROP_ID_FIELD = var_0_0.FieldDescriptor()
}

WORLDBATTLEJOINREQ = var_0_0.Descriptor()

local var_0_17 = {
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_ID_FIELD = var_0_0.FieldDescriptor()
}

WORLDFINDSTARTREQ = var_0_0.Descriptor()

local var_0_18 = {
	TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	CHOICE_FIELD = var_0_0.FieldDescriptor()
}

WORLDEXPEDITIONEXREQ = var_0_0.Descriptor()

local var_0_19 = {
	TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	NPC_ID_FIELD = var_0_0.FieldDescriptor()
}

WORLDMATCHJOINREQ = var_0_0.Descriptor()

local var_0_20 = {
	MATCH_ID_FIELD = var_0_0.FieldDescriptor(),
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor(),
	IS_CREATE_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor()
}

WORLDSURVIVALHALLJOINREQ = var_0_0.Descriptor()

local var_0_21 = {
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	HALL_ID_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor()
}

WORLDSURVIVALEXHALLJOINREQ = var_0_0.Descriptor()

local var_0_22 = {
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	HALL_ID_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor()
}

WORLDFINDRESP = var_0_0.Descriptor()

local var_0_23 = {
	OPPONENTS_FIELD = var_0_0.FieldDescriptor(),
	OPPONENT_RANKS_FIELD = var_0_0.FieldDescriptor(),
	RANK_FIELD = var_0_0.FieldDescriptor()
}

WORLDSWEEPRESP = var_0_0.Descriptor()

local var_0_24 = {
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	RESULT_FIELD = var_0_0.FieldDescriptor()
}

WORLDBATTLESTARTRESP = var_0_0.Descriptor()

local var_0_25 = {
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	IS_REVENGE_FIELD = var_0_0.FieldDescriptor(),
	IS_RESCUE_FIELD = var_0_0.FieldDescriptor()
}

WORLDGETEXPEDITIONRESP = var_0_0.Descriptor()

local var_0_26 = {
	DATA_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor()
}

WORLDFOCUSRESP = var_0_0.Descriptor()

local var_0_27 = {
	INFO_FIELD = var_0_0.FieldDescriptor(),
	STATUS_FIELD = var_0_0.FieldDescriptor()
}

WORLDGETOPPONENTRESP = var_0_0.Descriptor()

local var_0_28 = {
	CITY_ID_FIELD = var_0_0.FieldDescriptor(),
	OPPONENT_ID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

WORLDFINDEXRESP = var_0_0.Descriptor()

local var_0_29 = {
	PVP_ID_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_ID_FIELD = var_0_0.FieldDescriptor()
}

LOTTERYUNOPENLIST = var_0_0.Descriptor()

local var_0_30 = {
	PERIOD_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_COUNT_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_PROGRESS_FIELD = var_0_0.FieldDescriptor()
}

LOTTERYOPENLIST = var_0_0.Descriptor()

local var_0_31 = {
	PERIOD_FIELD = var_0_0.FieldDescriptor(),
	USER_INFO_FIELD = var_0_0.FieldDescriptor()
}

RECOMMENDCARDREQ = var_0_0.Descriptor()

local var_0_32 = {
	VIP_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor()
}

DARKDUELDASHBOARD = var_0_0.Descriptor()

local var_0_33 = {
	TOTAL_WIN_FIELD = var_0_0.FieldDescriptor(),
	TOTAL_LOSE_FIELD = var_0_0.FieldDescriptor(),
	TWO_ZERO_WIN_FIELD = var_0_0.FieldDescriptor(),
	ZERO_TWO_LOSE_FIELD = var_0_0.FieldDescriptor(),
	TWO_ONE_WIN_FIELD = var_0_0.FieldDescriptor(),
	ONE_TWO_LOSE_FIELD = var_0_0.FieldDescriptor(),
	ONE_ZERO_WIN_FIELD = var_0_0.FieldDescriptor(),
	ZERO_ONE_LOSE_FIELD = var_0_0.FieldDescriptor()
}

WORSHIPMVP = var_0_0.Descriptor()

local var_0_34 = {
	MVP_TYPE_FIELD = var_0_0.FieldDescriptor(),
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALEXPLORESTARTREQ = var_0_0.Descriptor()

local var_0_35 = {
	CARDS_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALEXPLOREENDRESP = var_0_0.Descriptor()

local var_0_36 = {
	GAMEOVER_TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	CAPTURES_FIELD = var_0_0.FieldDescriptor(),
	GAIN_TIME_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALENDRESP = var_0_0.Descriptor()

local var_0_37 = {
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	RANK_FIELD = var_0_0.FieldDescriptor(),
	RESOURCE_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALEXEXPLORESTARTREQ = var_0_0.Descriptor()

local var_0_38 = {
	CARDS_FIELD = var_0_0.FieldDescriptor(),
	CARD_EXTRA_SKILLS_FIELD = var_0_0.FieldDescriptor(),
	HAS_PRIVILEGE_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALEXEXPLOREENDRESP = var_0_0.Descriptor()

local var_0_39 = {
	GAMEOVER_TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	CAPTURES_FIELD = var_0_0.FieldDescriptor(),
	GAIN_SKILLS_FIELD = var_0_0.FieldDescriptor(),
	GAIN_TIME_FIELD = var_0_0.FieldDescriptor(),
	WIN_FIELD = var_0_0.FieldDescriptor(),
	LOSE_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALEXENDRESP = var_0_0.Descriptor()

local var_0_40 = {
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	RANK_FIELD = var_0_0.FieldDescriptor(),
	RESOURCE_FIELD = var_0_0.FieldDescriptor(),
	WIN_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALEXEQUIPSKILLREQ = var_0_0.Descriptor()

local var_0_41 = {
	CARD_FIELD = var_0_0.FieldDescriptor(),
	SKILLS_FIELD = var_0_0.FieldDescriptor()
}

SGLWORLDMSG = var_0_0.Descriptor()

local var_0_42 = {
	WORLD_ATTACK_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_CHALLENGE_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SWEEP_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SCOUT_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_RESET_SWEEP_COUNT_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_CHALLENGE_COMMANDER_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_CHALLENGE_ELITE_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_FIND_START_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_BATTLE_JOIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_ROB_EXP_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SWEEP_COPY_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SOS_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_RESCUE_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_RESCUE_JOIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_FIND_EX_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_FIND_SERVER_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_BATTLE_JOIN_SERVER_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_PROXY_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_INFO_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_TIME_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_ROB_GOLD_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_EXPEDITION_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_EXPEDITION_EX_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_LOTTERY_USER_TOKEN_FIELD = var_0_0.FieldDescriptor(),
	WORLD_BUY_TICKET_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SELECT_CHAR_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SELECT_CARD_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_LOTTERY_COUNT_FIELD = var_0_0.FieldDescriptor(),
	WORLD_CREATE_MATCH_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_QUERY_MATCH_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_JOIN_MATCH_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_RECYCLE_MATCH_REQ_FIELD = var_0_0.FieldDescriptor(),
	SYNC_TEAM_INFO_REQ_FIELD = var_0_0.FieldDescriptor(),
	SYNC_LEGEND_LOTTERY_REQ_FIELD = var_0_0.FieldDescriptor(),
	RECOMMEND_CARD_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_MATCH_TYPE_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_SELECT_DARK_TROOP_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORSHIP_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_LOTTERY_EX_COUNT_FIELD = var_0_0.FieldDescriptor(),
	CHARGE_RMB_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_BUY_LEGEND_TICKET_REQ_FIELD = var_0_0.FieldDescriptor(),
	WORLD_ATTACK_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_FIND_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_CHALLENGE_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SWEEP_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SCOUT_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_CHALLENGE_ELITE_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_CHALLENGE_COMMANDER_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_EXPEDITION_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_REFRESH_EXPEDITION_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_GET_EXPEDITION_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_EXPEDITION_OPEN_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_FIND_START_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_BATTLE_START_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_BATTLE_END_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_ROB_GOLD_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_ROB_EXP_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_RESCUE_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_RESCUE_END_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_FOCUS_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_FIND_EX_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_GET_OPPONENT_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_RESET_TROOP_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_OPPONENT_NOT_FOUND_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_EXPEDITION_EX_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_LOTTERY_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_GET_EXPEDITION_EX_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SELECT_CHAR_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_QUIT_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_BUY_TICKET_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SELECT_CARD_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_GET_MATCH_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_MATCH_INFO_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_USER_ID_RESP_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_UNOPEN_LIST_RESP_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_OPEN_LIST_RESP_FIELD = var_0_0.FieldDescriptor(),
	RECOMMEND_TROOP_RESP_FIELD = var_0_0.FieldDescriptor(),
	DARK_DUEL_DASH_BOARD_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_HALL_INFO_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_EXPLORE_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_END_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORSHIP_MVPS_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_LOTTERY_EX_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_ROLL_CHAR_RESP_FIELD = var_0_0.FieldDescriptor(),
	ENVELOPE_DELAY_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_SURVIVAL_EX_END_RESP_FIELD = var_0_0.FieldDescriptor(),
	WORLD_QUIT_LEGEND_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_4.ID_FIELD.name = "id"
var_0_4.ID_FIELD.full_name = ".sgland.WorldCity.id"
var_0_4.ID_FIELD.number = 1
var_0_4.ID_FIELD.index = 0
var_0_4.ID_FIELD.label = 2
var_0_4.ID_FIELD.has_default_value = false
var_0_4.ID_FIELD.default_value = 0
var_0_4.ID_FIELD.type = 5
var_0_4.ID_FIELD.cpp_type = 1
var_0_4.CHAPTER_FIELD.name = "chapter"
var_0_4.CHAPTER_FIELD.full_name = ".sgland.WorldCity.chapter"
var_0_4.CHAPTER_FIELD.number = 2
var_0_4.CHAPTER_FIELD.index = 1
var_0_4.CHAPTER_FIELD.label = 2
var_0_4.CHAPTER_FIELD.has_default_value = false
var_0_4.CHAPTER_FIELD.default_value = 0
var_0_4.CHAPTER_FIELD.type = 5
var_0_4.CHAPTER_FIELD.cpp_type = 1
WORLDCITY.name = "WorldCity"
WORLDCITY.full_name = ".sgland.WorldCity"
WORLDCITY.nested_types = {}
WORLDCITY.enum_types = {}
WORLDCITY.fields = {
	var_0_4.ID_FIELD,
	var_0_4.CHAPTER_FIELD
}
WORLDCITY.is_extendable = false
WORLDCITY.extensions = {}
var_0_5.ATK_ID_FIELD.name = "atk_id"
var_0_5.ATK_ID_FIELD.full_name = ".sgland.WorldBattleResult.atk_id"
var_0_5.ATK_ID_FIELD.number = 1
var_0_5.ATK_ID_FIELD.index = 0
var_0_5.ATK_ID_FIELD.label = 2
var_0_5.ATK_ID_FIELD.has_default_value = false
var_0_5.ATK_ID_FIELD.default_value = 0
var_0_5.ATK_ID_FIELD.type = 3
var_0_5.ATK_ID_FIELD.cpp_type = 2
var_0_5.DEF_ID_FIELD.name = "def_id"
var_0_5.DEF_ID_FIELD.full_name = ".sgland.WorldBattleResult.def_id"
var_0_5.DEF_ID_FIELD.number = 2
var_0_5.DEF_ID_FIELD.index = 1
var_0_5.DEF_ID_FIELD.label = 2
var_0_5.DEF_ID_FIELD.has_default_value = false
var_0_5.DEF_ID_FIELD.default_value = 0
var_0_5.DEF_ID_FIELD.type = 3
var_0_5.DEF_ID_FIELD.cpp_type = 2
var_0_5.ATK_INFO_FIELD.name = "atk_info"
var_0_5.ATK_INFO_FIELD.full_name = ".sgland.WorldBattleResult.atk_info"
var_0_5.ATK_INFO_FIELD.number = 3
var_0_5.ATK_INFO_FIELD.index = 2
var_0_5.ATK_INFO_FIELD.label = 2
var_0_5.ATK_INFO_FIELD.has_default_value = false
var_0_5.ATK_INFO_FIELD.default_value = nil
var_0_5.ATK_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_5.ATK_INFO_FIELD.type = 11
var_0_5.ATK_INFO_FIELD.cpp_type = 10
var_0_5.DEF_INFO_FIELD.name = "def_info"
var_0_5.DEF_INFO_FIELD.full_name = ".sgland.WorldBattleResult.def_info"
var_0_5.DEF_INFO_FIELD.number = 4
var_0_5.DEF_INFO_FIELD.index = 3
var_0_5.DEF_INFO_FIELD.label = 2
var_0_5.DEF_INFO_FIELD.has_default_value = false
var_0_5.DEF_INFO_FIELD.default_value = nil
var_0_5.DEF_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_5.DEF_INFO_FIELD.type = 11
var_0_5.DEF_INFO_FIELD.cpp_type = 10
var_0_5.ATK_RESP_FIELD.name = "atk_resp"
var_0_5.ATK_RESP_FIELD.full_name = ".sgland.WorldBattleResult.atk_resp"
var_0_5.ATK_RESP_FIELD.number = 5
var_0_5.ATK_RESP_FIELD.index = 4
var_0_5.ATK_RESP_FIELD.label = 2
var_0_5.ATK_RESP_FIELD.has_default_value = false
var_0_5.ATK_RESP_FIELD.default_value = nil
var_0_5.ATK_RESP_FIELD.message_type = var_0_1.SGLRESPMSG
var_0_5.ATK_RESP_FIELD.type = 11
var_0_5.ATK_RESP_FIELD.cpp_type = 10
var_0_5.DEF_RESP_FIELD.name = "def_resp"
var_0_5.DEF_RESP_FIELD.full_name = ".sgland.WorldBattleResult.def_resp"
var_0_5.DEF_RESP_FIELD.number = 6
var_0_5.DEF_RESP_FIELD.index = 5
var_0_5.DEF_RESP_FIELD.label = 2
var_0_5.DEF_RESP_FIELD.has_default_value = false
var_0_5.DEF_RESP_FIELD.default_value = nil
var_0_5.DEF_RESP_FIELD.message_type = var_0_1.SGLRESPMSG
var_0_5.DEF_RESP_FIELD.type = 11
var_0_5.DEF_RESP_FIELD.cpp_type = 10
var_0_5.BATTLE_TYPE_FIELD.name = "battle_type"
var_0_5.BATTLE_TYPE_FIELD.full_name = ".sgland.WorldBattleResult.battle_type"
var_0_5.BATTLE_TYPE_FIELD.number = 7
var_0_5.BATTLE_TYPE_FIELD.index = 6
var_0_5.BATTLE_TYPE_FIELD.label = 2
var_0_5.BATTLE_TYPE_FIELD.has_default_value = false
var_0_5.BATTLE_TYPE_FIELD.default_value = nil
var_0_5.BATTLE_TYPE_FIELD.enum_type = var_0_3.BATTLETYPE
var_0_5.BATTLE_TYPE_FIELD.type = 14
var_0_5.BATTLE_TYPE_FIELD.cpp_type = 8
var_0_5.PVP_ID_FIELD.name = "pvp_id"
var_0_5.PVP_ID_FIELD.full_name = ".sgland.WorldBattleResult.pvp_id"
var_0_5.PVP_ID_FIELD.number = 8
var_0_5.PVP_ID_FIELD.index = 7
var_0_5.PVP_ID_FIELD.label = 2
var_0_5.PVP_ID_FIELD.has_default_value = false
var_0_5.PVP_ID_FIELD.default_value = 0
var_0_5.PVP_ID_FIELD.type = 5
var_0_5.PVP_ID_FIELD.cpp_type = 1
var_0_5.BATTLE_ID_FIELD.name = "battle_id"
var_0_5.BATTLE_ID_FIELD.full_name = ".sgland.WorldBattleResult.battle_id"
var_0_5.BATTLE_ID_FIELD.number = 9
var_0_5.BATTLE_ID_FIELD.index = 8
var_0_5.BATTLE_ID_FIELD.label = 2
var_0_5.BATTLE_ID_FIELD.has_default_value = false
var_0_5.BATTLE_ID_FIELD.default_value = 0
var_0_5.BATTLE_ID_FIELD.type = 3
var_0_5.BATTLE_ID_FIELD.cpp_type = 2
var_0_5.CREATOR_ID_FIELD.name = "creator_id"
var_0_5.CREATOR_ID_FIELD.full_name = ".sgland.WorldBattleResult.creator_id"
var_0_5.CREATOR_ID_FIELD.number = 10
var_0_5.CREATOR_ID_FIELD.index = 9
var_0_5.CREATOR_ID_FIELD.label = 1
var_0_5.CREATOR_ID_FIELD.has_default_value = false
var_0_5.CREATOR_ID_FIELD.default_value = 0
var_0_5.CREATOR_ID_FIELD.type = 3
var_0_5.CREATOR_ID_FIELD.cpp_type = 2
var_0_5.ATK_RID_TEAMID_FIELD.name = "atk_rid_teamId"
var_0_5.ATK_RID_TEAMID_FIELD.full_name = ".sgland.WorldBattleResult.atk_rid_teamId"
var_0_5.ATK_RID_TEAMID_FIELD.number = 11
var_0_5.ATK_RID_TEAMID_FIELD.index = 10
var_0_5.ATK_RID_TEAMID_FIELD.label = 1
var_0_5.ATK_RID_TEAMID_FIELD.has_default_value = false
var_0_5.ATK_RID_TEAMID_FIELD.default_value = ""
var_0_5.ATK_RID_TEAMID_FIELD.type = 9
var_0_5.ATK_RID_TEAMID_FIELD.cpp_type = 9
var_0_5.DEF_RID_TEAMID_FIELD.name = "def_rid_teamId"
var_0_5.DEF_RID_TEAMID_FIELD.full_name = ".sgland.WorldBattleResult.def_rid_teamId"
var_0_5.DEF_RID_TEAMID_FIELD.number = 12
var_0_5.DEF_RID_TEAMID_FIELD.index = 11
var_0_5.DEF_RID_TEAMID_FIELD.label = 1
var_0_5.DEF_RID_TEAMID_FIELD.has_default_value = false
var_0_5.DEF_RID_TEAMID_FIELD.default_value = ""
var_0_5.DEF_RID_TEAMID_FIELD.type = 9
var_0_5.DEF_RID_TEAMID_FIELD.cpp_type = 9
WORLDBATTLERESULT.name = "WorldBattleResult"
WORLDBATTLERESULT.full_name = ".sgland.WorldBattleResult"
WORLDBATTLERESULT.nested_types = {}
WORLDBATTLERESULT.enum_types = {}
WORLDBATTLERESULT.fields = {
	var_0_5.ATK_ID_FIELD,
	var_0_5.DEF_ID_FIELD,
	var_0_5.ATK_INFO_FIELD,
	var_0_5.DEF_INFO_FIELD,
	var_0_5.ATK_RESP_FIELD,
	var_0_5.DEF_RESP_FIELD,
	var_0_5.BATTLE_TYPE_FIELD,
	var_0_5.PVP_ID_FIELD,
	var_0_5.BATTLE_ID_FIELD,
	var_0_5.CREATOR_ID_FIELD,
	var_0_5.ATK_RID_TEAMID_FIELD,
	var_0_5.DEF_RID_TEAMID_FIELD
}
WORLDBATTLERESULT.is_extendable = false
WORLDBATTLERESULT.extensions = {}
var_0_6.ATK_ID_FIELD.name = "atk_id"
var_0_6.ATK_ID_FIELD.full_name = ".sgland.DDRecheatResult.atk_id"
var_0_6.ATK_ID_FIELD.number = 1
var_0_6.ATK_ID_FIELD.index = 0
var_0_6.ATK_ID_FIELD.label = 2
var_0_6.ATK_ID_FIELD.has_default_value = false
var_0_6.ATK_ID_FIELD.default_value = 0
var_0_6.ATK_ID_FIELD.type = 3
var_0_6.ATK_ID_FIELD.cpp_type = 2
var_0_6.DEF_ID_FIELD.name = "def_id"
var_0_6.DEF_ID_FIELD.full_name = ".sgland.DDRecheatResult.def_id"
var_0_6.DEF_ID_FIELD.number = 2
var_0_6.DEF_ID_FIELD.index = 1
var_0_6.DEF_ID_FIELD.label = 2
var_0_6.DEF_ID_FIELD.has_default_value = false
var_0_6.DEF_ID_FIELD.default_value = 0
var_0_6.DEF_ID_FIELD.type = 3
var_0_6.DEF_ID_FIELD.cpp_type = 2
var_0_6.ATK_RESP_FIELD.name = "atk_resp"
var_0_6.ATK_RESP_FIELD.full_name = ".sgland.DDRecheatResult.atk_resp"
var_0_6.ATK_RESP_FIELD.number = 5
var_0_6.ATK_RESP_FIELD.index = 2
var_0_6.ATK_RESP_FIELD.label = 2
var_0_6.ATK_RESP_FIELD.has_default_value = false
var_0_6.ATK_RESP_FIELD.default_value = nil
var_0_6.ATK_RESP_FIELD.message_type = var_0_1.SGLRESPMSG
var_0_6.ATK_RESP_FIELD.type = 11
var_0_6.ATK_RESP_FIELD.cpp_type = 10
var_0_6.DEF_RESP_FIELD.name = "def_resp"
var_0_6.DEF_RESP_FIELD.full_name = ".sgland.DDRecheatResult.def_resp"
var_0_6.DEF_RESP_FIELD.number = 6
var_0_6.DEF_RESP_FIELD.index = 3
var_0_6.DEF_RESP_FIELD.label = 2
var_0_6.DEF_RESP_FIELD.has_default_value = false
var_0_6.DEF_RESP_FIELD.default_value = nil
var_0_6.DEF_RESP_FIELD.message_type = var_0_1.SGLRESPMSG
var_0_6.DEF_RESP_FIELD.type = 11
var_0_6.DEF_RESP_FIELD.cpp_type = 10
DDRECHEATRESULT.name = "DDRecheatResult"
DDRECHEATRESULT.full_name = ".sgland.DDRecheatResult"
DDRECHEATRESULT.nested_types = {}
DDRECHEATRESULT.enum_types = {}
DDRECHEATRESULT.fields = {
	var_0_6.ATK_ID_FIELD,
	var_0_6.DEF_ID_FIELD,
	var_0_6.ATK_RESP_FIELD,
	var_0_6.DEF_RESP_FIELD
}
DDRECHEATRESULT.is_extendable = false
DDRECHEATRESULT.extensions = {}
var_0_7.RESOURCE_FIELD.name = "resource"
var_0_7.RESOURCE_FIELD.full_name = ".sgland.WorldSweepResult.resource"
var_0_7.RESOURCE_FIELD.number = 1
var_0_7.RESOURCE_FIELD.index = 0
var_0_7.RESOURCE_FIELD.label = 3
var_0_7.RESOURCE_FIELD.has_default_value = false
var_0_7.RESOURCE_FIELD.default_value = {}
var_0_7.RESOURCE_FIELD.message_type = var_0_2.RESOURCE
var_0_7.RESOURCE_FIELD.type = 11
var_0_7.RESOURCE_FIELD.cpp_type = 10
WORLDSWEEPRESULT.name = "WorldSweepResult"
WORLDSWEEPRESULT.full_name = ".sgland.WorldSweepResult"
WORLDSWEEPRESULT.nested_types = {}
WORLDSWEEPRESULT.enum_types = {}
WORLDSWEEPRESULT.fields = {
	var_0_7.RESOURCE_FIELD
}
WORLDSWEEPRESULT.is_extendable = false
WORLDSWEEPRESULT.extensions = {}
var_0_8.TROOP_ID_FIELD.name = "troop_id"
var_0_8.TROOP_ID_FIELD.full_name = ".sgland.WorldAttackReq.troop_id"
var_0_8.TROOP_ID_FIELD.number = 1
var_0_8.TROOP_ID_FIELD.index = 0
var_0_8.TROOP_ID_FIELD.label = 2
var_0_8.TROOP_ID_FIELD.has_default_value = false
var_0_8.TROOP_ID_FIELD.default_value = 0
var_0_8.TROOP_ID_FIELD.type = 5
var_0_8.TROOP_ID_FIELD.cpp_type = 1
var_0_8.LEVEL_ID_FIELD.name = "level_id"
var_0_8.LEVEL_ID_FIELD.full_name = ".sgland.WorldAttackReq.level_id"
var_0_8.LEVEL_ID_FIELD.number = 2
var_0_8.LEVEL_ID_FIELD.index = 1
var_0_8.LEVEL_ID_FIELD.label = 2
var_0_8.LEVEL_ID_FIELD.has_default_value = false
var_0_8.LEVEL_ID_FIELD.default_value = 0
var_0_8.LEVEL_ID_FIELD.type = 5
var_0_8.LEVEL_ID_FIELD.cpp_type = 1
WORLDATTACKREQ.name = "WorldAttackReq"
WORLDATTACKREQ.full_name = ".sgland.WorldAttackReq"
WORLDATTACKREQ.nested_types = {}
WORLDATTACKREQ.enum_types = {}
WORLDATTACKREQ.fields = {
	var_0_8.TROOP_ID_FIELD,
	var_0_8.LEVEL_ID_FIELD
}
WORLDATTACKREQ.is_extendable = false
WORLDATTACKREQ.extensions = {}
var_0_9.TROOP_ID_FIELD.name = "troop_id"
var_0_9.TROOP_ID_FIELD.full_name = ".sgland.WorldChallengeReq.troop_id"
var_0_9.TROOP_ID_FIELD.number = 1
var_0_9.TROOP_ID_FIELD.index = 0
var_0_9.TROOP_ID_FIELD.label = 2
var_0_9.TROOP_ID_FIELD.has_default_value = false
var_0_9.TROOP_ID_FIELD.default_value = 0
var_0_9.TROOP_ID_FIELD.type = 5
var_0_9.TROOP_ID_FIELD.cpp_type = 1
var_0_9.CITY_FIELD.name = "city"
var_0_9.CITY_FIELD.full_name = ".sgland.WorldChallengeReq.city"
var_0_9.CITY_FIELD.number = 2
var_0_9.CITY_FIELD.index = 1
var_0_9.CITY_FIELD.label = 2
var_0_9.CITY_FIELD.has_default_value = false
var_0_9.CITY_FIELD.default_value = nil
var_0_9.CITY_FIELD.message_type = WORLDCITY
var_0_9.CITY_FIELD.type = 11
var_0_9.CITY_FIELD.cpp_type = 10
WORLDCHALLENGEREQ.name = "WorldChallengeReq"
WORLDCHALLENGEREQ.full_name = ".sgland.WorldChallengeReq"
WORLDCHALLENGEREQ.nested_types = {}
WORLDCHALLENGEREQ.enum_types = {}
WORLDCHALLENGEREQ.fields = {
	var_0_9.TROOP_ID_FIELD,
	var_0_9.CITY_FIELD
}
WORLDCHALLENGEREQ.is_extendable = false
WORLDCHALLENGEREQ.extensions = {}
var_0_10.TROOP_ID_FIELD.name = "troop_id"
var_0_10.TROOP_ID_FIELD.full_name = ".sgland.WorldChallengeCopyReq.troop_id"
var_0_10.TROOP_ID_FIELD.number = 1
var_0_10.TROOP_ID_FIELD.index = 0
var_0_10.TROOP_ID_FIELD.label = 2
var_0_10.TROOP_ID_FIELD.has_default_value = false
var_0_10.TROOP_ID_FIELD.default_value = 0
var_0_10.TROOP_ID_FIELD.type = 5
var_0_10.TROOP_ID_FIELD.cpp_type = 1
var_0_10.COPY_ID_FIELD.name = "copy_id"
var_0_10.COPY_ID_FIELD.full_name = ".sgland.WorldChallengeCopyReq.copy_id"
var_0_10.COPY_ID_FIELD.number = 2
var_0_10.COPY_ID_FIELD.index = 1
var_0_10.COPY_ID_FIELD.label = 2
var_0_10.COPY_ID_FIELD.has_default_value = false
var_0_10.COPY_ID_FIELD.default_value = 0
var_0_10.COPY_ID_FIELD.type = 5
var_0_10.COPY_ID_FIELD.cpp_type = 1
WORLDCHALLENGECOPYREQ.name = "WorldChallengeCopyReq"
WORLDCHALLENGECOPYREQ.full_name = ".sgland.WorldChallengeCopyReq"
WORLDCHALLENGECOPYREQ.nested_types = {}
WORLDCHALLENGECOPYREQ.enum_types = {}
WORLDCHALLENGECOPYREQ.fields = {
	var_0_10.TROOP_ID_FIELD,
	var_0_10.COPY_ID_FIELD
}
WORLDCHALLENGECOPYREQ.is_extendable = false
WORLDCHALLENGECOPYREQ.extensions = {}
var_0_11.CITY_ID_FIELD.name = "city_id"
var_0_11.CITY_ID_FIELD.full_name = ".sgland.WorldSOSReq.city_id"
var_0_11.CITY_ID_FIELD.number = 1
var_0_11.CITY_ID_FIELD.index = 0
var_0_11.CITY_ID_FIELD.label = 2
var_0_11.CITY_ID_FIELD.has_default_value = false
var_0_11.CITY_ID_FIELD.default_value = 0
var_0_11.CITY_ID_FIELD.type = 5
var_0_11.CITY_ID_FIELD.cpp_type = 1
var_0_11.MEMBER_ID_FIELD.name = "member_id"
var_0_11.MEMBER_ID_FIELD.full_name = ".sgland.WorldSOSReq.member_id"
var_0_11.MEMBER_ID_FIELD.number = 2
var_0_11.MEMBER_ID_FIELD.index = 1
var_0_11.MEMBER_ID_FIELD.label = 3
var_0_11.MEMBER_ID_FIELD.has_default_value = false
var_0_11.MEMBER_ID_FIELD.default_value = {}
var_0_11.MEMBER_ID_FIELD.type = 3
var_0_11.MEMBER_ID_FIELD.cpp_type = 2
var_0_11.CONTENT_FIELD.name = "content"
var_0_11.CONTENT_FIELD.full_name = ".sgland.WorldSOSReq.content"
var_0_11.CONTENT_FIELD.number = 3
var_0_11.CONTENT_FIELD.index = 2
var_0_11.CONTENT_FIELD.label = 2
var_0_11.CONTENT_FIELD.has_default_value = false
var_0_11.CONTENT_FIELD.default_value = ""
var_0_11.CONTENT_FIELD.type = 9
var_0_11.CONTENT_FIELD.cpp_type = 9
WORLDSOSREQ.name = "WorldSOSReq"
WORLDSOSREQ.full_name = ".sgland.WorldSOSReq"
WORLDSOSREQ.nested_types = {}
WORLDSOSREQ.enum_types = {}
WORLDSOSREQ.fields = {
	var_0_11.CITY_ID_FIELD,
	var_0_11.MEMBER_ID_FIELD,
	var_0_11.CONTENT_FIELD
}
WORLDSOSREQ.is_extendable = false
WORLDSOSREQ.extensions = {}
var_0_12.TROOP_ID_FIELD.name = "troop_id"
var_0_12.TROOP_ID_FIELD.full_name = ".sgland.WorldRescueReq.troop_id"
var_0_12.TROOP_ID_FIELD.number = 1
var_0_12.TROOP_ID_FIELD.index = 0
var_0_12.TROOP_ID_FIELD.label = 2
var_0_12.TROOP_ID_FIELD.has_default_value = false
var_0_12.TROOP_ID_FIELD.default_value = 0
var_0_12.TROOP_ID_FIELD.type = 5
var_0_12.TROOP_ID_FIELD.cpp_type = 1
var_0_12.MAIL_ID_FIELD.name = "mail_id"
var_0_12.MAIL_ID_FIELD.full_name = ".sgland.WorldRescueReq.mail_id"
var_0_12.MAIL_ID_FIELD.number = 2
var_0_12.MAIL_ID_FIELD.index = 1
var_0_12.MAIL_ID_FIELD.label = 2
var_0_12.MAIL_ID_FIELD.has_default_value = false
var_0_12.MAIL_ID_FIELD.default_value = 0
var_0_12.MAIL_ID_FIELD.type = 3
var_0_12.MAIL_ID_FIELD.cpp_type = 2
WORLDRESCUEREQ.name = "WorldRescueReq"
WORLDRESCUEREQ.full_name = ".sgland.WorldRescueReq"
WORLDRESCUEREQ.nested_types = {}
WORLDRESCUEREQ.enum_types = {}
WORLDRESCUEREQ.fields = {
	var_0_12.TROOP_ID_FIELD,
	var_0_12.MAIL_ID_FIELD
}
WORLDRESCUEREQ.is_extendable = false
WORLDRESCUEREQ.extensions = {}
var_0_13.USER_ID_FIELD.name = "user_id"
var_0_13.USER_ID_FIELD.full_name = ".sgland.WorldFindReq.user_id"
var_0_13.USER_ID_FIELD.number = 1
var_0_13.USER_ID_FIELD.index = 0
var_0_13.USER_ID_FIELD.label = 2
var_0_13.USER_ID_FIELD.has_default_value = false
var_0_13.USER_ID_FIELD.default_value = 0
var_0_13.USER_ID_FIELD.type = 3
var_0_13.USER_ID_FIELD.cpp_type = 2
var_0_13.TROOP_FIELD.name = "troop"
var_0_13.TROOP_FIELD.full_name = ".sgland.WorldFindReq.troop"
var_0_13.TROOP_FIELD.number = 2
var_0_13.TROOP_FIELD.index = 1
var_0_13.TROOP_FIELD.label = 2
var_0_13.TROOP_FIELD.has_default_value = false
var_0_13.TROOP_FIELD.default_value = nil
var_0_13.TROOP_FIELD.message_type = var_0_2.TROOPDATA
var_0_13.TROOP_FIELD.type = 11
var_0_13.TROOP_FIELD.cpp_type = 10
var_0_13.TYPE_FIELD.name = "type"
var_0_13.TYPE_FIELD.full_name = ".sgland.WorldFindReq.type"
var_0_13.TYPE_FIELD.number = 3
var_0_13.TYPE_FIELD.index = 2
var_0_13.TYPE_FIELD.label = 2
var_0_13.TYPE_FIELD.has_default_value = false
var_0_13.TYPE_FIELD.default_value = nil
var_0_13.TYPE_FIELD.enum_type = var_0_3.BATTLETYPE
var_0_13.TYPE_FIELD.type = 14
var_0_13.TYPE_FIELD.cpp_type = 8
var_0_13.MATCH_VALUE_FIELD.name = "match_value"
var_0_13.MATCH_VALUE_FIELD.full_name = ".sgland.WorldFindReq.match_value"
var_0_13.MATCH_VALUE_FIELD.number = 4
var_0_13.MATCH_VALUE_FIELD.index = 3
var_0_13.MATCH_VALUE_FIELD.label = 1
var_0_13.MATCH_VALUE_FIELD.has_default_value = false
var_0_13.MATCH_VALUE_FIELD.default_value = 0
var_0_13.MATCH_VALUE_FIELD.type = 5
var_0_13.MATCH_VALUE_FIELD.cpp_type = 1
var_0_13.IS_ROOKIE_FIELD.name = "is_rookie"
var_0_13.IS_ROOKIE_FIELD.full_name = ".sgland.WorldFindReq.is_rookie"
var_0_13.IS_ROOKIE_FIELD.number = 5
var_0_13.IS_ROOKIE_FIELD.index = 4
var_0_13.IS_ROOKIE_FIELD.label = 1
var_0_13.IS_ROOKIE_FIELD.has_default_value = true
var_0_13.IS_ROOKIE_FIELD.default_value = false
var_0_13.IS_ROOKIE_FIELD.type = 8
var_0_13.IS_ROOKIE_FIELD.cpp_type = 7
var_0_13.RID_FIELD.name = "rid"
var_0_13.RID_FIELD.full_name = ".sgland.WorldFindReq.rid"
var_0_13.RID_FIELD.number = 6
var_0_13.RID_FIELD.index = 5
var_0_13.RID_FIELD.label = 1
var_0_13.RID_FIELD.has_default_value = false
var_0_13.RID_FIELD.default_value = 0
var_0_13.RID_FIELD.type = 5
var_0_13.RID_FIELD.cpp_type = 1
var_0_13.TEAM_ID_FIELD.name = "team_id"
var_0_13.TEAM_ID_FIELD.full_name = ".sgland.WorldFindReq.team_id"
var_0_13.TEAM_ID_FIELD.number = 7
var_0_13.TEAM_ID_FIELD.index = 6
var_0_13.TEAM_ID_FIELD.label = 1
var_0_13.TEAM_ID_FIELD.has_default_value = false
var_0_13.TEAM_ID_FIELD.default_value = 0
var_0_13.TEAM_ID_FIELD.type = 3
var_0_13.TEAM_ID_FIELD.cpp_type = 2
var_0_13.TOTAL_LADDER_WIN_FIELD.name = "total_ladder_win"
var_0_13.TOTAL_LADDER_WIN_FIELD.full_name = ".sgland.WorldFindReq.total_ladder_win"
var_0_13.TOTAL_LADDER_WIN_FIELD.number = 8
var_0_13.TOTAL_LADDER_WIN_FIELD.index = 7
var_0_13.TOTAL_LADDER_WIN_FIELD.label = 1
var_0_13.TOTAL_LADDER_WIN_FIELD.has_default_value = false
var_0_13.TOTAL_LADDER_WIN_FIELD.default_value = 0
var_0_13.TOTAL_LADDER_WIN_FIELD.type = 5
var_0_13.TOTAL_LADDER_WIN_FIELD.cpp_type = 1
var_0_13.REG_DAY_FIELD.name = "reg_day"
var_0_13.REG_DAY_FIELD.full_name = ".sgland.WorldFindReq.reg_day"
var_0_13.REG_DAY_FIELD.number = 9
var_0_13.REG_DAY_FIELD.index = 8
var_0_13.REG_DAY_FIELD.label = 1
var_0_13.REG_DAY_FIELD.has_default_value = false
var_0_13.REG_DAY_FIELD.default_value = 0
var_0_13.REG_DAY_FIELD.type = 5
var_0_13.REG_DAY_FIELD.cpp_type = 1
var_0_13.NPC_TYPE_FIELD.name = "npc_type"
var_0_13.NPC_TYPE_FIELD.full_name = ".sgland.WorldFindReq.npc_type"
var_0_13.NPC_TYPE_FIELD.number = 10
var_0_13.NPC_TYPE_FIELD.index = 9
var_0_13.NPC_TYPE_FIELD.label = 1
var_0_13.NPC_TYPE_FIELD.has_default_value = false
var_0_13.NPC_TYPE_FIELD.default_value = 0
var_0_13.NPC_TYPE_FIELD.type = 5
var_0_13.NPC_TYPE_FIELD.cpp_type = 1
WORLDFINDREQ.name = "WorldFindReq"
WORLDFINDREQ.full_name = ".sgland.WorldFindReq"
WORLDFINDREQ.nested_types = {}
WORLDFINDREQ.enum_types = {}
WORLDFINDREQ.fields = {
	var_0_13.USER_ID_FIELD,
	var_0_13.TROOP_FIELD,
	var_0_13.TYPE_FIELD,
	var_0_13.MATCH_VALUE_FIELD,
	var_0_13.IS_ROOKIE_FIELD,
	var_0_13.RID_FIELD,
	var_0_13.TEAM_ID_FIELD,
	var_0_13.TOTAL_LADDER_WIN_FIELD,
	var_0_13.REG_DAY_FIELD,
	var_0_13.NPC_TYPE_FIELD
}
WORLDFINDREQ.is_extendable = false
WORLDFINDREQ.extensions = {}
var_0_14.TROOP_ID_FIELD.name = "troop_id"
var_0_14.TROOP_ID_FIELD.full_name = ".sgland.WorldFindExReq.troop_id"
var_0_14.TROOP_ID_FIELD.number = 1
var_0_14.TROOP_ID_FIELD.index = 0
var_0_14.TROOP_ID_FIELD.label = 2
var_0_14.TROOP_ID_FIELD.has_default_value = false
var_0_14.TROOP_ID_FIELD.default_value = 0
var_0_14.TROOP_ID_FIELD.type = 5
var_0_14.TROOP_ID_FIELD.cpp_type = 1
var_0_14.TYPE_FIELD.name = "type"
var_0_14.TYPE_FIELD.full_name = ".sgland.WorldFindExReq.type"
var_0_14.TYPE_FIELD.number = 2
var_0_14.TYPE_FIELD.index = 1
var_0_14.TYPE_FIELD.label = 2
var_0_14.TYPE_FIELD.has_default_value = false
var_0_14.TYPE_FIELD.default_value = nil
var_0_14.TYPE_FIELD.enum_type = var_0_3.BATTLETYPE
var_0_14.TYPE_FIELD.type = 14
var_0_14.TYPE_FIELD.cpp_type = 8
WORLDFINDEXREQ.name = "WorldFindExReq"
WORLDFINDEXREQ.full_name = ".sgland.WorldFindExReq"
WORLDFINDEXREQ.nested_types = {}
WORLDFINDEXREQ.enum_types = {}
WORLDFINDEXREQ.fields = {
	var_0_14.TROOP_ID_FIELD,
	var_0_14.TYPE_FIELD
}
WORLDFINDEXREQ.is_extendable = false
WORLDFINDEXREQ.extensions = {}
var_0_15.TROOP_ID_FIELD.name = "troop_id"
var_0_15.TROOP_ID_FIELD.full_name = ".sgland.WorldRobGoldReq.troop_id"
var_0_15.TROOP_ID_FIELD.number = 1
var_0_15.TROOP_ID_FIELD.index = 0
var_0_15.TROOP_ID_FIELD.label = 2
var_0_15.TROOP_ID_FIELD.has_default_value = false
var_0_15.TROOP_ID_FIELD.default_value = 0
var_0_15.TROOP_ID_FIELD.type = 5
var_0_15.TROOP_ID_FIELD.cpp_type = 1
var_0_15.COPY_ID_FIELD.name = "copy_id"
var_0_15.COPY_ID_FIELD.full_name = ".sgland.WorldRobGoldReq.copy_id"
var_0_15.COPY_ID_FIELD.number = 2
var_0_15.COPY_ID_FIELD.index = 1
var_0_15.COPY_ID_FIELD.label = 2
var_0_15.COPY_ID_FIELD.has_default_value = false
var_0_15.COPY_ID_FIELD.default_value = 0
var_0_15.COPY_ID_FIELD.type = 5
var_0_15.COPY_ID_FIELD.cpp_type = 1
var_0_15.PROP_ID_FIELD.name = "prop_id"
var_0_15.PROP_ID_FIELD.full_name = ".sgland.WorldRobGoldReq.prop_id"
var_0_15.PROP_ID_FIELD.number = 3
var_0_15.PROP_ID_FIELD.index = 2
var_0_15.PROP_ID_FIELD.label = 2
var_0_15.PROP_ID_FIELD.has_default_value = false
var_0_15.PROP_ID_FIELD.default_value = 0
var_0_15.PROP_ID_FIELD.type = 5
var_0_15.PROP_ID_FIELD.cpp_type = 1
WORLDROBGOLDREQ.name = "WorldRobGoldReq"
WORLDROBGOLDREQ.full_name = ".sgland.WorldRobGoldReq"
WORLDROBGOLDREQ.nested_types = {}
WORLDROBGOLDREQ.enum_types = {}
WORLDROBGOLDREQ.fields = {
	var_0_15.TROOP_ID_FIELD,
	var_0_15.COPY_ID_FIELD,
	var_0_15.PROP_ID_FIELD
}
WORLDROBGOLDREQ.is_extendable = false
WORLDROBGOLDREQ.extensions = {}
var_0_16.COPY_ID_FIELD.name = "copy_id"
var_0_16.COPY_ID_FIELD.full_name = ".sgland.WorldSweepCopyReq.copy_id"
var_0_16.COPY_ID_FIELD.number = 1
var_0_16.COPY_ID_FIELD.index = 0
var_0_16.COPY_ID_FIELD.label = 2
var_0_16.COPY_ID_FIELD.has_default_value = false
var_0_16.COPY_ID_FIELD.default_value = 0
var_0_16.COPY_ID_FIELD.type = 5
var_0_16.COPY_ID_FIELD.cpp_type = 1
var_0_16.PROP_ID_FIELD.name = "prop_id"
var_0_16.PROP_ID_FIELD.full_name = ".sgland.WorldSweepCopyReq.prop_id"
var_0_16.PROP_ID_FIELD.number = 2
var_0_16.PROP_ID_FIELD.index = 1
var_0_16.PROP_ID_FIELD.label = 2
var_0_16.PROP_ID_FIELD.has_default_value = false
var_0_16.PROP_ID_FIELD.default_value = 0
var_0_16.PROP_ID_FIELD.type = 5
var_0_16.PROP_ID_FIELD.cpp_type = 1
WORLDSWEEPCOPYREQ.name = "WorldSweepCopyReq"
WORLDSWEEPCOPYREQ.full_name = ".sgland.WorldSweepCopyReq"
WORLDSWEEPCOPYREQ.nested_types = {}
WORLDSWEEPCOPYREQ.enum_types = {}
WORLDSWEEPCOPYREQ.fields = {
	var_0_16.COPY_ID_FIELD,
	var_0_16.PROP_ID_FIELD
}
WORLDSWEEPCOPYREQ.is_extendable = false
WORLDSWEEPCOPYREQ.extensions = {}
var_0_17.USER_ID_FIELD.name = "user_id"
var_0_17.USER_ID_FIELD.full_name = ".sgland.WorldBattleJoinReq.user_id"
var_0_17.USER_ID_FIELD.number = 1
var_0_17.USER_ID_FIELD.index = 0
var_0_17.USER_ID_FIELD.label = 2
var_0_17.USER_ID_FIELD.has_default_value = false
var_0_17.USER_ID_FIELD.default_value = 0
var_0_17.USER_ID_FIELD.type = 3
var_0_17.USER_ID_FIELD.cpp_type = 2
var_0_17.BATTLE_ID_FIELD.name = "battle_id"
var_0_17.BATTLE_ID_FIELD.full_name = ".sgland.WorldBattleJoinReq.battle_id"
var_0_17.BATTLE_ID_FIELD.number = 2
var_0_17.BATTLE_ID_FIELD.index = 1
var_0_17.BATTLE_ID_FIELD.label = 2
var_0_17.BATTLE_ID_FIELD.has_default_value = false
var_0_17.BATTLE_ID_FIELD.default_value = 0
var_0_17.BATTLE_ID_FIELD.type = 3
var_0_17.BATTLE_ID_FIELD.cpp_type = 2
WORLDBATTLEJOINREQ.name = "WorldBattleJoinReq"
WORLDBATTLEJOINREQ.full_name = ".sgland.WorldBattleJoinReq"
WORLDBATTLEJOINREQ.nested_types = {}
WORLDBATTLEJOINREQ.enum_types = {}
WORLDBATTLEJOINREQ.fields = {
	var_0_17.USER_ID_FIELD,
	var_0_17.BATTLE_ID_FIELD
}
WORLDBATTLEJOINREQ.is_extendable = false
WORLDBATTLEJOINREQ.extensions = {}
var_0_18.TROOP_ID_FIELD.name = "troop_id"
var_0_18.TROOP_ID_FIELD.full_name = ".sgland.WorldFindStartReq.troop_id"
var_0_18.TROOP_ID_FIELD.number = 1
var_0_18.TROOP_ID_FIELD.index = 0
var_0_18.TROOP_ID_FIELD.label = 2
var_0_18.TROOP_ID_FIELD.has_default_value = false
var_0_18.TROOP_ID_FIELD.default_value = 0
var_0_18.TROOP_ID_FIELD.type = 5
var_0_18.TROOP_ID_FIELD.cpp_type = 1
var_0_18.CHOICE_FIELD.name = "choice"
var_0_18.CHOICE_FIELD.full_name = ".sgland.WorldFindStartReq.choice"
var_0_18.CHOICE_FIELD.number = 2
var_0_18.CHOICE_FIELD.index = 1
var_0_18.CHOICE_FIELD.label = 2
var_0_18.CHOICE_FIELD.has_default_value = false
var_0_18.CHOICE_FIELD.default_value = 0
var_0_18.CHOICE_FIELD.type = 5
var_0_18.CHOICE_FIELD.cpp_type = 1
WORLDFINDSTARTREQ.name = "WorldFindStartReq"
WORLDFINDSTARTREQ.full_name = ".sgland.WorldFindStartReq"
WORLDFINDSTARTREQ.nested_types = {}
WORLDFINDSTARTREQ.enum_types = {}
WORLDFINDSTARTREQ.fields = {
	var_0_18.TROOP_ID_FIELD,
	var_0_18.CHOICE_FIELD
}
WORLDFINDSTARTREQ.is_extendable = false
WORLDFINDSTARTREQ.extensions = {}
var_0_19.TROOP_ID_FIELD.name = "troop_id"
var_0_19.TROOP_ID_FIELD.full_name = ".sgland.WorldExpeditionExReq.troop_id"
var_0_19.TROOP_ID_FIELD.number = 1
var_0_19.TROOP_ID_FIELD.index = 0
var_0_19.TROOP_ID_FIELD.label = 2
var_0_19.TROOP_ID_FIELD.has_default_value = false
var_0_19.TROOP_ID_FIELD.default_value = 0
var_0_19.TROOP_ID_FIELD.type = 5
var_0_19.TROOP_ID_FIELD.cpp_type = 1
var_0_19.NPC_ID_FIELD.name = "npc_id"
var_0_19.NPC_ID_FIELD.full_name = ".sgland.WorldExpeditionExReq.npc_id"
var_0_19.NPC_ID_FIELD.number = 2
var_0_19.NPC_ID_FIELD.index = 1
var_0_19.NPC_ID_FIELD.label = 2
var_0_19.NPC_ID_FIELD.has_default_value = false
var_0_19.NPC_ID_FIELD.default_value = 0
var_0_19.NPC_ID_FIELD.type = 5
var_0_19.NPC_ID_FIELD.cpp_type = 1
WORLDEXPEDITIONEXREQ.name = "WorldExpeditionExReq"
WORLDEXPEDITIONEXREQ.full_name = ".sgland.WorldExpeditionExReq"
WORLDEXPEDITIONEXREQ.nested_types = {}
WORLDEXPEDITIONEXREQ.enum_types = {}
WORLDEXPEDITIONEXREQ.fields = {
	var_0_19.TROOP_ID_FIELD,
	var_0_19.NPC_ID_FIELD
}
WORLDEXPEDITIONEXREQ.is_extendable = false
WORLDEXPEDITIONEXREQ.extensions = {}
var_0_20.MATCH_ID_FIELD.name = "match_id"
var_0_20.MATCH_ID_FIELD.full_name = ".sgland.WorldMatchJoinReq.match_id"
var_0_20.MATCH_ID_FIELD.number = 1
var_0_20.MATCH_ID_FIELD.index = 0
var_0_20.MATCH_ID_FIELD.label = 2
var_0_20.MATCH_ID_FIELD.has_default_value = false
var_0_20.MATCH_ID_FIELD.default_value = 0
var_0_20.MATCH_ID_FIELD.type = 5
var_0_20.MATCH_ID_FIELD.cpp_type = 1
var_0_20.USER_ID_FIELD.name = "user_id"
var_0_20.USER_ID_FIELD.full_name = ".sgland.WorldMatchJoinReq.user_id"
var_0_20.USER_ID_FIELD.number = 2
var_0_20.USER_ID_FIELD.index = 1
var_0_20.USER_ID_FIELD.label = 2
var_0_20.USER_ID_FIELD.has_default_value = false
var_0_20.USER_ID_FIELD.default_value = 0
var_0_20.USER_ID_FIELD.type = 3
var_0_20.USER_ID_FIELD.cpp_type = 2
var_0_20.TROOP_FIELD.name = "troop"
var_0_20.TROOP_FIELD.full_name = ".sgland.WorldMatchJoinReq.troop"
var_0_20.TROOP_FIELD.number = 3
var_0_20.TROOP_FIELD.index = 2
var_0_20.TROOP_FIELD.label = 3
var_0_20.TROOP_FIELD.has_default_value = false
var_0_20.TROOP_FIELD.default_value = {}
var_0_20.TROOP_FIELD.message_type = var_0_2.TROOPDATA
var_0_20.TROOP_FIELD.type = 11
var_0_20.TROOP_FIELD.cpp_type = 10
var_0_20.IS_CREATE_FIELD.name = "is_create"
var_0_20.IS_CREATE_FIELD.full_name = ".sgland.WorldMatchJoinReq.is_create"
var_0_20.IS_CREATE_FIELD.number = 4
var_0_20.IS_CREATE_FIELD.index = 3
var_0_20.IS_CREATE_FIELD.label = 2
var_0_20.IS_CREATE_FIELD.has_default_value = false
var_0_20.IS_CREATE_FIELD.default_value = false
var_0_20.IS_CREATE_FIELD.type = 8
var_0_20.IS_CREATE_FIELD.cpp_type = 7
var_0_20.TYPE_FIELD.name = "type"
var_0_20.TYPE_FIELD.full_name = ".sgland.WorldMatchJoinReq.type"
var_0_20.TYPE_FIELD.number = 5
var_0_20.TYPE_FIELD.index = 4
var_0_20.TYPE_FIELD.label = 2
var_0_20.TYPE_FIELD.has_default_value = false
var_0_20.TYPE_FIELD.default_value = nil
var_0_20.TYPE_FIELD.enum_type = var_0_2.MATCHTYPE
var_0_20.TYPE_FIELD.type = 14
var_0_20.TYPE_FIELD.cpp_type = 8
WORLDMATCHJOINREQ.name = "WorldMatchJoinReq"
WORLDMATCHJOINREQ.full_name = ".sgland.WorldMatchJoinReq"
WORLDMATCHJOINREQ.nested_types = {}
WORLDMATCHJOINREQ.enum_types = {}
WORLDMATCHJOINREQ.fields = {
	var_0_20.MATCH_ID_FIELD,
	var_0_20.USER_ID_FIELD,
	var_0_20.TROOP_FIELD,
	var_0_20.IS_CREATE_FIELD,
	var_0_20.TYPE_FIELD
}
WORLDMATCHJOINREQ.is_extendable = false
WORLDMATCHJOINREQ.extensions = {}
var_0_21.USER_ID_FIELD.name = "user_id"
var_0_21.USER_ID_FIELD.full_name = ".sgland.WorldSurvivalHallJoinReq.user_id"
var_0_21.USER_ID_FIELD.number = 1
var_0_21.USER_ID_FIELD.index = 0
var_0_21.USER_ID_FIELD.label = 2
var_0_21.USER_ID_FIELD.has_default_value = false
var_0_21.USER_ID_FIELD.default_value = 0
var_0_21.USER_ID_FIELD.type = 3
var_0_21.USER_ID_FIELD.cpp_type = 2
var_0_21.HALL_ID_FIELD.name = "hall_id"
var_0_21.HALL_ID_FIELD.full_name = ".sgland.WorldSurvivalHallJoinReq.hall_id"
var_0_21.HALL_ID_FIELD.number = 2
var_0_21.HALL_ID_FIELD.index = 1
var_0_21.HALL_ID_FIELD.label = 2
var_0_21.HALL_ID_FIELD.has_default_value = false
var_0_21.HALL_ID_FIELD.default_value = 0
var_0_21.HALL_ID_FIELD.type = 3
var_0_21.HALL_ID_FIELD.cpp_type = 2
var_0_21.TROOP_FIELD.name = "troop"
var_0_21.TROOP_FIELD.full_name = ".sgland.WorldSurvivalHallJoinReq.troop"
var_0_21.TROOP_FIELD.number = 3
var_0_21.TROOP_FIELD.index = 2
var_0_21.TROOP_FIELD.label = 2
var_0_21.TROOP_FIELD.has_default_value = false
var_0_21.TROOP_FIELD.default_value = nil
var_0_21.TROOP_FIELD.message_type = var_0_2.TROOPDATA
var_0_21.TROOP_FIELD.type = 11
var_0_21.TROOP_FIELD.cpp_type = 10
WORLDSURVIVALHALLJOINREQ.name = "WorldSurvivalHallJoinReq"
WORLDSURVIVALHALLJOINREQ.full_name = ".sgland.WorldSurvivalHallJoinReq"
WORLDSURVIVALHALLJOINREQ.nested_types = {}
WORLDSURVIVALHALLJOINREQ.enum_types = {}
WORLDSURVIVALHALLJOINREQ.fields = {
	var_0_21.USER_ID_FIELD,
	var_0_21.HALL_ID_FIELD,
	var_0_21.TROOP_FIELD
}
WORLDSURVIVALHALLJOINREQ.is_extendable = false
WORLDSURVIVALHALLJOINREQ.extensions = {}
var_0_22.USER_ID_FIELD.name = "user_id"
var_0_22.USER_ID_FIELD.full_name = ".sgland.WorldSurvivalExHallJoinReq.user_id"
var_0_22.USER_ID_FIELD.number = 1
var_0_22.USER_ID_FIELD.index = 0
var_0_22.USER_ID_FIELD.label = 2
var_0_22.USER_ID_FIELD.has_default_value = false
var_0_22.USER_ID_FIELD.default_value = 0
var_0_22.USER_ID_FIELD.type = 3
var_0_22.USER_ID_FIELD.cpp_type = 2
var_0_22.HALL_ID_FIELD.name = "hall_id"
var_0_22.HALL_ID_FIELD.full_name = ".sgland.WorldSurvivalExHallJoinReq.hall_id"
var_0_22.HALL_ID_FIELD.number = 2
var_0_22.HALL_ID_FIELD.index = 1
var_0_22.HALL_ID_FIELD.label = 2
var_0_22.HALL_ID_FIELD.has_default_value = false
var_0_22.HALL_ID_FIELD.default_value = 0
var_0_22.HALL_ID_FIELD.type = 3
var_0_22.HALL_ID_FIELD.cpp_type = 2
var_0_22.TROOP_FIELD.name = "troop"
var_0_22.TROOP_FIELD.full_name = ".sgland.WorldSurvivalExHallJoinReq.troop"
var_0_22.TROOP_FIELD.number = 3
var_0_22.TROOP_FIELD.index = 2
var_0_22.TROOP_FIELD.label = 2
var_0_22.TROOP_FIELD.has_default_value = false
var_0_22.TROOP_FIELD.default_value = nil
var_0_22.TROOP_FIELD.message_type = var_0_2.TROOPDATA
var_0_22.TROOP_FIELD.type = 11
var_0_22.TROOP_FIELD.cpp_type = 10
WORLDSURVIVALEXHALLJOINREQ.name = "WorldSurvivalExHallJoinReq"
WORLDSURVIVALEXHALLJOINREQ.full_name = ".sgland.WorldSurvivalExHallJoinReq"
WORLDSURVIVALEXHALLJOINREQ.nested_types = {}
WORLDSURVIVALEXHALLJOINREQ.enum_types = {}
WORLDSURVIVALEXHALLJOINREQ.fields = {
	var_0_22.USER_ID_FIELD,
	var_0_22.HALL_ID_FIELD,
	var_0_22.TROOP_FIELD
}
WORLDSURVIVALEXHALLJOINREQ.is_extendable = false
WORLDSURVIVALEXHALLJOINREQ.extensions = {}
var_0_23.OPPONENTS_FIELD.name = "opponents"
var_0_23.OPPONENTS_FIELD.full_name = ".sgland.WorldFindResp.opponents"
var_0_23.OPPONENTS_FIELD.number = 1
var_0_23.OPPONENTS_FIELD.index = 0
var_0_23.OPPONENTS_FIELD.label = 3
var_0_23.OPPONENTS_FIELD.has_default_value = false
var_0_23.OPPONENTS_FIELD.default_value = {}
var_0_23.OPPONENTS_FIELD.message_type = var_0_2.TROOPDATA
var_0_23.OPPONENTS_FIELD.type = 11
var_0_23.OPPONENTS_FIELD.cpp_type = 10
var_0_23.OPPONENT_RANKS_FIELD.name = "opponent_ranks"
var_0_23.OPPONENT_RANKS_FIELD.full_name = ".sgland.WorldFindResp.opponent_ranks"
var_0_23.OPPONENT_RANKS_FIELD.number = 2
var_0_23.OPPONENT_RANKS_FIELD.index = 1
var_0_23.OPPONENT_RANKS_FIELD.label = 3
var_0_23.OPPONENT_RANKS_FIELD.has_default_value = false
var_0_23.OPPONENT_RANKS_FIELD.default_value = {}
var_0_23.OPPONENT_RANKS_FIELD.type = 5
var_0_23.OPPONENT_RANKS_FIELD.cpp_type = 1
var_0_23.RANK_FIELD.name = "rank"
var_0_23.RANK_FIELD.full_name = ".sgland.WorldFindResp.rank"
var_0_23.RANK_FIELD.number = 3
var_0_23.RANK_FIELD.index = 2
var_0_23.RANK_FIELD.label = 2
var_0_23.RANK_FIELD.has_default_value = false
var_0_23.RANK_FIELD.default_value = 0
var_0_23.RANK_FIELD.type = 5
var_0_23.RANK_FIELD.cpp_type = 1
WORLDFINDRESP.name = "WorldFindResp"
WORLDFINDRESP.full_name = ".sgland.WorldFindResp"
WORLDFINDRESP.nested_types = {}
WORLDFINDRESP.enum_types = {}
WORLDFINDRESP.fields = {
	var_0_23.OPPONENTS_FIELD,
	var_0_23.OPPONENT_RANKS_FIELD,
	var_0_23.RANK_FIELD
}
WORLDFINDRESP.is_extendable = false
WORLDFINDRESP.extensions = {}
var_0_24.TIMESTAMP_FIELD.name = "timestamp"
var_0_24.TIMESTAMP_FIELD.full_name = ".sgland.WorldSweepResp.timestamp"
var_0_24.TIMESTAMP_FIELD.number = 1
var_0_24.TIMESTAMP_FIELD.index = 0
var_0_24.TIMESTAMP_FIELD.label = 2
var_0_24.TIMESTAMP_FIELD.has_default_value = false
var_0_24.TIMESTAMP_FIELD.default_value = 0
var_0_24.TIMESTAMP_FIELD.type = 3
var_0_24.TIMESTAMP_FIELD.cpp_type = 2
var_0_24.RESULT_FIELD.name = "result"
var_0_24.RESULT_FIELD.full_name = ".sgland.WorldSweepResp.result"
var_0_24.RESULT_FIELD.number = 2
var_0_24.RESULT_FIELD.index = 1
var_0_24.RESULT_FIELD.label = 3
var_0_24.RESULT_FIELD.has_default_value = false
var_0_24.RESULT_FIELD.default_value = {}
var_0_24.RESULT_FIELD.message_type = WORLDSWEEPRESULT
var_0_24.RESULT_FIELD.type = 11
var_0_24.RESULT_FIELD.cpp_type = 10
WORLDSWEEPRESP.name = "WorldSweepResp"
WORLDSWEEPRESP.full_name = ".sgland.WorldSweepResp"
WORLDSWEEPRESP.nested_types = {}
WORLDSWEEPRESP.enum_types = {}
WORLDSWEEPRESP.fields = {
	var_0_24.TIMESTAMP_FIELD,
	var_0_24.RESULT_FIELD
}
WORLDSWEEPRESP.is_extendable = false
WORLDSWEEPRESP.extensions = {}
var_0_25.USER_INFO_FIELD.name = "user_info"
var_0_25.USER_INFO_FIELD.full_name = ".sgland.WorldBattleStartResp.user_info"
var_0_25.USER_INFO_FIELD.number = 1
var_0_25.USER_INFO_FIELD.index = 0
var_0_25.USER_INFO_FIELD.label = 2
var_0_25.USER_INFO_FIELD.has_default_value = false
var_0_25.USER_INFO_FIELD.default_value = nil
var_0_25.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_25.USER_INFO_FIELD.type = 11
var_0_25.USER_INFO_FIELD.cpp_type = 10
var_0_25.TROOP_FIELD.name = "troop"
var_0_25.TROOP_FIELD.full_name = ".sgland.WorldBattleStartResp.troop"
var_0_25.TROOP_FIELD.number = 2
var_0_25.TROOP_FIELD.index = 1
var_0_25.TROOP_FIELD.label = 3
var_0_25.TROOP_FIELD.has_default_value = false
var_0_25.TROOP_FIELD.default_value = {}
var_0_25.TROOP_FIELD.message_type = var_0_2.RESOURCE
var_0_25.TROOP_FIELD.type = 11
var_0_25.TROOP_FIELD.cpp_type = 10
var_0_25.TIMESTAMP_FIELD.name = "timestamp"
var_0_25.TIMESTAMP_FIELD.full_name = ".sgland.WorldBattleStartResp.timestamp"
var_0_25.TIMESTAMP_FIELD.number = 3
var_0_25.TIMESTAMP_FIELD.index = 2
var_0_25.TIMESTAMP_FIELD.label = 2
var_0_25.TIMESTAMP_FIELD.has_default_value = false
var_0_25.TIMESTAMP_FIELD.default_value = 0
var_0_25.TIMESTAMP_FIELD.type = 3
var_0_25.TIMESTAMP_FIELD.cpp_type = 2
var_0_25.IS_REVENGE_FIELD.name = "is_revenge"
var_0_25.IS_REVENGE_FIELD.full_name = ".sgland.WorldBattleStartResp.is_revenge"
var_0_25.IS_REVENGE_FIELD.number = 4
var_0_25.IS_REVENGE_FIELD.index = 3
var_0_25.IS_REVENGE_FIELD.label = 1
var_0_25.IS_REVENGE_FIELD.has_default_value = false
var_0_25.IS_REVENGE_FIELD.default_value = false
var_0_25.IS_REVENGE_FIELD.type = 8
var_0_25.IS_REVENGE_FIELD.cpp_type = 7
var_0_25.IS_RESCUE_FIELD.name = "is_rescue"
var_0_25.IS_RESCUE_FIELD.full_name = ".sgland.WorldBattleStartResp.is_rescue"
var_0_25.IS_RESCUE_FIELD.number = 5
var_0_25.IS_RESCUE_FIELD.index = 4
var_0_25.IS_RESCUE_FIELD.label = 1
var_0_25.IS_RESCUE_FIELD.has_default_value = false
var_0_25.IS_RESCUE_FIELD.default_value = false
var_0_25.IS_RESCUE_FIELD.type = 8
var_0_25.IS_RESCUE_FIELD.cpp_type = 7
WORLDBATTLESTARTRESP.name = "WorldBattleStartResp"
WORLDBATTLESTARTRESP.full_name = ".sgland.WorldBattleStartResp"
WORLDBATTLESTARTRESP.nested_types = {}
WORLDBATTLESTARTRESP.enum_types = {}
WORLDBATTLESTARTRESP.fields = {
	var_0_25.USER_INFO_FIELD,
	var_0_25.TROOP_FIELD,
	var_0_25.TIMESTAMP_FIELD,
	var_0_25.IS_REVENGE_FIELD,
	var_0_25.IS_RESCUE_FIELD
}
WORLDBATTLESTARTRESP.is_extendable = false
WORLDBATTLESTARTRESP.extensions = {}
var_0_26.DATA_FIELD.name = "data"
var_0_26.DATA_FIELD.full_name = ".sgland.WorldGetExpeditionResp.data"
var_0_26.DATA_FIELD.number = 1
var_0_26.DATA_FIELD.index = 0
var_0_26.DATA_FIELD.label = 2
var_0_26.DATA_FIELD.has_default_value = false
var_0_26.DATA_FIELD.default_value = nil
var_0_26.DATA_FIELD.message_type = var_0_2.PLAYEREXPEDITION
var_0_26.DATA_FIELD.type = 11
var_0_26.DATA_FIELD.cpp_type = 10
var_0_26.COUNT_FIELD.name = "count"
var_0_26.COUNT_FIELD.full_name = ".sgland.WorldGetExpeditionResp.count"
var_0_26.COUNT_FIELD.number = 2
var_0_26.COUNT_FIELD.index = 1
var_0_26.COUNT_FIELD.label = 2
var_0_26.COUNT_FIELD.has_default_value = false
var_0_26.COUNT_FIELD.default_value = 0
var_0_26.COUNT_FIELD.type = 5
var_0_26.COUNT_FIELD.cpp_type = 1
WORLDGETEXPEDITIONRESP.name = "WorldGetExpeditionResp"
WORLDGETEXPEDITIONRESP.full_name = ".sgland.WorldGetExpeditionResp"
WORLDGETEXPEDITIONRESP.nested_types = {}
WORLDGETEXPEDITIONRESP.enum_types = {}
WORLDGETEXPEDITIONRESP.fields = {
	var_0_26.DATA_FIELD,
	var_0_26.COUNT_FIELD
}
WORLDGETEXPEDITIONRESP.is_extendable = false
WORLDGETEXPEDITIONRESP.extensions = {}
var_0_27.INFO_FIELD.name = "info"
var_0_27.INFO_FIELD.full_name = ".sgland.WorldFocusResp.info"
var_0_27.INFO_FIELD.number = 1
var_0_27.INFO_FIELD.index = 0
var_0_27.INFO_FIELD.label = 2
var_0_27.INFO_FIELD.has_default_value = false
var_0_27.INFO_FIELD.default_value = nil
var_0_27.INFO_FIELD.message_type = var_0_2.USERINFO
var_0_27.INFO_FIELD.type = 11
var_0_27.INFO_FIELD.cpp_type = 10
var_0_27.STATUS_FIELD.name = "status"
var_0_27.STATUS_FIELD.full_name = ".sgland.WorldFocusResp.status"
var_0_27.STATUS_FIELD.number = 2
var_0_27.STATUS_FIELD.index = 1
var_0_27.STATUS_FIELD.label = 2
var_0_27.STATUS_FIELD.has_default_value = false
var_0_27.STATUS_FIELD.default_value = nil
var_0_27.STATUS_FIELD.enum_type = var_0_1.FOCUSSTATUS
var_0_27.STATUS_FIELD.type = 14
var_0_27.STATUS_FIELD.cpp_type = 8
WORLDFOCUSRESP.name = "WorldFocusResp"
WORLDFOCUSRESP.full_name = ".sgland.WorldFocusResp"
WORLDFOCUSRESP.nested_types = {}
WORLDFOCUSRESP.enum_types = {}
WORLDFOCUSRESP.fields = {
	var_0_27.INFO_FIELD,
	var_0_27.STATUS_FIELD
}
WORLDFOCUSRESP.is_extendable = false
WORLDFOCUSRESP.extensions = {}
var_0_28.CITY_ID_FIELD.name = "city_id"
var_0_28.CITY_ID_FIELD.full_name = ".sgland.WorldGetOpponentResp.city_id"
var_0_28.CITY_ID_FIELD.number = 1
var_0_28.CITY_ID_FIELD.index = 0
var_0_28.CITY_ID_FIELD.label = 2
var_0_28.CITY_ID_FIELD.has_default_value = false
var_0_28.CITY_ID_FIELD.default_value = 0
var_0_28.CITY_ID_FIELD.type = 5
var_0_28.CITY_ID_FIELD.cpp_type = 1
var_0_28.OPPONENT_ID_FIELD.name = "opponent_id"
var_0_28.OPPONENT_ID_FIELD.full_name = ".sgland.WorldGetOpponentResp.opponent_id"
var_0_28.OPPONENT_ID_FIELD.number = 2
var_0_28.OPPONENT_ID_FIELD.index = 1
var_0_28.OPPONENT_ID_FIELD.label = 2
var_0_28.OPPONENT_ID_FIELD.has_default_value = false
var_0_28.OPPONENT_ID_FIELD.default_value = 0
var_0_28.OPPONENT_ID_FIELD.type = 3
var_0_28.OPPONENT_ID_FIELD.cpp_type = 2
var_0_28.TIMESTAMP_FIELD.name = "timestamp"
var_0_28.TIMESTAMP_FIELD.full_name = ".sgland.WorldGetOpponentResp.timestamp"
var_0_28.TIMESTAMP_FIELD.number = 3
var_0_28.TIMESTAMP_FIELD.index = 2
var_0_28.TIMESTAMP_FIELD.label = 2
var_0_28.TIMESTAMP_FIELD.has_default_value = false
var_0_28.TIMESTAMP_FIELD.default_value = 0
var_0_28.TIMESTAMP_FIELD.type = 3
var_0_28.TIMESTAMP_FIELD.cpp_type = 2
WORLDGETOPPONENTRESP.name = "WorldGetOpponentResp"
WORLDGETOPPONENTRESP.full_name = ".sgland.WorldGetOpponentResp"
WORLDGETOPPONENTRESP.nested_types = {}
WORLDGETOPPONENTRESP.enum_types = {}
WORLDGETOPPONENTRESP.fields = {
	var_0_28.CITY_ID_FIELD,
	var_0_28.OPPONENT_ID_FIELD,
	var_0_28.TIMESTAMP_FIELD
}
WORLDGETOPPONENTRESP.is_extendable = false
WORLDGETOPPONENTRESP.extensions = {}
var_0_29.PVP_ID_FIELD.name = "pvp_id"
var_0_29.PVP_ID_FIELD.full_name = ".sgland.WorldFindExResp.pvp_id"
var_0_29.PVP_ID_FIELD.number = 1
var_0_29.PVP_ID_FIELD.index = 0
var_0_29.PVP_ID_FIELD.label = 2
var_0_29.PVP_ID_FIELD.has_default_value = false
var_0_29.PVP_ID_FIELD.default_value = 0
var_0_29.PVP_ID_FIELD.type = 5
var_0_29.PVP_ID_FIELD.cpp_type = 1
var_0_29.BATTLE_ID_FIELD.name = "battle_id"
var_0_29.BATTLE_ID_FIELD.full_name = ".sgland.WorldFindExResp.battle_id"
var_0_29.BATTLE_ID_FIELD.number = 2
var_0_29.BATTLE_ID_FIELD.index = 1
var_0_29.BATTLE_ID_FIELD.label = 2
var_0_29.BATTLE_ID_FIELD.has_default_value = false
var_0_29.BATTLE_ID_FIELD.default_value = 0
var_0_29.BATTLE_ID_FIELD.type = 3
var_0_29.BATTLE_ID_FIELD.cpp_type = 2
WORLDFINDEXRESP.name = "WorldFindExResp"
WORLDFINDEXRESP.full_name = ".sgland.WorldFindExResp"
WORLDFINDEXRESP.nested_types = {}
WORLDFINDEXRESP.enum_types = {}
WORLDFINDEXRESP.fields = {
	var_0_29.PVP_ID_FIELD,
	var_0_29.BATTLE_ID_FIELD
}
WORLDFINDEXRESP.is_extendable = false
WORLDFINDEXRESP.extensions = {}
var_0_30.PERIOD_FIELD.name = "period"
var_0_30.PERIOD_FIELD.full_name = ".sgland.LotteryUnopenList.period"
var_0_30.PERIOD_FIELD.number = 1
var_0_30.PERIOD_FIELD.index = 0
var_0_30.PERIOD_FIELD.label = 2
var_0_30.PERIOD_FIELD.has_default_value = false
var_0_30.PERIOD_FIELD.default_value = 0
var_0_30.PERIOD_FIELD.type = 5
var_0_30.PERIOD_FIELD.cpp_type = 1
var_0_30.LOTTERY_COUNT_FIELD.name = "lottery_count"
var_0_30.LOTTERY_COUNT_FIELD.full_name = ".sgland.LotteryUnopenList.lottery_count"
var_0_30.LOTTERY_COUNT_FIELD.number = 2
var_0_30.LOTTERY_COUNT_FIELD.index = 1
var_0_30.LOTTERY_COUNT_FIELD.label = 2
var_0_30.LOTTERY_COUNT_FIELD.has_default_value = false
var_0_30.LOTTERY_COUNT_FIELD.default_value = 0
var_0_30.LOTTERY_COUNT_FIELD.type = 5
var_0_30.LOTTERY_COUNT_FIELD.cpp_type = 1
var_0_30.LOTTERY_PROGRESS_FIELD.name = "lottery_progress"
var_0_30.LOTTERY_PROGRESS_FIELD.full_name = ".sgland.LotteryUnopenList.lottery_progress"
var_0_30.LOTTERY_PROGRESS_FIELD.number = 3
var_0_30.LOTTERY_PROGRESS_FIELD.index = 2
var_0_30.LOTTERY_PROGRESS_FIELD.label = 2
var_0_30.LOTTERY_PROGRESS_FIELD.has_default_value = false
var_0_30.LOTTERY_PROGRESS_FIELD.default_value = 0
var_0_30.LOTTERY_PROGRESS_FIELD.type = 5
var_0_30.LOTTERY_PROGRESS_FIELD.cpp_type = 1
LOTTERYUNOPENLIST.name = "LotteryUnopenList"
LOTTERYUNOPENLIST.full_name = ".sgland.LotteryUnopenList"
LOTTERYUNOPENLIST.nested_types = {}
LOTTERYUNOPENLIST.enum_types = {}
LOTTERYUNOPENLIST.fields = {
	var_0_30.PERIOD_FIELD,
	var_0_30.LOTTERY_COUNT_FIELD,
	var_0_30.LOTTERY_PROGRESS_FIELD
}
LOTTERYUNOPENLIST.is_extendable = false
LOTTERYUNOPENLIST.extensions = {}
var_0_31.PERIOD_FIELD.name = "period"
var_0_31.PERIOD_FIELD.full_name = ".sgland.LotteryOpenList.period"
var_0_31.PERIOD_FIELD.number = 1
var_0_31.PERIOD_FIELD.index = 0
var_0_31.PERIOD_FIELD.label = 2
var_0_31.PERIOD_FIELD.has_default_value = false
var_0_31.PERIOD_FIELD.default_value = 0
var_0_31.PERIOD_FIELD.type = 5
var_0_31.PERIOD_FIELD.cpp_type = 1
var_0_31.USER_INFO_FIELD.name = "user_info"
var_0_31.USER_INFO_FIELD.full_name = ".sgland.LotteryOpenList.user_info"
var_0_31.USER_INFO_FIELD.number = 2
var_0_31.USER_INFO_FIELD.index = 1
var_0_31.USER_INFO_FIELD.label = 2
var_0_31.USER_INFO_FIELD.has_default_value = false
var_0_31.USER_INFO_FIELD.default_value = nil
var_0_31.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_31.USER_INFO_FIELD.type = 11
var_0_31.USER_INFO_FIELD.cpp_type = 10
LOTTERYOPENLIST.name = "LotteryOpenList"
LOTTERYOPENLIST.full_name = ".sgland.LotteryOpenList"
LOTTERYOPENLIST.nested_types = {}
LOTTERYOPENLIST.enum_types = {}
LOTTERYOPENLIST.fields = {
	var_0_31.PERIOD_FIELD,
	var_0_31.USER_INFO_FIELD
}
LOTTERYOPENLIST.is_extendable = false
LOTTERYOPENLIST.extensions = {}
var_0_32.VIP_FIELD.name = "vip"
var_0_32.VIP_FIELD.full_name = ".sgland.RecommendCardReq.vip"
var_0_32.VIP_FIELD.number = 1
var_0_32.VIP_FIELD.index = 0
var_0_32.VIP_FIELD.label = 2
var_0_32.VIP_FIELD.has_default_value = false
var_0_32.VIP_FIELD.default_value = 0
var_0_32.VIP_FIELD.type = 5
var_0_32.VIP_FIELD.cpp_type = 1
var_0_32.TROPHY_FIELD.name = "trophy"
var_0_32.TROPHY_FIELD.full_name = ".sgland.RecommendCardReq.trophy"
var_0_32.TROPHY_FIELD.number = 2
var_0_32.TROPHY_FIELD.index = 1
var_0_32.TROPHY_FIELD.label = 2
var_0_32.TROPHY_FIELD.has_default_value = false
var_0_32.TROPHY_FIELD.default_value = 0
var_0_32.TROPHY_FIELD.type = 5
var_0_32.TROPHY_FIELD.cpp_type = 1
RECOMMENDCARDREQ.name = "RecommendCardReq"
RECOMMENDCARDREQ.full_name = ".sgland.RecommendCardReq"
RECOMMENDCARDREQ.nested_types = {}
RECOMMENDCARDREQ.enum_types = {}
RECOMMENDCARDREQ.fields = {
	var_0_32.VIP_FIELD,
	var_0_32.TROPHY_FIELD
}
RECOMMENDCARDREQ.is_extendable = false
RECOMMENDCARDREQ.extensions = {}
var_0_33.TOTAL_WIN_FIELD.name = "total_win"
var_0_33.TOTAL_WIN_FIELD.full_name = ".sgland.DarkDuelDashBoard.total_win"
var_0_33.TOTAL_WIN_FIELD.number = 1
var_0_33.TOTAL_WIN_FIELD.index = 0
var_0_33.TOTAL_WIN_FIELD.label = 2
var_0_33.TOTAL_WIN_FIELD.has_default_value = false
var_0_33.TOTAL_WIN_FIELD.default_value = 0
var_0_33.TOTAL_WIN_FIELD.type = 5
var_0_33.TOTAL_WIN_FIELD.cpp_type = 1
var_0_33.TOTAL_LOSE_FIELD.name = "total_lose"
var_0_33.TOTAL_LOSE_FIELD.full_name = ".sgland.DarkDuelDashBoard.total_lose"
var_0_33.TOTAL_LOSE_FIELD.number = 2
var_0_33.TOTAL_LOSE_FIELD.index = 1
var_0_33.TOTAL_LOSE_FIELD.label = 2
var_0_33.TOTAL_LOSE_FIELD.has_default_value = false
var_0_33.TOTAL_LOSE_FIELD.default_value = 0
var_0_33.TOTAL_LOSE_FIELD.type = 5
var_0_33.TOTAL_LOSE_FIELD.cpp_type = 1
var_0_33.TWO_ZERO_WIN_FIELD.name = "two_zero_win"
var_0_33.TWO_ZERO_WIN_FIELD.full_name = ".sgland.DarkDuelDashBoard.two_zero_win"
var_0_33.TWO_ZERO_WIN_FIELD.number = 3
var_0_33.TWO_ZERO_WIN_FIELD.index = 2
var_0_33.TWO_ZERO_WIN_FIELD.label = 2
var_0_33.TWO_ZERO_WIN_FIELD.has_default_value = false
var_0_33.TWO_ZERO_WIN_FIELD.default_value = 0
var_0_33.TWO_ZERO_WIN_FIELD.type = 5
var_0_33.TWO_ZERO_WIN_FIELD.cpp_type = 1
var_0_33.ZERO_TWO_LOSE_FIELD.name = "zero_two_lose"
var_0_33.ZERO_TWO_LOSE_FIELD.full_name = ".sgland.DarkDuelDashBoard.zero_two_lose"
var_0_33.ZERO_TWO_LOSE_FIELD.number = 4
var_0_33.ZERO_TWO_LOSE_FIELD.index = 3
var_0_33.ZERO_TWO_LOSE_FIELD.label = 2
var_0_33.ZERO_TWO_LOSE_FIELD.has_default_value = false
var_0_33.ZERO_TWO_LOSE_FIELD.default_value = 0
var_0_33.ZERO_TWO_LOSE_FIELD.type = 5
var_0_33.ZERO_TWO_LOSE_FIELD.cpp_type = 1
var_0_33.TWO_ONE_WIN_FIELD.name = "two_one_win"
var_0_33.TWO_ONE_WIN_FIELD.full_name = ".sgland.DarkDuelDashBoard.two_one_win"
var_0_33.TWO_ONE_WIN_FIELD.number = 5
var_0_33.TWO_ONE_WIN_FIELD.index = 4
var_0_33.TWO_ONE_WIN_FIELD.label = 2
var_0_33.TWO_ONE_WIN_FIELD.has_default_value = false
var_0_33.TWO_ONE_WIN_FIELD.default_value = 0
var_0_33.TWO_ONE_WIN_FIELD.type = 5
var_0_33.TWO_ONE_WIN_FIELD.cpp_type = 1
var_0_33.ONE_TWO_LOSE_FIELD.name = "one_two_lose"
var_0_33.ONE_TWO_LOSE_FIELD.full_name = ".sgland.DarkDuelDashBoard.one_two_lose"
var_0_33.ONE_TWO_LOSE_FIELD.number = 6
var_0_33.ONE_TWO_LOSE_FIELD.index = 5
var_0_33.ONE_TWO_LOSE_FIELD.label = 2
var_0_33.ONE_TWO_LOSE_FIELD.has_default_value = false
var_0_33.ONE_TWO_LOSE_FIELD.default_value = 0
var_0_33.ONE_TWO_LOSE_FIELD.type = 5
var_0_33.ONE_TWO_LOSE_FIELD.cpp_type = 1
var_0_33.ONE_ZERO_WIN_FIELD.name = "one_zero_win"
var_0_33.ONE_ZERO_WIN_FIELD.full_name = ".sgland.DarkDuelDashBoard.one_zero_win"
var_0_33.ONE_ZERO_WIN_FIELD.number = 7
var_0_33.ONE_ZERO_WIN_FIELD.index = 6
var_0_33.ONE_ZERO_WIN_FIELD.label = 2
var_0_33.ONE_ZERO_WIN_FIELD.has_default_value = false
var_0_33.ONE_ZERO_WIN_FIELD.default_value = 0
var_0_33.ONE_ZERO_WIN_FIELD.type = 5
var_0_33.ONE_ZERO_WIN_FIELD.cpp_type = 1
var_0_33.ZERO_ONE_LOSE_FIELD.name = "zero_one_lose"
var_0_33.ZERO_ONE_LOSE_FIELD.full_name = ".sgland.DarkDuelDashBoard.zero_one_lose"
var_0_33.ZERO_ONE_LOSE_FIELD.number = 8
var_0_33.ZERO_ONE_LOSE_FIELD.index = 7
var_0_33.ZERO_ONE_LOSE_FIELD.label = 2
var_0_33.ZERO_ONE_LOSE_FIELD.has_default_value = false
var_0_33.ZERO_ONE_LOSE_FIELD.default_value = 0
var_0_33.ZERO_ONE_LOSE_FIELD.type = 5
var_0_33.ZERO_ONE_LOSE_FIELD.cpp_type = 1
DARKDUELDASHBOARD.name = "DarkDuelDashBoard"
DARKDUELDASHBOARD.full_name = ".sgland.DarkDuelDashBoard"
DARKDUELDASHBOARD.nested_types = {}
DARKDUELDASHBOARD.enum_types = {}
DARKDUELDASHBOARD.fields = {
	var_0_33.TOTAL_WIN_FIELD,
	var_0_33.TOTAL_LOSE_FIELD,
	var_0_33.TWO_ZERO_WIN_FIELD,
	var_0_33.ZERO_TWO_LOSE_FIELD,
	var_0_33.TWO_ONE_WIN_FIELD,
	var_0_33.ONE_TWO_LOSE_FIELD,
	var_0_33.ONE_ZERO_WIN_FIELD,
	var_0_33.ZERO_ONE_LOSE_FIELD
}
DARKDUELDASHBOARD.is_extendable = false
DARKDUELDASHBOARD.extensions = {}
var_0_34.MVP_TYPE_FIELD.name = "mvp_type"
var_0_34.MVP_TYPE_FIELD.full_name = ".sgland.WorshipMVP.mvp_type"
var_0_34.MVP_TYPE_FIELD.number = 1
var_0_34.MVP_TYPE_FIELD.index = 0
var_0_34.MVP_TYPE_FIELD.label = 2
var_0_34.MVP_TYPE_FIELD.has_default_value = false
var_0_34.MVP_TYPE_FIELD.default_value = 0
var_0_34.MVP_TYPE_FIELD.type = 5
var_0_34.MVP_TYPE_FIELD.cpp_type = 1
var_0_34.USER_INFO_FIELD.name = "user_info"
var_0_34.USER_INFO_FIELD.full_name = ".sgland.WorshipMVP.user_info"
var_0_34.USER_INFO_FIELD.number = 2
var_0_34.USER_INFO_FIELD.index = 1
var_0_34.USER_INFO_FIELD.label = 2
var_0_34.USER_INFO_FIELD.has_default_value = false
var_0_34.USER_INFO_FIELD.default_value = nil
var_0_34.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_34.USER_INFO_FIELD.type = 11
var_0_34.USER_INFO_FIELD.cpp_type = 10
var_0_34.COUNT_FIELD.name = "count"
var_0_34.COUNT_FIELD.full_name = ".sgland.WorshipMVP.count"
var_0_34.COUNT_FIELD.number = 3
var_0_34.COUNT_FIELD.index = 2
var_0_34.COUNT_FIELD.label = 2
var_0_34.COUNT_FIELD.has_default_value = false
var_0_34.COUNT_FIELD.default_value = 0
var_0_34.COUNT_FIELD.type = 5
var_0_34.COUNT_FIELD.cpp_type = 1
WORSHIPMVP.name = "WorshipMVP"
WORSHIPMVP.full_name = ".sgland.WorshipMVP"
WORSHIPMVP.nested_types = {}
WORSHIPMVP.enum_types = {}
WORSHIPMVP.fields = {
	var_0_34.MVP_TYPE_FIELD,
	var_0_34.USER_INFO_FIELD,
	var_0_34.COUNT_FIELD
}
WORSHIPMVP.is_extendable = false
WORSHIPMVP.extensions = {}
var_0_35.CARDS_FIELD.name = "cards"
var_0_35.CARDS_FIELD.full_name = ".sgland.SurvivalExploreStartReq.cards"
var_0_35.CARDS_FIELD.number = 1
var_0_35.CARDS_FIELD.index = 0
var_0_35.CARDS_FIELD.label = 3
var_0_35.CARDS_FIELD.has_default_value = false
var_0_35.CARDS_FIELD.default_value = {}
var_0_35.CARDS_FIELD.message_type = var_0_2.RESOURCE
var_0_35.CARDS_FIELD.type = 11
var_0_35.CARDS_FIELD.cpp_type = 10
SURVIVALEXPLORESTARTREQ.name = "SurvivalExploreStartReq"
SURVIVALEXPLORESTARTREQ.full_name = ".sgland.SurvivalExploreStartReq"
SURVIVALEXPLORESTARTREQ.nested_types = {}
SURVIVALEXPLORESTARTREQ.enum_types = {}
SURVIVALEXPLORESTARTREQ.fields = {
	var_0_35.CARDS_FIELD
}
SURVIVALEXPLORESTARTREQ.is_extendable = false
SURVIVALEXPLORESTARTREQ.extensions = {}
var_0_36.GAMEOVER_TIMESTAMP_FIELD.name = "gameover_timestamp"
var_0_36.GAMEOVER_TIMESTAMP_FIELD.full_name = ".sgland.SurvivalExploreEndResp.gameover_timestamp"
var_0_36.GAMEOVER_TIMESTAMP_FIELD.number = 1
var_0_36.GAMEOVER_TIMESTAMP_FIELD.index = 0
var_0_36.GAMEOVER_TIMESTAMP_FIELD.label = 2
var_0_36.GAMEOVER_TIMESTAMP_FIELD.has_default_value = false
var_0_36.GAMEOVER_TIMESTAMP_FIELD.default_value = 0
var_0_36.GAMEOVER_TIMESTAMP_FIELD.type = 3
var_0_36.GAMEOVER_TIMESTAMP_FIELD.cpp_type = 2
var_0_36.CAPTURES_FIELD.name = "captures"
var_0_36.CAPTURES_FIELD.full_name = ".sgland.SurvivalExploreEndResp.captures"
var_0_36.CAPTURES_FIELD.number = 2
var_0_36.CAPTURES_FIELD.index = 1
var_0_36.CAPTURES_FIELD.label = 3
var_0_36.CAPTURES_FIELD.has_default_value = false
var_0_36.CAPTURES_FIELD.default_value = {}
var_0_36.CAPTURES_FIELD.message_type = var_0_2.RESOURCE
var_0_36.CAPTURES_FIELD.type = 11
var_0_36.CAPTURES_FIELD.cpp_type = 10
var_0_36.GAIN_TIME_FIELD.name = "gain_time"
var_0_36.GAIN_TIME_FIELD.full_name = ".sgland.SurvivalExploreEndResp.gain_time"
var_0_36.GAIN_TIME_FIELD.number = 3
var_0_36.GAIN_TIME_FIELD.index = 2
var_0_36.GAIN_TIME_FIELD.label = 2
var_0_36.GAIN_TIME_FIELD.has_default_value = false
var_0_36.GAIN_TIME_FIELD.default_value = 0
var_0_36.GAIN_TIME_FIELD.type = 5
var_0_36.GAIN_TIME_FIELD.cpp_type = 1
SURVIVALEXPLOREENDRESP.name = "SurvivalExploreEndResp"
SURVIVALEXPLOREENDRESP.full_name = ".sgland.SurvivalExploreEndResp"
SURVIVALEXPLOREENDRESP.nested_types = {}
SURVIVALEXPLOREENDRESP.enum_types = {}
SURVIVALEXPLOREENDRESP.fields = {
	var_0_36.GAMEOVER_TIMESTAMP_FIELD,
	var_0_36.CAPTURES_FIELD,
	var_0_36.GAIN_TIME_FIELD
}
SURVIVALEXPLOREENDRESP.is_extendable = false
SURVIVALEXPLOREENDRESP.extensions = {}
var_0_37.USER_ID_FIELD.name = "user_id"
var_0_37.USER_ID_FIELD.full_name = ".sgland.SurvivalEndResp.user_id"
var_0_37.USER_ID_FIELD.number = 1
var_0_37.USER_ID_FIELD.index = 0
var_0_37.USER_ID_FIELD.label = 2
var_0_37.USER_ID_FIELD.has_default_value = false
var_0_37.USER_ID_FIELD.default_value = 0
var_0_37.USER_ID_FIELD.type = 3
var_0_37.USER_ID_FIELD.cpp_type = 2
var_0_37.RANK_FIELD.name = "rank"
var_0_37.RANK_FIELD.full_name = ".sgland.SurvivalEndResp.rank"
var_0_37.RANK_FIELD.number = 2
var_0_37.RANK_FIELD.index = 1
var_0_37.RANK_FIELD.label = 2
var_0_37.RANK_FIELD.has_default_value = false
var_0_37.RANK_FIELD.default_value = 0
var_0_37.RANK_FIELD.type = 5
var_0_37.RANK_FIELD.cpp_type = 1
var_0_37.RESOURCE_FIELD.name = "resource"
var_0_37.RESOURCE_FIELD.full_name = ".sgland.SurvivalEndResp.resource"
var_0_37.RESOURCE_FIELD.number = 3
var_0_37.RESOURCE_FIELD.index = 2
var_0_37.RESOURCE_FIELD.label = 3
var_0_37.RESOURCE_FIELD.has_default_value = false
var_0_37.RESOURCE_FIELD.default_value = {}
var_0_37.RESOURCE_FIELD.message_type = var_0_2.RESOURCE
var_0_37.RESOURCE_FIELD.type = 11
var_0_37.RESOURCE_FIELD.cpp_type = 10
SURVIVALENDRESP.name = "SurvivalEndResp"
SURVIVALENDRESP.full_name = ".sgland.SurvivalEndResp"
SURVIVALENDRESP.nested_types = {}
SURVIVALENDRESP.enum_types = {}
SURVIVALENDRESP.fields = {
	var_0_37.USER_ID_FIELD,
	var_0_37.RANK_FIELD,
	var_0_37.RESOURCE_FIELD
}
SURVIVALENDRESP.is_extendable = false
SURVIVALENDRESP.extensions = {}
var_0_38.CARDS_FIELD.name = "cards"
var_0_38.CARDS_FIELD.full_name = ".sgland.SurvivalExExploreStartReq.cards"
var_0_38.CARDS_FIELD.number = 1
var_0_38.CARDS_FIELD.index = 0
var_0_38.CARDS_FIELD.label = 3
var_0_38.CARDS_FIELD.has_default_value = false
var_0_38.CARDS_FIELD.default_value = {}
var_0_38.CARDS_FIELD.message_type = var_0_2.RESOURCE
var_0_38.CARDS_FIELD.type = 11
var_0_38.CARDS_FIELD.cpp_type = 10
var_0_38.CARD_EXTRA_SKILLS_FIELD.name = "card_extra_skills"
var_0_38.CARD_EXTRA_SKILLS_FIELD.full_name = ".sgland.SurvivalExExploreStartReq.card_extra_skills"
var_0_38.CARD_EXTRA_SKILLS_FIELD.number = 2
var_0_38.CARD_EXTRA_SKILLS_FIELD.index = 1
var_0_38.CARD_EXTRA_SKILLS_FIELD.label = 3
var_0_38.CARD_EXTRA_SKILLS_FIELD.has_default_value = false
var_0_38.CARD_EXTRA_SKILLS_FIELD.default_value = {}
var_0_38.CARD_EXTRA_SKILLS_FIELD.message_type = var_0_2.CARDEXTRASKILL
var_0_38.CARD_EXTRA_SKILLS_FIELD.type = 11
var_0_38.CARD_EXTRA_SKILLS_FIELD.cpp_type = 10
var_0_38.HAS_PRIVILEGE_FIELD.name = "has_privilege"
var_0_38.HAS_PRIVILEGE_FIELD.full_name = ".sgland.SurvivalExExploreStartReq.has_privilege"
var_0_38.HAS_PRIVILEGE_FIELD.number = 3
var_0_38.HAS_PRIVILEGE_FIELD.index = 2
var_0_38.HAS_PRIVILEGE_FIELD.label = 1
var_0_38.HAS_PRIVILEGE_FIELD.has_default_value = false
var_0_38.HAS_PRIVILEGE_FIELD.default_value = false
var_0_38.HAS_PRIVILEGE_FIELD.type = 8
var_0_38.HAS_PRIVILEGE_FIELD.cpp_type = 7
SURVIVALEXEXPLORESTARTREQ.name = "SurvivalExExploreStartReq"
SURVIVALEXEXPLORESTARTREQ.full_name = ".sgland.SurvivalExExploreStartReq"
SURVIVALEXEXPLORESTARTREQ.nested_types = {}
SURVIVALEXEXPLORESTARTREQ.enum_types = {}
SURVIVALEXEXPLORESTARTREQ.fields = {
	var_0_38.CARDS_FIELD,
	var_0_38.CARD_EXTRA_SKILLS_FIELD,
	var_0_38.HAS_PRIVILEGE_FIELD
}
SURVIVALEXEXPLORESTARTREQ.is_extendable = false
SURVIVALEXEXPLORESTARTREQ.extensions = {}
var_0_39.GAMEOVER_TIMESTAMP_FIELD.name = "gameover_timestamp"
var_0_39.GAMEOVER_TIMESTAMP_FIELD.full_name = ".sgland.SurvivalExExploreEndResp.gameover_timestamp"
var_0_39.GAMEOVER_TIMESTAMP_FIELD.number = 1
var_0_39.GAMEOVER_TIMESTAMP_FIELD.index = 0
var_0_39.GAMEOVER_TIMESTAMP_FIELD.label = 2
var_0_39.GAMEOVER_TIMESTAMP_FIELD.has_default_value = false
var_0_39.GAMEOVER_TIMESTAMP_FIELD.default_value = 0
var_0_39.GAMEOVER_TIMESTAMP_FIELD.type = 3
var_0_39.GAMEOVER_TIMESTAMP_FIELD.cpp_type = 2
var_0_39.CAPTURES_FIELD.name = "captures"
var_0_39.CAPTURES_FIELD.full_name = ".sgland.SurvivalExExploreEndResp.captures"
var_0_39.CAPTURES_FIELD.number = 2
var_0_39.CAPTURES_FIELD.index = 1
var_0_39.CAPTURES_FIELD.label = 3
var_0_39.CAPTURES_FIELD.has_default_value = false
var_0_39.CAPTURES_FIELD.default_value = {}
var_0_39.CAPTURES_FIELD.message_type = var_0_2.RESOURCE
var_0_39.CAPTURES_FIELD.type = 11
var_0_39.CAPTURES_FIELD.cpp_type = 10
var_0_39.GAIN_SKILLS_FIELD.name = "gain_skills"
var_0_39.GAIN_SKILLS_FIELD.full_name = ".sgland.SurvivalExExploreEndResp.gain_skills"
var_0_39.GAIN_SKILLS_FIELD.number = 3
var_0_39.GAIN_SKILLS_FIELD.index = 2
var_0_39.GAIN_SKILLS_FIELD.label = 3
var_0_39.GAIN_SKILLS_FIELD.has_default_value = false
var_0_39.GAIN_SKILLS_FIELD.default_value = {}
var_0_39.GAIN_SKILLS_FIELD.type = 3
var_0_39.GAIN_SKILLS_FIELD.cpp_type = 2
var_0_39.GAIN_TIME_FIELD.name = "gain_time"
var_0_39.GAIN_TIME_FIELD.full_name = ".sgland.SurvivalExExploreEndResp.gain_time"
var_0_39.GAIN_TIME_FIELD.number = 4
var_0_39.GAIN_TIME_FIELD.index = 3
var_0_39.GAIN_TIME_FIELD.label = 2
var_0_39.GAIN_TIME_FIELD.has_default_value = false
var_0_39.GAIN_TIME_FIELD.default_value = 0
var_0_39.GAIN_TIME_FIELD.type = 5
var_0_39.GAIN_TIME_FIELD.cpp_type = 1
var_0_39.WIN_FIELD.name = "win"
var_0_39.WIN_FIELD.full_name = ".sgland.SurvivalExExploreEndResp.win"
var_0_39.WIN_FIELD.number = 5
var_0_39.WIN_FIELD.index = 4
var_0_39.WIN_FIELD.label = 1
var_0_39.WIN_FIELD.has_default_value = false
var_0_39.WIN_FIELD.default_value = 0
var_0_39.WIN_FIELD.type = 5
var_0_39.WIN_FIELD.cpp_type = 1
var_0_39.LOSE_FIELD.name = "lose"
var_0_39.LOSE_FIELD.full_name = ".sgland.SurvivalExExploreEndResp.lose"
var_0_39.LOSE_FIELD.number = 6
var_0_39.LOSE_FIELD.index = 5
var_0_39.LOSE_FIELD.label = 1
var_0_39.LOSE_FIELD.has_default_value = false
var_0_39.LOSE_FIELD.default_value = 0
var_0_39.LOSE_FIELD.type = 5
var_0_39.LOSE_FIELD.cpp_type = 1
var_0_39.TROPHY_FIELD.name = "trophy"
var_0_39.TROPHY_FIELD.full_name = ".sgland.SurvivalExExploreEndResp.trophy"
var_0_39.TROPHY_FIELD.number = 7
var_0_39.TROPHY_FIELD.index = 6
var_0_39.TROPHY_FIELD.label = 1
var_0_39.TROPHY_FIELD.has_default_value = false
var_0_39.TROPHY_FIELD.default_value = 0
var_0_39.TROPHY_FIELD.type = 5
var_0_39.TROPHY_FIELD.cpp_type = 1
SURVIVALEXEXPLOREENDRESP.name = "SurvivalExExploreEndResp"
SURVIVALEXEXPLOREENDRESP.full_name = ".sgland.SurvivalExExploreEndResp"
SURVIVALEXEXPLOREENDRESP.nested_types = {}
SURVIVALEXEXPLOREENDRESP.enum_types = {}
SURVIVALEXEXPLOREENDRESP.fields = {
	var_0_39.GAMEOVER_TIMESTAMP_FIELD,
	var_0_39.CAPTURES_FIELD,
	var_0_39.GAIN_SKILLS_FIELD,
	var_0_39.GAIN_TIME_FIELD,
	var_0_39.WIN_FIELD,
	var_0_39.LOSE_FIELD,
	var_0_39.TROPHY_FIELD
}
SURVIVALEXEXPLOREENDRESP.is_extendable = false
SURVIVALEXEXPLOREENDRESP.extensions = {}
var_0_40.USER_ID_FIELD.name = "user_id"
var_0_40.USER_ID_FIELD.full_name = ".sgland.SurvivalExEndResp.user_id"
var_0_40.USER_ID_FIELD.number = 1
var_0_40.USER_ID_FIELD.index = 0
var_0_40.USER_ID_FIELD.label = 2
var_0_40.USER_ID_FIELD.has_default_value = false
var_0_40.USER_ID_FIELD.default_value = 0
var_0_40.USER_ID_FIELD.type = 3
var_0_40.USER_ID_FIELD.cpp_type = 2
var_0_40.RANK_FIELD.name = "rank"
var_0_40.RANK_FIELD.full_name = ".sgland.SurvivalExEndResp.rank"
var_0_40.RANK_FIELD.number = 2
var_0_40.RANK_FIELD.index = 1
var_0_40.RANK_FIELD.label = 2
var_0_40.RANK_FIELD.has_default_value = false
var_0_40.RANK_FIELD.default_value = 0
var_0_40.RANK_FIELD.type = 5
var_0_40.RANK_FIELD.cpp_type = 1
var_0_40.RESOURCE_FIELD.name = "resource"
var_0_40.RESOURCE_FIELD.full_name = ".sgland.SurvivalExEndResp.resource"
var_0_40.RESOURCE_FIELD.number = 3
var_0_40.RESOURCE_FIELD.index = 2
var_0_40.RESOURCE_FIELD.label = 3
var_0_40.RESOURCE_FIELD.has_default_value = false
var_0_40.RESOURCE_FIELD.default_value = {}
var_0_40.RESOURCE_FIELD.message_type = var_0_2.RESOURCE
var_0_40.RESOURCE_FIELD.type = 11
var_0_40.RESOURCE_FIELD.cpp_type = 10
var_0_40.WIN_FIELD.name = "win"
var_0_40.WIN_FIELD.full_name = ".sgland.SurvivalExEndResp.win"
var_0_40.WIN_FIELD.number = 4
var_0_40.WIN_FIELD.index = 3
var_0_40.WIN_FIELD.label = 1
var_0_40.WIN_FIELD.has_default_value = false
var_0_40.WIN_FIELD.default_value = 0
var_0_40.WIN_FIELD.type = 5
var_0_40.WIN_FIELD.cpp_type = 1
var_0_40.TROPHY_FIELD.name = "trophy"
var_0_40.TROPHY_FIELD.full_name = ".sgland.SurvivalExEndResp.trophy"
var_0_40.TROPHY_FIELD.number = 5
var_0_40.TROPHY_FIELD.index = 4
var_0_40.TROPHY_FIELD.label = 1
var_0_40.TROPHY_FIELD.has_default_value = false
var_0_40.TROPHY_FIELD.default_value = 0
var_0_40.TROPHY_FIELD.type = 5
var_0_40.TROPHY_FIELD.cpp_type = 1
SURVIVALEXENDRESP.name = "SurvivalExEndResp"
SURVIVALEXENDRESP.full_name = ".sgland.SurvivalExEndResp"
SURVIVALEXENDRESP.nested_types = {}
SURVIVALEXENDRESP.enum_types = {}
SURVIVALEXENDRESP.fields = {
	var_0_40.USER_ID_FIELD,
	var_0_40.RANK_FIELD,
	var_0_40.RESOURCE_FIELD,
	var_0_40.WIN_FIELD,
	var_0_40.TROPHY_FIELD
}
SURVIVALEXENDRESP.is_extendable = false
SURVIVALEXENDRESP.extensions = {}
var_0_41.CARD_FIELD.name = "card"
var_0_41.CARD_FIELD.full_name = ".sgland.SurvivalExEquipSkillReq.card"
var_0_41.CARD_FIELD.number = 1
var_0_41.CARD_FIELD.index = 0
var_0_41.CARD_FIELD.label = 2
var_0_41.CARD_FIELD.has_default_value = false
var_0_41.CARD_FIELD.default_value = 0
var_0_41.CARD_FIELD.type = 5
var_0_41.CARD_FIELD.cpp_type = 1
var_0_41.SKILLS_FIELD.name = "skills"
var_0_41.SKILLS_FIELD.full_name = ".sgland.SurvivalExEquipSkillReq.skills"
var_0_41.SKILLS_FIELD.number = 2
var_0_41.SKILLS_FIELD.index = 1
var_0_41.SKILLS_FIELD.label = 3
var_0_41.SKILLS_FIELD.has_default_value = false
var_0_41.SKILLS_FIELD.default_value = {}
var_0_41.SKILLS_FIELD.type = 3
var_0_41.SKILLS_FIELD.cpp_type = 2
SURVIVALEXEQUIPSKILLREQ.name = "SurvivalExEquipSkillReq"
SURVIVALEXEQUIPSKILLREQ.full_name = ".sgland.SurvivalExEquipSkillReq"
SURVIVALEXEQUIPSKILLREQ.nested_types = {}
SURVIVALEXEQUIPSKILLREQ.enum_types = {}
SURVIVALEXEQUIPSKILLREQ.fields = {
	var_0_41.CARD_FIELD,
	var_0_41.SKILLS_FIELD
}
SURVIVALEXEQUIPSKILLREQ.is_extendable = false
SURVIVALEXEQUIPSKILLREQ.extensions = {}
var_0_42.WORLD_ATTACK_REQ_FIELD.name = "world_attack_req"
var_0_42.WORLD_ATTACK_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_attack_req"
var_0_42.WORLD_ATTACK_REQ_FIELD.number = 600
var_0_42.WORLD_ATTACK_REQ_FIELD.index = 0
var_0_42.WORLD_ATTACK_REQ_FIELD.label = 1
var_0_42.WORLD_ATTACK_REQ_FIELD.has_default_value = false
var_0_42.WORLD_ATTACK_REQ_FIELD.default_value = nil
var_0_42.WORLD_ATTACK_REQ_FIELD.message_type = WORLDATTACKREQ
var_0_42.WORLD_ATTACK_REQ_FIELD.type = 11
var_0_42.WORLD_ATTACK_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_CHALLENGE_REQ_FIELD.name = "world_challenge_req"
var_0_42.WORLD_CHALLENGE_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_challenge_req"
var_0_42.WORLD_CHALLENGE_REQ_FIELD.number = 601
var_0_42.WORLD_CHALLENGE_REQ_FIELD.index = 1
var_0_42.WORLD_CHALLENGE_REQ_FIELD.label = 1
var_0_42.WORLD_CHALLENGE_REQ_FIELD.has_default_value = false
var_0_42.WORLD_CHALLENGE_REQ_FIELD.default_value = nil
var_0_42.WORLD_CHALLENGE_REQ_FIELD.message_type = WORLDCHALLENGEREQ
var_0_42.WORLD_CHALLENGE_REQ_FIELD.type = 11
var_0_42.WORLD_CHALLENGE_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_SWEEP_REQ_FIELD.name = "world_sweep_req"
var_0_42.WORLD_SWEEP_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_sweep_req"
var_0_42.WORLD_SWEEP_REQ_FIELD.number = 602
var_0_42.WORLD_SWEEP_REQ_FIELD.index = 2
var_0_42.WORLD_SWEEP_REQ_FIELD.label = 1
var_0_42.WORLD_SWEEP_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SWEEP_REQ_FIELD.default_value = nil
var_0_42.WORLD_SWEEP_REQ_FIELD.message_type = WORLDCITY
var_0_42.WORLD_SWEEP_REQ_FIELD.type = 11
var_0_42.WORLD_SWEEP_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_SCOUT_REQ_FIELD.name = "world_scout_req"
var_0_42.WORLD_SCOUT_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_scout_req"
var_0_42.WORLD_SCOUT_REQ_FIELD.number = 605
var_0_42.WORLD_SCOUT_REQ_FIELD.index = 3
var_0_42.WORLD_SCOUT_REQ_FIELD.label = 1
var_0_42.WORLD_SCOUT_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SCOUT_REQ_FIELD.default_value = 0
var_0_42.WORLD_SCOUT_REQ_FIELD.type = 5
var_0_42.WORLD_SCOUT_REQ_FIELD.cpp_type = 1
var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD.name = "world_reset_sweep_count_req"
var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_reset_sweep_count_req"
var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD.number = 606
var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD.index = 4
var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD.label = 1
var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD.has_default_value = false
var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD.default_value = nil
var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD.message_type = WORLDCITY
var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD.type = 11
var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD.name = "world_challenge_commander_req"
var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_challenge_commander_req"
var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD.number = 607
var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD.index = 5
var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD.label = 1
var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD.has_default_value = false
var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD.default_value = nil
var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD.message_type = WORLDCHALLENGECOPYREQ
var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD.type = 11
var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD.name = "world_challenge_elite_req"
var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_challenge_elite_req"
var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD.number = 608
var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD.index = 6
var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD.label = 1
var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD.has_default_value = false
var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD.default_value = nil
var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD.message_type = WORLDCHALLENGECOPYREQ
var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD.type = 11
var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_FIND_START_REQ_FIELD.name = "world_find_start_req"
var_0_42.WORLD_FIND_START_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_find_start_req"
var_0_42.WORLD_FIND_START_REQ_FIELD.number = 609
var_0_42.WORLD_FIND_START_REQ_FIELD.index = 7
var_0_42.WORLD_FIND_START_REQ_FIELD.label = 1
var_0_42.WORLD_FIND_START_REQ_FIELD.has_default_value = false
var_0_42.WORLD_FIND_START_REQ_FIELD.default_value = nil
var_0_42.WORLD_FIND_START_REQ_FIELD.message_type = WORLDFINDSTARTREQ
var_0_42.WORLD_FIND_START_REQ_FIELD.type = 11
var_0_42.WORLD_FIND_START_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD.name = "world_battle_join_req"
var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_battle_join_req"
var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD.number = 610
var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD.index = 8
var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD.label = 1
var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD.has_default_value = false
var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD.default_value = 0
var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD.type = 3
var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD.cpp_type = 2
var_0_42.WORLD_ROB_EXP_REQ_FIELD.name = "world_rob_exp_req"
var_0_42.WORLD_ROB_EXP_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_rob_exp_req"
var_0_42.WORLD_ROB_EXP_REQ_FIELD.number = 611
var_0_42.WORLD_ROB_EXP_REQ_FIELD.index = 9
var_0_42.WORLD_ROB_EXP_REQ_FIELD.label = 1
var_0_42.WORLD_ROB_EXP_REQ_FIELD.has_default_value = false
var_0_42.WORLD_ROB_EXP_REQ_FIELD.default_value = nil
var_0_42.WORLD_ROB_EXP_REQ_FIELD.message_type = WORLDCHALLENGECOPYREQ
var_0_42.WORLD_ROB_EXP_REQ_FIELD.type = 11
var_0_42.WORLD_ROB_EXP_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_SWEEP_COPY_REQ_FIELD.name = "world_sweep_copy_req"
var_0_42.WORLD_SWEEP_COPY_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_sweep_copy_req"
var_0_42.WORLD_SWEEP_COPY_REQ_FIELD.number = 612
var_0_42.WORLD_SWEEP_COPY_REQ_FIELD.index = 10
var_0_42.WORLD_SWEEP_COPY_REQ_FIELD.label = 1
var_0_42.WORLD_SWEEP_COPY_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SWEEP_COPY_REQ_FIELD.default_value = nil
var_0_42.WORLD_SWEEP_COPY_REQ_FIELD.message_type = WORLDSWEEPCOPYREQ
var_0_42.WORLD_SWEEP_COPY_REQ_FIELD.type = 11
var_0_42.WORLD_SWEEP_COPY_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_SOS_REQ_FIELD.name = "world_sos_req"
var_0_42.WORLD_SOS_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_sos_req"
var_0_42.WORLD_SOS_REQ_FIELD.number = 613
var_0_42.WORLD_SOS_REQ_FIELD.index = 11
var_0_42.WORLD_SOS_REQ_FIELD.label = 1
var_0_42.WORLD_SOS_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SOS_REQ_FIELD.default_value = nil
var_0_42.WORLD_SOS_REQ_FIELD.message_type = WORLDSOSREQ
var_0_42.WORLD_SOS_REQ_FIELD.type = 11
var_0_42.WORLD_SOS_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_RESCUE_REQ_FIELD.name = "world_rescue_req"
var_0_42.WORLD_RESCUE_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_rescue_req"
var_0_42.WORLD_RESCUE_REQ_FIELD.number = 614
var_0_42.WORLD_RESCUE_REQ_FIELD.index = 12
var_0_42.WORLD_RESCUE_REQ_FIELD.label = 1
var_0_42.WORLD_RESCUE_REQ_FIELD.has_default_value = false
var_0_42.WORLD_RESCUE_REQ_FIELD.default_value = nil
var_0_42.WORLD_RESCUE_REQ_FIELD.message_type = WORLDRESCUEREQ
var_0_42.WORLD_RESCUE_REQ_FIELD.type = 11
var_0_42.WORLD_RESCUE_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD.name = "world_rescue_join_req"
var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_rescue_join_req"
var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD.number = 615
var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD.index = 13
var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD.label = 1
var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD.has_default_value = false
var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD.default_value = 0
var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD.type = 3
var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD.cpp_type = 2
var_0_42.WORLD_FIND_EX_REQ_FIELD.name = "world_find_ex_req"
var_0_42.WORLD_FIND_EX_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_find_ex_req"
var_0_42.WORLD_FIND_EX_REQ_FIELD.number = 616
var_0_42.WORLD_FIND_EX_REQ_FIELD.index = 14
var_0_42.WORLD_FIND_EX_REQ_FIELD.label = 1
var_0_42.WORLD_FIND_EX_REQ_FIELD.has_default_value = false
var_0_42.WORLD_FIND_EX_REQ_FIELD.default_value = nil
var_0_42.WORLD_FIND_EX_REQ_FIELD.message_type = WORLDFINDEXREQ
var_0_42.WORLD_FIND_EX_REQ_FIELD.type = 11
var_0_42.WORLD_FIND_EX_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_FIND_SERVER_REQ_FIELD.name = "world_find_server_req"
var_0_42.WORLD_FIND_SERVER_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_find_server_req"
var_0_42.WORLD_FIND_SERVER_REQ_FIELD.number = 617
var_0_42.WORLD_FIND_SERVER_REQ_FIELD.index = 15
var_0_42.WORLD_FIND_SERVER_REQ_FIELD.label = 1
var_0_42.WORLD_FIND_SERVER_REQ_FIELD.has_default_value = false
var_0_42.WORLD_FIND_SERVER_REQ_FIELD.default_value = nil
var_0_42.WORLD_FIND_SERVER_REQ_FIELD.message_type = WORLDFINDREQ
var_0_42.WORLD_FIND_SERVER_REQ_FIELD.type = 11
var_0_42.WORLD_FIND_SERVER_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD.name = "world_battle_join_server_req"
var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_battle_join_server_req"
var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD.number = 618
var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD.index = 16
var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD.label = 1
var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD.has_default_value = false
var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD.default_value = nil
var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD.message_type = WORLDBATTLEJOINREQ
var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD.type = 11
var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_PROXY_REQ_FIELD.name = "world_proxy_req"
var_0_42.WORLD_PROXY_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_proxy_req"
var_0_42.WORLD_PROXY_REQ_FIELD.number = 619
var_0_42.WORLD_PROXY_REQ_FIELD.index = 17
var_0_42.WORLD_PROXY_REQ_FIELD.label = 1
var_0_42.WORLD_PROXY_REQ_FIELD.has_default_value = false
var_0_42.WORLD_PROXY_REQ_FIELD.default_value = nil
var_0_42.WORLD_PROXY_REQ_FIELD.message_type = var_0_2.ACCOUNTINFO
var_0_42.WORLD_PROXY_REQ_FIELD.type = 11
var_0_42.WORLD_PROXY_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_INFO_REQ_FIELD.name = "world_info_req"
var_0_42.WORLD_INFO_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_info_req"
var_0_42.WORLD_INFO_REQ_FIELD.number = 620
var_0_42.WORLD_INFO_REQ_FIELD.index = 18
var_0_42.WORLD_INFO_REQ_FIELD.label = 1
var_0_42.WORLD_INFO_REQ_FIELD.has_default_value = false
var_0_42.WORLD_INFO_REQ_FIELD.default_value = nil
var_0_42.WORLD_INFO_REQ_FIELD.message_type = var_0_2.USERINFO
var_0_42.WORLD_INFO_REQ_FIELD.type = 11
var_0_42.WORLD_INFO_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_TIME_REQ_FIELD.name = "world_time_req"
var_0_42.WORLD_TIME_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_time_req"
var_0_42.WORLD_TIME_REQ_FIELD.number = 621
var_0_42.WORLD_TIME_REQ_FIELD.index = 19
var_0_42.WORLD_TIME_REQ_FIELD.label = 1
var_0_42.WORLD_TIME_REQ_FIELD.has_default_value = false
var_0_42.WORLD_TIME_REQ_FIELD.default_value = 0
var_0_42.WORLD_TIME_REQ_FIELD.type = 3
var_0_42.WORLD_TIME_REQ_FIELD.cpp_type = 2
var_0_42.WORLD_ROB_GOLD_REQ_FIELD.name = "world_rob_gold_req"
var_0_42.WORLD_ROB_GOLD_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_rob_gold_req"
var_0_42.WORLD_ROB_GOLD_REQ_FIELD.number = 622
var_0_42.WORLD_ROB_GOLD_REQ_FIELD.index = 20
var_0_42.WORLD_ROB_GOLD_REQ_FIELD.label = 1
var_0_42.WORLD_ROB_GOLD_REQ_FIELD.has_default_value = false
var_0_42.WORLD_ROB_GOLD_REQ_FIELD.default_value = nil
var_0_42.WORLD_ROB_GOLD_REQ_FIELD.message_type = WORLDROBGOLDREQ
var_0_42.WORLD_ROB_GOLD_REQ_FIELD.type = 11
var_0_42.WORLD_ROB_GOLD_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_EXPEDITION_REQ_FIELD.name = "world_expedition_req"
var_0_42.WORLD_EXPEDITION_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_expedition_req"
var_0_42.WORLD_EXPEDITION_REQ_FIELD.number = 623
var_0_42.WORLD_EXPEDITION_REQ_FIELD.index = 21
var_0_42.WORLD_EXPEDITION_REQ_FIELD.label = 1
var_0_42.WORLD_EXPEDITION_REQ_FIELD.has_default_value = false
var_0_42.WORLD_EXPEDITION_REQ_FIELD.default_value = 0
var_0_42.WORLD_EXPEDITION_REQ_FIELD.type = 5
var_0_42.WORLD_EXPEDITION_REQ_FIELD.cpp_type = 1
var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD.name = "world_expedition_ex_req"
var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_expedition_ex_req"
var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD.number = 624
var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD.index = 22
var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD.label = 1
var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD.has_default_value = false
var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD.default_value = nil
var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD.message_type = WORLDEXPEDITIONEXREQ
var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD.type = 11
var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD.name = "world_lottery_user_token"
var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD.full_name = ".sgland.SglWorldMsg.world_lottery_user_token"
var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD.number = 625
var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD.index = 23
var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD.label = 1
var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD.has_default_value = false
var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD.default_value = false
var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD.type = 8
var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD.cpp_type = 7
var_0_42.WORLD_BUY_TICKET_REQ_FIELD.name = "world_buy_ticket_req"
var_0_42.WORLD_BUY_TICKET_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_buy_ticket_req"
var_0_42.WORLD_BUY_TICKET_REQ_FIELD.number = 626
var_0_42.WORLD_BUY_TICKET_REQ_FIELD.index = 24
var_0_42.WORLD_BUY_TICKET_REQ_FIELD.label = 1
var_0_42.WORLD_BUY_TICKET_REQ_FIELD.has_default_value = false
var_0_42.WORLD_BUY_TICKET_REQ_FIELD.default_value = 0
var_0_42.WORLD_BUY_TICKET_REQ_FIELD.type = 5
var_0_42.WORLD_BUY_TICKET_REQ_FIELD.cpp_type = 1
var_0_42.WORLD_SELECT_CHAR_REQ_FIELD.name = "world_select_char_req"
var_0_42.WORLD_SELECT_CHAR_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_select_char_req"
var_0_42.WORLD_SELECT_CHAR_REQ_FIELD.number = 627
var_0_42.WORLD_SELECT_CHAR_REQ_FIELD.index = 25
var_0_42.WORLD_SELECT_CHAR_REQ_FIELD.label = 1
var_0_42.WORLD_SELECT_CHAR_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SELECT_CHAR_REQ_FIELD.default_value = 0
var_0_42.WORLD_SELECT_CHAR_REQ_FIELD.type = 5
var_0_42.WORLD_SELECT_CHAR_REQ_FIELD.cpp_type = 1
var_0_42.WORLD_SELECT_CARD_REQ_FIELD.name = "world_select_card_req"
var_0_42.WORLD_SELECT_CARD_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_select_card_req"
var_0_42.WORLD_SELECT_CARD_REQ_FIELD.number = 628
var_0_42.WORLD_SELECT_CARD_REQ_FIELD.index = 26
var_0_42.WORLD_SELECT_CARD_REQ_FIELD.label = 1
var_0_42.WORLD_SELECT_CARD_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SELECT_CARD_REQ_FIELD.default_value = 0
var_0_42.WORLD_SELECT_CARD_REQ_FIELD.type = 5
var_0_42.WORLD_SELECT_CARD_REQ_FIELD.cpp_type = 1
var_0_42.WORLD_LOTTERY_COUNT_FIELD.name = "world_lottery_count"
var_0_42.WORLD_LOTTERY_COUNT_FIELD.full_name = ".sgland.SglWorldMsg.world_lottery_count"
var_0_42.WORLD_LOTTERY_COUNT_FIELD.number = 629
var_0_42.WORLD_LOTTERY_COUNT_FIELD.index = 27
var_0_42.WORLD_LOTTERY_COUNT_FIELD.label = 1
var_0_42.WORLD_LOTTERY_COUNT_FIELD.has_default_value = false
var_0_42.WORLD_LOTTERY_COUNT_FIELD.default_value = 0
var_0_42.WORLD_LOTTERY_COUNT_FIELD.type = 5
var_0_42.WORLD_LOTTERY_COUNT_FIELD.cpp_type = 1
var_0_42.WORLD_CREATE_MATCH_REQ_FIELD.name = "world_create_match_req"
var_0_42.WORLD_CREATE_MATCH_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_create_match_req"
var_0_42.WORLD_CREATE_MATCH_REQ_FIELD.number = 630
var_0_42.WORLD_CREATE_MATCH_REQ_FIELD.index = 28
var_0_42.WORLD_CREATE_MATCH_REQ_FIELD.label = 1
var_0_42.WORLD_CREATE_MATCH_REQ_FIELD.has_default_value = false
var_0_42.WORLD_CREATE_MATCH_REQ_FIELD.default_value = ""
var_0_42.WORLD_CREATE_MATCH_REQ_FIELD.type = 9
var_0_42.WORLD_CREATE_MATCH_REQ_FIELD.cpp_type = 9
var_0_42.WORLD_QUERY_MATCH_REQ_FIELD.name = "world_query_match_req"
var_0_42.WORLD_QUERY_MATCH_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_query_match_req"
var_0_42.WORLD_QUERY_MATCH_REQ_FIELD.number = 631
var_0_42.WORLD_QUERY_MATCH_REQ_FIELD.index = 29
var_0_42.WORLD_QUERY_MATCH_REQ_FIELD.label = 1
var_0_42.WORLD_QUERY_MATCH_REQ_FIELD.has_default_value = false
var_0_42.WORLD_QUERY_MATCH_REQ_FIELD.default_value = 0
var_0_42.WORLD_QUERY_MATCH_REQ_FIELD.type = 5
var_0_42.WORLD_QUERY_MATCH_REQ_FIELD.cpp_type = 1
var_0_42.WORLD_JOIN_MATCH_REQ_FIELD.name = "world_join_match_req"
var_0_42.WORLD_JOIN_MATCH_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_join_match_req"
var_0_42.WORLD_JOIN_MATCH_REQ_FIELD.number = 632
var_0_42.WORLD_JOIN_MATCH_REQ_FIELD.index = 30
var_0_42.WORLD_JOIN_MATCH_REQ_FIELD.label = 1
var_0_42.WORLD_JOIN_MATCH_REQ_FIELD.has_default_value = false
var_0_42.WORLD_JOIN_MATCH_REQ_FIELD.default_value = nil
var_0_42.WORLD_JOIN_MATCH_REQ_FIELD.message_type = WORLDMATCHJOINREQ
var_0_42.WORLD_JOIN_MATCH_REQ_FIELD.type = 11
var_0_42.WORLD_JOIN_MATCH_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD.name = "world_recycle_match_req"
var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_recycle_match_req"
var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD.number = 633
var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD.index = 31
var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD.label = 1
var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD.has_default_value = false
var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD.default_value = 0
var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD.type = 5
var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD.cpp_type = 1
var_0_42.SYNC_TEAM_INFO_REQ_FIELD.name = "sync_team_info_req"
var_0_42.SYNC_TEAM_INFO_REQ_FIELD.full_name = ".sgland.SglWorldMsg.sync_team_info_req"
var_0_42.SYNC_TEAM_INFO_REQ_FIELD.number = 634
var_0_42.SYNC_TEAM_INFO_REQ_FIELD.index = 32
var_0_42.SYNC_TEAM_INFO_REQ_FIELD.label = 1
var_0_42.SYNC_TEAM_INFO_REQ_FIELD.has_default_value = false
var_0_42.SYNC_TEAM_INFO_REQ_FIELD.default_value = nil
var_0_42.SYNC_TEAM_INFO_REQ_FIELD.message_type = var_0_2.TEAMINWORLD
var_0_42.SYNC_TEAM_INFO_REQ_FIELD.type = 11
var_0_42.SYNC_TEAM_INFO_REQ_FIELD.cpp_type = 10
var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD.name = "sync_legend_lottery_req"
var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD.full_name = ".sgland.SglWorldMsg.sync_legend_lottery_req"
var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD.number = 635
var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD.index = 33
var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD.label = 1
var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD.has_default_value = false
var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD.default_value = 0
var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD.type = 5
var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD.cpp_type = 1
var_0_42.RECOMMEND_CARD_REQ_FIELD.name = "recommend_card_req"
var_0_42.RECOMMEND_CARD_REQ_FIELD.full_name = ".sgland.SglWorldMsg.recommend_card_req"
var_0_42.RECOMMEND_CARD_REQ_FIELD.number = 636
var_0_42.RECOMMEND_CARD_REQ_FIELD.index = 34
var_0_42.RECOMMEND_CARD_REQ_FIELD.label = 1
var_0_42.RECOMMEND_CARD_REQ_FIELD.has_default_value = false
var_0_42.RECOMMEND_CARD_REQ_FIELD.default_value = nil
var_0_42.RECOMMEND_CARD_REQ_FIELD.message_type = RECOMMENDCARDREQ
var_0_42.RECOMMEND_CARD_REQ_FIELD.type = 11
var_0_42.RECOMMEND_CARD_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_MATCH_TYPE_REQ_FIELD.name = "world_match_type_req"
var_0_42.WORLD_MATCH_TYPE_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_match_type_req"
var_0_42.WORLD_MATCH_TYPE_REQ_FIELD.number = 637
var_0_42.WORLD_MATCH_TYPE_REQ_FIELD.index = 35
var_0_42.WORLD_MATCH_TYPE_REQ_FIELD.label = 1
var_0_42.WORLD_MATCH_TYPE_REQ_FIELD.has_default_value = false
var_0_42.WORLD_MATCH_TYPE_REQ_FIELD.default_value = nil
var_0_42.WORLD_MATCH_TYPE_REQ_FIELD.enum_type = var_0_2.MATCHTYPE
var_0_42.WORLD_MATCH_TYPE_REQ_FIELD.type = 14
var_0_42.WORLD_MATCH_TYPE_REQ_FIELD.cpp_type = 8
var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD.name = "card_select_dark_troop_req"
var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD.full_name = ".sgland.SglWorldMsg.card_select_dark_troop_req"
var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD.number = 638
var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD.index = 36
var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD.label = 1
var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD.has_default_value = false
var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD.default_value = 0
var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD.type = 5
var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD.cpp_type = 1
var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD.name = "world_survival_explore_start_req"
var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_explore_start_req"
var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD.number = 639
var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD.index = 37
var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD.message_type = SURVIVALEXPLORESTARTREQ
var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD.name = "world_survival_hall_join_req"
var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_hall_join_req"
var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD.number = 640
var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD.index = 38
var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD.message_type = WORLDSURVIVALHALLJOINREQ
var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD.cpp_type = 10
var_0_42.WORSHIP_REQ_FIELD.name = "worship_req"
var_0_42.WORSHIP_REQ_FIELD.full_name = ".sgland.SglWorldMsg.worship_req"
var_0_42.WORSHIP_REQ_FIELD.number = 641
var_0_42.WORSHIP_REQ_FIELD.index = 39
var_0_42.WORSHIP_REQ_FIELD.label = 1
var_0_42.WORSHIP_REQ_FIELD.has_default_value = false
var_0_42.WORSHIP_REQ_FIELD.default_value = nil
var_0_42.WORSHIP_REQ_FIELD.enum_type = var_0_2.MVPTYPE
var_0_42.WORSHIP_REQ_FIELD.type = 14
var_0_42.WORSHIP_REQ_FIELD.cpp_type = 8
var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD.name = "world_lottery_ex_count"
var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD.full_name = ".sgland.SglWorldMsg.world_lottery_ex_count"
var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD.number = 642
var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD.index = 40
var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD.label = 1
var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD.has_default_value = false
var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD.default_value = 0
var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD.type = 5
var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD.cpp_type = 1
var_0_42.CHARGE_RMB_FIELD.name = "charge_rmb"
var_0_42.CHARGE_RMB_FIELD.full_name = ".sgland.SglWorldMsg.charge_rmb"
var_0_42.CHARGE_RMB_FIELD.number = 643
var_0_42.CHARGE_RMB_FIELD.index = 41
var_0_42.CHARGE_RMB_FIELD.label = 1
var_0_42.CHARGE_RMB_FIELD.has_default_value = false
var_0_42.CHARGE_RMB_FIELD.default_value = 0
var_0_42.CHARGE_RMB_FIELD.type = 5
var_0_42.CHARGE_RMB_FIELD.cpp_type = 1
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD.name = "world_survival_ex_explore_start_req"
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_ex_explore_start_req"
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD.number = 644
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD.index = 42
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD.message_type = SURVIVALEXEXPLORESTARTREQ
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD.name = "world_survival_ex_hall_join_req"
var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_ex_hall_join_req"
var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD.number = 645
var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD.index = 43
var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD.message_type = WORLDSURVIVALEXHALLJOINREQ
var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD.name = "world_survival_ex_equip_skill_req"
var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_ex_equip_skill_req"
var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD.number = 646
var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD.index = 44
var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD.message_type = SURVIVALEXEQUIPSKILLREQ
var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD.cpp_type = 10
var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD.name = "world_buy_legend_ticket_req"
var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD.full_name = ".sgland.SglWorldMsg.world_buy_legend_ticket_req"
var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD.number = 647
var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD.index = 45
var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD.label = 1
var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD.has_default_value = false
var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD.default_value = 0
var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD.type = 5
var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD.cpp_type = 1
var_0_42.WORLD_ATTACK_RESP_FIELD.name = "world_attack_resp"
var_0_42.WORLD_ATTACK_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_attack_resp"
var_0_42.WORLD_ATTACK_RESP_FIELD.number = 600
var_0_42.WORLD_ATTACK_RESP_FIELD.index = 46
var_0_42.WORLD_ATTACK_RESP_FIELD.label = 1
var_0_42.WORLD_ATTACK_RESP_FIELD.has_default_value = false
var_0_42.WORLD_ATTACK_RESP_FIELD.default_value = nil
var_0_42.WORLD_ATTACK_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.WORLD_ATTACK_RESP_FIELD.type = 11
var_0_42.WORLD_ATTACK_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_FIND_RESP_FIELD.name = "world_find_resp"
var_0_42.WORLD_FIND_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_find_resp"
var_0_42.WORLD_FIND_RESP_FIELD.number = 601
var_0_42.WORLD_FIND_RESP_FIELD.index = 47
var_0_42.WORLD_FIND_RESP_FIELD.label = 1
var_0_42.WORLD_FIND_RESP_FIELD.has_default_value = false
var_0_42.WORLD_FIND_RESP_FIELD.default_value = nil
var_0_42.WORLD_FIND_RESP_FIELD.message_type = WORLDFINDRESP
var_0_42.WORLD_FIND_RESP_FIELD.type = 11
var_0_42.WORLD_FIND_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_CHALLENGE_RESP_FIELD.name = "world_challenge_resp"
var_0_42.WORLD_CHALLENGE_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_challenge_resp"
var_0_42.WORLD_CHALLENGE_RESP_FIELD.number = 602
var_0_42.WORLD_CHALLENGE_RESP_FIELD.index = 48
var_0_42.WORLD_CHALLENGE_RESP_FIELD.label = 1
var_0_42.WORLD_CHALLENGE_RESP_FIELD.has_default_value = false
var_0_42.WORLD_CHALLENGE_RESP_FIELD.default_value = nil
var_0_42.WORLD_CHALLENGE_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.WORLD_CHALLENGE_RESP_FIELD.type = 11
var_0_42.WORLD_CHALLENGE_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_SWEEP_RESP_FIELD.name = "world_sweep_resp"
var_0_42.WORLD_SWEEP_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_sweep_resp"
var_0_42.WORLD_SWEEP_RESP_FIELD.number = 603
var_0_42.WORLD_SWEEP_RESP_FIELD.index = 49
var_0_42.WORLD_SWEEP_RESP_FIELD.label = 1
var_0_42.WORLD_SWEEP_RESP_FIELD.has_default_value = false
var_0_42.WORLD_SWEEP_RESP_FIELD.default_value = nil
var_0_42.WORLD_SWEEP_RESP_FIELD.message_type = WORLDSWEEPRESP
var_0_42.WORLD_SWEEP_RESP_FIELD.type = 11
var_0_42.WORLD_SWEEP_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_SCOUT_RESP_FIELD.name = "world_scout_resp"
var_0_42.WORLD_SCOUT_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_scout_resp"
var_0_42.WORLD_SCOUT_RESP_FIELD.number = 604
var_0_42.WORLD_SCOUT_RESP_FIELD.index = 50
var_0_42.WORLD_SCOUT_RESP_FIELD.label = 1
var_0_42.WORLD_SCOUT_RESP_FIELD.has_default_value = false
var_0_42.WORLD_SCOUT_RESP_FIELD.default_value = nil
var_0_42.WORLD_SCOUT_RESP_FIELD.message_type = var_0_2.TROOPDATA
var_0_42.WORLD_SCOUT_RESP_FIELD.type = 11
var_0_42.WORLD_SCOUT_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD.name = "world_challenge_elite_resp"
var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_challenge_elite_resp"
var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD.number = 605
var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD.index = 51
var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD.label = 1
var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD.has_default_value = false
var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD.default_value = nil
var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD.type = 11
var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD.name = "world_challenge_commander_resp"
var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_challenge_commander_resp"
var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD.number = 606
var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD.index = 52
var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD.label = 1
var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD.has_default_value = false
var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD.default_value = nil
var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD.type = 11
var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_EXPEDITION_RESP_FIELD.name = "world_expedition_resp"
var_0_42.WORLD_EXPEDITION_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_expedition_resp"
var_0_42.WORLD_EXPEDITION_RESP_FIELD.number = 607
var_0_42.WORLD_EXPEDITION_RESP_FIELD.index = 53
var_0_42.WORLD_EXPEDITION_RESP_FIELD.label = 1
var_0_42.WORLD_EXPEDITION_RESP_FIELD.has_default_value = false
var_0_42.WORLD_EXPEDITION_RESP_FIELD.default_value = nil
var_0_42.WORLD_EXPEDITION_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.WORLD_EXPEDITION_RESP_FIELD.type = 11
var_0_42.WORLD_EXPEDITION_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD.name = "world_refresh_expedition_resp"
var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_refresh_expedition_resp"
var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD.number = 608
var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD.index = 54
var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD.label = 1
var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD.has_default_value = false
var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD.default_value = nil
var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD.message_type = var_0_2.PLAYEREXPEDITION
var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD.type = 11
var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD.name = "world_get_expedition_resp"
var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_get_expedition_resp"
var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD.number = 609
var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD.index = 55
var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD.label = 1
var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD.has_default_value = false
var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD.default_value = nil
var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD.message_type = WORLDGETEXPEDITIONRESP
var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD.type = 11
var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD.name = "world_expedition_open_resp"
var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_expedition_open_resp"
var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD.number = 610
var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD.index = 56
var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD.label = 3
var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD.has_default_value = false
var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD.default_value = {}
var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD.type = 11
var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_FIND_START_RESP_FIELD.name = "world_find_start_resp"
var_0_42.WORLD_FIND_START_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_find_start_resp"
var_0_42.WORLD_FIND_START_RESP_FIELD.number = 611
var_0_42.WORLD_FIND_START_RESP_FIELD.index = 57
var_0_42.WORLD_FIND_START_RESP_FIELD.label = 1
var_0_42.WORLD_FIND_START_RESP_FIELD.has_default_value = false
var_0_42.WORLD_FIND_START_RESP_FIELD.default_value = nil
var_0_42.WORLD_FIND_START_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.WORLD_FIND_START_RESP_FIELD.type = 11
var_0_42.WORLD_FIND_START_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_BATTLE_START_RESP_FIELD.name = "world_battle_start_resp"
var_0_42.WORLD_BATTLE_START_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_battle_start_resp"
var_0_42.WORLD_BATTLE_START_RESP_FIELD.number = 612
var_0_42.WORLD_BATTLE_START_RESP_FIELD.index = 58
var_0_42.WORLD_BATTLE_START_RESP_FIELD.label = 1
var_0_42.WORLD_BATTLE_START_RESP_FIELD.has_default_value = false
var_0_42.WORLD_BATTLE_START_RESP_FIELD.default_value = nil
var_0_42.WORLD_BATTLE_START_RESP_FIELD.message_type = WORLDBATTLESTARTRESP
var_0_42.WORLD_BATTLE_START_RESP_FIELD.type = 11
var_0_42.WORLD_BATTLE_START_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_BATTLE_END_RESP_FIELD.name = "world_battle_end_resp"
var_0_42.WORLD_BATTLE_END_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_battle_end_resp"
var_0_42.WORLD_BATTLE_END_RESP_FIELD.number = 613
var_0_42.WORLD_BATTLE_END_RESP_FIELD.index = 59
var_0_42.WORLD_BATTLE_END_RESP_FIELD.label = 1
var_0_42.WORLD_BATTLE_END_RESP_FIELD.has_default_value = false
var_0_42.WORLD_BATTLE_END_RESP_FIELD.default_value = nil
var_0_42.WORLD_BATTLE_END_RESP_FIELD.message_type = var_0_3.BATTLELOG
var_0_42.WORLD_BATTLE_END_RESP_FIELD.type = 11
var_0_42.WORLD_BATTLE_END_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_ROB_GOLD_RESP_FIELD.name = "world_rob_gold_resp"
var_0_42.WORLD_ROB_GOLD_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_rob_gold_resp"
var_0_42.WORLD_ROB_GOLD_RESP_FIELD.number = 614
var_0_42.WORLD_ROB_GOLD_RESP_FIELD.index = 60
var_0_42.WORLD_ROB_GOLD_RESP_FIELD.label = 1
var_0_42.WORLD_ROB_GOLD_RESP_FIELD.has_default_value = false
var_0_42.WORLD_ROB_GOLD_RESP_FIELD.default_value = nil
var_0_42.WORLD_ROB_GOLD_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.WORLD_ROB_GOLD_RESP_FIELD.type = 11
var_0_42.WORLD_ROB_GOLD_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_ROB_EXP_RESP_FIELD.name = "world_rob_exp_resp"
var_0_42.WORLD_ROB_EXP_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_rob_exp_resp"
var_0_42.WORLD_ROB_EXP_RESP_FIELD.number = 615
var_0_42.WORLD_ROB_EXP_RESP_FIELD.index = 61
var_0_42.WORLD_ROB_EXP_RESP_FIELD.label = 1
var_0_42.WORLD_ROB_EXP_RESP_FIELD.has_default_value = false
var_0_42.WORLD_ROB_EXP_RESP_FIELD.default_value = nil
var_0_42.WORLD_ROB_EXP_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.WORLD_ROB_EXP_RESP_FIELD.type = 11
var_0_42.WORLD_ROB_EXP_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_RESCUE_RESP_FIELD.name = "world_rescue_resp"
var_0_42.WORLD_RESCUE_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_rescue_resp"
var_0_42.WORLD_RESCUE_RESP_FIELD.number = 616
var_0_42.WORLD_RESCUE_RESP_FIELD.index = 62
var_0_42.WORLD_RESCUE_RESP_FIELD.label = 1
var_0_42.WORLD_RESCUE_RESP_FIELD.has_default_value = false
var_0_42.WORLD_RESCUE_RESP_FIELD.default_value = nil
var_0_42.WORLD_RESCUE_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.WORLD_RESCUE_RESP_FIELD.type = 11
var_0_42.WORLD_RESCUE_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_RESCUE_END_RESP_FIELD.name = "world_rescue_end_resp"
var_0_42.WORLD_RESCUE_END_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_rescue_end_resp"
var_0_42.WORLD_RESCUE_END_RESP_FIELD.number = 617
var_0_42.WORLD_RESCUE_END_RESP_FIELD.index = 63
var_0_42.WORLD_RESCUE_END_RESP_FIELD.label = 1
var_0_42.WORLD_RESCUE_END_RESP_FIELD.has_default_value = false
var_0_42.WORLD_RESCUE_END_RESP_FIELD.default_value = 0
var_0_42.WORLD_RESCUE_END_RESP_FIELD.type = 5
var_0_42.WORLD_RESCUE_END_RESP_FIELD.cpp_type = 1
var_0_42.WORLD_FOCUS_RESP_FIELD.name = "world_focus_resp"
var_0_42.WORLD_FOCUS_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_focus_resp"
var_0_42.WORLD_FOCUS_RESP_FIELD.number = 618
var_0_42.WORLD_FOCUS_RESP_FIELD.index = 64
var_0_42.WORLD_FOCUS_RESP_FIELD.label = 1
var_0_42.WORLD_FOCUS_RESP_FIELD.has_default_value = false
var_0_42.WORLD_FOCUS_RESP_FIELD.default_value = nil
var_0_42.WORLD_FOCUS_RESP_FIELD.message_type = WORLDFOCUSRESP
var_0_42.WORLD_FOCUS_RESP_FIELD.type = 11
var_0_42.WORLD_FOCUS_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_FIND_EX_RESP_FIELD.name = "world_find_ex_resp"
var_0_42.WORLD_FIND_EX_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_find_ex_resp"
var_0_42.WORLD_FIND_EX_RESP_FIELD.number = 619
var_0_42.WORLD_FIND_EX_RESP_FIELD.index = 65
var_0_42.WORLD_FIND_EX_RESP_FIELD.label = 1
var_0_42.WORLD_FIND_EX_RESP_FIELD.has_default_value = false
var_0_42.WORLD_FIND_EX_RESP_FIELD.default_value = nil
var_0_42.WORLD_FIND_EX_RESP_FIELD.message_type = WORLDFINDEXRESP
var_0_42.WORLD_FIND_EX_RESP_FIELD.type = 11
var_0_42.WORLD_FIND_EX_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_GET_OPPONENT_RESP_FIELD.name = "world_get_opponent_resp"
var_0_42.WORLD_GET_OPPONENT_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_get_opponent_resp"
var_0_42.WORLD_GET_OPPONENT_RESP_FIELD.number = 620
var_0_42.WORLD_GET_OPPONENT_RESP_FIELD.index = 66
var_0_42.WORLD_GET_OPPONENT_RESP_FIELD.label = 1
var_0_42.WORLD_GET_OPPONENT_RESP_FIELD.has_default_value = false
var_0_42.WORLD_GET_OPPONENT_RESP_FIELD.default_value = nil
var_0_42.WORLD_GET_OPPONENT_RESP_FIELD.message_type = WORLDGETOPPONENTRESP
var_0_42.WORLD_GET_OPPONENT_RESP_FIELD.type = 11
var_0_42.WORLD_GET_OPPONENT_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_RESET_TROOP_RESP_FIELD.name = "world_reset_troop_resp"
var_0_42.WORLD_RESET_TROOP_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_reset_troop_resp"
var_0_42.WORLD_RESET_TROOP_RESP_FIELD.number = 621
var_0_42.WORLD_RESET_TROOP_RESP_FIELD.index = 67
var_0_42.WORLD_RESET_TROOP_RESP_FIELD.label = 1
var_0_42.WORLD_RESET_TROOP_RESP_FIELD.has_default_value = false
var_0_42.WORLD_RESET_TROOP_RESP_FIELD.default_value = nil
var_0_42.WORLD_RESET_TROOP_RESP_FIELD.message_type = var_0_2.TROOPDATA
var_0_42.WORLD_RESET_TROOP_RESP_FIELD.type = 11
var_0_42.WORLD_RESET_TROOP_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD.name = "world_opponent_not_found_resp"
var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_opponent_not_found_resp"
var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD.number = 622
var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD.index = 68
var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD.label = 3
var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD.has_default_value = false
var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD.default_value = {}
var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD.type = 11
var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD.name = "world_expedition_ex_resp"
var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_expedition_ex_resp"
var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD.number = 623
var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD.index = 69
var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD.label = 1
var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD.has_default_value = false
var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD.default_value = nil
var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD.type = 11
var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_LOTTERY_RESP_FIELD.name = "world_lottery_resp"
var_0_42.WORLD_LOTTERY_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_lottery_resp"
var_0_42.WORLD_LOTTERY_RESP_FIELD.number = 624
var_0_42.WORLD_LOTTERY_RESP_FIELD.index = 70
var_0_42.WORLD_LOTTERY_RESP_FIELD.label = 3
var_0_42.WORLD_LOTTERY_RESP_FIELD.has_default_value = false
var_0_42.WORLD_LOTTERY_RESP_FIELD.default_value = {}
var_0_42.WORLD_LOTTERY_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_42.WORLD_LOTTERY_RESP_FIELD.type = 11
var_0_42.WORLD_LOTTERY_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD.name = "world_get_expedition_ex_resp"
var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_get_expedition_ex_resp"
var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD.number = 625
var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD.index = 71
var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD.label = 1
var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD.has_default_value = false
var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD.default_value = nil
var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD.message_type = var_0_2.PLAYEREXPEDITIONEX
var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD.type = 11
var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_SELECT_CHAR_RESP_FIELD.name = "world_select_char_resp"
var_0_42.WORLD_SELECT_CHAR_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_select_char_resp"
var_0_42.WORLD_SELECT_CHAR_RESP_FIELD.number = 626
var_0_42.WORLD_SELECT_CHAR_RESP_FIELD.index = 72
var_0_42.WORLD_SELECT_CHAR_RESP_FIELD.label = 3
var_0_42.WORLD_SELECT_CHAR_RESP_FIELD.has_default_value = false
var_0_42.WORLD_SELECT_CHAR_RESP_FIELD.default_value = {}
var_0_42.WORLD_SELECT_CHAR_RESP_FIELD.type = 5
var_0_42.WORLD_SELECT_CHAR_RESP_FIELD.cpp_type = 1
var_0_42.WORLD_QUIT_RESP_FIELD.name = "world_quit_resp"
var_0_42.WORLD_QUIT_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_quit_resp"
var_0_42.WORLD_QUIT_RESP_FIELD.number = 627
var_0_42.WORLD_QUIT_RESP_FIELD.index = 73
var_0_42.WORLD_QUIT_RESP_FIELD.label = 3
var_0_42.WORLD_QUIT_RESP_FIELD.has_default_value = false
var_0_42.WORLD_QUIT_RESP_FIELD.default_value = {}
var_0_42.WORLD_QUIT_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_42.WORLD_QUIT_RESP_FIELD.type = 11
var_0_42.WORLD_QUIT_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_BUY_TICKET_RESP_FIELD.name = "world_buy_ticket_resp"
var_0_42.WORLD_BUY_TICKET_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_buy_ticket_resp"
var_0_42.WORLD_BUY_TICKET_RESP_FIELD.number = 628
var_0_42.WORLD_BUY_TICKET_RESP_FIELD.index = 74
var_0_42.WORLD_BUY_TICKET_RESP_FIELD.label = 3
var_0_42.WORLD_BUY_TICKET_RESP_FIELD.has_default_value = false
var_0_42.WORLD_BUY_TICKET_RESP_FIELD.default_value = {}
var_0_42.WORLD_BUY_TICKET_RESP_FIELD.type = 5
var_0_42.WORLD_BUY_TICKET_RESP_FIELD.cpp_type = 1
var_0_42.WORLD_SELECT_CARD_RESP_FIELD.name = "world_select_card_resp"
var_0_42.WORLD_SELECT_CARD_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_select_card_resp"
var_0_42.WORLD_SELECT_CARD_RESP_FIELD.number = 629
var_0_42.WORLD_SELECT_CARD_RESP_FIELD.index = 75
var_0_42.WORLD_SELECT_CARD_RESP_FIELD.label = 1
var_0_42.WORLD_SELECT_CARD_RESP_FIELD.has_default_value = false
var_0_42.WORLD_SELECT_CARD_RESP_FIELD.default_value = 0
var_0_42.WORLD_SELECT_CARD_RESP_FIELD.type = 5
var_0_42.WORLD_SELECT_CARD_RESP_FIELD.cpp_type = 1
var_0_42.WORLD_GET_MATCH_RESP_FIELD.name = "world_get_match_resp"
var_0_42.WORLD_GET_MATCH_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_get_match_resp"
var_0_42.WORLD_GET_MATCH_RESP_FIELD.number = 630
var_0_42.WORLD_GET_MATCH_RESP_FIELD.index = 76
var_0_42.WORLD_GET_MATCH_RESP_FIELD.label = 1
var_0_42.WORLD_GET_MATCH_RESP_FIELD.has_default_value = false
var_0_42.WORLD_GET_MATCH_RESP_FIELD.default_value = nil
var_0_42.WORLD_GET_MATCH_RESP_FIELD.message_type = var_0_2.MATCH
var_0_42.WORLD_GET_MATCH_RESP_FIELD.type = 11
var_0_42.WORLD_GET_MATCH_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_MATCH_INFO_RESP_FIELD.name = "world_match_info_resp"
var_0_42.WORLD_MATCH_INFO_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_match_info_resp"
var_0_42.WORLD_MATCH_INFO_RESP_FIELD.number = 631
var_0_42.WORLD_MATCH_INFO_RESP_FIELD.index = 77
var_0_42.WORLD_MATCH_INFO_RESP_FIELD.label = 1
var_0_42.WORLD_MATCH_INFO_RESP_FIELD.has_default_value = false
var_0_42.WORLD_MATCH_INFO_RESP_FIELD.default_value = nil
var_0_42.WORLD_MATCH_INFO_RESP_FIELD.message_type = var_0_2.MATCHINFO
var_0_42.WORLD_MATCH_INFO_RESP_FIELD.type = 11
var_0_42.WORLD_MATCH_INFO_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_USER_ID_RESP_FIELD.name = "world_user_id_resp"
var_0_42.WORLD_USER_ID_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_user_id_resp"
var_0_42.WORLD_USER_ID_RESP_FIELD.number = 632
var_0_42.WORLD_USER_ID_RESP_FIELD.index = 78
var_0_42.WORLD_USER_ID_RESP_FIELD.label = 1
var_0_42.WORLD_USER_ID_RESP_FIELD.has_default_value = false
var_0_42.WORLD_USER_ID_RESP_FIELD.default_value = 0
var_0_42.WORLD_USER_ID_RESP_FIELD.type = 3
var_0_42.WORLD_USER_ID_RESP_FIELD.cpp_type = 2
var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD.name = "lottery_unopen_list_resp"
var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD.full_name = ".sgland.SglWorldMsg.lottery_unopen_list_resp"
var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD.number = 633
var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD.index = 79
var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD.label = 3
var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD.has_default_value = false
var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD.default_value = {}
var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD.message_type = LOTTERYUNOPENLIST
var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD.type = 11
var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD.cpp_type = 10
var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD.name = "lottery_open_list_resp"
var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD.full_name = ".sgland.SglWorldMsg.lottery_open_list_resp"
var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD.number = 634
var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD.index = 80
var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD.label = 3
var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD.has_default_value = false
var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD.default_value = {}
var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD.message_type = LOTTERYOPENLIST
var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD.type = 11
var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD.cpp_type = 10
var_0_42.RECOMMEND_TROOP_RESP_FIELD.name = "recommend_troop_resp"
var_0_42.RECOMMEND_TROOP_RESP_FIELD.full_name = ".sgland.SglWorldMsg.recommend_troop_resp"
var_0_42.RECOMMEND_TROOP_RESP_FIELD.number = 635
var_0_42.RECOMMEND_TROOP_RESP_FIELD.index = 81
var_0_42.RECOMMEND_TROOP_RESP_FIELD.label = 3
var_0_42.RECOMMEND_TROOP_RESP_FIELD.has_default_value = false
var_0_42.RECOMMEND_TROOP_RESP_FIELD.default_value = {}
var_0_42.RECOMMEND_TROOP_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_42.RECOMMEND_TROOP_RESP_FIELD.type = 11
var_0_42.RECOMMEND_TROOP_RESP_FIELD.cpp_type = 10
var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD.name = "dark_duel_dash_board_resp"
var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD.full_name = ".sgland.SglWorldMsg.dark_duel_dash_board_resp"
var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD.number = 636
var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD.index = 82
var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD.label = 1
var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD.has_default_value = false
var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD.default_value = nil
var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD.message_type = DARKDUELDASHBOARD
var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD.type = 11
var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD.name = "world_survival_hall_info_resp"
var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_hall_info_resp"
var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD.number = 637
var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD.index = 83
var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD.message_type = var_0_2.SURVIVALHALLINFO
var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD.name = "world_survival_explore_resp"
var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_explore_resp"
var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD.number = 638
var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD.index = 84
var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD.message_type = SURVIVALEXPLOREENDRESP
var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_SURVIVAL_END_RESP_FIELD.name = "world_survival_end_resp"
var_0_42.WORLD_SURVIVAL_END_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_end_resp"
var_0_42.WORLD_SURVIVAL_END_RESP_FIELD.number = 639
var_0_42.WORLD_SURVIVAL_END_RESP_FIELD.index = 85
var_0_42.WORLD_SURVIVAL_END_RESP_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_END_RESP_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_END_RESP_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_END_RESP_FIELD.message_type = SURVIVALENDRESP
var_0_42.WORLD_SURVIVAL_END_RESP_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_END_RESP_FIELD.cpp_type = 10
var_0_42.WORSHIP_MVPS_RESP_FIELD.name = "worship_mvps_resp"
var_0_42.WORSHIP_MVPS_RESP_FIELD.full_name = ".sgland.SglWorldMsg.worship_mvps_resp"
var_0_42.WORSHIP_MVPS_RESP_FIELD.number = 640
var_0_42.WORSHIP_MVPS_RESP_FIELD.index = 86
var_0_42.WORSHIP_MVPS_RESP_FIELD.label = 3
var_0_42.WORSHIP_MVPS_RESP_FIELD.has_default_value = false
var_0_42.WORSHIP_MVPS_RESP_FIELD.default_value = {}
var_0_42.WORSHIP_MVPS_RESP_FIELD.message_type = WORSHIPMVP
var_0_42.WORSHIP_MVPS_RESP_FIELD.type = 11
var_0_42.WORSHIP_MVPS_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_LOTTERY_EX_RESP_FIELD.name = "world_lottery_ex_resp"
var_0_42.WORLD_LOTTERY_EX_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_lottery_ex_resp"
var_0_42.WORLD_LOTTERY_EX_RESP_FIELD.number = 641
var_0_42.WORLD_LOTTERY_EX_RESP_FIELD.index = 87
var_0_42.WORLD_LOTTERY_EX_RESP_FIELD.label = 3
var_0_42.WORLD_LOTTERY_EX_RESP_FIELD.has_default_value = false
var_0_42.WORLD_LOTTERY_EX_RESP_FIELD.default_value = {}
var_0_42.WORLD_LOTTERY_EX_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_42.WORLD_LOTTERY_EX_RESP_FIELD.type = 11
var_0_42.WORLD_LOTTERY_EX_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_ROLL_CHAR_RESP_FIELD.name = "world_roll_char_resp"
var_0_42.WORLD_ROLL_CHAR_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_roll_char_resp"
var_0_42.WORLD_ROLL_CHAR_RESP_FIELD.number = 642
var_0_42.WORLD_ROLL_CHAR_RESP_FIELD.index = 88
var_0_42.WORLD_ROLL_CHAR_RESP_FIELD.label = 3
var_0_42.WORLD_ROLL_CHAR_RESP_FIELD.has_default_value = false
var_0_42.WORLD_ROLL_CHAR_RESP_FIELD.default_value = {}
var_0_42.WORLD_ROLL_CHAR_RESP_FIELD.type = 5
var_0_42.WORLD_ROLL_CHAR_RESP_FIELD.cpp_type = 1
var_0_42.ENVELOPE_DELAY_RESP_FIELD.name = "envelope_delay_resp"
var_0_42.ENVELOPE_DELAY_RESP_FIELD.full_name = ".sgland.SglWorldMsg.envelope_delay_resp"
var_0_42.ENVELOPE_DELAY_RESP_FIELD.number = 643
var_0_42.ENVELOPE_DELAY_RESP_FIELD.index = 89
var_0_42.ENVELOPE_DELAY_RESP_FIELD.label = 1
var_0_42.ENVELOPE_DELAY_RESP_FIELD.has_default_value = false
var_0_42.ENVELOPE_DELAY_RESP_FIELD.default_value = 0
var_0_42.ENVELOPE_DELAY_RESP_FIELD.type = 3
var_0_42.ENVELOPE_DELAY_RESP_FIELD.cpp_type = 2
var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD.name = "world_survival_ex_hall_info_resp"
var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_ex_hall_info_resp"
var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD.number = 644
var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD.index = 90
var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD.message_type = var_0_2.SURVIVALEXHALLINFO
var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD.name = "world_survival_ex_explore_resp"
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_ex_explore_resp"
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD.number = 645
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD.index = 91
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD.message_type = SURVIVALEXEXPLOREENDRESP
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD.name = "world_survival_ex_end_resp"
var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_survival_ex_end_resp"
var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD.number = 646
var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD.index = 92
var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD.label = 1
var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD.has_default_value = false
var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD.default_value = nil
var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD.message_type = SURVIVALEXENDRESP
var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD.type = 11
var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD.cpp_type = 10
var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD.name = "world_quit_legend_resp"
var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD.full_name = ".sgland.SglWorldMsg.world_quit_legend_resp"
var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD.number = 647
var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD.index = 93
var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD.label = 3
var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD.has_default_value = false
var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD.default_value = {}
var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD.type = 11
var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD.cpp_type = 10
SGLWORLDMSG.name = "SglWorldMsg"
SGLWORLDMSG.full_name = ".sgland.SglWorldMsg"
SGLWORLDMSG.nested_types = {}
SGLWORLDMSG.enum_types = {}
SGLWORLDMSG.fields = {}
SGLWORLDMSG.is_extendable = false
SGLWORLDMSG.extensions = {
	var_0_42.WORLD_ATTACK_REQ_FIELD,
	var_0_42.WORLD_CHALLENGE_REQ_FIELD,
	var_0_42.WORLD_SWEEP_REQ_FIELD,
	var_0_42.WORLD_SCOUT_REQ_FIELD,
	var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD,
	var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD,
	var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD,
	var_0_42.WORLD_FIND_START_REQ_FIELD,
	var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD,
	var_0_42.WORLD_ROB_EXP_REQ_FIELD,
	var_0_42.WORLD_SWEEP_COPY_REQ_FIELD,
	var_0_42.WORLD_SOS_REQ_FIELD,
	var_0_42.WORLD_RESCUE_REQ_FIELD,
	var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD,
	var_0_42.WORLD_FIND_EX_REQ_FIELD,
	var_0_42.WORLD_FIND_SERVER_REQ_FIELD,
	var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD,
	var_0_42.WORLD_PROXY_REQ_FIELD,
	var_0_42.WORLD_INFO_REQ_FIELD,
	var_0_42.WORLD_TIME_REQ_FIELD,
	var_0_42.WORLD_ROB_GOLD_REQ_FIELD,
	var_0_42.WORLD_EXPEDITION_REQ_FIELD,
	var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD,
	var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD,
	var_0_42.WORLD_BUY_TICKET_REQ_FIELD,
	var_0_42.WORLD_SELECT_CHAR_REQ_FIELD,
	var_0_42.WORLD_SELECT_CARD_REQ_FIELD,
	var_0_42.WORLD_LOTTERY_COUNT_FIELD,
	var_0_42.WORLD_CREATE_MATCH_REQ_FIELD,
	var_0_42.WORLD_QUERY_MATCH_REQ_FIELD,
	var_0_42.WORLD_JOIN_MATCH_REQ_FIELD,
	var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD,
	var_0_42.SYNC_TEAM_INFO_REQ_FIELD,
	var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD,
	var_0_42.RECOMMEND_CARD_REQ_FIELD,
	var_0_42.WORLD_MATCH_TYPE_REQ_FIELD,
	var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD,
	var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD,
	var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD,
	var_0_42.WORSHIP_REQ_FIELD,
	var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD,
	var_0_42.CHARGE_RMB_FIELD,
	var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD,
	var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD,
	var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD,
	var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD,
	var_0_42.WORLD_ATTACK_RESP_FIELD,
	var_0_42.WORLD_FIND_RESP_FIELD,
	var_0_42.WORLD_CHALLENGE_RESP_FIELD,
	var_0_42.WORLD_SWEEP_RESP_FIELD,
	var_0_42.WORLD_SCOUT_RESP_FIELD,
	var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD,
	var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD,
	var_0_42.WORLD_EXPEDITION_RESP_FIELD,
	var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD,
	var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD,
	var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD,
	var_0_42.WORLD_FIND_START_RESP_FIELD,
	var_0_42.WORLD_BATTLE_START_RESP_FIELD,
	var_0_42.WORLD_BATTLE_END_RESP_FIELD,
	var_0_42.WORLD_ROB_GOLD_RESP_FIELD,
	var_0_42.WORLD_ROB_EXP_RESP_FIELD,
	var_0_42.WORLD_RESCUE_RESP_FIELD,
	var_0_42.WORLD_RESCUE_END_RESP_FIELD,
	var_0_42.WORLD_FOCUS_RESP_FIELD,
	var_0_42.WORLD_FIND_EX_RESP_FIELD,
	var_0_42.WORLD_GET_OPPONENT_RESP_FIELD,
	var_0_42.WORLD_RESET_TROOP_RESP_FIELD,
	var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD,
	var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD,
	var_0_42.WORLD_LOTTERY_RESP_FIELD,
	var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD,
	var_0_42.WORLD_SELECT_CHAR_RESP_FIELD,
	var_0_42.WORLD_QUIT_RESP_FIELD,
	var_0_42.WORLD_BUY_TICKET_RESP_FIELD,
	var_0_42.WORLD_SELECT_CARD_RESP_FIELD,
	var_0_42.WORLD_GET_MATCH_RESP_FIELD,
	var_0_42.WORLD_MATCH_INFO_RESP_FIELD,
	var_0_42.WORLD_USER_ID_RESP_FIELD,
	var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD,
	var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD,
	var_0_42.RECOMMEND_TROOP_RESP_FIELD,
	var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD,
	var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD,
	var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD,
	var_0_42.WORLD_SURVIVAL_END_RESP_FIELD,
	var_0_42.WORSHIP_MVPS_RESP_FIELD,
	var_0_42.WORLD_LOTTERY_EX_RESP_FIELD,
	var_0_42.WORLD_ROLL_CHAR_RESP_FIELD,
	var_0_42.ENVELOPE_DELAY_RESP_FIELD,
	var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD,
	var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD,
	var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD,
	var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD
}
DDRecheatResult = var_0_0.Message(DDRECHEATRESULT)
DarkDuelDashBoard = var_0_0.Message(DARKDUELDASHBOARD)
LotteryOpenList = var_0_0.Message(LOTTERYOPENLIST)
LotteryUnopenList = var_0_0.Message(LOTTERYUNOPENLIST)
RecommendCardReq = var_0_0.Message(RECOMMENDCARDREQ)
SglWorldMsg = var_0_0.Message(SGLWORLDMSG)
SurvivalEndResp = var_0_0.Message(SURVIVALENDRESP)
SurvivalExEndResp = var_0_0.Message(SURVIVALEXENDRESP)
SurvivalExEquipSkillReq = var_0_0.Message(SURVIVALEXEQUIPSKILLREQ)
SurvivalExExploreEndResp = var_0_0.Message(SURVIVALEXEXPLOREENDRESP)
SurvivalExExploreStartReq = var_0_0.Message(SURVIVALEXEXPLORESTARTREQ)
SurvivalExploreEndResp = var_0_0.Message(SURVIVALEXPLOREENDRESP)
SurvivalExploreStartReq = var_0_0.Message(SURVIVALEXPLORESTARTREQ)
WorldAttackReq = var_0_0.Message(WORLDATTACKREQ)
WorldBattleJoinReq = var_0_0.Message(WORLDBATTLEJOINREQ)
WorldBattleResult = var_0_0.Message(WORLDBATTLERESULT)
WorldBattleStartResp = var_0_0.Message(WORLDBATTLESTARTRESP)
WorldChallengeCopyReq = var_0_0.Message(WORLDCHALLENGECOPYREQ)
WorldChallengeReq = var_0_0.Message(WORLDCHALLENGEREQ)
WorldCity = var_0_0.Message(WORLDCITY)
WorldExpeditionExReq = var_0_0.Message(WORLDEXPEDITIONEXREQ)
WorldFindExReq = var_0_0.Message(WORLDFINDEXREQ)
WorldFindExResp = var_0_0.Message(WORLDFINDEXRESP)
WorldFindReq = var_0_0.Message(WORLDFINDREQ)
WorldFindResp = var_0_0.Message(WORLDFINDRESP)
WorldFindStartReq = var_0_0.Message(WORLDFINDSTARTREQ)
WorldFocusResp = var_0_0.Message(WORLDFOCUSRESP)
WorldGetExpeditionResp = var_0_0.Message(WORLDGETEXPEDITIONRESP)
WorldGetOpponentResp = var_0_0.Message(WORLDGETOPPONENTRESP)
WorldMatchJoinReq = var_0_0.Message(WORLDMATCHJOINREQ)
WorldRescueReq = var_0_0.Message(WORLDRESCUEREQ)
WorldRobGoldReq = var_0_0.Message(WORLDROBGOLDREQ)
WorldSOSReq = var_0_0.Message(WORLDSOSREQ)
WorldSurvivalExHallJoinReq = var_0_0.Message(WORLDSURVIVALEXHALLJOINREQ)
WorldSurvivalHallJoinReq = var_0_0.Message(WORLDSURVIVALHALLJOINREQ)
WorldSweepCopyReq = var_0_0.Message(WORLDSWEEPCOPYREQ)
WorldSweepResp = var_0_0.Message(WORLDSWEEPRESP)
WorldSweepResult = var_0_0.Message(WORLDSWEEPRESULT)
WorshipMVP = var_0_0.Message(WORSHIPMVP)

var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_ATTACK_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_CHALLENGE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SWEEP_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SCOUT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_RESET_SWEEP_COUNT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_CHALLENGE_COMMANDER_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_CHALLENGE_ELITE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_FIND_START_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_BATTLE_JOIN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_ROB_EXP_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SWEEP_COPY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SOS_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_RESCUE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_RESCUE_JOIN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_FIND_EX_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_FIND_SERVER_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_BATTLE_JOIN_SERVER_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_PROXY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_INFO_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_TIME_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_ROB_GOLD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_EXPEDITION_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_EXPEDITION_EX_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_LOTTERY_USER_TOKEN_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_BUY_TICKET_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SELECT_CHAR_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SELECT_CARD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_LOTTERY_COUNT_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_CREATE_MATCH_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_QUERY_MATCH_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_JOIN_MATCH_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_RECYCLE_MATCH_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.SYNC_TEAM_INFO_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.SYNC_LEGEND_LOTTERY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.RECOMMEND_CARD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_MATCH_TYPE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.CARD_SELECT_DARK_TROOP_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_EXPLORE_START_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_HALL_JOIN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORSHIP_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_LOTTERY_EX_COUNT_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.CHARGE_RMB_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_EX_EXPLORE_START_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_EX_HALL_JOIN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_EX_EQUIP_SKILL_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_42.WORLD_BUY_LEGEND_TICKET_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_ATTACK_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_FIND_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_CHALLENGE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_SWEEP_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_SCOUT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_CHALLENGE_ELITE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_CHALLENGE_COMMANDER_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_EXPEDITION_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_REFRESH_EXPEDITION_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_GET_EXPEDITION_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_EXPEDITION_OPEN_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_FIND_START_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_BATTLE_START_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_BATTLE_END_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_ROB_GOLD_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_ROB_EXP_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_RESCUE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_RESCUE_END_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_FOCUS_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_FIND_EX_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_GET_OPPONENT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_RESET_TROOP_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_OPPONENT_NOT_FOUND_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_EXPEDITION_EX_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_LOTTERY_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_GET_EXPEDITION_EX_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_SELECT_CHAR_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_QUIT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_BUY_TICKET_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_SELECT_CARD_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_GET_MATCH_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_MATCH_INFO_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_USER_ID_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.LOTTERY_UNOPEN_LIST_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.LOTTERY_OPEN_LIST_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.RECOMMEND_TROOP_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.DARK_DUEL_DASH_BOARD_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_HALL_INFO_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_EXPLORE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_END_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORSHIP_MVPS_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_LOTTERY_EX_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_ROLL_CHAR_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.ENVELOPE_DELAY_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_EX_HALL_INFO_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_EX_EXPLORE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_SURVIVAL_EX_END_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_42.WORLD_QUIT_LEGEND_RESP_FIELD)
