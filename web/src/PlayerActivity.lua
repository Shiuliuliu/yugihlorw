local var_0_0 = class("PlayerActivity")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_0._ghost = arg_2_1.ghost
		arg_2_0._loginDays = arg_2_1.login
		arg_2_0._chargeIngot = arg_2_1.charge
		arg_2_0._chargeDays = arg_2_1.charge_ex
		arg_2_0._lastChargeTimestamp = arg_2_1.last_charge_ex
		arg_2_0._rebateIngot = arg_2_1.rebate
		arg_2_0._consumeIngot = arg_2_1.consume
		arg_2_0._privilegeStamp = arg_2_1.privilege_stamp / 1000
		arg_2_0._arenaPrivilegeTime = arg_2_1.last_ladder_ex_privilege / 1000
		arg_2_0._survivalPrivilegeTime = arg_2_1.last_survival_ex_privilege / 1000
		arg_2_0._personalFundStatus = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.personal_fund_status) do
			arg_2_0._personalFundStatus[iter_2_1.id] = iter_2_1.buy_time / 1000
		end

		P._playerBonus:updatePersonalFundValue(true)

		arg_2_0._doubleChargeDayLimitValue = arg_2_1.double_charge_day_limit_value
		ClientData._lotteryWeekPower = arg_2_1.turn_table_count

		if arg_2_1:HasField("bonus") then
			local var_2_0, var_2_1 = P._playerBonus.hashPbBonus(arg_2_1.bonus)

			for iter_2_2, iter_2_3 in ipairs(P._playerBonus._bonusActivity) do
				iter_2_3._value = var_2_0[iter_2_3._info._cid] or iter_2_3._value
				iter_2_3._isClaimed = var_2_1[iter_2_3._infoId] or iter_2_3._isClaimed
			end
		end

		arg_2_0._productBuyCounts = {}

		for iter_2_4, iter_2_5 in ipairs(arg_2_1.bundles) do
			arg_2_0._productBuyCounts[iter_2_5.info_id] = iter_2_5.num
		end
	end

	arg_2_0._actCharge = ClientData.getValidActivityByType(603)
	arg_2_0._actChargeGift = ClientData.getValidActivityByType(623)
end

function var_0_0.isPrivilegeValid(arg_3_0)
	return ClientData.getCurrentTime() < arg_3_0._privilegeStamp
end

function var_0_0.getPrivilegeTimeStr(arg_4_0)
	local var_4_0 = ClientData.getCurrentTime()

	if not arg_4_0:isPrivilegeValid() then
		return
	end

	local var_4_1 = arg_4_0._privilegeStamp - var_4_0
	local var_4_2 = math.floor(var_4_1 / 86400)
	local var_4_3 = var_4_1 % 86400
	local var_4_4 = math.floor(var_4_3 / 3600)
	local var_4_5 = math.floor(var_4_3 % 3600 / 60)

	return string.format(Str(STR.PRIVELEGE_EFFECTING_COUNTDOWN), var_4_2, var_4_4, var_4_5)
end

function var_0_0.clear(arg_5_0)
	arg_5_0._actNewRegionLegend = nil
	arg_5_0._actMarket = nil
	arg_5_0._actMarketOff = nil
	arg_5_0._actScore = nil
	arg_5_0._actConsume = nil
	arg_5_0._actDailyChargeTimes = nil
	arg_5_0._actCharge = nil
	arg_5_0._actRebate = nil
	arg_5_0._actChargeDays = info
	arg_5_0._actChargeBonus = info
	arg_5_0._actFlag2x = nil
	arg_5_0._actNormalFrag2x = nil
	arg_5_0._actMidFrag2x = nil
	arg_5_0._actHardFrag2x = nil
	arg_5_0._actGuardTower2x = nil
	arg_5_0._actContributeYubi2x = nil
	arg_5_0._actFestivalTask = nil
	arg_5_0._actCountryRecruit = nil
	arg_5_0._actFragRecruit = nil
	arg_5_0._actSplit = nil
	arg_5_0._actGift = nil
end

function var_0_0.genActivityKey(arg_6_0, arg_6_1)
	return arg_6_1._type[1] .. arg_6_1._beginTime .. arg_6_1._endTime
end

function var_0_0.parseTime(arg_7_0, arg_7_1)
	if arg_7_1 == nil or arg_7_1 == "" then
		return 0
	end

	local var_7_0 = tonumber(arg_7_1)

	if var_7_0 then
		return P._serverOpenTimestamp + (var_7_0 - 1) * Data.DAY_SECONDS
	else
		return ClientData.parseTimeStr(arg_7_1)
	end
end

