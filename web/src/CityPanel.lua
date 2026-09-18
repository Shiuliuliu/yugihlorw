local var_0_0 = require("SidePanel")
local var_0_1 = class("CityPanel", var_0_0)

function var_0_1.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.createSidePanel(var_0_1)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.init(arg_2_0)

	arg_2_0._city = arg_2_1

	if arg_2_1._newModeStart > 0 then
		arg_2_1:setNewModeStart(0, true)
	end

	local var_2_0 = GuideManager.getCurStepName()

	if string.find(var_2_0, "select city") then
		GuideManager.startStepLater(0.5)
	end

	arg_2_0._title:setString(Str(arg_2_1._info._nameSid))

	local var_2_1
	local var_2_2 = arg_2_0._city._status ~= arg_2_0._city.Status.user

	if var_2_2 then
		arg_2_0._tabs = arg_2_0:getChapterTabs()

		arg_2_0:initContentBg(arg_2_0._tabs)

		var_2_1 = lc.h(arg_2_0._contentBg) - 24
	else
		arg_2_0:initContentBg()

		var_2_1 = arg_2_0:addArea(arg_2_0:createPlayerArea(Str(STR.OPPONENT_LORD)), lc.h(arg_2_0._contentBg) - 26)
	end

	arg_2_0._troopArea = var_2_2 and arg_2_0:createTroopArea(Str(STR.DEF_TROOP)) or arg_2_0:createTroopArea(Str(STR.DEF_TROOP), 300)

	local var_2_3 = arg_2_0:addArea(arg_2_0._troopArea, var_2_1)
	local var_2_4 = arg_2_0:addArea(arg_2_0:createDropArea(), var_2_3)

	if var_2_2 then
		local var_2_5 = arg_2_0:addArea(arg_2_0:createConditionArea(), var_2_4)
	end

	arg_2_0:createButtonArea()
	arg_2_0:addArea(arg_2_0:createButtonClipArea())

	if var_2_2 then
		if arg_2_2 then
			arg_2_2 = math.min(arg_2_2, #arg_2_0:getChapters())
		else
			arg_2_2 = math.min(arg_2_0._city._chapter, #arg_2_0:getChapters())
		end

		for iter_2_0 = arg_2_2, 1, -1 do
			if arg_2_0:checkShowTab(iter_2_0, false) then
				arg_2_0._contentBg:showTab(iter_2_0, true, false)

				break
			end
		end
	else
		arg_2_0._playerArea:setVisible(false)
		arg_2_0._troopArea:setVisible(false)
		arg_2_0._dropArea:setVisible(false)
		arg_2_0._buttonArea:setVisible(false)

		arg_2_0._activeIndicator = ClientView.showPanelActiveIndicator(arg_2_0._formBG, cc.rect(10, 10, lc.w(arg_2_0._formBG) - 20, lc.h(arg_2_0._formBG) - 20))

		performWithDelay(arg_2_0, function()
			arg_2_0._city:requestUserInfo()
		end, 0.3)
	end

	if var_2_2 then
		arg_2_0:updateRaidCountAndUiAround()
	end
end

function var_0_1.onEnter(arg_4_0)
	local var_4_0 = {}

	table.insert(var_4_0, lc.addEventListener(Data.Event.city_user_dirty, function(arg_5_0)
		if arg_5_0._data == arg_4_0._city then
			if arg_4_0._activeIndicator ~= nil then
				arg_4_0._activeIndicator:removeFromParent()

				arg_4_0._activeIndicator = nil
			end

			arg_4_0:updateCityUser()
		end
	end))
	table.insert(var_4_0, lc.addEventListener(GuideManager.Event.seek, function(arg_6_0)
		arg_4_0:onGuide(arg_6_0)
	end))
	table.insert(var_4_0, lc.addEventListener(Data.Event.prop_dirty, function(arg_7_0)
		if arg_7_0._data._infoId == Data.PropsId.sweep_card then
			arg_4_0:updateSweepCardLabels()
		end
	end))
	table.insert(var_4_0, lc.addEventListener(Data.Event.grain_dirty, function(arg_8_0)
		arg_4_0:updateCostLabel()
	end))

	arg_4_0._listeners = var_4_0

	if arg_4_0._btnTroop then
		arg_4_0._btnTroop._label:setString(string.format("%s %d", Str(STR.TROOP), P._curTroopIndex))
	end

	if arg_4_0._conditionList then
		for iter_4_0 = 1, #arg_4_0._conditionList do
			local var_4_1 = arg_4_0._conditionList[iter_4_0]

			if P:preCheckCondition(var_4_1._conditionId, var_4_1._conditionValue, P._curTroopIndex) then
				var_4_1:setColor(ClientView.COLOR_TEXT_DARK)
			else
				var_4_1:setColor(lc.Color3B.red)
			end
		end
	end

	arg_4_0:updateMyAttackValue()
end

function var_0_1.onExit(arg_9_0)
	for iter_9_0 = 1, #arg_9_0._listeners do
		lc.Dispatcher:removeEventListener(arg_9_0._listeners[iter_9_0])
	end

	arg_9_0:unscheduleUpdate()
end

function var_0_1.getChapters(arg_10_0)
	if arg_10_0._chapters == nil then
		arg_10_0._chapters = arg_10_0._city:getChapters()
	end

	return arg_10_0._chapters
end

function var_0_1.getChapterTabs(arg_11_0)
	local var_11_0 = arg_11_0:getChapters()
	local var_11_1 = arg_11_0._city
	local var_11_2 = {}

	for iter_11_0 = 1, #var_11_0 do
		local var_11_3 = {
			_width = 140,
			_tag = #var_11_2 + 1,
			_labelStr = Str(STR.STORY_LINE + #var_11_2),
			_handler = function(arg_12_0)
				arg_11_0:showTab(arg_12_0)
			end,
			_checkHandler = function(arg_13_0, arg_13_1)
				return arg_11_0:checkShowTab(arg_13_0, arg_13_1)
			end
		}

		if var_11_1:getType() ~= Data.CityType.small then
			var_11_3._spriteFrame = iter_11_0 < var_11_1._chapter and "world_city_star_focus3" or "world_city_star_unfocus2"
		end

		if iter_11_0 == 1 then
			var_11_3._left = 16
		end

		table.insert(var_11_2, var_11_3)
	end

	return var_11_2
end

function var_0_1.createConditionArea(arg_14_0, arg_14_1)
	local var_14_0 = lc.w(arg_14_0._contentBg) - var_0_0.CONTENT_MARGIN_H
	local var_14_1 = 150
	local var_14_2 = lc.createNode(cc.size(var_14_0, var_14_1))
	local var_14_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.PASS_CONDITION))

	lc.addChildToPos(var_14_2, var_14_3, cc.p(var_0_0.CONTENT_MARGIN_LEFT + lc.w(var_14_3) / 2, var_14_1 - lc.h(var_14_3) / 2))

	arg_14_0._conditionTitle = var_14_3
	arg_14_0._conditionList = {}
	arg_14_0._conditionArea = var_14_2

	return var_14_2
end

function var_0_1.createButtonClipArea(arg_15_0)
	local var_15_0 = lc.w(arg_15_0._buttonArea)
	local var_15_1 = lc.h(arg_15_0._buttonArea)
	local var_15_2 = ccui.Layout:create()

	var_15_2:setContentSize(var_15_0, var_15_1)
	var_15_2:setAnchorPoint(0.5, 0.5)
	var_15_2:setPosition(arg_15_0._buttonArea:getPosition())
	var_15_2:setClippingEnabled(true)
	arg_15_0._buttonArea:setContentSize(var_15_0 * 2, var_15_1)
	arg_15_0._buttonArea:setPosition(var_15_0, var_15_1 / 2)
	var_15_2:addChild(arg_15_0._buttonArea)
	arg_15_0:createButtons()

	if arg_15_0._city._status ~= arg_15_0._city.Status.user then
		arg_15_0:createArrows()
	end

	return var_15_2
end

function var_0_1.createButtons(arg_16_0)
	local var_16_0 = lc.w(arg_16_0._buttonArea) / 2
	local var_16_1 = 148
	local var_16_2 = ClientView.CRECT_BUTTON.height
	local var_16_3 = cc.rect(0, 0, var_16_1, var_16_2 + 40)
	local var_16_4 = ClientView.COLOR_RES_LABEL_BG_LIGHT
	local var_16_5 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_17_0)
		arg_16_0:onSelectTroop()
	end, ClientView.CRECT_BUTTON, var_16_1)

	var_16_5:addLabel("")
	var_16_5:setTouchRect(var_16_3)
	lc.addChildToPos(arg_16_0._buttonArea, var_16_5, cc.p(var_16_0 / 2 - 10 - lc.w(var_16_5) / 2, var_16_2 / 2))

	arg_16_0._btnTroop = var_16_5
	arg_16_0._labelAttack = ClientView.addIconValue(arg_16_0._buttonArea, "img_icon_power", "00000", lc.x(arg_16_0._btnTroop) - 48, lc.top(arg_16_0._btnTroop) + 24)

	arg_16_0._labelAttack:setColor(ClientView.COLOR_TEXT_DARK)

	local var_16_6 = ClientView.createResConsumeButtonArea(var_16_1, "img_icon_res2_s", var_16_4, nil, Str(STR.CAPTURE))

	lc.addChildToPos(arg_16_0._buttonArea, var_16_6, cc.p(var_16_0 / 2 + 10 + lc.w(var_16_5) / 2, lc.h(var_16_6) / 2))

	function var_16_6._btn._callback()
		arg_16_0:onAttack()
	end

	var_16_6._btn:setTouchRect(var_16_3)

	arg_16_0._costLabel = var_16_6._resLabel
	arg_16_0._btnAttack = var_16_6._btn

	if arg_16_0._city._status == arg_16_0._city.Status.user and (arg_16_0._city._ownerType == SglMsg_pb.PB_USER_PLAYER or arg_16_0._city._ownerType == SglMsg_pb.PB_USER_NPC) then
		var_16_6._btn._label:setString(Str(STR.REVENGE))
		var_16_6._resArea:setVisible(false)
	end

	local var_16_7 = ClientView.createResConsumeButtonArea(var_16_1, ClientData.getPropIconName(Data.PropsId.sweep_card), var_16_4, nil, string.format(Str(STR.SWEEP_TIMES), 1))

	lc.addChildToPos(arg_16_0._buttonArea, var_16_7, cc.p(lc.x(var_16_5) + var_16_0, lc.h(var_16_7) / 2))

	function var_16_7._btn._callback()
		arg_16_0:onSweep(1, true)
	end

	var_16_7._btn:setTouchRect(var_16_3)

	arg_16_0._sweepOnceLabel = var_16_7._resLabel

	local var_16_8 = ClientView.createResConsumeButtonArea(var_16_1, ClientData.getPropIconName(Data.PropsId.sweep_card), var_16_4, nil, string.format(Str(STR.SWEEP_TIMES), 5))

	lc.addChildToPos(arg_16_0._buttonArea, var_16_8, cc.p(lc.x(var_16_6) + var_16_0, lc.h(var_16_8) / 2))

	function var_16_8._btn._callback()
		arg_16_0:onSweep(5, true)
	end

	var_16_8._btn:setTouchRect(var_16_3)

	arg_16_0._sweepMultiLabel = var_16_8._resLabel
