local var_0_0 = class("LevelForm", BaseForm)
local var_0_1 = cc.size(758, 670)
local var_0_2 = var_0_0.LEFT_MARGIN + 40
local var_0_3 = var_0_0.TOP_MARGIN + 40
local var_0_4 = 40
local var_0_5 = 16
local var_0_6 = 16
local var_0_7 = 20
local var_0_8 = 20
local var_0_9 = 170
local var_0_10 = 100

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, Str(arg_2_1._nameSid), bor(BaseForm.FLAG.PAPER_BG, BaseForm.FLAG.TTF_TITLE))

	arg_2_0._levelInfo = arg_2_1
	arg_2_0._troopArea = arg_2_0:createTroopArea(Str(STR.DEF_TROOP))

	local var_2_0 = lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - 50
	local var_2_1 = arg_2_0:addArea(arg_2_0._troopArea, var_2_0)

	arg_2_0:addDividingLine(var_2_1)

	local var_2_2 = var_2_1 - 16
	local var_2_3 = arg_2_0:addArea(arg_2_0:createDropArea(), var_2_2)

	arg_2_0:addDividingLine(var_2_3)

	local var_2_4 = var_2_3 - 16
	local var_2_5 = arg_2_0:addArea(arg_2_0:createConditionArea(), var_2_4)

	arg_2_0:addDividingLine(var_2_5)

	local var_2_6 = var_2_5 - 16

	arg_2_0:createButtonArea()
	arg_2_0:addArea(arg_2_0:createButtonClipArea())
	arg_2_0:updateRaidCountAndUiAround()
	arg_2_0:updateInfo()
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	local var_3_0 = {}

	table.insert(var_3_0, lc.addEventListener(GuideManager.Event.seek, function(arg_4_0)
		arg_3_0:onGuide(arg_4_0)
	end))
	table.insert(var_3_0, lc.addEventListener(Data.Event.prop_dirty, function(arg_5_0)
		if arg_5_0._data._infoId == Data.PropsId.sweep_card then
			arg_3_0:updateSweepCardLabels()
		end
	end))

	arg_3_0._listeners = var_3_0

	if arg_3_0._btnTroop then
		arg_3_0._btnTroop._label:setString(string.format("%s %d", Str(STR.TROOP), P._curTroopIndex))
	end

	if arg_3_0._conditionList then
		for iter_3_0 = 1, #arg_3_0._conditionList do
			local var_3_1 = arg_3_0._conditionList[iter_3_0]

			if P:preCheckCondition(var_3_1._conditionId, var_3_1._conditionValue, P._curTroopIndex) then
				var_3_1:setColor(ClientView.COLOR_TEXT_LIGHT)
			else
				var_3_1:setColor(lc.Color3B.red)
			end
		end
	end

	arg_3_0:updateMyAttackValue()
end

function var_0_0.onExit(arg_6_0)
	var_0_0.super.onExit(arg_6_0)

	for iter_6_0 = 1, #arg_6_0._listeners do
		lc.Dispatcher:removeEventListener(arg_6_0._listeners[iter_6_0])
	end

	arg_6_0:unscheduleUpdate()
end

