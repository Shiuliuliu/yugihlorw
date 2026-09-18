local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("City_pb")

CITYGUARDREQ = var_0_0.Descriptor()

local var_0_3 = {
	SLOT_ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	IS_GUARD_FIELD = var_0_0.FieldDescriptor()
}

PKGGUARDREQ = var_0_0.Descriptor()

local var_0_4 = {
	SLOT_ID_FIELD = var_0_0.FieldDescriptor(),
	PKG_ID_FIELD = var_0_0.FieldDescriptor(),
	IS_GUARD_FIELD = var_0_0.FieldDescriptor()
}

CITYPROCEDUREASSIGNREQ = var_0_0.Descriptor()

local var_0_5 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	HERO_ID_FIELD = var_0_0.FieldDescriptor()
}

SGLCITYMSG = var_0_0.Descriptor()

local var_0_6 = {
	CITY_GUARD_REQ_FIELD = var_0_0.FieldDescriptor(),
	CITY_PICK_REQ_FIELD = var_0_0.FieldDescriptor(),
	CITY_PROCEDURE_REMOVE_REQ_FIELD = var_0_0.FieldDescriptor(),
	CITY_PROCEDURE_FINISH_REQ_FIELD = var_0_0.FieldDescriptor(),
	CITY_PROCEDURE_ASSIGN_REQ_FIELD = var_0_0.FieldDescriptor(),
	CITY_VISIT_REMOVE_REQ_FIELD = var_0_0.FieldDescriptor(),
	CITY_VISIT_RECRUIT_REQ_FIELD = var_0_0.FieldDescriptor(),
	CITY_VISIT_STAY_REQ_FIELD = var_0_0.FieldDescriptor(),
	CITY_PROCEDURE_CANCEL_REQ_FIELD = var_0_0.FieldDescriptor(),
	PKG_GUARD_REQ_FIELD = var_0_0.FieldDescriptor(),
	CITY_VISIT_RESP_FIELD = var_0_0.FieldDescriptor(),
	CITY_GUARD_RESP_FIELD = var_0_0.FieldDescriptor(),
	CITY_PICK_RESP_FIELD = var_0_0.FieldDescriptor(),
	PKG_GUARD_RESP_FIELD = var_0_0.FieldDescriptor(),
	PKG_PICK_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.SLOT_ID_FIELD.name = "slot_id"
var_0_3.SLOT_ID_FIELD.full_name = ".sgland.CityGuardReq.slot_id"
var_0_3.SLOT_ID_FIELD.number = 1
var_0_3.SLOT_ID_FIELD.index = 0
var_0_3.SLOT_ID_FIELD.label = 2
var_0_3.SLOT_ID_FIELD.has_default_value = false
var_0_3.SLOT_ID_FIELD.default_value = 0
var_0_3.SLOT_ID_FIELD.type = 5
var_0_3.SLOT_ID_FIELD.cpp_type = 1
var_0_3.INFO_ID_FIELD.name = "info_id"
var_0_3.INFO_ID_FIELD.full_name = ".sgland.CityGuardReq.info_id"
var_0_3.INFO_ID_FIELD.number = 2
var_0_3.INFO_ID_FIELD.index = 1
var_0_3.INFO_ID_FIELD.label = 2
var_0_3.INFO_ID_FIELD.has_default_value = false
var_0_3.INFO_ID_FIELD.default_value = 0
var_0_3.INFO_ID_FIELD.type = 5
var_0_3.INFO_ID_FIELD.cpp_type = 1
var_0_3.IS_GUARD_FIELD.name = "is_guard"
var_0_3.IS_GUARD_FIELD.full_name = ".sgland.CityGuardReq.is_guard"
var_0_3.IS_GUARD_FIELD.number = 3
var_0_3.IS_GUARD_FIELD.index = 2
var_0_3.IS_GUARD_FIELD.label = 2
var_0_3.IS_GUARD_FIELD.has_default_value = false
var_0_3.IS_GUARD_FIELD.default_value = false
var_0_3.IS_GUARD_FIELD.type = 8
var_0_3.IS_GUARD_FIELD.cpp_type = 7
CITYGUARDREQ.name = "CityGuardReq"
CITYGUARDREQ.full_name = ".sgland.CityGuardReq"
CITYGUARDREQ.nested_types = {}
CITYGUARDREQ.enum_types = {}
CITYGUARDREQ.fields = {
	var_0_3.SLOT_ID_FIELD,
	var_0_3.INFO_ID_FIELD,
	var_0_3.IS_GUARD_FIELD
}
CITYGUARDREQ.is_extendable = false
CITYGUARDREQ.extensions = {}
var_0_4.SLOT_ID_FIELD.name = "slot_id"
var_0_4.SLOT_ID_FIELD.full_name = ".sgland.PkgGuardReq.slot_id"
var_0_4.SLOT_ID_FIELD.number = 1
var_0_4.SLOT_ID_FIELD.index = 0
var_0_4.SLOT_ID_FIELD.label = 2
var_0_4.SLOT_ID_FIELD.has_default_value = false
var_0_4.SLOT_ID_FIELD.default_value = 0
var_0_4.SLOT_ID_FIELD.type = 5
var_0_4.SLOT_ID_FIELD.cpp_type = 1
var_0_4.PKG_ID_FIELD.name = "pkg_id"
var_0_4.PKG_ID_FIELD.full_name = ".sgland.PkgGuardReq.pkg_id"
var_0_4.PKG_ID_FIELD.number = 2
var_0_4.PKG_ID_FIELD.index = 1
var_0_4.PKG_ID_FIELD.label = 2
var_0_4.PKG_ID_FIELD.has_default_value = false
var_0_4.PKG_ID_FIELD.default_value = 0
var_0_4.PKG_ID_FIELD.type = 5
var_0_4.PKG_ID_FIELD.cpp_type = 1
var_0_4.IS_GUARD_FIELD.name = "is_guard"
var_0_4.IS_GUARD_FIELD.full_name = ".sgland.PkgGuardReq.is_guard"
var_0_4.IS_GUARD_FIELD.number = 3
var_0_4.IS_GUARD_FIELD.index = 2
var_0_4.IS_GUARD_FIELD.label = 2
var_0_4.IS_GUARD_FIELD.has_default_value = false
var_0_4.IS_GUARD_FIELD.default_value = false
var_0_4.IS_GUARD_FIELD.type = 8
var_0_4.IS_GUARD_FIELD.cpp_type = 7
PKGGUARDREQ.name = "PkgGuardReq"
PKGGUARDREQ.full_name = ".sgland.PkgGuardReq"
PKGGUARDREQ.nested_types = {}
PKGGUARDREQ.enum_types = {}
PKGGUARDREQ.fields = {
	var_0_4.SLOT_ID_FIELD,
	var_0_4.PKG_ID_FIELD,
	var_0_4.IS_GUARD_FIELD
}
PKGGUARDREQ.is_extendable = false
PKGGUARDREQ.extensions = {}
var_0_5.ID_FIELD.name = "id"
var_0_5.ID_FIELD.full_name = ".sgland.CityProcedureAssignReq.id"
var_0_5.ID_FIELD.number = 1
var_0_5.ID_FIELD.index = 0
var_0_5.ID_FIELD.label = 2
var_0_5.ID_FIELD.has_default_value = false
var_0_5.ID_FIELD.default_value = 0
var_0_5.ID_FIELD.type = 5
var_0_5.ID_FIELD.cpp_type = 1
var_0_5.HERO_ID_FIELD.name = "hero_id"
var_0_5.HERO_ID_FIELD.full_name = ".sgland.CityProcedureAssignReq.hero_id"
var_0_5.HERO_ID_FIELD.number = 2
var_0_5.HERO_ID_FIELD.index = 1
var_0_5.HERO_ID_FIELD.label = 3
var_0_5.HERO_ID_FIELD.has_default_value = false
var_0_5.HERO_ID_FIELD.default_value = {}
var_0_5.HERO_ID_FIELD.type = 5
var_0_5.HERO_ID_FIELD.cpp_type = 1
CITYPROCEDUREASSIGNREQ.name = "CityProcedureAssignReq"
CITYPROCEDUREASSIGNREQ.full_name = ".sgland.CityProcedureAssignReq"
CITYPROCEDUREASSIGNREQ.nested_types = {}
CITYPROCEDUREASSIGNREQ.enum_types = {}
CITYPROCEDUREASSIGNREQ.fields = {
	var_0_5.ID_FIELD,
	var_0_5.HERO_ID_FIELD
}
CITYPROCEDUREASSIGNREQ.is_extendable = false
CITYPROCEDUREASSIGNREQ.extensions = {}
var_0_6.CITY_GUARD_REQ_FIELD.name = "city_guard_req"
var_0_6.CITY_GUARD_REQ_FIELD.full_name = ".sgland.SglCityMsg.city_guard_req"
var_0_6.CITY_GUARD_REQ_FIELD.number = 400
var_0_6.CITY_GUARD_REQ_FIELD.index = 0
var_0_6.CITY_GUARD_REQ_FIELD.label = 1
var_0_6.CITY_GUARD_REQ_FIELD.has_default_value = false
var_0_6.CITY_GUARD_REQ_FIELD.default_value = nil
var_0_6.CITY_GUARD_REQ_FIELD.message_type = CITYGUARDREQ
var_0_6.CITY_GUARD_REQ_FIELD.type = 11
var_0_6.CITY_GUARD_REQ_FIELD.cpp_type = 10
var_0_6.CITY_PICK_REQ_FIELD.name = "city_pick_req"
var_0_6.CITY_PICK_REQ_FIELD.full_name = ".sgland.SglCityMsg.city_pick_req"
var_0_6.CITY_PICK_REQ_FIELD.number = 401
var_0_6.CITY_PICK_REQ_FIELD.index = 1
var_0_6.CITY_PICK_REQ_FIELD.label = 1
var_0_6.CITY_PICK_REQ_FIELD.has_default_value = false
var_0_6.CITY_PICK_REQ_FIELD.default_value = 0
var_0_6.CITY_PICK_REQ_FIELD.type = 5
var_0_6.CITY_PICK_REQ_FIELD.cpp_type = 1
var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD.name = "city_procedure_remove_req"
var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD.full_name = ".sgland.SglCityMsg.city_procedure_remove_req"
var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD.number = 402
var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD.index = 2
var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD.label = 1
var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD.has_default_value = false
var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD.default_value = 0
var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD.type = 5
var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD.cpp_type = 1
var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD.name = "city_procedure_finish_req"
var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD.full_name = ".sgland.SglCityMsg.city_procedure_finish_req"
var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD.number = 403
var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD.index = 3
var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD.label = 1
var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD.has_default_value = false
var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD.default_value = 0
var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD.type = 5
var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD.cpp_type = 1
var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD.name = "city_procedure_assign_req"
var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD.full_name = ".sgland.SglCityMsg.city_procedure_assign_req"
var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD.number = 404
var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD.index = 4
var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD.label = 1
var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD.has_default_value = false
var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD.default_value = nil
var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD.message_type = CITYPROCEDUREASSIGNREQ
var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD.type = 11
var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD.cpp_type = 10
var_0_6.CITY_VISIT_REMOVE_REQ_FIELD.name = "city_visit_remove_req"
var_0_6.CITY_VISIT_REMOVE_REQ_FIELD.full_name = ".sgland.SglCityMsg.city_visit_remove_req"
var_0_6.CITY_VISIT_REMOVE_REQ_FIELD.number = 405
var_0_6.CITY_VISIT_REMOVE_REQ_FIELD.index = 5
var_0_6.CITY_VISIT_REMOVE_REQ_FIELD.label = 1
var_0_6.CITY_VISIT_REMOVE_REQ_FIELD.has_default_value = false
var_0_6.CITY_VISIT_REMOVE_REQ_FIELD.default_value = 0
var_0_6.CITY_VISIT_REMOVE_REQ_FIELD.type = 5
var_0_6.CITY_VISIT_REMOVE_REQ_FIELD.cpp_type = 1
var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD.name = "city_visit_recruit_req"
var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD.full_name = ".sgland.SglCityMsg.city_visit_recruit_req"
var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD.number = 406
var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD.index = 6
var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD.label = 1
var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD.has_default_value = false
var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD.default_value = 0
var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD.type = 5
var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD.cpp_type = 1
var_0_6.CITY_VISIT_STAY_REQ_FIELD.name = "city_visit_stay_req"
var_0_6.CITY_VISIT_STAY_REQ_FIELD.full_name = ".sgland.SglCityMsg.city_visit_stay_req"
var_0_6.CITY_VISIT_STAY_REQ_FIELD.number = 407
var_0_6.CITY_VISIT_STAY_REQ_FIELD.index = 7
var_0_6.CITY_VISIT_STAY_REQ_FIELD.label = 1
var_0_6.CITY_VISIT_STAY_REQ_FIELD.has_default_value = false
var_0_6.CITY_VISIT_STAY_REQ_FIELD.default_value = 0
var_0_6.CITY_VISIT_STAY_REQ_FIELD.type = 5
var_0_6.CITY_VISIT_STAY_REQ_FIELD.cpp_type = 1
var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD.name = "city_procedure_cancel_req"
var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD.full_name = ".sgland.SglCityMsg.city_procedure_cancel_req"
var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD.number = 408
var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD.index = 8
var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD.label = 1
var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD.has_default_value = false
var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD.default_value = 0
var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD.type = 5
var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD.cpp_type = 1
var_0_6.PKG_GUARD_REQ_FIELD.name = "pkg_guard_req"
var_0_6.PKG_GUARD_REQ_FIELD.full_name = ".sgland.SglCityMsg.pkg_guard_req"
var_0_6.PKG_GUARD_REQ_FIELD.number = 409
var_0_6.PKG_GUARD_REQ_FIELD.index = 9
var_0_6.PKG_GUARD_REQ_FIELD.label = 1
var_0_6.PKG_GUARD_REQ_FIELD.has_default_value = false
var_0_6.PKG_GUARD_REQ_FIELD.default_value = nil
var_0_6.PKG_GUARD_REQ_FIELD.message_type = PKGGUARDREQ
var_0_6.PKG_GUARD_REQ_FIELD.type = 11
var_0_6.PKG_GUARD_REQ_FIELD.cpp_type = 10
var_0_6.CITY_VISIT_RESP_FIELD.name = "city_visit_resp"
var_0_6.CITY_VISIT_RESP_FIELD.full_name = ".sgland.SglCityMsg.city_visit_resp"
var_0_6.CITY_VISIT_RESP_FIELD.number = 400
var_0_6.CITY_VISIT_RESP_FIELD.index = 10
var_0_6.CITY_VISIT_RESP_FIELD.label = 3
var_0_6.CITY_VISIT_RESP_FIELD.has_default_value = false
var_0_6.CITY_VISIT_RESP_FIELD.default_value = {}
var_0_6.CITY_VISIT_RESP_FIELD.message_type = var_0_2.VISIT
var_0_6.CITY_VISIT_RESP_FIELD.type = 11
var_0_6.CITY_VISIT_RESP_FIELD.cpp_type = 10
var_0_6.CITY_GUARD_RESP_FIELD.name = "city_guard_resp"
var_0_6.CITY_GUARD_RESP_FIELD.full_name = ".sgland.SglCityMsg.city_guard_resp"
var_0_6.CITY_GUARD_RESP_FIELD.number = 401
var_0_6.CITY_GUARD_RESP_FIELD.index = 11
var_0_6.CITY_GUARD_RESP_FIELD.label = 1
var_0_6.CITY_GUARD_RESP_FIELD.has_default_value = false
var_0_6.CITY_GUARD_RESP_FIELD.default_value = nil
var_0_6.CITY_GUARD_RESP_FIELD.message_type = var_0_2.GUARDSLOT
var_0_6.CITY_GUARD_RESP_FIELD.type = 11
var_0_6.CITY_GUARD_RESP_FIELD.cpp_type = 10
var_0_6.CITY_PICK_RESP_FIELD.name = "city_pick_resp"
var_0_6.CITY_PICK_RESP_FIELD.full_name = ".sgland.SglCityMsg.city_pick_resp"
var_0_6.CITY_PICK_RESP_FIELD.number = 402
var_0_6.CITY_PICK_RESP_FIELD.index = 12
var_0_6.CITY_PICK_RESP_FIELD.label = 1
var_0_6.CITY_PICK_RESP_FIELD.has_default_value = false
var_0_6.CITY_PICK_RESP_FIELD.default_value = nil
var_0_6.CITY_PICK_RESP_FIELD.message_type = var_0_2.GUARDSLOT
var_0_6.CITY_PICK_RESP_FIELD.type = 11
var_0_6.CITY_PICK_RESP_FIELD.cpp_type = 10
var_0_6.PKG_GUARD_RESP_FIELD.name = "pkg_guard_resp"
var_0_6.PKG_GUARD_RESP_FIELD.full_name = ".sgland.SglCityMsg.pkg_guard_resp"
var_0_6.PKG_GUARD_RESP_FIELD.number = 403
var_0_6.PKG_GUARD_RESP_FIELD.index = 13
var_0_6.PKG_GUARD_RESP_FIELD.label = 1
var_0_6.PKG_GUARD_RESP_FIELD.has_default_value = false
var_0_6.PKG_GUARD_RESP_FIELD.default_value = nil
var_0_6.PKG_GUARD_RESP_FIELD.message_type = var_0_2.PKGGUARDSLOT
var_0_6.PKG_GUARD_RESP_FIELD.type = 11
var_0_6.PKG_GUARD_RESP_FIELD.cpp_type = 10
var_0_6.PKG_PICK_RESP_FIELD.name = "pkg_pick_resp"
var_0_6.PKG_PICK_RESP_FIELD.full_name = ".sgland.SglCityMsg.pkg_pick_resp"
var_0_6.PKG_PICK_RESP_FIELD.number = 404
var_0_6.PKG_PICK_RESP_FIELD.index = 14
var_0_6.PKG_PICK_RESP_FIELD.label = 1
var_0_6.PKG_PICK_RESP_FIELD.has_default_value = false
var_0_6.PKG_PICK_RESP_FIELD.default_value = nil
var_0_6.PKG_PICK_RESP_FIELD.message_type = var_0_2.PKGGUARDSLOT
var_0_6.PKG_PICK_RESP_FIELD.type = 11
var_0_6.PKG_PICK_RESP_FIELD.cpp_type = 10
SGLCITYMSG.name = "SglCityMsg"
SGLCITYMSG.full_name = ".sgland.SglCityMsg"
SGLCITYMSG.nested_types = {}
SGLCITYMSG.enum_types = {}
SGLCITYMSG.fields = {}
SGLCITYMSG.is_extendable = false
SGLCITYMSG.extensions = {
	var_0_6.CITY_GUARD_REQ_FIELD,
	var_0_6.CITY_PICK_REQ_FIELD,
	var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD,
	var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD,
	var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD,
	var_0_6.CITY_VISIT_REMOVE_REQ_FIELD,
	var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD,
	var_0_6.CITY_VISIT_STAY_REQ_FIELD,
	var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD,
	var_0_6.PKG_GUARD_REQ_FIELD,
	var_0_6.CITY_VISIT_RESP_FIELD,
	var_0_6.CITY_GUARD_RESP_FIELD,
	var_0_6.CITY_PICK_RESP_FIELD,
	var_0_6.PKG_GUARD_RESP_FIELD,
	var_0_6.PKG_PICK_RESP_FIELD
}
CityGuardReq = var_0_0.Message(CITYGUARDREQ)
CityProcedureAssignReq = var_0_0.Message(CITYPROCEDUREASSIGNREQ)
PkgGuardReq = var_0_0.Message(PKGGUARDREQ)
SglCityMsg = var_0_0.Message(SGLCITYMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_6.CITY_GUARD_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.CITY_PICK_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.CITY_PROCEDURE_REMOVE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.CITY_PROCEDURE_FINISH_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.CITY_PROCEDURE_ASSIGN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.CITY_VISIT_REMOVE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.CITY_VISIT_RECRUIT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.CITY_VISIT_STAY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.CITY_PROCEDURE_CANCEL_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_6.PKG_GUARD_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.CITY_VISIT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.CITY_GUARD_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.CITY_PICK_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.PKG_GUARD_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.PKG_PICK_RESP_FIELD)
