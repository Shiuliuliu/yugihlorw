-- LoginScene: username/password login and registration
-- Shown before RegionScene when no saved credentials exist.

local var_0_0 = class("LoginScene", require("BaseScene"))

local MODE_LOGIN = 1
local MODE_REGISTER = 2

function var_0_0.create()
	return lc.createScene(var_0_0)
end

function var_0_0.init(arg_2_0)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.region) then
		return false
	end

	arg_2_0._mode = MODE_LOGIN
	arg_2_0._username = ""
	arg_2_0._password = ""
	arg_2_0._confirmPass = ""
	arg_2_0._message = ""
	arg_2_0._isGuideOnEnter = false

	ClientData.loadLCRes("res/avatar.lcres")
	ClientData.loadLCRes("res/general.lcres")

	local var_2_0l = lc.File:getStringFromFile("res/updater/loading.plist")
	local var_2_1l = lc.TextureCache:addImage("res/updater/loading.pvr.ccz")
	lc.FrameCache:addSpriteFramesWithFileContent(var_2_0l, var_2_1l)

	-- Background
	local var_2_0 = ClientView.createLoadingBg()
	var_2_0:setPosition(ClientView.SCR_CW, ClientView.SCR_CH)
	arg_2_0:addChild(var_2_0)

	-- Title
	local var_2_1 = ClientView.createBMFont(ClientView.BMFont.huali_32, ClientData.getAppName())
	var_2_1:setScale(1.5)
	lc.addChildToPos(arg_2_0, var_2_1, cc.p(ClientView.SCR_CW, ClientView.SCR_H - 80), 5)

	-- Panel background
	local panelW = 520
	local panelH = 380
	local panelX = ClientView.SCR_CW
	local panelY = ClientView.SCR_CH - 20

	local var_2_2 = ccui.Scale9Sprite:createWithSpriteFrameName("img_com_bg_27", ClientView.CRECT_COM_BG27)
	var_2_2:setContentSize(cc.size(panelW, panelH))
	var_2_2:setOpacity(200)
	lc.addChildToPos(arg_2_0, var_2_2, cc.p(panelX, panelY), 2)

	arg_2_0._panelBg = var_2_2

	-- Mode tabs (Login / Register)
	local tabY = panelY + panelH / 2 - 30

	local var_2_3 = ClientView.createShaderButton("img_btn_tab_bg_focus_3", function()
		arg_2_0:switchMode(MODE_LOGIN)
	end)
	var_2_3:ignoreContentAdaptWithSize(false)
	var_2_3:setContentSize(cc.size(200, 50))
	var_2_3:addLabel(Str(STR.LOGIN) or "Đăng nhập", ClientView.COLOR_TEXT_LIGHT)
	lc.addChildToPos(arg_2_0, var_2_3, cc.p(panelX - 110, tabY), 3)
	arg_2_0._btnLogin = var_2_3

	local var_2_4 = ClientView.createShaderButton("img_btn_tab_bg_unfocus_3", function()
		arg_2_0:switchMode(MODE_REGISTER)
	end)
	var_2_4:ignoreContentAdaptWithSize(false)
	var_2_4:setContentSize(cc.size(200, 50))
	var_2_4:addLabel(Str(STR.REGISTER) or "Đăng ký", ClientView.COLOR_TEXT_LIGHT)
	lc.addChildToPos(arg_2_0, var_2_4, cc.p(panelX + 110, tabY), 3)
	arg_2_0._btnRegister = var_2_4

	-- Username field
	local fieldBaseY = tabY - 70

	local lblUser = cc.Label:createWithTTF("Tài khoản:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblUser:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_2_0, lblUser, cc.p(panelX - panelW/2 + 30, fieldBaseY), 3)

	local btnUser = ClientView.createScale9ShaderButton(nil, function()
		arg_2_0:showInput(0)
	end, cc.rect(1, 1, 1, 1), 300, 40)
	btnUser:setColor(cc.c3b(30, 30, 40))
	lc.addChildToPos(arg_2_0, btnUser, cc.p(panelX + 80, fieldBaseY), 3)
	arg_2_0._btnUser = btnUser

	local txtUser = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2)
	txtUser:setAnchorPoint(0, 0.5)
	lc.addChildToPos(btnUser, txtUser, cc.p(10, lc.ch(btnUser)), 1)
	arg_2_0._txtUser = txtUser

	-- Password field
	local fieldPassY = fieldBaseY - 60

	local lblPass = cc.Label:createWithTTF("Mật khẩu:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblPass:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_2_0, lblPass, cc.p(panelX - panelW/2 + 30, fieldPassY), 3)

	local btnPass = ClientView.createScale9ShaderButton(nil, function()
		arg_2_0:showInput(1)
	end, cc.rect(1, 1, 1, 1), 300, 40)
	btnPass:setColor(cc.c3b(30, 30, 40))
	lc.addChildToPos(arg_2_0, btnPass, cc.p(panelX + 80, fieldPassY), 3)
	arg_2_0._btnPass = btnPass

	local txtPass = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2)
	txtPass:setAnchorPoint(0, 0.5)
	lc.addChildToPos(btnPass, txtPass, cc.p(10, lc.ch(btnPass)), 1)
	arg_2_0._txtPass = txtPass

	-- Confirm password field (register only)
	local fieldConfirmY = fieldPassY - 60

	local lblConfirm = cc.Label:createWithTTF("Xác nhận MK:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblConfirm:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_2_0, lblConfirm, cc.p(panelX - panelW/2 + 30, fieldConfirmY), 3)
	arg_2_0._lblConfirm = lblConfirm

	local btnConfirm = ClientView.createScale9ShaderButton(nil, function()
		arg_2_0:showInput(2)
	end, cc.rect(1, 1, 1, 1), 300, 40)
	btnConfirm:setColor(cc.c3b(30, 30, 40))
	lc.addChildToPos(arg_2_0, btnConfirm, cc.p(panelX + 80, fieldConfirmY), 3)
	arg_2_0._btnConfirm = btnConfirm

	local txtConfirm = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2)
	txtConfirm:setAnchorPoint(0, 0.5)
	lc.addChildToPos(btnConfirm, txtConfirm, cc.p(10, lc.ch(btnConfirm)), 1)
	arg_2_0._txtConfirm = txtConfirm

	-- Hide confirm by default (login mode)
	arg_2_0._lblConfirm:setVisible(false)
	arg_2_0._btnConfirm:setVisible(false)

	-- Message label (errors, status)
	local msgY = fieldConfirmY - 50
	local lblMsg = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2)
	lblMsg:setColor(cc.c3b(255, 100, 100))
	lc.addChildToPos(arg_2_0, lblMsg, cc.p(panelX, msgY), 3)
	arg_2_0._lblMsg = lblMsg

	-- Submit button
	local submitY = msgY - 50
	-- The "start_button" frame in loading.plist has its caption painted into the
	-- image, so it can only ever say the Chinese it was drawn with. Use the
	-- standard green plate and give it a real label instead.
	local btnSubmit = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onSubmit()
	end, ClientView.CRECT_BUTTON_S, 260, 64)

	btnSubmit:addLabel(Str(STR.START))
	lc.addChildToPos(arg_2_0, btnSubmit, cc.p(panelX, submitY), 3)
	arg_2_0._btnSubmit = btnSubmit

	-- Version
	local var_2_5 = ClientView.createBMFont(ClientView.BMFont.huali_20, Str(STR.VERSION) .. ClientData.getDisplayVersion())
	var_2_5:setScale(0.8)
	lc.addChildToPos(arg_2_0, var_2_5, cc.p(ClientView.SCR_W - lc.cw(var_2_5) - ClientView.SCR_EDGE, 20), 2)

	return true
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)
	GuideManager.releaseLayer()
	lc.Audio.playAudio(AUDIO.M_LOADING)

	-- Load saved credentials if any
	local savedUser = lc.UserDefault:getStringForKey("LOGIN_USERNAME", "")
	if savedUser ~= "" then
		arg_3_0._username = savedUser
	end

	-- Show error from previous failed login attempt
	if ClientData._loginError and ClientData._loginError ~= "" then
		arg_3_0._message = ClientData._loginError
		ClientData._loginError = nil
	end

	arg_3_0:updateFields()
