local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")

module("Auth_pb")

SGLAUTHMSG = var_0_0.Descriptor()

local var_0_2 = {
	AUTHENTICATION_FIELD = var_0_0.FieldDescriptor(),
	AGENT_FIELD = var_0_0.FieldDescriptor(),
	PASS_FIELD = var_0_0.FieldDescriptor(),
	CHALLENGE_FIELD = var_0_0.FieldDescriptor()
}

var_0_2.AUTHENTICATION_FIELD.name = "authentication"
var_0_2.AUTHENTICATION_FIELD.full_name = ".sgland.SglAuthMsg.authentication"
var_0_2.AUTHENTICATION_FIELD.number = 100
var_0_2.AUTHENTICATION_FIELD.index = 0
var_0_2.AUTHENTICATION_FIELD.label = 1
var_0_2.AUTHENTICATION_FIELD.has_default_value = false
var_0_2.AUTHENTICATION_FIELD.default_value = ""
var_0_2.AUTHENTICATION_FIELD.type = 12
var_0_2.AUTHENTICATION_FIELD.cpp_type = 9
var_0_2.AGENT_FIELD.name = "agent"
var_0_2.AGENT_FIELD.full_name = ".sgland.SglAuthMsg.agent"
var_0_2.AGENT_FIELD.number = 101
var_0_2.AGENT_FIELD.index = 1
var_0_2.AGENT_FIELD.label = 1
var_0_2.AGENT_FIELD.has_default_value = false
var_0_2.AGENT_FIELD.default_value = ""
var_0_2.AGENT_FIELD.type = 9
var_0_2.AGENT_FIELD.cpp_type = 9
var_0_2.PASS_FIELD.name = "pass"
var_0_2.PASS_FIELD.full_name = ".sgland.SglAuthMsg.pass"
var_0_2.PASS_FIELD.number = 102
var_0_2.PASS_FIELD.index = 2
var_0_2.PASS_FIELD.label = 1
var_0_2.PASS_FIELD.has_default_value = false
var_0_2.PASS_FIELD.default_value = ""
var_0_2.PASS_FIELD.type = 9
var_0_2.PASS_FIELD.cpp_type = 9
var_0_2.CHALLENGE_FIELD.name = "challenge"
var_0_2.CHALLENGE_FIELD.full_name = ".sgland.SglAuthMsg.challenge"
var_0_2.CHALLENGE_FIELD.number = 100
var_0_2.CHALLENGE_FIELD.index = 3
var_0_2.CHALLENGE_FIELD.label = 1
var_0_2.CHALLENGE_FIELD.has_default_value = false
var_0_2.CHALLENGE_FIELD.default_value = ""
var_0_2.CHALLENGE_FIELD.type = 12
var_0_2.CHALLENGE_FIELD.cpp_type = 9
SGLAUTHMSG.name = "SglAuthMsg"
SGLAUTHMSG.full_name = ".sgland.SglAuthMsg"
SGLAUTHMSG.nested_types = {}
SGLAUTHMSG.enum_types = {}
SGLAUTHMSG.fields = {}
SGLAUTHMSG.is_extendable = false
SGLAUTHMSG.extensions = {
	var_0_2.AUTHENTICATION_FIELD,
	var_0_2.AGENT_FIELD,
	var_0_2.PASS_FIELD,
	var_0_2.CHALLENGE_FIELD
}
SglAuthMsg = var_0_0.Message(SGLAUTHMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_2.AUTHENTICATION_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_2.AGENT_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_2.PASS_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_2.CHALLENGE_FIELD)
