local var_0_0 = class("PropProp")
local var_0_1 = require("Prop")

function var_0_0.ctor(arg_1_0)
	arg_1_0._props = {}
end

function var_0_0.clear(arg_2_0)
	arg_2_0._props = {}
end

function var_0_0.init(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(Data._propsInfo) do
		local var_3_0 = var_0_1.new(iter_3_0)

		arg_3_0._props[var_3_0._infoId] = var_3_0
	end

	local var_3_1 = arg_3_1.props

	for iter_3_2 = 1, #var_3_1 do
		if Data.getType(var_3_1[iter_3_2].info_id) == Data.CardType.item_skill then
			arg_3_0._props[var_3_1[iter_3_2].info_id] = arg_3_0._props[var_3_1[iter_3_2].info_id] or var_0_1.new(var_3_1[iter_3_2].info_id)
		end

		local var_3_2 = arg_3_0._props[var_3_1[iter_3_2].info_id]

		if var_3_2 then
			var_3_2._num = var_3_1[iter_3_2].num
		end
	end

	local var_3_3 = arg_3_1.chests

	for iter_3_3 = 1, #var_3_3 do
		local var_3_4 = arg_3_0._props[var_3_3[iter_3_3].id]

		if var_3_4 then
			var_3_4._isOpened = var_3_3[iter_3_3].opened
			var_3_4._num = 1
		end
	end

	local var_3_5 = arg_3_1.crowns

	for iter_3_4 = 1, #var_3_5 do
		local var_3_6 = arg_3_0._props[var_3_5[iter_3_4].info_id]

		if var_3_6 then
			var_3_6._num = var_3_5[iter_3_4].num
		end
	end

	local var_3_7 = arg_3_1.legend_crowns

	for iter_3_5 = 1, #var_3_7 do
		local var_3_8 = arg_3_0._props[var_3_7[iter_3_5].info_id]

		if var_3_8 then
			var_3_8._num = var_3_7[iter_3_5].num
		end
	end
end

function var_0_0.hasProps(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._props[arg_4_1] ~= nil and arg_4_2 <= arg_4_0._props[arg_4_1]._num then
		return true
	end

	return false
end

function var_0_0.changeProps(arg_5_0, arg_5_1, arg_5_2)
	if Data.getType(arg_5_1) == Data.CardType.item_skill then
		arg_5_0._props[arg_5_1] = arg_5_0._props[arg_5_1] or var_0_1.new(arg_5_1)
	end

	local var_5_0 = arg_5_0._props[arg_5_1]

	if var_5_0 then
		if arg_5_2 == 0 then
			return true
		end

		local var_5_1 = var_5_0._num + arg_5_2

		if var_5_1 >= 0 then
			var_5_0._num = var_5_1

			var_5_0:sendPropDirty()

			return true
		end
	end

	return false
end

function var_0_0.setProps(arg_6_0, arg_6_1, arg_6_2)
	if Data.getType(arg_6_1) == Data.CardType.item_skill then
		arg_6_0._props[arg_6_1] = arg_6_0._props[arg_6_1] or var_0_1.new(arg_6_1)
	end

	local var_6_0 = arg_6_0._props[arg_6_1]

	if var_6_0 then
		var_6_0._num = arg_6_2

		var_6_0:sendPropDirty()
	end
end

function var_0_0.useProp(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2 or 1

	if arg_7_0:hasProps(arg_7_1._infoId, var_7_0) then
		arg_7_0:changeProps(arg_7_1._infoId, -var_7_0)

		return Data.ErrorType.ok
	end

	return Data.ErrorType.error
end

function var_0_0.validPropId(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0
	local var_8_1

	local function var_8_2(arg_9_0, arg_9_1)
		for iter_9_0 = arg_9_1, 1, -1 do
			if arg_8_0._props[arg_9_0 + iter_9_0]._num > 0 then
				return arg_9_0 + iter_9_0
			end
		end
	end

	if arg_8_1 == Data.PropsId.avatar_frame_level_rank or arg_8_1 == Data.PropsId.avatar_frame_level_rank1 or arg_8_1 == Data.PropsId.avatar_frame_level_rank2 or arg_8_1 == Data.PropsId.avatar_frame_level_rank3 then
		var_8_0 = Data.PropsId.avatar_frame_level_rank

		if arg_8_2 then
			var_8_1 = var_8_2(var_8_0, 3)
		end
	elseif arg_8_1 == Data.PropsId.avatar_frame_xmas or arg_8_1 == Data.PropsId.avatar_frame_xmas_1 or arg_8_1 == Data.PropsId.avatar_frame_xmas_2 then
		if arg_8_1 == Data.PropsId.avatar_frame_xmas_2 then
			var_8_0 = Data.PropsId.avatar_frame_xmas_1
		else
			var_8_0 = arg_8_1
		end

		if arg_8_2 then
			var_8_1 = var_8_2(Data.PropsId.avatar_frame_xmas, 2)
		end
	else
		var_8_0, var_8_1 = arg_8_1, arg_8_1
	end

	return var_8_0, var_8_1 or arg_8_1
end

function var_0_0.getCouldEquipSkillItems(arg_10_0, arg_10_1)
	local var_10_0 = Data.removeAdditional(arg_10_1)
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0._props) do
		if iter_10_1._num > 0 then
			local var_10_2 = Data.getExtraSid(iter_10_0)

			if var_10_2 > 0 and Data.canSkillRub(var_10_2, var_10_0) then
				var_10_1[#var_10_1 + 1] = iter_10_0
			end
		end
	end

	return var_10_1
end

return var_0_0
