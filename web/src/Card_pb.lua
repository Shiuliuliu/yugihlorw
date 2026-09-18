local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Card_pb")

CARDUPGRADEREQ = var_0_0.Descriptor()

local var_0_3 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	SWALLOW_ID_FIELD = var_0_0.FieldDescriptor(),
	SWALLOW_EXP_FIELD = var_0_0.FieldDescriptor()
}

CARDSPLITREQ = var_0_0.Descriptor()

local var_0_4 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	IS_NORMAL_FIELD = var_0_0.FieldDescriptor()
}

CARDEVOLUTIONREQ = var_0_0.Descriptor()

local var_0_5 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	SWALLOW_ID_FIELD = var_0_0.FieldDescriptor()
}

CARDTRANSFORMREQ = var_0_0.Descriptor()

local var_0_6 = {
	INFO_ID_FIELD = var_0_0.FieldDescriptor()
}

CARDSELLREQ = var_0_0.Descriptor()

local var_0_7 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor()
}

CARDEQUIPREQ = var_0_0.Descriptor()

local var_0_8 = {
	EQUIP_ID_FIELD = var_0_0.FieldDescriptor(),
	HERO_ID_FIELD = var_0_0.FieldDescriptor(),
	IS_EQUIP_FIELD = var_0_0.FieldDescriptor()
}

CARDRECOVERREQ = var_0_0.Descriptor()

local var_0_9 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor()
}

CARDSKILLSETREQ = var_0_0.Descriptor()

local var_0_10 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	IS_KEEP_FIELD = var_0_0.FieldDescriptor()
}

CARDEVOLUTIONRESP = var_0_0.Descriptor()

local var_0_11 = {
	SKILL_ID_FIELD = var_0_0.FieldDescriptor(),
	SKILL_LEVEL_FIELD = var_0_0.FieldDescriptor()
}

LOTTERYRECORD = var_0_0.Descriptor()

local var_0_12 = {
	HERO_FIELD = var_0_0.FieldDescriptor(),
	TOTAL_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_FIELD = var_0_0.FieldDescriptor(),
	MIN_FIELD = var_0_0.FieldDescriptor(),
	MAX_FIELD = var_0_0.FieldDescriptor(),
	MIN_INFO_FIELD = var_0_0.FieldDescriptor(),
	MAX_INFO_FIELD = var_0_0.FieldDescriptor()
}

CARDLOTTERYREQ = var_0_0.Descriptor()

local var_0_13 = {
	PKG_ID_FIELD = var_0_0.FieldDescriptor(),
	IS_FREE_FIELD = var_0_0.FieldDescriptor()
}

BOOKLOTTERYRESP = var_0_0.Descriptor()

local var_0_14 = {
	RESOURCE_FIELD = var_0_0.FieldDescriptor(),
	NEXT_QUALITY_FIELD = var_0_0.FieldDescriptor()
}

UPPKGCARDREQ = var_0_0.Descriptor()

local var_0_15 = {
	PKG_ID_FIELD = var_0_0.FieldDescriptor(),
	CARD_ID_FIELD = var_0_0.FieldDescriptor()
}

UPPKGCARDRESP = var_0_0.Descriptor()

