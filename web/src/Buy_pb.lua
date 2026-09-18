local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")

module("Buy_pb")

IAPCALLBACK = var_0_0.Descriptor()

local var_0_2 = {
	PURCHASE_ID_FIELD = var_0_0.FieldDescriptor(),
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	REGION_ID_FIELD = var_0_0.FieldDescriptor(),
	IS_SUCCESS_FIELD = var_0_0.FieldDescriptor(),
	AMOUNT_FIELD = var_0_0.FieldDescriptor(),
	FAIL_DESC_FIELD = var_0_0.FieldDescriptor(),
	PROMO_CODE_FIELD = var_0_0.FieldDescriptor()
}

IAPSTARTRESP = var_0_0.Descriptor()

local var_0_3 = {
	PURCHASE_ID_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor()
}

IAPFINISHREQ = var_0_0.Descriptor()

local var_0_4 = {
	PURCHASE_ID_FIELD = var_0_0.FieldDescriptor(),
	IS_SUCCESS_FIELD = var_0_0.FieldDescriptor(),
	FAIL_DESC_FIELD = var_0_0.FieldDescriptor()
}

IAPFINISHRESP = var_0_0.Descriptor()

local var_0_5 = {
	PURCHASE_ID_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	IS_SUCCESS_FIELD = var_0_0.FieldDescriptor(),
	FAIL_DESC_FIELD = var_0_0.FieldDescriptor(),
	EXTRA_INGOT_FIELD = var_0_0.FieldDescriptor(),
	EXTRA_VIP_EXP_FIELD = var_0_0.FieldDescriptor()
}

BUYDAILYREQ = var_0_0.Descriptor()

local var_0_6 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor()
}

BUYDUSTREQ = var_0_0.Descriptor()

local var_0_7 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	GRADE_FIELD = var_0_0.FieldDescriptor()
}

SGLBUYMSG = var_0_0.Descriptor()

