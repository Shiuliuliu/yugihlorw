local var_0_0 = class("DescForm", BaseForm)
local var_0_1 = require("CardThumbnail")
local var_0_2 = require("CardInfoPanel")
local var_0_3 = cc.size(1000, 710)

var_0_0.TroopType = {
	extend = 2,
	main = 1
}

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2 == nil and Str(STR.INFO) or Str(STR.RECOMMEND_TROOP)

	arg_2_0._type = arg_2_2
	arg_2_0._troopType = var_0_0.TroopType.main

	var_0_0.super.init(arg_2_0, var_0_3, var_2_0, 0)

	local var_2_1 = lc.createSprite({
		_name = "troop_bg",
		_crect = cc.rect(0, 0, 1, 365),
		_size = cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, 365)
	})

	lc.addChildToPos(arg_2_0._frame, var_2_1, cc.p(var_0_3.width / 2, var_0_0.FRAME_THICK_BOTTOM + 60 + lc.h(var_2_1) / 2))

	arg_2_0._troopBg = var_2_1

	local var_2_2 = lc.List.createH(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, ClientView.CARD_SIZE.height), 30, 30)

	var_2_2:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(var_2_1, var_2_2)
	lc.offset(var_2_2, 0, 10)

	arg_2_0._list = var_2_2

	if arg_2_2 ~= nil then
		arg_2_0._input = arg_2_1
		arg_2_0._user = ClientData.getAttackUserFromInput(arg_2_1)
		arg_2_0._troop = ClientData.pbTroopToTroop(arg_2_0._user._troopCards)

		arg_2_0:updateView()
	else
		arg_2_0._userId = arg_2_1
		arg_2_0._indicator = ClientView.showPanelActiveIndicator(arg_2_0._form)
	end
end

function var_0_0.onShowActionFinished(arg_3_0)
	if arg_3_0._type == nil then
		ClientData.sendUserVisit(arg_3_0._userId)
	end
end

function var_0_0.updateView(arg_4_0)
	local var_4_0 = arg_4_0._user
	local var_4_1 = arg_4_0._type
	local var_4_2 = arg_4_0._troop
	local var_4_3 = lc.bottom(arg_4_0._titleFrame) - 20
	local var_4_4 = UserWidget.Flag.LEVEL_NAME

	if var_4_1 == Data.RecommendTroop.player then
		var_4_4 = bor(var_4_4, UserWidget.Flag.REGION)
	end

	if not arg_4_0._widget then
		local var_4_5 = require("UserWidget").create(var_4_0, var_4_4)

		if var_4_5._regionArea then
			lc.offset(var_4_5._regionArea, 20, -100)
			var_4_5._regionArea:setColor(ClientView.COLOR_TEXT_WHITE)
		end

		lc.addChildToPos(arg_4_0._frame, var_4_5, cc.p(60 + lc.w(var_4_5) / 2, var_4_3 - 50))

		arg_4_0._widget = var_4_5
	end

	local var_4_6 = arg_4_0._label

	if not var_4_6 then
		var_4_6 = ClientView.createTTF(Str(STR.CUR_TROOP), ClientView.FontSize.S1, ClientView.COLOR_TEXT_TITLE)

		lc.addChildToPos(arg_4_0._frame, var_4_6, cc.p(60 + lc.cw(var_4_6), lc.ch(var_4_6) + var_0_0.FRAME_THICK_BOTTOM + 10))

		arg_4_0._label = var_4_6
	end

	if not arg_4_0._countLabel then
		local var_4_7 = 0
		local var_4_8 = 0
		local var_4_9 = 0

		for iter_4_0, iter_4_1 in ipairs(var_4_2) do
			local var_4_10 = Data.getType(iter_4_1._infoId)

			if var_4_10 == Data.CardType.monster then
				var_4_7 = var_4_7 + iter_4_1._num
			elseif var_4_10 == Data.CardType.rare then
				var_4_9 = var_4_9 + iter_4_1._num
			else
				var_4_8 = var_4_8 + iter_4_1._num
			end
		end

		local var_4_11 = ClientView.createBMFont(ClientView.BMFont.huali_26, string.format(Str(STR.TROOP_ALL_COUNT), var_4_7, var_4_8, var_4_9))

		lc.addChildToPos(arg_4_0._frame, var_4_11, cc.p(lc.right(var_4_6) + 40 + lc.cw(var_4_11), lc.y(var_4_6)))

		arg_4_0._countLabel = var_4_11
	end

	arg_4_0:updateTroopList()

	if not arg_4_0._trainBtn then
		local var_4_12 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_5_0)
			arg_4_0:onTrain()
		end, ClientView.CRECT_BUTTON, 150)

		var_4_12:addLabel(Str(STR.TRAIN))
		var_4_12:setVisible(arg_4_0._input ~= nil)
		lc.addChildToPos(arg_4_0._frame, var_4_12, cc.p(var_0_3.width - 120, var_4_3 - 50))

		arg_4_0._trainBtn = var_4_12
	end

	local var_4_13 = arg_4_0._troopBg
	local var_4_14 = arg_4_0._mainBtn

	if not var_4_14 then
		var_4_14 = ClientView.createShaderButton("troop_selected", function(arg_6_0)
			arg_4_0._troopType = var_0_0.TroopType.main

			arg_4_0:updateView()
		end)

		var_4_14:addIcon("img_troop_main")
		var_4_14:setAnchorPoint(0.5, 1)
		lc.addChildToPos(var_4_13, var_4_14, cc.p(lc.cw(var_4_14), lc.h(var_4_13) + 56))

		arg_4_0._mainBtn = var_4_14
	end

	var_4_14:loadTextureNormal(arg_4_0._troopType == var_0_0.TroopType.main and "troop_selected" or "troop_unselected", ccui.TextureResType.plistType)
	var_4_14._icon:setPosition(cc.p(lc.cw(var_4_14), lc.h(var_4_14) - 25))
	var_4_14:setEnabled(arg_4_0._troopType ~= var_0_0.TroopType.main)

	local var_4_15 = arg_4_0._extendBtn

	if not var_4_15 then
		var_4_15 = ClientView.createShaderButton("troop_unselected", function(arg_7_0)
			arg_4_0._troopType = var_0_0.TroopType.extend

			arg_4_0:updateView()
		end)

		var_4_15:addIcon("img_troop_rare")
		var_4_15:setAnchorPoint(0.5, 1)
		lc.addChildToPos(var_4_13, var_4_15, cc.p(lc.right(var_4_14) + 10 + lc.cw(var_4_15), lc.h(var_4_13) + 56))

		arg_4_0._extendBtn = var_4_15
	end

	var_4_15:loadTextureNormal(arg_4_0._troopType == var_0_0.TroopType.extend and "troop_selected" or "troop_unselected", ccui.TextureResType.plistType)
	var_4_15._icon:setPosition(cc.p(lc.cw(var_4_15), lc.h(var_4_15) - 25))
	var_4_15:setEnabled(arg_4_0._troopType ~= var_0_0.TroopType.extend)