function var_0_0.isVisible(arg_8_0, arg_8_1)
	if ClientData._cfg.testActivity then
		return true
	end

	if ClientData.getDaysAfterServerOpen() <= Data.NEW_REGION_DAYS then
		if arg_8_1._id < 1000 and arg_8_1._isShare == 0 and (arg_8_1._type[1] ~= 105 or arg_8_0._actNewRegionLegend) then
			return false
		end
	elseif (arg_8_1._id >= 1000 or arg_8_1._isShare == 0 and arg_8_1._beginTimestamp > 0 and P._newRegionCloseTimestamp > arg_8_1._beginTimestamp) and arg_8_1._type[1] ~= 105 then
		return false
	end

	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_1._gameType) do
		if ClientData.getGameType() == iter_8_1 then
			var_8_0 = true

			break
		end
	end

	if var_8_0 then
		if arg_8_1._type[1] == 401 and P._playerBonus._bonusLogin[1]._value > 8 then
			return false
		end

		local var_8_1 = arg_8_1._visibleTime

		if var_8_1 == "" then
			return true
		end

		local var_8_2 = string.splitByChar(var_8_1, "-")
		local var_8_3 = ClientData.getCurrentTime()

		if var_8_3 >= arg_8_0:parseTime(var_8_2[1]) then
			if var_8_2[2] then
				return var_8_3 <= arg_8_0:parseTime(var_8_2[2])
			else
				return true
			end
		end
	end

	return false
end

