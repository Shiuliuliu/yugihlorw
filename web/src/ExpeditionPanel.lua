local var_0_0 = require("SidePanel")
local var_0_1 = class("ExpeditionPanel", var_0_0)

function var_0_1.create(arg_1_0)
	local var_1_0 = var_0_0.createSidePanel(var_0_1)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1)
	var_0_1.super.init(arg_2_0)

	arg_2_0._chapter = arg_2_1

	arg_2_0._title:setString(Str(STR.COPY_EXPEDITION) .. arg_2_1)
	arg_2_0:initContentBg()

	local var_2_0 = arg_2_0:addArea(arg_2_0:createPlayerArea(Str(STR.OPPONENT_LORD)), lc.h(arg_2_0._contentBg) - 26)

	arg_2_0._userArea:setUser(P._playerExpedition._players[arg_2_1], true)

	arg_2_0._troopArea = arg_2_0:createTroopArea(Str(STR.DEF_TROOP), 404)

	local var_2_1 = arg_2_0:addArea(arg_2_0._troopArea, var_2_0)

	arg_2_0:addArea(arg_2_0:createButtonArea())
	arg_2_0:createButtons()
	arg_2_0:addDividingLine(lc.top(arg_2_0._buttonArea) + 16)

	local var_2_2 = P._playerExpedition._troopInfos[arg_2_1]
	local var_2_3 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		table.insert(var_2_3, iter_2_1)
	end

	table.sort(var_2_3, function(arg_3_0, arg_3_1)
		if arg_3_0._type == Data.CardType.monster and arg_3_1._type ~= Data.CardType.monster then
			return true
		elseif arg_3_0._type ~= Data.CardType.monster and arg_3_1._type == Data.CardType.monster then
			return false
		else
			return arg_3_0:getFightingValue() > arg_3_1:getFightingValue()
		end
	end)

	local var_2_4 = {}

	for iter_2_2 = 1, #var_2_3 do
		table.insert(var_2_4, var_2_3[iter_2_2])
	end

	if arg_2_0._chapter <= P._playerExpedition._chapter then
		arg_2_0._buttonArea:setVisible(false)

		local var_2_5 = ClientView.createStatusLabel(Str(STR.CAPTURED), ClientView.COLOR_TEXT_GREEN)

		lc.addChildToPos(arg_2_0._contentBg, var_2_5, cc.p(lc.w(arg_2_0._contentBg) / 2, 100))
	end

	arg_2_0:updateTroopArea(arg_2_0._troopArea, var_2_4)
	arg_2_0:updateMyAttackValue()
end

function var_0_1.onEnter(arg_4_0)
	local var_4_0 = {}

	table.insert(var_4_0, lc.addEventListener(Data.Event.grain_dirty, function(arg_5_0)
		arg_4_0:updateCostLabel()
	end))

	arg_4_0._listeners = var_4_0

	arg_4_0:updateCostLabel()
	arg_4_0:updateMyAttackValue()
end

function var_0_1.onExit(arg_6_0)
	for iter_6_0 = 1, #arg_6_0._listeners do
		lc.Dispatcher:removeEventListener(arg_6_0._listeners[iter_6_0])
	end
end

function var_0_1.createButtons(arg_7_0)
	local var_7_0 = lc.w(arg_7_0._buttonArea) / 2
	local var_7_1 = 148
	local var_7_2 = ClientView.CRECT_BUTTON.height
	local var_7_3 = cc.rect(0, 0, var_7_1, var_7_2 + 40)
	local var_7_4 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_8_0)
		arg_7_0:onSelectTroop()
	end, ClientView.CRECT_BUTTON, var_7_1)

	var_7_4:addLabel(Str(STR.TROOP))
	var_7_4:setTouchRect(var_7_3)
	lc.addChildToPos(arg_7_0._buttonArea, var_7_4, cc.p(var_7_0 - 10 - lc.w(var_7_4) / 2, var_7_2 / 2))

	arg_7_0._btnTroop = var_7_4
	arg_7_0._labelAttack = ClientView.addIconValue(arg_7_0._buttonArea, "img_icon_power", "00000", lc.x(arg_7_0._btnTroop) - 48, lc.top(arg_7_0._btnTroop) + 24)

	arg_7_0._labelAttack:setColor(ClientView.COLOR_TEXT_DARK)
	arg_7_0:updateMyAttackValue()

	local var_7_5 = ClientView.createResConsumeButtonArea(var_7_1, "img_icon_res2_s", ClientView.COLOR_RES_LABEL_BG_LIGHT, 0, Str(STR.CAPTURE))

	lc.addChildToPos(arg_7_0._buttonArea, var_7_5, cc.p(var_7_0 + 10 + lc.w(var_7_4) / 2, lc.h(var_7_5) / 2))
	var_7_5._btn:setTouchRect(var_7_3)

	function var_7_5._btn._callback()
		arg_7_0:onAttack()
	end

	arg_7_0._btnAttack = var_7_5._btn
	arg_7_0._costLabel = var_7_5._resLabel
end

function var_0_1.updateCostLabel(arg_10_0)
	local var_10_0 = P:getBattleCost()

	arg_10_0._costLabel:setString(var_10_0)
	arg_10_0._costLabel:setColor(var_10_0 > P._grain and lc.Color3B.red or lc.Color3B.white)
end

function var_0_1.updateMyAttackValue(arg_11_0)
	arg_11_0._labelAttack:setString(string.format("%d", P._playerCard:getTroopFightingValue(Data.TroopIndex.expedition)))
end

function var_0_1.onSelectTroop(arg_12_0)
	lc.pushScene(require("HeroCenterScene").create(Data.TroopIndex.expedition))
end

function var_0_1.onAttack(arg_13_0)
	local var_13_0, var_13_1 = P._playerCard:checkTroop(Data.TroopIndex.expedition)

	if not var_13_0 then
		ToastManager.push(var_13_1)

		return
	end

	if not P:checkBattleCost() then
		ToastManager.push(Str(STR.NOT_ENOUGH_GRAIN))
		require("ExchangeResForm").create(Data.ResType.grain):show()

		return
	end

	arg_13_0:hide()

	ClientData._battleFromCopy = {
		_type = Data.CopyType.expedition
	}

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendWorldExpedition()
end

return var_0_1
