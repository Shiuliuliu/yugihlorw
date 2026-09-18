lc = lc or {}

local var_0_0 = {
	State = {
		paused = 3,
		unloaded = 0,
		idle = 1,
		playing = 2
	},
	Behavior = {
		effect = 1,
		music = 0
	},
	SwitchType = {
		yes_once = 1,
		yes_replay = 0,
		no = 2
	},
	PlayCondition = {
		ignore = 2,
		play = 0,
		stop = 1
	}
}

var_0_0.EVENT_STOPPED = "LC_AUDIO_STOPPED"

local var_0_1 = {}
local var_0_2 = 0
local var_0_3 = cc.SimpleAudioEngine:getInstance()
local var_0_4 = lc.Scheduler

local function var_0_5(arg_1_0)
	if arg_1_0.playingParams.isNotifyStop then
		local var_1_0 = cc.EventCustom:new(var_0_0.EVENT_STOPPED)

		var_1_0.audioInfo = arg_1_0

		lc.Dispatcher:dispatchEvent(var_1_0)
	end

	arg_1_0.state = var_0_0.State.idle
	var_0_1[arg_1_0.id] = nil
end

function var_0_0.loadAudioConfig(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or "main"

	if not var_0_0._configs then
		var_0_0._configs = {}
		var_0_0._configs.count = 1
	else
		var_0_0._configs.count = var_0_0._configs.count + 1
	end

	var_0_0._configs[arg_2_1] = {}

	local var_2_0 = cc.FileUtils:getInstance():getDataFromFile(arg_2_0)
	local var_2_1 = cc.FileUtils:getInstance():getValueMapFromData(var_2_0, #var_2_0).audios

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_2 = iter_2_1.name

		if not var_2_2:find("%.") then
			var_2_2 = var_2_2 .. ".mp3"
		end

		var_0_0.addAudio(var_2_2, iter_2_1.behavior, iter_2_1.duration, iter_2_1.group, iter_2_1.loop, iter_2_1.condition, iter_2_1.switch)
	end
end

function var_0_0.addAudio(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	arg_3_7 = arg_3_7 or "main"
	var_0_0._configs[arg_3_7] = var_0_0._configs[arg_3_7] or {}

	local var_3_0 = var_0_0._configs[arg_3_7]
	local var_3_1 = {
		id = table.getn(var_3_0) + 1,
		name = arg_3_0,
		cfgName = arg_3_7,
		behavior = arg_3_1 or var_0_0.Behavior.music,
		duration = arg_3_2 or -1,
		group = arg_3_3 or -1,
		isLoop = arg_3_4 == true or arg_3_4 == 1,
		playCondition = arg_3_5 or var_0_0.PlayCondition.play,
		switch = arg_3_6 or var_0_0.SwitchType.yes_once,
		state = var_0_0.State.unloaded,
		playingParams = {},
		scheduleForStop = function(arg_4_0, arg_4_1)
			local var_4_0 = arg_4_0.playingParams

			if var_4_0.scheduleId then
				var_0_4:unscheduleScriptEntry(var_4_0.scheduleId)
			end

			var_4_0.scheduleId = var_0_4:scheduleScriptFunc(function()
				var_0_4:unscheduleScriptEntry(var_4_0.scheduleId)

				var_4_0.scheduleId = nil

				var_0_5(arg_4_0)
			end, arg_4_1 or arg_4_0.duration, false)
		end
	}

	table.insert(var_3_0, var_3_1)

	return var_3_1
end

function var_0_0.preloadAudio(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or "main"

	assert(var_0_0._configs[arg_6_1], string.format("[lc.Audio.preloadAudio] The info table '%s' is not exist!", arg_6_1))

	local var_6_0 = var_0_0._configs[arg_6_1][arg_6_0]

	assert(var_6_0, string.format("[lc.Audio.preloadAudio] The audio id '%d' in table '%s' is not exist!", arg_6_0, arg_6_1))

	if var_6_0.state ~= var_0_0.State.unloaded then
		return
	end

	if var_6_0.behavior == var_0_0.Behavior.music then
		var_0_3:preloadMusic(var_6_0.name)
	else
		var_0_3:preloadEffect(var_6_0.name)
	end

	var_6_0.state = var_0_0.State.idle
end

function var_0_0.unloadAudio(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or "main"

	assert(var_0_0._configs[arg_7_1], string.format("[lc.Audio.unloadAudio] The info table '%s' is not exist!", arg_7_1))

	local var_7_0 = var_0_0._configs[arg_7_1][arg_7_0]

	assert(var_7_0, string.format("[lc.Audio.unloadAudio] The audio id '%d' in table '%s' is not exist!", arg_7_0, arg_7_1))

	if var_7_0.state == var_0_0.State.unloaded then
		return
	end

	if var_7_0.state == var_0_0.State.playing then
		var_0_0.stopAudio(arg_7_0, arg_7_1)
	end

	if var_7_0.behavior == var_0_0.Behavior.music then
		var_0_3:stopMusic(true)
	else
		var_0_3:unloadEffect(var_7_0.name)
	end

	var_7_0.state = var_0_0.State.unloaded
end

function var_0_0.playAudio(arg_8_0, arg_8_1, arg_8_2)
	if ClientData.isAppStoreReviewing() then
		return
	end
	if arg_8_0 == nil then
		return
	end

	arg_8_2 = arg_8_2 or "main"

	assert(var_0_0._configs[arg_8_2], string.format("[lc.Audio.playAudio] The info table '%s' is not exist!", arg_8_2))

	local var_8_0 = var_0_0._configs[arg_8_2][arg_8_0]

	assert(var_8_0, string.format("[lc.Audio.playAudio] The audio id '%d' in table '%s' is not exist!", arg_8_0, arg_8_2))

	arg_8_1 = arg_8_1 or false

	if var_8_0.state == var_0_0.State.playing then
		local var_8_1 = var_8_0.playCondition

		if var_8_1 == var_0_0.PlayCondition.stop then
			var_0_0.stopAudio(arg_8_0, arg_8_2)
		elseif var_8_1 == var_0_0.PlayCondition.ignore then
			return
		end
	end

	if var_8_0.group >= 0 then
		local var_8_2 = {}

		for iter_8_0, iter_8_1 in pairs(var_0_1) do
			if iter_8_1.group == var_8_0.group then
				table.insert(var_8_2, iter_8_1)
			end
		end

		for iter_8_2, iter_8_3 in ipairs(var_8_2) do
			var_0_0.stopAudio(iter_8_3.id, iter_8_3.cfgName)
		end
	end

	if bit.band(var_0_2, bit.lshift(1, var_8_0.behavior)) ~= 0 and var_8_0.switch == var_0_0.SwitchType.yes_once then
		return
	end

	if var_8_0.behavior == var_0_0.Behavior.music then
		var_0_3:playMusic(var_8_0.name, var_8_0.isLoop)

		var_8_0.playingParams.id = 0
	else
		var_8_0.playingParams.id = var_0_3:playEffect(var_8_0.name, var_8_0.isLoop)
	end

	var_8_0.playingParams.playTime = os.time()
	var_8_0.playingParams.duration = 0
	var_0_1[var_8_0.id] = var_8_0
	var_8_0.state = var_0_0.State.playing

	if bit.band(var_0_2, bit.lshift(1, var_8_0.behavior)) ~= 0 and var_8_0.switch == var_0_0.SwitchType.yes_replay then
		var_0_0.pauseAudio(var_8_0.id, var_8_0.cfgName)
	end

	if not var_8_0.isLoop then
		var_8_0.playingParams.isNotifyStop = arg_8_1

		var_8_0:scheduleForStop()
	end
end

function var_0_0.pauseAudio(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or "main"

	assert(var_0_0._configs[arg_9_1], string.format("[lc.Audio.pauseAudio] The info table '%s' is not exist!", arg_9_1))

	local var_9_0 = var_0_0._configs[arg_9_1][arg_9_0]

	assert(var_9_0, string.format("[lc.Audio.pauseAudio] The audio id '%d' in table '%s' is not exist!", arg_9_0, arg_9_1))

	if var_9_0.state ~= var_0_0.State.playing then
		return
	end

	if var_9_0.behavior == var_0_0.Behavior.music then
		var_0_3:pauseMusic()
	else
		var_0_3:pauseEffect(var_9_0.playingId)
	end

	var_9_0.state = var_0_0.State.paused

	local var_9_1 = var_9_0.playingParams

	if var_9_1.scheduleId then
		var_0_4:unscheduleScriptEntry(var_9_1.scheduleId)

		var_9_1.scheduleId = nil
		var_9_1.duration = os.time() - var_9_1.playTime
	end
end

function var_0_0.resumeAudio(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or "main"

	assert(var_0_0._configs[arg_10_1], string.format("[lc.Audio.resumeAudio] The info table '%s' is not exist!", arg_10_1))

	local var_10_0 = var_0_0._configs[arg_10_1][arg_10_0]

	assert(var_10_0, string.format("[lc.Audio.resumeAudio] The audio id '%d' in table '%s' is not exist!", arg_10_0, arg_10_1))

	if var_10_0.state ~= var_0_0.State.paused then
		return
	end

	if var_10_0.behavior == var_0_0.Behavior.music then
		var_0_3:resumeMusic()
	else
		var_0_3:resumeEffect(var_10_0.playingId)
	end

	var_10_0.state = var_0_0.State.playing

	if not var_10_0.isLoop then
		var_10_0:scheduleForStop(var_10_0.duration - var_10_0.playingParams.duration)
	end
end

function var_0_0.stopAudio(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or "main"

	assert(var_0_0._configs[arg_11_1], string.format("[lc.Audio.stopAudio] The info table '%s' is not exist!", arg_11_1))

	local var_11_0 = var_0_0._configs[arg_11_1][arg_11_0]

	assert(var_11_0, string.format("[lc.Audio.stopAudio] The audio id '%d' in table '%s' is not exist!", arg_11_0, arg_11_1))

	if var_11_0.state == var_0_0.State.idle or var_11_0.state == var_0_0.State.unloaded then
		return
	end

	if var_11_0.behavior == var_0_0.Behavior.music then
		var_0_3:stopMusic(false)
	else
		var_0_3:stopEffect(var_11_0.playingParams.id)
	end

	var_0_5(var_11_0)
end

function var_0_0.stopAllAudio(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(var_0_1) do
		if (not arg_12_0 or iter_12_1.behavior == arg_12_0) and (not arg_12_1 or iter_12_1.cfgName == arg_12_1) then
			table.insert(var_12_0, iter_12_1)
		end
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_0) do
		var_0_0.stopAudio(iter_12_3.id, iter_12_3.cfgName)
	end
end

function var_0_0.setAudioVolume(arg_13_0, arg_13_1)
	if not arg_13_1 or arg_13_1 == var_0_0.Behavior.effect then
		var_0_3:setEffectsVolume(arg_13_0)
	end

	if not arg_13_1 or arg_13_1 == var_0_0.Behavior.music then
		var_0_3:setMusicVolume(arg_13_0)
	end
end

function var_0_0.setIsMute(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 then
		var_0_2 = arg_14_0 and bit.bor(var_0_2, bit.lshift(1, arg_14_1)) or bit.band(var_0_2, bit.bnot(bit.lshift(1, arg_14_1)))
	else
		var_0_2 = arg_14_0 and 3 or 0
	end

	if arg_14_0 then
		local var_14_0 = {}

		for iter_14_0, iter_14_1 in pairs(var_0_1) do
			if (not arg_14_1 or iter_14_1.behavior == arg_14_1) and (not arg_14_2 or iter_14_1.cfgName == arg_14_2) then
				if iter_14_1.switch == var_0_0.SwitchType.yes_once then
					table.insert(var_14_0, iter_14_1)
				elseif iter_14_1.switch == var_0_0.SwitchType.yes_replay then
					var_0_0.pauseAudio(iter_14_1.id, iter_14_1.cfgName)
				end
			end
		end

		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			var_0_0.stopAudio(iter_14_3.id, iter_14_3.cfgName)
		end
	else
		for iter_14_4, iter_14_5 in pairs(var_0_1) do
			if (not arg_14_1 or iter_14_5.behavior == arg_14_1) and (not arg_14_2 or iter_14_5.cfgName == arg_14_2) and iter_14_5.switch == var_0_0.SwitchType.yes_replay then
				var_0_0.resumeAudio(iter_14_5.id, iter_14_5.cfgName)
			end
		end
	end
end

function var_0_0.unloadAllAudio(arg_15_0, arg_15_1)
	if not var_0_0._configs then
		return
	end

	for iter_15_0, iter_15_1 in pairs(var_0_0._configs) do
		if not arg_15_1 or iter_15_0 == arg_15_1 then
			for iter_15_2, iter_15_3 in ipairs(iter_15_1) do
				if not arg_15_0 or iter_15_3.behavior == arg_15_0 then
					unloadAudio(iter_15_3.id, arg_15_1)
				end
			end
		end
	end
end

function var_0_0.clear()
	var_0_0.unloadAllAudio()

	var_0_0._configs = nil
	playingAudioList = nil
end

lc.Audio = var_0_0

return var_0_0
