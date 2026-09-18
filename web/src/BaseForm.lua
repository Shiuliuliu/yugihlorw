local var_0_0 = class("BaseForm", require("BasePanel"))

var_0_0.LEFT_MARGIN = 36
var_0_0.RIGHT_MARGIN = 36
var_0_0.TOP_MARGIN = 30
var_0_0.BOTTOM_MARGIN = 30
var_0_0.FRAME_THICK_LEFT = 36
var_0_0.FRAME_THICK_RIGHT = 36
var_0_0.FRAME_THICK_H = var_0_0.FRAME_THICK_LEFT + var_0_0.FRAME_THICK_RIGHT
var_0_0.FRAME_THICK_TOP = 30
var_0_0.FRAME_THICK_BOTTOM = 30
var_0_0.FRAME_THICK_V = var_0_0.FRAME_THICK_TOP + var_0_0.FRAME_THICK_BOTTOM
var_0_0.TAB_CRECT = cc.rect(36, 0, 1, 86)
var_0_0.TAB_Y_FOCUS = 21
var_0_0.TAB_Y_UNFOCUS = 23
var_0_0.TAB_COLOR_UNFOCUS = cc.c3b(100, 100, 100)
var_0_0.TAB_COLOR_LABEL_UNFOCUS = cc.c3b(110, 170, 60)
var_0_0.ACTION_DURATION = 0.3
var_0_0.FLAG = {
	BOTTOM_AREA = 16,
	SCROLL_V = 32,
	SCROLL_H = 64,
	TOP_AREA = 8,
	PAPER_BG = 4,
	TTF_TITLE = 256,
	BASE_TITLE_BG = 1,
	ADVANCE_TITLE_BG = 2,
	NO_CLOSE_BTN = 128
}

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.init(arg_1_0, arg_1_4)

	arg_1_0._form = ccui.Widget:create()

	arg_1_0._form:setContentSize(arg_1_1)
	arg_1_0._form:setTouchEnabled(true)
	arg_1_0._form:setAnchorPoint(0.5, 0.5)

	local var_1_0 = ClientView.createFrameBox(arg_1_1)

	lc.addChildToCenter(arg_1_0._form, var_1_0)

	arg_1_0._frame = var_1_0
	arg_1_3 = arg_1_3 or 0

	local var_1_1 = cc.p(0, -2)
	local var_1_2 = cc.size(lc.w(arg_1_0._form) - var_0_0.FRAME_THICK_LEFT - var_0_0.FRAME_THICK_RIGHT, lc.h(arg_1_0._form) - var_0_0.FRAME_THICK_TOP - var_0_0.FRAME_THICK_BOTTOM)

	if band(arg_1_3, var_0_0.FLAG.TOP_AREA) ~= 0 then
		arg_1_0:addTopBg()

		var_1_2.height = var_1_2.height - 64
	end

	if band(arg_1_3, var_0_0.FLAG.BOTTOM_AREA) ~= 0 then
		arg_1_0:addBottomBg()

		var_1_2.height = var_1_2.height - 72
		var_1_1.y = var_1_1.y + 72
	end

	local var_1_3 = 0

	if arg_1_2 then
		local var_1_4

		if band(arg_1_3, var_0_0.FLAG.BASE_TITLE_BG) ~= 0 then
			var_1_4 = ccui.Scale9Sprite:createWithSpriteFrameName("img_form_title_bg_2", ClientView.CRECT_FORM_TITLE_BG2)

			var_1_4:setContentSize(lc.w(arg_1_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN, ClientView.CRECT_FORM_TITLE_BG2.height)
			lc.addChildToPos(arg_1_0._form, var_1_4, cc.p(lc.w(arg_1_0._form) / 2, lc.h(arg_1_0._form) - var_0_0.TOP_MARGIN - lc.h(var_1_4) / 2), 10)

			local var_1_5 = cc.Label:createWithTTF(arg_1_2, ClientView.TTF_FONT, ClientView.FontSize.M1)

			var_1_5:setColor(ClientView.COLOR_TEXT_LIGHT)
			var_1_5:setPosition(lc.w(var_1_4) / 2, lc.h(var_1_4) / 2 + 4)
			var_1_4:addChild(var_1_5)

			arg_1_0._titleLabel = var_1_5
		else
			var_1_4 = lc.createSprite({
				_name = "img_form_title_bg_1",
				_crect = ClientView.CRECT_FORM_TITLE_BG1_CRECT,
				_size = cc.size(560, ClientView.CRECT_FORM_TITLE_BG1_CRECT.height)
			})

			lc.addChildToPos(arg_1_0._form, var_1_4, cc.p(lc.w(arg_1_0._form) / 2, lc.h(arg_1_0._form) - lc.h(var_1_4) / 2 + 10), 10)

			local var_1_6 = lc.createSprite({
				_name = "img_form_title_light_1",
				_crect = ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT,
				_size = cc.size(200, ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT.height)
			})

			lc.addChildToPos(var_1_4, var_1_6, cc.p(lc.w(var_1_4) / 2, lc.h(var_1_4) / 2 + 4))

			local var_1_7

			if band(arg_1_3, var_0_0.FLAG.TTF_TITLE) ~= 0 then
				var_1_7 = cc.Label:createWithTTF(arg_1_2, ClientView.TTF_FONT, ClientView.FontSize.M1)
			else
				var_1_7 = ClientView.createBMFont(ClientView.BMFont.huali_32, arg_1_2)
			end

			var_1_7:setColor(ClientView.COLOR_TEXT_TITLE)
			var_1_7:setPosition(lc.w(var_1_4) / 2, lc.h(var_1_4) / 2 + 4)
			var_1_4:addChild(var_1_7)

			arg_1_0._titleLabel = var_1_7
			var_1_3 = -(lc.top(var_1_4) - lc.h(arg_1_0._form)) / 2
		end

		arg_1_0._titleFrame = var_1_4
	end

	arg_1_0._form:setPosition(lc.w(arg_1_0) / 2, lc.h(arg_1_0) / 2 + var_1_3)
	arg_1_0:addChild(arg_1_0._form)

	if band(arg_1_3, var_0_0.FLAG.NO_CLOSE_BTN) == 0 then
		local var_1_8 = ClientData.isAppStoreReviewing() and lc.FrameCache:getSpriteFrame("img_btn_close_r") ~= nil and "img_btn_close_r" or "img_btn_close"
		local var_1_9 = ClientView.createShaderButton(var_1_8, function(arg_2_0)
			arg_1_0:hide()
		end)

		var_1_9:setZoomScale(0)
		var_1_9:setPosition(lc.w(arg_1_0._form) - 56, lc.h(arg_1_0._form) - 36)
		var_1_9:setTouchRect(cc.rect(0, 0, lc.w(var_1_9) + 30, lc.h(var_1_9) + 30))
		arg_1_0._form:addChild(var_1_9, 20)

		arg_1_0._btnBack = var_1_9
	end
end

function var_0_0.addTopBg(arg_3_0)
	local var_3_0 = cc.Sprite:createWithSpriteFrameName("img_com_bg_8")

	var_3_0:setScaleX((lc.w(arg_3_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN) / lc.w(var_3_0) + 0.1)
	var_3_0:setScaleY(1.2)
	lc.addChildToPos(arg_3_0._form, var_3_0, cc.p(lc.w(arg_3_0._form) / 2, lc.h(arg_3_0._form) - var_0_0.FRAME_THICK_TOP - lc.sh(var_3_0) / 2 + 6), -2)

	arg_3_0._frameTopBg = var_3_0
end

function var_0_0.addBottomBg(arg_4_0)
	local var_4_0 = ClientView.createLineSprite("img_bottom_bg", lc.w(arg_4_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT)

	lc.addChildToPos(arg_4_0._frame, var_4_0, cc.p(lc.w(arg_4_0._frame) / 2, ClientView.FRAME_INNER_BOTTOM + lc.h(var_4_0) / 2 - 6), -1)

	arg_4_0._frameBottomBg = var_4_0
end

function var_0_0.show(arg_5_0, arg_5_1)
	var_0_0.hideTopMost()

	if lc._runningScene and lc._runningScene._scene then
		if arg_5_0:getParent() then
			if arg_5_1 then
				lc.changeParent(arg_5_0, nil, lc._runningScene._scene, ClientData.ZOrder.form)
			else
				return
			end
		else
			lc._runningScene._scene:addChild(arg_5_0, ClientData.ZOrder.form)
		end

		if arg_5_0._form:getNumberOfRunningActions() == 0 then
			local var_5_0 = cc.p(lc.x(arg_5_0._form), lc.y(arg_5_0._form))

			arg_5_0._form:setPosition(lc.w(arg_5_0) / 2, -lc.h(arg_5_0._form))
			arg_5_0._form:runAction(lc.sequence(lc.ease(lc.moveTo(lc.absTime(var_0_0.ACTION_DURATION), var_5_0), "BackO"), function()
				if arg_5_0.onShowActionFinished then
					arg_5_0:onShowActionFinished()
				end
			end))
		end
	end
end

function var_0_0.hide(arg_7_0, arg_7_1)
	if arg_7_0:getParent() == nil then
		return
	end

	if arg_7_1 then
		arg_7_0:removeFromParent()

		return
	end

	if arg_7_0._form:getNumberOfRunningActions() == 0 then
		ClientView.blockTouch(arg_7_0)
		arg_7_0._form:runAction(cc.Sequence:create(cc.EaseBackIn:create(cc.MoveTo:create(lc.absTime(var_0_0.ACTION_DURATION), cc.p(lc.w(arg_7_0) / 2, -lc.h(arg_7_0._form)))), cc.CallFunc:create(function()
			if arg_7_0.onHideActionFinished then
				arg_7_0:onHideActionFinished()
			end

			arg_7_0:removeFromParent()
		end)))
	end
end

function var_0_0.addTabs(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == nil or #arg_9_1 == 0 then
		return
	end

	if arg_9_0._tabs then
		for iter_9_0 = 1, #arg_9_0._tabs do
			arg_9_0._tabs[iter_9_0]:removeFromParent(true)
		end
	end

	arg_9_0._tabs = {}

	local var_9_0 = 50
	local var_9_1 = 5
	local var_9_2 = (lc.w(arg_9_0._form) - 2 * var_9_0 - (#arg_9_1 - 1) * var_9_1) / #arg_9_1
	local var_9_3 = var_9_0

	for iter_9_1 = 1, #arg_9_1 do
		local var_9_4 = ClientView.createScale9ShaderButton("img_form_tab_focus", function(arg_10_0)
			arg_9_0:showTab(arg_9_1[iter_9_1], false)
		end, var_0_0.TAB_CRECT, var_9_2)

		var_9_4:setColor(var_0_0.TAB_COLOR_UNFOCUS)
		var_9_4:setAnchorPoint(0.5, 1)
		var_9_4:addLabel(arg_9_1[iter_9_1])
		var_9_4._label:setColor(var_0_0.TAB_COLOR_LABEL_UNFOCUS)
		var_9_4:setPosition(var_9_3 + var_9_2 / 2, var_0_0.TAB_Y_UNFOCUS)

		var_9_3 = var_9_3 + var_9_2 + var_9_1

		arg_9_0._frame:addChild(var_9_4, -1, iter_9_1)

		arg_9_0._tabs[arg_9_1[iter_9_1]] = var_9_4
	end

	local var_9_5 = lc.bottom(arg_9_0._tabs[arg_9_1[1]])

	arg_9_0._form:setPositionY(math.floor(lc.y(arg_9_0._form) - var_9_5 / 2 + 6))

	if arg_9_2 then
		arg_9_0:showTab(arg_9_1[arg_9_2], true)
	else
		arg_9_0:showTab(arg_9_1[1], true)
	end
end

function var_0_0.showTab(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._tabs[arg_11_1]

	if var_11_0 == nil then
		return false
	end

	local var_11_1 = arg_11_0._focusTab

	if var_11_1 == var_11_0 and not arg_11_2 then
		return false
	end

	if var_11_1 then
		var_11_1:setColor(var_0_0.TAB_COLOR_UNFOCUS)
		var_11_1:setLocalZOrder(-1)
		var_11_1:setPositionY(var_0_0.TAB_Y_UNFOCUS)
		var_11_1._label:setColor(var_0_0.TAB_COLOR_LABEL_UNFOCUS)
	end

	arg_11_0._focusTab = var_11_0

	var_11_0:setColor(lc.Color3B.white)
	var_11_0:setLocalZOrder(1)
	var_11_0:setPositionY(var_0_0.TAB_Y_FOCUS)
	var_11_0._label:setColor(lc.Color3B.white)

	return true
end

function var_0_0.showFormTip(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0._tip then
		arg_12_0._tip:removeFromParent()
	end

	local var_12_0 = ClientView.createBoldRichText(arg_12_1, {
		_normalClr = ClientView.COLOR_TEXT_DARK,
		_boldClr = ClientView.COLOR_TEXT_ORANGE_DARK,
		_fontSize = ClientView.FontSize.S1
	})
	local var_12_1 = lc.createImageView({
		_name = "img_tip_bg",
		_crect = ClientView.CRECT_TIP_BG,
		_size = cc.size(lc.w(var_12_0) + 90, lc.h(var_12_0) + 100)
	})

	var_12_1:setScale(0)
	var_12_1:setAnchorPoint(0, 0)
	lc.addChildToPos(var_12_1, var_12_0, cc.p(lc.w(var_12_0) / 2 + 45, lc.h(var_12_0) / 2 + 70))
	lc.addChildToPos(arg_12_0._form, var_12_1, cc.p(10 + (arg_12_3 or 0), lc.h(arg_12_0._form) - 60 + (arg_12_4 or 0)), 20)

	if arg_12_2 then
		var_12_1:setTouchEnabled(true)
		var_12_1:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 == ccui.TouchEventType.ended then
				arg_12_2()
			end
		end)
	end

	var_12_1:runAction(lc.ease(lc.scaleTo(0.4, 1), "BackO"))

	arg_12_0._tip = var_12_1
end

BaseForm = var_0_0

return var_0_0
