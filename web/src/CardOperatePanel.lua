local var_0_0 = class("CardOperatePanel", require("BasePanel"))
local var_0_1 = require("CardThumbnail")

var_0_0.OperateMode = {
	decompose = 3,
	compose = 1,
	recall = 5,
	recovery = 4,
	upgrade = 2
}

local var_0_2 = cc.size(340, 412)
local var_0_3 = {
	cc.c4f(0, 0.3, 0.1, 0.1),
	cc.c4f(0, 0.11, 0.5, 0.1),
	cc.c4f(0.45, 0.11, 0.5, 0.1),
	cc.c4f(0.45, 0.11, 0, 0.1),
	cc.c4f(0.4, 0, 0, 0.1)
}
local var_0_4 = {
	Str(STR.COMPOSE),
	Str(STR.UPGRADE),
	Str(STR.DECOMPOSE),
	Str(STR.RECOVERY),
	Str(STR.RECOVERY)
}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.init(arg_2_0, true)

	arg_2_0._panelName = "CardOperatePanel"
	arg_2_0._isShowResourceUI = true

	local var_2_0, var_2_1, var_2_2 = Data.removeAdditional(arg_2_1)

	arg_2_0._infoId = arg_2_1
	arg_2_0._cardId = var_2_0
	arg_2_0._isGold = var_2_2
	arg_2_0._goldId = Data.setAdditional(var_2_0, false, true)
	arg_2_0._count = 1
	arg_2_0._info = Data.getInfo(arg_2_1)
	arg_2_0._mode = arg_2_2
	arg_2_0._card = arg_2_3
	arg_2_0._level = P._playerCard._levels[arg_2_1] or 1

	local var_2_3 = lc.createSprite("res/jpg/ui_scene_bg.jpg")

	lc.addChildToCenter(arg_2_0, var_2_3)

	local var_2_4 = ClientView.createTitleArea(var_0_4[arg_2_0._mode], function()
		arg_2_0:hide()
	end)

	arg_2_0:addChild(var_2_4)

	arg_2_0._topArea = var_2_4

	arg_2_0:createBottomArea()

	local var_2_5 = arg_2_0:createThumbnail(arg_2_1, nil)

	lc.addChildToPos(arg_2_0, var_2_5, cc.p(lc.w(arg_2_0) / 2 - 230, lc.h(arg_2_0) / 2 + 118))
	lc.offset(var_2_5, 0, -30)

	arg_2_0._leftThumbnail = var_2_5

	local var_2_6 = P._playerCard:getCardCount(arg_2_1)
	local var_2_7 = P._playerCard:getCardCountInTroop(arg_2_1, true)
	local var_2_8 = ClientView.createTTF("")

	var_2_8:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_2_0, var_2_8, cc.p(lc.left(var_2_5), lc.bottom(var_2_5) - 25))

	arg_2_0._label1 = var_2_8

	local var_2_9 = ClientView.createTTF("")

	var_2_9:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_2_0, var_2_9, cc.p(lc.left(var_2_5), lc.bottom(var_2_8) - 25))

	arg_2_0._label2 = var_2_9

	local var_2_10 = ClientView.createTTF("")

	var_2_10:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_2_0, var_2_10, cc.p(lc.left(var_2_5), lc.bottom(var_2_9) - 25))

	arg_2_0._label3 = var_2_10

	local var_2_11 = ClientView.createTTF("")

	var_2_11:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_2_0, var_2_11, cc.p(lc.left(var_2_5), lc.bottom(var_2_10) - 25))

	arg_2_0._label4 = var_2_11

	local var_2_12 = ClientView.createShaderButton("img_rebirth_btn", function(arg_4_0)
		if arg_2_0._mode == var_0_0.OperateMode.upgrade then
			arg_2_0:onUpgrade()
		elseif arg_2_0._mode == var_0_0.OperateMode.compose then
			arg_2_0:onCompose()
		elseif arg_2_0._mode == var_0_0.OperateMode.decompose then
			arg_2_0:onDecompose()
		elseif arg_2_0._mode == var_0_0.OperateMode.recovery then
			arg_2_0:onRecovery()
		elseif arg_2_0._mode == var_0_0.OperateMode.recall then
			arg_2_0:onRecall()
		end
	end)

	lc.addChildToPos(arg_2_0, var_2_12, cc.p(lc.w(arg_2_0) / 2 + 200, 270))
	lc.offset(var_2_12, 0, -60)

	arg_2_0._btn = var_2_12

	local var_2_13 = ClientView.createBMFont(ClientView.BMFont.huali_32, labelStr)

	var_2_13:setColor(lc.Color3B.yellow)
	var_2_13:setAdditionalKerning(10)
	lc.addChildToPos(var_2_12, var_2_13, cc.p(lc.w(var_2_12) / 2, 30))

	var_2_12._label = var_2_13

	local var_2_14 = ClientView.createResIconLabel(130, "img_icon_res1_s")

	function var_2_14.update(arg_5_0, arg_5_1)
		arg_5_0._label:setString(arg_5_1)
		arg_5_0._label:setColor(arg_5_1 > P._gold and lc.Color3B.red or lc.Color3B.white)
	end

	lc.addChildToPos(var_2_12, var_2_14, cc.p(lc.w(var_2_12) / 2 + 12, 62))

	arg_2_0._goldArea = var_2_14

	arg_2_0._goldArea:setVisible(false)
	lc.offset(var_2_12._label, 0, 20)
	arg_2_0:onSelectMode()
end

function var_0_0.createBottomArea(arg_6_0)
	return
end

function var_0_0.onSelectMode(arg_7_0, arg_7_1)
	arg_7_0._count = 0

	arg_7_0._topArea._title:setString(var_0_4[arg_7_0._mode])
	arg_7_0._btn._label:setString(var_0_4[arg_7_0._mode])
	arg_7_0:updateView()
end

function var_0_0.createThumbnail(arg_8_0, arg_8_1)
	local var_8_0 = var_0_1.create(arg_8_1)

	var_8_0:setTouchEnabled(true)
	var_8_0:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 == ccui.TouchEventType.ended then
			local var_9_0 = require("CardInfoPanel")

			var_9_0.create(arg_8_1, level, var_9_0.OperateType.na):show()
		end
	end)

	return var_8_0
end

function var_0_0.createArrow(arg_10_0)
	local var_10_0 = lc.createSprite("img_arrow_right")

	var_10_0:setScale(0.5)
	var_10_0:setColor(ClientView.COLOR_TEXT_GREEN)

	return var_10_0
