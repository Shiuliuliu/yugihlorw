local var_0_0 = {
	stopAllEffects = function()
		cc.SimpleAudioEngine:getInstance():stopAllEffects()
	end,
	getMusicVolume = function()
		return cc.SimpleAudioEngine:getInstance():getMusicVolume()
	end,
	isMusicPlaying = function()
		return cc.SimpleAudioEngine:getInstance():isMusicPlaying()
	end,
	getEffectsVolume = function()
		return cc.SimpleAudioEngine:getInstance():getEffectsVolume()
	end,
	setMusicVolume = function(arg_5_0)
		cc.SimpleAudioEngine:getInstance():setMusicVolume(arg_5_0)
	end,
	stopEffect = function(arg_6_0)
		cc.SimpleAudioEngine:getInstance():stopEffect(arg_6_0)
	end,
	stopMusic = function(arg_7_0)
		local var_7_0 = false

		if arg_7_0 ~= nil then
			var_7_0 = arg_7_0
		end

		cc.SimpleAudioEngine:getInstance():stopMusic(var_7_0)
	end,
	playMusic = function(arg_8_0, arg_8_1)
		local var_8_0 = false

		if arg_8_1 ~= nil then
			var_8_0 = arg_8_1
		end

		cc.SimpleAudioEngine:getInstance():playMusic(arg_8_0, var_8_0)
	end,
	pauseAllEffects = function()
		cc.SimpleAudioEngine:getInstance():pauseAllEffects()
	end,
	preloadMusic = function(arg_10_0)
		cc.SimpleAudioEngine:getInstance():preloadMusic(arg_10_0)
	end,
	resumeMusic = function()
		cc.SimpleAudioEngine:getInstance():resumeMusic()
	end,
	playEffect = function(arg_12_0, arg_12_1)
		local var_12_0 = false

		if arg_12_1 ~= nil then
			var_12_0 = arg_12_1
		end

		return cc.SimpleAudioEngine:getInstance():playEffect(arg_12_0, var_12_0)
	end,
	rewindMusic = function()
		cc.SimpleAudioEngine:getInstance():rewindMusic()
	end,
	willPlayMusic = function()
		return cc.SimpleAudioEngine:getInstance():willPlayMusic()
	end,
	unloadEffect = function(arg_15_0)
		cc.SimpleAudioEngine:getInstance():unloadEffect(arg_15_0)
	end,
	preloadEffect = function(arg_16_0)
		cc.SimpleAudioEngine:getInstance():preloadEffect(arg_16_0)
	end,
	setEffectsVolume = function(arg_17_0)
		cc.SimpleAudioEngine:getInstance():setEffectsVolume(arg_17_0)
	end,
	pauseEffect = function(arg_18_0)
		cc.SimpleAudioEngine:getInstance():pauseEffect(arg_18_0)
	end,
	resumeAllEffects = function(arg_19_0)
		cc.SimpleAudioEngine:getInstance():resumeAllEffects()
	end,
	pauseMusic = function()
		cc.SimpleAudioEngine:getInstance():pauseMusic()
	end,
	resumeEffect = function(arg_21_0)
		cc.SimpleAudioEngine:getInstance():resumeEffect(arg_21_0)
	end,
	getInstance = function()
		return cc.SimpleAudioEngine:getInstance()
	end,
	destroyInstance = function()
		return cc.SimpleAudioEngine:destroyInstance()
	end
}
local var_0_1 = "AudioEngine"
local var_0_2 = {}
local var_0_3 = {
	__index = var_0_0,
	__newindex = function(arg_24_0, arg_24_1, arg_24_2)
		print("attemp to update a read-only table")
	end
}

setmetatable(var_0_2, var_0_3)

_G[var_0_1] = var_0_2
package.loaded[var_0_1] = var_0_2
