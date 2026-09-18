local var_0_0 = require("Socket_pb")
local var_0_1 = class("RegionScene", require("BaseScene"))

function var_0_1.create()
	return lc.createScene(var_0_1)
end

function var_0_1.init(arg_2_0)
	if not var_0_1.super.init(arg_2_0, ClientData.SceneId.region) then
		return false
	end

	ClientData.loadLCRes("res/avatar.lcres")
	ClientData.loadLCRes("res/general.lcres")

	local var_2_0 = lc.File:getStringFromFile("res/updater/loading.plist")
	local var_2_1 = lc.TextureCache:addImage("res/updater/loading.pvr.ccz")

	lc.FrameCache:addSpriteFramesWithFileContent(var_2_0, var_2_1)

	local var_2_2 = true

	if ClientData.isShowAgreement() then
		var_2_2 = lc.UserDefault:getBoolForKey(ClientData.ConfigKey.agreement, false)
	end

	local var_2_3 = ClientView.createBMFont(ClientView.BMFont.huali_20, (Str(STR.VERSION) or "Phiên bản: ") .. ClientData.getDisplayVersion())

	var_2_3:setScale(0.8)
	lc.addChildToPos(arg_2_0, var_2_3, cc.p(ClientView.SCR_W - lc.cw(var_2_3) - ClientView.SCR_EDGE, 20), 2)

	if not ClientData.isAppStoreReviewing() then
		for iter_2_0 = 1, 3 do
			local var_2_4 = ClientView.createBMFont(ClientView.BMFont.huali_20, Str(STR.ISBN + iter_2_0 - 1, true))

			var_2_4:setAnchorPoint(0, 0.5)
			var_2_4:setScale(0.8)
			lc.addChildToPos(arg_2_0, var_2_4, cc.p(ClientView.SCR_EDGE + 16 + (iter_2_0 == 3 and 2 or 0), 80 - iter_2_0 * 20), 2)
		end
	end

	-- Background
	if ClientData.isAppStoreReviewing() then
		local var_2_5 = ClientView.createLoadingBg()
		var_2_5:setPosition(ClientView.SCR_CW, ClientView.SCR_CH)
		arg_2_0:addChild(var_2_5, 3)
	elseif ClientData.isDJLX() then
		local var_2_6 = cc.Sprite:create("res/updater/loading_djlx.jpg")
		var_2_6:setPosition(ClientView.SCR_CW, ClientView.SCR_CH)
		arg_2_0:addChild(var_2_6)

		local var_2_7 = cc.DragonBonesNode:createWithDecrypt("res/effects/loading3.lcres", "loading3", "loading3")
		var_2_7:gotoAndPlay("effect1")
		lc.addChildToPos(arg_2_0, var_2_7, cc.p(lc.w(arg_2_0) / 2 + 36, lc.h(arg_2_0) / 2 - 58))
		arg_2_0._bone = var_2_7
	else
		local var_2_8 = ClientView.createLoadingBg()
		var_2_8:setPosition(ClientView.SCR_CW, ClientView.SCR_CH)
		arg_2_0:addChild(var_2_8)

		local var_2_9 = "loading5"
		if ClientData.isAnotherSkin() then
			var_2_9 = "loading4"
		end

		local var_2_10 = cc.DragonBonesNode:createWithDecrypt(lc.formatBones(var_2_9), var_2_9, var_2_9)
		var_2_10:gotoAndPlay("effect")
		var_2_10:setVisible(false)
		lc.addChildToPos(arg_2_0, var_2_10, cc.p(lc.w(arg_2_0) / 2, lc.h(arg_2_0) / 2 - 58))
		arg_2_0._bone = var_2_10
	end

	-- ====== LOGIN / REGISTER UI ======
	arg_2_0._loginMode = 1   -- 1=login, 2=register
	arg_2_0._loginUsername = lc.UserDefault:getStringForKey("LOGIN_USERNAME", "")
	arg_2_0._loginPassword = ""
	arg_2_0._loginConfirm = ""
	arg_2_0._loginMsg = ClientData._loginError or ""
	ClientData._loginError = nil

	local loginLayer = lc.createNode(cc.size(lc.w(arg_2_0), lc.h(arg_2_0)))
	lc.addChildToCenter(arg_2_0, loginLayer, 5)
	arg_2_0._loginLayer = loginLayer

	-- Dim backdrop behind dialog
	local overlay = cc.LayerColor:create(cc.c4b(0, 0, 0, 190))
	loginLayer:addChild(overlay, 0)

	-- Dialog Window Frame (600 x 500) - beautifully proportioned
	local dialogW, dialogH = 600, 500
	local frameBox = ClientView.createFrameBox(cc.size(dialogW, dialogH))
	lc.addChildToPos(loginLayer, frameBox, cc.p(ClientView.SCR_CW, ClientView.SCR_CH), 1)
	arg_2_0._loginFrameBox = frameBox

	-- Title banner mounted at top edge of dialog frame
	local titleBg = ccui.Scale9Sprite:createWithSpriteFrameName("img_form_title_bg_2", ClientView.CRECT_FORM_TITLE_BG2)
	titleBg:setContentSize(dialogW - 120, 56)
	lc.addChildToPos(loginLayer, titleBg, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + dialogH / 2 - 4), 3)

	local lblTitle = cc.Label:createWithTTF("ĐĂNG NHẬP", ClientView.TTF_FONT, ClientView.FontSize.B2)
	lblTitle:setColor(cc.c3b(255, 230, 80))
	lc.addChildToCenter(titleBg, lblTitle)
	arg_2_0._lblLoginTitle = lblTitle

	-- Mode Tabs: Login & Register side-by-side
	local tabY = ClientView.SCR_CH + 165
	local tabLoginBtn = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:setLoginMode(1)
	end, ClientView.CRECT_BUTTON_S, 140, 44)
	lc.addChildToPos(loginLayer, tabLoginBtn, cc.p(ClientView.SCR_CW - 80, tabY), 2)
	local tabLoginLbl = cc.Label:createWithTTF("Đăng nhập", ClientView.TTF_FONT, ClientView.FontSize.S1)
	tabLoginLbl:setColor(lc.Color3B.white)
	lc.addChildToCenter(tabLoginBtn, tabLoginLbl)
	arg_2_0._tabLoginBtn = tabLoginBtn
	arg_2_0._tabLoginLbl = tabLoginLbl

	local tabRegBtn = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_2_0:setLoginMode(2)
	end, ClientView.CRECT_BUTTON_S, 140, 44)
	lc.addChildToPos(loginLayer, tabRegBtn, cc.p(ClientView.SCR_CW + 80, tabY), 2)
	local tabRegLbl = cc.Label:createWithTTF("Đăng ký", ClientView.TTF_FONT, ClientView.FontSize.S1)
	tabRegLbl:setColor(lc.Color3B.white)
	lc.addChildToCenter(tabRegBtn, tabRegLbl)
	arg_2_0._tabRegBtn = tabRegBtn
	arg_2_0._tabRegLbl = tabRegLbl

	-- Row geometry: Label at cx - 90 (anchor right), EditBox at cx + 65 (width 280)
	local labelX = ClientView.SCR_CW - 90
	local editX  = ClientView.SCR_CW + 65
	local editW, editH = 280, 42

	-- Row 1: Username
	local row1Y = ClientView.SCR_CH + 105
	local lblUser = cc.Label:createWithTTF("Tài khoản:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblUser:setAnchorPoint(1, 0.5)
	lblUser:setColor(cc.c3b(245, 225, 170))
	lc.addChildToPos(loginLayer, lblUser, cc.p(labelX, row1Y), 2)

	local editUser = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(editW, editH), "Nhập tên tài khoản", true, 20)
	editUser:setFontColor(lc.Color4B.white)
	lc.addChildToPos(loginLayer, editUser, cc.p(editX, row1Y), 2)
	arg_2_0._editUser = editUser

	-- Row 2: Password
	local row2Y = ClientView.SCR_CH + 55
	local lblPass = cc.Label:createWithTTF("Mật khẩu:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblPass:setAnchorPoint(1, 0.5)
	lblPass:setColor(cc.c3b(245, 225, 170))
	lc.addChildToPos(loginLayer, lblPass, cc.p(labelX, row2Y), 2)

	local editPass = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(editW, editH), "Nhập mật khẩu", true, 32)
	editPass:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
	editPass:setFontColor(lc.Color4B.white)
	lc.addChildToPos(loginLayer, editPass, cc.p(editX, row2Y), 2)
	arg_2_0._editPass = editPass

	-- Row 3: Confirm password (register mode only)
	local row3Y = ClientView.SCR_CH + 5
	local lblConfirm = cc.Label:createWithTTF("Nhập lại:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblConfirm:setAnchorPoint(1, 0.5)
	lblConfirm:setColor(cc.c3b(245, 225, 170))
	lc.addChildToPos(loginLayer, lblConfirm, cc.p(labelX, row3Y), 2)
	arg_2_0._lblConfirm = lblConfirm

	local editConfirm = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(editW, editH), "Nhập lại mật khẩu", true, 32)
	editConfirm:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
	editConfirm:setFontColor(lc.Color4B.white)
	lc.addChildToPos(loginLayer, editConfirm, cc.p(editX, row3Y), 2)
	arg_2_0._editConfirm = editConfirm

	arg_2_0._lblConfirm:setVisible(false)
	arg_2_0._editConfirm:setVisible(false)

	-- Row 4: Character Name (register mode only)
	local row4Y = ClientView.SCR_CH - 45
	local lblCharName = cc.Label:createWithTTF("Tên nhân vật:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblCharName:setAnchorPoint(1, 0.5)
	lblCharName:setColor(cc.c3b(245, 225, 170))
	lc.addChildToPos(loginLayer, lblCharName, cc.p(labelX, row4Y), 2)
	arg_2_0._lblCharName = lblCharName

	local editCharName = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(editW, editH), "Nhập tên nhân vật", true, 20)
	editCharName:setFontColor(lc.Color4B.white)
	lc.addChildToPos(loginLayer, editCharName, cc.p(editX, row4Y), 2)
	arg_2_0._editCharName = editCharName

	arg_2_0._lblCharName:setVisible(false)
	arg_2_0._editCharName:setVisible(false)

	-- Message / Error label
	local lblMsg = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2)
	lblMsg:setColor(cc.c3b(255, 90, 80))
	lc.addChildToPos(loginLayer, lblMsg, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 92), 2)
	arg_2_0._lblLoginMsg = lblMsg

	-- Skip tutorial unconditionally
	arg_2_0._skipTutorial = true

	-- Remember Login checkbox
	local savedRemember = lc.UserDefault:getBoolForKey("REMEMBER_LOGIN", true)
	arg_2_0._rememberLogin = savedRemember
	local rememberStr = arg_2_0._rememberLogin and "[✓] Lưu tài khoản & mật khẩu" or "[  ] Lưu tài khoản & mật khẩu"
	local rememberBox = cc.Label:createWithTTF(rememberStr, ClientView.TTF_FONT, ClientView.FontSize.S2)
	rememberBox:setColor(arg_2_0._rememberLogin and lc.Color3B.green or lc.Color3B.white)
	lc.addChildToPos(loginLayer, rememberBox, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 122), 2)
	arg_2_0._rememberBoxLabel = rememberBox

	local rememberBtn = ClientView.createShaderButton("load_region_bg", function()
		arg_2_0._rememberLogin = not arg_2_0._rememberLogin
		if arg_2_0._rememberLogin then
			arg_2_0._rememberBoxLabel:setString("[✓] Lưu tài khoản & mật khẩu")
			arg_2_0._rememberBoxLabel:setColor(lc.Color3B.green)
		else
			arg_2_0._rememberBoxLabel:setString("[  ] Lưu tài khoản & mật khẩu")
			arg_2_0._rememberBoxLabel:setColor(lc.Color3B.white)
		end
	end)
	rememberBtn:setContentSize(300, 32)
	rememberBtn:setOpacity(0)
	lc.addChildToPos(loginLayer, rememberBtn, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 122), 3)
	arg_2_0._rememberBtn = rememberBtn

	-- Submit Button (Centered, solid green button)
	local btnSubmit = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onLoginSubmit()
	end, ClientView.CRECT_BUTTON_S, 250, 56)
	btnSubmit:addLabel(Str(STR.START))
	lc.addChildToPos(loginLayer, btnSubmit, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 178), 2)
	arg_2_0._btnLoginSubmit = btnSubmit

	arg_2_0:updateLoginFields()

	-- Pre-fill saved username & password
	local savedUser = lc.UserDefault:getStringForKey("LOGIN_USERNAME", "")
	if savedUser ~= "" then
		arg_2_0._editUser:setText(savedUser)
	end
	local savedPass = savedRemember and lc.UserDefault:getStringForKey("LOGIN_PASSWORD", "") or ""
	if savedPass ~= "" then
		arg_2_0._editPass:setText(savedPass)
	end

	-- ====== REGION UI (hidden until login done) ======
	local var_2_11 = lc.createNode(cc.size(lc.w(arg_2_0), lc.h(arg_2_0)))
	lc.addChildToCenter(arg_2_0, var_2_11, 1)
	var_2_11:setVisible(false)
	arg_2_0._regionLayer = var_2_11

	local var_2_12 = lc.createSprite("load_region_bg")
	var_2_12:setScale(8, 1)
	lc.addChildToPos(var_2_11, var_2_12, cc.p(ClientView.SCR_CW, var_2_2 and 190 or 200))

	local var_2_13 = ClientView.createScale9ShaderButton(nil, function(arg_3_0)
		local var_3_0 = require("SelectRegionForm").create()

		function var_3_0._callback(arg_4_0)
			ClientData._userRegion._id = arg_4_0
			arg_2_0:updateSelectedRegion()
		end

		var_3_0:show()
	end, cc.rect(1, 1, 1, 1), 460, 62)

	var_2_13:setColor(cc.c3b(12, 15, 30))
	var_2_13:setTouchEnabled(false)
	var_2_13:setContentSize(hintBgSize)
	lc.addChildToPos(var_2_11, var_2_13, cc.p(lc.w(arg_2_0) / 2, lc.y(var_2_12)))

	arg_2_0._btnChange = var_2_13

	local var_2_14 = cc.Label:createWithTTF(Str(STR.REGION_LOADING), ClientView.TTF_FONT, ClientView.FontSize.M2)
	lc.addChildToCenter(var_2_13, var_2_14, 2)
	arg_2_0._loadingText = var_2_14

	local var_2_15 = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.M2)
	var_2_15:setAnchorPoint(0, 0.5)
	var_2_15:setVisible(false)
	lc.addChildToPos(var_2_13, var_2_15, cc.p(16, lc.h(var_2_13) / 2), 2)
	arg_2_0._regionText = var_2_15

	local var_2_16 = cc.Label:createWithTTF(Str(STR.REGION_CHANGE), ClientView.TTF_FONT, ClientView.FontSize.M2)
	var_2_16:setAnchorPoint(1, 0.5)
	var_2_16:setVisible(false)
	var_2_16:setColor(lc.Color3B.green)
	lc.addChildToPos(var_2_13, var_2_16, cc.p(lc.w(var_2_13) - 16, lc.h(var_2_13) / 2), 2)
	arg_2_0._changeLabel = var_2_16

	local var_2_17 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		local var_5_0 = true

		if ClientData.isShowAgreement() then
			var_5_0 = lc.UserDefault:getBoolForKey(ClientData.ConfigKey.agreement, false)
		end

		if not var_5_0 then
			return ToastManager.push(string.format(Str(STR.CONFIRM_AGREEMENT_2), ClientData.getAppName()))
		end

		arg_2_0:switchScene()
	end, ClientView.CRECT_BUTTON_S, 280, 72)

	var_2_17:addLabel(Str(STR.START))
	var_2_17:setEnabled(false)
	lc.addChildToPos(var_2_11, var_2_17, cc.p(ClientView.SCR_CW + 10, 80))
	arg_2_0._btnStart = var_2_17

	if ClientData.getAppId() ~= "10051" then
		local var_2_18 = lc.createSprite("load_region_bg")
		var_2_18:setScale(8, 0.7)
		lc.addChildToPos(var_2_11, var_2_18, cc.p(ClientView.SCR_CW, 135), 1)

		local var_2_19 = ClientView.createTTF(string.format(Str(STR.CONFIRM_AGREEMENT), ClientData.getAppName()), ClientView.FontSize.S1, lc.Color3B.white)
		lc.addChildToPos(var_2_11, var_2_19, cc.p(ClientView.SCR_CW, lc.y(var_2_18)), 1)

		local var_2_20 = ClientView.createShaderButton(nil, ClientView.openUserProtocol)
		var_2_20:setContentSize(var_2_19:getContentSize())
		lc.addChildToPos(var_2_11, var_2_20, cc.p(var_2_19:getPosition()), 2)

		local var_2_21 = ccui.CheckBox:create("img_filter_item", "img_filter", ccui.TextureResType.plistType)
		var_2_21:setSelected(var_2_2)
		lc.addChildToPos(var_2_11, var_2_21, cc.p(lc.left(var_2_19) - lc.cw(var_2_21), lc.y(var_2_18)), 1)
		var_2_21:addEventListener(function(arg_6_0, arg_6_1)
			if arg_6_1 == ccui.CheckBoxEventType.selected then
				lc.UserDefault:setBoolForKey(ClientData.ConfigKey.agreement, true)
			elseif arg_6_1 == ccui.CheckBoxEventType.unselected then
				lc.UserDefault:setBoolForKey(ClientData.ConfigKey.agreement, false)
			end
		end)
	end

	local var_2_22 = ClientView.createTTF(Str(STR.GAME_ANNOUNCE, true), 18, cc.c3b(0, 0, 0), cc.size(600, 0), cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
	var_2_22:setAnchorPoint(0.5, 1)
	lc.addChildToPos(arg_2_0, var_2_22, cc.p(ClientView.SCR_CW, ClientView.SCR_H - 4))
	var_2_22:setVisible(false)

	if ClientData.isShowAgreement() then
		lc.TextureCache:addImageWithMask("res/jpg/load_btn_agreement.jpg")
		local var_2_23 = ClientView.createShaderButton("res/jpg/load_btn_agreement.jpg", ClientView.openUserProtocol)
		lc.addChildToPos(var_2_23, ClientView.fitLabel(ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.AGREEMENT)), lc.w(var_2_23) - 6, 0.4), cc.p(lc.w(var_2_23) / 2, 20))
		lc.addChildToPos(arg_2_0, var_2_23, cc.p(ClientView.SCR_W - 12 - lc.w(var_2_23) / 2, ClientView.SCR_H - 20 - lc.h(var_2_23) / 2))
	end

	arg_2_0._isPacketReceived = false
	arg_2_0._isGuideOnEnter = false

	if ClientData.isAppStoreReviewing() then
		var_2_11:setVisible(true)
	elseif ClientData.isAnotherSkin() then
		local var_2_24 = arg_2_0._bone:getAnimationDuration("effect1")
		arg_2_0:runAction(lc.sequence(var_2_24, function()
			arg_2_0._bone:gotoAndPlay("effect2")
		end))
	end

	if lc.FrameCache:getSpriteFrame("load_age") ~= nil then
		local var_2_25 = ClientView.createShaderButton("load_age", function()
			ClientView.showHelpForm(nil, Data.HelpType.age_limit)
		end)
		lc.addChildToPos(arg_2_0, var_2_25, cc.p(lc.cw(var_2_25) + 10, lc.h(arg_2_0) - lc.ch(var_2_25) - 10), 10)
	end

	return true
