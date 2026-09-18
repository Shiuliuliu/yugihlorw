require("TavernScene")
require("PalaceScene")
require("CardBoxScene")
require("HeroCenterScene")
require("MarketScene")

local var_0_0 = class("CityScene", require("BaseScene"))
local var_0_1 = 4
local var_0_2 = 100
local var_0_3 = 600
local var_0_4 = 1.25
local var_0_5
local var_0_6
local var_0_7 = {
	Data.FixityId.depot,
	Data.FixityId.union,
	Data.FixityId.manage_troop,
	Data.FixityId.tavern,
	Data.FixityId.duel,
	Data.FixityId.skin_shop
}
local var_0_8 = {
	"city_btn_depot",
	"city_btn_union",
	"city_btn_troop",
	"city_btn_tavern",
	{
		_bones = "juedou",
		_size = cc.size(180, 180)
	},
	"city_btn_skin"
}
local var_0_9 = {
	cc.p(1178, ClientView.SCR_CH + 28 - 90),
	cc.p(1494, ClientView.SCR_CH + 28 - 90),
	cc.p(1178, ClientView.SCR_CH + 28 + 90),
	cc.p(1494, ClientView.SCR_CH + 28 + 90),
	cc.p(1338, ClientView.SCR_CH + 28),
	cc.p(1332, ClientView.SCR_CH + 28 - 184)
}

function var_0_0.create()
	return lc.createScene(var_0_0)
end

function var_0_0.init(arg_2_0)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.city) then
		return false
	end

	local var_2_0 = lc.Director:getVisibleSize()

	var_0_5, var_0_6 = 0, 0

	local var_2_1 = lc.createSprite("res/jpg/city_bg_01.jpg")

	var_2_1:setAnchorPoint(1 - lc.w(arg_2_0) / 2 / lc.w(var_2_1), 0.5)
	print(var_2_1:getAnchorPoint().x)
	lc.addChildToPos(arg_2_0, var_2_1, cc.p(lc.w(arg_2_0) / 2, lc.h(arg_2_0) / 2))

	arg_2_0._bg = var_2_1

	arg_2_0:initCharacters()
	arg_2_0:initButtons()
	arg_2_0:updateButtonFlags()
	var_2_1:setScale(1.5)
	arg_2_0:updateTopLayer()

	return true
end

function var_0_0.updateTopLayer(arg_3_0)
	if math.floor(ClientData.getServerTick() / 100) == 20200404 then
		if not arg_3_0._topLayer then
			local var_3_0 = ccui.Layout:create()

			lc.initMaskLayer(var_3_0, 230, lc.Color3B.black)
			var_3_0:setTouchEnabled(false)
			lc.addChildToCenter(arg_3_0._scene, var_3_0, 1000000000)

			local var_3_1 = ClientView.createTTF(Str(STR.CORONA_DAY), 50)

			lc.addChildToCenter(var_3_0, var_3_1)

			arg_3_0._topLayer = var_3_0
		end
	elseif arg_3_0._topLayer then
		arg_3_0._topLayer:removeFromParent()

		arg_3_0._topLayer = nil
	end
end

function var_0_0.initButtons(arg_4_0)
	arg_4_0._btns = {}

	for iter_4_0 = 1, #var_0_7 do
		local var_4_0 = var_0_8[iter_4_0]
		local var_4_1

		if type(var_4_0) == "string" then
			var_4_1 = ClientView.createShaderButton(var_4_0, function(arg_5_0)
				arg_4_0:onButton(var_0_7[iter_4_0])
			end)
		else
			var_4_1 = ClientView.createShaderButton(nil, function(arg_6_0)
				arg_4_0:onButton(var_0_7[iter_4_0])
			end)

			var_4_1:setContentSize(var_4_0._size)

			local var_4_2 = DragonBones.create(var_4_0._bones)

			var_4_2:setScale(0.9)
			lc.addChildToCenter(var_4_1, var_4_2)
			var_4_2:gotoAndPlay("effect")
		end

		lc.addChildToPos(arg_4_0._bg, var_4_1, var_0_9[iter_4_0], 1, iter_4_0)

		arg_4_0._btns[iter_4_0] = var_4_1
	end

	if ClientData.isAppStoreReviewing() then
		arg_4_0._btns[1]:setVisible(false)
		arg_4_0._btns[4]:setVisible(false)
		arg_4_0._btns[6]:setVisible(false)
		arg_4_0._btns[3]:setPosition(arg_4_0._btns[1]:getPosition())
	end

	if ClientData.isAnotherSkin2Locked() then
		arg_4_0._btns[6]:setVisible(false)
	end
