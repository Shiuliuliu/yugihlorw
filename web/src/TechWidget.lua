local var_0_0 = class("TechWidget", ClientView.createShaderButton)

var_0_0.ITEM_SIZE = cc.size(180, 226)
var_0_0.ICON_SIZE = cc.size(102, 110)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:setContentSize(var_0_0.ITEM_SIZE)
	var_1_0:init()
	var_1_0:updateTech(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.createIcon(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.new()

	var_2_0:setContentSize(var_0_0.ICON_SIZE)
	var_2_0:initIcon(var_0_0.ICON_SIZE.height - 50, 0.75)
	var_2_0:updateTech(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.onEnter(arg_3_0)
	if not arg_3_0._ignoreEvent then
		arg_3_0._listeners = {}

		table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.union_tech_dirty, function(arg_4_0)
			local var_4_0 = arg_4_0._param

			if var_4_0 == arg_3_0._tech then
				arg_3_0:updateTech(var_4_0)
			end
		end))
		table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.union_tech_upgrade, function(arg_5_0)
			if arg_5_0._param == arg_3_0._tech then
				arg_3_0:showUpgradeEffect()
			end
		end))
	end
end

function var_0_0.onExit(arg_6_0)
	if not arg_6_0._ignoreEvent then
		for iter_6_0 = 1, #arg_6_0._listeners do
			lc.Dispatcher:removeEventListener(arg_6_0._listeners[iter_6_0])
		end
	end
end

function var_0_0.init(arg_7_0)
	local var_7_0 = lc.w(arg_7_0) / 2
	local var_7_1 = cc.ShaderSprite:createWithFramename("img_tech_bg")

	lc.addChildToCenter(arg_7_0, var_7_1)

	arg_7_0._itemBg = var_7_1

	arg_7_0:initIcon(lc.h(arg_7_0) - 92)

	local var_7_2 = cc.ShaderSprite:createWithFramename("img_title_bg_2")

	lc.addChildToPos(arg_7_0, var_7_2, cc.p(var_7_0, 40))

	arg_7_0._nameBg = var_7_2

	local var_7_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, "")

	lc.addChildToCenter(var_7_2, var_7_3)

	arg_7_0._name = var_7_3
	arg_7_0._lockScale = 0.8
end

function var_0_0.initIcon(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = lc.w(arg_8_0) / 2
	local var_8_1 = cc.ShaderSprite:createWithFramename("img_tech_frame")

	lc.addChildToPos(arg_8_0, var_8_1, cc.p(var_8_0, arg_8_1))

	arg_8_0._iconBg = var_8_1

	local var_8_2 = cc.ShaderSprite:createWithFramename("img_blank")

	lc.addChildToPos(var_8_1, var_8_2, cc.p(lc.w(var_8_1) / 2, lc.h(var_8_1) / 2 + 4))

	arg_8_0._icon = var_8_2

	if arg_8_2 then
		var_8_1:setScale(arg_8_2)
	end

	local var_8_3 = lc.createSprite("img_tech_level_bg")

	lc.addChildToPos(arg_8_0, var_8_3, cc.p(var_8_0, lc.bottom(var_8_1) + 14), 1)

	arg_8_0._levelBg = var_8_3

	local var_8_4 = ClientView.createBMFont(ClientView.BMFont.number_legend, "")

	lc.addChildToPos(var_8_3, var_8_4, cc.p(lc.w(var_8_3) / 2, lc.h(var_8_3) / 2 + 2))

	arg_8_0._level = var_8_4
	arg_8_0._lockScale = 0.5

	arg_8_0:registerScriptHandler(function(arg_9_0)
		if arg_9_0 == "enter" then
			arg_8_0:onEnter()
		elseif arg_9_0 == "exit" then
			arg_8_0:onExit()
		end
	end)
end

function var_0_0.updateTech(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._tech = arg_10_1

	arg_10_0._icon:setSpriteFrame(string.format("img_tech_icon_%03d", arg_10_1._infoId))
	arg_10_0:showLock(arg_10_2)

	if arg_10_0._name then
		arg_10_0._name:setString(Str(arg_10_1._info._nameSid))
	end
end

function var_0_0.showUpgradeEffect(arg_11_0)
	local var_11_0 = lc._runningScene._scene
	local var_11_1 = lc.convertPos(cc.p(lc.w(arg_11_0) / 2, lc.h(arg_11_0) / 2), arg_11_0, var_11_0)

	if arg_11_0._name then
		local var_11_2 = Particle.create("tech-upgrade-1")

		lc.addChildToPos(var_11_0, var_11_2, cc.p(var_11_1.x, var_11_1.y - 100), ClientData.ZOrder.effect)

		local var_11_3 = Particle.create("tech-upgrade-2")

		lc.addChildToPos(var_11_0, var_11_3, var_11_1, ClientData.ZOrder.effect)
	else
		local var_11_4 = Particle.create("tech-upgrade-self")

		lc.addChildToPos(var_11_0, var_11_4, var_11_1, ClientData.ZOrder.effect)
	end

	lc.Audio.playAudio(AUDIO.E_CARD_UPGRADE)
end

function var_0_0.showLock(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._tech

	if arg_12_1 then
		arg_12_0._levelBg:setSpriteFrame("img_icon_lock")
		arg_12_0._levelBg:setScale(arg_12_0._lockScale)
		arg_12_0._level:setVisible(false)
	else
		arg_12_0._levelBg:setSpriteFrame("img_tech_level_bg")
		arg_12_0._levelBg:setScale(1)

		local var_12_1
		local var_12_2

		if var_12_0._isSelf then
			_, var_12_1 = P._playerUnion:getTech(var_12_0._infoId)
			var_12_2 = var_12_1 < var_12_0._level and ClientView.COLOR_TEXT_RED or lc.Color3B.white
		else
			var_12_1 = var_12_0._level
			var_12_2 = lc.Color3B.white
		end

		var_12_2 = var_12_1 == var_12_0._info._maxLevel and ClientView.COLOR_TEXT_GREEN or var_12_2

		arg_12_0._level:setString(Str(STR.NUM_1 + var_12_1 - 1))
		arg_12_0._level:setColor(var_12_2)
		arg_12_0._level:setVisible(true)
		arg_12_0:setGray(false)
	end
end

function var_0_0.setGray(arg_13_0, arg_13_1)
	if arg_13_1 then
		if arg_13_0._itemBg then
			arg_13_0._itemBg:setEffect(ClientView.SHADER_DISABLE)
			arg_13_0._nameBg:setEffect(ClientView.SHADER_DISABLE)
		end

		arg_13_0._iconBg:setEffect(ClientView.SHADER_DISABLE)
		arg_13_0._icon:setEffect(ClientView.SHADER_DISABLE)
	else
		if arg_13_0._itemBg then
			arg_13_0._itemBg:setEffect(nil)
			arg_13_0._nameBg:setEffect(nil)
		end

		arg_13_0._iconBg:setEffect(nil)
		arg_13_0._icon:setEffect(nil)
	end
end

return var_0_0