end

-- ====== LOGIN UI METHODS ======

function var_0_1.setLoginMode(arg_lm_0, arg_lm_1)
	arg_lm_0._loginMode = arg_lm_1
	arg_lm_0._loginMsg = ""

	if arg_lm_1 == 1 then
		arg_lm_0._lblLoginTitle:setString("ĐĂNG NHẬP")
		if arg_lm_0._tabLoginBtn.setDisplayFrame then
			arg_lm_0._tabLoginBtn:setDisplayFrame("img_btn_1_s")
		end
		if arg_lm_0._tabRegBtn.setDisplayFrame then
			arg_lm_0._tabRegBtn:setDisplayFrame("img_btn_2_s")
		end
		if arg_lm_0._btnLoginSubmit and arg_lm_0._btnLoginSubmit._label then
			arg_lm_0._btnLoginSubmit._label:setString("BẮT ĐẦU")
		end
		if arg_lm_0._lblConfirm then arg_lm_0._lblConfirm:setVisible(false) end
		if arg_lm_0._editConfirm then arg_lm_0._editConfirm:setVisible(false) end
		if arg_lm_0._lblCharName then arg_lm_0._lblCharName:setVisible(false) end
		if arg_lm_0._editCharName then arg_lm_0._editCharName:setVisible(false) end
		if arg_lm_0._rememberBoxLabel then arg_lm_0._rememberBoxLabel:setVisible(true) end
		if arg_lm_0._rememberBtn then arg_lm_0._rememberBtn:setVisible(true) end
	else
		arg_lm_0._lblLoginTitle:setString("ĐĂNG KÝ")
		if arg_lm_0._tabLoginBtn.setDisplayFrame then
			arg_lm_0._tabLoginBtn:setDisplayFrame("img_btn_2_s")
		end
		if arg_lm_0._tabRegBtn.setDisplayFrame then
			arg_lm_0._tabRegBtn:setDisplayFrame("img_btn_1_s")
		end
		if arg_lm_0._btnLoginSubmit and arg_lm_0._btnLoginSubmit._label then
			arg_lm_0._btnLoginSubmit._label:setString("ĐĂNG KÝ NGAY")
		end
		if arg_lm_0._lblConfirm then arg_lm_0._lblConfirm:setVisible(true) end
		if arg_lm_0._editConfirm then arg_lm_0._editConfirm:setVisible(true) end
		if arg_lm_0._lblCharName then arg_lm_0._lblCharName:setVisible(true) end
		if arg_lm_0._editCharName then arg_lm_0._editCharName:setVisible(true) end
		if arg_lm_0._rememberBoxLabel then arg_lm_0._rememberBoxLabel:setVisible(false) end
		if arg_lm_0._rememberBtn then arg_lm_0._rememberBtn:setVisible(false) end
	end
	arg_lm_0:updateLoginFields()
