local var_0_0 = require("BaseUIScene")
local var_0_1 = class("TavernScene", var_0_0)
local var_0_2 = require("CardInfoPanel")
local var_0_3 = 1
local var_0_4 = 250
local var_0_5 = 160
local var_0_6 = 110
local var_0_7 = {
	Data.PropsId.miracle_indicator,
	Data.PropsId.dust_rare,
	Data.PropsId.dust_magic,
	Data.PropsId.dust_monster
}

var_0_1.TAB = {
	diamond_shop = 7,
	clash = 15,
	vote_shop = 13,
	rare_shop = 6,
	badge_shop = 19,
	select_card = 12,
	depot_shop = 4,
	critical_card = 11,
	collect = 16,
	vote_recovery = 14,
	skill_shop = 18,
	rare_draw_card = 3,
	time_limit = 1,
	month_card5_shop = 20,
	new_shop = 17,
	god_pump = 10,
	draw_card = 2,
	god_shop = 8
}

function var_0_1.create(arg_1_0, arg_1_1)
	return lc.createScene(var_0_1, arg_1_0, arg_1_1)
end

function var_0_1.init(arg_2_0, arg_2_1, arg_2_2)
	if not var_0_1.super.init(arg_2_0, ClientData.SceneId.tavern, STR.SID_FIXITY_NAME_1007, var_0_0.STYLE_SIMPLE, true) then
		return false
	end

	arg_2_0._resNames = ClientData.loadLCRes("res/activity.lcres")

	arg_2_0:generateCardPackageData()

	arg_2_0._focusInfoId = arg_2_1

	local var_2_0 = arg_2_2 or var_0_1.TAB.draw_card
	local var_2_1 = {}

	if #arg_2_0._timeLimitPackages > 0 then
		table.insert(var_2_1, {
			_index = var_0_1.TAB.time_limit,
			_str = Str(STR.TIME_LIMIT_PACKAGE)
		})

		var_2_0 = var_0_1.TAB.time_limit
	end

	table.insert(var_2_1, {
		_index = var_0_1.TAB.draw_card,
		_str = Str(STR.CHARACTER) .. Str(STR.PACKAGE)
	})

	if P._vip >= 1 then
		table.insert(var_2_1, {
			_index = var_0_1.TAB.critical_card,
			_str = Str(STR.CRITICAL_PACKAGE)
		})
	end

	table.insert(var_2_1, {
		_index = var_0_1.TAB.rare_draw_card,
		_str = Str(STR.RARE) .. Str(STR.PACKAGE)
	})

	if #arg_2_0._clashPackages > 0 then
		table.insert(var_2_1, {
			_index = var_0_1.TAB.clash,
			_str = Str(STR.CLASH_PACKAGE)
		})
	end

	if #arg_2_0._collectPackages > 0 then
		table.insert(var_2_1, {
			_index = var_0_1.TAB.collect,
			_str = Str(STR.COLLECT_PACKAGE)
		})
	end

	if #arg_2_0._godPumpPackages > 0 and P._vip >= 1 then
		table.insert(var_2_1, {
			_index = var_0_1.TAB.god_pump,
			_str = Str(STR.GOD_PUMP)
		})
	end

	if not ClientData.isAnotherSkin2Locked() then
		table.insert(var_2_1, {
			_index = var_0_1.TAB.rare_shop,
			_str = Str(STR.GOD_SHOP)
		})
		table.insert(var_2_1, {
			_index = var_0_1.TAB.diamond_shop,
			_str = Str(STR.DIAMOND_SHOP)
		})
		table.insert(var_2_1, {
			_index = var_0_1.TAB.depot_shop,
			_str = Str(STR.DEPOT_SHOP)
		})
		table.insert(var_2_1, {
			_index = var_0_1.TAB.vote_shop,
			_str = Str(STR.VOTE_SHOP)
		})
		table.insert(var_2_1, {
			_index = var_0_1.TAB.new_shop,
			_str = Str(STR.NEW_SHOP)
		})
		table.insert(var_2_1, 1, {
			_index = var_0_1.TAB.skill_shop,
			_str = Str(STR.SKILL_SHOP)
		})
		table.insert(var_2_1, 2, {
			_index = var_0_1.TAB.badge_shop,
			_str = Str(STR.BADGE_SHOP)
		})
		table.insert(var_2_1, 1, {
			_index = var_0_1.TAB.month_card5_shop,
			_str = Str(STR.MONTH_CARD5_SHOP)
		})

		local var_2_2 = ClientData.getServerTick()

		for iter_2_0, iter_2_1 in ipairs(Data._recallInfo) do
			if var_2_2 >= iter_2_1._startTime and var_2_2 <= iter_2_1._endTime then
				table.insert(var_2_1, {
					_index = var_0_1.TAB.vote_recovery,
					_str = Str(STR.CARD) .. Str(STR.RECOVERY)
				})

				break
			end
		end
	end

	if #arg_2_0._selectPackages > 0 then
		var_2_0 = var_0_1.TAB.select_card

		table.insert(var_2_1, 1, {
			_index = var_0_1.TAB.select_card,
			_str = Str(STR.SELECT_PACKAGE)
		})
	end

	local var_2_3 = ClientView.createVerticalTabListArea(lc.bottom(arg_2_0._titleArea), var_2_1, function(arg_3_0, arg_3_1, arg_3_2)
		if not arg_3_1 or arg_3_2 then
			arg_2_0:showTab(arg_3_0)
		end
	end, ClientView.SCR_EDGE)

	lc.addChildToPos(arg_2_0, var_2_3, cc.p(lc.w(var_2_3) / 2 - 4 + ClientView.SCR_EDGE, lc.bottom(arg_2_0._titleArea) / 2 + 2), 1)

	arg_2_0._tabArea = var_2_3

	function arg_2_0._titleArea._btnBack._callback()
		if arg_2_0._detailPanel then
			arg_2_0:hideCardBox()
		elseif arg_2_0._shopArea and arg_2_0._shopArea._detailPanel then
			arg_2_0._shopArea:hideCardBox()
		else
			arg_2_0:hide()
		end
	end

	local var_2_4 = lc.List.createH(cc.size(lc.w(arg_2_0) - lc.right(var_2_3), lc.h(arg_2_0) - 60), 30, 30)

	var_2_4:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0, var_2_4, cc.p(lc.right(var_2_3) + lc.cw(var_2_4), lc.ch(var_2_4)))

	arg_2_0._recruitItems = {}

	var_2_4:setVisible(false)

	arg_2_0._list = var_2_4
	arg_2_0._packageCards = {}

	local var_2_5

	for iter_2_2, iter_2_3 in pairs(Data._recruitInfo) do
		if iter_2_3._value == arg_2_1 then
			var_2_5 = iter_2_3

			break
		end
	end

	if arg_2_1 and var_2_5 then
		if Data.getIsTimeLimitRecruite(var_2_5) then
			var_2_0 = var_0_1.TAB.time_limit
		elseif Data.getIsRareRecruite(var_2_5) then
			var_2_0 = var_0_1.TAB.rare_draw_card
		elseif Data.getIsCharacterRecruite(var_2_5) then
			var_2_0 = var_0_1.TAB.draw_card
		elseif Data.getIsTimeLimitCriticalRecruite(var_2_5) then
			var_2_0 = var_0_1.TAB.critical_card
		end
	end

	arg_2_0._tabArea:showTab(var_2_0)

	return true
end