end

function var_0_0.initCharacters(arg_7_0)
	local var_7_0 = cc.p((ClientView.SCR_W - 600) / 2 + 50, 250)

	arg_7_0:updateCharacter()
end

function var_0_0.updateCharacter(arg_8_0)
	if arg_8_0._bones ~= nil then
		arg_8_0._bones:removeFromParent()
	end

	local var_8_0 = cc.p((ClientView.SCR_W - 600) / 2 + 50, 250)
	local var_8_1 = P:getCharacterId()

	if ClientData.isAppStoreReviewing() then
		var_8_1 = 12
	end

	local var_8_2 = DragonBones.create(Data.getCharacterBoneName(var_8_1))

	lc.addChildToPos(arg_8_0._bg, var_8_2, arg_8_0._bg:convertToNodeSpace(var_8_0), 0)
	var_8_2:gotoAndPlay(Data.getCharacterAniName(var_8_1))
	lc.offset(var_8_2, 0, Data.getCharacterOffsetY(var_8_1))

	arg_8_0._bones = var_8_2

end

function var_0_0.addParticles(arg_9_0)
	return
end

function var_0_0.findFixityEntry(arg_10_0, arg_10_1)
	return var_0_9[1]
end

function var_0_0.setUiVisible(arg_11_0, arg_11_1)
	ClientView.getMenuUI():setVisible(arg_11_1)
	ClientView.getResourceUI():setVisible(arg_11_1)
	ClientView.getChatPanel()._btnPop:setVisible(arg_11_1)
end

