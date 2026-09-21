local var_0_0 = class("LordForm", BaseForm)
local var_0_1 = cc.size(862, 642)
local var_0_2 = var_0_0.LEFT_MARGIN + 40
local var_0_3 = var_0_0.TOP_MARGIN + 40
local var_0_4 = 170
local var_0_5 = 100

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = UserWidget.create(P, UserWidget.Flag.NAME_UNION_VIP)

	var_2_0._unionArea._name:setColor(ClientView.COLOR_TEXT_ORANGE)
	lc.addChildToPos(arg_2_0._form, var_2_0, cc.p(var_0_2 + lc.w(var_2_0) / 2 + 10, lc.h(arg_2_0._form) - var_0_3 - lc.h(var_2_0) / 2))

	arg_2_0._userAvatar = var_2_0

	local var_2_1 = lc.createSprite("img_icon_id")

	lc.addChildToPos(arg_2_0._form, var_2_1, cc.p(lc.right(var_2_0) + 60, lc.y(var_2_0) + 18))

	local var_2_2 = ClientView.createTTF(ClientData.convertId(P._id), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)

	lc.addChildToPos(arg_2_0._form, var_2_2, cc.p(lc.right(var_2_1) + 6 + lc.w(var_2_2) / 2, lc.y(var_2_1) + 2))
	arg_2_0:updateLevelExpBar()

	local var_2_3 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_3_0)
		arg_2_0:onChangeCharacter()
	end, ClientView.CRECT_BUTTON_S, var_0_4)

	var_2_3:addLabel(Str(STR.CHANGE_CHARACTER))
	lc.addChildToPos(arg_2_0._form, var_2_3, cc.p(lc.w(arg_2_0._form) - var_0_2 - lc.w(var_2_3) / 2, lc.y(arg_2_0._levelExpBar)))
	var_2_3:setVisible(true)

	local var_2_4 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_4_0)
		arg_2_0:onChangeName()
	end, ClientView.CRECT_BUTTON_S, 150, 44)

	var_2_4:addLabel("Sửa đổi biệt hiệu")
	var_2_4:setVisible(true)
	
	local var_btn_avatar = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_2_0:onChangeAvatar()
	end, ClientView.CRECT_BUTTON_S, 150, 44)
	var_btn_avatar:addLabel(Str(STR.CHANGE_ICON) or "Đổi Avatar")
	lc.addChildToPos(arg_2_0._form, var_btn_avatar, cc.p(lc.left(arg_2_0._userAvatar) + lc.w(var_btn_avatar) / 2 - 10, lc.bottom(arg_2_0._userAvatar) - lc.h(var_btn_avatar) / 2 - 20))

	lc.addChildToPos(arg_2_0._form, var_2_4, cc.p(lc.left(arg_2_0._userAvatar) + lc.w(var_2_4) / 2 - 10, lc.bottom(arg_2_0._userAvatar) - lc.h(var_2_4) / 2 - 72))

	local var_2_5 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_5_0)
		arg_2_0:onChangeAvatar()
	end, ClientView.CRECT_BUTTON_S, var_0_4)

	var_2_5:addLabel(Str(STR.CHANGE_ICON))
	lc.addChildToPos(arg_2_0._form, var_2_5, cc.p(lc.right(var_2_4) + lc.w(var_2_5) / 2 + 10, lc.y(var_2_4)))

	local var_2_6 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_6_0)
		arg_2_0:onChangeAvatarFrame()
	end, ClientView.CRECT_BUTTON_S, var_0_4)

	var_2_6:addLabel(Str(STR.CHANGE_RECT))
	lc.addChildToPos(arg_2_0._form, var_2_6, cc.p(lc.right(var_2_5) + lc.w(var_2_6) / 2 + 10, lc.y(var_2_5)))

	local var_2_7 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_7_0)
		arg_2_0:onChangeCardBack()
	end, ClientView.CRECT_BUTTON_S, var_0_4)

	var_2_7:addLabel(Str(STR.CHANGE_CARD_BACK))
	lc.addChildToPos(arg_2_0._form, var_2_7, cc.p(lc.right(var_2_6) + lc.w(var_2_7) / 2 + 10, lc.y(var_2_5)))

	if not ClientData.isAppStoreReviewing() then
		local var_2_8 = ClientView.createScale9ShaderButton("img_btn_3_s", function(arg_8_0)
			arg_2_0:onShowVIP()
		end, ClientView.CRECT_BUTTON_S, var_0_4)

		var_2_8:addLabel("VIP " .. Str(STR.PRIVILEGE))
		var_2_8._label:setColor(ClientView.COLOR_TEXT_INGOT)
		lc.addChildToPos(arg_2_0._form, var_2_8, cc.p(lc.w(arg_2_0._form) - var_0_2 - lc.w(var_2_8) / 2, lc.top(arg_2_0._userAvatar) - lc.h(var_2_8) / 2 + 10))
		var_2_8:setVisible(not ClientData.isHideCharge())

		local var_2_9 = ClientView.createScale9ShaderButton("img_btn_3_s", function(arg_9_0)
			arg_2_0:onShowExchangeCode()
		end, ClientView.CRECT_BUTTON_S, var_0_4)

		var_2_9:addLabel(Str(STR.EXCHANGE_CODE))
		var_2_9._label:setColor(ClientView.COLOR_TEXT_INGOT)
		lc.addChildToPos(arg_2_0._form, var_2_9, cc.p(lc.x(var_2_8), 64))
	end

	if ClientData.isShowAgreement() then
		local var_2_10 = ClientView.createScale9ShaderButton("img_btn_1_s", ClientView.openUserProtocol, ClientView.CRECT_BUTTON_S, var_0_4)

		var_2_10:addLabel(Str(STR.AGREEMENT))
		lc.addChildToPos(arg_2_0._form, var_2_10, cc.p(lc.w(arg_2_0._form) - var_0_2 - lc.w(var_2_10) * 1.5, 64))
	end

	local var_2_11 = ClientView.createDividingLine(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, ClientView.COLOR_DIVIDING_LINE_LIGHT)

	lc.addChildToPos(arg_2_0._form, var_2_11, cc.p(lc.w(arg_2_0._form) / 2, lc.bottom(var_2_4) - 20))

	local var_2_12 = ClientView.createScale9ShaderButton(ClientData._isMusicOn and "img_btn_1_s" or "img_btn_2_s", function(arg_10_0)
		arg_2_0:onSwitchMusic(arg_10_0)
	end, ClientView.CRECT_BUTTON_S, var_0_5)

	var_2_12:addLabel(ClientData._isMusicOn and Str(STR.ON) or Str(STR.OFF))
	lc.addChildToPos(arg_2_0._form, var_2_12, cc.p(lc.right(var_2_4) - lc.w(var_2_12) / 2, lc.bottom(var_2_11) - lc.h(var_2_12) / 2 - 20))

	local var_2_13 = cc.Label:createWithTTF(Str(STR.AUDIO_MUSIC), ClientView.TTF_FONT, ClientView.FontSize.S2)

	var_2_13:setColor(ClientView.COLOR_LABEL_LIGHT)
	lc.addChildToPos(arg_2_0._form, var_2_13, cc.p(lc.left(var_2_12) - lc.w(var_2_13) / 2 - 10, lc.y(var_2_12)))

	local var_2_14 = ClientView.createScale9ShaderButton(ClientData._isEffectOn and "img_btn_1_s" or "img_btn_2_s", function(arg_11_0)
		arg_2_0:onSwitchEffect(arg_11_0)
	end, ClientView.CRECT_BUTTON_S, var_0_5)

	var_2_14:addLabel(ClientData._isEffectOn and Str(STR.ON) or Str(STR.OFF))
	lc.addChildToPos(arg_2_0._form, var_2_14, cc.p(lc.right(var_2_5) - lc.w(var_2_14) / 2, lc.y(var_2_12)))

	local var_2_15 = cc.Label:createWithTTF(Str(STR.AUDIO_EFFECT), ClientView.TTF_FONT, ClientView.FontSize.S2)

	var_2_15:setColor(ClientView.COLOR_LABEL_LIGHT)
	lc.addChildToPos(arg_2_0._form, var_2_15, cc.p(lc.left(var_2_14) - lc.w(var_2_15) / 2 - 10, lc.y(var_2_14)))

	local var_2_16 = ClientView.createScale9ShaderButton(ClientData._isPosOn and "img_btn_1_s" or "img_btn_2_s", function(arg_12_0)
		arg_2_0:onSwitchPos(arg_12_0)
	end, ClientView.CRECT_BUTTON_S, var_0_5)

	var_2_16:addLabel(ClientData._isPosOn and Str(STR.ON) or Str(STR.OFF))
	lc.addChildToPos(arg_2_0._form, var_2_16, cc.p(lc.right(var_2_6) - lc.w(var_2_16) / 2, lc.y(var_2_12)))

	local var_2_17 = cc.Label:createWithTTF(Str(STR.POS_LABEL, true), ClientView.TTF_FONT, ClientView.FontSize.S2)

	var_2_17:setColor(ClientView.COLOR_LABEL_LIGHT)
	lc.addChildToPos(arg_2_0._form, var_2_17, cc.p(lc.left(var_2_16) - lc.w(var_2_17) / 2 - 10, lc.y(var_2_16)))
	var_2_16:setVisible(P:getMaxCharacterLevel() >= ClientData.POS_UNLOCK_LEVEL)
	var_2_17:setVisible(var_2_16:isVisible())

	local var_2_18 = ClientView.createScale9ShaderButton(P._isNewRound and "img_btn_1_s" or "img_btn_2_s", function(arg_13_0)
		arg_2_0:onSwitchRound(arg_13_0)
	end, ClientView.CRECT_BUTTON_S, var_0_5)

	var_2_18:addLabel(P._isNewRound and Str(STR.ON) or Str(STR.OFF))
	lc.addChildToPos(arg_2_0._form, var_2_18, cc.p(lc.right(var_2_7) - lc.w(var_2_18) / 2, lc.y(var_2_12)))

	local var_2_19 = cc.Label:createWithTTF(Str(STR.NEW_ROUND_LABEL, true), ClientView.TTF_FONT, ClientView.FontSize.S2)

	var_2_19:setColor(ClientView.COLOR_LABEL_LIGHT)
	lc.addChildToPos(arg_2_0._form, var_2_19, cc.p(lc.left(var_2_18) - lc.w(var_2_19) / 2 - 10, lc.y(var_2_18)))

	local var_2_20 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_14_0)
		arg_2_0:onChangeRegion()
	end, ClientView.CRECT_BUTTON_S, var_0_4)

	var_2_20:addLabel(Str(STR.CHANGE_REGION))
	lc.addChildToPos(arg_2_0._form, var_2_20, cc.p(lc.x(var_2_5), lc.bottom(var_2_12) - lc.h(var_2_20) / 2 - 20))

	local var_2_21 = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = ClientView.CRECT_COM_BG2,
		_size = cc.size(240, 40)
	})

	var_2_21:setColor(lc.Color3B.black)
	var_2_21:setOpacity(150)
	lc.addChildToPos(arg_2_0._form, var_2_21, cc.p(lc.left(var_2_13) + lc.w(var_2_21) / 2 - 10, lc.y(var_2_20)), -1)

	local var_2_22 = ClientData._userRegion
	local var_2_23 = ClientView.createTTF(ClientData.genFullRegionName(var_2_22._id, var_2_22._name, true), ClientView.FontSize.S1)

	var_2_23:setScale(0.8)
	lc.addChildToPos(arg_2_0._form, var_2_23, cc.p(lc.left(var_2_13) + lc.sw(var_2_23) / 2, lc.y(var_2_20)))

	local var_2_24 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_15_0)
		arg_2_0:onHelp()
	end, ClientView.CRECT_BUTTON_S, var_0_4)

	var_2_24:addLabel(Str(STR.HELP))
	lc.addChildToPos(arg_2_0._form, var_2_24, cc.p(lc.x(var_2_6), lc.y(var_2_20)))

	local var_2_25 = lc.App:getChannelName()

	if ClientData.isVivo() and false then
		local var_2_26 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_16_0)
			require("Dialog").showDialog(Str(STR.CONFIRM_CLOSE_ACCOUNT), function()
				ClientData.sendBanLogin()

				ClientData._regions = {}

				ClientData.saveUserRegion()
				lc.App:userLogout()
				ClientView.getActiveIndicator():show(Str(STR.WAITING))
			end, nil, nil, function()
				lc.App:openURL("http://sh.smbbgo.com/mzsm/090921252395.html")
			end)
		end, ClientView.CRECT_BUTTON_S, var_0_4)

		var_2_26:addLabel(Str(STR.CLOSE_ACCOUNT))
		lc.addChildToPos(arg_2_0._form, var_2_26, cc.p(lc.w(arg_2_0._form) - var_0_2 - lc.w(var_2_26) / 2, lc.y(var_2_20)))
	elseif var_2_25 ~= "ASDK" and var_2_25 ~= "YIXIN" and not ClientData.isAppStoreReviewing() then
		local var_2_27 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_19_0)
			arg_2_0:onChangeUser()
		end, ClientView.CRECT_BUTTON_S, var_0_4)

		var_2_27:addLabel(Str(STR.CHANGE_USER))
		lc.addChildToPos(arg_2_0._form, var_2_27, cc.p(lc.w(arg_2_0._form) - var_0_2 - lc.w(var_2_27) / 2, lc.y(var_2_20)))
	end

	if var_2_25 == "FACEBOOK" then
		local var_2_28 = ClientView.createScale9ShaderButton(P._canBind and "img_btn_2_s" or "img_btn_1_s", function(arg_20_0)
			arg_2_0:onBindUser()
		end, ClientView.CRECT_BUTTON_S, var_0_4)

		var_2_28:addLabel(Str(P._canBind and STR.BIND_GCID or STR.BIND_GCID_BOUND))
		lc.addChildToPos(arg_2_0._form, var_2_28, cc.p(btnNotice:getPosition()))

		if lc.FrameCache:getSpriteFrame("img_facebook") then
			local var_2_29 = lc.createSprite("img_facebook")

			lc.addChildToPos(var_2_28, var_2_29, cc.p(28, lc.h(var_2_28) / 2 + 1))
			var_2_28._label:setPositionX(lc.x(var_2_28._label) + 16)
		end

		arg_2_0._btnBind = var_2_28

		btnNotice:setPosition(cc.p(lc.x(var_2_6), lc.y(btnIllustration)))
	end

	local var_2_30 = ClientView.createDividingLine(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, ClientView.COLOR_DIVIDING_LINE_LIGHT)

	lc.addChildToPos(arg_2_0._form, var_2_30, cc.p(lc.w(arg_2_0._form) / 2, lc.bottom(var_2_20) - 20))

	local var_2_31 = lc.bottom(var_2_30) - 20
	local var_2_32 = var_0_3 + 20
	local var_2_33 = {}

	for iter_2_0, iter_2_1 in pairs(Data._aboutInfo) do
		if not ClientData.isAppStoreReviewing() and (lc.PLATFORM ~= cc.PLATFORM_OS_ANDROID or ClientData.isYYB()) then
			table.insert(var_2_33, iter_2_1)
		end
	end

	table.sort(var_2_33, function(arg_21_0, arg_21_1)
		return arg_21_0._id < arg_21_1._id
	end)

	for iter_2_2 = 1, #var_2_33 do
		local var_2_34 = Str(var_2_33[iter_2_2]._descSid)

		if iter_2_2 == 2 and ClientData.isYYB() then
			var_2_34 = "658936992"
		end

		local var_2_35, var_2_36 = ClientView.createKeyValueLabel(Str(var_2_33[iter_2_2]._nameSid), var_2_34, ClientView.FontSize.M1)

		var_2_35:setScale(0.7)
		var_2_36:setScale(0.7)
		var_2_35:addToParent(arg_2_0._form, cc.p(var_2_32, var_2_31))

		var_2_31 = var_2_31 - 34
	end

	local var_2_37 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_22_0)
		arg_2_0:onAbout()
	end, ClientView.CRECT_BUTTON_S, var_0_4)

	var_2_37:addLabel(Str(STR.ABOUT))
	lc.addChildToPos(arg_2_0._form, var_2_37, cc.p(lc.w(arg_2_0._form) - var_0_2 - lc.w(var_2_37) / 2, lc.y(var_2_20)))
	var_2_37:setVisible(false)

	if ClientData.isRateValid() then
		local var_2_38 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_23_0)
			arg_2_0:onRate()
		end, ClientView.CRECT_BUTTON_S, var_0_4)

		var_2_38:addLabel(Str(STR.RATE))
		lc.addChildToPos(arg_2_0._form, var_2_38, cc.p(lc.left(btnAbout) - 10 - lc.w(var_2_38) / 2, marginTop))
	end

	arg_2_0._isShowResourceUI = true

	local var_2_39 = ClientView.createBMFont(ClientView.BMFont.huali_20, Str(STR.VERSION) .. ClientData.getDisplayVersion())

	var_2_39:setScale(0.8)
	lc.addChildToPos(arg_2_0, var_2_39, cc.p(lc.w(arg_2_0) / 2, 50))