end

function var_0_0.onExit(arg_4_0)
	var_0_0.super.onExit(arg_4_0)
end

function var_0_0.onIdle(arg_5_0)
	lc.Director:updateTouchTimestamp()
end

function var_0_0.switchMode(arg_6_0, arg_6_1)
	arg_6_0._mode = arg_6_1
	arg_6_0._message = ""

	if arg_6_1 == MODE_LOGIN then
		arg_6_0._btnLogin:loadTextureNormal("img_btn_tab_bg_focus_3", ccui.TextureResType.plistType)
		arg_6_0._btnRegister:loadTextureNormal("img_btn_tab_bg_unfocus_3", ccui.TextureResType.plistType)
		arg_6_0._lblConfirm:setVisible(false)
		arg_6_0._btnConfirm:setVisible(false)
	else
		arg_6_0._btnLogin:loadTextureNormal("img_btn_tab_bg_unfocus_3", ccui.TextureResType.plistType)
		arg_6_0._btnRegister:loadTextureNormal("img_btn_tab_bg_focus_3", ccui.TextureResType.plistType)
		arg_6_0._lblConfirm:setVisible(true)
		arg_6_0._btnConfirm:setVisible(true)
	end

	arg_6_0:updateFields()
end

function var_0_0.showInput(arg_7_0, arg_7_1)
	local title, current, maxLen

	if arg_7_1 == 0 then
		title = "Tài khoản"
		current = arg_7_0._username
		maxLen = 20
	elseif arg_7_1 == 1 then
		title = "Mật khẩu"
		current = arg_7_0._password
		maxLen = 32
	elseif arg_7_1 == 2 then
		title = "Xác nhận mật khẩu"
		current = arg_7_0._confirmPass
		maxLen = 32
	end

	if lc.PLATFORM == cc.PLATFORM_OS_ANDROID or lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD then
		-- Use native input dialog
		lc.inputText(title, current, maxLen, function(result)
			if result then
				if arg_7_1 == 0 then
					arg_7_0._username = result
				elseif arg_7_1 == 1 then
					arg_7_0._password = result
				elseif arg_7_1 == 2 then
					arg_7_0._confirmPass = result
				end
				arg_7_0:updateFields()
			end
		end)
	else
		-- Windows: simple prompt via lc.inputBox if available, otherwise skip
		if lc.inputBox then
			local result = lc.inputBox(title, current)
			if result then
				if arg_7_1 == 0 then
					arg_7_0._username = result
				elseif arg_7_1 == 1 then
					arg_7_0._password = result
				elseif arg_7_1 == 2 then
					arg_7_0._confirmPass = result
				end
				arg_7_0:updateFields()
			end
		end
	end
