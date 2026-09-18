local var_0_0 = class("ActivityScene", require("BaseUIScene"))
local var_0_1 = require("CumulativeArea")
local var_0_2 = require("NewServerArea")
local var_0_3 = require("VoteArea")

var_0_0.Tab = {
	limit_large_02 = 24,
	daily_3 = 46,
	limit_large_03 = 25,
	week_lottery = 9,
	limit_large_minus_2 = 20,
	invite = 5,
	limit_large_05 = 27,
	limit_large_04 = 26,
	trophy_activity = 42,
	yyb = 301,
	new_server = 41,
	cumulative = 40,
	limit_large_00 = 22,
	limit_large_08 = 30,
	limit_large_01 = 23,
	first_recharge = 1,
	limit_small = 10,
	rank1 = 43,
	month_card3 = 45,
	personal_fund = 7,
	month_card = 3,
	fund = 4,
	vote = 50,
	limit_large_minus_1 = 21,
	package = 2,
	limit_large_06 = 28,
	limit_large_07 = 29,
	exp_fund = 8,
	feed_back = 6,
	return_to_game = 31,
	rank2 = 44,
	vote2 = 51
}

function var_0_0.create(...)
	return lc.createScene(var_0_0, ...)
end

function var_0_0.init(arg_2_0, arg_2_1)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.activity, STR.ACTIVITY, require("BaseUIScene").STYLE_SIMPLE, false) then
		return false
	end

	arg_2_0._bg:setTexture("res/jpg/recharge_bg.jpg")
	arg_2_0._bg:setLocalZOrder(-2)

	local var_2_0 = lc.createSprite("res/jpg/activity_edge.jpg")

	var_2_0:setAnchorPoint(0, 0)
	lc.addChildToPos(arg_2_0._bg, var_2_0, cc.p(228, 0))

	local var_2_1 = lc.createSprite("res/jpg/activity_edge.jpg")

	var_2_1:setFlippedX(true)
	var_2_1:setAnchorPoint(1, 0)
	lc.addChildToPos(arg_2_0._bg, var_2_1, cc.p(lc.w(arg_2_0._bg) + 20, 0))

	arg_2_0._initTab = arg_2_1

	return true
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	local var_3_0 = {
		Data.Event.month_card_dirty,
		Data.Event.fund_dirty,
		Data.Event.personal_fund_dirty,
		Data.Event.package_dirty,
		Data.Event.bonus_dirty
	}

	arg_3_0._listeners = {}

	for iter_3_0 = 1, #var_3_0 do
		local var_3_1 = lc.addEventListener(var_3_0[iter_3_0], function(arg_4_0)
			arg_3_0:onEvent(arg_4_0, var_3_0[iter_3_0])
		end)

		table.insert(arg_3_0._listeners, var_3_1)
	end

	arg_3_0:updateAll()
end

function var_0_0.onExit(arg_5_0)
	var_0_0.super.onExit(arg_5_0)

	for iter_5_0 = 1, #arg_5_0._listeners do
		lc.Dispatcher:removeEventListener(arg_5_0._listeners[iter_5_0])
	end

	ClientView.getMenuUI():updateActivityFlag()
end