function var_0_1.generateCardPackageData(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(Data._recruitInfo) do
		if iter_5_1._isHide == 0 or iter_5_1._isHide == 2 and not ClientData.isAnotherSkin2Locked() then
			var_5_0[#var_5_0 + 1] = iter_5_1
		end
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0._value > 216000
		local var_6_1 = arg_6_1._value > 216000
		local var_6_2 = arg_6_0._value > 200000
		local var_6_3 = arg_6_1._value > 200000
		local var_6_4 = arg_6_0._value > 100000
		local var_6_5 = arg_6_1._value > 100000
		local var_6_6 = arg_5_0:isLocked(arg_6_0)
		local var_6_7 = arg_5_0:isLocked(arg_6_1)

		if var_6_0 and not var_6_1 then
			return true
		elseif not var_6_0 and var_6_1 then
			return false
		elseif var_6_2 and not var_6_3 then
			return true
		elseif not var_6_2 and var_6_3 then
			return false
		elseif not var_6_6 and var_6_7 then
			return true
		elseif var_6_6 and not var_6_7 then
			return false
		elseif var_6_4 and not var_6_5 then
			return true
		elseif not var_6_4 and var_6_5 then
			return false
		else
			return arg_6_0._value < arg_6_1._value
		end
	end)

	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = {}
	local var_5_4 = {}
	local var_5_5 = {}
	local var_5_6 = {}
	local var_5_7 = {}
	local var_5_8 = {}

	arg_5_0._timeLimitPackages = var_5_1
	arg_5_0._godPumpPackages = var_5_2
	arg_5_0._drawCardPackages = var_5_3
	arg_5_0._rareDrawCardPackages = var_5_4
	arg_5_0._criticalPackages = var_5_5
	arg_5_0._selectPackages = var_5_6
	arg_5_0._clashPackages = var_5_7
	arg_5_0._collectPackages = var_5_8

	local function var_5_9(...)
		return {
			...
		}
	end

	if arg_5_0:isGuideRarePackage() then
		table.insert(var_5_4, var_5_9(Data._dropInfo[P._guideID < 118 and 1 or 2], Data.getRecruiteInfo(101010), Data.getRecruiteInfo(101050)))
	end

	local var_5_10 = 1

	while var_5_10 <= #var_5_0 do
		local var_5_11 = true

		if Data.getIsTimeLimitRecruite(var_5_0[var_5_10]) then
			var_5_11 = not arg_5_0:isGuideRarePackage() and not ClientData.isHideActivityPackage() and ClientData.isActivityValidByParam(var_5_0[var_5_10]._value - 200000, true)

			if not arg_5_0:isGuideRarePackage() and not var_5_11 and Data.getIsTimeLimitCriticalRecruite(var_5_0[var_5_10]) then
				local var_5_12 = var_5_0[var_5_10]._param[9]

				if var_5_12 then
					var_5_11 = P:isCharacterUnlocked(var_5_12) or var_5_12 == 11
				end
			end
		elseif Data.getIsRareRecruite(var_5_0[var_5_10]) then
			var_5_11 = not arg_5_0:isGuideRarePackage() and (P:getCharacterUnlockCount() >= 2 or ClientView.isPackageShowInRareShop(var_5_0[var_5_10]._value))
		end

		if var_5_11 then
			if Data.getIsTimeLimitFestivalRecruite(var_5_0[var_5_10]) then
				table.insert(var_5_1, var_5_9(var_5_0[var_5_10], var_5_0[var_5_10 + 1], var_5_0[var_5_10 + 2], var_5_0[var_5_10 + 3]))
			elseif Data.getIsTimeLimitCriticalRecruite(var_5_0[var_5_10]) then
				if var_5_0[var_5_10]._value >= 351001 then
					table.insert(var_5_5, var_5_9(var_5_0[var_5_10]))
				else
					table.insert(var_5_5, var_5_9(var_5_0[var_5_10], var_5_0[var_5_10 + 1]))
				end
			elseif Data.getIsTimeLimitSelectRecruite(var_5_0[var_5_10]) then
				table.insert(var_5_6, var_5_9(var_5_0[var_5_10], var_5_0[var_5_10 + 1], var_5_0[var_5_10 + 2], var_5_0[var_5_10 + 3]))
			elseif Data.getIsCollectionRecruite(var_5_0[var_5_10]) then
				table.insert(var_5_8, var_5_9(var_5_0[var_5_10], var_5_0[var_5_10 + 1]))
			elseif Data.getIsRareRecruite(var_5_0[var_5_10]) then
				table.insert(var_5_4, var_5_9(var_5_0[var_5_10], var_5_0[var_5_10 + 1], var_5_0[var_5_10 + 2]))
			elseif Data.getIsCharacterRecruite(var_5_0[var_5_10]) then
				table.insert(var_5_3, var_5_9(var_5_0[var_5_10], var_5_0[var_5_10 + 1], var_5_0[var_5_10 + 2]))
			elseif Data.getIsGodPumpRecruite(var_5_0[var_5_10]) then
				table.insert(var_5_2, var_5_9(var_5_0[var_5_10], var_5_0[var_5_10 + 1]))
			elseif Data.getIsClashRecruite(var_5_0[var_5_10]) then
				if P._playerFindClash:getGrade(P._trophy) >= math.floor((var_5_0[var_5_10]._value - 20000) / 5000) then
					table.insert(var_5_7, var_5_9(var_5_0[var_5_10]))
				end
			elseif Data.getIsTimeLimitRecruite(var_5_0[var_5_10]) then
				table.insert(var_5_1, var_5_9(var_5_0[var_5_10], var_5_0[var_5_10 + 1], var_5_0[var_5_10 + 2]))
			end
		end

		if Data.getIsTimeLimitFestivalRecruite(var_5_0[var_5_10]) or Data.getIsTimeLimitSelectRecruite(var_5_0[var_5_10]) then
			var_5_10 = var_5_10 + 4
		elseif Data.getIsTimeLimitCriticalRecruite(var_5_0[var_5_10]) or Data.getIsGodPumpRecruite(var_5_0[var_5_10]) or Data.getIsCollectionRecruite(var_5_0[var_5_10]) then
			var_5_10 = var_5_10 + 2
		elseif var_5_0[var_5_10]._value == 250101 or Data.getIsClashRecruite(var_5_0[var_5_10]) then
			var_5_10 = var_5_10 + 1
		else
			var_5_10 = var_5_10 + 3
		end
	end

	table.sort(var_5_1, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0[1]
		local var_8_1 = arg_8_1[1]

		return var_8_0._value > var_8_1._value
	end)
	table.reverse(var_5_4)
	table.sort(var_5_5, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0[1]
		local var_9_1 = arg_9_1[1]
		local var_9_2 = arg_5_0:isLocked(var_9_0) and 0 or 1
		local var_9_3 = arg_5_0:isLocked(var_9_1) and 0 or 1

		if var_9_2 ~= var_9_3 then
			return var_9_3 < var_9_2
		else
			return var_9_0._value > var_9_1._value
		end
	end)
	table.reverse(var_5_4)

	local var_5_13 = {}

	for iter_5_2, iter_5_3 in pairs(Data._exchangeInfo) do
		if Data.isGodPumpExchange(iter_5_3._activityId) then
			local var_5_14 = iter_5_3._activityId - 1000

			var_5_13[var_5_14] = var_5_13[var_5_14] or {}

			table.insert(var_5_13[var_5_14], iter_5_3._id)
		end
	end

	for iter_5_4 = 1, #var_5_13 do
		table.insert(var_5_2, iter_5_4, var_5_13[iter_5_4])
	end
end

function var_0_1.showTab(arg_10_0, arg_10_1)
	if arg_10_0._detailPanel then
		arg_10_0:hideCardBox()
	end

	if arg_10_0._shopArea and arg_10_0._shopArea.hideCardBox then
		arg_10_0._shopArea:hideCardBox()
	end

	for iter_10_0 = 1, #arg_10_0._recruitItems do
		arg_10_0:removeTexureByCheckInfo(arg_10_0._recruitItems[iter_10_0]._checkInfo)
	end

	arg_10_0._recruitItems = {}

	arg_10_0._list:setVisible(false)

	if arg_10_0._shopArea then
		arg_10_0._shopArea:removeFromParent()

		arg_10_0._shopArea = nil
	end

	if arg_10_1._index == var_0_1.TAB.draw_card then
		local var_10_0 = arg_10_0._list
		local var_10_1 = arg_10_0._drawCardPackages

		var_10_0:setVisible(true)
		var_10_0:bindData(var_10_1, function(arg_11_0, arg_11_1)
			arg_10_0:createRecruitItem(arg_11_0, arg_11_1)
		end, math.min(8, #var_10_1), 1)

		for iter_10_1 = 1, var_10_0._cacheCount do
			local var_10_2 = var_10_1[iter_10_1]
			local var_10_3 = arg_10_0:createRecruitItem(nil, var_10_2)

			var_10_0:pushBackCustomItem(var_10_3)
			table.insert(arg_10_0._recruitItems, var_10_3)
		end
	elseif arg_10_1._index == var_0_1.TAB.rare_draw_card then
		local var_10_4 = arg_10_0._list
		local var_10_5 = arg_10_0._rareDrawCardPackages

		var_10_4:setVisible(true)
		var_10_4:bindData(var_10_5, function(arg_12_0, arg_12_1)
			arg_10_0:createRecruitItem(arg_12_0, arg_12_1)
		end, math.min(8, #var_10_5), 1)

		for iter_10_2 = 1, var_10_4._cacheCount do
			local var_10_6 = var_10_5[iter_10_2]
			local var_10_7 = arg_10_0:createRecruitItem(nil, var_10_6)

			var_10_4:pushBackCustomItem(var_10_7)
			table.insert(arg_10_0._recruitItems, var_10_7)
		end
	elseif arg_10_1._index == var_0_1.TAB.critical_card then
		local var_10_8 = arg_10_0._list
		local var_10_9 = arg_10_0._criticalPackages

		var_10_8:setVisible(true)
		var_10_8:bindData(var_10_9, function(arg_13_0, arg_13_1)
			arg_10_0:createRecruitItem(arg_13_0, arg_13_1)
		end, math.min(8, #var_10_9), 1)

		for iter_10_3 = 1, var_10_8._cacheCount do
			local var_10_10 = var_10_9[iter_10_3]
			local var_10_11 = arg_10_0:createRecruitItem(nil, var_10_10)

			var_10_8:pushBackCustomItem(var_10_11)
			table.insert(arg_10_0._recruitItems, var_10_11)
		end
	elseif arg_10_1._index == var_0_1.TAB.select_card then
		local var_10_12 = arg_10_0._list
		local var_10_13 = arg_10_0._selectPackages

		var_10_12:setVisible(true)
		var_10_12:bindData(var_10_13, function(arg_14_0, arg_14_1)
			arg_10_0:createRecruitItem(arg_14_0, arg_14_1)
		end, math.min(8, #var_10_13), 1)

		for iter_10_4 = 1, var_10_12._cacheCount do
			local var_10_14 = var_10_13[iter_10_4]
			local var_10_15 = arg_10_0:createRecruitItem(nil, var_10_14)

			var_10_12:pushBackCustomItem(var_10_15)
			table.insert(arg_10_0._recruitItems, var_10_15)
		end
	elseif arg_10_1._index == var_0_1.TAB.time_limit then
		local var_10_16 = arg_10_0._list
		local var_10_17 = arg_10_0._timeLimitPackages

		var_10_16:setVisible(true)
		var_10_16:bindData(var_10_17, function(arg_15_0, arg_15_1)
			arg_10_0:createRecruitItem(arg_15_0, arg_15_1)
		end, math.min(8, #var_10_17), 1)

		for iter_10_5 = 1, var_10_16._cacheCount do
			local var_10_18 = var_10_17[iter_10_5]
			local var_10_19 = arg_10_0:createRecruitItem(nil, var_10_18)

			var_10_16:pushBackCustomItem(var_10_19)
			table.insert(arg_10_0._recruitItems, var_10_19)
		end
	elseif arg_10_1._index == var_0_1.TAB.collect then
		local var_10_20 = arg_10_0._list
		local var_10_21 = arg_10_0._collectPackages

		var_10_20:setVisible(true)
		var_10_20:bindData(var_10_21, function(arg_16_0, arg_16_1)
			arg_10_0:createRecruitItem(arg_16_0, arg_16_1)
		end, math.min(8, #var_10_21), 1)

		for iter_10_6 = 1, var_10_20._cacheCount do
			local var_10_22 = var_10_21[iter_10_6]
			local var_10_23 = arg_10_0:createRecruitItem(nil, var_10_22)

			var_10_20:pushBackCustomItem(var_10_23)
			table.insert(arg_10_0._recruitItems, var_10_23)
		end
	elseif arg_10_1._index == var_0_1.TAB.god_pump then
		local var_10_24 = arg_10_0._list
		local var_10_25 = arg_10_0._godPumpPackages

		var_10_24:setVisible(true)
		var_10_24:bindData(var_10_25, function(arg_17_0, arg_17_1)
			arg_10_0:createRecruitItem(arg_17_0, arg_17_1)
		end, math.min(8, #var_10_25), 1)

		for iter_10_7 = 1, var_10_24._cacheCount do
			local var_10_26 = var_10_25[iter_10_7]
			local var_10_27 = arg_10_0:createRecruitItem(nil, var_10_26)

			var_10_24:pushBackCustomItem(var_10_27)
			table.insert(arg_10_0._recruitItems, var_10_27)
		end
	elseif arg_10_1._index == var_0_1.TAB.clash then
		local var_10_28 = arg_10_0._list
		local var_10_29 = arg_10_0._clashPackages

		var_10_28:setVisible(true)
		var_10_28:bindData(var_10_29, function(arg_18_0, arg_18_1)
			arg_10_0:createRecruitItem(arg_18_0, arg_18_1)
		end, math.min(8, #var_10_29), 1)

		for iter_10_8 = 1, var_10_28._cacheCount do
			local var_10_30 = var_10_29[iter_10_8]
			local var_10_31 = arg_10_0:createRecruitItem(nil, var_10_30)

			var_10_28:pushBackCustomItem(var_10_31)
			table.insert(arg_10_0._recruitItems, var_10_31)
		end
	elseif arg_10_1._index == var_0_1.TAB.depot_shop then
		arg_10_0._shopArea = require("DepotShopArea").create(lc.w(arg_10_0._list) - 100, lc.h(arg_10_0._list))

		lc.addChildToPos(arg_10_0, arg_10_0._shopArea, cc.p(lc.x(arg_10_0._list), lc.y(arg_10_0._list) - 20))
	elseif arg_10_1._index == var_0_1.TAB.skill_shop then
		arg_10_0._shopArea = require("SkillShopArea").create(lc.w(arg_10_0._list) - 100, lc.h(arg_10_0._list))

		lc.addChildToPos(arg_10_0, arg_10_0._shopArea, cc.p(lc.x(arg_10_0._list), lc.y(arg_10_0._list) - 20))
	elseif arg_10_1._index == var_0_1.TAB.rare_shop then
		arg_10_0._shopArea = require("RareShopArea").create(lc.w(arg_10_0._list) - 100, lc.h(arg_10_0._list) + 100)

		lc.addChildToPos(arg_10_0, arg_10_0._shopArea, cc.p(lc.x(arg_10_0._list), lc.y(arg_10_0._list) - 20))
	elseif arg_10_1._index == var_0_1.TAB.diamond_shop then
		arg_10_0._shopArea = require("DiamondShopArea").create(lc.w(arg_10_0._list) - 100, lc.h(arg_10_0._list) + 100)

		lc.addChildToPos(arg_10_0, arg_10_0._shopArea, cc.p(lc.x(arg_10_0._list), lc.y(arg_10_0._list) - 20))
	elseif arg_10_1._index == var_0_1.TAB.new_shop then
		arg_10_0._shopArea = require("NewShopArea").create(lc.w(arg_10_0._list) - 100, lc.h(arg_10_0._list) + 100)

		lc.addChildToPos(arg_10_0, arg_10_0._shopArea, cc.p(lc.x(arg_10_0._list), lc.y(arg_10_0._list) - 20))
	elseif arg_10_1._index == var_0_1.TAB.badge_shop then
		arg_10_0._shopArea = require("BadgeShopArea").create(lc.w(arg_10_0._list) - 100, lc.h(arg_10_0._list) + 100)

		lc.addChildToPos(arg_10_0, arg_10_0._shopArea, cc.p(lc.x(arg_10_0._list), lc.y(arg_10_0._list) - 20))
	elseif arg_10_1._index == var_0_1.TAB.month_card5_shop then
		arg_10_0._shopArea = require("MonthCard5ShopArea").create(lc.w(arg_10_0._list) - 100, lc.h(arg_10_0._list) + 100)

		lc.addChildToPos(arg_10_0, arg_10_0._shopArea, cc.p(lc.x(arg_10_0._list), lc.y(arg_10_0._list) - 20))
	elseif arg_10_1._index == var_0_1.TAB.vote_shop then
		arg_10_0._shopArea = require("VoteShopArea").create(lc.w(arg_10_0._list) - 100, lc.h(arg_10_0._list))

		lc.addChildToPos(arg_10_0, arg_10_0._shopArea, cc.p(lc.x(arg_10_0._list), lc.y(arg_10_0._list) - 20))
	elseif arg_10_1._index == var_0_1.TAB.vote_recovery then
		arg_10_0._shopArea = require("RecoveryShopArea").create(lc.w(arg_10_0._list) - 100, lc.h(arg_10_0._list))

		lc.addChildToPos(arg_10_0, arg_10_0._shopArea, cc.p(lc.x(arg_10_0._list), lc.y(arg_10_0._list) - 20))
	end

	arg_10_0:setResourcePanel()
end

function var_0_1.setResourcePanel(arg_19_0)
	local var_19_0 = ClientView.getResourceUI()

	var_19_0:setMode(Data.ResType.gold)

	if arg_19_0._detailData then
		local var_19_1 = arg_19_0._detailData[1]

		if #var_19_1._showRes > 1 then
			var_19_0:setMode(nil, nil, var_19_1._showRes)

			return
		end

		local var_19_2 = var_19_1._param[6]
		local var_19_3 = var_19_1._param[7]

		if var_19_2 and var_19_2 ~= 0 and var_19_3 and var_19_3 ~= 0 and P._propBag:hasProps(var_19_2, var_19_3) then
			var_19_0:setMode(var_19_2)

			return
		end
	end

	local var_19_4 = arg_19_0._tabArea._focusedTab

	if var_19_4._index == var_0_1.TAB.god_pump then
		var_19_0:setMode(Data.PropsId.common_fragment)
	elseif var_19_4._index == var_0_1.TAB.time_limit then
		var_19_0:setMode(Data.PropsId.time_role_package_ticket)
	elseif var_19_4._index == var_0_1.TAB.diamond_shop then
		var_19_0:setMode(Data.PropsId.times_package_ticket)
	elseif var_19_4._index == var_0_1.TAB.new_shop then
		var_19_0:setMode(Data.PropsId.new_token)
	elseif var_19_4._index == var_0_1.TAB.vote_shop then
		var_19_0:setMode(Data.PropsId.vote_shop_token, 1)
	elseif var_19_4._index == var_0_1.TAB.collect then
		var_19_0:setMode(Data.PropsId.collect_shop_token, 1)
	elseif var_19_4._index == var_0_1.TAB.skill_shop or var_19_4._index == var_0_1.TAB.badge_shop then
		var_19_0:setMode(Data.PropsId.skill_item_token, 1)
	elseif var_19_4._index == var_0_1.TAB.month_card5_shop then
		var_19_0:setMode(Data.PropsId.month_card5_token)
	elseif var_19_4._index == var_0_1.TAB.critical_card then
		if P:getItemCount(Data.PropsId.critical_package_ticket) > 0 then
			var_19_0:setMode(Data.PropsId.critical_package_ticket, 1)
		else
			var_19_0:setMode(Data.PropsId.time_role_package_ticket, 1)
		end
	elseif arg_19_0._detailPanel and var_19_4._index == var_0_1.TAB.clash then
		var_19_0:setMode(arg_19_0._detailPanel._btns[1]._resType)
	end
end

function var_0_1.onEnter(arg_20_0)
	var_0_1.super.onEnter(arg_20_0)
	arg_20_0:setResourcePanel()

	arg_20_0._tokenListener = lc.addEventListener(Data.Event.prop_dirty, function(arg_21_0)
		if arg_21_0._data == P._propBag._props[Data.PropsId.dust_monster] or arg_21_0._data == P._propBag._props[Data.PropsId.dust_magic] or arg_21_0._data == P._propBag._props[Data.PropsId.dust_rare] or arg_21_0._data == P._propBag._props[Data.PropsId.common_fragment] or arg_21_0._data == P._propBag._props[Data.PropsId.miracle_indicator] or arg_21_0._data == P._propBag._props[Data.PropsId.character_package_dust] or arg_21_0._data == P._propBag._props[Data.PropsId.special_common_fragment] or arg_21_0._data == P._propBag._props[Data.PropsId.select_recruite_token] or arg_21_0._data == P._propBag._props[Data.PropsId.rare_package_dust] then
			arg_20_0:updateCardBox()
		end
	end)
	arg_20_0._ingotListener = lc.addEventListener(Data.Event.ingot_dirty, function(arg_22_0)
		arg_20_0:updateCardBox()
	end)
	arg_20_0._goldListener = lc.addEventListener(Data.Event.gold_dirty, function(arg_23_0)
		arg_20_0:updateCardBox()
	end)
	arg_20_0._fragmentListener = lc.addEventListener(Data.Event.fragment_dirty, function(arg_24_0)
		arg_20_0:updateCardBox()
	end)
	arg_20_0._rareGiftListener = lc.addEventListener(Data.Event.rare_gift_dirty, function(arg_25_0)
		arg_20_0:updateCardBox()
	end)

	arg_20_0:syncData()
end

function var_0_1.onExit(arg_26_0)
	var_0_1.super.onExit(arg_26_0)
	lc.Dispatcher:removeEventListener(arg_26_0._tokenListener)
	lc.Dispatcher:removeEventListener(arg_26_0._ingotListener)
	lc.Dispatcher:removeEventListener(arg_26_0._goldListener)
	lc.Dispatcher:removeEventListener(arg_26_0._fragmentListener)
	lc.Dispatcher:removeEventListener(arg_26_0._rareGiftListener)
	arg_26_0:unscheduleUpdate()
end

function var_0_1.onCleanup(arg_27_0)
	var_0_1.super.onCleanup(arg_27_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/tavern_item_bg.jpg"))

	for iter_27_0 = 1, #arg_27_0._recruitItems do
		arg_27_0:removeTexureByCheckInfo(arg_27_0._recruitItems[iter_27_0]._checkInfo)
	end

	ClientData.unloadLCRes(arg_27_0._resNames)
end

function var_0_1.syncData(arg_28_0)
	var_0_1.super.syncData(arg_28_0)
	arg_28_0:updateCardBox()
end

function var_0_1.createRecruitItem(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_2[1]

	if arg_29_1 then
		arg_29_0:removeTexureByCheckInfo(arg_29_1._checkInfo)
		arg_29_1:removeAllChildren()
	else
		arg_29_1 = ccui.Layout:create()

		arg_29_1:setContentSize(cc.size(var_0_4, 690))
		arg_29_1:setAnchorPoint(0.5, 0.5)
	end

	local var_29_1 = type(var_29_0) ~= "table"

	arg_29_1._checkInfo = var_29_0

	local var_29_2

	if var_29_1 then
		var_29_2 = ClientView.createExchangeCardPackage(var_29_0)
	else
		var_29_2 = ClientView.createCardPackage(var_29_0)
	end

	local var_29_3 = ClientView.createShaderButton(nil, function(arg_30_0)
		arg_29_0:sendShowDetail(arg_29_2)
	end)

	var_29_3:setContentSize(var_29_2:getContentSize())
	var_29_3:setZoomScale(0.02)
	lc.addChildToCenter(var_29_3, var_29_2)

	if var_29_1 then
		function var_29_3._callback()
			require("ExchangePackagePanel").create(arg_29_2):show()
		end
	end

	lc.addChildToCenter(arg_29_1, var_29_3)

	local var_29_4
	local var_29_5

	if not var_29_1 then
		var_29_4, var_29_5 = arg_29_0:isLocked(var_29_0)
	else
		var_29_4 = false
	end

	if var_29_4 then
		var_29_2:setGray()

		local var_29_6 = lc.createSprite("img_com_bg_45")

		lc.addChildToPos(var_29_2, var_29_6, cc.p(lc.cw(var_29_2), lc.ch(var_29_2) + 30))

		local var_29_7 = ClientView.createBoldRichTextMultiLine(var_29_5, ClientView.RICHTEXT_PARAM_LIGHT_S2)

		lc.addChildToCenter(var_29_6, var_29_7)
	end

	if not var_29_1 and Data.getIsTimeLimitRecruite(var_29_0) then
		local var_29_8 = var_29_0._param[9]

		if Data.getIsTimeLimitRoleRecruite(var_29_0) and var_29_8 ~= 99 then
			local var_29_9 = Data._characterInfo[var_29_8]

			if var_29_9 and var_29_9._visibleLevel <= 0 and P:isNewBie(var_29_0) then
				local var_29_10 = ClientView.createBMFont(ClientView.BMFont.huali_26, string.format(Str(STR.NEWBIE_PACKAGE_TIP), var_29_0._param[3]))

				lc.addChildToPos(var_29_2, var_29_10, cc.p(lc.cw(var_29_2), 158))
			end
		elseif not Data.getIsTimeLimitFestivalRecruite(var_29_0) and not Data.getIsTimeLimitCriticalRecruite(var_29_0) and not Data.getIsTimeLimitSelectRecruite(var_29_0) then
			local var_29_11 = ClientData.getValidActivityByParam(var_29_0._value - 200000, true)

			if var_29_11 then
				local var_29_12 = ClientView.createBMFont(ClientView.BMFont.huali_26, ClientData.getActivityDurationStr(var_29_11))

				lc.addChildToPos(var_29_2, var_29_12, cc.p(lc.cw(var_29_2), 158))
			end
		end
	end

	return arg_29_1
end

function var_0_1.createCostArea(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	local var_32_0 = arg_32_5 and var_0_5 or var_0_4
	local var_32_1 = "img_blank"
	local var_32_2 = arg_32_1._param[2]
	local var_32_3 = arg_32_1._param[6]
	local var_32_4 = arg_32_1._param[7]
	local var_32_5 = arg_32_3._param[2] * (arg_32_3._param[1] == 3 and 10 or 1) / (arg_32_3._value % 100)
	local var_32_6 = arg_32_2 == 1 and "img_btn_2" or arg_32_2 == 10 and "img_btn_1" or "img_btn_3"

	var_32_6 = arg_32_4 and var_32_6 .. "_s" or var_32_6

	local var_32_7 = ClientView.createResConsumeButton(var_32_0, var_0_6, var_32_1, "999999", string.format(Str(Data.getIsClashRecruite(arg_32_1) and STR.RECRUIT_MULTIPLE_2 or STR.RECRUIT_MULTIPLE), arg_32_2), var_32_6)

	var_32_7:setDisabledShader(ClientView.SHADER_DISABLE)

	var_32_7._isCostArea = true

	if arg_32_5 then
		var_32_7._label:setPosition(cc.p(lc.cw(var_32_7), lc.ch(var_32_7) + 12))
		var_32_7._resArea:setPosition(cc.p(lc.cw(var_32_7), lc.ch(var_32_7) - 14))
		var_32_7._resArea:setVisible(true)
		var_32_7._resArea:setOpacity(0)
		var_32_7._resArea:setCascadeOpacityEnabled(false)
	else
		lc.offset(var_32_7._resArea, 6, 0)
		var_32_7._resArea:setVisible(true)
		var_32_7._resArea:setOpacity(0)
		var_32_7._resArea:setCascadeOpacityEnabled(false)
	end

	function var_32_7.update(arg_33_0)
		local var_33_0
		local var_33_1 = arg_32_1._param[2]
		local var_33_2 = arg_32_1._param[6]
		local var_33_3 = arg_32_1._param[7]
		local var_33_4 = arg_32_1._param[1]
		local var_33_5 = P:getItemCount(var_33_4)

		if var_33_2 and var_33_2 ~= 0 and var_33_3 and var_33_3 ~= 0 and P._propBag:hasProps(var_33_2, var_33_3) then
			var_33_4 = var_33_2
			var_33_1 = var_33_3
		elseif Data.getIsRareRecruite(arg_32_1) and arg_32_1._param[1] == Data.ResType.gold and P._propBag:hasProps(Data.PropsId.rare_package_ticket, arg_32_2) then
			var_33_4 = Data.PropsId.rare_package_ticket
			var_33_1 = arg_32_2
		elseif Data.getIsCharacterRecruite(arg_32_1) and P._propBag:hasProps(Data.PropsId.character_package_ticket, arg_32_2) then
			var_33_4 = Data.PropsId.character_package_ticket
			var_33_1 = arg_32_2
		elseif Data.getIsTimeLimitCriticalRecruite(arg_32_1) and arg_32_1._param[1] == Data.ResType.ingot and P._propBag:hasProps(Data.PropsId.critical_package_ticket, arg_32_2) then
			var_33_4 = Data.PropsId.critical_package_ticket
			var_33_1 = arg_32_2
		elseif Data.getIsTimeLimitFestivalRecruite(arg_32_1) and arg_32_1._param[1] == Data.ResType.gold and P._propBag:hasProps(Data.PropsId.festival_package_ticket, arg_32_2) then
			var_33_4 = Data.PropsId.festival_package_ticket
			var_33_1 = arg_32_2
		elseif arg_32_1._param[1] == Data.ResType.ingot and arg_32_1._param[2] == 1800 and P._propBag:hasProps(Data.PropsId.time_role_package_ticket, 1) then
			var_33_4 = Data.PropsId.time_role_package_ticket
			var_33_1 = 1
		end

		local var_33_6 = ClientData.getIconName(var_33_4, false)

		arg_33_0._resType = var_33_4
		arg_33_0._resNeed = var_33_1

		local var_33_7 = arg_33_0._resLabel

		var_33_7:setString(string.format("%d", arg_33_0._resNeed))
		arg_33_0._resArea._ico:setSpriteFrame(var_33_6)
		var_33_7:setColor(P:getItemCount(var_33_4) < arg_33_0._resNeed and ClientView.COLOR_TEXT_RED_DARK or ClientView.COLOR_TEXT_WHITE)

		arg_33_0._resArea:setVisible(true)
		arg_33_0._resArea:setCascadeOpacityEnabled(false)
		local ico = arg_33_0._resArea._ico
		local lbl = var_33_7
		if ico and lbl then
			ico:setVisible(true)
			ico:setOpacity(255)
			lbl:setVisible(true)
			lbl:setOpacity(255)
			local icoW = (ico.getContentSize and ico:getContentSize().width) or 26
			local lblW = (lbl.getContentSize and lbl:getContentSize().width) or 40
			local gap = 4
			local totalW = icoW + gap + lblW
			local startX = (lc.w(arg_33_0._resArea) - totalW) / 2
			ico:setPosition(startX + icoW / 2, lc.h(arg_33_0._resArea) / 2)
			lbl:setPosition(startX + icoW + gap + lblW / 2, lc.h(arg_33_0._resArea) / 2)
		end

		if arg_33_0._discount then
			arg_33_0._discount:removeFromParent()

			arg_33_0._discount = nil
		end

		if arg_33_0._resType == arg_32_1._param[1] and arg_32_1._value ~= arg_32_3._value then
			local var_33_8 = 10 * arg_32_1._param[2] * (arg_32_1._param[1] == 3 and 10 or 1) / (arg_32_2 * var_32_5)
			local var_33_9 = cc.Sprite:createWithSpriteFrameName("img_hl_bg")

			var_33_9:setRotation(-10)
			var_33_9:setScale(0.8)
			lc.addChildToPos(arg_33_0, var_33_9, cc.p(lc.w(arg_33_0) - 10, lc.h(arg_33_0) - 6))

			arg_33_0._discount = var_33_9

			local var_33_10

			if var_33_8 > math.floor(var_33_8) then
				var_33_10 = string.format("%.1f%s", var_33_8, Str(STR.DISCOUNT))
			else
				var_33_10 = string.format("%d%s", var_33_8, Str(STR.DISCOUNT))
			end

			local var_33_11 = ClientView.createBMFont(ClientView.BMFont.huali_20, var_33_10)

			var_33_11:setColor(ClientView.COLOR_TEXT_RED)
			lc.addChildToPos(var_33_9, var_33_11, cc.p(lc.w(var_33_9) / 2, lc.h(var_33_9) / 2 + 4))

			if var_33_8 >= 10 then
				var_33_9:setVisible(false)
			end
		end
	end

	var_32_7:update()

	return var_32_7
end

function var_0_1.onMsg(arg_34_0, arg_34_1)
	if var_0_1.super.onMsg(arg_34_0, arg_34_1) then
		return true
	end

	local var_34_0 = arg_34_1.type
	local var_34_1 = arg_34_1.status

	if var_34_0 == SglMsgType_pb.PB_TYPE_CARD_LOTTERY then
		if not arg_34_0._detailData then
			return false
		end

		local var_34_2 = arg_34_0._detailData[1]

		ClientView.getActiveIndicator():hide()

		local var_34_3 = arg_34_1.Extensions[Card_pb.SglCardMsg.card_lottery_resp]

		if Data.getIsGodPumpRecruite(var_34_2) then
			local var_34_4 = {}

			for iter_34_0, iter_34_1 in ipairs(var_34_3) do
				table.insert(var_34_4, {
					_level = 1,
					_isFragment = false,
					_infoId = iter_34_1.info_id,
					_count = iter_34_1.num
				})
			end

			require("RewardPanel").create(var_34_3):show(require("RewardPanel").MODE_LOTTERY)

			return true
		end

		local var_34_5 = {}
		local var_34_6 = {}
		local var_34_7 = {}

		for iter_34_2 = 1, #var_34_3 do
			local var_34_8 = var_34_3[iter_34_2]
			local var_34_9 = Data.getType(var_34_8.info_id)

			if var_34_9 >= Data.CardType.monster and var_34_9 <= Data.CardType.rare then
				if P._playerCard:addCard(var_34_8.info_id, var_34_8.num) then
					var_34_7[var_34_9] = true
				end

				var_34_6[#var_34_6 + 1] = {
					_infoId = var_34_8.info_id,
					_num = var_34_8.num
				}

				arg_34_0:removeCardFromPackage(var_34_8.info_id, var_34_8.num)
			else
				var_34_5[#var_34_5 + 1] = {
					_infoId = var_34_8.info_id,
					_num = var_34_8.num
				}
			end
		end

		for iter_34_3 in pairs(var_34_7) do
			P._playerCard:sendCardListDirty(iter_34_3)
		end

		local var_34_10 = cc.EventCustom:new(Data.Event.hero_lottery)

		var_34_10._times = type == RECRUIT_LEGEND and 1 or #var_34_6

		lc.Dispatcher:dispatchEvent(var_34_10)
		arg_34_0:updateCardBox()

		local var_34_11

		for iter_34_4, iter_34_5 in ipairs(var_34_5) do
			local var_34_12 = string.format(Str(STR.GOT_VOID_DIAMOND), iter_34_5._num, Str(Data._propsInfo[iter_34_5._infoId]._nameSid))

			var_34_11 = var_34_11 and var_34_11 .. Str(STR.AND_2) .. var_34_12 or Str(STR.GET) .. var_34_12

			P._propBag:changeProps(iter_34_5._infoId, iter_34_5._num)
		end

		if var_34_11 then
			ToastManager.push(var_34_11)
		end

		local var_34_13 = require("CardPackagePanel").Mode.open_one

		require("CardPackagePanel").create(var_34_13, var_34_6, arg_34_0._curRecruitInfo, var_34_2):show()

		local var_34_14 = GuideManager.getCurStepName()

		if string.find(var_34_14, "buy once") then
			GuideManager._finger:setVisible(false)
			GuideManager.finishStepLater(0.8)
		end

		return true
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_CARDBOX_INFO or var_34_0 == SglMsgType_pb.PB_TYPE_RESET_CARDBOX then
		if not arg_34_0._detailData then
			return false
		end

		local var_34_15 = arg_34_0._detailData[1]
		local var_34_16 = arg_34_1.Extensions[Card_pb.SglCardMsg.card_box_info_resp]

		arg_34_0._packageCards = {}

		for iter_34_6 = 1, #var_34_16 do
			if Data.getIsTimeLimitCriticalRecruite(var_34_15) or Data.getIsRareRecruite(var_34_15) then
				local var_34_17 = Data.getInfo(var_34_16[iter_34_6].info_id)._maxCount
				local var_34_18 = math.min(var_34_17, P._playerCard:getCardCount(var_34_16[iter_34_6].info_id))
				local var_34_19 = var_34_17 - var_34_18

				arg_34_0._packageCards[iter_34_6] = {
					_infoId = var_34_16[iter_34_6].info_id,
					_getNum = var_34_18,
					_remainNum = var_34_19
				}
			else
				arg_34_0._packageCards[iter_34_6] = {
					_infoId = var_34_16[iter_34_6].info_id,
					_getNum = var_34_16[iter_34_6].get_num,
					_remainNum = var_34_16[iter_34_6].remain_num
				}
			end
		end

		if arg_34_1:HasExtension(Card_pb.SglCardMsg.remain_pkg_ur_resp) then
			arg_34_0._remainUrCount = arg_34_1.Extensions[Card_pb.SglCardMsg.remain_pkg_ur_resp]
		else
			arg_34_0._remainUrCount = nil
		end

		local var_34_20 = arg_34_1.Extensions[Card_pb.SglCardMsg.up_pkg_card_id_resp]

		arg_34_0._selectedCard = var_34_20.card_id
		arg_34_0._selectedTime = var_34_20.timestamp / 1000

		ClientView.getActiveIndicator():hide()
		arg_34_0:showCardBox()

		local var_34_21 = GuideManager.getCurStepName()

		if string.find(var_34_21, "buy package") then
			GuideManager._finger:setVisible(false)
			GuideManager.finishStepLater(0.8)
		end

		local var_34_22 = arg_34_1.Extensions[Card_pb.SglCardMsg.rare_pkg_resource_resp]

		if #var_34_22 > 0 then
			local var_34_23 = math.floor(var_34_15._value / 1000) % 100
			local var_34_24 = Data.PurchaseType.rare_gift_1 + var_34_23 - 1

			if not arg_34_0._rareGiftRewards then
				arg_34_0._rareGiftRewards = {}
			end

			local var_34_25 = {}

			arg_34_0._rareGiftRewards[var_34_24] = var_34_25

			for iter_34_7, iter_34_8 in ipairs(var_34_22) do
				var_34_25[#var_34_25 + 1] = Data.pb2Resource(iter_34_8)
			end

			local function var_34_26(arg_35_0)
				for iter_35_0, iter_35_1 in ipairs(arg_34_0._packageCards) do
					if iter_35_1._infoId == arg_35_0 then
						return iter_35_0
					end
				end

				return 1000
			end

			table.sort(var_34_25, function(arg_36_0, arg_36_1)
				local var_36_0 = var_34_26(arg_36_0._infoId)
				local var_36_1 = var_34_26(arg_36_1._infoId)

				if arg_36_0._infoId == Data.PropsId.rare_package_ticket then
					return true
				end

				if arg_36_1._infoId == Data.PropsId.rare_package_ticket then
					return false
				end

				return var_36_0 < var_36_1
			end)
		end
	elseif var_34_0 == SglMsgType_pb.PB_TYPE_CARD_UP_PKG_CARD then
		local var_34_27 = ClientView.getActiveIndicator()

		arg_34_0._selectedCard = var_34_27._userData
		arg_34_0._selectedTime = ClientData.getCurrentTime()

		var_34_27:hide()

		if arg_34_0:isSelectRecruite() then
			P:addResource(Data.PropsId.select_recruite_token, 1, -1)
		end

		arg_34_0:updateSelecedCard()
	end

	return false
end

function var_0_1.afterOpenPackage(arg_37_0, arg_37_1)
	GuideManager.finishStep()

	local var_37_0 = arg_37_0._detailData
	local var_37_1 = var_37_0[1]

	if var_37_1._type == 1001 or var_37_1._type == 1012 or var_37_1._type == 1017 then
		if arg_37_0._remainUrCount <= 0 then
			arg_37_0:sendShowDetail(var_37_0)
		else
			for iter_37_0 = 1, #arg_37_1 do
				local var_37_2 = arg_37_1[iter_37_0]

				if Data.getInfo(var_37_2._infoId)._quality == Data.CardQuality.UR then
					arg_37_0:sendShowDetail(var_37_0)

					break
				end
			end
		end
	elseif Data.getIsCharacterRecruite(var_37_1) then
		local var_37_3, var_37_4, var_37_5 = arg_37_0:getPackageInfo()

		if var_37_5 <= 0 then
			arg_37_0:sendShowDetail(var_37_0)
		end
	elseif var_37_1._type == 1018 or Data.getIsClashRecruite(var_37_1) or Data.getIsCollectionRecruite(var_37_1) then
		arg_37_0:sendShowDetail(var_37_0)
	end
end

function var_0_1.addRecruitEffects(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1:getParent():convertToWorldSpace(cc.p(lc.x(arg_38_1), lc.top(arg_38_1) - 120))

	if false then
		local var_38_1 = Particle.create("par_lottery2")
		local var_38_2 = Particle.create("par_lottery3")

		var_38_1:setPosition(var_38_0)
		var_38_2:setPosition(var_38_0)
		arg_38_0._scene:addChild(var_38_1, ClientData.ZOrder.effect)
		arg_38_0._scene:addChild(var_38_2, ClientData.ZOrder.effect)
	else
		local var_38_3 = Particle.create("par_lottery1")

		var_38_3:setPosition(var_38_0)
		arg_38_0._scene:addChild(var_38_3, ClientData.ZOrder.effect)
	end
end

function var_0_1.onGuide(arg_39_0, arg_39_1)
	local var_39_0 = GuideManager.getCurStepName()

	if arg_39_0._tabArea._focusedTab._index ~= var_0_1.TAB.rare_draw_card then
		arg_39_0._tabArea:showTab(var_0_1.TAB.rare_draw_card)
	end

	if string.sub(var_39_0, 1, 11) == "buy package" then
		local var_39_1 = arg_39_0._recruitItems[1]

		arg_39_0._list:forceDoLayout()
		GuideManager.setOperateLayer(var_39_1)
	elseif string.sub(var_39_0, 1, 8) == "buy once" then
		local var_39_2 = arg_39_0._detailPanel._btns[1]

		GuideManager.setOperateLayer(var_39_2)
	elseif var_39_0 == "leave tavern" then
		GuideManager.setOperateLayer(arg_39_0._titleArea._btnBack)
	else
		return
	end

	arg_39_1:stopPropagation()
end

function var_0_1.isGuideRarePackage(arg_40_0)
	return P._guideID < 154
end

function var_0_1.sendShowDetail(arg_41_0, arg_41_1)
	arg_41_0._detailData = arg_41_1

	local var_41_0 = arg_41_1[1]

	if Data.getIsTimeLimitSelectRecruite(var_41_0) or Data.getIsTimeLimitFestivalRecruite(var_41_0) then
		var_41_0 = arg_41_1[3]
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendCardBoxInfo(var_41_0._value)
end

function var_0_1.sendBuyPackage(arg_42_0, arg_42_1, arg_42_2)
	lc.Audio.playAudio(AUDIO.E_TAVERN_BUY_PACKAGE)

	arg_42_0._curRecruitInfo = arg_42_2

	if arg_42_0._remainUrCount then
		arg_42_0._remainUrCount = arg_42_0._remainUrCount - arg_42_2._value % 100
	end

	local var_42_0 = arg_42_1._resType
	local var_42_1 = arg_42_1._resNeed

	if var_42_1 > P:getItemCount(var_42_0) then
		return ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(var_42_0)))
	end

	ClientView.getActiveIndicator():show(Str(STR.RECRUITING), var_0_3)
	ClientData.sendCardLottery(arg_42_2._value, false, var_42_0)
	P:addResource(var_42_0, 0, -var_42_1)
end

function var_0_1.sendResetBox(arg_43_0, arg_43_1)
	ClientView.getActiveIndicator():show(Str(STR.RECRUITING), var_0_3)
	ClientData.sendCardBoxReset(arg_43_1._value, false)
end

function var_0_1.showCardBox(arg_44_0)
	local var_44_0 = arg_44_0._detailData
	local var_44_1 = var_44_0[1]

	if Data.getIsGodPumpRecruite(var_44_1) then
		return arg_44_0:showGodPumpBox()
	end

	arg_44_0._tabArea:setVisible(false)

	if arg_44_0._detailPanel then
		return arg_44_0:updateCardBox()
	end

	arg_44_0._list:setVisible(false)

	local var_44_2 = cc.Node:create()

	var_44_2:setContentSize(ClientView.SCR_SIZE)
	var_44_2:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToCenter(arg_44_0, var_44_2, 1)

	arg_44_0._detailPanel = var_44_2

	local var_44_3 = ClientView.createCardPackage(var_44_1)

	lc.addChildToPos(arg_44_0, var_44_3, cc.p(lc.cw(var_44_3) + ClientView.SCR_EDGE, lc.ch(var_44_2) - 30), 101)

	arg_44_0._detailPanel._package = var_44_3

	local var_44_4, var_44_5 = arg_44_0:isLocked(var_44_1)
	local var_44_6 = Data.getIsRareRecruite(var_44_1) or Data.getIsCharacterRecruite(var_44_1) or Data.getIsTimeLimitCriticalRecruite(var_44_1) or Data.getIsClashRecruite(var_44_1)

	arg_44_0:initCardList(var_44_2, require("CardList").ModeType[var_44_6 and "recruite" or "recruite_langend"])

	local var_44_7 = lc.createSprite({
		_name = var_44_6 and "img_com_bg_39" or "img_com_bg_40",
		_size = cc.size(ClientView.SCR_W - 240 - ClientView.SCR_EDGE, 66),
		_crect = cc.rect(4, 33, 1, 1)
	})

	lc.addChildToPos(var_44_2, var_44_7, cc.p(ClientView.SCR_W - lc.cw(var_44_7), 166))

	var_44_2._bg = var_44_7
	var_44_2._cardCounts = {}

	if not Data.getIsTimeLimitSelectRecruite(var_44_1) and not arg_44_0:isSelectRecruite() and not Data.getIsCollectionRecruite(var_44_1) then
		local var_44_8

		if Data.getIsCharacterRecruite(var_44_1) then
			var_44_8 = cc.size(80, 30)
		else
			var_44_8 = cc.size(40, 30)
		end

		local var_44_9 = {
			"img_icon_quality_n",
			"img_icon_quality_r",
			"img_icon_quality_sr",
			"img_icon_quality_ur"
		}

		for iter_44_0 = 1, 4 do
			local var_44_10 = cc.p((var_44_8.width + 54) * (4 - iter_44_0) + 50, lc.ch(var_44_7) - 4)
			local var_44_11 = lc.createSprite(var_44_9[iter_44_0])

			lc.addChildToPos(var_44_7, var_44_11, var_44_10)

			local var_44_12 = lc.createSprite({
				_name = "img_com_bg_42",
				_crect = ClientView.CRECT_COM_BG42,
				_size = var_44_8
			})

			lc.addChildToPos(var_44_11, var_44_12, cc.p(lc.w(var_44_11) + lc.cw(var_44_12) - 4, lc.ch(var_44_11)), -1)

			local var_44_13 = ClientView.createTTF("100/100", ClientView.FontSize.S3)

			lc.addChildToPos(var_44_12, var_44_13, cc.p(lc.cw(var_44_12) - 2, lc.ch(var_44_12) + 2))

			var_44_2._cardCounts[iter_44_0] = var_44_13
		end
	end

	if Data.getIsTimeLimitSelectRecruite(var_44_1) or arg_44_0:isSelectRecruite() then
		local var_44_14 = string.format(Str(STR.PACKAGE_SELECT_CARD_TIP), 10)
		local var_44_15 = ClientView.createBoldRichTextMultiLine(var_44_14, ClientView.RICHTEXT_PARAM_LIGHT_S2)

		lc.addChildToPos(var_44_7, var_44_15, cc.p(lc.cw(var_44_15) + 50, lc.ch(var_44_7)), 2)

		var_44_2._buyTip2 = var_44_15

		local var_44_16 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_45_0)
			arg_44_0:onChangeUp()
		end, ClientView.CRECT_BUTTON_S, 150)

		var_44_16:addLabel(Str(STR.SELECT))
		lc.addChildToPos(var_44_7, var_44_16, cc.p(lc.right(var_44_15) + lc.cw(var_44_16), lc.y(var_44_15)))

		var_44_2._btnChange = var_44_16

		if arg_44_0:isSelectRecruite() then
			local var_44_17 = ClientView.createBoldRichTextMultiLine(Str(STR.PACKAGE_SELECT_CARD_TIP_2), ClientView.RICHTEXT_PARAM_LIGHT_S2)

			lc.addChildToPos(var_44_7, var_44_17, cc.p(lc.right(var_44_2._btnChange) + 10 + lc.cw(var_44_17), lc.ch(var_44_7)), 2)

			var_44_2._buyTip3 = var_44_17

			local var_44_18 = Data.PropsId.select_recruite_token
			local var_44_19 = ClientView.createItemCountArea(var_44_18, ClientData.getIconName(var_44_18), 150, P:getItemCount(var_44_18))

			lc.addChildToPos(var_44_7, var_44_19, cc.p(lc.right(var_44_2._buyTip3) + 10 + lc.cw(var_44_19), lc.ch(var_44_7) + 5), 2)

			var_44_2._valueArea = var_44_19
		end

		function var_44_2.updateSelecedCard()
			if arg_44_0._selectedCard and arg_44_0._selectedCard ~= 0 then
				if not var_44_2._cardIcon then
					local var_46_0 = IconWidget.create({
						_infoId = arg_44_0._selectedCard
					}, IconWidget.DisplayFlag.ITEM_NO_NAME)

					var_46_0:setScale(0.7)
					lc.addChildToPos(var_44_7, var_46_0, cc.p(lc.right(var_44_15) + lc.cw(var_46_0), lc.y(var_44_15)))

					var_44_2._cardIcon = var_46_0

					var_44_2._btnChange:setPosition(cc.p(lc.right(var_46_0) + lc.cw(var_44_16) + 10, lc.y(var_46_0)))

					if arg_44_0:isSelectRecruite() then
						var_44_2._buyTip3:setPosition(cc.p(lc.right(var_44_2._btnChange) + 50 + lc.cw(var_44_2._buyTip3), lc.ch(var_44_7)))
						var_44_2._valueArea:setPosition(cc.p(lc.right(var_44_2._buyTip3) + 50 + lc.cw(var_44_2._valueArea), lc.ch(var_44_7)))
					end
				else
					var_44_2._cardIcon:resetData({
						_infoId = arg_44_0._selectedCard
					})
				end
			elseif var_44_2._cardIcon then
				arg_44_0._detailPanel._package:removeFromParent()

				arg_44_0._detailPanel._package = nil

				arg_44_0._detailPanel:removeFromParent()

				arg_44_0._detailPanel = nil

				arg_44_0:showCardBox()
			end
		end
	elseif Data.getIsCharacterRecruite(var_44_1) then
		local var_44_20 = ClientView.createTTF(Str(STR.REMIAN_CARD_PACKAGE), ClientView.FontSize.S3)

		lc.addChildToPos(var_44_7, var_44_20, cc.p(lc.w(var_44_7) - 180 - ClientView.SCR_EDGE, lc.ch(var_44_7) + 16))

		local var_44_21 = lc.createSprite({
			_name = "img_com_bg_42",
			_crect = ClientView.CRECT_COM_BG42,
			_size = cc.size(80, 30)
		})

		lc.addChildToPos(var_44_7, var_44_21, cc.p(lc.x(var_44_20), lc.ch(var_44_7) - 14))

		local var_44_22 = ClientView.createTTF("200", ClientView.FontSize.S2)

		lc.addChildToPos(var_44_21, var_44_22, cc.p(lc.cw(var_44_21) - 2, lc.ch(var_44_21) + 2))

		var_44_2._packageCount = var_44_22

		local var_44_23 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_47_0)
			if var_44_4 then
				ToastManager.push(var_44_5)
			else
				require("Dialog").showDialog(Str(STR.CONFIRM_RESET_PACKAGES), function()
					arg_44_0:sendResetBox(var_44_1)
				end, false)
			end
		end, ClientView.CRECT_BUTTON_S, 90)

		lc.addChildToPos(var_44_7, var_44_23, cc.p(lc.w(var_44_7) - 70 - ClientView.SCR_EDGE, lc.ch(var_44_7)))
		var_44_23:setScale(0.8)
		var_44_23:addLabel(Str(STR.RESET))

		local var_44_24 = ClientView.createTTF(Str(STR.TAVERN_TIP), ClientView.FontSize.S3)

		lc.addChildToPos(var_44_7, var_44_24, cc.p(lc.cw(var_44_24) + 26, -2))
	else
		if Data.getIsCollectionRecruite(var_44_1) then
			local var_44_25 = string.format(Str(STR.PACKAGE_COLLECT_CARD_TIP), 10)
			local var_44_26 = ClientView.createBoldRichTextMultiLine(var_44_25, ClientView.RICHTEXT_PARAM_LIGHT_S2)

			lc.addChildToPos(var_44_7, var_44_26, cc.p(lc.cw(var_44_7) - 200, lc.ch(var_44_7)), 2)

			var_44_2._buyTip2 = var_44_26

			local var_44_27 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_49_0)
				arg_44_0:onBuy()
			end, ClientView.CRECT_BUTTON_S, 150)

			var_44_27:addLabel(Str(STR.BUY))
			lc.addChildToPos(var_44_7, var_44_27, cc.p(lc.right(var_44_26) + lc.cw(var_44_27), lc.y(var_44_26)))

			var_44_2._btnBuy = var_44_27
		end

		if not Data.getIsTimeLimitCriticalRecruite(var_44_1) and not Data.getIsClashRecruite(var_44_1) then
			local var_44_28 = string.format(Str(STR.RECRUIT_MORE_TIP), 10)
			local var_44_29 = ClientView.createBoldRichTextMultiLine(var_44_28, ClientView.RICHTEXT_PARAM_LIGHT_S2)

			lc.addChildToPos(var_44_7, var_44_29, cc.p(lc.w(var_44_7) - 240 - ClientView.SCR_EDGE, lc.ch(var_44_7)), 2)

			var_44_2._buyTip = var_44_29

			local var_44_30 = lc.createSprite({
				_name = "img_com_bg_42",
				_size = cc.size(lc.w(var_44_29) + 20, 44),
				_crect = ClientView.CRECT_COM_BG42
			})

			lc.addChildToPos(var_44_7, var_44_30, cc.p(lc.x(var_44_29), lc.y(var_44_29) - 2))

			if var_44_1._isHide == 1 then
				var_44_29:setVisible(false)
				var_44_30:setVisible(false)
			end
		end

		print("++++++++++++++++++++#self._packageCards", #arg_44_0._packageCards)

		local var_44_31 = {}

		for iter_44_1 = 1, #arg_44_0._packageCards do
			local var_44_32 = arg_44_0._packageCards[iter_44_1]

			if Data.getInfo(var_44_32._infoId)._quality == Data.CardQuality.UR then
				table.insert(var_44_31, var_44_32._infoId)
			end
		end

		local var_44_33 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_50_0)
			require("ComposeForm").create(var_44_31, var_44_1._value):show()
		end, cc.rect(0, 0, 0, 0), 90, 60)

		var_44_33:addLabel(Str(STR.COMPOSE))
		lc.addChildToPos(var_44_7, var_44_33, cc.p(lc.w(var_44_7) - 70, lc.ch(var_44_7)))
		var_44_33:setVisible(false)

		if buyTip then
			lc.offset(buyTip, 120, 0)
			lc.offset(tipBg, 120, 0)
		end
	end

	local var_44_34 = Data.getIsRareRecruite(var_44_1) and var_44_1._param[8] and var_44_1._param[8] > 0
	local var_44_35 = false
	local var_44_36 = {}

	var_44_2._btns = var_44_36

	local var_44_37 = {}

	for iter_44_2, iter_44_3 in ipairs(var_44_0) do
		if iter_44_3._isHide ~= 1 then
			var_44_37[#var_44_37 + 1] = iter_44_3
		end
	end

	local var_44_38 = #var_44_37 > 3
	local var_44_39 = 26 - 20 * (1366 - ClientView.SCR_W) / 342

	if not var_44_34 then
		for iter_44_4 = 1, #var_44_37 do
			local var_44_40 = var_44_37[iter_44_4]
			local var_44_41 = math.max(1, var_44_40._value % 100)
			local var_44_42 = arg_44_0:createCostArea(var_44_40, var_44_41, var_44_1, var_44_35, var_44_38)

			var_44_36[#var_44_36 + 1] = var_44_42

			function var_44_42._callback(arg_51_0)
				if var_44_4 then
					ToastManager.push(var_44_5)
				else
					arg_44_0:sendBuyPackage(arg_51_0, var_44_40)
				end
			end
		end
	else
		local var_44_43 = #var_44_37 >= 3

		for iter_44_5 = 1, math.min(3, #var_44_37) do
			local var_44_44 = var_44_37[iter_44_5]
			local var_44_45 = math.max(1, var_44_44._value % 100)
			local var_44_46 = arg_44_0:createCostArea(var_44_44, var_44_45, var_44_1, var_44_35, var_44_43)

			var_44_36[#var_44_36 + 1] = var_44_46

			function var_44_46._callback(arg_52_0)
				if var_44_4 then
					ToastManager.push(var_44_5)
				else
					arg_44_0:sendBuyPackage(arg_52_0, var_44_44)
				end
			end
		end

		local var_44_47 = math.floor(var_44_1._value / 1000) % 100
		local var_44_48 = var_44_1._param[8]
		local var_44_49 = P._playerBonus._bonuses[var_44_48]._isClaimed
		local var_44_50 = Data.PurchaseType.rare_gift_1 + var_44_47 - 1

		ToastManager.push(ClientData.getProductTitle(var_44_50))

		local var_44_51 = ClientView.createShaderButton("btn_rare_gift", function()
			local var_53_0 = arg_44_0._rareGiftRewards[var_44_50]

			require("RareGiftForm").create(var_44_50, var_53_0):show()
		end)

		var_44_51:setDisabledShader(ClientView.SHADER_DISABLE)
		var_44_51:setEnabled(not var_44_49)

		local var_44_52 = lc.createSprite("activity_rmb_" .. ClientData.getPrice(var_44_50))

		lc.addChildToPos(var_44_51, var_44_52, cc.p(lc.cw(var_44_51), lc.h(var_44_51) + lc.ch(var_44_52)))

		var_44_2._rareGitBtn = var_44_51
		var_44_36[#var_44_36 + 1] = var_44_51
	end

	if #var_44_36 == 4 then
		var_44_39 = 40
	end

	lc.addNodesToCenter(var_44_2, var_44_36, var_44_39, 50, nil, nil, lc.x(arg_44_0._cardList))

	if Data.getIsTimeLimitFestivalRecruite(var_44_1) then
		local var_44_53 = lc.createNode()

		var_44_53:setScale(0.8)

		local var_44_54 = ClientView.createShaderButton("img_btn_wheel", function()
			lc.pushScene(require("LotteryPackageScene").create(var_44_1._value))
		end)

		lc.addChildToCenter(var_44_53, var_44_54)

		local var_44_55 = DragonBones.create("choujiang")

		lc.addChildToCenter(var_44_54, var_44_55)
		var_44_55:gotoAndPlay("effect1")
		lc.addChildToPos(var_44_2, var_44_53, cc.p(lc.w(var_44_2) - lc.cw(var_44_54) - 20, lc.ch(var_44_2) - 100))
	end

	if Data.getIsTimeLimitRoleRecruite(var_44_1) then
		var_44_36[1]:setPosition(var_44_36[2]:getPosition())
		var_44_36[2]:setVisible(false)
		var_44_36[3]:setVisible(false)
	end

	arg_44_0:updateCardBox()
	var_44_3:setPosition(cc.p(lc.x(var_44_3) + 100, lc.y(var_44_3)))
	var_44_3:runAction(lc.sequence(lc.moveBy(0.2, cc.p(-100, 0))))
	var_44_2:setVisible(false)
	var_44_2:setPosition(cc.p(ClientView.SCR_CW - 200, ClientView.SCR_CH))
	var_44_2:runAction(lc.sequence(lc.delay(0.2), lc.show(), lc.ease(lc.moveBy(0.3, cc.p(200, 0)), "BackO")))
	arg_44_0:setResourcePanel()
end

function var_0_1.showGodPumpBox(arg_55_0)
	local var_55_0 = arg_55_0._detailData
	local var_55_1 = var_55_0[1]

	if not Data.getIsGodPumpRecruite(var_55_1) then
		return
	end

	arg_55_0._tabArea:setVisible(false)
	arg_55_0._list:setVisible(false)

	if arg_55_0._detailPanel then
		return arg_55_0:updateGodPumpBox()
	end

	arg_55_0._bg:setTexture("res/jpg/god_pump_bg.jpg")

	local var_55_2 = ClientView.createLineSprite("img_bottom_bg", ClientView.SCR_W)

	lc.addChildToPos(arg_55_0, var_55_2, cc.p(ClientView.SCR_CW, lc.ch(var_55_2)))

	arg_55_0._bottomArea = var_55_2

	local var_55_3 = var_55_1._param[6] == 1
	local var_55_4 = var_55_1._param[7]

	if var_55_3 then
		local var_55_5 = ClientView.createTTF(Str(STR.EXTRA_RES_TIP), ClientView.FontSize.S2)
		local var_55_6 = ClientView.createItemCountArea(Data.PropsId.special_common_fragment, ClientData.getPropIconName(Data.PropsId.special_common_fragment), 200)

		lc.addNodesToCenter(var_55_2, {
			var_55_5,
			var_55_6
		}, 10, 40)

		arg_55_0._resArea = var_55_6
	end

	local var_55_7 = cc.Node:create()

	var_55_7:setContentSize(ClientView.SCR_SIZE)
	var_55_7:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToCenter(arg_55_0, var_55_7, 1)

	arg_55_0._detailPanel = var_55_7

	local var_55_8 = lc.createNode()

	lc.addChildToPos(var_55_7, var_55_8, cc.p(lc.cw(var_55_7), lc.ch(var_55_7) + 70))

	local var_55_9 = {}
	local var_55_10 = 0.6

	for iter_55_0, iter_55_1 in ipairs(arg_55_0._packageCards) do
		local var_55_11 = iter_55_1._infoId
		local var_55_12 = lc.createNode()

		var_55_12._id = var_55_11

		local var_55_13 = ClientView.createShaderButton(nil, function()
			var_0_2.create(var_55_11, 1, var_0_2.OperateType.view):show()
		end)
		local var_55_14 = require("CardThumbnail").create(var_55_11, 1)

		var_55_14:setScale(var_55_10)
		var_55_13:setContentSize(lc.w(var_55_14) * var_55_10, lc.h(var_55_14) * var_55_10)
		lc.addChildToCenter(var_55_13, var_55_14)

		local var_55_15 = lc.createSprite("god_pump_stage")
		local var_55_16 = lc.createSprite("god_pump_light")

		var_55_12:setContentSize(lc.w(var_55_16), lc.h(var_55_14) * var_55_10 + 140)
		lc.addChildToPos(var_55_12, var_55_15, cc.p(lc.cw(var_55_12), lc.ch(var_55_15)))
		lc.addChildToPos(var_55_12, var_55_16, cc.p(lc.cw(var_55_12), lc.h(var_55_15) + lc.ch(var_55_16) - 40))
		lc.addChildToPos(var_55_12, var_55_13, cc.p(lc.cw(var_55_12), lc.h(var_55_12) - lc.ch(var_55_13)))

		local var_55_17 = lc.createNode()

		lc.addChildToPos(var_55_12, var_55_17, cc.p(var_55_13:getPosition()), -1)

		var_55_12._effectNode = var_55_17

		local var_55_18 = ClientView.createShaderButton("god_pump_btn", function(arg_57_0)
			local var_57_0, var_57_1, var_57_2 = P._playerCard:composeCardByFragment(var_55_12._id, var_55_3, true, var_55_1._value)

			if var_57_0 == Data.ErrorType.compose_common_fragment then
				local var_57_3 = ""

				if var_57_1 > 0 and var_57_2 > 0 then
					var_57_3 = string.format(Str(STR.COMFIRM_COMPOSE_WITH_SPECIAL_COMMON_FRAGMENT), var_57_1, var_57_2)
				elseif var_57_1 > 0 then
					var_57_3 = string.format(Str(STR.COMFIRM_COMPOSE_WITH_SPECIAL_FRAGMENT), var_57_1)
				elseif var_57_2 > 0 then
					var_57_3 = string.format(Str(STR.COMFIRM_COMPOSE_WITH_COMMON_FRAGMENT), var_57_2)
				end

				require("Dialog").showDialog(var_57_3, function()
					P._playerCard:composeCardByFragment(var_55_12._id, var_55_3, false, var_55_1._value)
					require("CardComposePanel").create(var_55_12._id):show()
				end)
			elseif var_57_0 == Data.ErrorType.ok then
				require("Dialog").showDialog(Str(STR.COMFIRM_COMPOSE_FRAGMENT), function()
					P._playerCard:composeCardByFragment(var_55_12._id, var_55_3, false, var_55_1._value)
					require("CardComposePanel").create(var_55_12._id):show()
				end)
			else
				return ToastManager.push(Str(STR.FRAGMENT_NOT_ENOUGH))
			end
		end)

		var_55_18:setDisabledShader(ClientView.SHADER_DISABLE)
		lc.addChildToPos(var_55_12, var_55_18, cc.p(lc.cw(var_55_12), lc.ch(var_55_18)))
		var_55_18:addLabel(Str(STR.COMPOSE))

		var_55_12._composeBtn = var_55_18

		local var_55_19 = ClientView.createLabelProgressBar(lc.w(var_55_18), nil, ClientView.COLOR_TEXT_WHITE, ClientView.COLOR_TEXT_BLUE)

		lc.addChildToPos(var_55_12, var_55_19, cc.p(lc.cw(var_55_12), lc.top(var_55_18) + 10))
		var_55_19._bar:setPercent(P._playerCard:getFragmentCount(var_55_12._id) / P._playerCard:getCardFragmentNeedCount(var_55_12._id) * 100)
		var_55_19:setLabel(P._playerCard:getFragmentCount(var_55_12._id), P._playerCard:getCardFragmentNeedCount(var_55_12._id))

		var_55_12._progressBar = var_55_19

		if var_55_4 then
			var_55_18:setVisible(false)

			local var_55_20 = ClientView.createShaderButton("god_pump_btn", function(arg_60_0)
				local var_60_0 = P._playerCard:convert2FragmentId(var_55_12._id)
				local var_60_1 = P._playerCard:getFragmentCount(var_55_12._id)

				if var_60_1 > 0 then
					require("Dialog").showDialog(Str(STR.CONVERT_TIP), function()
						ClientData.sendConvertFragment(var_60_0)
						require("RewardPanel").create({
							{
								info_id = Data.PropsId.special_common_fragment,
								num = var_60_1
							}
						}):show()
						P._playerCard:removeCard(var_60_0, var_60_1)
					end)
				end
			end)

			var_55_20:setDisabledShader(ClientView.SHADER_DISABLE)
			lc.addChildToPos(var_55_12, var_55_20, cc.p(lc.cw(var_55_12), lc.ch(var_55_20)))
			var_55_20:addLabel(Str(STR.CONVERT))

			var_55_12._convertBtn = var_55_20
		end

		table.insert(var_55_9, var_55_12)
	end

	lc.addNodesToCenter(var_55_8, var_55_9, -40)

	var_55_7._cards = var_55_9

	local function var_55_21()
		local var_62_0 = true

		for iter_62_0, iter_62_1 in ipairs(arg_55_0._packageCards) do
			local var_62_1 = Data.getInfo(iter_62_1._infoId)

			if P._playerCard:getCardCount(iter_62_1._infoId) < var_62_1._maxCount and P._playerCard:getFragmentCount(iter_62_1._infoId) < P._playerCard:getCardFragmentNeedCount(iter_62_1._infoId) then
				var_62_0 = false

				break
			end
		end

		if var_62_0 then
			ToastManager.push(Str(STR.ALL_CARDS_OWNED))

			return false
		end

		return true
	end

	local var_55_22 = {}

	var_55_7._btns = var_55_22

	if var_55_4 then
		local var_55_23 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_63_0)
			require("AncientShopForm").create(math.floor(var_55_1._value / 100)):show()
		end, ClientView.CRECT_BUTTON, 200)

		lc.addChildToPos(var_55_7, var_55_23, cc.p(lc.cw(var_55_7), lc.ch(var_55_7) - 200))
		var_55_23:addLabel(Str(STR.BUY))
	else
		for iter_55_2, iter_55_3 in ipairs(var_55_0) do
			local var_55_24 = math.max(1, iter_55_3._value % 100)
			local var_55_25 = arg_55_0:createCostArea(iter_55_3, var_55_24, iter_55_3)

			function var_55_25._callback(arg_64_0)
				if var_55_21() then
					arg_55_0:sendBuyPackage(arg_64_0, iter_55_3)
				end
			end

			var_55_22[#var_55_22 + 1] = var_55_25
		end
	end

	lc.addNodesToCenter(var_55_7, var_55_22, 200, lc.ch(var_55_7) - 200)

	if not var_55_4 then
		local var_55_26 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_65_0)
			require("GodPumpUnopendForm").create():show()
		end, ClientView.CRECT_BUTTON_S, 120)

		lc.addChildToPos(var_55_7, var_55_26, cc.p(lc.w(var_55_7) - 240, 40))
		var_55_26:addLabel(Str(STR.LOTTERY_UNOPENED))

		local var_55_27 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_66_0)
			require("GodPumpOpendForm").create():show()
		end, ClientView.CRECT_BUTTON_S, 120)

		lc.addChildToPos(var_55_7, var_55_27, cc.p(lc.w(var_55_7) - 90, 40))
		var_55_27:addLabel(Str(STR.LOTTERY_OPENED))
	end

	arg_55_0:updateGodPumpBox()
	var_55_7:setVisible(false)
	var_55_7:setPosition(cc.p(ClientView.SCR_CW - 200, ClientView.SCR_CH))
	var_55_7:runAction(lc.sequence(lc.delay(0.2), lc.show(), lc.ease(lc.moveBy(0.3, cc.p(200, 0)), "BackO")))
end

function var_0_1.updateGodPumpBox(arg_67_0)
	local var_67_0 = arg_67_0._detailPanel

	if not var_67_0 then
		return
	end

	local var_67_1 = arg_67_0._detailData[1]

	if arg_67_0._resArea then
		arg_67_0._resArea._label:setString(P:getItemCount(Data.PropsId.special_common_fragment))
	end

	local var_67_2 = var_67_1._param[6] == 1
	local var_67_3 = var_67_1._param[7]
	local var_67_4 = var_67_0._cards

	for iter_67_0, iter_67_1 in ipairs(var_67_4) do
		local var_67_5 = Data.getInfo(iter_67_1._id)
		local var_67_6 = iter_67_1._progressBar

		var_67_6._bar:setPercent(P._playerCard:getFragmentCount(iter_67_1._id) / P._playerCard:getCardFragmentNeedCount(iter_67_1._id) * 100)

		if var_67_3 or P._playerCard:getCardCount(iter_67_1._id) < var_67_5._maxCount then
			var_67_6:setLabel(P._playerCard:getFragmentCount(iter_67_1._id), P._playerCard:getCardFragmentNeedCount(iter_67_1._id))
		else
			var_67_6:setLabel(Str(STR.UNION_SHOP_OWN))
		end

		if not var_67_3 then
			local var_67_7 = P._playerCard:composeCardByFragment(iter_67_1._id, var_67_2, true, var_67_1._value)

			iter_67_1._composeBtn:setEnabled(var_67_7 ~= Data.ErrorType.fragment_not_enough)
			iter_67_1._composeBtn:setVisible(P._playerCard:getCardCount(iter_67_1._id) < var_67_5._maxCount)
			iter_67_1._effectNode:removeAllChildren()

			if var_67_7 == Data.ErrorType.compose_common_fragment and P._playerCard:getCardCount(iter_67_1._id) < var_67_5._maxCount then
				local var_67_8 = DragonBones.create("xuanzhong")

				var_67_8:setScale(1.2)
				var_67_8:gotoAndPlay("effect1")
				lc.addChildToCenter(iter_67_1._effectNode, var_67_8)
			elseif var_67_7 == Data.ErrorType.ok and P._playerCard:getCardCount(iter_67_1._id) < var_67_5._maxCount then
				local var_67_9 = Particle.create("par_urxz")

				var_67_9:setScale(0.5)
				lc.addChildToCenter(iter_67_1._effectNode, var_67_9)
			end
		else
			iter_67_1._convertBtn:setEnabled(P._playerCard:getFragmentCount(iter_67_1._id) > 0)
		end
	end

	for iter_67_2, iter_67_3 in ipairs(var_67_0._btns) do
		iter_67_3:update()
	end
end

function var_0_1.hideCardBox(arg_68_0)
	arg_68_0._bg:setTexture("res/jpg/ui_scene_bg.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/god_pump_bg.jpg")
	arg_68_0._tabArea:setVisible(true)
	arg_68_0._list:setVisible(true)

	if arg_68_0._bottomArea then
		arg_68_0._bottomArea:removeFromParent()

		arg_68_0._bottomArea = nil
	end

	if arg_68_0._resArea then
		arg_68_0._resArea = nil
	end

	if arg_68_0._detailPanel then
		if arg_68_0._detailPanel._package then
			arg_68_0._detailPanel._package:removeFromParent()

			arg_68_0._detailPanel._package = nil
		end

		arg_68_0._detailPanel:removeFromParent()

		arg_68_0._detailPanel = nil
		arg_68_0._detailData = nil
	end

	arg_68_0._selectedCard = nil

	arg_68_0:setResourcePanel()
end

function var_0_1.updateCardBox(arg_69_0)
	if not arg_69_0._detailPanel or not arg_69_0._detailData then
		return
	end

	local var_69_0 = arg_69_0._detailData[1]

	if Data.getIsGodPumpRecruite(var_69_0) then
		return arg_69_0:updateGodPumpBox()
	end

	arg_69_0:updateCardList()

	local var_69_1, var_69_2, var_69_3 = arg_69_0:getPackageInfo()

	if arg_69_0._detailPanel._packageCount then
		for iter_69_0 = 1, #arg_69_0._detailPanel._cardCounts do
			arg_69_0._detailPanel._cardCounts[iter_69_0]:setString(string.format("%d/%d", var_69_1[iter_69_0], var_69_2[iter_69_0] + var_69_1[iter_69_0]))
		end

		arg_69_0._detailPanel._packageCount:setString(var_69_3)
	else
		for iter_69_1 = 1, #arg_69_0._detailPanel._cardCounts do
			arg_69_0._detailPanel._cardCounts[iter_69_1]:setString(var_69_2[iter_69_1] + var_69_1[iter_69_1])
		end
	end

	if arg_69_0._detailPanel._buyTip then
		if Data.getIsTimeLimitRoleRecruite(var_69_0) then
			ClientView.updateBoldRichTextMultiLine(arg_69_0._detailPanel._buyTip, Str(STR.RECRUIT_MORE_TIP_2))
		else
			local var_69_4 = string.format(Str(STR.RECRUIT_MORE_TIP), arg_69_0._remainUrCount)

			ClientView.updateBoldRichTextMultiLine(arg_69_0._detailPanel._buyTip, var_69_4)
		end
	end

	for iter_69_2, iter_69_3 in ipairs(arg_69_0._detailPanel._btns) do
		if iter_69_3._isCostArea then
			iter_69_3:update()
		end

		if Data.getIsClashRecruite(var_69_0) and var_69_3 == 0 then
			iter_69_3:setEnabled(false)
		end
	end

	if Data.getIsRareRecruite(var_69_0) and var_69_0._param[8] and var_69_0._param[8] > 0 and arg_69_0._detailPanel._rareGitBtn then
		local var_69_5 = math.floor(var_69_0._value / 1000) % 100
		local var_69_6 = var_69_0._param[8]
		local var_69_7 = P._playerBonus._bonuses[var_69_6]._isClaimed

		arg_69_0._detailPanel._rareGitBtn:setEnabled(not var_69_7)
	end

	arg_69_0:setResourcePanel()

	local var_69_8 = arg_69_0._detailPanel._valueArea

	if var_69_8 and var_69_8._infoId then
		var_69_8._label:setString(P:getItemCount(var_69_8._infoId))
	end

	arg_69_0:updateSelecedCard()
end

function var_0_1.initCardList(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0 = math.min(ClientView.SCR_W - 240 - 120, 820)

	arg_70_0._cardList = require("CardList").create(cc.size(var_70_0, 500), 0.5, false)

	arg_70_0._cardList:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_70_1, arg_70_0._cardList, cc.p((ClientView.SCR_W + 240) / 2, ClientView.SCR_CH + 70))
	arg_70_0._cardList:setMode(arg_70_2)

	arg_70_0._cardList._recruiteInfo = arg_70_0._packageCards

	local var_70_1 = (ClientView.SCR_W - 400 - lc.w(arg_70_0._cardList)) / 4

	arg_70_0._cardList._pageLeft._pos = cc.p(-var_70_1, lc.ch(arg_70_0._cardList))
	arg_70_0._cardList._pageRight._pos = cc.p(lc.w(arg_70_0._cardList) + var_70_1, lc.ch(arg_70_0._cardList))

	local var_70_2 = 240 + ClientView.SCR_EDGE - (lc.x(arg_70_0._cardList) - lc.cw(arg_70_0._cardList))
	local var_70_3 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_70_0._cardList, var_70_3, cc.p(lc.cw(var_70_3) + var_70_2, arg_70_2 == arg_70_0._cardList.ModeType.recruite and 2 or 8), -1)
	var_70_3:setFlippedX(true)
	var_70_3:setScale(1, 0.9)
	arg_70_0._cardList._pageLabel:setPosition(cc.p(var_70_3:getPosition()))
	arg_70_0._cardList:registerCardSelectedHandler(function(arg_71_0)
		require("CardInfoPanel").create(arg_71_0, 1, require("CardInfoPanel").OperateType.view):show()
	end)
end

function var_0_1.updateCardList(arg_72_0)
	arg_72_0._cardList._recruiteInfo = arg_72_0._packageCards

	arg_72_0._cardList:init(nil, {})
	arg_72_0._cardList:refresh(true)
end

function var_0_1.getPackageInfo(arg_73_0)
	local var_73_0 = arg_73_0._detailData[1]
	local var_73_1 = {
		0,
		0,
		0,
		0,
		0
	}
	local var_73_2 = {
		0,
		0,
		0,
		0,
		0
	}

	for iter_73_0 = 1, #arg_73_0._packageCards do
		local var_73_3 = arg_73_0._packageCards[iter_73_0]
		local var_73_4 = Data.getInfo(var_73_3._infoId)._quality

		var_73_1[var_73_4] = var_73_1[var_73_4] + var_73_3._remainNum
		var_73_2[var_73_4] = var_73_2[var_73_4] + var_73_3._getNum
	end

	local var_73_5 = 0

	for iter_73_1 = 1, #var_73_1 do
		var_73_5 = var_73_5 + var_73_1[iter_73_1]
	end

	local var_73_6 = Data.getIsCharacterRecruite(var_73_0) and 3 or 1
	local var_73_7 = math.floor(var_73_5 / var_73_6)

	return var_73_1, var_73_2, var_73_7
end

function var_0_1.removeCardFromPackage(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_0._detailData[1]

	if Data.getIsCharacterRecruite(var_74_0) then
		for iter_74_0 = 1, #arg_74_0._packageCards do
			local var_74_1 = arg_74_0._packageCards[iter_74_0]

			if var_74_1._infoId == arg_74_1 then
				var_74_1._getNum = var_74_1._getNum + arg_74_2
				var_74_1._remainNum = var_74_1._remainNum - arg_74_2
			end
		end
	end
end

function var_0_1.isLocked(arg_75_0, arg_75_1)
	local var_75_0 = false
	local var_75_1 = ""
	local var_75_2 = math.floor(arg_75_1._value / 100) * 100 + 1

	if Data.getIsTimeLimitRecruite(arg_75_1) then
		if Data.getIsTimeLimitRoleRecruite(arg_75_1) then
			local var_75_3 = arg_75_1._param[9]

			if var_75_3 ~= 99 then
				local var_75_4 = Data._characterInfo[var_75_3]

				if var_75_4 and not P:isCharacterUnlocked(var_75_4._id) then
					var_75_0 = true
					var_75_1 = string.format("%s\n|%s|", Str(STR.NEED_UNLOCK), lc.str(var_75_4._nameSid))
				end

				if var_75_4 and P._characters[var_75_3]._level < var_75_4._visibleLevel then
					var_75_0 = true
					var_75_1 = string.format(Str(STR.UNLOCK_WHEN_LEVEL, true), lc.str(var_75_4._nameSid), var_75_4._visibleLevel)
				end
			end
		elseif Data.getIsTimeLimitCriticalRecruite(arg_75_1) then
			local var_75_5 = arg_75_1._param[9]

			if var_75_5 == 11 and not P:isCharacterUnlocked(var_75_5) then
				local var_75_6 = Data._characterInfo[var_75_5]

				var_75_0 = true
				var_75_1 = string.format("%s\n|%s|", Str(STR.NEED_UNLOCK), lc.str(var_75_6._nameSid))
			end
		end
	elseif Data.getIsRareRecruite(arg_75_1) then
		-- block empty
	elseif Data.getIsCharacterRecruite(arg_75_1) then
		local var_75_7

		for iter_75_0, iter_75_1 in pairs(Data._characterInfo) do
			if iter_75_1._packageIds[1] == var_75_2 then
				var_75_7 = iter_75_1

				break
			end
		end

		if var_75_7 and not P:isCharacterUnlocked(var_75_7._id) then
			var_75_0 = true
			var_75_1 = string.format("%s\n|%s|", Str(STR.NEED_UNLOCK), lc.str(var_75_7._nameSid))
		end
	end

	return var_75_0, var_75_1
end

function var_0_1.removeTexureByCheckInfo(arg_76_0, arg_76_1)
	if type(arg_76_1) == "table" then
		lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/lottery_" .. arg_76_1._value .. ".jpg"))
	else
		local var_76_0 = Data._exchangeInfo[arg_76_1]

		lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/lottery_" .. var_76_0._activityId .. ".jpg"))
	end
end

function var_0_1.onChangeUp(arg_77_0)
	if arg_77_0:isSelectRecruite() then
		if P:getItemCount(Data.PropsId.select_recruite_token) <= 0 then
			return ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(Data.PropsId.select_recruite_token)))
		end
	elseif ClientData.getExpireTimestamp(0) < arg_77_0._selectedTime then
		return ToastManager.push(Str(STR.CHANGE_ONCE_A_DAY))
	end

	local var_77_0 = arg_77_0._detailData[3]

	require("ChooseUpPanel").create(var_77_0, arg_77_0._selectedCard):show()
end

function var_0_1.updateSelecedCard(arg_78_0)
	if not arg_78_0._selectedCard then
		return
	end

	local var_78_0 = arg_78_0._detailPanel

	if not var_78_0.updateSelecedCard then
		return false
	end

	var_78_0.updateSelecedCard()

	arg_78_0._cardList._upCard = arg_78_0._selectedCard

	arg_78_0._cardList:refresh()
end

function var_0_1.isSelectRecruite(arg_79_0)
	local var_79_0 = arg_79_0._detailData

	if not var_79_0 then
		return false
	end

	local var_79_1 = var_79_0[1]

	if Data.getIsTimeLimitFestivalRecruite(var_79_1) then
		if arg_79_0._selectedCard and arg_79_0._selectedCard > 0 then
			return true
		end

		if P:getItemCount(Data.PropsId.select_recruite_token) > 0 then
			return true
		end
	end

	return false
end

function var_0_1.onBuy(arg_80_0)
	local var_80_0 = arg_80_0._detailData[1]

	require("ShopPanel").create(var_80_0):show()
end

return var_0_1
