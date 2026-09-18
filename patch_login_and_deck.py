"""
Patch lua_src.json and index.html:
1. RegionScene: Rebuild loginLayer as an authentic in-game dialog popup using ClientView.createFrameBox and img_form_title_bg_2.
2. h5_patch.lua: Hook ClientData.saveTroops and ClientData.sendTroops to automatically call jdzcApi:saveDeck so any deck changes in game are linked & persisted to MySQL user_decks.
3. index.html: Bump version to force reload.
"""
import json, sys, io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

LUA_PATH = r'D:\yugitauapk\web\lua_src.json'
with open(LUA_PATH, 'r', encoding='utf-8') as f:
    lua_data = json.load(f)

# =========================================================================
# 1. PATCH RegionScene (Login Dialog)
# =========================================================================
region_src = lua_data['RegionScene']

# Find loginLayer creation and replace it up to the start of REGION UI
s_idx = region_src.find('local loginLayer = lc.createNode')
e_idx = region_src.find('-- ====== REGION UI (hidden until login done) ======')

if s_idx == -1 or e_idx == -1:
    print('ERROR: bounds for loginLayer in RegionScene not found!')
    sys.exit(1)

new_login_layer = '''local loginLayer = lc.createNode(cc.size(lc.w(arg_2_0), lc.h(arg_2_0)))
	lc.addChildToCenter(arg_2_0, loginLayer, 5)
	arg_2_0._loginLayer = loginLayer

	-- Dim backdrop behind dialog
	local overlay = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
	loginLayer:addChild(overlay, 0)

	-- Dialog Window Frame using official game asset
	local dialogW, dialogH = 560, 430
	local frameBox = ClientView.createFrameBox(cc.size(dialogW, dialogH))
	lc.addChildToPos(loginLayer, frameBox, cc.p(ClientView.SCR_CW, ClientView.SCR_CH), 1)
	arg_2_0._loginFrameBox = frameBox

	-- Title banner mounted at the top of dialog frame
	local titleBg = ccui.Scale9Sprite:createWithSpriteFrameName("img_form_title_bg_2", ClientView.CRECT_FORM_TITLE_BG2)
	titleBg:setContentSize(dialogW - 100, 54)
	lc.addChildToPos(loginLayer, titleBg, cc.p(ClientView.SCR_CW, ClientView.SCR_CH + dialogH / 2 - 4), 3)

	local lblTitle = cc.Label:createWithTTF("ĐĂNG NHẬP", ClientView.TTF_FONT, ClientView.FontSize.B2)
	lblTitle:setColor(cc.c3b(255, 230, 80))
	lc.addChildToCenter(titleBg, lblTitle)
	arg_2_0._lblLoginTitle = lblTitle

	-- Mode Tabs (Đăng nhập / Đăng ký)
	local tabY = ClientView.SCR_CH + 130
	local tabLoginBtn = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:setLoginMode(1)
	end, ClientView.CRECT_BUTTON_S, 140, 42)
	lc.addChildToPos(loginLayer, tabLoginBtn, cc.p(ClientView.SCR_CW - 85, tabY), 2)
	local tabLoginLbl = cc.Label:createWithTTF("Đăng nhập", ClientView.TTF_FONT, ClientView.FontSize.S1)
	tabLoginLbl:setColor(lc.Color3B.white)
	lc.addChildToCenter(tabLoginBtn, tabLoginLbl)
	arg_2_0._tabLoginBtn = tabLoginBtn
	arg_2_0._tabLoginLbl = tabLoginLbl

	local tabRegBtn = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_2_0:setLoginMode(2)
	end, ClientView.CRECT_BUTTON_S, 140, 42)
	lc.addChildToPos(loginLayer, tabRegBtn, cc.p(ClientView.SCR_CW + 85, tabY), 2)
	local tabRegLbl = cc.Label:createWithTTF("Đăng ký", ClientView.TTF_FONT, ClientView.FontSize.S1)
	tabRegLbl:setColor(lc.Color3B.white)
	lc.addChildToCenter(tabRegBtn, tabRegLbl)
	arg_2_0._tabRegBtn = tabRegBtn
	arg_2_0._tabRegLbl = tabRegLbl

	-- Username input row
	local rowY = ClientView.SCR_CH + 65
	local lblUser = cc.Label:createWithTTF("Tài khoản:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblUser:setAnchorPoint(1, 0.5)
	lblUser:setColor(cc.c3b(230, 230, 240))
	lc.addChildToPos(loginLayer, lblUser, cc.p(ClientView.SCR_CW - 130, rowY), 2)

	local editUser = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(270, 44), "Nhập tài khoản", true, 20)
	editUser:setFontColor(lc.Color4B.white)
	lc.addChildToPos(loginLayer, editUser, cc.p(ClientView.SCR_CW + 35, rowY), 2)
	arg_2_0._editUser = editUser

	-- Password input row
	rowY = ClientView.SCR_CH + 10
	local lblPass = cc.Label:createWithTTF("Mật khẩu:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblPass:setAnchorPoint(1, 0.5)
	lblPass:setColor(cc.c3b(230, 230, 240))
	lc.addChildToPos(loginLayer, lblPass, cc.p(ClientView.SCR_CW - 130, rowY), 2)

	local editPass = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(270, 44), "Nhập mật khẩu", true, 32)
	editPass:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
	editPass:setFontColor(lc.Color4B.white)
	lc.addChildToPos(loginLayer, editPass, cc.p(ClientView.SCR_CW + 35, rowY), 2)
	arg_2_0._editPass = editPass

	-- Confirm password row (register only)
	rowY = ClientView.SCR_CH - 45
	local lblConfirm = cc.Label:createWithTTF("Xác nhận:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblConfirm:setAnchorPoint(1, 0.5)
	lblConfirm:setColor(cc.c3b(230, 230, 240))
	lc.addChildToPos(loginLayer, lblConfirm, cc.p(ClientView.SCR_CW - 130, rowY), 2)
	arg_2_0._lblConfirm = lblConfirm

	local editConfirm = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(270, 44), "Nhập lại mật khẩu", true, 32)
	editConfirm:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
	editConfirm:setFontColor(lc.Color4B.white)
	lc.addChildToPos(loginLayer, editConfirm, cc.p(ClientView.SCR_CW + 35, rowY), 2)
	arg_2_0._editConfirm = editConfirm

	arg_2_0._lblConfirm:setVisible(false)
	arg_2_0._editConfirm:setVisible(false)

	-- Message label
	local lblMsg = cc.Label:createWithTTF("", ClientView.TTF_FONT, ClientView.FontSize.S2)
	lblMsg:setColor(cc.c3b(255, 90, 90))
	lc.addChildToPos(loginLayer, lblMsg, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 78), 2)
	arg_2_0._lblLoginMsg = lblMsg

	-- Skip Tutorial checkbox
	arg_2_0._skipTutorial = true
	local skipBox = cc.Label:createWithTTF("[X] Bỏ qua hướng dẫn tân thủ", ClientView.TTF_FONT, ClientView.FontSize.S2)
	skipBox:setColor(lc.Color3B.green)
	lc.addChildToPos(loginLayer, skipBox, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 105), 2)
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
	lc.addChildToPos(loginLayer, skipBtn, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 105), 3)

	-- Submit button (authentic green game button)
	local btnSubmit = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onLoginSubmit()
	end, ClientView.CRECT_BUTTON_S, 230, 56)
	btnSubmit:addLabel(Str(STR.START))
	lc.addChildToPos(loginLayer, btnSubmit, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 155), 2)
	arg_2_0._btnLoginSubmit = btnSubmit

	arg_2_0:updateLoginFields()

	-- Pre-fill saved username
	local savedUser = lc.UserDefault:getStringForKey("LOGIN_USERNAME", "")
	if savedUser ~= "" then
		arg_2_0._editUser:setText(savedUser)
	end

	'''

