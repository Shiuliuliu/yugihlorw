local var_0_0 = class("DescForm", BaseForm)
local var_0_1 = 720
local var_0_2 = cc.size(560, 250)

function var_0_0.createByFixity(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:initByFixity(arg_1_0)

	return var_1_0
end

function var_0_0.initByFixity(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, cc.size(var_0_1, 440), Str(arg_2_1._info._nameSid), bor(BaseForm.FLAG.BASE_TITLE_BG, BaseForm.FLAG.PAPER_BG))

	local var_2_0 = 200
	local var_2_1 = 20
	local var_2_2 = lc.createSprite(string.format("f%d", arg_2_1._info._id))
	local var_2_3 = math.min(var_2_0 / lc.w(var_2_2), 1)
	local var_2_4 = math.min(var_2_0 / lc.h(var_2_2), 1)

	var_2_2:setScale(var_2_3 < var_2_4 and var_2_3 or var_2_4)
	lc.addChildToPos(arg_2_0._form, var_2_2, cc.p(var_0_0.FRAME_THICK_LEFT + var_2_1 + var_2_0 / 2, lc.bottom(arg_2_0._titleFrame) - var_2_1 - var_2_0 / 2))

	if arg_2_1._info._id == 1003 then
		lc.addChildToPos(var_2_2, lc.createSprite("f1003_5"), cc.p(lc.w(var_2_2) / 2, lc.h(var_2_2) / 2 + 10))
	end

	local var_2_5 = string.splitByChar(Str(arg_2_1._info._descSid), "|")
	local var_2_6 = var_2_5[2]
	local var_2_7 = var_2_5[1]
	local var_2_8 = ClientView.createTTF(var_2_6, ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK, cc.size(360, 90), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)

	lc.addChildToPos(arg_2_0._form, var_2_8, cc.p(var_0_0.LEFT_MARGIN + var_2_0 + var_2_1 + var_2_1 + lc.w(var_2_8) / 2, lc.bottom(arg_2_0._titleFrame) - var_2_1 - lc.h(var_2_8) / 2 - 20))

	local var_2_9 = ClientView.createTTF(string.format(Str(STR.BRACKETS_S), string.format(Str(STR.LORD_UNLOCK_LEVEL), P._playerCity:getUnlockLevel(arg_2_1))), ClientView.FontSize.S1, ClientView.COLOR_TEXT_GREEN_DARK)

	lc.addChildToPos(arg_2_0._form, var_2_9, cc.p(lc.right(var_2_8) - lc.w(var_2_9) / 2, lc.bottom(arg_2_0._titleFrame) - var_2_1 - var_2_0 + lc.h(var_2_9) / 2 + 30))

	local var_2_10 = ClientView.createTTF(var_2_7, nil, ClientView.COLOR_LABEL_DARK, cc.size(480, 0), cc.TEXT_ALIGNMENT_LEFT)

	lc.addChildToPos(arg_2_0._form, var_2_10, cc.p(lc.w(arg_2_0._form) / 2, var_0_0.BOTTOM_MARGIN + var_2_1 + var_2_1 + lc.h(var_2_10) / 2))
end

function var_0_0.create(arg_3_0)
	local var_3_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_3_0:init(arg_3_0)

	return var_3_0
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_1 = clone(arg_4_1)

	local var_4_0, var_4_1 = Data.getInfo(arg_4_1._infoId, 1)
	local var_4_2 = var_0_0.FRAME_THICK_TOP + 30
	local var_4_3 = lc._runningScene._sceneId == ClientData.SceneId.depot
	local var_4_4 = arg_4_1._showOwnCount or arg_4_1._count ~= nil
	local var_4_5 = P:getItemCount(arg_4_1._infoId)
	local var_4_6 = arg_4_1._count

	if not var_4_4 then
		var_4_6 = var_4_5
	end

	local var_4_7 = IconWidget.create({
		_infoId = arg_4_1._infoId,
		_count = var_4_6
	}, IconWidget.DisplayFlag.COUNT)

	var_4_7:setTouchEnabled(false)

	var_4_7._marginTop = var_4_2
	arg_4_0._icon = var_4_7

	local var_4_8 = ClientView.createTTF(ClientData.getNameByInfoId(arg_4_1._infoId), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)
	local var_4_9 = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = ClientView.CRECT_COM_BG2,
		_size = cc.size(400, 40)
	})

	var_4_9:setColor(lc.Color3B.black)
	var_4_9:setOpacity(100)
	lc.addChildToPos(var_4_9, var_4_8, cc.p(30 + lc.w(var_4_8) / 2, lc.h(var_4_9) / 2 - 1))

	local var_4_10 = 60
	local var_4_11 = Str(var_4_0._descSid)

	if var_4_1 == Data.CardType.card_skill or var_4_1 == Data.CardType.item_skill then
		var_4_11 = ClientData.getSkillDesc(math.floor(arg_4_1._infoId / Data.INFO_ID_FRAGMENT_SIZE_LARGE), 1) .. "\n|" .. (var_4_1 == Data.CardType.card_skill and Str(STR.EQUIP_TIP) or Str(STR.RUB_TIP)) .. "|"
	end

	local var_4_12

	if string.find(var_4_11, "|") ~= nil then
		var_4_12 = ClientView.createBoldRichText(var_4_11, ClientView.RICHTEXT_PARAM_LIGHT_S1, 440)
	else
		var_4_12 = ClientView.createTTF(var_4_11, ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(440, 0))
	end

	local var_4_13 = var_4_2 + math.max(lc.h(var_4_7), var_4_10 + lc.h(var_4_12))
	local var_4_14

	if var_4_1 == Data.CardType.item_skill then
		local var_4_15 = Data._unRubExInfo[Data.getExtraSid(arg_4_1._infoId)]

		if var_4_15 then
			local var_4_16 = ""
			local var_4_17 = 0

			if var_4_15._category[1] ~= 0 then
				var_4_17 = var_4_17 + 1
				var_4_16 = var_4_16 .. var_4_17 .. Str(STR.COLON) .. "|"

				for iter_4_0, iter_4_1 in ipairs(var_4_15._category) do
					var_4_16 = var_4_16 .. Str(STR.CARD_CATEGORY_BEGIN + iter_4_1)

					if iter_4_0 ~= #var_4_15._category then
						var_4_16 = var_4_16 .. Str(STR.DOT)
					end
				end

				var_4_16 = var_4_16 .. Str(STR.CARD_CATEGORY) .. "|\n"
			end

			if var_4_15._nature[1] ~= 0 then
				var_4_17 = var_4_17 + 1
				var_4_16 = var_4_16 .. var_4_17 .. Str(STR.COLON) .. "|"

				for iter_4_2, iter_4_3 in ipairs(var_4_15._nature) do
					var_4_16 = var_4_16 .. Str(STR.NATURE_NONE + iter_4_3)

					if iter_4_2 ~= #var_4_15._nature then
						var_4_16 = var_4_16 .. Str(STR.DOT)
					end
				end

				var_4_16 = var_4_16 .. Str(STR.ATTRIBUTE) .. "|\n"
			end

			if var_4_15._keyword[1] ~= 0 then
				var_4_17 = var_4_17 + 1
				var_4_16 = var_4_16 .. var_4_17 .. Str(STR.COLON) .. "|"

				for iter_4_4, iter_4_5 in ipairs(var_4_15._keyword) do
					var_4_16 = var_4_16 .. Str(STR.CARD_KEYWORD_BEGIN + iter_4_5)

					if iter_4_4 ~= #var_4_15._keyword then
						var_4_16 = var_4_16 .. Str(STR.DOT)
					end
				end

				var_4_16 = var_4_16 .. Str(STR.CARD_KEYWORD) .. "|\n"
			end

			if var_4_15._forbidCardId[1] ~= 0 then
				local var_4_18 = var_4_17 + 1

				var_4_16 = var_4_16 .. var_4_18 .. Str(STR.COLON) .. "|"
				var_4_16 = var_4_16 .. Str(STR.NOT_S)

				for iter_4_6, iter_4_7 in ipairs(var_4_15._forbidCardId) do
					var_4_16 = var_4_16 .. ClientData.getNameByInfoId(iter_4_7)

					if iter_4_6 ~= #var_4_15._forbidCardId then
						var_4_16 = var_4_16 .. Str(STR.DOT)
					end
				end
			end

			var_4_14 = ClientView.createBoldRichTextMultiLine(Str(STR.CAN_RUB_TIP) .. "\n" .. var_4_16, ClientView.RICHTEXT_PARAM_LIGHT_S1, 640)
			var_4_13 = var_4_13 + lc.h(var_4_14)
		end
	end

	if var_4_1 == Data.CardType.card_skill or var_4_1 == Data.CardType.item_skill then
		var_4_13 = var_4_13 + 50

		var_0_0.super.init(arg_4_0, cc.size(var_0_1, var_4_13), nil, bor(BaseForm.FLAG.PAPER_BG))

		local var_4_19 = arg_4_0._form

		lc.addChildToPos(var_4_19, var_4_7, cc.p(120, var_4_13 - lc.h(var_4_7) / 2 - var_4_7._marginTop))
		lc.addChildToPos(var_4_19, var_4_9, cc.p(lc.right(var_4_7) - 10 + lc.w(var_4_9) / 2, lc.top(var_4_7) - lc.h(var_4_9) / 2 - 10))
		lc.addChildToPos(var_4_19, var_4_12, cc.p(lc.right(var_4_7) + 20 + lc.w(var_4_12) / 2, lc.top(var_4_7) - var_4_10 - lc.h(var_4_12) / 2))

		if var_4_14 then
			lc.addChildToPos(var_4_19, var_4_14, cc.p(lc.left(var_4_7) + lc.cw(var_4_14), lc.bottom(var_4_12) - 10 - lc.ch(var_4_14)))
		end

		return
	end

	local var_4_20 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = var_0_2
	})

	var_4_20._marginTop = var_4_13 + 20

	local var_4_21 = lc.List.createV(cc.size(var_0_2.width - 40, var_0_2.height - 14))

	var_4_21:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_4_20, var_4_21, cc.p(lc.w(var_4_20) / 2, lc.h(var_4_20) / 2))

	local var_4_22 = ccui.Widget:create()
	local var_4_23 = cc.Label:createWithTTF(Str(STR.GET_PATH), ClientView.TTF_FONT, ClientView.FontSize.S1, cc.size(lc.w(var_4_21), 0), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

	var_4_23:setColor(ClientView.COLOR_TEXT_ORANGE)
	var_4_22:setContentSize(lc.w(var_4_21), lc.h(var_4_23))
	lc.addChildToCenter(var_4_22, var_4_23)
	var_4_21:pushBackCustomItem(var_4_22)

	local var_4_24 = string.splitByChar(Str(var_4_0._pathSid), "/")

	for iter_4_8, iter_4_9 in ipairs(var_4_24) do
		local var_4_25 = ccui.Widget:create()
		local var_4_26 = ClientView.createBoldRichText(iter_4_9, {
			_normalClr = ClientView.COLOR_TEXT_LIGHT,
			_boldClr = ClientView.COLOR_TEXT_ORANGE_LIGHT,
			_fontSize = ClientView.FontSize.S1
		}, lc.w(var_4_21))

		var_4_25:setContentSize(lc.w(var_4_21), lc.h(var_4_26))
		lc.addChildToCenter(var_4_25, var_4_26)
		var_4_21:pushBackCustomItem(var_4_25)
	end

	if arg_4_1._infoId == Data.PropsId.legend_chest then
		local var_4_27 = ccui.Widget:create()

		var_4_27:setContentSize(lc.w(var_4_21), lc.h(var_4_21) - 50)

		local var_4_28 = 0
		local var_4_29 = lc.h(var_4_27) - 40

		ClientView.addDecoratedLabel(var_4_27, Str(STR.LEGEND_BOX_monsters), cc.p(lc.w(var_4_27) / 2, var_4_29), 26)

		local var_4_30 = var_4_29 - 50

		arg_4_0._legendHeroIcons = {}

		for iter_4_10, iter_4_11 in ipairs(Data._globalInfo._legendHero) do
			local var_4_31 = IconWidget.create({
				_infoId = iter_4_11
			})

			arg_4_0._legendHeroIcons[iter_4_11] = var_4_31

			local var_4_32, var_4_33 = P._playerCard:getCards(Data.CardType.monster)

			for iter_4_12, iter_4_13 in pairs(var_4_32) do
				if iter_4_13._infoId == iter_4_11 then
					var_4_33 = true

					break
				end
			end

			var_4_31:setGray(not var_4_33)
			lc.addChildToPos(var_4_27, var_4_31, cc.p(var_4_28 + IconWidget.SIZE / 2 + 46, var_4_30 - IconWidget.SIZE / 2))

			if iter_4_10 % 4 == 0 then
				var_4_28, var_4_30 = 0, var_4_30 - IconWidget.SIZE - 40
			else
				var_4_28 = var_4_28 + IconWidget.SIZE + 20
			end
		end

		var_4_21:pushBackCustomItem(var_4_27)

		var_4_13 = var_4_13 + 30
	end

	local var_4_34 = var_4_13 + 20 + lc.h(var_4_20) + 30 + var_0_0.FRAME_THICK_BOTTOM

	if var_4_3 and var_4_1 == Data.CardType.props then
		if var_4_0._type == Data.PropsType.box then
			var_4_34 = var_4_34 + 20 + lc.frameSize("img_btn_1").height
		elseif var_4_0._id == Data.PropsId.vip_card then
			var_4_34 = var_4_34 + 60 + lc.frameSize("img_btn_1").height
		end
	end

	var_0_0.super.init(arg_4_0, cc.size(var_0_1, var_4_34), nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_4_35 = arg_4_0._form

	lc.addChildToPos(var_4_35, var_4_7, cc.p(120, var_4_34 - lc.h(var_4_7) / 2 - var_4_7._marginTop))
	lc.addChildToPos(var_4_35, var_4_9, cc.p(lc.right(var_4_7) - 10 + lc.w(var_4_9) / 2, lc.top(var_4_7) - lc.h(var_4_9) / 2 - 10))
	lc.addChildToPos(var_4_35, var_4_12, cc.p(lc.right(var_4_7) + 20 + lc.w(var_4_12) / 2, lc.top(var_4_7) - var_4_10 - lc.h(var_4_12) / 2))
	lc.addChildToPos(var_4_35, var_4_20, cc.p(lc.w(var_4_35) / 2, var_4_34 - var_4_20._marginTop - lc.h(var_4_20) / 2))

	if var_4_3 then
		if var_4_1 == Data.CardType.props then
			local var_4_36

			if var_4_0._id == Data.PropsId.vip_card then
				var_4_36 = arg_4_0.useVipCard

				arg_4_0:updateVipProgress()
			elseif var_4_0._type == Data.PropsType.box then
				var_4_36 = arg_4_0.openBox
			end

			if var_4_36 then
				local var_4_37 = ClientView.createScale9ShaderButton("img_btn_1", function()
					var_4_36(arg_4_0, arg_4_1, 1)
				end, ClientView.CRECT_BUTTON, 150)

				var_4_37:addLabel(string.format(Str(STR.USE_TIMES), 1))
				lc.addChildToPos(var_4_35, var_4_37, cc.p(lc.w(var_4_35) / 2 - 100, var_0_0.FRAME_THICK_BOTTOM + 30 + lc.h(var_4_37) / 2))

				local var_4_38 = math.min(arg_4_1._infoId == Data.PropsId.legend_chest and 5 or 10, arg_4_1._count)

				if arg_4_1._count > 300 then
					var_4_38 = 50
				end

				if arg_4_1._infoId == Data.PropsId.exp_bottle or arg_4_1._infoId == Data.PropsId.exp_bottle_s then
					local var_4_39 = arg_4_1._infoId == Data.PropsId.exp_bottle and 2000 or 500
					local var_4_40 = P:getLevel()
					local var_4_41 = P:getMaxLevel(P:getCharacterId())
					local var_4_42 = P._characters[P:getCharacterId()]._exp
					local var_4_43 = Data._globalInfo._playerLevelupExp[var_4_41] - Data._globalInfo._playerLevelupExp[var_4_40] - var_4_42

					var_4_38 = math.min(var_4_38, math.ceil(var_4_43 / var_4_39))
				end

				local var_4_44 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_6_0)
					var_4_36(arg_4_0, arg_4_1, arg_6_0._times)
				end, ClientView.CRECT_BUTTON, 150)

				var_4_44:addLabel(string.format(Str(STR.USE_TIMES), var_4_38))
				lc.addChildToPos(var_4_35, var_4_44, cc.p(lc.w(var_4_35) / 2 + 100, lc.y(var_4_37)))

				arg_4_0._btnUseMulti = var_4_44
				var_4_44._times = var_4_38
				arg_4_0._btnUseMulti = var_4_44

				if arg_4_1._infoId == Data.PropsId.legend_chest then
					arg_4_0:updateLegendBoxOpenTimes()
				end
			end
		end
	elseif Data.isCardBack(arg_4_1._infoId) or Data.isAvatarFrame(arg_4_1._infoId) then
		local var_4_45 = var_4_5 > 0 and Str(STR.UNLOCKED) or Str(STR.LOCK)
		local var_4_46 = ClientView.createTTF(var_4_45, ClientView.FontSize.S1, var_4_5 > 0 and ClientView.COLOR_LABEL_LIGHT or ClientView.COLOR_TEXT_RED_DARK)

		lc.addChildToPos(var_4_35, var_4_46, cc.p(lc.w(var_4_35) - lc.w(var_4_46) / 2 - 80, lc.y(var_4_9)))
	elseif var_4_5 ~= nil and var_4_5 >= 0 then
		local var_4_47

		if Data.isUnionRes(arg_4_1._infoId) then
			local var_4_48 = P._playerUnion:getMyUnion()

			if arg_4_1._infoId == Data.ResType.union_act then
				local var_4_49, var_4_50 = P._playerUnion:getUnionUpgradeExp()
				local var_4_51 = ""

				if var_4_49 then
					var_4_51 = Str(STR.UNION_LEVEL_MAX)
				else
					var_4_51 = string.format("(%s: %s)", Str(STR.UNION_EXP_MAX), var_4_50)
				end

				var_4_47 = ClientView.createTTF(var_4_51, ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)
			else
				var_4_47 = ClientView.createTTF(string.format("(%s: %s)", Str(STR.MAX), P._playerUnion:getMaxResource(arg_4_1._infoId)), ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)
			end
		elseif var_4_4 then
			var_4_47 = ClientView.createTTF(string.format("(%s: %s)", Str(STR.CURRENT_OWN), ClientData.formatNum(var_4_5, 9999)), ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)
		end

		if var_4_47 then
			lc.addChildToPos(var_4_35, var_4_47, cc.p(lc.w(var_4_35) - lc.w(var_4_47) / 2 - 60, lc.y(var_4_9)))
		end
	end

	if GuideManager.getCurStepName() == "leave claim" then
		GuideManager.pauseGuide()
	end
