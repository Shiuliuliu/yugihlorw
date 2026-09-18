local var_0_0 = class("PalaceVisitArea", lc.ExtendCCNode)
local var_0_1 = 800

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_0, arg_1_1)
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
	arg_3_0._scene = lc._runningScene

	local var_3_0 = ClientView.createLabelProgressBar(lc.w(arg_3_0) - 20, ClientView.BMFont.huali_26, lc.Color3B.yellow, lc.Color3B.green)

	lc.addChildToPos(arg_3_0, var_3_0, cc.p(lc.w(arg_3_0) / 2, lc.h(arg_3_0) - lc.h(var_3_0) / 2 - 10))

	arg_3_0._graceBar = var_3_0

	local var_3_1 = lc.createSprite("img_icon_orange_card")

	lc.addChildToPos(var_3_0, var_3_1, cc.p(lc.w(var_3_0) - 20, lc.h(var_3_0) / 2))

	var_3_0._icon = var_3_1

	arg_3_0:updateGraceBar()
	arg_3_0:updateContentView()
end

function var_0_0.updateGraceBar(arg_4_0)
	local var_4_0 = arg_4_0._graceBar

	var_4_0._bar:setPercent(P._grace * 100 / Data._globalInfo._maxGrace)
	var_4_0._label:setString(string.format("%s: %d / %d", Str(STR.GRACE), P._grace, Data._globalInfo._maxGrace))

	if P._grace == Data._globalInfo._maxGrace then
		var_4_0._bar:runAction(lc.rep(lc.sequence(lc.tintTo(0.5, 255, 255, 255), lc.tintTo(0.5, 0, 255, 0))))
		var_4_0._icon:runAction(lc.rep(lc.sequence(lc.rotateTo(0.06, 0), lc.rotateTo(0.12, 20), lc.rotateTo(0.05, 5), lc.rotateTo(0.1, 15), lc.rotateTo(0.01, 10), 2)))
	else
		var_4_0._bar:stopAllActions()
		var_4_0._bar:setColor(lc.Color3B.green)
		var_4_0._icon:stopAllActions()
		var_4_0._icon:setRotation(10)
	end
end