end

function var_0_1.createArrows(arg_21_0)
	local var_21_0 = lc.w(arg_21_0._buttonArea) / 2
	local var_21_1 = cc.size(60, lc.h(arg_21_0._buttonArea))
	local var_21_2 = ClientView.createArrowButton(false, var_21_1, function(arg_22_0)
		arg_21_0:onArrow(arg_22_0)
	end)

	lc.addChildToPos(arg_21_0._buttonArea, var_21_2, cc.p(var_21_0 - lc.w(var_21_2) / 2, lc.h(arg_21_0._buttonArea) / 2))

	local var_21_3 = ClientView.createArrowButton(true, var_21_1, function(arg_23_0)
		arg_21_0:onArrow(arg_23_0)
	end)

	lc.addChildToPos(arg_21_0._buttonArea, var_21_3, cc.p(var_21_0 + lc.w(var_21_3) / 2, lc.h(arg_21_0._buttonArea) / 2))

	arg_21_0._btnArrowLeft = var_21_3
	arg_21_0._btnArrowRight = var_21_2
end

function var_0_1.updateCityUser(arg_24_0)
	arg_24_0._playerArea:setVisible(true)
	arg_24_0._troopArea:setVisible(true)
	arg_24_0._dropArea:setVisible(true)
	arg_24_0._buttonArea:setVisible(true)
	arg_24_0._userArea:setUser(arg_24_0._city._cityUser._userInfo, true)
	arg_24_0:updateInfo()

	if arg_24_0._dividingLine == nil then
		arg_24_0:addDividingLine(0)
		arg_24_0._dividingLine:setPositionY(lc.top(arg_24_0._buttonArea:getParent()) + 10)
	end

	arg_24_0:updateUnionHelp()
