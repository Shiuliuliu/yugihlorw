local var_0_0 = class("UnionBossArea", lc.ExtendCCNode)
local var_0_1 = 800
local var_0_2 = cc.size(440, 500)
local var_0_3 = cc.size(300, 360)
local var_0_4 = 26
local var_0_5 = 36
local var_0_6 = 36
local var_0_7 = 255
local var_0_8 = 128
local var_0_9 = ClientView.COLOR_TEXT_GREEN_DARK
local var_0_10 = ClientView.COLOR_TEXT_GRAY
local var_0_11 = ClientView.COLOR_TEXT_DARK
local var_0_12 = var_0_10
local var_0_13 = 100

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_1, arg_1_2)
	var_1_0:init(arg_1_0)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local var_3_0 = P._playerUnion:getMyUnion()
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0._bosses) do
		table.insert(var_3_1, iter_3_1)
	end

	table.sort(var_3_1, function(arg_4_0, arg_4_1)
		return arg_4_0._id < arg_4_1._id
	end)

	arg_3_0._bossData = var_3_1

	if #arg_3_0._bossData > 0 then
		arg_3_0:initBottomArea()
		arg_3_0:initBossArea()
		arg_3_0:initDetailArea()
		arg_3_0:initButtonsArea()
		arg_3_0:selectBoss(arg_3_0._bossData[arg_3_1], true)
		arg_3_0:updateBottomArea()
	end
end

function var_0_0.initBottomArea(arg_5_0)
	local var_5_0 = lc.createSprite("img_troop_bg")

	var_5_0:setScaleX(lc.w(arg_5_0) / lc.w(var_5_0) + 0.1)
	var_5_0:setRotation(180)

	local var_5_1 = lc.createNode(cc.size(lc.w(arg_5_0), lc.h(var_5_0)))

	lc.addChildToPos(arg_5_0, var_5_1, cc.p(lc.w(arg_5_0) / 2, lc.h(var_5_1) / 2 - 8))
	lc.addChildToCenter(var_5_1, var_5_0)

	arg_5_0._bottomArea = var_5_1

	local var_5_2 = lc.List.createH(cc.size(lc.w(arg_5_0), IconWidget.SIZE + 20), 20, 16)

	lc.addChildToPos(var_5_1, var_5_2, cc.p(0, 18))

	arg_5_0._bossList = var_5_2

	local var_5_3 = arg_5_0._bossData

	var_5_2:bindData(var_5_3, function(arg_6_0, arg_6_1)
		arg_5_0:setOrCreateBossIcon(arg_6_0, arg_6_1)
	end, math.min(#var_5_3, 12))

	for iter_5_0 = 1, var_5_2._cacheCount do
		local var_5_4 = arg_5_0:setOrCreateBossIcon(nil, var_5_3[iter_5_0])

		var_5_2:pushBackCustomItem(var_5_4)
	end
end

function var_0_0.initBossArea(arg_7_0)
	local var_7_0 = lc.createNode(cc.size(var_0_1 - var_0_2.width, var_0_2.height))
	local var_7_1 = (lc.w(arg_7_0) - math.min(var_0_1, lc.w(arg_7_0))) / 2

	lc.addChildToPos(arg_7_0, var_7_0, cc.p(var_7_1 - 15 + lc.w(var_7_0) / 2, lc.h(arg_7_0) - lc.h(var_7_0) / 2 - 4))

	local var_7_2 = lc.createSprite("img_name_bg_01")

	lc.addChildToPos(var_7_0, var_7_2, cc.p(lc.w(var_7_0) / 2, lc.h(var_7_0) - lc.h(var_7_2) / 2 - 10))

	local var_7_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, "")

	var_7_3:setColor(cc.c3b(255, 210, 140))
	lc.addChildToPos(var_7_2, var_7_3, cc.p(lc.w(var_7_2) / 2, lc.h(var_7_2) / 2 + 6))

	arg_7_0._bossName = var_7_3

	local var_7_4 = lc.createSprite("img_title_decoration", cc.p(4, lc.h(var_7_2) / 2), cc.p(1, 0.5))

	var_7_4:setFlippedX(true)
	var_7_2:addChild(var_7_4)

	local var_7_5 = lc.createSprite("img_title_decoration", cc.p(lc.w(var_7_2) - 4, lc.y(var_7_4)), cc.p(0, 0.5))

	var_7_2:addChild(var_7_5)

	local var_7_6 = lc._runningScene
	local var_7_7 = ccui.Widget:create()

	var_7_7:setContentSize(var_0_3)
	var_7_7:setTouchEnabled(true)
	var_7_7:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 == ccui.TouchEventType.ended then
			arg_7_0:randomBossAction()
		end
	end)

	arg_7_0._linkObjs = {
		var_7_7
	}

	local var_7_8 = cc.p(ClientView.VERTICAL_TAB_WIDTH + var_7_1, lc.bottom(var_7_0))

	lc.addChildToPos(var_7_6, var_7_7, cc.p(var_7_8.x + lc.w(var_7_0) / 2 - 20, var_7_8.y + 20 + lc.h(var_7_7) / 2), 1)

	local var_7_9 = lc.createSprite("card_atk")

	var_7_9:setScale(0.6)
	lc.addChildToPos(var_7_7, var_7_9, cc.p(math.floor(lc.sw(var_7_9) / 2), math.floor(lc.sh(var_7_9) / 2)), 1)

	arg_7_0._atkBg = var_7_9

	local var_7_10 = ClientView.createBMFont(ClientView.BMFont.huali_26, "0")

	lc.addChildToPos(var_7_7, var_7_10, cc.p(lc.x(var_7_9) + 4, lc.y(var_7_9) - 5), 1)

	arg_7_0._atkVal = var_7_10

	local var_7_11 = ClientView.createLabelProgressBar(240, ClientView.BMFont.huali_26, nil, ClientView.COLOR_TEXT_RED_DARK)

	lc.addChildToPos(var_7_7, var_7_11, cc.p(lc.w(var_7_7) - lc.w(var_7_11) / 2, lc.y(var_7_9) - 6), 1)

	arg_7_0._hpBar = var_7_11
	arg_7_0._figureArea = var_7_7