end

function var_0_1.updateLoginFields(arg_uf_0)
	arg_uf_0._lblLoginMsg:setString(arg_uf_0._loginMsg)
end

function var_0_1.onLoginSubmit(arg_ls_0)
	local username = string.trim(arg_ls_0._editUser:getText())
	local password = string.trim(arg_ls_0._editPass:getText())
	local confirm = string.trim(arg_ls_0._editConfirm:getText())
	local charName = arg_ls_0._editCharName and string.trim(arg_ls_0._editCharName:getText()) or ""

	if username == "" then
		arg_ls_0._loginMsg = "Vui lòng nhập tài khoản!"
		arg_ls_0:updateLoginFields()
		return
	end
	if #username < 3 or #username > 20 then
		arg_ls_0._loginMsg = "Tài khoản phải từ 3-20 ký tự!"
		arg_ls_0:updateLoginFields()
		return
	end
	if password == "" then
		arg_ls_0._loginMsg = "Vui lòng nhập mật khẩu!"
		arg_ls_0:updateLoginFields()
		return
	end
	if #password < 4 then
		arg_ls_0._loginMsg = "Mật khẩu phải từ 4 ký tự trở lên!"
		arg_ls_0:updateLoginFields()
		return
	end
	if arg_ls_0._loginMode == 2 then
		if confirm == "" then
			arg_ls_0._loginMsg = "Vui lòng nhập lại mật khẩu!"
			arg_ls_0:updateLoginFields()
			return
		end
	if password ~= confirm then
			arg_ls_0._loginMsg = "Mật khẩu nhập lại không khớp!"
			arg_ls_0:updateLoginFields()
			return
		end
		if charName == "" then
			arg_ls_0._loginMsg = "Vui lòng nhập tên nhân vật!"
			arg_ls_0:updateLoginFields()
			return
		end
		if #charName < 2 or #charName > 20 then
			arg_ls_0._loginMsg = "Tên nhân vật phải từ 2-20 ký tự!"
			arg_ls_0:updateLoginFields()
			return
		end
	end

	arg_ls_0._btnLoginSubmit:setEnabled(false)
	arg_ls_0._loginMsg = "Đang xác thực với máy chủ..."
	arg_ls_0:updateLoginFields()

	local api = jsbridge.object("jdzcApi")
	local cb = function(rawRes)
		local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
		if res and res.code == 200 then
			ClientData._account = res.account
			if P and res.account then
				local gc = tonumber(res.account.gold_cup) or 0
				local sc = tonumber(res.account.silver_cup) or 0
				local bc = tonumber(res.account.bronze_cup) or 0
				if gc > 0 then
					P._crown = { _infoId = 7204, _num = gc }
				elseif sc > 0 then
					P._crown = { _infoId = 7205, _num = sc }
				elseif bc > 0 then
					P._crown = { _infoId = 7206, _num = bc }
				end
			end
			ClientData._loginUsername = username
			ClientData._loginPassword = password
			ClientData._skipTutorial = true
			if arg_ls_0._rememberLogin then
				lc.UserDefault:setStringForKey("LOGIN_USERNAME", username)
				lc.UserDefault:setStringForKey("LOGIN_PASSWORD", password)
				lc.UserDefault:setBoolForKey("REMEMBER_LOGIN", true)
			else
				lc.UserDefault:setStringForKey("LOGIN_PASSWORD", "")
				lc.UserDefault:setBoolForKey("REMEMBER_LOGIN", false)
			end

			-- Populate servers from MySQL
			ClientData._regions = {}
			for _, srv in ipairs(res.servers or {}) do
				ClientData._regions[srv.id] = {
					_id = srv.id,
					_name = srv.name,
					_host = srv.host,
					_status = srv.status,
					_isNew = srv.is_new == 1,
					_isRecommend = srv.is_recommend == 1
				}
			end
			ClientData._regionCount = #(res.servers or {})
			ClientData._historyRegion = {}
			ClientData._userRegion = ClientData._regions[1] or { _id = 1, _name = "S1 - Quyết Chiến Chi Thành" }

			-- Switch to region selection
			arg_ls_0._loginLayer:setVisible(false)
			arg_ls_0._regionLayer:setVisible(true)
			arg_ls_0:updateSelectedRegion()
		else
			arg_ls_0._btnLoginSubmit:setEnabled(true)
			arg_ls_0._loginMsg = res and res.msg or "Lỗi kết nối máy chủ!"
			arg_ls_0:updateLoginFields()
		end
	end

	if arg_ls_0._loginMode == 2 then
		api:register(username, password, charName, cb)
	else
		api:login(username, password, cb)
	end
