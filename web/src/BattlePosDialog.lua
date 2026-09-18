local var_0_0 = class("BattlePosDialog", lc.ExtendUIWidget)

BattlePosDialog = var_0_0
var_0_0.Mode = {
	sync = 2,
	summon = 1,
	link = 4,
	xyz = 3
}
var_0_0.ITEM_SIZE = cc.size(134, 196)

local var_0_1 = 0.5
local var_0_2 = 0.35

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9)
	arg_2_0._battleUi = arg_2_1
	arg_2_0._playerUi = arg_2_2
	arg_2_0._pCard = arg_2_3
	arg_2_0._pTargetCard = arg_2_4
	arg_2_0._skill = arg_2_5
	arg_2_0._choiceBase = arg_2_6
	arg_2_0._toBoardCards = arg_2_7
	arg_2_0._boardCards = arg_2_8
	arg_2_0._mode = arg_2_9

	arg_2_0:setContentSize(ClientView.SCR_SIZE)
	arg_2_0:setAnchorPoint(cc.p(0.5, 0.5))

	arg_2_0._posList = {}

	arg_2_0:initTitle()
	arg_2_0:initBoard()
	arg_2_0:initButtons()
	arg_2_0:initCardList()
	arg_2_0:updateView()
	arg_2_0:setTouchEnabled(false)
	arg_2_0._battleUi._btnSetting:setEnabled(false)
	arg_2_0._battleUi._btnAuto:setEnabled(false)
end

function var_0_0.show(arg_3_0)
	arg_3_0._confirmButton:setEnabled(false)
	lc.addChildToCenter(arg_3_0._battleUi._scene, arg_3_0, BattleScene.ZOrder.top)
end

function var_0_0.hide(arg_4_0)
	arg_4_0._battleUi._choicePosDialog = nil

	if arg_4_0._pCard._card._status == BattleData.CardStatus.hand then
		arg_4_0._pCard:setVisible(true)
		arg_4_0._playerUi:playAction(arg_4_0._pCard, PlayerUi.Action.replace_hand_card, 0, 1)
	end

	arg_4_0._battleUi._btnSetting:setEnabled(true)
	arg_4_0._battleUi._btnAuto:setEnabled(true)
	arg_4_0:removeFromParent()
end

function var_0_0.cancel(arg_5_0)
	arg_5_0:hide()
end

