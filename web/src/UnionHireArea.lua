local var_0_0 = class("UnionHireArea", lc.ExtendCCNode)
local var_0_1 = require("FilterWidget")
local var_0_2 = require("CardList")
local var_0_3 = require("HireHero")
local var_0_4 = 602

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(cc.size(arg_1_0, arg_1_1))
	var_1_0:init()
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0)
	ClientView.addUISceneCommonFrames(arg_3_0, lc.h(arg_3_0) - 58)
	ClientView.addVerticalTabButtons(arg_3_0, {
		Str(STR.UNION_HIRE_MY),
		Str(STR.UNION_HIRE_ALL)
	}, lc.h(arg_3_0), 16)

	local var_3_0 = ClientView.createPaperBg(cc.size(0, 0))

	arg_3_0:addChild(var_3_0)

	arg_3_0._listBg = var_3_0

	local var_3_1 = lc.createNode(cc.size(lc.w(arg_3_0) - 10, var_0_4), nil, cc.p(0, 1))

	lc.addChildToPos(arg_3_0, var_3_1, cc.p(0, lc.bottom(arg_3_0._frameTopLine) + 8))

	arg_3_0._cardArea = var_3_1
	arg_3_0._unlockVips = {}

	for iter_3_0, iter_3_1 in ipairs(Data._globalInfo._vipLetCount) do
		arg_3_0._unlockVips[iter_3_1] = iter_3_0 - 1
	end

	arg_3_0:showTab(1)
end

function var_0_0.showTab(arg_4_0, arg_4_1)
	arg_4_0._tabArea:showTab(arg_4_1)
	arg_4_0:updateTabContent()
end

function var_0_0.updateTabContent(arg_5_0)
	local var_5_0 = arg_5_0._tabArea._focusTabIndex
	local var_5_1 = arg_5_0._cardArea
	local var_5_2 = arg_5_0._listBg

	var_5_1:removeAllChildren()

	if var_5_0 == 1 then
		arg_5_0._filterWidget = nil

		local var_5_3 = cc.size(lc.w(var_5_1) + 10, var_0_4)

		var_5_2:setContentSize(cc.size(var_5_3.width + 40, var_5_3.height))

		local var_5_4 = lc.List.createH(var_5_3, 32, 14)

		arg_5_0._cardList = var_5_4

		lc.addChildToCenter(var_5_1, var_5_4)
	else
		local var_5_5 = var_0_1.create(var_0_1.ModeType.hire, lc.w(var_5_1) - 24)

		arg_5_0._filterWidget = var_5_5

		var_5_5:resetAllFilter()
		var_5_5:registerSortFilterHandler(function()
			arg_5_0:updateCardList()
		end)
		lc.addChildToPos(var_5_1, var_5_5, cc.p(lc.w(var_5_1) / 2, lc.h(var_5_1) - lc.h(var_5_5) / 2 - 10))

		local var_5_6 = cc.size(lc.w(var_5_1) + 10, var_0_4 - lc.h(var_5_5) - 16)

		var_5_2:setContentSize(cc.size(var_5_6.width + 40, var_5_6.height))

		local var_5_7 = var_0_2.create(var_5_6)

		arg_5_0._cardList = var_5_7

		var_5_7:setCascadeOpacityEnabled(true)
		var_5_7:registerCardSelectedHandler(function(arg_7_0)
			arg_5_0:selectCard(arg_7_0)
		end)
		var_5_7:registerTapBtnCustom1(function(arg_8_0)
			arg_5_0:hireHero(arg_8_0)
		end)
		var_5_1:addChild(var_5_7)
	end

	var_5_2:setPosition(lc.w(arg_5_0) / 2, lc.bottom(var_5_1) + lc.h(var_5_2) / 2)
	arg_5_0:updateCardList()
end

function var_0_0.updateCardList(arg_9_0)
	local var_9_0 = arg_9_0._tabArea._focusTabIndex
	local var_9_1 = arg_9_0._cardList

	if var_9_0 == 1 then
		var_9_1:removeAllItems()

		for iter_9_0 = 1, 3 do
			local var_9_2 = arg_9_0:createMyHireItem(iter_9_0)

			var_9_1:pushBackCustomItem(var_9_2)
		end
	else
		local var_9_3 = arg_9_0._filterWidget
		local var_9_4
		local var_9_5 = {}
		local var_9_6, var_9_7 = var_9_3:getSortFunc()

		if var_9_6 then
			var_9_4 = {
				_func = var_9_6,
				_isReverse = not var_9_7
			}
		end

		local var_9_8, var_9_9 = var_9_3:getFilterNatureFunc()

		if var_9_8 then
			var_9_5[var_0_2.FilterType.country] = {
				_func = var_9_8,
				_keyVal = var_9_9
			}
		end

		local var_9_10, var_9_11 = var_9_3:getFilterCategoryFunc()

		if var_9_10 then
			var_9_5[var_0_2.FilterType.category] = {
				_func = var_9_10,
				_keyVal = var_9_11
			}
		end

		local var_9_12, var_9_13 = var_9_3:getFilterLevelFunc()

		if var_9_12 then
			var_9_5[var_0_2.FilterType.cost] = {
				_func = var_9_12,
				_keyVal = var_9_13
			}
		end

		local var_9_14, var_9_15 = var_9_3:getFilterQualityFunc()

		if var_9_14 then
			var_9_5[var_0_2.FilterType.quality] = {
				_func = var_9_14,
				_keyVal = var_9_15
			}
		end

		local var_9_16, var_9_17 = var_9_3:getFilterSearchFunc()

		if var_9_16 then
			var_9_5[var_0_2.FilterType.search] = {
				_func = var_9_16,
				_keyVal = var_9_17
			}
		end

		var_9_1:setMode(var_0_2.ModeType.hire)
		var_9_1:init(Data.CardType.monster, var_9_4, nil, var_9_5)
		var_9_1:refresh(true)
	end
