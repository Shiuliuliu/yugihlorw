local var_0_0 = require("BaseUIScene")
local var_0_1 = class("BookLotteryScene", var_0_0)
local var_0_2 = "res/jpg/book_lottery_bg.jpg"
local var_0_3 = cc.size(820, 190)
local var_0_4 = 60
local var_0_5 = {
	cc.p(202, 45),
	cc.p(359, 160),
	cc.p(298, 344),
	cc.p(106, 341),
	cc.p(47, 158)
}
local var_0_6 = {
	0,
	72,
	144,
	216,
	288
}

function var_0_1.create()
	return lc.createScene(var_0_1)
end

function var_0_1.init(arg_2_0)
	if not var_0_1.super.init(arg_2_0, ClientData.SceneId.book_lottery, STR.LOTTERY_BOOK or STR.CARD_SEP_BOOK, var_0_0.STYLE_EMPTY, true) then
		return false
	end

	arg_2_0._resNames = ClientData.loadLCRes("res/book_lottery.lcres")

	local var_2_0 = lc.w(arg_2_0) / 2
	local var_2_1 = lc.createSprite(var_0_2)
	local var_2_2 = lc.w(arg_2_0) / lc.w(var_2_1)
	local var_2_3 = lc.bottom(arg_2_0._titleArea) / lc.h(var_2_1)

	var_2_1:setScale(var_2_3 < var_2_2 and var_2_2 or var_2_3)
	lc.addChildToPos(arg_2_0, var_2_1, cc.p(var_2_0, lc.sh(var_2_1) / 2))

	local var_2_4 = lc.createSprite("book_lottery_book_bg")
	local var_2_5 = lc.createSprite("book_lottery_chain")

	var_2_5:setRotation(-22.3)
	var_2_5:setAnchorPoint(1, 1)
	lc.addChildToPos(var_2_4, var_2_5, cc.p(20, lc.h(var_2_4) / 2 + 50))
	lc.addChildToPos(arg_2_0, var_2_4, cc.p(var_2_0 - lc.w(var_2_4) / 2, lc.bottom(arg_2_0._titleArea) - lc.h(var_2_4) / 2 - 20), 1)

	local var_2_6 = lc.createSprite("book_lottery_book_bg")

	var_2_6:setFlippedX(true)

	local var_2_7 = lc.createSprite("book_lottery_chain")

	var_2_7:setFlippedX(true)
	var_2_7:setRotation(22.3)
	var_2_7:setAnchorPoint(0, 1)
	lc.addChildToPos(var_2_6, var_2_7, cc.p(lc.w(var_2_6) - 20, lc.h(var_2_6) / 2 + 50))
	lc.addChildToPos(arg_2_0, var_2_6, cc.p(var_2_0 + lc.w(var_2_6) / 2, lc.y(var_2_4)), 1)

	local var_2_8 = lc.createSprite("book_lottery_circle")

	lc.addChildToPos(arg_2_0, var_2_8, cc.p(var_2_0, lc.y(var_2_4) + 6), 1)

	arg_2_0._circle = var_2_8
	arg_2_0._stones = {}

	for iter_2_0 = 1, #var_0_5 do
		local var_2_9 = lc.createSprite(string.format("book_lottery_quality%d", iter_2_0))

		var_2_8:addChild(var_2_9)
		table.insert(arg_2_0._stones, var_2_9)
	end

	arg_2_0:resetStones()

	local var_2_10 = lc.createNode(var_0_3)
	local var_2_11 = lc.createSprite({
		_name = "book_lottery_bottom",
		_crect = cc.rect(169, 0, 1, 190),
		_size = cc.size(var_0_3.width - 170, 190)
	})

	lc.addChildToPos(var_2_10, var_2_11, cc.p(lc.w(var_2_11) / 2, var_0_3.height / 2))

	local var_2_12 = lc.createSprite("book_lottery_bottom")

	var_2_12:setFlippedX(true)
	lc.addChildToPos(var_2_10, var_2_12, cc.p(var_0_3.width - lc.w(var_2_12) / 2, var_0_3.height / 2))
	lc.addChildToPos(arg_2_0, var_2_10, cc.p(var_2_0, lc.bottom(var_2_8) - 52))

	local var_2_13 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_2_0:lottery(1)
	end, ClientView.CRECT_BUTTON, 160)

	var_2_13:addLabel(string.format(Str(STR.HUNT_TIMES), 1))
	lc.addChildToPos(var_2_10, var_2_13, cc.p(154 + lc.w(var_2_13) / 2, var_0_4 + lc.h(var_2_13) / 2))

	local var_2_14 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_2_0:lottery(10)
	end, ClientView.CRECT_BUTTON, 160)

	var_2_14:addLabel(string.format(Str(STR.HUNT_TIMES), 10))
	lc.addChildToPos(var_2_10, var_2_14, cc.p(lc.right(var_2_13) + lc.w(var_2_14) / 2 + 16, lc.y(var_2_13)))

	local var_2_15 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_5_0)
		arg_2_0:lottery(100)
	end, ClientView.CRECT_BUTTON, 160)

	var_2_15:addLabel(string.format(Str(STR.HUNT_TIMES), 100))
	lc.addChildToPos(var_2_10, var_2_15, cc.p(lc.right(var_2_14) + lc.w(var_2_15) / 2 + 16, lc.y(var_2_13)))

	local var_2_16 = ClientView.createResIconLabel(140, "img_icon_res1_s", lc.Color3B.black)

	var_2_16:setOpacity(180)
	lc.addChildToPos(arg_2_0, var_2_16, cc.p(var_2_0 + 10, lc.bottom(var_2_8) + 120), 1)

	arg_2_0._resCost = var_2_16

	arg_2_0:initDropArea()
	arg_2_0:syncData()

	return true
