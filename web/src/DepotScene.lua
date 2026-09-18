local var_0_0 = class("DepotScene", BaseUIScene)
local var_0_1 = "res/jpg/depot_bg.jpg"
local var_0_2 = cc.size(190, 190)
local var_0_3 = 30
local var_0_4 = 3
local var_0_5 = cc.size(240, 120)
local var_0_6 = require("CardInfoPanel")

function var_0_0.create(arg_1_0)
	return lc.createScene(var_0_0, arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.depot, STR.SID_FIXITY_NAME_1016, BaseUIScene.STYLE_TAB, true) then
		return false
	end

	local var_2_0 = ClientView.createFrameBox(cc.size(lc.w(arg_2_0) - 148 - ClientView.SCR_EDGE * 2, lc.bottom(arg_2_0._titleArea)))

	lc.addChildToPos(arg_2_0, var_2_0, cc.p(lc.w(var_2_0) / 2 + 148 + ClientView.SCR_EDGE, lc.h(var_2_0) / 2))

	arg_2_0._frame = var_2_0

	local var_2_1 = {
		Str(STR.MY) .. Str(STR.PROPS),
		Str(STR.ACTIVITY_PROP)
	}

	ClientView.addVerticalTabButtons(arg_2_0, var_2_1, lc.top(arg_2_0._frame) - 80, lc.left(arg_2_0._frame) - 124, 580)
	arg_2_0:createDepotArea()
	arg_2_0:createArtifactArea()

	arg_2_0._tabArea._focusTabIndex = arg_2_1

	arg_2_0:syncData()

	arg_2_0._listeners = {}

	table.insert(arg_2_0._listeners, lc.addEventListener(Data.Event.prop_dirty, function(arg_3_0)
		arg_2_0:onPropNumChanged(arg_3_0)
	end))

	return true
end

function var_0_0.syncData(arg_4_0)
	var_0_0.super.syncData(arg_4_0)
	arg_4_0:prepareData()
	arg_4_0:showTab(arg_4_0._tabArea._focusTabIndex or 1, true)
end

