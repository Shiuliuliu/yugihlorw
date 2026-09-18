local var_0_0 = require("SidePanel")
local var_0_1 = class("ElitePanel", var_0_0)

function var_0_1.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.createSidePanel(var_0_1)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.init(arg_2_0)

	arg_2_0._info = arg_2_2

	arg_2_0._title:setString(arg_2_1)
	arg_2_0:initContentBg()

	local var_2_0 = lc.h(arg_2_0._contentBg) - 20

	arg_2_0._troopArea = arg_2_0:createTroopArea(Str(STR.DEF_TROOP))

	local var_2_1 = arg_2_0:addArea(arg_2_0._troopArea, var_2_0)

	arg_2_0:addDividingLine(var_2_1)

	local var_2_2 = var_2_1 - 16

	if arg_2_0._info._id then
		local var_2_3 = arg_2_0:addArea(arg_2_0:createDropArea(), var_2_2)
	end

	arg_2_0:createButtonArea()
	arg_2_0:addArea(arg_2_0:createButtonClipArea())
	arg_2_0:addDividingLine(lc.top(arg_2_0._buttonArea:getParent()) - 20)
	arg_2_0:updateTroop()

	if arg_2_0._info._id then
		arg_2_0:updateDrop()
		arg_2_0:updateSweepCardLabels()
	end
end

function var_0_1.createConditionArea(arg_3_0, arg_3_1)
	local var_3_0 = lc.w(arg_3_0._contentBg)
	local var_3_1 = 150
	local var_3_2 = lc.createNode(cc.size(var_3_0, var_3_1))
	local var_3_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.SWEEP_CONDITION))

	lc.addChildToPos(var_3_2, var_3_3, cc.p(var_0_0.CONTENT_MARGIN_LEFT + lc.w(var_3_3) / 2, var_3_1 - lc.h(var_3_3) / 2))

	local function var_3_4(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = ClientView.createTTF(string.format(Str(STR.BRACKETS_D), arg_4_0), ClientView.FontSize.S1, ClientView.COLOR_LABEL_LIGHT)

		var_4_0:setScale(0.85)
		lc.addChildToPos(var_3_2, var_4_0, cc.p(var_0_0.CONTENT_MARGIN_LEFT - 4 + lc.sw(var_4_0) / 2, arg_4_2 - lc.h(var_4_0) / 2))

		local var_4_1 = ClientView.createTTF(arg_4_1, ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)

		var_4_1:setScale(0.85)
		lc.addChildToPos(var_3_2, var_4_1, cc.p(lc.right(var_4_0) + 4 + lc.sw(var_4_1) / 2, lc.y(var_4_0)))

		return arg_4_2 - lc.h(var_4_0) - 6, var_4_1
	end

	local var_3_5 = lc.bottom(var_3_3) - 6
	local var_3_6
	local var_3_7 = var_3_4(1, string.format(Str(STR.SWEEP_COND_SCORE), arg_3_0._info._sweepScore), var_3_5)

	return var_3_2
end

function var_0_1.createButtonClipArea(arg_5_0)
	local var_5_0 = lc.w(arg_5_0._buttonArea)
	local var_5_1 = lc.h(arg_5_0._buttonArea)
	local var_5_2 = ccui.Layout:create()

	var_5_2:setContentSize(var_5_0, var_5_1)
	var_5_2:setAnchorPoint(0.5, 0.5)
	var_5_2:setPosition(arg_5_0._buttonArea:getPosition())
	var_5_2:setClippingEnabled(true)
	arg_5_0._buttonArea:setContentSize(var_5_0 * 2, var_5_1)
	arg_5_0._buttonArea:setPosition(var_5_0, var_5_1 / 2)
	var_5_2:addChild(arg_5_0._buttonArea)
	arg_5_0:createButtons()

	if arg_5_0._info._id and P._copyScore[arg_5_0._info._id] >= arg_5_0._info._sweepScore then
		arg_5_0:createArrows()
	end

	return var_5_2
end

function var_0_1.createButtons(arg_6_0)
	local var_6_0 = lc.w(arg_6_0._buttonArea) / 2
	local var_6_1 = 120
	local var_6_2 = ClientView.CRECT_BUTTON.height
	local var_6_3 = cc.rect(0, 0, var_6_1, var_6_2 + 40)
	local var_6_4 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_7_0)
		arg_6_0:onSelectTroop()
	end, ClientView.CRECT_BUTTON, var_6_1)

	var_6_4:addLabel("")
	var_6_4:setTouchRect(var_6_3)
	lc.addChildToPos(arg_6_0._buttonArea, var_6_4, cc.p(var_6_0 / 2 - 10 - lc.w(var_6_4) / 2, var_6_2 / 2))

	arg_6_0._btnTroop = var_6_4

	local var_6_5 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_8_0)
		arg_6_0:onAttack()
	end, ClientView.CRECT_BUTTON, var_6_1)

	var_6_5:addLabel(Str(STR.CAPTURE))
	lc.addChildToPos(arg_6_0._buttonArea, var_6_5, cc.p(var_6_0 / 2 + 10 + lc.cw(var_6_5), var_6_2 / 2))

	arg_6_0._btnAttack = var_6_5
