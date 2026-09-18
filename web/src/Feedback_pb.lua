local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")

module("Feedback_pb")

FEEDBACKTYPE = var_0_0.EnumDescriptor()

local var_0_2 = {
	PB_FEEDBACK_CONSULT = var_0_0.EnumValueDescriptor(),
	PB_FEEDBACK_BUG = var_0_0.EnumValueDescriptor(),
	PB_FEEDBACK_COMPLAINT = var_0_0.EnumValueDescriptor(),
	PB_FEEDBACK_SUGGESTION = var_0_0.EnumValueDescriptor()
}

FEEDBACKREQ = var_0_0.Descriptor()

local var_0_3 = {
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	CONTENT_FIELD = var_0_0.FieldDescriptor()
}

SGLFEEDBACKMSG = var_0_0.Descriptor()

local var_0_4 = {
	FEEDBACK_REQ_FIELD = var_0_0.FieldDescriptor()
}

var_0_2.PB_FEEDBACK_CONSULT.name = "PB_FEEDBACK_CONSULT"
var_0_2.PB_FEEDBACK_CONSULT.index = 0
var_0_2.PB_FEEDBACK_CONSULT.number = 1
var_0_2.PB_FEEDBACK_BUG.name = "PB_FEEDBACK_BUG"
var_0_2.PB_FEEDBACK_BUG.index = 1
var_0_2.PB_FEEDBACK_BUG.number = 2
var_0_2.PB_FEEDBACK_COMPLAINT.name = "PB_FEEDBACK_COMPLAINT"
var_0_2.PB_FEEDBACK_COMPLAINT.index = 2
var_0_2.PB_FEEDBACK_COMPLAINT.number = 3
var_0_2.PB_FEEDBACK_SUGGESTION.name = "PB_FEEDBACK_SUGGESTION"
var_0_2.PB_FEEDBACK_SUGGESTION.index = 3
var_0_2.PB_FEEDBACK_SUGGESTION.number = 4
FEEDBACKTYPE.name = "FeedbackType"
FEEDBACKTYPE.full_name = ".sgland.FeedbackType"
FEEDBACKTYPE.values = {
	var_0_2.PB_FEEDBACK_CONSULT,
	var_0_2.PB_FEEDBACK_BUG,
	var_0_2.PB_FEEDBACK_COMPLAINT,
	var_0_2.PB_FEEDBACK_SUGGESTION
}
var_0_3.TYPE_FIELD.name = "type"
var_0_3.TYPE_FIELD.full_name = ".sgland.FeedbackReq.type"
var_0_3.TYPE_FIELD.number = 1
var_0_3.TYPE_FIELD.index = 0
var_0_3.TYPE_FIELD.label = 2
var_0_3.TYPE_FIELD.has_default_value = false
var_0_3.TYPE_FIELD.default_value = nil
var_0_3.TYPE_FIELD.enum_type = FEEDBACKTYPE
var_0_3.TYPE_FIELD.type = 14
var_0_3.TYPE_FIELD.cpp_type = 8
var_0_3.CONTENT_FIELD.name = "content"
var_0_3.CONTENT_FIELD.full_name = ".sgland.FeedbackReq.content"
var_0_3.CONTENT_FIELD.number = 2
var_0_3.CONTENT_FIELD.index = 1
var_0_3.CONTENT_FIELD.label = 2
var_0_3.CONTENT_FIELD.has_default_value = false
var_0_3.CONTENT_FIELD.default_value = ""
var_0_3.CONTENT_FIELD.type = 9
var_0_3.CONTENT_FIELD.cpp_type = 9
FEEDBACKREQ.name = "FeedbackReq"
FEEDBACKREQ.full_name = ".sgland.FeedbackReq"
FEEDBACKREQ.nested_types = {}
FEEDBACKREQ.enum_types = {}
FEEDBACKREQ.fields = {
	var_0_3.TYPE_FIELD,
	var_0_3.CONTENT_FIELD
}
FEEDBACKREQ.is_extendable = false
FEEDBACKREQ.extensions = {}
var_0_4.FEEDBACK_REQ_FIELD.name = "feedback_req"
var_0_4.FEEDBACK_REQ_FIELD.full_name = ".sgland.SglFeedbackMsg.feedback_req"
var_0_4.FEEDBACK_REQ_FIELD.number = 1300
var_0_4.FEEDBACK_REQ_FIELD.index = 0
var_0_4.FEEDBACK_REQ_FIELD.label = 1
var_0_4.FEEDBACK_REQ_FIELD.has_default_value = false
var_0_4.FEEDBACK_REQ_FIELD.default_value = nil
var_0_4.FEEDBACK_REQ_FIELD.message_type = FEEDBACKREQ
var_0_4.FEEDBACK_REQ_FIELD.type = 11
var_0_4.FEEDBACK_REQ_FIELD.cpp_type = 10
SGLFEEDBACKMSG.name = "SglFeedbackMsg"
SGLFEEDBACKMSG.full_name = ".sgland.SglFeedbackMsg"
SGLFEEDBACKMSG.nested_types = {}
SGLFEEDBACKMSG.enum_types = {}
SGLFEEDBACKMSG.fields = {}
SGLFEEDBACKMSG.is_extendable = false
SGLFEEDBACKMSG.extensions = {
	var_0_4.FEEDBACK_REQ_FIELD
}
FeedbackReq = var_0_0.Message(FEEDBACKREQ)
PB_FEEDBACK_BUG = 2
PB_FEEDBACK_COMPLAINT = 3
PB_FEEDBACK_CONSULT = 1
PB_FEEDBACK_SUGGESTION = 4
SglFeedbackMsg = var_0_0.Message(SGLFEEDBACKMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_4.FEEDBACK_REQ_FIELD)
