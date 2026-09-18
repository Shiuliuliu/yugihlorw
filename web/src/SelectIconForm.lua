local var_0_0 = class("SelectIconForm", BaseForm)
local var_0_1 = cc.size(740, 640)
local var_0_2 = 5
local var_0_3 = 80

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.SELECT) .. Str(STR.PROPS), 0)

	arg_2_0._func = arg_2_1
	arg_2_0._selectedInfoId = arg_2_2

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - var_0_3), 32, 20)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0._frame, var_2_0, cc.p(lc.w(arg_2_0._frame) / 2, lc.h(arg_2_0._frame) / 2 + var_0_3 / 2))

	arg_2_0._list = var_2_0
	arg_2_0._infoIds = {}

	for iter_2_0, iter_2_1 in pairs(Data._propsInfo) do
		if iter_2_0 >= 7300 and iter_2_0 < 7400 then
			arg_2_0._infoIds[#arg_2_0._infoIds + 1] = iter_2_0
		end
	end

	table.sort(arg_2_0._infoIds, function(arg_3_0, arg_3_1)
		return arg_3_0 < arg_3_1
	end)
	arg_2_0:createBottomArea()
	arg_2_0:createIconList()
end

function var_0_0.createBottomArea(arg_4_0)
	local var_4_0 = ClientView.createLineSprite("img_bottom_bg", lc.w(arg_4_0._list))

	var_4_0:setAnchorPoint(0.5, 0)
	lc.addChildToPos(arg_4_0._frame, var_4_0, cc.p(lc.w(arg_4_0._frame) / 2, ClientView.FRAME_INNER_BOTTOM - 12), -1)

	arg_4_0._bottomArea = var_4_0

	local var_4_1 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		if arg_4_0._func then
			arg_4_0._func(arg_4_0._curBtn and arg_4_0._curBtn._infoId or nil)
		end

		arg_4_0:hide()
	end, ClientView.CRECT_BUTTON, 100, ClientView.CRECT_BUTTON_S.height)

	var_4_1:addLabel(Str(STR.OK))
	lc.addChildToPos(arg_4_0._bottomArea, var_4_1, cc.p(lc.w(arg_4_0._bottomArea) - lc.w(var_4_1) / 2 - 20, lc.h(arg_4_0._bottomArea) / 2))

	arg_4_0._btnConfirm = var_4_1
end

function var_0_0.createIconList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}

	local function var_6_2(arg_7_0)
		table.insert(var_6_1, arg_7_0)

		if #var_6_1 == var_0_2 then
			table.insert(var_6_0, var_6_1)

			var_6_1 = {}
		end
	end

	for iter_6_0 = 1, #arg_6_0._infoIds do
		local var_6_3 = arg_6_0._infoIds[iter_6_0]
		local var_6_4 = Data.getInfo(var_6_3)

		var_6_2(var_6_4)
	end

	local var_6_5 = arg_6_0._list

	var_6_5:bindData(var_6_0, function(arg_8_0, arg_8_1)
		arg_6_0:setOrCreateItem(arg_8_0, arg_8_1)
	end, math.min(8, #var_6_0), 1)

	for iter_6_1 = 1, var_6_5._cacheCount do
		local var_6_6 = var_6_0[iter_6_1]
		local var_6_7 = arg_6_0:setOrCreateItem(nil, var_6_6)

		var_6_5:pushBackCustomItem(var_6_7)
	end

	var_6_5:jumpToTop()
end

function var_0_0.setOrCreateItem(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == nil then
		arg_9_1 = ccui.Widget:create()
	end

	arg_9_1:removeAllChildren()

	local var_9_0 = 100
	local var_9_1 = 26
	local var_9_2 = (var_9_0 + var_9_1) * var_0_2 - var_9_1

	arg_9_1:setContentSize(var_9_2, 180)

	local var_9_3 = cc.p(var_9_0 / 2, lc.h(arg_9_1) / 2)

	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		local var_9_4 = IconWidget.create({
			_infoId = iter_9_1._id,
			_count = P._propBag._props[iter_9_1._id]._num
		}, IconWidget.DisplayFlag.ITEM)

		var_9_4._name:setColor(lc.Color3B.white)
		lc.addChildToPos(arg_9_1, var_9_4, var_9_3)

		var_9_3.x = var_9_3.x + lc.w(var_9_4) + var_9_1

		local var_9_5 = ccui.ShaderButton:create("img_btn_check_bg", ccui.TextureResType.plistType)

		var_9_5:setTouchRect(cc.rect(-10, -10, lc.w(var_9_5) + 20, lc.h(var_9_5) + 20))
		var_9_5:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

		var_9_5._infoId = iter_9_1._id

		lc.addChildToPos(var_9_4, var_9_5, cc.p(lc.w(var_9_4) / 2, -30))
		var_9_5:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 == ccui.TouchEventType.ended then
				lc.Audio.playAudio(AUDIO.E_BUTTON_DEFAULT)
				arg_9_0:selectBtn(arg_10_0)
			end
		end)

		if iter_9_1._id == arg_9_0._selectedInfoId then
			arg_9_0:selectBtn(var_9_5)
		end
	end

	return arg_9_1
end

function var_0_0.selectBtn(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1._infoId

	if not P._propBag._props[var_11_0] or P._propBag._props[var_11_0]._num <= 0 then
		return
	end

	if arg_11_0._curBtn ~= nil then
		arg_11_0._curBtn:removeAllChildren()
	end

	if arg_11_0._curBtn == arg_11_1 then
		arg_11_0._curBtn = nil
	else
		arg_11_0._curBtn = arg_11_1

		local var_11_1 = lc.createSprite("img_icon_check")

		lc.addChildToCenter(arg_11_1, var_11_1)
	end
end

return var_0_0
