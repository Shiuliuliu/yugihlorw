local var_0_0 = class("ServerAnnouncementForm", BaseForm)
local var_0_1 = cc.size(800, 600)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.ANNOUNCEMENT), bor(var_0_0.FLAG.ADVANCE_TITLE_BG))

	local var_2_0 = arg_2_0._form
	local var_2_1 = lc.List.createV(cc.size(var_0_1.width - var_0_0.FRAME_THICK_H - 40, var_0_1.height - var_0_0.FRAME_THICK_V), 30, 10)

	lc.addChildToCenter(var_2_0, var_2_1)

	arg_2_0._list = var_2_1
	arg_2_0._indicator = ClientView.showPanelActiveIndicator(var_2_0)

	local var_2_2, var_2_3 = lc.App:getChannelName()
	local var_2_4

	if var_2_2 == "DEV" or lc.App:getRedirectGameServer() == "DEV" then
		var_2_4 = "_dev"
	else
		local var_2_5

		var_2_5 = var_2_2 == "APPSTORE" and "_appstore" or ""
		var_2_4 = ""
	end

	if ClientData._cfg and ClientData._cfg.testAnnounce then
		arg_2_0:onGetAnnouncement(true)
	else
		arg_2_0._http = lc.httpRequest(string.format("https://leocool-patch.oss-cn-hangzhou.aliyuncs.com/manga/YGO/announce%s.txt", var_2_4), "GET", function()
			arg_2_0:onGetAnnouncement()
		end)
	end
end

function var_0_0.createItem(arg_4_0, arg_4_1)
	local var_4_0 = string.splitByChar(arg_4_1, ",")
	local var_4_1 = ccui.Widget:create()

	if #var_4_0 >= 4 then
		local var_4_2 = lc.w(arg_4_0._list)
		local var_4_3 = 0
		local var_4_4 = 8
		local var_4_5
		local var_4_6
		local var_4_7
		local var_4_8

		if var_4_0[1] ~= " " then
			var_4_5 = ClientView.createTTF(var_4_0[1], ClientView.FontSize.M2, ClientView.COLOR_TEXT_ORANGE)
			var_4_3 = var_4_3 + lc.h(var_4_5) + 10
		end

		if var_4_0[2] ~= " " then
			var_4_6 = ClientView.createTTF(var_4_0[2], ClientView.FontSize.S1, lc.Color3B.yellow)
			var_4_3 = var_4_3 + lc.h(var_4_6) + (var_4_5 and var_4_4 or 0)
		end

		local var_4_9 = ccui.RichTextEx:create()

		var_4_9:setMaxWidth(var_4_2 - 30)

		local var_4_10 = string.gsub(var_4_0[4], "\\n", "\n")
		local var_4_11 = string.splitByChar(var_4_10, "\n")

		for iter_4_0, iter_4_1 in ipairs(var_4_11) do
			ClientView.appendBoldRichText(var_4_9, iter_4_1)
			var_4_9:insertElement(ccui.RichItemNewLine:create(0))
		end

		var_4_9:formatText()

		local var_4_12 = var_4_3 + lc.h(var_4_9) + var_4_4

		var_4_1:setContentSize(var_4_2, var_4_12)
		lc.addChildToPos(var_4_1, var_4_9, cc.p(15 + lc.w(var_4_9) / 2, lc.h(var_4_9) / 2))

		if var_4_5 then
			local var_4_13 = lc.createSprite({
				_name = "img_com_bg_2",
				_crect = ClientView.CRECT_COM_BG2,
				_size = cc.size(720, 40)
			})

			var_4_13:setColor(lc.Color3B.black)
			var_4_13:setOpacity(100)
			lc.addChildToPos(var_4_1, var_4_13, cc.p(lc.w(var_4_13) / 2, var_4_12 - lc.h(var_4_5) / 2))
			lc.addChildToPos(var_4_1, var_4_5, cc.p(lc.w(var_4_5) / 2 + 10, lc.y(var_4_13)))
		end

		if var_4_6 then
			lc.addChildToPos(var_4_1, var_4_6, cc.p(lc.left(var_4_9) + lc.w(var_4_6) / 2, (var_4_5 and var_4_12 - 40 - var_4_4 or var_4_12) - lc.h(var_4_6) / 2))
		end
	end

	return var_4_1
end

function var_0_0.onGetAnnouncement(arg_5_0, arg_5_1)
	if arg_5_0._indicator then
		arg_5_0._indicator:removeFromParent()

		arg_5_0._indicator = nil
	end

	local var_5_0 = arg_5_0._list
	local var_5_1 = arg_5_1 and lc.readFile("res/../announce_dev.txt") or arg_5_0._http.responseText

	if var_5_1 == "" then
		var_5_0:setItemsMargin(0)
		var_5_0:checkEmpty(Str(STR.LIST_EMPTY_NO_ANNOUNCE))

		return
	end

	local var_5_2 = string.splitByChar(var_5_1, "\n")

	for iter_5_0, iter_5_1 in ipairs(var_5_2) do
		var_5_0:pushBackCustomItem(arg_5_0:createItem(iter_5_1))
	end

	arg_5_0._http = nil
end

function var_0_0.hide(arg_6_0, arg_6_1)
	if arg_6_0._http then
		arg_6_0._http:unregisterScriptHandler()

		arg_6_0._http = nil
	end

	var_0_0.super.hide(arg_6_0, arg_6_1)
end

function var_0_0.onCleanup(arg_7_0)
	var_0_0.super.onCleanup(arg_7_0)
end

return var_0_0
