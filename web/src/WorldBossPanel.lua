local var_0_0 = class("WorldBossPanel", require("SidePanel"))

function var_0_0.createSidePanel(arg_1_0)
	local var_1_0 = arg_1_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setContentSize(lc.Director:getVisibleSize())
	var_1_0:setTouchEnabled(true)
	var_1_0:setTouchSwallow(false)

	return var_1_0
end

function var_0_0.create(arg_2_0)
	local var_2_0 = var_0_0.createSidePanel(var_0_0)

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	var_0_0.super.init(arg_3_0)

	arg_3_0._city = arg_3_1

	arg_3_0._title:setString(Str(arg_3_1._info._nameSid))
	arg_3_0:initContentBg()

	local var_3_0 = arg_3_0._contentBg
	local var_3_1 = Data._troopInfo[Data._levelInfo[arg_3_1._chapterIds[1]]._opponentTroopID]
	local var_3_2

	for iter_3_0, iter_3_1 in ipairs(var_3_1._infoId) do
		if Data.getInfo(iter_3_1)._nature == Data.CardCountry.mo then
			require("Card").create(iter_3_1)._level = var_3_1._level[iter_3_0]

			break
		end
	end

	local var_3_3 = require("CardThumbnail").create(card)

	var_3_3:setTouchEnabled(true)
	var_3_3:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 == ccui.TouchEventType.ended then
			require("CardInfoPanel").create(var_3_3._card, false):show()
		end
	end)
	lc.addChildToPos(var_3_0, var_3_3, cc.p(lc.w(var_3_0) / 2, lc.h(var_3_0) - lc.h(var_3_3) / 2 - 24))

	local var_3_4 = ClientView.createTTF(Str(STR.TODAY_HIGHEST_SCORE), ClientView.FontSize.S1, ClientView.COLOR_LABEL_DARK)

	lc.addChildToPos(var_3_0, var_3_4, cc.p(lc.w(var_3_0) / 2, lc.bottom(var_3_3) - 40))

	local var_3_5 = ClientView.createResIconLabel(200, "img_icon_score")

	var_3_5._label:setString(P._worldBossScore)
	lc.addChildToPos(var_3_0, var_3_5, cc.p(lc.w(var_3_0) / 2, lc.bottom(var_3_4) - 24))

	local var_3_6 = ClientView.createScale9ShaderButton("img_btn_1", function()
		require("RankForm").create(Data.RankRange.lord, 4):show()
	end, ClientView.CRECT_BUTTON, 150)

	var_3_6:addLabel(Str(STR.RANK))
	lc.addChildToPos(var_3_0, var_3_6, cc.p(lc.w(var_3_0) / 2, lc.bottom(var_3_5) - 40))
	arg_3_0:addArea(arg_3_0:createButtonArea())
	arg_3_0:createButtons()

	local var_3_7 = ClientView.createKeyValueLabel(Str(STR.REMAIN_TIMES), "0 / 0", ClientView.FontSize.S2, false)
	local var_3_8 = lc.h(arg_3_0._buttonArea)

	var_3_7:addToParent(var_3_0, cc.p((lc.w(var_3_0) - var_3_7:getTotalWidth()) / 2, var_3_8 + var_0_0.CONTENT_MARGIN_BOTTOM + 6 + lc.h(var_3_7) / 2))

	arg_3_0._labelRemainCount = var_3_7._value

	arg_3_0:updateRemainTimes()
	arg_3_0:addDividingLine(lc.top(var_3_7) + 16)
end

function var_0_0.createButtons(arg_6_0)
	local var_6_0 = lc.w(arg_6_0._buttonArea) / 2
	local var_6_1 = 148
	local var_6_2 = ClientView.CRECT_BUTTON.height
	local var_6_3 = cc.rect(0, 0, var_6_1, var_6_2 + 40)
	local var_6_4 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_7_0)
		arg_6_0:onSelectTroop()
	end, ClientView.CRECT_BUTTON, var_6_1)

	var_6_4:addLabel("")
	var_6_4:setTouchRect(var_6_3)
	lc.addChildToPos(arg_6_0._buttonArea, var_6_4, cc.p(var_6_0 - 10 - lc.w(var_6_4) / 2, var_6_2 / 2))

	arg_6_0._btnTroop = var_6_4
	arg_6_0._labelAttack = ClientView.addIconValue(arg_6_0._buttonArea, "img_icon_power", "00000", lc.x(arg_6_0._btnTroop) - 48, lc.top(arg_6_0._btnTroop) + 24)

	arg_6_0._labelAttack:setColor(ClientView.COLOR_TEXT_DARK)
	arg_6_0:updateMyAttackValue()

	local var_6_5 = ClientView.createResConsumeButtonArea(var_6_1, "img_icon_res2_s", ClientView.COLOR_RES_LABEL_BG_LIGHT, string.format("%d", P:getBattleCost()), Str(STR.CHALLENGE))

	lc.addChildToPos(arg_6_0._buttonArea, var_6_5, cc.p(var_6_0 + 10 + lc.w(var_6_4) / 2, lc.h(var_6_5) / 2))
	var_6_5._btn:setTouchRect(var_6_3)

	function var_6_5._btn._callback()
		arg_6_0:onAttack()
	end

	arg_6_0._btnAttack = var_6_5._btn
end

function var_0_0.updateMyAttackValue(arg_9_0)
	arg_9_0._labelAttack:setString(string.format("%d", P._playerCard:getTroopFightingValue(P._curTroopIndex)))
end

function var_0_0.updateRemainTimes(arg_10_0)
	local var_10_0 = Data._globalInfo._dailyAtkBossCount + P._dailyBuyWorldBoss

	arg_10_0._labelRemainCount:setString(string.format("%d / %d", var_10_0 - P._dailyWorldBoss, var_10_0))
end

function var_0_0.onEnter(arg_11_0)
	if arg_11_0._btnTroop then
		arg_11_0._btnTroop._label:setString(string.format("%s %d", Str(STR.TROOP), P._curTroopIndex))
	end

	arg_11_0:updateMyAttackValue()
end

function var_0_0.onSelectTroop(arg_12_0)
	lc.pushScene(require("HeroCenterScene").create(P._curTroopIndex))
end

function var_0_0.onAttack(arg_13_0)
	if not P:checkBattleCost() then
		ToastManager.push(Str(STR.NOT_ENOUGH_GRAIN))
		require("ExchangeResForm").create(Data.ResType.grain):show()

		return
	end

	local var_13_0 = Data._globalInfo._buyAtkBossIngot

	if P._dailyWorldBoss >= Data._globalInfo._dailyAtkBossCount + P._dailyBuyWorldBoss then
		require("Dialog").showDialog(string.format(Str(STR.RAIDS_TIMES_NOT_ENOUGH), var_13_0, 1), function()
			if not ClientView.checkIngot(var_13_0) then
				return
			end

			P:changeResource(Data.ResType.ingot, -var_13_0)

			P._dailyBuyWorldBoss = P._dailyBuyWorldBoss + 1

			arg_13_0:onAttack()
		end)

		return
	end

	arg_13_0:hide()
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendWorldAttack(P._curTroopIndex, arg_13_0._city._infoId)
end

return var_0_0