end

function var_0_0.updateFields(arg_8_0)
	arg_8_0._txtUser:setString(arg_8_0._username ~= "" and arg_8_0._username or "(nhập tài khoản)")
	arg_8_0._txtUser:setColor(arg_8_0._username ~= "" and lc.Color3B.white or cc.c3b(128, 128, 128))

	local passDisplay = arg_8_0._password ~= "" and string.rep("*", #arg_8_0._password) or "(nhập mật khẩu)"
	arg_8_0._txtPass:setString(passDisplay)
	arg_8_0._txtPass:setColor(arg_8_0._password ~= "" and lc.Color3B.white or cc.c3b(128, 128, 128))

	local confirmDisplay = arg_8_0._confirmPass ~= "" and string.rep("*", #arg_8_0._confirmPass) or "(xác nhận MK)"
	arg_8_0._txtConfirm:setString(confirmDisplay)
	arg_8_0._txtConfirm:setColor(arg_8_0._confirmPass ~= "" and lc.Color3B.white or cc.c3b(128, 128, 128))

	arg_8_0._lblMsg:setString(arg_8_0._message)
end

function var_0_0.onSubmit(arg_9_0)
	-- Validate
	if arg_9_0._username == "" then
		arg_9_0._message = "Vui lòng nhập tài khoản!"
		arg_9_0:updateFields()
		return
	end

	if #arg_9_0._username < 3 or #arg_9_0._username > 20 then
		arg_9_0._message = "Tài khoản phải từ 3-20 ký tự!"
		arg_9_0:updateFields()
		return
	end

	if arg_9_0._password == "" then
		arg_9_0._message = "Vui lòng nhập mật khẩu!"
		arg_9_0:updateFields()
		return
	end

	if #arg_9_0._password < 4 then
		arg_9_0._message = "Mật khẩu phải ít nhất 4 ký tự!"
		arg_9_0:updateFields()
		return
	end

	if arg_9_0._mode == MODE_REGISTER then
		if arg_9_0._confirmPass == "" then
			arg_9_0._message = "Vui lòng xác nhận mật khẩu!"
			arg_9_0:updateFields()
			return
		end

		if arg_9_0._password ~= arg_9_0._confirmPass then
			arg_9_0._message = "Mật khẩu xác nhận không khớp!"
			arg_9_0:updateFields()
			return
		end
	end

	-- Save credentials to ClientData for the network flow
	ClientData._loginUsername = arg_9_0._username
	ClientData._loginPassword = arg_9_0._password
	ClientData._loginMode = arg_9_0._mode == MODE_REGISTER and "register" or "login"

	-- Save username locally for next time
	lc.UserDefault:setStringForKey("LOGIN_USERNAME", arg_9_0._username)
	lc.UserDefault:setStringForKey("LOGIN_HAS_ACCOUNT", "1")

	-- Proceed to region selection or loading
	ClientData.loadUserRegion()

	if ClientData.hasUserRegion() then
		lc.replaceScene(require("LoadingScene").create())
	else
		lc.replaceScene(require("RegionScene").create())
	end
end

return var_0_0
