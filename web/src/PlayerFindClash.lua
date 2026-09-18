local var_0_0 = class("PlayerFindClash")
local var_0_1 = require("Log")

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()

	arg_1_0._trophy = 0
	arg_1_0._ladderTrophy = 0

	ClientData.addMsgListener(arg_1_0, function(arg_2_0)
		return arg_1_0:onMsg(arg_2_0)
	end, 0)
	lc.addEventListener(Data.Event.prop_dirty, function(arg_3_0)
		arg_1_0:syncChests()
	end)
end

function var_0_0.clear(arg_4_0)
	arg_4_0._isSyncData = false
	arg_4_0._chests = {}
end

function var_0_0.simulate(arg_5_0)
	arg_5_0._isSyncData = true
	arg_5_0._endTime = 0
	arg_5_0._preRank = 0
	arg_5_0._preTrophy = 0
	arg_5_0._trophy = 600
	arg_5_0._grade = arg_5_0:getGrade(arg_5_0._trophy)
	arg_5_0._isFirst = true

	lc.sendEvent(Data.Event.clash_sync_ready)
end

function var_0_0.changeTrophy(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._trophy + arg_6_1

	if var_6_0 < 0 then
		var_6_0 = 0
	end

	arg_6_0._trophy = var_6_0
	arg_6_0._grade = arg_6_0:getGrade(var_6_0)

	for iter_6_0 = 1, #P._playerBonus._bonusClashTarget do
		P._playerBonus._bonusClashTarget[iter_6_0]:setValue(math.max(arg_6_0._trophy, P._playerBonus._bonusClashTarget[iter_6_0]._value))
	end

	lc.sendEvent(Data.Event.clash_trophy_dirty)
end

function var_0_0.changeLadderTrophy(arg_7_0, arg_7_1)
	arg_7_0._ladderTrophy = arg_7_0._ladderTrophy + arg_7_1

	lc.sendEvent(Data.Event.ladder_trophy_dirty)
end

function var_0_0.getGrade(arg_8_0, arg_8_1)
	for iter_8_0 = Data.FindClashGrade.bronze + 1, Data.FindClashGrade.legend do
		if arg_8_1 < Data._ladderInfo[iter_8_0]._trophy then
			return iter_8_0 - 1
		end
	end

	return Data.FindClashGrade.legend
end

function var_0_0.resetChests(arg_9_0)
	for iter_9_0 = Data.PropsId.clash_chest, Data.PropsId.clash_chest_end do
		local var_9_0 = P._propBag._props[iter_9_0]

		if var_9_0 and var_9_0._num > 0 then
			var_9_0._isOpened = false

			P._propBag:setProps(iter_9_0, 0)
		end
	end

	arg_9_0._chests = {}
end

function var_0_0.syncChests(arg_10_0)
	arg_10_0._chests = {}

	for iter_10_0 = Data.PropsId.clash_chest, Data.PropsId.clash_chest_end do
		local var_10_0 = P._propBag._props[iter_10_0]

		if var_10_0 and var_10_0._num > 0 then
			local var_10_1 = iter_10_0 % 10

			if arg_10_0._chests[var_10_1] == nil then
				local var_10_2 = math.floor((iter_10_0 - Data.PropsId.clash_chest) / 10) + 1

				arg_10_0._chests[var_10_1] = {
					_prop = var_10_0,
					_grade = var_10_2
				}
			end
		end
	end
end

function var_0_0.getChestGrade(arg_11_0, arg_11_1)
	if arg_11_0._chests[arg_11_1] then
		return arg_11_0._chests[arg_11_1]._grade
	else
		return arg_11_0._grade
	end
end

function var_0_0.isAllChestsOpened(arg_12_0)
	for iter_12_0 = 1, 5 do
		if arg_12_0._chests[iter_12_0] == nil or not arg_12_0._chests[iter_12_0]._prop._isOpened then
			return false
		end
	end

	return true
end

function var_0_0.onMsg(arg_13_0, arg_13_1)
	if arg_13_1.type == SglMsgType_pb.PB_TYPE_RANK_PRE then
		arg_13_0._isSyncData = true

		local var_13_0 = arg_13_1.Extensions[Rank_pb.SglRankMsg.rank_pre_resp]

		arg_13_0._endTime = var_13_0.end_time / 1000
		P._playerFindClashEx._endTime = var_13_0.legend_end_time / 1000
		arg_13_0._preRank = var_13_0.pre_rank
		arg_13_0._preTrophy = var_13_0.pre_trophy
		arg_13_0._trophy = 0

		arg_13_0:changeTrophy(var_13_0.trophy)

		arg_13_0._grade = arg_13_0:getGrade(arg_13_0._trophy)
		arg_13_0._period = var_13_0.period
		arg_13_0._isFirst = var_13_0.is_first
		arg_13_0._ladderTrophy = 0

		if var_13_0:HasField("ladder_ex_trophy") then
			arg_13_0:changeLadderTrophy(var_13_0.ladder_ex_trophy)
		end

		if var_13_0:HasField("legend_trophy") then
			P._playerFindClashEx._trophy = var_13_0.legend_trophy
		end

		local var_13_1 = Data._globalInfo._ladderStage

		for iter_13_0 = 0, #var_13_1 + 1 do
			local var_13_2 = var_13_0.ranks[iter_13_0 + 1]

			if var_13_2 then
				var_13_2.user_id = var_13_0.user_id
			end

			P._playerRank:parseRankData(var_13_2, SglMsgType_pb.PB_TYPE_RANK_PRE, iter_13_0)
		end

		arg_13_0._clashId = var_13_0.user_id

		local var_13_3 = var_13_0.legend_ranks[1]

		if var_13_3 then
			var_13_3.user_id = var_13_0.user_id

			P._playerRank:parseRankData(var_13_3, SglMsgType_pb.PB_TYPE_RANK_LEGEND_PRE, i)
		end

		arg_13_0:syncChests()
		lc.sendEvent(Data.Event.clash_sync_ready)

		return true
	end

	return false
end

return var_0_0
