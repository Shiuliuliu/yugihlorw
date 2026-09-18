local var_0_0 = class("ItemList", lc.ExtendUIWidget)

var_0_0.ModeType = {
	skill = 2,
	skin = 1
}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setTouchEnabled(not GuideManager.isGuideEnabled())
	var_1_0:setContentSize(arg_1_0)
	var_1_0:setCascadeOpacityEnabled(true)

	var_1_0._itemSize = arg_1_1
	var_1_0._emptyTip = arg_1_2
	var_1_0._createItemFunc = arg_1_3
	var_1_0._updateItemFunc = arg_1_4

	var_1_0:initPage(arg_1_5, arg_1_6)

	return var_1_0
end

function var_0_0.initPage(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0._itemSize.width
	local var_2_1 = arg_2_0._itemSize.height
	local var_2_2 = arg_2_1 or 2
	local var_2_3 = arg_2_2 or 5
	local var_2_4 = (lc.h(arg_2_0) - var_2_2 * var_2_1) / (var_2_2 + 1)
	local var_2_5 = (lc.w(arg_2_0) - var_2_3 * var_2_0) / (var_2_3 + 1)

	while true do
		if var_2_5 < 10 then
			var_2_3 = var_2_3 - 1
			var_2_5 = (lc.w(arg_2_0) - var_2_3 * var_2_0) / (var_2_3 + 1)
		else
			break
		end
	end

	arg_2_0._row, arg_2_0._col = var_2_2, var_2_3

	local var_2_6 = var_2_5 + var_2_0 / 2
	local var_2_7 = var_2_4 + var_2_1 / 2

	arg_2_0._itemRow, arg_2_0._itemCol = var_2_2, var_2_3
	arg_2_0._curPage = 1
	arg_2_0._totalPage = 1
	arg_2_0._items = {}

	for iter_2_0 = 1, var_2_2 do
		arg_2_0._items[iter_2_0] = {}

		for iter_2_1 = 1, var_2_3 do
			local var_2_8 = arg_2_0._createItemFunc()

			lc.addChildToPos(arg_2_0, var_2_8, cc.p(var_2_6 + (iter_2_1 - 1) * (var_2_0 + var_2_5), var_2_7 + (var_2_2 - iter_2_0) * (var_2_1 + var_2_4)))

			arg_2_0._items[iter_2_0][iter_2_1] = var_2_8
		end
	end

	local var_2_9 = cc.p(arg_2_0._items[1][1]:getPositionX() - ClientView.CARD_SIZE.width / 2 - 10, lc.h(arg_2_0) / 2)

	arg_2_0._pageLeft = ClientView.createPageArrow(true, var_2_9, function()
		if arg_2_0._curPage > 1 then
			arg_2_0._curPage = arg_2_0._curPage - 1
		end

		arg_2_0:updatePage(false)
	end)

	lc.addChildToPos(arg_2_0, arg_2_0._pageLeft, var_2_9)

	local var_2_10 = cc.p(arg_2_0._items[1][arg_2_0._itemCol]:getPositionX() + ClientView.CARD_SIZE.width / 2 + 10, lc.h(arg_2_0) / 2)

	arg_2_0._pageRight = ClientView.createPageArrow(false, var_2_10, function()
		if arg_2_0._curPage < arg_2_0._totalPage then
			arg_2_0._curPage = arg_2_0._curPage + 1
		end

		arg_2_0:updatePage(false)
	end)

	lc.addChildToPos(arg_2_0, arg_2_0._pageRight, var_2_10)

	local var_2_11 = ClientView.createBMFont(ClientView.BMFont.huali_26, "1/1")

	var_2_11:setScale(0.8)

	lc.addChildToPos(arg_2_0, var_2_11, cc.p(lc.w(arg_2_0) - 64, lc.h(arg_2_0) + 20))

	arg_2_0._pageLabel = var_2_11

	local var_2_12 = cc.Label:createWithTTF(arg_2_0._emptyTip, ClientView.TTF_FONT, ClientView.FontSize.S1)

	var_2_12:setPosition(lc.cw(arg_2_0), lc.ch(arg_2_0))
	var_2_12:setColor(ClientView.COLOR_LABEL_LIGHT)
	arg_2_0:addProtectedChild(var_2_12)

	arg_2_0._tip = var_2_12
end

function var_0_0.updatePage(arg_5_0, arg_5_1)
	arg_5_0._totalPage = #arg_5_0._data == 0 and 1 or math.floor((#arg_5_0._data - 1) / (arg_5_0._row * arg_5_0._col)) + 1

	if arg_5_1 then
		arg_5_0._curPage = 1
	end

	for iter_5_0 = 1, arg_5_0._row do
		for iter_5_1 = 1, arg_5_0._col do
			local var_5_0 = arg_5_0._items[iter_5_0][iter_5_1]
			local var_5_1 = arg_5_0._data[(arg_5_0._curPage - 1) * arg_5_0._row * arg_5_0._col + (iter_5_0 - 1) * arg_5_0._col + iter_5_1]

			arg_5_0._updateItemFunc(var_5_0, var_5_1)
		end
	end

	arg_5_0._pageLabel:setString(string.format("%s%d/%d%s", lc.str(STR.PAGE_PREFIX), arg_5_0._curPage, arg_5_0._totalPage, lc.str(STR.PAGE_SUFFIX)))
	arg_5_0._pageLeft:setVisible(arg_5_0._curPage > 1)
	arg_5_0._pageLeft:float()
	arg_5_0._pageRight:setVisible(arg_5_0._curPage < arg_5_0._totalPage)
	arg_5_0._pageRight:float()
	arg_5_0._tip:setVisible(#arg_5_0._data == 0)
end

function var_0_0.setData(arg_6_0, arg_6_1)
	arg_6_0._data = arg_6_1
end

function var_0_0.onEnter(arg_7_0)
	arg_7_0._listeners = {}

	arg_7_0:updatePage(true)
end

function var_0_0.onExit(arg_8_0)
	for iter_8_0 = 1, #arg_8_0._listeners do
		lc.Dispatcher:removeEventListener(arg_8_0._listeners[iter_8_0])
	end

	arg_8_0._listeners = {}
end

function var_0_0.refreshItems(arg_9_0)
	if not arg_9_0._data then
		return
	end

	for iter_9_0 = 1, arg_9_0._row do
		for iter_9_1 = 1, arg_9_0._col do
			local var_9_0 = arg_9_0._items[iter_9_0][iter_9_1]
			local var_9_1 = arg_9_0._data[(arg_9_0._curPage - 1) * arg_9_0._row * arg_9_0._col + (iter_9_0 - 1) * arg_9_0._col + iter_9_1]

			arg_9_0._updateItemFunc(var_9_0, var_9_1)
		end
	end
end

function var_0_0.onCleanup(arg_10_0)
	return
end

return var_0_0
