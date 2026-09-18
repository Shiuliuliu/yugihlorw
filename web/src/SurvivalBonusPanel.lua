local var_0_0 = class("SurvivalBonusPanel", require("BasePanel"))
local var_0_1 = {
	game_over = 2,
	explore = 1
}

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, true)

	arg_2_0._isEx = arg_2_1

	local var_2_0 = arg_2_0._isEx and P._playerFindSurvivalEx or P._playerFindSurvival
	local var_2_1 = var_2_0._rank
	local var_2_2 = var_2_0._rewards
	local var_2_3 = var_2_0._getSeconds
	local var_2_4 = var_2_0._captures
	local var_2_5

	if var_2_2 then
		if var_2_1 == 1 then
			var_2_5 = DragonBones.create("duelking")
		else
			var_2_5 = DragonBones.create("taotai")
		end
	else
		var_2_5 = DragonBones.create("zhanlipin")
	end

	if var_2_5 then
		lc.addChildToCenter(arg_2_0, var_2_5)
	end

	local var_2_6 = lc.createNode(arg_2_0:getContentSize())

	var_2_6:setVisible(false)
	lc.addChildToCenter(arg_2_0, var_2_6)

	local var_2_7 = ClientView.createTTF("", ClientView.FontSize.M2, ClientView.COLOR_TEXT_DARK)

	lc.addChildToPos(var_2_6, var_2_7, cc.p(lc.cw(var_2_6), 425))

	if var_2_2 and var_2_1 then
		if var_2_1 == 1 then
			var_2_7:setString(Str(STR.SURVIVE_SUCCESS))
		else
			var_2_7:setString(Str(STR.RANK) .. " : " .. var_2_1)

			if not var_2_2._isInHall then
				var_2_7:setVisible(false)
			end
		end
	elseif var_2_3 and var_2_3 ~= 0 then
		local var_2_8 = lc.createSprite("img_icon_survival_time")

		var_2_8:setScale(0.8)
		lc.addChildToPos(var_2_6, var_2_8, cc.p(lc.cw(var_2_6) - lc.cw(var_2_8) - 5, 410))

		local var_2_9 = ClientView.createTTF(var_2_3 > 0 and "+" .. math.floor(var_2_3) or math.floor(var_2_3), ClientView.FontSize.M2, var_2_3 > 0 and ClientView.COLOR_TEXT_DARK or ClientView.COLOR_TEXT_RED)

		var_2_9:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_2_6, var_2_9, cc.p(lc.cw(var_2_6) + 5, 410))
	end

	local var_2_10 = var_2_2 or {}

	if var_2_3 then
		local var_2_11 = 0

		for iter_2_0, iter_2_1 in ipairs(var_2_4) do
			var_2_11 = var_2_11 + iter_2_1._num
		end

		if var_2_11 > 0 and var_2_11 < 40 then
			var_2_10[#var_2_10 + 1] = {
				_count = 1,
				_infoId = Data.PropsId.small_card_package
			}
		elseif var_2_11 >= 40 then
			var_2_10[#var_2_10 + 1] = {
				_count = 1,
				_infoId = Data.PropsId.big_card_package
			}
		end
	end

	local var_2_12 = {}

	for iter_2_2, iter_2_3 in ipairs(var_2_10) do
		local var_2_13 = IconWidget.create(iter_2_3)

		var_2_12[#var_2_12 + 1] = var_2_13
	end

	lc.addNodesToCenter(var_2_6, var_2_12, 20, 320)

	for iter_2_4, iter_2_5 in ipairs(var_2_12) do
		iter_2_5:setVisible(false)
	end

	local var_2_14 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_3_0)
		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, 140)

	var_2_14:addLabel(Str(STR.OK))
	lc.addChildToPos(var_2_6, var_2_14, cc.p(lc.cw(var_2_6), lc.ch(var_2_6) - 300))

	local var_2_15 = var_2_5:getAnimationDuration("effect")

	var_2_5:gotoAndPlay("effect")
	var_2_5:runAction(lc.sequence(var_2_15, function()
		var_2_5:gotoAndPlay("effect2")
		var_2_6:setVisible(true)

		for iter_4_0, iter_4_1 in ipairs(var_2_12) do
			iter_4_1:setVisible(true)
			iter_4_1:runAction(lc.sequence((iter_4_0 - 1) * 0.2, lc.scaleTo(0.1, 1.2), lc.scaleTo(0.1, 1)))
		end
	end))
	lc.Audio.playAudio(AUDIO.E_CLAIM)
end

function var_0_0.onEnter(arg_5_0)
	var_0_0.super.onEnter(arg_5_0)
end

function var_0_0.onExit(arg_6_0)
	var_0_0.super.onExit(arg_6_0)
	lc.Dispatcher:removeEventListener(arg_6_0._listener)
end

function var_0_0.onCleanup(arg_7_0)
	var_0_0.super.onCleanup(arg_7_0)
end

function var_0_0.hide(arg_8_0)
	var_0_0.super.hide(arg_8_0)
end

return var_0_0
