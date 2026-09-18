local var_0_0 = class("PlayerRank")
local var_0_1 = require("Rank")

var_0_0.RANK_COUNT = 50

local var_0_2
local var_0_3

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
	lc.addEventListener(Data.Event.level_dirty, function()
		arg_1_0:clearRank(SglMsgType_pb.PB_TYPE_RANK_LEVEL)
		arg_1_0:clearRank(SglMsgType_pb.PB_TYPE_RANK_REGION)
	end)
	lc.addEventListener(Data.Event.chapter_level_dirty, function()
		arg_1_0:clearRank(SglMsgType_pb.PB_TYPE_RANK_STAR)
	end)
	lc.addEventListener(Data.Event.trophy_dirty, function()
		arg_1_0:clearRank(SglMsgType_pb.PB_TYPE_RANK_TROPHY)
	end)
	lc.addEventListener(Data.Event.dark_trophy_dirty, function()
		arg_1_0:clearRank(SglMsgType_pb.PB_TYPE_RANK_DARK)
	end)
	lc.addEventListener(Data.Event.union_level_upgrade, function()
		arg_1_0:clearRank(SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL)
	end)
	lc.addEventListener(Data.Event.clash_trophy_dirty, function()
		for iter_7_0 = 0, #Data._globalInfo._ladderStage + 1 do
			arg_1_0:clearRank(SglMsgType_pb.PB_TYPE_RANK_LADDER, iter_7_0)
		end
	end)
	ClientData.addMsgListener(arg_1_0, function(arg_8_0)
		return arg_1_0:onMsg(arg_8_0)
	end, 0)
end

function var_0_0.clear(arg_9_0)
	var_0_2 = 0
	var_0_3 = {}
end

function var_0_0.initRanks(arg_10_0)
	local var_10_0 = {}

	for iter_10_0 = 1, var_0_0.RANK_COUNT do
		table.insert(var_10_0, var_0_1.new())
	end

	return var_10_0
end

function var_0_0.parseRankData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:getRankName(arg_11_2, arg_11_3)
	local var_11_1, var_11_2 = (function(arg_12_0)
		if arg_11_0[var_11_0] == nil then
			arg_11_0[var_11_0] = arg_11_0:initRanks()
		end

		return arg_11_0[var_11_0]
	end)(arg_11_2)

	if arg_11_2 == SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL or arg_11_2 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_TIME or arg_11_2 == SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY then
		var_11_2 = true
	elseif arg_11_2 == SglMsgType_pb.PB_TYPE_RANK_PRE then
		var_11_1._isReserve = true
	end

	local var_11_3

	if arg_11_2 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM or arg_11_2 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM then
		var_11_3 = true
	end

	if arg_11_1 then
		var_11_1._count = #arg_11_1.data

		if arg_11_1:HasField("user_id") then
			var_11_1._rankId = arg_11_1.user_id
		elseif arg_11_2 == SglMsgType_pb.PB_TYPE_RANK_PRE or arg_11_2 == SglMsgType_pb.PB_TYPE_RANK_LADDER then
			var_11_1._rankId = (P and P._id) or 0
		else
			var_11_1._rankId = P._id
		end

		if arg_11_1:HasField("season") then
			var_11_1._season = arg_11_1.season
		end

		if arg_11_1:HasField("end_time") then
			var_11_1._endTime = arg_11_1.end_time / 1000
		end

		if arg_11_1:HasField("param") then
			var_11_1._param = arg_11_1.param
		end

		var_11_1._selfRank = nil
		if arg_11_1.self_rank then
			local var_sr_obj = var_0_1.new()
			var_sr_obj:set(arg_11_1.self_rank, arg_11_2, arg_11_3)
			var_11_1._selfRank = var_sr_obj
		end

		local var_11_4 = 1

		for iter_11_0 = 1, #arg_11_1.data do
			local var_11_5 = arg_11_1.data[iter_11_0]

			if arg_11_2 == SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY and var_11_5.union_info.member == 0 then
				var_11_1._count = var_11_1._count - 1
			else
				local var_11_6

				if var_11_4 <= var_0_0.RANK_COUNT then
					var_11_6 = var_11_1[var_11_4]

					var_11_6:set(var_11_5, arg_11_2, arg_11_3)
				end

				if not var_11_2 and not var_11_3 and var_11_5.user_info.id == var_11_1._rankId or var_11_2 and var_11_5.union_info.id == P._unionId or var_11_3 and var_11_5.team.id == P._playerUnion._groupId then
					if var_11_6 == nil then
						var_11_6 = var_0_1.new()

						var_11_6:set(var_11_5, arg_11_2, arg_11_3)

						var_11_1._count = var_11_1._count - 1
					end

					var_11_1._selfRank = var_11_6
				end

				var_11_4 = var_11_4 + 1
			end
		end
	else
		var_11_1._count = 0
		var_11_1._rankId = P._id
		var_11_1._selfRank = nil
	end

	var_0_3[var_11_0] = var_11_1

	arg_11_0:sendRankListDirty(arg_11_2, arg_11_3)
end