end

function var_0_0.onEnter(arg_24_0)
	var_0_0.super.onEnter(arg_24_0)

	arg_24_0._listeners = {}

	local var_24_0 = lc.addEventListener(Data.Event.name_dirty, function(arg_25_0)
		arg_24_0._userAvatar:setName(P._name)
	end)

	table.insert(arg_24_0._listeners, var_24_0)

	local var_24_1 = lc.addEventListener(Data.Event.icon_dirty, function(arg_26_0)
		arg_24_0._userAvatar:setAvatar(P)
	end)

	table.insert(arg_24_0._listeners, var_24_1)

	local var_24_2 = lc.addEventListener(Data.Event.avatar_frame_dirty, function(arg_27_0)
		arg_24_0._userAvatar:setAvatar(P)
		arg_24_0._userAvatar:setVip(P._vip)
	end)

	table.insert(arg_24_0._listeners, var_24_2)

	local var_24_3 = lc.addEventListener(Data.Event.vip_dirty, function(arg_28_0)
		arg_24_0._userAvatar:setVip(P._vip)
	end)

	table.insert(arg_24_0._listeners, var_24_3)

	local var_24_4 = lc.addEventListener(Data.Event.character_dirty, function(arg_29_0)
		arg_24_0._userAvatar:setAvatar(P)
		arg_24_0:updateLevelExpBar()
	end)

	table.insert(arg_24_0._listeners, var_24_4)

	local var_24_5 = lc.addEventListener(GuideManager.Event.seek, function(arg_30_0)
		arg_24_0:onGuide(arg_30_0)
	end)

	table.insert(arg_24_0._listeners, var_24_5)

	local var_24_6 = lc.addEventListener(Data.Event.bind_gcid_dirty, function(arg_31_0)
		arg_24_0:updateBindBtn()
	end)

	table.insert(arg_24_0._listeners, var_24_6)

	if GuideManager.getCurStepName() == "enter setting" then
		GuideManager.finishStepLater()
	end
