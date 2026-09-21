lc = lc or {}
lc.App = cc.Application:getInstance()
lc.Director = cc.Director:getInstance()
lc.Dispatcher = lc.Director:getEventDispatcher()
lc.Scheduler = lc.Director:getScheduler()
lc.TextureCache = lc.Director:getTextureCache()
lc.FrameCache = cc.SpriteFrameCache:getInstance()
lc.File = cc.FileUtils:getInstance()
lc.UserDefault = cc.UserDefault:getInstance()
lc.AppStartTime = os.time()
lc.Dir = {
	counter_clockwise = 512,
	vertical = 12,
	left_top = 5,
	left_bottom = 9,
	right_top = 6,
	left = 1,
	none = 0,
	clockwise = 256,
	right_bottom = 10,
	horizontal = 3,
	top = 4,
	bottom = 8,
	right = 2
}
lc.FPS = lc.Director:getAnimationInterval()
lc.PLATFORM = lc.App:getTargetPlatform()
-- cocos2d-html5 does not expose getTargetPlatform(), but the game still
-- needs a stable platform value for feature gates and H5-only fallbacks.
if lc.PLATFORM == nil then
	lc.PLATFORM = cc.PLATFORM_OS_EMSCRIPTEN
end
lc.Color3B = {
	white = cc.c3b(255, 255, 255),
	yellow = cc.c3b(255, 255, 0),
	green = cc.c3b(0, 255, 0),
	blue = cc.c3b(0, 0, 255),
	red = cc.c3b(255, 0, 0),
	magenta = cc.c3b(255, 0, 255),
	black = cc.c3b(0, 0, 0),
	orange = cc.c3b(255, 127, 0),
	gray = cc.c3b(166, 166, 166),
	dark_gray = cc.c3b(50, 50, 50),
	purple = cc.c3b(139, 0, 255),
	light_blue = cc.c3b(80, 80, 192)
}
lc.Color4B = {
	white = cc.c4b(255, 255, 255, 255),
	yellow = cc.c4b(255, 255, 0, 255),
	green = cc.c4b(0, 255, 0, 255),
	blue = cc.c4b(0, 0, 255, 255),
	red = cc.c4b(255, 0, 0, 255),
	magenta = cc.c4b(255, 0, 255, 255),
	black = cc.c4b(0, 0, 0, 255),
	orange = cc.c4b(255, 127, 0, 255),
	gray = cc.c4b(166, 166, 166, 255)
}
lc.Color4F = {
	white = cc.c4f(1, 1, 1, 1),
	yellow = cc.c4f(1, 1, 0, 1),
	green = cc.c4f(0, 1, 0, 1),
	blue = cc.c4f(0, 0, 1, 1),
	red = cc.c4f(1, 0, 0, 1),
	magenta = cc.c4f(1, 0, 1, 1),
	black = cc.c4f(0, 0, 0, 1),
	orange = cc.c4f(1, 0.5, 0, 1),
	gray = cc.c4f(0.65, 0.65, 0.65, 1)
}
bor = bit.bor
bnot = bit.bnot
band = bit.band
bxor = bit.bxor
blsh = bit.lshift
brsh = bit.rshift

function lc.log(...)
	if lc._isReleasePrint == nil then
		if (lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD) and lc.App:getAppId() == "1000000000" then
			lc._isReleasePrint = true
		else
			lc._isReleasePrint = false
		end
	end

	if lc._isReleasePrint then
		release_print(string.format(...))
	else
		print(string.format(...))
	end
end

function lc.dumpTable(arg_2_0, arg_2_1, arg_2_2)
	if type(arg_2_2) ~= "string" then
		arg_2_2 = ""
	end

	if type(arg_2_0) ~= "table" then
		print(arg_2_2 .. tostring(arg_2_0))
	else
		print(arg_2_0)

		if arg_2_1 ~= 0 then
			local var_2_0 = arg_2_2 .. "    "

			print(arg_2_2 .. "{")

			for iter_2_0, iter_2_1 in pairs(arg_2_0) do
				print(var_2_0 .. iter_2_0 .. " = ")

				if type(iter_2_1) ~= "table" or type(arg_2_1) == "number" and arg_2_1 <= 1 then
					print(iter_2_1)
				elseif arg_2_1 == nil then
					lc.dumpTable(iter_2_1, nil, var_2_0)
				else
					lc.dumpTable(iter_2_1, arg_2_1 - 1, var_2_0)
				end
			end

			print(arg_2_2 .. "}")
		end
	end
end

