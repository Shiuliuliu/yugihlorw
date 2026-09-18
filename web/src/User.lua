local var_0_0 = class("User")

var_0_0.Users = {}

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.user_info or arg_1_0
	if type(var_1_0) == "table" and not var_1_0.HasField then
		var_1_0.HasField = function(self, name) return rawget(self, name) ~= nil end
		var_1_0.last_login = var_1_0.last_login or (os.time() * 1000)
		var_1_0.rid = var_1_0.rid or 10001
	end
	local var_1_1

	if arg_1_1 and var_0_0.Users[var_1_0.id] ~= nil then
		var_1_1 = var_0_0.Users[var_1_0.id]
	else
		var_1_1 = var_0_0.new(var_1_0.id)
	end

	var_1_1._badgeLevel = arg_1_0.badge_level or 0
	var_1_1._isBuybadge = arg_1_0.badge_purchased
	var_1_1._expDonate = arg_1_0.exp_donate
	var_1_1._name = var_1_0.name
	var_1_1._gold = var_1_0.gold
	var_1_1._grain = var_1_0.grain
	var_1_1._ingot = var_1_0.ingot
	var_1_1._level = var_1_0.level
	var_1_1._avatar = var_1_0.avatar
	var_1_1._exp = var_1_0.exp
	var_1_1._trophy = var_1_0.trophy or 800
	var_1_1._vip = var_1_0.vip
	var_1_1._shield = var_1_0.shield
	var_1_1._unionId = var_1_0.union_id
	var_1_1._unionName = var_1_0.union_name
	var_1_1._unionJob = var_1_0.union_title
	var_1_1._unionBadge = var_1_0.union_avatar
	var_1_1._unionWord = var_1_0.union_tag
	var_1_1._lastLogin = var_1_0.last_login / 1000
	var_1_1._regionId = var_1_0.rid
	var_1_1._regionId2 = var_1_0.rid % 10000
	var_1_1._privilege = var_1_0.privilege
	var_1_1._monthCardType = var_1_0.month_card

	if var_1_0._crown then
		var_1_1._crown = var_1_0._crown
	elseif var_1_0:HasField("crown") and var_1_0.crown then
		local cid = var_1_0.crown.info_id or var_1_0.crown._infoId
		local cnum = var_1_0.crown.num or var_1_0.crown._num or 1
		if cid and cid > 0 then
			var_1_1._crown = {
				_infoId = cid,
				_num = cnum
			}
		end
	end

	if not var_1_1._crown then
		local gc = tonumber(var_1_0.gold_cup or 0) or 0
		local sc = tonumber(var_1_0.silver_cup or 0) or 0
		local bc = tonumber(var_1_0.bronze_cup or 0) or 0
		if gc > 0 then
			var_1_1._crown = { _infoId = 7204, _num = gc }
		elseif sc > 0 then
			var_1_1._crown = { _infoId = 7205, _num = sc }
		elseif bc > 0 then
			var_1_1._crown = { _infoId = 7206, _num = bc }
		end
	end

	if var_1_0:HasField("legend_crown") then
		var_1_1._legendCrown = {
			_infoId = var_1_0.legend_crown.info_id,
			_num = var_1_0.legend_crown.num
		}
	end

	if var_1_0:HasField("avatar_frame_count") then
		var_1_1._avatarFrameCount = var_1_0.avatar_frame_count
	end

	if var_1_0:HasField("mass_war_score") then
		var_1_1._massWarScore = var_1_0.mass_war_score
	end

	var_1_1._avatarFrameId = var_1_0.avatar_frame

	if var_1_1._avatarFrameId == 0 then
		var_1_1._avatarFrameId = Data.PropsId.avatar_frame
	end

	return var_1_1
end

function var_0_0.createNpc()
	local var_2_0 = var_0_0.new(0)

	var_2_0._name = Str(STR.NPC_NAME)
	var_2_0._level = 1
	var_2_0._vip = 0
	var_2_0._unionId = 0
	var_2_0._avatar = 0
	var_2_0._avatarFrameId = Data.PropsId.avatar_frame

	return var_2_0
end

function var_0_0.ctor(arg_3_0, arg_3_1)
	arg_3_0._id = arg_3_1
	var_0_0.Users[arg_3_1] = arg_3_0
end

function var_0_0.getTitle(arg_4_0)
	for iter_4_0 = 1, #Data._globalInfo._playerTitleTrophy do
		if iter_4_0 < #Data._globalInfo._playerTitleTrophy then
			if arg_4_0._trophy >= Data._globalInfo._playerTitleTrophy[iter_4_0] and arg_4_0._trophy < Data._globalInfo._playerTitleTrophy[iter_4_0 + 1] then
				return iter_4_0
			end
		elseif arg_4_0._trophy >= Data._globalInfo._playerTitleTrophy[iter_4_0] then
			return iter_4_0
		end
	end
end

function var_0_0.getGrainCapacity(arg_5_0)
	local var_5_0 = arg_5_0._level

	if var_5_0 > #Data._globalInfo._grainCapacity then
		var_5_0 = #Data._globalInfo._grainCapacity
	end

	return Data._globalInfo._grainCapacity[var_5_0]
end

function var_0_0.sendUserDirty(arg_6_0)
	local var_6_0 = cc.EventCustom:new(Data.Event.user_dirty)

	var_6_0._data = arg_6_0

	lc.Dispatcher:dispatchEvent(var_6_0)
end

function var_0_0.hasPrivilege(arg_7_0, arg_7_1)
	return band(arg_7_0._privilege, arg_7_1) ~= 0
end

return var_0_0
