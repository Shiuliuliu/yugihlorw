local var_0_0 = require("Fixity")
local var_0_1 = class("PlayerCity")

function var_0_1.ctor(arg_1_0)
	arg_1_0._fixities = {}
end

function var_0_1.clear(arg_2_0)
	arg_2_0._fixities = {}
end

function var_0_1.init(arg_3_0, arg_3_1)
	local var_3_0 = 1

	for iter_3_0, iter_3_1 in pairs(Data._fixityInfo) do
		local var_3_1 = #iter_3_1._pos01

		for iter_3_2 = 1, var_3_1 do
			if iter_3_1._unlockLevel[iter_3_2] >= 200 then
				break
			end

			if iter_3_0 > Data.FixityId.activity then
				local var_3_2 = P._playerActivity._actFestivalTask

				if var_3_2 == nil or var_3_2._param[1] ~= iter_3_0 then
					break
				end
			end

			local var_3_3 = var_0_0.new(iter_3_0)

			table.insert(arg_3_0._fixities, var_3_3)

			if iter_3_0 == Data.FixityId.farmland then
				var_3_3._timestamp = arg_3_1.last_collect_grain / 1000
			elseif iter_3_0 == Data.FixityId.residence then
				var_3_3._timestamp = arg_3_1.last_collect_gold / 1000
			elseif iter_3_0 == Data.FixityId.guard then
				for iter_3_3, iter_3_4 in ipairs(arg_3_1.guards) do
					local var_3_4 = P._playerCard._monsters[iter_3_4.hero_id]

					if var_3_4 then
						var_3_4._taskId = 0

						table.insert(var_3_3._guards, {
							_hero = var_3_4,
							_timestamp = iter_3_4.timestamp / 1000,
							_span = iter_3_4.span / 1000
						})
					end
				end

				arg_3_0._guardFixity = var_3_3
			end
		end
	end

	table.sort(arg_3_0._fixities, function(arg_4_0, arg_4_1)
		return arg_4_0._infoId < arg_4_1._infoId
	end)

	for iter_3_5 = 1, #arg_3_0._fixities do
		arg_3_0._fixities[iter_3_5]._id = iter_3_5
		arg_3_0._fixities[iter_3_5]._isLock = P._level < arg_3_0:getUnlockLevel(arg_3_0._fixities[iter_3_5])
	end
end

function var_0_1.getGrainTime(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._fixities) do
		if iter_5_1._infoId == Data.FixityId.farmland and not iter_5_1._isLock then
			return iter_5_1:getFullGrainTimestamp() - ClientData.getCurrentTime()
		end
	end

	return 0
end

function var_0_1.getGoldTime(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._fixities) do
		if iter_6_1._infoId == Data.FixityId.residence and not iter_6_1._isLock then
			return iter_6_1:getFullGoldTimestamp() - ClientData.getCurrentTime()
		end
	end

	return 0
end

function var_0_1.getFragmentTime(arg_7_0)
	return arg_7_0._guardFixity:getMinFragmentTimestamp()
end

