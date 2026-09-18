local var_0_0 = require("PlayerCard")
local var_0_1 = require("PlayerCity")
local var_0_26 = require("PlayerPalace")
local var_0_2 = require("PlayerWorld")
local var_0_3 = require("PlayerBonus")
local var_0_4 = require("PlayerAchieve")
local var_0_5 = require("PlayerBadge")
local var_0_6 = require("PlayerBadgeEx")
local var_0_7 = require("PlayerBadgeEx2")
local var_0_8 = require("PlayerMarket")
local var_0_9 = require("PlayerMessage")
local var_0_10 = require("PlayerRank")
local var_0_11 = require("PlayerMail")
local var_0_12 = require("PlayerLog")
local var_0_13 = require("PlayerExpedition")
local var_0_14 = require("PlayerUnion")
local var_0_15 = require("UnderAttack")
local var_0_16 = require("PropBag")
local var_0_17 = require("PlayerRoom")
local var_0_18 = require("PlayerFindClash")
local var_0_19 = require("PlayerFindClashEx")
local var_0_20 = require("PlayerFindLadder")
local var_0_21 = require("PlayerFindUnionBattle")
local var_0_22 = require("PlayerFindDark")
local var_0_23 = require("PlayerFindSurvival")
local var_0_24 = require("PlayerFindSurvivalEx")

require("PlayerActivity")
require("json")

local var_0_25 = class("Player")

function var_0_25.ctor(arg_1_0)
	arg_1_0._playerCard = var_0_0.new()
	arg_1_0._playerCity = var_0_1.new()
	arg_1_0._playerPalace = var_0_26.new()
	arg_1_0._playerWorld = var_0_2.new()
	arg_1_0._playerBonus = var_0_3.new()
	arg_1_0._playerAchieve = var_0_4.new()
	arg_1_0._playerMarket = var_0_8.new()
	arg_1_0._playerMessage = var_0_9.new()
	arg_1_0._playerMail = var_0_11.new()
	arg_1_0._playerLog = var_0_12.new()
	arg_1_0._playerRank = var_0_10.new()
	arg_1_0._playerExpedition = var_0_13.new()
	arg_1_0._playerUnion = var_0_14.new()
	arg_1_0._playerActivity = PlayerActivity.new()
	arg_1_0._playerBadge = var_0_5.new()
	arg_1_0._playerBadgeEx = var_0_6.new()
	arg_1_0._playerBadgeEx2 = var_0_7.new()
	arg_1_0._underAttack = var_0_15.new()
	arg_1_0._propBag = var_0_16.new()
	arg_1_0._playerRoom = var_0_17.new()
	arg_1_0._playerFindClash = var_0_18.new()
	arg_1_0._playerFindClashEx = var_0_19.new()
	arg_1_0._playerFindLadder = var_0_20.new()
	arg_1_0._playerFindUnionBattle = var_0_21.new()
	arg_1_0._playerFindDark = var_0_22.new()
	arg_1_0._playerFindSurvival = var_0_23.new()
	arg_1_0._playerFindSurvivalEx = var_0_24.new()
end

function var_0_25.clear(arg_2_0)
	arg_2_0:stopPlayerScheduler()
	arg_2_0._playerCard:clear()
	arg_2_0._playerCity:clear()
	arg_2_0._playerWorld:clear()
	arg_2_0._playerBonus:clear()
	arg_2_0._playerAchieve:clear()
	arg_2_0._playerBadge:clear()
	arg_2_0._playerBadgeEx:clear()
	arg_2_0._playerBadgeEx2:clear()
	arg_2_0._playerMarket:clear()
	arg_2_0._playerMessage:clear()
	arg_2_0._playerMail:clear()
	arg_2_0._playerLog:clear()
	arg_2_0._playerRank:clear()
	arg_2_0._playerExpedition:clear()
	arg_2_0._playerUnion:clear()
	arg_2_0._playerActivity:clear()
	arg_2_0._underAttack:clear()
	arg_2_0._propBag:clear()
	arg_2_0._playerRoom:clear()
	arg_2_0._playerFindClash:clear()
	arg_2_0._playerFindClashEx:clear(true)
	arg_2_0._playerFindSurvival:clear()
	arg_2_0._playerFindSurvivalEx:clear()

	arg_2_0._id = nil
	arg_2_0._guideID = nil
	arg_2_0._dailyActive = nil
	arg_2_0._weekActive = nil
	arg_2_0._inviteCode = nil
	arg_2_0._invitedCode = nil
	arg_2_0._hasEnterCity = nil
	require("User").Users = {}
	require("Union").Unions = {}
	require("Mail").Mails = {}

	require("MarqueeManager").release()

	arg_2_0._voteRecord = {}
end

