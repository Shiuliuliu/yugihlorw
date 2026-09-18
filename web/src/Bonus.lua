local var_0_0 = class("Bonus")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._infoId = arg_1_1
	arg_1_0._info = Data._bonusInfo[arg_1_1]
	arg_1_0._type = arg_1_0._info._type
	arg_1_0._value = 0
	arg_1_0._isClaimed = false
end

function var_0_0.sendBonusDirty(arg_2_0, arg_2_1)
	if arg_2_0._task and not arg_2_0._task:isValid() then
		return
	end

	local var_2_0 = cc.EventCustom:new(Data.Event.bonus_dirty)

	var_2_0._data = arg_2_0
	var_2_0._lastValue = arg_2_1

	lc.Dispatcher:dispatchEvent(var_2_0)

	if arg_2_0._info._cid >= Data.BonusCid.channel_begin and arg_2_0._info._cid <= Data.BonusCid.channel_end then
		lc.sendEvent(Data.Event.channel_bonus_dirty)
	end

	if arg_2_0._value and arg_2_0._value >= arg_2_0._info._val and not arg_2_0._isDefaultClaimable then
		arg_2_0._isDefaultClaimable = true
	end
end

function var_0_0.setValue(arg_3_0, arg_3_1)
	if arg_3_1 == arg_3_0._value then
		return false
	end

	arg_3_0._value = arg_3_1

	return true
end

function var_0_0.isChapter(arg_4_0)
	local var_4_0 = arg_4_0._info._cid

	return var_4_0 == 103 or var_4_0 == 104 or var_4_0 == 105
end

function var_0_0.isTeach(arg_5_0)
	return arg_5_0._info._type == Data.BonusType.teach
end

function var_0_0.canClaim(arg_6_0)
	local var_6_0 = arg_6_0._info

	if not (arg_6_0._value >= var_6_0._val and (var_6_0._val > 0 or Data.isPersonalFund(arg_6_0._infoId)) and not arg_6_0._isClaimed) then
		return false
	end

	if var_6_0._type == Data.BonusType.online then
		local var_6_1 = arg_6_0:getPrevBonus()

		if var_6_1 ~= nil and not var_6_1._isClaimed then
			return false
		end
	elseif var_6_0._type == Data.BonusType.fund_level then
		return ClientData.isRecharged(Data.PurchaseType.fund) or P:isUnionFundValid()
	elseif var_6_0._type == Data.BonusType.invite then
		return arg_6_0._claimTimes < arg_6_0._claimTimesMax and arg_6_0._value > arg_6_0._claimTimes
	end

	return true
end

function var_0_0.getPrevBonus(arg_7_0)
	local var_7_0 = arg_7_0._info
	local var_7_1 = P._playerBonus._bonuses[var_7_0._id - 1]

	if var_7_1 ~= nil and var_7_1._info._type ~= arg_7_0._type then
		var_7_1 = nil
	end

	return var_7_1
end

function var_0_0.isDouble(arg_8_0)
	if not Data.isPersonalFund(arg_8_0._infoId) then
		return false
	end

	if not arg_8_0:canClaim() then
		return false
	end

	local var_8_0 = math.ceil((arg_8_0._infoId - 10800) / 30) + Data.PurchaseType.personal_fund_1 - 1
	local var_8_1 = P._playerActivity._personalFundStatus[var_8_0]

	if not var_8_1 then
		return false
	end

	local var_8_2 = math.ceil((ClientData.getExpireTimestamp(0) - var_8_1) / 24 / 3600)

	if arg_8_0._info._val == var_8_2 and arg_8_0._info._val ~= 0 then
		return true
	end

	return false
end

return var_0_0