end

function var_0_1.createArrows(arg_9_0)
	local var_9_0 = lc.w(arg_9_0._buttonArea) / 2
	local var_9_1 = cc.size(60, lc.h(arg_9_0._buttonArea))
	local var_9_2 = ClientView.createArrowButton(false, var_9_1, function(arg_10_0)
		arg_9_0:onArrow(arg_10_0)
	end)

	lc.addChildToPos(arg_9_0._buttonArea, var_9_2, cc.p(var_9_0 - lc.w(var_9_2) / 2 + 8, lc.h(arg_9_0._buttonArea) / 2))
	var_9_2._arrow:setScale(0.8)

	local var_9_3 = ClientView.createArrowButton(true, var_9_1, function(arg_11_0)
		arg_9_0:onArrow(arg_11_0)
	end)

	lc.addChildToPos(arg_9_0._buttonArea, var_9_3, cc.p(var_9_0 + lc.w(var_9_3) / 2 - 8, lc.h(arg_9_0._buttonArea) / 2))
	var_9_3._arrow:setScale(0.8)

	arg_9_0._btnArrowLeft = var_9_3
	arg_9_0._btnArrowRight = var_9_2

	arg_9_0:onArrow(arg_9_0._btnArrowRight)
	arg_9_0._btnArrowRight:setVisible(true)
end

function var_0_1.updateTroop(arg_12_0)
	local var_12_0 = {}

	if arg_12_0._info._troopId then
		local var_12_1 = Data._troopInfo[arg_12_0._info._troopId]

		for iter_12_0 = 1, #var_12_1._infoId do
			table.insert(var_12_0, {
				_infoId = var_12_1._infoId[iter_12_0],
				_num = var_12_1._num[iter_12_0],
				_level = var_12_1._level[iter_12_0]
			})
		end
	elseif arg_12_0._info._expeditionTroopId then
		local var_12_2 = P._playerExpedition._troopInfos[arg_12_0._info._expeditionTroopId]

		if var_12_2 ~= nil then
			for iter_12_1 = 1, #var_12_2 do
				table.insert(var_12_0, {
					_infoId = var_12_2[iter_12_1]._infoId,
					_num = var_12_2[iter_12_1]._num,
					_level = var_12_2[iter_12_1]._level
				})
			end
		end
	end

	ClientData.sortTroopCards(var_12_0)
	arg_12_0:updateTroopArea(arg_12_0._troopArea, var_12_0)
end

function var_0_1.updateDrop(arg_13_0)
	arg_13_0:updateDropArea(arg_13_0._info._picId)
end

function var_0_1.onEnter(arg_14_0)
	arg_14_0._btnTroop._label:setString(string.format("%s %d", Str(STR.TROOP), P._curTroopIndex))
end

function var_0_1.onExit(arg_15_0)
	return
end

function var_0_1.onSelectTroop(arg_16_0)
	lc.pushScene(require("HeroCenterScene").create())
end