end

function var_0_1.onLogin(arg_on_0)
	-- Password login completes on this scene's socket. The stock flow asked
	-- for the server list before showing the start button; the login form
	-- short-circuits that (a saved region goes straight to a login), so ask
	-- for the list here. The response populates the server picker and
	-- enables the start button; LoadingScene handles the game login after.
	ClientView.getActiveIndicator():hide()
	ClientData._loginMode = "login"
	ClientData.loginRegionServer()

	return true
end

function var_0_1.onEnter(arg_9_0)
	var_0_1.super.onEnter(arg_9_0)
	GuideManager.releaseLayer()

	-- Don't connect yet - wait for login form submission
	-- Connection will happen in onLoginSubmit()

	-- Announcement form disabled for offline/self-hosted server
	-- (external URL unreachable, blocks login UI)
	-- if not ClientData.isAppStoreReviewing() then
	-- 	require("ServerAnnouncementForm").create():show()
	-- end

	lc.Audio.playAudio(AUDIO.M_LOADING)
end

function var_0_1.onExit(arg_11_0)
	var_0_1.super.onExit(arg_11_0)
	arg_11_0:unscheduleLoading()
	lc.Dispatcher:removeEventListener(arg_11_0._listener)
end

function var_0_1.onCleanup(arg_12_0)
	var_0_1.super.onCleanup(arg_12_0)