end

function var_0_0.createDetailDividingLine(arg_11_0)
	local var_11_0 = ccui.Widget:create()
	local var_11_1 = ClientView.createDividingLine(260, cc.c3b(14, 140, 228))

	var_11_0:setContentSize(var_11_1:getContentSize())
	lc.addChildToCenter(var_11_0, var_11_1)

	return var_11_0
end

function var_0_0.createDetailSkillArea(arg_12_0)
	local var_12_0, var_12_1 = Data.getInfo(arg_12_0._infoId)
	local var_12_2
	local var_12_3
	local var_12_4
	local var_12_5

	if var_12_1 == Data.CardType.monster then
		for iter_12_0 = 1, 3 do
			var_12_2, var_12_4 = var_12_0._skillId[iter_12_0], var_12_0._skillId[iter_12_0]
			var_12_3, var_12_5 = arg_12_0._level, arg_12_0._level + 1

			if var_12_2 ~= var_12_4 or var_12_3 ~= var_12_5 then
				break
			end
		end
	else
		for iter_12_1 = 1, 3 do
			var_12_2, var_12_4 = var_12_0._skillId[iter_12_1], var_12_0._skillId[iter_12_1]
			var_12_3, var_12_5 = arg_12_0._level, arg_12_0._level + 1

			if var_12_2 ~= var_12_4 or var_12_3 ~= var_12_5 then
				break
			end
		end
	end

	if var_12_2 == 0 then
		return
	end

	local var_12_6 = ccui.Widget:create()
	local var_12_7 = Data._skillInfo[var_12_2]
	local var_12_8 = Data._skillInfo[var_12_4]
	local var_12_9 = lc.createSprite(string.format("img_icon_skill_%d", math.floor(var_12_2 / Data.INFO_ID_GROUP_SIZE)))

	var_12_9:setScale(0.8)

	local var_12_10 = Str(var_12_7._nameSid)

	if var_12_7._val[var_12_3] > 0 then
		var_12_10 = var_12_10 .. string.format(" %d", var_12_3)
	end

	local var_12_11 = ClientView.createTTF(var_12_10)
	local var_12_12

	if var_12_2 == var_12_4 then
		var_12_12 = ClientView.createSkillDesc(var_12_7, var_12_3, var_12_5, lc.w(arg_12_0._detailList) - 40)
	else
		var_12_12 = ClientView.createSkillDesc(var_12_8, var_12_5, nil, lc.w(arg_12_0._detailList) - 40)
	end

	var_12_6:setContentSize(lc.w(arg_12_0._detailList), math.floor(lc.sh(var_12_9)) + lc.h(var_12_12) + 10)
	ClientView.addSkillTapHandler(var_12_6, var_12_4, var_12_5)
	lc.addChildToPos(var_12_6, var_12_9, cc.p(20 + math.floor(lc.sw(var_12_9)) / 2, lc.h(var_12_6) - math.floor(lc.sh(var_12_9)) / 2))

	if var_12_2 ~= var_12_4 or var_12_3 < var_12_5 then
		lc.addChildToPos(var_12_6, var_12_11, cc.p(lc.right(var_12_9) + 16 + lc.w(var_12_11) / 2, lc.top(var_12_9) - 20))

		local var_12_13 = arg_12_0:createArrow()

		lc.addChildToPos(var_12_6, var_12_13, cc.p(lc.right(var_12_11) + 10 + lc.sw(var_12_13) / 2, lc.y(var_12_11)))

		if var_12_2 == var_12_4 then
			local var_12_14 = ClientView.createTTF(tostring(var_12_5), nil, ClientView.COLOR_TEXT_GREEN)

			lc.addChildToPos(var_12_6, var_12_14, cc.p(lc.right(var_12_13) + 10 + lc.w(var_12_14) / 2, lc.y(var_12_11)))
		else
			local var_12_15 = Str(var_12_8._nameSid)

			if var_12_8._val[var_12_5] > 0 then
				var_12_15 = var_12_15 .. string.format(" %d", var_12_5)
			end

			local var_12_16 = ClientView.createTTF(var_12_15, nil, ClientView.COLOR_TEXT_GREEN)

			lc.addChildToPos(var_12_6, var_12_16, cc.p(lc.right(var_12_13) + 10 + lc.w(var_12_16) / 2, lc.y(var_12_11)))
		end
	else
		local var_12_17 = ClientView.createTTF(string.format(Str(STR.BRACKETS_S), Str(STR.GET)), nil, ClientView.COLOR_TEXT_GREEN)

		lc.addChildToPos(var_12_6, var_12_17, cc.p(lc.right(var_12_9) + 16 + lc.w(var_12_17) / 2, lc.top(var_12_9) - 20))
		lc.addChildToPos(var_12_6, var_12_11, cc.p(lc.right(var_12_17) + 6 + lc.w(var_12_11) / 2, lc.y(var_12_17)))
	end

	lc.addChildToPos(var_12_6, var_12_12, cc.p(lc.w(var_12_6) / 2, lc.h(var_12_12) / 2))

	return var_12_6
end

