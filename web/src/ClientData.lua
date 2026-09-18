local var_0_0 = {}
var_0_0._language = _G._cachedLanguage or (rawget(_G, 'ClientData') and ClientData._language)

var_0_0.DEBUG_GUIDE_ID = nil

if lc.PLATFORM == cc.PLATFORM_OS_WINDOWS then
	local var_0_1 = lc.readFile("config.json")

	if var_0_1 and var_0_1 ~= "" then
		var_0_0._cfg = json.decode(var_0_1).init_cfg
	else
		var_0_0._cfg = {}
	end

	var_0_0.DEBUG_USER_ID = var_0_0._cfg.userId

	if var_0_0.DEBUG_USER_ID == 0 then
		var_0_0.DEBUG_USER_ID = nil
	end
else
	var_0_0._cfg = {}
	var_0_0.DEBUG_USER_ID = nil
end

var_0_0.DEBUG_UNION = false
var_0_0.CAMERA_2D_FLAG = 1
var_0_0.CAMERA_3D_FLAG = 2
var_0_0.BIRDVIEW_ANGLE = 10
var_0_0.MAX_INPUT_LEN = 50
var_0_0.MAX_NAME_DISPLAY_LEN = 190
var_0_0.MAX_GROUP_NAME_DISPLAY_LEN = 170
var_0_0.MAX_MSG_COUNT = 100
var_0_0.MAX_UNION_MSG_COUNT = 30
var_0_0.CARDS_IMG_COUNT = 10
var_0_0.POS_UNLOCK_LEVEL = 40
var_0_0.ConfigKey = {
	gexin_push_id = "GEXIN_PUSH_ID",
	new_defense_log = "NEW_DEFENSE_LOG",
	new_clash_log = "NEW_CLASH_LOG",
	region_info = "REGION_INFO",
	pos_on = "POS_ON",
	lock_level_vip = "LOCK_LEVEL_VIP",
	agreement = "AGREEMENT",
	push_guard_fragment = "PUSH_GUARD_FRAGMENT",
	new_attack_log = "NEW_ATTACK_LOG",
	push_grain_night = "PUSH_GRAIN_NIGHT",
	new_notice_mail = "NEW_NOTICE_MAIL",
	push_copy_pvp_unlock = "PUSH_COPY_PVP_UNLOCK",
	new_card = "NEW_CARD",
	new_bulletin_msg = "NEW_NEWS_MSG",
	push_grain_noon = "PUSH_GRAIN_NOON",
	push_reward_send = "PUSH_REWARD_SEND",
	lock_level_split = "LOCK_LEVEL_SPLIT",
	last_login = "LAST_LOGIN",
	push_union_help = "PUSH_UNION_HELP",
	lock_level_herocenter = "LOCK_LEVEL_HEROCENTER",
	push_palace_task = "PUSH_PALACE_TASK",
	new_ladder_log = "NEW_LADDER_LOG",
	lock_level_battle = "LOCK_LEVEL_BATTLE",
	push_copy_pvp = "PUSH_COPY_PVP",
	new_union_mail = "NEW_UNION_MAIL",
	effect_on = "EFFECT_ON",
	new_friend_mail = "NEW_FRIEND_MAIL",
	battle_speed = "BATTLE_SPEED",
	music_on = "MUSIC_ON",
	battle_manual_guide_done = "BATTLE_MANUAL_GUIDE_DONE",
	last_level = "LAST_LEVEL",
	new_union_defense_log = "NEW_UNION_DEFENSE_LOG",
	activity_show_day = "ACTIVITY_SHOW_DAY",
	video_played = "VIDEO_PLAYED",
	new_friend = "NEW_FRIEND",
	battle_need_manual_guide = "BATTLE_NEED_MANUAL_GUIDE",
	new_union_msg = "NEW_UNION_MSG",
	new_announce = "NEW_ANNOUNCE",
	push_grain_full = "PUSH_GRAIN_FULL",
	new_world_msg = "NEW_WORLD_MSG",
	new_section = "NEW_SECTION",
	prompt_rate_game = "PROMPT_RATE_GAME",
	new_union_attack_log = "NEW_UNION_ATTACK_LOG",
	lock_level_city = "LOCK_LEVEL_CITY",
	cur_troop = "CUR_TROOP",
	push_gold_full = "PUSH_GOLD_FULL",
	new_battle_msg = "NEW_BATTLE_MSG",
	lock_level_equip = "LOCK_LEVEL_EQUIP"
}
var_0_0.SceneId = {
	factory_trap = 9,
	crusade = 30,
	activity = 24,
	union = 26,
	expedition = 19,
	survival_hall = 52,
	tavern = 5,
	loading = 1,
	manage_troop = 17,
	factory_rare = 10,
	lottery = 38,
	train = 21,
	skin_shop = 39,
	city = 2,
	factory_magic = 8,
	factory_monster = 7,
	effect = 53,
	res_switch = 18,
	world = 3,
	illustrations = 16,
	pawnshops = 15,
	recharge = 36,
	card_operate = 54,
	festival_lottery = 55,
	survival_ex_hall = 56,
	checkin = 32,
	battle = 4,
	find = 33,
	union_battle = 50,
	book_lottery = 25,
	union_battle_group = 51,
	race = 20,
	region = 22,
	room = 40,
	in_room = 41,
	market = 12,
	union_war = 28,
	store = 14,
	guard = 29,
	union_world = 27,
	depot = 34,
	transfer = 35,
	visit = 23
}
var_0_0.ZOrder = {
	side = 20,
	effect = 40,
	guide = 50,
	dialog = 70,
	form = 30,
	ui = 10,
	indicator = 60,
	toast = 80
}
var_0_0.OnMsgPriority = {
	scene = 100,
	after_scene = 200,
	before_scene = 0
}
var_0_0.SocketStatus = {
	disconnected = 1,
	login = 3,
	connected = 2
}
var_0_0.LCResType = {
	texture = 1,
	sprite_frame = 2,
	sprite_frames = 4
}
var_0_0.SocketLog = {
	disconnect = "disconnect",
	reconnect = "reconnect",
	unstable = "unstable",
	reachability_changed = "reachability_changed",
	recover = "recover"
}
var_0_0._lcres = {}

local var_0_2 = 4096
local var_0_3 = "socketLog.txt"

function var_0_0.init()
	var_0_0._msgListeners = {}
	var_0_0._errorListeners = {}
	var_0_0._evtListeners = {}

	table.insert(var_0_0._evtListeners, lc.addEventListener(Data.Event.application, function(arg_2_0)
		var_0_0.onApplicationEvent(arg_2_0)
	end))
	table.insert(var_0_0._evtListeners, lc.addEventListener(require("Socket_pb").Event.connect_fail, function(arg_3_0)
		var_0_0.onConnectFail()
		lc._runningScene:onConnectFailEvent(arg_3_0)
	end))
	table.insert(var_0_0._evtListeners, lc.addEventListener(require("Socket_pb").Event.disconnect, function(arg_4_0)
		var_0_0.onDisconnect()
		lc._runningScene:onDisconnectEvent(arg_4_0)
	end))
	table.insert(var_0_0._evtListeners, lc.addEventListener(GuideManager.Event.seek, function(arg_5_0)
		lc._runningScene:onGuide(arg_5_0)
	end))
	table.insert(var_0_0._evtListeners, lc.addEventListener(Data.Event.friend, function(arg_6_0)
		lc._runningScene:onFriend(arg_6_0._event)
	end))
	table.insert(var_0_0._evtListeners, lc.addEventListener(Data.Event.mail, function(arg_7_0)
		lc._runningScene:onMail(arg_7_0._event)
	end))
	var_0_0.addMsgListener(var_0_0, function(arg_8_0)
		return var_0_0.onMsgBeforeScene(arg_8_0)
	end, var_0_0.OnMsgPriority.before_scene)
	var_0_0.addMsgListener(var_0_0, function(arg_9_0)
		local var_9_0 = lc._runningScene

		if var_9_0 and var_9_0.onMsg then
			return var_9_0:onMsg(arg_9_0)
		end
	end, var_0_0.OnMsgPriority.scene)
	var_0_0.addMsgListener(var_0_0, function(arg_10_0)
		return var_0_0.onMsgAfterScene(arg_10_0)
	end, var_0_0.OnMsgPriority.after_scene)
	var_0_0.addErrorListener(var_0_0, function(arg_11_0)
		local var_11_0 = lc._runningScene

		if var_11_0 and var_11_0.onError then
			return var_11_0:onError(arg_11_0)
		end
	end, 0)
	var_0_0.toggleAudio(lc.Audio.Behavior.music, lc.UserDefault:getBoolForKey(var_0_0.ConfigKey.music_on, true))
	var_0_0.toggleAudio(lc.Audio.Behavior.effect, lc.UserDefault:getBoolForKey(var_0_0.ConfigKey.effect_on, true))
	lc.Director:setIdleTime(180)
	lc.Director:setBlurParam(512, 384, "res/shader/blur_gaussian_x.fsh", "res/shader/blur_gaussian_y.fsh")
	var_0_0.initCamera3D()

	ClientData._subChannelUid = nil
	ClientData._isFromGameCenter = nil

	if ClientData.isOppo() then
		local var_1_0 = ClientData.getSubChannelInfo(true)

		if var_1_0 and var_1_0.uid then
			ClientData._subChannelUid = var_1_0.uid
			ClientData._isFromGameCenter = var_1_0.isfromcenter
		end
	end

	var_0_0._player = require("Player").new()
	P = var_0_0._player
	var_0_0._savedUnionData = {}
	var_0_0._option = lc.App.getOption and lc.App:getOption() or 0
	var_0_0._socketStatus = var_0_0.SocketStatus.disconnected

	local var_1_1 = os.time()

	var_0_0._timezone = os.difftime(var_1_1, os.time(os.date("!*t", var_1_1)))
	var_0_0._btnClickTime = 0
end

function var_0_0.loadLCRes(arg_12_0)
	print(arg_12_0)

	if ClientData.isAppStoreReviewing() and arg_12_0 == "res/city.lcres" then
		var_0_0.loadLCRes("res/city_2.lcres")
	end

	if var_0_0.getBinVersion() == "1.5.0" then
		local var_12_0 = lc.readFile(arg_12_0, 0, 44)
		local var_12_1 = #var_12_0
		local var_12_2 = {}

		if string.sub(var_12_0, 1, 3) ~= "LCR" then
			return var_12_2
		end

		local var_12_3, var_12_4, var_12_5, var_12_6 = string.unpack(string.sub(var_12_0, 4, 12), "b<i<i")
		local var_12_7 = 44
		local var_12_8 = {}

		local function var_12_9(arg_13_0)
			local var_13_0 = arg_13_0.jpg
			local var_13_1 = arg_13_0.mask
			local var_13_2 = arg_13_0.sfb

			if var_13_0 and var_13_1 and var_13_2 then
				local var_13_3 = lc.TextureCache:addImageWithMask(var_13_0.data, var_13_0.len, var_13_1.data, var_13_1.len, var_13_0.name)

				var_0_0._lcres[var_13_0.name] = var_13_3

				local var_13_4 = var_13_2.name

				lc.FrameCache:addSpriteFramesWithData(var_13_2.data, var_13_2.len, var_13_3)

				var_0_0._lcres[var_13_4] = var_0_0.LCResType.sprite_frames
				var_12_8 = {}

				local var_13_5 = cc.EventCustom:new(Data.Event.resource)

				var_13_5:setUserString(var_13_4)
				lc.Dispatcher:dispatchEvent(var_13_5)
			end
		end

		while true do
			local var_12_10 = lc.readFile(arg_12_0, var_12_7, 256)

			if var_12_10 == nil then
				break
			end

			local var_12_11, var_12_12, var_12_13, var_12_14, var_12_15 = string.unpack(var_12_10, "bb<Ib")
			local var_12_16 = string.sub(var_12_10, 8, 7 + var_12_15)
			local var_12_17 = var_0_0.decrypt(var_12_16, var_12_5, 1)

			var_12_5 = bit.band(var_12_5 + var_12_6, 4294967295)

			local var_12_18, var_12_19 = string.unpack(string.sub(var_12_10, 8 + var_12_15), "<I")

			var_12_7 = var_12_7 + 11 + var_12_15

			if var_0_0._lcres[var_12_17] == nil then
				local var_12_20 = lc.readFile(arg_12_0, var_12_7, var_12_19)

				if string.hasSuffix(var_12_17, ".jpm") then
					var_12_20 = var_0_0.decrypt(var_12_20, var_12_5, var_12_13)

					local var_12_21, var_12_22, var_12_23 = string.unpack(string.sub(var_12_20, 5, 12), "<I<I")
					local var_12_24 = string.sub(var_12_20, 13, 12 + var_12_22)

					var_12_8.jpg = {
						name = var_12_17,
						data = var_12_24,
						len = var_12_22
					}

					local var_12_25 = string.sub(var_12_20, 13 + var_12_22, 12 + var_12_22 + var_12_23)

					var_12_8.mask = {
						data = var_12_25,
						len = var_12_23
					}

					var_12_9(var_12_8)
					table.insert(var_12_2, var_12_17)
				elseif string.hasSuffix(var_12_17, ".sfb") then
					var_12_20 = var_0_0.decrypt(var_12_20, var_12_5, var_12_13)
					var_12_8.sfb = {
						name = var_12_17,
						data = var_12_20,
						len = var_12_19
					}

					var_12_9(var_12_8)
					table.insert(var_12_2, var_12_17)
				elseif string.hasSuffix(var_12_17, ".lan") then
					local var_12_26 = var_0_0.decrypt(var_12_20, var_12_5, var_12_13)

					var_0_0.addLanguage(var_12_26)
				end
			else
				local var_12_27 = cc.EventCustom:new(Data.Event.resource)

				var_12_27:setUserString(var_12_17)
				lc.Dispatcher:dispatchEvent(var_12_27)
			end

			var_12_5 = bit.band(var_12_5 + var_12_6, 4294967295)
			var_12_7 = var_12_7 + var_12_19
		end

		local var_12_28

		do return var_12_2 end
		return
	end

	return lc.App:loadRes(arg_12_0)
end

function var_0_0.unloadLCRes(arg_14_0)
	if var_0_0.getBinVersion() == "1.5.0" then
		if #arg_14_0 == 0 then
			return
		end

		for iter_14_0, iter_14_1 in ipairs(arg_14_0) do
			print("unload res", iter_14_1)

			local var_14_0 = var_0_0._lcres[iter_14_1]

			if type(var_14_0) == "userdata" then
				lc.TextureCache:removeTextureForKey(iter_14_1)
				lc.FrameCache:removeSpriteFramesFromTexture(var_14_0)
			end

			var_0_0._lcres[iter_14_1] = nil
		end
	else
		lc.App:unloadRes(arg_14_0)
	end
end

function var_0_0.str(arg_15_0, arg_15_1)
	local var_15_0, var_15_1 = var_0_0.getBinVersion()

	if var_15_0 == "1.5.0" then
		local lang = var_0_0._language or _G._cachedLanguage or (rawget(_G, 'ClientData') and ClientData._language)
		var_15_1 = lang and lang[arg_15_0]

		if var_15_1 then
			var_15_1 = string.gsub(var_15_1, "\\n", "\n")
		end
	else
		var_15_1 = lc.str(arg_15_0, arg_15_1)
	end

	if var_15_1 == nil or var_15_1 == "" then
		local var_15_2 = string.format("region:%s, id:%s", var_0_0._userRegion and var_0_0._userRegion._id or "NA", P and P._id or "NA")
		local var_15_3 = string.format("[LUA ERROR]: <SceneId:%s> %s\n%s ", lc._runningScene and lc._runningScene._sceneId or "NA", string.format("Faild to get string id = %s", tostring(arg_15_0)), debug.traceback())

		print(var_15_3)

		if lc.PLATFORM ~= cc.PLATFORM_OS_WINDOWS then
			onLuaException(var_15_2, var_15_3)
		end
	end

	return var_15_1 or ""
end

function var_0_0.decrypt(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = ""

	if arg_16_2 == 1 or #arg_16_0 <= var_0_2 then
		var_16_0 = string.decrypt(arg_16_0, arg_16_1)
	else
		var_16_0 = string.decrypt(string.sub(arg_16_0, 1, var_0_2), arg_16_1) .. string.sub(arg_16_0, var_0_2 + 1)
	end

	return var_16_0
end

function var_0_0.addLanguage(arg_17_0)
	var_0_0._language = {}

	local var_17_0 = string.splitByChar(arg_17_0, "\n")

	for iter_17_0 = 1, #var_17_0 do
		local var_17_1
		local var_17_2 = string.splitByChar(var_17_0[iter_17_0], ",")
		local var_17_3 = 1
		local var_17_4 = #var_17_2

		repeat
			local var_17_5 = var_17_2[var_17_3]

			if var_17_5[1] == "\"" then
				repeat
					if var_17_3 < #var_17_2 then
						var_17_3 = var_17_3 + 1
						var_17_5 = var_17_5 .. var_17_2[var_17_3]
					end
				until var_17_5[-1] == "\""

				var_17_5 = string.sub(var_17_5, 2, #var_17_5 - 1)
			end

			var_17_1 = var_17_5
		until true

		var_0_0._language[#var_0_0._language + 1] = var_17_1
	end
	_G._cachedLanguage = var_0_0._language
	if rawget(_G, 'ClientData') and type(ClientData) == 'table' then ClientData._language = var_0_0._language end
end

function var_0_0.getAppId()
	return lc.App.getAppId and lc.App:getAppId() or ""
end

function var_0_0.getAppName()
	local var_19_0 = lc.App:getChannelName()
	local var_19_1 = lc.App:getRedirectGameServer()

	if var_19_0 == "ASDK" then
		local var_19_2 = ClientData.getAppId()

		if var_19_2 == "1223968820" or var_19_2 == "1233056141" or var_19_2 == "1238592436" or var_19_2 == "1253377972" or var_19_2 == "1258093284" or var_19_2 == "1266610857" or var_19_2 == "1279610129" then
			return Str(STR.APP_NAME_JDZC)
		elseif var_19_2 == "1224018227" or var_19_2 == "1233068376" or var_19_2 == "1276986300" then
			return Str(STR.APP_NAME_JDXY)
		elseif var_19_2 == "1224451743" then
			return Str(STR.APP_NAME_JDWG)
		elseif var_19_2 == "1226367282" or var_19_2 == "1268939521" then
			return Str(STR.APP_NAME_YXJDW)
		elseif var_19_2 == "1245141618" then
			return Str(STR.APP_NAME_JDGS)
		elseif var_19_2 == "1227413760" then
			return Str(STR.APP_NAME_JDW)
		elseif var_19_2 == "1227583177" then
			return Str(STR.APP_NAME_ZQJDW)
		elseif var_19_2 == "1233975630" or var_19_2 == "1271285460" then
			return Str(STR.APP_NAME_JDYXW)
		elseif var_19_2 == "1243370767" then
			return Str(STR.APP_NAME_YXWDM)
		elseif var_19_2 == "1263797229" then
			return Str(STR.APP_NAME_HDLL)
		elseif var_19_2 == "1248760084" then
			return Str(STR.APP_NAME_JDZC) .. "OL"
		elseif var_19_2 == "1249631440" then
			return Str(STR.APP_NAME_YXS)
		elseif var_19_2 == "1263901941" then
			return Str(STR.APP_NAME_JDXSD)
		elseif var_19_2 == "1268933253" or var_19_2 == "1278820492" or var_19_2 == "10037" then
			return Str(STR.APP_NAME_DJLX)
		elseif var_19_2 == "1270144966" then
			return Str(STR.APP_NAME_KZCS)
		elseif var_19_2 == "1274926810" then
			return Str(STR.APP_NAME_YXKPW)
		elseif var_19_2 == "1282829449" then
			return Str(STR.APP_NAME_YXZC)
		elseif var_19_2 == "1286948701" or var_19_2 == "1289515478" then
			return Str(STR.APP_NAME_GSZJD)
		elseif var_19_2 == "1286612569" then
			return Str(STR.APP_NAME_WZYX)
		end
	end

	return Str(STR.APP_NAME_JDZC)
end

function var_0_0.getGameType()
	local var_20_0 = ClientData.getAppName()

	return Data.GameType.jdzc
end

function var_0_0.getSubChannelName()
	local var_21_0 = lc.App:getChannelName()
	local var_21_1 = ""

	if lc.PLATFORM == cc.PLATFORM_OS_WINDOWS then
		local var_21_2 = ClientData.getAppId()

		if var_21_2 == "10006" or var_21_2 == "10018" then
			var_21_1 = "yyb"
		elseif #var_21_2 == 5 then
			var_21_1 = "uc"
		else
			var_21_1 = "appstore"
		end
	elseif var_21_0 == "ASDK" then
		if lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD then
			var_21_1 = "appstore"
		elseif lc.PLATFORM == cc.PLATFORM_OS_ANDROID then
			var_21_1 = lc.File:getDataFromFile("AsdkChannel.txt") or "android"
		end
	elseif var_21_0 == "OFFICIAL" then
		if lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD then
			var_21_1 = "appstore"
		elseif lc.PLATFORM == cc.PLATFORM_OS_ANDROID then
			var_21_1 = "uc"
		end
	end

	return var_21_1
end

function var_0_0.getSubChannelType()
	local var_22_0 = ClientData.getSubChannelName()

	if var_22_0 == "appstore" then
		return 1
	elseif var_22_0 == "yyb" then
		return 3
	elseif var_22_0 ~= "" then
		return 0
	else
		return -1
	end
end

function var_0_0.initCamera3D()
	local var_23_0 = lc.Director:getWinSize()
	local var_23_1 = lc.Director:getZEye()
	local var_23_2 = cc.Camera:createPerspective(60, var_23_0.width / var_23_0.height, 10, var_23_1 + var_23_0.height / 2)

	var_23_2:setPosition3D({
		x = var_23_0.width / 2,
		y = var_23_0.height / 2,
		z = var_23_1
	})
	var_23_2:lookAt({
		z = 0,
		x = var_23_0.width / 2,
		y = var_23_0.height / 2
	}, {
		z = 0,
		x = 0,
		y = 1
	})
	var_23_2:setCameraFlag(var_0_0.CAMERA_3D_FLAG)
	var_23_2:retain()

	var_0_0._camera3D = var_23_2
end

function var_0_0.addNotification(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2 > 0 and lc.UserDefault:getBoolForKey(arg_24_0, true) then
		lc.App:addNotification(arg_24_1, Str(arg_24_1), arg_24_2)
		lc.log("AddNotification key:%s, time:%s", arg_24_0, var_0_0.formatPeriod(arg_24_2))
	end
end

function var_0_0.isLogin()
	return var_0_0._socketStatus == var_0_0.SocketStatus.login
end

function var_0_0.onApplicationEvent(arg_26_0)
	local var_26_0 = arg_26_0:getUserString()

	if var_26_0 == "ENTER_BACKGROUND" and (not lc._runningScene or true) then
		return true
	elseif var_26_0 == "ENTER_FOREGROUND" and (not lc._runningScene or true) then
		return true
	elseif var_26_0 == "IDLE" then
		return true
	elseif var_26_0 == "REACHABILITY_CHANGED" then
		var_0_0.writeSocketLog(ClientData.SocketLog.reachability_changed)

		return true
	elseif string.hasPrefix(var_26_0, "GAMECENTERID_CHANGED") then
		local var_26_1 = string.sub(var_26_0, 21)

		if var_0_0.isLogin() then
			var_0_0.sendQueryGcid(var_26_1)
		elseif var_0_0._socketStatus == var_0_0.SocketStatus.connected and lc._runningScene ~= nil and lc._runningScene._sceneId == ClientData.SceneId.region then
			var_0_0.sendRegionListReq()
		end

		return true
	elseif var_26_0 == "USER_LOGOUT" then
		print("#### " .. var_26_0)
		lc._runningScene:runAction(cc.CallFunc:create(function()
			ClientView.getActiveIndicator():hide()

			local var_27_0 = lc._runningScene

			if var_27_0._sceneId == ClientData.SceneId.city then
				var_27_0:clearCity()
			end

			var_0_0.switchToUpdateScene()
		end))

		return true
	elseif var_26_0 == "PAY_FAILED" then
		print("#### " .. var_26_0)

		ClientData._isIAPing = false

		ClientView.getActiveIndicator():hide()

		local var_26_2 = Str(STR.BUYFAIL)

		ToastManager.push(var_26_2)
		var_0_0.sendIAPFinishReq()

		return true
	elseif var_26_0 == "PAY_SESSION_EXPIRE" then
		print("#### " .. var_26_0)

		ClientData._isIAPing = false

		ClientView.getActiveIndicator():hide()

		local var_26_3 = Str(STR.BUY_SESSION_EXPIRE)

		ToastManager.push(var_26_3)
		var_0_0.sendIAPFinishReq()

		return true
	elseif var_26_0 == "PAY_SUCCESS" then
		ClientView.iapPaySuccess()

		return true
	elseif var_26_0 == "PAY_CANCEL" then
		print("#### " .. var_26_0)

		ClientData._isIAPing = false

		ClientView.getActiveIndicator():hide()
		var_0_0.sendIAPFinishReq()

		return true
	elseif string.hasPrefix(var_26_0, "FACEBOOK_LOGGEDIN") then
		print("#### " .. var_26_0)

		local var_26_4 = string.sub(var_26_0, 19)

		print("#### facebook id:", var_26_4)

		if var_26_4 == "" then
			ClientView.getActiveIndicator():hide()
			ToastManager.push(Str(STR.BIND_GCID_FAILED_ID_EMPTY))

			return true
		end

		ClientData.sendQueryGcid(var_26_4)

		return true
	elseif var_26_0 == "FACEBOOK_LIKED" then
		print("#### " .. var_26_0)
		ToastManager.push(Str(STR.FACEBOOK_TASK_FINISHED))
		ClientData.sendUserFacebook(2402)
		P._playerBonus:onFacebookTaskDirty(2402)
	elseif var_26_0 == "FACEBOOK_INVITED" then
		print("#### " .. var_26_0)
		ToastManager.push(Str(STR.FACEBOOK_TASK_FINISHED))
		ClientData.sendUserFacebook(2403)
		P._playerBonus:onFacebookTaskDirty(2403)
	elseif var_26_0 == "WX_SHARE_OK" then
		print("#### " .. var_26_0)
		lc._runningScene:runAction(lc.sequence(0, function()
			ToastManager.push(Str(STR.SHARE_SUCCEED))

			local var_28_0 = cc.EventCustom:new(Data.Event.wx_share)

			var_28_0._isOK = true

			lc.Dispatcher:dispatchEvent(var_28_0)
		end))
	elseif var_26_0 == "WX_SHARE_DENIED" or var_26_0 == "WX_SHARE_UNSUPPORTED" or var_26_0 == "WX_SHARE_UNKNOWN" then
		print("#### " .. var_26_0)
		lc._runningScene:runAction(lc.sequence(0, function()
			ToastManager.push(Str(STR.SHARE_FAILED))

			local var_29_0 = cc.EventCustom:new(Data.Event.wx_share)

			var_29_0._isOK = false

			lc.Dispatcher:dispatchEvent(var_29_0)
		end))
	end

	return false
end

function var_0_0.getDisplayRegionId(arg_30_0)
	if ClientData.isDJLX() then
		arg_30_0 = arg_30_0 - Data.DJLX_REGION_ID_BASE
	end

	return arg_30_0 < 100000 and arg_30_0 % 10000 or arg_30_0
end

function var_0_0.getUserStringId(arg_31_0, arg_31_1)
	return string.format("%d+%d", arg_31_0, arg_31_1)
end

function var_0_0.getChannelName(arg_32_0)
	if arg_32_0 < 10000 then
		return Str(STR.CHANNEL_ANDROID)
	elseif arg_32_0 < 20000 then
		return Str(STR.CHANNEL_APPLE)
	elseif arg_32_0 < 30000 then
		return Str(STR.CHANNEL_COMP)
	else
		return Str(STR.CHANNEL_YYB)
	end
end

function var_0_0.genFullRegionName(arg_33_0, arg_33_1, arg_33_2)
	return string.format("%03d%s%s%s", var_0_0.getDisplayRegionId(arg_33_0), Str(STR.REGION), arg_33_2 and " " or "  ", arg_33_1)
end

function var_0_0.genChannelRegionName(arg_34_0)
	local var_34_0 = var_0_0.getChannelName(arg_34_0)
	local var_34_1 = var_0_0.getDisplayRegionId(arg_34_0)

	return string.format("%s%d%s", var_34_0, var_34_1, Str(STR.REGION))
end

function var_0_0.addBattleDebugLog(arg_35_0)
	var_0_0._battleDebugLog = (var_0_0._battleDebugLog or "") .. arg_35_0
end

function var_0_0.getCity(arg_36_0)
	return P._playerWorld._cities[arg_36_0]
end

function var_0_0.getUnionBossTroopIndex(arg_37_0)
	return arg_37_0 - 100 + 7
end

function var_0_0.getUnionBossIdByTroopIndex(arg_38_0)
	return arg_38_0 - 7 + 100
end

function var_0_0.sortTroopCards(arg_39_0)
	table.sort(arg_39_0, function(arg_40_0, arg_40_1)
		local var_40_0 = {
			[Data.CardType.monster] = 1,
			[Data.CardType.magic] = 2,
			[Data.CardType.trap] = 3
		}
		local var_40_1, var_40_2 = Data.getInfo(arg_40_0._infoId)
		local var_40_3, var_40_4 = Data.getInfo(arg_40_1._infoId)

		if var_40_0[var_40_2] == var_40_0[var_40_4] then
			if var_40_1._quality == var_40_3._quality then
				return var_40_1._id > var_40_3._id
			else
				return var_40_1._quality > var_40_1._quality
			end
		else
			return var_40_0[var_40_2] < var_40_0[var_40_4]
		end
	end)
end

function var_0_0.claimBonus(arg_41_0)
	local var_41_0

	if arg_41_0._id then
		var_41_0 = P._playerBonus:claimServerBonus(arg_41_0)

		if var_41_0 == Data.ErrorType.ok then
			ClientData.sendClaimServerBonus(arg_41_0._id)
		end
	else
		var_41_0 = P._playerBonus:claimBonus(arg_41_0._infoId)

		if var_41_0 == Data.ErrorType.ok then
			if arg_41_0._type == Data.BonusType.online then
				ClientData.sendClaimOnlineBonus(arg_41_0._infoId)
			elseif arg_41_0._type == Data.BonusType.activity then
				ClientData.sendClaimActivityBonus(arg_41_0._task._infoId)
			else
				ClientData.sendClaimBonus(arg_41_0._infoId)
			end
		end
	end

	return var_41_0
end

function var_0_0.onConnectedAndAuthorized()
	lc.log("[NETWORK] ClientData.onConnectedAndAuthorized")

	var_0_0._socketStatus = var_0_0.SocketStatus.connected
	var_0_0._sentHeartbeatTimestamp = nil
	var_0_0._receivedHeartbeatTimestamp = nil

	if var_0_0._heartbeatGapNoticeId ~= nil then
		NoticeManager.hide(var_0_0._heartbeatGapNoticeId)

		var_0_0._heartbeatLostNoticeId = nil
	end

	if var_0_0._heartbeatLostNoticeId ~= nil then
		NoticeManager.hide(var_0_0._heartbeatLostNoticeId)

		var_0_0._heartbeatLostNoticeId = nil
	end

	var_0_0._schedulerHearBeatID = lc.Scheduler:scheduleScriptFunc(function(arg_43_0)
		var_0_0.sendHeartBeat()
	end, 1, false)

	var_0_0.loadUserRegion()

	if var_0_0.hasUserRegion() then
		var_0_0.loginGameServer()
	else
		var_0_0.loginRegionServer()
	end
end

function var_0_0.onConnectFail()
	lc.log("[NETWORK] ClientData.onConnectFail")
end

function var_0_0.onDisconnect()
	print("[NETWORK] ClientData.onDisconnect")

	var_0_0._socketStatus = var_0_0.SocketStatus.disconnected
	var_0_0._sentHeartbeatTimestamp = nil
	var_0_0._receivedHeartbeatTimestamp = nil

	if var_0_0._schedulerHearBeatID ~= nil then
		lc.Scheduler:unscheduleScriptEntry(var_0_0._schedulerHearBeatID)

		var_0_0._schedulerHearBeatID = nil
	end

	if var_0_0._socketDataListener ~= nil then
		lc.Dispatcher:removeEventListener(var_0_0._socketDataListener)

		var_0_0._socketDataListener = nil
	end

	if P then
		P:stopPlayerScheduler()
	end
end

function var_0_0.onSocketData(arg_46_0)
	if arg_46_0._socket ~= var_0_0._socket then
		return false
	end

	if not arg_46_0._hasError then
		return var_0_0.onMsg(arg_46_0._msg)
	else
		return var_0_0.onError(arg_46_0._msg)
	end
end

function var_0_0.onMsg(arg_47_0)
	for iter_47_0 = 1, #var_0_0._msgListeners do
		if iter_47_0 > #var_0_0._msgListeners then
			break
		end

		if var_0_0._msgListeners[iter_47_0]._onMsg(arg_47_0) then
			return true
		end
	end

	return false
end

function var_0_0.onError(arg_48_0)
	for iter_48_0 = 1, #var_0_0._errorListeners do
		if var_0_0._errorListeners[iter_48_0]._onError(arg_48_0) then
			return true
		end
	end

	return false
end

function var_0_0.addMsgListener(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = {
		_target = arg_49_0,
		_onMsg = arg_49_1,
		_priority = arg_49_2
	}

	for iter_49_0 = 1, #var_0_0._msgListeners do
		local var_49_1 = var_0_0._msgListeners[iter_49_0]

		if var_49_1._target == var_49_0._target and var_49_1._priority == var_49_0._priority then
			return
		end

		if var_49_0._priority < var_49_1._priority then
			table.insert(var_0_0._msgListeners, iter_49_0, var_49_0)

			return
		end
	end

	table.insert(var_0_0._msgListeners, var_49_0)
end

function var_0_0.removeMsgListener(arg_50_0)
	for iter_50_0 = 1, #var_0_0._msgListeners do
		if var_0_0._msgListeners[iter_50_0]._target == arg_50_0 then
			table.remove(var_0_0._msgListeners, iter_50_0)

			return
		end
	end
end

function var_0_0.addErrorListener(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = {
		_target = arg_51_0,
		_onError = arg_51_1,
		_priority = arg_51_2
	}

	for iter_51_0 = 1, #var_0_0._errorListeners do
		local var_51_1 = var_0_0._errorListeners[iter_51_0]

		if var_51_1._target == var_51_0._target then
			return
		end

		if var_51_0._priority < var_51_1._priority then
			table.insert(var_0_0._errorListeners, iter_51_0, var_51_0)

			return
		end
	end

	table.insert(var_0_0._errorListeners, #var_0_0._errorListeners + 1, var_51_0)
end

function var_0_0.removeErrorListener(arg_52_0)
	for iter_52_0 = 1, #var_0_0._errorListeners do
		if var_0_0._errorListeners[iter_52_0]._target == arg_52_0 then
			table.remove(var_0_0._errorListeners, iter_52_0)

			return
		end
	end
end

function var_0_0.onMsgBeforeScene(arg_53_0)
	local var_53_0 = arg_53_0.status

	if var_53_0 ~= SglMsg_pb.PB_STATUS_OK then
		lc._runningScene:onMsgErrorStatus(arg_53_0, var_53_0)

		return true
	end

	local var_53_1 = arg_53_0.type

	if var_53_1 == SglMsgType_pb.PB_TYPE_AUTHENTICATION then
		var_0_0.onConnectedAndAuthorized()

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_USER_LOGIN or var_53_1 == SglMsgType_pb.PB_TYPE_USER_REGISTER then
		var_0_0._socketStatus = var_0_0.SocketStatus.login

		local var_53_2 = arg_53_0.Extensions[User_pb.SglUserMsg.user_in_resp]

		var_0_0.loadPlayerData(P, var_53_2)
		var_0_0.loadSubChannelInfo()

		local var_53_3 = var_53_2.is_in_battle
		local var_53_4 = var_53_2.is_in_match
		local var_53_5 = var_53_2.is_in_hall

		Data.GROUP_NUM = var_53_2.team_member_uplimit
		lc._runningScene._isLogin = true

		lc.log("login success! %s", var_53_3 and "now in battle!" or "")
		var_0_0.sendUserEvent({
			type = "login",
			isInBattle = tostring(var_53_3),
			sceneId = lc._runningScene and lc._runningScene._sceneId or 0,
			regIds = var_0_0._regIds
		})

		if var_53_3 ~= true and not var_53_4 and not var_53_5 then
			lc._runningScene:onLogin()
		end

		var_0_0.checkSocketLog()
		var_0_0.syncServerPush()

		local var_53_6 = cc.EventCustom:new(Data.Event.login)

		lc.Dispatcher:dispatchEvent(var_53_6)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_USER_QUERY_GCID then
		local var_53_7 = lc.App:getChannelName()
		local var_53_8 = arg_53_0.Extensions[User_pb.SglUserMsg.user_query_gcid_resp]

		if var_53_7 == "APPSTORE" then
			if var_53_8 then
				lc._runningScene:onGameCenterIdChanged()
			end
		elseif var_53_7 == "FACEBOOK" then
			P._canBind = not var_53_8

			ClientView.getActiveIndicator():hide()
			ToastManager.push(Str(var_53_8 and STR.BIND_GCID_SUCCEED or STR.BIND_GCID_FAILED))

			local var_53_9 = cc.EventCustom:new(Data.Event.bind_gcid_dirty)

			lc.Dispatcher:dispatchEvent(var_53_9)

			if var_53_8 then
				ClientData.sendUserFacebook(2401)
				P._playerBonus:onFacebookTaskDirty(2401)
			end
		end

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_USER_NOTIFY_EVENT then
		local var_53_10 = arg_53_0.Extensions[User_pb.SglUserMsg.user_notify_event_resp]

		if var_53_10.type == 1 then
			for iter_53_0 = 1, #P._playerBonus._bonusInvite do
				local var_53_11 = P._playerBonus._bonusInvite[iter_53_0]

				var_53_11._value = var_53_11._value + 1
			end

			bonus:sendBonusDirty()
		elseif var_53_10.type == 2 then
			P._inviteIngot = P._inviteIngot + var_53_10.param

			lc.sendEvent(Data.Event.invite_ingot_dirty)
		elseif var_53_10.type == 3 then
			P._inviteCount = P._inviteCount + 1

			lc.sendEvent(Data.Event.invite_count_dirty)
		end

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_HEART_BEAT then
		var_0_0._receivedHeartbeatTimestamp = lc.Director:getCurrentTime()

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_USER_OPPO_VIP_LEVEL then
		ClientData.onGetOppoVipLevel(arg_53_0.Extensions[User_pb.SglUserMsg.user_oppo_vip_resp])
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_FRIEND_BATTLE then
		local var_53_12 = arg_53_0.Extensions[Friend_pb.SglFriendMsg.friend_battle_resp]
		local var_53_13 = var_0_0.genInputFromFriendBattleResp(var_53_12)

		lc._runningScene:onFriendBattle(var_53_13)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_ATTACK then
		local var_53_14 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_attack_resp]
		local var_53_15 = var_0_0.genInputFromAttackResp(var_53_14)

		lc._runningScene:onAttack(var_53_15)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_CHALLENGE then
		local var_53_16 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_challenge_resp]
		local var_53_17 = var_0_0.genInputFromChallengeResp(var_53_16)

		lc._runningScene:onChallenge(var_53_17)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_RESCUE then
		local var_53_18 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_rescue_resp]
		local var_53_19 = var_0_0.genInputFromAttackResp(var_53_18)

		lc._runningScene:onAttack(var_53_19)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_EXPEDITION then
		local var_53_20 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_expedition_resp]
		local var_53_21

		if arg_53_0:HasExtension(World_pb.SglWorldMsg.world_refresh_expedition_resp) then
			var_53_21 = var_0_0.genInputFromExpeditionResp(var_53_20, arg_53_0.Extensions[World_pb.SglWorldMsg.world_refresh_expedition_resp])
		else
			var_53_21 = var_0_0.genInputFromExpeditionResp(var_53_20)
		end

		lc._runningScene:onExpedition(var_53_21)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_EXPEDITION_EX or var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_EXPEDITION_EX_BOSS then
		local var_53_22 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_expedition_ex_resp]
		local var_53_23

		if arg_53_0:HasExtension(World_pb.SglWorldMsg.world_get_expedition_ex_resp) then
			var_53_23 = var_0_0.genInputFromExpeditionExResp(var_53_22, arg_53_0.Extensions[World_pb.SglWorldMsg.world_get_expedition_ex_resp])
		else
			var_53_23 = var_0_0.genInputFromExpeditionExResp(var_53_22)
		end

		lc._runningScene:onExpeditionEx(var_53_23)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_CHALLENGE_ELITE then
		local var_53_24 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_challenge_elite_resp]
		local var_53_25 = var_0_0.genInputFromEliteResp(var_53_24)

		lc._runningScene:onElite(var_53_25)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_ROB_EXP then
		local var_53_26 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_rob_exp_resp]
		local var_53_27 = var_0_0.genInputFromRobExpResp(var_53_26)

		lc._runningScene:onRobExp(var_53_27)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_CHALLENGE_COMMANDER then
		local var_53_28 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_challenge_commander_resp]
		local var_53_29 = var_0_0.genInputFromCommanderResp(var_53_28)

		lc._runningScene:onHorse(var_53_29)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_ROB_GOLD then
		local var_53_30 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_rob_gold_resp]
		local var_53_31 = var_0_0.genInputFromBossResp(var_53_30)

		lc._runningScene:onBoss(var_53_31)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_UNION_BOSS_ATTACK then
		local var_53_32 = arg_53_0.Extensions[Union_pb.SglUnionMsg.union_boss_attack_resp]
		local var_53_33 = var_0_0.genInputFromBossResp(var_53_32)

		lc._runningScene:onBoss(var_53_33)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_BATTLE_REPLAY or var_53_1 == SglMsgType_pb.PB_TYPE_BATTLE_REPLAY_EX or var_53_1 == SglMsgType_pb.PB_TYPE_BATTLE_REPLAY_TUTORIAL or var_53_1 == SglMsgType_pb.PB_TYPE_BATTLE_REPLAY_SHARE then
		local var_53_34 = arg_53_0.Extensions[Battle_pb.SglBattleMsg.battle_replay_resp]
		local var_53_35 = var_0_0.genInputFromReplayResp(var_53_34)

		lc._runningScene:onReplay(var_53_35)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_FIND_START then
		local var_53_36 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_find_start_resp]
		local var_53_37 = var_0_0.genInputFromFindStartResp(var_53_36)

		lc._runningScene:onFindStart(var_53_37)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_BATTLE_RECOVER then
		lc.log("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXBATTLE RECOVER")

		local var_53_38 = arg_53_0.Extensions[Battle_pb.SglBattleMsg.battle_recover_resp]

		var_0_0.initConfig(var_53_38.player_troop.info.id)

		local var_53_39 = var_0_0.genInputFromRecoverResp(var_53_38, arg_53_0)

		print("battle recover")

		if var_53_38.type == Battle_pb.PB_BATTLE_DARK then
			P._playerFindDark:onFind()
		end

		if ClientView._findMatchPanel then
			ClientView._findMatchPanel:onFind(var_53_39)
		else
			lc._runningScene:onBattleRecover(var_53_39)
		end

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_FIND_EX_CANCEL then
		if ClientView._findMatchPanel and not ClientData._isAutoBattle then
			ClientView._findMatchPanel:hide()
		end

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_BATTLE_END then
		lc.log("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxBATTLE_END")

		local var_53_40 = arg_53_0.Extensions[Battle_pb.SglBattleMsg.battle_end_resp]

		if var_53_40:HasField("dark_duel_end_resp") then
			P._playerFindDark:onInningEnd(var_53_40.dark_duel_end_resp)
		end

		if arg_53_0:HasExtension(World_pb.SglWorldMsg.world_survival_explore_resp) then
			P._playerFindSurvival:parseExploreResp(arg_53_0.Extensions[World_pb.SglWorldMsg.world_survival_explore_resp])
		end

		if arg_53_0:HasExtension(World_pb.SglWorldMsg.world_survival_ex_explore_resp) then
			local var_53_41 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_survival_ex_explore_resp]
			local var_53_42 = var_53_40.resource:add()

			var_53_42.info_id = Data.ResType.survival_ex_trophy
			var_53_42.num = var_53_41.trophy - P._playerFindSurvivalEx._trophy

			P._playerFindSurvivalEx:parseExploreResp(var_53_41)
		end

		if ClientView._findMatchPanel then
			ClientView._findMatchPanel:hide()

			ClientView._findMatchPanel = nil
		end

		if ClientView._explorePanel then
			ClientView._explorePanel:hide()

			ClientView._explorePanel = nil
		end

		lc._runningScene:onBattleEnd(var_53_40)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_BATTLE_START then
		local var_53_43 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_battle_start_resp]

		if not var_53_43.is_revenge and not var_53_43.is_rescue then
			P._underAttack:addBattle(var_53_43)
		end

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_USER_VOTE_RECORD then
		local var_53_44 = arg_53_0.Extensions[User_pb.SglUserMsg.vote_record_resp]

		P:parseVote(var_53_44)

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_BATTLE_END then
		if arg_53_0:HasExtension(World_pb.SglWorldMsg.world_battle_end_resp) then
			local var_53_45 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_battle_end_resp]
			local var_53_46 = require("Log").new(false, var_53_45)

			P._playerLog:addLog(var_53_46, Battle_pb.PB_BATTLE_PLAYER)
			P._playerLog:sendLogDirty(require("PlayerLog").Event.defense_log_dirty)
			P:changeTrophy(var_53_46._resultType == Data.BattleResult.win and var_53_46._trophy or -var_53_46._trophy)

			if var_53_46._resultType == Data.BattleResult.lose then
				local var_53_47 = P._playerWorld._cities[var_53_46._city]

				if var_53_47 then
					var_53_47:cityOccupied(var_53_46._timestamp, var_53_46._opponent._id)
				end
			end

			local var_53_48 = P._underAttack:removeBattle(var_53_46._opponent._id)
		end

		return true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_RESCUE_END then
		local var_53_49 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_rescue_end_resp]
		local var_53_50 = P._playerWorld._cities[var_53_49]

		if var_53_50 then
			var_53_50:captureSuccess()

			if lc._runningScene._sceneId == ClientData.SceneId.world then
				ClientView._worldScene:hideTab()
			end
		end
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_BATTLE_OP_USECARD then
		var_0_0._usedCardsToAdd = var_0_0._usedCardsToAdd or {}

		local var_53_51 = arg_53_0.Extensions[Battle_pb.SglBattleMsg.battle_op_usecard_resp]

		for iter_53_1 = 1, #var_53_51 do
			table.insert(var_0_0._usedCardsToAdd, var_53_51[iter_53_1])
		end

		print("++++++++++++++++++++ get PB_TYPE_BATTLE_OP_USECARD", var_53_51[1], var_53_51[2], var_53_51[3])
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_BATTLE_USECARD then
		var_0_0._observeUsedCards = var_0_0._observeUsedCards or {}

		local var_53_52 = arg_53_0.Extensions[Battle_pb.SglBattleMsg.battle_op_usecard_resp]

		for iter_53_2 = 1, #var_53_52 do
			table.insert(var_0_0._observeUsedCards, var_53_52[iter_53_2])
		end

		print("++++++++++++++++++++ get PB_TYPE_BATTLE_USECARD", var_53_52[1], var_53_52[2], var_53_52[3])
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_BATTLE_OP_ONLINE then
		var_0_0.sendBattleSync()

		var_0_0._isOppoOnline = true
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_BATTLE_OP_OFFLINE then
		var_0_0._isOppoOnline = false
	elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY or var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_EX or var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_ACTIVITY or var_53_1 == SglMsgType_pb.PB_TYPE_CARD_LOTTERY_TURNTABLE then
		local var_53_53
		local var_53_54 = ClientData._lotteryTimes
		local var_53_55
		local var_53_56
		local var_53_57

		if var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY then
			local var_53_58 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_lottery_resp]

			var_53_55 = Data.PropsId.lottery_token
			var_53_56 = 1
			var_53_57 = Data._globalInfo._expeditionDialCost
		elseif var_53_1 == SglMsgType_pb.PB_TYPE_CARD_LOTTERY_TURNTABLE then
			local var_53_59 = arg_53_0.Extensions[Card_pb.SglCardMsg.lottery_turn_table_resp]

			var_53_55 = Data.PropsId.week_lottery_token
			var_53_56 = 1
		elseif var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_EX then
			local var_53_60 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_lottery_resp]

			var_53_55 = Data.PropsId.dark_lottery_token
			var_53_56 = 10
		else
			local var_53_61 = arg_53_0.Extensions[World_pb.SglWorldMsg.world_lottery_resp]
			local var_53_62 = ClientData.getValidActivityByType(535)

			var_53_55 = var_53_62._bonusId[1]
			var_53_56 = var_53_62._bonusId[2]
			var_53_57 = var_53_62._bonusId[3]
		end

		if P._propBag:hasProps(var_53_55, var_53_56 * var_53_54) then
			P._propBag:changeProps(var_53_55, -var_53_54 * var_53_56)
		elseif var_53_57 then
			P:changeResource(Data.ResType.ingot, -var_53_57 * var_53_54)
		end

		if var_53_1 == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY then
			ClientData._lotteryPower = ClientData._lotteryPower + var_53_54
		elseif var_53_1 == SglMsgType_pb.PB_TYPE_CARD_LOTTERY_TURNTABLE then
			ClientData._lotteryWeekPower = ClientData._lotteryWeekPower + var_53_54
		end
	end

	return false
