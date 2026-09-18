local var_0_0 = class("EliteForm", BaseForm)
local var_0_1 = 748
local var_0_2 = {
	1,
	2,
	3,
	3,
	4,
	4
}
local var_0_3 = {
	cc.p(78, 574),
	cc.p(150, 444),
	cc.p(80, 310),
	cc.p(175, 166),
	cc.p(335, 256),
	cc.p(404, 426),
	cc.p(522, 560),
	cc.p(750, 560),
	cc.p(966, 610),
	cc.p(1174, 542),
	cc.p(1248, 346),
	cc.p(1130, 100)
}
local var_0_4 = {
	cc.p(168, 170),
	cc.p(70, 302),
	cc.p(180, 460),
	cc.p(356, 546),
	cc.p(582, 586),
	cc.p(788, 520),
	cc.p(908, 408),
	cc.p(1066, 512),
	cc.p(1246, 486),
	cc.p(1176, 296),
	cc.p(998, 220),
	cc.p(788, 232)
}
local var_0_5 = {
	cc.p(60, 252),
	cc.p(150, 390),
	cc.p(304, 190),
	cc.p(394, 404),
	cc.p(594, 236),
	cc.p(760, 262),
	cc.p(844, 456),
	cc.p(1018, 552),
	cc.p(1192, 516),
	cc.p(1290, 346),
	cc.p(1108, 222),
	cc.p(960, 362)
}
local var_0_6

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = ClientView.SCR_W - require("SidePanel").WIDTH + 20
	local var_2_1 = math.floor(arg_2_1 / 10)

	arg_2_0._copyType = arg_2_1
	arg_2_0._copyGroup = var_2_1
	arg_2_0._bonusSprites = {}

	local var_2_2 = ""

	if var_2_1 == Data.CopyType.group_elite then
		var_2_2 = Str(STR.COPY_ELITE)
		var_0_6 = var_0_3
	elseif var_2_1 == Data.CopyType.group_boss then
		var_2_2 = Str(STR.COPY_BOSS)
	elseif var_2_1 == Data.CopyType.group_commander then
		var_2_2 = Str(STR.COPY_COMMANDER)
		var_0_6 = var_0_4
	elseif var_2_1 == Data.CopyType.group_expedition then
		var_2_2 = Str(STR.COPY_EXPEDITION)
		var_0_6 = var_0_5
	end

	var_0_0.super.init(arg_2_0, cc.size(var_2_0, var_0_1), var_2_2, bor(0))

	arg_2_0._resNames = var_2_1 == Data.CopyType.group_expedition and ClientData.loadLCRes("res/expedition.lcres") or {}

	arg_2_0._btnBack:setVisible(false)
	arg_2_0._form:setTouchEnabled(false)
	arg_2_0:createBottomArea()

	local var_2_3 = Data.getCopyStartId(arg_2_1)

	if arg_2_2 == nil then
		if var_2_1 ~= Data.CopyType.group_expedition then
			for iter_2_0 = 1, Data.COPY_LEVEL_COUNT do
				if P._copyPassTimes[var_2_3 + iter_2_0 - 1] == 0 then
					arg_2_2 = iter_2_0

					break
				end
			end
		else
			arg_2_2 = 1
		end
	end

	arg_2_0._level = arg_2_2

	if var_2_1 == Data.CopyType.group_boss then
		arg_2_0:createLevelSelector(var_2_3, arg_2_2)
	else
		arg_2_0:createLevelWidgets(var_2_3, arg_2_2)
	end

	arg_2_0:focusLevel(arg_2_2)

	if var_2_1 == Data.CopyType.group_expedition then
		if P._playerExpedition._isRefreshed then
			arg_2_0:updateStatus()
		else
			ClientView.getActiveIndicator():show(Str(STR.WAITING))
			ClientData.sendGetExpedition()
		end
	end
end

function var_0_0.onCleanup(arg_3_0)
	var_0_0.super.onCleanup(arg_3_0)
	ClientData.unloadLCRes(arg_3_0._resNames)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/copy_list_bg_11.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/copy_list_bg_31.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/copy_list_bg_41.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/copy_list_bg_51.jpg"))
end

