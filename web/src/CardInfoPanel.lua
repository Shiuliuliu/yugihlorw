local var_0_0 = class("CardInfoPanel", require("BasePanel"))
local var_0_1 = require("CardOperatePanel")
local var_0_2 = 1000
local var_0_3 = 604
local var_0_4 = 10
local var_0_5 = 10
local var_0_6 = 4
local var_0_7 = 26
local var_0_8 = 36
local var_0_9 = 36
local var_0_10 = 255
local var_0_11 = 128
local var_0_12 = 350
local var_0_13 = ClientView.COLOR_TEXT_GREEN_DARK
local var_0_14 = ClientView.COLOR_TEXT_GRAY, ClientView.COLOR_TEXT_LIGHT

var_0_0.OperateType = {
	recall = 6,
	recovery = 5,
	na = 1,
	troop = 2,
	view = 3,
	operate = 4
}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	if arg_1_3 and arg_1_3._srcInfoId then
		arg_1_0 = arg_1_3._srcInfoId
	end

	local var_1_1 = false
	local var_1_2 = false
	local var_1_3 = 0
	local var_1_4, var_1_5, var_1_6

	arg_1_0, var_1_4, var_1_5, var_1_6 = Data.removeAdditional(arg_1_0)
	var_1_0._isGold = var_1_5
	var_1_0._extraSid = var_1_6
	arg_1_0 = Data.setAdditional(arg_1_0, false, var_1_5, var_1_6)

	local var_1_7 = Data.getInfo(arg_1_0)

	if arg_1_2 == var_0_0.OperateType.operate and var_1_7 and var_1_7._packageId[1] == Data.UNION_SHOP_PACKAGE_ID then
		arg_1_2 = var_0_0.OperateType.recovery

		if not arg_1_3 then
			for iter_1_0, iter_1_1 in ipairs(Data._unionProductsExInfo) do
				if iter_1_1._cardId == arg_1_0 then
					arg_1_3 = iter_1_1

					break
				end
			end
		end
	end

	if arg_1_2 then
		var_0_0._operateType = arg_1_2
	end

	if var_0_0._operateType == nil then
		var_0_0._operateType = var_0_0.OperateType.na
	end

	var_1_0:init(arg_1_0, arg_1_1, arg_1_3, arg_1_4, arg_1_5)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	var_0_0.super.init(arg_2_0, false)

	arg_2_0._panelName = "CardInfoPanel"
	arg_2_0._infoId = arg_2_1
	arg_2_0._level = arg_2_2 or P._playerCard._levels[arg_2_1] or 1
	arg_2_0._card = arg_2_3
	arg_2_0._statusStrs = arg_2_4
	arg_2_0._hasStatus = arg_2_0._statusStrs ~= nil and #arg_2_0._statusStrs[1] + #arg_2_0._statusStrs[2] > 0
	arg_2_0._params = arg_2_5

	arg_2_0:addChild(arg_2_0:createTopArea())
	arg_2_0:addChild(arg_2_0:createCard())
	arg_2_0:addChild(arg_2_0:createRightArea())
	arg_2_0:addChild(arg_2_0:createBottomArea())
	arg_2_0._topArea:setVisible(false)
end

function var_0_0.setCardList(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._isForce = true

	arg_3_0._topArea:setVisible(true)
	arg_3_0._topArea._title:setString(arg_3_3)
	arg_3_0._topArea._posLabel:setString(arg_3_2 .. "/" .. #arg_3_1)

	arg_3_0._cardList = arg_3_1
	arg_3_0._cardListIndex = arg_3_2

	arg_3_0:checkCardList()
end

function var_0_0.setCardCount(arg_4_0, arg_4_1)
	arg_4_0._count = arg_4_1

	if arg_4_0._countLabel == nil then
		local var_4_0 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.AMOUNT) .. ": " .. arg_4_1)

		var_4_0:setAnchorPoint(0, 0.5)
		lc.addChildToPos(arg_4_0._bottomArea, var_4_0, cc.p(6, lc.h(arg_4_0._bottomArea) - lc.h(var_4_0) / 2))

		arg_4_0._countLabel = var_4_0

		lc.offset(arg_4_0._versionLabel, 0, -lc.ch(var_4_0) - 10)
		lc.offset(arg_4_0._btnCollect, 0, -lc.ch(var_4_0) - 10)
	else
		arg_4_0._countLabel:setString(Str(STR.AMOUNT) .. ": " .. arg_4_1)
	end
