local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("News_pb")

WHAT = var_0_0.EnumDescriptor()

local var_0_3 = {
	PB_NEWS_PURCHASE = var_0_0.EnumValueDescriptor(),
	PB_NEWS_WAR_DECLARE = var_0_0.EnumValueDescriptor(),
	PB_NEWS_WAR_WIN = var_0_0.EnumValueDescriptor(),
	PB_NEWS_WAR_LOSE = var_0_0.EnumValueDescriptor(),
	PB_NEWS_ATTACK_WIN = var_0_0.EnumValueDescriptor(),
	PB_NEWS_DEFEND_WIN = var_0_0.EnumValueDescriptor(),
	PB_NEWS_LOTTERY = var_0_0.EnumValueDescriptor(),
	PB_NEWS_MIX = var_0_0.EnumValueDescriptor(),
	PB_NEWS_TRANSFORM = var_0_0.EnumValueDescriptor(),
	PB_NEWS_EXPEDITION = var_0_0.EnumValueDescriptor(),
	PB_NEWS_RECRUIT = var_0_0.EnumValueDescriptor(),
	PB_NEWS_VISIT = var_0_0.EnumValueDescriptor(),
	PB_NEWS_UNION_CREATE = var_0_0.EnumValueDescriptor(),
	PB_NEWS_UNION_UPGRADE = var_0_0.EnumValueDescriptor(),
	PB_NEWS_OPEN_CHEST = var_0_0.EnumValueDescriptor(),
	PB_NEWS_BUY = var_0_0.EnumValueDescriptor(),
	PB_NEWS_RANK = var_0_0.EnumValueDescriptor(),
	PB_NEWS_RANK_LADDER = var_0_0.EnumValueDescriptor()
}

NEWS = var_0_0.Descriptor()