function var_0_25.init(arg_3_0, arg_3_1)
	arg_3_0._id = arg_3_1.user_info.id

	lc.log("@@@@@@@@ PLAYER ID: %d", arg_3_0._id)

	arg_3_0._sid = ClientData.getUserStringId(ClientData._userRegion._id, arg_3_0._id)

	ClientData.initConfig(arg_3_0._id)

	arg_3_0._unionId = arg_3_1.user_info.union_id
	arg_3_0._unionJob = arg_3_1.user_info.union_title
	arg_3_0._roomId = arg_3_1.user_info.room_id or 0
	arg_3_0._roomJob = arg_3_1.user_info.room_title or Data.RoomJob.rookie

	if arg_3_0:hasUnion() then
		lc.log("@@@@@@@@ UNION ID: %d", arg_3_0._unionId)
	end

	arg_3_0._name = arg_3_1.user_info.name
	arg_3_0._exp = arg_3_1.user_info.exp

	print("EXP:", arg_3_0._exp)

	arg_3_0._level = arg_3_1.user_info.level
	arg_3_0._vip = arg_3_1.user_info.vip
	arg_3_0._vipExp = arg_3_1.user_info.vip_exp
	arg_3_0._trophy = arg_3_1.user_info.trophy
	arg_3_0._avatar = arg_3_1.user_info.avatar
	arg_3_0._loginTime = arg_3_1.user_info.last_login / 1000
	arg_3_0._regTime = arg_3_1.user_info.reg_date / 1000
	arg_3_0._timeOffset = arg_3_1.time_offset / 1000
	arg_3_0._loginTimeTick = ClientData.getServerDateTick()
	arg_3_0._privilege = arg_3_1.user_info.privilege
	arg_3_0._canBind = arg_3_1.can_bind
	arg_3_0._functionSwitch = 0

	if arg_3_1:HasField("function_switch") then
		arg_3_0._functionSwitch = arg_3_1.function_switch
	end

	if arg_3_1.user_info:HasField("code") then
		arg_3_0._invitedCode = arg_3_1.user_info.code
	end

	arg_3_0._inviteIngot = arg_3_1.user_count.invite_charge
	arg_3_0._inviteCount = arg_3_1.user_count.invite_count
	arg_3_0._lastLogin = lc.readConfig(ClientData.ConfigKey.last_login, arg_3_0._loginTime)

	lc.writeConfig(ClientData.ConfigKey.last_login, math.floor(arg_3_0._loginTime))

	_, arg_3_0._dayOfMonth = ClientData.getServerDate()
	arg_3_0._gold = arg_3_1.user_info.gold
	arg_3_0._grain = arg_3_1.user_info.grain
	arg_3_0._ingot = arg_3_1.user_info.ingot
	arg_3_0._achievePoint = arg_3_1.user_info.achievement
	arg_3_0._highestPower = arg_3_1.power or 0
	arg_3_0._serverOpenTime = arg_3_1.server_open_time / 1000
	arg_3_0._serverVersion = arg_3_1.server_version
	arg_3_0._guideID = ClientData.DEBUG_GUIDE_ID or arg_3_1.user_info.guide
	arg_3_0._guideDifficultyID = arg_3_1.user_info.guide1
	arg_3_0._guideRecruiteID = arg_3_1.user_info.guide2

	if arg_3_0._guideDifficultyID == 0 then
		arg_3_0._guideDifficultyID = 10001
	end

	if arg_3_0._guideRecruiteID == 0 then
		arg_3_0._guideRecruiteID = 20001
	end

	lc.log("@@@@@@@@ GUIDE ID: %d %d %d", arg_3_0._guideID, arg_3_0._guideDifficultyID, arg_3_0._guideRecruiteID)

	arg_3_0._activityPoints = 0
	arg_3_0._pvpWinTotal = arg_3_1.user_battle.total_pvp_win
	arg_3_0._pvpTotal = arg_3_0._pvpWinTotal + arg_3_1.user_battle.total_pvp_lose
	arg_3_0._pvpWinDaily = arg_3_1.user_battle.daily_pvp_win
	arg_3_0._pvpDaily = arg_3_0._pvpWinDaily + arg_3_1.user_battle.daily_pvp_lose
	arg_3_0._dailyClashWin = arg_3_1.user_battle.daily_ladder_win
	arg_3_0._ladderContWin = arg_3_1.user_battle.ladder_cont_win
	arg_3_0._ladderContLose = arg_3_1.user_battle.ladder_cont_lose
	-- UserLottery is optional in the recovered server response.  Keep the
	-- dependent screens usable until a populated lottery record arrives.
	local var_3_0 = arg_3_1.user_lottery or {}
	arg_3_0._lotteryNextFree = {}

	for iter_3_0 = 1, #(var_3_0.next_free or {}) do
		arg_3_0._lotteryNextFree[iter_3_0] = var_3_0.next_free[iter_3_0] / 1000
	end

	local var_3_1 = var_3_0.next_quality or 1

	if var_3_1 < 1 then
		var_3_1 = 1
	elseif var_3_1 > 5 then
		var_3_1 = 5
	end

	arg_3_0._bookLotteryQuality = var_3_1
	arg_3_0._legendBoxOpenTimes = var_3_0.nchest or 0
	arg_3_0._legendBoxOpenRemainTimes = var_3_0.nchest_ex or 0
	arg_3_0._bloodJade = var_3_0.point or 0
	arg_3_0._dailyBuyOrangeHeroFBox = arg_3_1.user_count.buy_chest1
	arg_3_0._dailyBuyPurpleHeroFBox = arg_3_1.user_count.buy_chest2
	arg_3_0._dailyBuyOrangeHorseFBox = arg_3_1.user_count.buy_chest3
	arg_3_0._dailyBuyPurpleHorseFBox = arg_3_1.user_count.buy_chest4
	arg_3_0._dailyBuyHeroExp = arg_3_1.user_count.buy_hero_exp
	arg_3_0._dailyBuyEquipExp = arg_3_1.user_count.buy_equip_exp
	arg_3_0._dailyBuyHorseExp = arg_3_1.user_count.buy_horse_exp
	arg_3_0._dailyBuyBookExp = arg_3_1.user_count.buy_book_exp
	arg_3_0._dailyBuyStone = arg_3_1.user_count.buy_stone
	arg_3_0._dailyBuyRemedy = arg_3_1.user_count.buy_remedy
	arg_3_0._dailyBuyGold = arg_3_1.user_count.buy_gold
	arg_3_0._dailyBuyGrain = arg_3_1.user_count.buy_grain
	arg_3_0._dailyBuyRefresh = arg_3_1.user_count.buy_refresh
	arg_3_0._dailyBuyRefreshPvp = arg_3_1.user_count.buy_refresh_pvp
	arg_3_0._dailyBuyRefreshUnion = arg_3_1.user_count.buy_refresh_union
	arg_3_0._dailyBuyRefreshLadder = arg_3_1.user_count.buy_refresh_ladder
	arg_3_0._dailyBuyCopyExpedition = arg_3_1.user_count.buy_expedition
	arg_3_0._dailyLotteryPackageCount = arg_3_1.user_count.buy_elite
	arg_3_0._dailyBuyCopyBoss = arg_3_1.user_count.buy_rob_exp
	arg_3_0._dailyBuyCopyCommander = arg_3_1.user_count.buy_commander
	arg_3_0._dailyCopyBoss = arg_3_1.user_count.rob_gold
	arg_3_0._dailyDonate = band(arg_3_1.user_count.donate, 128) / 128
	arg_3_0._dailyIngotDonate = band(arg_3_1.user_count.donate, 127)
	arg_3_0._dailyWorship = arg_3_1.user_count.worship
	arg_3_0._dailyChallengeElite = arg_3_1.user_count.challenge_elite
	arg_3_0._dailyChallengeCommander = arg_3_1.user_count.challenge_commander
	arg_3_0._dailyTrophy = arg_3_1.user_count.trophy
	arg_3_0._dailyExpedition = arg_3_1.user_count.expedition
	arg_3_0._dailySendMail = arg_3_1.user_count.send_mail
	arg_3_0._dailyClaimedGold = arg_3_1.user_count.gold
	arg_3_0._dailyNextSpawn = arg_3_1.user_count.next_spawn / 1000

	if arg_3_0._dailyClaimedGold == 0 then
		arg_3_0._dailyClaimedGold = nil
	end

	arg_3_0._dailyCollectedGold = arg_3_1.user_count.collect_gold

	print("@@@@@@@@ COLLECTED GOLD:", arg_3_0._dailyCollectedGold)

	arg_3_0._dailyWorldBoss = arg_3_1.user_count.atk_boss
	arg_3_0._dailyBuyWorldBoss = arg_3_1.user_count.buy_atk_boss
	arg_3_0._worldBossScore = arg_3_1.user_battle.boss_score
	arg_3_0._dailyResetLadder = arg_3_1.user_count.reset_ladder
	arg_3_0._nextCityHelp = arg_3_1.user_count.next_sos / 1000
	arg_3_0._monthlyRecheck = arg_3_1.user_count.re_check
	arg_3_0._serverOpenTimestamp = arg_3_1.open_time / 1000
	arg_3_0._newRegionCloseTimestamp = arg_3_0._serverOpenTimestamp + Data.NEW_REGION_DAYS * Data.DAY_SECONDS
	arg_3_0._unionFundFlag = arg_3_1.user_count.welfare
	arg_3_0._changeNameCount = arg_3_1.user_count.edit_name
	arg_3_0._nextShareBattle = arg_3_1.user_count.next_share / 1000
	arg_3_0._nextChat = arg_3_1.user_count.next_chat / 1000
	arg_3_0._nextCopyPvp = arg_3_1.user_count.next_find / 1000
	arg_3_0._unlockCopyPvpTimes = arg_3_1.user_count.buy_refresh_find
	arg_3_0._dailyCopyPvpTimes = arg_3_1.user_count.atk_player

	local var_3_0 = arg_3_1.user_count.atk_uboss
	local var_3_1 = {}

	for iter_3_1, iter_3_2 in pairs(Data._unionBossInfo) do
		var_3_1[iter_3_1] = band(brsh(var_3_0, (iter_3_1 - 100 - 1) * 2), 3)
	end

	arg_3_0._dailyChallengeUBoss = var_3_1
	arg_3_0._grace = arg_3_1.user_count.grace

	if arg_3_1.user_count.month_card / 1000 > arg_3_0._loginTime then
		arg_3_0._monthCardDay1 = math.ceil((arg_3_1.user_count.month_card / 1000 - arg_3_0._loginTime) / Data.DAY_SECONDS)
	else
		arg_3_0._monthCardDay1 = 0
	end

	if arg_3_1.user_count.month_card_ex / 1000 > arg_3_0._loginTime then
		arg_3_0._monthCardDay2 = math.ceil((arg_3_1.user_count.month_card_ex / 1000 - arg_3_0._loginTime) / Data.DAY_SECONDS)
	else
		arg_3_0._monthCardDay2 = 0
	end

	arg_3_0._firstIngotRecharge = arg_3_1.user_count.charge
	arg_3_0._ingotDailyRecharge = arg_3_1.user_count.daily_charge
	arg_3_0._systemAnnouncement = {}

	if #arg_3_1.announcement > 0 then
		local var_3_2 = json.decode(arg_3_1.announcement)

		for iter_3_3, iter_3_4 in ipairs(var_3_2) do
			table.insert(arg_3_0._systemAnnouncement, {
				_title = iter_3_4.title,
				_content = iter_3_4.content,
				_timestamp = arg_3_1.time_of_ann / 1000
			})
		end
	end

	for iter_3_5, iter_3_6 in ipairs(arg_3_0._systemAnnouncement) do
		iter_3_6._content = string.gsub(iter_3_6._content, "\\n", "\n")
	end

	local var_3_3 = arg_3_1.attach.character

	arg_3_0._isNewRound = var_3_3.is_dynamic_timeout
	arg_3_0._characters = {}

	for iter_3_7, iter_3_8 in pairs(Data._characterInfo) do
		local var_3_4 = {
			_level = 0,
			_exp = 0,
			_id = iter_3_7,
			_avatar = iter_3_7 * 100 + 1
		}

		arg_3_0._characters[iter_3_7] = var_3_4
	end

	for iter_3_9 = 1, #var_3_3.chars do
		local var_3_5 = var_3_3.chars[iter_3_9]
		local var_3_6 = {
			_id = var_3_5.id,
			_level = var_3_5.level,
			_exp = var_3_5.exp,
			_avatar = var_3_5.avatar,
			_skinId = var_3_5.skin,
			_breakOut = var_3_5.break_out
		}

		print("@@@@@@@@ CHARACTER:", var_3_6._id, Str(Data._characterInfo[var_3_6._id]._nameSid), var_3_6._avatar, var_3_6._level, var_3_6._exp, var_3_6._skinId)

		arg_3_0._characters[var_3_6._id] = var_3_6
	end

	local var_3_7 = arg_3_0._characters[arg_3_0:getCharacterId()]

	print("cur CHARACTER id: ", arg_3_0:getCharacterId(), "CHARACTER EXP: ", var_3_7._exp)

	arg_3_0._isDefending = false
	arg_3_0._baseHp = 500
	arg_3_0._status = 0

	arg_3_0._playerBonus:init(arg_3_1.attach.bonus)
	arg_3_0._playerActivity:init(arg_3_1.attach.activity)
	arg_3_0._playerBadge:init(arg_3_1.attach.activity)
	arg_3_0._playerBadgeEx:init(arg_3_1.attach.activity)
	arg_3_0._playerBadgeEx2:init(arg_3_1.attach.activity)
	arg_3_0._playerFindLadder:init(arg_3_1.attach.ladder)
	arg_3_0._playerFindClashEx:init(arg_3_1.attach.ladder)
	arg_3_0._playerFindDark:init(arg_3_1.attach.dark)
	arg_3_0._playerFindSurvival:init(arg_3_1.attach.survival)
	arg_3_0._playerFindSurvivalEx:init(arg_3_1.attach.survival_ex)
	arg_3_0._playerCard:init(arg_3_1.card)
	arg_3_0._playerCity:init(arg_3_1.city)
	arg_3_0._playerWorld:init(arg_3_1.world)
	arg_3_0._propBag:init(arg_3_1.attach.prop)

	arg_3_0._troopRemarks = {}

	for iter_3_10, iter_3_11 in ipairs(arg_3_1.attach.prop.marks) do
		table.insert(arg_3_0._troopRemarks, iter_3_11)
	end

	arg_3_0._playerMarket:init(arg_3_1.attach.shop)
	arg_3_0._playerAchieve:init()

	if arg_3_1:HasField("union") then
		arg_3_0._playerUnion:initBase(arg_3_1.union)
	end

	arg_3_0._avatarFrameId = arg_3_1.user_info.avatar_frame

	if arg_3_0._avatarFrameId == 0 then
		_, arg_3_0._avatarFrameId = arg_3_0._propBag:validPropId(Data.PropsId.avatar_frame)
	end

	arg_3_0._cardBackId = arg_3_1.user_info.card_back

	if arg_3_0._cardBackId == 0 then
		arg_3_0._cardBackId = Data.PropsId.card_back
	end

	arg_3_0._crown = nil

	if arg_3_1.user_info and arg_3_1.user_info:HasField("crown") then
		arg_3_0._crown = {
			_infoId = arg_3_1.user_info.crown.info_id,
			_num = arg_3_1.user_info.crown.num
		}
	end

	if (arg_3_0._crown == nil or arg_3_0._crown._infoId == 0) and ClientData and ClientData._account then
		local gc = tonumber(ClientData._account.gold_cup) or 0
		local sc = tonumber(ClientData._account.silver_cup) or 0
		local bc = tonumber(ClientData._account.bronze_cup) or 0
		if gc > 0 then
			arg_3_0._crown = { _infoId = 7204, _num = gc }
		elseif sc > 0 then
			arg_3_0._crown = { _infoId = 7205, _num = sc }
		elseif bc > 0 then
			arg_3_0._crown = { _infoId = 7206, _num = bc }
		end
	end

	arg_3_0._legendCrown = nil

	if arg_3_1.user_info:HasField("legend_crown") then
		arg_3_0._legendCrown = {
			_infoId = arg_3_1.user_info.legend_crown.info_id,
			_num = arg_3_1.user_info.legend_crown.num
		}
	end

	arg_3_0._copyPassTimes, arg_3_0._copyScore = {}, {}

	for iter_3_12, iter_3_13 in pairs(Data._copyInfo) do
		arg_3_0._copyPassTimes[iter_3_12] = 0
		arg_3_0._copyScore[iter_3_12] = 0
	end

	for iter_3_14, iter_3_15 in ipairs(arg_3_1.attach.copy.copies) do
		arg_3_0._copyPassTimes[iter_3_15.id] = iter_3_15.value
		arg_3_0._copyScore[iter_3_15.id] = iter_3_15.score

		print("@@@@@@@@ COPY: ", iter_3_15.id, iter_3_15.value, iter_3_15.score)
	end

	arg_3_0._chatBanList = {}

	for iter_3_16, iter_3_17 in ipairs(arg_3_1.ban_chat) do
		arg_3_0._chatBanList[iter_3_17] = true
	end

	arg_3_0._curTroopIndex = lc.readConfig(ClientData.ConfigKey.cur_troop, 1)

	if arg_3_0._curTroopIndex < 1 or arg_3_0._curTroopIndex > arg_3_0:getMaxTroopCount() then
		arg_3_0._curTroopIndex = 1

		lc.writeConfig(ClientData.ConfigKey.cur_troop, arg_3_0._curTroopIndex)
	end

	if lc.readConfig(ClientData.ConfigKey.lock_level_city) == nil then
		lc.writeConfig(ClientData.ConfigKey.lock_level_city, arg_3_0._level)
	end

	if lc.readConfig(ClientData.ConfigKey.lock_level_split) == nil then
		lc.writeConfig(ClientData.ConfigKey.lock_level_split, arg_3_0._level)
	end

	if lc.readConfig(ClientData.ConfigKey.lock_level_equip) == nil then
		lc.writeConfig(ClientData.ConfigKey.lock_level_equip, arg_3_0._level)
	end

	if lc.readConfig(ClientData.ConfigKey.lock_level_herocenter) == nil then
		lc.writeConfig(ClientData.ConfigKey.lock_level_herocenter, arg_3_0._level)
	end

	if lc.readConfig(ClientData.ConfigKey.lock_level_battle) == nil then
		lc.writeConfig(ClientData.ConfigKey.lock_level_battle, arg_3_0._level)
	end

	if lc.readConfig(ClientData.ConfigKey.lock_level_vip) == nil then
		lc.writeConfig(ClientData.ConfigKey.lock_level_vip, arg_3_0._level)
	end

	ClientData.togglePos(lc.UserDefault:getBoolForKey(ClientData.ConfigKey.pos_on, false) and P:getMaxCharacterLevel() >= ClientData.POS_UNLOCK_LEVEL)

	local var_3_8 = lc.App:getChannelName()

	if var_3_8 == "APPSTORE" or var_3_8 == "FACEBOOK" then
		local var_3_9 = ClientData.getSubChannelName()
		local var_3_10 = {
			subChannel = var_3_9,
			day = P:getDayDiff()
		}

		ClientData.sendUserEvent(var_3_10)
		ClientData.submitRoleData("")
	elseif var_3_8 == "UC" then
		ClientData.submitRoleData("loginGameRole")
	elseif var_3_8 == "ASDK" then
		if #arg_3_0._name ~= 0 and arg_3_0._guideID >= 103 then
			ClientData.submitRoleData("0")
		end

		local var_3_11 = ClientData.getSubChannelName()
		local var_3_12 = {
			subChannel = var_3_11,
			day = P:getDayDiff()
		}

		ClientData.sendUserEvent(var_3_12)
	else
		ClientData.submitRoleData("")
	end

	ClientData._worldDisplay = Data.WorldDisplay.normal
	ClientData._worldDisplayCity = Data.WorldDisplay.normal
	arg_3_0._playerSchedulerID = lc.Scheduler:scheduleScriptFunc(function(arg_4_0)
		arg_3_0:scheduler(arg_4_0)
	end, 1, false)
end

function var_0_25.hasUnion(arg_5_0)
	return arg_5_0._unionId and arg_5_0._unionId > 0
end

function var_0_25.scheduler(arg_6_0, arg_6_1)
	arg_6_0._playerRank:scheduler(arg_6_1)
end

function var_0_25.stopPlayerScheduler(arg_7_0)
	if arg_7_0._playerSchedulerID ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_7_0._playerSchedulerID)

		arg_7_0._playerSchedulerID = nil
	end
end