function var_0_0.onEnter(arg_12_0)
	var_0_0.super.onEnter(arg_12_0)

	local var_12_0 = 0

	if GuideManager.getCurDifficultyStepName() == "check duel" and P._playerWorld._curLevel[1] > 10104 then
		var_12_0 = 5
		P._guideDifficultyID = P._guideDifficultyID + 1
	end

	if var_12_0 == 0 and GuideManager.getCurRecruiteStepName() == "check union" and P:getMaxCharacterLevel() >= P._playerCity:getUnionUnlockLevel() then
		var_12_0 = 2
		P._guideRecruiteID = P._guideRecruiteID + 1
	end

	arg_12_0:setAllBtnsEnabled(true)

	if P._hasEnterCity then
		arg_12_0:runAction(lc.sequence(0, function()
			arg_12_0:updateCharacter()
		end))
	end

	if not P._hasEnterCity then
		P._hasEnterCity = true

		local function var_12_1(arg_14_0)
			arg_12_0._bg._touchEnabled = false

			arg_12_0:setAllBtnsEnabled(false)

			local function var_14_0()
				local var_15_0

				if not ClientData.isActivityShowed(Data.PurchaseType.checkin) then
					var_15_0 = require("CheckinForm").create()
				end

				local var_15_1 = P._playerActivity:getActivitiesToShow()

				local function var_15_2()
					require("FundTasksPanel").create(P._playerBonus._changedFundTasks, Str(STR.FUND_TASKS)):show()

					P._playerBonus._changedFundTasks = {}
				end

				if var_15_0 then
					var_15_0:show()

					if #var_15_1 > 0 then
						function var_15_0.onHideActionFinished()
							require("ActivityForm").create(var_15_1):show()
						end
					elseif table.maxn(P._playerBonus._changedFundTasks) > 0 then
						var_15_0.onHideActionFinished = var_15_2
					end
				elseif #var_15_1 > 0 then
					require("ActivityForm").create(var_15_1):show()
				elseif table.maxn(P._playerBonus._changedFundTasks) > 0 then
					var_15_2()
				end

				arg_12_0._bg._touchEnabled = true

				arg_12_0:addParticles()
				arg_12_0:setAllBtnsEnabled(true)
			end

			arg_14_0 = arg_14_0 / 3

			arg_12_0._bg:runAction(lc.sequence(lc.scaleTo(arg_14_0, 1), var_14_0))

			return arg_14_0
		end

		if GuideManager.isGuideInCity() then
			arg_12_0._bg:setScale(1)
			arg_12_0:setUiVisible(true)
		else
			if not GuideManager.isGuideEnabled() and var_12_0 == 0 then
				var_12_1(1.5)
			else
				arg_12_0._bg:setScale(1)
			end

			arg_12_0:setUiVisible(true)
		end
	else
		arg_12_0._bg:setScale(1)
	end

	arg_12_0._listeners = {}
	arg_12_0._listeners.guide_finish = lc.addEventListener(GuideManager.Event.finish, function(arg_18_0)
		arg_12_0:onGuideFinish(arg_18_0)
	end)

	local function var_12_2(arg_19_0)
		if arg_12_0:onGesture(arg_19_0) then
			arg_19_0:stopPropagation()
		end
	end

	arg_12_0._listeners.gesturePan = lc.addEventListener(lc.Gesture.GestureEvent.pan, var_12_2, -1)
	arg_12_0._listeners.touchBegan = lc.addEventListener(lc.Gesture.TouchEvent.began, var_12_2, -1)
	arg_12_0._listeners.touchEnded = lc.addEventListener(lc.Gesture.TouchEvent.ended, var_12_2, -1)
	arg_12_0._listeners.touchCancelled = lc.addEventListener(lc.Gesture.TouchEvent.cancelled, var_12_2, -1)

	table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.login, function()
		arg_12_0:updateTopLayer()
	end))

	arg_12_0._listeners.character = lc.addEventListener(Data.Event.character_dirty, function(arg_21_0)
		arg_12_0:updateCharacter()
	end)
	arg_12_0._listeners.cardFlag = lc.addEventListener(Data.Event.card_flag_dirty, function(arg_22_0)
		arg_12_0:updateButtonFlags()
	end)
	arg_12_0._listeners.unionFlag = lc.addEventListener(Data.Event.message, function(arg_23_0)
		if arg_23_0._event == P._playerMessage.Event.msg_new then
			arg_12_0:updateUnionFlags()
		end
	end)

	arg_12_0:scheduleUpdateWithPriorityLua(function(arg_24_0)
		arg_12_0:onScheduler()
	end, 0)
	lc.Audio.playAudio(AUDIO.M_CITY)
	arg_12_0._scene:addChild(ClientView.getChatPanel(), ClientData.ZOrder.side)

	local var_12_3 = ClientView.getResourceUI()

	var_12_3:setMode(Data.ResType.gold)
	arg_12_0._scene:addChild(var_12_3, math.max(var_12_3:getLocalZOrder(), ClientData.ZOrder.ui))

	local var_12_4 = ClientView.getMenuUI()

	arg_12_0._scene:addChild(var_12_4, ClientData.ZOrder.ui)

	if BaseScene._lastSceneId == ClientData.SceneId.union and ClientData.isRateValid() and not lc.UserDefault:getBoolForKey(ClientData.ConfigKey.prompt_rate_game, false) then
		require("RateForm").create():show()
		lc.UserDefault:setBoolForKey(ClientData.ConfigKey.prompt_rate_game, true)
	end

	local var_12_5 = GuideManager.getCurStepName()

	if P._guideID == 101 then
		require("ChangeCharacterPanel").create(true):show()
	elseif var_12_5 == "win battle" and P._hasEnterCity then
		GuideManager.finishStepLater()
	end

	if var_12_0 > 0 then
		arg_12_0:runAction(lc.sequence(0, function()
			GuideManager.showOperateLayer()

			local var_25_0 = GuideManager.createNpcTipLayer(Data._guideInfo[var_12_0 == 5 and P._guideDifficultyID or P._guideRecruiteID], false, true, false, 0)

			GuideManager.addContainerLayer(var_25_0)
			GuideManager.setOperateLayer(arg_12_0._btns[var_12_0])
		end))
	end

	arg_12_0:updateButtonFlags()

	if ClientData._isAutoBattle then
		arg_12_0:runAction(lc.sequence(1, function()
			if lc._runningScene._sceneId ~= ClientData.SceneId.find and lc._runningScene._sceneId ~= ClientData.SceneId.battle then
				lc.pushScene(require("FindScene").create())
			end
		end))
	end