end

function var_0_1.updateInfo(arg_25_0)
	local var_25_0 = {}

	if arg_25_0._city._status ~= arg_25_0._city.Status.user then
		var_25_0 = arg_25_0:getChapters()[arg_25_0._tabs[arg_25_0._focusTabIndex]._tag]:getTroopCards()
	else
		var_25_0 = arg_25_0._city._cityUser:getTroopCards()

		if arg_25_0._city._ownerType == SglMsg_pb.PB_USER_PLAYER then
			local var_25_1 = ClientView.createLabelProgressBar(250, ClientView.BMFont.huali_26)

			var_25_1._label:setScale(0.8)
			var_25_1:registerScriptHandler(function(arg_26_0)
				if arg_26_0 == "enter" then
					var_25_1:scheduleUpdateWithPriorityLua(function(arg_27_0)
						local var_27_0 = Data._globalInfo._cityLoseTime * 3600
						local var_27_1 = arg_25_0._city._timestamp + var_27_0 - ClientData.getCurrentTime()

						if var_27_1 < 0 then
							var_25_1:removeFromParent()
						else
							var_25_1._bar:setPercent((var_27_0 - var_27_1) * 100 / var_27_0)
							var_25_1:setLabel(ClientData.formatPeriod(var_27_1) .. Str(STR.LEAVE_AFTER))
						end
					end, 0)
				end
			end)
			lc.addChildToPos(arg_25_0._playerArea, var_25_1, cc.p(lc.w(arg_25_0._playerArea) - lc.w(var_25_1) / 2 - 20, lc.h(arg_25_0._playerArea) - lc.h(var_25_1) / 2), 1)
		end
	end

	ClientData.sortTroopCards(var_25_0)
	arg_25_0:updateTroopArea(arg_25_0._troopArea, var_25_0)

	local var_25_2 = {}

	if arg_25_0._city._status ~= arg_25_0._city.Status.user then
		local var_25_3 = arg_25_0:getChapters()[arg_25_0._tabs[arg_25_0._focusTabIndex]._tag]

		if arg_25_0._city:getType() == Data.CityType.small or arg_25_0._city._chapter <= arg_25_0._focusTabIndex then
			var_25_2 = var_25_3:getDrops(true)

			arg_25_0._dropTitle:setString(Str(STR.FIRST) .. Str(STR.PASS_BONUS))
		else
			var_25_2 = var_25_3:getDrops(false)
		end

		arg_25_0:updateDropArea(var_25_2)
	else
		arg_25_0._dropArea:setVisible(false)
	end

	if arg_25_0._conditionArea then
		arg_25_0:updateConditionArea()
	end

	arg_25_0:updateMyAttackValue()

	if arg_25_0._city._status ~= arg_25_0._city.Status.user then
		arg_25_0:updateRaidCountAndUiAround()
		arg_25_0:updateArrow()
	else
		arg_25_0:updateCostLabel(P:getBattleCost())
	end