end

function var_0_0.initDetailArea(arg_9_0)
	local var_9_0 = ClientView.createPaperBg(var_0_2, true)
	local var_9_1 = (lc.w(arg_9_0) - math.min(var_0_1, lc.w(arg_9_0))) / 2

	lc.addChildToPos(arg_9_0, var_9_0, cc.p(lc.w(arg_9_0) - var_9_1 - 10 - var_0_2.width / 2, lc.h(arg_9_0) - lc.h(var_9_0) / 2 - 4))

	local var_9_2 = {
		{
			_labelStr = Str(STR.INFO),
			_handler = function(arg_10_0)
				arg_9_0:refreshDetailContent(arg_10_0)
			end
		},
		{
			_labelStr = Str(STR.BONUS),
			_handler = function(arg_11_0)
				arg_9_0:refreshDetailContent(arg_11_0)
			end
		}
	}
	local var_9_3 = ClientView.createHorizontalContentTab(cc.size(lc.w(var_9_0) - 30, 426), var_9_2)

	lc.addChildToPos(var_9_0, var_9_3, cc.p(lc.w(var_9_0) / 2, 203))

	local var_9_4 = lc.List.createV(cc.size(lc.w(var_9_3._content), lc.h(var_9_3._content) - 30), 16, 20)

	var_9_4:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_9_3._content, var_9_4, cc.p(lc.w(var_9_3._content) / 2, lc.h(var_9_3._content) / 2 + 5))

	var_9_3._list = var_9_4
	arg_9_0._detailArea = var_9_3
end

