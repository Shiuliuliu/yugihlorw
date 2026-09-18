local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Mail_pb")

MAILTYPE = var_0_0.EnumDescriptor()

local var_0_3 = {
	PB_MAIL_SYSTEM = var_0_0.EnumValueDescriptor(),
	PB_MAIL_FRIEND = var_0_0.EnumValueDescriptor(),
	PB_MAIL_UNION = var_0_0.EnumValueDescriptor(),
	PB_MAIL_NOTIFY = var_0_0.EnumValueDescriptor()
}

MAILSENDREQ = var_0_0.Descriptor()

local var_0_4 = {
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	ID_FIELD = var_0_0.FieldDescriptor(),
	CONTENT_FIELD = var_0_0.FieldDescriptor(),
	STATUS_FIELD = var_0_0.FieldDescriptor()
}

MAILRECEIVERESP = var_0_0.Descriptor()

local var_0_5 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	CONTENT_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	INVITE_STATUS_FIELD = var_0_0.FieldDescriptor(),
	APPLY_STATUS_FIELD = var_0_0.FieldDescriptor(),
	SOS_STATUS_FIELD = var_0_0.FieldDescriptor(),
	UNION_INFO_FIELD = var_0_0.FieldDescriptor(),
	PARAM_FIELD = var_0_0.FieldDescriptor()
}

SGLMAILMSG = var_0_0.Descriptor()

