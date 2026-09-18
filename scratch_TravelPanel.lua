local var_0_0 = require("BasePanel")
local var_0_1 = class("TravelPanel", var_0_0)
local var_0_2 = 224
local var_0_3 = 1140
local var_0_4 = 538
local var_0_5 = {
	cc.rect(26, 36, 1, 1),
	cc.rect(109, 78, 2, 1),
	cc.rect(109, 105, 1, 2)
}
local var_0_6 = {
	cc.p(144, 269),
	cc.p(416, 269),
	cc.p(720, 269),
	cc.p(996, 269)
}
local var_0_7 = {
	2,
	3,
	5
}

function var_0_1.create(arg_1_0)
	local var_1_0 = var_0_1.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1)
	var_0_1.super.init(arg_2_0, true)
	ClientData.loadLCRes("res/travel.lcres")

	arg_2_0._panelName = "TravelPanel"
	arg_2_0._focusLevelId = arg_2_1
	arg_2_0._difficulty = 1

	local var_2_0 = ClientView.createTitleArea(Str(STR.TRAVEL), function()
		if arg_2_0._floatChapter then
			arg_2_0:onUnselectChapter(arg_2_0._floatChapter)
		else
			arg_2_0:hide()
		end
	end)

	arg_2_0:addChild(var_2_0)

	local var_2_1 = lc.createImageView({
		_name = "img_travel_bottom",
		_crect = cc.rect(124, 0, 4, 79),
		_size = cc.size(920, 79)
	})

	lc.addChildToPos(arg_2_0, var_2_1, cc.p(lc.w(arg_2_0) / 2, lc.h(var_2_1) / 2))

	arg_2_0._difficultyBtns = {}

	for iter_2_0 = 1, 3 do
		local var_2_2 = ClientView.createShaderButton("img_travel_0" .. iter_2_0, function(arg_4_0)
			arg_2_0:onSelectDifficulty(arg_4_0)
		end)

		var_2_2._index = iter_2_0

		lc.addChildToPos(var_2_1, var_2_2, cc.p(lc.w(var_2_1) / 2 + 192 * (-2 + iter_2_0), 58), 1)

		arg_2_0._difficultyBtns[#arg_2_0._difficultyBtns + 1] = var_2_2
	end

	local var_2_3 = lc.createSprite("img_travel_focus")

	lc.addChildToPos(var_2_1, var_2_3, cc.p(arg_2_0._difficultyBtns[1]:getPosition()))

	arg_2_0._btnFocus = var_2_3

	local var_2_4 = lc.List.createH(cc.size(lc.w(arg_2_0), lc.bottom(var_2_0) - 108), 50 + ClientView.SCR_EDGE, 10)

	lc.addChildToPos(arg_2_0, var_2_4, cc.p(0, 108))

	arg_2_0._chapterList = var_2_4

	arg_2_0:updateChapterList()

	local var_2_5 = lc.createMaskLayer(255, lc.Color3B.black, cc.size(lc.w(arg_2_0), lc.h(var_2_4)))

	var_2_5:setVisible(false)
	var_2_5:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0, var_2_5, cc.p(lc.w(var_2_5) / 2, lc.bottom(var_2_4) + lc.h(var_2_4) / 2))

	arg_2_0._maskLayer = var_2_5

	local var_2_6 = lc.List.createH(cc.size(lc.w(arg_2_0) - var_0_2 + 8, lc.bottom(var_2_0) - 108), 20, 0)

	var_2_6:setVisible(false)
	lc.addChildToPos(arg_2_0, var_2_6, cc.p(var_0_2 - 8, lc.y(arg_2_0._chapterList)))

	arg_2_0._levelList = var_2_6

	return true
end

