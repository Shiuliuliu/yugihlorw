local var_0_0 = require("Bonus")
local var_0_1 = class("PlayerBonus")

function var_0_1.ctor(arg_1_0)
	arg_1_0._bonuses = {}
	arg_1_0._bonusesByType = {}
	arg_1_0._bonusesByCid = {}
	arg_1_0._serverBonuses = {}
	arg_1_0._sendBonuses = {}
	arg_1_0._bonusCount = 0
	arg_1_0._achievePoint = 0

	lc.addEventListener(Data.Event.level_dirty, function(arg_2_0)
		arg_1_0:onLevelDirty()
	end)
	lc.addEventListener(Data.Event.card_dirty, function(arg_3_0)
		arg_1_0:onCardDirty(arg_3_0._infoId)
	end)
	lc.addEventListener(Data.Event.card_add, function(arg_4_0)
		arg_1_0:onCardAdd(arg_4_0._infoId)
	end)
	lc.addEventListener(Data.Event.recharge_success, function(arg_5_0)
		if arg_5_0._type == Data.PurchaseType.month_card_1 or arg_5_0._type == Data.PurchaseType.month_card_2 then
			arg_1_0:onMonthCardDirty(arg_5_0._type)
		end
	end)
	lc.addEventListener(Data.Event.chapter_level_dirty, function(arg_6_0)
		arg_1_0:onChapterLevelDirty(arg_6_0._levelId)
	end)
	lc.addEventListener(Data.Event.city_sweep, function(arg_7_0)
		arg_1_0:onNoviceTaskDirty(2, arg_7_0._times)
	end)
	lc.addEventListener(Data.Event.hero_guard_dirty, function(arg_8_0)
		if arg_8_0._data._taskId == 0 then
			arg_1_0:onNoviceTaskDirty(3)
		end
	end)
	lc.addEventListener(Data.Event.palace_task_done, function(arg_9_0)
		arg_1_0:onNoviceTaskDirty(6)
	end)
	lc.addEventListener(Data.Event.pk_join, function(arg_10_0)
		arg_1_0:onNoviceTaskDirty(5)
	end)
	lc.addEventListener(Data.Event.hero_lottery, function(arg_11_0)
		arg_1_0:onNoviceTaskDirty(4, arg_11_0._times)
	end)
	lc.addEventListener(Data.Event.mix_hero, function(arg_12_0)
		arg_1_0:onNoviceTaskDirty(7)
	end)
	lc.addEventListener(Data.Event.book_lottery, function(arg_13_0)
		arg_1_0:onNoviceTaskDirty(8, arg_13_0._times)
	end)
	lc.addEventListener(Data.Event.time_hour_changed, function(arg_14_0)
		arg_1_0:checkGrainBonus()
	end)
	lc.addEventListener(Data.Event.clash_trophy_dirty, function(arg_15_0)
		arg_1_0:onTrophyDirty()
	end)
	lc.addEventListener(Data.Event.ladder_trophy_dirty, function(arg_16_0)
		arg_1_0:onLadderTrophyDirty()
	end)

	if ClientData._subChannelUid then
		lc.addEventListener(Data.Event.channel_level_dirty, function(arg_17_0)
			arg_1_0:updateChannelLevelBonus(arg_17_0._param)
			arg_1_0:updateChannelCumulativeBonus(math.floor(P:getTotalVipExp() / 10))
		end)
		lc.addEventListener(Data.Event.vip_exp_dirty, function(arg_18_0)
			arg_1_0:updateChannelCumulativeBonus(math.floor(P:getTotalVipExp() / 10))
		end)
	end

	ClientData.addMsgListener(arg_1_0, function(arg_19_0)
		return arg_1_0:onMsg(arg_19_0)
	end, 0)
end

function var_0_1.clear(arg_20_0)
	arg_20_0._bonusCount = 0
	arg_20_0._bonuses = {}
	arg_20_0._serverBonuses = {}
	arg_20_0._sendBonuses = {}

	arg_20_0:stopSchedule()
end

function var_0_1.splitBonus(arg_21_0, arg_21_1)
	local var_21_0 = {}
	local var_21_1 = {}
	local var_21_2 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0) do
		local var_21_3 = arg_21_1 and arg_21_1(iter_21_0, iter_21_1) or iter_21_1

		if iter_21_1._value >= iter_21_1._info._val then
			if iter_21_1._isClaimed then
				table.insert(var_21_2, var_21_3)
			else
				table.insert(var_21_0, var_21_3)
			end
		else
			table.insert(var_21_1, var_21_3)
		end
	end

	return var_21_0, var_21_1, var_21_2
end

function var_0_1.hashPbBonus(arg_22_0)
	local var_22_0 = {}
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.bonuses) do
		var_22_0[iter_22_1.cid] = iter_22_1.value
	end

	for iter_22_2, iter_22_3 in ipairs(arg_22_0.claimed) do
		var_22_1[iter_22_3] = true
	end

	return var_22_0, var_22_1
end

