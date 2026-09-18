local var_0_0 = class("BattleHelpForm", BaseForm)
local var_0_1 = cc.size(900, 720)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.HELP), 0)

	arg_2_0._pageContents = {
		{
			{
				_content = 2
			},
			_title = 1
		},
		{
			{
				_image = "1",
				_content = 4
			},
			{
				_image = "2",
				_content = 5
			},
			_title = 3
		},
		{
			{
				_content = 7
			},
			_title = 6
		},
		{
			{
				_content = 9
			},
			_title = 8
		},
		{
			{
				_image = "3",
				_content = 11
			},
			{
				_image = "4",
				_content = 12
			},
			_title = 10
		},
		{
			{
				_content = 14
			},
			_title = 13
		},
		{
			{
				_image = "5",
				_content = 16
			},
			_title = 15
		}
	}

	if lc._runningScene._sceneId ~= ClientData.SceneId.battle and ClientData.isVivo() then
		arg_2_0._pageContents[8] = {
			_title = 100
		}
	end

	arg_2_0._pageTexts = {}

	for iter_2_0, iter_2_1 in ipairs(Data._helpInfo) do
		if iter_2_1._type == Data.HelpType.battle then
			table.insert(arg_2_0._pageTexts, Str(iter_2_1._nameSid, true))
		end
	end

	arg_2_0._pageTexts[100] = Str(STR.CLOSE_ACCOUNT)
	arg_2_0._curPage = 1
	arg_2_0._totalPage = #arg_2_0._pageContents

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN, lc.bottom(arg_2_0._titleFrame) - var_0_0.BOTTOM_MARGIN + 10), 20, 30)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0._form, var_2_0, cc.p(lc.w(arg_2_0._form) / 2, lc.bottom(arg_2_0._titleFrame) - lc.h(var_2_0) / 2 + 8))

	arg_2_0._list = var_2_0

	local var_2_1 = ClientView.createShaderButton("img_page_right", function()
		if arg_2_0._curPage > 1 then
			arg_2_0._curPage = arg_2_0._curPage - 1
		end

		arg_2_0:refresh()
	end)

	var_2_1:setAnchorPoint(0, 0.5)
	var_2_1:setFlippedX(true)
	var_2_1:setTouchRect(cc.rect(-20, -20, lc.w(var_2_1) + 40, lc.h(var_2_1) + 40))

	local var_2_2 = cc.p(-10, lc.ch(arg_2_0._form))

	var_2_1._pos = var_2_2

	lc.addChildToPos(arg_2_0._form, var_2_1, var_2_2)

	function var_2_1.float(arg_4_0)
		arg_4_0:stopAllActions()
		arg_4_0:setPosition(arg_4_0._pos)
		arg_4_0:runAction(lc.rep(lc.sequence({
			lc.moveTo(0.8, cc.p(arg_4_0._pos.x - 8, arg_4_0._pos.y)),
			lc.moveTo(0.8, arg_4_0._pos)
		})))
	end

	arg_2_0._pageLeft = var_2_1

	local var_2_3 = ClientView.createShaderButton("img_page_right", function()
		if arg_2_0._curPage < arg_2_0._totalPage then
			arg_2_0._curPage = arg_2_0._curPage + 1
		end

		arg_2_0:refresh()
	end)

	var_2_3:setAnchorPoint(0, 0.5)
	var_2_3:setTouchRect(cc.rect(-20, -20, lc.w(var_2_3) + 40, lc.h(var_2_3) + 40))

	local var_2_4 = cc.p(lc.w(arg_2_0._form) + 10, lc.ch(arg_2_0._form))

	var_2_3._pos = var_2_4

	lc.addChildToPos(arg_2_0._form, var_2_3, var_2_4)

	function var_2_3.float(arg_6_0)
		arg_6_0:stopAllActions()
		arg_6_0:setPosition(arg_6_0._pos)
		arg_6_0:runAction(lc.rep(lc.sequence({
			lc.moveTo(0.8, cc.p(arg_6_0._pos.x + 8, arg_6_0._pos.y)),
			lc.moveTo(0.8, arg_6_0._pos)
		})))
	end

	arg_2_0._pageRight = var_2_3

	arg_2_0:refresh()
end