function var_0_0.updateContentView(arg_5_0)
	local var_5_0 = arg_5_0._contentArea

	if var_5_0 then
		var_5_0:removeFromParent()
	end

	arg_5_0._scene:showTabFlag(arg_5_0._scene.TAB.visit)

	arg_5_0._ingotIcon = nil

	local var_5_1 = lc.createNode(cc.size(var_0_1, lc.h(arg_5_0) - lc.h(arg_5_0._graceBar)))

	lc.addChildToPos(arg_5_0, var_5_1, cc.p(lc.w(arg_5_0) / 2, lc.h(var_5_1) / 2))

	arg_5_0._contentArea = var_5_1

	local var_5_2 = P._playerPalace._visit

	if var_5_2 == nil or var_5_2:isFinished() then
		local var_5_3 = ClientView.createTTF(string.format(Str(STR.LIST_EMPTY_NO_CARD), Str(STR.MONSTER) .. Str(STR.VISIT)), ClientView.FontSize.S1)

		lc.addChildToCenter(var_5_1, var_5_3)

		local var_5_4

		if P._grace == Data._globalInfo._maxGrace then
			var_5_4 = ClientView.createBoldRichText(Str(STR.PALACE_VISIT_ORANGE), {
				_normalClr = ClientView.COLOR_LABEL_LIGHT,
				_boldClr = ClientView.COLOR_TEXT_LIGHT,
				_fontSize = ClientView.FontSize.S1
			})
		else
			var_5_4 = ClientView.createBoldRichText(Str(STR.PALACE_VISIT_TIP), {
				_normalClr = ClientView.COLOR_LABEL_LIGHT,
				_boldClr = ClientView.COLOR_TEXT_LIGHT,
				_fontSize = ClientView.FontSize.S1
			})
		end

		lc.addChildToPos(var_5_1, var_5_4, cc.p(lc.w(var_5_1) / 2, lc.h(var_5_1) - lc.h(var_5_4) / 2 - 20))

		if var_5_2 then
			P._playerPalace._visit = nil
		end

		return
	end

	local var_5_5 = var_5_2:getHeroInfoId()
	local var_5_6 = require("Card").create(var_5_5)
	local var_5_7 = require("CardThumbnail").create(var_5_6)

	var_5_7:setTouchEnabled(true)
	var_5_7:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 == ccui.TouchEventType.ended then
			require("CardInfoPanel").create(var_5_6):show()
		end
	end)
	lc.addChildToPos(var_5_1, var_5_7, cc.p(lc.w(var_5_1) / 2 - lc.w(var_5_7) / 2 - 100, lc.h(var_5_1) - lc.h(var_5_7) / 2 - 20))

	local var_5_8 = ClientView.createBoldRichText(string.format(Str(STR.RELATION2HERO), Str(var_5_6._info._nameSid)), {
		_normalClr = ClientView.COLOR_LABEL_LIGHT,
		_boldClr = ClientView.COLOR_TEXT_LIGHT,
		_fontSize = ClientView.FontSize.S1
	})

	lc.addChildToPos(var_5_1, var_5_8, cc.p(lc.right(var_5_7) + lc.w(var_5_8) / 2 + 50, lc.top(var_5_7) - lc.h(var_5_8) / 2 - 10))

	local var_5_9 = lc.left(var_5_8)

	for iter_5_0, iter_5_1 in ipairs(var_5_6._info._relId) do
		local var_5_10 = iter_5_1[1]

		if var_5_10 > 0 then
			local var_5_11 = IconWidget.create({
				_infoId = var_5_10
			}, IconWidget.DisplayFlag.NAME)

			var_5_11:setGray(P._playerCard._levels[var_5_10] == nil)
			var_5_11._name:setColor(ClientView.COLOR_TEXT_LIGHT)
			lc.addChildToPos(var_5_1, var_5_11, cc.p(var_5_9 + lc.w(var_5_11) / 2, lc.bottom(var_5_8) - lc.h(var_5_11) / 2 - 10))

			var_5_9 = var_5_9 + lc.w(var_5_11) + 10
		end
	end

	local var_5_12 = ClientView.createTTF(Str(STR.HERO_LEAVE_COUNTDOWN) .. ":", ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)

	lc.addChildToPos(var_5_1, var_5_12, cc.p(lc.left(var_5_8) + lc.w(var_5_12) / 2, lc.top(var_5_7) - lc.h(var_5_12) / 2 - 190))

	local var_5_13 = ClientView.createLabelProgressBar(200, ClientView.BMFont.huali_26)

	var_5_13._label:setScale(0.8)
	lc.addChildToPos(var_5_1, var_5_13, cc.p(lc.right(var_5_12) + lc.w(var_5_13) / 2 + 10, lc.y(var_5_12)))

	arg_5_0._progressBar = var_5_13

	local var_5_14 = ClientView.createResConsumeButtonArea({
		150,
		160
	}, "img_icon_res3_s", ClientView.COLOR_RES_LABEL_BG_LIGHT, var_5_2:getStayIngot(), Str(STR.STAY_ONE_DAY))

	function var_5_14._btn._callback()
		arg_5_0:onVisitStay()
	end

	lc.addChildToPos(var_5_1, var_5_14, cc.p(lc.w(var_5_1) - lc.w(var_5_14) / 2 - 50, lc.bottom(var_5_12) - lc.h(var_5_14) / 2 - 12))

	arg_5_0._stayIngot = var_5_14._resLabel

	if P._vip >= Data._globalInfo._vipRecruit then
		local var_5_15 = ClientView.createResConsumeButtonArea({
			150,
			160
		}, "img_icon_res3_s", ClientView.COLOR_RES_LABEL_BG_LIGHT, var_5_2._info._ingot, Str(STR.PALACE_VISIT_RECRUIT))

		function var_5_15._btn._callback()
			arg_5_0:onVisitRecruit()
		end

		lc.addChildToPos(var_5_1, var_5_15, cc.p(lc.x(var_5_14), lc.bottom(var_5_14) - lc.h(var_5_15) / 2 - 4))
	end

	arg_5_0._graceAdd = Data._globalInfo._graceValue[CardHelper.getCardQuality(var_5_6)] + Data._globalInfo._vipGrace[P._vip + 1]

	local var_5_16 = ClientView.createBoldRichText(string.format(Str(STR.COMMIT_PROP2HERO), Str(STR.GRACE), arg_5_0._graceAdd), {
		_normalClr = ClientView.COLOR_LABEL_LIGHT,
		_boldClr = ClientView.COLOR_TEXT_LIGHT,
		_fontSize = ClientView.FontSize.S1
	})

	lc.addChildToPos(var_5_1, var_5_16, cc.p(lc.w(var_5_1) / 2, lc.bottom(var_5_7) - lc.h(var_5_16) / 2 - 24))

	local var_5_17 = var_5_2:getNeedItems()

	for iter_5_2, iter_5_3 in ipairs(var_5_17) do
		local var_5_18 = IconWidget.create({
			_infoId = iter_5_3._infoId,
			_count = iter_5_3._num
		}, IconWidget.DisplayFlag.ITEM)

		var_5_18._name:setColor(ClientView.COLOR_TEXT_LIGHT)

		local var_5_19 = P:getItemCount(iter_5_3._infoId)

		if iter_5_3._isProp then
			var_5_18._countBg._count:setString(string.format("%s/%d", ClientData.formatNum(var_5_19, 9999), iter_5_3._num))
		else
			arg_5_0._ingotIcon = var_5_18
		end

		var_5_18._countBg._count:setColor(var_5_19 < iter_5_3._num and ClientView.COLOR_TEXT_RED or ClientView.COLOR_TEXT_LIGHT)
		lc.addChildToPos(arg_5_0._contentArea, var_5_18, cc.p(lc.x(var_5_16) + (iter_5_2 - #var_5_17 / 2 - 0.5) * 120, lc.bottom(var_5_16) - lc.h(var_5_18) / 2 - 20))
	end

	local var_5_20 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_9_0)
		arg_5_0:onVisitClaim()
	end, ClientView.CRECT_BUTTON, 160)

	var_5_20:addLabel(Str(STR.SHANGCI))
	lc.addChildToPos(var_5_1, var_5_20, cc.p(lc.w(var_5_1) / 2 + lc.w(var_5_20) / 2 + 20, lc.h(var_5_20) / 2 + 20))

	local var_5_21 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_10_0)
		arg_5_0:onVisitGiveup(true, false)
	end, ClientView.CRECT_BUTTON, 160)

	var_5_21:addLabel(Str(STR.SONGKE))
	lc.addChildToPos(var_5_1, var_5_21, cc.p(lc.w(var_5_1) / 2 - lc.w(var_5_21) / 2 - 20, lc.h(var_5_21) / 2 + 20))
