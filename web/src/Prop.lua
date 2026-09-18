local var_0_0 = class("Prop")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._infoId = arg_1_1
	arg_1_0._info = Data.getInfo(arg_1_1)

	if arg_1_2 ~= nil then
		arg_1_0._num = arg_1_2.num
	else
		arg_1_0._num = 0
	end
end

function var_0_0.getQuality(arg_2_0)
	return arg_2_0._info._quality
end

function var_0_0.sendPropDirty(arg_3_0)
	if arg_3_0._infoId >= 7201 and arg_3_0._infoId <= 7206 then
		if P._crown == nil or arg_3_0._infoId <= P._crown._infoId then
			P._crown = {
				_infoId = arg_3_0._infoId,
				_num = arg_3_0._num
			}

			local var_3_0 = cc.EventCustom:new(Data.Event.crown_dirty)

			var_3_0._data = arg_3_0

			lc.Dispatcher:dispatchEvent(var_3_0)
		end
	elseif arg_3_0._infoId >= 7201 and arg_3_0._infoId <= 7299 then
		if P._legendCrown == nil or arg_3_0._infoId <= P._legendCrown._infoId then
			P._legendCrown = {
				_infoId = arg_3_0._infoId,
				_num = arg_3_0._num
			}

			local var_3_1 = cc.EventCustom:new(Data.Event.crown_dirty)

			var_3_1._data = arg_3_0

			lc.Dispatcher:dispatchEvent(var_3_1)
		end
	elseif arg_3_0._infoId == 7208 then
		P._privilege = bor(P._privilege, Data.Privilege.foot_crown)

		local var_3_2 = cc.EventCustom:new(Data.Event.crown_dirty)

		var_3_2._data = arg_3_0

		lc.Dispatcher:dispatchEvent(var_3_2)
	elseif arg_3_0._infoId >= 7213 and arg_3_0._infoId <= 7215 then
		local var_3_3 = cc.EventCustom:new(Data.Event.crown_dirty)

		var_3_3._data = arg_3_0

		lc.Dispatcher:dispatchEvent(var_3_3)
	else
		local var_3_4 = cc.EventCustom:new(Data.Event.prop_dirty)

		var_3_4._data = arg_3_0

		lc.Dispatcher:dispatchEvent(var_3_4)
	end
end

return var_0_0
