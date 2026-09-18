local var_0_0 = class("PlayerExpedition")

function var_0_0.ctor(arg_1_0)
	arg_1_0._troopInfos = {}
	arg_1_0._chests = {}
	arg_1_0._isRefreshed = false
end

function var_0_0.clear(arg_2_0)
	arg_2_0._isRefreshed = false
end

function var_0_0.refresh(arg_3_0, arg_3_1)
	arg_3_0._players = {}
	arg_3_0._troopInfos = {}
	arg_3_0._chests = {}
	arg_3_0._isRefreshed = true
	arg_3_0._reliveTimes = arg_3_1.recover_count
	arg_3_0._chapter = arg_3_1.chapter
	arg_3_0._sweepChapter = arg_3_1.sweep_chapter

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.troops) do
		local var_3_0 = ClientData.pbTroopToTroop(iter_3_1)

		table.insert(arg_3_0._troopInfos, var_3_0)
		table.insert(arg_3_0._players, require("User").create(iter_3_1.info))
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.chests) do
		table.insert(arg_3_0._chests, {
			_id = iter_3_3.id,
			_opened = iter_3_3.opened
		})
	end
end

function var_0_0.setCardDead(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0._troopInfos[arg_4_1]

	if var_4_0 ~= nil then
		for iter_4_0 = 1, #var_4_0 do
			local var_4_1 = var_4_0[iter_4_0]

			if var_4_1._id == arg_4_2 and var_4_1._type == arg_4_3 then
				var_4_1._isDead = true

				return
			end
		end
	end
end

function var_0_0.getDropDetail(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._chests[arg_5_1]._id
	local var_5_1

	for iter_5_0, iter_5_1 in pairs(Data._dropInfo) do
		if iter_5_1._type == 1007 and iter_5_1._value == var_5_0 then
			var_5_1 = iter_5_1

			break
		end
	end

	return var_5_1
end

function var_0_0.getReliveIngot(arg_6_0)
	return math.floor((arg_6_0._reliveTimes + 1) / 2) * 10
end

return var_0_0
