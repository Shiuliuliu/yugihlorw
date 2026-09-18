local var_0_0 = class("GuideCitySprite", lc.ExtendUIWidget)
local var_0_1 = {
	{
		x = 347,
		y = 255
	},
	{
		x = 1014,
		y = 326
	},
	{
		x = 461,
		y = 558
	},
	{
		x = 877,
		y = 668
	}
}

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_WIDGET)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._index = arg_2_1

	if arg_2_1 < 4 then
		local var_2_0 = lc.createSprite(string.format("bat_guide_city_%02d", arg_2_1))

		arg_2_0:setContentSize(var_2_0:getContentSize())
		lc.addChildToCenter(arg_2_0, var_2_0)
	else
		arg_2_0:setContentSize(140, 140)
	end

	ClientView.addFixityName(arg_2_0, Str(STR.GUIDE_CITY_NAME_1 + arg_2_1 - 1), ClientView.COLOR_BMFONT)
	arg_2_0._name:setVisible(false)
	arg_2_0._name._bg:setVisible(false)
	arg_2_0:setPosition(var_0_1[arg_2_1])
	arg_2_0:registerScriptHandler(function(arg_3_0)
		if arg_3_0 == "enter" then
			arg_2_0:onEnter()
		elseif arg_3_0 == "exit" then
			arg_2_0:onExit()
		end
	end)
	arg_2_0:setTouchEnabled(true)
	arg_2_0:addEffects()
end

function var_0_0.onEnter(arg_4_0)
	arg_4_0:updateCity()
end

function var_0_0.onExit(arg_5_0)
	return
end

function var_0_0.updateCity(arg_6_0)
	local var_6_0 = math.floor(ClientData._player._guideID / 10) / 2 + 1 >= arg_6_0._index

	arg_6_0._name:setVisible(var_6_0)
	arg_6_0._name._bg:setVisible(var_6_0)
end

function var_0_0.addEffects(arg_7_0)
	if arg_7_0._index == 1 then
		local var_7_0 = Particle.create("par_huoshan")

		var_7_0:setPositionType(cc.POSITION_TYPE_GROUPED)
		lc.addChildToPos(arg_7_0, var_7_0, cc.p(lc.w(arg_7_0) / 2 - 24, lc.h(arg_7_0) / 2 - 40), -1)
	elseif arg_7_0._index == 2 then
		local var_7_1 = Particle.create("par_pubu_01")

		var_7_1:setPositionType(cc.POSITION_TYPE_GROUPED)
		lc.addChildToPos(arg_7_0, var_7_1, cc.p(lc.w(arg_7_0) / 2 - 42, lc.h(arg_7_0) / 2 + 10))

		local var_7_2 = Particle.create("par_pubu_02")

		var_7_2:setPositionType(cc.POSITION_TYPE_GROUPED)
		lc.addChildToPos(arg_7_0, var_7_2, cc.p(lc.w(arg_7_0) / 2 - 60, lc.h(arg_7_0) / 2 - 70))
	elseif arg_7_0._index == 4 then
		local var_7_3 = Particle.create("par_shandong_01")

		var_7_3:setPositionType(cc.POSITION_TYPE_GROUPED)
		lc.addChildToPos(arg_7_0, var_7_3, cc.p(lc.w(arg_7_0) / 2 - 8, lc.h(arg_7_0) / 2 - 8))

		local var_7_4 = Particle.create("par_shandong_02")

		var_7_4:setPositionType(cc.POSITION_TYPE_GROUPED)
		lc.addChildToPos(arg_7_0, var_7_4, cc.p(var_7_3:getPosition()))
	end
end

return var_0_0
