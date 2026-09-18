local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Shop_pb")

SHOPREFRESHRESP = var_0_0.Descriptor()

local var_0_3 = {
	NEXT_REFRESH_FIELD = var_0_0.FieldDescriptor(),
	BUNDLES_FIELD = var_0_0.FieldDescriptor()
}

SHOPREFRESHALLRESP = var_0_0.Descriptor()

local var_0_4 = {
	NEXT_REFRESH_FIELD = var_0_0.FieldDescriptor(),
	BUNDLES_FIELD = var_0_0.FieldDescriptor(),
	PVP_BUNDLES_FIELD = var_0_0.FieldDescriptor(),
	LADDER_BUNDLES_FIELD = var_0_0.FieldDescriptor()
}

SHOPOPENRESP = var_0_0.Descriptor()

local var_0_5 = {
	LAST_OPEN_FIELD = var_0_0.FieldDescriptor(),
	BUNDLES_FIELD = var_0_0.FieldDescriptor()
}

SHOPGIFTRESP = var_0_0.Descriptor()

local var_0_6 = {
	LAST_GIFT_FIELD = var_0_0.FieldDescriptor(),
	GIFTS_FIELD = var_0_0.FieldDescriptor()
}

SGLSHOPMSG = var_0_0.Descriptor()

local var_0_7 = {
	SHOP_BUY_REQ_FIELD = var_0_0.FieldDescriptor(),
	SHOP_EXCHANGE_REQ_FIELD = var_0_0.FieldDescriptor(),
	SHOP_BUY_TYPE_REQ_FIELD = var_0_0.FieldDescriptor(),
	SHOP_EXCHANGE_PROP_REQ_FIELD = var_0_0.FieldDescriptor(),
	SHOP_BUY_EFFECT_CARD_REQ_FIELD = var_0_0.FieldDescriptor(),
	SHOP_EXCHANGE_PROP_TIMES_FIELD = var_0_0.FieldDescriptor(),
	SHOP_VOTE_COUNT_REQ_FIELD = var_0_0.FieldDescriptor(),
	SHOP_RECYCLE_REQ_FIELD = var_0_0.FieldDescriptor(),
	SHOP_REFRESH_RESP_FIELD = var_0_0.FieldDescriptor(),
	SHOP_OPEN_RESP_FIELD = var_0_0.FieldDescriptor(),
	SHOP_REFRESH_ALL_RESP_FIELD = var_0_0.FieldDescriptor(),
	SHOP_GIFT_RESP_FIELD = var_0_0.FieldDescriptor(),
	SHOP_VOTE_COUNT_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.NEXT_REFRESH_FIELD.name = "next_refresh"
var_0_3.NEXT_REFRESH_FIELD.full_name = ".sgland.ShopRefreshResp.next_refresh"
var_0_3.NEXT_REFRESH_FIELD.number = 1
var_0_3.NEXT_REFRESH_FIELD.index = 0
var_0_3.NEXT_REFRESH_FIELD.label = 2
var_0_3.NEXT_REFRESH_FIELD.has_default_value = false
var_0_3.NEXT_REFRESH_FIELD.default_value = 0
var_0_3.NEXT_REFRESH_FIELD.type = 3
var_0_3.NEXT_REFRESH_FIELD.cpp_type = 2
var_0_3.BUNDLES_FIELD.name = "bundles"
var_0_3.BUNDLES_FIELD.full_name = ".sgland.ShopRefreshResp.bundles"
var_0_3.BUNDLES_FIELD.number = 2
var_0_3.BUNDLES_FIELD.index = 1
var_0_3.BUNDLES_FIELD.label = 3
var_0_3.BUNDLES_FIELD.has_default_value = false
var_0_3.BUNDLES_FIELD.default_value = {}
var_0_3.BUNDLES_FIELD.message_type = var_0_2.BUNDLE
var_0_3.BUNDLES_FIELD.type = 11
var_0_3.BUNDLES_FIELD.cpp_type = 10
SHOPREFRESHRESP.name = "ShopRefreshResp"
SHOPREFRESHRESP.full_name = ".sgland.ShopRefreshResp"
SHOPREFRESHRESP.nested_types = {}
SHOPREFRESHRESP.enum_types = {}
SHOPREFRESHRESP.fields = {
	var_0_3.NEXT_REFRESH_FIELD,
	var_0_3.BUNDLES_FIELD
}
SHOPREFRESHRESP.is_extendable = false
SHOPREFRESHRESP.extensions = {}
var_0_4.NEXT_REFRESH_FIELD.name = "next_refresh"
var_0_4.NEXT_REFRESH_FIELD.full_name = ".sgland.ShopRefreshAllResp.next_refresh"
var_0_4.NEXT_REFRESH_FIELD.number = 1
var_0_4.NEXT_REFRESH_FIELD.index = 0
var_0_4.NEXT_REFRESH_FIELD.label = 2
var_0_4.NEXT_REFRESH_FIELD.has_default_value = false
var_0_4.NEXT_REFRESH_FIELD.default_value = 0
var_0_4.NEXT_REFRESH_FIELD.type = 3
var_0_4.NEXT_REFRESH_FIELD.cpp_type = 2
var_0_4.BUNDLES_FIELD.name = "bundles"
var_0_4.BUNDLES_FIELD.full_name = ".sgland.ShopRefreshAllResp.bundles"
var_0_4.BUNDLES_FIELD.number = 2
var_0_4.BUNDLES_FIELD.index = 1
var_0_4.BUNDLES_FIELD.label = 3
var_0_4.BUNDLES_FIELD.has_default_value = false
var_0_4.BUNDLES_FIELD.default_value = {}
var_0_4.BUNDLES_FIELD.message_type = var_0_2.BUNDLE
var_0_4.BUNDLES_FIELD.type = 11
var_0_4.BUNDLES_FIELD.cpp_type = 10
var_0_4.PVP_BUNDLES_FIELD.name = "pvp_bundles"
var_0_4.PVP_BUNDLES_FIELD.full_name = ".sgland.ShopRefreshAllResp.pvp_bundles"
var_0_4.PVP_BUNDLES_FIELD.number = 3
var_0_4.PVP_BUNDLES_FIELD.index = 2
var_0_4.PVP_BUNDLES_FIELD.label = 3
var_0_4.PVP_BUNDLES_FIELD.has_default_value = false
var_0_4.PVP_BUNDLES_FIELD.default_value = {}
var_0_4.PVP_BUNDLES_FIELD.message_type = var_0_2.BUNDLE
var_0_4.PVP_BUNDLES_FIELD.type = 11
var_0_4.PVP_BUNDLES_FIELD.cpp_type = 10
var_0_4.LADDER_BUNDLES_FIELD.name = "ladder_bundles"
var_0_4.LADDER_BUNDLES_FIELD.full_name = ".sgland.ShopRefreshAllResp.ladder_bundles"
var_0_4.LADDER_BUNDLES_FIELD.number = 4
var_0_4.LADDER_BUNDLES_FIELD.index = 3
var_0_4.LADDER_BUNDLES_FIELD.label = 3
var_0_4.LADDER_BUNDLES_FIELD.has_default_value = false
var_0_4.LADDER_BUNDLES_FIELD.default_value = {}
var_0_4.LADDER_BUNDLES_FIELD.message_type = var_0_2.BUNDLE
var_0_4.LADDER_BUNDLES_FIELD.type = 11
var_0_4.LADDER_BUNDLES_FIELD.cpp_type = 10
SHOPREFRESHALLRESP.name = "ShopRefreshAllResp"
SHOPREFRESHALLRESP.full_name = ".sgland.ShopRefreshAllResp"
SHOPREFRESHALLRESP.nested_types = {}
SHOPREFRESHALLRESP.enum_types = {}
SHOPREFRESHALLRESP.fields = {
	var_0_4.NEXT_REFRESH_FIELD,
	var_0_4.BUNDLES_FIELD,
	var_0_4.PVP_BUNDLES_FIELD,
	var_0_4.LADDER_BUNDLES_FIELD
}
SHOPREFRESHALLRESP.is_extendable = false
SHOPREFRESHALLRESP.extensions = {}
var_0_5.LAST_OPEN_FIELD.name = "last_open"
var_0_5.LAST_OPEN_FIELD.full_name = ".sgland.ShopOpenResp.last_open"
var_0_5.LAST_OPEN_FIELD.number = 1
var_0_5.LAST_OPEN_FIELD.index = 0
var_0_5.LAST_OPEN_FIELD.label = 2
var_0_5.LAST_OPEN_FIELD.has_default_value = false
var_0_5.LAST_OPEN_FIELD.default_value = 0
var_0_5.LAST_OPEN_FIELD.type = 3
var_0_5.LAST_OPEN_FIELD.cpp_type = 2
var_0_5.BUNDLES_FIELD.name = "bundles"
var_0_5.BUNDLES_FIELD.full_name = ".sgland.ShopOpenResp.bundles"
var_0_5.BUNDLES_FIELD.number = 2
var_0_5.BUNDLES_FIELD.index = 1
var_0_5.BUNDLES_FIELD.label = 3
var_0_5.BUNDLES_FIELD.has_default_value = false
var_0_5.BUNDLES_FIELD.default_value = {}
var_0_5.BUNDLES_FIELD.message_type = var_0_2.BUNDLEEX
var_0_5.BUNDLES_FIELD.type = 11
var_0_5.BUNDLES_FIELD.cpp_type = 10
SHOPOPENRESP.name = "ShopOpenResp"
SHOPOPENRESP.full_name = ".sgland.ShopOpenResp"
SHOPOPENRESP.nested_types = {}
SHOPOPENRESP.enum_types = {}
SHOPOPENRESP.fields = {
	var_0_5.LAST_OPEN_FIELD,
	var_0_5.BUNDLES_FIELD
}
SHOPOPENRESP.is_extendable = false
SHOPOPENRESP.extensions = {}
var_0_6.LAST_GIFT_FIELD.name = "last_gift"
var_0_6.LAST_GIFT_FIELD.full_name = ".sgland.ShopGiftResp.last_gift"
var_0_6.LAST_GIFT_FIELD.number = 1
var_0_6.LAST_GIFT_FIELD.index = 0
var_0_6.LAST_GIFT_FIELD.label = 2
var_0_6.LAST_GIFT_FIELD.has_default_value = false
var_0_6.LAST_GIFT_FIELD.default_value = 0
var_0_6.LAST_GIFT_FIELD.type = 3
var_0_6.LAST_GIFT_FIELD.cpp_type = 2
var_0_6.GIFTS_FIELD.name = "gifts"
var_0_6.GIFTS_FIELD.full_name = ".sgland.ShopGiftResp.gifts"
var_0_6.GIFTS_FIELD.number = 2
var_0_6.GIFTS_FIELD.index = 1
var_0_6.GIFTS_FIELD.label = 3
var_0_6.GIFTS_FIELD.has_default_value = false
var_0_6.GIFTS_FIELD.default_value = {}
var_0_6.GIFTS_FIELD.message_type = var_0_2.RESOURCE
var_0_6.GIFTS_FIELD.type = 11
var_0_6.GIFTS_FIELD.cpp_type = 10
SHOPGIFTRESP.name = "ShopGiftResp"
SHOPGIFTRESP.full_name = ".sgland.ShopGiftResp"
SHOPGIFTRESP.nested_types = {}
SHOPGIFTRESP.enum_types = {}
SHOPGIFTRESP.fields = {
	var_0_6.LAST_GIFT_FIELD,
	var_0_6.GIFTS_FIELD
}
SHOPGIFTRESP.is_extendable = false
SHOPGIFTRESP.extensions = {}
var_0_7.SHOP_BUY_REQ_FIELD.name = "shop_buy_req"
var_0_7.SHOP_BUY_REQ_FIELD.full_name = ".sgland.SglShopMsg.shop_buy_req"
var_0_7.SHOP_BUY_REQ_FIELD.number = 1500
var_0_7.SHOP_BUY_REQ_FIELD.index = 0
var_0_7.SHOP_BUY_REQ_FIELD.label = 1
var_0_7.SHOP_BUY_REQ_FIELD.has_default_value = false
var_0_7.SHOP_BUY_REQ_FIELD.default_value = 0
var_0_7.SHOP_BUY_REQ_FIELD.type = 5
var_0_7.SHOP_BUY_REQ_FIELD.cpp_type = 1
var_0_7.SHOP_EXCHANGE_REQ_FIELD.name = "shop_exchange_req"
var_0_7.SHOP_EXCHANGE_REQ_FIELD.full_name = ".sgland.SglShopMsg.shop_exchange_req"
var_0_7.SHOP_EXCHANGE_REQ_FIELD.number = 1501
var_0_7.SHOP_EXCHANGE_REQ_FIELD.index = 1
var_0_7.SHOP_EXCHANGE_REQ_FIELD.label = 1
var_0_7.SHOP_EXCHANGE_REQ_FIELD.has_default_value = false
var_0_7.SHOP_EXCHANGE_REQ_FIELD.default_value = 0
var_0_7.SHOP_EXCHANGE_REQ_FIELD.type = 5
var_0_7.SHOP_EXCHANGE_REQ_FIELD.cpp_type = 1
var_0_7.SHOP_BUY_TYPE_REQ_FIELD.name = "shop_buy_type_req"
var_0_7.SHOP_BUY_TYPE_REQ_FIELD.full_name = ".sgland.SglShopMsg.shop_buy_type_req"
var_0_7.SHOP_BUY_TYPE_REQ_FIELD.number = 1502
var_0_7.SHOP_BUY_TYPE_REQ_FIELD.index = 2
var_0_7.SHOP_BUY_TYPE_REQ_FIELD.label = 1
var_0_7.SHOP_BUY_TYPE_REQ_FIELD.has_default_value = false
var_0_7.SHOP_BUY_TYPE_REQ_FIELD.default_value = 0
var_0_7.SHOP_BUY_TYPE_REQ_FIELD.type = 5
var_0_7.SHOP_BUY_TYPE_REQ_FIELD.cpp_type = 1
var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD.name = "shop_exchange_prop_req"
var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD.full_name = ".sgland.SglShopMsg.shop_exchange_prop_req"
var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD.number = 1503
var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD.index = 3
var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD.label = 1
var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD.has_default_value = false
var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD.default_value = 0
var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD.type = 5
var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD.cpp_type = 1
var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD.name = "shop_buy_effect_card_req"
var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD.full_name = ".sgland.SglShopMsg.shop_buy_effect_card_req"
var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD.number = 1504
var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD.index = 4
var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD.label = 1
var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD.has_default_value = false
var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD.default_value = 0
var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD.type = 5
var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD.cpp_type = 1
var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD.name = "shop_exchange_prop_times"
var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD.full_name = ".sgland.SglShopMsg.shop_exchange_prop_times"
var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD.number = 1505
var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD.index = 5
var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD.label = 1
var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD.has_default_value = false
var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD.default_value = 0
var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD.type = 5
var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD.cpp_type = 1
var_0_7.SHOP_VOTE_COUNT_REQ_FIELD.name = "shop_vote_count_req"
var_0_7.SHOP_VOTE_COUNT_REQ_FIELD.full_name = ".sgland.SglShopMsg.shop_vote_count_req"
var_0_7.SHOP_VOTE_COUNT_REQ_FIELD.number = 1506
var_0_7.SHOP_VOTE_COUNT_REQ_FIELD.index = 6
var_0_7.SHOP_VOTE_COUNT_REQ_FIELD.label = 1
var_0_7.SHOP_VOTE_COUNT_REQ_FIELD.has_default_value = false
var_0_7.SHOP_VOTE_COUNT_REQ_FIELD.default_value = 0
var_0_7.SHOP_VOTE_COUNT_REQ_FIELD.type = 5
var_0_7.SHOP_VOTE_COUNT_REQ_FIELD.cpp_type = 1
var_0_7.SHOP_RECYCLE_REQ_FIELD.name = "shop_recycle_req"
var_0_7.SHOP_RECYCLE_REQ_FIELD.full_name = ".sgland.SglShopMsg.shop_recycle_req"
var_0_7.SHOP_RECYCLE_REQ_FIELD.number = 1507
var_0_7.SHOP_RECYCLE_REQ_FIELD.index = 7
var_0_7.SHOP_RECYCLE_REQ_FIELD.label = 1
var_0_7.SHOP_RECYCLE_REQ_FIELD.has_default_value = false
var_0_7.SHOP_RECYCLE_REQ_FIELD.default_value = nil
var_0_7.SHOP_RECYCLE_REQ_FIELD.message_type = var_0_2.PAIR
var_0_7.SHOP_RECYCLE_REQ_FIELD.type = 11
var_0_7.SHOP_RECYCLE_REQ_FIELD.cpp_type = 10
var_0_7.SHOP_REFRESH_RESP_FIELD.name = "shop_refresh_resp"
var_0_7.SHOP_REFRESH_RESP_FIELD.full_name = ".sgland.SglShopMsg.shop_refresh_resp"
var_0_7.SHOP_REFRESH_RESP_FIELD.number = 1500
var_0_7.SHOP_REFRESH_RESP_FIELD.index = 8
var_0_7.SHOP_REFRESH_RESP_FIELD.label = 1
var_0_7.SHOP_REFRESH_RESP_FIELD.has_default_value = false
var_0_7.SHOP_REFRESH_RESP_FIELD.default_value = nil
var_0_7.SHOP_REFRESH_RESP_FIELD.message_type = SHOPREFRESHRESP
var_0_7.SHOP_REFRESH_RESP_FIELD.type = 11
var_0_7.SHOP_REFRESH_RESP_FIELD.cpp_type = 10
var_0_7.SHOP_OPEN_RESP_FIELD.name = "shop_open_resp"
var_0_7.SHOP_OPEN_RESP_FIELD.full_name = ".sgland.SglShopMsg.shop_open_resp"
var_0_7.SHOP_OPEN_RESP_FIELD.number = 1501
var_0_7.SHOP_OPEN_RESP_FIELD.index = 9
var_0_7.SHOP_OPEN_RESP_FIELD.label = 1
var_0_7.SHOP_OPEN_RESP_FIELD.has_default_value = false
var_0_7.SHOP_OPEN_RESP_FIELD.default_value = nil
var_0_7.SHOP_OPEN_RESP_FIELD.message_type = SHOPOPENRESP
var_0_7.SHOP_OPEN_RESP_FIELD.type = 11
var_0_7.SHOP_OPEN_RESP_FIELD.cpp_type = 10
var_0_7.SHOP_REFRESH_ALL_RESP_FIELD.name = "shop_refresh_all_resp"
var_0_7.SHOP_REFRESH_ALL_RESP_FIELD.full_name = ".sgland.SglShopMsg.shop_refresh_all_resp"
var_0_7.SHOP_REFRESH_ALL_RESP_FIELD.number = 1502
var_0_7.SHOP_REFRESH_ALL_RESP_FIELD.index = 10
var_0_7.SHOP_REFRESH_ALL_RESP_FIELD.label = 1
var_0_7.SHOP_REFRESH_ALL_RESP_FIELD.has_default_value = false
var_0_7.SHOP_REFRESH_ALL_RESP_FIELD.default_value = nil
var_0_7.SHOP_REFRESH_ALL_RESP_FIELD.message_type = SHOPREFRESHALLRESP
var_0_7.SHOP_REFRESH_ALL_RESP_FIELD.type = 11
var_0_7.SHOP_REFRESH_ALL_RESP_FIELD.cpp_type = 10
var_0_7.SHOP_GIFT_RESP_FIELD.name = "shop_gift_resp"
var_0_7.SHOP_GIFT_RESP_FIELD.full_name = ".sgland.SglShopMsg.shop_gift_resp"
var_0_7.SHOP_GIFT_RESP_FIELD.number = 1503
var_0_7.SHOP_GIFT_RESP_FIELD.index = 11
var_0_7.SHOP_GIFT_RESP_FIELD.label = 1
var_0_7.SHOP_GIFT_RESP_FIELD.has_default_value = false
var_0_7.SHOP_GIFT_RESP_FIELD.default_value = nil
var_0_7.SHOP_GIFT_RESP_FIELD.message_type = SHOPGIFTRESP
var_0_7.SHOP_GIFT_RESP_FIELD.type = 11
var_0_7.SHOP_GIFT_RESP_FIELD.cpp_type = 10
var_0_7.SHOP_VOTE_COUNT_RESP_FIELD.name = "shop_vote_count_resp"
var_0_7.SHOP_VOTE_COUNT_RESP_FIELD.full_name = ".sgland.SglShopMsg.shop_vote_count_resp"
var_0_7.SHOP_VOTE_COUNT_RESP_FIELD.number = 1504
var_0_7.SHOP_VOTE_COUNT_RESP_FIELD.index = 12
var_0_7.SHOP_VOTE_COUNT_RESP_FIELD.label = 1
var_0_7.SHOP_VOTE_COUNT_RESP_FIELD.has_default_value = false
var_0_7.SHOP_VOTE_COUNT_RESP_FIELD.default_value = 0
var_0_7.SHOP_VOTE_COUNT_RESP_FIELD.type = 5
var_0_7.SHOP_VOTE_COUNT_RESP_FIELD.cpp_type = 1
SGLSHOPMSG.name = "SglShopMsg"
SGLSHOPMSG.full_name = ".sgland.SglShopMsg"
SGLSHOPMSG.nested_types = {}
SGLSHOPMSG.enum_types = {}
SGLSHOPMSG.fields = {}
SGLSHOPMSG.is_extendable = false
SGLSHOPMSG.extensions = {
	var_0_7.SHOP_BUY_REQ_FIELD,
	var_0_7.SHOP_EXCHANGE_REQ_FIELD,
	var_0_7.SHOP_BUY_TYPE_REQ_FIELD,
	var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD,
	var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD,
	var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD,
	var_0_7.SHOP_VOTE_COUNT_REQ_FIELD,
	var_0_7.SHOP_RECYCLE_REQ_FIELD,
	var_0_7.SHOP_REFRESH_RESP_FIELD,
	var_0_7.SHOP_OPEN_RESP_FIELD,
	var_0_7.SHOP_REFRESH_ALL_RESP_FIELD,
	var_0_7.SHOP_GIFT_RESP_FIELD,
	var_0_7.SHOP_VOTE_COUNT_RESP_FIELD
}
SglShopMsg = var_0_0.Message(SGLSHOPMSG)
ShopGiftResp = var_0_0.Message(SHOPGIFTRESP)
ShopOpenResp = var_0_0.Message(SHOPOPENRESP)
ShopRefreshAllResp = var_0_0.Message(SHOPREFRESHALLRESP)
ShopRefreshResp = var_0_0.Message(SHOPREFRESHRESP)

var_0_1.SglReqMsg.RegisterExtension(var_0_7.SHOP_BUY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_7.SHOP_EXCHANGE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_7.SHOP_BUY_TYPE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_7.SHOP_EXCHANGE_PROP_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_7.SHOP_BUY_EFFECT_CARD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_7.SHOP_EXCHANGE_PROP_TIMES_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_7.SHOP_VOTE_COUNT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_7.SHOP_RECYCLE_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_7.SHOP_REFRESH_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_7.SHOP_OPEN_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_7.SHOP_REFRESH_ALL_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_7.SHOP_GIFT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_7.SHOP_VOTE_COUNT_RESP_FIELD)