end

function var_0_1.onMsg(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.type
	local var_13_1 = arg_13_1.status

	if var_13_0 == SglMsgType_pb.PB_TYPE_REGION_LIST then
		local var_13_2 = arg_13_1.Extensions[Region_pb.SglRegionMsg.region_list_resp]

		ClientData._regions = {}

		for iter_13_0 = 1, #var_13_2.region do
			local var_13_3 = arg_13_0:newRegion(var_13_2.region[iter_13_0])

			if ClientData.isDJLX() then
				if var_13_3._id > Data.DJLX_REGION_ID_BASE then
					ClientData._regions[var_13_3._id] = var_13_3
				end
			else
				ClientData._regions[var_13_3._id] = var_13_3
			end
		end

		ClientData._regionCount = #var_13_2.region

		if ClientData.isDJLX() then
			ClientData._regionCount = ClientData._regionCount - Data.DJLX_REGION_ID_BASE
		end

		ClientData._historyRegion = {}

		local var_13_4 = var_13_2.last_login

		for iter_13_1 = 1, #var_13_4 do
			local var_13_5 = arg_13_0:newHistory(var_13_4[iter_13_1])

			if ClientData._regions[var_13_5._rid] then
				table.insert(ClientData._historyRegion, var_13_5)
			end
		end

		if #ClientData._historyRegion > 0 then
			ClientData._userRegion._id = ClientData._historyRegion[1]._rid
		else
			local var_13_6
			local var_13_7
			local var_13_8

			for iter_13_2, iter_13_3 in pairs(ClientData._regions) do
				var_13_8 = iter_13_3._id

				if iter_13_3._isRecommend then
					var_13_6 = iter_13_3._id
				end

				if iter_13_3._isNew then
					var_13_7 = iter_13_3._id
				end
			end

			ClientData._userRegion._id = var_13_6 or var_13_7 or var_13_8
		end

		arg_13_0._isPacketReceived = true

		if ClientData.isAppStoreReviewing() then
			arg_13_0:switchScene()
		else
			arg_13_0:tryUnscheduleLoading()
		end
	end

	if var_0_1.super.onMsg(arg_13_0, arg_13_1) then
		return true
	end

	return false
end

function var_0_1.onIdle(arg_14_0)
	lc.Director:updateTouchTimestamp()
end

function var_0_1.newRegion(arg_15_0, arg_15_1)
	return {
		_id = arg_15_1.id,
		_host = arg_15_1.host,
		_name = arg_15_1.name,
		_status = arg_15_1.status,
		_isNew = arg_15_1.is_new,
		_isRecommend = arg_15_1.is_recommend
	}
end

function var_0_1.newHistory(arg_16_0, arg_16_1)
	local var_16_0 = {
		_rid = arg_16_1.rid,
		_name = arg_16_1.name,
		_level = arg_16_1.level,
		_avatar = arg_16_1.avatar,
		_vip = arg_16_1.vip,
		_avatarFrameId = arg_16_1.avatar_frame
	}

	if var_16_0._avatarFrameId == 0 then
		var_16_0._avatarFrameId = nil
	end

	lc.log("rid: %d, timestamp:%f", arg_16_1.rid, arg_16_1.last_login)

	return var_16_0
end

function var_0_1.unscheduleLoading(arg_17_0)
	if arg_17_0._loadingSchedulerID ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_17_0._loadingSchedulerID)

		arg_17_0._loadingSchedulerID = nil
	end