end

function var_0_1.syncData(arg_6_0)
	var_0_1.super.syncData(arg_6_0)
	arg_6_0._circle:setRotation(var_0_6[P._bookLotteryQuality])
	arg_6_0._resCost._label:setString(Data._globalInfo._lotteryBookGold[P._bookLotteryQuality])
end

function var_0_1.initDropArea(arg_7_0)
	local var_7_0 = 100
	local var_7_1 = lc.createSprite({
		_name = "img_com_bg_17",
		_crect = ClientView.CRECT_COM_BG17,
		_size = cc.size(var_7_0, 140)
	})

	lc.addChildToPos(arg_7_0, var_7_1, cc.p(lc.w(arg_7_0) / 2, lc.h(var_7_1) / 2 + 10))

	arg_7_0._dropArea = var_7_1

	var_7_1:setVisible(false)

	local var_7_2 = ccui.Layout:create()

	var_7_2:setContentSize(lc.w(var_7_1) - 100, lc.h(var_7_1))
	var_7_2:setClippingEnabled(true)
	var_7_2:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToCenter(var_7_1, var_7_2)

	var_7_1._layout = var_7_2

	local var_7_3 = lc.createNode(var_7_2:getContentSize())

	lc.addChildToCenter(var_7_2, var_7_3)

	var_7_1._iconArea = var_7_3
	var_7_1._openW = 500
	var_7_1._isOpen = true

	function var_7_1.showResult(arg_8_0, arg_8_1)
		P:sortResultItems(arg_8_1)
		lc.addNodesToCenter(arg_8_0._iconArea, arg_8_1, 10, lc.h(var_7_3) / 2 + 3)

		arg_8_0._openW = var_7_0 + (IconWidget.SIZE + 10) * #arg_8_1

		arg_8_0:open()
	end

	function var_7_1.updatePos(arg_9_0, arg_9_1)
		arg_9_0:setContentSize(arg_9_1)
		arg_9_0._layout:setContentSize(math.max(0, arg_9_1.width - 100), arg_9_1.height)
		arg_9_0._layout:setPositionX(arg_9_1.width / 2)
		arg_9_0._iconArea:setPositionX(lc.w(arg_9_0._layout) / 2)
	end

	function var_7_1.open(arg_10_0)
		if arg_10_0._isOpen then
			return
		end

		arg_10_0:scheduleUpdateWithPriorityLua(function()
			local var_11_0 = arg_10_0:getContentSize()

			var_11_0.width = var_11_0.width + 20

			if var_11_0.width > arg_10_0._openW then
				var_11_0.width = arg_10_0._openW
				arg_10_0._isOpen = true

				arg_10_0:unscheduleUpdate()
				ClientView.showResChangeText(arg_7_0, Data.ResType.gold, -arg_7_0._goldCost, 0, -260)
			end

			arg_10_0:updatePos(var_11_0)
		end, 0)
	end

	function var_7_1.close(arg_12_0)
		if not arg_12_0._isOpen then
			return
		end

		arg_12_0:scheduleUpdateWithPriorityLua(function()
			local var_13_0 = arg_12_0:getContentSize()

			var_13_0.width = var_13_0.width - 20

			if var_13_0.width < var_7_0 then
				var_13_0.width = var_7_0
				arg_12_0._isOpen = false

				arg_12_0._iconArea:removeAllChildren()
				arg_12_0:unscheduleUpdate()
			end

			arg_12_0:updatePos(var_13_0)
		end, 0)
	end