local var_0_6 = {
	MAIL_SEND_REQ_FIELD = var_0_0.FieldDescriptor(),
	MAIL_LIST_RESP_FIELD = var_0_0.FieldDescriptor(),
	MAIL_RECEIVE_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.PB_MAIL_SYSTEM.name = "PB_MAIL_SYSTEM"
var_0_3.PB_MAIL_SYSTEM.index = 0
var_0_3.PB_MAIL_SYSTEM.number = 1
var_0_3.PB_MAIL_FRIEND.name = "PB_MAIL_FRIEND"
var_0_3.PB_MAIL_FRIEND.index = 1
var_0_3.PB_MAIL_FRIEND.number = 2
var_0_3.PB_MAIL_UNION.name = "PB_MAIL_UNION"
var_0_3.PB_MAIL_UNION.index = 2
var_0_3.PB_MAIL_UNION.number = 3
var_0_3.PB_MAIL_NOTIFY.name = "PB_MAIL_NOTIFY"
var_0_3.PB_MAIL_NOTIFY.index = 3
var_0_3.PB_MAIL_NOTIFY.number = 4
MAILTYPE.name = "MailType"
MAILTYPE.full_name = ".sgland.MailType"
MAILTYPE.values = {
	var_0_3.PB_MAIL_SYSTEM,
	var_0_3.PB_MAIL_FRIEND,
	var_0_3.PB_MAIL_UNION,
	var_0_3.PB_MAIL_NOTIFY
}
var_0_4.TYPE_FIELD.name = "type"
var_0_4.TYPE_FIELD.full_name = ".sgland.MailSendReq.type"
var_0_4.TYPE_FIELD.number = 1
var_0_4.TYPE_FIELD.index = 0
var_0_4.TYPE_FIELD.label = 2
var_0_4.TYPE_FIELD.has_default_value = false
var_0_4.TYPE_FIELD.default_value = nil
var_0_4.TYPE_FIELD.enum_type = MAILTYPE
var_0_4.TYPE_FIELD.type = 14
var_0_4.TYPE_FIELD.cpp_type = 8
var_0_4.ID_FIELD.name = "id"
var_0_4.ID_FIELD.full_name = ".sgland.MailSendReq.id"
var_0_4.ID_FIELD.number = 2
var_0_4.ID_FIELD.index = 1
var_0_4.ID_FIELD.label = 1
var_0_4.ID_FIELD.has_default_value = false
var_0_4.ID_FIELD.default_value = 0
var_0_4.ID_FIELD.type = 3
var_0_4.ID_FIELD.cpp_type = 2
var_0_4.CONTENT_FIELD.name = "content"
var_0_4.CONTENT_FIELD.full_name = ".sgland.MailSendReq.content"
var_0_4.CONTENT_FIELD.number = 3
var_0_4.CONTENT_FIELD.index = 2
var_0_4.CONTENT_FIELD.label = 2
var_0_4.CONTENT_FIELD.has_default_value = false
var_0_4.CONTENT_FIELD.default_value = ""
var_0_4.CONTENT_FIELD.type = 9
var_0_4.CONTENT_FIELD.cpp_type = 9
var_0_4.STATUS_FIELD.name = "status"
var_0_4.STATUS_FIELD.full_name = ".sgland.MailSendReq.status"
var_0_4.STATUS_FIELD.number = 4
var_0_4.STATUS_FIELD.index = 3
var_0_4.STATUS_FIELD.label = 1
var_0_4.STATUS_FIELD.has_default_value = false
var_0_4.STATUS_FIELD.default_value = nil
var_0_4.STATUS_FIELD.enum_type = var_0_1.INVITESTATUS
var_0_4.STATUS_FIELD.type = 14
var_0_4.STATUS_FIELD.cpp_type = 8
MAILSENDREQ.name = "MailSendReq"
MAILSENDREQ.full_name = ".sgland.MailSendReq"
MAILSENDREQ.nested_types = {}
MAILSENDREQ.enum_types = {}
MAILSENDREQ.fields = {
	var_0_4.TYPE_FIELD,
	var_0_4.ID_FIELD,
	var_0_4.CONTENT_FIELD,
	var_0_4.STATUS_FIELD
}
MAILSENDREQ.is_extendable = false
MAILSENDREQ.extensions = {}
var_0_5.ID_FIELD.name = "id"
var_0_5.ID_FIELD.full_name = ".sgland.MailReceiveResp.id"
var_0_5.ID_FIELD.number = 1
var_0_5.ID_FIELD.index = 0
var_0_5.ID_FIELD.label = 2
var_0_5.ID_FIELD.has_default_value = false
var_0_5.ID_FIELD.default_value = 0
var_0_5.ID_FIELD.type = 3
var_0_5.ID_FIELD.cpp_type = 2
var_0_5.CONTENT_FIELD.name = "content"
var_0_5.CONTENT_FIELD.full_name = ".sgland.MailReceiveResp.content"
var_0_5.CONTENT_FIELD.number = 2
var_0_5.CONTENT_FIELD.index = 1
var_0_5.CONTENT_FIELD.label = 2
var_0_5.CONTENT_FIELD.has_default_value = false
var_0_5.CONTENT_FIELD.default_value = ""
var_0_5.CONTENT_FIELD.type = 9
var_0_5.CONTENT_FIELD.cpp_type = 9
var_0_5.TYPE_FIELD.name = "type"
var_0_5.TYPE_FIELD.full_name = ".sgland.MailReceiveResp.type"
var_0_5.TYPE_FIELD.number = 3
var_0_5.TYPE_FIELD.index = 2
var_0_5.TYPE_FIELD.label = 2
var_0_5.TYPE_FIELD.has_default_value = false
var_0_5.TYPE_FIELD.default_value = nil
var_0_5.TYPE_FIELD.enum_type = MAILTYPE
var_0_5.TYPE_FIELD.type = 14
var_0_5.TYPE_FIELD.cpp_type = 8
var_0_5.TIMESTAMP_FIELD.name = "timestamp"
var_0_5.TIMESTAMP_FIELD.full_name = ".sgland.MailReceiveResp.timestamp"
var_0_5.TIMESTAMP_FIELD.number = 4
var_0_5.TIMESTAMP_FIELD.index = 3
var_0_5.TIMESTAMP_FIELD.label = 2
var_0_5.TIMESTAMP_FIELD.has_default_value = false
var_0_5.TIMESTAMP_FIELD.default_value = 0
var_0_5.TIMESTAMP_FIELD.type = 3
var_0_5.TIMESTAMP_FIELD.cpp_type = 2
var_0_5.USER_INFO_FIELD.name = "user_info"
var_0_5.USER_INFO_FIELD.full_name = ".sgland.MailReceiveResp.user_info"
var_0_5.USER_INFO_FIELD.number = 5
var_0_5.USER_INFO_FIELD.index = 4
var_0_5.USER_INFO_FIELD.label = 1
var_0_5.USER_INFO_FIELD.has_default_value = false
var_0_5.USER_INFO_FIELD.default_value = nil
var_0_5.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_5.USER_INFO_FIELD.type = 11
var_0_5.USER_INFO_FIELD.cpp_type = 10
var_0_5.INVITE_STATUS_FIELD.name = "invite_status"
var_0_5.INVITE_STATUS_FIELD.full_name = ".sgland.MailReceiveResp.invite_status"
var_0_5.INVITE_STATUS_FIELD.number = 6
var_0_5.INVITE_STATUS_FIELD.index = 5
var_0_5.INVITE_STATUS_FIELD.label = 1
var_0_5.INVITE_STATUS_FIELD.has_default_value = false
var_0_5.INVITE_STATUS_FIELD.default_value = nil
var_0_5.INVITE_STATUS_FIELD.enum_type = var_0_1.INVITESTATUS
var_0_5.INVITE_STATUS_FIELD.type = 14
var_0_5.INVITE_STATUS_FIELD.cpp_type = 8
var_0_5.APPLY_STATUS_FIELD.name = "apply_status"
var_0_5.APPLY_STATUS_FIELD.full_name = ".sgland.MailReceiveResp.apply_status"
var_0_5.APPLY_STATUS_FIELD.number = 7
var_0_5.APPLY_STATUS_FIELD.index = 6
var_0_5.APPLY_STATUS_FIELD.label = 1
var_0_5.APPLY_STATUS_FIELD.has_default_value = false
var_0_5.APPLY_STATUS_FIELD.default_value = nil
var_0_5.APPLY_STATUS_FIELD.enum_type = var_0_1.APPLYSTATUS
var_0_5.APPLY_STATUS_FIELD.type = 14
var_0_5.APPLY_STATUS_FIELD.cpp_type = 8
var_0_5.SOS_STATUS_FIELD.name = "sos_status"
var_0_5.SOS_STATUS_FIELD.full_name = ".sgland.MailReceiveResp.sos_status"
var_0_5.SOS_STATUS_FIELD.number = 8
var_0_5.SOS_STATUS_FIELD.index = 7
var_0_5.SOS_STATUS_FIELD.label = 1
var_0_5.SOS_STATUS_FIELD.has_default_value = false
var_0_5.SOS_STATUS_FIELD.default_value = nil
var_0_5.SOS_STATUS_FIELD.enum_type = var_0_1.SOSSTATUS
var_0_5.SOS_STATUS_FIELD.type = 14
var_0_5.SOS_STATUS_FIELD.cpp_type = 8
var_0_5.UNION_INFO_FIELD.name = "union_info"
var_0_5.UNION_INFO_FIELD.full_name = ".sgland.MailReceiveResp.union_info"
var_0_5.UNION_INFO_FIELD.number = 9
var_0_5.UNION_INFO_FIELD.index = 8
var_0_5.UNION_INFO_FIELD.label = 1
var_0_5.UNION_INFO_FIELD.has_default_value = false
var_0_5.UNION_INFO_FIELD.default_value = nil
var_0_5.UNION_INFO_FIELD.message_type = var_0_2.UNIONINFO
var_0_5.UNION_INFO_FIELD.type = 11
var_0_5.UNION_INFO_FIELD.cpp_type = 10
var_0_5.PARAM_FIELD.name = "param"
var_0_5.PARAM_FIELD.full_name = ".sgland.MailReceiveResp.param"
var_0_5.PARAM_FIELD.number = 10
var_0_5.PARAM_FIELD.index = 9
var_0_5.PARAM_FIELD.label = 1
var_0_5.PARAM_FIELD.has_default_value = false
var_0_5.PARAM_FIELD.default_value = ""
var_0_5.PARAM_FIELD.type = 9
var_0_5.PARAM_FIELD.cpp_type = 9
MAILRECEIVERESP.name = "MailReceiveResp"
MAILRECEIVERESP.full_name = ".sgland.MailReceiveResp"
MAILRECEIVERESP.nested_types = {}
MAILRECEIVERESP.enum_types = {}
MAILRECEIVERESP.fields = {
	var_0_5.ID_FIELD,
	var_0_5.CONTENT_FIELD,
	var_0_5.TYPE_FIELD,
	var_0_5.TIMESTAMP_FIELD,
	var_0_5.USER_INFO_FIELD,
	var_0_5.INVITE_STATUS_FIELD,
	var_0_5.APPLY_STATUS_FIELD,
	var_0_5.SOS_STATUS_FIELD,
	var_0_5.UNION_INFO_FIELD,
	var_0_5.PARAM_FIELD
}
MAILRECEIVERESP.is_extendable = false
MAILRECEIVERESP.extensions = {}
var_0_6.MAIL_SEND_REQ_FIELD.name = "mail_send_req"
var_0_6.MAIL_SEND_REQ_FIELD.full_name = ".sgland.SglMailMsg.mail_send_req"
var_0_6.MAIL_SEND_REQ_FIELD.number = 1000
var_0_6.MAIL_SEND_REQ_FIELD.index = 0
var_0_6.MAIL_SEND_REQ_FIELD.label = 1
var_0_6.MAIL_SEND_REQ_FIELD.has_default_value = false
var_0_6.MAIL_SEND_REQ_FIELD.default_value = nil
var_0_6.MAIL_SEND_REQ_FIELD.message_type = MAILSENDREQ
var_0_6.MAIL_SEND_REQ_FIELD.type = 11
var_0_6.MAIL_SEND_REQ_FIELD.cpp_type = 10
var_0_6.MAIL_LIST_RESP_FIELD.name = "mail_list_resp"
var_0_6.MAIL_LIST_RESP_FIELD.full_name = ".sgland.SglMailMsg.mail_list_resp"
var_0_6.MAIL_LIST_RESP_FIELD.number = 1000
var_0_6.MAIL_LIST_RESP_FIELD.index = 1
var_0_6.MAIL_LIST_RESP_FIELD.label = 3
var_0_6.MAIL_LIST_RESP_FIELD.has_default_value = false
var_0_6.MAIL_LIST_RESP_FIELD.default_value = {}
var_0_6.MAIL_LIST_RESP_FIELD.message_type = MAILRECEIVERESP
var_0_6.MAIL_LIST_RESP_FIELD.type = 11
var_0_6.MAIL_LIST_RESP_FIELD.cpp_type = 10
var_0_6.MAIL_RECEIVE_RESP_FIELD.name = "mail_receive_resp"
var_0_6.MAIL_RECEIVE_RESP_FIELD.full_name = ".sgland.SglMailMsg.mail_receive_resp"
var_0_6.MAIL_RECEIVE_RESP_FIELD.number = 1001
var_0_6.MAIL_RECEIVE_RESP_FIELD.index = 2
var_0_6.MAIL_RECEIVE_RESP_FIELD.label = 1
var_0_6.MAIL_RECEIVE_RESP_FIELD.has_default_value = false
var_0_6.MAIL_RECEIVE_RESP_FIELD.default_value = nil
var_0_6.MAIL_RECEIVE_RESP_FIELD.message_type = MAILRECEIVERESP
var_0_6.MAIL_RECEIVE_RESP_FIELD.type = 11
var_0_6.MAIL_RECEIVE_RESP_FIELD.cpp_type = 10
SGLMAILMSG.name = "SglMailMsg"
SGLMAILMSG.full_name = ".sgland.SglMailMsg"
SGLMAILMSG.nested_types = {}
SGLMAILMSG.enum_types = {}
SGLMAILMSG.fields = {}
SGLMAILMSG.is_extendable = false
SGLMAILMSG.extensions = {
	var_0_6.MAIL_SEND_REQ_FIELD,
	var_0_6.MAIL_LIST_RESP_FIELD,
	var_0_6.MAIL_RECEIVE_RESP_FIELD
}
MailReceiveResp = var_0_0.Message(MAILRECEIVERESP)
MailSendReq = var_0_0.Message(MAILSENDREQ)
PB_MAIL_FRIEND = 2
PB_MAIL_NOTIFY = 4
PB_MAIL_SYSTEM = 1
PB_MAIL_UNION = 3
SglMailMsg = var_0_0.Message(SGLMAILMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_6.MAIL_SEND_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.MAIL_LIST_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.MAIL_RECEIVE_RESP_FIELD)