end

function var_0_0.onEnter(arg_11_0)
	arg_11_0._listeners = {}

	local var_11_0 = lc.addEventListener(Data.Event.palace_visit_dirty, function(arg_12_0)
		if arg_12_0._data == P._playerPalace._visit then
			if arg_12_0._data:isFinished() then
				arg_11_0:onVisitGiveup(false, true)
			else
				arg_11_0:updateGraceBar()
				arg_11_0:updateContentView()
			end
		end
	end)

	table.insert(arg_11_0._listeners, var_11_0)

	local var_11_1 = lc.addEventListener(Data.Event.vip_dirty, function(arg_13_0)
		arg_11_0:updateContentView()
	end)

	table.insert(arg_11_0._listeners, var_11_1)

	local var_11_2 = lc.addEventListener(Data.Event.ingot_dirty, function(arg_14_0)
		if arg_11_0._ingotIcon then
			arg_11_0._ingotIcon._countBg._count:setColor(P._ingot < arg_11_0._ingotIcon._data._count and ClientView.COLOR_TEXT_RED or ClientView.COLOR_TEXT_LIGHT)
		end
	end)

	table.insert(arg_11_0._listeners, var_11_2)
	arg_11_0:scheduleUpdateWithPriorityLua(function(arg_15_0)
		arg_11_0:onSchedule(arg_15_0)
	end, 0)
end

function var_0_0.onExit(arg_16_0)
	for iter_16_0 = 1, #arg_16_0._listeners do
		lc.Dispatcher:removeEventListener(arg_16_0._listeners[iter_16_0])
	end

	arg_16_0:unscheduleUpdate()
end

function var_0_0.onSchedule(arg_17_0, arg_17_1)
	local var_17_0 = P._playerPalace._visit

	if var_17_0 == nil then
		return
	end

	local var_17_1 = math.ceil(var_17_0._timestamp - ClientData.getCurrentTime())

	if var_17_1 < 0 then
		var_17_1 = 0
	end

	local var_17_2 = var_17_0:getDuration()

	arg_17_0._progressBar._bar:setPercent((var_17_2 - var_17_1) * 100 / var_17_2)
	arg_17_0._progressBar._label:setString(ClientData.formatPeriod(var_17_1))
