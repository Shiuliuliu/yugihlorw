local var_0_0 = class("BattleInitiativeSkillsDialog", BasePanel)

var_0_0.LEFT_MARGIN = 36
var_0_0.RIGHT_MARGIN = 36
var_0_0.ACTION_DURATION = 0.3
var_0_0.ITEM_SIZE = cc.size(100, 120)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_WIDGET)

	var_1_0:setContentSize(ClientView.SCR_W, ClientView.SCR_H)
	var_1_0:setTouchEnabled(true)
	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.init(arg_2_0, false)

	arg_2_0._itemTouchHandles = {}
	arg_2_0._skillInfos = arg_2_1
	arg_2_0._row = math.ceil(#arg_2_1 / arg_2_3)
	arg_2_0._col = arg_2_3

	local var_2_0 = ClientView.createFrameBox(cc.size(900, 350))

	lc.addChildToPos(arg_2_0, var_2_0, cc.p(lc.cw(arg_2_0), 140))

	arg_2_0._form = var_2_0
	titleBg = lc.createSprite({
		_name = "img_form_title_bg_1",
		_crect = ClientView.CRECT_FORM_TITLE_BG1_CRECT,
		_size = cc.size(560, ClientView.CRECT_FORM_TITLE_BG1_CRECT.height)
	})

	lc.addChildToPos(arg_2_0._form, titleBg, cc.p(lc.w(arg_2_0._form) / 2, lc.h(arg_2_0._form) - lc.h(titleBg) / 2 + 10), 10)

	arg_2_0._titleArea = titleBg

	local var_2_1 = lc.createSprite({
		_name = "img_form_title_light_1",
		_crect = ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT,
		_size = cc.size(200, ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT.height)
	})

	lc.addChildToPos(titleBg, var_2_1, cc.p(lc.w(titleBg) / 2, lc.h(titleBg) / 2 + 4))

	local var_2_2
	local var_2_3 = cc.Label:createWithTTF(arg_2_2, ClientView.TTF_FONT, ClientView.FontSize.M1)

	var_2_3:setColor(ClientView.COLOR_TEXT_TITLE)
	var_2_3:setPosition(lc.w(titleBg) / 2, lc.h(titleBg) / 2 + 4)
	titleBg:addChild(var_2_3)

	arg_2_0._titleLabel = var_2_3

	arg_2_0:initCardList()
	arg_2_0:updateView()
end

function var_0_0.registerItemTouchHandles(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._itemTouchHandles._beginHandle = arg_3_1
	arg_3_0._itemTouchHandles._moveHandle = arg_3_2
	arg_3_0._itemTouchHandles._endHandle = arg_3_3
	arg_3_0._itemTouchHandles._longHandle = arg_3_4
end

function var_0_0.show(arg_4_0)
	lc.addChildToCenter(lc._runningScene, arg_4_0, BattleScene.ZOrder.form)
	lc.offset(arg_4_0._form, 0, -350)
	arg_4_0._form:runAction(lc.sequence(lc.ease(lc.moveBy(lc.absTime(var_0_0.ACTION_DURATION), cc.p(0, 350)), "BackO")))
end

function var_0_0.hide(arg_5_0)
	arg_5_0._isHiding = true

	arg_5_0._form:runAction(lc.sequence(lc.moveBy(lc.absTime(var_0_0.ACTION_DURATION), cc.p(0, -350)), function()
		arg_5_0:removeFromParent()
	end))
end

function var_0_0.confirm(arg_7_0)
	if arg_7_0._confirmFunction then
		arg_7_0._confirmFunction(arg_7_0)
	end

	arg_7_0:hide()
end

function var_0_0.initCardList(arg_8_0)
	arg_8_0._allCards = {}

	local var_8_0 = lc.List.createV(cc.size(lc.w(arg_8_0._form) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, 300))

	var_8_0:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(arg_8_0._form, var_8_0, cc.p(lc.cw(arg_8_0._form), lc.bottom(arg_8_0._titleArea) - lc.ch(var_8_0) + 20))

	arg_8_0._list = var_8_0

	local var_8_1 = lc.arrayToTable(arg_8_0._skillInfos, arg_8_0._col)

	for iter_8_0 = 1, #var_8_1 do
		local var_8_2 = var_8_1[iter_8_0]
		local var_8_3 = arg_8_0:createItem(var_8_2)

		var_8_0:pushBackCustomItem(var_8_3)
	end
end

function var_0_0.createItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = ccui.Widget:create()

	var_9_0:setContentSize(cc.size(lc.w(arg_9_0._list), var_0_0.ITEM_SIZE.height))

	local var_9_1 = lc.w(var_9_0) / arg_9_0._col

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_2 = iter_9_1._owner
		local var_9_3 = IconWidget.create(var_9_2, IconWidget.DisplayFlag.NAME)

		var_9_3._skill = iter_9_1

		var_9_3._name:setColor(ClientView.COLOR_TEXT_WHITE)

		var_9_3._nameColor = ClientView.COLOR_TEXT_WHITE

		var_9_3:registerTouchHandles(arg_9_0._itemTouchHandles)
		lc.addChildToPos(var_9_0, var_9_3, cc.p(var_9_1 * (iter_9_0 - 0.5), lc.ch(var_9_0)))

		if var_9_2._status == BattleData.CardStatus.grave then
			local var_9_4 = lc.createSprite("initiative_grave")

			lc.addChildToPos(var_9_3, var_9_4, cc.p(14, lc.h(var_9_3._frame) + 10))
		elseif var_9_2._status == BattleData.CardStatus.rare then
			local var_9_5 = lc.createSprite("initiative_rare")

			lc.addChildToPos(var_9_3, var_9_5, cc.p(14, lc.h(var_9_3._frame) + 10))
		elseif var_9_2._status == BattleData.CardStatus.hand then
			local var_9_6 = lc.createSprite("initiative_rare")

			lc.addChildToPos(var_9_3, var_9_6, cc.p(14, lc.h(var_9_3._frame) + 10))
		elseif var_9_2._status == BattleData.CardStatus.leave then
			local var_9_7 = lc.createSprite("initiative_grave")

			lc.addChildToPos(var_9_3, var_9_7, cc.p(14, lc.h(var_9_3._frame) + 10))
		end

		local var_9_8 = Data._skillInfo[iter_9_1._id]
		local var_9_9 = Str(var_9_8._nameSid)

		if iter_9_1._id == 3851 then
			var_9_9 = Str(iter_9_1._owner._info._briefNameSid)

			local var_9_10 = ClientView.createBMFont(ClientView.BMFont.huali_20, iter_9_1._owner:getStar())

			var_9_10:setAnchorPoint(1, 0)
			lc.addChildToPos(var_9_0, var_9_10, cc.p(lc.right(var_9_3) - 10, lc.bottom(var_9_3) + 36), 2)

			local var_9_11 = lc.createSprite("card_quality")

			lc.addChildToPos(var_9_0, var_9_11, cc.p(lc.left(var_9_10) - 14, lc.y(var_9_10) + 10), 2)
		elseif iter_9_1._id == 6753 then
			var_9_9 = Str(iter_9_1._owner._info._briefNameSid)

			local var_9_12 = ClientView.createBMFont(ClientView.BMFont.huali_20, iter_9_1._owner._info._joinComponent[1])

			var_9_12:setAnchorPoint(1, 0)
			lc.addChildToPos(var_9_0, var_9_12, cc.p(lc.right(var_9_3) - 10, lc.bottom(var_9_3) + 36), 2)

			local var_9_13 = lc.createSprite("card_quality")

			lc.addChildToPos(var_9_0, var_9_13, cc.p(lc.left(var_9_12) - 14, lc.y(var_9_12) + 10), 2)
		elseif iter_9_1._id == 9298 then
			var_9_9 = Str(iter_9_1._owner._info._briefNameSid)

			local var_9_14 = ClientView.createBMFont(ClientView.BMFont.huali_20, iter_9_1._owner:getLink())

			var_9_14:setAnchorPoint(1, 0)
			lc.addChildToPos(var_9_0, var_9_14, cc.p(lc.right(var_9_3) - 10, lc.bottom(var_9_3) + 36), 2)
		end

		var_9_3._name:setString(var_9_9)
		var_9_3._name:setScale(0.6)
		ClientView.fitLabel(var_9_3._name, lc.w(var_9_3._frame) + 16, 0.45)
		var_9_3._name:setPosition(lc.w(var_9_3) / 2, lc.sh(var_9_3._name) / 2)

		if not var_9_3._skillBadge then
			local var_9_sk_ico = lc.createSprite("img_icon_skill")
			if var_9_sk_ico then
				lc.addChildToPos(var_9_3._frame, var_9_sk_ico, cc.p(20, lc.h(var_9_3._frame) - 20), 2)
				var_9_3._skillBadge = var_9_sk_ico
			end
		end
	end

	return var_9_0
end

function var_0_0.updateView(arg_10_0)
	for iter_10_0 = 1, #arg_10_0._allCards do
		local var_10_0 = arg_10_0._allCards[iter_10_0]

		if arg_10_0:isInSelectedList(iter_10_0) then
			if not var_10_0._glow then
				local var_10_1 = DragonBones.create("xuanzhong")

				var_10_1:gotoAndPlay("effect1")
				var_10_1:setScale(1.4)
				lc.addChildToCenter(var_10_0, var_10_1, -1)

				var_10_0._glow = var_10_1
			end
		elseif var_10_0._glow then
			var_10_0._glow:removeFromParent()

			var_10_0._glow = nil
		end
	end

	if arg_10_0._confirmButton then
		local var_10_2 = arg_10_0:isChoiceSatisfied()

		arg_10_0._confirmButton:setEnabled(var_10_2)
	end
end

return var_0_0
