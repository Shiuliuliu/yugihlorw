local var_0_0 = require("protobuf")
local var_0_1 = require("SglMsg_pb")
local var_0_2 = require("Data_pb")

module("Rank_pb")

RANKDATA = var_0_0.Descriptor()

local var_0_3 = {
	USER_INFO_FIELD = var_0_0.FieldDescriptor(),
	UNION_INFO_FIELD = var_0_0.FieldDescriptor(),
	VALUE_FIELD = var_0_0.FieldDescriptor(),
	RANK_FIELD = var_0_0.FieldDescriptor(),
	TEAM_FIELD = var_0_0.FieldDescriptor()
}

RANKLISTRESP = var_0_0.Descriptor()

local var_0_4 = {
	END_TIME_FIELD = var_0_0.FieldDescriptor(),
	DATA_FIELD = var_0_0.FieldDescriptor(),
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	SEASON_FIELD = var_0_0.FieldDescriptor(),
	PARAM_FIELD = var_0_0.FieldDescriptor()
}

RANKLISTS = var_0_0.Descriptor()

local var_0_5 = {
	RANKS_FIELD = var_0_0.FieldDescriptor()
}

RANKPRERESP = var_0_0.Descriptor()

local var_0_6 = {
	RANKS_FIELD = var_0_0.FieldDescriptor(),
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	PRE_RANK_FIELD = var_0_0.FieldDescriptor(),
	PRE_TROPHY_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor(),
	IS_FIRST_FIELD = var_0_0.FieldDescriptor(),
	END_TIME_FIELD = var_0_0.FieldDescriptor(),
	PERIOD_FIELD = var_0_0.FieldDescriptor(),
	LADDER_EX_TROPHY_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_RANKS_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_TROPHY_FIELD = var_0_0.FieldDescriptor(),
	LEGEND_END_TIME_FIELD = var_0_0.FieldDescriptor()
}

RANKPREEXRESP = var_0_0.Descriptor()

local var_0_7 = {
	USER_ID_FIELD = var_0_0.FieldDescriptor(),
	TROPHY_FIELD = var_0_0.FieldDescriptor(),
	IS_FIRST_FIELD = var_0_0.FieldDescriptor(),
	PERIOD_FIELD = var_0_0.FieldDescriptor(),
	END_TIME_FIELD = var_0_0.FieldDescriptor(),
	TROOP_FIELD = var_0_0.FieldDescriptor(),
	WIN_FIELD = var_0_0.FieldDescriptor(),
	LOSE_FIELD = var_0_0.FieldDescriptor()
}

TEAMKEY = var_0_0.Descriptor()

local var_0_8 = {
	RID_FIELD = var_0_0.FieldDescriptor(),
	TEAM_ID_FIELD = var_0_0.FieldDescriptor()
}

SGLRANKMSG = var_0_0.Descriptor()

local var_0_9 = {
	RANK_UBOSS_REQ_FIELD = var_0_0.FieldDescriptor(),
	RANK_LADDER_REQ_FIELD = var_0_0.FieldDescriptor(),
	RANK_CHAR_REQ_FIELD = var_0_0.FieldDescriptor(),
	RANK_RESET_REQ_FIELD = var_0_0.FieldDescriptor(),
	RANK_TEAM_REQ_FIELD = var_0_0.FieldDescriptor(),
	RANK_LIST_RESP_FIELD = var_0_0.FieldDescriptor(),
	RANK_UBOSS_RESP_FIELD = var_0_0.FieldDescriptor(),
	RANK_PRE_RESP_FIELD = var_0_0.FieldDescriptor(),
	RANK_LADDER_RESP_FIELD = var_0_0.FieldDescriptor(),
	RANK_PRE_EX_RESP_FIELD = var_0_0.FieldDescriptor(),
	RANK_CHAR_RESP_FIELD = var_0_0.FieldDescriptor(),
	RANK_TOP_TEAM_MVP_RESP_FIELD = var_0_0.FieldDescriptor()
}

