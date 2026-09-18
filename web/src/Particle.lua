local var_0_0 = class("Particle", function()
	return cc.ParticleSystemQuad:create()
end)

Particle = var_0_0

function var_0_0.create(arg_2_0)
	local var_2_0 = var_0_0.new()

	var_2_0:init(arg_2_0)
	var_2_0:registerScriptHandler(function(arg_3_0)
		if arg_3_0 == "cleanup" then
			var_2_0:onCleanup()
		end
	end)

	return var_2_0
end

function var_0_0.onCleanup(arg_4_0)
	if arg_4_0._data == nil then
		return
	end

	local var_4_0 = arg_4_0._data.textureFileName

	if ClientData._particleTexture[var_4_0] ~= nil then
		ClientData._particleTexture[var_4_0] = ClientData._particleTexture[var_4_0] - 1
	end

	if ClientData._particleTexture[var_4_0] == 0 then
		local var_4_1 = "res/particle/" .. arg_4_0._data.textureFileName .. ".png"

		if lc.TextureCache:getTextureForKey(var_4_1) ~= nil then
			lc.TextureCache:removeTextureForKey(var_4_1)
		end
	end
end

function var_0_0.init(arg_5_0, arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in pairs(Data._particleInfo) do
		if arg_5_1 == iter_5_1.name then
			var_5_0 = iter_5_1

			break
		end
	end

	if var_5_0 == nil then
		print("@@@@@@@ unable to find particle data", arg_5_1)
	else
		arg_5_0._data = var_5_0

		arg_5_0:initEmitter(var_5_0)

		ClientData._particleTexture = ClientData._particleTexture or {}

		local var_5_1 = var_5_0.textureFileName

		ClientData._particleTexture[var_5_1] = (ClientData._particleTexture[var_5_1] or 0) + 1
	end
end

function var_0_0.initEmitter(arg_6_0, arg_6_1)
	arg_6_0:setTotalParticles(arg_6_1.maxParticles)

	if arg_6_1.duration > 0 then
		arg_6_0:setAutoRemoveOnFinish(true)
	else
		arg_6_0:setAutoRemoveOnFinish(false)
	end

	arg_6_0:setAngle(arg_6_1.angle)
	arg_6_0:setAngleVar(arg_6_1.angleVariance)
	arg_6_0:setDuration(arg_6_1.duration)

	local var_6_0 = "res/particle/" .. arg_6_1.textureFileName .. ".png"
	local var_6_1 = lc.TextureCache:getTextureForKey(var_6_0) or lc.TextureCache:addImage(var_6_0)

	arg_6_0:setTexture(var_6_1)
	arg_6_0:setBlendFunc(arg_6_1.blendFuncSource, arg_6_1.blendFuncDestination)
	arg_6_0:setStartColor(cc.c4f(arg_6_1.startColorRed, arg_6_1.startColorGreen, arg_6_1.startColorBlue, arg_6_1.startColorAlpha))
	arg_6_0:setStartColorVar(cc.c4f(arg_6_1.startColorVarianceRed, arg_6_1.startColorVarianceGreen, arg_6_1.startColorVarianceBlue, arg_6_1.startColorVarianceAlpha))
	arg_6_0:setEndColor(cc.c4f(arg_6_1.finishColorRed, arg_6_1.finishColorGreen, arg_6_1.finishColorBlue, arg_6_1.finishColorAlpha))
	arg_6_0:setEndColorVar(cc.c4f(arg_6_1.finishColorVarianceRed, arg_6_1.finishColorVarianceGreen, arg_6_1.finishColorVarianceBlue, arg_6_1.finishColorVarianceAlpha))
	arg_6_0:setStartSize(arg_6_1.startParticleSize)
	arg_6_0:setStartSizeVar(arg_6_1.startParticleSizeVariance)
	arg_6_0:setEndSize(arg_6_1.finishParticleSize)
	arg_6_0:setEndSizeVar(arg_6_1.finishParticleSizeVariance)
	arg_6_0:setPosition(cc.p(arg_6_1.sourcePositionx, arg_6_1.sourcePositiony))
	arg_6_0:setPosVar(cc.p(arg_6_1.sourcePositionVariancex, arg_6_1.sourcePositionVariancey))
	arg_6_0:setStartSpin(arg_6_1.rotationStart)
	arg_6_0:setStartSpinVar(arg_6_1.rotationStartVariance)
	arg_6_0:setEndSpin(arg_6_1.rotationEnd)
	arg_6_0:setEndSpinVar(arg_6_1.rotationEndVariance)
	arg_6_0:setEmitterMode(arg_6_1.emitterType)

	if arg_6_1.emitterType == 0 then
		arg_6_0:setGravity({
			x = arg_6_1.gravityx,
			y = arg_6_1.gravityy
		})
		arg_6_0:setSpeed(arg_6_1.speed)
		arg_6_0:setSpeedVar(arg_6_1.speedVariance)
		arg_6_0:setRadialAccel(arg_6_1.radialAcceleration)
		arg_6_0:setRadialAccelVar(arg_6_1.radialAccelVariance)
		arg_6_0:setTangentialAccel(arg_6_1.tangentialAcceleration)
		arg_6_0:setTangentialAccelVar(arg_6_1.tangentialAccelVariance)
		arg_6_0:setRotationIsDir(false)
	elseif arg_6_1.emitterType == 1 then
		arg_6_0:setStartRadius(arg_6_1.maxRadius)
		arg_6_0:setStartRadiusVar(arg_6_1.maxRadiusVariance)
		arg_6_0:setEndRadius(arg_6_1.minRadius)
		arg_6_0:setEndRadiusVar(arg_6_1.minRadiusVariance)
		arg_6_0:setRotatePerSecond(arg_6_1.rotatePerSecond)
		arg_6_0:setRotatePerSecondVar(arg_6_1.rotatePerSecondVariance)
	end

	arg_6_0:setLife(arg_6_1.particleLifespan)
	arg_6_0:setLifeVar(arg_6_1.particleLifespanVariance)
	arg_6_0:setEmissionRate(arg_6_1.maxParticles / (arg_6_1.particleLifespan <= 0 and 0.001 or arg_6_1.particleLifespan))
end

return var_0_0