function var_0_0.refresh(arg_7_0)
	if arg_7_0._curPage == 1 then
		arg_7_0._pageLeft:setVisible(false)
	else
		arg_7_0._pageLeft:setVisible(true)
		arg_7_0._pageLeft:float()
	end

	if arg_7_0._curPage == arg_7_0._totalPage then
		arg_7_0._pageRight:setVisible(false)
	else
		arg_7_0._pageRight:setVisible(true)
		arg_7_0._pageRight:float()
	end

	arg_7_0._list:removeAllItems()

	local var_7_0 = arg_7_0._pageContents[arg_7_0._curPage]
	local var_7_1 = arg_7_0._pageTexts[var_7_0._title]

	arg_7_0._list:pushBackCustomItem(arg_7_0:createTitle(var_7_1))

	for iter_7_0 = 1, #var_7_0 do
		local var_7_2 = var_7_0[iter_7_0]

		if var_7_2._image then
			local var_7_3 = string.format("res/jpg/battle_help_%s.jpg", var_7_2._image)

			arg_7_0._list:pushBackCustomItem(arg_7_0:createImage(var_7_3))
		end

		if var_7_2._content then
			local var_7_4 = arg_7_0._pageTexts[var_7_2._content]

			arg_7_0._list:pushBackCustomItem(arg_7_0:createText(var_7_4))
		end
	end

	if arg_7_0._curPage == 8 then
		arg_7_0._list:pushBackCustomItem(arg_7_0:createText(Str(STR.CONFIRM_CLOSE_ACCOUNT)))

		local var_7_5 = ccui.Widget:create()

		var_7_5:setContentSize(100, 200)
		arg_7_0._list:pushBackCustomItem(var_7_5)

		local var_7_6 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_8_0)
			require("Dialog").showDialog(Str(STR.CONFIRM_CLOSE_ACCOUNT), function()
				ClientData.sendBanLogin()

				ClientData._regions = {}

				ClientData.saveUserRegion()
				lc.App:userLogout()
				ClientView.getActiveIndicator():show(Str(STR.WAITING))
			end, nil, nil, function()
				lc.App:openURL("http://sh.smbbgo.com/mzsm/090921252395.html")
			end)
		end, ClientView.CRECT_BUTTON, 170)

		var_7_6:addLabel(Str(STR.CLOSE_ACCOUNT))
		lc.addChildToCenter(var_7_5, var_7_6)
	end
end

function var_0_0.createTitle(arg_11_0, arg_11_1)
	local var_11_0 = ccui.Layout:create()

	var_11_0:setContentSize(cc.size(lc.w(arg_11_0._list), 60))
	var_11_0:setAnchorPoint(0.5, 0.5)

	local var_11_1 = lc.createSprite({
		_name = "img_com_bg_49",
		_size = cc.size(lc.w(var_11_0), 48),
		_crect = cc.rect(50, 24, 1, 1)
	})

	lc.addChildToPos(var_11_0, var_11_1, cc.p(lc.cw(var_11_1), lc.ch(var_11_0)))

	local var_11_2 = ClientView.createTTF(arg_11_1, ClientView.FontSize.M1)

	lc.addChildToPos(var_11_0, var_11_2, cc.p(lc.cw(var_11_2) + 20, lc.ch(var_11_0)))

	return var_11_0
end

function var_0_0.createText(arg_12_0, arg_12_1)
	local var_12_0 = ccui.Layout:create()
	local var_12_1 = ClientView.createBoldRichTextMultiLine(arg_12_1, ClientView.RICHTEXT_PARAM_LIGHT_S1, lc.w(arg_12_0._list) - 40)

	var_12_0:setContentSize(cc.size(lc.w(arg_12_0._list), lc.h(var_12_1) + 40))
	var_12_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_12_0, var_12_1, cc.p(lc.cw(var_12_1) + 20, lc.ch(var_12_0)))

	return var_12_0
end

function var_0_0.createImage(arg_13_0, arg_13_1)
	local var_13_0 = ccui.Layout:create()
	local var_13_1 = lc.createSpriteWithMask(arg_13_1)

	var_13_0:setContentSize(lc.w(arg_13_0._list), lc.h(var_13_1) + 20)
	var_13_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_13_0, var_13_1, cc.p(lc.cw(var_13_0), lc.ch(var_13_0)))

	return var_13_0
end

function var_0_0.onEnter(arg_14_0)
	var_0_0.super.onEnter(arg_14_0)
end

function var_0_0.onExit(arg_15_0)
	var_0_0.super.onExit(arg_15_0)
end

function var_0_0.onCleanup(arg_16_0)
	var_0_0.super.onCleanup(arg_16_0)

	for iter_16_0 = 1, #arg_16_0._pageContents do
		local var_16_0 = arg_16_0._pageContents[iter_16_0]

		for iter_16_1 = 1, #var_16_0 do
			local var_16_1 = var_16_0[iter_16_1]

			if var_16_1._image then
				local var_16_2 = string.format("res/jpg/battle_help_%s.jpg", var_16_1._image)

				lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename(var_16_2))
			end
		end
	end
end

return var_0_0