function var_0_0.addArea(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 then
		lc.addChildToPos(arg_7_0._frame, arg_7_1, cc.p(lc.w(arg_7_0._frame) / 2, arg_7_2 - lc.h(arg_7_1) / 2))

		return arg_7_2 - lc.h(arg_7_1) - var_0_8
	else
		arg_7_0._frame:addChild(arg_7_1)
	end
end

function var_0_0.createTroopArea(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = lc.w(arg_8_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT

	arg_8_2 = arg_8_2 or 142

	local var_8_1 = arg_8_2 > 142
	local var_8_2 = lc.createNode(cc.size(var_8_0, arg_8_2))
	local var_8_3 = lc.createSprite({
		_name = "img_com_bg_5",
		_crect = ClientView.CRECT_COM_BG5,
		_size = cc.size(90, 46)
	})

	lc.addChildToPos(var_8_2, var_8_3, cc.p(lc.w(var_8_2) - lc.w(var_8_3) / 2 - 8, arg_8_2 - lc.h(var_8_3) / 2 + 12))

	local var_8_4 = lc.createSprite("img_icon_cardnum")

	var_8_4:setScale(0.6)
	lc.addChildToPos(var_8_3, var_8_4, cc.p(24, lc.h(var_8_3) / 2 + 2))

	var_8_2._cardNumLabel = ClientView.createBMFont(ClientView.BMFont.huali_26, "0")

	lc.addChildToPos(var_8_3, var_8_2._cardNumLabel, cc.p(60, lc.h(var_8_3) / 2 + 2))

	local var_8_5 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_8_1)

	lc.addChildToPos(var_8_2, var_8_5, cc.p(var_0_5 + lc.w(var_8_5) / 2, arg_8_2 - lc.h(var_8_5) / 2))

	local var_8_6

	if var_8_1 then
		var_8_6 = lc.List.createV(cc.size(var_8_0, arg_8_2 - 36), 6, 2)

		local var_8_7 = lc.createSprite("img_gradient_border")

		var_8_7:setScaleX(var_8_0 / lc.w(var_8_7))
		var_8_7:setColor(cc.c3b(222, 210, 182))
		lc.addChildToPos(var_8_2, var_8_7, cc.p(var_8_0 / 2, lc.h(var_8_6) - 5), 1)

		local var_8_8 = lc.createSprite("img_gradient_border")

		var_8_8:setScaleX(var_8_0 / lc.w(var_8_8))
		var_8_8:setFlippedY(true)
		var_8_8:setColor(cc.c3b(222, 210, 182))
		lc.addChildToPos(var_8_2, var_8_8, cc.p(var_8_0 / 2, 5), 1)
	else
		var_8_6 = lc.List.createH(cc.size(var_8_0, 110), var_0_5, 10)
	end

	lc.addChildToPos(var_8_2, var_8_6, cc.p(0, 0))

	var_8_2._list = var_8_6
	var_8_6._isMultiLine = var_8_1

	return var_8_2
end

function var_0_0.createDropArea(arg_9_0, arg_9_1)
	local var_9_0 = lc.w(arg_9_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT
	local var_9_1 = 140
	local var_9_2 = lc.createNode(cc.size(var_9_0, var_9_1))
	local var_9_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.MAYBE) .. Str(STR.GET))

	var_9_3:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_9_2, var_9_3, cc.p(var_0_5, var_9_1 - lc.h(var_9_3) / 2))

	local var_9_4 = lc.List.createH(cc.size(var_9_0, 110), var_0_5, 10)

	lc.addChildToPos(var_9_2, var_9_4, cc.p(0, 0))

	arg_9_0._dropList = var_9_4
	arg_9_0._dropArea = var_9_2
	arg_9_0._dropTitle = var_9_3

	return var_9_2
end

function var_0_0.addDividingLine(arg_10_0, arg_10_1)
	local var_10_0 = ClientView.createDividingLine(lc.w(arg_10_0._frame) - var_0_4 - 16, ClientView.COLOR_DIVIDING_LINE_LIGHT)

	lc.addChildToPos(arg_10_0._frame, var_10_0, cc.p(lc.w(arg_10_0._frame) / 2, arg_10_1))

	arg_10_0._dividingLine = var_10_0
end

