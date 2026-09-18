local var_0_0 = class("MainTask")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._infoId = arg_1_1
	arg_1_0._info = Data._mainTaskInfo[arg_1_1]

	local var_1_0 = arg_1_0:getBonus()

	if var_1_0._info._type == 1 then
		var_1_0._task = arg_1_0
	end
end

function var_0_0.getBonus(arg_2_0)
	return P._playerBonus._bonuses[arg_2_0._info._bonusId]
end

function var_0_0.getDesc(arg_3_0)
	local var_3_0 = arg_3_0:getBonus()._info
	local var_3_1 = arg_3_0._info._type

	if var_3_1 == Data.MainTaskType.chapter then
		local var_3_2 = {
			Str(STR.STORY_LINE),
			Str(STR.REBEL),
			Str(STR.CHAOS)
		}
		local var_3_3 = Data._levelInfo[var_3_0._val]

		return string.format(Str(var_3_0._nameSid), string.format("%s" .. Str(STR.BRACKETS_S), Str(var_3_3._nameSid), var_3_2[math.floor(var_3_3._id / 10000)]))
	elseif var_3_1 == Data.MainTaskType.level then
		return string.format(Str(var_3_0._nameSid), var_3_0._val)
	elseif var_3_1 == Data.MainTaskType.card then
		local var_3_4 = var_3_0._val
		local var_3_5 = arg_3_0:getBonus()._info._cid

		if var_3_5 == 205 or var_3_5 == 305 then
			var_3_4 = var_3_4 + 1
		end

		return string.format(Str(var_3_0._nameSid), var_3_4)
	else
		return Str(var_3_0._nameSid)
	end
end

function var_0_0.getClaimableCount(arg_4_0)
	local var_4_0 = arg_4_0:getBonus()._info
	local var_4_1 = var_4_0._type
	local var_4_2 = var_4_0._cid
	local var_4_3 = 0

	for iter_4_0, iter_4_1 in pairs(P._playerAchieve._mainTasks) do
		local var_4_4 = iter_4_1:getBonus()

		if var_4_4._info._type == var_4_1 and var_4_4._info._cid == var_4_2 and var_4_4:canClaim() then
			var_4_3 = var_4_3 + 1
		end
	end

	return var_4_3
end

function var_0_0.isDefaultValid(arg_5_0)
	return not arg_5_0:isDone()
end

function var_0_0.isValid(arg_6_0)
	if not arg_6_0:isDefaultValid() then
		return false
	end

	local var_6_0 = arg_6_0._info._condition

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = P._playerAchieve._mainTasks[var_6_0[iter_6_0]]

		if var_6_1 ~= nil and not var_6_1:isDone() then
			return false
		end
	end

	if arg_6_0._infoId < 1000 then
		local var_6_2 = arg_6_0:getBonus()._info._val

		if Data._levelInfo[var_6_2] ~= nil then
			-- block empty
		end
	end

	return true
end

function var_0_0.isDone(arg_7_0)
	local var_7_0 = arg_7_0:getBonus()

	return var_7_0._value >= var_7_0._info._val and var_7_0._isClaimed
end

return var_0_0
