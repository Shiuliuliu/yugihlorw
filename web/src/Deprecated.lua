require("Cocos2d")

local function var_0_0(arg_1_0, arg_1_1)
	print("\n********** \n" .. arg_1_0 .. " was deprecated please use " .. arg_1_1 .. " instead.\n**********")
end

local var_0_1 = {
	sharedDirector = function()
		var_0_0("CCDirector:sharedDirector", "cc.Director:getInstance")

		return cc.Director:getInstance()
	end
}

rawset(CCDirector, "sharedDirector", var_0_1.sharedDirector)

local var_0_2 = {
	getInstance = function(arg_3_0)
		var_0_0("cc.TextureCache:getInstance", "cc.Director:getInstance():getTextureCache")

		return cc.Director:getInstance():getTextureCache()
	end
}

rawset(cc.TextureCache, "getInstance", var_0_2.getInstance)

function var_0_2.destroyInstance(arg_4_0)
	var_0_0("cc.TextureCache:destroyInstance", "cc.Director:getInstance():destroyTextureCache")

	return cc.Director:getInstance():destroyTextureCache()
end

rawset(cc.TextureCache, "destroyInstance", var_0_2.destroyInstance)

function var_0_2.dumpCachedTextureInfo(arg_5_0)
	var_0_0("self:dumpCachedTextureInfo", "self:getCachedTextureInfo")

	return print(arg_5_0:getCachedTextureInfo())
end

rawset(cc.TextureCache, "dumpCachedTextureInfo", var_0_2.dumpCachedTextureInfo)

local var_0_3 = {
	sharedTextureCache = function()
		var_0_0("CCTextureCache:sharedTextureCache", "CCTextureCache:getInstance")

		return cc.TextureCache:getInstance()
	end
}

rawset(CCTextureCache, "sharedTextureCache", var_0_3.sharedTextureCache)

function var_0_3.purgeSharedTextureCache()
	var_0_0("CCTextureCache:purgeSharedTextureCache", "CCTextureCache:destroyInstance")

	return cc.TextureCache:destroyInstance()
end

rawset(CCTextureCache, "purgeSharedTextureCache", var_0_3.purgeSharedTextureCache)

function var_0_3.addUIImage(arg_8_0, arg_8_1, arg_8_2)
	var_0_0("CCTextureCache:addUIImage", "CCTextureCache:addImage")

	return arg_8_0:addImage(arg_8_1, arg_8_2)
end

rawset(CCTextureCache, "addUIImage", var_0_3.addUIImage)

local var_0_4 = {
	addSpriteFrameWithFileName = function(arg_9_0, ...)
		var_0_0("CCAnimationDeprecated:addSpriteFrameWithFileName", "cc.Animation:addSpriteFrameWithFile")

		return arg_9_0:addSpriteFrameWithFile(...)
	end
}

rawset(CCAnimation, "addSpriteFrameWithFileName", var_0_4.addSpriteFrameWithFileName)

local var_0_5 = {
	sharedAnimationCache = function()
		var_0_0("CCAnimationCache:sharedAnimationCache", "CCAnimationCache:getInstance")

		return CCAnimationCache:getInstance()
	end
}

rawset(CCAnimationCache, "sharedAnimationCache", var_0_5.sharedAnimationCache)

function var_0_5.purgeSharedAnimationCache()
	var_0_0("CCAnimationCache:purgeSharedAnimationCache", "CCAnimationCache:destroyInstance")

	return CCAnimationCache:destroyInstance()
end

rawset(CCAnimationCache, "purgeSharedAnimationCache", var_0_5.purgeSharedAnimationCache)

function var_0_5.addAnimationsWithFile(arg_12_0, ...)
	var_0_0("CCAnimationCache:addAnimationsWithFile", "cc.AnimationCache:addAnimations")

	return arg_12_0:addAnimations(...)
end

rawset(CCAnimationCache, "addAnimationsWithFile", var_0_5.addAnimationsWithFile)

function var_0_5.animationByName(arg_13_0, ...)
	var_0_0("CCAnimationCache:animationByName", "cc.AnimationCache:getAnimation")

	return arg_13_0:getAnimation(...)
end

rawset(CCAnimationCache, "animationByName", var_0_5.animationByName)

function var_0_5.removeAnimationByName(arg_14_0)
	var_0_0("CCAnimationCache:removeAnimationByName", "cc.AnimationCache:removeAnimation")

	return arg_14_0:removeAnimation()
end

rawset(CCAnimationCache, "removeAnimationByName", var_0_5.removeAnimationByName)

local var_0_6 = {
	sharedFileUtils = function()
		var_0_0("CCFileUtils:sharedFileUtils", "CCFileUtils:getInstance")

		return cc.FileUtils:getInstance()
	end
}

rawset(CCFileUtils, "sharedFileUtils", var_0_6.sharedFileUtils)

function var_0_6.purgeFileUtils()
	var_0_0("CCFileUtils:purgeFileUtils", "CCFileUtils:destroyInstance")

	return cc.FileUtils:destroyInstance()
end

rawset(CCFileUtils, "purgeFileUtils", var_0_6.purgeFileUtils)

local var_0_7 = {
	sharedEngine = function()
		var_0_0("SimpleAudioEngine:sharedEngine", "SimpleAudioEngine:getInstance")

		return cc.SimpleAudioEngine:getInstance()
	end
}

rawset(SimpleAudioEngine, "sharedEngine", var_0_7.sharedEngine)

function var_0_7.playBackgroundMusic(arg_18_0, ...)
	var_0_0("SimpleAudioEngine:playBackgroundMusic", "SimpleAudioEngine:playMusic")

	return arg_18_0:playMusic(...)
end

rawset(SimpleAudioEngine, "playBackgroundMusic", var_0_7.playBackgroundMusic)

local var_0_8 = {
	createWithItem = function(arg_19_0, ...)
		var_0_0("CCMenuDeprecated:createWithItem", "cc.Menu:createWithItem")

		return arg_19_0:create(...)
	end
}

rawset(CCMenu, "createWithItem", var_0_8.createWithItem)

function var_0_8.setHandlerPriority(arg_20_0)
	print("\n********** \n" .. "setHandlerPriority was deprecated in 3.0. \n**********")
end

rawset(CCMenu, "setHandlerPriority", var_0_8.setHandlerPriority)

local var_0_9 = {
	boundingBox = function(arg_21_0)
		var_0_0("CCNode:boundingBox", "cc.Node:getBoundingBox")

		return arg_21_0:getBoundingBox()
	end
}

rawset(CCNode, "boundingBox", var_0_9.boundingBox)

function var_0_9.numberOfRunningActions(arg_22_0)
	var_0_0("CCNode:numberOfRunningActions", "cc.Node:getNumberOfRunningActions")

	return arg_22_0:getNumberOfRunningActions()
end

rawset(CCNode, "numberOfRunningActions", var_0_9.numberOfRunningActions)

function var_0_9.removeFromParentAndCleanup(arg_23_0, ...)
	var_0_0("CCNode:removeFromParentAndCleanup", "cc.Node:removeFromParent")

	return arg_23_0:removeFromParent(...)
end

rawset(CCNode, "removeFromParentAndCleanup", var_0_9.removeFromParentAndCleanup)

local function var_0_10()
	var_0_0("CCDrawPrimitives", "cc.DrawPrimitives")

	return cc.DrawPrimitives
end

_G.CCDrawPrimitives = var_0_10()