end

function var_0_1.resetStones(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._stones) do
		iter_14_1:setPosition(var_0_5[iter_14_0])

		if iter_14_0 == P._bookLotteryQuality then
			iter_14_1:setColor(lc.Color3B.white)
		else
			iter_14_1:setColor(lc.Color3B.gray)
		end
	end
end

function var_0_1.lottery(arg_15_0, arg_15_1)
	local var_15_0 = Data._globalInfo._lotteryBookGold[P._bookLotteryQuality]

	if not ClientView.checkGold(var_15_0) then
		return
	end

	arg_15_0._dropArea:setVisible(true)
	P:changeResource(Data.ResType.gold, -var_15_0)

	arg_15_0._lotteryStartTime = ClientData.getCurrentTime()
	arg_15_0._goods = {}
	arg_15_0._goldCost = var_15_0

	ClientData.sendBookLottery(arg_15_1)
	ClientView.getActiveIndicator():show()
	arg_15_0:showLotteryEffect()
end

function var_0_1.showLotteryEffect(arg_16_0)
	arg_16_0._particles = {}

	local var_16_0 = arg_16_0._stones[P._bookLotteryQuality]

	var_16_0:runAction(lc.sequence(lc.moveTo(0.4, lc.w(arg_16_0._circle) / 2, lc.h(arg_16_0._circle) / 2), function()
		local var_17_0 = {
			"par_book_lottery2",
			"par_book_lottery3",
			"par_book_lottery4"
		}

		for iter_17_0 = 1, #var_17_0 do
			local var_17_1 = Particle.create(var_17_0[iter_17_0])

			var_17_1:setAutoRemoveOnFinish(false)
			var_17_1:setPosition(lc._runningScene:convertToNodeSpace(var_16_0:convertToWorldSpace(cc.p(lc.w(var_16_0) / 2, lc.h(var_16_0) / 2))))
			lc._runningScene:addChild(var_17_1, ClientData.ZOrder.effect)
			table.insert(arg_16_0._particles, var_17_1)
		end
	end, 1, function()
		arg_16_0:tryStopLotteryEffect()
	end))

	local var_16_1 = Particle.create("par_book_lottery1")

	var_16_1:setPosition(lc._runningScene:convertToNodeSpace(var_16_0:convertToWorldSpace(cc.p(lc.w(var_16_0) / 2, lc.h(var_16_0) / 2))))
	lc._runningScene:addChild(var_16_1, ClientData.ZOrder.effect)
	arg_16_0._circle:stopAllActions()
	arg_16_0._circle:runAction(lc.rep(lc.rotateBy(0.5, 360)))
	arg_16_0._dropArea:close()
	arg_16_0._resCost:setVisible(false)
	lc.Audio.playAudio(AUDIO.E_BOOK_ANIMATION)
end

function var_0_1.tryStopLotteryEffect(arg_19_0)
	if next(arg_19_0._goods) == nil or ClientData.getCurrentTime() - arg_19_0._lotteryStartTime < 1.2 then
		return
	end

	arg_19_0._circle:stopAllActions()
	arg_19_0._circle:runAction(lc.sequence(lc.rotateTo(0.4, var_0_6[P._bookLotteryQuality]), function()
		ClientView.getActiveIndicator():hide()
		arg_19_0:resetStones()
		arg_19_0._resCost._label:setString(string.format("%d", Data._globalInfo._lotteryBookGold[P._bookLotteryQuality]))
	end))

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._particles) do
		iter_19_1:setAutoRemoveOnFinish(true)
		iter_19_1:stopSystem()
	end

	local var_19_0 = {}

	for iter_19_2, iter_19_3 in pairs(arg_19_0._goods) do
		local var_19_1 = IconWidget.create(iter_19_3, IconWidget.DisplayFlag.ITEM_NO_NAME)

		table.insert(var_19_0, var_19_1)
	end

	arg_19_0._dropArea:showResult(var_19_0)
	arg_19_0._resCost:setVisible(true)
	lc.Audio.playAudio(AUDIO.E_BOOK_GET)
