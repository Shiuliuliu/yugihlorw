local var_0_0 = class("CardPackagePanel", require("BasePanel"))
local var_0_1 = require("CardThumbnail")

var_0_0.PACKAGE_CARD_COUNT = 3

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, true)

	arg_2_0._cardId = arg_2_1

	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 == ccui.TouchEventType.ended then
			return true
		end
	end)
end

function var_0_0.onEnter(arg_4_0)
	var_0_0.super.onEnter(arg_4_0)

	arg_4_0._listeners = {}

	arg_4_0:start()
end

function var_0_0.onExit(arg_5_0)
	var_0_0.super.onExit(arg_5_0)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_5_1)
	end
end

function var_0_0.onCleanup(arg_6_0)
	var_0_0.super.onCleanup(arg_6_0)

	if arg_6_0._cardThumbnails then
		for iter_6_0 = 1, #arg_6_0._cardThumbnails do
			var_0_1.releaseToPool(arg_6_0._cardThumbnails[iter_6_0]._cardSprite)
		end
	end
end

function var_0_0.start(arg_7_0)
	lc.Audio.playAudio(AUDIO.E_TAVERN_OPEN_PACKAGE)
	arg_7_0:runAction(lc.sequence(0, function()
		local var_8_0 = Particle.create("hecheng_1")

		lc.addChildToPos(arg_7_0, var_8_0, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 260), 20)
	end, 0.15, function()
		local var_9_0 = Particle.create("hecheng_2")

		lc.addChildToCenter(arg_7_0, var_9_0, 20)
	end, 0.65, function()
		local var_10_0 = Particle.create("hecheng_3")

		lc.addChildToCenter(arg_7_0, var_10_0, 20)
	end, 0.15, function()
		local var_11_0 = Particle.create("hecheng_4")

		lc.addChildToCenter(arg_7_0, var_11_0)
	end, 0.15, function()
		arg_7_0:showCards()
	end))
end

function var_0_0.showCards(arg_13_0)
	arg_13_0._isEndShowCards = false

	local var_13_0 = Data.getInfo(arg_13_0._cardId)
	local var_13_1 = {
		var_13_0
	}

	arg_13_0._cardThumbnails = {}

	for iter_13_0 = 1, #var_13_1 do
		local var_13_2 = var_13_1[iter_13_0]
		local var_13_3 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH)
		local var_13_4 = (iter_13_0 - 2) * 5
		local var_13_5 = ccui.Layout:create()

		var_13_5:setAnchorPoint(0.5, 0.5)
		var_13_5:setContentSize(cc.size(275, 410))
		lc.addChildToCenter(arg_13_0, var_13_5, 10)

		arg_13_0._cardThumbnails[iter_13_0] = var_13_5
		var_13_5._card = var_13_2

		local var_13_6 = var_0_1.createFromPool(arg_13_0._cardId, 1)

		var_13_6._thumbnail:updateFlag()
		lc.addChildToCenter(var_13_5, var_13_6)

		var_13_5._cardSprite = var_13_6

		local var_13_7 = cc.Node:create()

		lc.addChildToCenter(var_13_5, var_13_7)

		var_13_5._effectNode = var_13_7

		arg_13_0:endShowCards()
	end
end

function var_0_0.endShowCards(arg_14_0)
	arg_14_0._isEndShowCards = true

	local var_14_0 = 1
	local var_14_1 = {
		0.8,
		1.2,
		1
	}

	for iter_14_0 = 1, #arg_14_0._cardThumbnails do
		local var_14_2 = arg_14_0._cardThumbnails[iter_14_0]
		local var_14_3 = var_14_1[iter_14_0]
		local var_14_4 = Data.getInfo(arg_14_0._cardId)

		var_14_2:runAction(lc.sequence(lc.scaleTo(0.2 * var_14_3, var_14_0 * 1.1), lc.scaleTo(0.3 * var_14_3, var_14_0), function()
			var_14_2:runAction(lc.rep(lc.sequence(lc.scaleTo(0.3, var_14_0 * 1.05), lc.scaleTo(0.4, var_14_0))))
		end))
		var_14_2:setTouchEnabled(true)
		var_14_2:setTouchSwallow(true)
		var_14_2:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 == ccui.TouchEventType.ended then
				return require("CardInfoPanel").create(arg_14_0._cardId):show()
			end
		end)
	end

	arg_14_0:showButtons()
end

function var_0_0.showButtons(arg_17_0)
	local var_17_0 = lc.createSprite({
		_name = "img_form_title_bg_1",
		_crect = ClientView.CRECT_FORM_TITLE_BG1_CRECT,
		_size = cc.size(560, ClientView.CRECT_FORM_TITLE_BG1_CRECT.height)
	})

	lc.addChildToPos(arg_17_0, var_17_0, cc.p(lc.cw(arg_17_0), lc.ch(arg_17_0) + lc.h(var_17_0) + 200), 10)

	local var_17_1 = lc.createSprite({
		_name = "img_form_title_light_1",
		_crect = ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT,
		_size = cc.size(200, ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT.height)
	})

	lc.addChildToPos(var_17_0, var_17_1, cc.p(lc.w(var_17_0) / 2, lc.h(var_17_0) / 2 + 4))

	local var_17_2 = ClientView.createTTF(Str(STR.COMPOSE) .. Str(STR.SUCCESS), ClientView.FontSize.M1, ClientView.COLOR_TEXT_WHITE)

	var_17_2:setColor(ClientView.COLOR_TEXT_TITLE)
	var_17_2:setPosition(lc.w(var_17_0) / 2, lc.h(var_17_0) / 2 + 4)
	var_17_0:addChild(var_17_2)

	arg_17_0._titleLabel = var_17_2

	local var_17_3 = cc.Node:create()

	lc.addChildToPos(arg_17_0, var_17_3, cc.p(lc.cw(arg_17_0), 70))

	local var_17_4 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_18_0)
		arg_17_0:hide()
	end, ClientView.CRECT_BUTTON, 300)

	lc.addChildToCenter(var_17_3, var_17_4)
	var_17_4:addLabel(Str(STR.BACK))

	arg_17_0._btnBack = var_17_4

	var_17_3:setScale(0)
	var_17_3:runAction(lc.sequence(lc.delay(0.4), lc.ease(lc.scaleTo(0.5, 1), "BackO")))
end

return var_0_0
