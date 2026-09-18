local var_0_0 = class("TopMostPanel", BasePanel)

var_0_0.FRAME_THICK = 7
var_0_0.FRAME_THICK_BOTH = var_0_0.FRAME_THICK + var_0_0.FRAME_THICK
var_0_0.SHADOW_L = 10
var_0_0.SHADOW_R = 10
var_0_0.SHADOW_H = var_0_0.SHADOW_L + var_0_0.SHADOW_R
var_0_0.SHADOW_T = 8
var_0_0.SHADOW_B = 12
var_0_0.SHADOW_V = var_0_0.SHADOW_T + var_0_0.SHADOW_B

function var_0_0.create(arg_1_0)
	if not var_0_0.canCreate() then
		return nil
	end

	local var_1_0 = var_0_0.new(lc.EXTEND_WIDGET)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.canCreate()
	if var_0_0._touchLayer and var_0_0._touchLayer._isTouchOnLinkNode then
		return false
	else
		return true
	end
end

function var_0_0.init(arg_3_0, arg_3_1)
	var_0_0.super.init(arg_3_0, true, true)

	arg_3_0._isNeedTransparent = true

	if var_0_0._touchLayer == nil then
		local function var_3_0(arg_4_0)
			if var_0_0._touchLayer._linkNodes then
				for iter_4_0, iter_4_1 in ipairs(var_0_0._touchLayer._linkNodes) do
					if lc.contain(iter_4_1, arg_4_0) then
						return true
					end
				end
			end

			return false
		end

		local var_3_1 = ClientView.createTouchLayer()

		var_3_1:retain()

		function var_3_1._touchHandler(arg_5_0, arg_5_1, arg_5_2)
			local var_5_0 = cc.p(arg_5_1, arg_5_2)

			if arg_5_0 == "began" then
				local var_5_1 = BasePanel._topMostPanel

				if var_5_1 then
					if not lc.contain(var_5_1, var_5_0) then
						if var_3_0(var_5_0) then
							var_0_0._touchLayer._isTouchOnLinkNode = true
						end

						var_5_1:hide()
					end
				else
					var_0_0._touchLayer._isTouchOnLinkNode = false
				end

				return 0
			end
		end

		var_0_0._touchLayer = var_3_1
	end

	arg_3_0:setContentSize(arg_3_1)
end

