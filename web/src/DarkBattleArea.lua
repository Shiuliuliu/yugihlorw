local var_0_0 = class("UnionBattleArea", lc.ExtendCCNode)
local var_0_1 = require("CardThumbnail")
local var_0_2 = require("CardInfoPanel")
local var_0_3 = 300
local var_0_4 = 100
local var_0_5 = 320
local var_0_6 = 500
local var_0_7 = 0.7
local var_0_8 = 0.45
local var_0_9 = Data._globalInfo._darkDuelCost
local var_0_10 = 100

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_0, arg_1_1)
	var_1_0:init()
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		elseif arg_2_0 == "cleanup" then
			var_1_0:onCleanup()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0)
	arg_3_0._curTroopIndex = Data.TroopIndex.dark_battle1

	local var_3_0 = lc.createSprite("res/jpg/dark_battle_bg.jpg")

	lc.addChildToCenter(arg_3_0, var_3_0)

	arg_3_0._areaNode = lc.createNode()

	arg_3_0._areaNode:setContentSize(arg_3_0:getContentSize())
	lc.addChildToCenter(arg_3_0, arg_3_0._areaNode)

	arg_3_0._listeners = {}

	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.rank_list_dirty, function(arg_4_0)
		if arg_4_0._type == SglMsgType_pb.PB_TYPE_RANK_DARK_PRE then
			if arg_3_0._indicator then
				arg_3_0._indicator:removeFromParent()

				arg_3_0._indicator = nil
			end

			arg_3_0:enterDefultArea()
		end
	end))
	ClientData.addMsgListener(arg_3_0, function(arg_5_0)
		return arg_3_0:onMsg(arg_5_0)
	end, 0)
	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.prop_dirty, function(arg_6_0)
		ClientView.addPriceToBtn(arg_3_0._findBtn, 1, Data.PropsId.dark_ticket, 100)
	end))
end