function var_0_0.onCleanup(arg_6_0)
	var_0_0.super.onCleanup(arg_6_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/recharge_bg.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_first_recharge.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_first_recharge_2.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_first_recharge_01.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_first_recharge_02.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_feedback.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_fund.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_month_card.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_invite_1.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_invite_2.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_invite_3.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_invite_1_2.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_invite_2_2.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_01.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_02.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_03.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_04.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_05.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_06.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_07.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_return.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_return_2.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_recharge.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_package.jpg"))
	ClientData.unloadLCRes(arg_6_0._resNames)
end

function var_0_0.updateTabs(arg_7_0)
	local var_7_0

	if arg_7_0._tabArea then
		if arg_7_0._tabArea._focusedTab then
			var_7_0 = arg_7_0._tabArea._focusedTab._index
		end

		arg_7_0._tabArea:removeFromParent()
	end

	local var_7_1 = {
		{
			_index = var_0_0.Tab.month_card,
			_str = Str(STR.MONTH_CARD)
		},
		{
			_index = var_0_0.Tab.invite,
			_str = Str(STR.INVITE_PACKAGE)
		},
		{
			_index = var_0_0.Tab.feed_back,
			_str = Str(STR.FEEDBACK_PACKAGE)
		}
	}

	if ClientData.getValidActivityByType(Data.ActivityType.month_card3) then
		table.insert(var_7_1, 2, {
			_index = var_0_0.Tab.month_card3,
			_str = Str(STR.MONTH_CARD3)
		})
	end

	if ClientData.getValidActivityByType(Data.ActivityType.daily_3) then
		table.insert(var_7_1, 2, {
			_index = var_0_0.Tab.daily_3,
			_str = Str(ClientData.getValidActivityByType(Data.ActivityType.daily_3)._nameSid)
		})
	end

	if not ClientData.isPackageRecharged() then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.package,
			_str = Str(STR.RECHARGE_PACKAGE)
		})
	end

	if arg_7_0:getFirstRechargeStatus() == 0 then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.first_recharge,
			_str = Str(STR.FIRST_RECHARGE_BONUS)
		})
	else
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.first_recharge,
			_str = Str(STR.FIRST_RECHARGE_BONUS_2)
		})
	end

	if ClientData.getValidActivityByType(Data.ActivityType.week_lottery) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.week_lottery,
			_str = Str(ClientData.getValidActivityByType(Data.ActivityType.week_lottery)._nameSid)
		})
	end

	if ClientData.isActivityValidByParam(Data.PurchaseType.limit_8) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.limit_large_08,
			_str = Str(ClientData.getValidActivityByParam(Data.PurchaseType.limit_8)._nameSid)
		})
	end

	if ClientData.isActivityValidByParam(Data.PurchaseType.limit_7) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.limit_large_07,
			_str = Str(ClientData.getValidActivityByParam(Data.PurchaseType.limit_7)._nameSid)
		})
	end

	if ClientData.isActivityValidByParam(Data.PurchaseType.limit_6) and P:isNewBie2() then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.limit_large_06,
			_str = Str(ClientData.getValidActivityByParam(Data.PurchaseType.limit_6)._nameSid)
		})
	end

	if ClientData.isActivityValidByParam(Data.PurchaseType.limit_5) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.limit_large_05,
			_str = Str(ClientData.getValidActivityByParam(Data.PurchaseType.limit_5)._nameSid)
		})
	end

	if ClientData.isActivityValidByParam(Data.PurchaseType.limit_2) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.limit_large_02,
			_str = Str(ClientData.getValidActivityByParam(Data.PurchaseType.limit_2)._nameSid)
		})
	end

	if ClientData.isActivityValidByParam(Data.PurchaseType.limit_1) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.limit_large_01,
			_str = Str(ClientData.getValidActivityByParam(Data.PurchaseType.limit_1)._nameSid)
		})
	end

	if ClientData.isActivityValidByParam(Data.PurchaseType.limit_0) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.limit_large_00,
			_str = Str(ClientData.getValidActivityByParam(Data.PurchaseType.limit_0)._nameSid)
		})
	end

	if ClientData.isActivityValidByParam(Data.PurchaseType.limit_minus_1) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.limit_large_minus_1,
			_str = Str(ClientData.getValidActivityByParam(Data.PurchaseType.limit_minus_1)._nameSid)
		})
	end

	if ClientData.isActivityValidByParam(Data.PurchaseType.limit_minus_2) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.limit_large_minus_2,
			_str = Str(ClientData.getValidActivityByParam(Data.PurchaseType.limit_minus_2)._nameSid)
		})
	end

	if ClientData.getValidActivityByType(Data.ActivityType.vote_show) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.vote,
			_str = Str(ClientData.getValidActivityByType(Data.ActivityType.vote_show)._nameSid)
		})
	end

	if ClientData.getValidActivityByType(Data.ActivityType.vote_show2) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.vote2,
			_str = Str(ClientData.getValidActivityByType(Data.ActivityType.vote_show2)._nameSid)
		})
	end

	if ClientData.isReturnToGame() and not ClientData.isReturnToGameClaimed() then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.return_to_game,
			_str = Str(STR.RETURN_PACKAGE)
		})
	end

	for iter_7_0 = Data.PurchaseType.limit_3, Data.PurchaseType.limit_4 do
		if ClientData.isActivityValidByParam(iter_7_0) then
			local var_7_2 = ClientData.getValidActivityByParam(iter_7_0)

			table.insert(var_7_1, 1, {
				_index = var_0_0.Tab.limit_large_03 + iter_7_0 - Data.PurchaseType.limit_3,
				_str = Str(var_7_2._nameSid)
			})
		end
	end

	if ClientData.getValidActivityByType(Data.ActivityType.yyb) then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.yyb,
			_str = Str(ClientData.getValidActivityByType(Data.ActivityType.yyb)._nameSid)
		})
	end

	if P._playerActivity:isShowPersonalFund() then
		local var_7_3 = {}

		for iter_7_1 = 4, 1, -1 do
			var_7_3[#var_7_3 + 1] = {
				_isSub = true,
				_subIndex = var_0_0.Tab.personal_fund * 10000 + iter_7_1,
				_str = Str(STR.PERSONAL_FUND + iter_7_1)
			}
		end

		table.insert(var_7_1, 2, {
			_index = var_0_0.Tab.personal_fund,
			_str = Str(STR.PERSONAL_FUND),
			_tabs = var_7_3
		})
	end

	local var_7_4 = {}
	local var_7_5 = P._playerBonus._bonusFundLevel
	local var_7_6 = false

	for iter_7_2, iter_7_3 in ipairs(var_7_5) do
		if not var_7_5._isClaimed then
			var_7_6 = true

			break
		end
	end

	if ClientData.isRecharged(Data.PurchaseType.fund) and var_7_6 then
		var_7_4[#var_7_4 + 1] = {
			_isSub = true,
			_subIndex = var_0_0.Tab.fund * 10000 + 1,
			_str = Str(STR.FUND_LEVEL + 1)
		}
	end

	local var_7_7 = P._playerBonus._bonusPersonalFund
	local var_7_8 = false

	for iter_7_4, iter_7_5 in ipairs(var_7_7) do
		local var_7_9 = math.ceil((iter_7_5._infoId - 10800) / 30) + Data.PurchaseType.personal_fund_1 - 1

		if not var_7_7._isClaimed and var_7_9 == Data.PurchaseType.personal_fund_7 then
			var_7_8 = true

			break
		end
	end

	if P._playerActivity._personalFundStatus[Data.PurchaseType.personal_fund_7] and var_7_8 then
		var_7_4[#var_7_4 + 1] = {
			_isSub = true,
			_subIndex = var_0_0.Tab.fund * 10000 + 2,
			_str = Str(STR.FUND_LEVEL + 2)
		}
	end

	if ClientData._cfg and ClientData._cfg.testFund == 1 or #var_7_4 > 0 then
		table.insert(var_7_1, 3, {
			_index = var_0_0.Tab.fund,
			_str = Str(STR.FUND_LEVEL),
			_tabs = var_7_4
		})
	end

	local var_7_10 = P._playerBonus._bonusPersonalFund
	local var_7_11 = false

	for iter_7_6, iter_7_7 in ipairs(var_7_10) do
		local var_7_12 = math.ceil((iter_7_7._infoId - 10800) / 30) + Data.PurchaseType.personal_fund_1 - 1

		if not var_7_10._isClaimed and var_7_12 == Data.PurchaseType.personal_fund_5 then
			var_7_11 = true

			break
		end
	end

	if ClientData._cfg and ClientData._cfg.testFund == 1 or P._playerActivity._personalFundStatus[Data.PurchaseType.personal_fund_5] and var_7_11 then
		table.insert(var_7_1, 3, {
			_index = var_0_0.Tab.exp_fund,
			_str = Str(STR.EXP_FUND)
		})
	end

	local var_7_13 = {}

	for iter_7_8 = Data.ActivityType.cumulative_newbie_end, Data.ActivityType.cumulative_newbie_start, -1 do
		local var_7_14 = ClientData.getValidActivityByType(iter_7_8)

		if var_7_14 then
			local var_7_15 = iter_7_8 - Data.ActivityType.cumulative_newbie_start + 1

			var_7_13[#var_7_13 + 1] = {
				_isSub = true,
				_subIndex = var_0_0.Tab.cumulative * 10000 + var_7_15,
				_str = Str(var_7_14._nameSid)
			}
		end
	end

	if #var_7_13 > 0 then
		table.insert(var_7_1, 2, {
			_index = var_0_0.Tab.cumulative,
			_str = Str(STR.CUMULATIVE_NEWBIE),
			_tabs = var_7_13
		})
	end

	local var_7_16 = {}

	for iter_7_9 = Data.ActivityType.new_server_begin, Data.ActivityType.new_server_end do
		local var_7_17 = ClientData.getValidActivityByType(iter_7_9)

		if var_7_17 then
			table.insert(var_7_16, 1, {
				_isSub = true,
				_subIndex = var_0_0.Tab.new_server * 10000 + iter_7_9,
				_str = Str(var_7_17._nameSid)
			})
		end
	end

	if #var_7_16 > 0 then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.new_server,
			_str = Str(STR.NEW_SERVER_ACTIVITY),
			_tabs = var_7_16
		})
	end

	local var_7_18 = ClientData.getValidActivityByType(Data.ActivityType.trophy_activity)

	if var_7_18 then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.trophy_activity,
			_str = Str(var_7_18._nameSid)
		})
	end

	local var_7_19 = ClientData.getValidActivityByType(Data.ActivityType.rank1)

	if var_7_19 then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.rank1,
			_str = Str(var_7_19._nameSid)
		})
	end

	local var_7_20 = ClientData.getValidActivityByType(Data.ActivityType.rank2)

	if var_7_20 then
		table.insert(var_7_1, 1, {
			_index = var_0_0.Tab.rank2,
			_str = Str(var_7_20._nameSid)
		})
	end

	local var_7_21 = ClientView.createVerticalTabListArea(lc.bottom(arg_7_0._titleArea), var_7_1, function(arg_8_0, arg_8_1, arg_8_2)
		if not arg_8_1 or arg_8_2 then
			arg_7_0:showTab(arg_8_0)
		end
	end, ClientView.SCR_EDGE)

	lc.addChildToPos(arg_7_0, var_7_21, cc.p(lc.w(var_7_21) / 2 - 4 + ClientView.SCR_EDGE, lc.bottom(arg_7_0._titleArea) / 2 + 2), 1)

	function var_7_21._subTabExpandCallback(arg_9_0)
		arg_7_0:updateButtonFlags()
	end

	arg_7_0._tabArea = var_7_21

	local var_7_22 = arg_7_0._initTab or var_7_0

	arg_7_0._initTab = nil

	local var_7_23 = false

	if var_7_22 then
		for iter_7_10 = 1, #var_7_1 do
			if var_7_1[iter_7_10]._index == var_7_22 then
				var_7_23 = true

				break
			end

			if var_7_1[iter_7_10]._tabs then
				for iter_7_11, iter_7_12 in ipairs(var_7_1[iter_7_10]._tabs) do
					if iter_7_12._subIndex == var_7_22 then
						var_7_23 = true

						break
					end
				end
			end
		end
	end

	if not var_7_23 then
		var_7_22 = var_7_1[1]._index

		if var_7_1[1]._tabs then
			var_7_22 = var_7_1[1]._tabs[#var_7_1[1]._tabs]._subIndex
		end
	end

	local var_7_24 = var_7_22 > 10000 and math.floor(var_7_22 / 10000) or var_7_22

	arg_7_0._tabArea:showTab(var_7_24, true)

	if var_7_22 > 100 then
		arg_7_0._tabArea:showTab(var_7_22, true)
	end
end

function var_0_0.showTab(arg_10_0, arg_10_1)
	if not arg_10_0._detailLayer then
		arg_10_0._detailLayer = lc.createNode(cc.size(math.min(ClientView.SCR_W - lc.w(arg_10_0._tabArea), 1126), ClientView.SCR_H - lc.h(arg_10_0._titleArea)))

		lc.addChildToPos(arg_10_0, arg_10_0._detailLayer, cc.p((ClientView.SCR_W + lc.w(arg_10_0._tabArea)) / 2, lc.ch(arg_10_0._detailLayer)), -1)
	else
		arg_10_0._detailLayer:removeAllChildren()

		arg_10_0._detailLayer.update = nil
	end

	if arg_10_1._index == var_0_0.Tab.month_card then
		arg_10_0:initMonthCard()
	elseif arg_10_1._index == var_0_0.Tab.month_card3 then
		arg_10_0:initMonthCard3()
	elseif math.floor(arg_10_1._index / 10000) == var_0_0.Tab.fund then
		if arg_10_1._index % 10000 == 1 then
			arg_10_0:initFund()
		else
			arg_10_0:initFund2()
		end
	elseif math.floor(arg_10_1._index / 10000) == var_0_0.Tab.personal_fund then
		arg_10_0:initPersonalFund(arg_10_1._index % 10000)
	elseif arg_10_1._index == var_0_0.Tab.exp_fund then
		arg_10_0:initPersonalFund(5)
	elseif arg_10_1._index == var_0_0.Tab.package then
		arg_10_0:initPackage()
	elseif arg_10_1._index == var_0_0.Tab.first_recharge then
		arg_10_0:initFirstRecharge()
	elseif arg_10_1._index == var_0_0.Tab.feed_back then
		arg_10_0:initFeedBack()
	elseif arg_10_1._index == var_0_0.Tab.invite then
		arg_10_0:initInvite()
	elseif arg_10_1._index == var_0_0.Tab.limit_small then
		arg_10_0:initLimitSmall()
	elseif arg_10_1._index == var_0_0.Tab.limit_large_minus_2 or arg_10_1._index == var_0_0.Tab.limit_large_minus_1 or arg_10_1._index == var_0_0.Tab.limit_large_00 or arg_10_1._index == var_0_0.Tab.limit_large_01 or arg_10_1._index == var_0_0.Tab.limit_large_02 or arg_10_1._index == var_0_0.Tab.limit_large_08 or arg_10_1._index == var_0_0.Tab.daily_3 then
		arg_10_0:initLimitLarge(arg_10_1._index)
	elseif arg_10_1._index == var_0_0.Tab.week_lottery then
		arg_10_0:initActivityAd(Data.ActivityType.week_lottery)
	elseif arg_10_1._index >= var_0_0.Tab.limit_large_03 and arg_10_1._index <= var_0_0.Tab.limit_large_07 then
		arg_10_0:initLimitLarge(arg_10_1._index)
	elseif arg_10_1._index == var_0_0.Tab.return_to_game then
		arg_10_0:initReturnPackage(arg_10_1._index)
	elseif arg_10_1._index == var_0_0.Tab.trophy_activity then
		local var_10_0 = var_0_2.create(arg_10_0._detailLayer:getContentSize(), Data.ActivityType.trophy_activity)

		lc.addChildToCenter(arg_10_0._detailLayer, var_10_0)
	elseif arg_10_1._index == var_0_0.Tab.rank1 then
		local var_10_1 = var_0_2.create(arg_10_0._detailLayer:getContentSize(), Data.ActivityType.rank1)

		lc.addChildToCenter(arg_10_0._detailLayer, var_10_1)
	elseif arg_10_1._index == var_0_0.Tab.rank2 then
		local var_10_2 = var_0_2.create(arg_10_0._detailLayer:getContentSize(), Data.ActivityType.rank2)

		lc.addChildToCenter(arg_10_0._detailLayer, var_10_2)
	elseif math.floor(arg_10_1._index / 10000) == var_0_0.Tab.cumulative then
		local var_10_3 = var_0_1.create(arg_10_0._detailLayer:getContentSize(), arg_10_1._index % 10000)

		lc.addChildToCenter(arg_10_0._detailLayer, var_10_3)
	elseif math.floor(arg_10_1._index / 10000) == var_0_0.Tab.new_server then
		local var_10_4 = var_0_2.create(arg_10_0._detailLayer:getContentSize(), arg_10_1._index % 10000)

		lc.addChildToCenter(arg_10_0._detailLayer, var_10_4)
	elseif arg_10_1._index == var_0_0.Tab.vote then
		local var_10_5 = var_0_3.create(arg_10_0._detailLayer:getContentSize(), Data.ActivityType.vote)

		lc.addChildToCenter(arg_10_0._detailLayer, var_10_5)
	elseif arg_10_1._index == var_0_0.Tab.vote2 then
		local var_10_6 = var_0_3.create(arg_10_0._detailLayer:getContentSize(), Data.ActivityType.vote2)

		lc.addChildToCenter(arg_10_0._detailLayer, var_10_6)
	elseif arg_10_1._index == var_0_0.Tab.yyb then
		var_0_0.initYYB(arg_10_0._detailLayer)
	end

	arg_10_0._titleArea._btnHelp:setVisible(arg_10_0:getHelpType() ~= nil)
	arg_10_0:updateButtonFlags()
end

function var_0_0.initFirstRecharge(arg_11_0)
	local var_11_0 = arg_11_0._detailLayer
	local var_11_1 = arg_11_0:getFirstRechargeStatus()

	if var_11_1 == 0 then
		local var_11_2 = "activity_first_recharge"

		if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_11_2 .. "_2")) then
			var_11_2 = var_11_2 .. "_2"
		end

		local var_11_3 = lc.createSprite(lc.formatJpg(var_11_2))

		lc.addChildToCenter(var_11_0, var_11_3)

		local var_11_4 = P._playerBonus._packageBonus[1120]._info
		local var_11_5 = {}

		for iter_11_0 = 1, #var_11_4._rid do
			local var_11_6 = IconWidget.create({
				_infoId = var_11_4._rid[iter_11_0],
				_level = var_11_4._level[iter_11_0],
				_count = var_11_4._count[iter_11_0],
				_isFragment = var_11_4._isFragment[iter_11_0] > 0
			})

			var_11_6._name:setVisible(false)
			var_11_6:setScale(0.8)
			table.insert(var_11_5, var_11_6)
		end

		P:sortResultItems(var_11_5)

		local var_11_7 = cc.p(lc.cw(var_11_3) - 20, lc.ch(var_11_3) - 210)

		for iter_11_1 = 1, #var_11_5 do
			local var_11_8 = var_11_5[iter_11_1]
			local var_11_9 = cc.p(var_11_7.x + (lc.w(var_11_8) - 5) * (iter_11_1 - (#var_11_5 + 1) / 2), var_11_7.y)

			lc.addChildToPos(var_11_3, var_11_8, var_11_9)
		end

		local var_11_10 = ClientView.createShaderButton("img_btn_recharge_1", function(arg_12_0)
			return
		end)

		lc.addChildToPos(var_11_3, var_11_10, cc.p(lc.cw(var_11_3) + 260, lc.ch(var_11_3) - 200))
		var_11_10:setDisabledShader(ClientView.SHADER_DISABLE)
		var_11_10:addLabel(Str(STR.RECHARGE_NOW))

		arg_11_0._firstChargeBtn = var_11_10
	elseif var_11_1 == 1 then
		arg_11_0._resNames = ClientData.loadLCRes("res/first_recharge.lcres")

		local var_11_11 = lc.createSprite("res/jpg/activity_first_recharge_01.jpg")

		lc.addChildToCenter(var_11_0, var_11_11)

		local var_11_12 = lc.createSprite("recharge_jigsaw_bg")

		lc.addChildToPos(var_11_0, var_11_12, cc.p(lc.cw(var_11_0), 536))

		arg_11_0._jigsawBg = var_11_12

		local var_11_13 = lc.createSprite("recharge_jigsaw_lines")

		lc.addChildToCenter(var_11_12, var_11_13, 1)

		arg_11_0._jigSawLines = var_11_13

		local var_11_14 = ClientView.createShaderButton("recharge_btn", function(arg_13_0)
			arg_11_0:onClaimRecharge7Bonus()
		end)

		lc.addChildToPos(var_11_0, var_11_14, cc.p(lc.cw(var_11_0), 380))
		var_11_14:setDisabledShader(ClientView.SHADER_DISABLE)

		arg_11_0._recharge7Btn = var_11_14

		arg_11_0:addDailyRechargeArea()
	else
		local var_11_15 = lc.createSprite("res/jpg/activity_first_recharge_02.jpg")

		lc.addChildToCenter(var_11_0, var_11_15)
		arg_11_0:addDailyRechargeArea()
	end

	arg_11_0:updateFirstRecharge()
end

function var_0_0.addDailyRechargeArea(arg_14_0)
	local var_14_0 = arg_14_0._detailLayer

	arg_14_0._dailyPurchaseTypes = {
		Data.PurchaseType.daily_1,
		Data.PurchaseType.daily_2
	}
	arg_14_0._daiyChargeBtns = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._dailyPurchaseTypes) do
		local var_14_1 = P._playerBonus:getBonusByPurchaseType(iter_14_1)
		local var_14_2 = {}
		local var_14_3 = var_14_1._info

		for iter_14_2 = 1, #var_14_3._rid do
			local var_14_4 = IconWidget.create({
				_infoId = var_14_3._rid[iter_14_2],
				_level = var_14_3._level[iter_14_2],
				_count = var_14_3._count[iter_14_2],
				_isFragment = var_14_3._isFragment[iter_14_2] > 0
			})

			var_14_4._name:setVisible(false)
			table.insert(var_14_2, var_14_4)
		end

		P:sortResultItems(var_14_2)

		local var_14_5 = -130
		local var_14_6 = 165

		if iter_14_0 == 2 then
			var_14_5, var_14_6 = -130, 58
		end

		for iter_14_3 = 1, #var_14_2 do
			local var_14_7 = var_14_2[iter_14_3]
			local var_14_8 = cc.p(lc.cw(var_14_0) + var_14_5 + (lc.w(var_14_7) - 14) * (iter_14_3 - (#var_14_2 + 1) / 2), var_14_6)

			var_14_7:setScale(0.8)
			lc.addChildToPos(var_14_0, var_14_7, var_14_8)
		end

		local var_14_9 = ClientView.createShaderButton("img_btn_recharge_1", function(arg_15_0)
			arg_14_0:onBuy(Data.PurchaseType.daily_1 + iter_14_0 - 1)
		end)

		lc.addChildToPos(var_14_0, var_14_9, cc.p(lc.cw(var_14_0) + 120 + lc.cw(var_14_9), var_14_6))
		var_14_9:setDisabledShader(ClientView.SHADER_DISABLE)
		var_14_9:addLabel(Str(STR.BUY_NOW))

		arg_14_0._daiyChargeBtns[iter_14_0] = var_14_9
	end
end

function var_0_0.updateFirstRecharge(arg_16_0)
	local var_16_0 = arg_16_0:getFirstRechargeStatus()

	if var_16_0 == 0 then
		local var_16_1 = arg_16_0._firstChargeBtn
		local var_16_2 = P._playerBonus._packageBonus[1120]

		if not ClientData.isGemRecharged() then
			var_16_1._label:setString(Str(STR.RECHARGE_NOW))

			function var_16_1._callback()
				lc.pushScene(require("RechargeScene").create())
			end
		elseif var_16_2._value >= var_16_2._info._val and not var_16_2._isClaimed then
			var_16_1._label:setString(Str(STR.CLAIM))

			function var_16_1._callback()
				arg_16_0:onClaimFirstRecharge()
			end
		else
			var_16_1._label:setString(Str(STR.CLAIMED))
			var_16_1:setEnabled(false)

			function var_16_1._callback()
				return
			end
		end
	elseif var_16_0 == 1 then
		local var_16_3 = ClientData.getRecharge7BonusValue()

		if var_16_3 >= 7 then
			local var_16_4 = lc.createSprite("recharge_jigsaw_fg")

			lc.addChildToCenter(arg_16_0._jigsawBg, var_16_4, 1)
			arg_16_0._recharge7Btn:setEnabled(true)

			local var_16_5 = lc.createSprite("recharge_jigsaw_light")

			var_16_5:setScale(9)
			var_16_5:runAction(lc.rep(lc.sequence(lc.scaleTo(0.5, 8.5), lc.scaleTo(0.5, 9))))
			lc.addChildToCenter(arg_16_0._jigsawBg, var_16_5, -1)

			local var_16_6 = lc.createSprite("recharge_btn_light")

			var_16_6:setScale(6)
			var_16_6:runAction(lc.rep(lc.sequence(lc.scaleTo(0.5, 5.5), lc.scaleTo(0.5, 6))))
			lc.addChildToPos(arg_16_0._recharge7Btn, var_16_6, cc.p(lc.cw(arg_16_0._recharge7Btn), lc.ch(arg_16_0._recharge7Btn) + 4), -1)
		else
			for iter_16_0 = 1, var_16_3 do
				local var_16_7 = lc.createSprite("recharge_jigsaw_0" .. iter_16_0)

				var_16_7:setOpacity(0)
				var_16_7:runAction(lc.fadeIn(2))
				lc.addChildToCenter(arg_16_0._jigsawBg, var_16_7)
			end

			arg_16_0._recharge7Btn:setEnabled(false)
		end

		arg_16_0:updateDailyRechargeArea()
	else
		arg_16_0:updateDailyRechargeArea()
	end
end

function var_0_0.updateDailyRechargeArea(arg_20_0)
	local var_20_0 = ClientData.isRecharged(Data.PurchaseType.daily_1) or ClientData.isRecharged(Data.PurchaseType.daily_2)

	for iter_20_0 = 1, #arg_20_0._daiyChargeBtns do
		if var_20_0 then
			arg_20_0._daiyChargeBtns[iter_20_0]._label:setString(Str(STR.PURCHASED))
			arg_20_0._daiyChargeBtns[iter_20_0]:setEnabled(false)
		end
	end
end

function var_0_0.initPackage(arg_21_0)
	local var_21_0 = arg_21_0._detailLayer
	local var_21_1 = {
		Data.PurchaseType.package_1,
		Data.PurchaseType.package_3,
		Data.PurchaseType.package_4,
		Data.PurchaseType.package_2,
		Data.PurchaseType.package_5,
		Data.PurchaseType.package_6
	}
	local var_21_2 = lc.List.createH(var_21_0:getContentSize())

	lc.addChildToCenter(var_21_0, var_21_2)

	arg_21_0._packageItems = {}

	for iter_21_0 = 1, #var_21_1 do
		local var_21_3 = var_21_1[iter_21_0]
		local var_21_4 = P._playerBonus._packageBonus[1121 + var_21_3 - Data.PurchaseType.package_1]
		local var_21_5 = Data._globalInfo._packageRmb[var_21_3 - Data.PurchaseType.package_1 + 1]
		local var_21_6, var_21_7 = arg_21_0:createPackageItem(var_21_3, var_21_4, var_21_5, 200 + iter_21_0)

		var_21_2:pushBackCustomItem(var_21_6)

		arg_21_0._packageItems[iter_21_0] = var_21_7
	end

	arg_21_0:updatePackage()
end

function var_0_0.updatePackage(arg_22_0)
	for iter_22_0 = 1, #arg_22_0._packageItems do
		local var_22_0 = arg_22_0._packageItems[iter_22_0]
		local var_22_1 = var_22_0._purchaseType
		local var_22_2 = var_22_0._btn
		local var_22_3 = P._playerBonus._packageBonus[1121 + var_22_1 - Data.PurchaseType.package_1]._info

		if false then
			var_22_0:setHide(true)
		else
			var_22_0:setHide(false)

			if ClientData.isRecharged(var_22_1) then
				var_22_2._label:setString(Str(STR.PURCHASED))
				var_22_2:setEnabled(false)
			end
		end
	end
end

function var_0_0.createPackageItem(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = ccui.Layout:create()
	local var_23_1 = lc.createSpriteWithMask("res/jpg/package_bg.jpg")

	var_23_0:setContentSize(var_23_1:getContentSize())
	var_23_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(var_23_0, var_23_1)

	var_23_1._purchaseType = arg_23_1

	local var_23_2 = DragonBones.create("lihe")

	lc.addChildToPos(var_23_1, var_23_2, cc.p(lc.cw(var_23_1), lc.ch(var_23_1) + 150))
	var_23_2:gotoAndPlay(string.format("effect%d", arg_23_4))

	local var_23_3 = lc.createSpriteWithMask(string.format("res/jpg/package_title_%d.jpg", arg_23_4))

	lc.addChildToPos(var_23_1, var_23_3, cc.p(lc.cw(var_23_1), lc.h(var_23_1) - 20))

	local var_23_4 = lc.createSpriteWithMask(string.format("res/jpg/package_desc_%d.jpg", arg_23_1))

	lc.addChildToPos(var_23_1, var_23_4, cc.p(lc.cw(var_23_1), 200 + lc.ch(var_23_4)))

	local var_23_5 = lc.createSprite("img_recharge_once")

	lc.addChildToPos(var_23_1, var_23_5, cc.p(lc.cw(var_23_1) + 50, lc.ch(var_23_1) + 90))

	local var_23_6 = lc.createSprite("img_recharge_once_tip")

	lc.addChildToPos(var_23_5, var_23_6, cc.p(lc.cw(var_23_5), lc.ch(var_23_5)))

	local var_23_7 = lc.createSprite("img_unkown")

	lc.addChildToPos(var_23_1, var_23_7, cc.p(var_23_2:getPosition()))

	local var_23_8 = arg_23_2._info
	local var_23_9 = {}

	for iter_23_0 = 1, #var_23_8._rid do
		local var_23_10 = IconWidget.create({
			_infoId = var_23_8._rid[iter_23_0],
			_level = var_23_8._level[iter_23_0],
			_count = var_23_8._count[iter_23_0],
			_isFragment = var_23_8._isFragment[iter_23_0] > 0
		})

		var_23_10._name:setVisible(false)
		table.insert(var_23_9, var_23_10)
	end

	P:sortResultItems(var_23_9)

	local var_23_11 = #var_23_9 == 2 and 0.8 or 0.7
	local var_23_12 = #var_23_9 == 2 and 14 or 2

	for iter_23_1 = 1, #var_23_9 do
		local var_23_13 = var_23_9[iter_23_1]
		local var_23_14 = cc.p(lc.cw(var_23_1) + (lc.w(var_23_13) * var_23_11 + var_23_12) * (iter_23_1 - (#var_23_9 + 1) / 2), 140)

		var_23_13:setScale(var_23_11)
		lc.addChildToPos(var_23_1, var_23_13, var_23_14)
	end

	local var_23_15 = ClientView.createShaderButton("img_btn_recharge_2", function(arg_24_0)
		arg_23_0:onBuy(arg_23_1)
	end)

	lc.addChildToPos(var_23_1, var_23_15, cc.p(lc.cw(var_23_1), 54))
	var_23_15:setDisabledShader(ClientView.SHADER_DISABLE)
	var_23_15:addLabel((arg_23_1 ~= Data.PurchaseType.limit_2 and Str(STR.RMB) or "") .. arg_23_3)

	var_23_1._btn = var_23_15

	if arg_23_1 == Data.PurchaseType.limit_2 then
		var_23_15:addIcon("img_icon_res3_s")
		lc.offset(var_23_15._icon, 50, 0)
	end

	function var_23_1.setHide(arg_25_0, arg_25_1)
		var_23_7:setVisible(arg_25_1)
		var_23_2:setVisible(not arg_25_1)
		var_23_3:setVisible(not arg_25_1)
		var_23_4:setVisible(not arg_25_1)
		var_23_5:setVisible(not arg_25_1)
		var_23_15:setVisible(not arg_25_1)

		for iter_25_0 = 1, #var_23_9 do
			var_23_9[iter_25_0]:setVisible(not arg_25_1)
		end
	end

	return var_23_0, var_23_1
end

function var_0_0.initMonthCard(arg_26_0)
	local var_26_0 = arg_26_0._detailLayer
	local var_26_1, var_26_2, var_26_3, var_26_4 = ClientData.getServerDate()
	local var_26_5 = lc.createSprite(string.format("res/jpg/activity_month_card_%d.jpg", var_26_3))

	lc.addChildToCenter(var_26_0, var_26_5)

	local var_26_6 = {
		Data.PurchaseType.month_card_1,
		Data.PurchaseType.month_card_2
	}

	for iter_26_0 = 1, #var_26_6 do
		local var_26_7 = var_26_6[iter_26_0]
		local var_26_8 = cc.p(lc.cw(var_26_0) + (iter_26_0 == 1 and -200 or 200), lc.ch(var_26_0))
		local var_26_9 = P._playerBonus._bonusMonthCardBought[iter_26_0]._value
		local var_26_10 = (var_26_9 ~= 0 and P._playerBonus._bonusMonthCardPackage[(iter_26_0 - 1) * 2 + math.min(2, var_26_9)] or P._playerBonus._bonusMonthCard[iter_26_0])._info
		local var_26_11 = {}

		for iter_26_1 = 1, #var_26_10._rid do
			local var_26_12 = IconWidget.create({
				_infoId = var_26_10._rid[iter_26_1],
				_level = var_26_10._level[iter_26_1],
				_count = var_26_10._count[iter_26_1],
				_isFragment = var_26_10._isFragment[iter_26_1] > 0
			})

			var_26_12._name:setVisible(false)
			var_26_12:setScale(0.9)
			table.insert(var_26_11, var_26_12)
		end

		for iter_26_2 = 1, #var_26_11 do
			local var_26_13 = var_26_11[iter_26_2]
			local var_26_14 = cc.p(var_26_8.x + (lc.w(var_26_13) + 6) * (iter_26_2 - (#var_26_11 + 1) / 2) + 12, var_26_8.y - 100)

			lc.addChildToPos(var_26_0, var_26_13, var_26_14)
		end

		local var_26_15 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_26_9 ~= 0 and string.format(Str(STR.MONTHCARD_TIP2), math.min(3, var_26_9 + 1)) or Str(STR.MONTHCARD_TIP1))

		var_26_15:setScale(0.8)
		var_26_15:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_26_0, var_26_15, cc.p(var_26_8.x - 170, var_26_8.y - 14))

		local var_26_16 = iter_26_0 == 1 and 9003 or 9015
		local var_26_17, var_26_18, var_26_19, var_26_20 = ClientData.getServerDate()
		local var_26_21 = Data._bonusInfo[var_26_16 + var_26_19 - 1]
		local var_26_22 = Data.getInfo(var_26_21._rid[1])
		local var_26_23 = ClientView.createShaderButton(nil, function()
			require("CardInfoPanel").create(var_26_22._id, 1):show()
		end)

		var_26_23:setContentSize(cc.size(350, 170))
		lc.addChildToPos(var_26_0, var_26_23, cc.p(var_26_8.x, var_26_8.y + 90))

		local var_26_24 = ClientView.createShaderButton("img_btn_recharge_2", function(arg_28_0)
			arg_26_0:onBuy(var_26_7)
		end)

		lc.addChildToPos(var_26_0, var_26_24, cc.p(var_26_8.x + 10, 100))

		if P._playerBonus._bonusMonthCardBought[iter_26_0]._value >= 3 then
			var_26_24:setDisabledShader(ClientView.SHADER_DISABLE)
			var_26_24:setEnabled(false)
			var_26_24:addLabel(Str(STR.PURCHASED) .. string.format(Str(STR.CARD_AMOUNT), 3))
		else
			var_26_24:addLabel(Str(STR.BUY_NOW))
		end
	end
end

function var_0_0.initMonthCard3(arg_29_0)
	local var_29_0 = arg_29_0._detailLayer
	local var_29_1 = lc.List.createH(var_29_0:getContentSize())

	lc.addChildToCenter(var_29_0, var_29_1)

	local var_29_2 = {
		Data.PurchaseType.month_card_3,
		Data.PurchaseType.month_card_4
	}

	if ClientData.getValidActivityByType(Data.ActivityType.month_card5) then
		var_29_2[#var_29_2 + 1] = Data.PurchaseType.month_card_5
	end

	if ClientData.getValidActivityByType(Data.ActivityType.month_card6) then
		var_29_2[#var_29_2 + 1] = Data.PurchaseType.month_card_6
	end

	table.sort(var_29_2, function(arg_30_0, arg_30_1)
		local var_30_0 = P._playerBonus:getBonusByPurchaseType(arg_30_0)
		local var_30_1 = P._playerBonus:getBonusByPurchaseType(arg_30_1)
		local var_30_2 = var_30_0._value
		local var_30_3 = var_30_1._value

		if var_30_2 ~= var_30_3 then
			return var_30_2 < var_30_3
		else
			return arg_30_0 < arg_30_1
		end
	end)

	local var_29_3 = {
		[Data.PurchaseType.month_card_3] = "res/jpg/month_card_bg_3.jpg",
		[Data.PurchaseType.month_card_4] = "res/jpg/month_card_bg_4.jpg",
		[Data.PurchaseType.month_card_5] = "res/jpg/month_card_bg_5.jpg",
		[Data.PurchaseType.month_card_6] = "res/jpg/month_card_bg_6.jpg"
	}

	for iter_29_0 = 1, #var_29_2 do
		local var_29_4 = var_29_2[iter_29_0]
		local var_29_5 = var_29_3[var_29_4]
		local var_29_6 = arg_29_0:createMonthCard3Area(var_29_4, var_29_5)

		var_29_1:pushBackCustomItem(var_29_6)
	end
end

function var_0_0.createMonthCard3Area(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = lc.createSpriteWithMask(arg_31_2)
	local var_31_1 = ccui.Widget:create()

	var_31_1:setContentSize(var_31_0:getContentSize())
	lc.addChildToCenter(var_31_1, var_31_0)

	local var_31_2 = cc.p(lc.cw(var_31_1) - 48, lc.ch(var_31_1) - 12)
	local var_31_3 = P._playerBonus:getBonusByPurchaseType(arg_31_1)
	local var_31_4 = var_31_3._info
	local var_31_5 = var_31_3._value
	local var_31_6 = {}

	for iter_31_0 = 1, #var_31_4._rid do
		local var_31_7 = IconWidget.create({
			_infoId = var_31_4._rid[iter_31_0],
			_level = var_31_4._level[iter_31_0],
			_count = var_31_4._count[iter_31_0],
			_isFragment = var_31_4._isFragment[iter_31_0] > 0
		})

		var_31_7._name:setVisible(false)
		var_31_7:setScale(0.9)
		table.insert(var_31_6, var_31_7)
	end

	for iter_31_1 = 1, #var_31_6 do
		local var_31_8 = var_31_6[iter_31_1]
		local var_31_9 = cc.p(var_31_2.x + (lc.w(var_31_8) + 6) * (iter_31_1 - (#var_31_6 + 1) / 2) + 12, var_31_2.y - 100)

		lc.addChildToPos(var_31_1, var_31_8, var_31_9)
	end

	if arg_31_1 == Data.PurchaseType.month_card_4 and var_31_5 == 0 then
		local var_31_10 = 86400
		local var_31_11 = math.min(30, math.floor(ClientData.getCurrentTime() / var_31_10) - math.floor(P._regTime / var_31_10))
		local var_31_12 = {}

		for iter_31_2 = 1, #var_31_4._rid do
			local var_31_13 = IconWidget.create({
				_infoId = var_31_4._rid[iter_31_2],
				_level = var_31_4._level[iter_31_2],
				_count = var_31_4._count[iter_31_2],
				_isFragment = var_31_4._isFragment[iter_31_2] > 0
			})

			var_31_13._name:setVisible(false)
			var_31_13._countLabel:setString(ClientData.formatNum(var_31_4._count[iter_31_2] * var_31_11, 9999))
			var_31_13:setScale(0.9)
			table.insert(var_31_12, var_31_13)
		end

		for iter_31_3 = 1, #var_31_12 do
			local var_31_14 = var_31_12[iter_31_3]
			local var_31_15 = cc.p(var_31_2.x + (lc.w(var_31_14) + 6) * (iter_31_3 - (#var_31_12 + 1) / 2) + 12, var_31_2.y + 60)

			lc.addChildToPos(var_31_1, var_31_14, var_31_15)
		end
	end

	local var_31_16 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.MONTHCARD_TIP3))

	var_31_16:setScale(0.8)
	var_31_16:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_31_1, var_31_16, cc.p(var_31_2.x - 170, var_31_2.y - 14))

	local var_31_17 = ClientView.createShaderButton("img_btn_recharge_2", function(arg_32_0)
		arg_31_0:onBuy(arg_31_1)
	end)

	lc.addChildToPos(var_31_1, var_31_17, cc.p(var_31_2.x + 10, 100))

	if var_31_5 > 0 then
		var_31_17:setDisabledShader(ClientView.SHADER_DISABLE)
		var_31_17:setEnabled(false)
		var_31_17:addLabel(Str(STR.PURCHASED))
	else
		var_31_17:addLabel(Str(STR.BUY_NOW))
	end

	return var_31_1
end

function var_0_0.initFund(arg_33_0)
	local var_33_0 = arg_33_0._detailLayer
	local var_33_1 = lc.createSprite("res/jpg/activity_fund.jpg")

	lc.addChildToPos(var_33_0, var_33_1, cc.p(lc.cw(var_33_1) + 4, lc.ch(var_33_1)), 10)

	local var_33_2 = lc.w(var_33_1)
	local var_33_3 = ClientView.createShaderButton("img_btn_recharge_5", function(arg_34_0)
		arg_33_0:onBuy(Data.PurchaseType.fund)
	end)

	lc.addChildToPos(var_33_1, var_33_3, cc.p(lc.cw(var_33_1), 50))
	var_33_3:setDisabledShader(ClientView.SHADER_DISABLE)
	var_33_3:addLabel(Str(STR.BUY_NOW))

	arg_33_0._fundBtn = var_33_3

	local var_33_4 = lc.List.createV(cc.size(lc.w(var_33_0) - lc.w(var_33_1) - 8, lc.h(var_33_0)), 16, 10)

	var_33_4:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_33_0, var_33_4, cc.p(lc.w(var_33_0) - lc.cw(var_33_4), lc.ch(var_33_4)))

	arg_33_0._fundList = var_33_4

	arg_33_0:updateFund()
end

function var_0_0.updateFund(arg_35_0)
	local var_35_0 = arg_35_0._fundBtn

	if not ClientData.isRecharged(Data.PurchaseType.fund) then
		var_35_0._label:setString(Str(STR.BUY_NOW))
	else
		var_35_0._label:setString(Str(STR.PURCHASED))
		var_35_0:setEnabled(false)
	end

	if not ClientData._cfg or ClientData._cfg.testFund ~= 1 then
		var_35_0._label:setString(Str(STR.CANNOT_BUY))
		var_35_0:setEnabled(false)
	end

	local var_35_1 = arg_35_0._fundList
	local var_35_2 = P._playerBonus._bonusFundLevel
	local var_35_3 = {}
	local var_35_4, var_35_5, var_35_6 = P._playerBonus.splitBonus(var_35_2)

	table.sort(var_35_4, function(arg_36_0, arg_36_1)
		return arg_36_0._info._val < arg_36_1._info._val
	end)
	table.sort(var_35_5, function(arg_37_0, arg_37_1)
		return arg_37_0._info._val < arg_37_1._info._val
	end)
	table.sort(var_35_6, function(arg_38_0, arg_38_1)
		return arg_38_0._info._val < arg_38_1._info._val
	end)

	for iter_35_0, iter_35_1 in ipairs(var_35_4) do
		table.insert(var_35_3, iter_35_1)
	end

	for iter_35_2, iter_35_3 in ipairs(var_35_5) do
		table.insert(var_35_3, iter_35_3)
	end

	for iter_35_4, iter_35_5 in ipairs(var_35_6) do
		table.insert(var_35_3, iter_35_5)
	end

	var_35_1:bindData(var_35_3, function(arg_39_0, arg_39_1)
		arg_35_0:setOrCreateItem(arg_39_0, arg_39_1)
	end, math.min(5, #var_35_3))

	for iter_35_6 = 1, var_35_1._cacheCount do
		var_35_1:pushBackCustomItem(arg_35_0:setOrCreateItem(nil, var_35_3[iter_35_6]))
	end
end

function var_0_0.initFund2(arg_40_0)
	local var_40_0 = arg_40_0._detailLayer
	local var_40_1 = lc.createSprite("res/jpg/activity_fund2.jpg")

	lc.addChildToPos(var_40_0, var_40_1, cc.p(lc.cw(var_40_1) + 4, lc.ch(var_40_1)), 10)

	local var_40_2 = lc.w(var_40_1)
	local var_40_3 = ClientView.createShaderButton("img_btn_recharge_5", function(arg_41_0)
		arg_40_0:onBuy(var_40_0._purchaseType)
	end)

	lc.addChildToPos(var_40_1, var_40_3, cc.p(lc.cw(var_40_1), 50))
	var_40_3:setDisabledShader(ClientView.SHADER_DISABLE)
	var_40_3:addLabel(Str(STR.BUY_NOW))

	arg_40_0._fundBtn = var_40_3

	local var_40_4 = lc.List.createV(cc.size(lc.w(var_40_0) - lc.w(var_40_1) - 8, lc.h(var_40_0)), 16, 10)

	var_40_4:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_40_0, var_40_4, cc.p(lc.w(var_40_0) - lc.cw(var_40_4), lc.ch(var_40_4)))

	arg_40_0._fundList = var_40_4

	function var_40_0.update()
		local var_42_0 = Data.PurchaseType.personal_fund_7
		local var_42_1 = Data._fundInfo[var_42_0]._vip

		if not P._playerActivity._personalFundStatus[var_42_0] then
			if var_42_1 <= P._vip then
				var_40_3._label:setString(Str(STR.BUY_NOW))
				var_40_3:setEnabled(true)
			else
				var_40_3._label:setString(Str(STR.CANNOT) .. Str(STR.BUY))
				var_40_3:setEnabled(false)
			end
		else
			var_40_3._label:setString(Str(STR.PURCHASED))
			var_40_3:setEnabled(false)
		end

		var_40_3._label:setString(Str(STR.CANNOT_BUY))
		var_40_3:setEnabled(false)

		var_40_0._purchaseType = var_42_0

		local var_42_2 = Data._fundInfo[var_42_0]._bonusId
		local var_42_3 = {}

		for iter_42_0, iter_42_1 in ipairs(var_42_2) do
			var_42_3[iter_42_0] = P._playerBonus._bonuses[iter_42_1]
		end

		table.sort(var_42_3, function(arg_43_0, arg_43_1)
			local var_43_0 = arg_43_0._isClaimed and 1 or 0
			local var_43_1 = arg_43_1._isClaimed and 1 or 0

			if var_43_0 ~= var_43_1 then
				return var_43_0 < var_43_1
			end

			return arg_43_0._infoId < arg_43_1._infoId
		end)
		var_40_4:bindData(var_42_3, function(arg_44_0, arg_44_1)
			arg_40_0:setOrCreateItem(arg_44_0, arg_44_1)
		end, math.min(5, #var_42_3))

		for iter_42_2 = 1, var_40_4._cacheCount do
			var_40_4:pushBackCustomItem(arg_40_0:setOrCreateItem(nil, var_42_3[iter_42_2]))
		end
	end

	var_40_0.update()
end

function var_0_0.initPersonalFund(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0._detailLayer
	local var_45_1 = lc.createSprite(string.format("res/jpg/activity_personal_fund_%s.jpg", arg_45_1))

	lc.addChildToPos(var_45_0, var_45_1, cc.p(lc.cw(var_45_1) + 4, lc.ch(var_45_1)), 10)

	local var_45_2 = lc.w(var_45_1)
	local var_45_3 = ClientView.createShaderButton("img_btn_recharge_5", function(arg_46_0)
		arg_45_0:onBuy(var_45_0._purchaseType)
	end)

	lc.addChildToPos(var_45_1, var_45_3, cc.p(lc.cw(var_45_1), 50))
	var_45_3:setDisabledShader(ClientView.SHADER_DISABLE)
	var_45_3:addLabel(Str(STR.BUY_NOW))

	arg_45_0._fundBtn = var_45_3

	local var_45_4 = lc.List.createV(cc.size(lc.w(var_45_0) - lc.w(var_45_1) - 8, lc.h(var_45_0)), 16, 10)

	var_45_4:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_45_0, var_45_4, cc.p(lc.w(var_45_0) - lc.cw(var_45_4), lc.ch(var_45_4)))

	arg_45_0._fundList = var_45_4

	function var_45_0.update(arg_47_0)
		local var_47_0 = arg_47_0 and Data.PurchaseType.personal_fund_1 + arg_47_0 - 1 or var_45_0._purchaseType
		local var_47_1 = Data._fundInfo[var_47_0]._vip

		if not P._playerActivity._personalFundStatus[var_47_0] then
			if var_47_1 <= P._vip then
				if P._playerActivity:getPersonalFundBuyActivity() then
					var_45_3._label:setString(Str(STR.BUY_NOW))
					var_45_3:setEnabled(true)
				else
					var_45_3._label:setString(Str(STR.CANNOT) .. Str(STR.BUY))
					var_45_3:setEnabled(false)
				end
			else
				var_45_3._label:setString("V" .. var_47_1 .. Str(STR.CAN_S) .. Str(STR.BUY))
				var_45_3:setEnabled(false)
			end
		else
			var_45_3._label:setString(Str(STR.PURCHASED))
			var_45_3:setEnabled(false)
		end

		if arg_47_0 == 5 and (not ClientData._cfg or ClientData._cfg.testFund ~= 1) then
			var_45_3._label:setString(Str(STR.CANNOT_BUY))
			var_45_3:setEnabled(false)
		end

		var_45_0._purchaseType = var_47_0

		local var_47_2 = Data._fundInfo[var_47_0]._bonusId
		local var_47_3 = {}

		for iter_47_0, iter_47_1 in ipairs(var_47_2) do
			var_47_3[iter_47_0] = P._playerBonus._bonuses[iter_47_1]
		end

		table.sort(var_47_3, function(arg_48_0, arg_48_1)
			local var_48_0 = arg_48_0._isClaimed and 1 or 0
			local var_48_1 = arg_48_1._isClaimed and 1 or 0

			if var_48_0 ~= var_48_1 then
				return var_48_0 < var_48_1
			end

			return arg_48_0._infoId < arg_48_1._infoId
		end)
		var_45_4:bindData(var_47_3, function(arg_49_0, arg_49_1)
			arg_45_0:setOrCreateItem(arg_49_0, arg_49_1)
		end, math.min(5, #var_47_3))

		for iter_47_2 = 1, var_45_4._cacheCount do
			var_45_4:pushBackCustomItem(arg_45_0:setOrCreateItem(nil, var_47_3[iter_47_2]))
		end
	end

	var_45_0.update(arg_45_1)
end

function var_0_0.setOrCreateItem(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = string.format(Str(arg_50_2._info._nameSid), arg_50_2._info._val)

	if arg_50_1 == nil then
		arg_50_1 = require("BonusWidget").create(lc.w(arg_50_0._fundList), arg_50_2, var_50_0)
	else
		arg_50_1:setBonus(arg_50_2, var_50_0)
	end

	arg_50_1:registerCallback(function(arg_51_0)
		arg_50_0:onClainFund(arg_51_0)
	end)

	return arg_50_1
end

function var_0_0.initFeedBack(arg_52_0)
	local var_52_0 = arg_52_0._detailLayer
	local var_52_1 = lc.createSprite("res/jpg/activity_feedback.jpg")

	lc.addChildToCenter(var_52_0, var_52_1)

	local var_52_2 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_53_0)
		local var_53_0 = require("InputForm")

		var_53_0.create(var_53_0.Type.FEEDBACK):show()
	end, ClientView.CRECT_BUTTON, 240)

	lc.addChildToPos(var_52_0, var_52_2, cc.p(lc.cw(var_52_0), 112))
	var_52_2:setDisabledShader(ClientView.SHADER_DISABLE)
	var_52_2:addLabel(Str(STR.FEEDBACK))
end

function var_0_0.initInvite(arg_54_0)
	local var_54_0 = arg_54_0._detailLayer
	local var_54_1 = require("InvitePanel").create(var_54_0:getContentSize())

	lc.addChildToCenter(var_54_0, var_54_1)

	arg_54_0._invitePanel = var_54_1
end

function var_0_0.updateInvite(arg_55_0)
	return
end

function var_0_0.initLimitSmall(arg_56_0)
	local var_56_0 = arg_56_0._detailLayer
	local var_56_1 = {
		Data.PurchaseType.limit_1,
		Data.PurchaseType.limit_2,
		Data.PurchaseType.limit_0
	}
	local var_56_2 = lc.List.createH(var_56_0:getContentSize())

	lc.addChildToCenter(var_56_0, var_56_2)

	arg_56_0._packageItems = {}

	for iter_56_0 = 1, #var_56_1 do
		local var_56_3 = var_56_1[iter_56_0]
		local var_56_4 = ClientData.getValidActivityByParam(var_56_3)
		local var_56_5 = P._playerBonus._bonuses[var_56_4._bonusId[1]]
		local var_56_6 = iter_56_0 == 1 and 30 or 520
		local var_56_7, var_56_8 = arg_56_0:createPackageItem(var_56_3, var_56_5, var_56_6)

		var_56_2:pushBackCustomItem(var_56_7)

		arg_56_0._packageItems[iter_56_0] = var_56_8
	end

	arg_56_0:updateLimitSmall()
end

function var_0_0.updateLimitSmall(arg_57_0)
	for iter_57_0 = 1, #arg_57_0._packageItems do
		local var_57_0 = arg_57_0._packageItems[iter_57_0]
		local var_57_1 = var_57_0._purchaseType
		local var_57_2 = var_57_0._btn
		local var_57_3 = ClientData.getValidActivityByParam(var_57_1)
		local var_57_4 = P._playerBonus._bonuses[var_57_3._bonusId[1]]

		var_57_0:setHide(false)

		if ClientData.isRecharged(var_57_1) then
			var_57_2._label:setString(Str(STR.PURCHASED))

			if var_57_2._icon then
				var_57_2._icon:setVisible(false)
			end

			var_57_2._label:setPositionX(lc.cw(var_57_2))
			var_57_2:setEnabled(false)
		end
	end
end

function var_0_0.initActivityAd(arg_58_0, arg_58_1)
	local var_58_0 = ClientData.getValidActivityByType(arg_58_1)
	local var_58_1 = lc.createSprite(lc.formatJpg(var_58_0._img))

	lc.addChildToCenter(arg_58_0._detailLayer, var_58_1)

	local var_58_2 = ClientView.createShaderButton("img_btn_recharge_1", function(arg_59_0)
		return
	end)

	lc.addChildToPos(var_58_1, var_58_2, cc.p(lc.cw(var_58_1), 50))
	var_58_2:addLabel(Str(STR.GO))

	if arg_58_1 == Data.ActivityType.week_lottery then
		local var_58_3, var_58_4 = ClientData.getActivityDurationStr(var_58_0, true, true)
		local var_58_5 = ClientView.createTTF(string.format(Str(STR.LOTTERY_RESET_TIME), var_58_4))

		lc.addChildToPos(var_58_1, var_58_5, cc.p(lc.x(var_58_2), lc.top(var_58_2) + lc.ch(var_58_5) + 5))

		function var_58_2._callback()
			lc.pushScene(require("LotteryScene").create(Data.LotteryType.week))
		end
	end
end

function var_0_0.initLimitLarge(arg_61_0, arg_61_1)
	local var_61_0 = Data.PurchaseType.limit_minus_2 + arg_61_1 - var_0_0.Tab.limit_large_minus_2

	if arg_61_1 == var_0_0.Tab.daily_3 then
		var_61_0 = Data.PurchaseType.daily_3
	end

	local var_61_1 = var_0_0.createLimitLarge(var_61_0, arg_61_0._detailLayer, true)

	if var_61_1 == nil then
		return
	end

	local var_61_2 = ClientData.getValidActivityByParam(var_61_0)

	if var_61_0 == Data.PurchaseType.daily_3 then
		var_61_2 = ClientData.getValidActivityByType(Data.ActivityType.daily_3)
	end

	for iter_61_0 = 1, #var_61_1 do
		if var_61_0 == Data.PurchaseType.limit_minus_2 or var_61_0 == Data.PurchaseType.limit_minus_1 or var_61_0 == Data.PurchaseType.limit_1 or var_61_0 == Data.PurchaseType.limit_2 or var_61_0 == Data.PurchaseType.limit_0 or var_61_0 == Data.PurchaseType.daily_3 then
			var_61_1[iter_61_0]._callback = function(arg_62_0)
				arg_61_0:onBuy(var_61_0 + iter_61_0 - 1)
			end

			if #var_61_2._bonusId <= P._playerBonus._bonuses[var_61_2._bonusId[1]]._value and var_61_0 ~= Data.PurchaseType.limit_minus_2 then
				var_61_1[iter_61_0]._label:setString(Str(STR.PURCHASED))
				var_61_1[iter_61_0]:setEnabled(false)
			end
		else
			var_61_1[iter_61_0]._callback = function(arg_63_0)
				if var_61_0 == Data.PurchaseType.limit_3 then
					ClientView.tryGotoFindLadder(false)
				elseif var_61_0 == Data.PurchaseType.limit_4 then
					ClientView.tryGotoFindClash(false)
				end
			end
		end
	end
end

function var_0_0.createLimitLarge(arg_64_0, arg_64_1, arg_64_2)
	print("+++++++++++++++purchaseType", arg_64_0)

	local var_64_0 = ClientData.getValidActivityByParam(arg_64_0)

	if arg_64_0 == Data.PurchaseType.daily_3 then
		var_64_0 = ClientData.getValidActivityByType(Data.ActivityType.daily_3)
	end

	local var_64_1 = "res/jpg/activity_limit_large_0" .. arg_64_0 - Data.PurchaseType.limit_0 .. ".jpg"

	if #var_64_0._img > 0 then
		var_64_1 = lc.formatJpg(var_64_0._img)
	end

	local var_64_2 = lc.createSprite(var_64_1)

	lc.addChildToCenter(arg_64_1, var_64_2)

	arg_64_1._bg = var_64_2

	local var_64_3 = {}

	if (arg_64_0 == Data.PurchaseType.limit_3 or arg_64_0 == Data.PurchaseType.limit_4) and arg_64_2 then
		local var_64_4 = {
			cc.p(564, 70),
			cc.p(564, 110),
			cc.p(564, 70)
		}
		local var_64_5 = ClientView.createShaderButton("img_btn_recharge_1", function(arg_65_0)
			return
		end)

		lc.addChildToPos(var_64_2, var_64_5, var_64_4[arg_64_0 - Data.PurchaseType.limit_3 + 1])
		var_64_5:addLabel(Str(STR.GO))

		var_64_3[1] = var_64_5
	end

	if arg_64_0 == Data.PurchaseType.limit_5 then
		return
	end

	if arg_64_0 >= Data.PurchaseType.limit_3 and arg_64_0 ~= Data.PurchaseType.daily_3 then
		return var_64_3
	end

	for iter_64_0 = 1, 1 do
		local var_64_6 = #var_64_0._bonusId
		local var_64_7 = P._playerBonus._bonuses[var_64_0._bonusId[1]]
		local var_64_8 = var_64_6 == 1 and var_64_7 or P._playerBonus._bonuses[var_64_0._bonusId[math.min(3, var_64_7._value + 1)]]
		local var_64_9 = {}
		local var_64_10 = var_64_8._info

		for iter_64_1 = 1, #var_64_10._rid do
			local var_64_11 = IconWidget.create({
				_infoId = var_64_10._rid[iter_64_1],
				_level = var_64_10._level[iter_64_1],
				_count = var_64_10._count[iter_64_1],
				_isFragment = var_64_10._isFragment[iter_64_1] > 0
			})

			var_64_11._name:setVisible(false)
			table.insert(var_64_9, var_64_11)
		end

		P:sortResultItems(var_64_9)

		local var_64_12 = arg_64_0 == Data.PurchaseType.limit_minus_1 or arg_64_0 == Data.PurchaseType.daily_3
		local var_64_13 = 120
		local var_64_14 = 260

		if var_64_12 then
			var_64_13, var_64_14 = -5, 200
		end

		for iter_64_2 = 1, #var_64_9 do
			local var_64_15 = var_64_9[iter_64_2]
			local var_64_16 = cc.p(lc.cw(arg_64_1) + var_64_13 + (lc.w(var_64_15) + 10) * (iter_64_2 - (#var_64_9 + 1) / 2), var_64_14)

			var_64_15:setScale(0.9)
			lc.addChildToPos(arg_64_1, var_64_15, var_64_16)
		end

		if arg_64_2 then
			local var_64_17 = ClientView.createShaderButton("img_btn_recharge_1", function(arg_66_0)
				return
			end)
			local var_64_18 = 680
			local var_64_19 = 125

			if var_64_12 then
				var_64_18, var_64_19 = 550, 90
			end

			lc.addChildToPos(var_64_2, var_64_17, cc.p(var_64_18, var_64_19))
			var_64_17:setDisabledShader(ClientView.SHADER_DISABLE)
			var_64_17:addLabel(Str(STR.BUY_NOW))

			var_64_3[iter_64_0] = var_64_17
		end
	end

	return var_64_3
end

function var_0_0.initReturnPackage(arg_67_0)
	local var_67_0 = var_0_0.createReturnPackage(arg_67_0._detailLayer, true)

	function var_67_0._callback(arg_68_0)
		arg_67_0:onClaimReturnPackage()
	end

	if ClientData.isReturnToGameClaimed() then
		var_67_0._label:setString(Str(STR.CLAIMED))
		var_67_0:setEnabled(false)
	end
end

function var_0_0.createReturnPackage(arg_69_0, arg_69_1)
	local var_69_0 = "activity_return"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_69_0 .. "_2")) then
		var_69_0 = var_69_0 .. "_2"
	end

	local var_69_1 = lc.createSprite(lc.formatJpg(var_69_0))

	lc.addChildToCenter(arg_69_0, var_69_1)

	arg_69_0._bg = var_69_1

	local var_69_2 = P._playerBonus._returnBonus
	local var_69_3 = {}
	local var_69_4 = var_69_2._info

	for iter_69_0 = 1, #var_69_4._rid do
		local var_69_5 = IconWidget.create({
			_infoId = var_69_4._rid[iter_69_0],
			_level = var_69_4._level[iter_69_0],
			_count = var_69_4._count[iter_69_0],
			_isFragment = var_69_4._isFragment[iter_69_0] > 0
		})

		var_69_5._name:setVisible(false)
		table.insert(var_69_3, var_69_5)
	end

	P:sortResultItems(var_69_3)

	local var_69_6 = -122
	local var_69_7 = 374

	for iter_69_1 = 1, 2 do
		for iter_69_2 = 1, 3 do
			local var_69_8 = var_69_3[(iter_69_1 - 1) * 3 + iter_69_2]

			if var_69_8 ~= nil then
				local var_69_9 = cc.p(lc.cw(arg_69_0) + var_69_6 + (lc.w(var_69_8) + 20) * (iter_69_2 - 2), var_69_7 - iter_69_1 * 110)

				var_69_8:setScale(0.9)
				lc.addChildToPos(arg_69_0, var_69_8, var_69_9)
			end
		end
	end

	local var_69_10 = ClientView.createShaderButton("img_btn_recharge_1", function(arg_70_0)
		return
	end)
	local var_69_11 = 436
	local var_69_12 = 56

	lc.addChildToPos(var_69_1, var_69_10, cc.p(var_69_11, var_69_12))
	var_69_10:setDisabledShader(ClientView.SHADER_DISABLE)
	var_69_10:addLabel(Str(STR.CLAIM))
	var_69_10:setVisible(arg_69_1)

	return var_69_10
end

function var_0_0.createAdRecharge(arg_71_0)
	local var_71_0 = lc.createSprite("res/jpg/activity_recharge.jpg")

	lc.addChildToCenter(arg_71_0, var_71_0)

	arg_71_0._bg = var_71_0

	local var_71_1 = P._playerBonus._packageBonus[1120]
	local var_71_2 = {}
	local var_71_3 = var_71_1._info

	for iter_71_0 = 1, #var_71_3._rid do
		local var_71_4 = IconWidget.create({
			_infoId = var_71_3._rid[iter_71_0],
			_level = var_71_3._level[iter_71_0],
			_count = var_71_3._count[iter_71_0],
			_isFragment = var_71_3._isFragment[iter_71_0] > 0
		})

		var_71_4._name:setVisible(false)
		table.insert(var_71_2, var_71_4)
	end

	P:sortResultItems(var_71_2)

	local var_71_5 = -122
	local var_71_6 = 256

	for iter_71_1 = 1, #var_71_2 do
		local var_71_7 = var_71_2[iter_71_1]
		local var_71_8 = cc.p(lc.cw(arg_71_0) + var_71_5 + (lc.w(var_71_7) + 10) * (iter_71_1 - (#var_71_2 + 1) / 2), var_71_6)

		var_71_7:setScale(0.9)
		lc.addChildToPos(arg_71_0, var_71_7, var_71_8)
	end
end

function var_0_0.createAdPackage(arg_72_0)
	local var_72_0 = lc.createSprite("res/jpg/activity_package.jpg")

	lc.addChildToCenter(arg_72_0, var_72_0)

	arg_72_0._bg = var_72_0

	local var_72_1 = P._playerBonus._packageBonus[1121]
	local var_72_2 = {}
	local var_72_3 = var_72_1._info

	for iter_72_0 = 1, #var_72_3._rid do
		local var_72_4 = IconWidget.create({
			_infoId = var_72_3._rid[iter_72_0],
			_level = var_72_3._level[iter_72_0],
			_count = var_72_3._count[iter_72_0],
			_isFragment = var_72_3._isFragment[iter_72_0] > 0
		})

		var_72_4._name:setVisible(false)
		table.insert(var_72_2, var_72_4)
	end

	P:sortResultItems(var_72_2)

	local var_72_5 = -128
	local var_72_6 = 228

	for iter_72_1 = 1, #var_72_2 do
		local var_72_7 = var_72_2[iter_72_1]
		local var_72_8 = cc.p(lc.cw(arg_72_0) + var_72_5 + (lc.w(var_72_7) + 10) * (iter_72_1 - (#var_72_2 + 1) / 2), var_72_6)

		var_72_7:setScale(0.9)
		lc.addChildToPos(arg_72_0, var_72_7, var_72_8)
	end
end

function var_0_0.initYYB(arg_73_0)
	local var_73_0 = lc.createSprite("res/jpg/ad_yyb.jpg")

	lc.addChildToCenter(arg_73_0, var_73_0)

	arg_73_0._bg = var_73_0

	local var_73_1 = ClientView.createShaderButton("img_btn_recharge_1", function(arg_74_0)
		lc.App:openUrl("https://imgcache.qq.com/club/themes/mobile/middle_page/index.html?url=https%3A%2F%2Fqzs.qq.com%2Fopen%2Fbaymax%2F22%2F10947_1e9d0f8e91ec91a95e6ce627da4cd12c_1.html%3Ffrom%3Djdzc")
	end)

	lc.addChildToPos(var_73_0, var_73_1, cc.p(lc.cw(var_73_0), 50))
	var_73_1:addLabel(Str(STR.GO))
end

function var_0_0.onClaimFirstRecharge(arg_75_0)
	local var_75_0 = P._playerBonus._packageBonus[1120]

	if var_75_0._value >= var_75_0._info._val then
		local var_75_1 = ClientData.claimBonus(var_75_0)

		ClientView.showClaimBonusResult(var_75_0, var_75_1)
		arg_75_0:updateAll()
	end
end

function var_0_0.onClaimRecharge7Bonus(arg_76_0)
	local var_76_0 = P._playerBonus._packageBonus[1306]

	if var_76_0._value >= var_76_0._info._val then
		local var_76_1 = ClientData.claimBonus(var_76_0)

		ClientView.showClaimBonusResult(var_76_0, var_76_1)
		arg_76_0:updateAll()
	end
end

function var_0_0.onClaimReturnPackage(arg_77_0)
	local var_77_0 = P._playerBonus._returnBonus

	if var_77_0._value >= var_77_0._info._val then
		local var_77_1 = ClientData.claimBonus(var_77_0)

		ClientView.showClaimBonusResult(var_77_0, var_77_1)
		arg_77_0:updateAll()
	end
end

function var_0_0.onClainFund(arg_78_0, arg_78_1)
	if arg_78_1._value >= arg_78_1._info._val and not arg_78_1._isClaimed then
		local var_78_0 = clone(arg_78_1)
		local var_78_1 = ClientData.claimBonus(arg_78_1)

		if arg_78_0._detailLayer and arg_78_0._detailLayer.update then
			arg_78_0._detailLayer.update()
			arg_78_0:updateButtonFlags()
		else
			arg_78_0:updateAll()
		end

		ClientView.showClaimBonusResult(var_78_0, var_78_1)
	end
end

function var_0_0.onBuy(arg_79_0, arg_79_1)
	ClientView.startIAP(arg_79_1)
end

function var_0_0.getFirstRechargeStatus(arg_80_0)
	if not ClientData.isGemRecharged() or P._playerBonus:getFirstRechargeFlag() > 0 then
		return 0
	elseif not ClientData.isRecharge7BonusClaimed() then
		return 1
	else
		return 2
	end
end

function var_0_0.updateAll(arg_81_0)
	arg_81_0:updateTabs()
	arg_81_0:updateButtonFlags()
end

function var_0_0.updateButtonFlags(arg_82_0)
	local var_82_0 = arg_82_0._tabArea._list:getItems()
	local var_82_1 = arg_82_0:getTabByType(var_0_0.Tab.first_recharge)

	if var_82_1 then
		local var_82_2 = arg_82_0:getFirstRechargeStatus()

		if var_82_2 == 0 then
			ClientView.checkNewFlag(var_82_1, P._playerBonus:getFirstRechargeFlag(), -10, -10)
		elseif var_82_2 == 1 then
			ClientView.checkNewFlag(var_82_1, P._playerBonus:getRecharge7Flag(), -10, -10)
		end
	end

	local var_82_3 = arg_82_0:getTabByType(var_0_0.Tab.fund)

	if var_82_3 then
		ClientView.checkNewFlag(var_82_3, P._playerBonus:getFundBonusFlag() + P._playerBonus:getFund2BonusFlag(), -10, -10)
	end

	local var_82_4 = arg_82_0:getTabByType(var_0_0.Tab.fund * 10000 + 1)

	if var_82_4 then
		ClientView.checkNewFlag(var_82_4, P._playerBonus:getFundBonusFlag(), -10, -10)
	end

	local var_82_5 = arg_82_0:getTabByType(var_0_0.Tab.fund * 10000 + 2)

	if var_82_5 then
		ClientView.checkNewFlag(var_82_5, P._playerBonus:getFund2BonusFlag(), -10, -10)
	end

	local var_82_6 = arg_82_0:getTabByType(var_0_0.Tab.exp_fund)

	if var_82_6 then
		ClientView.checkNewFlag(var_82_6, P._playerBonus:getExpFundBonusFlag(), -10, -10)
	end

	local var_82_7 = arg_82_0:getTabByType(var_0_0.Tab.invite)

	if var_82_7 then
		ClientView.checkNewFlag(var_82_7, P._playerBonus:getInviteBonusFlag(), -10, -10)
	end

	local var_82_8 = arg_82_0:getTabByType(var_0_0.Tab.return_to_game)

	if var_82_8 then
		ClientView.checkNewFlag(var_82_8, P._playerBonus:getReturnPackageFlag(), -10, -10)
	end

	local var_82_9 = arg_82_0:getTabByType(var_0_0.Tab.personal_fund)

	if var_82_9 then
		ClientView.checkNewFlag(var_82_9, P._playerBonus:getPersonalFundFlag(), -10, -10)
	end

	for iter_82_0 = 1, 4 do
		local var_82_10 = var_0_0.Tab.personal_fund * 10000 + iter_82_0
		local var_82_11 = arg_82_0:getTabByType(var_82_10)
		local var_82_12 = Data.PurchaseType.personal_fund_1 + iter_82_0 - 1

		if var_82_11 then
			ClientView.checkNewFlag(var_82_11, P._playerBonus:getPersonalFundFlag(var_82_12), -10, -10)
		end
	end

	local var_82_13 = arg_82_0:getTabByType(var_0_0.Tab.new_server)

	if var_82_13 then
		ClientView.checkNewFlag(var_82_13, P._playerBonus:getNewServerBonusFlag(), -10, -10)
	end

	for iter_82_1 = Data.ActivityType.clash_bonus, Data.ActivityType.level_bonus do
		local var_82_14 = var_0_0.Tab.new_server * 10000 + iter_82_1
		local var_82_15 = arg_82_0:getTabByType(var_82_14)

		if var_82_15 then
			ClientView.checkNewFlag(var_82_15, P._playerBonus:getNewServerBonusFlag(iter_82_1), -10, -10)
		end
	end
end

function var_0_0.getTabByType(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0._tabArea._list:getItems()

	for iter_83_0 = 1, #var_83_0 do
		local var_83_1 = var_83_0[iter_83_0]

		if var_83_1._index == arg_83_1 then
			return var_83_1
		end
	end

	return nil
end

function var_0_0.onEvent(arg_84_0, arg_84_1, arg_84_2)
	if arg_84_2 == Data.Event.fund_dirty or arg_84_2 == Data.Event.month_card_dirty or arg_84_2 == Data.Event.package_dirty then
		arg_84_0:updateAll()
	elseif arg_84_2 == Data.Event.bonus_dirty then
		local var_84_0 = arg_84_1._data

		if var_84_0 and var_84_0._info._type == Data.BonusType.fund_all then
			arg_84_0:updateAll()
		end
	elseif arg_84_2 == Data.Event.personal_fund_dirty and arg_84_0._detailLayer.update then
		arg_84_0._detailLayer.update()
		arg_84_0:updateButtonFlags()
	end
end

function var_0_0.getHelpType(arg_85_0)
	local var_85_0 = arg_85_0._tabArea._focusedTab._index

	if arg_85_0._actType == Data.ActivityType.new_server_begin or arg_85_0._actType == Data.ActivityType.rank1 then
		local var_85_1 = ClientView.createShaderButton("img_btn_rule", function()
			ClientView.showHelpForm(nil, Data.HelpType.new_server_begin + 2)
		end)

		lc.addChildToPos(ad, var_85_1, cc.p(lc.cw(ad) + 362, 170))
	end

	if math.floor(var_85_0 / 10000) == var_0_0.Tab.new_server and (var_85_0 % 10000 == 1 or var_85_0 % 10000 == 3) then
		return Data.HelpType.new_server_begin + 2
	elseif var_85_0 == var_0_0.Tab.vote then
		return Data.HelpType.vote
	elseif var_85_0 == var_0_0.Tab.month_card then
		return Data.HelpType.month_card
	elseif var_85_0 == var_0_0.Tab.month_card3 then
		return Data.HelpType.month_card3
	end
end

function var_0_0.syncData(arg_87_0)
	var_0_0.super.syncData(arg_87_0)
	arg_87_0:updateAll()
end

return var_0_0