function var_0_25.setCurrentTroopIndex(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._curTroopIndex == arg_8_1 and not arg_8_2 then
		return false
	end

	if arg_8_1 < 1 or arg_8_1 > arg_8_0:getMaxTroopCount() then
		return false
	end

	arg_8_0._curTroopIndex = arg_8_1

	lc.writeConfig(ClientData.ConfigKey.cur_troop, arg_8_1)

	return true
end

function var_0_25.hasPrivilege(arg_9_0, arg_9_1)
	return band(arg_9_0._privilege, arg_9_1) ~= 0
end

function var_0_25.isUserAdmin(arg_10_0)
	return arg_10_0._privilege == bor(Data.Privilege.chat_ban, Data.Privilege.mail_free)
end

function var_0_25.setUnionFundValid(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0._unionFundFlag = bor(arg_11_0._unionFundFlag, 2)
	else
		arg_11_0._unionFundFlag = band(arg_11_0._unionFundFlag, bnot(2))
	end
end

function var_0_25.isUnionFundValid(arg_12_0)
	return band(arg_12_0._unionFundFlag, 2) ~= 0
end

function var_0_25.givenUnionFund(arg_13_0)
	arg_13_0._unionFundFlag = bor(arg_13_0._unionFundFlag, 1, 2)
end

function var_0_25.getDayDiff(arg_14_0)
	local var_14_0 = math.floor((P._regTime + 28800) / Data.DAY_SECONDS)

	return math.floor((P._loginTime + 28800) / Data.DAY_SECONDS) - var_14_0
end

function var_0_25.getItemCount(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = Data.getType(arg_15_1)

	if var_15_0 == Data.CardType.res then
		if arg_15_1 == Data.ResType.gold then
			return arg_15_0._gold
		elseif arg_15_1 == Data.ResType.grain then
			return arg_15_0._grain
		elseif arg_15_1 == Data.ResType.ingot then
			return arg_15_0._ingot
		elseif arg_15_1 == Data.ResType.clash_trophy then
			return P._playerFindClash._trophy
		elseif arg_15_1 == Data.ResType.ladder_trophy then
			return arg_15_0._playerFindClash._ladderTrophy
		elseif arg_15_1 == Data.ResType.clash_ex_trophy then
			return arg_15_0._playerFindClashEx._trophy
		elseif arg_15_1 == Data.ResType.exp then
			return arg_15_0._exp
		elseif arg_15_1 == Data.ResType.blood_jade then
			return arg_15_0._bloodJade
		elseif arg_15_1 == Data.ResType.union_personal_power then
			return arg_15_0._dailyActive
		elseif arg_15_1 == Data.ResType.union_battle_trophy then
			return arg_15_0._playerUnion._battleTrophy
		elseif arg_15_1 == Data.ResType.dark_trophy then
			return arg_15_0._playerFindDark._trophy
		elseif arg_15_1 == Data.ResType.survival_ex_trophy then
			return arg_15_0._playerFindSurvivalEx._trophy
		elseif arg_15_0:hasUnion() then
			local var_15_1 = arg_15_0._playerUnion:getMyUnion()

			if arg_15_1 == Data.ResType.union_act then
				return var_15_1._act
			elseif arg_15_1 == Data.ResType.union_gold then
				return var_15_1._gold
			elseif arg_15_1 == Data.ResType.union_wood then
				return var_15_1._wood
			end
		end
	elseif var_15_0 == Data.CardType.props then
		if arg_15_1 >= Data.PropsId.special and (arg_15_1 == Data.PropsId.avatar_frame or arg_15_1 == Data.PropsId.card_back) then
			return 1
		end

		return arg_15_0._propBag._props[arg_15_1] and arg_15_0._propBag._props[arg_15_1]._num or 0
	elseif var_15_0 == Data.CardType.item_skill then
		return arg_15_0._propBag._props[arg_15_1] and arg_15_0._propBag._props[arg_15_1]._num or 0
	elseif var_15_0 >= Data.CardType.monster and var_15_0 <= Data.CardType.rare then
		if arg_15_2 and arg_15_2._ignoreTroop then
			return count
		end

		local var_15_2 = P._playerCard:getCardFreeCount(arg_15_1)
		local var_15_3 = 0

		if arg_15_2 and arg_15_2._costExtra and var_15_2 > 0 then
			local var_15_4, var_15_5, var_15_6, var_15_7 = Data.removeAdditional(arg_15_1)

			if not var_15_6 and var_15_7 == 0 then
				local var_15_8 = Data.setAdditional(var_15_4, var_15_5, not var_15_6)

				var_15_3 = P:getItemCount(var_15_8)
			end
		end

		return var_15_2 + var_15_3
	elseif var_15_0 == Data.CardType.common_fragment then
		return arg_15_0._playerCard:getCommonFragmentByInfoId(arg_15_1)._fragmentNum
	end

	return -1
end

function var_0_25.getLotteryFlag(arg_16_0)
	local var_16_0 = 0

	for iter_16_0 = 1, #arg_16_0._lotteryNextFree do
		if arg_16_0._lotteryNextFree[iter_16_0] ~= 0 and arg_16_0._lotteryNextFree[iter_16_0] - ClientData.getCurrentTime() <= 0 then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function var_0_25.getExchangeGold(arg_17_0, arg_17_1)
	if arg_17_1 == 9999 then
		return 520, 9999
	elseif arg_17_1 == 4000 then
		return 280, 4000
	elseif arg_17_1 == 10000 then
		return 601, 10000
	elseif arg_17_1 == 3000 then
		return 3000, 3000, Data.ResType.gold
	elseif arg_17_1 == 6000 then
		return 300, 6000
	elseif arg_17_1 == 6800 then
		return 680, 6800
	else
		return Data._globalInfo._goldIngot[arg_17_1], Data._globalInfo._goldValue[arg_17_1]
	end
end

function var_0_25.getExchangeGrain(arg_18_0)
	local var_18_0 = arg_18_0._dailyBuyGrain + 1

	if var_18_0 > #Data._globalInfo._grainIngot then
		var_18_0 = #Data._globalInfo._grainIngot
	end

	return Data._globalInfo._grainIngot[var_18_0], Data._globalInfo._grainValue[var_18_0]
end

function var_0_25.getExchangeDust(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == Data.PropsId.dust_monster then
		return Data._globalInfo._dustMonsterIngot[arg_19_2], Data._globalInfo._dustMonsterValue[arg_19_2]
	elseif arg_19_1 == Data.PropsId.dust_magic then
		return Data._globalInfo._dustMagicIngot[arg_19_2], Data._globalInfo._dustMagicValue[arg_19_2]
	elseif arg_19_1 == Data.PropsId.dust_rare then
		return Data._globalInfo._dustRareIngot[arg_19_2], Data._globalInfo._dustRareValue[arg_19_2]
	elseif arg_19_1 == Data.PropsId.dimension_bottle then
		return Data._globalInfo._dimensionBottleIngot[arg_19_2], Data._globalInfo._dimensionBottleValue[arg_19_2]
	elseif arg_19_1 == Data.PropsId.skin_crystal then
		return Data._globalInfo._phantomCrystalIngot[arg_19_2], Data._globalInfo._phantomCrystalValue[arg_19_2]
	elseif arg_19_1 == Data.PropsId.times_package_ticket then
		return Data._globalInfo._dimensionLotteryTokenIngot[arg_19_2], Data._globalInfo._dimensionLotteryTokenValue[arg_19_2]
	end
end

function var_0_25.buyGold(arg_20_0, arg_20_1)
	if arg_20_0:getBuyGoldTimes() <= 0 then
		return Data.ErrorType.need_more_daily_buy_gold
	end

	local var_20_0, var_20_1, var_20_2 = arg_20_0:getExchangeGold(arg_20_1)

	var_20_2 = var_20_2 or Data.ResType.ingot

	if var_20_2 == Data.ResType.ingot then
		if not arg_20_0:hasResource(var_20_2, var_20_0) then
			return Data.ErrorType.need_more_ingot
		end
	elseif var_20_2 == Data.ResType.gold and not arg_20_0:hasResource(var_20_2, var_20_0) then
		return Data.ErrorType.need_more_gold
	end

	arg_20_0._dailyBuyGold = arg_20_0._dailyBuyGold + 1

	arg_20_0:changeResource(Data.ResType.gold, var_20_1)
	arg_20_0:changeResource(var_20_2, -var_20_0)

	return Data.ErrorType.ok
end

function var_0_25.buyGrain(arg_21_0)
	if arg_21_0:getBuyGrainTimes() <= 0 then
		return Data.ErrorType.need_more_daily_buy_grain
	end

	local var_21_0, var_21_1 = arg_21_0:getExchangeGrain()

	if not arg_21_0:hasResource(Data.ResType.ingot, var_21_0) then
		return Data.ErrorType.need_more_ingot
	end

	arg_21_0._dailyBuyGrain = arg_21_0._dailyBuyGrain + 1

	arg_21_0:changeResource(Data.ResType.grain, var_21_1)
	arg_21_0:changeResource(Data.ResType.ingot, -var_21_0)

	return Data.ErrorType.ok
end

function var_0_25.buyDust(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0, var_22_1 = arg_22_0:getExchangeDust(arg_22_1, arg_22_2)

	if not arg_22_0:hasResource(Data.ResType.ingot, var_22_0) then
		return Data.ErrorType.need_more_ingot
	end

	arg_22_0._propBag:changeProps(arg_22_1, var_22_1)
	arg_22_0:changeResource(Data.ResType.ingot, -var_22_0)

	return Data.ErrorType.ok
end

function var_0_25.hasResource(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == Data.ResType.gold then
		return arg_23_2 <= arg_23_0._gold
	elseif arg_23_1 == Data.ResType.grain then
		return arg_23_2 <= arg_23_0._grain
	elseif arg_23_1 == Data.ResType.ingot then
		return arg_23_2 <= arg_23_0._ingot
	elseif arg_23_1 == Data.ResType.blood_jade then
		return arg_23_2 <= arg_23_0._bloodJade
	end

	return false
end

function var_0_25.tryChangeResource(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 == Data.ResType.gold then
		local var_24_0 = arg_24_0._gold + arg_24_2

		if var_24_0 >= 0 then
			local var_24_1 = var_24_0 - arg_24_0._gold

			return true, var_24_1
		end
	elseif arg_24_1 == Data.ResType.grain then
		local var_24_2 = arg_24_0._grain + arg_24_2

		if var_24_2 >= 0 then
			if var_24_2 > arg_24_0:getGrainCapacity() then
				var_24_2 = arg_24_0:getGrainCapacity()
			end

			local var_24_3 = var_24_2 - arg_24_0._grain

			return true, var_24_3
		end
	elseif arg_24_1 == Data.ResType.ingot then
		local var_24_4 = arg_24_0._ingot + arg_24_2

		if var_24_4 >= 0 then
			local var_24_5 = var_24_4 - arg_24_0._ingot

			return true, var_24_5
		end
	end

	return false, 0
end

function var_0_25.changeResource(arg_25_0, arg_25_1, arg_25_2)
	if Data.isUnionRes(arg_25_1) then
		return arg_25_0._playerUnion:changeResource(arg_25_1, arg_25_2)
	end

	if arg_25_1 == Data.ResType.gold then
		local var_25_0 = arg_25_0._gold + arg_25_2

		if var_25_0 >= 0 then
			local var_25_1 = var_25_0 - arg_25_0._gold

			arg_25_0._gold = var_25_0

			arg_25_0:sendGoldDirty()

			return true, var_25_1
		end
	elseif arg_25_1 == Data.ResType.grain then
		local var_25_2 = arg_25_0._grain + arg_25_2

		if var_25_2 >= 0 then
			local var_25_3 = var_25_2 - arg_25_0._grain

			arg_25_0._grain = var_25_2

			arg_25_0:sendGrainDirty()

			return true, var_25_3
		end
	elseif arg_25_1 == Data.ResType.ingot then
		local var_25_4 = arg_25_0._ingot + arg_25_2

		if var_25_4 >= 0 then
			local var_25_5 = var_25_4 - arg_25_0._ingot

			arg_25_0._ingot = var_25_4

			if arg_25_2 < 0 and arg_25_0._playerActivity._actConsume then
				arg_25_0._playerActivity._consumeIngot = arg_25_0._playerActivity._consumeIngot - arg_25_2
			end

			arg_25_0:sendIngotDirty()

			return true, var_25_5
		end
	elseif arg_25_1 == Data.ResType.blood_jade then
		local var_25_6 = arg_25_0._bloodJade + arg_25_2

		if var_25_6 >= 0 then
			arg_25_0._bloodJade = var_25_6

			arg_25_0:sendBloodJadeDirty()

			return true, arg_25_2
		end
	elseif arg_25_1 == Data.ResType.achieve_point then
		local var_25_7 = arg_25_0._achievePoint + arg_25_2

		if var_25_7 >= 0 then
			arg_25_0._achievePoint = var_25_7

			arg_25_0:sendAchievePointDirty()

			return true, arg_25_2
		end
	elseif arg_25_1 == Data.ResType.union_personal_power then
		local var_25_8 = arg_25_0._dailyActive + arg_25_2

		if var_25_8 >= 0 then
			arg_25_0._dailyActive = var_25_8
		end

		for iter_25_0, iter_25_1 in ipairs(P._playerBonus._bonusDailyActive) do
			iter_25_1._value = P._dailyActive
		end

		local var_25_9 = arg_25_0._weekActive + arg_25_2

		if var_25_9 >= 0 then
			arg_25_0._weekActive = var_25_9
		end

		for iter_25_2, iter_25_3 in ipairs(P._playerBonus._bonusWeekActive) do
			iter_25_3._value = P._weekActive
		end

		arg_25_0:sendDailyActiveDirty()
	elseif arg_25_1 == Data.ResType.union_battle_trophy then
		local var_25_10 = arg_25_0._playerUnion._battleTrophy + arg_25_2
		local var_25_11 = math.max(var_25_10, 500)

		arg_25_0._playerUnion._battleTrophy = var_25_11

		arg_25_0:sendUnionBattleTrophyDirty()
	elseif arg_25_1 == Data.ResType.dark_trophy then
		local var_25_12 = math.max(arg_25_0._playerFindDark._trophy, 500) + arg_25_2
		local var_25_13 = math.max(var_25_12, 500)

		arg_25_0._playerFindDark._trophy = var_25_13

		arg_25_0:sendDarkTrophyDirty()
	elseif arg_25_1 == Data.ResType.clash_ex_trophy then
		local var_25_14 = math.max(arg_25_0._playerFindClashEx._trophy, 0) + arg_25_2
		local var_25_15 = math.max(var_25_14, 0)

		arg_25_0._playerFindClashEx._trophy = var_25_15

		arg_25_0:sendClashExTrophyDirty()
	elseif arg_25_1 == Data.ResType.exp or arg_25_1 == Data.ResType.character_exp then
		arg_25_0:changeExp(arg_25_2)
	elseif arg_25_1 == Data.ResType.badge_star then
		arg_25_0._playerBadge:changeStarNum(arg_25_2)
	elseif arg_25_1 == Data.ResType.badge_star_ex then
		arg_25_0._playerBadgeEx:changeStarNum(arg_25_2)
	elseif arg_25_1 == Data.ResType.badge_star_ex2 then
		arg_25_0._playerBadgeEx2:changeStarNum(arg_25_2)
	end

	return false, 0
end

function var_0_25.addResourcesData(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		local var_26_1 = arg_26_0:addResource(iter_26_1._infoId, iter_26_1._level, iter_26_1._count, iter_26_1._isFragment, true, arg_26_2)

		if var_26_1 then
			var_26_0[var_26_1] = true
		end
	end

	for iter_26_2 in pairs(var_26_0) do
		arg_26_0._playerCard:sendCardListDirty(iter_26_2)
	end
end

function var_0_25.addResources(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	local var_27_0 = {}
	local var_27_1 = math.min(#arg_27_1, #arg_27_3)

	for iter_27_0 = 1, var_27_1 do
		local var_27_2 = arg_27_0:addResource(arg_27_1[iter_27_0], arg_27_2[iter_27_0], arg_27_3[iter_27_0], arg_27_4[iter_27_0], true)

		if var_27_2 then
			var_27_0[var_27_2] = true
		end
	end

	for iter_27_1 in pairs(var_27_0) do
		arg_27_0._playerCard:sendCardListDirty(iter_27_1)
	end
end

function var_0_25.addResource(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5, arg_28_6)
	if Data.isUnionRes(arg_28_1) then
		arg_28_0._playerUnion:changeResource(arg_28_1, arg_28_3)
	elseif arg_28_1 == Data.ResType.gold or arg_28_1 == Data.ResType.grain or arg_28_1 == Data.ResType.ingot or arg_28_1 == Data.ResType.blood_jade or arg_28_1 == Data.ResType.achieve_point or arg_28_1 == Data.ResType.union_personal_power or arg_28_1 == Data.ResType.exp or arg_28_1 == Data.ResType.character_exp or arg_28_1 == Data.ResType.dark_trophy or arg_28_1 == Data.ResType.badge_star or arg_28_1 == Data.ResType.badge_star_ex or arg_28_1 == Data.ResType.badge_star_ex2 or arg_28_1 == Data.ResType.new_server_score then
		arg_28_0:changeResource(arg_28_1, arg_28_3)
	else
		local var_28_0 = Data.getType(arg_28_1)

		if var_28_0 == Data.CardType.props or var_28_0 == Data.CardType.item_skill then
			arg_28_0._propBag:changeProps(arg_28_1, arg_28_3)
		elseif var_28_0 == Data.CardType.monster_skin or var_28_0 == Data.CardType.rare_skin then
			arg_28_0._playerCard:buySkinId(arg_28_1, arg_28_3)
		else
			local var_28_1 = P:getItemCount(arg_28_1)

			if arg_28_6 and arg_28_6._costExtra and arg_28_3 < 0 and var_28_1 > 0 and arg_28_3 + var_28_1 < 0 then
				local var_28_2, var_28_3, var_28_4 = Data.removeAdditional(arg_28_1)

				if not var_28_4 then
					local var_28_5 = Data.setAdditional(var_28_2, var_28_3, not var_28_4)
					local var_28_6 = arg_28_3 + var_28_1

					arg_28_0._playerCard:addCard(var_28_5, var_28_6)

					arg_28_3 = arg_28_3 - var_28_6
				end
			end

			if arg_28_0._playerCard:addCard(arg_28_1, arg_28_3) then
				if not arg_28_5 then
					arg_28_0._playerCard:sendCardListDirty(var_28_0)
				end

				return var_28_0
			end
		end
	end
end

function var_0_25.getLevelupGrain(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = 0

	for iter_29_0 = arg_29_1 + 1, arg_29_2 do
		var_29_0 = var_29_0 + Data._globalInfo._playerLevelupGrain[math.min(iter_29_0, #Data._globalInfo._playerLevelupGrain)]
	end

	return var_29_0
end

function var_0_25.changeLevel(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0:getCharacterId()
	local var_30_1 = arg_30_0._characters[var_30_0]
	local var_30_2 = math.min(var_30_1._level + arg_30_1, arg_30_0:getMaxLevel(var_30_0))

	if var_30_2 > 0 then
		var_30_1._level = var_30_2

		arg_30_0:sendLevelDirty()

		return true
	end

	return false
end

function var_0_25.changeExp(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = 0
	local var_31_1 = arg_31_0:getCharacterId()
	local var_31_2 = arg_31_0._characters[var_31_1]

	var_31_2._exp = var_31_2._exp + arg_31_1

	local var_31_3 = arg_31_0:getMaxCharacterLevel()
	local var_31_4 = arg_31_0:getLevelupExp(var_31_2._level + var_31_0)

	while var_31_2._level < arg_31_0:getMaxLevel(var_31_1) and var_31_4 > 0 and var_31_4 <= var_31_2._exp do
		var_31_2._exp = var_31_2._exp - var_31_4
		var_31_0 = var_31_0 + 1
		var_31_4 = arg_31_0:getLevelupExp(var_31_2._level + var_31_0)
	end

	if var_31_0 > 0 then
		local var_31_5 = var_31_2._level

		arg_31_0:changeLevel(var_31_0, arg_31_2)

		var_31_0 = var_31_2._level - var_31_5

		if var_31_2._level == P:getMaxLevel(var_31_2._id) then
			var_31_2._exp = 0
		end
	end

	arg_31_0:sendExpDirty()

	if arg_31_0:getMaxCharacterLevel() ~= var_31_3 and lc.App:getChannelName() == "ASDK" then
		ClientData.submitRoleData("2")
	end

	return var_31_0
end

function var_0_25.changeVIP(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0._vip + arg_32_1

	if arg_32_1 > 0 then
		arg_32_0._vip = var_32_0

		arg_32_0:sendVIPDirty()

		return true
	end

	return false
end

function var_0_25.changeVIPExp(arg_33_0, arg_33_1)
	local var_33_0 = 0

	arg_33_0._vipExp = arg_33_0._vipExp + arg_33_1

	local var_33_1 = arg_33_0:getVIPupExp(arg_33_0._vip + var_33_0)

	while arg_33_0._vip < #Data._globalInfo._vipIngot - 1 and var_33_1 > 0 and var_33_1 <= arg_33_0._vipExp do
		arg_33_0._vipExp = arg_33_0._vipExp - var_33_1
		var_33_0 = var_33_0 + 1
		var_33_1 = arg_33_0:getVIPupExp(arg_33_0._vip + var_33_0)
	end

	if var_33_0 > 0 then
		arg_33_0:changeVIP(var_33_0)
	end

	arg_33_0:sendVIPExpDirty()

	return var_33_0
end

function var_0_25.changeTrophy(arg_34_0, arg_34_1)
	arg_34_0._playerFindClash:changeTrophy(arg_34_1)
end

function var_0_25.changeLadderTrophy(arg_35_0, arg_35_1)
	arg_35_0._playerFindClash:changeLadderTrophy(arg_35_1)
end

function var_0_25.changeName(arg_36_0, arg_36_1)
	if arg_36_0._name == arg_36_1 or arg_36_1 == "" then
		return false
	end

	arg_36_0._name = arg_36_1

	arg_36_0:sendNameDirty()

	return true
end

function var_0_25.changeIcon(arg_37_0, arg_37_1)
	if arg_37_0._avatar == arg_37_1 then
		return false
	end

	arg_37_0._avatar = arg_37_1
	arg_37_0._characters[arg_37_0:getCharacterId()]._avatar = arg_37_1

	arg_37_0:sendIconDirty()

	return true
end

function var_0_25.changeAvatarFrame(arg_38_0, arg_38_1)
	if arg_38_0._avatarFrameId == arg_38_1 then
		return false
	end

	arg_38_0._avatarFrameId = arg_38_1

	arg_38_0:sendAvatarFrameDirty()

	return true
end

function var_0_25.changeCharacter(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_2 and arg_39_0:getCharacterId() == arg_39_1 then
		return false
	end

	arg_39_0:changeIcon(arg_39_0._characters[arg_39_1]._avatar)

	if arg_39_0:getCharacterId() ~= arg_39_1 then
		arg_39_0:changeIcon(arg_39_1 * 100 + 1)
	end

	arg_39_0:sendCharacterDirty()

	return true
end

function var_0_25.getBattleCost(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0

	if arg_40_3 and arg_40_3 > 0 then
		local var_40_1 = math.floor(arg_40_3 / 10000)

		var_40_0 = arg_40_2 and Data._globalInfo._chapterLoseCost[var_40_1] or Data._globalInfo._chapterCost[var_40_1]
	else
		var_40_0 = arg_40_2 and Data._globalInfo._battleLoseCost or Data._globalInfo._battleCost
	end

	if arg_40_1 then
		var_40_0 = var_40_0 * arg_40_1
	end

	return var_40_0
end

function var_0_25.checkBattleCost(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0:getBattleCost(arg_41_1, nil, arg_41_2)

	return arg_41_0:hasResource(Data.ResType.grain, var_41_0)
end

function var_0_25.getFindCost(arg_42_0)
	local var_42_0 = math.floor(arg_42_0._level / 5) + 1

	if var_42_0 > #Data._globalInfo._findCost then
		var_42_0 = #Data._globalInfo._findCost
	end

	return Data._globalInfo._findCost[var_42_0]
end

function var_0_25.checkFindCost(arg_43_0)
	local var_43_0 = arg_43_0:getFindCost()

	return arg_43_0:hasResource(Data.ResType.gold, var_43_0)
end

function var_0_25.sortByInfoId(arg_44_0, arg_44_1, arg_44_2)
	local function var_44_0(arg_45_0, arg_45_1)
		local var_45_0 = arg_45_0._infoId or arg_45_0._id
		local var_45_1 = arg_45_1._infoId or arg_45_1._id
		local var_45_2 = Data.removeAdditional(var_45_0)
		local var_45_3 = Data.removeAdditional(var_45_1)

		if var_45_2 == var_45_3 then
			return arg_44_2 ~= (var_45_0 < var_45_1)
		else
			return arg_44_2 ~= (var_45_2 < var_45_3)
		end
	end

	table.sort(arg_44_1, var_44_0)

	return arg_44_1
end

function var_0_25.sortByQuality(arg_46_0, arg_46_1, arg_46_2)
	local function getCardId(x)
		if type(x) == "table" then return x._infoId or x._id or 0 end
		return tonumber(x) or 0
	end

	local function var_46_0(arg_47_0, arg_47_1)
		local id0 = getCardId(arg_47_0)
		local id1 = getCardId(arg_47_1)
		local var_47_0 = Data.getInfo(id0)
		local var_47_1 = Data.getInfo(id1)

		if var_47_0 == nil or var_47_1 == nil then
			return id0 < id1
		end

		local q0 = var_47_0._quality or 0
		local q1 = var_47_1._quality or 0

		if q0 == q1 then
			local var_47_2 = Data.removeAdditional(id0)
			local var_47_3 = Data.removeAdditional(id1)

			if var_47_2 == var_47_3 then
				return id1 < id0
			else
				return var_47_3 < var_47_2
			end
		else
			return arg_46_2 ~= (q0 < q1)
		end
	end

	table.sort(arg_46_1, var_46_0)

	return arg_46_1
end

function var_0_25.sortCardsByATK(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_1
	local function getCardId(x)
		if type(x) == "table" then return x._infoId or x._id or 0 end
		return tonumber(x) or 0
	end

	local function var_48_1(arg_49_0, arg_49_1)
		local id0 = getCardId(arg_49_0)
		local id1 = getCardId(arg_49_1)
		local var_49_0 = Data.getInfo(id0)
		local var_49_1 = Data.getInfo(id1)
		if not var_49_0 or not var_49_1 then return id0 < id1 end
		local atk0 = (var_49_0._atk and var_49_0._atk[1]) or 0
		local atk1 = (var_49_1._atk and var_49_1._atk[1]) or 0

		if arg_48_2 then
			return atk0 > atk1
		else
			return atk0 < atk1
		end
	end

	table.sort(var_48_0, var_48_1)

	return var_48_0
end

function var_0_25.sortCardsByHP(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_1
	local function getCardId(x)
		if type(x) == "table" then return x._infoId or x._id or 0 end
		return tonumber(x) or 0
	end

	local function var_50_1(arg_51_0, arg_51_1)
		local id0 = getCardId(arg_51_0)
		local id1 = getCardId(arg_51_1)
		local var_51_0 = Data.getInfo(id0)
		local var_51_1 = Data.getInfo(id1)
		if not var_51_0 or not var_51_1 then return id0 < id1 end
		local hp0 = (var_51_0._hp and var_51_0._hp[1]) or 0
		local hp1 = (var_51_1._hp and var_51_1._hp[1]) or 0

		if arg_50_2 then
			return hp0 > hp1
		else
			return hp0 < hp1
		end
	end

	table.sort(var_50_0, var_50_1)

	return var_50_0
end

function var_0_25.sortResultItems(arg_52_0, arg_52_1)
	local function var_52_0(arg_53_0, arg_53_1)
		local var_53_0, var_53_1, var_53_2 = Data.removeAdditional(arg_53_0._infoId or arg_53_0._data._infoId)
		local var_53_3, var_53_4, var_53_5 = Data.removeAdditional(arg_53_1._infoId or arg_53_1._data._infoId)
		local var_53_6, var_53_7 = Data.getInfo(var_53_0)
		local var_53_8, var_53_9 = Data.getInfo(var_53_3)

		if var_53_7 == Data.CardType.magic or var_53_7 == Data.CardType.trap or var_53_7 == Data.CardType.monster or var_53_7 == Data.CardType.polymerization then
			var_53_7 = var_53_7 * 10000

			if var_53_2 then
				var_53_7 = var_53_7 * 10
			end

			if var_53_1 then
				var_53_7 = var_53_7 / 100
			end
		elseif var_53_7 == Data.CardType.props then
			var_53_7 = var_53_7 * 10
		end

		if var_53_9 == Data.CardType.magic or var_53_9 == Data.CardType.trap or var_53_9 == Data.CardType.monster or var_53_9 == Data.CardType.polymerization then
			var_53_9 = var_53_9 * 10000

			if var_53_5 then
				var_53_9 = var_53_9 * 10
			end

			if var_53_4 then
				var_53_9 = var_53_9 / 100
			end
		elseif var_53_9 == Data.CardType.props then
			var_53_9 = var_53_9 * 10
		end

		local var_53_10 = var_53_6 and var_53_6._quality or -1
		local var_53_11 = var_53_8 and var_53_8._quality or -1

		if var_53_7 == var_53_9 then
			if var_53_10 == var_53_11 then
				return var_53_6._id > var_53_8._id
			else
				return var_53_11 < var_53_10
			end
		else
			return var_53_9 < var_53_7
		end
	end

	table.sort(arg_52_1, var_52_0)

	return arg_52_1
end

function var_0_25.sortCardsByNum(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = arg_54_1

	local function var_54_1(arg_55_0, arg_55_1)
		local var_55_0 = P._playerCard:getCardCount(arg_55_0)
		local var_55_1 = P._playerCard:getCardCount(arg_55_1)

		if var_55_0 == var_55_1 then
			if arg_54_2 then
				return arg_55_1 < arg_55_0
			else
				return arg_55_0 < arg_55_1
			end
		end

		if arg_54_2 then
			return var_55_1 < var_55_0
		else
			return var_55_0 < var_55_1
		end
	end

	table.sort(var_54_0, var_54_1)

	return var_54_0
end

function var_0_25.filterByOption(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = {}

	for iter_56_0, iter_56_1 in ipairs(arg_56_1) do
		local var_56_1 = type(iter_56_1) == "number" and Data.getInfo(iter_56_1) or iter_56_1

		if band(var_56_1._option, arg_56_2) > 0 then
			table.insert(var_56_0, iter_56_1)
		end
	end

	return var_56_0
end

function var_0_25.filterByCategory(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = {}

	for iter_57_0, iter_57_1 in ipairs(arg_57_1) do
		if (type(iter_57_1) == "number" and Data.getInfo(iter_57_1) or iter_57_1)._category == arg_57_2 then
			table.insert(var_57_0, iter_57_1)
		end
	end

	return var_57_0
end

function var_0_25.filterByQuality(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		if (type(iter_58_1) == "number" and Data.getInfo(iter_58_1) or iter_58_1)._quality == arg_58_2 then
			table.insert(var_58_0, iter_58_1)
		end
	end

	return var_58_0
end

function var_0_25.filterByNature(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = {}

	for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
		if (type(iter_59_1) == "number" and Data.getInfo(iter_59_1) or iter_59_1)._nature == arg_59_2 then
			table.insert(var_59_0, iter_59_1)
		end
	end

	return var_59_0
end

function var_0_25.filterByLevel(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = {}

	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		if (type(iter_60_1) == "number" and Data.getInfo(iter_60_1) or iter_60_1)._star == arg_60_2 then
			table.insert(var_60_0, iter_60_1)
		end
	end

	return var_60_0
end

function var_0_25.filterByType(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = {}

	for iter_61_0, iter_61_1 in ipairs(arg_61_1) do
		if (arg_61_2(iter_61_1) == "number" and Data.getType(iter_61_1) or Data.getType(iter_61_1._infoId)) == arg_61_2 then
			table.insert(var_61_0, iter_61_1)
		end
	end

	return var_61_0
end

function var_0_25.filterByTroop(arg_62_0, arg_62_1)
	local var_62_0 = {}

	for iter_62_0 = 1, #arg_62_1 do
		if arg_62_1[iter_62_0]:isInTroop(0) then
			table.insert(var_62_0, arg_62_1[iter_62_0])
		end
	end

	return var_62_0
end

function var_0_25.filterByUntroop(arg_63_0, arg_63_1)
	local var_63_0 = {}

	for iter_63_0 = 1, #arg_63_1 do
		if not arg_63_1[iter_63_0]:isInTroop(0) then
			table.insert(var_63_0, arg_63_1[iter_63_0])
		end
	end

	return var_63_0
end

function var_0_25.filterByCanUpgrade(arg_64_0, arg_64_1)
	local var_64_0 = {}

	for iter_64_0, iter_64_1 in ipairs(arg_64_1) do
		if P._playerCard:upgradeCard(iter_64_1, true) == Data.ErrorType.ok then
			table.insert(var_64_0, iter_64_1)
		end
	end

	return var_64_0
end

function var_0_25.filterByCanCompose(arg_65_0, arg_65_1)
	local var_65_0 = {}

	for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
		if P._playerCard:composeCard(iter_65_1, 1, true) == Data.ErrorType.ok then
			table.insert(var_65_0, iter_65_1)
		end
	end

	return var_65_0
end

function var_0_25.filterByCollect(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = {}

	for iter_66_0, iter_66_1 in ipairs(arg_66_1) do
		local var_66_1 = type(iter_66_1) == "number" and iter_66_1 or iter_66_1._id or iter_66_1._infoId
		local var_66_2 = P._playerCard:isCollected(var_66_1)

		if arg_66_2 == 1 and var_66_2 or arg_66_2 == 2 and not var_66_2 then
			table.insert(var_66_0, iter_66_1)
		end
	end

	return var_66_0
end


local utf8_lower_map = {
	["A"] = "a", ["B"] = "b", ["C"] = "c", ["D"] = "d", ["E"] = "e", ["F"] = "f", ["G"] = "g", ["H"] = "h",
	["I"] = "i", ["J"] = "j", ["K"] = "k", ["L"] = "l", ["M"] = "m", ["N"] = "n", ["O"] = "o", ["P"] = "p",
	["Q"] = "q", ["R"] = "r", ["S"] = "s", ["T"] = "t", ["U"] = "u", ["V"] = "v", ["W"] = "w", ["X"] = "x",
	["Y"] = "y", ["Z"] = "z",
	["À"] = "à", ["Á"] = "á", ["Ả"] = "ả", ["Ã"] = "ã", ["Ạ"] = "ạ",
	["Ă"] = "ă", ["Ằ"] = "ằ", ["Ắ"] = "ắ", ["Ẳ"] = "ẳ", ["Ẵ"] = "ẵ", ["Ặ"] = "ặ",
	["Â"] = "â", ["Ầ"] = "ầ", ["Ấ"] = "ấ", ["Ẩ"] = "ẩ", ["Ẫ"] = "ẫ", ["Ậ"] = "ậ",
	["Đ"] = "đ",
	["È"] = "è", ["É"] = "é", ["Ẻ"] = "ẻ", ["Ẽ"] = "ẽ", ["Ẹ"] = "ẹ",
	["Ê"] = "ê", ["Ề"] = "ề", ["Ế"] = "ế", ["Ể"] = "ể", ["Ễ"] = "ễ", ["Ệ"] = "ệ",
	["Ì"] = "ì", ["Í"] = "í", ["Ỉ"] = "ỉ", ["Ĩ"] = "ĩ", ["Ị"] = "ị",
	["Ò"] = "ò", ["Ó"] = "ó", ["Ỏ"] = "ỏ", ["Õ"] = "õ", ["Ọ"] = "ọ",
	["Ô"] = "ô", ["Ồ"] = "ồ", ["Ố"] = "ố", ["Ổ"] = "ổ", ["Ỗ"] = "ỗ", ["Ộ"] = "ộ",
	["Ơ"] = "ơ", ["Ờ"] = "ờ", ["Ớ"] = "ớ", ["Ở"] = "ở", ["Ỡ"] = "ỡ", ["Ợ"] = "ợ",
	["Ù"] = "ù", ["Ú"] = "ú", ["Ủ"] = "ủ", ["Ũ"] = "ũ", ["Ụ"] = "ụ",
	["Ư"] = "ư", ["Ừ"] = "ừ", ["Ứ"] = "ứ", ["Ử"] = "ử", ["Ữ"] = "ữ", ["Ự"] = "ự",
	["Ỳ"] = "ỳ", ["Ý"] = "ý", ["Ỷ"] = "ỷ", ["Ỹ"] = "ỹ", ["Ỵ"] = "ỵ"
}

local no_accent_map = {
	["à"] = "a", ["á"] = "a", ["ả"] = "a", ["ã"] = "a", ["ạ"] = "a",
	["ă"] = "a", ["ằ"] = "a", ["ắ"] = "a", ["ẳ"] = "a", ["ẵ"] = "a", ["ặ"] = "a",
	["â"] = "a", ["ầ"] = "a", ["ấ"] = "a", ["ẩ"] = "a", ["ẫ"] = "a", ["ậ"] = "a",
	["đ"] = "d",
	["è"] = "e", ["é"] = "e", ["ẻ"] = "e", ["ẽ"] = "e", ["ẹ"] = "e",
	["ê"] = "e", ["ề"] = "e", ["ế"] = "e", ["ể"] = "e", ["ễ"] = "e", ["ệ"] = "e",
	["ì"] = "i", ["í"] = "i", ["ỉ"] = "i", ["ĩ"] = "i", ["ị"] = "i",
	["ò"] = "o", ["ó"] = "o", ["ỏ"] = "o", ["õ"] = "o", ["ọ"] = "o",
	["ô"] = "o", ["ồ"] = "o", ["ố"] = "o", ["ổ"] = "o", ["ỗ"] = "o", ["ộ"] = "o",
	["ơ"] = "o", ["ờ"] = "o", ["ớ"] = "o", ["ở"] = "o", ["ỡ"] = "o", ["ợ"] = "o",
	["ù"] = "u", ["ú"] = "u", ["ủ"] = "u", ["ũ"] = "u", ["ụ"] = "u",
	["ư"] = "u", ["ừ"] = "u", ["ứ"] = "u", ["ử"] = "u", ["ữ"] = "u", ["ự"] = "u",
	["ỳ"] = "y", ["ý"] = "y", ["ỷ"] = "y", ["ỹ"] = "y", ["ỵ"] = "y"
}

local function utf8Lower(str)
	if not str then return "" end
	local res = {}
	local i = 1
	local len = #str
	while i <= len do
		local b = string.byte(str, i)
		local ch
		if b < 128 then
			ch = string.sub(str, i, i)
			i = i + 1
			if b >= 65 and b <= 90 then
				ch = string.char(b + 32)
			end
		elseif b >= 192 and b <= 223 then
			ch = string.sub(str, i, i + 1)
			i = i + 2
			if utf8_lower_map[ch] then ch = utf8_lower_map[ch] end
		elseif b >= 224 and b <= 239 then
			ch = string.sub(str, i, i + 2)
			i = i + 3
			if utf8_lower_map[ch] then ch = utf8_lower_map[ch] end
		elseif b >= 240 and b <= 247 then
			ch = string.sub(str, i, i + 3)
			i = i + 4
		else
			ch = string.sub(str, i, i)
			i = i + 1
		end
		table.insert(res, ch)
	end
	return table.concat(res)
end

local function removeAccents(str)
	if not str then return "" end
	local res = {}
	local i = 1
	local len = #str
	while i <= len do
		local b = string.byte(str, i)
		local ch
		if b < 128 then
			ch = string.sub(str, i, i)
			i = i + 1
		elseif b >= 192 and b <= 223 then
			ch = string.sub(str, i, i + 1)
			i = i + 2
			if no_accent_map[ch] then ch = no_accent_map[ch] end
		elseif b >= 224 and b <= 239 then
			ch = string.sub(str, i, i + 2)
			i = i + 3
			if no_accent_map[ch] then ch = no_accent_map[ch] end
		elseif b >= 240 and b <= 247 then
			ch = string.sub(str, i, i + 3)
			i = i + 4
		else
			ch = string.sub(str, i, i)
			i = i + 1
		end
		table.insert(res, ch)
	end
	return table.concat(res)
end

local function strTrim(s)
	if not s then return "" end
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

local function matchCardSearch(target, query)
	if not target or not query or query == "" then return false end
	target = tostring(target)
	query = strTrim(tostring(query))
	if query == "" then return true end

	local t_low = utf8Lower(target)
	local q_low = utf8Lower(query)
	if string.find(t_low, q_low, 1, true) then
		return true
	end

	local t_noacc = removeAccents(t_low)
	local q_noacc = removeAccents(q_low)
	if string.find(t_noacc, q_noacc, 1, true) then
		return true
	end

	return false
end

function var_0_25.filterBySearch(arg_67_0, arg_67_1, arg_67_2)
	local var_67_0 = {}
	arg_67_2 = strTrim(arg_67_2)

	for iter_67_0, iter_67_1 in ipairs(arg_67_1) do
		local var_67_1 = type(iter_67_1) == "number" and Data.getInfo(iter_67_1) or iter_67_1

		if arg_67_2 == "" then
			table.insert(var_67_0, iter_67_1)
		else
			local cardName = Str(var_67_1._nameSid)
			if matchCardSearch(cardName, arg_67_2) then
				table.insert(var_67_0, iter_67_1)
			elseif var_67_1._category ~= nil and matchCardSearch(Str(STR.CARD_CATEGORY_BEGIN + var_67_1._category), arg_67_2) then
				table.insert(var_67_0, iter_67_1)
			elseif var_67_1._keyword ~= nil and matchCardSearch(Str(STR.CARD_KEYWORD_BEGIN + var_67_1._keyword), arg_67_2) then
				table.insert(var_67_0, iter_67_1)
			else
				local matchedSkill = false
				if var_67_1._skillId then
					for iter_67_2 = 1, #var_67_1._skillId do
						if arg_67_0:searchInSkill(var_67_1._skillId[iter_67_2], arg_67_2) then
							table.insert(var_67_0, iter_67_1)
							matchedSkill = true
							break
						end
					end
				end
			end
		end
	end

	return var_67_0
end

function var_0_25.searchInSkill(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = Data._skillInfo[arg_68_1]

	if var_68_0 then
		if matchCardSearch(Str(var_68_0._nameSid), arg_68_2) then
			return true
		elseif matchCardSearch(Str(var_68_0._descSid), arg_68_2) then
			return true
		end
	end

	return false
end

function var_0_25.sendGoldDirty(arg_69_0)
	local var_69_0 = cc.EventCustom:new(Data.Event.gold_dirty)

	lc.Dispatcher:dispatchEvent(var_69_0)
end

function var_0_25.sendGrainDirty(arg_70_0)
	local var_70_0 = cc.EventCustom:new(Data.Event.grain_dirty)

	lc.Dispatcher:dispatchEvent(var_70_0)
end

function var_0_25.sendIngotDirty(arg_71_0)
	local var_71_0 = cc.EventCustom:new(Data.Event.ingot_dirty)

	lc.Dispatcher:dispatchEvent(var_71_0)
end

function var_0_25.sendGhostDirty(arg_72_0)
	local var_72_0 = cc.EventCustom:new(Data.Event.ghost_dirty)

	lc.Dispatcher:dispatchEvent(var_72_0)
end

function var_0_25.sendBloodJadeDirty(arg_73_0)
	local var_73_0 = cc.EventCustom:new(Data.Event.blood_jade_dirty)

	lc.Dispatcher:dispatchEvent(var_73_0)
end

function var_0_25.sendAchievePointDirty(arg_74_0)
	local var_74_0 = cc.EventCustom:new(Data.Event.achieve_point_dirty)

	lc.Dispatcher:dispatchEvent(var_74_0)
end

function var_0_25.sendUnionBattleTrophyDirty(arg_75_0)
	local var_75_0 = cc.EventCustom:new(Data.Event.union_battle_trophy_dirty)

	lc.Dispatcher:dispatchEvent(var_75_0)
end

function var_0_25.sendDarkTrophyDirty(arg_76_0)
	local var_76_0 = cc.EventCustom:new(Data.Event.dark_trophy_dirty)

	lc.Dispatcher:dispatchEvent(var_76_0)
end

function var_0_25.sendClashExTrophyDirty(arg_77_0)
	local var_77_0 = cc.EventCustom:new(Data.Event.clash_ex_trophy_dirty)

	lc.Dispatcher:dispatchEvent(var_77_0)
end

function var_0_25.sendDailyActiveDirty(arg_78_0)
	local var_78_0 = cc.EventCustom:new(Data.Event.daily_active_dirty)

	lc.Dispatcher:dispatchEvent(var_78_0)
end

function var_0_25.sendLevelDirty(arg_79_0)
	local var_79_0 = cc.EventCustom:new(Data.Event.level_dirty)

	lc.Dispatcher:dispatchEvent(var_79_0)
end

function var_0_25.sendExpDirty(arg_80_0)
	local var_80_0 = cc.EventCustom:new(Data.Event.exp_dirty)

	lc.Dispatcher:dispatchEvent(var_80_0)
end

function var_0_25.sendVIPDirty(arg_81_0)
	local var_81_0 = cc.EventCustom:new(Data.Event.vip_dirty)

	lc.Dispatcher:dispatchEvent(var_81_0)
end

function var_0_25.sendVIPExpDirty(arg_82_0)
	local var_82_0 = cc.EventCustom:new(Data.Event.vip_exp_dirty)

	lc.Dispatcher:dispatchEvent(var_82_0)
end

function var_0_25.sendMonthCardDirty(arg_83_0)
	local var_83_0 = cc.EventCustom:new(Data.Event.month_card_dirty)

	lc.Dispatcher:dispatchEvent(var_83_0)
end

function var_0_25.sendFundDirty(arg_84_0)
	local var_84_0 = cc.EventCustom:new(Data.Event.fund_dirty)

	lc.Dispatcher:dispatchEvent(var_84_0)
end

function var_0_25.sendPersonalFundDirty(arg_85_0)
	local var_85_0 = cc.EventCustom:new(Data.Event.personal_fund_dirty)

	lc.Dispatcher:dispatchEvent(var_85_0)
end

function var_0_25.sendPackageDirty(arg_86_0)
	local var_86_0 = cc.EventCustom:new(Data.Event.package_dirty)

	lc.Dispatcher:dispatchEvent(var_86_0)
end

function var_0_25.sendTrophyDirty(arg_87_0)
	local var_87_0 = cc.EventCustom:new(Data.Event.trophy_dirty)

	lc.Dispatcher:dispatchEvent(var_87_0)
end

function var_0_25.sendNameDirty(arg_88_0)
	local var_88_0 = cc.EventCustom:new(Data.Event.name_dirty)

	lc.Dispatcher:dispatchEvent(var_88_0)
end

function var_0_25.sendIconDirty(arg_89_0)
	local var_89_0 = cc.EventCustom:new(Data.Event.icon_dirty)

	lc.Dispatcher:dispatchEvent(var_89_0)
end

function var_0_25.sendAvatarFrameDirty(arg_90_0)
	local var_90_0 = cc.EventCustom:new(Data.Event.avatar_frame_dirty)

	lc.Dispatcher:dispatchEvent(var_90_0)
end

function var_0_25.sendCharacterDirty(arg_91_0)
	local var_91_0 = cc.EventCustom:new(Data.Event.character_dirty)

	lc.Dispatcher:dispatchEvent(var_91_0)
end

function var_0_25.getUnlockSlotLevel(arg_92_0, arg_92_1)
	local var_92_0 = arg_92_1 + Data._globalInfo._unlockSlot[1]

	for iter_92_0 = 1, #Data._globalInfo._unlockSlot do
		if Data._globalInfo._unlockSlot[iter_92_0] == var_92_0 then
			return iter_92_0 - 1
		end
	end
end

function var_0_25.getMaxTroopCount(arg_93_0)
	return arg_93_0:getCharacterUnlockCount() + arg_93_0._playerCard:getExtraTroopCount()
end

function var_0_25.getTitle(arg_94_0, arg_94_1)
	if arg_94_1 == nil then
		arg_94_1 = arg_94_0._trophy
	end

	for iter_94_0 = 1, #Data._globalInfo._playerTitleTrophy do
		if iter_94_0 < #Data._globalInfo._playerTitleTrophy then
			if arg_94_1 >= Data._globalInfo._playerTitleTrophy[iter_94_0] and arg_94_1 < Data._globalInfo._playerTitleTrophy[iter_94_0 + 1] then
				return iter_94_0
			end
		elseif arg_94_1 >= Data._globalInfo._playerTitleTrophy[iter_94_0] then
			return iter_94_0
		end
	end
end

function var_0_25.isMaxLevel(arg_95_0, arg_95_1)
	return P:getLevel(arg_95_1) >= P:getMaxLevel(arg_95_1)
end

function var_0_25.getMaxLevel(arg_96_0, arg_96_1)
	if arg_96_1 and not arg_96_0._characters[arg_96_1]._breakOut then
		return 100
	else
		return #Data._globalInfo._playerLevelupExp
	end
end

function var_0_25.getLevelupExp(arg_97_0, arg_97_1)
	if arg_97_1 <= 0 then
		return 0
	end

	if arg_97_1 >= #Data._globalInfo._playerLevelupExp then
		arg_97_1 = #Data._globalInfo._playerLevelupExp - 1
	end

	return Data._globalInfo._playerLevelupExp[arg_97_1 + 1] - Data._globalInfo._playerLevelupExp[arg_97_1]
end

function var_0_25.getVIPupExp(arg_98_0, arg_98_1)
	if arg_98_1 == nil then
		arg_98_1 = arg_98_0._vip
	end

	if arg_98_1 < 0 then
		return 0
	end

	if arg_98_1 >= #Data._globalInfo._vipIngot - 1 then
		return 0
	end

	return Data._globalInfo._vipIngot[arg_98_1 + 2] - Data._globalInfo._vipIngot[arg_98_1 + 1]
end

function var_0_25.getTotalVipExp(arg_99_0)
	local var_99_0 = arg_99_0._vipExp

	for iter_99_0 = 1, arg_99_0._vip do
		var_99_0 = var_99_0 + Data._globalInfo._vipIngot[iter_99_0]
	end

	return var_99_0
end

function var_0_25.getBattleExp(arg_100_0, arg_100_1)
	if arg_100_1 == nil then
		arg_100_1 = arg_100_0._level
	end

	if arg_100_1 <= 0 then
		return 0
	end

	if arg_100_1 > #Data._globalInfo._playerBattleExp then
		return Data._globalInfo._playerBattleExp[#Data._globalInfo._playerBattleExp]
	end

	return Data._globalInfo._playerBattleExp[arg_100_1]
end

function var_0_25.getHp(arg_101_0, arg_101_1)
	if arg_101_1 == nil then
		arg_101_1 = arg_101_0._level
	end

	if arg_101_1 <= 0 then
		return 0
	end

	if arg_101_1 > #Data._globalInfo._playerHp then
		return Data._globalInfo._playerHp[#Data._globalInfo._playerHp]
	end

	return Data._globalInfo._playerHp[arg_101_1]
end

function var_0_25.getReputation(arg_102_0, arg_102_1)
	if arg_102_1 == nil then
		arg_102_1 = arg_102_0._level
	end

	if arg_102_1 <= 0 then
		return 0
	end

	return lc.arrayAt(Data._globalInfo._playerReputation, arg_102_1) + P._playerUnion:getTechVal(Data.UnionTechId.lord_reputation)
end

function var_0_25.getGrainCapacity(arg_103_0, arg_103_1)
	arg_103_1 = arg_103_1 or arg_103_0._level

	if arg_103_1 > #Data._globalInfo._grainCapacity then
		arg_103_1 = #Data._globalInfo._grainCapacity
	end

	return Data._globalInfo._grainCapacity[arg_103_1]
end

function var_0_25.getBuyGoldTimes(arg_104_0)
	local var_104_0 = arg_104_0._vip + 1

	if var_104_0 > #Data._globalInfo._vipBuyGold then
		var_104_0 = #Data._globalInfo._vipBuyGold
	end

	return Data._globalInfo._vipBuyGold[var_104_0] - arg_104_0._dailyBuyGold
end

function var_0_25.getBuyGrainTimes(arg_105_0)
	local var_105_0 = arg_105_0._vip + 1

	if var_105_0 > #Data._globalInfo._vipBuyGrain then
		var_105_0 = #Data._globalInfo._vipBuyGrain
	end

	return Data._globalInfo._vipBuyGrain[var_105_0] - arg_105_0._dailyBuyGrain
end

function var_0_25.getBuyPacksNumber(arg_106_0)
	local var_106_0 = arg_106_0._vip + 1

	if var_106_0 > #Data._globalInfo._vipBuyPacks then
		var_106_0 = #Data._globalInfo._vipBuyPacks
	end

	return Data._globalInfo._vipBuyPacks[var_106_0] - arg_106_0._dailyBuyPacks
end

function var_0_25.getBuyHeroExpNumber(arg_107_0)
	local var_107_0 = arg_107_0._vip + 1

	if var_107_0 > #Data._globalInfo._vipBuyHeroExp then
		var_107_0 = #Data._globalInfo._vipBuyHeroExp
	end

	return Data._globalInfo._vipBuyHeroExp[var_107_0] - arg_107_0._dailyBuyHeroExp
end

function var_0_25.getBuyEquipExpNumber(arg_108_0)
	local var_108_0 = arg_108_0._vip + 1

	if var_108_0 > #Data._globalInfo._vipBuyEquipExp then
		var_108_0 = #Data._globalInfo._vipBuyEquipExp
	end

	return Data._globalInfo._vipBuyEquipExp[var_108_0] - arg_108_0._dailyBuyEquipExp
end

function var_0_25.getBuyHorseExpNumber(arg_109_0)
	local var_109_0 = arg_109_0._vip + 1

	if var_109_0 > #Data._globalInfo._vipBuyHorseExp then
		var_109_0 = #Data._globalInfo._vipBuyHorseExp
	end

	return Data._globalInfo._vipBuyHorseExp[var_109_0] - arg_109_0._dailyBuyHorseExp
end

function var_0_25.getBuyBookExpNumber(arg_110_0)
	local var_110_0 = arg_110_0._vip + 1

	if var_110_0 > #Data._globalInfo._vipBuyBookExp then
		var_110_0 = #Data._globalInfo._vipBuyBookExp
	end

	return Data._globalInfo._vipBuyBookExp[var_110_0] - arg_110_0._dailyBuyBookExp
end

function var_0_25.getBuyOrangeHeroFBoxNumber(arg_111_0)
	local var_111_0 = arg_111_0._vip + 1

	if var_111_0 > #Data._globalInfo._vipBuyChest1 then
		var_111_0 = #Data._globalInfo._vipBuyChest1
	end

	return Data._globalInfo._vipBuyChest1[var_111_0] - arg_111_0._dailyBuyOrangeHeroFBox
end

function var_0_25.getBuyPurpleHeroFBoxNumber(arg_112_0)
	local var_112_0 = arg_112_0._vip + 1

	if var_112_0 > #Data._globalInfo._vipBuyChest2 then
		var_112_0 = #Data._globalInfo._vipBuyChest2
	end

	return Data._globalInfo._vipBuyChest2[var_112_0] - arg_112_0._dailyBuyPurpleHeroFBox
end

function var_0_25.getBuyOrangeHorseFBoxNumber(arg_113_0)
	local var_113_0 = arg_113_0._vip + 1

	if var_113_0 > #Data._globalInfo._vipBuyChest3 then
		var_113_0 = #Data._globalInfo._vipBuyChest3
	end

	return Data._globalInfo._vipBuyChest3[var_113_0] - arg_113_0._dailyBuyOrangeHorseFBox
end

function var_0_25.getBuyPurpleHorseFBoxNumber(arg_114_0)
	local var_114_0 = arg_114_0._vip + 1

	if var_114_0 > #Data._globalInfo._vipBuyChest4 then
		var_114_0 = #Data._globalInfo._vipBuyChest4
	end

	return Data._globalInfo._vipBuyChest4[var_114_0] - arg_114_0._dailyBuyPurpleHorseFBox
end

function var_0_25.getBuyStoneNumber(arg_115_0)
	local var_115_0 = arg_115_0._vip + 1

	if var_115_0 > #Data._globalInfo._vipBuyStone then
		var_115_0 = #Data._globalInfo._vipBuyStone
	end

	return Data._globalInfo._vipBuyStone[var_115_0] - arg_115_0._dailyBuyStone
end

function var_0_25.getBuyRemedyNumber(arg_116_0)
	local var_116_0 = arg_116_0._vip + 1

	if var_116_0 > #Data._globalInfo._vipBuyRemedy then
		var_116_0 = #Data._globalInfo._vipBuyRemedy
	end

	return Data._globalInfo._vipBuyRemedy[var_116_0] - arg_116_0._dailyBuyRemedy
end

function var_0_25.getBuyRefreshTimes(arg_117_0, arg_117_1)
	if arg_117_1 == Data.MarketBuyType.random then
		return lc.arrayAt(Data._globalInfo._vipBuyRefresh, arg_117_0._vip + 1)
	elseif arg_117_1 == Data.MarketBuyType.flag or arg_117_1 == Data.MarketBuyType.union or arg_117_1 == Data.MarketBuyType.dragon_flag then
		return lc.arrayAt(Data._globalInfo._vipBuyRefreshEx, arg_117_0._vip + 1)
	end

	return 0
end

function var_0_25.getRemainBuyRefreshTimes(arg_118_0, arg_118_1)
	if arg_118_1 == Data.MarketBuyType.random then
		return lc.arrayAt(Data._globalInfo._vipBuyRefresh, arg_118_0._vip + 1) - arg_118_0._dailyBuyRefresh
	elseif arg_118_1 == Data.MarketBuyType.flag then
		return lc.arrayAt(Data._globalInfo._vipBuyRefreshEx, arg_118_0._vip + 1) - arg_118_0._dailyBuyRefreshPvp
	elseif arg_118_1 == Data.MarketBuyType.union then
		return lc.arrayAt(Data._globalInfo._vipBuyRefreshEx, arg_118_0._vip + 1) - arg_118_0._dailyBuyRefreshUnion
	elseif arg_118_1 == Data.MarketBuyType.dragon_flag then
		return lc.arrayAt(Data._globalInfo._vipBuyRefreshEx, arg_118_0._vip + 1) - arg_118_0._dailyBuyRefreshLadder
	end

	return 0
end

function var_0_25.getBuyRefreshCost(arg_119_0, arg_119_1, arg_119_2)
	if arg_119_1 == Data.MarketBuyType.random then
		if arg_119_2 == Data.ResType.ingot then
			return lc.arrayAt(Data._globalInfo._buyRefreshCost, arg_119_0._dailyBuyRefresh + 1)
		else
			return 1
		end
	elseif arg_119_1 == Data.MarketBuyType.flag then
		if arg_119_2 == Data.ResType.ingot then
			return lc.arrayAt(Data._globalInfo._buyRefreshPVPCost, arg_119_0._dailyBuyRefreshPvp + 1)
		else
			return Data._globalInfo._buyRefreshPVPCostEx
		end
	elseif arg_119_1 == Data.MarketBuyType.union then
		if arg_119_2 == Data.ResType.ingot then
			return lc.arrayAt(Data._globalInfo._buyRefreshUnionCost, arg_119_0._dailyBuyRefreshUnion + 1)
		else
			return Data._globalInfo._buyRefreshUnionCostEx
		end
	elseif arg_119_1 == Data.MarketBuyType.dragon_flag then
		if arg_119_2 == Data.ResType.ingot then
			return lc.arrayAt(Data._globalInfo._buyRefreshLadderCost, arg_119_0._dailyBuyRefreshLadder + 1)
		else
			return Data._globalInfo._buyRefreshLadderCostEx
		end
	end

	return 0
end

function var_0_25.getBuyShieldTimes(arg_120_0)
	local var_120_0 = arg_120_0._vip + 1

	if var_120_0 > #Data._globalInfo._vipBuyShield then
		var_120_0 = #Data._globalInfo._vipBuyShield
	end

	return Data._globalInfo._vipBuyShield[var_120_0] - arg_120_0._dailyBuyShield
end

function var_0_25.getCopyEliteTimes(arg_121_0)
	local var_121_0 = arg_121_0._vip + 1

	if var_121_0 > #Data._globalInfo._vipEliteCount then
		var_121_0 = #Data._globalInfo._vipEliteCount
	end

	return Data._globalInfo._vipEliteCount[var_121_0]
end

function var_0_25.getCopyCommanderTimes(arg_122_0)
	local var_122_0 = arg_122_0._vip + 1

	if var_122_0 > #Data._globalInfo._vipCommanderCount then
		var_122_0 = #Data._globalInfo._vipCommanderCount
	end

	return Data._globalInfo._vipCommanderCount[var_122_0]
end

function var_0_25.getCopyBossTimes(arg_123_0)
	local var_123_0 = arg_123_0._vip + 1

	if var_123_0 > #Data._globalInfo._vipRobGoldCount then
		var_123_0 = #Data._globalInfo._vipRobGoldCount
	end

	return Data._globalInfo._vipRobGoldCount[var_123_0]
end

function var_0_25.getCopyExpeditionTimes(arg_124_0)
	local var_124_0 = arg_124_0._vip + 1

	if var_124_0 > #Data._globalInfo._vipExpeditionCount then
		var_124_0 = #Data._globalInfo._vipExpeditionCount
	end

	return Data._globalInfo._vipExpeditionCount[var_124_0]
end

function var_0_25.getBuyCopyEliteRemainTimes(arg_125_0)
	local var_125_0 = arg_125_0._vip + 1

	if var_125_0 > #Data._globalInfo._vipBuyElite then
		var_125_0 = #Data._globalInfo._vipBuyElite
	end

	return Data._globalInfo._vipBuyElite[var_125_0] - arg_125_0._dailyBuyCopyElite
end

function var_0_25.getBuyCopyEliteIngot(arg_126_0)
	return 18 + arg_126_0._dailyBuyCopyElite * 10
end

function var_0_25.getBuyCopyBossRemainTimes(arg_127_0)
	local var_127_0 = arg_127_0._vip + 1

	if var_127_0 > #Data._globalInfo._vipBuyRobGold then
		var_127_0 = #Data._globalInfo._vipBuyRobGold
	end

	return Data._globalInfo._vipBuyRobGold[var_127_0] - arg_127_0._dailyBuyCopyBoss
end

function var_0_25.getBuyCopyBossIngot(arg_128_0)
	return 18 + arg_128_0._dailyBuyCopyBoss * 10
end

function var_0_25.getBuyCopyCommanderRemainTimes(arg_129_0)
	local var_129_0 = arg_129_0._vip + 1

	if var_129_0 > #Data._globalInfo._vipBuyCommander then
		var_129_0 = #Data._globalInfo._vipBuyCommander
	end

	return Data._globalInfo._vipBuyCommander[var_129_0] - arg_129_0._dailyBuyCopyCommander
end

function var_0_25.getBuyCopyCommanderIngot(arg_130_0)
	return 38 + arg_130_0._dailyBuyCopyCommander * 30
end

function var_0_25.getBuyCopyExpeditionRemainTimes(arg_131_0)
	local var_131_0 = arg_131_0._vip + 1

	if var_131_0 > #Data._globalInfo._vipBuyExpedition then
		var_131_0 = #Data._globalInfo._vipBuyExpedition
	end

	return Data._globalInfo._vipBuyExpedition[var_131_0] - arg_131_0._dailyBuyCopyExpedition
end

function var_0_25.getBuyCopyExpeditionIngot(arg_132_0)
	return Data._globalInfo._buyExpeditionIngot
end

function var_0_25.getCopyEliteRemainTimes(arg_133_0)
	return arg_133_0:getCopyEliteTimes() + arg_133_0._dailyBuyCopyElite - arg_133_0._dailyChallengeElite
end

function var_0_25.getCopyBossRemainTimes(arg_134_0)
	return arg_134_0:getCopyBossTimes() + arg_134_0._dailyBuyCopyBoss - arg_134_0._dailyCopyBoss
end

function var_0_25.getCopyCommanderRemainTimes(arg_135_0)
	return arg_135_0:getCopyCommanderTimes() + arg_135_0._dailyBuyCopyCommander - arg_135_0._dailyChallengeCommander
end

function var_0_25.getCopyExpeditionRemainTimes(arg_136_0)
	return arg_136_0:getCopyExpeditionTimes() + arg_136_0._dailyBuyCopyExpedition - arg_136_0._dailyExpedition
end

function var_0_25.getToadLevel(arg_137_0, arg_137_1)
	return (arg_137_1 or arg_137_0._level) - 25 + 1
end

function var_0_25.getCopyTimes(arg_138_0, arg_138_1)
	local var_138_0 = math.floor(arg_138_1 / 10)

	if var_138_0 == Data.CopyType.group_elite then
		return arg_138_0:getCopyEliteTimes()
	elseif var_138_0 == Data.CopyType.group_boss then
		return arg_138_0:getCopyBossTimes()
	elseif var_138_0 == Data.CopyType.group_commander then
		return arg_138_0:getCopyCommanderTimes()
	elseif var_138_0 == Data.CopyType.group_expedition then
		return arg_138_0:getCopyExpeditionTimes()
	end
end

function var_0_25.getCopyTotalTimes(arg_139_0, arg_139_1)
	local var_139_0 = math.floor(arg_139_1 / 10)

	if var_139_0 == Data.CopyType.group_elite then
		return arg_139_0:getCopyEliteTimes() + arg_139_0._dailyBuyCopyElite
	elseif var_139_0 == Data.CopyType.group_boss then
		return arg_139_0:getCopyBossTimes() + arg_139_0._dailyBuyCopyBoss
	elseif var_139_0 == Data.CopyType.group_commander then
		return arg_139_0:getCopyCommanderTimes() + arg_139_0._dailyBuyCopyCommander
	elseif var_139_0 == Data.CopyType.group_expedition then
		return arg_139_0:getCopyExpeditionTimes() + arg_139_0._dailyBuyCopyExpedition
	end
end

function var_0_25.getChallengeCopyRemainTimes(arg_140_0, arg_140_1)
	local var_140_0 = math.floor(arg_140_1 / 10)

	if var_140_0 == Data.CopyType.group_elite then
		return arg_140_0:getCopyEliteRemainTimes()
	elseif var_140_0 == Data.CopyType.group_boss then
		return arg_140_0:getCopyBossRemainTimes()
	elseif var_140_0 == Data.CopyType.group_commander then
		return arg_140_0:getCopyCommanderRemainTimes()
	elseif var_140_0 == Data.CopyType.group_expedition then
		return arg_140_0:getCopyExpeditionRemainTimes()
	end
end

function var_0_25.getBuyCopyRemainTimes(arg_141_0, arg_141_1)
	local var_141_0 = math.floor(arg_141_1 / 10)

	if var_141_0 == Data.CopyType.group_elite then
		return arg_141_0:getBuyCopyEliteRemainTimes()
	elseif var_141_0 == Data.CopyType.group_boss then
		return arg_141_0:getBuyCopyBossRemainTimes()
	elseif var_141_0 == Data.CopyType.group_commander then
		return arg_141_0:getBuyCopyCommanderRemainTimes()
	elseif var_141_0 == Data.CopyType.group_expedition then
		return arg_141_0:getBuyCopyExpeditionRemainTimes()
	end
end

function var_0_25.getBuyCopyIngot(arg_142_0, arg_142_1)
	local var_142_0 = math.floor(arg_142_1 / 10)

	if var_142_0 == Data.CopyType.group_elite then
		local var_142_1 = arg_142_1 % 10

		return arg_142_0:getBuyCopyEliteIngot(var_142_1)
	elseif var_142_0 == Data.CopyType.group_boss then
		return arg_142_0:getBuyCopyBossIngot()
	elseif var_142_0 == Data.CopyType.group_commander then
		return arg_142_0:getBuyCopyCommanderIngot()
	elseif var_142_0 == Data.CopyType.group_expedition then
		return arg_142_0:getBuyCopyExpeditionIngot()
	end
end

function var_0_25.accountCopyWin(arg_143_0, arg_143_1)
	local var_143_0 = math.floor(arg_143_1 / 10)

	if var_143_0 == Data.CopyType.group_elite then
		P._dailyChallengeElite = P._dailyChallengeElite + 1
	elseif var_143_0 == Data.CopyType.group_boss then
		P._dailyCopyBoss = P._dailyCopyBoss + 1
	elseif var_143_0 == Data.CopyType.group_commander then
		P._dailyChallengeCommander = P._dailyChallengeCommander + 1
	elseif var_143_0 == Data.CopyType.group_expedition then
		P._playerExpedition._chapter = P._playerExpedition._chapter + 1
	end
end

function var_0_25.addBuyCopyTimes(arg_144_0, arg_144_1)
	local var_144_0 = math.floor(arg_144_1 / 10)

	if var_144_0 == Data.CopyType.group_elite then
		arg_144_0._dailyBuyCopyElite = arg_144_0._dailyBuyCopyElite + 1
	elseif var_144_0 == Data.CopyType.group_boss then
		arg_144_0._dailyBuyCopyBoss = arg_144_0._dailyBuyCopyBoss + 1
	elseif var_144_0 == Data.CopyType.group_commander then
		arg_144_0._dailyBuyCopyCommander = arg_144_0._dailyBuyCopyCommander + 1
	elseif var_144_0 == Data.CopyType.group_expedition then
		arg_144_0._dailyBuyCopyExpedition = arg_144_0._dailyBuyCopyExpedition + 1
	end

	lc.sendEvent(Data.Event.copy_times_dirty, {
		_type = arg_144_1
	})
end

function var_0_25.getUnionBossRemainTimes(arg_145_0, arg_145_1)
	return Data._globalInfo._dailyAtkUBossCount - arg_145_0._dailyChallengeUBoss[arg_145_1]
end

function var_0_25.preCheckCondition(arg_146_0, arg_146_1, arg_146_2, arg_146_3)
	local var_146_0 = {}

	if arg_146_1 == 6 or arg_146_1 == 16 then
		var_146_0._cardType = nil
		var_146_0._type = 1
	elseif arg_146_1 >= 7 and arg_146_1 <= 9 then
		var_146_0._cardType = arg_146_1 - 6
		var_146_0._type = 1
	elseif arg_146_1 == 10 then
		return arg_146_0._playerCard:getTroopCardCountByMinStar(arg_146_2, arg_146_3) == 0
	elseif arg_146_1 == 11 then
		return arg_146_0._playerCard:getTroopCardCountByNature(arg_146_2, arg_146_3) == 0
	elseif arg_146_1 == 16 then
		var_146_0._cardType = nil
		var_146_0._type = 2
	elseif arg_146_1 >= 17 and arg_146_1 <= 19 then
		var_146_0._cardType = arg_146_1 - 16
		var_146_0._type = 2
	end

	if var_146_0._type ~= nil then
		local var_146_1 = arg_146_0._playerCard:getTroopCardCountByType(var_146_0._cardType, arg_146_3)

		if var_146_0._type == 1 then
			return arg_146_2 <= var_146_1
		elseif var_146_0._type == 2 then
			return var_146_1 <= arg_146_2
		end
	end

	return true
end

function var_0_25.getDailyGoldFlag(arg_147_0)
	if (Data._globalInfo._vipCollectGold[P._vip] or 5) - P._dailyCollectedGold > 0 and P._dailyNextSpawn < ClientData.getCurrentTime() then
		return 1
	end

	return 0
end

function var_0_25.getCharacterId(arg_148_0)
	local var_148_0

	if arg_148_0._avatar >= 52000 then
		var_148_0 = Data._skinInfo[arg_148_0._avatar]._infoId
	elseif arg_148_0._avatar >= 100 then
		var_148_0 = math.floor(arg_148_0._avatar / 100)
	else
		var_148_0 = arg_148_0._avatar

		if not Data._characterInfo[var_148_0] then
			var_148_0 = 2
		end
	end

	return var_148_0
end

function var_0_25.isCharacterUnlocked(arg_149_0, arg_149_1)
	return P._characters[arg_149_1] and P._characters[arg_149_1]._level > 0 or false
end

function var_0_25.canUnlockCharacter(arg_150_0, arg_150_1)
	local var_150_0 = true
	local var_150_1 = ""
	local var_150_2 = Data._characterInfo[arg_150_1]

	if not var_150_2 then
		var_150_0 = false

		return var_150_0, var_150_1
	end

	local var_150_3 = Str(STR.UNLOCK_CHARACTER_CONDITION)
	local var_150_4 = ""
	local var_150_5 = var_150_2.params[1]

	for iter_150_0 = 2, #var_150_2.params do
		local var_150_6 = var_150_2.params[iter_150_0]
		local var_150_7 = Data._characterInfo[var_150_6]

		var_150_4 = var_150_4 .. "|" .. Str(var_150_7._nameSid) .. "|"

		if iter_150_0 ~= #var_150_2.params then
			var_150_4 = var_150_4 .. Str(STR.COMMA_DUN)
		end

		if var_150_5 > arg_150_0._characters[var_150_6]._level then
			var_150_0 = false
		end
	end

	local var_150_8 = string.format(var_150_3, var_150_4, var_150_5)

	return var_150_0, var_150_8
end

function var_0_25.getCharacterUnlockIngot(arg_151_0, arg_151_1)
	return Data._globalInfo._unlockCharIngot
end

function var_0_25.getCharacterCount(arg_152_0)
	local var_152_0 = 0

	for iter_152_0, iter_152_1 in pairs(Data._characterInfo) do
		if iter_152_0 < 50 then
			var_152_0 = var_152_0 + 1
		end
	end

	return var_152_0
end

function var_0_25.getCharacterUnlockCount(arg_153_0)
	local var_153_0 = 0

	for iter_153_0, iter_153_1 in pairs(Data._characterInfo) do
		if var_0_25:isCharacterUnlocked(iter_153_0) then
			var_153_0 = var_153_0 + 1
		end
	end

	return var_153_0
end

function var_0_25.getLevel(arg_154_0, arg_154_1)
	return arg_154_0._characters[arg_154_1 or arg_154_0:getCharacterId()]._level
end

function var_0_25.getMaxCharacterLevel(arg_155_0)
	local var_155_0 = 0

	for iter_155_0, iter_155_1 in pairs(Data._characterInfo) do
		local var_155_1 = arg_155_0._characters[iter_155_0]._level

		if var_155_0 < var_155_1 then
			var_155_0 = var_155_1
		end
	end

	return var_155_0
end

function var_0_25.getTotalCharacterLevel(arg_156_0)
	local var_156_0 = 0

	for iter_156_0, iter_156_1 in pairs(Data._characterInfo) do
		var_156_0 = var_156_0 + arg_156_0._characters[iter_156_0]._level
	end

	return var_156_0
end

function var_0_25.isShowSpecialPackage(arg_157_0)
	return bit.band(arg_157_0._functionSwitch, 1) ~= 0
end

function var_0_25.isDoubleIngotEnabled(arg_158_0)
	if bit.band(arg_158_0._functionSwitch, 4) ~= 0 and ClientData.getValidActivityByType(607) ~= nil then
		return true
	end

	if ClientData.getValidActivityByType(Data.ActivityType.recharge_double) then
		return true
	end

	if arg_158_0:isNewBie2() and ClientData.getValidActivityByType(Data.ActivityType.newbie_recharge_double) then
		return true
	end

	return false
end

function var_0_25.getClashTargetStep(arg_159_0)
	local var_159_0 = #arg_159_0._playerBonus._bonusClashTarget

	for iter_159_0 = 1, #arg_159_0._playerBonus._bonusClashTarget do
		if not arg_159_0._playerBonus._bonusClashTarget[iter_159_0]._isClaimed then
			var_159_0 = iter_159_0

			break
		end
	end

	return var_159_0
end

function var_0_25.isNewBie(arg_160_0, arg_160_1)
	return (type(arg_160_1) == "table" and arg_160_1._param[3] or arg_160_1) > math.floor((ClientData.getCurrentTime() + P._timeOffset) / 86400) - math.floor((P._regTime + P._timeOffset) / 86400)
end

function var_0_25.isNewBie2(arg_161_0)
	return 1 > math.floor((ClientData.getCurrentTime() + P._timeOffset) / 86400) - math.floor((P._regTime + P._timeOffset) / 86400)
end

function var_0_25.isNewBieByServerOpenTime(arg_162_0, arg_162_1)
	local var_162_0 = math.floor((ClientData.getCurrentTime() + P._timeOffset) / 86400)
	local var_162_1 = math.floor((P._serverOpenTime + P._timeOffset) / 86400)

	return var_162_0 - var_162_1 >= 0 and arg_162_1 > var_162_0 - var_162_1
end

function var_0_25.resetCharacterSkin(arg_163_0, arg_163_1)
	arg_163_0._characters[arg_163_1]._skinId = nil

	arg_163_0:sendCharacterDirty()
	lc.sendEvent(Data.Event.skin_dirty)

	return true
end

function var_0_25.changeCharacterSkin(arg_164_0, arg_164_1)
	local var_164_0 = Data._skinInfo[arg_164_1]._infoId

	if not arg_164_0:isCharacterUnlocked(var_164_0) then
		return false
	end

	arg_164_0:changeCharacter(var_164_0)

	arg_164_0._characters[var_164_0]._skinId = arg_164_1

	arg_164_0:sendCharacterDirty()
	lc.sendEvent(Data.Event.skin_dirty)

	return true
end

function var_0_25.sendVoteRequest(arg_165_0, arg_165_1)
	local var_165_0 = ClientData.getCurrentTime()

	arg_165_0._voteTime = arg_165_0._voteTime or 0

	if var_165_0 - arg_165_0._voteTime > 30 then
		table.clear(arg_165_0._voteRecord)
		ClientData.sendVoteRecord(arg_165_1)

		return true
	else
		lc.sendEvent(Data.Event.vote_dirty)

		return false
	end
end

function var_0_25.parseVote(arg_166_0, arg_166_1)
	for iter_166_0, iter_166_1 in ipairs(arg_166_1) do
		arg_166_0._voteRecord[#arg_166_0._voteRecord + 1] = {
			_infoId = iter_166_1.key,
			_num = iter_166_1.value
		}
	end

	table.sort(arg_166_0._voteRecord, function(arg_167_0, arg_167_1)
		return arg_167_0._num > arg_167_1._num
	end)
	lc.sendEvent(Data.Event.vote_dirty)
end

function var_0_25.vote(arg_168_0, arg_168_1, arg_168_2, arg_168_3)
	local var_168_0 = false

	for iter_168_0, iter_168_1 in ipairs(arg_168_0._voteRecord) do
		if iter_168_1._infoId == arg_168_2 then
			iter_168_1._num = iter_168_1._num + arg_168_3
			var_168_0 = true

			break
		end
	end

	if not var_168_0 then
		arg_168_0._voteRecord[#arg_168_0._voteRecord + 1] = {
			_infoId = arg_168_2,
			_num = arg_168_3
		}
	end

	table.sort(arg_168_0._voteRecord, function(arg_169_0, arg_169_1)
		return arg_169_0._num > arg_169_1._num
	end)
	ClientData.sendVote(arg_168_1, arg_168_2, arg_168_3)
end

function var_0_25.getItemsToSend(arg_170_0)
	local var_170_0 = {}
	local var_170_1 = ClientData.getValidActivityByType(Data.ActivityType.exchange)

	if var_170_1 then
		local var_170_2 = var_170_1._param

		for iter_170_0, iter_170_1 in ipairs(var_170_2) do
			var_170_0[#var_170_0 + 1] = {
				_isBonus = true,
				_id = iter_170_1
			}
		end

		if P:getItemCount(Data.PropsId.vote_box) > 0 then
			var_170_0[#var_170_0 + 1] = {
				_id = Data.PropsId.vote_box
			}
		end
	end

	for iter_170_2, iter_170_3 in ipairs(P._playerCard._cards) do
		for iter_170_4, iter_170_5 in pairs(iter_170_3) do
			if Data.isGold(iter_170_4) and P:getItemCount(iter_170_4) > 0 then
				var_170_0[#var_170_0 + 1] = {
					_isGold = true,
					_id = iter_170_4
				}
			end
		end
	end

	return var_170_0
end

function var_0_25.isAllowChat(arg_171_0)
	return true, ""
end

function var_0_25.breakOutChar(arg_172_0, arg_172_1)
	if P:getItemCount(Data.PropsId.char_break_out_token) < 1 then
		return Data.ErrorType.need_more_count
	end

	P:addResource(Data.PropsId.char_break_out_token, 1, -1)

	arg_172_0._characters[arg_172_1]._breakOut = true

	lc.sendEvent(Data.Event.level_dirty)

	return Data.ErrorType.ok
end

function var_0_25.isCharBreakOut(arg_173_0, arg_173_1)
	return arg_173_0._characters[arg_173_1]._breakOut
end

function var_0_25.setNewRound(arg_174_0, arg_174_1)
	arg_174_0._isNewRound = arg_174_1

	ClientData.sendIsNewRound(arg_174_1)
end

return var_0_25
