local var_0_0 = require("protobuf")

module("Data_pb")

MATCHTYPE = var_0_0.EnumDescriptor()

local var_0_1 = {
	PB_TYPE_NORMAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_DARK = var_0_0.EnumValueDescriptor()
}

MVPTYPE = var_0_0.EnumDescriptor()

local var_0_2 = {
	LADDER_MVP = var_0_0.EnumValueDescriptor(),
	LADDER_EX_MVP = var_0_0.EnumValueDescriptor(),
	DARK_DUEL_MVP = var_0_0.EnumValueDescriptor(),
	MASSWAR_MVP = var_0_0.EnumValueDescriptor(),
	SURVIVAL_MVP = var_0_0.EnumValueDescriptor(),
	SURVIVAL_EX_MVP = var_0_0.EnumValueDescriptor()
}

CROWN = var_0_0.Descriptor()

local var_0_3 = {
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	NUM_FIELD = var_0_0.FieldDescriptor()
}

USERINFO = var_0_0.Descriptor()

local var_0_4 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FIELD = var_0_0.FieldDescriptor(),
	UNION_ID_FIELD = var_0_0.FieldDescriptor(),
	UNION_NAME_FIELD = var_0_0.FieldDescriptor(),
	UNION_TITLE_FIELD = var_0_0.FieldDescriptor(),
	VIP_FIELD = var_0_0.FieldDescriptor(),
	LAST_LOGIN_FIELD = var_0_0.FieldDescriptor(),
	UNION_TAG_FIELD = var_0_0.FieldDescriptor(),
	UNION_AVATAR_FIELD = var_0_0.FieldDescriptor(),
	CARD_BACK_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FRAME_FIELD = var_0_0.FieldDescriptor(),
	RID_FIELD = var_0_0.FieldDescriptor(),
	IS_NPC_FIELD = var_0_0.FieldDescriptor(),
	CODE_FIELD = var_0_0.FieldDescriptor(),
	CROWN_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FRAME_COUNT_FIELD = var_0_0.FieldDescriptor(),
	MASS_WAR_SCORE_FIELD = var_0_0.FieldDescriptor(),
	PRIVILEGE_FIELD = var_0_0.FieldDescriptor(),
	MONTH_CARD_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_CROWN_FIELD = var_0_0.FieldDescriptor(),
	BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD = var_0_0.FieldDescriptor()
}

ACCOUNTINFO = var_0_0.Descriptor()

local var_0_5 = {
	CHANNEL_FIELD = var_0_0.FieldDescriptor(),
	RID_FIELD = var_0_0.FieldDescriptor(),
	UID_FIELD = var_0_0.FieldDescriptor(),
	CID_FIELD = var_0_0.FieldDescriptor(),
	GCID_FIELD = var_0_0.FieldDescriptor(),
	GID_FIELD = var_0_0.FieldDescriptor()
}

LOGININFO = var_0_0.Descriptor()

local var_0_6 = {
	RID_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FIELD = var_0_0.FieldDescriptor(),
	VIP_FIELD = var_0_0.FieldDescriptor(),
	LAST_LOGIN_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FRAME_FIELD = var_0_0.FieldDescriptor(),
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	REG_DATE_FIELD = var_0_0.FieldDescriptor(),
	INGOT_FIELD = var_0_0.FieldDescriptor()
}

UNIONINFO = var_0_0.Descriptor()

local var_0_7 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	TAG_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor(),
	MEMBER_FIELD = var_0_0.FieldDescriptor(),
	ANNOUNCEMENT_FIELD = var_0_0.FieldDescriptor(),
	REQUIRED_LEVEL_FIELD = var_0_0.FieldDescriptor()
}

VISIT = var_0_0.Descriptor()

local var_0_8 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

PROCEDURE = var_0_0.Descriptor()

local var_0_9 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	HEROS_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

RESOURCE = var_0_0.Descriptor()

local var_0_10 = {
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	NUM_FIELD = var_0_0.FieldDescriptor()
}

CARDBOXCARDINFO = var_0_0.Descriptor()

local var_0_11 = {
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	GET_NUM_FIELD = var_0_0.FieldDescriptor(),
	REMAIN_NUM_FIELD = var_0_0.FieldDescriptor()
}

CARDBOX = var_0_0.Descriptor()

local var_0_12 = {
	BOX_ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor()
}

FESTIVALDROP = var_0_0.Descriptor()

local var_0_13 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	RESOURCE_FIELD = var_0_0.FieldDescriptor(),
	WEIGHT_FIELD = var_0_0.FieldDescriptor()
}

FESTIVALBOX = var_0_0.Descriptor()

local var_0_14 = {
	BOX_ID_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_COUNT_FIELD = var_0_0.FieldDescriptor(),
	DROPS_FIELD = var_0_0.FieldDescriptor()
}

LADDERBOX = var_0_0.Descriptor()

local var_0_15 = {
	BOX_ID_FIELD = var_0_0.FieldDescriptor(),
	RESOURCE_FIELD = var_0_0.FieldDescriptor()
}

PARYERLOTTERYDL = var_0_0.Descriptor()

local var_0_16 = {
	CARD_BOX_FIELD = var_0_0.FieldDescriptor(),
	FESTIVAL_BOX_FIELD = var_0_0.FieldDescriptor(),
	LADDER_BOX_FIELD = var_0_0.FieldDescriptor()
}

PAIR = var_0_0.Descriptor()

local var_0_17 = {
	KEY_FIELD = var_0_0.FieldDescriptor(),
	VALUE_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

FESTIVALEXTRALOTTERYDATA = var_0_0.Descriptor()

local var_0_18 = {
	PKG_ID_FIELD = var_0_0.FieldDescriptor(),
	EXTRA_CARDS_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor()
}

PLAYERLOTTERYCOUNT = var_0_0.Descriptor()

local var_0_19 = {
	PKG_ID_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor(),
	SR_COUNT_FIELD = var_0_0.FieldDescriptor(),
	FREE_LOTTERY_COUNT_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_PKG_ID_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_LOTTERY_COUNT_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_UP_PAIRS_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_UP_COUNT_PAIRS_FIELD = var_0_0.FieldDescriptor(),
	FESTIVAL_EXTRAS_FIELD = var_0_0.FieldDescriptor()
}

CHARACTER = var_0_0.Descriptor()

local var_0_20 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	EXP_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FIELD = var_0_0.FieldDescriptor(),
	SKIN_FIELD = var_0_0.FieldDescriptor(),
	BREAK_OUT_FIELD = var_0_0.FieldDescriptor()
}

CHARACTERS = var_0_0.Descriptor()

local var_0_21 = {
	CHARACTER_FIELD = var_0_0.FieldDescriptor()
}

PLAYERCHARACTER = var_0_0.Descriptor()

local var_0_22 = {
	CHAR_ID_FIELD = var_0_0.FieldDescriptor(),
	CHARS_FIELD = var_0_0.FieldDescriptor(),
	LADDER_EVENT_TROPHY_FIELD = var_0_0.FieldDescriptor(),
	IS_DYNAMIC_TIMEOUT_FIELD = var_0_0.FieldDescriptor()
}

CARDLEVEL = var_0_0.Descriptor()

local var_0_23 = {
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor()
}

BUNDLE = var_0_0.Descriptor()

local var_0_24 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	PRODUCT_FIELD = var_0_0.FieldDescriptor(),
	IS_AVAILABLE_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor()
}

BUNDLEEX = var_0_0.Descriptor()

local var_0_25 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	PRODUCT_FIELD = var_0_0.FieldDescriptor(),
	COST_FIELD = var_0_0.FieldDescriptor(),
	IS_AVAILABLE_FIELD = var_0_0.FieldDescriptor()
}

GUARD = var_0_0.Descriptor()

local var_0_26 = {
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	SPAN_FIELD = var_0_0.FieldDescriptor()
}

PKGGUARD = var_0_0.Descriptor()

local var_0_27 = {
	PKG_ID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	SPAN_FIELD = var_0_0.FieldDescriptor()
}

GUARDSLOT = var_0_0.Descriptor()

local var_0_28 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor(),
	GUARD_FIELD = var_0_0.FieldDescriptor()
}

PKGGUARDSLOT = var_0_0.Descriptor()

local var_0_29 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	PKG_GUARD_FIELD = var_0_0.FieldDescriptor()
}

CITY = var_0_0.Descriptor()

local var_0_30 = {
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	CHAPTER_FIELD = var_0_0.FieldDescriptor(),
	OWNER_TYPE_FIELD = var_0_0.FieldDescriptor(),
	OWNER_ID_FIELD = var_0_0.FieldDescriptor(),
	SWEEP_COUNT_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	RESET_COUNT_FIELD = var_0_0.FieldDescriptor()
}

BONUS = var_0_0.Descriptor()

local var_0_31 = {
	CID_FIELD = var_0_0.FieldDescriptor(),
	VALUE_FIELD = var_0_0.FieldDescriptor()
}

EXTRA = var_0_0.Descriptor()

local var_0_32 = {
	RESOURCES_FIELD = var_0_0.FieldDescriptor()
}

ACTIVITYBONUS = var_0_0.Descriptor()

local var_0_33 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	TITLE_FIELD = var_0_0.FieldDescriptor(),
	EXTRA_FIELD = var_0_0.FieldDescriptor(),
	CLAIMED_FIELD = var_0_0.FieldDescriptor()
}

TROOP = var_0_0.Descriptor()

local var_0_34 = {
	TROOP_ITEM_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor()
}

SKININUSE = var_0_0.Descriptor()

local var_0_35 = {
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	SKIN_ID_FIELD = var_0_0.FieldDescriptor(),
	EFFECT_IDS_FIELD = var_0_0.FieldDescriptor()
}

CARDEXTRASKILL = var_0_0.Descriptor()

local var_0_36 = {
	CARD_FIELD = var_0_0.FieldDescriptor(),
	SKILLS_FIELD = var_0_0.FieldDescriptor()
}

TROOPDATA = var_0_0.Descriptor()

local var_0_37 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	HP_FIELD = var_0_0.FieldDescriptor(),
	CARDS_FIELD = var_0_0.FieldDescriptor(),
	INFO_FIELD = var_0_0.FieldDescriptor(),
	ASSISTANT_FIELD = var_0_0.FieldDescriptor(),
	LEVELS_FIELD = var_0_0.FieldDescriptor(),
	SKINS_FIELD = var_0_0.FieldDescriptor(),
	INIT_ROUND_TIMEOUT_FIELD = var_0_0.FieldDescriptor(),
	ROUND_EXTRA_TIMEOUT_FIELD = var_0_0.FieldDescriptor(),
	ROUND_TIMEOUT_FIELD = var_0_0.FieldDescriptor(),
	ROUND_OPTIMIZATION_FIELD = var_0_0.FieldDescriptor(),
	CARD_EXTRA_SKILLS_FIELD = var_0_0.FieldDescriptor()
}

CHEST = var_0_0.Descriptor()

local var_0_38 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	OPENED_FIELD = var_0_0.FieldDescriptor()
}

DROP = var_0_0.Descriptor()

local var_0_39 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor(),
	DROP_FIELD = var_0_0.FieldDescriptor()
}

CHAPTER = var_0_0.Descriptor()

local var_0_40 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	DROPS_FIELD = var_0_0.FieldDescriptor()
}

COPY = var_0_0.Descriptor()

local var_0_41 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	VALUE_FIELD = var_0_0.FieldDescriptor(),
	SCORE_FIELD = var_0_0.FieldDescriptor()
}

TECH = var_0_0.Descriptor()

local var_0_42 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor()
}

PLAYERDROP = var_0_0.Descriptor()

local var_0_43 = {
	CHAPTERS_FIELD = var_0_0.FieldDescriptor()
}

PLAYERCOPY = var_0_0.Descriptor()

local var_0_44 = {
	COPIES_FIELD = var_0_0.FieldDescriptor()
}

SKIN = var_0_0.Descriptor()

local var_0_45 = {
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	DEFAULT_SKIN_FIELD = var_0_0.FieldDescriptor(),
	SKIN_ID_FIELD = var_0_0.FieldDescriptor(),
	EXPIRE_FIELD = var_0_0.FieldDescriptor(),
	DEFAULT_EFFECTS_FIELD = var_0_0.FieldDescriptor()
}

PLAYERCARD = var_0_0.Descriptor()

local var_0_46 = {
	CARDS_FIELD = var_0_0.FieldDescriptor(),
	TROOPS_FIELD = var_0_0.FieldDescriptor(),
	LEVELS_FIELD = var_0_0.FieldDescriptor(),
	UNLOCKED_FIELD = var_0_0.FieldDescriptor(),
	SLOTS_FIELD = var_0_0.FieldDescriptor(),
	SKIN_FIELD = var_0_0.FieldDescriptor(),
	FRAGMENTS_FIELD = var_0_0.FieldDescriptor(),
	DARK_TROOPS_FIELD = var_0_0.FieldDescriptor(),
	ROOM_DARK_TROOPS_FIELD = var_0_0.FieldDescriptor(),
	EXTRA_TROOP_COUNT_FIELD = var_0_0.FieldDescriptor(),
	COLLECTED_FIELD = var_0_0.FieldDescriptor()
}

PLAYERCITY = var_0_0.Descriptor()

local var_0_47 = {
	VISITS_FIELD = var_0_0.FieldDescriptor(),
	PROCEDURES_FIELD = var_0_0.FieldDescriptor(),
	GUARDS_FIELD = var_0_0.FieldDescriptor(),
	LAST_VIST_FIELD = var_0_0.FieldDescriptor(),
	LAST_COLLECT_GOLD_FIELD = var_0_0.FieldDescriptor(),
	LAST_COLLECT_GRAIN_FIELD = var_0_0.FieldDescriptor()
}

PLAYERWORLD = var_0_0.Descriptor()

local var_0_48 = {
	CUR_LEVELS_FIELD = var_0_0.FieldDescriptor()
}

YYBGIFT = var_0_0.Descriptor()

local var_0_49 = {
	BONUS_ID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

PLAYERBONUS = var_0_0.Descriptor()

local var_0_50 = {
	BONUSES_FIELD = var_0_0.FieldDescriptor(),
	CLAIMED_FIELD = var_0_0.FieldDescriptor(),
	ITEMS_FIELD = var_0_0.FieldDescriptor(),
	GIFTS_FIELD = var_0_0.FieldDescriptor(),
	TASK_RESET_COUNT_FIELD = var_0_0.FieldDescriptor()
}

PLAYERPROP = var_0_0.Descriptor()

local var_0_51 = {
	PROPS_FIELD = var_0_0.FieldDescriptor(),
	CHESTS_FIELD = var_0_0.FieldDescriptor(),
	MARKS_FIELD = var_0_0.FieldDescriptor(),
	CROWNS_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_CROWNS_FIELD = var_0_0.FieldDescriptor(),
	CUR_LEGEND_CROWN_FIELD = var_0_0.FieldDescriptor(),
	LAST_LEGEND_CROWN_TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

BUNDLELIMIT = var_0_0.Descriptor()

local var_0_52 = {
	BUNDLE_ID_FIELD = var_0_0.FieldDescriptor(),
	LIMIT_FIELD = var_0_0.FieldDescriptor()
}

PLAYERSHOP = var_0_0.Descriptor()

local var_0_53 = {
	NEXT_REFRESH_FIELD = var_0_0.FieldDescriptor(),
	BUNDLES_FIELD = var_0_0.FieldDescriptor(),
	PVP_BUNDLES_FIELD = var_0_0.FieldDescriptor(),
	LAST_OPEN_FIELD = var_0_0.FieldDescriptor(),
	MYST_BUNDLES_FIELD = var_0_0.FieldDescriptor(),
	LADDER_BUNDLES_FIELD = var_0_0.FieldDescriptor(),
	GIFTS_FIELD = var_0_0.FieldDescriptor(),
	LAST_GIFT_FIELD = var_0_0.FieldDescriptor(),
	RARE_BUNDLES_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_BUNDLES_FIELD = var_0_0.FieldDescriptor(),
	EXCHANGE_PROP_LIMIT_FIELD = var_0_0.FieldDescriptor(),
	RECYCLE_CARD_LIMIT_FIELD = var_0_0.FieldDescriptor(),
	RUBBING_LIMIT_FIELD = var_0_0.FieldDescriptor(),
	BADGE_BUNDLES_FIELD = var_0_0.FieldDescriptor()
}

PLAYEREXPEDITION = var_0_0.Descriptor()

local var_0_54 = {
	CHAPTER_FIELD = var_0_0.FieldDescriptor(),
	CHESTS_FIELD = var_0_0.FieldDescriptor(),
	TROOPS_FIELD = var_0_0.FieldDescriptor(),
	SWEEP_CHAPTER_FIELD = var_0_0.FieldDescriptor(),
	RECOVER_COUNT_FIELD = var_0_0.FieldDescriptor()
}

EXPEDITIONEXNPC = var_0_0.Descriptor()

local var_0_55 = {
	TROOP_DATA_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor(),
	RANDOM_POSITION_FIELD = var_0_0.FieldDescriptor(),
	NEXT_REFRESH_FIELD = var_0_0.FieldDescriptor(),
	CHANLLENGE_COUNT_FIELD = var_0_0.FieldDescriptor()
}

EXPEDITIONEXBOSS = var_0_0.Descriptor()

local var_0_56 = {
	BOSS_FIELD = var_0_0.FieldDescriptor(),
	CHANLLENGE_COUNT_FIELD = var_0_0.FieldDescriptor(),
	RANDOM_POSITION_FIELD = var_0_0.FieldDescriptor(),
	NEXT_REFRESH_FIELD = var_0_0.FieldDescriptor()
}

PLAYEREXPEDITIONEX = var_0_0.Descriptor()

local var_0_57 = {
	LAST_NPC_UPDATE_TIME_FIELD = var_0_0.FieldDescriptor(),
	LAST_BOSS_UPDATE_TIME_FIELD = var_0_0.FieldDescriptor(),
	LAST_LOTTERY_POWER_UPDATE_TIME_FIELD = var_0_0.FieldDescriptor(),
	TROOPS_FIELD = var_0_0.FieldDescriptor(),
	BOSS_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_POWER_FIELD = var_0_0.FieldDescriptor(),
	NEXT_REFRESH_FIELD = var_0_0.FieldDescriptor(),
	CUR_NPC_FIELD = var_0_0.FieldDescriptor()
}

TEAMINFO = var_0_0.Descriptor()

local var_0_58 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	SCORE_FIELD = var_0_0.FieldDescriptor(),
	SCORE_UPDATE_TIME_FIELD = var_0_0.FieldDescriptor()
}

PLAYERUNION = var_0_0.Descriptor()

local var_0_59 = {
	NEXT_REFRESH_FIELD = var_0_0.FieldDescriptor(),
	BUNDLES_FIELD = var_0_0.FieldDescriptor(),
	CARDS_FIELD = var_0_0.FieldDescriptor(),
	LAST_RENT_FIELD = var_0_0.FieldDescriptor(),
	RENTED_FIELD = var_0_0.FieldDescriptor(),
	BONUSES_FIELD = var_0_0.FieldDescriptor(),
	TECHS_FIELD = var_0_0.FieldDescriptor(),
	TEAM_INFO_FIELD = var_0_0.FieldDescriptor()
}

FUNDSTATUS = var_0_0.Descriptor()

local var_0_60 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	BUY_TIME_FIELD = var_0_0.FieldDescriptor()
}

PLAYERACTIVITY = var_0_0.Descriptor()

local var_0_61 = {
	LOGIN_FIELD = var_0_0.FieldDescriptor(),
	CHARGE_FIELD = var_0_0.FieldDescriptor(),
	GHOST_FIELD = var_0_0.FieldDescriptor(),
	CONSUME_FIELD = var_0_0.FieldDescriptor(),
	LAST_LOGIN_FIELD = var_0_0.FieldDescriptor(),
	LAST_CHARGE_FIELD = var_0_0.FieldDescriptor(),
	LAST_GHOST_FIELD = var_0_0.FieldDescriptor(),
	LAST_CONSUME_FIELD = var_0_0.FieldDescriptor(),
	REBATE_FIELD = var_0_0.FieldDescriptor(),
	LAST_REBATE_FIELD = var_0_0.FieldDescriptor(),
	BONUS_FIELD = var_0_0.FieldDescriptor(),
	LAST_BONUS_FIELD = var_0_0.FieldDescriptor(),
	BUNDLES_FIELD = var_0_0.FieldDescriptor(),
	LAST_MARKET_FIELD = var_0_0.FieldDescriptor(),
	CHARGE_EX_FIELD = var_0_0.FieldDescriptor(),
	LAST_CHARGE_EX_FIELD = var_0_0.FieldDescriptor(),
	LAST_PKG_CARD_FIELD = var_0_0.FieldDescriptor(),
	LAST_PKG_GIFT_FIELD = var_0_0.FieldDescriptor(),
	LAST_PKG_GIFT_INGOT_FIELD = var_0_0.FieldDescriptor(),
	LAST_PKG_GIFT_MULTIPLE1_FIELD = var_0_0.FieldDescriptor(),
	LAST_PKG_GIFT_MULTIPLE2_FIELD = var_0_0.FieldDescriptor(),
	PRIVILEGE_STAMP_FIELD = var_0_0.FieldDescriptor(),
	LADDER_DAILY_DROP_FIELD = var_0_0.FieldDescriptor(),
	LADDER_EX_DAILY_DROP_FIELD = var_0_0.FieldDescriptor(),
	DARK_DAILY_DROP_FIELD = var_0_0.FieldDescriptor(),
	MAX_DARK_SCORE_FIELD = var_0_0.FieldDescriptor(),
	LAST_MAX_DARK_SCORE_FIELD = var_0_0.FieldDescriptor(),
	LAST_PKG_GIFT_MULTIPLE0_FIELD = var_0_0.FieldDescriptor(),
	SURVIVAL_DAILY_DROP_FIELD = var_0_0.FieldDescriptor(),
	PERSONAL_FUND_STATUS_FIELD = var_0_0.FieldDescriptor(),
	LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD = var_0_0.FieldDescriptor(),
	DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD = var_0_0.FieldDescriptor(),
	BADGE_LEVEL_FIELD = var_0_0.FieldDescriptor(),
	BADGE_EXP_FIELD = var_0_0.FieldDescriptor(),
	BADGE_PURCHASED_FIELD = var_0_0.FieldDescriptor(),
	BADGE_SEASON_FIELD = var_0_0.FieldDescriptor(),
	BADGE_END_TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	BADGE_LADDER_GAIN_WEELY_FIELD = var_0_0.FieldDescriptor(),
	BADGE_MATCH_GAIN_WEEKLY_FIELD = var_0_0.FieldDescriptor(),
	TURN_TABLE_COUNT_FIELD = var_0_0.FieldDescriptor(),
	LAST_TURN_TABLE_LOTTERY_FIELD = var_0_0.FieldDescriptor(),
	LAST_LADDER_EX_PRIVILEGE_FIELD = var_0_0.FieldDescriptor(),
	LADDER_ACITIVTY_TROPHY_FIELD = var_0_0.FieldDescriptor(),
	LAST_LADDER_ACITIVTY_TROPHY_FIELD = var_0_0.FieldDescriptor(),
	PACKAGE_GOT_INFO_FIELD = var_0_0.FieldDescriptor(),
	SURVIVAL_EX_DAILY_DROP_FIELD = var_0_0.FieldDescriptor(),
	LAST_SURVIVAL_EX_PRIVILEGE_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_DAILY_DROP_FIELD = var_0_0.FieldDescriptor(),
	SPRING_BADGE_LEVEL_FIELD = var_0_0.FieldDescriptor(),
	SPRING_BADGE_EXP_FIELD = var_0_0.FieldDescriptor(),
	SPRING_BADGE_PURCHASED_FIELD = var_0_0.FieldDescriptor(),
	SPRING_BADGE_SEASON_FIELD = var_0_0.FieldDescriptor(),
	SPRING_BADGE_END_TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	SPRING_BADGE_LADDER_GAIN_WEELY_FIELD = var_0_0.FieldDescriptor(),
	SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD = var_0_0.FieldDescriptor(),
	SPRING2_BADGE_LEVEL_FIELD = var_0_0.FieldDescriptor(),
	SPRING2_BADGE_EXP_FIELD = var_0_0.FieldDescriptor(),
	SPRING2_BADGE_PURCHASED_FIELD = var_0_0.FieldDescriptor(),
	SPRING2_BADGE_SEASON_FIELD = var_0_0.FieldDescriptor(),
	SPRING2_BADGE_END_TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD = var_0_0.FieldDescriptor(),
	SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD = var_0_0.FieldDescriptor()
}

PLAYERLADDER = var_0_0.Descriptor()

local var_0_62 = {
	HAS_TICKET_FIELD = var_0_0.FieldDescriptor(),
	CHAR_ID_FIELD = var_0_0.FieldDescriptor(),
	STEP_FIELD = var_0_0.FieldDescriptor(),
	POOL_FIELD = var_0_0.FieldDescriptor(),
	CARDS_FIELD = var_0_0.FieldDescriptor(),
	WIN_FIELD = var_0_0.FieldDescriptor(),
	LOSE_FIELD = var_0_0.FieldDescriptor(),
	CHEST_FIELD = var_0_0.FieldDescriptor(),
	CHARS_FIELD = var_0_0.FieldDescriptor(),
	SELECTED_FIELD = var_0_0.FieldDescriptor(),
	DAILY_WIN_FIELD = var_0_0.FieldDescriptor(),
	ROLL_TIMES_FIELD = var_0_0.FieldDescriptor(),
	USED_EXTRA_LOSE_TIMES_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_TICKET_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_WIN_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_LOSE_FIELD = var_0_0.FieldDescriptor(),
	DAILY_LEGEND_WIN_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_CHEST_FIELD = var_0_0.FieldDescriptor(),
	CHEAT_COUNT_FIELD = var_0_0.FieldDescriptor()
}

PLAYERDARK = var_0_0.Descriptor()

local var_0_63 = {
	INNING_FIELD = var_0_0.FieldDescriptor(),
	SCORE_FIELD = var_0_0.FieldDescriptor(),
	WIN_FIELD = var_0_0.FieldDescriptor(),
	OPWIN_FIELD = var_0_0.FieldDescriptor()
}

PLAYERSURVIVAL = var_0_0.Descriptor()

local var_0_64 = {
	HAS_TICKET_FIELD = var_0_0.FieldDescriptor(),
	CHAR_ID_FIELD = var_0_0.FieldDescriptor(),
	STEP_FIELD = var_0_0.FieldDescriptor(),
	POOL_FIELD = var_0_0.FieldDescriptor(),
	CARDS_FIELD = var_0_0.FieldDescriptor(),
	CHARS_FIELD = var_0_0.FieldDescriptor(),
	SELECTED_FIELD = var_0_0.FieldDescriptor(),
	CAPTURES_FIELD = var_0_0.FieldDescriptor(),
	ADDRESS_FIELD = var_0_0.FieldDescriptor(),
	PRIVILEGE_STAMP_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALEXSKILL = var_0_0.Descriptor()

local var_0_65 = {
	CARD_FIELD = var_0_0.FieldDescriptor(),
	SKILLS_FIELD = var_0_0.FieldDescriptor()
}

PLAYERSURVIVALEX = var_0_0.Descriptor()

local var_0_66 = {
	HAS_TICKET_FIELD = var_0_0.FieldDescriptor(),
	CHAR_ID_FIELD = var_0_0.FieldDescriptor(),
	STEP_FIELD = var_0_0.FieldDescriptor(),
	POOL_FIELD = var_0_0.FieldDescriptor(),
	CARDS_FIELD = var_0_0.FieldDescriptor(),
	CHARS_FIELD = var_0_0.FieldDescriptor(),
	SELECTED_FIELD = var_0_0.FieldDescriptor(),
	CAPTURES_FIELD = var_0_0.FieldDescriptor(),
	ADDRESS_FIELD = var_0_0.FieldDescriptor(),
	CAPTURE_SKILLS_FIELD = var_0_0.FieldDescriptor(),
	PRIVILEGE_STAMP_FIELD = var_0_0.FieldDescriptor(),
	WIN_FIELD = var_0_0.FieldDescriptor(),
	LOSE_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor(),
	ROLL_TIMES_FIELD = var_0_0.FieldDescriptor()
}

BATTLESPOT = var_0_0.Descriptor()

local var_0_67 = {
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	PLAYER_TROOP_FIELD = var_0_0.FieldDescriptor(),
	OPPONENT_TROOP_FIELD = var_0_0.FieldDescriptor(),
	PLAYER_USED_CARDS_FIELD = var_0_0.FieldDescriptor(),
	OPPONENT_USED_CARDS_FIELD = var_0_0.FieldDescriptor(),
	RANDOM_SEQ_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_ID_FIELD = var_0_0.FieldDescriptor(),
	COPY_ID_FIELD = var_0_0.FieldDescriptor(),
	IS_OP_ONLINE_FIELD = var_0_0.FieldDescriptor(),
	IS_OP_SKIP_FIELD = var_0_0.FieldDescriptor(),
	IS_ATTACKER_FIELD = var_0_0.FieldDescriptor(),
	PLAYER_PVP_SOLDIER_FIELD = var_0_0.FieldDescriptor(),
	OPPONENT_PVP_SOLDIER_FIELD = var_0_0.FieldDescriptor(),
	BOSS_ID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	NPC_TYPE_FIELD = var_0_0.FieldDescriptor(),
	IS_WATCHER_FIELD = var_0_0.FieldDescriptor(),
	PLAYER_TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	OPPONENT_TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	RULE_TYPE_FIELD = var_0_0.FieldDescriptor()
}

BATTLERESULT = var_0_0.Descriptor()

local var_0_68 = {
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	TASK_RESULT_FIELD = var_0_0.FieldDescriptor(),
	DAMAGE_FIELD = var_0_0.FieldDescriptor(),
	HP_FIELD = var_0_0.FieldDescriptor(),
	ASSISTANT_DAMAGE_FIELD = var_0_0.FieldDescriptor(),
	ATK_SCORE_FIELD = var_0_0.FieldDescriptor(),
	DEF_SCORE_FIELD = var_0_0.FieldDescriptor(),
	ROUND_FIELD = var_0_0.FieldDescriptor(),
	LOG_FIELD = var_0_0.FieldDescriptor(),
	ATTACKER_STAT_FIELD = var_0_0.FieldDescriptor(),
	DEFENDER_STAT_FIELD = var_0_0.FieldDescriptor(),
	ATTACKER_BATTLE_PASS_FIELD = var_0_0.FieldDescriptor(),
	DEFENDER_BATTLE_PASS_FIELD = var_0_0.FieldDescriptor()
}

ATTACHDATA = var_0_0.Descriptor()

local var_0_69 = {
	PROP_FIELD = var_0_0.FieldDescriptor(),
	SHOP_FIELD = var_0_0.FieldDescriptor(),
	BONUS_FIELD = var_0_0.FieldDescriptor(),
	COPY_FIELD = var_0_0.FieldDescriptor(),
	ACTIVITY_FIELD = var_0_0.FieldDescriptor(),
	CHARACTER_FIELD = var_0_0.FieldDescriptor(),
	LADDER_FIELD = var_0_0.FieldDescriptor(),
	DARK_FIELD = var_0_0.FieldDescriptor(),
	SURVIVAL_FIELD = var_0_0.FieldDescriptor(),
	SURVIVAL_EX_FIELD = var_0_0.FieldDescriptor()
}

UNIONMINI = var_0_0.Descriptor()

local var_0_70 = {
	INFO_FIELD = var_0_0.FieldDescriptor(),
	DATA_FIELD = var_0_0.FieldDescriptor(),
	TECHS_FIELD = var_0_0.FieldDescriptor()
}

CONTESTANT = var_0_0.Descriptor()

local var_0_71 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_FIELD = var_0_0.FieldDescriptor(),
	WIN_FIELD = var_0_0.FieldDescriptor(),
	TROOP_IDS_FIELD = var_0_0.FieldDescriptor(),
	CUR_TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	IS_ONLINE_FIELD = var_0_0.FieldDescriptor()
}

MATCH = var_0_0.Descriptor()

local var_0_72 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	CREATOR_FIELD = var_0_0.FieldDescriptor(),
	PLAYERO_FIELD = var_0_0.FieldDescriptor(),
	PLAYERA_FIELD = var_0_0.FieldDescriptor(),
	PLAYERB_FIELD = var_0_0.FieldDescriptor(),
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	MATCH_HP_FIELD = var_0_0.FieldDescriptor()
}

MATCHINFO = var_0_0.Descriptor()

local var_0_73 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	ADDRESS_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALHALL = var_0_0.Descriptor()

local var_0_74 = {
	ID_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALHALLINFO = var_0_0.Descriptor()

local var_0_75 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	NUM_FIELD = var_0_0.FieldDescriptor(),
	ADDRESS_FIELD = var_0_0.FieldDescriptor(),
	GAMEOVER_TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	IS_IN_HALL_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALEXHALL = var_0_0.Descriptor()

local var_0_76 = {
	ID_FIELD = var_0_0.FieldDescriptor()
}

SURVIVALEXHALLINFO = var_0_0.Descriptor()

local var_0_77 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	NUM_FIELD = var_0_0.FieldDescriptor(),
	ADDRESS_FIELD = var_0_0.FieldDescriptor(),
	GAMEOVER_TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	IS_IN_HALL_FIELD = var_0_0.FieldDescriptor(),
	START_TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

TEAM = var_0_0.Descriptor()

local var_0_78 = {
	RID_FIELD = var_0_0.FieldDescriptor(),
	ID_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FIELD = var_0_0.FieldDescriptor(),
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	MASSWAR_STARTED_FIELD = var_0_0.FieldDescriptor(),
	MASS_WAR_SCORE_FIELD = var_0_0.FieldDescriptor()
}

TEAMLIST = var_0_0.Descriptor()

local var_0_79 = {
	TEAMS_FIELD = var_0_0.FieldDescriptor()
}

FULLTEAM = var_0_0.Descriptor()

local var_0_80 = {
	RID_FIELD = var_0_0.FieldDescriptor(),
	ID_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FIELD = var_0_0.FieldDescriptor(),
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor()
}

TEAMINWORLD = var_0_0.Descriptor()

local var_0_81 = {
	RID_FIELD = var_0_0.FieldDescriptor(),
	ID_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FIELD = var_0_0.FieldDescriptor(),
	ACCOUNT_INFO_FIELD = var_0_0.FieldDescriptor()
}

REPLAYINFO = var_0_0.Descriptor()

local var_0_82 = {
	INFO_FIELD = var_0_0.FieldDescriptor(),
	REPLAY_FIELD = var_0_0.FieldDescriptor(),
	VIP_FIELD = var_0_0.FieldDescriptor(),
	PRETROPHY_FIELD = var_0_0.FieldDescriptor()
}

REPLAYINFOS = var_0_0.Descriptor()

local var_0_83 = {
	REPLAY_INFO_FIELD = var_0_0.FieldDescriptor()
}

MVPINFO = var_0_0.Descriptor()

local var_0_84 = {
	ACCOUNT_INFO_FIELD = var_0_0.FieldDescriptor(),
	MVP_TYPE_FIELD = var_0_0.FieldDescriptor(),
	IS_NEW_FIELD = var_0_0.FieldDescriptor()
}

var_0_1.PB_TYPE_NORMAL.name = "PB_TYPE_NORMAL"
var_0_1.PB_TYPE_NORMAL.index = 0
var_0_1.PB_TYPE_NORMAL.number = 1
var_0_1.PB_TYPE_DARK.name = "PB_TYPE_DARK"
var_0_1.PB_TYPE_DARK.index = 1
var_0_1.PB_TYPE_DARK.number = 2
MATCHTYPE.name = "MatchType"
MATCHTYPE.full_name = ".sgland.MatchType"
MATCHTYPE.values = {
	var_0_1.PB_TYPE_NORMAL,
	var_0_1.PB_TYPE_DARK
}
var_0_2.LADDER_MVP.name = "LADDER_MVP"
var_0_2.LADDER_MVP.index = 0
var_0_2.LADDER_MVP.number = 0
var_0_2.LADDER_EX_MVP.name = "LADDER_EX_MVP"
var_0_2.LADDER_EX_MVP.index = 1
var_0_2.LADDER_EX_MVP.number = 1
var_0_2.DARK_DUEL_MVP.name = "DARK_DUEL_MVP"
var_0_2.DARK_DUEL_MVP.index = 2
var_0_2.DARK_DUEL_MVP.number = 2
var_0_2.MASSWAR_MVP.name = "MASSWAR_MVP"
var_0_2.MASSWAR_MVP.index = 3
var_0_2.MASSWAR_MVP.number = 3
var_0_2.SURVIVAL_MVP.name = "SURVIVAL_MVP"
var_0_2.SURVIVAL_MVP.index = 4
var_0_2.SURVIVAL_MVP.number = 4
var_0_2.SURVIVAL_EX_MVP.name = "SURVIVAL_EX_MVP"
var_0_2.SURVIVAL_EX_MVP.index = 5
var_0_2.SURVIVAL_EX_MVP.number = 5
MVPTYPE.name = "MVPType"
MVPTYPE.full_name = ".sgland.MVPType"
MVPTYPE.values = {
	var_0_2.LADDER_MVP,
	var_0_2.LADDER_EX_MVP,
	var_0_2.DARK_DUEL_MVP,
	var_0_2.MASSWAR_MVP,
	var_0_2.SURVIVAL_MVP,
	var_0_2.SURVIVAL_EX_MVP
}
var_0_3.INFO_ID_FIELD.name = "info_id"
var_0_3.INFO_ID_FIELD.full_name = ".sgland.Crown.info_id"
var_0_3.INFO_ID_FIELD.number = 1
var_0_3.INFO_ID_FIELD.index = 0
var_0_3.INFO_ID_FIELD.label = 2
var_0_3.INFO_ID_FIELD.has_default_value = false
var_0_3.INFO_ID_FIELD.default_value = 0
var_0_3.INFO_ID_FIELD.type = 5
var_0_3.INFO_ID_FIELD.cpp_type = 1
var_0_3.NUM_FIELD.name = "num"
var_0_3.NUM_FIELD.full_name = ".sgland.Crown.num"
var_0_3.NUM_FIELD.number = 2
var_0_3.NUM_FIELD.index = 1
var_0_3.NUM_FIELD.label = 2
var_0_3.NUM_FIELD.has_default_value = false
var_0_3.NUM_FIELD.default_value = 0
var_0_3.NUM_FIELD.type = 5
var_0_3.NUM_FIELD.cpp_type = 1
CROWN.name = "Crown"
CROWN.full_name = ".sgland.Crown"
CROWN.nested_types = {}
CROWN.enum_types = {}
CROWN.fields = {
	var_0_3.INFO_ID_FIELD,
	var_0_3.NUM_FIELD
}
CROWN.is_extendable = false
CROWN.extensions = {}
var_0_4.ID_FIELD.name = "id"
var_0_4.ID_FIELD.full_name = ".sgland.UserInfo.id"
var_0_4.ID_FIELD.number = 1
var_0_4.ID_FIELD.index = 0
var_0_4.ID_FIELD.label = 2
var_0_4.ID_FIELD.has_default_value = false
var_0_4.ID_FIELD.default_value = 0
var_0_4.ID_FIELD.type = 3
var_0_4.ID_FIELD.cpp_type = 2
var_0_4.NAME_FIELD.name = "name"
var_0_4.NAME_FIELD.full_name = ".sgland.UserInfo.name"
var_0_4.NAME_FIELD.number = 2
var_0_4.NAME_FIELD.index = 1
var_0_4.NAME_FIELD.label = 2
var_0_4.NAME_FIELD.has_default_value = false
var_0_4.NAME_FIELD.default_value = ""
var_0_4.NAME_FIELD.type = 9
var_0_4.NAME_FIELD.cpp_type = 9
var_0_4.LEVEL_FIELD.name = "level"
var_0_4.LEVEL_FIELD.full_name = ".sgland.UserInfo.level"
var_0_4.LEVEL_FIELD.number = 3
var_0_4.LEVEL_FIELD.index = 2
var_0_4.LEVEL_FIELD.label = 2
var_0_4.LEVEL_FIELD.has_default_value = false
var_0_4.LEVEL_FIELD.default_value = 0
var_0_4.LEVEL_FIELD.type = 5
var_0_4.LEVEL_FIELD.cpp_type = 1
var_0_4.TROPHY_FIELD.name = "trophy"
var_0_4.TROPHY_FIELD.full_name = ".sgland.UserInfo.trophy"
var_0_4.TROPHY_FIELD.number = 4
var_0_4.TROPHY_FIELD.index = 3
var_0_4.TROPHY_FIELD.label = 2
var_0_4.TROPHY_FIELD.has_default_value = false
var_0_4.TROPHY_FIELD.default_value = 0
var_0_4.TROPHY_FIELD.type = 5
var_0_4.TROPHY_FIELD.cpp_type = 1
var_0_4.AVATAR_FIELD.name = "avatar"
var_0_4.AVATAR_FIELD.full_name = ".sgland.UserInfo.avatar"
var_0_4.AVATAR_FIELD.number = 5
var_0_4.AVATAR_FIELD.index = 4
var_0_4.AVATAR_FIELD.label = 2
var_0_4.AVATAR_FIELD.has_default_value = false
var_0_4.AVATAR_FIELD.default_value = 0
var_0_4.AVATAR_FIELD.type = 5
var_0_4.AVATAR_FIELD.cpp_type = 1
var_0_4.UNION_ID_FIELD.name = "union_id"
var_0_4.UNION_ID_FIELD.full_name = ".sgland.UserInfo.union_id"
var_0_4.UNION_ID_FIELD.number = 6
var_0_4.UNION_ID_FIELD.index = 5
var_0_4.UNION_ID_FIELD.label = 1
var_0_4.UNION_ID_FIELD.has_default_value = false
var_0_4.UNION_ID_FIELD.default_value = 0
var_0_4.UNION_ID_FIELD.type = 3
var_0_4.UNION_ID_FIELD.cpp_type = 2
var_0_4.UNION_NAME_FIELD.name = "union_name"
var_0_4.UNION_NAME_FIELD.full_name = ".sgland.UserInfo.union_name"
var_0_4.UNION_NAME_FIELD.number = 7
var_0_4.UNION_NAME_FIELD.index = 6
var_0_4.UNION_NAME_FIELD.label = 1
var_0_4.UNION_NAME_FIELD.has_default_value = false
var_0_4.UNION_NAME_FIELD.default_value = ""
var_0_4.UNION_NAME_FIELD.type = 9
var_0_4.UNION_NAME_FIELD.cpp_type = 9
var_0_4.UNION_TITLE_FIELD.name = "union_title"
var_0_4.UNION_TITLE_FIELD.full_name = ".sgland.UserInfo.union_title"
var_0_4.UNION_TITLE_FIELD.number = 8
var_0_4.UNION_TITLE_FIELD.index = 7
var_0_4.UNION_TITLE_FIELD.label = 1
var_0_4.UNION_TITLE_FIELD.has_default_value = false
var_0_4.UNION_TITLE_FIELD.default_value = 0
var_0_4.UNION_TITLE_FIELD.type = 5
var_0_4.UNION_TITLE_FIELD.cpp_type = 1
var_0_4.VIP_FIELD.name = "vip"
var_0_4.VIP_FIELD.full_name = ".sgland.UserInfo.vip"
var_0_4.VIP_FIELD.number = 9
var_0_4.VIP_FIELD.index = 8
var_0_4.VIP_FIELD.label = 1
var_0_4.VIP_FIELD.has_default_value = false
var_0_4.VIP_FIELD.default_value = 0
var_0_4.VIP_FIELD.type = 5
var_0_4.VIP_FIELD.cpp_type = 1
var_0_4.LAST_LOGIN_FIELD.name = "last_login"
var_0_4.LAST_LOGIN_FIELD.full_name = ".sgland.UserInfo.last_login"
var_0_4.LAST_LOGIN_FIELD.number = 10
var_0_4.LAST_LOGIN_FIELD.index = 9
var_0_4.LAST_LOGIN_FIELD.label = 1
var_0_4.LAST_LOGIN_FIELD.has_default_value = false
var_0_4.LAST_LOGIN_FIELD.default_value = 0
var_0_4.LAST_LOGIN_FIELD.type = 3
var_0_4.LAST_LOGIN_FIELD.cpp_type = 2
var_0_4.UNION_TAG_FIELD.name = "union_tag"
var_0_4.UNION_TAG_FIELD.full_name = ".sgland.UserInfo.union_tag"
var_0_4.UNION_TAG_FIELD.number = 11
var_0_4.UNION_TAG_FIELD.index = 10
var_0_4.UNION_TAG_FIELD.label = 1
var_0_4.UNION_TAG_FIELD.has_default_value = false
var_0_4.UNION_TAG_FIELD.default_value = ""
var_0_4.UNION_TAG_FIELD.type = 9
var_0_4.UNION_TAG_FIELD.cpp_type = 9
var_0_4.UNION_AVATAR_FIELD.name = "union_avatar"
var_0_4.UNION_AVATAR_FIELD.full_name = ".sgland.UserInfo.union_avatar"
var_0_4.UNION_AVATAR_FIELD.number = 12
var_0_4.UNION_AVATAR_FIELD.index = 11
var_0_4.UNION_AVATAR_FIELD.label = 1
var_0_4.UNION_AVATAR_FIELD.has_default_value = false
var_0_4.UNION_AVATAR_FIELD.default_value = 0
var_0_4.UNION_AVATAR_FIELD.type = 5
var_0_4.UNION_AVATAR_FIELD.cpp_type = 1
var_0_4.CARD_BACK_FIELD.name = "card_back"
var_0_4.CARD_BACK_FIELD.full_name = ".sgland.UserInfo.card_back"
var_0_4.CARD_BACK_FIELD.number = 13
var_0_4.CARD_BACK_FIELD.index = 12
var_0_4.CARD_BACK_FIELD.label = 1
var_0_4.CARD_BACK_FIELD.has_default_value = false
var_0_4.CARD_BACK_FIELD.default_value = 0
var_0_4.CARD_BACK_FIELD.type = 5
var_0_4.CARD_BACK_FIELD.cpp_type = 1
var_0_4.AVATAR_FRAME_FIELD.name = "avatar_frame"
var_0_4.AVATAR_FRAME_FIELD.full_name = ".sgland.UserInfo.avatar_frame"
var_0_4.AVATAR_FRAME_FIELD.number = 14
var_0_4.AVATAR_FRAME_FIELD.index = 13
var_0_4.AVATAR_FRAME_FIELD.label = 1
var_0_4.AVATAR_FRAME_FIELD.has_default_value = false
var_0_4.AVATAR_FRAME_FIELD.default_value = 0
var_0_4.AVATAR_FRAME_FIELD.type = 5
var_0_4.AVATAR_FRAME_FIELD.cpp_type = 1
var_0_4.RID_FIELD.name = "rid"
var_0_4.RID_FIELD.full_name = ".sgland.UserInfo.rid"
var_0_4.RID_FIELD.number = 15
var_0_4.RID_FIELD.index = 14
var_0_4.RID_FIELD.label = 1
var_0_4.RID_FIELD.has_default_value = false
var_0_4.RID_FIELD.default_value = 0
var_0_4.RID_FIELD.type = 5
var_0_4.RID_FIELD.cpp_type = 1
var_0_4.IS_NPC_FIELD.name = "is_npc"
var_0_4.IS_NPC_FIELD.full_name = ".sgland.UserInfo.is_npc"
var_0_4.IS_NPC_FIELD.number = 16
var_0_4.IS_NPC_FIELD.index = 15
var_0_4.IS_NPC_FIELD.label = 1
var_0_4.IS_NPC_FIELD.has_default_value = true
var_0_4.IS_NPC_FIELD.default_value = false
var_0_4.IS_NPC_FIELD.type = 8
var_0_4.IS_NPC_FIELD.cpp_type = 7
var_0_4.CODE_FIELD.name = "code"
var_0_4.CODE_FIELD.full_name = ".sgland.UserInfo.code"
var_0_4.CODE_FIELD.number = 17
var_0_4.CODE_FIELD.index = 16
var_0_4.CODE_FIELD.label = 1
var_0_4.CODE_FIELD.has_default_value = false
var_0_4.CODE_FIELD.default_value = ""
var_0_4.CODE_FIELD.type = 9
var_0_4.CODE_FIELD.cpp_type = 9
var_0_4.CROWN_FIELD.name = "crown"
var_0_4.CROWN_FIELD.full_name = ".sgland.UserInfo.crown"
var_0_4.CROWN_FIELD.number = 18
var_0_4.CROWN_FIELD.index = 17
var_0_4.CROWN_FIELD.label = 1
var_0_4.CROWN_FIELD.has_default_value = false
var_0_4.CROWN_FIELD.default_value = nil
var_0_4.CROWN_FIELD.message_type = CROWN
var_0_4.CROWN_FIELD.type = 11
var_0_4.CROWN_FIELD.cpp_type = 10
var_0_4.AVATAR_FRAME_COUNT_FIELD.name = "avatar_frame_count"
var_0_4.AVATAR_FRAME_COUNT_FIELD.full_name = ".sgland.UserInfo.avatar_frame_count"
var_0_4.AVATAR_FRAME_COUNT_FIELD.number = 19
var_0_4.AVATAR_FRAME_COUNT_FIELD.index = 18
var_0_4.AVATAR_FRAME_COUNT_FIELD.label = 1
var_0_4.AVATAR_FRAME_COUNT_FIELD.has_default_value = false
var_0_4.AVATAR_FRAME_COUNT_FIELD.default_value = 0
var_0_4.AVATAR_FRAME_COUNT_FIELD.type = 5
var_0_4.AVATAR_FRAME_COUNT_FIELD.cpp_type = 1
var_0_4.MASS_WAR_SCORE_FIELD.name = "mass_war_score"
var_0_4.MASS_WAR_SCORE_FIELD.full_name = ".sgland.UserInfo.mass_war_score"
var_0_4.MASS_WAR_SCORE_FIELD.number = 20
var_0_4.MASS_WAR_SCORE_FIELD.index = 19
var_0_4.MASS_WAR_SCORE_FIELD.label = 1
var_0_4.MASS_WAR_SCORE_FIELD.has_default_value = false
var_0_4.MASS_WAR_SCORE_FIELD.default_value = 0
var_0_4.MASS_WAR_SCORE_FIELD.type = 5
var_0_4.MASS_WAR_SCORE_FIELD.cpp_type = 1
var_0_4.PRIVILEGE_FIELD.name = "privilege"
var_0_4.PRIVILEGE_FIELD.full_name = ".sgland.UserInfo.privilege"
var_0_4.PRIVILEGE_FIELD.number = 21
var_0_4.PRIVILEGE_FIELD.index = 20
var_0_4.PRIVILEGE_FIELD.label = 1
var_0_4.PRIVILEGE_FIELD.has_default_value = false
var_0_4.PRIVILEGE_FIELD.default_value = 0
var_0_4.PRIVILEGE_FIELD.type = 5
var_0_4.PRIVILEGE_FIELD.cpp_type = 1
var_0_4.MONTH_CARD_FIELD.name = "month_card"
var_0_4.MONTH_CARD_FIELD.full_name = ".sgland.UserInfo.month_card"
var_0_4.MONTH_CARD_FIELD.number = 22
var_0_4.MONTH_CARD_FIELD.index = 21
var_0_4.MONTH_CARD_FIELD.label = 1
var_0_4.MONTH_CARD_FIELD.has_default_value = false
var_0_4.MONTH_CARD_FIELD.default_value = 0
var_0_4.MONTH_CARD_FIELD.type = 5
var_0_4.MONTH_CARD_FIELD.cpp_type = 1
var_0_4.LEGEND_CROWN_FIELD.name = "legend_crown"
var_0_4.LEGEND_CROWN_FIELD.full_name = ".sgland.UserInfo.legend_crown"
var_0_4.LEGEND_CROWN_FIELD.number = 23
var_0_4.LEGEND_CROWN_FIELD.index = 22
var_0_4.LEGEND_CROWN_FIELD.label = 1
var_0_4.LEGEND_CROWN_FIELD.has_default_value = false
var_0_4.LEGEND_CROWN_FIELD.default_value = nil
var_0_4.LEGEND_CROWN_FIELD.message_type = CROWN
var_0_4.LEGEND_CROWN_FIELD.type = 11
var_0_4.LEGEND_CROWN_FIELD.cpp_type = 10
var_0_4.BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD.name = "battle_round_extra_time_flag"
var_0_4.BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD.full_name = ".sgland.UserInfo.battle_round_extra_time_flag"
var_0_4.BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD.number = 24
var_0_4.BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD.index = 23
var_0_4.BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD.label = 1
var_0_4.BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD.has_default_value = false
var_0_4.BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD.default_value = 0
var_0_4.BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD.type = 5
var_0_4.BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD.cpp_type = 1
USERINFO.name = "UserInfo"
USERINFO.full_name = ".sgland.UserInfo"
USERINFO.nested_types = {}
USERINFO.enum_types = {}
USERINFO.fields = {
	var_0_4.ID_FIELD,
	var_0_4.NAME_FIELD,
	var_0_4.LEVEL_FIELD,
	var_0_4.TROPHY_FIELD,
	var_0_4.AVATAR_FIELD,
	var_0_4.UNION_ID_FIELD,
	var_0_4.UNION_NAME_FIELD,
	var_0_4.UNION_TITLE_FIELD,
	var_0_4.VIP_FIELD,
	var_0_4.LAST_LOGIN_FIELD,
	var_0_4.UNION_TAG_FIELD,
	var_0_4.UNION_AVATAR_FIELD,
	var_0_4.CARD_BACK_FIELD,
	var_0_4.AVATAR_FRAME_FIELD,
	var_0_4.RID_FIELD,
	var_0_4.IS_NPC_FIELD,
	var_0_4.CODE_FIELD,
	var_0_4.CROWN_FIELD,
	var_0_4.AVATAR_FRAME_COUNT_FIELD,
	var_0_4.MASS_WAR_SCORE_FIELD,
	var_0_4.PRIVILEGE_FIELD,
	var_0_4.MONTH_CARD_FIELD,
	var_0_4.LEGEND_CROWN_FIELD,
	var_0_4.BATTLE_ROUND_EXTRA_TIME_FLAG_FIELD
}
USERINFO.is_extendable = false
USERINFO.extensions = {}
var_0_5.CHANNEL_FIELD.name = "channel"
var_0_5.CHANNEL_FIELD.full_name = ".sgland.AccountInfo.channel"
var_0_5.CHANNEL_FIELD.number = 1
var_0_5.CHANNEL_FIELD.index = 0
var_0_5.CHANNEL_FIELD.label = 2
var_0_5.CHANNEL_FIELD.has_default_value = false
var_0_5.CHANNEL_FIELD.default_value = ""
var_0_5.CHANNEL_FIELD.type = 9
var_0_5.CHANNEL_FIELD.cpp_type = 9
var_0_5.RID_FIELD.name = "rid"
var_0_5.RID_FIELD.full_name = ".sgland.AccountInfo.rid"
var_0_5.RID_FIELD.number = 2
var_0_5.RID_FIELD.index = 1
var_0_5.RID_FIELD.label = 2
var_0_5.RID_FIELD.has_default_value = false
var_0_5.RID_FIELD.default_value = 0
var_0_5.RID_FIELD.type = 5
var_0_5.RID_FIELD.cpp_type = 1
var_0_5.UID_FIELD.name = "uid"
var_0_5.UID_FIELD.full_name = ".sgland.AccountInfo.uid"
var_0_5.UID_FIELD.number = 3
var_0_5.UID_FIELD.index = 2
var_0_5.UID_FIELD.label = 1
var_0_5.UID_FIELD.has_default_value = false
var_0_5.UID_FIELD.default_value = ""
var_0_5.UID_FIELD.type = 9
var_0_5.UID_FIELD.cpp_type = 9
var_0_5.CID_FIELD.name = "cid"
var_0_5.CID_FIELD.full_name = ".sgland.AccountInfo.cid"
var_0_5.CID_FIELD.number = 4
var_0_5.CID_FIELD.index = 3
var_0_5.CID_FIELD.label = 2
var_0_5.CID_FIELD.has_default_value = false
var_0_5.CID_FIELD.default_value = ""
var_0_5.CID_FIELD.type = 9
var_0_5.CID_FIELD.cpp_type = 9
var_0_5.GCID_FIELD.name = "gcid"
var_0_5.GCID_FIELD.full_name = ".sgland.AccountInfo.gcid"
var_0_5.GCID_FIELD.number = 5
var_0_5.GCID_FIELD.index = 4
var_0_5.GCID_FIELD.label = 1
var_0_5.GCID_FIELD.has_default_value = false
var_0_5.GCID_FIELD.default_value = ""
var_0_5.GCID_FIELD.type = 9
var_0_5.GCID_FIELD.cpp_type = 9
var_0_5.GID_FIELD.name = "gid"
var_0_5.GID_FIELD.full_name = ".sgland.AccountInfo.gid"
var_0_5.GID_FIELD.number = 6
var_0_5.GID_FIELD.index = 5
var_0_5.GID_FIELD.label = 1
var_0_5.GID_FIELD.has_default_value = false
var_0_5.GID_FIELD.default_value = 0
var_0_5.GID_FIELD.type = 3
var_0_5.GID_FIELD.cpp_type = 2
ACCOUNTINFO.name = "AccountInfo"
ACCOUNTINFO.full_name = ".sgland.AccountInfo"
ACCOUNTINFO.nested_types = {}
ACCOUNTINFO.enum_types = {}
ACCOUNTINFO.fields = {
	var_0_5.CHANNEL_FIELD,
	var_0_5.RID_FIELD,
	var_0_5.UID_FIELD,
	var_0_5.CID_FIELD,
	var_0_5.GCID_FIELD,
	var_0_5.GID_FIELD
}
ACCOUNTINFO.is_extendable = false
ACCOUNTINFO.extensions = {}
var_0_6.RID_FIELD.name = "rid"
var_0_6.RID_FIELD.full_name = ".sgland.LoginInfo.rid"
var_0_6.RID_FIELD.number = 1
var_0_6.RID_FIELD.index = 0
var_0_6.RID_FIELD.label = 2
var_0_6.RID_FIELD.has_default_value = false
var_0_6.RID_FIELD.default_value = 0
var_0_6.RID_FIELD.type = 5
var_0_6.RID_FIELD.cpp_type = 1
var_0_6.NAME_FIELD.name = "name"
var_0_6.NAME_FIELD.full_name = ".sgland.LoginInfo.name"
var_0_6.NAME_FIELD.number = 2
var_0_6.NAME_FIELD.index = 1
var_0_6.NAME_FIELD.label = 2
var_0_6.NAME_FIELD.has_default_value = false
var_0_6.NAME_FIELD.default_value = ""
var_0_6.NAME_FIELD.type = 9
var_0_6.NAME_FIELD.cpp_type = 9
var_0_6.LEVEL_FIELD.name = "level"
var_0_6.LEVEL_FIELD.full_name = ".sgland.LoginInfo.level"
var_0_6.LEVEL_FIELD.number = 3
var_0_6.LEVEL_FIELD.index = 2
var_0_6.LEVEL_FIELD.label = 2
var_0_6.LEVEL_FIELD.has_default_value = false
var_0_6.LEVEL_FIELD.default_value = 0
var_0_6.LEVEL_FIELD.type = 5
var_0_6.LEVEL_FIELD.cpp_type = 1
var_0_6.AVATAR_FIELD.name = "avatar"
var_0_6.AVATAR_FIELD.full_name = ".sgland.LoginInfo.avatar"
var_0_6.AVATAR_FIELD.number = 4
var_0_6.AVATAR_FIELD.index = 3
var_0_6.AVATAR_FIELD.label = 2
var_0_6.AVATAR_FIELD.has_default_value = false
var_0_6.AVATAR_FIELD.default_value = 0
var_0_6.AVATAR_FIELD.type = 5
var_0_6.AVATAR_FIELD.cpp_type = 1
var_0_6.VIP_FIELD.name = "vip"
var_0_6.VIP_FIELD.full_name = ".sgland.LoginInfo.vip"
var_0_6.VIP_FIELD.number = 5
var_0_6.VIP_FIELD.index = 4
var_0_6.VIP_FIELD.label = 2
var_0_6.VIP_FIELD.has_default_value = false
var_0_6.VIP_FIELD.default_value = 0
var_0_6.VIP_FIELD.type = 5
var_0_6.VIP_FIELD.cpp_type = 1
var_0_6.LAST_LOGIN_FIELD.name = "last_login"
var_0_6.LAST_LOGIN_FIELD.full_name = ".sgland.LoginInfo.last_login"
var_0_6.LAST_LOGIN_FIELD.number = 6
var_0_6.LAST_LOGIN_FIELD.index = 5
var_0_6.LAST_LOGIN_FIELD.label = 1
var_0_6.LAST_LOGIN_FIELD.has_default_value = false
var_0_6.LAST_LOGIN_FIELD.default_value = 0
var_0_6.LAST_LOGIN_FIELD.type = 3
var_0_6.LAST_LOGIN_FIELD.cpp_type = 2
var_0_6.AVATAR_FRAME_FIELD.name = "avatar_frame"
var_0_6.AVATAR_FRAME_FIELD.full_name = ".sgland.LoginInfo.avatar_frame"
var_0_6.AVATAR_FRAME_FIELD.number = 7
var_0_6.AVATAR_FRAME_FIELD.index = 6
var_0_6.AVATAR_FRAME_FIELD.label = 1
var_0_6.AVATAR_FRAME_FIELD.has_default_value = false
var_0_6.AVATAR_FRAME_FIELD.default_value = 0
var_0_6.AVATAR_FRAME_FIELD.type = 5
var_0_6.AVATAR_FRAME_FIELD.cpp_type = 1
var_0_6.USER_ID_FIELD.name = "user_id"
var_0_6.USER_ID_FIELD.full_name = ".sgland.LoginInfo.user_id"
var_0_6.USER_ID_FIELD.number = 8
var_0_6.USER_ID_FIELD.index = 7
var_0_6.USER_ID_FIELD.label = 1
var_0_6.USER_ID_FIELD.has_default_value = false
var_0_6.USER_ID_FIELD.default_value = 0
var_0_6.USER_ID_FIELD.type = 3
var_0_6.USER_ID_FIELD.cpp_type = 2
var_0_6.REG_DATE_FIELD.name = "reg_date"
var_0_6.REG_DATE_FIELD.full_name = ".sgland.LoginInfo.reg_date"
var_0_6.REG_DATE_FIELD.number = 9
var_0_6.REG_DATE_FIELD.index = 8
var_0_6.REG_DATE_FIELD.label = 1
var_0_6.REG_DATE_FIELD.has_default_value = false
var_0_6.REG_DATE_FIELD.default_value = 0
var_0_6.REG_DATE_FIELD.type = 3
var_0_6.REG_DATE_FIELD.cpp_type = 2
var_0_6.INGOT_FIELD.name = "ingot"
var_0_6.INGOT_FIELD.full_name = ".sgland.LoginInfo.ingot"
var_0_6.INGOT_FIELD.number = 10
var_0_6.INGOT_FIELD.index = 9
var_0_6.INGOT_FIELD.label = 1
var_0_6.INGOT_FIELD.has_default_value = false
var_0_6.INGOT_FIELD.default_value = 0
var_0_6.INGOT_FIELD.type = 5
var_0_6.INGOT_FIELD.cpp_type = 1
LOGININFO.name = "LoginInfo"
LOGININFO.full_name = ".sgland.LoginInfo"
LOGININFO.nested_types = {}
LOGININFO.enum_types = {}
LOGININFO.fields = {
	var_0_6.RID_FIELD,
	var_0_6.NAME_FIELD,
	var_0_6.LEVEL_FIELD,
	var_0_6.AVATAR_FIELD,
	var_0_6.VIP_FIELD,
	var_0_6.LAST_LOGIN_FIELD,
	var_0_6.AVATAR_FRAME_FIELD,
	var_0_6.USER_ID_FIELD,
	var_0_6.REG_DATE_FIELD,
	var_0_6.INGOT_FIELD
}
LOGININFO.is_extendable = false
LOGININFO.extensions = {}
var_0_7.ID_FIELD.name = "id"
var_0_7.ID_FIELD.full_name = ".sgland.UnionInfo.id"
var_0_7.ID_FIELD.number = 1
var_0_7.ID_FIELD.index = 0
var_0_7.ID_FIELD.label = 2
var_0_7.ID_FIELD.has_default_value = false
var_0_7.ID_FIELD.default_value = 0
var_0_7.ID_FIELD.type = 3
var_0_7.ID_FIELD.cpp_type = 2
var_0_7.NAME_FIELD.name = "name"
var_0_7.NAME_FIELD.full_name = ".sgland.UnionInfo.name"
var_0_7.NAME_FIELD.number = 2
var_0_7.NAME_FIELD.index = 1
var_0_7.NAME_FIELD.label = 2
var_0_7.NAME_FIELD.has_default_value = false
var_0_7.NAME_FIELD.default_value = ""
var_0_7.NAME_FIELD.type = 9
var_0_7.NAME_FIELD.cpp_type = 9
var_0_7.AVATAR_FIELD.name = "avatar"
var_0_7.AVATAR_FIELD.full_name = ".sgland.UnionInfo.avatar"
var_0_7.AVATAR_FIELD.number = 3
var_0_7.AVATAR_FIELD.index = 2
var_0_7.AVATAR_FIELD.label = 2
var_0_7.AVATAR_FIELD.has_default_value = false
var_0_7.AVATAR_FIELD.default_value = 0
var_0_7.AVATAR_FIELD.type = 5
var_0_7.AVATAR_FIELD.cpp_type = 1
var_0_7.TYPE_FIELD.name = "type"
var_0_7.TYPE_FIELD.full_name = ".sgland.UnionInfo.type"
var_0_7.TYPE_FIELD.number = 4
var_0_7.TYPE_FIELD.index = 3
var_0_7.TYPE_FIELD.label = 2
var_0_7.TYPE_FIELD.has_default_value = false
var_0_7.TYPE_FIELD.default_value = 0
var_0_7.TYPE_FIELD.type = 5
var_0_7.TYPE_FIELD.cpp_type = 1
var_0_7.TAG_FIELD.name = "tag"
var_0_7.TAG_FIELD.full_name = ".sgland.UnionInfo.tag"
var_0_7.TAG_FIELD.number = 5
var_0_7.TAG_FIELD.index = 4
var_0_7.TAG_FIELD.label = 2
var_0_7.TAG_FIELD.has_default_value = false
var_0_7.TAG_FIELD.default_value = ""
var_0_7.TAG_FIELD.type = 9
var_0_7.TAG_FIELD.cpp_type = 9
var_0_7.LEVEL_FIELD.name = "level"
var_0_7.LEVEL_FIELD.full_name = ".sgland.UnionInfo.level"
var_0_7.LEVEL_FIELD.number = 6
var_0_7.LEVEL_FIELD.index = 5
var_0_7.LEVEL_FIELD.label = 2
var_0_7.LEVEL_FIELD.has_default_value = false
var_0_7.LEVEL_FIELD.default_value = 0
var_0_7.LEVEL_FIELD.type = 5
var_0_7.LEVEL_FIELD.cpp_type = 1
var_0_7.MEMBER_FIELD.name = "member"
var_0_7.MEMBER_FIELD.full_name = ".sgland.UnionInfo.member"
var_0_7.MEMBER_FIELD.number = 7
var_0_7.MEMBER_FIELD.index = 6
var_0_7.MEMBER_FIELD.label = 2
var_0_7.MEMBER_FIELD.has_default_value = false
var_0_7.MEMBER_FIELD.default_value = 0
var_0_7.MEMBER_FIELD.type = 5
var_0_7.MEMBER_FIELD.cpp_type = 1
var_0_7.ANNOUNCEMENT_FIELD.name = "announcement"
var_0_7.ANNOUNCEMENT_FIELD.full_name = ".sgland.UnionInfo.announcement"
var_0_7.ANNOUNCEMENT_FIELD.number = 8
var_0_7.ANNOUNCEMENT_FIELD.index = 7
var_0_7.ANNOUNCEMENT_FIELD.label = 2
var_0_7.ANNOUNCEMENT_FIELD.has_default_value = false
var_0_7.ANNOUNCEMENT_FIELD.default_value = ""
var_0_7.ANNOUNCEMENT_FIELD.type = 9
var_0_7.ANNOUNCEMENT_FIELD.cpp_type = 9
var_0_7.REQUIRED_LEVEL_FIELD.name = "required_level"
var_0_7.REQUIRED_LEVEL_FIELD.full_name = ".sgland.UnionInfo.required_level"
var_0_7.REQUIRED_LEVEL_FIELD.number = 9
var_0_7.REQUIRED_LEVEL_FIELD.index = 8
var_0_7.REQUIRED_LEVEL_FIELD.label = 2
var_0_7.REQUIRED_LEVEL_FIELD.has_default_value = false
var_0_7.REQUIRED_LEVEL_FIELD.default_value = 0
var_0_7.REQUIRED_LEVEL_FIELD.type = 5
var_0_7.REQUIRED_LEVEL_FIELD.cpp_type = 1
UNIONINFO.name = "UnionInfo"
UNIONINFO.full_name = ".sgland.UnionInfo"
UNIONINFO.nested_types = {}
UNIONINFO.enum_types = {}
UNIONINFO.fields = {
	var_0_7.ID_FIELD,
	var_0_7.NAME_FIELD,
	var_0_7.AVATAR_FIELD,
	var_0_7.TYPE_FIELD,
	var_0_7.TAG_FIELD,
	var_0_7.LEVEL_FIELD,
	var_0_7.MEMBER_FIELD,
	var_0_7.ANNOUNCEMENT_FIELD,
	var_0_7.REQUIRED_LEVEL_FIELD
}
UNIONINFO.is_extendable = false
UNIONINFO.extensions = {}
var_0_8.ID_FIELD.name = "id"
var_0_8.ID_FIELD.full_name = ".sgland.Visit.id"
var_0_8.ID_FIELD.number = 1
var_0_8.ID_FIELD.index = 0
var_0_8.ID_FIELD.label = 2
var_0_8.ID_FIELD.has_default_value = false
var_0_8.ID_FIELD.default_value = 0
var_0_8.ID_FIELD.type = 5
var_0_8.ID_FIELD.cpp_type = 1
var_0_8.INFO_ID_FIELD.name = "info_id"
var_0_8.INFO_ID_FIELD.full_name = ".sgland.Visit.info_id"
var_0_8.INFO_ID_FIELD.number = 2
var_0_8.INFO_ID_FIELD.index = 1
var_0_8.INFO_ID_FIELD.label = 2
var_0_8.INFO_ID_FIELD.has_default_value = false
var_0_8.INFO_ID_FIELD.default_value = 0
var_0_8.INFO_ID_FIELD.type = 5
var_0_8.INFO_ID_FIELD.cpp_type = 1
var_0_8.COUNT_FIELD.name = "count"
var_0_8.COUNT_FIELD.full_name = ".sgland.Visit.count"
var_0_8.COUNT_FIELD.number = 3
var_0_8.COUNT_FIELD.index = 2
var_0_8.COUNT_FIELD.label = 2
var_0_8.COUNT_FIELD.has_default_value = false
var_0_8.COUNT_FIELD.default_value = 0
var_0_8.COUNT_FIELD.type = 5
var_0_8.COUNT_FIELD.cpp_type = 1
var_0_8.TIMESTAMP_FIELD.name = "timestamp"
var_0_8.TIMESTAMP_FIELD.full_name = ".sgland.Visit.timestamp"
var_0_8.TIMESTAMP_FIELD.number = 4
var_0_8.TIMESTAMP_FIELD.index = 3
var_0_8.TIMESTAMP_FIELD.label = 2
var_0_8.TIMESTAMP_FIELD.has_default_value = false
var_0_8.TIMESTAMP_FIELD.default_value = 0
var_0_8.TIMESTAMP_FIELD.type = 3
var_0_8.TIMESTAMP_FIELD.cpp_type = 2
VISIT.name = "Visit"
VISIT.full_name = ".sgland.Visit"
VISIT.nested_types = {}
VISIT.enum_types = {}
VISIT.fields = {
	var_0_8.ID_FIELD,
	var_0_8.INFO_ID_FIELD,
	var_0_8.COUNT_FIELD,
	var_0_8.TIMESTAMP_FIELD
}
VISIT.is_extendable = false
VISIT.extensions = {}
var_0_9.ID_FIELD.name = "id"
var_0_9.ID_FIELD.full_name = ".sgland.Procedure.id"
var_0_9.ID_FIELD.number = 1
var_0_9.ID_FIELD.index = 0
var_0_9.ID_FIELD.label = 2
var_0_9.ID_FIELD.has_default_value = false
var_0_9.ID_FIELD.default_value = 0
var_0_9.ID_FIELD.type = 5
var_0_9.ID_FIELD.cpp_type = 1
var_0_9.INFO_ID_FIELD.name = "info_id"
var_0_9.INFO_ID_FIELD.full_name = ".sgland.Procedure.info_id"
var_0_9.INFO_ID_FIELD.number = 2
var_0_9.INFO_ID_FIELD.index = 1
var_0_9.INFO_ID_FIELD.label = 2
var_0_9.INFO_ID_FIELD.has_default_value = false
var_0_9.INFO_ID_FIELD.default_value = 0
var_0_9.INFO_ID_FIELD.type = 5
var_0_9.INFO_ID_FIELD.cpp_type = 1
var_0_9.HEROS_FIELD.name = "heros"
var_0_9.HEROS_FIELD.full_name = ".sgland.Procedure.heros"
var_0_9.HEROS_FIELD.number = 3
var_0_9.HEROS_FIELD.index = 2
var_0_9.HEROS_FIELD.label = 3
var_0_9.HEROS_FIELD.has_default_value = false
var_0_9.HEROS_FIELD.default_value = {}
var_0_9.HEROS_FIELD.type = 5
var_0_9.HEROS_FIELD.cpp_type = 1
var_0_9.TIMESTAMP_FIELD.name = "timestamp"
var_0_9.TIMESTAMP_FIELD.full_name = ".sgland.Procedure.timestamp"
var_0_9.TIMESTAMP_FIELD.number = 4
var_0_9.TIMESTAMP_FIELD.index = 3
var_0_9.TIMESTAMP_FIELD.label = 1
var_0_9.TIMESTAMP_FIELD.has_default_value = false
var_0_9.TIMESTAMP_FIELD.default_value = 0
var_0_9.TIMESTAMP_FIELD.type = 3
var_0_9.TIMESTAMP_FIELD.cpp_type = 2
PROCEDURE.name = "Procedure"
PROCEDURE.full_name = ".sgland.Procedure"
PROCEDURE.nested_types = {}
PROCEDURE.enum_types = {}
PROCEDURE.fields = {
	var_0_9.ID_FIELD,
	var_0_9.INFO_ID_FIELD,
	var_0_9.HEROS_FIELD,
	var_0_9.TIMESTAMP_FIELD
}
PROCEDURE.is_extendable = false
PROCEDURE.extensions = {}
var_0_10.INFO_ID_FIELD.name = "info_id"
var_0_10.INFO_ID_FIELD.full_name = ".sgland.Resource.info_id"
var_0_10.INFO_ID_FIELD.number = 1
var_0_10.INFO_ID_FIELD.index = 0
var_0_10.INFO_ID_FIELD.label = 2
var_0_10.INFO_ID_FIELD.has_default_value = false
var_0_10.INFO_ID_FIELD.default_value = 0
var_0_10.INFO_ID_FIELD.type = 5
var_0_10.INFO_ID_FIELD.cpp_type = 1
var_0_10.NUM_FIELD.name = "num"
var_0_10.NUM_FIELD.full_name = ".sgland.Resource.num"
var_0_10.NUM_FIELD.number = 2
var_0_10.NUM_FIELD.index = 1
var_0_10.NUM_FIELD.label = 2
var_0_10.NUM_FIELD.has_default_value = false
var_0_10.NUM_FIELD.default_value = 0
var_0_10.NUM_FIELD.type = 5
var_0_10.NUM_FIELD.cpp_type = 1
RESOURCE.name = "Resource"
RESOURCE.full_name = ".sgland.Resource"
RESOURCE.nested_types = {}
RESOURCE.enum_types = {}
RESOURCE.fields = {
	var_0_10.INFO_ID_FIELD,
	var_0_10.NUM_FIELD
}
RESOURCE.is_extendable = false
RESOURCE.extensions = {}
var_0_11.INFO_ID_FIELD.name = "info_id"
var_0_11.INFO_ID_FIELD.full_name = ".sgland.CardBoxCardInfo.info_id"
var_0_11.INFO_ID_FIELD.number = 1
var_0_11.INFO_ID_FIELD.index = 0
var_0_11.INFO_ID_FIELD.label = 2
var_0_11.INFO_ID_FIELD.has_default_value = false
var_0_11.INFO_ID_FIELD.default_value = 0
var_0_11.INFO_ID_FIELD.type = 5
var_0_11.INFO_ID_FIELD.cpp_type = 1
var_0_11.GET_NUM_FIELD.name = "get_num"
var_0_11.GET_NUM_FIELD.full_name = ".sgland.CardBoxCardInfo.get_num"
var_0_11.GET_NUM_FIELD.number = 2
var_0_11.GET_NUM_FIELD.index = 1
var_0_11.GET_NUM_FIELD.label = 2
var_0_11.GET_NUM_FIELD.has_default_value = false
var_0_11.GET_NUM_FIELD.default_value = 0
var_0_11.GET_NUM_FIELD.type = 5
var_0_11.GET_NUM_FIELD.cpp_type = 1
var_0_11.REMAIN_NUM_FIELD.name = "remain_num"
var_0_11.REMAIN_NUM_FIELD.full_name = ".sgland.CardBoxCardInfo.remain_num"
var_0_11.REMAIN_NUM_FIELD.number = 3
var_0_11.REMAIN_NUM_FIELD.index = 2
var_0_11.REMAIN_NUM_FIELD.label = 2
var_0_11.REMAIN_NUM_FIELD.has_default_value = false
var_0_11.REMAIN_NUM_FIELD.default_value = 0
var_0_11.REMAIN_NUM_FIELD.type = 5
var_0_11.REMAIN_NUM_FIELD.cpp_type = 1
CARDBOXCARDINFO.name = "CardBoxCardInfo"
CARDBOXCARDINFO.full_name = ".sgland.CardBoxCardInfo"
CARDBOXCARDINFO.nested_types = {}
CARDBOXCARDINFO.enum_types = {}
CARDBOXCARDINFO.fields = {
	var_0_11.INFO_ID_FIELD,
	var_0_11.GET_NUM_FIELD,
	var_0_11.REMAIN_NUM_FIELD
}
CARDBOXCARDINFO.is_extendable = false
CARDBOXCARDINFO.extensions = {}
var_0_12.BOX_ID_FIELD.name = "box_id"
var_0_12.BOX_ID_FIELD.full_name = ".sgland.CardBox.box_id"
var_0_12.BOX_ID_FIELD.number = 1
var_0_12.BOX_ID_FIELD.index = 0
var_0_12.BOX_ID_FIELD.label = 2
var_0_12.BOX_ID_FIELD.has_default_value = false
var_0_12.BOX_ID_FIELD.default_value = 0
var_0_12.BOX_ID_FIELD.type = 5
var_0_12.BOX_ID_FIELD.cpp_type = 1
var_0_12.INFO_ID_FIELD.name = "info_id"
var_0_12.INFO_ID_FIELD.full_name = ".sgland.CardBox.info_id"
var_0_12.INFO_ID_FIELD.number = 2
var_0_12.INFO_ID_FIELD.index = 1
var_0_12.INFO_ID_FIELD.label = 3
var_0_12.INFO_ID_FIELD.has_default_value = false
var_0_12.INFO_ID_FIELD.default_value = {}
var_0_12.INFO_ID_FIELD.type = 5
var_0_12.INFO_ID_FIELD.cpp_type = 1
CARDBOX.name = "CardBox"
CARDBOX.full_name = ".sgland.CardBox"
CARDBOX.nested_types = {}
CARDBOX.enum_types = {}
CARDBOX.fields = {
	var_0_12.BOX_ID_FIELD,
	var_0_12.INFO_ID_FIELD
}
CARDBOX.is_extendable = false
CARDBOX.extensions = {}
var_0_13.ID_FIELD.name = "id"
var_0_13.ID_FIELD.full_name = ".sgland.FestivalDrop.id"
var_0_13.ID_FIELD.number = 1
var_0_13.ID_FIELD.index = 0
var_0_13.ID_FIELD.label = 2
var_0_13.ID_FIELD.has_default_value = false
var_0_13.ID_FIELD.default_value = 0
var_0_13.ID_FIELD.type = 5
var_0_13.ID_FIELD.cpp_type = 1
var_0_13.RESOURCE_FIELD.name = "resource"
var_0_13.RESOURCE_FIELD.full_name = ".sgland.FestivalDrop.resource"
var_0_13.RESOURCE_FIELD.number = 2
var_0_13.RESOURCE_FIELD.index = 1
var_0_13.RESOURCE_FIELD.label = 2
var_0_13.RESOURCE_FIELD.has_default_value = false
var_0_13.RESOURCE_FIELD.default_value = nil
var_0_13.RESOURCE_FIELD.message_type = RESOURCE
var_0_13.RESOURCE_FIELD.type = 11
var_0_13.RESOURCE_FIELD.cpp_type = 10
var_0_13.WEIGHT_FIELD.name = "weight"
var_0_13.WEIGHT_FIELD.full_name = ".sgland.FestivalDrop.weight"
var_0_13.WEIGHT_FIELD.number = 3
var_0_13.WEIGHT_FIELD.index = 2
var_0_13.WEIGHT_FIELD.label = 2
var_0_13.WEIGHT_FIELD.has_default_value = false
var_0_13.WEIGHT_FIELD.default_value = 0
var_0_13.WEIGHT_FIELD.type = 5
var_0_13.WEIGHT_FIELD.cpp_type = 1
FESTIVALDROP.name = "FestivalDrop"
FESTIVALDROP.full_name = ".sgland.FestivalDrop"
FESTIVALDROP.nested_types = {}
FESTIVALDROP.enum_types = {}
FESTIVALDROP.fields = {
	var_0_13.ID_FIELD,
	var_0_13.RESOURCE_FIELD,
	var_0_13.WEIGHT_FIELD
}
FESTIVALDROP.is_extendable = false
FESTIVALDROP.extensions = {}
var_0_14.BOX_ID_FIELD.name = "box_id"
var_0_14.BOX_ID_FIELD.full_name = ".sgland.FestivalBox.box_id"
var_0_14.BOX_ID_FIELD.number = 1
var_0_14.BOX_ID_FIELD.index = 0
var_0_14.BOX_ID_FIELD.label = 2
var_0_14.BOX_ID_FIELD.has_default_value = false
var_0_14.BOX_ID_FIELD.default_value = 0
var_0_14.BOX_ID_FIELD.type = 5
var_0_14.BOX_ID_FIELD.cpp_type = 1
var_0_14.LOTTERY_COUNT_FIELD.name = "lottery_count"
var_0_14.LOTTERY_COUNT_FIELD.full_name = ".sgland.FestivalBox.lottery_count"
var_0_14.LOTTERY_COUNT_FIELD.number = 2
var_0_14.LOTTERY_COUNT_FIELD.index = 1
var_0_14.LOTTERY_COUNT_FIELD.label = 2
var_0_14.LOTTERY_COUNT_FIELD.has_default_value = false
var_0_14.LOTTERY_COUNT_FIELD.default_value = 0
var_0_14.LOTTERY_COUNT_FIELD.type = 5
var_0_14.LOTTERY_COUNT_FIELD.cpp_type = 1
var_0_14.DROPS_FIELD.name = "drops"
var_0_14.DROPS_FIELD.full_name = ".sgland.FestivalBox.drops"
var_0_14.DROPS_FIELD.number = 3
var_0_14.DROPS_FIELD.index = 2
var_0_14.DROPS_FIELD.label = 3
var_0_14.DROPS_FIELD.has_default_value = false
var_0_14.DROPS_FIELD.default_value = {}
var_0_14.DROPS_FIELD.message_type = FESTIVALDROP
var_0_14.DROPS_FIELD.type = 11
var_0_14.DROPS_FIELD.cpp_type = 10
FESTIVALBOX.name = "FestivalBox"
FESTIVALBOX.full_name = ".sgland.FestivalBox"
FESTIVALBOX.nested_types = {}
FESTIVALBOX.enum_types = {}
FESTIVALBOX.fields = {
	var_0_14.BOX_ID_FIELD,
	var_0_14.LOTTERY_COUNT_FIELD,
	var_0_14.DROPS_FIELD
}
FESTIVALBOX.is_extendable = false
FESTIVALBOX.extensions = {}
var_0_15.BOX_ID_FIELD.name = "box_id"
var_0_15.BOX_ID_FIELD.full_name = ".sgland.LadderBox.box_id"
var_0_15.BOX_ID_FIELD.number = 1
var_0_15.BOX_ID_FIELD.index = 0
var_0_15.BOX_ID_FIELD.label = 2
var_0_15.BOX_ID_FIELD.has_default_value = false
var_0_15.BOX_ID_FIELD.default_value = 0
var_0_15.BOX_ID_FIELD.type = 5
var_0_15.BOX_ID_FIELD.cpp_type = 1
var_0_15.RESOURCE_FIELD.name = "resource"
var_0_15.RESOURCE_FIELD.full_name = ".sgland.LadderBox.resource"
var_0_15.RESOURCE_FIELD.number = 2
var_0_15.RESOURCE_FIELD.index = 1
var_0_15.RESOURCE_FIELD.label = 3
var_0_15.RESOURCE_FIELD.has_default_value = false
var_0_15.RESOURCE_FIELD.default_value = {}
var_0_15.RESOURCE_FIELD.message_type = RESOURCE
var_0_15.RESOURCE_FIELD.type = 11
var_0_15.RESOURCE_FIELD.cpp_type = 10
LADDERBOX.name = "LadderBox"
LADDERBOX.full_name = ".sgland.LadderBox"
LADDERBOX.nested_types = {}
LADDERBOX.enum_types = {}
LADDERBOX.fields = {
	var_0_15.BOX_ID_FIELD,
	var_0_15.RESOURCE_FIELD
}
LADDERBOX.is_extendable = false
LADDERBOX.extensions = {}
var_0_16.CARD_BOX_FIELD.name = "card_box"
var_0_16.CARD_BOX_FIELD.full_name = ".sgland.ParyerLotteryDL.card_box"
var_0_16.CARD_BOX_FIELD.number = 1
var_0_16.CARD_BOX_FIELD.index = 0
var_0_16.CARD_BOX_FIELD.label = 3
var_0_16.CARD_BOX_FIELD.has_default_value = false
var_0_16.CARD_BOX_FIELD.default_value = {}
var_0_16.CARD_BOX_FIELD.message_type = CARDBOX
var_0_16.CARD_BOX_FIELD.type = 11
var_0_16.CARD_BOX_FIELD.cpp_type = 10
var_0_16.FESTIVAL_BOX_FIELD.name = "festival_box"
var_0_16.FESTIVAL_BOX_FIELD.full_name = ".sgland.ParyerLotteryDL.festival_box"
var_0_16.FESTIVAL_BOX_FIELD.number = 2
var_0_16.FESTIVAL_BOX_FIELD.index = 1
var_0_16.FESTIVAL_BOX_FIELD.label = 3
var_0_16.FESTIVAL_BOX_FIELD.has_default_value = false
var_0_16.FESTIVAL_BOX_FIELD.default_value = {}
var_0_16.FESTIVAL_BOX_FIELD.message_type = FESTIVALBOX
var_0_16.FESTIVAL_BOX_FIELD.type = 11
var_0_16.FESTIVAL_BOX_FIELD.cpp_type = 10
var_0_16.LADDER_BOX_FIELD.name = "ladder_box"
var_0_16.LADDER_BOX_FIELD.full_name = ".sgland.ParyerLotteryDL.ladder_box"
var_0_16.LADDER_BOX_FIELD.number = 3
var_0_16.LADDER_BOX_FIELD.index = 2
var_0_16.LADDER_BOX_FIELD.label = 3
var_0_16.LADDER_BOX_FIELD.has_default_value = false
var_0_16.LADDER_BOX_FIELD.default_value = {}
var_0_16.LADDER_BOX_FIELD.message_type = LADDERBOX
var_0_16.LADDER_BOX_FIELD.type = 11
var_0_16.LADDER_BOX_FIELD.cpp_type = 10
PARYERLOTTERYDL.name = "ParyerLotteryDL"
PARYERLOTTERYDL.full_name = ".sgland.ParyerLotteryDL"
PARYERLOTTERYDL.nested_types = {}
PARYERLOTTERYDL.enum_types = {}
PARYERLOTTERYDL.fields = {
	var_0_16.CARD_BOX_FIELD,
	var_0_16.FESTIVAL_BOX_FIELD,
	var_0_16.LADDER_BOX_FIELD
}
PARYERLOTTERYDL.is_extendable = false
PARYERLOTTERYDL.extensions = {}
var_0_17.KEY_FIELD.name = "key"
var_0_17.KEY_FIELD.full_name = ".sgland.Pair.key"
var_0_17.KEY_FIELD.number = 1
var_0_17.KEY_FIELD.index = 0
var_0_17.KEY_FIELD.label = 2
var_0_17.KEY_FIELD.has_default_value = false
var_0_17.KEY_FIELD.default_value = 0
var_0_17.KEY_FIELD.type = 5
var_0_17.KEY_FIELD.cpp_type = 1
var_0_17.VALUE_FIELD.name = "value"
var_0_17.VALUE_FIELD.full_name = ".sgland.Pair.value"
var_0_17.VALUE_FIELD.number = 2
var_0_17.VALUE_FIELD.index = 1
var_0_17.VALUE_FIELD.label = 2
var_0_17.VALUE_FIELD.has_default_value = false
var_0_17.VALUE_FIELD.default_value = 0
var_0_17.VALUE_FIELD.type = 5
var_0_17.VALUE_FIELD.cpp_type = 1
var_0_17.TIMESTAMP_FIELD.name = "timestamp"
var_0_17.TIMESTAMP_FIELD.full_name = ".sgland.Pair.timestamp"
var_0_17.TIMESTAMP_FIELD.number = 3
var_0_17.TIMESTAMP_FIELD.index = 2
var_0_17.TIMESTAMP_FIELD.label = 1
var_0_17.TIMESTAMP_FIELD.has_default_value = false
var_0_17.TIMESTAMP_FIELD.default_value = 0
var_0_17.TIMESTAMP_FIELD.type = 3
var_0_17.TIMESTAMP_FIELD.cpp_type = 2
PAIR.name = "Pair"
PAIR.full_name = ".sgland.Pair"
PAIR.nested_types = {}
PAIR.enum_types = {}
PAIR.fields = {
	var_0_17.KEY_FIELD,
	var_0_17.VALUE_FIELD,
	var_0_17.TIMESTAMP_FIELD
}
PAIR.is_extendable = false
PAIR.extensions = {}
var_0_18.PKG_ID_FIELD.name = "pkg_id"
var_0_18.PKG_ID_FIELD.full_name = ".sgland.FestivalExtraLotteryData.pkg_id"
var_0_18.PKG_ID_FIELD.number = 1
var_0_18.PKG_ID_FIELD.index = 0
var_0_18.PKG_ID_FIELD.label = 2
var_0_18.PKG_ID_FIELD.has_default_value = false
var_0_18.PKG_ID_FIELD.default_value = 0
var_0_18.PKG_ID_FIELD.type = 5
var_0_18.PKG_ID_FIELD.cpp_type = 1
var_0_18.EXTRA_CARDS_FIELD.name = "extra_cards"
var_0_18.EXTRA_CARDS_FIELD.full_name = ".sgland.FestivalExtraLotteryData.extra_cards"
var_0_18.EXTRA_CARDS_FIELD.number = 2
var_0_18.EXTRA_CARDS_FIELD.index = 1
var_0_18.EXTRA_CARDS_FIELD.label = 3
var_0_18.EXTRA_CARDS_FIELD.has_default_value = false
var_0_18.EXTRA_CARDS_FIELD.default_value = {}
var_0_18.EXTRA_CARDS_FIELD.type = 5
var_0_18.EXTRA_CARDS_FIELD.cpp_type = 1
var_0_18.COUNT_FIELD.name = "count"
var_0_18.COUNT_FIELD.full_name = ".sgland.FestivalExtraLotteryData.count"
var_0_18.COUNT_FIELD.number = 3
var_0_18.COUNT_FIELD.index = 2
var_0_18.COUNT_FIELD.label = 2
var_0_18.COUNT_FIELD.has_default_value = false
var_0_18.COUNT_FIELD.default_value = 0
var_0_18.COUNT_FIELD.type = 5
var_0_18.COUNT_FIELD.cpp_type = 1
FESTIVALEXTRALOTTERYDATA.name = "FestivalExtraLotteryData"
FESTIVALEXTRALOTTERYDATA.full_name = ".sgland.FestivalExtraLotteryData"
FESTIVALEXTRALOTTERYDATA.nested_types = {}
FESTIVALEXTRALOTTERYDATA.enum_types = {}
FESTIVALEXTRALOTTERYDATA.fields = {
	var_0_18.PKG_ID_FIELD,
	var_0_18.EXTRA_CARDS_FIELD,
	var_0_18.COUNT_FIELD
}
FESTIVALEXTRALOTTERYDATA.is_extendable = false
FESTIVALEXTRALOTTERYDATA.extensions = {}
var_0_19.PKG_ID_FIELD.name = "pkg_id"
var_0_19.PKG_ID_FIELD.full_name = ".sgland.PlayerLotteryCount.pkg_id"
var_0_19.PKG_ID_FIELD.number = 1
var_0_19.PKG_ID_FIELD.index = 0
var_0_19.PKG_ID_FIELD.label = 3
var_0_19.PKG_ID_FIELD.has_default_value = false
var_0_19.PKG_ID_FIELD.default_value = {}
var_0_19.PKG_ID_FIELD.type = 5
var_0_19.PKG_ID_FIELD.cpp_type = 1
var_0_19.COUNT_FIELD.name = "count"
var_0_19.COUNT_FIELD.full_name = ".sgland.PlayerLotteryCount.count"
var_0_19.COUNT_FIELD.number = 2
var_0_19.COUNT_FIELD.index = 1
var_0_19.COUNT_FIELD.label = 3
var_0_19.COUNT_FIELD.has_default_value = false
var_0_19.COUNT_FIELD.default_value = {}
var_0_19.COUNT_FIELD.type = 5
var_0_19.COUNT_FIELD.cpp_type = 1
var_0_19.SR_COUNT_FIELD.name = "sr_count"
var_0_19.SR_COUNT_FIELD.full_name = ".sgland.PlayerLotteryCount.sr_count"
var_0_19.SR_COUNT_FIELD.number = 3
var_0_19.SR_COUNT_FIELD.index = 2
var_0_19.SR_COUNT_FIELD.label = 3
var_0_19.SR_COUNT_FIELD.has_default_value = false
var_0_19.SR_COUNT_FIELD.default_value = {}
var_0_19.SR_COUNT_FIELD.type = 5
var_0_19.SR_COUNT_FIELD.cpp_type = 1
var_0_19.FREE_LOTTERY_COUNT_FIELD.name = "free_lottery_count"
var_0_19.FREE_LOTTERY_COUNT_FIELD.full_name = ".sgland.PlayerLotteryCount.free_lottery_count"
var_0_19.FREE_LOTTERY_COUNT_FIELD.number = 4
var_0_19.FREE_LOTTERY_COUNT_FIELD.index = 3
var_0_19.FREE_LOTTERY_COUNT_FIELD.label = 1
var_0_19.FREE_LOTTERY_COUNT_FIELD.has_default_value = false
var_0_19.FREE_LOTTERY_COUNT_FIELD.default_value = 0
var_0_19.FREE_LOTTERY_COUNT_FIELD.type = 5
var_0_19.FREE_LOTTERY_COUNT_FIELD.cpp_type = 1
var_0_19.LEGEND_PKG_ID_FIELD.name = "legend_pkg_id"
var_0_19.LEGEND_PKG_ID_FIELD.full_name = ".sgland.PlayerLotteryCount.legend_pkg_id"
var_0_19.LEGEND_PKG_ID_FIELD.number = 5
var_0_19.LEGEND_PKG_ID_FIELD.index = 4
var_0_19.LEGEND_PKG_ID_FIELD.label = 3
var_0_19.LEGEND_PKG_ID_FIELD.has_default_value = false
var_0_19.LEGEND_PKG_ID_FIELD.default_value = {}
var_0_19.LEGEND_PKG_ID_FIELD.type = 5
var_0_19.LEGEND_PKG_ID_FIELD.cpp_type = 1
var_0_19.LEGEND_LOTTERY_COUNT_FIELD.name = "legend_lottery_count"
var_0_19.LEGEND_LOTTERY_COUNT_FIELD.full_name = ".sgland.PlayerLotteryCount.legend_lottery_count"
var_0_19.LEGEND_LOTTERY_COUNT_FIELD.number = 6
var_0_19.LEGEND_LOTTERY_COUNT_FIELD.index = 5
var_0_19.LEGEND_LOTTERY_COUNT_FIELD.label = 3
var_0_19.LEGEND_LOTTERY_COUNT_FIELD.has_default_value = false
var_0_19.LEGEND_LOTTERY_COUNT_FIELD.default_value = {}
var_0_19.LEGEND_LOTTERY_COUNT_FIELD.type = 5
var_0_19.LEGEND_LOTTERY_COUNT_FIELD.cpp_type = 1
var_0_19.LOTTERY_UP_PAIRS_FIELD.name = "lottery_up_pairs"
var_0_19.LOTTERY_UP_PAIRS_FIELD.full_name = ".sgland.PlayerLotteryCount.lottery_up_pairs"
var_0_19.LOTTERY_UP_PAIRS_FIELD.number = 7
var_0_19.LOTTERY_UP_PAIRS_FIELD.index = 6
var_0_19.LOTTERY_UP_PAIRS_FIELD.label = 3
var_0_19.LOTTERY_UP_PAIRS_FIELD.has_default_value = false
var_0_19.LOTTERY_UP_PAIRS_FIELD.default_value = {}
var_0_19.LOTTERY_UP_PAIRS_FIELD.message_type = PAIR
var_0_19.LOTTERY_UP_PAIRS_FIELD.type = 11
var_0_19.LOTTERY_UP_PAIRS_FIELD.cpp_type = 10
var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD.name = "lottery_up_count_pairs"
var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD.full_name = ".sgland.PlayerLotteryCount.lottery_up_count_pairs"
var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD.number = 8
var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD.index = 7
var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD.label = 3
var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD.has_default_value = false
var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD.default_value = {}
var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD.message_type = PAIR
var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD.type = 11
var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD.cpp_type = 10
var_0_19.FESTIVAL_EXTRAS_FIELD.name = "festival_extras"
var_0_19.FESTIVAL_EXTRAS_FIELD.full_name = ".sgland.PlayerLotteryCount.festival_extras"
var_0_19.FESTIVAL_EXTRAS_FIELD.number = 9
var_0_19.FESTIVAL_EXTRAS_FIELD.index = 8
var_0_19.FESTIVAL_EXTRAS_FIELD.label = 3
var_0_19.FESTIVAL_EXTRAS_FIELD.has_default_value = false
var_0_19.FESTIVAL_EXTRAS_FIELD.default_value = {}
var_0_19.FESTIVAL_EXTRAS_FIELD.message_type = FESTIVALEXTRALOTTERYDATA
var_0_19.FESTIVAL_EXTRAS_FIELD.type = 11
var_0_19.FESTIVAL_EXTRAS_FIELD.cpp_type = 10
PLAYERLOTTERYCOUNT.name = "PlayerLotteryCount"
PLAYERLOTTERYCOUNT.full_name = ".sgland.PlayerLotteryCount"
PLAYERLOTTERYCOUNT.nested_types = {}
PLAYERLOTTERYCOUNT.enum_types = {}
PLAYERLOTTERYCOUNT.fields = {
	var_0_19.PKG_ID_FIELD,
	var_0_19.COUNT_FIELD,
	var_0_19.SR_COUNT_FIELD,
	var_0_19.FREE_LOTTERY_COUNT_FIELD,
	var_0_19.LEGEND_PKG_ID_FIELD,
	var_0_19.LEGEND_LOTTERY_COUNT_FIELD,
	var_0_19.LOTTERY_UP_PAIRS_FIELD,
	var_0_19.LOTTERY_UP_COUNT_PAIRS_FIELD,
	var_0_19.FESTIVAL_EXTRAS_FIELD
}
PLAYERLOTTERYCOUNT.is_extendable = false
PLAYERLOTTERYCOUNT.extensions = {}
var_0_20.ID_FIELD.name = "id"
var_0_20.ID_FIELD.full_name = ".sgland.Character.id"
var_0_20.ID_FIELD.number = 1
var_0_20.ID_FIELD.index = 0
var_0_20.ID_FIELD.label = 2
var_0_20.ID_FIELD.has_default_value = false
var_0_20.ID_FIELD.default_value = 0
var_0_20.ID_FIELD.type = 5
var_0_20.ID_FIELD.cpp_type = 1
var_0_20.EXP_FIELD.name = "exp"
var_0_20.EXP_FIELD.full_name = ".sgland.Character.exp"
var_0_20.EXP_FIELD.number = 2
var_0_20.EXP_FIELD.index = 1
var_0_20.EXP_FIELD.label = 2
var_0_20.EXP_FIELD.has_default_value = false
var_0_20.EXP_FIELD.default_value = 0
var_0_20.EXP_FIELD.type = 5
var_0_20.EXP_FIELD.cpp_type = 1
var_0_20.LEVEL_FIELD.name = "level"
var_0_20.LEVEL_FIELD.full_name = ".sgland.Character.level"
var_0_20.LEVEL_FIELD.number = 3
var_0_20.LEVEL_FIELD.index = 2
var_0_20.LEVEL_FIELD.label = 2
var_0_20.LEVEL_FIELD.has_default_value = false
var_0_20.LEVEL_FIELD.default_value = 0
var_0_20.LEVEL_FIELD.type = 5
var_0_20.LEVEL_FIELD.cpp_type = 1
var_0_20.AVATAR_FIELD.name = "avatar"
var_0_20.AVATAR_FIELD.full_name = ".sgland.Character.avatar"
var_0_20.AVATAR_FIELD.number = 4
var_0_20.AVATAR_FIELD.index = 3
var_0_20.AVATAR_FIELD.label = 2
var_0_20.AVATAR_FIELD.has_default_value = false
var_0_20.AVATAR_FIELD.default_value = 0
var_0_20.AVATAR_FIELD.type = 5
var_0_20.AVATAR_FIELD.cpp_type = 1
var_0_20.SKIN_FIELD.name = "skin"
var_0_20.SKIN_FIELD.full_name = ".sgland.Character.skin"
var_0_20.SKIN_FIELD.number = 5
var_0_20.SKIN_FIELD.index = 4
var_0_20.SKIN_FIELD.label = 1
var_0_20.SKIN_FIELD.has_default_value = false
var_0_20.SKIN_FIELD.default_value = 0
var_0_20.SKIN_FIELD.type = 5
var_0_20.SKIN_FIELD.cpp_type = 1
var_0_20.BREAK_OUT_FIELD.name = "break_out"
var_0_20.BREAK_OUT_FIELD.full_name = ".sgland.Character.break_out"
var_0_20.BREAK_OUT_FIELD.number = 6
var_0_20.BREAK_OUT_FIELD.index = 5
var_0_20.BREAK_OUT_FIELD.label = 1
var_0_20.BREAK_OUT_FIELD.has_default_value = false
var_0_20.BREAK_OUT_FIELD.default_value = false
var_0_20.BREAK_OUT_FIELD.type = 8
var_0_20.BREAK_OUT_FIELD.cpp_type = 7
CHARACTER.name = "Character"
CHARACTER.full_name = ".sgland.Character"
CHARACTER.nested_types = {}
CHARACTER.enum_types = {}
CHARACTER.fields = {
	var_0_20.ID_FIELD,
	var_0_20.EXP_FIELD,
	var_0_20.LEVEL_FIELD,
	var_0_20.AVATAR_FIELD,
	var_0_20.SKIN_FIELD,
	var_0_20.BREAK_OUT_FIELD
}
CHARACTER.is_extendable = false
CHARACTER.extensions = {}
var_0_21.CHARACTER_FIELD.name = "character"
var_0_21.CHARACTER_FIELD.full_name = ".sgland.Characters.character"
var_0_21.CHARACTER_FIELD.number = 1
var_0_21.CHARACTER_FIELD.index = 0
var_0_21.CHARACTER_FIELD.label = 3
var_0_21.CHARACTER_FIELD.has_default_value = false
var_0_21.CHARACTER_FIELD.default_value = {}
var_0_21.CHARACTER_FIELD.message_type = CHARACTER
var_0_21.CHARACTER_FIELD.type = 11
var_0_21.CHARACTER_FIELD.cpp_type = 10
CHARACTERS.name = "Characters"
CHARACTERS.full_name = ".sgland.Characters"
CHARACTERS.nested_types = {}
CHARACTERS.enum_types = {}
CHARACTERS.fields = {
	var_0_21.CHARACTER_FIELD
}
CHARACTERS.is_extendable = false
CHARACTERS.extensions = {}
var_0_22.CHAR_ID_FIELD.name = "char_id"
var_0_22.CHAR_ID_FIELD.full_name = ".sgland.PlayerCharacter.char_id"
var_0_22.CHAR_ID_FIELD.number = 1
var_0_22.CHAR_ID_FIELD.index = 0
var_0_22.CHAR_ID_FIELD.label = 1
var_0_22.CHAR_ID_FIELD.has_default_value = false
var_0_22.CHAR_ID_FIELD.default_value = 0
var_0_22.CHAR_ID_FIELD.type = 5
var_0_22.CHAR_ID_FIELD.cpp_type = 1
var_0_22.CHARS_FIELD.name = "chars"
var_0_22.CHARS_FIELD.full_name = ".sgland.PlayerCharacter.chars"
var_0_22.CHARS_FIELD.number = 2
var_0_22.CHARS_FIELD.index = 1
var_0_22.CHARS_FIELD.label = 3
var_0_22.CHARS_FIELD.has_default_value = false
var_0_22.CHARS_FIELD.default_value = {}
var_0_22.CHARS_FIELD.message_type = CHARACTER
var_0_22.CHARS_FIELD.type = 11
var_0_22.CHARS_FIELD.cpp_type = 10
var_0_22.LADDER_EVENT_TROPHY_FIELD.name = "ladder_event_trophy"
var_0_22.LADDER_EVENT_TROPHY_FIELD.full_name = ".sgland.PlayerCharacter.ladder_event_trophy"
var_0_22.LADDER_EVENT_TROPHY_FIELD.number = 3
var_0_22.LADDER_EVENT_TROPHY_FIELD.index = 2
var_0_22.LADDER_EVENT_TROPHY_FIELD.label = 1
var_0_22.LADDER_EVENT_TROPHY_FIELD.has_default_value = false
var_0_22.LADDER_EVENT_TROPHY_FIELD.default_value = 0
var_0_22.LADDER_EVENT_TROPHY_FIELD.type = 5
var_0_22.LADDER_EVENT_TROPHY_FIELD.cpp_type = 1
var_0_22.IS_DYNAMIC_TIMEOUT_FIELD.name = "is_dynamic_timeout"
var_0_22.IS_DYNAMIC_TIMEOUT_FIELD.full_name = ".sgland.PlayerCharacter.is_dynamic_timeout"
var_0_22.IS_DYNAMIC_TIMEOUT_FIELD.number = 4
var_0_22.IS_DYNAMIC_TIMEOUT_FIELD.index = 3
var_0_22.IS_DYNAMIC_TIMEOUT_FIELD.label = 1
var_0_22.IS_DYNAMIC_TIMEOUT_FIELD.has_default_value = false
var_0_22.IS_DYNAMIC_TIMEOUT_FIELD.default_value = false
var_0_22.IS_DYNAMIC_TIMEOUT_FIELD.type = 8
var_0_22.IS_DYNAMIC_TIMEOUT_FIELD.cpp_type = 7
PLAYERCHARACTER.name = "PlayerCharacter"
PLAYERCHARACTER.full_name = ".sgland.PlayerCharacter"
PLAYERCHARACTER.nested_types = {}
PLAYERCHARACTER.enum_types = {}
PLAYERCHARACTER.fields = {
	var_0_22.CHAR_ID_FIELD,
	var_0_22.CHARS_FIELD,
	var_0_22.LADDER_EVENT_TROPHY_FIELD,
	var_0_22.IS_DYNAMIC_TIMEOUT_FIELD
}
PLAYERCHARACTER.is_extendable = false
PLAYERCHARACTER.extensions = {}
var_0_23.INFO_ID_FIELD.name = "info_id"
var_0_23.INFO_ID_FIELD.full_name = ".sgland.CardLevel.info_id"
var_0_23.INFO_ID_FIELD.number = 1
var_0_23.INFO_ID_FIELD.index = 0
var_0_23.INFO_ID_FIELD.label = 2
var_0_23.INFO_ID_FIELD.has_default_value = false
var_0_23.INFO_ID_FIELD.default_value = 0
var_0_23.INFO_ID_FIELD.type = 5
var_0_23.INFO_ID_FIELD.cpp_type = 1
var_0_23.LEVEL_FIELD.name = "level"
var_0_23.LEVEL_FIELD.full_name = ".sgland.CardLevel.level"
var_0_23.LEVEL_FIELD.number = 2
var_0_23.LEVEL_FIELD.index = 1
var_0_23.LEVEL_FIELD.label = 2
var_0_23.LEVEL_FIELD.has_default_value = false
var_0_23.LEVEL_FIELD.default_value = 0
var_0_23.LEVEL_FIELD.type = 5
var_0_23.LEVEL_FIELD.cpp_type = 1
CARDLEVEL.name = "CardLevel"
CARDLEVEL.full_name = ".sgland.CardLevel"
CARDLEVEL.nested_types = {}
CARDLEVEL.enum_types = {}
CARDLEVEL.fields = {
	var_0_23.INFO_ID_FIELD,
	var_0_23.LEVEL_FIELD
}
CARDLEVEL.is_extendable = false
CARDLEVEL.extensions = {}
var_0_24.ID_FIELD.name = "id"
var_0_24.ID_FIELD.full_name = ".sgland.Bundle.id"
var_0_24.ID_FIELD.number = 1
var_0_24.ID_FIELD.index = 0
var_0_24.ID_FIELD.label = 2
var_0_24.ID_FIELD.has_default_value = false
var_0_24.ID_FIELD.default_value = 0
var_0_24.ID_FIELD.type = 5
var_0_24.ID_FIELD.cpp_type = 1
var_0_24.INFO_ID_FIELD.name = "info_id"
var_0_24.INFO_ID_FIELD.full_name = ".sgland.Bundle.info_id"
var_0_24.INFO_ID_FIELD.number = 2
var_0_24.INFO_ID_FIELD.index = 1
var_0_24.INFO_ID_FIELD.label = 2
var_0_24.INFO_ID_FIELD.has_default_value = false
var_0_24.INFO_ID_FIELD.default_value = 0
var_0_24.INFO_ID_FIELD.type = 5
var_0_24.INFO_ID_FIELD.cpp_type = 1
var_0_24.PRODUCT_FIELD.name = "product"
var_0_24.PRODUCT_FIELD.full_name = ".sgland.Bundle.product"
var_0_24.PRODUCT_FIELD.number = 3
var_0_24.PRODUCT_FIELD.index = 2
var_0_24.PRODUCT_FIELD.label = 2
var_0_24.PRODUCT_FIELD.has_default_value = false
var_0_24.PRODUCT_FIELD.default_value = nil
var_0_24.PRODUCT_FIELD.message_type = RESOURCE
var_0_24.PRODUCT_FIELD.type = 11
var_0_24.PRODUCT_FIELD.cpp_type = 10
var_0_24.IS_AVAILABLE_FIELD.name = "is_available"
var_0_24.IS_AVAILABLE_FIELD.full_name = ".sgland.Bundle.is_available"
var_0_24.IS_AVAILABLE_FIELD.number = 4
var_0_24.IS_AVAILABLE_FIELD.index = 3
var_0_24.IS_AVAILABLE_FIELD.label = 2
var_0_24.IS_AVAILABLE_FIELD.has_default_value = false
var_0_24.IS_AVAILABLE_FIELD.default_value = false
var_0_24.IS_AVAILABLE_FIELD.type = 8
var_0_24.IS_AVAILABLE_FIELD.cpp_type = 7
var_0_24.COUNT_FIELD.name = "count"
var_0_24.COUNT_FIELD.full_name = ".sgland.Bundle.count"
var_0_24.COUNT_FIELD.number = 5
var_0_24.COUNT_FIELD.index = 4
var_0_24.COUNT_FIELD.label = 1
var_0_24.COUNT_FIELD.has_default_value = false
var_0_24.COUNT_FIELD.default_value = 0
var_0_24.COUNT_FIELD.type = 5
var_0_24.COUNT_FIELD.cpp_type = 1
BUNDLE.name = "Bundle"
BUNDLE.full_name = ".sgland.Bundle"
BUNDLE.nested_types = {}
BUNDLE.enum_types = {}
BUNDLE.fields = {
	var_0_24.ID_FIELD,
	var_0_24.INFO_ID_FIELD,
	var_0_24.PRODUCT_FIELD,
	var_0_24.IS_AVAILABLE_FIELD,
	var_0_24.COUNT_FIELD
}
BUNDLE.is_extendable = false
BUNDLE.extensions = {}
var_0_25.ID_FIELD.name = "id"
var_0_25.ID_FIELD.full_name = ".sgland.BundleEx.id"
var_0_25.ID_FIELD.number = 1
var_0_25.ID_FIELD.index = 0
var_0_25.ID_FIELD.label = 2
var_0_25.ID_FIELD.has_default_value = false
var_0_25.ID_FIELD.default_value = 0
var_0_25.ID_FIELD.type = 5
var_0_25.ID_FIELD.cpp_type = 1
var_0_25.PRODUCT_FIELD.name = "product"
var_0_25.PRODUCT_FIELD.full_name = ".sgland.BundleEx.product"
var_0_25.PRODUCT_FIELD.number = 2
var_0_25.PRODUCT_FIELD.index = 1
var_0_25.PRODUCT_FIELD.label = 2
var_0_25.PRODUCT_FIELD.has_default_value = false
var_0_25.PRODUCT_FIELD.default_value = nil
var_0_25.PRODUCT_FIELD.message_type = RESOURCE
var_0_25.PRODUCT_FIELD.type = 11
var_0_25.PRODUCT_FIELD.cpp_type = 10
var_0_25.COST_FIELD.name = "cost"
var_0_25.COST_FIELD.full_name = ".sgland.BundleEx.cost"
var_0_25.COST_FIELD.number = 3
var_0_25.COST_FIELD.index = 2
var_0_25.COST_FIELD.label = 2
var_0_25.COST_FIELD.has_default_value = false
var_0_25.COST_FIELD.default_value = nil
var_0_25.COST_FIELD.message_type = RESOURCE
var_0_25.COST_FIELD.type = 11
var_0_25.COST_FIELD.cpp_type = 10
var_0_25.IS_AVAILABLE_FIELD.name = "is_available"
var_0_25.IS_AVAILABLE_FIELD.full_name = ".sgland.BundleEx.is_available"
var_0_25.IS_AVAILABLE_FIELD.number = 4
var_0_25.IS_AVAILABLE_FIELD.index = 3
var_0_25.IS_AVAILABLE_FIELD.label = 2
var_0_25.IS_AVAILABLE_FIELD.has_default_value = false
var_0_25.IS_AVAILABLE_FIELD.default_value = false
var_0_25.IS_AVAILABLE_FIELD.type = 8
var_0_25.IS_AVAILABLE_FIELD.cpp_type = 7
BUNDLEEX.name = "BundleEx"
BUNDLEEX.full_name = ".sgland.BundleEx"
BUNDLEEX.nested_types = {}
BUNDLEEX.enum_types = {}
BUNDLEEX.fields = {
	var_0_25.ID_FIELD,
	var_0_25.PRODUCT_FIELD,
	var_0_25.COST_FIELD,
	var_0_25.IS_AVAILABLE_FIELD
}
BUNDLEEX.is_extendable = false
BUNDLEEX.extensions = {}
var_0_26.INFO_ID_FIELD.name = "info_id"
var_0_26.INFO_ID_FIELD.full_name = ".sgland.Guard.info_id"
var_0_26.INFO_ID_FIELD.number = 1
var_0_26.INFO_ID_FIELD.index = 0
var_0_26.INFO_ID_FIELD.label = 2
var_0_26.INFO_ID_FIELD.has_default_value = false
var_0_26.INFO_ID_FIELD.default_value = 0
var_0_26.INFO_ID_FIELD.type = 5
var_0_26.INFO_ID_FIELD.cpp_type = 1
var_0_26.TIMESTAMP_FIELD.name = "timestamp"
var_0_26.TIMESTAMP_FIELD.full_name = ".sgland.Guard.timestamp"
var_0_26.TIMESTAMP_FIELD.number = 2
var_0_26.TIMESTAMP_FIELD.index = 1
var_0_26.TIMESTAMP_FIELD.label = 2
var_0_26.TIMESTAMP_FIELD.has_default_value = false
var_0_26.TIMESTAMP_FIELD.default_value = 0
var_0_26.TIMESTAMP_FIELD.type = 3
var_0_26.TIMESTAMP_FIELD.cpp_type = 2
var_0_26.SPAN_FIELD.name = "span"
var_0_26.SPAN_FIELD.full_name = ".sgland.Guard.span"
var_0_26.SPAN_FIELD.number = 3
var_0_26.SPAN_FIELD.index = 2
var_0_26.SPAN_FIELD.label = 2
var_0_26.SPAN_FIELD.has_default_value = false
var_0_26.SPAN_FIELD.default_value = 0
var_0_26.SPAN_FIELD.type = 3
var_0_26.SPAN_FIELD.cpp_type = 2
GUARD.name = "Guard"
GUARD.full_name = ".sgland.Guard"
GUARD.nested_types = {}
GUARD.enum_types = {}
GUARD.fields = {
	var_0_26.INFO_ID_FIELD,
	var_0_26.TIMESTAMP_FIELD,
	var_0_26.SPAN_FIELD
}
GUARD.is_extendable = false
GUARD.extensions = {}
var_0_27.PKG_ID_FIELD.name = "pkg_id"
var_0_27.PKG_ID_FIELD.full_name = ".sgland.PkgGuard.pkg_id"
var_0_27.PKG_ID_FIELD.number = 1
var_0_27.PKG_ID_FIELD.index = 0
var_0_27.PKG_ID_FIELD.label = 2
var_0_27.PKG_ID_FIELD.has_default_value = false
var_0_27.PKG_ID_FIELD.default_value = 0
var_0_27.PKG_ID_FIELD.type = 5
var_0_27.PKG_ID_FIELD.cpp_type = 1
var_0_27.TIMESTAMP_FIELD.name = "timestamp"
var_0_27.TIMESTAMP_FIELD.full_name = ".sgland.PkgGuard.timestamp"
var_0_27.TIMESTAMP_FIELD.number = 2
var_0_27.TIMESTAMP_FIELD.index = 1
var_0_27.TIMESTAMP_FIELD.label = 2
var_0_27.TIMESTAMP_FIELD.has_default_value = false
var_0_27.TIMESTAMP_FIELD.default_value = 0
var_0_27.TIMESTAMP_FIELD.type = 3
var_0_27.TIMESTAMP_FIELD.cpp_type = 2
var_0_27.SPAN_FIELD.name = "span"
var_0_27.SPAN_FIELD.full_name = ".sgland.PkgGuard.span"
var_0_27.SPAN_FIELD.number = 3
var_0_27.SPAN_FIELD.index = 2
var_0_27.SPAN_FIELD.label = 2
var_0_27.SPAN_FIELD.has_default_value = false
var_0_27.SPAN_FIELD.default_value = 0
var_0_27.SPAN_FIELD.type = 3
var_0_27.SPAN_FIELD.cpp_type = 2
PKGGUARD.name = "PkgGuard"
PKGGUARD.full_name = ".sgland.PkgGuard"
PKGGUARD.nested_types = {}
PKGGUARD.enum_types = {}
PKGGUARD.fields = {
	var_0_27.PKG_ID_FIELD,
	var_0_27.TIMESTAMP_FIELD,
	var_0_27.SPAN_FIELD
}
PKGGUARD.is_extendable = false
PKGGUARD.extensions = {}
var_0_28.ID_FIELD.name = "id"
var_0_28.ID_FIELD.full_name = ".sgland.GuardSlot.id"
var_0_28.ID_FIELD.number = 1
var_0_28.ID_FIELD.index = 0
var_0_28.ID_FIELD.label = 2
var_0_28.ID_FIELD.has_default_value = false
var_0_28.ID_FIELD.default_value = 0
var_0_28.ID_FIELD.type = 5
var_0_28.ID_FIELD.cpp_type = 1
var_0_28.LEVEL_FIELD.name = "level"
var_0_28.LEVEL_FIELD.full_name = ".sgland.GuardSlot.level"
var_0_28.LEVEL_FIELD.number = 2
var_0_28.LEVEL_FIELD.index = 1
var_0_28.LEVEL_FIELD.label = 2
var_0_28.LEVEL_FIELD.has_default_value = false
var_0_28.LEVEL_FIELD.default_value = 0
var_0_28.LEVEL_FIELD.type = 5
var_0_28.LEVEL_FIELD.cpp_type = 1
var_0_28.GUARD_FIELD.name = "guard"
var_0_28.GUARD_FIELD.full_name = ".sgland.GuardSlot.guard"
var_0_28.GUARD_FIELD.number = 3
var_0_28.GUARD_FIELD.index = 2
var_0_28.GUARD_FIELD.label = 1
var_0_28.GUARD_FIELD.has_default_value = false
var_0_28.GUARD_FIELD.default_value = nil
var_0_28.GUARD_FIELD.message_type = GUARD
var_0_28.GUARD_FIELD.type = 11
var_0_28.GUARD_FIELD.cpp_type = 10
GUARDSLOT.name = "GuardSlot"
GUARDSLOT.full_name = ".sgland.GuardSlot"
GUARDSLOT.nested_types = {}
GUARDSLOT.enum_types = {}
GUARDSLOT.fields = {
	var_0_28.ID_FIELD,
	var_0_28.LEVEL_FIELD,
	var_0_28.GUARD_FIELD
}
GUARDSLOT.is_extendable = false
GUARDSLOT.extensions = {}
var_0_29.ID_FIELD.name = "id"
var_0_29.ID_FIELD.full_name = ".sgland.PkgGuardSlot.id"
var_0_29.ID_FIELD.number = 1
var_0_29.ID_FIELD.index = 0
var_0_29.ID_FIELD.label = 2
var_0_29.ID_FIELD.has_default_value = false
var_0_29.ID_FIELD.default_value = 0
var_0_29.ID_FIELD.type = 5
var_0_29.ID_FIELD.cpp_type = 1
var_0_29.PKG_GUARD_FIELD.name = "pkg_guard"
var_0_29.PKG_GUARD_FIELD.full_name = ".sgland.PkgGuardSlot.pkg_guard"
var_0_29.PKG_GUARD_FIELD.number = 3
var_0_29.PKG_GUARD_FIELD.index = 1
var_0_29.PKG_GUARD_FIELD.label = 1
var_0_29.PKG_GUARD_FIELD.has_default_value = false
var_0_29.PKG_GUARD_FIELD.default_value = nil
var_0_29.PKG_GUARD_FIELD.message_type = PKGGUARD
var_0_29.PKG_GUARD_FIELD.type = 11
var_0_29.PKG_GUARD_FIELD.cpp_type = 10
PKGGUARDSLOT.name = "PkgGuardSlot"
PKGGUARDSLOT.full_name = ".sgland.PkgGuardSlot"
PKGGUARDSLOT.nested_types = {}
PKGGUARDSLOT.enum_types = {}
PKGGUARDSLOT.fields = {
	var_0_29.ID_FIELD,
	var_0_29.PKG_GUARD_FIELD
}
PKGGUARDSLOT.is_extendable = false
PKGGUARDSLOT.extensions = {}
var_0_30.INFO_ID_FIELD.name = "info_id"
var_0_30.INFO_ID_FIELD.full_name = ".sgland.City.info_id"
var_0_30.INFO_ID_FIELD.number = 1
var_0_30.INFO_ID_FIELD.index = 0
var_0_30.INFO_ID_FIELD.label = 2
var_0_30.INFO_ID_FIELD.has_default_value = false
var_0_30.INFO_ID_FIELD.default_value = 0
var_0_30.INFO_ID_FIELD.type = 5
var_0_30.INFO_ID_FIELD.cpp_type = 1
var_0_30.CHAPTER_FIELD.name = "chapter"
var_0_30.CHAPTER_FIELD.full_name = ".sgland.City.chapter"
var_0_30.CHAPTER_FIELD.number = 2
var_0_30.CHAPTER_FIELD.index = 1
var_0_30.CHAPTER_FIELD.label = 2
var_0_30.CHAPTER_FIELD.has_default_value = false
var_0_30.CHAPTER_FIELD.default_value = 0
var_0_30.CHAPTER_FIELD.type = 5
var_0_30.CHAPTER_FIELD.cpp_type = 1
var_0_30.OWNER_TYPE_FIELD.name = "owner_type"
var_0_30.OWNER_TYPE_FIELD.full_name = ".sgland.City.owner_type"
var_0_30.OWNER_TYPE_FIELD.number = 3
var_0_30.OWNER_TYPE_FIELD.index = 2
var_0_30.OWNER_TYPE_FIELD.label = 2
var_0_30.OWNER_TYPE_FIELD.has_default_value = false
var_0_30.OWNER_TYPE_FIELD.default_value = 0
var_0_30.OWNER_TYPE_FIELD.type = 5
var_0_30.OWNER_TYPE_FIELD.cpp_type = 1
var_0_30.OWNER_ID_FIELD.name = "owner_id"
var_0_30.OWNER_ID_FIELD.full_name = ".sgland.City.owner_id"
var_0_30.OWNER_ID_FIELD.number = 4
var_0_30.OWNER_ID_FIELD.index = 3
var_0_30.OWNER_ID_FIELD.label = 2
var_0_30.OWNER_ID_FIELD.has_default_value = false
var_0_30.OWNER_ID_FIELD.default_value = 0
var_0_30.OWNER_ID_FIELD.type = 3
var_0_30.OWNER_ID_FIELD.cpp_type = 2
var_0_30.SWEEP_COUNT_FIELD.name = "sweep_count"
var_0_30.SWEEP_COUNT_FIELD.full_name = ".sgland.City.sweep_count"
var_0_30.SWEEP_COUNT_FIELD.number = 5
var_0_30.SWEEP_COUNT_FIELD.index = 4
var_0_30.SWEEP_COUNT_FIELD.label = 3
var_0_30.SWEEP_COUNT_FIELD.has_default_value = false
var_0_30.SWEEP_COUNT_FIELD.default_value = {}
var_0_30.SWEEP_COUNT_FIELD.type = 5
var_0_30.SWEEP_COUNT_FIELD.cpp_type = 1
var_0_30.TIMESTAMP_FIELD.name = "timestamp"
var_0_30.TIMESTAMP_FIELD.full_name = ".sgland.City.timestamp"
var_0_30.TIMESTAMP_FIELD.number = 6
var_0_30.TIMESTAMP_FIELD.index = 5
var_0_30.TIMESTAMP_FIELD.label = 1
var_0_30.TIMESTAMP_FIELD.has_default_value = false
var_0_30.TIMESTAMP_FIELD.default_value = 0
var_0_30.TIMESTAMP_FIELD.type = 3
var_0_30.TIMESTAMP_FIELD.cpp_type = 2
var_0_30.RESET_COUNT_FIELD.name = "reset_count"
var_0_30.RESET_COUNT_FIELD.full_name = ".sgland.City.reset_count"
var_0_30.RESET_COUNT_FIELD.number = 7
var_0_30.RESET_COUNT_FIELD.index = 6
var_0_30.RESET_COUNT_FIELD.label = 3
var_0_30.RESET_COUNT_FIELD.has_default_value = false
var_0_30.RESET_COUNT_FIELD.default_value = {}
var_0_30.RESET_COUNT_FIELD.type = 5
var_0_30.RESET_COUNT_FIELD.cpp_type = 1
CITY.name = "City"
CITY.full_name = ".sgland.City"
CITY.nested_types = {}
CITY.enum_types = {}
CITY.fields = {
	var_0_30.INFO_ID_FIELD,
	var_0_30.CHAPTER_FIELD,
	var_0_30.OWNER_TYPE_FIELD,
	var_0_30.OWNER_ID_FIELD,
	var_0_30.SWEEP_COUNT_FIELD,
	var_0_30.TIMESTAMP_FIELD,
	var_0_30.RESET_COUNT_FIELD
}
CITY.is_extendable = false
CITY.extensions = {}
var_0_31.CID_FIELD.name = "cid"
var_0_31.CID_FIELD.full_name = ".sgland.Bonus.cid"
var_0_31.CID_FIELD.number = 1
var_0_31.CID_FIELD.index = 0
var_0_31.CID_FIELD.label = 2
var_0_31.CID_FIELD.has_default_value = false
var_0_31.CID_FIELD.default_value = 0
var_0_31.CID_FIELD.type = 5
var_0_31.CID_FIELD.cpp_type = 1
var_0_31.VALUE_FIELD.name = "value"
var_0_31.VALUE_FIELD.full_name = ".sgland.Bonus.value"
var_0_31.VALUE_FIELD.number = 2
var_0_31.VALUE_FIELD.index = 1
var_0_31.VALUE_FIELD.label = 2
var_0_31.VALUE_FIELD.has_default_value = false
var_0_31.VALUE_FIELD.default_value = 0
var_0_31.VALUE_FIELD.type = 5
var_0_31.VALUE_FIELD.cpp_type = 1
BONUS.name = "Bonus"
BONUS.full_name = ".sgland.Bonus"
BONUS.nested_types = {}
BONUS.enum_types = {}
BONUS.fields = {
	var_0_31.CID_FIELD,
	var_0_31.VALUE_FIELD
}
BONUS.is_extendable = false
BONUS.extensions = {}
var_0_32.RESOURCES_FIELD.name = "resources"
var_0_32.RESOURCES_FIELD.full_name = ".sgland.Extra.resources"
var_0_32.RESOURCES_FIELD.number = 1
var_0_32.RESOURCES_FIELD.index = 0
var_0_32.RESOURCES_FIELD.label = 3
var_0_32.RESOURCES_FIELD.has_default_value = false
var_0_32.RESOURCES_FIELD.default_value = {}
var_0_32.RESOURCES_FIELD.message_type = RESOURCE
var_0_32.RESOURCES_FIELD.type = 11
var_0_32.RESOURCES_FIELD.cpp_type = 10
EXTRA.name = "Extra"
EXTRA.full_name = ".sgland.Extra"
EXTRA.nested_types = {}
EXTRA.enum_types = {}
EXTRA.fields = {
	var_0_32.RESOURCES_FIELD
}
EXTRA.is_extendable = false
EXTRA.extensions = {}
var_0_33.ID_FIELD.name = "id"
var_0_33.ID_FIELD.full_name = ".sgland.ActivityBonus.id"
var_0_33.ID_FIELD.number = 1
var_0_33.ID_FIELD.index = 0
var_0_33.ID_FIELD.label = 2
var_0_33.ID_FIELD.has_default_value = false
var_0_33.ID_FIELD.default_value = 0
var_0_33.ID_FIELD.type = 3
var_0_33.ID_FIELD.cpp_type = 2
var_0_33.INFO_ID_FIELD.name = "info_id"
var_0_33.INFO_ID_FIELD.full_name = ".sgland.ActivityBonus.info_id"
var_0_33.INFO_ID_FIELD.number = 2
var_0_33.INFO_ID_FIELD.index = 1
var_0_33.INFO_ID_FIELD.label = 2
var_0_33.INFO_ID_FIELD.has_default_value = false
var_0_33.INFO_ID_FIELD.default_value = 0
var_0_33.INFO_ID_FIELD.type = 5
var_0_33.INFO_ID_FIELD.cpp_type = 1
var_0_33.TIMESTAMP_FIELD.name = "timestamp"
var_0_33.TIMESTAMP_FIELD.full_name = ".sgland.ActivityBonus.timestamp"
var_0_33.TIMESTAMP_FIELD.number = 3
var_0_33.TIMESTAMP_FIELD.index = 2
var_0_33.TIMESTAMP_FIELD.label = 2
var_0_33.TIMESTAMP_FIELD.has_default_value = false
var_0_33.TIMESTAMP_FIELD.default_value = 0
var_0_33.TIMESTAMP_FIELD.type = 3
var_0_33.TIMESTAMP_FIELD.cpp_type = 2
var_0_33.TITLE_FIELD.name = "title"
var_0_33.TITLE_FIELD.full_name = ".sgland.ActivityBonus.title"
var_0_33.TITLE_FIELD.number = 4
var_0_33.TITLE_FIELD.index = 3
var_0_33.TITLE_FIELD.label = 1
var_0_33.TITLE_FIELD.has_default_value = false
var_0_33.TITLE_FIELD.default_value = ""
var_0_33.TITLE_FIELD.type = 9
var_0_33.TITLE_FIELD.cpp_type = 9
var_0_33.EXTRA_FIELD.name = "extra"
var_0_33.EXTRA_FIELD.full_name = ".sgland.ActivityBonus.extra"
var_0_33.EXTRA_FIELD.number = 5
var_0_33.EXTRA_FIELD.index = 4
var_0_33.EXTRA_FIELD.label = 1
var_0_33.EXTRA_FIELD.has_default_value = false
var_0_33.EXTRA_FIELD.default_value = nil
var_0_33.EXTRA_FIELD.message_type = EXTRA
var_0_33.EXTRA_FIELD.type = 11
var_0_33.EXTRA_FIELD.cpp_type = 10
var_0_33.CLAIMED_FIELD.name = "claimed"
var_0_33.CLAIMED_FIELD.full_name = ".sgland.ActivityBonus.claimed"
var_0_33.CLAIMED_FIELD.number = 6
var_0_33.CLAIMED_FIELD.index = 5
var_0_33.CLAIMED_FIELD.label = 1
var_0_33.CLAIMED_FIELD.has_default_value = false
var_0_33.CLAIMED_FIELD.default_value = false
var_0_33.CLAIMED_FIELD.type = 8
var_0_33.CLAIMED_FIELD.cpp_type = 7
ACTIVITYBONUS.name = "ActivityBonus"
ACTIVITYBONUS.full_name = ".sgland.ActivityBonus"
ACTIVITYBONUS.nested_types = {}
ACTIVITYBONUS.enum_types = {}
ACTIVITYBONUS.fields = {
	var_0_33.ID_FIELD,
	var_0_33.INFO_ID_FIELD,
	var_0_33.TIMESTAMP_FIELD,
	var_0_33.TITLE_FIELD,
	var_0_33.EXTRA_FIELD,
	var_0_33.CLAIMED_FIELD
}
ACTIVITYBONUS.is_extendable = false
ACTIVITYBONUS.extensions = {}
var_0_34.TROOP_ITEM_FIELD.name = "troop_item"
var_0_34.TROOP_ITEM_FIELD.full_name = ".sgland.Troop.troop_item"
var_0_34.TROOP_ITEM_FIELD.number = 1
var_0_34.TROOP_ITEM_FIELD.index = 0
var_0_34.TROOP_ITEM_FIELD.label = 3
var_0_34.TROOP_ITEM_FIELD.has_default_value = false
var_0_34.TROOP_ITEM_FIELD.default_value = {}
var_0_34.TROOP_ITEM_FIELD.message_type = RESOURCE
var_0_34.TROOP_ITEM_FIELD.type = 11
var_0_34.TROOP_ITEM_FIELD.cpp_type = 10
var_0_34.NAME_FIELD.name = "name"
var_0_34.NAME_FIELD.full_name = ".sgland.Troop.name"
var_0_34.NAME_FIELD.number = 2
var_0_34.NAME_FIELD.index = 1
var_0_34.NAME_FIELD.label = 1
var_0_34.NAME_FIELD.has_default_value = false
var_0_34.NAME_FIELD.default_value = ""
var_0_34.NAME_FIELD.type = 9
var_0_34.NAME_FIELD.cpp_type = 9
TROOP.name = "Troop"
TROOP.full_name = ".sgland.Troop"
TROOP.nested_types = {}
TROOP.enum_types = {}
TROOP.fields = {
	var_0_34.TROOP_ITEM_FIELD,
	var_0_34.NAME_FIELD
}
TROOP.is_extendable = false
TROOP.extensions = {}
var_0_35.INFO_ID_FIELD.name = "info_id"
var_0_35.INFO_ID_FIELD.full_name = ".sgland.SkinInUse.info_id"
var_0_35.INFO_ID_FIELD.number = 1
var_0_35.INFO_ID_FIELD.index = 0
var_0_35.INFO_ID_FIELD.label = 2
var_0_35.INFO_ID_FIELD.has_default_value = false
var_0_35.INFO_ID_FIELD.default_value = 0
var_0_35.INFO_ID_FIELD.type = 5
var_0_35.INFO_ID_FIELD.cpp_type = 1
var_0_35.SKIN_ID_FIELD.name = "skin_id"
var_0_35.SKIN_ID_FIELD.full_name = ".sgland.SkinInUse.skin_id"
var_0_35.SKIN_ID_FIELD.number = 2
var_0_35.SKIN_ID_FIELD.index = 1
var_0_35.SKIN_ID_FIELD.label = 2
var_0_35.SKIN_ID_FIELD.has_default_value = false
var_0_35.SKIN_ID_FIELD.default_value = 0
var_0_35.SKIN_ID_FIELD.type = 5
var_0_35.SKIN_ID_FIELD.cpp_type = 1
var_0_35.EFFECT_IDS_FIELD.name = "effect_ids"
var_0_35.EFFECT_IDS_FIELD.full_name = ".sgland.SkinInUse.effect_ids"
var_0_35.EFFECT_IDS_FIELD.number = 3
var_0_35.EFFECT_IDS_FIELD.index = 2
var_0_35.EFFECT_IDS_FIELD.label = 3
var_0_35.EFFECT_IDS_FIELD.has_default_value = false
var_0_35.EFFECT_IDS_FIELD.default_value = {}
var_0_35.EFFECT_IDS_FIELD.type = 5
var_0_35.EFFECT_IDS_FIELD.cpp_type = 1
SKININUSE.name = "SkinInUse"
SKININUSE.full_name = ".sgland.SkinInUse"
SKININUSE.nested_types = {}
SKININUSE.enum_types = {}
SKININUSE.fields = {
	var_0_35.INFO_ID_FIELD,
	var_0_35.SKIN_ID_FIELD,
	var_0_35.EFFECT_IDS_FIELD
}
SKININUSE.is_extendable = false
SKININUSE.extensions = {}
var_0_36.CARD_FIELD.name = "card"
var_0_36.CARD_FIELD.full_name = ".sgland.CardExtraSkill.card"
var_0_36.CARD_FIELD.number = 1
var_0_36.CARD_FIELD.index = 0
var_0_36.CARD_FIELD.label = 2
var_0_36.CARD_FIELD.has_default_value = false
var_0_36.CARD_FIELD.default_value = 0
var_0_36.CARD_FIELD.type = 5
var_0_36.CARD_FIELD.cpp_type = 1
var_0_36.SKILLS_FIELD.name = "skills"
var_0_36.SKILLS_FIELD.full_name = ".sgland.CardExtraSkill.skills"
var_0_36.SKILLS_FIELD.number = 2
var_0_36.SKILLS_FIELD.index = 1
var_0_36.SKILLS_FIELD.label = 3
var_0_36.SKILLS_FIELD.has_default_value = false
var_0_36.SKILLS_FIELD.default_value = {}
var_0_36.SKILLS_FIELD.type = 3
var_0_36.SKILLS_FIELD.cpp_type = 2
CARDEXTRASKILL.name = "CardExtraSkill"
CARDEXTRASKILL.full_name = ".sgland.CardExtraSkill"
CARDEXTRASKILL.nested_types = {}
CARDEXTRASKILL.enum_types = {}
CARDEXTRASKILL.fields = {
	var_0_36.CARD_FIELD,
	var_0_36.SKILLS_FIELD
}
CARDEXTRASKILL.is_extendable = false
CARDEXTRASKILL.extensions = {}
var_0_37.ID_FIELD.name = "id"
var_0_37.ID_FIELD.full_name = ".sgland.TroopData.id"
var_0_37.ID_FIELD.number = 1
var_0_37.ID_FIELD.index = 0
var_0_37.ID_FIELD.label = 2
var_0_37.ID_FIELD.has_default_value = false
var_0_37.ID_FIELD.default_value = 0
var_0_37.ID_FIELD.type = 3
var_0_37.ID_FIELD.cpp_type = 2
var_0_37.HP_FIELD.name = "hp"
var_0_37.HP_FIELD.full_name = ".sgland.TroopData.hp"
var_0_37.HP_FIELD.number = 2
var_0_37.HP_FIELD.index = 1
var_0_37.HP_FIELD.label = 2
var_0_37.HP_FIELD.has_default_value = false
var_0_37.HP_FIELD.default_value = 0
var_0_37.HP_FIELD.type = 5
var_0_37.HP_FIELD.cpp_type = 1
var_0_37.CARDS_FIELD.name = "cards"
var_0_37.CARDS_FIELD.full_name = ".sgland.TroopData.cards"
var_0_37.CARDS_FIELD.number = 3
var_0_37.CARDS_FIELD.index = 2
var_0_37.CARDS_FIELD.label = 3
var_0_37.CARDS_FIELD.has_default_value = false
var_0_37.CARDS_FIELD.default_value = {}
var_0_37.CARDS_FIELD.message_type = RESOURCE
var_0_37.CARDS_FIELD.type = 11
var_0_37.CARDS_FIELD.cpp_type = 10
var_0_37.INFO_FIELD.name = "info"
var_0_37.INFO_FIELD.full_name = ".sgland.TroopData.info"
var_0_37.INFO_FIELD.number = 4
var_0_37.INFO_FIELD.index = 3
var_0_37.INFO_FIELD.label = 1
var_0_37.INFO_FIELD.has_default_value = false
var_0_37.INFO_FIELD.default_value = nil
var_0_37.INFO_FIELD.message_type = USERINFO
var_0_37.INFO_FIELD.type = 11
var_0_37.INFO_FIELD.cpp_type = 10
var_0_37.ASSISTANT_FIELD.name = "assistant"
var_0_37.ASSISTANT_FIELD.full_name = ".sgland.TroopData.assistant"
var_0_37.ASSISTANT_FIELD.number = 5
var_0_37.ASSISTANT_FIELD.index = 4
var_0_37.ASSISTANT_FIELD.label = 3
var_0_37.ASSISTANT_FIELD.has_default_value = false
var_0_37.ASSISTANT_FIELD.default_value = {}
var_0_37.ASSISTANT_FIELD.type = 5
var_0_37.ASSISTANT_FIELD.cpp_type = 1
var_0_37.LEVELS_FIELD.name = "levels"
var_0_37.LEVELS_FIELD.full_name = ".sgland.TroopData.levels"
var_0_37.LEVELS_FIELD.number = 6
var_0_37.LEVELS_FIELD.index = 5
var_0_37.LEVELS_FIELD.label = 3
var_0_37.LEVELS_FIELD.has_default_value = false
var_0_37.LEVELS_FIELD.default_value = {}
var_0_37.LEVELS_FIELD.message_type = CARDLEVEL
var_0_37.LEVELS_FIELD.type = 11
var_0_37.LEVELS_FIELD.cpp_type = 10
var_0_37.SKINS_FIELD.name = "skins"
var_0_37.SKINS_FIELD.full_name = ".sgland.TroopData.skins"
var_0_37.SKINS_FIELD.number = 7
var_0_37.SKINS_FIELD.index = 6
var_0_37.SKINS_FIELD.label = 3
var_0_37.SKINS_FIELD.has_default_value = false
var_0_37.SKINS_FIELD.default_value = {}
var_0_37.SKINS_FIELD.message_type = SKININUSE
var_0_37.SKINS_FIELD.type = 11
var_0_37.SKINS_FIELD.cpp_type = 10
var_0_37.INIT_ROUND_TIMEOUT_FIELD.name = "init_round_timeout"
var_0_37.INIT_ROUND_TIMEOUT_FIELD.full_name = ".sgland.TroopData.init_round_timeout"
var_0_37.INIT_ROUND_TIMEOUT_FIELD.number = 8
var_0_37.INIT_ROUND_TIMEOUT_FIELD.index = 7
var_0_37.INIT_ROUND_TIMEOUT_FIELD.label = 1
var_0_37.INIT_ROUND_TIMEOUT_FIELD.has_default_value = false
var_0_37.INIT_ROUND_TIMEOUT_FIELD.default_value = 0
var_0_37.INIT_ROUND_TIMEOUT_FIELD.type = 5
var_0_37.INIT_ROUND_TIMEOUT_FIELD.cpp_type = 1
var_0_37.ROUND_EXTRA_TIMEOUT_FIELD.name = "round_extra_timeout"
var_0_37.ROUND_EXTRA_TIMEOUT_FIELD.full_name = ".sgland.TroopData.round_extra_timeout"
var_0_37.ROUND_EXTRA_TIMEOUT_FIELD.number = 9
var_0_37.ROUND_EXTRA_TIMEOUT_FIELD.index = 8
var_0_37.ROUND_EXTRA_TIMEOUT_FIELD.label = 1
var_0_37.ROUND_EXTRA_TIMEOUT_FIELD.has_default_value = false
var_0_37.ROUND_EXTRA_TIMEOUT_FIELD.default_value = 0
var_0_37.ROUND_EXTRA_TIMEOUT_FIELD.type = 5
var_0_37.ROUND_EXTRA_TIMEOUT_FIELD.cpp_type = 1
var_0_37.ROUND_TIMEOUT_FIELD.name = "round_timeout"
var_0_37.ROUND_TIMEOUT_FIELD.full_name = ".sgland.TroopData.round_timeout"
var_0_37.ROUND_TIMEOUT_FIELD.number = 10
var_0_37.ROUND_TIMEOUT_FIELD.index = 9
var_0_37.ROUND_TIMEOUT_FIELD.label = 1
var_0_37.ROUND_TIMEOUT_FIELD.has_default_value = false
var_0_37.ROUND_TIMEOUT_FIELD.default_value = 0
var_0_37.ROUND_TIMEOUT_FIELD.type = 5
var_0_37.ROUND_TIMEOUT_FIELD.cpp_type = 1
var_0_37.ROUND_OPTIMIZATION_FIELD.name = "round_optimization"
var_0_37.ROUND_OPTIMIZATION_FIELD.full_name = ".sgland.TroopData.round_optimization"
var_0_37.ROUND_OPTIMIZATION_FIELD.number = 11
var_0_37.ROUND_OPTIMIZATION_FIELD.index = 10
var_0_37.ROUND_OPTIMIZATION_FIELD.label = 1
var_0_37.ROUND_OPTIMIZATION_FIELD.has_default_value = false
var_0_37.ROUND_OPTIMIZATION_FIELD.default_value = false
var_0_37.ROUND_OPTIMIZATION_FIELD.type = 8
var_0_37.ROUND_OPTIMIZATION_FIELD.cpp_type = 7
var_0_37.CARD_EXTRA_SKILLS_FIELD.name = "card_extra_skills"
var_0_37.CARD_EXTRA_SKILLS_FIELD.full_name = ".sgland.TroopData.card_extra_skills"
var_0_37.CARD_EXTRA_SKILLS_FIELD.number = 12
var_0_37.CARD_EXTRA_SKILLS_FIELD.index = 11
var_0_37.CARD_EXTRA_SKILLS_FIELD.label = 3
var_0_37.CARD_EXTRA_SKILLS_FIELD.has_default_value = false
var_0_37.CARD_EXTRA_SKILLS_FIELD.default_value = {}
var_0_37.CARD_EXTRA_SKILLS_FIELD.message_type = CARDEXTRASKILL
var_0_37.CARD_EXTRA_SKILLS_FIELD.type = 11
var_0_37.CARD_EXTRA_SKILLS_FIELD.cpp_type = 10
TROOPDATA.name = "TroopData"
TROOPDATA.full_name = ".sgland.TroopData"
TROOPDATA.nested_types = {}
TROOPDATA.enum_types = {}
TROOPDATA.fields = {
	var_0_37.ID_FIELD,
	var_0_37.HP_FIELD,
	var_0_37.CARDS_FIELD,
	var_0_37.INFO_FIELD,
	var_0_37.ASSISTANT_FIELD,
	var_0_37.LEVELS_FIELD,
	var_0_37.SKINS_FIELD,
	var_0_37.INIT_ROUND_TIMEOUT_FIELD,
	var_0_37.ROUND_EXTRA_TIMEOUT_FIELD,
	var_0_37.ROUND_TIMEOUT_FIELD,
	var_0_37.ROUND_OPTIMIZATION_FIELD,
	var_0_37.CARD_EXTRA_SKILLS_FIELD
}
TROOPDATA.is_extendable = false
TROOPDATA.extensions = {}
var_0_38.ID_FIELD.name = "id"
var_0_38.ID_FIELD.full_name = ".sgland.Chest.id"
var_0_38.ID_FIELD.number = 1
var_0_38.ID_FIELD.index = 0
var_0_38.ID_FIELD.label = 2
var_0_38.ID_FIELD.has_default_value = false
var_0_38.ID_FIELD.default_value = 0
var_0_38.ID_FIELD.type = 5
var_0_38.ID_FIELD.cpp_type = 1
var_0_38.OPENED_FIELD.name = "opened"
var_0_38.OPENED_FIELD.full_name = ".sgland.Chest.opened"
var_0_38.OPENED_FIELD.number = 2
var_0_38.OPENED_FIELD.index = 1
var_0_38.OPENED_FIELD.label = 2
var_0_38.OPENED_FIELD.has_default_value = false
var_0_38.OPENED_FIELD.default_value = false
var_0_38.OPENED_FIELD.type = 8
var_0_38.OPENED_FIELD.cpp_type = 7
CHEST.name = "Chest"
CHEST.full_name = ".sgland.Chest"
CHEST.nested_types = {}
CHEST.enum_types = {}
CHEST.fields = {
	var_0_38.ID_FIELD,
	var_0_38.OPENED_FIELD
}
CHEST.is_extendable = false
CHEST.extensions = {}
var_0_39.ID_FIELD.name = "id"
var_0_39.ID_FIELD.full_name = ".sgland.Drop.id"
var_0_39.ID_FIELD.number = 1
var_0_39.ID_FIELD.index = 0
var_0_39.ID_FIELD.label = 2
var_0_39.ID_FIELD.has_default_value = false
var_0_39.ID_FIELD.default_value = 0
var_0_39.ID_FIELD.type = 5
var_0_39.ID_FIELD.cpp_type = 1
var_0_39.COUNT_FIELD.name = "count"
var_0_39.COUNT_FIELD.full_name = ".sgland.Drop.count"
var_0_39.COUNT_FIELD.number = 2
var_0_39.COUNT_FIELD.index = 1
var_0_39.COUNT_FIELD.label = 2
var_0_39.COUNT_FIELD.has_default_value = false
var_0_39.COUNT_FIELD.default_value = 0
var_0_39.COUNT_FIELD.type = 5
var_0_39.COUNT_FIELD.cpp_type = 1
var_0_39.DROP_FIELD.name = "drop"
var_0_39.DROP_FIELD.full_name = ".sgland.Drop.drop"
var_0_39.DROP_FIELD.number = 3
var_0_39.DROP_FIELD.index = 2
var_0_39.DROP_FIELD.label = 2
var_0_39.DROP_FIELD.has_default_value = false
var_0_39.DROP_FIELD.default_value = 0
var_0_39.DROP_FIELD.type = 5
var_0_39.DROP_FIELD.cpp_type = 1
DROP.name = "Drop"
DROP.full_name = ".sgland.Drop"
DROP.nested_types = {}
DROP.enum_types = {}
DROP.fields = {
	var_0_39.ID_FIELD,
	var_0_39.COUNT_FIELD,
	var_0_39.DROP_FIELD
}
DROP.is_extendable = false
DROP.extensions = {}
var_0_40.ID_FIELD.name = "id"
var_0_40.ID_FIELD.full_name = ".sgland.Chapter.id"
var_0_40.ID_FIELD.number = 1
var_0_40.ID_FIELD.index = 0
var_0_40.ID_FIELD.label = 2
var_0_40.ID_FIELD.has_default_value = false
var_0_40.ID_FIELD.default_value = 0
var_0_40.ID_FIELD.type = 5
var_0_40.ID_FIELD.cpp_type = 1
var_0_40.DROPS_FIELD.name = "drops"
var_0_40.DROPS_FIELD.full_name = ".sgland.Chapter.drops"
var_0_40.DROPS_FIELD.number = 2
var_0_40.DROPS_FIELD.index = 1
var_0_40.DROPS_FIELD.label = 3
var_0_40.DROPS_FIELD.has_default_value = false
var_0_40.DROPS_FIELD.default_value = {}
var_0_40.DROPS_FIELD.message_type = DROP
var_0_40.DROPS_FIELD.type = 11
var_0_40.DROPS_FIELD.cpp_type = 10
CHAPTER.name = "Chapter"
CHAPTER.full_name = ".sgland.Chapter"
CHAPTER.nested_types = {}
CHAPTER.enum_types = {}
CHAPTER.fields = {
	var_0_40.ID_FIELD,
	var_0_40.DROPS_FIELD
}
CHAPTER.is_extendable = false
CHAPTER.extensions = {}
var_0_41.ID_FIELD.name = "id"
var_0_41.ID_FIELD.full_name = ".sgland.Copy.id"
var_0_41.ID_FIELD.number = 1
var_0_41.ID_FIELD.index = 0
var_0_41.ID_FIELD.label = 2
var_0_41.ID_FIELD.has_default_value = false
var_0_41.ID_FIELD.default_value = 0
var_0_41.ID_FIELD.type = 5
var_0_41.ID_FIELD.cpp_type = 1
var_0_41.VALUE_FIELD.name = "value"
var_0_41.VALUE_FIELD.full_name = ".sgland.Copy.value"
var_0_41.VALUE_FIELD.number = 2
var_0_41.VALUE_FIELD.index = 1
var_0_41.VALUE_FIELD.label = 2
var_0_41.VALUE_FIELD.has_default_value = false
var_0_41.VALUE_FIELD.default_value = 0
var_0_41.VALUE_FIELD.type = 5
var_0_41.VALUE_FIELD.cpp_type = 1
var_0_41.SCORE_FIELD.name = "score"
var_0_41.SCORE_FIELD.full_name = ".sgland.Copy.score"
var_0_41.SCORE_FIELD.number = 3
var_0_41.SCORE_FIELD.index = 2
var_0_41.SCORE_FIELD.label = 1
var_0_41.SCORE_FIELD.has_default_value = false
var_0_41.SCORE_FIELD.default_value = 0
var_0_41.SCORE_FIELD.type = 5
var_0_41.SCORE_FIELD.cpp_type = 1
COPY.name = "Copy"
COPY.full_name = ".sgland.Copy"
COPY.nested_types = {}
COPY.enum_types = {}
COPY.fields = {
	var_0_41.ID_FIELD,
	var_0_41.VALUE_FIELD,
	var_0_41.SCORE_FIELD
}
COPY.is_extendable = false
COPY.extensions = {}
var_0_42.ID_FIELD.name = "id"
var_0_42.ID_FIELD.full_name = ".sgland.Tech.id"
var_0_42.ID_FIELD.number = 1
var_0_42.ID_FIELD.index = 0
var_0_42.ID_FIELD.label = 2
var_0_42.ID_FIELD.has_default_value = false
var_0_42.ID_FIELD.default_value = 0
var_0_42.ID_FIELD.type = 5
var_0_42.ID_FIELD.cpp_type = 1
var_0_42.LEVEL_FIELD.name = "level"
var_0_42.LEVEL_FIELD.full_name = ".sgland.Tech.level"
var_0_42.LEVEL_FIELD.number = 2
var_0_42.LEVEL_FIELD.index = 1
var_0_42.LEVEL_FIELD.label = 2
var_0_42.LEVEL_FIELD.has_default_value = false
var_0_42.LEVEL_FIELD.default_value = 0
var_0_42.LEVEL_FIELD.type = 5
var_0_42.LEVEL_FIELD.cpp_type = 1
TECH.name = "Tech"
TECH.full_name = ".sgland.Tech"
TECH.nested_types = {}
TECH.enum_types = {}
TECH.fields = {
	var_0_42.ID_FIELD,
	var_0_42.LEVEL_FIELD
}
TECH.is_extendable = false
TECH.extensions = {}
var_0_43.CHAPTERS_FIELD.name = "chapters"
var_0_43.CHAPTERS_FIELD.full_name = ".sgland.PlayerDrop.chapters"
var_0_43.CHAPTERS_FIELD.number = 1
var_0_43.CHAPTERS_FIELD.index = 0
var_0_43.CHAPTERS_FIELD.label = 3
var_0_43.CHAPTERS_FIELD.has_default_value = false
var_0_43.CHAPTERS_FIELD.default_value = {}
var_0_43.CHAPTERS_FIELD.message_type = CHAPTER
var_0_43.CHAPTERS_FIELD.type = 11
var_0_43.CHAPTERS_FIELD.cpp_type = 10
PLAYERDROP.name = "PlayerDrop"
PLAYERDROP.full_name = ".sgland.PlayerDrop"
PLAYERDROP.nested_types = {}
PLAYERDROP.enum_types = {}
PLAYERDROP.fields = {
	var_0_43.CHAPTERS_FIELD
}
PLAYERDROP.is_extendable = false
PLAYERDROP.extensions = {}
var_0_44.COPIES_FIELD.name = "copies"
var_0_44.COPIES_FIELD.full_name = ".sgland.PlayerCopy.copies"
var_0_44.COPIES_FIELD.number = 1
var_0_44.COPIES_FIELD.index = 0
var_0_44.COPIES_FIELD.label = 3
var_0_44.COPIES_FIELD.has_default_value = false
var_0_44.COPIES_FIELD.default_value = {}
var_0_44.COPIES_FIELD.message_type = COPY
var_0_44.COPIES_FIELD.type = 11
var_0_44.COPIES_FIELD.cpp_type = 10
PLAYERCOPY.name = "PlayerCopy"
PLAYERCOPY.full_name = ".sgland.PlayerCopy"
PLAYERCOPY.nested_types = {}
PLAYERCOPY.enum_types = {}
PLAYERCOPY.fields = {
	var_0_44.COPIES_FIELD
}
PLAYERCOPY.is_extendable = false
PLAYERCOPY.extensions = {}
var_0_45.INFO_ID_FIELD.name = "info_id"
var_0_45.INFO_ID_FIELD.full_name = ".sgland.Skin.info_id"
var_0_45.INFO_ID_FIELD.number = 1
var_0_45.INFO_ID_FIELD.index = 0
var_0_45.INFO_ID_FIELD.label = 2
var_0_45.INFO_ID_FIELD.has_default_value = false
var_0_45.INFO_ID_FIELD.default_value = 0
var_0_45.INFO_ID_FIELD.type = 5
var_0_45.INFO_ID_FIELD.cpp_type = 1
var_0_45.DEFAULT_SKIN_FIELD.name = "default_skin"
var_0_45.DEFAULT_SKIN_FIELD.full_name = ".sgland.Skin.default_skin"
var_0_45.DEFAULT_SKIN_FIELD.number = 2
var_0_45.DEFAULT_SKIN_FIELD.index = 1
var_0_45.DEFAULT_SKIN_FIELD.label = 2
var_0_45.DEFAULT_SKIN_FIELD.has_default_value = false
var_0_45.DEFAULT_SKIN_FIELD.default_value = 0
var_0_45.DEFAULT_SKIN_FIELD.type = 5
var_0_45.DEFAULT_SKIN_FIELD.cpp_type = 1
var_0_45.SKIN_ID_FIELD.name = "skin_id"
var_0_45.SKIN_ID_FIELD.full_name = ".sgland.Skin.skin_id"
var_0_45.SKIN_ID_FIELD.number = 3
var_0_45.SKIN_ID_FIELD.index = 2
var_0_45.SKIN_ID_FIELD.label = 3
var_0_45.SKIN_ID_FIELD.has_default_value = false
var_0_45.SKIN_ID_FIELD.default_value = {}
var_0_45.SKIN_ID_FIELD.type = 5
var_0_45.SKIN_ID_FIELD.cpp_type = 1
var_0_45.EXPIRE_FIELD.name = "expire"
var_0_45.EXPIRE_FIELD.full_name = ".sgland.Skin.expire"
var_0_45.EXPIRE_FIELD.number = 4
var_0_45.EXPIRE_FIELD.index = 3
var_0_45.EXPIRE_FIELD.label = 3
var_0_45.EXPIRE_FIELD.has_default_value = false
var_0_45.EXPIRE_FIELD.default_value = {}
var_0_45.EXPIRE_FIELD.type = 3
var_0_45.EXPIRE_FIELD.cpp_type = 2
var_0_45.DEFAULT_EFFECTS_FIELD.name = "default_effects"
var_0_45.DEFAULT_EFFECTS_FIELD.full_name = ".sgland.Skin.default_effects"
var_0_45.DEFAULT_EFFECTS_FIELD.number = 5
var_0_45.DEFAULT_EFFECTS_FIELD.index = 4
var_0_45.DEFAULT_EFFECTS_FIELD.label = 3
var_0_45.DEFAULT_EFFECTS_FIELD.has_default_value = false
var_0_45.DEFAULT_EFFECTS_FIELD.default_value = {}
var_0_45.DEFAULT_EFFECTS_FIELD.type = 5
var_0_45.DEFAULT_EFFECTS_FIELD.cpp_type = 1
SKIN.name = "Skin"
SKIN.full_name = ".sgland.Skin"
SKIN.nested_types = {}
SKIN.enum_types = {}
SKIN.fields = {
	var_0_45.INFO_ID_FIELD,
	var_0_45.DEFAULT_SKIN_FIELD,
	var_0_45.SKIN_ID_FIELD,
	var_0_45.EXPIRE_FIELD,
	var_0_45.DEFAULT_EFFECTS_FIELD
}
SKIN.is_extendable = false
SKIN.extensions = {}
var_0_46.CARDS_FIELD.name = "cards"
var_0_46.CARDS_FIELD.full_name = ".sgland.PlayerCard.cards"
var_0_46.CARDS_FIELD.number = 1
var_0_46.CARDS_FIELD.index = 0
var_0_46.CARDS_FIELD.label = 3
var_0_46.CARDS_FIELD.has_default_value = false
var_0_46.CARDS_FIELD.default_value = {}
var_0_46.CARDS_FIELD.message_type = RESOURCE
var_0_46.CARDS_FIELD.type = 11
var_0_46.CARDS_FIELD.cpp_type = 10
var_0_46.TROOPS_FIELD.name = "troops"
var_0_46.TROOPS_FIELD.full_name = ".sgland.PlayerCard.troops"
var_0_46.TROOPS_FIELD.number = 2
var_0_46.TROOPS_FIELD.index = 1
var_0_46.TROOPS_FIELD.label = 3
var_0_46.TROOPS_FIELD.has_default_value = false
var_0_46.TROOPS_FIELD.default_value = {}
var_0_46.TROOPS_FIELD.message_type = TROOP
var_0_46.TROOPS_FIELD.type = 11
var_0_46.TROOPS_FIELD.cpp_type = 10
var_0_46.LEVELS_FIELD.name = "levels"
var_0_46.LEVELS_FIELD.full_name = ".sgland.PlayerCard.levels"
var_0_46.LEVELS_FIELD.number = 3
var_0_46.LEVELS_FIELD.index = 2
var_0_46.LEVELS_FIELD.label = 3
var_0_46.LEVELS_FIELD.has_default_value = false
var_0_46.LEVELS_FIELD.default_value = {}
var_0_46.LEVELS_FIELD.message_type = CARDLEVEL
var_0_46.LEVELS_FIELD.type = 11
var_0_46.LEVELS_FIELD.cpp_type = 10
var_0_46.UNLOCKED_FIELD.name = "unlocked"
var_0_46.UNLOCKED_FIELD.full_name = ".sgland.PlayerCard.unlocked"
var_0_46.UNLOCKED_FIELD.number = 4
var_0_46.UNLOCKED_FIELD.index = 3
var_0_46.UNLOCKED_FIELD.label = 3
var_0_46.UNLOCKED_FIELD.has_default_value = false
var_0_46.UNLOCKED_FIELD.default_value = {}
var_0_46.UNLOCKED_FIELD.type = 5
var_0_46.UNLOCKED_FIELD.cpp_type = 1
var_0_46.SLOTS_FIELD.name = "slots"
var_0_46.SLOTS_FIELD.full_name = ".sgland.PlayerCard.slots"
var_0_46.SLOTS_FIELD.number = 5
var_0_46.SLOTS_FIELD.index = 4
var_0_46.SLOTS_FIELD.label = 3
var_0_46.SLOTS_FIELD.has_default_value = false
var_0_46.SLOTS_FIELD.default_value = {}
var_0_46.SLOTS_FIELD.message_type = GUARDSLOT
var_0_46.SLOTS_FIELD.type = 11
var_0_46.SLOTS_FIELD.cpp_type = 10
var_0_46.SKIN_FIELD.name = "skin"
var_0_46.SKIN_FIELD.full_name = ".sgland.PlayerCard.skin"
var_0_46.SKIN_FIELD.number = 6
var_0_46.SKIN_FIELD.index = 5
var_0_46.SKIN_FIELD.label = 3
var_0_46.SKIN_FIELD.has_default_value = false
var_0_46.SKIN_FIELD.default_value = {}
var_0_46.SKIN_FIELD.message_type = SKIN
var_0_46.SKIN_FIELD.type = 11
var_0_46.SKIN_FIELD.cpp_type = 10
var_0_46.FRAGMENTS_FIELD.name = "fragments"
var_0_46.FRAGMENTS_FIELD.full_name = ".sgland.PlayerCard.fragments"
var_0_46.FRAGMENTS_FIELD.number = 7
var_0_46.FRAGMENTS_FIELD.index = 6
var_0_46.FRAGMENTS_FIELD.label = 3
var_0_46.FRAGMENTS_FIELD.has_default_value = false
var_0_46.FRAGMENTS_FIELD.default_value = {}
var_0_46.FRAGMENTS_FIELD.message_type = RESOURCE
var_0_46.FRAGMENTS_FIELD.type = 11
var_0_46.FRAGMENTS_FIELD.cpp_type = 10
var_0_46.DARK_TROOPS_FIELD.name = "dark_troops"
var_0_46.DARK_TROOPS_FIELD.full_name = ".sgland.PlayerCard.dark_troops"
var_0_46.DARK_TROOPS_FIELD.number = 8
var_0_46.DARK_TROOPS_FIELD.index = 7
var_0_46.DARK_TROOPS_FIELD.label = 3
var_0_46.DARK_TROOPS_FIELD.has_default_value = false
var_0_46.DARK_TROOPS_FIELD.default_value = {}
var_0_46.DARK_TROOPS_FIELD.message_type = TROOP
var_0_46.DARK_TROOPS_FIELD.type = 11
var_0_46.DARK_TROOPS_FIELD.cpp_type = 10
var_0_46.ROOM_DARK_TROOPS_FIELD.name = "room_dark_troops"
var_0_46.ROOM_DARK_TROOPS_FIELD.full_name = ".sgland.PlayerCard.room_dark_troops"
var_0_46.ROOM_DARK_TROOPS_FIELD.number = 9
var_0_46.ROOM_DARK_TROOPS_FIELD.index = 8
var_0_46.ROOM_DARK_TROOPS_FIELD.label = 3
var_0_46.ROOM_DARK_TROOPS_FIELD.has_default_value = false
var_0_46.ROOM_DARK_TROOPS_FIELD.default_value = {}
var_0_46.ROOM_DARK_TROOPS_FIELD.message_type = TROOP
var_0_46.ROOM_DARK_TROOPS_FIELD.type = 11
var_0_46.ROOM_DARK_TROOPS_FIELD.cpp_type = 10
var_0_46.EXTRA_TROOP_COUNT_FIELD.name = "extra_troop_count"
var_0_46.EXTRA_TROOP_COUNT_FIELD.full_name = ".sgland.PlayerCard.extra_troop_count"
var_0_46.EXTRA_TROOP_COUNT_FIELD.number = 10
var_0_46.EXTRA_TROOP_COUNT_FIELD.index = 9
var_0_46.EXTRA_TROOP_COUNT_FIELD.label = 1
var_0_46.EXTRA_TROOP_COUNT_FIELD.has_default_value = false
var_0_46.EXTRA_TROOP_COUNT_FIELD.default_value = 0
var_0_46.EXTRA_TROOP_COUNT_FIELD.type = 5
var_0_46.EXTRA_TROOP_COUNT_FIELD.cpp_type = 1
var_0_46.COLLECTED_FIELD.name = "collected"
var_0_46.COLLECTED_FIELD.full_name = ".sgland.PlayerCard.collected"
var_0_46.COLLECTED_FIELD.number = 11
var_0_46.COLLECTED_FIELD.index = 10
var_0_46.COLLECTED_FIELD.label = 3
var_0_46.COLLECTED_FIELD.has_default_value = false
var_0_46.COLLECTED_FIELD.default_value = {}
var_0_46.COLLECTED_FIELD.type = 5
var_0_46.COLLECTED_FIELD.cpp_type = 1
PLAYERCARD.name = "PlayerCard"
PLAYERCARD.full_name = ".sgland.PlayerCard"
PLAYERCARD.nested_types = {}
PLAYERCARD.enum_types = {}
PLAYERCARD.fields = {
	var_0_46.CARDS_FIELD,
	var_0_46.TROOPS_FIELD,
	var_0_46.LEVELS_FIELD,
	var_0_46.UNLOCKED_FIELD,
	var_0_46.SLOTS_FIELD,
	var_0_46.SKIN_FIELD,
	var_0_46.FRAGMENTS_FIELD,
	var_0_46.DARK_TROOPS_FIELD,
	var_0_46.ROOM_DARK_TROOPS_FIELD,
	var_0_46.EXTRA_TROOP_COUNT_FIELD,
	var_0_46.COLLECTED_FIELD
}
PLAYERCARD.is_extendable = false
PLAYERCARD.extensions = {}
var_0_47.VISITS_FIELD.name = "visits"
var_0_47.VISITS_FIELD.full_name = ".sgland.PlayerCity.visits"
var_0_47.VISITS_FIELD.number = 1
var_0_47.VISITS_FIELD.index = 0
var_0_47.VISITS_FIELD.label = 3
var_0_47.VISITS_FIELD.has_default_value = false
var_0_47.VISITS_FIELD.default_value = {}
var_0_47.VISITS_FIELD.message_type = VISIT
var_0_47.VISITS_FIELD.type = 11
var_0_47.VISITS_FIELD.cpp_type = 10
var_0_47.PROCEDURES_FIELD.name = "procedures"
var_0_47.PROCEDURES_FIELD.full_name = ".sgland.PlayerCity.procedures"
var_0_47.PROCEDURES_FIELD.number = 2
var_0_47.PROCEDURES_FIELD.index = 1
var_0_47.PROCEDURES_FIELD.label = 3
var_0_47.PROCEDURES_FIELD.has_default_value = false
var_0_47.PROCEDURES_FIELD.default_value = {}
var_0_47.PROCEDURES_FIELD.message_type = PROCEDURE
var_0_47.PROCEDURES_FIELD.type = 11
var_0_47.PROCEDURES_FIELD.cpp_type = 10
var_0_47.GUARDS_FIELD.name = "guards"
var_0_47.GUARDS_FIELD.full_name = ".sgland.PlayerCity.guards"
var_0_47.GUARDS_FIELD.number = 3
var_0_47.GUARDS_FIELD.index = 2
var_0_47.GUARDS_FIELD.label = 3
var_0_47.GUARDS_FIELD.has_default_value = false
var_0_47.GUARDS_FIELD.default_value = {}
var_0_47.GUARDS_FIELD.message_type = GUARD
var_0_47.GUARDS_FIELD.type = 11
var_0_47.GUARDS_FIELD.cpp_type = 10
var_0_47.LAST_VIST_FIELD.name = "last_vist"
var_0_47.LAST_VIST_FIELD.full_name = ".sgland.PlayerCity.last_vist"
var_0_47.LAST_VIST_FIELD.number = 4
var_0_47.LAST_VIST_FIELD.index = 3
var_0_47.LAST_VIST_FIELD.label = 2
var_0_47.LAST_VIST_FIELD.has_default_value = false
var_0_47.LAST_VIST_FIELD.default_value = 0
var_0_47.LAST_VIST_FIELD.type = 3
var_0_47.LAST_VIST_FIELD.cpp_type = 2
var_0_47.LAST_COLLECT_GOLD_FIELD.name = "last_collect_gold"
var_0_47.LAST_COLLECT_GOLD_FIELD.full_name = ".sgland.PlayerCity.last_collect_gold"
var_0_47.LAST_COLLECT_GOLD_FIELD.number = 5
var_0_47.LAST_COLLECT_GOLD_FIELD.index = 4
var_0_47.LAST_COLLECT_GOLD_FIELD.label = 2
var_0_47.LAST_COLLECT_GOLD_FIELD.has_default_value = false
var_0_47.LAST_COLLECT_GOLD_FIELD.default_value = 0
var_0_47.LAST_COLLECT_GOLD_FIELD.type = 3
var_0_47.LAST_COLLECT_GOLD_FIELD.cpp_type = 2
var_0_47.LAST_COLLECT_GRAIN_FIELD.name = "last_collect_grain"
var_0_47.LAST_COLLECT_GRAIN_FIELD.full_name = ".sgland.PlayerCity.last_collect_grain"
var_0_47.LAST_COLLECT_GRAIN_FIELD.number = 6
var_0_47.LAST_COLLECT_GRAIN_FIELD.index = 5
var_0_47.LAST_COLLECT_GRAIN_FIELD.label = 2
var_0_47.LAST_COLLECT_GRAIN_FIELD.has_default_value = false
var_0_47.LAST_COLLECT_GRAIN_FIELD.default_value = 0
var_0_47.LAST_COLLECT_GRAIN_FIELD.type = 3
var_0_47.LAST_COLLECT_GRAIN_FIELD.cpp_type = 2
PLAYERCITY.name = "PlayerCity"
PLAYERCITY.full_name = ".sgland.PlayerCity"
PLAYERCITY.nested_types = {}
PLAYERCITY.enum_types = {}
PLAYERCITY.fields = {
	var_0_47.VISITS_FIELD,
	var_0_47.PROCEDURES_FIELD,
	var_0_47.GUARDS_FIELD,
	var_0_47.LAST_VIST_FIELD,
	var_0_47.LAST_COLLECT_GOLD_FIELD,
	var_0_47.LAST_COLLECT_GRAIN_FIELD
}
PLAYERCITY.is_extendable = false
PLAYERCITY.extensions = {}
var_0_48.CUR_LEVELS_FIELD.name = "cur_levels"
var_0_48.CUR_LEVELS_FIELD.full_name = ".sgland.PlayerWorld.cur_levels"
var_0_48.CUR_LEVELS_FIELD.number = 1
var_0_48.CUR_LEVELS_FIELD.index = 0
var_0_48.CUR_LEVELS_FIELD.label = 3
var_0_48.CUR_LEVELS_FIELD.has_default_value = false
var_0_48.CUR_LEVELS_FIELD.default_value = {}
var_0_48.CUR_LEVELS_FIELD.type = 5
var_0_48.CUR_LEVELS_FIELD.cpp_type = 1
PLAYERWORLD.name = "PlayerWorld"
PLAYERWORLD.full_name = ".sgland.PlayerWorld"
PLAYERWORLD.nested_types = {}
PLAYERWORLD.enum_types = {}
PLAYERWORLD.fields = {
	var_0_48.CUR_LEVELS_FIELD
}
PLAYERWORLD.is_extendable = false
PLAYERWORLD.extensions = {}
var_0_49.BONUS_ID_FIELD.name = "bonus_id"
var_0_49.BONUS_ID_FIELD.full_name = ".sgland.YybGift.bonus_id"
var_0_49.BONUS_ID_FIELD.number = 1
var_0_49.BONUS_ID_FIELD.index = 0
var_0_49.BONUS_ID_FIELD.label = 2
var_0_49.BONUS_ID_FIELD.has_default_value = false
var_0_49.BONUS_ID_FIELD.default_value = 0
var_0_49.BONUS_ID_FIELD.type = 5
var_0_49.BONUS_ID_FIELD.cpp_type = 1
var_0_49.TIMESTAMP_FIELD.name = "timestamp"
var_0_49.TIMESTAMP_FIELD.full_name = ".sgland.YybGift.timestamp"
var_0_49.TIMESTAMP_FIELD.number = 2
var_0_49.TIMESTAMP_FIELD.index = 1
var_0_49.TIMESTAMP_FIELD.label = 2
var_0_49.TIMESTAMP_FIELD.has_default_value = false
var_0_49.TIMESTAMP_FIELD.default_value = 0
var_0_49.TIMESTAMP_FIELD.type = 3
var_0_49.TIMESTAMP_FIELD.cpp_type = 2
YYBGIFT.name = "YybGift"
YYBGIFT.full_name = ".sgland.YybGift"
YYBGIFT.nested_types = {}
YYBGIFT.enum_types = {}
YYBGIFT.fields = {
	var_0_49.BONUS_ID_FIELD,
	var_0_49.TIMESTAMP_FIELD
}
YYBGIFT.is_extendable = false
YYBGIFT.extensions = {}
var_0_50.BONUSES_FIELD.name = "bonuses"
var_0_50.BONUSES_FIELD.full_name = ".sgland.PlayerBonus.bonuses"
var_0_50.BONUSES_FIELD.number = 1
var_0_50.BONUSES_FIELD.index = 0
var_0_50.BONUSES_FIELD.label = 3
var_0_50.BONUSES_FIELD.has_default_value = false
var_0_50.BONUSES_FIELD.default_value = {}
var_0_50.BONUSES_FIELD.message_type = BONUS
var_0_50.BONUSES_FIELD.type = 11
var_0_50.BONUSES_FIELD.cpp_type = 10
var_0_50.CLAIMED_FIELD.name = "claimed"
var_0_50.CLAIMED_FIELD.full_name = ".sgland.PlayerBonus.claimed"
var_0_50.CLAIMED_FIELD.number = 2
var_0_50.CLAIMED_FIELD.index = 1
var_0_50.CLAIMED_FIELD.label = 3
var_0_50.CLAIMED_FIELD.has_default_value = false
var_0_50.CLAIMED_FIELD.default_value = {}
var_0_50.CLAIMED_FIELD.type = 5
var_0_50.CLAIMED_FIELD.cpp_type = 1
var_0_50.ITEMS_FIELD.name = "items"
var_0_50.ITEMS_FIELD.full_name = ".sgland.PlayerBonus.items"
var_0_50.ITEMS_FIELD.number = 3
var_0_50.ITEMS_FIELD.index = 2
var_0_50.ITEMS_FIELD.label = 3
var_0_50.ITEMS_FIELD.has_default_value = false
var_0_50.ITEMS_FIELD.default_value = {}
var_0_50.ITEMS_FIELD.message_type = RESOURCE
var_0_50.ITEMS_FIELD.type = 11
var_0_50.ITEMS_FIELD.cpp_type = 10
var_0_50.GIFTS_FIELD.name = "gifts"
var_0_50.GIFTS_FIELD.full_name = ".sgland.PlayerBonus.gifts"
var_0_50.GIFTS_FIELD.number = 4
var_0_50.GIFTS_FIELD.index = 3
var_0_50.GIFTS_FIELD.label = 3
var_0_50.GIFTS_FIELD.has_default_value = false
var_0_50.GIFTS_FIELD.default_value = {}
var_0_50.GIFTS_FIELD.message_type = YYBGIFT
var_0_50.GIFTS_FIELD.type = 11
var_0_50.GIFTS_FIELD.cpp_type = 10
var_0_50.TASK_RESET_COUNT_FIELD.name = "task_reset_count"
var_0_50.TASK_RESET_COUNT_FIELD.full_name = ".sgland.PlayerBonus.task_reset_count"
var_0_50.TASK_RESET_COUNT_FIELD.number = 5
var_0_50.TASK_RESET_COUNT_FIELD.index = 4
var_0_50.TASK_RESET_COUNT_FIELD.label = 1
var_0_50.TASK_RESET_COUNT_FIELD.has_default_value = false
var_0_50.TASK_RESET_COUNT_FIELD.default_value = 0
var_0_50.TASK_RESET_COUNT_FIELD.type = 5
var_0_50.TASK_RESET_COUNT_FIELD.cpp_type = 1
PLAYERBONUS.name = "PlayerBonus"
PLAYERBONUS.full_name = ".sgland.PlayerBonus"
PLAYERBONUS.nested_types = {}
PLAYERBONUS.enum_types = {}
PLAYERBONUS.fields = {
	var_0_50.BONUSES_FIELD,
	var_0_50.CLAIMED_FIELD,
	var_0_50.ITEMS_FIELD,
	var_0_50.GIFTS_FIELD,
	var_0_50.TASK_RESET_COUNT_FIELD
}
PLAYERBONUS.is_extendable = false
PLAYERBONUS.extensions = {}
var_0_51.PROPS_FIELD.name = "props"
var_0_51.PROPS_FIELD.full_name = ".sgland.PlayerProp.props"
var_0_51.PROPS_FIELD.number = 1
var_0_51.PROPS_FIELD.index = 0
var_0_51.PROPS_FIELD.label = 3
var_0_51.PROPS_FIELD.has_default_value = false
var_0_51.PROPS_FIELD.default_value = {}
var_0_51.PROPS_FIELD.message_type = RESOURCE
var_0_51.PROPS_FIELD.type = 11
var_0_51.PROPS_FIELD.cpp_type = 10
var_0_51.CHESTS_FIELD.name = "chests"
var_0_51.CHESTS_FIELD.full_name = ".sgland.PlayerProp.chests"
var_0_51.CHESTS_FIELD.number = 2
var_0_51.CHESTS_FIELD.index = 1
var_0_51.CHESTS_FIELD.label = 3
var_0_51.CHESTS_FIELD.has_default_value = false
var_0_51.CHESTS_FIELD.default_value = {}
var_0_51.CHESTS_FIELD.message_type = CHEST
var_0_51.CHESTS_FIELD.type = 11
var_0_51.CHESTS_FIELD.cpp_type = 10
var_0_51.MARKS_FIELD.name = "marks"
var_0_51.MARKS_FIELD.full_name = ".sgland.PlayerProp.marks"
var_0_51.MARKS_FIELD.number = 3
var_0_51.MARKS_FIELD.index = 2
var_0_51.MARKS_FIELD.label = 3
var_0_51.MARKS_FIELD.has_default_value = false
var_0_51.MARKS_FIELD.default_value = {}
var_0_51.MARKS_FIELD.type = 9
var_0_51.MARKS_FIELD.cpp_type = 9
var_0_51.CROWNS_FIELD.name = "crowns"
var_0_51.CROWNS_FIELD.full_name = ".sgland.PlayerProp.crowns"
var_0_51.CROWNS_FIELD.number = 4
var_0_51.CROWNS_FIELD.index = 3
var_0_51.CROWNS_FIELD.label = 3
var_0_51.CROWNS_FIELD.has_default_value = false
var_0_51.CROWNS_FIELD.default_value = {}
var_0_51.CROWNS_FIELD.message_type = CROWN
var_0_51.CROWNS_FIELD.type = 11
var_0_51.CROWNS_FIELD.cpp_type = 10
var_0_51.LEGEND_CROWNS_FIELD.name = "legend_crowns"
var_0_51.LEGEND_CROWNS_FIELD.full_name = ".sgland.PlayerProp.legend_crowns"
var_0_51.LEGEND_CROWNS_FIELD.number = 5
var_0_51.LEGEND_CROWNS_FIELD.index = 4
var_0_51.LEGEND_CROWNS_FIELD.label = 3
var_0_51.LEGEND_CROWNS_FIELD.has_default_value = false
var_0_51.LEGEND_CROWNS_FIELD.default_value = {}
var_0_51.LEGEND_CROWNS_FIELD.message_type = CROWN
var_0_51.LEGEND_CROWNS_FIELD.type = 11
var_0_51.LEGEND_CROWNS_FIELD.cpp_type = 10
var_0_51.CUR_LEGEND_CROWN_FIELD.name = "cur_legend_crown"
var_0_51.CUR_LEGEND_CROWN_FIELD.full_name = ".sgland.PlayerProp.cur_legend_crown"
var_0_51.CUR_LEGEND_CROWN_FIELD.number = 6
var_0_51.CUR_LEGEND_CROWN_FIELD.index = 5
var_0_51.CUR_LEGEND_CROWN_FIELD.label = 1
var_0_51.CUR_LEGEND_CROWN_FIELD.has_default_value = false
var_0_51.CUR_LEGEND_CROWN_FIELD.default_value = 0
var_0_51.CUR_LEGEND_CROWN_FIELD.type = 5
var_0_51.CUR_LEGEND_CROWN_FIELD.cpp_type = 1
var_0_51.LAST_LEGEND_CROWN_TIMESTAMP_FIELD.name = "last_legend_crown_timestamp"
var_0_51.LAST_LEGEND_CROWN_TIMESTAMP_FIELD.full_name = ".sgland.PlayerProp.last_legend_crown_timestamp"
var_0_51.LAST_LEGEND_CROWN_TIMESTAMP_FIELD.number = 7
var_0_51.LAST_LEGEND_CROWN_TIMESTAMP_FIELD.index = 6
var_0_51.LAST_LEGEND_CROWN_TIMESTAMP_FIELD.label = 1
var_0_51.LAST_LEGEND_CROWN_TIMESTAMP_FIELD.has_default_value = false
var_0_51.LAST_LEGEND_CROWN_TIMESTAMP_FIELD.default_value = 0
var_0_51.LAST_LEGEND_CROWN_TIMESTAMP_FIELD.type = 3
var_0_51.LAST_LEGEND_CROWN_TIMESTAMP_FIELD.cpp_type = 2
PLAYERPROP.name = "PlayerProp"
PLAYERPROP.full_name = ".sgland.PlayerProp"
PLAYERPROP.nested_types = {}
PLAYERPROP.enum_types = {}
PLAYERPROP.fields = {
	var_0_51.PROPS_FIELD,
	var_0_51.CHESTS_FIELD,
	var_0_51.MARKS_FIELD,
	var_0_51.CROWNS_FIELD,
	var_0_51.LEGEND_CROWNS_FIELD,
	var_0_51.CUR_LEGEND_CROWN_FIELD,
	var_0_51.LAST_LEGEND_CROWN_TIMESTAMP_FIELD
}
PLAYERPROP.is_extendable = false
PLAYERPROP.extensions = {}
var_0_52.BUNDLE_ID_FIELD.name = "bundle_id"
var_0_52.BUNDLE_ID_FIELD.full_name = ".sgland.BundleLimit.bundle_id"
var_0_52.BUNDLE_ID_FIELD.number = 1
var_0_52.BUNDLE_ID_FIELD.index = 0
var_0_52.BUNDLE_ID_FIELD.label = 2
var_0_52.BUNDLE_ID_FIELD.has_default_value = false
var_0_52.BUNDLE_ID_FIELD.default_value = 0
var_0_52.BUNDLE_ID_FIELD.type = 5
var_0_52.BUNDLE_ID_FIELD.cpp_type = 1
var_0_52.LIMIT_FIELD.name = "limit"
var_0_52.LIMIT_FIELD.full_name = ".sgland.BundleLimit.limit"
var_0_52.LIMIT_FIELD.number = 2
var_0_52.LIMIT_FIELD.index = 1
var_0_52.LIMIT_FIELD.label = 2
var_0_52.LIMIT_FIELD.has_default_value = false
var_0_52.LIMIT_FIELD.default_value = 0
var_0_52.LIMIT_FIELD.type = 5
var_0_52.LIMIT_FIELD.cpp_type = 1
BUNDLELIMIT.name = "BundleLimit"
BUNDLELIMIT.full_name = ".sgland.BundleLimit"
BUNDLELIMIT.nested_types = {}
BUNDLELIMIT.enum_types = {}
BUNDLELIMIT.fields = {
	var_0_52.BUNDLE_ID_FIELD,
	var_0_52.LIMIT_FIELD
}
BUNDLELIMIT.is_extendable = false
BUNDLELIMIT.extensions = {}
var_0_53.NEXT_REFRESH_FIELD.name = "next_refresh"
var_0_53.NEXT_REFRESH_FIELD.full_name = ".sgland.PlayerShop.next_refresh"
var_0_53.NEXT_REFRESH_FIELD.number = 2
var_0_53.NEXT_REFRESH_FIELD.index = 0
var_0_53.NEXT_REFRESH_FIELD.label = 2
var_0_53.NEXT_REFRESH_FIELD.has_default_value = false
var_0_53.NEXT_REFRESH_FIELD.default_value = 0
var_0_53.NEXT_REFRESH_FIELD.type = 3
var_0_53.NEXT_REFRESH_FIELD.cpp_type = 2
var_0_53.BUNDLES_FIELD.name = "bundles"
var_0_53.BUNDLES_FIELD.full_name = ".sgland.PlayerShop.bundles"
var_0_53.BUNDLES_FIELD.number = 3
var_0_53.BUNDLES_FIELD.index = 1
var_0_53.BUNDLES_FIELD.label = 3
var_0_53.BUNDLES_FIELD.has_default_value = false
var_0_53.BUNDLES_FIELD.default_value = {}
var_0_53.BUNDLES_FIELD.message_type = BUNDLE
var_0_53.BUNDLES_FIELD.type = 11
var_0_53.BUNDLES_FIELD.cpp_type = 10
var_0_53.PVP_BUNDLES_FIELD.name = "pvp_bundles"
var_0_53.PVP_BUNDLES_FIELD.full_name = ".sgland.PlayerShop.pvp_bundles"
var_0_53.PVP_BUNDLES_FIELD.number = 4
var_0_53.PVP_BUNDLES_FIELD.index = 2
var_0_53.PVP_BUNDLES_FIELD.label = 3
var_0_53.PVP_BUNDLES_FIELD.has_default_value = false
var_0_53.PVP_BUNDLES_FIELD.default_value = {}
var_0_53.PVP_BUNDLES_FIELD.message_type = BUNDLE
var_0_53.PVP_BUNDLES_FIELD.type = 11
var_0_53.PVP_BUNDLES_FIELD.cpp_type = 10
var_0_53.LAST_OPEN_FIELD.name = "last_open"
var_0_53.LAST_OPEN_FIELD.full_name = ".sgland.PlayerShop.last_open"
var_0_53.LAST_OPEN_FIELD.number = 5
var_0_53.LAST_OPEN_FIELD.index = 3
var_0_53.LAST_OPEN_FIELD.label = 1
var_0_53.LAST_OPEN_FIELD.has_default_value = false
var_0_53.LAST_OPEN_FIELD.default_value = 0
var_0_53.LAST_OPEN_FIELD.type = 3
var_0_53.LAST_OPEN_FIELD.cpp_type = 2
var_0_53.MYST_BUNDLES_FIELD.name = "myst_bundles"
var_0_53.MYST_BUNDLES_FIELD.full_name = ".sgland.PlayerShop.myst_bundles"
var_0_53.MYST_BUNDLES_FIELD.number = 6
var_0_53.MYST_BUNDLES_FIELD.index = 4
var_0_53.MYST_BUNDLES_FIELD.label = 3
var_0_53.MYST_BUNDLES_FIELD.has_default_value = false
var_0_53.MYST_BUNDLES_FIELD.default_value = {}
var_0_53.MYST_BUNDLES_FIELD.message_type = BUNDLEEX
var_0_53.MYST_BUNDLES_FIELD.type = 11
var_0_53.MYST_BUNDLES_FIELD.cpp_type = 10
var_0_53.LADDER_BUNDLES_FIELD.name = "ladder_bundles"
var_0_53.LADDER_BUNDLES_FIELD.full_name = ".sgland.PlayerShop.ladder_bundles"
var_0_53.LADDER_BUNDLES_FIELD.number = 7
var_0_53.LADDER_BUNDLES_FIELD.index = 5
var_0_53.LADDER_BUNDLES_FIELD.label = 3
var_0_53.LADDER_BUNDLES_FIELD.has_default_value = false
var_0_53.LADDER_BUNDLES_FIELD.default_value = {}
var_0_53.LADDER_BUNDLES_FIELD.message_type = BUNDLE
var_0_53.LADDER_BUNDLES_FIELD.type = 11
var_0_53.LADDER_BUNDLES_FIELD.cpp_type = 10
var_0_53.GIFTS_FIELD.name = "gifts"
var_0_53.GIFTS_FIELD.full_name = ".sgland.PlayerShop.gifts"
var_0_53.GIFTS_FIELD.number = 8
var_0_53.GIFTS_FIELD.index = 6
var_0_53.GIFTS_FIELD.label = 3
var_0_53.GIFTS_FIELD.has_default_value = false
var_0_53.GIFTS_FIELD.default_value = {}
var_0_53.GIFTS_FIELD.message_type = RESOURCE
var_0_53.GIFTS_FIELD.type = 11
var_0_53.GIFTS_FIELD.cpp_type = 10
var_0_53.LAST_GIFT_FIELD.name = "last_gift"
var_0_53.LAST_GIFT_FIELD.full_name = ".sgland.PlayerShop.last_gift"
var_0_53.LAST_GIFT_FIELD.number = 9
var_0_53.LAST_GIFT_FIELD.index = 7
var_0_53.LAST_GIFT_FIELD.label = 1
var_0_53.LAST_GIFT_FIELD.has_default_value = false
var_0_53.LAST_GIFT_FIELD.default_value = 0
var_0_53.LAST_GIFT_FIELD.type = 3
var_0_53.LAST_GIFT_FIELD.cpp_type = 2
var_0_53.RARE_BUNDLES_FIELD.name = "rare_bundles"
var_0_53.RARE_BUNDLES_FIELD.full_name = ".sgland.PlayerShop.rare_bundles"
var_0_53.RARE_BUNDLES_FIELD.number = 10
var_0_53.RARE_BUNDLES_FIELD.index = 8
var_0_53.RARE_BUNDLES_FIELD.label = 3
var_0_53.RARE_BUNDLES_FIELD.has_default_value = false
var_0_53.RARE_BUNDLES_FIELD.default_value = {}
var_0_53.RARE_BUNDLES_FIELD.type = 5
var_0_53.RARE_BUNDLES_FIELD.cpp_type = 1
var_0_53.LEGEND_BUNDLES_FIELD.name = "legend_bundles"
var_0_53.LEGEND_BUNDLES_FIELD.full_name = ".sgland.PlayerShop.legend_bundles"
var_0_53.LEGEND_BUNDLES_FIELD.number = 11
var_0_53.LEGEND_BUNDLES_FIELD.index = 9
var_0_53.LEGEND_BUNDLES_FIELD.label = 3
var_0_53.LEGEND_BUNDLES_FIELD.has_default_value = false
var_0_53.LEGEND_BUNDLES_FIELD.default_value = {}
var_0_53.LEGEND_BUNDLES_FIELD.type = 5
var_0_53.LEGEND_BUNDLES_FIELD.cpp_type = 1
var_0_53.EXCHANGE_PROP_LIMIT_FIELD.name = "exchange_prop_limit"
var_0_53.EXCHANGE_PROP_LIMIT_FIELD.full_name = ".sgland.PlayerShop.exchange_prop_limit"
var_0_53.EXCHANGE_PROP_LIMIT_FIELD.number = 12
var_0_53.EXCHANGE_PROP_LIMIT_FIELD.index = 10
var_0_53.EXCHANGE_PROP_LIMIT_FIELD.label = 3
var_0_53.EXCHANGE_PROP_LIMIT_FIELD.has_default_value = false
var_0_53.EXCHANGE_PROP_LIMIT_FIELD.default_value = {}
var_0_53.EXCHANGE_PROP_LIMIT_FIELD.message_type = BUNDLELIMIT
var_0_53.EXCHANGE_PROP_LIMIT_FIELD.type = 11
var_0_53.EXCHANGE_PROP_LIMIT_FIELD.cpp_type = 10
var_0_53.RECYCLE_CARD_LIMIT_FIELD.name = "recycle_card_limit"
var_0_53.RECYCLE_CARD_LIMIT_FIELD.full_name = ".sgland.PlayerShop.recycle_card_limit"
var_0_53.RECYCLE_CARD_LIMIT_FIELD.number = 13
var_0_53.RECYCLE_CARD_LIMIT_FIELD.index = 11
var_0_53.RECYCLE_CARD_LIMIT_FIELD.label = 3
var_0_53.RECYCLE_CARD_LIMIT_FIELD.has_default_value = false
var_0_53.RECYCLE_CARD_LIMIT_FIELD.default_value = {}
var_0_53.RECYCLE_CARD_LIMIT_FIELD.message_type = BUNDLELIMIT
var_0_53.RECYCLE_CARD_LIMIT_FIELD.type = 11
var_0_53.RECYCLE_CARD_LIMIT_FIELD.cpp_type = 10
var_0_53.RUBBING_LIMIT_FIELD.name = "rubbing_limit"
var_0_53.RUBBING_LIMIT_FIELD.full_name = ".sgland.PlayerShop.rubbing_limit"
var_0_53.RUBBING_LIMIT_FIELD.number = 14
var_0_53.RUBBING_LIMIT_FIELD.index = 12
var_0_53.RUBBING_LIMIT_FIELD.label = 3
var_0_53.RUBBING_LIMIT_FIELD.has_default_value = false
var_0_53.RUBBING_LIMIT_FIELD.default_value = {}
var_0_53.RUBBING_LIMIT_FIELD.message_type = BUNDLELIMIT
var_0_53.RUBBING_LIMIT_FIELD.type = 11
var_0_53.RUBBING_LIMIT_FIELD.cpp_type = 10
var_0_53.BADGE_BUNDLES_FIELD.name = "badge_bundles"
var_0_53.BADGE_BUNDLES_FIELD.full_name = ".sgland.PlayerShop.badge_bundles"
var_0_53.BADGE_BUNDLES_FIELD.number = 15
var_0_53.BADGE_BUNDLES_FIELD.index = 13
var_0_53.BADGE_BUNDLES_FIELD.label = 3
var_0_53.BADGE_BUNDLES_FIELD.has_default_value = false
var_0_53.BADGE_BUNDLES_FIELD.default_value = {}
var_0_53.BADGE_BUNDLES_FIELD.type = 5
var_0_53.BADGE_BUNDLES_FIELD.cpp_type = 1
PLAYERSHOP.name = "PlayerShop"
PLAYERSHOP.full_name = ".sgland.PlayerShop"
PLAYERSHOP.nested_types = {}
PLAYERSHOP.enum_types = {}
PLAYERSHOP.fields = {
	var_0_53.NEXT_REFRESH_FIELD,
	var_0_53.BUNDLES_FIELD,
	var_0_53.PVP_BUNDLES_FIELD,
	var_0_53.LAST_OPEN_FIELD,
	var_0_53.MYST_BUNDLES_FIELD,
	var_0_53.LADDER_BUNDLES_FIELD,
	var_0_53.GIFTS_FIELD,
	var_0_53.LAST_GIFT_FIELD,
	var_0_53.RARE_BUNDLES_FIELD,
	var_0_53.LEGEND_BUNDLES_FIELD,
	var_0_53.EXCHANGE_PROP_LIMIT_FIELD,
	var_0_53.RECYCLE_CARD_LIMIT_FIELD,
	var_0_53.RUBBING_LIMIT_FIELD,
	var_0_53.BADGE_BUNDLES_FIELD
}
PLAYERSHOP.is_extendable = false
PLAYERSHOP.extensions = {}
var_0_54.CHAPTER_FIELD.name = "chapter"
var_0_54.CHAPTER_FIELD.full_name = ".sgland.PlayerExpedition.chapter"
var_0_54.CHAPTER_FIELD.number = 1
var_0_54.CHAPTER_FIELD.index = 0
var_0_54.CHAPTER_FIELD.label = 2
var_0_54.CHAPTER_FIELD.has_default_value = false
var_0_54.CHAPTER_FIELD.default_value = 0
var_0_54.CHAPTER_FIELD.type = 5
var_0_54.CHAPTER_FIELD.cpp_type = 1
var_0_54.CHESTS_FIELD.name = "chests"
var_0_54.CHESTS_FIELD.full_name = ".sgland.PlayerExpedition.chests"
var_0_54.CHESTS_FIELD.number = 2
var_0_54.CHESTS_FIELD.index = 1
var_0_54.CHESTS_FIELD.label = 3
var_0_54.CHESTS_FIELD.has_default_value = false
var_0_54.CHESTS_FIELD.default_value = {}
var_0_54.CHESTS_FIELD.message_type = CHEST
var_0_54.CHESTS_FIELD.type = 11
var_0_54.CHESTS_FIELD.cpp_type = 10
var_0_54.TROOPS_FIELD.name = "troops"
var_0_54.TROOPS_FIELD.full_name = ".sgland.PlayerExpedition.troops"
var_0_54.TROOPS_FIELD.number = 3
var_0_54.TROOPS_FIELD.index = 2
var_0_54.TROOPS_FIELD.label = 3
var_0_54.TROOPS_FIELD.has_default_value = false
var_0_54.TROOPS_FIELD.default_value = {}
var_0_54.TROOPS_FIELD.message_type = TROOPDATA
var_0_54.TROOPS_FIELD.type = 11
var_0_54.TROOPS_FIELD.cpp_type = 10
var_0_54.SWEEP_CHAPTER_FIELD.name = "sweep_chapter"
var_0_54.SWEEP_CHAPTER_FIELD.full_name = ".sgland.PlayerExpedition.sweep_chapter"
var_0_54.SWEEP_CHAPTER_FIELD.number = 4
var_0_54.SWEEP_CHAPTER_FIELD.index = 3
var_0_54.SWEEP_CHAPTER_FIELD.label = 1
var_0_54.SWEEP_CHAPTER_FIELD.has_default_value = false
var_0_54.SWEEP_CHAPTER_FIELD.default_value = 0
var_0_54.SWEEP_CHAPTER_FIELD.type = 5
var_0_54.SWEEP_CHAPTER_FIELD.cpp_type = 1
var_0_54.RECOVER_COUNT_FIELD.name = "recover_count"
var_0_54.RECOVER_COUNT_FIELD.full_name = ".sgland.PlayerExpedition.recover_count"
var_0_54.RECOVER_COUNT_FIELD.number = 5
var_0_54.RECOVER_COUNT_FIELD.index = 4
var_0_54.RECOVER_COUNT_FIELD.label = 1
var_0_54.RECOVER_COUNT_FIELD.has_default_value = false
var_0_54.RECOVER_COUNT_FIELD.default_value = 0
var_0_54.RECOVER_COUNT_FIELD.type = 5
var_0_54.RECOVER_COUNT_FIELD.cpp_type = 1
PLAYEREXPEDITION.name = "PlayerExpedition"
PLAYEREXPEDITION.full_name = ".sgland.PlayerExpedition"
PLAYEREXPEDITION.nested_types = {}
PLAYEREXPEDITION.enum_types = {}
PLAYEREXPEDITION.fields = {
	var_0_54.CHAPTER_FIELD,
	var_0_54.CHESTS_FIELD,
	var_0_54.TROOPS_FIELD,
	var_0_54.SWEEP_CHAPTER_FIELD,
	var_0_54.RECOVER_COUNT_FIELD
}
PLAYEREXPEDITION.is_extendable = false
PLAYEREXPEDITION.extensions = {}
var_0_55.TROOP_DATA_FIELD.name = "troop_data"
var_0_55.TROOP_DATA_FIELD.full_name = ".sgland.ExpeditionExNPC.troop_data"
var_0_55.TROOP_DATA_FIELD.number = 1
var_0_55.TROOP_DATA_FIELD.index = 0
var_0_55.TROOP_DATA_FIELD.label = 2
var_0_55.TROOP_DATA_FIELD.has_default_value = false
var_0_55.TROOP_DATA_FIELD.default_value = nil
var_0_55.TROOP_DATA_FIELD.message_type = TROOPDATA
var_0_55.TROOP_DATA_FIELD.type = 11
var_0_55.TROOP_DATA_FIELD.cpp_type = 10
var_0_55.LEVEL_FIELD.name = "level"
var_0_55.LEVEL_FIELD.full_name = ".sgland.ExpeditionExNPC.level"
var_0_55.LEVEL_FIELD.number = 2
var_0_55.LEVEL_FIELD.index = 1
var_0_55.LEVEL_FIELD.label = 2
var_0_55.LEVEL_FIELD.has_default_value = false
var_0_55.LEVEL_FIELD.default_value = 0
var_0_55.LEVEL_FIELD.type = 5
var_0_55.LEVEL_FIELD.cpp_type = 1
var_0_55.RANDOM_POSITION_FIELD.name = "random_position"
var_0_55.RANDOM_POSITION_FIELD.full_name = ".sgland.ExpeditionExNPC.random_position"
var_0_55.RANDOM_POSITION_FIELD.number = 3
var_0_55.RANDOM_POSITION_FIELD.index = 2
var_0_55.RANDOM_POSITION_FIELD.label = 2
var_0_55.RANDOM_POSITION_FIELD.has_default_value = false
var_0_55.RANDOM_POSITION_FIELD.default_value = 0
var_0_55.RANDOM_POSITION_FIELD.type = 5
var_0_55.RANDOM_POSITION_FIELD.cpp_type = 1
var_0_55.NEXT_REFRESH_FIELD.name = "next_refresh"
var_0_55.NEXT_REFRESH_FIELD.full_name = ".sgland.ExpeditionExNPC.next_refresh"
var_0_55.NEXT_REFRESH_FIELD.number = 4
var_0_55.NEXT_REFRESH_FIELD.index = 3
var_0_55.NEXT_REFRESH_FIELD.label = 1
var_0_55.NEXT_REFRESH_FIELD.has_default_value = false
var_0_55.NEXT_REFRESH_FIELD.default_value = 0
var_0_55.NEXT_REFRESH_FIELD.type = 3
var_0_55.NEXT_REFRESH_FIELD.cpp_type = 2
var_0_55.CHANLLENGE_COUNT_FIELD.name = "chanllenge_count"
var_0_55.CHANLLENGE_COUNT_FIELD.full_name = ".sgland.ExpeditionExNPC.chanllenge_count"
var_0_55.CHANLLENGE_COUNT_FIELD.number = 5
var_0_55.CHANLLENGE_COUNT_FIELD.index = 4
var_0_55.CHANLLENGE_COUNT_FIELD.label = 1
var_0_55.CHANLLENGE_COUNT_FIELD.has_default_value = false
var_0_55.CHANLLENGE_COUNT_FIELD.default_value = 0
var_0_55.CHANLLENGE_COUNT_FIELD.type = 5
var_0_55.CHANLLENGE_COUNT_FIELD.cpp_type = 1
EXPEDITIONEXNPC.name = "ExpeditionExNPC"
EXPEDITIONEXNPC.full_name = ".sgland.ExpeditionExNPC"
EXPEDITIONEXNPC.nested_types = {}
EXPEDITIONEXNPC.enum_types = {}
EXPEDITIONEXNPC.fields = {
	var_0_55.TROOP_DATA_FIELD,
	var_0_55.LEVEL_FIELD,
	var_0_55.RANDOM_POSITION_FIELD,
	var_0_55.NEXT_REFRESH_FIELD,
	var_0_55.CHANLLENGE_COUNT_FIELD
}
EXPEDITIONEXNPC.is_extendable = false
EXPEDITIONEXNPC.extensions = {}
var_0_56.BOSS_FIELD.name = "boss"
var_0_56.BOSS_FIELD.full_name = ".sgland.ExpeditionExBoss.boss"
var_0_56.BOSS_FIELD.number = 1
var_0_56.BOSS_FIELD.index = 0
var_0_56.BOSS_FIELD.label = 2
var_0_56.BOSS_FIELD.has_default_value = false
var_0_56.BOSS_FIELD.default_value = nil
var_0_56.BOSS_FIELD.message_type = TROOPDATA
var_0_56.BOSS_FIELD.type = 11
var_0_56.BOSS_FIELD.cpp_type = 10
var_0_56.CHANLLENGE_COUNT_FIELD.name = "chanllenge_count"
var_0_56.CHANLLENGE_COUNT_FIELD.full_name = ".sgland.ExpeditionExBoss.chanllenge_count"
var_0_56.CHANLLENGE_COUNT_FIELD.number = 2
var_0_56.CHANLLENGE_COUNT_FIELD.index = 1
var_0_56.CHANLLENGE_COUNT_FIELD.label = 2
var_0_56.CHANLLENGE_COUNT_FIELD.has_default_value = false
var_0_56.CHANLLENGE_COUNT_FIELD.default_value = 0
var_0_56.CHANLLENGE_COUNT_FIELD.type = 5
var_0_56.CHANLLENGE_COUNT_FIELD.cpp_type = 1
var_0_56.RANDOM_POSITION_FIELD.name = "random_position"
var_0_56.RANDOM_POSITION_FIELD.full_name = ".sgland.ExpeditionExBoss.random_position"
var_0_56.RANDOM_POSITION_FIELD.number = 3
var_0_56.RANDOM_POSITION_FIELD.index = 2
var_0_56.RANDOM_POSITION_FIELD.label = 2
var_0_56.RANDOM_POSITION_FIELD.has_default_value = false
var_0_56.RANDOM_POSITION_FIELD.default_value = 0
var_0_56.RANDOM_POSITION_FIELD.type = 5
var_0_56.RANDOM_POSITION_FIELD.cpp_type = 1
var_0_56.NEXT_REFRESH_FIELD.name = "next_refresh"
var_0_56.NEXT_REFRESH_FIELD.full_name = ".sgland.ExpeditionExBoss.next_refresh"
var_0_56.NEXT_REFRESH_FIELD.number = 4
var_0_56.NEXT_REFRESH_FIELD.index = 3
var_0_56.NEXT_REFRESH_FIELD.label = 1
var_0_56.NEXT_REFRESH_FIELD.has_default_value = false
var_0_56.NEXT_REFRESH_FIELD.default_value = 0
var_0_56.NEXT_REFRESH_FIELD.type = 3
var_0_56.NEXT_REFRESH_FIELD.cpp_type = 2
EXPEDITIONEXBOSS.name = "ExpeditionExBoss"
EXPEDITIONEXBOSS.full_name = ".sgland.ExpeditionExBoss"
EXPEDITIONEXBOSS.nested_types = {}
EXPEDITIONEXBOSS.enum_types = {}
EXPEDITIONEXBOSS.fields = {
	var_0_56.BOSS_FIELD,
	var_0_56.CHANLLENGE_COUNT_FIELD,
	var_0_56.RANDOM_POSITION_FIELD,
	var_0_56.NEXT_REFRESH_FIELD
}
EXPEDITIONEXBOSS.is_extendable = false
EXPEDITIONEXBOSS.extensions = {}
var_0_57.LAST_NPC_UPDATE_TIME_FIELD.name = "last_npc_update_time"
var_0_57.LAST_NPC_UPDATE_TIME_FIELD.full_name = ".sgland.PlayerExpeditionEx.last_npc_update_time"
var_0_57.LAST_NPC_UPDATE_TIME_FIELD.number = 1
var_0_57.LAST_NPC_UPDATE_TIME_FIELD.index = 0
var_0_57.LAST_NPC_UPDATE_TIME_FIELD.label = 1
var_0_57.LAST_NPC_UPDATE_TIME_FIELD.has_default_value = false
var_0_57.LAST_NPC_UPDATE_TIME_FIELD.default_value = 0
var_0_57.LAST_NPC_UPDATE_TIME_FIELD.type = 3
var_0_57.LAST_NPC_UPDATE_TIME_FIELD.cpp_type = 2
var_0_57.LAST_BOSS_UPDATE_TIME_FIELD.name = "last_boss_update_time"
var_0_57.LAST_BOSS_UPDATE_TIME_FIELD.full_name = ".sgland.PlayerExpeditionEx.last_boss_update_time"
var_0_57.LAST_BOSS_UPDATE_TIME_FIELD.number = 2
var_0_57.LAST_BOSS_UPDATE_TIME_FIELD.index = 1
var_0_57.LAST_BOSS_UPDATE_TIME_FIELD.label = 1
var_0_57.LAST_BOSS_UPDATE_TIME_FIELD.has_default_value = false
var_0_57.LAST_BOSS_UPDATE_TIME_FIELD.default_value = 0
var_0_57.LAST_BOSS_UPDATE_TIME_FIELD.type = 3
var_0_57.LAST_BOSS_UPDATE_TIME_FIELD.cpp_type = 2
var_0_57.LAST_LOTTERY_POWER_UPDATE_TIME_FIELD.name = "last_lottery_power_update_time"
var_0_57.LAST_LOTTERY_POWER_UPDATE_TIME_FIELD.full_name = ".sgland.PlayerExpeditionEx.last_lottery_power_update_time"
var_0_57.LAST_LOTTERY_POWER_UPDATE_TIME_FIELD.number = 3
var_0_57.LAST_LOTTERY_POWER_UPDATE_TIME_FIELD.index = 2
var_0_57.LAST_LOTTERY_POWER_UPDATE_TIME_FIELD.label = 1
var_0_57.LAST_LOTTERY_POWER_UPDATE_TIME_FIELD.has_default_value = false
var_0_57.LAST_LOTTERY_POWER_UPDATE_TIME_FIELD.default_value = 0
var_0_57.LAST_LOTTERY_POWER_UPDATE_TIME_FIELD.type = 3
var_0_57.LAST_LOTTERY_POWER_UPDATE_TIME_FIELD.cpp_type = 2
var_0_57.TROOPS_FIELD.name = "troops"
var_0_57.TROOPS_FIELD.full_name = ".sgland.PlayerExpeditionEx.troops"
var_0_57.TROOPS_FIELD.number = 4
var_0_57.TROOPS_FIELD.index = 3
var_0_57.TROOPS_FIELD.label = 3
var_0_57.TROOPS_FIELD.has_default_value = false
var_0_57.TROOPS_FIELD.default_value = {}
var_0_57.TROOPS_FIELD.message_type = EXPEDITIONEXNPC
var_0_57.TROOPS_FIELD.type = 11
var_0_57.TROOPS_FIELD.cpp_type = 10
var_0_57.BOSS_FIELD.name = "boss"
var_0_57.BOSS_FIELD.full_name = ".sgland.PlayerExpeditionEx.boss"
var_0_57.BOSS_FIELD.number = 5
var_0_57.BOSS_FIELD.index = 4
var_0_57.BOSS_FIELD.label = 1
var_0_57.BOSS_FIELD.has_default_value = false
var_0_57.BOSS_FIELD.default_value = nil
var_0_57.BOSS_FIELD.message_type = EXPEDITIONEXBOSS
var_0_57.BOSS_FIELD.type = 11
var_0_57.BOSS_FIELD.cpp_type = 10
var_0_57.LOTTERY_POWER_FIELD.name = "lottery_power"
var_0_57.LOTTERY_POWER_FIELD.full_name = ".sgland.PlayerExpeditionEx.lottery_power"
var_0_57.LOTTERY_POWER_FIELD.number = 6
var_0_57.LOTTERY_POWER_FIELD.index = 5
var_0_57.LOTTERY_POWER_FIELD.label = 2
var_0_57.LOTTERY_POWER_FIELD.has_default_value = false
var_0_57.LOTTERY_POWER_FIELD.default_value = 0
var_0_57.LOTTERY_POWER_FIELD.type = 5
var_0_57.LOTTERY_POWER_FIELD.cpp_type = 1
var_0_57.NEXT_REFRESH_FIELD.name = "next_refresh"
var_0_57.NEXT_REFRESH_FIELD.full_name = ".sgland.PlayerExpeditionEx.next_refresh"
var_0_57.NEXT_REFRESH_FIELD.number = 7
var_0_57.NEXT_REFRESH_FIELD.index = 6
var_0_57.NEXT_REFRESH_FIELD.label = 1
var_0_57.NEXT_REFRESH_FIELD.has_default_value = false
var_0_57.NEXT_REFRESH_FIELD.default_value = 0
var_0_57.NEXT_REFRESH_FIELD.type = 3
var_0_57.NEXT_REFRESH_FIELD.cpp_type = 2
var_0_57.CUR_NPC_FIELD.name = "cur_npc"
var_0_57.CUR_NPC_FIELD.full_name = ".sgland.PlayerExpeditionEx.cur_npc"
var_0_57.CUR_NPC_FIELD.number = 8
var_0_57.CUR_NPC_FIELD.index = 7
var_0_57.CUR_NPC_FIELD.label = 1
var_0_57.CUR_NPC_FIELD.has_default_value = false
var_0_57.CUR_NPC_FIELD.default_value = 0
var_0_57.CUR_NPC_FIELD.type = 5
var_0_57.CUR_NPC_FIELD.cpp_type = 1
PLAYEREXPEDITIONEX.name = "PlayerExpeditionEx"
PLAYEREXPEDITIONEX.full_name = ".sgland.PlayerExpeditionEx"
PLAYEREXPEDITIONEX.nested_types = {}
PLAYEREXPEDITIONEX.enum_types = {}
PLAYEREXPEDITIONEX.fields = {
	var_0_57.LAST_NPC_UPDATE_TIME_FIELD,
	var_0_57.LAST_BOSS_UPDATE_TIME_FIELD,
	var_0_57.LAST_LOTTERY_POWER_UPDATE_TIME_FIELD,
	var_0_57.TROOPS_FIELD,
	var_0_57.BOSS_FIELD,
	var_0_57.LOTTERY_POWER_FIELD,
	var_0_57.NEXT_REFRESH_FIELD,
	var_0_57.CUR_NPC_FIELD
}
PLAYEREXPEDITIONEX.is_extendable = false
PLAYEREXPEDITIONEX.extensions = {}
var_0_58.ID_FIELD.name = "id"
var_0_58.ID_FIELD.full_name = ".sgland.TeamInfo.id"
var_0_58.ID_FIELD.number = 1
var_0_58.ID_FIELD.index = 0
var_0_58.ID_FIELD.label = 2
var_0_58.ID_FIELD.has_default_value = false
var_0_58.ID_FIELD.default_value = 0
var_0_58.ID_FIELD.type = 3
var_0_58.ID_FIELD.cpp_type = 2
var_0_58.SCORE_FIELD.name = "score"
var_0_58.SCORE_FIELD.full_name = ".sgland.TeamInfo.score"
var_0_58.SCORE_FIELD.number = 2
var_0_58.SCORE_FIELD.index = 1
var_0_58.SCORE_FIELD.label = 2
var_0_58.SCORE_FIELD.has_default_value = false
var_0_58.SCORE_FIELD.default_value = 0
var_0_58.SCORE_FIELD.type = 5
var_0_58.SCORE_FIELD.cpp_type = 1
var_0_58.SCORE_UPDATE_TIME_FIELD.name = "score_update_time"
var_0_58.SCORE_UPDATE_TIME_FIELD.full_name = ".sgland.TeamInfo.score_update_time"
var_0_58.SCORE_UPDATE_TIME_FIELD.number = 3
var_0_58.SCORE_UPDATE_TIME_FIELD.index = 2
var_0_58.SCORE_UPDATE_TIME_FIELD.label = 2
var_0_58.SCORE_UPDATE_TIME_FIELD.has_default_value = false
var_0_58.SCORE_UPDATE_TIME_FIELD.default_value = 0
var_0_58.SCORE_UPDATE_TIME_FIELD.type = 3
var_0_58.SCORE_UPDATE_TIME_FIELD.cpp_type = 2
TEAMINFO.name = "TeamInfo"
TEAMINFO.full_name = ".sgland.TeamInfo"
TEAMINFO.nested_types = {}
TEAMINFO.enum_types = {}
TEAMINFO.fields = {
	var_0_58.ID_FIELD,
	var_0_58.SCORE_FIELD,
	var_0_58.SCORE_UPDATE_TIME_FIELD
}
TEAMINFO.is_extendable = false
TEAMINFO.extensions = {}
var_0_59.NEXT_REFRESH_FIELD.name = "next_refresh"
var_0_59.NEXT_REFRESH_FIELD.full_name = ".sgland.PlayerUnion.next_refresh"
var_0_59.NEXT_REFRESH_FIELD.number = 1
var_0_59.NEXT_REFRESH_FIELD.index = 0
var_0_59.NEXT_REFRESH_FIELD.label = 2
var_0_59.NEXT_REFRESH_FIELD.has_default_value = false
var_0_59.NEXT_REFRESH_FIELD.default_value = 0
var_0_59.NEXT_REFRESH_FIELD.type = 3
var_0_59.NEXT_REFRESH_FIELD.cpp_type = 2
var_0_59.BUNDLES_FIELD.name = "bundles"
var_0_59.BUNDLES_FIELD.full_name = ".sgland.PlayerUnion.bundles"
var_0_59.BUNDLES_FIELD.number = 2
var_0_59.BUNDLES_FIELD.index = 1
var_0_59.BUNDLES_FIELD.label = 3
var_0_59.BUNDLES_FIELD.has_default_value = false
var_0_59.BUNDLES_FIELD.default_value = {}
var_0_59.BUNDLES_FIELD.message_type = BUNDLE
var_0_59.BUNDLES_FIELD.type = 11
var_0_59.BUNDLES_FIELD.cpp_type = 10
var_0_59.CARDS_FIELD.name = "cards"
var_0_59.CARDS_FIELD.full_name = ".sgland.PlayerUnion.cards"
var_0_59.CARDS_FIELD.number = 4
var_0_59.CARDS_FIELD.index = 2
var_0_59.CARDS_FIELD.label = 3
var_0_59.CARDS_FIELD.has_default_value = false
var_0_59.CARDS_FIELD.default_value = {}
var_0_59.CARDS_FIELD.message_type = RESOURCE
var_0_59.CARDS_FIELD.type = 11
var_0_59.CARDS_FIELD.cpp_type = 10
var_0_59.LAST_RENT_FIELD.name = "last_rent"
var_0_59.LAST_RENT_FIELD.full_name = ".sgland.PlayerUnion.last_rent"
var_0_59.LAST_RENT_FIELD.number = 5
var_0_59.LAST_RENT_FIELD.index = 3
var_0_59.LAST_RENT_FIELD.label = 1
var_0_59.LAST_RENT_FIELD.has_default_value = false
var_0_59.LAST_RENT_FIELD.default_value = 0
var_0_59.LAST_RENT_FIELD.type = 3
var_0_59.LAST_RENT_FIELD.cpp_type = 2
var_0_59.RENTED_FIELD.name = "rented"
var_0_59.RENTED_FIELD.full_name = ".sgland.PlayerUnion.rented"
var_0_59.RENTED_FIELD.number = 6
var_0_59.RENTED_FIELD.index = 4
var_0_59.RENTED_FIELD.label = 3
var_0_59.RENTED_FIELD.has_default_value = false
var_0_59.RENTED_FIELD.default_value = {}
var_0_59.RENTED_FIELD.type = 3
var_0_59.RENTED_FIELD.cpp_type = 2
var_0_59.BONUSES_FIELD.name = "bonuses"
var_0_59.BONUSES_FIELD.full_name = ".sgland.PlayerUnion.bonuses"
var_0_59.BONUSES_FIELD.number = 7
var_0_59.BONUSES_FIELD.index = 5
var_0_59.BONUSES_FIELD.label = 3
var_0_59.BONUSES_FIELD.has_default_value = false
var_0_59.BONUSES_FIELD.default_value = {}
var_0_59.BONUSES_FIELD.message_type = RESOURCE
var_0_59.BONUSES_FIELD.type = 11
var_0_59.BONUSES_FIELD.cpp_type = 10
var_0_59.TECHS_FIELD.name = "techs"
var_0_59.TECHS_FIELD.full_name = ".sgland.PlayerUnion.techs"
var_0_59.TECHS_FIELD.number = 8
var_0_59.TECHS_FIELD.index = 6
var_0_59.TECHS_FIELD.label = 3
var_0_59.TECHS_FIELD.has_default_value = false
var_0_59.TECHS_FIELD.default_value = {}
var_0_59.TECHS_FIELD.message_type = TECH
var_0_59.TECHS_FIELD.type = 11
var_0_59.TECHS_FIELD.cpp_type = 10
var_0_59.TEAM_INFO_FIELD.name = "team_info"
var_0_59.TEAM_INFO_FIELD.full_name = ".sgland.PlayerUnion.team_info"
var_0_59.TEAM_INFO_FIELD.number = 9
var_0_59.TEAM_INFO_FIELD.index = 7
var_0_59.TEAM_INFO_FIELD.label = 1
var_0_59.TEAM_INFO_FIELD.has_default_value = false
var_0_59.TEAM_INFO_FIELD.default_value = nil
var_0_59.TEAM_INFO_FIELD.message_type = TEAMINFO
var_0_59.TEAM_INFO_FIELD.type = 11
var_0_59.TEAM_INFO_FIELD.cpp_type = 10
PLAYERUNION.name = "PlayerUnion"
PLAYERUNION.full_name = ".sgland.PlayerUnion"
PLAYERUNION.nested_types = {}
PLAYERUNION.enum_types = {}
PLAYERUNION.fields = {
	var_0_59.NEXT_REFRESH_FIELD,
	var_0_59.BUNDLES_FIELD,
	var_0_59.CARDS_FIELD,
	var_0_59.LAST_RENT_FIELD,
	var_0_59.RENTED_FIELD,
	var_0_59.BONUSES_FIELD,
	var_0_59.TECHS_FIELD,
	var_0_59.TEAM_INFO_FIELD
}
PLAYERUNION.is_extendable = false
PLAYERUNION.extensions = {}
var_0_60.ID_FIELD.name = "id"
var_0_60.ID_FIELD.full_name = ".sgland.FundStatus.id"
var_0_60.ID_FIELD.number = 1
var_0_60.ID_FIELD.index = 0
var_0_60.ID_FIELD.label = 2
var_0_60.ID_FIELD.has_default_value = false
var_0_60.ID_FIELD.default_value = 0
var_0_60.ID_FIELD.type = 5
var_0_60.ID_FIELD.cpp_type = 1
var_0_60.BUY_TIME_FIELD.name = "buy_time"
var_0_60.BUY_TIME_FIELD.full_name = ".sgland.FundStatus.buy_time"
var_0_60.BUY_TIME_FIELD.number = 2
var_0_60.BUY_TIME_FIELD.index = 1
var_0_60.BUY_TIME_FIELD.label = 2
var_0_60.BUY_TIME_FIELD.has_default_value = false
var_0_60.BUY_TIME_FIELD.default_value = 0
var_0_60.BUY_TIME_FIELD.type = 3
var_0_60.BUY_TIME_FIELD.cpp_type = 2
FUNDSTATUS.name = "FundStatus"
FUNDSTATUS.full_name = ".sgland.FundStatus"
FUNDSTATUS.nested_types = {}
FUNDSTATUS.enum_types = {}
FUNDSTATUS.fields = {
	var_0_60.ID_FIELD,
	var_0_60.BUY_TIME_FIELD
}
FUNDSTATUS.is_extendable = false
FUNDSTATUS.extensions = {}
var_0_61.LOGIN_FIELD.name = "login"
var_0_61.LOGIN_FIELD.full_name = ".sgland.PlayerActivity.login"
var_0_61.LOGIN_FIELD.number = 1
var_0_61.LOGIN_FIELD.index = 0
var_0_61.LOGIN_FIELD.label = 2
var_0_61.LOGIN_FIELD.has_default_value = false
var_0_61.LOGIN_FIELD.default_value = 0
var_0_61.LOGIN_FIELD.type = 5
var_0_61.LOGIN_FIELD.cpp_type = 1
var_0_61.CHARGE_FIELD.name = "charge"
var_0_61.CHARGE_FIELD.full_name = ".sgland.PlayerActivity.charge"
var_0_61.CHARGE_FIELD.number = 2
var_0_61.CHARGE_FIELD.index = 1
var_0_61.CHARGE_FIELD.label = 2
var_0_61.CHARGE_FIELD.has_default_value = false
var_0_61.CHARGE_FIELD.default_value = 0
var_0_61.CHARGE_FIELD.type = 5
var_0_61.CHARGE_FIELD.cpp_type = 1
var_0_61.GHOST_FIELD.name = "ghost"
var_0_61.GHOST_FIELD.full_name = ".sgland.PlayerActivity.ghost"
var_0_61.GHOST_FIELD.number = 3
var_0_61.GHOST_FIELD.index = 2
var_0_61.GHOST_FIELD.label = 2
var_0_61.GHOST_FIELD.has_default_value = false
var_0_61.GHOST_FIELD.default_value = 0
var_0_61.GHOST_FIELD.type = 5
var_0_61.GHOST_FIELD.cpp_type = 1
var_0_61.CONSUME_FIELD.name = "consume"
var_0_61.CONSUME_FIELD.full_name = ".sgland.PlayerActivity.consume"
var_0_61.CONSUME_FIELD.number = 4
var_0_61.CONSUME_FIELD.index = 3
var_0_61.CONSUME_FIELD.label = 2
var_0_61.CONSUME_FIELD.has_default_value = false
var_0_61.CONSUME_FIELD.default_value = 0
var_0_61.CONSUME_FIELD.type = 5
var_0_61.CONSUME_FIELD.cpp_type = 1
var_0_61.LAST_LOGIN_FIELD.name = "last_login"
var_0_61.LAST_LOGIN_FIELD.full_name = ".sgland.PlayerActivity.last_login"
var_0_61.LAST_LOGIN_FIELD.number = 5
var_0_61.LAST_LOGIN_FIELD.index = 4
var_0_61.LAST_LOGIN_FIELD.label = 2
var_0_61.LAST_LOGIN_FIELD.has_default_value = false
var_0_61.LAST_LOGIN_FIELD.default_value = 0
var_0_61.LAST_LOGIN_FIELD.type = 3
var_0_61.LAST_LOGIN_FIELD.cpp_type = 2
var_0_61.LAST_CHARGE_FIELD.name = "last_charge"
var_0_61.LAST_CHARGE_FIELD.full_name = ".sgland.PlayerActivity.last_charge"
var_0_61.LAST_CHARGE_FIELD.number = 6
var_0_61.LAST_CHARGE_FIELD.index = 5
var_0_61.LAST_CHARGE_FIELD.label = 2
var_0_61.LAST_CHARGE_FIELD.has_default_value = false
var_0_61.LAST_CHARGE_FIELD.default_value = 0
var_0_61.LAST_CHARGE_FIELD.type = 3
var_0_61.LAST_CHARGE_FIELD.cpp_type = 2
var_0_61.LAST_GHOST_FIELD.name = "last_ghost"
var_0_61.LAST_GHOST_FIELD.full_name = ".sgland.PlayerActivity.last_ghost"
var_0_61.LAST_GHOST_FIELD.number = 7
var_0_61.LAST_GHOST_FIELD.index = 6
var_0_61.LAST_GHOST_FIELD.label = 2
var_0_61.LAST_GHOST_FIELD.has_default_value = false
var_0_61.LAST_GHOST_FIELD.default_value = 0
var_0_61.LAST_GHOST_FIELD.type = 3
var_0_61.LAST_GHOST_FIELD.cpp_type = 2
var_0_61.LAST_CONSUME_FIELD.name = "last_consume"
var_0_61.LAST_CONSUME_FIELD.full_name = ".sgland.PlayerActivity.last_consume"
var_0_61.LAST_CONSUME_FIELD.number = 8
var_0_61.LAST_CONSUME_FIELD.index = 7
var_0_61.LAST_CONSUME_FIELD.label = 2
var_0_61.LAST_CONSUME_FIELD.has_default_value = false
var_0_61.LAST_CONSUME_FIELD.default_value = 0
var_0_61.LAST_CONSUME_FIELD.type = 3
var_0_61.LAST_CONSUME_FIELD.cpp_type = 2
var_0_61.REBATE_FIELD.name = "rebate"
var_0_61.REBATE_FIELD.full_name = ".sgland.PlayerActivity.rebate"
var_0_61.REBATE_FIELD.number = 9
var_0_61.REBATE_FIELD.index = 8
var_0_61.REBATE_FIELD.label = 1
var_0_61.REBATE_FIELD.has_default_value = false
var_0_61.REBATE_FIELD.default_value = 0
var_0_61.REBATE_FIELD.type = 5
var_0_61.REBATE_FIELD.cpp_type = 1
var_0_61.LAST_REBATE_FIELD.name = "last_rebate"
var_0_61.LAST_REBATE_FIELD.full_name = ".sgland.PlayerActivity.last_rebate"
var_0_61.LAST_REBATE_FIELD.number = 10
var_0_61.LAST_REBATE_FIELD.index = 9
var_0_61.LAST_REBATE_FIELD.label = 1
var_0_61.LAST_REBATE_FIELD.has_default_value = false
var_0_61.LAST_REBATE_FIELD.default_value = 0
var_0_61.LAST_REBATE_FIELD.type = 3
var_0_61.LAST_REBATE_FIELD.cpp_type = 2
var_0_61.BONUS_FIELD.name = "bonus"
var_0_61.BONUS_FIELD.full_name = ".sgland.PlayerActivity.bonus"
var_0_61.BONUS_FIELD.number = 11
var_0_61.BONUS_FIELD.index = 10
var_0_61.BONUS_FIELD.label = 1
var_0_61.BONUS_FIELD.has_default_value = false
var_0_61.BONUS_FIELD.default_value = nil
var_0_61.BONUS_FIELD.message_type = PLAYERBONUS
var_0_61.BONUS_FIELD.type = 11
var_0_61.BONUS_FIELD.cpp_type = 10
var_0_61.LAST_BONUS_FIELD.name = "last_bonus"
var_0_61.LAST_BONUS_FIELD.full_name = ".sgland.PlayerActivity.last_bonus"
var_0_61.LAST_BONUS_FIELD.number = 12
var_0_61.LAST_BONUS_FIELD.index = 11
var_0_61.LAST_BONUS_FIELD.label = 1
var_0_61.LAST_BONUS_FIELD.has_default_value = false
var_0_61.LAST_BONUS_FIELD.default_value = 0
var_0_61.LAST_BONUS_FIELD.type = 3
var_0_61.LAST_BONUS_FIELD.cpp_type = 2
var_0_61.BUNDLES_FIELD.name = "bundles"
var_0_61.BUNDLES_FIELD.full_name = ".sgland.PlayerActivity.bundles"
var_0_61.BUNDLES_FIELD.number = 13
var_0_61.BUNDLES_FIELD.index = 12
var_0_61.BUNDLES_FIELD.label = 3
var_0_61.BUNDLES_FIELD.has_default_value = false
var_0_61.BUNDLES_FIELD.default_value = {}
var_0_61.BUNDLES_FIELD.message_type = RESOURCE
var_0_61.BUNDLES_FIELD.type = 11
var_0_61.BUNDLES_FIELD.cpp_type = 10
var_0_61.LAST_MARKET_FIELD.name = "last_market"
var_0_61.LAST_MARKET_FIELD.full_name = ".sgland.PlayerActivity.last_market"
var_0_61.LAST_MARKET_FIELD.number = 14
var_0_61.LAST_MARKET_FIELD.index = 13
var_0_61.LAST_MARKET_FIELD.label = 1
var_0_61.LAST_MARKET_FIELD.has_default_value = false
var_0_61.LAST_MARKET_FIELD.default_value = 0
var_0_61.LAST_MARKET_FIELD.type = 3
var_0_61.LAST_MARKET_FIELD.cpp_type = 2
var_0_61.CHARGE_EX_FIELD.name = "charge_ex"
var_0_61.CHARGE_EX_FIELD.full_name = ".sgland.PlayerActivity.charge_ex"
var_0_61.CHARGE_EX_FIELD.number = 15
var_0_61.CHARGE_EX_FIELD.index = 14
var_0_61.CHARGE_EX_FIELD.label = 1
var_0_61.CHARGE_EX_FIELD.has_default_value = false
var_0_61.CHARGE_EX_FIELD.default_value = 0
var_0_61.CHARGE_EX_FIELD.type = 5
var_0_61.CHARGE_EX_FIELD.cpp_type = 1
var_0_61.LAST_CHARGE_EX_FIELD.name = "last_charge_ex"
var_0_61.LAST_CHARGE_EX_FIELD.full_name = ".sgland.PlayerActivity.last_charge_ex"
var_0_61.LAST_CHARGE_EX_FIELD.number = 16
var_0_61.LAST_CHARGE_EX_FIELD.index = 15
var_0_61.LAST_CHARGE_EX_FIELD.label = 1
var_0_61.LAST_CHARGE_EX_FIELD.has_default_value = false
var_0_61.LAST_CHARGE_EX_FIELD.default_value = 0
var_0_61.LAST_CHARGE_EX_FIELD.type = 3
var_0_61.LAST_CHARGE_EX_FIELD.cpp_type = 2
var_0_61.LAST_PKG_CARD_FIELD.name = "last_pkg_card"
var_0_61.LAST_PKG_CARD_FIELD.full_name = ".sgland.PlayerActivity.last_pkg_card"
var_0_61.LAST_PKG_CARD_FIELD.number = 17
var_0_61.LAST_PKG_CARD_FIELD.index = 16
var_0_61.LAST_PKG_CARD_FIELD.label = 1
var_0_61.LAST_PKG_CARD_FIELD.has_default_value = false
var_0_61.LAST_PKG_CARD_FIELD.default_value = 0
var_0_61.LAST_PKG_CARD_FIELD.type = 3
var_0_61.LAST_PKG_CARD_FIELD.cpp_type = 2
var_0_61.LAST_PKG_GIFT_FIELD.name = "last_pkg_gift"
var_0_61.LAST_PKG_GIFT_FIELD.full_name = ".sgland.PlayerActivity.last_pkg_gift"
var_0_61.LAST_PKG_GIFT_FIELD.number = 18
var_0_61.LAST_PKG_GIFT_FIELD.index = 17
var_0_61.LAST_PKG_GIFT_FIELD.label = 1
var_0_61.LAST_PKG_GIFT_FIELD.has_default_value = false
var_0_61.LAST_PKG_GIFT_FIELD.default_value = 0
var_0_61.LAST_PKG_GIFT_FIELD.type = 3
var_0_61.LAST_PKG_GIFT_FIELD.cpp_type = 2
var_0_61.LAST_PKG_GIFT_INGOT_FIELD.name = "last_pkg_gift_ingot"
var_0_61.LAST_PKG_GIFT_INGOT_FIELD.full_name = ".sgland.PlayerActivity.last_pkg_gift_ingot"
var_0_61.LAST_PKG_GIFT_INGOT_FIELD.number = 19
var_0_61.LAST_PKG_GIFT_INGOT_FIELD.index = 18
var_0_61.LAST_PKG_GIFT_INGOT_FIELD.label = 1
var_0_61.LAST_PKG_GIFT_INGOT_FIELD.has_default_value = false
var_0_61.LAST_PKG_GIFT_INGOT_FIELD.default_value = 0
var_0_61.LAST_PKG_GIFT_INGOT_FIELD.type = 3
var_0_61.LAST_PKG_GIFT_INGOT_FIELD.cpp_type = 2
var_0_61.LAST_PKG_GIFT_MULTIPLE1_FIELD.name = "last_pkg_gift_multiple1"
var_0_61.LAST_PKG_GIFT_MULTIPLE1_FIELD.full_name = ".sgland.PlayerActivity.last_pkg_gift_multiple1"
var_0_61.LAST_PKG_GIFT_MULTIPLE1_FIELD.number = 20
var_0_61.LAST_PKG_GIFT_MULTIPLE1_FIELD.index = 19
var_0_61.LAST_PKG_GIFT_MULTIPLE1_FIELD.label = 1
var_0_61.LAST_PKG_GIFT_MULTIPLE1_FIELD.has_default_value = false
var_0_61.LAST_PKG_GIFT_MULTIPLE1_FIELD.default_value = 0
var_0_61.LAST_PKG_GIFT_MULTIPLE1_FIELD.type = 3
var_0_61.LAST_PKG_GIFT_MULTIPLE1_FIELD.cpp_type = 2
var_0_61.LAST_PKG_GIFT_MULTIPLE2_FIELD.name = "last_pkg_gift_multiple2"
var_0_61.LAST_PKG_GIFT_MULTIPLE2_FIELD.full_name = ".sgland.PlayerActivity.last_pkg_gift_multiple2"
var_0_61.LAST_PKG_GIFT_MULTIPLE2_FIELD.number = 21
var_0_61.LAST_PKG_GIFT_MULTIPLE2_FIELD.index = 20
var_0_61.LAST_PKG_GIFT_MULTIPLE2_FIELD.label = 1
var_0_61.LAST_PKG_GIFT_MULTIPLE2_FIELD.has_default_value = false
var_0_61.LAST_PKG_GIFT_MULTIPLE2_FIELD.default_value = 0
var_0_61.LAST_PKG_GIFT_MULTIPLE2_FIELD.type = 3
var_0_61.LAST_PKG_GIFT_MULTIPLE2_FIELD.cpp_type = 2
var_0_61.PRIVILEGE_STAMP_FIELD.name = "privilege_stamp"
var_0_61.PRIVILEGE_STAMP_FIELD.full_name = ".sgland.PlayerActivity.privilege_stamp"
var_0_61.PRIVILEGE_STAMP_FIELD.number = 22
var_0_61.PRIVILEGE_STAMP_FIELD.index = 21
var_0_61.PRIVILEGE_STAMP_FIELD.label = 1
var_0_61.PRIVILEGE_STAMP_FIELD.has_default_value = false
var_0_61.PRIVILEGE_STAMP_FIELD.default_value = 0
var_0_61.PRIVILEGE_STAMP_FIELD.type = 3
var_0_61.PRIVILEGE_STAMP_FIELD.cpp_type = 2
var_0_61.LADDER_DAILY_DROP_FIELD.name = "ladder_daily_drop"
var_0_61.LADDER_DAILY_DROP_FIELD.full_name = ".sgland.PlayerActivity.ladder_daily_drop"
var_0_61.LADDER_DAILY_DROP_FIELD.number = 23
var_0_61.LADDER_DAILY_DROP_FIELD.index = 22
var_0_61.LADDER_DAILY_DROP_FIELD.label = 1
var_0_61.LADDER_DAILY_DROP_FIELD.has_default_value = false
var_0_61.LADDER_DAILY_DROP_FIELD.default_value = 0
var_0_61.LADDER_DAILY_DROP_FIELD.type = 5
var_0_61.LADDER_DAILY_DROP_FIELD.cpp_type = 1
var_0_61.LADDER_EX_DAILY_DROP_FIELD.name = "ladder_ex_daily_drop"
var_0_61.LADDER_EX_DAILY_DROP_FIELD.full_name = ".sgland.PlayerActivity.ladder_ex_daily_drop"
var_0_61.LADDER_EX_DAILY_DROP_FIELD.number = 24
var_0_61.LADDER_EX_DAILY_DROP_FIELD.index = 23
var_0_61.LADDER_EX_DAILY_DROP_FIELD.label = 1
var_0_61.LADDER_EX_DAILY_DROP_FIELD.has_default_value = false
var_0_61.LADDER_EX_DAILY_DROP_FIELD.default_value = 0
var_0_61.LADDER_EX_DAILY_DROP_FIELD.type = 5
var_0_61.LADDER_EX_DAILY_DROP_FIELD.cpp_type = 1
var_0_61.DARK_DAILY_DROP_FIELD.name = "dark_daily_drop"
var_0_61.DARK_DAILY_DROP_FIELD.full_name = ".sgland.PlayerActivity.dark_daily_drop"
var_0_61.DARK_DAILY_DROP_FIELD.number = 25
var_0_61.DARK_DAILY_DROP_FIELD.index = 24
var_0_61.DARK_DAILY_DROP_FIELD.label = 1
var_0_61.DARK_DAILY_DROP_FIELD.has_default_value = false
var_0_61.DARK_DAILY_DROP_FIELD.default_value = 0
var_0_61.DARK_DAILY_DROP_FIELD.type = 5
var_0_61.DARK_DAILY_DROP_FIELD.cpp_type = 1
var_0_61.MAX_DARK_SCORE_FIELD.name = "max_dark_score"
var_0_61.MAX_DARK_SCORE_FIELD.full_name = ".sgland.PlayerActivity.max_dark_score"
var_0_61.MAX_DARK_SCORE_FIELD.number = 26
var_0_61.MAX_DARK_SCORE_FIELD.index = 25
var_0_61.MAX_DARK_SCORE_FIELD.label = 1
var_0_61.MAX_DARK_SCORE_FIELD.has_default_value = false
var_0_61.MAX_DARK_SCORE_FIELD.default_value = 0
var_0_61.MAX_DARK_SCORE_FIELD.type = 5
var_0_61.MAX_DARK_SCORE_FIELD.cpp_type = 1
var_0_61.LAST_MAX_DARK_SCORE_FIELD.name = "last_max_dark_score"
var_0_61.LAST_MAX_DARK_SCORE_FIELD.full_name = ".sgland.PlayerActivity.last_max_dark_score"
var_0_61.LAST_MAX_DARK_SCORE_FIELD.number = 27
var_0_61.LAST_MAX_DARK_SCORE_FIELD.index = 26
var_0_61.LAST_MAX_DARK_SCORE_FIELD.label = 1
var_0_61.LAST_MAX_DARK_SCORE_FIELD.has_default_value = false
var_0_61.LAST_MAX_DARK_SCORE_FIELD.default_value = 0
var_0_61.LAST_MAX_DARK_SCORE_FIELD.type = 3
var_0_61.LAST_MAX_DARK_SCORE_FIELD.cpp_type = 2
var_0_61.LAST_PKG_GIFT_MULTIPLE0_FIELD.name = "last_pkg_gift_multiple0"
var_0_61.LAST_PKG_GIFT_MULTIPLE0_FIELD.full_name = ".sgland.PlayerActivity.last_pkg_gift_multiple0"
var_0_61.LAST_PKG_GIFT_MULTIPLE0_FIELD.number = 28
var_0_61.LAST_PKG_GIFT_MULTIPLE0_FIELD.index = 27
var_0_61.LAST_PKG_GIFT_MULTIPLE0_FIELD.label = 1
var_0_61.LAST_PKG_GIFT_MULTIPLE0_FIELD.has_default_value = false
var_0_61.LAST_PKG_GIFT_MULTIPLE0_FIELD.default_value = 0
var_0_61.LAST_PKG_GIFT_MULTIPLE0_FIELD.type = 3
var_0_61.LAST_PKG_GIFT_MULTIPLE0_FIELD.cpp_type = 2
var_0_61.SURVIVAL_DAILY_DROP_FIELD.name = "survival_daily_drop"
var_0_61.SURVIVAL_DAILY_DROP_FIELD.full_name = ".sgland.PlayerActivity.survival_daily_drop"
var_0_61.SURVIVAL_DAILY_DROP_FIELD.number = 29
var_0_61.SURVIVAL_DAILY_DROP_FIELD.index = 28
var_0_61.SURVIVAL_DAILY_DROP_FIELD.label = 1
var_0_61.SURVIVAL_DAILY_DROP_FIELD.has_default_value = false
var_0_61.SURVIVAL_DAILY_DROP_FIELD.default_value = 0
var_0_61.SURVIVAL_DAILY_DROP_FIELD.type = 5
var_0_61.SURVIVAL_DAILY_DROP_FIELD.cpp_type = 1
var_0_61.PERSONAL_FUND_STATUS_FIELD.name = "personal_fund_status"
var_0_61.PERSONAL_FUND_STATUS_FIELD.full_name = ".sgland.PlayerActivity.personal_fund_status"
var_0_61.PERSONAL_FUND_STATUS_FIELD.number = 30
var_0_61.PERSONAL_FUND_STATUS_FIELD.index = 29
var_0_61.PERSONAL_FUND_STATUS_FIELD.label = 3
var_0_61.PERSONAL_FUND_STATUS_FIELD.has_default_value = false
var_0_61.PERSONAL_FUND_STATUS_FIELD.default_value = {}
var_0_61.PERSONAL_FUND_STATUS_FIELD.message_type = FUNDSTATUS
var_0_61.PERSONAL_FUND_STATUS_FIELD.type = 11
var_0_61.PERSONAL_FUND_STATUS_FIELD.cpp_type = 10
var_0_61.LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD.name = "last_double_charge_day_limit"
var_0_61.LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD.full_name = ".sgland.PlayerActivity.last_double_charge_day_limit"
var_0_61.LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD.number = 31
var_0_61.LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD.index = 30
var_0_61.LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD.label = 1
var_0_61.LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD.has_default_value = false
var_0_61.LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD.default_value = 0
var_0_61.LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD.type = 3
var_0_61.LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD.cpp_type = 2
var_0_61.DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD.name = "double_charge_day_limit_value"
var_0_61.DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD.full_name = ".sgland.PlayerActivity.double_charge_day_limit_value"
var_0_61.DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD.number = 32
var_0_61.DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD.index = 31
var_0_61.DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD.label = 1
var_0_61.DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD.has_default_value = true
var_0_61.DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD.default_value = 63
var_0_61.DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD.type = 5
var_0_61.DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD.cpp_type = 1
var_0_61.BADGE_LEVEL_FIELD.name = "badge_level"
var_0_61.BADGE_LEVEL_FIELD.full_name = ".sgland.PlayerActivity.badge_level"
var_0_61.BADGE_LEVEL_FIELD.number = 33
var_0_61.BADGE_LEVEL_FIELD.index = 32
var_0_61.BADGE_LEVEL_FIELD.label = 1
var_0_61.BADGE_LEVEL_FIELD.has_default_value = false
var_0_61.BADGE_LEVEL_FIELD.default_value = 0
var_0_61.BADGE_LEVEL_FIELD.type = 5
var_0_61.BADGE_LEVEL_FIELD.cpp_type = 1
var_0_61.BADGE_EXP_FIELD.name = "badge_exp"
var_0_61.BADGE_EXP_FIELD.full_name = ".sgland.PlayerActivity.badge_exp"
var_0_61.BADGE_EXP_FIELD.number = 34
var_0_61.BADGE_EXP_FIELD.index = 33
var_0_61.BADGE_EXP_FIELD.label = 1
var_0_61.BADGE_EXP_FIELD.has_default_value = false
var_0_61.BADGE_EXP_FIELD.default_value = 0
var_0_61.BADGE_EXP_FIELD.type = 5
var_0_61.BADGE_EXP_FIELD.cpp_type = 1
var_0_61.BADGE_PURCHASED_FIELD.name = "badge_purchased"
var_0_61.BADGE_PURCHASED_FIELD.full_name = ".sgland.PlayerActivity.badge_purchased"
var_0_61.BADGE_PURCHASED_FIELD.number = 35
var_0_61.BADGE_PURCHASED_FIELD.index = 34
var_0_61.BADGE_PURCHASED_FIELD.label = 1
var_0_61.BADGE_PURCHASED_FIELD.has_default_value = false
var_0_61.BADGE_PURCHASED_FIELD.default_value = false
var_0_61.BADGE_PURCHASED_FIELD.type = 8
var_0_61.BADGE_PURCHASED_FIELD.cpp_type = 7
var_0_61.BADGE_SEASON_FIELD.name = "badge_season"
var_0_61.BADGE_SEASON_FIELD.full_name = ".sgland.PlayerActivity.badge_season"
var_0_61.BADGE_SEASON_FIELD.number = 36
var_0_61.BADGE_SEASON_FIELD.index = 35
var_0_61.BADGE_SEASON_FIELD.label = 1
var_0_61.BADGE_SEASON_FIELD.has_default_value = false
var_0_61.BADGE_SEASON_FIELD.default_value = 0
var_0_61.BADGE_SEASON_FIELD.type = 5
var_0_61.BADGE_SEASON_FIELD.cpp_type = 1
var_0_61.BADGE_END_TIMESTAMP_FIELD.name = "badge_end_timestamp"
var_0_61.BADGE_END_TIMESTAMP_FIELD.full_name = ".sgland.PlayerActivity.badge_end_timestamp"
var_0_61.BADGE_END_TIMESTAMP_FIELD.number = 37
var_0_61.BADGE_END_TIMESTAMP_FIELD.index = 36
var_0_61.BADGE_END_TIMESTAMP_FIELD.label = 1
var_0_61.BADGE_END_TIMESTAMP_FIELD.has_default_value = false
var_0_61.BADGE_END_TIMESTAMP_FIELD.default_value = 0
var_0_61.BADGE_END_TIMESTAMP_FIELD.type = 3
var_0_61.BADGE_END_TIMESTAMP_FIELD.cpp_type = 2
var_0_61.BADGE_LADDER_GAIN_WEELY_FIELD.name = "badge_ladder_gain_weely"
var_0_61.BADGE_LADDER_GAIN_WEELY_FIELD.full_name = ".sgland.PlayerActivity.badge_ladder_gain_weely"
var_0_61.BADGE_LADDER_GAIN_WEELY_FIELD.number = 38
var_0_61.BADGE_LADDER_GAIN_WEELY_FIELD.index = 37
var_0_61.BADGE_LADDER_GAIN_WEELY_FIELD.label = 1
var_0_61.BADGE_LADDER_GAIN_WEELY_FIELD.has_default_value = false
var_0_61.BADGE_LADDER_GAIN_WEELY_FIELD.default_value = 0
var_0_61.BADGE_LADDER_GAIN_WEELY_FIELD.type = 5
var_0_61.BADGE_LADDER_GAIN_WEELY_FIELD.cpp_type = 1
var_0_61.BADGE_MATCH_GAIN_WEEKLY_FIELD.name = "badge_match_gain_weekly"
var_0_61.BADGE_MATCH_GAIN_WEEKLY_FIELD.full_name = ".sgland.PlayerActivity.badge_match_gain_weekly"
var_0_61.BADGE_MATCH_GAIN_WEEKLY_FIELD.number = 39
var_0_61.BADGE_MATCH_GAIN_WEEKLY_FIELD.index = 38
var_0_61.BADGE_MATCH_GAIN_WEEKLY_FIELD.label = 1
var_0_61.BADGE_MATCH_GAIN_WEEKLY_FIELD.has_default_value = false
var_0_61.BADGE_MATCH_GAIN_WEEKLY_FIELD.default_value = 0
var_0_61.BADGE_MATCH_GAIN_WEEKLY_FIELD.type = 5
var_0_61.BADGE_MATCH_GAIN_WEEKLY_FIELD.cpp_type = 1
var_0_61.TURN_TABLE_COUNT_FIELD.name = "turn_table_count"
var_0_61.TURN_TABLE_COUNT_FIELD.full_name = ".sgland.PlayerActivity.turn_table_count"
var_0_61.TURN_TABLE_COUNT_FIELD.number = 40
var_0_61.TURN_TABLE_COUNT_FIELD.index = 39
var_0_61.TURN_TABLE_COUNT_FIELD.label = 1
var_0_61.TURN_TABLE_COUNT_FIELD.has_default_value = false
var_0_61.TURN_TABLE_COUNT_FIELD.default_value = 0
var_0_61.TURN_TABLE_COUNT_FIELD.type = 5
var_0_61.TURN_TABLE_COUNT_FIELD.cpp_type = 1
var_0_61.LAST_TURN_TABLE_LOTTERY_FIELD.name = "last_turn_table_lottery"
var_0_61.LAST_TURN_TABLE_LOTTERY_FIELD.full_name = ".sgland.PlayerActivity.last_turn_table_lottery"
var_0_61.LAST_TURN_TABLE_LOTTERY_FIELD.number = 41
var_0_61.LAST_TURN_TABLE_LOTTERY_FIELD.index = 40
var_0_61.LAST_TURN_TABLE_LOTTERY_FIELD.label = 1
var_0_61.LAST_TURN_TABLE_LOTTERY_FIELD.has_default_value = false
var_0_61.LAST_TURN_TABLE_LOTTERY_FIELD.default_value = 0
var_0_61.LAST_TURN_TABLE_LOTTERY_FIELD.type = 3
var_0_61.LAST_TURN_TABLE_LOTTERY_FIELD.cpp_type = 2
var_0_61.LAST_LADDER_EX_PRIVILEGE_FIELD.name = "last_ladder_ex_privilege"
var_0_61.LAST_LADDER_EX_PRIVILEGE_FIELD.full_name = ".sgland.PlayerActivity.last_ladder_ex_privilege"
var_0_61.LAST_LADDER_EX_PRIVILEGE_FIELD.number = 42
var_0_61.LAST_LADDER_EX_PRIVILEGE_FIELD.index = 41
var_0_61.LAST_LADDER_EX_PRIVILEGE_FIELD.label = 1
var_0_61.LAST_LADDER_EX_PRIVILEGE_FIELD.has_default_value = false
var_0_61.LAST_LADDER_EX_PRIVILEGE_FIELD.default_value = 0
var_0_61.LAST_LADDER_EX_PRIVILEGE_FIELD.type = 3
var_0_61.LAST_LADDER_EX_PRIVILEGE_FIELD.cpp_type = 2
var_0_61.LADDER_ACITIVTY_TROPHY_FIELD.name = "ladder_acitivty_trophy"
var_0_61.LADDER_ACITIVTY_TROPHY_FIELD.full_name = ".sgland.PlayerActivity.ladder_acitivty_trophy"
var_0_61.LADDER_ACITIVTY_TROPHY_FIELD.number = 43
var_0_61.LADDER_ACITIVTY_TROPHY_FIELD.index = 42
var_0_61.LADDER_ACITIVTY_TROPHY_FIELD.label = 1
var_0_61.LADDER_ACITIVTY_TROPHY_FIELD.has_default_value = false
var_0_61.LADDER_ACITIVTY_TROPHY_FIELD.default_value = 0
var_0_61.LADDER_ACITIVTY_TROPHY_FIELD.type = 5
var_0_61.LADDER_ACITIVTY_TROPHY_FIELD.cpp_type = 1
var_0_61.LAST_LADDER_ACITIVTY_TROPHY_FIELD.name = "last_ladder_acitivty_trophy"
var_0_61.LAST_LADDER_ACITIVTY_TROPHY_FIELD.full_name = ".sgland.PlayerActivity.last_ladder_acitivty_trophy"
var_0_61.LAST_LADDER_ACITIVTY_TROPHY_FIELD.number = 44
var_0_61.LAST_LADDER_ACITIVTY_TROPHY_FIELD.index = 43
var_0_61.LAST_LADDER_ACITIVTY_TROPHY_FIELD.label = 1
var_0_61.LAST_LADDER_ACITIVTY_TROPHY_FIELD.has_default_value = false
var_0_61.LAST_LADDER_ACITIVTY_TROPHY_FIELD.default_value = 0
var_0_61.LAST_LADDER_ACITIVTY_TROPHY_FIELD.type = 3
var_0_61.LAST_LADDER_ACITIVTY_TROPHY_FIELD.cpp_type = 2
var_0_61.PACKAGE_GOT_INFO_FIELD.name = "package_got_info"
var_0_61.PACKAGE_GOT_INFO_FIELD.full_name = ".sgland.PlayerActivity.package_got_info"
var_0_61.PACKAGE_GOT_INFO_FIELD.number = 45
var_0_61.PACKAGE_GOT_INFO_FIELD.index = 44
var_0_61.PACKAGE_GOT_INFO_FIELD.label = 1
var_0_61.PACKAGE_GOT_INFO_FIELD.has_default_value = false
var_0_61.PACKAGE_GOT_INFO_FIELD.default_value = 0
var_0_61.PACKAGE_GOT_INFO_FIELD.type = 3
var_0_61.PACKAGE_GOT_INFO_FIELD.cpp_type = 2
var_0_61.SURVIVAL_EX_DAILY_DROP_FIELD.name = "survival_ex_daily_drop"
var_0_61.SURVIVAL_EX_DAILY_DROP_FIELD.full_name = ".sgland.PlayerActivity.survival_ex_daily_drop"
var_0_61.SURVIVAL_EX_DAILY_DROP_FIELD.number = 46
var_0_61.SURVIVAL_EX_DAILY_DROP_FIELD.index = 45
var_0_61.SURVIVAL_EX_DAILY_DROP_FIELD.label = 1
var_0_61.SURVIVAL_EX_DAILY_DROP_FIELD.has_default_value = false
var_0_61.SURVIVAL_EX_DAILY_DROP_FIELD.default_value = 0
var_0_61.SURVIVAL_EX_DAILY_DROP_FIELD.type = 5
var_0_61.SURVIVAL_EX_DAILY_DROP_FIELD.cpp_type = 1
var_0_61.LAST_SURVIVAL_EX_PRIVILEGE_FIELD.name = "last_survival_ex_privilege"
var_0_61.LAST_SURVIVAL_EX_PRIVILEGE_FIELD.full_name = ".sgland.PlayerActivity.last_survival_ex_privilege"
var_0_61.LAST_SURVIVAL_EX_PRIVILEGE_FIELD.number = 47
var_0_61.LAST_SURVIVAL_EX_PRIVILEGE_FIELD.index = 46
var_0_61.LAST_SURVIVAL_EX_PRIVILEGE_FIELD.label = 1
var_0_61.LAST_SURVIVAL_EX_PRIVILEGE_FIELD.has_default_value = false
var_0_61.LAST_SURVIVAL_EX_PRIVILEGE_FIELD.default_value = 0
var_0_61.LAST_SURVIVAL_EX_PRIVILEGE_FIELD.type = 3
var_0_61.LAST_SURVIVAL_EX_PRIVILEGE_FIELD.cpp_type = 2
var_0_61.LEGEND_DAILY_DROP_FIELD.name = "legend_daily_drop"
var_0_61.LEGEND_DAILY_DROP_FIELD.full_name = ".sgland.PlayerActivity.legend_daily_drop"
var_0_61.LEGEND_DAILY_DROP_FIELD.number = 48
var_0_61.LEGEND_DAILY_DROP_FIELD.index = 47
var_0_61.LEGEND_DAILY_DROP_FIELD.label = 1
var_0_61.LEGEND_DAILY_DROP_FIELD.has_default_value = false
var_0_61.LEGEND_DAILY_DROP_FIELD.default_value = 0
var_0_61.LEGEND_DAILY_DROP_FIELD.type = 5
var_0_61.LEGEND_DAILY_DROP_FIELD.cpp_type = 1
var_0_61.SPRING_BADGE_LEVEL_FIELD.name = "spring_badge_level"
var_0_61.SPRING_BADGE_LEVEL_FIELD.full_name = ".sgland.PlayerActivity.spring_badge_level"
var_0_61.SPRING_BADGE_LEVEL_FIELD.number = 49
var_0_61.SPRING_BADGE_LEVEL_FIELD.index = 48
var_0_61.SPRING_BADGE_LEVEL_FIELD.label = 1
var_0_61.SPRING_BADGE_LEVEL_FIELD.has_default_value = false
var_0_61.SPRING_BADGE_LEVEL_FIELD.default_value = 0
var_0_61.SPRING_BADGE_LEVEL_FIELD.type = 5
var_0_61.SPRING_BADGE_LEVEL_FIELD.cpp_type = 1
var_0_61.SPRING_BADGE_EXP_FIELD.name = "spring_badge_exp"
var_0_61.SPRING_BADGE_EXP_FIELD.full_name = ".sgland.PlayerActivity.spring_badge_exp"
var_0_61.SPRING_BADGE_EXP_FIELD.number = 50
var_0_61.SPRING_BADGE_EXP_FIELD.index = 49
var_0_61.SPRING_BADGE_EXP_FIELD.label = 1
var_0_61.SPRING_BADGE_EXP_FIELD.has_default_value = false
var_0_61.SPRING_BADGE_EXP_FIELD.default_value = 0
var_0_61.SPRING_BADGE_EXP_FIELD.type = 5
var_0_61.SPRING_BADGE_EXP_FIELD.cpp_type = 1
var_0_61.SPRING_BADGE_PURCHASED_FIELD.name = "spring_badge_purchased"
var_0_61.SPRING_BADGE_PURCHASED_FIELD.full_name = ".sgland.PlayerActivity.spring_badge_purchased"
var_0_61.SPRING_BADGE_PURCHASED_FIELD.number = 51
var_0_61.SPRING_BADGE_PURCHASED_FIELD.index = 50
var_0_61.SPRING_BADGE_PURCHASED_FIELD.label = 1
var_0_61.SPRING_BADGE_PURCHASED_FIELD.has_default_value = false
var_0_61.SPRING_BADGE_PURCHASED_FIELD.default_value = false
var_0_61.SPRING_BADGE_PURCHASED_FIELD.type = 8
var_0_61.SPRING_BADGE_PURCHASED_FIELD.cpp_type = 7
var_0_61.SPRING_BADGE_SEASON_FIELD.name = "spring_badge_season"
var_0_61.SPRING_BADGE_SEASON_FIELD.full_name = ".sgland.PlayerActivity.spring_badge_season"
var_0_61.SPRING_BADGE_SEASON_FIELD.number = 52
var_0_61.SPRING_BADGE_SEASON_FIELD.index = 51
var_0_61.SPRING_BADGE_SEASON_FIELD.label = 1
var_0_61.SPRING_BADGE_SEASON_FIELD.has_default_value = false
var_0_61.SPRING_BADGE_SEASON_FIELD.default_value = 0
var_0_61.SPRING_BADGE_SEASON_FIELD.type = 5
var_0_61.SPRING_BADGE_SEASON_FIELD.cpp_type = 1
var_0_61.SPRING_BADGE_END_TIMESTAMP_FIELD.name = "spring_badge_end_timestamp"
var_0_61.SPRING_BADGE_END_TIMESTAMP_FIELD.full_name = ".sgland.PlayerActivity.spring_badge_end_timestamp"
var_0_61.SPRING_BADGE_END_TIMESTAMP_FIELD.number = 53
var_0_61.SPRING_BADGE_END_TIMESTAMP_FIELD.index = 52
var_0_61.SPRING_BADGE_END_TIMESTAMP_FIELD.label = 1
var_0_61.SPRING_BADGE_END_TIMESTAMP_FIELD.has_default_value = false
var_0_61.SPRING_BADGE_END_TIMESTAMP_FIELD.default_value = 0
var_0_61.SPRING_BADGE_END_TIMESTAMP_FIELD.type = 3
var_0_61.SPRING_BADGE_END_TIMESTAMP_FIELD.cpp_type = 2
var_0_61.SPRING_BADGE_LADDER_GAIN_WEELY_FIELD.name = "spring_badge_ladder_gain_weely"
var_0_61.SPRING_BADGE_LADDER_GAIN_WEELY_FIELD.full_name = ".sgland.PlayerActivity.spring_badge_ladder_gain_weely"
var_0_61.SPRING_BADGE_LADDER_GAIN_WEELY_FIELD.number = 54
var_0_61.SPRING_BADGE_LADDER_GAIN_WEELY_FIELD.index = 53
var_0_61.SPRING_BADGE_LADDER_GAIN_WEELY_FIELD.label = 1
var_0_61.SPRING_BADGE_LADDER_GAIN_WEELY_FIELD.has_default_value = false
var_0_61.SPRING_BADGE_LADDER_GAIN_WEELY_FIELD.default_value = 0
var_0_61.SPRING_BADGE_LADDER_GAIN_WEELY_FIELD.type = 5
var_0_61.SPRING_BADGE_LADDER_GAIN_WEELY_FIELD.cpp_type = 1
var_0_61.SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD.name = "spring_badge_match_gain_weekly"
var_0_61.SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD.full_name = ".sgland.PlayerActivity.spring_badge_match_gain_weekly"
var_0_61.SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD.number = 55
var_0_61.SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD.index = 54
var_0_61.SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD.label = 1
var_0_61.SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD.has_default_value = false
var_0_61.SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD.default_value = 0
var_0_61.SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD.type = 5
var_0_61.SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD.cpp_type = 1
var_0_61.SPRING2_BADGE_LEVEL_FIELD.name = "spring2_badge_level"
var_0_61.SPRING2_BADGE_LEVEL_FIELD.full_name = ".sgland.PlayerActivity.spring2_badge_level"
var_0_61.SPRING2_BADGE_LEVEL_FIELD.number = 56
var_0_61.SPRING2_BADGE_LEVEL_FIELD.index = 55
var_0_61.SPRING2_BADGE_LEVEL_FIELD.label = 1
var_0_61.SPRING2_BADGE_LEVEL_FIELD.has_default_value = false
var_0_61.SPRING2_BADGE_LEVEL_FIELD.default_value = 0
var_0_61.SPRING2_BADGE_LEVEL_FIELD.type = 5
var_0_61.SPRING2_BADGE_LEVEL_FIELD.cpp_type = 1
var_0_61.SPRING2_BADGE_EXP_FIELD.name = "spring2_badge_exp"
var_0_61.SPRING2_BADGE_EXP_FIELD.full_name = ".sgland.PlayerActivity.spring2_badge_exp"
var_0_61.SPRING2_BADGE_EXP_FIELD.number = 57
var_0_61.SPRING2_BADGE_EXP_FIELD.index = 56
var_0_61.SPRING2_BADGE_EXP_FIELD.label = 1
var_0_61.SPRING2_BADGE_EXP_FIELD.has_default_value = false
var_0_61.SPRING2_BADGE_EXP_FIELD.default_value = 0
var_0_61.SPRING2_BADGE_EXP_FIELD.type = 5
var_0_61.SPRING2_BADGE_EXP_FIELD.cpp_type = 1
var_0_61.SPRING2_BADGE_PURCHASED_FIELD.name = "spring2_badge_purchased"
var_0_61.SPRING2_BADGE_PURCHASED_FIELD.full_name = ".sgland.PlayerActivity.spring2_badge_purchased"
var_0_61.SPRING2_BADGE_PURCHASED_FIELD.number = 58
var_0_61.SPRING2_BADGE_PURCHASED_FIELD.index = 57
var_0_61.SPRING2_BADGE_PURCHASED_FIELD.label = 1
var_0_61.SPRING2_BADGE_PURCHASED_FIELD.has_default_value = false
var_0_61.SPRING2_BADGE_PURCHASED_FIELD.default_value = false
var_0_61.SPRING2_BADGE_PURCHASED_FIELD.type = 8
var_0_61.SPRING2_BADGE_PURCHASED_FIELD.cpp_type = 7
var_0_61.SPRING2_BADGE_SEASON_FIELD.name = "spring2_badge_season"
var_0_61.SPRING2_BADGE_SEASON_FIELD.full_name = ".sgland.PlayerActivity.spring2_badge_season"
var_0_61.SPRING2_BADGE_SEASON_FIELD.number = 59
var_0_61.SPRING2_BADGE_SEASON_FIELD.index = 58
var_0_61.SPRING2_BADGE_SEASON_FIELD.label = 1
var_0_61.SPRING2_BADGE_SEASON_FIELD.has_default_value = false
var_0_61.SPRING2_BADGE_SEASON_FIELD.default_value = 0
var_0_61.SPRING2_BADGE_SEASON_FIELD.type = 5
var_0_61.SPRING2_BADGE_SEASON_FIELD.cpp_type = 1
var_0_61.SPRING2_BADGE_END_TIMESTAMP_FIELD.name = "spring2_badge_end_timestamp"
var_0_61.SPRING2_BADGE_END_TIMESTAMP_FIELD.full_name = ".sgland.PlayerActivity.spring2_badge_end_timestamp"
var_0_61.SPRING2_BADGE_END_TIMESTAMP_FIELD.number = 60
var_0_61.SPRING2_BADGE_END_TIMESTAMP_FIELD.index = 59
var_0_61.SPRING2_BADGE_END_TIMESTAMP_FIELD.label = 1
var_0_61.SPRING2_BADGE_END_TIMESTAMP_FIELD.has_default_value = false
var_0_61.SPRING2_BADGE_END_TIMESTAMP_FIELD.default_value = 0
var_0_61.SPRING2_BADGE_END_TIMESTAMP_FIELD.type = 3
var_0_61.SPRING2_BADGE_END_TIMESTAMP_FIELD.cpp_type = 2
var_0_61.SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD.name = "spring2_badge_ladder_gain_weely"
var_0_61.SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD.full_name = ".sgland.PlayerActivity.spring2_badge_ladder_gain_weely"
var_0_61.SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD.number = 61
var_0_61.SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD.index = 60
var_0_61.SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD.label = 1
var_0_61.SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD.has_default_value = false
var_0_61.SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD.default_value = 0
var_0_61.SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD.type = 5
var_0_61.SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD.cpp_type = 1
var_0_61.SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD.name = "spring2_badge_match_gain_weekly"
var_0_61.SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD.full_name = ".sgland.PlayerActivity.spring2_badge_match_gain_weekly"
var_0_61.SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD.number = 62
var_0_61.SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD.index = 61
var_0_61.SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD.label = 1
var_0_61.SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD.has_default_value = false
var_0_61.SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD.default_value = 0
var_0_61.SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD.type = 5
var_0_61.SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD.cpp_type = 1
PLAYERACTIVITY.name = "PlayerActivity"
PLAYERACTIVITY.full_name = ".sgland.PlayerActivity"
PLAYERACTIVITY.nested_types = {}
PLAYERACTIVITY.enum_types = {}
PLAYERACTIVITY.fields = {
	var_0_61.LOGIN_FIELD,
	var_0_61.CHARGE_FIELD,
	var_0_61.GHOST_FIELD,
	var_0_61.CONSUME_FIELD,
	var_0_61.LAST_LOGIN_FIELD,
	var_0_61.LAST_CHARGE_FIELD,
	var_0_61.LAST_GHOST_FIELD,
	var_0_61.LAST_CONSUME_FIELD,
	var_0_61.REBATE_FIELD,
	var_0_61.LAST_REBATE_FIELD,
	var_0_61.BONUS_FIELD,
	var_0_61.LAST_BONUS_FIELD,
	var_0_61.BUNDLES_FIELD,
	var_0_61.LAST_MARKET_FIELD,
	var_0_61.CHARGE_EX_FIELD,
	var_0_61.LAST_CHARGE_EX_FIELD,
	var_0_61.LAST_PKG_CARD_FIELD,
	var_0_61.LAST_PKG_GIFT_FIELD,
	var_0_61.LAST_PKG_GIFT_INGOT_FIELD,
	var_0_61.LAST_PKG_GIFT_MULTIPLE1_FIELD,
	var_0_61.LAST_PKG_GIFT_MULTIPLE2_FIELD,
	var_0_61.PRIVILEGE_STAMP_FIELD,
	var_0_61.LADDER_DAILY_DROP_FIELD,
	var_0_61.LADDER_EX_DAILY_DROP_FIELD,
	var_0_61.DARK_DAILY_DROP_FIELD,
	var_0_61.MAX_DARK_SCORE_FIELD,
	var_0_61.LAST_MAX_DARK_SCORE_FIELD,
	var_0_61.LAST_PKG_GIFT_MULTIPLE0_FIELD,
	var_0_61.SURVIVAL_DAILY_DROP_FIELD,
	var_0_61.PERSONAL_FUND_STATUS_FIELD,
	var_0_61.LAST_DOUBLE_CHARGE_DAY_LIMIT_FIELD,
	var_0_61.DOUBLE_CHARGE_DAY_LIMIT_VALUE_FIELD,
	var_0_61.BADGE_LEVEL_FIELD,
	var_0_61.BADGE_EXP_FIELD,
	var_0_61.BADGE_PURCHASED_FIELD,
	var_0_61.BADGE_SEASON_FIELD,
	var_0_61.BADGE_END_TIMESTAMP_FIELD,
	var_0_61.BADGE_LADDER_GAIN_WEELY_FIELD,
	var_0_61.BADGE_MATCH_GAIN_WEEKLY_FIELD,
	var_0_61.TURN_TABLE_COUNT_FIELD,
	var_0_61.LAST_TURN_TABLE_LOTTERY_FIELD,
	var_0_61.LAST_LADDER_EX_PRIVILEGE_FIELD,
	var_0_61.LADDER_ACITIVTY_TROPHY_FIELD,
	var_0_61.LAST_LADDER_ACITIVTY_TROPHY_FIELD,
	var_0_61.PACKAGE_GOT_INFO_FIELD,
	var_0_61.SURVIVAL_EX_DAILY_DROP_FIELD,
	var_0_61.LAST_SURVIVAL_EX_PRIVILEGE_FIELD,
	var_0_61.LEGEND_DAILY_DROP_FIELD,
	var_0_61.SPRING_BADGE_LEVEL_FIELD,
	var_0_61.SPRING_BADGE_EXP_FIELD,
	var_0_61.SPRING_BADGE_PURCHASED_FIELD,
	var_0_61.SPRING_BADGE_SEASON_FIELD,
	var_0_61.SPRING_BADGE_END_TIMESTAMP_FIELD,
	var_0_61.SPRING_BADGE_LADDER_GAIN_WEELY_FIELD,
	var_0_61.SPRING_BADGE_MATCH_GAIN_WEEKLY_FIELD,
	var_0_61.SPRING2_BADGE_LEVEL_FIELD,
	var_0_61.SPRING2_BADGE_EXP_FIELD,
	var_0_61.SPRING2_BADGE_PURCHASED_FIELD,
	var_0_61.SPRING2_BADGE_SEASON_FIELD,
	var_0_61.SPRING2_BADGE_END_TIMESTAMP_FIELD,
	var_0_61.SPRING2_BADGE_LADDER_GAIN_WEELY_FIELD,
	var_0_61.SPRING2_BADGE_MATCH_GAIN_WEEKLY_FIELD
}
PLAYERACTIVITY.is_extendable = false
PLAYERACTIVITY.extensions = {}
var_0_62.HAS_TICKET_FIELD.name = "has_ticket"
var_0_62.HAS_TICKET_FIELD.full_name = ".sgland.PlayerLadder.has_ticket"
var_0_62.HAS_TICKET_FIELD.number = 1
var_0_62.HAS_TICKET_FIELD.index = 0
var_0_62.HAS_TICKET_FIELD.label = 2
var_0_62.HAS_TICKET_FIELD.has_default_value = false
var_0_62.HAS_TICKET_FIELD.default_value = false
var_0_62.HAS_TICKET_FIELD.type = 8
var_0_62.HAS_TICKET_FIELD.cpp_type = 7
var_0_62.CHAR_ID_FIELD.name = "char_id"
var_0_62.CHAR_ID_FIELD.full_name = ".sgland.PlayerLadder.char_id"
var_0_62.CHAR_ID_FIELD.number = 2
var_0_62.CHAR_ID_FIELD.index = 1
var_0_62.CHAR_ID_FIELD.label = 1
var_0_62.CHAR_ID_FIELD.has_default_value = false
var_0_62.CHAR_ID_FIELD.default_value = 0
var_0_62.CHAR_ID_FIELD.type = 5
var_0_62.CHAR_ID_FIELD.cpp_type = 1
var_0_62.STEP_FIELD.name = "step"
var_0_62.STEP_FIELD.full_name = ".sgland.PlayerLadder.step"
var_0_62.STEP_FIELD.number = 3
var_0_62.STEP_FIELD.index = 2
var_0_62.STEP_FIELD.label = 2
var_0_62.STEP_FIELD.has_default_value = false
var_0_62.STEP_FIELD.default_value = 0
var_0_62.STEP_FIELD.type = 5
var_0_62.STEP_FIELD.cpp_type = 1
var_0_62.POOL_FIELD.name = "pool"
var_0_62.POOL_FIELD.full_name = ".sgland.PlayerLadder.pool"
var_0_62.POOL_FIELD.number = 4
var_0_62.POOL_FIELD.index = 3
var_0_62.POOL_FIELD.label = 3
var_0_62.POOL_FIELD.has_default_value = false
var_0_62.POOL_FIELD.default_value = {}
var_0_62.POOL_FIELD.type = 5
var_0_62.POOL_FIELD.cpp_type = 1
var_0_62.CARDS_FIELD.name = "cards"
var_0_62.CARDS_FIELD.full_name = ".sgland.PlayerLadder.cards"
var_0_62.CARDS_FIELD.number = 5
var_0_62.CARDS_FIELD.index = 4
var_0_62.CARDS_FIELD.label = 3
var_0_62.CARDS_FIELD.has_default_value = false
var_0_62.CARDS_FIELD.default_value = {}
var_0_62.CARDS_FIELD.message_type = RESOURCE
var_0_62.CARDS_FIELD.type = 11
var_0_62.CARDS_FIELD.cpp_type = 10
var_0_62.WIN_FIELD.name = "win"
var_0_62.WIN_FIELD.full_name = ".sgland.PlayerLadder.win"
var_0_62.WIN_FIELD.number = 6
var_0_62.WIN_FIELD.index = 5
var_0_62.WIN_FIELD.label = 2
var_0_62.WIN_FIELD.has_default_value = false
var_0_62.WIN_FIELD.default_value = 0
var_0_62.WIN_FIELD.type = 5
var_0_62.WIN_FIELD.cpp_type = 1
var_0_62.LOSE_FIELD.name = "lose"
var_0_62.LOSE_FIELD.full_name = ".sgland.PlayerLadder.lose"
var_0_62.LOSE_FIELD.number = 7
var_0_62.LOSE_FIELD.index = 6
var_0_62.LOSE_FIELD.label = 2
var_0_62.LOSE_FIELD.has_default_value = false
var_0_62.LOSE_FIELD.default_value = 0
var_0_62.LOSE_FIELD.type = 5
var_0_62.LOSE_FIELD.cpp_type = 1
var_0_62.CHEST_FIELD.name = "chest"
var_0_62.CHEST_FIELD.full_name = ".sgland.PlayerLadder.chest"
var_0_62.CHEST_FIELD.number = 8
var_0_62.CHEST_FIELD.index = 7
var_0_62.CHEST_FIELD.label = 1
var_0_62.CHEST_FIELD.has_default_value = false
var_0_62.CHEST_FIELD.default_value = nil
var_0_62.CHEST_FIELD.message_type = CHEST
var_0_62.CHEST_FIELD.type = 11
var_0_62.CHEST_FIELD.cpp_type = 10
var_0_62.CHARS_FIELD.name = "chars"
var_0_62.CHARS_FIELD.full_name = ".sgland.PlayerLadder.chars"
var_0_62.CHARS_FIELD.number = 9
var_0_62.CHARS_FIELD.index = 8
var_0_62.CHARS_FIELD.label = 3
var_0_62.CHARS_FIELD.has_default_value = false
var_0_62.CHARS_FIELD.default_value = {}
var_0_62.CHARS_FIELD.type = 5
var_0_62.CHARS_FIELD.cpp_type = 1
var_0_62.SELECTED_FIELD.name = "selected"
var_0_62.SELECTED_FIELD.full_name = ".sgland.PlayerLadder.selected"
var_0_62.SELECTED_FIELD.number = 10
var_0_62.SELECTED_FIELD.index = 9
var_0_62.SELECTED_FIELD.label = 3
var_0_62.SELECTED_FIELD.has_default_value = false
var_0_62.SELECTED_FIELD.default_value = {}
var_0_62.SELECTED_FIELD.type = 5
var_0_62.SELECTED_FIELD.cpp_type = 1
var_0_62.DAILY_WIN_FIELD.name = "daily_win"
var_0_62.DAILY_WIN_FIELD.full_name = ".sgland.PlayerLadder.daily_win"
var_0_62.DAILY_WIN_FIELD.number = 11
var_0_62.DAILY_WIN_FIELD.index = 10
var_0_62.DAILY_WIN_FIELD.label = 1
var_0_62.DAILY_WIN_FIELD.has_default_value = false
var_0_62.DAILY_WIN_FIELD.default_value = 0
var_0_62.DAILY_WIN_FIELD.type = 5
var_0_62.DAILY_WIN_FIELD.cpp_type = 1
var_0_62.ROLL_TIMES_FIELD.name = "roll_times"
var_0_62.ROLL_TIMES_FIELD.full_name = ".sgland.PlayerLadder.roll_times"
var_0_62.ROLL_TIMES_FIELD.number = 12
var_0_62.ROLL_TIMES_FIELD.index = 11
var_0_62.ROLL_TIMES_FIELD.label = 1
var_0_62.ROLL_TIMES_FIELD.has_default_value = false
var_0_62.ROLL_TIMES_FIELD.default_value = 0
var_0_62.ROLL_TIMES_FIELD.type = 5
var_0_62.ROLL_TIMES_FIELD.cpp_type = 1
var_0_62.USED_EXTRA_LOSE_TIMES_FIELD.name = "used_extra_lose_times"
var_0_62.USED_EXTRA_LOSE_TIMES_FIELD.full_name = ".sgland.PlayerLadder.used_extra_lose_times"
var_0_62.USED_EXTRA_LOSE_TIMES_FIELD.number = 13
var_0_62.USED_EXTRA_LOSE_TIMES_FIELD.index = 12
var_0_62.USED_EXTRA_LOSE_TIMES_FIELD.label = 1
var_0_62.USED_EXTRA_LOSE_TIMES_FIELD.has_default_value = false
var_0_62.USED_EXTRA_LOSE_TIMES_FIELD.default_value = 0
var_0_62.USED_EXTRA_LOSE_TIMES_FIELD.type = 5
var_0_62.USED_EXTRA_LOSE_TIMES_FIELD.cpp_type = 1
var_0_62.LEGEND_TICKET_FIELD.name = "legend_ticket"
var_0_62.LEGEND_TICKET_FIELD.full_name = ".sgland.PlayerLadder.legend_ticket"
var_0_62.LEGEND_TICKET_FIELD.number = 14
var_0_62.LEGEND_TICKET_FIELD.index = 13
var_0_62.LEGEND_TICKET_FIELD.label = 1
var_0_62.LEGEND_TICKET_FIELD.has_default_value = false
var_0_62.LEGEND_TICKET_FIELD.default_value = false
var_0_62.LEGEND_TICKET_FIELD.type = 8
var_0_62.LEGEND_TICKET_FIELD.cpp_type = 7
var_0_62.LEGEND_WIN_FIELD.name = "legend_win"
var_0_62.LEGEND_WIN_FIELD.full_name = ".sgland.PlayerLadder.legend_win"
var_0_62.LEGEND_WIN_FIELD.number = 15
var_0_62.LEGEND_WIN_FIELD.index = 14
var_0_62.LEGEND_WIN_FIELD.label = 1
var_0_62.LEGEND_WIN_FIELD.has_default_value = false
var_0_62.LEGEND_WIN_FIELD.default_value = 0
var_0_62.LEGEND_WIN_FIELD.type = 5
var_0_62.LEGEND_WIN_FIELD.cpp_type = 1
var_0_62.LEGEND_LOSE_FIELD.name = "legend_lose"
var_0_62.LEGEND_LOSE_FIELD.full_name = ".sgland.PlayerLadder.legend_lose"
var_0_62.LEGEND_LOSE_FIELD.number = 16
var_0_62.LEGEND_LOSE_FIELD.index = 15
var_0_62.LEGEND_LOSE_FIELD.label = 1
var_0_62.LEGEND_LOSE_FIELD.has_default_value = false
var_0_62.LEGEND_LOSE_FIELD.default_value = 0
var_0_62.LEGEND_LOSE_FIELD.type = 5
var_0_62.LEGEND_LOSE_FIELD.cpp_type = 1
var_0_62.DAILY_LEGEND_WIN_FIELD.name = "daily_legend_win"
var_0_62.DAILY_LEGEND_WIN_FIELD.full_name = ".sgland.PlayerLadder.daily_legend_win"
var_0_62.DAILY_LEGEND_WIN_FIELD.number = 17
var_0_62.DAILY_LEGEND_WIN_FIELD.index = 16
var_0_62.DAILY_LEGEND_WIN_FIELD.label = 1
var_0_62.DAILY_LEGEND_WIN_FIELD.has_default_value = false
var_0_62.DAILY_LEGEND_WIN_FIELD.default_value = 0
var_0_62.DAILY_LEGEND_WIN_FIELD.type = 5
var_0_62.DAILY_LEGEND_WIN_FIELD.cpp_type = 1
var_0_62.LEGEND_CHEST_FIELD.name = "legend_chest"
var_0_62.LEGEND_CHEST_FIELD.full_name = ".sgland.PlayerLadder.legend_chest"
var_0_62.LEGEND_CHEST_FIELD.number = 18
var_0_62.LEGEND_CHEST_FIELD.index = 17
var_0_62.LEGEND_CHEST_FIELD.label = 1
var_0_62.LEGEND_CHEST_FIELD.has_default_value = false
var_0_62.LEGEND_CHEST_FIELD.default_value = nil
var_0_62.LEGEND_CHEST_FIELD.message_type = CHEST
var_0_62.LEGEND_CHEST_FIELD.type = 11
var_0_62.LEGEND_CHEST_FIELD.cpp_type = 10
var_0_62.CHEAT_COUNT_FIELD.name = "cheat_count"
var_0_62.CHEAT_COUNT_FIELD.full_name = ".sgland.PlayerLadder.cheat_count"
var_0_62.CHEAT_COUNT_FIELD.number = 19
var_0_62.CHEAT_COUNT_FIELD.index = 18
var_0_62.CHEAT_COUNT_FIELD.label = 1
var_0_62.CHEAT_COUNT_FIELD.has_default_value = false
var_0_62.CHEAT_COUNT_FIELD.default_value = 0
var_0_62.CHEAT_COUNT_FIELD.type = 5
var_0_62.CHEAT_COUNT_FIELD.cpp_type = 1
PLAYERLADDER.name = "PlayerLadder"
PLAYERLADDER.full_name = ".sgland.PlayerLadder"
PLAYERLADDER.nested_types = {}
PLAYERLADDER.enum_types = {}
PLAYERLADDER.fields = {
	var_0_62.HAS_TICKET_FIELD,
	var_0_62.CHAR_ID_FIELD,
	var_0_62.STEP_FIELD,
	var_0_62.POOL_FIELD,
	var_0_62.CARDS_FIELD,
	var_0_62.WIN_FIELD,
	var_0_62.LOSE_FIELD,
	var_0_62.CHEST_FIELD,
	var_0_62.CHARS_FIELD,
	var_0_62.SELECTED_FIELD,
	var_0_62.DAILY_WIN_FIELD,
	var_0_62.ROLL_TIMES_FIELD,
	var_0_62.USED_EXTRA_LOSE_TIMES_FIELD,
	var_0_62.LEGEND_TICKET_FIELD,
	var_0_62.LEGEND_WIN_FIELD,
	var_0_62.LEGEND_LOSE_FIELD,
	var_0_62.DAILY_LEGEND_WIN_FIELD,
	var_0_62.LEGEND_CHEST_FIELD,
	var_0_62.CHEAT_COUNT_FIELD
}
PLAYERLADDER.is_extendable = false
PLAYERLADDER.extensions = {}
var_0_63.INNING_FIELD.name = "inning"
var_0_63.INNING_FIELD.full_name = ".sgland.PlayerDark.inning"
var_0_63.INNING_FIELD.number = 1
var_0_63.INNING_FIELD.index = 0
var_0_63.INNING_FIELD.label = 2
var_0_63.INNING_FIELD.has_default_value = false
var_0_63.INNING_FIELD.default_value = 0
var_0_63.INNING_FIELD.type = 5
var_0_63.INNING_FIELD.cpp_type = 1
var_0_63.SCORE_FIELD.name = "score"
var_0_63.SCORE_FIELD.full_name = ".sgland.PlayerDark.score"
var_0_63.SCORE_FIELD.number = 2
var_0_63.SCORE_FIELD.index = 1
var_0_63.SCORE_FIELD.label = 2
var_0_63.SCORE_FIELD.has_default_value = false
var_0_63.SCORE_FIELD.default_value = 0
var_0_63.SCORE_FIELD.type = 5
var_0_63.SCORE_FIELD.cpp_type = 1
var_0_63.WIN_FIELD.name = "win"
var_0_63.WIN_FIELD.full_name = ".sgland.PlayerDark.win"
var_0_63.WIN_FIELD.number = 3
var_0_63.WIN_FIELD.index = 2
var_0_63.WIN_FIELD.label = 2
var_0_63.WIN_FIELD.has_default_value = false
var_0_63.WIN_FIELD.default_value = 0
var_0_63.WIN_FIELD.type = 5
var_0_63.WIN_FIELD.cpp_type = 1
var_0_63.OPWIN_FIELD.name = "opWin"
var_0_63.OPWIN_FIELD.full_name = ".sgland.PlayerDark.opWin"
var_0_63.OPWIN_FIELD.number = 4
var_0_63.OPWIN_FIELD.index = 3
var_0_63.OPWIN_FIELD.label = 2
var_0_63.OPWIN_FIELD.has_default_value = false
var_0_63.OPWIN_FIELD.default_value = 0
var_0_63.OPWIN_FIELD.type = 5
var_0_63.OPWIN_FIELD.cpp_type = 1
PLAYERDARK.name = "PlayerDark"
PLAYERDARK.full_name = ".sgland.PlayerDark"
PLAYERDARK.nested_types = {}
PLAYERDARK.enum_types = {}
PLAYERDARK.fields = {
	var_0_63.INNING_FIELD,
	var_0_63.SCORE_FIELD,
	var_0_63.WIN_FIELD,
	var_0_63.OPWIN_FIELD
}
PLAYERDARK.is_extendable = false
PLAYERDARK.extensions = {}
var_0_64.HAS_TICKET_FIELD.name = "has_ticket"
var_0_64.HAS_TICKET_FIELD.full_name = ".sgland.PlayerSurvival.has_ticket"
var_0_64.HAS_TICKET_FIELD.number = 1
var_0_64.HAS_TICKET_FIELD.index = 0
var_0_64.HAS_TICKET_FIELD.label = 2
var_0_64.HAS_TICKET_FIELD.has_default_value = false
var_0_64.HAS_TICKET_FIELD.default_value = false
var_0_64.HAS_TICKET_FIELD.type = 8
var_0_64.HAS_TICKET_FIELD.cpp_type = 7
var_0_64.CHAR_ID_FIELD.name = "char_id"
var_0_64.CHAR_ID_FIELD.full_name = ".sgland.PlayerSurvival.char_id"
var_0_64.CHAR_ID_FIELD.number = 2
var_0_64.CHAR_ID_FIELD.index = 1
var_0_64.CHAR_ID_FIELD.label = 1
var_0_64.CHAR_ID_FIELD.has_default_value = false
var_0_64.CHAR_ID_FIELD.default_value = 0
var_0_64.CHAR_ID_FIELD.type = 5
var_0_64.CHAR_ID_FIELD.cpp_type = 1
var_0_64.STEP_FIELD.name = "step"
var_0_64.STEP_FIELD.full_name = ".sgland.PlayerSurvival.step"
var_0_64.STEP_FIELD.number = 3
var_0_64.STEP_FIELD.index = 2
var_0_64.STEP_FIELD.label = 2
var_0_64.STEP_FIELD.has_default_value = false
var_0_64.STEP_FIELD.default_value = 0
var_0_64.STEP_FIELD.type = 5
var_0_64.STEP_FIELD.cpp_type = 1
var_0_64.POOL_FIELD.name = "pool"
var_0_64.POOL_FIELD.full_name = ".sgland.PlayerSurvival.pool"
var_0_64.POOL_FIELD.number = 4
var_0_64.POOL_FIELD.index = 3
var_0_64.POOL_FIELD.label = 3
var_0_64.POOL_FIELD.has_default_value = false
var_0_64.POOL_FIELD.default_value = {}
var_0_64.POOL_FIELD.type = 5
var_0_64.POOL_FIELD.cpp_type = 1
var_0_64.CARDS_FIELD.name = "cards"
var_0_64.CARDS_FIELD.full_name = ".sgland.PlayerSurvival.cards"
var_0_64.CARDS_FIELD.number = 5
var_0_64.CARDS_FIELD.index = 4
var_0_64.CARDS_FIELD.label = 3
var_0_64.CARDS_FIELD.has_default_value = false
var_0_64.CARDS_FIELD.default_value = {}
var_0_64.CARDS_FIELD.message_type = RESOURCE
var_0_64.CARDS_FIELD.type = 11
var_0_64.CARDS_FIELD.cpp_type = 10
var_0_64.CHARS_FIELD.name = "chars"
var_0_64.CHARS_FIELD.full_name = ".sgland.PlayerSurvival.chars"
var_0_64.CHARS_FIELD.number = 6
var_0_64.CHARS_FIELD.index = 5
var_0_64.CHARS_FIELD.label = 3
var_0_64.CHARS_FIELD.has_default_value = false
var_0_64.CHARS_FIELD.default_value = {}
var_0_64.CHARS_FIELD.type = 5
var_0_64.CHARS_FIELD.cpp_type = 1
var_0_64.SELECTED_FIELD.name = "selected"
var_0_64.SELECTED_FIELD.full_name = ".sgland.PlayerSurvival.selected"
var_0_64.SELECTED_FIELD.number = 7
var_0_64.SELECTED_FIELD.index = 6
var_0_64.SELECTED_FIELD.label = 3
var_0_64.SELECTED_FIELD.has_default_value = false
var_0_64.SELECTED_FIELD.default_value = {}
var_0_64.SELECTED_FIELD.type = 5
var_0_64.SELECTED_FIELD.cpp_type = 1
var_0_64.CAPTURES_FIELD.name = "captures"
var_0_64.CAPTURES_FIELD.full_name = ".sgland.PlayerSurvival.captures"
var_0_64.CAPTURES_FIELD.number = 8
var_0_64.CAPTURES_FIELD.index = 7
var_0_64.CAPTURES_FIELD.label = 3
var_0_64.CAPTURES_FIELD.has_default_value = false
var_0_64.CAPTURES_FIELD.default_value = {}
var_0_64.CAPTURES_FIELD.message_type = RESOURCE
var_0_64.CAPTURES_FIELD.type = 11
var_0_64.CAPTURES_FIELD.cpp_type = 10
var_0_64.ADDRESS_FIELD.name = "address"
var_0_64.ADDRESS_FIELD.full_name = ".sgland.PlayerSurvival.address"
var_0_64.ADDRESS_FIELD.number = 9
var_0_64.ADDRESS_FIELD.index = 8
var_0_64.ADDRESS_FIELD.label = 1
var_0_64.ADDRESS_FIELD.has_default_value = false
var_0_64.ADDRESS_FIELD.default_value = ""
var_0_64.ADDRESS_FIELD.type = 9
var_0_64.ADDRESS_FIELD.cpp_type = 9
var_0_64.PRIVILEGE_STAMP_FIELD.name = "privilege_stamp"
var_0_64.PRIVILEGE_STAMP_FIELD.full_name = ".sgland.PlayerSurvival.privilege_stamp"
var_0_64.PRIVILEGE_STAMP_FIELD.number = 10
var_0_64.PRIVILEGE_STAMP_FIELD.index = 9
var_0_64.PRIVILEGE_STAMP_FIELD.label = 1
var_0_64.PRIVILEGE_STAMP_FIELD.has_default_value = false
var_0_64.PRIVILEGE_STAMP_FIELD.default_value = 0
var_0_64.PRIVILEGE_STAMP_FIELD.type = 3
var_0_64.PRIVILEGE_STAMP_FIELD.cpp_type = 2
PLAYERSURVIVAL.name = "PlayerSurvival"
PLAYERSURVIVAL.full_name = ".sgland.PlayerSurvival"
PLAYERSURVIVAL.nested_types = {}
PLAYERSURVIVAL.enum_types = {}
PLAYERSURVIVAL.fields = {
	var_0_64.HAS_TICKET_FIELD,
	var_0_64.CHAR_ID_FIELD,
	var_0_64.STEP_FIELD,
	var_0_64.POOL_FIELD,
	var_0_64.CARDS_FIELD,
	var_0_64.CHARS_FIELD,
	var_0_64.SELECTED_FIELD,
	var_0_64.CAPTURES_FIELD,
	var_0_64.ADDRESS_FIELD,
	var_0_64.PRIVILEGE_STAMP_FIELD
}
PLAYERSURVIVAL.is_extendable = false
PLAYERSURVIVAL.extensions = {}
var_0_65.CARD_FIELD.name = "card"
var_0_65.CARD_FIELD.full_name = ".sgland.SurvivalExSkill.card"
var_0_65.CARD_FIELD.number = 1
var_0_65.CARD_FIELD.index = 0
var_0_65.CARD_FIELD.label = 2
var_0_65.CARD_FIELD.has_default_value = false
var_0_65.CARD_FIELD.default_value = 0
var_0_65.CARD_FIELD.type = 5
var_0_65.CARD_FIELD.cpp_type = 1
var_0_65.SKILLS_FIELD.name = "skills"
var_0_65.SKILLS_FIELD.full_name = ".sgland.SurvivalExSkill.skills"
var_0_65.SKILLS_FIELD.number = 2
var_0_65.SKILLS_FIELD.index = 1
var_0_65.SKILLS_FIELD.label = 3
var_0_65.SKILLS_FIELD.has_default_value = false
var_0_65.SKILLS_FIELD.default_value = {}
var_0_65.SKILLS_FIELD.type = 3
var_0_65.SKILLS_FIELD.cpp_type = 2
SURVIVALEXSKILL.name = "SurvivalExSkill"
SURVIVALEXSKILL.full_name = ".sgland.SurvivalExSkill"
SURVIVALEXSKILL.nested_types = {}
SURVIVALEXSKILL.enum_types = {}
SURVIVALEXSKILL.fields = {
	var_0_65.CARD_FIELD,
	var_0_65.SKILLS_FIELD
}
SURVIVALEXSKILL.is_extendable = false
SURVIVALEXSKILL.extensions = {}
var_0_66.HAS_TICKET_FIELD.name = "has_ticket"
var_0_66.HAS_TICKET_FIELD.full_name = ".sgland.PlayerSurvivalEx.has_ticket"
var_0_66.HAS_TICKET_FIELD.number = 1
var_0_66.HAS_TICKET_FIELD.index = 0
var_0_66.HAS_TICKET_FIELD.label = 2
var_0_66.HAS_TICKET_FIELD.has_default_value = false
var_0_66.HAS_TICKET_FIELD.default_value = false
var_0_66.HAS_TICKET_FIELD.type = 8
var_0_66.HAS_TICKET_FIELD.cpp_type = 7
var_0_66.CHAR_ID_FIELD.name = "char_id"
var_0_66.CHAR_ID_FIELD.full_name = ".sgland.PlayerSurvivalEx.char_id"
var_0_66.CHAR_ID_FIELD.number = 2
var_0_66.CHAR_ID_FIELD.index = 1
var_0_66.CHAR_ID_FIELD.label = 1
var_0_66.CHAR_ID_FIELD.has_default_value = false
var_0_66.CHAR_ID_FIELD.default_value = 0
var_0_66.CHAR_ID_FIELD.type = 5
var_0_66.CHAR_ID_FIELD.cpp_type = 1
var_0_66.STEP_FIELD.name = "step"
var_0_66.STEP_FIELD.full_name = ".sgland.PlayerSurvivalEx.step"
var_0_66.STEP_FIELD.number = 3
var_0_66.STEP_FIELD.index = 2
var_0_66.STEP_FIELD.label = 2
var_0_66.STEP_FIELD.has_default_value = false
var_0_66.STEP_FIELD.default_value = 0
var_0_66.STEP_FIELD.type = 5
var_0_66.STEP_FIELD.cpp_type = 1
var_0_66.POOL_FIELD.name = "pool"
var_0_66.POOL_FIELD.full_name = ".sgland.PlayerSurvivalEx.pool"
var_0_66.POOL_FIELD.number = 4
var_0_66.POOL_FIELD.index = 3
var_0_66.POOL_FIELD.label = 3
var_0_66.POOL_FIELD.has_default_value = false
var_0_66.POOL_FIELD.default_value = {}
var_0_66.POOL_FIELD.type = 5
var_0_66.POOL_FIELD.cpp_type = 1
var_0_66.CARDS_FIELD.name = "cards"
var_0_66.CARDS_FIELD.full_name = ".sgland.PlayerSurvivalEx.cards"
var_0_66.CARDS_FIELD.number = 5
var_0_66.CARDS_FIELD.index = 4
var_0_66.CARDS_FIELD.label = 3
var_0_66.CARDS_FIELD.has_default_value = false
var_0_66.CARDS_FIELD.default_value = {}
var_0_66.CARDS_FIELD.message_type = RESOURCE
var_0_66.CARDS_FIELD.type = 11
var_0_66.CARDS_FIELD.cpp_type = 10
var_0_66.CHARS_FIELD.name = "chars"
var_0_66.CHARS_FIELD.full_name = ".sgland.PlayerSurvivalEx.chars"
var_0_66.CHARS_FIELD.number = 6
var_0_66.CHARS_FIELD.index = 5
var_0_66.CHARS_FIELD.label = 3
var_0_66.CHARS_FIELD.has_default_value = false
var_0_66.CHARS_FIELD.default_value = {}
var_0_66.CHARS_FIELD.type = 5
var_0_66.CHARS_FIELD.cpp_type = 1
var_0_66.SELECTED_FIELD.name = "selected"
var_0_66.SELECTED_FIELD.full_name = ".sgland.PlayerSurvivalEx.selected"
var_0_66.SELECTED_FIELD.number = 7
var_0_66.SELECTED_FIELD.index = 6
var_0_66.SELECTED_FIELD.label = 3
var_0_66.SELECTED_FIELD.has_default_value = false
var_0_66.SELECTED_FIELD.default_value = {}
var_0_66.SELECTED_FIELD.type = 5
var_0_66.SELECTED_FIELD.cpp_type = 1
var_0_66.CAPTURES_FIELD.name = "captures"
var_0_66.CAPTURES_FIELD.full_name = ".sgland.PlayerSurvivalEx.captures"
var_0_66.CAPTURES_FIELD.number = 8
var_0_66.CAPTURES_FIELD.index = 7
var_0_66.CAPTURES_FIELD.label = 3
var_0_66.CAPTURES_FIELD.has_default_value = false
var_0_66.CAPTURES_FIELD.default_value = {}
var_0_66.CAPTURES_FIELD.message_type = RESOURCE
var_0_66.CAPTURES_FIELD.type = 11
var_0_66.CAPTURES_FIELD.cpp_type = 10
var_0_66.ADDRESS_FIELD.name = "address"
var_0_66.ADDRESS_FIELD.full_name = ".sgland.PlayerSurvivalEx.address"
var_0_66.ADDRESS_FIELD.number = 9
var_0_66.ADDRESS_FIELD.index = 8
var_0_66.ADDRESS_FIELD.label = 1
var_0_66.ADDRESS_FIELD.has_default_value = false
var_0_66.ADDRESS_FIELD.default_value = ""
var_0_66.ADDRESS_FIELD.type = 9
var_0_66.ADDRESS_FIELD.cpp_type = 9
var_0_66.CAPTURE_SKILLS_FIELD.name = "capture_skills"
var_0_66.CAPTURE_SKILLS_FIELD.full_name = ".sgland.PlayerSurvivalEx.capture_skills"
var_0_66.CAPTURE_SKILLS_FIELD.number = 10
var_0_66.CAPTURE_SKILLS_FIELD.index = 9
var_0_66.CAPTURE_SKILLS_FIELD.label = 3
var_0_66.CAPTURE_SKILLS_FIELD.has_default_value = false
var_0_66.CAPTURE_SKILLS_FIELD.default_value = {}
var_0_66.CAPTURE_SKILLS_FIELD.message_type = SURVIVALEXSKILL
var_0_66.CAPTURE_SKILLS_FIELD.type = 11
var_0_66.CAPTURE_SKILLS_FIELD.cpp_type = 10
var_0_66.PRIVILEGE_STAMP_FIELD.name = "privilege_stamp"
var_0_66.PRIVILEGE_STAMP_FIELD.full_name = ".sgland.PlayerSurvivalEx.privilege_stamp"
var_0_66.PRIVILEGE_STAMP_FIELD.number = 11
var_0_66.PRIVILEGE_STAMP_FIELD.index = 10
var_0_66.PRIVILEGE_STAMP_FIELD.label = 1
var_0_66.PRIVILEGE_STAMP_FIELD.has_default_value = false
var_0_66.PRIVILEGE_STAMP_FIELD.default_value = 0
var_0_66.PRIVILEGE_STAMP_FIELD.type = 3
var_0_66.PRIVILEGE_STAMP_FIELD.cpp_type = 2
var_0_66.WIN_FIELD.name = "win"
var_0_66.WIN_FIELD.full_name = ".sgland.PlayerSurvivalEx.win"
var_0_66.WIN_FIELD.number = 12
var_0_66.WIN_FIELD.index = 11
var_0_66.WIN_FIELD.label = 1
var_0_66.WIN_FIELD.has_default_value = false
var_0_66.WIN_FIELD.default_value = 0
var_0_66.WIN_FIELD.type = 5
var_0_66.WIN_FIELD.cpp_type = 1
var_0_66.LOSE_FIELD.name = "lose"
var_0_66.LOSE_FIELD.full_name = ".sgland.PlayerSurvivalEx.lose"
var_0_66.LOSE_FIELD.number = 13
var_0_66.LOSE_FIELD.index = 12
var_0_66.LOSE_FIELD.label = 1
var_0_66.LOSE_FIELD.has_default_value = false
var_0_66.LOSE_FIELD.default_value = 0
var_0_66.LOSE_FIELD.type = 5
var_0_66.LOSE_FIELD.cpp_type = 1
var_0_66.TROPHY_FIELD.name = "trophy"
var_0_66.TROPHY_FIELD.full_name = ".sgland.PlayerSurvivalEx.trophy"
var_0_66.TROPHY_FIELD.number = 14
var_0_66.TROPHY_FIELD.index = 13
var_0_66.TROPHY_FIELD.label = 1
var_0_66.TROPHY_FIELD.has_default_value = false
var_0_66.TROPHY_FIELD.default_value = 0
var_0_66.TROPHY_FIELD.type = 5
var_0_66.TROPHY_FIELD.cpp_type = 1
var_0_66.ROLL_TIMES_FIELD.name = "roll_times"
var_0_66.ROLL_TIMES_FIELD.full_name = ".sgland.PlayerSurvivalEx.roll_times"
var_0_66.ROLL_TIMES_FIELD.number = 15
var_0_66.ROLL_TIMES_FIELD.index = 14
var_0_66.ROLL_TIMES_FIELD.label = 1
var_0_66.ROLL_TIMES_FIELD.has_default_value = false
var_0_66.ROLL_TIMES_FIELD.default_value = 0
var_0_66.ROLL_TIMES_FIELD.type = 5
var_0_66.ROLL_TIMES_FIELD.cpp_type = 1
PLAYERSURVIVALEX.name = "PlayerSurvivalEx"
PLAYERSURVIVALEX.full_name = ".sgland.PlayerSurvivalEx"
PLAYERSURVIVALEX.nested_types = {}
PLAYERSURVIVALEX.enum_types = {}
PLAYERSURVIVALEX.fields = {
	var_0_66.HAS_TICKET_FIELD,
	var_0_66.CHAR_ID_FIELD,
	var_0_66.STEP_FIELD,
	var_0_66.POOL_FIELD,
	var_0_66.CARDS_FIELD,
	var_0_66.CHARS_FIELD,
	var_0_66.SELECTED_FIELD,
	var_0_66.CAPTURES_FIELD,
	var_0_66.ADDRESS_FIELD,
	var_0_66.CAPTURE_SKILLS_FIELD,
	var_0_66.PRIVILEGE_STAMP_FIELD,
	var_0_66.WIN_FIELD,
	var_0_66.LOSE_FIELD,
	var_0_66.TROPHY_FIELD,
	var_0_66.ROLL_TIMES_FIELD
}
PLAYERSURVIVALEX.is_extendable = false
PLAYERSURVIVALEX.extensions = {}
var_0_67.TYPE_FIELD.name = "type"
var_0_67.TYPE_FIELD.full_name = ".sgland.BattleSpot.type"
var_0_67.TYPE_FIELD.number = 1
var_0_67.TYPE_FIELD.index = 0
var_0_67.TYPE_FIELD.label = 2
var_0_67.TYPE_FIELD.has_default_value = false
var_0_67.TYPE_FIELD.default_value = 0
var_0_67.TYPE_FIELD.type = 5
var_0_67.TYPE_FIELD.cpp_type = 1
var_0_67.PLAYER_TROOP_FIELD.name = "player_troop"
var_0_67.PLAYER_TROOP_FIELD.full_name = ".sgland.BattleSpot.player_troop"
var_0_67.PLAYER_TROOP_FIELD.number = 6
var_0_67.PLAYER_TROOP_FIELD.index = 1
var_0_67.PLAYER_TROOP_FIELD.label = 2
var_0_67.PLAYER_TROOP_FIELD.has_default_value = false
var_0_67.PLAYER_TROOP_FIELD.default_value = nil
var_0_67.PLAYER_TROOP_FIELD.message_type = TROOPDATA
var_0_67.PLAYER_TROOP_FIELD.type = 11
var_0_67.PLAYER_TROOP_FIELD.cpp_type = 10
var_0_67.OPPONENT_TROOP_FIELD.name = "opponent_troop"
var_0_67.OPPONENT_TROOP_FIELD.full_name = ".sgland.BattleSpot.opponent_troop"
var_0_67.OPPONENT_TROOP_FIELD.number = 7
var_0_67.OPPONENT_TROOP_FIELD.index = 2
var_0_67.OPPONENT_TROOP_FIELD.label = 2
var_0_67.OPPONENT_TROOP_FIELD.has_default_value = false
var_0_67.OPPONENT_TROOP_FIELD.default_value = nil
var_0_67.OPPONENT_TROOP_FIELD.message_type = TROOPDATA
var_0_67.OPPONENT_TROOP_FIELD.type = 11
var_0_67.OPPONENT_TROOP_FIELD.cpp_type = 10
var_0_67.PLAYER_USED_CARDS_FIELD.name = "player_used_cards"
var_0_67.PLAYER_USED_CARDS_FIELD.full_name = ".sgland.BattleSpot.player_used_cards"
var_0_67.PLAYER_USED_CARDS_FIELD.number = 8
var_0_67.PLAYER_USED_CARDS_FIELD.index = 3
var_0_67.PLAYER_USED_CARDS_FIELD.label = 3
var_0_67.PLAYER_USED_CARDS_FIELD.has_default_value = false
var_0_67.PLAYER_USED_CARDS_FIELD.default_value = {}
var_0_67.PLAYER_USED_CARDS_FIELD.type = 5
var_0_67.PLAYER_USED_CARDS_FIELD.cpp_type = 1
var_0_67.OPPONENT_USED_CARDS_FIELD.name = "opponent_used_cards"
var_0_67.OPPONENT_USED_CARDS_FIELD.full_name = ".sgland.BattleSpot.opponent_used_cards"
var_0_67.OPPONENT_USED_CARDS_FIELD.number = 9
var_0_67.OPPONENT_USED_CARDS_FIELD.index = 4
var_0_67.OPPONENT_USED_CARDS_FIELD.label = 3
var_0_67.OPPONENT_USED_CARDS_FIELD.has_default_value = false
var_0_67.OPPONENT_USED_CARDS_FIELD.default_value = {}
var_0_67.OPPONENT_USED_CARDS_FIELD.type = 5
var_0_67.OPPONENT_USED_CARDS_FIELD.cpp_type = 1
var_0_67.RANDOM_SEQ_FIELD.name = "random_seq"
var_0_67.RANDOM_SEQ_FIELD.full_name = ".sgland.BattleSpot.random_seq"
var_0_67.RANDOM_SEQ_FIELD.number = 10
var_0_67.RANDOM_SEQ_FIELD.index = 5
var_0_67.RANDOM_SEQ_FIELD.label = 3
var_0_67.RANDOM_SEQ_FIELD.has_default_value = false
var_0_67.RANDOM_SEQ_FIELD.default_value = {}
var_0_67.RANDOM_SEQ_FIELD.type = 5
var_0_67.RANDOM_SEQ_FIELD.cpp_type = 1
var_0_67.LEVEL_ID_FIELD.name = "level_id"
var_0_67.LEVEL_ID_FIELD.full_name = ".sgland.BattleSpot.level_id"
var_0_67.LEVEL_ID_FIELD.number = 11
var_0_67.LEVEL_ID_FIELD.index = 6
var_0_67.LEVEL_ID_FIELD.label = 1
var_0_67.LEVEL_ID_FIELD.has_default_value = false
var_0_67.LEVEL_ID_FIELD.default_value = 0
var_0_67.LEVEL_ID_FIELD.type = 5
var_0_67.LEVEL_ID_FIELD.cpp_type = 1
var_0_67.COPY_ID_FIELD.name = "copy_id"
var_0_67.COPY_ID_FIELD.full_name = ".sgland.BattleSpot.copy_id"
var_0_67.COPY_ID_FIELD.number = 12
var_0_67.COPY_ID_FIELD.index = 7
var_0_67.COPY_ID_FIELD.label = 1
var_0_67.COPY_ID_FIELD.has_default_value = false
var_0_67.COPY_ID_FIELD.default_value = 0
var_0_67.COPY_ID_FIELD.type = 5
var_0_67.COPY_ID_FIELD.cpp_type = 1
var_0_67.IS_OP_ONLINE_FIELD.name = "is_op_online"
var_0_67.IS_OP_ONLINE_FIELD.full_name = ".sgland.BattleSpot.is_op_online"
var_0_67.IS_OP_ONLINE_FIELD.number = 13
var_0_67.IS_OP_ONLINE_FIELD.index = 8
var_0_67.IS_OP_ONLINE_FIELD.label = 1
var_0_67.IS_OP_ONLINE_FIELD.has_default_value = false
var_0_67.IS_OP_ONLINE_FIELD.default_value = false
var_0_67.IS_OP_ONLINE_FIELD.type = 8
var_0_67.IS_OP_ONLINE_FIELD.cpp_type = 7
var_0_67.IS_OP_SKIP_FIELD.name = "is_op_skip"
var_0_67.IS_OP_SKIP_FIELD.full_name = ".sgland.BattleSpot.is_op_skip"
var_0_67.IS_OP_SKIP_FIELD.number = 14
var_0_67.IS_OP_SKIP_FIELD.index = 9
var_0_67.IS_OP_SKIP_FIELD.label = 1
var_0_67.IS_OP_SKIP_FIELD.has_default_value = false
var_0_67.IS_OP_SKIP_FIELD.default_value = false
var_0_67.IS_OP_SKIP_FIELD.type = 8
var_0_67.IS_OP_SKIP_FIELD.cpp_type = 7
var_0_67.IS_ATTACKER_FIELD.name = "is_attacker"
var_0_67.IS_ATTACKER_FIELD.full_name = ".sgland.BattleSpot.is_attacker"
var_0_67.IS_ATTACKER_FIELD.number = 15
var_0_67.IS_ATTACKER_FIELD.index = 10
var_0_67.IS_ATTACKER_FIELD.label = 2
var_0_67.IS_ATTACKER_FIELD.has_default_value = false
var_0_67.IS_ATTACKER_FIELD.default_value = false
var_0_67.IS_ATTACKER_FIELD.type = 8
var_0_67.IS_ATTACKER_FIELD.cpp_type = 7
var_0_67.PLAYER_PVP_SOLDIER_FIELD.name = "player_pvp_soldier"
var_0_67.PLAYER_PVP_SOLDIER_FIELD.full_name = ".sgland.BattleSpot.player_pvp_soldier"
var_0_67.PLAYER_PVP_SOLDIER_FIELD.number = 16
var_0_67.PLAYER_PVP_SOLDIER_FIELD.index = 11
var_0_67.PLAYER_PVP_SOLDIER_FIELD.label = 1
var_0_67.PLAYER_PVP_SOLDIER_FIELD.has_default_value = false
var_0_67.PLAYER_PVP_SOLDIER_FIELD.default_value = nil
var_0_67.PLAYER_PVP_SOLDIER_FIELD.message_type = RESOURCE
var_0_67.PLAYER_PVP_SOLDIER_FIELD.type = 11
var_0_67.PLAYER_PVP_SOLDIER_FIELD.cpp_type = 10
var_0_67.OPPONENT_PVP_SOLDIER_FIELD.name = "opponent_pvp_soldier"
var_0_67.OPPONENT_PVP_SOLDIER_FIELD.full_name = ".sgland.BattleSpot.opponent_pvp_soldier"
var_0_67.OPPONENT_PVP_SOLDIER_FIELD.number = 17
var_0_67.OPPONENT_PVP_SOLDIER_FIELD.index = 12
var_0_67.OPPONENT_PVP_SOLDIER_FIELD.label = 1
var_0_67.OPPONENT_PVP_SOLDIER_FIELD.has_default_value = false
var_0_67.OPPONENT_PVP_SOLDIER_FIELD.default_value = nil
var_0_67.OPPONENT_PVP_SOLDIER_FIELD.message_type = RESOURCE
var_0_67.OPPONENT_PVP_SOLDIER_FIELD.type = 11
var_0_67.OPPONENT_PVP_SOLDIER_FIELD.cpp_type = 10
var_0_67.BOSS_ID_FIELD.name = "boss_id"
var_0_67.BOSS_ID_FIELD.full_name = ".sgland.BattleSpot.boss_id"
var_0_67.BOSS_ID_FIELD.number = 18
var_0_67.BOSS_ID_FIELD.index = 13
var_0_67.BOSS_ID_FIELD.label = 1
var_0_67.BOSS_ID_FIELD.has_default_value = false
var_0_67.BOSS_ID_FIELD.default_value = 0
var_0_67.BOSS_ID_FIELD.type = 5
var_0_67.BOSS_ID_FIELD.cpp_type = 1
var_0_67.TIMESTAMP_FIELD.name = "timestamp"
var_0_67.TIMESTAMP_FIELD.full_name = ".sgland.BattleSpot.timestamp"
var_0_67.TIMESTAMP_FIELD.number = 19
var_0_67.TIMESTAMP_FIELD.index = 14
var_0_67.TIMESTAMP_FIELD.label = 1
var_0_67.TIMESTAMP_FIELD.has_default_value = false
var_0_67.TIMESTAMP_FIELD.default_value = 0
var_0_67.TIMESTAMP_FIELD.type = 3
var_0_67.TIMESTAMP_FIELD.cpp_type = 2
var_0_67.NPC_TYPE_FIELD.name = "npc_type"
var_0_67.NPC_TYPE_FIELD.full_name = ".sgland.BattleSpot.npc_type"
var_0_67.NPC_TYPE_FIELD.number = 20
var_0_67.NPC_TYPE_FIELD.index = 15
var_0_67.NPC_TYPE_FIELD.label = 1
var_0_67.NPC_TYPE_FIELD.has_default_value = false
var_0_67.NPC_TYPE_FIELD.default_value = 0
var_0_67.NPC_TYPE_FIELD.type = 5
var_0_67.NPC_TYPE_FIELD.cpp_type = 1
var_0_67.IS_WATCHER_FIELD.name = "is_watcher"
var_0_67.IS_WATCHER_FIELD.full_name = ".sgland.BattleSpot.is_watcher"
var_0_67.IS_WATCHER_FIELD.number = 21
var_0_67.IS_WATCHER_FIELD.index = 16
var_0_67.IS_WATCHER_FIELD.label = 1
var_0_67.IS_WATCHER_FIELD.has_default_value = true
var_0_67.IS_WATCHER_FIELD.default_value = false
var_0_67.IS_WATCHER_FIELD.type = 8
var_0_67.IS_WATCHER_FIELD.cpp_type = 7
var_0_67.PLAYER_TIMESTAMP_FIELD.name = "player_timestamp"
var_0_67.PLAYER_TIMESTAMP_FIELD.full_name = ".sgland.BattleSpot.player_timestamp"
var_0_67.PLAYER_TIMESTAMP_FIELD.number = 22
var_0_67.PLAYER_TIMESTAMP_FIELD.index = 17
var_0_67.PLAYER_TIMESTAMP_FIELD.label = 1
var_0_67.PLAYER_TIMESTAMP_FIELD.has_default_value = false
var_0_67.PLAYER_TIMESTAMP_FIELD.default_value = 0
var_0_67.PLAYER_TIMESTAMP_FIELD.type = 3
var_0_67.PLAYER_TIMESTAMP_FIELD.cpp_type = 2
var_0_67.OPPONENT_TIMESTAMP_FIELD.name = "opponent_timestamp"
var_0_67.OPPONENT_TIMESTAMP_FIELD.full_name = ".sgland.BattleSpot.opponent_timestamp"
var_0_67.OPPONENT_TIMESTAMP_FIELD.number = 23
var_0_67.OPPONENT_TIMESTAMP_FIELD.index = 18
var_0_67.OPPONENT_TIMESTAMP_FIELD.label = 1
var_0_67.OPPONENT_TIMESTAMP_FIELD.has_default_value = false
var_0_67.OPPONENT_TIMESTAMP_FIELD.default_value = 0
var_0_67.OPPONENT_TIMESTAMP_FIELD.type = 3
var_0_67.OPPONENT_TIMESTAMP_FIELD.cpp_type = 2
var_0_67.RULE_TYPE_FIELD.name = "rule_type"
var_0_67.RULE_TYPE_FIELD.full_name = ".sgland.BattleSpot.rule_type"
var_0_67.RULE_TYPE_FIELD.number = 24
var_0_67.RULE_TYPE_FIELD.index = 19
var_0_67.RULE_TYPE_FIELD.label = 1
var_0_67.RULE_TYPE_FIELD.has_default_value = false
var_0_67.RULE_TYPE_FIELD.default_value = 0
var_0_67.RULE_TYPE_FIELD.type = 5
var_0_67.RULE_TYPE_FIELD.cpp_type = 1
BATTLESPOT.name = "BattleSpot"
BATTLESPOT.full_name = ".sgland.BattleSpot"
BATTLESPOT.nested_types = {}
BATTLESPOT.enum_types = {}
BATTLESPOT.fields = {
	var_0_67.TYPE_FIELD,
	var_0_67.PLAYER_TROOP_FIELD,
	var_0_67.OPPONENT_TROOP_FIELD,
	var_0_67.PLAYER_USED_CARDS_FIELD,
	var_0_67.OPPONENT_USED_CARDS_FIELD,
	var_0_67.RANDOM_SEQ_FIELD,
	var_0_67.LEVEL_ID_FIELD,
	var_0_67.COPY_ID_FIELD,
	var_0_67.IS_OP_ONLINE_FIELD,
	var_0_67.IS_OP_SKIP_FIELD,
	var_0_67.IS_ATTACKER_FIELD,
	var_0_67.PLAYER_PVP_SOLDIER_FIELD,
	var_0_67.OPPONENT_PVP_SOLDIER_FIELD,
	var_0_67.BOSS_ID_FIELD,
	var_0_67.TIMESTAMP_FIELD,
	var_0_67.NPC_TYPE_FIELD,
	var_0_67.IS_WATCHER_FIELD,
	var_0_67.PLAYER_TIMESTAMP_FIELD,
	var_0_67.OPPONENT_TIMESTAMP_FIELD,
	var_0_67.RULE_TYPE_FIELD
}
BATTLESPOT.is_extendable = false
BATTLESPOT.extensions = {}
var_0_68.TYPE_FIELD.name = "type"
var_0_68.TYPE_FIELD.full_name = ".sgland.BattleResult.type"
var_0_68.TYPE_FIELD.number = 1
var_0_68.TYPE_FIELD.index = 0
var_0_68.TYPE_FIELD.label = 2
var_0_68.TYPE_FIELD.has_default_value = false
var_0_68.TYPE_FIELD.default_value = 0
var_0_68.TYPE_FIELD.type = 5
var_0_68.TYPE_FIELD.cpp_type = 1
var_0_68.TASK_RESULT_FIELD.name = "task_result"
var_0_68.TASK_RESULT_FIELD.full_name = ".sgland.BattleResult.task_result"
var_0_68.TASK_RESULT_FIELD.number = 2
var_0_68.TASK_RESULT_FIELD.index = 1
var_0_68.TASK_RESULT_FIELD.label = 3
var_0_68.TASK_RESULT_FIELD.has_default_value = false
var_0_68.TASK_RESULT_FIELD.default_value = {}
var_0_68.TASK_RESULT_FIELD.type = 8
var_0_68.TASK_RESULT_FIELD.cpp_type = 7
var_0_68.DAMAGE_FIELD.name = "damage"
var_0_68.DAMAGE_FIELD.full_name = ".sgland.BattleResult.damage"
var_0_68.DAMAGE_FIELD.number = 3
var_0_68.DAMAGE_FIELD.index = 2
var_0_68.DAMAGE_FIELD.label = 2
var_0_68.DAMAGE_FIELD.has_default_value = false
var_0_68.DAMAGE_FIELD.default_value = 0
var_0_68.DAMAGE_FIELD.type = 5
var_0_68.DAMAGE_FIELD.cpp_type = 1
var_0_68.HP_FIELD.name = "hp"
var_0_68.HP_FIELD.full_name = ".sgland.BattleResult.hp"
var_0_68.HP_FIELD.number = 4
var_0_68.HP_FIELD.index = 3
var_0_68.HP_FIELD.label = 2
var_0_68.HP_FIELD.has_default_value = false
var_0_68.HP_FIELD.default_value = 0
var_0_68.HP_FIELD.type = 5
var_0_68.HP_FIELD.cpp_type = 1
var_0_68.ASSISTANT_DAMAGE_FIELD.name = "assistant_damage"
var_0_68.ASSISTANT_DAMAGE_FIELD.full_name = ".sgland.BattleResult.assistant_damage"
var_0_68.ASSISTANT_DAMAGE_FIELD.number = 5
var_0_68.ASSISTANT_DAMAGE_FIELD.index = 4
var_0_68.ASSISTANT_DAMAGE_FIELD.label = 3
var_0_68.ASSISTANT_DAMAGE_FIELD.has_default_value = false
var_0_68.ASSISTANT_DAMAGE_FIELD.default_value = {}
var_0_68.ASSISTANT_DAMAGE_FIELD.type = 5
var_0_68.ASSISTANT_DAMAGE_FIELD.cpp_type = 1
var_0_68.ATK_SCORE_FIELD.name = "atk_score"
var_0_68.ATK_SCORE_FIELD.full_name = ".sgland.BattleResult.atk_score"
var_0_68.ATK_SCORE_FIELD.number = 6
var_0_68.ATK_SCORE_FIELD.index = 5
var_0_68.ATK_SCORE_FIELD.label = 2
var_0_68.ATK_SCORE_FIELD.has_default_value = false
var_0_68.ATK_SCORE_FIELD.default_value = 0
var_0_68.ATK_SCORE_FIELD.type = 5
var_0_68.ATK_SCORE_FIELD.cpp_type = 1
var_0_68.DEF_SCORE_FIELD.name = "def_score"
var_0_68.DEF_SCORE_FIELD.full_name = ".sgland.BattleResult.def_score"
var_0_68.DEF_SCORE_FIELD.number = 7
var_0_68.DEF_SCORE_FIELD.index = 6
var_0_68.DEF_SCORE_FIELD.label = 2
var_0_68.DEF_SCORE_FIELD.has_default_value = false
var_0_68.DEF_SCORE_FIELD.default_value = 0
var_0_68.DEF_SCORE_FIELD.type = 5
var_0_68.DEF_SCORE_FIELD.cpp_type = 1
var_0_68.ROUND_FIELD.name = "round"
var_0_68.ROUND_FIELD.full_name = ".sgland.BattleResult.round"
var_0_68.ROUND_FIELD.number = 8
var_0_68.ROUND_FIELD.index = 7
var_0_68.ROUND_FIELD.label = 2
var_0_68.ROUND_FIELD.has_default_value = false
var_0_68.ROUND_FIELD.default_value = 0
var_0_68.ROUND_FIELD.type = 5
var_0_68.ROUND_FIELD.cpp_type = 1
var_0_68.LOG_FIELD.name = "log"
var_0_68.LOG_FIELD.full_name = ".sgland.BattleResult.log"
var_0_68.LOG_FIELD.number = 9
var_0_68.LOG_FIELD.index = 8
var_0_68.LOG_FIELD.label = 2
var_0_68.LOG_FIELD.has_default_value = false
var_0_68.LOG_FIELD.default_value = ""
var_0_68.LOG_FIELD.type = 9
var_0_68.LOG_FIELD.cpp_type = 9
var_0_68.ATTACKER_STAT_FIELD.name = "attacker_stat"
var_0_68.ATTACKER_STAT_FIELD.full_name = ".sgland.BattleResult.attacker_stat"
var_0_68.ATTACKER_STAT_FIELD.number = 10
var_0_68.ATTACKER_STAT_FIELD.index = 9
var_0_68.ATTACKER_STAT_FIELD.label = 3
var_0_68.ATTACKER_STAT_FIELD.has_default_value = false
var_0_68.ATTACKER_STAT_FIELD.default_value = {}
var_0_68.ATTACKER_STAT_FIELD.type = 5
var_0_68.ATTACKER_STAT_FIELD.cpp_type = 1
var_0_68.DEFENDER_STAT_FIELD.name = "defender_stat"
var_0_68.DEFENDER_STAT_FIELD.full_name = ".sgland.BattleResult.defender_stat"
var_0_68.DEFENDER_STAT_FIELD.number = 11
var_0_68.DEFENDER_STAT_FIELD.index = 10
var_0_68.DEFENDER_STAT_FIELD.label = 3
var_0_68.DEFENDER_STAT_FIELD.has_default_value = false
var_0_68.DEFENDER_STAT_FIELD.default_value = {}
var_0_68.DEFENDER_STAT_FIELD.type = 5
var_0_68.DEFENDER_STAT_FIELD.cpp_type = 1
var_0_68.ATTACKER_BATTLE_PASS_FIELD.name = "attacker_battle_pass"
var_0_68.ATTACKER_BATTLE_PASS_FIELD.full_name = ".sgland.BattleResult.attacker_battle_pass"
var_0_68.ATTACKER_BATTLE_PASS_FIELD.number = 12
var_0_68.ATTACKER_BATTLE_PASS_FIELD.index = 11
var_0_68.ATTACKER_BATTLE_PASS_FIELD.label = 3
var_0_68.ATTACKER_BATTLE_PASS_FIELD.has_default_value = false
var_0_68.ATTACKER_BATTLE_PASS_FIELD.default_value = {}
var_0_68.ATTACKER_BATTLE_PASS_FIELD.type = 5
var_0_68.ATTACKER_BATTLE_PASS_FIELD.cpp_type = 1
var_0_68.DEFENDER_BATTLE_PASS_FIELD.name = "defender_battle_pass"
var_0_68.DEFENDER_BATTLE_PASS_FIELD.full_name = ".sgland.BattleResult.defender_battle_pass"
var_0_68.DEFENDER_BATTLE_PASS_FIELD.number = 13
var_0_68.DEFENDER_BATTLE_PASS_FIELD.index = 12
var_0_68.DEFENDER_BATTLE_PASS_FIELD.label = 3
var_0_68.DEFENDER_BATTLE_PASS_FIELD.has_default_value = false
var_0_68.DEFENDER_BATTLE_PASS_FIELD.default_value = {}
var_0_68.DEFENDER_BATTLE_PASS_FIELD.type = 5
var_0_68.DEFENDER_BATTLE_PASS_FIELD.cpp_type = 1
BATTLERESULT.name = "BattleResult"
BATTLERESULT.full_name = ".sgland.BattleResult"
BATTLERESULT.nested_types = {}
BATTLERESULT.enum_types = {}
BATTLERESULT.fields = {
	var_0_68.TYPE_FIELD,
	var_0_68.TASK_RESULT_FIELD,
	var_0_68.DAMAGE_FIELD,
	var_0_68.HP_FIELD,
	var_0_68.ASSISTANT_DAMAGE_FIELD,
	var_0_68.ATK_SCORE_FIELD,
	var_0_68.DEF_SCORE_FIELD,
	var_0_68.ROUND_FIELD,
	var_0_68.LOG_FIELD,
	var_0_68.ATTACKER_STAT_FIELD,
	var_0_68.DEFENDER_STAT_FIELD,
	var_0_68.ATTACKER_BATTLE_PASS_FIELD,
	var_0_68.DEFENDER_BATTLE_PASS_FIELD
}
BATTLERESULT.is_extendable = false
BATTLERESULT.extensions = {}
var_0_69.PROP_FIELD.name = "prop"
var_0_69.PROP_FIELD.full_name = ".sgland.AttachData.prop"
var_0_69.PROP_FIELD.number = 1
var_0_69.PROP_FIELD.index = 0
var_0_69.PROP_FIELD.label = 2
var_0_69.PROP_FIELD.has_default_value = false
var_0_69.PROP_FIELD.default_value = nil
var_0_69.PROP_FIELD.message_type = PLAYERPROP
var_0_69.PROP_FIELD.type = 11
var_0_69.PROP_FIELD.cpp_type = 10
var_0_69.SHOP_FIELD.name = "shop"
var_0_69.SHOP_FIELD.full_name = ".sgland.AttachData.shop"
var_0_69.SHOP_FIELD.number = 2
var_0_69.SHOP_FIELD.index = 1
var_0_69.SHOP_FIELD.label = 2
var_0_69.SHOP_FIELD.has_default_value = false
var_0_69.SHOP_FIELD.default_value = nil
var_0_69.SHOP_FIELD.message_type = PLAYERSHOP
var_0_69.SHOP_FIELD.type = 11
var_0_69.SHOP_FIELD.cpp_type = 10
var_0_69.BONUS_FIELD.name = "bonus"
var_0_69.BONUS_FIELD.full_name = ".sgland.AttachData.bonus"
var_0_69.BONUS_FIELD.number = 3
var_0_69.BONUS_FIELD.index = 2
var_0_69.BONUS_FIELD.label = 2
var_0_69.BONUS_FIELD.has_default_value = false
var_0_69.BONUS_FIELD.default_value = nil
var_0_69.BONUS_FIELD.message_type = PLAYERBONUS
var_0_69.BONUS_FIELD.type = 11
var_0_69.BONUS_FIELD.cpp_type = 10
var_0_69.COPY_FIELD.name = "copy"
var_0_69.COPY_FIELD.full_name = ".sgland.AttachData.copy"
var_0_69.COPY_FIELD.number = 4
var_0_69.COPY_FIELD.index = 3
var_0_69.COPY_FIELD.label = 2
var_0_69.COPY_FIELD.has_default_value = false
var_0_69.COPY_FIELD.default_value = nil
var_0_69.COPY_FIELD.message_type = PLAYERCOPY
var_0_69.COPY_FIELD.type = 11
var_0_69.COPY_FIELD.cpp_type = 10
var_0_69.ACTIVITY_FIELD.name = "activity"
var_0_69.ACTIVITY_FIELD.full_name = ".sgland.AttachData.activity"
var_0_69.ACTIVITY_FIELD.number = 5
var_0_69.ACTIVITY_FIELD.index = 4
var_0_69.ACTIVITY_FIELD.label = 2
var_0_69.ACTIVITY_FIELD.has_default_value = false
var_0_69.ACTIVITY_FIELD.default_value = nil
var_0_69.ACTIVITY_FIELD.message_type = PLAYERACTIVITY
var_0_69.ACTIVITY_FIELD.type = 11
var_0_69.ACTIVITY_FIELD.cpp_type = 10
var_0_69.CHARACTER_FIELD.name = "character"
var_0_69.CHARACTER_FIELD.full_name = ".sgland.AttachData.character"
var_0_69.CHARACTER_FIELD.number = 6
var_0_69.CHARACTER_FIELD.index = 5
var_0_69.CHARACTER_FIELD.label = 2
var_0_69.CHARACTER_FIELD.has_default_value = false
var_0_69.CHARACTER_FIELD.default_value = nil
var_0_69.CHARACTER_FIELD.message_type = PLAYERCHARACTER
var_0_69.CHARACTER_FIELD.type = 11
var_0_69.CHARACTER_FIELD.cpp_type = 10
var_0_69.LADDER_FIELD.name = "ladder"
var_0_69.LADDER_FIELD.full_name = ".sgland.AttachData.ladder"
var_0_69.LADDER_FIELD.number = 7
var_0_69.LADDER_FIELD.index = 6
var_0_69.LADDER_FIELD.label = 2
var_0_69.LADDER_FIELD.has_default_value = false
var_0_69.LADDER_FIELD.default_value = nil
var_0_69.LADDER_FIELD.message_type = PLAYERLADDER
var_0_69.LADDER_FIELD.type = 11
var_0_69.LADDER_FIELD.cpp_type = 10
var_0_69.DARK_FIELD.name = "dark"
var_0_69.DARK_FIELD.full_name = ".sgland.AttachData.dark"
var_0_69.DARK_FIELD.number = 8
var_0_69.DARK_FIELD.index = 7
var_0_69.DARK_FIELD.label = 2
var_0_69.DARK_FIELD.has_default_value = false
var_0_69.DARK_FIELD.default_value = nil
var_0_69.DARK_FIELD.message_type = PLAYERDARK
var_0_69.DARK_FIELD.type = 11
var_0_69.DARK_FIELD.cpp_type = 10
var_0_69.SURVIVAL_FIELD.name = "survival"
var_0_69.SURVIVAL_FIELD.full_name = ".sgland.AttachData.survival"
var_0_69.SURVIVAL_FIELD.number = 9
var_0_69.SURVIVAL_FIELD.index = 8
var_0_69.SURVIVAL_FIELD.label = 2
var_0_69.SURVIVAL_FIELD.has_default_value = false
var_0_69.SURVIVAL_FIELD.default_value = nil
var_0_69.SURVIVAL_FIELD.message_type = PLAYERSURVIVAL
var_0_69.SURVIVAL_FIELD.type = 11
var_0_69.SURVIVAL_FIELD.cpp_type = 10
var_0_69.SURVIVAL_EX_FIELD.name = "survival_ex"
var_0_69.SURVIVAL_EX_FIELD.full_name = ".sgland.AttachData.survival_ex"
var_0_69.SURVIVAL_EX_FIELD.number = 10
var_0_69.SURVIVAL_EX_FIELD.index = 9
var_0_69.SURVIVAL_EX_FIELD.label = 2
var_0_69.SURVIVAL_EX_FIELD.has_default_value = false
var_0_69.SURVIVAL_EX_FIELD.default_value = nil
var_0_69.SURVIVAL_EX_FIELD.message_type = PLAYERSURVIVALEX
var_0_69.SURVIVAL_EX_FIELD.type = 11
var_0_69.SURVIVAL_EX_FIELD.cpp_type = 10
ATTACHDATA.name = "AttachData"
ATTACHDATA.full_name = ".sgland.AttachData"
ATTACHDATA.nested_types = {}
ATTACHDATA.enum_types = {}
ATTACHDATA.fields = {
	var_0_69.PROP_FIELD,
	var_0_69.SHOP_FIELD,
	var_0_69.BONUS_FIELD,
	var_0_69.COPY_FIELD,
	var_0_69.ACTIVITY_FIELD,
	var_0_69.CHARACTER_FIELD,
	var_0_69.LADDER_FIELD,
	var_0_69.DARK_FIELD,
	var_0_69.SURVIVAL_FIELD,
	var_0_69.SURVIVAL_EX_FIELD
}
ATTACHDATA.is_extendable = false
ATTACHDATA.extensions = {}
var_0_70.INFO_FIELD.name = "info"
var_0_70.INFO_FIELD.full_name = ".sgland.UnionMini.info"
var_0_70.INFO_FIELD.number = 1
var_0_70.INFO_FIELD.index = 0
var_0_70.INFO_FIELD.label = 2
var_0_70.INFO_FIELD.has_default_value = false
var_0_70.INFO_FIELD.default_value = nil
var_0_70.INFO_FIELD.message_type = UNIONINFO
var_0_70.INFO_FIELD.type = 11
var_0_70.INFO_FIELD.cpp_type = 10
var_0_70.DATA_FIELD.name = "data"
var_0_70.DATA_FIELD.full_name = ".sgland.UnionMini.data"
var_0_70.DATA_FIELD.number = 2
var_0_70.DATA_FIELD.index = 1
var_0_70.DATA_FIELD.label = 2
var_0_70.DATA_FIELD.has_default_value = false
var_0_70.DATA_FIELD.default_value = nil
var_0_70.DATA_FIELD.message_type = PLAYERUNION
var_0_70.DATA_FIELD.type = 11
var_0_70.DATA_FIELD.cpp_type = 10
var_0_70.TECHS_FIELD.name = "techs"
var_0_70.TECHS_FIELD.full_name = ".sgland.UnionMini.techs"
var_0_70.TECHS_FIELD.number = 3
var_0_70.TECHS_FIELD.index = 2
var_0_70.TECHS_FIELD.label = 3
var_0_70.TECHS_FIELD.has_default_value = false
var_0_70.TECHS_FIELD.default_value = {}
var_0_70.TECHS_FIELD.message_type = TECH
var_0_70.TECHS_FIELD.type = 11
var_0_70.TECHS_FIELD.cpp_type = 10
UNIONMINI.name = "UnionMini"
UNIONMINI.full_name = ".sgland.UnionMini"
UNIONMINI.nested_types = {}
UNIONMINI.enum_types = {}
UNIONMINI.fields = {
	var_0_70.INFO_FIELD,
	var_0_70.DATA_FIELD,
	var_0_70.TECHS_FIELD
}
UNIONMINI.is_extendable = false
UNIONMINI.extensions = {}
var_0_71.ID_FIELD.name = "id"
var_0_71.ID_FIELD.full_name = ".sgland.Contestant.id"
var_0_71.ID_FIELD.number = 1
var_0_71.ID_FIELD.index = 0
var_0_71.ID_FIELD.label = 2
var_0_71.ID_FIELD.has_default_value = false
var_0_71.ID_FIELD.default_value = 0
var_0_71.ID_FIELD.type = 3
var_0_71.ID_FIELD.cpp_type = 2
var_0_71.INFO_FIELD.name = "info"
var_0_71.INFO_FIELD.full_name = ".sgland.Contestant.info"
var_0_71.INFO_FIELD.number = 2
var_0_71.INFO_FIELD.index = 1
var_0_71.INFO_FIELD.label = 2
var_0_71.INFO_FIELD.has_default_value = false
var_0_71.INFO_FIELD.default_value = nil
var_0_71.INFO_FIELD.message_type = USERINFO
var_0_71.INFO_FIELD.type = 11
var_0_71.INFO_FIELD.cpp_type = 10
var_0_71.WIN_FIELD.name = "win"
var_0_71.WIN_FIELD.full_name = ".sgland.Contestant.win"
var_0_71.WIN_FIELD.number = 3
var_0_71.WIN_FIELD.index = 2
var_0_71.WIN_FIELD.label = 1
var_0_71.WIN_FIELD.has_default_value = false
var_0_71.WIN_FIELD.default_value = 0
var_0_71.WIN_FIELD.type = 5
var_0_71.WIN_FIELD.cpp_type = 1
var_0_71.TROOP_IDS_FIELD.name = "troop_ids"
var_0_71.TROOP_IDS_FIELD.full_name = ".sgland.Contestant.troop_ids"
var_0_71.TROOP_IDS_FIELD.number = 4
var_0_71.TROOP_IDS_FIELD.index = 3
var_0_71.TROOP_IDS_FIELD.label = 3
var_0_71.TROOP_IDS_FIELD.has_default_value = false
var_0_71.TROOP_IDS_FIELD.default_value = {}
var_0_71.TROOP_IDS_FIELD.type = 5
var_0_71.TROOP_IDS_FIELD.cpp_type = 1
var_0_71.CUR_TROOP_ID_FIELD.name = "cur_troop_id"
var_0_71.CUR_TROOP_ID_FIELD.full_name = ".sgland.Contestant.cur_troop_id"
var_0_71.CUR_TROOP_ID_FIELD.number = 5
var_0_71.CUR_TROOP_ID_FIELD.index = 4
var_0_71.CUR_TROOP_ID_FIELD.label = 1
var_0_71.CUR_TROOP_ID_FIELD.has_default_value = false
var_0_71.CUR_TROOP_ID_FIELD.default_value = 0
var_0_71.CUR_TROOP_ID_FIELD.type = 5
var_0_71.CUR_TROOP_ID_FIELD.cpp_type = 1
var_0_71.IS_ONLINE_FIELD.name = "is_online"
var_0_71.IS_ONLINE_FIELD.full_name = ".sgland.Contestant.is_online"
var_0_71.IS_ONLINE_FIELD.number = 6
var_0_71.IS_ONLINE_FIELD.index = 5
var_0_71.IS_ONLINE_FIELD.label = 1
var_0_71.IS_ONLINE_FIELD.has_default_value = false
var_0_71.IS_ONLINE_FIELD.default_value = false
var_0_71.IS_ONLINE_FIELD.type = 8
var_0_71.IS_ONLINE_FIELD.cpp_type = 7
CONTESTANT.name = "Contestant"
CONTESTANT.full_name = ".sgland.Contestant"
CONTESTANT.nested_types = {}
CONTESTANT.enum_types = {}
CONTESTANT.fields = {
	var_0_71.ID_FIELD,
	var_0_71.INFO_FIELD,
	var_0_71.WIN_FIELD,
	var_0_71.TROOP_IDS_FIELD,
	var_0_71.CUR_TROOP_ID_FIELD,
	var_0_71.IS_ONLINE_FIELD
}
CONTESTANT.is_extendable = false
CONTESTANT.extensions = {}
var_0_72.ID_FIELD.name = "id"
var_0_72.ID_FIELD.full_name = ".sgland.Match.id"
var_0_72.ID_FIELD.number = 1
var_0_72.ID_FIELD.index = 0
var_0_72.ID_FIELD.label = 2
var_0_72.ID_FIELD.has_default_value = false
var_0_72.ID_FIELD.default_value = 0
var_0_72.ID_FIELD.type = 5
var_0_72.ID_FIELD.cpp_type = 1
var_0_72.CREATOR_FIELD.name = "creator"
var_0_72.CREATOR_FIELD.full_name = ".sgland.Match.creator"
var_0_72.CREATOR_FIELD.number = 2
var_0_72.CREATOR_FIELD.index = 1
var_0_72.CREATOR_FIELD.label = 2
var_0_72.CREATOR_FIELD.has_default_value = false
var_0_72.CREATOR_FIELD.default_value = nil
var_0_72.CREATOR_FIELD.message_type = CONTESTANT
var_0_72.CREATOR_FIELD.type = 11
var_0_72.CREATOR_FIELD.cpp_type = 10
var_0_72.PLAYERO_FIELD.name = "playerO"
var_0_72.PLAYERO_FIELD.full_name = ".sgland.Match.playerO"
var_0_72.PLAYERO_FIELD.number = 3
var_0_72.PLAYERO_FIELD.index = 2
var_0_72.PLAYERO_FIELD.label = 1
var_0_72.PLAYERO_FIELD.has_default_value = false
var_0_72.PLAYERO_FIELD.default_value = nil
var_0_72.PLAYERO_FIELD.message_type = CONTESTANT
var_0_72.PLAYERO_FIELD.type = 11
var_0_72.PLAYERO_FIELD.cpp_type = 10
var_0_72.PLAYERA_FIELD.name = "playerA"
var_0_72.PLAYERA_FIELD.full_name = ".sgland.Match.playerA"
var_0_72.PLAYERA_FIELD.number = 4
var_0_72.PLAYERA_FIELD.index = 3
var_0_72.PLAYERA_FIELD.label = 1
var_0_72.PLAYERA_FIELD.has_default_value = false
var_0_72.PLAYERA_FIELD.default_value = nil
var_0_72.PLAYERA_FIELD.message_type = CONTESTANT
var_0_72.PLAYERA_FIELD.type = 11
var_0_72.PLAYERA_FIELD.cpp_type = 10
var_0_72.PLAYERB_FIELD.name = "playerB"
var_0_72.PLAYERB_FIELD.full_name = ".sgland.Match.playerB"
var_0_72.PLAYERB_FIELD.number = 5
var_0_72.PLAYERB_FIELD.index = 4
var_0_72.PLAYERB_FIELD.label = 1
var_0_72.PLAYERB_FIELD.has_default_value = false
var_0_72.PLAYERB_FIELD.default_value = nil
var_0_72.PLAYERB_FIELD.message_type = CONTESTANT
var_0_72.PLAYERB_FIELD.type = 11
var_0_72.PLAYERB_FIELD.cpp_type = 10
var_0_72.USER_ID_FIELD.name = "user_id"
var_0_72.USER_ID_FIELD.full_name = ".sgland.Match.user_id"
var_0_72.USER_ID_FIELD.number = 6
var_0_72.USER_ID_FIELD.index = 5
var_0_72.USER_ID_FIELD.label = 2
var_0_72.USER_ID_FIELD.has_default_value = false
var_0_72.USER_ID_FIELD.default_value = 0
var_0_72.USER_ID_FIELD.type = 3
var_0_72.USER_ID_FIELD.cpp_type = 2
var_0_72.TYPE_FIELD.name = "type"
var_0_72.TYPE_FIELD.full_name = ".sgland.Match.type"
var_0_72.TYPE_FIELD.number = 7
var_0_72.TYPE_FIELD.index = 6
var_0_72.TYPE_FIELD.label = 1
var_0_72.TYPE_FIELD.has_default_value = false
var_0_72.TYPE_FIELD.default_value = nil
var_0_72.TYPE_FIELD.enum_type = MATCHTYPE
var_0_72.TYPE_FIELD.type = 14
var_0_72.TYPE_FIELD.cpp_type = 8
var_0_72.MATCH_HP_FIELD.name = "match_hp"
var_0_72.MATCH_HP_FIELD.full_name = ".sgland.Match.match_hp"
var_0_72.MATCH_HP_FIELD.number = 8
var_0_72.MATCH_HP_FIELD.index = 7
var_0_72.MATCH_HP_FIELD.label = 1
var_0_72.MATCH_HP_FIELD.has_default_value = false
var_0_72.MATCH_HP_FIELD.default_value = 0
var_0_72.MATCH_HP_FIELD.type = 5
var_0_72.MATCH_HP_FIELD.cpp_type = 1
MATCH.name = "Match"
MATCH.full_name = ".sgland.Match"
MATCH.nested_types = {}
MATCH.enum_types = {}
MATCH.fields = {
	var_0_72.ID_FIELD,
	var_0_72.CREATOR_FIELD,
	var_0_72.PLAYERO_FIELD,
	var_0_72.PLAYERA_FIELD,
	var_0_72.PLAYERB_FIELD,
	var_0_72.USER_ID_FIELD,
	var_0_72.TYPE_FIELD,
	var_0_72.MATCH_HP_FIELD
}
MATCH.is_extendable = false
MATCH.extensions = {}
var_0_73.ID_FIELD.name = "id"
var_0_73.ID_FIELD.full_name = ".sgland.MatchInfo.id"
var_0_73.ID_FIELD.number = 1
var_0_73.ID_FIELD.index = 0
var_0_73.ID_FIELD.label = 2
var_0_73.ID_FIELD.has_default_value = false
var_0_73.ID_FIELD.default_value = 0
var_0_73.ID_FIELD.type = 5
var_0_73.ID_FIELD.cpp_type = 1
var_0_73.ADDRESS_FIELD.name = "address"
var_0_73.ADDRESS_FIELD.full_name = ".sgland.MatchInfo.address"
var_0_73.ADDRESS_FIELD.number = 2
var_0_73.ADDRESS_FIELD.index = 1
var_0_73.ADDRESS_FIELD.label = 2
var_0_73.ADDRESS_FIELD.has_default_value = false
var_0_73.ADDRESS_FIELD.default_value = ""
var_0_73.ADDRESS_FIELD.type = 9
var_0_73.ADDRESS_FIELD.cpp_type = 9
var_0_73.TYPE_FIELD.name = "type"
var_0_73.TYPE_FIELD.full_name = ".sgland.MatchInfo.type"
var_0_73.TYPE_FIELD.number = 3
var_0_73.TYPE_FIELD.index = 2
var_0_73.TYPE_FIELD.label = 2
var_0_73.TYPE_FIELD.has_default_value = true
var_0_73.TYPE_FIELD.default_value = PB_TYPE_NORMAL
var_0_73.TYPE_FIELD.enum_type = MATCHTYPE
var_0_73.TYPE_FIELD.type = 14
var_0_73.TYPE_FIELD.cpp_type = 8
MATCHINFO.name = "MatchInfo"
MATCHINFO.full_name = ".sgland.MatchInfo"
MATCHINFO.nested_types = {}
MATCHINFO.enum_types = {}
MATCHINFO.fields = {
	var_0_73.ID_FIELD,
	var_0_73.ADDRESS_FIELD,
	var_0_73.TYPE_FIELD
}
MATCHINFO.is_extendable = false
MATCHINFO.extensions = {}
var_0_74.ID_FIELD.name = "id"
var_0_74.ID_FIELD.full_name = ".sgland.SurvivalHall.id"
var_0_74.ID_FIELD.number = 1
var_0_74.ID_FIELD.index = 0
var_0_74.ID_FIELD.label = 2
var_0_74.ID_FIELD.has_default_value = false
var_0_74.ID_FIELD.default_value = 0
var_0_74.ID_FIELD.type = 5
var_0_74.ID_FIELD.cpp_type = 1
SURVIVALHALL.name = "SurvivalHall"
SURVIVALHALL.full_name = ".sgland.SurvivalHall"
SURVIVALHALL.nested_types = {}
SURVIVALHALL.enum_types = {}
SURVIVALHALL.fields = {
	var_0_74.ID_FIELD
}
SURVIVALHALL.is_extendable = false
SURVIVALHALL.extensions = {}
var_0_75.ID_FIELD.name = "id"
var_0_75.ID_FIELD.full_name = ".sgland.SurvivalHallInfo.id"
var_0_75.ID_FIELD.number = 1
var_0_75.ID_FIELD.index = 0
var_0_75.ID_FIELD.label = 1
var_0_75.ID_FIELD.has_default_value = false
var_0_75.ID_FIELD.default_value = 0
var_0_75.ID_FIELD.type = 5
var_0_75.ID_FIELD.cpp_type = 1
var_0_75.NUM_FIELD.name = "num"
var_0_75.NUM_FIELD.full_name = ".sgland.SurvivalHallInfo.num"
var_0_75.NUM_FIELD.number = 2
var_0_75.NUM_FIELD.index = 1
var_0_75.NUM_FIELD.label = 2
var_0_75.NUM_FIELD.has_default_value = false
var_0_75.NUM_FIELD.default_value = 0
var_0_75.NUM_FIELD.type = 5
var_0_75.NUM_FIELD.cpp_type = 1
var_0_75.ADDRESS_FIELD.name = "address"
var_0_75.ADDRESS_FIELD.full_name = ".sgland.SurvivalHallInfo.address"
var_0_75.ADDRESS_FIELD.number = 3
var_0_75.ADDRESS_FIELD.index = 2
var_0_75.ADDRESS_FIELD.label = 1
var_0_75.ADDRESS_FIELD.has_default_value = false
var_0_75.ADDRESS_FIELD.default_value = ""
var_0_75.ADDRESS_FIELD.type = 9
var_0_75.ADDRESS_FIELD.cpp_type = 9
var_0_75.GAMEOVER_TIMESTAMP_FIELD.name = "gameover_timestamp"
var_0_75.GAMEOVER_TIMESTAMP_FIELD.full_name = ".sgland.SurvivalHallInfo.gameover_timestamp"
var_0_75.GAMEOVER_TIMESTAMP_FIELD.number = 4
var_0_75.GAMEOVER_TIMESTAMP_FIELD.index = 3
var_0_75.GAMEOVER_TIMESTAMP_FIELD.label = 1
var_0_75.GAMEOVER_TIMESTAMP_FIELD.has_default_value = false
var_0_75.GAMEOVER_TIMESTAMP_FIELD.default_value = 0
var_0_75.GAMEOVER_TIMESTAMP_FIELD.type = 3
var_0_75.GAMEOVER_TIMESTAMP_FIELD.cpp_type = 2
var_0_75.IS_IN_HALL_FIELD.name = "is_in_hall"
var_0_75.IS_IN_HALL_FIELD.full_name = ".sgland.SurvivalHallInfo.is_in_hall"
var_0_75.IS_IN_HALL_FIELD.number = 5
var_0_75.IS_IN_HALL_FIELD.index = 4
var_0_75.IS_IN_HALL_FIELD.label = 1
var_0_75.IS_IN_HALL_FIELD.has_default_value = false
var_0_75.IS_IN_HALL_FIELD.default_value = false
var_0_75.IS_IN_HALL_FIELD.type = 8
var_0_75.IS_IN_HALL_FIELD.cpp_type = 7
SURVIVALHALLINFO.name = "SurvivalHallInfo"
SURVIVALHALLINFO.full_name = ".sgland.SurvivalHallInfo"
SURVIVALHALLINFO.nested_types = {}
SURVIVALHALLINFO.enum_types = {}
SURVIVALHALLINFO.fields = {
	var_0_75.ID_FIELD,
	var_0_75.NUM_FIELD,
	var_0_75.ADDRESS_FIELD,
	var_0_75.GAMEOVER_TIMESTAMP_FIELD,
	var_0_75.IS_IN_HALL_FIELD
}
SURVIVALHALLINFO.is_extendable = false
SURVIVALHALLINFO.extensions = {}
var_0_76.ID_FIELD.name = "id"
var_0_76.ID_FIELD.full_name = ".sgland.SurvivalExHall.id"
var_0_76.ID_FIELD.number = 1
var_0_76.ID_FIELD.index = 0
var_0_76.ID_FIELD.label = 2
var_0_76.ID_FIELD.has_default_value = false
var_0_76.ID_FIELD.default_value = 0
var_0_76.ID_FIELD.type = 5
var_0_76.ID_FIELD.cpp_type = 1
SURVIVALEXHALL.name = "SurvivalExHall"
SURVIVALEXHALL.full_name = ".sgland.SurvivalExHall"
SURVIVALEXHALL.nested_types = {}
SURVIVALEXHALL.enum_types = {}
SURVIVALEXHALL.fields = {
	var_0_76.ID_FIELD
}
SURVIVALEXHALL.is_extendable = false
SURVIVALEXHALL.extensions = {}
var_0_77.ID_FIELD.name = "id"
var_0_77.ID_FIELD.full_name = ".sgland.SurvivalExHallInfo.id"
var_0_77.ID_FIELD.number = 1
var_0_77.ID_FIELD.index = 0
var_0_77.ID_FIELD.label = 1
var_0_77.ID_FIELD.has_default_value = false
var_0_77.ID_FIELD.default_value = 0
var_0_77.ID_FIELD.type = 5
var_0_77.ID_FIELD.cpp_type = 1
var_0_77.NUM_FIELD.name = "num"
var_0_77.NUM_FIELD.full_name = ".sgland.SurvivalExHallInfo.num"
var_0_77.NUM_FIELD.number = 2
var_0_77.NUM_FIELD.index = 1
var_0_77.NUM_FIELD.label = 2
var_0_77.NUM_FIELD.has_default_value = false
var_0_77.NUM_FIELD.default_value = 0
var_0_77.NUM_FIELD.type = 5
var_0_77.NUM_FIELD.cpp_type = 1
var_0_77.ADDRESS_FIELD.name = "address"
var_0_77.ADDRESS_FIELD.full_name = ".sgland.SurvivalExHallInfo.address"
var_0_77.ADDRESS_FIELD.number = 3
var_0_77.ADDRESS_FIELD.index = 2
var_0_77.ADDRESS_FIELD.label = 1
var_0_77.ADDRESS_FIELD.has_default_value = false
var_0_77.ADDRESS_FIELD.default_value = ""
var_0_77.ADDRESS_FIELD.type = 9
var_0_77.ADDRESS_FIELD.cpp_type = 9
var_0_77.GAMEOVER_TIMESTAMP_FIELD.name = "gameover_timestamp"
var_0_77.GAMEOVER_TIMESTAMP_FIELD.full_name = ".sgland.SurvivalExHallInfo.gameover_timestamp"
var_0_77.GAMEOVER_TIMESTAMP_FIELD.number = 4
var_0_77.GAMEOVER_TIMESTAMP_FIELD.index = 3
var_0_77.GAMEOVER_TIMESTAMP_FIELD.label = 1
var_0_77.GAMEOVER_TIMESTAMP_FIELD.has_default_value = false
var_0_77.GAMEOVER_TIMESTAMP_FIELD.default_value = 0
var_0_77.GAMEOVER_TIMESTAMP_FIELD.type = 3
var_0_77.GAMEOVER_TIMESTAMP_FIELD.cpp_type = 2
var_0_77.IS_IN_HALL_FIELD.name = "is_in_hall"
var_0_77.IS_IN_HALL_FIELD.full_name = ".sgland.SurvivalExHallInfo.is_in_hall"
var_0_77.IS_IN_HALL_FIELD.number = 5
var_0_77.IS_IN_HALL_FIELD.index = 4
var_0_77.IS_IN_HALL_FIELD.label = 1
var_0_77.IS_IN_HALL_FIELD.has_default_value = false
var_0_77.IS_IN_HALL_FIELD.default_value = false
var_0_77.IS_IN_HALL_FIELD.type = 8
var_0_77.IS_IN_HALL_FIELD.cpp_type = 7
var_0_77.START_TIMESTAMP_FIELD.name = "start_timestamp"
var_0_77.START_TIMESTAMP_FIELD.full_name = ".sgland.SurvivalExHallInfo.start_timestamp"
var_0_77.START_TIMESTAMP_FIELD.number = 6
var_0_77.START_TIMESTAMP_FIELD.index = 5
var_0_77.START_TIMESTAMP_FIELD.label = 1
var_0_77.START_TIMESTAMP_FIELD.has_default_value = false
var_0_77.START_TIMESTAMP_FIELD.default_value = 0
var_0_77.START_TIMESTAMP_FIELD.type = 3
var_0_77.START_TIMESTAMP_FIELD.cpp_type = 2
SURVIVALEXHALLINFO.name = "SurvivalExHallInfo"
SURVIVALEXHALLINFO.full_name = ".sgland.SurvivalExHallInfo"
SURVIVALEXHALLINFO.nested_types = {}
SURVIVALEXHALLINFO.enum_types = {}
SURVIVALEXHALLINFO.fields = {
	var_0_77.ID_FIELD,
	var_0_77.NUM_FIELD,
	var_0_77.ADDRESS_FIELD,
	var_0_77.GAMEOVER_TIMESTAMP_FIELD,
	var_0_77.IS_IN_HALL_FIELD,
	var_0_77.START_TIMESTAMP_FIELD
}
SURVIVALEXHALLINFO.is_extendable = false
SURVIVALEXHALLINFO.extensions = {}
var_0_78.RID_FIELD.name = "rid"
var_0_78.RID_FIELD.full_name = ".sgland.Team.rid"
var_0_78.RID_FIELD.number = 1
var_0_78.RID_FIELD.index = 0
var_0_78.RID_FIELD.label = 2
var_0_78.RID_FIELD.has_default_value = false
var_0_78.RID_FIELD.default_value = 0
var_0_78.RID_FIELD.type = 5
var_0_78.RID_FIELD.cpp_type = 1
var_0_78.ID_FIELD.name = "id"
var_0_78.ID_FIELD.full_name = ".sgland.Team.id"
var_0_78.ID_FIELD.number = 2
var_0_78.ID_FIELD.index = 1
var_0_78.ID_FIELD.label = 2
var_0_78.ID_FIELD.has_default_value = false
var_0_78.ID_FIELD.default_value = 0
var_0_78.ID_FIELD.type = 3
var_0_78.ID_FIELD.cpp_type = 2
var_0_78.NAME_FIELD.name = "name"
var_0_78.NAME_FIELD.full_name = ".sgland.Team.name"
var_0_78.NAME_FIELD.number = 3
var_0_78.NAME_FIELD.index = 2
var_0_78.NAME_FIELD.label = 2
var_0_78.NAME_FIELD.has_default_value = false
var_0_78.NAME_FIELD.default_value = ""
var_0_78.NAME_FIELD.type = 9
var_0_78.NAME_FIELD.cpp_type = 9
var_0_78.AVATAR_FIELD.name = "avatar"
var_0_78.AVATAR_FIELD.full_name = ".sgland.Team.avatar"
var_0_78.AVATAR_FIELD.number = 4
var_0_78.AVATAR_FIELD.index = 3
var_0_78.AVATAR_FIELD.label = 2
var_0_78.AVATAR_FIELD.has_default_value = false
var_0_78.AVATAR_FIELD.default_value = 0
var_0_78.AVATAR_FIELD.type = 5
var_0_78.AVATAR_FIELD.cpp_type = 1
var_0_78.USER_INFO_FIELD.name = "user_info"
var_0_78.USER_INFO_FIELD.full_name = ".sgland.Team.user_info"
var_0_78.USER_INFO_FIELD.number = 5
var_0_78.USER_INFO_FIELD.index = 4
var_0_78.USER_INFO_FIELD.label = 3
var_0_78.USER_INFO_FIELD.has_default_value = false
var_0_78.USER_INFO_FIELD.default_value = {}
var_0_78.USER_INFO_FIELD.message_type = USERINFO
var_0_78.USER_INFO_FIELD.type = 11
var_0_78.USER_INFO_FIELD.cpp_type = 10
var_0_78.MASSWAR_STARTED_FIELD.name = "masswar_started"
var_0_78.MASSWAR_STARTED_FIELD.full_name = ".sgland.Team.masswar_started"
var_0_78.MASSWAR_STARTED_FIELD.number = 6
var_0_78.MASSWAR_STARTED_FIELD.index = 5
var_0_78.MASSWAR_STARTED_FIELD.label = 1
var_0_78.MASSWAR_STARTED_FIELD.has_default_value = false
var_0_78.MASSWAR_STARTED_FIELD.default_value = false
var_0_78.MASSWAR_STARTED_FIELD.type = 8
var_0_78.MASSWAR_STARTED_FIELD.cpp_type = 7
var_0_78.MASS_WAR_SCORE_FIELD.name = "mass_war_score"
var_0_78.MASS_WAR_SCORE_FIELD.full_name = ".sgland.Team.mass_war_score"
var_0_78.MASS_WAR_SCORE_FIELD.number = 7
var_0_78.MASS_WAR_SCORE_FIELD.index = 6
var_0_78.MASS_WAR_SCORE_FIELD.label = 1
var_0_78.MASS_WAR_SCORE_FIELD.has_default_value = false
var_0_78.MASS_WAR_SCORE_FIELD.default_value = 0
var_0_78.MASS_WAR_SCORE_FIELD.type = 5
var_0_78.MASS_WAR_SCORE_FIELD.cpp_type = 1
TEAM.name = "Team"
TEAM.full_name = ".sgland.Team"
TEAM.nested_types = {}
TEAM.enum_types = {}
TEAM.fields = {
	var_0_78.RID_FIELD,
	var_0_78.ID_FIELD,
	var_0_78.NAME_FIELD,
	var_0_78.AVATAR_FIELD,
	var_0_78.USER_INFO_FIELD,
	var_0_78.MASSWAR_STARTED_FIELD,
	var_0_78.MASS_WAR_SCORE_FIELD
}
TEAM.is_extendable = false
TEAM.extensions = {}
var_0_79.TEAMS_FIELD.name = "teams"
var_0_79.TEAMS_FIELD.full_name = ".sgland.TeamList.teams"
var_0_79.TEAMS_FIELD.number = 1
var_0_79.TEAMS_FIELD.index = 0
var_0_79.TEAMS_FIELD.label = 3
var_0_79.TEAMS_FIELD.has_default_value = false
var_0_79.TEAMS_FIELD.default_value = {}
var_0_79.TEAMS_FIELD.message_type = TEAM
var_0_79.TEAMS_FIELD.type = 11
var_0_79.TEAMS_FIELD.cpp_type = 10
TEAMLIST.name = "TeamList"
TEAMLIST.full_name = ".sgland.TeamList"
TEAMLIST.nested_types = {}
TEAMLIST.enum_types = {}
TEAMLIST.fields = {
	var_0_79.TEAMS_FIELD
}
TEAMLIST.is_extendable = false
TEAMLIST.extensions = {}
var_0_80.RID_FIELD.name = "rid"
var_0_80.RID_FIELD.full_name = ".sgland.FullTeam.rid"
var_0_80.RID_FIELD.number = 1
var_0_80.RID_FIELD.index = 0
var_0_80.RID_FIELD.label = 2
var_0_80.RID_FIELD.has_default_value = false
var_0_80.RID_FIELD.default_value = 0
var_0_80.RID_FIELD.type = 5
var_0_80.RID_FIELD.cpp_type = 1
var_0_80.ID_FIELD.name = "id"
var_0_80.ID_FIELD.full_name = ".sgland.FullTeam.id"
var_0_80.ID_FIELD.number = 2
var_0_80.ID_FIELD.index = 1
var_0_80.ID_FIELD.label = 2
var_0_80.ID_FIELD.has_default_value = false
var_0_80.ID_FIELD.default_value = 0
var_0_80.ID_FIELD.type = 3
var_0_80.ID_FIELD.cpp_type = 2
var_0_80.NAME_FIELD.name = "name"
var_0_80.NAME_FIELD.full_name = ".sgland.FullTeam.name"
var_0_80.NAME_FIELD.number = 3
var_0_80.NAME_FIELD.index = 2
var_0_80.NAME_FIELD.label = 2
var_0_80.NAME_FIELD.has_default_value = false
var_0_80.NAME_FIELD.default_value = ""
var_0_80.NAME_FIELD.type = 9
var_0_80.NAME_FIELD.cpp_type = 9
var_0_80.AVATAR_FIELD.name = "avatar"
var_0_80.AVATAR_FIELD.full_name = ".sgland.FullTeam.avatar"
var_0_80.AVATAR_FIELD.number = 4
var_0_80.AVATAR_FIELD.index = 3
var_0_80.AVATAR_FIELD.label = 2
var_0_80.AVATAR_FIELD.has_default_value = false
var_0_80.AVATAR_FIELD.default_value = 0
var_0_80.AVATAR_FIELD.type = 5
var_0_80.AVATAR_FIELD.cpp_type = 1
var_0_80.USER_ID_FIELD.name = "user_id"
var_0_80.USER_ID_FIELD.full_name = ".sgland.FullTeam.user_id"
var_0_80.USER_ID_FIELD.number = 5
var_0_80.USER_ID_FIELD.index = 4
var_0_80.USER_ID_FIELD.label = 3
var_0_80.USER_ID_FIELD.has_default_value = false
var_0_80.USER_ID_FIELD.default_value = {}
var_0_80.USER_ID_FIELD.type = 3
var_0_80.USER_ID_FIELD.cpp_type = 2
var_0_80.TROOP_FIELD.name = "troop"
var_0_80.TROOP_FIELD.full_name = ".sgland.FullTeam.troop"
var_0_80.TROOP_FIELD.number = 6
var_0_80.TROOP_FIELD.index = 5
var_0_80.TROOP_FIELD.label = 3
var_0_80.TROOP_FIELD.has_default_value = false
var_0_80.TROOP_FIELD.default_value = {}
var_0_80.TROOP_FIELD.message_type = TROOP
var_0_80.TROOP_FIELD.type = 11
var_0_80.TROOP_FIELD.cpp_type = 10
FULLTEAM.name = "FullTeam"
FULLTEAM.full_name = ".sgland.FullTeam"
FULLTEAM.nested_types = {}
FULLTEAM.enum_types = {}
FULLTEAM.fields = {
	var_0_80.RID_FIELD,
	var_0_80.ID_FIELD,
	var_0_80.NAME_FIELD,
	var_0_80.AVATAR_FIELD,
	var_0_80.USER_ID_FIELD,
	var_0_80.TROOP_FIELD
}
FULLTEAM.is_extendable = false
FULLTEAM.extensions = {}
var_0_81.RID_FIELD.name = "rid"
var_0_81.RID_FIELD.full_name = ".sgland.TeamInWorld.rid"
var_0_81.RID_FIELD.number = 1
var_0_81.RID_FIELD.index = 0
var_0_81.RID_FIELD.label = 2
var_0_81.RID_FIELD.has_default_value = false
var_0_81.RID_FIELD.default_value = 0
var_0_81.RID_FIELD.type = 5
var_0_81.RID_FIELD.cpp_type = 1
var_0_81.ID_FIELD.name = "id"
var_0_81.ID_FIELD.full_name = ".sgland.TeamInWorld.id"
var_0_81.ID_FIELD.number = 2
var_0_81.ID_FIELD.index = 1
var_0_81.ID_FIELD.label = 2
var_0_81.ID_FIELD.has_default_value = false
var_0_81.ID_FIELD.default_value = 0
var_0_81.ID_FIELD.type = 3
var_0_81.ID_FIELD.cpp_type = 2
var_0_81.NAME_FIELD.name = "name"
var_0_81.NAME_FIELD.full_name = ".sgland.TeamInWorld.name"
var_0_81.NAME_FIELD.number = 3
var_0_81.NAME_FIELD.index = 2
var_0_81.NAME_FIELD.label = 2
var_0_81.NAME_FIELD.has_default_value = false
var_0_81.NAME_FIELD.default_value = ""
var_0_81.NAME_FIELD.type = 9
var_0_81.NAME_FIELD.cpp_type = 9
var_0_81.AVATAR_FIELD.name = "avatar"
var_0_81.AVATAR_FIELD.full_name = ".sgland.TeamInWorld.avatar"
var_0_81.AVATAR_FIELD.number = 4
var_0_81.AVATAR_FIELD.index = 3
var_0_81.AVATAR_FIELD.label = 2
var_0_81.AVATAR_FIELD.has_default_value = false
var_0_81.AVATAR_FIELD.default_value = 0
var_0_81.AVATAR_FIELD.type = 5
var_0_81.AVATAR_FIELD.cpp_type = 1
var_0_81.ACCOUNT_INFO_FIELD.name = "account_info"
var_0_81.ACCOUNT_INFO_FIELD.full_name = ".sgland.TeamInWorld.account_info"
var_0_81.ACCOUNT_INFO_FIELD.number = 5
var_0_81.ACCOUNT_INFO_FIELD.index = 4
var_0_81.ACCOUNT_INFO_FIELD.label = 3
var_0_81.ACCOUNT_INFO_FIELD.has_default_value = false
var_0_81.ACCOUNT_INFO_FIELD.default_value = {}
var_0_81.ACCOUNT_INFO_FIELD.message_type = ACCOUNTINFO
var_0_81.ACCOUNT_INFO_FIELD.type = 11
var_0_81.ACCOUNT_INFO_FIELD.cpp_type = 10
TEAMINWORLD.name = "TeamInWorld"
TEAMINWORLD.full_name = ".sgland.TeamInWorld"
TEAMINWORLD.nested_types = {}
TEAMINWORLD.enum_types = {}
TEAMINWORLD.fields = {
	var_0_81.RID_FIELD,
	var_0_81.ID_FIELD,
	var_0_81.NAME_FIELD,
	var_0_81.AVATAR_FIELD,
	var_0_81.ACCOUNT_INFO_FIELD
}
TEAMINWORLD.is_extendable = false
TEAMINWORLD.extensions = {}
var_0_82.INFO_FIELD.name = "info"
var_0_82.INFO_FIELD.full_name = ".sgland.ReplayInfo.info"
var_0_82.INFO_FIELD.number = 1
var_0_82.INFO_FIELD.index = 0
var_0_82.INFO_FIELD.label = 2
var_0_82.INFO_FIELD.has_default_value = false
var_0_82.INFO_FIELD.default_value = nil
var_0_82.INFO_FIELD.message_type = ACCOUNTINFO
var_0_82.INFO_FIELD.type = 11
var_0_82.INFO_FIELD.cpp_type = 10
var_0_82.REPLAY_FIELD.name = "replay"
var_0_82.REPLAY_FIELD.full_name = ".sgland.ReplayInfo.replay"
var_0_82.REPLAY_FIELD.number = 2
var_0_82.REPLAY_FIELD.index = 1
var_0_82.REPLAY_FIELD.label = 2
var_0_82.REPLAY_FIELD.has_default_value = false
var_0_82.REPLAY_FIELD.default_value = nil
var_0_82.REPLAY_FIELD.message_type = BATTLESPOT
var_0_82.REPLAY_FIELD.type = 11
var_0_82.REPLAY_FIELD.cpp_type = 10
var_0_82.VIP_FIELD.name = "vip"
var_0_82.VIP_FIELD.full_name = ".sgland.ReplayInfo.vip"
var_0_82.VIP_FIELD.number = 3
var_0_82.VIP_FIELD.index = 2
var_0_82.VIP_FIELD.label = 2
var_0_82.VIP_FIELD.has_default_value = false
var_0_82.VIP_FIELD.default_value = 0
var_0_82.VIP_FIELD.type = 5
var_0_82.VIP_FIELD.cpp_type = 1
var_0_82.PRETROPHY_FIELD.name = "preTrophy"
var_0_82.PRETROPHY_FIELD.full_name = ".sgland.ReplayInfo.preTrophy"
var_0_82.PRETROPHY_FIELD.number = 4
var_0_82.PRETROPHY_FIELD.index = 3
var_0_82.PRETROPHY_FIELD.label = 2
var_0_82.PRETROPHY_FIELD.has_default_value = false
var_0_82.PRETROPHY_FIELD.default_value = 0
var_0_82.PRETROPHY_FIELD.type = 5
var_0_82.PRETROPHY_FIELD.cpp_type = 1
REPLAYINFO.name = "ReplayInfo"
REPLAYINFO.full_name = ".sgland.ReplayInfo"
REPLAYINFO.nested_types = {}
REPLAYINFO.enum_types = {}
REPLAYINFO.fields = {
	var_0_82.INFO_FIELD,
	var_0_82.REPLAY_FIELD,
	var_0_82.VIP_FIELD,
	var_0_82.PRETROPHY_FIELD
}
REPLAYINFO.is_extendable = false
REPLAYINFO.extensions = {}
var_0_83.REPLAY_INFO_FIELD.name = "replay_info"
var_0_83.REPLAY_INFO_FIELD.full_name = ".sgland.ReplayInfos.replay_info"
var_0_83.REPLAY_INFO_FIELD.number = 1
var_0_83.REPLAY_INFO_FIELD.index = 0
var_0_83.REPLAY_INFO_FIELD.label = 3
var_0_83.REPLAY_INFO_FIELD.has_default_value = false
var_0_83.REPLAY_INFO_FIELD.default_value = {}
var_0_83.REPLAY_INFO_FIELD.message_type = REPLAYINFO
var_0_83.REPLAY_INFO_FIELD.type = 11
var_0_83.REPLAY_INFO_FIELD.cpp_type = 10
REPLAYINFOS.name = "ReplayInfos"
REPLAYINFOS.full_name = ".sgland.ReplayInfos"
REPLAYINFOS.nested_types = {}
REPLAYINFOS.enum_types = {}
REPLAYINFOS.fields = {
	var_0_83.REPLAY_INFO_FIELD
}
REPLAYINFOS.is_extendable = false
REPLAYINFOS.extensions = {}
var_0_84.ACCOUNT_INFO_FIELD.name = "account_info"
var_0_84.ACCOUNT_INFO_FIELD.full_name = ".sgland.MVPInfo.account_info"
var_0_84.ACCOUNT_INFO_FIELD.number = 1
var_0_84.ACCOUNT_INFO_FIELD.index = 0
var_0_84.ACCOUNT_INFO_FIELD.label = 2
var_0_84.ACCOUNT_INFO_FIELD.has_default_value = false
var_0_84.ACCOUNT_INFO_FIELD.default_value = nil
var_0_84.ACCOUNT_INFO_FIELD.message_type = ACCOUNTINFO
var_0_84.ACCOUNT_INFO_FIELD.type = 11
var_0_84.ACCOUNT_INFO_FIELD.cpp_type = 10
var_0_84.MVP_TYPE_FIELD.name = "mvp_type"
var_0_84.MVP_TYPE_FIELD.full_name = ".sgland.MVPInfo.mvp_type"
var_0_84.MVP_TYPE_FIELD.number = 2
var_0_84.MVP_TYPE_FIELD.index = 1
var_0_84.MVP_TYPE_FIELD.label = 2
var_0_84.MVP_TYPE_FIELD.has_default_value = false
var_0_84.MVP_TYPE_FIELD.default_value = nil
var_0_84.MVP_TYPE_FIELD.enum_type = MVPTYPE
var_0_84.MVP_TYPE_FIELD.type = 14
var_0_84.MVP_TYPE_FIELD.cpp_type = 8
var_0_84.IS_NEW_FIELD.name = "is_new"
var_0_84.IS_NEW_FIELD.full_name = ".sgland.MVPInfo.is_new"
var_0_84.IS_NEW_FIELD.number = 3
var_0_84.IS_NEW_FIELD.index = 2
var_0_84.IS_NEW_FIELD.label = 2
var_0_84.IS_NEW_FIELD.has_default_value = false
var_0_84.IS_NEW_FIELD.default_value = false
var_0_84.IS_NEW_FIELD.type = 8
var_0_84.IS_NEW_FIELD.cpp_type = 7
MVPINFO.name = "MVPInfo"
MVPINFO.full_name = ".sgland.MVPInfo"
MVPINFO.nested_types = {}
MVPINFO.enum_types = {}
MVPINFO.fields = {
	var_0_84.ACCOUNT_INFO_FIELD,
	var_0_84.MVP_TYPE_FIELD,
	var_0_84.IS_NEW_FIELD
}
MVPINFO.is_extendable = false
MVPINFO.extensions = {}
AccountInfo = var_0_0.Message(ACCOUNTINFO)
ActivityBonus = var_0_0.Message(ACTIVITYBONUS)
AttachData = var_0_0.Message(ATTACHDATA)
BattleResult = var_0_0.Message(BATTLERESULT)
BattleSpot = var_0_0.Message(BATTLESPOT)
Bonus = var_0_0.Message(BONUS)
Bundle = var_0_0.Message(BUNDLE)
BundleEx = var_0_0.Message(BUNDLEEX)
BundleLimit = var_0_0.Message(BUNDLELIMIT)
CardBox = var_0_0.Message(CARDBOX)
CardBoxCardInfo = var_0_0.Message(CARDBOXCARDINFO)
CardExtraSkill = var_0_0.Message(CARDEXTRASKILL)
CardLevel = var_0_0.Message(CARDLEVEL)
Chapter = var_0_0.Message(CHAPTER)
Character = var_0_0.Message(CHARACTER)
Characters = var_0_0.Message(CHARACTERS)
Chest = var_0_0.Message(CHEST)
City = var_0_0.Message(CITY)
Contestant = var_0_0.Message(CONTESTANT)
Copy = var_0_0.Message(COPY)
Crown = var_0_0.Message(CROWN)
DARK_DUEL_MVP = 2
Drop = var_0_0.Message(DROP)
ExpeditionExBoss = var_0_0.Message(EXPEDITIONEXBOSS)
ExpeditionExNPC = var_0_0.Message(EXPEDITIONEXNPC)
Extra = var_0_0.Message(EXTRA)
FestivalBox = var_0_0.Message(FESTIVALBOX)
FestivalDrop = var_0_0.Message(FESTIVALDROP)
FestivalExtraLotteryData = var_0_0.Message(FESTIVALEXTRALOTTERYDATA)
FullTeam = var_0_0.Message(FULLTEAM)
FundStatus = var_0_0.Message(FUNDSTATUS)
Guard = var_0_0.Message(GUARD)
GuardSlot = var_0_0.Message(GUARDSLOT)
LADDER_EX_MVP = 1
LADDER_MVP = 0
LadderBox = var_0_0.Message(LADDERBOX)
LoginInfo = var_0_0.Message(LOGININFO)
MASSWAR_MVP = 3
MVPInfo = var_0_0.Message(MVPINFO)
Match = var_0_0.Message(MATCH)
MatchInfo = var_0_0.Message(MATCHINFO)
PB_TYPE_DARK = 2
PB_TYPE_NORMAL = 1
Pair = var_0_0.Message(PAIR)
ParyerLotteryDL = var_0_0.Message(PARYERLOTTERYDL)
PkgGuard = var_0_0.Message(PKGGUARD)
PkgGuardSlot = var_0_0.Message(PKGGUARDSLOT)
PlayerActivity = var_0_0.Message(PLAYERACTIVITY)
PlayerBonus = var_0_0.Message(PLAYERBONUS)
PlayerCard = var_0_0.Message(PLAYERCARD)
PlayerCharacter = var_0_0.Message(PLAYERCHARACTER)
PlayerCity = var_0_0.Message(PLAYERCITY)
PlayerCopy = var_0_0.Message(PLAYERCOPY)
PlayerDark = var_0_0.Message(PLAYERDARK)
PlayerDrop = var_0_0.Message(PLAYERDROP)
PlayerExpedition = var_0_0.Message(PLAYEREXPEDITION)
PlayerExpeditionEx = var_0_0.Message(PLAYEREXPEDITIONEX)
PlayerLadder = var_0_0.Message(PLAYERLADDER)
PlayerLotteryCount = var_0_0.Message(PLAYERLOTTERYCOUNT)
PlayerProp = var_0_0.Message(PLAYERPROP)
PlayerShop = var_0_0.Message(PLAYERSHOP)
PlayerSurvival = var_0_0.Message(PLAYERSURVIVAL)
PlayerSurvivalEx = var_0_0.Message(PLAYERSURVIVALEX)
PlayerUnion = var_0_0.Message(PLAYERUNION)
PlayerWorld = var_0_0.Message(PLAYERWORLD)
Procedure = var_0_0.Message(PROCEDURE)
ReplayInfo = var_0_0.Message(REPLAYINFO)
ReplayInfos = var_0_0.Message(REPLAYINFOS)
Resource = var_0_0.Message(RESOURCE)
SURVIVAL_EX_MVP = 5
SURVIVAL_MVP = 4
Skin = var_0_0.Message(SKIN)
SkinInUse = var_0_0.Message(SKININUSE)
SurvivalExHall = var_0_0.Message(SURVIVALEXHALL)
SurvivalExHallInfo = var_0_0.Message(SURVIVALEXHALLINFO)
SurvivalExSkill = var_0_0.Message(SURVIVALEXSKILL)
SurvivalHall = var_0_0.Message(SURVIVALHALL)
SurvivalHallInfo = var_0_0.Message(SURVIVALHALLINFO)
Team = var_0_0.Message(TEAM)
TeamInWorld = var_0_0.Message(TEAMINWORLD)
TeamInfo = var_0_0.Message(TEAMINFO)
TeamList = var_0_0.Message(TEAMLIST)
Tech = var_0_0.Message(TECH)
Troop = var_0_0.Message(TROOP)
TroopData = var_0_0.Message(TROOPDATA)
UnionInfo = var_0_0.Message(UNIONINFO)
UnionMini = var_0_0.Message(UNIONMINI)
UserInfo = var_0_0.Message(USERINFO)
Visit = var_0_0.Message(VISIT)
YybGift = var_0_0.Message(YYBGIFT)