function var_0_0.initTopArea(arg_7_0)
	local var_7_0 = lc.createNode()

	var_7_0:setContentSize(arg_7_0:getContentSize())
	lc.addChildToCenter(arg_7_0, var_7_0)

	arg_7_0._topArea = var_7_0

	local var_7_1 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(var_7_0, var_7_1, cc.p(lc.w(arg_7_0) / 2, lc.h(arg_7_0) - lc.h(var_7_1) / 2 + 5))

	local var_7_2 = ClientView.createTTF(Str(STR.DARK_BATTLE_CHAMPION), ClientView.FontSize.S1)

	lc.addChildToPos(var_7_1, var_7_2, cc.p(lc.w(var_7_1) / 2, lc.h(var_7_1) / 2 + 5))

	local function var_7_3(arg_8_0)
		local var_8_0 = ccui.Widget:create()

		var_8_0:setContentSize(250, 236)

		local var_8_1 = lc.w(var_8_0) / 2
		local var_8_2 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_DARK_PRE)
		local var_8_3
		local var_8_4

		if var_8_2 and var_8_2[arg_8_0] then
			var_8_4 = var_8_2[arg_8_0]
			var_8_3 = var_8_4._user
		end

		if var_8_3 then
			var_8_0:setTouchEnabled(true)
			var_8_0:addTouchEventListener(function(arg_9_0, arg_9_1)
				if arg_9_1 == ccui.TouchEventType.ended then
					require("ClashUserInfoForm").create(var_8_3._id):show()
				end
			end)
		end

		local var_8_5 = cc.ShaderSprite:createWithFramename("img_stage_gold")

		lc.addChildToPos(var_8_0, var_8_5, cc.p(var_8_1, lc.h(var_8_5) / 2))

		local var_8_6 = cc.ShaderSprite:createWithFramename("img_stage_gold_light")

		var_8_6:setScale(2)
		lc.addChildToPos(var_8_5, var_8_6, cc.p(lc.w(var_8_5) / 2, lc.h(var_8_5) + 40))

		local var_8_7 = require("UserWidget").create()

		lc.addChildToPos(var_8_0, var_8_7, cc.p(var_8_1, lc.h(var_8_0) - lc.h(var_8_7) / 2 - 24))

		var_8_0._avatar = var_8_7

		local var_8_8 = ClientView.createIconLabelArea("img_icon_res16_s", var_8_4._value, 150)

		var_8_8._valBg:setScale(0.84)
		var_8_8._icon:setScale(0.84)
		lc.offset(var_8_8._icon, 10)
		lc.offset(var_8_8._label, -10)
		lc.addChildToPos(var_8_0, var_8_8, cc.p(var_8_1, 88))

		var_8_0._trophy = var_8_8._label

		local var_8_9 = ClientView.createTTF(var_8_3 and var_8_3._name or string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.LORD)), ClientView.FontSize.S2)

		lc.addChildToPos(var_8_0, var_8_9, cc.p(var_8_1, 24))

		var_8_0._name = var_8_9

		local var_8_10 = {
			_avatar = var_8_3 and var_8_3._avatar,
			_vip = var_8_3 and var_8_3._vip or 0
		}

		if arg_8_0 == 1 then
			var_8_10._avatarFrameId = 7512
		else
			var_8_5:setScaleY(0.9)
			lc.offset(var_8_7, 0, -4)
			lc.offset(var_8_8, 0, -2)
			lc.offset(var_8_9, 0, 4)

			if arg_8_0 == 2 then
				var_8_10._avatarFrameId = 7510

				var_8_5:setEffect(ClientView.SHADER_COLOR_STAGE_SILVER)
				var_8_6:setEffect(ClientView.SHADER_COLOR_STAGE_SILVER)
			elseif arg_8_0 == 3 then
				var_8_10._avatarFrameId = 7511

				var_8_5:setEffect(ClientView.SHADER_COLOR_STAGE_BRONZE)
				var_8_6:setEffect(ClientView.SHADER_COLOR_STAGE_BRONZE)
			end
		end

		var_8_7:setUser(var_8_10)

		return var_8_0
	end

	local var_7_4 = var_7_3(1)

	lc.addChildToPos(var_7_0, var_7_4, cc.p(lc.w(arg_7_0) / 2, lc.bottom(var_7_1) + 8 - lc.h(var_7_4) / 2), 1)

	local var_7_5 = var_7_3(2)

	lc.addChildToPos(var_7_0, var_7_5, cc.p(math.max(lc.left(var_7_4) - 30 - lc.w(var_7_5), 0) + lc.w(var_7_5) / 2, lc.y(var_7_4)))

	local var_7_6 = var_7_3(3)

	lc.addChildToPos(var_7_0, var_7_6, cc.p(math.min(lc.right(var_7_4) + 30 + lc.w(var_7_5), lc.w(arg_7_0)) - lc.w(var_7_6) / 2, lc.y(var_7_4)))

	var_7_0._stages = {
		var_7_4,
		var_7_5,
		var_7_6
	}
end

