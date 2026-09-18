local var_0_0 = class("Skin")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._infoId = arg_1_1
	arg_1_0._currentIds = {
		0,
		0,
		0,
		0
	}
	arg_1_0._availableSkins = {}
end

function var_0_0.createWithPb(arg_2_0)
	local var_2_0 = var_0_0.new()

	var_2_0:initByPb(arg_2_0)

	return var_2_0
end

function var_0_0.initByPb(arg_3_0, arg_3_1)
	arg_3_0._infoId = arg_3_1.info_id
	arg_3_0._currentIds[Data.SkinEffectType.skin] = arg_3_1.default_skin

	for iter_3_0 = 1, #arg_3_1.skin_id do
		arg_3_0._availableSkins[iter_3_0] = {
			_id = arg_3_1.skin_id[iter_3_0],
			_expire = math.floor(arg_3_1.expire[iter_3_0] / 1000)
		}
	end

	for iter_3_1 = 1, #arg_3_1.default_effects do
		local var_3_0 = arg_3_1.default_effects[iter_3_1]
		local var_3_1 = Data._skinInfo[var_3_0]

		arg_3_0._currentIds[var_3_1._type] = var_3_0
	end
end

function var_0_0.addAvailable(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = arg_4_0:isSkinIdAvailable(arg_4_1)
	local var_4_2 = arg_4_2 == 0 and 0 or ClientData.getExpireTimestamp(arg_4_2)

	if var_4_0 then
		var_4_1._expire = var_4_2
	else
		arg_4_0._availableSkins[#arg_4_0._availableSkins + 1] = {
			_id = arg_4_1,
			_expire = var_4_2
		}
	end
end

function var_0_0.isSkinIdAvailable(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0 = 1, #arg_5_0._availableSkins do
		if arg_5_1 == arg_5_0._availableSkins[iter_5_0]._id and (arg_5_0._availableSkins[iter_5_0]._expire == 0 or not arg_5_2) then
			return true, arg_5_0._availableSkins[iter_5_0]
		end
	end

	return false
end

function var_0_0.getCurrentId(arg_6_0, arg_6_1)
	return arg_6_0._currentIds[arg_6_1]
end

function var_0_0.setCurrentId(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._currentIds[arg_7_2] = arg_7_1
end

function var_0_0.getEffectCount(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._availableSkins) do
		local var_8_1 = Data._skinInfo[iter_8_1._id]

		if var_8_1 and (var_8_1._type == Data.SkinEffectType.attack or var_8_1._type == Data.SkinEffectType.toBoard or var_8_1._type == Data.SkinEffectType.onBoard) then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

return var_0_0
