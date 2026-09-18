local var_0_0 = class("IconWidget", lc.ExtendUIWidget)

var_0_0.SIZE = 92
var_0_0.DisplayFlag = {
	COUNT = 4,
	LEVEL = 2,
	NAME = 16,
	COUNT_RANGE = 32
}
var_0_0.DisplayFlag.ITEM = bor(var_0_0.DisplayFlag.COUNT, var_0_0.DisplayFlag.NAME)
var_0_0.DisplayFlag.ITEM_RANGE = bor(var_0_0.DisplayFlag.COUNT_RANGE, var_0_0.DisplayFlag.NAME)
var_0_0.DisplayFlag.ITEM_NO_NAME = bor(var_0_0.DisplayFlag.COUNT)
var_0_0.DisplayFlag.CARD_TROOP = bor(var_0_0.DisplayFlag.LEVEL, var_0_0.DisplayFlag.COUNT)
var_0_0.DisplayFlag.CARD_REBIRTH = bor(var_0_0.DisplayFlag.NAME)

local var_0_1 = require("CardInfoPanel")

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = lc.Pool.get("IconWidget")
	local var_1_1 = var_1_0._data

	var_1_1._infoId = arg_1_0._infoId
	var_1_1._count = arg_1_0._count or arg_1_0._num
	var_1_1._param = arg_1_0._param
	var_1_1._showOwnCount = arg_1_0._showOwnCount
	var_1_1._cardList = arg_1_0._cardList
	var_1_1._index = arg_1_0._index
	var_1_1._title = arg_1_0._title

	var_1_0:resetIcon()
	var_1_0:setData(var_1_1, arg_1_1)

	return var_1_0
end

