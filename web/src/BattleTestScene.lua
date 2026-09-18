local var_0_0 = class("BattleTestScene", require("BaseScene"))

BattleTestScene = var_0_0

require("BattleTestUi", true)
require("BattleTestUiTouch", true)
require("BattleTestListDialog", true)
require("BattleTestExtend", true)

function var_0_0.create(arg_1_0)
	return lc.createScene(var_0_0, arg_1_0)
end

function var_0_0.init(arg_2_0)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.battle_test) then
		return false
	end

	ClientData._battleScene = arg_2_0
	arg_2_0._isGuideOnEnter = false
	arg_2_0._battleUiNormal = BattleTestUi.create(arg_2_0, "normal")

	arg_2_0:addChild(arg_2_0._battleUiNormal)

	arg_2_0._battleUi = arg_2_0._battleUiNormal

	arg_2_0:setKeyboardEnabled(true)
	arg_2_0:registerScriptKeypadHandler(function(arg_3_0)
		local var_3_0 = cc.EventCustom:new(Data.Event.unitest)

		var_3_0._key = arg_3_0

		lc.Dispatcher:dispatchEvent(var_3_0)
	end)

	return true
end

function var_0_0.onEnter(arg_4_0)
	var_0_0.super.onEnter(arg_4_0)
end

function var_0_0.onExit(arg_5_0)
	var_0_0.super.onExit(arg_5_0)
end

return var_0_0
