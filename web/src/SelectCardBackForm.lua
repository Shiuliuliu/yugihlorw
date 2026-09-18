local var_0_0 = class("SelectCardBackForm", BaseForm)
local var_0_1 = cc.size(1000, 640)
local var_0_2 = 6

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.CHANGE_CARD_BACK), 0)

	local var_2_0 = lc.List.createH(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 30, 20)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0._frame, var_2_0)

	arg_2_0._list = var_2_0

	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(Data._propsInfo) do
		if iter_2_1._type == Data.PropsType.card_back and (iter_2_0 == Data.PropsId.card_back or P:getItemCount(iter_2_0) > 0) then
			table.insert(var_2_1, iter_2_1)
		end
	end

	table.sort(var_2_1, function(arg_3_0, arg_3_1)
		return arg_3_0._id < arg_3_1._id
	end)

	arg_2_0._cardBacks = var_2_1

	arg_2_0:updateAvatarList()
end

function var_0_0.updateAvatarList(arg_4_0)
	local var_4_0 = arg_4_0._list
	local var_4_1 = arg_4_0._cardBacks

	var_4_0:bindData(var_4_1, function(arg_5_0, arg_5_1)
		arg_4_0:setOrCreateItem(arg_5_0, arg_5_1)
	end, math.min(5, #var_4_1))

	for iter_4_0 = 1, var_4_0._cacheCount do
		local var_4_2 = var_4_1[iter_4_0]
		local var_4_3 = arg_4_0:setOrCreateItem(nil, var_4_2)

		var_4_0:pushBackCustomItem(var_4_3)
	end

	var_4_0:jumpToTop()
end

function var_0_0.setOrCreateItem(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == nil then
		local var_6_0 = ClientView.createShaderButton(ClientView.getCardBackName())

		var_6_0:setPressedShader(nil)

		local var_6_1 = ClientView.createTTF("0", ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)
		local var_6_2 = ClientView.createScale9ShaderButton("img_btn_1", nil, ClientView.CRECT_BUTTON, 160)

		var_6_2:addLabel(Str(STR.SELECT))

		local var_6_3 = lc.w(var_6_0)
		local var_6_4 = lc.h(var_6_0) + 10 + lc.h(var_6_1) + 14 + lc.h(var_6_2)

		arg_6_1 = ccui.Widget:create()

		arg_6_1:setContentSize(var_6_3, var_6_4)
		lc.addChildToPos(arg_6_1, var_6_0, cc.p(var_6_3 / 2, var_6_4 - lc.h(var_6_0) / 2))
		lc.addChildToPos(arg_6_1, var_6_1, cc.p(var_6_3 / 2, lc.bottom(var_6_0) - 10 - lc.h(var_6_1) / 2))
		lc.addChildToPos(arg_6_1, var_6_2, cc.p(var_6_3 / 2, lc.h(var_6_2) / 2))

		arg_6_1._back = var_6_0
		arg_6_1._name = var_6_1
		arg_6_1._btnSelect = var_6_2
	end

	arg_6_1._back:removeAllChildren()

	if ClientData._player._cardBackId == arg_6_2._id then
		local var_6_5 = lc.createSprite("img_cur")

		lc.addChildToCenter(arg_6_1._back, var_6_5)
	elseif ClientData._player:getItemCount(arg_6_2._id) <= 0 then
		ClientView.addLockChains(arg_6_1._back, 1)
	end

	arg_6_1._back:loadTextureNormal(ClientView.getCardBackName(arg_6_2._id), ccui.TextureResType.plistType)

	function arg_6_1._back._callback()
		require("DescForm").create({
			_infoId = arg_6_2._id
		}):show()
	end

	arg_6_1._name:setString(arg_6_2._nameSid and Str(arg_6_2._nameSid) or Str(STR.DEFAULT) .. Str(STR.CARD_BACK))

	function arg_6_1._btnSelect._callback()
		if ClientData._player:getItemCount(arg_6_2._id) <= 0 then
			ToastManager.push(Str(STR.CARD_BACK_LOCKED))
		elseif ClientData._player._cardBackId == arg_6_2._id then
			arg_6_0:hide()
		else
			ClientData.sendSetCardBack(arg_6_2._id)

			ClientData._player._cardBackId = arg_6_2._id

			ToastManager.push(Str(STR.SELECT_CARD_BACK_SUCCESS))
			arg_6_0:hide()
		end
	end

	return arg_6_1
end

return var_0_0