local var_0_11 = {
	ccDrawPoint = function(arg_25_0)
		var_0_0("ccDrawPoint", "cc.DrawPrimitives.drawPoint")

		return cc.DrawPrimitives.drawPoint(arg_25_0)
	end
}

rawset(_G, "ccDrawPoint", var_0_11.ccDrawPoint)

function var_0_11.ccDrawLine(arg_26_0, arg_26_1)
	var_0_0("ccDrawLine", "cc.DrawPrimitives.drawLine")

	return cc.DrawPrimitives.drawLine(arg_26_0, arg_26_1)
end

rawset(_G, "ccDrawLine", var_0_11.ccDrawLine)

function var_0_11.ccDrawRect(arg_27_0, arg_27_1)
	var_0_0("ccDrawRect", "cc.DrawPrimitives.drawRect")

	return cc.DrawPrimitives.drawRect(arg_27_0, arg_27_1)
end

rawset(_G, "ccDrawRect", var_0_11.ccDrawRect)

function var_0_11.ccDrawSolidRect(arg_28_0, arg_28_1, arg_28_2)
	var_0_0("ccDrawSolidRect", "cc.DrawPrimitives.drawSolidRect")

	return cc.DrawPrimitives.drawSolidRect(arg_28_0, arg_28_1, arg_28_2)
end

rawset(_G, "ccDrawSolidRect", var_0_11.ccDrawSolidRect)

function var_0_11.ccDrawCircle(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, ...)
	var_0_0("ccDrawCircle", "cc.DrawPrimitives.drawCircle")

	return cc.DrawPrimitives.drawCircle(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, ...)
end

rawset(_G, "ccDrawCircle", var_0_11.ccDrawCircle)

function var_0_11.ccDrawSolidCircle(arg_30_0, arg_30_1, arg_30_2, arg_30_3, ...)
	var_0_0("ccDrawSolidCircle", "cc.DrawPrimitives.drawSolidCircle")

	return cc.DrawPrimitives.drawSolidCircle(arg_30_0, arg_30_1, arg_30_2, arg_30_3, ...)
end

rawset(_G, "ccDrawSolidCircle", var_0_11.ccDrawSolidCircle)

