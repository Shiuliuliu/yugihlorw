local var_0_0 = class("BattleListDialog", lc.ExtendUIWidget)

BattleListDialog = var_0_0
var_0_0.Mode = {
	compose = 11,
	exchange = 5,
	check = 3,
	sync = 14,
	ceremony = 13,
	link = 16,
	check_ignore_cancel = 4,
	choice = 2,
	xyz = 15,
	list = 1,
	merge = 12
}
var_0_0.ITEM_SIZE = cc.size(210, 300)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	arg_2_0._battleUi = arg_2_1
	arg_2_0._playerUi = arg_2_5
	arg_2_0._cardInfos = arg_2_2
	arg_2_0._card = arg_2_6
	arg_2_0._mode = arg_2_3

	local var_2_0 = arg_2_4 == Str(STR.BATTLE_GRAVE)

	arg_2_0._isLeave, arg_2_0._isGrave = arg_2_4 == Str(STR.BATTLE_LEAVE), var_2_0
	arg_2_0._showStatus = false
	arg_2_0._showAdjust = false

	if arg_2_0._mode == var_0_0.Mode.merge or arg_2_0._mode == var_0_0.Mode.ceremony or arg_2_0._mode == var_0_0.Mode.sync or arg_2_0._mode == var_0_0.Mode.xyz or arg_2_0._mode == var_0_0.Mode.link then
		arg_2_0._showStatus = true

		if arg_2_0._mode == var_0_0.Mode.sync then
			arg_2_0._showAdjust = true
		end
	elseif arg_2_0._mode == var_0_0.Mode.choice or arg_2_0._mode == var_0_0.Mode.check or arg_2_0._mode == var_0_0.Mode.check_ignore_cancel then
		local var_2_1 = {}
		local var_2_2 = 0
		local var_2_3 = {}
		local var_2_4 = 0

		for iter_2_0 = 1, #arg_2_2 do
			if var_2_1[arg_2_2[iter_2_0]._status] == nil then
				var_2_1[arg_2_2[iter_2_0]._status] = true
				var_2_2 = var_2_2 + 1
			end

			if var_2_3[arg_2_2[iter_2_0]._owner] == nil then
				var_2_3[arg_2_2[iter_2_0]._owner] = true
				var_2_4 = var_2_4 + 1
			end
		end

		if var_2_2 > 1 or var_2_4 > 1 then
			arg_2_0._showStatus = true
		end
	end

	if arg_2_0._mode == var_0_0.Mode.check_ignore_cancel then
		arg_2_0._ignoreCancel = true
	end

	arg_2_0:setContentSize(ClientView.SCR_SIZE)
	arg_2_0:setAnchorPoint(cc.p(0.5, 0.5))
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 == ccui.TouchEventType.ended and not arg_2_0._ignoreCancel then
			arg_2_0:cancel()
		end
	end)

	if arg_2_0._mode == var_0_0.Mode.list then
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

		local var_2_7 = ClientView.createTTF(arg_2_4 or "", ClientView.FontSize.M1)

		var_2_7:setColor(ClientView.COLOR_TEXT_TITLE)
		lc.addChildToPos(var_2_5, var_2_7, cc.p(lc.w(var_2_5) / 2, lc.h(var_2_5) / 2 + 4))

		arg_2_0._titleLabel = var_2_7
	elseif arg_2_0._mode == var_0_0.Mode.choice or arg_2_0._mode == var_0_0.Mode.check or arg_2_0._mode == var_0_0.Mode.check_ignore_cancel or arg_2_0._mode == var_0_0.Mode.merge or arg_2_0._mode == var_0_0.Mode.ceremony or arg_2_0._mode == var_0_0.Mode.sync or arg_2_0._mode == var_0_0.Mode.xyz or arg_2_0._mode == var_0_0.Mode.link or arg_2_0._mode == var_0_0.Mode.exchange then
		local var_2_8 = ClientView.createTTF(arg_2_4 or "", ClientView.FontSize.M1)

		lc.addChildToPos(arg_2_0, var_2_8, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 220), 10)
		var_2_8:setColor(ClientView.COLOR_TEXT_TITLE)

		arg_2_0._titleLabel = var_2_8

		local var_2_9 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_4_0)
			if arg_2_0._card and arg_2_0._card:hasSkills({
				6401
			}) then
				arg_2_0:confirm6401()
			else
				arg_2_0:confirm()
			end
		end, ClientView.CRECT_BUTTON, 150)

		lc.addChildToPos(arg_2_0, var_2_9, cc.p(ClientView.SCR_CW, 100), 10)
		var_2_9:addLabel(Str(STR.OK))
		var_2_9:setDisabledShader(ClientView.SHADER_DISABLE)

		arg_2_0._confirmButton = var_2_9

		if arg_2_0._mode == var_0_0.Mode.check or arg_2_0._card and arg_2_0._card._status == BattleData.CardStatus.grave and arg_2_0._card:hasSkillFast(4821) then
			var_2_9:setVisible(false)
		end

		if arg_2_0._mode == var_0_0.Mode.check or arg_2_0._card and arg_2_0._card._status == BattleData.CardStatus.grave and arg_2_0._card:hasSkillFast(5505) then
			var_2_9:setVisible(false)
		end

		if arg_2_0._mode == var_0_0.Mode.check or arg_2_0._card and arg_2_0._card._status == BattleData.CardStatus.board and arg_2_0._card:hasSkillFast(13044) then
			var_2_9:setVisible(false)
		end

		if arg_2_0._mode == var_0_0.Mode.check or arg_2_0._card and arg_2_0._card._status == BattleData.CardStatus.board and arg_2_0._card:hasSkillFast(13045) then
			var_2_9:setVisible(false)
		end

		if arg_2_0._mode == var_0_0.Mode.check or arg_2_0._card and arg_2_0._card._status == BattleData.CardStatus.board and arg_2_0._card:hasSkillFast(13697) then
			var_2_9:setVisible(false)
		end
	elseif arg_2_0._mode == var_0_0.Mode.compose then
		local var_2_10 = lc.createSprite({
			_name = "img_title_bg",
			_size = cc.size(480, 52),
			_crect = cc.rect(115, 25, 1, 1)
		})

		lc.addChildToPos(arg_2_0, var_2_10, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 220), 10)

		local var_2_11 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_2_4 or "")

		lc.addChildToPos(var_2_10, var_2_11, cc.p(lc.w(var_2_10) / 2, lc.h(var_2_10) / 2))

		arg_2_0._titleLabel = var_2_11
	end

	arg_2_0._checkFunction = nil
	arg_2_0._confirmFunction = nil
	arg_2_0._cancelFunction = nil
	arg_2_0._selectedList = {}

	arg_2_0:initCardList()
	arg_2_0:updateView()
