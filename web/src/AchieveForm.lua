local var_0_0 = class("AchieveForm", BaseForm)
local var_0_1 = cc.size(1010, 700)
local var_0_2 = 60

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.ACHIEVEMENT), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))
	arg_2_0._form:setTouchEnabled(false)

	local var_2_0 = {
		{
			_isSub = true,
			_str = Str(Data._characterInfo[19]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 19
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[18]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 18
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[17]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 17
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[16]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 16
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[15]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 15
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[11]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 11
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[14]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 14
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[7]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 7
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[9]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 9
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[10]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 10
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[13]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 13
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[4]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 4
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[12]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 12
		},
		{
			_isSub = true,
			_str = string.sub(Str(Data._characterInfo[5]._nameSid), 1, 9),
			_subIndex = Data.BonusType.level * 100 + 5
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[2]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 2
		},
		{
			_isSub = true,
			_str = Str(Data._characterInfo[3]._nameSid),
			_subIndex = Data.BonusType.level * 100 + 3
		}
	}
	local var_2_1 = {
		{
			_isSub = true,
			_str = Str(STR.FIND_ARENA_TITLE),
			_subIndex = Data.BonusType.clash * 100 + 2
		},
		{
			_isSub = true,
			_str = Str(STR.FIND_CLASH_TITLE),
			_subIndex = Data.BonusType.clash * 100 + 1
		}
	}
	local var_2_2

	if ClientData.isAppStoreReviewing() then
		var_2_2 = {}
	else
		var_2_2 = {
			{
				_str = Str(STR.MAIN_TASK),
				_index = Data.BonusType.lord
			},
			{
				_str = Str(STR.LEVEL_TASK),
				_index = Data.BonusType.level,
				_tabs = var_2_0
			},
			{
				_str = Str(STR.APP_NAME_JDZC),
				_index = Data.BonusType.clash,
				_tabs = var_2_1
			},
			{
				_str = Str(STR.ACHIEVE_COST),
				_index = Data.BonusType.gold_cost
			},
			{
				_str = Str(STR.ACHIEVE_COLLECT),
				_index = Data.BonusType.gold_gain
			}
		}
	end

	if ClientData.isUseFacebook() then
		Data.BonusType.facebook = Data.BonusType.online + 1
		Data.BonusType.novice = Data.BonusType.online + 2

		table.insert(var_2_2, {
			_str = "Facebook" .. Str(STR.BONUS)
		})
	end

	if not P._playerBonus:isAllNoviceTaskClaimed() then
		-- block empty
	end

	local var_2_3 = ClientView.createVerticalTabListArea(lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM, var_2_2, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0:showTab(arg_3_0._index, not arg_3_1, arg_3_2)
	end)

	function var_2_3._subTabExpandCallback(arg_4_0)
		arg_2_0:showTabFlag()
	end

	lc.addChildToPos(arg_2_0._frame, var_2_3, cc.p(ClientView.FRAME_INNER_LEFT + lc.w(var_2_3) / 2, lc.h(arg_2_0._frame) / 2), 0)

	arg_2_0._tabArea = var_2_3

	local var_2_4 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - lc.right(var_2_3) - ClientView.FRAME_INNER_RIGHT - 24, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - var_0_2 - 52), 10, 10)

	var_2_4:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0._frame, var_2_4, cc.p(lc.right(var_2_3) + 14 + lc.w(var_2_4) / 2, lc.h(arg_2_0._frame) / 2 - var_0_2))

	arg_2_0._list = var_2_4

	local var_2_5 = lc.createNode()

	lc.addChildToPos(arg_2_0._frame, var_2_5, cc.p((lc.w(arg_2_0._frame) + lc.right(var_2_3)) / 2 - 14, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - var_0_2))

	local var_2_6 = "achieve_bg"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_2_6 .. "_2")) then
		var_2_6 = var_2_6 .. "_2"
	end

	if ClientData.isAnotherSkin2() and lc.File:isFileExist(lc.formatJpg(var_2_6 .. "_3")) then
		var_2_6 = var_2_6 .. "_3"
	end

	local var_2_7 = lc.createSprite(lc.formatJpg(var_2_6))

	var_2_5:addChild(var_2_7)

	local var_2_8 = ClientData.formatNum(P._achievePoint, 9999)
	local var_2_9 = ClientView.createTTF(var_2_8, ClientView.FontSize.S1)

	var_2_9:setAnchorPoint(0.5, 0)
	lc.addChildToPos(var_2_5, var_2_9, cc.p(235, -26))

	arg_2_0._pointLabel = var_2_9

	P._playerBonus:sendBonusRequest()

	if arg_2_0._indicator then
		arg_2_0._indicator:removeFromParent()

		arg_2_0._indicator = nil
	end

	arg_2_0._indicator = ClientView.showPanelActiveIndicator(arg_2_0._form, lc.bound(arg_2_0._list))

	lc.offset(arg_2_0._indicator, 0, 20)
end

function var_0_0.onDataCallBack(arg_5_0)
	if arg_5_0._indicator then
		arg_5_0._indicator:removeFromParent()

		arg_5_0._indicator = nil
	end

	arg_5_0._tabArea:showTab(Data.BonusType.lord, false)
	arg_5_0:onGuide(nil)
end

