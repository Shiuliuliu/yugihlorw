local var_0_0 = class("Message")
local var_0_1 = require("MarqueeManager")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	if type(arg_1_1) == "table" and not arg_1_1.HasField then
		arg_1_1.HasField = function(self, name) return rawget(self, name) ~= nil end
		arg_1_1.timestamp = arg_1_1.timestamp or (os.time() * 1000)
	end
	arg_1_0._timestamp = arg_1_1.timestamp / 1000

	local function var_1_0(arg_2_0)
		if arg_1_1:HasField(arg_2_0) then
			return arg_1_1[arg_2_0]
		end
	end

	if arg_1_2 == SglMsgType_pb.PB_TYPE_CHAT then
		arg_1_0._user = require("User").create(arg_1_1.user_info)

		if arg_1_0._user then
			arg_1_0._type = Data.MsgType.world
		else
			arg_1_0._type = Data.MsgType.bulletin
		end

		arg_1_0._content = arg_1_1.content

		if arg_1_0._user:hasPrivilege(Data.Privilege.survival) then
			arg_1_0._content = string.format(Str(STR.MESSAGE_SURVIVAL_FORMAT), arg_1_0._content)
		end
	elseif arg_1_2 == SglMsgType_pb.PB_TYPE_UNION_MESSAGE then
		arg_1_0._user = require("User").create(arg_1_1.user1)
		arg_1_0._type = Data.MsgType.union

		if arg_1_1:HasField("user2") then
			arg_1_0._target = require("User").create(arg_1_1.user2)
		end

		local var_1_1 = arg_1_1.type
		local var_1_2 = var_1_0("param1")
		local var_1_3 = var_1_0("param2")

		if var_1_1 == Union_pb.PB_UNION_JOIN then
			if arg_1_0._target then
				arg_1_0._content = string.format(Str(STR.BE_INVITED_TO) .. "%s", arg_1_0._target._name, Str(STR.UNION_JOIN_NEWS))
			else
				arg_1_0._content = Str(STR.UNION_JOIN_NEWS)
			end

			arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
		elseif var_1_1 == Union_pb.PB_UNION_CREATE then
			arg_1_0._content = string.format("%s|%s|", Str(STR.CREATE_UNION), arg_1_0._user._unionName)
			arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
		elseif var_1_1 == Union_pb.PB_UNION_KICKOUT then
			arg_1_0._content = string.format(Str(STR.UNION_KICKOUT_NEWS), arg_1_0._target._name)
			arg_1_0._clr = ClientView.COLOR_TEXT_RED_DARK
		elseif var_1_1 == Union_pb.PB_UNION_LEAVE then
			arg_1_0._content = Str(STR.UNION_LEAVE_NEWS)
			arg_1_0._clr = ClientView.COLOR_TEXT_RED_DARK
		elseif var_1_1 == Union_pb.PB_UNION_TO_CO_LEADER or var_1_1 == Union_pb.PB_UNION_TO_MEMBER then
			arg_1_0._content = string.format(Str(STR.UNION_CHANGE_JOB_NEWS), arg_1_0._target._name, Str(STR.ROOKIE + arg_1_0._target._unionJob - 1))
			arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
		elseif var_1_1 == var_1_1 == Union_pb.PB_UNION_TO_LEADER then
			arg_1_0._content = Str(STR.UNION_TO_LEADER)
			arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
		elseif var_1_1 == Union_pb.PB_UNION_RESIGN then
			arg_1_0._content = string.format(Str(STR.UNION_GIVE_LEADER_TO), arg_1_0._target._name)
			arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
		elseif var_1_1 == Union_pb.PB_UNION_UPGRADE then
			arg_1_0._content = string.format(Str(STR.UNION_UPGRADE_NEWS), var_1_2)
			arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
		elseif var_1_1 == Union_pb.PB_UNION_DONATE then
			local var_1_4 = arg_1_1.resource[1]

			arg_1_0._content = string.format(Str(STR.NEWS_MEMBER_CONTRIBUTE), var_1_4.num, Str(STR.SID_RES_NAME_13))
			arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
		elseif var_1_1 == Union_pb.PB_UNION_TECH_UPGRADE then
			local var_1_5 = P._playerUnion:getMyUnion()

			if var_1_5 then
				arg_1_0._content = string.format(Str(STR.UNION_UPGRADE_TECH_NEWS), Str(var_1_5._techs[var_1_3]._info._nameSid), var_1_2)
				arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
			else
				arg_1_0._content = ""
			end
		elseif var_1_1 == Union_pb.PB_UNION_RESCUE then
			-- block empty
		elseif var_1_1 == Union_pb.PB_UNION_IMPEACH then
			arg_1_0._content = Str(STR.UNION_IMPEACH_NEWS)
			arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
		elseif var_1_1 == Union_pb.PB_UNION_UNIMPEACH then
			arg_1_0._content = Str(STR.UNION_UNIMPEACH_NEWS)
			arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
		elseif var_1_1 == Union_pb.PB_UNION_IMPEACHED then
			arg_1_0._content = Str(STR.UNION_IMPEACHED_NEWS)
			arg_1_0._clr = ClientView.COLOR_TEXT_RED_DARK
		else
			arg_1_0._content = var_1_0("message")

			if arg_1_0._content == nil then
				arg_1_0._content = ""
			end
		end
	elseif arg_1_2 == SglMsgType_pb.PB_TYPE_NEWS then
		arg_1_0._user = require("User").create(arg_1_1.user1)
		arg_1_0._type = Data.MsgType.bulletin

		if arg_1_1:HasField("user2") then
			arg_1_0._target = require("User").create(arg_1_1.user2)
		end

		arg_1_0._items = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_1.resource) do
			table.insert(arg_1_0._items, {
				_infoId = iter_1_1.info_id,
				_num = iter_1_1.num,
				_isFragment = iter_1_1.is_fragment,
				_level = iter_1_1.level
			})
		end

		local var_1_6 = arg_1_0._items[1]

		local function var_1_7(arg_3_0)
			local var_3_0, var_3_1 = Data.getInfo(arg_3_0._infoId)

			if var_3_0 ~= nil then
				return Str(var_3_0._nameSid), ClientData.getStrByCardType(var_3_1)
			else
				return "", ClientData.getStrByCardType(var_3_1)
			end
		end

		local var_1_8 = arg_1_1.what
		local var_1_9 = var_1_0("param")

		if var_1_8 == News_pb.PB_NEWS_PURCHASE then
			arg_1_0._content = string.format(Str(STR.NEWS_VIP), arg_1_0._user._vip)
		elseif var_1_8 == News_pb.PB_NEWS_LOTTERY then
			arg_1_0._needMarquee = true

			local var_1_10 = Data.getRecruiteInfo(var_1_9)
			local var_1_11 = Str(var_1_10._nameSid)
			local var_1_12 = Str(STR.RP_GOOD)
			local var_1_13 = var_1_9 % 100

			if Data.getIsTimeLimitCriticalRecruite(var_1_10) then
				local var_1_14 = 1

				if arg_1_0._items[1]._num > 2 or arg_1_0._items[2] and arg_1_0._items[2]._num > 2 or arg_1_0._items[3] and arg_1_0._items[3]._num > 2 then
					local var_1_15 = 3

					var_1_12 = Str(STR.RP_GOOD_3)
				elseif arg_1_0._items[1]._num > 1 or arg_1_0._items[2] and arg_1_0._items[2]._num > 1 or arg_1_0._items[3] and arg_1_0._items[3]._num > 1 then
					local var_1_16 = 2

					var_1_12 = Str(STR.RP_GOOD_2)
				end

				arg_1_0._content = string.format(Str(STR.NEWS_LOTTERY_2), var_1_11, var_1_13, var_1_7(var_1_6), var_1_6._num > 1 and Str(STR.MULTIPY) .. var_1_6._num or "", arg_1_0._items[2] and var_1_7(arg_1_0._items[2]) or "", arg_1_0._items[2] and arg_1_0._items[2]._num > 1 and Str(STR.MULTIPY) .. arg_1_0._items[2]._num or "", arg_1_0._items[3] and var_1_7(arg_1_0._items[3]) or "", arg_1_0._items[3] and arg_1_0._items[3]._num > 1 and Str(STR.MULTIPY) .. arg_1_0._items[3]._num or "")
			else
				arg_1_0._content = string.format(Str(STR.NEWS_LOTTERY), var_1_11, var_1_13, var_1_7(var_1_6), #arg_1_0._items > 1 and Str(STR.SO_ON) or "")
			end

			if var_1_12 then
				arg_1_0._content = var_1_12 .. arg_1_0._content
			end
		elseif var_1_8 == News_pb.PB_NEWS_MIX then
			local var_1_17 = ClientData.getPlaceByCardType(Data.getType(var_1_6._infoId))
			local var_1_18, var_1_19 = var_1_7(var_1_6)

			arg_1_0._content = string.format(Str(STR.NEWS_MIX), var_1_17, var_1_19, var_1_18)
		elseif var_1_8 == News_pb.PB_NEWS_TRANSFORM then
			arg_1_0._content = string.format(Str(STR.NEWS_REBIRTH), var_1_7(var_1_6))
		elseif var_1_8 == News_pb.PB_NEWS_EXPEDITION then
			local var_1_20, var_1_21 = var_1_7(var_1_6)

			arg_1_0._content = string.format(Str(STR.NEWS_EXPEDITION), var_1_21, var_1_20)
			arg_1_0._needMarquee = true
		elseif var_1_8 == News_pb.PB_NEWS_RECRUIT then
			arg_1_0._content = string.format(Str(STR.NEWS_RECRUIT), var_1_7(var_1_6))
			arg_1_0._needMarquee = true
		elseif var_1_8 == News_pb.PB_NEWS_VISIT then
			arg_1_0._content = string.format(Str(STR.NEWS_VISIT), var_1_7(var_1_6))
		elseif var_1_8 == News_pb.PB_NEWS_UNION_CREATE then
			arg_1_0._content = string.format(Str(STR.NEWS_UNION_CREATE), arg_1_1.union1.name)
			arg_1_0._needMarquee = true
		elseif var_1_8 == News_pb.PB_NEWS_UNION_UPGRADE then
			local var_1_22 = arg_1_1.union1

			arg_1_0._content = string.format(Str(STR.NEWS_UNION_UPGRADE), var_1_22.name, var_1_22.level)
		elseif var_1_8 == News_pb.PB_NEWS_OPEN_CHEST then
			arg_1_0._content = string.format(Str(STR.NEWS_OPEN_CHEST), ClientData.getNameByInfoId(var_1_9), var_1_7(var_1_6), #arg_1_0._items > 1 and Str(STR.SO_ON) or "")
			arg_1_0._needMarquee = true
		elseif var_1_8 == News_pb.PB_NEWS_ATTACK_WIN then
			-- block empty
		elseif var_1_8 == News_pb.PB_NEWS_DEFEND_WIN then
			arg_1_0._content = string.format(Str(STR.NEWS_COPY_PVP_DEFEND_WIN), arg_1_0._user._name)

			arg_1_0:pushToMarquee(string.format("#|%s|#%s", arg_1_0._target._name, arg_1_0._content), true)
		elseif var_1_8 == News_pb.PB_NEWS_BUY then
			local var_1_23

			if var_1_9 == SglMsgType_pb.PB_TYPE_SHOP_BUY then
				var_1_23 = Str(STR.RANDOM_MARKET)
			elseif var_1_9 == SglMsgType_pb.PB_TYPE_SHOP_BUY_PVP then
				var_1_23 = Str(STR.FLAG_MARKET)
			elseif var_1_9 == SglMsgType_pb.PB_TYPE_UNION_BUY then
				var_1_23 = Str(STR.UNION_MARKET)
			end

			arg_1_0._content = string.format(Str(STR.NEWS_BUY), var_1_23, ClientData.getNameByInfoId(arg_1_0._items[1]._infoId))

			arg_1_0:pushToMarquee(string.format("#|%s|#%s", arg_1_0._user._name, arg_1_0._content))
		elseif var_1_8 == News_pb.PB_NEWS_RANK then
			arg_1_0._content = string.format(Str(STR.NEWS_RANK_CHANGE), var_1_9)

			arg_1_0:pushToMarquee(string.format("#|%s|#%s", arg_1_0._user._name, arg_1_0._content), true)
		elseif var_1_8 == News_pb.PB_NEWS_RANK_LADDER then
			arg_1_0._content = string.format(Str(STR.NEWS_RANK_LADDER_CHANGE), var_1_9)

			arg_1_0:pushToMarquee(string.format("#|%s|#%s", arg_1_0._user._name, arg_1_0._content), true)
		else
			arg_1_0._content = ""
		end
	elseif arg_1_2 == SglMsgType_pb.PB_TYPE_BATTLE_SHARE then
		arg_1_0._log = require("Log").new(arg_1_1.is_attack, arg_1_1.log)

		if arg_1_1:HasField("user_info") then
			if arg_1_0._log._isAttack then
				arg_1_0._user = arg_1_0._log._player
				arg_1_0._opponent = arg_1_0._log._opponent
				arg_1_0._resultType = arg_1_0._log._resultType
			else
				arg_1_0._user = arg_1_0._log._opponent
				arg_1_0._opponent = arg_1_0._log._player
				arg_1_0._resultType = -arg_1_0._log._resultType
			end

			arg_1_0._sender = require("User").create(arg_1_1.user_info)
			arg_1_0._content = arg_1_1.text

			if arg_1_0._content == "" or arg_1_0._content == Str(STR.SHARE_BATTLE_MSG) then
				arg_1_0._content = string.format("|%s|" .. Str(STR.SHARE_BATTLE_MSG), arg_1_1.user_info.name)
			else
				arg_1_0._content = string.format(Str(STR.SHARE_BATTLE_BY_USER), arg_1_1.user_info.name) .. arg_1_0._content
			end
		else
			arg_1_0._user = arg_1_0._log._player
			arg_1_0._opponent = arg_1_0._log._opponent
			arg_1_0._resultType = arg_1_0._log._resultType
			arg_1_0._content = Str(STR.SHARE_BATTLE_BY_SYS)
		end

		local var_1_24 = string.format("|\\255.255.255\\%s|", Str(STR.BRACKETS_S)) .. "%s"
		local var_1_25

		if arg_1_0._log._type == Battle_pb.PB_BATTLE_PLAYER then
			var_1_25 = Str(STR.FIND_TROPHY_TITLE)
		elseif arg_1_0._log._type == Battle_pb.PB_BATTLE_WORLD_LADDER then
			var_1_25 = Str(STR.FIND_CLASH_TITLE)
		elseif arg_1_0._log._type == Battle_pb.PB_BATTLE_WORLD_LADDER_EX then
			var_1_25 = Str(STR.FIND_ARENA_TITLE)
		end

		arg_1_0._content = string.format(var_1_24, var_1_25, arg_1_0._content)
		arg_1_0._type = Data.MsgType.battle
		arg_1_0._round = arg_1_1.round
		arg_1_0._watchIds = {}

		if arg_1_1.watched then
			for iter_1_2, iter_1_3 in ipairs(arg_1_1.watched) do
				arg_1_0._watchIds[iter_1_3] = true
			end

			arg_1_0._watchIdsCount = #arg_1_1.watched
		end

		arg_1_0._likeIds = {}

		for iter_1_4, iter_1_5 in ipairs(arg_1_1.thumbs_up) do
			arg_1_0._likeIds[iter_1_5] = true
		end

		arg_1_0._likeIdsCount = #arg_1_1.thumbs_up
	elseif arg_1_2 == SglMsgType_pb.PB_TYPE_FRIEND_BATTLE_START then
		arg_1_0._user = require("User").create(arg_1_1.user_info)
		arg_1_0._type = Data.MsgType.battle
		arg_1_0._battleId = arg_1_1.id
		arg_1_0._content = Str(STR.FRIEND_BATTLE_UNDER)
	elseif arg_1_2 == SglMsgType_pb.PB_TYPE_FRIEND_BATTLE then
		arg_1_0._type = Data.MsgType.union
		arg_1_0._content = Str(STR.FRIEND_BATTLE_INVITE)
		arg_1_0._clr = ClientView.COLOR_TEXT_ORANGE
		arg_1_0._battleId = arg_1_1.battle_id
		arg_1_0._unionId = arg_1_1.union_id
		arg_1_0._user = require("User").create(arg_1_1.user1)

		if arg_1_1:HasField("user2") then
			arg_1_0._opponent = require("User").create(arg_1_1.user2)
		end

		arg_1_0._isValid = arg_1_1.is_valid

		if arg_1_1:HasField("result") then
			arg_1_0._resultType = arg_1_1.result.result_type
			arg_1_0._replayId = arg_1_1.result.replay_id
		end
	end
end

function var_0_0.pushToMarquee(arg_4_0, arg_4_1, arg_4_2)
	if math.floor(arg_4_0._timestamp) > math.ceil(P._loginTime) then
		var_0_1.push(arg_4_1)
	end

	arg_4_0._hiddenInChat = arg_4_2
end

return var_0_0
