local var_0_0 = class("CardThumbnail", lc.ExtendUIWidget)

var_0_0.pool = {}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(ClientView.CARD_SIZE)
	var_1_0:setTouchEnabled(false)
	var_1_0:createComponent(arg_1_0, arg_1_2)
	var_1_0:setScaleFactor(arg_1_1)
	var_1_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_1_0:setCascadeOpacityEnabled(true)

	return var_1_0
end

function var_0_0.createComponent(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._infoId = arg_2_1

	local var_2_0, var_2_1, var_2_2 = Data.removeAdditional(arg_2_1)

	arg_2_0._cardId = var_2_0
	arg_2_0._isGold = Data.isGold(arg_2_1)
	arg_2_0._skinId = arg_2_2
	arg_2_0._frame = ClientView.createCardFrame(arg_2_0._infoId, nil, arg_2_0._skinId)

	lc.addChildToCenter(arg_2_0, arg_2_0._frame, 1)

	arg_2_0._shadow = ClientView.createCardShadow(arg_2_0._infoId)

	arg_2_0._frame:addChild(arg_2_0._shadow, -1)
end

function var_0_0.updateComponent(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._infoId = arg_3_1

	local var_3_0, var_3_1, var_3_2 = Data.removeAdditional(arg_3_1)

	arg_3_0._cardId = var_3_0
	arg_3_0._isGold = Data.isGold(arg_3_1)
	arg_3_0._skinId = arg_3_2

	arg_3_0._frame:update(arg_3_0._infoId, arg_3_0._skinId)
	arg_3_0._shadow:update(arg_3_0._infoId)
end

--- How many thumbnails the pool starts with, and grows by.
var_0_0.POOL_INIT = 70
var_0_0.POOL_STEP = 15

function var_0_0.createPool()
	if #var_0_0.pool ~= 0 then
		return
	end

	var_0_0.extendPool(var_0_0.POOL_INIT)
end

--- Add another batch of thumbnails to the pool.
--
-- Split out of createPool so the pool can grow. It was fixed at eighty, and
-- createFromPool answered an exhausted pool with nil - which CardList stores
-- in its item grid and hands straight back to releaseToPool on cleanup, so a
-- busy screen turned into "attempt to index local 'arg_15_0'". lc.Pool, which
-- every other pooled widget uses, extends itself for exactly this reason; this
-- one now does the same.
function var_0_0.extendPool(arg_100_0)
	local var_100_0 = #var_0_0.pool

	for iter_4_0 = var_100_0 + 1, var_100_0 + arg_100_0 do
		local var_4_0 = var_0_0.create(10001, 1)

		var_4_0:registerScriptHandler(function(arg_5_0)
			if arg_5_0 == "enter" then
				var_4_0:onEnter()
			elseif arg_5_0 == "exit" then
				var_4_0:onExit()
			end
		end)

		local var_4_1 = ccui.Layout:create()

		var_4_1:addChild(var_4_0)

		local var_4_2 = ClientView.createScale9ShaderButton("img_btn_1", nil, ClientView.CRECT_BUTTON, 110)

		var_4_2:setEnabled(false)
		var_4_2:setVisible(false)
		var_4_2:addLabel("")
		var_4_1:addChild(var_4_2)

		local var_4_3 = ccui.ShaderButton:create("img_btn_check_bg", ccui.TextureResType.plistType)

		var_4_3:setVisible(false)
		var_4_3:setTouchRect(cc.rect(-10, -10, lc.w(var_4_3) + 20, lc.h(var_4_3) + 20))
		var_4_3:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
		lc.addChildToPos(var_4_1, var_4_3, cc.p(0, -136))

		var_4_3._checkedSprite = cc.Sprite:createWithSpriteFrameName("img_icon_check")

		var_4_3._checkedSprite:setVisible(false)
		lc.addChildToPos(var_4_3, var_4_3._checkedSprite, cc.p(lc.w(var_4_3) / 2, lc.h(var_4_3) / 2 + 8))

		local var_4_4 = ccui.ShaderButton:create("img_btn_check_bg", ccui.TextureResType.plistType)

		var_4_4:setVisible(false)
		var_4_4:setTouchRect(cc.rect(-10, -10, lc.w(var_4_4) + 20, lc.h(var_4_4) + 20))
		var_4_4:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
		lc.addChildToPos(var_4_1, var_4_4, cc.p(0, -136))

		var_4_4._checkedSprite = cc.Sprite:createWithSpriteFrameName("img_icon_check")

		var_4_4._checkedSprite:setVisible(false)
		lc.addChildToPos(var_4_4, var_4_4._checkedSprite, cc.p(lc.w(var_4_4) / 2, lc.h(var_4_4) / 2 + 8))

		local var_4_5 = lc.createSprite("img_card_count_bg")

		var_4_5:setAnchorPoint(0.5, 0)
		var_4_5:setVisible(false)
		lc.addChildToPos(var_4_1, var_4_5, cc.p(0, -148), -1)

		local var_4_6 = ccui.Scale9Sprite:createWithSpriteFrameName("depot_bg", cc.rect(0, 0, 0, 0))

		var_4_6:setContentSize(cc.size(lc.w(var_4_5) - 20, lc.h(var_4_5) - 10))
		lc.addChildToCenter(var_4_5, var_4_6, -1)
		var_4_6:setVisible(false)

		var_4_5._bg = var_4_6

		local var_4_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, "x1")

		var_4_7:setScale(0.9)
		lc.addChildToPos(var_4_5, var_4_7, cc.p(lc.w(var_4_5) / 2, lc.h(var_4_5) / 2))

		var_4_5._label = var_4_7

		function var_4_5.update(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
			arg_6_5 = arg_6_5 or P._playerCard:getCardCount(var_4_1._thumbnail._infoId)
			var_4_1._thumbnail._count = arg_6_2

			if arg_6_2 ~= nil and arg_6_3 ~= nil and (arg_6_3 <= arg_6_2 or arg_6_4 ~= nil and arg_6_5 <= arg_6_4) then
				arg_6_0._label:setString(lc.str(arg_6_3 <= arg_6_2 and STR.USE_LIMITED or STR.USED_OUT))
				arg_6_0._label:setScale(0.8)
				arg_6_0._label:setPosition(lc.w(arg_6_0) / 2, 18)
				var_4_1._thumbnail._frame._frame:setEffect(ClientView.SHADER_DISABLE)
				var_4_1._thumbnail._frame:setEffect(ClientView.SHADER_DISABLE)

				var_4_1._locked = true
			else
				if arg_6_2 and arg_6_3 then
					arg_6_0._label:setString(arg_6_4 .. "/" .. arg_6_5)
				elseif arg_6_2 then
					arg_6_0._label:setString("x" .. arg_6_2)
				else
					arg_6_0._label:setString("x" .. arg_6_5)
				end

				arg_6_0._label:setScale(0.9)
				arg_6_0._label:setPosition(lc.w(arg_6_0) / 2, 19)
				var_4_1._thumbnail._frame:setEffect(nil)

				var_4_1._locked = false
			end

			arg_6_0:setVisible(arg_6_1)
			arg_6_0:setScale(var_4_1._thumbnail._scale / 0.6)
			arg_6_0:setPosition(cc.p(0, var_4_1._thumbnail._scale / 0.6 * -148))
		end

		function var_4_5.updateDetermined(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
			arg_7_0._label:setString(arg_7_2 .. "/" .. arg_7_3)

			if arg_7_2 == 0 then
				var_4_1._thumbnail._frame._frame:setEffect(ClientView.SHADER_DISABLE)
				var_4_1._thumbnail._frame:setEffect(ClientView.SHADER_DISABLE)

				var_4_1._locked = true
			else
				var_4_1._thumbnail._frame:setEffect(nil)

				var_4_1._locked = false
			end

			arg_7_0._label:setScale(0.9)
			arg_7_0._label:setPosition(lc.w(arg_7_0) / 2, 19)
			arg_7_0:setVisible(arg_7_1)
			arg_7_0:setScale(var_4_1._thumbnail._scale / 0.6)
			arg_7_0:setPosition(cc.p(0, var_4_1._thumbnail._scale / 0.6 * -148))
		end

		function var_4_5.updateEffect(arg_8_0, arg_8_1, arg_8_2)
			arg_8_0._label:setString(arg_8_2 == 0 and Str(STR.VOID_SHORT) .. Str(STR.EFFECT) or Str(STR.EFFECT) .. "x" .. arg_8_2)
			arg_8_0._label:setScale(0.9)
			arg_8_0._label:setPosition(lc.w(arg_8_0) / 2, 19)
			arg_8_0:setVisible(arg_8_1)
			arg_8_0:setScale(var_4_1._thumbnail._scale / 0.6)
			arg_8_0:setPosition(cc.p(0, var_4_1._thumbnail._scale / 0.6 * -148))
		end

		local var_4_8 = lc.createSprite({
			_name = "img_com_bg_26",
			_crect = ClientView.CRECT_COM_BG26,
			_size = cc.size(158, 36)
		})

		var_4_8:setVisible(false)
		lc.addChildToPos(var_4_1, var_4_8, cc.p(0, -132))

		local var_4_9 = ClientView.createBMFont(ClientView.BMFont.huali_26, "0")

		lc.addChildToCenter(var_4_8, var_4_9)

		var_4_8._label = var_4_9

		local var_4_10 = ClientView.createShaderButton("img_btn_squarel_s_2", function(arg_9_0)
			if var_4_8._callbackAdd then
				var_4_8._callbackAdd(d)
			end
		end)

		lc.addChildToPos(var_4_10, lc.createSprite("img_icon_add"), cc.p(lc.w(var_4_10) / 2, lc.h(var_4_10) / 2 + 1))
		lc.addChildToPos(var_4_8, var_4_10, cc.p(lc.w(var_4_8) - lc.w(var_4_10) / 2, lc.h(var_4_8) / 2))

		local var_4_11 = ClientView.createShaderButton("img_btn_squarel_s_2", function(arg_10_0)
			if var_4_8._callbackMinus then
				var_4_8._callbackMinus()
			end
		end)

		lc.addChildToPos(var_4_11, lc.createSprite("img_icon_minus"), cc.p(lc.w(var_4_11) / 2, lc.h(var_4_11) / 2 + 1))
		lc.addChildToPos(var_4_8, var_4_11, cc.p(lc.w(var_4_11) / 2, lc.h(var_4_8) / 2))

		var_4_8._btnAdd = var_4_10
		var_4_8._btnMinus = var_4_11

		local var_4_12 = ClientView.createStatusLabel("", ClientView.COLOR_TEXT_GREEN)

		var_4_12:setVisible(false)
		lc.addChildToCenter(var_4_0, var_4_12)

		function var_4_1.showStatusRect(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
			var_4_12:setVisible(arg_11_1)

			if arg_11_1 then
				var_4_12:setRotation(arg_11_5 or 0)
				var_4_12:setColor(arg_11_3 or ClientView.COLOR_TEXT_GREEN)
				var_4_12:setPosition(arg_11_4 or cc.p(lc.w(var_4_0) / 2, lc.h(var_4_0) / 2))
				var_4_12._label:setString(arg_11_2)
				var_4_12._label:setColor(var_4_12:getColor())
			end
		end

		var_4_0._item = var_4_1
		var_4_1._thumbnail = var_4_0

		var_4_2:setDisabledShader(ClientView.SHADER_DISABLE)

		var_4_1._btnCustom1 = var_4_2
		var_4_1._btnRadio = var_4_3
		var_4_1._btnCheck = var_4_4
		var_4_1._countArea = var_4_5
		var_4_1._multiSelectArea = var_4_8
		var_4_1._statusRect = var_4_12
		var_4_1._listeners = {}

		var_4_1:retain()

		var_4_1._isBusy = false
		var_4_1._poolIndex = iter_4_0

		table.insert(var_0_0.pool, var_4_1)
	end
end

function var_0_0.releasePool()
	for iter_12_0, iter_12_1 in ipairs(var_0_0.pool) do
		iter_12_1._thumbnail:unregisterScriptHandler()

		for iter_12_2 = 1, #iter_12_1._listeners do
			lc.Dispatcher:removeEventListener(iter_12_1._listeners[iter_12_2])
		end

		iter_12_1._listeners = {}

		iter_12_1:removeAllChildren()
		iter_12_1:release()
	end

	var_0_0.pool = {}
end

function var_0_0.createFromPool(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	for iter_13_0, iter_13_1 in ipairs(var_0_0.pool) do
		if not iter_13_1._isBusy then
			iter_13_1._isBusy = true
			iter_13_1._sceneId = lc._runningScene and lc._runningScene._sceneId or 0

			if arg_13_0 ~= nil then
				iter_13_1._thumbnail:updateComponent(arg_13_0, arg_13_2)
			end

			iter_13_1._thumbnail:setScaleFactor(arg_13_1)
			iter_13_1._thumbnail:setVisible(true)
			iter_13_1._thumbnail._frame:setEffect(nil)
			iter_13_1._countArea:setPositionY(-148)

			iter_13_1._listeners = {}

			local var_13_1 = lc.addEventListener(Data.Event.card_select, function(arg_14_0)
				if iter_13_1._thumbnail._infoId == arg_14_0._infoId then
					if iter_13_1._btnRadio:isVisible() then
						iter_13_1._btnRadio._checkedSprite:setVisible(arg_14_0._count > 0)
					end

					if iter_13_1._btnCheck:isVisible() then
						iter_13_1._btnCheck._checkedSprite:setVisible(arg_14_0._count > 0)
					end
				end
			end)

			table.insert(iter_13_1._listeners, var_13_1)

			var_13_0 = iter_13_1

			break
		end
	end

	if var_13_0 == nil then
		local var_13_2 = ""

		for iter_13_2, iter_13_3 in ipairs(var_0_0.pool) do
			if iter_13_3._isBusy then
				var_13_2 = var_13_2 .. tostring(iter_13_3._sceneId) .. ","
			end
		end

		lc.log(var_13_2)
		ClientData.sendUserEvent({
			err_debug = 1,
			sceneIds = var_13_2
		})

		-- Grow rather than give up: a caller that gets nil stores it and
		-- hands it back on cleanup, which is a crash a screen or two later.
		-- Only retry if the pool really did grow, so a failure to build one
		-- cannot turn into an endless recursion.
		local var_13_3 = #var_0_0.pool

		if var_13_3 < 120 then
			var_0_0.extendPool(var_0_0.POOL_STEP)
		end

		if #var_0_0.pool > var_13_3 then
			return var_0_0.createFromPool(arg_13_0, arg_13_1, arg_13_2)
		end
	end

	return var_13_0
end

--- Hand a thumbnail back to the pool.
--
-- Nothing to hand back is not an error. Six callers release whole lists at
-- once - FindLadderArea and FindSurvivalArea walk a troop list and release
-- each entry's _item, which a custom row simply does not have - so a nil here
-- is ordinary and used to end the screen with "attempt to index local
-- 'arg_15_0'". lc.Pool.free, which every other pooled widget goes through,
-- has always shrugged this off; this one now does too.
function var_0_0.releaseToPool(arg_15_0)
	if arg_15_0 == nil then
		return
	end

	arg_15_0:removeFromParent()

	arg_15_0._isBusy = false
	arg_15_0._sceneId = nil

	for iter_15_0 = 1, #arg_15_0._listeners do
		lc.Dispatcher:removeEventListener(arg_15_0._listeners[iter_15_0])
	end

	arg_15_0._listeners = {}

	arg_15_0:setVisible(true)
	arg_15_0._thumbnail:setScaleFactor(1)
	arg_15_0._thumbnail:setTouchEnabled(false)
	arg_15_0._thumbnail:setOpacity(255)
	arg_15_0._btnCustom1:setEnabled(false)
	arg_15_0._btnCustom1:setVisible(false)
	arg_15_0._btnCustom1:setContentSize(lc.w(arg_15_0._btnCustom1), ClientView.CRECT_BUTTON.height)

	arg_15_0._btnCustom1._callback = nil

	if arg_15_0._btnCustom1._resIcon then
		arg_15_0._btnCustom1._resIcon:removeFromParent()

		arg_15_0._btnCustom1._resIcon = nil
	end

	arg_15_0._btnRadio:setEnabled(false)
	arg_15_0._btnRadio:setVisible(false)
	arg_15_0._btnRadio._checkedSprite:setVisible(false)

	arg_15_0._btnRadio._card = nil

	arg_15_0._btnCheck:setEnabled(false)
	arg_15_0._btnCheck:setVisible(false)
	arg_15_0._btnCheck._checkedSprite:setVisible(false)

	arg_15_0._btnCheck._card = nil

	arg_15_0._countArea:setVisible(false)
	arg_15_0._countArea._bg:setVisible(false)
	arg_15_0._multiSelectArea:setVisible(false)

	arg_15_0._multiSelectArea._callbackAdd = nil
	arg_15_0._multiSelectArea._callbackMinus = nil

	arg_15_0._statusRect:setVisible(false)

	if arg_15_0._thumbnail._newFlag then
		arg_15_0._thumbnail._newFlag:removeFromParent()

		arg_15_0._thumbnail._newFlag = nil
	end

	if arg_15_0._thumbnail._discountFlag then
		arg_15_0._thumbnail._discountFlag:removeFromParent()

		arg_15_0._thumbnail._discountFlag = nil
	end

	arg_15_0._thumbnail:setGray(false)
	arg_15_0._thumbnail:setUp(false)
end

function var_0_0.onEnter(arg_16_0)
	arg_16_0._listeners = {}

	local var_16_0 = lc.addEventListener(Data.Event.card_dirty, function(arg_17_0)
		if arg_17_0._infoId == arg_16_0._infoId then
			arg_16_0._skinId = P._playerCard:getSkinId(arg_16_0._infoId)

			arg_16_0:updateComponent(arg_16_0._infoId, arg_16_0._skinId)
		end
	end)

	table.insert(arg_16_0._listeners, var_16_0)
end

function var_0_0.onExit(arg_18_0)
	for iter_18_0 = 1, #arg_18_0._listeners do
		lc.Dispatcher:removeEventListener(arg_18_0._listeners[iter_18_0])
	end

	arg_18_0._listeners = {}

	if arg_18_0._newBones ~= nil then
		arg_18_0._newBones:removeFromParent()

		arg_18_0._newBones = nil
	end
end

function var_0_0.setScaleFactor(arg_19_0, arg_19_1)
	arg_19_0._scale = arg_19_1 and arg_19_1 or 1

	arg_19_0:setContentSize(cc.size(ClientView.CARD_SIZE.width * arg_19_0._scale, ClientView.CARD_SIZE.height * arg_19_0._scale))

	local var_19_0 = cc.p(lc.w(arg_19_0) / 2, lc.h(arg_19_0) / 2)

	arg_19_0._frame:setPosition(var_19_0)
	arg_19_0._frame:setScale(arg_19_0._scale)
end

function var_0_0.getMaxSize(arg_20_0)
	return ClientView.CARD_SIZE
end

function var_0_0.updateFlag(arg_21_0)
	local var_21_0 = ClientView.checkNewFlag(arg_21_0, P._playerCard:isUnlocked(arg_21_0._infoId), 40 - 50 * arg_21_0._scale, 10 - 260 * arg_21_0._scale)

	if var_21_0 then
		var_21_0:setLocalZOrder(2)
		var_21_0:setSpriteFrame("img_new_l")
		var_21_0:setScale(1)
	end

	if arg_21_0._newBones ~= nil then
		arg_21_0._newBones:removeFromParent()

		arg_21_0._newBones = nil
	end
end

function var_0_0.updateUnionShopFlag(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	local var_22_0 = arg_22_0._item._countArea

	var_22_0:setVisible(true)
	var_22_0._bg:setVisible(true)
	var_22_0._label:setString(arg_22_1 .. "/" .. arg_22_2)
	var_22_0._label:setPositionY(lc.ch(var_22_0._bg))
	var_22_0:setScale(arg_22_0._item._thumbnail._scale / 0.6)
	var_22_0:setPosition(cc.p(0, arg_22_0._item._thumbnail._scale / 0.6 * -148))

	local var_22_1

	if arg_22_5 == 0 then
		if arg_22_0._discountFlag then
			arg_22_0._discountFlag:removeFromParent()

			arg_22_0._discountFlag = nil
		end

		local var_22_2 = ClientView.checkNewFlag(arg_22_0, true, 40 - 50 * arg_22_0._scale, 10 - 260 * arg_22_0._scale)

		if var_22_2 then
			var_22_2:setLocalZOrder(2)
			var_22_2:setSpriteFrame("discount_bg_new")
		end
	else
		if arg_22_0._newFlag then
			arg_22_0._newFlag:removeFromParent()

			arg_22_0._newFlag = nil
		end

		local var_22_3 = ClientView.checkDiscountFlag(arg_22_0, arg_22_5, 40 - 50 * arg_22_0._scale, 10 - 260 * arg_22_0._scale)

		if var_22_3 then
			var_22_3:setLocalZOrder(2)
		end
	end

	if arg_22_2 <= arg_22_1 then
		arg_22_0._item._countArea._label:setString(Str(STR.UNION_SHOP_OWN))
	end

	arg_22_0._item._btnCustom1:setEnabled(true)
end

function var_0_0.updateRareShopFlag(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	local var_23_0 = arg_23_0._item._countArea

	var_23_0:setVisible(true)
	var_23_0._bg:setVisible(true)
	var_23_0._label:setPositionY(lc.ch(var_23_0._bg))
	var_23_0:setScale(arg_23_0._item._thumbnail._scale / 0.6)
	var_23_0:setPosition(cc.p(0, arg_23_0._item._thumbnail._scale / 0.6 * -148))

	local var_23_1 = arg_23_0._infoId

	if arg_23_5 and false then
		arg_23_0._item._countArea._label:setString(Str(STR.PURCHASED))
	elseif arg_23_2 <= arg_23_1 then
		arg_23_0._item._countArea._label:setString(Str(STR.UNION_SHOP_OWN))
	else
		arg_23_0._item._countArea._label:setString(arg_23_1 .. "/" .. arg_23_2)
	end

	if false then
		arg_23_0._item._countArea._label:setString("0/1")
	end

	arg_23_0._item._btnCustom1:setEnabled(true)
end

function var_0_0.updateDiamondShopFlag(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = arg_24_0._item._countArea

	var_24_0:setVisible(true)
	var_24_0._bg:setVisible(true)
	var_24_0._label:setString(arg_24_1 .. "/" .. arg_24_2)
	var_24_0._label:setPositionY(lc.ch(var_24_0._bg))
	var_24_0:setScale(arg_24_0._item._thumbnail._scale / 0.6)
	var_24_0:setPosition(cc.p(0, arg_24_0._item._thumbnail._scale / 0.6 * -148))
	arg_24_0._item._btnCustom1:setEnabled(true)
end

function var_0_0.updateVoteShopFlag(arg_25_0, arg_25_1)
	local var_25_0 = Data._voteProductsInfo[arg_25_1]
	local var_25_1 = arg_25_0._item._countArea

	var_25_1:setVisible(true)
	var_25_1._bg:setVisible(true)

	if var_25_0._totalNumer > 0 and var_25_0._showType and var_25_0._showType == 1 then
		var_25_1._label:setString(string.format(Str(STR.LIMITED_NUM), var_25_0._totalNumer))
	elseif var_25_0._endData > 0 then
		local var_25_2 = math.floor(var_25_0._endData % 1000000 / 10000)
		local var_25_3 = math.floor(var_25_0._endData % 10000 / 100)

		var_25_1._label:setString(string.format(Str(STR.OFF_DATE), var_25_2, var_25_3))
	else
		var_25_1._label:setString(Str(STR.RESIDENT))
	end

	var_25_1._label:setPositionY(lc.ch(var_25_1._bg))
	var_25_1:setScale(arg_25_0._item._thumbnail._scale / 0.6)
	var_25_1:setPosition(cc.p(0, arg_25_0._item._thumbnail._scale / 0.6 * -148))
end

function var_0_0.setGray(arg_26_0, arg_26_1)
	arg_26_0._frame._frame:setEffect(arg_26_1 and ClientView.SHADER_DISABLE or arg_26_0._infoId and ClientView.getCardShader(arg_26_0._infoId) or nil)
	arg_26_0._frame:setEffect(arg_26_1 and ClientView.SHADER_DISABLE or nil)
end

function var_0_0.setSelected(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_1 and arg_27_0._glow then
		arg_27_0._glow:removeFromParent()

		arg_27_0._glow = nil
	end

	if arg_27_1 and not arg_27_0._glow then
		local var_27_0 = DragonBones.create("xuanzhong")

		var_27_0:gotoAndPlay("effect1")
		var_27_0:setScale(1.4)
		lc.addChildToCenter(arg_27_0, var_27_0, -1)

		arg_27_0._glow = var_27_0
	end

	if arg_27_2 ~= nil then
		arg_27_0:setUp(arg_27_2)
	end
end

function var_0_0.setUp(arg_28_0, arg_28_1)
	if not arg_28_1 and arg_28_0._upSpr then
		arg_28_0._upSpr:removeFromParent()

		arg_28_0._upSpr = nil
	end

	if arg_28_1 and not arg_28_0._upSpr then
		local var_28_0 = lc.createSprite("img_up")

		var_28_0:setScale(arg_28_0._scale)
		lc.addChildToPos(arg_28_0, var_28_0, cc.p(lc.sw(var_28_0) / 2, lc.sh(arg_28_0) / 2), 100)

		arg_28_0._upSpr = var_28_0
	end
end

function var_0_0.updateRecoveryFlag(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = Data._recallInfo[arg_29_1]
	local var_29_1 = arg_29_0._item._countArea

	var_29_1:setVisible(true)
	var_29_1._bg:setVisible(true)
	var_29_1._label:setString("x" .. arg_29_2)
	var_29_1._label:setPositionY(lc.ch(var_29_1._bg))
	var_29_1:setScale(arg_29_0._item._thumbnail._scale / 0.6)
	var_29_1:setPosition(cc.p(0, arg_29_0._item._thumbnail._scale / 0.6 * -148))
end

return var_0_0