function var_0_11.ccDrawQuadBezier(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	var_0_0("ccDrawQuadBezier", "cc.DrawPrimitives.drawQuadBezier")

	return cc.DrawPrimitives.drawQuadBezier(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
end

rawset(_G, "ccDrawQuadBezier", var_0_11.ccDrawQuadBezier)

function var_0_11.ccDrawCubicBezier(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	var_0_0("ccDrawCubicBezier", "cc.DrawPrimitives.drawCubicBezier")

	return cc.DrawPrimitives.drawCubicBezier(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
end

rawset(_G, "ccDrawCubicBezier", var_0_11.ccDrawCubicBezier)

function var_0_11.ccDrawCatmullRom(arg_33_0, arg_33_1)
	var_0_0("ccDrawCatmullRom", "cc.DrawPrimitives.drawCatmullRom")

	return cc.DrawPrimitives.drawCatmullRom(arg_33_0, arg_33_1)
end

rawset(_G, "ccDrawCatmullRom", var_0_11.ccDrawCatmullRom)

function var_0_11.ccDrawCardinalSpline(arg_34_0, arg_34_1, arg_34_2)
	var_0_0("ccDrawCardinalSpline", "cc.DrawPrimitives.drawCardinalSpline")

	return cc.DrawPrimitives.drawCardinalSpline(arg_34_0, arg_34_1, arg_34_2)
end

rawset(_G, "ccDrawCardinalSpline", var_0_11.ccDrawCardinalSpline)

function var_0_11.ccDrawColor4B(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	var_0_0("ccDrawColor4B", "cc.DrawPrimitives.drawColor4B")

	return cc.DrawPrimitives.drawColor4B(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
end

rawset(_G, "ccDrawColor4B", var_0_11.ccDrawColor4B)

function var_0_11.ccDrawColor4F(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	var_0_0("ccDrawColor4F", "cc.DrawPrimitives.drawColor4F")

	return cc.DrawPrimitives.drawColor4F(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
end

rawset(_G, "ccDrawColor4F", var_0_11.ccDrawColor4F)

function var_0_11.ccPointSize(arg_37_0)
	var_0_0("ccPointSize", "cc.DrawPrimitives.setPointSize")

	return cc.DrawPrimitives.setPointSize(arg_37_0)
end

rawset(_G, "ccPointSize", var_0_11.ccPointSize)

local var_0_12 = {
	setReverseProgress = function(arg_38_0, ...)
		var_0_0("CCProgressTimer", "CCProgressTimer:setReverseDirection")

		return arg_38_0:setReverseDirection(...)
	end
}

rawset(CCProgressTimer, "setReverseProgress", var_0_12.setReverseProgress)

local var_0_13 = {
	spriteFrameByName = function(arg_39_0, arg_39_1)
		var_0_0("CCSpriteFrameCache:spriteFrameByName", "CCSpriteFrameCache:getSpriteFrameByName")

		return arg_39_0:getSpriteFrameByName(arg_39_1)
	end
}

rawset(CCSpriteFrameCache, "spriteFrameByName", var_0_13.spriteFrameByName)

function var_0_13.sharedSpriteFrameCache()
	var_0_0("CCSpriteFrameCache:sharedSpriteFrameCache", "CCSpriteFrameCache:getInstance")

	return CCSpriteFrameCache:getInstance()
end

rawset(CCSpriteFrameCache, "sharedSpriteFrameCache", var_0_13.sharedSpriteFrameCache)

function var_0_13.purgeSharedSpriteFrameCache()
	var_0_0("CCSpriteFrameCache:purgeSharedSpriteFrameCache", "CCSpriteFrameCache:destroyInstance")

	return CCSpriteFrameCache:destroyInstance()
end

rawset(CCSpriteFrameCache, "purgeSharedSpriteFrameCache", var_0_13.purgeSharedSpriteFrameCache)

function var_0_13.addSpriteFramesWithFile(arg_42_0, ...)
	var_0_0("CCSpriteFrameCache:addSpriteFramesWithFile", "CCSpriteFrameCache:addSpriteFrames")

	return arg_42_0:addSpriteFrames(...)
end

rawset(CCSpriteFrameCache, "addSpriteFramesWithFile", var_0_13.addSpriteFramesWithFile)

function var_0_13.getSpriteFrameByName(arg_43_0, ...)
	var_0_0("CCSpriteFrameCache:getSpriteFrameByName", "CCSpriteFrameCache:getSpriteFrame")

	return arg_43_0:getSpriteFrame(...)
end

rawset(CCSpriteFrameCache, "getSpriteFrameByName", var_0_13.getSpriteFrameByName)

local var_0_14 = {
	create = function(arg_44_0, ...)
		var_0_0("CCLabelAtlas:create", "CCLabelAtlas:_create")

		return arg_44_0:_create(...)
	end
}

rawset(CCLabelAtlas, "create", var_0_14.create)

local function var_0_15(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	var_0_0("CCRectMake(x,y,width,height)", "cc.rect(x,y,width,height) in lua")

	return cc.rect(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
end

rawset(_G, "CCRectMake", var_0_15)

local function var_0_16(arg_46_0, arg_46_1, arg_46_2)
	var_0_0("ccc3(r,g,b)", "cc.c3b(r,g,b)")

	return cc.c3b(arg_46_0, arg_46_1, arg_46_2)
end

rawset(_G, "ccc3", var_0_16)

local function var_0_17(arg_47_0, arg_47_1)
	var_0_0("ccp(x,y)", "cc.p(x,y)")

	return cc.p(arg_47_0, arg_47_1)
end

rawset(_G, "ccp", var_0_17)

local function var_0_18(arg_48_0, arg_48_1)
	var_0_0("CCSizeMake(width,height)", "cc.size(width,height)")

	return cc.size(arg_48_0, arg_48_1)
end

rawset(_G, "CCSizeMake", var_0_18)

local function var_0_19(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	var_0_0("ccc4(r,g,b,a)", "cc.c4b(r,g,b,a)")

	return cc.c4b(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
end

rawset(_G, "ccc4", var_0_19)

local function var_0_20(arg_50_0)
	var_0_0("ccc4FFromccc3B(color3B)", "cc.c4f(color3B.r / 255.0,color3B.g / 255.0,color3B.b / 255.0,1.0)")

	return cc.c4f(arg_50_0.r / 255, arg_50_0.g / 255, arg_50_0.b / 255, 1)
end

rawset(_G, "ccc4FFromccc3B", var_0_20)

local function var_0_21(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	var_0_0("ccc4f(r,g,b,a)", "cc.c4f(r,g,b,a)")

	return cc.c4f(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
end

rawset(_G, "ccc4f", var_0_21)

local function var_0_22(arg_52_0)
	var_0_0("ccc4FFromccc4B(color4B)", "cc.c4f(color4B.r/255.0, color4B.g/255.0, color4B.b/255.0, color4B.a/255.0)")

	return cc.c4f(arg_52_0.r / 255, arg_52_0.g / 255, arg_52_0.b / 255, arg_52_0.a / 255)
end

rawset(_G, "ccc4FFromccc4B", var_0_22)

local function var_0_23(arg_53_0, arg_53_1)
	var_0_0("ccc4FEqual(a,b)", "a:equals(b)")

	return arg_53_0:equals(arg_53_1)
end

rawset(_G, "ccc4FEqual", var_0_23)

local function var_0_24(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5)
	var_0_0("ccpLineIntersect", "cc.pIsLineIntersect")

	return cc.pIsLineIntersect(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5)
end

rawset(_G, "ccpLineIntersect", var_0_24)

local function var_0_25(arg_55_0, arg_55_1)
	var_0_0("CCPointMake(x,y)", "cc.p(x,y)")

	return cc.p(arg_55_0, arg_55_1)
end

rawset(_G, "CCPointMake", var_0_25)

local function var_0_26(arg_56_0)
	var_0_0("ccpNeg", "cc.pSub")

	return cc.pSub({
		x = 0,
		y = 0
	}, arg_56_0)
end

rawset(_G, "ccpNeg", var_0_26)

local function var_0_27(arg_57_0, arg_57_1)
	var_0_0("ccpAdd", "cc.pAdd")

	return cc.pAdd(arg_57_0, arg_57_1)
end

rawset(_G, "ccpAdd", var_0_27)

local function var_0_28(arg_58_0, arg_58_1)
	var_0_0("ccpSub", "cc.pSub")

	return cc.pSub(arg_58_0, arg_58_1)
end

rawset(_G, "ccpSub", var_0_28)

local function var_0_29(arg_59_0, arg_59_1)
	var_0_0("ccpMult", "cc.pMul")

	return cc.pMul(arg_59_0, arg_59_1)
end

rawset(_G, "ccpMult", var_0_29)

local function var_0_30(arg_60_0, arg_60_1)
	var_0_0("ccpMidpoint", "cc.pMidpoint")

	return cc.pMidpoint(arg_60_0, arg_60_1)
end

rawset(_G, "ccpMidpoint", var_0_30)

local function var_0_31(arg_61_0, arg_61_1)
	var_0_0("ccpDot", "cc.pDot")

	return cc.pDot(arg_61_0, arg_61_1)
end

rawset(_G, "ccpDot", var_0_31)

local function var_0_32(arg_62_0, arg_62_1)
	var_0_0("ccpCross", "cc.pCross")

	return cc.pCross(arg_62_0, arg_62_1)
end

rawset(_G, "ccpCross", var_0_32)

local function var_0_33(arg_63_0)
	var_0_0("ccpPerp", "cc.pPerp")

	return cc.pPerp(arg_63_0)
end

rawset(_G, "ccpPerp", var_0_33)

local function var_0_34(arg_64_0)
	var_0_0("ccpRPerp", "cc.RPerp")

	return cc.RPerp(arg_64_0)
end

rawset(_G, "ccpRPerp", var_0_34)

local function var_0_35(arg_65_0, arg_65_1)
	var_0_0("ccpProject", "cc.pProject")

	return cc.pProject(arg_65_0, arg_65_1)
end

rawset(_G, "ccpProject", var_0_35)

local function var_0_36(arg_66_0, arg_66_1)
	var_0_0("ccpRotate", "cc.pRotate")

	return cc.pRotate(arg_66_0, arg_66_1)
end

rawset(_G, "ccpRotate", var_0_36)

local function var_0_37(arg_67_0, arg_67_1)
	var_0_0("ccpUnrotate", "cc.pUnrotate")

	return cc.pUnrotate(arg_67_0, arg_67_1)
end

rawset(_G, "ccpUnrotate", var_0_37)

local function var_0_38(arg_68_0)
	var_0_0("ccpLengthSQ", "cc.pLengthSQ")

	return cc.pLengthSQ(arg_68_0)
end

rawset(_G, "ccpLengthSQ", var_0_38)

local function var_0_39(arg_69_0, arg_69_1)
	var_0_0("ccpDistanceSQ", "cc.pDistanceSQ")

	return cc.pDistanceSQ(arg_69_0, arg_69_1)
end

rawset(_G, "ccpDistanceSQ", var_0_39)

local function var_0_40(arg_70_0)
	var_0_0("ccpLength", "cc.pGetLength")

	return cc.pGetLength(arg_70_0)
end

rawset(_G, "ccpLength", var_0_40)

local function var_0_41(arg_71_0, arg_71_1)
	var_0_0("ccpDistance", "cc.pGetDistance")

	return cc.pGetDistance(arg_71_0, arg_71_1)
end

rawset(_G, "ccpDistance", var_0_41)

local function var_0_42(arg_72_0)
	var_0_0("ccpNormalize", "cc.pNormalize")

	return cc.pNormalize(arg_72_0)
end

rawset(_G, "ccpNormalize", var_0_42)

local function var_0_43(arg_73_0)
	var_0_0("ccpForAngle", "cc.pForAngle")

	return cc.pForAngle(arg_73_0)
end

rawset(_G, "ccpForAngle", var_0_43)

local function var_0_44(arg_74_0)
	var_0_0("ccpToAngle", "cc.pToAngleSelf")

	return cc.pToAngleSelf(arg_74_0)
end

rawset(_G, "ccpToAngle", var_0_44)

local function var_0_45(arg_75_0, arg_75_1, arg_75_2)
	var_0_0("ccpClamp", "cc.pGetClampPoint")

	return cc.pGetClampPoint(arg_75_0, arg_75_1, arg_75_2)
end

rawset(_G, "ccpClamp", var_0_45)

local function var_0_46(arg_76_0)
	var_0_0("ccpFromSize(sz)", "cc.pFromSize")

	return cc.pFromSize(arg_76_0)
end

rawset(_G, "ccpFromSize", var_0_46)

local function var_0_47(arg_77_0, arg_77_1, arg_77_2)
	var_0_0("ccpLerp", "cc.pLerp")

	return cc.pLerp(arg_77_0, arg_77_1, arg_77_2)
end

rawset(_G, "ccpLerp", var_0_47)

local function var_0_48(arg_78_0, arg_78_1, arg_78_2)
	var_0_0("ccpFuzzyEqual", "cc.pFuzzyEqual")

	return cc.pFuzzyEqual(arg_78_0, arg_78_1, arg_78_2)
end

rawset(_G, "ccpFuzzyEqual", var_0_48)

local function var_0_49(arg_79_0, arg_79_1)
	var_0_0("ccpCompMult", "cc.p")

	return cc.p(arg_79_0.x * arg_79_1.x, arg_79_0.y * arg_79_1.y)
end

rawset(_G, "ccpCompMult", var_0_49)

local function var_0_50(arg_80_0, arg_80_1)
	var_0_0("ccpAngleSigned", "cc.pGetAngle")

	return cc.pGetAngle(arg_80_0, arg_80_1)
end

rawset(_G, "ccpAngleSigned", var_0_50)

local function var_0_51(arg_81_0, arg_81_1)
	var_0_0("ccpAngle", "cc.pGetAngle")

	return cc.pGetAngle(arg_81_0, ptw)
end

rawset(_G, "ccpAngle", var_0_51)

local function var_0_52(arg_82_0, arg_82_1, arg_82_2)
	var_0_0("ccpRotateByAngle", "cc.pRotateByAngle")

	return cc.pRotateByAngle(arg_82_0, arg_82_1, arg_82_2)
end

rawset(_G, "ccpRotateByAngle", var_0_52)

local function var_0_53(arg_83_0, arg_83_1, arg_83_2, arg_83_3)
	var_0_0("ccpSegmentIntersect", "cc.pIsSegmentIntersect")

	return cc.pIsSegmentIntersect(arg_83_0, arg_83_1, arg_83_2, arg_83_3)
end

rawset(_G, "ccpSegmentIntersect", var_0_53)

local function var_0_54(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	var_0_0("ccpIntersectPoint", "cc.pGetIntersectPoint")

	return cc.pGetIntersectPoint(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
end

rawset(_G, "ccpIntersectPoint", var_0_54)

local function var_0_55(arg_85_0, arg_85_1)
	var_0_0("vertex2(x,y)", "cc.vertex2F(x,y)")

	return cc.vertex2F(arg_85_0, arg_85_1)
end

rawset(_G, "vertex2", var_0_55)

local function var_0_56(arg_86_0, arg_86_1, arg_86_2)
	var_0_0("vertex3(x,y,z)", "cc.Vertex3F(x,y,z)")

	return cc.Vertex3F(arg_86_0, arg_86_1, arg_86_2)
end

rawset(_G, "vertex3", var_0_56)

local function var_0_57(arg_87_0, arg_87_1)
	var_0_0("tex2(u,v)", "cc.tex2f(u,v)")

	return cc.tex2f(arg_87_0, arg_87_1)
end

rawset(_G, "tex2", var_0_57)

local function var_0_58(arg_88_0)
	var_0_0("ccc4BFromccc4F(color4F)", "Color4B(color4F.r * 255.0, color4F.g * 255.0, color4F.b * 255.0, color4B.a * 255.0)")

	return Color4B(arg_88_0.r * 255, arg_88_0.g * 255, arg_88_0.b * 255, color4B.a * 255)
end

rawset(_G, "ccc4BFromccc4F", var_0_58)

local function var_0_59()
	var_0_0("ccColor3B", "cc.c3b(0,0,0)")

	return cc.c3b(0, 0, 0)
end

_G.ccColor3B = var_0_59

local function var_0_60()
	var_0_0("ccColor4B", "cc.c4b(0,0,0,0)")

	return cc.c4b(0, 0, 0, 0)
end

_G.ccColor4B = var_0_60

local function var_0_61()
	var_0_0("ccColor4F", "cc.c4f(0.0,0.0,0.0,0.0)")

	return cc.c4f(0, 0, 0, 0)
end

_G.ccColor4F = var_0_61

local function var_0_62()
	var_0_0("ccVertex2F", "cc.vertex2F(0.0,0.0)")

	return cc.vertex2F(0, 0)
end

_G.ccVertex2F = var_0_62

local function var_0_63()
	var_0_0("ccVertex3F", "cc.Vertex3F(0.0, 0.0, 0.0)")

	return cc.Vertex3F(0, 0, 0)
end

_G.ccVertex3F = var_0_63

local function var_0_64()
	var_0_0("ccTex2F", "cc.tex2F(0.0, 0.0)")

	return cc.tex2F(0, 0)
end

_G.ccTex2F = var_0_64

local function var_0_65()
	var_0_0("ccPointSprite", "cc.PointSprite(cc.vertex2F(0.0, 0.0),cc.c4b(0.0, 0.0, 0.0),0)")

	return cc.PointSprite(cc.vertex2F(0, 0), cc.c4b(0, 0, 0), 0)
end

_G.ccPointSprite = var_0_65

local function var_0_66()
	var_0_0("ccQuad2", "cc.Quad2(cc.vertex2F(0.0, 0.0), cc.vertex2F(0.0, 0.0), cc.vertex2F(0.0, 0.0), cc.vertex2F(0.0, 0.0))")

	return cc.Quad2(cc.vertex2F(0, 0), cc.vertex2F(0, 0), cc.vertex2F(0, 0), cc.vertex2F(0, 0))
end

_G.ccQuad2 = var_0_66

local function var_0_67()
	var_0_0("ccQuad3", "cc.Quad3(cc.Vertex3F(0.0, 0.0 ,0.0), cc.Vertex3F(0.0, 0.0 ,0.0), cc.Vertex3F(0.0, 0.0 ,0.0), cc.Vertex3F(0.0, 0.0 ,0.0))")

	return cc.Quad3(cc.Vertex3F(0, 0, 0), cc.Vertex3F(0, 0, 0), cc.Vertex3F(0, 0, 0), cc.Vertex3F(0, 0, 0))
end

_G.ccQuad3 = var_0_67

local function var_0_68()
	var_0_0("ccV2F_C4B_T2F", "cc.V2F_C4B_T2F(cc.vertex2F(0.0, 0.0), cc.c4b(0 , 0, 0, 0 ), cc.tex2F(0.0, 0.0))")

	return cc.V2F_C4B_T2F(cc.vertex2F(0, 0), cc.c4b(0, 0, 0, 0), cc.tex2F(0, 0))
end

_G.ccV2F_C4B_T2F = var_0_68

local function var_0_69()
	var_0_0("ccV2F_C4F_T2F", "cc.V2F_C4F_T2F(cc.vertex2F(0.0, 0.0), cc.c4f(0.0 , 0.0 , 0.0 , 0.0 ), cc.tex2F(0.0, 0.0))")

	return cc.V2F_C4F_T2F(cc.vertex2F(0, 0), cc.c4f(0, 0, 0, 0), cc.tex2F(0, 0))
end

_G.ccV2F_C4F_T2F = var_0_69

local function var_0_70()
	var_0_0("ccV3F_C4B_T2F", "cc.V3F_C4B_T2F(cc.vertex3F(0.0, 0.0, 0.0), cc.c4b(0 , 0 , 0, 0 ), cc.tex2F(0.0, 0.0))")

	return cc.V3F_C4B_T2F(cc.vertex3F(0, 0, 0), cc.c4b(0, 0, 0, 0), cc.tex2F(0, 0))
end

_G.ccV3F_C4B_T2F = var_0_70

local function var_0_71()
	var_0_0("ccV2F_C4B_T2F_Quad", "cc.V2F_C4B_T2F_Quad(cc.V2F_C4B_T2F(cc.vertex2F(0.0, 0.0), cc.c4b(0 , 0, 0, 0 ), cc.tex2F(0.0, 0.0)), cc.V2F_C4B_T2F(cc.vertex2F(0.0, 0.0), cc.c4b(0 , 0, 0, 0 ), cc.tex2F(0.0, 0.0)), cc.V2F_C4B_T2F(cc.vertex2F(0.0, 0.0), cc.c4b(0 , 0, 0, 0 ), cc.tex2F(0.0, 0.0)), cc.V2F_C4B_T2F(cc.vertex2F(0.0, 0.0), cc.c4b(0 , 0, 0, 0 ), cc.tex2F(0.0, 0.0)))")

	return cc.V2F_C4B_T2F_Quad(cc.V2F_C4B_T2F(cc.vertex2F(0, 0), cc.c4b(0, 0, 0, 0), cc.tex2F(0, 0)), cc.V2F_C4B_T2F(cc.vertex2F(0, 0), cc.c4b(0, 0, 0, 0), cc.tex2F(0, 0)), cc.V2F_C4B_T2F(cc.vertex2F(0, 0), cc.c4b(0, 0, 0, 0), cc.tex2F(0, 0)), cc.V2F_C4B_T2F(cc.vertex2F(0, 0), cc.c4b(0, 0, 0, 0), cc.tex2F(0, 0)))
end

_G.ccV2F_C4B_T2F_Quad = var_0_71

local function var_0_72()
	var_0_0("ccV3F_C4B_T2F_Quad", "cc.V3F_C4B_T2F_Quad(_tl, _bl, _tr, _br)")

	return cc.V3F_C4B_T2F_Quad(cc.V3F_C4B_T2F(cc.vertex3F(0, 0, 0), cc.c4b(0, 0, 0, 0), cc.tex2F(0, 0)), cc.V3F_C4B_T2F(cc.vertex3F(0, 0, 0), cc.c4b(0, 0, 0, 0), cc.tex2F(0, 0)), cc.V3F_C4B_T2F(cc.vertex3F(0, 0, 0), cc.c4b(0, 0, 0, 0), cc.tex2F(0, 0)), cc.V3F_C4B_T2F(cc.vertex3F(0, 0, 0), cc.c4b(0, 0, 0, 0), cc.tex2F(0, 0)))
end

_G.ccV3F_C4B_T2F_Quad = var_0_72

local function var_0_73()
	var_0_0("ccV2F_C4F_T2F_Quad", "cc.V2F_C4F_T2F_Quad(_bl, _br, _tl, _tr)")

	return cc.V2F_C4F_T2F_Quad(cc.V2F_C4F_T2F(cc.vertex2F(0, 0), cc.c4f(0, 0, 0, 0), cc.tex2F(0, 0)), cc.V2F_C4F_T2F(cc.vertex2F(0, 0), cc.c4f(0, 0, 0, 0), cc.tex2F(0, 0)), cc.V3F_C4B_T2F(cc.vertex2F(0, 0), cc.c4f(0, 0, 0, 0), cc.tex2F(0, 0)), cc.V2F_C4F_T2F(cc.vertex2F(0, 0), cc.c4f(0, 0, 0, 0), cc.tex2F(0, 0)))
end

_G.ccV2F_C4F_T2F_Quad = var_0_73

local function var_0_74()
	var_0_0("ccT2F_Quad", "cc.T2F_Quad(_bl, _br, _tl, _tr)")

	return cc.T2F_Quad(cc.tex2F(0, 0), cc.tex2F(0, 0), cc.tex2F(0, 0), cc.tex2F(0, 0))
end

_G.ccT2F_Quad = var_0_74

local function var_0_75()
	var_0_0("ccAnimationFrameData", "cc.AnimationFrameData( _texCoords, _delay, _size)")

	return cc.AnimationFrameData(cc.T2F_Quad(cc.tex2F(0, 0), cc.tex2F(0, 0), cc.tex2F(0, 0), cc.tex2F(0, 0)), 0, cc.size(0, 0))
end

_G.ccAnimationFrameData = var_0_75

local function var_0_76(arg_106_0, arg_106_1)
	var_0_0("tex2(u,v)", "cc.tex2f(u,v)")

	return cc.tex2f(arg_106_0, arg_106_1)
end

rawset(_G, "tex2", var_0_76)

local var_0_77 = {
	addHandleOfControlEvent = function(arg_107_0, arg_107_1, arg_107_2)
		var_0_0("addHandleOfControlEvent", "registerControlEventHandler")
		print("come in addHandleOfControlEvent")
		arg_107_0:registerControlEventHandler(arg_107_1, arg_107_2)
	end
}

rawset(CCControl, "addHandleOfControlEvent", var_0_77.addHandleOfControlEvent)
rawset(CCTableView, "kTableViewScroll", cc.SCROLLVIEW_SCRIPT_SCROLL)
rawset(CCTableView, "kTableViewZoom", cc.SCROLLVIEW_SCRIPT_ZOOM)
rawset(CCTableView, "kTableCellTouched", cc.TABLECELL_TOUCHED)
rawset(CCTableView, "kTableCellSizeForIndex", cc.TABLECELL_SIZE_FOR_INDEX)
rawset(CCTableView, "kTableCellSizeAtIndex", cc.TABLECELL_SIZE_AT_INDEX)
rawset(CCTableView, "kNumberOfCellsInTableView", cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
rawset(CCScrollView, "kScrollViewScroll", cc.SCROLLVIEW_SCRIPT_SCROLL)
rawset(CCScrollView, "kScrollViewZoom", cc.SCROLLVIEW_SCRIPT_ZOOM)

local var_0_78 = {
	sharedApplication = function()
		var_0_0("CCApplication:sharedApplication", "CCApplication:getInstance")

		return CCApplication:getInstance()
	end
}

rawset(CCApplication, "sharedApplication", var_0_78.sharedApplication)

local var_0_79 = {
	sharedDirector = function()
		var_0_0("CCDirector:sharedDirector", "CCDirector:getInstance")

		return CCDirector:getInstance()
	end
}

rawset(CCDirector, "sharedDirector", var_0_79.sharedDirector)

local var_0_80 = {
	sharedUserDefault = function()
		var_0_0("CCUserDefault:sharedUserDefault", "CCUserDefault:getInstance")

		return CCUserDefault:getInstance()
	end
}

rawset(CCUserDefault, "sharedUserDefault", var_0_80.sharedUserDefault)

function var_0_80.purgeSharedUserDefault()
	var_0_0("CCUserDefault:purgeSharedUserDefault", "CCUserDefault:destroyInstance")

	return CCUserDefault:destroyInstance()
end

rawset(CCUserDefault, "purgeSharedUserDefault", var_0_80.purgeSharedUserDefault)

local var_0_81 = {
	vertex = function(arg_112_0, arg_112_1)
		var_0_0("vertex", "CCGrid3DAction:getVertex")

		return arg_112_0:getVertex(arg_112_1)
	end
}

rawset(CCGrid3DAction, "vertex", var_0_81.vertex)

function var_0_81.originalVertex(arg_113_0, arg_113_1)
	var_0_0("originalVertex", "CCGrid3DAction:getOriginalVertex")

	return arg_113_0:getOriginalVertex(arg_113_1)
end

rawset(CCGrid3DAction, "originalVertex", var_0_81.originalVertex)

local var_0_82 = {
	tile = function(arg_114_0, arg_114_1)
		var_0_0("tile", "CCTiledGrid3DAction:getTile")

		return arg_114_0:getTile(arg_114_1)
	end
}

rawset(CCTiledGrid3DAction, "tile", var_0_82.tile)

function var_0_82.originalTile(arg_115_0, arg_115_1)
	var_0_0("originalTile", "CCTiledGrid3DAction:getOriginalTile")

	return arg_115_0:getOriginalTile(arg_115_1)
end

rawset(CCTiledGrid3DAction, "originalTile", var_0_82.originalTile)

local var_0_83 = {
	stringForFormat = function(arg_116_0)
		var_0_0("Texture2D:stringForFormat", "Texture2D:getStringForFormat")

		return arg_116_0:getStringForFormat()
	end
}

rawset(CCTexture2D, "stringForFormat", var_0_83.stringForFormat)

function var_0_83.bitsPerPixelForFormat(arg_117_0)
	var_0_0("Texture2D:bitsPerPixelForFormat", "Texture2D:getBitsPerPixelForFormat")

	return arg_117_0:getBitsPerPixelForFormat()
end

rawset(CCTexture2D, "bitsPerPixelForFormat", var_0_83.bitsPerPixelForFormat)

function var_0_83.bitsPerPixelForFormat(arg_118_0, arg_118_1)
	var_0_0("Texture2D:bitsPerPixelForFormat", "Texture2D:getBitsPerPixelForFormat")

	return arg_118_0:getBitsPerPixelForFormat(arg_118_1)
end

rawset(CCTexture2D, "bitsPerPixelForFormat", var_0_83.bitsPerPixelForFormat)

function var_0_83.defaultAlphaPixelFormat(arg_119_0)
	var_0_0("Texture2D:defaultAlphaPixelFormat", "Texture2D:getDefaultAlphaPixelFormat")

	return arg_119_0:getDefaultAlphaPixelFormat()
end

rawset(CCTexture2D, "defaultAlphaPixelFormat", var_0_83.defaultAlphaPixelFormat)

local var_0_84 = {
	timerWithScriptHandler = function(arg_120_0, arg_120_1)
		var_0_0("CCTimer:timerWithScriptHandler", "CCTimer:createWithScriptHandler")

		return CCTimer:createWithScriptHandler(arg_120_0, arg_120_1)
	end
}

rawset(CCTimer, "timerWithScriptHandler", var_0_84.timerWithScriptHandler)

function var_0_84.numberOfRunningActionsInTarget(arg_121_0, arg_121_1)
	var_0_0("CCActionManager:numberOfRunningActionsInTarget", "CCActionManager:getNumberOfRunningActionsInTarget")

	return arg_121_0:getNumberOfRunningActionsInTarget(arg_121_1)
end

rawset(CCTimer, "numberOfRunningActionsInTarget", var_0_84.numberOfRunningActionsInTarget)

local var_0_85 = {
	fontSize = function()
		var_0_0("CCMenuItemFont:fontSize", "CCMenuItemFont:getFontSize")

		return CCMenuItemFont:getFontSize()
	end
}

rawset(CCMenuItemFont, "fontSize", var_0_85.fontSize)

function var_0_85.fontName()
	var_0_0("CCMenuItemFont:fontName", "CCMenuItemFont:getFontName")

	return CCMenuItemFont:getFontName()
end

rawset(CCMenuItemFont, "fontName", var_0_85.fontName)

function var_0_85.fontSizeObj(arg_124_0)
	var_0_0("CCMenuItemFont:fontSizeObj", "CCMenuItemFont:getFontSizeObj")

	return arg_124_0:getFontSizeObj()
end

rawset(CCMenuItemFont, "fontSizeObj", var_0_85.fontSizeObj)

function var_0_85.fontNameObj(arg_125_0)
	var_0_0("CCMenuItemFont:fontNameObj", "CCMenuItemFont:getFontNameObj")

	return arg_125_0:getFontNameObj()
end

rawset(CCMenuItemFont, "fontNameObj", var_0_85.fontNameObj)

local var_0_86 = {
	selectedItem = function(arg_126_0)
		var_0_0("CCMenuItemToggle:selectedItem", "CCMenuItemToggle:getSelectedItem")

		return arg_126_0:getSelectedItem()
	end
}

rawset(CCMenuItemToggle, "selectedItem", var_0_86.selectedItem)

local var_0_87 = {
	tileAt = function(arg_127_0, arg_127_1)
		var_0_0("CCTileMapAtlas:tileAt", "CCTileMapAtlas:getTileAt")

		return arg_127_0:getTileAt(arg_127_1)
	end
}

rawset(CCTileMapAtlas, "tileAt", var_0_87.tileAt)

local var_0_88 = {
	tileAt = function(arg_128_0, arg_128_1)
		var_0_0("CCTMXLayer:tileAt", "CCTMXLayer:getTileAt")

		return arg_128_0:getTileAt(arg_128_1)
	end
}

rawset(CCTMXLayer, "tileAt", var_0_88.tileAt)

function var_0_88.tileGIDAt(arg_129_0, arg_129_1)
	var_0_0("CCTMXLayer:tileGIDAt", "CCTMXLayer:getTileGIDAt")

	return arg_129_0:getTileGIDAt(arg_129_1)
end

rawset(CCTMXLayer, "tileGIDAt", var_0_88.tileGIDAt)

function var_0_88.positionAt(arg_130_0, arg_130_1)
	var_0_0("CCTMXLayer:positionAt", "CCTMXLayer:getPositionAt")

	return arg_130_0:getPositionAt(arg_130_1)
end

rawset(CCTMXLayer, "positionAt", var_0_88.positionAt)

function var_0_88.propertyNamed(arg_131_0, arg_131_1)
	var_0_0("CCTMXLayer:propertyNamed", "CCTMXLayer:getProperty")

	return arg_131_0:getProperty(arg_131_1)
end

rawset(CCTMXLayer, "propertyNamed", var_0_88.propertyNamed)

local var_0_89 = {
	layerNamed = function(arg_132_0, arg_132_1)
		var_0_0("CCTMXTiledMap:layerNamed", "CCTMXTiledMap:getLayer")

		return arg_132_0:getLayer(arg_132_1)
	end
}

rawset(CCTMXTiledMap, "layerNamed", var_0_89.layerNamed)

function var_0_89.propertyNamed(arg_133_0, arg_133_1)
	var_0_0("CCTMXTiledMap:propertyNamed", "CCTMXTiledMap:getProperty")

	return arg_133_0:getProperty(arg_133_1)
end

rawset(CCTMXTiledMap, "propertyNamed", var_0_89.propertyNamed)

function var_0_89.propertiesForGID(arg_134_0, arg_134_1)
	var_0_0("CCTMXTiledMap:propertiesForGID", "CCTMXTiledMap:getPropertiesForGID")

	return arg_134_0:getPropertiesForGID(arg_134_1)
end

rawset(CCTMXTiledMap, "propertiesForGID", var_0_89.propertiesForGID)

function var_0_89.objectGroupNamed(arg_135_0, arg_135_1)
	var_0_0("CCTMXTiledMap:objectGroupNamed", "CCTMXTiledMap:getObjectGroup")

	return arg_135_0:getObjectGroup(arg_135_1)
end

rawset(CCTMXTiledMap, "objectGroupNamed", var_0_89.objectGroupNamed)

local var_0_90 = {
	getStoringCharacters = function(arg_136_0)
		var_0_0("CCTMXMapInfo:getStoringCharacters", "CCTMXMapInfo:isStoringCharacters")

		return arg_136_0:isStoringCharacters()
	end
}

rawset(CCTMXMapInfo, "getStoringCharacters", var_0_90.getStoringCharacters)

function var_0_90.formatWithTMXFile(arg_137_0, arg_137_1)
	var_0_0("CCTMXMapInfo:formatWithTMXFile", "CCTMXMapInfo:create")

	return CCTMXMapInfo:create(arg_137_1)
end

rawset(CCTMXMapInfo, "formatWithTMXFile", var_0_90.formatWithTMXFile)

function var_0_90.formatWithXML(arg_138_0, arg_138_1, arg_138_2)
	var_0_0("CCTMXMapInfo:formatWithXML", "TMXMapInfo:createWithXML")

	return CCTMXMapInfo:createWithXML(arg_138_1, arg_138_2)
end

rawset(CCTMXMapInfo, "formatWithXML", var_0_90.formatWithXML)

local var_0_91 = {
	propertyNamed = function(arg_139_0, arg_139_1)
		var_0_0("CCTMXObjectGroup:propertyNamed", "CCTMXObjectGroup:getProperty")

		return arg_139_0:getProperty(arg_139_1)
	end
}

rawset(CCTMXObjectGroup, "propertyNamed", var_0_91.propertyNamed)

function var_0_91.objectNamed(arg_140_0, arg_140_1)
	var_0_0("CCTMXObjectGroup:objectNamed", "CCTMXObjectGroup:getObject")

	return arg_140_0:getObject(arg_140_1)
end

rawset(CCTMXObjectGroup, "objectNamed", var_0_91.objectNamed)

local var_0_92 = CCApplication:getInstance():getTargetPlatform()

if kTargetIphone == var_0_92 or kTargetIpad == var_0_92 or kTargetAndroid == var_0_92 or kTargetWindows == var_0_92 then
	local var_0_93 = {
		sendTextMsg = function(arg_141_0, arg_141_1)
			var_0_0("WebSocket:sendTextMsg", "WebSocket:sendString")

			return arg_141_0:sendString(arg_141_1)
		end
	}

	rawset(WebSocket, "sendTextMsg", var_0_93.sendTextMsg)

	function var_0_93.sendBinaryMsg(arg_142_0, arg_142_1, arg_142_2)
		var_0_0("WebSocket:sendBinaryMsg", "WebSocket:sendString")
		string.char(unpack(arg_142_1))

		return arg_142_0:sendString(string.char(unpack(arg_142_1)))
	end

	rawset(WebSocket, "sendBinaryMsg", var_0_93.sendBinaryMsg)
end

local var_0_94 = {
	newCCImage = function(arg_143_0)
		var_0_0("CCRenderTexture:newCCImage", "CCRenderTexture:newImage")

		return arg_143_0:newImage()
	end
}

rawset(CCRenderTexture, "newCCImage", var_0_94.newCCImage)

local var_0_95 = {
	setFlipX = function(arg_144_0, arg_144_1)
		var_0_0("CCSpriteDeprecated:setFlipX", "CCSpriteDeprecated:setFlippedX")

		return arg_144_0:setFlippedX(arg_144_1)
	end
}

rawset(cc.Sprite, "setFlipX", var_0_95.setFlipX)

function var_0_95.setFlipY(arg_145_0, arg_145_1)
	var_0_0("CCSpriteDeprecated:setFlipY", "CCSpriteDeprecated:setFlippedY")

	return arg_145_0:setFlippedY(arg_145_1)
end

rawset(cc.Sprite, "setFlipY", var_0_95.setFlipY)

local var_0_96 = {
	setKeypadEnabled = function(arg_146_0, arg_146_1)
		return arg_146_0:setKeyboardEnabled(arg_146_1)
	end
}

rawset(cc.Layer, "setKeypadEnabled", var_0_96.setKeypadEnabled)

function var_0_96.isKeypadEnabled(arg_147_0)
	return arg_147_0:isKeyboardEnabled()
end

rawset(cc.Layer, "isKeypadEnabled", var_0_96.isKeypadEnabled)

local var_0_97 = {
	purgeGUIReader = function()
		var_0_0("ccs.GUIReader:purgeGUIReader", "ccs.GUIReader:destroyInstance")

		return ccs.GUIReader:destroyInstance()
	end
}

rawset(ccs.GUIReader, "purgeGUIReader", var_0_97.purgeGUIReader)

local var_0_98 = {
	destroyActionManager = function()
		var_0_0("ccs.ActionManagerEx:destroyActionManager", "ccs.ActionManagerEx:destroyInstance")

		return ccs.ActionManagerEx:destroyInstance()
	end
}

rawset(ccs.ActionManagerEx, "destroyActionManager", var_0_98.destroyActionManager)

local var_0_99 = {
	destroySceneReader = function(arg_150_0)
		var_0_0("ccs.SceneReader:destroySceneReader", "ccs.SceneReader:destroyInstance")

		return arg_150_0:destroyInstance()
	end
}

rawset(ccs.SceneReader, "destroySceneReader", var_0_99.destroySceneReader)

local var_0_100 = {
	sharedArmatureDataManager = function()
		var_0_0("CCArmatureDataManager:sharedArmatureDataManager", "ccs.ArmatureDataManager:getInstance")

		return ccs.ArmatureDataManager:getInstance()
	end
}

rawset(CCArmatureDataManager, "sharedArmatureDataManager", var_0_100.sharedArmatureDataManager)

function var_0_100.purge()
	var_0_0("CCArmatureDataManager:purge", "ccs.ArmatureDataManager:destoryInstance")

	return ccs.ArmatureDataManager:destoryInstance()
end

rawset(CCArmatureDataManager, "purge", var_0_100.purge)

local var_0_101 = {
	shareReader = function()
		var_0_0("GUIReader:shareReader", "ccs.GUIReader:getInstance")

		return ccs.GUIReader:getInstance()
	end
}

rawset(GUIReader, "shareReader", var_0_101.shareReader)

function var_0_101.purgeGUIReader()
	var_0_0("GUIReader:purgeGUIReader", "ccs.GUIReader:destroyInstance")

	return ccs.GUIReader:destroyInstance()
end

rawset(GUIReader, "purgeGUIReader", var_0_101.purgeGUIReader)

local var_0_102 = {
	sharedSceneReader = function()
		var_0_0("SceneReader:sharedSceneReader", "ccs.SceneReader:getInstance")

		return ccs.SceneReader:getInstance()
	end
}

rawset(SceneReader, "sharedSceneReader", var_0_102.sharedSceneReader)

function var_0_102.purgeSceneReader(arg_156_0)
	var_0_0("SceneReader:purgeSceneReader", "ccs.SceneReader:destroyInstance")

	return arg_156_0:destroyInstance()
end

rawset(SceneReader, "purgeSceneReader", var_0_102.purgeSceneReader)

local var_0_103 = {
	setZOrder = function(arg_157_0, arg_157_1)
		var_0_0("cc.Node:setZOrder", "cc.Node:setLocalZOrder")

		return arg_157_0:setLocalZOrder(arg_157_1)
	end
}

rawset(cc.Node, "setZOrder", var_0_103.setZOrder)

function var_0_103.getZOrder(arg_158_0)
	var_0_0("cc.Node:getZOrder", "cc.Node:getLocalZOrder")

	return arg_158_0:getLocalZOrder()
end

rawset(cc.Node, "getZOrder", var_0_103.getZOrder)

function var_0_103.setVertexZ(arg_159_0, arg_159_1)
	var_0_0("cc.Node:setVertexZ", "cc.Node:setPositionZ")

	return arg_159_0:setPositionZ(arg_159_1)
end

rawset(cc.Node, "setVertexZ", var_0_103.setVertexZ)

function var_0_103.getVertexZ(arg_160_0)
	var_0_0("cc.Node:getVertexZ", "cc.Node:getPositionZ")

	return arg_160_0:getPositionZ()
end

rawset(cc.Node, "getVertexZ", var_0_103.getVertexZ)

local var_0_104 = {
	initWithVertexShaderByteArray = function(arg_161_0, arg_161_1, arg_161_2)
		var_0_0("cc.GLProgram:initWithVertexShaderByteArray", "cc.GLProgram:initWithByteArrays")

		return arg_161_0:initWithByteArrays(arg_161_1, arg_161_2)
	end
}

rawset(cc.GLProgram, "initWithVertexShaderByteArray", var_0_104.initWithVertexShaderByteArray)

function var_0_104.initWithVertexShaderFilename(arg_162_0, arg_162_1, arg_162_2)
	var_0_0("cc.GLProgram:initWithVertexShaderFilename", "cc.GLProgram:initWithFilenames")

	return arg_162_0:initWithFilenames(arg_162_1, arg_162_2)
end

rawset(cc.GLProgram, "initWithVertexShaderFilename", var_0_104.initWithVertexShaderFilename)

function var_0_104.addAttribute(arg_163_0, arg_163_1, arg_163_2)
	var_0_0("cc.GLProgram:addAttribute", "cc.GLProgram:bindAttribLocation")

	return arg_163_0:bindAttribLocation(arg_163_1, arg_163_2)
end

rawset(cc.GLProgram, "addAttribute", var_0_104.addAttribute)

local var_0_105 = {
	setText = function(arg_164_0, arg_164_1)
		var_0_0("ccui.Text:setText", "ccui.Text:setString")

		return arg_164_0:setString(arg_164_1)
	end
}

rawset(ccui.Text, "setText", var_0_105.setText)

function var_0_105.getStringValue(arg_165_0)
	var_0_0("ccui.Text:getStringValue", "ccui.Text:getString")

	return arg_165_0:getString()
end

rawset(ccui.Text, "getStringValue", var_0_105.getStringValue)

local var_0_106 = {
	setStringValue = function(arg_166_0, arg_166_1)
		var_0_0("ccui.TextAtlas:setStringValue", "ccui.TextAtlas:setString")

		return arg_166_0:setString(arg_166_1)
	end
}

rawset(ccui.TextAtlas, "setStringValue", var_0_106.setStringValue)

function var_0_106.getStringValue(arg_167_0)
	var_0_0("ccui.TextAtlas:getStringValue", "ccui.TextAtlas:getString")

	return arg_167_0:getString()
end

rawset(ccui.TextAtlas, "getStringValue", var_0_106.getStringValue)

local var_0_107 = {
	setText = function(arg_168_0, arg_168_1)
		var_0_0("ccui.TextBMFont:setText", "ccui.TextBMFont:setString")

		return arg_168_0:setString(arg_168_1)
	end
}

rawset(ccui.TextBMFont, "setText", var_0_107.setText)

function var_0_107.getStringValue(arg_169_0)
	var_0_0("ccui.Text:getStringValue", "ccui.TextBMFont:getString")

	return arg_169_0:getString()
end

rawset(ccui.Text, "getStringValue", var_0_107.getStringValue)

local var_0_108 = {
	getProgram = function(arg_170_0, arg_170_1)
		var_0_0("cc.ShaderCache:getProgram", "cc.ShaderCache:getGLProgram")

		return arg_170_0:getGLProgram(arg_170_1)
	end
}

rawset(cc.ShaderCache, "getProgram", var_0_108.getProgram)

local var_0_109 = {
	getLeftInParent = function(arg_171_0)
		var_0_0("ccui.Widget:getLeftInParent", "ccui.Widget:getLeftBoundary")

		return arg_171_0:getLeftBoundary()
	end
}

rawset(ccui.Widget, "getLeftInParent", var_0_109.getLeftInParent)

function var_0_109.getBottomInParent(arg_172_0)
	var_0_0("ccui.Widget:getBottomInParent", "ccui.Widget:getBottomBoundary")

	return arg_172_0:getBottomBoundary()
end

rawset(ccui.Widget, "getBottomInParent", var_0_109.getBottomInParent)

function var_0_109.getRightInParent(arg_173_0)
	var_0_0("ccui.Widget:getRightInParent", "ccui.Widget:getRightBoundary")

	return arg_173_0:getRightBoundary()
end

rawset(ccui.Widget, "getRightInParent", var_0_109.getRightInParent)

function var_0_109.getTopInParent(arg_174_0)
	var_0_0("ccui.Widget:getTopInParent", "ccui.Widget:getTopBoundary")

	return arg_174_0:getTopBoundary()
end

rawset(ccui.Widget, "getTopInParent", var_0_109.getTopInParent)

function var_0_109.getSize(arg_175_0)
	var_0_0("ccui.Widget:getSize", "ccui.Widget:getContentSize")

	return arg_175_0:getContentSize()
end

rawset(ccui.Widget, "getSize", var_0_109.getSize)

function var_0_109.setSize(arg_176_0, ...)
	var_0_0("ccui.Widget:setSize", "ccui.Widget:setContentSize")

	return arg_176_0:setContentSize(...)
end

rawset(ccui.Widget, "setSize", var_0_109.setSize)

local var_0_110 = {
	addEventListenerCheckBox = function(arg_177_0, arg_177_1)
		var_0_0("ccui.CheckBox:addEventListenerCheckBox", "ccui.CheckBox:addEventListener")

		return arg_177_0:addEventListener(arg_177_1)
	end
}

rawset(ccui.CheckBox, "addEventListenerCheckBox", var_0_110.addEventListenerCheckBox)

local var_0_111 = {
	addEventListenerSlider = function(arg_178_0, arg_178_1)
		var_0_0("ccui.Slider:addEventListenerSlider", "ccui.Slider:addEventListener")

		return arg_178_0:addEventListener(arg_178_1)
	end
}

rawset(ccui.Slider, "addEventListenerSlider", var_0_111.addEventListenerSlider)

local var_0_112 = {
	addEventListenerTextField = function(arg_179_0, arg_179_1)
		var_0_0("ccui.TextField:addEventListenerTextField", "ccui.TextField:addEventListener")

		return arg_179_0:addEventListener(arg_179_1)
	end
}

rawset(ccui.TextField, "addEventListenerTextField", var_0_112.addEventListenerTextField)

local var_0_113 = {
	addEventListenerPageView = function(arg_180_0, arg_180_1)
		var_0_0("ccui.PageView:addEventListenerPageView", "ccui.PageView:addEventListener")

		return arg_180_0:addEventListener(arg_180_1)
	end
}

rawset(ccui.PageView, "addEventListenerPageView", var_0_113.addEventListenerPageView)

local var_0_114 = {
	addEventListenerScrollView = function(arg_181_0, arg_181_1)
		var_0_0("ccui.ScrollView:addEventListenerScrollView", "ccui.ScrollView:addEventListener")

		return arg_181_0:addEventListener(arg_181_1)
	end
}

rawset(ccui.ScrollView, "addEventListenerScrollView", var_0_114.addEventListenerScrollView)

local var_0_115 = {
	addEventListenerListView = function(arg_182_0, arg_182_1)
		var_0_0("ccui.ListView:addEventListenerListView", "ccui.ListView:addEventListener")

		return arg_182_0:addEventListener(arg_182_1)
	end
}

rawset(ccui.ListView, "addEventListenerListView", var_0_115.addEventListenerListView)