function var_0_1.init(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._fundResetCount = arg_23_1.task_reset_count or 0

	local var_23_0, var_23_1 = var_0_1.hashPbBonus(arg_23_1)

	if arg_23_2 == nil then
		arg_23_2 = true
	end

	table.clear(arg_23_0._bonusesByType)
	table.clear(arg_23_0._bonusesByCid)

	arg_23_0._bonusLord = {}
	arg_23_0._bonusLevel = {}
	arg_23_0._bonusChapter = {}
	arg_23_0._bonusCharacter = {}
	arg_23_0._bonusPassChapter = {}
	arg_23_0._bonusEquip = {}
	arg_23_0._bonusHorse = {}
	arg_23_0._bonusBook = {}
	arg_23_0._bonusDailyTask = {}
	arg_23_0._bonusGrainTask = {}

	if arg_23_2 then
		arg_23_0._bonusOnlineTask = {}
	end

	arg_23_0._bonusNoviceTask = {}
	arg_23_0._bonusFacebookTask = {}
	arg_23_0._bonusWeekCheckin = {}
	arg_23_0._bonusLogin = {}
	arg_23_0._bonusMonthCheckin = {}
	arg_23_0._bonusVipDaily = {}
	arg_23_0._bonusMonthCard = {}
	arg_23_0._bonusMonthCardBought = {}
	arg_23_0._bonusMonthCardPackage = {}
	arg_23_0._bonusActiveGift = {}
	arg_23_0._bonusPrivilegeGift = {}
	arg_23_0._bonusActivity = {}
	arg_23_0._bonusFundLevel = {}
	arg_23_0._bonusFundAll = {}
	arg_23_0._bonusInvite = {}
	arg_23_0._bonusClashTarget = {}
	arg_23_0._bonusClash = {}
	arg_23_0._bonusClashConti = {}
	arg_23_0._bonusClashLegacy = {}
	arg_23_0._bonusClashLocal = {}
	arg_23_0._bonusClashZone = {}
	arg_23_0._bonusArenaOnce = {}
	arg_23_0._bonusArenaAll = {}
	arg_23_0._bonusArena12 = {}
	arg_23_0._bonusGoldGain = {}
	arg_23_0._bonusGoldCost = {}
	arg_23_0._bonusGemCost = {}
	arg_23_0._bonusBottle = {}
	arg_23_0._bonusCardSr = {}
	arg_23_0._bonusCardUr = {}
	arg_23_0._bonusCardPackage = {}
	arg_23_0._bonusTeach = {}
	arg_23_0._bonusDailyActive = {}
	arg_23_0._bonusWeekActive = {}
	arg_23_0._loginDayBonus = {}
	arg_23_0._bonusFundTasks = {}
	arg_23_0._changedFundTasks = {}
	arg_23_0._allFundTasks = {}
	arg_23_0._anyLevelBonus = {}
	arg_23_0._bonusShare = {}
	arg_23_0._bonusWorship = {}
	arg_23_0._bonusPersonalFund = {}
	arg_23_0._bonusCumulativeNewBie = {}
	arg_23_0._bonusBadge = {}
	arg_23_0._bonusBadgeEx = {}
	arg_23_0._bonusBadgeEx2 = {}
	arg_23_0._channelBonuses = {}
	arg_23_0._newServerBonuses = {}
	arg_23_0._clashBonuses = {
		arg_23_0._bonusClash,
		arg_23_0._bonusClashConti,
		arg_23_0._bonusClashLegacy,
		arg_23_0._bonusClashLocal,
		arg_23_0._bonusClashZone
	}
	arg_23_0._arenaBonuses = {
		arg_23_0._bonusArenaOnce,
		arg_23_0._bonusArenaAll,
		arg_23_0._bonusArena12
	}
	arg_23_0._collectBonuses = {
		arg_23_0._bonusGoldGain,
		arg_23_0._bonusCardSr,
		arg_23_0._bonusCardUr,
		arg_23_0._loginDayBonus,
		arg_23_0._anyLevelBonus
	}
	arg_23_0._costBonuses = {
		arg_23_0._bonusGoldCost,
		arg_23_0._bonusGemCost,
		arg_23_0._bonusCardPackage,
		arg_23_0._bonusBottle
	}

	for iter_23_0, iter_23_1 in pairs(Data._bonusInfo) do
		if iter_23_1._cid > 0 or iter_23_1._type > 0 or Data.isPersonalFund(iter_23_1._id) then
			local var_23_2 = var_0_0.new(iter_23_0)
			local var_23_3 = var_23_2._type
			local var_23_4 = iter_23_1._cid

			var_23_2._value = var_23_0[iter_23_1._cid] or var_23_2._value
			var_23_2._isClaimed = var_23_1[iter_23_0] or var_23_2._isClaimed
			var_23_2._isDefaultClaimable = var_23_2._value >= iter_23_1._val

			if var_23_3 ~= Data.BonusType.online or arg_23_2 == true then
				arg_23_0._bonuses[iter_23_0] = var_23_2
			end

			arg_23_0._bonusesByType[var_23_3] = arg_23_0._bonusesByType[var_23_3] or {}
			arg_23_0._bonusesByType[var_23_3][#arg_23_0._bonusesByType[var_23_3] + 1] = var_23_2
			arg_23_0._bonusesByCid[var_23_4] = arg_23_0._bonusesByCid[var_23_4] or {}
			arg_23_0._bonusesByCid[var_23_4][#arg_23_0._bonusesByCid[var_23_4] + 1] = var_23_2

			if Data.isPersonalFund(var_23_2._infoId) then
				table.insert(arg_23_0._bonusPersonalFund, var_23_2)
			elseif ClientData._subChannelUid and iter_23_1._cid >= Data.BonusCid.channel_begin and iter_23_1._cid <= Data.BonusCid.channel_end then
				local var_23_5 = arg_23_0._channelBonuses[iter_23_1._cid] or {}

				arg_23_0._channelBonuses[iter_23_1._cid] = var_23_5
				var_23_5[#var_23_5 + 1] = var_23_2

				if iter_23_1._cid == Data.BonusCid.channel_launch then
					var_23_2._value = ClientData._isFromGameCenter and 1 or 0
				end
			elseif iter_23_1._cid >= Data.BonusCid.new_server_begin and iter_23_1._cid <= Data.BonusCid.new_server_travel_3 then
				local var_23_6 = iter_23_1._cid

				if var_23_6 == Data.BonusCid.new_server_travel_2 or var_23_6 == Data.BonusCid.new_server_travel_3 then
					var_23_6 = Data.BonusCid.new_server_travel
				end

				arg_23_0._newServerBonuses[var_23_6] = arg_23_0._newServerBonuses[var_23_6] or {}
				arg_23_0._newServerBonuses[var_23_6][#arg_23_0._newServerBonuses[var_23_6] + 1] = var_23_2
			elseif iter_23_1._cid >= Data.BonusCid.cumulative_newbie_start and iter_23_1._cid <= Data.BonusCid.cumulative_newbie_end then
				local var_23_7 = iter_23_1._cid - Data.BonusCid.cumulative_newbie_start + 1

				arg_23_0._bonusCumulativeNewBie[var_23_7] = arg_23_0._bonusCumulativeNewBie[var_23_7] or {}
				arg_23_0._bonusCumulativeNewBie[var_23_7][#arg_23_0._bonusCumulativeNewBie[var_23_7] + 1] = var_23_2
			elseif var_23_3 == Data.BonusType.lord then
				if iter_23_1._cid == 101 then
					table.insert(arg_23_0._bonusLord, var_23_2)
				else
					table.insert(arg_23_0._bonusChapter, var_23_2)
				end
			elseif var_23_3 == Data.BonusType.level then
				if var_23_2._info._val <= P:getMaxLevel() then
					table.insert(arg_23_0._bonusLevel, var_23_2)
				end
			elseif var_23_3 == Data.BonusType.free_badge_reward or var_23_3 == Data.BonusType.badge_reward then
				table.insert(arg_23_0._bonusBadge, var_23_2)
			elseif var_23_3 == Data.BonusType.free_badge_reward_ex or var_23_3 == Data.BonusType.badge_reward_ex then
				table.insert(arg_23_0._bonusBadgeEx, var_23_2)
			elseif var_23_3 == Data.BonusType.free_badge_reward_ex2 or var_23_3 == Data.BonusType.badge_reward_ex2 then
				table.insert(arg_23_0._bonusBadgeEx2, var_23_2)
			elseif var_23_3 == Data.BonusType.character then
				table.insert(arg_23_0._bonusCharacter, var_23_2)
			elseif var_23_3 == Data.BonusType.equip then
				table.insert(arg_23_0._bonusEquip, var_23_2)
			elseif var_23_3 == Data.BonusType.book then
				table.insert(arg_23_0._bonusBook, var_23_2)
			elseif var_23_3 == Data.BonusType.horse then
				table.insert(arg_23_0._bonusHorse, var_23_2)
			elseif var_23_3 == Data.BonusType.daily_task then
				table.insert(arg_23_0._bonusDailyTask, var_23_2)
			elseif var_23_3 == Data.BonusType.week_checkin then
				table.insert(arg_23_0._bonusWeekCheckin, var_23_2)
			elseif var_23_3 == Data.BonusType.login then
				table.insert(arg_23_0._bonusLogin, var_23_2)
			elseif var_23_3 == Data.BonusType.vip_daily then
				if iter_23_1._cid >= 1120 and iter_23_1._cid <= 1126 or iter_23_1._cid >= 1304 and iter_23_1._cid <= 1306 then
					arg_23_0._packageBonus = arg_23_0._packageBonus or {}
					arg_23_0._packageBonus[iter_23_1._cid] = var_23_2
				elseif iter_23_1._cid >= 1312 and iter_23_1._cid <= 1313 then
					arg_23_0._bonusActiveGift[iter_23_1._cid - 1311] = var_23_2
				elseif iter_23_1._cid >= 1405 and iter_23_1._cid <= 1406 then
					arg_23_0._bonusPrivilegeGift[iter_23_1._cid - 1404] = var_23_2
				else
					table.insert(arg_23_0._bonusVipDaily, var_23_2)
				end
			elseif var_23_3 == Data.BonusType.month_card then
				if iter_23_1._cid == 1321 or iter_23_1._cid == 1322 then
					arg_23_0._bonusMonthCardBought[iter_23_1._cid - 1320] = var_23_2
				elseif iter_23_1._cid >= 1308 and iter_23_1._cid <= 1311 then
					arg_23_0._bonusMonthCardPackage[iter_23_1._cid - 1307] = var_23_2
				else
					table.insert(arg_23_0._bonusMonthCard, var_23_2)
				end
			elseif var_23_3 == Data.BonusType.grain then
				table.insert(arg_23_0._bonusGrainTask, var_23_2)
			elseif var_23_3 == Data.BonusType.online then
				if iter_23_1._id == 4009 then
					arg_23_0._cardBonus = var_23_2
				elseif arg_23_2 then
					table.insert(arg_23_0._bonusOnlineTask, var_23_2)
				end
			elseif var_23_3 == Data.BonusType.novice then
				table.insert(arg_23_0._bonusNoviceTask, var_23_2)
			elseif var_23_3 == Data.BonusType.activity then
				table.insert(arg_23_0._bonusActivity, var_23_2)
			elseif var_23_3 == Data.BonusType.pass_chapter then
				table.insert(arg_23_0._bonusPassChapter, var_23_2)
			elseif var_23_3 == Data.BonusType.fund_level then
				var_23_2._value = P:getMaxCharacterLevel()

				table.insert(arg_23_0._bonusFundLevel, var_23_2)
			elseif var_23_3 == Data.BonusType.fund_all then
				table.insert(arg_23_0._bonusFundAll, var_23_2)
			elseif var_23_3 == Data.BonusType.invite then
				if iter_23_1._cid == 108 then
					table.insert(arg_23_0._bonusInvite, var_23_2)

					var_23_2._claimTimesMax = ({
						50,
						35,
						20,
						10,
						5
					})[iter_23_1._cid - 108 + 1]
					var_23_2._claimTimes = 0
				elseif iter_23_1._cid == 113 then
					arg_23_0._invitedBonus = var_23_2
				end
			elseif var_23_3 == Data.BonusType.facebook then
				table.insert(arg_23_0._bonusFacebookTask, var_23_2)
			elseif var_23_3 == Data.BonusType.clash_target then
				table.insert(arg_23_0._bonusClashTarget, var_23_2)
			elseif var_23_3 == Data.BonusType.clash then
				table.insert(arg_23_0._bonusClash, var_23_2)
			elseif var_23_3 == Data.BonusType.clash_conti then
				table.insert(arg_23_0._bonusClashConti, var_23_2)
			elseif var_23_3 == Data.BonusType.clash_legacy then
				table.insert(arg_23_0._bonusClashLegacy, var_23_2)
			elseif var_23_3 == Data.BonusType.clash_local then
				table.insert(arg_23_0._bonusClashLocal, var_23_2)
			elseif var_23_3 == Data.BonusType.clash_zone then
				table.insert(arg_23_0._bonusClashZone, var_23_2)
			elseif var_23_3 == Data.BonusType.arena_once then
				table.insert(arg_23_0._bonusArenaOnce, var_23_2)
			elseif var_23_3 == Data.BonusType.arena_all then
				table.insert(arg_23_0._bonusArenaAll, var_23_2)
			elseif var_23_3 == Data.BonusType.arena_12 then
				table.insert(arg_23_0._bonusArena12, var_23_2)
			elseif var_23_3 == Data.BonusType.gold_cost then
				table.insert(arg_23_0._bonusGoldCost, var_23_2)
			elseif var_23_3 == Data.BonusType.gold_gain then
				table.insert(arg_23_0._bonusGoldGain, var_23_2)
			elseif var_23_3 == Data.BonusType.gem_cost then
				table.insert(arg_23_0._bonusGemCost, var_23_2)
			elseif var_23_3 == Data.BonusType.bottle then
				table.insert(arg_23_0._bonusBottle, var_23_2)
			elseif var_23_3 == Data.BonusType.card_sr then
				table.insert(arg_23_0._bonusCardSr, var_23_2)
			elseif var_23_3 == Data.BonusType.card_ur then
				table.insert(arg_23_0._bonusCardUr, var_23_2)
			elseif var_23_3 == Data.BonusType.card_package then
				table.insert(arg_23_0._bonusCardPackage, var_23_2)
			elseif var_23_3 == Data.BonusType.teach then
				arg_23_0._bonusTeach[var_23_2._infoId] = var_23_2
			elseif var_23_3 == Data.BonusType.login_day then
				table.insert(arg_23_0._loginDayBonus, var_23_2)
			elseif var_23_3 == Data.BonusType.any_level then
				table.insert(arg_23_0._anyLevelBonus, var_23_2)
			elseif var_23_3 == Data.BonusType.daily_active then
				if var_23_2._info._cid == 3010 then
					table.insert(arg_23_0._bonusDailyActive, var_23_2)

					if not P._dailyActive and var_23_2._value then
						P._dailyActive = var_23_2._value
					end
				else
					table.insert(arg_23_0._bonusWeekActive, var_23_2)

					if not P._weekActive and var_23_2._value then
						P._weekActive = var_23_2._value
					end
				end
			elseif var_23_3 == Data.BonusType.return_to_game then
				arg_23_0._returnBonus = var_23_2
			elseif var_23_3 == Data.BonusType.fund_task then
				arg_23_0._allFundTasks[var_23_2._info._cid] = var_23_2

				if var_23_0[var_23_2._info._cid] ~= nil and not var_23_2._isClaimed then
					arg_23_0._bonusFundTasks[var_23_2._info._cid] = var_23_2
					arg_23_0._changedFundTasks[var_23_2._info._cid] = var_23_2._info._cid
				end
			elseif var_23_3 == Data.BonusType.share then
				arg_23_0._bonusShare[var_23_2._infoId] = var_23_2
			end

			if iter_23_1._cid == 705 then
				table.insert(arg_23_0._bonusWorship, var_23_2)
			end
		end
	end

	local var_23_8, var_23_9, var_23_10 = ClientData.getServerDate()

	for iter_23_2, iter_23_3 in pairs(Data._monthCheckinInfo) do
		if iter_23_3._month == var_23_10 then
			local var_23_11 = arg_23_0._bonuses[iter_23_3._bonusId]

			var_23_11._checkinInfo = iter_23_3

			table.insert(arg_23_0._bonusMonthCheckin, var_23_11)
		end
	end

	local var_23_12 = {
		arg_23_0._bonusDailyTask,
		arg_23_0._bonusLevel,
		arg_23_0._bonusBadge,
		arg_23_0._bonusBadgeEx,
		arg_23_0._bonusBadgeEx2,
		arg_23_0._bonusGrainTask,
		arg_23_0._bonusOnlineTask,
		arg_23_0._bonusWeekCheckin,
		arg_23_0._bonusLogin,
		arg_23_0._bonusMonthCheckin,
		arg_23_0._bonusVipDaily,
		arg_23_0._bonusMonthCard,
		arg_23_0._bonusLord,
		arg_23_0._bonusChapter,
		arg_23_0._bonusCharacter,
		arg_23_0._bonusEquip,
		arg_23_0._bonusHorse,
		arg_23_0._bonusBook,
		arg_23_0._bonusClashTarget,
		arg_23_0._bonusClash,
		arg_23_0._bonusClashConti,
		arg_23_0._bonusClashLegacy,
		arg_23_0._bonusClashLocal,
		arg_23_0._bonusClashZone,
		arg_23_0._bonusArenaOnce,
		arg_23_0._bonusArenaAll,
		arg_23_0._bonusArena12,
		arg_23_0._bonusGoldCost,
		arg_23_0._bonusGoldGain,
		arg_23_0._bonusGemCost,
		arg_23_0._bonusBottle,
		arg_23_0._bonusCardSr,
		arg_23_0._bonusCardUr,
		arg_23_0._bonusCardPackage,
		arg_23_0._bonusTeach,
		arg_23_0._bonusPersonalFund
	}

	for iter_23_4, iter_23_5 in ipairs(var_23_12) do
		table.sort(iter_23_5, function(arg_24_0, arg_24_1)
			if arg_24_0._info._cid == arg_24_1._info._cid then
				return arg_24_0._info._val < arg_24_1._info._val
			end

			return arg_24_0._info._cid < arg_24_1._info._cid
		end)
	end

	table.sort(arg_23_0._bonusNoviceTask, function(arg_25_0, arg_25_1)
		return arg_25_0._info._id < arg_25_1._info._id
	end)
	table.sort(arg_23_0._bonusDailyActive, function(arg_26_0, arg_26_1)
		return arg_26_0._info._id < arg_26_1._info._id
	end)
	table.sort(arg_23_0._bonusWeekActive, function(arg_27_0, arg_27_1)
		return arg_27_0._info._id < arg_27_1._info._id
	end)

	for iter_23_6, iter_23_7 in pairs(arg_23_0._bonusCumulativeNewBie) do
		table.sort(iter_23_7, function(arg_28_0, arg_28_1)
			return arg_28_0._info._id < arg_28_1._info._id
		end)
	end

	for iter_23_8, iter_23_9 in pairs(arg_23_0._channelBonuses) do
		table.sort(iter_23_9, function(arg_29_0, arg_29_1)
			return arg_29_0._info._id < arg_29_1._info._id
		end)
	end

	for iter_23_10, iter_23_11 in pairs(arg_23_0._newServerBonuses) do
		table.sort(iter_23_11, function(arg_30_0, arg_30_1)
			return arg_30_0._info._id < arg_30_1._info._id
		end)
	end

	for iter_23_12, iter_23_13 in ipairs(arg_23_0._bonusOnlineTask) do
		local var_23_13 = iter_23_13:getPrevBonus()

		if var_23_13 and iter_23_13._value < var_23_13._info._val then
			iter_23_13._value = var_23_13._info._val
		end

		iter_23_13._timestamp = ClientData.getCurrentTime()
	end

	arg_23_0:startSchedule()

	for iter_23_14, iter_23_15 in ipairs(arg_23_1.items) do
		local var_23_14 = arg_23_0._bonuses[iter_23_15.info_id]

		var_23_14._claimTimes = iter_23_15.num

		if var_23_14._claimTimes >= var_23_14._claimTimesMax then
			var_23_14._isClaimed = true
		end
	end

	arg_23_0:initIapCount(arg_23_1)
	arg_23_0:checkGrainBonus()
	arg_23_0:checkOnlineBonus()

	if ClientData._subChannelVipLevel then
		arg_23_0:updateChannelLevelBonus(ClientData._subChannelVipLevel)
		arg_23_0:updateChannelCumulativeBonus(math.floor(P:getTotalVipExp() / 10))
	end

	if not arg_23_2 then
		arg_23_0:updatePersonalFundValue()
	end

	arg_23_0:onNewServerLevelDirty(true)
end

function var_0_1.updatePersonalFundValue(arg_31_0, arg_31_1)
	local var_31_0 = false
	local var_31_1 = {}
	local var_31_2 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0._bonusPersonalFund) do
		local var_31_3 = math.ceil((iter_31_1._infoId - 10800) / 30) + Data.PurchaseType.personal_fund_1 - 1

		if var_31_1[var_31_3] == nil then
			var_31_1[var_31_3] = true
		end

		if not iter_31_1._isClaimed then
			var_31_1[var_31_3] = false
		end
	end

	for iter_31_2, iter_31_3 in ipairs(arg_31_0._bonusPersonalFund) do
		local var_31_4 = math.ceil((iter_31_3._infoId - 10800) / 30) + Data.PurchaseType.personal_fund_1 - 1
		local var_31_5 = P._playerActivity._personalFundStatus[var_31_4]

		if var_31_5 then
			local var_31_6 = math.ceil((ClientData.getExpireTimestamp(0) - var_31_5) / 24 / 3600)

			if var_31_4 <= Data.PurchaseType.personal_fund_4 and var_31_6 >= Data.PERSONAL_FUND_RESET and var_31_1[var_31_4] or var_31_4 == Data.PurchaseType.personal_fund_5 and var_31_6 >= Data.PERSONAL_FUND_RESET_2 and var_31_1[var_31_4] then
				iter_31_3._isClaimed = false
				iter_31_3._value = iter_31_3._info._val == 0 and -1 or 0
				iter_31_3._multiple = nil
				var_31_2[var_31_4] = true
			else
				iter_31_3._value = var_31_6
				iter_31_3._multiple = iter_31_3:isDouble() and 2 or 1
			end
		else
			iter_31_3._value = iter_31_3._info._val == 0 and -1 or 0
			iter_31_3._multiple = nil
		end
	end

	for iter_31_4, iter_31_5 in pairs(var_31_2) do
		P._playerActivity._personalFundStatus[iter_31_4] = nil
	end

	if not arg_31_1 then
		P:sendPersonalFundDirty()
	end
end

function var_0_1.getPersonalFundFlag(arg_32_0, arg_32_1)
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in ipairs(arg_32_0._bonusPersonalFund) do
		local var_32_1 = math.ceil((iter_32_1._infoId - 10800) / 30) + Data.PurchaseType.personal_fund_1 - 1

		if iter_32_1:canClaim() and var_32_1 <= Data.PurchaseType.personal_fund_4 then
			if not arg_32_1 then
				var_32_0 = var_32_0 + 1
			elseif arg_32_1 == var_32_1 then
				var_32_0 = var_32_0 + 1
			end
		end
	end

	return var_32_0
end

function var_0_1.getFund2BonusFlag(arg_33_0, arg_33_1)
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in ipairs(arg_33_0._bonusPersonalFund) do
		local var_33_1 = math.ceil((iter_33_1._infoId - 10800) / 30) + Data.PurchaseType.personal_fund_1 - 1

		if iter_33_1:canClaim() and var_33_1 == Data.PurchaseType.personal_fund_7 then
			if not arg_33_1 then
				var_33_0 = var_33_0 + 1
			elseif arg_33_1 == var_33_1 then
				var_33_0 = var_33_0 + 1
			end
		end
	end

	return var_33_0
end

function var_0_1.getExpFundBonusFlag(arg_34_0, arg_34_1)
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in ipairs(arg_34_0._bonusPersonalFund) do
		local var_34_1 = math.ceil((iter_34_1._infoId - 10800) / 30) + Data.PurchaseType.personal_fund_1 - 1

		if iter_34_1:canClaim() and var_34_1 == Data.PurchaseType.personal_fund_5 then
			if not arg_34_1 then
				var_34_0 = var_34_0 + 1
			elseif arg_34_1 == var_34_1 then
				var_34_0 = var_34_0 + 1
			end
		end
	end

	return var_34_0
end

function var_0_1.startSchedule(arg_35_0)
	arg_35_0:stopSchedule()

	arg_35_0._schedulerId = lc.Scheduler:scheduleScriptFunc(function(arg_36_0)
		arg_35_0:checkOnlineBonus()
	end, 1, false)
end

function var_0_1.stopSchedule(arg_37_0)
	if arg_37_0._schedulerId then
		lc.Scheduler:unscheduleScriptEntry(arg_37_0._schedulerId)

		arg_37_0._schedulerId = nil
	end
end

function var_0_1.checkGrainBonus(arg_38_0)
	if arg_38_0._bonusGrainTask == nil then
		return
	end

	local var_38_0 = ClientData.getServerDate()
	local var_38_1
	local var_38_2 = P._timeOffset / 3600

	for iter_38_0, iter_38_1 in ipairs(Data.GRAIN_TIME) do
		if var_38_0 >= iter_38_1[1] - var_38_2 and var_38_0 < iter_38_1[2] - var_38_2 then
			var_38_1 = arg_38_0._bonusGrainTask[iter_38_0]

			break
		end
	end

	if var_38_1 and var_38_1:setValue(1) then
		var_38_1:sendBonusDirty()
	end

	for iter_38_2, iter_38_3 in ipairs(arg_38_0._bonusGrainTask) do
		if iter_38_3 ~= var_38_1 and iter_38_3:setValue(0) then
			iter_38_3:sendBonusDirty()
		end
	end
end

function var_0_1.checkOnlineBonus(arg_39_0)
	if arg_39_0._bonusOnlineTask then
		for iter_39_0, iter_39_1 in ipairs(arg_39_0._bonusOnlineTask) do
			local var_39_0 = iter_39_1:getPrevBonus()

			if (var_39_0 == nil or var_39_0._isClaimed) and not iter_39_1._isClaimed then
				local var_39_1 = ClientData.getCurrentTime()

				iter_39_1._value = iter_39_1._value + (var_39_1 - iter_39_1._timestamp)
				iter_39_1._timestamp = var_39_1

				if iter_39_1._value >= iter_39_1._info._val then
					iter_39_1:sendBonusDirty()
				end

				break
			end
		end
	end

	if arg_39_0._cardBonus and not arg_39_0._cardBonus._isClaimed then
		arg_39_0._cardBonus._value = math.floor((ClientData.getCurrentTime() - P._regTime) / 3600)
	end
end

function var_0_1.getCommonBonusFlag(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = 0

	for iter_40_0, iter_40_1 in ipairs(arg_40_1) do
		if iter_40_1._value and iter_40_1._value >= iter_40_1._info._val and not iter_40_1._isClaimed and (arg_40_2 == nil or iter_40_1._info._cid == arg_40_2) then
			var_40_0 = var_40_0 + 1
		end
	end

	return var_40_0
end

function var_0_1.getNewServerBonusFlag(arg_41_0, arg_41_1)
	local var_41_0 = 0

	for iter_41_0 = Data.ActivityType.clash_bonus, Data.ActivityType.level_bonus do
		if (not arg_41_1 or arg_41_1 == iter_41_0) and ClientData.getValidActivityByType(iter_41_0) then
			local var_41_1 = P._playerBonus._newServerBonuses[iter_41_0 - Data.ActivityType.clash_bonus + Data.BonusCid.new_server_begin]

			var_41_0 = var_41_0 + P._playerBonus:getCommonBonusFlag(var_41_1)
		end
	end

	return var_41_0
end

function var_0_1.getActivityBonusFlag(arg_42_0)
	return arg_42_0:getFirstRechargeBonusFlag() + arg_42_0:getVipGiftBonusFlag()
end

function var_0_1.getCheckinBonusFlag(arg_43_0)
	return arg_43_0:getMonthCardBonusFlag() + arg_43_0:getMonthCard3BonusFlag() + arg_43_0:getWeekCheckinBonusFlag() + arg_43_0:getMonthCheckinBonusFlag() + arg_43_0:getLoginBonusFlag() + arg_43_0:getOnlineTaskBonusFlag()
end

function var_0_1.getFundBonusFlag(arg_44_0)
	return arg_44_0:getFundLevelBonusFlag() + arg_44_0:getFundAllBonusFlag()
end

function var_0_1.getFirstRechargeFlag(arg_45_0)
	local var_45_0 = P._playerBonus._packageBonus[1120]

	if ClientData.isGemRecharged() and var_45_0._value >= var_45_0._info._val and not var_45_0._isClaimed then
		return 1
	end

	return 0
end

function var_0_1.getRecharge7Flag(arg_46_0)
	local var_46_0 = P._playerBonus._packageBonus[1306]

	if var_46_0._value >= var_46_0._info._val and not var_46_0._isClaimed then
		return 1
	end

	return 0
end

function var_0_1.getReturnPackageFlag(arg_47_0)
	local var_47_0 = P._playerBonus._returnBonus

	if var_47_0 and var_47_0._value >= var_47_0._info._val and not var_47_0._isClaimed then
		return 1
	end

	return 0
end

function var_0_1.getInviteBonusFlag(arg_48_0)
	local var_48_0 = 0

	for iter_48_0, iter_48_1 in pairs(arg_48_0._bonusInvite) do
		if iter_48_1._value >= iter_48_1._info._val and not iter_48_1._isClaimed then
			var_48_0 = var_48_0 + 1
		end
	end

	return var_48_0
end

function var_0_1.getClaimCenterBonusFlag(arg_49_0)
	local var_49_0 = 0

	for iter_49_0, iter_49_1 in ipairs(arg_49_0._serverBonuses) do
		if not iter_49_1._isClaimed then
			var_49_0 = var_49_0 + 1
		end
	end

	return var_49_0
end

function var_0_1.getSendBonusFlag(arg_50_0)
	local var_50_0 = 0

	for iter_50_0, iter_50_1 in ipairs(arg_50_0._sendBonuses) do
		if not iter_50_1._isClaimed then
			var_50_0 = var_50_0 + 1
		end
	end

	return var_50_0
end

function var_0_1.getTaskBonusFlag(arg_51_0)
	if ClientData.isAppStoreReviewing() then
		return arg_51_0:getOnlineTaskBonusFlag()
	else
		return arg_51_0:getLevelTaskBonusFlag() + arg_51_0:getMainTaskBonusFlag() + arg_51_0:getOnlineTaskBonusFlag()
	end
end

function var_0_1.getDailyActiveBonusFlag(arg_52_0)
	local var_52_0 = 0

	for iter_52_0, iter_52_1 in ipairs(arg_52_0._bonusDailyActive) do
		if iter_52_1:canClaim() then
			var_52_0 = var_52_0 + 1
		end
	end

	return var_52_0
end

function var_0_1.getWeekActiveBonusFlag(arg_53_0)
	local var_53_0 = 0

	for iter_53_0, iter_53_1 in ipairs(arg_53_0._bonusWeekActive) do
		if iter_53_1:canClaim() then
			var_53_0 = var_53_0 + 1
		end
	end

	return var_53_0
end

function var_0_1.getFundTasksFlag(arg_54_0)
	local var_54_0 = 0

	for iter_54_0, iter_54_1 in pairs(arg_54_0._bonusFundTasks) do
		if iter_54_1:canClaim() then
			var_54_0 = var_54_0 + 1
		end
	end

	return var_54_0
end

function var_0_1.getAchieveBonusFlag(arg_55_0)
	local var_55_0 = arg_55_0:getLevelTaskBonusFlag() + arg_55_0:getMainTaskBonusFlag() + arg_55_0:getClashBonusesFlag() + arg_55_0:getArenaBonusesFlag() + arg_55_0:getCollectBonusFlag() + arg_55_0:getCostBonusFlag()

	arg_55_0._bonusCount = var_55_0

	return var_55_0
end

function var_0_1.getClashBonusesFlag(arg_56_0)
	local var_56_0 = 0

	for iter_56_0, iter_56_1 in ipairs(arg_56_0._clashBonuses) do
		for iter_56_2, iter_56_3 in ipairs(iter_56_1) do
			if iter_56_3:canClaim() then
				var_56_0 = var_56_0 + 1

				break
			end
		end
	end

	return var_56_0
end

function var_0_1.getClashBonusFlag(arg_57_0)
	local var_57_0 = 0

	for iter_57_0, iter_57_1 in ipairs(arg_57_0._bonusClash) do
		if iter_57_1:canClaim() then
			var_57_0 = var_57_0 + 1
		end
	end

	return var_57_0
end

function var_0_1.getClashContiBonusFlag(arg_58_0)
	local var_58_0 = 0

	for iter_58_0, iter_58_1 in ipairs(arg_58_0._bonusClashConti) do
		if iter_58_1:canClaim() then
			var_58_0 = var_58_0 + 1
		end
	end

	return var_58_0
end

function var_0_1.getClashLegacyBonusFlag(arg_59_0)
	local var_59_0 = 0

	for iter_59_0, iter_59_1 in ipairs(arg_59_0._bonusClashLegacy) do
		if iter_59_1:canClaim() then
			var_59_0 = var_59_0 + 1
		end
	end

	return var_59_0
end

function var_0_1.getClashLocalBonusFlag(arg_60_0)
	local var_60_0 = 0

	for iter_60_0, iter_60_1 in ipairs(arg_60_0._bonusClashLocal) do
		if iter_60_1:canClaim() then
			var_60_0 = var_60_0 + 1
		end
	end

	return var_60_0
end

function var_0_1.getClashZoneBonusFlag(arg_61_0)
	local var_61_0 = 0

	for iter_61_0, iter_61_1 in ipairs(arg_61_0._bonusClashZone) do
		if iter_61_1:canClaim() then
			var_61_0 = var_61_0 + 1
		end
	end

	return var_61_0
end

function var_0_1.getArenaBonusesFlag(arg_62_0)
	local var_62_0 = 0

	for iter_62_0, iter_62_1 in ipairs(arg_62_0._arenaBonuses) do
		for iter_62_2, iter_62_3 in ipairs(iter_62_1) do
			if iter_62_3:canClaim() then
				var_62_0 = var_62_0 + 1

				break
			end
		end
	end

	return var_62_0
end

function var_0_1.getArenaOnceBonusFlag(arg_63_0)
	local var_63_0 = 0

	for iter_63_0, iter_63_1 in ipairs(arg_63_0._bonusArenaOnce) do
		if iter_63_1:canClaim() then
			var_63_0 = var_63_0 + 1
		end
	end

	return var_63_0
end

function var_0_1.getArenaAllBonusFlag(arg_64_0)
	local var_64_0 = 0

	for iter_64_0, iter_64_1 in ipairs(arg_64_0._bonusArenaAll) do
		if iter_64_1:canClaim() then
			var_64_0 = var_64_0 + 1
		end
	end

	return var_64_0
end

function var_0_1.getArena12BonusFlag(arg_65_0)
	local var_65_0 = 0

	for iter_65_0, iter_65_1 in ipairs(arg_65_0._bonusArena12) do
		if iter_65_1:canClaim() then
			var_65_0 = var_65_0 + 1
		end
	end

	return var_65_0
end

function var_0_1.getCostBonusFlag(arg_66_0)
	local var_66_0 = 0

	for iter_66_0, iter_66_1 in ipairs(arg_66_0._costBonuses) do
		for iter_66_2, iter_66_3 in ipairs(iter_66_1) do
			if iter_66_3:canClaim() then
				var_66_0 = var_66_0 + 1

				break
			end
		end
	end

	return var_66_0
end

function var_0_1.getGoldGainBonusFlag(arg_67_0)
	local var_67_0 = 0

	for iter_67_0, iter_67_1 in ipairs(arg_67_0._bonusGoldGain) do
		if iter_67_1:canClaim() then
			var_67_0 = var_67_0 + 1
		end
	end

	return var_67_0
end

function var_0_1.getGoldCostBonusFlag(arg_68_0)
	local var_68_0 = 0

	for iter_68_0, iter_68_1 in ipairs(arg_68_0._bonusGoldCost) do
		if iter_68_1:canClaim() then
			var_68_0 = var_68_0 + 1
		end
	end

	return var_68_0
end

function var_0_1.getGemCostBonusFlag(arg_69_0)
	local var_69_0 = 0

	for iter_69_0, iter_69_1 in ipairs(arg_69_0._bonusGemCost) do
		if iter_69_1:canClaim() then
			var_69_0 = var_69_0 + 1
		end
	end

	return var_69_0
end

function var_0_1.getBottleBonusFlag(arg_70_0)
	local var_70_0 = 0

	for iter_70_0, iter_70_1 in ipairs(arg_70_0._bonusBottle) do
		if iter_70_1:canClaim() then
			var_70_0 = var_70_0 + 1
		end
	end

	return var_70_0
end

function var_0_1.getCollectBonusFlag(arg_71_0)
	local var_71_0 = 0

	for iter_71_0, iter_71_1 in ipairs(arg_71_0._collectBonuses) do
		for iter_71_2, iter_71_3 in ipairs(iter_71_1) do
			if iter_71_3:canClaim() then
				var_71_0 = var_71_0 + 1

				break
			end
		end
	end

	return var_71_0
end

function var_0_1.getCardSrBonusFlag(arg_72_0)
	local var_72_0 = 0

	for iter_72_0, iter_72_1 in ipairs(arg_72_0._bonusCardSr) do
		if iter_72_1:canClaim() then
			var_72_0 = var_72_0 + 1
		end
	end

	return var_72_0
end

function var_0_1.getCardUrBonusFlag(arg_73_0)
	local var_73_0 = 0

	for iter_73_0, iter_73_1 in ipairs(arg_73_0._bonusCardUr) do
		if iter_73_1:canClaim() then
			var_73_0 = var_73_0 + 1
		end
	end

	return var_73_0
end

function var_0_1.getCardPackageBonusFlag(arg_74_0)
	local var_74_0 = 0

	for iter_74_0, iter_74_1 in ipairs(arg_74_0._bonusCardPackage) do
		if iter_74_1:canClaim() then
			var_74_0 = var_74_0 + 1
		end
	end

	return var_74_0
end

function var_0_1.getDailyTaskBonusFlag(arg_75_0)
	local var_75_0 = 0

	for iter_75_0, iter_75_1 in ipairs(arg_75_0._bonusDailyTask) do
		if P._playerAchieve:getDailyTaskLevel(iter_75_1._info._cid % 100) <= P._level and iter_75_1._value >= iter_75_1._info._val and not iter_75_1._isClaimed then
			var_75_0 = var_75_0 + 1
		end
	end

	return var_75_0
end

function var_0_1.getMainTaskBonusFlag(arg_76_0)
	local var_76_0 = 0

	for iter_76_0, iter_76_1 in pairs(P._playerAchieve._mainTasks) do
		local var_76_1 = iter_76_1:getBonus()

		if iter_76_1:isValid() and var_76_1._value >= var_76_1._info._val then
			var_76_0 = var_76_0 + 1
		end
	end

	return var_76_0
end

function var_0_1.getGrainTaskBonusFlag(arg_77_0)
	local var_77_0 = 0

	for iter_77_0, iter_77_1 in ipairs(arg_77_0._bonusGrainTask) do
		if iter_77_1:canClaim() then
			var_77_0 = var_77_0 + 1
		end
	end

	return var_77_0
end

function var_0_1.getOnlineTaskBonusFlag(arg_78_0)
	for iter_78_0, iter_78_1 in ipairs(arg_78_0._bonusOnlineTask) do
		if iter_78_1:canClaim() then
			return 1
		end
	end

	return 0
end

function var_0_1.getNoviceTaskBonusFlag(arg_79_0)
	local var_79_0 = 0

	for iter_79_0, iter_79_1 in ipairs(arg_79_0._bonusNoviceTask) do
		local var_79_1 = iter_79_1._infoId % 100
		local var_79_2 = arg_79_0._bonusLogin[1]._value

		if iter_79_1._value >= iter_79_1._info._val and not iter_79_1._isClaimed and var_79_1 <= var_79_2 then
			var_79_0 = var_79_0 + 1
		end
	end

	return var_79_0
end

function var_0_1.getFacebookTaskBonusFlag(arg_80_0)
	local var_80_0 = 0

	for iter_80_0, iter_80_1 in ipairs(arg_80_0._bonusFacebookTask) do
		if iter_80_1._value >= iter_80_1._info._val and not iter_80_1._isClaimed then
			var_80_0 = var_80_0 + 1
		end
	end

	return var_80_0
end

function var_0_1.isAllNoviceTaskClaimed(arg_81_0)
	local var_81_0 = 0

	for iter_81_0, iter_81_1 in ipairs(arg_81_0._bonusNoviceTask) do
		if not iter_81_1._isClaimed then
			return false
		end
	end

	return true
end

function var_0_1.getLevelTaskBonusFlag(arg_82_0, arg_82_1)
	return arg_82_0:getCommonBonusFlag(arg_82_0._bonusLevel, arg_82_1)
end

function var_0_1.getMonthCardBonusFlag(arg_83_0)
	return arg_83_0:getCommonBonusFlag(arg_83_0._bonusMonthCard) - arg_83_0:getMonthCard3BonusFlag()
end

local var_0_2 = {
	Data.PurchaseType.month_card_3,
	Data.PurchaseType.month_card_4,
	Data.PurchaseType.month_card_5,
	Data.PurchaseType.month_card_6
}

function var_0_1.getMonthCard3BonusFlag(arg_84_0)
	local var_84_0 = 0

	for iter_84_0, iter_84_1 in ipairs(var_0_2) do
		local var_84_1, var_84_2 = arg_84_0:getBonusIdByPurchaseType(iter_84_1)

		var_84_0 = var_84_0 + arg_84_0:getCommonBonusFlag(arg_84_0._bonusesByCid[var_84_2])
	end

	return var_84_0
end

function var_0_1.getWeekCheckinBonusFlag(arg_85_0)
	return arg_85_0:getCommonBonusFlag(arg_85_0._bonusWeekCheckin)
end

function var_0_1.getMonthCheckinBonusFlag(arg_86_0)
	return arg_86_0:getCommonBonusFlag(arg_86_0._bonusMonthCheckin)
end

function var_0_1.getLoginBonusFlag(arg_87_0)
	return arg_87_0:getCommonBonusFlag(arg_87_0._bonusLogin)
end

function var_0_1.getVipDailyBonusFlag(arg_88_0)
	return arg_88_0:getCommonBonusFlag(arg_88_0._bonusVipDaily)
end

function var_0_1.getFundLevelBonusFlag(arg_89_0)
	local var_89_0 = 0
	local var_89_1 = ClientData.isRecharged(Data.PurchaseType.fund) or P:isUnionFundValid()

	for iter_89_0, iter_89_1 in ipairs(arg_89_0._bonusFundLevel) do
		if var_89_1 and iter_89_1._value >= iter_89_1._info._val and not iter_89_1._isClaimed then
			var_89_0 = var_89_0 + 1
		end
	end

	return var_89_0
end

function var_0_1.getFundAllBonusFlag(arg_90_0)
	return arg_90_0:getCommonBonusFlag(arg_90_0._bonusFundAll)
end

function var_0_1.getFundTaskBonusFlag(arg_91_0)
	local var_91_0 = 0

	for iter_91_0, iter_91_1 in pairs(arg_91_0._bonusFundTasks) do
		if iter_91_1._value >= iter_91_1._info._val and not iter_91_1._isClaimed then
			var_91_0 = var_91_0 + 1
		end
	end

	return var_91_0
end

function var_0_1.getChannelFlag(arg_92_0)
	local var_92_0 = 0

	for iter_92_0, iter_92_1 in pairs(arg_92_0._channelBonuses) do
		local var_92_1 = arg_92_0:getCommonBonusFlag(iter_92_1)

		if iter_92_0 == Data.BonusCid.channel_login then
			var_92_1 = math.min(1, var_92_1)
		end

		var_92_0 = var_92_0 + var_92_1
	end

	return var_92_0
end

function var_0_1.initIapCount(arg_93_0, arg_93_1)
	arg_93_0._iapCount = {
		0,
		0
	}

	for iter_93_0, iter_93_1 in ipairs(arg_93_1.bonuses) do
		if iter_93_1.cid == 4001 or iter_93_1.cid == 4002 then
			arg_93_0._iapCount[iter_93_1.cid - 4000] = iter_93_1.value
		end
	end
end

function var_0_1.getIapCount(arg_94_0, arg_94_1)
	if arg_94_1 == 1 or arg_94_1 == 2 then
		return (arg_94_0._iapCount[1] or 0) + (arg_94_0._iapCount[2] or 0)
	else
		return arg_94_0._iapCount[arg_94_1] or 0
	end
end

function var_0_1.incIapCount(arg_95_0, arg_95_1)
	if arg_95_0._iapCount[arg_95_1] ~= nil then
		arg_95_0._iapCount[arg_95_1] = arg_95_0._iapCount[arg_95_1] + 1
	end
end

function var_0_1.claimServerBonus(arg_96_0, arg_96_1)
	if arg_96_1 ~= nil then
		if arg_96_1._isClaimed then
			return Data.ErrorType.claimed
		end

		if arg_96_1._info then
			local var_96_0 = arg_96_1._info

			P:addResources(var_96_0._rid, var_96_0._level, var_96_0._count, var_96_0._isFragment)
		else
			P:addResourcesData(arg_96_1._extraBonus)
		end

		arg_96_1._isClaimed = true

		arg_96_1:sendBonusDirty()

		return Data.ErrorType.ok
	end

	return Data.ErrorType.error
end

function var_0_1.claimBonus(arg_97_0, arg_97_1)
	local var_97_0 = arg_97_0._bonuses[arg_97_1]

	if var_97_0 then
		local var_97_1 = var_97_0._info

		if var_97_0._isClaimed then
			return Data.ErrorType.claimed
		end

		if var_97_0._value < var_97_0._info._val then
			return Data.ErrorType.claim_not_support
		end

		local var_97_2 = {}

		for iter_97_0, iter_97_1 in ipairs(var_97_1._count) do
			table.insert(var_97_2, iter_97_1 * (var_97_0._multiple or 1))
		end

		P:addResources(var_97_1._rid, var_97_1._level, var_97_2, var_97_1._isFragment)
		arg_97_0:tryClaimBonusExtra(arg_97_1)

		if var_97_0._claimTimesMax then
			var_97_0._claimTimes = var_97_0._claimTimes + 1
			var_97_0._isClaimed = var_97_0._claimTimes >= var_97_0._claimTimesMax
		else
			if var_97_1._type == Data.BonusType.online then
				local var_97_3 = ClientData.getCurrentTime()

				for iter_97_2, iter_97_3 in ipairs(arg_97_0._bonusOnlineTask) do
					iter_97_3._timestamp = var_97_3
				end
			elseif var_97_1._type == Data.BonusType.pass_chapter then
				arg_97_0:onNoviceTaskDirty(1)
			end

			var_97_0._isClaimed = true
		end

		if Data.isPersonalFund(var_97_0._infoId) then
			arg_97_0:updatePersonalFundValue()
		end

		var_97_0:sendBonusDirty()

		return Data.ErrorType.ok
	end

	return Data.ErrorType.error
end

function var_0_1.tryClaimBonusExtra(arg_98_0, arg_98_1)
	local var_98_0, var_98_1 = ClientData.getValidActivityByTypeAndParam(525, arg_98_1)

	if var_98_0 == nil then
		return
	end

	local var_98_2 = var_98_0._bonusId[var_98_1]
	local var_98_3 = Data._bonusInfo[var_98_2]

	if var_98_3 == nil then
		return
	end

	P:addResources(var_98_3._rid, var_98_3._level, var_98_3._count, var_98_3._isFragment)
end

function var_0_1.supplyMonthCheckinBonus(arg_99_0, arg_99_1)
	local var_99_0 = arg_99_0._bonuses[arg_99_1]

	if var_99_0 ~= nil and var_99_0._type == Data.BonusType.month_checkin then
		if var_99_0._isClaimed then
			return Data.ErrorType.claimed
		end

		local var_99_1 = math.min(10 + P._monthlyRecheck * 10, Data._globalInfo._maxRecheckIngot)

		if not P:hasResource(Data.ResType.ingot, var_99_1) then
			return Data.ErrorType.need_more_ingot
		end

		if P._dayOfMonth >= var_99_0._info._val and var_99_0._info._val - var_99_0._value == 1 then
			for iter_99_0 = 1, #arg_99_0._bonusMonthCheckin do
				arg_99_0._bonusMonthCheckin[iter_99_0]._value = arg_99_0._bonusMonthCheckin[iter_99_0]._value + 1

				if arg_99_0._bonusMonthCheckin[iter_99_0] ~= var_99_0 then
					arg_99_0._bonusMonthCheckin[iter_99_0]:sendBonusDirty()
				end
			end

			P:changeResource(Data.ResType.ingot, -var_99_1)

			P._monthlyRecheck = P._monthlyRecheck + 1

			return arg_99_0:claimBonus(var_99_0._infoId)
		end
	end

	return Data.ErrorType.error
end

function var_0_1.onWeekActiveDirty(arg_100_0)
	for iter_100_0, iter_100_1 in ipairs(arg_100_0._bonusWeekActive) do
		iter_100_1._value = P._weekActive
	end
end

function var_0_1.onTrophyDirty(arg_101_0, arg_101_1)
	if not P:isNewBieByServerOpenTime(7) then
		return
	end

	arg_101_1 = arg_101_1 or P:getItemCount(Data.ResType.clash_trophy)

	for iter_101_0, iter_101_1 in ipairs(arg_101_0._newServerBonuses[Data.BonusCid.new_server_clash]) do
		if arg_101_1 > iter_101_1._value then
			iter_101_1._value = arg_101_1
		end
	end

	arg_101_0._newServerBonuses[Data.BonusCid.new_server_clash][1]:sendBonusDirty()
end

function var_0_1.onLadderTrophyDirty(arg_102_0, arg_102_1)
	if not P:isNewBieByServerOpenTime(7) then
		return
	end

	arg_102_1 = arg_102_1 or P:getItemCount(Data.ResType.ladder_trophy)

	for iter_102_0, iter_102_1 in ipairs(arg_102_0._newServerBonuses[Data.BonusCid.new_server_arena]) do
		if arg_102_1 > iter_102_1._value then
			iter_102_1._value = arg_102_1
		end
	end

	arg_102_0._newServerBonuses[Data.BonusCid.new_server_arena][1]:sendBonusDirty()
end

function var_0_1.checkBonusLevel(arg_103_0, arg_103_1)
	local var_103_0 = P:getCharacterId()
	local var_103_1 = P._characters[var_103_0]

	if arg_103_1._info._cid % 1000 == var_103_0 and arg_103_1._info._type == Data.BonusType.level and arg_103_1._value ~= var_103_1._level then
		local var_103_2 = arg_103_1._value

		arg_103_1._value = var_103_1._level

		arg_103_1:sendBonusDirty(var_103_2)
	end
end

function var_0_1.onLevelDirty(arg_104_0)
	for iter_104_0, iter_104_1 in ipairs(arg_104_0._bonusLord) do
		arg_104_0:checkBonusLevel(iter_104_1)
	end

	for iter_104_2, iter_104_3 in ipairs(arg_104_0._bonusLevel) do
		arg_104_0:checkBonusLevel(iter_104_3)
	end

	arg_104_0:onFundLevelDirty()
	arg_104_0:onNewServerLevelDirty()
end

function var_0_1.onFundLevelDirty(arg_105_0, arg_105_1)
	for iter_105_0, iter_105_1 in ipairs(arg_105_0._bonusFundLevel) do
		if iter_105_1._value ~= P:getMaxCharacterLevel() or arg_105_1 then
			local var_105_0 = iter_105_1._value

			iter_105_1._value = P:getMaxCharacterLevel()

			iter_105_1:sendBonusDirty(var_105_0)
		end
	end
end

function var_0_1.onNewServerLevelDirty(arg_106_0, arg_106_1)
	if not P:isNewBieByServerOpenTime(7) then
		return
	end

	for iter_106_0, iter_106_1 in ipairs(arg_106_0._newServerBonuses[Data.BonusCid.new_server_level]) do
		if iter_106_1._value ~= P:getTotalCharacterLevel() or arg_106_1 then
			local var_106_0 = iter_106_1._value

			iter_106_1._value = P:getTotalCharacterLevel()

			iter_106_1:sendBonusDirty(var_106_0)
		end
	end
end

function var_0_1.onFundNumDirty(arg_107_0)
	for iter_107_0, iter_107_1 in ipairs(arg_107_0._bonusFundAll) do
		local var_107_0 = iter_107_1._value

		iter_107_1._value = iter_107_1._value + 1

		iter_107_1:sendBonusDirty(var_107_0)
	end
end

function var_0_1.onCardDirty(arg_108_0, arg_108_1)
	local var_108_0, var_108_1 = Data.getInfo(arg_108_1)

	if var_108_1 == Data.CardType.monster then
		for iter_108_0, iter_108_1 in ipairs(arg_108_0._bonusCharacter) do
			local var_108_2 = iter_108_1._info._cid % 100
			local var_108_3 = false
			local var_108_4 = iter_108_1._value

			if var_108_2 == 4 and var_108_1 == Data.CardType.monster then
				-- block empty
			elseif var_108_2 == 5 and var_108_1 == Data.CardType.monster then
				-- block empty
			end

			if var_108_3 then
				iter_108_1:sendBonusDirty(var_108_4)
			end
		end
	end
end

function var_0_1.onCardAdd(arg_109_0, arg_109_1)
	if arg_109_1 == nil then
		return
	end

	local var_109_0, var_109_1 = Data.getInfo(arg_109_1)

	if var_109_1 == Data.CardType.monster then
		for iter_109_0 = 1, #arg_109_0._bonusCharacter do
			local var_109_2 = arg_109_0._bonusCharacter[iter_109_0]
			local var_109_3 = var_109_2._info._cid % 100
			local var_109_4 = false
			local var_109_5 = var_109_2._value

			if var_109_3 == 2 and var_109_0._quality == Data.CardQuality.SR then
				var_109_2._value = var_109_2._value + 1
				var_109_4 = true
			elseif var_109_3 == 3 and var_109_0._quality == Data.CardQuality.UR then
				var_109_2._value = var_109_2._value + 1
				var_109_4 = true
			end

			if var_109_4 then
				var_109_2:sendBonusDirty(var_109_5)
			end
		end
	end
end

function var_0_1.onMonthCardDirty(arg_110_0, arg_110_1)
	local var_110_0 = arg_110_1 - Data.PurchaseType.month_card_1 + 1
	local var_110_1 = arg_110_0._bonusMonthCard[var_110_0]

	var_110_1._value = var_110_1._info._val

	var_110_1:sendBonusDirty()
end

function var_0_1.onChapterLevelDirty(arg_111_0, arg_111_1)
	local function var_111_0(arg_112_0)
		local var_112_0 = math.floor(arg_111_1 / 10000)

		if math.floor(arg_112_0._info._val / 10000) == var_112_0 and arg_112_0._value ~= arg_111_1 then
			arg_112_0._value = arg_111_1

			arg_112_0:sendBonusDirty()
		end
	end

	for iter_111_0, iter_111_1 in ipairs(arg_111_0._bonusChapter) do
		var_111_0(iter_111_1)
	end

	for iter_111_2, iter_111_3 in ipairs(arg_111_0._bonusPassChapter) do
		var_111_0(iter_111_3)
	end

	if not P:isNewBieByServerOpenTime(7) then
		return
	end

	for iter_111_4, iter_111_5 in ipairs(arg_111_0._newServerBonuses[Data.BonusCid.new_server_travel]) do
		var_111_0(iter_111_5)
	end
end

function var_0_1.onNoviceTaskDirty(arg_113_0, arg_113_1, arg_113_2)
	return
end

function var_0_1.onFacebookTaskDirty(arg_114_0, arg_114_1, arg_114_2)
	for iter_114_0 = 1, #arg_114_0._bonusFacebookTask do
		local var_114_0 = arg_114_0._bonusFacebookTask[iter_114_0]

		if var_114_0._info._cid == arg_114_1 then
			var_114_0._value = arg_114_2 or 1

			var_114_0:sendBonusDirty()

			break
		end
	end
end

function var_0_1.sendBonusRequest(arg_115_0)
	local var_115_0 = SglMsgType_pb.PB_TYPE_BONUS_PLAYER_BONUS

	ClientData.sendBonusRequest(var_115_0)
end

function var_0_1.onMsg(arg_116_0, arg_116_1)
	local var_116_0 = arg_116_1.type
	local var_116_1 = arg_116_1.status

	if var_116_0 == SglMsgType_pb.PB_TYPE_BONUS_PLAYER_BONUS then
		arg_116_0:updateBonus(arg_116_1)
	elseif var_116_0 == SglMsgType_pb.PB_TYPE_BONUS_PLAYER_BONUS_AVAILABLE then
		arg_116_0._bonusCount = arg_116_1.Extensions[Bonus_pb.SglBonusMsg.bonus_count] or 0

		if ClientView.MenuUI ~= nil then
			ClientView.getMenuUI():updateAchieveFlag(arg_116_0._bonusCount)
		end
	elseif var_116_0 == SglMsgType_pb.PB_TYPE_BONUS_ACTIVITY then
		local var_116_2 = arg_116_1.Extensions[Bonus_pb.SglBonusMsg.bonus_activity_resp]

		for iter_116_0 = 1, #var_116_2 do
			local var_116_3 = require("ServerBonus").new(var_116_2[iter_116_0])

			if var_116_3._title and string.find(var_116_3._title, Str(STR.SEND_GIFT2)) then
				table.insert(arg_116_0._sendBonuses, var_116_3)
			else
				table.insert(arg_116_0._serverBonuses, var_116_3)
			end
		end

		table.sort(arg_116_0._sendBonuses, function(arg_117_0, arg_117_1)
			return arg_117_0._timestamp > arg_117_1._timestamp
		end)
		table.sort(arg_116_0._serverBonuses, function(arg_118_0, arg_118_1)
			return arg_118_0._timestamp > arg_118_1._timestamp
		end)

		local var_116_4 = cc.EventCustom:new(Data.Event.server_bonus_list_dirty)

		lc.Dispatcher:dispatchEvent(var_116_4)

		return true
	elseif var_116_0 == SglMsgType_pb.PB_TYPE_USER_SPAWN_GOLD then
		local var_116_5 = arg_116_1.Extensions[User_pb.SglUserMsg.user_spawn_gold_resp]

		P._dailyClaimedGold = var_116_5.gold
		P._dailyNextSpawn = var_116_5.next_spawn / 1000
		ClientData._isNewGoldClaim = true

		lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.daily_gold_dirty))

		return true
	elseif var_116_0 == SglMsgType_pb.PB_TYPE_BUY_FUND then
		arg_116_0:onFundNumDirty()

		return true
	elseif var_116_0 == SglMsgType_pb.PB_TYPE_BONUS_DAILY_TASK or var_116_0 == SglMsgType_pb.PB_TYPE_BONUS_DAILY_TASK_RESET then
		local var_116_6 = arg_116_1.Extensions[Bonus_pb.SglBonusMsg.daily_task]

		for iter_116_1, iter_116_2 in ipairs(var_116_6) do
			if arg_116_0._bonusFundTasks[iter_116_2.cid] then
				if arg_116_0._bonusFundTasks[iter_116_2.cid]._value ~= iter_116_2.value then
					if not arg_116_0._bonusFundTasks[iter_116_2.cid]:canClaim() and not arg_116_0._bonusFundTasks[iter_116_2.cid]._isClaimed and iter_116_2.value > 0 then
						arg_116_0._changedFundTasks[iter_116_2.cid] = iter_116_2.cid
					end

					arg_116_0._bonusFundTasks[iter_116_2.cid]._value = iter_116_2.value
				end
			elseif not iter_116_2._isClaimed then
				arg_116_0._bonusFundTasks[iter_116_2.cid] = arg_116_0._allFundTasks[iter_116_2.cid]
				arg_116_0._bonusFundTasks[iter_116_2.cid]._value = iter_116_2.value
				arg_116_0._bonusFundTasks[iter_116_2.cid]._isClaimed = false
				arg_116_0._changedFundTasks[iter_116_2.cid] = iter_116_2.cid
			end
		end

		lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.fund_task_dirty))
		NoticeManager.hideAll()

		local var_116_7 = 1

		for iter_116_3, iter_116_4 in pairs(arg_116_0._bonusFundTasks) do
			if var_116_7 > 5 then
				break
			end

			if arg_116_0._changedFundTasks[iter_116_4._info._cid] and iter_116_4._value > 0 then
				local var_116_8 = lc.createNode()
				local var_116_9 = lc.createSprite("fund_task_spr")

				var_116_9:setScale(0.5)

				local var_116_10 = ClientView.createTTF(string.gsub(string.format(Str(iter_116_4._info._nameSid), iter_116_4._info._val), "\\n", "") .. ": ", ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)
				local var_116_11 = ClientView.createTTF(iter_116_4._value .. "/" .. iter_116_4._info._val, ClientView.FontSize.S1, ClientView.COLOR_TEXT_INGOT)

				var_116_8:setContentSize(cc.size(lc.w(var_116_9) + lc.w(var_116_10) + lc.w(var_116_11) + 30, 50))
				lc.addNodesToCenter(var_116_8, {
					var_116_9,
					var_116_10,
					var_116_11
				}, 10)

				local var_116_12 = ccui.RichTextEx:create()

				var_116_12:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, var_116_8))
				NoticeManager.show(var_116_12, 5, 100)
			end

			var_116_7 = var_116_7 + 1
		end

		arg_116_0._changedFundTasks = {}

		return false
	elseif var_116_0 == SglMsgType_pb.PB_TYPE_BONUS_CLAIM_ENVELOPE or var_116_0 == SglMsgType_pb.PB_TYPE_BONUS_CLAIM_CHARGE_ENVELOPE then
		local var_116_13 = arg_116_1.Extensions[Bonus_pb.SglBonusMsg.envelope_res]

		ClientView.getActiveIndicator():hide()

		if var_116_13.num > 0 then
			require("RewardPanel").create({
				var_116_13
			}):show()
		else
			ToastManager.push(Str(STR.ENVELOPE_EMPTY))
		end
	elseif var_116_0 == SglMsgType_pb.PB_TYPE_BONUS_ENVELOPE_AVAILABLE then
		if P._guideID >= 500 and lc._runningScene._sceneId ~= ClientData.SceneId.loading and (lc._runningScene._sceneId ~= ClientData.SceneId.battle or lc.UserDefault:getBoolForKey("envelope_battle", true)) then
			ClientView.getEnvelopePanel():show()
		end

		return true
	elseif var_116_0 == SglMsgType_pb.PB_TYPE_BONUS_CHARGE_ENVELOPE_AVAILABLE then
		local var_116_14 = require("User").create(arg_116_1.Extensions[Bonus_pb.SglBonusMsg.charge_envelope_resp])

		if P._guideID >= 500 and lc._runningScene._sceneId ~= ClientData.SceneId.loading and (lc._runningScene._sceneId ~= ClientData.SceneId.battle or lc.UserDefault:getBoolForKey("envelope_battle", true)) then
			ClientView.getEnvelopePanel(var_116_14):show()
		end

		return true
	end

	return false
