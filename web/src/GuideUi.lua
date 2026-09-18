local var_0_0 = class("GuideUi", lc.ExtendUIWidget)

GuideUi = var_0_0

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_WIDGET)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._callback = arg_2_2

	arg_2_0:setContentSize(arg_2_1:getContentSize())
	arg_2_0:setTouchEnabled(true)

	local var_2_0 = lc.createSprite("res/bat_scene/bat_scene_guide.jpg")

	lc.addChildToCenter(arg_2_0, var_2_0)

	local var_2_1 = DragonBones.create("hmssn")

	var_2_1:setScale(1.3)
	var_2_1:gotoAndPlay("effect")
	lc.addChildToPos(arg_2_0, var_2_1, cc.p(lc.w(arg_2_0) / 2 - 150, 280))

	local var_2_2 = lc.createMaskLayer(160, lc.Color3B.black, cc.size(ClientView.SCR_W, 110))

	var_2_2:setTouchEnabled(false)
	arg_2_0:addChild(var_2_2)

	local var_2_3 = ClientView.createTTF("", ClientView.FontSize.M2)

	var_2_3:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_2_2, var_2_3, cc.p(20, 80))

	arg_2_0._title = var_2_3

	local var_2_4 = ClientView.createTTF("", ClientView.FontSize.M2)

	var_2_4:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_2_2, var_2_4, cc.p(20, 40))

	arg_2_0._label = var_2_4

	arg_2_0:updateText()
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 == ccui.TouchEventType.ended then
			arg_2_0:nextStep()
		end
	end)

	return true
end

function var_0_0.onEnter(arg_4_0)
	lc.Audio.playAudio(AUDIO.M_GUIDE)
end

function var_0_0.nextStep(arg_5_0)
	local var_5_0 = Data._guideInfo[P._guideID]

	if var_5_0._saveStep ~= 0 then
		P._guideID = var_5_0._saveStep

		arg_5_0._callback()
		arg_5_0:removeFromParent()
	else
		P._guideID = P._guideID + 1

		arg_5_0:updateText()
	end
end

function var_0_0.updateText(arg_6_0)
	local var_6_0 = Data._guideInfo[P._guideID]

	arg_6_0._title:setString("[" .. (var_6_0._param == 0 and Str(STR.PLAYER) or Str(STR.NPC_NAME)) .. "]")
	arg_6_0._label:setString(Str(var_6_0._nameSid))
end

return var_0_0
