local var_0_0 = {}
local var_0_1 = 2000

function var_0_0.init()
	var_0_0._textures = {}
	var_0_0._count = 0
	var_0_0._tick = 0
end

function var_0_0.clear()
	for iter_2_0, iter_2_1 in pairs(var_0_0._textures) do
		lc.App:unloadRes(iter_2_0)
	end

	var_0_0.init()
end

function var_0_0.loadTexture(arg_3_0, arg_3_1)
	if var_0_0._textures == nil then var_0_0.init() end
	if not var_0_0._textures[arg_3_0] then
		if var_0_0._count == var_0_1 then
			var_0_0.unloadOldestTexture()
		end

		lc.App:loadRes(arg_3_1)

		var_0_0._count = var_0_0._count + 1
	end

	var_0_0._textures[arg_3_0] = var_0_0._tick
	var_0_0._tick = var_0_0._tick + 1
end

function var_0_0.unloadOldestTexture()
	local var_4_0 = 4294967295
	local var_4_1

	for iter_4_0, iter_4_1 in pairs(var_0_0._textures) do
		if iter_4_1 < var_4_0 then
			var_4_0 = iter_4_1
			var_4_1 = iter_4_0
		end
	end

	if var_4_1 ~= nil then
		lc.App:unloadRes(var_4_1)

		var_0_0._textures[var_4_1] = nil
		var_0_0._count = var_0_0._count - 1
	end
end

function var_0_0.preloadTextures(arg_5_0)
	for iter_5_0 = 1, #arg_5_0 do
		var_0_0.loadTexture(arg_5_0[iter_5_0])
	end
end

TextureManager = var_0_0

return var_0_0