end

function var_0_1.tryUnscheduleLoading(arg_18_0)
	if arg_18_0._isPacketReceived == true then
		arg_18_0:unscheduleLoading()
		arg_18_0:updateSelectedRegion()
	end
end

function var_0_1.updateLoading(arg_19_0, arg_19_1)
	arg_19_0._loadingTick = arg_19_0._loadingTick + 1

	if arg_19_0._loadingTick == 4 then
		arg_19_0._loadingTick = 0
	end

	local var_19_0 = Str(STR.REGION_LOADING)

	if arg_19_0._loadingTick > 0 then
		for iter_19_0 = 1, arg_19_0._loadingTick do
			var_19_0 = var_19_0 .. "."
		end
	end

	arg_19_0._loadingText:setString(var_19_0)
end

function var_0_1.updateSelectedRegion(arg_20_0)
	arg_20_0._loadingText:setVisible(false)
	arg_20_0._btnChange:setTouchEnabled(true)
	arg_20_0._changeLabel:setVisible(true)
	arg_20_0._btnStart:setEnabled(true)

	local var_20_0 = ClientData._regions[ClientData._userRegion._id]

	arg_20_0._regionText:setVisible(true)
	arg_20_0._regionText:setString(ClientData.genFullRegionName(var_20_0._id, var_20_0._name))

	-- the server name sits on the left of the bar and the change hint on the
	-- right; in Vietnamese both run long enough to meet in the middle
	local var_20_9 = lc.w(arg_20_0._btnChange) / 2 - 28

	ClientView.fitLabel(arg_20_0._regionText, var_20_9)
	ClientView.fitLabel(arg_20_0._changeLabel, var_20_9)