end

function var_0_0.checkCardList(arg_5_0)
	if arg_5_0._cardList == nil then
		return
	end

	local var_5_0 = arg_5_0._cardList
	local var_5_1 = arg_5_0._cardListIndex
	local var_5_2 = 60
	local var_5_3 = 100

	local function var_5_4(arg_6_0)
		arg_5_0._cardListIndex = arg_5_0._cardListIndex + (arg_6_0 and 1 or -1)

		local var_6_0 = var_5_0[arg_5_0._cardListIndex]
		local var_6_1
		local var_6_2

		if type(var_6_0) == "number" then
			var_6_1 = var_6_0
		else
			var_6_1 = var_6_0._infoId
			var_6_2 = var_6_0._num
		end

		local var_6_3 = var_0_0.create(var_6_1, nil)

		var_6_3:setCardList(var_5_0, arg_5_0._cardListIndex, arg_5_0._topArea._title:getString())

		if var_6_2 ~= nil then
			var_6_3:setCardCount(var_6_2)
		end

		var_6_3:show()
		arg_5_0:hide()
	end

	local function var_5_5(arg_7_0, arg_7_1)
		arg_7_0:setEnabled(arg_7_1)
		arg_7_0:setSwallowTouches(true)
		arg_7_0._arrow:setVisible(arg_7_1)
	end

	local var_5_6 = arg_5_0._arrowLeft

	if var_5_6 == nil then
		var_5_6 = ClientView.createArrowButton(true, cc.size(var_5_2, var_5_3), function()
			var_5_4(false)
		end)

		lc.addChildToPos(arg_5_0, var_5_6, cc.p(var_5_2 / 2 + 10, 100))

		arg_5_0._arrowLeft = var_5_6
	end

	local var_5_7 = arg_5_0._arrowRight

	if var_5_7 == nil then
		var_5_7 = ClientView.createArrowButton(false, cc.size(var_5_2, var_5_3), function()
			var_5_4(true)
		end)

		lc.addChildToPos(arg_5_0, var_5_7, cc.p(lc.w(arg_5_0) - var_5_2 / 2 - 10, 100))

		arg_5_0._arrowRight = var_5_7
	end

	var_5_5(var_5_6, var_5_0[var_5_1 - 1] ~= nil)
	var_5_5(var_5_7, var_5_0[var_5_1 + 1] ~= nil)
end

function var_0_0.createCurrentOwn(arg_10_0)
	local var_10_0 = ClientView.createBMFont(ClientView.BMFont.huali_26, "")

	var_10_0:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_10_0._bottomArea, var_10_0, cc.p(6, lc.h(arg_10_0._bottomArea) - lc.h(var_10_0) / 2))

	arg_10_0._currentOwnLabel = var_10_0

	arg_10_0:updateCurrentOwn()
end

function var_0_0.createTopArea(arg_11_0)
	local var_11_0 = ClientView.createTitleArea(Str(STR.CARD_LIST), function()
		arg_11_0:hide()

		if GuideManager.getCurStepName() == "leave card info" then
			GuideManager.finishStep()
		end
	end)
	local var_11_1 = ClientView.createBMFont(ClientView.BMFont.huali_32, "1/1")

	lc.addChildToPos(var_11_0, var_11_1, cc.p(400, lc.ch(var_11_0)))

	var_11_0._posLabel = var_11_1
	arg_11_0._topArea = var_11_0

	return var_11_0
end