end

function var_0_0.onVisitClaim(arg_18_0)
	local var_18_0, var_18_1 = P._playerPalace:confirmVisit()

	if var_18_0 == Data.ErrorType.ok then
		local var_18_2 = require("Card").create(var_18_1)

		require("RewardCardPanel").create(Str(STR.GET) .. Str(STR.MONSTER), {
			var_18_2
		}):show()

		P._grace = math.min(P._grace + arg_18_0._graceAdd, Data._globalInfo._maxGrace)

		ClientData.sendConfirmPalaceVisit(P._playerPalace._visit._id)
		arg_18_0:onVisitGiveup(false, true)
		arg_18_0:updateGraceBar()
	elseif var_18_0 == Data.ErrorType.hero_leave then
		ToastManager.push(Str(STR.HERO_LEAVE))
	elseif var_18_0 == Data.ErrorType.need_more_visit_prop then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(var_18_1)))
	elseif var_18_0 == Data.ErrorType.need_more_ingot then
		require("PromptForm").ConfirmBuyIngot.create():show()
	end
end

function var_0_0.onVisitGiveup(arg_19_0, arg_19_1, arg_19_2)
	if P._playerPalace._visit == nil then
		ToastManager.push(Str(STR.HERO_LEAVE))

		return
	end

	if not arg_19_2 then
		require("Dialog").showDialog(Str(STR.SURE_TO_SONGKE), function()
			arg_19_0:onVisitGiveup(arg_19_1, true)
		end)

		return
	end

	if arg_19_1 then
		ClientData.sendRemovePalaceVisit(P._playerPalace._visit._id)
	end

	P._playerPalace._visit = nil

	arg_19_0:updateContentView()
end

function var_0_0.onVisitStay(arg_21_0, arg_21_1)
	local var_21_0 = P._playerPalace._visit

	if var_21_0 == nil then
		ToastManager.push(Str(STR.HERO_LEAVE))

		return
	end

	if not arg_21_1 then
		require("Dialog").showDialog(string.format(Str(STR.SURE_TO_STAY), var_21_0:getStayIngot()), function()
			arg_21_0:onVisitStay(true)
		end)

		return
	end

	local var_21_1 = P._playerPalace:stayVisit()

	if var_21_1 == Data.ErrorType.ok then
		ClientData.sendStayPalaceVisit(var_21_0._id)
		arg_21_0._stayIngot:setString(string.format("%d", var_21_0:getStayIngot()))
	elseif var_21_1 == Data.ErrorType.hero_leave then
		ToastManager.push(Str(STR.HERO_LEAVE))
	elseif var_21_1 == Data.ErrorType.need_more_ingot then
		require("PromptForm").ConfirmBuyIngot.create():show()
	end
end

function var_0_0.onVisitRecruit(arg_23_0, arg_23_1)
	local var_23_0 = P._playerPalace._visit

	if var_23_0 == nil then
		ToastManager.push(Str(STR.HERO_LEAVE))

		return
	end

	if not arg_23_1 then
		require("Dialog").showDialog(string.format(Str(STR.SURE_TO_RECRUIT), var_23_0._info._ingot), function()
			arg_23_0:onVisitRecruit(true)
		end)

		return
	end

	local var_23_1, var_23_2 = P._playerPalace:recruitVisit()

	if var_23_1 == Data.ErrorType.ok then
		local var_23_3 = require("Card").create(var_23_2)

		require("RewardCardPanel").create(Str(STR.GET) .. Str(STR.MONSTER), {
			var_23_3
		}):show()

		P._grace = math.min(P._grace + arg_23_0._graceAdd, Data._globalInfo._maxGrace)

		ClientData.sendRecruitPalaceVisit(var_23_0._id)
		arg_23_0:onVisitGiveup(false, true)
		arg_23_0:updateGraceBar()
	elseif var_23_1 == Data.ErrorType.hero_leave then
		ToastManager.push(Str(STR.HERO_LEAVE))
	elseif var_23_1 == Data.ErrorType.need_more_ingot then
		require("PromptForm").ConfirmBuyIngot.create():show()
	end
end

return var_0_0