function var_0_0.enterDefultArea(arg_10_0)
	if arg_10_0._topArea then
		arg_10_0._topArea:removeFromParent()

		arg_10_0._topArea = nil
	end

	arg_10_0:initTopArea()

	local var_10_0 = arg_10_0._areaNode

	arg_10_0:releaseTroopCards()
	var_10_0:removeAllChildren()

	arg_10_0._troopArea = arg_10_0:createTroopArea(var_10_0)

	arg_10_0:updateTroopList(arg_10_0._curTroopIndex)

	local var_10_1 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_11_0)
		arg_10_0:releaseTroopCards()
		lc.pushScene(require("HeroCenterScene").create(arg_10_0._curTroopIndex))
	end, ClientView.CRECT_BUTTON_S, 100)

	var_10_1:addLabel(Str(STR.MANAGE_CARDS))
	lc.addChildToPos(var_10_0, var_10_1, cc.p(lc.cw(var_10_0) + 300, lc.top(arg_10_0._troopArea) + lc.ch(var_10_1) + 20))

	local var_10_2 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_12_0)
		require("RankForm").create(Data.RankRange.dark):show()
	end, ClientView.CRECT_BUTTON_S, 100)

	var_10_2:addLabel(Str(STR.RANK))
	lc.addChildToPos(var_10_0, var_10_2, cc.p(lc.cw(var_10_0) + 300, lc.top(var_10_1) + lc.ch(var_10_2) + 20))

	local var_10_3 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_13_0)
		require("LogForm").create(Battle_pb.PB_BATTLE_DARK):show()
	end, ClientView.CRECT_BUTTON_S, 100)

	var_10_3:addLabel(Str(STR.LOG))
	lc.addChildToPos(var_10_0, var_10_3, cc.p(lc.cw(var_10_0) - 300, lc.top(arg_10_0._troopArea) + lc.ch(var_10_3) + 20))

	local var_10_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_14_0)
		require("DarkUserInfoForm").create():show()
	end, ClientView.CRECT_BUTTON_S, 100)

	var_10_4:addLabel(Str(STR.RANK_HISTORY))
	lc.addChildToPos(var_10_0, var_10_4, cc.p(lc.cw(var_10_0) - 300, lc.top(var_10_3) + lc.ch(var_10_4) + 20))

	local var_10_5 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_15_0)
		arg_10_0:find()
	end, ClientView.CRECT_BUTTON, 200)

	lc.addChildToPos(var_10_0, var_10_5, cc.p(lc.cw(var_10_0), lc.ch(var_10_0) - 25))
	ClientView.addPriceToBtn(var_10_5, 1, Data.PropsId.dark_ticket, 100)

	arg_10_0._findBtn = var_10_5

	local var_10_6 = lc.createSprite("wait_text_bg")

	var_10_6:setScale(lc.w(var_10_0) / lc.w(var_10_6), 41 / lc.h(var_10_6))
	lc.addChildToPos(var_10_0, var_10_6, cc.p(lc.cw(var_10_0), lc.top(var_10_5) + 25))

	local var_10_7 = ClientView.createTTF(P._playerFindDark:getStartTimeTip(), ClientView.FontSize.S2)

	lc.addChildToPos(var_10_0, var_10_7, cc.p(lc.cw(var_10_0), lc.top(var_10_5) + 25))

	local var_10_8 = lc.createNode()

	var_10_8:setScale(0.8)

	local var_10_9 = ClientView.createShaderButton("img_btn_wheel", function()
		lc.pushScene(require("LotteryScene").create(Data.LotteryType.dark))
	end)

	lc.addChildToCenter(var_10_8, var_10_9)

	local var_10_10 = DragonBones.create("choujiang")

	lc.addChildToCenter(var_10_9, var_10_10)
	var_10_10:gotoAndPlay("effect1")
	lc.addChildToPos(var_10_0, var_10_8, cc.p(lc.right(var_10_5) + lc.cw(var_10_9) + 20, lc.y(var_10_5)))

	if P._playerFindDark:isInDarkBattle() then
		arg_10_0:find()
	end
end

function var_0_0.find(arg_17_0)
	if ClientView._findMatchPanel then
		return
	end

	if not P._playerFindDark:isInDarkBattle() and P:getItemCount(Data.PropsId.dark_ticket) < 1 then
		return require("ExchangeResForm").create(Data.PropsId.dark_ticket):show()
	end

	local var_17_0, var_17_1 = P._playerCard:checkDarkTroops()

	if not var_17_0 then
		return ToastManager.push(var_17_1)
	end

	if P._playerFindDark:getIsValidTime() ~= 0 then
		return ToastManager.push(Str(STR.DARK_BATTLE_NOT_STARTED))
	end

	if ClientView._findMatchPanel then
		return
	end

	require("FindMatchPanel").create(Data.FindMatchType.dark):show()
end