function var_0_0.createDetailValueChangeArea(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 48
	local var_13_2 = 20
	local var_13_3, var_13_4 = Data.getInfo(arg_13_0._infoId)
	local var_13_5
	local var_13_6

	if var_13_4 == Data.CardType.monster then
		var_13_5, var_13_6 = var_13_3._atk[arg_13_0._level], var_13_3._atk[arg_13_0._level + 1]
		var_13_0 = var_13_0 + var_13_1
	end

	local var_13_7
	local var_13_8

	if var_13_4 == Data.CardType.monster then
		var_13_7, var_13_8 = var_13_3._hp[arg_13_0._level], var_13_3._hp[arg_13_0._level + 1]
		var_13_0 = var_13_0 + var_13_1
	end

	if var_13_0 == 0 then
		return nil
	end

	local var_13_9 = ccui.Widget:create()

	var_13_9:setContentSize(lc.w(arg_13_0._detailList), var_13_0)

	local function var_13_10(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7)
		if arg_14_2 == nil or arg_14_2 == arg_14_3 then
			return arg_14_6
		end

		local var_14_0

		if lc.FrameCache:getSpriteFrame(arg_14_0) then
			var_14_0 = lc.createSprite(arg_14_0)
		else
			var_14_0 = ClientView.createTTF(arg_14_0, ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)
		end

		var_14_0:setScale(arg_14_1)
		var_14_0:setAnchorPoint(1, 0.5)
		lc.addChildToPos(var_13_9, var_14_0, cc.p(80, arg_14_6 + (arg_14_7 or 0)))

		local var_14_1 = arg_13_0:createArrow()

		lc.addChildToPos(var_13_9, var_14_1, cc.p(190, arg_14_6))

		local function var_14_2(arg_15_0)
			if arg_15_0 < 1 then
				return string.format("%d%%", arg_15_0 * 100)
			else
				return tostring(arg_15_0)
			end
		end

		arg_14_2 = ClientView.createTTF(var_14_2(arg_14_2), ClientView.FontSize.S1)

		lc.addChildToPos(var_13_9, arg_14_2, cc.p(lc.left(var_14_1) - 10 - lc.w(arg_14_2) / 2, arg_14_6))

		arg_14_3 = ClientView.createTTF(var_14_2(arg_14_3), ClientView.FontSize.S1, ClientView.COLOR_TEXT_GREEN)

		lc.addChildToPos(var_13_9, arg_14_3, cc.p(lc.right(var_14_1) + 10 + lc.w(arg_14_2) / 2, arg_14_6))

		if arg_14_4 and arg_14_4 < arg_14_5 then
			arg_14_6 = arg_14_6 - 30

			local var_14_3 = arg_13_0:createArrow()

			lc.addChildToPos(var_13_9, var_14_3, cc.p(190, arg_14_6))

			arg_14_4 = ClientView.createKeyValueLabel(string.format("(%s", Str(STR.POTENTIAL)), var_14_2(arg_14_4), ClientView.FontSize.S2, true)

			arg_14_4:addToParent(var_13_9, cc.p(lc.left(var_14_3) - 10 - arg_14_4:getTotalWidth(), arg_14_6))

			arg_14_5 = ClientView.createTTF(var_14_2(arg_14_5), nil, ClientView.COLOR_TEXT_GREEN)

			lc.addChildToPos(var_13_9, arg_14_5, cc.p(lc.right(var_14_3) + 10 + lc.w(arg_14_5) / 2, arg_14_6))

			local var_14_4 = ClientView.createTTF(")", nil, ClientView.COLOR_LABEL_LIGHT)

			lc.addChildToPos(var_13_9, var_14_4, cc.p(lc.right(arg_14_5) + lc.w(var_14_4) / 2, arg_14_6))

			arg_14_6 = arg_14_6 - var_13_1 - var_13_2 + 30
		else
			arg_14_6 = arg_14_6 - var_13_1
		end

		return arg_14_6
	end

	local var_13_11 = var_13_0 - var_13_1 / 2
	local var_13_12 = var_13_10("card_cost", 0.5, repValue, newRepValue, nil, nil, var_13_11)
	local var_13_13 = var_13_10("card_atk", 1, var_13_5, var_13_6, nil, nil, var_13_12, 2)
	local var_13_14 = var_13_10("card_def", 1, var_13_7, var_13_8, nil, nil, var_13_13)

	return var_13_9
end

function var_0_0.createDetailSkillPoolArea(arg_16_0)
	local var_16_0 = arg_16_0._leftThumbnail._card
	local var_16_1 = {}
	local var_16_2
	local var_16_3
	local var_16_4
	local var_16_5

	if var_16_0._newSkillCache > 0 then
		local var_16_6 = ClientData.getStrByCardType(var_16_0._type)
		local var_16_7 = string.format(Str(STR.PROMPT_SUB_CACHE), var_16_6, Str(STR.SKILL_ADDITION), Str(STR.UPGRADE))

		return (ClientView.createBoldRichText(var_16_7, ClientView.RICHTEXT_PARAM_LIGHT_S1, 290))
	elseif #var_16_1 > 0 then
		table.sort(var_16_1, function(arg_17_0, arg_17_1)
			return arg_17_0._id < arg_17_1._id
		end)

		local var_16_8 = ccui.Widget:create()
		local var_16_9 = 50
		local var_16_10 = ClientView.createTTF(var_16_2, ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)
		local var_16_11 = lc.h(var_16_10) + 20 + var_16_9 * #var_16_1

		if var_16_3 then
			var_16_11 = var_16_11 + 30
		end

		var_16_8:setContentSize(lc.w(arg_16_0._detailList), var_16_11)

		local var_16_12 = var_16_11 - lc.h(var_16_10) / 2

		lc.addChildToPos(var_16_8, var_16_10, cc.p(lc.w(var_16_8) / 2, var_16_12))

		if var_16_3 then
			local var_16_13 = ClientView.createBoldRichText(var_16_3, ClientView.RICHTEXT_PARAM_LIGHT_S2)

			var_16_12 = lc.bottom(var_16_10) - 4 - lc.h(var_16_13) / 2

			lc.addChildToPos(var_16_8, var_16_13, cc.p(lc.w(var_16_8) / 2, var_16_12))
		end

		local var_16_14 = var_16_12 - lc.h(var_16_10) / 2 - 20 - var_16_9 / 2

		for iter_16_0, iter_16_1 in ipairs(var_16_1) do
			local var_16_15 = ccui.Widget:create()

			var_16_15:setContentSize(lc.w(var_16_8), var_16_9)
			ClientView.addSkillTapHandler(var_16_15, iter_16_1._id, var_16_4)

			local var_16_16 = lc.createSprite(string.format("img_icon_skill_%d", Data.getType(iter_16_1._id)))

			var_16_16:setScale(0.8)
			lc.addChildToPos(var_16_15, var_16_16, cc.p(20 + math.floor(lc.sw(var_16_16)) / 2, var_16_9 / 2))

			local var_16_17

			if iter_16_1._val[1] > 0 then
				var_16_17 = string.format("%s %d - %d", Str(iter_16_1._nameSid), var_16_4, math.min(var_16_5, CardHelper.getSkillMaxLevel(iter_16_1._id)))
			else
				var_16_17 = string.format("%s", Str(iter_16_1._nameSid))
			end

			local var_16_18 = ClientView.createTTF(var_16_17)

			lc.addChildToPos(var_16_15, var_16_18, cc.p(lc.right(var_16_16) + 16 + lc.w(var_16_18) / 2, var_16_9 / 2))
			lc.addChildToPos(var_16_8, var_16_15, cc.p(lc.w(var_16_8) / 2, var_16_14))

			var_16_14 = var_16_14 - var_16_9
		end

		return var_16_8
	end
end

function var_0_0.updateView(arg_18_0)
	local var_18_0 = P._playerCard:getCardCount(arg_18_0._infoId)
	local var_18_1, var_18_2 = P._playerCard:getCardCountInTroop(arg_18_0._infoId)

	arg_18_0._max = P._playerCard:getCardOperateCount(arg_18_0._infoId)

	if arg_18_0._mode == var_0_0.OperateMode.recovery then
		arg_18_0._max = var_18_0 - var_18_1
	elseif arg_18_0._mode == var_0_0.OperateMode.decompose then
		arg_18_0._max = math.max(0, var_18_0 - var_18_2)
	elseif arg_18_0._mode == var_0_0.OperateMode.recall then
		local var_18_3 = arg_18_0._card._cardsNum - (P._playerMarket._recoveryMap[arg_18_0._card._id] or 0)

		arg_18_0._max = math.min(var_18_0, var_18_3)
		arg_18_0._removeTroopCount = var_18_0 - var_18_2
	end

	arg_18_0._label1:setString(lc.str(STR.CURRENT_OWN) .. ": " .. var_18_0)
	arg_18_0._label2:setString(lc.str(STR.INTROOPED) .. ": " .. var_18_2)

	if arg_18_0._mode == var_0_0.OperateMode.recall then
		arg_18_0._label3:setString(lc.str(STR.CAN_S) .. var_0_4[arg_18_0._mode] .. ": " .. arg_18_0._max .. "/" .. arg_18_0._card._cardsNum)
	else
		arg_18_0._label3:setString(lc.str(STR.CAN_S) .. var_0_4[arg_18_0._mode] .. ": " .. arg_18_0._max)
	end

	if arg_18_0._mode == var_0_0.OperateMode.recall then
		local var_18_4, var_18_5, var_18_6, var_18_7 = ClientData.tick2Date(arg_18_0._card._startTime)
		local var_18_8, var_18_9, var_18_10, var_18_11 = ClientData.tick2Date(arg_18_0._card._endTime)

		arg_18_0._label4:setString(string.format(Str(STR.RECALL_DURATION), var_18_5, var_18_6, var_18_9, var_18_10))
	end

	arg_18_0:updateRightThumbnail()
	arg_18_0:updateCardUpgradeArea()
	arg_18_0:updateCountSelectArea()
	arg_18_0:updateCosumeMaterialArea()
	arg_18_0:updateGotMaterialArea()
	arg_18_0._goldArea:update(arg_18_0:getConsumeGold())
end

function var_0_0.updateCardInfoArea(arg_19_0)
	if arg_19_0._cardInfoArea ~= nil then
		arg_19_0._cardInfoArea:removeFromParent()

		arg_19_0._cardInfoArea = nil
	end

	if arg_19_0._mode == var_0_0.OperateMode.upgrade then
		return
	end

	local var_19_0 = lc.h(arg_19_0) - 200
	local var_19_1 = ClientView.createFrameBox(var_0_2)
	local var_19_2 = require("CardInfoWidget").create(arg_19_0._infoId, arg_19_0._level, cc.size(lc.w(var_19_1) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(var_19_1) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), false)

	var_19_2:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(var_19_1, var_19_2, -1)
	lc.addChildToPos(arg_19_0, var_19_1, cc.p(lc.w(arg_19_0) / 2 + 330, lc.y(arg_19_0._leftThumbnail)))

	arg_19_0._cardInfoArea = var_19_1
end

function var_0_0.updateCardUpgradeArea(arg_20_0)
	if arg_20_0._cardUpgradeArea ~= nil then
		arg_20_0._cardUpgradeArea:removeFromParent()

		arg_20_0._cardUpgradeArea = nil
	end

	if arg_20_0._mode ~= var_0_0.OperateMode.upgrade then
		return
	end

	if arg_20_0._level == Data.CARD_MAX_LEVEL then
		return
	end

	local var_20_0 = ClientView.createFrameBox(var_0_2)

	var_20_0:setPosition(lc.w(arg_20_0) / 2, lc.top(arg_20_0._leftThumbnail) - lc.h(var_20_0) / 2)
	arg_20_0:addChild(var_20_0)

	local var_20_1 = lc.List.create(cc.size(lc.w(var_20_0) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(var_20_0) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 20, 20)

	lc.addChildToCenter(var_20_0, var_20_1, -1)

	arg_20_0._detailList = var_20_1

	local function var_20_2(arg_21_0, arg_21_1)
		if arg_21_0 then
			if arg_21_1 ~= false then
				var_20_1:pushBackCustomItem(arg_20_0:createDetailDividingLine())
			end

			var_20_1:pushBackCustomItem(arg_21_0)
		end

		return arg_21_0
	end

	if Data.getType(arg_20_0._infoId) == Data.CardType.monster then
		var_20_2(arg_20_0:createDetailValueChangeArea(), false)
	end

	var_20_2(arg_20_0:createDetailSkillArea())

	arg_20_0._cardUpgradeArea = var_20_0
end

function var_0_0.updateCountSelectArea(arg_22_0)
	if arg_22_0._countSelectArea ~= nil then
		arg_22_0._countSelectArea:removeFromParent()

		arg_22_0._countSelectArea = nil
	end

	if arg_22_0._mode == var_0_0.OperateMode.upgrade then
		return
	end

	local var_22_0 = lc.createNode()

	var_22_0:setContentSize(ClientView.CARD_SIZE)
	lc.addChildToPos(arg_22_0, var_22_0, cc.p(lc.w(arg_22_0) / 2 + 200, lc.y(arg_22_0._leftThumbnail)))
	lc.offset(var_22_0, 0, 70)

	local var_22_1 = lc.createSprite({
		_name = "img_com_bg_32",
		_crect = ClientView.CRECT_COM_BG32,
		_size = cc.size(200, ClientView.CRECT_COM_BG32.height)
	})

	lc.addChildToPos(var_22_0, var_22_1, cc.p(lc.w(var_22_0) / 2, lc.h(var_22_0) - 100))

	local var_22_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_0_4[arg_22_0._mode] .. lc.str(STR.AMOUNT))

	lc.addChildToCenter(var_22_1, var_22_2)

	local var_22_3 = require("SelectCountWidget").create(function(arg_23_0)
		arg_22_0:updateCount(arg_23_0)
	end, 140, math.min(arg_22_0._max, 100), 0)

	var_22_3._countVal:setString(arg_22_0._count)

	arg_22_0._countWidget = var_22_3

	lc.addChildToPos(var_22_0, var_22_3, cc.p(lc.w(var_22_0) / 2, lc.bottom(var_22_1) - 20 - var_22_3.HEIGHT / 2))
	lc.offset(var_22_3._btnAddTen, -105, -70)
	lc.offset(var_22_3._btnReduceTen, 105, -70)

	arg_22_0._countSelectArea = var_22_0

	if arg_22_0._mode == var_0_0.OperateMode.recall then
		var_22_3._btnAddTen:setVisible(false)
		var_22_3._btnReduceTen:setVisible(false)
		lc.offset(var_22_3, 0, -50)
	end
end

function var_0_0.updateRightThumbnail(arg_24_0)
	if arg_24_0._rightThumbnail ~= nil then
		arg_24_0._rightThumbnail:removeFromParent()

		arg_24_0._rightThumbnail = nil
	end

	if arg_24_0._mode ~= var_0_0.OperateMode.upgrade then
		return
	end

	if arg_24_0._level == Data.CARD_MAX_LEVEL then
		return
	end

	local var_24_0 = arg_24_0:createThumbnail(arg_24_0._infoId, arg_24_0._level + 1)

	var_24_0:setPosition(lc.w(arg_24_0) / 2 + 330, lc.y(arg_24_0._leftThumbnail))
	arg_24_0:addChild(var_24_0)

	arg_24_0._rightThumbnail = var_24_0
end

function var_0_0.updateCosumeMaterialArea(arg_25_0)
	return
end

function var_0_0.updateGotMaterialArea(arg_26_0)
	if arg_26_0._gotMatArea ~= nil then
		arg_26_0._gotMatArea:removeFromParent()

		arg_26_0._gotMatArea = nil
	end

	if arg_26_0._mode == var_0_0.OperateMode.upgrade and arg_26_0._level == Data.CARD_MAX_LEVEL then
		return
	end

	local var_26_0 = {}

	local function var_26_1(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = {}

		if arg_27_1 then
			var_27_0._icon = IconWidget.create({
				_infoId = arg_27_1,
				_num = P:getItemCount(arg_27_1)
			}, 0)
			var_27_0._need = arg_27_2 or card:getRebirthNeedCount()
		else
			var_27_0._icon = IconWidget.create({
				_isFragment = false,
				_infoId = arg_27_0,
				_count = P._playerCard:getCardCount(arg_27_0)
			}, 0)
			var_27_0._need = arg_27_2 or card:getRebirthNeedCount()
		end

		return var_27_0
	end

	if arg_26_0._mode == var_0_0.OperateMode.upgrade then
		-- block empty
	elseif arg_26_0._mode == var_0_0.OperateMode.compose then
		table.insert(var_26_0, var_26_1(arg_26_0._infoId, nil, arg_26_0._count))
	elseif arg_26_0._mode == var_0_0.OperateMode.decompose then
		local var_26_2, var_26_3 = P._playerCard:getDecomposeDust(arg_26_0._infoId)
		local var_26_4 = var_26_3 * arg_26_0._count

		table.insert(var_26_0, var_26_1(arg_26_0._infoId, var_26_2, var_26_4))
	elseif arg_26_0._mode == var_0_0.OperateMode.recovery then
		local var_26_5, var_26_6 = P._playerCard:getRecoveryDust(arg_26_0._card._id)
		local var_26_7 = var_26_6 * arg_26_0._count

		table.insert(var_26_0, var_26_1(arg_26_0._infoId, var_26_5, var_26_7))
	elseif arg_26_0._mode == var_0_0.OperateMode.recall then
		local var_26_8 = P._playerCard:getRecallDust(arg_26_0._card._id, arg_26_0._count)

		for iter_26_0, iter_26_1 in pairs(var_26_8) do
			table.insert(var_26_0, var_26_1(arg_26_0._infoId, iter_26_0, iter_26_1))
		end
	end

	local var_26_9 = ClientView.createMaterialArea(var_26_0, lc.str(STR.GET) .. lc.str(STR.RESOURCE), false)

	lc.addChildToPos(arg_26_0, var_26_9, cc.p(lc.w(arg_26_0) / 2 + 200, 260))

	arg_26_0._gotMatArea = var_26_9
end

function var_0_0.getConsumeGold(arg_28_0)
	local var_28_0 = 0

	if arg_28_0._mode == var_0_0.OperateMode.upgrade then
		var_28_0 = P._playerCard:getUpgradeGold(arg_28_0._infoId)
	elseif arg_28_0._mode == var_0_0.OperateMode.compose then
		var_28_0 = P._playerCard:getComposeGold(arg_28_0._infoId) * arg_28_0._count
	elseif arg_28_0._mode == var_0_0.OperateMode.decompose then
		var_28_0 = P._playerCard:getDecomposeGold(arg_28_0._infoId) * arg_28_0._count
	end

	return var_28_0
end

function var_0_0.updateCount(arg_29_0, arg_29_1)
	arg_29_0._count = arg_29_1 or 0

	arg_29_0:updateCosumeMaterialArea()
	arg_29_0:updateGotMaterialArea()
	arg_29_0._goldArea:update(arg_29_0:getConsumeGold())
end

function var_0_0.showEffect(arg_30_0)
	local var_30_0, var_30_1 = Data.getInfo(arg_30_0._infoId)
	local var_30_2 = lc._runningScene
	local var_30_3 = arg_30_0._leftThumbnail
	local var_30_4 = lc.convertPos(cc.p(lc.w(var_30_3) / 2, lc.h(var_30_3) / 2), var_30_3, var_30_2)
	local var_30_5 = Particle.create("par_card_rebirth5")

	var_30_5:setStartColor(var_0_3[var_30_0._quality])
	var_30_5:setEndColor(var_0_3[var_30_0._quality])
	lc.addChildToPos(var_30_2._scene, var_30_5, var_30_4, ClientData.ZOrder.effect)
	var_30_2:runAction(lc.sequence(0.5, function()
		arg_30_0:onUpgradeSuccess()
	end))
	lc.Audio.playAudio(AUDIO.E_CARD_EVOLUTE)
end

function var_0_0.onEnter(arg_32_0)
	var_0_0.super.onEnter(arg_32_0)

	arg_32_0._listeners = {}

	table.insert(arg_32_0._listeners, lc.addEventListener(GuideManager.Event.seek, function(arg_33_0)
		arg_32_0:onGuide(arg_33_0)
	end))
	table.insert(arg_32_0._listeners, lc.addEventListener(Data.Event.gold_dirty, function(arg_34_0)
		arg_32_0._goldArea:update(arg_32_0:getConsumeGold())
	end))
	ClientData.addMsgListener(arg_32_0, function(arg_35_0)
		return arg_32_0:onMsg(arg_35_0)
	end, 1)

	if GuideManager.getCurStepName() == "enter evolve card" then
		GuideManager.finishStepLater()
	end
end

function var_0_0.onExit(arg_36_0)
	var_0_0.super.onExit(arg_36_0)
	ClientData.removeMsgListener(arg_36_0)

	for iter_36_0 = 1, #arg_36_0._listeners do
		lc.Dispatcher:removeEventListener(arg_36_0._listeners[iter_36_0])
	end

	ClientData.removeMsgListener(arg_36_0)
end

function var_0_0.onUpgrade(arg_37_0)
	local var_37_0 = Str(STR.UPGRADE)
	local var_37_1 = Data.getType(arg_37_0._infoId)
	local var_37_2 = P._playerCard:upgradeCard(arg_37_0._infoId)

	if var_37_2 == Data.ErrorType.ok then
		ClientView.getActiveIndicator():show()
		arg_37_0:showEffect()
		ClientData.sendCardUpgrade(arg_37_0._infoId)

		if GuideManager.getCurStepName() == "evolve card" then
			GuideManager.finishStep(true)
		end
	elseif var_37_2 == Data.ErrorType.card_already_max_level then
		ToastManager.push(string.format(Str(STR.REACH_MAX_LEVEL), Str(STR.CARD)))
	elseif var_37_2 == Data.ErrorType.card_not_support then
		ToastManager.push(string.format(Str(STR.NOTEVOLUTION), var_37_0))
	elseif var_37_2 == Data.ErrorType.need_more_polish then
		ToastManager.push(Str(STR.NOT_ENOUGH_POLISH))
	elseif var_37_2 == Data.ErrorType.need_more_evolutematerial then
		ToastManager.push(Str(STR.NOT_ENOUGH_EVOLUTION_DRUG))
	elseif var_37_2 == Data.ErrorType.need_more_stonerare then
		ToastManager.push(Str(STR.NOT_ENOUGH_STONE_RARE))
	elseif var_37_2 == Data.ErrorType.need_more_stonelegend then
		ToastManager.push(Str(STR.NOT_ENOUGH_STONE_LEGEND))
	elseif var_37_2 == Data.ErrorType.need_more_flowerrare then
		ToastManager.push(Str(STR.NOT_ENOUGH_FLOWER_RARE))
	elseif var_37_2 == Data.ErrorType.need_more_flowerlegend then
		ToastManager.push(Str(STR.NOT_ENOUGH_FLOWER_LEGEND))
	elseif var_37_2 == Data.ErrorType.need_more_horse_shoes or var_37_2 == Data.ErrorType.need_more_horse_armor then
		ToastManager.push(Str(STR.NOT_ENOUGH_HORSE_TRAIN_MAT))
	elseif var_37_2 == Data.ErrorType.need_more_gold then
		ToastManager.push(Str(STR.NOT_ENOUGH_GOLD))
		require("ExchangeResForm").create(Data.ResType.gold):show()
	elseif var_37_2 == Data.ErrorType.need_more_samecard then
		if arg_37_0._mode == var_0_0.OperateMode.recall then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH_SAME_CARD_RECALL), ClientData.getStrByCardType(var_37_1)))
		else
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH_SAME_CARD), ClientData.getStrByCardType(var_37_1)))
		end
	elseif var_37_2 == Data.ErrorType.card_cannot_compose then
		ToastManager.push(param)
	end
