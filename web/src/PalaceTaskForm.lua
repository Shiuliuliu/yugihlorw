local var_0_0 = class("PalaceTaskFrom", require("BaseForm"))
local var_0_1 = cc.size(854, 720)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form

	lc.offset(arg_2_0._btnBack, 0, -20)

	arg_2_0._task = arg_2_1

	local var_2_1 = 20
	local var_2_2 = require("IconWidget").create({
		_infoId = arg_2_1:getHeroInfoId()
	}, 0)

	var_2_2:setScale(0.6)
	lc.addChildToPos(var_2_0, var_2_2, cc.p(var_0_0.LEFT_MARGIN + 60, var_0_1.height - var_0_0.TOP_MARGIN - 50))

	local var_2_3 = ClientView.createTTF(arg_2_1:getThink(), nil, ClientView.COLOR_LABEL_DARK, cc.size(580, 0))

	var_2_3:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_2_0, var_2_3, cc.p(140, lc.y(var_2_2)))

	local var_2_4 = ClientView.createVerticalTitle(Str(STR.PALACE_REVIEW_RECOMMEND_HERO), ClientView.COLOR_SHADOW_BG_BROWN)

	lc.addChildToPos(var_2_0, var_2_4, cc.p(math.floor(lc.left(var_2_2)) + lc.w(var_2_4) / 2, math.floor(lc.bottom(var_2_2)) - 20 - lc.h(var_2_4) / 2))

	local var_2_5 = lc.right(var_2_4) + var_2_1
	local var_2_6 = lc.y(var_2_4)
	local var_2_7 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1._info._specialHero) do
		local var_2_8 = require("IconWidget").create({
			_infoId = iter_2_1
		}, IconWidget.DisplayFlag.NAME)

		lc.addChildToPos(var_2_0, var_2_8, cc.p(var_2_5 + lc.w(var_2_8) / 2, var_2_6))

		var_2_5 = var_2_5 + lc.w(var_2_8) + var_2_1

		table.insert(var_2_7, iter_2_1)
	end

	local var_2_9 = P._playerCard:getCards(Data.CardType.monster)

	for iter_2_2, iter_2_3 in pairs(var_2_9) do
		local var_2_10 = iter_2_3._infoId

		for iter_2_4, iter_2_5 in ipairs(var_2_7) do
			if iter_2_5 == Data.getBaseId(var_2_10) and iter_2_3._taskId == nil then
				iter_2_3._isRecommend = true

				table.remove(var_2_7, iter_2_4)

				break
			end
		end
	end

	local var_2_11 = ClientView.createVerticalTitle(Str(STR.PALACE_REVIEW_REWARD), ClientView.COLOR_SHADOW_BG_BROWN)

	lc.addChildToPos(var_2_0, var_2_11, cc.p(math.floor(lc.left(var_2_2)) + lc.w(var_2_11) / 2, math.floor(lc.bottom(var_2_4)) - 12 - lc.h(var_2_11) / 2))

	local var_2_12, var_2_13 = lc.right(var_2_11) + var_2_1, lc.y(var_2_11)

	arg_2_0._rewards = {}

	local var_2_14 = Data._bonusInfo[arg_2_1._info._bonus]

	for iter_2_6, iter_2_7 in ipairs(var_2_14._rid) do
		local var_2_15 = require("IconWidget").create({
			_count = 0,
			_infoId = iter_2_7,
			_isFragment = var_2_14._isFragment[iter_2_6] > 0
		}, IconWidget.DisplayFlag.ITEM)

		lc.addChildToPos(var_2_0, var_2_15, cc.p(var_2_12 + lc.w(var_2_15) / 2, var_2_13))
		table.insert(arg_2_0._rewards, var_2_15)

		var_2_12 = var_2_12 + lc.w(var_2_15) + var_2_1
	end

	local var_2_16 = ClientView.addDecoratedLabel(var_2_0, Str(STR.PALACE_REVIEW_SELECT_HERO), cc.p(lc.w(var_2_0) / 2, lc.bottom(var_2_11) - 44), 26)
	local var_2_17 = ClientView.createBoldRichText(Str(STR.PALACE_REVIEW_REWARD_TIP), {
		_normalClr = ClientView.COLOR_TEXT_DARK,
		_boldClr = ClientView.COLOR_TEXT_GREEN_DARK
	})

	lc.addChildToPos(var_2_0, var_2_17, cc.p(lc.w(var_2_0) / 2, lc.bottom(var_2_16) - 20))

	local var_2_18 = arg_2_1._info._slot
	local var_2_19, var_2_20 = (lc.w(var_2_0) - (IconWidget.SIZE + var_2_1) * var_2_18 + var_2_1) / 2, lc.bottom(var_2_17) - 10 - IconWidget.SIZE / 2

	arg_2_0._heroSlots = {}

	for iter_2_8 = 1, arg_2_1._info._slot do
		local var_2_21 = ClientView.createShaderButton("card_rect_add", function(arg_3_0)
			arg_2_0:selectHero()
		end)

		var_2_21:setTouchEnabled(arg_2_1._timestamp == 0)
		lc.addChildToPos(var_2_0, var_2_21, cc.p(var_2_19 + lc.w(var_2_21) / 2, var_2_20))
		table.insert(arg_2_0._heroSlots, var_2_21)

		var_2_19 = var_2_19 + lc.w(var_2_21) + var_2_1
	end

	local var_2_22 = ClientView.createProgressBar(320, lc.Color3B.orange)
	local var_2_23 = ClientView.createKeyValueLabel(Str(STR.PALACE_REVIEW_DURATION), ClientData.formatPeriod(arg_2_1:getDuration(), 1), ClientView.FontSize.S2, true)

	var_2_23:addToParent(var_2_22, cc.p((lc.w(var_2_22) - var_2_23:getTotalWidth()) / 2, lc.h(var_2_22) / 2))
	lc.addChildToPos(var_2_0, var_2_22, cc.p(lc.w(var_2_0) / 2, var_0_0.BOTTOM_MARGIN + lc.h(var_2_22) / 2 + 36))

	if arg_2_1._timestamp == 0 then
		local var_2_24 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_4_0)
			arg_2_0:ignore(false)
		end, ClientView.CRECT_BUTTON, 150)

		var_2_24:addLabel(Str(STR.IGNORE))
		lc.addChildToPos(var_2_0, var_2_24, cc.p(lc.left(var_2_11) + lc.w(var_2_24) / 2, lc.y(var_2_22)))

		local var_2_25 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_5_0)
			arg_2_0:confirm()
		end, ClientView.CRECT_BUTTON, 150)

		var_2_25:addLabel(Str(STR.GEWHRT))
		lc.addChildToPos(var_2_0, var_2_25, cc.p(lc.w(var_2_0) - lc.x(var_2_24), lc.y(var_2_22)))

		arg_2_0._btnConfirm = var_2_25

		arg_2_0:updateRewardsCount()
	else
		arg_2_0:setHeroSlots(arg_2_1._monsters)
	end