function var_0_0.linkNode(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0._touchLayer

	var_6_0._linkNodes = var_6_0._linkNodes or {}

	table.insert(var_6_0._linkNodes, arg_6_1)
end

function var_0_0.show(arg_7_0, arg_7_1)
	var_0_0.super.show(arg_7_0, arg_7_1)

	BasePanel._topMostPanel = arg_7_0
end

function var_0_0.hide(arg_8_0)
	if var_0_0._touchLayer then
		var_0_0._touchLayer._linkNodes = nil
	end

	var_0_0.super.hide(arg_8_0)

	BasePanel._topMostPanel = nil
end

local var_0_1 = class("ButtonList", var_0_0)

var_0_1.MARGIN = 12
var_0_1.GAP = 8

function var_0_1.create(arg_9_0, arg_9_1)
	if not var_0_0.canCreate() then
		return nil
	end

	local var_9_0 = var_0_1.new(lc.EXTEND_WIDGET)

	var_9_0._titleStr = arg_9_1

	var_9_0:init(arg_9_0)

	return var_9_0
end

function var_0_1.init(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.setContentSize

	function arg_10_0.setContentSize(arg_11_0, arg_11_1, arg_11_2)
		if type(arg_11_1) == "table" then
			arg_11_2 = arg_11_1.height
			arg_11_1 = arg_11_1.width
		end

		var_10_0(arg_11_0, arg_11_1, arg_11_2)
		arg_11_0._bg:setContentSize(arg_11_1, arg_11_2)
		arg_11_0._bg:setPosition(arg_11_1 / 2, arg_11_2 / 2)
	end

	local var_10_1 = ClientView.createFramedShadowColorBg(arg_10_1, color or cc.c3b(40, 50, 60))

	arg_10_0._bg = var_10_1

	arg_10_0:addChild(var_10_1)
	var_0_1.super.init(arg_10_0, arg_10_1)
end

function var_0_1.setButtonDefs(arg_12_0, arg_12_1)
	local var_12_0 = lc.w(arg_12_0) - 40

	arg_12_0._buttons = {}

	local var_12_1 = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_2 = iter_12_1._w or var_12_0

		if iter_12_1._isSeparator then
			local var_12_3 = lc.createImageView("img_divide_line_5")

			var_12_3:setScaleX(var_12_2 / lc.w(var_12_3))
			var_12_3:setOpacity(100)

			var_12_1 = var_12_1 + lc.h(var_12_3) + var_0_1.GAP

			table.insert(arg_12_0._buttons, var_12_3)
		else
			local var_12_4 = iter_12_1._h or ClientView.CRECT_BUTTON_S.height
			local var_12_5 = ClientView.createScale9ShaderButton(iter_12_1._focus and "img_btn_2_s" or "img_btn_1_s", function()
				if iter_12_1._handler then
					iter_12_1._handler()
				end

				BasePanel.hideTopMost()
			end, ClientView.CRECT_BUTTON, var_12_2, var_12_4)

			var_12_5:setDisabledShader(ClientView.SHADER_DISABLE)
			var_12_5:setEnabled(iter_12_1._handler ~= nil)

			if iter_12_1._onButtonCreate then
				iter_12_1._onButtonCreate(var_12_5)
			end

			if iter_12_1._area then
				var_12_5._labelArea = iter_12_1._area

				lc.addChildToPos(var_12_5, iter_12_1._area, cc.p(var_12_2 / 2, var_12_4 / 2 + 1))
			else
				local var_12_6 = iter_12_1._str or Str(iter_12_1._sid)

				var_12_5:addLabel(var_12_6)
			end

			var_12_1 = var_12_1 + var_12_4 + var_0_1.GAP

			table.insert(arg_12_0._buttons, var_12_5)
		end
	end

	local var_12_7 = var_12_1 - var_0_1.GAP + var_0_1.MARGIN + var_0_1.MARGIN + var_0_0.FRAME_THICK_BOTH
	local var_12_8 = 0
	local var_12_9 = 0

	if arg_12_0._titleStr then
		local var_12_10 = ClientView.createTTF(arg_12_0._titleStr)

		var_12_8 = lc.w(var_12_10)
		var_12_9 = lc.h(var_12_10) + 8
		var_12_7 = var_12_7 + var_12_9

		lc.addChildToPos(arg_12_0._bg, var_12_10, cc.p(lc.w(arg_12_0._bg) / 2, var_12_7 - lc.h(var_12_10) / 2 - 16))

		arg_12_0._title = var_12_10
	end

	local var_12_11 = true

	if var_12_7 < lc.h(arg_12_0) then
		local var_12_12 = lc.w(arg_12_0)

		if lc.w(arg_12_0) < var_12_8 + 30 then
			var_12_12 = var_12_8 + 30

			arg_12_0._title:setPositionX(var_12_12 / 2)
		end

		arg_12_0:setContentSize(var_12_12, var_12_7)

		var_12_11 = false
	end

	local var_12_13 = lc.List.createV(cc.size(lc.w(arg_12_0), lc.h(arg_12_0) - 12 - var_12_9), var_0_1.MARGIN, var_0_1.GAP)

	var_12_13:setBounceEnabled(var_12_11)

	for iter_12_2, iter_12_3 in ipairs(arg_12_0._buttons) do
		var_12_13:pushBackCustomItem(iter_12_3)
	end

	lc.addChildToPos(arg_12_0._bg, var_12_13, cc.p(0, 6))
end

local var_0_2 = class("TroopList", var_0_1)

var_0_2.WIDTH = 310
var_0_2.GAP = 3

function var_0_2.create()
	if not var_0_0.canCreate() then
		return nil
	end

	local var_14_0 = var_0_2.new(lc.EXTEND_WIDGET)

	var_14_0:init(cc.size(var_0_2.WIDTH, 0))

	return var_14_0
end

function var_0_2.setButtonDefs(arg_15_0, arg_15_1)
	local var_15_0 = var_0_2.WIDTH - var_0_1.MARGIN - var_0_1.MARGIN - var_0_0.FRAME_THICK_BOTH

	arg_15_0._items = {}

	local var_15_1 = var_0_1.MARGIN + var_0_1.MARGIN + var_0_0.FRAME_THICK_BOTH - var_0_2.GAP

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_2 = iter_15_1._handler ~= nil
		local var_15_3 = ClientView.CRECT_BUTTON_S.height
		local var_15_4 = ccui.Widget:create()

		var_15_4:setContentSize(var_15_0, var_15_3)

		if var_15_2 then
			-- block empty
		end

		local var_15_5 = ClientView.createScale9ShaderButton("img_btn_2", function()
			iter_15_1._handler(1)
			BasePanel.hideTopMost()
		end, ClientView.CRECT_BUTTON_S, var_15_2 and (not iter_15_1._hideRemark or not iter_15_1._hideExchange) and 204 or var_15_0 + var_0_0.FRAME_THICK_BOTH)

		if var_15_2 and not iter_15_1._hideRemark then
			local var_15_6 = iter_15_1._remark

			if var_15_6 == nil or var_15_6 == "" then
				var_15_6 = iter_15_1._str
			end

			local var_15_7 = ClientView.createTTF(var_15_6, ClientView.FontSize.S2, remarkClr)

			var_15_7:setScale(math.min(1, (lc.w(var_15_5) - 16) / lc.w(var_15_7)))
			lc.addChildToCenter(var_15_5, var_15_7)
		else
			local var_15_8 = ClientView.createBoldRichTextMultiLine(iter_15_1._str, ClientView.RICHTEXT_PARAM_LIGHT_S2)

			lc.addChildToCenter(var_15_5, var_15_8)
		end

		var_15_5:setDisabledShader(ClientView.SHADER_DISABLE)
		var_15_5:setEnabled(iter_15_1._handler ~= nil)
		lc.addChildToPos(var_15_4, var_15_5, cc.p(lc.cw(var_15_5), lc.h(var_15_4) - lc.ch(var_15_5)), -1)

		if var_15_2 then
			if not iter_15_1._hideRemark then
				local var_15_9 = ClientView.createScale9ShaderButton("img_btn_1", function()
					iter_15_1._handler(3)
				end, ClientView.CRECT_BUTTON_S, 82)

				var_15_9:setDisabledShader(ClientView.SHADER_DISABLE)
				var_15_9:setEnabled(var_15_5:isEnabled())
				lc.addChildToPos(var_15_4, var_15_9, cc.p(lc.right(var_15_5) + lc.cw(var_15_9), lc.y(var_15_5)))

				local var_15_10 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.REMARK))

				lc.addChildToCenter(var_15_9, var_15_10)
				var_15_10:setScale(0.9)
			end

			if iter_15_1._hideRemark and not iter_15_1._hideExchange then
				local var_15_11 = ClientView.createScale9ShaderButton("img_btn_1", function()
					iter_15_1._handler(4)
				end, ClientView.CRECT_BUTTON_S, 82)

				lc.addChildToPos(var_15_4, var_15_11, cc.p(lc.right(var_15_5) + lc.cw(var_15_11), lc.y(var_15_5)))

				local var_15_12 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.EXCHANGE_TROOP))

				lc.addChildToCenter(var_15_11, var_15_12)
				var_15_12:setScale(0.9)
			end
		end

		var_15_1 = var_15_1 + var_15_3 + var_0_2.GAP

		table.insert(arg_15_0._items, var_15_4)
	end

	local var_15_13 = math.min(var_15_1, ClientView.SCR_H - 40)

	arg_15_0:setContentSize(var_0_2.WIDTH, var_15_13)

	local var_15_14 = lc.List.createV(cc.size(lc.w(arg_15_0) - var_0_0.FRAME_THICK_BOTH, var_15_13 - var_0_0.FRAME_THICK_BOTH), var_0_1.MARGIN, var_0_2.GAP)

	var_15_14:setBounceEnabled(false)

	for iter_15_2, iter_15_3 in ipairs(arg_15_0._items) do
		var_15_14:pushBackCustomItem(iter_15_3)
	end

	arg_15_0._bg:addChild(var_15_14)
