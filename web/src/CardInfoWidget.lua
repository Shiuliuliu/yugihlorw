local var_0_0 = class("CardInfoWidget", lc.ExtendUIWidget)
local var_0_1 = require("CardInfoPanel")
local var_0_2 = 12
local var_0_3 = 6
local var_0_4 = 255
local var_0_5 = 128
local var_0_6 = ClientView.COLOR_TEXT_GREEN_DARK
local var_0_7 = ClientView.COLOR_TEXT_GRAY
local var_0_8 = ClientView.COLOR_TEXT_ORANGE
local var_0_9 = ClientView.COLOR_TEXT_LIGHT
local var_0_10 = var_0_7

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	arg_2_0._infoId = arg_2_1
	arg_2_0._cardId, arg_2_0._isFragment, arg_2_0._isGold, arg_2_0._extraSid = Data.removeAdditional(arg_2_1)
	arg_2_0._cardSpecificId = Data.setAdditional(arg_2_0._cardId, false, arg_2_0._isGold, arg_2_0._extraSid)
	arg_2_0._level = arg_2_2
	arg_2_0._isBrief = arg_2_4
	arg_2_0._card = arg_2_5
	arg_2_0._params = arg_2_6

	arg_2_0:setContentSize(arg_2_3)

	local var_2_0 = lc.List.createV(arg_2_3, 16, 20)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0, var_2_0)

	arg_2_0._list = var_2_0

	arg_2_0:updateList()
end

function var_0_0.updateList(arg_3_0)
	local var_3_0 = arg_3_0._list

	var_3_0:removeAllItems()

	local var_3_1, var_3_2 = Data.getInfo(arg_3_0._infoId)

	if not arg_3_0._isBrief then
		if var_3_2 == Data.CardType.monster or var_3_2 == Data.CardType.rare then
			var_3_0:pushBackCustomItem(arg_3_0:createCategory())
		end

		if var_3_1._keyword ~= 0 then
			var_3_0:pushBackCustomItem(arg_3_0:createKeyword())
		end

		var_3_0:pushBackCustomItem(arg_3_0:createDesc())
		var_3_0:pushBackCustomItem(arg_3_0:createUseLimit())
	end

	local var_3_3 = arg_3_0:createSkill()

	if var_3_3 then
		var_3_0:pushBackCustomItem(var_3_3)
	end

	if (var_3_2 == Data.CardType.monster or var_3_2 == Data.CardType.rare) and band(var_3_1._option, Data.MonsterOption.is_sync) == 0 and band(var_3_1._option, Data.MonsterOption.is_xyz) == 0 and band(var_3_1._option, Data.MonsterOption.is_pendulum) == 0 and (var_3_1._joinResult ~= nil and var_3_1._joinResult[1] ~= 0 or var_3_1._joinComponent ~= nil and var_3_1._joinComponent[1] ~= 0) then
		var_3_0:pushBackCustomItem(arg_3_0:createMerge())
	end

	if not arg_3_0._isBrief and ClientData._userRegion and #Str(var_3_1._guideSid) > 1 then
		var_3_0:pushBackCustomItem(arg_3_0:createGuide())
	end

	if arg_3_0._isBrief then
		local var_3_4 = 20

		for iter_3_0 = 1, #var_3_0:getItems() do
			var_3_4 = var_3_4 + lc.h(var_3_0:getItems()[iter_3_0]) + 20
		end

		local var_3_5 = var_3_4 - 20

		arg_3_0:setContentSize(lc.w(var_3_0), var_3_5)
		var_3_0:setContentSize(lc.w(var_3_0), var_3_5)
		var_3_0:setPositionY(math.floor(var_3_5 / 2))
	end
end