function var_0_0.showTab(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_2 then
		return
	end

	arg_6_0._focusTabIndex = arg_6_1

	arg_6_0:refreshList()

	if GuideManager.isGuideEnabled() and arg_6_3 then
		GuideManager.finishStepLater()
	end
end

function var_0_0.showTabFlag(arg_7_0)
	local var_7_0 = arg_7_0._tabArea._list:getItems()

	for iter_7_0 = 1, #var_7_0 do
		local var_7_1 = 0
		local var_7_2 = var_7_0[iter_7_0]._index

		if var_7_2 == Data.BonusType.lord then
			var_7_1 = P._playerBonus:getMainTaskBonusFlag()
		elseif var_7_2 == Data.BonusType.level then
			var_7_1 = P._playerBonus:getLevelTaskBonusFlag()
		elseif var_7_2 == Data.BonusType.daily_task then
			var_7_1 = P._playerBonus:getDailyTaskBonusFlag()
		elseif var_7_2 == Data.BonusType.novice then
			var_7_1 = P._playerBonus:getNoviceTaskBonusFlag()
		elseif var_7_2 == Data.BonusType.grain then
			var_7_1 = P._playerBonus:getGrainTaskBonusFlag()
		elseif var_7_2 == Data.BonusType.facebook then
			var_7_1 = P._playerBonus:getFacebookTaskBonusFlag()
		elseif var_7_2 == Data.BonusType.clash then
			var_7_1 = P._playerBonus:getClashBonusesFlag() + P._playerBonus:getArenaBonusesFlag()
		elseif math.floor(var_7_2 / 100) == Data.BonusType.level then
			local var_7_3 = var_7_2 % 100

			var_7_1 = P._playerBonus:getLevelTaskBonusFlag(2000 + var_7_3)
		elseif math.floor(var_7_2 / 100) == Data.BonusType.clash then
			local var_7_4 = var_7_2 % 100

			if var_7_4 == 1 then
				var_7_1 = P._playerBonus:getClashBonusesFlag()
			elseif var_7_4 == 2 then
				var_7_1 = P._playerBonus:getArenaBonusesFlag()
			end
		elseif var_7_2 == Data.BonusType.gold_cost then
			var_7_1 = P._playerBonus:getCostBonusFlag()
		elseif var_7_2 == Data.BonusType.gold_gain then
			var_7_1 = P._playerBonus:getCollectBonusFlag()
		end

		local var_7_5 = var_7_0[iter_7_0]

		ClientView.checkNewFlag(var_7_5, var_7_1)
	end
end

function var_0_0.onEnter(arg_8_0)
	var_0_0.super.onEnter(arg_8_0)

	arg_8_0._listeners = {}

	local var_8_0 = lc.addEventListener(Data.Event.achieve_list_dirty, function(arg_9_0)
		arg_8_0:onDataCallBack()
	end)

	table.insert(arg_8_0._listeners, var_8_0)

	if arg_8_0._indicator then
		arg_8_0:onDataCallBack()
	end

	local var_8_1 = lc.addEventListener(Data.Event.achieve_point_dirty, function(arg_10_0)
		arg_8_0:refreshPoint()
	end)

	table.insert(arg_8_0._listeners, var_8_1)

	local var_8_2 = lc.addEventListener(Data.Event.level_dirty, function(arg_11_0)
		arg_8_0:refreshList()
	end)

	table.insert(arg_8_0._listeners, var_8_2)

	local var_8_3 = lc.addEventListener(Data.Event.bonus_dirty, function(arg_12_0)
		if arg_12_0._data._info._type == Data.BonusType.grain then
			arg_8_0:showTabFlag()
		end
	end)

	table.insert(arg_8_0._listeners, var_8_3)

	local var_8_4 = lc.addEventListener(GuideManager.Event.seek, function(arg_13_0)
		arg_8_0:onGuide(arg_13_0)
	end)

	table.insert(arg_8_0._listeners, var_8_4)

	local var_8_5 = lc.addEventListener(GuideManager.Event.finish, function(arg_14_0)
		arg_8_0:onGuideFinish(arg_14_0)
	end)

	table.insert(arg_8_0._listeners, var_8_5)

	if GuideManager.getCurStepName() == "enter task" then
		GuideManager.finishStepLater()
	end
end

function var_0_0.onExit(arg_15_0)
	var_0_0.super.onExit(arg_15_0)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_15_1)
	end
end

