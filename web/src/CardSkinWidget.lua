local var_0_0 = class("CarSkinWidget", lc.ExtendUIWidget)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._infoId = arg_2_1

	arg_2_0:setContentSize(arg_2_2)

	local var_2_0 = lc.List.createV(arg_2_2, 16, 20)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0, var_2_0)

	arg_2_0._list = var_2_0
end

function var_0_0.onEnter(arg_3_0)
	arg_3_0:updateList()
end

function var_0_0.updateList(arg_4_0)
	local var_4_0 = arg_4_0._list

	var_4_0:removeAllItems()

	local var_4_1 = Data.getInfo(arg_4_0._infoId)
	local var_4_2 = {
		0
	}

	if arg_4_0._infoId ~= 10407 or P._vip >= 12 then
		for iter_4_0 = 1, #var_4_1._skin do
			if var_4_1._skin[iter_4_0] == 0 then
				break
			end

			var_4_2[#var_4_2 + 1] = var_4_1._skin[iter_4_0]
		end
	end

	for iter_4_1 = 1, #var_4_2 do
		local var_4_3 = arg_4_0:setOrCreateItem(nil, var_4_2[iter_4_1])

		var_4_0:pushBackCustomItem(var_4_3)
	end
end

function var_0_0.setOrCreateItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2 == 0 and Data.getInfo(arg_5_0._infoId) or Data._skinInfo[arg_5_2]
	local var_5_1, var_5_2 = P._playerCard:hasSkin(arg_5_2)
	local var_5_3 = var_5_2 and var_5_2._expire ~= 0 and ClientData.getExpireDay(var_5_2._expire) or 0
	local var_5_4 = P._playerCard:getSkinId(arg_5_0._infoId) == arg_5_2
	local var_5_5 = arg_5_2 == 0 and 0 or var_5_0._price

	if arg_5_1 == nil then
		arg_5_1 = ccui.Layout:create()

		arg_5_1:setTouchEnabled(true)
		arg_5_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

		local var_5_6 = lc.createSpriteWithMask("res/jpg/skin_bg.jpg")

		arg_5_1:setContentSize(var_5_6:getContentSize())
		lc.addChildToCenter(arg_5_1, var_5_6)

		local var_5_7 = ClientView.createSkinFrame(arg_5_2, arg_5_0._infoId, true)

		lc.addChildToPos(arg_5_1, var_5_7, cc.p(10 + lc.cw(var_5_7), lc.ch(var_5_6)))

		arg_5_1._frame = var_5_7

		local var_5_8 = ClientView.createTTF(Str(var_5_0._nameSid), ClientView.FontSize.S1)

		lc.addChildToPos(arg_5_1, var_5_8, cc.p(384, lc.h(arg_5_1) - 56))

		arg_5_1._nameLabel = var_5_8

		local var_5_9 = lc.createSprite("skin_bought")

		lc.addChildToPos(arg_5_1, var_5_9, cc.p(lc.x(var_5_8), lc.ch(arg_5_1) - 20))
		var_5_9:setVisible(var_5_1 and var_5_3 == 0)

		arg_5_1._statusIcon = var_5_9

		local var_5_10 = ClientView.createBMFont(ClientView.BMFont.huali_26, string.format(Str(STR.SKIN_EXPIRE_IN), var_5_3))

		lc.addChildToPos(arg_5_1, var_5_10, cc.p(lc.x(var_5_8), lc.y(var_5_9)))
		var_5_10:setVisible(var_5_3 ~= 0)

		arg_5_1._expireLabel = var_5_10

		local var_5_11 = ClientView.createResIconLabel(150, ClientData.getPropIconName(Data.PropsId.skin_crystal))

		var_5_11._label:setString(var_5_5)
		lc.addChildToPos(arg_5_1, var_5_11, cc.p(lc.x(var_5_8) + 20, lc.y(var_5_9)))
		var_5_11:setVisible(not var_5_1)

		arg_5_1._priceLabel = var_5_11

		local var_5_12 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_6_0)
			arg_5_0:onBtn(arg_5_2)
		end, ClientView.CRECT_BUTTON_S, 150)

		var_5_12:addLabel(var_5_1 and (var_5_4 and Str(STR.CURRENT) .. Str(STR.SELECT) or Str(STR.SELECT)) or Str(STR.GO) .. Str(STR.BUY))
		var_5_12:setDisabledShader(ClientView.SHADER_DISABLE)
		var_5_12:setEnabled(not var_5_4)
		lc.addChildToPos(arg_5_1, var_5_12, cc.p(lc.x(var_5_8), 46))

		arg_5_1._btn = var_5_12
	else
		arg_5_1._frame:updateSkin(arg_5_2, arg_5_0._infoId)
		arg_5_1._nameLabel:setString(Str(var_5_0._nameSid))

		if var_5_1 then
			arg_5_1._statusIcon:setVisible(var_5_3 == 0)
			arg_5_1._expireLabel:setVisible(var_5_3 ~= 0)
			arg_5_1._priceLabel:setVisible(false)
			arg_5_1._btn._label:setString(var_5_4 and Str(STR.CURRENT) .. Str(STR.SELECT) or Str(STR.SELECT))
		else
			arg_5_1._statusIcon:setVisible(false)
			arg_5_1._expireLabel:setVisible(false)
			arg_5_1._priceLabel:setVisible(true)
			arg_5_1._btn._label:setString(Str(STR.GO) .. Str(STR.BUY))
		end

		arg_5_1._btn:setEnabled(not var_5_4)
	end

	return arg_5_1
end

function var_0_0.onBtn(arg_7_0, arg_7_1)
	if arg_7_1 ~= 0 or not Data.getInfo(arg_7_0._infoId) then
		local var_7_0 = Data._skinInfo[arg_7_1]
	end

	local var_7_1 = P._playerCard:hasSkin(arg_7_1)
	local var_7_2 = P._playerCard:getSkinId(arg_7_0._infoId) == arg_7_1

	if var_7_1 then
		if var_7_2 then
			-- block empty
		else
			if P._playerCard:setSkinId(arg_7_0._infoId, arg_7_1) then
				ClientData.sendSetSkin(arg_7_0._infoId, arg_7_1)
				ToastManager.push(Str(STR.SET_SKIN_SUCCEED))
			else
				ToastManager.push(Str(STR.SET_SKIN_FAILED))
			end

			P._playerCard:sendCardDirty(arg_7_0._infoId)
			arg_7_0:updateList()
		end
	elseif lc._runningScene._sceneId ~= ClientData.SceneId.skin_shop then
		ClientView.popScene(true)
		lc.pushScene(require("SkinShopScene").create())
	end
end

return var_0_0
