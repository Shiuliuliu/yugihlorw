local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Region_pb")

REGIONSTATUS = var_0_0.EnumDescriptor()

local var_0_3 = {
	PB_TYPE_IDLE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BUSY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FULL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MAINTAIN = var_0_0.EnumValueDescriptor()
}

REGION = var_0_0.Descriptor()

local var_0_4 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	HOST_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor(),
	STATUS_FIELD = var_0_0.FieldDescriptor(),
	IS_NEW_FIELD = var_0_0.FieldDescriptor(),
	IS_RECOMMEND_FIELD = var_0_0.FieldDescriptor(),
	OPEN_TIME_FIELD = var_0_0.FieldDescriptor()
}

REGIONGROUP = var_0_0.Descriptor()

local var_0_5 = {
	NAME_FIELD = var_0_0.FieldDescriptor(),
	REGIONS_FIELD = var_0_0.FieldDescriptor()
}

REGIONLISTREQ = var_0_0.Descriptor()

local var_0_6 = {
	UID_FIELD = var_0_0.FieldDescriptor(),
	CHANNEL_FIELD = var_0_0.FieldDescriptor(),
	GCID_FIELD = var_0_0.FieldDescriptor(),
	IS_REVIEW_FIELD = var_0_0.FieldDescriptor()
}

REGIONLISTRESP = var_0_0.Descriptor()

local var_0_7 = {
	REGION_FIELD = var_0_0.FieldDescriptor(),
	LAST_LOGIN_FIELD = var_0_0.FieldDescriptor(),
	MAINTAIN_INFO_FIELD = var_0_0.FieldDescriptor()
}

GIFTCALLBACK = var_0_0.Descriptor()