end

function var_0_0.onUpgradeSuccess(arg_38_0)
	ClientView.getActiveIndicator():hide()

	local var_38_0 = require("RewardCardPanel").create(Str(STR.UPGRADE) .. Str(STR.SUCCESS), {
		{
			_num = 1,
			_infoId = arg_38_0._infoId
		}
	})

	var_38_0:show()

	if false then
		local var_38_1 = Data._skillInfo[newSkillId]
		local var_38_2 = card._newSkillId > 0
		local var_38_3
		local var_38_4
		local var_38_5
		local var_38_6 = string.format("%s%s", Str(STR.GET), Str(STR.SKILL_ADDITION))
		local var_38_7 = string.format("%s (+%d)", Str(var_38_1._nameSid), newSkillLevel)

		if var_38_2 then
			var_38_5 = string.format("%s (+%d)", Str(Data._skillInfo[card._newSkillId]._nameSid), card._newSkillLevel)
		end

		local var_38_8 = ClientView.createTTF(var_38_7, var_38_2 and ClientView.FontSize.S1 or ClientView.FontSize.M1, ClientView.COLOR_TEXT_GREEN_DARK)
		local var_38_9 = lc.createSprite(string.format("img_icon_skill_%d", Data.getSkillType(var_38_1._id)))

		var_38_9:setScale(var_38_2 and 0.6 or 0.8)

		local var_38_10 = math.max(240, math.floor(lc.sw(var_38_9)) + 10 + lc.w(var_38_8) + 60)
		local var_38_11 = 140

		if var_38_2 then
			var_38_10, var_38_11 = var_38_10 + 200, var_38_11 + 30
		end

		local var_38_12 = lc.createImageView({
			_name = "img_com_bg_4",
			_crect = ClientView.CRECT_COM_BG4,
			_size = cc.size(var_38_10, var_38_11)
		})

		ClientView.addSkillTapHandler(var_38_12, newSkillId, 1)

		local var_38_13 = ClientView.createTTF(var_38_6, ClientView.FontSize.S1, ClientView.COLOR_LABEL_DARK)

		lc.addChildToPos(var_38_12, var_38_13, cc.p(var_38_10 / 2, var_38_11 - 20 - lc.h(var_38_13) / 2))
		lc.addNodesToCenter(var_38_12, {
			var_38_9,
			var_38_8
		}, 10, var_38_2 and 94 or 54)

		if var_38_2 then
			local var_38_14 = string.splitByChar(Str(STR.PROMPT_SUB_REPLACE), "|")
			local var_38_15 = ccui.RichTextEx:create()

			var_38_15:insertElement(ccui.RichItemLabel:create(0, ClientView.COLOR_TEXT_DARK, 255, var_38_14[1], ClientView.TTF_FONT, ClientView.FontSize.S2))

			local var_38_16 = lc.createSprite(string.format("img_icon_skill_%d", Data.getType(card._newSkillId)))

			var_38_16:setScale(0.5)

			local var_38_17 = lc.createNode(cc.size(30, 30))

			lc.addChildToCenter(var_38_17, var_38_16)
			var_38_15:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, var_38_17))
			var_38_15:insertElement(ccui.RichItemLabel:create(0, ClientView.COLOR_TEXT_GREEN_DARK, 255, var_38_5, ClientView.TTF_FONT, ClientView.FontSize.S2))
			var_38_15:insertElement(ccui.RichItemLabel:create(0, ClientView.COLOR_TEXT_DARK, 255, var_38_14[2], ClientView.TTF_FONT, ClientView.FontSize.S2))
			lc.addChildToPos(var_38_12, var_38_15, cc.p(lc.w(var_38_12) / 2, 50))
			ClientView.addSkillTapHandler(var_38_15, card._newSkillId, 1)
			lc.offset(var_38_0._btnBack, -lc.w(var_38_0._btnBack) / 2 - 10)

			local var_38_18 = ClientView.createScale9ShaderButton("img_btn_1", function()
				card._newSkillId = newSkillId
				card._newSkillLevel = newSkillLevel
				card._newSkillCache = 0

				card:sendCardDirty()
				ClientData.sendCardSetSkill(card._id, card._infoId, true)
				arg_38_0:updateView()
				var_38_0:hide()
			end, ClientView.CRECT_BUTTON, lc.w(var_38_0._btnBack))

			function var_38_0._btnBack._callback()
				card._newSkillCache = 0

				ClientData.sendCardSetSkill(card._id, card._infoId, false)
				arg_38_0:updateView()
				var_38_0:hide()
			end

			var_38_18:addLabel(Str(STR.REPLACE))
			lc.addChildToPos(var_38_0, var_38_18, cc.p(lc.w(var_38_0) / 2 + 10 + lc.w(var_38_18) / 2, lc.y(var_38_0._btnBack)))
			var_38_0:addTouchEventListener(function()
				return
			end)
		else
			card._newSkillId = newSkillId
			card._newSkillLevel = newSkillLevel
			card._newSkillCache = 0

			card:sendCardDirty()
			arg_38_0:updateView()
		end

		lc.addChildToPos(var_38_0, var_38_12, cc.p(lc.w(var_38_0) / 2, lc.top(var_38_0._btnBack) + 110))
		lc.addChildToCenter(lc._runningScene._scene, Particle.create("par_card_rebirth4"), ClientData.ZOrder.effect)
	else
		arg_38_0._level = arg_38_0._level + 1

		lc.addChildToCenter(lc._runningScene._scene, Particle.create("par_card_rebirth3"), ClientData.ZOrder.effect)
		arg_38_0:updateView()

		if GuideManager.getCurStepName() == "evolve card 2" then
			GuideManager.finishStepLater()
		end
	end
