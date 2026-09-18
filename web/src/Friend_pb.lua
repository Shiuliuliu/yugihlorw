local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Friend_pb")

FRIENDBATTLERESULT = var_0_0.Descriptor()

local var_0_3 = {
	RESULT_TYPE_FIELD = var_0_0.FieldDescriptor(),
	REPLAY_ID_FIELD = var_0_0.FieldDescriptor()
}

FRIENDBATTLE = var_0_0.Descriptor()

local var_0_4 = {
	BATTLE_ID_FIELD = var_0_0.FieldDescriptor(),
	UNION_ID_FIELD = var_0_0.FieldDescriptor(),
	USER1_FIELD = var_0_0.FieldDescriptor(),
	USER2_FIELD = var_0_0.FieldDescriptor(),
	IS_VALID_FIELD = var_0_0.FieldDescriptor(),
	RESULT_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

FRIENDINVITEREQ = var_0_0.Descriptor()

local var_0_5 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	MESSAGE_FIELD = var_0_0.FieldDescriptor()
}

FRIENDACCEPTREQ = var_0_0.Descriptor()

local var_0_6 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	IS_ACCEPT_FIELD = var_0_0.FieldDescriptor()
}

FRIENDBATTLEJOINREQ = var_0_0.Descriptor()

local var_0_7 = {
	BATTLE_ID_FIELD = var_0_0.FieldDescriptor(),
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	TROOP_ID_FIELD = var_0_0.FieldDescriptor()
}

FRIENDBATTLESTARTRESP = var_0_0.Descriptor()

local var_0_8 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

FRIENDBATTLEENDRESP = var_0_0.Descriptor()

local var_0_9 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	RESULT_TYPE_FIELD = var_0_0.FieldDescriptor()
}

SGLFRIENDMSG = var_0_0.Descriptor()