function var_0_0.hasVisibleActivities(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(Data._activityInfo) do
		if arg_9_0:isVisible(iter_9_1) then
			return true
		end
	end

	return false
end

function var_0_0.isValid(arg_10_0, arg_10_1)
	local var_10_0 = ClientData.getCurrentTime()

	return var_10_0 >= arg_10_1._beginTimestamp and (var_10_0 < arg_10_1._endTimestamp or arg_10_1._endTimestamp == 0)
end

function var_0_0.getNewActivityCount(arg_11_0)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(Data._activityInfo) do
		if arg_11_0:isActivityNew(iter_11_1) then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

function var_0_0.isActivityNew(arg_12_0, arg_12_1)
	if not arg_12_0:isValid(arg_12_1) or not arg_12_0:isVisible(arg_12_1) then
		return false
	end

	arg_12_1 = type(arg_12_1) == "number" and Data._activityInfo[arg_12_1] or arg_12_1

	local var_12_0 = arg_12_0:genActivityKey(arg_12_1)

	return lc.readConfig(var_12_0, 0) == 0
end

function var_0_0.readActivity(arg_13_0, arg_13_1)
	if not arg_13_0:isValid(arg_13_1) or not arg_13_0:isVisible(arg_13_1) then
		return
	end

	arg_13_1 = type(arg_13_1) == "number" and Data._activityInfo[arg_13_1] or arg_13_1

	local var_13_0 = arg_13_0:genActivityKey(arg_13_1)

	lc.writeConfig(var_13_0, ClientData.getCurrentTime())
end

function var_0_0.checkChargeDays(arg_14_0)
	if arg_14_0._actChargeBonus == nil then
		return
	end

	local var_14_0, var_14_1 = ClientData.getServerDate()
	local var_14_2, var_14_3 = ClientData.getServerDate(arg_14_0._lastChargeTimestamp)

	if var_14_1 ~= var_14_3 then
		arg_14_0._chargeDays = arg_14_0._chargeDays + 1
		arg_14_0._lastChargeTimestamp = ClientData.getCurrentTime()
	end
end

function var_0_0.getActivitiesToShow(arg_15_0)
	local var_15_0 = {}

	if not ClientData.isAppStoreReviewing() then
		if not ClientData.isActivityShowed(Data.PurchaseType.return_to_game) and ClientData.isReturnToGame() and not ClientData.isReturnToGameClaimed() then
			table.insert(var_15_0, Data.PurchaseType.return_to_game)
		end

		for iter_15_0 = Data.PurchaseType.limit_3, Data.PurchaseType.limit_8 do
			if not ClientData.isActivityShowed(iter_15_0) and ClientData.isActivityValidByParam(iter_15_0) and (iter_15_0 ~= Data.PurchaseType.limit_6 or P:isNewBie2()) then
				table.insert(var_15_0, iter_15_0)
			end
		end

		local var_15_1 = lc.PLATFORM == cc.PLATFORM_OS_ANDROID and {
			Data.PurchaseType.limit_0,
			Data.PurchaseType.limit_2,
			Data.PurchaseType.limit_1,
			Data.PurchaseType.limit_minus_1
		} or {
			Data.PurchaseType.limit_0,
			Data.PurchaseType.limit_2,
			Data.PurchaseType.limit_1,
			Data.PurchaseType.limit_minus_1,
			Data.PurchaseType.limit_minus_2
		}

		for iter_15_1 = 1, #var_15_1 do
			local var_15_2 = var_15_1[iter_15_1]

			if not ClientData.isActivityShowed(var_15_2) and ClientData.isActivityValidByParam(var_15_2) and not ClientData.isRecharged(var_15_2) and ClientData.isRecharged(Data.PurchaseType.package_1) then
				table.insert(var_15_0, var_15_2)
			end
		end

		-- Disable ad popups on login
		-- if not ClientData.isActivityShowed(Data.PurchaseType.ad_recharge) and not ClientData.isGemRecharged() then
		-- 	table.insert(var_15_0, Data.PurchaseType.ad_recharge)
		-- end
		-- if not ClientData.isActivityShowed(Data.PurchaseType.ad_package) and not ClientData.isRecharged(Data.PurchaseType.package_1) then
		-- 	table.insert(var_15_0, Data.PurchaseType.ad_package)
		-- end

		if not ClientData.isActivityShowed(Data.ActivityType.yyb) then
			table.insert(var_15_0, ClientData.getValidActivityByType(Data.ActivityType.yyb))
		end
	end

	return var_15_0
end

function var_0_0.getPersonalFundBuyActivity(arg_16_0)
	return ClientData.getValidActivityByType(608)
end

function var_0_0.getPersonalFundClaimActivity(arg_17_0)
	return ClientData.getValidActivityByType(609)
end

function var_0_0.getPersonalFundTimeStr(arg_18_0)
	local var_18_0 = arg_18_0:getPersonalFundBuyActivity() or ClientData.getActivityByType(608)
	local var_18_1 = arg_18_0:getPersonalFundClaimActivity() or ClientData.getActivityByType(609)
	local var_18_2, var_18_3 = ClientData.getActivityDurationStr(var_18_0, true)
	local var_18_4, var_18_5 = ClientData.getActivityDurationStr(var_18_1, true)
	local var_18_6 = string.format(Str(STR.PERSONAL_FUND_TIP_1), var_18_3)
	local var_18_7 = string.format(Str(STR.PERSONAL_FUND_TIP_2), var_18_5)

	return var_18_6, var_18_7
end

function var_0_0.isShowPersonalFund(arg_19_0)
	return arg_19_0:getPersonalFundBuyActivity() or arg_19_0:getPersonalFundClaimActivity()
end

function var_0_0.is315Recharged(arg_20_0, arg_20_1)
	if not (arg_20_1 >= Data.PurchaseType.product_1) or not (arg_20_1 <= Data.PurchaseType.product_8) then
		return true
	end

	local var_20_0 = arg_20_1 - Data.PurchaseType.product_1

	return bit.band(arg_20_0._doubleChargeDayLimitValue, bit.lshift(1, var_20_0)) ~= 0
end

function var_0_0.set315Recharged(arg_21_0, arg_21_1)
	if not (arg_21_1 >= Data.PurchaseType.product_1) or not (arg_21_1 <= Data.PurchaseType.product_8) then
		return
	end

	local var_21_0 = arg_21_1 - Data.PurchaseType.product_1

	arg_21_0._doubleChargeDayLimitValue = bit.bor(arg_21_0._doubleChargeDayLimitValue, bit.lshift(1, var_21_0))
end

function var_0_0.getPurchaseRemainDay(arg_22_0, arg_22_1)
	local var_22_0 = P._playerBonus:getBonusIdByPurchaseType(arg_22_1)
	local var_22_1 = P._playerBonus._bonuses[var_22_0]

	if arg_22_1 == Data.PurchaseType.arena_privilege_1 or arg_22_1 == Data.PurchaseType.arena_privilege_2 then
		local var_22_2 = 0

		if var_22_1._value > 0 then
			var_22_2 = arg_22_0._arenaPrivilegeTime
		end

		if var_22_2 == 0 then
			return 0
		end

		local var_22_3 = math.floor((ClientData.getCurrentTime() + P._timeOffset) / 86400)

		return math.floor((var_22_2 + P._timeOffset) / 86400) - var_22_3
	elseif arg_22_1 == Data.PurchaseType.survival_privilege_1 or arg_22_1 == Data.PurchaseType.survival_privilege_2 then
		local var_22_4 = 0

		if var_22_1._value > 0 then
			var_22_4 = arg_22_0._survivalPrivilegeTime
		end

		if var_22_4 == 0 then
			return 0
		end

		local var_22_5 = math.floor((ClientData.getCurrentTime() + P._timeOffset) / 86400)

		return math.floor((var_22_4 + P._timeOffset) / 86400) - var_22_5
	end

	return 0
end

function var_0_0.addPurchaseRemainDay(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = math.floor(ClientData.getCurrentTime())
	local var_23_1 = var_23_0 - var_23_0 % 86400 - 28800
	local var_23_2 = P._playerBonus:getBonusIdByPurchaseType(arg_23_1)
	local var_23_3 = P._playerBonus._bonuses[var_23_2]

	if arg_23_1 == Data.PurchaseType.arena_privilege_1 or arg_23_1 == Data.PurchaseType.arena_privilege_2 then
		var_23_3._value = var_23_3._value + 1
		arg_23_0._arenaPrivilegeTime = math.max(arg_23_0._arenaPrivilegeTime or 0, var_23_1) + arg_23_2 * 86400
	end

	if arg_23_1 == Data.PurchaseType.survival_privilege_1 or arg_23_1 == Data.PurchaseType.survival_privilege_2 then
		var_23_3._value = var_23_3._value + 1
		arg_23_0._survivalPrivilegeTime = math.max(arg_23_0._survivalPrivilegeTime or 0, var_23_1) + arg_23_2 * 86400
	end
end

PlayerActivity = var_0_0

return var_0_0