function var_0_0.createButtonArea(arg_11_0)
	local var_11_0 = lc.w(arg_11_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT
	local var_11_1 = 180
	local var_11_2 = ccui.Layout:create()

	var_11_2:setContentSize(var_11_0, var_11_1)
	var_11_2:setAnchorPoint(0.5, 0.5)
	var_11_2:setPosition(lc.w(arg_11_0._frame) / 2, var_0_7 + var_11_1 / 2 + 16)

	arg_11_0._buttonArea = var_11_2

	return var_11_2
end

function var_0_0.updateTroopArea(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1._list
	local var_12_1 = arg_12_1._list._isMultiLine

	var_12_0:removeAllChildren()

	local var_12_2 = 0
	local var_12_3 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
		local var_12_4 = IconWidget.create({
			_infoId = iter_12_1._infoId,
			_num = iter_12_1._num,
			_cardList = arg_12_2,
			_index = iter_12_0,
			_title = Str(STR.DEF_TROOP)
		}, IconWidget.DisplayFlag.CARD_TROOP)

		if iter_12_1._isDead then
			var_12_4:setGray(true)
		else
			var_12_2 = var_12_2 + iter_12_1._num
		end

		table.insert(var_12_3, var_12_4)
	end

	if var_12_1 then
		local var_12_5 = 100
		local var_12_6 = IconWidget.SIZE / 2 + 16
		local var_12_7 = var_12_5 / 2
		local var_12_8

		for iter_12_2, iter_12_3 in ipairs(var_12_3) do
			if var_12_8 == nil then
				var_12_8 = ccui.Widget:create()

				var_12_8:setContentSize(lc.w(var_12_0), var_12_5)
			end

			lc.addChildToPos(var_12_8, iter_12_3, cc.p(var_12_6, var_12_7))

			if iter_12_2 % 4 == 0 then
				var_12_0:pushBackCustomItem(var_12_8)

				var_12_8 = nil
				var_12_6 = IconWidget.SIZE / 2 + 16
			else
				var_12_6 = var_12_6 + IconWidget.SIZE + 12
			end
		end

		if var_12_8 then
			var_12_0:pushBackCustomItem(var_12_8)
		end
	else
		for iter_12_4, iter_12_5 in ipairs(var_12_3) do
			var_12_0:pushBackCustomItem(iter_12_5)
		end
	end

	arg_12_1._cardNumLabel:setString(string.format("%d", var_12_2))
end

function var_0_0.updateDropArea(arg_13_0, arg_13_1)
	arg_13_0._dropList:removeAllItems()

	for iter_13_0 = 1, #arg_13_1 do
		local var_13_0 = arg_13_1[iter_13_0]
		local var_13_1 = IconWidget.create({
			_showOwnCount = true,
			_isFragment = false,
			_infoId = var_13_0
		}, IconWidgetFlag.ITEM_NO_NAME)

		arg_13_0._dropList:pushBackCustomItem(var_13_1)
	end
end

function var_0_0.createConditionArea(arg_14_0, arg_14_1)
	local var_14_0 = lc.w(arg_14_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT
	local var_14_1 = 80
	local var_14_2 = lc.createNode(cc.size(var_14_0, var_14_1))
	local var_14_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.PASS_CONDITION))

	lc.addChildToPos(var_14_2, var_14_3, cc.p(var_0_5 + lc.w(var_14_3) / 2, var_14_1 - lc.h(var_14_3) / 2))

	arg_14_0._conditionTitle = var_14_3
	arg_14_0._conditionList = {}
	arg_14_0._conditionArea = var_14_2

	return var_14_2
end

function var_0_0.createButtonClipArea(arg_15_0)
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

	return var_15_2
end

function var_0_0.createButtons(arg_16_0)
	local var_16_0 = lc.w(arg_16_0._buttonArea) / 2
	local var_16_1 = 148
	local var_16_2 = ClientView.CRECT_BUTTON.height
	local var_16_3 = cc.rect(0, 0, var_16_1, var_16_2 + 40)
	local var_16_4 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_17_0)
		arg_16_0:onSelectTroop()
	end, ClientView.CRECT_BUTTON, var_16_1)

	var_16_4:addLabel("")
	var_16_4:setTouchRect(var_16_3)
	lc.addChildToPos(arg_16_0._buttonArea, var_16_4, cc.p(var_16_0 / 2 - 100 - lc.w(var_16_4) / 2, var_16_2 / 2))

	arg_16_0._btnTroop = var_16_4
	arg_16_0._labelAttack, arg_16_0._iconAttack = ClientView.addIconValue(arg_16_0._buttonArea, "img_icon_power", "00000", lc.x(arg_16_0._btnTroop) - 48, lc.top(arg_16_0._btnTroop) + 24)

	arg_16_0._labelAttack:setColor(ClientView.COLOR_TEXT_LIGHT)
	arg_16_0._labelAttack:setVisible(false)
	arg_16_0._iconAttack:setVisible(false)

	local var_16_5 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_18_0)
		arg_16_0:onAttack()
	end, ClientView.CRECT_BUTTON, var_16_1)

	var_16_5:addLabel(Str(STR.CAPTURE))
	lc.addChildToPos(arg_16_0._buttonArea, var_16_5, cc.p(var_16_0 / 2 + 100 + lc.cw(var_16_5), lc.ch(var_16_5)))

	arg_16_0._btnAttack = var_16_5
end