function var_0_0.createItemBegin(arg_4_0, arg_4_1)
	local var_4_0 = 12
	local var_4_1 = lc.w(arg_4_0._list) - 20
	local var_4_2 = ccui.Widget:create()

	var_4_2:setContentSize(var_4_1, 0)

	function var_4_2.createText(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = ClientView.createTTF(arg_5_1)

		if arg_5_2 then
			var_5_0:setColor(arg_5_2)
		end

		if arg_5_3 then
			var_5_0:setDimensions(arg_5_3, 0)
		end

		return var_5_0
	end

	function var_4_2.createRichText(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = ClientView.createTTF(arg_6_1)

		if arg_6_3 ~= nil and lc.w(var_6_0) > arg_6_3 + 4 then
			var_6_0 = ClientView.createBoldRichTextMultiLine(arg_6_1, ClientView.RICHTEXT_PARAM_LIGHT_S2, arg_6_3 + 4)
		else
			var_6_0 = ClientView.createBoldRichTextMultiLine(arg_6_1, ClientView.RICHTEXT_PARAM_LIGHT_S2)
		end

		var_6_0:setAnchorPoint(cc.p(0, 0.5))

		return var_6_0
	end

	if arg_4_1 then
		local var_4_3 = ClientView.addDecoratedLabel(var_4_2, arg_4_1, cc.p(var_4_1 / 2 - 20, 0), var_0_2)

		var_4_2._title = var_4_3
		var_4_0 = var_4_0 + lc.h(var_4_3) + 4
	else
		var_4_0 = var_4_0 - 8
	end

	return var_4_2, arg_4_0._infoId, var_4_1, var_4_0
end

function var_0_0.createItemEnd(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_3

	arg_7_1:setContentSize(cc.size(arg_7_2, arg_7_3))

	for iter_7_0, iter_7_1 in ipairs(arg_7_1:getChildren()) do
		arg_7_3 = iter_7_1:getPositionY()

		iter_7_1:setPositionY(var_7_0 - arg_7_3 - lc.sh(iter_7_1) / 2)
	end

	local var_7_1 = lc.createSprite("img_divide_line_8")

	var_7_1:setScale(lc.w(arg_7_0._list) / lc.w(var_7_1), 1)
	lc.addChildToPos(arg_7_1, var_7_1, cc.p(lc.w(arg_7_1) / 2, lc.h(var_7_1) / 2 - 14))

	return arg_7_1
end

function var_0_0.createCategory(arg_8_0)
	local var_8_0, var_8_1, var_8_2, var_8_3 = arg_8_0:createItemBegin(Str(STR.CARD_CATEGORY))
	local var_8_4, var_8_5 = Data.getInfo(var_8_1)
	local var_8_6 = ""

	for iter_8_0 = 1, 14 do
		if band(var_8_4._option, 2^(iter_8_0 - 1)) ~= 0 then
			if var_8_6 ~= "" then
				var_8_6 = var_8_6 .. Str(STR.DOT)
			end

			var_8_6 = var_8_6 .. Str(STR.MONSTER_FLAG_BEGIN + iter_8_0)
		end
	end

	local var_8_7 = var_8_0:createText(Str(STR.CARD_CATEGORY_BEGIN + var_8_4._category) .. " - " .. var_8_6, ClientView.COLOR_TEXT_LIGHT, var_8_2 - 10)

	lc.addChildToPos(var_8_0, var_8_7, cc.p(var_8_2 / 2, var_8_3))

	return arg_8_0:createItemEnd(var_8_0, var_8_2, var_8_3 + lc.h(var_8_7))
end

function var_0_0.createKeyword(arg_9_0)
	local var_9_0, var_9_1, var_9_2, var_9_3 = arg_9_0:createItemBegin(Str(STR.CARD_KEYWORD))
	local var_9_4 = Data.getInfo(var_9_1)
	local var_9_5 = var_9_0:createText(Str(STR.CARD_KEYWORD_BEGIN + var_9_4._keyword), ClientView.COLOR_TEXT_LIGHT, var_9_2 - 10)

	lc.addChildToPos(var_9_0, var_9_5, cc.p(var_9_2 / 2, var_9_3))

	return arg_9_0:createItemEnd(var_9_0, var_9_2, var_9_3 + lc.h(var_9_5))
end

function var_0_0.createDesc(arg_10_0)
	local var_10_0, var_10_1, var_10_2, var_10_3 = arg_10_0:createItemBegin(Str(STR.MEMOIR))
	local var_10_4 = Data.getInfo(var_10_1)
	local var_10_5 = var_10_0:createRichText(Str(var_10_4._descSid), ClientView.COLOR_TEXT_LIGHT, var_10_2 - 10)

	lc.addChildToPos(var_10_0, var_10_5, cc.p(var_0_3, var_10_3))

	return arg_10_0:createItemEnd(var_10_0, var_10_2, var_10_3 + lc.h(var_10_5))
end

function var_0_0.createGuide(arg_11_0)
	local var_11_0, var_11_1, var_11_2, var_11_3 = arg_11_0:createItemBegin()
	local var_11_4 = Data.getInfo(var_11_1)
	local var_11_5 = var_11_0:createRichText(Str(var_11_4._guideSid, true), ClientView.COLOR_TEXT_LIGHT, var_11_2 - 10)

	lc.addChildToPos(var_11_0, var_11_5, cc.p(var_0_3, var_11_3))

	return arg_11_0:createItemEnd(var_11_0, var_11_2, var_11_3 + lc.h(var_11_5))
end

function var_0_0.createUseLimit(arg_12_0)
	local var_12_0, var_12_1, var_12_2, var_12_3 = arg_12_0:createItemBegin(Str(STR.USE_LIMITED))
	local var_12_4 = Data.getInfo(var_12_1)
	local var_12_5 = var_12_0:createText(string.format(Str(STR.USE_LIMIT_DESC), var_12_4._maxCount), ClientView.COLOR_TEXT_LIGHT, var_12_2 - 10)

	lc.addChildToPos(var_12_0, var_12_5, cc.p(var_12_2 / 2, var_12_3))

	return arg_12_0:createItemEnd(var_12_0, var_12_2, var_12_3 + lc.h(var_12_5))
end

function var_0_0.createSkill(arg_13_0)
	local var_13_0, var_13_1, var_13_2, var_13_3 = arg_13_0:createItemBegin(Str(STR.SKILL))
	local var_13_4, var_13_5 = Data.getInfo(var_13_1)

	if not arg_13_0._isBrief then
		local var_13_6 = ClientView.createTTF(Str(STR.SKILL_TAP_TIP), ClientView.FontSize.S3, ClientView.COLOR_TEXT_LIGHT_BLUE)

		lc.addChildToPos(var_13_0, var_13_6, cc.p(var_13_2 - lc.w(var_13_6) / 2 - 4, var_13_3 - 32))
	end

	local var_13_7 = {}

	if ClientView.isInBattleScene() and arg_13_0._card then
		for iter_13_0 = 1, #arg_13_0._card._skills do
			if arg_13_0._card._skills[iter_13_0]._id ~= 3851 and arg_13_0._card._skills[iter_13_0]._id ~= 6753 and arg_13_0._card._skills[iter_13_0]._id ~= 9298 and arg_13_0._card._skills[iter_13_0]._id ~= arg_13_0._extraSid then
				local var_13_8 = Data._skillInfo[arg_13_0._card._skills[iter_13_0]._id]
				local var_13_9 = {
					_skillInfo = var_13_8,
					_skillLevel = arg_13_0._level,
					_provider = arg_13_0._card._skills[iter_13_0]._provider
				}

				table.insert(var_13_7, var_13_9)
			end
		end
	else
		for iter_13_1 = 1, #var_13_4._skillId do
			local var_13_10 = Data._skillInfo[var_13_4._skillId[iter_13_1]]

			if var_13_10 then
				local var_13_11 = {
					_skillInfo = var_13_10,
					_skillLevel = arg_13_0._level
				}

				table.insert(var_13_7, var_13_11)
			end
		end
	end

	local var_13_12 = 4
	local var_13_13 = 10
	local var_13_14 = #var_13_7 > 0

	if arg_13_0._params and arg_13_0._params._isEquip and (var_13_5 == Data.CardType.monster or var_13_5 == Data.CardType.rare) then
		local var_13_15 = P._playerFindSurvivalEx._skills[arg_13_0._infoId] or {}

		if #var_13_15 > 0 then
			for iter_13_2, iter_13_3 in ipairs(var_13_15) do
				iter_13_3 = math.floor(iter_13_3 / Data.INFO_ID_FRAGMENT_SIZE_LARGE)

				local var_13_16 = Data._skillInfo[iter_13_3]

				if var_13_16 then
					local var_13_17 = {
						_isEquiped = true,
						_skillInfo = var_13_16,
						_skillLevel = arg_13_0._level
					}

					table.insert(var_13_7, 1, var_13_17)
				end
			end

			var_13_14 = true
		end

		local var_13_18 = P._playerFindSurvivalEx:getCouldEquipSkills(arg_13_0._infoId)

		if #var_13_18 > 0 then
			local var_13_19 = ClientView.createShaderButton(nil, function()
				require("EquipSkillForm").create(arg_13_0._infoId, var_13_18, function()
					arg_13_0:updateList()
				end):show()
			end)

			var_13_19:setContentSize(cc.size(200, 80))

			local var_13_20 = lc.createSprite("img_compose_add")

			var_13_20:setScale(60 / lc.w(var_13_20))
			lc.addChildToPos(var_13_19, var_13_20, cc.p(lc.sw(var_13_20) / 2, lc.ch(var_13_19)))

			local var_13_21 = V.createTTF(Str(STR.EQUIP_SKILL))

			lc.addChildToPos(var_13_19, var_13_21, cc.p(lc.sw(var_13_20) + 10 + lc.cw(var_13_21), lc.ch(var_13_19)))
			lc.addChildToPos(var_13_0, var_13_19, cc.p(lc.cw(var_13_19), var_13_3))

			var_13_3 = var_13_3 + lc.h(var_13_19)
			var_13_14 = true
		end
	end

	local var_13_22 = Data.getInfo(arg_13_0._infoId)

	if arg_13_0._extraSid > 0 then
		local var_13_23 = Data._skillInfo[arg_13_0._extraSid]

		if var_13_23 then
			local var_13_24 = {
				_isRubbed = true,
				_skillInfo = var_13_23,
				_skillLevel = arg_13_0._level
			}

			table.insert(var_13_7, 1, var_13_24)
		end

		var_13_14 = true
	elseif var_0_1._operateType == var_0_1.OperateType.operate or var_0_1._operateType == var_0_1.OperateType.recovery then
		local var_13_25 = P._playerCard:getCardFreeCount(arg_13_0._cardSpecificId)
		local var_13_26 = P._propBag:getCouldEquipSkillItems(arg_13_0._infoId)

		if #var_13_26 > 0 then
			local var_13_27 = ClientView.createShaderButton(nil, function()
				if var_13_25 <= 0 then
					return ToastManager.push(Str(STR.REMOVE_CARD_FROM_TROOP))
				end

				require("EquipSkillForm").create(arg_13_0._infoId, var_13_26):show()
			end)

			var_13_27:setContentSize(cc.size(200, 80))

			local var_13_28 = lc.createSprite("img_compose_add")

			var_13_28:setScale(60 / lc.w(var_13_28))
			lc.addChildToPos(var_13_27, var_13_28, cc.p(lc.sw(var_13_28) / 2, lc.ch(var_13_27)))

			local var_13_29 = V.createTTF(Str(STR.RUB_SKILL))

			lc.addChildToPos(var_13_27, var_13_29, cc.p(lc.sw(var_13_28) + 10 + lc.cw(var_13_29), lc.ch(var_13_27)))
			lc.addChildToPos(var_13_0, var_13_27, cc.p(lc.cw(var_13_27), var_13_3))

			var_13_3 = var_13_3 + lc.h(var_13_27)
			var_13_14 = true
		end
	end

	if not var_13_14 then
		return
	end

	for iter_13_4, iter_13_5 in ipairs(var_13_7) do
		local var_13_30, var_13_31, var_13_32 = ClientView.getSkillDisplayInfo(iter_13_5._skillInfo._id, iter_13_5._skillLevel)

		if lc.PLATFORM == cc.PLATFORM_OS_WINDOWS and ClientView.isInBattleScene() then
			var_13_31 = var_13_31 .. "(" .. iter_13_5._skillInfo._id .. ")"

			if iter_13_5._skillInfo._isIgnoreDefend ~= 0 then
				var_13_31 = var_13_31 .. "[D" .. iter_13_5._skillInfo._isIgnoreDefend .. "]"
			end

			if arg_13_0._card and arg_13_0._card._info._targetType ~= nil and arg_13_0._card._info._targetType ~= 0 then
				var_13_31 = var_13_31 .. "[T" .. arg_13_0._card._info._targetType .. "]"
			end
		end

		if iter_13_5._provider == BattleData.SkillProvider.extra or iter_13_5._provider == BattleData.SkillProvider.given then
			var_13_31 = var_13_31 .. " (" .. Str(STR.BATTLE_CARD_EXTRA_SKILL) .. ")"
		end

		local var_13_33 = lc.createSprite(var_13_30)

		if iter_13_5._isRubbed and (var_0_1._operateType == var_0_1.OperateType.operate or var_0_1._operateType == var_0_1.OperateType.recovery) then
			local var_13_34 = Data._unRubExInfo[arg_13_0._extraSid]
			local var_13_35 = P._playerCard:getCardFreeCount(arg_13_0._cardSpecificId)
			local var_13_36 = not Data.canSkillRub(arg_13_0._extraSid, arg_13_0._cardId)
			local var_13_37 = V.createScale9ShaderButton("img_btn_1_s", function()
				if var_13_35 <= 0 then
					return ToastManager.push(Str(STR.REMOVE_CARD_FROM_TROOP))
				end

				if var_13_36 then
					require("Dialog").showDialog(string.format(Str(STR.SURE_TO_UNRUB_EX), var_13_34._price), function()
						P:addResource(var_13_34._resType, 1, var_13_34._price)
						P._playerCard:unRubSkill(arg_13_0._cardSpecificId, true)
					end)
				elseif V.checkIngot(500) then
					require("Dialog").showDialog(Str(STR.SURE_TO_UNRUB), function()
						P:addResource(arg_13_0._extraSid * Data.INFO_ID_FRAGMENT_SIZE_LARGE, 1, 1)
						P:addResource(Data.ResType.ingot, 1, -500)
						P._playerCard:unRubSkill(arg_13_0._cardSpecificId)
					end)
				end
			end, V.CRECT_BUTTON_S, lc.w(var_13_33) + 10, lc.h(var_13_33))

			lc.addChildToCenter(var_13_33, var_13_37)

			local var_13_38 = V.createTTF(var_13_36 and Str(STR.UNRUB_EX) or Str(STR.UNRUB), V.FontSize.S3, V.COLOR_TEXT_WHITE)

			lc.addChildToCenter(var_13_37, var_13_38)
		end

		local var_13_39 = var_13_0:createText(var_13_31)
		local var_13_40 = var_13_0:createText(var_13_32, nil, var_13_2 - 10 - lc.w(var_13_33) - var_13_13)

		var_13_33:setOpacity(var_0_4)
		var_13_39:setColor((iter_13_5._provider == BattleData.SkillProvider.extra or iter_13_5._provider == BattleData.SkillProvider.given) and var_0_8 or var_0_6)
		var_13_40:setColor((iter_13_5._isEquiped or iter_13_5._isRubbed or iter_13_5._skillInfo._id == arg_13_0._extraSid) and ClientView.COLOR_TEXT_INGOT or var_0_9)

		local var_13_41 = math.max(lc.h(var_13_33), lc.h(var_13_39) + lc.h(var_13_40) + var_13_12)
		local var_13_42 = ccui.Widget:create()

		var_13_42:setContentSize(var_13_2, var_13_41)
		ClientView.addSkillTapHandler(var_13_42, iter_13_5._skillInfo._id, iter_13_5._skillLevel)
		lc.addChildToPos(var_13_0, var_13_42, cc.p(var_13_2 / 2, var_13_3))
		lc.addChildToPos(var_13_42, var_13_33, cc.p(lc.w(var_13_33) / 2, lc.h(var_13_42) - lc.h(var_13_33) / 2))
		lc.addChildToPos(var_13_42, var_13_39, cc.p(lc.right(var_13_33) + lc.w(var_13_39) / 2 + var_13_13, lc.top(var_13_33) - lc.h(var_13_39) / 2))
		lc.addChildToPos(var_13_42, var_13_40, cc.p(lc.left(var_13_39) + lc.w(var_13_40) / 2, lc.bottom(var_13_39) - lc.h(var_13_40) / 2 - var_13_12))

		var_13_3 = var_13_3 + lc.h(var_13_39) + var_13_12 + lc.h(var_13_40) + 16
	end

	return arg_13_0:createItemEnd(var_13_0, var_13_2, var_13_3)
end

function var_0_0.createMerge(arg_20_0)
	local var_20_0, var_20_1, var_20_2, var_20_3 = arg_20_0:createItemBegin(Str(STR.MERGE_RESULT))
	local var_20_4, var_20_5 = Data.getInfo(var_20_1)

	for iter_20_0 = 1, #var_20_4._joinResult do
		local var_20_6 = var_20_4._joinResult[iter_20_0]

		if var_20_6 ~= 0 then
			var_20_3 = arg_20_0:createMergeLine(Data.getInfo(var_20_6), var_20_0, var_20_3)
		end
	end

	local var_20_7 = arg_20_0:createMergeLine(var_20_4, var_20_0, var_20_3)

	return arg_20_0:createItemEnd(var_20_0, var_20_2, var_20_7)
end

function var_0_0.createMergeLine(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = not GuideManager.isGuideInCity() and not ClientView.isInBattleScene()

	if arg_21_1._joinComponent ~= nil and arg_21_1._joinComponent[1] ~= 0 then
		local var_21_1 = -2
		local var_21_2 = arg_21_3

		for iter_21_0 = 1, #arg_21_1._joinComponent do
			local var_21_3 = IconWidget.create({
				_infoId = arg_21_1._joinComponent[iter_21_0]
			})

			var_21_3:setTouchEnabled(var_21_0 and arg_21_1._joinComponent[iter_21_0] ~= arg_21_0._infoId)
			var_21_3._name:setColor(ClientView.COLOR_BMFONT)
			lc.addChildToPos(arg_21_2, var_21_3, cc.p(var_21_1 + lc.w(var_21_3) / 2, var_21_2))

			var_21_1 = var_21_1 + lc.w(var_21_3) + 10

			local var_21_4 = ClientView.createBMFont(ClientView.BMFont.huali_26, iter_21_0 == #arg_21_1._joinComponent and "=" or "+")

			lc.addChildToPos(arg_21_2, var_21_4, cc.p(var_21_1 + lc.w(var_21_4) / 2, var_21_2 + 40))

			var_21_1 = var_21_1 + lc.w(var_21_4) + 10
		end

		local var_21_5 = IconWidget.create({
			_infoId = arg_21_1._id
		})

		var_21_5:setTouchEnabled(var_21_0 and arg_21_1._id ~= arg_21_0._infoId)
		var_21_5._name:setColor(ClientView.COLOR_BMFONT)
		lc.addChildToPos(arg_21_2, var_21_5, cc.p(var_21_1 + lc.w(var_21_5) / 2, var_21_2))

		arg_21_3 = arg_21_3 + lc.h(var_21_5) + 20
	end

	return arg_21_3
end

return var_0_0