end

function var_0_0.updateSelHeroes(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._heroSlots) do
		iter_6_1:removeAllChildren()

		if iter_6_1._hero then
			local var_6_0 = IconWidget.createByInfoId(iter_6_1._hero, nil, 0)

			var_6_0:setTouchEnabled(arg_6_0._task._timestamp > 0)
			lc.addChildToCenter(iter_6_1, var_6_0)
		end
	end

	arg_6_0:updateRewardsCount()
end

function var_0_0.selectHero(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._heroSlots) do
		if iter_7_1._hero then
			table.insert(var_7_0, iter_7_1._hero)
		end
	end

	local var_7_1 = require("CardSelectForm").createPalaceForm(var_7_0)

	var_7_1:show()
	var_7_1:registerSelectedHandler(function(arg_8_0)
		arg_7_0:setHeroSlots(arg_8_0)
	end)
end

function var_0_0.setHeroSlots(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._heroSlots) do
		if iter_9_0 <= #arg_9_1 then
			iter_9_1._hero = arg_9_1[iter_9_0]
		else
			iter_9_1._hero = nil
		end
	end

	arg_9_0:updateSelHeroes()
end

function var_0_0.updateRewardsCount(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._heroSlots) do
		if iter_10_1._hero then
			table.insert(var_10_0, iter_10_1._hero)
		end
	end

	local var_10_1 = arg_10_0._task
	local var_10_2 = P._playerPalace:calcTaskRewardsPercent(var_10_1, var_10_0)
	local var_10_3 = arg_10_0._rewards
	local var_10_4 = Data._bonusInfo[var_10_1._info._bonus]

	for iter_10_2, iter_10_3 in ipairs(var_10_4._count) do
		iter_10_3 = math.floor(iter_10_3 * var_10_2)

		local var_10_5 = var_10_3[iter_10_2]._countBg._count

		var_10_5:setString(tostring(iter_10_3))

		if iter_10_3 > 0 then
			var_10_5:runAction(lc.sequence(lc.scaleTo(0.5, 1.8), lc.scaleTo(0.2, 1)))
		end
	end
