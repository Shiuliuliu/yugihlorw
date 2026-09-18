local var_0_0 = class("ChatPanel", lc.ExtendUIWidget)
local var_0_1 = {
	world = Data.MsgType.world,
	bulletin = Data.MsgType.bulletin,
	battle = Data.MsgType.battle
}
local var_0_2 = cc.size(624, lc.Director:getVisibleSize().height)
local var_0_3 = 140
local var_0_4 = 20
local var_0_5 = 0
local var_0_6 = {
	10,
	10,
	10,
	6
}
local var_0_7 = 100
local var_0_8 = 1

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_WIDGET)

	var_1_0:setAnchorPoint(0, 0)
	var_1_0:setContentSize(var_0_2)
	var_1_0:init()

	var_1_0._listener = lc.addEventListener(Data.Event.message, function(arg_2_0)
		var_1_0:onMessageEvent(arg_2_0)
	end)

	-- Store panel instance for direct refresh from pollChatHistory
	pcall(function() ClientData._chatPanel = var_1_0 end)

	return var_1_0
end

function var_0_0.init(arg_3_0)
	local var_3_0 = {
		Str(STR.WORLD),
		Str(STR.BULLETIN),
		Str(STR.BATTLE)
	}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = {
			_tag = iter_3_0,
			_labelStr = var_3_0[iter_3_0],
			_width = var_0_3,
			_handler = function(arg_4_0)
				arg_3_0:showTab(arg_4_0)
			end,
			_checkHandler = function(arg_5_0, arg_5_1)
				return arg_3_0:checkShowTab(arg_5_0, arg_5_1)
			end
		}

		table.insert(var_3_1, var_3_2)
	end

	local var_3_3 = ClientView.createHorizontalContentTab(cc.size(var_0_2.width, var_0_2.height - 60), var_3_1)

	lc.addChildToPos(arg_3_0, var_3_3, cc.p(lc.w(arg_3_0) / 2, lc.h(var_3_3) / 2), -1)

	arg_3_0._contentBg = var_3_3

	local var_3_4 = lc.List.createV(cc.size(lc.w(var_3_3) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 16, lc.h(var_3_3) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 16, 16)

	var_3_4:setAnchorPoint(0.5, 0)

	var_3_4._originH = lc.h(var_3_4)

	lc.addChildToPos(var_3_3, var_3_4, cc.p(lc.w(var_3_3) / 2, ClientView.FRAME_INNER_BOTTOM))

	arg_3_0._list = var_3_4

	local var_3_5 = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		return
	end, ClientView.CRECT_BUTTON_S, 100)

	var_3_5:addLabel(Str(STR.SEND))

	local var_3_6 = ccui.Layout:create()

	var_3_6:setContentSize(cc.size(lc.w(var_3_4), lc.h(var_3_5)))
	var_3_6:setAnchorPoint(0.5, 1)
	lc.addChildToPos(var_3_3, var_3_6, cc.p(lc.w(var_3_3) / 2, lc.h(var_3_3) - ClientView.FRAME_INNER_TOP - 16))

	arg_3_0._inputArea = var_3_6

	lc.addChildToPos(var_3_6, var_3_5, cc.p(lc.w(var_3_6) - lc.w(var_3_5) / 2, lc.h(var_3_6) / 2), 1)

	arg_3_0._btnSend = var_3_5

	local var_3_7 = ClientView.createEditBox("img_com_bg_26", cc.rect(12, 14, 2, 2), cc.size(lc.w(var_3_6) - lc.w(var_3_5) - 8, lc.h(var_3_5)), nil, true)

	var_3_7:setFontColor(lc.Color4B.white)
	lc.addChildToPos(var_3_6, var_3_7, cc.p(lc.w(var_3_7) / 2, lc.y(var_3_5)))

	arg_3_0._iptSend = var_3_7

	local var_3_8 = lc.createSprite("img_btn_pop")
	local var_3_9 = ClientView.createShaderButton(nil, function(arg_7_0)
		if arg_3_0._isPop then
			arg_3_0:push()
		else
			arg_3_0:pop()
		end
	end)

	var_3_9:setAnchorPoint(0, 0.5)
	var_3_9:setContentSize(var_3_8:getContentSize())
	lc.addChildToPos(arg_3_0, var_3_9, cc.p(var_0_2.width - 8, lc.h(arg_3_0) / 2), -2)

	arg_3_0._btnPop = var_3_9

	lc.addChildToCenter(var_3_9, var_3_8)

	arg_3_0._arrowPop = var_3_8
	arg_3_0._isPop = false

	arg_3_0:setPosition(-var_0_2.width + 12 + ClientView.SCR_EDGE, 0)
	arg_3_0._contentBg:setVisible(false)
