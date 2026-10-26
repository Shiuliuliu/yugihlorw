local var_0_0 = class("PasteDeckForm", BaseForm)
local var_0_1 = cc.size(760, 420)

function var_0_0.create(scene, troopIndex)
	local form = var_0_0.new(lc.EXTEND_LAYOUT_MASK)
	form:init(scene, troopIndex)
	return form
end

function var_0_0.init(arg_2_0, scene, troopIndex)
	var_0_0.super.init(arg_2_0, var_0_1, "Dán bộ bài (Deck)", bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._scene = scene
	arg_2_0._troopIndex = troopIndex or (scene and scene._curTroopIndex) or P._curTroopIndex or 1

	local formW = lc.w(arg_2_0._form)
	local formH = lc.h(arg_2_0._form)

	-- Instruction label
	local label = ClientView.createTTF("Dán mã bộ bài (YGODECK://...) hoặc danh sách ID vào bên dưới:\n(Hệ thống sẽ tự động dán tối đa số lá bạn đang sở hữu cả Main & Extra Deck)", ClientView.FontSize.S2)
	label:setPosition(formW / 2, formH - var_0_0.TOP_MARGIN - 65)
	arg_2_0._form:addChild(label)

	-- EditBox
	local editSize = cc.size(620, 64)
	local editBox = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, editSize, "Nhập hoặc dán mã bộ bài...", true)
	editBox:setPosition(formW / 2, lc.bottom(label) - editSize.height / 2 - 20)
	arg_2_0._form:addChild(editBox)

	arg_2_0._editor = editBox

	-- Pre-fill with clipboard if available
	local DeckHelper = require("DeckCodeHelper")
	local initialClipboard = DeckHelper.getClipboardText()
	if initialClipboard and initialClipboard ~= "" and (initialClipboard:find("^YGODECK:") or initialClipboard:find("M:") or initialClipboard:find("E:")) then
		editBox:setText(initialClipboard)
	end

	-- Button "Dán từ Clipboard"
	local btnPaste = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_2_0:onFastPaste()
	end, ClientView.CRECT_BUTTON_S, 200, 52)
	btnPaste:addLabel("Dán từ Clipboard")
	lc.addChildToPos(arg_2_0._form, btnPaste, cc.p(formW / 2 - 130, var_0_0.FRAME_THICK_BOTTOM + 35 + lc.h(btnPaste) / 2))

	-- Button "Xác nhận dán"
	local btnConfirm = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_2_0:onApply()
	end, ClientView.CRECT_BUTTON_S, 200, 52)
	btnConfirm:addLabel("Xác nhận dán")
	lc.addChildToPos(arg_2_0._form, btnConfirm, cc.p(formW / 2 + 130, var_0_0.FRAME_THICK_BOTTOM + 35 + lc.h(btnConfirm) / 2))
end

function var_0_0.onFastPaste(arg_3_0)
	local DeckHelper = require("DeckCodeHelper")
	local curText = arg_3_0._editor:getText() or ""
	local pasted = DeckHelper.pastePrompt("Dán mã bộ bài (YGODECK://...) hoặc danh sách ID vào đây:", curText)
	if pasted and pasted ~= "" then
		arg_3_0._editor:setText(pasted)
		arg_3_0:onApply()
	end
end

function var_0_0.onApply(arg_4_0)
	local text = arg_4_0._editor:getText() or ""
	text = text:match("^%s*(.-)%s*$") or ""

	if text == "" then
		ToastManager.push("Vui lòng nhập hoặc dán mã bộ bài trước!")
		return
	end

	local DeckHelper = require("DeckCodeHelper")
	local ok = DeckHelper.applyDeckCodeToTroop(arg_4_0._scene, arg_4_0._troopIndex, text)
	if ok then
		arg_4_0:hide()
	end
end

return var_0_0