function var_0_0.updateInfo(arg_19_0)
	local var_19_0 = arg_19_0:getTroopCards()

	ClientData.sortTroopCards(var_19_0)
	arg_19_0:updateTroopArea(arg_19_0._troopArea, var_19_0)

	local var_19_1 = arg_19_0:getDrops(true)

	arg_19_0._dropTitle:setString(Str(STR.FIRST) .. Str(STR.PASS_BONUS))
	arg_19_0:updateDropArea(var_19_1)

	if arg_19_0._conditionArea then
		arg_19_0:updateConditionArea()
	end

	arg_19_0:updateMyAttackValue()
	arg_19_0:updateRaidCountAndUiAround()
end

function var_0_0.updateConditionArea(arg_20_0)
	if arg_20_0._conditionList == nil then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._conditionList) do
		iter_20_1._num:removeFromParent()
		iter_20_1:removeFromParent()
	end

	arg_20_0._conditionList = {}

	local var_20_0 = arg_20_0:getConditions()
	local var_20_1 = lc.bottom(arg_20_0._conditionTitle) - 6

	for iter_20_2 = 1, #var_20_0 do
		local var_20_2 = var_20_0[iter_20_2]
		local var_20_3 = arg_20_0._levelInfo._value[iter_20_2]
		local var_20_4 = ""
		local var_20_5 = ""

		if var_20_2._id == 11 then
			var_20_4 = Str(STR.NATURE_NONE + var_20_3)
		elseif var_20_2._id == 13 then
			local var_20_6 = Data._monsterInfo[var_20_3] or Data._magicInfo[var_20_3] or Data._trapInfo[var_20_3]

			var_20_4 = Str(var_20_6._nameSid)
		elseif var_20_2._id == 14 then
			var_20_4 = Str(Data._eventInfo[var_20_3]._nameSid)
		elseif var_20_2._id == 29 then
			local var_20_7 = var_20_3 % 100000
			local var_20_8 = math.floor(var_20_3 / 100000)

			var_20_4 = "" .. var_20_8

			local var_20_9 = Data.getInfo(var_20_7)

			var_20_5 = Str(var_20_9._nameSid)
		else
			var_20_4 = string.format("%d", var_20_3)
		end

		local var_20_10 = cc.Label:createWithTTF(string.format(Str(STR.BRACKETS_D), iter_20_2), ClientView.TTF_FONT, ClientView.FontSize.S2)

		var_20_10:setColor(ClientView.COLOR_LABEL_LIGHT)
		lc.addChildToPos(arg_20_0._conditionArea, var_20_10, cc.p(var_0_5 + 5 + lc.w(var_20_10) / 2, var_20_1 - lc.h(var_20_10) / 2))

		local var_20_11 = string.gsub(Str(var_20_2._descSid), "%[.+%]", var_20_4) .. var_20_5
		local var_20_12 = cc.Label:createWithTTF(var_20_11, ClientView.TTF_FONT, ClientView.FontSize.S2)

		var_20_12:setColor(ClientView.COLOR_TEXT_LIGHT)
		lc.addChildToPos(arg_20_0._conditionArea, var_20_12, cc.p(lc.right(var_20_10) + 4 + lc.w(var_20_12) / 2, lc.y(var_20_10)))

		var_20_12._num = var_20_10
		var_20_12._conditionId = var_20_2._id
		var_20_12._conditionValue = var_20_3

		table.insert(arg_20_0._conditionList, var_20_12)

		var_20_1 = var_20_1 - lc.h(var_20_12) - 6

		if not P:preCheckCondition(var_20_12._conditionId, var_20_12._conditionValue, P._curTroopIndex) then
			var_20_12:setColor(lc.Color3B.red)
		end
	end
end

function var_0_0.updateMyAttackValue(arg_21_0)
	arg_21_0._labelAttack:setString(string.format("%d", P._playerCard:getTroopFightingValue(P._curTroopIndex)))
end