function var_0_1.onEnter(arg_5_0)
	var_0_1.super.onEnter(arg_5_0)

	arg_5_0._listeners = {}

	table.insert(arg_5_0._listeners, lc.addEventListener(GuideManager.Event.seek, function(arg_6_0)
		arg_5_0:onGuide(arg_6_0)
	end))
	table.insert(arg_5_0._listeners, lc.addEventListener(Data.Event.copy_times_dirty, function(arg_7_0)
		return
	end))

	local var_5_0 = GuideManager.getCurDifficultyStepName()

	if string.sub(var_5_0, 1, 16) == "check difficulty" then
		local var_5_1 = tonumber(string.sub(var_5_0, 18, 18)) + 1
		local var_5_2 = false

		if var_5_1 == 2 and not Data.isLevelLock(20101) then
			var_5_2 = true
		elseif var_5_1 == 3 and not Data.isLevelLock(30101) then
			var_5_2 = true
		end

		if var_5_2 then
			P._guideDifficultyID = P._guideDifficultyID + 1

			arg_5_0:runAction(lc.sequence(0, function()
				GuideManager.showOperateLayer()

				local var_8_0 = GuideManager.createNpcTipLayer(Data._guideInfo[P._guideDifficultyID], false, true, false, 0)

				var_8_0:setScale(0.8)
				GuideManager.addContainerLayer(var_8_0)
				GuideManager.setOperateLayer(arg_5_0._difficultyBtns[var_5_1])
			end))

			return
		end
	end

	if arg_5_0._focusLevelId then
		local var_5_3 = math.floor(arg_5_0._focusLevelId / 10000)

		arg_5_0:onSelectDifficulty(arg_5_0._difficultyBtns[var_5_3])

		if P._playerWorld._curLevel[var_5_3] > arg_5_0._focusLevelId then
			local var_5_4 = arg_5_0._focusLevelId + 1

			if Data._levelInfo[var_5_4] == nil then
				var_5_4 = (math.floor(arg_5_0._focusLevelId / 100) + 1) * 100 + 1
			end

			arg_5_0._focusLevelId = var_5_4
		end

		local var_5_5 = math.floor(arg_5_0._focusLevelId / 100) % 100
		local var_5_6 = arg_5_0._chapterItems[var_5_5]

		arg_5_0:gotoChapter(var_5_6)
		arg_5_0:onSelectChapter(var_5_6)

		local var_5_7 = arg_5_0._focusLevelId % 100

		arg_5_0:gotoLevel(var_5_7)

		arg_5_0._focusLevelId = nil
	elseif not GuideManager.isGuideEnabled() then
		local var_5_8 = lc.UserDefault:getIntegerForKey(ClientData.ConfigKey.last_level, 10101)
		local var_5_9 = math.floor(var_5_8 / 10000)

		if var_5_9 ~= 1 then
			arg_5_0:onSelectDifficulty(arg_5_0._difficultyBtns[var_5_9])
		end
	end

	if GuideManager.isGuideEnabled() then
		GuideManager.finishStepLater()
	end
end

function var_0_1.onExit(arg_9_0)
	var_0_1.super.onExit(arg_9_0)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_9_1)
	end
end

function var_0_1.onCleanup(arg_10_0)
	var_0_1.super.onCleanup(arg_10_0)
	ClientData.unloadLCRes({
		"travel.jpm",
		"travel.png.sfb"
	})

	for iter_10_0 = 1, #arg_10_0._chapterItems do
		print(string.format("chapter_%02d.jpm", iter_10_0))
		ClientData.unloadLCRes({
			string.format("chapter_%02d.jpm", iter_10_0),
			string.format("chapter_%02d.png.sfb", iter_10_0)
		})
	end
end