var_0_3.USER_INFO_FIELD.name = "user_info"
var_0_3.USER_INFO_FIELD.full_name = ".sgland.RankData.user_info"
var_0_3.USER_INFO_FIELD.number = 1
var_0_3.USER_INFO_FIELD.index = 0
var_0_3.USER_INFO_FIELD.label = 1
var_0_3.USER_INFO_FIELD.has_default_value = false
var_0_3.USER_INFO_FIELD.default_value = nil
var_0_3.USER_INFO_FIELD.message_type = var_0_2.USERINFO
var_0_3.USER_INFO_FIELD.type = 11
var_0_3.USER_INFO_FIELD.cpp_type = 10
var_0_3.UNION_INFO_FIELD.name = "union_info"
var_0_3.UNION_INFO_FIELD.full_name = ".sgland.RankData.union_info"
var_0_3.UNION_INFO_FIELD.number = 2
var_0_3.UNION_INFO_FIELD.index = 1
var_0_3.UNION_INFO_FIELD.label = 1
var_0_3.UNION_INFO_FIELD.has_default_value = false
var_0_3.UNION_INFO_FIELD.default_value = nil
var_0_3.UNION_INFO_FIELD.message_type = var_0_2.UNIONINFO
var_0_3.UNION_INFO_FIELD.type = 11
var_0_3.UNION_INFO_FIELD.cpp_type = 10
var_0_3.VALUE_FIELD.name = "value"
var_0_3.VALUE_FIELD.full_name = ".sgland.RankData.value"
var_0_3.VALUE_FIELD.number = 3
var_0_3.VALUE_FIELD.index = 2
var_0_3.VALUE_FIELD.label = 2
var_0_3.VALUE_FIELD.has_default_value = false
var_0_3.VALUE_FIELD.default_value = 0
var_0_3.VALUE_FIELD.type = 5
var_0_3.VALUE_FIELD.cpp_type = 1
var_0_3.RANK_FIELD.name = "rank"
var_0_3.RANK_FIELD.full_name = ".sgland.RankData.rank"
var_0_3.RANK_FIELD.number = 4
var_0_3.RANK_FIELD.index = 3
var_0_3.RANK_FIELD.label = 2
var_0_3.RANK_FIELD.has_default_value = false
var_0_3.RANK_FIELD.default_value = 0
var_0_3.RANK_FIELD.type = 5
var_0_3.RANK_FIELD.cpp_type = 1
var_0_3.TEAM_FIELD.name = "team"
var_0_3.TEAM_FIELD.full_name = ".sgland.RankData.team"
var_0_3.TEAM_FIELD.number = 5
var_0_3.TEAM_FIELD.index = 4
var_0_3.TEAM_FIELD.label = 1
var_0_3.TEAM_FIELD.has_default_value = false
var_0_3.TEAM_FIELD.default_value = nil
var_0_3.TEAM_FIELD.message_type = var_0_2.TEAM
var_0_3.TEAM_FIELD.type = 11
var_0_3.TEAM_FIELD.cpp_type = 10
RANKDATA.name = "RankData"
RANKDATA.full_name = ".sgland.RankData"
RANKDATA.nested_types = {}
RANKDATA.enum_types = {}
RANKDATA.fields = {
	var_0_3.USER_INFO_FIELD,
	var_0_3.UNION_INFO_FIELD,
	var_0_3.VALUE_FIELD,
	var_0_3.RANK_FIELD,
	var_0_3.TEAM_FIELD
}
RANKDATA.is_extendable = false
RANKDATA.extensions = {}
var_0_4.END_TIME_FIELD.name = "end_time"
var_0_4.END_TIME_FIELD.full_name = ".sgland.RankListResp.end_time"
var_0_4.END_TIME_FIELD.number = 1
var_0_4.END_TIME_FIELD.index = 0
var_0_4.END_TIME_FIELD.label = 2
var_0_4.END_TIME_FIELD.has_default_value = false
var_0_4.END_TIME_FIELD.default_value = 0
var_0_4.END_TIME_FIELD.type = 3
var_0_4.END_TIME_FIELD.cpp_type = 2
var_0_4.DATA_FIELD.name = "data"
var_0_4.DATA_FIELD.full_name = ".sgland.RankListResp.data"
var_0_4.DATA_FIELD.number = 2
var_0_4.DATA_FIELD.index = 1
var_0_4.DATA_FIELD.label = 3
var_0_4.DATA_FIELD.has_default_value = false
var_0_4.DATA_FIELD.default_value = {}
var_0_4.DATA_FIELD.message_type = RANKDATA
var_0_4.DATA_FIELD.type = 11
var_0_4.DATA_FIELD.cpp_type = 10
var_0_4.USER_ID_FIELD.name = "user_id"
var_0_4.USER_ID_FIELD.full_name = ".sgland.RankListResp.user_id"
var_0_4.USER_ID_FIELD.number = 3
var_0_4.USER_ID_FIELD.index = 2
var_0_4.USER_ID_FIELD.label = 1
var_0_4.USER_ID_FIELD.has_default_value = false
var_0_4.USER_ID_FIELD.default_value = 0
var_0_4.USER_ID_FIELD.type = 3
var_0_4.USER_ID_FIELD.cpp_type = 2
var_0_4.SEASON_FIELD.name = "season"
var_0_4.SEASON_FIELD.full_name = ".sgland.RankListResp.season"
var_0_4.SEASON_FIELD.number = 4
var_0_4.SEASON_FIELD.index = 3
var_0_4.SEASON_FIELD.label = 1
var_0_4.SEASON_FIELD.has_default_value = false
var_0_4.SEASON_FIELD.default_value = 0
var_0_4.SEASON_FIELD.type = 5
var_0_4.SEASON_FIELD.cpp_type = 1
var_0_4.PARAM_FIELD.name = "param"
var_0_4.PARAM_FIELD.full_name = ".sgland.RankListResp.param"
var_0_4.PARAM_FIELD.number = 5
var_0_4.PARAM_FIELD.index = 4
var_0_4.PARAM_FIELD.label = 1
var_0_4.PARAM_FIELD.has_default_value = false
var_0_4.PARAM_FIELD.default_value = 0
var_0_4.PARAM_FIELD.type = 5
var_0_4.PARAM_FIELD.cpp_type = 1
RANKLISTRESP.name = "RankListResp"
RANKLISTRESP.full_name = ".sgland.RankListResp"
RANKLISTRESP.nested_types = {}
RANKLISTRESP.enum_types = {}
RANKLISTRESP.fields = {
	var_0_4.END_TIME_FIELD,
	var_0_4.DATA_FIELD,
	var_0_4.USER_ID_FIELD,
	var_0_4.SEASON_FIELD,
	var_0_4.PARAM_FIELD
}
RANKLISTRESP.is_extendable = false
RANKLISTRESP.extensions = {}
var_0_5.RANKS_FIELD.name = "ranks"
var_0_5.RANKS_FIELD.full_name = ".sgland.RankLists.ranks"
var_0_5.RANKS_FIELD.number = 1
var_0_5.RANKS_FIELD.index = 0
var_0_5.RANKS_FIELD.label = 3
var_0_5.RANKS_FIELD.has_default_value = false
var_0_5.RANKS_FIELD.default_value = {}
var_0_5.RANKS_FIELD.message_type = RANKLISTRESP
var_0_5.RANKS_FIELD.type = 11
var_0_5.RANKS_FIELD.cpp_type = 10
RANKLISTS.name = "RankLists"
RANKLISTS.full_name = ".sgland.RankLists"
RANKLISTS.nested_types = {}
RANKLISTS.enum_types = {}
RANKLISTS.fields = {
	var_0_5.RANKS_FIELD
}
RANKLISTS.is_extendable = false
RANKLISTS.extensions = {}
var_0_6.RANKS_FIELD.name = "ranks"
var_0_6.RANKS_FIELD.full_name = ".sgland.RankPreResp.ranks"
var_0_6.RANKS_FIELD.number = 1
var_0_6.RANKS_FIELD.index = 0
var_0_6.RANKS_FIELD.label = 3
var_0_6.RANKS_FIELD.has_default_value = false
var_0_6.RANKS_FIELD.default_value = {}
var_0_6.RANKS_FIELD.message_type = RANKLISTRESP
var_0_6.RANKS_FIELD.type = 11
var_0_6.RANKS_FIELD.cpp_type = 10
var_0_6.USER_ID_FIELD.name = "user_id"
var_0_6.USER_ID_FIELD.full_name = ".sgland.RankPreResp.user_id"
var_0_6.USER_ID_FIELD.number = 2
var_0_6.USER_ID_FIELD.index = 1
var_0_6.USER_ID_FIELD.label = 2
var_0_6.USER_ID_FIELD.has_default_value = false
var_0_6.USER_ID_FIELD.default_value = 0
var_0_6.USER_ID_FIELD.type = 3
var_0_6.USER_ID_FIELD.cpp_type = 2
var_0_6.PRE_RANK_FIELD.name = "pre_rank"
var_0_6.PRE_RANK_FIELD.full_name = ".sgland.RankPreResp.pre_rank"
var_0_6.PRE_RANK_FIELD.number = 3
var_0_6.PRE_RANK_FIELD.index = 2
var_0_6.PRE_RANK_FIELD.label = 2
var_0_6.PRE_RANK_FIELD.has_default_value = false
var_0_6.PRE_RANK_FIELD.default_value = 0
var_0_6.PRE_RANK_FIELD.type = 5
var_0_6.PRE_RANK_FIELD.cpp_type = 1
var_0_6.PRE_TROPHY_FIELD.name = "pre_trophy"
var_0_6.PRE_TROPHY_FIELD.full_name = ".sgland.RankPreResp.pre_trophy"
var_0_6.PRE_TROPHY_FIELD.number = 4
var_0_6.PRE_TROPHY_FIELD.index = 3
var_0_6.PRE_TROPHY_FIELD.label = 2
var_0_6.PRE_TROPHY_FIELD.has_default_value = false
var_0_6.PRE_TROPHY_FIELD.default_value = 0
var_0_6.PRE_TROPHY_FIELD.type = 5
var_0_6.PRE_TROPHY_FIELD.cpp_type = 1
var_0_6.TROPHY_FIELD.name = "trophy"
var_0_6.TROPHY_FIELD.full_name = ".sgland.RankPreResp.trophy"
var_0_6.TROPHY_FIELD.number = 5
var_0_6.TROPHY_FIELD.index = 4
var_0_6.TROPHY_FIELD.label = 2
var_0_6.TROPHY_FIELD.has_default_value = false
var_0_6.TROPHY_FIELD.default_value = 0
var_0_6.TROPHY_FIELD.type = 5
var_0_6.TROPHY_FIELD.cpp_type = 1
var_0_6.IS_FIRST_FIELD.name = "is_first"
var_0_6.IS_FIRST_FIELD.full_name = ".sgland.RankPreResp.is_first"
var_0_6.IS_FIRST_FIELD.number = 6
var_0_6.IS_FIRST_FIELD.index = 5
var_0_6.IS_FIRST_FIELD.label = 2
var_0_6.IS_FIRST_FIELD.has_default_value = false
var_0_6.IS_FIRST_FIELD.default_value = false
var_0_6.IS_FIRST_FIELD.type = 8
var_0_6.IS_FIRST_FIELD.cpp_type = 7
var_0_6.END_TIME_FIELD.name = "end_time"
var_0_6.END_TIME_FIELD.full_name = ".sgland.RankPreResp.end_time"
var_0_6.END_TIME_FIELD.number = 7
var_0_6.END_TIME_FIELD.index = 6
var_0_6.END_TIME_FIELD.label = 2
var_0_6.END_TIME_FIELD.has_default_value = false
var_0_6.END_TIME_FIELD.default_value = 0
var_0_6.END_TIME_FIELD.type = 3
var_0_6.END_TIME_FIELD.cpp_type = 2
var_0_6.PERIOD_FIELD.name = "period"
var_0_6.PERIOD_FIELD.full_name = ".sgland.RankPreResp.period"
var_0_6.PERIOD_FIELD.number = 8
var_0_6.PERIOD_FIELD.index = 7
var_0_6.PERIOD_FIELD.label = 3
var_0_6.PERIOD_FIELD.has_default_value = false
var_0_6.PERIOD_FIELD.default_value = {}
var_0_6.PERIOD_FIELD.type = 5
var_0_6.PERIOD_FIELD.cpp_type = 1
var_0_6.LADDER_EX_TROPHY_FIELD.name = "ladder_ex_trophy"
var_0_6.LADDER_EX_TROPHY_FIELD.full_name = ".sgland.RankPreResp.ladder_ex_trophy"
var_0_6.LADDER_EX_TROPHY_FIELD.number = 9
var_0_6.LADDER_EX_TROPHY_FIELD.index = 8
var_0_6.LADDER_EX_TROPHY_FIELD.label = 1
var_0_6.LADDER_EX_TROPHY_FIELD.has_default_value = false
var_0_6.LADDER_EX_TROPHY_FIELD.default_value = 0
var_0_6.LADDER_EX_TROPHY_FIELD.type = 5
var_0_6.LADDER_EX_TROPHY_FIELD.cpp_type = 1
var_0_6.LEGEND_RANKS_FIELD.name = "legend_ranks"
var_0_6.LEGEND_RANKS_FIELD.full_name = ".sgland.RankPreResp.legend_ranks"
var_0_6.LEGEND_RANKS_FIELD.number = 10
var_0_6.LEGEND_RANKS_FIELD.index = 9
var_0_6.LEGEND_RANKS_FIELD.label = 3
var_0_6.LEGEND_RANKS_FIELD.has_default_value = false
var_0_6.LEGEND_RANKS_FIELD.default_value = {}
var_0_6.LEGEND_RANKS_FIELD.message_type = RANKLISTRESP
var_0_6.LEGEND_RANKS_FIELD.type = 11
var_0_6.LEGEND_RANKS_FIELD.cpp_type = 10
var_0_6.LEGEND_TROPHY_FIELD.name = "legend_trophy"
var_0_6.LEGEND_TROPHY_FIELD.full_name = ".sgland.RankPreResp.legend_trophy"
var_0_6.LEGEND_TROPHY_FIELD.number = 11
var_0_6.LEGEND_TROPHY_FIELD.index = 10
var_0_6.LEGEND_TROPHY_FIELD.label = 1
var_0_6.LEGEND_TROPHY_FIELD.has_default_value = false
var_0_6.LEGEND_TROPHY_FIELD.default_value = 0
var_0_6.LEGEND_TROPHY_FIELD.type = 5
var_0_6.LEGEND_TROPHY_FIELD.cpp_type = 1
var_0_6.LEGEND_END_TIME_FIELD.name = "legend_end_time"
var_0_6.LEGEND_END_TIME_FIELD.full_name = ".sgland.RankPreResp.legend_end_time"
var_0_6.LEGEND_END_TIME_FIELD.number = 12
var_0_6.LEGEND_END_TIME_FIELD.index = 11
var_0_6.LEGEND_END_TIME_FIELD.label = 2
var_0_6.LEGEND_END_TIME_FIELD.has_default_value = false
var_0_6.LEGEND_END_TIME_FIELD.default_value = 0
var_0_6.LEGEND_END_TIME_FIELD.type = 3
var_0_6.LEGEND_END_TIME_FIELD.cpp_type = 2
RANKPRERESP.name = "RankPreResp"
RANKPRERESP.full_name = ".sgland.RankPreResp"
RANKPRERESP.nested_types = {}
RANKPRERESP.enum_types = {}
RANKPRERESP.fields = {
	var_0_6.RANKS_FIELD,
	var_0_6.USER_ID_FIELD,
	var_0_6.PRE_RANK_FIELD,
	var_0_6.PRE_TROPHY_FIELD,
	var_0_6.TROPHY_FIELD,
	var_0_6.IS_FIRST_FIELD,
	var_0_6.END_TIME_FIELD,
	var_0_6.PERIOD_FIELD,
	var_0_6.LADDER_EX_TROPHY_FIELD,
	var_0_6.LEGEND_RANKS_FIELD,
	var_0_6.LEGEND_TROPHY_FIELD,
	var_0_6.LEGEND_END_TIME_FIELD
}
RANKPRERESP.is_extendable = false
RANKPRERESP.extensions = {}
var_0_7.USER_ID_FIELD.name = "user_id"
var_0_7.USER_ID_FIELD.full_name = ".sgland.RankPreExResp.user_id"
var_0_7.USER_ID_FIELD.number = 1
var_0_7.USER_ID_FIELD.index = 0
var_0_7.USER_ID_FIELD.label = 2
var_0_7.USER_ID_FIELD.has_default_value = false
var_0_7.USER_ID_FIELD.default_value = 0
var_0_7.USER_ID_FIELD.type = 3
var_0_7.USER_ID_FIELD.cpp_type = 2
var_0_7.TROPHY_FIELD.name = "trophy"
var_0_7.TROPHY_FIELD.full_name = ".sgland.RankPreExResp.trophy"
var_0_7.TROPHY_FIELD.number = 2
var_0_7.TROPHY_FIELD.index = 1
var_0_7.TROPHY_FIELD.label = 2
var_0_7.TROPHY_FIELD.has_default_value = false
var_0_7.TROPHY_FIELD.default_value = 0
var_0_7.TROPHY_FIELD.type = 5
var_0_7.TROPHY_FIELD.cpp_type = 1
var_0_7.IS_FIRST_FIELD.name = "is_first"
var_0_7.IS_FIRST_FIELD.full_name = ".sgland.RankPreExResp.is_first"
var_0_7.IS_FIRST_FIELD.number = 3
var_0_7.IS_FIRST_FIELD.index = 2
var_0_7.IS_FIRST_FIELD.label = 2
var_0_7.IS_FIRST_FIELD.has_default_value = false
var_0_7.IS_FIRST_FIELD.default_value = false
var_0_7.IS_FIRST_FIELD.type = 8
var_0_7.IS_FIRST_FIELD.cpp_type = 7
var_0_7.PERIOD_FIELD.name = "period"
var_0_7.PERIOD_FIELD.full_name = ".sgland.RankPreExResp.period"
var_0_7.PERIOD_FIELD.number = 4
var_0_7.PERIOD_FIELD.index = 3
var_0_7.PERIOD_FIELD.label = 3
var_0_7.PERIOD_FIELD.has_default_value = false
var_0_7.PERIOD_FIELD.default_value = {}
var_0_7.PERIOD_FIELD.type = 5
var_0_7.PERIOD_FIELD.cpp_type = 1
var_0_7.END_TIME_FIELD.name = "end_time"
var_0_7.END_TIME_FIELD.full_name = ".sgland.RankPreExResp.end_time"
var_0_7.END_TIME_FIELD.number = 5
var_0_7.END_TIME_FIELD.index = 4
var_0_7.END_TIME_FIELD.label = 2
var_0_7.END_TIME_FIELD.has_default_value = false
var_0_7.END_TIME_FIELD.default_value = 0
var_0_7.END_TIME_FIELD.type = 3
var_0_7.END_TIME_FIELD.cpp_type = 2
var_0_7.TROOP_FIELD.name = "troop"
var_0_7.TROOP_FIELD.full_name = ".sgland.RankPreExResp.troop"
var_0_7.TROOP_FIELD.number = 6
var_0_7.TROOP_FIELD.index = 5
var_0_7.TROOP_FIELD.label = 2
var_0_7.TROOP_FIELD.has_default_value = false
var_0_7.TROOP_FIELD.default_value = nil
var_0_7.TROOP_FIELD.message_type = var_0_2.TROOPDATA
var_0_7.TROOP_FIELD.type = 11
var_0_7.TROOP_FIELD.cpp_type = 10
var_0_7.WIN_FIELD.name = "win"
var_0_7.WIN_FIELD.full_name = ".sgland.RankPreExResp.win"
var_0_7.WIN_FIELD.number = 7
var_0_7.WIN_FIELD.index = 6
var_0_7.WIN_FIELD.label = 2
var_0_7.WIN_FIELD.has_default_value = false
var_0_7.WIN_FIELD.default_value = 0
var_0_7.WIN_FIELD.type = 5
var_0_7.WIN_FIELD.cpp_type = 1
var_0_7.LOSE_FIELD.name = "lose"
var_0_7.LOSE_FIELD.full_name = ".sgland.RankPreExResp.lose"
var_0_7.LOSE_FIELD.number = 8
var_0_7.LOSE_FIELD.index = 7
var_0_7.LOSE_FIELD.label = 2
var_0_7.LOSE_FIELD.has_default_value = false
var_0_7.LOSE_FIELD.default_value = 0
var_0_7.LOSE_FIELD.type = 5
var_0_7.LOSE_FIELD.cpp_type = 1
RANKPREEXRESP.name = "RankPreExResp"
RANKPREEXRESP.full_name = ".sgland.RankPreExResp"
RANKPREEXRESP.nested_types = {}
RANKPREEXRESP.enum_types = {}
RANKPREEXRESP.fields = {
	var_0_7.USER_ID_FIELD,
	var_0_7.TROPHY_FIELD,
	var_0_7.IS_FIRST_FIELD,
	var_0_7.PERIOD_FIELD,
	var_0_7.END_TIME_FIELD,
	var_0_7.TROOP_FIELD,
	var_0_7.WIN_FIELD,
	var_0_7.LOSE_FIELD
}
RANKPREEXRESP.is_extendable = false
RANKPREEXRESP.extensions = {}
var_0_8.RID_FIELD.name = "rid"
var_0_8.RID_FIELD.full_name = ".sgland.TeamKey.rid"
var_0_8.RID_FIELD.number = 1
var_0_8.RID_FIELD.index = 0
var_0_8.RID_FIELD.label = 2
var_0_8.RID_FIELD.has_default_value = false
var_0_8.RID_FIELD.default_value = 0
var_0_8.RID_FIELD.type = 5
var_0_8.RID_FIELD.cpp_type = 1
var_0_8.TEAM_ID_FIELD.name = "team_id"
var_0_8.TEAM_ID_FIELD.full_name = ".sgland.TeamKey.team_id"
var_0_8.TEAM_ID_FIELD.number = 2
var_0_8.TEAM_ID_FIELD.index = 1
var_0_8.TEAM_ID_FIELD.label = 2
var_0_8.TEAM_ID_FIELD.has_default_value = false
var_0_8.TEAM_ID_FIELD.default_value = 0
var_0_8.TEAM_ID_FIELD.type = 3
var_0_8.TEAM_ID_FIELD.cpp_type = 2
TEAMKEY.name = "TeamKey"
TEAMKEY.full_name = ".sgland.TeamKey"
TEAMKEY.nested_types = {}
TEAMKEY.enum_types = {}
TEAMKEY.fields = {
	var_0_8.RID_FIELD,
	var_0_8.TEAM_ID_FIELD
}
TEAMKEY.is_extendable = false
TEAMKEY.extensions = {}
var_0_9.RANK_UBOSS_REQ_FIELD.name = "rank_uboss_req"
var_0_9.RANK_UBOSS_REQ_FIELD.full_name = ".sgland.SglRankMsg.rank_uboss_req"
var_0_9.RANK_UBOSS_REQ_FIELD.number = 1700
var_0_9.RANK_UBOSS_REQ_FIELD.index = 0
var_0_9.RANK_UBOSS_REQ_FIELD.label = 1
var_0_9.RANK_UBOSS_REQ_FIELD.has_default_value = false
var_0_9.RANK_UBOSS_REQ_FIELD.default_value = 0
var_0_9.RANK_UBOSS_REQ_FIELD.type = 5
var_0_9.RANK_UBOSS_REQ_FIELD.cpp_type = 1
var_0_9.RANK_LADDER_REQ_FIELD.name = "rank_ladder_req"
var_0_9.RANK_LADDER_REQ_FIELD.full_name = ".sgland.SglRankMsg.rank_ladder_req"
var_0_9.RANK_LADDER_REQ_FIELD.number = 1701
var_0_9.RANK_LADDER_REQ_FIELD.index = 1
var_0_9.RANK_LADDER_REQ_FIELD.label = 1
var_0_9.RANK_LADDER_REQ_FIELD.has_default_value = false
var_0_9.RANK_LADDER_REQ_FIELD.default_value = 0
var_0_9.RANK_LADDER_REQ_FIELD.type = 5
var_0_9.RANK_LADDER_REQ_FIELD.cpp_type = 1
var_0_9.RANK_CHAR_REQ_FIELD.name = "rank_char_req"
var_0_9.RANK_CHAR_REQ_FIELD.full_name = ".sgland.SglRankMsg.rank_char_req"
var_0_9.RANK_CHAR_REQ_FIELD.number = 1702
var_0_9.RANK_CHAR_REQ_FIELD.index = 2
var_0_9.RANK_CHAR_REQ_FIELD.label = 1
var_0_9.RANK_CHAR_REQ_FIELD.has_default_value = false
var_0_9.RANK_CHAR_REQ_FIELD.default_value = 0
var_0_9.RANK_CHAR_REQ_FIELD.type = 5
var_0_9.RANK_CHAR_REQ_FIELD.cpp_type = 1
var_0_9.RANK_RESET_REQ_FIELD.name = "rank_reset_req"
var_0_9.RANK_RESET_REQ_FIELD.full_name = ".sgland.SglRankMsg.rank_reset_req"
var_0_9.RANK_RESET_REQ_FIELD.number = 1703
var_0_9.RANK_RESET_REQ_FIELD.index = 3
var_0_9.RANK_RESET_REQ_FIELD.label = 3
var_0_9.RANK_RESET_REQ_FIELD.has_default_value = false
var_0_9.RANK_RESET_REQ_FIELD.default_value = {}
var_0_9.RANK_RESET_REQ_FIELD.message_type = var_0_2.ACCOUNTINFO
var_0_9.RANK_RESET_REQ_FIELD.type = 11
var_0_9.RANK_RESET_REQ_FIELD.cpp_type = 10
var_0_9.RANK_TEAM_REQ_FIELD.name = "rank_team_req"
var_0_9.RANK_TEAM_REQ_FIELD.full_name = ".sgland.SglRankMsg.rank_team_req"
var_0_9.RANK_TEAM_REQ_FIELD.number = 1704
var_0_9.RANK_TEAM_REQ_FIELD.index = 4
var_0_9.RANK_TEAM_REQ_FIELD.label = 1
var_0_9.RANK_TEAM_REQ_FIELD.has_default_value = false
var_0_9.RANK_TEAM_REQ_FIELD.default_value = nil
var_0_9.RANK_TEAM_REQ_FIELD.message_type = TEAMKEY
var_0_9.RANK_TEAM_REQ_FIELD.type = 11
var_0_9.RANK_TEAM_REQ_FIELD.cpp_type = 10
var_0_9.RANK_LIST_RESP_FIELD.name = "rank_list_resp"
var_0_9.RANK_LIST_RESP_FIELD.full_name = ".sgland.SglRankMsg.rank_list_resp"
var_0_9.RANK_LIST_RESP_FIELD.number = 1700
var_0_9.RANK_LIST_RESP_FIELD.index = 5
var_0_9.RANK_LIST_RESP_FIELD.label = 1
var_0_9.RANK_LIST_RESP_FIELD.has_default_value = false
var_0_9.RANK_LIST_RESP_FIELD.default_value = nil
var_0_9.RANK_LIST_RESP_FIELD.message_type = RANKLISTRESP
var_0_9.RANK_LIST_RESP_FIELD.type = 11
var_0_9.RANK_LIST_RESP_FIELD.cpp_type = 10
var_0_9.RANK_UBOSS_RESP_FIELD.name = "rank_uboss_resp"
var_0_9.RANK_UBOSS_RESP_FIELD.full_name = ".sgland.SglRankMsg.rank_uboss_resp"
var_0_9.RANK_UBOSS_RESP_FIELD.number = 1701
var_0_9.RANK_UBOSS_RESP_FIELD.index = 6
var_0_9.RANK_UBOSS_RESP_FIELD.label = 1
var_0_9.RANK_UBOSS_RESP_FIELD.has_default_value = false
var_0_9.RANK_UBOSS_RESP_FIELD.default_value = 0
var_0_9.RANK_UBOSS_RESP_FIELD.type = 5
var_0_9.RANK_UBOSS_RESP_FIELD.cpp_type = 1
var_0_9.RANK_PRE_RESP_FIELD.name = "rank_pre_resp"
var_0_9.RANK_PRE_RESP_FIELD.full_name = ".sgland.SglRankMsg.rank_pre_resp"
var_0_9.RANK_PRE_RESP_FIELD.number = 1702
var_0_9.RANK_PRE_RESP_FIELD.index = 7
var_0_9.RANK_PRE_RESP_FIELD.label = 1
var_0_9.RANK_PRE_RESP_FIELD.has_default_value = false
var_0_9.RANK_PRE_RESP_FIELD.default_value = nil
var_0_9.RANK_PRE_RESP_FIELD.message_type = RANKPRERESP
var_0_9.RANK_PRE_RESP_FIELD.type = 11
var_0_9.RANK_PRE_RESP_FIELD.cpp_type = 10
var_0_9.RANK_LADDER_RESP_FIELD.name = "rank_ladder_resp"
var_0_9.RANK_LADDER_RESP_FIELD.full_name = ".sgland.SglRankMsg.rank_ladder_resp"
var_0_9.RANK_LADDER_RESP_FIELD.number = 1703
var_0_9.RANK_LADDER_RESP_FIELD.index = 8
var_0_9.RANK_LADDER_RESP_FIELD.label = 1
var_0_9.RANK_LADDER_RESP_FIELD.has_default_value = false
var_0_9.RANK_LADDER_RESP_FIELD.default_value = 0
var_0_9.RANK_LADDER_RESP_FIELD.type = 5
var_0_9.RANK_LADDER_RESP_FIELD.cpp_type = 1
var_0_9.RANK_PRE_EX_RESP_FIELD.name = "rank_pre_ex_resp"
var_0_9.RANK_PRE_EX_RESP_FIELD.full_name = ".sgland.SglRankMsg.rank_pre_ex_resp"
var_0_9.RANK_PRE_EX_RESP_FIELD.number = 1704
var_0_9.RANK_PRE_EX_RESP_FIELD.index = 9
var_0_9.RANK_PRE_EX_RESP_FIELD.label = 1
var_0_9.RANK_PRE_EX_RESP_FIELD.has_default_value = false
var_0_9.RANK_PRE_EX_RESP_FIELD.default_value = nil
var_0_9.RANK_PRE_EX_RESP_FIELD.message_type = RANKPREEXRESP
var_0_9.RANK_PRE_EX_RESP_FIELD.type = 11
var_0_9.RANK_PRE_EX_RESP_FIELD.cpp_type = 10
var_0_9.RANK_CHAR_RESP_FIELD.name = "rank_char_resp"
var_0_9.RANK_CHAR_RESP_FIELD.full_name = ".sgland.SglRankMsg.rank_char_resp"
var_0_9.RANK_CHAR_RESP_FIELD.number = 1705
var_0_9.RANK_CHAR_RESP_FIELD.index = 10
var_0_9.RANK_CHAR_RESP_FIELD.label = 1
var_0_9.RANK_CHAR_RESP_FIELD.has_default_value = false
var_0_9.RANK_CHAR_RESP_FIELD.default_value = 0
var_0_9.RANK_CHAR_RESP_FIELD.type = 5
var_0_9.RANK_CHAR_RESP_FIELD.cpp_type = 1
var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD.name = "rank_top_team_mvp_resp"
var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD.full_name = ".sgland.SglRankMsg.rank_top_team_mvp_resp"
var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD.number = 1706
var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD.index = 11
var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD.label = 1
var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD.has_default_value = false
var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD.default_value = nil
var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD.message_type = RANKLISTS
var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD.type = 11
var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD.cpp_type = 10
SGLRANKMSG.name = "SglRankMsg"
SGLRANKMSG.full_name = ".sgland.SglRankMsg"
SGLRANKMSG.nested_types = {}
SGLRANKMSG.enum_types = {}
SGLRANKMSG.fields = {}
SGLRANKMSG.is_extendable = false
SGLRANKMSG.extensions = {
	var_0_9.RANK_UBOSS_REQ_FIELD,
	var_0_9.RANK_LADDER_REQ_FIELD,
	var_0_9.RANK_CHAR_REQ_FIELD,
	var_0_9.RANK_RESET_REQ_FIELD,
	var_0_9.RANK_TEAM_REQ_FIELD,
	var_0_9.RANK_LIST_RESP_FIELD,
	var_0_9.RANK_UBOSS_RESP_FIELD,
	var_0_9.RANK_PRE_RESP_FIELD,
	var_0_9.RANK_LADDER_RESP_FIELD,
	var_0_9.RANK_PRE_EX_RESP_FIELD,
	var_0_9.RANK_CHAR_RESP_FIELD,
	var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD
}
RankData = var_0_0.Message(RANKDATA)
RankListResp = var_0_0.Message(RANKLISTRESP)
RankLists = var_0_0.Message(RANKLISTS)
RankPreExResp = var_0_0.Message(RANKPREEXRESP)
RankPreResp = var_0_0.Message(RANKPRERESP)
SglRankMsg = var_0_0.Message(SGLRANKMSG)
TeamKey = var_0_0.Message(TEAMKEY)

var_0_1.SglReqMsg.RegisterExtension(var_0_9.RANK_UBOSS_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_9.RANK_LADDER_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_9.RANK_CHAR_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_9.RANK_RESET_REQ_FIELD)
var_0_1.SglReqMsg.RegisterExtension(var_0_9.RANK_TEAM_REQ_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_9.RANK_LIST_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_9.RANK_UBOSS_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_9.RANK_PRE_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_9.RANK_LADDER_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_9.RANK_PRE_EX_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_9.RANK_CHAR_RESP_FIELD)
var_0_1.SglRespMsg.RegisterExtension(var_0_9.RANK_TOP_TEAM_MVP_RESP_FIELD)
