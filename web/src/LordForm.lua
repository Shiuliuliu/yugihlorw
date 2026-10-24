local var_0_0 = class("LordForm", BaseForm)
local var_0_1 = cc.size(862, 642)
local var_0_4 = 170
local var_0_5 = 100

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)
	var_1_0:init()
	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local formW = lc.w(arg_2_0._form)
	local formH = lc.h(arg_2_0._form)

	-- Group tables for managing visibility of each tab's widgets
	arg_2_0._profileNodes = {}
	arg_2_0._graphicsNodes = {}
	arg_2_0._systemNodes = {}

	local function addNode(tabIndex, node, pos, zOrder)
		lc.addChildToPos(arg_2_0._form, node, pos, zOrder or 1)
		if tabIndex == 1 then
			table.insert(arg_2_0._profileNodes, node)
		elseif tabIndex == 2 then
			table.insert(arg_2_0._graphicsNodes, node)
		elseif tabIndex == 3 then
			table.insert(arg_2_0._systemNodes, node)
		end
		return node
	end

	-- =========================================================
	-- TOP NAVIGATION TABS (Inside form header at y = 582)
	-- =========================================================
	local tabDefs = {
		{ idx = 1, label = "Cá nhân",      width = 210, x = formW / 2 - 235 },
		{ idx = 2, label = "Đồ họa & FPS", width = 230, x = formW / 2 },
		{ idx = 3, label = "Hệ thống",     width = 210, x = formW / 2 + 235 }
	}

	arg_2_0._tabBtns = {}
	for _, tdef in ipairs(tabDefs) do
		local btn = ClientView.createScale9ShaderButton(tdef.idx == 1 and "img_btn_1_s" or "img_btn_2_s", function()
			arg_2_0:showTab(tdef.idx)
		end, ClientView.CRECT_BUTTON_S, tdef.width, 46)
		btn:addLabel(tdef.label)
		btn._label:setColor(tdef.idx == 1 and lc.Color3B.green or lc.Color3B.white)
		lc.addChildToPos(arg_2_0._form, btn, cc.p(tdef.x, 582), 10)
		arg_2_0._tabBtns[tdef.idx] = btn
	end

	-- Header divider line below tabs
	local headerLine = ClientView.createDividingLine(760, ClientView.COLOR_DIVIDING_LINE_LIGHT)
	lc.addChildToPos(arg_2_0._form, headerLine, cc.p(formW / 2, 545), 2)

	-- =========================================================
	-- TAB 1: CÁ NHÂN (PROFILE & CUSTOMIZATION)
	-- =========================================================
	local var_2_0 = UserWidget.create(P, UserWidget.Flag.NAME_UNION_VIP)
	var_2_0._unionArea._name:setColor(ClientView.COLOR_TEXT_ORANGE)
	addNode(1, var_2_0, cc.p(145, 475))
	arg_2_0._userAvatar = var_2_0

	local var_2_1 = lc.createSprite("img_icon_id")
	addNode(1, var_2_1, cc.p(260, 505))

	local var_2_2 = ClientView.createTTF(ClientData.convertId(P._id), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)
	addNode(1, var_2_2, cc.p(lc.right(var_2_1) + 8 + lc.w(var_2_2) / 2, lc.y(var_2_1) + 2))

	arg_2_0:updateLevelExpBar()

	-- VIP Privilege button
	if not ClientData.isAppStoreReviewing() then
		local var_vip = ClientView.createScale9ShaderButton("img_btn_3_s", function()
			arg_2_0:onShowVIP()
		end, ClientView.CRECT_BUTTON_S, 160, 44)
		var_vip:addLabel("VIP " .. Str(STR.PRIVILEGE))
		var_vip._label:setColor(ClientView.COLOR_TEXT_INGOT)
		addNode(1, var_vip, cc.p(715, 505))
		var_vip:setVisible(not ClientData.isHideCharge())
	end

	-- Change Character button
	local var_change_char = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onChangeCharacter()
	end, ClientView.CRECT_BUTTON_S, 160, 44)
	var_change_char:addLabel(Str(STR.CHANGE_CHARACTER))
	addNode(1, var_change_char, cc.p(715, 445))

	-- Divider 1
	local line1 = ClientView.createDividingLine(760, ClientView.COLOR_DIVIDING_LINE_LIGHT)
	addNode(1, line1, cc.p(formW / 2, 390))

	-- Customization Title
	local lblCustom = cc.Label:createWithTTF("TÙY BIẾN NHÂN VẬT & THẺ BÀI", ClientView.TTF_FONT, ClientView.FontSize.M1)
	lblCustom:setColor(ClientView.COLOR_TEXT_ORANGE)
	addNode(1, lblCustom, cc.p(formW / 2, 355))

	-- Row of 4 Customization Buttons at y = 295
	local y_cust = 295
	local btnName = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_2_0:onChangeName()
	end, ClientView.CRECT_BUTTON_S, 155, 46)
	btnName:addLabel("Sửa biệt hiệu")
	addNode(1, btnName, cc.p(140, y_cust))

	local btnAvatar = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_2_0:onChangeAvatar()
	end, ClientView.CRECT_BUTTON_S, 155, 46)
	btnAvatar:addLabel(Str(STR.CHANGE_ICON) or "Đổi Avatar")
	addNode(1, btnAvatar, cc.p(330, y_cust))

	local btnFrame = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_2_0:onChangeAvatarFrame()
	end, ClientView.CRECT_BUTTON_S, 155, 46)
	btnFrame:addLabel(Str(STR.CHANGE_RECT) or "Đổi Khung")
	addNode(1, btnFrame, cc.p(520, y_cust))

	local btnCardBack = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_2_0:onChangeCardBack()
	end, ClientView.CRECT_BUTTON_S, 155, 46)
	btnCardBack:addLabel(Str(STR.CHANGE_CARD_BACK) or "Đổi Mặt Lưng")
	addNode(1, btnCardBack, cc.p(710, y_cust))

	-- Divider 2
	local line2 = ClientView.createDividingLine(760, ClientView.COLOR_DIVIDING_LINE_LIGHT)
	addNode(1, line2, cc.p(formW / 2, 230))

	-- Bottom rewards row
	if not ClientData.isAppStoreReviewing() then
		local btnCode = ClientView.createScale9ShaderButton("img_btn_3_s", function()
			arg_2_0:onShowExchangeCode()
		end, ClientView.CRECT_BUTTON_S, 220, 50)
		btnCode:addLabel(Str(STR.EXCHANGE_CODE))
		btnCode._label:setColor(ClientView.COLOR_TEXT_INGOT)
		addNode(1, btnCode, cc.p(formW / 2 - 130, 145))

		local btnVipPriv = ClientView.createScale9ShaderButton("img_btn_3_s", function()
			arg_2_0:onShowVIP()
		end, ClientView.CRECT_BUTTON_S, 220, 50)
		btnVipPriv:addLabel("Đặc Quyền VIP")
		btnVipPriv._label:setColor(ClientView.COLOR_TEXT_INGOT)
		addNode(1, btnVipPriv, cc.p(formW / 2 + 130, 145))
		btnVipPriv:setVisible(not ClientData.isHideCharge())
	end

	if ClientData.isShowAgreement() then
		local btnAgree = ClientView.createScale9ShaderButton("img_btn_1_s", ClientView.openUserProtocol, ClientView.CRECT_BUTTON_S, 180, 40)
		btnAgree:addLabel(Str(STR.AGREEMENT))
		addNode(1, btnAgree, cc.p(formW / 2, 75))
	end

	-- =========================================================
	-- TAB 2: ĐỒ HỌA & FPS (5-STEP FPS + 3-STEP GRAPHICS + STATS)
	-- =========================================================
	local api = jsbridge and jsbridge.object("jdzcApi")
	local curFps = api and api.getFpsLimit and tonumber(api:getFpsLimit()) or 60
	local curQuality = api and api.getGraphicQuality and tonumber(api:getGraphicQuality()) or 3
	local isFpsShown = api and api.isDisplayFps and api:isDisplayFps() or false

	-- Section 1: FPS Limit
	local lblFpsTitle = cc.Label:createWithTTF("TỐC ĐỘ KHUNG HÌNH (FPS)", ClientView.TTF_FONT, ClientView.FontSize.M1)
	lblFpsTitle:setColor(ClientView.COLOR_TEXT_ORANGE)
	addNode(2, lblFpsTitle, cc.p(formW / 2, 510))

	local fpsOpts = {
		{ fps = 30,  label = "30 FPS" },
		{ fps = 60,  label = "60 FPS" },
		{ fps = 90,  label = "90 FPS" },
		{ fps = 120, label = "120 FPS" },
		{ fps = 0,   label = "Không giới hạn" }
	}

	arg_2_0._fpsBtns = {}
	local fpsX = { 127, 279, 431, 583, 735 }
	for idx, opt in ipairs(fpsOpts) do
		local isSel = (opt.fps == curFps)
		local btn = ClientView.createScale9ShaderButton(isSel and "img_btn_1_s" or "img_btn_2_s", function()
			arg_2_0:onSelectFps(opt.fps)
		end, ClientView.CRECT_BUTTON_S, 132, 46)
		btn:addLabel(opt.label)
		btn._label:setColor(isSel and lc.Color3B.green or lc.Color3B.white)
		addNode(2, btn, cc.p(fpsX[idx], 445))
		arg_2_0._fpsBtns[opt.fps] = btn
	end

	-- Divider FPS
	local lineFps = ClientView.createDividingLine(760, ClientView.COLOR_DIVIDING_LINE_LIGHT)
	addNode(2, lineFps, cc.p(formW / 2, 380))

	-- Section 2: Graphic Quality
	local lblQualTitle = cc.Label:createWithTTF("CHẤT LƯỢNG ĐỒ HỌA", ClientView.TTF_FONT, ClientView.FontSize.M1)
	lblQualTitle:setColor(ClientView.COLOR_TEXT_ORANGE)
	addNode(2, lblQualTitle, cc.p(formW / 2, 330))

	local qualOpts = {
		{ q = 1, label = "Nhanh" },
		{ q = 2, label = "Đẹp" },
		{ q = 3, label = "Tuyệt sắc" }
	}

	arg_2_0._qualBtns = {}
	local qualX = { 186, 431, 676 }
	for idx, opt in ipairs(qualOpts) do
		local isSel = (opt.q == curQuality)
		local btn = ClientView.createScale9ShaderButton(isSel and "img_btn_1_s" or "img_btn_2_s", function()
			arg_2_0:onSelectQuality(opt.q)
		end, ClientView.CRECT_BUTTON_S, 210, 48)
		btn:addLabel(opt.label)
		btn._label:setColor(isSel and lc.Color3B.green or lc.Color3B.white)
		addNode(2, btn, cc.p(qualX[idx], 265))
		arg_2_0._qualBtns[opt.q] = btn
	end

	-- Divider Quality
	local lineQual = ClientView.createDividingLine(760, ClientView.COLOR_DIVIDING_LINE_LIGHT)
	addNode(2, lineQual, cc.p(formW / 2, 200))

	-- Section 3: Display FPS counter
	local lblStats = cc.Label:createWithTTF("Hiển thị chỉ số FPS ở góc màn hình:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblStats:setColor(ClientView.COLOR_LABEL_LIGHT)
	addNode(2, lblStats, cc.p(320, 135))

	local btnStats = ClientView.createScale9ShaderButton(isFpsShown and "img_btn_1_s" or "img_btn_2_s", function(btnSelf)
		arg_2_0:onToggleDisplayFps(btnSelf)
	end, ClientView.CRECT_BUTTON_S, 130, 42)
	btnStats:addLabel(isFpsShown and "BẬT" or "TẮT")
	btnStats._label:setColor(isFpsShown and lc.Color3B.green or lc.Color3B.white)
	addNode(2, btnStats, cc.p(610, 135))
	arg_2_0._btnStats = btnStats

	-- =========================================================
	-- TAB 3: HỆ THỐNG (AUDIO, BATTLE SETTINGS, SERVER & ACCOUNT)
	-- =========================================================
	-- Row 1: Nhạc nền & Khóa vị trí at y = 495
	local lblMusic = cc.Label:createWithTTF(Str(STR.AUDIO_MUSIC) or "Nhạc nền", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblMusic:setColor(ClientView.COLOR_LABEL_LIGHT)
	addNode(3, lblMusic, cc.p(120, 495))

	local btnMusic = ClientView.createScale9ShaderButton(ClientData._isMusicOn and "img_btn_1_s" or "img_btn_2_s", function(btnSelf)
		arg_2_0:onSwitchMusic(btnSelf)
	end, ClientView.CRECT_BUTTON_S, 84, 40)
	btnMusic:addLabel(ClientData._isMusicOn and Str(STR.ON) or Str(STR.OFF))
	addNode(3, btnMusic, cc.p(220, 495))
	arg_2_0._btnMusic = btnMusic

	local sliderMusic = ClientView.createVolumeSlider(140, 22, ClientData.getMusicVolume(), function(val)
		ClientData.setMusicVolume(val)
		if val > 0 and not ClientData._isMusicOn then
			ClientData.toggleAudio(lc.Audio.Behavior.music, true)
			btnMusic._label:setString(Str(STR.ON))
			btnMusic:loadTextureNormal("img_btn_1_s", ccui.TextureResType.plistType)
		elseif val == 0 and ClientData._isMusicOn then
			ClientData.toggleAudio(lc.Audio.Behavior.music, false)
			btnMusic._label:setString(Str(STR.OFF))
			btnMusic:loadTextureNormal("img_btn_2_s", ccui.TextureResType.plistType)
		end
	end)
	addNode(3, sliderMusic, cc.p(375, 495))
	arg_2_0._sliderMusic = sliderMusic

	-- Battle setting: Khóa vị trí
	local lblPos = cc.Label:createWithTTF(Str(STR.POS_LABEL, true) or "Khóa vị trí thẻ:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblPos:setColor(ClientView.COLOR_LABEL_LIGHT)
	addNode(3, lblPos, cc.p(585, 495))

	local btnPos = ClientView.createScale9ShaderButton(ClientData._isPosOn and "img_btn_1_s" or "img_btn_2_s", function(btnSelf)
		arg_2_0:onSwitchPos(btnSelf)
	end, ClientView.CRECT_BUTTON_S, 84, 40)
	btnPos:addLabel(ClientData._isPosOn and Str(STR.ON) or Str(STR.OFF))
	addNode(3, btnPos, cc.p(710, 495))
	btnPos:setVisible(P:getMaxCharacterLevel() >= ClientData.POS_UNLOCK_LEVEL)
	lblPos:setVisible(btnPos:isVisible())

	-- Row 2: Hiệu ứng & Tự kết thúc lượt at y = 425
	local lblEffect = cc.Label:createWithTTF(Str(STR.AUDIO_EFFECT) or "Hiệu ứng", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblEffect:setColor(ClientView.COLOR_LABEL_LIGHT)
	addNode(3, lblEffect, cc.p(120, 425))

	local btnEffect = ClientView.createScale9ShaderButton(ClientData._isEffectOn and "img_btn_1_s" or "img_btn_2_s", function(btnSelf)
		arg_2_0:onSwitchEffect(btnSelf)
	end, ClientView.CRECT_BUTTON_S, 84, 40)
	btnEffect:addLabel(ClientData._isEffectOn and Str(STR.ON) or Str(STR.OFF))
	addNode(3, btnEffect, cc.p(220, 425))
	arg_2_0._btnEffect = btnEffect

	local sliderEffect = ClientView.createVolumeSlider(140, 22, ClientData.getEffectVolume(), function(val)
		ClientData.setEffectVolume(val)
		if val > 0 and not ClientData._isEffectOn then
			ClientData.toggleAudio(lc.Audio.Behavior.effect, true)
			btnEffect._label:setString(Str(STR.ON))
			btnEffect:loadTextureNormal("img_btn_1_s", ccui.TextureResType.plistType)
		elseif val == 0 and ClientData._isEffectOn then
			ClientData.toggleAudio(lc.Audio.Behavior.effect, false)
			btnEffect._label:setString(Str(STR.OFF))
			btnEffect:loadTextureNormal("img_btn_2_s", ccui.TextureResType.plistType)
		end
	end)
	addNode(3, sliderEffect, cc.p(375, 425))
	arg_2_0._sliderEffect = sliderEffect

	-- Battle setting: Tự kết thúc lượt
	local lblRound = cc.Label:createWithTTF(Str(STR.NEW_ROUND_LABEL, true) or "Tự kết thúc lượt:", ClientView.TTF_FONT, ClientView.FontSize.S1)
	lblRound:setColor(ClientView.COLOR_LABEL_LIGHT)
	addNode(3, lblRound, cc.p(585, 425))

	local btnRound = ClientView.createScale9ShaderButton(P._isNewRound and "img_btn_1_s" or "img_btn_2_s", function(btnSelf)
		arg_2_0:onSwitchRound(btnSelf)
	end, ClientView.CRECT_BUTTON_S, 84, 40)
	btnRound:addLabel(P._isNewRound and Str(STR.ON) or Str(STR.OFF))
	addNode(3, btnRound, cc.p(710, 425))

	-- Divider System 1
	local lineSys1 = ClientView.createDividingLine(760, ClientView.COLOR_DIVIDING_LINE_LIGHT)
	addNode(3, lineSys1, cc.p(formW / 2, 370))

	-- Section: Server & Account
	local lblSrvTitle = cc.Label:createWithTTF("MÁY CHỦ & TÀI KHOẢN", ClientView.TTF_FONT, ClientView.FontSize.M1)
	lblSrvTitle:setColor(ClientView.COLOR_TEXT_ORANGE)
	addNode(3, lblSrvTitle, cc.p(formW / 2, 335))

	local srvBg = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = ClientView.CRECT_COM_BG2,
		_size = cc.size(240, 44)
	})
	srvBg:setColor(lc.Color3B.black)
	srvBg:setOpacity(150)
	addNode(3, srvBg, cc.p(210, 275), 0)

	local curRegion = ClientData._userRegion or { _id = 1, _name = "S1 - Quyết Chiến Chi Thành" }
	local srvName = ClientView.createTTF(ClientData.genFullRegionName(curRegion._id, curRegion._name, true), ClientView.FontSize.S1)
	srvName:setScale(0.85)
	lc.addChildToCenter(srvBg, srvName)

	local btnChangeRegion = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onChangeRegion()
	end, ClientView.CRECT_BUTTON_S, 140, 44)
	btnChangeRegion:addLabel(Str(STR.CHANGE_REGION))
	addNode(3, btnChangeRegion, cc.p(420, 275))

	local btnLogout = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_2_0:onChangeUser()
	end, ClientView.CRECT_BUTTON_S, 160, 44)
	btnLogout:addLabel(Str(STR.CHANGE_USER))
	addNode(3, btnLogout, cc.p(640, 275))

	-- Divider System 2
	local lineSys2 = ClientView.createDividingLine(760, ClientView.COLOR_DIVIDING_LINE_LIGHT)
	addNode(3, lineSys2, cc.p(formW / 2, 215))

	-- Section: Help & Info
	local btnHelp = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onHelp()
	end, ClientView.CRECT_BUTTON_S, 210, 46)
	btnHelp:addLabel(Str(STR.HELP) or "Hướng dẫn luật chơi")
	addNode(3, btnHelp, cc.p(300, 155))

	local btnAbout = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onAbout()
	end, ClientView.CRECT_BUTTON_S, 210, 46)
	btnAbout:addLabel(Str(STR.ABOUT) or "Thông tin game")
	addNode(3, btnAbout, cc.p(560, 155))

	-- Version and copyright at bottom
	local lblVer = ClientView.createBMFont(ClientView.BMFont.huali_20, Str(STR.VERSION) .. ClientData.getDisplayVersion())
	lblVer:setScale(0.8)
	addNode(3, lblVer, cc.p(formW / 2, 85))

	local lblFanmade = cc.Label:createWithTTF("Dự án Fan-made phi thương mại · Yu-Gi-Oh! © Konami & Kazuki Takahashi", ClientView.TTF_FONT, ClientView.FontSize.S2)
	lblFanmade:setColor(ClientView.COLOR_LABEL_LIGHT)
	addNode(3, lblFanmade, cc.p(formW / 2, 55))

	-- Show Tab 1 initially
	arg_2_0:showTab(1)
