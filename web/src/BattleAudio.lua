local var_0_0 = class("BattleAudio")

BattleAudio = var_0_0

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._battleUi = arg_1_1
end

function var_0_0.playHeroAudio(arg_2_0, arg_2_1, arg_2_2)
	-- All hero Japanese voice lines (v_on_*) do not exist in web client; return early to prevent 404 network stalls
	return
end

function var_0_0.playSkillAudio(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = Data._skillAudioInfo[arg_3_1]

	if var_3_0 ~= nil and P._guideID >= 100 then
		if var_3_0._effect1 ~= "NULL" then
			arg_3_0:playEffect(var_3_0._effect1)
		end

		if var_3_0._effect2 ~= "NULL" then
			arg_3_3 = arg_3_3 or 0.01

			arg_3_0._battleUi:runAction(cc.Sequence:create(cc.DelayTime:create(arg_3_3), cc.CallFunc:create(function()
				arg_3_0:playEffect(var_3_0._effect2)
			end)))
		end

		local var_3_1 = arg_3_2._owner._avatar % 100 ~= 0 and var_3_0._voice1 or var_3_0._voice2

		arg_3_0:playEffect(var_3_1)
	end
end

local AUDIO_EFFECT_LIST = nil

function var_0_0.playEffect(arg_5_0, arg_5_1)
	if arg_5_1 == nil or arg_5_1 == "NULL" then
		return
	end

	-- Skip missing voice files (v_*) to prevent network 404 stalls
	if string.sub(arg_5_1, 1, 2) == "v_" then
		return
	end

	if AUDIO_EFFECT_LIST == nil then
		AUDIO_EFFECT_LIST = {}
		local listStr = lc.readFile and lc.readFile("res/bat_audio/list.txt")
		if listStr then
			for line in string.gmatch(listStr, "[^\r\n]+") do
				AUDIO_EFFECT_LIST[line] = true
			end
		end
	end

	-- Only play if the audio file exists on disk
	if AUDIO_EFFECT_LIST and not AUDIO_EFFECT_LIST[arg_5_1] then
		return
	end

	if ClientData._isEffectOn then
		cc.SimpleAudioEngine:getInstance():playEffect("res/bat_audio/" .. arg_5_1 .. ".mp3")
	end
end

return var_0_0
