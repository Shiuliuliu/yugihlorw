local var_0_0 = class("CardFactoryPanel", require("BasePanel"))

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, true)

	arg_2_0._panelName = "CardFactoryPanel"
	arg_2_0._params = {}

	for iter_2_0 = 1, 4 do
		arg_2_0:addButton(iter_2_0)
	end

	local var_2_0 = lc.createSprite("img_factory_light")

	var_2_0:setScale(8)
	lc.addChildToCenter(arg_2_0, var_2_0)
end

function var_0_0.addButton(arg_3_0, arg_3_1)
	local var_3_0 = {
		"monster",
		"magic",
		"trap",
		"merge"
	}
	local var_3_1 = {
		STR.MONSTER,
		STR.MAGIC,
		STR.TRAP,
		STR.RARE
	}
	local var_3_2 = arg_3_1 % 2 == 1
	local var_3_3 = arg_3_1 <= 2
	local var_3_4 = ClientView.createScale9ShaderButton("img_blank", function(arg_4_0)
		if arg_3_1 == 1 then
			lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.factory_monster))
		elseif arg_3_1 == 2 then
			lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.factory_magic))
		elseif arg_3_1 == 3 then
			lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.factory_trap))
		elseif arg_3_1 == 4 then
			lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.factory_rare))
		end
	end, cc.rect(0, 0, 2, 2), 369, 297)
	local var_3_5 = lc.w(var_3_4) / 2
	local var_3_6 = lc.h(var_3_4) / 2

	lc.addChildToPos(arg_3_0, var_3_4, cc.p(lc.w(arg_3_0) / 2 + (var_3_2 and -var_3_5 or var_3_5), lc.h(arg_3_0) / 2 + (var_3_3 and var_3_6 or -var_3_6)))

	local var_3_7 = lc.createSprite("img_factory_" .. var_3_0[arg_3_1])

	lc.addChildToCenter(var_3_4, var_3_7)

	local var_3_8 = lc.createSprite("img_factory_unfocus")

	var_3_8:setFlippedX(var_3_2)
	var_3_8:setFlippedY(not var_3_3)
	lc.addChildToCenter(var_3_4, var_3_8)

	local var_3_9 = lc.createSprite("img_factory_label_bg")

	lc.addChildToPos(var_3_4, var_3_9, cc.p(lc.w(var_3_4) / 2 + (var_3_2 and -76 or 76), 50))
	var_3_9:setFlippedX(var_3_2)
	var_3_9:setFlippedY(not var_3_3)

	local var_3_10 = ClientView.createBMFont(ClientView.BMFont.huali_26, lc.str(var_3_1[arg_3_1]))

	lc.addChildToCenter(var_3_9, var_3_10)
end

return var_0_0