region_src = region_src[:s_idx] + new_login_layer + region_src[e_idx:]

# Also update setLoginMode in RegionScene to adjust button frames & labels
old_setmode = 'function var_0_1.setLoginMode(arg_lm_0, arg_lm_1)'
new_setmode = '''function var_0_1.setLoginMode(arg_lm_0, arg_lm_1)
	arg_lm_0._loginMode = arg_lm_1
	arg_lm_0._loginMsg = ""

	if arg_lm_1 == 1 then
		arg_lm_0._lblLoginTitle:setString("ĐĂNG NHẬP")
		arg_lm_0._tabLoginBtn:setSpriteFrameName("img_btn_1_s")
		arg_lm_0._tabRegBtn:setSpriteFrameName("img_btn_2_s")
		arg_lm_0._btnLoginSubmit._label:setString("BẮT ĐẦU")
		arg_lm_0._lblConfirm:setVisible(false)
		arg_lm_0._editConfirm:setVisible(false)
	else
		arg_lm_0._lblLoginTitle:setString("ĐĂNG KÝ")
		arg_lm_0._tabLoginBtn:setSpriteFrameName("img_btn_2_s")
		arg_lm_0._tabRegBtn:setSpriteFrameName("img_btn_1_s")
		arg_lm_0._btnLoginSubmit._label:setString("ĐĂNG KÝ NGAY")
		arg_lm_0._lblConfirm:setVisible(true)
		arg_lm_0._editConfirm:setVisible(true)
	end
	arg_lm_0:updateLoginFields()
end'''

