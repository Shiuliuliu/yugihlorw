local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Chat_pb")

CHATTYPE = var_0_0.EnumDescriptor()

local var_0_3 = {
	PB_CHAT_WORLD = var_0_0.EnumValueDescriptor(),
	PB_CHAT_UNION = var_0_0.EnumValueDescriptor(),
	PB_CHAT_PRIVATE = var_0_0.EnumValueDescriptor()
}

CHAT = var_0_0.Descriptor()

local var_0_4 = {
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	CONTENT_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	IS_IMPORTANT_FIELD = var_0_0.FieldDescriptor()
}

CHATSENDREQ = var_0_0.Descriptor()

local var_0_5 = {
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	ID_FIELD = var_0_0.FieldDescriptor(),
	CONTENT_FIELD = var_0_0.FieldDescriptor()
}

SGLCHATMSG = var_0_0.Descriptor()

local var_0_6 = {
	CHAT_SEND_REQ_FIELD = var_0_0.FieldDescriptor(),
	CHAT_RECEIVE_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.PB_CHAT_WORLD.name = "PB_CHAT_WORLD"
var_0_3.PB_CHAT_WORLD.index = 0
var_0_3.PB_CHAT_WORLD.number = 1
var_0_3.PB_CHAT_UNION.name = "PB_CHAT_UNION"
var_0_3.PB_CHAT_UNION.index = 1
var_0_3.PB_CHAT_UNION.number = 2
var_0_3.PB_CHAT_PRIVATE.name = "PB_CHAT_PRIVATE"
var_0_3.PB_CHAT_PRIVATE.index = 2
var_0_3.PB_CHAT_PRIVATE.number = 3
CHATTYPE.name = "ChatType"
CHATTYPE.full_name = ".sgland.ChatType"
CHATTYPE.values = {
	var_0_3.PB_CHAT_WORLD,
	var_0_3.PB_CHAT_UNION,
	var_0_3.PB_CHAT_PRIVATE
}
var_0_4.TYPE_FIELD.name = "type"
var_0_4.TYPE_FIELD.full_name = ".sgland.Chat.type"
var_0_4.TYPE_FIELD.number = 1
var_0_4.TYPE_FIELD.index = 0
var_0_4.TYPE_FIELD.label = 2
var_0_4.TYPE_FIELD.has_default_value = false
var_0_4.TYPE_FIELD.default_value = nil
var_0_4.TYPE_FIELD.enum_type = CHATTYPE
var_0_4.TYPE_FIELD.type = 14
var_0_4.TYPE_FIELD.cpp_type = 8
var_0_4.USER_INFO_FIELD.name = "user_info"
var_0_4.USER_INFO_FIELD.full_name = ".sgland.Chat.user_info"
var_0_4.USER_INFO_FIELD.number = 2
var_0_4.USER_INFO_FIELD.index = 1
var_0_4.USER_INFO_FIELD.label = 1
var_0_4.USER_INFO_FIELD.has_default_value = false
var_0_4.USER_INFO_FIELD.default_value = nil
var_0_4.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_4.USER_INFO_FIELD.type = 11
var_0_4.USER_INFO_FIELD.cpp_type = 10
var_0_4.CONTENT_FIELD.name = "content"
var_0_4.CONTENT_FIELD.full_name = ".sgland.Chat.content"
var_0_4.CONTENT_FIELD.number = 3
var_0_4.CONTENT_FIELD.index = 2
var_0_4.CONTENT_FIELD.label = 2
var_0_4.CONTENT_FIELD.has_default_value = false
var_0_4.CONTENT_FIELD.default_value = ""
var_0_4.CONTENT_FIELD.type = 9
var_0_4.CONTENT_FIELD.cpp_type = 9
var_0_4.TIMESTAMP_FIELD.name = "timestamp"
var_0_4.TIMESTAMP_FIELD.full_name = ".sgland.Chat.timestamp"
var_0_4.TIMESTAMP_FIELD.number = 4
var_0_4.TIMESTAMP_FIELD.index = 3
var_0_4.TIMESTAMP_FIELD.label = 2
var_0_4.TIMESTAMP_FIELD.has_default_value = false
var_0_4.TIMESTAMP_FIELD.default_value = 0
var_0_4.TIMESTAMP_FIELD.type = 3
var_0_4.TIMESTAMP_FIELD.cpp_type = 2
var_0_4.IS_IMPORTANT_FIELD.name = "is_important"
var_0_4.IS_IMPORTANT_FIELD.full_name = ".sgland.Chat.is_important"
var_0_4.IS_IMPORTANT_FIELD.number = 5
var_0_4.IS_IMPORTANT_FIELD.index = 4
var_0_4.IS_IMPORTANT_FIELD.label = 1
var_0_4.IS_IMPORTANT_FIELD.has_default_value = false
var_0_4.IS_IMPORTANT_FIELD.default_value = false
var_0_4.IS_IMPORTANT_FIELD.type = 8
var_0_4.IS_IMPORTANT_FIELD.cpp_type = 7
CHAT.name = "Chat"
CHAT.full_name = ".sgland.Chat"
CHAT.nested_types = {}
CHAT.enum_types = {}
CHAT.fields = {
	var_0_4.TYPE_FIELD,
	var_0_4.USER_INFO_FIELD,
	var_0_4.CONTENT_FIELD,
	var_0_4.TIMESTAMP_FIELD,
	var_0_4.IS_IMPORTANT_FIELD
}
CHAT.is_extendable = false
CHAT.extensions = {}
var_0_5.TYPE_FIELD.name = "type"
var_0_5.TYPE_FIELD.full_name = ".sgland.ChatSendReq.type"
var_0_5.TYPE_FIELD.number = 1
var_0_5.TYPE_FIELD.index = 0
var_0_5.TYPE_FIELD.label = 2
var_0_5.TYPE_FIELD.has_default_value = false
var_0_5.TYPE_FIELD.default_value = nil
var_0_5.TYPE_FIELD.enum_type = CHATTYPE
var_0_5.TYPE_FIELD.type = 14
var_0_5.TYPE_FIELD.cpp_type = 8
var_0_5.ID_FIELD.name = "id"
var_0_5.ID_FIELD.full_name = ".sgland.ChatSendReq.id"
var_0_5.ID_FIELD.number = 2
var_0_5.ID_FIELD.index = 1
var_0_5.ID_FIELD.label = 1
var_0_5.ID_FIELD.has_default_value = false
var_0_5.ID_FIELD.default_value = 0
var_0_5.ID_FIELD.type = 3
var_0_5.ID_FIELD.cpp_type = 2
var_0_5.CONTENT_FIELD.name = "content"
var_0_5.CONTENT_FIELD.full_name = ".sgland.ChatSendReq.content"
var_0_5.CONTENT_FIELD.number = 3
var_0_5.CONTENT_FIELD.index = 2
var_0_5.CONTENT_FIELD.label = 2
var_0_5.CONTENT_FIELD.has_default_value = false
var_0_5.CONTENT_FIELD.default_value = ""
var_0_5.CONTENT_FIELD.type = 9
var_0_5.CONTENT_FIELD.cpp_type = 9
CHATSENDREQ.name = "ChatSendReq"
CHATSENDREQ.full_name = ".sgland.ChatSendReq"
CHATSENDREQ.nested_types = {}
CHATSENDREQ.enum_types = {}
CHATSENDREQ.fields = {
	var_0_5.TYPE_FIELD,
	var_0_5.ID_FIELD,
	var_0_5.CONTENT_FIELD
}
CHATSENDREQ.is_extendable = false
CHATSENDREQ.extensions = {}
var_0_6.CHAT_SEND_REQ_FIELD.name = "chat_send_req"
var_0_6.CHAT_SEND_REQ_FIELD.full_name = ".sgland.SglChatMsg.chat_send_req"
var_0_6.CHAT_SEND_REQ_FIELD.number = 1100
var_0_6.CHAT_SEND_REQ_FIELD.index = 0
var_0_6.CHAT_SEND_REQ_FIELD.label = 1
var_0_6.CHAT_SEND_REQ_FIELD.has_default_value = false
var_0_6.CHAT_SEND_REQ_FIELD.default_value = nil
var_0_6.CHAT_SEND_REQ_FIELD.message_type = CHATSENDREQ
var_0_6.CHAT_SEND_REQ_FIELD.type = 11
var_0_6.CHAT_SEND_REQ_FIELD.cpp_type = 10
var_0_6.CHAT_RECEIVE_RESP_FIELD.name = "chat_receive_resp"
var_0_6.CHAT_RECEIVE_RESP_FIELD.full_name = ".sgland.SglChatMsg.chat_receive_resp"
var_0_6.CHAT_RECEIVE_RESP_FIELD.number = 1100
var_0_6.CHAT_RECEIVE_RESP_FIELD.index = 1
var_0_6.CHAT_RECEIVE_RESP_FIELD.label = 3
var_0_6.CHAT_RECEIVE_RESP_FIELD.has_default_value = false
var_0_6.CHAT_RECEIVE_RESP_FIELD.default_value = {}
var_0_6.CHAT_RECEIVE_RESP_FIELD.message_type = CHAT
var_0_6.CHAT_RECEIVE_RESP_FIELD.type = 11
var_0_6.CHAT_RECEIVE_RESP_FIELD.cpp_type = 10
SGLCHATMSG.name = "SglChatMsg"
SGLCHATMSG.full_name = ".sgland.SglChatMsg"
SGLCHATMSG.nested_types = {}
SGLCHATMSG.enum_types = {}
SGLCHATMSG.fields = {}
SGLCHATMSG.is_extendable = false
SGLCHATMSG.extensions = {
	var_0_6.CHAT_SEND_REQ_FIELD,
	var_0_6.CHAT_RECEIVE_RESP_FIELD
}
Chat = var_0_0.Message(CHAT)
ChatSendReq = var_0_0.Message(CHATSENDREQ)
PB_CHAT_PRIVATE = 3
PB_CHAT_UNION = 2
PB_CHAT_WORLD = 1
SglChatMsg = var_0_0.Message(SGLCHATMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_6.CHAT_SEND_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_6.CHAT_RECEIVE_RESP_FIELD)
