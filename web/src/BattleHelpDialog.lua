local var_0_0 = class("BattleHelpDialog", lc.ExtendUIWidget)

BattleHelpDialog = var_0_0

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)
	var_1_0:addTouchEventListener(function(arg_2_0, arg_2_1)
		if arg_2_1 == ccui.TouchEventType.ended then
			var_1_0:hide()
		end
	end)
	var_1_0:registerScriptHandler(function(arg_3_0)
		if arg_3_0 == "cleanup" then
			ClientData.unloadLCRes({
				"bat_help.jpm",
				"bat_help.png.sfb"
			})
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0._battleUi = arg_4_1

	ClientData.loadLCRes("res/bat_help.lcres")
	arg_4_0:setOpacity(ClientView.MASK_OPACITY_LIGHT)

	if arg_4_0._battleUi._btnSpeed and arg_4_0._battleUi._btnSpeed:isVisible() then
		local var_4_0, var_4_1 = arg_4_0._battleUi._btnSpeed:getPosition()

		arg_4_0:addChild(lc.createSprite("bat_help_speed", cc.p(var_4_0 + 108, var_4_1 + 20)))
	end

	if arg_4_0._battleUi._btnAuto and arg_4_0._battleUi._btnAuto:isVisible() then
		local var_4_2, var_4_3 = arg_4_0._battleUi._btnAuto:getPosition()

		arg_4_0:addChild(lc.createSprite("bat_help_auto", cc.p(var_4_2 + 134, var_4_3 + 16)))
	end

	if arg_4_0._battleUi._btnSkip and arg_4_0._battleUi._btnSkip:isVisible() then
		local var_4_4, var_4_5 = arg_4_0._battleUi._btnSkip:getPosition()

		arg_4_0:addChild(lc.createSprite("bat_help_skip", cc.p(var_4_4 + 110, var_4_5)))
	end

	if arg_4_0._battleUi._atkPile then
		local var_4_6, var_4_7 = arg_4_0._battleUi._atkPile:getParent():getPosition()

		arg_4_0:addChild(lc.createSprite("bat_help_pile", cc.p(var_4_6 - 134, var_4_7 + 10)))
	end

	local var_4_8 = (ClientView.SCR_W - 1024) / 2
	local var_4_9 = cc.p(arg_4_0._battleUi._btnEndRound:getPosition())

	arg_4_0:addChild(lc.createSprite("bat_help_start", cc.p(var_4_9.x + var_4_8 - 142, var_4_9.y)))

	local var_4_10 = PlayerUi.Pos.attacker_gems[2]

	arg_4_0:addChild(lc.createSprite("bat_help_gem", cc.p(var_4_10.x + var_4_8 - 190, var_4_10.y)))

	local var_4_11 = PlayerUi.Pos.attacker_grave

	arg_4_0:addChild(lc.createSprite("bat_help_grave", cc.p(var_4_11.x + var_4_8 + 120, var_4_11.y)))

	local var_4_12 = PlayerUi.Pos.attacker_fortress

	arg_4_0:addChild(lc.createSprite("bat_help_fortress", cc.p(var_4_12.x + var_4_8 + 66, var_4_12.y + 64)))

	local var_4_13 = ClientView.createTTF(Str(STR.CONTINUE))

	var_4_13:setPosition(ClientView.SCR_CW, ClientView.SCR_H - 40)
	var_4_13:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeIn:create(0.5), cc.DelayTime:create(0.5), cc.FadeOut:create(0.5))))
	arg_4_0:addChild(var_4_13)
end

function var_0_0.hide(arg_5_0)
	arg_5_0:removeFromParent()
end

return var_0_0
