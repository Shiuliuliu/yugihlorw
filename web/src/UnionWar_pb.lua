local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("UnionWar_pb")

UNIONCAMPSTATUS = var_0_0.EnumDescriptor()

local var_0_3 = {
	PB_UNION_CAMP_NA = var_0_0.EnumValueDescriptor(),
	PB_UNION_CAMP_SCOUTED = var_0_0.EnumValueDescriptor(),
	PB_UNION_CAMP_DEFEATED = var_0_0.EnumValueDescriptor()
}

UNIONCITY = var_0_0.Descriptor()

local var_0_4 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	NAME_FIELD = var_0_0.FieldDescriptor(),
	LEVEL_FIELD = var_0_0.FieldDescriptor(),
	X_FIELD = var_0_0.FieldDescriptor(),
	Y_FIELD = var_0_0.FieldDescriptor(),
	OWNER_FIELD = var_0_0.FieldDescriptor()
}

UNIONCAMP = var_0_0.Descriptor()

local var_0_5 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	STATUS_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor()
}

UNIONCAMPLITE = var_0_0.Descriptor()

local var_0_6 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	STATUS_FIELD = var_0_0.FieldDescriptor(),
	OWNER_FIELD = var_0_0.FieldDescriptor()
}

UNIONCAMPFIELD = var_0_0.Descriptor()

local var_0_7 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	CAMPS_FIELD = var_0_0.FieldDescriptor()
}

UNIONCAMPFIELDLITE = var_0_0.Descriptor()

local var_0_8 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	CAMPS_FIELD = var_0_0.FieldDescriptor()
}

UNIONWARDATA = var_0_0.Descriptor()

local var_0_9 = {
	PLAYER_TROOPS_FIELD = var_0_0.FieldDescriptor(),
	UNION_CAMP_FIELDS_FIELD = var_0_0.FieldDescriptor()
}

UNIONBATTLELOG = var_0_0.Descriptor()

local var_0_10 = {
	ID_FIELD = var_0_0.FieldDescriptor(),
	WAR_ID_FIELD = var_0_0.FieldDescriptor(),
	ATTACKER_FIELD = var_0_0.FieldDescriptor(),
	DEFENDER_FIELD = var_0_0.FieldDescriptor(),
	REPLAY_ID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor(),
	IS_AVAILABLE_FIELD = var_0_0.FieldDescriptor(),
	RESULT_TYPE_FIELD = var_0_0.FieldDescriptor(),
	CAMP_ID_FIELD = var_0_0.FieldDescriptor()
}

UNIONBATTLE = var_0_0.Descriptor()

local var_0_11 = {
	WAR_ID_FIELD = var_0_0.FieldDescriptor(),
	ATTACKER_FIELD = var_0_0.FieldDescriptor(),
	DEFENDER_FIELD = var_0_0.FieldDescriptor(),
	CAMP_ID_FIELD = var_0_0.FieldDescriptor(),
	TIMESTAMP_FIELD = var_0_0.FieldDescriptor()
}

UNIONWAR = var_0_0.Descriptor()

local var_0_12 = {
	WAR_ID_FIELD = var_0_0.FieldDescriptor(),
	CITY_ID_FIELD = var_0_0.FieldDescriptor(),
	START_TIME_FIELD = var_0_0.FieldDescriptor(),
	END_TIME_FIELD = var_0_0.FieldDescriptor(),
	UNION_INFOS_FIELD = var_0_0.FieldDescriptor()
}

UNIONBATTLESCOUTREQ = var_0_0.Descriptor()

local var_0_13 = {
	WAR_ID_FIELD = var_0_0.FieldDescriptor(),
	UNION_ID_FIELD = var_0_0.FieldDescriptor(),
	CAMP_ID_FIELD = var_0_0.FieldDescriptor()
}

UNIONBATTLEATTACKREQ = var_0_0.Descriptor()

local var_0_14 = {
	WAR_ID_FIELD = var_0_0.FieldDescriptor(),
	UNION_ID_FIELD = var_0_0.FieldDescriptor(),
	CAMP_ID_FIELD = var_0_0.FieldDescriptor()
}

UNIONWORLDRESP = var_0_0.Descriptor()

local var_0_15 = {
	START_TIME_FIELD = var_0_0.FieldDescriptor(),
	END_TIME_FIELD = var_0_0.FieldDescriptor(),
	NEXT_START_TIME_FIELD = var_0_0.FieldDescriptor(),
	CITIES_FIELD = var_0_0.FieldDescriptor()
}

UNIONWARDATARESP = var_0_0.Descriptor()

local var_0_16 = {
	WAR_ID_FIELD = var_0_0.FieldDescriptor(),
	UNION_CAMP_FIELDS_FIELD = var_0_0.FieldDescriptor(),
	LOGS_FIELD = var_0_0.FieldDescriptor()
}

UNIONWARENDRESP = var_0_0.Descriptor()

local var_0_17 = {
	WAR_ID_FIELD = var_0_0.FieldDescriptor(),
	CITIES_FIELD = var_0_0.FieldDescriptor()
}

UNIONBATTLESCOUTRESP = var_0_0.Descriptor()

local var_0_18 = {
	WAR_ID_FIELD = var_0_0.FieldDescriptor(),
	UNION_ID_FIELD = var_0_0.FieldDescriptor(),
	CAMP_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor()
}

UNIONBATTLEENDRESP = var_0_0.Descriptor()

local var_0_19 = {
	BATTLE_FIELD = var_0_0.FieldDescriptor(),
	LOG_FIELD = var_0_0.FieldDescriptor()
}

MASSWARTEAMMETA = var_0_0.Descriptor()

local var_0_20 = {
	TEAM_NAME_FIELD = var_0_0.FieldDescriptor(),
	TEAM_AVATAR_FIELD = var_0_0.FieldDescriptor()
}

MASSWARTEAMUSERID = var_0_0.Descriptor()

local var_0_21 = {
	TEAM_ID_FIELD = var_0_0.FieldDescriptor(),
	USER_ID_FIELD = var_0_0.FieldDescriptor()
}

MASSWARCARDS = var_0_0.Descriptor()

local var_0_22 = {
	CARDS_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor()
}

SGLUNIONWARMSG = var_0_0.Descriptor()

