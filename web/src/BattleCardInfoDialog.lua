local var_0_0 = class("BattleCardInfoDialog", lc.ExtendUIWidget)

BattleCardInfoDialog = var_0_0

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._battleUi = arg_2_1

	local var_2_0 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH + 20)
	local var_2_1 = CardSprite.create(arg_2_2, arg_2_0._battleUi._playerUi)

	var_2_1._pCardArea:setScale(CardSprite.Scale.hd)
	var_2_1:setPosition(var_2_0.x - 310, var_2_0.y + 120)
	arg_2_0:addChild(var_2_1)
	var_2_1:showCardInfo(false)

	if arg_2_2._type == Data.CardType.monster then
		var_2_1._pAtkSpr:setString(ClientData.formatNum(arg_2_2._maxAtk, 99999))
		var_2_1._pHpSpr:setString(ClientData.formatNum(arg_2_2._maxHp, 99999))
	end

	var_2_1:setCameraMask(ClientData.CAMERA_2D_FLAG)
end

function var_0_0.hide(arg_3_0)
	arg_3_0:removeFromParent()
end

return var_0_0