function var_0_0.createBottomArea(arg_4_0)
	local var_4_0 = 40

	if arg_4_0._copyGroup == Data.CopyType.group_boss then
		var_4_0 = 160
	elseif arg_4_0._copyGroup == Data.CopyType.group_expedition then
		var_4_0 = 72
	end

	local var_4_1 = lc.createMaskLayer(192, lc.Color3B.black, cc.size(lc.w(arg_4_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, var_4_0))

	var_4_1:setAnchorPoint(0.5, 0)
	lc.addChildToPos(arg_4_0._frame, var_4_1, cc.p(lc.w(arg_4_0._frame) / 2, ClientView.FRAME_INNER_BOTTOM - 4), -1)

	arg_4_0._bottomArea = var_4_1

	local var_4_2 = 30
	local var_4_3 = ClientView.createTTF(Str(STR.RECOMMEND_SKILL) .. ":", nil, ClientView.COLOR_LABEL_LIGHT)

	lc.addChildToPos(var_4_1, var_4_3, cc.p(var_4_2 + lc.w(var_4_3) / 2, lc.h(var_4_1) - var_4_2 - lc.h(var_4_3) / 2 + 6))
	var_4_3:setVisible(false)

	arg_4_0._skillLabel = var_4_3

	local var_4_4 = ClientView.createKeyValueLabel(Str(arg_4_0._copyGroup == Data.CopyType.group_expedition and STR.DAILY_RESTART_TIMES or STR.REMAIN_TIMES), "", ClientView.FontSize.S1, false)

	var_4_4:addToParent(var_4_1, cc.p(lc.w(arg_4_0._bottomArea) - 232, lc.h(var_4_4) / 2 + 8))

	arg_4_0._remainTimes = var_4_4._value

	if arg_4_0._copyGroup == Data.CopyType.group_expedition then
		lc.offset(var_4_4, -220, 0)

		local var_4_5 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_5_0)
			arg_4_0:onReset(true)
		end, ClientView.CRECT_BUTTON_S, 150)

		var_4_5:addLabel(Str(STR.RESTART))
		lc.addChildToPos(var_4_1, var_4_5, cc.p(lc.w(var_4_1) - lc.w(var_4_5) / 2 - 10, lc.h(var_4_5) / 2 + 4))

		arg_4_0._btnReset = var_4_5
	end

	arg_4_0:updateRemainTimes()
end