local var_0_4 = {
	WHAT_FIELD = var_0_0.FieldDescriptor(),
	PARAM_FIELD = var_0_0.FieldDescriptor(),
	USER1_FIELD = var_0_0.FieldDescriptor(),
	USER2_FIELD = var_0_0.FieldDescriptor(),
	UNION1_FIELD = var_0_0.FieldDescriptor(),
	UNION2_FIELD = var_0_0.FieldDescriptor(),
	RESOURCE_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

SGLNEWSMSG = var_0_0.Descriptor()

local var_0_5 = {
	NEWS_MAINTENANCE_REQ_FIELD = var_0_0.FieldDescriptor(),
	NEWS_RECEIVE_RESP_FIELD = var_0_0.FieldDescriptor(),
	NEWS_ANNOUNCEMENT_RESP_FIELD = var_0_0.FieldDescriptor(),
	NEWS_MAINTENANCE_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.PB_NEWS_PURCHASE.name = "PB_NEWS_PURCHASE"
var_0_3.PB_NEWS_PURCHASE.index = 0
var_0_3.PB_NEWS_PURCHASE.number = 1
var_0_3.PB_NEWS_WAR_DECLARE.name = "PB_NEWS_WAR_DECLARE"
var_0_3.PB_NEWS_WAR_DECLARE.index = 1
var_0_3.PB_NEWS_WAR_DECLARE.number = 2
var_0_3.PB_NEWS_WAR_WIN.name = "PB_NEWS_WAR_WIN"
var_0_3.PB_NEWS_WAR_WIN.index = 2
var_0_3.PB_NEWS_WAR_WIN.number = 3
var_0_3.PB_NEWS_WAR_LOSE.name = "PB_NEWS_WAR_LOSE"
var_0_3.PB_NEWS_WAR_LOSE.index = 3
var_0_3.PB_NEWS_WAR_LOSE.number = 4
var_0_3.PB_NEWS_ATTACK_WIN.name = "PB_NEWS_ATTACK_WIN"
var_0_3.PB_NEWS_ATTACK_WIN.index = 4
var_0_3.PB_NEWS_ATTACK_WIN.number = 5
var_0_3.PB_NEWS_DEFEND_WIN.name = "PB_NEWS_DEFEND_WIN"
var_0_3.PB_NEWS_DEFEND_WIN.index = 5
var_0_3.PB_NEWS_DEFEND_WIN.number = 6
var_0_3.PB_NEWS_LOTTERY.name = "PB_NEWS_LOTTERY"
var_0_3.PB_NEWS_LOTTERY.index = 6
var_0_3.PB_NEWS_LOTTERY.number = 7
var_0_3.PB_NEWS_MIX.name = "PB_NEWS_MIX"
var_0_3.PB_NEWS_MIX.index = 7
var_0_3.PB_NEWS_MIX.number = 8
var_0_3.PB_NEWS_TRANSFORM.name = "PB_NEWS_TRANSFORM"
var_0_3.PB_NEWS_TRANSFORM.index = 8
var_0_3.PB_NEWS_TRANSFORM.number = 9
var_0_3.PB_NEWS_EXPEDITION.name = "PB_NEWS_EXPEDITION"
var_0_3.PB_NEWS_EXPEDITION.index = 9
var_0_3.PB_NEWS_EXPEDITION.number = 10
var_0_3.PB_NEWS_RECRUIT.name = "PB_NEWS_RECRUIT"
var_0_3.PB_NEWS_RECRUIT.index = 10
var_0_3.PB_NEWS_RECRUIT.number = 11
var_0_3.PB_NEWS_VISIT.name = "PB_NEWS_VISIT"
var_0_3.PB_NEWS_VISIT.index = 11
var_0_3.PB_NEWS_VISIT.number = 12
var_0_3.PB_NEWS_UNION_CREATE.name = "PB_NEWS_UNION_CREATE"
var_0_3.PB_NEWS_UNION_CREATE.index = 12
var_0_3.PB_NEWS_UNION_CREATE.number = 13
var_0_3.PB_NEWS_UNION_UPGRADE.name = "PB_NEWS_UNION_UPGRADE"
var_0_3.PB_NEWS_UNION_UPGRADE.index = 13
var_0_3.PB_NEWS_UNION_UPGRADE.number = 14
var_0_3.PB_NEWS_OPEN_CHEST.name = "PB_NEWS_OPEN_CHEST"
var_0_3.PB_NEWS_OPEN_CHEST.index = 14
var_0_3.PB_NEWS_OPEN_CHEST.number = 15
var_0_3.PB_NEWS_BUY.name = "PB_NEWS_BUY"
var_0_3.PB_NEWS_BUY.index = 15
var_0_3.PB_NEWS_BUY.number = 16
var_0_3.PB_NEWS_RANK.name = "PB_NEWS_RANK"
var_0_3.PB_NEWS_RANK.index = 16
var_0_3.PB_NEWS_RANK.number = 17
var_0_3.PB_NEWS_RANK_LADDER.name = "PB_NEWS_RANK_LADDER"
var_0_3.PB_NEWS_RANK_LADDER.index = 17
var_0_3.PB_NEWS_RANK_LADDER.number = 18
WHAT.name = "What"
WHAT.full_name = ".sgland.What"
WHAT.values = {
	var_0_3.PB_NEWS_PURCHASE,
	var_0_3.PB_NEWS_WAR_DECLARE,
	var_0_3.PB_NEWS_WAR_WIN,
	var_0_3.PB_NEWS_WAR_LOSE,
	var_0_3.PB_NEWS_ATTACK_WIN,
	var_0_3.PB_NEWS_DEFEND_WIN,
	var_0_3.PB_NEWS_LOTTERY,
	var_0_3.PB_NEWS_MIX,
	var_0_3.PB_NEWS_TRANSFORM,
	var_0_3.PB_NEWS_EXPEDITION,
	var_0_3.PB_NEWS_RECRUIT,
	var_0_3.PB_NEWS_VISIT,
	var_0_3.PB_NEWS_UNION_CREATE,
	var_0_3.PB_NEWS_UNION_UPGRADE,
	var_0_3.PB_NEWS_OPEN_CHEST,
	var_0_3.PB_NEWS_BUY,
	var_0_3.PB_NEWS_RANK,
	var_0_3.PB_NEWS_RANK_LADDER
}
var_0_4.WHAT_FIELD.name = "what"
var_0_4.WHAT_FIELD.full_name = ".sgland.News.what"
var_0_4.WHAT_FIELD.number = 1
var_0_4.WHAT_FIELD.index = 0
var_0_4.WHAT_FIELD.label = 2
var_0_4.WHAT_FIELD.has_default_value = false
var_0_4.WHAT_FIELD.default_value = nil
var_0_4.WHAT_FIELD.enum_type = WHAT
var_0_4.WHAT_FIELD.type = 14
var_0_4.WHAT_FIELD.cpp_type = 8
var_0_4.PARAM_FIELD.name = "param"
var_0_4.PARAM_FIELD.full_name = ".sgland.News.param"
var_0_4.PARAM_FIELD.number = 2
var_0_4.PARAM_FIELD.index = 1
var_0_4.PARAM_FIELD.label = 1
var_0_4.PARAM_FIELD.has_default_value = false
var_0_4.PARAM_FIELD.default_value = 0
var_0_4.PARAM_FIELD.type = 5
var_0_4.PARAM_FIELD.cpp_type = 1
var_0_4.USER1_FIELD.name = "user1"
var_0_4.USER1_FIELD.full_name = ".sgland.News.user1"
var_0_4.USER1_FIELD.number = 3
var_0_4.USER1_FIELD.index = 2
var_0_4.USER1_FIELD.label = 1
var_0_4.USER1_FIELD.has_default_value = false
var_0_4.USER1_FIELD.default_value = nil
var_0_4.USER1_FIELD.message_type = var_0_2.USERINFO
var_0_4.USER1_FIELD.type = 11
var_0_4.USER1_FIELD.cpp_type = 10
var_0_4.USER2_FIELD.name = "user2"
var_0_4.USER2_FIELD.full_name = ".sgland.News.user2"
var_0_4.USER2_FIELD.number = 4
var_0_4.USER2_FIELD.index = 3
var_0_4.USER2_FIELD.label = 1
var_0_4.USER2_FIELD.has_default_value = false
var_0_4.USER2_FIELD.default_value = nil
var_0_4.USER2_FIELD.message_type = var_0_2.USERINFO
var_0_4.USER2_FIELD.type = 11
var_0_4.USER2_FIELD.cpp_type = 10
var_0_4.UNION1_FIELD.name = "union1"
var_0_4.UNION1_FIELD.full_name = ".sgland.News.union1"
var_0_4.UNION1_FIELD.number = 5
var_0_4.UNION1_FIELD.index = 4
var_0_4.UNION1_FIELD.label = 1
var_0_4.UNION1_FIELD.has_default_value = false
var_0_4.UNION1_FIELD.default_value = nil
var_0_4.UNION1_FIELD.message_type = var_0_2.UNIONINFO
var_0_4.UNION1_FIELD.type = 11
var_0_4.UNION1_FIELD.cpp_type = 10
var_0_4.UNION2_FIELD.name = "union2"
var_0_4.UNION2_FIELD.full_name = ".sgland.News.union2"
var_0_4.UNION2_FIELD.number = 6
var_0_4.UNION2_FIELD.index = 5
var_0_4.UNION2_FIELD.label = 1
var_0_4.UNION2_FIELD.has_default_value = false
var_0_4.UNION2_FIELD.default_value = nil
var_0_4.UNION2_FIELD.message_type = var_0_2.UNIONINFO
var_0_4.UNION2_FIELD.type = 11
var_0_4.UNION2_FIELD.cpp_type = 10
var_0_4.RESOURCE_FIELD.name = "resource"
var_0_4.RESOURCE_FIELD.full_name = ".sgland.News.resource"
var_0_4.RESOURCE_FIELD.number = 7
var_0_4.RESOURCE_FIELD.index = 6
var_0_4.RESOURCE_FIELD.label = 3
var_0_4.RESOURCE_FIELD.has_default_value = false
var_0_4.RESOURCE_FIELD.default_value = {}
var_0_4.RESOURCE_FIELD.message_type = var_0_2.RESOURCE
var_0_4.RESOURCE_FIELD.type = 11
var_0_4.RESOURCE_FIELD.cpp_type = 10
var_0_4.TIMESTAMP_FIELD.name = "timestamp"
var_0_4.TIMESTAMP_FIELD.full_name = ".sgland.News.timestamp"
var_0_4.TIMESTAMP_FIELD.number = 8
var_0_4.TIMESTAMP_FIELD.index = 7
var_0_4.TIMESTAMP_FIELD.label = 2
var_0_4.TIMESTAMP_FIELD.has_default_value = false
var_0_4.TIMESTAMP_FIELD.default_value = 0
var_0_4.TIMESTAMP_FIELD.type = 3
var_0_4.TIMESTAMP_FIELD.cpp_type = 2
NEWS.name = "News"
NEWS.full_name = ".sgland.News"
NEWS.nested_types = {}
NEWS.enum_types = {}
NEWS.fields = {
	var_0_4.WHAT_FIELD,
	var_0_4.PARAM_FIELD,
	var_0_4.USER1_FIELD,
	var_0_4.USER2_FIELD,
	var_0_4.UNION1_FIELD,
	var_0_4.UNION2_FIELD,
	var_0_4.RESOURCE_FIELD,
	var_0_4.TIMESTAMP_FIELD
}
NEWS.is_extendable = false
NEWS.extensions = {}
var_0_5.NEWS_MAINTENANCE_REQ_FIELD.name = "news_maintenance_req"
var_0_5.NEWS_MAINTENANCE_REQ_FIELD.full_name = ".sgland.SglNewsMsg.news_maintenance_req"
var_0_5.NEWS_MAINTENANCE_REQ_FIELD.number = 1600
var_0_5.NEWS_MAINTENANCE_REQ_FIELD.index = 0
var_0_5.NEWS_MAINTENANCE_REQ_FIELD.label = 1
var_0_5.NEWS_MAINTENANCE_REQ_FIELD.has_default_value = false
var_0_5.NEWS_MAINTENANCE_REQ_FIELD.default_value = ""
var_0_5.NEWS_MAINTENANCE_REQ_FIELD.type = 9
var_0_5.NEWS_MAINTENANCE_REQ_FIELD.cpp_type = 9
var_0_5.NEWS_RECEIVE_RESP_FIELD.name = "news_receive_resp"
var_0_5.NEWS_RECEIVE_RESP_FIELD.full_name = ".sgland.SglNewsMsg.news_receive_resp"
var_0_5.NEWS_RECEIVE_RESP_FIELD.number = 1600
var_0_5.NEWS_RECEIVE_RESP_FIELD.index = 1
var_0_5.NEWS_RECEIVE_RESP_FIELD.label = 3
var_0_5.NEWS_RECEIVE_RESP_FIELD.has_default_value = false
var_0_5.NEWS_RECEIVE_RESP_FIELD.default_value = {}
var_0_5.NEWS_RECEIVE_RESP_FIELD.message_type = NEWS
var_0_5.NEWS_RECEIVE_RESP_FIELD.type = 11
var_0_5.NEWS_RECEIVE_RESP_FIELD.cpp_type = 10
var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD.name = "news_announcement_resp"
var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD.full_name = ".sgland.SglNewsMsg.news_announcement_resp"
var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD.number = 1601
var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD.index = 2
var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD.label = 1
var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD.has_default_value = false
var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD.default_value = ""
var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD.type = 9
var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD.cpp_type = 9
var_0_5.NEWS_MAINTENANCE_RESP_FIELD.name = "news_maintenance_resp"
var_0_5.NEWS_MAINTENANCE_RESP_FIELD.full_name = ".sgland.SglNewsMsg.news_maintenance_resp"
var_0_5.NEWS_MAINTENANCE_RESP_FIELD.number = 1602
var_0_5.NEWS_MAINTENANCE_RESP_FIELD.index = 3
var_0_5.NEWS_MAINTENANCE_RESP_FIELD.label = 1
var_0_5.NEWS_MAINTENANCE_RESP_FIELD.has_default_value = false
var_0_5.NEWS_MAINTENANCE_RESP_FIELD.default_value = ""
var_0_5.NEWS_MAINTENANCE_RESP_FIELD.type = 9
var_0_5.NEWS_MAINTENANCE_RESP_FIELD.cpp_type = 9
SGLNEWSMSG.name = "SglNewsMsg"
SGLNEWSMSG.full_name = ".sgland.SglNewsMsg"
SGLNEWSMSG.nested_types = {}
SGLNEWSMSG.enum_types = {}
SGLNEWSMSG.fields = {}
SGLNEWSMSG.is_extendable = false
SGLNEWSMSG.extensions = {
	var_0_5.NEWS_MAINTENANCE_REQ_FIELD,
	var_0_5.NEWS_RECEIVE_RESP_FIELD,
	var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD,
	var_0_5.NEWS_MAINTENANCE_RESP_FIELD
}
News = var_0_0.Message(NEWS)
PB_NEWS_ATTACK_WIN = 5
PB_NEWS_BUY = 16
PB_NEWS_DEFEND_WIN = 6
PB_NEWS_EXPEDITION = 10
PB_NEWS_LOTTERY = 7
PB_NEWS_MIX = 8
PB_NEWS_OPEN_CHEST = 15
PB_NEWS_PURCHASE = 1
PB_NEWS_RANK = 17
PB_NEWS_RANK_LADDER = 18
PB_NEWS_RECRUIT = 11
PB_NEWS_TRANSFORM = 9
PB_NEWS_UNION_CREATE = 13
PB_NEWS_UNION_UPGRADE = 14
PB_NEWS_VISIT = 12
PB_NEWS_WAR_DECLARE = 2
PB_NEWS_WAR_LOSE = 4
PB_NEWS_WAR_WIN = 3
SglNewsMsg = var_0_0.Message(SGLNEWSMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_5.NEWS_MAINTENANCE_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_5.NEWS_RECEIVE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_5.NEWS_ANNOUNCEMENT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_5.NEWS_MAINTENANCE_RESP_FIELD)
