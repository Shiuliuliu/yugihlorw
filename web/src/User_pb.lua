local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("User_pb")

FULLUSERINFO = var_0_0.Descriptor()

local var_0_3 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor(),
	GOLD_FIELD = var_0_0.FieldDescriptor(),
	GRAIN_FIELD = var_0_0.FieldDescriptor(),
	INGOT_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor(),
	EXP_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor(),
	VIP_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FIELD = var_0_0.FieldDescriptor(),
	GUIDE_FIELD = var_0_0.FieldDescriptor(),
	SHIELD_FIELD = var_0_0.FieldDescriptor(),
	UNION_ID_FIELD = var_0_0.FieldDescriptor(),
	UNION_NAME_FIELD = var_0_0.FieldDescriptor(),
	UNION_AVATAR_FIELD = var_0_0.FieldDescriptor(),
	UNION_TAG_FIELD = var_0_0.FieldDescriptor(),
	UNION_TITLE_FIELD = var_0_0.FieldDescriptor(),
	LAST_LOGIN_FIELD = var_0_0.FieldDescriptor(),
	VIP_EXP_FIELD = var_0_0.FieldDescriptor(),
	DEF_TROOP_FIELD = var_0_0.FieldDescriptor(),
	CARD_BACK_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FRAME_FIELD = var_0_0.FieldDescriptor(),
	REG_DATE_FIELD = var_0_0.FieldDescriptor(),
	CONFIG_FIELD = var_0_0.FieldDescriptor(),
	PRIVILEGE_FIELD = var_0_0.FieldDescriptor(),
	CODE_FIELD = var_0_0.FieldDescriptor(),
	RID_FIELD = var_0_0.FieldDescriptor(),
	GUIDE1_FIELD = var_0_0.FieldDescriptor(),
	GUIDE2_FIELD = var_0_0.FieldDescriptor(),
	CROWN_FIELD = var_0_0.FieldDescriptor(),
	ACHIEVEMENT_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FRAME_COUNT_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_CROWN_FIELD = var_0_0.FieldDescriptor()
}

USERBATTLE = var_0_0.Descriptor()

local var_0_4 = {
	TOTAL_ATK_WIN_FIELD = var_0_0.FieldDescriptor(),
	TOTAL_ATK_LOSE_FIELD = var_0_0.FieldDescriptor(),
	TOTAL_DEF_WIN_FIELD = var_0_0.FieldDescriptor(),
	TOTAL_DEF_LOSE_FIELD = var_0_0.FieldDescriptor(),
	TOTAL_PVP_WIN_FIELD = var_0_0.FieldDescriptor(),
	TOTAL_PVP_LOSE_FIELD = var_0_0.FieldDescriptor(),
	PERIOD_ATK_WIN_FIELD = var_0_0.FieldDescriptor(),
	PERIOD_ATK_LOSE_FIELD = var_0_0.FieldDescriptor(),
	PERIOD_DEF_WIN_FIELD = var_0_0.FieldDescriptor(),
	PERIOD_DEF_LOSE_FIELD = var_0_0.FieldDescriptor(),
	DAILY_PVP_WIN_FIELD = var_0_0.FieldDescriptor(),
	DAILY_PVP_LOSE_FIELD = var_0_0.FieldDescriptor(),
	BOSS_SCORE_FIELD = var_0_0.FieldDescriptor(),
	DAILY_LADDER_WIN_FIELD = var_0_0.FieldDescriptor(),
	DAILY_LADDER_LOSE_FIELD = var_0_0.FieldDescriptor(),
	LADDER_CONT_WIN_FIELD = var_0_0.FieldDescriptor(),
	LADDER_CONT_LOSE_FIELD = var_0_0.FieldDescriptor()
}

USERLOTTERY = var_0_0.Descriptor()

local var_0_5 = {
	NEXT_FREE_FIELD = var_0_0.FieldDescriptor(),
	NEXT_QUALITY_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor(),
	NCHEST_FIELD = var_0_0.FieldDescriptor(),
	NCHEST_EX_FIELD = var_0_0.FieldDescriptor(),
	POINT_FIELD = var_0_0.FieldDescriptor()
}

USERCOUNT = var_0_0.Descriptor()

local var_0_6 = {
	BUY_GOLD_FIELD = var_0_0.FieldDescriptor(),
	BUY_GRAIN_FIELD = var_0_0.FieldDescriptor(),
	BUY_REFRESH_FIELD = var_0_0.FieldDescriptor(),
	BUY_CHEST1_FIELD = var_0_0.FieldDescriptor(),
	BUY_CHEST2_FIELD = var_0_0.FieldDescriptor(),
	BUY_CHEST3_FIELD = var_0_0.FieldDescriptor(),
	BUY_CHEST4_FIELD = var_0_0.FieldDescriptor(),
	BUY_HERO_EXP_FIELD = var_0_0.FieldDescriptor(),
	BUY_EQUIP_EXP_FIELD = var_0_0.FieldDescriptor(),
	BUY_HORSE_EXP_FIELD = var_0_0.FieldDescriptor(),
	BUY_BOOK_EXP_FIELD = var_0_0.FieldDescriptor(),
	BUY_COMMANDER_FIELD = var_0_0.FieldDescriptor(),
	BUY_ELITE_FIELD = var_0_0.FieldDescriptor(),
	BUY_EXPEDITION_FIELD = var_0_0.FieldDescriptor(),
	BUY_ROB_GOLD_FIELD = var_0_0.FieldDescriptor(),
	EDIT_NAME_FIELD = var_0_0.FieldDescriptor(),
	NEXT_SHARE_FIELD = var_0_0.FieldDescriptor(),
	CHALLENGE_COMMANDER_FIELD = var_0_0.FieldDescriptor(),
	CHALLENGE_ELITE_FIELD = var_0_0.FieldDescriptor(),
	EXPEDITION_FIELD = var_0_0.FieldDescriptor(),
	ROB_GOLD_FIELD = var_0_0.FieldDescriptor(),
	NEXT_CHAT_FIELD = var_0_0.FieldDescriptor(),
	SEND_MAIL_FIELD = var_0_0.FieldDescriptor(),
	MONTH_CARD_FIELD = var_0_0.FieldDescriptor(),
	COLLECT_GOLD_FIELD = var_0_0.FieldDescriptor(),
	CHARGE_FIELD = var_0_0.FieldDescriptor(),
	NEXT_SPAWN_FIELD = var_0_0.FieldDescriptor(),
	NEXT_SOS_FIELD = var_0_0.FieldDescriptor(),
	DONATE_FIELD = var_0_0.FieldDescriptor(),
	BUY_REMEDY_FIELD = var_0_0.FieldDescriptor(),
	BUY_STONE_FIELD = var_0_0.FieldDescriptor(),
	BUY_ROB_EXP_FIELD = var_0_0.FieldDescriptor(),
	ROB_EXP_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor(),
	DAILY_CHARGE_FIELD = var_0_0.FieldDescriptor(),
	WIN_ROB_GOLD_FIELD = var_0_0.FieldDescriptor(),
	WORSHIP_FIELD = var_0_0.FieldDescriptor(),
	BUY_REFRESH_PVP_FIELD = var_0_0.FieldDescriptor(),
	BUY_REFRESH_UNION_FIELD = var_0_0.FieldDescriptor(),
	ATK_BOSS_FIELD = var_0_0.FieldDescriptor(),
	BUY_ATK_BOSS_FIELD = var_0_0.FieldDescriptor(),
	RE_CHECK_FIELD = var_0_0.FieldDescriptor(),
	MONTH_CARD_EX_FIELD = var_0_0.FieldDescriptor(),
	NEXT_FIND_FIELD = var_0_0.FieldDescriptor(),
	BUY_REFRESH_FIND_FIELD = var_0_0.FieldDescriptor(),
	GRACE_FIELD = var_0_0.FieldDescriptor(),
	ATK_UBOSS_FIELD = var_0_0.FieldDescriptor(),
	WELFARE_FIELD = var_0_0.FieldDescriptor(),
	BUY_REFRESH_LADDER_FIELD = var_0_0.FieldDescriptor(),
	ATK_PLAYER_FIELD = var_0_0.FieldDescriptor(),
	INVITE_CHARGE_FIELD = var_0_0.FieldDescriptor(),
	INVITE_COUNT_FIELD = var_0_0.FieldDescriptor(),
	RESET_LADDER_FIELD = var_0_0.FieldDescriptor(),
	CONSUME_FIELD = var_0_0.FieldDescriptor()
}

USERNOTIFYEVENT = var_0_0.Descriptor()

local var_0_7 = {
	CODE_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	PARAM_FIELD = var_0_0.FieldDescriptor(),
	INFO_FIELD = var_0_0.FieldDescriptor(),
	RENOTFIY_FIELD = var_0_0.FieldDescriptor()
}

USERREGREQ = var_0_0.Descriptor()

local var_0_8 = {
	CHANNEL_FIELD = var_0_0.FieldDescriptor(),
	RID_FIELD = var_0_0.FieldDescriptor(),
	UID_FIELD = var_0_0.FieldDescriptor(),
	VERSION_FIELD = var_0_0.FieldDescriptor(),
	CID_FIELD = var_0_0.FieldDescriptor(),
	DEVICE_INFO_FIELD = var_0_0.FieldDescriptor(),
	BINARY_VERSION_FIELD = var_0_0.FieldDescriptor(),
	IDFA_FIELD = var_0_0.FieldDescriptor(),
	APPID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

USEROPPOVIPREQ = var_0_0.Descriptor()

local var_0_9 = {
	SUB_CHANNEL_FIELD = var_0_0.FieldDescriptor(),
	CHANNEL_UID_FIELD = var_0_0.FieldDescriptor()
}

USERLOGINREQ = var_0_0.Descriptor()

local var_0_10 = {
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	VERSION_FIELD = var_0_0.FieldDescriptor(),
	CID_FIELD = var_0_0.FieldDescriptor(),
	DEVICE_INFO_FIELD = var_0_0.FieldDescriptor(),
	BINARY_VERSION_FIELD = var_0_0.FieldDescriptor(),
	CODE_FIELD = var_0_0.FieldDescriptor()
}

USEROPENCHESTREQ = var_0_0.Descriptor()

local var_0_11 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	NUM_FIELD = var_0_0.FieldDescriptor()
}

USERUNLOCKCHARACTERREQ = var_0_0.Descriptor()

local var_0_12 = {
	CHAR_ID_FIELD = var_0_0.FieldDescriptor(),
	USE_INGOT_FIELD = var_0_0.FieldDescriptor()
}

USERSETSKINREQ = var_0_0.Descriptor()

local var_0_13 = {
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	SKIN_ID_FIELD = var_0_0.FieldDescriptor()
}

USERINRESP = var_0_0.Descriptor()

local var_0_14 = {
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	CARD_FIELD = var_0_0.FieldDescriptor(),
	ATTACH_FIELD = var_0_0.FieldDescriptor(),
	CITY_FIELD = var_0_0.FieldDescriptor(),
	WORLD_FIELD = var_0_0.FieldDescriptor(),
	USER_BATTLE_FIELD = var_0_0.FieldDescriptor(),
	USER_LOTTERY_FIELD = var_0_0.FieldDescriptor(),
	USER_COUNT_FIELD = var_0_0.FieldDescriptor(),
	ANNOUNCEMENT_FIELD = var_0_0.FieldDescriptor(),
	TIME_OFFSET_FIELD = var_0_0.FieldDescriptor(),
	TIME_OF_ANN_FIELD = var_0_0.FieldDescriptor(),
	IS_IN_BATTLE_FIELD = var_0_0.FieldDescriptor(),
	UNION_FIELD = var_0_0.FieldDescriptor(),
	OPEN_TIME_FIELD = var_0_0.FieldDescriptor(),
	BAN_CHAT_FIELD = var_0_0.FieldDescriptor(),
	CAN_BIND_FIELD = var_0_0.FieldDescriptor(),
	FUNCTION_SWITCH_FIELD = var_0_0.FieldDescriptor(),
	IS_IN_MATCH_FIELD = var_0_0.FieldDescriptor(),
	TEAM_MEMBER_UPLIMIT_FIELD = var_0_0.FieldDescriptor(),
	IS_IN_HALL_FIELD = var_0_0.FieldDescriptor(),
	SERVER_OPEN_TIME_FIELD = var_0_0.FieldDescriptor(),
	SERVER_VERSION_FIELD = var_0_0.FieldDescriptor()
}

USERVISITRESP = var_0_0.Descriptor()

local var_0_15 = {
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor(),
	POWER_FIELD = var_0_0.FieldDescriptor()
}

USERVISITEXRESP = var_0_0.Descriptor()

local var_0_16 = {
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	PRE_RANK_FIELD = var_0_0.FieldDescriptor(),
	BEST_RANK_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_TROPHY_FIELD = var_0_0.FieldDescriptor(),
	PRE_LEGEND_RANK_FIELD = var_0_0.FieldDescriptor(),
	BEST_LEGEND_RANK_FIELD = var_0_0.FieldDescriptor()
}

USERSPAWNGOLDRESP = var_0_0.Descriptor()

local var_0_17 = {
	GOLD_FIELD = var_0_0.FieldDescriptor(),
	NEXT_SPAWN_FIELD = var_0_0.FieldDescriptor()
}

USERCOLLECTGOLDRESP = var_0_0.Descriptor()

local var_0_18 = {
	GOLD_FIELD = var_0_0.FieldDescriptor(),
	CREDIT_FIELD = var_0_0.FieldDescriptor()
}

USERVOTEREQ = var_0_0.Descriptor()

local var_0_19 = {
	STAGE_FIELD = var_0_0.FieldDescriptor(),
	VOTE_FIELD = var_0_0.FieldDescriptor()
}

SGLUSERMSG = var_0_0.Descriptor()