function var_0_0.createLevelWidgets(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = lc.createSprite("res/jpg/copy_list_bg_" .. arg_6_0._copyType .. ".jpg")
	local var_6_1 = lc.List.createH(cc.size(lc.w(arg_6_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(var_6_0)), 0, 0)

	lc.addChildToCenter(arg_6_0._frame, var_6_1, -2)

	arg_6_0._list = var_6_1

	local var_6_2 = ccui.Widget:create()

	var_6_2:setContentSize(lc.w(var_6_0) - 660, lc.h(var_6_0) + 20)
	lc.addChildToCenter(var_6_2, var_6_0)
	var_6_1:pushBackCustomItem(var_6_2)

	var_6_1._layer = var_6_2

	for iter_6_0 = 1, Data.COPY_LEVEL_COUNT do
		local var_6_3 = ccui.Widget:create()

		var_6_3:setContentSize(60, 60)
		lc.addChildToPos(var_6_2, var_6_3, cc.p(var_0_6[iter_6_0].x, var_0_6[iter_6_0].y), 0, iter_6_0)

		if arg_6_0._copyGroup ~= Data.CopyType.group_expedition then
			var_6_3._info = Data._copyInfo[arg_6_1 + iter_6_0 - 1]
		else
			var_6_3._info = {
				_expeditionTroopId = math.floor(iter_6_0 / 2) + 1
			}
		end

		var_6_3:setTouchEnabled(true)
		var_6_3:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
		var_6_3:addTouchEventListener(function(arg_7_0, arg_7_1)
			if arg_7_1 == ccui.TouchEventType.ended then
				arg_6_0:focusWidget(arg_7_0)
			end
		end)

		if arg_6_0._copyGroup == Data.CopyType.group_expedition then
			var_6_3:setName(iter_6_0 % 2 == 0 and "" or string.format(Str(STR.EXPEDITION_LEVEL), math.floor((iter_6_0 + 1) / 2)))
		else
			var_6_3:setName(arg_6_0:createLevelStr(iter_6_0))
		end

		local var_6_4 = false
		local var_6_5 = (arg_6_0._copyGroup ~= Data.CopyType.group_expedition or false) and P._level < var_6_3._info._unlock

		if arg_6_0._copyGroup == Data.CopyType.group_expedition or P._copyPassTimes[var_6_3._info._id] <= 0 or var_6_5 then
			arg_6_0:addLevelName(var_6_3, false)

			if arg_6_0._copyGroup == Data.CopyType.group_expedition then
				if iter_6_0 % 2 == 0 then
					arg_6_0:addChest(var_6_3, math.floor(iter_6_0 / 2))
				else
					arg_6_0:addAvatar(var_6_3, math.floor(iter_6_0 / 2))
				end
			end

			if var_6_5 then
				var_6_3._isLock = true

				local var_6_6 = lc.createSprite("img_icon_lock")

				var_6_6:setScale(0.8)
				lc.addChildToCenter(var_6_3, var_6_6, 1)
			end
		else
			arg_6_0:addLevelName(var_6_3, true)
		end
	end
end

function var_0_0.createLevelSelector(arg_8_0, arg_8_1, arg_8_2)
	ClientData._copyGoldPropId = nil

	local var_8_0 = lc.createSprite("res/jpg/copy_list_bg_" .. arg_8_0._copyType .. ".jpg")
	local var_8_1 = ccui.Layout:create()

	var_8_1:setContentSize(cc.size(lc.w(arg_8_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(var_8_0)))
	var_8_1:setAnchorPoint(0.5, 0.5)
	var_8_1:setClippingEnabled(true)
	var_8_1:setTouchEnabled(true)
	lc.addChildToCenter(arg_8_0._frame, var_8_1, -2)
	lc.addChildToCenter(var_8_1, var_8_0, -1)

	local var_8_2 = lc.createImageView("img_copy_gold_slot")

	lc.addChildToPos(arg_8_0._bottomArea, var_8_2, cc.p(110, lc.h(var_8_2) / 2 + 6))

	local var_8_3 = ccui.Layout:create()

	var_8_3:setContentSize(cc.size(lc.w(var_8_2) - 20, lc.h(var_8_2)))
	var_8_3:setAnchorPoint(0.5, 0.5)
	var_8_3:setClippingEnabled(true)
	lc.addChildToCenter(var_8_2, var_8_3)

	arg_8_0._levelArea = var_8_3

	local var_8_4 = lc.createSprite("img_copy_gold_slot_icon")

	lc.addChildToCenter(var_8_3, var_8_4)

	arg_8_0._levelFg = var_8_4

	local var_8_5 = lc.createSprite(string.format("img_copy_gold_%02d", arg_8_2))

	lc.addChildToCenter(var_8_4, var_8_5)

	local var_8_6 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.SELECT) .. Str(STR.DIFFICULTY))

	lc.addChildToPos(arg_8_0._bottomArea, var_8_6, cc.p(lc.x(var_8_2), lc.top(var_8_2) + 4 + lc.h(var_8_6) / 2))

	local var_8_7 = 40
	local var_8_8 = 40
	local var_8_9 = ClientView.createArrowButton(true, cc.size(var_8_7, var_8_8), function(arg_9_0)
		arg_8_0:onSelectLevel(arg_9_0)
	end)

	var_8_9:setVisible(arg_8_2 > 1)
	var_8_9:setTouchRect(cc.rect(-30, -30, 90, 90))
	lc.addChildToPos(arg_8_0._bottomArea, var_8_9, cc.p(lc.left(var_8_2) - 10 - var_8_7 / 2, lc.y(var_8_2)))

	arg_8_0._btnArrowLeft = var_8_9

	local var_8_10 = ClientView.createArrowButton(false, cc.size(var_8_7, var_8_8), function(arg_10_0)
		arg_8_0:onSelectLevel(arg_10_0)
	end)

	var_8_10:setVisible(arg_8_2 < Data.COPY_LEVEL_COUNT)
	var_8_10:setTouchRect(cc.rect(-30, -30, 90, 90))
	lc.addChildToPos(arg_8_0._bottomArea, var_8_10, cc.p(lc.right(var_8_2) + 10 + var_8_7 / 2, lc.y(var_8_2)))

	arg_8_0._btnArrowRight = var_8_10

	local var_8_11 = ClientView.createShaderButton("img_slot", function(arg_11_0)
		require("SelectIconForm").create(function(arg_12_0)
			arg_8_0:onSelectProp(arg_12_0)
		end, ClientData._copyGoldPropId):show()
	end)

	lc.addChildToPos(arg_8_0._bottomArea, var_8_11, cc.p(300, lc.y(var_8_2)))

	local var_8_12 = lc.createSprite("img_icon_add_big")

	var_8_12:setScale(0.4)
	lc.addChildToCenter(var_8_11, var_8_12)

	arg_8_0._propBtn = var_8_11

	local var_8_13 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.SELECT) .. Str(STR.PROPS))

	lc.addChildToPos(arg_8_0._bottomArea, var_8_13, cc.p(lc.x(var_8_11), lc.y(var_8_6)))