function var_0_0.confirm(arg_6_0)
	local var_6_0 = {
		[BattleData.ExtraType.pos] = {}
	}

	for iter_6_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		if arg_6_0._posList[iter_6_0] then
			var_6_0[BattleData.ExtraType.pos][#var_6_0[BattleData.ExtraType.pos] + 1] = iter_6_0 * 10000 + arg_6_0._posList[iter_6_0]._id
		end
	end

	arg_6_0._playerUi:sendEvent(PlayerUi.EventType.send_use_card, {
		_card = arg_6_0._pCard._card,
		_target = arg_6_0._pTargetCard ~= nil and arg_6_0._pTargetCard._card or nil,
		_choice = arg_6_0._choiceBase,
		_extra = var_6_0
	})
	arg_6_0:hide()
end

function var_0_0.auto(arg_7_0)
	arg_7_0._playerUi:sendEvent(PlayerUi.EventType.send_use_card, {
		_card = arg_7_0._pCard._card,
		_target = arg_7_0._pTargetCard ~= nil and arg_7_0._pTargetCard._card or nil,
		_choice = arg_7_0._choiceBase
	})
	arg_7_0:hide()
end

function var_0_0.onTouchBegan(arg_8_0, arg_8_1)
	arg_8_0._isTouchMoved = false
	arg_8_0._touchCard = arg_8_0:getTouchCard(arg_8_1)

	if arg_8_0._touchCard ~= nil then
		arg_8_0._arrow = BattleLine.create(cc.p(arg_8_0._touchCard:getPosition()), true)

		arg_8_0:addChild(arg_8_0._arrow)
	else
		arg_8_0._touchRect = arg_8_0:getTouchRect(arg_8_1)
	end

	return true
end

function var_0_0.onTouchMoved(arg_9_0, arg_9_1)
	if cc.pGetDistance(arg_9_1:getLocation(), arg_9_1:getStartLocation()) > lc.Gesture.BUDGE_LIMIT then
		arg_9_0._isTouchMoved = true
	end

	if arg_9_0._touchCard == nil then
		return
	end

	local var_9_0 = false
	local var_9_1 = arg_9_0:getTouchRect(arg_9_1)

	if var_9_1 ~= nil and arg_9_0._boardCards[var_9_1._pos] == nil and arg_9_0._posList[var_9_1._pos] == nil and arg_9_0:isPosValid(arg_9_0._touchCard._card, var_9_1._pos) then
		var_9_0 = true
	end

	if arg_9_0._arrow then
		arg_9_0._arrow:directTo(arg_9_1:getLocation(), var_9_0 and var_9_1 or nil)
	end
end

function var_0_0.onTouchEnded(arg_10_0, arg_10_1)
	if arg_10_0._touchCard then
		arg_10_0:removeArrow()

		if arg_10_0._isTouchMoved then
			local var_10_0 = arg_10_0:getTouchRect(arg_10_1)

			arg_10_0:tryAddCardToRect(arg_10_0._touchCard, var_10_0)
		end

		arg_10_0._touchCard = nil
	elseif arg_10_0._touchRect then
		if not arg_10_0._isTouchMoved then
			if arg_10_0._posList[arg_10_0._touchRect._pos] == nil then
				if arg_10_0._widgets[1]:isEnabled() then
					arg_10_0:tryAddCardToRect(arg_10_0._widgets[1], arg_10_0._touchRect)
				end
			else
				arg_10_0:removeCardFromRect(arg_10_0._touchRect)
			end
		end

		arg_10_0._touchRect = nil
	elseif not arg_10_0._isTouchMoved then
		arg_10_0:cancel()
	end
end

function var_0_0.onTouchCancelld(arg_11_0)
	return
end

function var_0_0.getTouchCard(arg_12_0, arg_12_1)
	for iter_12_0 = 1, #arg_12_0._widgets do
		local var_12_0 = arg_12_0._widgets[iter_12_0]

		if var_12_0:isEnabled() and cc.rectContainsPoint(cc.rect(lc.left(var_12_0), lc.bottom(var_12_0), lc.sw(var_12_0), lc.sh(var_12_0)), arg_12_1:getLocation()) then
			return var_12_0
		end
	end
end

function var_0_0.getTouchRect(arg_13_0, arg_13_1)
	for iter_13_0 = 1, #arg_13_0._rects do
		local var_13_0 = arg_13_0._rects[iter_13_0]
		local var_13_1 = var_13_0:convertToNodeSpace(cc.p(arg_13_1:getLocation()))

		if cc.rectContainsPoint(cc.rect(0, 0, lc.w(var_13_0), lc.h(var_13_0)), var_13_1) then
			return var_13_0
		end
	end
end

function var_0_0.removeArrow(arg_14_0)
	if arg_14_0._arrow then
		arg_14_0._arrow:removeFromParent()

		arg_14_0._arrow = nil
	end
end

function var_0_0.isPosValid(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._mode == var_0_0.Mode.summon or arg_15_0._mode == var_0_0.Mode.sync or arg_15_0._mode == var_0_0.Mode.xyz then
		if arg_15_2 == 6 then
			return false
		end
	elseif arg_15_0._mode == var_0_0.Mode.link then
		if arg_15_0._linkPos[arg_15_2] ~= true then
			return false
		end
	elseif arg_15_0._mode == 9280 then
		return arg_15_2 ~= 6 and arg_15_0._pCard._card:isCardEmptyLinkPos(arg_15_2)
	end

	return true
end

function var_0_0.tryAddCardToRect(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 ~= nil and arg_16_0._boardCards[arg_16_2._pos] == nil and arg_16_0._posList[arg_16_2._pos] == nil and arg_16_0:isPosValid(arg_16_1._card, arg_16_2._pos) then
		arg_16_1:setEnabled(false)
		arg_16_1:setGray(true)

		arg_16_0._posList[arg_16_2._pos] = arg_16_1._card
		arg_16_2._toBoardWidget = arg_16_1

		local var_16_0 = arg_16_0:createCardItem(arg_16_1._card)

		if arg_16_2._pos == 2 or arg_16_2._pos == 6 then
			var_16_0:setScale(var_0_2)
		end

		lc.addChildToCenter(arg_16_2, var_16_0)

		arg_16_2._widget = var_16_0

		arg_16_0:updateView()
	end
end

function var_0_0.removeCardFromRect(arg_17_0, arg_17_1)
	arg_17_0._posList[arg_17_1._pos] = nil

	arg_17_1._toBoardWidget:setEnabled(true)
	arg_17_1._toBoardWidget:setGray(false)
	arg_17_1._widget:removeFromParent()
	arg_17_0:updateView()
end

function var_0_0.initTitle(arg_18_0)
	local var_18_0 = ClientView.createTTF(Str(STR.POS_TITLE), ClientView.FontSize.M1)

	lc.addChildToPos(arg_18_0, var_18_0, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 320), 10)
	var_18_0:setColor(ClientView.COLOR_TEXT_TITLE)

	arg_18_0._titleLabel = var_18_0
end

function var_0_0.initBoard(arg_19_0)
	local var_19_0 = lc.createNode(cc.size(lc.w(arg_19_0._battleUi._battleFrame), 200), cc.p(0.5, 0.5))

	var_19_0:setScale(0.9)
	lc.addChildToPos(arg_19_0, var_19_0, cc.p(lc.cw(arg_19_0), lc.ch(arg_19_0) + 120))

	local var_19_1 = {
		3,
		4,
		2,
		5,
		1,
		4
	}
	local var_19_2 = {}
	local var_19_3 = {}
	local var_19_4 = PlayerUi.Pos.attacker_board_x
	local var_19_5 = PlayerUi.Pos.board_pos_dy

	for iter_19_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_19_6 = lc.createSprite((iter_19_0 == 2 or iter_19_0 == 6) and "battle_board_small_01" or "battle_board_large_01")

		lc.addChildToPos(var_19_0, var_19_6, cc.p(98 + var_19_1[iter_19_0] * 176, lc.ch(var_19_0) + ((iter_19_0 == 2 or iter_19_0 == 6) and (iter_19_0 == 2 and -var_19_5[2] or var_19_5[1]) or 0)))

		var_19_6._pos = iter_19_0
		var_19_3[iter_19_0] = var_19_6

		local var_19_7 = arg_19_0._boardCards[iter_19_0]

		if var_19_7 ~= nil then
			local var_19_8 = arg_19_0:createCardItem(var_19_7)

			if iter_19_0 == 2 or iter_19_0 == 6 then
				var_19_8:setScale(var_0_2)
			end

			var_19_8:setGray(true)
			lc.addChildToCenter(var_19_6, var_19_8)
		end
	end

	arg_19_0._rects = var_19_3
end

function var_0_0.initButtons(arg_20_0)
	local var_20_0 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_21_0)
		arg_20_0:confirm()
	end, ClientView.CRECT_BUTTON, 180)

	lc.addChildToPos(arg_20_0, var_20_0, cc.p(ClientView.SCR_CW + 200, 100), 10)
	var_20_0:addLabel(Str(STR.OK))
	var_20_0:setDisabledShader(ClientView.SHADER_DISABLE)

	arg_20_0._confirmButton = var_20_0

	local var_20_1 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_22_0)
		arg_20_0:auto()
	end, ClientView.CRECT_BUTTON, 180)

	lc.addChildToPos(arg_20_0, var_20_1, cc.p(ClientView.SCR_CW - 200, 100), 10)
	var_20_1:addLabel(Str(STR.POS_AUTO))
	var_20_1:setDisabledShader(ClientView.SHADER_DISABLE)

	arg_20_0._autoButton = var_20_1

	local var_20_2 = ClientView.createTTF(Str(STR.POS_DIALOG_TIP), ClientView.FontSize.S1)

	lc.addChildToPos(arg_20_0, var_20_2, cc.p(ClientView.SCR_CW, 40), 10)
