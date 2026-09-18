local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Union_pb")

UNIONTYPE = var_0_0.EnumDescriptor()

local var_0_3 = {
	PB_UNION_ANY = var_0_0.EnumValueDescriptor(),
	PB_UNION_APPLY = var_0_0.EnumValueDescriptor(),
	PB_UNION_INVITE = var_0_0.EnumValueDescriptor(),
	PB_UNION_CLOSED = var_0_0.EnumValueDescriptor()
}

UNIONTITLE = var_0_0.EnumDescriptor()

local var_0_4 = {
	PB_UNION_MEMBER = var_0_0.EnumValueDescriptor(),
	PB_UNION_CO_LEADER = var_0_0.EnumValueDescriptor(),
	PB_UNION_LEADER = var_0_0.EnumValueDescriptor()
}

UNIONMESSAGETYPE = var_0_0.EnumDescriptor()

local var_0_5 = {
	PB_UNION_CHAT = var_0_0.EnumValueDescriptor(),
	PB_UNION_JOIN = var_0_0.EnumValueDescriptor(),
	PB_UNION_LEAVE = var_0_0.EnumValueDescriptor(),
	PB_UNION_KICKOUT = var_0_0.EnumValueDescriptor(),
	PB_UNION_TO_MEMBER = var_0_0.EnumValueDescriptor(),
	PB_UNION_TO_CO_LEADER = var_0_0.EnumValueDescriptor(),
	PB_UNION_TO_LEADER = var_0_0.EnumValueDescriptor(),
	PB_UNION_DONATE = var_0_0.EnumValueDescriptor(),
	PB_UNION_UPGRADE = var_0_0.EnumValueDescriptor(),
	PB_UNION_CLAIM_TASK = var_0_0.EnumValueDescriptor(),
	PB_UNION_SHOP_UPGRADE = var_0_0.EnumValueDescriptor(),
	PB_UNION_BOARD_UPGRADE = var_0_0.EnumValueDescriptor(),
	PB_UNION_LET = var_0_0.EnumValueDescriptor(),
	PB_UNION_UNLET = var_0_0.EnumValueDescriptor(),
	PB_UNION_RESIGN = var_0_0.EnumValueDescriptor(),
	PB_UNION_CREATE = var_0_0.EnumValueDescriptor(),
	PB_UNION_TECH_UPGRADE = var_0_0.EnumValueDescriptor(),
	PB_UNION_RESCUE = var_0_0.EnumValueDescriptor(),
	PB_UNION_IMPEACH = var_0_0.EnumValueDescriptor(),
	PB_UNION_UNIMPEACH = var_0_0.EnumValueDescriptor(),
	PB_UNION_IMPEACHED = var_0_0.EnumValueDescriptor(),
	PB_UNION_ADD_EXP = var_0_0.EnumValueDescriptor(),
	PB_UNION_MASSWAR_TEAM_INVITE_REQ = var_0_0.EnumValueDescriptor(),
	PB_UNION_MASSWAR_TEAM_JOIN_REQ = var_0_0.EnumValueDescriptor()
}

FULLUNIONINFO = var_0_0.Descriptor()

local var_0_6 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	TAG_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor(),
	EXP_FIELD = var_0_0.FieldDescriptor(),
	GOLD_FIELD = var_0_0.FieldDescriptor(),
	WOOD_FIELD = var_0_0.FieldDescriptor(),
	ANNOUNCEMENT_FIELD = var_0_0.FieldDescriptor(),
	MEMBER_FIELD = var_0_0.FieldDescriptor(),
	REQUIRED_LEVEL_FIELD = var_0_0.FieldDescriptor()
}

UNIONMESSAGE = var_0_0.Descriptor()

local var_0_7 = {
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	USER1_FIELD = var_0_0.FieldDescriptor(),
	MESSAGE_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	RESOURCE_FIELD = var_0_0.FieldDescriptor(),
	LET_FIELD = var_0_0.FieldDescriptor(),
	USER2_FIELD = var_0_0.FieldDescriptor(),
	PARAM1_FIELD = var_0_0.FieldDescriptor(),
	PARAM2_FIELD = var_0_0.FieldDescriptor()
}

UNIONDONATE = var_0_0.Descriptor()

local var_0_8 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	GOLD_FIELD = var_0_0.FieldDescriptor(),
	WOOD_FIELD = var_0_0.FieldDescriptor(),
	EXP_FIELD = var_0_0.FieldDescriptor(),
	POWER_FIELD = var_0_0.FieldDescriptor()
}

UNIONDONATEEX = var_0_0.Descriptor()

local var_0_9 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	GOLD_FIELD = var_0_0.FieldDescriptor(),
	WOOD_FIELD = var_0_0.FieldDescriptor(),
	EXP_FIELD = var_0_0.FieldDescriptor(),
	POWER_FIELD = var_0_0.FieldDescriptor()
}

UNIONLET = var_0_0.Descriptor()

local var_0_10 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	OWNER_ID_FIELD = var_0_0.FieldDescriptor(),
	CARDS_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	RENTED_FIELD = var_0_0.FieldDescriptor()
}

UNIONBOSSSCORE = var_0_0.Descriptor()

local var_0_11 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	SCORE_FIELD = var_0_0.FieldDescriptor(),
	COUNT_FIELD = var_0_0.FieldDescriptor()
}

UNIONBOSS = var_0_0.Descriptor()

local var_0_12 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	HP_FIELD = var_0_0.FieldDescriptor(),
	START_TIME_FIELD = var_0_0.FieldDescriptor(),
	END_TIME_FIELD = var_0_0.FieldDescriptor(),
	KILLED_COUNT_FIELD = var_0_0.FieldDescriptor(),
	SCORE_FIELD = var_0_0.FieldDescriptor(),
	ASSISTANT_FIELD = var_0_0.FieldDescriptor()
}

UNIONDATA = var_0_0.Descriptor()

local var_0_13 = {
	MESSAGES_FIELD = var_0_0.FieldDescriptor(),
	WEEKLY_DONATES_FIELD = var_0_0.FieldDescriptor(),
	LETS_FIELD = var_0_0.FieldDescriptor(),
	CHATS_FIELD = var_0_0.FieldDescriptor(),
	DAILY_DONATES_FIELD = var_0_0.FieldDescriptor(),
	IMPEACHES_FIELD = var_0_0.FieldDescriptor()
}

UNIONDATAEX = var_0_0.Descriptor()

local var_0_14 = {
	BOSSES_FIELD = var_0_0.FieldDescriptor(),
	TECHS_FIELD = var_0_0.FieldDescriptor(),
	PROPS_FIELD = var_0_0.FieldDescriptor(),
	TEAMS_FIELD = var_0_0.FieldDescriptor()
}

UNIONEDIT = var_0_0.Descriptor()

local var_0_15 = {
	NAME_FIELD = var_0_0.FieldDescriptor(),
	AVATAR_FIELD = var_0_0.FieldDescriptor(),
	ANNOUNCEMENT_FIELD = var_0_0.FieldDescriptor(),
	TAG_FIELD = var_0_0.FieldDescriptor(),
	TYPE_FIELD = var_0_0.FieldDescriptor(),
	REQUIRED_LEVEL_FIELD = var_0_0.FieldDescriptor()
}

UNIONBOSSFOCUS = var_0_0.Descriptor()

local var_0_16 = {
	INFO_FIELD = var_0_0.FieldDescriptor(),
	ID_FIELD = var_0_0.FieldDescriptor()
}

UNIONINVITEREQ = var_0_0.Descriptor()

local var_0_17 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	MESSAGE_FIELD = var_0_0.FieldDescriptor()
}

MEMBERINFO = var_0_0.Descriptor()

local var_0_18 = {
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	BADGE_LEVEL_FIELD = var_0_0.FieldDescriptor(),
	BADGE_PURCHASED_FIELD = var_0_0.FieldDescriptor(),
	EXP_DONATE_FIELD = var_0_0.FieldDescriptor()
}

UNIONDETAIL = var_0_0.Descriptor()

local var_0_19 = {
	UNION_INFO_FIELD = var_0_0.FieldDescriptor(),
	MEMBER_INFO_FIELD = var_0_0.FieldDescriptor()
}

UNIONAPPLYREQ = var_0_0.Descriptor()

local var_0_20 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	MESSAGE_FIELD = var_0_0.FieldDescriptor()
}

UNIONACCEPTREQ = var_0_0.Descriptor()

local var_0_21 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	IS_ACCEPT_FIELD = var_0_0.FieldDescriptor(),
	CONTENT_FIELD = var_0_0.FieldDescriptor()
}

UNIONDONATEREQ = var_0_0.Descriptor()

local var_0_22 = {
	DONATE_TYPE_FIELD = var_0_0.FieldDescriptor(),
	GRADE_FIELD = var_0_0.FieldDescriptor()
}

UNIONWORSHIPREQ = var_0_0.Descriptor()

local var_0_23 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	GRADE_FIELD = var_0_0.FieldDescriptor()
}

UNIONCOLLECTREQ = var_0_0.Descriptor()

local var_0_24 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	INFO_ID_FIELD = var_0_0.FieldDescriptor(),
	NUM_FIELD = var_0_0.FieldDescriptor()
}

UNIONSEARCHREQ = var_0_0.Descriptor()

local var_0_25 = {
	NAME_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor(),
	ID_FIELD = var_0_0.FieldDescriptor()
}

UNIONMINERESP = var_0_0.Descriptor()

local var_0_26 = {
	DETAIL_FIELD = var_0_0.FieldDescriptor(),
	LETS_FIELD = var_0_0.FieldDescriptor(),
	WEEKLY_DONATES_FIELD = var_0_0.FieldDescriptor(),
	DAILY_DONATES_FIELD = var_0_0.FieldDescriptor(),
	DATA_FIELD = var_0_0.FieldDescriptor(),
	FOCUSES_FIELD = var_0_0.FieldDescriptor(),
	IMPEACHES_FIELD = var_0_0.FieldDescriptor()
}

UNIONBOSSDAMAGERESP = var_0_0.Descriptor()

local var_0_27 = {
	INFO_FIELD = var_0_0.FieldDescriptor(),
	ID_FIELD = var_0_0.FieldDescriptor(),
	DAMAGE_FIELD = var_0_0.FieldDescriptor(),
	SCORE_FIELD = var_0_0.FieldDescriptor(),
	ASSISTANT_DAMAGE_FIELD = var_0_0.FieldDescriptor()
}

SGLUNIONMSG = var_0_0.Descriptor()

