local var_0_0 = require("Socket_pb")
local var_0_1 = class("LoadingScene", require("BaseScene"))
local var_0_2 = 0.02

function var_0_1.create()
	return lc.createScene(var_0_1)
end

function var_0_1.init(arg_2_0)
	if not var_0_1.super.init(arg_2_0, ClientData.SceneId.loading) then
		return false
	end

	local var_2_0 = lc.File:getStringFromFile("res/updater/loading.plist")
	local var_2_1 = lc.TextureCache:addImage("res/updater/loading.pvr.ccz")

	lc.FrameCache:addSpriteFramesWithFileContent(var_2_0, var_2_1)
	lc.UserDefault:setBoolForKey(ClientData.ConfigKey.agreement, true)

	local var_2_2 = ClientView.createBMFont(ClientView.BMFont.huali_20, Str(STR.VERSION) .. ClientData.getDisplayVersion())

	var_2_2:setScale(0.8)
	lc.addChildToPos(arg_2_0, var_2_2, cc.p(ClientView.SCR_W - lc.cw(var_2_2) - ClientView.SCR_EDGE, 20), 2)

	if not ClientData.isAppStoreReviewing() then
		for iter_2_0 = 1, 3 do
			local var_2_3 = ClientView.createBMFont(ClientView.BMFont.huali_20, Str(STR.ISBN + iter_2_0 - 1, true))

			var_2_3:setAnchorPoint(0, 0.5)
			var_2_3:setScale(0.8)
			lc.addChildToPos(arg_2_0, var_2_3, cc.p(ClientView.SCR_EDGE + 16 + (iter_2_0 == 3 and 2 or 0), 80 - iter_2_0 * 20), 2)
		end
	end

	local var_2_4 = ClientView.createLoadingBg()

	var_2_4:setPosition(ClientView.SCR_CW, ClientView.SCR_CH)

	if ClientData.isAppStoreReviewing() then
		arg_2_0:addChild(var_2_4, 3)
	else
		arg_2_0:addChild(var_2_4)
	end

	local var_2_5 = ccui.Scale9Sprite:createWithSpriteFrameName("load_bar_shade", cc.rect(11, 11, 1, 1))

	var_2_5:setPosition(ClientView.SCR_CW, 110)
	var_2_5:setContentSize(cc.size(600, 48))
	var_2_5:setColor(cc.c3b(12, 15, 30))
	var_2_5:setOpacity(128)
	arg_2_0:addChild(var_2_5, 1)

	arg_2_0._hintPrefix = ClientData._userRegion._name

	local var_2_6 = cc.Label:createWithTTF(Str(STR.CONNECTING) .. arg_2_0._hintPrefix, ClientView.TTF_FONT, ClientView.FontSize.S1)

	var_2_6:setPosition(ClientView.SCR_CW, 110)
	arg_2_0:addChild(var_2_6, 2)

	arg_2_0._hint = var_2_6

	local var_2_7 = ccui.Scale9Sprite:createWithSpriteFrameName("load_bar_bg", cc.rect(96, 0, 4, 36))

	var_2_7:setPosition(ClientView.SCR_CW, 60)
	var_2_7:setContentSize(cc.size(624, 36))
	arg_2_0:addChild(var_2_7, 1)

	local var_2_8 = ccui.LoadingBar:create()

	var_2_8:loadTexture("load_bar_fg", ccui.TextureResType.plistType)
	var_2_8:setPosition(ClientView.SCR_CW, 60)
	var_2_8:setScale9Enabled(true)
	var_2_8:setCapInsets(cc.rect(21, 0, 2, 24))
	var_2_8:setContentSize(cc.size(600, 24))
	arg_2_0:addChild(var_2_8, 2)

	arg_2_0._loadingBar = var_2_8
	arg_2_0._loadingPercentage = 5

	arg_2_0:updateLoadingBar()

	local var_2_9 = ClientView.createTTF(Str(STR.GAME_ANNOUNCE, true), 18, cc.c3b(0, 0, 0), cc.size(600, 0), cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)

	var_2_9:setAnchorPoint(0.5, 1)
	lc.addChildToPos(arg_2_0, var_2_9, cc.p(ClientView.SCR_CW, ClientView.SCR_H - 28))
	lc.TextureCache:addImageWithMask("res/jpg/load_btn_agreement.jpg")
	lc.TextureCache:addImageWithMask("res/jpg/load_btn_server.jpg")

	if ClientData.isShowAgreement() then
		local var_2_10 = ClientView.createShaderButton("res/jpg/load_btn_agreement.jpg", ClientView.openUserProtocol)

		lc.addChildToPos(var_2_10, ClientView.fitLabel(ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.AGREEMENT)), lc.w(var_2_10) - 6, 0.4), cc.p(lc.w(var_2_10) / 2, 20))
		lc.addChildToPos(arg_2_0, var_2_10, cc.p(ClientView.SCR_W - 12 - lc.w(var_2_10) / 2 - ClientView.SCR_EDGE, ClientView.SCR_H - 20 - lc.h(var_2_10) / 2))
	end

	local var_2_11 = ClientView.createShaderButton("res/jpg/load_btn_server.jpg", function(arg_3_0)
		arg_3_0:setEnabled(false)
		ClientData.switchToRegionScene()
	end)

	lc.addChildToPos(var_2_11, ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.SELECT_SERVER)), cc.p(lc.w(var_2_11) / 2, 20))
	lc.addChildToPos(arg_2_0, var_2_11, cc.p(ClientView.SCR_W - 12 - lc.w(var_2_11) / 2 - ClientView.SCR_EDGE, ClientView.SCR_H - 20 - lc.h(var_2_11) / 2 - (ClientData.isShowAgreement() and lc.h(var_2_11) or 0)))
	GuideManager.stopGuide()

	arg_2_0._isGuideOnEnter = false

	NoticeManager.init()

	return true