end

function var_0_0.show(arg_5_0)
	if arg_5_0._mode == var_0_0.Mode.merge and arg_5_0._choiceParam then
		for iter_5_0 = 1, #arg_5_0._allCards do
			arg_5_0._selectedList[iter_5_0] = true
		end

		if arg_5_0:isChoiceSatisfied() then
			arg_5_0:updateView()
		else
			arg_5_0._selectedList = {}
		end
	end

	if arg_5_0._alreadySatisfied then
		arg_5_0._confirmButton:setEnabled(true)
	end

	lc.addChildToCenter(arg_5_0._battleUi._scene, arg_5_0, BattleScene.ZOrder.top)
end

function var_0_0.hide(arg_6_0)
	arg_6_0:removeFromParent()
end

function var_0_0.cancel(arg_7_0)
	if arg_7_0._cancelFunction then
		arg_7_0._cancelFunction(arg_7_0)
	end

	arg_7_0:hide()
end

function var_0_0.confirm(arg_8_0)
	if arg_8_0._confirmFunction then
		arg_8_0._confirmFunction(arg_8_0)
	end

	arg_8_0:hide()
end

function var_0_0.confirm6401(arg_9_0)
	for iter_9_0 = 1, #arg_9_0._cardInfos do
		if arg_9_0._selectedList[iter_9_0] then
			local var_9_0 = arg_9_0._cardInfos[iter_9_0]
			local var_9_1 = arg_9_0._allCards[iter_9_0]

			arg_9_0:runAction(lc.sequence(function()
				arg_9_0._confirmButton:setVisible(false)

				for iter_10_0 = 1, #arg_9_0._allCards do
					arg_9_0._allCards[iter_10_0]:setEnabled(false)
				end

				arg_9_0._ignoreCancel = true

				local var_10_0 = require("CardThumbnail").create(var_9_0._infoId, nil, var_9_0._originOwner._skins[var_9_0._infoId])

				var_10_0:setScale(0.7)
				lc.addChildToCenter(var_9_1, var_10_0)
			end, 4, function()
				arg_9_0:confirm()
			end))
		end
	end