function var_0_0.onCleanup(arg_16_0)
	ClientView.getMenuUI():updateAchieveFlag()
	var_0_0.super.onCleanup(arg_16_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/task_novice_top.jpg"))
end

function var_0_0.onShowActionFinished(arg_17_0)
	arg_17_0:onGuide(nil)
end

function var_0_0.refreshPoint(arg_18_0)
	local var_18_0 = ClientData.formatNum(P._achievePoint, 9999)

	arg_18_0._pointLabel:setString(var_18_0)
end

function var_0_0.refreshList(arg_19_0)
	local var_19_0 = arg_19_0._list

	if arg_19_0._topBar then
		arg_19_0._topBar:removeFromParent()

		arg_19_0._topBar = nil
	end

	if arg_19_0._focusTabIndex == Data.BonusType.lord then
		local var_19_1 = {}
		local var_19_2 = 1

		for iter_19_0, iter_19_1 in ipairs(P._playerAchieve:getOrderedMainTasks()) do
			if iter_19_1:isValid() then
				local var_19_3 = iter_19_1:getBonus()

				if var_19_3._value >= var_19_3._info._val then
					table.insert(var_19_1, var_19_2, iter_19_1)

					var_19_2 = var_19_2 + 1
				else
					table.insert(var_19_1, iter_19_1)
				end
			end
		end

		var_19_0:bindData(var_19_1, function(arg_20_0, arg_20_1)
			arg_19_0:setOrCreateItem(arg_20_0, arg_20_1)
		end, math.min(5, #var_19_1))

		for iter_19_2 = 1, var_19_0._cacheCount do
			var_19_0:pushBackCustomItem(arg_19_0:setOrCreateItem(nil, var_19_1[iter_19_2]))
		end
	elseif arg_19_0._focusTabIndex == Data.BonusType.level or math.floor(arg_19_0._focusTabIndex / 100) == Data.BonusType.level then
		local var_19_4 = {}
		local var_19_5, var_19_6, var_19_7 = P._playerBonus.splitBonus(P._playerBonus._bonusLevel)
		local var_19_8 = arg_19_0._focusTabIndex - Data.BonusType.level * 100

		for iter_19_3, iter_19_4 in ipairs(var_19_5) do
			if iter_19_4._info._cid - 2000 == var_19_8 then
				table.insert(var_19_4, iter_19_4)
			end
		end

		for iter_19_5, iter_19_6 in ipairs(var_19_6) do
			if iter_19_6._info._cid - 2000 == var_19_8 and (P:isMaxLevel(var_19_8) or iter_19_6._info._val <= P:getMaxLevel(var_19_8)) then
				table.insert(var_19_4, iter_19_6)
			end
		end

		for iter_19_7, iter_19_8 in ipairs(var_19_7) do
			if iter_19_8._info._cid - 2000 == var_19_8 then
				table.insert(var_19_4, iter_19_8)
			end
		end

		var_19_0:bindData(var_19_4, function(arg_21_0, arg_21_1)
			arg_19_0:setOrCreateItem(arg_21_0, arg_21_1)
		end, math.min(5, #var_19_4))

		for iter_19_9 = 1, var_19_0._cacheCount do
			var_19_0:pushBackCustomItem(arg_19_0:setOrCreateItem(nil, var_19_4[iter_19_9]))
		end
	elseif arg_19_0._focusTabIndex == Data.BonusType.daily_task then
		local var_19_9 = {}
		local var_19_10 = 1
		local var_19_11 = P._playerBonus._bonusDailyTask

		for iter_19_10, iter_19_11 in ipairs(var_19_11) do
			if P._playerAchieve:getDailyTaskLevel(iter_19_11._info._cid % 100) <= P._level and not iter_19_11._isClaimed then
				if iter_19_11._value >= iter_19_11._info._val then
					table.insert(var_19_9, var_19_10, iter_19_11)

					var_19_10 = var_19_10 + 1
				else
					table.insert(var_19_9, iter_19_11)
				end
			end
		end

		var_19_0:bindData(var_19_9, function(arg_22_0, arg_22_1)
			arg_19_0:setOrCreateItem(arg_22_0, arg_22_1)
		end, math.min(5, #var_19_9))

		for iter_19_12 = 1, var_19_0._cacheCount do
			var_19_0:pushBackCustomItem(arg_19_0:setOrCreateItem(nil, var_19_9[iter_19_12]))
		end

		var_19_0:checkEmpty(Str(STR.LIST_EMPTY_TASK_DONE))
	elseif arg_19_0._focusTabIndex == Data.BonusType.grain then
		local var_19_12 = P._playerBonus._bonusGrainTask

		var_19_0:bindData(var_19_12, function(arg_23_0, arg_23_1)
			arg_19_0:setOrCreateItem(arg_23_0, arg_23_1)
		end, math.min(5, #var_19_12))

		for iter_19_13 = 1, var_19_0._cacheCount do
			var_19_0:pushBackCustomItem(arg_19_0:setOrCreateItem(nil, var_19_12[iter_19_13]))
		end
	elseif arg_19_0._focusTabIndex == Data.BonusType.novice then
		local var_19_13 = {}
		local var_19_14 = 1
		local var_19_15 = P._playerBonus._bonusNoviceTask

		for iter_19_14, iter_19_15 in ipairs(var_19_15) do
			if not iter_19_15._isClaimed then
				table.insert(var_19_13, var_19_14, iter_19_15)

				var_19_14 = var_19_14 + 1
			end
		end

		var_19_0:bindData(var_19_13, function(arg_24_0, arg_24_1)
			arg_19_0:setOrCreateItem(arg_24_0, arg_24_1)
		end, math.min(5, #var_19_13))

		for iter_19_16 = 1, var_19_0._cacheCount do
			var_19_0:pushBackCustomItem(arg_19_0:setOrCreateItem(nil, var_19_13[iter_19_16]))
		end

		if not ClientData.isAppStoreReviewing() then
			var_19_0:setContentSize(lc.w(var_19_0), lc.h(arg_19_0._frame) - 110)

			if not var_19_0:checkEmpty(Str(STR.LIST_EMPTY_TASK_DONE)) then
				arg_19_0._topBar = lc.createSpriteWithMask("res/jpg/task_novice_top.jpg")

				lc.addChildToPos(arg_19_0._frame, arg_19_0._topBar, cc.p(lc.left(var_19_0) + lc.w(arg_19_0._topBar) / 2 - 8, lc.top(var_19_0) + lc.h(arg_19_0._topBar) / 2 - 14))
			end
		end
	elseif arg_19_0._focusTabIndex == Data.BonusType.facebook then
		local var_19_16 = P._playerBonus._bonusFacebookTask

		var_19_0:bindData(var_19_16, function(arg_25_0, arg_25_1)
			arg_19_0:setOrCreateItem(arg_25_0, arg_25_1)
		end, math.min(5, #var_19_16))

		for iter_19_17 = 1, var_19_0._cacheCount do
			var_19_0:pushBackCustomItem(arg_19_0:setOrCreateItem(nil, var_19_16[iter_19_17]))
		end
	elseif arg_19_0._focusTabIndex == Data.BonusType.clash or math.floor(arg_19_0._focusTabIndex / 100) == Data.BonusType.clash then
		local var_19_17 = arg_19_0._focusTabIndex % 100
		local var_19_18 = {}

		if var_19_17 == 1 then
			for iter_19_18, iter_19_19 in ipairs(P._playerBonus._clashBonuses) do
				for iter_19_20, iter_19_21 in ipairs(iter_19_19) do
					if iter_19_21._isClaimed == false then
						table.insert(var_19_18, iter_19_21)

						break
					end
				end
			end
		elseif var_19_17 == 2 then
			for iter_19_22, iter_19_23 in ipairs(P._playerBonus._arenaBonuses) do
				for iter_19_24, iter_19_25 in ipairs(iter_19_23) do
					if iter_19_25._isClaimed == false then
						table.insert(var_19_18, iter_19_25)

						break
					end
				end
			end
		end

		table.sort(var_19_18, function(arg_26_0, arg_26_1)
			if arg_26_0:canClaim() and not arg_26_1:canClaim() then
				return true
			elseif not arg_26_0:canClaim() and arg_26_1:canClaim() then
				return false
			end

			return arg_26_0._type < arg_26_1._type
		end)
		var_19_0:bindData(var_19_18, function(arg_27_0, arg_27_1)
			arg_19_0:setOrCreateItem(arg_27_0, arg_27_1)
		end, math.min(5, #var_19_18))

		for iter_19_26 = 1, var_19_0._cacheCount do
			var_19_0:pushBackCustomItem(arg_19_0:setOrCreateItem(nil, var_19_18[iter_19_26]))
		end
	elseif arg_19_0._focusTabIndex == Data.BonusType.gold_cost then
		local var_19_19 = {}

		for iter_19_27, iter_19_28 in ipairs(P._playerBonus._costBonuses) do
			for iter_19_29, iter_19_30 in ipairs(iter_19_28) do
				if iter_19_30._isClaimed == false then
					table.insert(var_19_19, iter_19_30)

					break
				end
			end
		end

		table.sort(var_19_19, function(arg_28_0, arg_28_1)
			if arg_28_0:canClaim() and not arg_28_1:canClaim() then
				return true
			elseif not arg_28_0:canClaim() and arg_28_1:canClaim() then
				return false
			end

			return arg_28_0._type < arg_28_1._type
		end)
		var_19_0:bindData(var_19_19, function(arg_29_0, arg_29_1)
			arg_19_0:setOrCreateItem(arg_29_0, arg_29_1)
		end, math.min(5, #var_19_19))

		for iter_19_31 = 1, var_19_0._cacheCount do
			var_19_0:pushBackCustomItem(arg_19_0:setOrCreateItem(nil, var_19_19[iter_19_31]))
		end
	elseif arg_19_0._focusTabIndex == Data.BonusType.gold_gain then
		local var_19_20 = {}

		for iter_19_32, iter_19_33 in ipairs(P._playerBonus._collectBonuses) do
			for iter_19_34, iter_19_35 in ipairs(iter_19_33) do
				if iter_19_35._isClaimed == false then
					table.insert(var_19_20, iter_19_35)

					break
				end
			end
		end

		table.sort(var_19_20, function(arg_30_0, arg_30_1)
			if arg_30_0:canClaim() and not arg_30_1:canClaim() then
				return true
			elseif not arg_30_0:canClaim() and arg_30_1:canClaim() then
				return false
			end

			return arg_30_0._type < arg_30_1._type
		end)
		var_19_0:bindData(var_19_20, function(arg_31_0, arg_31_1)
			arg_19_0:setOrCreateItem(arg_31_0, arg_31_1)
		end, math.min(5, #var_19_20))

		for iter_19_36 = 1, var_19_0._cacheCount do
			var_19_0:pushBackCustomItem(arg_19_0:setOrCreateItem(nil, var_19_20[iter_19_36]))
		end
	end

	var_19_0:forceDoLayout()
	var_19_0:gotoTop()
	arg_19_0:showTabFlag()
end

function var_0_0.setOrCreateItem(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0._focusTabIndex == Data.BonusType.lord then
		local var_32_0 = arg_32_2:getBonus()
		local var_32_1 = Str(STR.MAIN_TASK_CHAPTER + arg_32_2._info._type)

		if arg_32_1 == nil then
			arg_32_1 = require("BonusWidget").create(lc.w(arg_32_0._list), var_32_0, var_32_1, arg_32_2:getDesc())
		else
			arg_32_1:setBonus(var_32_0, var_32_1, arg_32_2:getDesc())

			arg_32_1._newFlag = nil
		end

		arg_32_1:registerCallback(function(arg_33_0)
			arg_32_0:dealMainTask(arg_33_0)
		end)

		local var_32_2 = arg_32_2:getClaimableCount()

		if var_32_2 > 1 then
			local var_32_3 = ClientView.checkNewFlag(arg_32_1, var_32_2, -40, -32)

			if var_32_3 then
				var_32_3:setSpriteFrame("img_new_g")
			end

			if arg_32_1._progBar then
				arg_32_1._progBar:setVisible(false)
			end

			local var_32_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
				local var_34_0 = var_32_0._info
				local var_34_1 = var_34_0._type
				local var_34_2 = var_34_0._cid
				local var_34_3 = {}
				local var_34_4 = {}

				for iter_34_0, iter_34_1 in pairs(P._playerAchieve._mainTasks) do
					local var_34_5 = iter_34_1:getBonus()
					local var_34_6 = var_34_5._info

					if var_34_5._info._type == var_34_1 and var_34_5._info._cid == var_34_2 and var_34_5:canClaim() then
						ClientData.claimBonus(var_34_5)

						for iter_34_2, iter_34_3 in ipairs(var_34_6._rid) do
							local var_34_7 = var_34_3[iter_34_3]

							if var_34_7 == nil then
								var_34_7 = {}
								var_34_3[iter_34_3] = var_34_7
								var_34_7._infoId = iter_34_3
								var_34_7._count = var_34_6._count[iter_34_2]
								var_34_7._level = var_34_6._level[iter_34_2]
								var_34_7._isFragment = var_34_6._isFragment[iter_34_2] > 0

								table.insert(var_34_4, var_34_7)
							else
								var_34_7._count = var_34_7._count + var_34_6._count[iter_34_2]
							end
						end
					end
				end

				local var_34_8 = require("RewardPanel")

				var_34_8.create(var_34_4, var_34_8.MODE_CLAIM_ALL):show()
				lc.Audio.playAudio(AUDIO.E_CLAIM)
				arg_32_0:refreshList()
			end, ClientView.CRECT_BUTTON_S, lc.w(arg_32_1._button))

			var_32_4:addLabel(Str(STR.CLAIM_ALL))
			lc.addChildToPos(arg_32_1, var_32_4, cc.p(lc.x(arg_32_1._button), lc.bottom(arg_32_1._button) - 4 - lc.h(var_32_4) / 2))
		end
	elseif arg_32_0._focusTabIndex == Data.BonusType.novice then
		local var_32_5 = string.format(Str(STR.NOVICE_TASK_LOGIN_DAYS_TO_CLAIM), arg_32_2._infoId % 100)
		local var_32_6 = Str(arg_32_2._info._nameSid)

		if arg_32_1 == nil then
			arg_32_1 = require("BonusWidget").create(lc.w(arg_32_0._list), arg_32_2, var_32_5, var_32_6)
		else
			arg_32_1:setBonus(arg_32_2, var_32_5, var_32_6)
		end

		arg_32_1:registerCallback(function(arg_35_0)
			arg_32_0:dealNoviceTask(arg_35_0)
		end)
	elseif arg_32_0._focusTabIndex == Data.BonusType.facebook then
		if arg_32_1 == nil then
			arg_32_1 = require("BonusWidget").create(lc.w(arg_32_0._list), arg_32_2, title)
		else
			arg_32_1:setBonus(arg_32_2, title)
		end

		arg_32_1:registerCallback(function(arg_36_0)
			arg_32_0:dealFacebookTask(arg_36_0)
		end)
	elseif arg_32_0._focusTabIndex == Data.BonusType.clash or math.floor(arg_32_0._focusTabIndex / 100) == Data.BonusType.clash then
		local var_32_7 = string.format(Str(arg_32_2._info._nameSid), arg_32_2._info._val)

		if arg_32_1 == nil then
			arg_32_1 = require("BonusWidget").create(lc.w(arg_32_0._list), arg_32_2, var_32_7)
		else
			arg_32_1:setBonus(arg_32_2, var_32_7)
		end

		arg_32_1:registerCallback(function(arg_37_0)
			arg_32_0:dealClashAchieve(arg_37_0)
		end)

		local var_32_8 = 0

		if arg_32_2._type == Data.BonusType.clash then
			var_32_8 = P._playerBonus:getClashBonusFlag()
		elseif arg_32_2._type == Data.BonusType.clash_conti then
			var_32_8 = P._playerBonus:getClashContiBonusFlag()
		elseif arg_32_2._type == Data.BonusType.clash_legacy then
			var_32_8 = P._playerBonus:getClashLegacyBonusFlag()
		elseif arg_32_2._type == Data.BonusType.clash_zone then
			var_32_8 = P._playerBonus:getClashZoneBonusFlag()
		elseif arg_32_2._type == Data.BonusType.arena_once then
			var_32_8 = P._playerBonus:getArenaOnceBonusFlag()
		elseif arg_32_2._type == Data.BonusType.arena_all then
			var_32_8 = P._playerBonus:getArenaAllBonusFlag()
		elseif arg_32_2._type == Data.BonusType.arena_12 then
			var_32_8 = P._playerBonus:getArena12BonusFlag()
		end

		if var_32_8 > 1 then
			local var_32_9 = ClientView.checkNewFlag(arg_32_1, var_32_8, -40, -32)

			if var_32_9 then
				var_32_9:setSpriteFrame("img_new_g")
			end

			local var_32_10 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
				arg_32_0:claimAll(arg_32_2)
			end, ClientView.CRECT_BUTTON_S, lc.w(arg_32_1._button), 50)

			var_32_10:addLabel(Str(STR.CLAIM_ALL))
			arg_32_1:adjustPosition(true)
			lc.addChildToPos(arg_32_1, var_32_10, cc.p(lc.x(arg_32_1._button), lc.bottom(arg_32_1._button) - 4 - lc.h(var_32_10) / 2))
		end
	elseif arg_32_0._focusTabIndex == Data.BonusType.gold_cost then
		local var_32_11 = string.format(Str(arg_32_2._info._nameSid), arg_32_2._info._val)

		if arg_32_1 == nil then
			arg_32_1 = require("BonusWidget").create(lc.w(arg_32_0._list), arg_32_2, var_32_11)
		else
			arg_32_1:setBonus(arg_32_2, var_32_11)
		end

		arg_32_1:registerCallback(function(arg_39_0)
			arg_32_0:dealCostAchieve(arg_39_0)
		end)

		local var_32_12 = 0

		if arg_32_2._type == Data.BonusType.gold_cost then
			var_32_12 = P._playerBonus:getGoldCostBonusFlag()
		elseif arg_32_2._type == Data.BonusType.gem_cost then
			var_32_12 = P._playerBonus:getGemCostBonusFlag()
		elseif arg_32_2._type == Data.BonusType.bottle then
			var_32_12 = P._playerBonus:getBottleBonusFlag()
		elseif arg_32_2._type == Data.BonusType.card_package then
			var_32_12 = P._playerBonus:getCardPackageBonusFlag()
		end

		if var_32_12 > 1 then
			local var_32_13 = ClientView.checkNewFlag(arg_32_1, var_32_12, -40, -32)

			if var_32_13 then
				var_32_13:setSpriteFrame("img_new_g")
			end

			local var_32_14 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
				arg_32_0:claimAll(arg_32_2)
			end, ClientView.CRECT_BUTTON_S, lc.w(arg_32_1._button), 50)

			var_32_14:addLabel(Str(STR.CLAIM_ALL))
			arg_32_1:adjustPosition(true)
			lc.addChildToPos(arg_32_1, var_32_14, cc.p(lc.x(arg_32_1._button), lc.bottom(arg_32_1._button) - 4 - lc.h(var_32_14) / 2))
		end
	elseif arg_32_0._focusTabIndex == Data.BonusType.gold_gain then
		local var_32_15 = string.format(Str(arg_32_2._info._nameSid), arg_32_2._info._val)

		if arg_32_1 == nil then
			arg_32_1 = require("BonusWidget").create(lc.w(arg_32_0._list), arg_32_2, var_32_15)
		else
			arg_32_1:setBonus(arg_32_2, var_32_15)
		end

		arg_32_1:registerCallback(function(arg_41_0)
			arg_32_0:dealCollectAchieve(arg_41_0)
		end)

		local var_32_16 = 0

		if arg_32_2._type == Data.BonusType.card_sr then
			var_32_16 = P._playerBonus:getCardSrBonusFlag()
		elseif arg_32_2._type == Data.BonusType.card_ur then
			var_32_16 = P._playerBonus:getCardUrBonusFlag()
		elseif arg_32_2._type == Data.BonusType.gold_gain then
			var_32_16 = P._playerBonus:getGoldGainBonusFlag()
		end

		if var_32_16 > 1 then
			local var_32_17 = ClientView.checkNewFlag(arg_32_1, var_32_16, -40, -32)

			if var_32_17 then
				var_32_17:setSpriteFrame("img_new_g")
			end

			local var_32_18 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
				arg_32_0:claimAll(arg_32_2)
			end, ClientView.CRECT_BUTTON_S, lc.w(arg_32_1._button), 50)

			var_32_18:addLabel(Str(STR.CLAIM_ALL))
			arg_32_1:adjustPosition(true)
			lc.addChildToPos(arg_32_1, var_32_18, cc.p(lc.x(arg_32_1._button), lc.bottom(arg_32_1._button) - 4 - lc.h(var_32_18) / 2))
		end
	else
		local var_32_19

		if arg_32_0._focusTabIndex == Data.BonusType.level or math.floor(arg_32_0._focusTabIndex / 100) == Data.BonusType.level then
			var_32_19 = string.format(Str(arg_32_2._info._nameSid), arg_32_2._info._val)
		end

		if arg_32_1 == nil then
			arg_32_1 = require("BonusWidget").create(lc.w(arg_32_0._list), arg_32_2, var_32_19)
		else
			arg_32_1:setBonus(arg_32_2, var_32_19)
		end

		arg_32_1:registerCallback(function(arg_43_0)
			arg_32_0:dealCommonTask(arg_43_0, arg_32_1)
		end)
	end

	return arg_32_1
end

function var_0_0.claimAll(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1._info
	local var_44_1 = var_44_0._type
	local var_44_2 = var_44_0._cid
	local var_44_3 = {}

	if arg_44_1._type == Data.BonusType.clash then
		var_44_3 = P._playerBonus._bonusClash
	elseif arg_44_1._type == Data.BonusType.clash_conti then
		var_44_3 = P._playerBonus._bonusClashConti
	elseif arg_44_1._type == Data.BonusType.clash_legacy then
		var_44_3 = P._playerBonus._bonusClashLegacy
	elseif arg_44_1._type == Data.BonusType.clash_local then
		var_44_3 = P._playerBonus._bonusClashLocal
	elseif arg_44_1._type == Data.BonusType.clash_target then
		var_44_3 = P._playerBonus._bonusClashTarget
	elseif arg_44_1._type == Data.BonusType.gold_cost then
		var_44_3 = P._playerBonus._bonusGoldCost
	elseif arg_44_1._type == Data.BonusType.gem_cost then
		var_44_3 = P._playerBonus._bonusGemCost
	elseif arg_44_1._type == Data.BonusType.gold_gain then
		var_44_3 = P._playerBonus._bonusGoldGain
	elseif arg_44_1._type == Data.BonusType.card_package then
		var_44_3 = P._playerBonus._bonusCardPackage
	elseif arg_44_1._type == Data.BonusType.card_ur then
		var_44_3 = P._playerBonus._bonusCardUr
	elseif arg_44_1._type == Data.BonusType.card_sr then
		var_44_3 = P._playerBonus._bonusCardSr
	elseif arg_44_1._type == Data.BonusType.bottle then
		var_44_3 = P._playerBonus._bonusBottle
	elseif arg_44_1._type == Data.BonusType.arena_once then
		var_44_3 = P._playerBonus._bonusArenaOnce
	elseif arg_44_1._type == Data.BonusType.arena_all then
		var_44_3 = P._playerBonus._bonusArenaAll
	elseif arg_44_1._type == Data.BonusType.arena_12 then
		var_44_3 = P._playerBonus._bonusArena12
	end

	local var_44_4 = {}
	local var_44_5 = {}

	for iter_44_0, iter_44_1 in pairs(var_44_3) do
		local var_44_6 = iter_44_1
		local var_44_7 = var_44_6._info

		if var_44_6._info._type == var_44_1 and var_44_6._info._cid == var_44_2 and var_44_6:canClaim() then
			ClientData.claimBonus(var_44_6)

			for iter_44_2, iter_44_3 in ipairs(var_44_7._rid) do
				local var_44_8 = var_44_4[iter_44_3]

				if var_44_8 == nil then
					var_44_8 = {}
					var_44_4[iter_44_3] = var_44_8
					var_44_8._infoId = iter_44_3
					var_44_8._count = var_44_7._count[iter_44_2]
					var_44_8._level = var_44_7._level[iter_44_2]
					var_44_8._isFragment = var_44_7._isFragment[iter_44_2] > 0

					table.insert(var_44_5, var_44_8)
				else
					var_44_8._count = var_44_8._count + var_44_7._count[iter_44_2]
				end
			end
		end
	end

	local var_44_9 = require("RewardPanel")

	var_44_9.create(var_44_5, var_44_9.MODE_CLAIM_ALL):show()
	lc.Audio.playAudio(AUDIO.E_CLAIM)
	arg_44_0:refreshList()
end

function var_0_0.dealClashAchieve(arg_45_0, arg_45_1)
	if arg_45_1._value >= arg_45_1._info._val then
		if not arg_45_1._isClaimed then
			local var_45_0 = ClientData.claimBonus(arg_45_1)

			arg_45_0:refreshList()
			ClientView.showClaimBonusResult(arg_45_1, var_45_0)
		end
	elseif P._playerWorld._curLevel[1] > 10104 then
		if arg_45_1._type == Data.BonusType.arena_once or arg_45_1._type == Data.BonusType.arena_all or arg_45_1._type == Data.BonusType.arena_12 then
			lc.pushScene(require("FindScene").create(Data.FindMatchType.ladder))
		else
			lc.pushScene(require("FindScene").create())
		end

		arg_45_0:hide(true)
	else
		ToastManager.push(string.format(Str(STR.FINDSCENE_LOCKED), Str(Data._chapterInfo[1]._nameSid)))
	end
end

function var_0_0.dealCollectAchieve(arg_46_0, arg_46_1)
	if arg_46_1._value >= arg_46_1._info._val then
		if not arg_46_1._isClaimed then
			local var_46_0 = ClientData.claimBonus(arg_46_1)

			arg_46_0:refreshList()
			ClientView.showClaimBonusResult(arg_46_1, var_46_0)
		end
	elseif arg_46_1._info._type == Data.BonusType.gold_gain then
		require("ExchangeResForm").create(Data.ResType.gold):show()
		arg_46_0:hide(true)
	else
		lc.pushScene(require("TavernScene").create())
		arg_46_0:hide(true)
	end
end

function var_0_0.dealCostAchieve(arg_47_0, arg_47_1)
	if arg_47_1._value >= arg_47_1._info._val then
		if not arg_47_1._isClaimed then
			local var_47_0 = ClientData.claimBonus(arg_47_1)

			arg_47_0:refreshList()
			ClientView.showClaimBonusResult(arg_47_1, var_47_0)
		end
	else
		lc.pushScene(require("TavernScene").create())
		arg_47_0:hide(true)
	end
end

function var_0_0.dealMainTask(arg_48_0, arg_48_1)
	if arg_48_1._value >= arg_48_1._info._val then
		if not arg_48_1._isClaimed then
			local var_48_0 = ClientData.claimBonus(arg_48_1)

			arg_48_0:refreshList()
			ClientView.showClaimBonusResult(arg_48_1, var_48_0)
		end
	else
		local var_48_1

		for iter_48_0, iter_48_1 in pairs(P._playerAchieve._mainTasks) do
			if iter_48_1._info._bonusId == arg_48_1._infoId then
				if GuideManager.isGuideEnabled() then
					local var_48_2 = GuideManager.getCurStepName()

					if iter_48_1._type == Data.MainTaskType.chapter then
						if lc._runningScene._sceneId == ClientData.SceneId.city and var_48_2 == "enter world" then
							GuideManager.finishStep()
						end
					elseif iter_48_1._type == Data.MainTaskType.card and (var_48_2 == "enter heromansion" or var_48_2 == "enter barrack") then
						GuideManager.finishStep()
					end
				else
					var_48_1 = iter_48_1
				end
			end
		end

		if var_48_1 then
			arg_48_0:setVisible(false)

			local var_48_3 = var_48_1:getBonus()

			arg_48_0:gotoBonusTask(var_48_3)
		end

		arg_48_0:hide(true)
	end
end

function var_0_0.dealCommonTask(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_1._value >= arg_49_1._info._val then
		if not arg_49_1._isClaimed then
			local var_49_0 = ClientData.claimBonus(arg_49_1)

			arg_49_0:refreshList()
			ClientView.showClaimBonusResult(arg_49_1, var_49_0)
		end
	elseif arg_49_2._isShowBreakOut then
		local var_49_1 = arg_49_2._charId

		require("Dialog").showDialog(string.format(Str(STR.SURE_TO_BREAK_OUT), Str(Data._characterInfo[var_49_1]._nameSid)), function()
			local var_50_0 = P:breakOutChar(var_49_1)

			if var_50_0 == Data.ErrorType.need_more_count then
				return ToastManager.push(string.format(Str(STR.NOT_ENOUGH_X), ClientData.getNameByInfoId(Data.PropsId.char_break_out_token)))
			elseif var_50_0 == Data.ErrorType.ok then
				return ClientData.sendCharBreakOut(var_49_1)
			end
		end)
	else
		local var_49_2 = arg_49_1._info._cid % 100

		if var_49_2 == Data.DailyAchieveType.city_battle_win then
			if lc._runningScene._sceneId == ClientData.SceneId.city then
				arg_49_0:guideToChapter()
			else
				lc._runningScene:setWorldDisplay(Data.WorldDisplay.normal)
			end
		elseif var_49_2 == Data.DailyAchieveType.challenge_elite or var_49_2 == Data.DailyAchieveType.city_battle_win or var_49_2 == Data.DailyAchieveType.player_battle_win or var_49_2 == Data.DailyAchieveType.rob_horse or var_49_2 == Data.DailyAchieveType.copy_boss or var_49_2 == Data.DailyAchieveType.expedition then
			if var_49_2 == Data.DailyAchieveType.player_battle_win then
				lc.pushScene(require("FindScene").create())
			elseif var_49_2 == Data.DailyAchieveType.rob_horse then
				require("CrusadePanel").create(Data.CopyType.group_commander):show()
			elseif var_49_2 == Data.DailyAchieveType.challenge_elite then
				require("CrusadePanel").create(Data.CopyType.group_elite):show()
			elseif var_49_2 == Data.DailyAchieveType.expedition then
				require("CrusadePanel").create(Data.CopyType.group_expedition):show()
			elseif var_49_2 == Data.DailyAchieveType.copy_boss then
				require("CrusadePanel").create(Data.CopyType.group_boss):show()
			end
		elseif var_49_2 == Data.DailyAchieveType.collect_in_residence or var_49_2 == Data.DailyAchieveType.collect_in_farmland or var_49_2 == Data.DailyAchieveType.collect_fragment then
			arg_49_0:gotoBonusTask(arg_49_1)
		elseif var_49_2 == Data.DailyAchieveType.book_lottery then
			ClientView.popScene(true)
			lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.factory_magic))
			lc.pushScene(require("BookLotteryScene").create())
		elseif var_49_2 == Data.DailyAchieveType.upgrade_hero then
			ClientView.popScene(true)
			lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.factory_monster))
		elseif var_49_2 == Data.DailyAchieveType.upgrade_book then
			ClientView.popScene(true)
			lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.factory_magic))
		elseif var_49_2 == Data.DailyAchieveType.upgrade_equip then
			ClientView.popScene(true)
			lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.factory_trap))
		elseif var_49_2 == Data.DailyAchieveType.upgrade_horse then
			ClientView.popScene(true)
			lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.stable))
		elseif var_49_2 == Data.DailyAchieveType.lottery_hero then
			ClientView.popScene(true)
			lc.pushScene(require("TavernScene").create())
		elseif var_49_2 == Data.DailyAchieveType.view_palace_task then
			ClientView.popScene(true)
			lc.pushScene(require("PalaceScene").create())
		elseif var_49_2 == Data.DailyAchieveType.open_box then
			ClientView.popScene(true)
			lc.pushScene(require("DepotScene").create())
		elseif var_49_2 == Data.DailyAchieveType.challenge_uboss then
			if P:hasUnion() then
				ClientView.popScene(true)
				lc.pushScene(require("UnionScene").create())
			else
				ToastManager.push(Str(STR.UNLOCK_JOIN_UNION))

				return
			end
		end

		arg_49_0:hide(true)
	end
end

function var_0_0.dealNoviceTask(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1._infoId % 100

	if arg_51_1._value >= arg_51_1._info._val then
		if not arg_51_1._isClaimed then
			if var_51_0 > P._playerBonus._bonusLogin[1]._value then
				ToastManager.push(string.format(Str(STR.NOVICE_TASK_CANT_CLAIM), var_51_0))

				return
			end

			local var_51_1 = ClientData.claimBonus(arg_51_1)

			arg_51_0:refreshList()
			ClientView.showClaimBonusResult(arg_51_1, var_51_1)
		end
	else
		arg_51_0:setVisible(false)
		arg_51_0:gotoBonusTask(arg_51_1)
		arg_51_0:hide(true)
	end
end

function var_0_0.dealFacebookTask(arg_52_0, arg_52_1)
	if arg_52_1._value >= arg_52_1._info._val then
		if not arg_52_1._isClaimed then
			local var_52_0 = ClientData.claimBonus(arg_52_1)

			arg_52_0:refreshList()
			ClientView.showClaimBonusResult(arg_52_1, var_52_0)
		end
	else
		arg_52_0:gotoBonusTask(arg_52_1)
	end
end

function var_0_0.gotoBonusTask(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1._info._cid

	if arg_53_1._info._type == Data.BonusType.facebook then
		if lc.PLATFORM == cc.PLATFORM_OS_WINDOWS then
			local var_53_1 = {
				"FACEBOOK_LOGGEDIN",
				"FACEBOOK_LIKED",
				"FACEBOOK_INVITED"
			}
			local var_53_2 = cc.EventCustom:new(Data.Event.application)

			var_53_2:setUserString(var_53_1[var_53_0 - 2400])
			lc.Dispatcher:dispatchEvent(var_53_2)
		elseif var_53_0 == 2401 then
			lc.App:facebookLogin()
		elseif var_53_0 == 2402 then
			lc.App:facebookLike("https://www.facebook.com/%E8%99%9F%E4%BB%A4%E4%B8%89%E5%9C%8B-1330223180338868/")
		elseif var_53_0 == 2403 then
			lc.App:facebookInvite("https://fb.me/1037952556288521")
		end
	elseif var_53_0 == 1705 then
		GuideManager.showSoftGuideFinger(ClientView.getMenuUI()._btnRank)
	elseif arg_53_1:isChapter() or var_53_0 == 1701 or var_53_0 == 1702 or var_53_0 >= 2000 and var_53_0 <= 2100 then
		if lc._runningScene._sceneId == ClientData.SceneId.city then
			local var_53_3

			if arg_53_1:isChapter() then
				local var_53_4 = Data._levelInfo[arg_53_1._info._val]

				require("TravelPanel").create(var_53_4._id):show()
			elseif var_53_0 == 1701 then
				lc.pushScene(require("WorldScene").create({
					_infoId = 1
				}, Data.WorldDisplay.normal))
			elseif var_53_0 == 1702 then
				for iter_53_0, iter_53_1 in ipairs(P._playerWorld._chapters) do
					local var_53_5 = P._playerWorld._cities[iter_53_1._levelId]

					if var_53_5._status == var_53_5.Status.self and var_53_5:getType() ~= Data.CityType.small then
						arg_53_0:guideToChapter(var_53_5._chapterIds[1])

						break
					end
				end
			else
				arg_53_0:guideToChapter()
			end
		else
			lc._runningScene:onGotoBonusTask(arg_53_1)
		end
	else
		if lc._runningScene._sceneId == ClientData.SceneId.world then
			ClientView.popScene(true)
		end

		if ClientView._cityScene then
			ClientView._cityScene:onGotoBonusTask(arg_53_1)
		end
	end
end

function var_0_0.guideToChapter(arg_54_0, arg_54_1)
	return
end

function var_0_0.hide(arg_55_0, arg_55_1)
	var_0_0.super.hide(arg_55_0, arg_55_1)

	if GuideManager.getCurStepName() == "close task" then
		GuideManager.finishStep()
	end
end

function var_0_0.onGuide(arg_56_0, arg_56_1)
	local var_56_0 = GuideManager.getCurStepName()

	if var_56_0 == "claim task" then
		if arg_56_0._list:getChildrenCount() > 0 then
			GuideManager.setOperateLayer(arg_56_0._list:getItem(0)._button)
		end
	elseif var_56_0 == "close task" then
		GuideManager.setOperateLayer(arg_56_0._btnBack)
	elseif string.find(var_56_0, "goto task") then
		local var_56_1 = tonumber(var_56_0:split(" ")[3])
		local var_56_2 = 0

		if var_56_1 == 4 then
			arg_56_0._list:scrollToBottom(0.2, false)

			var_56_2 = 0.3
		end

		arg_56_0._list:runAction(lc.sequence(var_56_2, function()
			GuideManager.setOperateLayer(arg_56_0._list:getItem(var_56_1)._button)
		end))
	elseif var_56_0 == "show tab maintask" then
		GuideManager.setOperateLayer(arg_56_0._tabArea._list:getItem(Data.BonusType.lord - 1))
	elseif var_56_0 == "show tab dailytask" then
		GuideManager.setOperateLayer(arg_56_0._tabArea._list:getItem(Data.BonusType.daily_task - 1))
	elseif var_56_0 == "show tab novicetask" then
		GuideManager.setOperateLayer(arg_56_0._tabArea._list:getItem(Data.BonusType.novice - 1))
	else
		return
	end

	if arg_56_1 then
		arg_56_1:stopPropagation()
	end
end

function var_0_0.onGuideFinish(arg_58_0, arg_58_1)
	if arg_58_1._guideId == 500 then
		GuideManager.showSoftGuideFinger(arg_58_0._list:getItem(Data.BonusType.lord - 1)._button)
	end
end

return var_0_0
