local var_0_0 = class("SkinBuyForm", BaseForm)
local var_0_1 = cc.size(820, 400)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, 0)

	arg_2_0._isShowResourceUI = true
	arg_2_0._skinId = arg_2_1
	arg_2_0._info = Data._skinInfo[arg_2_1]
	arg_2_0._isAvatar = arg_2_1 >= 52000 and arg_2_1 < 53000
	arg_2_0._isCharacter = arg_2_1 >= 54000 and arg_2_1 < 55000
	arg_2_0._skinInfo = Data._skinInfo[arg_2_1]
	arg_2_0._monsterInfo = Data._monsterInfo[arg_2_0._skinInfo._infoId]
	arg_2_0._characterInfo = Data._characterInfo[arg_2_0._skinInfo._infoId]
	arg_2_0._prices = {
		arg_2_0._skinInfo._price3D,
		arg_2_0._skinInfo._price7D,
		arg_2_0._skinInfo._price
	}
	arg_2_0._propId = arg_2_0._info._resType

	if arg_2_0._isCharacter or arg_2_0._isAvatar then
		arg_2_0._propId = arg_2_0._skinInfo._resType
	end

	arg_2_0:initSkinArea()
	arg_2_0:initBuyArea()
	arg_2_0:updateBuyArea()
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	arg_3_0._listeners = {}

	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.prop_dirty, function()
		arg_3_0:updateBuyArea()
	end))
end

function var_0_0.onExit(arg_5_0)
	var_0_0.super.onExit(arg_5_0)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_5_1)
	end
end

function var_0_0.onCleanup(arg_6_0)
	var_0_0.super.onCleanup(arg_6_0)
end

function var_0_0.initSkinArea(arg_7_0)
	local var_7_0

	if arg_7_0._isAvatar then
		var_7_0 = ClientView.createAvatarSkinFrame(arg_7_0._skinId)
	elseif arg_7_0._isCharacter then
		var_7_0 = ClientView.createCharacterSkinFrame(arg_7_0._skinId, arg_7_0._skinInfo._infoId)
	else
		var_7_0 = ClientView.createSkinFrame(arg_7_0._skinId)
	end

	lc.addChildToPos(arg_7_0._frame, var_7_0, cc.p(160, lc.ch(arg_7_0._frame) - 10))

	arg_7_0._skinFrame = var_7_0
end

function var_0_0.initBuyArea(arg_8_0)
	arg_8_0._priceLabels = {}
	arg_8_0._btns = {}

	local var_8_0

	if arg_8_0._isAvatar then
		var_8_0 = {
			nil,
			nil,
			Str(STR.AVATAR_FOREVER)
		}
	elseif arg_8_0._isCharacter then
		var_8_0 = {
			nil,
			nil,
			Str(STR.SKIN_FOREVER)
		}
	else
		var_8_0 = {
			string.format(Str(STR.SKIN_DAY), 3),
			string.format(Str(STR.SKIN_DAY), 7),
			Str(STR.SKIN_FOREVER)
		}
	end

	local var_8_1 = (arg_8_0._isAvatar or arg_8_0._isCharacter) and 0 or math.floor(105)
	local var_8_2 = lc.y(arg_8_0._skinFrame) + var_8_1 + 25

	for iter_8_0 = 1, 3 do
		if var_8_0[iter_8_0] then
			local var_8_3 = lc.createSprite({
				_name = "img_com_bg_26",
				_crect = ClientView.CRECT_COM_BG26,
				_size = cc.size(280, 50)
			})

			lc.addChildToPos(arg_8_0._frame, var_8_3, cc.p(310 + lc.cw(var_8_3), var_8_2 - lc.ch(var_8_3)))

			local var_8_4 = ClientView.createTTF(var_8_0[iter_8_0], ClientView.FontSize.S1)

			lc.addChildToPos(var_8_3, var_8_4, cc.p(20 + lc.cw(var_8_4), lc.ch(var_8_3)))
			var_8_4:setColor(iter_8_0 == 3 and ClientView.COLOR_LABEL_LIGHT or ClientView.COLOR_TEXT_WHITE)

			local var_8_5 = ClientData.getIconName(arg_8_0._propId)
			local var_8_6 = ClientView.createResIconLabel(120, var_8_5)

			var_8_6._label:setString(arg_8_0._prices[iter_8_0])
			lc.addChildToPos(var_8_3, var_8_6, cc.p(lc.x(var_8_4) + 100 + lc.cw(var_8_6), lc.y(var_8_4)))

			arg_8_0._priceLabels[iter_8_0] = var_8_6._label

			local var_8_7 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_9_0)
				arg_8_0:onBtn(arg_9_0)
			end, ClientView.CRECT_BUTTON_S, 140)

			var_8_7._index = iter_8_0

			var_8_7:addLabel(Str(STR.BUY))
			var_8_7:setDisabledShader(ClientView.SHADER_DISABLE)
			lc.addChildToPos(arg_8_0._frame, var_8_7, cc.p(lc.right(var_8_3) + 20 + lc.cw(var_8_7), lc.y(var_8_3)))

			arg_8_0._btns[iter_8_0] = var_8_7
		end

		var_8_2 = var_8_2 - var_8_1
	end