old_setmode_end = region_src.find('function var_0_1.updateLoginFields')
setmode_start = region_src.find(old_setmode)
if setmode_start != -1 and old_setmode_end != -1:
    region_src = region_src[:setmode_start] + new_setmode + '\n\n' + region_src[old_setmode_end:]

lua_data['RegionScene'] = region_src
print('✓ RegionScene login dialog updated successfully!')

# =========================================================================
# 2. PATCH h5_patch.lua (Deck Sync / Save Hook)
# =========================================================================
h5_src = lua_data.get('h5_patch', '')

# Check if deck sync hook is already installed
if 'SYNC_DECK_TO_WEB' not in h5_src:
    # Insert deck sync hook into patchClientData
    target_needle = 'function patchClientData()'
    deck_hook_code = '''
-- SYNC_DECK_TO_WEB: Save deck changes directly to MySQL via jdzcApi:saveDeck
local function syncPlayerDecksToWeb()
	if not (P and P._playerCard and P._playerCard._troops) then return end
	local accId = ClientData._account and ClientData._account.id or 1
	local api = jsbridge and jsbridge.object("jdzcApi")
	if not (api and api.saveDeck) then return end

	local jsonMod = require("json")
	for slot = 1, 5 do
		local troop = P._playerCard._troops[slot]
		if troop and #troop > 0 then
			local cards = {}
			local extra = {}
			for _, item in ipairs(troop) do
				local cid = type(item) == "table" and (item._infoId or item.info_id) or item
				if cid and cid > 0 then
					local ctype = Data.getType(cid)
					if ctype == Data.CardType.rare then
						table.insert(extra, cid)
					else
						table.insert(cards, cid)
					end
				end
			end
			local cStr = jsonMod.encode(cards)
			local eStr = jsonMod.encode(extra)
			api:saveDeck(accId, slot, "Bộ Bài " .. tostring(slot), cStr, eStr)
		end
	end
end
'''
    insert_pos = h5_src.find(target_needle)
    if insert_pos != -1:
        h5_src = h5_src[:insert_pos] + deck_hook_code + '\n' + h5_src[insert_pos:]

    # Hook ClientData.saveTroops and ClientData.sendTroops in patchClientData
    target_in_patch = 'ClientData._lotteryWeekPower = tonumber(ClientData._lotteryWeekPower) or 0'
    hook_install = '''ClientData._lotteryWeekPower = tonumber(ClientData._lotteryWeekPower) or 0

	-- Auto sync deck to web server on troop save
	local _origSaveTroops = ClientData.saveTroops
	ClientData.saveTroops = function(...)
		local ret = _origSaveTroops and _origSaveTroops(...)
		pcall(syncPlayerDecksToWeb)
		return ret
	end

	local _origSendTroops = ClientData.sendTroops
	ClientData.sendTroops = function(...)
		pcall(syncPlayerDecksToWeb)
		if _origSendTroops then return _origSendTroops(...) end
	end
'''
    h5_src = h5_src.replace(target_in_patch, hook_install, 1)
    lua_data['h5_patch'] = h5_src
    print('✓ h5_patch deck sync hooks installed successfully!')
else:
    print('ℹ Deck sync hook already in h5_patch')

# Save lua_src.json
with open(LUA_PATH, 'w', encoding='utf-8') as f:
    json.dump(lua_data, f, ensure_ascii=False, separators=(',', ':'))
print('✓ lua_src.json saved!')

# =========================================================================
# 3. BUMP VERSION in index.html
# =========================================================================
INDEX_PATH = r'D:\yugitauapk\web\index.html'
with open(INDEX_PATH, 'r', encoding='utf-8') as f:
    html = f.read()

# Replace version to 20260912c
import re
html = re.sub(r'version:\s*[\'"][^\'"]+[\'"]', "version: '20260912c'", html)

with open(INDEX_PATH, 'w', encoding='utf-8') as f:
    f.write(html)
print('✓ index.html version bumped to 20260912c!')
