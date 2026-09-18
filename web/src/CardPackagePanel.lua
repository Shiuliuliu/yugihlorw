local var_0_0 = class("CardPackagePanel", require("BasePanel"))
local var_0_1 = require("CardThumbnail")

var_0_0.PACKAGE_CARD_COUNT = 3
var_0_0.Mode = {
	open_one = 1,
	show_all = 2
}

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	var_0_0.super.init(arg_2_0, true)

	arg_2_0._mode = arg_2_1
	arg_2_0._newCards = arg_2_2
	arg_2_0._recruitInfo = arg_2_3
	arg_2_0._recruitInfoOnce = arg_2_4
	arg_2_0._packageIndex = arg_2_5 or 1
	arg_2_0._cardScale = ClientView.SCR_W / 1366 * 0.9

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 ~= ccui.TouchEventType.ended or arg_2_0._isShowTotalList then
			-- block empty
		elseif not arg_2_0._isEndShowPackage then
			arg_2_0:endPackageShow()
		elseif not arg_2_0._isOpened then
			arg_2_0:openPackage()
			GuideManager.closeNpcTipLayer()
			GuideManager.finishStepLater(1.5)
		end
	end)
end

function var_0_0.onEnter(arg_4_0)
	var_0_0.super.onEnter(arg_4_0)

	arg_4_0._listeners = {}

	table.insert(arg_4_0._listeners, lc.addEventListener(GuideManager.Event.seek, function(arg_5_0)
		arg_4_0:onGuide(arg_5_0)
	end))

	if arg_4_0._mode == var_0_0.Mode.open_one then
		arg_4_0:start()
	else
		arg_4_0:showTotalCards()
	end
end

function var_0_0.onExit(arg_6_0)
	var_0_0.super.onExit(arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_6_1)
	end
end

function var_0_0.onCleanup(arg_7_0)
	var_0_0.super.onCleanup(arg_7_0)

	if arg_7_0._cardThumbnails then
		for iter_7_0 = 1, 3 do
			if arg_7_0._cardThumbnails[iter_7_0] then
				var_0_1.releaseToPool(arg_7_0._cardThumbnails[iter_7_0]._cardSprite)
			end
		end
	end
end