end

local var_0_3 = class("DescPanel", var_0_0)

var_0_3.WIDTH = 400
var_0_3.MARGIN = 30

function var_0_3.create(arg_19_0)
	local var_19_0 = var_0_3.new(lc.EXTEND_WIDGET)

	if var_19_0:init(arg_19_0) then
		return var_19_0
	end
end

function var_0_3.createByInfoId(arg_20_0, arg_20_1)
	local var_20_0

	if arg_20_0 == 0 then
		var_20_0 = Str(STR.NPC_DESC)
	else
		local var_20_1 = Data.getInfo(arg_20_0)

		if var_20_1 == nil or var_20_1._descSid == nil then
			return nil
		end

		local var_20_2 = ClientData.getItemTypeNameByInfoId(arg_20_0, arg_20_1)

		var_20_0 = string.format("|%s|%s", string.format(Str(STR.BRACKETS_S), var_20_2), Str(var_20_1._descSid))
	end

	local var_20_3 = var_0_3.new(lc.EXTEND_WIDGET)

	if var_20_3:init(var_20_0) then
		return var_20_3
	end
end

function var_0_3.init(arg_21_0, arg_21_1)
	local var_21_0 = ClientView.createBoldRichText(arg_21_1, {
		_width = var_0_3.WIDTH - var_0_3.MARGIN * 2
	})
	local var_21_1 = cc.size(var_0_3.WIDTH, lc.h(var_21_0) + var_0_3.MARGIN * 2)
	local var_21_2 = ClientView.createFramedShadowColorBg(var_21_1, color or cc.c3b(40, 50, 60))

	var_21_2:setOpacity(240)
	lc.addChildToCenter(var_21_2, var_21_0)

	local var_21_3 = lc.createImageView({
		_name = "img_com_bg_15",
		_crect = ClientView.CRECT_COM_BG15
	})

	var_21_3:setContentSize(var_21_1.width + var_0_0.SHADOW_H, var_21_1.height + var_0_0.SHADOW_V)
	lc.addChildToPos(var_21_2, var_21_3, cc.p(var_21_1.width / 2 - 6, var_21_1.height / 2 - 8), -1)
	var_0_3.super.init(arg_21_0, var_21_1)
	lc.addChildToCenter(arg_21_0, var_21_2)

	return true