local var_0_10 = {
	FRIEND_SEARCH_REQ_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_INVITE_REQ_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_ACCEPT_REQ_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_REMOVE_REQ_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_BATTLE_REQ_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_BATTLE_JOIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_SEARCH_RESP_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_RECOMMEND_RESP_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_INVITE_RESP_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_LIST_RESP_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_EXCEED_RESP_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_ACCEPTED_RESP_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_REMOVED_RESP_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_BATTLE_RESP_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_BATTLE_START_RESP_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_BATTLE_END_RESP_FIELD = var_0_0.FieldDescriptor(),
	FRIEND_BATTLE_UPDATE_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.RESULT_TYPE_FIELD.name = "result_type"
var_0_3.RESULT_TYPE_FIELD.full_name = ".sgland.FriendBattleResult.result_type"
var_0_3.RESULT_TYPE_FIELD.number = 1
var_0_3.RESULT_TYPE_FIELD.index = 0
var_0_3.RESULT_TYPE_FIELD.label = 2
var_0_3.RESULT_TYPE_FIELD.has_default_value = false
var_0_3.RESULT_TYPE_FIELD.default_value = 0
var_0_3.RESULT_TYPE_FIELD.type = 5
var_0_3.RESULT_TYPE_FIELD.cpp_type = 1
var_0_3.REPLAY_ID_FIELD.name = "replay_id"
var_0_3.REPLAY_ID_FIELD.full_name = ".sgland.FriendBattleResult.replay_id"
var_0_3.REPLAY_ID_FIELD.number = 2
var_0_3.REPLAY_ID_FIELD.index = 1
var_0_3.REPLAY_ID_FIELD.label = 2
var_0_3.REPLAY_ID_FIELD.has_default_value = false
var_0_3.REPLAY_ID_FIELD.default_value = 0
var_0_3.REPLAY_ID_FIELD.type = 3
var_0_3.REPLAY_ID_FIELD.cpp_type = 2
FRIENDBATTLERESULT.name = "FriendBattleResult"
FRIENDBATTLERESULT.full_name = ".sgland.FriendBattleResult"
FRIENDBATTLERESULT.nested_types = {}
FRIENDBATTLERESULT.enum_types = {}
FRIENDBATTLERESULT.fields = {
	var_0_3.RESULT_TYPE_FIELD,
	var_0_3.REPLAY_ID_FIELD
}
FRIENDBATTLERESULT.is_extendable = false
FRIENDBATTLERESULT.extensions = {}
var_0_4.BATTLE_ID_FIELD.name = "battle_id"
var_0_4.BATTLE_ID_FIELD.full_name = ".sgland.FriendBattle.battle_id"
var_0_4.BATTLE_ID_FIELD.number = 1
var_0_4.BATTLE_ID_FIELD.index = 0
var_0_4.BATTLE_ID_FIELD.label = 2
var_0_4.BATTLE_ID_FIELD.has_default_value = false
var_0_4.BATTLE_ID_FIELD.default_value = 0
var_0_4.BATTLE_ID_FIELD.type = 3
var_0_4.BATTLE_ID_FIELD.cpp_type = 2
var_0_4.UNION_ID_FIELD.name = "union_id"
var_0_4.UNION_ID_FIELD.full_name = ".sgland.FriendBattle.union_id"
var_0_4.UNION_ID_FIELD.number = 2
var_0_4.UNION_ID_FIELD.index = 1
var_0_4.UNION_ID_FIELD.label = 2
var_0_4.UNION_ID_FIELD.has_default_value = false
var_0_4.UNION_ID_FIELD.default_value = 0
var_0_4.UNION_ID_FIELD.type = 3
var_0_4.UNION_ID_FIELD.cpp_type = 2
var_0_4.USER1_FIELD.name = "user1"
var_0_4.USER1_FIELD.full_name = ".sgland.FriendBattle.user1"
var_0_4.USER1_FIELD.number = 3
var_0_4.USER1_FIELD.index = 2
var_0_4.USER1_FIELD.label = 2
var_0_4.USER1_FIELD.has_default_value = false
var_0_4.USER1_FIELD.default_value = nil
var_0_4.USER1_FIELD.message_type = var_0_2.USERINFO
var_0_4.USER1_FIELD.type = 11
var_0_4.USER1_FIELD.cpp_type = 10
var_0_4.USER2_FIELD.name = "user2"
var_0_4.USER2_FIELD.full_name = ".sgland.FriendBattle.user2"
var_0_4.USER2_FIELD.number = 4
var_0_4.USER2_FIELD.index = 3
var_0_4.USER2_FIELD.label = 1
var_0_4.USER2_FIELD.has_default_value = false
var_0_4.USER2_FIELD.default_value = nil
var_0_4.USER2_FIELD.message_type = var_0_2.USERINFO
var_0_4.USER2_FIELD.type = 11
var_0_4.USER2_FIELD.cpp_type = 10
var_0_4.IS_VALID_FIELD.name = "is_valid"
var_0_4.IS_VALID_FIELD.full_name = ".sgland.FriendBattle.is_valid"
var_0_4.IS_VALID_FIELD.number = 5
var_0_4.IS_VALID_FIELD.index = 4
var_0_4.IS_VALID_FIELD.label = 2
var_0_4.IS_VALID_FIELD.has_default_value = false
var_0_4.IS_VALID_FIELD.default_value = false
var_0_4.IS_VALID_FIELD.type = 8
var_0_4.IS_VALID_FIELD.cpp_type = 7
var_0_4.RESULT_FIELD.name = "result"
var_0_4.RESULT_FIELD.full_name = ".sgland.FriendBattle.result"
var_0_4.RESULT_FIELD.number = 6
var_0_4.RESULT_FIELD.index = 5
var_0_4.RESULT_FIELD.label = 1
var_0_4.RESULT_FIELD.has_default_value = false
var_0_4.RESULT_FIELD.default_value = nil
var_0_4.RESULT_FIELD.message_type = FRIENDBATTLERESULT
var_0_4.RESULT_FIELD.type = 11
var_0_4.RESULT_FIELD.cpp_type = 10
var_0_4.TIMESTAMP_FIELD.name = "timestamp"
var_0_4.TIMESTAMP_FIELD.full_name = ".sgland.FriendBattle.timestamp"
var_0_4.TIMESTAMP_FIELD.number = 7
var_0_4.TIMESTAMP_FIELD.index = 6
var_0_4.TIMESTAMP_FIELD.label = 2
var_0_4.TIMESTAMP_FIELD.has_default_value = false
var_0_4.TIMESTAMP_FIELD.default_value = 0
var_0_4.TIMESTAMP_FIELD.type = 3
var_0_4.TIMESTAMP_FIELD.cpp_type = 2
FRIENDBATTLE.name = "FriendBattle"
FRIENDBATTLE.full_name = ".sgland.FriendBattle"
FRIENDBATTLE.nested_types = {}
FRIENDBATTLE.enum_types = {}
FRIENDBATTLE.fields = {
	var_0_4.BATTLE_ID_FIELD,
	var_0_4.UNION_ID_FIELD,
	var_0_4.USER1_FIELD,
	var_0_4.USER2_FIELD,
	var_0_4.IS_VALID_FIELD,
	var_0_4.RESULT_FIELD,
	var_0_4.TIMESTAMP_FIELD
}
FRIENDBATTLE.is_extendable = false
FRIENDBATTLE.extensions = {}
var_0_5.ID_FIELD.name = "id"
var_0_5.ID_FIELD.full_name = ".sgland.FriendInviteReq.id"
var_0_5.ID_FIELD.number = 1
var_0_5.ID_FIELD.index = 0
var_0_5.ID_FIELD.label = 2
var_0_5.ID_FIELD.has_default_value = false
var_0_5.ID_FIELD.default_value = 0
var_0_5.ID_FIELD.type = 3
var_0_5.ID_FIELD.cpp_type = 2
var_0_5.MESSAGE_FIELD.name = "message"
var_0_5.MESSAGE_FIELD.full_name = ".sgland.FriendInviteReq.message"
var_0_5.MESSAGE_FIELD.number = 2
var_0_5.MESSAGE_FIELD.index = 1
var_0_5.MESSAGE_FIELD.label = 1
var_0_5.MESSAGE_FIELD.has_default_value = false
var_0_5.MESSAGE_FIELD.default_value = ""
var_0_5.MESSAGE_FIELD.type = 9
var_0_5.MESSAGE_FIELD.cpp_type = 9
FRIENDINVITEREQ.name = "FriendInviteReq"
FRIENDINVITEREQ.full_name = ".sgland.FriendInviteReq"
FRIENDINVITEREQ.nested_types = {}
FRIENDINVITEREQ.enum_types = {}
FRIENDINVITEREQ.fields = {
	var_0_5.ID_FIELD,
	var_0_5.MESSAGE_FIELD
}
FRIENDINVITEREQ.is_extendable = false
FRIENDINVITEREQ.extensions = {}
var_0_6.ID_FIELD.name = "id"
var_0_6.ID_FIELD.full_name = ".sgland.FriendAcceptReq.id"
var_0_6.ID_FIELD.number = 1
var_0_6.ID_FIELD.index = 0
var_0_6.ID_FIELD.label = 2
var_0_6.ID_FIELD.has_default_value = false
var_0_6.ID_FIELD.default_value = 0
var_0_6.ID_FIELD.type = 3
var_0_6.ID_FIELD.cpp_type = 2
var_0_6.IS_ACCEPT_FIELD.name = "is_accept"
var_0_6.IS_ACCEPT_FIELD.full_name = ".sgland.FriendAcceptReq.is_accept"
var_0_6.IS_ACCEPT_FIELD.number = 2
var_0_6.IS_ACCEPT_FIELD.index = 1
var_0_6.IS_ACCEPT_FIELD.label = 2
var_0_6.IS_ACCEPT_FIELD.has_default_value = false
var_0_6.IS_ACCEPT_FIELD.default_value = false
var_0_6.IS_ACCEPT_FIELD.type = 8
var_0_6.IS_ACCEPT_FIELD.cpp_type = 7
FRIENDACCEPTREQ.name = "FriendAcceptReq"
FRIENDACCEPTREQ.full_name = ".sgland.FriendAcceptReq"
FRIENDACCEPTREQ.nested_types = {}
FRIENDACCEPTREQ.enum_types = {}
FRIENDACCEPTREQ.fields = {
	var_0_6.ID_FIELD,
	var_0_6.IS_ACCEPT_FIELD
}
FRIENDACCEPTREQ.is_extendable = false
FRIENDACCEPTREQ.extensions = {}
var_0_7.BATTLE_ID_FIELD.name = "battle_id"
var_0_7.BATTLE_ID_FIELD.full_name = ".sgland.FriendBattleJoinReq.battle_id"
var_0_7.BATTLE_ID_FIELD.number = 1
var_0_7.BATTLE_ID_FIELD.index = 0
var_0_7.BATTLE_ID_FIELD.label = 2
var_0_7.BATTLE_ID_FIELD.has_default_value = false
var_0_7.BATTLE_ID_FIELD.default_value = 0
var_0_7.BATTLE_ID_FIELD.type = 3
var_0_7.BATTLE_ID_FIELD.cpp_type = 2
var_0_7.USER_ID_FIELD.name = "user_id"
var_0_7.USER_ID_FIELD.full_name = ".sgland.FriendBattleJoinReq.user_id"
var_0_7.USER_ID_FIELD.number = 2
var_0_7.USER_ID_FIELD.index = 1
var_0_7.USER_ID_FIELD.label = 2
var_0_7.USER_ID_FIELD.has_default_value = false
var_0_7.USER_ID_FIELD.default_value = 0
var_0_7.USER_ID_FIELD.type = 3
var_0_7.USER_ID_FIELD.cpp_type = 2
var_0_7.TROOP_ID_FIELD.name = "troop_id"
var_0_7.TROOP_ID_FIELD.full_name = ".sgland.FriendBattleJoinReq.troop_id"
var_0_7.TROOP_ID_FIELD.number = 3
var_0_7.TROOP_ID_FIELD.index = 2
var_0_7.TROOP_ID_FIELD.label = 2
var_0_7.TROOP_ID_FIELD.has_default_value = false
var_0_7.TROOP_ID_FIELD.default_value = 0
var_0_7.TROOP_ID_FIELD.type = 5
var_0_7.TROOP_ID_FIELD.cpp_type = 1
FRIENDBATTLEJOINREQ.name = "FriendBattleJoinReq"
FRIENDBATTLEJOINREQ.full_name = ".sgland.FriendBattleJoinReq"
FRIENDBATTLEJOINREQ.nested_types = {}
FRIENDBATTLEJOINREQ.enum_types = {}
FRIENDBATTLEJOINREQ.fields = {
	var_0_7.BATTLE_ID_FIELD,
	var_0_7.USER_ID_FIELD,
	var_0_7.TROOP_ID_FIELD
}
FRIENDBATTLEJOINREQ.is_extendable = false
FRIENDBATTLEJOINREQ.extensions = {}
var_0_8.ID_FIELD.name = "id"
var_0_8.ID_FIELD.full_name = ".sgland.FriendBattleStartResp.id"
var_0_8.ID_FIELD.number = 1
var_0_8.ID_FIELD.index = 0
var_0_8.ID_FIELD.label = 2
var_0_8.ID_FIELD.has_default_value = false
var_0_8.ID_FIELD.default_value = 0
var_0_8.ID_FIELD.type = 3
var_0_8.ID_FIELD.cpp_type = 2
var_0_8.USER_INFO_FIELD.name = "user_info"
var_0_8.USER_INFO_FIELD.full_name = ".sgland.FriendBattleStartResp.user_info"
var_0_8.USER_INFO_FIELD.number = 2
var_0_8.USER_INFO_FIELD.index = 1
var_0_8.USER_INFO_FIELD.label = 2
var_0_8.USER_INFO_FIELD.has_default_value = false
var_0_8.USER_INFO_FIELD.default_value = nil
var_0_8.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_8.USER_INFO_FIELD.type = 11
var_0_8.USER_INFO_FIELD.cpp_type = 10
var_0_8.TIMESTAMP_FIELD.name = "timestamp"
var_0_8.TIMESTAMP_FIELD.full_name = ".sgland.FriendBattleStartResp.timestamp"
var_0_8.TIMESTAMP_FIELD.number = 3
var_0_8.TIMESTAMP_FIELD.index = 2
var_0_8.TIMESTAMP_FIELD.label = 2
var_0_8.TIMESTAMP_FIELD.has_default_value = false
var_0_8.TIMESTAMP_FIELD.default_value = 0
var_0_8.TIMESTAMP_FIELD.type = 3
var_0_8.TIMESTAMP_FIELD.cpp_type = 2
FRIENDBATTLESTARTRESP.name = "FriendBattleStartResp"
FRIENDBATTLESTARTRESP.full_name = ".sgland.FriendBattleStartResp"
FRIENDBATTLESTARTRESP.nested_types = {}
FRIENDBATTLESTARTRESP.enum_types = {}
FRIENDBATTLESTARTRESP.fields = {
	var_0_8.ID_FIELD,
	var_0_8.USER_INFO_FIELD,
	var_0_8.TIMESTAMP_FIELD
}
FRIENDBATTLESTARTRESP.is_extendable = false
FRIENDBATTLESTARTRESP.extensions = {}
var_0_9.ID_FIELD.name = "id"
var_0_9.ID_FIELD.full_name = ".sgland.FriendBattleEndResp.id"
var_0_9.ID_FIELD.number = 1
var_0_9.ID_FIELD.index = 0
var_0_9.ID_FIELD.label = 2
var_0_9.ID_FIELD.has_default_value = false
var_0_9.ID_FIELD.default_value = 0
var_0_9.ID_FIELD.type = 3
var_0_9.ID_FIELD.cpp_type = 2
var_0_9.RESULT_TYPE_FIELD.name = "result_type"
var_0_9.RESULT_TYPE_FIELD.full_name = ".sgland.FriendBattleEndResp.result_type"
var_0_9.RESULT_TYPE_FIELD.number = 2
var_0_9.RESULT_TYPE_FIELD.index = 1
var_0_9.RESULT_TYPE_FIELD.label = 1
var_0_9.RESULT_TYPE_FIELD.has_default_value = false
var_0_9.RESULT_TYPE_FIELD.default_value = 0
var_0_9.RESULT_TYPE_FIELD.type = 5
var_0_9.RESULT_TYPE_FIELD.cpp_type = 1
FRIENDBATTLEENDRESP.name = "FriendBattleEndResp"
FRIENDBATTLEENDRESP.full_name = ".sgland.FriendBattleEndResp"
FRIENDBATTLEENDRESP.nested_types = {}
FRIENDBATTLEENDRESP.enum_types = {}
FRIENDBATTLEENDRESP.fields = {
	var_0_9.ID_FIELD,
	var_0_9.RESULT_TYPE_FIELD
}
FRIENDBATTLEENDRESP.is_extendable = false
FRIENDBATTLEENDRESP.extensions = {}
var_0_10.FRIEND_SEARCH_REQ_FIELD.name = "friend_search_req"
var_0_10.FRIEND_SEARCH_REQ_FIELD.full_name = ".sgland.SglFriendMsg.friend_search_req"
var_0_10.FRIEND_SEARCH_REQ_FIELD.number = 900
var_0_10.FRIEND_SEARCH_REQ_FIELD.index = 0
var_0_10.FRIEND_SEARCH_REQ_FIELD.label = 1
var_0_10.FRIEND_SEARCH_REQ_FIELD.has_default_value = false
var_0_10.FRIEND_SEARCH_REQ_FIELD.default_value = ""
var_0_10.FRIEND_SEARCH_REQ_FIELD.type = 9
var_0_10.FRIEND_SEARCH_REQ_FIELD.cpp_type = 9
var_0_10.FRIEND_INVITE_REQ_FIELD.name = "friend_invite_req"
var_0_10.FRIEND_INVITE_REQ_FIELD.full_name = ".sgland.SglFriendMsg.friend_invite_req"
var_0_10.FRIEND_INVITE_REQ_FIELD.number = 901
var_0_10.FRIEND_INVITE_REQ_FIELD.index = 1
var_0_10.FRIEND_INVITE_REQ_FIELD.label = 1
var_0_10.FRIEND_INVITE_REQ_FIELD.has_default_value = false
var_0_10.FRIEND_INVITE_REQ_FIELD.default_value = nil
var_0_10.FRIEND_INVITE_REQ_FIELD.message_type = FRIENDINVITEREQ
var_0_10.FRIEND_INVITE_REQ_FIELD.type = 11
var_0_10.FRIEND_INVITE_REQ_FIELD.cpp_type = 10
var_0_10.FRIEND_ACCEPT_REQ_FIELD.name = "friend_accept_req"
var_0_10.FRIEND_ACCEPT_REQ_FIELD.full_name = ".sgland.SglFriendMsg.friend_accept_req"
var_0_10.FRIEND_ACCEPT_REQ_FIELD.number = 902
var_0_10.FRIEND_ACCEPT_REQ_FIELD.index = 2
var_0_10.FRIEND_ACCEPT_REQ_FIELD.label = 1
var_0_10.FRIEND_ACCEPT_REQ_FIELD.has_default_value = false
var_0_10.FRIEND_ACCEPT_REQ_FIELD.default_value = nil
var_0_10.FRIEND_ACCEPT_REQ_FIELD.message_type = FRIENDACCEPTREQ
var_0_10.FRIEND_ACCEPT_REQ_FIELD.type = 11
var_0_10.FRIEND_ACCEPT_REQ_FIELD.cpp_type = 10
var_0_10.FRIEND_REMOVE_REQ_FIELD.name = "friend_remove_req"
var_0_10.FRIEND_REMOVE_REQ_FIELD.full_name = ".sgland.SglFriendMsg.friend_remove_req"
var_0_10.FRIEND_REMOVE_REQ_FIELD.number = 903
var_0_10.FRIEND_REMOVE_REQ_FIELD.index = 3
var_0_10.FRIEND_REMOVE_REQ_FIELD.label = 1
var_0_10.FRIEND_REMOVE_REQ_FIELD.has_default_value = false
var_0_10.FRIEND_REMOVE_REQ_FIELD.default_value = 0
var_0_10.FRIEND_REMOVE_REQ_FIELD.type = 3
var_0_10.FRIEND_REMOVE_REQ_FIELD.cpp_type = 2
var_0_10.FRIEND_BATTLE_REQ_FIELD.name = "friend_battle_req"
var_0_10.FRIEND_BATTLE_REQ_FIELD.full_name = ".sgland.SglFriendMsg.friend_battle_req"
var_0_10.FRIEND_BATTLE_REQ_FIELD.number = 904
var_0_10.FRIEND_BATTLE_REQ_FIELD.index = 4
var_0_10.FRIEND_BATTLE_REQ_FIELD.label = 1
var_0_10.FRIEND_BATTLE_REQ_FIELD.has_default_value = false
var_0_10.FRIEND_BATTLE_REQ_FIELD.default_value = 0
var_0_10.FRIEND_BATTLE_REQ_FIELD.type = 5
var_0_10.FRIEND_BATTLE_REQ_FIELD.cpp_type = 1
var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD.name = "friend_battle_join_req"
var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD.full_name = ".sgland.SglFriendMsg.friend_battle_join_req"
var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD.number = 905
var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD.index = 5
var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD.label = 1
var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD.has_default_value = false
var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD.default_value = nil
var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD.message_type = FRIENDBATTLEJOINREQ
var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD.type = 11
var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD.cpp_type = 10
var_0_10.FRIEND_SEARCH_RESP_FIELD.name = "friend_search_resp"
var_0_10.FRIEND_SEARCH_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_search_resp"
var_0_10.FRIEND_SEARCH_RESP_FIELD.number = 900
var_0_10.FRIEND_SEARCH_RESP_FIELD.index = 6
var_0_10.FRIEND_SEARCH_RESP_FIELD.label = 3
var_0_10.FRIEND_SEARCH_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_SEARCH_RESP_FIELD.default_value = {}
var_0_10.FRIEND_SEARCH_RESP_FIELD.message_type = var_0_2.USERINFO
var_0_10.FRIEND_SEARCH_RESP_FIELD.type = 11
var_0_10.FRIEND_SEARCH_RESP_FIELD.cpp_type = 10
var_0_10.FRIEND_RECOMMEND_RESP_FIELD.name = "friend_recommend_resp"
var_0_10.FRIEND_RECOMMEND_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_recommend_resp"
var_0_10.FRIEND_RECOMMEND_RESP_FIELD.number = 901
var_0_10.FRIEND_RECOMMEND_RESP_FIELD.index = 7
var_0_10.FRIEND_RECOMMEND_RESP_FIELD.label = 3
var_0_10.FRIEND_RECOMMEND_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_RECOMMEND_RESP_FIELD.default_value = {}
var_0_10.FRIEND_RECOMMEND_RESP_FIELD.message_type = var_0_2.USERINFO
var_0_10.FRIEND_RECOMMEND_RESP_FIELD.type = 11
var_0_10.FRIEND_RECOMMEND_RESP_FIELD.cpp_type = 10
var_0_10.FRIEND_INVITE_RESP_FIELD.name = "friend_invite_resp"
var_0_10.FRIEND_INVITE_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_invite_resp"
var_0_10.FRIEND_INVITE_RESP_FIELD.number = 902
var_0_10.FRIEND_INVITE_RESP_FIELD.index = 8
var_0_10.FRIEND_INVITE_RESP_FIELD.label = 1
var_0_10.FRIEND_INVITE_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_INVITE_RESP_FIELD.default_value = nil
var_0_10.FRIEND_INVITE_RESP_FIELD.enum_type = var_0_1.INVITESTATUS
var_0_10.FRIEND_INVITE_RESP_FIELD.type = 14
var_0_10.FRIEND_INVITE_RESP_FIELD.cpp_type = 8
var_0_10.FRIEND_LIST_RESP_FIELD.name = "friend_list_resp"
var_0_10.FRIEND_LIST_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_list_resp"
var_0_10.FRIEND_LIST_RESP_FIELD.number = 903
var_0_10.FRIEND_LIST_RESP_FIELD.index = 9
var_0_10.FRIEND_LIST_RESP_FIELD.label = 3
var_0_10.FRIEND_LIST_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_LIST_RESP_FIELD.default_value = {}
var_0_10.FRIEND_LIST_RESP_FIELD.message_type = var_0_2.USERINFO
var_0_10.FRIEND_LIST_RESP_FIELD.type = 11
var_0_10.FRIEND_LIST_RESP_FIELD.cpp_type = 10
var_0_10.FRIEND_EXCEED_RESP_FIELD.name = "friend_exceed_resp"
var_0_10.FRIEND_EXCEED_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_exceed_resp"
var_0_10.FRIEND_EXCEED_RESP_FIELD.number = 904
var_0_10.FRIEND_EXCEED_RESP_FIELD.index = 10
var_0_10.FRIEND_EXCEED_RESP_FIELD.label = 1
var_0_10.FRIEND_EXCEED_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_EXCEED_RESP_FIELD.default_value = 0
var_0_10.FRIEND_EXCEED_RESP_FIELD.type = 3
var_0_10.FRIEND_EXCEED_RESP_FIELD.cpp_type = 2
var_0_10.FRIEND_ACCEPTED_RESP_FIELD.name = "friend_accepted_resp"
var_0_10.FRIEND_ACCEPTED_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_accepted_resp"
var_0_10.FRIEND_ACCEPTED_RESP_FIELD.number = 905
var_0_10.FRIEND_ACCEPTED_RESP_FIELD.index = 11
var_0_10.FRIEND_ACCEPTED_RESP_FIELD.label = 1
var_0_10.FRIEND_ACCEPTED_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_ACCEPTED_RESP_FIELD.default_value = nil
var_0_10.FRIEND_ACCEPTED_RESP_FIELD.message_type = var_0_2.USERINFO
var_0_10.FRIEND_ACCEPTED_RESP_FIELD.type = 11
var_0_10.FRIEND_ACCEPTED_RESP_FIELD.cpp_type = 10
var_0_10.FRIEND_REMOVED_RESP_FIELD.name = "friend_removed_resp"
var_0_10.FRIEND_REMOVED_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_removed_resp"
var_0_10.FRIEND_REMOVED_RESP_FIELD.number = 906
var_0_10.FRIEND_REMOVED_RESP_FIELD.index = 12
var_0_10.FRIEND_REMOVED_RESP_FIELD.label = 1
var_0_10.FRIEND_REMOVED_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_REMOVED_RESP_FIELD.default_value = 0
var_0_10.FRIEND_REMOVED_RESP_FIELD.type = 3
var_0_10.FRIEND_REMOVED_RESP_FIELD.cpp_type = 2
var_0_10.FRIEND_BATTLE_RESP_FIELD.name = "friend_battle_resp"
var_0_10.FRIEND_BATTLE_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_battle_resp"
var_0_10.FRIEND_BATTLE_RESP_FIELD.number = 907
var_0_10.FRIEND_BATTLE_RESP_FIELD.index = 13
var_0_10.FRIEND_BATTLE_RESP_FIELD.label = 3
var_0_10.FRIEND_BATTLE_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_BATTLE_RESP_FIELD.default_value = {}
var_0_10.FRIEND_BATTLE_RESP_FIELD.message_type = FRIENDBATTLE
var_0_10.FRIEND_BATTLE_RESP_FIELD.type = 11
var_0_10.FRIEND_BATTLE_RESP_FIELD.cpp_type = 10
var_0_10.FRIEND_BATTLE_START_RESP_FIELD.name = "friend_battle_start_resp"
var_0_10.FRIEND_BATTLE_START_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_battle_start_resp"
var_0_10.FRIEND_BATTLE_START_RESP_FIELD.number = 908
var_0_10.FRIEND_BATTLE_START_RESP_FIELD.index = 14
var_0_10.FRIEND_BATTLE_START_RESP_FIELD.label = 1
var_0_10.FRIEND_BATTLE_START_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_BATTLE_START_RESP_FIELD.default_value = nil
var_0_10.FRIEND_BATTLE_START_RESP_FIELD.message_type = FRIENDBATTLESTARTRESP
var_0_10.FRIEND_BATTLE_START_RESP_FIELD.type = 11
var_0_10.FRIEND_BATTLE_START_RESP_FIELD.cpp_type = 10
var_0_10.FRIEND_BATTLE_END_RESP_FIELD.name = "friend_battle_end_resp"
var_0_10.FRIEND_BATTLE_END_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_battle_end_resp"
var_0_10.FRIEND_BATTLE_END_RESP_FIELD.number = 909
var_0_10.FRIEND_BATTLE_END_RESP_FIELD.index = 15
var_0_10.FRIEND_BATTLE_END_RESP_FIELD.label = 1
var_0_10.FRIEND_BATTLE_END_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_BATTLE_END_RESP_FIELD.default_value = nil
var_0_10.FRIEND_BATTLE_END_RESP_FIELD.message_type = FRIENDBATTLEENDRESP
var_0_10.FRIEND_BATTLE_END_RESP_FIELD.type = 11
var_0_10.FRIEND_BATTLE_END_RESP_FIELD.cpp_type = 10
var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD.name = "friend_battle_update_resp"
var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD.full_name = ".sgland.SglFriendMsg.friend_battle_update_resp"
var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD.number = 910
var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD.index = 16
var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD.label = 1
var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD.has_default_value = false
var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD.default_value = nil
var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD.message_type = FRIENDBATTLE
var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD.type = 11
var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD.cpp_type = 10
SGLFRIENDMSG.name = "SglFriendMsg"
SGLFRIENDMSG.full_name = ".sgland.SglFriendMsg"
SGLFRIENDMSG.nested_types = {}
SGLFRIENDMSG.enum_types = {}
SGLFRIENDMSG.fields = {}
SGLFRIENDMSG.is_extendable = false
SGLFRIENDMSG.extensions = {
	var_0_10.FRIEND_SEARCH_REQ_FIELD,
	var_0_10.FRIEND_INVITE_REQ_FIELD,
	var_0_10.FRIEND_ACCEPT_REQ_FIELD,
	var_0_10.FRIEND_REMOVE_REQ_FIELD,
	var_0_10.FRIEND_BATTLE_REQ_FIELD,
	var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD,
	var_0_10.FRIEND_SEARCH_RESP_FIELD,
	var_0_10.FRIEND_RECOMMEND_RESP_FIELD,
	var_0_10.FRIEND_INVITE_RESP_FIELD,
	var_0_10.FRIEND_LIST_RESP_FIELD,
	var_0_10.FRIEND_EXCEED_RESP_FIELD,
	var_0_10.FRIEND_ACCEPTED_RESP_FIELD,
	var_0_10.FRIEND_REMOVED_RESP_FIELD,
	var_0_10.FRIEND_BATTLE_RESP_FIELD,
	var_0_10.FRIEND_BATTLE_START_RESP_FIELD,
	var_0_10.FRIEND_BATTLE_END_RESP_FIELD,
	var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD
}
FriendAcceptReq = var_0_0.Message(FRIENDACCEPTREQ)
FriendBattle = var_0_0.Message(FRIENDBATTLE)
FriendBattleEndResp = var_0_0.Message(FRIENDBATTLEENDRESP)
FriendBattleJoinReq = var_0_0.Message(FRIENDBATTLEJOINREQ)
FriendBattleResult = var_0_0.Message(FRIENDBATTLERESULT)
FriendBattleStartResp = var_0_0.Message(FRIENDBATTLESTARTRESP)
FriendInviteReq = var_0_0.Message(FRIENDINVITEREQ)
SglFriendMsg = var_0_0.Message(SGLFRIENDMSG)

var_0_1.SglReqMsg.RegisterExtension(var_0_10.FRIEND_SEARCH_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_10.FRIEND_INVITE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_10.FRIEND_ACCEPT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_10.FRIEND_REMOVE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_10.FRIEND_BATTLE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_10.FRIEND_BATTLE_JOIN_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_SEARCH_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_RECOMMEND_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_INVITE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_LIST_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_EXCEED_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_ACCEPTED_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_REMOVED_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_BATTLE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_BATTLE_START_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_BATTLE_END_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_10.FRIEND_BATTLE_UPDATE_RESP_FIELD)