end

function var_0_1.onEnter(arg_4_0)
	var_0_1.super.onEnter(arg_4_0)
	GuideManager.releaseLayer()

	arg_4_0._listener = lc.addEventListener(Data.Event.resource, function(arg_5_0)
		arg_4_0:onResourceEvent(arg_5_0)
	end)
	arg_4_0._isInBattle = false
	arg_4_0._isInRoom = false

	lc.Audio.playAudio(AUDIO.M_LOADING)
	ClientData.reconnectGameServer()
end

function var_0_1.onExit(arg_6_0)
	var_0_1.super.onExit(arg_6_0)
	lc.Dispatcher:removeEventListener(arg_6_0._listener)
end

function var_0_1.onCleanup(arg_7_0)
	var_0_1.super.onCleanup(arg_7_0)

	if lc._runningScene._sceneId == ClientData.SceneId.city or lc._runningScene._sceneId == ClientData.SceneId.battle then
		arg_7_0:removeAllChildren()
		ClientData.unloadLoadingRes()
	end
end

function var_0_1.onMsgErrorStatus(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.type

	lc.log("msgType:%d msgStatus:%d", var_8_0, arg_8_2)

	if var_8_0 ~= SglMsgType_pb.PB_TYPE_USER_LOGIN or var_8_0 == SglMsgType_pb.PB_TYPE_USER_REGISTER or var_8_0 == SglMsgType_pb.PB_TYPE_HEART_BEAT then
		if arg_8_2 == SglMsg_pb.PB_STATUS_USER_UNDER_ATTACK then
			arg_8_0._isInBattle = true

			local var_8_1 = arg_8_1.Extensions[User_pb.SglUserMsg.user_under_attack_resp]
			local var_8_2 = string.format(Str(STR.UNDER_ATTACKING), var_8_1.name)

			arg_8_0._hint:setString(var_8_2)

			return true
		elseif arg_8_2 == SglMsg_pb.PB_STATUS_BATTLE_RECOVER then
			arg_8_0._isInBattle = true

			arg_8_0._hint:setString(Str(STR.RECOVER_BATTLE))

			return true
		elseif arg_8_2 == SglMsg_pb.PB_STATUS_BATTLE_JOIN_NOT_ALLOWED then
			arg_8_0._isInBattle = false

			if not arg_8_0._isInRoom and not arg_8_0._isInSurvivalHall and not arg_8_0._isInSurvivalExHall then
				arg_8_0._hint:setString(Str(STR.LOADING_DATA) .. arg_8_0._hintPrefix)
				arg_8_0:loadResStart()
			end

			return true
		elseif arg_8_2 == SglMsg_pb.PB_STATUS_MATCH_JOIN_NOT_ALLOWED then
			arg_8_0._isInRoom = false

			arg_8_0._hint:setString(Str(STR.LOADING_DATA) .. arg_8_0._hintPrefix)
			arg_8_0:loadResStart()

			return true
		elseif arg_8_2 == SglMsg_pb.PB_STATUS_SURVIVAL_JOIN_NOT_ALLOWED then
			arg_8_0._isInSurvivalHall = false

			P._playerFindSurvival:clear()
			arg_8_0._hint:setString(Str(STR.LOADING_DATA) .. arg_8_0._hintPrefix)
			arg_8_0:loadResStart()

			return true
		end
	end

	return var_0_1.super.onMsgErrorStatus(arg_8_0, arg_8_1, arg_8_2)
end

function var_0_1.onLogin(arg_9_0)
	if P._guideID < 100 then
		if ClientData._skipTutorial then
			-- Skip only the tutorial battle. Guide 101 is the game's own
			-- character/name setup checkpoint; CityScene handles it.
			P._guideID = 101
			ClientData.sendGuideID(101)
		else
			local var_9_0 = math.floor(P._guideID / 10)

			if var_9_0 == 0 then
				var_9_0 = 1
			end

			P._guideID = var_9_0 * 10 + 1
			arg_9_0._isInBattle = true
			arg_9_0._input = ClientData.genInputFromGuidance(var_9_0)

			lc.writeConfig(ClientData.ConfigKey.battle_need_manual_guide, true)
		end
	end

	arg_9_0._hint:setString(Str(STR.LOADING_DATA) .. arg_9_0._hintPrefix)
	arg_9_0:loadResStart()
end

function var_0_1.onIdle(arg_10_0)
	lc.Director:updateTouchTimestamp()
end

function var_0_1.onBattleRecover(arg_11_0, arg_11_1)
	arg_11_0._input = arg_11_1
	arg_11_0._isInBattle = true

	arg_11_0._hint:setString(Str(STR.PREPARE_LIVE_BATTLE))
	arg_11_0:loadResStart()
end

function var_0_1.onEnterRoom(arg_12_0, arg_12_1)
	if not P._playerRoom:getMyRoom() then
		arg_12_0._isInRoom = false

		arg_12_0:onLogin()
	else
		arg_12_0._isInRoom = true

		arg_12_0._hint:setString(Str(STR.PREPARE_ENTER_ROOM))
		arg_12_0:loadResStart()
	end
end

function var_0_1.onEnterSurvivalHall(arg_13_0)
	if not P._playerFindSurvival._isInHall then
		arg_13_0._isInSurvivalHall = false

		arg_13_0:onLogin()
	else
		arg_13_0._isInSurvivalHall = true

		arg_13_0._hint:setString(Str(STR.PREPARE_ENTER_SURVIVAL))
		arg_13_0:loadResStart()
	end
end

function var_0_1.onEnterSurvivalExHall(arg_14_0)
	if not P._playerFindSurvivalEx._isInHall then
		arg_14_0._isInSurvivalExHall = false

		arg_14_0:onLogin()
	else
		arg_14_0._isInSurvivalExHall = true

		arg_14_0._hint:setString(Str(STR.PREPARE_ENTER_SURVIVAL_EX))
		arg_14_0:loadResStart()
	end
end

function var_0_1.onBattleWait(arg_15_0)
	arg_15_0._isInBattle = true

	arg_15_0._hint:setString(Str(STR.WAIT_BATTLE_RESULT))
end

function var_0_1.onResourceEvent(arg_16_0, arg_16_1)
	if not arg_16_0:checkWorking() then
		return
	end

	local var_16_0 = arg_16_1:getUserString()

	if not arg_16_0:updateLoadResProgress(var_16_0) then
		return
	end

	performWithDelay(arg_16_0, function()
		if arg_16_0._loadingPercentage == 10 then
			ClientData.loadLCRes("res/cards_back.lcres")
		elseif arg_16_0._loadingPercentage == 12 then
			ClientData.loadLCRes("res/cards_back2.lcres")
		elseif arg_16_0._loadingPercentage == 13 then
			ClientData.loadLCRes("res/cards_back3.lcres")
		elseif arg_16_0._loadingPercentage == 14 then
			ClientData.loadLCRes("res/cards_back4.lcres")
		elseif arg_16_0._loadingPercentage == 15 then
			ClientData.loadLCRes("res/props.lcres")
		elseif arg_16_0._loadingPercentage == 16 then
			ClientData.loadLCRes("res/general.lcres")
		elseif arg_16_0._loadingPercentage >= 20 and arg_16_0._loadingPercentage < 35 then
			local var_17_0 = arg_16_0._loadingPercentage - 19

			ClientData.loadLCRes("res/cards_img_" .. var_17_0 .. ".lcres")
		elseif not arg_16_0._isInBattle then
			if arg_16_0._loadingPercentage == 65 then
				if ClientData.DEBUG_UNION then
					ClientData.loadLCRes("res/union_war.lcres")
				else
					ClientData.loadLCRes("res/city.lcres")
				end
			elseif arg_16_0._loadingPercentage == 90 then
				if ClientData.DEBUG_UNION then
					lc.TextureCache:addImage("res/jpg/union_world_bg.jpg")
					lc.TextureCache:addImage("res/jpg/union_war_bg.jpg")
				else
					lc.TextureCache:addImage("res/jpg/world_bg.jpg")
					lc.TextureCache:addImage("res/jpg/legend_bg.jpg")
				end

				arg_16_0._loadingPercentage = 100
				arg_16_0._basePercentage = arg_16_0._loadingPercentage
			end
		elseif arg_16_0._loadingPercentage == 65 then
			ClientData.loadLCRes("res/battle.lcres")
		elseif arg_16_0._loadingPercentage == 80 then
			local var_17_1 = 1

			if arg_16_0._input then
				var_17_1 = arg_16_0._input._sceneType
			end

			local var_17_2 = cc.Sprite:create(string.format("res/bat_scene/bat_scene_%d_bg.jpg", var_17_1))
		elseif arg_16_0._loadingPercentage == 90 then
			arg_16_0._loadingPercentage = 100
			arg_16_0._basePercentage = arg_16_0._loadingPercentage
		end

		arg_16_0:updateLoadingBar()
		arg_16_0:checkLoadResFinished()
	end, 0.01)
end

function var_0_1.updateLoadingBar(arg_18_0)
	arg_18_0._loadingBar:setPercent(arg_18_0._loadingPercentage)

	if arg_18_0._loadingBarHead then
		arg_18_0._loadingBarHead:setPositionX(lc.x(arg_18_0._loadingBar) + arg_18_0._loadingPercentage * 6 - 300 - 10)
	end
end

function var_0_1.loadResStart(arg_19_0)
	if not arg_19_0._loadingRes then
		arg_19_0._loadingRes = true

		ClientData.loadLCRes("res/avatar.lcres")
	end
end

function var_0_1.updateLoadResProgress(arg_20_0, arg_20_1)
	if arg_20_1 == "avatar.png.sfb" then
		arg_20_0._loadingPercentage = 10

		return true
	elseif arg_20_1 == "cards_back.png.sfb" then
		arg_20_0._loadingPercentage = 12

		return true
	elseif arg_20_1 == "cards_back2.png.sfb" then
		arg_20_0._loadingPercentage = 13

		return true
	elseif arg_20_1 == "cards_back3.png.sfb" then
		arg_20_0._loadingPercentage = 14

		return true
	elseif arg_20_1 == "cards_back4.png.sfb" then
		arg_20_0._loadingPercentage = 15

		return true
	elseif arg_20_1 == "props.png.sfb" then
		arg_20_0._loadingPercentage = 16

		return true
	elseif arg_20_1 == "general.png.sfb" then
		arg_20_0._loadingPercentage = 20

		return true
	elseif arg_20_1 == "cards_img_" .. ClientData.CARDS_IMG_COUNT .. ".png.sfb" then
		arg_20_0._loadingPercentage = 65

		return true
	elseif string.hasPrefix(arg_20_1, "cards_img_") and string.hasSuffix(arg_20_1, ".png.sfb") then
		arg_20_0._loadingPercentage = arg_20_0._loadingPercentage + 1

		return true
	elseif string.hasPrefix(arg_20_1, "cards_") and string.hasSuffix(arg_20_1, ".png.sfb") then
		arg_20_0._loadingPercentage = arg_20_0._loadingPercentage + 1

		return true
	elseif arg_20_1 == "city.png.sfb" or arg_20_1 == "city_2.png.sfb" then
		arg_20_0._loadingPercentage = 90

		return true
	elseif arg_20_1 == "battle.png.sfb" then
		arg_20_0._loadingPercentage = 90

		return true
	end

	return false
end

function var_0_1.checkLoadResFinished(arg_21_0)
	if arg_21_0._loadingPercentage == 100 then
		for iter_21_0, iter_21_1 in ipairs(ClientView.BMFONTS_COMMON) do
			local var_21_0 = cc.Label:createWithBMFont(iter_21_1, "")
		end

		if not arg_21_0._isInBattle then
			for iter_21_2, iter_21_3 in ipairs(ClientView.BMFONTS_CITY) do
				local var_21_1 = cc.Label:createWithBMFont(iter_21_3, "")
			end
		else
			for iter_21_4, iter_21_5 in ipairs(ClientView.BMFONTS_BATTLE) do
				local var_21_2 = cc.Label:createWithBMFont(iter_21_5, "")
			end

			ClientData._dragonBonesTexture = {}

			local var_21_3 = {
				"xuanzhong",
				"kapaisiwang",
				"beiji"
			}

			for iter_21_6, iter_21_7 in ipairs(var_21_3) do
				local var_21_4 = cc.DragonBonesNode:createWithDecrypt(string.format("res/effects/%s.lcres", iter_21_7), iter_21_7, iter_21_7)

				ClientData._dragonBonesTexture[iter_21_7] = 1
			end

			ClientData._battleAudio = {}

			local var_21_5 = {
				"e_card_deal",
				"e_card_using",
				"e_card_board",
				"e_card_hurt",
				"e_card_die",
				"e_book_equip",
				"e_horse_equip"
			}

			for iter_21_8, iter_21_9 in ipairs(var_21_5) do
				local var_21_6 = "res/bat_audio/" .. iter_21_9 .. ".mp3"

				cc.SimpleAudioEngine:getInstance():preloadEffect(var_21_6)
			end
		end

		require("ResourcePanel")
		require("IconWidget")
		require("CardThumbnail").createPool()

		if P._guideID == 11 then
			arg_21_0:screenShot()
		end

		performWithDelay(arg_21_0, function()
			arg_21_0:switchScene()
		end, 0.1)
	end
end

function var_0_1.switchScene(arg_23_0)
	arg_23_0:unscheduleUpdate()

	if not arg_23_0:checkWorking() then
		return
	end

	if arg_23_0._isInBattle then
		lc.replaceScene(require("BattleScene").create(arg_23_0._input))
		ClientData.sendBattleLoadingDone()
	else
		ClientView.getResourceUI():setLocalZOrder(ClientData.ZOrder.ui)
		ClientView.getMenuUI()
		ClientView.getChatPanel()

		if ClientData.DEBUG_UNION then
			lc.replaceScene(require("UnionWorldScene").create())
		elseif P._playerFindDark:isInDarkBattle() then
			lc.pushScene(require("FindScene").create(Data.FindMatchType.dark))
			require("FindMatchPanel").create(Data.FindMatchType.dark):show()
		elseif arg_23_0._isInRoom then
			ClientData.replaceCityScene()
			lc.pushScene(require("FindScene").create(Data.FindMatchType.clash))
			lc.pushScene(require("InRoomScene").create())
		elseif arg_23_0._isInSurvivalHall then
			ClientData.replaceCityScene()
			lc.pushScene(require("FindScene").create(Data.FindMatchType.survival))
			lc.pushScene(require("SurvivalHallScene").create())
		elseif arg_23_0._isInSurvivalExHall then
			ClientData.replaceCityScene()
			lc.pushScene(require("FindScene").create(Data.FindMatchType.survival))
			lc.pushScene(require("SurvivalExHallScene").create())
		else
			ClientData.replaceCityScene()

			if GuideManager.isGuideInWorld() and P._guideID < 500 then
				-- block empty
			elseif GuideManager.isGuideEnabled() then
				local var_23_0 = GuideManager.getCurStepName()

				if var_23_0 == "enter evolve card" then
					lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.factory_monster))
				elseif var_23_0 == "claim task" or string.find(var_23_0, "goto task") then
					performWithDelay(lc._runningScene, function()
						require("AchieveForm").create():show()
					end, 0.1)
				elseif var_23_0 == "palace review others" then
					lc.pushScene(require("PalaceScene").create())
				elseif var_23_0 == "equip important" then
					lc.pushScene(require("CardBoxScene").create(ClientData.SceneId.factory_trap))
				end

				lc._runningScene._needGuideStartStep = true
			end
		end
	end

	collectgarbage("collect")
end

function var_0_1.screenShot(arg_25_0)
	local var_25_0 = cc.RenderTexture:create(lc.w(arg_25_0), lc.h(arg_25_0))

	var_25_0:begin()
	arg_25_0:visit()
	var_25_0:endToLua()
	var_25_0:retain()

	ClientView._rt = var_25_0
end

return var_0_1
