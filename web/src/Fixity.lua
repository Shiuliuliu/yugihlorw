local var_0_0 = class("Fixity")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._infoId = arg_1_1
	arg_1_0._info = Data._fixityInfo[arg_1_0._infoId]
	arg_1_0._isLock = false

	if arg_1_0._infoId == Data.FixityId.farmland or arg_1_0._infoId == Data.FixityId.residence then
		arg_1_0._remainRes = 0
	elseif arg_1_0._infoId == Data.FixityId.guard then
		arg_1_0._guards = {}
	end
end

function var_0_0.getRes(arg_2_0, arg_2_1)
	if arg_2_1 < 0 then
		arg_2_1 = 0
	end

	local var_2_0 = 0

	if arg_2_0._infoId == Data.FixityId.residence then
		var_2_0 = math.floor(arg_2_1 * Data._globalInfo._residenceCapacity / (Data._globalInfo._residenceResumeTime * 60) + arg_2_0._remainRes)

		if var_2_0 > Data._globalInfo._residenceCapacity then
			var_2_0 = Data._globalInfo._residenceCapacity
		end
	elseif arg_2_0._infoId == Data.FixityId.farmland then
		var_2_0 = math.floor(arg_2_1 * Data._globalInfo._farmlandCapacity / (Data._globalInfo._farmlandResumeTime * 60) + arg_2_0._remainRes)

		if var_2_0 > Data._globalInfo._farmlandCapacity then
			var_2_0 = Data._globalInfo._farmlandCapacity
		end
	end

	return var_2_0
end

function var_0_0.clearRes(arg_3_0, arg_3_1)
	if arg_3_0._infoId ~= Data.FixityId.farmland and arg_3_0._infoId ~= Data.FixityId.residence then
		return
	end

	if arg_3_1 == nil or arg_3_1 < 0 then
		arg_3_0._remainRes = 0
	else
		arg_3_0._remainRes = arg_3_1
	end
end

function var_0_0.changeGuardHero(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == arg_4_2 then
		return Data.ErrorType.error
	end

	if arg_4_1 and not arg_4_3 then
		return Data.ErrorType.contain_guard_hero
	end

	if arg_4_1 then
		arg_4_1._taskId = nil

		arg_4_1:sendHeroGuardDirty()
		ClientData.sendGuard(slotId, arg_4_1._id, false)
	end

	if arg_4_2 then
		arg_4_2._taskId = 0

		arg_4_2:sendHeroGuardDirty()
		ClientData.sendHeroGuard(slotId, arg_4_2._id, true)
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._guards) do
		if iter_4_1._hero == arg_4_1 then
			if arg_4_2 then
				iter_4_1._hero = arg_4_2
				iter_4_1._timestamp = ClientData.getCurrentTime()
				iter_4_1._span = nil
			else
				table.remove(arg_4_0._guards, iter_4_0)
			end

			return Data.ErrorType.ok
		end
	end

	if arg_4_2 then
		table.insert(arg_4_0._guards, {
			_hero = arg_4_2,
			_timestamp = ClientData.getCurrentTime()
		})
	end

	return Data.ErrorType.ok
end

function var_0_0.getMinFragmentTimestamp(arg_5_0)
	if #arg_5_0._guards == 0 then
		return 0
	end

	table.sort(arg_5_0._guards, function(arg_6_0, arg_6_1)
		return arg_6_0._timestamp < arg_6_1._timestamp
	end)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._guards) do
		if iter_5_1._span then
			local var_5_0 = iter_5_1._span + iter_5_1._timestamp - ClientData.getCurrentTime()

			if var_5_0 > 0 then
				return var_5_0
			end
		end
	end

	return 0
end

function var_0_0.getFullGrainTimestamp(arg_7_0)
	return (Data._globalInfo._farmlandCapacity - arg_7_0._remainRes) * (Data._globalInfo._farmlandResumeTime * 60) / Data._globalInfo._farmlandCapacity + arg_7_0._timestamp
end

function var_0_0.getFullGoldTimestamp(arg_8_0)
	return (Data._globalInfo._residenceCapacity - arg_8_0._remainRes) * (Data._globalInfo._residenceResumeTime * 60) / Data._globalInfo._residenceCapacity + arg_8_0._timestamp
end

function var_0_0.sendFixityDirty(arg_9_0)
	local var_9_0 = cc.EventCustom:new(Data.Event.fixity_dirty)

	var_9_0._data = arg_9_0

	lc.Dispatcher:dispatchEvent(var_9_0)
end

return var_0_0
