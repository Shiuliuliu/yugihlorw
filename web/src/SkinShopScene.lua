local var_0_0 = require("BaseUIScene")
local var_0_1 = class("SkinShopScene", var_0_0)
local var_0_2 = require("FilterWidget")
local var_0_3 = require("CardInfoPanel")
local var_0_4 = 1
local var_0_5 = 2

function var_0_1.create()
	return lc.createScene(var_0_1)
end

function var_0_1.init(arg_2_0)
	if not var_0_1.super.init(arg_2_0, ClientData.SceneId.skin_shop, STR.SKIN_SHOP, var_0_0.STYLE_TAB, true) then
		return false
	end

	arg_2_0:createFrame()
	arg_2_0:createFilterWidget()
	arg_2_0:createSkinList()
	arg_2_0:createAvatarList()
	arg_2_0:createCharacterList()
	ClientView.addVerticalTabButtons(arg_2_0, {
		Str(STR.CHARACTER) .. Str(STR.SHOP),
		Str(STR.AVATAR) .. Str(STR.SHOP),
		Str(STR.SKIN) .. Str(STR.SHOP),
		Str(STR.EFFECT_STORE)
	}, lc.top(arg_2_0._frame) - 60, lc.left(arg_2_0._frame) - 124, 580)
	arg_2_0:syncData()
	arg_2_0:showTab(var_0_4)

	return true
end

function var_0_1.onEnter(arg_3_0)
	var_0_1.super.onEnter(arg_3_0)
	ClientView.getResourceUI():setMode(arg_3_0._tabArea._focusTabIndex == 1 and Data.PropsId.avatar_skin_crystal or Data.PropsId.skin_crystal)

	arg_3_0._listeners = {}

	table.insert(arg_3_0._listeners, lc.addEventListener(Data.Event.skin_dirty, function()
		arg_3_0._skinList:updatePage(false)
		arg_3_0._avatarList:updatePage(false)
		arg_3_0._characterList:updatePage(false)
	end))
end

function var_0_1.onExit(arg_5_0)
	var_0_1.super.onExit(arg_5_0)
	ClientView.getResourceUI():setMode(Data.ResType.gold)

	for iter_5_0 = 1, #arg_5_0._listeners do
		lc.Dispatcher:removeEventListener(arg_5_0._listeners[iter_5_0])
	end
end

