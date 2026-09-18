local var_0_0 = require("Monster")
local var_0_1 = class("HireHero", Hero)

function var_0_1.ctor(arg_1_0, arg_1_1)
	if arg_1_1 then
		arg_1_0._guid = arg_1_1.id
		arg_1_0._ownerId = arg_1_1.owner_id

		local var_1_0
		local var_1_1

		for iter_1_0, iter_1_1 in ipairs(arg_1_1.cards) do
			local var_1_2 = Data.getType(iter_1_1.info_id)

			if var_1_2 == Data.CardType.monster then
				var_0_1.super.ctor(arg_1_0, iter_1_1.info_id, iter_1_1)
			elseif var_1_2 == Data.CardType.weapon then
				var_1_0 = require("EquipCard").create(iter_1_1.info_id, iter_1_1)
			elseif var_1_2 == Data.CardType.armor then
				var_1_1 = require("EquipCard").create(iter_1_1.info_id, iter_1_1)
			end
		end

		arg_1_0._weapon = var_1_0
		arg_1_0._armor = var_1_1

		local var_1_3

		if arg_1_1.timestamp then
			var_1_3 = arg_1_1.timestamp / 1000
		end

		arg_1_0:init(arg_1_0._ownerId == P._id, var_1_3)
	end

	arg_1_0:dirtyFightingValue()
end

function var_0_1.addHire(arg_2_0)
	local var_2_0 = var_0_1.new()

	var_2_0._infoId = arg_2_0._infoId

	arg_2_0:clone(nil, var_2_0)
	var_2_0:init(true)

	return var_2_0
end

function var_0_1.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._info = Data.getInfo(arg_3_0._infoId)
	arg_3_0._type = Data.CardType.monster
	arg_3_0._isMyHire = arg_3_1
	arg_3_0._timestamp = arg_3_2 or ClientData.getCurrentTime()
	arg_3_0._weaponId = 0
	arg_3_0._armorId = 0
	arg_3_0._troopPos = {}

	for iter_3_0 = 1, Data.TroopIndex.num do
		arg_3_0._troopPos[iter_3_0] = 0
	end
end

function var_0_1.calcMyHireRewards(arg_4_0)
	local var_4_0 = arg_4_0:getFightingValue()
	local var_4_1 = (ClientData.getCurrentTime() - arg_4_0._timestamp) / 3600

	return math.min(math.floor(var_4_0 * 25 * var_4_1 / 24), 500000)
end

function var_0_1.calcHireCost(arg_5_0)
	local var_5_0 = arg_5_0:getFightingValue()

	return math.floor(var_5_0 * 10)
end

function var_0_1.isNew(arg_6_0)
	return false
end

function var_0_1.isHired(arg_7_0)
	if arg_7_0._isHired == nil then
		arg_7_0._isHired = false

		local var_7_0 = P._playerUnion._hireMembers

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if iter_7_1 == arg_7_0._ownerId then
				arg_7_0._isHired = true

				break
			end
		end
	end

	return arg_7_0._isHired
end

function var_0_1.claimReward(arg_8_0)
	local var_8_0 = ClientData.getCurrentTime()

	if (var_8_0 - arg_8_0._timestamp) / 3600 < 1 then
		return 0
	else
		local var_8_1 = arg_8_0:calcMyHireRewards()

		P:changeResource(Data.ResType.gold, var_8_1)

		arg_8_0._timestamp = var_8_0

		return var_8_1
	end
end

return var_0_1