end

function var_0_1.updateBonus(arg_119_0, arg_119_1)
	local var_119_0 = arg_119_1.Extensions[Bonus_pb.SglBonusMsg.player_bonus]

	arg_119_0:init(var_119_0, false)
	P._playerAchieve:sendAchieveListDirty()
end

function var_0_1.sendResetFundTask(arg_120_0, arg_120_1)
	arg_120_0._bonusFundTasks[arg_120_1] = nil

	ClientData.sendResetFundTask(arg_120_1)

	arg_120_0._fundResetCount = arg_120_0._fundResetCount - 1
end

function var_0_1.updateChannelLevelBonus(arg_121_0, arg_121_1)
	local var_121_0 = arg_121_0._channelBonuses[Data.BonusCid.channel_vip_level]

	for iter_121_0, iter_121_1 in ipairs(var_121_0) do
		iter_121_1._value = arg_121_1
	end

	local var_121_1 = arg_121_0._channelBonuses[Data.BonusCid.channel_login]

	for iter_121_2, iter_121_3 in ipairs(var_121_1) do
		iter_121_3._value = arg_121_1
	end

	lc.sendEvent(Data.Event.channel_bonus_dirty)
end

function var_0_1.updateChannelCumulativeBonus(arg_122_0, arg_122_1)
	local var_122_0 = arg_122_0._channelBonuses[Data.BonusCid.channel_cumulative]

	for iter_122_0, iter_122_1 in ipairs(var_122_0) do
		iter_122_1._value = arg_122_1
	end

	lc.sendEvent(Data.Event.channel_bonus_dirty)