local var_0_20 = {
	USER_REG_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_LOGIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_VISIT_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_SET_GUIDE_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_SET_NAME_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_SET_AVATAR_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_OPEN_CHEST_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_SET_TROOP_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_FINISH_TRAIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_CLAIM_GIFT_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_SET_EVENT_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_GCID_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_SET_CARD_BACK_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_SET_AVATAR_FRAME_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_APPLY_VIP_CARD_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_SET_CONFIG_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_TECH_UPGRADE_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_BAN_CHAT_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_GIVE_FUND_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_BIND_INVITE_CODE_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_CHECK_INVITE_CODE_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_NOTITY_EVENT_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_FACEBOOK_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_CANCEL_BAN_CHAT_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_SET_CHARACTER_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_UNLOCK_CHARACTER_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_SET_SKIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_OPPO_VIP_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_COMMAND_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_VOTE_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_VOTE_RECORD_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_BREAK_OUT_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_DYNAMIC_TIMEOUT_REQ_FIELD = var_0_0.FieldDescriptor(),
	USER_IN_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_VISIT_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_OPEN_CHEST_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_UNDER_ATTACK_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_SPAWN_GOLD_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_CLAIM_GIFT_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_QUERY_GCID_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_BAN_LOGIN_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_ADMIN_LIST_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_BAN_CHAT_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_ILLEGAL_INPUT_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_VISIT_EX_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_GET_INVITE_CODE_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_CHECK_INVITE_CODE_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_NOTIFY_EVENT_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_CANCEL_BAN_CHAT_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_COLLECT_GOLD_RESP_FIELD = var_0_0.FieldDescriptor(),
	INIT_CARDS_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_OPPO_VIP_RESP_FIELD = var_0_0.FieldDescriptor(),
	USER_COMMAND_RESP_FIELD = var_0_0.FieldDescriptor(),
	VOTE_RECORD_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.ID_FIELD.name = "id"
var_0_3.ID_FIELD.full_name = ".sgland.FullUserInfo.id"
var_0_3.ID_FIELD.number = 1
var_0_3.ID_FIELD.index = 0
var_0_3.ID_FIELD.label = 2
var_0_3.ID_FIELD.has_default_value = false
var_0_3.ID_FIELD.default_value = 0
var_0_3.ID_FIELD.type = 3
var_0_3.ID_FIELD.cpp_type = 2
var_0_3.NAME_FIELD.name = "name"
var_0_3.NAME_FIELD.full_name = ".sgland.FullUserInfo.name"
var_0_3.NAME_FIELD.number = 2
var_0_3.NAME_FIELD.index = 1
var_0_3.NAME_FIELD.label = 2
var_0_3.NAME_FIELD.has_default_value = false
var_0_3.NAME_FIELD.default_value = ""
var_0_3.NAME_FIELD.type = 9
var_0_3.NAME_FIELD.cpp_type = 9
var_0_3.GOLD_FIELD.name = "gold"
var_0_3.GOLD_FIELD.full_name = ".sgland.FullUserInfo.gold"
var_0_3.GOLD_FIELD.number = 3
var_0_3.GOLD_FIELD.index = 2
var_0_3.GOLD_FIELD.label = 2
var_0_3.GOLD_FIELD.has_default_value = false
var_0_3.GOLD_FIELD.default_value = 0
var_0_3.GOLD_FIELD.type = 5
var_0_3.GOLD_FIELD.cpp_type = 1
var_0_3.GRAIN_FIELD.name = "grain"
var_0_3.GRAIN_FIELD.full_name = ".sgland.FullUserInfo.grain"
var_0_3.GRAIN_FIELD.number = 4
var_0_3.GRAIN_FIELD.index = 3
var_0_3.GRAIN_FIELD.label = 2
var_0_3.GRAIN_FIELD.has_default_value = false
var_0_3.GRAIN_FIELD.default_value = 0
var_0_3.GRAIN_FIELD.type = 5
var_0_3.GRAIN_FIELD.cpp_type = 1
var_0_3.INGOT_FIELD.name = "ingot"
var_0_3.INGOT_FIELD.full_name = ".sgland.FullUserInfo.ingot"
var_0_3.INGOT_FIELD.number = 5
var_0_3.INGOT_FIELD.index = 4
var_0_3.INGOT_FIELD.label = 2
var_0_3.INGOT_FIELD.has_default_value = false
var_0_3.INGOT_FIELD.default_value = 0
var_0_3.INGOT_FIELD.type = 5
var_0_3.INGOT_FIELD.cpp_type = 1
var_0_3.LEVEL_FIELD.name = "level"
var_0_3.LEVEL_FIELD.full_name = ".sgland.FullUserInfo.level"
var_0_3.LEVEL_FIELD.number = 6
var_0_3.LEVEL_FIELD.index = 5
var_0_3.LEVEL_FIELD.label = 2
var_0_3.LEVEL_FIELD.has_default_value = false
var_0_3.LEVEL_FIELD.default_value = 0
var_0_3.LEVEL_FIELD.type = 5
var_0_3.LEVEL_FIELD.cpp_type = 1
var_0_3.EXP_FIELD.name = "exp"
var_0_3.EXP_FIELD.full_name = ".sgland.FullUserInfo.exp"
var_0_3.EXP_FIELD.number = 7
var_0_3.EXP_FIELD.index = 6
var_0_3.EXP_FIELD.label = 2
var_0_3.EXP_FIELD.has_default_value = false
var_0_3.EXP_FIELD.default_value = 0
var_0_3.EXP_FIELD.type = 5
var_0_3.EXP_FIELD.cpp_type = 1
var_0_3.TROPHY_FIELD.name = "trophy"
var_0_3.TROPHY_FIELD.full_name = ".sgland.FullUserInfo.trophy"
var_0_3.TROPHY_FIELD.number = 8
var_0_3.TROPHY_FIELD.index = 7
var_0_3.TROPHY_FIELD.label = 2
var_0_3.TROPHY_FIELD.has_default_value = false
var_0_3.TROPHY_FIELD.default_value = 0
var_0_3.TROPHY_FIELD.type = 5
var_0_3.TROPHY_FIELD.cpp_type = 1
var_0_3.VIP_FIELD.name = "vip"
var_0_3.VIP_FIELD.full_name = ".sgland.FullUserInfo.vip"
var_0_3.VIP_FIELD.number = 9
var_0_3.VIP_FIELD.index = 8
var_0_3.VIP_FIELD.label = 2
var_0_3.VIP_FIELD.has_default_value = false
var_0_3.VIP_FIELD.default_value = 0
var_0_3.VIP_FIELD.type = 5
var_0_3.VIP_FIELD.cpp_type = 1
var_0_3.AVATAR_FIELD.name = "avatar"
var_0_3.AVATAR_FIELD.full_name = ".sgland.FullUserInfo.avatar"
var_0_3.AVATAR_FIELD.number = 10
var_0_3.AVATAR_FIELD.index = 9
var_0_3.AVATAR_FIELD.label = 2
var_0_3.AVATAR_FIELD.has_default_value = false
var_0_3.AVATAR_FIELD.default_value = 0
var_0_3.AVATAR_FIELD.type = 5
var_0_3.AVATAR_FIELD.cpp_type = 1
var_0_3.GUIDE_FIELD.name = "guide"
var_0_3.GUIDE_FIELD.full_name = ".sgland.FullUserInfo.guide"
var_0_3.GUIDE_FIELD.number = 11
var_0_3.GUIDE_FIELD.index = 10
var_0_3.GUIDE_FIELD.label = 2
var_0_3.GUIDE_FIELD.has_default_value = false
var_0_3.GUIDE_FIELD.default_value = 0
var_0_3.GUIDE_FIELD.type = 5
var_0_3.GUIDE_FIELD.cpp_type = 1
var_0_3.SHIELD_FIELD.name = "shield"
var_0_3.SHIELD_FIELD.full_name = ".sgland.FullUserInfo.shield"
var_0_3.SHIELD_FIELD.number = 12
var_0_3.SHIELD_FIELD.index = 11
var_0_3.SHIELD_FIELD.label = 1
var_0_3.SHIELD_FIELD.has_default_value = false
var_0_3.SHIELD_FIELD.default_value = 0
var_0_3.SHIELD_FIELD.type = 3
var_0_3.SHIELD_FIELD.cpp_type = 2
var_0_3.UNION_ID_FIELD.name = "union_id"
var_0_3.UNION_ID_FIELD.full_name = ".sgland.FullUserInfo.union_id"
var_0_3.UNION_ID_FIELD.number = 13
var_0_3.UNION_ID_FIELD.index = 12
var_0_3.UNION_ID_FIELD.label = 1
var_0_3.UNION_ID_FIELD.has_default_value = false
var_0_3.UNION_ID_FIELD.default_value = 0
var_0_3.UNION_ID_FIELD.type = 3
var_0_3.UNION_ID_FIELD.cpp_type = 2
var_0_3.UNION_NAME_FIELD.name = "union_name"
var_0_3.UNION_NAME_FIELD.full_name = ".sgland.FullUserInfo.union_name"
var_0_3.UNION_NAME_FIELD.number = 14
var_0_3.UNION_NAME_FIELD.index = 13
var_0_3.UNION_NAME_FIELD.label = 1
var_0_3.UNION_NAME_FIELD.has_default_value = false
var_0_3.UNION_NAME_FIELD.default_value = ""
var_0_3.UNION_NAME_FIELD.type = 9
var_0_3.UNION_NAME_FIELD.cpp_type = 9
var_0_3.UNION_AVATAR_FIELD.name = "union_avatar"
var_0_3.UNION_AVATAR_FIELD.full_name = ".sgland.FullUserInfo.union_avatar"
var_0_3.UNION_AVATAR_FIELD.number = 15
var_0_3.UNION_AVATAR_FIELD.index = 14
var_0_3.UNION_AVATAR_FIELD.label = 1
var_0_3.UNION_AVATAR_FIELD.has_default_value = false
var_0_3.UNION_AVATAR_FIELD.default_value = 0
var_0_3.UNION_AVATAR_FIELD.type = 5
var_0_3.UNION_AVATAR_FIELD.cpp_type = 1
var_0_3.UNION_TAG_FIELD.name = "union_tag"
var_0_3.UNION_TAG_FIELD.full_name = ".sgland.FullUserInfo.union_tag"
var_0_3.UNION_TAG_FIELD.number = 16
var_0_3.UNION_TAG_FIELD.index = 15
var_0_3.UNION_TAG_FIELD.label = 1
var_0_3.UNION_TAG_FIELD.has_default_value = false
var_0_3.UNION_TAG_FIELD.default_value = ""
var_0_3.UNION_TAG_FIELD.type = 9
var_0_3.UNION_TAG_FIELD.cpp_type = 9
var_0_3.UNION_TITLE_FIELD.name = "union_title"
var_0_3.UNION_TITLE_FIELD.full_name = ".sgland.FullUserInfo.union_title"
var_0_3.UNION_TITLE_FIELD.number = 17
var_0_3.UNION_TITLE_FIELD.index = 16
var_0_3.UNION_TITLE_FIELD.label = 1
var_0_3.UNION_TITLE_FIELD.has_default_value = false
var_0_3.UNION_TITLE_FIELD.default_value = 0
var_0_3.UNION_TITLE_FIELD.type = 5
var_0_3.UNION_TITLE_FIELD.cpp_type = 1
var_0_3.LAST_LOGIN_FIELD.name = "last_login"
var_0_3.LAST_LOGIN_FIELD.full_name = ".sgland.FullUserInfo.last_login"
var_0_3.LAST_LOGIN_FIELD.number = 18
var_0_3.LAST_LOGIN_FIELD.index = 17
var_0_3.LAST_LOGIN_FIELD.label = 1
var_0_3.LAST_LOGIN_FIELD.has_default_value = false
var_0_3.LAST_LOGIN_FIELD.default_value = 0
var_0_3.LAST_LOGIN_FIELD.type = 3
var_0_3.LAST_LOGIN_FIELD.cpp_type = 2
var_0_3.VIP_EXP_FIELD.name = "vip_exp"
var_0_3.VIP_EXP_FIELD.full_name = ".sgland.FullUserInfo.vip_exp"
var_0_3.VIP_EXP_FIELD.number = 19
var_0_3.VIP_EXP_FIELD.index = 18
var_0_3.VIP_EXP_FIELD.label = 2
var_0_3.VIP_EXP_FIELD.has_default_value = false
var_0_3.VIP_EXP_FIELD.default_value = 0
var_0_3.VIP_EXP_FIELD.type = 5
var_0_3.VIP_EXP_FIELD.cpp_type = 1
var_0_3.DEF_TROOP_FIELD.name = "def_troop"
var_0_3.DEF_TROOP_FIELD.full_name = ".sgland.FullUserInfo.def_troop"
var_0_3.DEF_TROOP_FIELD.number = 20
var_0_3.DEF_TROOP_FIELD.index = 19
var_0_3.DEF_TROOP_FIELD.label = 2
var_0_3.DEF_TROOP_FIELD.has_default_value = false
var_0_3.DEF_TROOP_FIELD.default_value = 0
var_0_3.DEF_TROOP_FIELD.type = 5
var_0_3.DEF_TROOP_FIELD.cpp_type = 1
var_0_3.CARD_BACK_FIELD.name = "card_back"
var_0_3.CARD_BACK_FIELD.full_name = ".sgland.FullUserInfo.card_back"
var_0_3.CARD_BACK_FIELD.number = 21
var_0_3.CARD_BACK_FIELD.index = 20
var_0_3.CARD_BACK_FIELD.label = 1
var_0_3.CARD_BACK_FIELD.has_default_value = false
var_0_3.CARD_BACK_FIELD.default_value = 0
var_0_3.CARD_BACK_FIELD.type = 5
var_0_3.CARD_BACK_FIELD.cpp_type = 1
var_0_3.AVATAR_FRAME_FIELD.name = "avatar_frame"
var_0_3.AVATAR_FRAME_FIELD.full_name = ".sgland.FullUserInfo.avatar_frame"
var_0_3.AVATAR_FRAME_FIELD.number = 22
var_0_3.AVATAR_FRAME_FIELD.index = 21
var_0_3.AVATAR_FRAME_FIELD.label = 1
var_0_3.AVATAR_FRAME_FIELD.has_default_value = false
var_0_3.AVATAR_FRAME_FIELD.default_value = 0
var_0_3.AVATAR_FRAME_FIELD.type = 5
var_0_3.AVATAR_FRAME_FIELD.cpp_type = 1
var_0_3.REG_DATE_FIELD.name = "reg_date"
var_0_3.REG_DATE_FIELD.full_name = ".sgland.FullUserInfo.reg_date"
var_0_3.REG_DATE_FIELD.number = 23
var_0_3.REG_DATE_FIELD.index = 22
var_0_3.REG_DATE_FIELD.label = 2
var_0_3.REG_DATE_FIELD.has_default_value = false
var_0_3.REG_DATE_FIELD.default_value = 0
var_0_3.REG_DATE_FIELD.type = 3
var_0_3.REG_DATE_FIELD.cpp_type = 2
var_0_3.CONFIG_FIELD.name = "config"
var_0_3.CONFIG_FIELD.full_name = ".sgland.FullUserInfo.config"
var_0_3.CONFIG_FIELD.number = 24
var_0_3.CONFIG_FIELD.index = 23
var_0_3.CONFIG_FIELD.label = 2
var_0_3.CONFIG_FIELD.has_default_value = false
var_0_3.CONFIG_FIELD.default_value = 0
var_0_3.CONFIG_FIELD.type = 5
var_0_3.CONFIG_FIELD.cpp_type = 1
var_0_3.PRIVILEGE_FIELD.name = "privilege"
var_0_3.PRIVILEGE_FIELD.full_name = ".sgland.FullUserInfo.privilege"
var_0_3.PRIVILEGE_FIELD.number = 25
var_0_3.PRIVILEGE_FIELD.index = 24
var_0_3.PRIVILEGE_FIELD.label = 1
var_0_3.PRIVILEGE_FIELD.has_default_value = false
var_0_3.PRIVILEGE_FIELD.default_value = 0
var_0_3.PRIVILEGE_FIELD.type = 5
var_0_3.PRIVILEGE_FIELD.cpp_type = 1
var_0_3.CODE_FIELD.name = "code"
var_0_3.CODE_FIELD.full_name = ".sgland.FullUserInfo.code"
var_0_3.CODE_FIELD.number = 26
var_0_3.CODE_FIELD.index = 25
var_0_3.CODE_FIELD.label = 1
var_0_3.CODE_FIELD.has_default_value = false
var_0_3.CODE_FIELD.default_value = ""
var_0_3.CODE_FIELD.type = 9
var_0_3.CODE_FIELD.cpp_type = 9
var_0_3.RID_FIELD.name = "rid"
var_0_3.RID_FIELD.full_name = ".sgland.FullUserInfo.rid"
var_0_3.RID_FIELD.number = 27
var_0_3.RID_FIELD.index = 26
var_0_3.RID_FIELD.label = 1
var_0_3.RID_FIELD.has_default_value = false
var_0_3.RID_FIELD.default_value = 0
var_0_3.RID_FIELD.type = 5
var_0_3.RID_FIELD.cpp_type = 1
var_0_3.GUIDE1_FIELD.name = "guide1"
var_0_3.GUIDE1_FIELD.full_name = ".sgland.FullUserInfo.guide1"
var_0_3.GUIDE1_FIELD.number = 28
var_0_3.GUIDE1_FIELD.index = 27
var_0_3.GUIDE1_FIELD.label = 1
var_0_3.GUIDE1_FIELD.has_default_value = false
var_0_3.GUIDE1_FIELD.default_value = 0
var_0_3.GUIDE1_FIELD.type = 5
var_0_3.GUIDE1_FIELD.cpp_type = 1
var_0_3.GUIDE2_FIELD.name = "guide2"
var_0_3.GUIDE2_FIELD.full_name = ".sgland.FullUserInfo.guide2"
var_0_3.GUIDE2_FIELD.number = 29
var_0_3.GUIDE2_FIELD.index = 28
var_0_3.GUIDE2_FIELD.label = 1
var_0_3.GUIDE2_FIELD.has_default_value = false
var_0_3.GUIDE2_FIELD.default_value = 0
var_0_3.GUIDE2_FIELD.type = 5
var_0_3.GUIDE2_FIELD.cpp_type = 1
var_0_3.CROWN_FIELD.name = "crown"
var_0_3.CROWN_FIELD.full_name = ".sgland.FullUserInfo.crown"
var_0_3.CROWN_FIELD.number = 30
var_0_3.CROWN_FIELD.index = 29
var_0_3.CROWN_FIELD.label = 1
var_0_3.CROWN_FIELD.has_default_value = false
var_0_3.CROWN_FIELD.default_value = nil
var_0_3.CROWN_FIELD.message_type = var_0_2.CROWN
var_0_3.CROWN_FIELD.type = 11
var_0_3.CROWN_FIELD.cpp_type = 10
var_0_3.ACHIEVEMENT_FIELD.name = "achievement"
var_0_3.ACHIEVEMENT_FIELD.full_name = ".sgland.FullUserInfo.achievement"
var_0_3.ACHIEVEMENT_FIELD.number = 31
var_0_3.ACHIEVEMENT_FIELD.index = 30
var_0_3.ACHIEVEMENT_FIELD.label = 1
var_0_3.ACHIEVEMENT_FIELD.has_default_value = false
var_0_3.ACHIEVEMENT_FIELD.default_value = 0
var_0_3.ACHIEVEMENT_FIELD.type = 5
var_0_3.ACHIEVEMENT_FIELD.cpp_type = 1
var_0_3.AVATAR_FRAME_COUNT_FIELD.name = "avatar_frame_count"
var_0_3.AVATAR_FRAME_COUNT_FIELD.full_name = ".sgland.FullUserInfo.avatar_frame_count"
var_0_3.AVATAR_FRAME_COUNT_FIELD.number = 32
var_0_3.AVATAR_FRAME_COUNT_FIELD.index = 31
var_0_3.AVATAR_FRAME_COUNT_FIELD.label = 1
var_0_3.AVATAR_FRAME_COUNT_FIELD.has_default_value = false
var_0_3.AVATAR_FRAME_COUNT_FIELD.default_value = 0
var_0_3.AVATAR_FRAME_COUNT_FIELD.type = 5
var_0_3.AVATAR_FRAME_COUNT_FIELD.cpp_type = 1
var_0_3.LEGEND_CROWN_FIELD.name = "legend_crown"
var_0_3.LEGEND_CROWN_FIELD.full_name = ".sgland.FullUserInfo.legend_crown"
var_0_3.LEGEND_CROWN_FIELD.number = 33
var_0_3.LEGEND_CROWN_FIELD.index = 32
var_0_3.LEGEND_CROWN_FIELD.label = 1
var_0_3.LEGEND_CROWN_FIELD.has_default_value = false
var_0_3.LEGEND_CROWN_FIELD.default_value = nil
var_0_3.LEGEND_CROWN_FIELD.message_type = var_0_2.CROWN
var_0_3.LEGEND_CROWN_FIELD.type = 11
var_0_3.LEGEND_CROWN_FIELD.cpp_type = 10
FULLUSERINFO.name = "FullUserInfo"
FULLUSERINFO.full_name = ".sgland.FullUserInfo"
FULLUSERINFO.nested_types = {}
FULLUSERINFO.enum_types = {}
FULLUSERINFO.fields = {
	var_0_3.ID_FIELD,
	var_0_3.NAME_FIELD,
	var_0_3.GOLD_FIELD,
	var_0_3.GRAIN_FIELD,
	var_0_3.INGOT_FIELD,
	var_0_3.LEVEL_FIELD,
	var_0_3.EXP_FIELD,
	var_0_3.TROPHY_FIELD,
	var_0_3.VIP_FIELD,
	var_0_3.AVATAR_FIELD,
	var_0_3.GUIDE_FIELD,
	var_0_3.SHIELD_FIELD,
	var_0_3.UNION_ID_FIELD,
	var_0_3.UNION_NAME_FIELD,
	var_0_3.UNION_AVATAR_FIELD,
	var_0_3.UNION_TAG_FIELD,
	var_0_3.UNION_TITLE_FIELD,
	var_0_3.LAST_LOGIN_FIELD,
	var_0_3.VIP_EXP_FIELD,
	var_0_3.DEF_TROOP_FIELD,
	var_0_3.CARD_BACK_FIELD,
	var_0_3.AVATAR_FRAME_FIELD,
	var_0_3.REG_DATE_FIELD,
	var_0_3.CONFIG_FIELD,
	var_0_3.PRIVILEGE_FIELD,
	var_0_3.CODE_FIELD,
	var_0_3.RID_FIELD,
	var_0_3.GUIDE1_FIELD,
	var_0_3.GUIDE2_FIELD,
	var_0_3.CROWN_FIELD,
	var_0_3.ACHIEVEMENT_FIELD,
	var_0_3.AVATAR_FRAME_COUNT_FIELD,
	var_0_3.LEGEND_CROWN_FIELD
}
FULLUSERINFO.is_extendable = false
FULLUSERINFO.extensions = {}
var_0_4.TOTAL_ATK_WIN_FIELD.name = "total_atk_win"
var_0_4.TOTAL_ATK_WIN_FIELD.full_name = ".sgland.UserBattle.total_atk_win"
var_0_4.TOTAL_ATK_WIN_FIELD.number = 1
var_0_4.TOTAL_ATK_WIN_FIELD.index = 0
var_0_4.TOTAL_ATK_WIN_FIELD.label = 2
var_0_4.TOTAL_ATK_WIN_FIELD.has_default_value = false
var_0_4.TOTAL_ATK_WIN_FIELD.default_value = 0
var_0_4.TOTAL_ATK_WIN_FIELD.type = 5
var_0_4.TOTAL_ATK_WIN_FIELD.cpp_type = 1
var_0_4.TOTAL_ATK_LOSE_FIELD.name = "total_atk_lose"
var_0_4.TOTAL_ATK_LOSE_FIELD.full_name = ".sgland.UserBattle.total_atk_lose"
var_0_4.TOTAL_ATK_LOSE_FIELD.number = 2
var_0_4.TOTAL_ATK_LOSE_FIELD.index = 1
var_0_4.TOTAL_ATK_LOSE_FIELD.label = 2
var_0_4.TOTAL_ATK_LOSE_FIELD.has_default_value = false
var_0_4.TOTAL_ATK_LOSE_FIELD.default_value = 0
var_0_4.TOTAL_ATK_LOSE_FIELD.type = 5
var_0_4.TOTAL_ATK_LOSE_FIELD.cpp_type = 1
var_0_4.TOTAL_DEF_WIN_FIELD.name = "total_def_win"
var_0_4.TOTAL_DEF_WIN_FIELD.full_name = ".sgland.UserBattle.total_def_win"
var_0_4.TOTAL_DEF_WIN_FIELD.number = 3
var_0_4.TOTAL_DEF_WIN_FIELD.index = 2
var_0_4.TOTAL_DEF_WIN_FIELD.label = 2
var_0_4.TOTAL_DEF_WIN_FIELD.has_default_value = false
var_0_4.TOTAL_DEF_WIN_FIELD.default_value = 0
var_0_4.TOTAL_DEF_WIN_FIELD.type = 5
var_0_4.TOTAL_DEF_WIN_FIELD.cpp_type = 1
var_0_4.TOTAL_DEF_LOSE_FIELD.name = "total_def_lose"
var_0_4.TOTAL_DEF_LOSE_FIELD.full_name = ".sgland.UserBattle.total_def_lose"
var_0_4.TOTAL_DEF_LOSE_FIELD.number = 4
var_0_4.TOTAL_DEF_LOSE_FIELD.index = 3
var_0_4.TOTAL_DEF_LOSE_FIELD.label = 2
var_0_4.TOTAL_DEF_LOSE_FIELD.has_default_value = false
var_0_4.TOTAL_DEF_LOSE_FIELD.default_value = 0
var_0_4.TOTAL_DEF_LOSE_FIELD.type = 5
var_0_4.TOTAL_DEF_LOSE_FIELD.cpp_type = 1
var_0_4.TOTAL_PVP_WIN_FIELD.name = "total_pvp_win"
var_0_4.TOTAL_PVP_WIN_FIELD.full_name = ".sgland.UserBattle.total_pvp_win"
var_0_4.TOTAL_PVP_WIN_FIELD.number = 5
var_0_4.TOTAL_PVP_WIN_FIELD.index = 4
var_0_4.TOTAL_PVP_WIN_FIELD.label = 2
var_0_4.TOTAL_PVP_WIN_FIELD.has_default_value = false
var_0_4.TOTAL_PVP_WIN_FIELD.default_value = 0
var_0_4.TOTAL_PVP_WIN_FIELD.type = 5
var_0_4.TOTAL_PVP_WIN_FIELD.cpp_type = 1
var_0_4.TOTAL_PVP_LOSE_FIELD.name = "total_pvp_lose"
var_0_4.TOTAL_PVP_LOSE_FIELD.full_name = ".sgland.UserBattle.total_pvp_lose"
var_0_4.TOTAL_PVP_LOSE_FIELD.number = 6
var_0_4.TOTAL_PVP_LOSE_FIELD.index = 5
var_0_4.TOTAL_PVP_LOSE_FIELD.label = 2
var_0_4.TOTAL_PVP_LOSE_FIELD.has_default_value = false
var_0_4.TOTAL_PVP_LOSE_FIELD.default_value = 0
var_0_4.TOTAL_PVP_LOSE_FIELD.type = 5
var_0_4.TOTAL_PVP_LOSE_FIELD.cpp_type = 1
var_0_4.PERIOD_ATK_WIN_FIELD.name = "period_atk_win"
var_0_4.PERIOD_ATK_WIN_FIELD.full_name = ".sgland.UserBattle.period_atk_win"
var_0_4.PERIOD_ATK_WIN_FIELD.number = 7
var_0_4.PERIOD_ATK_WIN_FIELD.index = 6
var_0_4.PERIOD_ATK_WIN_FIELD.label = 2
var_0_4.PERIOD_ATK_WIN_FIELD.has_default_value = false
var_0_4.PERIOD_ATK_WIN_FIELD.default_value = 0
var_0_4.PERIOD_ATK_WIN_FIELD.type = 5
var_0_4.PERIOD_ATK_WIN_FIELD.cpp_type = 1
var_0_4.PERIOD_ATK_LOSE_FIELD.name = "period_atk_lose"
var_0_4.PERIOD_ATK_LOSE_FIELD.full_name = ".sgland.UserBattle.period_atk_lose"
var_0_4.PERIOD_ATK_LOSE_FIELD.number = 8
var_0_4.PERIOD_ATK_LOSE_FIELD.index = 7
var_0_4.PERIOD_ATK_LOSE_FIELD.label = 2
var_0_4.PERIOD_ATK_LOSE_FIELD.has_default_value = false
var_0_4.PERIOD_ATK_LOSE_FIELD.default_value = 0
var_0_4.PERIOD_ATK_LOSE_FIELD.type = 5
var_0_4.PERIOD_ATK_LOSE_FIELD.cpp_type = 1
var_0_4.PERIOD_DEF_WIN_FIELD.name = "period_def_win"
var_0_4.PERIOD_DEF_WIN_FIELD.full_name = ".sgland.UserBattle.period_def_win"
var_0_4.PERIOD_DEF_WIN_FIELD.number = 9
var_0_4.PERIOD_DEF_WIN_FIELD.index = 8
var_0_4.PERIOD_DEF_WIN_FIELD.label = 2
var_0_4.PERIOD_DEF_WIN_FIELD.has_default_value = false
var_0_4.PERIOD_DEF_WIN_FIELD.default_value = 0
var_0_4.PERIOD_DEF_WIN_FIELD.type = 5
var_0_4.PERIOD_DEF_WIN_FIELD.cpp_type = 1
var_0_4.PERIOD_DEF_LOSE_FIELD.name = "period_def_lose"
var_0_4.PERIOD_DEF_LOSE_FIELD.full_name = ".sgland.UserBattle.period_def_lose"
var_0_4.PERIOD_DEF_LOSE_FIELD.number = 10
var_0_4.PERIOD_DEF_LOSE_FIELD.index = 9
var_0_4.PERIOD_DEF_LOSE_FIELD.label = 2
var_0_4.PERIOD_DEF_LOSE_FIELD.has_default_value = false
var_0_4.PERIOD_DEF_LOSE_FIELD.default_value = 0
var_0_4.PERIOD_DEF_LOSE_FIELD.type = 5
var_0_4.PERIOD_DEF_LOSE_FIELD.cpp_type = 1
var_0_4.DAILY_PVP_WIN_FIELD.name = "daily_pvp_win"
var_0_4.DAILY_PVP_WIN_FIELD.full_name = ".sgland.UserBattle.daily_pvp_win"
var_0_4.DAILY_PVP_WIN_FIELD.number = 11
var_0_4.DAILY_PVP_WIN_FIELD.index = 10
var_0_4.DAILY_PVP_WIN_FIELD.label = 2
var_0_4.DAILY_PVP_WIN_FIELD.has_default_value = false
var_0_4.DAILY_PVP_WIN_FIELD.default_value = 0
var_0_4.DAILY_PVP_WIN_FIELD.type = 5
var_0_4.DAILY_PVP_WIN_FIELD.cpp_type = 1
var_0_4.DAILY_PVP_LOSE_FIELD.name = "daily_pvp_lose"
var_0_4.DAILY_PVP_LOSE_FIELD.full_name = ".sgland.UserBattle.daily_pvp_lose"
var_0_4.DAILY_PVP_LOSE_FIELD.number = 12
var_0_4.DAILY_PVP_LOSE_FIELD.index = 11
var_0_4.DAILY_PVP_LOSE_FIELD.label = 2
var_0_4.DAILY_PVP_LOSE_FIELD.has_default_value = false
var_0_4.DAILY_PVP_LOSE_FIELD.default_value = 0
var_0_4.DAILY_PVP_LOSE_FIELD.type = 5
var_0_4.DAILY_PVP_LOSE_FIELD.cpp_type = 1
var_0_4.BOSS_SCORE_FIELD.name = "boss_score"
var_0_4.BOSS_SCORE_FIELD.full_name = ".sgland.UserBattle.boss_score"
var_0_4.BOSS_SCORE_FIELD.number = 13
var_0_4.BOSS_SCORE_FIELD.index = 12
var_0_4.BOSS_SCORE_FIELD.label = 2
var_0_4.BOSS_SCORE_FIELD.has_default_value = false
var_0_4.BOSS_SCORE_FIELD.default_value = 0
var_0_4.BOSS_SCORE_FIELD.type = 5
var_0_4.BOSS_SCORE_FIELD.cpp_type = 1
var_0_4.DAILY_LADDER_WIN_FIELD.name = "daily_ladder_win"
var_0_4.DAILY_LADDER_WIN_FIELD.full_name = ".sgland.UserBattle.daily_ladder_win"
var_0_4.DAILY_LADDER_WIN_FIELD.number = 14
var_0_4.DAILY_LADDER_WIN_FIELD.index = 13
var_0_4.DAILY_LADDER_WIN_FIELD.label = 2
var_0_4.DAILY_LADDER_WIN_FIELD.has_default_value = false
var_0_4.DAILY_LADDER_WIN_FIELD.default_value = 0
var_0_4.DAILY_LADDER_WIN_FIELD.type = 5
var_0_4.DAILY_LADDER_WIN_FIELD.cpp_type = 1
var_0_4.DAILY_LADDER_LOSE_FIELD.name = "daily_ladder_lose"
var_0_4.DAILY_LADDER_LOSE_FIELD.full_name = ".sgland.UserBattle.daily_ladder_lose"
var_0_4.DAILY_LADDER_LOSE_FIELD.number = 15
var_0_4.DAILY_LADDER_LOSE_FIELD.index = 14
var_0_4.DAILY_LADDER_LOSE_FIELD.label = 2
var_0_4.DAILY_LADDER_LOSE_FIELD.has_default_value = false
var_0_4.DAILY_LADDER_LOSE_FIELD.default_value = 0
var_0_4.DAILY_LADDER_LOSE_FIELD.type = 5
var_0_4.DAILY_LADDER_LOSE_FIELD.cpp_type = 1
var_0_4.LADDER_CONT_WIN_FIELD.name = "ladder_cont_win"
var_0_4.LADDER_CONT_WIN_FIELD.full_name = ".sgland.UserBattle.ladder_cont_win"
var_0_4.LADDER_CONT_WIN_FIELD.number = 16
var_0_4.LADDER_CONT_WIN_FIELD.index = 15
var_0_4.LADDER_CONT_WIN_FIELD.label = 2
var_0_4.LADDER_CONT_WIN_FIELD.has_default_value = false
var_0_4.LADDER_CONT_WIN_FIELD.default_value = 0
var_0_4.LADDER_CONT_WIN_FIELD.type = 5
var_0_4.LADDER_CONT_WIN_FIELD.cpp_type = 1
var_0_4.LADDER_CONT_LOSE_FIELD.name = "ladder_cont_lose"
var_0_4.LADDER_CONT_LOSE_FIELD.full_name = ".sgland.UserBattle.ladder_cont_lose"
var_0_4.LADDER_CONT_LOSE_FIELD.number = 17
var_0_4.LADDER_CONT_LOSE_FIELD.index = 16
var_0_4.LADDER_CONT_LOSE_FIELD.label = 2
var_0_4.LADDER_CONT_LOSE_FIELD.has_default_value = false
var_0_4.LADDER_CONT_LOSE_FIELD.default_value = 0
var_0_4.LADDER_CONT_LOSE_FIELD.type = 5
var_0_4.LADDER_CONT_LOSE_FIELD.cpp_type = 1
USERBATTLE.name = "UserBattle"
USERBATTLE.full_name = ".sgland.UserBattle"
USERBATTLE.nested_types = {}
USERBATTLE.enum_types = {}
USERBATTLE.fields = {
	var_0_4.TOTAL_ATK_WIN_FIELD,
	var_0_4.TOTAL_ATK_LOSE_FIELD,
	var_0_4.TOTAL_DEF_WIN_FIELD,
	var_0_4.TOTAL_DEF_LOSE_FIELD,
	var_0_4.TOTAL_PVP_WIN_FIELD,
	var_0_4.TOTAL_PVP_LOSE_FIELD,
	var_0_4.PERIOD_ATK_WIN_FIELD,
	var_0_4.PERIOD_ATK_LOSE_FIELD,
	var_0_4.PERIOD_DEF_WIN_FIELD,
	var_0_4.PERIOD_DEF_LOSE_FIELD,
	var_0_4.DAILY_PVP_WIN_FIELD,
	var_0_4.DAILY_PVP_LOSE_FIELD,
	var_0_4.BOSS_SCORE_FIELD,
	var_0_4.DAILY_LADDER_WIN_FIELD,
	var_0_4.DAILY_LADDER_LOSE_FIELD,
	var_0_4.LADDER_CONT_WIN_FIELD,
	var_0_4.LADDER_CONT_LOSE_FIELD
}
USERBATTLE.is_extendable = false
USERBATTLE.extensions = {}
var_0_5.NEXT_FREE_FIELD.name = "next_free"
var_0_5.NEXT_FREE_FIELD.full_name = ".sgland.UserLottery.next_free"
var_0_5.NEXT_FREE_FIELD.number = 1
var_0_5.NEXT_FREE_FIELD.index = 0
var_0_5.NEXT_FREE_FIELD.label = 3
var_0_5.NEXT_FREE_FIELD.has_default_value = false
var_0_5.NEXT_FREE_FIELD.default_value = {}
var_0_5.NEXT_FREE_FIELD.type = 3
var_0_5.NEXT_FREE_FIELD.cpp_type = 2
var_0_5.NEXT_QUALITY_FIELD.name = "next_quality"
var_0_5.NEXT_QUALITY_FIELD.full_name = ".sgland.UserLottery.next_quality"
var_0_5.NEXT_QUALITY_FIELD.number = 2
var_0_5.NEXT_QUALITY_FIELD.index = 1
var_0_5.NEXT_QUALITY_FIELD.label = 2
var_0_5.NEXT_QUALITY_FIELD.has_default_value = false
var_0_5.NEXT_QUALITY_FIELD.default_value = 0
var_0_5.NEXT_QUALITY_FIELD.type = 5
var_0_5.NEXT_QUALITY_FIELD.cpp_type = 1
var_0_5.COUNT_FIELD.name = "count"
var_0_5.COUNT_FIELD.full_name = ".sgland.UserLottery.count"
var_0_5.COUNT_FIELD.number = 3
var_0_5.COUNT_FIELD.index = 2
var_0_5.COUNT_FIELD.label = 3
var_0_5.COUNT_FIELD.has_default_value = false
var_0_5.COUNT_FIELD.default_value = {}
var_0_5.COUNT_FIELD.type = 5
var_0_5.COUNT_FIELD.cpp_type = 1
var_0_5.NCHEST_FIELD.name = "nchest"
var_0_5.NCHEST_FIELD.full_name = ".sgland.UserLottery.nchest"
var_0_5.NCHEST_FIELD.number = 4
var_0_5.NCHEST_FIELD.index = 3
var_0_5.NCHEST_FIELD.label = 2
var_0_5.NCHEST_FIELD.has_default_value = false
var_0_5.NCHEST_FIELD.default_value = 0
var_0_5.NCHEST_FIELD.type = 5
var_0_5.NCHEST_FIELD.cpp_type = 1
var_0_5.NCHEST_EX_FIELD.name = "nchest_ex"
var_0_5.NCHEST_EX_FIELD.full_name = ".sgland.UserLottery.nchest_ex"
var_0_5.NCHEST_EX_FIELD.number = 5
var_0_5.NCHEST_EX_FIELD.index = 4
var_0_5.NCHEST_EX_FIELD.label = 2
var_0_5.NCHEST_EX_FIELD.has_default_value = false
var_0_5.NCHEST_EX_FIELD.default_value = 0
var_0_5.NCHEST_EX_FIELD.type = 5
var_0_5.NCHEST_EX_FIELD.cpp_type = 1
var_0_5.POINT_FIELD.name = "point"
var_0_5.POINT_FIELD.full_name = ".sgland.UserLottery.point"
var_0_5.POINT_FIELD.number = 6
var_0_5.POINT_FIELD.index = 5
var_0_5.POINT_FIELD.label = 2
var_0_5.POINT_FIELD.has_default_value = false
var_0_5.POINT_FIELD.default_value = 0
var_0_5.POINT_FIELD.type = 5
var_0_5.POINT_FIELD.cpp_type = 1
USERLOTTERY.name = "UserLottery"
USERLOTTERY.full_name = ".sgland.UserLottery"
USERLOTTERY.nested_types = {}
USERLOTTERY.enum_types = {}
USERLOTTERY.fields = {
	var_0_5.NEXT_FREE_FIELD,
	var_0_5.NEXT_QUALITY_FIELD,
	var_0_5.COUNT_FIELD,
	var_0_5.NCHEST_FIELD,
	var_0_5.NCHEST_EX_FIELD,
	var_0_5.POINT_FIELD
}
USERLOTTERY.is_extendable = false
USERLOTTERY.extensions = {}
var_0_6.BUY_GOLD_FIELD.name = "buy_gold"
var_0_6.BUY_GOLD_FIELD.full_name = ".sgland.UserCount.buy_gold"
var_0_6.BUY_GOLD_FIELD.number = 1
var_0_6.BUY_GOLD_FIELD.index = 0
var_0_6.BUY_GOLD_FIELD.label = 2
var_0_6.BUY_GOLD_FIELD.has_default_value = false
var_0_6.BUY_GOLD_FIELD.default_value = 0
var_0_6.BUY_GOLD_FIELD.type = 5
var_0_6.BUY_GOLD_FIELD.cpp_type = 1
var_0_6.BUY_GRAIN_FIELD.name = "buy_grain"
var_0_6.BUY_GRAIN_FIELD.full_name = ".sgland.UserCount.buy_grain"
var_0_6.BUY_GRAIN_FIELD.number = 2
var_0_6.BUY_GRAIN_FIELD.index = 1
var_0_6.BUY_GRAIN_FIELD.label = 2
var_0_6.BUY_GRAIN_FIELD.has_default_value = false
var_0_6.BUY_GRAIN_FIELD.default_value = 0
var_0_6.BUY_GRAIN_FIELD.type = 5
var_0_6.BUY_GRAIN_FIELD.cpp_type = 1
var_0_6.BUY_REFRESH_FIELD.name = "buy_refresh"
var_0_6.BUY_REFRESH_FIELD.full_name = ".sgland.UserCount.buy_refresh"
var_0_6.BUY_REFRESH_FIELD.number = 3
var_0_6.BUY_REFRESH_FIELD.index = 2
var_0_6.BUY_REFRESH_FIELD.label = 2
var_0_6.BUY_REFRESH_FIELD.has_default_value = false
var_0_6.BUY_REFRESH_FIELD.default_value = 0
var_0_6.BUY_REFRESH_FIELD.type = 5
var_0_6.BUY_REFRESH_FIELD.cpp_type = 1
var_0_6.BUY_CHEST1_FIELD.name = "buy_chest1"
var_0_6.BUY_CHEST1_FIELD.full_name = ".sgland.UserCount.buy_chest1"
var_0_6.BUY_CHEST1_FIELD.number = 4
var_0_6.BUY_CHEST1_FIELD.index = 3
var_0_6.BUY_CHEST1_FIELD.label = 2
var_0_6.BUY_CHEST1_FIELD.has_default_value = false
var_0_6.BUY_CHEST1_FIELD.default_value = 0
var_0_6.BUY_CHEST1_FIELD.type = 5
var_0_6.BUY_CHEST1_FIELD.cpp_type = 1
var_0_6.BUY_CHEST2_FIELD.name = "buy_chest2"
var_0_6.BUY_CHEST2_FIELD.full_name = ".sgland.UserCount.buy_chest2"
var_0_6.BUY_CHEST2_FIELD.number = 5
var_0_6.BUY_CHEST2_FIELD.index = 4
var_0_6.BUY_CHEST2_FIELD.label = 2
var_0_6.BUY_CHEST2_FIELD.has_default_value = false
var_0_6.BUY_CHEST2_FIELD.default_value = 0
var_0_6.BUY_CHEST2_FIELD.type = 5
var_0_6.BUY_CHEST2_FIELD.cpp_type = 1
var_0_6.BUY_CHEST3_FIELD.name = "buy_chest3"
var_0_6.BUY_CHEST3_FIELD.full_name = ".sgland.UserCount.buy_chest3"
var_0_6.BUY_CHEST3_FIELD.number = 6
var_0_6.BUY_CHEST3_FIELD.index = 5
var_0_6.BUY_CHEST3_FIELD.label = 2
var_0_6.BUY_CHEST3_FIELD.has_default_value = false
var_0_6.BUY_CHEST3_FIELD.default_value = 0
var_0_6.BUY_CHEST3_FIELD.type = 5
var_0_6.BUY_CHEST3_FIELD.cpp_type = 1
var_0_6.BUY_CHEST4_FIELD.name = "buy_chest4"
var_0_6.BUY_CHEST4_FIELD.full_name = ".sgland.UserCount.buy_chest4"
var_0_6.BUY_CHEST4_FIELD.number = 7
var_0_6.BUY_CHEST4_FIELD.index = 6
var_0_6.BUY_CHEST4_FIELD.label = 2
var_0_6.BUY_CHEST4_FIELD.has_default_value = false
var_0_6.BUY_CHEST4_FIELD.default_value = 0
var_0_6.BUY_CHEST4_FIELD.type = 5
var_0_6.BUY_CHEST4_FIELD.cpp_type = 1
var_0_6.BUY_HERO_EXP_FIELD.name = "buy_hero_exp"
var_0_6.BUY_HERO_EXP_FIELD.full_name = ".sgland.UserCount.buy_hero_exp"
var_0_6.BUY_HERO_EXP_FIELD.number = 8
var_0_6.BUY_HERO_EXP_FIELD.index = 7
var_0_6.BUY_HERO_EXP_FIELD.label = 2
var_0_6.BUY_HERO_EXP_FIELD.has_default_value = false
var_0_6.BUY_HERO_EXP_FIELD.default_value = 0
var_0_6.BUY_HERO_EXP_FIELD.type = 5
var_0_6.BUY_HERO_EXP_FIELD.cpp_type = 1
var_0_6.BUY_EQUIP_EXP_FIELD.name = "buy_equip_exp"
var_0_6.BUY_EQUIP_EXP_FIELD.full_name = ".sgland.UserCount.buy_equip_exp"
var_0_6.BUY_EQUIP_EXP_FIELD.number = 9
var_0_6.BUY_EQUIP_EXP_FIELD.index = 8
var_0_6.BUY_EQUIP_EXP_FIELD.label = 2
var_0_6.BUY_EQUIP_EXP_FIELD.has_default_value = false
var_0_6.BUY_EQUIP_EXP_FIELD.default_value = 0
var_0_6.BUY_EQUIP_EXP_FIELD.type = 5
var_0_6.BUY_EQUIP_EXP_FIELD.cpp_type = 1
var_0_6.BUY_HORSE_EXP_FIELD.name = "buy_horse_exp"
var_0_6.BUY_HORSE_EXP_FIELD.full_name = ".sgland.UserCount.buy_horse_exp"
var_0_6.BUY_HORSE_EXP_FIELD.number = 10
var_0_6.BUY_HORSE_EXP_FIELD.index = 9
var_0_6.BUY_HORSE_EXP_FIELD.label = 2
var_0_6.BUY_HORSE_EXP_FIELD.has_default_value = false
var_0_6.BUY_HORSE_EXP_FIELD.default_value = 0
var_0_6.BUY_HORSE_EXP_FIELD.type = 5
var_0_6.BUY_HORSE_EXP_FIELD.cpp_type = 1
var_0_6.BUY_BOOK_EXP_FIELD.name = "buy_book_exp"
var_0_6.BUY_BOOK_EXP_FIELD.full_name = ".sgland.UserCount.buy_book_exp"
var_0_6.BUY_BOOK_EXP_FIELD.number = 11
var_0_6.BUY_BOOK_EXP_FIELD.index = 10
var_0_6.BUY_BOOK_EXP_FIELD.label = 2
var_0_6.BUY_BOOK_EXP_FIELD.has_default_value = false
var_0_6.BUY_BOOK_EXP_FIELD.default_value = 0
var_0_6.BUY_BOOK_EXP_FIELD.type = 5
var_0_6.BUY_BOOK_EXP_FIELD.cpp_type = 1
var_0_6.BUY_COMMANDER_FIELD.name = "buy_commander"
var_0_6.BUY_COMMANDER_FIELD.full_name = ".sgland.UserCount.buy_commander"
var_0_6.BUY_COMMANDER_FIELD.number = 12
var_0_6.BUY_COMMANDER_FIELD.index = 11
var_0_6.BUY_COMMANDER_FIELD.label = 2
var_0_6.BUY_COMMANDER_FIELD.has_default_value = false
var_0_6.BUY_COMMANDER_FIELD.default_value = 0
var_0_6.BUY_COMMANDER_FIELD.type = 5
var_0_6.BUY_COMMANDER_FIELD.cpp_type = 1
var_0_6.BUY_ELITE_FIELD.name = "buy_elite"
var_0_6.BUY_ELITE_FIELD.full_name = ".sgland.UserCount.buy_elite"
var_0_6.BUY_ELITE_FIELD.number = 13
var_0_6.BUY_ELITE_FIELD.index = 12
var_0_6.BUY_ELITE_FIELD.label = 2
var_0_6.BUY_ELITE_FIELD.has_default_value = false
var_0_6.BUY_ELITE_FIELD.default_value = 0
var_0_6.BUY_ELITE_FIELD.type = 5
var_0_6.BUY_ELITE_FIELD.cpp_type = 1
var_0_6.BUY_EXPEDITION_FIELD.name = "buy_expedition"
var_0_6.BUY_EXPEDITION_FIELD.full_name = ".sgland.UserCount.buy_expedition"
var_0_6.BUY_EXPEDITION_FIELD.number = 14
var_0_6.BUY_EXPEDITION_FIELD.index = 13
var_0_6.BUY_EXPEDITION_FIELD.label = 2
var_0_6.BUY_EXPEDITION_FIELD.has_default_value = false
var_0_6.BUY_EXPEDITION_FIELD.default_value = 0
var_0_6.BUY_EXPEDITION_FIELD.type = 5
var_0_6.BUY_EXPEDITION_FIELD.cpp_type = 1
var_0_6.BUY_ROB_GOLD_FIELD.name = "buy_rob_gold"
var_0_6.BUY_ROB_GOLD_FIELD.full_name = ".sgland.UserCount.buy_rob_gold"
var_0_6.BUY_ROB_GOLD_FIELD.number = 15
var_0_6.BUY_ROB_GOLD_FIELD.index = 14
var_0_6.BUY_ROB_GOLD_FIELD.label = 2
var_0_6.BUY_ROB_GOLD_FIELD.has_default_value = false
var_0_6.BUY_ROB_GOLD_FIELD.default_value = 0
var_0_6.BUY_ROB_GOLD_FIELD.type = 5
var_0_6.BUY_ROB_GOLD_FIELD.cpp_type = 1
var_0_6.EDIT_NAME_FIELD.name = "edit_name"
var_0_6.EDIT_NAME_FIELD.full_name = ".sgland.UserCount.edit_name"
var_0_6.EDIT_NAME_FIELD.number = 16
var_0_6.EDIT_NAME_FIELD.index = 15
var_0_6.EDIT_NAME_FIELD.label = 2
var_0_6.EDIT_NAME_FIELD.has_default_value = false
var_0_6.EDIT_NAME_FIELD.default_value = 0
var_0_6.EDIT_NAME_FIELD.type = 5
var_0_6.EDIT_NAME_FIELD.cpp_type = 1
var_0_6.NEXT_SHARE_FIELD.name = "next_share"
var_0_6.NEXT_SHARE_FIELD.full_name = ".sgland.UserCount.next_share"
var_0_6.NEXT_SHARE_FIELD.number = 17
var_0_6.NEXT_SHARE_FIELD.index = 16
var_0_6.NEXT_SHARE_FIELD.label = 2
var_0_6.NEXT_SHARE_FIELD.has_default_value = false
var_0_6.NEXT_SHARE_FIELD.default_value = 0
var_0_6.NEXT_SHARE_FIELD.type = 3
var_0_6.NEXT_SHARE_FIELD.cpp_type = 2
var_0_6.CHALLENGE_COMMANDER_FIELD.name = "challenge_commander"
var_0_6.CHALLENGE_COMMANDER_FIELD.full_name = ".sgland.UserCount.challenge_commander"
var_0_6.CHALLENGE_COMMANDER_FIELD.number = 18
var_0_6.CHALLENGE_COMMANDER_FIELD.index = 17
var_0_6.CHALLENGE_COMMANDER_FIELD.label = 2
var_0_6.CHALLENGE_COMMANDER_FIELD.has_default_value = false
var_0_6.CHALLENGE_COMMANDER_FIELD.default_value = 0
var_0_6.CHALLENGE_COMMANDER_FIELD.type = 5
var_0_6.CHALLENGE_COMMANDER_FIELD.cpp_type = 1
var_0_6.CHALLENGE_ELITE_FIELD.name = "challenge_elite"
var_0_6.CHALLENGE_ELITE_FIELD.full_name = ".sgland.UserCount.challenge_elite"
var_0_6.CHALLENGE_ELITE_FIELD.number = 19
var_0_6.CHALLENGE_ELITE_FIELD.index = 18
var_0_6.CHALLENGE_ELITE_FIELD.label = 2
var_0_6.CHALLENGE_ELITE_FIELD.has_default_value = false
var_0_6.CHALLENGE_ELITE_FIELD.default_value = 0
var_0_6.CHALLENGE_ELITE_FIELD.type = 5
var_0_6.CHALLENGE_ELITE_FIELD.cpp_type = 1
var_0_6.EXPEDITION_FIELD.name = "expedition"
var_0_6.EXPEDITION_FIELD.full_name = ".sgland.UserCount.expedition"
var_0_6.EXPEDITION_FIELD.number = 20
var_0_6.EXPEDITION_FIELD.index = 19
var_0_6.EXPEDITION_FIELD.label = 2
var_0_6.EXPEDITION_FIELD.has_default_value = false
var_0_6.EXPEDITION_FIELD.default_value = 0
var_0_6.EXPEDITION_FIELD.type = 5
var_0_6.EXPEDITION_FIELD.cpp_type = 1
var_0_6.ROB_GOLD_FIELD.name = "rob_gold"
var_0_6.ROB_GOLD_FIELD.full_name = ".sgland.UserCount.rob_gold"
var_0_6.ROB_GOLD_FIELD.number = 21
var_0_6.ROB_GOLD_FIELD.index = 20
var_0_6.ROB_GOLD_FIELD.label = 2
var_0_6.ROB_GOLD_FIELD.has_default_value = false
var_0_6.ROB_GOLD_FIELD.default_value = 0
var_0_6.ROB_GOLD_FIELD.type = 5
var_0_6.ROB_GOLD_FIELD.cpp_type = 1
var_0_6.NEXT_CHAT_FIELD.name = "next_chat"
var_0_6.NEXT_CHAT_FIELD.full_name = ".sgland.UserCount.next_chat"
var_0_6.NEXT_CHAT_FIELD.number = 22
var_0_6.NEXT_CHAT_FIELD.index = 21
var_0_6.NEXT_CHAT_FIELD.label = 2
var_0_6.NEXT_CHAT_FIELD.has_default_value = false
var_0_6.NEXT_CHAT_FIELD.default_value = 0
var_0_6.NEXT_CHAT_FIELD.type = 3
var_0_6.NEXT_CHAT_FIELD.cpp_type = 2
var_0_6.SEND_MAIL_FIELD.name = "send_mail"
var_0_6.SEND_MAIL_FIELD.full_name = ".sgland.UserCount.send_mail"
var_0_6.SEND_MAIL_FIELD.number = 23
var_0_6.SEND_MAIL_FIELD.index = 22
var_0_6.SEND_MAIL_FIELD.label = 2
var_0_6.SEND_MAIL_FIELD.has_default_value = false
var_0_6.SEND_MAIL_FIELD.default_value = 0
var_0_6.SEND_MAIL_FIELD.type = 5
var_0_6.SEND_MAIL_FIELD.cpp_type = 1
var_0_6.MONTH_CARD_FIELD.name = "month_card"
var_0_6.MONTH_CARD_FIELD.full_name = ".sgland.UserCount.month_card"
var_0_6.MONTH_CARD_FIELD.number = 24
var_0_6.MONTH_CARD_FIELD.index = 23
var_0_6.MONTH_CARD_FIELD.label = 2
var_0_6.MONTH_CARD_FIELD.has_default_value = false
var_0_6.MONTH_CARD_FIELD.default_value = 0
var_0_6.MONTH_CARD_FIELD.type = 3
var_0_6.MONTH_CARD_FIELD.cpp_type = 2
var_0_6.COLLECT_GOLD_FIELD.name = "collect_gold"
var_0_6.COLLECT_GOLD_FIELD.full_name = ".sgland.UserCount.collect_gold"
var_0_6.COLLECT_GOLD_FIELD.number = 25
var_0_6.COLLECT_GOLD_FIELD.index = 24
var_0_6.COLLECT_GOLD_FIELD.label = 2
var_0_6.COLLECT_GOLD_FIELD.has_default_value = false
var_0_6.COLLECT_GOLD_FIELD.default_value = 0
var_0_6.COLLECT_GOLD_FIELD.type = 5
var_0_6.COLLECT_GOLD_FIELD.cpp_type = 1
var_0_6.CHARGE_FIELD.name = "charge"
var_0_6.CHARGE_FIELD.full_name = ".sgland.UserCount.charge"
var_0_6.CHARGE_FIELD.number = 26
var_0_6.CHARGE_FIELD.index = 25
var_0_6.CHARGE_FIELD.label = 2
var_0_6.CHARGE_FIELD.has_default_value = false
var_0_6.CHARGE_FIELD.default_value = 0
var_0_6.CHARGE_FIELD.type = 3
var_0_6.CHARGE_FIELD.cpp_type = 2
var_0_6.NEXT_SPAWN_FIELD.name = "next_spawn"
var_0_6.NEXT_SPAWN_FIELD.full_name = ".sgland.UserCount.next_spawn"
var_0_6.NEXT_SPAWN_FIELD.number = 27
var_0_6.NEXT_SPAWN_FIELD.index = 26
var_0_6.NEXT_SPAWN_FIELD.label = 2
var_0_6.NEXT_SPAWN_FIELD.has_default_value = false
var_0_6.NEXT_SPAWN_FIELD.default_value = 0
var_0_6.NEXT_SPAWN_FIELD.type = 3
var_0_6.NEXT_SPAWN_FIELD.cpp_type = 2
var_0_6.NEXT_SOS_FIELD.name = "next_sos"
var_0_6.NEXT_SOS_FIELD.full_name = ".sgland.UserCount.next_sos"
var_0_6.NEXT_SOS_FIELD.number = 28
var_0_6.NEXT_SOS_FIELD.index = 27
var_0_6.NEXT_SOS_FIELD.label = 2
var_0_6.NEXT_SOS_FIELD.has_default_value = false
var_0_6.NEXT_SOS_FIELD.default_value = 0
var_0_6.NEXT_SOS_FIELD.type = 3
var_0_6.NEXT_SOS_FIELD.cpp_type = 2
var_0_6.DONATE_FIELD.name = "donate"
var_0_6.DONATE_FIELD.full_name = ".sgland.UserCount.donate"
var_0_6.DONATE_FIELD.number = 29
var_0_6.DONATE_FIELD.index = 28
var_0_6.DONATE_FIELD.label = 2
var_0_6.DONATE_FIELD.has_default_value = false
var_0_6.DONATE_FIELD.default_value = 0
var_0_6.DONATE_FIELD.type = 5
var_0_6.DONATE_FIELD.cpp_type = 1
var_0_6.BUY_REMEDY_FIELD.name = "buy_remedy"
var_0_6.BUY_REMEDY_FIELD.full_name = ".sgland.UserCount.buy_remedy"
var_0_6.BUY_REMEDY_FIELD.number = 30
var_0_6.BUY_REMEDY_FIELD.index = 29
var_0_6.BUY_REMEDY_FIELD.label = 2
var_0_6.BUY_REMEDY_FIELD.has_default_value = false
var_0_6.BUY_REMEDY_FIELD.default_value = 0
var_0_6.BUY_REMEDY_FIELD.type = 5
var_0_6.BUY_REMEDY_FIELD.cpp_type = 1
var_0_6.BUY_STONE_FIELD.name = "buy_stone"
var_0_6.BUY_STONE_FIELD.full_name = ".sgland.UserCount.buy_stone"
var_0_6.BUY_STONE_FIELD.number = 31
var_0_6.BUY_STONE_FIELD.index = 30
var_0_6.BUY_STONE_FIELD.label = 2
var_0_6.BUY_STONE_FIELD.has_default_value = false
var_0_6.BUY_STONE_FIELD.default_value = 0
var_0_6.BUY_STONE_FIELD.type = 5
var_0_6.BUY_STONE_FIELD.cpp_type = 1
var_0_6.BUY_ROB_EXP_FIELD.name = "buy_rob_exp"
var_0_6.BUY_ROB_EXP_FIELD.full_name = ".sgland.UserCount.buy_rob_exp"
var_0_6.BUY_ROB_EXP_FIELD.number = 32
var_0_6.BUY_ROB_EXP_FIELD.index = 31
var_0_6.BUY_ROB_EXP_FIELD.label = 2
var_0_6.BUY_ROB_EXP_FIELD.has_default_value = false
var_0_6.BUY_ROB_EXP_FIELD.default_value = 0
var_0_6.BUY_ROB_EXP_FIELD.type = 5
var_0_6.BUY_ROB_EXP_FIELD.cpp_type = 1
var_0_6.ROB_EXP_FIELD.name = "rob_exp"
var_0_6.ROB_EXP_FIELD.full_name = ".sgland.UserCount.rob_exp"
var_0_6.ROB_EXP_FIELD.number = 33
var_0_6.ROB_EXP_FIELD.index = 32
var_0_6.ROB_EXP_FIELD.label = 2
var_0_6.ROB_EXP_FIELD.has_default_value = false
var_0_6.ROB_EXP_FIELD.default_value = 0
var_0_6.ROB_EXP_FIELD.type = 5
var_0_6.ROB_EXP_FIELD.cpp_type = 1
var_0_6.TROPHY_FIELD.name = "trophy"
var_0_6.TROPHY_FIELD.full_name = ".sgland.UserCount.trophy"
var_0_6.TROPHY_FIELD.number = 34
var_0_6.TROPHY_FIELD.index = 33
var_0_6.TROPHY_FIELD.label = 2
var_0_6.TROPHY_FIELD.has_default_value = false
var_0_6.TROPHY_FIELD.default_value = 0
var_0_6.TROPHY_FIELD.type = 5
var_0_6.TROPHY_FIELD.cpp_type = 1
var_0_6.DAILY_CHARGE_FIELD.name = "daily_charge"
var_0_6.DAILY_CHARGE_FIELD.full_name = ".sgland.UserCount.daily_charge"
var_0_6.DAILY_CHARGE_FIELD.number = 35
var_0_6.DAILY_CHARGE_FIELD.index = 34
var_0_6.DAILY_CHARGE_FIELD.label = 2
var_0_6.DAILY_CHARGE_FIELD.has_default_value = false
var_0_6.DAILY_CHARGE_FIELD.default_value = 0
var_0_6.DAILY_CHARGE_FIELD.type = 5
var_0_6.DAILY_CHARGE_FIELD.cpp_type = 1
var_0_6.WIN_ROB_GOLD_FIELD.name = "win_rob_gold"
var_0_6.WIN_ROB_GOLD_FIELD.full_name = ".sgland.UserCount.win_rob_gold"
var_0_6.WIN_ROB_GOLD_FIELD.number = 36
var_0_6.WIN_ROB_GOLD_FIELD.index = 35
var_0_6.WIN_ROB_GOLD_FIELD.label = 2
var_0_6.WIN_ROB_GOLD_FIELD.has_default_value = false
var_0_6.WIN_ROB_GOLD_FIELD.default_value = 0
var_0_6.WIN_ROB_GOLD_FIELD.type = 5
var_0_6.WIN_ROB_GOLD_FIELD.cpp_type = 1
var_0_6.WORSHIP_FIELD.name = "worship"
var_0_6.WORSHIP_FIELD.full_name = ".sgland.UserCount.worship"
var_0_6.WORSHIP_FIELD.number = 37
var_0_6.WORSHIP_FIELD.index = 36
var_0_6.WORSHIP_FIELD.label = 2
var_0_6.WORSHIP_FIELD.has_default_value = false
var_0_6.WORSHIP_FIELD.default_value = 0
var_0_6.WORSHIP_FIELD.type = 5
var_0_6.WORSHIP_FIELD.cpp_type = 1
var_0_6.BUY_REFRESH_PVP_FIELD.name = "buy_refresh_pvp"
var_0_6.BUY_REFRESH_PVP_FIELD.full_name = ".sgland.UserCount.buy_refresh_pvp"
var_0_6.BUY_REFRESH_PVP_FIELD.number = 38
var_0_6.BUY_REFRESH_PVP_FIELD.index = 37
var_0_6.BUY_REFRESH_PVP_FIELD.label = 2
var_0_6.BUY_REFRESH_PVP_FIELD.has_default_value = false
var_0_6.BUY_REFRESH_PVP_FIELD.default_value = 0
var_0_6.BUY_REFRESH_PVP_FIELD.type = 5
var_0_6.BUY_REFRESH_PVP_FIELD.cpp_type = 1
var_0_6.BUY_REFRESH_UNION_FIELD.name = "buy_refresh_union"
var_0_6.BUY_REFRESH_UNION_FIELD.full_name = ".sgland.UserCount.buy_refresh_union"
var_0_6.BUY_REFRESH_UNION_FIELD.number = 39
var_0_6.BUY_REFRESH_UNION_FIELD.index = 38
var_0_6.BUY_REFRESH_UNION_FIELD.label = 2
var_0_6.BUY_REFRESH_UNION_FIELD.has_default_value = false
var_0_6.BUY_REFRESH_UNION_FIELD.default_value = 0
var_0_6.BUY_REFRESH_UNION_FIELD.type = 5
var_0_6.BUY_REFRESH_UNION_FIELD.cpp_type = 1
var_0_6.ATK_BOSS_FIELD.name = "atk_boss"
var_0_6.ATK_BOSS_FIELD.full_name = ".sgland.UserCount.atk_boss"
var_0_6.ATK_BOSS_FIELD.number = 40
var_0_6.ATK_BOSS_FIELD.index = 39
var_0_6.ATK_BOSS_FIELD.label = 2
var_0_6.ATK_BOSS_FIELD.has_default_value = false
var_0_6.ATK_BOSS_FIELD.default_value = 0
var_0_6.ATK_BOSS_FIELD.type = 5
var_0_6.ATK_BOSS_FIELD.cpp_type = 1
var_0_6.BUY_ATK_BOSS_FIELD.name = "buy_atk_boss"
var_0_6.BUY_ATK_BOSS_FIELD.full_name = ".sgland.UserCount.buy_atk_boss"
var_0_6.BUY_ATK_BOSS_FIELD.number = 41
var_0_6.BUY_ATK_BOSS_FIELD.index = 40
var_0_6.BUY_ATK_BOSS_FIELD.label = 2
var_0_6.BUY_ATK_BOSS_FIELD.has_default_value = false
var_0_6.BUY_ATK_BOSS_FIELD.default_value = 0
var_0_6.BUY_ATK_BOSS_FIELD.type = 5
var_0_6.BUY_ATK_BOSS_FIELD.cpp_type = 1
var_0_6.RE_CHECK_FIELD.name = "re_check"
var_0_6.RE_CHECK_FIELD.full_name = ".sgland.UserCount.re_check"
var_0_6.RE_CHECK_FIELD.number = 42
var_0_6.RE_CHECK_FIELD.index = 41
var_0_6.RE_CHECK_FIELD.label = 2
var_0_6.RE_CHECK_FIELD.has_default_value = false
var_0_6.RE_CHECK_FIELD.default_value = 0
var_0_6.RE_CHECK_FIELD.type = 5
var_0_6.RE_CHECK_FIELD.cpp_type = 1
var_0_6.MONTH_CARD_EX_FIELD.name = "month_card_ex"
var_0_6.MONTH_CARD_EX_FIELD.full_name = ".sgland.UserCount.month_card_ex"
var_0_6.MONTH_CARD_EX_FIELD.number = 43
var_0_6.MONTH_CARD_EX_FIELD.index = 42
var_0_6.MONTH_CARD_EX_FIELD.label = 2
var_0_6.MONTH_CARD_EX_FIELD.has_default_value = false
var_0_6.MONTH_CARD_EX_FIELD.default_value = 0
var_0_6.MONTH_CARD_EX_FIELD.type = 3
var_0_6.MONTH_CARD_EX_FIELD.cpp_type = 2
var_0_6.NEXT_FIND_FIELD.name = "next_find"
var_0_6.NEXT_FIND_FIELD.full_name = ".sgland.UserCount.next_find"
var_0_6.NEXT_FIND_FIELD.number = 44
var_0_6.NEXT_FIND_FIELD.index = 43
var_0_6.NEXT_FIND_FIELD.label = 2
var_0_6.NEXT_FIND_FIELD.has_default_value = false
var_0_6.NEXT_FIND_FIELD.default_value = 0
var_0_6.NEXT_FIND_FIELD.type = 3
var_0_6.NEXT_FIND_FIELD.cpp_type = 2
var_0_6.BUY_REFRESH_FIND_FIELD.name = "buy_refresh_find"
var_0_6.BUY_REFRESH_FIND_FIELD.full_name = ".sgland.UserCount.buy_refresh_find"
var_0_6.BUY_REFRESH_FIND_FIELD.number = 45
var_0_6.BUY_REFRESH_FIND_FIELD.index = 44
var_0_6.BUY_REFRESH_FIND_FIELD.label = 2
var_0_6.BUY_REFRESH_FIND_FIELD.has_default_value = false
var_0_6.BUY_REFRESH_FIND_FIELD.default_value = 0
var_0_6.BUY_REFRESH_FIND_FIELD.type = 5
var_0_6.BUY_REFRESH_FIND_FIELD.cpp_type = 1
var_0_6.GRACE_FIELD.name = "grace"
var_0_6.GRACE_FIELD.full_name = ".sgland.UserCount.grace"
var_0_6.GRACE_FIELD.number = 46
var_0_6.GRACE_FIELD.index = 45
var_0_6.GRACE_FIELD.label = 2
var_0_6.GRACE_FIELD.has_default_value = false
var_0_6.GRACE_FIELD.default_value = 0
var_0_6.GRACE_FIELD.type = 5
var_0_6.GRACE_FIELD.cpp_type = 1
var_0_6.ATK_UBOSS_FIELD.name = "atk_uboss"
var_0_6.ATK_UBOSS_FIELD.full_name = ".sgland.UserCount.atk_uboss"
var_0_6.ATK_UBOSS_FIELD.number = 47
var_0_6.ATK_UBOSS_FIELD.index = 46
var_0_6.ATK_UBOSS_FIELD.label = 2
var_0_6.ATK_UBOSS_FIELD.has_default_value = false
var_0_6.ATK_UBOSS_FIELD.default_value = 0
var_0_6.ATK_UBOSS_FIELD.type = 5
var_0_6.ATK_UBOSS_FIELD.cpp_type = 1
var_0_6.WELFARE_FIELD.name = "welfare"
var_0_6.WELFARE_FIELD.full_name = ".sgland.UserCount.welfare"
var_0_6.WELFARE_FIELD.number = 48
var_0_6.WELFARE_FIELD.index = 47
var_0_6.WELFARE_FIELD.label = 2
var_0_6.WELFARE_FIELD.has_default_value = false
var_0_6.WELFARE_FIELD.default_value = 0
var_0_6.WELFARE_FIELD.type = 5
var_0_6.WELFARE_FIELD.cpp_type = 1
var_0_6.BUY_REFRESH_LADDER_FIELD.name = "buy_refresh_ladder"
var_0_6.BUY_REFRESH_LADDER_FIELD.full_name = ".sgland.UserCount.buy_refresh_ladder"
var_0_6.BUY_REFRESH_LADDER_FIELD.number = 49
var_0_6.BUY_REFRESH_LADDER_FIELD.index = 48
var_0_6.BUY_REFRESH_LADDER_FIELD.label = 2
var_0_6.BUY_REFRESH_LADDER_FIELD.has_default_value = false
var_0_6.BUY_REFRESH_LADDER_FIELD.default_value = 0
var_0_6.BUY_REFRESH_LADDER_FIELD.type = 5
var_0_6.BUY_REFRESH_LADDER_FIELD.cpp_type = 1
var_0_6.ATK_PLAYER_FIELD.name = "atk_player"
var_0_6.ATK_PLAYER_FIELD.full_name = ".sgland.UserCount.atk_player"
var_0_6.ATK_PLAYER_FIELD.number = 50
var_0_6.ATK_PLAYER_FIELD.index = 49
var_0_6.ATK_PLAYER_FIELD.label = 2
var_0_6.ATK_PLAYER_FIELD.has_default_value = false
var_0_6.ATK_PLAYER_FIELD.default_value = 0
var_0_6.ATK_PLAYER_FIELD.type = 5
var_0_6.ATK_PLAYER_FIELD.cpp_type = 1
var_0_6.INVITE_CHARGE_FIELD.name = "invite_charge"
var_0_6.INVITE_CHARGE_FIELD.full_name = ".sgland.UserCount.invite_charge"
var_0_6.INVITE_CHARGE_FIELD.number = 51
var_0_6.INVITE_CHARGE_FIELD.index = 50
var_0_6.INVITE_CHARGE_FIELD.label = 2
var_0_6.INVITE_CHARGE_FIELD.has_default_value = false
var_0_6.INVITE_CHARGE_FIELD.default_value = 0
var_0_6.INVITE_CHARGE_FIELD.type = 5
var_0_6.INVITE_CHARGE_FIELD.cpp_type = 1
var_0_6.INVITE_COUNT_FIELD.name = "invite_count"
var_0_6.INVITE_COUNT_FIELD.full_name = ".sgland.UserCount.invite_count"
var_0_6.INVITE_COUNT_FIELD.number = 52
var_0_6.INVITE_COUNT_FIELD.index = 51
var_0_6.INVITE_COUNT_FIELD.label = 2
var_0_6.INVITE_COUNT_FIELD.has_default_value = false
var_0_6.INVITE_COUNT_FIELD.default_value = 0
var_0_6.INVITE_COUNT_FIELD.type = 5
var_0_6.INVITE_COUNT_FIELD.cpp_type = 1
var_0_6.RESET_LADDER_FIELD.name = "reset_ladder"
var_0_6.RESET_LADDER_FIELD.full_name = ".sgland.UserCount.reset_ladder"
var_0_6.RESET_LADDER_FIELD.number = 53
var_0_6.RESET_LADDER_FIELD.index = 52
var_0_6.RESET_LADDER_FIELD.label = 2
var_0_6.RESET_LADDER_FIELD.has_default_value = false
var_0_6.RESET_LADDER_FIELD.default_value = 0
var_0_6.RESET_LADDER_FIELD.type = 5
var_0_6.RESET_LADDER_FIELD.cpp_type = 1
var_0_6.CONSUME_FIELD.name = "consume"
var_0_6.CONSUME_FIELD.full_name = ".sgland.UserCount.consume"
var_0_6.CONSUME_FIELD.number = 54
var_0_6.CONSUME_FIELD.index = 53
var_0_6.CONSUME_FIELD.label = 2
var_0_6.CONSUME_FIELD.has_default_value = false
var_0_6.CONSUME_FIELD.default_value = 0
var_0_6.CONSUME_FIELD.type = 5
var_0_6.CONSUME_FIELD.cpp_type = 1
USERCOUNT.name = "UserCount"
USERCOUNT.full_name = ".sgland.UserCount"
USERCOUNT.nested_types = {}
USERCOUNT.enum_types = {}
USERCOUNT.fields = {
	var_0_6.BUY_GOLD_FIELD,
	var_0_6.BUY_GRAIN_FIELD,
	var_0_6.BUY_REFRESH_FIELD,
	var_0_6.BUY_CHEST1_FIELD,
	var_0_6.BUY_CHEST2_FIELD,
	var_0_6.BUY_CHEST3_FIELD,
	var_0_6.BUY_CHEST4_FIELD,
	var_0_6.BUY_HERO_EXP_FIELD,
	var_0_6.BUY_EQUIP_EXP_FIELD,
	var_0_6.BUY_HORSE_EXP_FIELD,
	var_0_6.BUY_BOOK_EXP_FIELD,
	var_0_6.BUY_COMMANDER_FIELD,
	var_0_6.BUY_ELITE_FIELD,
	var_0_6.BUY_EXPEDITION_FIELD,
	var_0_6.BUY_ROB_GOLD_FIELD,
	var_0_6.EDIT_NAME_FIELD,
	var_0_6.NEXT_SHARE_FIELD,
	var_0_6.CHALLENGE_COMMANDER_FIELD,
	var_0_6.CHALLENGE_ELITE_FIELD,
	var_0_6.EXPEDITION_FIELD,
	var_0_6.ROB_GOLD_FIELD,
	var_0_6.NEXT_CHAT_FIELD,
	var_0_6.SEND_MAIL_FIELD,
	var_0_6.MONTH_CARD_FIELD,
	var_0_6.COLLECT_GOLD_FIELD,
	var_0_6.CHARGE_FIELD,
	var_0_6.NEXT_SPAWN_FIELD,
	var_0_6.NEXT_SOS_FIELD,
	var_0_6.DONATE_FIELD,
	var_0_6.BUY_REMEDY_FIELD,
	var_0_6.BUY_STONE_FIELD,
	var_0_6.BUY_ROB_EXP_FIELD,
	var_0_6.ROB_EXP_FIELD,
	var_0_6.TROPHY_FIELD,
	var_0_6.DAILY_CHARGE_FIELD,
	var_0_6.WIN_ROB_GOLD_FIELD,
	var_0_6.WORSHIP_FIELD,
	var_0_6.BUY_REFRESH_PVP_FIELD,
	var_0_6.BUY_REFRESH_UNION_FIELD,
	var_0_6.ATK_BOSS_FIELD,
	var_0_6.BUY_ATK_BOSS_FIELD,
	var_0_6.RE_CHECK_FIELD,
	var_0_6.MONTH_CARD_EX_FIELD,
	var_0_6.NEXT_FIND_FIELD,
	var_0_6.BUY_REFRESH_FIND_FIELD,
	var_0_6.GRACE_FIELD,
	var_0_6.ATK_UBOSS_FIELD,
	var_0_6.WELFARE_FIELD,
	var_0_6.BUY_REFRESH_LADDER_FIELD,
	var_0_6.ATK_PLAYER_FIELD,
	var_0_6.INVITE_CHARGE_FIELD,
	var_0_6.INVITE_COUNT_FIELD,
	var_0_6.RESET_LADDER_FIELD,
	var_0_6.CONSUME_FIELD
}
USERCOUNT.is_extendable = false
USERCOUNT.extensions = {}
var_0_7.CODE_FIELD.name = "code"
var_0_7.CODE_FIELD.full_name = ".sgland.UserNotifyEvent.code"
var_0_7.CODE_FIELD.number = 1
var_0_7.CODE_FIELD.index = 0
var_0_7.CODE_FIELD.label = 2
var_0_7.CODE_FIELD.has_default_value = false
var_0_7.CODE_FIELD.default_value = ""
var_0_7.CODE_FIELD.type = 9
var_0_7.CODE_FIELD.cpp_type = 9
var_0_7.TYPE_FIELD.name = "type"
var_0_7.TYPE_FIELD.full_name = ".sgland.UserNotifyEvent.type"
var_0_7.TYPE_FIELD.number = 2
var_0_7.TYPE_FIELD.index = 1
var_0_7.TYPE_FIELD.label = 2
var_0_7.TYPE_FIELD.has_default_value = false
var_0_7.TYPE_FIELD.default_value = 0
var_0_7.TYPE_FIELD.type = 5
var_0_7.TYPE_FIELD.cpp_type = 1
var_0_7.PARAM_FIELD.name = "param"
var_0_7.PARAM_FIELD.full_name = ".sgland.UserNotifyEvent.param"
var_0_7.PARAM_FIELD.number = 3
var_0_7.PARAM_FIELD.index = 2
var_0_7.PARAM_FIELD.label = 2
var_0_7.PARAM_FIELD.has_default_value = false
var_0_7.PARAM_FIELD.default_value = 0
var_0_7.PARAM_FIELD.type = 5
var_0_7.PARAM_FIELD.cpp_type = 1
var_0_7.INFO_FIELD.name = "info"
var_0_7.INFO_FIELD.full_name = ".sgland.UserNotifyEvent.info"
var_0_7.INFO_FIELD.number = 4
var_0_7.INFO_FIELD.index = 3
var_0_7.INFO_FIELD.label = 1
var_0_7.INFO_FIELD.has_default_value = false
var_0_7.INFO_FIELD.default_value = nil
var_0_7.INFO_FIELD.message_type = var_0_2.ACCOUNTINFO
var_0_7.INFO_FIELD.type = 11
var_0_7.INFO_FIELD.cpp_type = 10
var_0_7.RENOTFIY_FIELD.name = "renotfiy"
var_0_7.RENOTFIY_FIELD.full_name = ".sgland.UserNotifyEvent.renotfiy"
var_0_7.RENOTFIY_FIELD.number = 5
var_0_7.RENOTFIY_FIELD.index = 4
var_0_7.RENOTFIY_FIELD.label = 1
var_0_7.RENOTFIY_FIELD.has_default_value = false
var_0_7.RENOTFIY_FIELD.default_value = false
var_0_7.RENOTFIY_FIELD.type = 8
var_0_7.RENOTFIY_FIELD.cpp_type = 7
USERNOTIFYEVENT.name = "UserNotifyEvent"
USERNOTIFYEVENT.full_name = ".sgland.UserNotifyEvent"
USERNOTIFYEVENT.nested_types = {}
USERNOTIFYEVENT.enum_types = {}
USERNOTIFYEVENT.fields = {
	var_0_7.CODE_FIELD,
	var_0_7.TYPE_FIELD,
	var_0_7.PARAM_FIELD,
	var_0_7.INFO_FIELD,
	var_0_7.RENOTFIY_FIELD
}
USERNOTIFYEVENT.is_extendable = false
USERNOTIFYEVENT.extensions = {}
var_0_8.CHANNEL_FIELD.name = "channel"
var_0_8.CHANNEL_FIELD.full_name = ".sgland.UserRegReq.channel"
var_0_8.CHANNEL_FIELD.number = 1
var_0_8.CHANNEL_FIELD.index = 0
var_0_8.CHANNEL_FIELD.label = 2
var_0_8.CHANNEL_FIELD.has_default_value = false
var_0_8.CHANNEL_FIELD.default_value = ""
var_0_8.CHANNEL_FIELD.type = 9
var_0_8.CHANNEL_FIELD.cpp_type = 9
var_0_8.RID_FIELD.name = "rid"
var_0_8.RID_FIELD.full_name = ".sgland.UserRegReq.rid"
var_0_8.RID_FIELD.number = 2
var_0_8.RID_FIELD.index = 1
var_0_8.RID_FIELD.label = 2
var_0_8.RID_FIELD.has_default_value = false
var_0_8.RID_FIELD.default_value = 0
var_0_8.RID_FIELD.type = 5
var_0_8.RID_FIELD.cpp_type = 1
var_0_8.UID_FIELD.name = "uid"
var_0_8.UID_FIELD.full_name = ".sgland.UserRegReq.uid"
var_0_8.UID_FIELD.number = 3
var_0_8.UID_FIELD.index = 2
var_0_8.UID_FIELD.label = 2
var_0_8.UID_FIELD.has_default_value = false
var_0_8.UID_FIELD.default_value = ""
var_0_8.UID_FIELD.type = 9
var_0_8.UID_FIELD.cpp_type = 9
var_0_8.VERSION_FIELD.name = "version"
var_0_8.VERSION_FIELD.full_name = ".sgland.UserRegReq.version"
var_0_8.VERSION_FIELD.number = 4
var_0_8.VERSION_FIELD.index = 3
var_0_8.VERSION_FIELD.label = 1
var_0_8.VERSION_FIELD.has_default_value = false
var_0_8.VERSION_FIELD.default_value = ""
var_0_8.VERSION_FIELD.type = 9
var_0_8.VERSION_FIELD.cpp_type = 9
var_0_8.CID_FIELD.name = "cid"
var_0_8.CID_FIELD.full_name = ".sgland.UserRegReq.cid"
var_0_8.CID_FIELD.number = 5
var_0_8.CID_FIELD.index = 4
var_0_8.CID_FIELD.label = 1
var_0_8.CID_FIELD.has_default_value = false
var_0_8.CID_FIELD.default_value = ""
var_0_8.CID_FIELD.type = 9
var_0_8.CID_FIELD.cpp_type = 9
var_0_8.DEVICE_INFO_FIELD.name = "device_info"
var_0_8.DEVICE_INFO_FIELD.full_name = ".sgland.UserRegReq.device_info"
var_0_8.DEVICE_INFO_FIELD.number = 6
var_0_8.DEVICE_INFO_FIELD.index = 5
var_0_8.DEVICE_INFO_FIELD.label = 1
var_0_8.DEVICE_INFO_FIELD.has_default_value = false
var_0_8.DEVICE_INFO_FIELD.default_value = ""
var_0_8.DEVICE_INFO_FIELD.type = 9
var_0_8.DEVICE_INFO_FIELD.cpp_type = 9
var_0_8.BINARY_VERSION_FIELD.name = "binary_version"
var_0_8.BINARY_VERSION_FIELD.full_name = ".sgland.UserRegReq.binary_version"
var_0_8.BINARY_VERSION_FIELD.number = 7
var_0_8.BINARY_VERSION_FIELD.index = 6
var_0_8.BINARY_VERSION_FIELD.label = 1
var_0_8.BINARY_VERSION_FIELD.has_default_value = false
var_0_8.BINARY_VERSION_FIELD.default_value = ""
var_0_8.BINARY_VERSION_FIELD.type = 9
var_0_8.BINARY_VERSION_FIELD.cpp_type = 9
var_0_8.IDFA_FIELD.name = "idfa"
var_0_8.IDFA_FIELD.full_name = ".sgland.UserRegReq.idfa"
var_0_8.IDFA_FIELD.number = 8
var_0_8.IDFA_FIELD.index = 7
var_0_8.IDFA_FIELD.label = 1
var_0_8.IDFA_FIELD.has_default_value = false
var_0_8.IDFA_FIELD.default_value = ""
var_0_8.IDFA_FIELD.type = 9
var_0_8.IDFA_FIELD.cpp_type = 9
var_0_8.APPID_FIELD.name = "appid"
var_0_8.APPID_FIELD.full_name = ".sgland.UserRegReq.appid"
var_0_8.APPID_FIELD.number = 9
var_0_8.APPID_FIELD.index = 8
var_0_8.APPID_FIELD.label = 1
var_0_8.APPID_FIELD.has_default_value = false
var_0_8.APPID_FIELD.default_value = ""
var_0_8.APPID_FIELD.type = 9
var_0_8.APPID_FIELD.cpp_type = 9
var_0_8.TIMESTAMP_FIELD.name = "timestamp"
var_0_8.TIMESTAMP_FIELD.full_name = ".sgland.UserRegReq.timestamp"
var_0_8.TIMESTAMP_FIELD.number = 10
var_0_8.TIMESTAMP_FIELD.index = 9
var_0_8.TIMESTAMP_FIELD.label = 1
var_0_8.TIMESTAMP_FIELD.has_default_value = false
var_0_8.TIMESTAMP_FIELD.default_value = 0
var_0_8.TIMESTAMP_FIELD.type = 3
var_0_8.TIMESTAMP_FIELD.cpp_type = 2
USERREGREQ.name = "UserRegReq"
USERREGREQ.full_name = ".sgland.UserRegReq"
USERREGREQ.nested_types = {}
USERREGREQ.enum_types = {}
USERREGREQ.fields = {
	var_0_8.CHANNEL_FIELD,
	var_0_8.RID_FIELD,
	var_0_8.UID_FIELD,
	var_0_8.VERSION_FIELD,
	var_0_8.CID_FIELD,
	var_0_8.DEVICE_INFO_FIELD,
	var_0_8.BINARY_VERSION_FIELD,
	var_0_8.IDFA_FIELD,
	var_0_8.APPID_FIELD,
	var_0_8.TIMESTAMP_FIELD
}
USERREGREQ.is_extendable = false
USERREGREQ.extensions = {}
var_0_9.SUB_CHANNEL_FIELD.name = "sub_channel"
var_0_9.SUB_CHANNEL_FIELD.full_name = ".sgland.UserOppoVipReq.sub_channel"
var_0_9.SUB_CHANNEL_FIELD.number = 1
var_0_9.SUB_CHANNEL_FIELD.index = 0
var_0_9.SUB_CHANNEL_FIELD.label = 1
var_0_9.SUB_CHANNEL_FIELD.has_default_value = false
var_0_9.SUB_CHANNEL_FIELD.default_value = ""
var_0_9.SUB_CHANNEL_FIELD.type = 9
var_0_9.SUB_CHANNEL_FIELD.cpp_type = 9
var_0_9.CHANNEL_UID_FIELD.name = "channel_uid"
var_0_9.CHANNEL_UID_FIELD.full_name = ".sgland.UserOppoVipReq.channel_uid"
var_0_9.CHANNEL_UID_FIELD.number = 2
var_0_9.CHANNEL_UID_FIELD.index = 1
var_0_9.CHANNEL_UID_FIELD.label = 1
var_0_9.CHANNEL_UID_FIELD.has_default_value = false
var_0_9.CHANNEL_UID_FIELD.default_value = ""
var_0_9.CHANNEL_UID_FIELD.type = 9
var_0_9.CHANNEL_UID_FIELD.cpp_type = 9
USEROPPOVIPREQ.name = "UserOppoVipReq"
USEROPPOVIPREQ.full_name = ".sgland.UserOppoVipReq"
USEROPPOVIPREQ.nested_types = {}
USEROPPOVIPREQ.enum_types = {}
USEROPPOVIPREQ.fields = {
	var_0_9.SUB_CHANNEL_FIELD,
	var_0_9.CHANNEL_UID_FIELD
}
USEROPPOVIPREQ.is_extendable = false
USEROPPOVIPREQ.extensions = {}
var_0_10.USER_ID_FIELD.name = "user_id"
var_0_10.USER_ID_FIELD.full_name = ".sgland.UserLoginReq.user_id"
var_0_10.USER_ID_FIELD.number = 1
var_0_10.USER_ID_FIELD.index = 0
var_0_10.USER_ID_FIELD.label = 2
var_0_10.USER_ID_FIELD.has_default_value = false
var_0_10.USER_ID_FIELD.default_value = 0
var_0_10.USER_ID_FIELD.type = 3
var_0_10.USER_ID_FIELD.cpp_type = 2
var_0_10.VERSION_FIELD.name = "version"
var_0_10.VERSION_FIELD.full_name = ".sgland.UserLoginReq.version"
var_0_10.VERSION_FIELD.number = 2
var_0_10.VERSION_FIELD.index = 1
var_0_10.VERSION_FIELD.label = 1
var_0_10.VERSION_FIELD.has_default_value = false
var_0_10.VERSION_FIELD.default_value = ""
var_0_10.VERSION_FIELD.type = 9
var_0_10.VERSION_FIELD.cpp_type = 9
var_0_10.CID_FIELD.name = "cid"
var_0_10.CID_FIELD.full_name = ".sgland.UserLoginReq.cid"
var_0_10.CID_FIELD.number = 3
var_0_10.CID_FIELD.index = 2
var_0_10.CID_FIELD.label = 1
var_0_10.CID_FIELD.has_default_value = false
var_0_10.CID_FIELD.default_value = ""
var_0_10.CID_FIELD.type = 9
var_0_10.CID_FIELD.cpp_type = 9
var_0_10.DEVICE_INFO_FIELD.name = "device_info"
var_0_10.DEVICE_INFO_FIELD.full_name = ".sgland.UserLoginReq.device_info"
var_0_10.DEVICE_INFO_FIELD.number = 4
var_0_10.DEVICE_INFO_FIELD.index = 3
var_0_10.DEVICE_INFO_FIELD.label = 1
var_0_10.DEVICE_INFO_FIELD.has_default_value = false
var_0_10.DEVICE_INFO_FIELD.default_value = ""
var_0_10.DEVICE_INFO_FIELD.type = 9
var_0_10.DEVICE_INFO_FIELD.cpp_type = 9
var_0_10.BINARY_VERSION_FIELD.name = "binary_version"
var_0_10.BINARY_VERSION_FIELD.full_name = ".sgland.UserLoginReq.binary_version"
var_0_10.BINARY_VERSION_FIELD.number = 5
var_0_10.BINARY_VERSION_FIELD.index = 4
var_0_10.BINARY_VERSION_FIELD.label = 1
var_0_10.BINARY_VERSION_FIELD.has_default_value = false
var_0_10.BINARY_VERSION_FIELD.default_value = ""
var_0_10.BINARY_VERSION_FIELD.type = 9
var_0_10.BINARY_VERSION_FIELD.cpp_type = 9
var_0_10.CODE_FIELD.name = "code"
var_0_10.CODE_FIELD.full_name = ".sgland.UserLoginReq.code"
var_0_10.CODE_FIELD.number = 6
var_0_10.CODE_FIELD.index = 5
var_0_10.CODE_FIELD.label = 1
var_0_10.CODE_FIELD.has_default_value = false
var_0_10.CODE_FIELD.default_value = ""
var_0_10.CODE_FIELD.type = 9
var_0_10.CODE_FIELD.cpp_type = 9
USERLOGINREQ.name = "UserLoginReq"
USERLOGINREQ.full_name = ".sgland.UserLoginReq"
USERLOGINREQ.nested_types = {}
USERLOGINREQ.enum_types = {}
USERLOGINREQ.fields = {
	var_0_10.USER_ID_FIELD,
	var_0_10.VERSION_FIELD,
	var_0_10.CID_FIELD,
	var_0_10.DEVICE_INFO_FIELD,
	var_0_10.BINARY_VERSION_FIELD,
	var_0_10.CODE_FIELD
}
USERLOGINREQ.is_extendable = false
USERLOGINREQ.extensions = {}
var_0_11.ID_FIELD.name = "id"
var_0_11.ID_FIELD.full_name = ".sgland.UserOpenChestReq.id"
var_0_11.ID_FIELD.number = 1
var_0_11.ID_FIELD.index = 0
var_0_11.ID_FIELD.label = 2
var_0_11.ID_FIELD.has_default_value = false
var_0_11.ID_FIELD.default_value = 0
var_0_11.ID_FIELD.type = 5
var_0_11.ID_FIELD.cpp_type = 1
var_0_11.NUM_FIELD.name = "num"
var_0_11.NUM_FIELD.full_name = ".sgland.UserOpenChestReq.num"
var_0_11.NUM_FIELD.number = 2
var_0_11.NUM_FIELD.index = 1
var_0_11.NUM_FIELD.label = 2
var_0_11.NUM_FIELD.has_default_value = false
var_0_11.NUM_FIELD.default_value = 0
var_0_11.NUM_FIELD.type = 5
var_0_11.NUM_FIELD.cpp_type = 1
USEROPENCHESTREQ.name = "UserOpenChestReq"
USEROPENCHESTREQ.full_name = ".sgland.UserOpenChestReq"
USEROPENCHESTREQ.nested_types = {}
USEROPENCHESTREQ.enum_types = {}
USEROPENCHESTREQ.fields = {
	var_0_11.ID_FIELD,
	var_0_11.NUM_FIELD
}
USEROPENCHESTREQ.is_extendable = false
USEROPENCHESTREQ.extensions = {}
var_0_12.CHAR_ID_FIELD.name = "char_id"
var_0_12.CHAR_ID_FIELD.full_name = ".sgland.UserUnlockCharacterReq.char_id"
var_0_12.CHAR_ID_FIELD.number = 1
var_0_12.CHAR_ID_FIELD.index = 0
var_0_12.CHAR_ID_FIELD.label = 2
var_0_12.CHAR_ID_FIELD.has_default_value = false
var_0_12.CHAR_ID_FIELD.default_value = 0
var_0_12.CHAR_ID_FIELD.type = 5
var_0_12.CHAR_ID_FIELD.cpp_type = 1
var_0_12.USE_INGOT_FIELD.name = "use_ingot"
var_0_12.USE_INGOT_FIELD.full_name = ".sgland.UserUnlockCharacterReq.use_ingot"
var_0_12.USE_INGOT_FIELD.number = 2
var_0_12.USE_INGOT_FIELD.index = 1
var_0_12.USE_INGOT_FIELD.label = 2
var_0_12.USE_INGOT_FIELD.has_default_value = false
var_0_12.USE_INGOT_FIELD.default_value = false
var_0_12.USE_INGOT_FIELD.type = 8
var_0_12.USE_INGOT_FIELD.cpp_type = 7
USERUNLOCKCHARACTERREQ.name = "UserUnlockCharacterReq"
USERUNLOCKCHARACTERREQ.full_name = ".sgland.UserUnlockCharacterReq"
USERUNLOCKCHARACTERREQ.nested_types = {}
USERUNLOCKCHARACTERREQ.enum_types = {}
USERUNLOCKCHARACTERREQ.fields = {
	var_0_12.CHAR_ID_FIELD,
	var_0_12.USE_INGOT_FIELD
}
USERUNLOCKCHARACTERREQ.is_extendable = false
USERUNLOCKCHARACTERREQ.extensions = {}
var_0_13.INFO_ID_FIELD.name = "info_id"
var_0_13.INFO_ID_FIELD.full_name = ".sgland.UserSetSkinReq.info_id"
var_0_13.INFO_ID_FIELD.number = 1
var_0_13.INFO_ID_FIELD.index = 0
var_0_13.INFO_ID_FIELD.label = 2
var_0_13.INFO_ID_FIELD.has_default_value = false
var_0_13.INFO_ID_FIELD.default_value = 0
var_0_13.INFO_ID_FIELD.type = 5
var_0_13.INFO_ID_FIELD.cpp_type = 1
var_0_13.SKIN_ID_FIELD.name = "skin_id"
var_0_13.SKIN_ID_FIELD.full_name = ".sgland.UserSetSkinReq.skin_id"
var_0_13.SKIN_ID_FIELD.number = 2
var_0_13.SKIN_ID_FIELD.index = 1
var_0_13.SKIN_ID_FIELD.label = 2
var_0_13.SKIN_ID_FIELD.has_default_value = false
var_0_13.SKIN_ID_FIELD.default_value = 0
var_0_13.SKIN_ID_FIELD.type = 5
var_0_13.SKIN_ID_FIELD.cpp_type = 1
USERSETSKINREQ.name = "UserSetSkinReq"
USERSETSKINREQ.full_name = ".sgland.UserSetSkinReq"
USERSETSKINREQ.nested_types = {}
USERSETSKINREQ.enum_types = {}
USERSETSKINREQ.fields = {
	var_0_13.INFO_ID_FIELD,
	var_0_13.SKIN_ID_FIELD
}
USERSETSKINREQ.is_extendable = false
USERSETSKINREQ.extensions = {}
var_0_14.USER_INFO_FIELD.name = "user_info"
var_0_14.USER_INFO_FIELD.full_name = ".sgland.UserInResp.user_info"
var_0_14.USER_INFO_FIELD.number = 1
var_0_14.USER_INFO_FIELD.index = 0
var_0_14.USER_INFO_FIELD.label = 2
var_0_14.USER_INFO_FIELD.has_default_value = false
var_0_14.USER_INFO_FIELD.default_value = nil
var_0_14.USER_INFO_FIELD.message_type = FULLUSERINFO
var_0_14.USER_INFO_FIELD.type = 11
var_0_14.USER_INFO_FIELD.cpp_type = 10
var_0_14.CARD_FIELD.name = "card"
var_0_14.CARD_FIELD.full_name = ".sgland.UserInResp.card"
var_0_14.CARD_FIELD.number = 2
var_0_14.CARD_FIELD.index = 1
var_0_14.CARD_FIELD.label = 2
var_0_14.CARD_FIELD.has_default_value = false
var_0_14.CARD_FIELD.default_value = nil
var_0_14.CARD_FIELD.message_type = var_0_2.PLAYERCARD
var_0_14.CARD_FIELD.type = 11
var_0_14.CARD_FIELD.cpp_type = 10
var_0_14.ATTACH_FIELD.name = "attach"
var_0_14.ATTACH_FIELD.full_name = ".sgland.UserInResp.attach"
var_0_14.ATTACH_FIELD.number = 3
var_0_14.ATTACH_FIELD.index = 2
var_0_14.ATTACH_FIELD.label = 2
var_0_14.ATTACH_FIELD.has_default_value = false
var_0_14.ATTACH_FIELD.default_value = nil
var_0_14.ATTACH_FIELD.message_type = var_0_2.ATTACHDATA
var_0_14.ATTACH_FIELD.type = 11
var_0_14.ATTACH_FIELD.cpp_type = 10
var_0_14.CITY_FIELD.name = "city"
var_0_14.CITY_FIELD.full_name = ".sgland.UserInResp.city"
var_0_14.CITY_FIELD.number = 4
var_0_14.CITY_FIELD.index = 3
var_0_14.CITY_FIELD.label = 2
var_0_14.CITY_FIELD.has_default_value = false
var_0_14.CITY_FIELD.default_value = nil
var_0_14.CITY_FIELD.message_type = var_0_2.PLAYERCITY
var_0_14.CITY_FIELD.type = 11
var_0_14.CITY_FIELD.cpp_type = 10
var_0_14.WORLD_FIELD.name = "world"
var_0_14.WORLD_FIELD.full_name = ".sgland.UserInResp.world"
var_0_14.WORLD_FIELD.number = 5
var_0_14.WORLD_FIELD.index = 4
var_0_14.WORLD_FIELD.label = 2
var_0_14.WORLD_FIELD.has_default_value = false
var_0_14.WORLD_FIELD.default_value = nil
var_0_14.WORLD_FIELD.message_type = var_0_2.PLAYERWORLD
var_0_14.WORLD_FIELD.type = 11
var_0_14.WORLD_FIELD.cpp_type = 10
var_0_14.USER_BATTLE_FIELD.name = "user_battle"
var_0_14.USER_BATTLE_FIELD.full_name = ".sgland.UserInResp.user_battle"
var_0_14.USER_BATTLE_FIELD.number = 6
var_0_14.USER_BATTLE_FIELD.index = 5
var_0_14.USER_BATTLE_FIELD.label = 2
var_0_14.USER_BATTLE_FIELD.has_default_value = false
var_0_14.USER_BATTLE_FIELD.default_value = nil
var_0_14.USER_BATTLE_FIELD.message_type = USERBATTLE
var_0_14.USER_BATTLE_FIELD.type = 11
var_0_14.USER_BATTLE_FIELD.cpp_type = 10
var_0_14.USER_LOTTERY_FIELD.name = "user_lottery"
var_0_14.USER_LOTTERY_FIELD.full_name = ".sgland.UserInResp.user_lottery"
var_0_14.USER_LOTTERY_FIELD.number = 7
var_0_14.USER_LOTTERY_FIELD.index = 6
var_0_14.USER_LOTTERY_FIELD.label = 2
var_0_14.USER_LOTTERY_FIELD.has_default_value = false
var_0_14.USER_LOTTERY_FIELD.default_value = nil
var_0_14.USER_LOTTERY_FIELD.message_type = USERLOTTERY
var_0_14.USER_LOTTERY_FIELD.type = 11
var_0_14.USER_LOTTERY_FIELD.cpp_type = 10
var_0_14.USER_COUNT_FIELD.name = "user_count"
var_0_14.USER_COUNT_FIELD.full_name = ".sgland.UserInResp.user_count"
var_0_14.USER_COUNT_FIELD.number = 8
var_0_14.USER_COUNT_FIELD.index = 7
var_0_14.USER_COUNT_FIELD.label = 2
var_0_14.USER_COUNT_FIELD.has_default_value = false
var_0_14.USER_COUNT_FIELD.default_value = nil
var_0_14.USER_COUNT_FIELD.message_type = USERCOUNT
var_0_14.USER_COUNT_FIELD.type = 11
var_0_14.USER_COUNT_FIELD.cpp_type = 10
var_0_14.ANNOUNCEMENT_FIELD.name = "announcement"
var_0_14.ANNOUNCEMENT_FIELD.full_name = ".sgland.UserInResp.announcement"
var_0_14.ANNOUNCEMENT_FIELD.number = 9
var_0_14.ANNOUNCEMENT_FIELD.index = 8
var_0_14.ANNOUNCEMENT_FIELD.label = 2
var_0_14.ANNOUNCEMENT_FIELD.has_default_value = false
var_0_14.ANNOUNCEMENT_FIELD.default_value = ""
var_0_14.ANNOUNCEMENT_FIELD.type = 9
var_0_14.ANNOUNCEMENT_FIELD.cpp_type = 9
var_0_14.TIME_OFFSET_FIELD.name = "time_offset"
var_0_14.TIME_OFFSET_FIELD.full_name = ".sgland.UserInResp.time_offset"
var_0_14.TIME_OFFSET_FIELD.number = 10
var_0_14.TIME_OFFSET_FIELD.index = 9
var_0_14.TIME_OFFSET_FIELD.label = 2
var_0_14.TIME_OFFSET_FIELD.has_default_value = false
var_0_14.TIME_OFFSET_FIELD.default_value = 0
var_0_14.TIME_OFFSET_FIELD.type = 3
var_0_14.TIME_OFFSET_FIELD.cpp_type = 2
var_0_14.TIME_OF_ANN_FIELD.name = "time_of_ann"
var_0_14.TIME_OF_ANN_FIELD.full_name = ".sgland.UserInResp.time_of_ann"
var_0_14.TIME_OF_ANN_FIELD.number = 11
var_0_14.TIME_OF_ANN_FIELD.index = 10
var_0_14.TIME_OF_ANN_FIELD.label = 2
var_0_14.TIME_OF_ANN_FIELD.has_default_value = false
var_0_14.TIME_OF_ANN_FIELD.default_value = 0
var_0_14.TIME_OF_ANN_FIELD.type = 3
var_0_14.TIME_OF_ANN_FIELD.cpp_type = 2
var_0_14.IS_IN_BATTLE_FIELD.name = "is_in_battle"
var_0_14.IS_IN_BATTLE_FIELD.full_name = ".sgland.UserInResp.is_in_battle"
var_0_14.IS_IN_BATTLE_FIELD.number = 12
var_0_14.IS_IN_BATTLE_FIELD.index = 11
var_0_14.IS_IN_BATTLE_FIELD.label = 1
var_0_14.IS_IN_BATTLE_FIELD.has_default_value = true
var_0_14.IS_IN_BATTLE_FIELD.default_value = false
var_0_14.IS_IN_BATTLE_FIELD.type = 8
var_0_14.IS_IN_BATTLE_FIELD.cpp_type = 7
var_0_14.UNION_FIELD.name = "union"
var_0_14.UNION_FIELD.full_name = ".sgland.UserInResp.union"
var_0_14.UNION_FIELD.number = 13
var_0_14.UNION_FIELD.index = 12
var_0_14.UNION_FIELD.label = 1
var_0_14.UNION_FIELD.has_default_value = false
var_0_14.UNION_FIELD.default_value = nil
var_0_14.UNION_FIELD.message_type = var_0_2.UNIONMINI
var_0_14.UNION_FIELD.type = 11
var_0_14.UNION_FIELD.cpp_type = 10
var_0_14.OPEN_TIME_FIELD.name = "open_time"
var_0_14.OPEN_TIME_FIELD.full_name = ".sgland.UserInResp.open_time"
var_0_14.OPEN_TIME_FIELD.number = 14
var_0_14.OPEN_TIME_FIELD.index = 13
var_0_14.OPEN_TIME_FIELD.label = 2
var_0_14.OPEN_TIME_FIELD.has_default_value = false
var_0_14.OPEN_TIME_FIELD.default_value = 0
var_0_14.OPEN_TIME_FIELD.type = 3
var_0_14.OPEN_TIME_FIELD.cpp_type = 2
var_0_14.BAN_CHAT_FIELD.name = "ban_chat"
var_0_14.BAN_CHAT_FIELD.full_name = ".sgland.UserInResp.ban_chat"
var_0_14.BAN_CHAT_FIELD.number = 15
var_0_14.BAN_CHAT_FIELD.index = 14
var_0_14.BAN_CHAT_FIELD.label = 3
var_0_14.BAN_CHAT_FIELD.has_default_value = false
var_0_14.BAN_CHAT_FIELD.default_value = {}
var_0_14.BAN_CHAT_FIELD.type = 3
var_0_14.BAN_CHAT_FIELD.cpp_type = 2
var_0_14.CAN_BIND_FIELD.name = "can_bind"
var_0_14.CAN_BIND_FIELD.full_name = ".sgland.UserInResp.can_bind"
var_0_14.CAN_BIND_FIELD.number = 16
var_0_14.CAN_BIND_FIELD.index = 15
var_0_14.CAN_BIND_FIELD.label = 2
var_0_14.CAN_BIND_FIELD.has_default_value = false
var_0_14.CAN_BIND_FIELD.default_value = false
var_0_14.CAN_BIND_FIELD.type = 8
var_0_14.CAN_BIND_FIELD.cpp_type = 7
var_0_14.FUNCTION_SWITCH_FIELD.name = "function_switch"
var_0_14.FUNCTION_SWITCH_FIELD.full_name = ".sgland.UserInResp.function_switch"
var_0_14.FUNCTION_SWITCH_FIELD.number = 17
var_0_14.FUNCTION_SWITCH_FIELD.index = 16
var_0_14.FUNCTION_SWITCH_FIELD.label = 1
var_0_14.FUNCTION_SWITCH_FIELD.has_default_value = false
var_0_14.FUNCTION_SWITCH_FIELD.default_value = 0
var_0_14.FUNCTION_SWITCH_FIELD.type = 5
var_0_14.FUNCTION_SWITCH_FIELD.cpp_type = 1
var_0_14.IS_IN_MATCH_FIELD.name = "is_in_match"
var_0_14.IS_IN_MATCH_FIELD.full_name = ".sgland.UserInResp.is_in_match"
var_0_14.IS_IN_MATCH_FIELD.number = 18
var_0_14.IS_IN_MATCH_FIELD.index = 17
var_0_14.IS_IN_MATCH_FIELD.label = 1
var_0_14.IS_IN_MATCH_FIELD.has_default_value = true
var_0_14.IS_IN_MATCH_FIELD.default_value = false
var_0_14.IS_IN_MATCH_FIELD.type = 8
var_0_14.IS_IN_MATCH_FIELD.cpp_type = 7
var_0_14.TEAM_MEMBER_UPLIMIT_FIELD.name = "team_member_uplimit"
var_0_14.TEAM_MEMBER_UPLIMIT_FIELD.full_name = ".sgland.UserInResp.team_member_uplimit"
var_0_14.TEAM_MEMBER_UPLIMIT_FIELD.number = 19
var_0_14.TEAM_MEMBER_UPLIMIT_FIELD.index = 18
var_0_14.TEAM_MEMBER_UPLIMIT_FIELD.label = 1
var_0_14.TEAM_MEMBER_UPLIMIT_FIELD.has_default_value = false
var_0_14.TEAM_MEMBER_UPLIMIT_FIELD.default_value = 0
var_0_14.TEAM_MEMBER_UPLIMIT_FIELD.type = 5
var_0_14.TEAM_MEMBER_UPLIMIT_FIELD.cpp_type = 1
var_0_14.IS_IN_HALL_FIELD.name = "is_in_hall"
var_0_14.IS_IN_HALL_FIELD.full_name = ".sgland.UserInResp.is_in_hall"
var_0_14.IS_IN_HALL_FIELD.number = 20
var_0_14.IS_IN_HALL_FIELD.index = 19
var_0_14.IS_IN_HALL_FIELD.label = 1
var_0_14.IS_IN_HALL_FIELD.has_default_value = true
var_0_14.IS_IN_HALL_FIELD.default_value = false
var_0_14.IS_IN_HALL_FIELD.type = 8
var_0_14.IS_IN_HALL_FIELD.cpp_type = 7
var_0_14.SERVER_OPEN_TIME_FIELD.name = "server_open_time"
var_0_14.SERVER_OPEN_TIME_FIELD.full_name = ".sgland.UserInResp.server_open_time"
var_0_14.SERVER_OPEN_TIME_FIELD.number = 21
var_0_14.SERVER_OPEN_TIME_FIELD.index = 20
var_0_14.SERVER_OPEN_TIME_FIELD.label = 1
var_0_14.SERVER_OPEN_TIME_FIELD.has_default_value = false
var_0_14.SERVER_OPEN_TIME_FIELD.default_value = 0
var_0_14.SERVER_OPEN_TIME_FIELD.type = 3
var_0_14.SERVER_OPEN_TIME_FIELD.cpp_type = 2
var_0_14.SERVER_VERSION_FIELD.name = "server_version"
var_0_14.SERVER_VERSION_FIELD.full_name = ".sgland.UserInResp.server_version"
var_0_14.SERVER_VERSION_FIELD.number = 22
var_0_14.SERVER_VERSION_FIELD.index = 21
var_0_14.SERVER_VERSION_FIELD.label = 1
var_0_14.SERVER_VERSION_FIELD.has_default_value = false
var_0_14.SERVER_VERSION_FIELD.default_value = ""
var_0_14.SERVER_VERSION_FIELD.type = 9
var_0_14.SERVER_VERSION_FIELD.cpp_type = 9
USERINRESP.name = "UserInResp"
USERINRESP.full_name = ".sgland.UserInResp"
USERINRESP.nested_types = {}
USERINRESP.enum_types = {}
USERINRESP.fields = {
	var_0_14.USER_INFO_FIELD,
	var_0_14.CARD_FIELD,
	var_0_14.ATTACH_FIELD,
	var_0_14.CITY_FIELD,
	var_0_14.WORLD_FIELD,
	var_0_14.USER_BATTLE_FIELD,
	var_0_14.USER_LOTTERY_FIELD,
	var_0_14.USER_COUNT_FIELD,
	var_0_14.ANNOUNCEMENT_FIELD,
	var_0_14.TIME_OFFSET_FIELD,
	var_0_14.TIME_OF_ANN_FIELD,
	var_0_14.IS_IN_BATTLE_FIELD,
	var_0_14.UNION_FIELD,
	var_0_14.OPEN_TIME_FIELD,
	var_0_14.BAN_CHAT_FIELD,
	var_0_14.CAN_BIND_FIELD,
	var_0_14.FUNCTION_SWITCH_FIELD,
	var_0_14.IS_IN_MATCH_FIELD,
	var_0_14.TEAM_MEMBER_UPLIMIT_FIELD,
	var_0_14.IS_IN_HALL_FIELD,
	var_0_14.SERVER_OPEN_TIME_FIELD,
	var_0_14.SERVER_VERSION_FIELD
}
USERINRESP.is_extendable = false
USERINRESP.extensions = {}
var_0_15.USER_INFO_FIELD.name = "user_info"
var_0_15.USER_INFO_FIELD.full_name = ".sgland.UserVisitResp.user_info"
var_0_15.USER_INFO_FIELD.number = 1
var_0_15.USER_INFO_FIELD.index = 0
var_0_15.USER_INFO_FIELD.label = 2
var_0_15.USER_INFO_FIELD.has_default_value = false
var_0_15.USER_INFO_FIELD.default_value = nil
var_0_15.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_15.USER_INFO_FIELD.type = 11
var_0_15.USER_INFO_FIELD.cpp_type = 10
var_0_15.TROOP_FIELD.name = "troop"
var_0_15.TROOP_FIELD.full_name = ".sgland.UserVisitResp.troop"
var_0_15.TROOP_FIELD.number = 2
var_0_15.TROOP_FIELD.index = 1
var_0_15.TROOP_FIELD.label = 3
var_0_15.TROOP_FIELD.has_default_value = false
var_0_15.TROOP_FIELD.default_value = {}
var_0_15.TROOP_FIELD.message_type = var_0_2.RESOURCE
var_0_15.TROOP_FIELD.type = 11
var_0_15.TROOP_FIELD.cpp_type = 10
var_0_15.POWER_FIELD.name = "power"
var_0_15.POWER_FIELD.full_name = ".sgland.UserVisitResp.power"
var_0_15.POWER_FIELD.number = 3
var_0_15.POWER_FIELD.index = 2
var_0_15.POWER_FIELD.label = 2
var_0_15.POWER_FIELD.has_default_value = false
var_0_15.POWER_FIELD.default_value = 0
var_0_15.POWER_FIELD.type = 5
var_0_15.POWER_FIELD.cpp_type = 1
USERVISITRESP.name = "UserVisitResp"
USERVISITRESP.full_name = ".sgland.UserVisitResp"
USERVISITRESP.nested_types = {}
USERVISITRESP.enum_types = {}
USERVISITRESP.fields = {
	var_0_15.USER_INFO_FIELD,
	var_0_15.TROOP_FIELD,
	var_0_15.POWER_FIELD
}
USERVISITRESP.is_extendable = false
USERVISITRESP.extensions = {}
var_0_16.USER_INFO_FIELD.name = "user_info"
var_0_16.USER_INFO_FIELD.full_name = ".sgland.UserVisitExResp.user_info"
var_0_16.USER_INFO_FIELD.number = 1
var_0_16.USER_INFO_FIELD.index = 0
var_0_16.USER_INFO_FIELD.label = 2
var_0_16.USER_INFO_FIELD.has_default_value = false
var_0_16.USER_INFO_FIELD.default_value = nil
var_0_16.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_16.USER_INFO_FIELD.type = 11
var_0_16.USER_INFO_FIELD.cpp_type = 10
var_0_16.PRE_RANK_FIELD.name = "pre_rank"
var_0_16.PRE_RANK_FIELD.full_name = ".sgland.UserVisitExResp.pre_rank"
var_0_16.PRE_RANK_FIELD.number = 2
var_0_16.PRE_RANK_FIELD.index = 1
var_0_16.PRE_RANK_FIELD.label = 2
var_0_16.PRE_RANK_FIELD.has_default_value = false
var_0_16.PRE_RANK_FIELD.default_value = 0
var_0_16.PRE_RANK_FIELD.type = 5
var_0_16.PRE_RANK_FIELD.cpp_type = 1
var_0_16.BEST_RANK_FIELD.name = "best_rank"
var_0_16.BEST_RANK_FIELD.full_name = ".sgland.UserVisitExResp.best_rank"
var_0_16.BEST_RANK_FIELD.number = 3
var_0_16.BEST_RANK_FIELD.index = 2
var_0_16.BEST_RANK_FIELD.label = 2
var_0_16.BEST_RANK_FIELD.has_default_value = false
var_0_16.BEST_RANK_FIELD.default_value = 0
var_0_16.BEST_RANK_FIELD.type = 5
var_0_16.BEST_RANK_FIELD.cpp_type = 1
var_0_16.LEGEND_TROPHY_FIELD.name = "legend_trophy"
var_0_16.LEGEND_TROPHY_FIELD.full_name = ".sgland.UserVisitExResp.legend_trophy"
var_0_16.LEGEND_TROPHY_FIELD.number = 4
var_0_16.LEGEND_TROPHY_FIELD.index = 3
var_0_16.LEGEND_TROPHY_FIELD.label = 2
var_0_16.LEGEND_TROPHY_FIELD.has_default_value = false
var_0_16.LEGEND_TROPHY_FIELD.default_value = 0
var_0_16.LEGEND_TROPHY_FIELD.type = 5
var_0_16.LEGEND_TROPHY_FIELD.cpp_type = 1
var_0_16.PRE_LEGEND_RANK_FIELD.name = "pre_legend_rank"
var_0_16.PRE_LEGEND_RANK_FIELD.full_name = ".sgland.UserVisitExResp.pre_legend_rank"
var_0_16.PRE_LEGEND_RANK_FIELD.number = 5
var_0_16.PRE_LEGEND_RANK_FIELD.index = 4
var_0_16.PRE_LEGEND_RANK_FIELD.label = 2
var_0_16.PRE_LEGEND_RANK_FIELD.has_default_value = false
var_0_16.PRE_LEGEND_RANK_FIELD.default_value = 0
var_0_16.PRE_LEGEND_RANK_FIELD.type = 5
var_0_16.PRE_LEGEND_RANK_FIELD.cpp_type = 1
var_0_16.BEST_LEGEND_RANK_FIELD.name = "best_legend_rank"
var_0_16.BEST_LEGEND_RANK_FIELD.full_name = ".sgland.UserVisitExResp.best_legend_rank"
var_0_16.BEST_LEGEND_RANK_FIELD.number = 6
var_0_16.BEST_LEGEND_RANK_FIELD.index = 5
var_0_16.BEST_LEGEND_RANK_FIELD.label = 2
var_0_16.BEST_LEGEND_RANK_FIELD.has_default_value = false
var_0_16.BEST_LEGEND_RANK_FIELD.default_value = 0
var_0_16.BEST_LEGEND_RANK_FIELD.type = 5
var_0_16.BEST_LEGEND_RANK_FIELD.cpp_type = 1
USERVISITEXRESP.name = "UserVisitExResp"
USERVISITEXRESP.full_name = ".sgland.UserVisitExResp"
USERVISITEXRESP.nested_types = {}
USERVISITEXRESP.enum_types = {}
USERVISITEXRESP.fields = {
	var_0_16.USER_INFO_FIELD,
	var_0_16.PRE_RANK_FIELD,
	var_0_16.BEST_RANK_FIELD,
	var_0_16.LEGEND_TROPHY_FIELD,
	var_0_16.PRE_LEGEND_RANK_FIELD,
	var_0_16.BEST_LEGEND_RANK_FIELD
}
USERVISITEXRESP.is_extendable = false
USERVISITEXRESP.extensions = {}
var_0_17.GOLD_FIELD.name = "gold"
var_0_17.GOLD_FIELD.full_name = ".sgland.UserSpawnGoldResp.gold"
var_0_17.GOLD_FIELD.number = 1
var_0_17.GOLD_FIELD.index = 0
var_0_17.GOLD_FIELD.label = 2
var_0_17.GOLD_FIELD.has_default_value = false
var_0_17.GOLD_FIELD.default_value = 0
var_0_17.GOLD_FIELD.type = 5
var_0_17.GOLD_FIELD.cpp_type = 1
var_0_17.NEXT_SPAWN_FIELD.name = "next_spawn"
var_0_17.NEXT_SPAWN_FIELD.full_name = ".sgland.UserSpawnGoldResp.next_spawn"
var_0_17.NEXT_SPAWN_FIELD.number = 2
var_0_17.NEXT_SPAWN_FIELD.index = 1
var_0_17.NEXT_SPAWN_FIELD.label = 2
var_0_17.NEXT_SPAWN_FIELD.has_default_value = false
var_0_17.NEXT_SPAWN_FIELD.default_value = 0
var_0_17.NEXT_SPAWN_FIELD.type = 3
var_0_17.NEXT_SPAWN_FIELD.cpp_type = 2
USERSPAWNGOLDRESP.name = "UserSpawnGoldResp"
USERSPAWNGOLDRESP.full_name = ".sgland.UserSpawnGoldResp"
USERSPAWNGOLDRESP.nested_types = {}
USERSPAWNGOLDRESP.enum_types = {}
USERSPAWNGOLDRESP.fields = {
	var_0_17.GOLD_FIELD,
	var_0_17.NEXT_SPAWN_FIELD
}
USERSPAWNGOLDRESP.is_extendable = false
USERSPAWNGOLDRESP.extensions = {}
var_0_18.GOLD_FIELD.name = "gold"
var_0_18.GOLD_FIELD.full_name = ".sgland.UserCollectGoldResp.gold"
var_0_18.GOLD_FIELD.number = 1
var_0_18.GOLD_FIELD.index = 0
var_0_18.GOLD_FIELD.label = 2
var_0_18.GOLD_FIELD.has_default_value = false
var_0_18.GOLD_FIELD.default_value = 0
var_0_18.GOLD_FIELD.type = 5
var_0_18.GOLD_FIELD.cpp_type = 1
var_0_18.CREDIT_FIELD.name = "credit"
var_0_18.CREDIT_FIELD.full_name = ".sgland.UserCollectGoldResp.credit"
var_0_18.CREDIT_FIELD.number = 2
var_0_18.CREDIT_FIELD.index = 1
var_0_18.CREDIT_FIELD.label = 2
var_0_18.CREDIT_FIELD.has_default_value = false
var_0_18.CREDIT_FIELD.default_value = 0
var_0_18.CREDIT_FIELD.type = 5
var_0_18.CREDIT_FIELD.cpp_type = 1
USERCOLLECTGOLDRESP.name = "UserCollectGoldResp"
USERCOLLECTGOLDRESP.full_name = ".sgland.UserCollectGoldResp"
USERCOLLECTGOLDRESP.nested_types = {}
USERCOLLECTGOLDRESP.enum_types = {}
USERCOLLECTGOLDRESP.fields = {
	var_0_18.GOLD_FIELD,
	var_0_18.CREDIT_FIELD
}
USERCOLLECTGOLDRESP.is_extendable = false
USERCOLLECTGOLDRESP.extensions = {}
var_0_19.STAGE_FIELD.name = "stage"
var_0_19.STAGE_FIELD.full_name = ".sgland.UserVoteReq.stage"
var_0_19.STAGE_FIELD.number = 1
var_0_19.STAGE_FIELD.index = 0
var_0_19.STAGE_FIELD.label = 2
var_0_19.STAGE_FIELD.has_default_value = false
var_0_19.STAGE_FIELD.default_value = 0
var_0_19.STAGE_FIELD.type = 5
var_0_19.STAGE_FIELD.cpp_type = 1
var_0_19.VOTE_FIELD.name = "vote"
var_0_19.VOTE_FIELD.full_name = ".sgland.UserVoteReq.vote"
var_0_19.VOTE_FIELD.number = 2
var_0_19.VOTE_FIELD.index = 1
var_0_19.VOTE_FIELD.label = 2
var_0_19.VOTE_FIELD.has_default_value = false
var_0_19.VOTE_FIELD.default_value = nil
var_0_19.VOTE_FIELD.message_type = var_0_2.PAIR
var_0_19.VOTE_FIELD.type = 11
var_0_19.VOTE_FIELD.cpp_type = 10
USERVOTEREQ.name = "UserVoteReq"
USERVOTEREQ.full_name = ".sgland.UserVoteReq"
USERVOTEREQ.nested_types = {}
USERVOTEREQ.enum_types = {}
USERVOTEREQ.fields = {
	var_0_19.STAGE_FIELD,
	var_0_19.VOTE_FIELD
}
USERVOTEREQ.is_extendable = false
USERVOTEREQ.extensions = {}
var_0_20.USER_REG_REQ_FIELD.name = "user_reg_req"
var_0_20.USER_REG_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_reg_req"
var_0_20.USER_REG_REQ_FIELD.number = 300
var_0_20.USER_REG_REQ_FIELD.index = 0
var_0_20.USER_REG_REQ_FIELD.label = 1
var_0_20.USER_REG_REQ_FIELD.has_default_value = false
var_0_20.USER_REG_REQ_FIELD.default_value = nil
var_0_20.USER_REG_REQ_FIELD.message_type = USERREGREQ
var_0_20.USER_REG_REQ_FIELD.type = 11
var_0_20.USER_REG_REQ_FIELD.cpp_type = 10
var_0_20.USER_LOGIN_REQ_FIELD.name = "user_login_req"
var_0_20.USER_LOGIN_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_login_req"
var_0_20.USER_LOGIN_REQ_FIELD.number = 301
var_0_20.USER_LOGIN_REQ_FIELD.index = 1
var_0_20.USER_LOGIN_REQ_FIELD.label = 1
var_0_20.USER_LOGIN_REQ_FIELD.has_default_value = false
var_0_20.USER_LOGIN_REQ_FIELD.default_value = nil
var_0_20.USER_LOGIN_REQ_FIELD.message_type = USERLOGINREQ
var_0_20.USER_LOGIN_REQ_FIELD.type = 11
var_0_20.USER_LOGIN_REQ_FIELD.cpp_type = 10
var_0_20.USER_VISIT_REQ_FIELD.name = "user_visit_req"
var_0_20.USER_VISIT_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_visit_req"
var_0_20.USER_VISIT_REQ_FIELD.number = 302
var_0_20.USER_VISIT_REQ_FIELD.index = 2
var_0_20.USER_VISIT_REQ_FIELD.label = 1
var_0_20.USER_VISIT_REQ_FIELD.has_default_value = false
var_0_20.USER_VISIT_REQ_FIELD.default_value = 0
var_0_20.USER_VISIT_REQ_FIELD.type = 3
var_0_20.USER_VISIT_REQ_FIELD.cpp_type = 2
var_0_20.USER_SET_GUIDE_REQ_FIELD.name = "user_set_guide_req"
var_0_20.USER_SET_GUIDE_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_set_guide_req"
var_0_20.USER_SET_GUIDE_REQ_FIELD.number = 303
var_0_20.USER_SET_GUIDE_REQ_FIELD.index = 3
var_0_20.USER_SET_GUIDE_REQ_FIELD.label = 1
var_0_20.USER_SET_GUIDE_REQ_FIELD.has_default_value = false
var_0_20.USER_SET_GUIDE_REQ_FIELD.default_value = 0
var_0_20.USER_SET_GUIDE_REQ_FIELD.type = 5
var_0_20.USER_SET_GUIDE_REQ_FIELD.cpp_type = 1
var_0_20.USER_SET_NAME_REQ_FIELD.name = "user_set_name_req"
var_0_20.USER_SET_NAME_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_set_name_req"
var_0_20.USER_SET_NAME_REQ_FIELD.number = 304
var_0_20.USER_SET_NAME_REQ_FIELD.index = 4
var_0_20.USER_SET_NAME_REQ_FIELD.label = 1
var_0_20.USER_SET_NAME_REQ_FIELD.has_default_value = false
var_0_20.USER_SET_NAME_REQ_FIELD.default_value = ""
var_0_20.USER_SET_NAME_REQ_FIELD.type = 9
var_0_20.USER_SET_NAME_REQ_FIELD.cpp_type = 9
var_0_20.USER_SET_AVATAR_REQ_FIELD.name = "user_set_avatar_req"
var_0_20.USER_SET_AVATAR_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_set_avatar_req"
var_0_20.USER_SET_AVATAR_REQ_FIELD.number = 305
var_0_20.USER_SET_AVATAR_REQ_FIELD.index = 5
var_0_20.USER_SET_AVATAR_REQ_FIELD.label = 1
var_0_20.USER_SET_AVATAR_REQ_FIELD.has_default_value = false
var_0_20.USER_SET_AVATAR_REQ_FIELD.default_value = 0
var_0_20.USER_SET_AVATAR_REQ_FIELD.type = 5
var_0_20.USER_SET_AVATAR_REQ_FIELD.cpp_type = 1
var_0_20.USER_OPEN_CHEST_REQ_FIELD.name = "user_open_chest_req"
var_0_20.USER_OPEN_CHEST_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_open_chest_req"
var_0_20.USER_OPEN_CHEST_REQ_FIELD.number = 306
var_0_20.USER_OPEN_CHEST_REQ_FIELD.index = 6
var_0_20.USER_OPEN_CHEST_REQ_FIELD.label = 1
var_0_20.USER_OPEN_CHEST_REQ_FIELD.has_default_value = false
var_0_20.USER_OPEN_CHEST_REQ_FIELD.default_value = nil
var_0_20.USER_OPEN_CHEST_REQ_FIELD.message_type = USEROPENCHESTREQ
var_0_20.USER_OPEN_CHEST_REQ_FIELD.type = 11
var_0_20.USER_OPEN_CHEST_REQ_FIELD.cpp_type = 10
var_0_20.USER_SET_TROOP_REQ_FIELD.name = "user_set_troop_req"
var_0_20.USER_SET_TROOP_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_set_troop_req"
var_0_20.USER_SET_TROOP_REQ_FIELD.number = 307
var_0_20.USER_SET_TROOP_REQ_FIELD.index = 7
var_0_20.USER_SET_TROOP_REQ_FIELD.label = 1
var_0_20.USER_SET_TROOP_REQ_FIELD.has_default_value = false
var_0_20.USER_SET_TROOP_REQ_FIELD.default_value = 0
var_0_20.USER_SET_TROOP_REQ_FIELD.type = 5
var_0_20.USER_SET_TROOP_REQ_FIELD.cpp_type = 1
var_0_20.USER_FINISH_TRAIN_REQ_FIELD.name = "user_finish_train_req"
var_0_20.USER_FINISH_TRAIN_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_finish_train_req"
var_0_20.USER_FINISH_TRAIN_REQ_FIELD.number = 308
var_0_20.USER_FINISH_TRAIN_REQ_FIELD.index = 8
var_0_20.USER_FINISH_TRAIN_REQ_FIELD.label = 1
var_0_20.USER_FINISH_TRAIN_REQ_FIELD.has_default_value = false
var_0_20.USER_FINISH_TRAIN_REQ_FIELD.default_value = 0
var_0_20.USER_FINISH_TRAIN_REQ_FIELD.type = 5
var_0_20.USER_FINISH_TRAIN_REQ_FIELD.cpp_type = 1
var_0_20.USER_CLAIM_GIFT_REQ_FIELD.name = "user_claim_gift_req"
var_0_20.USER_CLAIM_GIFT_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_claim_gift_req"
var_0_20.USER_CLAIM_GIFT_REQ_FIELD.number = 309
var_0_20.USER_CLAIM_GIFT_REQ_FIELD.index = 9
var_0_20.USER_CLAIM_GIFT_REQ_FIELD.label = 1
var_0_20.USER_CLAIM_GIFT_REQ_FIELD.has_default_value = false
var_0_20.USER_CLAIM_GIFT_REQ_FIELD.default_value = ""
var_0_20.USER_CLAIM_GIFT_REQ_FIELD.type = 9
var_0_20.USER_CLAIM_GIFT_REQ_FIELD.cpp_type = 9
var_0_20.USER_SET_EVENT_REQ_FIELD.name = "user_set_event_req"
var_0_20.USER_SET_EVENT_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_set_event_req"
var_0_20.USER_SET_EVENT_REQ_FIELD.number = 310
var_0_20.USER_SET_EVENT_REQ_FIELD.index = 10
var_0_20.USER_SET_EVENT_REQ_FIELD.label = 1
var_0_20.USER_SET_EVENT_REQ_FIELD.has_default_value = false
var_0_20.USER_SET_EVENT_REQ_FIELD.default_value = ""
var_0_20.USER_SET_EVENT_REQ_FIELD.type = 9
var_0_20.USER_SET_EVENT_REQ_FIELD.cpp_type = 9
var_0_20.USER_GCID_REQ_FIELD.name = "user_gcid_req"
var_0_20.USER_GCID_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_gcid_req"
var_0_20.USER_GCID_REQ_FIELD.number = 311
var_0_20.USER_GCID_REQ_FIELD.index = 11
var_0_20.USER_GCID_REQ_FIELD.label = 1
var_0_20.USER_GCID_REQ_FIELD.has_default_value = false
var_0_20.USER_GCID_REQ_FIELD.default_value = ""
var_0_20.USER_GCID_REQ_FIELD.type = 9
var_0_20.USER_GCID_REQ_FIELD.cpp_type = 9
var_0_20.USER_SET_CARD_BACK_REQ_FIELD.name = "user_set_card_back_req"
var_0_20.USER_SET_CARD_BACK_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_set_card_back_req"
var_0_20.USER_SET_CARD_BACK_REQ_FIELD.number = 312
var_0_20.USER_SET_CARD_BACK_REQ_FIELD.index = 12
var_0_20.USER_SET_CARD_BACK_REQ_FIELD.label = 1
var_0_20.USER_SET_CARD_BACK_REQ_FIELD.has_default_value = false
var_0_20.USER_SET_CARD_BACK_REQ_FIELD.default_value = 0
var_0_20.USER_SET_CARD_BACK_REQ_FIELD.type = 5
var_0_20.USER_SET_CARD_BACK_REQ_FIELD.cpp_type = 1
var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD.name = "user_set_avatar_frame_req"
var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_set_avatar_frame_req"
var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD.number = 313
var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD.index = 13
var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD.label = 1
var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD.has_default_value = false
var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD.default_value = 0
var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD.type = 5
var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD.cpp_type = 1
var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD.name = "user_apply_vip_card_req"
var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_apply_vip_card_req"
var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD.number = 314
var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD.index = 14
var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD.label = 1
var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD.has_default_value = false
var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD.default_value = 0
var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD.type = 5
var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD.cpp_type = 1
var_0_20.USER_SET_CONFIG_REQ_FIELD.name = "user_set_config_req"
var_0_20.USER_SET_CONFIG_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_set_config_req"
var_0_20.USER_SET_CONFIG_REQ_FIELD.number = 315
var_0_20.USER_SET_CONFIG_REQ_FIELD.index = 15
var_0_20.USER_SET_CONFIG_REQ_FIELD.label = 1
var_0_20.USER_SET_CONFIG_REQ_FIELD.has_default_value = false
var_0_20.USER_SET_CONFIG_REQ_FIELD.default_value = 0
var_0_20.USER_SET_CONFIG_REQ_FIELD.type = 5
var_0_20.USER_SET_CONFIG_REQ_FIELD.cpp_type = 1
var_0_20.USER_TECH_UPGRADE_REQ_FIELD.name = "user_tech_upgrade_req"
var_0_20.USER_TECH_UPGRADE_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_tech_upgrade_req"
var_0_20.USER_TECH_UPGRADE_REQ_FIELD.number = 316
var_0_20.USER_TECH_UPGRADE_REQ_FIELD.index = 16
var_0_20.USER_TECH_UPGRADE_REQ_FIELD.label = 1
var_0_20.USER_TECH_UPGRADE_REQ_FIELD.has_default_value = false
var_0_20.USER_TECH_UPGRADE_REQ_FIELD.default_value = 0
var_0_20.USER_TECH_UPGRADE_REQ_FIELD.type = 5
var_0_20.USER_TECH_UPGRADE_REQ_FIELD.cpp_type = 1
var_0_20.USER_BAN_CHAT_REQ_FIELD.name = "user_ban_chat_req"
var_0_20.USER_BAN_CHAT_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_ban_chat_req"
var_0_20.USER_BAN_CHAT_REQ_FIELD.number = 317
var_0_20.USER_BAN_CHAT_REQ_FIELD.index = 17
var_0_20.USER_BAN_CHAT_REQ_FIELD.label = 1
var_0_20.USER_BAN_CHAT_REQ_FIELD.has_default_value = false
var_0_20.USER_BAN_CHAT_REQ_FIELD.default_value = 0
var_0_20.USER_BAN_CHAT_REQ_FIELD.type = 3
var_0_20.USER_BAN_CHAT_REQ_FIELD.cpp_type = 2
var_0_20.USER_GIVE_FUND_REQ_FIELD.name = "user_give_fund_req"
var_0_20.USER_GIVE_FUND_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_give_fund_req"
var_0_20.USER_GIVE_FUND_REQ_FIELD.number = 318
var_0_20.USER_GIVE_FUND_REQ_FIELD.index = 18
var_0_20.USER_GIVE_FUND_REQ_FIELD.label = 1
var_0_20.USER_GIVE_FUND_REQ_FIELD.has_default_value = false
var_0_20.USER_GIVE_FUND_REQ_FIELD.default_value = 0
var_0_20.USER_GIVE_FUND_REQ_FIELD.type = 3
var_0_20.USER_GIVE_FUND_REQ_FIELD.cpp_type = 2
var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD.name = "user_bind_invite_code_req"
var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_bind_invite_code_req"
var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD.number = 319
var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD.index = 19
var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD.label = 1
var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD.has_default_value = false
var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD.default_value = ""
var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD.type = 9
var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD.cpp_type = 9
var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD.name = "user_check_invite_code_req"
var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_check_invite_code_req"
var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD.number = 320
var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD.index = 20
var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD.label = 1
var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD.has_default_value = false
var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD.default_value = ""
var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD.type = 9
var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD.cpp_type = 9
var_0_20.USER_NOTITY_EVENT_REQ_FIELD.name = "user_notity_event_req"
var_0_20.USER_NOTITY_EVENT_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_notity_event_req"
var_0_20.USER_NOTITY_EVENT_REQ_FIELD.number = 321
var_0_20.USER_NOTITY_EVENT_REQ_FIELD.index = 21
var_0_20.USER_NOTITY_EVENT_REQ_FIELD.label = 1
var_0_20.USER_NOTITY_EVENT_REQ_FIELD.has_default_value = false
var_0_20.USER_NOTITY_EVENT_REQ_FIELD.default_value = nil
var_0_20.USER_NOTITY_EVENT_REQ_FIELD.message_type = USERNOTIFYEVENT
var_0_20.USER_NOTITY_EVENT_REQ_FIELD.type = 11
var_0_20.USER_NOTITY_EVENT_REQ_FIELD.cpp_type = 10
var_0_20.USER_FACEBOOK_REQ_FIELD.name = "user_facebook_req"
var_0_20.USER_FACEBOOK_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_facebook_req"
var_0_20.USER_FACEBOOK_REQ_FIELD.number = 322
var_0_20.USER_FACEBOOK_REQ_FIELD.index = 22
var_0_20.USER_FACEBOOK_REQ_FIELD.label = 1
var_0_20.USER_FACEBOOK_REQ_FIELD.has_default_value = false
var_0_20.USER_FACEBOOK_REQ_FIELD.default_value = 0
var_0_20.USER_FACEBOOK_REQ_FIELD.type = 5
var_0_20.USER_FACEBOOK_REQ_FIELD.cpp_type = 1
var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD.name = "user_cancel_ban_chat_req"
var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_cancel_ban_chat_req"
var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD.number = 323
var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD.index = 23
var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD.label = 1
var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD.has_default_value = false
var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD.default_value = 0
var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD.type = 3
var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD.cpp_type = 2
var_0_20.USER_SET_CHARACTER_REQ_FIELD.name = "user_set_character_req"
var_0_20.USER_SET_CHARACTER_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_set_character_req"
var_0_20.USER_SET_CHARACTER_REQ_FIELD.number = 324
var_0_20.USER_SET_CHARACTER_REQ_FIELD.index = 24
var_0_20.USER_SET_CHARACTER_REQ_FIELD.label = 1
var_0_20.USER_SET_CHARACTER_REQ_FIELD.has_default_value = false
var_0_20.USER_SET_CHARACTER_REQ_FIELD.default_value = 0
var_0_20.USER_SET_CHARACTER_REQ_FIELD.type = 5
var_0_20.USER_SET_CHARACTER_REQ_FIELD.cpp_type = 1
var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD.name = "user_unlock_character_req"
var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_unlock_character_req"
var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD.number = 325
var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD.index = 25
var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD.label = 1
var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD.has_default_value = false
var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD.default_value = nil
var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD.message_type = USERUNLOCKCHARACTERREQ
var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD.type = 11
var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD.cpp_type = 10
var_0_20.USER_SET_SKIN_REQ_FIELD.name = "user_set_skin_req"
var_0_20.USER_SET_SKIN_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_set_skin_req"
var_0_20.USER_SET_SKIN_REQ_FIELD.number = 326
var_0_20.USER_SET_SKIN_REQ_FIELD.index = 26
var_0_20.USER_SET_SKIN_REQ_FIELD.label = 1
var_0_20.USER_SET_SKIN_REQ_FIELD.has_default_value = false
var_0_20.USER_SET_SKIN_REQ_FIELD.default_value = nil
var_0_20.USER_SET_SKIN_REQ_FIELD.message_type = USERSETSKINREQ
var_0_20.USER_SET_SKIN_REQ_FIELD.type = 11
var_0_20.USER_SET_SKIN_REQ_FIELD.cpp_type = 10
var_0_20.USER_OPPO_VIP_REQ_FIELD.name = "user_oppo_vip_req"
var_0_20.USER_OPPO_VIP_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_oppo_vip_req"
var_0_20.USER_OPPO_VIP_REQ_FIELD.number = 327
var_0_20.USER_OPPO_VIP_REQ_FIELD.index = 27
var_0_20.USER_OPPO_VIP_REQ_FIELD.label = 1
var_0_20.USER_OPPO_VIP_REQ_FIELD.has_default_value = false
var_0_20.USER_OPPO_VIP_REQ_FIELD.default_value = nil
var_0_20.USER_OPPO_VIP_REQ_FIELD.message_type = USEROPPOVIPREQ
var_0_20.USER_OPPO_VIP_REQ_FIELD.type = 11
var_0_20.USER_OPPO_VIP_REQ_FIELD.cpp_type = 10
var_0_20.USER_COMMAND_REQ_FIELD.name = "user_command_req"
var_0_20.USER_COMMAND_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_command_req"
var_0_20.USER_COMMAND_REQ_FIELD.number = 328
var_0_20.USER_COMMAND_REQ_FIELD.index = 28
var_0_20.USER_COMMAND_REQ_FIELD.label = 1
var_0_20.USER_COMMAND_REQ_FIELD.has_default_value = false
var_0_20.USER_COMMAND_REQ_FIELD.default_value = ""
var_0_20.USER_COMMAND_REQ_FIELD.type = 9
var_0_20.USER_COMMAND_REQ_FIELD.cpp_type = 9
var_0_20.USER_VOTE_REQ_FIELD.name = "user_vote_req"
var_0_20.USER_VOTE_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_vote_req"
var_0_20.USER_VOTE_REQ_FIELD.number = 329
var_0_20.USER_VOTE_REQ_FIELD.index = 29
var_0_20.USER_VOTE_REQ_FIELD.label = 1
var_0_20.USER_VOTE_REQ_FIELD.has_default_value = false
var_0_20.USER_VOTE_REQ_FIELD.default_value = nil
var_0_20.USER_VOTE_REQ_FIELD.message_type = USERVOTEREQ
var_0_20.USER_VOTE_REQ_FIELD.type = 11
var_0_20.USER_VOTE_REQ_FIELD.cpp_type = 10
var_0_20.USER_VOTE_RECORD_REQ_FIELD.name = "user_vote_record_req"
var_0_20.USER_VOTE_RECORD_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_vote_record_req"
var_0_20.USER_VOTE_RECORD_REQ_FIELD.number = 330
var_0_20.USER_VOTE_RECORD_REQ_FIELD.index = 30
var_0_20.USER_VOTE_RECORD_REQ_FIELD.label = 1
var_0_20.USER_VOTE_RECORD_REQ_FIELD.has_default_value = false
var_0_20.USER_VOTE_RECORD_REQ_FIELD.default_value = 0
var_0_20.USER_VOTE_RECORD_REQ_FIELD.type = 5
var_0_20.USER_VOTE_RECORD_REQ_FIELD.cpp_type = 1
var_0_20.USER_BREAK_OUT_REQ_FIELD.name = "user_break_out_req"
var_0_20.USER_BREAK_OUT_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_break_out_req"
var_0_20.USER_BREAK_OUT_REQ_FIELD.number = 331
var_0_20.USER_BREAK_OUT_REQ_FIELD.index = 31
var_0_20.USER_BREAK_OUT_REQ_FIELD.label = 1
var_0_20.USER_BREAK_OUT_REQ_FIELD.has_default_value = false
var_0_20.USER_BREAK_OUT_REQ_FIELD.default_value = 0
var_0_20.USER_BREAK_OUT_REQ_FIELD.type = 5
var_0_20.USER_BREAK_OUT_REQ_FIELD.cpp_type = 1
var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD.name = "user_dynamic_timeout_req"
var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD.full_name = ".sgland.SglUserMsg.user_dynamic_timeout_req"
var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD.number = 332
var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD.index = 32
var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD.label = 1
var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD.has_default_value = false
var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD.default_value = false
var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD.type = 8
var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD.cpp_type = 7
var_0_20.USER_IN_RESP_FIELD.name = "user_in_resp"
var_0_20.USER_IN_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_in_resp"
var_0_20.USER_IN_RESP_FIELD.number = 300
var_0_20.USER_IN_RESP_FIELD.index = 33
var_0_20.USER_IN_RESP_FIELD.label = 1
var_0_20.USER_IN_RESP_FIELD.has_default_value = false
var_0_20.USER_IN_RESP_FIELD.default_value = nil
var_0_20.USER_IN_RESP_FIELD.message_type = USERINRESP
var_0_20.USER_IN_RESP_FIELD.type = 11
var_0_20.USER_IN_RESP_FIELD.cpp_type = 10
var_0_20.USER_VISIT_RESP_FIELD.name = "user_visit_resp"
var_0_20.USER_VISIT_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_visit_resp"
var_0_20.USER_VISIT_RESP_FIELD.number = 301
var_0_20.USER_VISIT_RESP_FIELD.index = 34
var_0_20.USER_VISIT_RESP_FIELD.label = 1
var_0_20.USER_VISIT_RESP_FIELD.has_default_value = false
var_0_20.USER_VISIT_RESP_FIELD.default_value = nil
var_0_20.USER_VISIT_RESP_FIELD.message_type = USERVISITRESP
var_0_20.USER_VISIT_RESP_FIELD.type = 11
var_0_20.USER_VISIT_RESP_FIELD.cpp_type = 10
var_0_20.USER_OPEN_CHEST_RESP_FIELD.name = "user_open_chest_resp"
var_0_20.USER_OPEN_CHEST_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_open_chest_resp"
var_0_20.USER_OPEN_CHEST_RESP_FIELD.number = 302
var_0_20.USER_OPEN_CHEST_RESP_FIELD.index = 35
var_0_20.USER_OPEN_CHEST_RESP_FIELD.label = 3
var_0_20.USER_OPEN_CHEST_RESP_FIELD.has_default_value = false
var_0_20.USER_OPEN_CHEST_RESP_FIELD.default_value = {}
var_0_20.USER_OPEN_CHEST_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_20.USER_OPEN_CHEST_RESP_FIELD.type = 11
var_0_20.USER_OPEN_CHEST_RESP_FIELD.cpp_type = 10
var_0_20.USER_UNDER_ATTACK_RESP_FIELD.name = "user_under_attack_resp"
var_0_20.USER_UNDER_ATTACK_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_under_attack_resp"
var_0_20.USER_UNDER_ATTACK_RESP_FIELD.number = 303
var_0_20.USER_UNDER_ATTACK_RESP_FIELD.index = 36
var_0_20.USER_UNDER_ATTACK_RESP_FIELD.label = 1
var_0_20.USER_UNDER_ATTACK_RESP_FIELD.has_default_value = false
var_0_20.USER_UNDER_ATTACK_RESP_FIELD.default_value = nil
var_0_20.USER_UNDER_ATTACK_RESP_FIELD.message_type = var_0_2.USERINFO
var_0_20.USER_UNDER_ATTACK_RESP_FIELD.type = 11
var_0_20.USER_UNDER_ATTACK_RESP_FIELD.cpp_type = 10
var_0_20.USER_SPAWN_GOLD_RESP_FIELD.name = "user_spawn_gold_resp"
var_0_20.USER_SPAWN_GOLD_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_spawn_gold_resp"
var_0_20.USER_SPAWN_GOLD_RESP_FIELD.number = 304
var_0_20.USER_SPAWN_GOLD_RESP_FIELD.index = 37
var_0_20.USER_SPAWN_GOLD_RESP_FIELD.label = 1
var_0_20.USER_SPAWN_GOLD_RESP_FIELD.has_default_value = false
var_0_20.USER_SPAWN_GOLD_RESP_FIELD.default_value = nil
var_0_20.USER_SPAWN_GOLD_RESP_FIELD.message_type = USERSPAWNGOLDRESP
var_0_20.USER_SPAWN_GOLD_RESP_FIELD.type = 11
var_0_20.USER_SPAWN_GOLD_RESP_FIELD.cpp_type = 10
var_0_20.USER_CLAIM_GIFT_RESP_FIELD.name = "user_claim_gift_resp"
var_0_20.USER_CLAIM_GIFT_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_claim_gift_resp"
var_0_20.USER_CLAIM_GIFT_RESP_FIELD.number = 305
var_0_20.USER_CLAIM_GIFT_RESP_FIELD.index = 38
var_0_20.USER_CLAIM_GIFT_RESP_FIELD.label = 3
var_0_20.USER_CLAIM_GIFT_RESP_FIELD.has_default_value = false
var_0_20.USER_CLAIM_GIFT_RESP_FIELD.default_value = {}
var_0_20.USER_CLAIM_GIFT_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_20.USER_CLAIM_GIFT_RESP_FIELD.type = 11
var_0_20.USER_CLAIM_GIFT_RESP_FIELD.cpp_type = 10
var_0_20.USER_QUERY_GCID_RESP_FIELD.name = "user_query_gcid_resp"
var_0_20.USER_QUERY_GCID_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_query_gcid_resp"
var_0_20.USER_QUERY_GCID_RESP_FIELD.number = 306
var_0_20.USER_QUERY_GCID_RESP_FIELD.index = 39
var_0_20.USER_QUERY_GCID_RESP_FIELD.label = 1
var_0_20.USER_QUERY_GCID_RESP_FIELD.has_default_value = false
var_0_20.USER_QUERY_GCID_RESP_FIELD.default_value = false
var_0_20.USER_QUERY_GCID_RESP_FIELD.type = 8
var_0_20.USER_QUERY_GCID_RESP_FIELD.cpp_type = 7
var_0_20.USER_BAN_LOGIN_RESP_FIELD.name = "user_ban_login_resp"
var_0_20.USER_BAN_LOGIN_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_ban_login_resp"
var_0_20.USER_BAN_LOGIN_RESP_FIELD.number = 307
var_0_20.USER_BAN_LOGIN_RESP_FIELD.index = 40
var_0_20.USER_BAN_LOGIN_RESP_FIELD.label = 1
var_0_20.USER_BAN_LOGIN_RESP_FIELD.has_default_value = false
var_0_20.USER_BAN_LOGIN_RESP_FIELD.default_value = 0
var_0_20.USER_BAN_LOGIN_RESP_FIELD.type = 3
var_0_20.USER_BAN_LOGIN_RESP_FIELD.cpp_type = 2
var_0_20.USER_ADMIN_LIST_RESP_FIELD.name = "user_admin_list_resp"
var_0_20.USER_ADMIN_LIST_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_admin_list_resp"
var_0_20.USER_ADMIN_LIST_RESP_FIELD.number = 308
var_0_20.USER_ADMIN_LIST_RESP_FIELD.index = 41
var_0_20.USER_ADMIN_LIST_RESP_FIELD.label = 3
var_0_20.USER_ADMIN_LIST_RESP_FIELD.has_default_value = false
var_0_20.USER_ADMIN_LIST_RESP_FIELD.default_value = {}
var_0_20.USER_ADMIN_LIST_RESP_FIELD.message_type = var_0_2.USERINFO
var_0_20.USER_ADMIN_LIST_RESP_FIELD.type = 11
var_0_20.USER_ADMIN_LIST_RESP_FIELD.cpp_type = 10
var_0_20.USER_BAN_CHAT_RESP_FIELD.name = "user_ban_chat_resp"
var_0_20.USER_BAN_CHAT_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_ban_chat_resp"
var_0_20.USER_BAN_CHAT_RESP_FIELD.number = 309
var_0_20.USER_BAN_CHAT_RESP_FIELD.index = 42
var_0_20.USER_BAN_CHAT_RESP_FIELD.label = 1
var_0_20.USER_BAN_CHAT_RESP_FIELD.has_default_value = false
var_0_20.USER_BAN_CHAT_RESP_FIELD.default_value = 0
var_0_20.USER_BAN_CHAT_RESP_FIELD.type = 3
var_0_20.USER_BAN_CHAT_RESP_FIELD.cpp_type = 2
var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD.name = "user_illegal_input_resp"
var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_illegal_input_resp"
var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD.number = 310
var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD.index = 43
var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD.label = 1
var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD.has_default_value = false
var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD.default_value = ""
var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD.type = 9
var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD.cpp_type = 9
var_0_20.USER_VISIT_EX_RESP_FIELD.name = "user_visit_ex_resp"
var_0_20.USER_VISIT_EX_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_visit_ex_resp"
var_0_20.USER_VISIT_EX_RESP_FIELD.number = 311
var_0_20.USER_VISIT_EX_RESP_FIELD.index = 44
var_0_20.USER_VISIT_EX_RESP_FIELD.label = 1
var_0_20.USER_VISIT_EX_RESP_FIELD.has_default_value = false
var_0_20.USER_VISIT_EX_RESP_FIELD.default_value = nil
var_0_20.USER_VISIT_EX_RESP_FIELD.message_type = USERVISITEXRESP
var_0_20.USER_VISIT_EX_RESP_FIELD.type = 11
var_0_20.USER_VISIT_EX_RESP_FIELD.cpp_type = 10
var_0_20.USER_GET_INVITE_CODE_RESP_FIELD.name = "user_get_invite_code_resp"
var_0_20.USER_GET_INVITE_CODE_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_get_invite_code_resp"
var_0_20.USER_GET_INVITE_CODE_RESP_FIELD.number = 312
var_0_20.USER_GET_INVITE_CODE_RESP_FIELD.index = 45
var_0_20.USER_GET_INVITE_CODE_RESP_FIELD.label = 1
var_0_20.USER_GET_INVITE_CODE_RESP_FIELD.has_default_value = false
var_0_20.USER_GET_INVITE_CODE_RESP_FIELD.default_value = ""
var_0_20.USER_GET_INVITE_CODE_RESP_FIELD.type = 9
var_0_20.USER_GET_INVITE_CODE_RESP_FIELD.cpp_type = 9
var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD.name = "user_check_invite_code_resp"
var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_check_invite_code_resp"
var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD.number = 313
var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD.index = 46
var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD.label = 1
var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD.has_default_value = false
var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD.default_value = nil
var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD.message_type = var_0_2.USERINFO
var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD.type = 11
var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD.cpp_type = 10
var_0_20.USER_NOTIFY_EVENT_RESP_FIELD.name = "user_notify_event_resp"
var_0_20.USER_NOTIFY_EVENT_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_notify_event_resp"
var_0_20.USER_NOTIFY_EVENT_RESP_FIELD.number = 314
var_0_20.USER_NOTIFY_EVENT_RESP_FIELD.index = 47
var_0_20.USER_NOTIFY_EVENT_RESP_FIELD.label = 1
var_0_20.USER_NOTIFY_EVENT_RESP_FIELD.has_default_value = false
var_0_20.USER_NOTIFY_EVENT_RESP_FIELD.default_value = nil
var_0_20.USER_NOTIFY_EVENT_RESP_FIELD.message_type = USERNOTIFYEVENT
var_0_20.USER_NOTIFY_EVENT_RESP_FIELD.type = 11
var_0_20.USER_NOTIFY_EVENT_RESP_FIELD.cpp_type = 10
var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD.name = "user_cancel_ban_chat_resp"
var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_cancel_ban_chat_resp"
var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD.number = 315
var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD.index = 48
var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD.label = 1
var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD.has_default_value = false
var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD.default_value = 0
var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD.type = 3
var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD.cpp_type = 2
var_0_20.USER_COLLECT_GOLD_RESP_FIELD.name = "user_collect_gold_resp"
var_0_20.USER_COLLECT_GOLD_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_collect_gold_resp"
var_0_20.USER_COLLECT_GOLD_RESP_FIELD.number = 316
var_0_20.USER_COLLECT_GOLD_RESP_FIELD.index = 49
var_0_20.USER_COLLECT_GOLD_RESP_FIELD.label = 1
var_0_20.USER_COLLECT_GOLD_RESP_FIELD.has_default_value = false
var_0_20.USER_COLLECT_GOLD_RESP_FIELD.default_value = nil
var_0_20.USER_COLLECT_GOLD_RESP_FIELD.message_type = USERCOLLECTGOLDRESP
var_0_20.USER_COLLECT_GOLD_RESP_FIELD.type = 11
var_0_20.USER_COLLECT_GOLD_RESP_FIELD.cpp_type = 10
var_0_20.INIT_CARDS_RESP_FIELD.name = "init_cards_resp"
var_0_20.INIT_CARDS_RESP_FIELD.full_name = ".sgland.SglUserMsg.init_cards_resp"
var_0_20.INIT_CARDS_RESP_FIELD.number = 317
var_0_20.INIT_CARDS_RESP_FIELD.index = 50
var_0_20.INIT_CARDS_RESP_FIELD.label = 3
var_0_20.INIT_CARDS_RESP_FIELD.has_default_value = false
var_0_20.INIT_CARDS_RESP_FIELD.default_value = {}
var_0_20.INIT_CARDS_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_20.INIT_CARDS_RESP_FIELD.type = 11
var_0_20.INIT_CARDS_RESP_FIELD.cpp_type = 10
var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD.name = "user_claim_gift_bonus_id_resp"
var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_claim_gift_bonus_id_resp"
var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD.number = 318
var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD.index = 51
var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD.label = 1
var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD.has_default_value = false
var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD.default_value = 0
var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD.type = 5
var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD.cpp_type = 1
var_0_20.USER_OPPO_VIP_RESP_FIELD.name = "user_oppo_vip_resp"
var_0_20.USER_OPPO_VIP_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_oppo_vip_resp"
var_0_20.USER_OPPO_VIP_RESP_FIELD.number = 319
var_0_20.USER_OPPO_VIP_RESP_FIELD.index = 52
var_0_20.USER_OPPO_VIP_RESP_FIELD.label = 1
var_0_20.USER_OPPO_VIP_RESP_FIELD.has_default_value = false
var_0_20.USER_OPPO_VIP_RESP_FIELD.default_value = 0
var_0_20.USER_OPPO_VIP_RESP_FIELD.type = 5
var_0_20.USER_OPPO_VIP_RESP_FIELD.cpp_type = 1
var_0_20.USER_COMMAND_RESP_FIELD.name = "user_command_resp"
var_0_20.USER_COMMAND_RESP_FIELD.full_name = ".sgland.SglUserMsg.user_command_resp"
var_0_20.USER_COMMAND_RESP_FIELD.number = 320
var_0_20.USER_COMMAND_RESP_FIELD.index = 53
var_0_20.USER_COMMAND_RESP_FIELD.label = 1
var_0_20.USER_COMMAND_RESP_FIELD.has_default_value = false
var_0_20.USER_COMMAND_RESP_FIELD.default_value = ""
var_0_20.USER_COMMAND_RESP_FIELD.type = 9
var_0_20.USER_COMMAND_RESP_FIELD.cpp_type = 9
var_0_20.VOTE_RECORD_RESP_FIELD.name = "vote_record_resp"
var_0_20.VOTE_RECORD_RESP_FIELD.full_name = ".sgland.SglUserMsg.vote_record_resp"
var_0_20.VOTE_RECORD_RESP_FIELD.number = 321
var_0_20.VOTE_RECORD_RESP_FIELD.index = 54
var_0_20.VOTE_RECORD_RESP_FIELD.label = 3
var_0_20.VOTE_RECORD_RESP_FIELD.has_default_value = false
var_0_20.VOTE_RECORD_RESP_FIELD.default_value = {}
var_0_20.VOTE_RECORD_RESP_FIELD.message_type = var_0_2.PAIR
var_0_20.VOTE_RECORD_RESP_FIELD.type = 11
var_0_20.VOTE_RECORD_RESP_FIELD.cpp_type = 10
SGLUSERMSG.name = "SglUserMsg"
SGLUSERMSG.full_name = ".sgland.SglUserMsg"
SGLUSERMSG.nested_types = {}
SGLUSERMSG.enum_types = {}
SGLUSERMSG.fields = {}
SGLUSERMSG.is_extendable = false
SGLUSERMSG.extensions = {
	var_0_20.USER_REG_REQ_FIELD,
	var_0_20.USER_LOGIN_REQ_FIELD,
	var_0_20.USER_VISIT_REQ_FIELD,
	var_0_20.USER_SET_GUIDE_REQ_FIELD,
	var_0_20.USER_SET_NAME_REQ_FIELD,
	var_0_20.USER_SET_AVATAR_REQ_FIELD,
	var_0_20.USER_OPEN_CHEST_REQ_FIELD,
	var_0_20.USER_SET_TROOP_REQ_FIELD,
	var_0_20.USER_FINISH_TRAIN_REQ_FIELD,
	var_0_20.USER_CLAIM_GIFT_REQ_FIELD,
	var_0_20.USER_SET_EVENT_REQ_FIELD,
	var_0_20.USER_GCID_REQ_FIELD,
	var_0_20.USER_SET_CARD_BACK_REQ_FIELD,
	var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD,
	var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD,
	var_0_20.USER_SET_CONFIG_REQ_FIELD,
	var_0_20.USER_TECH_UPGRADE_REQ_FIELD,
	var_0_20.USER_BAN_CHAT_REQ_FIELD,
	var_0_20.USER_GIVE_FUND_REQ_FIELD,
	var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD,
	var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD,
	var_0_20.USER_NOTITY_EVENT_REQ_FIELD,
	var_0_20.USER_FACEBOOK_REQ_FIELD,
	var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD,
	var_0_20.USER_SET_CHARACTER_REQ_FIELD,
	var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD,
	var_0_20.USER_SET_SKIN_REQ_FIELD,
	var_0_20.USER_OPPO_VIP_REQ_FIELD,
	var_0_20.USER_COMMAND_REQ_FIELD,
	var_0_20.USER_VOTE_REQ_FIELD,
	var_0_20.USER_VOTE_RECORD_REQ_FIELD,
	var_0_20.USER_BREAK_OUT_REQ_FIELD,
	var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD,
	var_0_20.USER_IN_RESP_FIELD,
	var_0_20.USER_VISIT_RESP_FIELD,
	var_0_20.USER_OPEN_CHEST_RESP_FIELD,
	var_0_20.USER_UNDER_ATTACK_RESP_FIELD,
	var_0_20.USER_SPAWN_GOLD_RESP_FIELD,
	var_0_20.USER_CLAIM_GIFT_RESP_FIELD,
	var_0_20.USER_QUERY_GCID_RESP_FIELD,
	var_0_20.USER_BAN_LOGIN_RESP_FIELD,
	var_0_20.USER_ADMIN_LIST_RESP_FIELD,
	var_0_20.USER_BAN_CHAT_RESP_FIELD,
	var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD,
	var_0_20.USER_VISIT_EX_RESP_FIELD,
	var_0_20.USER_GET_INVITE_CODE_RESP_FIELD,
	var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD,
	var_0_20.USER_NOTIFY_EVENT_RESP_FIELD,
	var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD,
	var_0_20.USER_COLLECT_GOLD_RESP_FIELD,
	var_0_20.INIT_CARDS_RESP_FIELD,
	var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD,
	var_0_20.USER_OPPO_VIP_RESP_FIELD,
	var_0_20.USER_COMMAND_RESP_FIELD,
	var_0_20.VOTE_RECORD_RESP_FIELD
}
FullUserInfo = var_0_0.Message(FULLUSERINFO)
SglUserMsg = var_0_0.Message(SGLUSERMSG)
UserBattle = var_0_0.Message(USERBATTLE)
UserCollectGoldResp = var_0_0.Message(USERCOLLECTGOLDRESP)
UserCount = var_0_0.Message(USERCOUNT)
UserInResp = var_0_0.Message(USERINRESP)
UserLoginReq = var_0_0.Message(USERLOGINREQ)
UserLottery = var_0_0.Message(USERLOTTERY)
UserNotifyEvent = var_0_0.Message(USERNOTIFYEVENT)
UserOpenChestReq = var_0_0.Message(USEROPENCHESTREQ)
UserOppoVipReq = var_0_0.Message(USEROPPOVIPREQ)
UserRegReq = var_0_0.Message(USERREGREQ)
UserSetSkinReq = var_0_0.Message(USERSETSKINREQ)
UserSpawnGoldResp = var_0_0.Message(USERSPAWNGOLDRESP)
UserUnlockCharacterReq = var_0_0.Message(USERUNLOCKCHARACTERREQ)
UserVisitExResp = var_0_0.Message(USERVISITEXRESP)
UserVisitResp = var_0_0.Message(USERVISITRESP)
UserVoteReq = var_0_0.Message(USERVOTEREQ)

var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_REG_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_LOGIN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_VISIT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_SET_GUIDE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_SET_NAME_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_SET_AVATAR_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_OPEN_CHEST_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_SET_TROOP_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_FINISH_TRAIN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_CLAIM_GIFT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_SET_EVENT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_GCID_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_SET_CARD_BACK_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_SET_AVATAR_FRAME_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_APPLY_VIP_CARD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_SET_CONFIG_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_TECH_UPGRADE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_BAN_CHAT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_GIVE_FUND_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_BIND_INVITE_CODE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_CHECK_INVITE_CODE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_NOTITY_EVENT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_FACEBOOK_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_CANCEL_BAN_CHAT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_SET_CHARACTER_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_UNLOCK_CHARACTER_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_SET_SKIN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_OPPO_VIP_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_COMMAND_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_VOTE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_VOTE_RECORD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_BREAK_OUT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_20.USER_DYNAMIC_TIMEOUT_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_IN_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_VISIT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_OPEN_CHEST_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_UNDER_ATTACK_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_SPAWN_GOLD_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_CLAIM_GIFT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_QUERY_GCID_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_BAN_LOGIN_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_ADMIN_LIST_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_BAN_CHAT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_ILLEGAL_INPUT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_VISIT_EX_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_GET_INVITE_CODE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_CHECK_INVITE_CODE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_NOTIFY_EVENT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_CANCEL_BAN_CHAT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_COLLECT_GOLD_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.INIT_CARDS_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_CLAIM_GIFT_BONUS_ID_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_OPPO_VIP_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.USER_COMMAND_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_20.VOTE_RECORD_RESP_FIELD)