end

function var_0_0.pop(arg_8_0)
	if arg_8_0._isPop then
		return
	end

	arg_8_0._isPop = true

	arg_8_0._arrowPop:setSpriteFrame("img_btn_push")
	arg_8_0._contentBg:setVisible(true)
	arg_8_0:stopAllActions()
	arg_8_0:runAction(lc.ease(lc.moveTo(0.35, cc.p(-8 + ClientView.SCR_EDGE, lc.y(arg_8_0))), "SineO"))

	local var_8_0

	if P:getMaxCharacterLevel() >= var_0_8 and P._playerMessage:getNewWorld() > 0 then
		var_8_0 = var_0_1.world
	elseif P._playerMessage:getNewBulletin() > 0 then
		var_8_0 = var_0_1.bulletin
	elseif P._playerMessage:getNewBattle() > 0 then
		var_8_0 = var_0_1.battle
	end

	pcall(function() if _G.flushPendingChatQueue then _G.flushPendingChatQueue() end end)
	arg_8_0._contentBg:showTab(var_8_0 or P:getMaxCharacterLevel() < var_0_8 and var_0_1.bulletin or var_0_1.world, true)

	pcall(function()
		if ClientData.pollChatHistory then
			ClientData.pollChatHistory()
		end
	end)

	if lc._runningScene._sceneId == ClientData.SceneId.world then
		lc._runningScene:hideTab()
	end
end

function var_0_0.push(arg_9_0)
	if not arg_9_0._isPop then
		return
	end

	arg_9_0._isPop = false

	arg_9_0._arrowPop:setSpriteFrame("img_btn_pop")
	arg_9_0:stopAllActions()
	arg_9_0:runAction(lc.sequence(lc.ease(lc.moveTo(0.2, cc.p(-var_0_2.width + 12 + ClientView.SCR_EDGE, lc.y(arg_9_0))), "SineI"), function()
		arg_9_0._contentBg:setVisible(false)
	end))
end