end

function var_0_1.getBonusByPurchaseType(arg_123_0, arg_123_1)
	local var_123_0, var_123_1 = arg_123_0:getBonusIdByPurchaseType(arg_123_1)

	if var_123_0 then
		return arg_123_0._bonuses[var_123_0]
	end

	if var_123_1 then
		return arg_123_0._bonusesByCid[var_123_1][1]
	end
end

function var_0_1.getBonusIdByPurchaseType(arg_124_0, arg_124_1)
	if arg_124_1 == Data.PurchaseType.arena_privilege_1 then
		return 3201
	elseif arg_124_1 == Data.PurchaseType.arena_privilege_2 then
		return 3202
	elseif arg_124_1 == Data.PurchaseType.survival_privilege_1 then
		return 3203
	elseif arg_124_1 == Data.PurchaseType.survival_privilege_2 then
		return 3204
	elseif arg_124_1 >= Data.PurchaseType.skill_1 and arg_124_1 <= Data.PurchaseType.skill_max then
		return arg_124_1 - Data.PurchaseType.skill_1 + 7559
	elseif arg_124_1 == Data.PurchaseType.daily_1 then
		return nil, 1304
	elseif arg_124_1 == Data.PurchaseType.daily_2 then
		return nil, 1305
	elseif arg_124_1 == Data.PurchaseType.daily_3 then
		return 7562
	elseif arg_124_1 == Data.PurchaseType.month_card_3 then
		return nil, 1303
	elseif arg_124_1 == Data.PurchaseType.month_card_4 then
		return nil, 1316
	elseif arg_124_1 == Data.PurchaseType.month_card_5 then
		return nil, 1317
	elseif arg_124_1 == Data.PurchaseType.month_card_6 then
		return nil, 1318
	end
end

return var_0_1