end

function var_0_0.updateBuyArea(arg_10_0)
	local var_10_0 = P._playerCard:hasSkin(arg_10_0._skinId, true)
	local var_10_1 = P._playerCard:hasSkin(arg_10_0._skinId, false)

	for iter_10_0 = 1, #arg_10_0._btns do
		arg_10_0._btns[iter_10_0]._label:setString(var_10_0 and Str(STR.PURCHASED) or (not var_10_1 or iter_10_0 == 3) and Str(STR.BUY) or Str(STR.SKIN_IN_TRIAL))
		arg_10_0._btns[iter_10_0]:setEnabled(not var_10_0 and (not var_10_1 or iter_10_0 == 3))
		arg_10_0._priceLabels[iter_10_0]:setColor(P:getItemCount(arg_10_0._propId) >= arg_10_0._prices[iter_10_0] and lc.Color3B.white or lc.Color3B.red)
	end
end

function var_0_0.onBtn(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1._index
	local var_11_1 = {
		3,
		7,
		0
	}
	local var_11_2 = arg_11_0._propId

	if P:getItemCount(var_11_2) < arg_11_0._prices[var_11_0] then
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(var_11_2)))

		if var_11_2 == Data.PropsId.skin_crystal then
			require("ExchangeResForm").create(var_11_2):show()
		end

		return
	end

	if P._playerCard:buySkinId(arg_11_0._skinId, var_11_1[var_11_0]) then
		P:addResource(arg_11_0._propId, 1, -arg_11_0._prices[var_11_0])
		ClientData.sendBuySkin(arg_11_0._skinId, var_11_1[var_11_0])
		arg_11_0:updateBuyArea()

		local var_11_3 = Str(STR.BUY_SKIN_SUCCEED)

		require("Dialog").showDialog(var_11_3, function()
			if arg_11_0._isAvatar then
				if P:changeCharacter(arg_11_0._skinInfo._infoId) or P:getCharacterId() == arg_11_0._skinInfo._infoId then
					if ClientData._player:changeIcon(arg_11_0._skinId) then
						ClientData.sendSetAvatar(arg_11_0._skinId)
						ToastManager.push(Str(STR.SET_AVATAR_SKIN_SUCCEED))
					else
						ToastManager.push(Str(STR.SET_AVATAR_SKIN_FAILED))
					end
				else
					ToastManager.push(Str(STR.SET_AVATAR_SKIN_FAILED))
				end
			elseif arg_11_0._isCharacter then
				if P:changeCharacterSkin(arg_11_0._skinId) then
					ClientData.sendSetSkin(arg_11_0._skinInfo._infoId, arg_11_0._skinId)
					ToastManager.push(Str(STR.SET_SKIN_SUCCEED))
				else
					ToastManager.push(Str(STR.SET_SKIN_FAILED))
				end
			elseif P._playerCard:setSkinId(arg_11_0._skinInfo._infoId, arg_11_0._skinId) then
				ClientData.sendSetSkin(arg_11_0._skinInfo._infoId, arg_11_0._skinId)
				ToastManager.push(Str(STR.SET_SKIN_SUCCEED))
			else
				ToastManager.push(Str(STR.SET_SKIN_FAILED))
			end
		end)
	else
		ToastManager.push(Str(STR.BUY_SKIN_FAILED))
	end
end

return var_0_0