end

function var_0_1.updateConditionArea(arg_28_0)
	if arg_28_0._conditionList == nil then
		return
	end

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._conditionList) do
		iter_28_1._num:removeFromParent()
		iter_28_1:removeFromParent()
	end

	arg_28_0._conditionList = {}

	local var_28_0 = arg_28_0:getChapters()[arg_28_0._tabs[arg_28_0._focusTabIndex]._tag]
	local var_28_1 = var_28_0:getConditions()
	local var_28_2 = lc.bottom(arg_28_0._conditionTitle) - 6

	for iter_28_2 = 1, #var_28_1 do
		local var_28_3 = var_28_1[iter_28_2]
		local var_28_4 = var_28_0._chapterInfo._value[iter_28_2]
		local var_28_5 = ""

		if var_28_3._id == 13 then
			local var_28_6 = Data._monsterInfo[var_28_4] or Data._bookInfo[var_28_4] or Data._horseInfo[var_28_4]

			var_28_5 = Str(var_28_6._nameSid)
		elseif var_28_3._id == 14 then
			var_28_5 = Str(Data._eventInfo[var_28_4]._nameSid)
		else
			var_28_5 = string.format("%d", var_28_4)
		end

		local var_28_7 = cc.Label:createWithTTF(string.format(Str(STR.BRACKETS_D), iter_28_2), ClientView.TTF_FONT, ClientView.FontSize.S2)

		var_28_7:setColor(ClientView.COLOR_LABEL_DARK)
		lc.addChildToPos(arg_28_0._conditionArea, var_28_7, cc.p(var_0_0.CONTENT_MARGIN_LEFT + 5 + lc.w(var_28_7) / 2, var_28_2 - lc.h(var_28_7) / 2))

		local var_28_8 = string.gsub(Str(var_28_3._descSid), "%[.+%]", var_28_5)
		local var_28_9 = cc.Label:createWithTTF(var_28_8, ClientView.TTF_FONT, ClientView.FontSize.S2)

		var_28_9:setColor(ClientView.COLOR_TEXT_DARK)
		lc.addChildToPos(arg_28_0._conditionArea, var_28_9, cc.p(lc.right(var_28_7) + 4 + lc.w(var_28_9) / 2, lc.y(var_28_7)))

		var_28_9._num = var_28_7
		var_28_9._conditionId = var_28_3._id
		var_28_9._conditionValue = var_28_4

		table.insert(arg_28_0._conditionList, var_28_9)

		var_28_2 = var_28_2 - lc.h(var_28_9) - 6

		if not P:preCheckCondition(var_28_9._conditionId, var_28_9._conditionValue, P._curTroopIndex) then
			var_28_9:setColor(lc.Color3B.red)
		end
	end