end

function var_0_1.onCleanup(arg_21_0)
	var_0_1.super.onCleanup(arg_21_0)
	ClientData.unloadLCRes(arg_21_0._resNames)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename(var_0_2))
end

function var_0_1.resetLotteryRefusal(arg_22_0)
	ClientView.getActiveIndicator():hide()
	arg_22_0._circle:stopAllActions()
	arg_22_0._circle:runAction(lc.rotateTo(0, var_0_6[P._bookLotteryQuality]))
	arg_22_0._stones[P._bookLotteryQuality]:stopAllActions()
	arg_22_0._dropArea:close()
	arg_22_0._resCost:setVisible(true)
	if arg_22_0._goldCost and arg_22_0._goldCost > 0 then
		P:changeResource(Data.ResType.gold, arg_22_0._goldCost)
	end
	arg_22_0._goldCost = 0
	arg_22_0._goods = {}
end

function var_0_1.onMsgErrorStatus(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1.type == SglMsgType_pb.PB_TYPE_CARD_LOTTERY_BOOK then
		arg_23_0:resetLotteryRefusal()
		return true
	end

	return var_0_1.super.onMsgErrorStatus(arg_23_0, arg_23_1, arg_23_2)
end

function var_0_1.onMsg(arg_22_0, arg_22_1)
	if var_0_1.super.onMsg(arg_22_0, arg_22_1) then
		return true
	end

	local var_22_0 = arg_22_1.type
	local var_22_1 = arg_22_1.status

	if var_22_0 == SglMsgType_pb.PB_TYPE_CARD_LOTTERY_BOOK then
		-- The book catalog/reward table is not present in the recovered data.
		-- A refusal must still unwind the optimistic client-side payment and
		-- animation, otherwise the scene stays locked with a hidden price label.
		if var_22_1 ~= SglMsg_pb.PB_STATUS_OK then
			arg_22_0:resetLotteryRefusal()
			return true
		end

		local var_22_2 = arg_22_1.Extensions[Card_pb.SglCardMsg.book_lottery_resp]
		if not var_22_2 then
			arg_22_0:resetLotteryRefusal()
			return true
		end
		local var_22_3 = #var_22_2
		local var_22_4 = arg_22_0._goods
		local var_22_5 = P._bookLotteryQuality

		for iter_22_0, iter_22_1 in ipairs(var_22_2) do
			local var_22_6 = iter_22_1.resource
			local var_22_7 = var_22_4[var_22_6.info_id]

			if var_22_7 then
				var_22_7._count = var_22_7._count + var_22_6.num
			else
				local var_22_8 = {
					_infoId = var_22_6.info_id,
					_level = var_22_6.level,
					_count = var_22_6.num,
					_isFragment = var_22_6.is_fragment
				}

				var_22_4[var_22_6.info_id] = var_22_8

				if Data.getType(var_22_6.info_id) == Data.CardType.book then
					ClientData._hasNewLotteryBook = true
				end
			end

			P:addResource(var_22_6.info_id, var_22_6.level, var_22_6.num, var_22_6.is_fragment, true)

			local var_22_10 = iter_22_1.next_quality or 1

			if var_22_10 < 1 then
				var_22_10 = 1
			elseif var_22_10 > #var_0_6 then
				var_22_10 = #var_0_6
			end

			P._bookLotteryQuality = var_22_10

			if iter_22_0 < var_22_3 then
				local var_22_9 = Data._globalInfo._lotteryBookGold[P._bookLotteryQuality]

				P:changeResource(Data.ResType.gold, -var_22_9)

				arg_22_0._goldCost = arg_22_0._goldCost + var_22_9
			end
		end

		lc.sendEvent(Data.Event.book_lottery, var_22_3)
		arg_22_0:tryStopLotteryEffect()

		return true
	end

	return false
end

function var_0_1.onGuide(arg_23_0, arg_23_1)
	if GuideManager.getCurStepName() == "exit lottery book" then
		GuideManager.setOperateLayer(arg_23_0._btnBack)
	else
		return
	end

	arg_23_1:stopPropagation()
end

return var_0_1