end

function var_0_0.onCompose(arg_42_0)
	local var_42_0 = Data.getType(arg_42_0._infoId)
	local var_42_1 = P._playerCard:composeCard(arg_42_0._infoId, arg_42_0._count)

	if var_42_1 == Data.ErrorType.ok then
		local var_42_2 = arg_42_0._leftThumbnail
		local var_42_3 = Particle.create("par_card_mix")

		if var_42_2 then
			var_42_3:setPosition(arg_42_0:convertToNodeSpace(var_42_2:convertToWorldSpace(cc.p(lc.w(var_42_2) / 2, lc.h(var_42_2) / 2))))
		else
			var_42_3:setVisible(false)
		end

		arg_42_0:addChild(var_42_3, ClientData.ZOrder.effect)
		ClientView.getActiveIndicator():show()
		arg_42_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_42_3:getDuration()), cc.CallFunc:create(function()
			ClientView.getActiveIndicator():hide()
			ClientData.sendCardCompose(arg_42_0._infoId, arg_42_0._count)
			var_42_3:stopSystem()
			var_42_3:removeFromParent()

			if var_42_0 == Data.CardType.monster then
				local var_43_0 = cc.EventCustom:new(Data.Event.mix_hero)

				lc.Dispatcher:dispatchEvent(var_43_0)
			end

			lc.Audio.playAudio(AUDIO.E_CARD_MIX)
			require("RewardCardPanel").create(Str(STR.COMPOSE) .. Str(STR.SUCCESS), {
				{
					_infoId = arg_42_0._infoId,
					_num = arg_42_0._count
				}
			}):show()
			arg_42_0:updateView()
		end)))
	elseif var_42_1 == Data.ErrorType.need_more_gold then
		ToastManager.push(Str(STR.NOT_ENOUGH_GOLD))
		require("ExchangeResForm").create(Data.ResType.gold):show()
	elseif var_42_1 == Data.ErrorType.need_more_dust then
		local var_42_4 = {
			[Data.CardType.monster] = STR.SID_PROPS_NAME_7015,
			[Data.CardType.magic] = STR.SID_PROPS_NAME_7016,
			[Data.CardType.trap] = STR.SID_PROPS_NAME_7017
		}

		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(var_42_4[var_42_0])))
	end
