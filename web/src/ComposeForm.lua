local var_0_0 = class("ComposeForm", BaseForm)

require("BattleListDialog")

local var_0_1 = require("PromptForm").ConfirmCompose
local var_0_2 = require("CardSprite")
local var_0_3 = cc.size(900, 700)
local var_0_4 = {
	cc.p(-250, 150),
	cc.p(-250, 0),
	cc.p(-250, -150),
	cc.p(250, 150),
	cc.p(250, 0),
	cc.p(250, -150)
}

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._rarePackageCards = arg_2_1
	arg_2_0._packgeId = arg_2_2
	arg_2_0._selectCards = {}

	var_0_0.super.init(arg_2_0, var_0_3, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form

	arg_2_0:createTransferArea()
end

function var_0_0.onCleanup(arg_3_0)
	var_0_0.super.onCleanup(arg_3_0)
end

function var_0_0.createTransferArea(arg_4_0)
	local var_4_0 = lc.createNode(arg_4_0._frame:getContentSize())

	var_4_0:setVisible(true)
	lc.addChildToCenter(arg_4_0._frame, var_4_0)

	arg_4_0._transferArea = var_4_0

	local var_4_1 = lc.w(var_4_0) / 2
	local var_4_2 = 440
	local var_4_3 = lc.createSpriteWithMask("res/jpg/add_card_bg.jpg")
	local var_4_4 = ClientView.createShaderButton(nil, function(arg_5_0)
		arg_4_0:selectTargetCard()
	end)
	local var_4_5 = lc.createSprite("img_compose_add")

	var_4_4:setContentSize(cc.size(240, 400))
	lc.addChildToCenter(var_4_4, var_4_5)
	lc.addChildToCenter(var_4_3, var_4_4)

	local var_4_6 = lc.createNode()

	lc.addChildToCenter(var_4_4, var_4_6)

	var_4_4.targetCardNode = var_4_6
	arg_4_0._addTargetBtn = var_4_4

	local var_4_7 = lc.createNode(var_4_3:getContentSize())

	lc.addChildToPos(var_4_0, var_4_7, cc.p(var_4_1, var_4_2), 1)

	arg_4_0._circle = var_4_7

	lc.addChildToCenter(var_4_7, var_4_3, -1)

	arg_4_0._slots = {}
	arg_4_0._slotBtns = {}

	for iter_4_0 = 1, #var_0_4 do
		local var_4_8 = lc.createSpriteWithMask("img_slot")

		lc.addChildToPos(var_4_7, var_4_8, cc.p(var_0_4[iter_4_0].x + lc.cw(var_4_7), var_0_4[iter_4_0].y + lc.ch(var_4_7)))

		local var_4_9 = ClientView.createShaderButton(nil, function(arg_6_0)
			arg_4_0:selectCard(iter_4_0)
		end)

		var_4_9:setContentSize(cc.size(60, 60))

		local var_4_10 = lc.createSprite("img_compose_add", cc.p(lc.cw(var_4_9), lc.ch(var_4_9)))

		var_4_10:setScale(lc.w(var_4_9) / lc.w(var_4_10), lc.h(var_4_9) / lc.h(var_4_10))
		var_4_9:addChild(var_4_10)
		var_4_9:setVisible(false)
		lc.addChildToCenter(var_4_8, var_4_9)

		local var_4_11 = lc.createNode()

		lc.addChildToCenter(var_4_8, var_4_11)
		table.insert(arg_4_0._slots, var_4_11)
		table.insert(arg_4_0._slotBtns, var_4_9)
	end

	local var_4_12 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_7_0)
		arg_4_0:onConfirmCompose()
	end, cc.rect(0, 0, 0, 0), 200, 80)

	var_4_12:setDisabledShader(ClientView.SHADER_DISABLE)
	lc.addChildToPos(var_4_0, var_4_12, cc.p(lc.cw(var_4_0), 80))

	local var_4_13 = ClientView.createBMFont(ClientView.BMFont.huali_32, Str(STR.MERGE_RESULT))

	var_4_13:setColor(lc.Color3B.white)
	var_4_13:setAdditionalKerning(10)
	lc.addChildToPos(var_4_12, var_4_13, cc.p(lc.w(var_4_12) / 2, 40))

	arg_4_0._composeBtn = var_4_12

	local var_4_14 = 400
	local var_4_15 = lc.createSprite("img_com_bg_38")

	var_4_15:setScale(var_4_14 / lc.w(var_4_15), 80 / lc.h(var_4_15))
	lc.addChildToPos(var_4_0, var_4_15, cc.p(var_4_1 + var_4_14 / 2, 180))

	local var_4_16 = lc.createSprite("img_com_bg_38")

	var_4_16:setScale(-var_4_14 / lc.w(var_4_16), 80 / lc.h(var_4_16))
	lc.addChildToPos(var_4_0, var_4_16, cc.p(var_4_1 - var_4_14 / 2, 180))

	local var_4_17 = ClientView.createTTF(Str(STR.COMPOSE_TIP), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(500, 0), cc.TEXT_ALIGNMENT_CENTER)

	lc.addChildToPos(var_4_0, var_4_17, cc.p(var_4_1, 180))
	arg_4_0:clearSelectedCards()
end