function var_0_0.createTroopArea(arg_18_0, arg_18_1)
	local var_18_0 = lc.createSprite({
		_name = "img_troop_bg_1",
		_size = cc.size(lc.w(arg_18_0) - ClientView.SCR_EDGE * 2, 212),
		_crect = cc.rect(47, 0, 1, 212)
	})

	lc.addChildToPos(arg_18_1, var_18_0, cc.p(lc.cw(arg_18_1), lc.ch(var_18_0)))

	local var_18_1 = lc.List.createH(cc.size(lc.w(var_18_0) - 50, lc.h(var_18_0) - 6), 20, 10)

	lc.addChildToPos(var_18_0, var_18_1, cc.p(24, 0))

	arg_18_0._troopList = var_18_1
	arg_18_0._troopBtns = {}

	for iter_18_0 = 1, 3 do
		local var_18_2 = arg_18_0:createTroopBtn(iter_18_0)

		lc.addChildToPos(var_18_0, var_18_2, cc.p(lc.cw(var_18_0) + (iter_18_0 - 2) * 140, lc.h(var_18_0) + 30))
		var_18_2:setLocalZOrder(arg_18_0._curTroopIndex - Data.TroopIndex.dark_battle1 + 1 == iter_18_0 and 1 or -1)

		arg_18_0._troopBtns[iter_18_0] = var_18_2
	end

	return var_18_0
end

function var_0_0.createTroopBtn(arg_19_0, arg_19_1)
	local var_19_0 = ClientView.createScale9ShaderButton(arg_19_1 == arg_19_0._curTroopIndex - Data.TroopIndex.dark_battle1 + 1 and "troop_select_light" or "troop_select_dark", function(arg_20_0)
		for iter_20_0, iter_20_1 in ipairs(arg_19_0._troopBtns) do
			iter_20_1:loadTextureNormal(iter_20_0 == arg_19_1 and "troop_select_light" or "troop_select_dark", ccui.TextureResType.plistType)
			iter_20_1:setEnabled(iter_20_0 ~= arg_19_1)
			iter_20_1:setLocalZOrder(iter_20_0 == arg_19_1 and 1 or -1)
			iter_20_1:setContentSize(cc.size(120, 77))
			iter_20_1:setCapInsets(cc.rect(38, 0, 1, 77))
		end

		arg_19_0._curTroopIndex = Data.TroopIndex.dark_battle1 + arg_19_1 - 1

		arg_19_0:updateTroopList(arg_19_0._curTroopIndex)
	end, cc.rect(38, 0, 1, 77), 120)

	var_19_0:addLabel(Str(STR.TROOP) .. arg_19_1)
	var_19_0:setEnabled(Data.TroopIndex.dark_battle1 + arg_19_1 - 1 ~= arg_19_0._curTroopIndex)

	return var_19_0
end