function var_0_0.createArea(arg_5_0)
	local var_5_0 = ccui.Layout:create()

	var_5_0:setContentSize(cc.size(lc.w(arg_5_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_5_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM))
	var_5_0:setAnchorPoint(0.5, 0.5)
	var_5_0:setClippingEnabled(true)
	lc.addChildToCenter(arg_5_0._frame, var_5_0, -1)

	return var_5_0
end

function var_0_0.createDepotArea(arg_6_0)
	arg_6_0._depotArea = arg_6_0:createArea()

	local var_6_0 = lc.List.createH(cc.size(lc.w(arg_6_0._depotArea), lc.h(arg_6_0._depotArea)), 20, var_0_3)

	lc.addChildToPos(arg_6_0._depotArea, var_6_0, cc.p(0, 0))

	arg_6_0._depotArea._list = var_6_0
end

function var_0_0.createArtifactArea(arg_7_0)
	arg_7_0._artifactArea = arg_7_0:createArea()

	local var_7_0 = lc.List.createH(cc.size(lc.w(arg_7_0._artifactArea), lc.h(arg_7_0._artifactArea)), 20, var_0_3)

	lc.addChildToPos(arg_7_0._artifactArea, var_7_0, cc.p(0, 0))

	arg_7_0._artifactArea._list = var_7_0
end

function var_0_0.prepareData(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(P._propBag._props) do
		if iter_8_1._info._type > 0 and iter_8_1._info._rank > 0 then
			if iter_8_1._info._type == Data.PropsType.artifact or iter_8_1._info._type == Data.PropsType.activity then
				var_8_1[#var_8_1 + 1] = iter_8_1
			else
				var_8_0[#var_8_0 + 1] = iter_8_1
			end
		end
	end

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		return arg_9_0._info._rank < arg_9_1._info._rank
	end)
	table.sort(var_8_1, function(arg_10_0, arg_10_1)
		return arg_10_0._info._id < arg_10_1._info._id
	end)

	arg_8_0._props = var_8_0
	arg_8_0._artifacts = var_8_1
end

function var_0_0.showTab(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._tabArea._focusTabIndex == arg_11_1 and not arg_11_2 then
		return
	end

	arg_11_0._tabArea:showTab(arg_11_1)

	if arg_11_1 == 1 then
		arg_11_0._depotArea:setVisible(true)
		arg_11_0._artifactArea:setVisible(false)
		arg_11_0:refreshItemList(0)
	elseif arg_11_1 == 2 then
		arg_11_0._depotArea:setVisible(false)
		arg_11_0._artifactArea:setVisible(true)
		arg_11_0:refreshItemList(Data.PropsType.artifact)
	end
end

function var_0_0.refreshItemList(arg_12_0, arg_12_1)
	local var_12_0 = lc.arrayToTable(arg_12_1 == 0 and arg_12_0._props or arg_12_0._artifacts, var_0_4, function(arg_13_0)
		return arg_13_0._num > 0
	end)
	local var_12_1 = (arg_12_1 == 0 and arg_12_0._depotArea or arg_12_0._artifactArea)._list

	var_12_1:bindData(var_12_0, function(arg_14_0, arg_14_1)
		arg_12_0:setOrCreateItem(arg_14_0, arg_14_1)
	end, math.min(8, #var_12_0))

	for iter_12_0 = 1, var_12_1._cacheCount do
		local var_12_2 = arg_12_0:setOrCreateItem(nil, var_12_0[iter_12_0])

		var_12_1:pushBackCustomItem(var_12_2)
	end

	var_12_1:jumpToTop()
	var_12_1:checkEmpty(string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.PROPS)))
end

function var_0_0.setOrCreateItem(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == nil then
		local var_15_0 = var_0_2.width
		local var_15_1 = (var_0_2.width + var_0_3) * var_0_4 - var_0_3

		arg_15_1 = ccui.Widget:create()

		arg_15_1:setContentSize(var_15_0, var_15_1)

		arg_15_1._pos = {}
		arg_15_1._props = {}

		local var_15_2 = var_15_0 / 2
		local var_15_3 = var_15_1 - var_0_2.height / 2

		for iter_15_0 = 1, var_0_4 do
			arg_15_1._pos[iter_15_0] = cc.p(var_15_2, var_15_3)
			var_15_3 = var_15_3 - var_0_2.height - var_0_3
		end
	end

	local var_15_4 = arg_15_1._props

	for iter_15_1 = 1, var_0_4 do
		local var_15_5 = var_15_4[iter_15_1]
		local var_15_6 = arg_15_2[iter_15_1]

		if iter_15_1 <= #arg_15_2 then
			if var_15_5 == nil then
				var_15_5 = arg_15_0:createPropItem(var_15_6)

				lc.addChildToPos(arg_15_1, var_15_5, arg_15_1._pos[iter_15_1])

				var_15_4[iter_15_1] = var_15_5
			else
				var_15_5._icon:resetData(var_15_6)
			end

			var_15_5:setVisible(true)
		elseif var_15_5 then
			var_15_5:setVisible(false)
		end
	end

	return arg_15_1
end

function var_0_0.createPropItem(arg_16_0, arg_16_1)
	local var_16_0 = lc.createImageView({
		_name = "img_com_bg_16",
		_crect = ClientView.CRECT_COM_BG16,
		_size = var_0_2
	})
	local var_16_1 = IconWidget.create(arg_16_1, IconWidget.DisplayFlag.ITEM)

	lc.addChildToCenter(var_16_0, var_16_1)
	var_16_1:setNameColor(lc.Color3B.white)

	var_16_0._icon = var_16_1

	return var_16_0
end

function var_0_0.onEnter(arg_17_0)
	var_0_0.super.onEnter(arg_17_0)
end

function var_0_0.onExit(arg_18_0)
	var_0_0.super.onExit(arg_18_0)
end

function var_0_0.onCleanup(arg_19_0)
	for iter_19_0 = 1, #arg_19_0._listeners do
		lc.Dispatcher:removeEventListener(arg_19_0._listeners[iter_19_0])
	end

	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename(var_0_1))
	var_0_0.super.onCleanup(arg_19_0)
end

function var_0_0.onMsg(arg_20_0, arg_20_1)
	if var_0_0.super.onMsg(arg_20_0, arg_20_1) then
		return true
	end

	local var_20_0 = arg_20_1.type
	local var_20_1 = arg_20_1.status

	if var_20_0 == SglMsgType_pb.PB_TYPE_USER_COLLECT_GOLD then
		local var_20_2 = arg_20_1.Extensions[User_pb.SglUserMsg.user_collect_gold_resp]
		local var_20_3 = var_20_2.gold
		local var_20_4 = var_20_2.credit

		arg_20_0:onGoldCollected(var_20_3, var_20_4)
	end
end

function var_0_0.onPropNumChanged(arg_21_0, arg_21_1)
	arg_21_0:refreshItemList(0)
end

return var_0_0