end

function var_0_0.confirmCompose(arg_12_0, arg_12_1)
	if arg_12_0._confirmFunction then
		arg_12_0._confirmFunction(arg_12_1._infoId)
	end

	arg_12_0:hide()
end

function var_0_0.setCardInfos(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._cardInfos = arg_13_1

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._allCards) do
		iter_13_1:removeFromParent()
	end

	if arg_13_0._list then
		arg_13_0._list:removeFromParent()

		arg_13_0._list = nil
	end

	arg_13_0:initCardList()

	if arg_13_2 then
		arg_13_0._titleLabel:setString(arg_13_2)
	end
end

function var_0_0.initCardList(arg_14_0)
	arg_14_0._allCards = {}

	if var_0_0.ITEM_SIZE.width * #arg_14_0._cardInfos < ClientView.SCR_W then
		for iter_14_0 = 1, #arg_14_0._cardInfos do
			local var_14_0 = arg_14_0._cardInfos[iter_14_0]
			local var_14_1 = cc.p(ClientView.SCR_CW + (iter_14_0 - (#arg_14_0._cardInfos + 1) / 2) * var_0_0.ITEM_SIZE.width, ClientView.SCR_CH)
			local var_14_2 = arg_14_0:createCardItem(var_14_0, iter_14_0)

			lc.addChildToPos(arg_14_0, var_14_2, var_14_1)
			table.insert(arg_14_0._allCards, var_14_2)
		end
	else
		local var_14_3 = lc.List.createH(cc.size(ClientView.SCR_W, var_0_0.ITEM_SIZE.height + 100))

		var_14_3:setAnchorPoint(cc.p(0.5, 0.5))
		lc.addChildToCenter(arg_14_0, var_14_3)

		for iter_14_1 = 1, #arg_14_0._cardInfos do
			local var_14_4 = arg_14_0._cardInfos[iter_14_1]
			local var_14_5 = arg_14_0:createCardItem(var_14_4, iter_14_1)

			var_14_3:pushBackCustomItem(var_14_5)
			table.insert(arg_14_0._allCards, var_14_5)
		end
	end
end

function var_0_0.createCardItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = ClientView.createShaderButton(nil, function(arg_16_0)
		arg_15_0:onSelectItem(arg_15_1, arg_15_2)
	end)

	var_15_0:setContentSize(var_0_0.ITEM_SIZE)
	var_15_0:setAnchorPoint(cc.p(0.5, 0.5))

	local var_15_1

	if (arg_15_1._status == BattleData.CardStatus.cover and arg_15_0._mode ~= var_0_0.Mode.check or arg_15_1._status == BattleData.CardStatus.hand and arg_15_0._card and arg_15_0._card:hasSkills({
		6401,
		5260
	}) and not arg_15_0._card:hasSkillFast(9313)) and (arg_15_0._playerUi == nil or arg_15_1._owner ~= arg_15_0._playerUi._player) then
		var_15_1 = lc.createSprite(ClientView.getCardBackName())
	else
		var_15_1 = require("CardThumbnail").create(arg_15_1._srcInfoId, nil, arg_15_1._originOwner._skins[arg_15_1._infoId])

		if (arg_15_0._mode == var_0_0.Mode.sync or arg_15_0._mode == var_0_0.Mode.xyz) and not arg_15_1:isXYZ() then
			var_15_1._frame._starArea:update(arg_15_1:getStar(), arg_15_1._infoId)
		end
	end

	lc.addChildToCenter(var_15_0, var_15_1)
	var_15_1:setScale(0.7)

	if arg_15_0._mode == var_0_0.Mode.compose then
		local var_15_2 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_17_0)
			arg_15_0:confirmCompose(arg_15_1)
		end, ClientView.CRECT_BUTTON, 150)

		lc.addChildToPos(var_15_1, var_15_2, cc.p(lc.cw(var_15_1), -50), 10)
		var_15_2:addLabel(Str(STR.OK))
		var_15_2:setDisabledShader(ClientView.SHADER_DISABLE)

		var_15_1._confirmButton = var_15_2
	elseif arg_15_0._showStatus then
		local var_15_3 = arg_15_0._playerUi ~= nil and Str(arg_15_1._owner == arg_15_0._playerUi._player and STR.SELF or STR.OPPONENT) or ""
		local var_15_4 = {
			[BattleData.CardStatus.board] = STR.BATTLE_BOARD,
			[BattleData.CardStatus.hand] = STR.BATTLE_HAND,
			[BattleData.CardStatus.grave] = STR.BATTLE_GRAVE,
			[BattleData.CardStatus.pile] = STR.TROOP,
			[BattleData.CardStatus.cover] = STR.BATTLE_CS,
			[BattleData.CardStatus.show] = STR.BATTLE_CS,
			[BattleData.CardStatus.field] = STR.BATTLE_FIELD,
			[BattleData.CardStatus.leave] = STR.BATTLE_LEAVE,
			[BattleData.CardStatus.rare] = STR.BATTLE_EXCARD_LIST
		}
		local var_15_5 = arg_15_1._status == BattleData.CardStatus.board and arg_15_1._pos == 6 and "EX" or var_15_4[arg_15_1._status] and Str(var_15_4[arg_15_1._status]) or ""
		local var_15_6 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_15_3 .. var_15_5)

		lc.addChildToPos(var_15_0, var_15_6, cc.p(lc.cw(var_15_0), -12))

		if arg_15_0._showAdjust then
			local var_15_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(arg_15_1:isAdjust() and STR.MONSTER_FLAG_ADJUST or STR.MONSTER_NOT_ADJUST))

			lc.addChildToPos(var_15_0, var_15_7, cc.p(lc.cw(var_15_0), -40))
		end
	end

	if arg_15_1._extraSid and arg_15_1._extraSid > 0 then
		local var_15_8 = ClientView.createTTF(Str(Data._skillInfo[arg_15_1._extraSid]._nameSid))

		lc.addChildToPos(var_15_0, var_15_8, cc.p(lc.cw(var_15_0), 300))
	end

	return var_15_0