end

function var_0_1.updateMyAttackValue(arg_29_0)
	arg_29_0._labelAttack:setString(string.format("%d", P._playerCard:getTroopFightingValue(P._curTroopIndex)))
end

function var_0_1.updateRaidCountAndUiAround(arg_30_0)
	local var_30_0 = arg_30_0._city
	local var_30_1 = var_30_0:getType() == Data.CityType.small and var_30_0._chapter or arg_30_0._tabs[arg_30_0._focusTabIndex]._tag

	if var_30_0:getType() ~= Data.CityType.small and var_30_0._status == var_30_0.Status.self then
		if var_30_1 < var_30_0._chapter then
			if arg_30_0._labelSweepCount == nil then
				local var_30_2 = ClientView.createKeyValueLabel(Str(STR.REMAIN_TIMES), "0 / 0", ClientView.FontSize.S2, false)
				local var_30_3 = lc.h(arg_30_0._buttonArea)

				var_30_2:addToParent(arg_30_0._contentBg, cc.p((lc.w(arg_30_0._contentBg) - var_30_2:getTotalWidth()) / 2, var_30_3 + var_0_0.CONTENT_MARGIN_BOTTOM + 6 + lc.h(var_30_2) / 2))

				arg_30_0._labelSweepCount = var_30_2
			end
		elseif arg_30_0._labelSweepCount then
			arg_30_0._labelSweepCount:removeFromParent()

			arg_30_0._labelSweepCount = nil
		end
	end

	if arg_30_0._dividingLine == nil then
		arg_30_0:addDividingLine(0)
	end

	if arg_30_0._labelSweepCount then
		arg_30_0._labelSweepCount._value:setString(string.format("%d / %d", arg_30_0._city._raidTimes[arg_30_0._tabs[arg_30_0._focusTabIndex]._tag], Data._globalInfo._dailySweepCount))
		arg_30_0._dividingLine:setPositionY(lc.top(arg_30_0._labelSweepCount) + 10)
	else
		arg_30_0._dividingLine:setPositionY(lc.top(arg_30_0._buttonArea:getParent()) + 10)
	end

	if arg_30_0._btnRank == nil then
		arg_30_0._btnRank = (function(arg_31_0, arg_31_1)
			local var_31_0 = cc.rect(ClientView.CRECT_COM_BG5.x, 0, ClientView.CRECT_COM_BG5.width, lc.frameSize("img_com_bg_5").height)
			local var_31_1 = ClientView.createScale9ShaderButton("img_com_bg_5", arg_31_1, var_31_0, 100)

			if arg_31_0 then
				var_31_1:addLabel(arg_31_0)
			end

			return var_31_1
		end)(Str(STR.CITY_STRATEGY))

		lc.addChildToPos(arg_30_0._contentBg, arg_30_0._btnRank, cc.p(lc.w(arg_30_0._contentBg) - var_0_1.CONTENT_MARGIN_RIGHT * 2 - lc.w(arg_30_0._btnRank) / 2, 0))
	end

	local var_30_4 = lc.top(arg_30_0._dividingLine) + lc.h(arg_30_0._btnRank) / 2 + 4
	local var_30_5 = var_30_0._status ~= var_30_0.Status.user

	arg_30_0._btnRank:setPositionY(var_30_4)
	arg_30_0._btnRank:setVisible(var_30_5)

	function arg_30_0._btnRank._callback()
		require("ChapterRankForm").create(var_30_0._chapterIds[var_30_1]):show()
	end

	local var_30_6 = var_30_0:getChapterIds()[var_30_1]

	arg_30_0:updateCostLabel(P:getBattleCost(nil, nil, var_30_6))
	arg_30_0:updateSweepCardLabels()
end

function var_0_1.updateCostLabel(arg_33_0, arg_33_1)
	arg_33_1 = arg_33_1 or arg_33_0._costLabel._cost
	arg_33_0._costLabel._cost = arg_33_1

	arg_33_0._costLabel:setString(arg_33_1)
	arg_33_0._costLabel:setColor(arg_33_1 > P._grain and lc.Color3B.red or lc.Color3B.white)