end

function var_0_0.onSelectLevel(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._level

	if arg_13_1 == arg_13_0._btnArrowLeft then
		arg_13_0._level = math.max(1, arg_13_0._level - 1)
	else
		arg_13_0._level = math.min(Data.COPY_LEVEL_COUNT, arg_13_0._level + 1)
	end

	if var_13_0 ~= arg_13_0._level then
		local var_13_1 = var_13_0 < arg_13_0._level and -100 or 100

		arg_13_0._levelFg:runAction(lc.sequence(lc.moveBy(0.3, var_13_1, 0), lc.remove()))
		arg_13_0._levelFg._panel:hide()

		local var_13_2 = lc.createSprite("img_copy_gold_slot_icon")

		lc.addChildToCenter(arg_13_0._levelArea, var_13_2)
		lc.offset(var_13_2, -var_13_1, 0)

		arg_13_0._levelFg = var_13_2

		local var_13_3 = lc.createSprite(string.format("img_copy_gold_%02d", arg_13_0._level))

		lc.addChildToCenter(var_13_2, var_13_3)
		arg_13_0._levelFg:runAction(lc.moveBy(0.3, var_13_1, 0))
		arg_13_0:focusLevel(arg_13_0._level)
	end

	arg_13_0._btnArrowLeft:setVisible(arg_13_0._level > 1)
	arg_13_0._btnArrowRight:setVisible(arg_13_0._level < Data.COPY_LEVEL_COUNT)
end

function var_0_0.focusLevel(arg_14_0, arg_14_1)
	if arg_14_0._list ~= nil then
		local var_14_0 = arg_14_0._list._layer:getChildByTag(arg_14_1)

		arg_14_0:focusWidget(var_14_0)
	else
		local var_14_1 = Data.getCopyStartId(arg_14_0._copyType)
		local var_14_2 = Data._copyInfo[var_14_1 + arg_14_1 - 1]
		local var_14_3 = require("CopyPanel").create(arg_14_0:createLevelStr(arg_14_1), var_14_2)

		var_14_3:addCloseButton(arg_14_0._btnBack._callback)
		arg_14_0:addChild(var_14_3)

		arg_14_0._levelFg._panel = var_14_3
	end
end

function var_0_0.onSelectProp(arg_15_0, arg_15_1)
	ClientData._copyGoldPropId = arg_15_1

	if arg_15_0._propBtn._icon then
		arg_15_0._propBtn._icon:removeFromParent()
	end

	local var_15_0 = IconWidget.create({
		_count = 1,
		_infoId = arg_15_1
	}, IconWidget.DisplayFlag.COUNT)

	var_15_0:setTouchEnabled(false)
	lc.addChildToCenter(arg_15_0._propBtn, var_15_0)

	arg_15_0._propBtn._icon = var_15_0
end

function var_0_0.focusWidget(arg_16_0, arg_16_1)
	if arg_16_0._focusWidget then
		if arg_16_0._focusWidget == arg_16_1 then
			return
		else
			arg_16_0:unfocusWidget()
		end
	end

	if arg_16_1._circle == nil then
		local var_16_0 = lc.createSprite("img_circle_02")

		var_16_0:setScale(arg_16_0._copyGroup ~= Data.CopyType.group_elite and 1.6 or 1, arg_16_0._copyGroup ~= Data.CopyType.group_elite and 0.8 or 1)
		lc.addChildToCenter(arg_16_1, var_16_0)

		arg_16_1._circle = var_16_0

		local var_16_1 = lc.createSprite("img_circle_03")

		var_16_1:runAction(lc.rep(lc.sequence(lc.spawn(lc.scaleTo(1, 1.4), lc.fadeOut(1)), function()
			var_16_1:setScale(0.8)
			var_16_1:setOpacity(255)
		end)))
		lc.addChildToCenter(var_16_0, var_16_1, -1)
	end

	if arg_16_1._avatarBg then
		arg_16_1._avatarBg:setScale(1.2)
		arg_16_1._avatarBg:setSpriteFrame("img_expedition_mark_01")
		arg_16_1._avatar:setPositionY(arg_16_1._avatar._posY)
	end

	if arg_16_1._isLock then
		ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), arg_16_1._info._unlock))
	end

	arg_16_0._focusWidget = arg_16_1

	local var_16_2 = require("CopyPanel").create(arg_16_1:getName(), arg_16_1._info)

	var_16_2:addCloseButton(arg_16_0._btnBack._callback)
	arg_16_0:addChild(var_16_2)

	arg_16_1._panel = var_16_2

	arg_16_0:jumpToWidget(arg_16_1)