local var_0_23 = {
	UNION_BATTLE_SCOUT_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_BATTLE_ATTACK_REQ_FIELD = var_0_0.FieldDescriptor(),
	UNION_BATTLE_JOIN_REQ_FIELD = var_0_0.FieldDescriptor(),
	MASSWAR_CREATE_TEAM_REQ_FIELD = var_0_0.FieldDescriptor(),
	MASSWAR_TEAM_USER_ID_FIELD = var_0_0.FieldDescriptor(),
	UNION_WORLD_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_WAR_DATA_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_BATTLE_START_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_BATTLE_END_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_BATTLE_SCOUT_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_WAR_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_BATTLE_ATTACK_RESP_FIELD = var_0_0.FieldDescriptor(),
	UNION_WAR_END_RESP_FIELD = var_0_0.FieldDescriptor(),
	MASSWAR_TEAM_LIST_RESP_FIELD = var_0_0.FieldDescriptor(),
	MASSWAR_LOAD_CARDS_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.PB_UNION_CAMP_NA.name = "PB_UNION_CAMP_NA"
var_0_3.PB_UNION_CAMP_NA.index = 0
var_0_3.PB_UNION_CAMP_NA.number = 1
var_0_3.PB_UNION_CAMP_SCOUTED.name = "PB_UNION_CAMP_SCOUTED"
var_0_3.PB_UNION_CAMP_SCOUTED.index = 1
var_0_3.PB_UNION_CAMP_SCOUTED.number = 2
var_0_3.PB_UNION_CAMP_DEFEATED.name = "PB_UNION_CAMP_DEFEATED"
var_0_3.PB_UNION_CAMP_DEFEATED.index = 2
var_0_3.PB_UNION_CAMP_DEFEATED.number = 3
UNIONCAMPSTATUS.name = "UnionCampStatus"
UNIONCAMPSTATUS.full_name = ".sgland.UnionCampStatus"
UNIONCAMPSTATUS.values = {
	var_0_3.PB_UNION_CAMP_NA,
	var_0_3.PB_UNION_CAMP_SCOUTED,
	var_0_3.PB_UNION_CAMP_DEFEATED
}
var_0_4.ID_FIELD.name = "id"
var_0_4.ID_FIELD.full_name = ".sgland.UnionCity.id"
var_0_4.ID_FIELD.number = 1
var_0_4.ID_FIELD.index = 0
var_0_4.ID_FIELD.label = 2
var_0_4.ID_FIELD.has_default_value = false
var_0_4.ID_FIELD.default_value = 0
var_0_4.ID_FIELD.type = 5
var_0_4.ID_FIELD.cpp_type = 1
var_0_4.NAME_FIELD.name = "name"
var_0_4.NAME_FIELD.full_name = ".sgland.UnionCity.name"
var_0_4.NAME_FIELD.number = 2
var_0_4.NAME_FIELD.index = 1
var_0_4.NAME_FIELD.label = 2
var_0_4.NAME_FIELD.has_default_value = false
var_0_4.NAME_FIELD.default_value = ""
var_0_4.NAME_FIELD.type = 9
var_0_4.NAME_FIELD.cpp_type = 9
var_0_4.LEVEL_FIELD.name = "level"
var_0_4.LEVEL_FIELD.full_name = ".sgland.UnionCity.level"
var_0_4.LEVEL_FIELD.number = 3
var_0_4.LEVEL_FIELD.index = 2
var_0_4.LEVEL_FIELD.label = 2
var_0_4.LEVEL_FIELD.has_default_value = false
var_0_4.LEVEL_FIELD.default_value = 0
var_0_4.LEVEL_FIELD.type = 5
var_0_4.LEVEL_FIELD.cpp_type = 1
var_0_4.X_FIELD.name = "x"
var_0_4.X_FIELD.full_name = ".sgland.UnionCity.x"
var_0_4.X_FIELD.number = 4
var_0_4.X_FIELD.index = 3
var_0_4.X_FIELD.label = 2
var_0_4.X_FIELD.has_default_value = false
var_0_4.X_FIELD.default_value = 0
var_0_4.X_FIELD.type = 5
var_0_4.X_FIELD.cpp_type = 1
var_0_4.Y_FIELD.name = "y"
var_0_4.Y_FIELD.full_name = ".sgland.UnionCity.y"
var_0_4.Y_FIELD.number = 5
var_0_4.Y_FIELD.index = 4
var_0_4.Y_FIELD.label = 2
var_0_4.Y_FIELD.has_default_value = false
var_0_4.Y_FIELD.default_value = 0
var_0_4.Y_FIELD.type = 5
var_0_4.Y_FIELD.cpp_type = 1
var_0_4.OWNER_FIELD.name = "owner"
var_0_4.OWNER_FIELD.full_name = ".sgland.UnionCity.owner"
var_0_4.OWNER_FIELD.number = 6
var_0_4.OWNER_FIELD.index = 5
var_0_4.OWNER_FIELD.label = 1
var_0_4.OWNER_FIELD.has_default_value = false
var_0_4.OWNER_FIELD.default_value = nil
var_0_4.OWNER_FIELD.message_type = var_0_2.UNIONINFO
var_0_4.OWNER_FIELD.type = 11
var_0_4.OWNER_FIELD.cpp_type = 10
UNIONCITY.name = "UnionCity"
UNIONCITY.full_name = ".sgland.UnionCity"
UNIONCITY.nested_types = {}
UNIONCITY.enum_types = {}
UNIONCITY.fields = {
	var_0_4.ID_FIELD,
	var_0_4.NAME_FIELD,
	var_0_4.LEVEL_FIELD,
	var_0_4.X_FIELD,
	var_0_4.Y_FIELD,
	var_0_4.OWNER_FIELD
}
UNIONCITY.is_extendable = false
UNIONCITY.extensions = {}
var_0_5.ID_FIELD.name = "id"
var_0_5.ID_FIELD.full_name = ".sgland.UnionCamp.id"
var_0_5.ID_FIELD.number = 1
var_0_5.ID_FIELD.index = 0
var_0_5.ID_FIELD.label = 2
var_0_5.ID_FIELD.has_default_value = false
var_0_5.ID_FIELD.default_value = 0
var_0_5.ID_FIELD.type = 5
var_0_5.ID_FIELD.cpp_type = 1
var_0_5.STATUS_FIELD.name = "status"
var_0_5.STATUS_FIELD.full_name = ".sgland.UnionCamp.status"
var_0_5.STATUS_FIELD.number = 2
var_0_5.STATUS_FIELD.index = 1
var_0_5.STATUS_FIELD.label = 2
var_0_5.STATUS_FIELD.has_default_value = false
var_0_5.STATUS_FIELD.default_value = nil
var_0_5.STATUS_FIELD.enum_type = UNIONCAMPSTATUS
var_0_5.STATUS_FIELD.type = 14
var_0_5.STATUS_FIELD.cpp_type = 8
var_0_5.TROOP_FIELD.name = "troop"
var_0_5.TROOP_FIELD.full_name = ".sgland.UnionCamp.troop"
var_0_5.TROOP_FIELD.number = 3
var_0_5.TROOP_FIELD.index = 2
var_0_5.TROOP_FIELD.label = 2
var_0_5.TROOP_FIELD.has_default_value = false
var_0_5.TROOP_FIELD.default_value = nil
var_0_5.TROOP_FIELD.message_type = var_0_2.TROOPDATA
var_0_5.TROOP_FIELD.type = 11
var_0_5.TROOP_FIELD.cpp_type = 10
UNIONCAMP.name = "UnionCamp"
UNIONCAMP.full_name = ".sgland.UnionCamp"
UNIONCAMP.nested_types = {}
UNIONCAMP.enum_types = {}
UNIONCAMP.fields = {
	var_0_5.ID_FIELD,
	var_0_5.STATUS_FIELD,
	var_0_5.TROOP_FIELD
}
UNIONCAMP.is_extendable = false
UNIONCAMP.extensions = {}
var_0_6.ID_FIELD.name = "id"
var_0_6.ID_FIELD.full_name = ".sgland.UnionCampLite.id"
var_0_6.ID_FIELD.number = 1
var_0_6.ID_FIELD.index = 0
var_0_6.ID_FIELD.label = 2
var_0_6.ID_FIELD.has_default_value = false
var_0_6.ID_FIELD.default_value = 0
var_0_6.ID_FIELD.type = 5
var_0_6.ID_FIELD.cpp_type = 1
var_0_6.STATUS_FIELD.name = "status"
var_0_6.STATUS_FIELD.full_name = ".sgland.UnionCampLite.status"
var_0_6.STATUS_FIELD.number = 2
var_0_6.STATUS_FIELD.index = 1
var_0_6.STATUS_FIELD.label = 2
var_0_6.STATUS_FIELD.has_default_value = false
var_0_6.STATUS_FIELD.default_value = nil
var_0_6.STATUS_FIELD.enum_type = UNIONCAMPSTATUS
var_0_6.STATUS_FIELD.type = 14
var_0_6.STATUS_FIELD.cpp_type = 8
var_0_6.OWNER_FIELD.name = "owner"
var_0_6.OWNER_FIELD.full_name = ".sgland.UnionCampLite.owner"
var_0_6.OWNER_FIELD.number = 3
var_0_6.OWNER_FIELD.index = 2
var_0_6.OWNER_FIELD.label = 2
var_0_6.OWNER_FIELD.has_default_value = false
var_0_6.OWNER_FIELD.default_value = nil
var_0_6.OWNER_FIELD.message_type = var_0_2.USERINFO
var_0_6.OWNER_FIELD.type = 11
var_0_6.OWNER_FIELD.cpp_type = 10
UNIONCAMPLITE.name = "UnionCampLite"
UNIONCAMPLITE.full_name = ".sgland.UnionCampLite"
UNIONCAMPLITE.nested_types = {}
UNIONCAMPLITE.enum_types = {}
UNIONCAMPLITE.fields = {
	var_0_6.ID_FIELD,
	var_0_6.STATUS_FIELD,
	var_0_6.OWNER_FIELD
}
UNIONCAMPLITE.is_extendable = false
UNIONCAMPLITE.extensions = {}
var_0_7.ID_FIELD.name = "id"
var_0_7.ID_FIELD.full_name = ".sgland.UnionCampField.id"
var_0_7.ID_FIELD.number = 1
var_0_7.ID_FIELD.index = 0
var_0_7.ID_FIELD.label = 2
var_0_7.ID_FIELD.has_default_value = false
var_0_7.ID_FIELD.default_value = 0
var_0_7.ID_FIELD.type = 3
var_0_7.ID_FIELD.cpp_type = 2
var_0_7.CAMPS_FIELD.name = "camps"
var_0_7.CAMPS_FIELD.full_name = ".sgland.UnionCampField.camps"
var_0_7.CAMPS_FIELD.number = 2
var_0_7.CAMPS_FIELD.index = 1
var_0_7.CAMPS_FIELD.label = 3
var_0_7.CAMPS_FIELD.has_default_value = false
var_0_7.CAMPS_FIELD.default_value = {}
var_0_7.CAMPS_FIELD.message_type = UNIONCAMP
var_0_7.CAMPS_FIELD.type = 11
var_0_7.CAMPS_FIELD.cpp_type = 10
UNIONCAMPFIELD.name = "UnionCampField"
UNIONCAMPFIELD.full_name = ".sgland.UnionCampField"
UNIONCAMPFIELD.nested_types = {}
UNIONCAMPFIELD.enum_types = {}
UNIONCAMPFIELD.fields = {
	var_0_7.ID_FIELD,
	var_0_7.CAMPS_FIELD
}
UNIONCAMPFIELD.is_extendable = false
UNIONCAMPFIELD.extensions = {}
var_0_8.ID_FIELD.name = "id"
var_0_8.ID_FIELD.full_name = ".sgland.UnionCampFieldLite.id"
var_0_8.ID_FIELD.number = 1
var_0_8.ID_FIELD.index = 0
var_0_8.ID_FIELD.label = 2
var_0_8.ID_FIELD.has_default_value = false
var_0_8.ID_FIELD.default_value = 0
var_0_8.ID_FIELD.type = 3
var_0_8.ID_FIELD.cpp_type = 2
var_0_8.CAMPS_FIELD.name = "camps"
var_0_8.CAMPS_FIELD.full_name = ".sgland.UnionCampFieldLite.camps"
var_0_8.CAMPS_FIELD.number = 2
var_0_8.CAMPS_FIELD.index = 1
var_0_8.CAMPS_FIELD.label = 3
var_0_8.CAMPS_FIELD.has_default_value = false
var_0_8.CAMPS_FIELD.default_value = {}
var_0_8.CAMPS_FIELD.message_type = UNIONCAMPLITE
var_0_8.CAMPS_FIELD.type = 11
var_0_8.CAMPS_FIELD.cpp_type = 10
UNIONCAMPFIELDLITE.name = "UnionCampFieldLite"
UNIONCAMPFIELDLITE.full_name = ".sgland.UnionCampFieldLite"
UNIONCAMPFIELDLITE.nested_types = {}
UNIONCAMPFIELDLITE.enum_types = {}
UNIONCAMPFIELDLITE.fields = {
	var_0_8.ID_FIELD,
	var_0_8.CAMPS_FIELD
}
UNIONCAMPFIELDLITE.is_extendable = false
UNIONCAMPFIELDLITE.extensions = {}
var_0_9.PLAYER_TROOPS_FIELD.name = "player_troops"
var_0_9.PLAYER_TROOPS_FIELD.full_name = ".sgland.UnionWarData.player_troops"
var_0_9.PLAYER_TROOPS_FIELD.number = 1
var_0_9.PLAYER_TROOPS_FIELD.index = 0
var_0_9.PLAYER_TROOPS_FIELD.label = 3
var_0_9.PLAYER_TROOPS_FIELD.has_default_value = false
var_0_9.PLAYER_TROOPS_FIELD.default_value = {}
var_0_9.PLAYER_TROOPS_FIELD.message_type = var_0_2.TROOPDATA
var_0_9.PLAYER_TROOPS_FIELD.type = 11
var_0_9.PLAYER_TROOPS_FIELD.cpp_type = 10
var_0_9.UNION_CAMP_FIELDS_FIELD.name = "union_camp_fields"
var_0_9.UNION_CAMP_FIELDS_FIELD.full_name = ".sgland.UnionWarData.union_camp_fields"
var_0_9.UNION_CAMP_FIELDS_FIELD.number = 2
var_0_9.UNION_CAMP_FIELDS_FIELD.index = 1
var_0_9.UNION_CAMP_FIELDS_FIELD.label = 3
var_0_9.UNION_CAMP_FIELDS_FIELD.has_default_value = false
var_0_9.UNION_CAMP_FIELDS_FIELD.default_value = {}
var_0_9.UNION_CAMP_FIELDS_FIELD.message_type = UNIONCAMPFIELD
var_0_9.UNION_CAMP_FIELDS_FIELD.type = 11
var_0_9.UNION_CAMP_FIELDS_FIELD.cpp_type = 10
UNIONWARDATA.name = "UnionWarData"
UNIONWARDATA.full_name = ".sgland.UnionWarData"
UNIONWARDATA.nested_types = {}
UNIONWARDATA.enum_types = {}
UNIONWARDATA.fields = {
	var_0_9.PLAYER_TROOPS_FIELD,
	var_0_9.UNION_CAMP_FIELDS_FIELD
}
UNIONWARDATA.is_extendable = false
UNIONWARDATA.extensions = {}
var_0_10.ID_FIELD.name = "id"
var_0_10.ID_FIELD.full_name = ".sgland.UnionBattleLog.id"
var_0_10.ID_FIELD.number = 1
var_0_10.ID_FIELD.index = 0
var_0_10.ID_FIELD.label = 2
var_0_10.ID_FIELD.has_default_value = false
var_0_10.ID_FIELD.default_value = 0
var_0_10.ID_FIELD.type = 3
var_0_10.ID_FIELD.cpp_type = 2
var_0_10.WAR_ID_FIELD.name = "war_id"
var_0_10.WAR_ID_FIELD.full_name = ".sgland.UnionBattleLog.war_id"
var_0_10.WAR_ID_FIELD.number = 2
var_0_10.WAR_ID_FIELD.index = 1
var_0_10.WAR_ID_FIELD.label = 2
var_0_10.WAR_ID_FIELD.has_default_value = false
var_0_10.WAR_ID_FIELD.default_value = 0
var_0_10.WAR_ID_FIELD.type = 3
var_0_10.WAR_ID_FIELD.cpp_type = 2
var_0_10.ATTACKER_FIELD.name = "attacker"
var_0_10.ATTACKER_FIELD.full_name = ".sgland.UnionBattleLog.attacker"
var_0_10.ATTACKER_FIELD.number = 3
var_0_10.ATTACKER_FIELD.index = 2
var_0_10.ATTACKER_FIELD.label = 2
var_0_10.ATTACKER_FIELD.has_default_value = false
var_0_10.ATTACKER_FIELD.default_value = nil
var_0_10.ATTACKER_FIELD.message_type = var_0_2.USERINFO
var_0_10.ATTACKER_FIELD.type = 11
var_0_10.ATTACKER_FIELD.cpp_type = 10
var_0_10.DEFENDER_FIELD.name = "defender"
var_0_10.DEFENDER_FIELD.full_name = ".sgland.UnionBattleLog.defender"
var_0_10.DEFENDER_FIELD.number = 4
var_0_10.DEFENDER_FIELD.index = 3
var_0_10.DEFENDER_FIELD.label = 2
var_0_10.DEFENDER_FIELD.has_default_value = false
var_0_10.DEFENDER_FIELD.default_value = nil
var_0_10.DEFENDER_FIELD.message_type = var_0_2.USERINFO
var_0_10.DEFENDER_FIELD.type = 11
var_0_10.DEFENDER_FIELD.cpp_type = 10
var_0_10.REPLAY_ID_FIELD.name = "replay_id"
var_0_10.REPLAY_ID_FIELD.full_name = ".sgland.UnionBattleLog.replay_id"
var_0_10.REPLAY_ID_FIELD.number = 5
var_0_10.REPLAY_ID_FIELD.index = 4
var_0_10.REPLAY_ID_FIELD.label = 2
var_0_10.REPLAY_ID_FIELD.has_default_value = false
var_0_10.REPLAY_ID_FIELD.default_value = 0
var_0_10.REPLAY_ID_FIELD.type = 3
var_0_10.REPLAY_ID_FIELD.cpp_type = 2
var_0_10.TIMESTAMP_FIELD.name = "timestamp"
var_0_10.TIMESTAMP_FIELD.full_name = ".sgland.UnionBattleLog.timestamp"
var_0_10.TIMESTAMP_FIELD.number = 6
var_0_10.TIMESTAMP_FIELD.index = 5
var_0_10.TIMESTAMP_FIELD.label = 2
var_0_10.TIMESTAMP_FIELD.has_default_value = false
var_0_10.TIMESTAMP_FIELD.default_value = 0
var_0_10.TIMESTAMP_FIELD.type = 3
var_0_10.TIMESTAMP_FIELD.cpp_type = 2
var_0_10.IS_AVAILABLE_FIELD.name = "is_available"
var_0_10.IS_AVAILABLE_FIELD.full_name = ".sgland.UnionBattleLog.is_available"
var_0_10.IS_AVAILABLE_FIELD.number = 7
var_0_10.IS_AVAILABLE_FIELD.index = 6
var_0_10.IS_AVAILABLE_FIELD.label = 2
var_0_10.IS_AVAILABLE_FIELD.has_default_value = false
var_0_10.IS_AVAILABLE_FIELD.default_value = false
var_0_10.IS_AVAILABLE_FIELD.type = 8
var_0_10.IS_AVAILABLE_FIELD.cpp_type = 7
var_0_10.RESULT_TYPE_FIELD.name = "result_type"
var_0_10.RESULT_TYPE_FIELD.full_name = ".sgland.UnionBattleLog.result_type"
var_0_10.RESULT_TYPE_FIELD.number = 8
var_0_10.RESULT_TYPE_FIELD.index = 7
var_0_10.RESULT_TYPE_FIELD.label = 2
var_0_10.RESULT_TYPE_FIELD.has_default_value = false
var_0_10.RESULT_TYPE_FIELD.default_value = 0
var_0_10.RESULT_TYPE_FIELD.type = 5
var_0_10.RESULT_TYPE_FIELD.cpp_type = 1
var_0_10.CAMP_ID_FIELD.name = "camp_id"
var_0_10.CAMP_ID_FIELD.full_name = ".sgland.UnionBattleLog.camp_id"
var_0_10.CAMP_ID_FIELD.number = 9
var_0_10.CAMP_ID_FIELD.index = 8
var_0_10.CAMP_ID_FIELD.label = 2
var_0_10.CAMP_ID_FIELD.has_default_value = false
var_0_10.CAMP_ID_FIELD.default_value = 0
var_0_10.CAMP_ID_FIELD.type = 5
var_0_10.CAMP_ID_FIELD.cpp_type = 1
UNIONBATTLELOG.name = "UnionBattleLog"
UNIONBATTLELOG.full_name = ".sgland.UnionBattleLog"
UNIONBATTLELOG.nested_types = {}
UNIONBATTLELOG.enum_types = {}
UNIONBATTLELOG.fields = {
	var_0_10.ID_FIELD,
	var_0_10.WAR_ID_FIELD,
	var_0_10.ATTACKER_FIELD,
	var_0_10.DEFENDER_FIELD,
	var_0_10.REPLAY_ID_FIELD,
	var_0_10.TIMESTAMP_FIELD,
	var_0_10.IS_AVAILABLE_FIELD,
	var_0_10.RESULT_TYPE_FIELD,
	var_0_10.CAMP_ID_FIELD
}
UNIONBATTLELOG.is_extendable = false
UNIONBATTLELOG.extensions = {}
var_0_11.WAR_ID_FIELD.name = "war_id"
var_0_11.WAR_ID_FIELD.full_name = ".sgland.UnionBattle.war_id"
var_0_11.WAR_ID_FIELD.number = 1
var_0_11.WAR_ID_FIELD.index = 0
var_0_11.WAR_ID_FIELD.label = 2
var_0_11.WAR_ID_FIELD.has_default_value = false
var_0_11.WAR_ID_FIELD.default_value = 0
var_0_11.WAR_ID_FIELD.type = 3
var_0_11.WAR_ID_FIELD.cpp_type = 2
var_0_11.ATTACKER_FIELD.name = "attacker"
var_0_11.ATTACKER_FIELD.full_name = ".sgland.UnionBattle.attacker"
var_0_11.ATTACKER_FIELD.number = 2
var_0_11.ATTACKER_FIELD.index = 1
var_0_11.ATTACKER_FIELD.label = 2
var_0_11.ATTACKER_FIELD.has_default_value = false
var_0_11.ATTACKER_FIELD.default_value = nil
var_0_11.ATTACKER_FIELD.message_type = var_0_2.USERINFO
var_0_11.ATTACKER_FIELD.type = 11
var_0_11.ATTACKER_FIELD.cpp_type = 10
var_0_11.DEFENDER_FIELD.name = "defender"
var_0_11.DEFENDER_FIELD.full_name = ".sgland.UnionBattle.defender"
var_0_11.DEFENDER_FIELD.number = 3
var_0_11.DEFENDER_FIELD.index = 2
var_0_11.DEFENDER_FIELD.label = 2
var_0_11.DEFENDER_FIELD.has_default_value = false
var_0_11.DEFENDER_FIELD.default_value = nil
var_0_11.DEFENDER_FIELD.message_type = var_0_2.USERINFO
var_0_11.DEFENDER_FIELD.type = 11
var_0_11.DEFENDER_FIELD.cpp_type = 10
var_0_11.CAMP_ID_FIELD.name = "camp_id"
var_0_11.CAMP_ID_FIELD.full_name = ".sgland.UnionBattle.camp_id"
var_0_11.CAMP_ID_FIELD.number = 4
var_0_11.CAMP_ID_FIELD.index = 3
var_0_11.CAMP_ID_FIELD.label = 2
var_0_11.CAMP_ID_FIELD.has_default_value = false
var_0_11.CAMP_ID_FIELD.default_value = 0
var_0_11.CAMP_ID_FIELD.type = 5
var_0_11.CAMP_ID_FIELD.cpp_type = 1
var_0_11.TIMESTAMP_FIELD.name = "timestamp"
var_0_11.TIMESTAMP_FIELD.full_name = ".sgland.UnionBattle.timestamp"
var_0_11.TIMESTAMP_FIELD.number = 5
var_0_11.TIMESTAMP_FIELD.index = 4
var_0_11.TIMESTAMP_FIELD.label = 2
var_0_11.TIMESTAMP_FIELD.has_default_value = false
var_0_11.TIMESTAMP_FIELD.default_value = 0
var_0_11.TIMESTAMP_FIELD.type = 3
var_0_11.TIMESTAMP_FIELD.cpp_type = 2
UNIONBATTLE.name = "UnionBattle"
UNIONBATTLE.full_name = ".sgland.UnionBattle"
UNIONBATTLE.nested_types = {}
UNIONBATTLE.enum_types = {}
UNIONBATTLE.fields = {
	var_0_11.WAR_ID_FIELD,
	var_0_11.ATTACKER_FIELD,
	var_0_11.DEFENDER_FIELD,
	var_0_11.CAMP_ID_FIELD,
	var_0_11.TIMESTAMP_FIELD
}
UNIONBATTLE.is_extendable = false
UNIONBATTLE.extensions = {}
var_0_12.WAR_ID_FIELD.name = "war_id"
var_0_12.WAR_ID_FIELD.full_name = ".sgland.UnionWar.war_id"
var_0_12.WAR_ID_FIELD.number = 1
var_0_12.WAR_ID_FIELD.index = 0
var_0_12.WAR_ID_FIELD.label = 2
var_0_12.WAR_ID_FIELD.has_default_value = false
var_0_12.WAR_ID_FIELD.default_value = 0
var_0_12.WAR_ID_FIELD.type = 3
var_0_12.WAR_ID_FIELD.cpp_type = 2
var_0_12.CITY_ID_FIELD.name = "city_id"
var_0_12.CITY_ID_FIELD.full_name = ".sgland.UnionWar.city_id"
var_0_12.CITY_ID_FIELD.number = 2
var_0_12.CITY_ID_FIELD.index = 1
var_0_12.CITY_ID_FIELD.label = 3
var_0_12.CITY_ID_FIELD.has_default_value = false
var_0_12.CITY_ID_FIELD.default_value = {}
var_0_12.CITY_ID_FIELD.type = 5
var_0_12.CITY_ID_FIELD.cpp_type = 1
var_0_12.START_TIME_FIELD.name = "start_time"
var_0_12.START_TIME_FIELD.full_name = ".sgland.UnionWar.start_time"
var_0_12.START_TIME_FIELD.number = 3
var_0_12.START_TIME_FIELD.index = 2
var_0_12.START_TIME_FIELD.label = 2
var_0_12.START_TIME_FIELD.has_default_value = false
var_0_12.START_TIME_FIELD.default_value = 0
var_0_12.START_TIME_FIELD.type = 3
var_0_12.START_TIME_FIELD.cpp_type = 2
var_0_12.END_TIME_FIELD.name = "end_time"
var_0_12.END_TIME_FIELD.full_name = ".sgland.UnionWar.end_time"
var_0_12.END_TIME_FIELD.number = 4
var_0_12.END_TIME_FIELD.index = 3
var_0_12.END_TIME_FIELD.label = 2
var_0_12.END_TIME_FIELD.has_default_value = false
var_0_12.END_TIME_FIELD.default_value = 0
var_0_12.END_TIME_FIELD.type = 3
var_0_12.END_TIME_FIELD.cpp_type = 2
var_0_12.UNION_INFOS_FIELD.name = "union_infos"
var_0_12.UNION_INFOS_FIELD.full_name = ".sgland.UnionWar.union_infos"
var_0_12.UNION_INFOS_FIELD.number = 5
var_0_12.UNION_INFOS_FIELD.index = 4
var_0_12.UNION_INFOS_FIELD.label = 3
var_0_12.UNION_INFOS_FIELD.has_default_value = false
var_0_12.UNION_INFOS_FIELD.default_value = {}
var_0_12.UNION_INFOS_FIELD.message_type = var_0_2.UNIONINFO
var_0_12.UNION_INFOS_FIELD.type = 11
var_0_12.UNION_INFOS_FIELD.cpp_type = 10
UNIONWAR.name = "UnionWar"
UNIONWAR.full_name = ".sgland.UnionWar"
UNIONWAR.nested_types = {}
UNIONWAR.enum_types = {}
UNIONWAR.fields = {
	var_0_12.WAR_ID_FIELD,
	var_0_12.CITY_ID_FIELD,
	var_0_12.START_TIME_FIELD,
	var_0_12.END_TIME_FIELD,
	var_0_12.UNION_INFOS_FIELD
}
UNIONWAR.is_extendable = false
UNIONWAR.extensions = {}
var_0_13.WAR_ID_FIELD.name = "war_id"
var_0_13.WAR_ID_FIELD.full_name = ".sgland.UnionBattleScoutReq.war_id"
var_0_13.WAR_ID_FIELD.number = 1
var_0_13.WAR_ID_FIELD.index = 0
var_0_13.WAR_ID_FIELD.label = 2
var_0_13.WAR_ID_FIELD.has_default_value = false
var_0_13.WAR_ID_FIELD.default_value = 0
var_0_13.WAR_ID_FIELD.type = 3
var_0_13.WAR_ID_FIELD.cpp_type = 2
var_0_13.UNION_ID_FIELD.name = "union_id"
var_0_13.UNION_ID_FIELD.full_name = ".sgland.UnionBattleScoutReq.union_id"
var_0_13.UNION_ID_FIELD.number = 2
var_0_13.UNION_ID_FIELD.index = 1
var_0_13.UNION_ID_FIELD.label = 2
var_0_13.UNION_ID_FIELD.has_default_value = false
var_0_13.UNION_ID_FIELD.default_value = 0
var_0_13.UNION_ID_FIELD.type = 3
var_0_13.UNION_ID_FIELD.cpp_type = 2
var_0_13.CAMP_ID_FIELD.name = "camp_id"
var_0_13.CAMP_ID_FIELD.full_name = ".sgland.UnionBattleScoutReq.camp_id"
var_0_13.CAMP_ID_FIELD.number = 3
var_0_13.CAMP_ID_FIELD.index = 2
var_0_13.CAMP_ID_FIELD.label = 2
var_0_13.CAMP_ID_FIELD.has_default_value = false
var_0_13.CAMP_ID_FIELD.default_value = 0
var_0_13.CAMP_ID_FIELD.type = 5
var_0_13.CAMP_ID_FIELD.cpp_type = 1
UNIONBATTLESCOUTREQ.name = "UnionBattleScoutReq"
UNIONBATTLESCOUTREQ.full_name = ".sgland.UnionBattleScoutReq"
UNIONBATTLESCOUTREQ.nested_types = {}
UNIONBATTLESCOUTREQ.enum_types = {}
UNIONBATTLESCOUTREQ.fields = {
	var_0_13.WAR_ID_FIELD,
	var_0_13.UNION_ID_FIELD,
	var_0_13.CAMP_ID_FIELD
}
UNIONBATTLESCOUTREQ.is_extendable = false
UNIONBATTLESCOUTREQ.extensions = {}
var_0_14.WAR_ID_FIELD.name = "war_id"
var_0_14.WAR_ID_FIELD.full_name = ".sgland.UnionBattleAttackReq.war_id"
var_0_14.WAR_ID_FIELD.number = 1
var_0_14.WAR_ID_FIELD.index = 0
var_0_14.WAR_ID_FIELD.label = 2
var_0_14.WAR_ID_FIELD.has_default_value = false
var_0_14.WAR_ID_FIELD.default_value = 0
var_0_14.WAR_ID_FIELD.type = 3
var_0_14.WAR_ID_FIELD.cpp_type = 2
var_0_14.UNION_ID_FIELD.name = "union_id"
var_0_14.UNION_ID_FIELD.full_name = ".sgland.UnionBattleAttackReq.union_id"
var_0_14.UNION_ID_FIELD.number = 2
var_0_14.UNION_ID_FIELD.index = 1
var_0_14.UNION_ID_FIELD.label = 2
var_0_14.UNION_ID_FIELD.has_default_value = false
var_0_14.UNION_ID_FIELD.default_value = 0
var_0_14.UNION_ID_FIELD.type = 3
var_0_14.UNION_ID_FIELD.cpp_type = 2
var_0_14.CAMP_ID_FIELD.name = "camp_id"
var_0_14.CAMP_ID_FIELD.full_name = ".sgland.UnionBattleAttackReq.camp_id"
var_0_14.CAMP_ID_FIELD.number = 3
var_0_14.CAMP_ID_FIELD.index = 2
var_0_14.CAMP_ID_FIELD.label = 2
var_0_14.CAMP_ID_FIELD.has_default_value = false
var_0_14.CAMP_ID_FIELD.default_value = 0
var_0_14.CAMP_ID_FIELD.type = 5
var_0_14.CAMP_ID_FIELD.cpp_type = 1
UNIONBATTLEATTACKREQ.name = "UnionBattleAttackReq"
UNIONBATTLEATTACKREQ.full_name = ".sgland.UnionBattleAttackReq"
UNIONBATTLEATTACKREQ.nested_types = {}
UNIONBATTLEATTACKREQ.enum_types = {}
UNIONBATTLEATTACKREQ.fields = {
	var_0_14.WAR_ID_FIELD,
	var_0_14.UNION_ID_FIELD,
	var_0_14.CAMP_ID_FIELD
}
UNIONBATTLEATTACKREQ.is_extendable = false
UNIONBATTLEATTACKREQ.extensions = {}
var_0_15.START_TIME_FIELD.name = "start_time"
var_0_15.START_TIME_FIELD.full_name = ".sgland.UnionWorldResp.start_time"
var_0_15.START_TIME_FIELD.number = 1
var_0_15.START_TIME_FIELD.index = 0
var_0_15.START_TIME_FIELD.label = 2
var_0_15.START_TIME_FIELD.has_default_value = false
var_0_15.START_TIME_FIELD.default_value = 0
var_0_15.START_TIME_FIELD.type = 3
var_0_15.START_TIME_FIELD.cpp_type = 2
var_0_15.END_TIME_FIELD.name = "end_time"
var_0_15.END_TIME_FIELD.full_name = ".sgland.UnionWorldResp.end_time"
var_0_15.END_TIME_FIELD.number = 2
var_0_15.END_TIME_FIELD.index = 1
var_0_15.END_TIME_FIELD.label = 2
var_0_15.END_TIME_FIELD.has_default_value = false
var_0_15.END_TIME_FIELD.default_value = 0
var_0_15.END_TIME_FIELD.type = 3
var_0_15.END_TIME_FIELD.cpp_type = 2
var_0_15.NEXT_START_TIME_FIELD.name = "next_start_time"
var_0_15.NEXT_START_TIME_FIELD.full_name = ".sgland.UnionWorldResp.next_start_time"
var_0_15.NEXT_START_TIME_FIELD.number = 3
var_0_15.NEXT_START_TIME_FIELD.index = 2
var_0_15.NEXT_START_TIME_FIELD.label = 2
var_0_15.NEXT_START_TIME_FIELD.has_default_value = false
var_0_15.NEXT_START_TIME_FIELD.default_value = 0
var_0_15.NEXT_START_TIME_FIELD.type = 3
var_0_15.NEXT_START_TIME_FIELD.cpp_type = 2
var_0_15.CITIES_FIELD.name = "cities"
var_0_15.CITIES_FIELD.full_name = ".sgland.UnionWorldResp.cities"
var_0_15.CITIES_FIELD.number = 4
var_0_15.CITIES_FIELD.index = 3
var_0_15.CITIES_FIELD.label = 3
var_0_15.CITIES_FIELD.has_default_value = false
var_0_15.CITIES_FIELD.default_value = {}
var_0_15.CITIES_FIELD.message_type = UNIONCITY
var_0_15.CITIES_FIELD.type = 11
var_0_15.CITIES_FIELD.cpp_type = 10
UNIONWORLDRESP.name = "UnionWorldResp"
UNIONWORLDRESP.full_name = ".sgland.UnionWorldResp"
UNIONWORLDRESP.nested_types = {}
UNIONWORLDRESP.enum_types = {}
UNIONWORLDRESP.fields = {
	var_0_15.START_TIME_FIELD,
	var_0_15.END_TIME_FIELD,
	var_0_15.NEXT_START_TIME_FIELD,
	var_0_15.CITIES_FIELD
}
UNIONWORLDRESP.is_extendable = false
UNIONWORLDRESP.extensions = {}
var_0_16.WAR_ID_FIELD.name = "war_id"
var_0_16.WAR_ID_FIELD.full_name = ".sgland.UnionWarDataResp.war_id"
var_0_16.WAR_ID_FIELD.number = 1
var_0_16.WAR_ID_FIELD.index = 0
var_0_16.WAR_ID_FIELD.label = 2
var_0_16.WAR_ID_FIELD.has_default_value = false
var_0_16.WAR_ID_FIELD.default_value = 0
var_0_16.WAR_ID_FIELD.type = 3
var_0_16.WAR_ID_FIELD.cpp_type = 2
var_0_16.UNION_CAMP_FIELDS_FIELD.name = "union_camp_fields"
var_0_16.UNION_CAMP_FIELDS_FIELD.full_name = ".sgland.UnionWarDataResp.union_camp_fields"
var_0_16.UNION_CAMP_FIELDS_FIELD.number = 2
var_0_16.UNION_CAMP_FIELDS_FIELD.index = 1
var_0_16.UNION_CAMP_FIELDS_FIELD.label = 3
var_0_16.UNION_CAMP_FIELDS_FIELD.has_default_value = false
var_0_16.UNION_CAMP_FIELDS_FIELD.default_value = {}
var_0_16.UNION_CAMP_FIELDS_FIELD.message_type = UNIONCAMPFIELDLITE
var_0_16.UNION_CAMP_FIELDS_FIELD.type = 11
var_0_16.UNION_CAMP_FIELDS_FIELD.cpp_type = 10
var_0_16.LOGS_FIELD.name = "logs"
var_0_16.LOGS_FIELD.full_name = ".sgland.UnionWarDataResp.logs"
var_0_16.LOGS_FIELD.number = 3
var_0_16.LOGS_FIELD.index = 2
var_0_16.LOGS_FIELD.label = 3
var_0_16.LOGS_FIELD.has_default_value = false
var_0_16.LOGS_FIELD.default_value = {}
var_0_16.LOGS_FIELD.message_type = UNIONBATTLELOG
var_0_16.LOGS_FIELD.type = 11
var_0_16.LOGS_FIELD.cpp_type = 10
UNIONWARDATARESP.name = "UnionWarDataResp"
UNIONWARDATARESP.full_name = ".sgland.UnionWarDataResp"
UNIONWARDATARESP.nested_types = {}
UNIONWARDATARESP.enum_types = {}
UNIONWARDATARESP.fields = {
	var_0_16.WAR_ID_FIELD,
	var_0_16.UNION_CAMP_FIELDS_FIELD,
	var_0_16.LOGS_FIELD
}
UNIONWARDATARESP.is_extendable = false
UNIONWARDATARESP.extensions = {}
var_0_17.WAR_ID_FIELD.name = "war_id"
var_0_17.WAR_ID_FIELD.full_name = ".sgland.UnionWarEndResp.war_id"
var_0_17.WAR_ID_FIELD.number = 1
var_0_17.WAR_ID_FIELD.index = 0
var_0_17.WAR_ID_FIELD.label = 2
var_0_17.WAR_ID_FIELD.has_default_value = false
var_0_17.WAR_ID_FIELD.default_value = 0
var_0_17.WAR_ID_FIELD.type = 3
var_0_17.WAR_ID_FIELD.cpp_type = 2
var_0_17.CITIES_FIELD.name = "cities"
var_0_17.CITIES_FIELD.full_name = ".sgland.UnionWarEndResp.cities"
var_0_17.CITIES_FIELD.number = 2
var_0_17.CITIES_FIELD.index = 1
var_0_17.CITIES_FIELD.label = 3
var_0_17.CITIES_FIELD.has_default_value = false
var_0_17.CITIES_FIELD.default_value = {}
var_0_17.CITIES_FIELD.message_type = UNIONCITY
var_0_17.CITIES_FIELD.type = 11
var_0_17.CITIES_FIELD.cpp_type = 10
UNIONWARENDRESP.name = "UnionWarEndResp"
UNIONWARENDRESP.full_name = ".sgland.UnionWarEndResp"
UNIONWARENDRESP.nested_types = {}
UNIONWARENDRESP.enum_types = {}
UNIONWARENDRESP.fields = {
	var_0_17.WAR_ID_FIELD,
	var_0_17.CITIES_FIELD
}
UNIONWARENDRESP.is_extendable = false
UNIONWARENDRESP.extensions = {}
var_0_18.WAR_ID_FIELD.name = "war_id"
var_0_18.WAR_ID_FIELD.full_name = ".sgland.UnionBattleScoutResp.war_id"
var_0_18.WAR_ID_FIELD.number = 1
var_0_18.WAR_ID_FIELD.index = 0
var_0_18.WAR_ID_FIELD.label = 2
var_0_18.WAR_ID_FIELD.has_default_value = false
var_0_18.WAR_ID_FIELD.default_value = 0
var_0_18.WAR_ID_FIELD.type = 3
var_0_18.WAR_ID_FIELD.cpp_type = 2
var_0_18.UNION_ID_FIELD.name = "union_id"
var_0_18.UNION_ID_FIELD.full_name = ".sgland.UnionBattleScoutResp.union_id"
var_0_18.UNION_ID_FIELD.number = 2
var_0_18.UNION_ID_FIELD.index = 1
var_0_18.UNION_ID_FIELD.label = 2
var_0_18.UNION_ID_FIELD.has_default_value = false
var_0_18.UNION_ID_FIELD.default_value = 0
var_0_18.UNION_ID_FIELD.type = 3
var_0_18.UNION_ID_FIELD.cpp_type = 2
var_0_18.CAMP_FIELD.name = "camp"
var_0_18.CAMP_FIELD.full_name = ".sgland.UnionBattleScoutResp.camp"
var_0_18.CAMP_FIELD.number = 3
var_0_18.CAMP_FIELD.index = 2
var_0_18.CAMP_FIELD.label = 1
var_0_18.CAMP_FIELD.has_default_value = false
var_0_18.CAMP_FIELD.default_value = nil
var_0_18.CAMP_FIELD.message_type = UNIONCAMP
var_0_18.CAMP_FIELD.type = 11
var_0_18.CAMP_FIELD.cpp_type = 10
var_0_18.TROOP_FIELD.name = "troop"
var_0_18.TROOP_FIELD.full_name = ".sgland.UnionBattleScoutResp.troop"
var_0_18.TROOP_FIELD.number = 4
var_0_18.TROOP_FIELD.index = 3
var_0_18.TROOP_FIELD.label = 1
var_0_18.TROOP_FIELD.has_default_value = false
var_0_18.TROOP_FIELD.default_value = nil
var_0_18.TROOP_FIELD.message_type = var_0_2.TROOPDATA
var_0_18.TROOP_FIELD.type = 11
var_0_18.TROOP_FIELD.cpp_type = 10
UNIONBATTLESCOUTRESP.name = "UnionBattleScoutResp"
UNIONBATTLESCOUTRESP.full_name = ".sgland.UnionBattleScoutResp"
UNIONBATTLESCOUTRESP.nested_types = {}
UNIONBATTLESCOUTRESP.enum_types = {}
UNIONBATTLESCOUTRESP.fields = {
	var_0_18.WAR_ID_FIELD,
	var_0_18.UNION_ID_FIELD,
	var_0_18.CAMP_FIELD,
	var_0_18.TROOP_FIELD
}
UNIONBATTLESCOUTRESP.is_extendable = false
UNIONBATTLESCOUTRESP.extensions = {}
var_0_19.BATTLE_FIELD.name = "battle"
var_0_19.BATTLE_FIELD.full_name = ".sgland.UnionBattleEndResp.battle"
var_0_19.BATTLE_FIELD.number = 1
var_0_19.BATTLE_FIELD.index = 0
var_0_19.BATTLE_FIELD.label = 2
var_0_19.BATTLE_FIELD.has_default_value = false
var_0_19.BATTLE_FIELD.default_value = nil
var_0_19.BATTLE_FIELD.message_type = UNIONBATTLE
var_0_19.BATTLE_FIELD.type = 11
var_0_19.BATTLE_FIELD.cpp_type = 10
var_0_19.LOG_FIELD.name = "log"
var_0_19.LOG_FIELD.full_name = ".sgland.UnionBattleEndResp.log"
var_0_19.LOG_FIELD.number = 2
var_0_19.LOG_FIELD.index = 1
var_0_19.LOG_FIELD.label = 1
var_0_19.LOG_FIELD.has_default_value = false
var_0_19.LOG_FIELD.default_value = nil
var_0_19.LOG_FIELD.message_type = UNIONBATTLELOG
var_0_19.LOG_FIELD.type = 11
var_0_19.LOG_FIELD.cpp_type = 10
UNIONBATTLEENDRESP.name = "UnionBattleEndResp"
UNIONBATTLEENDRESP.full_name = ".sgland.UnionBattleEndResp"
UNIONBATTLEENDRESP.nested_types = {}
UNIONBATTLEENDRESP.enum_types = {}
UNIONBATTLEENDRESP.fields = {
	var_0_19.BATTLE_FIELD,
	var_0_19.LOG_FIELD
}
UNIONBATTLEENDRESP.is_extendable = false
UNIONBATTLEENDRESP.extensions = {}
var_0_20.TEAM_NAME_FIELD.name = "team_name"
var_0_20.TEAM_NAME_FIELD.full_name = ".sgland.MassWarTeamMeta.team_name"
var_0_20.TEAM_NAME_FIELD.number = 1
var_0_20.TEAM_NAME_FIELD.index = 0
var_0_20.TEAM_NAME_FIELD.label = 2
var_0_20.TEAM_NAME_FIELD.has_default_value = false
var_0_20.TEAM_NAME_FIELD.default_value = ""
var_0_20.TEAM_NAME_FIELD.type = 9
var_0_20.TEAM_NAME_FIELD.cpp_type = 9
var_0_20.TEAM_AVATAR_FIELD.name = "team_avatar"
var_0_20.TEAM_AVATAR_FIELD.full_name = ".sgland.MassWarTeamMeta.team_avatar"
var_0_20.TEAM_AVATAR_FIELD.number = 2
var_0_20.TEAM_AVATAR_FIELD.index = 1
var_0_20.TEAM_AVATAR_FIELD.label = 2
var_0_20.TEAM_AVATAR_FIELD.has_default_value = false
var_0_20.TEAM_AVATAR_FIELD.default_value = 0
var_0_20.TEAM_AVATAR_FIELD.type = 5
var_0_20.TEAM_AVATAR_FIELD.cpp_type = 1
MASSWARTEAMMETA.name = "MassWarTeamMeta"
MASSWARTEAMMETA.full_name = ".sgland.MassWarTeamMeta"
MASSWARTEAMMETA.nested_types = {}
MASSWARTEAMMETA.enum_types = {}
MASSWARTEAMMETA.fields = {
	var_0_20.TEAM_NAME_FIELD,
	var_0_20.TEAM_AVATAR_FIELD
}
MASSWARTEAMMETA.is_extendable = false
MASSWARTEAMMETA.extensions = {}
var_0_21.TEAM_ID_FIELD.name = "team_id"
var_0_21.TEAM_ID_FIELD.full_name = ".sgland.MassWarTeamUserId.team_id"
var_0_21.TEAM_ID_FIELD.number = 1
var_0_21.TEAM_ID_FIELD.index = 0
var_0_21.TEAM_ID_FIELD.label = 2
var_0_21.TEAM_ID_FIELD.has_default_value = false
var_0_21.TEAM_ID_FIELD.default_value = 0
var_0_21.TEAM_ID_FIELD.type = 3
var_0_21.TEAM_ID_FIELD.cpp_type = 2
var_0_21.USER_ID_FIELD.name = "user_id"
var_0_21.USER_ID_FIELD.full_name = ".sgland.MassWarTeamUserId.user_id"
var_0_21.USER_ID_FIELD.number = 2
var_0_21.USER_ID_FIELD.index = 1
var_0_21.USER_ID_FIELD.label = 1
var_0_21.USER_ID_FIELD.has_default_value = false
var_0_21.USER_ID_FIELD.default_value = 0
var_0_21.USER_ID_FIELD.type = 3
var_0_21.USER_ID_FIELD.cpp_type = 2
MASSWARTEAMUSERID.name = "MassWarTeamUserId"
MASSWARTEAMUSERID.full_name = ".sgland.MassWarTeamUserId"
MASSWARTEAMUSERID.nested_types = {}
MASSWARTEAMUSERID.enum_types = {}
MASSWARTEAMUSERID.fields = {
	var_0_21.TEAM_ID_FIELD,
	var_0_21.USER_ID_FIELD
}
MASSWARTEAMUSERID.is_extendable = false
MASSWARTEAMUSERID.extensions = {}
var_0_22.CARDS_FIELD.name = "cards"
var_0_22.CARDS_FIELD.full_name = ".sgland.MassWarCards.cards"
var_0_22.CARDS_FIELD.number = 1
var_0_22.CARDS_FIELD.index = 0
var_0_22.CARDS_FIELD.label = 3
var_0_22.CARDS_FIELD.has_default_value = false
var_0_22.CARDS_FIELD.default_value = {}
var_0_22.CARDS_FIELD.message_type = var_0_2.RESOURCE
var_0_22.CARDS_FIELD.type = 11
var_0_22.CARDS_FIELD.cpp_type = 10
var_0_22.TROOP_FIELD.name = "troop"
var_0_22.TROOP_FIELD.full_name = ".sgland.MassWarCards.troop"
var_0_22.TROOP_FIELD.number = 2
var_0_22.TROOP_FIELD.index = 1
var_0_22.TROOP_FIELD.label = 3
var_0_22.TROOP_FIELD.has_default_value = false
var_0_22.TROOP_FIELD.default_value = {}
var_0_22.TROOP_FIELD.message_type = var_0_2.TROOP
var_0_22.TROOP_FIELD.type = 11
var_0_22.TROOP_FIELD.cpp_type = 10
MASSWARCARDS.name = "MassWarCards"
MASSWARCARDS.full_name = ".sgland.MassWarCards"
MASSWARCARDS.nested_types = {}
MASSWARCARDS.enum_types = {}
MASSWARCARDS.fields = {
	var_0_22.CARDS_FIELD,
	var_0_22.TROOP_FIELD
}
MASSWARCARDS.is_extendable = false
MASSWARCARDS.extensions = {}
var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD.name = "union_battle_scout_req"
var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD.full_name = ".sgland.SglUnionWarMsg.union_battle_scout_req"
var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD.number = 2100
var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD.index = 0
var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD.label = 1
var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD.has_default_value = false
var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD.default_value = nil
var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD.message_type = UNIONBATTLESCOUTREQ
var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD.type = 11
var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD.cpp_type = 10
var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD.name = "union_battle_attack_req"
var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD.full_name = ".sgland.SglUnionWarMsg.union_battle_attack_req"
var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD.number = 2101
var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD.index = 1
var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD.label = 1
var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD.has_default_value = false
var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD.default_value = nil
var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD.message_type = UNIONBATTLEATTACKREQ
var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD.type = 11
var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD.cpp_type = 10
var_0_23.UNION_BATTLE_JOIN_REQ_FIELD.name = "union_battle_join_req"
var_0_23.UNION_BATTLE_JOIN_REQ_FIELD.full_name = ".sgland.SglUnionWarMsg.union_battle_join_req"
var_0_23.UNION_BATTLE_JOIN_REQ_FIELD.number = 2102
var_0_23.UNION_BATTLE_JOIN_REQ_FIELD.index = 2
var_0_23.UNION_BATTLE_JOIN_REQ_FIELD.label = 1
var_0_23.UNION_BATTLE_JOIN_REQ_FIELD.has_default_value = false
var_0_23.UNION_BATTLE_JOIN_REQ_FIELD.default_value = 0
var_0_23.UNION_BATTLE_JOIN_REQ_FIELD.type = 3
var_0_23.UNION_BATTLE_JOIN_REQ_FIELD.cpp_type = 2
var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD.name = "masswar_create_team_req"
var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD.full_name = ".sgland.SglUnionWarMsg.masswar_create_team_req"
var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD.number = 2103
var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD.index = 3
var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD.label = 1
var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD.has_default_value = false
var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD.default_value = nil
var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD.message_type = MASSWARTEAMMETA
var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD.type = 11
var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD.cpp_type = 10
var_0_23.MASSWAR_TEAM_USER_ID_FIELD.name = "masswar_team_user_id"
var_0_23.MASSWAR_TEAM_USER_ID_FIELD.full_name = ".sgland.SglUnionWarMsg.masswar_team_user_id"
var_0_23.MASSWAR_TEAM_USER_ID_FIELD.number = 2104
var_0_23.MASSWAR_TEAM_USER_ID_FIELD.index = 4
var_0_23.MASSWAR_TEAM_USER_ID_FIELD.label = 1
var_0_23.MASSWAR_TEAM_USER_ID_FIELD.has_default_value = false
var_0_23.MASSWAR_TEAM_USER_ID_FIELD.default_value = nil
var_0_23.MASSWAR_TEAM_USER_ID_FIELD.message_type = MASSWARTEAMUSERID
var_0_23.MASSWAR_TEAM_USER_ID_FIELD.type = 11
var_0_23.MASSWAR_TEAM_USER_ID_FIELD.cpp_type = 10
var_0_23.UNION_WORLD_RESP_FIELD.name = "union_world_resp"
var_0_23.UNION_WORLD_RESP_FIELD.full_name = ".sgland.SglUnionWarMsg.union_world_resp"
var_0_23.UNION_WORLD_RESP_FIELD.number = 2100
var_0_23.UNION_WORLD_RESP_FIELD.index = 5
var_0_23.UNION_WORLD_RESP_FIELD.label = 1
var_0_23.UNION_WORLD_RESP_FIELD.has_default_value = false
var_0_23.UNION_WORLD_RESP_FIELD.default_value = nil
var_0_23.UNION_WORLD_RESP_FIELD.message_type = UNIONWORLDRESP
var_0_23.UNION_WORLD_RESP_FIELD.type = 11
var_0_23.UNION_WORLD_RESP_FIELD.cpp_type = 10
var_0_23.UNION_WAR_DATA_RESP_FIELD.name = "union_war_data_resp"
var_0_23.UNION_WAR_DATA_RESP_FIELD.full_name = ".sgland.SglUnionWarMsg.union_war_data_resp"
var_0_23.UNION_WAR_DATA_RESP_FIELD.number = 2101
var_0_23.UNION_WAR_DATA_RESP_FIELD.index = 6
var_0_23.UNION_WAR_DATA_RESP_FIELD.label = 1
var_0_23.UNION_WAR_DATA_RESP_FIELD.has_default_value = false
var_0_23.UNION_WAR_DATA_RESP_FIELD.default_value = nil
var_0_23.UNION_WAR_DATA_RESP_FIELD.message_type = UNIONWARDATARESP
var_0_23.UNION_WAR_DATA_RESP_FIELD.type = 11
var_0_23.UNION_WAR_DATA_RESP_FIELD.cpp_type = 10
var_0_23.UNION_BATTLE_START_RESP_FIELD.name = "union_battle_start_resp"
var_0_23.UNION_BATTLE_START_RESP_FIELD.full_name = ".sgland.SglUnionWarMsg.union_battle_start_resp"
var_0_23.UNION_BATTLE_START_RESP_FIELD.number = 2102
var_0_23.UNION_BATTLE_START_RESP_FIELD.index = 7
var_0_23.UNION_BATTLE_START_RESP_FIELD.label = 3
var_0_23.UNION_BATTLE_START_RESP_FIELD.has_default_value = false
var_0_23.UNION_BATTLE_START_RESP_FIELD.default_value = {}
var_0_23.UNION_BATTLE_START_RESP_FIELD.message_type = UNIONBATTLE
var_0_23.UNION_BATTLE_START_RESP_FIELD.type = 11
var_0_23.UNION_BATTLE_START_RESP_FIELD.cpp_type = 10
var_0_23.UNION_BATTLE_END_RESP_FIELD.name = "union_battle_end_resp"
var_0_23.UNION_BATTLE_END_RESP_FIELD.full_name = ".sgland.SglUnionWarMsg.union_battle_end_resp"
var_0_23.UNION_BATTLE_END_RESP_FIELD.number = 2103
var_0_23.UNION_BATTLE_END_RESP_FIELD.index = 8
var_0_23.UNION_BATTLE_END_RESP_FIELD.label = 1
var_0_23.UNION_BATTLE_END_RESP_FIELD.has_default_value = false
var_0_23.UNION_BATTLE_END_RESP_FIELD.default_value = nil
var_0_23.UNION_BATTLE_END_RESP_FIELD.message_type = UNIONBATTLEENDRESP
var_0_23.UNION_BATTLE_END_RESP_FIELD.type = 11
var_0_23.UNION_BATTLE_END_RESP_FIELD.cpp_type = 10
var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD.name = "union_battle_scout_resp"
var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD.full_name = ".sgland.SglUnionWarMsg.union_battle_scout_resp"
var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD.number = 2104
var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD.index = 9
var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD.label = 1
var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD.has_default_value = false
var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD.default_value = nil
var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD.message_type = UNIONBATTLESCOUTRESP
var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD.type = 11
var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD.cpp_type = 10
var_0_23.UNION_WAR_RESP_FIELD.name = "union_war_resp"
var_0_23.UNION_WAR_RESP_FIELD.full_name = ".sgland.SglUnionWarMsg.union_war_resp"
var_0_23.UNION_WAR_RESP_FIELD.number = 2105
var_0_23.UNION_WAR_RESP_FIELD.index = 10
var_0_23.UNION_WAR_RESP_FIELD.label = 3
var_0_23.UNION_WAR_RESP_FIELD.has_default_value = false
var_0_23.UNION_WAR_RESP_FIELD.default_value = {}
var_0_23.UNION_WAR_RESP_FIELD.message_type = UNIONWAR
var_0_23.UNION_WAR_RESP_FIELD.type = 11
var_0_23.UNION_WAR_RESP_FIELD.cpp_type = 10
var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD.name = "union_battle_attack_resp"
var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD.full_name = ".sgland.SglUnionWarMsg.union_battle_attack_resp"
var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD.number = 2106
var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD.index = 11
var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD.label = 1
var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD.has_default_value = false
var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD.default_value = nil
var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD.message_type = var_0_2.BATTLESPOT
var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD.type = 11
var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD.cpp_type = 10
var_0_23.UNION_WAR_END_RESP_FIELD.name = "union_war_end_resp"
var_0_23.UNION_WAR_END_RESP_FIELD.full_name = ".sgland.SglUnionWarMsg.union_war_end_resp"
var_0_23.UNION_WAR_END_RESP_FIELD.number = 2107
var_0_23.UNION_WAR_END_RESP_FIELD.index = 12
var_0_23.UNION_WAR_END_RESP_FIELD.label = 1
var_0_23.UNION_WAR_END_RESP_FIELD.has_default_value = false
var_0_23.UNION_WAR_END_RESP_FIELD.default_value = nil
var_0_23.UNION_WAR_END_RESP_FIELD.message_type = UNIONWARENDRESP
var_0_23.UNION_WAR_END_RESP_FIELD.type = 11
var_0_23.UNION_WAR_END_RESP_FIELD.cpp_type = 10
var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD.name = "masswar_team_list_resp"
var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD.full_name = ".sgland.SglUnionWarMsg.masswar_team_list_resp"
var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD.number = 2108
var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD.index = 13
var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD.label = 1
var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD.has_default_value = false
var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD.default_value = nil
var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD.message_type = var_0_2.TEAMLIST
var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD.type = 11
var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD.cpp_type = 10
var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD.name = "masswar_load_cards_resp"
var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD.full_name = ".sgland.SglUnionWarMsg.masswar_load_cards_resp"
var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD.number = 2109
var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD.index = 14
var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD.label = 1
var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD.has_default_value = false
var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD.default_value = nil
var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD.message_type = MASSWARCARDS
var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD.type = 11
var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD.cpp_type = 10
SGLUNIONWARMSG.name = "SglUnionWarMsg"
SGLUNIONWARMSG.full_name = ".sgland.SglUnionWarMsg"
SGLUNIONWARMSG.nested_types = {}
SGLUNIONWARMSG.enum_types = {}
SGLUNIONWARMSG.fields = {}
SGLUNIONWARMSG.is_extendable = false
SGLUNIONWARMSG.extensions = {
	var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD,
	var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD,
	var_0_23.UNION_BATTLE_JOIN_REQ_FIELD,
	var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD,
	var_0_23.MASSWAR_TEAM_USER_ID_FIELD,
	var_0_23.UNION_WORLD_RESP_FIELD,
	var_0_23.UNION_WAR_DATA_RESP_FIELD,
	var_0_23.UNION_BATTLE_START_RESP_FIELD,
	var_0_23.UNION_BATTLE_END_RESP_FIELD,
	var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD,
	var_0_23.UNION_WAR_RESP_FIELD,
	var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD,
	var_0_23.UNION_WAR_END_RESP_FIELD,
	var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD,
	var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD
}
MassWarCards = var_0_0.Message(MASSWARCARDS)
MassWarTeamMeta = var_0_0.Message(MASSWARTEAMMETA)
MassWarTeamUserId = var_0_0.Message(MASSWARTEAMUSERID)
PB_UNION_CAMP_DEFEATED = 3
PB_UNION_CAMP_NA = 1
PB_UNION_CAMP_SCOUTED = 2
SglUnionWarMsg = var_0_0.Message(SGLUNIONWARMSG)
UnionBattle = var_0_0.Message(UNIONBATTLE)
UnionBattleAttackReq = var_0_0.Message(UNIONBATTLEATTACKREQ)
UnionBattleEndResp = var_0_0.Message(UNIONBATTLEENDRESP)
UnionBattleLog = var_0_0.Message(UNIONBATTLELOG)
UnionBattleScoutReq = var_0_0.Message(UNIONBATTLESCOUTREQ)
UnionBattleScoutResp = var_0_0.Message(UNIONBATTLESCOUTRESP)
UnionCamp = var_0_0.Message(UNIONCAMP)
UnionCampField = var_0_0.Message(UNIONCAMPFIELD)
UnionCampFieldLite = var_0_0.Message(UNIONCAMPFIELDLITE)
UnionCampLite = var_0_0.Message(UNIONCAMPLITE)
UnionCity = var_0_0.Message(UNIONCITY)
UnionWar = var_0_0.Message(UNIONWAR)
UnionWarData = var_0_0.Message(UNIONWARDATA)
UnionWarDataResp = var_0_0.Message(UNIONWARDATARESP)
UnionWarEndResp = var_0_0.Message(UNIONWARENDRESP)
UnionWorldResp = var_0_0.Message(UNIONWORLDRESP)

var_0_1.SglReqMsg.RegisterExtension(var_0_23.UNION_BATTLE_SCOUT_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_23.UNION_BATTLE_ATTACK_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_23.UNION_BATTLE_JOIN_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_23.MASSWAR_CREATE_TEAM_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_23.MASSWAR_TEAM_USER_ID_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_23.UNION_WORLD_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_23.UNION_WAR_DATA_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_23.UNION_BATTLE_START_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_23.UNION_BATTLE_END_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_23.UNION_BATTLE_SCOUT_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_23.UNION_WAR_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_23.UNION_BATTLE_ATTACK_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_23.UNION_WAR_END_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_23.MASSWAR_TEAM_LIST_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_23.MASSWAR_LOAD_CARDS_RESP_FIELD)
