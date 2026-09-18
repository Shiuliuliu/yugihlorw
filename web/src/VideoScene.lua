local var_0_0 = class("VideoScene", require("BaseScene"))

function var_0_0.create()
	return lc.createScene(var_0_0)
end

function var_0_0.onEnter(arg_2_0)
	var_0_0.super.onEnter(arg_2_0)
	arg_2_0:runAction(lc.sequence(1, function()
		arg_2_0._handleComplete = true
	end))
	lc.UserDefault:setBoolForKey(ClientData.ConfigKey.video_played, true)
	arg_2_0:playVideo()
end

function var_0_0.onExit(arg_4_0)
	var_0_0.super.onExit(arg_4_0)
end

function var_0_0.onCleanup(arg_5_0)
	var_0_0.super.onCleanup(arg_5_0)
end

function var_0_0.init(arg_6_0)
	if not var_0_0.super.init(arg_6_0) then
		return false
	end

	arg_6_0._isGuideOnEnter = false

	return true
end

function var_0_0.playVideo(arg_7_0)
	if lc.PLATFORM == cc.PLATFORM_OS_ANDROID or lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD then
		local var_7_0 = ccexp.VideoPlayer:create()

		var_7_0:setPosition(cc.p(0, 0))
		var_7_0:setAnchorPoint(cc.p(0, 0))
		var_7_0:setContentSize(ClientView.SCR_SIZE)
		var_7_0:setFullScreenEnabled(true)
		var_7_0:setKeepAspectRatioEnabled(true)
		var_7_0:addEventListener(function(arg_8_0, arg_8_1)
			arg_7_0:onVideoEvent(arg_8_0, arg_8_1)
		end)
		arg_7_0:addChild(var_7_0)
		var_7_0:setFileName(lc.File:fullPathForFilename("res/video.mp4"))
		var_7_0:play()
	else
		arg_7_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			arg_7_0:switchScene()
		end)))
	end
end

function var_0_0.onVideoEvent(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == ccexp.VideoPlayerEvent.COMPLETED and arg_10_0._handleComplete or arg_10_2 == ccexp.VideoPlayerEvent.STOPPED then
		arg_10_0:switchScene()
	end
end

function var_0_0.onIdle(arg_11_0)
	lc.Director:updateTouchTimestamp()
end

function var_0_0.switchScene(arg_12_0)
	ClientView.popScene(false)
end

return var_0_0