end

function var_0_0.updateTroopList(arg_8_0)
	local var_8_0 = arg_8_0._troop

	arg_8_0:releaseTroopCards()

	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_2 = Data.getType(iter_8_1._infoId)

		if (arg_8_0._troopType ~= var_0_0.TroopType.main or var_8_2 ~= Data.CardType.rare) and (arg_8_0._troopType ~= var_0_0.TroopType.extend or var_8_2 == Data.CardType.rare) then
			local var_8_3

			if not var_8_3 then
				var_8_3 = ClientView.createShaderButton(nil, function()
					var_0_2.create(iter_8_1._infoId, 1, var_0_2.OperateType.view):show()
				end)

				var_8_3:retain()

				local var_8_4 = var_0_1.createFromPool(iter_8_1._infoId, 0.7)

				var_8_4._countArea:update(true, iter_8_1._num)
				var_8_3:setContentSize(var_8_4._thumbnail:getContentSize())
				var_8_3:setAnchorPoint(cc.p(0.5, 0.5))
				lc.addChildToPos(var_8_3, var_8_4, cc.p(lc.cw(var_8_3), lc.ch(var_8_3) + 10))
				var_8_4._thumbnail:setGray(P._playerCard:getCardCount(iter_8_1._infoId) < iter_8_1._num)

				var_8_3._item = var_8_4
			else
				var_8_3._item._countArea:update(true, iter_8_1._num)
				var_8_3._item._thumbnail:setGray(P._playerCard:getCardCount(iter_8_1._infoId) < iter_8_1._num)
			end

			table.insert(var_8_1, var_8_3)

			var_8_3._card = iter_8_1
		end
	end

	table.sort(var_8_1, function(arg_10_0, arg_10_1)
		local var_10_0 = Data.getOriginId(arg_10_0._card._infoId)
		local var_10_1 = Data.getOriginId(arg_10_1._card._infoId)

		if var_10_0 < var_10_1 then
			return true
		elseif var_10_1 < var_10_0 then
			return false
		else
			return arg_10_0._card._infoId < arg_10_1._card._infoId
		end
	end)

	for iter_8_2, iter_8_3 in ipairs(var_8_1) do
		arg_8_0._list:pushBackCustomItem(iter_8_3)
	end

	local var_8_5 = arg_8_0._label

	arg_8_0._list:refreshView()
	arg_8_0._list:scrollToLeft(0.1, true)
end

function var_0_0.onReplay(arg_11_0)
	lc._runningScene:onReplay(arg_11_0._input)
end

function var_0_0.onTrain(arg_12_0)
	local var_12_0 = ClientData.genRecommendTrainInput(arg_12_0._input)

	lc.replaceScene(require("ResSwitchScene").create(lc._runningScene._sceneId, ClientData.SceneId.battle, var_12_0))
end

function var_0_0.onEnter(arg_13_0)
	var_0_0.super.onEnter(arg_13_0)

	if arg_13_0._type == nil then
		ClientData.addMsgListener(arg_13_0, function(arg_14_0)
			return arg_13_0:onMsg(arg_14_0)
		end, 0)
	end
end

function var_0_0.onExit(arg_15_0)
	var_0_0.super.onExit(arg_15_0)

	if arg_15_0._type == nil then
		ClientData.removeMsgListener(arg_15_0)
	end
end

function var_0_0.onCleanup(arg_16_0)
	arg_16_0:releaseTroopCards()
	var_0_0.super.onCleanup(arg_16_0)
end

function var_0_0.releaseTroopCards(arg_17_0)
	if arg_17_0._list then
		local var_17_0 = arg_17_0._list:getItems()

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			var_0_1.releaseToPool(iter_17_1._item)
			iter_17_1:release()
		end

		arg_17_0._list:removeAllItems()
	end
end

function var_0_0.onMsg(arg_18_0, arg_18_1)
	if arg_18_1.type == SglMsgType_pb.PB_TYPE_USER_VISIT then
		arg_18_0._indicator:removeFromParent()

		local var_18_0 = arg_18_1.Extensions[User_pb.SglUserMsg.user_visit_resp]

		arg_18_0._user = require("User").create(var_18_0.user_info)
		arg_18_0._troop = ClientData.pbTroopToTroop(var_18_0.troop)

		arg_18_0:updateView()

		return true
	end

	return false
end

return var_0_0