function var_0_0.updateRaidCountAndUiAround(arg_22_0)
	if false then
		if arg_22_0._labelSweepCount == nil then
			local var_22_0 = ClientView.createKeyValueLabel(Str(STR.REMAIN_TIMES), "0 / 0", ClientView.FontSize.S2, false)
			local var_22_1 = lc.h(arg_22_0._buttonArea)

			var_22_0:addToParent(arg_22_0._frame, cc.p((lc.w(arg_22_0._frame) - var_22_0:getTotalWidth()) / 2, var_22_1 + var_0_7 + 6 + lc.h(var_22_0) / 2))

			arg_22_0._labelSweepCount = var_22_0
		end
	elseif arg_22_0._labelSweepCount then
		arg_22_0._labelSweepCount:removeFromParent()

		arg_22_0._labelSweepCount = nil
	end

	if arg_22_0._dividingLine == nil then
		arg_22_0:addDividingLine(130)
	end

	if arg_22_0._labelSweepCount then
		arg_22_0._labelSweepCount._value:setString(string.format("%d / %d", 1, Data._globalInfo._dailySweepCount))
	end

	if arg_22_0._btnRank == nil then
		arg_22_0._btnRank = (function(arg_23_0, arg_23_1)
			local var_23_0 = cc.rect(ClientView.CRECT_COM_BG5.x, 0, ClientView.CRECT_COM_BG5.width, lc.frameSize("img_com_bg_5").height)
			local var_23_1 = ClientView.createScale9ShaderButton("img_com_bg_5", arg_23_1, var_23_0, 100)

			if arg_23_0 then
				var_23_1:addLabel(arg_23_0)
			end

			return var_23_1
		end)(Str(STR.CITY_STRATEGY))

		lc.addChildToPos(arg_22_0._frame, arg_22_0._btnRank, cc.p(lc.w(arg_22_0._frame) - var_0_6 * 2 - lc.w(arg_22_0._btnRank) / 2, 0))
	end

	local var_22_2 = lc.top(arg_22_0._dividingLine) + lc.h(arg_22_0._btnRank) / 2 + 4
	local var_22_3 = false

	arg_22_0._btnRank:setPositionY(var_22_2)
	arg_22_0._btnRank:setVisible(var_22_3)

	function arg_22_0._btnRank._callback()
		require("ChapterRankForm").create(arg_22_0._levelInfo):show()
	end
end

function var_0_0.onSelectTroop(arg_25_0)
	lc.pushScene(require("HeroCenterScene").create())
end

function var_0_0.onAttack(arg_26_0)
	local var_26_0, var_26_1 = P._playerCard:checkTroop(P._curTroopIndex)

	if not var_26_0 then
		ToastManager.push(var_26_1)

		return
	end

	if not P:checkBattleCost(nil, arg_26_0._levelInfo._id) then
		ToastManager.push(Str(STR.NOT_ENOUGH_GRAIN), ToastManager.DURATION_LONG)
		require("ExchangeResForm").create(Data.ResType.grain):show()

		return
	end

	arg_26_0:hide()
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendWorldAttack(P._curTroopIndex, arg_26_0._levelInfo._id)
	lc.UserDefault:setIntegerForKey(ClientData.ConfigKey.last_level, arg_26_0._levelInfo._id)

	if GuideManager.getCurStepName() == "click fight" then
		GuideManager.finishStep(true)
	end
end

function var_0_0.onBuyRaidTimes(arg_27_0)
	if false then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH_BUY_TIMES), Str(STR.BUY) .. Str(STR.ATTACK_TIMES)))

		return false
	end

	if false then
		return false
	end

	return true
end

function var_0_0.onGuide(arg_28_0, arg_28_1)
	if GuideManager.getCurStepName() == "click fight" then
		GuideManager.setOperateLayer(arg_28_0._btnAttack)
	else
		return
	end

	arg_28_1:stopPropagation()
end

function var_0_0.getTroopCards(arg_29_0)
	local var_29_0 = {}
	local var_29_1 = arg_29_0._levelInfo._opponentTroopID
	local var_29_2 = Data._troopInfo[var_29_1]

	for iter_29_0 = 1, #var_29_2._infoId do
		var_29_0[iter_29_0] = {
			_infoId = var_29_2._infoId[iter_29_0],
			_num = var_29_2._num[iter_29_0],
			_level = var_29_2._level[iter_29_0]
		}
	end

	return var_29_0
end

function var_0_0.getDrops(arg_30_0, arg_30_1)
	if arg_30_1 then
		return arg_30_0._levelInfo._firstPid
	else
		return arg_30_0._levelInfo._pid
	end
end

function var_0_0.getConditions(arg_31_0)
	local var_31_0 = {}
	local var_31_1 = arg_31_0._levelInfo._condition

	for iter_31_0 = 1, #var_31_1 do
		local var_31_2 = Data._conditionInfo[var_31_1[iter_31_0]]

		table.insert(var_31_0, var_31_2)
	end

	return var_31_0
end

return var_0_0