end

function var_0_0.confirm(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._heroSlots) do
		if iter_11_1._hero then
			table.insert(var_11_0, iter_11_1._hero)
		end
	end

	if #var_11_0 == 0 then
		ToastManager.push(Str(STR.PALACE_REVIEW_AT_LEAST_ONE_HERO))

		return
	end

	if not arg_11_1 and #var_11_0 < #arg_11_0._heroSlots then
		require("Dialog").showDialog(string.format(Str(STR.PALACE_REVIEW_CONFIRM_DO), #arg_11_0._heroSlots), function()
			arg_11_0:confirm(true)
		end)

		return
	end

	if P._playerPalace:confirmTask(arg_11_0._task, var_11_0) == Data.ErrorType.ok then
		local var_11_1 = {}

		for iter_11_2, iter_11_3 in ipairs(var_11_0) do
			table.insert(var_11_1, iter_11_3._id)
		end

		ClientData.sendConfirmPalaceTask(arg_11_0._task._id, var_11_1)
		arg_11_0:hide()
	end
end

function var_0_0.ignore(arg_13_0, arg_13_1)
	if not arg_13_1 then
		require("Dialog").showDialog(Str(STR.SURE_TO_IGNORE), function()
			arg_13_0:ignore(true)
		end)

		return
	end

	P._playerPalace._tasks[arg_13_0._task._id] = nil

	P._playerPalace:sendPalaceTaskListDirty()
	ClientData.sendRemovePalaceTask(arg_13_0._task._id)
	arg_13_0:hide()
end

function var_0_0.onEnter(arg_15_0)
	var_0_0.super.onEnter(arg_15_0)

	arg_15_0._listener = lc.addEventListener(GuideManager.Event.seek, function(arg_16_0)
		arg_15_0:onGuide(arg_16_0)
	end)

	if GuideManager.isGuideEnabled() then
		GuideManager.finishStepLater()
	end
end

function var_0_0.onExit(arg_17_0)
	var_0_0.super.onExit(arg_17_0)
	lc.Dispatcher:removeEventListener(arg_17_0._listener)

	if GuideManager.isGuideEnabled() then
		GuideManager.finishStepLater()
	end
end

function var_0_0.onCleanup(arg_18_0)
	var_0_0.super.onCleanup(arg_18_0)

	local var_18_0 = P._playerCard:getCards(Data.CardType.monster)

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		iter_18_1._isRecommend = nil
	end
end

function var_0_0.onGuide(arg_19_0, arg_19_1)
	local var_19_0 = GuideManager.getCurStepName()

	if var_19_0 == "palace review selecthero" then
		GuideManager.setOperateLayer(arg_19_0._heroSlots[1])
	elseif var_19_0 == "palace review confirm" then
		GuideManager.setOperateLayer(arg_19_0._btnConfirm)
	else
		return
	end

	if arg_19_1 then
		arg_19_1:stopPropagation()
	end
end

return var_0_0