end

function var_0_0.showTab(arg_self, tabIndex)
	arg_self._curTab = tabIndex

	for _, node in ipairs(arg_self._profileNodes or {}) do
		node:setVisible(tabIndex == 1)
	end
	for _, node in ipairs(arg_self._graphicsNodes or {}) do
		node:setVisible(tabIndex == 2)
	end
	for _, node in ipairs(arg_self._systemNodes or {}) do
		node:setVisible(tabIndex == 3)
	end

	-- Update Tab Button Styles
	for idx, btn in ipairs(arg_self._tabBtns or {}) do
		local isFocus = (idx == tabIndex)
		btn:loadTextureNormal(isFocus and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
		btn._label:setColor(isFocus and lc.Color3B.green or lc.Color3B.white)
	end
end

-- =========================================================
-- GRAPHICS & FPS CONTROLS
-- =========================================================

function var_0_0.onSelectFps(arg_self, fps)
	local api = jsbridge and jsbridge.object("jdzcApi")
	if api and api.setFpsLimit then
		api:setFpsLimit(fps)
	end

	for val, btn in pairs(arg_self._fpsBtns or {}) do
		local isSel = (val == fps)
		btn:loadTextureNormal(isSel and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
		btn._label:setColor(isSel and lc.Color3B.green or lc.Color3B.white)
	end

	local msg = (fps == 0) and "Đã mở khóa FPS không giới hạn!" or ("Đã cài đặt tốc độ khung hình: " .. fps .. " FPS")
	ToastManager.push(msg)
end

function var_0_0.onSelectQuality(arg_self, quality)
	local api = jsbridge and jsbridge.object("jdzcApi")
	if api and api.setGraphicQuality then
		api:setGraphicQuality(quality)
	end

	for val, btn in pairs(arg_self._qualBtns or {}) do
		local isSel = (val == quality)
		btn:loadTextureNormal(isSel and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
		btn._label:setColor(isSel and lc.Color3B.green or lc.Color3B.white)
	end

	local names = { [1] = "Nhanh (1.0x)", [2] = "Đẹp (1.5x)", [3] = "Tuyệt sắc (2.0x Retina)" }
	ToastManager.push("Đã chọn chất lượng hình ảnh: " .. (names[quality] or "Tuyệt sắc"))
end

function var_0_0.onToggleDisplayFps(arg_self, btn)
	local api = jsbridge and jsbridge.object("jdzcApi")
	local curState = api and api.isDisplayFps and api:isDisplayFps() or false
	local newState = not curState

	if api and api.toggleDisplayFps then
		api:toggleDisplayFps(newState)
	end

	btn:loadTextureNormal(newState and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
	btn._label:setString(newState and "BẬT" or "TẮT")
	btn._label:setColor(newState and lc.Color3B.green or lc.Color3B.white)

	ToastManager.push(newState and "Đã bật hiển thị chỉ số FPS" or "Đã tắt hiển thị chỉ số FPS")
end

-- =========================================================
-- PROFILE & SYSTEM CONTROLS
-- =========================================================

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

function var_0_0.onSwitchMusic(arg_45_0, arg_45_1)
	ClientData.toggleAudio(lc.Audio.Behavior.music, not ClientData._isMusicOn)
	arg_45_1._label:setString(ClientData._isMusicOn and Str(STR.ON) or Str(STR.OFF))
	arg_45_1:loadTextureNormal(ClientData._isMusicOn and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
	arg_45_1:setContentSize(cc.size(84, ClientView.CRECT_BUTTON_S.height))
	if arg_45_0._sliderMusic then
		arg_45_0._sliderMusic:setValue(ClientData._isMusicOn and ClientData.getMusicVolume() or 0)
	end
end

function var_0_0.onSwitchEffect(arg_46_0, arg_46_1)
	ClientData.toggleAudio(lc.Audio.Behavior.effect, not ClientData._isEffectOn)
	arg_46_1._label:setString(ClientData._isEffectOn and Str(STR.ON) or Str(STR.OFF))
	arg_46_1:loadTextureNormal(ClientData._isEffectOn and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
	arg_46_1:setContentSize(cc.size(84, ClientView.CRECT_BUTTON_S.height))
	if arg_46_0._sliderEffect then
		arg_46_0._sliderEffect:setValue(ClientData._isEffectOn and ClientData.getEffectVolume() or 0)
	end
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

function var_0_0.onAbout(arg_51_0)
	require("AboutForm").create():show()
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

function var_0_0.updateLevelExpBar(arg_57_0)
	if arg_57_0._levelExpBar ~= nil then
		arg_57_0._levelExpBar:removeFromParent()
	end

	local var_57_0 = P._characters[P:getCharacterId()]
	local var_57_1 = ClientView.createLevelExpBar(var_57_0._level, var_57_0._exp, P:getLevelupExp(var_57_0._level), 310)

	if var_57_0._level >= P:getMaxLevel(P:getCharacterId()) then
		var_57_1._label:setString(Str(STR.MAX_LEVEL))
	end

	lc.addChildToPos(arg_57_0._form, var_57_1, cc.p(lc.left(arg_57_0._userAvatar) + lc.cw(var_57_1) + 160, lc.bottom(arg_57_0._userAvatar) - 25))

	arg_57_0._levelExpBar = var_57_1
	table.insert(arg_57_0._profileNodes, var_57_1)

	local var_57_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(Data._characterInfo[var_57_0._id]._nameSid))
	var_57_2:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_57_1, var_57_2, cc.p(-160, lc.ch(var_57_1)))

	if arg_57_0._curTab and arg_57_0._curTab ~= 1 then
		var_57_1:setVisible(false)
	end
end

return var_0_0