function var_0_0.updateTroopList(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:remainItemFromList(arg_21_1)

	arg_21_0:releaseTroopCards()

	local var_21_1 = {}

	for iter_21_0, iter_21_1 in ipairs(P._playerCard._troops[arg_21_1]) do
		local var_21_2

		for iter_21_2 = 1, #var_21_0 do
			if var_21_0[iter_21_2]._card._infoId == iter_21_1._infoId then
				var_21_2 = var_21_0[iter_21_2]

				break
			end
		end

		if not var_21_2 then
			var_21_2 = ccui.Layout:create()

			var_21_2:retain()

			local var_21_3 = var_0_1.createFromPool(iter_21_1._infoId, var_0_8)

			var_21_3._countArea:update(true, iter_21_1._num)
			var_21_2:setContentSize(var_21_3._thumbnail:getContentSize())
			var_21_2:setAnchorPoint(cc.p(0.5, 0.5))
			lc.addChildToPos(var_21_2, var_21_3, cc.p(lc.cw(var_21_2), lc.ch(var_21_2) + 10))
			var_21_3._thumbnail:setTouchEnabled(true)
			var_21_3._thumbnail:addTouchEventListener(function(arg_22_0, arg_22_1)
				arg_21_0:onTouchThumbnail(arg_22_0, arg_22_1)
			end)

			var_21_2._item = var_21_3
		else
			var_21_2._item._countArea:update(true, iter_21_1._num)
		end

		table.insert(var_21_1, var_21_2)

		var_21_2._card = iter_21_1
	end

	table.sort(var_21_1, function(arg_23_0, arg_23_1)
		local var_23_0 = Data.getOriginId(arg_23_0._card._infoId)
		local var_23_1 = Data.getOriginId(arg_23_1._card._infoId)

		if var_23_0 < var_23_1 then
			return true
		elseif var_23_1 < var_23_0 then
			return false
		else
			return arg_23_0._card._infoId < arg_23_1._card._infoId
		end
	end)

	for iter_21_3, iter_21_4 in ipairs(var_21_1) do
		arg_21_0._troopList:pushBackCustomItem(iter_21_4)
	end
end

function var_0_0.onTouchThumbnail(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2 == ccui.TouchEventType.began then
		arg_24_1:stopAllActions()
		arg_24_1:runAction(lc.scaleTo(0.1, 0.95))
	elseif arg_24_2 == ccui.TouchEventType.ended or arg_24_2 == ccui.TouchEventType.canceled then
		arg_24_1:stopAllActions()
		arg_24_1:runAction(lc.scaleTo(0.08, 1))
		arg_24_0:onItemTap(arg_24_1)
	end
end

function var_0_0.onItemTap(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1._infoId
	local var_25_1 = math.abs(cc.pSub(arg_25_1:getTouchEndPosition(), arg_25_1:getTouchBeganPosition()).x)
	local var_25_2 = math.abs(cc.pSub(arg_25_1:getTouchEndPosition(), arg_25_1:getTouchBeganPosition()).y)

	if var_25_1 < 32 and var_25_2 < 32 then
		local var_25_3 = {}
		local var_25_4 = 0
		local var_25_5 = arg_25_0._troopList:getItems()

		for iter_25_0 = 1, #var_25_5 do
			local var_25_6 = var_25_5[iter_25_0]._item._thumbnail

			var_25_3[#var_25_3 + 1] = {
				_infoId = var_25_6._infoId,
				_num = var_25_6._count
			}

			if arg_25_1 == var_25_6 then
				var_25_4 = iter_25_0
			end
		end

		local var_25_7 = var_0_2.create(var_25_0, 1, var_0_2.OperateType.na)

		var_25_7:setCardList(var_25_3, var_25_4, Str(STR.CUR_TROOP))
		var_25_7:setCardCount(arg_25_1._count)
		var_25_7:show()
	end
end

function var_0_0.remainItemFromList(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = arg_26_0._troopList:getItems()

	for iter_26_0 = #var_26_1, 1, -1 do
		local var_26_2 = var_26_1[iter_26_0]
		local var_26_3 = false

		for iter_26_1, iter_26_2 in ipairs(P._playerCard._troops[arg_26_1]) do
			if var_26_2._card._infoId == iter_26_2._infoId then
				var_26_3 = true

				break
			end
		end

		if var_26_3 then
			table.insert(var_26_0, var_26_2)
			arg_26_0._troopList:removeItem(iter_26_0 - 1, false)
		end
	end

	return var_26_0
end

function var_0_0.releaseTroopCards(arg_27_0)
	if arg_27_0._troopList then
		local var_27_0 = arg_27_0._troopList:getItems()

		for iter_27_0, iter_27_1 in ipairs(var_27_0) do
			var_0_1.releaseToPool(iter_27_1._item)
			iter_27_1:release()
		end

		arg_27_0._troopList:removeAllItems()
	end
end

function var_0_0.onEnter(arg_28_0)
	arg_28_0:updateView()
end

function var_0_0.isDataReady(arg_29_0)
	return P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_DARK_PRE)
end

function var_0_0.updateView(arg_30_0)
	if not arg_30_0._indicator then
		arg_30_0._indicator = ClientView.showPanelActiveIndicator(arg_30_0)
	end

	ClientData.sendRankRequest(SglMsgType_pb.PB_TYPE_RANK_DARK_PRE)
end

function var_0_0.onExit(arg_31_0)
	arg_31_0:releaseTroopCards()
	ClientData.removeMsgListener(arg_31_0)
end

function var_0_0.onMsg(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1.type

	return false
end

function var_0_0.onCleanup(arg_33_0)
	lc.TextureCache:removeTextureForKey("res/jpg/dark_battle_bg.jpg")

	for iter_33_0 = 1, #arg_33_0._listeners do
		lc.Dispatcher:removeEventListener(arg_33_0._listeners[iter_33_0])
	end
end

return var_0_0