function var_0_0.initButtonsArea(arg_12_0)
	local var_12_0 = math.min(var_0_1, lc.w(arg_12_0))
	local var_12_1 = lc.createNode(cc.size(var_12_0, 60))
	local var_12_2 = (lc.w(arg_12_0) - var_12_0) / 2

	lc.addChildToPos(arg_12_0, var_12_1, cc.p(var_12_2 - 15 + lc.w(var_12_1) / 2, lc.top(arg_12_0._bottomArea) + lc.h(var_12_1) / 2 + 2))

	local var_12_3 = ClientView.createScale9ShaderButton("img_btn_2", nil, ClientView.CRECT_BUTTON, 140)

	var_12_3:addLabel("")
	lc.addChildToPos(var_12_1, var_12_3, cc.p(lc.w(var_12_1) - lc.w(var_12_3) / 2, lc.h(var_12_1) / 2), 1)

	arg_12_0._btnChallenge = var_12_3

	local var_12_4 = ClientView.createScale9ShaderButton("img_btn_2", function()
		arg_12_0:editTroop()
	end, ClientView.CRECT_BUTTON, 140)

	var_12_4:addLabel(Str(STR.TROOP))
	lc.addChildToPos(var_12_1, var_12_4, cc.p(lc.left(var_12_3) - 10 - lc.w(var_12_4) / 2, lc.y(var_12_3)))

	arg_12_0._btnTroop = var_12_4

	local var_12_5 = ClientView.createResIconLabel(140, "img_icon_res13_s", lc.Color3B.white)

	lc.addChildToPos(var_12_1, var_12_5, cc.p(lc.left(var_12_3) - lc.w(var_12_5) / 2 + 10, lc.y(var_12_3)))

	arg_12_0._unlockRes = var_12_5

	local var_12_6 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_12_0:showMemberRank()
	end, ClientView.CRECT_BUTTON, 140)

	var_12_6:addLabel(Str(STR.UNION_MEMBER_RANK))
	lc.addChildToPos(var_12_1, var_12_6, cc.p(36 + lc.w(var_12_6) / 2, lc.y(var_12_3)))

	local var_12_7 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_12_0:showServerRank()
	end, ClientView.CRECT_BUTTON, 140)

	var_12_7:addLabel(Str(STR.SERVER_RANK))
	lc.addChildToPos(var_12_1, var_12_7, cc.p(lc.right(var_12_6) + 10 + lc.w(var_12_7) / 2, lc.y(var_12_3)))

	arg_12_0._buttonsArea = var_12_1
end