function var_0_1.onSelectDifficulty(arg_11_0, arg_11_1)
	if arg_11_1._index == 2 and Data.isLevelLock(20101) then
		ToastManager.push(lc.str(STR.DIFFICULTY_NOT_UNLOCKED), 3)

		return
	elseif arg_11_1._index == 3 and Data.isLevelLock(30101) then
		ToastManager.push(lc.str(STR.DIFFICULTY_NOT_UNLOCKED), 3)

		return
	end

	local var_11_0 = GuideManager.getCurDifficultyStepName()

	if string.sub(var_11_0, 1, 17) == "select difficulty" then
		P._guideDifficultyID = P._guideDifficultyID + 1

		ClientData.sendGuideID(P._guideDifficultyID)
		GuideManager.stopGuide()
	end

	arg_11_0._difficulty = arg_11_1._index

	arg_11_0._btnFocus:setPosition(cc.p(arg_11_0._difficultyBtns[arg_11_0._difficulty]:getPosition()))
	arg_11_0:updateChapterList()

	if arg_11_0._floatChapter ~= nil then
		arg_11_0._maskLayer:setVisible(false)
		arg_11_0._levelList:setVisible(false)
		arg_11_0._levelList:scrollToLeft(0.1, true)
		arg_11_0._floatChapter:removeFromParent()

		arg_11_0._floatChapter = nil
	end
end