function var_0_1.getFixityCount(arg_8_0, arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_0._fixities) do
		if iter_8_1._infoId == arg_8_1 then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_1.getUnlockLevel(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1._info

	if #var_9_0._unlockLevel == 1 then
		return var_9_0._unlockLevel[1]
	else
		local var_9_1 = 0

		for iter_9_0, iter_9_1 in ipairs(arg_9_0._fixities) do
			if iter_9_1._infoId == arg_9_1._infoId then
				var_9_1 = var_9_1 + 1

				if iter_9_1 == arg_9_1 then
					return var_9_0._unlockLevel[var_9_1]
				end
			end
		end
	end

	return 0
end

function var_0_1.getUnlockFixityNumber(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or P._level

	local var_10_0 = Data._fixityInfo[arg_10_1]
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0._unlockLevel) do
		if iter_10_1 <= arg_10_2 then
			var_10_1 = var_10_1 + 1
		end
	end

	return var_10_1
end

function var_0_1.tryUnlockFixities(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = 0
	local var_11_4 = 0

	for iter_11_0, iter_11_1 in pairs(arg_11_0._fixities) do
		if iter_11_1._isLock then
			if P._level >= arg_11_0:getUnlockLevel(iter_11_1) then
				iter_11_1._isLock = false
				iter_11_1._timestamp = arg_11_1

				iter_11_1:sendFixityDirty()

				var_11_2[iter_11_1._infoId] = iter_11_1
			end
		elseif iter_11_1._infoId == Data.FixityId.farmland then
			var_11_3 = var_11_3 + iter_11_1:getRes(arg_11_1 - iter_11_1._timestamp)

			table.insert(var_11_0, iter_11_1)
		elseif iter_11_1._infoId == Data.FixityId.residence then
			var_11_4 = var_11_4 + iter_11_1:getRes(arg_11_1 - iter_11_1._timestamp)

			table.insert(var_11_1, iter_11_1)
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_11_2) do
		if iter_11_2 == Data.FixityId.farmland then
			local var_11_5 = var_11_3 / (#var_11_0 + 1)

			for iter_11_4 = 1, #var_11_0 do
				var_11_0[iter_11_4]._timestamp = arg_11_1
				var_11_0[iter_11_4]._remainRes = var_11_5
			end

			iter_11_3._remainRes = var_11_5
		elseif iter_11_2 == Data.FixityId.residence then
			local var_11_6 = var_11_4 / (#var_11_1 + 1)

			for iter_11_5 = 1, #var_11_1 do
				var_11_1[iter_11_5]._timestamp = arg_11_1
				var_11_1[iter_11_5]._remainRes = var_11_6
			end

			iter_11_3._remainRes = var_11_6
		end
	end
end

function var_0_1.getBlacksmithUnlockLevel(arg_12_0)
	return Data._fixityInfo[Data.FixityId.blacksmith]._unlockLevel[1]
end

function var_0_1.getPalaceUnlockLevel(arg_13_0)
	return Data._fixityInfo[Data.FixityId.palace]._unlockLevel[1]
end

function var_0_1.getStableUnlockLevel(arg_14_0)
	return Data._fixityInfo[Data.FixityId.stable]._unlockLevel[1]
end

function var_0_1.getLibraryUnlockLevel(arg_15_0)
	return Data._fixityInfo[Data.FixityId.library]._unlockLevel[1]
end

function var_0_1.getMarketUnlockLevel(arg_16_0)
	return Data._fixityInfo[Data.FixityId.market]._unlockLevel[1]
end

function var_0_1.getGuardUnlockLevel(arg_17_0)
	return Data._fixityInfo[Data.FixityId.guard]._unlockLevel[1]
end

function var_0_1.getUnionUnlockLevel(arg_18_0)
	return Data._fixityInfo[Data.FixityId.union]._unlockLevel[1]
end

function var_0_1.getFixity(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._fixities) do
		if iter_19_1._infoId == arg_19_1 then
			return iter_19_1
		end
	end
end

function var_0_1.getUnlockFarmlands(arg_20_0)
	local var_20_0 = {}

	for iter_20_0 = 1, #arg_20_0._fixities do
		if arg_20_0._fixities[iter_20_0]._infoId == Data.FixityId.farmland and not arg_20_0._fixities[iter_20_0]._isLock then
			table.insert(var_20_0, arg_20_0._fixities[iter_20_0])
		end
	end

	return var_20_0
end

function var_0_1.getUnlockResidences(arg_21_0)
	local var_21_0 = {}

	for iter_21_0 = 1, #arg_21_0._fixities do
		if arg_21_0._fixities[iter_21_0]._infoId == Data.FixityId.residence and not arg_21_0._fixities[iter_21_0]._isLock then
			table.insert(var_21_0, arg_21_0._fixities[iter_21_0])
		end
	end

	return var_21_0
end

return var_0_1
