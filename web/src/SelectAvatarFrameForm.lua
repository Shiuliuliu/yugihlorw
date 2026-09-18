local var_0_0 = class("SelectAvatarFrameForm", BaseForm)
local var_0_1 = cc.size(720, 640)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.CHANGE_RECT), 0)

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 20, 20)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0._frame, var_2_0)

	arg_2_0._list = var_2_0

	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(Data._propsInfo) do
		if Data.isAvatarFrame(iter_2_0) and iter_2_0 ~= Data.PropsId.avatar_frame_level_rank1 and iter_2_0 ~= Data.PropsId.avatar_frame_level_rank2 and iter_2_0 ~= Data.PropsId.avatar_frame_level_rank3 and iter_2_0 ~= Data.PropsId.avatar_frame_xmas_1 and iter_2_0 ~= Data.PropsId.avatar_frame_xmas_2 then
			local var_2_2, var_2_3 = P._propBag:validPropId(iter_2_0, true)

			if var_2_3 == Data.PropsId.avatar_frame or P:getItemCount(var_2_3) > 0 then
				table.insert(var_2_1, iter_2_1)
			end
		end
	end

	table.sort(var_2_1, function(arg_3_0, arg_3_1)
		return arg_3_0._id < arg_3_1._id
	end)

	arg_2_0._frames = var_2_1

	arg_2_0:updateFrameList()
end

function var_0_0.updateFrameList(arg_4_0)
	local var_4_0 = arg_4_0._list
	local var_4_1 = arg_4_0._frames

	var_4_0:bindData(var_4_1, function(arg_5_0, arg_5_1)
		arg_4_0:setOrCreateItem(arg_5_0, arg_5_1)
	end, math.min(6, #var_4_1))

	for iter_4_0 = 1, var_4_0._cacheCount do
		local var_4_2 = var_4_1[iter_4_0]
		local var_4_3 = arg_4_0:setOrCreateItem(nil, var_4_2)

		var_4_0:pushBackCustomItem(var_4_3)
	end

	var_4_0:jumpToTop()
end

function var_0_0.setOrCreateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = UserWidget.FRAME_SIZE

	if arg_6_1 == nil then
		local var_6_1 = ClientView.createShaderButton("avatar_frame_001")

		var_6_1:setPressedShader(nil)

		local var_6_2 = ClientView.createTTF("0", ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)

		var_6_2:setAnchorPoint(0, 0.5)

		local var_6_3 = ClientView.createScale9ShaderButton("img_btn_1", nil, ClientView.CRECT_BUTTON, 150)

		var_6_3:addLabel(Str(STR.SELECT))

		local var_6_4 = lc.w(arg_6_0._list)
		local var_6_5 = var_6_0

		arg_6_1 = ccui.Widget:create()

		arg_6_1:setContentSize(var_6_4, var_6_5)
		lc.addChildToPos(arg_6_1, var_6_1, cc.p(100, var_6_5 / 2))
		lc.addChildToPos(arg_6_1, var_6_2, cc.p(lc.right(var_6_1) + 20, var_6_5 / 2))
		lc.addChildToPos(arg_6_1, var_6_3, cc.p(lc.w(arg_6_1) - 120, var_6_5 / 2))

		arg_6_1._frame = var_6_1
		arg_6_1._name = var_6_2
		arg_6_1._btnSelect = var_6_3
	end

	arg_6_1._frame:removeAllChildren()
	print("+++++++++++++++++++", arg_6_2._id)
	arg_6_1._frame:loadTextureNormal(ClientData.getAvatarFrameName(arg_6_2._id), ccui.TextureResType.plistType)

	function arg_6_1._frame._callback()
		require("DescForm").create({
			_infoId = arg_6_2._id
		}):show()
	end

	local var_6_6, var_6_7 = P._propBag:validPropId(arg_6_2._id, true)

	arg_6_1._name:setString(arg_6_2._nameSid and Str(arg_6_2._nameSid) or Str(STR.AVATAR_FRAME_DEF))

	function arg_6_1._btnSelect._callback()
		if P:changeAvatarFrame(var_6_7) then
			ClientData.sendSetAvatarFrame(var_6_7)
		end

		arg_6_0:hide()
	end

	return arg_6_1
end

return var_0_0