function var_0_0.selectTargetCard(arg_8_0)
	local var_8_0 = {}

	for iter_8_0 = 1, #arg_8_0._rarePackageCards do
		local var_8_1 = {
			_infoId = arg_8_0._rarePackageCards[iter_8_0]
		}

		table.insert(var_8_0, var_8_1)
	end

	local var_8_2 = BattleListDialog.create(lc._runningScene, var_8_0, BattleListDialog.Mode.compose, Str(STR.SELECT_COMPOSE_CARD))

	var_8_2:setChoiceFunction(function(arg_9_0)
		return
	end, function(arg_10_0)
		arg_8_0:onTargetSelected(arg_10_0)
	end, function(arg_11_0)
		return
	end)
	var_8_2:show()
end

function var_0_0.onTargetSelected(arg_12_0, arg_12_1)
	arg_12_0._targetCard = arg_12_1

	arg_12_0._addTargetBtn.targetCardNode:removeAllChildren()

	local var_12_0 = ClientView.createCardFrame(arg_12_0._targetCard)

	lc.addChildToCenter(arg_12_0._addTargetBtn.targetCardNode, var_12_0)
	arg_12_0:clearSelectedCards()
end

function var_0_0.selectCard(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0 = 1, #arg_13_0._slots do
		local var_13_2 = arg_13_0._slots[iter_13_0]._card

		if var_13_2 ~= nil then
			if iter_13_0 ~= arg_13_1 then
				var_13_0[#var_13_0 + 1] = var_13_2
			else
				local var_13_3 = var_13_2
			end
		end
	end

	local var_13_4 = {}

	for iter_13_1 = 1, #arg_13_0._rarePackageCards do
		if arg_13_0._rarePackageCards[iter_13_1] ~= arg_13_0._targetCard and P._playerCard:getCardFreeCount(arg_13_0._rarePackageCards[iter_13_1]) > 0 then
			table.insert(var_13_4, arg_13_0._rarePackageCards[iter_13_1])
		end
	end

	local var_13_5 = require("CardSelectForm").createRareComposeForm(var_13_4, arg_13_0._selectCards)

	var_13_5:registerSelectedHandler(function(arg_14_0)
		arg_13_0:updateSelectedCards(arg_14_0)
	end)
	var_13_5:show()
end

function var_0_0.updateSelectedCard(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._slots[arg_15_1]

	var_15_0:removeAllChildren()

	var_15_0._card = nil

	if arg_15_2 ~= nil then
		local var_15_1 = IconWidget.createByInfoId(arg_15_2)

		function var_15_1._callback()
			arg_15_0:selectCard(arg_15_1)
		end

		lc.addChildToCenter(var_15_0, var_15_1)

		var_15_0._card = arg_15_2
	end
end

function var_0_0.updateSelectedCards(arg_17_0, arg_17_1)
	local var_17_0 = 1

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		for iter_17_2 = 1, iter_17_1 do
			local var_17_1 = arg_17_0._slots[var_17_0]

			arg_17_0._slotBtns[var_17_0]:setVisible(arg_17_0._targetCard ~= nil)
			var_17_1:removeAllChildren()

			var_17_1._card = nil

			local var_17_2 = IconWidget.createByInfoId(iter_17_0)

			function var_17_2._callback()
				arg_17_0:selectCard(var_17_0)
			end

			lc.addChildToCenter(var_17_1, var_17_2)

			var_17_1._card = iter_17_0
			var_17_0 = var_17_0 + 1
		end
	end

	for iter_17_3 = var_17_0, #arg_17_0._slots do
		local var_17_3 = arg_17_0._slots[iter_17_3]

		arg_17_0._slotBtns[iter_17_3]:setVisible(arg_17_0._targetCard ~= nil)
		var_17_3:removeAllChildren()

		var_17_3._card = nil
	end

	arg_17_0._composeBtn:setEnabled(var_17_0 == 7)
end

function var_0_0.clearSelectedCards(arg_19_0)
	arg_19_0._selectCards = {}

	arg_19_0:updateSelectedCards(arg_19_0._selectCards)
end

function var_0_0.transferAutoAdd(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = P._playerCard:getCards(arg_20_0._cardType)

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		if iter_20_1:getQuality() == Data.CardQuality.good and not iter_20_1._isSelected then
			var_20_0[#var_20_0 + 1] = iter_20_1
		end
	end

	local var_20_2 = 1

	for iter_20_2 = 1, #arg_20_0._slots do
		if var_20_0[var_20_2] == nil then
			break
		end

		if arg_20_0._slots[iter_20_2]._card == nil then
			arg_20_0:updateSelectedCard(iter_20_2, var_20_0[var_20_2])

			var_20_2 = var_20_2 + 1
		end
	end
end

function var_0_0.onConfirmCompose(arg_21_0)
	local function var_21_0()
		P._playerCard:addCard(arg_21_0._targetCard, 1)

		for iter_22_0, iter_22_1 in pairs(arg_21_0._selectCards) do
			P._playerCard:removeCard(iter_22_0, iter_22_1)
		end

		arg_21_0:hide()
		require("RewardCardPanel").create(Str(STR.MERGE_RESULT) .. Str(STR.SUCCESS), {
			{
				_infoId = arg_21_0._targetCard
			}
		}):show()
		lc.Audio.playAudio(AUDIO.E_CARD_GET)
		ClientData.sendCardCompose(arg_21_0._packgeId, arg_21_0._targetCard, arg_21_0._selectCards)
	end

	var_0_1.create(arg_21_0._targetCard, arg_21_0._selectCards, var_21_0):show()
end

return var_0_0