end

function var_0_0.onDecompose(arg_44_0)
	local var_44_0 = Data.getType(arg_44_0._infoId)

	if arg_44_0._count == 0 then
		ToastManager.push(Str(STR.SELECT_COUNT_FIRST))

		return
	elseif arg_44_0._count > arg_44_0._max then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getStrByCardType(var_44_0)))

		return
	end

	if P._playerCard:getCardCount(arg_44_0._infoId) - arg_44_0._count < 3 then
		return require("Dialog").showDialog("Sau khi phân tách, số lượng lá bài này sẽ ít hơn 3 bản sao. Bạn có chắc chắn muốn phân tách không?", function()
			arg_44_0:doDecompose()
		end)
	end

	arg_44_0:doDecompose()
end

function var_0_0.doDecompose(arg_46_0)
	local var_46_0 = P._playerCard:decomposeCard(arg_46_0._infoId, arg_46_0._count)

	if var_46_0 == Data.ErrorType.ok then
		local var_46_1 = arg_46_0._leftThumbnail
		local var_46_2 = Particle.create("par_card_mix")

		if var_46_1 then
			var_46_2:setPosition(arg_46_0:convertToNodeSpace(var_46_1:convertToWorldSpace(cc.p(lc.w(var_46_1) / 2, lc.h(var_46_1) / 2))))
		else
			var_46_2:setVisible(false)
		end

		arg_46_0:addChild(var_46_2, ClientData.ZOrder.effect)
		ClientView.getActiveIndicator():show()
		arg_46_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_46_2:getDuration()), cc.CallFunc:create(function()
			ClientView.getActiveIndicator():hide()
			ClientData.sendCardDecompose(arg_46_0._infoId, arg_46_0._count)
			var_46_2:stopSystem()
			var_46_2:removeFromParent()

			if cardType == Data.CardType.monster then
				-- block empty
			end

			lc.Audio.playAudio(AUDIO.E_CARD_MIX)

			local var_47_0, var_47_1 = P._playerCard:getDecomposeDust(arg_46_0._infoId)
			local var_47_2 = require("RewardPanel")

			var_47_2.create({
				{
					_infoId = var_47_0,
					_count = var_47_1 * arg_46_0._count
				}
			}, var_47_2.MODE_SPLIT):show()
			arg_46_0:updateView()
		end)))
	elseif var_46_0 == Data.ErrorType.need_more_gold then
		ToastManager.push(Str(STR.NOT_ENOUGH_GOLD))
		require("ExchangeResForm").create(Data.ResType.gold):show()
	elseif var_46_0 == Data.ErrorType.need_more_samecard then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getStrByCardType(cardType)))
	end