end

function var_0_0.onMsgAfterScene(arg_54_0)
	if arg_54_0.type == SglMsgType_pb.PB_TYPE_USER_COMMAND then
		local var_54_0 = arg_54_0.Extensions[User_pb.SglUserMsg.user_command_resp]
		local var_54_1 = lc.runCode(var_54_0)

		ClientData.sendCommandRet(var_54_1)
	end

	return false
end

function var_0_0.sendCommandRet(arg_55_0)
	local var_55_0 = SglMsg_pb.SglReqMsg()

	var_55_0.type = SglMsgType_pb.PB_TYPE_USER_COMMAND
	var_55_0.Extensions[User_pb.SglUserMsg.user_command_req] = arg_55_0

	var_0_0.sendProtoMsg(var_55_0)
end

function var_0_0.loginGameServer()
	local var_56_0 = var_0_0.DEBUG_USER_ID

	-- Password-based login/register from LoginScene
	if var_0_0._loginUsername and var_0_0._loginUsername ~= "" then
		if var_0_0._loginMode == "register" then
			var_0_0.sendUserRegisterOnline()
		else
			var_0_0.sendUserLoginOnline()
		end
		return
	end

	-- Fallback: original device-based flow
	if var_56_0 == nil or var_56_0 == 0 then
		var_0_0.sendUserRegister()
	else
		var_0_0.sendUserLogin(var_56_0)
	end
end

function var_0_0.loginRegionServer()
	var_0_0.sendRegionListReq()
end

function var_0_0.loadPlayerData(arg_58_0, arg_58_1)
	arg_58_0:clear()

	var_0_0._baseTime = lc.Director:getCurrentTime()

	arg_58_0:init(arg_58_1)
end