end

local var_0_4 = class("FilterList", var_0_0)

var_0_4.MARGIN = 12
var_0_4.GAP = 8

function var_0_4.create(arg_22_0, arg_22_1)
	if not var_0_0.canCreate() then
		return nil
	end

	local var_22_0 = var_0_4.new(lc.EXTEND_WIDGET)

	var_22_0._titleStr = arg_22_1

	var_22_0:init(arg_22_0)

	return var_22_0
end

function var_0_4.init(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.setContentSize

	function arg_23_0.setContentSize(arg_24_0, arg_24_1, arg_24_2)
		if type(arg_24_1) == "table" then
			arg_24_2 = arg_24_1.height
			arg_24_1 = arg_24_1.width
		end

		var_23_0(arg_24_0, arg_24_1, arg_24_2)
		arg_24_0._bg:setContentSize(arg_24_1, arg_24_2)
		arg_24_0._bg:setPosition(arg_24_1 / 2, arg_24_2 / 2)
		if arg_24_0._btnClose then
			arg_24_0._btnClose:setPosition(arg_24_1 - 25, arg_24_2 - 25)
		end
	end

	local var_23_1 = ClientView.createFramedShadowColorBg(arg_23_1, color or cc.c3b(40, 50, 60))

	arg_23_0._bg = var_23_1

	arg_23_0:addChild(var_23_1)

	local w = (type(arg_23_1) == "table" and (arg_23_1.width or arg_23_1.w)) or 300
	local h = (type(arg_23_1) == "table" and (arg_23_1.height or arg_23_1.h)) or 400
	local btnClose = ClientView.createShaderButton("img_btn_close", function()
		BasePanel.hideTopMost()
	end)
	if btnClose then
		btnClose:setScale(1.1)
		lc.addChildToPos(arg_23_0, btnClose, cc.p(w - 25, h - 25), 100)
		arg_23_0._btnClose = btnClose
	end

	local var_23_2 = lc.List.createV(arg_23_1, 0, 0)

	var_23_1:addChild(var_23_2)
	var_23_2:setPositionY(5)

	arg_23_0._list = var_23_2

	local var_23_3 = ccui.Widget:create()

	arg_23_0._container = var_23_3

	var_23_2:pushBackCustomItem(var_23_3)
	var_0_4.super.init(arg_23_0, arg_23_1)
end

function var_0_4.setButtonDefs(arg_25_0, arg_25_1)
	local var_25_0 = lc.w(arg_25_0) - 40
	local var_25_1 = 80
	local var_25_2 = 130
	local var_25_3 = 50
	local var_25_4 = arg_25_0._container

	var_25_4:setContentSize(var_25_0, 0)
	var_25_4:setAnchorPoint(0.5, 1)

	local var_25_5 = 0

	for iter_25_0 = 1, #arg_25_1 do
		local var_25_6 = arg_25_1[iter_25_0]

		var_25_6._curFilters = var_25_6._curFilters or {}

		local var_25_7 = 0
		local var_25_8 = {}

		local function var_25_9(arg_26_0)
			for iter_26_0 = 1, #var_25_8 do
				local var_26_0 = false

				for iter_26_1, iter_26_2 in ipairs(arg_26_0) do
					if iter_26_2 == iter_26_0 then
						var_26_0 = true

						break
					end
				end

				var_25_8[iter_26_0]:setIsSelected(var_26_0)
			end
		end

		if iter_25_0 > 1 then
			local var_25_10 = lc.createSprite({
				_name = "img_divide_line_9",
				_size = cc.size(var_25_0, 2),
				_crect = cc.rect(10, 1, 1, 1)
			})

			lc.addChildToPos(var_25_4, var_25_10, cc.p(var_25_0 / 2, var_25_5 - 15))

			var_25_5 = var_25_5 - 30
		end

		local var_25_11 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_25_6._titleStr)

		var_25_11:setColor(lc.Color3B.yellow)
		lc.addChildToPos(var_25_4, var_25_11, cc.p(lc.cw(var_25_11), var_25_5 - lc.ch(var_25_11)))

		var_25_5 = var_25_5 - var_25_3 + lc.ch(var_25_11)

		for iter_25_1 = 1, #var_25_6 do
			local var_25_12 = var_25_6[iter_25_1]
			local var_25_13 = ClientView.createFilterButton(var_25_12._str, function()
				var_25_12._handler()
				var_25_9(var_25_6._curFilters)
			end, var_25_2, var_25_3)

			if var_25_0 < var_25_7 + lc.w(var_25_13) - 10 then
				var_25_7 = 0
				var_25_5 = var_25_5 - var_25_3
			end

			lc.addChildToPos(var_25_4, var_25_13, cc.p(var_25_7 + lc.cw(var_25_13), var_25_5 - lc.ch(var_25_13)))

			var_25_8[iter_25_1] = var_25_13
			var_25_7 = var_25_7 + var_25_2
		end

		var_25_5 = var_25_5 - var_25_3 + 10

		var_25_9(var_25_6._curFilters)
	end

	for iter_25_2, iter_25_3 in ipairs(var_25_4:getChildren()) do
		iter_25_3:setPositionY(iter_25_3:getPositionY() - var_25_5 + 40)
	end

	arg_25_0:setContentSize(lc.w(arg_25_0), math.min(750, -var_25_5 + 40))
	arg_25_0._list:setContentSize(lc.w(arg_25_0) - 10, lc.h(arg_25_0) - 10)
	var_25_4:setContentSize(var_25_0, -var_25_5 + 40)
	arg_25_0:setTouchEnabled(true)
	arg_25_0._list:removeAllItems()
	arg_25_0._list:pushBackCustomItem(var_25_4)
end

var_0_0.ButtonList = var_0_1
var_0_0.TroopList = var_0_2
var_0_0.DescPanel = var_0_3
var_0_0.FilterList = var_0_4

return var_0_0