end

function var_0_0.initCardList(arg_23_0)
	arg_23_0._widgets = {}

	if var_0_0.ITEM_SIZE.width * #arg_23_0._toBoardCards < ClientView.SCR_W then
		for iter_23_0 = 1, #arg_23_0._toBoardCards do
			local var_23_0 = arg_23_0._toBoardCards[iter_23_0]
			local var_23_1 = cc.p(ClientView.SCR_CW + (iter_23_0 - (#arg_23_0._toBoardCards + 1) / 2) * var_0_0.ITEM_SIZE.width, ClientView.SCR_CH - 120)
			local var_23_2 = arg_23_0:createCardItem(var_23_0)

			lc.addChildToPos(arg_23_0, var_23_2, var_23_1)
			table.insert(arg_23_0._widgets, var_23_2)
		end
	else
		local var_23_3 = lc.List.createH(cc.size(ClientView.SCR_W, var_0_0.ITEM_SIZE.height + 100))

		var_23_3:setAnchorPoint(cc.p(0.5, 0.5))
		lc.addChildToCenter(arg_23_0, var_23_3)

		for iter_23_1 = 1, #arg_23_0._toBoardCards do
			local var_23_4 = arg_23_0._toBoardCards[iter_23_1]
			local var_23_5 = arg_23_0:createCardItem(var_23_4)

			var_23_3:pushBackCustomItem(var_23_5)
			table.insert(arg_23_0._widgets, var_23_5)
		end
	end
end

function var_0_0.createCardItem(arg_24_0, arg_24_1)
	local var_24_0
	local var_24_1 = require("CardThumbnail").create(arg_24_1._infoId, nil, arg_24_1._originOwner._skins[arg_24_1._infoId])

	if not arg_24_1:isXYZ() and not arg_24_1:isLink() then
		var_24_1._frame._starArea:update(arg_24_1:getStar(), arg_24_1._infoId)
	end

	var_24_1._card = arg_24_1

	var_24_1:setScale(var_0_1)

	return var_24_1
end

function var_0_0.onSelectItem(arg_25_0, arg_25_1)
	local var_25_0 = require("CardInfoPanel")

	var_25_0.create(arg_25_1._infoId, 1, var_25_0.OperateType.na, arg_25_1, statusStrs):show()
end

function var_0_0.refreshPosDialogLinkPos(arg_26_0)
	arg_26_0._linkPos = {}
	arg_26_0._linkPos[Data.MAX_CARD_COUNT_ON_BOARD + 1] = true

	for iter_26_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		local var_26_0 = arg_26_0._boardCards[iter_26_0] or arg_26_0._posList[iter_26_0]

		if var_26_0 ~= nil and var_26_0:isLink() then
			for iter_26_1 = 1, #var_26_0._info._link do
				local var_26_1 = BattleData.LINK_POS[iter_26_0][var_26_0._info._link[iter_26_1]]

				if var_26_1 > 0 then
					arg_26_0._linkPos[var_26_1] = true
				end
			end
		end
	end

	local var_26_2 = arg_26_0._playerUi._player._opponent._boardCards[6]

	if var_26_2 ~= nil and var_26_2:isLink() then
		for iter_26_2 = 1, #var_26_2._info._link do
			local var_26_3 = BattleData.LINK_POS[6][var_26_2._info._link[iter_26_2]]

			if var_26_3 < 0 then
				arg_26_0._linkPos[-var_26_3] = true
			end
		end
	end
end

function var_0_0.updateLinkRects(arg_27_0)
	for iter_27_0 = 1, Data.MAX_CARD_COUNT_ON_BOARD + 1 do
		arg_27_0._rects[iter_27_0]:setSpriteFrame(((iter_27_0 == 2 or iter_27_0 == 6) and "battle_board_small_0" or "battle_board_large_0") .. (arg_27_0._linkPos[iter_27_0] and 2 or 1))
	end
end

function var_0_0.updateView(arg_28_0)
	arg_28_0:refreshPosDialogLinkPos()
	arg_28_0:updateLinkRects()

	if arg_28_0._confirmButton then
		arg_28_0._confirmButton:setEnabled(B.tableCount(arg_28_0._posList) == #arg_28_0._toBoardCards)
	end
end