function var_0_0.start(arg_8_0)
	local var_8_0 = arg_8_0._recruitInfoOnce
	local var_8_1 = ClientView.createCardPackage(var_8_0)

	lc.addChildToPos(arg_8_0, var_8_1, cc.p(ClientView.SCR_CW, -lc.ch(var_8_1)), 10)

	arg_8_0._package = var_8_1

	if #arg_8_0._newCards > var_0_0.PACKAGE_CARD_COUNT then
		local var_8_2 = string.format("%d/%d", arg_8_0._packageIndex, math.floor(#arg_8_0._newCards / var_0_0.PACKAGE_CARD_COUNT))
		local var_8_3 = ClientView.createTTF(var_8_2, ClientView.FontSize.S1)

		lc.addChildToPos(arg_8_0, var_8_3, cc.p(lc.cw(var_8_3) + 20, lc.ch(var_8_3) + 10))

		local var_8_4 = ClientView.createTTF(Str(STR.RECRUIT_FAST_OPEN), ClientView.FontSize.S1, ClientView.COLOR_TEXT_GREEN)
		local var_8_5 = ClientView.createShaderButton(nil, function(arg_9_0)
			require("Dialog").showDialog(Str(STR.RECRUIT_FAST_OPEN_TIP), function()
				var_0_0.create(var_0_0.Mode.show_all, arg_8_0._newCards, arg_8_0._recruitInfo, arg_8_0._recruitInfoOnce, arg_8_0._packageIndex + 1):show()
				arg_8_0:removeFromParent()
			end)
		end)

		var_8_5:setContentSize(cc.size(lc.w(var_8_4) + 16, lc.h(var_8_4) + 16))
		var_8_5:setAnchorPoint(cc.p(0.5, 0.5))
		lc.addChildToCenter(var_8_5, var_8_4)
		lc.addChildToPos(arg_8_0, var_8_5, cc.p(ClientView.SCR_W - lc.cw(var_8_4) - 20, lc.ch(var_8_4) + 20))
	end

	var_8_1:runAction(lc.sequence(lc.moveBy(1, cc.p(0, ClientView.SCR_CH + lc.ch(var_8_1))), function()
		arg_8_0:endPackageShow()
	end))

	local var_8_6 = lc.createNode()

	arg_8_0._tipNode = var_8_6

	lc.addChildToPos(arg_8_0, var_8_6, cc.p((ClientView.SCR_CW - 122) / 2, ClientView.SCR_CH))

	local var_8_7 = ClientView.createTTF(Str(STR.PURCHASED))
	local var_8_8 = lc.createSprite(ClientData.getPropIconName(Data.PropsId.skin_crystal))
	local var_8_9 = ClientView.createTTF(Str(STR.MULTIPY) .. math.max(arg_8_0._recruitInfo._value % 100, 1))
	local var_8_10 = ClientView.createTTF(Str(STR.LOTTERY_SUFFIX))

	lc.addNodesToCenter(var_8_6, {
		var_8_7,
		var_8_8,
		var_8_9,
		var_8_10
	}, 0)

	arg_8_0._isEndShowPackage = false
	arg_8_0._isOpened = false
	arg_8_0._isEndShowCards = false
	arg_8_0._isAllCardsOpend = false
end

function var_0_0.endPackageShow(arg_12_0)
	arg_12_0._isEndShowPackage = true

	local var_12_0 = arg_12_0._package

	var_12_0:stopAllActions()
	var_12_0:setPosition(cc.p(ClientView.SCR_CW, ClientView.SCR_CH))
	var_12_0:runAction(lc.rep(lc.sequence(lc.moveBy(0.8, cc.p(0, -20)), lc.moveBy(0.8, cc.p(0, 20)))))
end

function var_0_0.openPackage(arg_13_0)
	arg_13_0._isOpened = true

	arg_13_0._tipNode:setVisible(false)
	arg_13_0._package:stopAllActions()
	lc.Audio.playAudio(AUDIO.E_TAVERN_OPEN_PACKAGE)
	arg_13_0:runAction(lc.sequence(0, function()
		local var_14_0 = Particle.create("par_chouka01")

		lc.addChildToPos(arg_13_0, var_14_0, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 260), 20)
	end, 0.15, function()
		local var_15_0 = Particle.create("par_chouka02")

		lc.addChildToCenter(arg_13_0, var_15_0, 20)
	end, 0.65, function()
		local var_16_0 = Particle.create("par_chouka04")

		lc.addChildToCenter(arg_13_0, var_16_0, 20)

		local var_16_1 = Particle.create("par_chouka05")

		lc.addChildToCenter(arg_13_0, var_16_1, 20)
	end, 0.15, function()
		local var_17_0 = Particle.create("par_chouka03")

		lc.addChildToCenter(arg_13_0, var_17_0)
		arg_13_0:showCards()
	end))
end

function var_0_0.showCards(arg_18_0)
	arg_18_0._isEndShowCards = false

	arg_18_0._package:removeFromParent()

	arg_18_0._package = nil

	local var_18_0 = arg_18_0._cardScale
	local var_18_1 = (arg_18_0._packageIndex - 1) * var_0_0.PACKAGE_CARD_COUNT + 1
	local var_18_2 = math.min(#arg_18_0._newCards, arg_18_0._packageIndex * var_0_0.PACKAGE_CARD_COUNT)
	local var_18_3 = {}

	for iter_18_0 = var_18_1, var_18_2 do
		table.insert(var_18_3, arg_18_0._newCards[iter_18_0])
	end

	if #var_18_3 == 1 then
		table.insert(var_18_3, 1, nil)
	end

	arg_18_0._cardThumbnails = {}

	for iter_18_1 = 1, #var_18_3 do
		local var_18_4 = var_18_3[iter_18_1]

		if var_18_4 then
			local var_18_5 = cc.p(ClientView.SCR_CW + 400 * (iter_18_1 - 2) * var_18_0, ClientView.SCR_CH + (80 - math.abs(iter_18_1 - 2) * 40) * var_18_0)
			local var_18_6 = (iter_18_1 - 2) * 5
			local var_18_7 = ccui.Layout:create()

			lc.addChildToCenter(arg_18_0, var_18_7, 10)

			arg_18_0._cardThumbnails[iter_18_1] = var_18_7
			var_18_7._card = var_18_4

			local var_18_8 = lc.createSprite(ClientView.getCardBackName())

			var_18_7:setContentSize(var_18_8:getContentSize())
			var_18_7:setAnchorPoint(cc.p(0.5, 0.5))
			lc.addChildToCenter(var_18_7, var_18_8)

			var_18_7._cardBack = var_18_8

			local var_18_9 = var_0_1.createFromPool(var_18_4._infoId, 1)

			var_18_9._thumbnail:updateFlag()
			lc.addChildToCenter(var_18_7, var_18_9)
			var_18_9:setVisible(false)

			var_18_7._cardSprite = var_18_9

			local var_18_10 = cc.Node:create()

			lc.addChildToCenter(var_18_7, var_18_10)

			var_18_7._effectNode = var_18_10

			var_18_7:setScale(var_18_0)
			var_18_7:runAction(lc.sequence(lc.spawn(lc.moveTo(0.3, var_18_5), lc.rotateTo(0.3, var_18_6), lc.scaleTo(0.3, var_18_0)), function()
				arg_18_0:endShowCards()
			end))
		end
	end
end

function var_0_0.endShowCards(arg_20_0)
	arg_20_0._isEndShowCards = true

	local var_20_0 = arg_20_0._cardScale
	local var_20_1 = {
		0.8,
		1.2,
		1
	}

	for iter_20_0 = 1, 3 do
		local var_20_2 = arg_20_0._cardThumbnails[iter_20_0]

		if var_20_2 then
			local var_20_3 = var_20_1[iter_20_0]
			local var_20_4 = Data.getInfo(var_20_2._card._infoId)

			var_20_2:runAction(lc.sequence(lc.scaleTo(0.2 * var_20_3, var_20_0 * 1.1), lc.scaleTo(0.3 * var_20_3, var_20_0), function()
				var_20_2:runAction(lc.rep(lc.sequence(lc.scaleTo(0.3, var_20_0 * 1.05), lc.scaleTo(0.4, var_20_0))))
			end))
			var_20_2:setTouchEnabled(true)
			var_20_2:setTouchSwallow(true)
			var_20_2:addTouchEventListener(function(arg_22_0, arg_22_1)
				if arg_22_1 == ccui.TouchEventType.ended then
					if not arg_22_0._isOpened then
						return arg_20_0:openCard(var_20_2)
					else
						for iter_22_0 = 1, #lc._runningScene._scene:getChildren() do
							if lc._runningScene._scene:getChildren()[iter_22_0]._panelName == "CardInfoPanel" then
								return
							end
						end

						return require("CardInfoPanel").create(arg_22_0._card._infoId):show()
					end
				end
			end)
		end
	end
end

function var_0_0.openCard(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1._card

	arg_23_1._isOpened = true

	lc.Audio.playAudio(AUDIO.E_TAVERN_FLIP)

	local var_23_1 = true

	for iter_23_0 = 1, 3 do
		if arg_23_0._cardThumbnails[iter_23_0] and not arg_23_0._cardThumbnails[iter_23_0]._isOpened then
			var_23_1 = false

			break
		end
	end

	if var_23_1 then
		arg_23_0:showButtons()
	end

	if var_23_0._num > 1 then
		local var_23_2 = lc.createSprite("critical_title_" .. var_23_0._num)

		lc.addChildToPos(arg_23_1, var_23_2, cc.p(lc.cw(arg_23_1), lc.ch(arg_23_1)), 10)
		var_23_2:setScale(0)
		var_23_2:runAction(lc.sequence(lc.ease(lc.scaleTo(0.2, 2), "BackO"), lc.spawn(lc.moveTo(0.3, cc.p(lc.cw(arg_23_1), lc.h(arg_23_1) + 80)), lc.scaleTo(0.3, 0.8))))

		local var_23_3 = lc.createSprite("critical_num_" .. var_23_0._num)

		lc.addChildToPos(arg_23_1, var_23_3, cc.p(lc.cw(arg_23_1), -80))
		var_23_3:setScale(0)
		var_23_3:runAction(lc.ease(lc.scaleTo(0.5, 0.8), "BackO"))

		local var_23_4 = Particle.create("baoji1")

		lc.addChildToCenter(arg_23_1, var_23_4)

		local var_23_5 = Particle.create("baoji2")

		lc.addChildToCenter(arg_23_1, var_23_5)
	end

	arg_23_1._cardBack:runAction(lc.sequence(lc.rotateTo(0.3, 0, 90, 0), lc.hide()))
	arg_23_1._cardSprite:setRotation3D({
		z = 0,
		x = 0,
		y = -90
	})
	arg_23_1._cardSprite:runAction(lc.sequence(0.3, lc.show(), lc.rotateTo(0.3, 0, 0, 0)))
	arg_23_1._effectNode:runAction(lc.rotateTo(0.6, 0, 180, 0))
	arg_23_1._effectNode:runAction(lc.sequence(0.3, function()
		local var_24_0 = Data.getInfo(arg_23_1._card._infoId)

		if var_24_0._quality == Data.CardQuality.N then
			local var_24_1 = Particle.create("par_n")

			lc.addChildToCenter(arg_23_1._effectNode, var_24_1)
			var_24_1:setPositionType(cc.POSITION_TYPE_GROUPED)
		elseif var_24_0._quality == Data.CardQuality.R then
			local var_24_2 = Particle.create("par_r")

			lc.addChildToCenter(arg_23_1._effectNode, var_24_2)
			var_24_2:setPositionType(cc.POSITION_TYPE_GROUPED)
		elseif var_24_0._quality == Data.CardQuality.SR then
			local var_24_3 = Particle.create("par_sr01")

			lc.addChildToCenter(arg_23_1._effectNode, var_24_3)
			var_24_3:setPositionType(cc.POSITION_TYPE_GROUPED)

			local var_24_4 = Particle.create("par_sr02")

			lc.addChildToCenter(arg_23_1._effectNode, var_24_4)
			var_24_4:setPositionType(cc.POSITION_TYPE_GROUPED)

			local var_24_5 = Particle.create("par_srxz")

			lc.addChildToCenter(arg_23_1, var_24_5, -1)
		elseif var_24_0._quality == Data.CardQuality.UR then
			local var_24_6 = Particle.create("par_ur01")

			lc.addChildToCenter(arg_23_1._effectNode, var_24_6)
			var_24_6:setPositionType(cc.POSITION_TYPE_GROUPED)

			local var_24_7 = Particle.create("par_ur02")

			lc.addChildToCenter(arg_23_1._effectNode, var_24_7)
			var_24_7:setPositionType(cc.POSITION_TYPE_GROUPED)

			local var_24_8 = Particle.create("par_ur03")

			lc.addChildToCenter(arg_23_1._effectNode, var_24_8)
			var_24_8:setPositionType(cc.POSITION_TYPE_GROUPED)

			local var_24_9 = Particle.create("par_urxz")

			lc.addChildToCenter(arg_23_1, var_24_9, -1)
			lc.Audio.playAudio(AUDIO.E_TAVERN_FLIP_UR)
		end
	end))
	GuideManager.closeNpcTipLayer()
end

function var_0_0.showButtons(arg_25_0)
	local var_25_0 = lc._runningScene
	local var_25_1 = arg_25_0._packageIndex * var_0_0.PACKAGE_CARD_COUNT >= #arg_25_0._newCards
	local var_25_2

	var_25_2 = arg_25_0._packageIndex == 1 and var_25_1

	local var_25_3 = cc.Node:create()

	lc.addChildToPos(arg_25_0, var_25_3, cc.p(lc.cw(arg_25_0), 70))

	if var_25_1 then
		local var_25_4 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_26_0)
			arg_25_0:finish()
		end, ClientView.CRECT_BUTTON, 300)

		lc.addChildToCenter(var_25_3, var_25_4)
		var_25_4:addLabel(Str(STR.BACK))

		arg_25_0._btnBack = var_25_4
	else
		local var_25_5 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_27_0)
			var_0_0.create(var_0_0.Mode.open_one, arg_25_0._newCards, arg_25_0._recruitInfo, arg_25_0._recruitInfoOnce, arg_25_0._packageIndex + 1):show()
			arg_25_0:removeFromParent()
		end, ClientView.CRECT_BUTTON, 300)

		var_25_5:addLabel(Str(STR.RECRUIT_NEXT_ONE))
		lc.addChildToCenter(var_25_3, var_25_5)

		arg_25_0._btnNext = var_25_5
	end

	var_25_3:setScale(0)
	var_25_3:runAction(lc.sequence(lc.delay(0.4), lc.ease(lc.scaleTo(0.5, 1), "BackO")))
	GuideManager.finishStepLater(0.5)