function var_0_0.createBottomArea(arg_13_0)
	local var_13_0 = ccui.Layout:create()

	var_13_0:setContentSize(lc.w(arg_13_0._thumbnail), ClientView.PANEL_BOTTOM_HEIGHT)
	var_13_0:setAnchorPoint(0.5, 0.5)
	var_13_0:setPosition(lc.x(arg_13_0._thumbnail), lc.bottom(arg_13_0._thumbnail) - 20 - lc.h(var_13_0) / 2)

	arg_13_0._bottomArea = var_13_0

	local var_13_1 = lc.h(var_13_0)

	if var_0_0._operateType >= var_0_0.OperateType.view then
		arg_13_0:createCurrentOwn()
	end

	if arg_13_0._currentOwnLabel or arg_13_0._countLabel then
		var_13_1 = lc.bottom(arg_13_0._currentOwnLabel or arg_13_0._countLabel)
	end

	if P and P._id and P._id > 0 then
		local var_13_2 = ClientView.createTTF(Str(STR.VERSION) .. math.floor(ClientData.getServerTick() / 100))

		lc.addChildToPos(var_13_0, var_13_2, cc.p(lc.cw(var_13_2) + 8, var_13_1 - lc.ch(var_13_2) - 5))

		arg_13_0._versionLabel = var_13_2
		var_13_1 = lc.bottom(var_13_2)
	end

	if (var_0_0._operateType == var_0_0.OperateType.operate or var_0_0._operateType == var_0_0.OperateType.recovery) and P._guideID >= 500 and not arg_13_0._isGold then
		local var_13_3 = Data.getInfo(arg_13_0._infoId)

		if var_0_0._operateType == var_0_0.OperateType.operate then
			local var_13_4 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_14_0)
				var_0_1.create(arg_13_0._infoId, var_0_1.OperateMode.decompose):show()
			end, ClientView.CRECT_BUTTON, 120)

			var_13_4:addLabel(Str(STR.DECOMPOSE))
			lc.addChildToPos(var_13_0, var_13_4, cc.p(lc.cw(var_13_4), var_13_1 - 5 - lc.ch(var_13_4)))

			local var_13_5 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_15_0)
				arg_13_0:onDecomposeAll()
			end, ClientView.CRECT_BUTTON, 120)

			var_13_5:addLabel(Str(STR.DECOMPOSE_ALL))
			lc.addChildToPos(var_13_0, var_13_5, cc.p(lc.right(var_13_4) + 20 + lc.w(var_13_5) / 2, lc.y(var_13_4)))

			var_13_1 = lc.bottom(var_13_4)
		elseif var_0_0._operateType == var_0_0.OperateType.recovery then
			local var_13_6 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_16_0)
				var_0_1.create(arg_13_0._infoId, var_0_1.OperateMode.recovery, arg_13_0._card):show()
			end, ClientView.CRECT_BUTTON, 120)

			var_13_6:addLabel(Str(STR.RECOVERY))
			lc.addChildToPos(var_13_0, var_13_6, cc.p(lc.cw(var_13_0), var_13_1 - 5 - lc.ch(var_13_6)))

			var_13_1 = lc.bottom(var_13_6)
		end
	end

	local var_13_7 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_17_0)
		if P._playerCard:isCollected(arg_13_0._infoId) then
			P._playerCard:setCollected(arg_13_0._infoId)
		else
			P._playerCard:setCollected(arg_13_0._infoId, true)
		end

		arg_17_0._label:setString(P._playerCard:isCollected(arg_13_0._infoId) and Str(STR.COLLECTED) or Str(STR.COLLECT_2))
	end, ClientView.CRECT_BUTTON, 120)

	var_13_7:addLabel(P._playerCard:isCollected(arg_13_0._infoId) and Str(STR.COLLECTED) or Str(STR.COLLECT_2))
	lc.addChildToPos(var_13_0, var_13_7, cc.p(lc.cw(var_13_7), var_13_1 - 5 - lc.ch(var_13_7)))

	arg_13_0._btnCollect = var_13_7

	if var_0_0._operateType == var_0_0.OperateType.troop then
		local var_13_rem = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_rem_0)
			local curTroop = ClientData._cloneTroops and ClientData._cloneTroops[P._curTroopIndex]
			if curTroop then
				curTroop._isDirty = true
				for iter_rem = 1, #curTroop do
					if tonumber(curTroop[iter_rem]._infoId) == tonumber(arg_13_0._infoId) then
						curTroop[iter_rem]._num = (tonumber(curTroop[iter_rem]._num) or 1) - 1
						if curTroop[iter_rem]._num <= 0 then
							table.remove(curTroop, iter_rem)
						end
						break
					end
				end
				if lc._runningScene and lc._runningScene._scene and lc._runningScene._scene._curTroopIndex then
					pcall(function()
						lc._runningScene._scene:updateCardList(false)
						lc._runningScene._scene:updateTroopList()
						lc._runningScene._scene:updateBottomValueAreas()
					end)
				end
				ToastManager.push("Đã tháo bài khỏi bộ bài")
				arg_13_0:hide()
			end
		end, ClientView.CRECT_BUTTON_S, 130)
		var_13_rem:addLabel("Tháo bộ bài")
		lc.addChildToPos(var_13_0, var_13_rem, cc.p(lc.right(var_13_7) + 20 + lc.w(var_13_rem) / 2, lc.y(var_13_7)))
	end

	if var_0_0._operateType == var_0_0.OperateType.operate and lc._runningScene and lc._runningScene._scene and lc._runningScene._scene._curTroopIndex then
		local var_13_add = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_add_0)
			local scene = lc._runningScene and lc._runningScene._scene
			local curTroop = scene and ClientData._cloneTroops and ClientData._cloneTroops[scene._curTroopIndex]
			if curTroop and scene.addCardToTroop then
				local info = Data.getInfo(arg_13_0._infoId)
				local maxCnt = info and info._maxCount or 3
				local curCnt = scene:getTroopCardCount(curTroop, arg_13_0._infoId)
				if curCnt >= maxCnt then
					ToastManager.push("Đã đạt giới hạn số lượng lá bài này trong bộ bài!")
					return
				end
				scene:onCardUnlocked(arg_13_0._infoId)
				curTroop._isDirty = true
				scene:addCardToTroop(curTroop, arg_13_0._infoId)
				scene:updateCardList(false)
				scene:updateTroopList()
				scene:updateBottomValueAreas()
				ToastManager.push("Đã thêm bài vào bộ bài")
				arg_13_0:hide()
			end
		end, ClientView.CRECT_BUTTON_S, 130)
		var_13_add:addLabel("Thêm vào bộ")
		lc.addChildToPos(var_13_0, var_13_add, cc.p(lc.right(var_13_7) + 20 + lc.w(var_13_add) / 2, lc.y(var_13_7)))
	end

	return var_13_0