end

function var_0_0.unfocusWidget(arg_18_0)
	local var_18_0 = arg_18_0._focusWidget

	if var_18_0 == nil then
		return
	end

	if var_18_0._circle then
		var_18_0._circle:removeFromParent()

		var_18_0._circle = nil
	end

	if var_18_0._avatarBg then
		var_18_0._avatarBg:setScale(1)
		var_18_0._avatarBg:setSpriteFrame("img_expedition_mark")
		var_18_0._avatar:setPositionY(var_18_0._avatar._posY)
	end

	if var_18_0._isLock then
		-- block empty
	end

	var_18_0._panel:hide()

	arg_18_0._focusWidget = nil
end

function var_0_0.jumpToWidget(arg_19_0, arg_19_1)
	local var_19_0
	local var_19_1 = arg_19_1:getPositionX()
	local var_19_2 = var_19_1 < lc.w(arg_19_0._list) / 2 and 0 or var_19_1 > lc.w(arg_19_0._list._layer) - lc.w(arg_19_0._list) / 2 and 100 or (var_19_1 - lc.w(arg_19_0._list) / 2) * 100 / (lc.w(arg_19_0._list._layer) - lc.w(arg_19_0._list))

	arg_19_0._list:forceDoLayout()
	arg_19_0._list:jumpToPercentHorizontal(var_19_2)
end

function var_0_0.addLevelName(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_20_1:getName())

	lc.addChildToPos(arg_20_1, var_20_0, cc.p(lc.w(arg_20_1) / 2, arg_20_2 and lc.h(arg_20_1) + lc.h(var_20_0) / 2 - 8 or -lc.h(var_20_0) / 2 + 8))
end

function var_0_0.addLevelScore(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = lc.createSprite("img_icon_score")
	local var_21_1 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_21_2)
	local var_21_2 = lc.w(var_21_0) + lc.w(var_21_1) + 10

	lc.addChildToPos(arg_21_1, var_21_0, cc.p(lc.w(arg_21_1) / 2 - var_21_2 / 2 + lc.w(var_21_0) / 2, lc.h(arg_21_1) + lc.h(var_21_0) / 2 - 8))
	lc.addChildToPos(arg_21_1, var_21_1, cc.p(lc.right(var_21_0) + 10 + lc.w(var_21_1) / 2, lc.y(var_21_0) + 2))
end