function var_0_1.updateChapterList(arg_12_0)
	arg_12_0._chapterList:removeAllItems()

	arg_12_0._chapterItems = {}

	for iter_12_0, iter_12_1 in pairs(Data._chapterInfo) do
		local var_12_0 = arg_12_0:createChapterItem(iter_12_1, #arg_12_0._chapterItems + 1, cc.size(var_0_2, lc.h(arg_12_0._chapterList)), false)

		arg_12_0._chapterItems[#arg_12_0._chapterItems + 1] = var_12_0

		arg_12_0._chapterList:pushBackCustomItem(var_12_0)
	end

	arg_12_0._chapterList:scrollToLeft(0.3, true)
end

function var_0_1.createChapterItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = ccui.Widget:create()

	var_13_0._info = arg_13_1
	var_13_0._index = arg_13_2

	local var_13_1 = P._playerWorld._curLevel[arg_13_0._difficulty]

	var_13_0._locked = math.floor(var_13_1 / 100) % 100 < arg_13_1._id

	var_13_0:setContentSize(arg_13_3)
	var_13_0:setTouchEnabled(true)
	var_13_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_13_0:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 == ccui.TouchEventType.ended then
			if not arg_13_4 then
				arg_13_0:onSelectChapter(arg_14_0)
			else
				arg_13_0:onUnselectChapter(arg_14_0)
			end
		end
	end)

	local var_13_2 = lc.createSprite({
		_name = "travel_bg_0" .. arg_13_0._difficulty,
		_crect = var_0_5[arg_13_0._difficulty],
		_size = cc.size(lc.w(var_13_0) - (arg_13_0._difficulty == 1 and 0 or 6), lc.h(var_13_0) - (arg_13_0._difficulty == 1 and 6 or 12))
	})

	var_13_2:setEffect(arg_13_0._difficulty == 1 and ClientView.SHADER_COLORS[var_0_7[arg_13_0._difficulty]] or nil)
	lc.addChildToCenter(var_13_0, var_13_2)

	if arg_13_0._difficulty == 2 then
		lc.offset(var_13_2, -4, 4)
	elseif arg_13_0._difficulty == 3 then
		lc.offset(var_13_2, -6, 6)
	end

	local var_13_3 = string.format("travel_img_%02d", arg_13_2)

	if ClientData.isAnotherSkin() and lc.FrameCache:getSpriteFrame(var_13_3 .. "_2") then
		var_13_3 = var_13_3 .. "_2"
	end

	local var_13_4 = cc.ShaderSprite:createWithFramename(var_13_3)

	lc.addChildToPos(var_13_0, var_13_4, cc.p(lc.w(var_13_0) / 2 - 4, lc.h(var_13_0) / 2), -1)

	if var_13_0._locked then
		var_13_4:setEffect(ClientView.SHADER_DISABLE)
		var_13_2:setEffect(ClientView.SHADER_DISABLE)
	end

	local var_13_5 = cc.Label:createWithTTF(Str(arg_13_1._nameSid), ClientView.TTF_FONT, ClientView.FontSize.S1)

	lc.addChildToPos(var_13_0, var_13_5, cc.p(lc.w(var_13_0) / 2 - 4, 90))

	local var_13_6, var_13_7 = P._playerWorld:getChapterProgress(arg_13_0._difficulty, arg_13_1._id)
	local var_13_8 = ClientView.createBMFont(ClientView.BMFont.huali_26, string.format("%d/%d", var_13_7, var_13_6))

	lc.addChildToPos(var_13_0, var_13_8, cc.p(lc.w(var_13_0) / 2, 60))

	return var_13_0
end

function var_0_1.onSelectChapter(arg_15_0, arg_15_1)
	ClientData.loadLCRes(string.format("res/chapter_%02d.lcres", arg_15_1._info._id))

	if arg_15_1._locked then
		ToastManager.push(lc.str(STR.BATTLE_NOT_UNLOCKED), 3)

		return
	end

	lc.Audio.playAudio(AUDIO.E_TRAVEL_CHAPTER)

	arg_15_0._chapterId = arg_15_0._difficulty * 100 + arg_15_1._info._id

	arg_15_0:updateLevelList()
	arg_15_0._maskLayer:setVisible(true)

	local var_15_0 = arg_15_0:createChapterItem(arg_15_1._info, arg_15_1._info._id, arg_15_1:getContentSize(), true)

	var_15_0._chapterItem = arg_15_1

	local var_15_1 = lc.convertPos(cc.p(arg_15_1:getPosition()), arg_15_0._chapterList, arg_15_0)

	lc.addChildToPos(arg_15_0, var_15_0, var_15_1)
	var_15_0:runAction(lc.sequence(lc.moveTo(0.2, cc.p(lc.w(var_15_0) / 2 + ClientView.SCR_EDGE, lc.y(var_15_0)))))

	arg_15_0._floatChapter = var_15_0

	if GuideManager.getCurStepName() == "select chapter 1" then
		GuideManager.finishStepLater(0.5)
	end
end

function var_0_1.onUnselectChapter(arg_16_0, arg_16_1)
	lc.Audio.playAudio(AUDIO.E_TRAVEL_CHAPTER)

	local var_16_0 = arg_16_1._chapterItem

	ClientData.unloadLCRes({
		string.format("chapter_%02d.jpm", var_16_0._info._id),
		string.format("chapter_%02d.png.sfb", var_16_0._info._id)
	})

	local var_16_1 = lc.convertPos(cc.p(var_16_0:getPosition()), arg_16_0._chapterList, arg_16_0)

	arg_16_0._levelList:runAction(lc.sequence(lc.ease(lc.moveTo(0.3, cc.p(-lc.w(arg_16_0._levelList), lc.y(arg_16_0._levelList))), "BackI", 0.5), function()
		arg_16_0._levelList:setVisible(false)
	end))
	arg_16_1:runAction(lc.sequence(0.3, lc.moveTo(0.2, var_16_1), lc.remove(), function()
		arg_16_0._floatChapter = nil

		arg_16_0._maskLayer:setVisible(false)
		arg_16_0._levelList:scrollToLeft(0.1, true)
	end))
end

function var_0_1.gotoChapter(arg_19_0, arg_19_1)
	arg_19_0._chapterList:forceDoLayout()
	arg_19_0._chapterList:gotoPos(lc.right(arg_19_1) + 50 - ClientView.SCR_W)
end

function var_0_1.updateLevelList(arg_20_0)
	arg_20_0._levelList:removeAllItems()

	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(Data._levelInfo) do
		if math.floor(iter_20_1._id / 100) == arg_20_0._chapterId then
			var_20_0[#var_20_0 + 1] = iter_20_1
		end
	end

	table.sort(var_20_0, function(arg_21_0, arg_21_1)
		return arg_21_0._id < arg_21_1._id
	end)

	local var_20_1 = #var_20_0
	local var_20_2 = ccui.Layout:create()

	var_20_2:setContentSize(var_0_3, var_0_4)
	arg_20_0._levelList:pushBackCustomItem(var_20_2)

	for iter_20_2 = 1, #var_20_0 do
		local var_20_3, var_20_4 = arg_20_0:createLevelSprite(var_20_0[iter_20_2], iter_20_2)

		lc.addChildToPos(var_20_2, var_20_3, var_0_6[iter_20_2])

		if var_20_4 then
			var_20_1 = iter_20_2
		end
	end

	arg_20_0._levelList:setPosition(cc.p(-lc.w(arg_20_0._levelList), lc.y(arg_20_0._levelList)))
	arg_20_0._levelList:setVisible(true)
	arg_20_0._levelList:runAction(lc.sequence(0.2, lc.ease(lc.moveTo(0.3, cc.p(var_0_2 - 8 + ClientView.SCR_EDGE, lc.y(arg_20_0._levelList))), "BackIO", 0.5), function()
		arg_20_0:gotoLevel(var_20_1)
	end))
end

function var_0_1.createLevelSprite(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = false
	local var_23_1 = string.format("chapter_%02d_%02d", arg_23_0._chapterId % 100, arg_23_2)

	if ClientData.isAnotherSkin2() and lc.FrameCache:getSpriteFrame(var_23_1 .. "_3") then
		var_23_1 = var_23_1 .. "_3"
	end

	local var_23_2 = ClientView.createTouchSpriteWithShader(var_23_1, function(arg_24_0)
		arg_23_0:onSelectLevel(arg_24_0)
	end)

	var_23_2._info = arg_23_1
	var_23_2._locked = Data.isLevelLock(arg_23_1._id)

	if var_23_2._locked then
		var_23_2._sprite:setEffect(ClientView.SHADER_DISABLE)
	end

	if arg_23_1._id == P._playerWorld._curLevel[arg_23_0._difficulty] then
		local var_23_3 = Particle.create("dangqian")

		var_23_3:setPositionType(cc.POSITION_TYPE_GROUPED)
		lc.addChildToPos(var_23_2._sprite, var_23_3, cc.p(lc.w(var_23_2._sprite) / 2, lc.h(var_23_2._sprite) / 2 - 20))

		var_23_0 = true
	end

	return var_23_2, var_23_0
end

function var_0_1.onSelectLevel(arg_25_0, arg_25_1)
	if arg_25_1._locked then
		ToastManager.push(lc.str(STR.LEVEL_NOT_UNLOCK), 3)

		return
	end

	require("LevelForm").create(arg_25_1._info):show()

	local var_25_0 = GuideManager.getCurStepName()

	if string.sub(var_25_0, 1, 12) == "select level" then
		GuideManager.finishStepLater(0.4)
	end
end

function var_0_1.gotoLevel(arg_26_0, arg_26_1)
	arg_26_0._levelList:forceDoLayout()
	arg_26_0._levelList:gotoPos(lc.left(arg_26_0._levelList:getItems()[1]:getChildren()[arg_26_1]))
end

function var_0_1.onGuide(arg_27_0, arg_27_1)
	local var_27_0
	local var_27_1 = GuideManager.getCurStepName()

	if var_27_1 == "select chapter 1" then
		GuideManager.setOperateLayer(arg_27_0._chapterItems[1])

		var_27_0 = true
	elseif string.sub(var_27_1, 1, 12) == "select level" then
		GuideManager.setOperateLayer(arg_27_0._levelList:getItems()[1]:getChildren()[tonumber(string.sub(var_27_1, 14, 14))])

		var_27_0 = true
	end

	if var_27_0 then
		arg_27_1:stopPropagation()
	end
end

return var_0_1