end

function var_0_1.updateArrow(arg_34_0)
	local var_34_0 = false

	if arg_34_0._tabs then
		local var_34_1 = arg_34_0._tabs[arg_34_0._focusTabIndex]._tag

		var_34_0 = arg_34_0._city:getType() ~= Data.CityType.small and var_34_1 < arg_34_0._city._chapter
	end

	if var_34_0 then
		arg_34_0:onArrow(arg_34_0._btnArrowRight)
		arg_34_0._btnArrowRight:setVisible(true)
	else
		arg_34_0:onArrow(arg_34_0._btnArrowLeft)
		arg_34_0._btnArrowRight:setVisible(false)
	end
end

function var_0_1.updateSweepCardLabels(arg_35_0)
	local var_35_0 = P._propBag._props[Data.PropsId.sweep_card]._num

	arg_35_0._sweepOnceLabel:setString(string.format("%d/1", var_35_0))
	arg_35_0._sweepOnceLabel:setColor(var_35_0 < 1 and lc.Color3B.red or lc.Color3B.white)

	local var_35_1 = Data._globalInfo._dailySweepCount

	arg_35_0._sweepMultiLabel:setString(string.format("%d", var_35_1))
	arg_35_0._sweepMultiLabel:setColor(var_35_0 < var_35_1 and lc.Color3B.red or lc.Color3B.white)
end

function var_0_1.updateUnionHelp(arg_36_0)
	if arg_36_0._btnNeedHelp then
		arg_36_0._btnNeedHelp:removeFromParent()

		arg_36_0._btnNeedHelp = nil
	end

	if arg_36_0._needHelpCD then
		arg_36_0._needHelpCD:removeFromParent()

		arg_36_0._needHelpCD = nil
	end

	arg_36_0:unscheduleUpdate()

	if arg_36_0._city._status == arg_36_0._city.Status.user and arg_36_0._city._ownerType == SglMsg_pb.PB_USER_PLAYER then
		local var_36_0 = ClientView.createScale9ShaderButton("img_btn_1", function()
			if not P:hasUnion() then
				ToastManager.push(Str(STR.UNION_HELP_TIP))

				return
			end

			if math.ceil(P._nextCityHelp - ClientData.getCurrentTime()) > 0 then
				ToastManager.push(Str(STR.NEED_UNION_HELP_INVALID))
			else
				arg_36_0:selectUnionMembers()
			end
		end, ClientView.CRECT_BUTTON, 180)

		var_36_0:addLabel(Str(STR.NEED_UNION_HELP))
		lc.addChildToPos(arg_36_0._contentBg, var_36_0, cc.p(lc.w(arg_36_0._contentBg) / 2, lc.top(arg_36_0._dividingLine) + 10 + lc.h(var_36_0) / 2))

		arg_36_0._btnNeedHelp = var_36_0

		if math.ceil(P._nextCityHelp - ClientData.getCurrentTime()) > 0 then
			local var_36_1 = ClientView.createTTF("", nil, ClientView.COLOR_LABEL_DARK)

			lc.addChildToPos(arg_36_0._contentBg, var_36_1, cc.p(lc.x(var_36_0), lc.top(var_36_0) + 18))

			arg_36_0._needHelpCD = var_36_1

			arg_36_0:scheduleUpdateWithPriorityLua(function()
				local var_38_0 = math.ceil(P._nextCityHelp - ClientData.getCurrentTime())

				if var_38_0 > 0 then
					var_36_1:setString(string.format(Str(STR.NEED_UNION_HELP_CD), ClientData.formatPeriod(var_38_0)))
				else
					arg_36_0:unscheduleUpdate()
					arg_36_0._needHelpCD:removeFromParent()

					arg_36_0._needHelpCD = nil
				end
			end, 0)
		end
	end
end