local var_0_8 = {
	IAP_START_REQ_FIELD = var_0_0.FieldDescriptor(),
	IAP_FINISH_REQ_FIELD = var_0_0.FieldDescriptor(),
	BUY_DAILY_REQ_FIELD = var_0_0.FieldDescriptor(),
	BUY_GOLD_REQ_FIELD = var_0_0.FieldDescriptor(),
	BUY_DUST_REQ_FIELD = var_0_0.FieldDescriptor(),
	BUY_BADGE_REQ_FIELD = var_0_0.FieldDescriptor(),
	BUY_BADGE_LEVEL_REQ_FIELD = var_0_0.FieldDescriptor(),
	IAP_START_RESP_FIELD = var_0_0.FieldDescriptor(),
	IAP_FINISH_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_2.PURCHASE_ID_FIELD.name = "purchase_id"
var_0_2.PURCHASE_ID_FIELD.full_name = ".sgland.IAPCallback.purchase_id"
var_0_2.PURCHASE_ID_FIELD.number = 1
var_0_2.PURCHASE_ID_FIELD.index = 0
var_0_2.PURCHASE_ID_FIELD.label = 2
var_0_2.PURCHASE_ID_FIELD.has_default_value = false
var_0_2.PURCHASE_ID_FIELD.default_value = 0
var_0_2.PURCHASE_ID_FIELD.type = 3
var_0_2.PURCHASE_ID_FIELD.cpp_type = 2
var_0_2.USER_ID_FIELD.name = "user_id"
var_0_2.USER_ID_FIELD.full_name = ".sgland.IAPCallback.user_id"
var_0_2.USER_ID_FIELD.number = 2
var_0_2.USER_ID_FIELD.index = 1
var_0_2.USER_ID_FIELD.label = 2
var_0_2.USER_ID_FIELD.has_default_value = false
var_0_2.USER_ID_FIELD.default_value = 0
var_0_2.USER_ID_FIELD.type = 3
var_0_2.USER_ID_FIELD.cpp_type = 2
var_0_2.REGION_ID_FIELD.name = "region_id"
var_0_2.REGION_ID_FIELD.full_name = ".sgland.IAPCallback.region_id"
var_0_2.REGION_ID_FIELD.number = 3
var_0_2.REGION_ID_FIELD.index = 2
var_0_2.REGION_ID_FIELD.label = 2
var_0_2.REGION_ID_FIELD.has_default_value = false
var_0_2.REGION_ID_FIELD.default_value = 0
var_0_2.REGION_ID_FIELD.type = 5
var_0_2.REGION_ID_FIELD.cpp_type = 1
var_0_2.IS_SUCCESS_FIELD.name = "is_success"
var_0_2.IS_SUCCESS_FIELD.full_name = ".sgland.IAPCallback.is_success"
var_0_2.IS_SUCCESS_FIELD.number = 4
var_0_2.IS_SUCCESS_FIELD.index = 3
var_0_2.IS_SUCCESS_FIELD.label = 2
var_0_2.IS_SUCCESS_FIELD.has_default_value = false
var_0_2.IS_SUCCESS_FIELD.default_value = false
var_0_2.IS_SUCCESS_FIELD.type = 8
var_0_2.IS_SUCCESS_FIELD.cpp_type = 7
var_0_2.AMOUNT_FIELD.name = "amount"
var_0_2.AMOUNT_FIELD.full_name = ".sgland.IAPCallback.amount"
var_0_2.AMOUNT_FIELD.number = 5
var_0_2.AMOUNT_FIELD.index = 4
var_0_2.AMOUNT_FIELD.label = 2
var_0_2.AMOUNT_FIELD.has_default_value = false
var_0_2.AMOUNT_FIELD.default_value = 0
var_0_2.AMOUNT_FIELD.type = 2
var_0_2.AMOUNT_FIELD.cpp_type = 6
var_0_2.FAIL_DESC_FIELD.name = "fail_desc"
var_0_2.FAIL_DESC_FIELD.full_name = ".sgland.IAPCallback.fail_desc"
var_0_2.FAIL_DESC_FIELD.number = 6
var_0_2.FAIL_DESC_FIELD.index = 5
var_0_2.FAIL_DESC_FIELD.label = 1
var_0_2.FAIL_DESC_FIELD.has_default_value = false
var_0_2.FAIL_DESC_FIELD.default_value = ""
var_0_2.FAIL_DESC_FIELD.type = 9
var_0_2.FAIL_DESC_FIELD.cpp_type = 9
var_0_2.PROMO_CODE_FIELD.name = "promo_code"
var_0_2.PROMO_CODE_FIELD.full_name = ".sgland.IAPCallback.promo_code"
var_0_2.PROMO_CODE_FIELD.number = 7
var_0_2.PROMO_CODE_FIELD.index = 6
var_0_2.PROMO_CODE_FIELD.label = 1
var_0_2.PROMO_CODE_FIELD.has_default_value = false
var_0_2.PROMO_CODE_FIELD.default_value = ""
var_0_2.PROMO_CODE_FIELD.type = 9
var_0_2.PROMO_CODE_FIELD.cpp_type = 9
IAPCALLBACK.name = "IAPCallback"
IAPCALLBACK.full_name = ".sgland.IAPCallback"
IAPCALLBACK.nested_types = {}
IAPCALLBACK.enum_types = {}
IAPCALLBACK.fields = {
	var_0_2.PURCHASE_ID_FIELD,
	var_0_2.USER_ID_FIELD,
	var_0_2.REGION_ID_FIELD,
	var_0_2.IS_SUCCESS_FIELD,
	var_0_2.AMOUNT_FIELD,
	var_0_2.FAIL_DESC_FIELD,
	var_0_2.PROMO_CODE_FIELD
}
IAPCALLBACK.is_extendable = false
IAPCALLBACK.extensions = {}
var_0_3.PURCHASE_ID_FIELD.name = "purchase_id"
var_0_3.PURCHASE_ID_FIELD.full_name = ".sgland.IAPStartResp.purchase_id"
var_0_3.PURCHASE_ID_FIELD.number = 1
var_0_3.PURCHASE_ID_FIELD.index = 0
var_0_3.PURCHASE_ID_FIELD.label = 2
var_0_3.PURCHASE_ID_FIELD.has_default_value = false
var_0_3.PURCHASE_ID_FIELD.default_value = 0
var_0_3.PURCHASE_ID_FIELD.type = 3
var_0_3.PURCHASE_ID_FIELD.cpp_type = 2
var_0_3.TYPE_FIELD.name = "type"
var_0_3.TYPE_FIELD.full_name = ".sgland.IAPStartResp.type"
var_0_3.TYPE_FIELD.number = 2
var_0_3.TYPE_FIELD.index = 1
var_0_3.TYPE_FIELD.label = 2
var_0_3.TYPE_FIELD.has_default_value = false
var_0_3.TYPE_FIELD.default_value = 0
var_0_3.TYPE_FIELD.type = 5
var_0_3.TYPE_FIELD.cpp_type = 1
IAPSTARTRESP.name = "IAPStartResp"
IAPSTARTRESP.full_name = ".sgland.IAPStartResp"
IAPSTARTRESP.nested_types = {}
IAPSTARTRESP.enum_types = {}
IAPSTARTRESP.fields = {
	var_0_3.PURCHASE_ID_FIELD,
	var_0_3.TYPE_FIELD
}
IAPSTARTRESP.is_extendable = false
IAPSTARTRESP.extensions = {}
var_0_4.PURCHASE_ID_FIELD.name = "purchase_id"
var_0_4.PURCHASE_ID_FIELD.full_name = ".sgland.IAPFinishReq.purchase_id"
var_0_4.PURCHASE_ID_FIELD.number = 1
var_0_4.PURCHASE_ID_FIELD.index = 0
var_0_4.PURCHASE_ID_FIELD.label = 2
var_0_4.PURCHASE_ID_FIELD.has_default_value = false
var_0_4.PURCHASE_ID_FIELD.default_value = 0
var_0_4.PURCHASE_ID_FIELD.type = 3
var_0_4.PURCHASE_ID_FIELD.cpp_type = 2
var_0_4.IS_SUCCESS_FIELD.name = "is_success"
var_0_4.IS_SUCCESS_FIELD.full_name = ".sgland.IAPFinishReq.is_success"
var_0_4.IS_SUCCESS_FIELD.number = 2
var_0_4.IS_SUCCESS_FIELD.index = 1
var_0_4.IS_SUCCESS_FIELD.label = 2
var_0_4.IS_SUCCESS_FIELD.has_default_value = false
var_0_4.IS_SUCCESS_FIELD.default_value = false
var_0_4.IS_SUCCESS_FIELD.type = 8
var_0_4.IS_SUCCESS_FIELD.cpp_type = 7
var_0_4.FAIL_DESC_FIELD.name = "fail_desc"
var_0_4.FAIL_DESC_FIELD.full_name = ".sgland.IAPFinishReq.fail_desc"
var_0_4.FAIL_DESC_FIELD.number = 3
var_0_4.FAIL_DESC_FIELD.index = 2
var_0_4.FAIL_DESC_FIELD.label = 1
var_0_4.FAIL_DESC_FIELD.has_default_value = false
var_0_4.FAIL_DESC_FIELD.default_value = ""
var_0_4.FAIL_DESC_FIELD.type = 9
var_0_4.FAIL_DESC_FIELD.cpp_type = 9
IAPFINISHREQ.name = "IAPFinishReq"
IAPFINISHREQ.full_name = ".sgland.IAPFinishReq"
IAPFINISHREQ.nested_types = {}
IAPFINISHREQ.enum_types = {}
IAPFINISHREQ.fields = {
	var_0_4.PURCHASE_ID_FIELD,
	var_0_4.IS_SUCCESS_FIELD,
	var_0_4.FAIL_DESC_FIELD
}
IAPFINISHREQ.is_extendable = false
IAPFINISHREQ.extensions = {}
var_0_5.PURCHASE_ID_FIELD.name = "purchase_id"
var_0_5.PURCHASE_ID_FIELD.full_name = ".sgland.IAPFinishResp.purchase_id"
var_0_5.PURCHASE_ID_FIELD.number = 1
var_0_5.PURCHASE_ID_FIELD.index = 0
var_0_5.PURCHASE_ID_FIELD.label = 2
var_0_5.PURCHASE_ID_FIELD.has_default_value = false
var_0_5.PURCHASE_ID_FIELD.default_value = 0
var_0_5.PURCHASE_ID_FIELD.type = 3
var_0_5.PURCHASE_ID_FIELD.cpp_type = 2
var_0_5.TYPE_FIELD.name = "type"
var_0_5.TYPE_FIELD.full_name = ".sgland.IAPFinishResp.type"
var_0_5.TYPE_FIELD.number = 2
var_0_5.TYPE_FIELD.index = 1
var_0_5.TYPE_FIELD.label = 2
var_0_5.TYPE_FIELD.has_default_value = false
var_0_5.TYPE_FIELD.default_value = 0
var_0_5.TYPE_FIELD.type = 5
var_0_5.TYPE_FIELD.cpp_type = 1
var_0_5.IS_SUCCESS_FIELD.name = "is_success"
var_0_5.IS_SUCCESS_FIELD.full_name = ".sgland.IAPFinishResp.is_success"
var_0_5.IS_SUCCESS_FIELD.number = 3
var_0_5.IS_SUCCESS_FIELD.index = 2
var_0_5.IS_SUCCESS_FIELD.label = 2
var_0_5.IS_SUCCESS_FIELD.has_default_value = false
var_0_5.IS_SUCCESS_FIELD.default_value = false
var_0_5.IS_SUCCESS_FIELD.type = 8
var_0_5.IS_SUCCESS_FIELD.cpp_type = 7
var_0_5.FAIL_DESC_FIELD.name = "fail_desc"
var_0_5.FAIL_DESC_FIELD.full_name = ".sgland.IAPFinishResp.fail_desc"
var_0_5.FAIL_DESC_FIELD.number = 4
var_0_5.FAIL_DESC_FIELD.index = 3
var_0_5.FAIL_DESC_FIELD.label = 1
var_0_5.FAIL_DESC_FIELD.has_default_value = false
var_0_5.FAIL_DESC_FIELD.default_value = ""
var_0_5.FAIL_DESC_FIELD.type = 9
var_0_5.FAIL_DESC_FIELD.cpp_type = 9
var_0_5.EXTRA_INGOT_FIELD.name = "extra_ingot"
var_0_5.EXTRA_INGOT_FIELD.full_name = ".sgland.IAPFinishResp.extra_ingot"
var_0_5.EXTRA_INGOT_FIELD.number = 5
var_0_5.EXTRA_INGOT_FIELD.index = 4
var_0_5.EXTRA_INGOT_FIELD.label = 1
var_0_5.EXTRA_INGOT_FIELD.has_default_value = false
var_0_5.EXTRA_INGOT_FIELD.default_value = 0
var_0_5.EXTRA_INGOT_FIELD.type = 5
var_0_5.EXTRA_INGOT_FIELD.cpp_type = 1
var_0_5.EXTRA_VIP_EXP_FIELD.name = "extra_vip_exp"
var_0_5.EXTRA_VIP_EXP_FIELD.full_name = ".sgland.IAPFinishResp.extra_vip_exp"
var_0_5.EXTRA_VIP_EXP_FIELD.number = 6
var_0_5.EXTRA_VIP_EXP_FIELD.index = 5
var_0_5.EXTRA_VIP_EXP_FIELD.label = 1
var_0_5.EXTRA_VIP_EXP_FIELD.has_default_value = false
var_0_5.EXTRA_VIP_EXP_FIELD.default_value = 0
var_0_5.EXTRA_VIP_EXP_FIELD.type = 5
var_0_5.EXTRA_VIP_EXP_FIELD.cpp_type = 1
IAPFINISHRESP.name = "IAPFinishResp"
IAPFINISHRESP.full_name = ".sgland.IAPFinishResp"
IAPFINISHRESP.nested_types = {}
IAPFINISHRESP.enum_types = {}
IAPFINISHRESP.fields = {
	var_0_5.PURCHASE_ID_FIELD,
	var_0_5.TYPE_FIELD,
	var_0_5.IS_SUCCESS_FIELD,
	var_0_5.FAIL_DESC_FIELD,
	var_0_5.EXTRA_INGOT_FIELD,
	var_0_5.EXTRA_VIP_EXP_FIELD
}
IAPFINISHRESP.is_extendable = false
IAPFINISHRESP.extensions = {}
var_0_6.ID_FIELD.name = "id"
var_0_6.ID_FIELD.full_name = ".sgland.BuyDailyReq.id"
var_0_6.ID_FIELD.number = 1
var_0_6.ID_FIELD.index = 0
var_0_6.ID_FIELD.label = 2
var_0_6.ID_FIELD.has_default_value = false
var_0_6.ID_FIELD.default_value = 0
var_0_6.ID_FIELD.type = 5
var_0_6.ID_FIELD.cpp_type = 1
var_0_6.COUNT_FIELD.name = "count"
var_0_6.COUNT_FIELD.full_name = ".sgland.BuyDailyReq.count"
var_0_6.COUNT_FIELD.number = 2
var_0_6.COUNT_FIELD.index = 1
var_0_6.COUNT_FIELD.label = 2
var_0_6.COUNT_FIELD.has_default_value = false
var_0_6.COUNT_FIELD.default_value = 0
var_0_6.COUNT_FIELD.type = 5
var_0_6.COUNT_FIELD.cpp_type = 1
BUYDAILYREQ.name = "BuyDailyReq"
BUYDAILYREQ.full_name = ".sgland.BuyDailyReq"
BUYDAILYREQ.nested_types = {}
BUYDAILYREQ.enum_types = {}
BUYDAILYREQ.fields = {
	var_0_6.ID_FIELD,
	var_0_6.COUNT_FIELD
}
BUYDAILYREQ.is_extendable = false
BUYDAILYREQ.extensions = {}
var_0_7.ID_FIELD.name = "id"
var_0_7.ID_FIELD.full_name = ".sgland.BuyDustReq.id"
var_0_7.ID_FIELD.number = 1
var_0_7.ID_FIELD.index = 0
var_0_7.ID_FIELD.label = 2
var_0_7.ID_FIELD.has_default_value = false
var_0_7.ID_FIELD.default_value = 0
var_0_7.ID_FIELD.type = 5
var_0_7.ID_FIELD.cpp_type = 1
var_0_7.GRADE_FIELD.name = "grade"
var_0_7.GRADE_FIELD.full_name = ".sgland.BuyDustReq.grade"
var_0_7.GRADE_FIELD.number = 2
var_0_7.GRADE_FIELD.index = 1
var_0_7.GRADE_FIELD.label = 2
var_0_7.GRADE_FIELD.has_default_value = false
var_0_7.GRADE_FIELD.default_value = 0
var_0_7.GRADE_FIELD.type = 5
var_0_7.GRADE_FIELD.cpp_type = 1
BUYDUSTREQ.name = "BuyDustReq"
BUYDUSTREQ.full_name = ".sgland.BuyDustReq"
BUYDUSTREQ.nested_types = {}
BUYDUSTREQ.enum_types = {}
BUYDUSTREQ.fields = {
	var_0_7.ID_FIELD,
	var_0_7.GRADE_FIELD
}
BUYDUSTREQ.is_extendable = false
BUYDUSTREQ.extensions = {}
var_0_8.IAP_START_REQ_FIELD.name = "iap_start_req"
var_0_8.IAP_START_REQ_FIELD.full_name = ".sgland.SglBuyMsg.iap_start_req"
var_0_8.IAP_START_REQ_FIELD.number = 1400
var_0_8.IAP_START_REQ_FIELD.index = 0
var_0_8.IAP_START_REQ_FIELD.label = 1
var_0_8.IAP_START_REQ_FIELD.has_default_value = false
var_0_8.IAP_START_REQ_FIELD.default_value = 0
var_0_8.IAP_START_REQ_FIELD.type = 5
var_0_8.IAP_START_REQ_FIELD.cpp_type = 1
var_0_8.IAP_FINISH_REQ_FIELD.name = "iap_finish_req"
var_0_8.IAP_FINISH_REQ_FIELD.full_name = ".sgland.SglBuyMsg.iap_finish_req"
var_0_8.IAP_FINISH_REQ_FIELD.number = 1401
var_0_8.IAP_FINISH_REQ_FIELD.index = 1
var_0_8.IAP_FINISH_REQ_FIELD.label = 1
var_0_8.IAP_FINISH_REQ_FIELD.has_default_value = false
var_0_8.IAP_FINISH_REQ_FIELD.default_value = nil
var_0_8.IAP_FINISH_REQ_FIELD.message_type = IAPFINISHREQ
var_0_8.IAP_FINISH_REQ_FIELD.type = 11
var_0_8.IAP_FINISH_REQ_FIELD.cpp_type = 10
var_0_8.BUY_DAILY_REQ_FIELD.name = "buy_daily_req"
var_0_8.BUY_DAILY_REQ_FIELD.full_name = ".sgland.SglBuyMsg.buy_daily_req"
var_0_8.BUY_DAILY_REQ_FIELD.number = 1402
var_0_8.BUY_DAILY_REQ_FIELD.index = 2
var_0_8.BUY_DAILY_REQ_FIELD.label = 1
var_0_8.BUY_DAILY_REQ_FIELD.has_default_value = false
var_0_8.BUY_DAILY_REQ_FIELD.default_value = nil
var_0_8.BUY_DAILY_REQ_FIELD.message_type = BUYDAILYREQ
var_0_8.BUY_DAILY_REQ_FIELD.type = 11
var_0_8.BUY_DAILY_REQ_FIELD.cpp_type = 10
var_0_8.BUY_GOLD_REQ_FIELD.name = "buy_gold_req"
var_0_8.BUY_GOLD_REQ_FIELD.full_name = ".sgland.SglBuyMsg.buy_gold_req"
var_0_8.BUY_GOLD_REQ_FIELD.number = 1403
var_0_8.BUY_GOLD_REQ_FIELD.index = 3
var_0_8.BUY_GOLD_REQ_FIELD.label = 1
var_0_8.BUY_GOLD_REQ_FIELD.has_default_value = false
var_0_8.BUY_GOLD_REQ_FIELD.default_value = 0
var_0_8.BUY_GOLD_REQ_FIELD.type = 5
var_0_8.BUY_GOLD_REQ_FIELD.cpp_type = 1
var_0_8.BUY_DUST_REQ_FIELD.name = "buy_dust_req"
var_0_8.BUY_DUST_REQ_FIELD.full_name = ".sgland.SglBuyMsg.buy_dust_req"
var_0_8.BUY_DUST_REQ_FIELD.number = 1404
var_0_8.BUY_DUST_REQ_FIELD.index = 4
var_0_8.BUY_DUST_REQ_FIELD.label = 1
var_0_8.BUY_DUST_REQ_FIELD.has_default_value = false
var_0_8.BUY_DUST_REQ_FIELD.default_value = nil
var_0_8.BUY_DUST_REQ_FIELD.message_type = BUYDUSTREQ
var_0_8.BUY_DUST_REQ_FIELD.type = 11
var_0_8.BUY_DUST_REQ_FIELD.cpp_type = 10
var_0_8.BUY_BADGE_REQ_FIELD.name = "buy_badge_req"
var_0_8.BUY_BADGE_REQ_FIELD.full_name = ".sgland.SglBuyMsg.buy_badge_req"
var_0_8.BUY_BADGE_REQ_FIELD.number = 1405
var_0_8.BUY_BADGE_REQ_FIELD.index = 5
var_0_8.BUY_BADGE_REQ_FIELD.label = 1
var_0_8.BUY_BADGE_REQ_FIELD.has_default_value = false
var_0_8.BUY_BADGE_REQ_FIELD.default_value = 0
var_0_8.BUY_BADGE_REQ_FIELD.type = 5
var_0_8.BUY_BADGE_REQ_FIELD.cpp_type = 1
var_0_8.BUY_BADGE_LEVEL_REQ_FIELD.name = "buy_badge_level_req"
var_0_8.BUY_BADGE_LEVEL_REQ_FIELD.full_name = ".sgland.SglBuyMsg.buy_badge_level_req"
var_0_8.BUY_BADGE_LEVEL_REQ_FIELD.number = 1406
var_0_8.BUY_BADGE_LEVEL_REQ_FIELD.index = 6
var_0_8.BUY_BADGE_LEVEL_REQ_FIELD.label = 1
var_0_8.BUY_BADGE_LEVEL_REQ_FIELD.has_default_value = false
var_0_8.BUY_BADGE_LEVEL_REQ_FIELD.default_value = 0
var_0_8.BUY_BADGE_LEVEL_REQ_FIELD.type = 5
var_0_8.BUY_BADGE_LEVEL_REQ_FIELD.cpp_type = 1
var_0_8.IAP_START_RESP_FIELD.name = "iap_start_resp"
var_0_8.IAP_START_RESP_FIELD.full_name = ".sgland.SglBuyMsg.iap_start_resp"
var_0_8.IAP_START_RESP_FIELD.number = 1400
var_0_8.IAP_START_RESP_FIELD.index = 7
var_0_8.IAP_START_RESP_FIELD.label = 1
var_0_8.IAP_START_RESP_FIELD.has_default_value = false
var_0_8.IAP_START_RESP_FIELD.default_value = nil
var_0_8.IAP_START_RESP_FIELD.message_type = IAPSTARTRESP
var_0_8.IAP_START_RESP_FIELD.type = 11
var_0_8.IAP_START_RESP_FIELD.cpp_type = 10
var_0_8.IAP_FINISH_RESP_FIELD.name = "iap_finish_resp"
var_0_8.IAP_FINISH_RESP_FIELD.full_name = ".sgland.SglBuyMsg.iap_finish_resp"
var_0_8.IAP_FINISH_RESP_FIELD.number = 1401
var_0_8.IAP_FINISH_RESP_FIELD.index = 8
var_0_8.IAP_FINISH_RESP_FIELD.label = 1
var_0_8.IAP_FINISH_RESP_FIELD.has_default_value = false
var_0_8.IAP_FINISH_RESP_FIELD.default_value = nil
var_0_8.IAP_FINISH_RESP_FIELD.message_type = IAPFINISHRESP
var_0_8.IAP_FINISH_RESP_FIELD.type = 11
var_0_8.IAP_FINISH_RESP_FIELD.cpp_type = 10
SGLBUYMSG.name = "SglBuyMsg"
SGLBUYMSG.full_name = ".sgland.SglBuyMsg"
SGLBUYMSG.nested_types = {}
SGLBUYMSG.enum_types = {}
SGLBUYMSG.fields = {}
SGLBUYMSG.is_extendable = false
SGLBUYMSG.extensions = {
	var_0_8.IAP_START_REQ_FIELD,
	var_0_8.IAP_FINISH_REQ_FIELD,
	var_0_8.BUY_DAILY_REQ_FIELD,
	var_0_8.BUY_GOLD_REQ_FIELD,
	var_0_8.BUY_DUST_REQ_FIELD,
	var_0_8.BUY_BADGE_REQ_FIELD,
	var_0_8.BUY_BADGE_LEVEL_REQ_FIELD,
	var_0_8.IAP_START_RESP_FIELD,
	var_0_8.IAP_FINISH_RESP_FIELD
}
BuyDailyReq = var_0_0.Message(BUYDAILYREQ)
BuyDustReq = var_0_0.Message(BUYDUSTREQ)
IAPCallback = var_0_0.Message(IAPCALLBACK)
IAPFinishReq = var_0_0.Message(IAPFINISHREQ)
IAPFinishResp = var_0_0.Message(IAPFINISHRESP)
IAPStartResp = var_0_0.Message(IAPSTARTRESP)
SglBuyMsg = var_0_0.Message(SGLBUYMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_8.IAP_START_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_8.IAP_FINISH_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_8.BUY_DAILY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_8.BUY_GOLD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_8.BUY_DUST_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_8.BUY_BADGE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_8.BUY_BADGE_LEVEL_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_8.IAP_START_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_8.IAP_FINISH_RESP_FIELD)