end

function var_0_0.hide(arg_7_0)
	var_0_0.super.hide(arg_7_0)

	if GuideManager.getCurStepName() == "leave claim" then
		GuideManager.resumeGuide()
	end
end

function var_0_0.updateLegendBoxOpenTimes(arg_8_0)
	if arg_8_0._legendBoxOpenTip then
		arg_8_0._legendBoxOpenTip:removeFromParent()
	end

	local var_8_0 = Data._globalInfo._vipLegendChest[P._vip + 1] - P._legendBoxOpenRemainTimes
	local var_8_1 = (P._legendBoxOpenTimes == 0 or var_8_0 <= 1) and Str(STR.LEGEND_BOX_OPEN_TIP_NOW) or string.format(Str(STR.LEGEND_BOX_OPEN_TIP), var_8_0)
	local var_8_2 = ClientView.createBoldRichText(var_8_1, ClientView.RICHTEXT_PARAM_DARK_S1)

	lc.addChildToPos(arg_8_0._form, var_8_2, cc.p(lc.w(arg_8_0._form) / 2, lc.top(arg_8_0._btnUseMulti) + 10 + lc.h(var_8_2) / 2))

	arg_8_0._legendBoxOpenTip = var_8_2
end

function var_0_0.openBox(arg_9_0, arg_9_1, arg_9_2)
	if Data.getInfo(arg_9_1._infoId)._type ~= Data.PropsType.box then
		return
	end

	if (arg_9_1._infoId == 7116 or arg_9_1._infoId == 7117) and P:getLevel() >= P:getMaxLevel(P:getCharacterId()) then
		return ToastManager.push(string.format(Str(STR.REACH_MAX_LEVEL), Str(STR.CURRENT) .. Str(STR.CHARACTER)))
	end

	if arg_9_2 == 0 then
		arg_9_2 = 1
	end

	if P._propBag:useProp(arg_9_1, arg_9_2) == Data.ErrorType.ok then
		ClientView.getActiveIndicator():show(Str(STR.OPENING), nil, {
			_prop = arg_9_1,
			_useCount = arg_9_2
		})
		ClientData.sendOpenBox(arg_9_1._infoId, arg_9_2)
	else
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(STR.PROPS_TYPE_BOX)))
	end
