local var_0_0 = class("ResSwitchScene", require("BaseScene"))

function var_0_0.create(...)
	return lc.createScene(var_0_0, ...)
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.res_switch) then
		return false
	end

	arg_2_0._fromSceneId = arg_2_1
	arg_2_0._toSceneId = arg_2_2
	arg_2_0._input = arg_2_3

	if arg_2_2 == ClientData.SceneId.battle then
		ClientData._fromSceneId = arg_2_1
	end

	if arg_2_2 ~= ClientData.SceneId.battle and P._playerFindDark:isInDarkBattle() then
		if arg_2_1 == ClientData.SceneId.find then
			return
		else
			arg_2_2 = ClientData.SceneId.find
			ClientData._battleFromFindIndex = Data.FindMatchType.dark
		end
	end

	ClientData.loadLCRes("res/bat_loading/bat_loading.lcres")
	arg_2_0:initBackGround()
	GuideManager.stopGuide()

	arg_2_0._isGuideOnEnter = false

	return true
end

function var_0_0.initBackGround(arg_3_0)
	local var_3_0

	arg_3_0._isAd = false

	repeat
		local var_3_1, var_3_2, var_3_3, var_3_4 = ClientData.getServerDate()

		if lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD then
			var_3_0, arg_3_0._bgStr = ClientView.createLoadingBg()

			break
		end

		if var_0_0.batLoadBgIndex ~= nil then
			var_0_0.batLoadBgIndex = var_0_0.batLoadBgIndex < 6 and var_0_0.batLoadBgIndex + 1 or 1
		else
			var_0_0.batLoadBgIndex = math.random(1, 6)
		end

		local var_3_5 = string.format("bat_loading_bg%d", var_0_0.batLoadBgIndex)

		if ClientData.isAnotherSkin() and lc.File:isFileExist(string.format("res/bat_loading/%s.jpg", var_3_5 .. "_2")) then
			var_3_5 = var_3_5 .. "_2"
		end

		arg_3_0._bgStr = string.format(string.format("res/bat_loading/%s.jpg", var_3_5))
		var_3_0 = cc.Sprite:create(arg_3_0._bgStr)
	until true

	var_3_0:setScale(ClientView.SCR_W / var_3_0:getContentSize().width)
	var_3_0:setPosition(ClientView.SCR_CW, ClientView.SCR_CH)
	arg_3_0:addChild(var_3_0)

	local var_3_6 = ClientView.SCR_W / var_3_0:getContentSize().width * var_3_0:getContentSize().height / 2

	for iter_3_0 = 1, 4 do
		local var_3_7 = cc.p(math.floor((iter_3_0 - 1) / 2), iter_3_0 % 2)
		local var_3_8 = cc.Sprite:create("res/bat_loading/bat_loading_frame.jpg")

		var_3_8:setAnchorPoint(var_3_7)
		var_3_8:setFlippedX(var_3_7.x == 0)
		var_3_8:setFlippedY(var_3_7.y == 0)
		var_3_8:setPosition(ClientView.SCR_CW, ClientView.SCR_CH + var_3_6 * (var_3_7.y == 0 and 1 or -1))
		var_3_8:setScale(ClientView.SCR_W / var_3_8:getContentSize().width / 2)
		arg_3_0:addChild(var_3_8)
	end

	local var_3_9 = ccui.Scale9Sprite:createWithSpriteFrameName("bat_load_bar_shade", cc.rect(11, 11, 1, 1))

	var_3_9:setPosition(ClientView.SCR_CW, 110)
	var_3_9:setContentSize(cc.size(600, 48))
	var_3_9:setColor(cc.c3b(12, 15, 30))
	var_3_9:setOpacity(160)
	arg_3_0:addChild(var_3_9, 1)

	local var_3_10 = {}

	for iter_3_1, iter_3_2 in pairs(Data._tipInfo) do
		table.insert(var_3_10, iter_3_2._nameSid)
	end

	local var_3_11 = Str(var_3_10[math.random(1, #var_3_10)])
	local var_3_12 = cc.Label:createWithTTF(var_3_11, ClientView.TTF_FONT, ClientView.FontSize.S1)

	var_3_12:setPosition(ClientView.SCR_CW, 110)
	arg_3_0:addChild(var_3_12, 2)

	arg_3_0._hint = var_3_12

	if var_3_12:getContentSize().width > var_3_9:getContentSize().width - 40 then
		var_3_9:setContentSize(cc.size(var_3_12:getContentSize().width + 40, var_3_9:getContentSize().height))
	end

	local var_3_13 = ccui.Scale9Sprite:createWithSpriteFrameName("bat_load_bar_bg", cc.rect(96, 0, 4, 36))

	var_3_13:setPosition(ClientView.SCR_CW, 60)
	var_3_13:setContentSize(cc.size(624, 36))
	arg_3_0:addChild(var_3_13, 1)

	local var_3_14 = ccui.LoadingBar:create()

	var_3_14:loadTexture("bat_load_bar_fg", ccui.TextureResType.plistType)
	var_3_14:setPosition(ClientView.SCR_CW, 60)
	var_3_14:setScale9Enabled(true)
	var_3_14:setCapInsets(cc.rect(21, 0, 2, 24))
	var_3_14:setContentSize(cc.size(600, 24))
	arg_3_0:addChild(var_3_14, 2)

	arg_3_0._loadingBar = var_3_14
	arg_3_0._loadingPercentage = 0

	arg_3_0:updateLoadingBar()
end

function var_0_0.onEnter(arg_4_0)
	var_0_0.super.onEnter(arg_4_0)

	arg_4_0._listener = lc.addEventListener(Data.Event.resource, function(arg_5_0)
		arg_4_0:onResourceEvent(arg_5_0)
	end)

	if arg_4_0._toSceneId == ClientData.SceneId.battle then
		arg_4_0:loadBattleRes()
	else
		arg_4_0:loadCityUnionRes()
	end
end

function var_0_0.onExit(arg_6_0)
	var_0_0.super.onExit(arg_6_0)
	lc.Dispatcher:removeEventListener(arg_6_0._listener)
end

function var_0_0.onCleanup(arg_7_0)
	var_0_0.super.onCleanup(arg_7_0)

	if lc._runningScene._sceneId ~= ClientData.SceneId.res_switch then
		ClientData.unloadLCRes({
			"bat_loading.jpm",
			"bat_loading.png.sfb"
		})
		lc.TextureCache:removeTextureForKey("res/bat_loading/bat_loading_frame.jpg")
		lc.TextureCache:removeTextureForKey(arg_7_0._bgStr)
	end
end

function var_0_0.updateLoadingBar(arg_8_0)
	arg_8_0._loadingBar:setPercent(arg_8_0._loadingPercentage)
end

function var_0_0.loadBattleRes(arg_9_0)
	arg_9_0._loadingPercentage = 50

	arg_9_0:updateLoadingBar()
	ClientData.unloadCityUnionRes()
	ClientData.loadLCRes("res/battle.lcres")
end

function var_0_0.loadCityUnionRes(arg_10_0)
	arg_10_0._loadingPercentage = 50

	arg_10_0:updateLoadingBar()

	if arg_10_0._fromSceneId == ClientData.SceneId.battle then
		ClientData.unloadBattleRes()
	elseif arg_10_0._toSceneId == ClientData.SceneId.union_world or arg_10_0._toSceneId == ClientData.SceneId.union_war then
		ClientData.unloadCityRes()
	else
		ClientData.unloadUnionRes()
	end

	ClientData.loadLCRes("res/city.lcres")
end

function var_0_0.onResourceEvent(arg_11_0, arg_11_1)
	print("onResourceEvent", 1)

	if not arg_11_0:checkWorking() then
		return
	end

	local var_11_0 = arg_11_1:getUserString()

	print("onResourceEvent", 2, var_11_0)

	if not arg_11_0:updateLoadResProgress(var_11_0) then
		return
	end

	print("onResourceEvent", 3)
	performWithDelay(arg_11_0, function()
		if arg_11_0._toSceneId == ClientData.SceneId.battle and arg_11_0._loadingPercentage == 70 then
			arg_11_0._loadingPercentage = 100

			ClientData.preloadFonts(true)
			arg_11_0:preloadBattleAudio()
			arg_11_0:preloadBattleDragonBones()
		end

		arg_11_0:updateLoadingBar()
		arg_11_0:checkLoadResFinished()
	end, 0.01)
end

function var_0_0.updateLoadResProgress(arg_13_0, arg_13_1)
	if arg_13_1 == "city.png.sfb" or arg_13_1 == "city_2.png.sfb" then
		arg_13_0._loadingPercentage = 100

		return true
	elseif arg_13_1 == "battle.png.sfb" then
		arg_13_0._loadingPercentage = 70

		return true
	end

	return false
end

function var_0_0.checkLoadResFinished(arg_14_0)
	if arg_14_0._loadingPercentage == 100 then
		if arg_14_0._fromSceneId == ClientData.SceneId.battle then
			ClientData.preloadFonts(false)
		end

		performWithDelay(arg_14_0, function()
			arg_14_0:switchScene()
		end, arg_14_0._isAd and 2 or 0.1)
	end
end

function var_0_0.preloadBattleScene(arg_16_0)
	local var_16_0 = arg_16_0._input._sceneType

	if var_16_0 < 11 or var_16_0 > 15 then
		var_16_0 = 1
	end

	local var_16_1 = cc.Sprite:create(string.format("res/bat_scene/bat_scene_%d_bg.jpg", var_16_0))
end

function var_0_0.preloadBattleAudio(arg_17_0)
	if not lc.readConfig(ClientData.USER_CONFIG_EFFECT_KEY, ClientData.USER_CONFIG_EFFECT_DEFAULT) then
		return
	end

	local var_17_0 = {
		"e_card_deal",
		"e_card_using",
		"e_card_board",
		"e_card_hurt",
		"e_card_die",
		"e_book_equip",
		"e_horse_equip"
	}

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		cc.SimpleAudioEngine:getInstance():preloadEffect("res/bat_audio/" .. iter_17_1 .. ".mp3")
	end

	lc.log("preload audio")
end

function var_0_0.preloadBattleDragonBones(arg_18_0)
	local var_18_0 = {
		"xuanzhong",
		"kapaisiwang",
		"beiji"
	}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_1 = cc.DragonBonesNode:createWithDecrypt(string.format("res/effects/%s.lcres", iter_18_1), iter_18_1, iter_18_1)

		ClientData._dragonBonesTexture[iter_18_1] = 1
	end

	lc.log("preload dragonbones")
end

function var_0_0.switchScene(arg_19_0)
	arg_19_0:unscheduleUpdate()

	if not arg_19_0:checkWorking() then
		return
	end

	if arg_19_0._toSceneId == ClientData.SceneId.battle then
		local ok, bs = xpcall(function()
			return require("BattleScene").create(arg_19_0._input)
		end, function(err)
			return debug.traceback(tostring(err), 2)
		end)
		if ok and bs then
			lc.replaceScene(bs)
			ClientData.sendBattleLoadingDone()
		else
			print("[SWITCH SCENE BATTLE ERROR] " .. tostring(bs))
			pcall(function()
				ToastManager.push("Lỗi khởi tạo trận đấu, đang quay về thành...")
				ClientData.replaceCityScene()
			end)
		end
	else
		ClientView.getMenuUI()
		ClientView.getChatPanel()
		ClientView.getResourceUI()

		local var_19_0

		if arg_19_0._toSceneId == ClientData.SceneId.world then
			ClientData.replaceCityScene()
			lc.pushScene(require("WorldScene").create())

			var_19_0 = true
		elseif ClientData._isAutoBattle then
			ClientData.replaceCityScene()
			lc.pushScene(require("FindScene").create(Data.FindMatchType.clash))
		elseif arg_19_0._toSceneId == ClientData.SceneId.factory_monster or arg_19_0._toSceneId == ClientData.SceneId.factory_magic or arg_19_0._toSceneId == ClientData.SceneId.factory_trap or arg_19_0._toSceneId == ClientData.SceneId.factory_rare then
			ClientData.replaceCityScene()
			lc.pushScene(require("CardBoxScene").create(arg_19_0._toSceneId))
		elseif arg_19_0._toSceneId == ClientData.SceneId.manage_troop then
			ClientData.replaceCityScene()
			lc.pushScene(require("HeroCenterScene").create())
		elseif arg_19_0._toSceneId == ClientData.SceneId.union then
			ClientData.replaceCityScene()
			lc.pushScene(require("UnionScene").create())
		elseif arg_19_0._toSceneId == ClientData.SceneId.find then
			ClientData.replaceCityScene()
			lc.pushScene(require("FindScene").create(ClientData._battleFromFindIndex))
		elseif arg_19_0._toSceneId == ClientData.SceneId.in_room then
			ClientData.replaceCityScene()
			lc.pushScene(require("FindScene").create(Data.FindMatchType.clash))
			lc.pushScene(require("InRoomScene").create())
		elseif arg_19_0._toSceneId == ClientData.SceneId.survival_hall then
			ClientData.replaceCityScene()
			lc.pushScene(require("FindScene").create(Data.FindMatchType.survival))
			lc.pushScene(require("SurvivalHallScene").create())
		elseif arg_19_0._toSceneId == ClientData.SceneId.survival_ex_hall then
			ClientData.replaceCityScene()
			lc.pushScene(require("FindScene").create(Data.FindMatchType.survival_ex))
			lc.pushScene(require("SurvivalExHallScene").create())
		elseif arg_19_0._toSceneId == ClientData.SceneId.union_world then
			lc.replaceScene(require("UnionWorldScene").create())
		elseif arg_19_0._toSceneId == ClientData.SceneId.union_war then
			lc.replaceScene(require("UnionWorldScene").create())
			lc.pushScene(require("UnionWarScene").create(ClientData._savedUnionData._city, ClientData._savedUnionData._isAttacking))
		elseif arg_19_0._toSceneId == ClientData.SceneId.tavern then
			ClientData.replaceCityScene()
			lc.pushScene(require("TavernScene").create())
		else
			ClientData.replaceCityScene()

			var_19_0 = true
		end

		if var_19_0 then
			if GuideManager.isGuideEnabled() then
				lc._runningScene._needGuideStartStep = true
			elseif ClientData._battleFromCopy then
				lc.pushScene(require("ExpeditionScene").create())
			else
				local var_19_1 = ClientData._battleFromTravel

				if var_19_1 and (GuideManager.getCurDifficultyStepName() ~= "check duel" or not (P._playerWorld._curLevel[1] > 10104)) and (GuideManager.getCurRecruiteStepName() ~= "check union" or not (P:getMaxCharacterLevel() >= P._playerCity:getUnionUnlockLevel())) then
					require("TravelPanel").create(var_19_1._id):show()
				else
					local var_19_2 = ClientData._battleFromTeach

					if var_19_2 and (GuideManager.getCurDifficultyStepName() ~= "check duel" or not (P._playerWorld._curLevel[1] > 10104)) and (GuideManager.getCurRecruiteStepName() ~= "check union" or not (P:getMaxCharacterLevel() >= P._playerCity:getUnionUnlockLevel())) then
						require("TeachingForm").create(var_19_2):show()
					end
				end
			end
		end

		ClientData._battleFromCopy = nil
		ClientData._battleFromTravel = nil
		ClientData._battleFromTeach = nil
	end
end

function var_0_0.onLogin(arg_20_0)
	if var_0_0.super.onLogin(arg_20_0) then
		return true
	end

	lc.replaceScene(require("LoadingScene").create())

	return true
end

function var_0_0.onEnterSurvivalHall(arg_21_0)
	return
end

function var_0_0.onEnterSurvivalExHall(arg_22_0)
	return
end

return var_0_0