end

function var_0_0.createMyHireItem(arg_10_0, arg_10_1)
	local var_10_0 = ccui.Widget:create()

	var_10_0:setContentSize(cc.size(256, lc.h(arg_10_0._cardList)))

	var_10_0._index = arg_10_1

	local var_10_1 = lc.createImageView({
		_name = "img_com_bg_10",
		_crect = ClientView.CRECT_COM_BG10,
		_size = cc.size(270, 182)
	})

	var_10_1:setScale(0.88)
	lc.addChildToPos(var_10_0, var_10_1, cc.p(lc.w(var_10_0) / 2, 154))

	local var_10_2 = P._playerUnion._myHires[arg_10_1]

	if arg_10_1 <= lc.arrayAt(Data._globalInfo._vipLetCount, P._vip + 1) then
		if var_10_2 then
			local var_10_3 = require("CardThumbnail").create(var_10_2)

			lc.addChildToPos(var_10_0, var_10_3, cc.p(lc.w(var_10_0) / 2, lc.h(var_10_0) - lc.h(var_10_3) / 2 - 18))
			var_10_3:setTouchEnabled(true)
			var_10_3:addTouchEventListener(function(arg_11_0, arg_11_1)
				if arg_11_1 == ccui.TouchEventType.ended then
					require("CardInfoPanel").create(var_10_3._card):show()
				end
			end)

			local var_10_4 = lc.createSprite({
				_name = "img_progress_bg",
				_crect = ClientView.CRECT_PROGRESS_BG,
				_size = cc.size(190, 32)
			})

			lc.addChildToPos(var_10_0, var_10_4, cc.p(lc.x(var_10_1), lc.top(var_10_1) - 36))

			local var_10_5 = ClientView.createTTF("", ClientView.FontSize.S2)

			lc.addChildToCenter(var_10_4, var_10_5)

			local var_10_6 = ClientView.createTTF(Str(STR.TOTAL_REWARD_TIP), ClientView.FontSize.S2, ClientView.COLOR_LABEL_DARK)

			lc.addChildToPos(var_10_0, var_10_6, cc.p(lc.x(var_10_1), lc.bottom(var_10_4) - 26))

			local var_10_7 = ClientView.addIconValue(var_10_0, "img_icon_res1_s", 0, lc.left(var_10_4) + 20, lc.bottom(var_10_6) - 20)

			var_10_7:setColor(ClientView.COLOR_TEXT_DARK)

			local function var_10_8()
				var_10_5:setString(string.format("%s%s", Str(STR.HIRE_SEND), ClientData.formatPeriod(ClientData.getCurrentTime() - var_10_2._timestamp)))
				var_10_7:setString(var_10_2:calcMyHireRewards())
			end

			var_10_0:scheduleUpdateWithPriorityLua(var_10_8, 0)
		else
			local var_10_9 = ClientView.createTTF(Str(STR.HIRE_ADD_TIP), ClientView.FontSize.S1, ClientView.COLOR_LABEL_DARK)

			lc.addChildToPos(var_10_0, var_10_9, cc.p(var_10_1:getPosition()))

			local var_10_10 = ClientView.createAddCardArea(0.94, function(arg_13_0)
				arg_10_0:changeMyHireHero(var_10_0, true)
			end)

			lc.addChildToPos(var_10_0, var_10_10, cc.p(lc.w(var_10_0) / 2, lc.h(var_10_0) - lc.h(var_10_10) / 2 - 18))
		end

		local var_10_11 = ClientView.createShaderButton("img_btn_1", function()
			arg_10_0:claimMyHireReward(var_10_0)
		end)

		var_10_11:addLabel(Str(STR.CLAIM))
		lc.addChildToPos(var_10_0, var_10_11, cc.p(lc.w(var_10_0) / 2 - lc.w(var_10_11) / 2 - 5, lc.h(var_10_11) / 2 + 16), 1)

		local var_10_12 = ClientView.createShaderButton("img_btn_1")

		if var_10_2 then
			function var_10_12._callback()
				arg_10_0:recallMyHireHero(var_10_0)
			end

			var_10_12:addLabel(Str(STR.HIRE_BACK))
		else
			function var_10_12._callback()
				arg_10_0:changeMyHireHero(var_10_0, true)
			end

			var_10_12:addLabel(Str(STR.HIRE_SEND))
		end

		lc.addChildToPos(var_10_0, var_10_12, cc.p(lc.w(var_10_0) / 2 + lc.w(var_10_12) / 2 + 5, lc.y(var_10_11)), 1)
	else
		local var_10_13 = ClientView.createTTF(string.format("VIP%d%s", arg_10_0._unlockVips[arg_10_1 - 1] + 1, Str(STR.UNLOCK)), ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)

		lc.addChildToPos(var_10_0, var_10_13, cc.p(var_10_1:getPosition()))

		local var_10_14 = ClientView.createAddCardArea(0.94, nil, true)

		lc.addChildToPos(var_10_0, var_10_14, cc.p(lc.w(var_10_0) / 2, lc.h(var_10_0) - lc.h(var_10_14) / 2 - 18))
	end

	return var_10_0
