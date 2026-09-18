local var_0_0 = class("ChooseUpPanel", BasePanel)

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.init(arg_2_0, false)

	arg_2_0._pkgInfo = arg_2_1
	arg_2_0._srcSelectedCard = arg_2_2
	arg_2_0._selectedCard = arg_2_2

	local var_2_0 = lc.createSprite("wait_text_bg")

	lc.addChildToPos(arg_2_0, var_2_0, cc.p(lc.cw(arg_2_0), lc.h(arg_2_0) - 20 - lc.ch(var_2_0)))
	var_2_0:setScaleX(10)

	local var_2_1 = ClientView.createTTF(Str(STR.PACKAGE_SELECT_CARD_TITLE), ClientView.FontSize.S1)

	lc.addChildToPos(arg_2_0, var_2_1, cc.p(var_2_0:getPosition()))

	local var_2_2 = ClientView.createLineSprite("img_bottom_bg", lc.w(arg_2_0))

	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.cw(arg_2_0), lc.ch(var_2_2)))

	local var_2_3 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_3_0)
		arg_2_0:onChangeUp()
	end, ClientView.CRECT_BUTTON, 200)

	var_2_3:addLabel(Str(STR.OK))
	lc.addChildToCenter(var_2_2, var_2_3)
	lc.offset(var_2_3, -200, 0)

	arg_2_0._btnChange = var_2_3

	local var_2_4 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_4_0)
		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, 200)

	var_2_4:addLabel(Str(STR.CANCEL))
	lc.addChildToCenter(var_2_2, var_2_4)
	lc.offset(var_2_4, 200, 0)

	local var_2_5 = lc.List.createH(cc.size(lc.w(arg_2_0), lc.bottom(var_2_0) - lc.top(var_2_2)))

	lc.addChildToPos(arg_2_0, var_2_5, cc.p(0, lc.top(var_2_2)))

	arg_2_0._list = var_2_5

	local var_2_6 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1._pid) do
		local var_2_7 = iter_2_1[1]

		if var_2_7 ~= arg_2_0._selectedCard and Data.getInfo(var_2_7)._quality == Data.CardQuality.UR then
			var_2_6[#var_2_6 + 1] = var_2_7
		end
	end

	local var_2_8 = lc.arrayToTable(var_2_6, 2)

	for iter_2_2, iter_2_3 in ipairs(var_2_8) do
		local var_2_9 = arg_2_0:createListItem(iter_2_3)

		var_2_5:pushBackCustomItem(var_2_9)
	end
end

function var_0_0.createListItem(arg_5_0, arg_5_1)
	local var_5_0 = ccui.Widget:create()

	var_5_0:setContentSize(cc.size(230, lc.h(arg_5_0._list)))

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_1 = arg_5_0:createCardThumb(iter_5_1)

		lc.addChildToPos(var_5_0, var_5_1, cc.p(lc.cw(var_5_0), lc.h(var_5_0) * (iter_5_0 * 2 - 1) / 4))
	end

	return var_5_0
end

function var_0_0.createCardThumb(arg_6_0, arg_6_1)
	local var_6_0 = require("CardThumbnail").create(arg_6_1, 0.7)

	var_6_0:setTouchEnabled(true)
	var_6_0:onClick(function(arg_7_0, arg_7_1)
		arg_6_0:onTouchThumbnail(arg_7_0, arg_6_1)
	end)

	if arg_6_1 == arg_6_0._selectedCard then
		var_6_0:setSelected(true, true)
	end

	return var_6_0
end

function var_0_0.onTouchThumbnail(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._selectedThumb then
		arg_8_0._selectedThumb:setSelected(false, false)
	end

	arg_8_0._selectedThumb = arg_8_1
	arg_8_0._selectedCard = arg_8_2

	arg_8_0._selectedThumb:setSelected(true, true)
end

function var_0_0.onChangeUp(arg_9_0)
	if not arg_9_0._selectedCard then
		return ToastManager.push(Str(STR.SELECT_FIRST))
	end

	if arg_9_0._selectedCard ~= arg_9_0._srcSelectedCard then
		ClientView.getActiveIndicator():show(Str(STR.WAITING), nil, arg_9_0._selectedCard)
		ClientData.sendSelectUp(arg_9_0._pkgInfo._value, arg_9_0._selectedCard)
	end

	arg_9_0:hide()
end

function var_0_0.onEnter(arg_10_0)
	var_0_0.super.onEnter(arg_10_0)
end

function var_0_0.onExit(arg_11_0)
	var_0_0.super.onExit(arg_11_0)
end

function var_0_0.onCleanup(arg_12_0)
	var_0_0.super.onCleanup(arg_12_0)
end

return var_0_0