end

function var_0_0.onExit(arg_27_0)
	var_0_0.super.onExit(arg_27_0)

	if arg_27_0._bg.stopAnimation then
		arg_27_0._bg:stopAnimation()

		arg_27_0._bg._touchEnabled = true
	end

	for iter_27_0, iter_27_1 in pairs(arg_27_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_27_1)
	end

	arg_27_0:unscheduleUpdate()
	ClientView.removeResourceFromParent()
	ClientView.removeMenuFromParent()
	ClientView.removeChatPanelFromParent()
end

function var_0_0.onCleanup(arg_28_0)
	var_0_0.super.onCleanup(arg_28_0)
end

function var_0_0.onGesture(arg_29_0, arg_29_1)
	if not arg_29_0:checkWorking() or not arg_29_0._bg._touchEnabled then
		return
	end

	local var_29_0 = arg_29_1.touch
	local var_29_1 = arg_29_1:getEventName()

	if var_29_1 == lc.Gesture.TouchEvent.began then
		if arg_29_0._bg.stopAnimation then
			arg_29_0._bg:stopAnimation()
		end
	elseif var_29_1 == lc.Gesture.TouchEvent.ended then
		-- block empty
	elseif var_29_1 == lc.Gesture.TouchEvent.cancelled then
		-- block empty
	end

	return false
end

function var_0_0.onMsg(arg_30_0, arg_30_1)
	if var_0_0.super.onMsg(arg_30_0, arg_30_1) then
		return true
	end

	local var_30_0 = arg_30_1.type
	local var_30_1 = arg_30_1.status

	if var_30_0 == SglMsgType_pb.PB_TYPE_WORLD_SWEEP or var_30_0 == SglMsgType_pb.PB_TYPE_WORLD_SWEEP_ONCE then
		local var_30_2 = ClientView.getActiveIndicator():hide()._levelId
		local var_30_3 = arg_30_1.Extensions[World_pb.SglWorldMsg.world_sweep_resp]

		ClientView.showSweepForm(var_30_3)

		local var_30_4 = #var_30_3.result
		local var_30_5 = P:getBattleCost(var_30_4, nil, var_30_2)

		P:changeResource(Data.ResType.grain, -var_30_5)

		return true
	end

	return false
end

function var_0_0.clearCity(arg_31_0)
	arg_31_0:removeAllChildren()
end

function var_0_0.checkUnlockModule(arg_32_0)
	local var_32_0 = P._level
	local var_32_1 = lc.readConfig(ClientData.ConfigKey.lock_level_city, var_32_0)
	local var_32_2
	local var_32_3
	local var_32_4
	local var_32_5

	for iter_32_0, iter_32_1 in pairs(P._playerCity._fixities) do
		if iter_32_1._infoId == Data.FixityId.blacksmith then
			-- block empty
		elseif iter_32_1._infoId == Data.FixityId.stable then
			-- block empty
		elseif iter_32_1._infoId == Data.FixityId.library then
			-- block empty
		elseif iter_32_1._infoId == Data.FixityId.union then
			-- block empty
		end
	end

	local var_32_6 = {}

	if var_32_2 ~= nil then
		local var_32_7 = P._playerCity:getUnlockLevel(var_32_2)

		if var_32_1 < var_32_7 and var_32_7 <= var_32_0 then
			table.insert(var_32_6, Str(var_32_2._info._nameSid) .. Str(STR.UNLOCKED))
		end
	end

	if var_32_3 ~= nil then
		local var_32_8 = P._playerCity:getUnlockLevel(var_32_3)

		if var_32_1 < var_32_8 and var_32_8 <= var_32_0 then
			table.insert(var_32_6, Str(var_32_3._info._nameSid) .. Str(STR.UNLOCKED))
		end
	end

	if var_32_4 ~= nil then
		local var_32_9 = P._playerCity:getUnlockLevel(var_32_4)

		if var_32_1 < var_32_9 and var_32_9 <= var_32_0 then
			table.insert(var_32_6, Str(var_32_4._info._nameSid) .. Str(STR.UNLOCKED))
		end
	end

	if var_32_5 ~= nil then
		local var_32_10 = P._playerCity:getUnlockLevel(var_32_5)

		if var_32_1 < var_32_10 and var_32_10 <= var_32_0 then
			table.insert(var_32_6, Str(var_32_5._info._nameSid) .. Str(STR.UNLOCKED))
		end
	end

	if #var_32_6 > 0 then
		ToastManager.pushArray(var_32_6)
		lc.writeConfig(ClientData.ConfigKey.lock_level_city, var_32_0)
	end
