lc = lc or {}

local var_0_0 = class("LC_UI_List", lc.ExtendUIWidget)

var_0_0.DEFAULT_CACHE_COUNT = 10
var_0_0.TAG_EMPTY_LABEL = 1000

function var_0_0.createH(arg_1_0, arg_1_1, arg_1_2)
	return var_0_0.create(arg_1_0, lc.Dir.horizontal, arg_1_1, arg_1_2)
end

function var_0_0.createV(arg_2_0, arg_2_1, arg_2_2)
	return var_0_0.create(arg_2_0, lc.Dir.vertical, arg_2_1, arg_2_2)
end

function var_0_0.create(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = var_0_0.new(lc.EXTEND_LIST)

	if arg_3_1 == lc.Dir.horizontal then
		var_3_0:setDirection(ccui.ScrollViewDir.horizontal)
		var_3_0:setGravity(ccui.ListViewGravity.centerVertical)
	else
		var_3_0:setDirection(ccui.ScrollViewDir.vertical)
		var_3_0:setGravity(ccui.ListViewGravity.centerHorizontal)
	end

	var_3_0:setContentSize(arg_3_0)
	var_3_0:setBoundMargin(arg_3_2 or 20)
	var_3_0:setItemsMargin(arg_3_3 or 20)
	var_3_0:setBounceEnabled(true)
	var_3_0:setCascadeOpacityEnabled(true)

	return var_3_0
end

function var_0_0.bindData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0:removeAllItems()

	arg_4_0._data = arg_4_1

	if arg_4_1 then
		arg_4_0._keepCount = arg_4_4 or 0
		arg_4_0._cacheCount = arg_4_3 or var_0_0.DEFAULT_CACHE_COUNT
		arg_4_0._dataFunc = arg_4_2
		arg_4_0._indexBegin = 1
		arg_4_0._indexEnd = arg_4_0._cacheCount

		arg_4_0:addScrollViewEventListener(function(arg_5_0, arg_5_1)
			arg_4_0:onScroll(arg_5_1)
		end)
	else
		arg_4_0:addScrollViewEventListener(function()
			return
		end)
	end
end

function var_0_0.checkEmpty(arg_7_0, arg_7_1)
	if #arg_7_0:getItems() == 0 then
		if arg_7_1 then
			local var_7_0

			if type(arg_7_1) == "string" then
				var_7_0 = ClientView.createTTF(arg_7_1, ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)
			else
				var_7_0 = arg_7_1
			end

			arg_7_0:removeChildByTag(var_0_0.TAG_EMPTY_LABEL)
			lc.addChildToCenter(arg_7_0, var_7_0, 0, var_0_0.TAG_EMPTY_LABEL)
			arg_7_0:runAction(lc.sequence(0, function()
				arg_7_0:getInnerContainer():setContentSize(arg_7_0:getContentSize())
				arg_7_0:getInnerContainer():setPosition(0, 0)
			end))
		end

		return true
	end

	return false
end

function var_0_0.refreshItems(arg_9_0)
	local var_9_0 = arg_9_0._data

	if not var_9_0 then
		return
	end

	local var_9_2 = (arg_9_0._items and #arg_9_0._items > 0 and arg_9_0._items) or arg_9_0:getItems()
	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		local var_9_1 = var_9_0[arg_9_0._indexBegin + iter_9_0 - 1]

		arg_9_0._dataFunc(iter_9_1, var_9_1, arg_9_0._indexBegin + iter_9_0 - 1)
	end
end

function var_0_0.checkOutOfBoundItems(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getItems()
	local var_10_1 = {}
	local var_10_2
	local var_10_3

	if arg_10_1 == ccui.ScrollviewEventType.scrollToRight then
		local var_10_4 = lc.w(arg_10_0)
		local var_10_5 = arg_10_0:getInnerContainerSize().width

		for iter_10_0 = 1, #var_10_0 do
			local var_10_6 = var_10_0[iter_10_0]

			if var_10_4 < var_10_5 - lc.right(var_10_6) then
				table.insert(var_10_1, var_10_6)
			else
				break
			end
		end

		var_10_2 = var_10_0[#var_10_0]
		var_10_3 = lc.Dir.left
	elseif arg_10_1 == ccui.ScrollviewEventType.scrollToLeft then
		local var_10_7 = lc.w(arg_10_0)

		for iter_10_1 = #var_10_0, 1, -1 do
			local var_10_8 = var_10_0[iter_10_1]

			if var_10_7 < lc.left(var_10_8) then
				table.insert(var_10_1, var_10_8)
			else
				break
			end
		end

		var_10_2 = var_10_0[1]
		var_10_3 = lc.Dir.right
	elseif arg_10_1 == ccui.ScrollviewEventType.scrollToBottom then
		local var_10_9 = lc.h(arg_10_0)

		for iter_10_2 = 1, #var_10_0 do
			local var_10_10 = var_10_0[iter_10_2]

			if var_10_9 < lc.bottom(var_10_10) then
				table.insert(var_10_1, var_10_10)
			else
				break
			end
		end

		var_10_2 = var_10_0[#var_10_0]
		var_10_3 = lc.Dir.top
	elseif arg_10_1 == ccui.ScrollviewEventType.scrollToTop then
		local var_10_11 = lc.h(arg_10_0)
		local var_10_12 = arg_10_0:getInnerContainerSize().height

		for iter_10_3 = #var_10_0, 1, -1 do
			local var_10_13 = var_10_0[iter_10_3]

			if var_10_11 < var_10_12 - lc.top(var_10_13) then
				table.insert(var_10_1, var_10_13)
			else
				break
			end
		end

		var_10_2 = var_10_0[1]
		var_10_3 = lc.Dir.bottom
	end

	for iter_10_4 = 1, arg_10_0._keepCount do
		table.remove(var_10_1)
	end

	return var_10_3, var_10_1, var_10_2
end

function var_0_0.onScroll(arg_11_0, arg_11_1)
	if arg_11_0._data == nil or arg_11_0._dataFunc == nil then
		return
	end

	local var_11_0, var_11_1, var_11_2 = arg_11_0:checkOutOfBoundItems(arg_11_1)

	if var_11_0 == nil or var_11_2 == nil then
		return
	end

	local var_11_3 = arg_11_0._data._count or #arg_11_0._data

	if var_11_0 == lc.Dir.top or var_11_0 == lc.Dir.left then
		local var_11_4 = var_11_3 - arg_11_0._indexEnd

		if var_11_4 < #var_11_1 then
			for iter_11_0 = 1, #var_11_1 - var_11_4 do
				table.remove(var_11_1)
			end
		end

		for iter_11_1, iter_11_2 in ipairs(var_11_1) do
			arg_11_0._indexEnd = arg_11_0._indexEnd + 1

			arg_11_0._dataFunc(iter_11_2, arg_11_0._data[arg_11_0._indexEnd])
		end

		arg_11_0._indexBegin = arg_11_0._indexEnd - arg_11_0._cacheCount + 1
	elseif var_11_0 == lc.Dir.bottom or var_11_0 == lc.Dir.right then
		local var_11_5 = arg_11_0._indexBegin - 1

		if var_11_5 < #var_11_1 then
			for iter_11_3 = 1, #var_11_1 - var_11_5 do
				table.remove(var_11_1)
			end
		end

		for iter_11_4, iter_11_5 in ipairs(var_11_1) do
			arg_11_0._indexBegin = arg_11_0._indexBegin - 1

			arg_11_0._dataFunc(iter_11_5, arg_11_0._data[arg_11_0._indexBegin])
		end

		arg_11_0._indexEnd = arg_11_0._indexBegin + arg_11_0._cacheCount - 1
	end

	if #var_11_1 > 0 then
		local var_11_6 = var_11_2 == arg_11_0:getItem(0)

		for iter_11_6, iter_11_7 in ipairs(var_11_1) do
			iter_11_7:retain()
			arg_11_0:removeItemWithCleanup(iter_11_7, false)

			if var_11_6 then
				arg_11_0:insertCustomItem(iter_11_7, 0)
			else
				arg_11_0:pushBackCustomItem(iter_11_7)
			end

			iter_11_7:release()
		end

		local var_11_7 = arg_11_0:getInnerContainer()

		if var_11_0 == lc.Dir.left then
			arg_11_0:forceDoLayout()
			lc.offset(var_11_7, lc.w(var_11_7) - lc.right(var_11_2) - arg_11_0:getEndMargin())
		elseif var_11_0 == lc.Dir.right then
			arg_11_0:forceDoLayout()
			lc.offset(var_11_7, -lc.left(var_11_2) + arg_11_0:getStartMargin())
		elseif var_11_0 == lc.Dir.top then
			local var_11_8 = lc.h(var_11_7)

			arg_11_0:forceDoLayout()
			lc.offset(var_11_7, 0, -lc.bottom(var_11_2) + math.max(0, lc.h(var_11_7) - var_11_8) + arg_11_0:getEndMargin())
		elseif var_11_0 == lc.Dir.bottom then
			arg_11_0:forceDoLayout()
			lc.offset(var_11_7, 0, lc.h(var_11_7) - lc.top(var_11_2) - arg_11_0:getStartMargin())
		end
	end
end

function var_0_0.setDataToItems(arg_12_0, arg_12_1)
	if arg_12_0._data == nil or arg_12_0._dataFunc == nil then
		return
	end

	if arg_12_1 then
		arg_12_0._indexBegin = 1
		arg_12_0._indexEnd = arg_12_0._cacheCount
	else
		local var_12_0 = arg_12_0._data._count or #arg_12_0._data

		arg_12_0._indexBegin = var_12_0 - arg_12_0._cacheCount + 1
		arg_12_0._indexEnd = var_12_0
	end

	local var_12_1 = (arg_12_0._items and #arg_12_0._items > 0 and arg_12_0._items) or arg_12_0:getItems()
	local var_12_2 = arg_12_0._indexBegin

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		arg_12_0._dataFunc(iter_12_1, arg_12_0._data[var_12_2])

		var_12_2 = var_12_2 + 1
	end
end

function var_0_0.gotoLeft(arg_13_0)
	if arg_13_0:getDirection() ~= ccui.ScrollViewDir.horizontal then
		return
	end

	arg_13_0:setDataToItems(true)
	arg_13_0:jumpToLeft()
end

function var_0_0.gotoRight(arg_14_0)
	if arg_14_0:getDirection() ~= ccui.ScrollViewDir.horizontal then
		return
	end

	arg_14_0:setDataToItems(false)
	arg_14_0:jumpToRight()
end

function var_0_0.gotoTop(arg_15_0)
	if arg_15_0:getDirection() ~= ccui.ScrollViewDir.vertical then
		return
	end

	arg_15_0:setDataToItems(true)
	arg_15_0:jumpToTop()
end

function var_0_0.gotoBottom(arg_16_0)
	if arg_16_0:getDirection() ~= ccui.ScrollViewDir.vertical then
		return
	end

	arg_16_0:setDataToItems(false)
	arg_16_0:jumpToBottom()
end

function var_0_0.gotoPos(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 >= 0 and arg_17_1 or 0

	arg_17_0:setDataToItems(false)

	local var_17_0 = arg_17_0:getInnerContainer():getContentSize()

	if arg_17_0:getDirection() == ccui.ScrollViewDir.vertical then
		local var_17_1 = var_17_0.height - lc.h(arg_17_0)

		if var_17_1 > 0 then
			arg_17_0:jumpToPercentVertical(arg_17_1 * 100 / var_17_1)
		end
	else
		local var_17_2 = var_17_0.width - lc.w(arg_17_0)

		if var_17_2 > 0 then
			arg_17_0:jumpToPercentHorizontal(arg_17_1 * 100 / var_17_2)
		end
	end
end

function var_0_0.isAtBegin(arg_18_0)
	local var_18_0 = arg_18_0:getInnerContainer()
	local var_18_1, var_18_2 = var_18_0:getPosition()
	local var_18_3 = arg_18_0:getContentSize()
	local var_18_4 = var_18_0:getContentSize()

	if arg_18_0:getDirection() == ccui.ScrollViewDir.vertical then
		return math.abs(var_18_2 - (var_18_3.height - var_18_4.height)) < 1
	else
		return math.abs(var_18_1) < 1
	end
end

function var_0_0.isAtEnd(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0:getInnerContainer():getPosition()

	if arg_19_0:getDirection() == ccui.ScrollViewDir.vertical then
		return math.abs(var_19_1) < 1
	else
		return math.abs(var_19_0 - (listSize.width - innerSize.width)) < 1
	end
end

function var_0_0.setIsScrollEnabled(arg_20_0, arg_20_1)
	if arg_20_1 then
		if arg_20_0._savedScrollDir then
			arg_20_0:setDirection(arg_20_0._savedScrollDir)
		else
			arg_20_0:setDirection(ccui.ScrollViewDir.horizontal)
		end
		arg_20_0:setTouchEnabled(true)
	else
		local curDir = arg_20_0:getDirection()
		if curDir ~= ccui.ScrollViewDir.none then
			arg_20_0._savedScrollDir = curDir
		end
		arg_20_0:setDirection(ccui.ScrollViewDir.none)
	end
end

lc.List = var_0_0

return var_0_0