function var_0_0.reconnectRegionServer()
	var_0_0.disconnect(false)

	-- The self-hosted Java server serves the region list and the game on the
	-- same socket.  The stock region endpoint is unreachable in the emulator,
	-- which leaves RegionScene's loading text spinning forever.
	local host = "127.0.0.1"
	local port = 9191
	if lc.PLATFORM ~= cc.PLATFORM_OS_ANDROID and lc.PLATFORM ~= cc.PLATFORM_OS_IPHONE and lc.PLATFORM ~= cc.PLATFORM_OS_IPAD then
		local endpoint = var_0_0._cfg.regionServer or lc.App:getRegionServer()
		local parts = string.splitByChar(endpoint, ":")
		host = parts[#parts - 1]
		port = parts[#parts]
	end

	var_0_0.connect(host, port)
end

function var_0_0.reconnectGameServer()
	var_0_0._isWorking = true

	print("ClientData._isWorking = true")
	var_0_0.loadUserRegion()
	var_0_0.disconnect(false)
	var_0_0.connect(var_0_0._userRegion._ip, var_0_0._userRegion._port)
end

function var_0_0.connect(arg_61_0, arg_61_1)
	lc.log("[NETWORK] ClientData.connect %s %d", arg_61_0, arg_61_1)

	local var_61_0 = require("Socket_pb")

	var_0_0._socket = var_61_0.new(arg_61_0, arg_61_1)

	if var_0_0._socketDataListener == nil then
		var_0_0._socketDataListener = lc.addEventListener(var_61_0.Event.data, function(arg_62_0)
			var_0_0.onSocketData(arg_62_0)
		end)

		table.insert(var_0_0._evtListeners, var_0_0._socketDataListener)
	end

	var_0_0._socket:connect()
end

function var_0_0.disconnect(arg_63_0)
	lc.log("[NETWORK] ClientData.disconnect %s", arg_63_0 and "true" or "false")

	if var_0_0._socket ~= nil then
		var_0_0._socket:disconnect(arg_63_0)
		var_0_0._socket:close(arg_63_0)

		var_0_0._socket = nil
	end

	if not arg_63_0 then
		var_0_0.onDisconnect()
	end
end

function var_0_0.switchToUpdateScene()
	var_0_0.disconnect(false)
	lc.App:switchToUpdateScene()

	var_0_0.switchSchedulerID = lc.Scheduler:scheduleScriptFunc(function(arg_65_0)
		require("CardThumbnail").releasePool()
		lc.Pool.clear("IconWidget")
		lc.App:unloadRes("extend.lan")
		TextureManager.clear()

		for iter_65_0, iter_65_1 in ipairs(var_0_0._evtListeners) do
			lc.Dispatcher:removeEventListener(iter_65_1)
		end

		var_0_0._evtListeners = {}

		var_0_0.unloadCityUnionRes()
		var_0_0.unloadBattleRes()
		ClientData.unloadLCRes({
			"cards_back.jpm",
			"cards_back.png.sfb"
		})
		ClientData.unloadLCRes({
			"cards_back2.jpm",
			"cards_back2.png.sfb"
		})
		ClientData.unloadLCRes({
			"cards_back3.jpm",
			"cards_back3.png.sfb"
		})
		ClientData.unloadLCRes({
			"cards_back4.jpm",
			"cards_back4.png.sfb"
		})
		ClientData.unloadLCRes({
			"props.jpm",
			"props.png.sfb"
		})
		ClientData.unloadLCRes({
			"general.jpm",
			"general.png.sfb"
		})
		ClientData.unloadLCRes({
			"avatar.jpm",
			"avatar.png.sfb"
		})

		for iter_65_2 = 1, ClientData.CARDS_IMG_COUNT do
			local var_65_0 = "cards_img_" .. iter_65_2

			ClientData.unloadLCRes({
				var_65_0 .. ".jpm",
				var_65_0 .. ".png.sfb"
			})
		end

		lc.FrameCache:removeSpriteFrames()
		lc.TextureCache:removeAllTextures()
		lc.Director:purgeCachedData()
		lc.Scheduler:unscheduleScriptEntry(var_0_0.switchSchedulerID)
	end, 0, false)
end

function var_0_0.switchToRegionScene()
	var_0_0.disconnect(false)

	var_0_0._regions = {}

	var_0_0.saveUserRegion()
	lc.replaceScene(require("RegionScene").create())
end

function var_0_0.saveUserRegion()
	local var_67_0

	if var_0_0._userRegion ~= nil and var_0_0._userRegion._id ~= nil then
		var_67_0 = var_0_0._regions[var_0_0._userRegion._id]
	end

	if var_67_0 ~= nil then
		local var_67_1 = string.format("%d:%s:%s", var_67_0._id, var_67_0._host, var_67_0._name)

		lc.UserDefault:setStringForKey(var_0_0.ConfigKey.region_info, var_67_1)
	else
		lc.UserDefault:setStringForKey(var_0_0.ConfigKey.region_info, "")
	end
end

function var_0_0.loadUserRegion()
	var_0_0._userRegion = {}

	local var_68_0 = lc.UserDefault:getStringForKey(var_0_0.ConfigKey.region_info, "")

	if #var_68_0 ~= 0 then
		local var_68_1 = string.splitByChar(var_68_0, ":")

		if #var_68_1 == 4 then
			var_0_0._userRegion._id = tonumber(var_68_1[1])
			var_0_0._userRegion._ip = var_68_1[2]
			var_0_0._userRegion._port = var_68_1[3]
			var_0_0._userRegion._name = var_68_1[4]
		elseif #var_68_1 == 3 then
			-- Older builds persisted `id:host:name` while the connection
			-- requires a port. Accept that value so an existing install can
			-- recover after the server starts returning `host:port`.
			var_0_0._userRegion._id = tonumber(var_68_1[1])
			var_0_0._userRegion._ip = var_68_1[2]
			var_0_0._userRegion._port = 9191
			var_0_0._userRegion._name = var_68_1[3]
		end
	end

	if lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and false then
		var_0_0._userRegion._id = 3002
		var_0_0._userRegion._ip = "192.168.1.109"
		var_0_0._userRegion._port = 9191
		var_0_0._userRegion._name = "TEST"
	end

	-- The self-hosted server is exposed through adb reverse on the emulator.
	-- Never retain the old production/LAN address, otherwise LoadingScene
	-- waits forever before it can send the login request.
	if lc.PLATFORM == cc.PLATFORM_OS_ANDROID or lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD then
		-- Local development endpoint. adb reverse maps the emulator's
		-- 127.0.0.1:9191 to the host JVM.
		var_0_0._userRegion._id = var_0_0._userRegion._id or 3002
		var_0_0._userRegion._ip = "127.0.0.1"
		var_0_0._userRegion._port = 9191
		var_0_0._userRegion._name = var_0_0._userRegion._name or "TEST"
	end

	print("User Region info: ", var_0_0._userRegion._id, var_0_0._userRegion._ip, var_0_0._userRegion._port, var_0_0._userRegion._name)
end

function var_0_0.hasUserRegion()
	return var_0_0._userRegion._id ~= nil and var_0_0._userRegion._ip ~= nil and var_0_0._userRegion._port ~= nil and var_0_0._userRegion._name ~= nil
end

function var_0_0.getCurrentTime()
	if P._loginTime == nil or var_0_0._baseTime == nil then
		return lc.Director:getCurrentTime()
	else
		return P._loginTime + var_0_0.getRunningTime()
	end
end

function var_0_0.getRunningTime()
	local var_71_0 = lc.Director:getCurrentTime()

	return var_0_0._baseTime and var_71_0 - var_0_0._baseTime or 0
end

function var_0_0.getUtcTime(arg_72_0)
	if type(arg_72_0) == "number" then
		return arg_72_0 + var_0_0._timezone
	else
		return os.time(arg_72_0) + var_0_0._timezone
	end
end

function var_0_0.getDayOfWeek()
	if P._timeOffset then
		local var_73_0 = var_0_0.getCurrentTime() + P._timeOffset

		return os.date("!*t", var_73_0).wday - 1
	else
		return os.date("*t", var_0_0.getCurrentTime()).wday - 1
	end
end

function var_0_0.getVersion()
	local var_74_0 = lc.File:getWritablePath() .. "md5"
	local var_74_1 = "md5"
	local var_74_2 = lc.readFile(var_74_0, 0, 32)

	if var_74_2 == nil or #var_74_2 == 0 then
		var_74_2 = lc.readFile(var_74_1, 0, 32)

		if var_74_2 == nil or #var_74_2 == 0 then
			return ""
		end
	end

	local var_74_3, var_74_4 = string.unpack(var_74_2, "<I")
	local var_74_5 = string.decrypt(string.sub(var_74_2, 5), var_74_4)
	local var_74_6, var_74_7 = string.unpack(var_74_5, "b")

	return (string.sub(var_74_5, 2, var_74_7 + 1))
end

function var_0_0.getBinVersion()
	return lc.App.getBinaryVersion and lc.App:getBinaryVersion() or "1.5.0"
end

function var_0_0.getDisplayVersion()
	return "1.5.0-h5"
end

function var_0_0.getNameByInfoId(arg_77_0)
	arg_77_0 = arg_77_0 and tonumber(arg_77_0)

	local var_77_0 = false
	local var_77_1 = false
	local var_77_2, var_77_3

	arg_77_0, var_77_2, var_77_3 = Data.removeAdditional(arg_77_0)

	if type == Data.CardType.nature then
		return Str(STR.NATURE_NONE + arg_77_0 % 1000)
	elseif type == Data.CardType.category then
		return Str(STR.CARD_CATEGORY_BEGIN + arg_77_0 % 1000)
	elseif type == Data.CardType.keyword then
		return Str(STR.CARD_KEYWORD_BEGIN + arg_77_0 % 1000)
	elseif type == Data.CardType.flag then
		return Str(STR.MONSTER_FLAG_BEGIN + arg_77_0 % 1000)
	end

	local var_77_4 = Data.getInfo(arg_77_0, 1)

	return var_77_4 and Str(var_77_4._briefNameSid or var_77_4._nameSid) or ""
end

function var_0_0.getItemTypeNameByInfoId(arg_78_0, arg_78_1)
	local var_78_0, var_78_1 = Data.getInfo(arg_78_0)

	if var_78_1 == Data.CardType.res then
		return Str(STR.RESOURCE)
	elseif var_78_1 == Data.CardType.common_fragment or arg_78_1 then
		return Str(STR.CARD) .. Str(STR.FRAGMENT)
	elseif var_78_1 == Data.CardType.props then
		var_78_1 = var_78_0._type

		if var_78_1 == 0 then
			return Str(STR.RESOURCE)
		elseif var_78_1 >= 1 and var_78_1 <= 4 then
			return Str(var_78_1 + STR.PROPS_TYPE_BOX - 1)
		elseif var_78_1 == 5 then
			return Str(STR.PROPS_TYPE_DECORATION)
		elseif var_78_1 == 10 then
			return Str(STR.PROPS_TYPE_UNION)
		else
			return ""
		end
	elseif var_78_1 == Data.CardType.item_skill then
		return Str(STR.ITEM_SKILL)
	else
		return Str(STR.CARD)
	end
end

function var_0_0.isAppStoreReviewing()
	return false
end

function var_0_0.isAnotherSkin()
	if ClientData._cfg and ClientData._cfg.anotherSkin then
		return true
	end

	local var_80_0 = ClientData.getAppId()

	return var_80_0 == "1417144657" or var_80_0 == "1474317745" or var_80_0 == "1481550826" or var_80_0 == "50001" or var_80_0 == "50002" or var_80_0 == "60001"
end

function var_0_0.isAnotherSkin2()
	local var_81_0 = ClientData.getAppId()

	return var_81_0 == "60002" or var_81_0 == "60003" or var_81_0 == "1540741791"
end

function var_0_0.isAnotherSkin2Locked()
	if not ClientData.isAnotherSkin2() then
		return false
	end

	if P:getMaxCharacterLevel() >= 10 or ClientData.isGemRecharged() then
		return false
	end

	return true
end

function var_0_0.isAnotherCardImageSkin()
	return ClientData.isAnotherSkin2()
end

function var_0_0.getAppStoreReviewingType()
	if ClientData._cfg and ClientData._cfg.appstoreReview ~= nil and ClientData._cfg.appstoreReview > 0 then
		return ClientData._cfg.appstoreReview
	end

	if lc.FrameCache:getSpriteFrame("city_3_role") ~= nil then
		return 3
	elseif lc.FrameCache:getSpriteFrame("city_btn_1001") ~= nil then
		return 1
	else
		return 2
	end
end

function var_0_0.isHideActivityPackage()
	return bit.band(var_0_0._option, 2) ~= 0
end

function var_0_0.isHideCharge()
	return false
end

function var_0_0.isShowAgreement()
	if ClientData.isAppStoreReviewing() then
		return false
	end

	return ClientData.getAppId() ~= "10051"
end

function var_0_0.isAndroidTest0602()
	return false
end

function var_0_0.isDEV()
	return ClientData._userRegion and ClientData._userRegion._id == 8001
end

function var_0_0.isAppStore()
	local var_90_0 = ClientData.getAppId()

	return lc.App:getChannelName() == "ASDK" and (lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD) and not string.hasPrefix(var_90_0, "400")
end

function var_0_0.isJailbreak()
	local var_91_0 = ClientData.getAppId()

	return lc.App:getChannelName() == "ASDK" and (lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD) and string.hasPrefix(var_91_0, "400")
end

function var_0_0.isYYB()
	return lc.App:getChannelName() == "ASDK" and ClientData.getSubChannelName() == "yyb"
end

function var_0_0.isYYBNew()
	return var_0_0.isYYB() and lc.App.yybGetLoginType and lc.App:yybGetLoginType() ~= ""
end

function var_0_0.isYYBLoginByQQ()
	return var_0_0.isYYB() and lc.App.yybGetLoginType and lc.App:yybGetLoginType() == "0"
end

function var_0_0.isOppo()
	return lc.App:getChannelName() == "ASDK" and ClientData.getSubChannelName() == "oppo"
end

function var_0_0.isHuya()
	return lc.App:getChannelName() == "ASDK" and ClientData.getSubChannelName() == "huya"
end

function var_0_0.getSubChannelInfo(arg_97_0)
	if not arg_97_0 and var_0_0.SubChannelInfo then
		return var_0_0.SubChannelInfo
	end

	var_0_0.SubChannelInfo = nil

	if not lc.App.yybGetLoginType then
		return
	end

	local var_97_0 = lc.App:yybGetLoginType()

	if not var_97_0 or #var_97_0 < 2 or var_97_0[1] ~= "{" or var_97_0[#var_97_0] ~= "}" then
		return
	end

	local var_97_1 = json.decode(var_97_0)

	var_0_0.SubChannelInfo = var_97_1

	return var_97_1
end

function var_0_0.isVivo()
	return lc.App:getChannelName() == "ASDK" and ClientData.getSubChannelName() == "vivo"
end

function var_0_0.isDJLX()
	return lc.App:getChannelName() == "ASDK" and ClientData.getAppId() == "10037"
end

function var_0_0.isYuGiOhExt()
	local var_100_0 = ClientData.getAppId()

	return var_100_0 == "1000000000" or var_100_0 == "1474317745" or var_100_0 == "1481550826"
end

function var_0_0.isReview2()
	return lc.App:getChannelName() == "ASDK" and ClientData.getAppId() == "20000"
end

function var_0_0.hasAppStoreIapBug()
	local var_102_0 = var_0_0.getBinVersion()
	local var_102_1 = string.splitByChar(var_102_0, ".")
	local var_102_2 = {
		tonumber(var_102_1[1]),
		tonumber(var_102_1[2]),
		tonumber(var_102_1[3])
	}

	return var_102_2[1] < 1 or var_102_2[1] == 1 and var_102_2[2] < 6 or var_102_2[1] == 1 and var_102_2[2] == 6 and var_102_2[3] < 5
end

function var_0_0.isUseFacebook()
	return false
end

function var_0_0.isPlayVideo()
	return not ClientData.isAppStoreReviewing() and false
end

function var_0_0.isIPhoneX()
	return (lc.PLATFORM == cc.PLATFORM_OS_WINDOWS or lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD) and ClientView.SCR_W > 1662
end

function var_0_0.modifyPackageBonus(arg_106_0, arg_106_1)
	local var_106_0

	if ClientData.getAppStoreReviewingType() == 1 then
		var_106_0 = {
			Data.PropsId.dimension_bottle,
			Data.PropsId.character_package_dust,
			Data.PropsId.dimension_bottle
		}
	else
		var_106_0 = {
			Data.PropsId.ladder_ticket,
			Data.PropsId.character_package_dust,
			Data.PropsId.ladder_ticket
		}
	end

	local var_106_1 = {
		1,
		100,
		6
	}

	arg_106_0._rid = {
		var_106_0[arg_106_1 - Data.PurchaseType.package_1 + 1]
	}
	arg_106_0._count = {
		var_106_1[arg_106_1 - Data.PurchaseType.package_1 + 1]
	}
end

function var_0_0.replaceCityScene()
	if ClientData.isAppStoreReviewing() then
		lc.replaceScene(require("CityScene2").create())
	else
		lc.replaceScene(require("CityScene").create())
	end
end

function var_0_0.getPicIdByInfoId(arg_108_0)
	local var_108_0 = 0
	local var_108_1 = Data.getInfo(arg_108_0)

	if var_108_1 then
		var_108_0 = var_108_1._picId
	end

	if var_108_0 == nil or var_108_0 == 0 then
		var_108_0 = arg_108_0
	end

	return var_108_0
end

function var_0_0.getPropIconName(arg_109_0, arg_109_1)
	if arg_109_1 then
		local var_109_0 = string.format("props_ico_%d", ClientData.getPicIdByInfoId(arg_109_0))

		if not lc.FrameCache:getSpriteFrame(var_109_0) then
			var_109_0 = "card_icon_quality_00"
		end

		return var_109_0
	else
		local var_109_1 = string.format("img_icon_props_s%d", ClientData.getPicIdByInfoId(arg_109_0))

		if not lc.FrameCache:getSpriteFrame(var_109_1) then
			var_109_1 = "card_icon_quality_00"
		end

		return var_109_1
	end
end

function var_0_0.toggleAudio(arg_110_0, arg_110_1)
	if arg_110_0 == lc.Audio.Behavior.music then
		var_0_0._isMusicOn = arg_110_1

		lc.UserDefault:setBoolForKey(var_0_0.ConfigKey.music_on, arg_110_1)
	else
		var_0_0._isEffectOn = arg_110_1

		lc.UserDefault:setBoolForKey(var_0_0.ConfigKey.effect_on, arg_110_1)
	end

	lc.Audio.setIsMute(not arg_110_1, arg_110_0)
end

function var_0_0.togglePos(arg_111_0)
	var_0_0._isPosOn = arg_111_0

	lc.UserDefault:setBoolForKey(var_0_0.ConfigKey.pos_on, arg_111_0)
end

function var_0_0.syncServerPush()
	local var_112_0 = 0

	if lc.UserDefault:getBoolForKey(ClientData.ConfigKey.push_copy_pvp, true) then
		var_112_0 = bor(var_112_0, 1)
	end

	if lc.UserDefault:getBoolForKey(ClientData.ConfigKey.push_union_help, true) then
		var_112_0 = bor(var_112_0, 2)
	end

	var_0_0.sendServerPushSwitch(var_112_0)
end

function var_0_0.getUnpassTeachCount(arg_113_0, arg_113_1)
	local var_113_0 = arg_113_0 * Data.INFO_ID_GROUP_SIZE_LARGE
	local var_113_1 = (arg_113_0 + 1) * Data.INFO_ID_GROUP_SIZE_LARGE
	local var_113_2 = 0
	local var_113_3 = P:getMaxCharacterLevel()

	if arg_113_0 == Data.TeachType.mid_teach then
		if arg_113_1 == nil then
			for iter_113_0 = 1, 3 do
				var_113_2 = var_113_2 + var_0_0.getUnpassTeachCount(arg_113_0, iter_113_0)
			end

			return var_113_2
		elseif var_113_3 < Data._globalInfo._unlockMidTeach + (arg_113_1 - 1) * 2 then
			return var_113_2
		end
	elseif arg_113_0 == Data.TeachType.master_teach and var_113_3 < Data._globalInfo._unlockMasterTeach or arg_113_0 == Data.TeachType.new_teach and var_113_3 < Data._globalInfo._unlockNewTeach then
		return var_113_2
	end

	for iter_113_1, iter_113_2 in pairs(Data._teachInfo) do
		if var_113_0 < iter_113_2._id and var_113_1 > iter_113_2._id and (arg_113_1 == nil or Data.getTeachSubTypeIndex(iter_113_2._id) == arg_113_1) then
			local var_113_4 = iter_113_2._bonusId
			local var_113_5 = P._playerBonus._bonusTeach[var_113_4]

			if var_113_5 and var_113_5._value < var_113_5._info._val then
				var_113_2 = var_113_2 + 1
			end
		end
	end

	return var_113_2
end

function var_0_0.formatNum(arg_114_0, arg_114_1, arg_114_2)
	arg_114_0 = arg_114_0 or 0
	arg_114_1 = arg_114_1 or 999999

	if arg_114_1 < arg_114_0 then
		if arg_114_0 % 10000 == 0 or arg_114_2 then
			return string.format("%d" .. Str(STR.WAN), math.floor(arg_114_0 / 10000))
		else
			return string.format("%.1f" .. Str(STR.WAN), arg_114_0 / 10000)
		end
	else
		return string.format("%d", arg_114_0)
	end
end

function var_0_0.formatPeriod(arg_115_0, arg_115_1)
	local var_115_0 = arg_115_0
	local var_115_1 = math.floor(var_115_0 / Data.DAY_SECONDS)
	local var_115_2 = var_115_0 % Data.DAY_SECONDS
	local var_115_3 = math.floor(var_115_2 / 3600)
	local var_115_4 = var_115_2 % 3600
	local var_115_5 = math.floor(var_115_4 / 60)
	local var_115_6 = var_115_4 % 60
	local var_115_7 = 0

	arg_115_1 = arg_115_1 or 2

	local var_115_8 = ""

	if var_115_1 > 0 then
		var_115_7 = var_115_7 + 1
		var_115_8 = string.format("%d%s", var_115_1, Str(STR.DAY))
	end

	if var_115_7 == arg_115_1 then
		return var_115_8
	end

	if var_115_3 > 0 then
		var_115_7 = var_115_7 + 1
		var_115_8 = string.format("%s%d%s", var_115_8, var_115_3, Str(STR.HOUR))
	end

	if var_115_7 == arg_115_1 then
		return var_115_8
	end

	if var_115_5 > 0 then
		var_115_7 = var_115_7 + 1
		var_115_8 = string.format("%s%d%s", var_115_8, var_115_5, Str(STR.MINUTE))
	end

	if var_115_7 == arg_115_1 then
		return var_115_8
	end

	if var_115_6 > 0 or var_115_7 == 0 and var_115_6 == 0 then
		var_115_8 = string.format("%s%d%s", var_115_8, var_115_6, Str(STR.SECOND))
	end

	return var_115_8
end

function var_0_0.formatTime(arg_116_0, arg_116_1)
	if arg_116_0 < 0 then
		arg_116_0 = 0
	end

	local var_116_0 = math.floor(arg_116_0 / 3600)
	local var_116_1 = math.floor(arg_116_0 % 3600 / 60)
	local var_116_2 = math.floor(arg_116_0 % 3600 % 60)

	if arg_116_1 then
		return string.format("%02d:%02d", var_116_1, var_116_2)
	else
		return string.format("%02d:%02d:%02d", var_116_0, var_116_1, var_116_2)
	end
end

function var_0_0.parseTimeStr(arg_117_0, arg_117_1)
	if arg_117_0 == nil or arg_117_0 == "" then
		return 0
	end

	local var_117_0 = string.split(arg_117_0, ".")

	return var_0_0.getUtcTime({
		isdst = false,
		year = tonumber(var_117_0[1]),
		month = tonumber(var_117_0[2]),
		day = tonumber(var_117_0[3]),
		hour = var_117_0[4] and tonumber(var_117_0[4]) or 4,
		min = var_117_0[5] and tonumber(var_117_0[5]) or 0,
		sec = var_117_0[6] and tonumber(var_117_0[6]) or 0
	}) - (arg_117_1 or Data.SERVER_TIME_ZONE)
end

function var_0_0.getTimeAgo(arg_118_0, arg_118_1)
	local var_118_0 = var_0_0.getCurrentTime() - arg_118_0
	local var_118_1 = math.floor(var_118_0 / 24 / 3600)

	if var_118_1 > 0 then
		if arg_118_1 and arg_118_1 < var_118_1 then
			return string.format("%s%d%s", Str(STR.EXCEED), arg_118_1, Str(STR.DAY_AGO))
		else
			return string.format("%d%s", var_118_1, Str(STR.DAY_AGO))
		end
	end

	local var_118_2 = math.floor(var_118_0 / 3600)

	if var_118_2 > 0 then
		return string.format("%d%s", var_118_2, Str(STR.HOUR_AGO))
	end

	local var_118_3 = math.floor(var_118_0 / 60)

	if var_118_3 > 0 then
		return string.format("%d%s", var_118_3, Str(STR.MINUTE_AGO))
	end

	if var_118_0 <= 1 then
		return Str(STR.NOW)
	end

	return string.format("%d%s", var_118_0, Str(STR.SECOND_AGO))
end

function var_0_0.getServerDate(arg_119_0)
	if P == nil or P._loginTime == nil then
		return nil, nil, nil, nil
	end

	local var_119_0 = os.date("!*t", arg_119_0 or var_0_0.getCurrentTime() + P._timeOffset)

	return var_119_0.hour, var_119_0.day, var_119_0.month, var_119_0.year
end

function var_0_0.getServerTick(arg_120_0)
	local var_120_0, var_120_1, var_120_2, var_120_3 = var_0_0.getServerDate(arg_120_0)

	return var_120_3 * 1000000 + var_120_2 * 10000 + var_120_1 * 100 + var_120_0
end

function var_0_0.getServerDateTick(arg_121_0)
	local var_121_0, var_121_1, var_121_2, var_121_3 = var_0_0.getServerDate(arg_121_0)

	if var_121_1 == nil then
		return 0
	end

	return var_121_3 * 10000 + var_121_2 * 100 + var_121_1
end

function var_0_0.getServerDayTimeRemain(arg_122_0)
	local var_122_0 = os.date("!*t", ClientData.getCurrentTime())

	var_122_0.hour = arg_122_0 or 24
	var_122_0.min = 0
	var_122_0.sec = 0

	local var_122_1 = ClientData.getUtcTime(ClientData.getCurrentTime())

	return ClientData.getUtcTime(var_122_0) - var_122_1
end

function var_0_0.getExpireTimestamp(arg_123_0)
	local var_123_0 = var_0_0.getCurrentTime() + P._timeOffset

	return var_123_0 - var_123_0 % 86400 + arg_123_0 * 3600 * 24 - P._timeOffset
end

function var_0_0.getExpireDay(arg_124_0)
	local var_124_0 = var_0_0.getExpireTimestamp(0)

	return math.floor((arg_124_0 - var_124_0) / 3600 / 24)
end

function var_0_0.getMonthDay(arg_125_0, arg_125_1)
	local var_125_0 = ({
		31,
		28,
		31,
		30,
		31,
		30,
		31,
		31,
		30,
		31,
		30,
		31
	})[arg_125_1]

	if arg_125_1 == 2 and arg_125_0 % 4 == 0 and arg_125_0 % 100 ~= 0 then
		var_125_0 = var_125_0 + 1
	end

	return var_125_0
end

function var_0_0.getDaysAfterServerOpen()
	return (var_0_0.getCurrentTime() - P._serverOpenTimestamp) / Data.DAY_SECONDS
end

function var_0_0.convertId(arg_127_0, arg_127_1)
	local function var_127_0(arg_128_0)
		return bor(blsh(band(arg_128_0, 255), 8), band(brsh(arg_128_0, 8), 255))
	end

	if arg_127_1 then
		if arg_127_0 >= 75536 then
			return 65536 + math.floor((arg_127_0 - 75536) / 8)
		else
			arg_127_0 = arg_127_0 - 10000

			return var_127_0(arg_127_0)
		end
	elseif arg_127_0 >= 65536 then
		return 75536 + (arg_127_0 - 65536) * 8
	else
		return var_127_0(arg_127_0) + 10000
	end
end

function var_0_0.isRateValid()
	return lc.App.getAppRateUrl and lc.App:getAppRateUrl() ~= "" and not ClientData.isAppStoreReviewing()
end

function var_0_0.isMixable(arg_130_0)
	return true
end

function var_0_0.getTroopName(arg_131_0, arg_131_1)
	local var_131_0
	local var_131_1 = string.format("%s %d", Str(STR.TROOP), arg_131_0)

	if arg_131_1 then
		local var_131_2 = P._troopRemarks[arg_131_0]

		if var_131_2 == nil or var_131_2 == "" then
			var_131_2 = Str(STR.REMARK_NONE)
		end

		var_131_1 = var_131_1 .. string.format("\n|%s|", var_131_2)
	end

	return var_131_1
end

function var_0_0.getStrByCardType(arg_132_0)
	if arg_132_0 == Data.CardType.monster then
		return Str(STR.MONSTER)
	elseif arg_132_0 == Data.CardType.magic then
		return Str(STR.MAGIC)
	elseif arg_132_0 == Data.CardType.trap then
		return Str(STR.TRAP)
	elseif arg_132_0 == Data.CardType.rare then
		return Str(STR.RARE)
	end
end

function var_0_0.getPlaceByCardType(arg_133_0)
	local var_133_0 = ""

	if arg_133_0 == Data.CardType.monster then
		var_133_0 = Str(STR.SID_FIXITY_NAME_1005)
	elseif arg_133_0 == Data.CardType.weapon or arg_133_0 == Data.CardType.armor then
		var_133_0 = Str(STR.SID_FIXITY_NAME_1009)
	elseif arg_133_0 == Data.CardType.horse then
		var_133_0 = Str(STR.SID_FIXITY_NAME_1010)
	elseif arg_133_0 == Data.CardType.book then
		var_133_0 = Str(STR.SID_FIXITY_NAME_1011)
	end

	return string.gsub(var_133_0, " ", "")
end

function var_0_0.getAvatarFrameName(arg_134_0, arg_134_1)
	if arg_134_0 == Data.PropsId.avatar_frame then
		arg_134_1 = arg_134_1 or P._vip

		return string.format("avatar_frame_%03d", 1)
	else
		return string.format("avatar_frame_%d", arg_134_0)
	end
end

function var_0_0.getAvatarName(arg_135_0)
	local var_135_0

	if ClientData.isAnotherSkin() then
		if arg_135_0 > 52000 then
			var_135_0 = string.format("avatar_%d", arg_135_0)
		else
			var_135_0 = arg_135_0 > 10000 and arg_135_0 < 20000 and "avatar_51" or string.format("avatar_%04d", arg_135_0)
		end

		if lc.FrameCache:getSpriteFrame(var_135_0 .. "_2") then
			var_135_0 = var_135_0 .. "_2"
		end
	elseif ClientData.isAnotherSkin2() and arg_135_0 < 10000 then
		var_135_0 = string.format("avatar_%02d_3", math.floor(arg_135_0 / 100))
	elseif arg_135_0 > 52000 then
		var_135_0 = string.format("avatar_%d", arg_135_0)
	else
		var_135_0 = arg_135_0 > 10000 and arg_135_0 < 20000 and "avatar_51" or string.format("avatar_%02d", math.floor(arg_135_0 / 100))
	end

	print("++++++++++++++++", var_135_0, ClientData.isAnotherSkin(), ClientData.isAnotherSkin2())

	return var_135_0
end

function var_0_0.getSkillDesc(arg_136_0, arg_136_1)
	local var_136_0 = Data._skillInfo[arg_136_0]
	local var_136_1

	if var_136_0._val[1] == 0 then
		var_136_1 = Str(var_136_0._descSid)
	else
		var_136_1 = string.gsub(Str(var_136_0._descSid), "%[%d+%]", string.format("%d", var_136_0._val[arg_136_1]))
	end

	return (string.gsub(var_136_1, "#", ""))
end

function var_0_0.getRandomArray(arg_137_0)
	local var_137_0 = {}

	for iter_137_0 = 1, #arg_137_0 do
		table.insert(var_137_0, #var_137_0 + 1, arg_137_0[iter_137_0])
	end

	local var_137_1 = {}

	while #var_137_0 > 0 do
		local var_137_2 = math.random(1, #var_137_0)

		table.insert(var_137_1, #var_137_1 + 1, var_137_0[var_137_2])
		table.remove(var_137_0, var_137_2)
	end

	return var_137_1
end

function var_0_0.pbTroopToTroop(arg_138_0)
	local var_138_0 = {}
	local var_138_1 = {}

	for iter_138_0 = 1, #arg_138_0 do
		local var_138_2 = arg_138_0[iter_138_0]
		local var_138_3 = {
			_level = 1,
			_infoId = var_138_2.info_id,
			_num = var_138_2.num
		}

		var_138_0[#var_138_0 + 1] = var_138_3
	end

	return var_138_0
end

function var_0_0.troopToPbtroop(arg_139_0)
	local var_139_0 = {}
	local var_139_1 = {}

	for iter_139_0, iter_139_1 in ipairs(arg_139_0) do
		var_139_0[iter_139_0] = {
			info_id = iter_139_1._infoId,
			num = iter_139_1._num
		}
	end

	for iter_139_2, iter_139_3 in ipairs(arg_139_0) do
		var_139_1[iter_139_2] = {
			level = 1,
			info_id = iter_139_3._infoId
		}
	end

	return var_139_0, var_139_1
end

function var_0_0.saveTroops(arg_140_0)
	if var_0_0._cloneTroops == nil then
		return false
	end

	local var_140_0 = false

	for iter_140_0, iter_140_1 in pairs(var_0_0._cloneTroops) do
		if iter_140_1._isDirty then
			var_140_0 = true

			if arg_140_0 then
				P._playerCard:saveTroop(iter_140_1, iter_140_0)
			else
				break
			end
		end
	end

	return var_140_0
end

function var_0_0.initConfig(arg_141_0)
	local var_141_0 = var_0_0._userRegion._id .. "." .. arg_141_0

	lc.resetConfigFile(var_141_0)

	return var_141_0
end

function var_0_0.getActiveUnionWarCity()
	local var_142_0 = P._unionId
	local var_142_1 = var_0_0.getCurrentTime()

	if var_142_0 ~= nil and var_142_0 > 0 then
		for iter_142_0, iter_142_1 in pairs(var_0_0._unionWorld._wars) do
			if (iter_142_1._unionInfos[1]._id == var_142_0 or iter_142_1._unionInfos[2]._id == var_142_0) and var_142_1 >= iter_142_1._startTime and var_142_1 <= iter_142_1._endTime then
				return var_0_0._unionWorld._cities[iter_142_1._levelIds[1]]
			end
		end
	end

	return nil
end

function var_0_0.checkBtnClick()
	if ClientData.isDEV() then
		return true
	end

	local var_143_0 = ClientData.getCurrentTime()

	if var_143_0 - ClientData._btnClickTime < 1 then
		return false
	end

	ClientData._btnClickTime = var_143_0

	if not ClientData.checkServerDate() then
		return false
	end

	return true
end

function var_0_0.isAnyRecharged()
	return P._vip > 0 or P._vipExp > 0
end

function var_0_0.isGemRecharged()
	for iter_145_0 = Data.PurchaseType.product_1, Data.PurchaseType.product_8 do
		if var_0_0.isRecharged(iter_145_0) then
			return true
		end
	end

	return false
end

function var_0_0.isRecharged(arg_146_0)
	local var_146_0 = 0

	if arg_146_0 < Data.PurchaseType.month_card_1 then
		var_146_0 = arg_146_0 - Data.PurchaseType.product_1
	elseif arg_146_0 < Data.PurchaseType.package_1 then
		var_146_0 = arg_146_0 - Data.PurchaseType.month_card_1 + 10
	elseif arg_146_0 < Data.PurchaseType.limit_minus_2 then
		var_146_0 = arg_146_0 - Data.PurchaseType.package_1 + 20
	elseif arg_146_0 < Data.PurchaseType.return_to_game then
		var_146_0 = arg_146_0 - Data.PurchaseType.limit_minus_2 + 27
	elseif arg_146_0 >= Data.PurchaseType.personal_fund_1 then
		var_146_0 = arg_146_0 - Data.PurchaseType.personal_fund_1 + 40
	end

	local var_146_1 = false

	if var_146_0 > 32 then
		var_146_1 = bit.band(math.floor(P._firstIngotRecharge / math.pow(2, 32)), bit.lshift(1, var_146_0 - 32)) ~= 0
	else
		var_146_1 = bit.band(P._firstIngotRecharge, bit.lshift(1, var_146_0)) ~= 0
	end

	return var_146_1
end

function var_0_0.setRecharged(arg_147_0)
	if arg_147_0 >= Data.PurchaseType.rare_gift_1 and arg_147_0 <= Data.PurchaseType.rare_gift_max then
		return
	end

	if arg_147_0 >= Data.PurchaseType.cumulative_newbie_start and arg_147_0 <= Data.PurchaseType.cumulative_newbie_end then
		return
	end

	if arg_147_0 >= Data.PurchaseType.arena_privilege_1 and arg_147_0 <= Data.PurchaseType.survival_privilege_2 then
		return
	end

	if arg_147_0 > Data.PurchaseType.personal_fund_7 then
		return
	end

	local var_147_0 = 0

	if arg_147_0 < Data.PurchaseType.month_card_1 then
		var_147_0 = arg_147_0 - Data.PurchaseType.product_1
	elseif arg_147_0 < Data.PurchaseType.package_1 then
		var_147_0 = arg_147_0 - Data.PurchaseType.month_card_1 + 10
	elseif arg_147_0 < Data.PurchaseType.limit_minus_2 then
		var_147_0 = arg_147_0 - Data.PurchaseType.package_1 + 20
	elseif arg_147_0 < Data.PurchaseType.return_to_game then
		var_147_0 = arg_147_0 - Data.PurchaseType.limit_minus_2 + 27
	elseif arg_147_0 >= Data.PurchaseType.personal_fund_1 then
		var_147_0 = arg_147_0 - Data.PurchaseType.personal_fund_1 + 40
	end

	if not ClientData.isRecharged(arg_147_0) then
		P._firstIngotRecharge = P._firstIngotRecharge + math.pow(2, var_147_0)
	end

	P._playerBonus._packageBonus[1120]._value = bit.band(P._firstIngotRecharge, bit.lshift(1, var_147_0))

	P._playerBonus:incIapCount(arg_147_0)

	if arg_147_0 >= Data.PurchaseType.product_1 and arg_147_0 <= Data.PurchaseType.product_8 then
		P._playerActivity:set315Recharged(arg_147_0)
	end
end

function var_0_0.isPackageRecharged()
	for iter_148_0 = Data.PurchaseType.package_1, Data.PurchaseType.package_6 do
		if not var_0_0.isRecharged(iter_148_0) then
			return false
		end
	end

	return true
end

function var_0_0.isRechargeDouble(arg_149_0)
	local var_149_0 = var_0_0.isRecharged(arg_149_0)

	if arg_149_0 >= Data.PurchaseType.product_1 and arg_149_0 <= Data.PurchaseType.product_8 then
		local var_149_1 = P._playerActivity:is315Recharged(arg_149_0)

		var_149_0 = var_149_0 and var_149_1
	end

	return not var_149_0 or P:isDoubleIngotEnabled()
end

function var_0_0.isRecharge7BonusClaimed()
	return P._playerBonus._packageBonus[1306]._isClaimed
end

function var_0_0.getRecharge7BonusValue()
	return P._playerBonus._packageBonus[1306]._value
end

function var_0_0.isReturnToGameClaimed()
	local var_152_0 = P._playerBonus._returnBonus

	return var_152_0 and var_152_0._isClaimed or false
end

function var_0_0.isReturnToGame()
	local var_153_0 = P._playerBonus._returnBonus

	return var_153_0 and var_153_0._value >= var_153_0._info._val or false
end

function var_0_0.getProductNamePrefix()
	local var_154_0 = var_0_0.getAppId()

	if var_154_0 == "1364792637" then
		return "com.lan.wteng.juedw."
	elseif var_154_0 == "1370736015" then
		return "com.talegame.des.tiny."
	elseif var_154_0 == "1374769623" then
		return "com.card.duelmast."
	elseif var_154_0 == "1380032942" then
		return "com.extreme.game.jdc."
	elseif var_154_0 == "1380147350" then
		return "com.tianyao.jdou.yx."
	elseif var_154_0 == "1382539578" then
		return "com.jdwgame.kingcard."
	elseif var_154_0 == "1385371135" then
		return "com.decistrgle.jdgx."
	elseif var_154_0 == "1385334860" then
		return "com.mhuat.yxzhizhan."
	elseif var_154_0 == "1387402565" then
		return "com.htblood.king."
	elseif var_154_0 == "1159723149" then
		return "com.bie.iphone.game.nvhuang."
	elseif var_154_0 == "1392927189" then
		return "com.perso.magic."
	elseif var_154_0 == "1392243798" then
		return "com.yxwzc.gf."
	elseif var_154_0 == "1397398906" then
		return "com.coalition.rencounter."
	elseif lc.App.getPackageId then
		local var_154_1 = lc.App:getPackageId()

		if var_154_1 ~= nil and var_154_1 ~= "" then
			return var_154_1 .. "."
		end
	end

	return "com.game.juedouzc."
end

function var_0_0.getProductNameByPrice(arg_155_0)
	if arg_155_0 == 6 then
		return var_0_0.getProductNamePrefix() .. "package2.ticket_6"
	elseif arg_155_0 == 30 then
		return var_0_0.getProductNamePrefix() .. "package3.ticket_30"
	elseif arg_155_0 == 28 then
		return var_0_0.getProductNamePrefix() .. "gold.ticket_28"
	elseif arg_155_0 == 68 then
		return var_0_0.getProductNamePrefix() .. "gold.ticket_68"
	elseif arg_155_0 == 88 then
		return var_0_0.getProductNamePrefix() .. "gold.ticket_88"
	else
		local var_155_0 = var_0_0.getAppId()

		if arg_155_0 == 98 and var_155_0 == "1382539578" then
			return var_0_0.getProductNamePrefix() .. "gem1.ticket_" .. arg_155_0
		else
			return var_0_0.getProductNamePrefix() .. "gem.ticket_" .. arg_155_0
		end
	end
end

function var_0_0.getProductName(arg_156_0, arg_156_1)
	local var_156_0 = var_0_0.getPrice(arg_156_0)

	if arg_156_0 <= Data.PurchaseType.product_8 then
		return var_0_0.getProductNamePrefix() .. "gem.ticket_" .. math.floor(ClientData.getIngot(arg_156_0) / 10)
	elseif arg_156_0 == Data.PurchaseType.month_card_1 then
		return var_0_0.getProductNamePrefix() .. "gold.ticket_28"
	elseif arg_156_0 == Data.PurchaseType.month_card_2 then
		return var_0_0.getProductNamePrefix() .. "gold.ticket_68"
	elseif arg_156_0 == Data.PurchaseType.fund then
		return var_0_0.getProductNamePrefix() .. "gold.ticket_88"
	elseif arg_156_0 == Data.PurchaseType.package_1 then
		return var_0_0.getProductNamePrefix() .. "package1.ticket_6"
	elseif arg_156_0 == Data.PurchaseType.package_3 then
		return var_0_0.getProductNamePrefix() .. "package3.ticket_30"
	else
		return var_0_0.getProductNameByPrice(var_156_0)
	end
end

function var_0_0.getProductTitle(arg_157_0)
	if arg_157_0 == Data.PurchaseType.month_card_1 then
		return ClientData.isAppStoreReviewing() and Str(STR.SUPER_BONUS_1) or Str(STR.MONTH_CARD1)
	elseif arg_157_0 == Data.PurchaseType.month_card_2 then
		return ClientData.isAppStoreReviewing() and Str(STR.SUPER_BONUS_2) or Str(STR.MONTH_CARD2)
	elseif arg_157_0 == Data.PurchaseType.month_card_3 or arg_157_0 == Data.PurchaseType.month_card_4 or arg_157_0 == Data.PurchaseType.month_card_5 or arg_157_0 == Data.PurchaseType.month_card_6 then
		return Str(STR.MONTH_CARD3)
	elseif arg_157_0 == Data.PurchaseType.badge_ex or arg_157_0 == Data.PurchaseType.badge_ex2 then
		return Str(STR.MONTH_CARD3)
	elseif arg_157_0 == Data.PurchaseType.fund then
		return ClientData.isAppStoreReviewing() and Str(STR.SUPER_BONUS_3) or Str(STR.FUND_LEVEL)
	elseif arg_157_0 == Data.PurchaseType.daily_1 then
		return ClientData.getProductTitle(Data.PurchaseType.package_2)
	elseif arg_157_0 == Data.PurchaseType.daily_2 then
		return ClientData.getProductTitle(Data.PurchaseType.package_3)
	elseif arg_157_0 == Data.PurchaseType.daily_3 then
		return ClientData.getProductTitle(Data.PurchaseType.package_4)
	elseif arg_157_0 == Data.PurchaseType.active_1 then
		return Str(STR.ACTIVE_GIFT_TITLE1)
	elseif arg_157_0 == Data.PurchaseType.active_2 then
		return Str(STR.ACTIVE_GIFT_TITLE2)
	elseif arg_157_0 == Data.PurchaseType.privilege_1 then
		return Str(STR.PRIVILEGE_TITLE) .. "1"
	elseif arg_157_0 == Data.PurchaseType.privilege_2 then
		return Str(STR.PRIVILEGE_TITLE) .. "2"
	elseif arg_157_0 >= Data.PurchaseType.package_1 and arg_157_0 < Data.PurchaseType.limit_minus_2 then
		return Str(STR.SUPER_PACKAGE_1 + arg_157_0 - Data.PurchaseType.package_1)
	elseif arg_157_0 >= Data.PurchaseType.limit_minus_2 and arg_157_0 <= Data.PurchaseType.limit_2 then
		return Str(STR.LIMIT_PACKAGE_MINUS_2 + arg_157_0 - Data.PurchaseType.limit_minus_2)
	elseif arg_157_0 >= Data.PurchaseType.skill_1 and arg_157_0 <= Data.PurchaseType.skill_max then
		return Str(STR.SKILL_TOKEN) .. arg_157_0 - Data.PurchaseType.skill_1 + 1
	elseif arg_157_0 >= Data.PurchaseType.personal_fund_1 and arg_157_0 <= Data.PurchaseType.personal_fund_7 then
		return Str(STR.PERSONAL_FUND_1 + arg_157_0 - Data.PurchaseType.personal_fund_1)
	elseif arg_157_0 >= Data.PurchaseType.arena_privilege_1 and arg_157_0 <= Data.PurchaseType.survival_privilege_2 then
		return Str(STR.ARENA_PRIVILEGE_1 + arg_157_0 - Data.PurchaseType.arena_privilege_1)
	elseif arg_157_0 >= Data.PurchaseType.rare_gift_1 and arg_157_0 <= Data.PurchaseType.rare_gift_max then
		return Str(STR.RARE_GIFT) .. arg_157_0 - Data.PurchaseType.rare_gift_1 + 1
	else
		return string.format("%d %s", ClientData.getIngot(arg_157_0), Str(STR.SID_RES_NAME_3))
	end
end

function var_0_0.pay(arg_158_0, arg_158_1)
	if arg_158_0 >= Data.PurchaseType.cumulative_newbie_start and arg_158_0 <= Data.PurchaseType.cumulative_newbie_end then
		arg_158_0 = arg_158_0 % 10
	end

	var_0_0._purchaseType = arg_158_0
	var_0_0._purchaseId = arg_158_1

	local var_158_0 = string.gsub(P._name, "'", "")
	local var_158_1 = var_0_0.getPrice(arg_158_0)
	local var_158_2

	if lc.App:getChannelName() == "OPPO" then
		local var_158_3 = arg_158_0 == Data.PurchaseType.month_card_1 or arg_158_0 == Data.PurchaseType.month_card_2
		local var_158_4 = arg_158_0 == Data.PurchaseType.fund or arg_158_0 >= Data.PurchaseType.personal_fund_1 and arg_158_0 <= Data.PurchaseType.personal_fund_7
		local var_158_5 = (var_158_3 or var_158_4) and 1 or var_0_0.getIngot(arg_158_0)

		var_158_1 = var_158_1 / var_158_5

		local var_158_6 = (var_158_3 or var_158_4) and var_0_0.getProductName(arg_158_0, true) or Str(STR.SID_RES_NAME_3)

		var_158_2 = {
			exchangeRate = 10,
			productId = arg_158_0,
			productName = var_158_6,
			purchaseId = arg_158_1,
			price = var_158_1,
			count = var_158_5,
			regionId = var_0_0._userRegion._id,
			userId = P._id,
			userName = var_158_0,
			userLevel = P._level
		}
	elseif lc.App:getChannelName() == "MEIZU" or lc.App:getChannelName() == "SY37" or lc.App:getChannelName() == "YYB" then
		local var_158_7 = var_0_0.getIngot(arg_158_0)

		var_158_1 = var_158_1 / var_158_7

		local var_158_8 = Str(STR.SID_RES_NAME_3)

		var_158_2 = {
			exchangeRate = 10,
			productId = arg_158_0,
			productName = var_158_8,
			purchaseId = arg_158_1,
			price = var_158_1,
			count = var_158_7,
			regionId = var_0_0._userRegion._id,
			userId = P._id,
			userName = var_158_0,
			userLevel = P._level
		}
	elseif lc.App:getChannelName() == "OFFICIAL" then
		local var_158_9
		local var_158_10 = arg_158_0 == Data.PurchaseType.month_card_1 and 7 or arg_158_0 == Data.PurchaseType.month_card_2 and 8 or arg_158_0

		var_158_2 = {
			count = 1,
			exchangeRate = 10,
			productId = var_158_10,
			productName = var_0_0.getProductName(arg_158_0, true),
			purchaseId = arg_158_1,
			price = var_158_1,
			regionId = var_0_0._userRegion._id,
			userId = P._id,
			userName = var_158_0,
			userLevel = P._level
		}
	elseif lc.App:getChannelName() == "ASDK" then
		if lc.PLATFORM == cc.PLATFORM_OS_ANDROID then
			local var_158_11 = Data.PurchaseTypeConvert[arg_158_0] or arg_158_0
			local var_158_12 = var_0_0.getProductTitle(var_158_11)

			var_158_2 = {
				count = 1,
				exchangeRate = 10,
				productId = arg_158_0,
				productName = var_158_12,
				purchaseId = arg_158_1,
				price = var_158_1,
				regionId = var_0_0._userRegion._id,
				userId = P._id,
				userName = var_158_0,
				userLevel = P._level,
				userVipLevel = P._vip
			}
		elseif ClientData.isAppStore() then
			var_158_2 = {
				count = 1,
				exchangeRate = 10,
				productId = arg_158_0,
				productName = var_0_0.getProductName(arg_158_0, true),
				purchaseId = arg_158_1,
				price = var_158_1,
				regionId = var_0_0._userRegion._id,
				userId = P._id,
				userName = var_158_0,
				userLevel = P._level,
				userVipLevel = P._vip
			}
		else
			var_158_2 = {
				count = 1,
				exchangeRate = 10,
				productId = arg_158_0,
				productName = var_0_0.getProductTitle(arg_158_0),
				purchaseId = arg_158_1,
				price = var_158_1,
				regionId = var_0_0._userRegion._id,
				userId = P._id,
				userName = var_158_0,
				userLevel = P._level,
				userVipLevel = P._vip
			}
		end
	else
		var_158_2 = {
			count = 1,
			exchangeRate = 10,
			productId = arg_158_0,
			productName = var_0_0.getProductName(arg_158_0, lc.App:getChannelName() ~= "TONGBUTUI" and lc.App:getChannelName() ~= "YIXIN"),
			purchaseId = arg_158_1,
			price = var_158_1,
			regionId = var_0_0._userRegion._id,
			userId = P._id,
			userName = var_158_0,
			userLevel = P._level
		}
	end

	local var_158_13 = json.encode(var_158_2)

	print("####", var_158_13)
	lc.App:pay(var_158_13)
end

function var_0_0.getPrice(arg_159_0)
	if lc.App:getChannelName() ~= "APPSTORE" or not Data._globalInfo._ingotRmb then
		local var_159_0 = Data._globalInfo._ingotRmb
	end

	if arg_159_0 < Data.PurchaseType.month_card_1 then
		return Data._globalInfo._ingotRmb[arg_159_0]
	elseif arg_159_0 < Data.PurchaseType.package_1 then
		return Data._globalInfo._monthCardRmb[arg_159_0 - Data.PurchaseType.month_card_1 + 1]
	elseif arg_159_0 < Data.PurchaseType.limit_minus_2 then
		return Data._globalInfo._packageRmb[arg_159_0 - Data.PurchaseType.package_1 + 1]
	elseif arg_159_0 < Data.PurchaseType.return_to_game then
		return Data._globalInfo._limitRmb[arg_159_0 - Data.PurchaseType.limit_minus_2 + 1]
	elseif arg_159_0 >= Data.PurchaseType.personal_fund_1 and arg_159_0 < 2000 then
		return Data._globalInfo._fundRmb[arg_159_0 - Data.PurchaseType.personal_fund_1 + 1]
	elseif arg_159_0 >= Data.PurchaseType.rare_gift_1 and arg_159_0 <= Data.PurchaseType.rare_gift_max then
		return Data._globalInfo._rareGiftRmb[arg_159_0 - Data.PurchaseType.rare_gift_1 + 1]
	elseif arg_159_0 >= Data.PurchaseType.cumulative_newbie_start and arg_159_0 <= Data.PurchaseType.cumulative_newbie_end then
		return Data._globalInfo._ingotRmb[arg_159_0 % 10]
	end
end

function var_0_0.getDisplayPrice(arg_160_0)
	local var_160_0
	local var_160_1 = lc.App:getChannelName()

	if var_160_1 == "APPSTORE" or var_160_1 == "FACEBOOK" then
		var_160_0 = ClientData.getProductName(arg_160_0)
	end

	if var_160_0 ~= nil and lc.App.getDisplayPrice ~= nil then
		local var_160_2 = lc.App:getDisplayPrice(var_160_0)

		if var_160_2 ~= "" then
			return var_160_2
		end
	end

	return string.format("%s %d", Str(STR.RMB), ClientData.getPrice(arg_160_0))
end

function var_0_0.getIngot(arg_161_0, arg_161_1)
	local var_161_0 = lc.App:getChannelName()
	local var_161_1 = 0

	if arg_161_0 < Data.PurchaseType.month_card_1 then
		if not arg_161_1 and ClientData.isRechargeDouble(arg_161_0) then
			var_161_1 = Data._globalInfo._ingotValue[arg_161_0]
		else
			var_161_1 = Data._globalInfo._ingotGift[arg_161_0]

			if P._playerActivity._actChargeBonus then
				var_161_1 = var_161_1 + math.floor(values[arg_161_0] * P._playerActivity._actChargeBonus._bonusId[1] / 100)
			end
		end

		return Data._globalInfo._ingotValue[arg_161_0 - Data.PurchaseType.product_1 + 1], var_161_1
	elseif arg_161_0 < Data.PurchaseType.package_1 then
		return Data._globalInfo._monthCardRmb[arg_161_0 - Data.PurchaseType.month_card_1 + 1] * 10, var_161_1
	elseif arg_161_0 < Data.PurchaseType.limit_minus_2 then
		return Data._globalInfo._packageRmb[arg_161_0 - Data.PurchaseType.package_1 + 1] * 10, var_161_1
	elseif arg_161_0 < Data.PurchaseType.return_to_game then
		return Data._globalInfo._limitRmb[arg_161_0 - Data.PurchaseType.limit_minus_2 + 1] * 10, var_161_1
	elseif arg_161_0 >= Data.PurchaseType.personal_fund_1 and arg_161_0 <= Data.PurchaseType.personal_fund_7 then
		return Data._globalInfo._fundValue[arg_161_0 - Data.PurchaseType.personal_fund_1 + 1], var_161_1
	elseif arg_161_0 >= Data.PurchaseType.arena_privilege_1 and arg_161_0 <= Data.PurchaseType.survival_privilege_2 then
		return Data._globalInfo._fundValue[arg_161_0 - Data.PurchaseType.personal_fund_1 + 1], var_161_1
	elseif arg_161_0 >= Data.PurchaseType.rare_gift_1 and arg_161_0 <= Data.PurchaseType.rare_gift_max then
		return Data._globalInfo._rareGiftValue[arg_161_0 - Data.PurchaseType.rare_gift_1 + 1], var_161_1
	else
		return var_0_0.getPrice(arg_161_0) * 10, var_161_1
	end
end

function var_0_0.strToTimeTick(arg_162_0)
	local var_162_0 = string.splitByChar(arg_162_0, ".")

	return tonumber(var_162_0[1]) * 1000000 + tonumber(var_162_0[2]) * 10000 + tonumber(var_162_0[3]) * 100 + tonumber(var_162_0[4])
end

function var_0_0.strToMonthDay(arg_163_0, arg_163_1, arg_163_2, arg_163_3)
	if arg_163_2 then
		arg_163_1 = false
	end

	local var_163_0 = string.splitByChar(arg_163_0, ".")
	local var_163_1 = tonumber(var_163_0[1])
	local var_163_2 = tonumber(var_163_0[2])
	local var_163_3 = tonumber(var_163_0[3])
	local var_163_4 = tonumber(var_163_0[4])

	if arg_163_1 then
		var_163_3 = var_163_3 - 1

		if var_163_3 == 0 then
			var_163_2 = var_163_2 - 1

			if var_163_2 == 0 then
				var_163_2 = 12
				var_163_1 = var_163_1 - 1
			end

			var_163_3 = var_0_0.getMonthDay(var_163_1, var_163_2)
		end
	end

	if arg_163_3 then
		local var_163_5 = tostring(var_163_2) .. "." .. tostring(var_163_3)

		if arg_163_2 then
			var_163_5 = var_163_5 .. "." .. var_163_4
		end

		return var_163_5
	else
		local var_163_6 = tostring(var_163_2) .. Str(STR.MONTH) .. tostring(var_163_3) .. Str(STR.DAY_RI)

		if arg_163_2 then
			var_163_6 = var_163_6 .. var_163_4 .. Str(STR.HOUR_S)
		end

		return var_163_6
	end
end

function var_0_0.getActivityDuration(arg_164_0)
	return var_0_0.strToTimeTick(arg_164_0._beginTime), var_0_0.strToTimeTick(arg_164_0._endTime)
end

function var_0_0.getActivityDurationStr(arg_165_0, arg_165_1, arg_165_2, arg_165_3)
	local var_165_0 = var_0_0.strToMonthDay(arg_165_0._beginTime, false, arg_165_2, arg_165_3)
	local var_165_1 = var_0_0.strToMonthDay(arg_165_0._endTime, true, arg_165_2, arg_165_3)

	if arg_165_1 then
		return var_165_0, var_165_1
	elseif var_165_0 ~= var_165_1 then
		return var_165_0 .. " - " .. var_165_1
	else
		return var_165_0
	end
end

function var_0_0.tick2Date(arg_166_0)
	return math.floor(arg_166_0 / 1000000), math.floor(arg_166_0 / 10000) % 100, math.floor(arg_166_0 / 100) % 100, arg_166_0 % 100
end

function var_0_0.isActivityValid(arg_167_0)
	if arg_167_0 == nil then
		return false
	end

	local var_167_0 = arg_167_0._type[1]

	if arg_167_0._couldTest == 1 and P:hasPrivilege(Data.Privilege.test) then
		return true
	end

	if var_167_0 and var_167_0 >= Data.ActivityType.new_server_begin and var_167_0 <= Data.ActivityType.new_server_end then
		return var_167_0 - Data.ActivityType.new_server_begin < 2 and P:isNewBieByServerOpenTime(8) or P:isNewBieByServerOpenTime(7)
	end

	local var_167_1 = ClientData.getServerTick()
	local var_167_2, var_167_3 = ClientData.getActivityDuration(arg_167_0)

	if var_167_0 and var_167_0 >= Data.ActivityType.rank1 and var_167_0 <= Data.ActivityType.rank2 then
		local var_167_4 = P._serverOpenTime + P._timeOffset
		local var_167_5 = P._serverOpenTime + P._timeOffset + 691200
		local var_167_6 = ClientData.getServerTick(var_167_4)
		local var_167_7 = ClientData.getServerTick(var_167_5)

		if var_167_6 <= var_167_2 and var_167_2 <= var_167_7 or var_167_6 <= var_167_3 and var_167_3 <= var_167_7 then
			return false
		end
	end

	if var_167_2 <= var_167_1 and var_167_1 < var_167_3 then
		return true
	end

	local var_167_8 = arg_167_0._param[1]

	if var_167_8 and var_167_8 == Data.PurchaseType.limit_minus_1 and P:isNewBie(10) then
		return true
	end

	return false
end

function var_0_0.isActivityForSubChannel(arg_168_0)
	local var_168_0 = ClientData.getSubChannelType()

	for iter_168_0 = 1, #arg_168_0._subChannel do
		if arg_168_0._subChannel[iter_168_0] == var_168_0 then
			return true
		end
	end

	return false
end

function var_0_0.getValidActivityByParam(arg_169_0, arg_169_1)
	for iter_169_0, iter_169_1 in pairs(Data._activityInfo) do
		if iter_169_1._param[1] == arg_169_0 and var_0_0.isActivityForSubChannel(iter_169_1) and ClientData.isActivityValid(iter_169_1) and (not arg_169_1 or iter_169_1._type[1] == 1601) then
			return iter_169_1
		end
	end

	return nil
end

function var_0_0.getActivityByType(arg_170_0)
	for iter_170_0, iter_170_1 in pairs(Data._activityInfo) do
		if iter_170_1._type[1] == arg_170_0 and var_0_0.isActivityForSubChannel(iter_170_1) then
			return iter_170_1
		end
	end

	return nil
end

function var_0_0.getValidActivityByType(arg_171_0)
	for iter_171_0, iter_171_1 in pairs(Data._activityInfo) do
		if iter_171_1._type[1] == arg_171_0 and var_0_0.isActivityForSubChannel(iter_171_1) and ClientData.isActivityValid(iter_171_1) then
			return iter_171_1
		end
	end

	return nil
end

function var_0_0.getActivityByTypeAndParam(arg_172_0, arg_172_1)
	for iter_172_0, iter_172_1 in pairs(Data._activityInfo) do
		if iter_172_1._type[1] == arg_172_0 and var_0_0.isActivityForSubChannel(iter_172_1) then
			for iter_172_2 = 1, #iter_172_1._param do
				if iter_172_1._param[iter_172_2] == arg_172_1 then
					return iter_172_1, iter_172_2
				end
			end
		end
	end

	return nil
end

function var_0_0.getValidActivityByTypeAndParam(arg_173_0, arg_173_1)
	local var_173_0, var_173_1 = ClientData.getActivityByTypeAndParam(arg_173_0, arg_173_1)

	if var_173_0 and ClientData.isActivityValid(var_173_0) then
		return var_173_0, var_173_1
	end

	return nil
end

function var_0_0.isActivityValidByParam(arg_174_0, arg_174_1)
	return ClientData.getValidActivityByParam(arg_174_0, arg_174_1) ~= nil
end

function var_0_0.clearActivityShowed(arg_175_0)
	lc.writeConfig(ClientData.ConfigKey.activity_show_day .. arg_175_0, 0)
end

function var_0_0.setActivityShowed(arg_176_0)
	local var_176_0 = math.floor(ClientData.getServerTick() / 100)

	lc.writeConfig(ClientData.ConfigKey.activity_show_day .. arg_176_0, var_176_0)
end

function var_0_0.isActivityShowed(arg_177_0)
	local var_177_0 = math.floor(ClientData.getServerTick() / 100)

	return lc.readConfig(ClientData.ConfigKey.activity_show_day .. arg_177_0, 0) == var_177_0
end

function var_0_0.startFriendBattle(arg_178_0)
	local var_178_0, var_178_1 = P._playerCard:checkTroop(P._curTroopIndex)

	if not var_178_0 then
		ToastManager.push(var_178_1)

		return
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	var_0_0.sendFriendBattle(P._curTroopIndex, arg_178_0)
end

function var_0_0.sendBattleDebugLog()
	local var_179_0 = SglMsg_pb.SglReqMsg()

	var_179_0.type = SglMsgType_pb.PB_TYPE_BATTLE_ERROR

	var_0_0.sendProtoMsg(var_179_0)
end

function var_0_0.genGuidanceTroop(arg_180_0)
	local var_180_0 = Data._guidanceInfo[arg_180_0]
	local var_180_1 = {}
	local var_180_2 = {}
	local var_180_3 = {}
	local var_180_4 = {}
	local var_180_5 = 0
	local var_180_6 = 0

	for iter_180_0 = 1, 2 do
		local var_180_7 = iter_180_0 == 1 and var_180_1 or var_180_3
		local var_180_8 = iter_180_0 == 1 and var_180_2 or var_180_4
		local var_180_9 = Data._troopInfo[iter_180_0 == 1 and var_180_0._card or var_180_0._oppoCard]

		if iter_180_0 == 1 then
			var_180_5 = var_180_9._fortressHp
		else
			var_180_6 = var_180_9._fortressHp
		end

		for iter_180_1 = 1, #var_180_9._infoId do
			var_180_7[iter_180_1] = {
				info_id = var_180_9._infoId[iter_180_1],
				num = var_180_9._num[iter_180_1]
			}
			var_180_8[iter_180_1] = {
				info_id = var_180_9._infoId[iter_180_1],
				level = var_180_9._level[iter_180_1]
			}
		end
	end

	return var_180_1, var_180_2, var_180_5, var_180_3, var_180_4, var_180_6
end

function var_0_0.genTestTroop()
	local var_181_0 = {}
	local var_181_1 = {}
	local var_181_2 = {}
	local var_181_3 = {}
	local var_181_4 = Data._testInfo

	for iter_181_0 = 1, 2 do
		local var_181_5 = iter_181_0 == 1 and "_attacker" or "_defender"
		local var_181_6 = iter_181_0 == 1 and var_181_0 or var_181_2
		local var_181_7 = iter_181_0 == 1 and var_181_1 or var_181_3

		for iter_181_1 = 1, Data.TROOP_POS_COUNT do
			if var_181_4[var_181_5 .. "CardInfoId"][iter_181_1] == nil then
				break
			end

			local var_181_8 = {
				info_id = var_181_4[var_181_5 .. "CardInfoId"][iter_181_1],
				num = var_181_4[var_181_5 .. "CardNum"][iter_181_1] or 1
			}

			table.insert(var_181_6, var_181_8)

			local var_181_9 = {
				info_id = var_181_4[var_181_5 .. "CardInfoId"][iter_181_1],
				level = var_181_4[var_181_5 .. "CardLevel"][iter_181_1] or 1
			}

			table.insert(var_181_7, var_181_9)
		end
	end

	return var_181_0, var_181_1, var_181_2, var_181_3
end

function var_0_0.genTestAllTroop()
	local var_182_0 = {}
	local var_182_1 = {}

	for iter_182_0 = 1, 2 do
		local var_182_2 = iter_182_0 == 1 and var_182_0 or var_182_1

		for iter_182_1, iter_182_2 in pairs(Data._monsterInfo) do
			local var_182_3 = {
				info_id = iter_182_2._id
			}

			var_182_3.level = 15
			var_182_3.evolution_level = 2
			var_182_3.new_skill_id = 0
			var_182_3.new_skill_level = 0
			var_182_3.round = 1

			table.insert(var_182_2, var_182_3)
		end
	end

	return var_182_0, var_182_1
end

function var_0_0.addSceneSkills(arg_183_0, arg_183_1)
	local var_183_0 = arg_183_1._sceneSkills

	if var_183_0[1] and var_183_0[1][1] and var_183_0[1][1] > 0 then
		arg_183_0._opponent._fortressSkill = {
			_id = arg_183_1._sceneSkills[1][1],
			_level = arg_183_1._sceneSkills[1][2]
		}
	end

	if var_183_0[2] and var_183_0[2][1] and var_183_0[2][1] > 0 then
		arg_183_0._player._fortressSkill = {
			_id = arg_183_1._sceneSkills[2][1],
			_level = arg_183_1._sceneSkills[2][2]
		}
	end
end

function var_0_0.setBattleFromSceneId(arg_184_0)
	if arg_184_0 then
		var_0_0._fromSceneId = arg_184_0
	else
		local var_184_0 = lc._runningScene

		if var_184_0 == nil or var_184_0._sceneId ~= var_0_0.SceneId.city and var_184_0._sceneId ~= var_0_0.SceneId.world then
			var_0_0._fromSceneId = var_0_0.SceneId.city
		else
			var_0_0._fromSceneId = var_184_0._sceneId
		end
	end
end

function var_0_0.genInputFromResp(arg_185_0)
	local var_185_0 = {
		_type = arg_185_0.type,
		_timestamp = arg_185_0.timestamp,
		_copyId = arg_185_0.copy_id,
		_levelId = arg_185_0.level_id,
		_isOppoOnline = arg_185_0.is_op_online or false,
		_isAttacker = arg_185_0.is_attacker or false,
		_isWatcher = arg_185_0.is_watcher or false
	}

	var_185_0._player, var_185_0._opponent = {}, {}

	local var_185_1 = arg_185_0.player_troop.info or {}
	local var_185_2 = arg_185_0.opponent_troop.info or {}

	var_185_0._player._name, var_185_0._player._level, var_185_0._player._vip, var_185_0._player._avatar, var_185_0._player._region, var_185_0._player._regionId, var_185_0._player._privilege, var_185_0._player._monthCardType = var_185_1.name or "", var_185_1.level or 0, var_185_1.vip or 0, var_185_1.avatar or 0, var_185_1.rid, var_185_1.rid, var_185_1.privilege or 0, var_185_1.month_card or 0
	var_185_0._player._avatarFrame, var_185_0._player._cardBackId = var_185_1.avatar_frame, var_185_1.card_back == 0 and Data.PropsId.card_back or var_185_1.card_back
	var_185_0._player._isNpc = var_185_1.is_npc
	var_185_0._opponent._name, var_185_0._opponent._level, var_185_0._opponent._vip, var_185_0._opponent._avatar, var_185_0._opponent._region, var_185_0._opponent._privilege, var_185_0._opponent._monthCardType = var_185_2.name or "", var_185_2.level or 0, var_185_2.vip or 0, var_185_2.avatar or 0, var_185_2.rid, var_185_2.privilege or 0, var_185_2.month_card or 0
	var_185_0._opponent._avatarFrame, var_185_0._opponent._cardBackId = var_185_2.avatar_frame, var_185_2.card_back == 0 and Data.PropsId.card_back or var_185_2.card_back
	var_185_0._opponent._bossId = arg_185_0:HasField("boss_id") and arg_185_0.boss_id or 0
	var_185_0._opponent._isNpc = var_185_2.is_npc
	var_185_0._player._monthCardType, var_185_0._opponent._monthCardType = (var_185_1.battle_round_extra_time_flag or 0) * 4 + var_185_0._player._monthCardType, (var_185_2.battle_round_extra_time_flag or 0) * 4 + var_185_0._opponent._monthCardType
	var_185_0._player._isNewRound, var_185_0._opponent._isNewRound = arg_185_0.player_troop.round_optimization, arg_185_0.opponent_troop.round_optimization
	var_185_0._player._roundTimeInit, var_185_0._opponent._roundTimeInit = arg_185_0.player_troop.init_round_timeout, arg_185_0.opponent_troop.init_round_timeout
	var_185_0._player._roundTimeMax, var_185_0._opponent._roundTimeMax = arg_185_0.player_troop.round_timeout, arg_185_0.opponent_troop.round_timeout
	var_185_0._player._roundTimeDelta, var_185_0._opponent._roundTimeDelta = arg_185_0.player_troop.round_extra_timeout, arg_185_0.opponent_troop.round_extra_timeout
	var_185_0._player._troopCards, var_185_0._opponent._troopCards = arg_185_0.player_troop.cards, arg_185_0.opponent_troop.cards
	var_185_0._player._troopLevels, var_185_0._opponent._troopLevels = arg_185_0.player_troop.levels, arg_185_0.opponent_troop.levels
	var_185_0._player._extraSkills, var_185_0._opponent._extraSkills = arg_185_0.player_troop.card_extra_skills, arg_185_0.opponent_troop.card_extra_skills
	var_185_0._player._troopSkins, var_185_0._opponent._troopSkins = arg_185_0.player_troop.skins, arg_185_0.opponent_troop.skins
	var_185_0._player._fortressHp, var_185_0._opponent._fortressHp = arg_185_0.player_troop.hp, arg_185_0.opponent_troop.hp
	var_185_0._player._trophy = var_185_1.trophy
	var_185_0._opponent._trophy = var_185_2.trophy
	var_185_0._player._idInRoom, var_185_0._opponent._idInRoom = arg_185_0.player_troop.id, arg_185_0.opponent_troop.id
	var_185_0._player._crown = nil

	if var_185_1:HasField("crown") then
		var_185_0._player._crown = {
			_infoId = var_185_1.crown.info_id,
			_num = var_185_1.crown.num
		}
	end

	var_185_0._opponent._crown = nil

	if var_185_2:HasField("crown") then
		var_185_0._opponent._crown = {
			_infoId = var_185_2.crown.info_id,
			_num = var_185_2.crown.num
		}
	end

	var_185_0._player._legendCrown = nil

	if var_185_1:HasField("legend_crown") then
		var_185_0._player._legendCrown = {
			_infoId = var_185_1.legend_crown.info_id,
			_num = var_185_1.legend_crown.num
		}
	end

	var_185_0._opponent._legendCrown = nil

	if var_185_2:HasField("legend_crown") then
		var_185_0._opponent._legendCrown = {
			_infoId = var_185_2.legend_crown.info_id,
			_num = var_185_2.legend_crown.num
		}
	end

	var_185_0._player._avatarFrameCount = 0

	if var_185_1:HasField("avatar_frame_count") then
		var_185_0._player._avatarFrameCount = var_185_1.avatar_frame_count
	end

	var_185_0._opponent._avatarFrameCount = 0

	if var_185_2:HasField("avatar_frame_count") then
		var_185_0._opponent._avatarFrameCount = var_185_2.avatar_frame_count
	end

	if #arg_185_0.player_used_cards > 0 then
		var_185_0._player._usedCards = {
			_hasTime = true
		}

		for iter_185_0, iter_185_1 in ipairs(arg_185_0.player_used_cards) do
			var_185_0._player._usedCards[iter_185_0] = iter_185_1
		end
	end

	if #arg_185_0.opponent_used_cards > 0 then
		var_185_0._opponent._usedCards = {
			_hasTime = true
		}

		for iter_185_2, iter_185_3 in ipairs(arg_185_0.opponent_used_cards) do
			var_185_0._opponent._usedCards[iter_185_2] = iter_185_3
		end
	end

	if #arg_185_0.random_seq > 0 then
		var_185_0._randomSeed = arg_185_0.random_seq[1]

		print("BATTLE RANDOM SEED   ", arg_185_0.random_seq[1])
	end

	var_0_0._isOppoOnline = var_185_0._isOppoOnline
	var_0_0._usedCardsToAdd = {}
	var_0_0._observeUsedCards = {}
	var_185_0._ruleType = arg_185_0.rule_type

	return var_185_0
end

function var_0_0.genInputFromAttackResp(arg_186_0)
	local var_186_0 = var_0_0.genInputFromResp(arg_186_0)
	local var_186_1 = Data._levelInfo[var_186_0._levelId]

	var_186_0._sceneType = Data.getSceneTypeByCityId(var_186_0._levelId)
	ClientData._battleFromTravel = var_186_1

	if arg_186_0.type == Battle_pb.PB_BATTLE_NPC then
		var_186_0._battleType = Data.BattleType.npc
	elseif arg_186_0.type == Battle_pb.PB_BATTLE_PLAYER then
		var_186_0._battleType = Data.BattleType.PVP_revenge
	elseif arg_186_0.type == Battle_pb.PB_BATTLE_RESCUE then
		var_186_0._battleType = Data.BattleType.PVP_rescue
	elseif arg_186_0.type == Battle_pb.PB_BATTLE_MATCH then
		var_186_0._battleType = Data.BattleType.PVP_room
	elseif arg_186_0.type == Battle_pb.PB_BATTLE_MASSWAR_MULTIPLE then
		var_186_0._battleType = Data.BattleType.PVP_group
	elseif arg_186_0.type == Battle_pb.PB_BATTLE_DARK then
		var_186_0._battleType = Data.BattleType.PVP_dark
	elseif arg_186_0.type == Battle_pb.PB_BATTLE_SURVIVAL then
		var_186_0._battleType = Data.BattleType.PVP_survival
	elseif arg_186_0.type == Battle_pb.PB_BATTLE_SURVIVAL_EX then
		var_186_0._battleType = Data.BattleType.PVP_survival_ex
	elseif arg_186_0.type == Battle_pb.PB_BATTLE_WORLD_LEGEND then
		var_186_0._battleType = Data.BattleType.PVP_clash_ex
	else
		if arg_186_0.type == Battle_pb.PB_BATTLE_WORLD_BOSS then
			local var_186_2 = Data._troopInfo[var_186_1._opponentTroopID]
			local var_186_3

			for iter_186_0, iter_186_1 in ipairs(var_186_2._infoId) do
				if Data.getInfo(iter_186_1)._nature == Data.CardCountry.mo then
					var_186_0._worldBossId = iter_186_1

					break
				end
			end

			var_186_0._battleType = Data.BattleType.world_boss
		else
			var_186_0._battleType = Data.BattleType.task
		end

		var_186_0._opponent._name = Str(Data._levelInfo[var_186_0._levelId]._nameSid)
		var_186_0._opponent._level = 0
		var_186_0._conditionIds = var_186_1._condition
		var_186_0._conditionValues = var_186_1._value
		var_186_0._eventIds = var_186_1._eventId
		var_186_0._oppoEventIds = var_186_1._oppoEventId

		if var_186_1._storyOppoUsedCards[1] > 0 and var_186_0._opponent._usedCards == nil then
			var_186_0._opponent._usedCards = var_186_1._storyOppoUsedCards
		end

		var_186_0._storyRound = var_186_1._storyRound
		var_186_0._storyName = Str(var_186_1._storyName)
		var_186_0._sceneType = Data.getSceneTypeByCityId(var_186_0._levelId)

		var_0_0.addSceneSkills(var_186_0, var_186_1)
	end

	return var_186_0
end

function var_0_0.genInputFromChallengeResp(arg_187_0)
	local var_187_0 = var_0_0.genInputFromResp(arg_187_0)
	local var_187_1 = Data._levelInfo[var_187_0._levelId]

	ClientData._battleFromTravel = var_187_1
	var_187_0._battleType = Data.BattleType.sweep
	var_187_0._opponent._name = Str(var_187_1._nameSid)
	var_187_0._conditionIds = var_187_1._condition
	var_187_0._conditionValues = var_187_1._value
	var_187_0._eventIds = var_187_1._eventId
	var_187_0._oppoEventIds = var_187_1._oppoEventId
	var_187_0._storyRound = var_187_1._storyRound
	var_187_0._storyName = Str(var_187_1._storyName)
	var_187_0._sceneType = Data.getSceneTypeByCityId(var_187_0._levelId)

	var_0_0.addSceneSkills(var_187_0, var_187_1)

	return var_187_0
end

function var_0_0.genInputFromFindStartResp(arg_188_0)
	local var_188_0 = var_0_0.genInputFromResp(arg_188_0)

	var_188_0._sceneType = arg_188_0.opponent_troop.info.id % 4 + 1

	if arg_188_0:HasField("level_id") then
		var_188_0._battleType = Data.BattleType.PVP_revenge
		var_188_0._levelId = arg_188_0.level_id
	elseif arg_188_0.type == Battle_pb.PB_BATTLE_WORLD_LADDER then
		-- The rank ladder is played live, both clients relaying their moves
		-- through the server, so it runs on the room mode machinery: PVP_clash
		-- is this client ASYNCHRONOUS arena - it fights a stored copy of the
		-- opponent and never consumes a relayed move, which leaves the two
		-- sides staring at empty boards. _isRankLadder is what still marks it
		-- as a rank game, so the result moves the rank board rather than the
		-- arena trophy and the battle returns to the arena screen.
		var_188_0._battleType = Data.BattleType.PVP_room
		var_188_0._isRankLadder = true
		ClientData._battleFromFindIndex = Data.FindMatchType.clash

		var_0_0.setBattleFromSceneId(ClientData.SceneId.find)
	elseif arg_188_0.type == Battle_pb.PB_BATTLE_MATCH then
		-- a server-relayed room duel: both clients play the network mode
		var_188_0._battleType = Data.BattleType.PVP_room
		ClientData._battleFromFindIndex = Data.FindMatchType.hall

		var_0_0.setBattleFromSceneId(ClientData.SceneId.in_room)
	else
		var_188_0._battleType = Data.BattleType.PVP_trophy
		ClientData._battleFromFindIndex = Data.FindMatchType.rank_trophy

		var_0_0.setBattleFromSceneId(ClientData.SceneId.find)
	end

	return var_188_0
end

function var_0_0.genInputFromActivityPvpResp(arg_189_0)
	local var_189_0 = var_0_0.genInputFromResp(arg_189_0)

	var_189_0._sceneType = arg_189_0.opponent_troop.info.id % 4 + 1
	var_189_0._battleType = arg_189_0.opponent_troop.info.id == 0 and Data.BattleType.PVP_clash_npc or Data.BattleType.PVP_clash

	local var_189_1 = Data._activityTaskInfo._pvp._param[4][1]

	var_189_0._eventIds = {
		var_189_1
	}
	var_189_0._oppoEventIds = {
		var_189_1
	}

	var_0_0.setBattleFromSceneId()

	return var_189_0
end

function var_0_0.genInputFromLadderPvpResp(arg_190_0)
	local var_190_0 = var_0_0.genInputFromResp(arg_190_0)

	var_190_0._battleType = arg_190_0.opponent_troop.info.id == 0 and Data.BattleType.PVP_clash_npc or Data.BattleType.PVP_clash

	local var_190_1 = var_190_0._player._trophy
	local var_190_2 = var_190_0._opponent._trophy

	var_190_0._clashGrade = P._playerFindClash:getGrade(math.max(var_190_1, var_190_2))
	var_190_0._sceneType = 10 + var_190_0._clashGrade

	local var_190_3 = var_190_2 - var_190_1
	local var_190_4

	if var_190_0._battleType == Data.BattleType.PVP_clash_npc then
		var_190_4 = arg_190_0.npc_type + 1

		var_0_0.addSceneSkills(var_190_0, {
			_sceneSkills = {
				Data._ladderInfo[var_190_0._clashGrade]._sceneSkills[var_190_4]
			}
		})
	else
		var_190_4 = 5
	end

	var_190_0._clashOppoType = var_190_4
	ClientData._battleFromFindIndex = Data.FindMatchType.lord_clash

	var_0_0.setBattleFromSceneId(ClientData.SceneId.find)

	return var_190_0
end

function var_0_0.genInputFromMatchResp(arg_191_0)
	local var_191_0 = var_0_0.genInputFromResp(arg_191_0)

	var_191_0._battleType = Data.BattleType.PVP_room
	var_191_0._sceneType = Data.BattleSceneType.gold_scene
	ClientData._battleFromFindIndex = Data.FindMatchType.hall

	var_0_0.setBattleFromSceneId(ClientData.SceneId.in_room)

	return var_191_0
end

function var_0_0.genInputFromSurvivalResp(arg_192_0)
	local var_192_0 = var_0_0.genInputFromResp(arg_192_0)

	var_192_0._player._survivalTimeStamp = arg_192_0.player_timestamp / 1000
	var_192_0._opponent._survivalTimeStamp = arg_192_0.opponent_timestamp / 1000
	var_192_0._battleType = Data.BattleType.PVP_survival
	var_192_0._sceneType = Data.BattleSceneType.gold_scene
	ClientData._battleFromFindIndex = Data.FindMatchType.survival

	var_0_0.setBattleFromSceneId(ClientData.SceneId.survival_hall)

	return var_192_0
end

function var_0_0.genInputFromSurvivalExResp(arg_193_0)
	local var_193_0 = var_0_0.genInputFromResp(arg_193_0)

	var_193_0._player._survivalTimeStamp = arg_193_0.player_timestamp / 1000
	var_193_0._opponent._survivalTimeStamp = arg_193_0.opponent_timestamp / 1000
	var_193_0._battleType = Data.BattleType.PVP_survival_ex
	var_193_0._sceneType = Data.BattleSceneType.gold_scene
	ClientData._battleFromFindIndex = Data.FindMatchType.survival_ex

	var_0_0.setBattleFromSceneId(ClientData.SceneId.survival_ex_hall)

	return var_193_0
end

function var_0_0.genInputFromGroupResp(arg_194_0)
	local var_194_0 = var_0_0.genInputFromResp(arg_194_0)

	var_194_0._battleType = Data.BattleType.PVP_group
	var_194_0._sceneType = Data.BattleSceneType.gold_scene
	ClientData._battleFromFindIndex = Data.FindMatchType.union_battle

	var_0_0.setBattleFromSceneId(ClientData.SceneId.find)

	return var_194_0
end

function var_0_0.genInputFromDarkResp(arg_195_0)
	local var_195_0 = var_0_0.genInputFromResp(arg_195_0)

	var_195_0._battleType = Data.BattleType.PVP_dark
	var_195_0._sceneType = Data.BattleSceneType.gold_scene
	ClientData._battleFromFindIndex = Data.FindMatchType.dark

	var_0_0.setBattleFromSceneId(ClientData.SceneId.find)

	return var_195_0
end

function var_0_0.genInputFromLegendResp(arg_196_0)
	local var_196_0 = var_0_0.genInputFromResp(arg_196_0)

	var_196_0._battleType = Data.BattleType.PVP_clash_ex
	var_196_0._opponent._cardBackId = Data.PropsId.card_back
	var_196_0._sceneType = Data.BattleSceneType.gold_scene
	ClientData._battleFromFindIndex = Data.FindMatchType.clash_ex

	var_0_0.setBattleFromSceneId(ClientData.SceneId.find)

	return var_196_0
end

function var_0_0.genInputFromLadderExPvpResp(arg_197_0)
	local var_197_0 = var_0_0.genInputFromResp(arg_197_0)

	var_197_0._battleType = arg_197_0.opponent_troop.info.id == 0 and Data.BattleType.PVP_ladder_npc or Data.BattleType.PVP_ladder
	var_197_0._sceneType = 21
	ClientData._battleFromFindIndex = Data.FindMatchType.ladder

	var_0_0.setBattleFromSceneId(ClientData.SceneId.find)

	return var_197_0
end

function var_0_0.genInputFromExpeditionResp(arg_198_0, arg_198_1)
	local var_198_0 = var_0_0.genInputFromResp(arg_198_0)

	if arg_198_1 then
		P._playerExpedition:refresh(arg_198_1)
	end

	var_198_0._battleType = Data.BattleType.copy_expedition
	var_198_0._sceneType = Data.BattleSceneType.gold_scene
	ClientData._battleFromCopy = {
		_type = Data.CopyType.expedition
	}

	var_0_0.setBattleFromSceneId()

	return var_198_0
end

function var_0_0.genInputFromExpeditionExResp(arg_199_0, arg_199_1)
	local var_199_0 = var_0_0.genInputFromResp(arg_199_0)

	if arg_199_1 then
		local var_199_1 = arg_199_1

		ClientData._expeditionNpcInfos = {}

		for iter_199_0 = 1, #var_199_1.troops do
			local var_199_2 = {
				_level = var_199_1.troops[iter_199_0].level,
				_challengeCount = var_199_1.troops[iter_199_0].chanllenge_count
			}

			table.insert(ClientData._expeditionNpcInfos, var_199_2)
		end

		if var_199_1:HasField("boss") then
			local var_199_3 = var_199_1.boss

			if ClientData._expeditionBossInfo == nil then
				ClientData._expeditionBossInfo = {}
			end

			ClientData._expeditionBossInfo._challengeCount = var_199_3.chanllenge_count
		end

		ClientData._expeditionCurNpc = var_199_1.cur_npc
	end

	var_199_0._battleType = arg_199_0.type == Battle_pb.PB_BATTLE_EXPEDITION_EX_BOSS and Data.BattleType.expedition_ex_boss or Data.BattleType.expedition_ex
	var_199_0._sceneType = Data.BattleSceneType.gold_scene
	ClientData._battleFromCopy = {
		_type = Data.CopyType.expedition_ex
	}

	var_0_0.setBattleFromSceneId()

	return var_199_0
end

function var_0_0.genInputFromCommanderResp(arg_200_0)
	local var_200_0 = var_0_0.genInputFromResp(arg_200_0)
	local var_200_1 = Data._copyInfo[var_200_0._copyId]

	var_200_0._opponent._name = Str(STR.COPY_COMMANDER)
	var_200_0._opponent._level = var_200_1._level
	var_200_0._battleType = Data.BattleType.copy_commander
	var_200_0._sceneType = Data.BattleSceneType.horse_scene
	ClientData._battleFromCopy = var_200_1

	var_0_0.setBattleFromSceneId()

	return var_200_0
end

function var_0_0.genInputFromBossResp(arg_201_0)
	local var_201_0 = var_0_0.genInputFromResp(arg_201_0)
	local var_201_1 = Data._bossInfo[var_201_0._opponent._bossId]

	if var_201_0._opponent._bossId >= 101 and var_201_0._opponent._bossId <= 112 then
		var_201_0._opponent._bossLevel = P:getToadLevel(var_201_0._player._level)
		ClientData._battleFromCopy = {
			_type = Data.CopyType.boss
		}
	else
		var_201_0._opponent._bossLevel = 1
		var_201_0._opponent._isUnionBoss = true
		ClientData._battleFromUnionBoss = var_201_1

		var_0_0.addSceneSkills(var_201_0, var_201_1)

		var_201_0._opponent._assistantHp = {}
	end

	var_201_0._opponent._name = Str(var_201_1._nameSid)
	var_201_0._opponent._level = var_201_0._opponent._bossLevel
	var_201_0._battleType = Data.BattleType.boss
	var_201_0._sceneType = var_201_1._sceneType

	var_0_0.setBattleFromSceneId()

	return var_201_0
end

function var_0_0.genInputFromEliteResp(arg_202_0)
	local var_202_0 = var_0_0.genInputFromResp(arg_202_0)

	var_202_0._battleType = Data.BattleType.copy_elite

	local var_202_1 = {
		STR.BATTLE_ACTIVITY_WEI,
		STR.BATTLE_ACTIVITY_SHU,
		STR.BATTLE_ACTIVITY_WU,
		STR.BATTLE_ACTIVITY_QUN
	}
	local var_202_2 = Data._copyInfo[var_202_0._copyId]
	local var_202_3 = var_202_2._type % 10

	var_202_0._opponent._name = Str(var_202_1[var_202_3])
	var_202_0._opponent._level = var_202_2._level

	if var_202_3 == Data.CardCountry.wei then
		var_202_0._sceneType = Data.BattleSceneType.country_scene_wei
	elseif var_202_3 == Data.CardCountry.shu then
		var_202_0._sceneType = Data.BattleSceneType.country_scene_shu
	elseif var_202_3 == Data.CardCountry.wu then
		var_202_0._sceneType = Data.BattleSceneType.country_scene_wu
	elseif var_202_3 == Data.CardCountry.qun then
		var_202_0._sceneType = Data.BattleSceneType.country_scene_qun
	end

	ClientData._battleFromCopy = var_202_2

	var_0_0.setBattleFromSceneId()

	return var_202_0
end

function var_0_0.genInputFromRobExpResp(arg_203_0)
	local var_203_0 = var_0_0.genInputFromResp(arg_203_0)

	var_203_0._battleType = Data.BattleType.copy_boss

	local var_203_1 = Data._copyInfo[var_203_0._copyId]

	var_203_0._opponent._name = Str(STR.TROOP_IMMUNITY_PHY)
	var_203_0._opponent._level = var_203_1._level
	var_203_0._sceneType = Data.BattleSceneType.exp_scene

	var_0_0.addSceneSkills(var_203_0, var_203_1)

	ClientData._battleFromCopy = var_203_1

	var_0_0.setBattleFromSceneId()

	return var_203_0
end

function var_0_0.genRecommendTrainInput(arg_204_0)
	local var_204_0 = {
		_type = arg_204_0._type
	}

	var_204_0._timestamp = 0
	var_204_0._copyId = arg_204_0.copy_id
	var_204_0._levelId = arg_204_0.level_id
	var_204_0._isOppoOnline = false
	var_204_0._isAttacker = true
	var_204_0._isWatcher = false
	var_204_0._player, var_204_0._opponent = {}, arg_204_0._player
	var_204_0._player._usedCards, var_204_0._opponent._usedCards = {}, {}
	var_204_0._player._name, var_204_0._player._level, var_204_0._player._vip, var_204_0._player._avatar, var_204_0._player._region = P._name or "", P._level or 0, P._vip or 0, P._avatar or 0, P._rid
	var_204_0._player._avatarFrame, var_204_0._player._cardBackId = P._avatarFrameId, P._cardBackId
	var_204_0._player._isNpc = false

	local var_204_1 = P._playerCard:getTroop(P._curTroopIndex, true)

	var_204_0._player._troopCards, var_204_0._player._troopLevels = var_0_0.troopToPbtroop(var_204_1)
	var_204_0._player._troopSkins = {}
	var_204_0._player._fortressHp = 8000
	var_204_0._player._crown = P._crown
	var_204_0._player._avatarFrameCount = 0
	var_204_0._randomSeed = math.random(65536)
	var_0_0._isOppoOnline = var_204_0._isOppoOnline
	var_204_0._battleType = Data.BattleType.recommend_train
	var_204_0._sceneType = Data.BattleSceneType.gold_scene

	var_0_0.setBattleFromSceneId(ClientData.SceneId.city)

	return var_204_0
end

function var_0_0.genInputFromReplayResp(arg_205_0)
	local var_205_0

	if arg_205_0.type == Battle_pb.PB_BATTLE_CHAPTER or arg_205_0.type == Battle_pb.PB_BATTLE_NPC or arg_205_0.type == Battle_pb.PB_BATTLE_WORLD_BOSS then
		var_205_0 = var_0_0.genInputFromAttackResp(arg_205_0)
		var_205_0._replayingLog = nil
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_CITY then
		var_205_0 = var_0_0.genInputFromChallengeResp(arg_205_0)
		var_205_0._replayingLog = nil
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_ELITE then
		var_205_0 = var_0_0.genInputFromEliteResp(arg_205_0)
		var_205_0._replayingLog = nil
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_COMMANDER then
		var_205_0 = var_0_0.genInputFromCommanderResp(arg_205_0)
		var_205_0._replayingLog = nil
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_EXP then
		var_205_0 = var_0_0.genInputFromRobExpResp(arg_205_0)
		var_205_0._replayingLog = nil
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_GOLD or arg_205_0.type == Battle_pb.PB_BATTLE_UNION_BOSS then
		var_205_0 = var_0_0.genInputFromBossResp(arg_205_0)
		var_205_0._replayingLog = nil
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_EXPEDITION then
		var_205_0 = var_0_0.genInputFromExpeditionResp(arg_205_0)
		var_205_0._replayingLog = nil
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_EXPEDITION_EX or arg_205_0.type == Battle_pb.PB_BATTLE_EXPEDITION_EX_BOSS then
		var_205_0 = var_0_0.genInputFromExpeditionExResp(arg_205_0)
		var_205_0._replayingLog = nil
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_WORLD_LADDER then
		var_205_0 = var_0_0.genInputFromLadderPvpResp(arg_205_0)
		var_205_0._replayingLog = var_0_0._replayingLog
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_WORLD_LADDER_EX then
		var_205_0 = var_0_0.genInputFromLadderExPvpResp(arg_205_0)
		var_205_0._replayingLog = var_0_0._replayingLog
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_MATCH then
		var_205_0 = var_0_0.genInputFromMatchResp(arg_205_0)
		var_205_0._replayingLog = var_0_0._replayingLog
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_SURVIVAL then
		var_205_0 = var_0_0.genInputFromSurvivalResp(arg_205_0)
		var_205_0._replayingLog = var_0_0._replayingLog
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_MASSWAR_MULTIPLE then
		var_205_0 = var_0_0.genInputFromGroupResp(arg_205_0)
		var_205_0._replayingLog = var_0_0._replayingLog
	elseif arg_205_0.type == Battle_pb.PB_BATTLE_DARK then
		var_205_0 = var_0_0.genInputFromDarkResp(arg_205_0)
		var_205_0._replayingLog = var_0_0._replayingLog
	else
		var_205_0 = var_0_0.genInputFromResp(arg_205_0)
		var_205_0._battleType = Data.BattleType.PVP_trophy
		var_205_0._sceneType = arg_205_0.opponent_troop.info.id % 4 + 1
		var_205_0._replayingLog = var_0_0._replayingLog
	end

	var_205_0._replayBattleType = var_205_0._battleType
	var_205_0._battleType = Data.BattleType.replay

	return var_205_0
end

function var_0_0.genInputFromRecoverResp(arg_206_0, arg_206_1)
	local var_206_0 = {}
	local var_206_1 = var_0_0._fromSceneId

	if arg_206_0.type == Battle_pb.PB_BATTLE_CHAPTER or arg_206_0.type == Battle_pb.PB_BATTLE_WORLD_BOSS or arg_206_0.type == Battle_pb.PB_BATTLE_NPC or arg_206_0.type == Battle_pb.PB_BATTLE_RESCUE then
		var_206_0 = var_0_0.genInputFromAttackResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_CITY then
		var_206_0 = var_0_0.genInputFromChallengeResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_FRIEND then
		var_206_0 = var_0_0.genInputFromFriendBattleResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_PLAYER then
		var_206_0 = var_0_0.genInputFromFindStartResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_WORLD then
		var_206_0 = var_0_0.genInputFromActivityPvpResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_WORLD_LADDER then
		var_206_0 = var_0_0.genInputFromLadderPvpResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_WORLD_LADDER_EX then
		var_206_0 = var_0_0.genInputFromLadderExPvpResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_MATCH then
		var_206_0 = var_0_0.genInputFromMatchResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_MASSWAR_MULTIPLE then
		var_206_0 = var_0_0.genInputFromGroupResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_DARK then
		var_206_0 = var_0_0.genInputFromDarkResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_WORLD_LEGEND then
		var_206_0 = var_0_0.genInputFromLegendResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_SURVIVAL then
		var_206_0 = var_0_0.genInputFromSurvivalResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_SURVIVAL_EX then
		var_206_0 = var_0_0.genInputFromSurvivalExResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_ELITE then
		var_206_0 = var_0_0.genInputFromEliteResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_COMMANDER then
		var_206_0 = var_0_0.genInputFromCommanderResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_EXP then
		var_206_0 = var_0_0.genInputFromRobExpResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_EXPEDITION then
		if arg_206_1:HasExtension(World_pb.SglWorldMsg.world_refresh_expedition_resp) then
			var_206_0 = var_0_0.genInputFromExpeditionResp(arg_206_0, arg_206_1.Extensions[World_pb.SglWorldMsg.world_refresh_expedition_resp])
		else
			var_206_0 = var_0_0.genInputFromExpeditionResp(arg_206_0)
		end
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_EXPEDITION_EX or arg_206_0.type == Battle_pb.PB_BATTLE_EXPEDITION_EX_BOSS then
		if arg_206_1:HasExtension(World_pb.SglWorldMsg.world_get_expedition_ex_resp) then
			var_206_0 = var_0_0.genInputFromExpeditionExResp(arg_206_0, arg_206_1.Extensions[World_pb.SglWorldMsg.world_get_expedition_ex_resp])
		else
			var_206_0 = var_0_0.genInputFromExpeditionExResp(arg_206_0)
		end
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_GOLD or arg_206_0.type == Battle_pb.PB_BATTLE_UNION_BOSS then
		var_206_0 = var_0_0.genInputFromBossResp(arg_206_0)
	elseif arg_206_0.type == Battle_pb.PB_BATTLE_UNION then
		var_206_0 = var_0_0.genInputFromUnionBattle(arg_206_0)
	end

	var_206_0._needForward = (var_206_0._player._usedCards and #var_206_0._player._usedCards or 0) + (var_206_0._opponent._usedCards and #var_206_0._opponent._usedCards or 0) > 7

	var_0_0.setBattleFromSceneId(var_206_1)

	return var_206_0
end

function var_0_0.genInputFromFriendBattleResp(arg_207_0)
	local var_207_0 = var_0_0.genInputFromResp(arg_207_0)

	var_207_0._battleType = Data.BattleType.PVP_friend
	var_207_0._sceneType = arg_207_0.opponent_troop.info.id % 4 + 1

	return var_207_0
end

function var_0_0.genInputFromGuidance(arg_208_0)
	local var_208_0 = Data._guidanceInfo[arg_208_0]

	if var_208_0 == nil then
		return nil
	end

	local var_208_1 = {}

	var_208_1._type = nil
	var_208_1._timestamp = 0
	var_208_1._levelId = nil
	var_208_1._isOppoOnline = false
	var_208_1._isAttacker = var_208_0._isAttacker == 1
	var_208_1._player, var_208_1._opponent = {}, {}
	var_208_1._player._name, var_208_1._player._level, var_208_1._player._vip = Str(var_208_0._selfNameSid), 0, 0
	var_208_1._opponent._name, var_208_1._opponent._level, var_208_1._opponent._vip = Str(var_208_0._oppoNameSid), 0, 0
	var_208_1._player._isNpc, var_208_1._opponent._isNpc = false, false
	var_208_1._player._troopCards, var_208_1._player._troopLevels, var_208_1._player._fortressHp, var_208_1._opponent._troopCards, var_208_1._opponent._troopLevels, var_208_1._opponent._fortressHp = var_0_0.genGuidanceTroop(arg_208_0)
	var_208_1._player._troopSkins, var_208_1._opponent._troopSkins = {}, {}
	var_208_1._player._usedCards, var_208_1._opponent._usedCards = var_208_0._usedCards, var_208_0._oppoUsedCards
	var_208_1._battleType = Data.BattleType.guidance
	var_208_1._sceneType = var_208_0._sceneType
	var_208_1._eventIds = var_208_0._event
	var_208_1._oppoEventIds = var_208_0._oppoEvent

	if arg_208_0 == 1 and not ClientData.isPlayVideo() then
		for iter_208_0 = 1, #var_208_1._oppoEventIds do
			if var_208_1._oppoEventIds[iter_208_0] == 22 then
				table.remove(var_208_1._oppoEventIds, iter_208_0)

				break
			end
		end
	end

	var_208_1._conditionIds = var_208_0._conditions
	var_208_1._needForward = var_208_0._needForward ~= 0
	var_208_1._storyRound = var_208_0._storyRound
	var_208_1._storyName = Str(var_208_0._nameSid)
	var_208_1._player._avatar, var_208_1._opponent._avatar = 1, 201
	var_208_1._randomSeed = 0

	return var_208_1
end

function var_0_0.genInputFromTest(arg_209_0, arg_209_1)
	local var_209_0 = Data._testInfo
	local var_209_1 = {}

	var_209_1._type = nil
	var_209_1._timestamp = 0
	var_209_1._levelId = nil
	var_209_1._isOppoOnline = false
	var_209_1._isAttacker = true
	var_209_1._player, var_209_1._opponent = {}, {}
	var_209_1._player._name, var_209_1._player._level, var_209_1._player._vip = "Attacker", 0, 0
	var_209_1._opponent._name, var_209_1._opponent._level, var_209_1._opponent._vip = "Defender", 0, 0
	var_209_1._player._isNpc, var_209_1._opponent._isNpc = true, true
	var_209_1._player._troopCards, var_209_1._player._troopLevels, var_209_1._opponent._troopCards, var_209_1._opponent._troopLevels = var_0_0.genTestTroop(id)
	var_209_1._player._troopSkins, var_209_1._opponent._troopSkins = {}, {}
	var_209_1._player._fortressHp, var_209_1._opponent._fortressHp = var_209_0._attackerFortressHp, var_209_0._defenderFortressHp
	var_209_1._player._usedCards, var_209_1._opponent._usedCards = {}, {}
	var_209_1._eventIds, var_209_1._oppoEventIds = var_209_0._attackerEvents, var_209_0._defenderEvents
	var_209_1._storyRound = var_209_0._storyRound
	var_209_1._storyName = "Story Name"
	var_209_1._battleType = arg_209_0

	if arg_209_0 == Data.BattleType.test then
		var_209_1._sceneType = 11
		var_209_1._randomSeed = math.random(65536)
	elseif arg_209_0 == Data.BattleType.test_story then
		var_209_1._sceneType = Data.BattleSceneType.country_scene_wei

		if var_209_0._attackerUsedCards[1] ~= 0 or #var_209_0._attackerUsedCards > 1 then
			var_209_1._player._usedCards = var_209_0._attackerUsedCards
		end

		if var_209_0._defenderUsedCards[1] ~= 0 or #var_209_0._defenderUsedCards > 1 then
			var_209_1._opponent._usedCards = var_209_0._defenderUsedCards
		end

		var_209_1._randomSeed = math.random(65536)
	elseif arg_209_0 == Data.BattleType.replay then
		var_209_1._sceneType = Data.BattleSceneType.exp_scene

		if var_209_0._attackerUsedCards[1] ~= 0 or #var_209_0._attackerUsedCards > 1 then
			var_209_1._player._usedCards = var_209_0._attackerUsedCards
		end

		if var_209_0._defenderUsedCards[1] ~= 0 or #var_209_0._defenderUsedCards > 1 then
			var_209_1._opponent._usedCards = var_209_0._defenderUsedCards
		end

		var_209_1._replayingLog = {
			_isAttack = true,
			_player = {
				_level = 12,
				_avatar = 1001,
				_name = "replayPlayer",
				_trophy = 2
			},
			_opponent = {
				_level = 12,
				_avatar = 1001,
				_name = "replayPlayer",
				_trophy = 2
			}
		}
		var_209_1._randomSeed = math.random(65536)
	elseif arg_209_0 == Data.BattleType.boss then
		var_209_1._opponent._troop = {}
		var_209_1._oppoEventIds = {}
		var_209_1._opponent._bossId = arg_209_1 or 101
		var_209_1._opponent._bossLevel = 20
		var_209_1._sceneType = Data.BattleSceneType.toad_scene
		var_209_1._randomSeed = math.random(65536)
	elseif arg_209_0 == Data.BattleType.PVP_union then
		var_209_1._sceneType = Data.BattleSceneType.union_scene
		var_209_1._randomSeed = math.random(65536)
	end

	var_209_1._player._avatar, var_209_1._opponent._avatar = 301, 201
	var_209_1._player._crown, var_209_1._opponent._crown = {
		_infoId = 7201,
		_num = 1
	}, {
		_infoId = 7204,
		_num = 2
	}
	var_0_0._isOppoOnline = false

	return var_209_1
end

function var_0_0.genInputFromUnitTest()
	local var_210_0 = {
		_battleType = Data.BattleType.unittest
	}

	var_210_0._type = nil
	var_210_0._timestamp = 0
	var_210_0._levelId = nil
	var_210_0._isOppoOnline = false
	var_210_0._isAttacker = true
	var_210_0._player, var_210_0._opponent = {}, {}
	var_210_0._player._name, var_210_0._player._level, var_210_0._player._vip = "Attacker", 1, 0
	var_210_0._opponent._name, var_210_0._opponent._level, var_210_0._opponent._vip = "Defender", 1, 0
	var_210_0._player._isNpc, var_210_0._opponent._isNpc = true, true
	var_210_0._player._troopCards, var_210_0._player._troopLevels, var_210_0._player._troopSkins, var_210_0._opponent._troopCards, var_210_0._opponent._troopLevels, var_210_0._opponent._troopSkins = {}, {}, {}, {}, {}, {}, {}
	var_210_0._player._fortressHp, var_210_0._opponent._fortressHp = 8000, 8000
	var_210_0._player._usedCards, var_210_0._opponent._usedCards = {}, {}
	var_210_0._eventIds, var_210_0._oppoEventIds = {}, {}
	var_210_0._storyRound = 0
	var_210_0._storyName = ""
	var_210_0._sceneType = 11
	var_210_0._randomSeed = 0
	var_210_0._ruleType = Data.BattleRuleType.normal
	var_210_0._player._avatar, var_210_0._opponent._avatar = 301, 201
	var_0_0._isOppoOnline = false

	return var_210_0
end

function var_0_0.genInputFromUnionBattle(arg_211_0)
	local var_211_0 = var_0_0.genInputFromResp(arg_211_0)

	var_211_0._battleType = Data.BattleType.PVP_union
	var_211_0._sceneType = Data.BattleSceneType.union_scene

	return var_211_0
end

function var_0_0.setNeedSyncDataForCardListScenes()
	local var_212_0 = require("BaseScene")

	for iter_212_0 = 1, #var_212_0._sceneList do
		local var_212_1 = var_212_0._sceneList[iter_212_0]

		if var_212_1 ~= lc._runningScene and (var_212_1._sceneId == var_0_0.SceneId.manage_troop or var_212_1._sceneId == var_0_0.SceneId.factory_monster or var_212_1._sceneId == var_0_0.SceneId.factory_trap or var_212_1._sceneId == var_0_0.SceneId.stable or var_212_1._sceneId == var_0_0.SceneId.factory_magic or var_212_1._sceneId == var_0_0.SceneId.market or var_212_1._sceneId == var_0_0.SceneId.city) then
			var_212_1._needSyncData = true
		end
	end
end

function var_0_0.unloadLoadingRes(arg_213_0)
	local function var_213_0(arg_214_0)
		local function var_214_0(arg_215_0)
			return arg_214_0 and arg_214_0 .. arg_215_0 or lc.File:fullPathForFilename(arg_215_0)
		end

		lc.TextureCache:removeTextureForKey(var_214_0("res/updater/loading_" .. ClientData.getAppId() .. ".jpg"))
		lc.TextureCache:removeTextureForKey(var_214_0("res/updater/loading.jpg"))
		lc.TextureCache:removeTextureForKey(var_214_0("res/updater/loading1.jpg"))
		lc.TextureCache:removeTextureForKey(var_214_0("res/updater/loading_djlx.jpg"))
		lc.FrameCache:removeSpriteFramesFromFile("res/updater/loading.plist")
		lc.FrameCache:removeSpriteFramesFromFile(var_214_0("res/updater/loading.plist"))
		lc.TextureCache:removeTextureForKey(var_214_0("res/updater/loading.pvr.ccz"))
		lc.TextureCache:removeTextureForKey(var_214_0(string.format("res/jpg/img_loading_%s.jpg", lc.App:getChannelName())))
		lc.TextureCache:removeTextureForKey(var_214_0("res/jpg/load_btn_agreement.jpg"))
		lc.TextureCache:removeTextureForKey(var_214_0("res/jpg/load_btn_server.jpg"))
		ClientData.unloadDragonBones("loading")
	end

	if arg_213_0 then
		for iter_213_0, iter_213_1 in ipairs(lc.File:getSearchPaths()) do
			var_213_0(iter_213_1)
		end
	else
		var_213_0()
	end
end

function var_0_0.unloadBattleRes()
	ClientData.unloadLCRes({
		"battle.jpm",
		"battle.png.sfb"
	})

	for iter_216_0 = 1, Data.BattleSceneType.count do
		local var_216_0 = string.format("bat_scene_%d", iter_216_0)

		ClientData.unloadLCRes({
			var_216_0 .. ".jpm",
			var_216_0 .. ".png.sfb"
		})
		lc.TextureCache:removeTextureForKey(string.format("res/bat_scene/bat_scene_%d_bg.jpg", iter_216_0))
	end

	var_0_0.unloadAllAudio()
	var_0_0.unloadAllDragonBones()
	var_0_0.unloadAllParticle()
	var_0_0.unloadFonts(true)
end

function var_0_0.unloadCityUnionRes()
	ClientView.releaseMenuUI()
	ClientView.releaseResourceUI()
	ClientView.releaseActiveIndicator()
	ClientView.releaseChatPanel()
	var_0_0.unloadCityRes()
	var_0_0.unloadUnionRes()
	var_0_0.unloadFonts(false)
end

function var_0_0.unloadCityRes()
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/city_bg_01.jpg"))
	ClientData.unloadLCRes({
		"city.jpm",
		"city.png.sfb"
	})
	ClientData.unloadLCRes({
		"city_2.jpm",
		"city_2.png.sfb"
	})
	ClientData.unloadLCRes({
		"activity.jpm",
		"activity.png.sfb"
	})
	ClientData.unloadLCRes({
		"copy.jpm",
		"copy.png.sfb"
	})
	ClientData.unloadLCRes({
		"travel.jpm",
		"travel.png.sfb"
	})

	for iter_218_0 = 1, 10 do
		local var_218_0 = string.format("chapter_%02d", iter_218_0)

		ClientData.unloadLCRes({
			var_218_0 .. ".jpm",
			var_218_0 .. ".png.sfb"
		})
	end

	var_0_0.unloadAllAudio()
	var_0_0.unloadAllDragonBones()
	var_0_0.unloadAllParticle()
end

function var_0_0.unloadUnionRes()
	var_0_0.unloadAllAudio()
	var_0_0.unloadAllDragonBones()
	var_0_0.unloadAllParticle()
end

function var_0_0.unloadAllDragonBones()
	if Data._dragonBonesList == nil then
		local var_220_0 = lc.readFile("res/effects/list.txt")

		Data._dragonBonesList = string.splitByChar(var_220_0, "\n")
	end

	local var_220_1 = lc.File:isPopupNotify()

	lc.File:setPopupNotify(false)

	for iter_220_0, iter_220_1 in ipairs(Data._dragonBonesList) do
		var_0_0.unloadDragonBones(iter_220_1)
	end

	lc.File:setPopupNotify(var_220_1)

	var_0_0._dragonBonesTexture = {}
end

function var_0_0.unloadDragonBones(arg_221_0)
	local var_221_0 = arg_221_0 .. ".png"

	if lc.TextureCache:getTextureForKey(var_221_0) ~= nil then
		cc.DragonBonesNode:removeTextureAtlas(arg_221_0)
		lc.TextureCache:removeTextureForKey(var_221_0)
		lc.log("unload dragonbones  " .. var_221_0)
	end
end

function var_0_0.unloadAllParticle()
	if Data._particleList == nil then
		local var_222_0 = string.gsub(lc.readFile("res/particle/list.txt"), "\r", "")

		Data._particleList = string.splitByChar(var_222_0, "\n")
	end

	local var_222_1 = lc.File:isPopupNotify()

	lc.File:setPopupNotify(false)

	for iter_222_0, iter_222_1 in ipairs(Data._particleList) do
		local var_222_2 = "res/particle/" .. iter_222_1 .. ".png"

		if lc.TextureCache:getTextureForKey(var_222_2) ~= nil then
			lc.TextureCache:removeTextureForKey(var_222_2)
			lc.log("unload paritcle  " .. var_222_2)
		end
	end

	lc.File:setPopupNotify(var_222_1)

	var_0_0._particleTexture = {}
end

function var_0_0.unloadAllAudio()
	if Data._batAudioList == nil then
		local var_223_0 = string.gsub(lc.readFile("res/bat_audio/list.txt"), "\r", "")

		Data._batAudioList = string.splitByChar(var_223_0, "\n")
	end

	for iter_223_0, iter_223_1 in ipairs(Data._batAudioList) do
		local var_223_1 = "res/bat_audio/" .. iter_223_1 .. ".mp3"

		cc.SimpleAudioEngine:getInstance():unloadEffect(var_223_1)
	end

	for iter_223_2 = AUDIO.E_BATTLE_OPEN, AUDIO.M_BATTLE - 1 do
		lc.Audio.unloadAudio(iter_223_2)
	end

	lc.log("unload audio")
end

function var_0_0.unloadFonts(arg_224_0)
	local var_224_0 = arg_224_0 and ClientView.BMFONTS_BATTLE or ClientView.BMFONTS_CITY

	for iter_224_0, iter_224_1 in ipairs(var_224_0) do
		local var_224_1 = string.split(iter_224_1, ".")[1] .. ".png"

		if lc.TextureCache:getTextureForKey(var_224_1) ~= nil then
			lc.TextureCache:removeTextureForKey(var_224_1)
			lc.log("unload fonts  " .. var_224_1)
		end
	end
end

function var_0_0.preloadFonts(arg_225_0)
	local var_225_0 = arg_225_0 and ClientView.BMFONTS_BATTLE or ClientView.BMFONTS_CITY

	for iter_225_0, iter_225_1 in ipairs(var_225_0) do
		local var_225_1 = cc.Label:createWithBMFont(iter_225_1, "")
	end
end

function var_0_0.getUnionErrorStr(arg_226_0)
	if arg_226_0 == Data.ErrorType.leader_operate then
		return Str(STR.UNION_LEADER_OPERATE)
	elseif arg_226_0 == Data.ErrorType.elder_operate then
		return Str(STR.UNION_ELDER_OPERATE)
	elseif arg_226_0 == Data.ErrorType.rookie_operate then
		return Str(STR.UNION_ROOKIE_OPERATE)
	elseif arg_226_0 == Data.ErrorType.union_operate then
		return Str(STR.UNION_UNION_OPERATE)
	end

	return ""
end

function var_0_0.submitRoleData(arg_227_0)
	local var_227_0 = {
		roleId = P._id,
		roleName = string.gsub(P._name, "'", ""),
		roleLevel = P:getMaxCharacterLevel(),
		roleVipLevel = P._vip,
		roleRegTime = P._regTime,
		zoneId = var_0_0._userRegion._id,
		zoneName = string.gsub(var_0_0._userRegion._name, "'", ""),
		unionId = P._unionId or 0,
		unionName = string.gsub(P._unionName or "", "'", ""),
		ingot = P._ingot,
		gold = P._gold,
		exp = P._exp
	}
	local var_227_1 = json.encode(var_227_0)

	lc.App:submitExtendData(arg_227_0, var_227_1)
end

function var_0_0.appendGuideIdIfNeed(arg_228_0)
	local var_228_0 = GuideManager.getCurSaveGuideId()

	if var_228_0 then
		arg_228_0.Extensions[User_pb.SglUserMsg.user_set_guide_req] = var_228_0
	end
end

function var_0_0.sendProtoMsg(arg_229_0)
	if var_0_0._socket ~= nil then
		arg_229_0.dt = var_0_0.getRunningTime() * 1000

		var_0_0._socket:sendProtoMsg(arg_229_0)
	end
end

function var_0_0.sendHeartBeat()
	if var_0_0._sentHeartbeatTimestamp ~= nil and var_0_0._receivedHeartbeatTimestamp ~= nil then
		local var_230_0 = var_0_0._sentHeartbeatTimestamp - var_0_0._receivedHeartbeatTimestamp

		if var_230_0 > 60 then
			lc.log("[NETWORK] heartbeat lost", var_230_0)
			lc._runningScene:reconnect(Str(STR.HEARTBEAT_LOST))
			var_0_0.writeSocketLog(var_0_0.SocketLog.reconnect, var_230_0)

			return
		elseif var_230_0 > 30 then
			if lc._runningScene._reloadDialog == nil and lc.FrameCache:getSpriteFrame("img_icon_wifi_low") ~= nil then
				local var_230_1 = ccui.RichTextEx:create()
				local var_230_2 = cc.Sprite:createWithSpriteFrameName("img_icon_wifi_low")

				var_230_2:runAction(lc.rep(lc.sequence(0.5, cc.Show:create(), 0.5, cc.Hide:create())))
				var_230_1:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, var_230_2))
				var_230_1:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_DARK, 255, Str(STR.HEARTBEAT_GAP), ClientView.TTF_FONT, ClientView.FontSize.S1))

				var_0_0._heartbeatGapNoticeId = NoticeManager.show(var_230_1, nil, var_0_0._heartbeatGapNoticeId)
			end

			var_0_0.writeSocketLog(var_0_0.SocketLog.unstable, var_230_0)
		else
			if var_0_0._heartbeatGapNoticeId ~= nil then
				NoticeManager.hide(var_0_0._heartbeatGapNoticeId)

				var_0_0._heartbeatLostNoticeId = nil
			end

			if var_0_0._heartbeatLostNoticeId ~= nil then
				NoticeManager.hide(var_0_0._heartbeatLostNoticeId)

				var_0_0._heartbeatLostNoticeId = nil
			end

			var_0_0.writeSocketLog(var_0_0.SocketLog.recover, var_230_0)
		end
	end

	var_0_0._sentHeartbeatTimestamp = lc.Director:getCurrentTime()

	local var_230_3 = SglMsg_pb.SglReqMsg()

	var_230_3.type = SglMsgType_pb.PB_TYPE_HEART_BEAT

	var_0_0.sendProtoMsg(var_230_3)

	local var_230_4 = math.floor(var_0_0.getCurrentTime() / 3600)

	if var_0_0._hour == nil or var_0_0._hour ~= var_230_4 then
		var_0_0._hour = var_230_4

		local var_230_5 = cc.EventCustom:new(Data.Event.time_hour_changed)

		lc.Dispatcher:dispatchEvent(var_230_5)
	end

	ClientData.checkServerDate()
end

function var_0_0.checkServerDate()
	local var_231_0 = var_0_0.getServerDateTick()

	if P._loginTimeTick ~= nil and var_231_0 ~= P._loginTimeTick then
		lc._runningScene:showReloadDialog(Str(STR.NEW_DAY_BEGIN))

		return false
	end

	return true
end

function var_0_0.checkSocketLog()
	local var_232_0 = lc.readFile(lc.File:getWritablePath() .. var_0_3)

	if var_232_0 == nil or var_232_0 == "" then
		var_0_0._socketLog = var_232_0

		return
	end

	local var_232_1 = string.splitByChar(var_232_0, "\n")

	for iter_232_0, iter_232_1 in ipairs(var_232_1) do
		if iter_232_1 ~= "" then
			var_0_0.sendUserEvent({
				socketLog = iter_232_1
			})
		end
	end

	var_0_0._socketLog = nil

	lc.writeFile(lc.File:getWritablePath() .. var_0_3, "")
end

function var_0_0.writeSocketLog(arg_233_0, arg_233_1)
	if var_0_0._lastSocketLogType == arg_233_0 or var_0_0._lastSocketLogType ~= var_0_0.SocketLog.unstable and arg_233_0 == var_0_0.SocketLog.recover then
		return
	end

	var_0_0._lastSocketLogType = arg_233_0

	local var_233_0 = os.date("%c", var_0_0.getCurrentTime())
	local var_233_1 = string.format("%s %s (gap:%d)\n", var_233_0, arg_233_0, arg_233_1 or 0)

	var_0_0._socketLog = (var_0_0._socketLog or "") .. var_233_1

	lc.writeFile(lc.File:getWritablePath() .. var_0_3, var_0_0._socketLog)
end

function var_0_0.sendRegionListReq()
	local var_234_0 = lc.App:loadUserId()
	local var_234_1 = lc.App:getChannelName()
	local var_234_2 = var_234_0

	if var_234_1 == "OFFICIAL" or var_234_1 == "APPSTORE" then
		if var_234_0 == "UDID" then
			var_234_2 = nil
		end

		var_234_0 = lc.App:getUdid()
	elseif var_234_1 == "FACEBOOK" then
		if var_234_0 == "UDID" then
			var_234_2 = nil
			var_234_0 = lc.App:getUdid()
		else
			var_234_0 = ""
		end
	elseif lc.PLATFORM == cc.PLATFORM_OS_WINDOWS then
		if var_234_0 == "UDID" then
			var_234_2 = nil
		end

		var_234_0 = lc.App:getUdid()
	end

	local var_234_3 = SglMsg_pb.SglReqMsg()

	var_234_3.type = SglMsgType_pb.PB_TYPE_REGION_LIST

	local var_234_4 = var_234_3.Extensions[Region_pb.SglRegionMsg.region_list_req]

	var_234_4.uid = var_234_0

	if (var_234_1 == "OFFICIAL" or var_234_1 == "APPSTORE" or var_234_1 == "FACEBOOK") and var_234_2 ~= nil then
		var_234_4.gcid = var_234_2
	end

	local var_234_5 = lc.App:getRedirectGameServer()

	if #var_234_5 ~= 0 then
		var_234_1 = var_234_1 .. "_" .. var_234_5
	end

	var_234_4.channel = var_234_1

	lc.log("Region List UID:%s, GCID:%s", var_234_4.uid, var_234_4.gcid)
	var_0_0.sendProtoMsg(var_234_3)
end

function var_0_0.sendUserRegister()
	local var_235_0 = lc.App:loadUserId()
	local var_235_1 = var_0_0._userRegion._id
	local var_235_2 = lc.getDeviceInfo()
	local var_235_3 = var_0_0.getVersion()
	local var_235_4 = var_0_0.getBinVersion()
	local var_235_5 = lc.App:getChannelName()
	local var_235_6 = var_235_0

	if var_235_5 == "OFFICIAL" or var_235_5 == "APPSTORE" then
		if var_235_0 == "UDID" then
			var_235_6 = nil
		end

		var_235_0 = lc.App:getUdid()
	elseif var_235_5 == "FACEBOOK" then
		if var_235_0 == "UDID" then
			var_235_6 = nil
			var_235_0 = lc.App:getUdid()
		else
			var_235_0 = ""
		end
	elseif lc.PLATFORM == cc.PLATFORM_OS_WINDOWS then
		if var_235_0 == "UDID" then
			var_235_6 = nil
		end

		var_235_0 = lc.App:getUdid()
	end

	local var_235_7 = lc.App:bindAlias(var_235_5 .. var_235_0 .. var_235_1)

	if var_235_5 == "APPSTORE" then
		var_235_7 = ClientData.getAppId() .. "." .. var_235_7
	elseif var_235_5 == "FACEBOOK" then
		var_235_7 = ClientData.getAppId() .. "." .. var_235_7
	elseif var_235_5 == "ASDK" then
		local var_235_8 = ClientData.getSubChannelName()
		local var_235_9 = ClientData.getAppId()

		var_235_7 = var_235_8 .. "." .. var_235_9 .. "." .. var_235_7
	end

	lc.log("register to game server: %s with (uid: %s, rid: %d, alias: %s, device_info: %s, version: %s)", var_0_0._userRegion._ip, var_235_0, var_235_1, var_235_7, var_235_2, var_235_3)

	local var_235_10 = SglMsg_pb.SglReqMsg()

	var_235_10.type = SglMsgType_pb.PB_TYPE_USER_REGISTER

	local var_235_11 = var_235_10.Extensions[User_pb.SglUserMsg.user_reg_req]

	var_235_11.uid = var_235_0
	var_235_11.rid = var_235_1
	var_235_11.cid = var_235_7
	var_235_11.device_info = var_235_2
	var_235_11.version = var_235_3
	var_235_11.binary_version = var_235_4
	var_235_11.appid = ClientData.getAppId()

	if var_235_5 == "APPSTORE" and lc.App.getIdfa ~= nil then
		var_235_11.idfa = lc.App:getIdfa()
	end

	if (var_235_5 == "OFFICIAL" or var_235_5 == "APPSTORE" or var_235_5 == "FACEBOOK") and var_235_6 ~= nil then
		var_235_10.Extensions[User_pb.SglUserMsg.user_gcid_req] = var_235_6
	end

	var_0_0._regIds = string.format("gcid:%s, uid:%s", var_235_6, var_235_0)

	local var_235_12 = lc.App:getRedirectGameServer()

	if #var_235_12 ~= 0 then
		var_235_5 = var_235_5 .. "_" .. var_235_12
	end

	var_235_11.channel = var_235_5

	if ClientData._needSendBattleDebugLog and ClientData._battleDebugLog then
		var_235_10.Extensions[Battle_pb.SglBattleMsg.battle_log_req] = ClientData._battleDebugLog
		ClientData._needSendBattleDebugLog = false
	end

	var_0_0.sendProtoMsg(var_235_10)
end

function var_0_0.sendUserLogin(arg_236_0)
	local var_236_0 = lc.App:loadUserId()
	local var_236_1 = var_0_0._userRegion._id
	local var_236_2 = lc.getDeviceInfo()
	local var_236_3 = var_0_0.getVersion()
	local var_236_4 = var_0_0.getBinVersion()
	local var_236_5 = lc.App:getChannelName()
	local var_236_6 = lc.App:bindAlias(var_236_5 .. var_236_0 .. var_236_1)

	if var_236_5 == "APPSTORE" then
		var_236_6 = ClientData.getAppId() .. "." .. var_236_6
	elseif var_236_5 == "FACEBOOK" then
		var_236_6 = ClientData.getAppId() .. "." .. var_236_6
	elseif var_236_5 == "ASDK" then
		local var_236_7 = ClientData.getSubChannelName()
		local var_236_8 = ClientData.getAppId()

		var_236_6 = var_236_7 .. "." .. var_236_8 .. "." .. var_236_6
	end

	lc.log("login to game server: %s with (userId: %s, rid: %d, alias: %s, device_info: %s, version: %s)", var_0_0._userRegion._ip, arg_236_0, var_236_1, var_236_6, var_236_2, var_236_3)

	local var_236_9 = SglMsg_pb.SglReqMsg()

	var_236_9.type = SglMsgType_pb.PB_TYPE_USER_LOGIN

	local var_236_10 = var_236_9.Extensions[User_pb.SglUserMsg.user_login_req]

	var_236_10.user_id = arg_236_0
	var_236_10.cid = var_236_6
	var_236_10.device_info = var_236_2
	var_236_10.version = var_236_3
	var_236_10.binary_version = var_236_4
	var_236_10.code = ClientData._cfg and ClientData._cfg.loginCode or ""

	if ClientData._needSendBattleDebugLog and ClientData._battleDebugLog then
		var_236_9.Extensions[Battle_pb.SglBattleMsg.battle_log_req] = ClientData._battleDebugLog
		ClientData._needSendBattleDebugLog = false
	end

	var_0_0.sendProtoMsg(var_236_9)
end

-- Password-based login: sends username in Auth_pb.agent, password in Auth_pb.pass
function var_0_0.sendUserLoginOnline()
	local var_username = var_0_0._loginUsername or ""
	local var_password = var_0_0._loginPassword or ""
	local var_device = lc.getDeviceInfo()
	local var_version = var_0_0.getVersion()
	local var_binver = var_0_0.getBinVersion()

	lc.log("online login to game server: %s with (user: %s)", var_0_0._userRegion._ip, var_username)

	local var_msg = SglMsg_pb.SglReqMsg()
	var_msg.type = SglMsgType_pb.PB_TYPE_USER_LOGIN

	-- Set Auth_pb extensions for username/password
	var_msg.Extensions[Auth_pb.SglAuthMsg.agent] = var_username
	var_msg.Extensions[Auth_pb.SglAuthMsg.pass] = var_password

	-- Also set the user_login_req body so the server can read device_info
	local var_body = var_msg.Extensions[User_pb.SglUserMsg.user_login_req]
	var_body.user_id = 0
	var_body.cid = var_username
	var_body.device_info = var_device
	var_body.version = var_version
	var_body.binary_version = var_binver
	var_body.code = ""

	var_0_0.sendProtoMsg(var_msg)
end

-- Password-based register: sends username in Auth_pb.agent, password in Auth_pb.pass
function var_0_0.sendUserRegisterOnline()
	local var_username = var_0_0._loginUsername or ""
	local var_password = var_0_0._loginPassword or ""
	local var_device = lc.getDeviceInfo()
	local var_version = var_0_0.getVersion()
	local var_binver = var_0_0.getBinVersion()
	local var_rid = var_0_0._userRegion._id

	lc.log("online register to game server: %s with (user: %s, rid: %d)", var_0_0._userRegion._ip, var_username, var_rid)

	local var_msg = SglMsg_pb.SglReqMsg()
	var_msg.type = SglMsgType_pb.PB_TYPE_USER_REGISTER

	-- Set Auth_pb extensions for username/password
	var_msg.Extensions[Auth_pb.SglAuthMsg.agent] = var_username
	var_msg.Extensions[Auth_pb.SglAuthMsg.pass] = var_password

	-- Also set the user_reg_req body
	local var_body = var_msg.Extensions[User_pb.SglUserMsg.user_reg_req]
	var_body.channel = "online"
	var_body.rid = var_rid
	var_body.uid = var_username
	var_body.cid = var_username
	var_body.device_info = var_device
	var_body.version = var_version
	var_body.binary_version = var_binver

	var_0_0.sendProtoMsg(var_msg)
end

function var_0_0.sendUserVisit(arg_237_0)
	local var_237_0 = SglMsg_pb.SglReqMsg()

	var_237_0.type = SglMsgType_pb.PB_TYPE_USER_VISIT
	var_237_0.Extensions[User_pb.SglUserMsg.user_visit_req] = arg_237_0

	var_0_0.sendProtoMsg(var_237_0)
end

function var_0_0.sendWorldFind()
	local var_238_0 = SglMsg_pb.SglReqMsg()

	var_238_0.type = SglMsgType_pb.PB_TYPE_WORLD_FIND

	var_0_0.sendProtoMsg(var_238_0)
end

function var_0_0.sendWorldFindEx(arg_239_0, arg_239_1)
	local var_239_0 = SglMsg_pb.SglReqMsg()

	var_239_0.type = SglMsgType_pb.PB_TYPE_WORLD_FIND_EX

	local var_239_1 = var_239_0.Extensions[World_pb.SglWorldMsg.world_find_ex_req]

	var_239_1.troop_id = arg_239_0
	var_239_1.type = arg_239_1

	var_0_0.sendProtoMsg(var_239_0)
end

function var_0_0.sendWorldFindExCancel()
	local var_240_0 = SglMsg_pb.SglReqMsg()

	var_240_0.type = SglMsgType_pb.PB_TYPE_WORLD_FIND_EX_CANCEL

	var_0_0.sendProtoMsg(var_240_0)
end

function var_0_0.sendGetPvpLogs(arg_241_0)
	local var_241_0 = SglMsg_pb.SglReqMsg()

	var_241_0.type = SglMsgType_pb.PB_TYPE_BATTLE_LOG_EX
	var_241_0.Extensions[Battle_pb.SglBattleMsg.battle_log_ex_req] = arg_241_0

	var_0_0.sendProtoMsg(var_241_0)
end

function var_0_0.sendClashSync()
	local var_242_0 = SglMsg_pb.SglReqMsg()

	var_242_0.type = SglMsgType_pb.PB_TYPE_RANK_PRE

	var_0_0.sendProtoMsg(var_242_0)
end

function var_0_0.sendUnionBattleSync()
	local var_243_0 = SglMsg_pb.SglReqMsg()

	var_243_0.type = SglMsgType_pb.PB_TYPE_WORLD_MASSWAR_PRE

	var_0_0.sendProtoMsg(var_243_0)
end

function var_0_0.sendUserVisitRegion(arg_244_0)
	local var_244_0 = SglMsg_pb.SglReqMsg()

	var_244_0.type = SglMsgType_pb.PB_TYPE_USER_VISIT_EX
	var_244_0.Extensions[User_pb.SglUserMsg.user_visit_req] = arg_244_0

	var_0_0.sendProtoMsg(var_244_0)
end

function var_0_0.sendClashResetLadderLose()
	local var_245_0 = SglMsg_pb.SglReqMsg()

	var_245_0.type = SglMsgType_pb.PB_TYPE_WORLD_RESET_LADDER_LOSE

	var_0_0.sendProtoMsg(var_245_0)
end

function var_0_0.sendCreateRoom(arg_246_0)
	arg_246_0 = arg_246_0 or Data.RoomType.normal

	local var_246_0 = SglMsg_pb.SglReqMsg()

	var_246_0.type = SglMsgType_pb.PB_TYPE_WORLD_CREATE_MATCH
	var_246_0.Extensions[World_pb.SglWorldMsg.world_match_type_req] = arg_246_0

	var_0_0.sendProtoMsg(var_246_0)
end

function var_0_0.sendQueryRoom(arg_247_0)
	local var_247_0 = SglMsg_pb.SglReqMsg()

	var_247_0.type = SglMsgType_pb.PB_TYPE_WORLD_QUERY_MATCH
	var_247_0.Extensions[World_pb.SglWorldMsg.world_query_match_req] = arg_247_0

	var_0_0.sendProtoMsg(var_247_0)
end

function var_0_0.sendQuitRoom()
	local var_248_0 = SglMsg_pb.SglReqMsg()

	var_248_0.type = SglMsgType_pb.PB_TYPE_WORLD_QUIT_MATCH

	var_0_0.sendProtoMsg(var_248_0)
end

function var_0_0.sendToggleRoomMatch()
	local var_249_0 = SglMsg_pb.SglReqMsg()

	var_249_0.type = SglMsgType_pb.PB_TYPE_WORLD_TOGGLE_MATCH

	var_0_0.sendProtoMsg(var_249_0)
end

function var_0_0.sendStartRoomMatch()
	local var_250_0 = SglMsg_pb.SglReqMsg()

	var_250_0.type = SglMsgType_pb.PB_TYPE_WORLD_START_MATCH

	var_0_0.sendProtoMsg(var_250_0)
end

function var_0_0.sendClashExBuyTicket(arg_251_0)
	local var_251_0 = SglMsg_pb.SglReqMsg()

	var_251_0.type = SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_LEGEND
	var_251_0.Extensions[World_pb.SglWorldMsg.world_buy_legend_ticket_req] = arg_251_0

	var_0_0.sendProtoMsg(var_251_0)
end

function var_0_0.sendClashExQuit()
	local var_252_0 = SglMsg_pb.SglReqMsg()

	var_252_0.type = SglMsgType_pb.PB_TYPE_WORLD_QUIT_LEGEND

	var_0_0.sendProtoMsg(var_252_0)
end

function var_0_0.sendLadderBuyTicket(arg_253_0)
	local var_253_0 = SglMsg_pb.SglReqMsg()

	var_253_0.type = SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET
	var_253_0.Extensions[World_pb.SglWorldMsg.world_buy_ticket_req] = arg_253_0

	var_0_0.sendProtoMsg(var_253_0)
end

function var_0_0.sendLadderSelectCharacter(arg_254_0)
	local var_254_0 = SglMsg_pb.SglReqMsg()

	var_254_0.type = SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR
	var_254_0.Extensions[World_pb.SglWorldMsg.world_select_char_req] = arg_254_0

	var_0_0.sendProtoMsg(var_254_0)
end

function var_0_0.sendLadderSelectCard(arg_255_0)
	local var_255_0 = SglMsg_pb.SglReqMsg()

	var_255_0.type = SglMsgType_pb.PB_TYPE_WORLD_SELECT_CARD
	var_255_0.Extensions[World_pb.SglWorldMsg.world_select_card_req] = arg_255_0

	var_0_0.sendProtoMsg(var_255_0)
end

function var_0_0.sendLadderReselectCharacter()
	local var_256_0 = SglMsg_pb.SglReqMsg()

	var_256_0.type = SglMsgType_pb.PB_TYPE_WORLD_ROLL_CHAR

	var_0_0.sendProtoMsg(var_256_0)
end

function var_0_0.sendLadderQuit()
	local var_257_0 = SglMsg_pb.SglReqMsg()

	var_257_0.type = SglMsgType_pb.PB_TYPE_WORLD_QUIT

	var_0_0.sendProtoMsg(var_257_0)
end

function var_0_0.sendSurvivalBuyTicket(arg_258_0)
	local var_258_0 = SglMsg_pb.SglReqMsg()

	var_258_0.type = SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL
	var_258_0.Extensions[World_pb.SglWorldMsg.world_buy_ticket_req] = arg_258_0

	var_0_0.sendProtoMsg(var_258_0)
end

function var_0_0.sendSurvivalSelectCharacter(arg_259_0)
	local var_259_0 = SglMsg_pb.SglReqMsg()

	var_259_0.type = SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL
	var_259_0.Extensions[World_pb.SglWorldMsg.world_select_char_req] = arg_259_0

	var_0_0.sendProtoMsg(var_259_0)
end

function var_0_0.sendSurvivalSelectCard(arg_260_0)
	local var_260_0 = SglMsg_pb.SglReqMsg()

	var_260_0.type = SglMsgType_pb.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL
	var_260_0.Extensions[World_pb.SglWorldMsg.world_select_card_req] = arg_260_0

	var_0_0.sendProtoMsg(var_260_0)
end

function var_0_0.sendSurvivalQuit()
	local var_261_0 = SglMsg_pb.SglReqMsg()

	var_261_0.type = SglMsgType_pb.PB_TYPE_WORLD_QUIT_SURVIVAL

	var_0_0.sendProtoMsg(var_261_0)
end

function var_0_0.sendSurvivalExploreStart()
	local var_262_0 = SglMsg_pb.SglReqMsg()

	var_262_0.type = SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_EXPLORE_START

	local var_262_1 = var_262_0.Extensions[World_pb.SglWorldMsg.world_survival_explore_start_req]

	for iter_262_0, iter_262_1 in ipairs(P._playerFindSurvival._troopCards) do
		local var_262_2 = var_262_1.cards:add()

		var_262_2.info_id = iter_262_1._infoId
		var_262_2.num = iter_262_1._num
	end

	var_0_0.sendProtoMsg(var_262_0)
end

function var_0_0.sendSurvivalExplorerEnd()
	local var_263_0 = SglMsg_pb.SglReqMsg()

	var_263_0.type = SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_EXPLORE_END

	var_0_0.sendProtoMsg(var_263_0)
end

function var_0_0.sendSurvivalExBuyTicket(arg_264_0)
	local var_264_0 = SglMsg_pb.SglReqMsg()

	var_264_0.type = SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX
	var_264_0.Extensions[World_pb.SglWorldMsg.world_buy_ticket_req] = arg_264_0

	var_0_0.sendProtoMsg(var_264_0)
end

function var_0_0.sendSurvivalExSelectCharacter(arg_265_0)
	local var_265_0 = SglMsg_pb.SglReqMsg()

	var_265_0.type = SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX
	var_265_0.Extensions[World_pb.SglWorldMsg.world_select_char_req] = arg_265_0

	var_0_0.sendProtoMsg(var_265_0)
end

function var_0_0.sendSurvivalExSelectCard(arg_266_0)
	local var_266_0 = SglMsg_pb.SglReqMsg()

	var_266_0.type = SglMsgType_pb.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL_EX
	var_266_0.Extensions[World_pb.SglWorldMsg.world_select_card_req] = arg_266_0

	var_0_0.sendProtoMsg(var_266_0)
end

function var_0_0.sendSurvivalExQuit()
	local var_267_0 = SglMsg_pb.SglReqMsg()

	var_267_0.type = SglMsgType_pb.PB_TYPE_WORLD_QUIT_SURVIVAL_EX

	var_0_0.sendProtoMsg(var_267_0)
end

function var_0_0.sendSurvivalExExploreStart()
	local var_268_0 = SglMsg_pb.SglReqMsg()

	var_268_0.type = SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_START

	local var_268_1 = var_268_0.Extensions[World_pb.SglWorldMsg.world_survival_ex_explore_start_req]

	print("---------------------------")

	for iter_268_0, iter_268_1 in ipairs(P._playerFindSurvivalEx:getTroopCards(nil, true)) do
		local var_268_2 = var_268_1.cards:add()

		var_268_2.info_id = iter_268_1._infoId
		var_268_2.num = iter_268_1._num

		print("++++++++++++++", iter_268_1._infoId, iter_268_1._num)
	end

	var_0_0.sendProtoMsg(var_268_0)
end

function var_0_0.sendSurvivalExExplorerEnd()
	local var_269_0 = SglMsg_pb.SglReqMsg()

	var_269_0.type = SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_END

	var_0_0.sendProtoMsg(var_269_0)
end

function var_0_0.sendSurvivalExExEquipSkill(arg_270_0, arg_270_1)
	local var_270_0 = SglMsg_pb.SglReqMsg()

	var_270_0.type = SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_EX_EQUIP_SKILL

	local var_270_1 = var_270_0.Extensions[World_pb.SglWorldMsg.world_survival_ex_equip_skill_req]

	var_270_1.card = arg_270_0

	for iter_270_0, iter_270_1 in ipairs(arg_270_1) do
		var_270_1.skills:append(iter_270_1)
	end

	var_0_0.sendProtoMsg(var_270_0)
end

function var_0_0.sendSurvivalReselectCharacter()
	local var_271_0 = SglMsg_pb.SglReqMsg()

	var_271_0.type = SglMsgType_pb.PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX

	var_0_0.sendProtoMsg(var_271_0)
end

function var_0_0.sendWorldGuide(arg_272_0)
	local var_272_0 = SglMsg_pb.SglReqMsg()

	var_272_0.type = SglMsgType_pb.PB_TYPE_WORLD_GUIDE

	var_0_0.sendProtoMsg(var_272_0)
end

function var_0_0.sendWorldGuideEnd()
	local var_273_0 = SglMsg_pb.SglReqMsg()

	var_273_0.type = SglMsgType_pb.PB_TYPE_WORLD_GUIDE_END

	var_0_0.sendProtoMsg(var_273_0)
end

function var_0_0.sendLevelSweepOnce(arg_274_0)
	local var_274_0 = SglMsg_pb.SglReqMsg()

	var_274_0.type = SglMsgType_pb.PB_TYPE_WORLD_SWEEP_ONCE

	local var_274_1 = var_274_0.Extensions[World_pb.SglWorldMsg.world_sweep_req]

	var_274_1.id = arg_274_0
	var_274_1.chapter = 0

	var_0_0.sendProtoMsg(var_274_0)
end

function var_0_0.sendLevelSweep(arg_275_0)
	local var_275_0 = SglMsg_pb.SglReqMsg()

	var_275_0.type = SglMsgType_pb.PB_TYPE_WORLD_SWEEP

	local var_275_1 = var_275_0.Extensions[World_pb.SglWorldMsg.world_sweep_req]

	var_275_1.id = arg_275_0
	var_275_1.chapter = 0

	var_0_0.sendProtoMsg(var_275_0)
end

function var_0_0.sendWorldScout(arg_276_0)
	local var_276_0 = SglMsg_pb.SglReqMsg()

	var_276_0.type = SglMsgType_pb.PB_TYPE_WORLD_SCOUT
	var_276_0.Extensions[World_pb.SglWorldMsg.world_scout_req] = arg_276_0

	var_0_0.sendProtoMsg(var_276_0)
end

function var_0_0.sendWorldClearSweepCD()
	local var_277_0 = SglMsg_pb.SglReqMsg()

	var_277_0.type = SglMsgType_pb.PB_TYPE_WORLD_CLEAR_SWEEP_CD

	var_0_0.sendProtoMsg(var_277_0)
end

function var_0_0.sendWorldBuyRaidTimes(arg_278_0, arg_278_1)
	local var_278_0 = SglMsg_pb.SglReqMsg()

	var_278_0.type = SglMsgType_pb.PB_TYPE_WORLD_RESET_SWEEP_COUNT

	local var_278_1 = var_278_0.Extensions[World_pb.SglWorldMsg.world_reset_sweep_count_req]

	var_278_1.id = arg_278_0
	var_278_1.chapter = arg_278_1

	var_0_0.sendProtoMsg(var_278_0)
end

function var_0_0.sendGetExpedition()
	local var_279_0 = SglMsg_pb.SglReqMsg()

	var_279_0.type = SglMsgType_pb.PB_TYPE_WORLD_GET_EXPEDITION

	var_0_0.sendProtoMsg(var_279_0)
end

function var_0_0.sendRefreshExpedition()
	local var_280_0 = SglMsg_pb.SglReqMsg()

	var_280_0.type = SglMsgType_pb.PB_TYPE_WORLD_REFRESH_EXPEDITION

	var_0_0.sendProtoMsg(var_280_0)
end

function var_0_0.sendOpenExpedition()
	local var_281_0 = SglMsg_pb.SglReqMsg()

	var_281_0.type = SglMsgType_pb.PB_TYPE_WORLD_EXPEDITION_OPEN

	var_0_0.sendProtoMsg(var_281_0)
end

function var_0_0.sendSweepExpedition()
	local var_282_0 = SglMsg_pb.SglReqMsg()

	var_282_0.type = SglMsgType_pb.PB_TYPE_WORLD_SWEEP_EXPEDITION

	var_0_0.sendProtoMsg(var_282_0)
end

function var_0_0.sendGetExpeditionEx()
	local var_283_0 = SglMsg_pb.SglReqMsg()

	var_283_0.type = SglMsgType_pb.PB_TYPE_WORLD_GET_EXPEDITION_EX

	var_0_0.sendProtoMsg(var_283_0)
end

function var_0_0.sendWorldLottery(arg_284_0, arg_284_1)
	local var_284_0 = SglMsg_pb.SglReqMsg()

	var_284_0.type = SglMsgType_pb.PB_TYPE_WORLD_LOTTERY
	var_284_0.Extensions[World_pb.SglWorldMsg.world_lottery_user_token] = arg_284_0
	var_284_0.Extensions[World_pb.SglWorldMsg.world_lottery_count] = arg_284_1

	var_0_0.sendProtoMsg(var_284_0)
end

function var_0_0.sendWorldLotteryEx(arg_285_0)
	local var_285_0 = SglMsg_pb.SglReqMsg()

	var_285_0.type = SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_EX
	var_285_0.Extensions[World_pb.SglWorldMsg.world_lottery_ex_count] = arg_285_0

	var_0_0.sendProtoMsg(var_285_0)
end

function var_0_0.sendWorldLotteryActivity(arg_286_0, arg_286_1)
	local var_286_0 = SglMsg_pb.SglReqMsg()

	var_286_0.type = SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_ACTIVITY
	var_286_0.Extensions[World_pb.SglWorldMsg.world_lottery_user_token] = arg_286_0
	var_286_0.Extensions[World_pb.SglWorldMsg.world_lottery_count] = arg_286_1

	var_0_0.sendProtoMsg(var_286_0)
end

function var_0_0.sendWeekLottery(arg_287_0)
	local var_287_0 = SglMsg_pb.SglReqMsg()

	var_287_0.type = SglMsgType_pb.PB_TYPE_CARD_LOTTERY_TURNTABLE
	var_287_0.Extensions[Card_pb.SglCardMsg.lottery_turn_table_req] = arg_287_0

	var_0_0.sendProtoMsg(var_287_0)
end

function var_0_0.sendWorldCitySos(arg_288_0, arg_288_1, arg_288_2)
	local var_288_0 = SglMsg_pb.SglReqMsg()

	var_288_0.type = SglMsgType_pb.PB_TYPE_WORLD_SOS

	local var_288_1 = var_288_0.Extensions[World_pb.SglWorldMsg.world_sos_req]

	var_288_1.city_id = arg_288_0

	for iter_288_0, iter_288_1 in ipairs(arg_288_1) do
		if iter_288_1._isSelected then
			var_288_1.member_id:append(iter_288_1._id)
		end
	end

	var_288_1.content = arg_288_2

	var_0_0.sendProtoMsg(var_288_0)
end

function var_0_0.sendWorldCityRescue(arg_289_0, arg_289_1)
	local var_289_0 = SglMsg_pb.SglReqMsg()

	var_289_0.type = SglMsgType_pb.PB_TYPE_WORLD_RESCUE

	local var_289_1 = var_289_0.Extensions[World_pb.SglWorldMsg.world_rescue_req]

	var_289_1.troop_id = arg_289_0
	var_289_1.mail_id = arg_289_1

	var_0_0.sendProtoMsg(var_289_0)
end

function var_0_0.sendWorldGetOpponent()
	local var_290_0 = SglMsg_pb.SglReqMsg()

	var_290_0.type = SglMsgType_pb.PB_TYPE_WORLD_GET_OPPONENT

	var_0_0.sendProtoMsg(var_290_0)
end

function var_0_0.sendWorldFindNpc(arg_291_0)
	local var_291_0 = SglMsg_pb.SglReqMsg()

	var_291_0.type = SglMsgType_pb.PB_TYPE_WORLD_FIND_NPC

	if arg_291_0 then
		local var_291_1 = var_291_0.Extensions[World_pb.SglWorldMsg.world_find_ex_req]

		var_291_1.troop_id = arg_291_0
		var_291_1.type = 1
	end

	var_0_0.sendProtoMsg(var_291_0)
end

function var_0_0.sendWorldAttack(arg_292_0, arg_292_1)
	local var_292_0 = SglMsg_pb.SglReqMsg()

	var_292_0.type = SglMsgType_pb.PB_TYPE_WORLD_ATTACK

	local var_292_1 = var_292_0.Extensions[World_pb.SglWorldMsg.world_attack_req]

	var_292_1.troop_id = arg_292_0
	var_292_1.level_id = arg_292_1

	var_0_0.sendProtoMsg(var_292_0)
end

function var_0_0.sendWorldChallenge(arg_293_0, arg_293_1, arg_293_2)
	local var_293_0 = SglMsg_pb.SglReqMsg()

	var_293_0.type = SglMsgType_pb.PB_TYPE_WORLD_CHALLENGE

	local var_293_1 = var_293_0.Extensions[World_pb.SglWorldMsg.world_challenge_req]

	var_293_1.city.id = arg_293_1
	var_293_1.city.chapter = arg_293_2
	var_293_1.troop_id = arg_293_0

	var_0_0.sendProtoMsg(var_293_0)
end

function var_0_0.sendWorldExpedition(arg_294_0)
	local var_294_0 = SglMsg_pb.SglReqMsg()

	var_294_0.type = SglMsgType_pb.PB_TYPE_WORLD_EXPEDITION
	var_294_0.Extensions[World_pb.SglWorldMsg.world_expedition_req] = arg_294_0

	var_0_0.sendProtoMsg(var_294_0)
end

function var_0_0.sendWorldExpeditionEx(arg_295_0, arg_295_1, arg_295_2)
	local var_295_0 = SglMsg_pb.SglReqMsg()

	var_295_0.type = arg_295_2 and SglMsgType_pb.PB_TYPE_WORLD_EXPEDITION_EX_BOSS or SglMsgType_pb.PB_TYPE_WORLD_EXPEDITION_EX

	local var_295_1 = var_295_0.Extensions[World_pb.SglWorldMsg.world_expedition_ex_req]

	var_295_1.troop_id = arg_295_0
	var_295_1.npc_id = arg_295_1

	var_0_0.sendProtoMsg(var_295_0)
end

function var_0_0.sendWorldJoin(arg_296_0)
	local var_296_0 = SglMsg_pb.SglReqMsg()

	var_296_0.type = SglMsgType_pb.PB_TYPE_WORLD_BATTLE_JOIN
	var_296_0.Extensions[World_pb.SglWorldMsg.world_battle_join_req] = arg_296_0

	var_0_0.sendProtoMsg(var_296_0)
end

function var_0_0.sendWorldRescueJoin(arg_297_0)
	local var_297_0 = SglMsg_pb.SglReqMsg()

	var_297_0.type = SglMsgType_pb.PB_TYPE_WORLD_RESCUE_JOIN
	var_297_0.Extensions[World_pb.SglWorldMsg.world_rescue_join_req] = arg_297_0

	var_0_0.sendProtoMsg(var_297_0)
end

function var_0_0.sendChallengeElite(arg_298_0, arg_298_1)
	local var_298_0 = SglMsg_pb.SglReqMsg()

	var_298_0.type = SglMsgType_pb.PB_TYPE_WORLD_CHALLENGE_ELITE

	local var_298_1 = var_298_0.Extensions[World_pb.SglWorldMsg.world_challenge_elite_req]

	var_298_1.troop_id = arg_298_0
	var_298_1.copy_id = arg_298_1

	var_0_0.sendProtoMsg(var_298_0)
end

function var_0_0.sendChallengeGold(arg_299_0, arg_299_1, arg_299_2)
	local var_299_0 = SglMsg_pb.SglReqMsg()

	var_299_0.type = SglMsgType_pb.PB_TYPE_WORLD_ROB_GOLD

	local var_299_1 = var_299_0.Extensions[World_pb.SglWorldMsg.world_rob_gold_req]

	var_299_1.troop_id = arg_299_0
	var_299_1.copy_id = arg_299_1
	var_299_1.prop_id = arg_299_2

	var_0_0.sendProtoMsg(var_299_0)
end

function var_0_0.sendChallengeCommander(arg_300_0, arg_300_1)
	local var_300_0 = SglMsg_pb.SglReqMsg()

	var_300_0.type = SglMsgType_pb.PB_TYPE_WORLD_CHALLENGE_COMMANDER

	local var_300_1 = var_300_0.Extensions[World_pb.SglWorldMsg.world_challenge_commander_req]

	var_300_1.troop_id = arg_300_0
	var_300_1.copy_id = arg_300_1

	var_0_0.sendProtoMsg(var_300_0)
end

function var_0_0.sendCopySweep(arg_301_0, arg_301_1, arg_301_2)
	local var_301_0 = SglMsg_pb.SglReqMsg()

	if arg_301_1 == 1 then
		var_301_0.type = SglMsgType_pb.PB_TYPE_WORLD_SWEEP_COPY_ONCE
	else
		var_301_0.type = SglMsgType_pb.PB_TYPE_WORLD_SWEEP_COPY
	end

	local var_301_1 = var_301_0.Extensions[World_pb.SglWorldMsg.world_sweep_copy_req]

	var_301_1.copy_id = arg_301_0
	var_301_1.prop_id = arg_301_2

	var_0_0.sendProtoMsg(var_301_0)
end

function var_0_0.sendCopyPvpUnlock()
	local var_302_0 = SglMsg_pb.SglReqMsg()

	var_302_0.type = SglMsgType_pb.PB_TYPE_WORLD_FIND_RESET

	var_0_0.sendProtoMsg(var_302_0)
end

function var_0_0.sendWorldFindStart(arg_303_0, arg_303_1)
	local var_303_0 = SglMsg_pb.SglReqMsg()

	var_303_0.type = SglMsgType_pb.PB_TYPE_WORLD_FIND_START

	local var_303_1 = var_303_0.Extensions[World_pb.SglWorldMsg.world_find_start_req]

	var_303_1.troop_id = arg_303_0
	var_303_1.choice = arg_303_1

	var_0_0.sendProtoMsg(var_303_0)
end

function var_0_0.sendBattleReplay(arg_304_0, arg_304_1)
	local var_304_0 = SglMsg_pb.SglReqMsg()

	var_304_0.type = arg_304_1 and SglMsgType_pb.PB_TYPE_BATTLE_REPLAY or SglMsgType_pb.PB_TYPE_BATTLE_REPLAY_EX
	var_304_0.Extensions[Battle_pb.SglBattleMsg.battle_replay_req] = arg_304_0

	var_0_0.sendProtoMsg(var_304_0)
end

function var_0_0.sendBattleShareReplay(arg_305_0)
	local var_305_0 = SglMsg_pb.SglReqMsg()

	var_305_0.type = SglMsgType_pb.PB_TYPE_BATTLE_REPLAY_SHARE
	var_305_0.Extensions[Battle_pb.SglBattleMsg.battle_replay_share_req] = arg_305_0

	var_0_0.sendProtoMsg(var_305_0)
end

function var_0_0.sendTutorialReplay(arg_306_0)
	local var_306_0 = SglMsg_pb.SglReqMsg()

	var_306_0.type = SglMsgType_pb.PB_TYPE_BATTLE_REPLAY_TUTORIAL
	var_306_0.Extensions[Battle_pb.SglBattleMsg.battle_replay_tutorial_req] = arg_306_0

	var_0_0.sendProtoMsg(var_306_0)
end

function var_0_0.sendBattleStart(arg_307_0)
	local var_307_0 = SglMsg_pb.SglReqMsg()

	var_307_0.type = SglMsgType_pb.PB_TYPE_BATTLE_START
	var_307_0.Extensions[Battle_pb.SglBattleMsg.battle_start_req].troop_id = arg_307_0

	var_0_0.sendProtoMsg(var_307_0)
end

function var_0_0.sendBattleEnd(arg_308_0, arg_308_1)
	local var_308_0 = SglMsg_pb.SglReqMsg()

	var_308_0.type = SglMsgType_pb.PB_TYPE_BATTLE_SKIP

	if arg_308_0 then
		var_308_0.Extensions[User_pb.SglUserMsg.user_set_guide_req] = P._guideID
	end

	-- In a relayed PvP match the server runs no duel of its own, so this is the
	-- only place it can learn who won. Both clients report, and their two claims
	-- have to complement each other or neither is believed - which is why the
	-- result is sent even when this side lost.
	if arg_308_1 ~= nil then
		var_308_0.Extensions[Battle_pb.SglBattleMsg.battle_end_req] = arg_308_1
	end

	var_0_0.sendProtoMsg(var_308_0)
end

function var_0_0.sendBattleSkip()
	local var_309_0 = SglMsg_pb.SglReqMsg()

	var_309_0.type = SglMsgType_pb.PB_TYPE_BATTLE_SKIP

	var_0_0.sendProtoMsg(var_309_0)
end

function var_0_0.sendBattleSync(arg_310_0)
	local var_310_0 = SglMsg_pb.SglReqMsg()

	var_310_0.type = SglMsgType_pb.PB_TYPE_BATTLE_SYNC

	var_0_0.sendProtoMsg(var_310_0)
end

function var_0_0.sendBattleUseCard(arg_311_0, arg_311_1, arg_311_2, arg_311_3, arg_311_4)
	local var_311_0 = math.floor(var_0_0.getCurrentTime())
	local var_311_1 = SglMsg_pb.SglReqMsg()

	var_311_1.type = SglMsgType_pb.PB_TYPE_BATTLE_USECARD

	local var_311_2 = var_311_1.Extensions[Battle_pb.SglBattleMsg.battle_usecard_req]

	arg_311_1 = B.extendId(arg_311_0, arg_311_1)

	if arg_311_4 ~= nil then
		arg_311_2 = arg_311_2 + B.tableCount(arg_311_4) * 10000
	end

	var_311_2:append(arg_311_1)
	var_311_2:append(arg_311_2)
	var_311_2:append(arg_311_3)
	var_311_2:append(var_311_0)

	if arg_311_4 ~= nil then
		for iter_311_0, iter_311_1 in pairs(arg_311_4) do
			var_311_2:append(iter_311_0)
			var_311_2:append(#iter_311_1)

			for iter_311_2 = 1, #iter_311_1 do
				var_311_2:append(iter_311_1[iter_311_2])
			end
		end
	end

	print("++++++++++++++++++++sendBattleUseCard", arg_311_0._name, arg_311_1, arg_311_2, arg_311_3, arg_311_4)
	var_0_0.sendProtoMsg(var_311_1)

	if arg_311_0._isOnlinePvp and arg_311_0._playerType ~= BattleData.PlayerType.observe and arg_311_1 ~= BattleData.UseCardId.round then
		table.insert(arg_311_0._ops, {
			_card = arg_311_1,
			_target = arg_311_2,
			_timestamp = var_311_0
		})

		arg_311_0._replayIndex = arg_311_0._replayIndex + 1
	end
end

function var_0_0.sendBattleOppoUseCard(arg_312_0, arg_312_1, arg_312_2, arg_312_3, arg_312_4)
	local var_312_0 = SglMsg_pb.SglReqMsg()

	var_312_0.type = SglMsgType_pb.PB_TYPE_BATTLE_OP_USECARD

	local var_312_1 = var_312_0.Extensions[Battle_pb.SglBattleMsg.battle_op_usecard_req]

	arg_312_1 = B.extendId(arg_312_0, arg_312_1)

	if arg_312_4 ~= nil then
		arg_312_2 = arg_312_2 + B.tableCount(arg_312_4) * 10000
	end

	print("++++++++++++++++++++sendBattleOppoUseCard", arg_312_0._name, arg_312_1, arg_312_2, arg_312_3, arg_312_4)
	var_312_1:append(arg_312_1)
	var_312_1:append(arg_312_2)
	var_312_1:append(arg_312_3)
	var_312_1:append(-math.floor(var_0_0.getCurrentTime()))

	if arg_312_4 ~= nil then
		for iter_312_0, iter_312_1 in pairs(arg_312_4) do
			var_312_1:append(iter_312_0)
			var_312_1:append(#iter_312_1)

			for iter_312_2 = 1, #iter_312_1 do
				var_312_1:append(iter_312_1[iter_312_2])
			end
		end
	end

	var_0_0.sendProtoMsg(var_312_0)
end

function var_0_0.sendBattleRetry()
	local var_313_0 = SglMsg_pb.SglReqMsg()

	var_313_0.type = SglMsgType_pb.PB_TYPE_BATTLE_RETRY

	var_0_0.sendProtoMsg(var_313_0)
end

function var_0_0.sendBattleChat(arg_314_0)
	local var_314_0 = SglMsg_pb.SglReqMsg()

	var_314_0.type = SglMsgType_pb.PB_TYPE_BATTLE_CHAT
	var_314_0.Extensions[Battle_pb.SglBattleMsg.battle_chat_req] = arg_314_0

	var_0_0.sendProtoMsg(var_314_0)
end

function var_0_0.sendBattleLogGet()
	local var_315_0 = SglMsg_pb.SglReqMsg()

	var_315_0.type = SglMsgType_pb.PB_TYPE_BATTLE_LOG

	var_0_0.sendProtoMsg(var_315_0)
end

function var_0_0.sendBattleShare(arg_316_0, arg_316_1)
	local var_316_0 = SglMsg_pb.SglReqMsg()

	var_316_0.type = SglMsgType_pb.PB_TYPE_BATTLE_SHARE

	local var_316_1 = var_316_0.Extensions[Battle_pb.SglBattleMsg.battle_share_req]

	var_316_1.log_id = arg_316_0
	var_316_1.text = arg_316_1

	var_0_0.sendProtoMsg(var_316_0)
end

function var_0_0.sendBattleAgain()
	local var_317_0 = SglMsg_pb.SglReqMsg()

	var_317_0.type = SglMsgType_pb.PB_TYPE_BATTLE_AGAIN
	var_317_0.Extensions[Battle_pb.SglBattleMsg.battle_again_req] = P._curTroopIndex

	var_0_0.sendProtoMsg(var_317_0)
end

function var_0_0.sendTroopReload(arg_318_0, arg_318_1)
	local var_318_0 = SglMsg_pb.SglReqMsg()

	var_318_0.type = SglMsgType_pb.PB_TYPE_TROOP_RELOAD

	for iter_318_0 = 1, #arg_318_0 do
		local var_318_1 = var_318_0.Extensions[Troop_pb.SglTroopMsg.troop_reload_req]:add()

		var_318_1.troop_id = arg_318_0[iter_318_0]._troopIndex
		var_318_1.is_check = arg_318_0[iter_318_0]._isCheck

		for iter_318_1 = 1, #arg_318_0[iter_318_0]._cards do
			local var_318_2 = var_318_1.troop_info:add()

			var_318_2.info_id = arg_318_0[iter_318_0]._cards[iter_318_1]._infoId
			var_318_2.num = arg_318_0[iter_318_0]._cards[iter_318_1]._num
		end
	end

	if arg_318_1 then
		var_0_0.appendGuideIdIfNeed(var_318_0)
	end

	var_0_0.sendProtoMsg(var_318_0)
end

function var_0_0.sendTroops(arg_319_0, arg_319_1)
	if ClientData._cloneTroops == nil then
		return
	end

	local var_319_0 = {}
	local var_319_1 = {}
	local var_319_2 = {}

	for iter_319_0, iter_319_1 in pairs(ClientData._cloneTroops) do
		if iter_319_1._isDirty then
			iter_319_1._isDirty = false

			table.insert(var_319_1, iter_319_1)
			table.insert(var_319_2, iter_319_0)
		end
	end

	for iter_319_2 = 1, #var_319_1 do
		local var_319_3 = {
			_troopIndex = var_319_2[iter_319_2],
			_cards = {},
			_isCheck = P._guideID > 172 and lc.App:getChannelName() ~= "OFFICIAL" and var_319_2[iter_319_2] == arg_319_1 and not Data.isDarkTroop(arg_319_1) and not Data.isRoomDarkTroop(arg_319_1)
		}

		for iter_319_3 = 1, #var_319_1[iter_319_2] do
			table.insert(var_319_3._cards, {
				_infoId = var_319_1[iter_319_2][iter_319_3]._infoId,
				_num = var_319_1[iter_319_2][iter_319_3]._num
			})
		end

		table.insert(var_319_0, var_319_3)
	end

	if #var_319_0 > 0 then
		ClientData.sendTroopReload(var_319_0, arg_319_0)
	end
end

function var_0_0.sendDefTroopIndex(arg_320_0)
	local var_320_0 = SglMsg_pb.SglReqMsg()

	var_320_0.type = SglMsgType_pb.PB_TYPE_USER_SET_DEF_TROOP
	var_320_0.Extensions[User_pb.SglUserMsg.user_set_troop_req] = arg_320_0

	var_0_0.sendProtoMsg(var_320_0)
end

function var_0_0.sendCurToopIndex()
	local var_321_0 = SglMsg_pb.SglReqMsg()

	var_321_0.type = SglMsgType_pb.PB_TYPE_USER_SET_CUR_TROOP
	var_321_0.Extensions[User_pb.SglUserMsg.user_set_troop_req] = P._curTroopIndex

	var_0_0.sendProtoMsg(var_321_0)
end

function var_0_0.sendTroopRemark(arg_322_0, arg_322_1)
	local var_322_0 = SglMsg_pb.SglReqMsg()

	var_322_0.type = SglMsgType_pb.PB_TYPE_TROOP_MARK

	local var_322_1 = var_322_0.Extensions[Troop_pb.SglTroopMsg.troop_mark_req]

	var_322_1.troop_id = arg_322_0
	var_322_1.name = arg_322_1

	var_0_0.sendProtoMsg(var_322_0)
end

function var_0_0.sendCardCollect(arg_323_0)
	local var_323_0 = SglMsg_pb.SglReqMsg()

	var_323_0.type = SglMsgType_pb.PB_TYPE_CARD_COLLECT

	var_323_0.Extensions[Card_pb.SglCardMsg.card_collect_req]:append(arg_323_0)
	var_0_0.sendProtoMsg(var_323_0)
end

function var_0_0.sendCardUnlockConfirmed(arg_324_0)
	local var_324_0 = SglMsg_pb.SglReqMsg()

	var_324_0.type = SglMsgType_pb.PB_TYPE_CARD_UNLOCK
	var_324_0.Extensions[Card_pb.SglCardMsg.card_unlock_req] = arg_324_0

	var_0_0.sendProtoMsg(var_324_0)
end

function var_0_0.sendCardUpgrade(arg_325_0, arg_325_1, arg_325_2, arg_325_3)
	local var_325_0 = SglMsg_pb.SglReqMsg()

	var_325_0.type = SglMsgType_pb.PB_TYPE_CARD_UPGRADE

	local var_325_1 = var_325_0.Extensions[Card_pb.SglCardMsg.card_upgrade_req]

	var_325_1.id = arg_325_0
	var_325_1.info_id = arg_325_1

	if arg_325_2 ~= nil then
		for iter_325_0 = 1, #arg_325_2 do
			var_325_1.swallow_id:append(arg_325_2[iter_325_0])
		end
	end

	if arg_325_3 ~= nil then
		var_325_1.swallow_exp = arg_325_3
	end

	var_0_0.appendGuideIdIfNeed(var_325_0)
	var_0_0.sendProtoMsg(var_325_0)
end

function var_0_0.sendCardEvolution(arg_326_0, arg_326_1, arg_326_2)
	local var_326_0 = SglMsg_pb.SglReqMsg()

	var_326_0.type = SglMsgType_pb.PB_TYPE_CARD_EVOLUTION

	local var_326_1 = var_326_0.Extensions[Card_pb.SglCardMsg.card_evolution_req]

	var_326_1.id = arg_326_0
	var_326_1.info_id = arg_326_1

	if arg_326_2 ~= nil then
		for iter_326_0 = 1, #arg_326_2 do
			var_326_1.swallow_id:append(arg_326_2[iter_326_0])
		end
	end

	var_0_0.appendGuideIdIfNeed(var_326_0)
	var_0_0.sendProtoMsg(var_326_0)
end

function var_0_0.sendCardUpgrade(arg_327_0)
	local var_327_0 = SglMsg_pb.SglReqMsg()

	var_327_0.type = SglMsgType_pb.PB_TYPE_CARD_UPGRADE
	var_327_0.Extensions[Card_pb.SglCardMsg.card_upgrade_req] = arg_327_0

	var_0_0.sendProtoMsg(var_327_0)
end

function var_0_0.sendCardSetSkill(arg_328_0, arg_328_1, arg_328_2)
	local var_328_0 = SglMsg_pb.SglReqMsg()

	var_328_0.type = SglMsgType_pb.PB_TYPE_CARD_SKILL_SET

	local var_328_1 = var_328_0.Extensions[Card_pb.SglCardMsg.card_skill_set_req]

	var_328_1.id = arg_328_0
	var_328_1.info_id = arg_328_1
	var_328_1.is_keep = not arg_328_2

	var_0_0.sendProtoMsg(var_328_0)
end

function var_0_0.sendCardCompose(arg_329_0, arg_329_1, arg_329_2)
	local var_329_0 = SglMsg_pb.SglReqMsg()

	var_329_0.type = SglMsgType_pb.PB_TYPE_CARD_COMPOSE
	var_329_0.Extensions[Card_pb.SglCardMsg.card_compose_package_id] = tonumber(arg_329_0)

	local var_329_1 = var_329_0.Extensions[Card_pb.SglCardMsg.card_compose_req]
	local var_329_2 = var_329_1:add()

	var_329_2.info_id = arg_329_1
	var_329_2.num = 1

	for iter_329_0, iter_329_1 in pairs(arg_329_2) do
		local var_329_3 = var_329_1:add()

		var_329_3.info_id = iter_329_0
		var_329_3.num = iter_329_1
	end

	var_0_0.sendProtoMsg(var_329_0)
end

function var_0_0.sendCardDecompose(arg_330_0, arg_330_1)
	local var_330_0 = SglMsg_pb.SglReqMsg()

	var_330_0.type = SglMsgType_pb.PB_TYPE_CARD_DECOMPOSE

	local var_330_1 = var_330_0.Extensions[Card_pb.SglCardMsg.card_decompose_req]

	var_330_1.info_id = arg_330_0
	var_330_1.num = arg_330_1

	var_0_0.sendProtoMsg(var_330_0)
end

function var_0_0.sendCardRecovery(arg_331_0, arg_331_1)
	local var_331_0 = SglMsg_pb.SglReqMsg()

	var_331_0.type = SglMsgType_pb.PB_TYPE_CARD_RECOVERY

	local var_331_1 = var_331_0.Extensions[Card_pb.SglCardMsg.card_recovery_req]

	var_331_1.info_id = arg_331_0
	var_331_1.num = arg_331_1

	var_0_0.sendProtoMsg(var_331_0)
end

function var_0_0.sendCardSmelt(arg_332_0, arg_332_1)
	local var_332_0 = SglMsg_pb.SglReqMsg()

	var_332_0.type = SglMsgType_pb.PB_TYPE_CARD_SMELT

	local var_332_1 = var_332_0.Extensions[Card_pb.SglCardMsg.card_decompose_req]

	var_332_1.info_id = arg_332_0
	var_332_1.num = arg_332_1

	var_0_0.sendProtoMsg(var_332_0)
end

function var_0_0.sendCardDecomposeBatch()
	local var_333_0 = SglMsg_pb.SglReqMsg()

	var_333_0.type = SglMsgType_pb.PB_TYPE_CARD_DECOMPOSE_BATCH

	var_0_0.sendProtoMsg(var_333_0)
end

function var_0_0.sendCardSell(arg_334_0, arg_334_1)
	local var_334_0 = SglMsg_pb.SglReqMsg()

	var_334_0.type = SglMsgType_pb.PB_TYPE_CARD_SELL

	local var_334_1 = var_334_0.Extensions[Card_pb.SglCardMsg.card_sell_req]

	var_334_1.info_id = arg_334_0

	for iter_334_0 = 1, #arg_334_1 do
		var_334_1.id:append(arg_334_1[iter_334_0])
	end

	var_0_0.sendProtoMsg(var_334_0)
end

function var_0_0.sendCardTransfer(arg_335_0)
	local var_335_0 = SglMsg_pb.SglReqMsg()

	var_335_0.type = SglMsgType_pb.PB_TYPE_CARD_TRANSFER

	local var_335_1 = var_335_0.Extensions[Card_pb.SglCardMsg.card_transfer_req]

	for iter_335_0, iter_335_1 in pairs(arg_335_0) do
		local var_335_2 = var_335_1:add()

		var_335_2.info_id = iter_335_0
		var_335_2.num = iter_335_1
	end

	var_0_0.sendProtoMsg(var_335_0)
end

function var_0_0.sendCardLottery(arg_336_0, arg_336_1, arg_336_2)
	local var_336_0 = SglMsg_pb.SglReqMsg()

	var_336_0.type = SglMsgType_pb.PB_TYPE_CARD_LOTTERY

	local var_336_1 = var_336_0.Extensions[Card_pb.SglCardMsg.card_lottery_req]

	var_336_1.pkg_id = arg_336_0
	var_336_1.is_free = arg_336_1
	var_336_0.Extensions[Card_pb.SglCardMsg.card_lottery_use_token] = arg_336_2

	var_0_0.appendGuideIdIfNeed(var_336_0)
	var_0_0.sendProtoMsg(var_336_0)
end

function var_0_0.sendCardLotteryRecord(arg_337_0)
	local var_337_0 = SglMsg_pb.SglReqMsg()

	var_337_0.type = SglMsgType_pb.PB_TYPE_CARD_LOTTERY_RECORD
	var_337_0.Extensions[Card_pb.SglCardMsg.card_lottery_record_req] = arg_337_0

	var_0_0.sendProtoMsg(var_337_0)
end

function var_0_0.sendCardBoxInfo(arg_338_0)
	local var_338_0 = SglMsg_pb.SglReqMsg()

	var_338_0.type = SglMsgType_pb.PB_TYPE_CARDBOX_INFO
	var_338_0.Extensions[Card_pb.SglCardMsg.card_box_info_req] = arg_338_0

	var_0_0.sendProtoMsg(var_338_0)
end

function var_0_0.sendCardBoxReset(arg_339_0)
	local var_339_0 = SglMsg_pb.SglReqMsg()

	var_339_0.type = SglMsgType_pb.PB_TYPE_RESET_CARDBOX
	var_339_0.Extensions[Card_pb.SglCardMsg.reset_card_box_req] = arg_339_0

	var_0_0.sendProtoMsg(var_339_0)
end

function var_0_0.sendBookLottery(arg_340_0)
	local var_340_0 = SglMsg_pb.SglReqMsg()

	var_340_0.type = SglMsgType_pb.PB_TYPE_CARD_LOTTERY_BOOK

	-- card_lottery_req is a composite protobuf extension.  The native Lua
	-- binding accepted assigning a scalar here, but H5 correctly rejects it;
	-- the server reads the requested pull count from pkg_id.
	local var_340_1 = var_340_0.Extensions[Card_pb.SglCardMsg.card_lottery_req]
	var_340_1.pkg_id = arg_340_0
	var_340_1.is_free = false

	var_0_0.sendProtoMsg(var_340_0)
end

function var_0_0.sendBookLotteryTen()
	local var_341_0 = SglMsg_pb.SglReqMsg()

	var_341_0.type = SglMsgType_pb.PB_TYPE_CARD_LOTTERY_TEN_BOOK

	var_0_0.sendProtoMsg(var_341_0)
end

function var_0_0.sendBookLotteryOrange()
	local var_342_0 = SglMsg_pb.SglReqMsg()

	var_342_0.type = SglMsgType_pb.PB_TYPE_CARD_LOTTERY_BOOK_JUMP

	var_0_0.sendProtoMsg(var_342_0)
end

function var_0_0.sendCardEquip(arg_343_0, arg_343_1, arg_343_2)
	local var_343_0 = SglMsg_pb.SglReqMsg()

	var_343_0.type = SglMsgType_pb.PB_TYPE_CARD_EQUIP

	local var_343_1 = var_343_0.Extensions[Card_pb.SglCardMsg.card_equip_req]

	var_343_1.hero_id = arg_343_0
	var_343_1.equip_id = arg_343_1
	var_343_1.is_equip = arg_343_2

	var_0_0.appendGuideIdIfNeed(var_343_0)
	var_0_0.sendProtoMsg(var_343_0)
end

function var_0_0.sendGuard(arg_344_0, arg_344_1, arg_344_2)
	local var_344_0 = SglMsg_pb.SglReqMsg()

	var_344_0.type = SglMsgType_pb.PB_TYPE_CITY_GUARD

	local var_344_1 = var_344_0.Extensions[City_pb.SglCityMsg.city_guard_req]

	var_344_1.slot_id = arg_344_0
	var_344_1.info_id = arg_344_1
	var_344_1.is_guard = arg_344_2

	var_0_0.sendProtoMsg(var_344_0)
end

function var_0_0.sendGuardCollect(arg_345_0)
	local var_345_0 = SglMsg_pb.SglReqMsg()

	var_345_0.type = SglMsgType_pb.PB_TYPE_CITY_PICK
	var_345_0.Extensions[City_pb.SglCityMsg.city_pick_req] = arg_345_0

	var_0_0.sendProtoMsg(var_345_0)
end

function var_0_0.sendCardExtend(arg_346_0)
	local var_346_0 = SglMsg_pb.SglReqMsg()

	if arg_346_0 == Data.CardType.monster then
		var_346_0.type = SglMsgType_pb.PB_TYPE_CARD_EXPAND_HERO
	elseif arg_346_0 == Data.CardType.weapon or arg_346_0 == Data.CardType.armor then
		var_346_0.type = SglMsgType_pb.PB_TYPE_CARD_EXPAND_EQUIP
	elseif arg_346_0 == Data.CardType.book then
		var_346_0.type = SglMsgType_pb.PB_TYPE_CARD_EXPAND_BOOK
	elseif arg_346_0 == Data.CardType.horse then
		var_346_0.type = SglMsgType_pb.PB_TYPE_CARD_EXPAND_HORSE
	end

	var_0_0.sendProtoMsg(var_346_0)
end

function var_0_0.sendCardRelive(arg_347_0, arg_347_1)
	local var_347_0 = SglMsg_pb.SglReqMsg()

	var_347_0.type = SglMsgType_pb.PB_TYPE_CARD_RECOVER

	local var_347_1 = var_347_0.Extensions[Card_pb.SglCardMsg.card_recover_req]

	var_347_1.id = arg_347_0
	var_347_1.info_id = arg_347_1

	var_0_0.sendProtoMsg(var_347_0)
end

function var_0_0.sendSetSkin(arg_348_0, arg_348_1)
	arg_348_0 = arg_348_0 and Data.removeAdditional(arg_348_0)

	local var_348_0 = SglMsg_pb.SglReqMsg()

	var_348_0.type = SglMsgType_pb.PB_TYPE_USER_SET_SKIN

	local var_348_1 = var_348_0.Extensions[User_pb.SglUserMsg.user_set_skin_req]

	var_348_1.info_id = arg_348_0
	var_348_1.skin_id = arg_348_1

	var_0_0.sendProtoMsg(var_348_0)
end

function var_0_0.sendBuySkin(arg_349_0, arg_349_1)
	local var_349_0 = SglMsg_pb.SglReqMsg()

	var_349_0.type = SglMsgType_pb.PB_TYPE_SHOP_SKIN
	var_349_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_349_0
	var_349_0.Extensions[Shop_pb.SglShopMsg.shop_buy_type_req] = arg_349_1

	var_0_0.sendProtoMsg(var_349_0)
end

function var_0_0.sendBuyEffect(arg_350_0, arg_350_1, arg_350_2)
	local var_350_0 = SglMsg_pb.SglReqMsg()

	var_350_0.type = SglMsgType_pb.PB_TYPE_SHOP_SKIN
	var_350_0.Extensions[Shop_pb.SglShopMsg.shop_buy_effect_card_req] = arg_350_0
	var_350_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_350_1
	var_350_0.Extensions[Shop_pb.SglShopMsg.shop_buy_type_req] = 0

	var_0_0.sendProtoMsg(var_350_0)
end

function var_0_0.sendConfirmPalaceTask(arg_351_0, arg_351_1)
	local var_351_0 = SglMsg_pb.SglReqMsg()

	var_351_0.type = SglMsgType_pb.PB_TYPE_CITY_PROCEDURE_ASSIGN

	local var_351_1 = var_351_0.Extensions[City_pb.SglCityMsg.city_procedure_assign_req]

	var_351_1.id = arg_351_0

	for iter_351_0 = 1, #arg_351_1 do
		var_351_1.hero_id:append(arg_351_1[iter_351_0])
	end

	var_0_0.appendGuideIdIfNeed(var_351_0)
	var_0_0.sendProtoMsg(var_351_0)
end

function var_0_0.sendClaimPalaceTask(arg_352_0)
	local var_352_0 = SglMsg_pb.SglReqMsg()

	var_352_0.type = SglMsgType_pb.PB_TYPE_CITY_PROCEDURE_FINISH
	var_352_0.Extensions[City_pb.SglCityMsg.city_procedure_finish_req] = arg_352_0

	var_0_0.sendProtoMsg(var_352_0)
end

function var_0_0.sendRemovePalaceTask(arg_353_0)
	local var_353_0 = SglMsg_pb.SglReqMsg()

	var_353_0.type = SglMsgType_pb.PB_TYPE_CITY_PROCEDURE_REMOVE
	var_353_0.Extensions[City_pb.SglCityMsg.city_procedure_remove_req] = arg_353_0

	var_0_0.sendProtoMsg(var_353_0)
end

function var_0_0.sendCancelPalaceTask(arg_354_0)
	local var_354_0 = SglMsg_pb.SglReqMsg()

	var_354_0.type = SglMsgType_pb.PB_TYPE_CITY_PROCEDURE_CANCEL
	var_354_0.Extensions[City_pb.SglCityMsg.city_procedure_cancel_req] = arg_354_0

	var_0_0.sendProtoMsg(var_354_0)
end

function var_0_0.sendConfirmPalaceVisit(arg_355_0)
	local var_355_0 = SglMsg_pb.SglReqMsg()

	var_355_0.type = SglMsgType_pb.PB_TYPE_CITY_VISIT_RECRUIT
	var_355_0.Extensions[City_pb.SglCityMsg.city_visit_recruit_req] = arg_355_0

	var_0_0.sendProtoMsg(var_355_0)
end

function var_0_0.sendRemovePalaceVisit(arg_356_0)
	local var_356_0 = SglMsg_pb.SglReqMsg()

	var_356_0.type = SglMsgType_pb.PB_TYPE_CITY_VISIT_REMOVE
	var_356_0.Extensions[City_pb.SglCityMsg.city_visit_remove_req] = arg_356_0

	var_0_0.sendProtoMsg(var_356_0)
end

function var_0_0.sendStayPalaceVisit(arg_357_0)
	local var_357_0 = SglMsg_pb.SglReqMsg()

	var_357_0.type = SglMsgType_pb.PB_TYPE_CITY_VISIT_STAY
	var_357_0.Extensions[City_pb.SglCityMsg.city_visit_stay_req] = arg_357_0

	var_0_0.sendProtoMsg(var_357_0)
end

function var_0_0.sendRecruitPalaceVisit(arg_358_0)
	local var_358_0 = SglMsg_pb.SglReqMsg()

	var_358_0.type = SglMsgType_pb.PB_TYPE_CITY_VISIT_RECRUIT_EX
	var_358_0.Extensions[City_pb.SglCityMsg.city_visit_recruit_req] = arg_358_0

	var_0_0.sendProtoMsg(var_358_0)
end

function var_0_0.sendProductsGet()
	local var_359_0 = SglMsg_pb.SglReqMsg()

	var_359_0.type = SglMsgType_pb.PB_TYPE_SHOP_LIST

	var_0_0.sendProtoMsg(var_359_0)
end

function var_0_0.sendProductsRefresh(arg_360_0, arg_360_1)
	local var_360_0 = SglMsg_pb.SglReqMsg()
	local var_360_1 = arg_360_1 == Data.ResType.ingot

	if arg_360_0 == Data.MarketBuyType.random then
		if var_360_1 then
			var_360_0.type = SglMsgType_pb.PB_TYPE_SHOP_REFRESH
		else
			var_360_0.type = SglMsgType_pb.PB_TYPE_SHOP_REFRESH_EX
		end
	elseif arg_360_0 == Data.MarketBuyType.flag then
		if var_360_1 then
			var_360_0.type = SglMsgType_pb.PB_TYPE_SHOP_REFRESH_PVP
		else
			var_360_0.type = SglMsgType_pb.PB_TYPE_SHOP_REFRESH_PVP_EX
		end
	elseif arg_360_0 == Data.MarketBuyType.union then
		if var_360_1 then
			var_360_0.type = SglMsgType_pb.PB_TYPE_UNION_REFRESH
		else
			var_360_0.type = SglMsgType_pb.PB_TYPE_UNION_REFRESH_EX
		end
	elseif arg_360_0 == Data.MarketBuyType.dragon_flag then
		if var_360_1 then
			var_360_0.type = SglMsgType_pb.PB_TYPE_SHOP_REFRESH_LADDER
		else
			var_360_0.type = SglMsgType_pb.PB_TYPE_SHOP_REFRESH_LADDER_EX
		end
	end

	var_0_0.sendProtoMsg(var_360_0)
end

function var_0_0.sendProductsRefreshAll()
	local var_361_0 = SglMsg_pb.SglReqMsg()

	var_361_0.type = SglMsgType_pb.PB_TYPE_SHOP_REFRESH_ALL

	var_0_0.sendProtoMsg(var_361_0)
end

function var_0_0.sendProductBuy(arg_362_0)
	local var_362_0 = arg_362_0._id
	local var_362_1 = arg_362_0._type
	local var_362_2 = SglMsg_pb.SglReqMsg()

	if var_362_1 == Data.MarketBuyType.random then
		var_362_2.type = SglMsgType_pb.PB_TYPE_SHOP_BUY
		var_362_2.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = var_362_0
	elseif var_362_1 == Data.MarketBuyType.flag then
		var_362_2.type = SglMsgType_pb.PB_TYPE_SHOP_BUY_PVP
		var_362_2.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = var_362_0
	elseif var_362_1 == Data.MarketBuyType.union then
		var_362_2.type = SglMsgType_pb.PB_TYPE_UNION_BUY
		var_362_2.Extensions[Union_pb.SglUnionMsg.union_buy_req] = var_362_0
	elseif var_362_1 == Data.MarketBuyType.fragment then
		var_362_2.type = SglMsgType_pb.PB_TYPE_SHOP_EXCHANGE
		var_362_2.Extensions[Shop_pb.SglShopMsg.shop_exchange_req] = var_362_0
	elseif var_362_1 == Data.MarketBuyType.dragon_flag then
		var_362_2.type = SglMsgType_pb.PB_TYPE_SHOP_BUY_LADDER
		var_362_2.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = var_362_0
	end

	var_0_0.sendProtoMsg(var_362_2)
end

function var_0_0.sendFriendList()
	local var_363_0 = SglMsg_pb.SglReqMsg()

	var_363_0.type = SglMsgType_pb.PB_TYPE_FRIEND_LIST

	var_0_0.sendProtoMsg(var_363_0)
end

function var_0_0.sendFriendSearch(arg_364_0)
	local var_364_0 = SglMsg_pb.SglReqMsg()

	var_364_0.type = SglMsgType_pb.PB_TYPE_FRIEND_SEARCH
	var_364_0.Extensions[Friend_pb.SglFriendMsg.friend_search_req] = arg_364_0

	var_0_0.sendProtoMsg(var_364_0)
end

function var_0_0.sendFriendRecommend()
	local var_365_0 = SglMsg_pb.SglReqMsg()

	var_365_0.type = SglMsgType_pb.PB_TYPE_FRIEND_RECOMMEND

	var_0_0.sendProtoMsg(var_365_0)
end

function var_0_0.sendFriendInvite(arg_366_0, arg_366_1)
	local var_366_0 = SglMsg_pb.SglReqMsg()

	var_366_0.type = SglMsgType_pb.PB_TYPE_FRIEND_INVITE

	local var_366_1 = var_366_0.Extensions[Friend_pb.SglFriendMsg.friend_invite_req]

	var_366_1.id = arg_366_0
	var_366_1.message = arg_366_1

	var_0_0.sendProtoMsg(var_366_0)
end

function var_0_0.sendFriendRemove(arg_367_0)
	local var_367_0 = SglMsg_pb.SglReqMsg()

	var_367_0.type = SglMsgType_pb.PB_TYPE_FRIEND_REMOVE
	var_367_0.Extensions[Friend_pb.SglFriendMsg.friend_remove_req] = arg_367_0

	var_0_0.sendProtoMsg(var_367_0)
end

function var_0_0.sendUnionFriendBattle(arg_368_0)
	local var_368_0 = SglMsg_pb.SglReqMsg()

	var_368_0.type = SglMsgType_pb.PB_TYPE_FRIEND_BATTLE
	var_368_0.Extensions[Friend_pb.SglFriendMsg.friend_battle_req] = arg_368_0

	var_0_0.sendProtoMsg(var_368_0)
end

function var_0_0.sendUnionFriendBattleJoin(arg_369_0, arg_369_1, arg_369_2)
	local var_369_0 = SglMsg_pb.SglReqMsg()

	var_369_0.type = SglMsgType_pb.PB_TYPE_FRIEND_BATTLE_JOIN

	local var_369_1 = var_369_0.Extensions[Friend_pb.SglFriendMsg.friend_battle_join_req]

	var_369_1.troop_id = arg_369_0
	var_369_1.battle_id = arg_369_1
	var_369_1.user_id = arg_369_2

	var_0_0.sendProtoMsg(var_369_0)
end

function var_0_0.sendUnionFriendBattleCancel()
	local var_370_0 = SglMsg_pb.SglReqMsg()

	var_370_0.type = SglMsgType_pb.PB_TYPE_FRIEND_BATTLE_CANCEL

	var_0_0.sendProtoMsg(var_370_0)
end

function var_0_0.sendMailList()
	local var_371_0 = SglMsg_pb.SglReqMsg()

	var_371_0.type = SglMsgType_pb.PB_TYPE_MAIL_LIST

	var_0_0.sendProtoMsg(var_371_0)
end

function var_0_0.sendMailSend(arg_372_0, arg_372_1)
	local var_372_0 = SglMsg_pb.SglReqMsg()

	var_372_0.type = SglMsgType_pb.PB_TYPE_MAIL_SEND

	local var_372_1 = var_372_0.Extensions[Mail_pb.SglMailMsg.mail_send_req]

	if arg_372_1 then
		var_372_1.type = Mail_pb.PB_MAIL_FRIEND
		var_372_1.id = arg_372_1
	else
		var_372_1.type = Mail_pb.PB_MAIL_UNION
		var_372_1.id = P._unionId
	end

	var_372_1.content = arg_372_0

	var_0_0.sendProtoMsg(var_372_0)
end

function var_0_0.sendGetMessages()
	local var_373_0 = SglMsg_pb.SglReqMsg()

	var_373_0.type = SglMsgType_pb.PB_TYPE_USER_LOADING_DONE

	var_0_0.sendProtoMsg(var_373_0)
end

function var_0_0.sendChat(arg_374_0, arg_374_1, arg_374_2)
	local content = arg_374_2
	if not content or content == "" then return end

	local accId = (var_0_0._account and var_0_0._account.id) or (P and P._id) or 1
	local myName = (P and P._name) or "Duelist"
	local myLevel = (P and P._level) or 1
	local myAvatar = (P and P._avatar) or 201
	local myVip = (P and P._vip) or 0

	local localId = "c_" .. tostring(accId) .. "_" .. tostring(os.time()) .. "_" .. tostring(math.random(1000, 9999))
	var_0_0._knownMsgIds = var_0_0._knownMsgIds or {}
	var_0_0._knownMsgIds[localId] = true

	local msgType = (arg_374_0 == 1 or arg_374_0 == (Chat_pb and Chat_pb.PB_CHAT_WORLD or 1)) and Data.MsgType.world or Data.MsgType.union

	-- 1. Push directly into local player message queue
	local ok, err = pcall(function()
		if P and P._playerMessage and P._playerMessage._msgAll then
			local uinfo = require("User").create({
				id = accId,
				name = myName,
				level = myLevel,
				avatar = myAvatar,
				vip = myVip,
				gold = 0, grain = 0, ingot = 0, exp = 0, trophy = 800, shield = 0,
				union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
				last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
			})
			local msgObj = {
				_id = localId,
				_timestamp = os.time(),
				_user = uinfo,
				_type = msgType,
				_content = content,
				_items = {}
			}
			local wlist = P._playerMessage._msgAll[msgType]
			if wlist then
				if #wlist >= (var_0_0.MAX_MSG_COUNT or 50) then
					table.remove(wlist, #wlist)
				end
				table.insert(wlist, 1, msgObj)
			end
			P._playerMessage:sendMessageEvent(P._playerMessage.Event.msg_new, msgType, 1)
			pcall(function()
				local cp = (ClientView and ClientView.getChatPanel and ClientView.getChatPanel()) or var_0_0._chatPanel
				if cp and cp._isPop then
					cp:resetList()
				end
			end)
		end
	end)

	-- 2. Send via api:post
	pcall(function()
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("chat_send", {
				account_id = accId,
				name = myName,
				level = myLevel,
				avatar = myAvatar,
				content = content,
				client_msg_id = localId,
				type = (msgType == Data.MsgType.world and 1 or 2)
			})
		end
	end)
end

function var_0_0.pollChatHistory()
	pcall(function() if _G.flushPendingChatQueue then _G.flushPendingChatQueue() end end)
	pcall(function()
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.loadChatHistory then
			api:loadChatHistory()
		end
	end)
end
_G.pollChatHistory = var_0_0.pollChatHistory

function var_0_0.sendFeedback(arg_375_0, arg_375_1)
	local var_375_0 = SglMsg_pb.SglReqMsg()

	var_375_0.type = SglMsgType_pb.PB_TYPE_FEEDBACK

	local var_375_1 = var_375_0.Extensions[Feedback_pb.SglFeedbackMsg.feedback_req]

	var_375_1.type = arg_375_0
	var_375_1.content = arg_375_1

	var_0_0.sendProtoMsg(var_375_0)
end

function var_0_0.sendShareLike(arg_376_0)
	local var_376_0 = SglMsg_pb.SglReqMsg()

	var_376_0.type = SglMsgType_pb.PB_TYPE_BATTLE_THUMBS_UP
	var_376_0.Extensions[Battle_pb.SglBattleMsg.battle_thumbs_up_req] = arg_376_0

	var_0_0.sendProtoMsg(var_376_0)
end

function var_0_0.sendShareLikeCancel(arg_377_0)
	local var_377_0 = SglMsg_pb.SglReqMsg()

	var_377_0.type = SglMsgType_pb.PB_TYPE_BATTLE_THUMBS_UP_CANCEL
	var_377_0.Extensions[Battle_pb.SglBattleMsg.battle_thumbs_up_req] = arg_377_0

	var_0_0.sendProtoMsg(var_377_0)
end

function var_0_0.sendIAPStartReq(arg_378_0)
	local var_378_0 = SglMsg_pb.SglReqMsg()

	var_378_0.type = SglMsgType_pb.PB_TYPE_IAP_START
	var_378_0.Extensions[Buy_pb.SglBuyMsg.iap_start_req] = arg_378_0

	var_0_0.sendProtoMsg(var_378_0)
end

function var_0_0.sendIAPFinishReq()
	local var_379_0 = SglMsg_pb.SglReqMsg()

	var_379_0.type = SglMsgType_pb.PB_TYPE_IAP_FINISH

	local var_379_1 = var_379_0.Extensions[Buy_pb.SglBuyMsg.iap_finish_req]

	var_379_1.purchase_id = var_0_0._purchaseId or 0
	var_379_1.is_success = false
	var_379_1.fail_desc = ""

	var_0_0.sendProtoMsg(var_379_0)
end

function var_0_0.sendBuyGold(arg_380_0)
	local var_380_0 = SglMsg_pb.SglReqMsg()

	var_380_0.type = SglMsgType_pb.PB_TYPE_BUY_GOLD
	var_380_0.Extensions[Buy_pb.SglBuyMsg.buy_gold_req] = arg_380_0

	var_0_0.sendProtoMsg(var_380_0)
end

function var_0_0.sendBuyGrain()
	local var_381_0 = SglMsg_pb.SglReqMsg()

	var_381_0.type = SglMsgType_pb.PB_TYPE_BUY_GRAIN

	var_0_0.sendProtoMsg(var_381_0)
end

function var_0_0.sendBuyIngot(arg_382_0)
	local var_382_0 = SglMsg_pb.SglReqMsg()

	var_382_0.type = SglMsgType_pb.PB_TYPE_BUY_INGOT
	var_382_0.Extensions[Buy_pb.SglBuyMsg.buy_ingot_req] = arg_382_0

	var_0_0.sendProtoMsg(var_382_0)
end

function var_0_0.sendBuyDust(arg_383_0, arg_383_1)
	local var_383_0 = SglMsg_pb.SglReqMsg()

	var_383_0.type = SglMsgType_pb.PB_TYPE_BUY_DUST

	local var_383_1 = var_383_0.Extensions[Buy_pb.SglBuyMsg.buy_dust_req]

	var_383_1.id = arg_383_0
	var_383_1.grade = arg_383_1

	var_0_0.sendProtoMsg(var_383_0)
end

function var_0_0.sendBuyMonth(arg_384_0)
	local var_384_0 = SglMsg_pb.SglReqMsg()

	var_384_0.type = SglMsgType_pb.PB_TYPE_BUY_MONTH

	var_0_0.sendProtoMsg(var_384_0)
end

function var_0_0.sendBuyGoods(arg_385_0, arg_385_1)
	local var_385_0 = SglMsg_pb.SglReqMsg()

	var_385_0.type = SglMsgType_pb.PB_TYPE_BUY_DAILY

	local var_385_1 = var_385_0.Extensions[Buy_pb.SglBuyMsg.buy_daily_req]

	var_385_1.id = arg_385_0
	var_385_1.count = arg_385_1

	var_0_0.sendProtoMsg(var_385_0)
end

function var_0_0.sendClaimBonus(arg_386_0)
	local var_386_0 = SglMsg_pb.SglReqMsg()

	var_386_0.type = SglMsgType_pb.PB_TYPE_BONUS_CLAIM
	var_386_0.Extensions[Bonus_pb.SglBonusMsg.bonus_claim_req] = arg_386_0

	var_0_0.appendGuideIdIfNeed(var_386_0)
	var_0_0.sendProtoMsg(var_386_0)
end

function var_0_0.sendClaimOnlineBonus(arg_387_0)
	local var_387_0 = SglMsg_pb.SglReqMsg()

	var_387_0.type = SglMsgType_pb.PB_TYPE_BONUS_ONLINE_CLAIM
	var_387_0.Extensions[Bonus_pb.SglBonusMsg.bonus_claim_req] = arg_387_0

	var_0_0.sendProtoMsg(var_387_0)
end

function var_0_0.sendSupplyMonthCheckinBonus(arg_388_0)
	local var_388_0 = SglMsg_pb.SglReqMsg()

	var_388_0.type = SglMsgType_pb.PB_TYPE_BONUS_RE_CHECK_CLAIM
	var_388_0.Extensions[Bonus_pb.SglBonusMsg.bonus_claim_req] = arg_388_0

	var_0_0.sendProtoMsg(var_388_0)
end

function var_0_0.sendClaimServerBonus(arg_389_0)
	local var_389_0 = SglMsg_pb.SglReqMsg()

	var_389_0.type = SglMsgType_pb.PB_TYPE_BONUS_ACTIVITY_CLAIM
	var_389_0.Extensions[Bonus_pb.SglBonusMsg.bonus_activity_claim_req] = arg_389_0

	var_0_0.sendProtoMsg(var_389_0)
end

function var_0_0.sendGetDailyGold()
	local var_390_0 = SglMsg_pb.SglReqMsg()

	var_390_0.type = SglMsgType_pb.PB_TYPE_USER_SPAWN_GOLD

	var_0_0.sendProtoMsg(var_390_0)
end

function var_0_0.sendClaimDailyGold()
	local var_391_0 = SglMsg_pb.SglReqMsg()

	var_391_0.type = SglMsgType_pb.PB_TYPE_USER_COLLECT_GOLD

	var_0_0.sendProtoMsg(var_391_0)
end

function var_0_0.sendClaimActivityBonus(arg_392_0)
	local var_392_0 = SglMsg_pb.SglReqMsg()

	var_392_0.type = SglMsgType_pb.PB_TYPE_BONUS_ACTIVITY_EX_CLAIM
	var_392_0.Extensions[Bonus_pb.SglBonusMsg.bonus_claim_req] = arg_392_0

	var_0_0.sendProtoMsg(var_392_0)
end

function var_0_0.sendTeachingFinish(arg_393_0)
	local var_393_0 = SglMsg_pb.SglReqMsg()

	var_393_0.type = SglMsgType_pb.PB_TYPE_BONUS_TEACHING_FINISH
	var_393_0.Extensions[Bonus_pb.SglBonusMsg.bonus_teaching_finish_req] = arg_393_0

	var_0_0.sendProtoMsg(var_393_0)
end

function var_0_0.sendNoticeRequest()
	local var_394_0 = SglMsg_pb.SglReqMsg()

	var_394_0.type = SglMsgType_pb.PB_TYPE_NEWS_ANNOUNCEMENT

	var_0_0.sendProtoMsg(var_394_0)
end

function var_0_0.sendResCollect(arg_395_0)
	local var_395_0 = SglMsg_pb.SglReqMsg()

	if arg_395_0 == Data.FixityId.farmland then
		var_395_0.type = SglMsgType_pb.PB_TYPE_CITY_COLLECT_GRAIN
	else
		var_395_0.type = SglMsgType_pb.PB_TYPE_CITY_COLLECT_GOLD
	end

	var_0_0.appendGuideIdIfNeed(var_395_0)
	var_0_0.sendProtoMsg(var_395_0)
end

function var_0_0.sendRankRequest(arg_396_0, arg_396_1)
	local var_396_0 = SglMsg_pb.SglReqMsg()

	var_396_0.type = arg_396_0

	if arg_396_0 == SglMsgType_pb.PB_TYPE_RANK_LADDER then
		var_396_0.Extensions[Rank_pb.SglRankMsg.rank_ladder_req] = arg_396_1
	elseif arg_396_0 == SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL then
		var_396_0.Extensions[Rank_pb.SglRankMsg.rank_char_req] = arg_396_1
	end

	var_0_0.sendProtoMsg(var_396_0)
end

function var_0_0.sendRankUBoss(arg_397_0, arg_397_1)
	local var_397_0 = SglMsg_pb.SglReqMsg()

	var_397_0.type = arg_397_0
	var_397_0.Extensions[Rank_pb.SglRankMsg.rank_uboss_req] = arg_397_1

	var_0_0.sendProtoMsg(var_397_0)
end

function var_0_0.sendRankChapter(arg_398_0)
	local var_398_0 = SglMsg_pb.SglReqMsg()

	var_398_0.type = SglMsgType_pb.PB_TYPE_BATTLE_TUTORIAL
	var_398_0.Extensions[Battle_pb.SglBattleMsg.battle_tutorial_req] = arg_398_0

	var_0_0.sendProtoMsg(var_398_0)
end

function var_0_0.sendBonusRequest(arg_399_0)
	local var_399_0 = SglMsg_pb.SglReqMsg()

	var_399_0.type = arg_399_0

	var_0_0.sendProtoMsg(var_399_0)
end

function var_0_0.sendGuideID(arg_400_0)
	local var_400_0 = SglMsg_pb.SglReqMsg()

	var_400_0.type = SglMsgType_pb.PB_TYPE_USER_SET_GUIDE

	if arg_400_0 then
		var_400_0.Extensions[User_pb.SglUserMsg.user_set_guide_req] = arg_400_0
	end

	var_0_0.sendProtoMsg(var_400_0)
end

function var_0_0.sendOpenBox(arg_401_0, arg_401_1)
	local var_401_0 = SglMsg_pb.SglReqMsg()

	var_401_0.type = SglMsgType_pb.PB_TYPE_USER_OPEN_CHEST

	local var_401_1 = var_401_0.Extensions[User_pb.SglUserMsg.user_open_chest_req]

	var_401_1.id = arg_401_0
	var_401_1.num = arg_401_1

	var_0_0.sendProtoMsg(var_401_0)
end

function var_0_0.sendUseVipCard(arg_402_0)
	local var_402_0 = SglMsg_pb.SglReqMsg()

	var_402_0.type = SglMsgType_pb.PB_TYPE_USER_APPLY_VIP_CARD
	var_402_0.Extensions[User_pb.SglUserMsg.user_apply_vip_card_req] = arg_402_0

	var_0_0.sendProtoMsg(var_402_0)
end

function var_0_0.sendChangeName(arg_403_0)
	local var_403_0 = SglMsg_pb.SglReqMsg()

	var_403_0.type = SglMsgType_pb.PB_TYPE_USER_SET_NAME
	var_403_0.Extensions[User_pb.SglUserMsg.user_set_name_req] = arg_403_0

	var_0_0.sendProtoMsg(var_403_0)
end

function var_0_0.sendChangeNameGuide(arg_404_0)
	local var_404_0 = SglMsg_pb.SglReqMsg()

	var_404_0.type = SglMsgType_pb.PB_TYPE_USER_SET_NAME_GUIDE
	var_404_0.Extensions[User_pb.SglUserMsg.user_set_name_req] = arg_404_0

	var_0_0.sendProtoMsg(var_404_0)
end

function var_0_0.sendSetAvatar(arg_405_0)
	local var_405_0 = SglMsg_pb.SglReqMsg()

	var_405_0.type = SglMsgType_pb.PB_TYPE_USER_SET_AVATAR
	var_405_0.Extensions[User_pb.SglUserMsg.user_set_avatar_req] = arg_405_0

	var_0_0.sendProtoMsg(var_405_0)
end

function var_0_0.sendSetAvatarFrame(arg_406_0)
	local var_406_0 = SglMsg_pb.SglReqMsg()

	var_406_0.type = SglMsgType_pb.PB_TYPE_USER_SET_AVATAR_FRAME
	var_406_0.Extensions[User_pb.SglUserMsg.user_set_avatar_frame_req] = arg_406_0

	var_0_0.sendProtoMsg(var_406_0)
end

function var_0_0.sendSetCardBack(arg_407_0)
	local var_407_0 = SglMsg_pb.SglReqMsg()

	var_407_0.type = SglMsgType_pb.PB_TYPE_USER_SET_CARD_BACK
	var_407_0.Extensions[User_pb.SglUserMsg.user_set_card_back_req] = arg_407_0

	var_0_0.sendProtoMsg(var_407_0)
end

function var_0_0.sendUserGiftExchange(arg_408_0)
	local var_408_0 = SglMsg_pb.SglReqMsg()

	var_408_0.type = SglMsgType_pb.PB_TYPE_USER_CLAIM_GIFT
	var_408_0.Extensions[User_pb.SglUserMsg.user_claim_gift_req] = arg_408_0

	var_0_0.sendProtoMsg(var_408_0)
end

function var_0_0.sendChatBan(arg_409_0)
	local var_409_0 = SglMsg_pb.SglReqMsg()

	var_409_0.type = SglMsgType_pb.PB_TYPE_USER_BAN_CHAT
	var_409_0.Extensions[User_pb.SglUserMsg.user_ban_chat_req] = arg_409_0

	var_0_0.sendProtoMsg(var_409_0)
end

function var_0_0.sendBanLogin()
	local var_410_0 = SglMsg_pb.SglReqMsg()

	var_410_0.type = SglMsgType_pb.PB_TYPE_USER_BAN_LOGIN

	var_0_0.sendProtoMsg(var_410_0)
end

function var_0_0.sendUnlockCharacter(arg_411_0, arg_411_1)
	local var_411_0 = SglMsg_pb.SglReqMsg()

	var_411_0.type = SglMsgType_pb.PB_TYPE_USER_UNLOCK_CHARACTER

	local var_411_1 = var_411_0.Extensions[User_pb.SglUserMsg.user_unlock_character_req]

	var_411_1.char_id = arg_411_0
	var_411_1.use_ingot = arg_411_1

	var_0_0.sendProtoMsg(var_411_0)
end

function var_0_0.sendSetCharacter(arg_412_0, arg_412_1)
	local var_412_0 = SglMsg_pb.SglReqMsg()

	var_412_0.type = SglMsgType_pb.PB_TYPE_USER_SET_CHARACTER
	var_412_0.Extensions[User_pb.SglUserMsg.user_set_character_req] = arg_412_0

	if arg_412_1 then
		var_0_0.appendGuideIdIfNeed(var_412_0)
	end

	var_0_0.sendProtoMsg(var_412_0)
end

function var_0_0.sendGetMyUnionDetail()
	local var_413_0 = SglMsg_pb.SglReqMsg()

	var_413_0.type = SglMsgType_pb.PB_TYPE_UNION_MINE

	var_0_0.sendProtoMsg(var_413_0)
end

function var_0_0.sendGetUnionDetail(arg_414_0)
	local var_414_0 = SglMsg_pb.SglReqMsg()

	var_414_0.type = SglMsgType_pb.PB_TYPE_UNION_DETAIL
	var_414_0.Extensions[Union_pb.SglUnionMsg.union_detail_req] = arg_414_0

	var_0_0.sendProtoMsg(var_414_0)
end

function var_0_0.sendGetUnionMine()
	local var_415_0 = SglMsg_pb.SglReqMsg()

	var_415_0.type = SglMsgType_pb.PB_TYPE_UNION_MINE

	var_0_0.sendProtoMsg(var_415_0)
end

function var_0_0.sendGetSearchUnions(arg_416_0, arg_416_1)
	local var_416_0 = SglMsg_pb.SglReqMsg()

	var_416_0.type = SglMsgType_pb.PB_TYPE_UNION_SEARCH
	var_416_0.Extensions[Union_pb.SglUnionMsg.union_search_req][arg_416_0] = arg_416_1

	var_0_0.sendProtoMsg(var_416_0)
end

function var_0_0.sendGetRecommandUnions()
	local var_417_0 = SglMsg_pb.SglReqMsg()

	var_417_0.type = SglMsgType_pb.PB_TYPE_UNION_RECOMMEND

	var_0_0.sendProtoMsg(var_417_0)
end

function var_0_0.sendChangeUnion(arg_418_0, arg_418_1, arg_418_2, arg_418_3, arg_418_4, arg_418_5)
	local var_418_0 = SglMsg_pb.SglReqMsg()

	var_418_0.type = SglMsgType_pb.PB_TYPE_UNION_EDIT

	local var_418_1 = var_418_0.Extensions[Union_pb.SglUnionMsg.union_edit_req]

	var_418_1.name = arg_418_0
	var_418_1.announcement = arg_418_1
	var_418_1.required_level = arg_418_2
	var_418_1.type = arg_418_3
	var_418_1.avatar = arg_418_4
	var_418_1.tag = arg_418_5

	var_0_0.sendProtoMsg(var_418_0)
end

function var_0_0.sendCreateUnion(arg_419_0, arg_419_1, arg_419_2, arg_419_3, arg_419_4, arg_419_5)
	local var_419_0 = SglMsg_pb.SglReqMsg()

	var_419_0.type = SglMsgType_pb.PB_TYPE_UNION_CREATE

	local var_419_1 = var_419_0.Extensions[Union_pb.SglUnionMsg.union_create_req]

	var_419_1.name = arg_419_0
	var_419_1.announcement = arg_419_1
	var_419_1.required_level = arg_419_2
	var_419_1.type = arg_419_3
	var_419_1.avatar = arg_419_4
	var_419_1.tag = arg_419_5
	var_419_0.Extensions[Union_pb.SglUnionMsg.create_union_use_token] = P:getItemCount(Data.PropsId.union_create) > 0

	var_0_0.sendProtoMsg(var_419_0)
end

function var_0_0.sendUnionApply(arg_420_0, arg_420_1)
	local var_420_0 = SglMsg_pb.SglReqMsg()

	var_420_0.type = SglMsgType_pb.PB_TYPE_UNION_APPLY

	local var_420_1 = var_420_0.Extensions[Union_pb.SglUnionMsg.union_apply_req]

	var_420_1.id = arg_420_0
	var_420_1.message = arg_420_1

	var_0_0.sendProtoMsg(var_420_0)
end

function var_0_0.sendUnionInvite(arg_421_0, arg_421_1)
	local var_421_0 = SglMsg_pb.SglReqMsg()

	var_421_0.type = SglMsgType_pb.PB_TYPE_UNION_INVITE

	local var_421_1 = var_421_0.Extensions[Union_pb.SglUnionMsg.union_invite_req]

	var_421_1.id = arg_421_0
	var_421_1.message = arg_421_1

	var_0_0.sendProtoMsg(var_421_0)
end

function var_0_0.sendUnionAcceptApply(arg_422_0, arg_422_1)
	local var_422_0 = SglMsg_pb.SglReqMsg()

	var_422_0.type = SglMsgType_pb.PB_TYPE_UNION_ACCEPT_APPLY

	local var_422_1 = var_422_0.Extensions[Union_pb.SglUnionMsg.union_accept_req]

	var_422_1.id = arg_422_0
	var_422_1.is_accept = arg_422_1

	if not arg_422_1 then
		var_422_1.content = Str(STR.REFUSE_APPLY)
	end

	var_0_0.sendProtoMsg(var_422_0)
end

function var_0_0.sendUnionAcceptInvite(arg_423_0, arg_423_1)
	local var_423_0 = SglMsg_pb.SglReqMsg()

	var_423_0.type = SglMsgType_pb.PB_TYPE_UNION_ACCEPT_INVITE

	local var_423_1 = var_423_0.Extensions[Union_pb.SglUnionMsg.union_accept_req]

	var_423_1.id = arg_423_0
	var_423_1.is_accept = arg_423_1

	if not arg_423_1 then
		var_423_1.content = Str(STR.REFUSE_INVITE)
	end

	var_0_0.sendProtoMsg(var_423_0)
end

function var_0_0.sendUnionKickout(arg_424_0)
	local var_424_0 = SglMsg_pb.SglReqMsg()

	var_424_0.type = SglMsgType_pb.PB_TYPE_UNION_KICKOUT
	var_424_0.Extensions[Union_pb.SglUnionMsg.union_kickout_req] = arg_424_0

	var_0_0.sendProtoMsg(var_424_0)
end

function var_0_0.sendUnionLeave()
	local var_425_0 = SglMsg_pb.SglReqMsg()

	var_425_0.type = SglMsgType_pb.PB_TYPE_UNION_LEAVE

	var_0_0.sendProtoMsg(var_425_0)
end

function var_0_0.sendUnionPromote(arg_426_0)
	local var_426_0 = SglMsg_pb.SglReqMsg()

	var_426_0.type = SglMsgType_pb.PB_TYPE_UNION_PROMOTE
	var_426_0.Extensions[Union_pb.SglUnionMsg.union_promote_req] = arg_426_0

	var_0_0.sendProtoMsg(var_426_0)
end

function var_0_0.sendUnionDemote(arg_427_0)
	local var_427_0 = SglMsg_pb.SglReqMsg()

	var_427_0.type = SglMsgType_pb.PB_TYPE_UNION_DEMOTE
	var_427_0.Extensions[Union_pb.SglUnionMsg.union_demote_req] = arg_427_0

	var_0_0.sendProtoMsg(var_427_0)
end

function var_0_0.sendUnionGiveLeader(arg_428_0)
	local var_428_0 = SglMsg_pb.SglReqMsg()

	var_428_0.type = SglMsgType_pb.PB_TYPE_UNION_RESIGN
	var_428_0.Extensions[Union_pb.SglUnionMsg.union_resign_req] = arg_428_0

	var_0_0.sendProtoMsg(var_428_0)
end

function var_0_0.sendUnionUpgrade()
	local var_429_0 = SglMsg_pb.SglReqMsg()

	var_429_0.type = SglMsgType_pb.PB_TYPE_UNION_UPGRADE

	var_0_0.sendProtoMsg(var_429_0)
end

function var_0_0.sendUnionContribute(arg_430_0, arg_430_1)
	local var_430_0 = SglMsg_pb.SglReqMsg()

	var_430_0.type = SglMsgType_pb.PB_TYPE_UNION_DONATE

	local var_430_1 = var_430_0.Extensions[Union_pb.SglUnionMsg.union_donate_req]

	var_430_1.grade = arg_430_0
	var_430_1.donate_type = arg_430_1

	var_0_0.sendProtoMsg(var_430_0)
end

function var_0_0.sendUnionWorship(arg_431_0, arg_431_1)
	local var_431_0 = SglMsg_pb.SglReqMsg()

	var_431_0.type = SglMsgType_pb.PB_TYPE_UNION_WORSHIP

	local var_431_1 = var_431_0.Extensions[Union_pb.SglUnionMsg.union_worship_req]

	var_431_1.id = arg_431_0
	var_431_1.grade = arg_431_1

	var_0_0.sendProtoMsg(var_431_0)
end

function var_0_0.sendUnionAddHire(arg_432_0)
	local var_432_0 = SglMsg_pb.SglReqMsg()

	var_432_0.type = SglMsgType_pb.PB_TYPE_UNION_LET
	var_432_0.Extensions[Union_pb.SglUnionMsg.union_let_req] = arg_432_0

	var_0_0.sendProtoMsg(var_432_0)
end

function var_0_0.sendUnionHire(arg_433_0)
	local var_433_0 = SglMsg_pb.SglReqMsg()

	var_433_0.type = SglMsgType_pb.PB_TYPE_UNION_RENT
	var_433_0.Extensions[Union_pb.SglUnionMsg.union_rent_req] = arg_433_0

	var_0_0.sendProtoMsg(var_433_0)
end

function var_0_0.sendUnionHireClaim(arg_434_0)
	local var_434_0 = SglMsg_pb.SglReqMsg()

	var_434_0.type = SglMsgType_pb.PB_TYPE_UNION_CLAIM_LET
	var_434_0.Extensions[Union_pb.SglUnionMsg.union_claim_let_req] = arg_434_0

	var_0_0.sendProtoMsg(var_434_0)
end

function var_0_0.sendUnionHireRecall(arg_435_0)
	local var_435_0 = SglMsg_pb.SglReqMsg()

	var_435_0.type = SglMsgType_pb.PB_TYPE_UNION_UNLET
	var_435_0.Extensions[Union_pb.SglUnionMsg.union_unlet_req] = arg_435_0

	var_0_0.sendProtoMsg(var_435_0)
end

function var_0_0.sendGetUnionLog()
	local var_436_0 = SglMsg_pb.SglReqMsg()

	var_436_0.type = SglMsgType_pb.PB_TYPE_UNION_LOG

	var_0_0.sendProtoMsg(var_436_0)
end

function var_0_0.sendUnionBossUnlock(arg_437_0)
	local var_437_0 = SglMsg_pb.SglReqMsg()

	var_437_0.type = SglMsgType_pb.PB_TYPE_UNION_BOSS_UNLOCK
	var_437_0.Extensions[Union_pb.SglUnionMsg.union_boss_unlock_req] = arg_437_0

	var_0_0.sendProtoMsg(var_437_0)
end

function var_0_0.sendUnionBossChallenge(arg_438_0)
	local var_438_0 = SglMsg_pb.SglReqMsg()

	var_438_0.type = SglMsgType_pb.PB_TYPE_UNION_BOSS_ATTACK
	var_438_0.Extensions[Union_pb.SglUnionMsg.union_boss_attack_req] = arg_438_0

	var_0_0.sendProtoMsg(var_438_0)
end

function var_0_0.sendUnionUpgradeTech(arg_439_0)
	local var_439_0 = SglMsg_pb.SglReqMsg()

	var_439_0.type = SglMsgType_pb.PB_TYPE_UNION_TECH_UPGRADE
	var_439_0.Extensions[Union_pb.SglUnionMsg.union_tech_upgrade_req] = arg_439_0

	var_0_0.sendProtoMsg(var_439_0)
end

function var_0_0.sendUnionUpgradeTechSelf(arg_440_0)
	local var_440_0 = SglMsg_pb.SglReqMsg()

	var_440_0.type = SglMsgType_pb.PB_TYPE_USER_TECH_UPGRADE
	var_440_0.Extensions[User_pb.SglUserMsg.user_tech_upgrade_req] = arg_440_0

	var_0_0.sendProtoMsg(var_440_0)
end

function var_0_0.sendGiveFund(arg_441_0)
	local var_441_0 = SglMsg_pb.SglReqMsg()

	var_441_0.type = SglMsgType_pb.PB_TYPE_USER_GIVE_FUND
	var_441_0.Extensions[User_pb.SglUserMsg.user_give_fund_req] = arg_441_0

	var_0_0.sendProtoMsg(var_441_0)
end

function var_0_0.sendUnionImpeach(arg_442_0, arg_442_1)
	local var_442_0 = SglMsg_pb.SglReqMsg()

	var_442_0.type = arg_442_1 and SglMsgType_pb.PB_TYPE_UNION_UNIMPEACH or SglMsgType_pb.PB_TYPE_UNION_IMPEACH

	if not arg_442_1 then
		var_442_0.Extensions[Union_pb.SglUnionMsg.union_impeach_req] = arg_442_0
	end

	var_0_0.sendProtoMsg(var_442_0)
end

function var_0_0.sendUnionBattleScout(arg_443_0, arg_443_1, arg_443_2, arg_443_3)
	local var_443_0 = SglMsg_pb.SglReqMsg()

	var_443_0.type = SglMsgType_pb.PB_TYPE_UNION_WAR_BATTLE_SCOUT

	local var_443_1 = var_443_0.Extensions[UnionWar_pb.SglUnionWarMsg.union_battle_scout_req]

	var_443_1.war_id = arg_443_0
	var_443_1.union_id = arg_443_1
	var_443_1.camp_id = arg_443_2

	var_0_0.sendProtoMsg(var_443_0)
end

function var_0_0.sendUnionBattleAttack(arg_444_0, arg_444_1, arg_444_2)
	local var_444_0 = SglMsg_pb.SglReqMsg()

	var_444_0.type = SglMsgType_pb.PB_TYPE_UNION_WAR_BATTLE_ATTACK

	local var_444_1 = var_444_0.Extensions[UnionWar_pb.SglUnionWarMsg.union_battle_attack_req]

	var_444_1.war_id = arg_444_0
	var_444_1.union_id = arg_444_1
	var_444_1.camp_id = arg_444_2

	var_0_0.sendProtoMsg(var_444_0)
end

function var_0_0.sendUnionBattleJoin(arg_445_0)
	local var_445_0 = SglMsg_pb.SglReqMsg()

	var_445_0.type = SglMsgType_pb.PB_TYPE_UNION_WAR_BATTLE_JOIN
	var_445_0.Extensions[UnionWar_pb.SglUnionWarMsg.union_battle_join_req] = arg_445_0

	var_0_0.sendProtoMsg(var_445_0)
end

function var_0_0.sendGetInviteCode()
	local var_446_0 = SglMsg_pb.SglReqMsg()

	var_446_0.type = SglMsgType_pb.PB_TYPE_USER_GET_INVITE_CODE

	var_0_0.sendProtoMsg(var_446_0)
end

function var_0_0.sendGetInviteInfo(arg_447_0)
	local var_447_0 = SglMsg_pb.SglReqMsg()

	var_447_0.type = SglMsgType_pb.PB_TYPE_USER_CHECK_INVITE_CODE
	var_447_0.Extensions[User_pb.SglUserMsg.user_check_invite_code_req] = arg_447_0

	var_0_0.sendProtoMsg(var_447_0)
end

function var_0_0.sendBindInvite(arg_448_0)
	local var_448_0 = SglMsg_pb.SglReqMsg()

	var_448_0.type = SglMsgType_pb.PB_TYPE_USER_BIND_INVITE_CODE
	var_448_0.Extensions[User_pb.SglUserMsg.user_bind_invite_code_req] = arg_448_0

	var_0_0.sendProtoMsg(var_448_0)
end

function var_0_0.sendQueryGcid(arg_449_0)
	local var_449_0 = SglMsg_pb.SglReqMsg()

	var_449_0.type = SglMsgType_pb.PB_TYPE_USER_QUERY_GCID

	if arg_449_0 ~= "" and arg_449_0 ~= "UDID" then
		var_449_0.Extensions[User_pb.SglUserMsg.user_gcid_req] = arg_449_0
	end

	var_0_0.sendProtoMsg(var_449_0)
end

function var_0_0.sendBattleLoadingDone()
	local var_450_0 = SglMsg_pb.SglReqMsg()

	var_450_0.type = SglMsgType_pb.PB_TYPE_BATTLE_LOADING_DONE

	var_0_0.sendProtoMsg(var_450_0)
end

function var_0_0.sendServerPushSwitch(arg_451_0)
	local var_451_0 = SglMsg_pb.SglReqMsg()

	var_451_0.type = SglMsgType_pb.PB_TYPE_USER_SET_CONFIG
	var_451_0.Extensions[User_pb.SglUserMsg.user_set_config_req] = arg_451_0

	var_0_0.sendProtoMsg(var_451_0)
end

function var_0_0.sendUserEvent(arg_452_0)
	if var_0_0.isLogin() then
		local var_452_0 = SglMsg_pb.SglReqMsg()

		var_452_0.type = SglMsgType_pb.PB_TYPE_USER_SET_EVENT
		var_452_0.Extensions[User_pb.SglUserMsg.user_set_event_req] = json.encode(arg_452_0)

		var_0_0.sendProtoMsg(var_452_0)
	end
end

function var_0_0.sendUserFacebook(arg_453_0)
	local var_453_0 = SglMsg_pb.SglReqMsg()

	var_453_0.type = SglMsgType_pb.PB_TYPE_USER_FACEBOOK
	var_453_0.Extensions[User_pb.SglUserMsg.user_facebook_req] = arg_453_0

	var_0_0.sendProtoMsg(var_453_0)
end

function var_0_0.sendBuyDepot(arg_454_0)
	local var_454_0 = SglMsg_pb.SglReqMsg()

	var_454_0.type = SglMsgType_pb.PB_TYPE_SHOP_MAGICBOX
	var_454_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_454_0

	var_0_0.sendProtoMsg(var_454_0)
end

function var_0_0.sendBuyCollect(arg_455_0)
	local var_455_0 = SglMsg_pb.SglReqMsg()

	var_455_0.type = SglMsgType_pb.PB_TYPE_SHOP_COLLECTION
	var_455_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_455_0

	var_0_0.sendProtoMsg(var_455_0)
end

function var_0_0.sendBuyVote(arg_456_0)
	local var_456_0 = SglMsg_pb.SglReqMsg()

	var_456_0.type = SglMsgType_pb.PB_TYPE_SHOP_VOTE
	var_456_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_456_0

	var_0_0.sendProtoMsg(var_456_0)
end

function var_0_0.sendBuyBadgeProduct(arg_457_0)
	local var_457_0 = SglMsg_pb.SglReqMsg()

	var_457_0.type = SglMsgType_pb.PB_TYPE_SHOP_BADGE
	var_457_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_457_0

	var_0_0.sendProtoMsg(var_457_0)
end

function var_0_0.sendBuyUnion(arg_458_0)
	local var_458_0 = SglMsg_pb.SglReqMsg()

	var_458_0.type = SglMsgType_pb.PB_TYPE_SHOP_UNION
	var_458_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_458_0

	var_0_0.sendProtoMsg(var_458_0)
end

function var_0_0.sendBuyRare(arg_459_0)
	local var_459_0 = SglMsg_pb.SglReqMsg()

	var_459_0.type = SglMsgType_pb.PB_TYPE_SHOP_RARE
	var_459_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_459_0

	var_0_0.sendProtoMsg(var_459_0)

	P._playerMarket._rareGoodsMap[arg_459_0] = 1
end

function var_0_0.sendBuySkill(arg_460_0)
	local var_460_0 = SglMsg_pb.SglReqMsg()

	var_460_0.type = SglMsgType_pb.PB_TYPE_SHOP_RUBBING
	var_460_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_460_0

	var_0_0.sendProtoMsg(var_460_0)
end

function var_0_0.sendBuyDiamond(arg_461_0)
	local var_461_0 = SglMsg_pb.SglReqMsg()

	var_461_0.type = SglMsgType_pb.PB_TYPE_SHOP_DIAMOND
	var_461_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_461_0

	var_0_0.sendProtoMsg(var_461_0)
end

function var_0_0.sendBuyNew(arg_462_0)
	local var_462_0 = SglMsg_pb.SglReqMsg()

	var_462_0.type = SglMsgType_pb.PB_TYPE_SHOP_REVELRY
	var_462_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_462_0

	var_0_0.sendProtoMsg(var_462_0)
end

function var_0_0.sendBuyAncient(arg_463_0)
	local var_463_0 = SglMsg_pb.SglReqMsg()

	var_463_0.type = SglMsgType_pb.PB_TYPE_SHOP_ANCIENT
	var_463_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_463_0

	var_0_0.sendProtoMsg(var_463_0)
end

function var_0_0.sendBuyMonthCard5Product(arg_464_0)
	local var_464_0 = SglMsg_pb.SglReqMsg()

	var_464_0.type = SglMsgType_pb.PB_TYPE_SHOP_PRIVILEGE
	var_464_0.Extensions[Shop_pb.SglShopMsg.shop_buy_req] = arg_464_0

	var_0_0.sendProtoMsg(var_464_0)
end

function var_0_0.sendResetFundTask(arg_465_0)
	local var_465_0 = SglMsg_pb.SglReqMsg()

	var_465_0.type = SglMsgType_pb.PB_TYPE_BONUS_DAILY_TASK_RESET
	var_465_0.Extensions[Bonus_pb.SglBonusMsg.daily_task_reset_req] = arg_465_0

	var_0_0.sendProtoMsg(var_465_0)
end

function var_0_0.sendCreateGroup(arg_466_0, arg_466_1)
	local var_466_0 = SglMsg_pb.SglReqMsg()

	var_466_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_CREATE_TEAM

	local var_466_1 = var_466_0.Extensions[UnionWar_pb.SglUnionWarMsg.masswar_create_team_req]

	var_466_1.team_name = arg_466_0
	var_466_1.team_avatar = arg_466_1

	var_0_0.sendProtoMsg(var_466_0)
end

function var_0_0.sendGetGroups()
	local var_467_0 = SglMsg_pb.SglReqMsg()

	var_467_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_QUERY_INFO

	var_0_0.sendProtoMsg(var_467_0)
end

function var_0_0.sendStopUpdateGroups()
	local var_468_0 = SglMsg_pb.SglReqMsg()

	var_468_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_QUIT_INFO

	var_0_0.sendProtoMsg(var_468_0)
end

function var_0_0.sendExitGroup(arg_469_0)
	local var_469_0 = SglMsg_pb.SglReqMsg()

	var_469_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TEAM
	var_469_0.Extensions[UnionWar_pb.SglUnionWarMsg.masswar_team_user_id].team_id = arg_469_0

	var_0_0.sendProtoMsg(var_469_0)
end

function var_0_0.sendGroupKick(arg_470_0, arg_470_1)
	local var_470_0 = SglMsg_pb.SglReqMsg()

	var_470_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_KICK_OUT_TEAM

	local var_470_1 = var_470_0.Extensions[UnionWar_pb.SglUnionWarMsg.masswar_team_user_id]

	var_470_1.team_id = arg_470_0
	var_470_1.user_id = arg_470_1

	var_0_0.sendProtoMsg(var_470_0)
end

function var_0_0.sendGroupJoin(arg_471_0)
	local var_471_0 = SglMsg_pb.SglReqMsg()

	var_471_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_JOIN_TEAM
	var_471_0.Extensions[UnionWar_pb.SglUnionWarMsg.masswar_team_user_id].team_id = arg_471_0

	var_0_0.sendProtoMsg(var_471_0)
end

function var_0_0.sendGetGroupCards()
	local var_472_0 = SglMsg_pb.SglReqMsg()

	var_472_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_LOAD_CARDS

	var_0_0.sendProtoMsg(var_472_0)
end

function var_0_0.sendQuitGroupCards()
	local var_473_0 = SglMsg_pb.SglReqMsg()

	var_473_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TROOP

	var_0_0.sendProtoMsg(var_473_0)
end

function var_0_0.sendStartUnionBattle()
	local var_474_0 = SglMsg_pb.SglReqMsg()

	var_474_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_START

	var_0_0.sendProtoMsg(var_474_0)
end

function var_0_0.sendQuitUnionBattle()
	local var_475_0 = SglMsg_pb.SglReqMsg()

	var_475_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_QUIT

	var_0_0.sendProtoMsg(var_475_0)
end

function var_0_0.sendFindUnionBattle()
	local var_476_0 = SglMsg_pb.SglReqMsg()

	var_476_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_FIND

	var_0_0.sendProtoMsg(var_476_0)
end

function var_0_0.sendFindUnionBattleCancle()
	local var_477_0 = SglMsg_pb.SglReqMsg()

	var_477_0.type = SglMsgType_pb.PB_TYPE_MASSWAR_MULTIPLE_FIND_CANCEL

	var_0_0.sendProtoMsg(var_477_0)
end

function var_0_0.sendGetPreRanks()
	local var_478_0 = SglMsg_pb.SglReqMsg()

	var_478_0.type = SglMsgType_pb.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE

	var_0_0.sendProtoMsg(var_478_0)
end

function var_0_0.sendActivityExchange(arg_479_0)
	local var_479_0 = SglMsg_pb.SglReqMsg()

	var_479_0.type = SglMsgType_pb.PB_TYPE_SHOP_EXCHANGE_PROP
	var_479_0.Extensions[Shop_pb.SglShopMsg.shop_exchange_prop_req] = arg_479_0

	var_0_0.sendProtoMsg(var_479_0)
end

function var_0_0.sendProp(arg_480_0, arg_480_1, arg_480_2, arg_480_3)
	local var_480_0 = SglMsg_pb.SglReqMsg()

	var_480_0.type = SglMsgType_pb.PB_TYPE_BONUS_GIFT

	local var_480_1 = var_480_0.Extensions[Bonus_pb.SglBonusMsg.send_gift_req]

	var_480_1.user_id = arg_480_0

	if arg_480_3 then
		var_480_1.bonus_id = arg_480_1
		var_480_1.count = arg_480_2
	else
		var_480_1.bonus_id = 0
		var_480_1.resource.info_id = arg_480_1
		var_480_1.resource.num = arg_480_2
	end

	var_0_0.sendProtoMsg(var_480_0)
end

function var_0_0.sendGetLotteryOpened()
	local var_481_0 = SglMsg_pb.SglReqMsg()

	var_481_0.type = SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_OPENED

	var_0_0.sendProtoMsg(var_481_0)
end

function var_0_0.sendGetLotteryUnopened()
	local var_482_0 = SglMsg_pb.SglReqMsg()

	var_482_0.type = SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_UNOPEN

	var_0_0.sendProtoMsg(var_482_0)
end

function var_0_0.sendComposeCard(arg_483_0, arg_483_1)
	local var_483_0 = SglMsg_pb.SglReqMsg()

	var_483_0.type = SglMsgType_pb.PB_TYPE_CARD_LEGEND_COMPOSE
	var_483_0.Extensions[Card_pb.SglCardMsg.legend_card_compose] = arg_483_0
	var_483_0.Extensions[Card_pb.SglCardMsg.legend_card_compose_pkg] = arg_483_1

	var_0_0.sendProtoMsg(var_483_0)
end

function var_0_0.sendGetRecommendTroops()
	local var_484_0 = SglMsg_pb.SglReqMsg()

	var_484_0.type = SglMsgType_pb.PB_TYPE_WORLD_RECOMMEND_TROOP

	var_0_0.sendProtoMsg(var_484_0)
end

function var_0_0.getAttackUserFromInput(arg_485_0)
	local var_485_0 = arg_485_0._player
	local var_485_1 = arg_485_0._opponent

	return arg_485_0._isAttacker and var_485_0 or var_485_1
end

function var_0_0.sendGetDarkInfo()
	local var_486_0 = SglMsg_pb.SglReqMsg()

	var_486_0.type = SglMsgType_pb.PB_TYPE_WORLD_DARK_DUEL_DASHBOARD

	var_0_0.sendProtoMsg(var_486_0)
end

function var_0_0.sendDarkRetreat()
	local var_487_0 = SglMsg_pb.SglReqMsg()

	var_487_0.type = SglMsgType_pb.PB_TYPE_WORLD_DARK_DUEL_RECHEAT

	var_0_0.sendProtoMsg(var_487_0)
end

function var_0_0.sendRoomSelectTroop(arg_488_0)
	local var_488_0 = SglMsg_pb.SglReqMsg()

	var_488_0.type = SglMsgType_pb.PB_TYPE_WORLD_SELECT_DARK_TROOP
	var_488_0.Extensions[World_pb.SglWorldMsg.card_select_dark_troop_req] = arg_488_0

	var_0_0.sendProtoMsg(var_488_0)
end

function var_0_0.sendWxShared()
	local var_489_0 = SglMsg_pb.SglReqMsg()

	var_489_0.type = SglMsgType_pb.PB_TYPE_USER_SHARE

	var_0_0.sendProtoMsg(var_489_0)
end

function var_0_0.sendGetWorshipList()
	local var_490_0 = SglMsg_pb.SglReqMsg()

	var_490_0.type = SglMsgType_pb.PB_TYPE_WORLD_WORSHIP_LIST

	var_0_0.sendProtoMsg(var_490_0)
end

function var_0_0.sendWorship(arg_491_0)
	local var_491_0 = SglMsg_pb.SglReqMsg()

	var_491_0.type = SglMsgType_pb.PB_TYPE_WORLD_WORSHIP
	var_491_0.Extensions[World_pb.SglWorldMsg.worship_req] = arg_491_0

	var_0_0.sendProtoMsg(var_491_0)
end

function var_0_0.sendGetLotteryPackage(arg_492_0)
	local var_492_0 = SglMsg_pb.SglReqMsg()

	var_492_0.type = SglMsgType_pb.PB_TYPE_CARD_GET_FESTIVAL
	var_492_0.Extensions[Card_pb.SglCardMsg.festival_req] = arg_492_0

	var_0_0.sendProtoMsg(var_492_0)
end

function var_0_0.sendLotteryPackage(arg_493_0, arg_493_1)
	local var_493_0 = SglMsg_pb.SglReqMsg()

	var_493_0.type = SglMsgType_pb.PB_TYPE_CARD_LOTTERY_FESTIVAL
	var_493_0.Extensions[Card_pb.SglCardMsg.festival_req] = arg_493_0
	var_493_0.Extensions[Card_pb.SglCardMsg.festival_lottery_use_token] = arg_493_1

	var_0_0.sendProtoMsg(var_493_0)
end

function var_0_0.sendResetLotteryPackage(arg_494_0)
	local var_494_0 = SglMsg_pb.SglReqMsg()

	var_494_0.type = SglMsgType_pb.PB_TYPE_CARD_RESET_FESTIVAL
	var_494_0.Extensions[Card_pb.SglCardMsg.festival_req] = arg_494_0

	var_0_0.sendProtoMsg(var_494_0)
end

function var_0_0.sendClaimEnvelope(arg_495_0)
	local var_495_0 = SglMsg_pb.SglReqMsg()

	var_495_0.type = SglMsgType_pb.PB_TYPE_BONUS_CLAIM_ENVELOPE

	if arg_495_0 then
		var_495_0.type = SglMsgType_pb.PB_TYPE_BONUS_CLAIM_CHARGE_ENVELOPE
	end

	var_0_0.sendProtoMsg(var_495_0)
end

function var_0_0.sendConvertFragment(arg_496_0)
	local var_496_0 = SglMsg_pb.SglReqMsg()

	var_496_0.type = SglMsgType_pb.PB_TYPE_CARD_LEGEND_TRANSLATE
	var_496_0.Extensions[Card_pb.SglCardMsg.legend_translate_req] = arg_496_0

	var_0_0.sendProtoMsg(var_496_0)
end

function var_0_0.sendBuyBadge(arg_497_0)
	local var_497_0 = SglMsg_pb.SglReqMsg()

	var_497_0.type = SglMsgType_pb.PB_TYPE_BUY_BADGE
	var_497_0.Extensions[Buy_pb.SglBuyMsg.buy_badge_req] = arg_497_0

	var_0_0.sendProtoMsg(var_497_0)
end

function var_0_0.sendBuyBadgeStar(arg_498_0)
	local var_498_0 = SglMsg_pb.SglReqMsg()

	var_498_0.type = SglMsgType_pb.PB_TYPE_BUY_BADGE_LEVEL
	var_498_0.Extensions[Buy_pb.SglBuyMsg.buy_badge_level_req] = arg_498_0

	var_0_0.sendProtoMsg(var_498_0)
end

function var_0_0.sendBuyBadgeExStar(arg_499_0)
	local var_499_0 = SglMsg_pb.SglReqMsg()

	var_499_0.type = SglMsgType_pb.PB_TYPE_BUY_SPRING_BADGE_LEVEL
	var_499_0.Extensions[Buy_pb.SglBuyMsg.buy_badge_level_req] = arg_499_0

	var_0_0.sendProtoMsg(var_499_0)
end

function var_0_0.sendBuyBadgeEx2Star(arg_500_0)
	local var_500_0 = SglMsg_pb.SglReqMsg()

	var_500_0.type = SglMsgType_pb.PB_TYPE_BUY_SPRING2_BADGE_LEVEL
	var_500_0.Extensions[Buy_pb.SglBuyMsg.buy_badge_level_req] = arg_500_0

	var_0_0.sendProtoMsg(var_500_0)
end

function var_0_0.getIconName(arg_501_0, arg_501_1)
	local var_501_0
	local var_501_1
	local var_501_2
	local var_501_3 = 1

	if arg_501_0 == 0 then
		var_501_1 = "card_icon_quality_00"
		var_501_2 = ClientView.SHADER_GRAY_FRAME
		var_501_0 = "card_ico_0"
	else
		local var_501_4, var_501_5 = Data.getInfo(arg_501_0)

		if var_501_5 == Data.ResType.fragment then
			var_501_4 = Data.getInfo(P._playerCard:convert2CardId(arg_501_0))
		end

		if var_501_4 == nil and var_501_5 ~= Data.CardType.nature and var_501_5 ~= Data.CardType.category and var_501_5 ~= Data.CardType.keyword and var_501_5 ~= Data.CardType.flag and var_501_5 ~= Data.CardType.star and var_501_5 ~= Data.CardType.min_star and var_501_5 ~= Data.CardType.card_type and var_501_5 ~= Data.CardType.max_quality and var_501_5 ~= Data.CardType.max_star then
			arg_501_0 = 10001
			var_501_4, var_501_5 = Data.getInfo(arg_501_0)
		end

		if var_501_5 == Data.CardType.res then
			var_501_1 = "card_icon_quality_00"
			var_501_2 = ClientView.SHADER_GRAY_FRAME
			var_501_0 = arg_501_1 and string.format("res_ico_%d", arg_501_0) or string.format("img_icon_res%d_s", arg_501_0)
		elseif var_501_4 == nil then
			var_501_1 = "card_icon_quality_01"
			var_501_2 = ClientView.SHADER_TYPES[Data.CardType.monster]
			var_501_0 = string.format("card_ico_%d", arg_501_0)
		elseif var_501_5 == Data.CardType.other then
			var_501_1 = "card_icon_quality_00"
			var_501_2 = nil
			var_501_0 = "card_icon_unknow"
		elseif var_501_5 == Data.CardType.props then
			if Data.isAvatarFrame(arg_501_0) then
				local var_501_6 = P._propBag:validPropId(arg_501_0)

				var_501_1 = "card_icon_quality_00"
				var_501_2 = ClientView.SHADER_GRAY_FRAME
				var_501_0 = ClientData.getAvatarFrameName(var_501_6)
			elseif Data.isCardBack(arg_501_0) then
				var_501_1 = "card_icon_quality_00"
				var_501_2 = ClientView.SHADER_GRAY_FRAME
				var_501_0 = ClientView.getCardBackName(arg_501_0)
				var_501_3 = 0.2
			elseif var_501_4._type == Data.PropsType.artifact then
				var_501_1 = "card_icon_empty"
				var_501_2 = nil
				var_501_0 = ClientData.getPropIconName(arg_501_0, arg_501_1)
			else
				local var_501_7 = var_501_4._quality
				local var_501_8 = var_501_4._cardType

				if var_501_8 > 0 then
					var_501_1 = "card_icon_quality_00"
					var_501_2 = ClientView.SHADER_TYPES[var_501_8]
				else
					var_501_1 = "card_icon_quality_00"
					var_501_2 = ClientView.SHADER_GRAY_FRAME
				end

				var_501_0 = ClientData.getPropIconName(arg_501_0, arg_501_1)
			end
		elseif var_501_5 == Data.CardType.card_skill then
			local var_501_9 = arg_501_0 % Data.INFO_ID_FRAGMENT_SIZE_LARGE
			local var_501_10 = Data.getInfo(var_501_9)

			var_501_1 = "card_icon_quality_0" .. var_501_10._quality
			var_501_2 = ClientView.getCardShader(var_501_9)
			var_501_0 = ClientView.getCardIconName(var_501_9)
		elseif var_501_5 == Data.CardType.item_skill then
			var_501_0, var_501_1, var_501_2, var_501_3 = ClientData.getIconName(Data.PropsId.item_skill_base, arg_501_1)
		elseif var_501_5 >= Data.CardType.monster and var_501_5 <= Data.CardType.rare then
			local var_501_11 = P._playerCard:convert2CardId(arg_501_0)

			var_501_1 = "card_icon_quality_0" .. var_501_4._quality
			var_501_2 = ClientView.getCardShader(var_501_11)
			var_501_0 = ClientView.getCardIconName(var_501_11)
		end
	end

	if ClientData.isAppStoreReviewing() then
		local var_501_12 = var_501_0 .. "_r"

		if lc.FrameCache:getSpriteFrame(var_501_12) ~= nil then
			var_501_0 = var_501_12
		end
	end

	return var_501_0, var_501_1, var_501_2, var_501_3
end

function var_0_0.loadSubChannelInfo(arg_502_0)
	if ClientData._subChannelUid then
		ClientData.sendGetOppoVipLevel(ClientData._subChannelUid)
	end
end

function var_0_0.sendGetOppoVipLevel(arg_503_0)
	local var_503_0 = SglMsg_pb.SglReqMsg()

	var_503_0.type = SglMsgType_pb.PB_TYPE_USER_OPPO_VIP_LEVEL

	local var_503_1 = var_503_0.Extensions[User_pb.SglUserMsg.user_oppo_vip_req]

	var_503_1.sub_channel = "oppo"
	var_503_1.channel_uid = tostring(arg_503_0)

	var_0_0.sendProtoMsg(var_503_0)
end

function var_0_0.onGetOppoVipLevel(arg_504_0)
	ClientData._subChannelVipLevel = arg_504_0

	lc.sendEvent(Data.Event.channel_level_dirty, arg_504_0)
end

function var_0_0.sendSelectUp(arg_505_0, arg_505_1)
	local var_505_0 = SglMsg_pb.SglReqMsg()

	var_505_0.type = SglMsgType_pb.PB_TYPE_CARD_UP_PKG_CARD

	local var_505_1 = var_505_0.Extensions[Card_pb.SglCardMsg.up_pkg_card_req]

	var_505_1.pkg_id = arg_505_0
	var_505_1.card_id = arg_505_1

	var_0_0.sendProtoMsg(var_505_0)
end

function var_0_0.sendSelectHp(arg_506_0)
	local var_506_0 = SglMsg_pb.SglReqMsg()

	var_506_0.type = SglMsgType_pb.PB_TYPE_BATTLE_SET_MATCH_HP
	var_506_0.Extensions[Battle_pb.SglBattleMsg.battle_set_match_hp_req] = arg_506_0

	var_0_0.sendProtoMsg(var_506_0)
end

function var_0_0.sendVote(arg_507_0, arg_507_1, arg_507_2)
	local var_507_0 = SglMsg_pb.SglReqMsg()

	var_507_0.type = SglMsgType_pb.PB_TYPE_USER_VOTE

	local var_507_1 = var_507_0.Extensions[User_pb.SglUserMsg.user_vote_req]

	var_507_1.stage = arg_507_0
	var_507_1.vote.key = arg_507_1
	var_507_1.vote.value = arg_507_2

	var_0_0.sendProtoMsg(var_507_0)
end

function var_0_0.sendVoteRecord(arg_508_0)
	local var_508_0 = SglMsg_pb.SglReqMsg()

	var_508_0.type = SglMsgType_pb.PB_TYPE_USER_VOTE_RECORD
	var_508_0.Extensions[User_pb.SglUserMsg.user_vote_record_req] = arg_508_0

	var_0_0.sendProtoMsg(var_508_0)
end

function var_0_0.sendGetVoteShopCount(arg_509_0)
	local var_509_0 = SglMsg_pb.SglReqMsg()

	var_509_0.type = SglMsgType_pb.PB_TYPE_SHOP_VOTE_COUNT
	var_509_0.Extensions[Shop_pb.SglShopMsg.shop_vote_count_req] = arg_509_0

	var_0_0.sendProtoMsg(var_509_0)
end

function var_0_0.sendCardRecall(arg_510_0, arg_510_1)
	local var_510_0 = SglMsg_pb.SglReqMsg()

	var_510_0.type = SglMsgType_pb.PB_TYPE_SHOP_RECYCLE

	local var_510_1 = var_510_0.Extensions[Shop_pb.SglShopMsg.shop_recycle_req]

	var_510_1.key = arg_510_0
	var_510_1.value = arg_510_1

	var_0_0.sendProtoMsg(var_510_0)
end

function var_0_0.sendUnlockTroop()
	local var_511_0 = SglMsg_pb.SglReqMsg()

	var_511_0.type = SglMsgType_pb.PB_TYPE_TROOP_UNLOCK

	var_0_0.sendProtoMsg(var_511_0)
end

function var_0_0.sendCharBreakOut(arg_512_0)
	local var_512_0 = SglMsg_pb.SglReqMsg()

	var_512_0.type = SglMsgType_pb.PB_TYPE_USER_BREAK_OUT
	var_512_0.Extensions[User_pb.SglUserMsg.user_break_out_req] = arg_512_0

	var_0_0.sendProtoMsg(var_512_0)
end

function var_0_0.sendIsNewRound(arg_513_0)
	local var_513_0 = SglMsg_pb.SglReqMsg()

	var_513_0.type = SglMsgType_pb.PB_TYPE_USER_DYNAMIC_TIMEOUT
	var_513_0.Extensions[User_pb.SglUserMsg.user_dynamic_timeout_req] = arg_513_0

	var_0_0.sendProtoMsg(var_513_0)
end

function var_0_0.sendRubSkill(arg_514_0, arg_514_1)
	local var_514_0 = SglMsg_pb.SglReqMsg()

	var_514_0.type = SglMsgType_pb.PB_TYPE_CARD_RUBBING

	local var_514_1 = var_514_0.Extensions[Card_pb.SglCardMsg.rubbing_card_req]

	var_514_1.card_id = arg_514_0
	var_514_1.rubbing_id = arg_514_1

	var_0_0.sendProtoMsg(var_514_0)
end

function var_0_0.sendUnRubSkill(arg_515_0)
	local var_515_0 = SglMsg_pb.SglReqMsg()

	var_515_0.type = SglMsgType_pb.PB_TYPE_CARD_UNRUBBING
	var_515_0.Extensions[Card_pb.SglCardMsg.card_unrubbing_req] = arg_515_0

	var_0_0.sendProtoMsg(var_515_0)
end

function var_0_0.sendRemoveRubSkill(arg_516_0)
	local var_516_0 = SglMsg_pb.SglReqMsg()

	var_516_0.type = SglMsgType_pb.PB_TYPE_CARD_REMOVERUBBING
	var_516_0.Extensions[Card_pb.SglCardMsg.card_remove_rubbing_req] = arg_516_0

	var_0_0.sendProtoMsg(var_516_0)
end

function var_0_0.saveBattleTimingInfo(arg_517_0, arg_517_1)
	if var_0_0._battleRoundStartInfo and B.getSmallRound(var_0_0._battleRoundStartInfo._isAttacker, var_0_0._battleRoundStartInfo._round) >= B.getSmallRound(arg_517_1, arg_517_0._target) then
		return
	end

	var_0_0._battleRoundStartInfo = {
		_round = arg_517_0._target,
		_isAttacker = arg_517_1,
		_beginTime = arg_517_0._timestamp,
		_endTime = arg_517_0._timestamp2
	}
end

Str = var_0_0.str
ClientData = var_0_0