local var_0_8 = {
	CHANNEL_FIELD = var_0_0.FieldDescriptor(),
	RID_FIELD = var_0_0.FieldDescriptor(),
	UID_FIELD = var_0_0.FieldDescriptor(),
	TASK_ID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

SGLREGIONMSG = var_0_0.Descriptor()

local var_0_9 = {
	REGION_LIST_REQ_FIELD = var_0_0.FieldDescriptor(),
	REGION_LIST_RESP_FIELD = var_0_0.FieldDescriptor(),
	REGION_GROUP_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.PB_TYPE_IDLE.name = "PB_TYPE_IDLE"
var_0_3.PB_TYPE_IDLE.index = 0
var_0_3.PB_TYPE_IDLE.number = 1
var_0_3.PB_TYPE_BUSY.name = "PB_TYPE_BUSY"
var_0_3.PB_TYPE_BUSY.index = 1
var_0_3.PB_TYPE_BUSY.number = 2
var_0_3.PB_TYPE_FULL.name = "PB_TYPE_FULL"
var_0_3.PB_TYPE_FULL.index = 2
var_0_3.PB_TYPE_FULL.number = 3
var_0_3.PB_TYPE_MAINTAIN.name = "PB_TYPE_MAINTAIN"
var_0_3.PB_TYPE_MAINTAIN.index = 3
var_0_3.PB_TYPE_MAINTAIN.number = 4
REGIONSTATUS.name = "RegionStatus"
REGIONSTATUS.full_name = ".sgland.RegionStatus"
REGIONSTATUS.values = {
	var_0_3.PB_TYPE_IDLE,
	var_0_3.PB_TYPE_BUSY,
	var_0_3.PB_TYPE_FULL,
	var_0_3.PB_TYPE_MAINTAIN
}
var_0_4.ID_FIELD.name = "id"
var_0_4.ID_FIELD.full_name = ".sgland.Region.id"
var_0_4.ID_FIELD.number = 1
var_0_4.ID_FIELD.index = 0
var_0_4.ID_FIELD.label = 2
var_0_4.ID_FIELD.has_default_value = false
var_0_4.ID_FIELD.default_value = 0
var_0_4.ID_FIELD.type = 5
var_0_4.ID_FIELD.cpp_type = 1
var_0_4.HOST_FIELD.name = "host"
var_0_4.HOST_FIELD.full_name = ".sgland.Region.host"
var_0_4.HOST_FIELD.number = 2
var_0_4.HOST_FIELD.index = 1
var_0_4.HOST_FIELD.label = 2
var_0_4.HOST_FIELD.has_default_value = false
var_0_4.HOST_FIELD.default_value = ""
var_0_4.HOST_FIELD.type = 9
var_0_4.HOST_FIELD.cpp_type = 9
var_0_4.NAME_FIELD.name = "name"
var_0_4.NAME_FIELD.full_name = ".sgland.Region.name"
var_0_4.NAME_FIELD.number = 3
var_0_4.NAME_FIELD.index = 2
var_0_4.NAME_FIELD.label = 2
var_0_4.NAME_FIELD.has_default_value = false
var_0_4.NAME_FIELD.default_value = ""
var_0_4.NAME_FIELD.type = 9
var_0_4.NAME_FIELD.cpp_type = 9
var_0_4.STATUS_FIELD.name = "status"
var_0_4.STATUS_FIELD.full_name = ".sgland.Region.status"
var_0_4.STATUS_FIELD.number = 4
var_0_4.STATUS_FIELD.index = 3
var_0_4.STATUS_FIELD.label = 2
var_0_4.STATUS_FIELD.has_default_value = false
var_0_4.STATUS_FIELD.default_value = nil
var_0_4.STATUS_FIELD.enum_type = REGIONSTATUS
var_0_4.STATUS_FIELD.type = 14
var_0_4.STATUS_FIELD.cpp_type = 8
var_0_4.IS_NEW_FIELD.name = "is_new"
var_0_4.IS_NEW_FIELD.full_name = ".sgland.Region.is_new"
var_0_4.IS_NEW_FIELD.number = 5
var_0_4.IS_NEW_FIELD.index = 4
var_0_4.IS_NEW_FIELD.label = 2
var_0_4.IS_NEW_FIELD.has_default_value = false
var_0_4.IS_NEW_FIELD.default_value = false
var_0_4.IS_NEW_FIELD.type = 8
var_0_4.IS_NEW_FIELD.cpp_type = 7
var_0_4.IS_RECOMMEND_FIELD.name = "is_recommend"
var_0_4.IS_RECOMMEND_FIELD.full_name = ".sgland.Region.is_recommend"
var_0_4.IS_RECOMMEND_FIELD.number = 6
var_0_4.IS_RECOMMEND_FIELD.index = 5
var_0_4.IS_RECOMMEND_FIELD.label = 2
var_0_4.IS_RECOMMEND_FIELD.has_default_value = false
var_0_4.IS_RECOMMEND_FIELD.default_value = false
var_0_4.IS_RECOMMEND_FIELD.type = 8
var_0_4.IS_RECOMMEND_FIELD.cpp_type = 7
var_0_4.OPEN_TIME_FIELD.name = "open_time"
var_0_4.OPEN_TIME_FIELD.full_name = ".sgland.Region.open_time"
var_0_4.OPEN_TIME_FIELD.number = 7
var_0_4.OPEN_TIME_FIELD.index = 6
var_0_4.OPEN_TIME_FIELD.label = 1
var_0_4.OPEN_TIME_FIELD.has_default_value = false
var_0_4.OPEN_TIME_FIELD.default_value = 0
var_0_4.OPEN_TIME_FIELD.type = 3
var_0_4.OPEN_TIME_FIELD.cpp_type = 2
REGION.name = "Region"
REGION.full_name = ".sgland.Region"
REGION.nested_types = {}
REGION.enum_types = {}
REGION.fields = {
	var_0_4.ID_FIELD,
	var_0_4.HOST_FIELD,
	var_0_4.NAME_FIELD,
	var_0_4.STATUS_FIELD,
	var_0_4.IS_NEW_FIELD,
	var_0_4.IS_RECOMMEND_FIELD,
	var_0_4.OPEN_TIME_FIELD
}
REGION.is_extendable = false
REGION.extensions = {}
var_0_5.NAME_FIELD.name = "name"
var_0_5.NAME_FIELD.full_name = ".sgland.RegionGroup.name"
var_0_5.NAME_FIELD.number = 1
var_0_5.NAME_FIELD.index = 0
var_0_5.NAME_FIELD.label = 2
var_0_5.NAME_FIELD.has_default_value = false
var_0_5.NAME_FIELD.default_value = ""
var_0_5.NAME_FIELD.type = 9
var_0_5.NAME_FIELD.cpp_type = 9
var_0_5.REGIONS_FIELD.name = "regions"
var_0_5.REGIONS_FIELD.full_name = ".sgland.RegionGroup.regions"
var_0_5.REGIONS_FIELD.number = 2
var_0_5.REGIONS_FIELD.index = 1
var_0_5.REGIONS_FIELD.label = 3
var_0_5.REGIONS_FIELD.has_default_value = false
var_0_5.REGIONS_FIELD.default_value = {}
var_0_5.REGIONS_FIELD.message_type = REGION
var_0_5.REGIONS_FIELD.type = 11
var_0_5.REGIONS_FIELD.cpp_type = 10
REGIONGROUP.name = "RegionGroup"
REGIONGROUP.full_name = ".sgland.RegionGroup"
REGIONGROUP.nested_types = {}
REGIONGROUP.enum_types = {}
REGIONGROUP.fields = {
	var_0_5.NAME_FIELD,
	var_0_5.REGIONS_FIELD
}
REGIONGROUP.is_extendable = false
REGIONGROUP.extensions = {}
var_0_6.UID_FIELD.name = "uid"
var_0_6.UID_FIELD.full_name = ".sgland.RegionListReq.uid"
var_0_6.UID_FIELD.number = 1
var_0_6.UID_FIELD.index = 0
var_0_6.UID_FIELD.label = 2
var_0_6.UID_FIELD.has_default_value = false
var_0_6.UID_FIELD.default_value = ""
var_0_6.UID_FIELD.type = 9
var_0_6.UID_FIELD.cpp_type = 9
var_0_6.CHANNEL_FIELD.name = "channel"
var_0_6.CHANNEL_FIELD.full_name = ".sgland.RegionListReq.channel"
var_0_6.CHANNEL_FIELD.number = 2
var_0_6.CHANNEL_FIELD.index = 1
var_0_6.CHANNEL_FIELD.label = 2
var_0_6.CHANNEL_FIELD.has_default_value = false
var_0_6.CHANNEL_FIELD.default_value = ""
var_0_6.CHANNEL_FIELD.type = 9
var_0_6.CHANNEL_FIELD.cpp_type = 9
var_0_6.GCID_FIELD.name = "gcid"
var_0_6.GCID_FIELD.full_name = ".sgland.RegionListReq.gcid"
var_0_6.GCID_FIELD.number = 3
var_0_6.GCID_FIELD.index = 2
var_0_6.GCID_FIELD.label = 1
var_0_6.GCID_FIELD.has_default_value = false
var_0_6.GCID_FIELD.default_value = ""
var_0_6.GCID_FIELD.type = 9
var_0_6.GCID_FIELD.cpp_type = 9
var_0_6.IS_REVIEW_FIELD.name = "is_review"
var_0_6.IS_REVIEW_FIELD.full_name = ".sgland.RegionListReq.is_review"
var_0_6.IS_REVIEW_FIELD.number = 4
var_0_6.IS_REVIEW_FIELD.index = 3
var_0_6.IS_REVIEW_FIELD.label = 1
var_0_6.IS_REVIEW_FIELD.has_default_value = false
var_0_6.IS_REVIEW_FIELD.default_value = false
var_0_6.IS_REVIEW_FIELD.type = 8
var_0_6.IS_REVIEW_FIELD.cpp_type = 7
REGIONLISTREQ.name = "RegionListReq"
REGIONLISTREQ.full_name = ".sgland.RegionListReq"
REGIONLISTREQ.nested_types = {}
REGIONLISTREQ.enum_types = {}
REGIONLISTREQ.fields = {
	var_0_6.UID_FIELD,
	var_0_6.CHANNEL_FIELD,
	var_0_6.GCID_FIELD,
	var_0_6.IS_REVIEW_FIELD
}
REGIONLISTREQ.is_extendable = false
REGIONLISTREQ.extensions = {}
var_0_7.REGION_FIELD.name = "region"
var_0_7.REGION_FIELD.full_name = ".sgland.RegionListResp.region"
var_0_7.REGION_FIELD.number = 1
var_0_7.REGION_FIELD.index = 0
var_0_7.REGION_FIELD.label = 3
var_0_7.REGION_FIELD.has_default_value = false
var_0_7.REGION_FIELD.default_value = {}
var_0_7.REGION_FIELD.message_type = REGION
var_0_7.REGION_FIELD.type = 11
var_0_7.REGION_FIELD.cpp_type = 10
var_0_7.LAST_LOGIN_FIELD.name = "last_login"
var_0_7.LAST_LOGIN_FIELD.full_name = ".sgland.RegionListResp.last_login"
var_0_7.LAST_LOGIN_FIELD.number = 2
var_0_7.LAST_LOGIN_FIELD.index = 1
var_0_7.LAST_LOGIN_FIELD.label = 3
var_0_7.LAST_LOGIN_FIELD.has_default_value = false
var_0_7.LAST_LOGIN_FIELD.default_value = {}
var_0_7.LAST_LOGIN_FIELD.message_type = var_0_2.LOGININFO
var_0_7.LAST_LOGIN_FIELD.type = 11
var_0_7.LAST_LOGIN_FIELD.cpp_type = 10
var_0_7.MAINTAIN_INFO_FIELD.name = "maintain_info"
var_0_7.MAINTAIN_INFO_FIELD.full_name = ".sgland.RegionListResp.maintain_info"
var_0_7.MAINTAIN_INFO_FIELD.number = 3
var_0_7.MAINTAIN_INFO_FIELD.index = 2
var_0_7.MAINTAIN_INFO_FIELD.label = 1
var_0_7.MAINTAIN_INFO_FIELD.has_default_value = false
var_0_7.MAINTAIN_INFO_FIELD.default_value = ""
var_0_7.MAINTAIN_INFO_FIELD.type = 9
var_0_7.MAINTAIN_INFO_FIELD.cpp_type = 9
REGIONLISTRESP.name = "RegionListResp"
REGIONLISTRESP.full_name = ".sgland.RegionListResp"
REGIONLISTRESP.nested_types = {}
REGIONLISTRESP.enum_types = {}
REGIONLISTRESP.fields = {
	var_0_7.REGION_FIELD,
	var_0_7.LAST_LOGIN_FIELD,
	var_0_7.MAINTAIN_INFO_FIELD
}
REGIONLISTRESP.is_extendable = false
REGIONLISTRESP.extensions = {}
var_0_8.CHANNEL_FIELD.name = "channel"
var_0_8.CHANNEL_FIELD.full_name = ".sgland.GiftCallback.channel"
var_0_8.CHANNEL_FIELD.number = 1
var_0_8.CHANNEL_FIELD.index = 0
var_0_8.CHANNEL_FIELD.label = 2
var_0_8.CHANNEL_FIELD.has_default_value = false
var_0_8.CHANNEL_FIELD.default_value = ""
var_0_8.CHANNEL_FIELD.type = 9
var_0_8.CHANNEL_FIELD.cpp_type = 9
var_0_8.RID_FIELD.name = "rid"
var_0_8.RID_FIELD.full_name = ".sgland.GiftCallback.rid"
var_0_8.RID_FIELD.number = 2
var_0_8.RID_FIELD.index = 1
var_0_8.RID_FIELD.label = 2
var_0_8.RID_FIELD.has_default_value = false
var_0_8.RID_FIELD.default_value = 0
var_0_8.RID_FIELD.type = 5
var_0_8.RID_FIELD.cpp_type = 1
var_0_8.UID_FIELD.name = "uid"
var_0_8.UID_FIELD.full_name = ".sgland.GiftCallback.uid"
var_0_8.UID_FIELD.number = 3
var_0_8.UID_FIELD.index = 2
var_0_8.UID_FIELD.label = 2
var_0_8.UID_FIELD.has_default_value = false
var_0_8.UID_FIELD.default_value = ""
var_0_8.UID_FIELD.type = 9
var_0_8.UID_FIELD.cpp_type = 9
var_0_8.TASK_ID_FIELD.name = "task_id"
var_0_8.TASK_ID_FIELD.full_name = ".sgland.GiftCallback.task_id"
var_0_8.TASK_ID_FIELD.number = 4
var_0_8.TASK_ID_FIELD.index = 3
var_0_8.TASK_ID_FIELD.label = 2
var_0_8.TASK_ID_FIELD.has_default_value = false
var_0_8.TASK_ID_FIELD.default_value = 0
var_0_8.TASK_ID_FIELD.type = 5
var_0_8.TASK_ID_FIELD.cpp_type = 1
var_0_8.TIMESTAMP_FIELD.name = "timestamp"
var_0_8.TIMESTAMP_FIELD.full_name = ".sgland.GiftCallback.timestamp"
var_0_8.TIMESTAMP_FIELD.number = 5
var_0_8.TIMESTAMP_FIELD.index = 4
var_0_8.TIMESTAMP_FIELD.label = 2
var_0_8.TIMESTAMP_FIELD.has_default_value = false
var_0_8.TIMESTAMP_FIELD.default_value = 0
var_0_8.TIMESTAMP_FIELD.type = 3
var_0_8.TIMESTAMP_FIELD.cpp_type = 2
GIFTCALLBACK.name = "GiftCallback"
GIFTCALLBACK.full_name = ".sgland.GiftCallback"
GIFTCALLBACK.nested_types = {}
GIFTCALLBACK.enum_types = {}
GIFTCALLBACK.fields = {
	var_0_8.CHANNEL_FIELD,
	var_0_8.RID_FIELD,
	var_0_8.UID_FIELD,
	var_0_8.TASK_ID_FIELD,
	var_0_8.TIMESTAMP_FIELD
}
GIFTCALLBACK.is_extendable = false
GIFTCALLBACK.extensions = {}
var_0_9.REGION_LIST_REQ_FIELD.name = "region_list_req"
var_0_9.REGION_LIST_REQ_FIELD.full_name = ".sgland.SglRegionMsg.region_list_req"
var_0_9.REGION_LIST_REQ_FIELD.number = 1900
var_0_9.REGION_LIST_REQ_FIELD.index = 0
var_0_9.REGION_LIST_REQ_FIELD.label = 1
var_0_9.REGION_LIST_REQ_FIELD.has_default_value = false
var_0_9.REGION_LIST_REQ_FIELD.default_value = nil
var_0_9.REGION_LIST_REQ_FIELD.message_type = REGIONLISTREQ
var_0_9.REGION_LIST_REQ_FIELD.type = 11
var_0_9.REGION_LIST_REQ_FIELD.cpp_type = 10
var_0_9.REGION_LIST_RESP_FIELD.name = "region_list_resp"
var_0_9.REGION_LIST_RESP_FIELD.full_name = ".sgland.SglRegionMsg.region_list_resp"
var_0_9.REGION_LIST_RESP_FIELD.number = 1900
var_0_9.REGION_LIST_RESP_FIELD.index = 1
var_0_9.REGION_LIST_RESP_FIELD.label = 1
var_0_9.REGION_LIST_RESP_FIELD.has_default_value = false
var_0_9.REGION_LIST_RESP_FIELD.default_value = nil
var_0_9.REGION_LIST_RESP_FIELD.message_type = REGIONLISTRESP
var_0_9.REGION_LIST_RESP_FIELD.type = 11
var_0_9.REGION_LIST_RESP_FIELD.cpp_type = 10
var_0_9.REGION_GROUP_RESP_FIELD.name = "region_group_resp"
var_0_9.REGION_GROUP_RESP_FIELD.full_name = ".sgland.SglRegionMsg.region_group_resp"
var_0_9.REGION_GROUP_RESP_FIELD.number = 1901
var_0_9.REGION_GROUP_RESP_FIELD.index = 2
var_0_9.REGION_GROUP_RESP_FIELD.label = 3
var_0_9.REGION_GROUP_RESP_FIELD.has_default_value = false
var_0_9.REGION_GROUP_RESP_FIELD.default_value = {}
var_0_9.REGION_GROUP_RESP_FIELD.message_type = REGIONGROUP
var_0_9.REGION_GROUP_RESP_FIELD.type = 11
var_0_9.REGION_GROUP_RESP_FIELD.cpp_type = 10
SGLREGIONMSG.name = "SglRegionMsg"
SGLREGIONMSG.full_name = ".sgland.SglRegionMsg"
SGLREGIONMSG.nested_types = {}
SGLREGIONMSG.enum_types = {}
SGLREGIONMSG.fields = {}
SGLREGIONMSG.is_extendable = false
SGLREGIONMSG.extensions = {
	var_0_9.REGION_LIST_REQ_FIELD,
	var_0_9.REGION_LIST_RESP_FIELD,
	var_0_9.REGION_GROUP_RESP_FIELD
}
GiftCallback = var_0_0.Message(GIFTCALLBACK)
PB_TYPE_BUSY = 2
PB_TYPE_FULL = 3
PB_TYPE_IDLE = 1
PB_TYPE_MAINTAIN = 4
Region = var_0_0.Message(REGION)
RegionGroup = var_0_0.Message(REGIONGROUP)
RegionListReq = var_0_0.Message(REGIONLISTREQ)
RegionListResp = var_0_0.Message(REGIONLISTRESP)
SglRegionMsg = var_0_0.Message(SGLREGIONMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_9.REGION_LIST_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_9.REGION_LIST_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_9.REGION_GROUP_RESP_FIELD)