end

function var_0_0.createCard(arg_18_0)
	local var_18_0 = lc.Director:getVisibleSize()
	local var_18_1

	if var_0_0._operateType ~= var_0_0.OperateType.na then
		var_18_1 = P._playerCard:getSkinId(arg_18_0._infoId)
	end

	local var_18_2 = require("CardThumbnail").create(arg_18_0._infoId, nil, var_18_1)

	var_18_2:setTouchEnabled(false)
	var_18_2:setPosition(var_18_0.width / 2 + 230 + lc.w(var_18_2) / 2, lc.bottom(arg_18_0._topArea) - 30 - lc.h(var_18_2) / 2)

	arg_18_0._thumbnail = var_18_2

	return var_18_2
end

function var_0_0.createRightArea(arg_19_0)
	local var_19_0 = lc.h(arg_19_0) - 100
	local var_19_1 = ClientView.createFrameBox(cc.size(var_0_3, var_19_0))

	var_19_1:setPosition(lc.left(arg_19_0._thumbnail) - var_0_6 - var_0_3 / 2, lc.top(arg_19_0._thumbnail) - lc.h(var_19_1) / 2 + 14)

	local var_19_2 = cc.size(lc.w(var_19_1) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(var_19_1) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM)

	var_19_1._lists = {}

	local var_19_3 = {}

	if arg_19_0._hasStatus then
		var_19_3[#var_19_3 + 1] = Str(STR.STATUS)

		local var_19_4 = lc.List.createV(var_19_2, 16, 20)

		var_19_4:setAnchorPoint(0.5, 0.5)
		var_19_4:pushBackCustomItem(arg_19_0:createStatus(var_19_2))
		lc.addChildToPos(var_19_1, var_19_4, cc.p(lc.w(var_19_1) / 2, lc.h(var_19_1) / 2))

		var_19_1._lists[#var_19_1._lists + 1] = var_19_4
	end

	var_19_3[#var_19_3 + 1] = Str(STR.INFO)

	local var_19_5 = require("CardInfoWidget").create(arg_19_0._infoId, arg_19_0._level, var_19_2, false, arg_19_0._card, arg_19_0._params, arg_19_0)

	var_19_5:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_19_1, var_19_5, cc.p(lc.w(var_19_1) / 2, lc.h(var_19_1) / 2), -1)

	var_19_1._lists[#var_19_1._lists + 1] = var_19_5

	if not GuideManager.isGuideInCity() and not ClientView.isInBattleServerScene() then
		var_19_3[#var_19_3 + 1] = Str(STR.PACKAGE)

		local var_19_6 = lc.List.createV(var_19_2, 16, 20)

		var_19_6:setAnchorPoint(0.5, 0.5)

		local var_19_7 = Data.getPackages(arg_19_0._infoId)

		if #var_19_7 > 0 then
			var_19_6:pushBackCustomItem(arg_19_0:createPackage(var_19_2, var_19_7))
		end

		lc.addChildToPos(var_19_1, var_19_6, cc.p(lc.w(var_19_1) / 2, lc.h(var_19_1) / 2))

		var_19_1._lists[#var_19_1._lists + 1] = var_19_6

		local var_19_8 = Data.getType(arg_19_0._infoId)

		if var_19_8 == Data.CardType.monster or var_19_8 == Data.CardType.rare then
			var_19_3[#var_19_3 + 1] = Str(STR.SKIN)

			local var_19_9 = require("CardSkinWidget").create(arg_19_0._infoId, var_19_2)

			var_19_9:setAnchorPoint(0.5, 0.5)
			lc.addChildToPos(var_19_1, var_19_9, cc.p(lc.w(var_19_1) / 2, lc.h(var_19_1) / 2), -1)

			var_19_1._lists[#var_19_1._lists + 1] = var_19_9
		end
	end

	ClientView.addVerticalTabButtons(arg_19_0, var_19_3, lc.top(var_19_1) - 80, lc.left(var_19_1) - 124, 350)

	arg_19_0._detailArea = var_19_1

	return var_19_1
end

function var_0_0.showTab(arg_20_0, arg_20_1)
	for iter_20_0 = 1, #arg_20_0._detailArea._lists do
		arg_20_0._detailArea._lists[iter_20_0]:setVisible(iter_20_0 == arg_20_1)
	end

	arg_20_0._tabArea:showTab(arg_20_1)
end

function var_0_0.createPackage(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = ccui.Widget:create()

	var_21_0:setContentSize(arg_21_1.width, #arg_21_2 * 80 + 40)

	local var_21_1 = lc.h(var_21_0) - 40

	for iter_21_0 = 1, #arg_21_2 do
		var_21_1 = arg_21_0:addPackageLine(arg_21_2[iter_21_0], var_21_0, var_21_1)
	end

	return var_21_0
end

function var_0_0.addPackageLine(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = ClientView.createTTF(Str(arg_22_1._nameSid), ClientView.FontSize.M2, ClientView.COLOR_TEXT_ORANGE)

	lc.addChildToPos(arg_22_2, var_22_0, cc.p(lc.w(var_22_0) / 2 + 10, arg_22_3))

	local var_22_1 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_23_0)
		arg_22_0:hide()

		if lc._runningScene._sceneId ~= ClientData.SceneId.tavern then
			ClientView.popScene(true)
			lc.pushScene(require("TavernScene").create(arg_22_1._value))
		end
	end, ClientView.CRECT_BUTTON_S, 100)

	var_22_1:addLabel(Str(STR.GO))
	lc.addChildToPos(arg_22_2, var_22_1, cc.p(lc.w(arg_22_2) - lc.w(var_22_1) / 2 - 10, arg_22_3))

	if lc._runningScene._sceneId == ClientData.SceneId.battle or lc._runningScene._sceneId == ClientData.SceneId.in_room or lc._runningScene._sceneId == ClientData.SceneId.survival_hall or lc._runningScene._sceneId == ClientData.SceneId.survival_ex_hall then
		var_22_1:setVisible(false)
	end

	if GuideManager.isGuideInCity() or ClientView.isInBattleScene() then
		var_22_1:setDisabledShader(ClientView.SHADER_DISABLE)
		var_22_1:setEnabled(false)
		var_22_1:setSwallowTouches(false)
	end

	arg_22_3 = arg_22_3 - 80

	return arg_22_3
end

function var_0_0.addPathDesc(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = lc.frameSize("img_btn_1_s")
	local var_24_1 = ccui.RichTextEx:create()

	var_24_1:setMaxWidth(var_0_12)

	local var_24_2 = string.find(arg_24_2, "|")

	if var_24_2 then
		local var_24_3 = string.find(arg_24_2, "|", var_24_2 + 1)

		if var_24_3 then
			var_24_1:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, string.sub(arg_24_2, 0, var_24_2 - 1), ClientView.TTF_FONT, ClientView.FontSize.S2))
			var_24_1:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_GREEN_DARK, 255, string.sub(arg_24_2, var_24_2 + 1, var_24_3 - 1), ClientView.TTF_FONT, ClientView.FontSize.S2))
			var_24_1:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, string.sub(arg_24_2, var_24_3 + 1), ClientView.TTF_FONT, ClientView.FontSize.S2))
		end
	else
		var_24_1:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, arg_24_2, ClientView.TTF_FONT, ClientView.FontSize.S2))
	end

	var_24_1:setCascadeOpacityEnabled(true)
	var_24_1:formatText()
	lc.addChildToPos(arg_24_1, var_24_1, cc.p(lc.w(var_24_1) / 2 + 10, arg_24_3 + var_24_0.height / 2 - lc.h(var_24_1) / 2))
end

function var_0_0.createStatus(arg_25_0, arg_25_1)
	local var_25_0 = 10
	local var_25_1 = {
		cc.c3b(26, 254, 7),
		cc.c3b(250, 10, 10)
	}
	local var_25_2 = {}

	for iter_25_0 = 1, #arg_25_0._statusStrs do
		for iter_25_1 = 1, #arg_25_0._statusStrs[iter_25_0] do
			local var_25_3 = ClientView.createTTF(arg_25_0._statusStrs[iter_25_0][iter_25_1], ClientView.FontSize.S1, var_25_1[iter_25_0], cc.size(arg_25_1.width - 32, 0), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

			var_25_3:setAnchorPoint(0, 1)

			var_25_2[#var_25_2 + 1] = var_25_3
			var_25_0 = lc.h(var_25_3) + 10
		end
	end

	local var_25_4 = ccui.Widget:create()

	var_25_4:setContentSize(arg_25_1.width - 32, var_25_0)

	local var_25_5 = var_25_0 - 10

	for iter_25_2 = 1, #var_25_2 do
		lc.addChildToPos(var_25_4, var_25_2[iter_25_2], cc.p(0, var_25_5))

		var_25_5 = var_25_5 - lc.h(var_25_2[iter_25_2]) - 10
	end

	return var_25_4
end

function var_0_0.onEnter(arg_26_0)
	var_0_0.super.onEnter(arg_26_0)

	arg_26_0._listeners = {}

	local var_26_0 = lc.addEventListener(GuideManager.Event.seek, function(arg_27_0)
		arg_26_0:onGuide(arg_27_0)
	end)

	table.insert(arg_26_0._listeners, var_26_0)

	local var_26_1 = lc.addEventListener(Data.Event.card_dirty, function(arg_28_0)
		if arg_28_0._infoId == arg_26_0._infoId then
			arg_26_0:updateCurrentOwn()

			if var_0_0._operateType ~= var_0_0.OperateType.na then
				arg_26_0._thumbnail:updateComponent(arg_26_0._infoId, P._playerCard:getSkinId(arg_26_0._infoId))
			end
		end
	end)

	table.insert(arg_26_0._listeners, var_26_1)

	local var_26_2 = lc.addEventListener(Data.Event.card_skill_dirty, function(arg_29_0)
		if arg_29_0._param._oldId == arg_26_0._infoId then
			local var_29_0 = require("RewardPanel")
			local var_29_1 = {
				{
					count = 1,
					info_id = arg_29_0._param._newId
				}
			}

			if Data.getExtraSid(arg_29_0._param._oldId) > 0 then
				local var_29_2, var_29_3, var_29_4, var_29_5 = Data.removeAdditional(arg_29_0._param._oldId)
				local var_29_6 = Data._unRubExInfo[Data.getExtraSid(arg_29_0._param._oldId)]

				if not Data.canSkillRub(var_29_5, var_29_2) then
					var_29_1[#var_29_1 + 1] = {
						info_id = var_29_6._resType,
						count = var_29_6._price
					}
				else
					var_29_1[#var_29_1 + 1] = {
						count = 1,
						info_id = Data.setAdditional(0, false, false, var_29_5)
					}
				end
			end

			var_29_0.create(var_29_1, var_29_0.MODE_EXCHANGE):show()
			arg_26_0:hide()
		end
	end)

	table.insert(arg_26_0._listeners, var_26_2)

	local var_26_3 = GuideManager.getCurStepName()

	if var_26_3 == "show card info" then
		GuideManager.finishStepLater()
	elseif var_26_3 == "leave card reward" or var_26_3 == "leave claim" then
		GuideManager.pauseGuide()
	end

	arg_26_0:showTab(arg_26_0._tabArea._focusTabIndex or 1)
end

function var_0_0.onExit(arg_30_0)
	var_0_0.super.onExit(arg_30_0)

	for iter_30_0 = 1, #arg_30_0._listeners do
		lc.Dispatcher:removeEventListener(arg_30_0._listeners[iter_30_0])
	end

	GuideManager.resumeGuide()
end

function var_0_0.updateView(arg_31_0)
	arg_31_0:showTab(arg_31_0._tabArea._focusTabIndex or 1)
end

function var_0_0.updateCurrentOwn(arg_32_0)
	if arg_32_0._currentOwnLabel then
		arg_32_0._currentOwnLabel:setString(Str(STR.CURRENT_OWN) .. ": " .. P._playerCard:getCardCount(arg_32_0._infoId))
	end
end

function var_0_0.onDecomposeAll(arg_33_0)
	local total, countN, countR, countSR, countUR = P._playerCard:getCanDecomposeCount()

	if total <= 0 then
		ToastManager.push("Hiện không có lá bài thừa nào (> 3 lá) để phân tách!")
		return
	end

	local msg = string.format("Bạn có chắc chắn muốn phân tách tất cả các lá bài thừa (chỉ giữ lại 3 lá mỗi loại)?\n\nCó thể phân tách: %d lá bài thừa\n(UR: %d | SR: %d | R: %d | N: %d)", total, countUR, countSR, countR, countN)

	return require("Dialog").showDialog(msg, function()
		arg_33_0:doDecomposeAll()
	end)
end

function var_0_0.doDecomposeAll(arg_35_0)
	local var_35_0, decomposedList = P._playerCard:decomposeAll()

	if var_35_0 > 0 then
		ClientData.sendCardDecomposeBatch()
	end

	ToastManager.push(string.format("Phân tách thành công! Nhận được %d Vàng", var_35_0))

	if arg_35_0.updateCurrentOwn then
		arg_35_0:updateCurrentOwn()
	end
	if arg_35_0.updateView then
		arg_35_0:updateView()
	end
	if arg_35_0._cardList and arg_35_0._cardList.refresh then
		arg_35_0._cardList:refresh(true)
	end
end

function var_0_0.onGuide(arg_36_0, arg_36_1)
	local var_36_0 = GuideManager.getCurStepName()

	if var_36_0 == "show card attr" then
		GuideManager.setOperateLayer(arg_36_0._detailArea._tabs[2])
	elseif var_36_0 == "show card path" then
		GuideManager.setOperateLayer(arg_36_0._detailArea._tabs[3])
	elseif var_36_0 == "leave card info" then
		GuideManager.setOperateLayer(arg_36_0._topArea._btnBack, nil, arg_36_0._detailArea._tabs)
	elseif var_36_0 == "equip hero" then
		GuideManager.setOperateLayer(arg_36_0._bottomArea._btnEquip)
	else
		return
	end

	arg_36_1:stopPropagation()
end

return var_0_0
