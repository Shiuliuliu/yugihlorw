local var_0_0 = class("BattleTestListDialog", lc.ExtendUIWidget)

BattleTestListDialog = var_0_0
var_0_0.Mode = {
	choice = 2,
	list = 1,
	single_choice = 3
}
var_0_0.SwapTarget = {
	opponent = 2,
	player = 1
}
var_0_0.ITEM_SIZE = cc.size(210, 360)

local var_0_1

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0._battleUi = arg_2_1
	arg_2_0._cardInfos = arg_2_2
	arg_2_0._mode = arg_2_3
	arg_2_0._title = arg_2_4
	arg_2_0._touchTarget = arg_2_5

	arg_2_0:setContentSize(ClientView.SCR_SIZE)
	arg_2_0:setAnchorPoint(cc.p(0.5, 0.5))
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 == ccui.TouchEventType.ended then
			arg_2_0:cancel()
		end
	end)

	if arg_2_0._mode == var_0_0.Mode.list then
		local var_2_0 = lc.createSprite({
			_name = "img_form_title_bg_1",
			_crect = ClientView.CRECT_FORM_TITLE_BG1_CRECT,
			_size = cc.size(560, ClientView.CRECT_FORM_TITLE_BG1_CRECT.height)
		})

		lc.addChildToPos(arg_2_0, var_2_0, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 220), 10)

		local var_2_1 = lc.createSprite({
			_name = "img_form_title_light_1",
			_crect = ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT,
			_size = cc.size(200, ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT.height)
		})

		lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.w(var_2_0) / 2, lc.h(var_2_0) / 2 + 4))

		local var_2_2 = ClientView.createTTF(arg_2_4 or "", ClientView.FontSize.M1)

		var_2_2:setColor(ClientView.COLOR_TEXT_TITLE)
		lc.addChildToPos(var_2_0, var_2_2, cc.p(lc.w(var_2_0) / 2, lc.h(var_2_0) / 2 + 4))
	elseif arg_2_0._mode == var_0_0.Mode.choice then
		local var_2_3 = ClientView.createTTF(arg_2_4 or "", ClientView.FontSize.M1)

		lc.addChildToPos(arg_2_0, var_2_3, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 220), 10)
		var_2_3:setColor(ClientView.COLOR_TEXT_TITLE)

		local var_2_4 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_4_0)
			arg_2_0:confirm()
		end, ClientView.CRECT_BUTTON, 150)

		lc.addChildToPos(arg_2_0, var_2_4, cc.p(ClientView.SCR_CW, 100), 10)
		var_2_4:addLabel(Str(STR.OK))
		var_2_4:setDisabledShader(ClientView.SHADER_DISABLE)

		arg_2_0._confirmButton = var_2_4
	elseif arg_2_0._mode == var_0_0.Mode.single_choice then
		local var_2_5 = lc.createSprite({
			_name = "img_form_title_bg_1",
			_crect = ClientView.CRECT_FORM_TITLE_BG1_CRECT,
			_size = cc.size(560, ClientView.CRECT_FORM_TITLE_BG1_CRECT.height)
		})

		lc.addChildToPos(arg_2_0, var_2_5, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 220), 10)

		local var_2_6 = lc.createSprite({
			_name = "img_form_title_light_1",
			_crect = ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT,
			_size = cc.size(200, ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT.height)
		})

		lc.addChildToPos(var_2_5, var_2_6, cc.p(lc.w(var_2_5) / 2, lc.h(var_2_5) / 2 + 4))

		local var_2_7 = ClientView.createTTF((arg_2_4 or "") .. "(" .. #arg_2_2 .. ")", ClientView.FontSize.M1)

		var_2_7:setColor(ClientView.COLOR_TEXT_TITLE)
		lc.addChildToPos(var_2_5, var_2_7, cc.p(lc.w(var_2_5) / 2, lc.h(var_2_5) / 2 + 4))

		local function var_2_8(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
			local var_5_0 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_5_1)

			if arg_5_2 then
				var_5_0:setColor(arg_5_2)
			end

			if arg_5_3 then
				lc.addChildToPos(arg_5_0, var_5_0, arg_5_3)
			else
				lc.addChildToPos(arg_5_0, var_5_0, cc.p(lc.w(arg_5_0) / 2, lc.h(arg_5_0) / 2 + 1))
			end

			arg_5_0._label = var_5_0

			if arg_5_0._icon then
				lc.offset(var_5_0, 16)
				arg_5_0._icon:setPositionX(30)
			end
		end

		local var_2_9 = ClientView.createScale9ShaderButton("img_btn_squarel_s_1", function(arg_6_0)
			arg_2_0:delete()
		end, ClientView.CRECT_BUTTON, 120)

		lc.addChildToPos(arg_2_0, var_2_9, cc.p(ClientView.SCR_CW - 70, 160), 10)
		var_2_8(var_2_9, Str(STR.DELETE), nil, cc.p(lc.w(var_2_9) / 2, lc.h(var_2_9) / 2 - 13))

		arg_2_0._deleteButton = var_2_9

		local var_2_10 = ClientView.createScale9ShaderButton("img_btn_squarel_s_1", function(arg_7_0)
			arg_2_0:addSkill()
		end, ClientView.CRECT_BUTTON, 120)

		lc.addChildToPos(arg_2_0, var_2_10, cc.p(ClientView.SCR_CW + 70, 160), 10)
		var_2_8(var_2_10, Str(STR.SKILL), nil, cc.p(lc.w(var_2_10) / 2, lc.h(var_2_10) / 2 - 13))

		arg_2_0._addSkillButton = var_2_10

		local var_2_11 = ClientView.createShaderButton("img_arrow_1", function(arg_8_0)
			arg_2_0:move("left")
		end)

		lc.addChildToPos(arg_2_0, var_2_11, cc.p(ClientView.SCR_CW - 160, 145), 10)

		arg_2_0._leftButton = var_2_11

		local var_2_12 = ClientView.createShaderButton("img_arrow_1", function(arg_9_0)
			arg_2_0:move("right")
		end)

		var_2_12:setFlippedX(true)
		lc.addChildToPos(arg_2_0, var_2_12, cc.p(ClientView.SCR_CW + 160, 145), 10)

		arg_2_0._leftButton = var_2_11
	end

	arg_2_0._checkFunction = nil
	arg_2_0._confirmFunction = nil
	arg_2_0._cancelFunction = nil
	arg_2_0._selectedList = {}

	if var_0_1 ~= nil then
		local var_2_13 = arg_2_0._cardInfos[var_0_1]

		arg_2_0._selectedList[var_0_1] = var_2_13
	end

	arg_2_0:initCardList()
	arg_2_0:updateView()
end

function var_0_0.show(arg_10_0)
	lc.addChildToCenter(arg_10_0._battleUi._scene, arg_10_0, BattleScene.ZOrder.top)
end

function var_0_0.hide(arg_11_0)
	arg_11_0._selectedList = {}
	var_0_1 = nil

	arg_11_0:removeFromParent()
end

function var_0_0.cancel(arg_12_0)
	if arg_12_0._cancelFunction then
		arg_12_0._cancelFunction(arg_12_0)
	end

	arg_12_0:hide()
end

function var_0_0.confirm(arg_13_0)
	if arg_13_0._confirmFunction then
		arg_13_0._confirmFunction(arg_13_0)
	end

	arg_13_0:hide()
end

function var_0_0.delete(arg_14_0)
	local var_14_0 = arg_14_0:getSelectedCards()

	if #var_14_0 == 0 then
		ToastManager.push(Str(STR.SELECT_CARD_FIRST), 1)

		return
	end

	for iter_14_0 = 1, #var_14_0 do
		local var_14_1 = var_14_0[iter_14_0]

		if arg_14_0._touchTarget == arg_14_0._battleUi.TouchTarget.player_grave then
			if var_14_1 then
				local var_14_2 = arg_14_0._battleUi._playerUi:getCardSprite(var_14_1)

				arg_14_0._battleUi._player:removeCardFromGrave(var_14_1)
				arg_14_0._battleUi._player:removeCardFromCards(var_14_1)
				arg_14_0._battleUi._playerUi:removeCardFromGrave(var_14_1)
				arg_14_0._battleUi._playerUi:removeCardFromSprites(var_14_2)
				var_14_2:removeFromParent()
			end
		elseif arg_14_0._touchTarget == arg_14_0._battleUi.TouchTarget.player_leave then
			if var_14_1 then
				local var_14_3 = arg_14_0._battleUi._playerUi:getCardSprite(var_14_1)

				arg_14_0._battleUi._player:removeCardFromLeave(var_14_1)
				arg_14_0._battleUi._player:removeCardFromCards(var_14_1)
				arg_14_0._battleUi._playerUi:removeCardFromSprites(var_14_3)
				var_14_3:removeFromParent()
			end
		elseif arg_14_0._touchTarget == arg_14_0._battleUi.TouchTarget.player_rare then
			if var_14_1 then
				local var_14_4 = arg_14_0._battleUi._playerUi:getCardSprite(var_14_1)

				arg_14_0._battleUi._player:removeCardFromRare(var_14_1)
				arg_14_0._battleUi._player:removeCardFromCards(var_14_1)
				arg_14_0._battleUi._playerUi:removeCardFromRare(var_14_1)
				arg_14_0._battleUi._playerUi:removeCardFromSprites(var_14_4)
				var_14_4:removeFromParent()
			end
		elseif arg_14_0._touchTarget == arg_14_0._battleUi.TouchTarget.player_hand then
			if var_14_1 then
				local var_14_5 = arg_14_0._battleUi._playerUi:getCardSprite(var_14_1)

				arg_14_0._battleUi._player:removeCardFromHand(var_14_1)
				arg_14_0._battleUi._player:removeCardFromCards(var_14_1)
				arg_14_0._battleUi._playerUi:removeCardFromHand(var_14_1)
				arg_14_0._battleUi._playerUi:removeCardFromSprites(var_14_5)
				var_14_5:removeFromParent()
				arg_14_0._battleUi._playerUi:replaceHandCards(0)
			end
		elseif arg_14_0._touchTarget == arg_14_0._battleUi.TouchTarget.opponent_grave then
			if var_14_1 then
				local var_14_6 = arg_14_0._battleUi._opponentUi:getCardSprite(var_14_1)

				arg_14_0._battleUi._opponent:removeCardFromGrave(var_14_1)
				arg_14_0._battleUi._opponent:removeCardFromCards(var_14_1)
				arg_14_0._battleUi._opponentUi:removeCardFromGrave(var_14_1)
				arg_14_0._battleUi._opponentUi:removeCardFromSprites(var_14_6)
				var_14_6:removeFromParent()
			end
		elseif arg_14_0._touchTarget == arg_14_0._battleUi.TouchTarget.opponent_leave then
			if var_14_1 then
				local var_14_7 = arg_14_0._battleUi._opponentUi:getCardSprite(var_14_1)

				arg_14_0._battleUi._opponent:removeCardFromLeave(var_14_1)
				arg_14_0._battleUi._opponent:removeCardFromCards(var_14_1)
				arg_14_0._battleUi._opponentUi:removeCardFromSprites(var_14_7)
				var_14_7:removeFromParent()
			end
		elseif arg_14_0._touchTarget == arg_14_0._battleUi.TouchTarget.opponent_rare then
			if var_14_1 then
				local var_14_8 = arg_14_0._battleUi._opponentUi:getCardSprite(var_14_1)

				arg_14_0._battleUi._opponent:removeCardFromRare(var_14_1)
				arg_14_0._battleUi._opponent:removeCardFromCards(var_14_1)
				arg_14_0._battleUi._opponentUi:removeCardFromRare(var_14_1)
				arg_14_0._battleUi._opponentUi:removeCardFromSprites(var_14_8)
				var_14_8:removeFromParent()
			end
		elseif arg_14_0._touchTarget == arg_14_0._battleUi.TouchTarget.opponent_hand then
			if var_14_1 then
				local var_14_9 = arg_14_0._battleUi._opponentUi:getCardSprite(var_14_1)

				arg_14_0._battleUi._opponent:removeCardFromHand(var_14_1)
				arg_14_0._battleUi._opponent:removeCardFromCards(var_14_1)
				arg_14_0._battleUi._opponentUi:removeCardFromHand(var_14_1)
				arg_14_0._battleUi._opponentUi:removeCardFromSprites(var_14_9)
				var_14_9:removeFromParent()
				arg_14_0._battleUi._opponentUi:replaceHandCards(0)
			end
		elseif arg_14_0._touchTarget == arg_14_0._battleUi.TouchTarget.player_pile then
			if var_14_1 then
				local var_14_10 = arg_14_0._battleUi._playerUi:getCardSprite(var_14_1)

				arg_14_0._battleUi._player:removeCardFromPile(var_14_1)
				arg_14_0._battleUi._player:removeCardFromCards(var_14_1)
				arg_14_0._battleUi:updatePile(arg_14_0._battleUi._playerUi)
			end
		elseif arg_14_0._touchTarget == arg_14_0._battleUi.TouchTarget.opponent_pile and var_14_1 then
			local var_14_11 = arg_14_0._battleUi._opponentUi:getCardSprite(var_14_1)

			arg_14_0._battleUi._opponent:removeCardFromPile(var_14_1)
			arg_14_0._battleUi._opponent:removeCardFromCards(var_14_1)
			arg_14_0._battleUi:updatePile(arg_14_0._battleUi._opponentUi)
		end

		var_0_1 = nil
		arg_14_0._selectedList = {}

		arg_14_0:removeAllChildren()
		arg_14_0:init(arg_14_0._battleUi, arg_14_0._cardInfos, arg_14_0._mode, arg_14_0._title, arg_14_0._touchTarget)
	end
end

function var_0_0.move(arg_15_0, arg_15_1)
	if var_0_1 then
		local var_15_0 = arg_15_0._cardInfos[var_0_1]
		local var_15_1

		if arg_15_1 == "left" then
			if var_0_1 == 1 then
				return
			else
				var_15_1 = var_0_1 - 1
			end
		elseif arg_15_1 == "right" then
			if var_0_1 == #arg_15_0._cardInfos then
				return
			else
				var_15_1 = var_0_1 + 1
			end
		end

		local var_15_2 = arg_15_0._cardInfos[var_15_1]

		if arg_15_0._touchTarget == arg_15_0._battleUi.TouchTarget.player_grave then
			if var_15_0 and var_15_2 then
				arg_15_0:swap(var_15_0, var_15_2)
				arg_15_0._battleUi._playerUi:swapCardsInGrave(var_15_0, var_15_2)
			end
		elseif arg_15_0._touchTarget == arg_15_0._battleUi.TouchTarget.player_rare then
			if var_15_0 and var_15_2 then
				arg_15_0:swap(var_15_0, var_15_2)
				arg_15_0._battleUi._playerUi:swapCardsInRare(var_15_0, var_15_2)
			end
		elseif arg_15_0._touchTarget == arg_15_0._battleUi.TouchTarget.player_hand then
			if var_15_0 and var_15_2 then
				arg_15_0:swap(var_15_0, var_15_2)
				arg_15_0._battleUi._playerUi:swapCardsInHand(var_15_0, var_15_2)
			end
		elseif arg_15_0._touchTarget == arg_15_0._battleUi.TouchTarget.opponent_grave then
			if var_15_0 and var_15_2 then
				arg_15_0:swap(var_15_0, var_15_2)
				arg_15_0._battleUi._opponentUi:swapCardsInGrave(var_15_0, var_15_2)
			end
		elseif arg_15_0._touchTarget == arg_15_0._battleUi.TouchTarget.opponent_rare then
			if var_15_0 and var_15_2 then
				arg_15_0:swap(var_15_0, var_15_2)
				arg_15_0._battleUi._opponentUi:swapCardsInRare(var_15_0, var_15_2)
			end
		elseif arg_15_0._touchTarget == arg_15_0._battleUi.TouchTarget.opponent_hand then
			if var_15_0 and var_15_2 then
				arg_15_0:swap(var_15_0, var_15_2)
				arg_15_0._battleUi._opponentUi:swapCardsInHand(var_15_0, var_15_2)
			end
		elseif arg_15_0._touchTarget == arg_15_0._battleUi.TouchTarget.player_pile then
			if var_15_0 and var_15_2 then
				arg_15_0:swap(var_15_0, var_15_2)
				arg_15_0._battleUi._playerUi:swapCardsInPile(var_15_0, var_15_2)
			end
		elseif arg_15_0._touchTarget == arg_15_0._battleUi.TouchTarget.opponent_pile and var_15_0 and var_15_2 then
			arg_15_0:swap(var_15_0, var_15_2)
			arg_15_0._battleUi._opponentUi:swapCardsInPile(var_15_0, var_15_2)
		end

		arg_15_0:removeAllChildren()

		var_0_1 = var_15_1

		arg_15_0:init(arg_15_0._battleUi, arg_15_0._cardInfos, arg_15_0._mode, arg_15_0._title, arg_15_0._touchTarget)
	else
		ToastManager.push(Str(STR.SELECT_CARD_FIRST), 1)
	end
end

function var_0_0.swap(arg_16_0, arg_16_1, arg_16_2)
	lc.log("swap start -------------------------------")

	for iter_16_0 = 1, #arg_16_0._cardInfos do
		lc.log(iter_16_0 .. " -- " .. arg_16_0._cardInfos[1]._id)
	end

	for iter_16_1 = 1, #arg_16_0._cardInfos do
		if arg_16_1 == arg_16_0._cardInfos[iter_16_1] then
			arg_16_0._cardInfos[iter_16_1] = arg_16_2
		elseif arg_16_2 == arg_16_0._cardInfos[iter_16_1] then
			arg_16_0._cardInfos[iter_16_1] = arg_16_1
		end
	end

	for iter_16_2 = 1, #arg_16_0._cardInfos do
		lc.log(iter_16_2 .. " -- " .. arg_16_0._cardInfos[1]._id)
	end

	lc.log("swap start -------------------------------")
end

function var_0_0.addSkill(arg_17_0)
	local var_17_0 = arg_17_0:getSelectedCards()

	if #var_17_0 == 0 then
		ToastManager.push(Str(STR.SELECT_CARD_FIRST), 1)

		return
	end

	require("BattleTestInputForm").create(function(arg_18_0)
		if arg_18_0 == "" then
			-- block empty
		else
			arg_17_0:onAddSkill(var_17_0[1], arg_18_0)
		end
	end, BattleTestData.OperationType._addSkill):show()
end

function var_0_0.onAddSkill(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1._extraSkillId = tonumber(arg_19_2)
end

function var_0_0.initCardList(arg_20_0)
	arg_20_0._allCards = {}

	if var_0_0.ITEM_SIZE.width * #arg_20_0._cardInfos < ClientView.SCR_W then
		for iter_20_0 = 1, #arg_20_0._cardInfos do
			local var_20_0 = arg_20_0._cardInfos[iter_20_0]
			local var_20_1 = cc.p(ClientView.SCR_CW + (iter_20_0 - (#arg_20_0._cardInfos + 1) / 2) * var_0_0.ITEM_SIZE.width, ClientView.SCR_CH)
			local var_20_2 = arg_20_0:createCardItem(var_20_0, iter_20_0)

			lc.addChildToPos(arg_20_0, var_20_2, var_20_1)
			table.insert(arg_20_0._allCards, var_20_2)
		end
	else
		local var_20_3 = lc.List.createH(cc.size(ClientView.SCR_W, var_0_0.ITEM_SIZE.height))

		var_20_3:setAnchorPoint(cc.p(0.5, 0.5))
		lc.addChildToCenter(arg_20_0, var_20_3)

		for iter_20_1 = 1, #arg_20_0._cardInfos do
			local var_20_4 = arg_20_0._cardInfos[iter_20_1]
			local var_20_5 = arg_20_0:createCardItem(var_20_4, iter_20_1)

			var_20_3:pushBackCustomItem(var_20_5)
			table.insert(arg_20_0._allCards, var_20_5)
		end
	end
end

function var_0_0.createCardItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = ClientView.createShaderButton(nil, function(arg_22_0)
		arg_21_0:onSelectItem(arg_21_1, arg_21_2)
	end)

	var_21_0:setContentSize(var_0_0.ITEM_SIZE)
	var_21_0:setAnchorPoint(cc.p(0.5, 0.5))

	local var_21_1 = require("CardThumbnail").create(arg_21_1._infoId)

	lc.addChildToCenter(var_21_0, var_21_1)
	var_21_1:setScale(0.7)

	return var_21_0
end

function var_0_0.onSelectItem(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0._mode == var_0_0.Mode.list then
		local var_23_0 = require("CardInfoPanel")

		var_23_0.create(arg_23_1._infoId, 1, var_23_0.OperateType.na, arg_23_1, statusStrs):show()
	elseif arg_23_0._mode == var_0_0.Mode.choice then
		if not arg_23_0:isInSelectedList(arg_23_2) then
			arg_23_0:addToSelectedList(arg_23_2)
		else
			arg_23_0:removeFromSelectedList(arg_23_2)
		end
	elseif arg_23_0._mode == var_0_0.Mode.single_choice then
		if not arg_23_0:isInSelectedList(arg_23_2) then
			arg_23_0:addToSelectedList(arg_23_2)

			var_0_1 = arg_23_2
		else
			arg_23_0:removeFromSelectedList(arg_23_2)

			var_0_1 = nil
		end
	end
end

function var_0_0.setChoiceFunction(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0._checkFunction = arg_24_1
	arg_24_0._confirmFunction = arg_24_2
	arg_24_0._cancelFunction = arg_24_3
end

function var_0_0.addToSelectedList(arg_25_0, arg_25_1)
	arg_25_0._selectedList[arg_25_1] = true

	arg_25_0:updateView()
end

function var_0_0.removeFromSelectedList(arg_26_0, arg_26_1)
	arg_26_0._selectedList[arg_26_1] = false

	arg_26_0:updateView()
end

function var_0_0.isInSelectedList(arg_27_0, arg_27_1)
	return arg_27_0._selectedList[arg_27_1]
end

function var_0_0.getSelectedCount(arg_28_0)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in pairs(arg_28_0._selectedList) do
		if iter_28_1 then
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0
end

function var_0_0.getSelectedCards(arg_29_0)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_0._selectedList) do
		if iter_29_1 then
			var_29_0[#var_29_0 + 1] = arg_29_0._cardInfos[iter_29_0]
		end
	end

	return var_29_0
end

function var_0_0.isChoiceSatisfied(arg_30_0)
	if arg_30_0._checkFunction then
		return arg_30_0._checkFunction(arg_30_0)
	end

	return false
end

function var_0_0.updateView(arg_31_0)
	for iter_31_0 = 1, #arg_31_0._allCards do
		local var_31_0 = arg_31_0._allCards[iter_31_0]

		if arg_31_0:isInSelectedList(iter_31_0) then
			if not var_31_0._glow then
				local var_31_1 = DragonBones.create("xuanzhong")

				var_31_1:gotoAndPlay("effect1")
				var_31_1:setScale(1.4)
				lc.addChildToCenter(var_31_0, var_31_1, -1)

				var_31_0._glow = var_31_1
			end
		elseif var_31_0._glow then
			var_31_0._glow:removeFromParent()

			var_31_0._glow = nil
		end
	end

	if arg_31_0._confirmButton then
		local var_31_2 = arg_31_0:isChoiceSatisfied()

		arg_31_0._confirmButton:setEnabled(var_31_2)
	end
end
