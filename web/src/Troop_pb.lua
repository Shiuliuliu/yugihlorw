local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Troop_pb")

TROOPRELOADREQ = var_0_0.Descriptor()

local var_0_3 = {
	TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	TROOP_INFO_FIELD = var_0_0.FieldDescriptor(),
	IS_CHECK_FIELD = var_0_0.FieldDescriptor()
}

TROOPMARKREQ = var_0_0.Descriptor()

local var_0_4 = {
	TROOP_ID_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor()
}

SGLTROOPMSG = var_0_0.Descriptor()

local var_0_5 = {
	TROOP_RELOAD_REQ_FIELD = var_0_0.FieldDescriptor(),
	TROOP_MARK_REQ_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.TROOP_ID_FIELD.name = "troop_id"
var_0_3.TROOP_ID_FIELD.full_name = ".sgland.TroopReloadReq.troop_id"
var_0_3.TROOP_ID_FIELD.number = 1
var_0_3.TROOP_ID_FIELD.index = 0
var_0_3.TROOP_ID_FIELD.label = 2
var_0_3.TROOP_ID_FIELD.has_default_value = false
var_0_3.TROOP_ID_FIELD.default_value = 0
var_0_3.TROOP_ID_FIELD.type = 5
var_0_3.TROOP_ID_FIELD.cpp_type = 1
var_0_3.TROOP_INFO_FIELD.name = "troop_info"
var_0_3.TROOP_INFO_FIELD.full_name = ".sgland.TroopReloadReq.troop_info"
var_0_3.TROOP_INFO_FIELD.number = 2
var_0_3.TROOP_INFO_FIELD.index = 1
var_0_3.TROOP_INFO_FIELD.label = 3
var_0_3.TROOP_INFO_FIELD.has_default_value = false
var_0_3.TROOP_INFO_FIELD.default_value = {}
var_0_3.TROOP_INFO_FIELD.message_type = var_0_2.RESOURCE
var_0_3.TROOP_INFO_FIELD.type = 11
var_0_3.TROOP_INFO_FIELD.cpp_type = 10
var_0_3.IS_CHECK_FIELD.name = "is_check"
var_0_3.IS_CHECK_FIELD.full_name = ".sgland.TroopReloadReq.is_check"
var_0_3.IS_CHECK_FIELD.number = 3
var_0_3.IS_CHECK_FIELD.index = 2
var_0_3.IS_CHECK_FIELD.label = 2
var_0_3.IS_CHECK_FIELD.has_default_value = false
var_0_3.IS_CHECK_FIELD.default_value = false
var_0_3.IS_CHECK_FIELD.type = 8
var_0_3.IS_CHECK_FIELD.cpp_type = 7
TROOPRELOADREQ.name = "TroopReloadReq"
TROOPRELOADREQ.full_name = ".sgland.TroopReloadReq"
TROOPRELOADREQ.nested_types = {}
TROOPRELOADREQ.enum_types = {}
TROOPRELOADREQ.fields = {
	var_0_3.TROOP_ID_FIELD,
	var_0_3.TROOP_INFO_FIELD,
	var_0_3.IS_CHECK_FIELD
}
TROOPRELOADREQ.is_extendable = false
TROOPRELOADREQ.extensions = {}
var_0_4.TROOP_ID_FIELD.name = "troop_id"
var_0_4.TROOP_ID_FIELD.full_name = ".sgland.TroopMarkReq.troop_id"
var_0_4.TROOP_ID_FIELD.number = 1
var_0_4.TROOP_ID_FIELD.index = 0
var_0_4.TROOP_ID_FIELD.label = 2
var_0_4.TROOP_ID_FIELD.has_default_value = false
var_0_4.TROOP_ID_FIELD.default_value = 0
var_0_4.TROOP_ID_FIELD.type = 5
var_0_4.TROOP_ID_FIELD.cpp_type = 1
var_0_4.NAME_FIELD.name = "name"
var_0_4.NAME_FIELD.full_name = ".sgland.TroopMarkReq.name"
var_0_4.NAME_FIELD.number = 2
var_0_4.NAME_FIELD.index = 1
var_0_4.NAME_FIELD.label = 2
var_0_4.NAME_FIELD.has_default_value = false
var_0_4.NAME_FIELD.default_value = ""
var_0_4.NAME_FIELD.type = 9
var_0_4.NAME_FIELD.cpp_type = 9
TROOPMARKREQ.name = "TroopMarkReq"
TROOPMARKREQ.full_name = ".sgland.TroopMarkReq"
TROOPMARKREQ.nested_types = {}
TROOPMARKREQ.enum_types = {}
TROOPMARKREQ.fields = {
	var_0_4.TROOP_ID_FIELD,
	var_0_4.NAME_FIELD
}
TROOPMARKREQ.is_extendable = false
TROOPMARKREQ.extensions = {}
var_0_5.TROOP_RELOAD_REQ_FIELD.name = "troop_reload_req"
var_0_5.TROOP_RELOAD_REQ_FIELD.full_name = ".sgland.SglTroopMsg.troop_reload_req"
var_0_5.TROOP_RELOAD_REQ_FIELD.number = 800
var_0_5.TROOP_RELOAD_REQ_FIELD.index = 0
var_0_5.TROOP_RELOAD_REQ_FIELD.label = 3
var_0_5.TROOP_RELOAD_REQ_FIELD.has_default_value = false
var_0_5.TROOP_RELOAD_REQ_FIELD.default_value = {}
var_0_5.TROOP_RELOAD_REQ_FIELD.message_type = TROOPRELOADREQ
var_0_5.TROOP_RELOAD_REQ_FIELD.type = 11
var_0_5.TROOP_RELOAD_REQ_FIELD.cpp_type = 10
var_0_5.TROOP_MARK_REQ_FIELD.name = "troop_mark_req"
var_0_5.TROOP_MARK_REQ_FIELD.full_name = ".sgland.SglTroopMsg.troop_mark_req"
var_0_5.TROOP_MARK_REQ_FIELD.number = 801
var_0_5.TROOP_MARK_REQ_FIELD.index = 1
var_0_5.TROOP_MARK_REQ_FIELD.label = 1
var_0_5.TROOP_MARK_REQ_FIELD.has_default_value = false
var_0_5.TROOP_MARK_REQ_FIELD.default_value = nil
var_0_5.TROOP_MARK_REQ_FIELD.message_type = TROOPMARKREQ
var_0_5.TROOP_MARK_REQ_FIELD.type = 11
var_0_5.TROOP_MARK_REQ_FIELD.cpp_type = 10
SGLTROOPMSG.name = "SglTroopMsg"
SGLTROOPMSG.full_name = ".sgland.SglTroopMsg"
SGLTROOPMSG.nested_types = {}
SGLTROOPMSG.enum_types = {}
SGLTROOPMSG.fields = {}
SGLTROOPMSG.is_extendable = false
SGLTROOPMSG.extensions = {
	var_0_5.TROOP_RELOAD_REQ_FIELD,
	var_0_5.TROOP_MARK_REQ_FIELD
}
SglTroopMsg = var_0_0.Message(SGLTROOPMSG)
TroopMarkReq = var_0_0.Message(TROOPMARKREQ)
TroopReloadReq = var_0_0.Message(TROOPRELOADREQ)

var_0_1.SglReqMsg.RegisterExtension(var_0_5.TROOP_RELOAD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_5.TROOP_MARK_REQ_FIELD)
