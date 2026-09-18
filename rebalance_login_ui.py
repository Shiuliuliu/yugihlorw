"""
Patch RegionScene in lua_src.json with perfected UI geometry and clean inputs.
"""
import json, sys, io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

LUA_PATH = r'D:\yugitauapk\web\lua_src.json'
with open(LUA_PATH, 'r', encoding='utf-8') as f:
    lua_data = json.load(f)

region_src = lua_data['RegionScene']

s_idx = region_src.find('local loginLayer = lc.createNode')
e_idx = region_src.find('-- ====== REGION UI (hidden until login done) ======')

if s_idx == -1 or e_idx == -1:
    print('ERROR: bounds for loginLayer in RegionScene not found!')
    sys.exit(1)

new_login_layer = '''local loginLayer = lc.createNode(cc.size(lc.w(arg_2_0), lc.h(arg_2_0)))
	lc.addChildToCenter(arg_2_0, loginLayer, 5)
	arg_2_0._loginLayer = loginLayer

	-- Dim backdrop behind dialog
	local overlay = cc.LayerColor:create(cc.c4b(0, 0, 0, 190))
	loginLayer:addChild(overlay, 0)

	-- Dialog Window Frame (600 x 440) - beautifully proportioned
	local dialogW, dialogH = 600, 440
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
	local tabY = ClientView.SCR_CH + 138
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
	local editW, editH = 280, 44

	-- Row 1: Username
	local row1Y = ClientView.SCR_CH + 72
	local lblUser = cc.Label:createWithTTF("Tài khoản:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblUser:setAnchorPoint(1, 0.5)
	lblUser:setColor(cc.c3b(245, 225, 170))
	lc.addChildToPos(loginLayer, lblUser, cc.p(labelX, row1Y), 2)

	local editUser = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(editW, editH), "Nhập tên tài khoản", true, 20)
	editUser:setFontColor(lc.Color4B.white)
	lc.addChildToPos(loginLayer, editUser, cc.p(editX, row1Y), 2)
	arg_2_0._editUser = editUser

	-- Row 2: Password
	local row2Y = ClientView.SCR_CH + 16
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
	local row3Y = ClientView.SCR_CH - 40
	local lblConfirm = cc.Label:createWithTTF("Xác nhận:", ClientView.TTF_FONT, ClientView.FontSize.S1)
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

	-- Message / Error label
	local lblMsg = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2)
	lblMsg:setColor(cc.c3b(255, 90, 80))
	lc.addChildToPos(loginLayer, lblMsg, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 72), 2)
	arg_2_0._lblLoginMsg = lblMsg

	-- Skip Tutorial checkbox
	arg_2_0._skipTutorial = true
	local skipBox = cc.Label:createWithTTF("[X] Bỏ qua hướng dẫn tân thủ", ClientView.TTF_FONT, ClientView.FontSize.S2)
	skipBox:setColor(lc.Color3B.green)
	lc.addChildToPos(loginLayer, skipBox, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 100), 2)
	arg_2_0._skipBoxLabel = skipBox

	local skipBtn = ClientView.createShaderButton("load_region_bg", function()
		arg_2_0._skipTutorial = not arg_2_0._skipTutorial
		if arg_2_0._skipTutorial then
			arg_2_0._skipBoxLabel:setString("[X] Bỏ qua hướng dẫn tân thủ")
			arg_2_0._skipBoxLabel:setColor(lc.Color3B.green)
		else
			arg_2_0._skipBoxLabel:setString("[ ] Bỏ qua hướng dẫn tân thủ")
			arg_2_0._skipBoxLabel:setColor(lc.Color3B.white)
		end
	end)
	skipBtn:setContentSize(250, 32)
	skipBtn:setOpacity(0)
	lc.addChildToPos(loginLayer, skipBtn, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 100), 3)

	-- Submit Button (Centered, solid green button)
	local btnSubmit = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onLoginSubmit()
	end, ClientView.CRECT_BUTTON_S, 250, 58)
	btnSubmit:addLabel(Str(STR.START))
	lc.addChildToPos(loginLayer, btnSubmit, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 156), 2)
	arg_2_0._btnLoginSubmit = btnSubmit

	arg_2_0:updateLoginFields()

	-- Pre-fill saved username
	local savedUser = lc.UserDefault:getStringForKey("LOGIN_USERNAME", "")
	if savedUser ~= "" then
		arg_2_0._editUser:setText(savedUser)
	end

	'''

region_src = region_src[:s_idx] + new_login_layer + region_src[e_idx:]
lua_data['RegionScene'] = region_src

with open(LUA_PATH, 'w', encoding='utf-8') as f:
    json.dump(lua_data, f, ensure_ascii=False, separators=(',', ':'))

print('✓ RegionScene updated with balanced UI layout!')
