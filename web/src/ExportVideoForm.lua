local var_0_0 = class("ExportVideoForm", BaseForm)
local var_0_1 = cc.size(720, 500)

function var_0_0.create(battleUi, log)
	local form = var_0_0.new(lc.EXTEND_LAYOUT_MASK)
	form:init(battleUi, log)
	return form
end

function var_0_0.init(arg_2_0, battleUi, log)
	var_0_0.super.init(arg_2_0, var_0_1, "Tải Video Trận Đấu", bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._battleUi = battleUi
	arg_2_0._log = log
	arg_2_0._selectedFps = 60
	arg_2_0._selectedPerspective = 1 -- 1: Bạn, 2: Đối thủ

	local formW = lc.w(arg_2_0._form)
	local formH = lc.h(arg_2_0._form)

	-- Output description banner
	local descLabel = ClientView.createTTF("Đầu ra: Video định dạng MP4 chất lượng cao (60 / 90 / 120 / 200 FPS)", ClientView.FontSize.S2)
	descLabel:setColor(cc.c3b(255, 220, 100))
	descLabel:setPosition(formW / 2, formH - var_0_0.TOP_MARGIN - 40)
	arg_2_0._form:addChild(descLabel)

	-- FPS Section
	local fpsHeader = ClientView.createTTF("Tốc độ khung hình (FPS):", ClientView.FontSize.M2)
	fpsHeader:setAnchorPoint(0, 0.5)
	fpsHeader:setPosition(55, formH - var_0_0.TOP_MARGIN - 80)
	arg_2_0._form:addChild(fpsHeader)

	local fpsList = { 60, 90, 120, 200 }
	arg_2_0._fpsButtons = {}

	local fpsStartX = 125
	local fpsGapX = 155
	local fpsY = formH - var_0_0.TOP_MARGIN - 135

	for i, fps in ipairs(fpsList) do
		local btn = ClientView.createScale9ShaderButton(fps == 60 and "img_btn_1_s" or "img_btn_2_s", function()
			arg_2_0:onSelectFps(fps)
		end, ClientView.CRECT_BUTTON_S, 135, 52)

		btn:addLabel(string.format("%d FPS", fps))
		btn:setPosition(fpsStartX + (i - 1) * fpsGapX, fpsY)
		arg_2_0._form:addChild(btn)

		table.insert(arg_2_0._fpsButtons, { _fps = fps, _btn = btn })
	end

	-- Perspective Section
	local persHeader = ClientView.createTTF("Chọn góc nhìn người chơi:", ClientView.FontSize.M2)
	persHeader:setAnchorPoint(0, 0.5)
	persHeader:setPosition(55, fpsY - 55)
	arg_2_0._form:addChild(persHeader)

	local persY = persHeader:getPositionY() - 55

	local btnPlayer = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onSelectPerspective(1)
	end, ClientView.CRECT_BUTTON_S, 270, 52)
	btnPlayer:addLabel("Góc nhìn của bạn")
	btnPlayer:setPosition(formW / 2 - 150, persY)
	arg_2_0._form:addChild(btnPlayer)
	arg_2_0._btnPlayerView = btnPlayer

	local btnOpponent = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_2_0:onSelectPerspective(2)
	end, ClientView.CRECT_BUTTON_S, 270, 52)
	btnOpponent:addLabel("Góc nhìn đối thủ")
	btnOpponent:setPosition(formW / 2 + 150, persY)
	arg_2_0._form:addChild(btnOpponent)
	arg_2_0._btnOpponentView = btnOpponent

	-- Action buttons: Cancel & Confirm
	local bottomY = var_0_0.FRAME_THICK_BOTTOM + 32 + 26

	local btnCancel = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON_S, 180, 52)
	btnCancel:addLabel("Hủy bỏ")
	btnCancel:setPosition(formW / 2 - 140, bottomY)
	arg_2_0._form:addChild(btnCancel)

	local btnConfirm = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onConfirm()
	end, ClientView.CRECT_BUTTON_S, 260, 52)
	btnConfirm:addLabel("Bắt đầu tải về MP4")
	btnConfirm:setPosition(formW / 2 + 130, bottomY)
	arg_2_0._form:addChild(btnConfirm)

	arg_2_0:updateFpsUi()
	arg_2_0:updatePerspectiveUi()
end

function var_0_0.onSelectFps(arg_3_0, fps)
	arg_3_0._selectedFps = fps
	arg_3_0:updateFpsUi()
end

function var_0_0.updateFpsUi(arg_4_0)
	for _, item in ipairs(arg_4_0._fpsButtons) do
		local isSel = (item._fps == arg_4_0._selectedFps)
		item._btn:loadTextureNormal(isSel and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
		if item._btn._title then
			item._btn._title:setColor(isSel and cc.c3b(255, 230, 80) or cc.c3b(220, 220, 220))
		end
		item._btn:setColor(isSel and cc.c3b(255, 255, 255) or cc.c3b(180, 180, 180))
	end
end

function var_0_0.onSelectPerspective(arg_5_0, val)
	arg_5_0._selectedPerspective = val
	arg_5_0:updatePerspectiveUi()
end

function var_0_0.updatePerspectiveUi(arg_6_0)
	local isPlayer = (arg_6_0._selectedPerspective == 1)
	arg_6_0._btnPlayerView:loadTextureNormal(isPlayer and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
	arg_6_0._btnPlayerView:setColor(isPlayer and cc.c3b(255, 255, 255) or cc.c3b(180, 180, 180))
	if arg_6_0._btnPlayerView._title then
		arg_6_0._btnPlayerView._title:setColor(isPlayer and cc.c3b(255, 230, 80) or cc.c3b(220, 220, 220))
	end

	arg_6_0._btnOpponentView:loadTextureNormal(not isPlayer and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
	arg_6_0._btnOpponentView:setColor(not isPlayer and cc.c3b(255, 255, 255) or cc.c3b(180, 180, 180))
	if arg_6_0._btnOpponentView._title then
		arg_6_0._btnOpponentView._title:setColor(not isPlayer and cc.c3b(255, 230, 80) or cc.c3b(220, 220, 220))
	end
end

function var_0_0.onConfirm(arg_7_0)
	local fps = arg_7_0._selectedFps or 60
	local isOpponent = (arg_7_0._selectedPerspective == 2)
	local log = arg_7_0._log
	local repId = (log and (log._replayId or log._id)) or tostring(os.time())
	local fname = string.format("YGO_Replay_%s_%dfps.mp4", tostring(repId), fps)

	arg_7_0:hide()

	if arg_7_0._battleUi then
		local bUi = arg_7_0._battleUi
		local curOpp = (bUi._opponentUi and bUi._opponentUi._isController) or false
		if isOpponent ~= curOpp then
			bUi:onSwitchView()
		end

		local vr = jsbridge and jsbridge.object("jdzcVideoRecorder")
		if vr and vr.startRecord then
			vr:startRecord(fps, fname)
			bUi:showRecordingHud(fps)
			ToastManager.push(string.format("Bắt đầu ghi hình video MP4 (%d FPS)!", fps))
		else
			ToastManager.push("Trình duyệt không hỗ trợ MediaRecorder video/mp4!")
		end
	else
		if not log or not log._replayId then
			ToastManager.push("Không tìm thấy dữ liệu replay!")
			return
		end
		ClientData._recordVideoConfig = {
			fps = fps,
			isOpponent = isOpponent,
			filename = fname
		}
		ClientData.sendBattleReplay(log._replayId)
		ToastManager.push(string.format("Đang tải trận đấu và chuẩn bị xuất MP4 (%d FPS)...", fps))
	end
end

return var_0_0