function var_0_1.onArrow(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1 == arg_17_0._btnArrowLeft

	arg_17_0._buttonArea:stopAllActions()

	if var_17_0 then
		arg_17_0._buttonArea:runAction(lc.moveTo(0.3, cc.p(lc.w(arg_17_0._buttonArea) / 2, lc.y(arg_17_0._buttonArea))))
	else
		arg_17_0._buttonArea:runAction(lc.moveTo(0.3, cc.p(0, lc.y(arg_17_0._buttonArea))))
	end
end

function var_0_1.onAttack(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._info._type or Data.CopyType.expedition

	if arg_18_0._info._unlock then
		if P._level < arg_18_0._info._unlock then
			ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), arg_18_0._info._unlock))

			return
		end
	elseif arg_18_0._info._expeditionTroopId then
		local var_18_1 = arg_18_0._info._expeditionTroopId

		if var_18_1 <= P._playerExpedition._chapter then
			if P._playerExpedition._chests[var_18_1] ~= nil then
				if P._playerExpedition._chests[var_18_1]._opened then
					ToastManager.push(Str(STR.CITY_CAPTURED))
				else
					ToastManager.push(Str(STR.CITY_CAPTURED) .. "," .. Str(STR.CLAIM_SOON))
				end
			end

			return
		elseif var_18_1 == P._playerExpedition._chapter + 1 then
			for iter_18_0 = 1, var_18_1 - 1 do
				if P._playerExpedition._chests[iter_18_0] ~= nil and not P._playerExpedition._chests[iter_18_0]._opened then
					ToastManager.push(Str(STR.CLAIM_THEN_EXPEDITION))

					return
				end
			end
		else
			ToastManager.push(string.format(Str(STR.COPY_NEED_PASS_LEVEL), P._playerExpedition._chapter + 1))

			return
		end
	end

	if var_18_0 ~= Data.CopyType.expedition and P:getChallengeCopyRemainTimes(var_18_0) == 0 then
		if P:getBuyCopyRemainTimes(var_18_0) == 0 then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH_BUY_TIMES), Str(STR.BUY) .. Str(STR.ATTACK_TIMES)))

			return
		end

		local var_18_2 = P:getBuyCopyIngot(var_18_0)

		require("Dialog").showDialog(string.format(Str(STR.SURE_TO_BUY_CHALLENGE), var_18_2, 1), function()
			if not ClientView.checkIngot(var_18_2) then
				return
			end

			P:changeResource(Data.ResType.ingot, -var_18_2)
			P:addBuyCopyTimes(var_18_0)
			arg_18_0:onAttack(arg_18_1, arg_18_2)
		end)

		return
	end

	if arg_18_0._info._type then
		local var_18_3, var_18_4 = Data.getCopyStartId(var_18_0)

		for iter_18_1 = var_18_3, arg_18_0._info._id - 1 do
			if P._copyPassTimes[iter_18_1] == 0 then
				var_18_4 = Data._copyInfo[iter_18_1]._level

				break
			end
		end

		if var_18_4 then
			ToastManager.push(string.format(Str(STR.COPY_NEED_PASS_LEVEL), var_18_4))

			return
		end
	end

	local var_18_5, var_18_6 = P._playerCard:checkTroop(P._curTroopIndex)

	if not var_18_5 then
		ToastManager.push(var_18_6)

		return
	end

	if not P:checkBattleCost() then
		ToastManager.push(Str(STR.NOT_ENOUGH_GRAIN))
		require("ExchangeResForm").create(Data.ResType.grain):show()

		return
	end

	local var_18_7, var_18_8 = math.floor(var_18_0 / 10)

	if arg_18_1 then
		if not ClientView.useSweepCard(1, arg_18_2, function()
			arg_18_0:onAttack(true)
		end) then
			return
		end

		ClientView.getActiveIndicator():show(Str(STR.WAITING), nil, arg_18_0._info)
		ClientData.sendCopySweep(arg_18_0._info._id, 1, var_18_7 == Data.CopyType.group_boss and ClientData._copyGoldPropId or 0)
	else
		ClientData._battleFromCopy = arg_18_0._info

		if var_18_7 == Data.CopyType.group_elite then
			var_18_8 = ClientData.sendChallengeElite
		elseif var_18_7 == Data.CopyType.group_boss then
			ClientView.getActiveIndicator():show(Str(STR.WAITING))
			ClientData.sendChallengeGold(P._curTroopIndex, arg_18_0._info._id, ClientData._copyGoldPropId or 0)
		elseif var_18_7 == Data.CopyType.group_commander then
			var_18_8 = ClientData.sendChallengeCommander
		elseif var_18_7 == Data.CopyType.group_expedition then
			var_18_8 = ClientData.sendWorldExpedition
		end

		if var_18_8 then
			ClientView.getActiveIndicator():show(Str(STR.WAITING))
			var_18_8(P._curTroopIndex, arg_18_0._info._id)
		end
	end
end

return var_0_1