function var_0_1.onCleanup(arg_6_0)
	var_0_1.super.onCleanup(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(Data._skinInfo) do
		if iter_6_1._effect ~= 0 then
			ClientData.unloadDragonBones(iter_6_1._effect)
		end
	end
end

function var_0_1.syncData(arg_7_0)
	var_0_1.super.syncData(arg_7_0)
	arg_7_0._skinList:updatePage()
	arg_7_0._avatarList:updatePage()
end

function var_0_1.createFrame(arg_8_0)
	local var_8_0 = ClientView.createFrameBox(cc.size(lc.w(arg_8_0) - (16 + ClientView.FRAME_TAB_WIDTH + ClientView.SCR_EDGE) * 2, lc.h(arg_8_0) - lc.h(arg_8_0._titleArea)))

	lc.addChildToPos(arg_8_0, var_8_0, cc.p(lc.w(arg_8_0) / 2, lc.bottom(arg_8_0._titleArea) - lc.h(var_8_0) / 2 + 10))

	arg_8_0._frame = var_8_0
end

function var_0_1.createFilterWidget(arg_9_0)
	local var_9_0 = var_0_2.create(var_0_2.ModeType.skin, lc.h(arg_9_0._frame) - 80)

	var_9_0:resetAllFilter()
	var_9_0:registerSortFilterHandler(function()
		arg_9_0:updateSkinList()
	end)
	lc.addChildToPos(arg_9_0._frame, var_9_0, cc.p(lc.w(arg_9_0._frame) + ClientView.FRAME_TAB_WIDTH - lc.w(var_9_0) / 2 + 2, lc.h(var_9_0) / 2))

	arg_9_0._filterWidget = var_9_0
end

function var_0_1.createSkinList(arg_11_0)
	arg_11_0._skinList = require("ItemList").create(cc.size(lc.w(arg_11_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 90, lc.h(arg_11_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), cc.size(256, 312), Str(STR.LIST_EMPTY_NO_SKIN), function()
		return arg_11_0:createSkinItem()
	end, function(arg_13_0, arg_13_1)
		return arg_11_0:updateSkinItem(arg_13_0, arg_13_1)
	end, 2, 5)

	arg_11_0._skinList:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_11_0._frame, arg_11_0._skinList, cc.p(lc.w(arg_11_0._frame) / 2, lc.h(arg_11_0._frame) / 2))

	local var_11_0 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_11_0._frame, var_11_0, cc.p(-lc.w(var_11_0) / 2 + 12, 48), -1)
	arg_11_0._skinList._pageLabel:setPosition(-120, 20)
	arg_11_0._skinList:setData(arg_11_0:getSkinData())
end

function var_0_1.createAvatarList(arg_14_0)
	arg_14_0._avatarList = require("ItemList").create(cc.size(lc.w(arg_14_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 90, lc.h(arg_14_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), cc.size(256, 200), Str(STR.LIST_EMPTY_NO_SKIN), function()
		return arg_14_0:createAvatarItem()
	end, function(arg_16_0, arg_16_1)
		return arg_14_0:updateAvatarItem(arg_16_0, arg_16_1)
	end, 3, 5)

	arg_14_0._avatarList:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_14_0._frame, arg_14_0._avatarList, cc.p(lc.w(arg_14_0._frame) / 2, lc.h(arg_14_0._frame) / 2))

	local var_14_0 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_14_0._frame, var_14_0, cc.p(-lc.w(var_14_0) / 2 + 12, 48), -1)
	arg_14_0._avatarList._pageLabel:setPosition(-120, 20)
	arg_14_0._avatarList:setData(arg_14_0:getAvatarData())
end

function var_0_1.createCharacterList(arg_17_0)
	arg_17_0._characterList = require("ItemList").create(cc.size(lc.w(arg_17_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 90, lc.h(arg_17_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), cc.size(256, 312), Str(STR.LIST_EMPTY_NO_SKIN), function()
		return arg_17_0:createCharacterItem()
	end, function(arg_19_0, arg_19_1)
		return arg_17_0:updateCharacterItem(arg_19_0, arg_19_1)
	end, 2, 5)

	arg_17_0._characterList:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_17_0._frame, arg_17_0._characterList, cc.p(lc.w(arg_17_0._frame) / 2, lc.h(arg_17_0._frame) / 2))

	local var_17_0 = lc.createSprite("img_page_bg")

	lc.addChildToPos(arg_17_0._frame, var_17_0, cc.p(-lc.w(var_17_0) / 2 + 12, 48), -1)
	arg_17_0._characterList._pageLabel:setPosition(-120, 20)
	arg_17_0._characterList:setData(arg_17_0:getCharacterData())
end

function var_0_1.updateSkinList(arg_20_0)
	arg_20_0._skinList:setData(arg_20_0:getSkinData())
	arg_20_0._skinList:updatePage(true)
end

function var_0_1.createSkinItem(arg_21_0)
	local var_21_0 = ccui.Layout:create()

	var_21_0:setTouchEnabled(true)
	var_21_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_21_0:setAnchorPoint(0.5, 0.5)

	local var_21_1 = ClientView.createSkinFrame(50002)

	var_21_0:setContentSize(lc.w(var_21_1), lc.h(var_21_1) + 60)

	var_21_0._skinFrame = var_21_1

	local var_21_2 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_22_0)
		arg_21_0:onBtn(arg_22_0)
	end, ClientView.CRECT_BUTTON_S, lc.w(var_21_1))

	var_21_2:addLabel(Str(STR.BUY))
	var_21_2:setTouchRect(cc.rect(0, 0, lc.w(var_21_0), lc.h(var_21_0)))
	lc.addChildToPos(var_21_0, var_21_2, cc.p(lc.cw(var_21_1), lc.ch(var_21_2)))

	var_21_0._btn = var_21_2

	lc.addChildToPos(var_21_2, var_21_1, cc.p(lc.cw(var_21_1), lc.h(var_21_2) + lc.ch(var_21_1)))

	return var_21_0
end

