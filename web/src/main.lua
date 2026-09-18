local function var_0_0()
	collectgarbage("setpause", 100)
	collectgarbage("setstepmul", 5000)
end

local function var_0_1(arg_2_0, arg_2_1)
	local var_2_0 = cc.EventCustom:new(Data.Event.application)

	var_2_0:setUserString("INIT_PROGRESS_" .. arg_2_0)
	lc.Dispatcher:dispatchEvent(var_2_0)
	performWithDelay(lc.Director:getRunningScene(), arg_2_1, 0.01)
end

local function var_0_2(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0[arg_3_1], arg_3_0[arg_3_2] = arg_3_0[arg_3_2], arg_3_0[arg_3_1]
end

local function var_0_3(arg_4_0)
	local var_4_0 = #arg_4_0

	while var_4_0 > 1 do
		local var_4_1 = math.random(var_4_0)

		var_0_2(arg_4_0, var_4_1, var_4_0)

		var_4_0 = var_4_0 - 1
	end
end

local function var_0_4()
	ClientView.init()

	local var_5_0

	if TEST_BATTLE_MODE then
		local var_5_1 = tonumber(TEST_BATTLE_MODE)
		local var_5_2 = ClientData._cfg and ClientData._cfg.battleReview ~= nil and ClientData._cfg.battleReview > 0

		ClientData.loadLCRes("res/avatar.lcres")
		ClientData.loadLCRes("res/general.lcres")
		ClientData.loadLCRes("res/battle.lcres")

		if var_5_2 then
			ClientData.loadLCRes("res/cards_img_1.lcres")
			ClientData.loadLCRes("res/cards_back.lcres")
		else
			for iter_5_0 = 1, ClientData.CARDS_IMG_COUNT do
				ClientData.loadLCRes("res/cards_img_" .. iter_5_0 .. ".lcres")
			end

			ClientData.loadLCRes("res/cards_back.lcres")
			ClientData.loadLCRes("res/cards_back2.lcres")
			ClientData.loadLCRes("res/cards_back3.lcres")
			ClientData.loadLCRes("res/cards_back4.lcres")
			ClientData.loadLCRes("res/props.lcres")

			ClientData._dragonBonesTexture = {}

			local var_5_3 = {
				"xuanzhong",
				"kapaisiwang",
				"beiji"
			}

			for iter_5_1, iter_5_2 in ipairs(var_5_3) do
				ClientData._dragonBonesTexture[iter_5_2] = 1
			end

			require("IconWidget")
		end

		P._id = 0
		P._level = 50
		P._vip = 4
		P._guideID = 20000
		P._cardBackId = 7601
		P._avatar = 1

		local var_5_4 = lc.App:loadRes("res/test.lcres")

		local function var_5_5(arg_6_0)
			local var_6_0 = lc.App:getBinData(arg_6_0)

			if var_6_0 == nil then
				var_6_0 = lc.readFile(arg_6_0)
			end

			return var_6_0
		end

		if TEST_BATTLE_PARAM == "auto" then
			ClientData._isAutoTesting = true
			ClientData._infoIds = {}

			for iter_5_3, iter_5_4 in pairs(Data._monsterInfo) do
				if iter_5_4._isHide == 0 then
					ClientData._infoIds[#ClientData._infoIds + 1] = iter_5_3
				end
			end

			for iter_5_5, iter_5_6 in pairs(Data._magicInfo) do
				if iter_5_6._isHide == 0 then
					ClientData._infoIds[#ClientData._infoIds + 1] = iter_5_5
				end
			end

			for iter_5_7, iter_5_8 in pairs(Data._trapInfo) do
				if iter_5_8._isHide == 0 then
					ClientData._infoIds[#ClientData._infoIds + 1] = iter_5_7
				end
			end

			var_0_3(ClientData._infoIds)

			ClientData._infoIdIndex = 1
			Data._testInfo = dataparser.parseData(var_5_5("test.bin"), false)
		elseif var_5_1 == Data.BattleType.test_story then
			Data._testInfo = dataparser.parseData(var_5_5(TEST_BATTLE_PARAM or "teststory.bin"), false)
		elseif var_5_1 == Data.BattleType.replay then
			local var_5_6 = Data_pb.BattleSpot()

			var_5_6:ParseFromString(var_5_5(TEST_BATTLE_PARAM or "replay.bin"))

			Data._testInfo = var_5_6
		elseif var_5_1 == Data.BattleType.boss then
			Data._testInfo = dataparser.parseData(var_5_5("test.bin"), false)
		elseif var_5_1 == Data.BattleType.test then
			if TEST_BATTLE_PARAM == nil or TEST_BATTLE_PARAM == "" then
				TEST_BATTLE_PARAM = "test.bin"
			end

			Data._testInfo = dataparser.parseData(var_5_5(TEST_BATTLE_PARAM), false)
		end

		local var_5_7

		if var_5_1 == Data.BattleType.guidance then
			var_5_7 = ClientData.genInputFromGuidance(1)
		elseif var_5_1 == Data.BattleType.test or var_5_1 == Data.BattleType.test_story or var_5_1 == Data.BattleType.PVP_union then
			var_5_7 = ClientData.genInputFromTest(var_5_1)
		elseif var_5_1 == Data.BattleType.unittest then
			var_5_7 = ClientData.genInputFromUnitTest()
		elseif var_5_1 == Data.BattleType.boss then
			var_5_7 = ClientData.genInputFromTest(var_5_1, tonumber(TEST_BATTLE_PARAM))
		elseif var_5_1 == Data.BattleType.replay then
			var_5_7 = ClientData.genInputFromReplayResp(Data._testInfo)
		end

		local var_5_8 = var_5_7._sceneType

		ClientData.loadLCRes(string.format("res/bat_scene_%d.lcres", var_5_8))

		ClientData._userRegion = {
			_id = 8001
		}
		ClientData._isTesting = true
		var_5_7._isTesting = true
		var_5_7._speedFactor = 1

		if var_5_1 == Data.BattleType.unittest then
			var_5_0 = require("BattleTestScene").create()
		else
			var_5_0 = require("BattleScene").create(var_5_7)
		end
	else
		local var_5_9 = true

		if var_5_9 then
			if lc.PLATFORM ~= cc.PLATFORM_OS_WINDOWS or lc.App:getRedirectGameServer() ~= "DEV" then
				ClientData._regions = {}

				ClientData.saveUserRegion()
			end

			ClientData.loadUserRegion()
			ClientData.unloadLoadingRes(true)
			lc.File:purgeCachedEntries()

			-- Account authentication is intentionally the first interactive step.
			-- A saved region is only a connection hint; using it to jump directly
			-- into LoadingScene loses the password-based account context after an
			-- app restart and silently falls back to device login.
			var_5_0 = require("RegionScene").create()
		else
			ClientData._regions = {}

			ClientData.saveUserRegion()

			var_5_0 = require("VideoScene").create()
		end
	end

	var_5_0:retain()

	ClientView._scene = var_5_0

	var_0_1(100, function()
		lc.replaceScene(ClientView._scene)
		ClientView._scene:release()
	end)
end

local function var_0_5()
	lc.Audio.loadAudioConfig("res/audio/audioInfo.plist")
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 6)))
	ClientData.init()
	var_0_1(80, function()
		var_0_4()
	end)
end

local function var_0_6()
	lc.App:loadRes("res/lan.lcres")
	var_0_1(60, function()
		var_0_5()
	end)
end

local var_0_7 = bit.bxor
local var_0_8 = {
	__index = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0._ek2[arg_12_1]
		local var_12_1 = arg_12_0._ek3[arg_12_1]

		if var_12_0 ~= nil then
			local var_12_2 = arg_12_0[arg_12_1 .. var_12_0]

			return var_0_7(var_12_2, arg_12_0._ek1) - var_12_0
		elseif var_12_1 ~= nil then
			local var_12_3 = arg_12_0[arg_12_1 .. var_12_1]
			local var_12_4 = {}

			for iter_12_0 = 1, #var_12_3 do
				var_12_4[iter_12_0] = var_0_7(var_12_3[iter_12_0], arg_12_0._ek1) - var_12_1
			end

			return var_12_4
		else
			return nil
		end
	end
}

local function var_0_9(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in pairs(arg_13_0) do
		iter_13_1._ek1 = math.random(65536)
		iter_13_1._ek2 = {}
		iter_13_1._ek3 = {}

		for iter_13_2 = 1, #arg_13_1 do
			local var_13_0 = arg_13_1[iter_13_2]
			local var_13_1 = math.random(65536)

			iter_13_1._ek2[var_13_0] = var_13_1
			iter_13_1[var_13_0 .. var_13_1] = var_0_7(iter_13_1[var_13_0] + var_13_1, iter_13_1._ek1)
			iter_13_1[var_13_0] = nil
		end

		for iter_13_3 = 1, #arg_13_2 do
			local var_13_2 = arg_13_2[iter_13_3]
			local var_13_3 = math.random(65536)

			iter_13_1._ek3[var_13_2] = var_13_3

			local var_13_4 = iter_13_1[var_13_2]
			local var_13_5 = {}

			for iter_13_4 = 1, #var_13_4 do
				var_13_5[iter_13_4] = var_0_7(var_13_4[iter_13_4] + var_13_3, iter_13_1._ek1)
			end

			iter_13_1[var_13_2 .. var_13_3] = var_13_5
			iter_13_1[var_13_2] = nil
		end

		setmetatable(iter_13_1, var_0_8)
	end
end

local function var_0_10()
	local var_14_0 = lc.App:loadRes("res/data.lcres")

	for iter_14_0 = 1, #var_14_0 do
		local var_14_1 = var_14_0[iter_14_0]

		if string.hasSuffix(var_14_1, ".bin") then
			Data.parseData(var_14_1, lc.App:getBinData(var_14_1))
			lc.App:unloadRes(var_14_1)
		end
	end

	for iter_14_1, iter_14_2 in pairs(Data._activityNewInfo) do
		Data._activityInfo[iter_14_1] = iter_14_2
	end

	Data._activityNewInfo = nil

	var_0_9(Data._monsterInfo, {
		"_category",
		"_nature",
		"_keyword",
		"_quality",
		"_cost",
		"_star"
	}, {
		"_skillId",
		"_atk",
		"_hp"
	})
	var_0_9(Data._magicInfo, {
		"_type",
		"_keyword",
		"_quality"
	}, {
		"_skillId"
	})
	var_0_9(Data._trapInfo, {
		"_type",
		"_keyword",
		"_quality"
	}, {
		"_skillId"
	})
	var_0_9(Data._rareInfo, {
		"_category",
		"_nature",
		"_keyword",
		"_quality",
		"_cost",
		"_star"
	}, {
		"_skillId",
		"_atk",
		"_hp"
	})
	var_0_9(Data._skillInfo, {}, {
		"_val"
	})
	var_0_1(50, function()
		var_0_6()
	end)
end

local function var_0_11()
	require("TcpDebug")
	require("Cocos2d")
	require("Cocos2dConstants")
	require("OpenglConstants")
	require("GuiConstants")
	require("experimentalConstants")
	require("json")
	require("leocool")
	require("SglMsgType_pb")
	require("SglMsg_pb")
	require("Auth_pb")
	require("User_pb")
	require("City_pb")
	require("World_pb")
	require("Battle_pb")
	require("Troop_pb")
	require("Card_pb")
	require("Friend_pb")
	require("Mail_pb")
	require("Chat_pb")
	require("Buy_pb")
	require("Shop_pb")
	require("Bonus_pb")
	require("News_pb")
	require("Rank_pb")
	require("Feedback_pb")
	require("Region_pb")
	require("Union_pb")
	require("UnionWar_pb")
	require("Socket_pb")
	require("Data")
	require("GitVersion")
	require("ClientData")
	require("ClientView")
	require("TextureManager")
	require("ToastManager")
	require("GuideManager")
	require("NoticeManager")
	require("AudioEnums")
	require("StringEnums")
	require("UserWidget")
	require("CardHelper")
	require("BattleData")
	require("PlayerBattle")
	require("BattleHelper")
	require("BattleStaticHelper")
	require("BattleSkillCompiler")
	require("BattleCombination")
	require("BattleSkill")
	require("BattleStep")
	require("BattleCondition")
	require("BattleCard")
	require("BattleCardStatus")
	require("BattleEvent")
	require("BattleAi")
	require("BattleTestData")
	require("BattleScene")
	require("BattleUi")
	require("BattleUiTouch")
	require("BattleUiView")
	require("PlayerUi")
	require("SkillUi")
	require("StatusUi")
	require("CardSprite")
	require("BattleAudio")
	require("BattleLine")
	require("GuideUi")
	require("Particle")
	require("DragonBones")
	require("BattleDialog")
	require("BattleCardInfoDialog")
	require("BattleChatDialog")
	require("BattleEventDialog")
	require("BattleHelpDialog")
	require("BattlePVPDialog")
	require("BattleSettingDialog")
	require("BattleTaskDialog")
	require("BattleResultDialog")
	require("BattleListDialog")
	require("BattlePosDialog")
	var_0_1(40, function()
		var_0_10()
	end)
end

var_0_0()

local var_0_12 = {}
local var_0_13 = 3

function __G__TRACKBACK__(arg_18_0)
	local var_18_0 = string.format("[LUA ERROR]: <Sid:%s V:%s T:%s> %s\n%s ", lc._runningScene and lc._runningScene._sceneId or "NA", ClientData.getDisplayVersion(), os.date(), tostring(arg_18_0), debug.traceback())

	lc.log(var_18_0)

	if #var_0_12 == var_0_13 then
		table.remove(var_0_12, 1)
	end

	table.insert(var_0_12, var_18_0)

	local var_18_1 = ""

	for iter_18_0, iter_18_1 in ipairs(var_0_12) do
		var_18_1 = var_18_1 .. "\n" .. iter_18_1
	end

	local var_18_2 = string.format("region:%s, id:%s", ClientData._userRegion and ClientData._userRegion._id or "NA", P and P._id or "NA")

	lc.log(var_18_2 .. "\n" .. var_18_1)

	-- File sink: logcat rotates too fast to keep Lua errors, so persist the
	-- full message to the writable path where adb can pull it.
	pcall(function()
		local var_18_8 = io.open(lc.File:getWritablePath() .. "lua_error.log", "a")
		if var_18_8 then
			var_18_8:write(os.date("%H:%M:%S ") .. var_18_2 .. "\n" .. var_18_0 .. "\n" .. var_18_1 .. "\n\n")
			var_18_8:close()
		end
	end)

	if lc.PLATFORM ~= cc.PLATFORM_OS_WINDOWS then
		onLuaException(var_18_2, var_18_1)
	end

	if ClientData._reportBattleDebugLog then
		if ClientView.isInBattleScene() then
			local var_18_3 = var_18_0
			local var_18_4 = string.gsub(var_18_3, "'", "")
			local var_18_5 = string.gsub(var_18_4, "\"", "")
			local var_18_6 = string.gsub(var_18_5, "\n", " ")
			local var_18_7 = string.gsub(var_18_6, "\t", " ")

			ClientData.sendUserEvent({
				battleDebugLog = var_18_7
			})
			ClientData.sendBattleDebugLog()
		end

		ClientData._reportBattleDebugLog = false
	end
end

local var_0_14 = _G.require

function _G.require(arg_19_0, arg_19_1, ...)
	if arg_19_1 and lc.PLATFORM == cc.PLATFORM_OS_WINDOWS then
		package.loaded[arg_19_0] = nil
	end

	return var_0_14(arg_19_0, ...)
end

xpcall(var_0_11, __G__TRACKBACK__)