end

function var_0_0.changeMyHireHero(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 then
		local var_17_0 = P._playerUnion._myHires[arg_17_1._index]
		local var_17_1 = require("CardSelectForm").createHireForm(P._playerUnion._myHires, var_17_0)

		var_17_1:registerRadioSelectedHandler(function(arg_18_0)
			if arg_18_0 then
				arg_17_1._selectHero = arg_18_0

				arg_17_0:changeMyHireHero(arg_17_1, false)
			end
		end)
		var_17_1:show()

		return
	end

	P._playerUnion:addMyHire(arg_17_1._selectHero)
	ClientData.sendUnionAddHire(arg_17_1._selectHero._id)
	arg_17_0:updateCardList()
end

function var_0_0.claimMyHireReward(arg_19_0, arg_19_1)
	local var_19_0 = P._playerUnion._myHires[arg_19_1._index]

	if var_19_0 then
		local var_19_1 = var_19_0:claimReward()

		if var_19_1 > 0 then
			ClientView.showResChangeText(arg_19_1, Data.ResType.gold, var_19_1, 0, -180)
			ClientData.sendUnionHireClaim(var_19_0._guid)

			return true
		end
	end

	ToastManager.push(Str(STR.HIRE_REWARD_TIP))

	return false
end

function var_0_0.recallMyHireHero(arg_20_0, arg_20_1)
	local var_20_0 = P._playerUnion._myHires[arg_20_1._index]

	if var_20_0 then
		local var_20_1 = var_20_0:claimReward()

		if var_20_1 > 0 then
			ClientView.showResChangeText(arg_20_0, Data.ResType.gold, var_20_1)
			P._playerUnion:removeMyHire(arg_20_1._index)
			ClientData.sendUnionHireRecall(var_20_0._guid)
			arg_20_0:updateCardList()

			return true
		end
	end

	ToastManager.push(Str(STR.HIRE_RECALL_TIP))

	return false
end

function var_0_0.selectCard(arg_21_0, arg_21_1)
	if arg_21_1 then
		require("CardInfoPanel").create(arg_21_1):show()
	end
end

function var_0_0.hireHero(arg_22_0, arg_22_1)
	local var_22_0 = P._playerUnion:getMyUnion():findMember(arg_22_1._ownerId)

	if var_22_0 == nil then
		ToastManager.push(Str(STR.HIRE_NOT_FOUND))

		return
	end

	require("PromptForm").ConfirmHire.create(arg_22_1, var_22_0):show()
end

function var_0_0.onEnter(arg_23_0)
	ClientData.addMsgListener(arg_23_0, function(arg_24_0)
		return arg_23_0:onMsg(arg_24_0)
	end, 0)

	arg_23_0._listeners = {}

	table.insert(arg_23_0._listeners, lc.addEventListener(Data.Event.union_hires_dirty, function()
		if arg_23_0._tabArea._focusTabIndex == 2 then
			arg_23_0:updateCardList()
		end
	end))
	table.insert(arg_23_0._listeners, lc.addEventListener(Data.Event.vip_dirty, function()
		if arg_23_0._tabArea._focusTabIndex == 1 then
			arg_23_0:updateCardList()
		end
	end))
end

function var_0_0.onExit(arg_27_0)
	for iter_27_0 = 1, #arg_27_0._listeners do
		lc.Dispatcher:removeEventListener(arg_27_0._listeners[iter_27_0])
	end

	ClientData.removeMsgListener(arg_27_0)
end

function var_0_0.onMsg(arg_28_0, arg_28_1)
	if arg_28_1.type == SglMsgType_pb.PB_TYPE_UNION_RENT then
		local var_28_0 = ClientView.getActiveIndicator():hide()

		P._playerUnion:hire(var_28_0)
		P:changeResource(Data.ResType.gold, -var_28_0:calcHireCost())
		arg_28_0:updateCardList()
	end

	return false
end

return var_0_0