end

function var_0_0.onRecovery(arg_48_0)
	local var_48_0 = Data.getType(arg_48_0._infoId)

	if arg_48_0._count == 0 then
		ToastManager.push(Str(STR.SELECT_COUNT_RECOVERY))

		return
	elseif arg_48_0._count > arg_48_0._max then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getStrByCardType(var_48_0)))

		return
	end

	if P._playerCard:getCardCount(arg_48_0._infoId) - arg_48_0._count <= 3 then
		return require("Dialog").showDialog(string.format(Str(STR.FEW_AFTER_RECOVERY)), function()
			arg_48_0:doRecovery()
		end)
	end

	arg_48_0:doRecovery()
end

function var_0_0.doRecovery(arg_50_0)
	local var_50_0 = P._playerCard:recoveryCard(arg_50_0._infoId, arg_50_0._count, nil, arg_50_0._card._id)

	if var_50_0 == Data.ErrorType.ok then
		local var_50_1 = arg_50_0._leftThumbnail
		local var_50_2 = Particle.create("par_card_mix")

		if var_50_1 then
			var_50_2:setPosition(arg_50_0:convertToNodeSpace(var_50_1:convertToWorldSpace(cc.p(lc.w(var_50_1) / 2, lc.h(var_50_1) / 2))))
		else
			var_50_2:setVisible(false)
		end

		arg_50_0:addChild(var_50_2, ClientData.ZOrder.effect)
		ClientView.getActiveIndicator():show()
		arg_50_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_50_2:getDuration()), cc.CallFunc:create(function()
			ClientView.getActiveIndicator():hide()
			ClientData.sendCardRecovery(arg_50_0._infoId, arg_50_0._count)
			var_50_2:stopSystem()
			var_50_2:removeFromParent()
			lc.Audio.playAudio(AUDIO.E_CARD_MIX)

			local var_51_0, var_51_1 = P._playerCard:getRecoveryDust(arg_50_0._card._id)
			local var_51_2 = require("RewardPanel")

			var_51_2.create({
				{
					_infoId = var_51_0,
					_count = var_51_1 * arg_50_0._count
				}
			}, var_51_2.MODE_SPLIT):show()
			arg_50_0:updateView()
		end)))
	elseif var_50_0 == Data.ErrorType.need_more_samecard then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getStrByCardType(cardType)))
	end
