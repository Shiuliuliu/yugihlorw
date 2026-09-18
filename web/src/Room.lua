local var_0_0 = class("Room")

function var_0_0.create(arg_1_0)
	local var_1_0

	if arg_1_0 then
		var_1_0 = var_0_0.new(arg_1_0)
	end

	return var_1_0
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:updateInfo(arg_2_1)
end

function var_0_0.clear(arg_3_0)
	arg_3_0._members = {}
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	arg_4_0._id = arg_4_1.id
	arg_4_0._hp = arg_4_1.match_hp
	arg_4_0._type = arg_4_1:HasField("type") and arg_4_1.type or Data.RoomType.normal

	local var_4_0 = require("User").create(arg_4_1.creator.info, true)

	var_4_0._idInRoom = arg_4_1.creator.id
	arg_4_0._creator = var_4_0
	arg_4_0._creator._roomJob = Data.RoomJob.leader

	local var_4_1
	local var_4_2
	local var_4_3

	if arg_4_1:HasField("playerO") then
		var_4_1 = require("User").create(arg_4_1.playerO.info, true)
		var_4_1._idInRoom = arg_4_1.playerO.id
		var_4_1._win = arg_4_1.playerO.win
		var_4_1._isOnline = arg_4_1.playerO.is_online
	end

	if arg_4_1:HasField("playerA") then
		var_4_2 = require("User").create(arg_4_1.playerA.info, true)
		var_4_2._idInRoom = arg_4_1.playerA.id
		var_4_2._win = arg_4_1.playerA.win
		var_4_2._isOnline = arg_4_1.playerA.is_online

		if arg_4_0._type == Data.RoomType.dark then
			var_4_2._troopMap = {}

			for iter_4_0, iter_4_1 in ipairs(arg_4_1.playerA.troop_ids) do
				var_4_2._troopMap[iter_4_1] = true
			end

			var_4_2._curTroop = arg_4_1.playerA.cur_troop_id
		end
	end

	if arg_4_1:HasField("playerB") then
		var_4_3 = require("User").create(arg_4_1.playerB.info, true)
		var_4_3._idInRoom = arg_4_1.playerB.id
		var_4_3._win = arg_4_1.playerB.win
		var_4_3._isOnline = arg_4_1.playerB.is_online

		if arg_4_0._type == Data.RoomType.dark then
			var_4_3._troopMap = {}

			for iter_4_2, iter_4_3 in ipairs(arg_4_1.playerB.troop_ids) do
				var_4_3._troopMap[iter_4_3] = true
			end

			var_4_3._curTroop = arg_4_1.playerB.cur_troop_id
		end
	end

	arg_4_0._members = {
		var_4_1,
		var_4_2,
		var_4_3
	}

	for iter_4_4, iter_4_5 in pairs(arg_4_0._members) do
		if iter_4_5 then
			if iter_4_5._idInRoom == arg_4_0._creator._idInRoom then
				iter_4_5._roomJob = Data.RoomJob.leader
			else
				iter_4_5._roomJob = Data.RoomJob.rookie
			end
		end
	end
end

function var_0_0.getMembers(arg_5_0)
	return arg_5_0._members
end

function var_0_0.sendRoomDirty(arg_6_0)
	local var_6_0 = cc.EventCustom:new(Data.Event.room_dirty)

	var_6_0._data = arg_6_0

	lc.Dispatcher:dispatchEvent(var_6_0)
end

return var_0_0