end

function var_0_0.useVipCard(arg_10_0, arg_10_1, arg_10_2)
	if Data.getInfo(arg_10_1._infoId)._id ~= Data.PropsId.vip_card then
		return
	end

	if arg_10_2 == 0 then
		arg_10_2 = 1
	end

	if P._propBag:useProp(arg_10_1, arg_10_2) == Data.ErrorType.ok then
		ClientData.sendUseVipCard(arg_10_2)

		local var_10_0 = P._vip
		local var_10_1 = arg_10_2 * Data._globalInfo._vipCardFactor

		P:changeVIPExp(var_10_1)
		ToastManager.push(string.format(Str(STR.GET_VIP_EXP), var_10_1))
		arg_10_0:updateVipProgress(true)
		arg_10_0:onPropUsed(arg_10_1, arg_10_2)

		if var_10_0 < P._vip then
			require("LevelUpPanel").createVip(var_10_0, P._vip):show()
		end
	else
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), Str(STR.SID_PROPS_NAME_7098)))
	end
end

function var_0_0.updateVipProgress(arg_11_0, arg_11_1)
	return
end

function var_0_0.onEnter(arg_12_0)
	var_0_0.super.onEnter(arg_12_0)

	arg_12_0._listeners = {}

	if arg_12_0._legendHeroIcons then
		table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.card_add, function(arg_13_0)
			local var_13_0 = arg_12_0._legendHeroIcons[arg_13_0._infoId]

			if var_13_0 then
				var_13_0:setGray(false)
			end
		end))
	end

	ClientData.addMsgListener(arg_12_0, function(arg_14_0)
		return arg_12_0:onMsg(arg_14_0)
	end, 0)