end

function var_0_0.syncData(arg_33_0)
	var_0_0.super.syncData(arg_33_0)

	arg_33_0._bg._touchEnabled = P._guideID >= 103

	local var_33_0 = ClientView.getMenuUI()

	arg_33_0:updateButtonFlags()
end

function var_0_0.farmerWork(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_1:gotoAndPlay("labor2")
	arg_34_1:runAction(cc.Sequence:create(cc.DelayTime:create(math.random(5, 8)), cc.CallFunc:create(function()
		arg_34_0:farmerWalk(arg_34_1, arg_34_2, arg_34_3, false)
	end)))
end

function var_0_0.farmerSleep(arg_36_0, arg_36_1)
	arg_36_1:setVisible(false)
end

function var_0_0.farmerWalk(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0 = 50

	if arg_37_4 then
		arg_37_1:gotoAndPlay("walk2")

		local var_37_1 = arg_37_0._startPos[arg_37_2]
		local var_37_2 = arg_37_0._endPos[arg_37_3]
		local var_37_3 = cc.p(lc.x(arg_37_0._farmlands[arg_37_3]) + 30, lc.y(arg_37_0._farmlands[arg_37_3]) + 30)
		local var_37_4 = cc.pGetDistance(cc.p(lc.x(arg_37_1), lc.y(arg_37_1)), var_37_1)
		local var_37_5 = cc.pGetDistance(var_37_1, var_37_2)
		local var_37_6 = cc.pGetDistance(var_37_2, var_37_3)

		arg_37_1:runAction(cc.Sequence:create(cc.MoveTo:create(var_37_4 / var_37_0, var_37_1), cc.MoveTo:create(var_37_5 / var_37_0, var_37_2), cc.CallFunc:create(function()
			arg_37_1:setLocalZOrder(arg_37_0._endZOrder)
		end), cc.MoveTo:create(var_37_6 / var_37_0, var_37_3), cc.CallFunc:create(function()
			arg_37_0:farmerWork(arg_37_1, arg_37_2, arg_37_3)
		end)))
	else
		arg_37_1:gotoAndPlay("walk1")

		local var_37_7 = arg_37_0._endPos[arg_37_3]
		local var_37_8 = arg_37_0._startPos[arg_37_2]
		local var_37_9 = cc.p(lc.x(arg_37_0._residences[arg_37_2]), lc.y(arg_37_0._residences[arg_37_2]))
		local var_37_10 = cc.pGetDistance(cc.p(lc.x(arg_37_1), lc.y(arg_37_1)), var_37_7)
		local var_37_11 = cc.pGetDistance(var_37_7, var_37_8)
		local var_37_12 = cc.pGetDistance(var_37_8, var_37_9)

		arg_37_1:runAction(cc.Sequence:create(cc.MoveTo:create(var_37_10 / var_37_0, var_37_7), cc.CallFunc:create(function()
			arg_37_1:setLocalZOrder(arg_37_0._startZOrder)
		end), cc.MoveTo:create(var_37_11 / var_37_0, var_37_8), cc.MoveTo:create(var_37_12 / var_37_0, var_37_9), cc.CallFunc:create(function()
			arg_37_0:farmerSleep(arg_37_1)
		end)))
	end
end

function var_0_0.farmerAction(arg_42_0)
	local var_42_0 = cc.Sequence:create(cc.DelayTime:create(math.random(20, 30)), cc.CallFunc:create(function()
		arg_42_0:farmerAction()
	end))

	var_42_0:setTag(255)
	arg_42_0:stopActionByTag(255)
	arg_42_0:runAction(var_42_0)

	local var_42_1

	for iter_42_0 = 1, #arg_42_0._farmers do
		if not arg_42_0._farmers[iter_42_0]:isVisible() then
			var_42_1 = arg_42_0._farmers[iter_42_0]

			break
		end
	end

	if var_42_1 == nil then
		return
	end

	local var_42_2 = math.random(1, #arg_42_0._residences)
	local var_42_3 = math.random(1, #arg_42_0._farmlands)

	var_42_1:setVisible(true)
	var_42_1:setPosition(lc.x(arg_42_0._residences[var_42_2]), lc.y(arg_42_0._residences[var_42_2]))
	var_42_1:setLocalZOrder(arg_42_0._startZOrder)
	arg_42_0:farmerWalk(var_42_1, var_42_2, var_42_3, true)
end

function var_0_0.onGuideFinish(arg_44_0, arg_44_1)
	if P._guideID == 500 then
		-- block empty
	elseif P._guideID == 600 then
		GuideManager.showSoftGuideFinger(ClientView.getMenuUI()._btnCrusade)
	end
end

function var_0_0.onGuide(arg_45_0, arg_45_1)
	local var_45_0
	local var_45_1 = GuideManager.getCurStepName()

	if var_45_1 == "init troop" then
		local var_45_2 = {}

		for iter_45_0, iter_45_1 in pairs(P._playerCard._monsters) do
			table.insert(var_45_2, {
				_infoId = iter_45_0,
				_num = iter_45_1
			})
		end

		for iter_45_2, iter_45_3 in pairs(P._playerCard._magics) do
			table.insert(var_45_2, {
				_infoId = iter_45_2,
				_num = iter_45_3
			})
		end

		for iter_45_4, iter_45_5 in pairs(P._playerCard._traps) do
			table.insert(var_45_2, {
				_infoId = iter_45_4,
				_num = iter_45_5
			})
		end

		for iter_45_6, iter_45_7 in pairs(P._playerCard._rares) do
			table.insert(var_45_2, {
				_infoId = iter_45_6,
				_num = iter_45_7
			})
		end

		table.sort(var_45_2, function(arg_46_0, arg_46_1)
			local var_46_0 = Data.getInfo(arg_46_0._infoId)
			local var_46_1 = Data.getInfo(arg_46_1._infoId)

			if var_46_0._quality > var_46_1._quality then
				return true
			elseif var_46_0._quality < var_46_1._quality then
				return false
			else
				return arg_46_0._infoId < arg_46_1._infoId
			end
		end)
		require("RewardCardPanel").create(Str(STR.INIT_TROOP), var_45_2):show()
		GuideManager.finishStepLater()
	elseif var_45_1 == "enter travel" then
		GuideManager.setOperateLayer(ClientView.getMenuUI()._btnBattle)

		var_45_0 = true
	elseif var_45_1 == "enter setting" then
		GuideManager.setOperateLayer(ClientView.getMenuUI()._userArea)

		var_45_0 = true
	else
		for iter_45_8, iter_45_9 in pairs(arg_45_0._btns) do
			local var_45_3 = var_0_7[iter_45_9:getTag()]

			if var_45_1 == "collect grain" and var_45_3 == Data.FixityId.farmland or var_45_1 == "collect gold" and var_45_3 == Data.FixityId.residence or var_45_1 == "enter palace" and var_45_3 == Data.FixityId.palace or var_45_1 == "enter tavern" and var_45_3 == Data.FixityId.tavern or var_45_1 == "enter manage troop" and var_45_3 == Data.FixityId.manage_troop or var_45_1 == "enter market" and var_45_3 == Data.FixityId.market or var_45_1 == "enter union" and var_45_3 == Data.FixityId.union or var_45_1 == "enter duel" and var_45_3 == Data.FixityId.duel then
				GuideManager.setOperateLayer(iter_45_9)

				var_45_0 = true

				break
			end
		end
	end

	if var_45_0 then
		arg_45_1:stopPropagation()
	end
end

function var_0_0.onButton(arg_47_0, arg_47_1)
	if P._guideID < 103 then
		return
	end

	if not ClientData.checkBtnClick() then
		return
	end

	local var_47_0 = P._playerCity:getFixity(arg_47_1)

	if arg_47_1 == Data.FixityId.factory then
		arg_47_0:setAllBtnsEnabled(false)
		lc.pushScene(require("CardBoxScene").create())
	elseif arg_47_1 == Data.FixityId.manage_troop then
		arg_47_0:setAllBtnsEnabled(false)
		local ok, scene = pcall(function() return require("HeroCenterScene").create() end)
		if ok and scene then
			lc.pushScene(scene)
		else
			arg_47_0:setAllBtnsEnabled(true)
			ToastManager.push("Lỗi tải giao diện bộ bài")
			lc.log("[manage_troop] createScene error: " .. tostring(scene))
		end
	elseif arg_47_1 == Data.FixityId.tavern then
		arg_47_0:setAllBtnsEnabled(false)
		lc.pushScene(require("TavernScene").create())
	elseif arg_47_1 == Data.FixityId.skin_shop then
		arg_47_0:setAllBtnsEnabled(false)
		lc.pushScene(require("SkinShopScene").create())
	elseif arg_47_1 == Data.FixityId.market then
		arg_47_0:setAllBtnsEnabled(false)
		lc.pushScene(require("MarketScene").create())
	elseif arg_47_1 == Data.FixityId.depot then
		arg_47_0:setAllBtnsEnabled(false)
		lc.pushScene(require("DepotScene").create())
	elseif arg_47_1 == Data.FixityId.duel then
		-- Unlocked for all accounts immediately without tutorial requirement

		if GuideManager.getCurDifficultyStepName() == "select duel" then
			P._guideDifficultyID = P._guideDifficultyID + 1

			ClientData.sendGuideID(P._guideDifficultyID)
			GuideManager.stopGuide()
		end

		arg_47_0:setAllBtnsEnabled(false)
		lc.pushScene(require("FindScene").create())
	elseif arg_47_1 == Data.FixityId.union then
		local var_47_1 = P._playerCity:getUnionUnlockLevel()

		if var_47_1 > P:getMaxCharacterLevel() then
			ToastManager.push(string.format(Str(STR.UNIONSCENE_LOCKED), var_47_1))

			return
		end

		if GuideManager.getCurRecruiteStepName() == "select union" then
			P._guideRecruiteID = P._guideRecruiteID + 1

			ClientData.sendGuideID(P._guideRecruiteID)
			GuideManager.stopGuide()
		end

		arg_47_0:setAllBtnsEnabled(false)
		lc.pushScene(require("UnionScene").create())
	end
end

function var_0_0.onScheduler(arg_48_0)
	arg_48_0:updateDepotFlags()
end

function var_0_0.updateButtonFlags(arg_49_0)
	arg_49_0:updateDepotFlags()
	arg_49_0:updateTroopFlags()
	arg_49_0:updateUnionFlags()
end

function var_0_0.updateDepotFlags(arg_50_0)
	local var_50_0 = 0

	for iter_50_0, iter_50_1 in pairs(P._propBag._props) do
		if iter_50_1._infoId == 7001 or iter_50_1._infoId == 7003 then
			var_50_0 = iter_50_1._num + var_50_0
		end
	end

	ClientView.checkNewFlag(arg_50_0._btns[1], var_50_0, 0, -118)
end

function var_0_0.updateTroopFlags(arg_51_0)
	local var_51_0 = P._playerCard:getCardFlag()

	ClientView.checkNewFlag(arg_51_0._btns[3], var_51_0, 0, -118)
end

function var_0_0.updateUnionFlags(arg_52_0)
	local var_52_0 = P._playerMessage:getNewUnion()

	ClientView.checkNewFlag(arg_52_0._btns[2], var_52_0, 0, -118)
end

function var_0_0.setAllBtnsEnabled(arg_53_0, arg_53_1)
	for iter_53_0 = 1, #arg_53_0._btns do
		arg_53_0._btns[iter_53_0]:setEnabled(arg_53_1)
	end
end

return var_0_0