end

function var_0_0.onExit(arg_32_0)
	var_0_0.super.onExit(arg_32_0)

	for iter_32_0 = 1, #arg_32_0._listeners do
		lc.Dispatcher:removeEventListener(arg_32_0._listeners[iter_32_0])
	end

	arg_32_0._listeners = {}
end

function var_0_0.onChangeCharacter(arg_33_0)
	require("ChangeCharacterPanel").create(false):show()
end

function var_0_0.onShowVIP(arg_34_0)
	require("VIPInfoForm").create():show()
end

function var_0_0.onShowExchangeCode(arg_35_0)
	require("ExchangeCodeForm").create():show()
end

function var_0_0.onChangeAvatar(arg_36_0)
	require("SelectHeadForm").create():show()
end

function var_0_0.onChangeName(arg_37_0)
	require("RenameForm").create():show()
end

function var_0_0.onChangeAvatarFrame(arg_38_0)
	require("SelectAvatarFrameForm").create():show()
end

function var_0_0.onChangeCardBack(arg_39_0)
	require("SelectCardBackForm").create():show()
end

function var_0_0.onHelp(arg_40_0)
	require("BattleHelpForm").create():show()
end

function var_0_0.onChangeRegion(arg_41_0)
	ClientData.switchToRegionScene()