function var_0_0.addChest(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1:setTouchEnabled(false)

	local var_22_0 = ClientView.createShaderButton(string.format("img_chest_close_%d", var_0_2[arg_22_2]), function(arg_23_0)
		arg_22_0:onSelectExpeditionBonus(arg_22_2)
	end)

	var_22_0:setAnchorPoint(0.5, 0)

	var_22_0._quality = var_0_2[arg_22_2]

	lc.addChildToCenter(arg_22_1, var_22_0)
	lc.offset(var_22_0, 0, 12)
	table.insert(arg_22_0._bonusSprites, var_22_0)
end

function var_0_0.addAvatar(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = lc.createSprite("img_expedition_mark")

	lc.addChildToPos(arg_24_1:getParent(), var_24_0, cc.p(lc.x(arg_24_1) - 2, lc.y(arg_24_1) + 70))

	var_24_0._pos = cc.p(var_24_0:getPosition())

	local var_24_1 = string.format("img_expedition_avatar_%02d", arg_24_2 + 2)

	if ClientData.isAnotherSkin() and lc.FrameCache:getSpriteFrame(var_24_1 .. "_2") then
		var_24_1 = var_24_1 .. "_2"
	elseif ClientData.isAnotherCardImageSkin() and lc.FrameCache:getSpriteFrame(var_24_1 .. "_3") then
		var_24_1 = var_24_1 .. "_3"
	end

	local var_24_2 = lc.createSprite(var_24_1)

	lc.addChildToPos(var_24_0, var_24_2, cc.p(lc.w(var_24_0) / 2, lc.h(var_24_0) - lc.ch(var_24_2) * 0.7 - 12))
	var_24_2:setScale(0.7)

	var_24_2._posY = var_24_2:getPositionY()

	var_24_0:runAction(lc.rep(lc.sequence(lc.moveTo(0.5, cc.p(var_24_0._pos.x, var_24_0._pos.y - 10)), lc.moveTo(0.5, var_24_0._pos))))

	arg_24_1._avatarBg = var_24_0
	arg_24_1._avatar = var_24_2
end

function var_0_0.updateRecommandSkills(arg_25_0, arg_25_1)
	if arg_25_0._recSkills then
		arg_25_0._recSkills:removeFromParent()
	end

	local var_25_0 = Data._skillInfo
	local var_25_1 = ccui.RichTextEx:create()

	var_25_1:setMaxWidth(lc.w(arg_25_0._bottomArea) - 30 - lc.right(arg_25_0._skillLabel))
	var_25_1:addEventListenerRichText(function(arg_26_0)
		local var_26_0 = arg_25_1[arg_26_0:getTag()]

		require("IllustrationForm").create(Str(var_25_0[var_26_0]._nameSid)):show()
	end)

	arg_25_0._recSkills = var_25_1

	local function var_25_2(arg_27_0, arg_27_1)
		local var_27_0
		local var_27_1

		if type(arg_27_0) == "string" then
			var_27_0 = arg_27_0
		elseif arg_27_0 < 1000 then
			var_27_0 = Str(STR.SKILL_TYPE_1 + arg_27_0 - 1)
		else
			var_27_0 = string.format(Str(STR.BRACKETS_S), Str(var_25_0[arg_27_0]._nameSid))
			var_27_1 = true
		end

		if var_27_1 then
			var_25_1:insertElement(ccui.RichItemText:create(arg_27_1 or 0, ClientView.COLOR_TEXT_GREEN_DARK, 255, var_27_0, ClientView.TTF_FONT, ClientView.FontSize.S2))
		else
			var_25_1:insertElement(ccui.RichItemLabel:create(0, ClientView.COLOR_TEXT_LIGHT, 255, var_27_0, ClientView.TTF_FONT, ClientView.FontSize.S2))
		end
	end

	var_25_2(arg_25_1[1], 1)

	for iter_25_0 = 2, #arg_25_1 do
		var_25_2(",")
		var_25_2(arg_25_1[iter_25_0], iter_25_0)
	end

	var_25_2(Str(STR.SO_ON))
	var_25_1:formatText()
	lc.addChildToPos(arg_25_0._bottomArea, var_25_1, cc.p(lc.right(arg_25_0._skillLabel) + lc.w(var_25_1) / 2, lc.y(arg_25_0._skillLabel)))
end

function var_0_0.updateRemainTimes(arg_28_0)
	arg_28_0._remainTimes:setString(string.format("%d/%d", P:getChallengeCopyRemainTimes(arg_28_0._copyType), P:getCopyTotalTimes(arg_28_0._copyType)))

	if arg_28_0._copyGroup == Data.CopyType.expedition then
		-- block empty
	end
end

function var_0_0.createLevelStr(arg_29_0, arg_29_1)
	if arg_29_1 <= 10 then
		return string.format("%s%s", Str(STR.DIFFICULTY), Str(STR.NUM_1 + arg_29_1 - 1))
	else
		return string.format("%s%s%s", Str(STR.DIFFICULTY), Str(STR.NUM_10), Str(STR.NUM_1 + arg_29_1 % 10 - 1))
	end
end

function var_0_0.updateStatus(arg_30_0)
	local var_30_0 = 6

	for iter_30_0 = 1, var_30_0 do
		local var_30_1 = arg_30_0._bonusSprites[iter_30_0]
		local var_30_2 = P._playerExpedition._troopInfos[iter_30_0]
		local var_30_3 = P._playerExpedition._chests[iter_30_0]

		var_30_1:removeAllChildren()

		if var_30_3._opened then
			var_30_1:loadTextureNormal(string.format("img_chest_open_%d", var_30_1._quality), ccui.TextureResType.plistType)
		elseif iter_30_0 <= P._playerExpedition._chapter then
			var_30_1:loadTextureNormal(string.format("img_chest_full_%d", var_30_1._quality), ccui.TextureResType.plistType)

			local var_30_4 = Particle.create("par_kbx2")

			var_30_4:setAutoRemoveOnFinish(false)
			var_30_4:runAction(lc.rep(lc.sequence(4, function()
				var_30_4:resetSystem()
			end)))
			lc.addChildToPos(var_30_1, var_30_4, cc.p(lc.w(var_30_1) / 2 - 10, lc.h(var_30_1) / 2))
		elseif iter_30_0 == P._playerExpedition._chapter + 1 then
			var_30_1:loadTextureNormal(string.format("img_chest_close_%d", var_30_1._quality), ccui.TextureResType.plistType)
		else
			var_30_1:loadTextureNormal(string.format("img_chest_close_%d", var_30_1._quality), ccui.TextureResType.plistType)
		end
	end

	if var_30_0 > P._playerExpedition._chapter then
		arg_30_0:unfocusWidget()
		arg_30_0:focusLevel(P._playerExpedition._chapter * 2 + 1)
	end
end

function var_0_0.onSelectExpeditionBonus(arg_32_0, arg_32_1)
	if P._playerExpedition._chests[arg_32_1]._opened then
		ToastManager.push(Str(STR.BOX_OPENED))

		return
	elseif arg_32_1 > P._playerExpedition._chapter then
		ToastManager.push(string.format(Str(STR.WIN_EXPEDITION_CAN_OPEN), arg_32_1))

		return
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendOpenExpedition()
end

function var_0_0.onMsg(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1.type
	local var_33_1 = arg_33_1.status

	if var_33_0 == SglMsgType_pb.PB_TYPE_WORLD_GET_EXPEDITION then
		ClientView.getActiveIndicator():hide()

		local var_33_2 = arg_33_1.Extensions[World_pb.SglWorldMsg.world_get_expedition_resp]

		P._dailyExpedition = var_33_2.count

		P._playerExpedition:refresh(var_33_2.data)
		arg_33_0:updateStatus()
		arg_33_0:updateRemainTimes()

		return true
	elseif var_33_0 == SglMsgType_pb.PB_TYPE_WORLD_REFRESH_EXPEDITION then
		ClientView.getActiveIndicator():hide()
		P._playerExpedition:refresh(arg_33_1.Extensions[World_pb.SglWorldMsg.world_refresh_expedition_resp])
		arg_33_0:updateStatus()
		ToastManager.push(Str(STR.REFRESH_SUCCESS))

		return true
	elseif var_33_0 == SglMsgType_pb.PB_TYPE_WORLD_EXPEDITION_OPEN then
		ClientView.getActiveIndicator():hide()

		P._playerExpedition._chests[P._playerExpedition._chapter]._opened = true

		arg_33_0:updateStatus()

		local var_33_3 = require("RewardPanel")

		var_33_3.create(arg_33_1.Extensions[World_pb.SglWorldMsg.world_expedition_open_resp], var_33_3.MODE_CHEST):show()

		return true
	elseif var_33_0 == SglMsgType_pb.PB_TYPE_WORLD_SWEEP_EXPEDITION then
		ClientView.getActiveIndicator():hide()

		local var_33_4 = arg_33_1.Extensions[World_pb.SglWorldMsg.world_sweep_resp]

		ClientView.showSweepForm(var_33_4)

		local var_33_5 = #var_33_4.result
		local var_33_6 = P._playerExpedition
		local var_33_7 = var_33_6._chapter + 1
		local var_33_8 = var_33_6._chests

		for iter_33_0 = var_33_7, var_33_7 + var_33_5 - 1 do
			var_33_8[iter_33_0]._opened = true
		end

		var_33_6._chapter = var_33_6._chapter + var_33_5

		arg_33_0:updateStatus()

		local var_33_9 = P:getBattleCost() * var_33_5

		P:changeResource(Data.ResType.grain, -var_33_9)
		arg_33_0:updateSweepArea()

		return true
	end
end

function var_0_0.show(arg_34_0, arg_34_1)
	lc._runningScene._scene:addChild(arg_34_0, ClientData.ZOrder.form)
	arg_34_0._form:setPositionX(lc.w(arg_34_0._form) / 2)
end

function var_0_0.onReset(arg_35_0, arg_35_1)
	if P:getChallengeCopyRemainTimes(arg_35_0._copyType) == 0 and P:getBuyCopyRemainTimes(arg_35_0._copyType) == 0 then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH_BUY_TIMES), Str(STR.BUY) .. Str(STR.ATTACK_TIMES)))

		return
	end

	if P._playerExpedition._chapter < #P._playerExpedition._troopInfos and arg_35_1 then
		local var_35_0 = require("Dialog").showDialog(Str(STR.SURE_TO_EXPEDITION))

		function var_35_0._okHandler()
			var_35_0:hide(true)
			arg_35_0:onReset(false)
		end

		return
	end

	if P:getChallengeCopyRemainTimes(arg_35_0._copyType) == 0 then
		if P:getBuyCopyRemainTimes(arg_35_0._copyType) > 0 then
			local var_35_1 = P:getBuyCopyIngot(arg_35_0._copyType)
			local var_35_2 = require("Dialog").showDialog(string.format(Str(STR.SURE_TO_BUY_CHALLENGE), var_35_1, 1))

			function var_35_2._okHandler()
				if ClientView.checkIngot(var_35_1) then
					P:changeResource(Data.ResType.ingot, -var_35_1)
					P:addBuyCopyTimes(arg_35_0._copyType)
					var_35_2:hide(true)
					arg_35_0:onReset(arg_35_1)
				end
			end
		end

		return
	end

	P._dailyExpedition = P._dailyExpedition + 1

	arg_35_0:updateRemainTimes()
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendRefreshExpedition()
end

function var_0_0.hide(arg_38_0)
	arg_38_0:removeFromParent()
end

function var_0_0.onEnter(arg_39_0)
	var_0_0.super.onEnter(arg_39_0)
	ClientData.addMsgListener(arg_39_0, function(arg_40_0)
		return arg_39_0:onMsg(arg_40_0)
	end, 0)

	if arg_39_0._list ~= nil and arg_39_0._level > 1 then
		local var_39_0 = arg_39_0._list._layer:getChildByTag(arg_39_0._level)

		arg_39_0:jumpToWidget(var_39_0)
	end

	arg_39_0._listeners = {}

	table.insert(arg_39_0._listeners, lc.addEventListener(Data.Event.copy_times_dirty, function(arg_41_0)
		if arg_39_0._copyType == arg_41_0._param._type then
			arg_39_0:updateRemainTimes()
		end
	end))

	if GuideManager.isGuideEnabled() then
		GuideManager.finishStep()
	end
end

function var_0_0.onExit(arg_42_0)
	var_0_0.super.onExit(arg_42_0)

	for iter_42_0, iter_42_1 in ipairs(arg_42_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_42_1)
	end

	ClientData.removeMsgListener(arg_42_0)
end

return var_0_0