function lc.clearTable(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		arg_3_0[iter_3_0] = nil
	end
end

function lc.str(arg_4_0, arg_4_1)
	local var_4_0 = lc.App:getLanString(arg_4_0)

	if arg_4_1 then
		return string.gsub(var_4_0, "\\n", "\n")
	end

	return var_4_0
end

function lc.hex(arg_5_0)
	arg_5_0 = string.gsub(arg_5_0, ".", function(arg_6_0)
		return string.format("%02X", string.byte(arg_6_0))
	end)

	return arg_5_0
end

function lc.conv(arg_7_0, arg_7_1, arg_7_2)
	return iconv_open(arg_7_2, arg_7_1):iconv(arg_7_0)
end

function lc.round(arg_8_0)
	return math.floor(arg_8_0 + 0.5)
end

function lc.createNode(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = cc.Node:create()

	if arg_9_0 then
		var_9_0:setContentSize(arg_9_0)
	end

	if arg_9_1 then
		var_9_0:setPosition(arg_9_1)
	end

	var_9_0:setAnchorPoint(arg_9_2 or cc.p(0.5, 0.5))

	return var_9_0
end

local CUSTOM_ICON_SPRITES = {
	["img_icon_res1_s"] = "res/new/linh_thach_34.png",
	["res_ico_1"] = "res/new/linh_thach_76.png",
	["img_icon_res3_s"] = "res/new/linh_thach_vip_36.png",
	["res_ico_3"] = "res/new/linh_thach_vip_76.png"
}

function lc.createSprite(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if type(arg_10_0) == "string" and CUSTOM_ICON_SPRITES[arg_10_0] then
		var_10_0 = cc.Sprite:create(CUSTOM_ICON_SPRITES[arg_10_0])
	elseif type(arg_10_0) == "table" then
		local var_10_1 = arg_10_0._crect
		local var_10_2 = arg_10_0._size

		arg_10_0 = arg_10_0._name
		if CUSTOM_ICON_SPRITES[arg_10_0] then
			var_10_0 = cc.Sprite:create(CUSTOM_ICON_SPRITES[arg_10_0])
		else
			var_10_0 = string.find(arg_10_0, "%.") and ccui.Scale9Sprite:create(var_10_1, arg_10_0) or ccui.Scale9Sprite:createWithSpriteFrameName(arg_10_0, var_10_1)
		end

		if var_10_2 then
			var_10_0:setContentSize(var_10_2)
		end
	else
		var_10_0 = string.find(arg_10_0, "%.") and cc.Sprite:create(arg_10_0) or cc.Sprite:createWithSpriteFrameName(arg_10_0)
	end

	if arg_10_1 then
		var_10_0:setPosition(arg_10_1)
	end

	if arg_10_2 then
		var_10_0:setAnchorPoint(arg_10_2)
	end

	return var_10_0
end

function lc.createSpriteWithMask(arg_11_0, arg_11_1, arg_11_2)
	lc.TextureCache:addImageWithMask(arg_11_0)

	return lc.createSprite(arg_11_0, arg_11_1, arg_11_2)
end

function lc.createImageView(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0
	local var_12_1
	local var_12_2

	if type(arg_12_0) == "table" then
		var_12_1 = arg_12_0._crect
		var_12_2 = arg_12_0._size
		arg_12_0 = arg_12_0._name
	end

	local var_12_3 = string.find(arg_12_0, "%.")
	local var_12_4 = ccui.ImageView:create(arg_12_0, var_12_3 and ccui.TextureResType.localType or ccui.TextureResType.plistType)

	var_12_4:setTouchEnabled(true)

	if var_12_2 then
		var_12_4:setContentSize(var_12_2)
	end

	if var_12_1 then
		var_12_4:setScale9Enabled(true)
		var_12_4:setCapInsets(var_12_1)

		if var_12_2 then
			var_12_4:setContentSize(var_12_2)
		end
	end

	function var_12_4.setSpriteFrame(arg_13_0, arg_13_1)
		local var_13_0 = string.find(arg_13_1, "%.")

		arg_13_0:loadTexture(arg_13_1, var_13_0 and ccui.TextureResType.localType or ccui.TextureResType.plistType)
	end

	return var_12_4
end

function lc.createScene(arg_14_0, ...)
	local var_14_0 = arg_14_0.new(lc.EXTEND_LAYER)
	local var_14_1 = cc.Scene:create()

	var_14_0._scene = var_14_1

	if var_14_0:init(...) then
		var_14_1:registerScriptHandler(function(arg_15_0)
			if arg_15_0 == "enter" then
				if var_14_0.onEnter then
					var_14_0:onEnter()
				end
			elseif arg_15_0 == "exit" then
				if var_14_0.onExit then
					var_14_0:onExit()
				end
			elseif arg_15_0 == "cleanup" then
				if var_14_0.onCleanup then
					var_14_0:onCleanup()
				end
			elseif arg_15_0 == "enterTransitionFinish" then
				if var_14_0.onEnterTransitionFinish then
					var_14_0:onEnterTransitionFinish()
				end
			elseif arg_15_0 == "exitTransitionStart" and var_14_0.onExitTransitionStart then
				var_14_0:onExitTransitionStart()
			end
		end)
		var_14_1:addChild(var_14_0)

		var_14_1._layer = var_14_0

		return var_14_1
	end
end

function lc.pushScene(arg_16_0)
	if arg_16_0 then
		lc.Director:pushScene(arg_16_0)
	end
end

function lc.replaceScene(arg_17_0)
	if arg_17_0 then
		lc.Director:replaceScene(arg_17_0)
	end
end

function lc.addEventListener(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = cc.EventListenerCustom:create(arg_18_0, arg_18_1)

	lc.Dispatcher:addEventListenerWithFixedPriority(var_18_0, arg_18_2 or -1)

	return var_18_0
end

function lc.addGestureEventListener(arg_19_0, arg_19_1, arg_19_2)
	assert(arg_19_2, "The node can't be nil when add gesture event listener!")

	local var_19_0 = cc.EventListenerCustom:create(arg_19_0, arg_19_1)

	lc.Dispatcher:addEventListenerWithSceneGraphPriority(var_19_0, arg_19_2)

	return var_19_0
end

function lc.calcDistance(arg_20_0, arg_20_1)
	return math.sqrt((arg_20_0.x - arg_20_1.x)^2 + (arg_20_0.y - arg_20_1.y)^2)
end

function lc.httpRequest(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = cc.XMLHttpRequest:new()

	if arg_21_2 then
		var_21_0:registerScriptHandler(arg_21_2)
	end

	var_21_0:open(arg_21_1, arg_21_0)
	var_21_0:send()

	return var_21_0
end

function lc.readFile(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0

	if lc.PLATFORM == cc.PLATFORM_OS_ANDROID then
		var_22_0 = lc.File:getDataFromFile(arg_22_0, arg_22_1, arg_22_2)
	else
		local var_22_1 = io.open(lc.File:fullPathForFilename(arg_22_0), "rb")

		if var_22_1 == nil then
			return ""
		end

		if arg_22_1 ~= nil then
			var_22_1:seek("set", arg_22_1)
		end

		if arg_22_2 == nil then
			var_22_0 = var_22_1:read("*all")
		else
			var_22_0 = var_22_1:read(arg_22_2)
		end

		var_22_1:close()
	end

	return var_22_0
end

function lc.writeFile(arg_23_0, arg_23_1)
	arg_23_0 = lc.File:fullPathForFilename(arg_23_0)

	local var_23_0 = io.open(arg_23_0, "wb")

	if var_23_0 ~= nil then
		var_23_0:write(arg_23_1)
		var_23_0:close()
	end
end

function lc.resetConfigFile(arg_24_0)
	if lc._configFile == arg_24_0 then
		return
	end

	lc._configFile = arg_24_0

	local var_24_0 = lc.readFile(lc.File:getWritablePath() .. lc._configFile)

	if var_24_0 ~= nil and #var_24_0 > 0 then
		lc._configs = json.decode(var_24_0)
	else
		lc._configs = {}
	end
end

function lc.readConfig(arg_25_0, arg_25_1)
	if lc._configs == nil then lc._configs = {} end
	local var_25_0 = lc._configs[arg_25_0]

	if var_25_0 == nil and arg_25_1 ~= nil then
		var_25_0 = arg_25_1

		lc.writeConfig(arg_25_0, var_25_0)
	end

	return var_25_0
end

function lc.writeConfig(arg_26_0, arg_26_1)
	if lc._configs == nil then lc._configs = {} end
	lc._configs[arg_26_0] = arg_26_1

	local cfgPath = lc.File:getWritablePath() .. (lc._configFile or "config.json")
	lc.writeFile(cfgPath, json.encode(lc._configs))
end

function lc.getUdid()
	return (lc.App:getUdid())
end

function lc.getDeviceInfo()
	if lc.DEVICE_INFO == nil then
		local var_28_0 = {
			model = lc.App:getDeviceModel(),
			memory = lc.App:getSystemMemory(),
			udid = lc.App:getUdid()
		}

		lc.DEVICE_INFO = json.encode(var_28_0)
	end

	return lc.DEVICE_INFO
end

function lc.getRunningTime()
	return os.time() - lc.AppStartTime
end

function lc.w(arg_30_0)
	return arg_30_0:getContentSize().width
end

function lc.cw(arg_31_0)
	return arg_31_0:getContentSize().width / 2
end

function lc.sw(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:getScaleX()

	if arg_32_1 then
		local var_32_1 = arg_32_0:getParent()

		while var_32_1 do
			var_32_0 = var_32_0 * var_32_1:getScaleX()
			var_32_1 = var_32_1:getParent()
		end
	end

	return arg_32_0:getContentSize().width * var_32_0
end

function lc.h(arg_33_0)
	return arg_33_0:getContentSize().height
end

function lc.ch(arg_34_0)
	return arg_34_0:getContentSize().height / 2
end

function lc.sh(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getScaleY()

	if arg_35_1 then
		local var_35_1 = arg_35_0:getParent()

		while var_35_1 do
			var_35_0 = var_35_0 * var_35_1:getScaleY()
			var_35_1 = var_35_1:getParent()
		end
	end

	return arg_35_0:getContentSize().height * var_35_0
end

function lc.x(arg_36_0)
	return arg_36_0:getPositionX()
end

function lc.ax(arg_37_0)
	return arg_37_0:getAnchorPoint().x
end

function lc.y(arg_38_0)
	return arg_38_0:getPositionY()
end

function lc.ay(arg_39_0)
	return arg_39_0:getAnchorPoint().y
end

function lc.left(arg_40_0)
	local var_40_0 = arg_40_0:isIgnoreAnchorPointForPosition() and 0 or lc.ax(arg_40_0)

	return arg_40_0:getPositionX() - var_40_0 * lc.sw(arg_40_0)
end

function lc.right(arg_41_0)
	local var_41_0 = arg_41_0:isIgnoreAnchorPointForPosition() and 0 or lc.ax(arg_41_0)

	return arg_41_0:getPositionX() + (1 - var_41_0) * lc.sw(arg_41_0)
end

function lc.bottom(arg_42_0)
	local var_42_0 = arg_42_0:isIgnoreAnchorPointForPosition() and 0 or lc.ay(arg_42_0)

	return arg_42_0:getPositionY() - var_42_0 * lc.sh(arg_42_0)
end

function lc.top(arg_43_0)
	local var_43_0 = arg_43_0:isIgnoreAnchorPointForPosition() and 0 or lc.ay(arg_43_0)

	return arg_43_0:getPositionY() + (1 - var_43_0) * lc.sh(arg_43_0)
end

function lc.offset(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0, var_44_1 = arg_44_0:getPosition()

	arg_44_0:setPosition(var_44_0 + (arg_44_1 or 0), var_44_1 + (arg_44_2 or 0))

	return arg_44_0
end

function lc.bound(arg_45_0)
	return cc.rect(lc.left(arg_45_0), lc.bottom(arg_45_0), lc.sw(arg_45_0), lc.sh(arg_45_0))
end

function lc.contain(arg_46_0, arg_46_1)
	local var_46_0, var_46_1 = arg_46_0:convertToNodeSpace(arg_46_1)

	if arg_46_0._touchRect then
		var_46_1 = arg_46_0._touchRect
	else
		var_46_1 = cc.rect(0, 0, lc.w(arg_46_0), lc.h(arg_46_0))
	end

	return cc.rectContainsPoint(var_46_1, var_46_0)
end

function lc.contain3D(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_0:convertToNodeSpace3D(arg_47_1, arg_47_2)

	return cc.rectContainsPoint(cc.rect(0, 0, lc.w(arg_47_0), lc.h(arg_47_0)), var_47_0)
end

function lc.convertPos(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_1:convertToWorldSpace(arg_48_0)
	local var_48_1 = arg_48_2 and arg_48_2:convertToNodeSpace(var_48_0) or var_48_0

	var_48_1.x = math.floor(var_48_1.x)
	var_48_1.y = math.floor(var_48_1.y)

	return var_48_1
end

function lc.reverseChildrenPos(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0:getChildren()

	if arg_49_1 == lc.Dir.vertical then
		local var_49_1 = lc.h(arg_49_0)

		for iter_49_0, iter_49_1 in ipairs(var_49_0) do
			iter_49_1:setPositionY(var_49_1 - lc.y(iter_49_1))
		end
	else
		local var_49_2 = lc.w(arg_49_0)

		for iter_49_2, iter_49_3 in ipairs(var_49_0) do
			iter_49_3:setPositionX(var_49_2 - lc.x(iter_49_3))
		end
	end
end

function lc.makeEven(arg_50_0)
	local var_50_0 = math.floor(arg_50_0)

	return var_50_0 % 2 == 0 and var_50_0 or var_50_0 + 1
end

function lc.sendEvent(arg_51_0, arg_51_1)
	local var_51_0 = cc.EventCustom:new(arg_51_0)

	var_51_0._param = arg_51_1

	lc.Dispatcher:dispatchEvent(var_51_0)
end

function lc.addChildToCenter(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = arg_52_1:isIgnoreAnchorPointForPosition() and 0 or lc.ax(arg_52_1)
	local var_52_1 = arg_52_1:isIgnoreAnchorPointForPosition() and 0 or lc.ay(arg_52_1)
	local var_52_2 = cc.p(lc.w(arg_52_0) / 2 + (var_52_0 - 0.5) * lc.sw(arg_52_1), lc.h(arg_52_0) / 2 + (var_52_1 - 0.5) * lc.sh(arg_52_1))

	return lc.addChildToPos(arg_52_0, arg_52_1, var_52_2, arg_52_2, arg_52_3)
end

function lc.addChildToPos(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	arg_53_1:setPosition(arg_53_2)
	arg_53_0:addChild(arg_53_1, arg_53_3 or 0, arg_53_4 or -1)

	return arg_53_1
end

function lc.addNodesToCenter(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5, arg_54_6)
	for iter_54_0 = 1, #arg_54_1 do
		arg_54_0:addChild(arg_54_1[iter_54_0], arg_54_4 or 0, arg_54_5 or -1)
	end

	lc.setNodesToCenter(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_6)
end

function lc.setNodesToCenter(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4, arg_55_5)
	offX = offX or 0

	local var_55_0 = type(arg_55_2) == "table"
	local var_55_1 = type(arg_55_5) == "table"
	local var_55_2 = 0

	for iter_55_0 = 1, #arg_55_1 do
		local var_55_3 = arg_55_1[iter_55_0]

		if var_55_3:isVisible() then
			var_55_2 = var_55_2 + (arg_55_5 and (var_55_1 and arg_55_5[iter_55_0] or arg_55_5) or lc.sw(var_55_3))

			if iter_55_0 < #arg_55_1 then
				var_55_2 = var_55_2 + (var_55_0 and arg_55_2[iter_55_0] or arg_55_2)
			end
		end
	end

	local var_55_4 = lc.makeEven(var_55_2)

	arg_55_4 = arg_55_4 or lc.cw(arg_55_0)

	local var_55_5 = arg_55_4 - var_55_4 / 2

	arg_55_3 = arg_55_3 or lc.h(arg_55_0) / 2

	for iter_55_1 = 1, #arg_55_1 do
		local var_55_6 = arg_55_1[iter_55_1]

		if var_55_6:isVisible() then
			local var_55_7 = arg_55_5 and (var_55_1 and arg_55_5[iter_55_1] or arg_55_5) or lc.sw(var_55_6)

			var_55_6:setPosition(math.floor(var_55_5 + var_55_7 / 2), arg_55_3)

			if iter_55_1 < #arg_55_1 then
				var_55_5 = var_55_5 + var_55_7 + (var_55_0 and arg_55_2[iter_55_1] or arg_55_2)
			end
		end
	end
end

function lc.addNodesToCenterByVertical(arg_56_0, arg_56_1, arg_56_2, arg_56_3, arg_56_4, arg_56_5, arg_56_6)
	local var_56_0 = type(arg_56_2) == "table"
	local var_56_1 = 0

	for iter_56_0 = 1, #arg_56_1 do
		local var_56_2 = arg_56_1[iter_56_0]

		var_56_1 = var_56_1 + lc.sh(var_56_2)

		if iter_56_0 < #arg_56_1 then
			var_56_1 = var_56_1 + (var_56_0 and arg_56_2[iter_56_0] or arg_56_2)
		end
	end

	local var_56_3 = lc.makeEven(var_56_1)
	local var_56_4 = (arg_56_6 or lc.ch(arg_56_0)) - var_56_3 / 2

	arg_56_3 = arg_56_3 or lc.w(arg_56_0) / 2

	for iter_56_1 = 1, #arg_56_1 do
		local var_56_5 = arg_56_1[iter_56_1]

		var_56_5:setPosition(arg_56_3, math.floor(var_56_4 + lc.sh(var_56_5) / 2))
		arg_56_0:addChild(var_56_5, arg_56_4 or 0, arg_56_5 or -1)

		if iter_56_1 < #arg_56_1 then
			var_56_4 = var_56_4 + lc.sh(var_56_5) + (var_56_0 and arg_56_2[iter_56_1] or arg_56_2)
		end
	end
end

function lc.removeChildrenByTag(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:getChildren()
	local var_57_1 = 1

	while var_57_1 <= #var_57_0 do
		local var_57_2 = var_57_0[var_57_1]

		if var_57_2:getTag() == arg_57_1 then
			arg_57_0:removeChild(var_57_2)
		else
			var_57_1 = var_57_1 + 1
		end
	end
end

function lc.changeParent(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	arg_58_1 = arg_58_1 or arg_58_0:getParent()

	if arg_58_1 then
		arg_58_0:retain()
		arg_58_1:removeChild(arg_58_0, false)
		arg_58_2:addChild(arg_58_0, arg_58_3 or arg_58_0:getLocalZOrder(), arg_58_4 or arg_58_0:getTag())
		arg_58_0:release()
	else
		arg_58_2:addChild(arg_58_0, arg_58_3 or arg_58_0:getLocalZOrder(), arg_58_4 or arg_58_0:getTag())
	end
end

function lc.frameSize(arg_59_0)
	if arg_59_0 == nil then return cc.size(32, 32) end
	local var_59_0 = lc.FrameCache:getSpriteFrame(arg_59_0)
	if var_59_0 then
		return var_59_0:getOriginalSize()
	end
	if string.find(tostring(arg_59_0), "card_quality") then
		return cc.size(25, 26)
	end
	return cc.size(32, 32)
end

function lc.createMaskLayer(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = ccui.Layout:create()

	lc.initMaskLayer(var_60_0, arg_60_0, arg_60_1, arg_60_2)

	return var_60_0
end

function lc.initMaskLayer(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	arg_61_0:setContentSize(arg_61_3 or lc.Director:getVisibleSize())
	arg_61_0:setTouchEnabled(true)
	arg_61_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	arg_61_0:setBackGroundColor(arg_61_2 or lc.Color3B.black)
	arg_61_0:setBackGroundColorOpacity(arg_61_1 or 200)
end

function lc.splitText(arg_62_0)
	local var_62_0 = {}
	local var_62_1 = 1

	while var_62_1 <= string.len(arg_62_0) do
		local var_62_2 = string.byte(arg_62_0, var_62_1)

		if var_62_2 < 128 then
			table.insert(var_62_0, string.char(var_62_2))

			var_62_1 = var_62_1 + 1
		else
			table.insert(var_62_0, string.char(var_62_2, string.byte(arg_62_0, var_62_1 + 1), string.byte(arg_62_0, var_62_1 + 2)))

			var_62_1 = var_62_1 + 3
		end
	end

	return var_62_0
end

function lc.getTableCount(arg_63_0)
	local var_63_0 = next(arg_63_0)
	local var_63_1 = 0

	while var_63_0 do
		var_63_1 = var_63_1 + 1
		var_63_0 = next(arg_63_0, var_63_0)
	end

	return var_63_1
end

function lc.arrayAt(arg_64_0, arg_64_1)
	if arg_64_1 > #arg_64_0 then
		return arg_64_0[#arg_64_0]
	elseif arg_64_1 < 0 then
		local var_64_0 = #arg_64_0 + (arg_64_1 + 1)

		return var_64_0 < 1 and arg_64_0[1] or arg_64_0[var_64_0]
	else
		return arg_64_0[arg_64_1]
	end
end

function lc.arrayToTable(arg_65_0, arg_65_1, arg_65_2)
	local var_65_0 = {}
	local var_65_1 = {}

	for iter_65_0, iter_65_1 in ipairs(arg_65_0) do
		if arg_65_2 == nil or arg_65_2(iter_65_1) then
			if arg_65_1 > #var_65_1 then
				table.insert(var_65_1, iter_65_1)
			else
				table.insert(var_65_0, var_65_1)

				var_65_1 = {
					iter_65_1
				}
			end
		end
	end

	if #var_65_1 > 0 then
		table.insert(var_65_0, var_65_1)
	end

	return var_65_0
end

function lc.reorderToArray(arg_66_0, arg_66_1)
	local var_66_0 = {}
	local var_66_1, var_66_2 = next(arg_66_0)

	while var_66_1 do
		table.insert(var_66_0, var_66_2)

		var_66_1, var_66_2 = next(arg_66_0, var_66_1)
	end

	table.sort(var_66_0, arg_66_1)

	return var_66_0
end

function lc.absTime(arg_67_0)
	return arg_67_0 * cc.Director:getInstance():getScheduler():getTimeScale()
end

function lc.utf8CharSize(arg_68_0)
	if not arg_68_0 then
		return 0
	elseif arg_68_0 >= 240 then
		return 4
	elseif arg_68_0 >= 224 then
		return 3
	elseif arg_68_0 >= 192 then
		return 2
	else
		return 1
	end
end

function lc.utf8len(arg_69_0)
	local var_69_0 = 0
	local var_69_1 = 1

	while var_69_1 <= #arg_69_0 do
		local var_69_2 = string.byte(arg_69_0, var_69_1)

		var_69_1 = var_69_1 + lc.utf8CharSize(var_69_2)
		var_69_0 = var_69_0 + 1
	end

	return var_69_0
end

function lc.getUtf8Char(arg_70_0, arg_70_1)
	local var_70_0 = 1
	local var_70_1 = 1

	while var_70_0 <= #arg_70_0 do
		local var_70_2 = string.byte(arg_70_0, var_70_0)
		local var_70_3 = lc.utf8CharSize(var_70_2)

		if var_70_1 == arg_70_1 then
			return string.sub(arg_70_0, 1, var_70_0 + var_70_3 - 1)
		end

		var_70_0, var_70_1 = var_70_0 + var_70_3, var_70_1 + 1
	end

	return ""
end

local function var_0_0(arg_71_0)
	if #arg_71_0 == 1 then
		return arg_71_0[1]
	elseif #arg_71_0 == 2 then
		return {
			x = arg_71_0[1],
			y = arg_71_0[2]
		}
	end
end

function lc.moveTo(arg_72_0, ...)
	return cc.MoveTo:create(arg_72_0, var_0_0({
		...
	}))
end

function lc.moveBy(arg_73_0, ...)
	return cc.MoveBy:create(arg_73_0, var_0_0({
		...
	}))
end

function lc.scaleTo(arg_74_0, ...)
	return cc.ScaleTo:create(arg_74_0, ...)
end

function lc.scaleBy(arg_75_0, ...)
	return cc.ScaleBy:create(arg_75_0, ...)
end

function lc.rotateTo(arg_76_0, ...)
	local var_76_0 = {
		...
	}

	if #var_76_0 == 3 then
		return cc.RotateTo:create(arg_76_0, {
			x = var_76_0[1],
			y = var_76_0[2],
			z = var_76_0[3]
		})
	else
		return cc.RotateTo:create(arg_76_0, ...)
	end
end

function lc.rotateBy(arg_77_0, ...)
	local var_77_0 = {
		...
	}

	if #var_77_0 == 3 then
		return cc.RotateBy:create(arg_77_0, {
			x = var_77_0[1],
			y = var_77_0[2],
			z = var_77_0[3]
		})
	else
		return cc.RotateBy:create(arg_77_0, ...)
	end
end

function lc.tintTo(arg_78_0, ...)
	return cc.TintTo:create(arg_78_0, ...)
end

function lc.tintBy(arg_79_0, ...)
	local var_79_0 = {
		...
	}

	if #var_79_0 == 1 then
		return cc.RotateBy:create(arg_79_0, var_79_0[1].r, var_79_0[1].g, var_79_0[1].b)
	else
		return cc.RotateBy:create(arg_79_0, ...)
	end
end

function lc.fadeIn(arg_80_0)
	return cc.FadeIn:create(arg_80_0)
end

function lc.fadeOut(arg_81_0)
	return cc.FadeOut:create(arg_81_0)
end

function lc.fadeTo(arg_82_0, arg_82_1)
	return cc.FadeTo:create(arg_82_0, arg_82_1)
end

function lc.delay(arg_83_0)
	return cc.DelayTime:create(arg_83_0)
end

function lc.show()
	return cc.Show:create()
end

function lc.hide()
	return cc.Hide:create()
end

function lc.remove(...)
	return cc.RemoveSelf:create(...)
end

function lc.place(...)
	return cc.Place:create(var_0_0({
		...
	}))
end

function lc.call(arg_88_0)
	return cc.CallFunc:create(arg_88_0)
end

function lc.ease(arg_89_0, arg_89_1, arg_89_2)
	local var_89_0 = {
		I = {
			cc.EaseIn,
			2,
			1
		},
		O = {
			cc.EaseOut,
			2,
			1
		},
		IO = {
			cc.EaseIn,
			2,
			1
		},
		BackI = {
			cc.EaseBackIn,
			1
		},
		BackO = {
			cc.EaseBackOut,
			1
		},
		BackIO = {
			cc.EaseBackInOut,
			1
		},
		BounceI = {
			cc.EaseBounceIn,
			1
		},
		BounceO = {
			cc.EaseBounceOut,
			1
		},
		BounceIO = {
			cc.EaseBounceInOut,
			1
		},
		ElasticI = {
			cc.EaseElasticIn,
			2,
			0.3
		},
		ElasticO = {
			cc.EaseElasticOut,
			2,
			0.3
		},
		ElasticIO = {
			cc.EaseElasticInOut,
			2,
			0.3
		},
		SineI = {
			cc.EaseSineIn,
			1
		},
		SineO = {
			cc.EaseSineOut,
			1
		},
		SineIO = {
			cc.EaseSineInOut,
			1
		}
	}
	local var_89_1

	if var_89_0[arg_89_1] then
		local var_89_2, var_89_3, var_89_4 = unpack(var_89_0[arg_89_1])

		if var_89_3 == 2 then
			var_89_1 = var_89_2:create(arg_89_0, arg_89_2 or var_89_4)
		else
			var_89_1 = var_89_2:create(arg_89_0)
		end
	end

	return var_89_1
end

function lc.animate(arg_90_0, arg_90_1, arg_90_2)
	local var_90_0 = {}
	local var_90_1 = 1
	local var_90_2 = string.format("%s_%02d", arg_90_0, var_90_1)

	while lc.FrameCache:getSpriteFrame(var_90_2) do
		table.insert(var_90_0, #var_90_0 + 1, var_90_2)

		var_90_1 = var_90_1 + 1
		var_90_2 = string.format("%s_%02d", arg_90_0, var_90_1)
	end

	return var_90_0
end

function lc.sequence(...)
	local var_91_0 = {
		...
	}
	local var_91_1 = {}

	for iter_91_0 = 1, #var_91_0 do
		local var_91_2 = var_91_0[iter_91_0]

		if type(var_91_2) == "function" then
			var_91_2 = lc.call(var_91_2)
		elseif type(var_91_2) == "number" then
			var_91_2 = lc.delay(var_91_2)
		elseif type(var_91_2) == "table" then
			var_91_2 = lc.spawn(unpack(var_91_2))
		end

		table.insert(var_91_1, var_91_2)
	end

	return cc.Sequence:create(var_91_1)
end

function lc.spawn(...)
	local var_92_0 = {
		...
	}
	local var_92_1 = {}

	for iter_92_0 = 1, #var_92_0 do
		local var_92_2 = var_92_0[iter_92_0]

		if type(var_92_2) == "function" then
			var_92_2 = lc.call(var_92_2)
		elseif type(var_92_2) == "number" then
			var_92_2 = lc.delay(var_92_2)
		elseif type(var_92_2) == "table" then
			var_92_2 = lc.sequence(unpack(var_92_2))
		end

		table.insert(var_92_1, var_92_2)
	end

	return cc.Spawn:create(var_92_1)
end

function lc.rep(arg_93_0, arg_93_1)
	if arg_93_1 then
		return cc.Repeat:create(arg_93_0, arg_93_1)
	else
		return cc.RepeatForever:create(arg_93_0)
	end
end

getmetatable("").__index = function(arg_94_0, arg_94_1)
	if type(arg_94_1) == "number" then
		return string.sub(arg_94_0, arg_94_1, arg_94_1)
	else
		return string[arg_94_1]
	end
end

function string.split(arg_95_0, arg_95_1)
	arg_95_0 = arg_95_0 .. arg_95_1

	return {
		arg_95_0:match((arg_95_0:gsub("[^" .. arg_95_1 .. "]*" .. arg_95_1, "([^" .. arg_95_1 .. "]*)" .. arg_95_1)))
	}
end

function string.trim(arg_96_0)
	return (string.gsub(arg_96_0, "^%s*(.-)%s*$", "%1"))
end

function lc.formatJpg(arg_97_0)
	return string.format("res/jpg/%s.jpg", arg_97_0)
end

function lc.formatBones(arg_98_0)
	return string.format("res/effects/%s.lcres", arg_98_0)
end

function lc.formatDate(arg_99_0)
	local var_99_0 = os.date("*t", arg_99_0)

	return string.format(Str(STR.DATE_TIME_FORMAT), var_99_0.month, var_99_0.day, var_99_0.hour, var_99_0.min)
end

function lc.runCode(arg_100_0)
	if #arg_100_0 > 0 then
		local var_100_0, var_100_1 = pcall(function()
			local var_101_0, var_101_1 = loadstring(arg_100_0)

			if var_101_0 == nil then
				return string.format("parse patch error: %s", var_101_1)
			end

			return var_101_0()
		end)

		if var_100_0 then
			var_100_1 = var_100_1 and tostring(var_100_1) or "execute ok"

			lc.log(var_100_1)
		end

		return var_100_1
	else
		return "[ERROR] Empty code!"
	end
end

function table.contain(arg_102_0, arg_102_1)
	for iter_102_0, iter_102_1 in pairs(arg_102_0) do
		if iter_102_1 == arg_102_1 then
			return iter_102_0
		end
	end
end

function lc.getAngle(arg_103_0, arg_103_1)
	if arg_103_1.x - arg_103_0.x == 0 then
		return 0
	end

	return math.deg(cc.pGetAngle(cc.pSub(arg_103_0, arg_103_1), cc.p(0, 1)))
end

function table.removeByCondition(arg_104_0, arg_104_1)
	local var_104_0 = false
	local var_104_1 = 1
	local var_104_2 = #arg_104_0

	for iter_104_0 = 1, var_104_2 do
		local var_104_3 = arg_104_0[iter_104_0]

		if not arg_104_1(var_104_3) then
			arg_104_0[var_104_1] = var_104_3
			var_104_1 = var_104_1 + 1
		else
			var_104_0 = true
		end
	end

	for iter_104_1 = var_104_1, var_104_2 do
		arg_104_0[iter_104_1] = nil
	end

	return var_104_0
end