local var_0_16 = {
	CARD_ID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

RUBBINGCARDREQ = var_0_0.Descriptor()

local var_0_17 = {
	CARD_ID_FIELD = var_0_0.FieldDescriptor(),
	RUBBING_ID_FIELD = var_0_0.FieldDescriptor()
}

SGLCARDMSG = var_0_0.Descriptor()

local var_0_18 = {
	CARD_UPGRADE_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_EVOLUTION_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_SELL_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_UNLOCK_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_COMPOSE_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_DECOMPOSE_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_EQUIP_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_RECOVER_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_TRANSFORM_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_LOTTERY_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_LOTTERY_RECORD_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_SKILL_SET_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_BOX_INFO_REQ_FIELD = var_0_0.FieldDescriptor(),
	RESET_CARD_BOX_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_COMPOSE_PACKAGE_ID_FIELD = var_0_0.FieldDescriptor(),
	CARD_LOTTERY_USE_TOKEN_FIELD = var_0_0.FieldDescriptor(),
	CARD_RECOVERY_REQ_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_CARD_COMPOSE_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_CARD_COMPOSE_PKG_FIELD = var_0_0.FieldDescriptor(),
	FESTIVAL_REQ_FIELD = var_0_0.FieldDescriptor(),
	FESTIVAL_LOTTERY_USE_TOKEN_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_TRANSLATE_REQ_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_TURN_TABLE_REQ_FIELD = var_0_0.FieldDescriptor(),
	UP_PKG_CARD_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_COLLECT_REQ_FIELD = var_0_0.FieldDescriptor(),
	RUBBING_CARD_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_UNRUBBING_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_REMOVE_RUBBING_REQ_FIELD = var_0_0.FieldDescriptor(),
	CARD_LOTTERY_RESP_FIELD = var_0_0.FieldDescriptor(),
	BOOK_LOTTERY_RESP_FIELD = var_0_0.FieldDescriptor(),
	CARD_EVOLUTION_RESP_FIELD = var_0_0.FieldDescriptor(),
	CARD_LOTTERY_RECORD_RESP_FIELD = var_0_0.FieldDescriptor(),
	CARD_TRANSFER_RESP_FIELD = var_0_0.FieldDescriptor(),
	CARD_BOX_INFO_RESP_FIELD = var_0_0.FieldDescriptor(),
	REMAIN_PKG_UR_RESP_FIELD = var_0_0.FieldDescriptor(),
	RARE_PKG_RESOURCE_RESP_FIELD = var_0_0.FieldDescriptor(),
	FESTIVAL_BOX_RESP_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_FESTIVAL_RESP_FIELD = var_0_0.FieldDescriptor(),
	LOTTERY_TURN_TABLE_RESP_FIELD = var_0_0.FieldDescriptor(),
	UP_PKG_CARD_ID_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.ID_FIELD.name = "id"
var_0_3.ID_FIELD.full_name = ".sgland.CardUpgradeReq.id"
var_0_3.ID_FIELD.number = 1
var_0_3.ID_FIELD.index = 0
var_0_3.ID_FIELD.label = 2
var_0_3.ID_FIELD.has_default_value = false
var_0_3.ID_FIELD.default_value = 0
var_0_3.ID_FIELD.type = 5
var_0_3.ID_FIELD.cpp_type = 1
var_0_3.INFO_ID_FIELD.name = "info_id"
var_0_3.INFO_ID_FIELD.full_name = ".sgland.CardUpgradeReq.info_id"
var_0_3.INFO_ID_FIELD.number = 2
var_0_3.INFO_ID_FIELD.index = 1
var_0_3.INFO_ID_FIELD.label = 2
var_0_3.INFO_ID_FIELD.has_default_value = false
var_0_3.INFO_ID_FIELD.default_value = 0
var_0_3.INFO_ID_FIELD.type = 5
var_0_3.INFO_ID_FIELD.cpp_type = 1
var_0_3.SWALLOW_ID_FIELD.name = "swallow_id"
var_0_3.SWALLOW_ID_FIELD.full_name = ".sgland.CardUpgradeReq.swallow_id"
var_0_3.SWALLOW_ID_FIELD.number = 3
var_0_3.SWALLOW_ID_FIELD.index = 2
var_0_3.SWALLOW_ID_FIELD.label = 3
var_0_3.SWALLOW_ID_FIELD.has_default_value = false
var_0_3.SWALLOW_ID_FIELD.default_value = {}
var_0_3.SWALLOW_ID_FIELD.type = 5
var_0_3.SWALLOW_ID_FIELD.cpp_type = 1
var_0_3.SWALLOW_EXP_FIELD.name = "swallow_exp"
var_0_3.SWALLOW_EXP_FIELD.full_name = ".sgland.CardUpgradeReq.swallow_exp"
var_0_3.SWALLOW_EXP_FIELD.number = 4
var_0_3.SWALLOW_EXP_FIELD.index = 3
var_0_3.SWALLOW_EXP_FIELD.label = 1
var_0_3.SWALLOW_EXP_FIELD.has_default_value = false
var_0_3.SWALLOW_EXP_FIELD.default_value = 0
var_0_3.SWALLOW_EXP_FIELD.type = 5
var_0_3.SWALLOW_EXP_FIELD.cpp_type = 1
CARDUPGRADEREQ.name = "CardUpgradeReq"
CARDUPGRADEREQ.full_name = ".sgland.CardUpgradeReq"
CARDUPGRADEREQ.nested_types = {}
CARDUPGRADEREQ.enum_types = {}
CARDUPGRADEREQ.fields = {
	var_0_3.ID_FIELD,
	var_0_3.INFO_ID_FIELD,
	var_0_3.SWALLOW_ID_FIELD,
	var_0_3.SWALLOW_EXP_FIELD
}
CARDUPGRADEREQ.is_extendable = false
CARDUPGRADEREQ.extensions = {}
var_0_4.ID_FIELD.name = "id"
var_0_4.ID_FIELD.full_name = ".sgland.CardSplitReq.id"
var_0_4.ID_FIELD.number = 1
var_0_4.ID_FIELD.index = 0
var_0_4.ID_FIELD.label = 3
var_0_4.ID_FIELD.has_default_value = false
var_0_4.ID_FIELD.default_value = {}
var_0_4.ID_FIELD.type = 5
var_0_4.ID_FIELD.cpp_type = 1
var_0_4.INFO_ID_FIELD.name = "info_id"
var_0_4.INFO_ID_FIELD.full_name = ".sgland.CardSplitReq.info_id"
var_0_4.INFO_ID_FIELD.number = 2
var_0_4.INFO_ID_FIELD.index = 1
var_0_4.INFO_ID_FIELD.label = 2
var_0_4.INFO_ID_FIELD.has_default_value = false
var_0_4.INFO_ID_FIELD.default_value = 0
var_0_4.INFO_ID_FIELD.type = 5
var_0_4.INFO_ID_FIELD.cpp_type = 1
var_0_4.IS_NORMAL_FIELD.name = "is_normal"
var_0_4.IS_NORMAL_FIELD.full_name = ".sgland.CardSplitReq.is_normal"
var_0_4.IS_NORMAL_FIELD.number = 3
var_0_4.IS_NORMAL_FIELD.index = 2
var_0_4.IS_NORMAL_FIELD.label = 2
var_0_4.IS_NORMAL_FIELD.has_default_value = false
var_0_4.IS_NORMAL_FIELD.default_value = false
var_0_4.IS_NORMAL_FIELD.type = 8
var_0_4.IS_NORMAL_FIELD.cpp_type = 7
CARDSPLITREQ.name = "CardSplitReq"
CARDSPLITREQ.full_name = ".sgland.CardSplitReq"
CARDSPLITREQ.nested_types = {}
CARDSPLITREQ.enum_types = {}
CARDSPLITREQ.fields = {
	var_0_4.ID_FIELD,
	var_0_4.INFO_ID_FIELD,
	var_0_4.IS_NORMAL_FIELD
}
CARDSPLITREQ.is_extendable = false
CARDSPLITREQ.extensions = {}
var_0_5.ID_FIELD.name = "id"
var_0_5.ID_FIELD.full_name = ".sgland.CardEvolutionReq.id"
var_0_5.ID_FIELD.number = 1
var_0_5.ID_FIELD.index = 0
var_0_5.ID_FIELD.label = 2
var_0_5.ID_FIELD.has_default_value = false
var_0_5.ID_FIELD.default_value = 0
var_0_5.ID_FIELD.type = 5
var_0_5.ID_FIELD.cpp_type = 1
var_0_5.INFO_ID_FIELD.name = "info_id"
var_0_5.INFO_ID_FIELD.full_name = ".sgland.CardEvolutionReq.info_id"
var_0_5.INFO_ID_FIELD.number = 2
var_0_5.INFO_ID_FIELD.index = 1
var_0_5.INFO_ID_FIELD.label = 2
var_0_5.INFO_ID_FIELD.has_default_value = false
var_0_5.INFO_ID_FIELD.default_value = 0
var_0_5.INFO_ID_FIELD.type = 5
var_0_5.INFO_ID_FIELD.cpp_type = 1
var_0_5.SWALLOW_ID_FIELD.name = "swallow_id"
var_0_5.SWALLOW_ID_FIELD.full_name = ".sgland.CardEvolutionReq.swallow_id"
var_0_5.SWALLOW_ID_FIELD.number = 3
var_0_5.SWALLOW_ID_FIELD.index = 2
var_0_5.SWALLOW_ID_FIELD.label = 3
var_0_5.SWALLOW_ID_FIELD.has_default_value = false
var_0_5.SWALLOW_ID_FIELD.default_value = {}
var_0_5.SWALLOW_ID_FIELD.type = 5
var_0_5.SWALLOW_ID_FIELD.cpp_type = 1
CARDEVOLUTIONREQ.name = "CardEvolutionReq"
CARDEVOLUTIONREQ.full_name = ".sgland.CardEvolutionReq"
CARDEVOLUTIONREQ.nested_types = {}
CARDEVOLUTIONREQ.enum_types = {}
CARDEVOLUTIONREQ.fields = {
	var_0_5.ID_FIELD,
	var_0_5.INFO_ID_FIELD,
	var_0_5.SWALLOW_ID_FIELD
}
CARDEVOLUTIONREQ.is_extendable = false
CARDEVOLUTIONREQ.extensions = {}
var_0_6.INFO_ID_FIELD.name = "info_id"
var_0_6.INFO_ID_FIELD.full_name = ".sgland.CardTransformReq.info_id"
var_0_6.INFO_ID_FIELD.number = 1
var_0_6.INFO_ID_FIELD.index = 0
var_0_6.INFO_ID_FIELD.label = 2
var_0_6.INFO_ID_FIELD.has_default_value = false
var_0_6.INFO_ID_FIELD.default_value = 0
var_0_6.INFO_ID_FIELD.type = 5
var_0_6.INFO_ID_FIELD.cpp_type = 1
CARDTRANSFORMREQ.name = "CardTransformReq"
CARDTRANSFORMREQ.full_name = ".sgland.CardTransformReq"
CARDTRANSFORMREQ.nested_types = {}
CARDTRANSFORMREQ.enum_types = {}
CARDTRANSFORMREQ.fields = {
	var_0_6.INFO_ID_FIELD
}
CARDTRANSFORMREQ.is_extendable = false
CARDTRANSFORMREQ.extensions = {}
var_0_7.ID_FIELD.name = "id"
var_0_7.ID_FIELD.full_name = ".sgland.CardSellReq.id"
var_0_7.ID_FIELD.number = 1
var_0_7.ID_FIELD.index = 0
var_0_7.ID_FIELD.label = 3
var_0_7.ID_FIELD.has_default_value = false
var_0_7.ID_FIELD.default_value = {}
var_0_7.ID_FIELD.type = 5
var_0_7.ID_FIELD.cpp_type = 1
var_0_7.INFO_ID_FIELD.name = "info_id"
var_0_7.INFO_ID_FIELD.full_name = ".sgland.CardSellReq.info_id"
var_0_7.INFO_ID_FIELD.number = 2
var_0_7.INFO_ID_FIELD.index = 1
var_0_7.INFO_ID_FIELD.label = 2
var_0_7.INFO_ID_FIELD.has_default_value = false
var_0_7.INFO_ID_FIELD.default_value = 0
var_0_7.INFO_ID_FIELD.type = 5
var_0_7.INFO_ID_FIELD.cpp_type = 1
CARDSELLREQ.name = "CardSellReq"
CARDSELLREQ.full_name = ".sgland.CardSellReq"
CARDSELLREQ.nested_types = {}
CARDSELLREQ.enum_types = {}
CARDSELLREQ.fields = {
	var_0_7.ID_FIELD,
	var_0_7.INFO_ID_FIELD
}
CARDSELLREQ.is_extendable = false
CARDSELLREQ.extensions = {}
var_0_8.EQUIP_ID_FIELD.name = "equip_id"
var_0_8.EQUIP_ID_FIELD.full_name = ".sgland.CardEquipReq.equip_id"
var_0_8.EQUIP_ID_FIELD.number = 1
var_0_8.EQUIP_ID_FIELD.index = 0
var_0_8.EQUIP_ID_FIELD.label = 2
var_0_8.EQUIP_ID_FIELD.has_default_value = false
var_0_8.EQUIP_ID_FIELD.default_value = 0
var_0_8.EQUIP_ID_FIELD.type = 5
var_0_8.EQUIP_ID_FIELD.cpp_type = 1
var_0_8.HERO_ID_FIELD.name = "hero_id"
var_0_8.HERO_ID_FIELD.full_name = ".sgland.CardEquipReq.hero_id"
var_0_8.HERO_ID_FIELD.number = 2
var_0_8.HERO_ID_FIELD.index = 1
var_0_8.HERO_ID_FIELD.label = 2
var_0_8.HERO_ID_FIELD.has_default_value = false
var_0_8.HERO_ID_FIELD.default_value = 0
var_0_8.HERO_ID_FIELD.type = 5
var_0_8.HERO_ID_FIELD.cpp_type = 1
var_0_8.IS_EQUIP_FIELD.name = "is_equip"
var_0_8.IS_EQUIP_FIELD.full_name = ".sgland.CardEquipReq.is_equip"
var_0_8.IS_EQUIP_FIELD.number = 3
var_0_8.IS_EQUIP_FIELD.index = 2
var_0_8.IS_EQUIP_FIELD.label = 2
var_0_8.IS_EQUIP_FIELD.has_default_value = false
var_0_8.IS_EQUIP_FIELD.default_value = false
var_0_8.IS_EQUIP_FIELD.type = 8
var_0_8.IS_EQUIP_FIELD.cpp_type = 7
CARDEQUIPREQ.name = "CardEquipReq"
CARDEQUIPREQ.full_name = ".sgland.CardEquipReq"
CARDEQUIPREQ.nested_types = {}
CARDEQUIPREQ.enum_types = {}
CARDEQUIPREQ.fields = {
	var_0_8.EQUIP_ID_FIELD,
	var_0_8.HERO_ID_FIELD,
	var_0_8.IS_EQUIP_FIELD
}
CARDEQUIPREQ.is_extendable = false
CARDEQUIPREQ.extensions = {}
var_0_9.ID_FIELD.name = "id"
var_0_9.ID_FIELD.full_name = ".sgland.CardRecoverReq.id"
var_0_9.ID_FIELD.number = 1
var_0_9.ID_FIELD.index = 0
var_0_9.ID_FIELD.label = 2
var_0_9.ID_FIELD.has_default_value = false
var_0_9.ID_FIELD.default_value = 0
var_0_9.ID_FIELD.type = 5
var_0_9.ID_FIELD.cpp_type = 1
var_0_9.INFO_ID_FIELD.name = "info_id"
var_0_9.INFO_ID_FIELD.full_name = ".sgland.CardRecoverReq.info_id"
var_0_9.INFO_ID_FIELD.number = 2
var_0_9.INFO_ID_FIELD.index = 1
var_0_9.INFO_ID_FIELD.label = 2
var_0_9.INFO_ID_FIELD.has_default_value = false
var_0_9.INFO_ID_FIELD.default_value = 0
var_0_9.INFO_ID_FIELD.type = 5
var_0_9.INFO_ID_FIELD.cpp_type = 1
CARDRECOVERREQ.name = "CardRecoverReq"
CARDRECOVERREQ.full_name = ".sgland.CardRecoverReq"
CARDRECOVERREQ.nested_types = {}
CARDRECOVERREQ.enum_types = {}
CARDRECOVERREQ.fields = {
	var_0_9.ID_FIELD,
	var_0_9.INFO_ID_FIELD
}
CARDRECOVERREQ.is_extendable = false
CARDRECOVERREQ.extensions = {}
var_0_10.ID_FIELD.name = "id"
var_0_10.ID_FIELD.full_name = ".sgland.CardSkillSetReq.id"
var_0_10.ID_FIELD.number = 1
var_0_10.ID_FIELD.index = 0
var_0_10.ID_FIELD.label = 2
var_0_10.ID_FIELD.has_default_value = false
var_0_10.ID_FIELD.default_value = 0
var_0_10.ID_FIELD.type = 5
var_0_10.ID_FIELD.cpp_type = 1
var_0_10.INFO_ID_FIELD.name = "info_id"
var_0_10.INFO_ID_FIELD.full_name = ".sgland.CardSkillSetReq.info_id"
var_0_10.INFO_ID_FIELD.number = 2
var_0_10.INFO_ID_FIELD.index = 1
var_0_10.INFO_ID_FIELD.label = 2
var_0_10.INFO_ID_FIELD.has_default_value = false
var_0_10.INFO_ID_FIELD.default_value = 0
var_0_10.INFO_ID_FIELD.type = 5
var_0_10.INFO_ID_FIELD.cpp_type = 1
var_0_10.IS_KEEP_FIELD.name = "is_keep"
var_0_10.IS_KEEP_FIELD.full_name = ".sgland.CardSkillSetReq.is_keep"
var_0_10.IS_KEEP_FIELD.number = 3
var_0_10.IS_KEEP_FIELD.index = 2
var_0_10.IS_KEEP_FIELD.label = 2
var_0_10.IS_KEEP_FIELD.has_default_value = false
var_0_10.IS_KEEP_FIELD.default_value = false
var_0_10.IS_KEEP_FIELD.type = 8
var_0_10.IS_KEEP_FIELD.cpp_type = 7
CARDSKILLSETREQ.name = "CardSkillSetReq"
CARDSKILLSETREQ.full_name = ".sgland.CardSkillSetReq"
CARDSKILLSETREQ.nested_types = {}
CARDSKILLSETREQ.enum_types = {}
CARDSKILLSETREQ.fields = {
	var_0_10.ID_FIELD,
	var_0_10.INFO_ID_FIELD,
	var_0_10.IS_KEEP_FIELD
}
CARDSKILLSETREQ.is_extendable = false
CARDSKILLSETREQ.extensions = {}
var_0_11.SKILL_ID_FIELD.name = "skill_id"
var_0_11.SKILL_ID_FIELD.full_name = ".sgland.CardEvolutionResp.skill_id"
var_0_11.SKILL_ID_FIELD.number = 1
var_0_11.SKILL_ID_FIELD.index = 0
var_0_11.SKILL_ID_FIELD.label = 1
var_0_11.SKILL_ID_FIELD.has_default_value = false
var_0_11.SKILL_ID_FIELD.default_value = 0
var_0_11.SKILL_ID_FIELD.type = 5
var_0_11.SKILL_ID_FIELD.cpp_type = 1
var_0_11.SKILL_LEVEL_FIELD.name = "skill_level"
var_0_11.SKILL_LEVEL_FIELD.full_name = ".sgland.CardEvolutionResp.skill_level"
var_0_11.SKILL_LEVEL_FIELD.number = 2
var_0_11.SKILL_LEVEL_FIELD.index = 1
var_0_11.SKILL_LEVEL_FIELD.label = 1
var_0_11.SKILL_LEVEL_FIELD.has_default_value = false
var_0_11.SKILL_LEVEL_FIELD.default_value = 0
var_0_11.SKILL_LEVEL_FIELD.type = 5
var_0_11.SKILL_LEVEL_FIELD.cpp_type = 1
CARDEVOLUTIONRESP.name = "CardEvolutionResp"
CARDEVOLUTIONRESP.full_name = ".sgland.CardEvolutionResp"
CARDEVOLUTIONRESP.nested_types = {}
CARDEVOLUTIONRESP.enum_types = {}
CARDEVOLUTIONRESP.fields = {
	var_0_11.SKILL_ID_FIELD,
	var_0_11.SKILL_LEVEL_FIELD
}
CARDEVOLUTIONRESP.is_extendable = false
CARDEVOLUTIONRESP.extensions = {}
var_0_12.HERO_FIELD.name = "hero"
var_0_12.HERO_FIELD.full_name = ".sgland.LotteryRecord.hero"
var_0_12.HERO_FIELD.number = 1
var_0_12.HERO_FIELD.index = 0
var_0_12.HERO_FIELD.label = 2
var_0_12.HERO_FIELD.has_default_value = false
var_0_12.HERO_FIELD.default_value = 0
var_0_12.HERO_FIELD.type = 5
var_0_12.HERO_FIELD.cpp_type = 1
var_0_12.TOTAL_FIELD.name = "total"
var_0_12.TOTAL_FIELD.full_name = ".sgland.LotteryRecord.total"
var_0_12.TOTAL_FIELD.number = 2
var_0_12.TOTAL_FIELD.index = 1
var_0_12.TOTAL_FIELD.label = 2
var_0_12.TOTAL_FIELD.has_default_value = false
var_0_12.TOTAL_FIELD.default_value = 0
var_0_12.TOTAL_FIELD.type = 5
var_0_12.TOTAL_FIELD.cpp_type = 1
var_0_12.LEGEND_FIELD.name = "legend"
var_0_12.LEGEND_FIELD.full_name = ".sgland.LotteryRecord.legend"
var_0_12.LEGEND_FIELD.number = 3
var_0_12.LEGEND_FIELD.index = 2
var_0_12.LEGEND_FIELD.label = 2
var_0_12.LEGEND_FIELD.has_default_value = false
var_0_12.LEGEND_FIELD.default_value = 0
var_0_12.LEGEND_FIELD.type = 5
var_0_12.LEGEND_FIELD.cpp_type = 1
var_0_12.MIN_FIELD.name = "min"
var_0_12.MIN_FIELD.full_name = ".sgland.LotteryRecord.min"
var_0_12.MIN_FIELD.number = 4
var_0_12.MIN_FIELD.index = 3
var_0_12.MIN_FIELD.label = 2
var_0_12.MIN_FIELD.has_default_value = false
var_0_12.MIN_FIELD.default_value = 0
var_0_12.MIN_FIELD.type = 5
var_0_12.MIN_FIELD.cpp_type = 1
var_0_12.MAX_FIELD.name = "max"
var_0_12.MAX_FIELD.full_name = ".sgland.LotteryRecord.max"
var_0_12.MAX_FIELD.number = 5
var_0_12.MAX_FIELD.index = 4
var_0_12.MAX_FIELD.label = 2
var_0_12.MAX_FIELD.has_default_value = false
var_0_12.MAX_FIELD.default_value = 0
var_0_12.MAX_FIELD.type = 5
var_0_12.MAX_FIELD.cpp_type = 1
var_0_12.MIN_INFO_FIELD.name = "min_info"
var_0_12.MIN_INFO_FIELD.full_name = ".sgland.LotteryRecord.min_info"
var_0_12.MIN_INFO_FIELD.number = 6
var_0_12.MIN_INFO_FIELD.index = 5
var_0_12.MIN_INFO_FIELD.label = 1
var_0_12.MIN_INFO_FIELD.has_default_value = false
var_0_12.MIN_INFO_FIELD.default_value = nil
var_0_12.MIN_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_12.MIN_INFO_FIELD.type = 11
var_0_12.MIN_INFO_FIELD.cpp_type = 10
var_0_12.MAX_INFO_FIELD.name = "max_info"
var_0_12.MAX_INFO_FIELD.full_name = ".sgland.LotteryRecord.max_info"
var_0_12.MAX_INFO_FIELD.number = 7
var_0_12.MAX_INFO_FIELD.index = 6
var_0_12.MAX_INFO_FIELD.label = 1
var_0_12.MAX_INFO_FIELD.has_default_value = false
var_0_12.MAX_INFO_FIELD.default_value = nil
var_0_12.MAX_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_12.MAX_INFO_FIELD.type = 11
var_0_12.MAX_INFO_FIELD.cpp_type = 10
LOTTERYRECORD.name = "LotteryRecord"
LOTTERYRECORD.full_name = ".sgland.LotteryRecord"
LOTTERYRECORD.nested_types = {}
LOTTERYRECORD.enum_types = {}
LOTTERYRECORD.fields = {
	var_0_12.HERO_FIELD,
	var_0_12.TOTAL_FIELD,
	var_0_12.LEGEND_FIELD,
	var_0_12.MIN_FIELD,
	var_0_12.MAX_FIELD,
	var_0_12.MIN_INFO_FIELD,
	var_0_12.MAX_INFO_FIELD
}
LOTTERYRECORD.is_extendable = false
LOTTERYRECORD.extensions = {}
var_0_13.PKG_ID_FIELD.name = "pkg_id"
var_0_13.PKG_ID_FIELD.full_name = ".sgland.CardLotteryReq.pkg_id"
var_0_13.PKG_ID_FIELD.number = 1
var_0_13.PKG_ID_FIELD.index = 0
var_0_13.PKG_ID_FIELD.label = 2
var_0_13.PKG_ID_FIELD.has_default_value = false
var_0_13.PKG_ID_FIELD.default_value = 0
var_0_13.PKG_ID_FIELD.type = 5
var_0_13.PKG_ID_FIELD.cpp_type = 1
var_0_13.IS_FREE_FIELD.name = "is_free"
var_0_13.IS_FREE_FIELD.full_name = ".sgland.CardLotteryReq.is_free"
var_0_13.IS_FREE_FIELD.number = 2
var_0_13.IS_FREE_FIELD.index = 1
var_0_13.IS_FREE_FIELD.label = 2
var_0_13.IS_FREE_FIELD.has_default_value = false
var_0_13.IS_FREE_FIELD.default_value = false
var_0_13.IS_FREE_FIELD.type = 8
var_0_13.IS_FREE_FIELD.cpp_type = 7
CARDLOTTERYREQ.name = "CardLotteryReq"
CARDLOTTERYREQ.full_name = ".sgland.CardLotteryReq"
CARDLOTTERYREQ.nested_types = {}
CARDLOTTERYREQ.enum_types = {}
CARDLOTTERYREQ.fields = {
	var_0_13.PKG_ID_FIELD,
	var_0_13.IS_FREE_FIELD
}
CARDLOTTERYREQ.is_extendable = false
CARDLOTTERYREQ.extensions = {}
var_0_14.RESOURCE_FIELD.name = "resource"
var_0_14.RESOURCE_FIELD.full_name = ".sgland.BookLotteryResp.resource"
var_0_14.RESOURCE_FIELD.number = 1
var_0_14.RESOURCE_FIELD.index = 0
var_0_14.RESOURCE_FIELD.label = 2
var_0_14.RESOURCE_FIELD.has_default_value = false
var_0_14.RESOURCE_FIELD.default_value = nil
var_0_14.RESOURCE_FIELD.message_type = var_0_2.RESOURCE
var_0_14.RESOURCE_FIELD.type = 11
var_0_14.RESOURCE_FIELD.cpp_type = 10
var_0_14.NEXT_QUALITY_FIELD.name = "next_quality"
var_0_14.NEXT_QUALITY_FIELD.full_name = ".sgland.BookLotteryResp.next_quality"
var_0_14.NEXT_QUALITY_FIELD.number = 2
var_0_14.NEXT_QUALITY_FIELD.index = 1
var_0_14.NEXT_QUALITY_FIELD.label = 2
var_0_14.NEXT_QUALITY_FIELD.has_default_value = false
var_0_14.NEXT_QUALITY_FIELD.default_value = 0
var_0_14.NEXT_QUALITY_FIELD.type = 5
var_0_14.NEXT_QUALITY_FIELD.cpp_type = 1
BOOKLOTTERYRESP.name = "BookLotteryResp"
BOOKLOTTERYRESP.full_name = ".sgland.BookLotteryResp"
BOOKLOTTERYRESP.nested_types = {}
BOOKLOTTERYRESP.enum_types = {}
BOOKLOTTERYRESP.fields = {
	var_0_14.RESOURCE_FIELD,
	var_0_14.NEXT_QUALITY_FIELD
}
BOOKLOTTERYRESP.is_extendable = false
BOOKLOTTERYRESP.extensions = {}
var_0_15.PKG_ID_FIELD.name = "pkg_id"
var_0_15.PKG_ID_FIELD.full_name = ".sgland.UpPkgCardReq.pkg_id"
var_0_15.PKG_ID_FIELD.number = 1
var_0_15.PKG_ID_FIELD.index = 0
var_0_15.PKG_ID_FIELD.label = 2
var_0_15.PKG_ID_FIELD.has_default_value = false
var_0_15.PKG_ID_FIELD.default_value = 0
var_0_15.PKG_ID_FIELD.type = 5
var_0_15.PKG_ID_FIELD.cpp_type = 1
var_0_15.CARD_ID_FIELD.name = "card_id"
var_0_15.CARD_ID_FIELD.full_name = ".sgland.UpPkgCardReq.card_id"
var_0_15.CARD_ID_FIELD.number = 2
var_0_15.CARD_ID_FIELD.index = 1
var_0_15.CARD_ID_FIELD.label = 2
var_0_15.CARD_ID_FIELD.has_default_value = false
var_0_15.CARD_ID_FIELD.default_value = 0
var_0_15.CARD_ID_FIELD.type = 5
var_0_15.CARD_ID_FIELD.cpp_type = 1
UPPKGCARDREQ.name = "UpPkgCardReq"
UPPKGCARDREQ.full_name = ".sgland.UpPkgCardReq"
UPPKGCARDREQ.nested_types = {}
UPPKGCARDREQ.enum_types = {}
UPPKGCARDREQ.fields = {
	var_0_15.PKG_ID_FIELD,
	var_0_15.CARD_ID_FIELD
}
UPPKGCARDREQ.is_extendable = false
UPPKGCARDREQ.extensions = {}
var_0_16.CARD_ID_FIELD.name = "card_id"
var_0_16.CARD_ID_FIELD.full_name = ".sgland.UpPkgCardResp.card_id"
var_0_16.CARD_ID_FIELD.number = 1
var_0_16.CARD_ID_FIELD.index = 0
var_0_16.CARD_ID_FIELD.label = 2
var_0_16.CARD_ID_FIELD.has_default_value = false
var_0_16.CARD_ID_FIELD.default_value = 0
var_0_16.CARD_ID_FIELD.type = 5
var_0_16.CARD_ID_FIELD.cpp_type = 1
var_0_16.TIMESTAMP_FIELD.name = "timestamp"
var_0_16.TIMESTAMP_FIELD.full_name = ".sgland.UpPkgCardResp.timestamp"
var_0_16.TIMESTAMP_FIELD.number = 2
var_0_16.TIMESTAMP_FIELD.index = 1
var_0_16.TIMESTAMP_FIELD.label = 2
var_0_16.TIMESTAMP_FIELD.has_default_value = false
var_0_16.TIMESTAMP_FIELD.default_value = 0
var_0_16.TIMESTAMP_FIELD.type = 3
var_0_16.TIMESTAMP_FIELD.cpp_type = 2
UPPKGCARDRESP.name = "UpPkgCardResp"
UPPKGCARDRESP.full_name = ".sgland.UpPkgCardResp"
UPPKGCARDRESP.nested_types = {}
UPPKGCARDRESP.enum_types = {}
UPPKGCARDRESP.fields = {
	var_0_16.CARD_ID_FIELD,
	var_0_16.TIMESTAMP_FIELD
}
UPPKGCARDRESP.is_extendable = false
UPPKGCARDRESP.extensions = {}
var_0_17.CARD_ID_FIELD.name = "card_id"
var_0_17.CARD_ID_FIELD.full_name = ".sgland.RubbingCardReq.card_id"
var_0_17.CARD_ID_FIELD.number = 1
var_0_17.CARD_ID_FIELD.index = 0
var_0_17.CARD_ID_FIELD.label = 2
var_0_17.CARD_ID_FIELD.has_default_value = false
var_0_17.CARD_ID_FIELD.default_value = 0
var_0_17.CARD_ID_FIELD.type = 5
var_0_17.CARD_ID_FIELD.cpp_type = 1
var_0_17.RUBBING_ID_FIELD.name = "rubbing_id"
var_0_17.RUBBING_ID_FIELD.full_name = ".sgland.RubbingCardReq.rubbing_id"
var_0_17.RUBBING_ID_FIELD.number = 2
var_0_17.RUBBING_ID_FIELD.index = 1
var_0_17.RUBBING_ID_FIELD.label = 2
var_0_17.RUBBING_ID_FIELD.has_default_value = false
var_0_17.RUBBING_ID_FIELD.default_value = 0
var_0_17.RUBBING_ID_FIELD.type = 5
var_0_17.RUBBING_ID_FIELD.cpp_type = 1
RUBBINGCARDREQ.name = "RubbingCardReq"
RUBBINGCARDREQ.full_name = ".sgland.RubbingCardReq"
RUBBINGCARDREQ.nested_types = {}
RUBBINGCARDREQ.enum_types = {}
RUBBINGCARDREQ.fields = {
	var_0_17.CARD_ID_FIELD,
	var_0_17.RUBBING_ID_FIELD
}
RUBBINGCARDREQ.is_extendable = false
RUBBINGCARDREQ.extensions = {}
var_0_18.CARD_UPGRADE_REQ_FIELD.name = "card_upgrade_req"
var_0_18.CARD_UPGRADE_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_upgrade_req"
var_0_18.CARD_UPGRADE_REQ_FIELD.number = 500
var_0_18.CARD_UPGRADE_REQ_FIELD.index = 0
var_0_18.CARD_UPGRADE_REQ_FIELD.label = 1
var_0_18.CARD_UPGRADE_REQ_FIELD.has_default_value = false
var_0_18.CARD_UPGRADE_REQ_FIELD.default_value = 0
var_0_18.CARD_UPGRADE_REQ_FIELD.type = 5
var_0_18.CARD_UPGRADE_REQ_FIELD.cpp_type = 1
var_0_18.CARD_EVOLUTION_REQ_FIELD.name = "card_evolution_req"
var_0_18.CARD_EVOLUTION_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_evolution_req"
var_0_18.CARD_EVOLUTION_REQ_FIELD.number = 501
var_0_18.CARD_EVOLUTION_REQ_FIELD.index = 1
var_0_18.CARD_EVOLUTION_REQ_FIELD.label = 1
var_0_18.CARD_EVOLUTION_REQ_FIELD.has_default_value = false
var_0_18.CARD_EVOLUTION_REQ_FIELD.default_value = nil
var_0_18.CARD_EVOLUTION_REQ_FIELD.message_type = CARDEVOLUTIONREQ
var_0_18.CARD_EVOLUTION_REQ_FIELD.type = 11
var_0_18.CARD_EVOLUTION_REQ_FIELD.cpp_type = 10
var_0_18.CARD_SELL_REQ_FIELD.name = "card_sell_req"
var_0_18.CARD_SELL_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_sell_req"
var_0_18.CARD_SELL_REQ_FIELD.number = 502
var_0_18.CARD_SELL_REQ_FIELD.index = 2
var_0_18.CARD_SELL_REQ_FIELD.label = 1
var_0_18.CARD_SELL_REQ_FIELD.has_default_value = false
var_0_18.CARD_SELL_REQ_FIELD.default_value = nil
var_0_18.CARD_SELL_REQ_FIELD.message_type = CARDSELLREQ
var_0_18.CARD_SELL_REQ_FIELD.type = 11
var_0_18.CARD_SELL_REQ_FIELD.cpp_type = 10
var_0_18.CARD_UNLOCK_REQ_FIELD.name = "card_unlock_req"
var_0_18.CARD_UNLOCK_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_unlock_req"
var_0_18.CARD_UNLOCK_REQ_FIELD.number = 503
var_0_18.CARD_UNLOCK_REQ_FIELD.index = 3
var_0_18.CARD_UNLOCK_REQ_FIELD.label = 1
var_0_18.CARD_UNLOCK_REQ_FIELD.has_default_value = false
var_0_18.CARD_UNLOCK_REQ_FIELD.default_value = 0
var_0_18.CARD_UNLOCK_REQ_FIELD.type = 5
var_0_18.CARD_UNLOCK_REQ_FIELD.cpp_type = 1
var_0_18.CARD_COMPOSE_REQ_FIELD.name = "card_compose_req"
var_0_18.CARD_COMPOSE_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_compose_req"
var_0_18.CARD_COMPOSE_REQ_FIELD.number = 504
var_0_18.CARD_COMPOSE_REQ_FIELD.index = 4
var_0_18.CARD_COMPOSE_REQ_FIELD.label = 3
var_0_18.CARD_COMPOSE_REQ_FIELD.has_default_value = false
var_0_18.CARD_COMPOSE_REQ_FIELD.default_value = {}
var_0_18.CARD_COMPOSE_REQ_FIELD.message_type = var_0_2.RESOURCE
var_0_18.CARD_COMPOSE_REQ_FIELD.type = 11
var_0_18.CARD_COMPOSE_REQ_FIELD.cpp_type = 10
var_0_18.CARD_DECOMPOSE_REQ_FIELD.name = "card_decompose_req"
var_0_18.CARD_DECOMPOSE_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_decompose_req"
var_0_18.CARD_DECOMPOSE_REQ_FIELD.number = 505
var_0_18.CARD_DECOMPOSE_REQ_FIELD.index = 5
var_0_18.CARD_DECOMPOSE_REQ_FIELD.label = 1
var_0_18.CARD_DECOMPOSE_REQ_FIELD.has_default_value = false
var_0_18.CARD_DECOMPOSE_REQ_FIELD.default_value = nil
var_0_18.CARD_DECOMPOSE_REQ_FIELD.message_type = var_0_2.RESOURCE
var_0_18.CARD_DECOMPOSE_REQ_FIELD.type = 11
var_0_18.CARD_DECOMPOSE_REQ_FIELD.cpp_type = 10
var_0_18.CARD_EQUIP_REQ_FIELD.name = "card_equip_req"
var_0_18.CARD_EQUIP_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_equip_req"
var_0_18.CARD_EQUIP_REQ_FIELD.number = 506
var_0_18.CARD_EQUIP_REQ_FIELD.index = 6
var_0_18.CARD_EQUIP_REQ_FIELD.label = 1
var_0_18.CARD_EQUIP_REQ_FIELD.has_default_value = false
var_0_18.CARD_EQUIP_REQ_FIELD.default_value = nil
var_0_18.CARD_EQUIP_REQ_FIELD.message_type = CARDEQUIPREQ
var_0_18.CARD_EQUIP_REQ_FIELD.type = 11
var_0_18.CARD_EQUIP_REQ_FIELD.cpp_type = 10
var_0_18.CARD_RECOVER_REQ_FIELD.name = "card_recover_req"
var_0_18.CARD_RECOVER_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_recover_req"
var_0_18.CARD_RECOVER_REQ_FIELD.number = 507
var_0_18.CARD_RECOVER_REQ_FIELD.index = 7
var_0_18.CARD_RECOVER_REQ_FIELD.label = 1
var_0_18.CARD_RECOVER_REQ_FIELD.has_default_value = false
var_0_18.CARD_RECOVER_REQ_FIELD.default_value = nil
var_0_18.CARD_RECOVER_REQ_FIELD.message_type = CARDRECOVERREQ
var_0_18.CARD_RECOVER_REQ_FIELD.type = 11
var_0_18.CARD_RECOVER_REQ_FIELD.cpp_type = 10
var_0_18.CARD_TRANSFORM_REQ_FIELD.name = "card_transform_req"
var_0_18.CARD_TRANSFORM_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_transform_req"
var_0_18.CARD_TRANSFORM_REQ_FIELD.number = 508
var_0_18.CARD_TRANSFORM_REQ_FIELD.index = 8
var_0_18.CARD_TRANSFORM_REQ_FIELD.label = 1
var_0_18.CARD_TRANSFORM_REQ_FIELD.has_default_value = false
var_0_18.CARD_TRANSFORM_REQ_FIELD.default_value = nil
var_0_18.CARD_TRANSFORM_REQ_FIELD.message_type = CARDTRANSFORMREQ
var_0_18.CARD_TRANSFORM_REQ_FIELD.type = 11
var_0_18.CARD_TRANSFORM_REQ_FIELD.cpp_type = 10
var_0_18.CARD_LOTTERY_REQ_FIELD.name = "card_lottery_req"
var_0_18.CARD_LOTTERY_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_lottery_req"
var_0_18.CARD_LOTTERY_REQ_FIELD.number = 509
var_0_18.CARD_LOTTERY_REQ_FIELD.index = 9
var_0_18.CARD_LOTTERY_REQ_FIELD.label = 1
var_0_18.CARD_LOTTERY_REQ_FIELD.has_default_value = false
var_0_18.CARD_LOTTERY_REQ_FIELD.default_value = nil
var_0_18.CARD_LOTTERY_REQ_FIELD.message_type = CARDLOTTERYREQ
var_0_18.CARD_LOTTERY_REQ_FIELD.type = 11
var_0_18.CARD_LOTTERY_REQ_FIELD.cpp_type = 10
var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD.name = "card_lottery_record_req"
var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_lottery_record_req"
var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD.number = 510
var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD.index = 10
var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD.label = 1
var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD.has_default_value = false
var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD.default_value = 0
var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD.type = 5
var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD.cpp_type = 1
var_0_18.CARD_SKILL_SET_REQ_FIELD.name = "card_skill_set_req"
var_0_18.CARD_SKILL_SET_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_skill_set_req"
var_0_18.CARD_SKILL_SET_REQ_FIELD.number = 511
var_0_18.CARD_SKILL_SET_REQ_FIELD.index = 11
var_0_18.CARD_SKILL_SET_REQ_FIELD.label = 1
var_0_18.CARD_SKILL_SET_REQ_FIELD.has_default_value = false
var_0_18.CARD_SKILL_SET_REQ_FIELD.default_value = nil
var_0_18.CARD_SKILL_SET_REQ_FIELD.message_type = CARDSKILLSETREQ
var_0_18.CARD_SKILL_SET_REQ_FIELD.type = 11
var_0_18.CARD_SKILL_SET_REQ_FIELD.cpp_type = 10
var_0_18.CARD_BOX_INFO_REQ_FIELD.name = "card_box_info_req"
var_0_18.CARD_BOX_INFO_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_box_info_req"
var_0_18.CARD_BOX_INFO_REQ_FIELD.number = 512
var_0_18.CARD_BOX_INFO_REQ_FIELD.index = 12
var_0_18.CARD_BOX_INFO_REQ_FIELD.label = 1
var_0_18.CARD_BOX_INFO_REQ_FIELD.has_default_value = false
var_0_18.CARD_BOX_INFO_REQ_FIELD.default_value = 0
var_0_18.CARD_BOX_INFO_REQ_FIELD.type = 5
var_0_18.CARD_BOX_INFO_REQ_FIELD.cpp_type = 1
var_0_18.RESET_CARD_BOX_REQ_FIELD.name = "reset_card_box_req"
var_0_18.RESET_CARD_BOX_REQ_FIELD.full_name = ".sgland.SglCardMsg.reset_card_box_req"
var_0_18.RESET_CARD_BOX_REQ_FIELD.number = 513
var_0_18.RESET_CARD_BOX_REQ_FIELD.index = 13
var_0_18.RESET_CARD_BOX_REQ_FIELD.label = 1
var_0_18.RESET_CARD_BOX_REQ_FIELD.has_default_value = false
var_0_18.RESET_CARD_BOX_REQ_FIELD.default_value = 0
var_0_18.RESET_CARD_BOX_REQ_FIELD.type = 5
var_0_18.RESET_CARD_BOX_REQ_FIELD.cpp_type = 1
var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD.name = "card_compose_package_id"
var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD.full_name = ".sgland.SglCardMsg.card_compose_package_id"
var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD.number = 514
var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD.index = 14
var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD.label = 1
var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD.has_default_value = false
var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD.default_value = 0
var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD.type = 5
var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD.cpp_type = 1
var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD.name = "card_lottery_use_token"
var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD.full_name = ".sgland.SglCardMsg.card_lottery_use_token"
var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD.number = 515
var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD.index = 15
var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD.label = 1
var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD.has_default_value = false
var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD.default_value = 0
var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD.type = 5
var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD.cpp_type = 1
var_0_18.CARD_RECOVERY_REQ_FIELD.name = "card_recovery_req"
var_0_18.CARD_RECOVERY_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_recovery_req"
var_0_18.CARD_RECOVERY_REQ_FIELD.number = 516
var_0_18.CARD_RECOVERY_REQ_FIELD.index = 16
var_0_18.CARD_RECOVERY_REQ_FIELD.label = 1
var_0_18.CARD_RECOVERY_REQ_FIELD.has_default_value = false
var_0_18.CARD_RECOVERY_REQ_FIELD.default_value = nil
var_0_18.CARD_RECOVERY_REQ_FIELD.message_type = var_0_2.RESOURCE
var_0_18.CARD_RECOVERY_REQ_FIELD.type = 11
var_0_18.CARD_RECOVERY_REQ_FIELD.cpp_type = 10
var_0_18.LEGEND_CARD_COMPOSE_FIELD.name = "legend_card_compose"
var_0_18.LEGEND_CARD_COMPOSE_FIELD.full_name = ".sgland.SglCardMsg.legend_card_compose"
var_0_18.LEGEND_CARD_COMPOSE_FIELD.number = 517
var_0_18.LEGEND_CARD_COMPOSE_FIELD.index = 17
var_0_18.LEGEND_CARD_COMPOSE_FIELD.label = 1
var_0_18.LEGEND_CARD_COMPOSE_FIELD.has_default_value = false
var_0_18.LEGEND_CARD_COMPOSE_FIELD.default_value = 0
var_0_18.LEGEND_CARD_COMPOSE_FIELD.type = 5
var_0_18.LEGEND_CARD_COMPOSE_FIELD.cpp_type = 1
var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD.name = "legend_card_compose_pkg"
var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD.full_name = ".sgland.SglCardMsg.legend_card_compose_pkg"
var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD.number = 518
var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD.index = 18
var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD.label = 1
var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD.has_default_value = false
var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD.default_value = 0
var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD.type = 5
var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD.cpp_type = 1
var_0_18.FESTIVAL_REQ_FIELD.name = "festival_req"
var_0_18.FESTIVAL_REQ_FIELD.full_name = ".sgland.SglCardMsg.festival_req"
var_0_18.FESTIVAL_REQ_FIELD.number = 519
var_0_18.FESTIVAL_REQ_FIELD.index = 19
var_0_18.FESTIVAL_REQ_FIELD.label = 1
var_0_18.FESTIVAL_REQ_FIELD.has_default_value = false
var_0_18.FESTIVAL_REQ_FIELD.default_value = 0
var_0_18.FESTIVAL_REQ_FIELD.type = 5
var_0_18.FESTIVAL_REQ_FIELD.cpp_type = 1
var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD.name = "festival_lottery_use_token"
var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD.full_name = ".sgland.SglCardMsg.festival_lottery_use_token"
var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD.number = 520
var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD.index = 20
var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD.label = 1
var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD.has_default_value = false
var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD.default_value = false
var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD.type = 8
var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD.cpp_type = 7
var_0_18.LEGEND_TRANSLATE_REQ_FIELD.name = "legend_translate_req"
var_0_18.LEGEND_TRANSLATE_REQ_FIELD.full_name = ".sgland.SglCardMsg.legend_translate_req"
var_0_18.LEGEND_TRANSLATE_REQ_FIELD.number = 521
var_0_18.LEGEND_TRANSLATE_REQ_FIELD.index = 21
var_0_18.LEGEND_TRANSLATE_REQ_FIELD.label = 1
var_0_18.LEGEND_TRANSLATE_REQ_FIELD.has_default_value = false
var_0_18.LEGEND_TRANSLATE_REQ_FIELD.default_value = 0
var_0_18.LEGEND_TRANSLATE_REQ_FIELD.type = 5
var_0_18.LEGEND_TRANSLATE_REQ_FIELD.cpp_type = 1
var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD.name = "lottery_turn_table_req"
var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD.full_name = ".sgland.SglCardMsg.lottery_turn_table_req"
var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD.number = 522
var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD.index = 22
var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD.label = 1
var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD.has_default_value = false
var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD.default_value = 0
var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD.type = 5
var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD.cpp_type = 1
var_0_18.UP_PKG_CARD_REQ_FIELD.name = "up_pkg_card_req"
var_0_18.UP_PKG_CARD_REQ_FIELD.full_name = ".sgland.SglCardMsg.up_pkg_card_req"
var_0_18.UP_PKG_CARD_REQ_FIELD.number = 523
var_0_18.UP_PKG_CARD_REQ_FIELD.index = 23
var_0_18.UP_PKG_CARD_REQ_FIELD.label = 1
var_0_18.UP_PKG_CARD_REQ_FIELD.has_default_value = false
var_0_18.UP_PKG_CARD_REQ_FIELD.default_value = nil
var_0_18.UP_PKG_CARD_REQ_FIELD.message_type = UPPKGCARDREQ
var_0_18.UP_PKG_CARD_REQ_FIELD.type = 11
var_0_18.UP_PKG_CARD_REQ_FIELD.cpp_type = 10
var_0_18.CARD_COLLECT_REQ_FIELD.name = "card_collect_req"
var_0_18.CARD_COLLECT_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_collect_req"
var_0_18.CARD_COLLECT_REQ_FIELD.number = 524
var_0_18.CARD_COLLECT_REQ_FIELD.index = 24
var_0_18.CARD_COLLECT_REQ_FIELD.label = 3
var_0_18.CARD_COLLECT_REQ_FIELD.has_default_value = false
var_0_18.CARD_COLLECT_REQ_FIELD.default_value = {}
var_0_18.CARD_COLLECT_REQ_FIELD.type = 5
var_0_18.CARD_COLLECT_REQ_FIELD.cpp_type = 1
var_0_18.RUBBING_CARD_REQ_FIELD.name = "rubbing_card_req"
var_0_18.RUBBING_CARD_REQ_FIELD.full_name = ".sgland.SglCardMsg.rubbing_card_req"
var_0_18.RUBBING_CARD_REQ_FIELD.number = 525
var_0_18.RUBBING_CARD_REQ_FIELD.index = 25
var_0_18.RUBBING_CARD_REQ_FIELD.label = 1
var_0_18.RUBBING_CARD_REQ_FIELD.has_default_value = false
var_0_18.RUBBING_CARD_REQ_FIELD.default_value = nil
var_0_18.RUBBING_CARD_REQ_FIELD.message_type = RUBBINGCARDREQ
var_0_18.RUBBING_CARD_REQ_FIELD.type = 11
var_0_18.RUBBING_CARD_REQ_FIELD.cpp_type = 10
var_0_18.CARD_UNRUBBING_REQ_FIELD.name = "card_unrubbing_req"
var_0_18.CARD_UNRUBBING_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_unrubbing_req"
var_0_18.CARD_UNRUBBING_REQ_FIELD.number = 526
var_0_18.CARD_UNRUBBING_REQ_FIELD.index = 26
var_0_18.CARD_UNRUBBING_REQ_FIELD.label = 1
var_0_18.CARD_UNRUBBING_REQ_FIELD.has_default_value = false
var_0_18.CARD_UNRUBBING_REQ_FIELD.default_value = 0
var_0_18.CARD_UNRUBBING_REQ_FIELD.type = 5
var_0_18.CARD_UNRUBBING_REQ_FIELD.cpp_type = 1
var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD.name = "card_remove_rubbing_req"
var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD.full_name = ".sgland.SglCardMsg.card_remove_rubbing_req"
var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD.number = 527
var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD.index = 27
var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD.label = 1
var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD.has_default_value = false
var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD.default_value = 0
var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD.type = 5
var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD.cpp_type = 1
var_0_18.CARD_LOTTERY_RESP_FIELD.name = "card_lottery_resp"
var_0_18.CARD_LOTTERY_RESP_FIELD.full_name = ".sgland.SglCardMsg.card_lottery_resp"
var_0_18.CARD_LOTTERY_RESP_FIELD.number = 500
var_0_18.CARD_LOTTERY_RESP_FIELD.index = 28
var_0_18.CARD_LOTTERY_RESP_FIELD.label = 3
var_0_18.CARD_LOTTERY_RESP_FIELD.has_default_value = false
var_0_18.CARD_LOTTERY_RESP_FIELD.default_value = {}
var_0_18.CARD_LOTTERY_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_18.CARD_LOTTERY_RESP_FIELD.type = 11
var_0_18.CARD_LOTTERY_RESP_FIELD.cpp_type = 10
var_0_18.BOOK_LOTTERY_RESP_FIELD.name = "book_lottery_resp"
var_0_18.BOOK_LOTTERY_RESP_FIELD.full_name = ".sgland.SglCardMsg.book_lottery_resp"
var_0_18.BOOK_LOTTERY_RESP_FIELD.number = 502
var_0_18.BOOK_LOTTERY_RESP_FIELD.index = 29
var_0_18.BOOK_LOTTERY_RESP_FIELD.label = 3
var_0_18.BOOK_LOTTERY_RESP_FIELD.has_default_value = false
var_0_18.BOOK_LOTTERY_RESP_FIELD.default_value = {}
var_0_18.BOOK_LOTTERY_RESP_FIELD.message_type = BOOKLOTTERYRESP
var_0_18.BOOK_LOTTERY_RESP_FIELD.type = 11
var_0_18.BOOK_LOTTERY_RESP_FIELD.cpp_type = 10
var_0_18.CARD_EVOLUTION_RESP_FIELD.name = "card_evolution_resp"
var_0_18.CARD_EVOLUTION_RESP_FIELD.full_name = ".sgland.SglCardMsg.card_evolution_resp"
var_0_18.CARD_EVOLUTION_RESP_FIELD.number = 503
var_0_18.CARD_EVOLUTION_RESP_FIELD.index = 30
var_0_18.CARD_EVOLUTION_RESP_FIELD.label = 1
var_0_18.CARD_EVOLUTION_RESP_FIELD.has_default_value = false
var_0_18.CARD_EVOLUTION_RESP_FIELD.default_value = nil
var_0_18.CARD_EVOLUTION_RESP_FIELD.message_type = CARDEVOLUTIONRESP
var_0_18.CARD_EVOLUTION_RESP_FIELD.type = 11
var_0_18.CARD_EVOLUTION_RESP_FIELD.cpp_type = 10
var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD.name = "card_lottery_record_resp"
var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD.full_name = ".sgland.SglCardMsg.card_lottery_record_resp"
var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD.number = 504
var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD.index = 31
var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD.label = 1
var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD.has_default_value = false
var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD.default_value = nil
var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD.message_type = LOTTERYRECORD
var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD.type = 11
var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD.cpp_type = 10
var_0_18.CARD_TRANSFER_RESP_FIELD.name = "card_transfer_resp"
var_0_18.CARD_TRANSFER_RESP_FIELD.full_name = ".sgland.SglCardMsg.card_transfer_resp"
var_0_18.CARD_TRANSFER_RESP_FIELD.number = 505
var_0_18.CARD_TRANSFER_RESP_FIELD.index = 32
var_0_18.CARD_TRANSFER_RESP_FIELD.label = 3
var_0_18.CARD_TRANSFER_RESP_FIELD.has_default_value = false
var_0_18.CARD_TRANSFER_RESP_FIELD.default_value = {}
var_0_18.CARD_TRANSFER_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_18.CARD_TRANSFER_RESP_FIELD.type = 11
var_0_18.CARD_TRANSFER_RESP_FIELD.cpp_type = 10
var_0_18.CARD_BOX_INFO_RESP_FIELD.name = "card_box_info_resp"
var_0_18.CARD_BOX_INFO_RESP_FIELD.full_name = ".sgland.SglCardMsg.card_box_info_resp"
var_0_18.CARD_BOX_INFO_RESP_FIELD.number = 506
var_0_18.CARD_BOX_INFO_RESP_FIELD.index = 33
var_0_18.CARD_BOX_INFO_RESP_FIELD.label = 3
var_0_18.CARD_BOX_INFO_RESP_FIELD.has_default_value = false
var_0_18.CARD_BOX_INFO_RESP_FIELD.default_value = {}
var_0_18.CARD_BOX_INFO_RESP_FIELD.message_type = var_0_2.CARDBOXCARDINFO
var_0_18.CARD_BOX_INFO_RESP_FIELD.type = 11
var_0_18.CARD_BOX_INFO_RESP_FIELD.cpp_type = 10
var_0_18.REMAIN_PKG_UR_RESP_FIELD.name = "remain_pkg_ur_resp"
var_0_18.REMAIN_PKG_UR_RESP_FIELD.full_name = ".sgland.SglCardMsg.remain_pkg_ur_resp"
var_0_18.REMAIN_PKG_UR_RESP_FIELD.number = 507
var_0_18.REMAIN_PKG_UR_RESP_FIELD.index = 34
var_0_18.REMAIN_PKG_UR_RESP_FIELD.label = 1
var_0_18.REMAIN_PKG_UR_RESP_FIELD.has_default_value = false
var_0_18.REMAIN_PKG_UR_RESP_FIELD.default_value = 0
var_0_18.REMAIN_PKG_UR_RESP_FIELD.type = 5
var_0_18.REMAIN_PKG_UR_RESP_FIELD.cpp_type = 1
var_0_18.RARE_PKG_RESOURCE_RESP_FIELD.name = "rare_pkg_resource_resp"
var_0_18.RARE_PKG_RESOURCE_RESP_FIELD.full_name = ".sgland.SglCardMsg.rare_pkg_resource_resp"
var_0_18.RARE_PKG_RESOURCE_RESP_FIELD.number = 508
var_0_18.RARE_PKG_RESOURCE_RESP_FIELD.index = 35
var_0_18.RARE_PKG_RESOURCE_RESP_FIELD.label = 3
var_0_18.RARE_PKG_RESOURCE_RESP_FIELD.has_default_value = false
var_0_18.RARE_PKG_RESOURCE_RESP_FIELD.default_value = {}
var_0_18.RARE_PKG_RESOURCE_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_18.RARE_PKG_RESOURCE_RESP_FIELD.type = 11
var_0_18.RARE_PKG_RESOURCE_RESP_FIELD.cpp_type = 10
var_0_18.FESTIVAL_BOX_RESP_FIELD.name = "festival_box_resp"
var_0_18.FESTIVAL_BOX_RESP_FIELD.full_name = ".sgland.SglCardMsg.festival_box_resp"
var_0_18.FESTIVAL_BOX_RESP_FIELD.number = 509
var_0_18.FESTIVAL_BOX_RESP_FIELD.index = 36
var_0_18.FESTIVAL_BOX_RESP_FIELD.label = 1
var_0_18.FESTIVAL_BOX_RESP_FIELD.has_default_value = false
var_0_18.FESTIVAL_BOX_RESP_FIELD.default_value = nil
var_0_18.FESTIVAL_BOX_RESP_FIELD.message_type = var_0_2.FESTIVALBOX
var_0_18.FESTIVAL_BOX_RESP_FIELD.type = 11
var_0_18.FESTIVAL_BOX_RESP_FIELD.cpp_type = 10
var_0_18.LOTTERY_FESTIVAL_RESP_FIELD.name = "lottery_festival_resp"
var_0_18.LOTTERY_FESTIVAL_RESP_FIELD.full_name = ".sgland.SglCardMsg.lottery_festival_resp"
var_0_18.LOTTERY_FESTIVAL_RESP_FIELD.number = 510
var_0_18.LOTTERY_FESTIVAL_RESP_FIELD.index = 37
var_0_18.LOTTERY_FESTIVAL_RESP_FIELD.label = 1
var_0_18.LOTTERY_FESTIVAL_RESP_FIELD.has_default_value = false
var_0_18.LOTTERY_FESTIVAL_RESP_FIELD.default_value = nil
var_0_18.LOTTERY_FESTIVAL_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_18.LOTTERY_FESTIVAL_RESP_FIELD.type = 11
var_0_18.LOTTERY_FESTIVAL_RESP_FIELD.cpp_type = 10
var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD.name = "lottery_turn_table_resp"
var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD.full_name = ".sgland.SglCardMsg.lottery_turn_table_resp"
var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD.number = 511
var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD.index = 38
var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD.label = 3
var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD.has_default_value = false
var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD.default_value = {}
var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD.type = 11
var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD.cpp_type = 10
var_0_18.UP_PKG_CARD_ID_RESP_FIELD.name = "up_pkg_card_id_resp"
var_0_18.UP_PKG_CARD_ID_RESP_FIELD.full_name = ".sgland.SglCardMsg.up_pkg_card_id_resp"
var_0_18.UP_PKG_CARD_ID_RESP_FIELD.number = 512
var_0_18.UP_PKG_CARD_ID_RESP_FIELD.index = 39
var_0_18.UP_PKG_CARD_ID_RESP_FIELD.label = 1
var_0_18.UP_PKG_CARD_ID_RESP_FIELD.has_default_value = false
var_0_18.UP_PKG_CARD_ID_RESP_FIELD.default_value = nil
var_0_18.UP_PKG_CARD_ID_RESP_FIELD.message_type = UPPKGCARDRESP
var_0_18.UP_PKG_CARD_ID_RESP_FIELD.type = 11
var_0_18.UP_PKG_CARD_ID_RESP_FIELD.cpp_type = 10
SGLCARDMSG.name = "SglCardMsg"
SGLCARDMSG.full_name = ".sgland.SglCardMsg"
SGLCARDMSG.nested_types = {}
SGLCARDMSG.enum_types = {}
SGLCARDMSG.fields = {}
SGLCARDMSG.is_extendable = false
SGLCARDMSG.extensions = {
	var_0_18.CARD_UPGRADE_REQ_FIELD,
	var_0_18.CARD_EVOLUTION_REQ_FIELD,
	var_0_18.CARD_SELL_REQ_FIELD,
	var_0_18.CARD_UNLOCK_REQ_FIELD,
	var_0_18.CARD_COMPOSE_REQ_FIELD,
	var_0_18.CARD_DECOMPOSE_REQ_FIELD,
	var_0_18.CARD_EQUIP_REQ_FIELD,
	var_0_18.CARD_RECOVER_REQ_FIELD,
	var_0_18.CARD_TRANSFORM_REQ_FIELD,
	var_0_18.CARD_LOTTERY_REQ_FIELD,
	var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD,
	var_0_18.CARD_SKILL_SET_REQ_FIELD,
	var_0_18.CARD_BOX_INFO_REQ_FIELD,
	var_0_18.RESET_CARD_BOX_REQ_FIELD,
	var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD,
	var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD,
	var_0_18.CARD_RECOVERY_REQ_FIELD,
	var_0_18.LEGEND_CARD_COMPOSE_FIELD,
	var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD,
	var_0_18.FESTIVAL_REQ_FIELD,
	var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD,
	var_0_18.LEGEND_TRANSLATE_REQ_FIELD,
	var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD,
	var_0_18.UP_PKG_CARD_REQ_FIELD,
	var_0_18.CARD_COLLECT_REQ_FIELD,
	var_0_18.RUBBING_CARD_REQ_FIELD,
	var_0_18.CARD_UNRUBBING_REQ_FIELD,
	var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD,
	var_0_18.CARD_LOTTERY_RESP_FIELD,
	var_0_18.BOOK_LOTTERY_RESP_FIELD,
	var_0_18.CARD_EVOLUTION_RESP_FIELD,
	var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD,
	var_0_18.CARD_TRANSFER_RESP_FIELD,
	var_0_18.CARD_BOX_INFO_RESP_FIELD,
	var_0_18.REMAIN_PKG_UR_RESP_FIELD,
	var_0_18.RARE_PKG_RESOURCE_RESP_FIELD,
	var_0_18.FESTIVAL_BOX_RESP_FIELD,
	var_0_18.LOTTERY_FESTIVAL_RESP_FIELD,
	var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD,
	var_0_18.UP_PKG_CARD_ID_RESP_FIELD
}
BookLotteryResp = var_0_0.Message(BOOKLOTTERYRESP)
CardEquipReq = var_0_0.Message(CARDEQUIPREQ)
CardEvolutionReq = var_0_0.Message(CARDEVOLUTIONREQ)
CardEvolutionResp = var_0_0.Message(CARDEVOLUTIONRESP)
CardLotteryReq = var_0_0.Message(CARDLOTTERYREQ)
CardRecoverReq = var_0_0.Message(CARDRECOVERREQ)
CardSellReq = var_0_0.Message(CARDSELLREQ)
CardSkillSetReq = var_0_0.Message(CARDSKILLSETREQ)
CardSplitReq = var_0_0.Message(CARDSPLITREQ)
CardTransformReq = var_0_0.Message(CARDTRANSFORMREQ)
CardUpgradeReq = var_0_0.Message(CARDUPGRADEREQ)
LotteryRecord = var_0_0.Message(LOTTERYRECORD)
RubbingCardReq = var_0_0.Message(RUBBINGCARDREQ)
SglCardMsg = var_0_0.Message(SGLCARDMSG)
UpPkgCardReq = var_0_0.Message(UPPKGCARDREQ)
UpPkgCardResp = var_0_0.Message(UPPKGCARDRESP)

var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_UPGRADE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_EVOLUTION_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_SELL_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_UNLOCK_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_COMPOSE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_DECOMPOSE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_EQUIP_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_RECOVER_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_TRANSFORM_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_LOTTERY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_LOTTERY_RECORD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_SKILL_SET_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_BOX_INFO_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.RESET_CARD_BOX_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_COMPOSE_PACKAGE_ID_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_LOTTERY_USE_TOKEN_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_RECOVERY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.LEGEND_CARD_COMPOSE_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.LEGEND_CARD_COMPOSE_PKG_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.FESTIVAL_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.FESTIVAL_LOTTERY_USE_TOKEN_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.LEGEND_TRANSLATE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.LOTTERY_TURN_TABLE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.UP_PKG_CARD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_COLLECT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.RUBBING_CARD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_UNRUBBING_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_18.CARD_REMOVE_RUBBING_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.CARD_LOTTERY_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.BOOK_LOTTERY_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.CARD_EVOLUTION_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.CARD_LOTTERY_RECORD_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.CARD_TRANSFER_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.CARD_BOX_INFO_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.REMAIN_PKG_UR_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.RARE_PKG_RESOURCE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.FESTIVAL_BOX_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.LOTTERY_FESTIVAL_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.LOTTERY_TURN_TABLE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_18.UP_PKG_CARD_ID_RESP_FIELD)