function var_0_0.createByBonus(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = lc.Pool.get("IconWidget")
	local var_2_1 = var_2_0._data

	var_2_1._infoId = arg_2_0._rid[arg_2_1]
	var_2_1._count = arg_2_0._count[arg_2_1]
	var_2_1._param = arg_2_0._param

	var_2_0:resetIcon()
	var_2_0:setData(var_2_1, arg_2_2)

	return var_2_0
end

function var_0_0.createByInfoId(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = lc.Pool.get("IconWidget")
	local var_3_1 = var_3_0._data

	var_3_1._infoId = arg_3_0
	var_3_1._count = arg_3_1

	var_3_0:resetIcon()
	var_3_0:setData(var_3_1, arg_3_2 or var_0_0.DisplayFlag.CARD_TROOP)

	return var_3_0
end

function var_0_0.resetData(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._data

	var_4_0._infoId = arg_4_1._infoId
	var_4_0._count = arg_4_1._count or arg_4_1._num
	var_4_0._param = arg_4_1._param

	arg_4_0:setData(var_4_0, arg_4_0._flag)
end

function var_0_0.resetDataByBonus(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._data

	var_5_0._infoId = arg_5_1._rid[arg_5_2]
	var_5_0._count = arg_5_1._count[arg_5_2]
	var_5_0._param = arg_5_1._param

	arg_5_0:setData(var_5_0, arg_5_0._flag)
end

function var_0_0.init(arg_6_0)
	arg_6_0:setCascadeOpacityEnabled(true)

	arg_6_0._data = {}
	arg_6_0._nameColor = ClientView.COLOR_TEXT_DARK

	local var_6_0 = cc.ShaderSprite:createWithFramename("card_icon_quality_00")

	var_6_0:setCascadeOpacityEnabled(true)
	if lc.w(var_6_0) == 0 then
		var_6_0:setContentSize(cc.size(var_0_0.SIZE, var_0_0.SIZE))
	end
	arg_6_0:addProtectedChild(var_6_0)

	arg_6_0._frame = var_6_0

	local var_6_1 = cc.ShaderSprite:createWithFramename("img_blank")

	lc.addChildToCenter(var_6_0, var_6_1, -1)

	arg_6_0._img = var_6_1

	lc.addChildToCenter(var_6_0, lc.createSprite("img_card_ico_bg"), -2)

	local var_6_2 = lc.createSprite("icon_mask")

	var_6_2:setCascadeOpacityEnabled(true)
	lc.addChildToPos(var_6_0, var_6_2, cc.p(lc.w(var_6_0) / 2, lc.h(var_6_2) / 2 + 10), -1)

	local var_6_3 = ClientView.createBMFont(ClientView.BMFont.huali_20, "")

	var_6_3:setScale(0.8)
	var_6_3:setAnchorPoint(1, 0.5)
	lc.addChildToPos(var_6_2, var_6_3, cc.p(lc.w(var_6_2), lc.h(var_6_2) / 2))

	var_6_2._count = var_6_3
	arg_6_0._countLabel = var_6_3
	arg_6_0._countBg = var_6_2

	local var_6_4 = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.M1)

	var_6_4:setScale(0.6)
	arg_6_0:addProtectedChild(var_6_4)

	arg_6_0._name = var_6_4

	function arg_6_0.setGray(arg_7_0, arg_7_1)
		if arg_7_1 then
			arg_7_0._frame:setEffect(ClientView.SHADER_DISABLE)
			arg_7_0._img:setEffect(ClientView.SHADER_DISABLE)
			if arg_7_0._cardImg then
				arg_7_0._cardImg:setEffect(ClientView.SHADER_DISABLE)
			end
		else
			arg_7_0._frame:setEffect(arg_7_0._frame._shader)
			arg_7_0._img:setEffect(arg_7_0._img._shader)
			if arg_7_0._cardImg then
				arg_7_0._cardImg:setEffect(arg_7_0._cardImg._shader)
			end
		end
	end

	arg_6_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

	local var_6_5 = arg_6_0.setEnabled

	function arg_6_0.setEnabled(arg_8_0, arg_8_1)
		arg_8_0:setGray(not arg_8_1)
		arg_8_0:setTouchEnabled(arg_8_1)
		var_6_5(arg_8_0, arg_8_1)
	end
end

function var_0_0.resetIcon(arg_9_0)
	arg_9_0:setAnchorPoint(0.5, 0.5)
	arg_9_0:setPosition(0, 0)
	arg_9_0:setRotation(0)
	arg_9_0:setScale(1)
	arg_9_0:setOpacity(255)
	arg_9_0:setVisible(true)
	arg_9_0:setCameraMask(ClientData.CAMERA_2D_FLAG)

	arg_9_0._nameColor = ClientView.COLOR_TEXT_DARK
	arg_9_0._callback = nil
	arg_9_0._touchHandles = nil

	if arg_9_0._cardImg then
		arg_9_0._cardImg:removeFromParent()
		arg_9_0._cardImg = nil
	end

	if arg_9_0._img then
		arg_9_0._img:setSpriteFrame("img_blank")
		arg_9_0._img:setVisible(true)
		arg_9_0._img:setScale(1)
		arg_9_0._img:setEffect(nil)
		arg_9_0._img._shader = nil
	end

	if arg_9_0._name then
		arg_9_0._name:setScale(0.6)
	end

	if arg_9_0._fragmentIcon then
		arg_9_0._fragmentIcon:removeFromParent()

		arg_9_0._fragmentIcon = nil
	end

	if arg_9_0._skillBadge then
		arg_9_0._skillBadge:removeFromParent()

		arg_9_0._skillBadge = nil
	end

	arg_9_0:removeAllChildren()
	arg_9_0:setEnabled(true)

	local function var_9_0(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_1 == ccui.TouchEventType.began then
			local var_10_0 = 0.3

			arg_9_0._longPressTime = 0
			arg_9_0._isLongPressing = nil

			if arg_9_0._touchHandles and arg_9_0._touchHandles._beginHandle then
				arg_9_0._touchHandles._beginHandle(arg_10_0, arg_10_1, arg_10_2)
			end

			arg_9_0._longPressID = lc.Scheduler:scheduleScriptFunc(function(arg_11_0)
				if not arg_9_0._isLongPressing then
					arg_9_0._longPressTime = arg_9_0._longPressTime + arg_11_0

					if arg_9_0._longPressTime >= var_10_0 then
						arg_9_0._isLongPressing = true

						if arg_9_0._touchHandles and arg_9_0._touchHandles._longHandle then
							arg_9_0._touchHandles._longHandle(arg_10_0, arg_10_1, arg_10_2)
						else
							local var_11_0 = require("TopMostPanel").DescPanel.createByInfoId(arg_9_0._data._infoId, false)

							if var_11_0 then
								local var_11_1 = lc.w(var_11_0) / 2
								local var_11_2 = lc.h(var_11_0) / 2
								local var_11_3 = cc.pAdd(lc.convertPos(cc.p(lc.w(arg_9_0) / 2, lc.h(arg_9_0)), arg_9_0), cc.p(0, var_11_2 + 6))

								if var_11_3.x - var_11_1 < 0 then
									var_11_3.x = var_11_1
								elseif var_11_3.x + var_11_1 > ClientView.SCR_W then
									var_11_3.x = ClientView.SCR_W - var_11_1
								end

								if var_11_3.y + var_11_2 > ClientView.SCR_H then
									var_11_3.y = ClientView.SCR_H - var_11_2
								elseif var_11_3.y - var_11_2 < 0 then
									var_11_3.y = var_11_2
								end

								var_11_0:setPosition(var_11_3)
								var_11_0:show()
							end
						end
					end
				end
			end, lc.absTime(0.1), false)
		elseif arg_10_1 == ccui.TouchEventType.moved then
			if cc.pGetDistance(arg_10_0:getTouchMovePosition(), arg_10_0:getTouchBeganPosition()) > lc.Gesture.BUDGE_LIMIT then
				arg_9_0:cancelLongPress()

				if arg_9_0._isLongPressing then
					BasePanel.hideTopMost()
				end
			end

			if arg_9_0._touchHandles and arg_9_0._touchHandles._moveHandle then
				arg_9_0._touchHandles._moveHandle(arg_10_0, arg_10_1, arg_10_2)
			end
		elseif arg_10_1 == ccui.TouchEventType.ended or arg_10_1 == ccui.TouchEventType.canceled then
			if arg_9_0._touchHandles and arg_9_0._touchHandles._endHandle then
				arg_9_0._touchHandles._endHandle(arg_10_0, arg_10_2)
			end

			arg_9_0:cancelLongPress()

			if arg_9_0._isLongPressing then
				BasePanel.hideTopMost()

				return
			end

			if (not arg_9_0._touchHandles or not arg_9_0._touchHandles._endHandle) and arg_10_1 == ccui.TouchEventType.ended then
				if arg_9_0._callback then
					arg_9_0._callback(arg_10_0)
				else
					local var_10_1 = arg_9_0._data
					local var_10_2 = lc._runningScene
					local var_10_3

					if var_10_1._infoId > 0 then
						if GuideManager.isGuideEnabled() then
							GuideManager.pauseGuide()
						end

						local var_10_4 = Data.getType(var_10_1._infoId)

						if var_10_4 == Data.CardType.nature or var_10_4 == Data.CardType.category or var_10_4 == Data.CardType.keyword or var_10_4 == Data.CardType.flag then
							return
						end

						if var_10_4 == Data.CardType.res or var_10_4 == Data.CardType.exp or var_10_4 == Data.CardType.props or var_10_4 == Data.CardType.common_fragment or var_10_4 == Data.CardType.card_skill or var_10_4 == Data.CardType.item_skill then
							var_10_3 = require("DescForm").create(var_10_1)

							var_10_3:show()
						else
							local var_10_5 = var_0_1.create(var_10_1._infoId)

							if var_10_1._cardList ~= nil then
								var_10_5:setCardList(var_10_1._cardList, var_10_1._index, var_10_1._title)
								var_10_5:setCardCount(var_10_1._count)
							end

							var_10_5:show()
						end

						if var_10_3 and var_10_2._sceneId == ClientData.SceneId.battle then
							var_10_3:setLocalZOrder(BattleScene.ZOrder.form + 1)
						end
					end
				end
			end
		end
	end

	arg_9_0:addTouchEventListener(var_9_0)
end

function var_0_0.registerTouchHandles(arg_12_0, arg_12_1)
	arg_12_0._touchHandles = arg_12_1
end

function var_0_0.setData(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._frame
	local var_13_1 = arg_13_0._img
	local var_13_2 = arg_13_0._name

	var_13_1:removeAllChildren()

	arg_13_2 = arg_13_2 or var_0_0.DisplayFlag.ITEM
	arg_13_0._flag = arg_13_2

	local var_13_3 = arg_13_1._count

	if Data.getType(arg_13_1._infoId) == Data.CardType.props and arg_13_1._infoId >= Data.PropsId.special then
		var_13_3 = nil
	end

	if var_13_3 and var_13_3 >= 0 and band(arg_13_2, var_0_0.DisplayFlag.COUNT) ~= 0 then
		arg_13_0._countBg:setVisible(true)
		arg_13_0._countBg._count:setVisible(true)
		arg_13_0._countBg._count:setColor(lc.Color3B.white)
		arg_13_0._countBg._count:setString(ClientData.formatNum(var_13_3, 9999))
	elseif arg_13_1._param and band(arg_13_2, var_0_0.DisplayFlag.COUNT_RANGE) ~= 0 then
		arg_13_0._countBg:setVisible(true)
		arg_13_0._countBg._count:setVisible(true)
		arg_13_0._countBg._count:setColor(lc.Color3B.white)
		arg_13_0._countBg._count:setString(string.format("%s-%s", ClientData.formatNum(arg_13_1._param._min, 9999), ClientData.formatNum(arg_13_1._param._max, 9999)))
	else
		arg_13_0._countBg:setVisible(false)
		arg_13_0._countBg._count:setVisible(false)
	end

	if band(arg_13_2, var_0_0.DisplayFlag.NAME) ~= 0 then
		local var_13_4 = ClientData.getNameByInfoId(arg_13_1._infoId)

		var_13_2:setVisible(true)
		var_13_2:setScale(0.6)
		var_13_2:setString(var_13_4)
		var_13_2:setColor(arg_13_0._nameColor)
		-- item names sit under a fixed-width icon, in a grid: a Vietnamese name
		-- that runs past the icon runs into its neighbours
		local var_frame_w = lc.w(var_13_0) > 0 and lc.w(var_13_0) or var_0_0.SIZE
		local var_frame_h = lc.h(var_13_0) > 0 and lc.h(var_13_0) or var_0_0.SIZE
		ClientView.fitLabel(var_13_2, var_frame_w + 8)
		arg_13_0:setContentSize(var_frame_w, var_frame_h + 24)
		var_13_2:setPosition(lc.w(arg_13_0) / 2, lc.sh(var_13_2) / 2)
		var_13_0:setPosition(lc.w(arg_13_0) / 2, lc.h(arg_13_0) - var_frame_h / 2)
	else
		var_13_2:setVisible(false)
		local var_frame_w = lc.w(var_13_0) > 0 and lc.w(var_13_0) or var_0_0.SIZE
		local var_frame_h = lc.h(var_13_0) > 0 and lc.h(var_13_0) or var_0_0.SIZE
		arg_13_0:setContentSize(var_frame_w, var_frame_h)
		var_13_0:setPosition(lc.w(arg_13_0) / 2, lc.h(arg_13_0) / 2)
	end

	if arg_13_0._decArea then
		arg_13_0._decArea:removeFromParent()

		arg_13_0._decArea = nil
	end

	var_13_1:removeAllChildren()
	var_13_1:setScale(1)

	if arg_13_1._infoId == 604 then
		local var_13_5
	end

	local var_13_6, var_13_7 = Data.getInfo(arg_13_1._infoId)

	if var_13_6 == nil and var_13_7 ~= Data.CardType.nature and var_13_7 ~= Data.CardType.category and var_13_7 ~= Data.CardType.keyword and var_13_7 ~= Data.CardType.flag and var_13_7 ~= Data.CardType.star and var_13_7 ~= Data.CardType.min_star and var_13_7 ~= Data.CardType.card_type and var_13_7 ~= Data.CardType.max_quality and var_13_7 ~= Data.CardType.max_star then
		arg_13_1._infoId = 10001

		local var_13_8, var_13_9 = Data.getInfo(arg_13_1._infoId)
	end

	local var_13_10, var_13_11, var_13_12, var_13_13 = ClientData.getIconName(arg_13_1._infoId, true)

	if arg_13_0._cardImg then
		arg_13_0._cardImg:removeFromParent()
		arg_13_0._cardImg = nil
	end

	var_13_1:setVisible(true)
	if var_13_10 and var_13_10 ~= "" then
		arg_13_0:setSpriteDisplay(var_13_1, var_13_10)
		var_13_1:setScale(var_13_13 or 1)
	else
		var_13_1:setSpriteFrame("img_blank")
	end

	arg_13_0:setSpriteDisplay(var_13_0, var_13_11, var_13_12)

	if arg_13_0._fragmentIcon then
		arg_13_0._fragmentIcon:removeFromParent()

		arg_13_0._fragmentIcon = nil
	end

	local var_13_14, var_13_15, var_13_16, var_13_17 = Data.removeAdditional(arg_13_1._infoId)

	if var_13_15 or var_13_17 and var_13_17 > 0 then
		local var_13_18 = lc.createSprite(var_13_15 and "img_icon_fragment" or "img_icon_skill")

		lc.addChildToPos(var_13_0, var_13_18, cc.p(20, lc.h(var_13_0) - 20))

		arg_13_0._fragmentIcon = var_13_18
	end

	if var_13_3 and var_13_3 < 0 then
		arg_13_0:setGray(true)
	end
end

function var_0_0.setNameColor(arg_14_0, arg_14_1)
	arg_14_0._nameColor = arg_14_1

	arg_14_0._name:setColor(arg_14_0._nameColor)
end

function var_0_0.setSpriteDisplay(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_2 then
		arg_15_1:setSpriteFrame(arg_15_2)
	end

	arg_15_1:setEffect(arg_15_3)

	arg_15_1._shader = arg_15_3
end

function var_0_0.cancelLongPress(arg_16_0)
	if arg_16_0._longPressID then
		lc.Scheduler:unscheduleScriptEntry(arg_16_0._longPressID)

		arg_16_0._longPressID = nil
	end
end

function var_0_0.checkHighlight(arg_17_0)
	if arg_17_0:needHighlight() then
		local var_17_0 = lc.createSprite("img_light_3")

		var_17_0:setColor(lc.Color3B.yellow)
		var_17_0:setScale(1.5)
		lc.addChildToCenter(arg_17_0, var_17_0, -2)
		lc.offset(var_17_0, 0, 12)

		local var_17_1 = lc.createSprite("img_light_2")

		var_17_1:setColor(var_17_0:getColor())
		var_17_1:setScale(3)
		var_17_1:runAction(lc.rep(lc.rotateBy(4, 360)))
		lc.addChildToPos(arg_17_0, var_17_1, cc.p(var_17_0:getPosition()), -1)
	end
end

function var_0_0.needHighlight(arg_18_0)
	if arg_18_0._data == nil or arg_18_0._data._infoId == nil or arg_18_0._data._count == nil then
		return false
	end

	local var_18_0 = arg_18_0._data._infoId
	local var_18_1 = arg_18_0._data._count
	local var_18_2 = Data.getType(var_18_0)

	if var_18_2 >= Data.CardType.monster and var_18_2 <= Data.CardType.rare then
		return true
	end

	if var_18_0 == Data.PropsId.rare_package_ticket or var_18_0 == Data.PropsId.character_package_ticket or var_18_0 == Data.PropsId.times_package_ticket then
		return var_18_1 >= 5
	end

	return false
end

function var_0_0.onEnter(arg_19_0)
	if band(arg_19_0._flag, var_0_0.DisplayFlag.LEVEL) ~= 0 then
		arg_19_0._listener = lc.addEventListener(Data.Event.card_dirty, function(arg_20_0)
			if arg_20_0._infoId == arg_19_0._data._infoId then
				arg_19_0:setData(arg_19_0._data, arg_19_0._flag)
			end
		end)
	end
end

function var_0_0.onExit(arg_21_0)
	if arg_21_0._listener then
		lc.Dispatcher:removeEventListener(arg_21_0._listener)
	end
end

function var_0_0.onCleanup(arg_22_0)
	lc.Pool.free(arg_22_0)
end

IconWidget = var_0_0
IconWidgetFlag = IconWidget.DisplayFlag

function var_0_0.poolCreate()
	local var_23_0 = var_0_0.new(lc.EXTEND_WIDGET)

	var_23_0:retain()
	var_23_0:init()

	return var_23_0
end

function var_0_0.poolGet(arg_24_0)
	if arg_24_0:getParent() then
		arg_24_0:removeFromParent(false)
	end
end

function var_0_0.poolClear(arg_25_0)
	arg_25_0:release()
end

local var_0_2 = 100

lc.Pool.new("IconWidget", var_0_2)

return var_0_0
