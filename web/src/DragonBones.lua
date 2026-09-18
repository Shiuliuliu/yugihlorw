local var_0_0 = class("DragonBones", function(arg_1_0)
	return cc.DragonBonesNode:createWithDecrypt(string.format("res/effects/%s.lcres", arg_1_0), arg_1_0, arg_1_0)
end)

DragonBones = var_0_0

function var_0_0.create(arg_2_0)
	print("Create DragonBones: ", arg_2_0)

	if arg_2_0 == "malikepifu2" then
		local var_2_0
	end

	local var_2_1 = var_0_0.new(arg_2_0)

	var_2_1:init(arg_2_0)
	var_2_1:registerScriptHandler(function(arg_3_0)
		if arg_3_0 == "cleanup" then
			var_2_1:onCleanup()
		end
	end)

	return var_2_1
end

function var_0_0.onCleanup(arg_4_0)
	if ClientData._dragonBonesTexture[arg_4_0._name] ~= nil then
		ClientData._dragonBonesTexture[arg_4_0._name] = ClientData._dragonBonesTexture[arg_4_0._name] - 1
	end

	if ClientData._dragonBonesTexture[arg_4_0._name] == 0 then
		local var_4_0 = arg_4_0._name .. ".png"

		if lc.TextureCache:getTextureForKey(var_4_0) ~= nil then
			cc.DragonBonesNode:removeTextureAtlas(arg_4_0._name)
			lc.TextureCache:removeTextureForKey(var_4_0)
		end
	end
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0._name = arg_5_1
	ClientData._dragonBonesTexture = ClientData._dragonBonesTexture or {}
	ClientData._dragonBonesTexture[arg_5_0._name] = (ClientData._dragonBonesTexture[arg_5_0._name] or 0) + 1
end

return var_0_0