function var_0_1.checkShowTab(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0._city

	if arg_39_1 == 2 or arg_39_1 == 3 then
		local var_39_1 = var_39_0:getChapterDepends(arg_39_1)
		local var_39_2 = {
			Str(STR.STORY_LINE),
			Str(STR.REBEL),
			Str(STR.CHAOS)
		}

		local function var_39_3(arg_40_0)
			local var_40_0 = arg_40_0._city

			if var_40_0 then
				if var_40_0._regionId == var_39_0._regionId then
					return string.format(Str(STR.CHAPTER_MODE_LOCK1), Str(var_40_0._info._nameSid) .. Str(STR.DOT) .. var_39_2[arg_40_0._chapter])
				else
					return string.format(Str(STR.CHAPTER_MODE_LOCK2), var_40_0._regionId, Str(STR.BATTLE_NAME_01 + var_40_0._regionId - 1) .. Str(STR.DOT) .. var_39_2[arg_40_0._chapter])
				end
			else
				return string.format(Str(STR.CHAPTER_MODE_LOCK1), var_39_2[arg_40_0._chapter])
			end
		end

		local var_39_4 = #var_39_1

		if var_39_4 > 0 then
			if arg_39_2 then
				ToastManager.push(var_39_3(var_39_1[var_39_4]))
			end

			return false
		end
	end

	return true
end

function var_0_1.showTab(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_0._tabs == nil then
		return
	end

	if arg_41_1 > #arg_41_0._tabs then
		arg_41_1 = 1
	end

	if arg_41_0._focusTabIndex == arg_41_1 and not arg_41_2 then
		return
	end

	arg_41_0._focusTabIndex = arg_41_1

	arg_41_0:updateInfo()
end

function var_0_1.selectUnionMembers(arg_42_0)
	local var_42_0 = arg_42_0._city._infoId
	local var_42_1 = require("UnionMemberForm").createSelect(3, function(arg_43_0)
		if arg_43_0._selCount == 0 then
			ToastManager.push(Str(STR.NEED_UNION_HELP_AT_LEAST))
		else
			local var_43_0 = arg_43_0._iptMsg:getText()
			local var_43_1 = ClientData.MAX_INPUT_LEN - 10

			if var_43_1 < lc.utf8len(var_43_0) then
				ToastManager.push(Str(STR.MESSAGE) .. string.format(Str(STR.CANNOT_MORE_THAN), var_43_1))

				return
			end

			local var_43_2 = P._playerUnion:getMyUnion():getMembers()

			P._nextCityHelp = ClientData.getCurrentTime() + Data._globalInfo._sosCD * 3600

			ClientData.sendWorldCitySos(var_42_0, var_43_2, var_43_0)
			ToastManager.push(Str(STR.NEED_UNION_HELP_SENT))
			arg_43_0:hide()

			if arg_42_0.updateUnionHelp then
				arg_42_0:updateUnionHelp()
			end
		end
	end)
	local var_42_2 = var_42_1._bottomArea
	local var_42_3 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(774, 56), nil, true)

	var_42_3:setText(Str(STR.NEED_UNION_HELP_TIP))
	lc.addChildToPos(var_42_2, var_42_3, cc.p(12 + lc.w(var_42_3) / 2, lc.h(var_42_2) / 2))

	var_42_1._iptMsg = var_42_3

	var_42_2._btnOk._label:setString(Str(STR.SEND))
	var_42_1:show()
end

function var_0_1.onArrow(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1 == arg_44_0._btnArrowLeft

	arg_44_0._buttonArea:stopAllActions()

	if var_44_0 then
		arg_44_0._buttonArea:runAction(lc.moveTo(0.3, cc.p(lc.w(arg_44_0._buttonArea) / 2, lc.y(arg_44_0._buttonArea))))
	else
		arg_44_0._buttonArea:runAction(lc.moveTo(0.3, cc.p(0, lc.y(arg_44_0._buttonArea))))
	end

	if arg_44_0._conditionArea then
		arg_44_0._conditionArea:setVisible(var_44_0)
	end
end

function var_0_1.onSweep(arg_45_0, arg_45_1, arg_45_2)
	if P._level < 15 then
		ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), 15))

		return
	end

	if arg_45_1 > 1 and P._vip < Data._globalInfo._vipSweep then
		ToastManager.push(string.format(Str(STR.LORD_UNLOCK_VIP), Data._globalInfo._vipSweep))

		return
	end

	if not P:checkBattleCost(raidTimes, arg_45_0._city:getChapterIds()[chapter]) then
		ToastManager.push(Str(STR.NOT_ENOUGH_GRAIN), ToastManager.DURATION_LONG)
		require("ExchangeResForm").create(Data.ResType.grain):show()

		return
	end

	if not ClientView.useSweepCard(raidTimes, arg_45_2, function()
		arg_45_0:onSweep(arg_45_1)
	end) then
		return
	end

	arg_45_0._city._raidTimes[chapter] = arg_45_0._city._raidTimes[chapter] - raidTimes

	arg_45_0._city:sendCityDirty()
	arg_45_0:updateRaidCountAndUiAround()
	ClientView.getActiveIndicator():show(Str(STR.SWEEPING), nil, {
		_sweepChapter = arg_45_0._city._chapterIds[chapter]
	})

	if arg_45_1 == 1 then
		ClientData.sendLevelSweepOnce(arg_45_0._city._infoId, chapter)
	else
		ClientData.sendLevelSweep(arg_45_0._city._infoId, chapter)
	end