function var_0_1.updateSkinItem(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_2 == nil then
		arg_23_1:setVisible(false)

		return
	end

	local var_23_0 = arg_23_2._infoId
	local var_23_1 = arg_23_2._id
	local var_23_2 = Data.getInfo(var_23_0)
	local var_23_3 = P._playerCard:getCardCount(var_23_0) > 0
	local var_23_4 = P._playerCard:hasSkin(var_23_1, true)
	local var_23_5 = arg_23_1._btn:getContentSize()

	arg_23_1:setVisible(true)
	arg_23_1._skinFrame:updateSkin(var_23_1, var_23_0)
	arg_23_1._skinFrame._nameLabel:setString(Str(arg_23_2._nameSid))
	arg_23_1._skinFrame._monsterNameLabel:setString(Str(var_23_2._nameSid))
	arg_23_1._skinFrame._monsterNameLabel:setScale(math.min(0.8, 230 / lc.w(arg_23_1._skinFrame._monsterNameLabel)))

	arg_23_1._btn._skinId = var_23_1

	arg_23_1._btn:loadTextureNormal(var_23_4 and "img_btn_2_s" or "img_btn_1_s", ccui.TextureResType.plistType)
	arg_23_1._btn:setContentSize(var_23_5)
	arg_23_1._btn._label:setString(var_23_3 and (var_23_4 and Str(STR.PURCHASED) or Str(STR.BUY)) or Str(STR.SKIN_NEED_CARD))

	if var_23_3 then
		arg_23_1._btn:setDisabledShader(nil)
	else
		arg_23_1._btn:setDisabledShader(ClientView.SHADER_DISABLE)
	end

	arg_23_1._btn:setEnabled(var_23_3 and not var_23_4)
end

function var_0_1.getSkinData(arg_24_0)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(Data._skinInfo) do
		if (iter_24_1._infoId ~= 10407 or not (P._vip < 12) or iter_24_1._id == 50084) and (iter_24_1._infoId ~= 10446 or not (P._vip < 13)) and iter_24_1._id < 52000 then
			var_24_0[#var_24_0 + 1] = iter_24_1
		end
	end

	table.sort(var_24_0, function(arg_25_0, arg_25_1)
		return arg_25_0._id > arg_25_1._id
	end)

	local var_24_1, var_24_2 = arg_24_0._filterWidget:getFilterQualityFunc()
	local var_24_3, var_24_4 = arg_24_0._filterWidget:getFilterLevelFunc()
	local var_24_5, var_24_6 = arg_24_0._filterWidget:getFilterNatureFunc()
	local var_24_7, var_24_8 = arg_24_0._filterWidget:getFilterCategoryFunc()
	local var_24_9, var_24_10 = arg_24_0._filterWidget:getFilterSearchFunc()

	return (arg_24_0:filterSkinData(var_24_0, var_24_2, var_24_4, var_24_6, var_24_8, var_24_10))
end

function var_0_1.filterSkinData(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
	local var_26_0 = {}

	for iter_26_0 = 1, #arg_26_1 do
		local var_26_1 = arg_26_1[iter_26_0]
		local var_26_2 = var_26_1._infoId
		local var_26_3 = Data.getInfo(var_26_2)
		local var_26_4 = true

		if arg_26_2 ~= nil and var_26_3._quality ~= arg_26_2 then
			var_26_4 = false
		end

		if arg_26_3 ~= nil and var_26_3._cost ~= arg_26_3 then
			var_26_4 = false
		end

		if arg_26_4 ~= nil and var_26_3._nature ~= arg_26_4 then
			var_26_4 = false
		end

		if arg_26_5 ~= nil and var_26_3._category ~= arg_26_5 then
			var_26_4 = false
		end

		if arg_26_6 ~= nil and arg_26_6 ~= "" then
			local var_26_5 = string.find(Str(var_26_1._nameSid) .. Str(var_26_3._nameSid), arg_26_6)

			if var_26_5 == nil or var_26_5 == 0 then
				var_26_4 = false
			end
		end

		if var_26_4 then
			var_26_0[#var_26_0 + 1] = var_26_1
		end
	end

	return var_26_0
end

function var_0_1.updateAvatarList(arg_27_0)
	arg_27_0._avatarList:setData(arg_27_0:getAvatarData())
	arg_27_0._avatarList:updatePage(true)
end

function var_0_1.createAvatarItem(arg_28_0)
	local var_28_0 = ccui.Layout:create()

	var_28_0:setTouchEnabled(true)
	var_28_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_28_0:setAnchorPoint(0.5, 0.5)

	local var_28_1 = ClientView.createAvatarSkinFrame(52002)

	var_28_0:setContentSize(lc.w(var_28_1), lc.h(var_28_1) + 60)

	var_28_0._avatarFrame = var_28_1

	local var_28_2 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_29_0)
		arg_28_0:onBtn(arg_29_0)
	end, ClientView.CRECT_BUTTON_S, lc.w(var_28_1))

	var_28_2:addLabel(Str(STR.BUY))
	var_28_2:setDisabledShader(ClientView.SHADER_DISABLE)
	var_28_2:setTouchRect(cc.rect(0, 0, lc.w(var_28_0), lc.h(var_28_0)))
	lc.addChildToPos(var_28_0, var_28_2, cc.p(lc.cw(var_28_1), lc.ch(var_28_2)))

	var_28_0._btn = var_28_2

	lc.addChildToPos(var_28_2, var_28_1, cc.p(lc.cw(var_28_1), lc.h(var_28_2) + lc.ch(var_28_1)))

	return var_28_0
end

function var_0_1.updateAvatarItem(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_2 == nil then
		arg_30_1:setVisible(false)

		return
	end

	local var_30_0 = arg_30_2._infoId
	local var_30_1 = arg_30_2._id
	local var_30_2 = Data.getInfo(var_30_0)
	local var_30_3 = P._characters[var_30_0]._level > 0
	local var_30_4 = P._playerCard:hasSkin(var_30_1, true)
	local var_30_5 = arg_30_1._btn:getContentSize()

	arg_30_1:setVisible(true)
	arg_30_1._avatarFrame:updateSkin(var_30_1, var_30_0)

	arg_30_1._btn._skinId = var_30_1

	arg_30_1._btn:loadTextureNormal(var_30_4 and "img_btn_2_s" or "img_btn_1_s", ccui.TextureResType.plistType)
	arg_30_1._btn:setContentSize(var_30_5)
	arg_30_1._btn._label:setString(var_30_3 and (var_30_4 and Str(STR.PURCHASED) or Str(STR.BUY)) or Str(STR.LOCKED))

	if var_30_3 then
		arg_30_1._btn:setDisabledShader(nil)
	else
		arg_30_1._btn:setDisabledShader(ClientView.SHADER_DISABLE)
	end

	arg_30_1._btn:setEnabled(var_30_3 and not var_30_4)
end

function var_0_1.getAvatarData(arg_31_0)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(Data._skinInfo) do
		if iter_31_1._id > 52000 and iter_31_1._id < 53000 then
			var_31_0[#var_31_0 + 1] = iter_31_1
		end
	end

	table.sort(var_31_0, function(arg_32_0, arg_32_1)
		return arg_32_0._id > arg_32_1._id
	end)

	return var_31_0
end

function var_0_1.createCharacterItem(arg_33_0)
	local var_33_0 = ccui.Layout:create()

	var_33_0:setTouchEnabled(true)
	var_33_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_33_0:setAnchorPoint(0.5, 0.5)

	local var_33_1 = ClientView.createCharacterSkinFrame(54001)

	var_33_0:setContentSize(lc.w(var_33_1), lc.h(var_33_1) + 60)

	var_33_0._characterFrame = var_33_1

	local var_33_2 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_34_0)
		arg_33_0:onBtn(arg_34_0)
	end, ClientView.CRECT_BUTTON_S, lc.w(var_33_1))

	var_33_2:addLabel(Str(STR.BUY))
	var_33_2:setDisabledShader(ClientView.SHADER_DISABLE)
	var_33_2:setTouchRect(cc.rect(0, 0, lc.w(var_33_0), lc.h(var_33_0)))
	lc.addChildToPos(var_33_0, var_33_2, cc.p(lc.cw(var_33_1), lc.ch(var_33_2)))

	var_33_0._btn = var_33_2

	lc.addChildToPos(var_33_2, var_33_1, cc.p(lc.cw(var_33_1), lc.h(var_33_2) + lc.ch(var_33_1)))

	return var_33_0
end

function var_0_1.updateCharacterItem(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_2 == nil then
		arg_35_1:setVisible(false)

		return
	end

	local var_35_0 = arg_35_2._infoId
	local var_35_1 = arg_35_2._id
	local var_35_2 = Data._characterInfo[var_35_0]
	local var_35_3 = P._characters[var_35_0]
	local var_35_4 = var_35_3._level > 0
	local var_35_5 = P._playerCard:hasSkin(var_35_1, false)
	local var_35_6 = P._playerCard:hasSkin(var_35_1, true)
	local var_35_7 = var_35_3._skinId == var_35_1
	local var_35_8 = arg_35_1._btn:getContentSize()

	arg_35_1:setVisible(true)
	arg_35_1._characterFrame:updateSkin(var_35_1, var_35_0)

	arg_35_1._btn._skinId = var_35_1

	arg_35_1._btn:loadTextureNormal(var_35_5 and "img_btn_2_s" or "img_btn_1_s", ccui.TextureResType.plistType)
	arg_35_1._btn:setContentSize(var_35_8)

	if var_35_7 then
		arg_35_1._btn._label:setString(Str(STR.RESET))
		arg_35_1._btn:setEnabled(true)

		function arg_35_1._btn._callback()
			P:resetCharacterSkin(var_35_0)
			ClientData.sendSetSkin(var_35_0, 0)
		end
	elseif var_35_5 or var_35_6 then
		arg_35_1._btn._label:setString(Str(STR.USE))
		arg_35_1._btn:setEnabled(true)

		function arg_35_1._btn._callback()
			if P:changeCharacterSkin(var_35_1) then
				ClientData.sendSetSkin(var_35_0, var_35_1)
				ToastManager.push(Str(STR.SET_SKIN_SUCCEED))
			end
		end
	else
		function arg_35_1._btn._callback()
			arg_35_0:onBtn(arg_35_1._btn)
		end

		arg_35_1._btn._label:setString(var_35_4 and Str(STR.BUY) or Str(STR.LOCKED))
		arg_35_1._btn:setDisabledShader(ClientView.SHADER_DISABLE)
		arg_35_1._btn:setEnabled(var_35_4)
	end
end

function var_0_1.getCharacterData(arg_39_0)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(Data._skinInfo) do
		if iter_39_1._id > 54000 and iter_39_1._id < 55000 then
			var_39_0[#var_39_0 + 1] = iter_39_1
		end
	end

	table.sort(var_39_0, function(arg_40_0, arg_40_1)
		return arg_40_0._id > arg_40_1._id
	end)

	return var_39_0
end

function var_0_1.filterAvatarData(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5, arg_41_6)
	return
end

function var_0_1.onBtn(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1._skinId
	local var_42_1 = Data._skinInfo[var_42_0]._infoId

	require("SkinBuyForm").create(var_42_0):show()
end

function var_0_1.showTab(arg_43_0, arg_43_1)
	arg_43_0._skinList:setVisible(false)
	arg_43_0._avatarList:setVisible(false)
	arg_43_0._filterWidget:setVisible(false)
	arg_43_0._characterList:setVisible(false)

	if arg_43_1 == 4 then
		lc.pushScene(require("EffectScene").create())
		arg_43_0:showTab(arg_43_0._tabArea._focusTabIndex)
	elseif arg_43_1 == 3 then
		arg_43_0._tabArea:showTab(arg_43_1)
		arg_43_0._skinList:setVisible(true)
		arg_43_0._filterWidget:setVisible(true)
		ClientView.getResourceUI():setMode(Data.PropsId.skin_crystal)
	elseif arg_43_1 == 2 then
		arg_43_0._tabArea:showTab(arg_43_1)
		arg_43_0._avatarList:setVisible(true)
		ClientView.getResourceUI():setMode(Data.PropsId.avatar_skin_crystal)
	elseif arg_43_1 == 1 then
		arg_43_0._tabArea:showTab(arg_43_1)
		arg_43_0._characterList:setVisible(true)
		ClientView.getResourceUI():setMode(Data.ResType.gold)
	end
end

return var_0_1
