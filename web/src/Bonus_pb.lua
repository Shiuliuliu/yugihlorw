local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Bonus_pb")

BONUSLADDER = var_0_0.Descriptor()

local var_0_3 = {
	INFO_FIELD = var_0_0.FieldDescriptor(),
	BONUS_ID_FIELD = var_0_0.FieldDescriptor(),
	TITLE_FIELD = var_0_0.FieldDescriptor(),
	EXTRA_FIELD = var_0_0.FieldDescriptor()
}

SENDGIFT = var_0_0.Descriptor()

local var_0_4 = {
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	BONUS_ID_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor(),
	RESOURCE_FIELD = var_0_0.FieldDescriptor()
}

CLAIMFUNDREQ = var_0_0.Descriptor()

local var_0_5 = {
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	DAY_FIELD = var_0_0.FieldDescriptor()
}

SGLBONUSMSG = var_0_0.Descriptor()

local var_0_6 = {
	BONUS_CLAIM_REQ_FIELD = var_0_0.FieldDescriptor(),
	BONUS_ACTIVITY_CLAIM_REQ_FIELD = var_0_0.FieldDescriptor(),
	BONUS_TEACHING_FINISH_REQ_FIELD = var_0_0.FieldDescriptor(),
	DAILY_TASK_RESET_REQ_FIELD = var_0_0.FieldDescriptor(),
	SEND_GIFT_REQ_FIELD = var_0_0.FieldDescriptor(),
	CLAIM_FUND_REQ_FIELD = var_0_0.FieldDescriptor(),
	BONUS_ACTIVITY_RESP_FIELD = var_0_0.FieldDescriptor(),
	PLAYER_BONUS_FIELD = var_0_0.FieldDescriptor(),
	BONUS_COUNT_FIELD = var_0_0.FieldDescriptor(),
	DAILY_TASK_FIELD = var_0_0.FieldDescriptor(),
	ENVELOPE_RES_FIELD = var_0_0.FieldDescriptor(),
	FUND_RES_FIELD = var_0_0.FieldDescriptor(),
	CHARGE_ENVELOPE_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.INFO_FIELD.name = "info"
var_0_3.INFO_FIELD.full_name = ".sgland.BonusLadder.info"
var_0_3.INFO_FIELD.number = 1
var_0_3.INFO_FIELD.index = 0
var_0_3.INFO_FIELD.label = 2
var_0_3.INFO_FIELD.has_default_value = false
var_0_3.INFO_FIELD.default_value = nil
var_0_3.INFO_FIELD.message_type = var_0_2.ACCOUNTINFO
var_0_3.INFO_FIELD.type = 11
var_0_3.INFO_FIELD.cpp_type = 10
var_0_3.BONUS_ID_FIELD.name = "bonus_id"
var_0_3.BONUS_ID_FIELD.full_name = ".sgland.BonusLadder.bonus_id"
var_0_3.BONUS_ID_FIELD.number = 2
var_0_3.BONUS_ID_FIELD.index = 1
var_0_3.BONUS_ID_FIELD.label = 2
var_0_3.BONUS_ID_FIELD.has_default_value = false
var_0_3.BONUS_ID_FIELD.default_value = 0
var_0_3.BONUS_ID_FIELD.type = 5
var_0_3.BONUS_ID_FIELD.cpp_type = 1
var_0_3.TITLE_FIELD.name = "title"
var_0_3.TITLE_FIELD.full_name = ".sgland.BonusLadder.title"
var_0_3.TITLE_FIELD.number = 3
var_0_3.TITLE_FIELD.index = 2
var_0_3.TITLE_FIELD.label = 1
var_0_3.TITLE_FIELD.has_default_value = false
var_0_3.TITLE_FIELD.default_value = ""
var_0_3.TITLE_FIELD.type = 9
var_0_3.TITLE_FIELD.cpp_type = 9
var_0_3.EXTRA_FIELD.name = "extra"
var_0_3.EXTRA_FIELD.full_name = ".sgland.BonusLadder.extra"
var_0_3.EXTRA_FIELD.number = 4
var_0_3.EXTRA_FIELD.index = 3
var_0_3.EXTRA_FIELD.label = 1
var_0_3.EXTRA_FIELD.has_default_value = false
var_0_3.EXTRA_FIELD.default_value = nil
var_0_3.EXTRA_FIELD.message_type = var_0_2.EXTRA
var_0_3.EXTRA_FIELD.type = 11
var_0_3.EXTRA_FIELD.cpp_type = 10
BONUSLADDER.name = "BonusLadder"
BONUSLADDER.full_name = ".sgland.BonusLadder"
BONUSLADDER.nested_types = {}
BONUSLADDER.enum_types = {}
BONUSLADDER.fields = {
	var_0_3.INFO_FIELD,
	var_0_3.BONUS_ID_FIELD,
	var_0_3.TITLE_FIELD,
	var_0_3.EXTRA_FIELD
}
BONUSLADDER.is_extendable = false
BONUSLADDER.extensions = {}
var_0_4.USER_ID_FIELD.name = "user_id"
var_0_4.USER_ID_FIELD.full_name = ".sgland.SendGift.user_id"
var_0_4.USER_ID_FIELD.number = 1
var_0_4.USER_ID_FIELD.index = 0
var_0_4.USER_ID_FIELD.label = 2
var_0_4.USER_ID_FIELD.has_default_value = false
var_0_4.USER_ID_FIELD.default_value = 0
var_0_4.USER_ID_FIELD.type = 5
var_0_4.USER_ID_FIELD.cpp_type = 1
var_0_4.BONUS_ID_FIELD.name = "bonus_id"
var_0_4.BONUS_ID_FIELD.full_name = ".sgland.SendGift.bonus_id"
var_0_4.BONUS_ID_FIELD.number = 2
var_0_4.BONUS_ID_FIELD.index = 1
var_0_4.BONUS_ID_FIELD.label = 2
var_0_4.BONUS_ID_FIELD.has_default_value = false
var_0_4.BONUS_ID_FIELD.default_value = 0
var_0_4.BONUS_ID_FIELD.type = 5
var_0_4.BONUS_ID_FIELD.cpp_type = 1
var_0_4.COUNT_FIELD.name = "count"
var_0_4.COUNT_FIELD.full_name = ".sgland.SendGift.count"
var_0_4.COUNT_FIELD.number = 3
var_0_4.COUNT_FIELD.index = 2
var_0_4.COUNT_FIELD.label = 1
var_0_4.COUNT_FIELD.has_default_value = false
var_0_4.COUNT_FIELD.default_value = 0
var_0_4.COUNT_FIELD.type = 5
var_0_4.COUNT_FIELD.cpp_type = 1
var_0_4.RESOURCE_FIELD.name = "resource"
var_0_4.RESOURCE_FIELD.full_name = ".sgland.SendGift.resource"
var_0_4.RESOURCE_FIELD.number = 4
var_0_4.RESOURCE_FIELD.index = 3
var_0_4.RESOURCE_FIELD.label = 1
var_0_4.RESOURCE_FIELD.has_default_value = false
var_0_4.RESOURCE_FIELD.default_value = nil
var_0_4.RESOURCE_FIELD.message_type = var_0_2.RESOURCE
var_0_4.RESOURCE_FIELD.type = 11
var_0_4.RESOURCE_FIELD.cpp_type = 10
SENDGIFT.name = "SendGift"
SENDGIFT.full_name = ".sgland.SendGift"
SENDGIFT.nested_types = {}
SENDGIFT.enum_types = {}
SENDGIFT.fields = {
	var_0_4.USER_ID_FIELD,
	var_0_4.BONUS_ID_FIELD,
	var_0_4.COUNT_FIELD,
	var_0_4.RESOURCE_FIELD
}
SENDGIFT.is_extendable = false
SENDGIFT.extensions = {}
var_0_5.TYPE_FIELD.name = "type"
var_0_5.TYPE_FIELD.full_name = ".sgland.ClaimFundReq.type"
var_0_5.TYPE_FIELD.number = 1
var_0_5.TYPE_FIELD.index = 0
var_0_5.TYPE_FIELD.label = 2
var_0_5.TYPE_FIELD.has_default_value = false
var_0_5.TYPE_FIELD.default_value = 0
var_0_5.TYPE_FIELD.type = 5
var_0_5.TYPE_FIELD.cpp_type = 1
var_0_5.DAY_FIELD.name = "day"
var_0_5.DAY_FIELD.full_name = ".sgland.ClaimFundReq.day"
var_0_5.DAY_FIELD.number = 2
var_0_5.DAY_FIELD.index = 1
var_0_5.DAY_FIELD.label = 2
var_0_5.DAY_FIELD.has_default_value = false
var_0_5.DAY_FIELD.default_value = 0
var_0_5.DAY_FIELD.type = 5
var_0_5.DAY_FIELD.cpp_type = 1
CLAIMFUNDREQ.name = "ClaimFundReq"
CLAIMFUNDREQ.full_name = ".sgland.ClaimFundReq"
CLAIMFUNDREQ.nested_types = {}
CLAIMFUNDREQ.enum_types = {}
CLAIMFUNDREQ.fields = {
	var_0_5.TYPE_FIELD,
	var_0_5.DAY_FIELD
}
CLAIMFUNDREQ.is_extendable = false
CLAIMFUNDREQ.extensions = {}
var_0_6.BONUS_CLAIM_REQ_FIELD.name = "bonus_claim_req"
var_0_6.BONUS_CLAIM_REQ_FIELD.full_name = ".sgland.SglBonusMsg.bonus_claim_req"
var_0_6.BONUS_CLAIM_REQ_FIELD.number = 1200
var_0_6.BONUS_CLAIM_REQ_FIELD.index = 0
var_0_6.BONUS_CLAIM_REQ_FIELD.label = 1
var_0_6.BONUS_CLAIM_REQ_FIELD.has_default_value = false
var_0_6.BONUS_CLAIM_REQ_FIELD.default_value = 0
var_0_6.BONUS_CLAIM_REQ_FIELD.type = 5
var_0_6.BONUS_CLAIM_REQ_FIELD.cpp_type = 1
var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD.name = "bonus_activity_claim_req"
var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD.full_name = ".sgland.SglBonusMsg.bonus_activity_claim_req"
var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD.number = 1201
var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD.index = 1
var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD.label = 1
var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD.has_default_value = false
var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD.default_value = 0
var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD.type = 3
var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD.cpp_type = 2
var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD.name = "bonus_teaching_finish_req"
var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD.full_name = ".sgland.SglBonusMsg.bonus_teaching_finish_req"
var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD.number = 1202
var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD.index = 2
var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD.label = 1
var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD.has_default_value = false
var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD.default_value = 0
var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD.type = 5
var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD.cpp_type = 1
var_0_6.DAILY_TASK_RESET_REQ_FIELD.name = "daily_task_reset_req"
var_0_6.DAILY_TASK_RESET_REQ_FIELD.full_name = ".sgland.SglBonusMsg.daily_task_reset_req"
var_0_6.DAILY_TASK_RESET_REQ_FIELD.number = 1203
var_0_6.DAILY_TASK_RESET_REQ_FIELD.index = 3
var_0_6.DAILY_TASK_RESET_REQ_FIELD.label = 1
var_0_6.DAILY_TASK_RESET_REQ_FIELD.has_default_value = false
var_0_6.DAILY_TASK_RESET_REQ_FIELD.default_value = 0
var_0_6.DAILY_TASK_RESET_REQ_FIELD.type = 5
var_0_6.DAILY_TASK_RESET_REQ_FIELD.cpp_type = 1
var_0_6.SEND_GIFT_REQ_FIELD.name = "send_gift_req"
var_0_6.SEND_GIFT_REQ_FIELD.full_name = ".sgland.SglBonusMsg.send_gift_req"
var_0_6.SEND_GIFT_REQ_FIELD.number = 1204
var_0_6.SEND_GIFT_REQ_FIELD.index = 4
var_0_6.SEND_GIFT_REQ_FIELD.label = 1
var_0_6.SEND_GIFT_REQ_FIELD.has_default_value = false
var_0_6.SEND_GIFT_REQ_FIELD.default_value = nil
var_0_6.SEND_GIFT_REQ_FIELD.message_type = SENDGIFT
var_0_6.SEND_GIFT_REQ_FIELD.type = 11
var_0_6.SEND_GIFT_REQ_FIELD.cpp_type = 10
var_0_6.CLAIM_FUND_REQ_FIELD.name = "claim_fund_req"
var_0_6.CLAIM_FUND_REQ_FIELD.full_name = ".sgland.SglBonusMsg.claim_fund_req"
var_0_6.CLAIM_FUND_REQ_FIELD.number = 1205
var_0_6.CLAIM_FUND_REQ_FIELD.index = 5
var_0_6.CLAIM_FUND_REQ_FIELD.label = 1
var_0_6.CLAIM_FUND_REQ_FIELD.has_default_value = false
var_0_6.CLAIM_FUND_REQ_FIELD.default_value = nil
var_0_6.CLAIM_FUND_REQ_FIELD.message_type = CLAIMFUNDREQ
var_0_6.CLAIM_FUND_REQ_FIELD.type = 11
var_0_6.CLAIM_FUND_REQ_FIELD.cpp_type = 10
var_0_6.BONUS_ACTIVITY_RESP_FIELD.name = "bonus_activity_resp"
var_0_6.BONUS_ACTIVITY_RESP_FIELD.full_name = ".sgland.SglBonusMsg.bonus_activity_resp"
var_0_6.BONUS_ACTIVITY_RESP_FIELD.number = 1200
var_0_6.BONUS_ACTIVITY_RESP_FIELD.index = 6
var_0_6.BONUS_ACTIVITY_RESP_FIELD.label = 3
var_0_6.BONUS_ACTIVITY_RESP_FIELD.has_default_value = false
var_0_6.BONUS_ACTIVITY_RESP_FIELD.default_value = {}
var_0_6.BONUS_ACTIVITY_RESP_FIELD.message_type = var_0_2.ACTIVITYBONUS
var_0_6.BONUS_ACTIVITY_RESP_FIELD.type = 11
var_0_6.BONUS_ACTIVITY_RESP_FIELD.cpp_type = 10
var_0_6.PLAYER_BONUS_FIELD.name = "player_bonus"
var_0_6.PLAYER_BONUS_FIELD.full_name = ".sgland.SglBonusMsg.player_bonus"
var_0_6.PLAYER_BONUS_FIELD.number = 1201
var_0_6.PLAYER_BONUS_FIELD.index = 7
var_0_6.PLAYER_BONUS_FIELD.label = 1
var_0_6.PLAYER_BONUS_FIELD.has_default_value = false
var_0_6.PLAYER_BONUS_FIELD.default_value = nil
var_0_6.PLAYER_BONUS_FIELD.message_type = var_0_2.PLAYERBONUS
var_0_6.PLAYER_BONUS_FIELD.type = 11
var_0_6.PLAYER_BONUS_FIELD.cpp_type = 10
var_0_6.BONUS_COUNT_FIELD.name = "bonus_count"
var_0_6.BONUS_COUNT_FIELD.full_name = ".sgland.SglBonusMsg.bonus_count"
var_0_6.BONUS_COUNT_FIELD.number = 1202
var_0_6.BONUS_COUNT_FIELD.index = 8
var_0_6.BONUS_COUNT_FIELD.label = 1
var_0_6.BONUS_COUNT_FIELD.has_default_value = false
var_0_6.BONUS_COUNT_FIELD.default_value = 0
var_0_6.BONUS_COUNT_FIELD.type = 5
var_0_6.BONUS_COUNT_FIELD.cpp_type = 1
var_0_6.DAILY_TASK_FIELD.name = "daily_task"
var_0_6.DAILY_TASK_FIELD.full_name = ".sgland.SglBonusMsg.daily_task"
var_0_6.DAILY_TASK_FIELD.number = 1203
var_0_6.DAILY_TASK_FIELD.index = 9
var_0_6.DAILY_TASK_FIELD.label = 3
var_0_6.DAILY_TASK_FIELD.has_default_value = false
var_0_6.DAILY_TASK_FIELD.default_value = {}
var_0_6.DAILY_TASK_FIELD.message_type = var_0_2.BONUS
var_0_6.DAILY_TASK_FIELD.type = 11
var_0_6.DAILY_TASK_FIELD.cpp_type = 10
var_0_6.ENVELOPE_RES_FIELD.name = "envelope_res"
var_0_6.ENVELOPE_RES_FIELD.full_name = ".sgland.SglBonusMsg.envelope_res"
var_0_6.ENVELOPE_RES_FIELD.number = 1204
var_0_6.ENVELOPE_RES_FIELD.index = 10
var_0_6.ENVELOPE_RES_FIELD.label = 1
var_0_6.ENVELOPE_RES_FIELD.has_default_value = false
var_0_6.ENVELOPE_RES_FIELD.default_value = nil
var_0_6.ENVELOPE_RES_FIELD.message_type = var_0_2.RESOURCE
var_0_6.ENVELOPE_RES_FIELD.type = 11
var_0_6.ENVELOPE_RES_FIELD.cpp_type = 10
var_0_6.FUND_RES_FIELD.name = "fund_res"
var_0_6.FUND_RES_FIELD.full_name = ".sgland.SglBonusMsg.fund_res"
var_0_6.FUND_RES_FIELD.number = 1205
var_0_6.FUND_RES_FIELD.index = 11
var_0_6.FUND_RES_FIELD.label = 3
var_0_6.FUND_RES_FIELD.has_default_value = false
var_0_6.FUND_RES_FIELD.default_value = {}
var_0_6.FUND_RES_FIELD.message_type = var_0_2.RESOURCE
var_0_6.FUND_RES_FIELD.type = 11
var_0_6.FUND_RES_FIELD.cpp_type = 10
var_0_6.CHARGE_ENVELOPE_RESP_FIELD.name = "charge_envelope_resp"
var_0_6.CHARGE_ENVELOPE_RESP_FIELD.full_name = ".sgland.SglBonusMsg.charge_envelope_resp"
var_0_6.CHARGE_ENVELOPE_RESP_FIELD.number = 1206
var_0_6.CHARGE_ENVELOPE_RESP_FIELD.index = 12
var_0_6.CHARGE_ENVELOPE_RESP_FIELD.label = 1
var_0_6.CHARGE_ENVELOPE_RESP_FIELD.has_default_value = false
var_0_6.CHARGE_ENVELOPE_RESP_FIELD.default_value = nil
var_0_6.CHARGE_ENVELOPE_RESP_FIELD.message_type = var_0_2.USERINFO
var_0_6.CHARGE_ENVELOPE_RESP_FIELD.type = 11
var_0_6.CHARGE_ENVELOPE_RESP_FIELD.cpp_type = 10
SGLBONUSMSG.name = "SglBonusMsg"
SGLBONUSMSG.full_name = ".sgland.SglBonusMsg"
SGLBONUSMSG.nested_types = {}
SGLBONUSMSG.enum_types = {}
SGLBONUSMSG.fields = {}
SGLBONUSMSG.is_extendable = false
SGLBONUSMSG.extensions = {
	var_0_6.BONUS_CLAIM_REQ_FIELD,
	var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD,
	var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD,
	var_0_6.DAILY_TASK_RESET_REQ_FIELD,
	var_0_6.SEND_GIFT_REQ_FIELD,
	var_0_6.CLAIM_FUND_REQ_FIELD,
	var_0_6.BONUS_ACTIVITY_RESP_FIELD,
	var_0_6.PLAYER_BONUS_FIELD,
	var_0_6.BONUS_COUNT_FIELD,
	var_0_6.DAILY_TASK_FIELD,
	var_0_6.ENVELOPE_RES_FIELD,
	var_0_6.FUND_RES_FIELD,
	var_0_6.CHARGE_ENVELOPE_RESP_FIELD
}
BonusLadder = var_0_0.Message(BONUSLADDER)
ClaimFundReq = var_0_0.Message(CLAIMFUNDREQ)
SendGift = var_0_0.Message(SENDGIFT)
SglBonusMsg = var_0_0.Message(SGLBONUSMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_6.BONUS_CLAIM_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.BONUS_ACTIVITY_CLAIM_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.BONUS_TEACHING_FINISH_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.DAILY_TASK_RESET_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.SEND_GIFT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.CLAIM_FUND_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.BONUS_ACTIVITY_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.PLAYER_BONUS_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.BONUS_COUNT_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.DAILY_TASK_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.ENVELOPE_RES_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.FUND_RES_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.CHARGE_ENVELOPE_RESP_FIELD)