end

function var_0_1.onSelectTroop(arg_47_0)
	lc.pushScene(require("HeroCenterScene").create())
end

function var_0_1.onScoutAgain(arg_48_0)
	local var_48_0 = arg_48_0._tabs[arg_48_0._focusTabIndex]._tag

	if arg_48_0._city._raidTimes[var_48_0] == 0 then
		require("Dialog").showDialog(string.format(Str(STR.RAIDS_TIMES_NOT_ENOUGH), arg_48_0._city:getBuySweepIngot(var_48_0), Data._globalInfo._dailySweepCount), function()
			if arg_48_0:onBuyRaidTimes() then
				arg_48_0:onScoutAgain()
			end
		end)

		return
	end

	local var_48_1, var_48_2 = P._playerCard:checkTroop(P._curTroopIndex)

	if not var_48_1 then
		ToastManager.push(var_48_2)

		return
	end

	if not P:checkBattleCost(nil, arg_48_0._city:getChapterIds()[var_48_0]) then
		ToastManager.push(Str(STR.NOT_ENOUGH_GRAIN), ToastManager.DURATION_LONG)
		require("ExchangeResForm").create(Data.ResType.grain):show()

		return
	end

	arg_48_0:updateRaidCountAndUiAround()
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendWorldChallenge(P._curTroopIndex, arg_48_0._city._infoId, var_48_0)

	ClientData._chapterId = var_48_0

	arg_48_0:hide()
end

function var_0_1.onAttack(arg_50_0)
	if arg_50_0._btnArrowRight and arg_50_0._btnArrowRight:isVisible() then
		return arg_50_0:onScoutAgain()
	end

	local var_50_0, var_50_1 = P._playerCard:checkTroop(P._curTroopIndex)

	if not var_50_0 then
		ToastManager.push(var_50_1)

		return
	end

	local var_50_2
	local var_50_3

	if arg_50_0._city._status ~= arg_50_0._city.Status.user then
		local var_50_4 = arg_50_0._tabs[arg_50_0._focusTabIndex]._tag

		var_50_2 = arg_50_0._city:getChapterIds()[var_50_4]
		var_50_3 = true
	end

	if var_50_3 and not P:checkBattleCost(nil, var_50_2) then
		ToastManager.push(Str(STR.NOT_ENOUGH_GRAIN), ToastManager.DURATION_LONG)
		require("ExchangeResForm").create(Data.ResType.grain):show()

		return
	end

	arg_50_0:hide()
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendWorldAttack(P._curTroopIndex, arg_50_0._city._infoId)

	if GuideManager.getCurStepName() == "attack city" then
		GuideManager.finishStep(true)
	end
end

function var_0_1.onBuyRaidTimes(arg_51_0)
	if not arg_51_0._city:isResetSweepValid(arg_51_0._focusTabIndex) then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH_BUY_TIMES), Str(STR.BUY) .. Str(STR.ATTACK_TIMES)))

		return false
	end

	if not ClientView.checkIngot(arg_51_0._city:getBuySweepIngot(arg_51_0._tabs[arg_51_0._focusTabIndex]._tag)) then
		return false
	end

	P:changeResource(Data.ResType.ingot, -arg_51_0._city:getBuySweepIngot(arg_51_0._tabs[arg_51_0._focusTabIndex]._tag))

	arg_51_0._city._raidTimes[arg_51_0._tabs[arg_51_0._focusTabIndex]._tag] = arg_51_0._city._raidTimes[arg_51_0._tabs[arg_51_0._focusTabIndex]._tag] + Data._globalInfo._dailySweepCount
	arg_51_0._city._dailyResetSweep[arg_51_0._tabs[arg_51_0._focusTabIndex]._tag] = arg_51_0._city._dailyResetSweep[arg_51_0._tabs[arg_51_0._focusTabIndex]._tag] + 1

	arg_51_0:updateRaidCountAndUiAround()
	ClientData.sendWorldBuyRaidTimes(arg_51_0._city._infoId, arg_51_0._tabs[arg_51_0._focusTabIndex]._tag)

	return true
end

function var_0_1.onGuide(arg_52_0, arg_52_1)
	if GuideManager.getCurStepName() == "attack city" then
		if P._playerWorld._chapter == 0 then
			lc.log("Level Start [CHAPTER_001]")
		end

		GuideManager.setOperateLayer(arg_52_0._btnAttack)
	else
		return
	end

	arg_52_1:stopPropagation()
end

return var_0_1