function var_0_0.setOrCreateBossIcon(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == nil then
		local var_16_0 = IconWidget.create({
			_infoId = 0
		}, IconWidget.DisplayFlag.ITEM_NO_NAME)

		var_16_0:setEnabled(false)

		arg_16_1 = ClientView.createShaderButton()

		arg_16_1:setContentSize(var_16_0:getContentSize())
		lc.addChildToCenter(arg_16_1, var_16_0)

		arg_16_1._icon = var_16_0
	end

	local var_16_1 = arg_16_1._icon

	var_16_1:resetData({
		_infoId = arg_16_2._info._iconId
	})

	if arg_16_2._isActive then
		var_16_1:setSpriteDisplay(var_16_1._frame, nil, ClientView.SHADER_COLORS[Data.CardQuality.UR])
		var_16_1:setGray(arg_16_2._isLocked)
	else
		var_16_1:setGray(true)
		var_16_1:setSpriteDisplay(var_16_1._img, "card_icon_unknow")
	end

	arg_16_1._boss = arg_16_2

	function arg_16_1._callback()
		arg_16_0:selectBoss(arg_16_2)
	end

	return arg_16_1
end

function var_0_0.selectBoss(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == arg_18_0._boss and not arg_18_2 then
		return
	end

	if not arg_18_1._isActive then
		ToastManager.push(string.format(Str(STR.KILL_AUTO_ACTIVE), Str(Data._bossInfo[arg_18_1._id - 1]._nameSid)))

		return
	end

	lc._runningScene._unionBossIndex = arg_18_1._id - 100
	arg_18_0._boss = arg_18_1

	local var_18_0 = arg_18_1._info

	if arg_18_0._bossBones then
		arg_18_0._isBossAction = nil

		arg_18_0._bossBones:removeFromParent()
	end

	local var_18_1 = string.format("boss_%d", arg_18_1._id)
	local var_18_2 = DragonBones.create(var_18_1)

	var_18_2:gotoAndPlay("wait")
	lc.addChildToPos(arg_18_0._figureArea, var_18_2, cc.p(var_0_3.width / 2, var_0_3.height / 2 - 20))

	arg_18_0._bossBones = var_18_2

	arg_18_0._bossName:setString(Str(var_18_0._nameSid))
	arg_18_0._atkVal:setString(var_18_0._atk)
	arg_18_0._detailArea:showTab(1, true)
	arg_18_0:updateBossArea()
	arg_18_0:updateChallengeButton()
end

function var_0_0.updateBossArea(arg_19_0)
	local var_19_0 = arg_19_0._boss
	local var_19_1 = var_19_0._hp == 0 and var_19_0._info._hp or var_19_0._hp

	arg_19_0:setHpBar(arg_19_0._hpBar, var_19_1, var_19_0._info._hp)

	local var_19_2 = var_19_0._attacker

	if var_19_2 then
		if arg_19_0._attackerLabel == nil then
			local var_19_3 = lc.createSprite({
				_name = "img_com_bg_7",
				_crect = ClientView.CRECT_COM_BG7,
				_size = cc.size(280, 70)
			})

			var_19_3:setColor(cc.c3b(30, 20, 10))
			var_19_3:setOpacity(200)
			lc.addChildToPos(arg_19_0._figureArea, var_19_3, cc.p(var_0_3.width / 2, 80), 1)

			local var_19_4 = {
				_width = 230,
				_normalClr = ClientView.COLOR_TEXT_LIGHT,
				_boldClr = ClientView.COLOR_TEXT_GREEN,
				_fontSize = ClientView.FontSize.S2
			}
			local var_19_5 = ClientView.createBoldRichText(string.format(Str(STR.UNION_ATTACKING_BY), var_19_2._name), var_19_4)

			lc.addChildToCenter(var_19_3, var_19_5)

			arg_19_0._attackerLabel = var_19_3
		end
	elseif arg_19_0._attackerLabel then
		arg_19_0._attackerLabel:removeFromParent()

		arg_19_0._attackerLabel = nil
	end
end

function var_0_0.updateAssistants(arg_20_0)
	if arg_20_0._assistants == nil then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._assistants) do
		local var_20_0 = arg_20_0._boss._assistants[iter_20_0]._curHp

		arg_20_0:setHpBar(iter_20_1._hpBar, var_20_0, iter_20_1._card:getHp())

		if var_20_0 == 0 then
			iter_20_1:setGray(true)
		end
	end
end

function var_0_0.updateChallengeButton(arg_21_0)
	local var_21_0 = arg_21_0._btnChallenge
	local var_21_1 = arg_21_0._boss

	if arg_21_0._times then
		arg_21_0._times:removeFromParent()

		arg_21_0._times = nil
	end

	arg_21_0._btnTroop:setVisible(not var_21_1._isLocked)
	arg_21_0._unlockRes:setVisible(var_21_1._isLocked)

	if var_21_1._isLocked then
		var_21_0._label:setString(Str(STR.UNLOCK))

		function var_21_0._callback()
			arg_21_0:unlock()
		end

		local var_21_2 = P._playerUnion:getMyUnion()

		arg_21_0._unlockRes._label:setString(var_21_1._info._unlockRes)
		arg_21_0._unlockRes._label:setColor(var_21_1._info._unlockRes > var_21_2._act and lc.Color3B.red or lc.Color3B.white)
	else
		var_21_0._label:setString(Str(STR.CHALLENGE))

		function var_21_0._callback()
			arg_21_0:challenge()
		end

		local var_21_3 = ClientView.createBoldRichText(string.format(Str(STR.DAILY_UNION_BOSS_TIMES), P:getUnionBossRemainTimes(var_21_1._id), Data._globalInfo._dailyAtkUBossCount), ClientView.RICHTEXT_PARAM_LIGHT_S1)

		lc.addChildToPos(arg_21_0._buttonsArea, var_21_3, cc.p(lc.w(arg_21_0._buttonsArea) / 2 + 20, lc.y(var_21_0)))

		arg_21_0._times = var_21_3
	end
end

function var_0_0.updateBottomArea(arg_24_0)
	local var_24_0 = arg_24_0._bossList
	local var_24_1, var_24_2 = var_24_0:getItems()

	if #var_24_1 > 0 then
		for iter_24_0, iter_24_1 in ipairs(var_24_1) do
			if iter_24_1._boss._id == arg_24_0._boss._id then
				var_24_2 = iter_24_1

				break
			end
		end

		local var_24_3 = var_24_0:getInnerContainerSize().width
		local var_24_4 = math.max(var_24_3 - lc.right(var_24_2) - lc.w(var_24_0) + var_24_0:getItemsMargin(), 0)

		var_24_0:gotoPos(var_24_4)
	end
end

function var_0_0.randomBossAction(arg_25_0)
	if arg_25_0._bossBones == nil or arg_25_0._isBossAction then
		return
	end

	local var_25_0 = ({
		"attack",
		"attack_fortress",
		"effect1",
		"effect2"
	})[math.random(1, 4)]
	local var_25_1 = arg_25_0._bossBones
	local var_25_2 = var_25_1:getAnimationDuration(var_25_0)

	arg_25_0._isBossAction = true

	var_25_1:stopAllActions()
	var_25_1:gotoAndPlay(var_25_0)
	var_25_1:setLocalZOrder(2)
	var_25_1:runAction(lc.sequence(var_25_2, function()
		var_25_1:setLocalZOrder(0)
		var_25_1:gotoAndPlay("wait")

		arg_25_0._isBossAction = nil
	end))
end

function var_0_0.refreshDetailContent(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._detailArea._list

	var_27_0:removeAllItems()

	arg_27_0._assistants = {}

	if arg_27_1 == 1 then
		var_27_0:setBounceEnabled(true)
		var_27_0:pushBackCustomItem(arg_27_0:createDesc())

		if arg_27_0._boss._info._assistant[1] > 0 then
			var_27_0:pushBackCustomItem(arg_27_0:createAssistant())
		end

		var_27_0:pushBackCustomItem(arg_27_0:createSkill())
	elseif arg_27_1 == 2 then
		var_27_0:setBounceEnabled(false)
		var_27_0:pushBackCustomItem(arg_27_0:createBonus())
		var_27_0:pushBackCustomItem(arg_27_0:createBonus(true))
	end

	var_27_0:gotoTop()
end

function var_0_0.createItemBegin(arg_28_0, arg_28_1)
	local var_28_0 = 12
	local var_28_1 = lc.w(arg_28_0._detailArea) - var_0_5 - var_0_6
	local var_28_2 = ccui.Widget:create()

	var_28_2:setContentSize(var_28_1, 0)

	function var_28_2.createText(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
		local var_29_0 = ClientView.createTTF(arg_29_1)

		if arg_29_2 then
			var_29_0:setColor(arg_29_2)
		end

		if arg_29_3 then
			var_29_0:setDimensions(arg_29_3, 0)
		end

		return var_29_0
	end

	if arg_28_1 then
		local var_28_3 = ClientView.addDecoratedLabel(var_28_2, arg_28_1, cc.p(var_28_1 / 2, 0), var_0_4)

		var_28_2._title = var_28_3
		var_28_0 = var_28_0 + lc.h(var_28_3)
	end

	return var_28_2, arg_28_0._boss._info, var_28_1, var_28_0
end

function var_0_0.createItemEnd(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_3

	arg_30_1:setContentSize(cc.size(arg_30_2, arg_30_3))

	for iter_30_0, iter_30_1 in ipairs(arg_30_1:getChildren()) do
		arg_30_3 = iter_30_1:getPositionY()

		iter_30_1:setPositionY(var_30_0 - arg_30_3 - lc.sh(iter_30_1) / 2)
	end

	return arg_30_1
end

function var_0_0.createDesc(arg_31_0)
	local var_31_0, var_31_1, var_31_2, var_31_3 = arg_31_0:createItemBegin(Str(STR.MEMOIR))
	local var_31_4 = var_31_0:createText(Str(var_31_1._descSid), ClientView.COLOR_TEXT_DARK, var_31_2)

	lc.addChildToPos(var_31_0, var_31_4, cc.p(var_31_2 / 2, var_31_3))

	return arg_31_0:createItemEnd(var_31_0, var_31_2, var_31_3 + lc.h(var_31_4))
end

function var_0_0.createAssistant(arg_32_0)
	local var_32_0, var_32_1, var_32_2, var_32_3 = arg_32_0:createItemBegin(Str(STR.ASSISTANT_HERO))

	for iter_32_0, iter_32_1 in ipairs(arg_32_0._boss._assistants) do
		local var_32_4 = IconWidget.createByInfoId(iter_32_1)

		lc.addChildToPos(var_32_0, var_32_4, cc.p((IconWidget.SIZE + 16) * (iter_32_0 - 1) + IconWidget.SIZE / 2, var_32_3))
		table.insert(arg_32_0._assistants, var_32_4)

		local var_32_5 = ClientView.createLabelProgressBar(IconWidget.SIZE + 4, ClientView.BMFont.huali_20, nil, ClientView.COLOR_TEXT_RED_DARK)

		var_32_5:setScale(0.8)
		lc.addChildToPos(var_32_0, var_32_5, cc.p(lc.x(var_32_4), var_32_3 + IconWidget.SIZE + 4))

		var_32_4._hpBar = var_32_5
	end

	arg_32_0:updateAssistants()

	return arg_32_0:createItemEnd(var_32_0, var_32_2, var_32_3 + IconWidget.SIZE + 36)
end

function var_0_0.createSkill(arg_33_0)
	local var_33_0, var_33_1, var_33_2, var_33_3 = arg_33_0:createItemBegin(Str(STR.SKILL))
	local var_33_4 = {}

	for iter_33_0, iter_33_1 in ipairs(var_33_1._skillId) do
		local var_33_5 = Data._skillInfo[iter_33_1]

		if var_33_5 then
			local var_33_6 = {
				_skillInfo = var_33_5,
				_skillLevel = var_33_1._skillLevelSeq[iter_33_0],
				_unlockRound = var_33_1._startRound[iter_33_0],
				_skipRound = var_33_1._stepRound[iter_33_0]
			}

			table.insert(var_33_4, var_33_6)
		end
	end

	local var_33_7 = 4
	local var_33_8 = 10

	for iter_33_2, iter_33_3 in ipairs(var_33_4) do
		local var_33_9, var_33_10, var_33_11 = ClientView.getSkillDisplayInfo(iter_33_3._skillInfo._id, iter_33_3._skillLevel)
		local var_33_12 = lc.createSprite(var_33_9)
		local var_33_13 = var_33_0:createText(var_33_10)
		local var_33_14 = var_33_0:createText(var_33_11, nil, var_33_2)

		if iter_33_3._unlockRound == 1 then
			var_33_12:setOpacity(var_0_7)
			var_33_13:setColor(var_0_9)
			var_33_14:setColor(var_0_11)
		else
			var_33_12:setOpacity(var_0_8)
			var_33_13:setColor(var_0_10)
			var_33_14:setColor(var_0_12)
		end

		local var_33_15 = math.max(lc.h(var_33_12), lc.h(var_33_13) + lc.h(var_33_14) + var_33_7)
		local var_33_16 = ccui.Widget:create()

		var_33_16:setContentSize(var_33_2, var_33_15)
		ClientView.addSkillTapHandler(var_33_16, iter_33_3._skillInfo._id, iter_33_3._skillLevel)
		lc.addChildToPos(var_33_0, var_33_16, cc.p(var_33_2 / 2, var_33_3))
		var_33_12:setScale(0.6)
		lc.addChildToPos(var_33_16, var_33_12, cc.p(math.floor(lc.sw(var_33_12) / 2), lc.h(var_33_16) - math.floor(lc.sh(var_33_12) / 2)))
		lc.addChildToPos(var_33_16, var_33_13, cc.p(math.floor(lc.right(var_33_12)) + lc.w(var_33_13) / 2 + var_33_8, math.floor(lc.top(var_33_12)) - lc.h(var_33_13) / 2 - 3))
		lc.addChildToPos(var_33_16, var_33_14, cc.p(math.floor(lc.left(var_33_12)) + lc.w(var_33_14) / 2, math.floor(lc.bottom(var_33_12)) - lc.h(var_33_14) / 2 - var_33_7))

		local function var_33_17(arg_34_0, arg_34_1, arg_34_2)
			local var_34_0 = lc.createImageView(arg_34_0)

			ClientView.addLongPressDescPanel(var_34_0, arg_34_2, function(arg_35_0)
				local var_35_0 = lc.convertPos(cc.p(lc.w(var_33_16), lc.h(var_33_16)), var_33_16)

				return cc.p(var_35_0.x - lc.w(arg_35_0) / 2 + 30, var_35_0.y + lc.h(arg_35_0) / 2 + 10)
			end)
			lc.addChildToPos(var_34_0, ClientView.createTTF(tostring(arg_34_1), ClientView.FontSize.S3, ClientView.COLOR_TEXT_DARK), cc.p(lc.w(var_34_0) / 2, lc.h(var_34_0) / 2 + 4))

			return var_34_0
		end

		local var_33_18

		if iter_33_3._unlockRound > 1 then
			var_33_18 = var_33_17("img_icon_round_start", iter_33_3._unlockRound, string.format(Str(STR.SKILL_START_ROUND_TIP), iter_33_3._unlockRound))

			lc.addChildToPos(var_33_16, var_33_18, cc.p(var_33_2 - lc.w(var_33_18) / 2, lc.y(var_33_12)))
		end

		if iter_33_3._skipRound > 0 then
			local var_33_19 = var_33_17("img_icon_round_skip", iter_33_3._skipRound, string.format(Str(STR.SKILL_SKIP_ROUND_TIP), iter_33_3._skipRound))

			if var_33_18 then
				lc.addChildToPos(var_33_16, var_33_19, cc.p(lc.left(var_33_18) - 6 - lc.w(var_33_19) / 2, lc.y(var_33_12)))
			else
				lc.addChildToPos(var_33_16, var_33_19, cc.p(var_33_2 - lc.w(var_33_19) / 2, lc.y(var_33_12)))
			end
		end

		var_33_3 = var_33_3 + lc.h(var_33_13) + var_33_7 + lc.h(var_33_14) + 20
	end

	return arg_33_0:createItemEnd(var_33_0, var_33_2, var_33_3)
end

function var_0_0.createBonus(arg_36_0, arg_36_1)
	local var_36_0, var_36_1, var_36_2, var_36_3 = arg_36_0:createItemBegin(Str(arg_36_1 and STR.BONUS_KILLED or STR.BONUS_CHALLENGE))
	local var_36_4 = lc.List.createH(cc.size(382, IconWidget.SIZE + 20), 20, 10)

	var_36_4:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_36_0, var_36_4, cc.p(-22, var_36_3 - 4))

	local var_36_5 = var_36_3 + IconWidget.SIZE + 16
	local var_36_6 = var_36_1._dropPic[arg_36_1 and 2 or 1]

	for iter_36_0, iter_36_1 in ipairs(var_36_6) do
		local var_36_7 = IconWidget.create({
			_infoId = iter_36_1
		}, 0)

		var_36_4:pushBackCustomItem(var_36_7)
	end

	return arg_36_0:createItemEnd(var_36_0, var_36_2, var_36_5)
end

function var_0_0.setHpBar(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	arg_37_1._label:setString(arg_37_2)
	arg_37_1._label:setColor(arg_37_2 < arg_37_3 and ClientView.COLOR_TEXT_ORANGE or lc.Color3B.white)
	arg_37_1._bar:setPercent(arg_37_2 / arg_37_3 * 100)
end

function var_0_0.challenge(arg_38_0)
	local var_38_0 = arg_38_0._boss._id - 100
	local var_38_1 = P._playerWorld:getRegionLastCity(var_38_0, true)

	if not P._playerWorld:isCityChapterPassed(var_38_1._infoId, 3) then
		ToastManager.push(string.format(Str(STR.UNION_BOSS_CHAPTER_REQUIRED), var_38_0, Str(STR.BATTLE_NAME_01 + var_38_0 - 1)))

		return
	end

	if P:getUnionBossRemainTimes(arg_38_0._boss._id) == 0 then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH_BUY_TIMES), string.format("%s|%s|", Str(STR.CHALLENGE), Str(arg_38_0._boss._info._nameSid))))

		return
	end

	local var_38_2, var_38_3 = P._playerCard:checkTroop(ClientData.getUnionBossTroopIndex(arg_38_0._boss._id))

	if not var_38_2 then
		ToastManager.push(var_38_3)

		return
	end

	if not ClientView.checkCardCapacity() then
		return
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendUnionBossChallenge(arg_38_0._boss._id)
end

function var_0_0.unlock(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0._boss._info
	local var_39_1 = P._playerUnion:getMyUnion()

	if P._playerUnion:canOperate(P._playerUnion.Operate.unlock_boss) ~= Data.ErrorType.ok then
		ToastManager.push(Str(STR.UNION_PRIVILEGE_ERROR))

		return
	end

	if var_39_1._act < var_39_0._unlockRes then
		ToastManager.push(Str(STR.NOT_ENOUGH_UNION_ACT))

		return
	end

	if not arg_39_1 then
		require("Dialog").showDialog(string.format(Str(STR.CONFIRM_UNLOCK_UNION_BOSS), var_39_0._unlockRes, Str(var_39_0._nameSid)), function()
			arg_39_0:unlock(true)
		end)

		return
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendUnionBossUnlock(arg_39_0._boss._id)
end

function var_0_0.editTroop(arg_41_0)
	lc.pushScene(require("HeroCenterScene").create(ClientData.getUnionBossTroopIndex(arg_41_0._boss._id)))
end

function var_0_0.showMemberRank(arg_42_0)
	require("UnionMemberForm").createBossRank(arg_42_0._boss):show()
end

function var_0_0.showServerRank(arg_43_0)
	require("RankForm").create(Data.RankRange.lord, 5, arg_43_0._boss._id):show()
end

function var_0_0.onEnter(arg_44_0)
	arg_44_0._listeners = {}

	table.insert(arg_44_0._listeners, lc.addEventListener(Data.Event.union_boss_dirty, function(arg_45_0)
		local var_45_0 = arg_45_0._param

		if arg_44_0._boss._id == var_45_0 then
			ClientView.getActiveIndicator():hide()
			arg_44_0:updateBossArea()
			arg_44_0:updateChallengeButton()
			arg_44_0:updateAssistants()
		end

		arg_44_0:updateBottomArea()
	end))
end

function var_0_0.onExit(arg_46_0)
	for iter_46_0 = 1, #arg_46_0._listeners do
		lc.Dispatcher:removeEventListener(arg_46_0._listeners[iter_46_0])
	end
end

return var_0_0