end

function var_0_0.onChangeUser(arg_42_0)
	if lc.App:getChannelName() == "APPSTORE" then
		require("Dialog").showDialog(Str(STR.CHANGE_USER_IN_GAMECENTER), function()
			return
		end)
	else
		ClientData._regions = {}

		ClientData.saveUserRegion()
		lc.App:userLogout()
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
	end
end

function var_0_0.onBindUser(arg_44_0)
	if P._canBind then
		if lc.App.facebookLogin ~= nil then
			lc.App:facebookLogin()
			ClientView.getActiveIndicator():show(Str(STR.WAITING))
		end
	else
		ToastManager.push(Str(STR.BIND_GCID_BOUND_LONG))
	end
end

function var_0_0.onSwitchMusic(arg_45_0, arg_45_1)
	ClientData.toggleAudio(lc.Audio.Behavior.music, not ClientData._isMusicOn)
	arg_45_1._label:setString(ClientData._isMusicOn and Str(STR.ON) or Str(STR.OFF))
	arg_45_1:loadTextureNormal(ClientData._isMusicOn and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
	arg_45_1:setContentSize(cc.size(var_0_5, ClientView.CRECT_BUTTON_S.height))
end

function var_0_0.onSwitchEffect(arg_46_0, arg_46_1)
	ClientData.toggleAudio(lc.Audio.Behavior.effect, not ClientData._isEffectOn)
	arg_46_1._label:setString(ClientData._isEffectOn and Str(STR.ON) or Str(STR.OFF))
	arg_46_1:loadTextureNormal(ClientData._isEffectOn and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
	arg_46_1:setContentSize(cc.size(var_0_5, ClientView.CRECT_BUTTON_S.height))
end

function var_0_0.onSwitchPos(arg_47_0, arg_47_1)
	ClientData.togglePos(not ClientData._isPosOn)
	arg_47_1._label:setString(ClientData._isPosOn and Str(STR.ON) or Str(STR.OFF))
	arg_47_1:loadTextureNormal(ClientData._isPosOn and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
	arg_47_1:setContentSize(cc.size(var_0_5, ClientView.CRECT_BUTTON_S.height))
end

function var_0_0.onSwitchRound(arg_48_0, arg_48_1)
	P:setNewRound(not P._isNewRound)
	arg_48_1._label:setString(P._isNewRound and Str(STR.ON) or Str(STR.OFF))
	arg_48_1:loadTextureNormal(P._isNewRound and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
	arg_48_1:setContentSize(cc.size(var_0_5, ClientView.CRECT_BUTTON_S.height))
end

function var_0_0.onShowIllustration(arg_49_0)
	require("IllustrationForm").create():show()
end

function var_0_0.onPushNotice(arg_50_0)
	require("PushNoticeForm").create():show()
end

function var_0_0.onAbout(arg_51_0)
	require("AboutForm").create():show()
end

function var_0_0.onRate(arg_52_0)
	require("RateForm").create():show()
end

function var_0_0.onShowActionFinished(arg_53_0)
	arg_53_0:onGuide(nil)
end

function var_0_0.onHideActionFinished(arg_54_0)
	if GuideManager.getCurStepName() == "leave setting" then
		GuideManager.finishStep()
	end
end

function var_0_0.onGuide(arg_55_0, arg_55_1)
	if GuideManager.getCurStepName() == "leave setting" then
		GuideManager.setOperateLayer(arg_55_0._btnBack)
	else
		return
	end

	if arg_55_1 then
		arg_55_1:stopPropagation()
	end
end

function var_0_0.updateBindBtn(arg_56_0)
	if arg_56_0._btnBind ~= nil then
		arg_56_0._btnBind._label:setString(Str(P._canBind and STR.BIND_GCID or STR.BIND_GCID_BOUND))
		arg_56_0._btnBind:loadTextureNormal(P._canBind and "img_btn_2" or "img_btn_1", ccui.TextureResType.plistType)
	end
end

function var_0_0.updateLevelExpBar(arg_57_0)
	if arg_57_0._levelExpBar ~= nil then
		arg_57_0._levelExpBar:removeFromParent()
	end

	local var_57_0 = P._characters[P:getCharacterId()]
	local var_57_1 = ClientView.createLevelExpBar(var_57_0._level, var_57_0._exp, P:getLevelupExp(var_57_0._level), 332)

	if var_57_0._level >= P:getMaxLevel(P:getCharacterId()) then
		var_57_1._label:setString(Str(STR.MAX_LEVEL))
	end

	lc.addChildToPos(arg_57_0._form, var_57_1, cc.p(lc.left(arg_57_0._userAvatar) + lc.cw(var_57_1) + 184, lc.bottom(arg_57_0._userAvatar) - 28))

	arg_57_0._levelExpBar = var_57_1

	local var_57_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(Data._characterInfo[var_57_0._id]._nameSid))

	var_57_2:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_57_1, var_57_2, cc.p(-180, lc.ch(var_57_1)))
end

return var_0_0