end

function var_0_0.onExit(arg_15_0)
	var_0_0.super.onExit(arg_15_0)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_15_1)
	end

	ClientData.removeMsgListener(arg_15_0)
	GuideManager.resumeGuide()
end

function var_0_0.onPropUsed(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1._count = P:getItemCount(arg_16_1._infoId)

	arg_16_0._icon:resetData(arg_16_1)

	if arg_16_0._btnUseMulti and arg_16_1._count < arg_16_0._btnUseMulti._times then
		arg_16_0._btnUseMulti._label:setString(string.format(Str(STR.USE_TIMES), arg_16_1._count))

		arg_16_0._btnUseMulti._times = arg_16_1._count
	end

	if arg_16_0._btnUseMulti and arg_16_1._count > 300 then
		arg_16_0._btnUseMulti._label:setString(string.format(Str(STR.USE_TIMES), 50))

		arg_16_0._btnUseMulti._times = 50
	end

	if arg_16_1._count == 0 then
		if arg_16_1._infoId == Data.PropsId.vip_card then
			arg_16_0:runAction(lc.sequence(1.5, function()
				arg_16_0:hide()
			end))
		else
			arg_16_0:hide()
		end
	end

	if arg_16_1._infoId == Data.PropsId.legend_chest then
		P._legendBoxOpenTimes = P._legendBoxOpenTimes + arg_16_2
		P._legendBoxOpenRemainTimes = P._legendBoxOpenRemainTimes + arg_16_2

		if P._legendBoxOpenRemainTimes >= Data._globalInfo._vipLegendChest[P._vip + 1] then
			P._legendBoxOpenRemainTimes = 0
		end

		arg_16_0:updateLegendBoxOpenTimes()
	end

	local var_16_0 = cc.EventCustom:new(Data.Event.use_prop)

	var_16_0._prop = arg_16_1
	var_16_0._useCount = arg_16_2

	lc.Dispatcher:dispatchEvent(var_16_0)
end

function var_0_0.onMsg(arg_18_0, arg_18_1)
	if arg_18_1.type == SglMsgType_pb.PB_TYPE_USER_OPEN_CHEST then
		local var_18_0 = arg_18_1.Extensions[User_pb.SglUserMsg.user_open_chest_resp]
		local var_18_1 = ClientView.getActiveIndicator():hide()
		local var_18_2 = require("RewardPanel")

		var_18_2.create(var_18_0, var_18_2.MODE_CHEST):show()
		arg_18_0:onPropUsed(var_18_1._prop, var_18_1._useCount)

		return true
	end

	return false
end

return var_0_0