function var_0_0.checkShowTab(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == var_0_1.union then
		if not P:hasUnion() then
			ToastManager.push(Str(STR.UNION_CHAT_TIP))

			return false
		end
	elseif arg_11_1 == var_0_1.world and P:getMaxCharacterLevel() < var_0_8 then
		ToastManager.push(string.format(Str(STR.WORLD_CHAT_TIP), var_0_8))

		return false
	end

	return true
end

function var_0_0.showTab(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 == var_0_1.world or arg_12_1 == var_0_1.union
	local var_12_1 = arg_12_0._btnSend

	arg_12_0._inputArea:setVisible(var_12_0)

	function var_12_1._callback()
		if arg_12_1 == var_0_1.world then
			arg_12_0:send2World()
		else
			arg_12_0:send2Union()
		end
	end

	arg_12_0:resetList()

	if arg_12_0._isPop then
		local var_12_2 = arg_12_0._contentBg._focusTabIndex

		P._playerMessage:clearNew(var_12_2)
	end

	arg_12_0:showTabFlag()
end

function var_0_0.showTabFlag(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._contentBg._tabs) do
		local var_14_1 = P._playerMessage:getNew(iter_14_0)

		ClientView.checkNewFlag(iter_14_1, var_14_1, 24)

		var_14_0 = var_14_0 + var_14_1
	end

	ClientView.checkNewFlag(arg_14_0._btnPop, var_14_0, 2, -40)
end

function var_0_0.resetList(arg_15_0)
	local var_15_0 = arg_15_0._list
	local var_15_1 = arg_15_0._contentBg._focusTabIndex

	if var_15_1 == nil then
		return
	end

	local var_15_2 = var_15_1 == var_0_1.world or var_15_1 == var_0_1.union

	var_15_0:setContentSize(lc.w(var_15_0), var_15_0._originH - (var_15_2 and 76 or 0))

	pcall(function() if _G.flushPendingChatQueue then _G.flushPendingChatQueue() end end)
	local var_15_3 = P._playerMessage._msgAll[var_15_1]



	var_15_0:removeAllItems()
	var_15_0:bindData(var_15_3, function(arg_16_0, arg_16_1)
		arg_15_0:setOrCreateItem(arg_16_0, arg_16_1)
	end, math.min(var_0_6[var_15_1], #var_15_3), var_15_1 < var_0_1.bulletin and 2 or 0)

	for iter_15_0 = 1, var_15_0._cacheCount do
		if var_15_3[iter_15_0] then
			local var_15_4 = arg_15_0:setOrCreateItem(nil, var_15_3[iter_15_0])
			var_15_0:pushBackCustomItem(var_15_4)
		end
	end

	var_15_0:jumpToTop()
end

function var_0_0.updateList(arg_17_0, arg_17_1)
	arg_17_0:resetList()
end

function var_0_0.updateListItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._list:getItems()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if iter_18_1._msg == arg_18_1 then
			arg_18_0:setOrCreateItem(iter_18_1, arg_18_1)
		else
			arg_18_0:updateItemTime(iter_18_1)
		end
	end
end

function var_0_0.createItem(arg_19_0)
	local var_19_0 = ccui.Widget:create()

	var_19_0:setContentSize(lc.w(arg_19_0._list) - 8, h or 0)
	var_19_0:setTouchEnabled(true)
	var_19_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

	local var_19_1 = arg_19_0._contentBg._focusTabIndex
	local var_19_2 = UserWidget.Flag.NAME_UNION

	if var_19_1 == var_0_1.union then
		var_19_2 = UserWidget.Flag.LEVEL_NAME
	elseif var_19_1 == var_0_1.battle then
		var_19_2 = UserWidget.Flag.REGION_NAME_UNION
	end

	local var_19_3 = UserWidget.create(nil, var_19_2, 1)

	var_19_3:setScale(0.8)
	var_19_3:setAnchorPoint(0, 1)

	if var_19_3._vip then
		var_19_3._vip:setVisible(false)
	end

	if var_19_3._unionArea then
		var_19_3._unionArea._name:setColor(ClientView.COLOR_TEXT_ORANGE)
	end

	var_19_0:addChild(var_19_3)

	var_19_0._userArea = var_19_3

	local var_19_4 = ClientView.createTTF("", ClientView.FontSize.S2, ClientView.COLOR_LABEL_LIGHT)

	var_19_4:setAnchorPoint(1, 1)
	lc.addChildToPos(var_19_0, var_19_4, cc.p(lc.w(var_19_0), 0))

	var_19_0._time = var_19_4

	return var_19_0
end

function var_0_0.updateItemBase(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_1._msg = arg_20_2

	arg_20_1:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 == ccui.TouchEventType.ended then
			local var_21_0 = arg_20_2._sender or arg_20_2._user

			if var_21_0 then
				ClientView.operateUser(var_21_0, arg_20_1, arg_20_0._contentBg._focusTabIndex == var_0_1.world)
			end
		end
	end)
	arg_20_0:updateItemUser(arg_20_1)
	arg_20_0:updateItemTime(arg_20_1)

	if arg_20_1._content then
		arg_20_1._content:removeFromParent()
	end

	local var_20_0 = ccui.RichTextEx:create()

	if arg_20_2._user and arg_20_2._user.hasPrivilege and arg_20_2._user:hasPrivilege(Data.Privilege.survival) then
		var_20_0:insertElement(ccui.RichItemCustom:create(0, lc.Color3B.white, 255, lc.createSprite("img_title_survival")))
	end

	ClientView.appendBoldRichText(var_20_0, arg_20_2._content, {
		_normalClr = arg_20_2._clr or ClientView.COLOR_TEXT_LIGHT,
		_boldClr = ClientView.COLOR_TEXT_GREEN,
		_width = arg_20_3 or lc.w(arg_20_1)
	})
	var_20_0:setMaxWidth(arg_20_3 or lc.w(arg_20_1))
	var_20_0:setTouchEnabled(false)
	var_20_0:formatText()
	var_20_0:setCascadeOpacityEnabled(true)
	var_20_0:setAnchorPoint(cc.p(0, 0))
	arg_20_1:addChild(var_20_0)

	arg_20_1._content = var_20_0

	return lc.sh(arg_20_1._userArea) + 4 + lc.h(var_20_0)
end

function var_0_0.updateItemUser(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1._userArea
	local var_22_1 = arg_22_1._msg._user

	if var_22_1 and not var_22_1._crown then
		local msg = arg_22_1._msg
		local gc = tonumber((msg and msg._goldCup) or var_22_1._goldCup or var_22_1.gold_cup or 0) or 0
		local sc = tonumber((msg and msg._silverCup) or var_22_1._silverCup or var_22_1.silver_cup or 0) or 0
		local bc = tonumber((msg and msg._bronzeCup) or var_22_1._bronzeCup or var_22_1.bronze_cup or 0) or 0
		if gc > 0 then var_22_1._crown = { _infoId = 7204, _num = gc }
		elseif sc > 0 then var_22_1._crown = { _infoId = 7205, _num = sc }
		elseif bc > 0 then var_22_1._crown = { _infoId = 7206, _num = bc }
		end
	end

	var_22_0:setUser(var_22_1, true)
end

function var_0_0.updateItemTime(arg_23_0, arg_23_1)
	arg_23_1._time:setString(ClientData.getTimeAgo(arg_23_1._msg._timestamp))
end

function var_0_0.setOrCreateItem(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2._type == Data.MsgType.world or arg_24_2._type == Data.MsgType.union then
		return arg_24_0:setOrCreateChatItem(arg_24_1, arg_24_2)
	elseif arg_24_2._type == Data.MsgType.bulletin then
		return arg_24_0:setOrCreateBulletinItem(arg_24_1, arg_24_2)
	elseif arg_24_2._type == Data.MsgType.battle then
		return arg_24_0:setOrCreateBattleItem(arg_24_1, arg_24_2)
	end
end

function var_0_0.setOrCreateChatItem(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 == nil then
		arg_25_1 = arg_25_0:createItem()
	end

	local var_25_0 = arg_25_0:updateItemBase(arg_25_1, arg_25_2)

	arg_25_1:setContentSize(lc.w(arg_25_1), var_25_0)
	arg_25_1._userArea:setPosition(0, var_25_0)
	arg_25_1._time:setPosition(lc.w(arg_25_1), var_25_0)
	arg_25_1._content:setPosition(0, 0)

	return arg_25_1
end

function var_0_0.setOrCreateBulletinItem(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == nil then
		arg_26_1 = arg_26_0:createItem()

		local var_26_0 = lc.createSprite({
			_name = "img_divide_line_8",
			_crect = cc.rect(6, 1, 1, 1),
			_size = cc.size(lc.w(arg_26_1) + 28, 5)
		})

		lc.addChildToPos(arg_26_1, var_26_0, cc.p(lc.w(arg_26_1) / 2, 0))
	end

	local var_26_1 = 70
	local var_26_2 = 8
	local var_26_3 = (arg_26_2._items and #arg_26_2._items) or 0
	local var_26_4 = lc.w(arg_26_1) - 16

	local var_26_5 = arg_26_0:updateItemBase(arg_26_1, arg_26_2, var_26_4)
	local var_26_6 = var_26_5 + 8

	if var_26_3 > 0 then
		var_26_6 = var_26_6 + var_26_1 + var_26_2 + 6
	end

	arg_26_1:setContentSize(lc.w(arg_26_1), var_26_6)
	arg_26_1._userArea:setPosition(0, var_26_6)
	arg_26_1._time:setPosition(lc.w(arg_26_1), var_26_6)
	arg_26_1._content:setPosition(0, var_26_6 - var_26_5)

	local var_26_7 = 1000

	arg_26_1:removeChildrenByTag(var_26_7)

	if var_26_3 > 0 then
		local var_26_8 = 10
		local var_26_9 = var_26_6 - var_26_5 - 4

		for iter_26_0, iter_26_1 in ipairs(arg_26_2._items) do
			local var_26_10 = IconWidget.create(iter_26_1, IconWidget.DisplayFlag.ITEM_NO_NAME)

			var_26_10:setAnchorPoint(0, 1)
			var_26_10:setScale(var_26_1 / IconWidget.SIZE)
			lc.addChildToPos(arg_26_1, var_26_10, cc.p(var_26_8, var_26_9), 0, var_26_7)

			var_26_8 = var_26_8 + var_26_1 + var_26_2
		end
	end

	return arg_26_1
end

function var_0_0.setOrCreateBattleItem(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == nil then
		arg_27_1 = arg_27_0:createItem()

		local var_27_0 = UserWidget.create(nil, UserWidget.Flag.REGION_NAME_UNION, 1, true)

		var_27_0:setScale(0.8)
		var_27_0:setAnchorPoint(1, 1)

		if var_27_0._vipArea then
			var_27_0._vipArea:setVisible(false)
		end

		if var_27_0._unionArea then
			var_27_0._unionArea._name:setColor(ClientView.COLOR_TEXT_ORANGE)
		end

		arg_27_1:addChild(var_27_0)

		arg_27_1._oppoArea = var_27_0

		local var_27_1 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_28_0)
			return
		end, ClientView.CRECT_BUTTON_S, 150)

		var_27_1:setDisabledShader(ClientView.SHADER_DISABLE)
		var_27_1:addLabel("")
		arg_27_1:addChild(var_27_1)

		arg_27_1._btn1 = var_27_1

		local var_27_2 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_29_0)
			return
		end, ClientView.CRECT_BUTTON_S, 150)

		var_27_2:addLabel("")
		var_27_2:addIcon("img_icon_like")
		arg_27_1:addChild(var_27_2)

		arg_27_1._btn2 = var_27_2

		local var_27_3 = lc.createNode(cc.size(220, 40))

		local function var_27_4(arg_30_0, arg_30_1, arg_30_2)
			local var_30_0 = lc.createSprite(arg_30_0)

			lc.addChildToPos(var_27_3, var_30_0, cc.p(arg_30_1 + lc.w(var_30_0) / 2, lc.h(var_27_3) / 2))

			local var_30_1 = ClientView.createTTF("0", ClientView.FontSize.S3, ClientView.COLOR_LABEL_LIGHT)

			var_30_1:setAnchorPoint(0, 0.5)
			lc.addChildToPos(var_27_3, var_30_1, cc.p(lc.right(var_30_0) + 6, lc.y(var_30_0)))

			if arg_30_2 then
				lc.offset(var_30_0, 0, arg_30_2)
			end

			return var_30_1
		end

		arg_27_1._roundVal = var_27_4("img_icon_clock", 0)
		arg_27_1._watchVal = var_27_4("img_icon_watch", 100)
		arg_27_1._likeVal = var_27_4("img_icon_like", 180, 2)

		lc.addChildToPos(arg_27_1, var_27_3, cc.p(lc.w(var_27_3) / 2, 0))

		arg_27_1._infoArea = var_27_3

		local var_27_5 = lc.createSprite({
			_name = "img_divide_line_8",
			_crect = cc.rect(6, 1, 1, 1),
			_size = cc.size(lc.w(arg_27_1) + 28, 5)
		})

		lc.addChildToPos(arg_27_1, var_27_5, cc.p(lc.w(arg_27_1) / 2, 0))
	end

	local var_27_6 = arg_27_1._btn1
	local var_27_7 = arg_27_1._btn2
	local var_27_8 = arg_27_0:updateItemBase(arg_27_1, arg_27_2, lc.w(arg_27_1) - 100) + lc.h(var_27_6) + 42

	arg_27_1:setContentSize(lc.w(arg_27_1), var_27_8)
	arg_27_1._userArea:setPosition(0, var_27_8 - lc.h(arg_27_1._content) - 22)
	arg_27_1._userArea._regionArea:setColor(ClientView.COLOR_TEXT_WHITE)
	arg_27_1._userArea._idArea:setColor(ClientView.COLOR_TEXT_WHITE)
	arg_27_1._time:setPosition(lc.w(arg_27_1), var_27_8)
	arg_27_1._content:setPosition(0, var_27_8 - lc.h(arg_27_1._content))
	arg_27_1._oppoArea:setPosition(cc.p(lc.w(arg_27_1) + 4, lc.y(arg_27_1._userArea)))
	arg_27_1._oppoArea._regionArea:setColor(ClientView.COLOR_TEXT_WHITE)
	arg_27_1._oppoArea._idArea:setColor(ClientView.COLOR_TEXT_WHITE)
	var_27_6:setPosition(lc.w(arg_27_1) - lc.w(var_27_6) / 2, 38)
	var_27_7:setVisible(false)
	arg_27_1._userArea:removeChildrenByTag(var_0_7)

	if arg_27_2._log then
		local var_27_9 = arg_27_1._oppoArea

		var_27_9:setVisible(true)
		var_27_9:setUser(arg_27_2._opponent, true)

		local var_27_10 = cc.p(lc.cw(arg_27_1), lc.y(arg_27_1._userArea) - 70)

		if arg_27_2._watchIds[P._sid] then
			local var_27_11 = lc.createSprite(arg_27_2._resultType == Data.BattleResult.win and "img_win" or arg_27_2._resultType == Data.BattleResult.lose and "img_lose" or "img_draw")

			var_27_11:setScale(0.5)
			lc.addChildToPos(arg_27_1, var_27_11, cc.p(var_27_10.x - 220, var_27_10.y), 0, var_0_7)

			local var_27_12 = lc.createSprite(arg_27_2._resultType == Data.BattleResult.win and "img_lose" or arg_27_2._resultType == Data.BattleResult.lose and "img_win" or "img_draw")

			var_27_12:setScale(0.5)
			lc.addChildToPos(arg_27_1, var_27_12, cc.p(var_27_10.x + 244, var_27_10.y), 0, var_0_7)
		end

		arg_27_1._infoArea:setVisible(true)
		arg_27_1._infoArea:setPositionY(lc.y(var_27_6))
		arg_27_1._roundVal:setString(string.format(Str(STR.ROUND_N), arg_27_2._round))
		arg_27_1._watchVal:setString(tostring(arg_27_2._watchIdsCount))
		arg_27_1._likeVal:setString(tostring(arg_27_2._likeIdsCount))
		var_27_6._label:setString(Str(STR.REPLAY))

		function var_27_6._callback()
			arg_27_0:replayBattle(arg_27_2)
		end

		if arg_27_2._likeIds[P._sid] then
			var_27_7._label:setString(Str(STR.CANCEL))

			function var_27_7._callback()
				ClientData.sendShareLikeCancel(arg_27_2._log._id)
			end
		else
			var_27_7._label:setString(Str(STR.ZAN))

			function var_27_7._callback()
				ClientData.sendShareLike(arg_27_2._log._id)
			end
		end

		var_27_7:setVisible(true)
		var_27_7:setPosition(lc.left(var_27_6) - 6 - lc.w(var_27_7) / 2, lc.y(var_27_6))
	else
		arg_27_1._oppoArea:setVisible(false)
		arg_27_1._infoArea:setVisible(false)

		if arg_27_2._result then
			var_27_6._label:setString(Str(STR.JOIN))
			var_27_6:setEnabled(false)
		else
			var_27_6._label:setString(Str(STR.JOIN))

			function var_27_6._callback()
				arg_27_0:joinFriendBattle(arg_27_2._battleId)
			end
		end
	end

	return arg_27_1
end

function var_0_0.processByWin32Cmd(arg_35_0)
	if lc.PLATFORM == cc.PLATFORM_OS_WINDOWS then
		local var_35_0 = arg_35_0._iptSend:getText()

		if string.find(var_35_0, "CMD") == 1 or string.find(var_35_0, "cmd") == 1 then
			local var_35_1 = string.splitByChar(var_35_0, " ")

			for iter_35_0, iter_35_1 in ipairs(var_35_1) do
				local var_35_2 = string.splitByChar(iter_35_1, ":")

				if #var_35_2 == 2 then
					local var_35_3 = var_35_2[1]
					local var_35_4 = var_35_2[2]

					if var_35_3 == "replay" then
						ClientView.getActiveIndicator():show(Str(STR.WAITING))

						local var_35_5 = tonumber(var_35_4)

						ClientData.sendBattleReplay(var_35_5, var_35_5 < 2147483647)

						break
					end
				end
			end

			return true
		end
	end

	return false
end

function var_0_0.send2World(arg_36_0)
	if arg_36_0:processByWin32Cmd() then
		return
	end

	if P:getMaxCharacterLevel() < 1 then
		arg_36_0._iptSend:setText("")
		ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), Data._globalInfo._unlockChat))

		return
	end

	if P._chatBanList[P._id] then
		arg_36_0._iptSend:setText("")
		ToastManager.push(Str(STR.CHAT_BAN_TIP))

		return
	end

	local var_36_0, var_36_1 = P:isAllowChat()

	if not var_36_0 then
		return ToastManager.push(var_36_1)
	end

	local nextChat = P._nextChat or 0
	local var_36_2 = math.ceil(nextChat - ClientData.getCurrentTime())

	if var_36_2 <= 0 then
		local var_36_3 = arg_36_0._iptSend:getText()

		if var_36_3 == "" then
			return
		end

		local var_36_4 = string.gsub(var_36_3, "\n", " ")

		if lc.utf8len(var_36_4) > ClientData.MAX_INPUT_LEN then
			ToastManager.push(Str(STR.MESSAGE) .. string.format(Str(STR.CANNOT_MORE_THAN), ClientData.MAX_INPUT_LEN))
		else
			local chatCd = (Data and Data._globalInfo and Data._globalInfo._chatCD) or 0
			P._nextChat = ClientData.getCurrentTime() + chatCd * 60

			ClientData.sendChat(Chat_pb.PB_CHAT_WORLD, 0, var_36_4)
			arg_36_0._iptSend:setText("")
		end
	else
		ToastManager.push(string.format(Str(STR.WORLD_CHAT_WAIT_TIP), ClientData.formatPeriod(var_36_2)))
	end
end

function var_0_0.send2Union(arg_37_0)
	local var_37_0 = P._playerUnion
	local var_37_1 = var_37_0:canOperate(var_37_0.Operate.send_message)

	if var_37_1 == Data.ErrorType.ok then
		local var_37_2 = arg_37_0._iptSend:getText()

		if var_37_2 == "" then
			return
		end

		if lc.utf8len(var_37_2) > ClientData.MAX_INPUT_LEN then
			ToastManager.push(Str(STR.MESSAGE) .. string.format(Str(STR.CANNOT_MORE_THAN), ClientData.MAX_INPUT_LEN))
		else
			ClientData.sendChat(Chat_pb.PB_CHAT_UNION, P._unionId, var_37_2)
			arg_37_0._iptSend:setText("")
		end
	else
		ToastManager.push(ClientData.getUnionErrorStr(var_37_1))
	end
end

function var_0_0.replayBattle(arg_38_0, arg_38_1)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))

	local var_38_0 = arg_38_1._log

	ClientData._replayingLog = var_38_0
	ClientData._replaySharable = false

	ClientData.sendBattleShareReplay(var_38_0._id)
	ClientData.sendUserEvent({
		chatReplayId = var_38_0._id
	})
end

function var_0_0.joinFriendBattle(arg_39_0, arg_39_1)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendFriendBattleJoin(arg_39_1)
end

function var_0_0.onMessageEvent(arg_40_0, arg_40_1)
	if arg_40_0._isPop then
		local var_40_0 = arg_40_0._contentBg._focusTabIndex

		if arg_40_1._event == P._playerMessage.Event.msg_new then
			if var_40_0 == arg_40_1._type then
				arg_40_0:updateList(arg_40_1._param)
			end
		elseif arg_40_1._event == P._playerMessage.Event.msg_update then
			if var_40_0 == arg_40_1._type then
				arg_40_0:updateListItem(arg_40_1._param)
			end
		elseif arg_40_1._event == P._playerMessage.Event.union_clear and var_40_0 == var_0_1.union then
			arg_40_0._contentBg:showTab(var_0_1.world)
		end

		P._playerMessage:clearNew(var_40_0)
	end

	arg_40_0:showTabFlag()
end

function var_0_0.onEnter(arg_41_0)
	arg_41_0:showTabFlag()
	ClientData._chatPanel = arg_41_0

	arg_41_0._listeners = {}

	table.insert(arg_41_0._listeners, lc.addEventListener(Data.Event.login, function(arg_42_0)
		arg_41_0:resetList()
	end))

	-- Load chat history when the panel enters the scene (safe timing: scene fully loaded)
	pcall(function()
		if ClientData.pollChatHistory then
			ClientData.pollChatHistory()
		end
	end)
end

function var_0_0.onExit(arg_43_0)
	for iter_43_0 = 1, #arg_43_0._listeners do
		lc.Dispatcher:removeEventListener(arg_43_0._listeners[iter_43_0])
	end
	-- Retain ClientData._chatPanel as singleton across scene changes
end

function var_0_0.onRelease(arg_44_0)
	arg_44_0:removeAllChildren()
	lc.Dispatcher:removeEventListener(arg_44_0._listener)
end

return var_0_0