local var_0_28 = {
	UNION_CREATE_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_INVITE_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_APPLY_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_KICKOUT_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_ACCEPT_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_SEARCH_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_DETAIL_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_JOIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_EDIT_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_BUY_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_DONATE_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_PROMOTE_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_DEMOTE_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_RESIGN_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_LET_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_RENT_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_UNLET_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_CLAIM_LET_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_WORSHIP_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_BOSS_ATTACK_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_BOSS_UNLOCK_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_TECH_UPGRADE_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_IMPEACH_REQ_FIELD = var_0_0.FieldDescriptor(),
	CREATE_UNION_USE_TOKEN_FIELD = var_0_0.FieldDescriptor(),
	UNION_CREATE_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_INVITE_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_APPLY_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_SEARCH_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_MESSAGE_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_DETAIL_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_JOIN_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_REFRESH_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_POWER_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_MINE_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_RECOMMEND_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_LET_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_UNLET_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_ACCEPT_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_BOSS_ATTACK_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_BOSS_UNLOCK_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_BOSS_DAMAGE_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_BOSS_FOCUS_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_BOSS_KILL_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_JOIN_CD_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.PB_UNION_ANY.name = "PB_UNION_ANY"
var_0_3.PB_UNION_ANY.index = 0
var_0_3.PB_UNION_ANY.number = 1
var_0_3.PB_UNION_APPLY.name = "PB_UNION_APPLY"
var_0_3.PB_UNION_APPLY.index = 1
var_0_3.PB_UNION_APPLY.number = 2
var_0_3.PB_UNION_INVITE.name = "PB_UNION_INVITE"
var_0_3.PB_UNION_INVITE.index = 2
var_0_3.PB_UNION_INVITE.number = 3
var_0_3.PB_UNION_CLOSED.name = "PB_UNION_CLOSED"
var_0_3.PB_UNION_CLOSED.index = 3
var_0_3.PB_UNION_CLOSED.number = 4
UNIONTYPE.name = "UnionType"
UNIONTYPE.full_name = ".sgland.UnionType"
UNIONTYPE.values = {
	var_0_3.PB_UNION_ANY,
	var_0_3.PB_UNION_APPLY,
	var_0_3.PB_UNION_INVITE,
	var_0_3.PB_UNION_CLOSED
}
var_0_4.PB_UNION_MEMBER.name = "PB_UNION_MEMBER"
var_0_4.PB_UNION_MEMBER.index = 0
var_0_4.PB_UNION_MEMBER.number = 1
var_0_4.PB_UNION_CO_LEADER.name = "PB_UNION_CO_LEADER"
var_0_4.PB_UNION_CO_LEADER.index = 1
var_0_4.PB_UNION_CO_LEADER.number = 2
var_0_4.PB_UNION_LEADER.name = "PB_UNION_LEADER"
var_0_4.PB_UNION_LEADER.index = 2
var_0_4.PB_UNION_LEADER.number = 3
UNIONTITLE.name = "UnionTitle"
UNIONTITLE.full_name = ".sgland.UnionTitle"
UNIONTITLE.values = {
	var_0_4.PB_UNION_MEMBER,
	var_0_4.PB_UNION_CO_LEADER,
	var_0_4.PB_UNION_LEADER
}
var_0_5.PB_UNION_CHAT.name = "PB_UNION_CHAT"
var_0_5.PB_UNION_CHAT.index = 0
var_0_5.PB_UNION_CHAT.number = 1
var_0_5.PB_UNION_JOIN.name = "PB_UNION_JOIN"
var_0_5.PB_UNION_JOIN.index = 1
var_0_5.PB_UNION_JOIN.number = 2
var_0_5.PB_UNION_LEAVE.name = "PB_UNION_LEAVE"
var_0_5.PB_UNION_LEAVE.index = 2
var_0_5.PB_UNION_LEAVE.number = 3
var_0_5.PB_UNION_KICKOUT.name = "PB_UNION_KICKOUT"
var_0_5.PB_UNION_KICKOUT.index = 3
var_0_5.PB_UNION_KICKOUT.number = 4
var_0_5.PB_UNION_TO_MEMBER.name = "PB_UNION_TO_MEMBER"
var_0_5.PB_UNION_TO_MEMBER.index = 4
var_0_5.PB_UNION_TO_MEMBER.number = 5
var_0_5.PB_UNION_TO_CO_LEADER.name = "PB_UNION_TO_CO_LEADER"
var_0_5.PB_UNION_TO_CO_LEADER.index = 5
var_0_5.PB_UNION_TO_CO_LEADER.number = 6
var_0_5.PB_UNION_TO_LEADER.name = "PB_UNION_TO_LEADER"
var_0_5.PB_UNION_TO_LEADER.index = 6
var_0_5.PB_UNION_TO_LEADER.number = 7
var_0_5.PB_UNION_DONATE.name = "PB_UNION_DONATE"
var_0_5.PB_UNION_DONATE.index = 7
var_0_5.PB_UNION_DONATE.number = 8
var_0_5.PB_UNION_UPGRADE.name = "PB_UNION_UPGRADE"
var_0_5.PB_UNION_UPGRADE.index = 8
var_0_5.PB_UNION_UPGRADE.number = 9
var_0_5.PB_UNION_CLAIM_TASK.name = "PB_UNION_CLAIM_TASK"
var_0_5.PB_UNION_CLAIM_TASK.index = 9
var_0_5.PB_UNION_CLAIM_TASK.number = 10
var_0_5.PB_UNION_SHOP_UPGRADE.name = "PB_UNION_SHOP_UPGRADE"
var_0_5.PB_UNION_SHOP_UPGRADE.index = 10
var_0_5.PB_UNION_SHOP_UPGRADE.number = 11
var_0_5.PB_UNION_BOARD_UPGRADE.name = "PB_UNION_BOARD_UPGRADE"
var_0_5.PB_UNION_BOARD_UPGRADE.index = 11
var_0_5.PB_UNION_BOARD_UPGRADE.number = 12
var_0_5.PB_UNION_LET.name = "PB_UNION_LET"
var_0_5.PB_UNION_LET.index = 12
var_0_5.PB_UNION_LET.number = 13
var_0_5.PB_UNION_UNLET.name = "PB_UNION_UNLET"
var_0_5.PB_UNION_UNLET.index = 13
var_0_5.PB_UNION_UNLET.number = 14
var_0_5.PB_UNION_RESIGN.name = "PB_UNION_RESIGN"
var_0_5.PB_UNION_RESIGN.index = 14
var_0_5.PB_UNION_RESIGN.number = 15
var_0_5.PB_UNION_CREATE.name = "PB_UNION_CREATE"
var_0_5.PB_UNION_CREATE.index = 15
var_0_5.PB_UNION_CREATE.number = 16
var_0_5.PB_UNION_TECH_UPGRADE.name = "PB_UNION_TECH_UPGRADE"
var_0_5.PB_UNION_TECH_UPGRADE.index = 16
var_0_5.PB_UNION_TECH_UPGRADE.number = 17
var_0_5.PB_UNION_RESCUE.name = "PB_UNION_RESCUE"
var_0_5.PB_UNION_RESCUE.index = 17
var_0_5.PB_UNION_RESCUE.number = 18
var_0_5.PB_UNION_IMPEACH.name = "PB_UNION_IMPEACH"
var_0_5.PB_UNION_IMPEACH.index = 18
var_0_5.PB_UNION_IMPEACH.number = 19
var_0_5.PB_UNION_UNIMPEACH.name = "PB_UNION_UNIMPEACH"
var_0_5.PB_UNION_UNIMPEACH.index = 19
var_0_5.PB_UNION_UNIMPEACH.number = 20
var_0_5.PB_UNION_IMPEACHED.name = "PB_UNION_IMPEACHED"
var_0_5.PB_UNION_IMPEACHED.index = 20
var_0_5.PB_UNION_IMPEACHED.number = 21
var_0_5.PB_UNION_ADD_EXP.name = "PB_UNION_ADD_EXP"
var_0_5.PB_UNION_ADD_EXP.index = 21
var_0_5.PB_UNION_ADD_EXP.number = 22
var_0_5.PB_UNION_MASSWAR_TEAM_INVITE_REQ.name = "PB_UNION_MASSWAR_TEAM_INVITE_REQ"
var_0_5.PB_UNION_MASSWAR_TEAM_INVITE_REQ.index = 22
var_0_5.PB_UNION_MASSWAR_TEAM_INVITE_REQ.number = 23
var_0_5.PB_UNION_MASSWAR_TEAM_JOIN_REQ.name = "PB_UNION_MASSWAR_TEAM_JOIN_REQ"
var_0_5.PB_UNION_MASSWAR_TEAM_JOIN_REQ.index = 23
var_0_5.PB_UNION_MASSWAR_TEAM_JOIN_REQ.number = 24
UNIONMESSAGETYPE.name = "UnionMessageType"
UNIONMESSAGETYPE.full_name = ".sgland.UnionMessageType"
UNIONMESSAGETYPE.values = {
	var_0_5.PB_UNION_CHAT,
	var_0_5.PB_UNION_JOIN,
	var_0_5.PB_UNION_LEAVE,
	var_0_5.PB_UNION_KICKOUT,
	var_0_5.PB_UNION_TO_MEMBER,
	var_0_5.PB_UNION_TO_CO_LEADER,
	var_0_5.PB_UNION_TO_LEADER,
	var_0_5.PB_UNION_DONATE,
	var_0_5.PB_UNION_UPGRADE,
	var_0_5.PB_UNION_CLAIM_TASK,
	var_0_5.PB_UNION_SHOP_UPGRADE,
	var_0_5.PB_UNION_BOARD_UPGRADE,
	var_0_5.PB_UNION_LET,
	var_0_5.PB_UNION_UNLET,
	var_0_5.PB_UNION_RESIGN,
	var_0_5.PB_UNION_CREATE,
	var_0_5.PB_UNION_TECH_UPGRADE,
	var_0_5.PB_UNION_RESCUE,
	var_0_5.PB_UNION_IMPEACH,
	var_0_5.PB_UNION_UNIMPEACH,
	var_0_5.PB_UNION_IMPEACHED,
	var_0_5.PB_UNION_ADD_EXP,
	var_0_5.PB_UNION_MASSWAR_TEAM_INVITE_REQ,
	var_0_5.PB_UNION_MASSWAR_TEAM_JOIN_REQ
}
var_0_6.ID_FIELD.name = "id"
var_0_6.ID_FIELD.full_name = ".sgland.FullUnionInfo.id"
var_0_6.ID_FIELD.number = 1
var_0_6.ID_FIELD.index = 0
var_0_6.ID_FIELD.label = 2
var_0_6.ID_FIELD.has_default_value = false
var_0_6.ID_FIELD.default_value = 0
var_0_6.ID_FIELD.type = 3
var_0_6.ID_FIELD.cpp_type = 2
var_0_6.NAME_FIELD.name = "name"
var_0_6.NAME_FIELD.full_name = ".sgland.FullUnionInfo.name"
var_0_6.NAME_FIELD.number = 2
var_0_6.NAME_FIELD.index = 1
var_0_6.NAME_FIELD.label = 2
var_0_6.NAME_FIELD.has_default_value = false
var_0_6.NAME_FIELD.default_value = ""
var_0_6.NAME_FIELD.type = 9
var_0_6.NAME_FIELD.cpp_type = 9
var_0_6.AVATAR_FIELD.name = "avatar"
var_0_6.AVATAR_FIELD.full_name = ".sgland.FullUnionInfo.avatar"
var_0_6.AVATAR_FIELD.number = 3
var_0_6.AVATAR_FIELD.index = 2
var_0_6.AVATAR_FIELD.label = 2
var_0_6.AVATAR_FIELD.has_default_value = false
var_0_6.AVATAR_FIELD.default_value = 0
var_0_6.AVATAR_FIELD.type = 5
var_0_6.AVATAR_FIELD.cpp_type = 1
var_0_6.TYPE_FIELD.name = "type"
var_0_6.TYPE_FIELD.full_name = ".sgland.FullUnionInfo.type"
var_0_6.TYPE_FIELD.number = 4
var_0_6.TYPE_FIELD.index = 3
var_0_6.TYPE_FIELD.label = 2
var_0_6.TYPE_FIELD.has_default_value = false
var_0_6.TYPE_FIELD.default_value = 0
var_0_6.TYPE_FIELD.type = 5
var_0_6.TYPE_FIELD.cpp_type = 1
var_0_6.TAG_FIELD.name = "tag"
var_0_6.TAG_FIELD.full_name = ".sgland.FullUnionInfo.tag"
var_0_6.TAG_FIELD.number = 5
var_0_6.TAG_FIELD.index = 4
var_0_6.TAG_FIELD.label = 2
var_0_6.TAG_FIELD.has_default_value = false
var_0_6.TAG_FIELD.default_value = ""
var_0_6.TAG_FIELD.type = 9
var_0_6.TAG_FIELD.cpp_type = 9
var_0_6.LEVEL_FIELD.name = "level"
var_0_6.LEVEL_FIELD.full_name = ".sgland.FullUnionInfo.level"
var_0_6.LEVEL_FIELD.number = 6
var_0_6.LEVEL_FIELD.index = 5
var_0_6.LEVEL_FIELD.label = 2
var_0_6.LEVEL_FIELD.has_default_value = false
var_0_6.LEVEL_FIELD.default_value = 0
var_0_6.LEVEL_FIELD.type = 5
var_0_6.LEVEL_FIELD.cpp_type = 1
var_0_6.EXP_FIELD.name = "exp"
var_0_6.EXP_FIELD.full_name = ".sgland.FullUnionInfo.exp"
var_0_6.EXP_FIELD.number = 7
var_0_6.EXP_FIELD.index = 6
var_0_6.EXP_FIELD.label = 2
var_0_6.EXP_FIELD.has_default_value = false
var_0_6.EXP_FIELD.default_value = 0
var_0_6.EXP_FIELD.type = 5
var_0_6.EXP_FIELD.cpp_type = 1
var_0_6.GOLD_FIELD.name = "gold"
var_0_6.GOLD_FIELD.full_name = ".sgland.FullUnionInfo.gold"
var_0_6.GOLD_FIELD.number = 8
var_0_6.GOLD_FIELD.index = 7
var_0_6.GOLD_FIELD.label = 2
var_0_6.GOLD_FIELD.has_default_value = false
var_0_6.GOLD_FIELD.default_value = 0
var_0_6.GOLD_FIELD.type = 5
var_0_6.GOLD_FIELD.cpp_type = 1
var_0_6.WOOD_FIELD.name = "wood"
var_0_6.WOOD_FIELD.full_name = ".sgland.FullUnionInfo.wood"
var_0_6.WOOD_FIELD.number = 9
var_0_6.WOOD_FIELD.index = 8
var_0_6.WOOD_FIELD.label = 2
var_0_6.WOOD_FIELD.has_default_value = false
var_0_6.WOOD_FIELD.default_value = 0
var_0_6.WOOD_FIELD.type = 5
var_0_6.WOOD_FIELD.cpp_type = 1
var_0_6.ANNOUNCEMENT_FIELD.name = "announcement"
var_0_6.ANNOUNCEMENT_FIELD.full_name = ".sgland.FullUnionInfo.announcement"
var_0_6.ANNOUNCEMENT_FIELD.number = 10
var_0_6.ANNOUNCEMENT_FIELD.index = 9
var_0_6.ANNOUNCEMENT_FIELD.label = 2
var_0_6.ANNOUNCEMENT_FIELD.has_default_value = false
var_0_6.ANNOUNCEMENT_FIELD.default_value = ""
var_0_6.ANNOUNCEMENT_FIELD.type = 9
var_0_6.ANNOUNCEMENT_FIELD.cpp_type = 9
var_0_6.MEMBER_FIELD.name = "member"
var_0_6.MEMBER_FIELD.full_name = ".sgland.FullUnionInfo.member"
var_0_6.MEMBER_FIELD.number = 11
var_0_6.MEMBER_FIELD.index = 10
var_0_6.MEMBER_FIELD.label = 2
var_0_6.MEMBER_FIELD.has_default_value = false
var_0_6.MEMBER_FIELD.default_value = 0
var_0_6.MEMBER_FIELD.type = 5
var_0_6.MEMBER_FIELD.cpp_type = 1
var_0_6.REQUIRED_LEVEL_FIELD.name = "required_level"
var_0_6.REQUIRED_LEVEL_FIELD.full_name = ".sgland.FullUnionInfo.required_level"
var_0_6.REQUIRED_LEVEL_FIELD.number = 12
var_0_6.REQUIRED_LEVEL_FIELD.index = 11
var_0_6.REQUIRED_LEVEL_FIELD.label = 2
var_0_6.REQUIRED_LEVEL_FIELD.has_default_value = false
var_0_6.REQUIRED_LEVEL_FIELD.default_value = 0
var_0_6.REQUIRED_LEVEL_FIELD.type = 5
var_0_6.REQUIRED_LEVEL_FIELD.cpp_type = 1
FULLUNIONINFO.name = "FullUnionInfo"
FULLUNIONINFO.full_name = ".sgland.FullUnionInfo"
FULLUNIONINFO.nested_types = {}
FULLUNIONINFO.enum_types = {}
FULLUNIONINFO.fields = {
	var_0_6.ID_FIELD,
	var_0_6.NAME_FIELD,
	var_0_6.AVATAR_FIELD,
	var_0_6.TYPE_FIELD,
	var_0_6.TAG_FIELD,
	var_0_6.LEVEL_FIELD,
	var_0_6.EXP_FIELD,
	var_0_6.GOLD_FIELD,
	var_0_6.WOOD_FIELD,
	var_0_6.ANNOUNCEMENT_FIELD,
	var_0_6.MEMBER_FIELD,
	var_0_6.REQUIRED_LEVEL_FIELD
}
FULLUNIONINFO.is_extendable = false
FULLUNIONINFO.extensions = {}
var_0_7.TYPE_FIELD.name = "type"
var_0_7.TYPE_FIELD.full_name = ".sgland.UnionMessage.type"
var_0_7.TYPE_FIELD.number = 1
var_0_7.TYPE_FIELD.index = 0
var_0_7.TYPE_FIELD.label = 2
var_0_7.TYPE_FIELD.has_default_value = false
var_0_7.TYPE_FIELD.default_value = nil
var_0_7.TYPE_FIELD.enum_type = UNIONMESSAGETYPE
var_0_7.TYPE_FIELD.type = 14
var_0_7.TYPE_FIELD.cpp_type = 8
var_0_7.USER1_FIELD.name = "user1"
var_0_7.USER1_FIELD.full_name = ".sgland.UnionMessage.user1"
var_0_7.USER1_FIELD.number = 2
var_0_7.USER1_FIELD.index = 1
var_0_7.USER1_FIELD.label = 2
var_0_7.USER1_FIELD.has_default_value = false
var_0_7.USER1_FIELD.default_value = nil
var_0_7.USER1_FIELD.message_type = var_0_2.USERINFO
var_0_7.USER1_FIELD.type = 11
var_0_7.USER1_FIELD.cpp_type = 10
var_0_7.MESSAGE_FIELD.name = "message"
var_0_7.MESSAGE_FIELD.full_name = ".sgland.UnionMessage.message"
var_0_7.MESSAGE_FIELD.number = 3
var_0_7.MESSAGE_FIELD.index = 2
var_0_7.MESSAGE_FIELD.label = 1
var_0_7.MESSAGE_FIELD.has_default_value = false
var_0_7.MESSAGE_FIELD.default_value = ""
var_0_7.MESSAGE_FIELD.type = 9
var_0_7.MESSAGE_FIELD.cpp_type = 9
var_0_7.TIMESTAMP_FIELD.name = "timestamp"
var_0_7.TIMESTAMP_FIELD.full_name = ".sgland.UnionMessage.timestamp"
var_0_7.TIMESTAMP_FIELD.number = 4
var_0_7.TIMESTAMP_FIELD.index = 3
var_0_7.TIMESTAMP_FIELD.label = 2
var_0_7.TIMESTAMP_FIELD.has_default_value = false
var_0_7.TIMESTAMP_FIELD.default_value = 0
var_0_7.TIMESTAMP_FIELD.type = 3
var_0_7.TIMESTAMP_FIELD.cpp_type = 2
var_0_7.RESOURCE_FIELD.name = "resource"
var_0_7.RESOURCE_FIELD.full_name = ".sgland.UnionMessage.resource"
var_0_7.RESOURCE_FIELD.number = 5
var_0_7.RESOURCE_FIELD.index = 4
var_0_7.RESOURCE_FIELD.label = 3
var_0_7.RESOURCE_FIELD.has_default_value = false
var_0_7.RESOURCE_FIELD.default_value = {}
var_0_7.RESOURCE_FIELD.message_type = var_0_2.RESOURCE
var_0_7.RESOURCE_FIELD.type = 11
var_0_7.RESOURCE_FIELD.cpp_type = 10
var_0_7.LET_FIELD.name = "let"
var_0_7.LET_FIELD.full_name = ".sgland.UnionMessage.let"
var_0_7.LET_FIELD.number = 6
var_0_7.LET_FIELD.index = 5
var_0_7.LET_FIELD.label = 1
var_0_7.LET_FIELD.has_default_value = false
var_0_7.LET_FIELD.default_value = nil
var_0_7.LET_FIELD.message_type = _UNIONLET
var_0_7.LET_FIELD.type = 11
var_0_7.LET_FIELD.cpp_type = 10
var_0_7.USER2_FIELD.name = "user2"
var_0_7.USER2_FIELD.full_name = ".sgland.UnionMessage.user2"
var_0_7.USER2_FIELD.number = 7
var_0_7.USER2_FIELD.index = 6
var_0_7.USER2_FIELD.label = 1
var_0_7.USER2_FIELD.has_default_value = false
var_0_7.USER2_FIELD.default_value = nil
var_0_7.USER2_FIELD.message_type = var_0_2.USERINFO
var_0_7.USER2_FIELD.type = 11
var_0_7.USER2_FIELD.cpp_type = 10
var_0_7.PARAM1_FIELD.name = "param1"
var_0_7.PARAM1_FIELD.full_name = ".sgland.UnionMessage.param1"
var_0_7.PARAM1_FIELD.number = 8
var_0_7.PARAM1_FIELD.index = 7
var_0_7.PARAM1_FIELD.label = 1
var_0_7.PARAM1_FIELD.has_default_value = false
var_0_7.PARAM1_FIELD.default_value = 0
var_0_7.PARAM1_FIELD.type = 5
var_0_7.PARAM1_FIELD.cpp_type = 1
var_0_7.PARAM2_FIELD.name = "param2"
var_0_7.PARAM2_FIELD.full_name = ".sgland.UnionMessage.param2"
var_0_7.PARAM2_FIELD.number = 9
var_0_7.PARAM2_FIELD.index = 8
var_0_7.PARAM2_FIELD.label = 1
var_0_7.PARAM2_FIELD.has_default_value = false
var_0_7.PARAM2_FIELD.default_value = 0
var_0_7.PARAM2_FIELD.type = 5
var_0_7.PARAM2_FIELD.cpp_type = 1
UNIONMESSAGE.name = "UnionMessage"
UNIONMESSAGE.full_name = ".sgland.UnionMessage"
UNIONMESSAGE.nested_types = {}
UNIONMESSAGE.enum_types = {}
UNIONMESSAGE.fields = {
	var_0_7.TYPE_FIELD,
	var_0_7.USER1_FIELD,
	var_0_7.MESSAGE_FIELD,
	var_0_7.TIMESTAMP_FIELD,
	var_0_7.RESOURCE_FIELD,
	var_0_7.LET_FIELD,
	var_0_7.USER2_FIELD,
	var_0_7.PARAM1_FIELD,
	var_0_7.PARAM2_FIELD
}
UNIONMESSAGE.is_extendable = false
UNIONMESSAGE.extensions = {}
var_0_8.ID_FIELD.name = "id"
var_0_8.ID_FIELD.full_name = ".sgland.UnionDonate.id"
var_0_8.ID_FIELD.number = 1
var_0_8.ID_FIELD.index = 0
var_0_8.ID_FIELD.label = 2
var_0_8.ID_FIELD.has_default_value = false
var_0_8.ID_FIELD.default_value = 0
var_0_8.ID_FIELD.type = 3
var_0_8.ID_FIELD.cpp_type = 2
var_0_8.GOLD_FIELD.name = "gold"
var_0_8.GOLD_FIELD.full_name = ".sgland.UnionDonate.gold"
var_0_8.GOLD_FIELD.number = 2
var_0_8.GOLD_FIELD.index = 1
var_0_8.GOLD_FIELD.label = 2
var_0_8.GOLD_FIELD.has_default_value = false
var_0_8.GOLD_FIELD.default_value = 0
var_0_8.GOLD_FIELD.type = 5
var_0_8.GOLD_FIELD.cpp_type = 1
var_0_8.WOOD_FIELD.name = "wood"
var_0_8.WOOD_FIELD.full_name = ".sgland.UnionDonate.wood"
var_0_8.WOOD_FIELD.number = 3
var_0_8.WOOD_FIELD.index = 2
var_0_8.WOOD_FIELD.label = 2
var_0_8.WOOD_FIELD.has_default_value = false
var_0_8.WOOD_FIELD.default_value = 0
var_0_8.WOOD_FIELD.type = 5
var_0_8.WOOD_FIELD.cpp_type = 1
var_0_8.EXP_FIELD.name = "exp"
var_0_8.EXP_FIELD.full_name = ".sgland.UnionDonate.exp"
var_0_8.EXP_FIELD.number = 4
var_0_8.EXP_FIELD.index = 3
var_0_8.EXP_FIELD.label = 1
var_0_8.EXP_FIELD.has_default_value = false
var_0_8.EXP_FIELD.default_value = 0
var_0_8.EXP_FIELD.type = 2
var_0_8.EXP_FIELD.cpp_type = 6
var_0_8.POWER_FIELD.name = "power"
var_0_8.POWER_FIELD.full_name = ".sgland.UnionDonate.power"
var_0_8.POWER_FIELD.number = 5
var_0_8.POWER_FIELD.index = 4
var_0_8.POWER_FIELD.label = 1
var_0_8.POWER_FIELD.has_default_value = false
var_0_8.POWER_FIELD.default_value = 0
var_0_8.POWER_FIELD.type = 5
var_0_8.POWER_FIELD.cpp_type = 1
UNIONDONATE.name = "UnionDonate"
UNIONDONATE.full_name = ".sgland.UnionDonate"
UNIONDONATE.nested_types = {}
UNIONDONATE.enum_types = {}
UNIONDONATE.fields = {
	var_0_8.ID_FIELD,
	var_0_8.GOLD_FIELD,
	var_0_8.WOOD_FIELD,
	var_0_8.EXP_FIELD,
	var_0_8.POWER_FIELD
}
UNIONDONATE.is_extendable = false
UNIONDONATE.extensions = {}
var_0_9.ID_FIELD.name = "id"
var_0_9.ID_FIELD.full_name = ".sgland.UnionDonateEx.id"
var_0_9.ID_FIELD.number = 1
var_0_9.ID_FIELD.index = 0
var_0_9.ID_FIELD.label = 2
var_0_9.ID_FIELD.has_default_value = false
var_0_9.ID_FIELD.default_value = 0
var_0_9.ID_FIELD.type = 3
var_0_9.ID_FIELD.cpp_type = 2
var_0_9.GOLD_FIELD.name = "gold"
var_0_9.GOLD_FIELD.full_name = ".sgland.UnionDonateEx.gold"
var_0_9.GOLD_FIELD.number = 2
var_0_9.GOLD_FIELD.index = 1
var_0_9.GOLD_FIELD.label = 2
var_0_9.GOLD_FIELD.has_default_value = false
var_0_9.GOLD_FIELD.default_value = 0
var_0_9.GOLD_FIELD.type = 5
var_0_9.GOLD_FIELD.cpp_type = 1
var_0_9.WOOD_FIELD.name = "wood"
var_0_9.WOOD_FIELD.full_name = ".sgland.UnionDonateEx.wood"
var_0_9.WOOD_FIELD.number = 3
var_0_9.WOOD_FIELD.index = 2
var_0_9.WOOD_FIELD.label = 2
var_0_9.WOOD_FIELD.has_default_value = false
var_0_9.WOOD_FIELD.default_value = 0
var_0_9.WOOD_FIELD.type = 5
var_0_9.WOOD_FIELD.cpp_type = 1
var_0_9.EXP_FIELD.name = "exp"
var_0_9.EXP_FIELD.full_name = ".sgland.UnionDonateEx.exp"
var_0_9.EXP_FIELD.number = 4
var_0_9.EXP_FIELD.index = 3
var_0_9.EXP_FIELD.label = 1
var_0_9.EXP_FIELD.has_default_value = false
var_0_9.EXP_FIELD.default_value = 0
var_0_9.EXP_FIELD.type = 5
var_0_9.EXP_FIELD.cpp_type = 1
var_0_9.POWER_FIELD.name = "power"
var_0_9.POWER_FIELD.full_name = ".sgland.UnionDonateEx.power"
var_0_9.POWER_FIELD.number = 5
var_0_9.POWER_FIELD.index = 4
var_0_9.POWER_FIELD.label = 1
var_0_9.POWER_FIELD.has_default_value = false
var_0_9.POWER_FIELD.default_value = 0
var_0_9.POWER_FIELD.type = 5
var_0_9.POWER_FIELD.cpp_type = 1
UNIONDONATEEX.name = "UnionDonateEx"
UNIONDONATEEX.full_name = ".sgland.UnionDonateEx"
UNIONDONATEEX.nested_types = {}
UNIONDONATEEX.enum_types = {}
UNIONDONATEEX.fields = {
	var_0_9.ID_FIELD,
	var_0_9.GOLD_FIELD,
	var_0_9.WOOD_FIELD,
	var_0_9.EXP_FIELD,
	var_0_9.POWER_FIELD
}
UNIONDONATEEX.is_extendable = false
UNIONDONATEEX.extensions = {}
var_0_10.ID_FIELD.name = "id"
var_0_10.ID_FIELD.full_name = ".sgland.UnionLet.id"
var_0_10.ID_FIELD.number = 1
var_0_10.ID_FIELD.index = 0
var_0_10.ID_FIELD.label = 2
var_0_10.ID_FIELD.has_default_value = false
var_0_10.ID_FIELD.default_value = ""
var_0_10.ID_FIELD.type = 9
var_0_10.ID_FIELD.cpp_type = 9
var_0_10.OWNER_ID_FIELD.name = "owner_id"
var_0_10.OWNER_ID_FIELD.full_name = ".sgland.UnionLet.owner_id"
var_0_10.OWNER_ID_FIELD.number = 2
var_0_10.OWNER_ID_FIELD.index = 1
var_0_10.OWNER_ID_FIELD.label = 2
var_0_10.OWNER_ID_FIELD.has_default_value = false
var_0_10.OWNER_ID_FIELD.default_value = 0
var_0_10.OWNER_ID_FIELD.type = 3
var_0_10.OWNER_ID_FIELD.cpp_type = 2
var_0_10.CARDS_FIELD.name = "cards"
var_0_10.CARDS_FIELD.full_name = ".sgland.UnionLet.cards"
var_0_10.CARDS_FIELD.number = 3
var_0_10.CARDS_FIELD.index = 2
var_0_10.CARDS_FIELD.label = 3
var_0_10.CARDS_FIELD.has_default_value = false
var_0_10.CARDS_FIELD.default_value = {}
var_0_10.CARDS_FIELD.message_type = var_0_2.RESOURCE
var_0_10.CARDS_FIELD.type = 11
var_0_10.CARDS_FIELD.cpp_type = 10
var_0_10.TIMESTAMP_FIELD.name = "timestamp"
var_0_10.TIMESTAMP_FIELD.full_name = ".sgland.UnionLet.timestamp"
var_0_10.TIMESTAMP_FIELD.number = 4
var_0_10.TIMESTAMP_FIELD.index = 3
var_0_10.TIMESTAMP_FIELD.label = 2
var_0_10.TIMESTAMP_FIELD.has_default_value = false
var_0_10.TIMESTAMP_FIELD.default_value = 0
var_0_10.TIMESTAMP_FIELD.type = 3
var_0_10.TIMESTAMP_FIELD.cpp_type = 2
var_0_10.RENTED_FIELD.name = "rented"
var_0_10.RENTED_FIELD.full_name = ".sgland.UnionLet.rented"
var_0_10.RENTED_FIELD.number = 5
var_0_10.RENTED_FIELD.index = 4
var_0_10.RENTED_FIELD.label = 2
var_0_10.RENTED_FIELD.has_default_value = false
var_0_10.RENTED_FIELD.default_value = 0
var_0_10.RENTED_FIELD.type = 5
var_0_10.RENTED_FIELD.cpp_type = 1
UNIONLET.name = "UnionLet"
UNIONLET.full_name = ".sgland.UnionLet"
UNIONLET.nested_types = {}
UNIONLET.enum_types = {}
UNIONLET.fields = {
	var_0_10.ID_FIELD,
	var_0_10.OWNER_ID_FIELD,
	var_0_10.CARDS_FIELD,
	var_0_10.TIMESTAMP_FIELD,
	var_0_10.RENTED_FIELD
}
UNIONLET.is_extendable = false
UNIONLET.extensions = {}
var_0_11.ID_FIELD.name = "id"
var_0_11.ID_FIELD.full_name = ".sgland.UnionBossScore.id"
var_0_11.ID_FIELD.number = 1
var_0_11.ID_FIELD.index = 0
var_0_11.ID_FIELD.label = 2
var_0_11.ID_FIELD.has_default_value = false
var_0_11.ID_FIELD.default_value = 0
var_0_11.ID_FIELD.type = 3
var_0_11.ID_FIELD.cpp_type = 2
var_0_11.SCORE_FIELD.name = "score"
var_0_11.SCORE_FIELD.full_name = ".sgland.UnionBossScore.score"
var_0_11.SCORE_FIELD.number = 2
var_0_11.SCORE_FIELD.index = 1
var_0_11.SCORE_FIELD.label = 2
var_0_11.SCORE_FIELD.has_default_value = false
var_0_11.SCORE_FIELD.default_value = 0
var_0_11.SCORE_FIELD.type = 5
var_0_11.SCORE_FIELD.cpp_type = 1
var_0_11.COUNT_FIELD.name = "count"
var_0_11.COUNT_FIELD.full_name = ".sgland.UnionBossScore.count"
var_0_11.COUNT_FIELD.number = 3
var_0_11.COUNT_FIELD.index = 2
var_0_11.COUNT_FIELD.label = 1
var_0_11.COUNT_FIELD.has_default_value = false
var_0_11.COUNT_FIELD.default_value = 0
var_0_11.COUNT_FIELD.type = 5
var_0_11.COUNT_FIELD.cpp_type = 1
UNIONBOSSSCORE.name = "UnionBossScore"
UNIONBOSSSCORE.full_name = ".sgland.UnionBossScore"
UNIONBOSSSCORE.nested_types = {}
UNIONBOSSSCORE.enum_types = {}
UNIONBOSSSCORE.fields = {
	var_0_11.ID_FIELD,
	var_0_11.SCORE_FIELD,
	var_0_11.COUNT_FIELD
}
UNIONBOSSSCORE.is_extendable = false
UNIONBOSSSCORE.extensions = {}
var_0_12.ID_FIELD.name = "id"
var_0_12.ID_FIELD.full_name = ".sgland.UnionBoss.id"
var_0_12.ID_FIELD.number = 1
var_0_12.ID_FIELD.index = 0
var_0_12.ID_FIELD.label = 2
var_0_12.ID_FIELD.has_default_value = false
var_0_12.ID_FIELD.default_value = 0
var_0_12.ID_FIELD.type = 5
var_0_12.ID_FIELD.cpp_type = 1
var_0_12.HP_FIELD.name = "hp"
var_0_12.HP_FIELD.full_name = ".sgland.UnionBoss.hp"
var_0_12.HP_FIELD.number = 2
var_0_12.HP_FIELD.index = 1
var_0_12.HP_FIELD.label = 2
var_0_12.HP_FIELD.has_default_value = false
var_0_12.HP_FIELD.default_value = 0
var_0_12.HP_FIELD.type = 5
var_0_12.HP_FIELD.cpp_type = 1
var_0_12.START_TIME_FIELD.name = "start_time"
var_0_12.START_TIME_FIELD.full_name = ".sgland.UnionBoss.start_time"
var_0_12.START_TIME_FIELD.number = 3
var_0_12.START_TIME_FIELD.index = 2
var_0_12.START_TIME_FIELD.label = 2
var_0_12.START_TIME_FIELD.has_default_value = false
var_0_12.START_TIME_FIELD.default_value = 0
var_0_12.START_TIME_FIELD.type = 3
var_0_12.START_TIME_FIELD.cpp_type = 2
var_0_12.END_TIME_FIELD.name = "end_time"
var_0_12.END_TIME_FIELD.full_name = ".sgland.UnionBoss.end_time"
var_0_12.END_TIME_FIELD.number = 4
var_0_12.END_TIME_FIELD.index = 3
var_0_12.END_TIME_FIELD.label = 2
var_0_12.END_TIME_FIELD.has_default_value = false
var_0_12.END_TIME_FIELD.default_value = 0
var_0_12.END_TIME_FIELD.type = 3
var_0_12.END_TIME_FIELD.cpp_type = 2
var_0_12.KILLED_COUNT_FIELD.name = "killed_count"
var_0_12.KILLED_COUNT_FIELD.full_name = ".sgland.UnionBoss.killed_count"
var_0_12.KILLED_COUNT_FIELD.number = 5
var_0_12.KILLED_COUNT_FIELD.index = 4
var_0_12.KILLED_COUNT_FIELD.label = 2
var_0_12.KILLED_COUNT_FIELD.has_default_value = false
var_0_12.KILLED_COUNT_FIELD.default_value = 0
var_0_12.KILLED_COUNT_FIELD.type = 5
var_0_12.KILLED_COUNT_FIELD.cpp_type = 1
var_0_12.SCORE_FIELD.name = "score"
var_0_12.SCORE_FIELD.full_name = ".sgland.UnionBoss.score"
var_0_12.SCORE_FIELD.number = 6
var_0_12.SCORE_FIELD.index = 5
var_0_12.SCORE_FIELD.label = 3
var_0_12.SCORE_FIELD.has_default_value = false
var_0_12.SCORE_FIELD.default_value = {}
var_0_12.SCORE_FIELD.message_type = UNIONBOSSSCORE
var_0_12.SCORE_FIELD.type = 11
var_0_12.SCORE_FIELD.cpp_type = 10
var_0_12.ASSISTANT_FIELD.name = "assistant"
var_0_12.ASSISTANT_FIELD.full_name = ".sgland.UnionBoss.assistant"
var_0_12.ASSISTANT_FIELD.number = 7
var_0_12.ASSISTANT_FIELD.index = 6
var_0_12.ASSISTANT_FIELD.label = 3
var_0_12.ASSISTANT_FIELD.has_default_value = false
var_0_12.ASSISTANT_FIELD.default_value = {}
var_0_12.ASSISTANT_FIELD.type = 5
var_0_12.ASSISTANT_FIELD.cpp_type = 1
UNIONBOSS.name = "UnionBoss"
UNIONBOSS.full_name = ".sgland.UnionBoss"
UNIONBOSS.nested_types = {}
UNIONBOSS.enum_types = {}
UNIONBOSS.fields = {
	var_0_12.ID_FIELD,
	var_0_12.HP_FIELD,
	var_0_12.START_TIME_FIELD,
	var_0_12.END_TIME_FIELD,
	var_0_12.KILLED_COUNT_FIELD,
	var_0_12.SCORE_FIELD,
	var_0_12.ASSISTANT_FIELD
}
UNIONBOSS.is_extendable = false
UNIONBOSS.extensions = {}
var_0_13.MESSAGES_FIELD.name = "messages"
var_0_13.MESSAGES_FIELD.full_name = ".sgland.UnionData.messages"
var_0_13.MESSAGES_FIELD.number = 1
var_0_13.MESSAGES_FIELD.index = 0
var_0_13.MESSAGES_FIELD.label = 3
var_0_13.MESSAGES_FIELD.has_default_value = false
var_0_13.MESSAGES_FIELD.default_value = {}
var_0_13.MESSAGES_FIELD.message_type = UNIONMESSAGE
var_0_13.MESSAGES_FIELD.type = 11
var_0_13.MESSAGES_FIELD.cpp_type = 10
var_0_13.WEEKLY_DONATES_FIELD.name = "weekly_donates"
var_0_13.WEEKLY_DONATES_FIELD.full_name = ".sgland.UnionData.weekly_donates"
var_0_13.WEEKLY_DONATES_FIELD.number = 2
var_0_13.WEEKLY_DONATES_FIELD.index = 1
var_0_13.WEEKLY_DONATES_FIELD.label = 3
var_0_13.WEEKLY_DONATES_FIELD.has_default_value = false
var_0_13.WEEKLY_DONATES_FIELD.default_value = {}
var_0_13.WEEKLY_DONATES_FIELD.message_type = UNIONDONATE
var_0_13.WEEKLY_DONATES_FIELD.type = 11
var_0_13.WEEKLY_DONATES_FIELD.cpp_type = 10
var_0_13.LETS_FIELD.name = "lets"
var_0_13.LETS_FIELD.full_name = ".sgland.UnionData.lets"
var_0_13.LETS_FIELD.number = 3
var_0_13.LETS_FIELD.index = 2
var_0_13.LETS_FIELD.label = 3
var_0_13.LETS_FIELD.has_default_value = false
var_0_13.LETS_FIELD.default_value = {}
var_0_13.LETS_FIELD.message_type = UNIONLET
var_0_13.LETS_FIELD.type = 11
var_0_13.LETS_FIELD.cpp_type = 10
var_0_13.CHATS_FIELD.name = "chats"
var_0_13.CHATS_FIELD.full_name = ".sgland.UnionData.chats"
var_0_13.CHATS_FIELD.number = 4
var_0_13.CHATS_FIELD.index = 3
var_0_13.CHATS_FIELD.label = 3
var_0_13.CHATS_FIELD.has_default_value = false
var_0_13.CHATS_FIELD.default_value = {}
var_0_13.CHATS_FIELD.message_type = UNIONMESSAGE
var_0_13.CHATS_FIELD.type = 11
var_0_13.CHATS_FIELD.cpp_type = 10
var_0_13.DAILY_DONATES_FIELD.name = "daily_donates"
var_0_13.DAILY_DONATES_FIELD.full_name = ".sgland.UnionData.daily_donates"
var_0_13.DAILY_DONATES_FIELD.number = 5
var_0_13.DAILY_DONATES_FIELD.index = 4
var_0_13.DAILY_DONATES_FIELD.label = 3
var_0_13.DAILY_DONATES_FIELD.has_default_value = false
var_0_13.DAILY_DONATES_FIELD.default_value = {}
var_0_13.DAILY_DONATES_FIELD.message_type = UNIONDONATE
var_0_13.DAILY_DONATES_FIELD.type = 11
var_0_13.DAILY_DONATES_FIELD.cpp_type = 10
var_0_13.IMPEACHES_FIELD.name = "impeaches"
var_0_13.IMPEACHES_FIELD.full_name = ".sgland.UnionData.impeaches"
var_0_13.IMPEACHES_FIELD.number = 6
var_0_13.IMPEACHES_FIELD.index = 5
var_0_13.IMPEACHES_FIELD.label = 3
var_0_13.IMPEACHES_FIELD.has_default_value = false
var_0_13.IMPEACHES_FIELD.default_value = {}
var_0_13.IMPEACHES_FIELD.type = 3
var_0_13.IMPEACHES_FIELD.cpp_type = 2
UNIONDATA.name = "UnionData"
UNIONDATA.full_name = ".sgland.UnionData"
UNIONDATA.nested_types = {}
UNIONDATA.enum_types = {}
UNIONDATA.fields = {
	var_0_13.MESSAGES_FIELD,
	var_0_13.WEEKLY_DONATES_FIELD,
	var_0_13.LETS_FIELD,
	var_0_13.CHATS_FIELD,
	var_0_13.DAILY_DONATES_FIELD,
	var_0_13.IMPEACHES_FIELD
}
UNIONDATA.is_extendable = false
UNIONDATA.extensions = {}
var_0_14.BOSSES_FIELD.name = "bosses"
var_0_14.BOSSES_FIELD.full_name = ".sgland.UnionDataEx.bosses"
var_0_14.BOSSES_FIELD.number = 1
var_0_14.BOSSES_FIELD.index = 0
var_0_14.BOSSES_FIELD.label = 3
var_0_14.BOSSES_FIELD.has_default_value = false
var_0_14.BOSSES_FIELD.default_value = {}
var_0_14.BOSSES_FIELD.message_type = UNIONBOSS
var_0_14.BOSSES_FIELD.type = 11
var_0_14.BOSSES_FIELD.cpp_type = 10
var_0_14.TECHS_FIELD.name = "techs"
var_0_14.TECHS_FIELD.full_name = ".sgland.UnionDataEx.techs"
var_0_14.TECHS_FIELD.number = 2
var_0_14.TECHS_FIELD.index = 1
var_0_14.TECHS_FIELD.label = 3
var_0_14.TECHS_FIELD.has_default_value = false
var_0_14.TECHS_FIELD.default_value = {}
var_0_14.TECHS_FIELD.message_type = var_0_2.TECH
var_0_14.TECHS_FIELD.type = 11
var_0_14.TECHS_FIELD.cpp_type = 10
var_0_14.PROPS_FIELD.name = "props"
var_0_14.PROPS_FIELD.full_name = ".sgland.UnionDataEx.props"
var_0_14.PROPS_FIELD.number = 3
var_0_14.PROPS_FIELD.index = 2
var_0_14.PROPS_FIELD.label = 3
var_0_14.PROPS_FIELD.has_default_value = false
var_0_14.PROPS_FIELD.default_value = {}
var_0_14.PROPS_FIELD.message_type = var_0_2.RESOURCE
var_0_14.PROPS_FIELD.type = 11
var_0_14.PROPS_FIELD.cpp_type = 10
var_0_14.TEAMS_FIELD.name = "teams"
var_0_14.TEAMS_FIELD.full_name = ".sgland.UnionDataEx.teams"
var_0_14.TEAMS_FIELD.number = 4
var_0_14.TEAMS_FIELD.index = 3
var_0_14.TEAMS_FIELD.label = 3
var_0_14.TEAMS_FIELD.has_default_value = false
var_0_14.TEAMS_FIELD.default_value = {}
var_0_14.TEAMS_FIELD.message_type = var_0_2.FULLTEAM
var_0_14.TEAMS_FIELD.type = 11
var_0_14.TEAMS_FIELD.cpp_type = 10
UNIONDATAEX.name = "UnionDataEx"
UNIONDATAEX.full_name = ".sgland.UnionDataEx"
UNIONDATAEX.nested_types = {}
UNIONDATAEX.enum_types = {}
UNIONDATAEX.fields = {
	var_0_14.BOSSES_FIELD,
	var_0_14.TECHS_FIELD,
	var_0_14.PROPS_FIELD,
	var_0_14.TEAMS_FIELD
}
UNIONDATAEX.is_extendable = false
UNIONDATAEX.extensions = {}
var_0_15.NAME_FIELD.name = "name"
var_0_15.NAME_FIELD.full_name = ".sgland.UnionEdit.name"
var_0_15.NAME_FIELD.number = 1
var_0_15.NAME_FIELD.index = 0
var_0_15.NAME_FIELD.label = 2
var_0_15.NAME_FIELD.has_default_value = false
var_0_15.NAME_FIELD.default_value = ""
var_0_15.NAME_FIELD.type = 9
var_0_15.NAME_FIELD.cpp_type = 9
var_0_15.AVATAR_FIELD.name = "avatar"
var_0_15.AVATAR_FIELD.full_name = ".sgland.UnionEdit.avatar"
var_0_15.AVATAR_FIELD.number = 2
var_0_15.AVATAR_FIELD.index = 1
var_0_15.AVATAR_FIELD.label = 2
var_0_15.AVATAR_FIELD.has_default_value = false
var_0_15.AVATAR_FIELD.default_value = 0
var_0_15.AVATAR_FIELD.type = 5
var_0_15.AVATAR_FIELD.cpp_type = 1
var_0_15.ANNOUNCEMENT_FIELD.name = "announcement"
var_0_15.ANNOUNCEMENT_FIELD.full_name = ".sgland.UnionEdit.announcement"
var_0_15.ANNOUNCEMENT_FIELD.number = 3
var_0_15.ANNOUNCEMENT_FIELD.index = 2
var_0_15.ANNOUNCEMENT_FIELD.label = 2
var_0_15.ANNOUNCEMENT_FIELD.has_default_value = false
var_0_15.ANNOUNCEMENT_FIELD.default_value = ""
var_0_15.ANNOUNCEMENT_FIELD.type = 9
var_0_15.ANNOUNCEMENT_FIELD.cpp_type = 9
var_0_15.TAG_FIELD.name = "tag"
var_0_15.TAG_FIELD.full_name = ".sgland.UnionEdit.tag"
var_0_15.TAG_FIELD.number = 4
var_0_15.TAG_FIELD.index = 3
var_0_15.TAG_FIELD.label = 2
var_0_15.TAG_FIELD.has_default_value = false
var_0_15.TAG_FIELD.default_value = ""
var_0_15.TAG_FIELD.type = 9
var_0_15.TAG_FIELD.cpp_type = 9
var_0_15.TYPE_FIELD.name = "type"
var_0_15.TYPE_FIELD.full_name = ".sgland.UnionEdit.type"
var_0_15.TYPE_FIELD.number = 5
var_0_15.TYPE_FIELD.index = 4
var_0_15.TYPE_FIELD.label = 2
var_0_15.TYPE_FIELD.has_default_value = false
var_0_15.TYPE_FIELD.default_value = nil
var_0_15.TYPE_FIELD.enum_type = UNIONTYPE
var_0_15.TYPE_FIELD.type = 14
var_0_15.TYPE_FIELD.cpp_type = 8
var_0_15.REQUIRED_LEVEL_FIELD.name = "required_level"
var_0_15.REQUIRED_LEVEL_FIELD.full_name = ".sgland.UnionEdit.required_level"
var_0_15.REQUIRED_LEVEL_FIELD.number = 6
var_0_15.REQUIRED_LEVEL_FIELD.index = 5
var_0_15.REQUIRED_LEVEL_FIELD.label = 2
var_0_15.REQUIRED_LEVEL_FIELD.has_default_value = false
var_0_15.REQUIRED_LEVEL_FIELD.default_value = 0
var_0_15.REQUIRED_LEVEL_FIELD.type = 5
var_0_15.REQUIRED_LEVEL_FIELD.cpp_type = 1
UNIONEDIT.name = "UnionEdit"
UNIONEDIT.full_name = ".sgland.UnionEdit"
UNIONEDIT.nested_types = {}
UNIONEDIT.enum_types = {}
UNIONEDIT.fields = {
	var_0_15.NAME_FIELD,
	var_0_15.AVATAR_FIELD,
	var_0_15.ANNOUNCEMENT_FIELD,
	var_0_15.TAG_FIELD,
	var_0_15.TYPE_FIELD,
	var_0_15.REQUIRED_LEVEL_FIELD
}
UNIONEDIT.is_extendable = false
UNIONEDIT.extensions = {}
var_0_16.INFO_FIELD.name = "info"
var_0_16.INFO_FIELD.full_name = ".sgland.UnionBossFocus.info"
var_0_16.INFO_FIELD.number = 1
var_0_16.INFO_FIELD.index = 0
var_0_16.INFO_FIELD.label = 2
var_0_16.INFO_FIELD.has_default_value = false
var_0_16.INFO_FIELD.default_value = nil
var_0_16.INFO_FIELD.message_type = var_0_2.USERINFO
var_0_16.INFO_FIELD.type = 11
var_0_16.INFO_FIELD.cpp_type = 10
var_0_16.ID_FIELD.name = "id"
var_0_16.ID_FIELD.full_name = ".sgland.UnionBossFocus.id"
var_0_16.ID_FIELD.number = 2
var_0_16.ID_FIELD.index = 1
var_0_16.ID_FIELD.label = 2
var_0_16.ID_FIELD.has_default_value = false
var_0_16.ID_FIELD.default_value = 0
var_0_16.ID_FIELD.type = 5
var_0_16.ID_FIELD.cpp_type = 1
UNIONBOSSFOCUS.name = "UnionBossFocus"
UNIONBOSSFOCUS.full_name = ".sgland.UnionBossFocus"
UNIONBOSSFOCUS.nested_types = {}
UNIONBOSSFOCUS.enum_types = {}
UNIONBOSSFOCUS.fields = {
	var_0_16.INFO_FIELD,
	var_0_16.ID_FIELD
}
UNIONBOSSFOCUS.is_extendable = false
UNIONBOSSFOCUS.extensions = {}
var_0_17.ID_FIELD.name = "id"
var_0_17.ID_FIELD.full_name = ".sgland.UnionInviteReq.id"
var_0_17.ID_FIELD.number = 1
var_0_17.ID_FIELD.index = 0
var_0_17.ID_FIELD.label = 2
var_0_17.ID_FIELD.has_default_value = false
var_0_17.ID_FIELD.default_value = 0
var_0_17.ID_FIELD.type = 3
var_0_17.ID_FIELD.cpp_type = 2
var_0_17.MESSAGE_FIELD.name = "message"
var_0_17.MESSAGE_FIELD.full_name = ".sgland.UnionInviteReq.message"
var_0_17.MESSAGE_FIELD.number = 2
var_0_17.MESSAGE_FIELD.index = 1
var_0_17.MESSAGE_FIELD.label = 1
var_0_17.MESSAGE_FIELD.has_default_value = false
var_0_17.MESSAGE_FIELD.default_value = ""
var_0_17.MESSAGE_FIELD.type = 9
var_0_17.MESSAGE_FIELD.cpp_type = 9
UNIONINVITEREQ.name = "UnionInviteReq"
UNIONINVITEREQ.full_name = ".sgland.UnionInviteReq"
UNIONINVITEREQ.nested_types = {}
UNIONINVITEREQ.enum_types = {}
UNIONINVITEREQ.fields = {
	var_0_17.ID_FIELD,
	var_0_17.MESSAGE_FIELD
}
UNIONINVITEREQ.is_extendable = false
UNIONINVITEREQ.extensions = {}
var_0_18.USER_INFO_FIELD.name = "user_info"
var_0_18.USER_INFO_FIELD.full_name = ".sgland.MemberInfo.user_info"
var_0_18.USER_INFO_FIELD.number = 1
var_0_18.USER_INFO_FIELD.index = 0
var_0_18.USER_INFO_FIELD.label = 2
var_0_18.USER_INFO_FIELD.has_default_value = false
var_0_18.USER_INFO_FIELD.default_value = nil
var_0_18.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_18.USER_INFO_FIELD.type = 11
var_0_18.USER_INFO_FIELD.cpp_type = 10
var_0_18.BADGE_LEVEL_FIELD.name = "badge_level"
var_0_18.BADGE_LEVEL_FIELD.full_name = ".sgland.MemberInfo.badge_level"
var_0_18.BADGE_LEVEL_FIELD.number = 2
var_0_18.BADGE_LEVEL_FIELD.index = 1
var_0_18.BADGE_LEVEL_FIELD.label = 1
var_0_18.BADGE_LEVEL_FIELD.has_default_value = false
var_0_18.BADGE_LEVEL_FIELD.default_value = 0
var_0_18.BADGE_LEVEL_FIELD.type = 5
var_0_18.BADGE_LEVEL_FIELD.cpp_type = 1
var_0_18.BADGE_PURCHASED_FIELD.name = "badge_purchased"
var_0_18.BADGE_PURCHASED_FIELD.full_name = ".sgland.MemberInfo.badge_purchased"
var_0_18.BADGE_PURCHASED_FIELD.number = 3
var_0_18.BADGE_PURCHASED_FIELD.index = 2
var_0_18.BADGE_PURCHASED_FIELD.label = 1
var_0_18.BADGE_PURCHASED_FIELD.has_default_value = false
var_0_18.BADGE_PURCHASED_FIELD.default_value = false
var_0_18.BADGE_PURCHASED_FIELD.type = 8
var_0_18.BADGE_PURCHASED_FIELD.cpp_type = 7
var_0_18.EXP_DONATE_FIELD.name = "exp_donate"
var_0_18.EXP_DONATE_FIELD.full_name = ".sgland.MemberInfo.exp_donate"
var_0_18.EXP_DONATE_FIELD.number = 4
var_0_18.EXP_DONATE_FIELD.index = 3
var_0_18.EXP_DONATE_FIELD.label = 1
var_0_18.EXP_DONATE_FIELD.has_default_value = false
var_0_18.EXP_DONATE_FIELD.default_value = 0
var_0_18.EXP_DONATE_FIELD.type = 5
var_0_18.EXP_DONATE_FIELD.cpp_type = 1
MEMBERINFO.name = "MemberInfo"
MEMBERINFO.full_name = ".sgland.MemberInfo"
MEMBERINFO.nested_types = {}
MEMBERINFO.enum_types = {}
MEMBERINFO.fields = {
	var_0_18.USER_INFO_FIELD,
	var_0_18.BADGE_LEVEL_FIELD,
	var_0_18.BADGE_PURCHASED_FIELD,
	var_0_18.EXP_DONATE_FIELD
}
MEMBERINFO.is_extendable = false
MEMBERINFO.extensions = {}
var_0_19.UNION_INFO_FIELD.name = "union_info"
var_0_19.UNION_INFO_FIELD.full_name = ".sgland.UnionDetail.union_info"
var_0_19.UNION_INFO_FIELD.number = 1
var_0_19.UNION_INFO_FIELD.index = 0
var_0_19.UNION_INFO_FIELD.label = 2
var_0_19.UNION_INFO_FIELD.has_default_value = false
var_0_19.UNION_INFO_FIELD.default_value = nil
var_0_19.UNION_INFO_FIELD.message_type = FULLUNIONINFO
var_0_19.UNION_INFO_FIELD.type = 11
var_0_19.UNION_INFO_FIELD.cpp_type = 10
var_0_19.MEMBER_INFO_FIELD.name = "member_info"
var_0_19.MEMBER_INFO_FIELD.full_name = ".sgland.UnionDetail.member_info"
var_0_19.MEMBER_INFO_FIELD.number = 2
var_0_19.MEMBER_INFO_FIELD.index = 1
var_0_19.MEMBER_INFO_FIELD.label = 3
var_0_19.MEMBER_INFO_FIELD.has_default_value = false
var_0_19.MEMBER_INFO_FIELD.default_value = {}
var_0_19.MEMBER_INFO_FIELD.message_type = MEMBERINFO
var_0_19.MEMBER_INFO_FIELD.type = 11
var_0_19.MEMBER_INFO_FIELD.cpp_type = 10
UNIONDETAIL.name = "UnionDetail"
UNIONDETAIL.full_name = ".sgland.UnionDetail"
UNIONDETAIL.nested_types = {}
UNIONDETAIL.enum_types = {}
UNIONDETAIL.fields = {
	var_0_19.UNION_INFO_FIELD,
	var_0_19.MEMBER_INFO_FIELD
}
UNIONDETAIL.is_extendable = false
UNIONDETAIL.extensions = {}
var_0_20.ID_FIELD.name = "id"
var_0_20.ID_FIELD.full_name = ".sgland.UnionApplyReq.id"
var_0_20.ID_FIELD.number = 1
var_0_20.ID_FIELD.index = 0
var_0_20.ID_FIELD.label = 2
var_0_20.ID_FIELD.has_default_value = false
var_0_20.ID_FIELD.default_value = 0
var_0_20.ID_FIELD.type = 3
var_0_20.ID_FIELD.cpp_type = 2
var_0_20.MESSAGE_FIELD.name = "message"
var_0_20.MESSAGE_FIELD.full_name = ".sgland.UnionApplyReq.message"
var_0_20.MESSAGE_FIELD.number = 2
var_0_20.MESSAGE_FIELD.index = 1
var_0_20.MESSAGE_FIELD.label = 1
var_0_20.MESSAGE_FIELD.has_default_value = false
var_0_20.MESSAGE_FIELD.default_value = ""
var_0_20.MESSAGE_FIELD.type = 9
var_0_20.MESSAGE_FIELD.cpp_type = 9
UNIONAPPLYREQ.name = "UnionApplyReq"
UNIONAPPLYREQ.full_name = ".sgland.UnionApplyReq"
UNIONAPPLYREQ.nested_types = {}
UNIONAPPLYREQ.enum_types = {}
UNIONAPPLYREQ.fields = {
	var_0_20.ID_FIELD,
	var_0_20.MESSAGE_FIELD
}
UNIONAPPLYREQ.is_extendable = false
UNIONAPPLYREQ.extensions = {}
var_0_21.ID_FIELD.name = "id"
var_0_21.ID_FIELD.full_name = ".sgland.UnionAcceptReq.id"
var_0_21.ID_FIELD.number = 1
var_0_21.ID_FIELD.index = 0
var_0_21.ID_FIELD.label = 2
var_0_21.ID_FIELD.has_default_value = false
var_0_21.ID_FIELD.default_value = 0
var_0_21.ID_FIELD.type = 3
var_0_21.ID_FIELD.cpp_type = 2
var_0_21.IS_ACCEPT_FIELD.name = "is_accept"
var_0_21.IS_ACCEPT_FIELD.full_name = ".sgland.UnionAcceptReq.is_accept"
var_0_21.IS_ACCEPT_FIELD.number = 2
var_0_21.IS_ACCEPT_FIELD.index = 1
var_0_21.IS_ACCEPT_FIELD.label = 2
var_0_21.IS_ACCEPT_FIELD.has_default_value = false
var_0_21.IS_ACCEPT_FIELD.default_value = false
var_0_21.IS_ACCEPT_FIELD.type = 8
var_0_21.IS_ACCEPT_FIELD.cpp_type = 7
var_0_21.CONTENT_FIELD.name = "content"
var_0_21.CONTENT_FIELD.full_name = ".sgland.UnionAcceptReq.content"
var_0_21.CONTENT_FIELD.number = 3
var_0_21.CONTENT_FIELD.index = 2
var_0_21.CONTENT_FIELD.label = 1
var_0_21.CONTENT_FIELD.has_default_value = false
var_0_21.CONTENT_FIELD.default_value = ""
var_0_21.CONTENT_FIELD.type = 9
var_0_21.CONTENT_FIELD.cpp_type = 9
UNIONACCEPTREQ.name = "UnionAcceptReq"
UNIONACCEPTREQ.full_name = ".sgland.UnionAcceptReq"
UNIONACCEPTREQ.nested_types = {}
UNIONACCEPTREQ.enum_types = {}
UNIONACCEPTREQ.fields = {
	var_0_21.ID_FIELD,
	var_0_21.IS_ACCEPT_FIELD,
	var_0_21.CONTENT_FIELD
}
UNIONACCEPTREQ.is_extendable = false
UNIONACCEPTREQ.extensions = {}
var_0_22.DONATE_TYPE_FIELD.name = "donate_type"
var_0_22.DONATE_TYPE_FIELD.full_name = ".sgland.UnionDonateReq.donate_type"
var_0_22.DONATE_TYPE_FIELD.number = 1
var_0_22.DONATE_TYPE_FIELD.index = 0
var_0_22.DONATE_TYPE_FIELD.label = 2
var_0_22.DONATE_TYPE_FIELD.has_default_value = false
var_0_22.DONATE_TYPE_FIELD.default_value = 0
var_0_22.DONATE_TYPE_FIELD.type = 5
var_0_22.DONATE_TYPE_FIELD.cpp_type = 1
var_0_22.GRADE_FIELD.name = "grade"
var_0_22.GRADE_FIELD.full_name = ".sgland.UnionDonateReq.grade"
var_0_22.GRADE_FIELD.number = 2
var_0_22.GRADE_FIELD.index = 1
var_0_22.GRADE_FIELD.label = 2
var_0_22.GRADE_FIELD.has_default_value = false
var_0_22.GRADE_FIELD.default_value = 0
var_0_22.GRADE_FIELD.type = 5
var_0_22.GRADE_FIELD.cpp_type = 1
UNIONDONATEREQ.name = "UnionDonateReq"
UNIONDONATEREQ.full_name = ".sgland.UnionDonateReq"
UNIONDONATEREQ.nested_types = {}
UNIONDONATEREQ.enum_types = {}
UNIONDONATEREQ.fields = {
	var_0_22.DONATE_TYPE_FIELD,
	var_0_22.GRADE_FIELD
}
UNIONDONATEREQ.is_extendable = false
UNIONDONATEREQ.extensions = {}
var_0_23.ID_FIELD.name = "id"
var_0_23.ID_FIELD.full_name = ".sgland.UnionWorshipReq.id"
var_0_23.ID_FIELD.number = 1
var_0_23.ID_FIELD.index = 0
var_0_23.ID_FIELD.label = 2
var_0_23.ID_FIELD.has_default_value = false
var_0_23.ID_FIELD.default_value = 0
var_0_23.ID_FIELD.type = 3
var_0_23.ID_FIELD.cpp_type = 2
var_0_23.GRADE_FIELD.name = "grade"
var_0_23.GRADE_FIELD.full_name = ".sgland.UnionWorshipReq.grade"
var_0_23.GRADE_FIELD.number = 2
var_0_23.GRADE_FIELD.index = 1
var_0_23.GRADE_FIELD.label = 2
var_0_23.GRADE_FIELD.has_default_value = false
var_0_23.GRADE_FIELD.default_value = 0
var_0_23.GRADE_FIELD.type = 5
var_0_23.GRADE_FIELD.cpp_type = 1
UNIONWORSHIPREQ.name = "UnionWorshipReq"
UNIONWORSHIPREQ.full_name = ".sgland.UnionWorshipReq"
UNIONWORSHIPREQ.nested_types = {}
UNIONWORSHIPREQ.enum_types = {}
UNIONWORSHIPREQ.fields = {
	var_0_23.ID_FIELD,
	var_0_23.GRADE_FIELD
}
UNIONWORSHIPREQ.is_extendable = false
UNIONWORSHIPREQ.extensions = {}
var_0_24.ID_FIELD.name = "id"
var_0_24.ID_FIELD.full_name = ".sgland.UnionCollectReq.id"
var_0_24.ID_FIELD.number = 1
var_0_24.ID_FIELD.index = 0
var_0_24.ID_FIELD.label = 3
var_0_24.ID_FIELD.has_default_value = false
var_0_24.ID_FIELD.default_value = {}
var_0_24.ID_FIELD.type = 5
var_0_24.ID_FIELD.cpp_type = 1
var_0_24.INFO_ID_FIELD.name = "info_id"
var_0_24.INFO_ID_FIELD.full_name = ".sgland.UnionCollectReq.info_id"
var_0_24.INFO_ID_FIELD.number = 2
var_0_24.INFO_ID_FIELD.index = 1
var_0_24.INFO_ID_FIELD.label = 2
var_0_24.INFO_ID_FIELD.has_default_value = false
var_0_24.INFO_ID_FIELD.default_value = 0
var_0_24.INFO_ID_FIELD.type = 5
var_0_24.INFO_ID_FIELD.cpp_type = 1
var_0_24.NUM_FIELD.name = "num"
var_0_24.NUM_FIELD.full_name = ".sgland.UnionCollectReq.num"
var_0_24.NUM_FIELD.number = 3
var_0_24.NUM_FIELD.index = 2
var_0_24.NUM_FIELD.label = 1
var_0_24.NUM_FIELD.has_default_value = false
var_0_24.NUM_FIELD.default_value = 0
var_0_24.NUM_FIELD.type = 5
var_0_24.NUM_FIELD.cpp_type = 1
UNIONCOLLECTREQ.name = "UnionCollectReq"
UNIONCOLLECTREQ.full_name = ".sgland.UnionCollectReq"
UNIONCOLLECTREQ.nested_types = {}
UNIONCOLLECTREQ.enum_types = {}
UNIONCOLLECTREQ.fields = {
	var_0_24.ID_FIELD,
	var_0_24.INFO_ID_FIELD,
	var_0_24.NUM_FIELD
}
UNIONCOLLECTREQ.is_extendable = false
UNIONCOLLECTREQ.extensions = {}
var_0_25.NAME_FIELD.name = "name"
var_0_25.NAME_FIELD.full_name = ".sgland.UnionSearchReq.name"
var_0_25.NAME_FIELD.number = 1
var_0_25.NAME_FIELD.index = 0
var_0_25.NAME_FIELD.label = 1
var_0_25.NAME_FIELD.has_default_value = false
var_0_25.NAME_FIELD.default_value = ""
var_0_25.NAME_FIELD.type = 9
var_0_25.NAME_FIELD.cpp_type = 9
var_0_25.LEVEL_FIELD.name = "level"
var_0_25.LEVEL_FIELD.full_name = ".sgland.UnionSearchReq.level"
var_0_25.LEVEL_FIELD.number = 2
var_0_25.LEVEL_FIELD.index = 1
var_0_25.LEVEL_FIELD.label = 1
var_0_25.LEVEL_FIELD.has_default_value = false
var_0_25.LEVEL_FIELD.default_value = 0
var_0_25.LEVEL_FIELD.type = 5
var_0_25.LEVEL_FIELD.cpp_type = 1
var_0_25.ID_FIELD.name = "id"
var_0_25.ID_FIELD.full_name = ".sgland.UnionSearchReq.id"
var_0_25.ID_FIELD.number = 3
var_0_25.ID_FIELD.index = 2
var_0_25.ID_FIELD.label = 1
var_0_25.ID_FIELD.has_default_value = false
var_0_25.ID_FIELD.default_value = 0
var_0_25.ID_FIELD.type = 5
var_0_25.ID_FIELD.cpp_type = 1
UNIONSEARCHREQ.name = "UnionSearchReq"
UNIONSEARCHREQ.full_name = ".sgland.UnionSearchReq"
UNIONSEARCHREQ.nested_types = {}
UNIONSEARCHREQ.enum_types = {}
UNIONSEARCHREQ.fields = {
	var_0_25.NAME_FIELD,
	var_0_25.LEVEL_FIELD,
	var_0_25.ID_FIELD
}
UNIONSEARCHREQ.is_extendable = false
UNIONSEARCHREQ.extensions = {}
var_0_26.DETAIL_FIELD.name = "detail"
var_0_26.DETAIL_FIELD.full_name = ".sgland.UnionMineResp.detail"
var_0_26.DETAIL_FIELD.number = 1
var_0_26.DETAIL_FIELD.index = 0
var_0_26.DETAIL_FIELD.label = 2
var_0_26.DETAIL_FIELD.has_default_value = false
var_0_26.DETAIL_FIELD.default_value = nil
var_0_26.DETAIL_FIELD.message_type = UNIONDETAIL
var_0_26.DETAIL_FIELD.type = 11
var_0_26.DETAIL_FIELD.cpp_type = 10
var_0_26.LETS_FIELD.name = "lets"
var_0_26.LETS_FIELD.full_name = ".sgland.UnionMineResp.lets"
var_0_26.LETS_FIELD.number = 2
var_0_26.LETS_FIELD.index = 1
var_0_26.LETS_FIELD.label = 3
var_0_26.LETS_FIELD.has_default_value = false
var_0_26.LETS_FIELD.default_value = {}
var_0_26.LETS_FIELD.message_type = UNIONLET
var_0_26.LETS_FIELD.type = 11
var_0_26.LETS_FIELD.cpp_type = 10
var_0_26.WEEKLY_DONATES_FIELD.name = "weekly_donates"
var_0_26.WEEKLY_DONATES_FIELD.full_name = ".sgland.UnionMineResp.weekly_donates"
var_0_26.WEEKLY_DONATES_FIELD.number = 3
var_0_26.WEEKLY_DONATES_FIELD.index = 2
var_0_26.WEEKLY_DONATES_FIELD.label = 3
var_0_26.WEEKLY_DONATES_FIELD.has_default_value = false
var_0_26.WEEKLY_DONATES_FIELD.default_value = {}
var_0_26.WEEKLY_DONATES_FIELD.message_type = UNIONDONATEEX
var_0_26.WEEKLY_DONATES_FIELD.type = 11
var_0_26.WEEKLY_DONATES_FIELD.cpp_type = 10
var_0_26.DAILY_DONATES_FIELD.name = "daily_donates"
var_0_26.DAILY_DONATES_FIELD.full_name = ".sgland.UnionMineResp.daily_donates"
var_0_26.DAILY_DONATES_FIELD.number = 4
var_0_26.DAILY_DONATES_FIELD.index = 3
var_0_26.DAILY_DONATES_FIELD.label = 3
var_0_26.DAILY_DONATES_FIELD.has_default_value = false
var_0_26.DAILY_DONATES_FIELD.default_value = {}
var_0_26.DAILY_DONATES_FIELD.message_type = UNIONDONATEEX
var_0_26.DAILY_DONATES_FIELD.type = 11
var_0_26.DAILY_DONATES_FIELD.cpp_type = 10
var_0_26.DATA_FIELD.name = "data"
var_0_26.DATA_FIELD.full_name = ".sgland.UnionMineResp.data"
var_0_26.DATA_FIELD.number = 5
var_0_26.DATA_FIELD.index = 4
var_0_26.DATA_FIELD.label = 2
var_0_26.DATA_FIELD.has_default_value = false
var_0_26.DATA_FIELD.default_value = nil
var_0_26.DATA_FIELD.message_type = UNIONDATAEX
var_0_26.DATA_FIELD.type = 11
var_0_26.DATA_FIELD.cpp_type = 10
var_0_26.FOCUSES_FIELD.name = "focuses"
var_0_26.FOCUSES_FIELD.full_name = ".sgland.UnionMineResp.focuses"
var_0_26.FOCUSES_FIELD.number = 6
var_0_26.FOCUSES_FIELD.index = 5
var_0_26.FOCUSES_FIELD.label = 3
var_0_26.FOCUSES_FIELD.has_default_value = false
var_0_26.FOCUSES_FIELD.default_value = {}
var_0_26.FOCUSES_FIELD.message_type = UNIONBOSSFOCUS
var_0_26.FOCUSES_FIELD.type = 11
var_0_26.FOCUSES_FIELD.cpp_type = 10
var_0_26.IMPEACHES_FIELD.name = "impeaches"
var_0_26.IMPEACHES_FIELD.full_name = ".sgland.UnionMineResp.impeaches"
var_0_26.IMPEACHES_FIELD.number = 7
var_0_26.IMPEACHES_FIELD.index = 6
var_0_26.IMPEACHES_FIELD.label = 3
var_0_26.IMPEACHES_FIELD.has_default_value = false
var_0_26.IMPEACHES_FIELD.default_value = {}
var_0_26.IMPEACHES_FIELD.type = 3
var_0_26.IMPEACHES_FIELD.cpp_type = 2
UNIONMINERESP.name = "UnionMineResp"
UNIONMINERESP.full_name = ".sgland.UnionMineResp"
UNIONMINERESP.nested_types = {}
UNIONMINERESP.enum_types = {}
UNIONMINERESP.fields = {
	var_0_26.DETAIL_FIELD,
	var_0_26.LETS_FIELD,
	var_0_26.WEEKLY_DONATES_FIELD,
	var_0_26.DAILY_DONATES_FIELD,
	var_0_26.DATA_FIELD,
	var_0_26.FOCUSES_FIELD,
	var_0_26.IMPEACHES_FIELD
}
UNIONMINERESP.is_extendable = false
UNIONMINERESP.extensions = {}
var_0_27.INFO_FIELD.name = "info"
var_0_27.INFO_FIELD.full_name = ".sgland.UnionBossDamageResp.info"
var_0_27.INFO_FIELD.number = 1
var_0_27.INFO_FIELD.index = 0
var_0_27.INFO_FIELD.label = 2
var_0_27.INFO_FIELD.has_default_value = false
var_0_27.INFO_FIELD.default_value = nil
var_0_27.INFO_FIELD.message_type = var_0_2.USERINFO
var_0_27.INFO_FIELD.type = 11
var_0_27.INFO_FIELD.cpp_type = 10
var_0_27.ID_FIELD.name = "id"
var_0_27.ID_FIELD.full_name = ".sgland.UnionBossDamageResp.id"
var_0_27.ID_FIELD.number = 2
var_0_27.ID_FIELD.index = 1
var_0_27.ID_FIELD.label = 2
var_0_27.ID_FIELD.has_default_value = false
var_0_27.ID_FIELD.default_value = 0
var_0_27.ID_FIELD.type = 5
var_0_27.ID_FIELD.cpp_type = 1
var_0_27.DAMAGE_FIELD.name = "damage"
var_0_27.DAMAGE_FIELD.full_name = ".sgland.UnionBossDamageResp.damage"
var_0_27.DAMAGE_FIELD.number = 3
var_0_27.DAMAGE_FIELD.index = 2
var_0_27.DAMAGE_FIELD.label = 2
var_0_27.DAMAGE_FIELD.has_default_value = false
var_0_27.DAMAGE_FIELD.default_value = 0
var_0_27.DAMAGE_FIELD.type = 5
var_0_27.DAMAGE_FIELD.cpp_type = 1
var_0_27.SCORE_FIELD.name = "score"
var_0_27.SCORE_FIELD.full_name = ".sgland.UnionBossDamageResp.score"
var_0_27.SCORE_FIELD.number = 4
var_0_27.SCORE_FIELD.index = 3
var_0_27.SCORE_FIELD.label = 2
var_0_27.SCORE_FIELD.has_default_value = false
var_0_27.SCORE_FIELD.default_value = 0
var_0_27.SCORE_FIELD.type = 5
var_0_27.SCORE_FIELD.cpp_type = 1
var_0_27.ASSISTANT_DAMAGE_FIELD.name = "assistant_damage"
var_0_27.ASSISTANT_DAMAGE_FIELD.full_name = ".sgland.UnionBossDamageResp.assistant_damage"
var_0_27.ASSISTANT_DAMAGE_FIELD.number = 5
var_0_27.ASSISTANT_DAMAGE_FIELD.index = 4
var_0_27.ASSISTANT_DAMAGE_FIELD.label = 3
var_0_27.ASSISTANT_DAMAGE_FIELD.has_default_value = false
var_0_27.ASSISTANT_DAMAGE_FIELD.default_value = {}
var_0_27.ASSISTANT_DAMAGE_FIELD.type = 5
var_0_27.ASSISTANT_DAMAGE_FIELD.cpp_type = 1
UNIONBOSSDAMAGERESP.name = "UnionBossDamageResp"
UNIONBOSSDAMAGERESP.full_name = ".sgland.UnionBossDamageResp"
UNIONBOSSDAMAGERESP.nested_types = {}
UNIONBOSSDAMAGERESP.enum_types = {}
UNIONBOSSDAMAGERESP.fields = {
	var_0_27.INFO_FIELD,
	var_0_27.ID_FIELD,
	var_0_27.DAMAGE_FIELD,
	var_0_27.SCORE_FIELD,
	var_0_27.ASSISTANT_DAMAGE_FIELD
}
UNIONBOSSDAMAGERESP.is_extendable = false
UNIONBOSSDAMAGERESP.extensions = {}
var_0_28.UNION_CREATE_REQ_FIELD.name = "union_create_req"
var_0_28.UNION_CREATE_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_create_req"
var_0_28.UNION_CREATE_REQ_FIELD.number = 2000
var_0_28.UNION_CREATE_REQ_FIELD.index = 0
var_0_28.UNION_CREATE_REQ_FIELD.label = 1
var_0_28.UNION_CREATE_REQ_FIELD.has_default_value = false
var_0_28.UNION_CREATE_REQ_FIELD.default_value = nil
var_0_28.UNION_CREATE_REQ_FIELD.message_type = UNIONEDIT
var_0_28.UNION_CREATE_REQ_FIELD.type = 11
var_0_28.UNION_CREATE_REQ_FIELD.cpp_type = 10
var_0_28.UNION_INVITE_REQ_FIELD.name = "union_invite_req"
var_0_28.UNION_INVITE_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_invite_req"
var_0_28.UNION_INVITE_REQ_FIELD.number = 2001
var_0_28.UNION_INVITE_REQ_FIELD.index = 1
var_0_28.UNION_INVITE_REQ_FIELD.label = 1
var_0_28.UNION_INVITE_REQ_FIELD.has_default_value = false
var_0_28.UNION_INVITE_REQ_FIELD.default_value = nil
var_0_28.UNION_INVITE_REQ_FIELD.message_type = UNIONINVITEREQ
var_0_28.UNION_INVITE_REQ_FIELD.type = 11
var_0_28.UNION_INVITE_REQ_FIELD.cpp_type = 10
var_0_28.UNION_APPLY_REQ_FIELD.name = "union_apply_req"
var_0_28.UNION_APPLY_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_apply_req"
var_0_28.UNION_APPLY_REQ_FIELD.number = 2002
var_0_28.UNION_APPLY_REQ_FIELD.index = 2
var_0_28.UNION_APPLY_REQ_FIELD.label = 1
var_0_28.UNION_APPLY_REQ_FIELD.has_default_value = false
var_0_28.UNION_APPLY_REQ_FIELD.default_value = nil
var_0_28.UNION_APPLY_REQ_FIELD.message_type = UNIONAPPLYREQ
var_0_28.UNION_APPLY_REQ_FIELD.type = 11
var_0_28.UNION_APPLY_REQ_FIELD.cpp_type = 10
var_0_28.UNION_KICKOUT_REQ_FIELD.name = "union_kickout_req"
var_0_28.UNION_KICKOUT_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_kickout_req"
var_0_28.UNION_KICKOUT_REQ_FIELD.number = 2003
var_0_28.UNION_KICKOUT_REQ_FIELD.index = 3
var_0_28.UNION_KICKOUT_REQ_FIELD.label = 1
var_0_28.UNION_KICKOUT_REQ_FIELD.has_default_value = false
var_0_28.UNION_KICKOUT_REQ_FIELD.default_value = 0
var_0_28.UNION_KICKOUT_REQ_FIELD.type = 3
var_0_28.UNION_KICKOUT_REQ_FIELD.cpp_type = 2
var_0_28.UNION_ACCEPT_REQ_FIELD.name = "union_accept_req"
var_0_28.UNION_ACCEPT_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_accept_req"
var_0_28.UNION_ACCEPT_REQ_FIELD.number = 2004
var_0_28.UNION_ACCEPT_REQ_FIELD.index = 4
var_0_28.UNION_ACCEPT_REQ_FIELD.label = 1
var_0_28.UNION_ACCEPT_REQ_FIELD.has_default_value = false
var_0_28.UNION_ACCEPT_REQ_FIELD.default_value = nil
var_0_28.UNION_ACCEPT_REQ_FIELD.message_type = UNIONACCEPTREQ
var_0_28.UNION_ACCEPT_REQ_FIELD.type = 11
var_0_28.UNION_ACCEPT_REQ_FIELD.cpp_type = 10
var_0_28.UNION_SEARCH_REQ_FIELD.name = "union_search_req"
var_0_28.UNION_SEARCH_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_search_req"
var_0_28.UNION_SEARCH_REQ_FIELD.number = 2005
var_0_28.UNION_SEARCH_REQ_FIELD.index = 5
var_0_28.UNION_SEARCH_REQ_FIELD.label = 1
var_0_28.UNION_SEARCH_REQ_FIELD.has_default_value = false
var_0_28.UNION_SEARCH_REQ_FIELD.default_value = nil
var_0_28.UNION_SEARCH_REQ_FIELD.message_type = UNIONSEARCHREQ
var_0_28.UNION_SEARCH_REQ_FIELD.type = 11
var_0_28.UNION_SEARCH_REQ_FIELD.cpp_type = 10
var_0_28.UNION_DETAIL_REQ_FIELD.name = "union_detail_req"
var_0_28.UNION_DETAIL_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_detail_req"
var_0_28.UNION_DETAIL_REQ_FIELD.number = 2006
var_0_28.UNION_DETAIL_REQ_FIELD.index = 6
var_0_28.UNION_DETAIL_REQ_FIELD.label = 1
var_0_28.UNION_DETAIL_REQ_FIELD.has_default_value = false
var_0_28.UNION_DETAIL_REQ_FIELD.default_value = 0
var_0_28.UNION_DETAIL_REQ_FIELD.type = 3
var_0_28.UNION_DETAIL_REQ_FIELD.cpp_type = 2
var_0_28.UNION_JOIN_REQ_FIELD.name = "union_join_req"
var_0_28.UNION_JOIN_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_join_req"
var_0_28.UNION_JOIN_REQ_FIELD.number = 2007
var_0_28.UNION_JOIN_REQ_FIELD.index = 7
var_0_28.UNION_JOIN_REQ_FIELD.label = 1
var_0_28.UNION_JOIN_REQ_FIELD.has_default_value = false
var_0_28.UNION_JOIN_REQ_FIELD.default_value = 0
var_0_28.UNION_JOIN_REQ_FIELD.type = 3
var_0_28.UNION_JOIN_REQ_FIELD.cpp_type = 2
var_0_28.UNION_EDIT_REQ_FIELD.name = "union_edit_req"
var_0_28.UNION_EDIT_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_edit_req"
var_0_28.UNION_EDIT_REQ_FIELD.number = 2008
var_0_28.UNION_EDIT_REQ_FIELD.index = 8
var_0_28.UNION_EDIT_REQ_FIELD.label = 1
var_0_28.UNION_EDIT_REQ_FIELD.has_default_value = false
var_0_28.UNION_EDIT_REQ_FIELD.default_value = nil
var_0_28.UNION_EDIT_REQ_FIELD.message_type = UNIONEDIT
var_0_28.UNION_EDIT_REQ_FIELD.type = 11
var_0_28.UNION_EDIT_REQ_FIELD.cpp_type = 10
var_0_28.UNION_BUY_REQ_FIELD.name = "union_buy_req"
var_0_28.UNION_BUY_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_buy_req"
var_0_28.UNION_BUY_REQ_FIELD.number = 2009
var_0_28.UNION_BUY_REQ_FIELD.index = 9
var_0_28.UNION_BUY_REQ_FIELD.label = 1
var_0_28.UNION_BUY_REQ_FIELD.has_default_value = false
var_0_28.UNION_BUY_REQ_FIELD.default_value = 0
var_0_28.UNION_BUY_REQ_FIELD.type = 5
var_0_28.UNION_BUY_REQ_FIELD.cpp_type = 1
var_0_28.UNION_DONATE_REQ_FIELD.name = "union_donate_req"
var_0_28.UNION_DONATE_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_donate_req"
var_0_28.UNION_DONATE_REQ_FIELD.number = 2011
var_0_28.UNION_DONATE_REQ_FIELD.index = 10
var_0_28.UNION_DONATE_REQ_FIELD.label = 1
var_0_28.UNION_DONATE_REQ_FIELD.has_default_value = false
var_0_28.UNION_DONATE_REQ_FIELD.default_value = nil
var_0_28.UNION_DONATE_REQ_FIELD.message_type = UNIONDONATEREQ
var_0_28.UNION_DONATE_REQ_FIELD.type = 11
var_0_28.UNION_DONATE_REQ_FIELD.cpp_type = 10
var_0_28.UNION_PROMOTE_REQ_FIELD.name = "union_promote_req"
var_0_28.UNION_PROMOTE_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_promote_req"
var_0_28.UNION_PROMOTE_REQ_FIELD.number = 2012
var_0_28.UNION_PROMOTE_REQ_FIELD.index = 11
var_0_28.UNION_PROMOTE_REQ_FIELD.label = 1
var_0_28.UNION_PROMOTE_REQ_FIELD.has_default_value = false
var_0_28.UNION_PROMOTE_REQ_FIELD.default_value = 0
var_0_28.UNION_PROMOTE_REQ_FIELD.type = 3
var_0_28.UNION_PROMOTE_REQ_FIELD.cpp_type = 2
var_0_28.UNION_DEMOTE_REQ_FIELD.name = "union_demote_req"
var_0_28.UNION_DEMOTE_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_demote_req"
var_0_28.UNION_DEMOTE_REQ_FIELD.number = 2013
var_0_28.UNION_DEMOTE_REQ_FIELD.index = 12
var_0_28.UNION_DEMOTE_REQ_FIELD.label = 1
var_0_28.UNION_DEMOTE_REQ_FIELD.has_default_value = false
var_0_28.UNION_DEMOTE_REQ_FIELD.default_value = 0
var_0_28.UNION_DEMOTE_REQ_FIELD.type = 3
var_0_28.UNION_DEMOTE_REQ_FIELD.cpp_type = 2
var_0_28.UNION_RESIGN_REQ_FIELD.name = "union_resign_req"
var_0_28.UNION_RESIGN_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_resign_req"
var_0_28.UNION_RESIGN_REQ_FIELD.number = 2016
var_0_28.UNION_RESIGN_REQ_FIELD.index = 13
var_0_28.UNION_RESIGN_REQ_FIELD.label = 1
var_0_28.UNION_RESIGN_REQ_FIELD.has_default_value = false
var_0_28.UNION_RESIGN_REQ_FIELD.default_value = 0
var_0_28.UNION_RESIGN_REQ_FIELD.type = 3
var_0_28.UNION_RESIGN_REQ_FIELD.cpp_type = 2
var_0_28.UNION_LET_REQ_FIELD.name = "union_let_req"
var_0_28.UNION_LET_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_let_req"
var_0_28.UNION_LET_REQ_FIELD.number = 2017
var_0_28.UNION_LET_REQ_FIELD.index = 14
var_0_28.UNION_LET_REQ_FIELD.label = 1
var_0_28.UNION_LET_REQ_FIELD.has_default_value = false
var_0_28.UNION_LET_REQ_FIELD.default_value = 0
var_0_28.UNION_LET_REQ_FIELD.type = 5
var_0_28.UNION_LET_REQ_FIELD.cpp_type = 1
var_0_28.UNION_RENT_REQ_FIELD.name = "union_rent_req"
var_0_28.UNION_RENT_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_rent_req"
var_0_28.UNION_RENT_REQ_FIELD.number = 2018
var_0_28.UNION_RENT_REQ_FIELD.index = 15
var_0_28.UNION_RENT_REQ_FIELD.label = 1
var_0_28.UNION_RENT_REQ_FIELD.has_default_value = false
var_0_28.UNION_RENT_REQ_FIELD.default_value = ""
var_0_28.UNION_RENT_REQ_FIELD.type = 9
var_0_28.UNION_RENT_REQ_FIELD.cpp_type = 9
var_0_28.UNION_UNLET_REQ_FIELD.name = "union_unlet_req"
var_0_28.UNION_UNLET_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_unlet_req"
var_0_28.UNION_UNLET_REQ_FIELD.number = 2019
var_0_28.UNION_UNLET_REQ_FIELD.index = 16
var_0_28.UNION_UNLET_REQ_FIELD.label = 1
var_0_28.UNION_UNLET_REQ_FIELD.has_default_value = false
var_0_28.UNION_UNLET_REQ_FIELD.default_value = ""
var_0_28.UNION_UNLET_REQ_FIELD.type = 9
var_0_28.UNION_UNLET_REQ_FIELD.cpp_type = 9
var_0_28.UNION_CLAIM_LET_REQ_FIELD.name = "union_claim_let_req"
var_0_28.UNION_CLAIM_LET_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_claim_let_req"
var_0_28.UNION_CLAIM_LET_REQ_FIELD.number = 2020
var_0_28.UNION_CLAIM_LET_REQ_FIELD.index = 17
var_0_28.UNION_CLAIM_LET_REQ_FIELD.label = 1
var_0_28.UNION_CLAIM_LET_REQ_FIELD.has_default_value = false
var_0_28.UNION_CLAIM_LET_REQ_FIELD.default_value = ""
var_0_28.UNION_CLAIM_LET_REQ_FIELD.type = 9
var_0_28.UNION_CLAIM_LET_REQ_FIELD.cpp_type = 9
var_0_28.UNION_WORSHIP_REQ_FIELD.name = "union_worship_req"
var_0_28.UNION_WORSHIP_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_worship_req"
var_0_28.UNION_WORSHIP_REQ_FIELD.number = 2021
var_0_28.UNION_WORSHIP_REQ_FIELD.index = 18
var_0_28.UNION_WORSHIP_REQ_FIELD.label = 1
var_0_28.UNION_WORSHIP_REQ_FIELD.has_default_value = false
var_0_28.UNION_WORSHIP_REQ_FIELD.default_value = nil
var_0_28.UNION_WORSHIP_REQ_FIELD.message_type = UNIONWORSHIPREQ
var_0_28.UNION_WORSHIP_REQ_FIELD.type = 11
var_0_28.UNION_WORSHIP_REQ_FIELD.cpp_type = 10
var_0_28.UNION_BOSS_ATTACK_REQ_FIELD.name = "union_boss_attack_req"
var_0_28.UNION_BOSS_ATTACK_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_boss_attack_req"
var_0_28.UNION_BOSS_ATTACK_REQ_FIELD.number = 2022
var_0_28.UNION_BOSS_ATTACK_REQ_FIELD.index = 19
var_0_28.UNION_BOSS_ATTACK_REQ_FIELD.label = 1
var_0_28.UNION_BOSS_ATTACK_REQ_FIELD.has_default_value = false
var_0_28.UNION_BOSS_ATTACK_REQ_FIELD.default_value = 0
var_0_28.UNION_BOSS_ATTACK_REQ_FIELD.type = 5
var_0_28.UNION_BOSS_ATTACK_REQ_FIELD.cpp_type = 1
var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD.name = "union_boss_unlock_req"
var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_boss_unlock_req"
var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD.number = 2023
var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD.index = 20
var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD.label = 1
var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD.has_default_value = false
var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD.default_value = 0
var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD.type = 5
var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD.cpp_type = 1
var_0_28.UNION_TECH_UPGRADE_REQ_FIELD.name = "union_tech_upgrade_req"
var_0_28.UNION_TECH_UPGRADE_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_tech_upgrade_req"
var_0_28.UNION_TECH_UPGRADE_REQ_FIELD.number = 2024
var_0_28.UNION_TECH_UPGRADE_REQ_FIELD.index = 21
var_0_28.UNION_TECH_UPGRADE_REQ_FIELD.label = 1
var_0_28.UNION_TECH_UPGRADE_REQ_FIELD.has_default_value = false
var_0_28.UNION_TECH_UPGRADE_REQ_FIELD.default_value = 0
var_0_28.UNION_TECH_UPGRADE_REQ_FIELD.type = 5
var_0_28.UNION_TECH_UPGRADE_REQ_FIELD.cpp_type = 1
var_0_28.UNION_IMPEACH_REQ_FIELD.name = "union_impeach_req"
var_0_28.UNION_IMPEACH_REQ_FIELD.full_name = ".sgland.SglUnionMsg.union_impeach_req"
var_0_28.UNION_IMPEACH_REQ_FIELD.number = 2025
var_0_28.UNION_IMPEACH_REQ_FIELD.index = 22
var_0_28.UNION_IMPEACH_REQ_FIELD.label = 1
var_0_28.UNION_IMPEACH_REQ_FIELD.has_default_value = false
var_0_28.UNION_IMPEACH_REQ_FIELD.default_value = 0
var_0_28.UNION_IMPEACH_REQ_FIELD.type = 3
var_0_28.UNION_IMPEACH_REQ_FIELD.cpp_type = 2
var_0_28.CREATE_UNION_USE_TOKEN_FIELD.name = "create_union_use_token"
var_0_28.CREATE_UNION_USE_TOKEN_FIELD.full_name = ".sgland.SglUnionMsg.create_union_use_token"
var_0_28.CREATE_UNION_USE_TOKEN_FIELD.number = 2026
var_0_28.CREATE_UNION_USE_TOKEN_FIELD.index = 23
var_0_28.CREATE_UNION_USE_TOKEN_FIELD.label = 1
var_0_28.CREATE_UNION_USE_TOKEN_FIELD.has_default_value = false
var_0_28.CREATE_UNION_USE_TOKEN_FIELD.default_value = false
var_0_28.CREATE_UNION_USE_TOKEN_FIELD.type = 8
var_0_28.CREATE_UNION_USE_TOKEN_FIELD.cpp_type = 7
var_0_28.UNION_CREATE_RESP_FIELD.name = "union_create_resp"
var_0_28.UNION_CREATE_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_create_resp"
var_0_28.UNION_CREATE_RESP_FIELD.number = 2000
var_0_28.UNION_CREATE_RESP_FIELD.index = 24
var_0_28.UNION_CREATE_RESP_FIELD.label = 1
var_0_28.UNION_CREATE_RESP_FIELD.has_default_value = false
var_0_28.UNION_CREATE_RESP_FIELD.default_value = nil
var_0_28.UNION_CREATE_RESP_FIELD.message_type = var_0_2.UNIONMINI
var_0_28.UNION_CREATE_RESP_FIELD.type = 11
var_0_28.UNION_CREATE_RESP_FIELD.cpp_type = 10
var_0_28.UNION_INVITE_RESP_FIELD.name = "union_invite_resp"
var_0_28.UNION_INVITE_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_invite_resp"
var_0_28.UNION_INVITE_RESP_FIELD.number = 2001
var_0_28.UNION_INVITE_RESP_FIELD.index = 25
var_0_28.UNION_INVITE_RESP_FIELD.label = 1
var_0_28.UNION_INVITE_RESP_FIELD.has_default_value = false
var_0_28.UNION_INVITE_RESP_FIELD.default_value = nil
var_0_28.UNION_INVITE_RESP_FIELD.enum_type = var_0_1.INVITESTATUS
var_0_28.UNION_INVITE_RESP_FIELD.type = 14
var_0_28.UNION_INVITE_RESP_FIELD.cpp_type = 8
var_0_28.UNION_APPLY_RESP_FIELD.name = "union_apply_resp"
var_0_28.UNION_APPLY_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_apply_resp"
var_0_28.UNION_APPLY_RESP_FIELD.number = 2002
var_0_28.UNION_APPLY_RESP_FIELD.index = 26
var_0_28.UNION_APPLY_RESP_FIELD.label = 1
var_0_28.UNION_APPLY_RESP_FIELD.has_default_value = false
var_0_28.UNION_APPLY_RESP_FIELD.default_value = nil
var_0_28.UNION_APPLY_RESP_FIELD.enum_type = var_0_1.APPLYSTATUS
var_0_28.UNION_APPLY_RESP_FIELD.type = 14
var_0_28.UNION_APPLY_RESP_FIELD.cpp_type = 8
var_0_28.UNION_SEARCH_RESP_FIELD.name = "union_search_resp"
var_0_28.UNION_SEARCH_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_search_resp"
var_0_28.UNION_SEARCH_RESP_FIELD.number = 2003
var_0_28.UNION_SEARCH_RESP_FIELD.index = 27
var_0_28.UNION_SEARCH_RESP_FIELD.label = 3
var_0_28.UNION_SEARCH_RESP_FIELD.has_default_value = false
var_0_28.UNION_SEARCH_RESP_FIELD.default_value = {}
var_0_28.UNION_SEARCH_RESP_FIELD.message_type = var_0_2.UNIONINFO
var_0_28.UNION_SEARCH_RESP_FIELD.type = 11
var_0_28.UNION_SEARCH_RESP_FIELD.cpp_type = 10
var_0_28.UNION_MESSAGE_RESP_FIELD.name = "union_message_resp"
var_0_28.UNION_MESSAGE_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_message_resp"
var_0_28.UNION_MESSAGE_RESP_FIELD.number = 2004
var_0_28.UNION_MESSAGE_RESP_FIELD.index = 28
var_0_28.UNION_MESSAGE_RESP_FIELD.label = 3
var_0_28.UNION_MESSAGE_RESP_FIELD.has_default_value = false
var_0_28.UNION_MESSAGE_RESP_FIELD.default_value = {}
var_0_28.UNION_MESSAGE_RESP_FIELD.message_type = UNIONMESSAGE
var_0_28.UNION_MESSAGE_RESP_FIELD.type = 11
var_0_28.UNION_MESSAGE_RESP_FIELD.cpp_type = 10
var_0_28.UNION_DETAIL_RESP_FIELD.name = "union_detail_resp"
var_0_28.UNION_DETAIL_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_detail_resp"
var_0_28.UNION_DETAIL_RESP_FIELD.number = 2005
var_0_28.UNION_DETAIL_RESP_FIELD.index = 29
var_0_28.UNION_DETAIL_RESP_FIELD.label = 1
var_0_28.UNION_DETAIL_RESP_FIELD.has_default_value = false
var_0_28.UNION_DETAIL_RESP_FIELD.default_value = nil
var_0_28.UNION_DETAIL_RESP_FIELD.message_type = UNIONDETAIL
var_0_28.UNION_DETAIL_RESP_FIELD.type = 11
var_0_28.UNION_DETAIL_RESP_FIELD.cpp_type = 10
var_0_28.UNION_JOIN_RESP_FIELD.name = "union_join_resp"
var_0_28.UNION_JOIN_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_join_resp"
var_0_28.UNION_JOIN_RESP_FIELD.number = 2006
var_0_28.UNION_JOIN_RESP_FIELD.index = 30
var_0_28.UNION_JOIN_RESP_FIELD.label = 1
var_0_28.UNION_JOIN_RESP_FIELD.has_default_value = false
var_0_28.UNION_JOIN_RESP_FIELD.default_value = nil
var_0_28.UNION_JOIN_RESP_FIELD.message_type = var_0_2.UNIONMINI
var_0_28.UNION_JOIN_RESP_FIELD.type = 11
var_0_28.UNION_JOIN_RESP_FIELD.cpp_type = 10
var_0_28.UNION_REFRESH_RESP_FIELD.name = "union_refresh_resp"
var_0_28.UNION_REFRESH_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_refresh_resp"
var_0_28.UNION_REFRESH_RESP_FIELD.number = 2007
var_0_28.UNION_REFRESH_RESP_FIELD.index = 31
var_0_28.UNION_REFRESH_RESP_FIELD.label = 1
var_0_28.UNION_REFRESH_RESP_FIELD.has_default_value = false
var_0_28.UNION_REFRESH_RESP_FIELD.default_value = nil
var_0_28.UNION_REFRESH_RESP_FIELD.message_type = var_0_2.PLAYERUNION
var_0_28.UNION_REFRESH_RESP_FIELD.type = 11
var_0_28.UNION_REFRESH_RESP_FIELD.cpp_type = 10
var_0_28.UNION_POWER_RESP_FIELD.name = "union_power_resp"
var_0_28.UNION_POWER_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_power_resp"
var_0_28.UNION_POWER_RESP_FIELD.number = 2010
var_0_28.UNION_POWER_RESP_FIELD.index = 32
var_0_28.UNION_POWER_RESP_FIELD.label = 1
var_0_28.UNION_POWER_RESP_FIELD.has_default_value = false
var_0_28.UNION_POWER_RESP_FIELD.default_value = 0
var_0_28.UNION_POWER_RESP_FIELD.type = 5
var_0_28.UNION_POWER_RESP_FIELD.cpp_type = 1
var_0_28.UNION_MINE_RESP_FIELD.name = "union_mine_resp"
var_0_28.UNION_MINE_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_mine_resp"
var_0_28.UNION_MINE_RESP_FIELD.number = 2011
var_0_28.UNION_MINE_RESP_FIELD.index = 33
var_0_28.UNION_MINE_RESP_FIELD.label = 1
var_0_28.UNION_MINE_RESP_FIELD.has_default_value = false
var_0_28.UNION_MINE_RESP_FIELD.default_value = nil
var_0_28.UNION_MINE_RESP_FIELD.message_type = UNIONMINERESP
var_0_28.UNION_MINE_RESP_FIELD.type = 11
var_0_28.UNION_MINE_RESP_FIELD.cpp_type = 10
var_0_28.UNION_RECOMMEND_RESP_FIELD.name = "union_recommend_resp"
var_0_28.UNION_RECOMMEND_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_recommend_resp"
var_0_28.UNION_RECOMMEND_RESP_FIELD.number = 2012
var_0_28.UNION_RECOMMEND_RESP_FIELD.index = 34
var_0_28.UNION_RECOMMEND_RESP_FIELD.label = 3
var_0_28.UNION_RECOMMEND_RESP_FIELD.has_default_value = false
var_0_28.UNION_RECOMMEND_RESP_FIELD.default_value = {}
var_0_28.UNION_RECOMMEND_RESP_FIELD.message_type = var_0_2.UNIONINFO
var_0_28.UNION_RECOMMEND_RESP_FIELD.type = 11
var_0_28.UNION_RECOMMEND_RESP_FIELD.cpp_type = 10
var_0_28.UNION_LET_RESP_FIELD.name = "union_let_resp"
var_0_28.UNION_LET_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_let_resp"
var_0_28.UNION_LET_RESP_FIELD.number = 2013
var_0_28.UNION_LET_RESP_FIELD.index = 35
var_0_28.UNION_LET_RESP_FIELD.label = 1
var_0_28.UNION_LET_RESP_FIELD.has_default_value = false
var_0_28.UNION_LET_RESP_FIELD.default_value = nil
var_0_28.UNION_LET_RESP_FIELD.message_type = UNIONLET
var_0_28.UNION_LET_RESP_FIELD.type = 11
var_0_28.UNION_LET_RESP_FIELD.cpp_type = 10
var_0_28.UNION_UNLET_RESP_FIELD.name = "union_unlet_resp"
var_0_28.UNION_UNLET_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_unlet_resp"
var_0_28.UNION_UNLET_RESP_FIELD.number = 2014
var_0_28.UNION_UNLET_RESP_FIELD.index = 36
var_0_28.UNION_UNLET_RESP_FIELD.label = 1
var_0_28.UNION_UNLET_RESP_FIELD.has_default_value = false
var_0_28.UNION_UNLET_RESP_FIELD.default_value = ""
var_0_28.UNION_UNLET_RESP_FIELD.type = 9
var_0_28.UNION_UNLET_RESP_FIELD.cpp_type = 9
var_0_28.UNION_ACCEPT_RESP_FIELD.name = "union_accept_resp"
var_0_28.UNION_ACCEPT_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_accept_resp"
var_0_28.UNION_ACCEPT_RESP_FIELD.number = 2015
var_0_28.UNION_ACCEPT_RESP_FIELD.index = 37
var_0_28.UNION_ACCEPT_RESP_FIELD.label = 1
var_0_28.UNION_ACCEPT_RESP_FIELD.has_default_value = false
var_0_28.UNION_ACCEPT_RESP_FIELD.default_value = 0
var_0_28.UNION_ACCEPT_RESP_FIELD.type = 3
var_0_28.UNION_ACCEPT_RESP_FIELD.cpp_type = 2
var_0_28.UNION_BOSS_ATTACK_RESP_FIELD.name = "union_boss_attack_resp"
var_0_28.UNION_BOSS_ATTACK_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_boss_attack_resp"
var_0_28.UNION_BOSS_ATTACK_RESP_FIELD.number = 2016
var_0_28.UNION_BOSS_ATTACK_RESP_FIELD.index = 38
var_0_28.UNION_BOSS_ATTACK_RESP_FIELD.label = 1
var_0_28.UNION_BOSS_ATTACK_RESP_FIELD.has_default_value = false
var_0_28.UNION_BOSS_ATTACK_RESP_FIELD.default_value = nil
var_0_28.UNION_BOSS_ATTACK_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_28.UNION_BOSS_ATTACK_RESP_FIELD.type = 11
var_0_28.UNION_BOSS_ATTACK_RESP_FIELD.cpp_type = 10
var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD.name = "union_boss_unlock_resp"
var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_boss_unlock_resp"
var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD.number = 2017
var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD.index = 39
var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD.label = 1
var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD.has_default_value = false
var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD.default_value = 0
var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD.type = 5
var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD.cpp_type = 1
var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD.name = "union_boss_damage_resp"
var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_boss_damage_resp"
var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD.number = 2018
var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD.index = 40
var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD.label = 1
var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD.has_default_value = false
var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD.default_value = nil
var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD.message_type = UNIONBOSSDAMAGERESP
var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD.type = 11
var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD.cpp_type = 10
var_0_28.UNION_BOSS_FOCUS_RESP_FIELD.name = "union_boss_focus_resp"
var_0_28.UNION_BOSS_FOCUS_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_boss_focus_resp"
var_0_28.UNION_BOSS_FOCUS_RESP_FIELD.number = 2019
var_0_28.UNION_BOSS_FOCUS_RESP_FIELD.index = 41
var_0_28.UNION_BOSS_FOCUS_RESP_FIELD.label = 1
var_0_28.UNION_BOSS_FOCUS_RESP_FIELD.has_default_value = false
var_0_28.UNION_BOSS_FOCUS_RESP_FIELD.default_value = nil
var_0_28.UNION_BOSS_FOCUS_RESP_FIELD.message_type = UNIONBOSSFOCUS
var_0_28.UNION_BOSS_FOCUS_RESP_FIELD.type = 11
var_0_28.UNION_BOSS_FOCUS_RESP_FIELD.cpp_type = 10
var_0_28.UNION_BOSS_KILL_RESP_FIELD.name = "union_boss_kill_resp"
var_0_28.UNION_BOSS_KILL_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_boss_kill_resp"
var_0_28.UNION_BOSS_KILL_RESP_FIELD.number = 2020
var_0_28.UNION_BOSS_KILL_RESP_FIELD.index = 42
var_0_28.UNION_BOSS_KILL_RESP_FIELD.label = 3
var_0_28.UNION_BOSS_KILL_RESP_FIELD.has_default_value = false
var_0_28.UNION_BOSS_KILL_RESP_FIELD.default_value = {}
var_0_28.UNION_BOSS_KILL_RESP_FIELD.message_type = var_0_2.RESOURCE
var_0_28.UNION_BOSS_KILL_RESP_FIELD.type = 11
var_0_28.UNION_BOSS_KILL_RESP_FIELD.cpp_type = 10
var_0_28.UNION_JOIN_CD_RESP_FIELD.name = "union_join_cd_resp"
var_0_28.UNION_JOIN_CD_RESP_FIELD.full_name = ".sgland.SglUnionMsg.union_join_cd_resp"
var_0_28.UNION_JOIN_CD_RESP_FIELD.number = 2021
var_0_28.UNION_JOIN_CD_RESP_FIELD.index = 43
var_0_28.UNION_JOIN_CD_RESP_FIELD.label = 1
var_0_28.UNION_JOIN_CD_RESP_FIELD.has_default_value = false
var_0_28.UNION_JOIN_CD_RESP_FIELD.default_value = 0
var_0_28.UNION_JOIN_CD_RESP_FIELD.type = 3
var_0_28.UNION_JOIN_CD_RESP_FIELD.cpp_type = 2
SGLUNIONMSG.name = "SglUnionMsg"
SGLUNIONMSG.full_name = ".sgland.SglUnionMsg"
SGLUNIONMSG.nested_types = {}
SGLUNIONMSG.enum_types = {}
SGLUNIONMSG.fields = {}
SGLUNIONMSG.is_extendable = false
SGLUNIONMSG.extensions = {
	var_0_28.UNION_CREATE_REQ_FIELD,
	var_0_28.UNION_INVITE_REQ_FIELD,
	var_0_28.UNION_APPLY_REQ_FIELD,
	var_0_28.UNION_KICKOUT_REQ_FIELD,
	var_0_28.UNION_ACCEPT_REQ_FIELD,
	var_0_28.UNION_SEARCH_REQ_FIELD,
	var_0_28.UNION_DETAIL_REQ_FIELD,
	var_0_28.UNION_JOIN_REQ_FIELD,
	var_0_28.UNION_EDIT_REQ_FIELD,
	var_0_28.UNION_BUY_REQ_FIELD,
	var_0_28.UNION_DONATE_REQ_FIELD,
	var_0_28.UNION_PROMOTE_REQ_FIELD,
	var_0_28.UNION_DEMOTE_REQ_FIELD,
	var_0_28.UNION_RESIGN_REQ_FIELD,
	var_0_28.UNION_LET_REQ_FIELD,
	var_0_28.UNION_RENT_REQ_FIELD,
	var_0_28.UNION_UNLET_REQ_FIELD,
	var_0_28.UNION_CLAIM_LET_REQ_FIELD,
	var_0_28.UNION_WORSHIP_REQ_FIELD,
	var_0_28.UNION_BOSS_ATTACK_REQ_FIELD,
	var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD,
	var_0_28.UNION_TECH_UPGRADE_REQ_FIELD,
	var_0_28.UNION_IMPEACH_REQ_FIELD,
	var_0_28.CREATE_UNION_USE_TOKEN_FIELD,
	var_0_28.UNION_CREATE_RESP_FIELD,
	var_0_28.UNION_INVITE_RESP_FIELD,
	var_0_28.UNION_APPLY_RESP_FIELD,
	var_0_28.UNION_SEARCH_RESP_FIELD,
	var_0_28.UNION_MESSAGE_RESP_FIELD,
	var_0_28.UNION_DETAIL_RESP_FIELD,
	var_0_28.UNION_JOIN_RESP_FIELD,
	var_0_28.UNION_REFRESH_RESP_FIELD,
	var_0_28.UNION_POWER_RESP_FIELD,
	var_0_28.UNION_MINE_RESP_FIELD,
	var_0_28.UNION_RECOMMEND_RESP_FIELD,
	var_0_28.UNION_LET_RESP_FIELD,
	var_0_28.UNION_UNLET_RESP_FIELD,
	var_0_28.UNION_ACCEPT_RESP_FIELD,
	var_0_28.UNION_BOSS_ATTACK_RESP_FIELD,
	var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD,
	var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD,
	var_0_28.UNION_BOSS_FOCUS_RESP_FIELD,
	var_0_28.UNION_BOSS_KILL_RESP_FIELD,
	var_0_28.UNION_JOIN_CD_RESP_FIELD
}
FullUnionInfo = var_0_0.Message(FULLUNIONINFO)
MemberInfo = var_0_0.Message(MEMBERINFO)
PB_UNION_ADD_EXP = 22
PB_UNION_ANY = 1
PB_UNION_APPLY = 2
PB_UNION_BOARD_UPGRADE = 12
PB_UNION_CHAT = 1
PB_UNION_CLAIM_TASK = 10
PB_UNION_CLOSED = 4
PB_UNION_CO_LEADER = 2
PB_UNION_CREATE = 16
PB_UNION_DONATE = 8
PB_UNION_IMPEACH = 19
PB_UNION_IMPEACHED = 21
PB_UNION_INVITE = 3
PB_UNION_JOIN = 2
PB_UNION_KICKOUT = 4
PB_UNION_LEADER = 3
PB_UNION_LEAVE = 3
PB_UNION_LET = 13
PB_UNION_MASSWAR_TEAM_INVITE_REQ = 23
PB_UNION_MASSWAR_TEAM_JOIN_REQ = 24
PB_UNION_MEMBER = 1
PB_UNION_RESCUE = 18
PB_UNION_RESIGN = 15
PB_UNION_SHOP_UPGRADE = 11
PB_UNION_TECH_UPGRADE = 17
PB_UNION_TO_CO_LEADER = 6
PB_UNION_TO_LEADER = 7
PB_UNION_TO_MEMBER = 5
PB_UNION_UNIMPEACH = 20
PB_UNION_UNLET = 14
PB_UNION_UPGRADE = 9
SglUnionMsg = var_0_0.Message(SGLUNIONMSG)
UnionAcceptReq = var_0_0.Message(UNIONACCEPTREQ)
UnionApplyReq = var_0_0.Message(UNIONAPPLYREQ)
UnionBoss = var_0_0.Message(UNIONBOSS)
UnionBossDamageResp = var_0_0.Message(UNIONBOSSDAMAGERESP)
UnionBossFocus = var_0_0.Message(UNIONBOSSFOCUS)
UnionBossScore = var_0_0.Message(UNIONBOSSSCORE)
UnionCollectReq = var_0_0.Message(UNIONCOLLECTREQ)
UnionData = var_0_0.Message(UNIONDATA)
UnionDataEx = var_0_0.Message(UNIONDATAEX)
UnionDetail = var_0_0.Message(UNIONDETAIL)
UnionDonate = var_0_0.Message(UNIONDONATE)
UnionDonateEx = var_0_0.Message(UNIONDONATEEX)
UnionDonateReq = var_0_0.Message(UNIONDONATEREQ)
UnionEdit = var_0_0.Message(UNIONEDIT)
UnionInviteReq = var_0_0.Message(UNIONINVITEREQ)
UnionLet = var_0_0.Message(UNIONLET)
UnionMessage = var_0_0.Message(UNIONMESSAGE)
UnionMineResp = var_0_0.Message(UNIONMINERESP)
UnionSearchReq = var_0_0.Message(UNIONSEARCHREQ)
UnionWorshipReq = var_0_0.Message(UNIONWORSHIPREQ)

var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_CREATE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_INVITE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_APPLY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_KICKOUT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_ACCEPT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_SEARCH_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_DETAIL_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_JOIN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_EDIT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_BUY_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_DONATE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_PROMOTE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_DEMOTE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_RESIGN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_LET_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_RENT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_UNLET_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_CLAIM_LET_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_WORSHIP_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_BOSS_ATTACK_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_BOSS_UNLOCK_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_TECH_UPGRADE_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.UNION_IMPEACH_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_28.CREATE_UNION_USE_TOKEN_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_CREATE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_INVITE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_APPLY_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_SEARCH_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_MESSAGE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_DETAIL_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_JOIN_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_REFRESH_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_POWER_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_MINE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_RECOMMEND_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_LET_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_UNLET_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_ACCEPT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_BOSS_ATTACK_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_BOSS_UNLOCK_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_BOSS_DAMAGE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_BOSS_FOCUS_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_BOSS_KILL_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_28.UNION_JOIN_CD_RESP_FIELD)