end

function var_0_0.onSelectItem(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._card and arg_18_0._card._status == BattleData.CardStatus.grave and arg_18_0._card:hasSkillFast(4821) then
		arg_18_0:addToSelectedList(arg_18_2)
		arg_18_0:confirm()
	elseif arg_18_0._card and arg_18_0._card._status == BattleData.CardStatus.grave and arg_18_0._card:hasSkillFast(5505) then
		arg_18_0:addToSelectedList(arg_18_2)
		arg_18_0:confirm()
	elseif arg_18_0._card and arg_18_0._card:hasSkillFast(9694) then
		arg_18_0:addToSelectedList(arg_18_2)
		arg_18_0:confirm()
	elseif arg_18_0._card and arg_18_0._card._status == BattleData.CardStatus.board and arg_18_0._card:hasSkillFast(13044) then
		arg_18_0:addToSelectedList(arg_18_2)
		arg_18_0:confirm()
	elseif arg_18_0._card and arg_18_0._card._status == BattleData.CardStatus.board and arg_18_0._card:hasSkillFast(13045) then
		arg_18_0:addToSelectedList(arg_18_2)
		arg_18_0:confirm()
	elseif arg_18_0._card and arg_18_0._card._status == BattleData.CardStatus.board and arg_18_0._card:hasSkillFast(13697) then
		arg_18_0:addToSelectedList(arg_18_2)
		arg_18_0:confirm()
	elseif arg_18_0._mode == var_0_0.Mode.list or arg_18_0._mode == var_0_0.Mode.check or arg_18_0._mode == var_0_0.Mode.check_ignore_cancel then
		local var_18_0 = require("CardInfoPanel")

		var_18_0.create(arg_18_1._infoId, 1, var_18_0.OperateType.na, arg_18_1, statusStrs):show()
	elseif arg_18_0._mode == var_0_0.Mode.choice or arg_18_0._mode == var_0_0.Mode.merge or arg_18_0._mode == var_0_0.Mode.ceremony or arg_18_0._mode == var_0_0.Mode.sync or arg_18_0._mode == var_0_0.Mode.xyz or arg_18_0._mode == var_0_0.Mode.link or arg_18_0._mode == var_0_0.Mode.exchange then
		if not arg_18_0:isInSelectedList(arg_18_2) then
			arg_18_0:addToSelectedList(arg_18_2)
		else
			arg_18_0:removeFromSelectedList(arg_18_2)
		end
	elseif arg_18_0._mode == var_0_0.Mode.compose then
		local var_18_1 = require("CardInfoPanel")

		var_18_1.create(arg_18_1._infoId, 1, var_18_1.OperateType.na, arg_18_1, statusStrs):show(BattleScene.ZOrder.top)
	end
end

function var_0_0.setChoiceFunction(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0._checkFunction = arg_19_1
	arg_19_0._confirmFunction = arg_19_2
	arg_19_0._cancelFunction = arg_19_3
end

function var_0_0.addToSelectedList(arg_20_0, arg_20_1)
	arg_20_0._selectedList[arg_20_1] = true

	arg_20_0:updateView()
end

function var_0_0.removeFromSelectedList(arg_21_0, arg_21_1)
	arg_21_0._selectedList[arg_21_1] = false

	arg_21_0:updateView()
end

function var_0_0.isInSelectedList(arg_22_0, arg_22_1)
	return arg_22_0._selectedList[arg_22_1]
end

function var_0_0.getSelectedCount(arg_23_0)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(arg_23_0._selectedList) do
		if iter_23_1 then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function var_0_0.getSelectedCards(arg_24_0)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(arg_24_0._selectedList) do
		if iter_24_1 then
			var_24_0[#var_24_0 + 1] = arg_24_0._cardInfos[iter_24_0]
		end
	end

	return var_24_0
end

function var_0_0.isChoiceSatisfied(arg_25_0)
	if arg_25_0._mode == var_0_0.Mode.check_ignore_cancel then
		return true
	end

	if arg_25_0._card:hasSkillFast(9694) then
		return true
	end

	if arg_25_0._checkFunction then
		return arg_25_0._checkFunction(arg_25_0)
	end

	return false
end

function var_0_0.updateView(arg_26_0)
	for iter_26_0 = 1, #arg_26_0._allCards do
		local var_26_0 = arg_26_0._allCards[iter_26_0]

		if arg_26_0:isInSelectedList(iter_26_0) then
			if not var_26_0._glow then
				local var_26_1 = DragonBones.create("xuanzhong")

				var_26_1:gotoAndPlay("effect1")
				var_26_1:setScale(1.4)
				lc.addChildToCenter(var_26_0, var_26_1, -1)

				var_26_0._glow = var_26_1
			end
		elseif var_26_0._glow then
			var_26_0._glow:removeFromParent()

			var_26_0._glow = nil
		end
	end

	if arg_26_0._confirmButton then
		local var_26_2 = arg_26_0:isChoiceSatisfied()

		arg_26_0._confirmButton:setEnabled(var_26_2)
	end
end