function var_0_0.getRanks(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0[arg_13_0:getRankName(arg_13_1, arg_13_2)]
end

function var_0_0.getRankName(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = ""

	if arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_LEVEL then
		var_14_0 = "lordLevel"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_POWER then
		var_14_0 = "power"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_STAR then
		var_14_0 = "cityStar"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_TROPHY then
		var_14_0 = "trophy"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL then
		var_14_0 = "unionLevel"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_BOSS then
		var_14_0 = "worldBoss"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE then
		var_14_0 = "uboss"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_TIME then
		var_14_0 = "unionBoss"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_LADDER then
		var_14_0 = "findClash"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_LADDER_EX then
		var_14_0 = "findLadder"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_PRE then
		var_14_0 = "findClashPre"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY then
		var_14_0 = "unionTrophy"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP then
		var_14_0 = "unionBattleMvp"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM then
		var_14_0 = "unionBattleTeam"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP then
		var_14_0 = "unionBattlePreMvp"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM then
		var_14_0 = "unionBattlePreTeam"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_DARK then
		var_14_0 = "dark"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_DARK_PRE then
		var_14_0 = "darkPre"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_ENVELOPE then
		var_14_0 = "envelope"
	elseif arg_14_1 == 1725 then
		var_14_0 = "newServer"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_TROPHY_ACTIVITY then
		var_14_0 = "trophy_activity"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_TROPHY_YEAR_ACTIVITY then
		var_14_0 = "rank1"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_LEGEND then
		var_14_0 = "PB_TYPE_RANK_LEGEND"
	elseif arg_14_1 == SglMsgType_pb.PB_TYPE_RANK_LEGEND_PRE then
		var_14_0 = "PB_TYPE_RANK_LEGEND_PRE"
	end

	return arg_14_2 and string.format("_%sRanks_%s", var_14_0, arg_14_2) or string.format("_%sRanks", var_14_0)
end

function var_0_0.getRankBonusInfo(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or SglMsgType_pb.PB_TYPE_RANK_TROPHY

	for iter_15_0, iter_15_1 in pairs(Data._rankBonusInfo) do
		if iter_15_1._type == arg_15_2 and arg_15_1 >= iter_15_1._min and arg_15_1 <= iter_15_1._max then
			return iter_15_1
		end
	end
end

function var_0_0.scheduler(arg_16_0, arg_16_1)
	var_0_2 = var_0_2 + arg_16_1

	if var_0_2 > 30 then
		var_0_2 = 0

		for iter_16_0, iter_16_1 in pairs(var_0_3) do
			if not iter_16_1._isReserve then
				var_0_3[iter_16_0] = nil
			end
		end
	end
end

function var_0_0.clearRank(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getRankName(arg_17_1, arg_17_2)

	var_0_3[var_17_0] = nil
end

function var_0_0.clearPreRank(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:getRankName(arg_18_1, arg_18_2)

	arg_18_0[var_18_0] = nil
	var_0_3[var_18_0] = nil
end

function var_0_0.sendRankRequest(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:getRankName(arg_19_1, arg_19_2)

	if not var_0_3[var_19_0] or arg_19_1 == SglMsgType_pb.PB_TYPE_RANK_ENVELOPE then
		ClientData.sendRankRequest(arg_19_1, arg_19_2)

		return true
	else
		arg_19_0:sendRankListDirty(arg_19_1, arg_19_2)
	end
end

function var_0_0.sendRankListDirty(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = cc.EventCustom:new(Data.Event.rank_list_dirty)

	var_20_0._type = arg_20_1
	var_20_0._subType = arg_20_2

	lc.Dispatcher:dispatchEvent(var_20_0)
end

function var_0_0.onMsg(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.type

	if var_21_0 == SglMsgType_pb.PB_TYPE_RANK_LEVEL or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_POWER or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_STAR or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_TROPHY or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_BOSS or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_TIME or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_LADDER or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_LADDER_EX or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_DARK or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_DARK_PRE or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_LEGEND or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_LEGEND_PRE or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_ENVELOPE or var_21_0 == 1725 or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_TROPHY_ACTIVITY or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_TROPHY_YEAR_ACTIVITY or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY then
		local var_21_1 = arg_21_1.Extensions[Rank_pb.SglRankMsg.rank_list_resp]
		local var_21_2

		if var_21_0 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE or var_21_0 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_TIME then
			var_21_2 = arg_21_1.Extensions[Rank_pb.SglRankMsg.rank_uboss_resp]
		elseif var_21_0 == SglMsgType_pb.PB_TYPE_RANK_LADDER then
			var_21_2 = arg_21_1.Extensions[Rank_pb.SglRankMsg.rank_ladder_resp]
		elseif var_21_0 == SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL then
			var_21_2 = arg_21_1.Extensions[Rank_pb.SglRankMsg.rank_char_resp]
		end

		arg_21_0:parseRankData(var_21_1, var_21_0, var_21_2)

		return true
	elseif var_21_0 == SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE then
		local var_21_3 = arg_21_1.Extensions[Rank_pb.SglRankMsg.rank_top_team_mvp_resp].ranks

		arg_21_0:parseRankData(var_21_3[1], SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM, nil)
		arg_21_0:parseRankData(var_21_3[2], SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP, nil)

		return true
	end

	return false
end

return var_0_0