end

function var_0_1.switchScene(arg_21_0)
	arg_21_0._btnStart:setEnabled(false)
	arg_21_0._btnStart:setVisible(false)
	if arg_21_0._regionLayer then arg_21_0._regionLayer:setVisible(false) end
	if arg_21_0._btnRegion then arg_21_0._btnRegion:setVisible(false) end
	if arg_21_0._regionText then arg_21_0._regionText:setVisible(false) end

	if not arg_21_0._loadingLayer then
		local loadLayer = cc.Node:create()
		lc.addChildToPos(arg_21_0, loadLayer, cc.p(0, 0), 100)
		arg_21_0._loadingLayer = loadLayer

		local shade = ccui.Scale9Sprite:createWithSpriteFrameName("load_bar_shade", cc.rect(11, 11, 1, 1))
		shade:setPosition(ClientView.SCR_CW, 110)
		shade:setContentSize(cc.size(600, 48))
		shade:setColor(cc.c3b(12, 15, 30))
		shade:setOpacity(160)
		loadLayer:addChild(shade, 1)

		local hint = cc.Label:createWithTTF("Đang kết nối máy chủ...", ClientView.TTF_FONT, ClientView.FontSize.S1)
		hint:setPosition(ClientView.SCR_CW, 110)
		hint:setColor(cc.c3b(245, 230, 180))
		loadLayer:addChild(hint, 2)
		arg_21_0._loadingHint = hint

		local barBg = ccui.Scale9Sprite:createWithSpriteFrameName("load_bar_bg", cc.rect(96, 0, 4, 36))
		barBg:setPosition(ClientView.SCR_CW, 60)
		barBg:setContentSize(cc.size(624, 36))
		loadLayer:addChild(barBg, 1)

		local bar = ccui.LoadingBar:create()
		bar:loadTexture("load_bar_fg", ccui.TextureResType.plistType)
		bar:setPosition(ClientView.SCR_CW, 60)
		bar:setScale9Enabled(true)
		bar:setCapInsets(cc.rect(21, 0, 2, 24))
		bar:setContentSize(cc.size(600, 24))
		bar:setPercent(0)
		loadLayer:addChild(bar, 2)
		arg_21_0._loadingBar = bar

		local percentLbl = ClientView.createBMFont(ClientView.BMFont.huali_20, "0%")
		percentLbl:setPosition(ClientView.SCR_CW, 60)
		loadLayer:addChild(percentLbl, 3)
		arg_21_0._loadingPercentLbl = percentLbl
	end
	arg_21_0._loadingLayer:setVisible(true)

	local curPct = 15
	local function setProgress(pct, msg)
		curPct = pct
		if arg_21_0._loadingBar then arg_21_0._loadingBar:setPercent(pct) end
		if arg_21_0._loadingPercentLbl then arg_21_0._loadingPercentLbl:setString(tostring(pct) .. "%") end
		if msg and arg_21_0._loadingHint then arg_21_0._loadingHint:setString(msg) end
	end

	setProgress(15, "Đang kết nối máy chủ...")

	local waitAction = arg_21_0:runAction(cc.RepeatForever:create(cc.Sequence:create(
		cc.DelayTime:create(0.08),
		cc.CallFunc:create(function()
			if curPct < 40 then
				setProgress(curPct + 2, "Đang kết nối máy chủ...")
			end
		end)
	)))

	local api = jsbridge.object("jdzcApi")
	local accId = ClientData._account and ClientData._account.id or 1
	local srvId = ClientData._userRegion and ClientData._userRegion._id or 1

	api:enterGame(accId, srvId, function(rawRes)
		local ok, err = xpcall(function()
		if waitAction then arg_21_0:stopAction(waitAction) end
		local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
		if res and res.code == 200 and res.data then
			setProgress(45, "Đang đồng bộ dữ liệu tài khoản...")

			ClientData.loadLCRes("res/city.lcres")
			ClientData.loadLCRes("res/cards_back.lcres")
			ClientData.loadLCRes("res/cards_img_1.lcres")

			local acc = res.data.account
			if res.data.leaderboard then
				ClientData._cachedLeaderboard = res.data.leaderboard
			end
			local cards = res.data.cards
			local decks = res.data.decks
			local cur_levels = res.data.cur_levels

			performWithDelay(arg_21_0, function()
				setProgress(68, "Đang nạp danh mục thẻ bài...")

				local ob = require("OnlineBridge")
				local pb_data = ob.buildLoginData(acc, cards, decks, cur_levels, res.data.checkins)
				ClientData.loadPlayerData(P, pb_data)
				if ob and ob.syncCheckinBonuses then
					ob.syncCheckinBonuses(P, res.data.checkins)
				end

				performWithDelay(arg_21_0, function()
					setProgress(85, "Đang khôi phục bộ bài...")

					local BANNED_DECK_CARDS = { [40657] = true, [40693] = true, [40694] = true }
					for _, d in ipairs(decks or {}) do
						local counts, order = {}, {}
						for _, cid in ipairs(d.cards or {}) do
							cid = tonumber(cid)
							if cid and cid > 0 and not BANNED_DECK_CARDS[cid] then
								if not counts[cid] then
									counts[cid] = 0
									table.insert(order, cid)
								end
								counts[cid] = counts[cid] + 1
							end
						end
						for _, cid in ipairs(d.extra_cards or {}) do
							cid = tonumber(cid)
							if cid and cid > 0 and not BANNED_DECK_CARDS[cid] then
								if not counts[cid] then
									counts[cid] = 0
									table.insert(order, cid)
								end
								counts[cid] = counts[cid] + 1
							end
						end
						local card_objs = {}
						for _, cid in ipairs(order) do
							table.insert(card_objs, { _infoId = cid, _num = counts[cid] })
						end
						P._playerCard:saveTroop(card_objs, d.deck_slot or 1)
					end

					performWithDelay(arg_21_0, function()
						setProgress(95, "Đang khởi tạo thế giới game...")

						ClientData.saveUserRegion()
						ClientData.unloadLoadingRes(true)
						lc.File:purgeCachedEntries()

						ClientView.getResourceUI():setLocalZOrder(ClientData.ZOrder.ui)
						ClientView.getMenuUI()
						ClientView.getChatPanel()

						setProgress(100, "Hoàn tất! Đang vào trò chơi...")

						arg_21_0:runAction(cc.Sequence:create(
							cc.DelayTime:create(0.2),
							cc.CallFunc:create(function()
								ClientData.replaceCityScene()
							end)
						))
					end, 0.08)
				end, 0.08)
			end, 0.08)
		else
			if arg_21_0._loadingLayer then arg_21_0._loadingLayer:setVisible(false) end
			arg_21_0._btnStart:setVisible(true)
			arg_21_0._btnStart:setEnabled(true)
			if arg_21_0._btnRegion then arg_21_0._btnRegion:setVisible(true) end
			if arg_21_0._regionText then
				arg_21_0._regionText:setVisible(true)
				arg_21_0._regionText:setString(res and res.msg or "Lỗi kết nối máy chủ!")
			end
			if ToastManager and ToastManager.push then
				ToastManager.push(res and res.msg or "Lỗi kết nối máy chủ!")
			end
		end
		end, function(e)
			print("[ENTER_GAME ERROR] " .. tostring(e) .. "\n" .. debug.traceback())
		end)
	end)
end

return var_0_1