end

function var_0_0.onRecall(arg_52_0)
	local var_52_0 = Data.getType(arg_52_0._infoId)

	if arg_52_0._count == 0 then
		ToastManager.push(Str(STR.SELECT_COUNT_RECALL))

		return
	elseif arg_52_0._count > arg_52_0._max then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH_SAME_CARD_RECALL), ClientData.getStrByCardType(var_52_0)))

		return
	end

	if arg_52_0._removeTroopCount and arg_52_0._count > arg_52_0._removeTroopCount then
		return require("Dialog").showDialog(string.format(Str(STR.REMOVE_FROM_TROOP_TIP), ClientData.getNameByInfoId(arg_52_0._infoId)), function()
			P._playerCard:removeCardFromTroops(arg_52_0._infoId)
			arg_52_0:doRecall()
		end)
	end

	arg_52_0:doRecall()
end

function var_0_0.doRecall(arg_54_0)
	local var_54_0, var_54_1 = P._playerCard:recallCard(arg_54_0._infoId, arg_54_0._count, nil, arg_54_0._card._id)

	if var_54_0 == Data.ErrorType.ok then
		local var_54_2 = arg_54_0._leftThumbnail
		local var_54_3 = Particle.create("par_card_mix")

		if var_54_2 then
			var_54_3:setPosition(arg_54_0:convertToNodeSpace(var_54_2:convertToWorldSpace(cc.p(lc.w(var_54_2) / 2, lc.h(var_54_2) / 2))))
		else
			var_54_3:setVisible(false)
		end

		arg_54_0:addChild(var_54_3, ClientData.ZOrder.effect)
		ClientView.getActiveIndicator():show()
		arg_54_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_54_3:getDuration()), cc.CallFunc:create(function()
			ClientView.getActiveIndicator():hide()
			ClientData.sendCardRecall(arg_54_0._card._id, arg_54_0._count)
			var_54_3:stopSystem()
			var_54_3:removeFromParent()
			lc.Audio.playAudio(AUDIO.E_CARD_MIX)

			local var_55_0 = {}

			for iter_55_0, iter_55_1 in pairs(var_54_1) do
				var_55_0[#var_55_0 + 1] = {
					_infoId = iter_55_0,
					_count = iter_55_1
				}
			end

			local var_55_1 = require("RewardPanel")

			var_55_1.create(var_55_0, var_55_1.MODE_SPLIT):show()
			arg_54_0:updateView()
		end)))
	elseif var_54_0 == Data.ErrorType.need_more_samecard then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH_SAME_CARD_RECALL), ClientData.getStrByCardType(cardType)))
	end
end

function var_0_0.onMsg(arg_56_0, arg_56_1)
	if arg_56_1.type == SglMsgType_pb.PB_TYPE_CARD_EVOLUTION then
		-- block empty
	end

	return false
end

function var_0_0.onGuide(arg_57_0, arg_57_1)
	if GuideManager.getCurStepName():hasPrefix("evolve card") then
		GuideManager.setOperateLayer(arg_57_0._consumeMatArea._btn)
	else
		return
	end

	arg_57_1:stopPropagation()
end

return var_0_0