end

function var_0_0.onGuide(arg_28_0, arg_28_1)
	local var_28_0 = GuideManager.getCurStepName()

	if var_28_0 == "open package" then
		GuideManager.setOperateLayer(arg_28_0._package)
	elseif var_28_0 == "click card" then
		GuideManager.setOperateLayer(arg_28_0._cardThumbnails[1])
	elseif var_28_0 == "leave card reward" then
		GuideManager.setOperateLayer(arg_28_0._btnBack, nil, arg_28_0._cardThumbnails)

		for iter_28_0 = 1, #lc._runningScene._scene:getChildren() do
			if lc._runningScene._scene:getChildren()[iter_28_0]._panelName == "CardInfoPanel" then
				GuideManager.pauseGuide()

				break
			end
		end
	else
		return
	end

	arg_28_1:stopPropagation()
end

function var_0_0.finish(arg_29_0)
	local var_29_0 = arg_29_0._newCards

	arg_29_0:hide()

	return lc._runningScene:afterOpenPackage(var_29_0)
end

function var_0_0.showTotalCards(arg_30_0)
	arg_30_0._isShowTotalList = true

	local var_30_0 = {}

	for iter_30_0 = 1, #arg_30_0._newCards do
		local var_30_1 = arg_30_0._newCards[iter_30_0]
		local var_30_2 = #var_30_0 + 1

		for iter_30_1 = 1, #var_30_0 do
			if var_30_0[iter_30_1]._infoId == var_30_1._infoId then
				var_30_2 = iter_30_1

				break
			end
		end

		if not var_30_0[var_30_2] then
			var_30_0[var_30_2] = {
				_infoId = var_30_1._infoId,
				_num = var_30_1._num
			}
		else
			var_30_0[var_30_2]._num = var_30_0[var_30_2]._num + var_30_1._num
		end
	end

	table.sort(var_30_0, function(arg_31_0, arg_31_1)
		return Data.getInfo(arg_31_0._infoId)._quality > Data.getInfo(arg_31_1._infoId)._quality
	end)

	local var_30_3 = lc.createSprite("img_title_bg")

	var_30_3:setScale(600 / lc.w(var_30_3), 1)
	lc.addChildToPos(arg_30_0, var_30_3, cc.p(lc.w(arg_30_0) / 2, lc.h(arg_30_0) - 50))

	local var_30_4 = ClientView.createTTF(Str(STR.GET) .. Str(STR.CARD), ClientView.FontSize.S1, lc.Color3B.yellow)

	lc.addChildToPos(arg_30_0, var_30_4, cc.p(lc.x(var_30_3), lc.y(var_30_3)))

	local var_30_5 = math.min(ClientView.SCR_W - 240, 800)

	arg_30_0._cardList = require("CardList").create(cc.size(var_30_5, 500), 0.5, false)

	arg_30_0._cardList:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_30_0, arg_30_0._cardList, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 20))

	local var_30_6 = 20

	arg_30_0._cardList._pageLeft._pos = cc.p(-var_30_6, lc.ch(arg_30_0._cardList))
	arg_30_0._cardList._pageRight._pos = cc.p(lc.w(arg_30_0._cardList) + var_30_6, lc.ch(arg_30_0._cardList))

	local var_30_7 = 240 - (lc.x(arg_30_0._cardList) - lc.cw(arg_30_0._cardList))
	local var_30_8 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_30_0._cardList, var_30_8, cc.p(lc.cw(var_30_8) + var_30_7, -8), -1)
	var_30_8:setFlippedX(true)
	var_30_8:setScale(1, 0.9)
	arg_30_0._cardList._pageLabel:setPosition(cc.p(var_30_8:getPosition()))
	arg_30_0._cardList:setMode(require("CardList").ModeType.recruite_list)

	arg_30_0._cardList._recruiteInfo = var_30_0

	arg_30_0._cardList:init(nil, {})
	arg_30_0._cardList:refresh(true)
	arg_30_0._cardList:registerCardSelectedHandler(function(arg_32_0)
		require("CardInfoPanel").create(arg_32_0, 1, require("CardInfoPanel").OperateType.view):show()
	end)

	local var_30_9 = cc.Node:create()

	lc.addChildToPos(arg_30_0, var_30_9, cc.p(lc.cw(arg_30_0), 70))

	local var_30_10 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_33_0)
		arg_30_0:finish()
	end, ClientView.CRECT_BUTTON, 300)

	var_30_10:addLabel(Str(STR.BACK))
	lc.addChildToCenter(var_30_9, var_30_10)

	arg_30_0._btnBack = var_30_10

	arg_30_0._cardList:setPosition(cc.p(ClientView.SCR_CW, -lc.ch(arg_30_0._cardList)))
	arg_30_0._cardList:runAction(lc.sequence(lc.delay(0.5), lc.ease(lc.moveTo(0.5, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 20)), "BackO")))
	var_30_9:setScale(0)
	var_30_9:runAction(lc.sequence(lc.delay(1), lc.ease(lc.scaleTo(0.5, 1), "BackO")))
end

return var_0_0
