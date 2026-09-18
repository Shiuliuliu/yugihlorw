local var_0_0 = class("UnionSearchArea", lc.ExtendCCNode)
local var_0_1 = 800
local var_0_2 = {
	id = 2,
	name = 1,
	level = 3
}

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(math.min(arg_1_0, var_0_1), arg_1_1)
	var_1_0:init()
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0)
	local var_3_0 = lc.w(arg_3_0)
	local var_3_1 = lc.h(arg_3_0)
	local var_3_2 = lc.createSprite({
		_name = "img_com_bg_4",
		_crect = ClientView.CRECT_COM_BG4,
		_size = cc.size(var_3_0 - 12, 110)
	})

	lc.addChildToPos(arg_3_0, var_3_2, cc.p(var_3_0 / 2 + 4, var_3_1 - lc.h(var_3_2) / 2 - 8), 1)

	local var_3_3 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_4_0)
		arg_3_0:searchUnion()
	end, ClientView.CRECT_BUTTON_S, 160)

	var_3_3:addIcon("img_icon_search")
	var_3_3:addLabel(Str(STR.SEARCH))
	lc.addChildToPos(var_3_2, var_3_3, cc.p(lc.w(var_3_2) - lc.w(var_3_3) / 2 - 30, lc.h(var_3_2) / 2 + 4), 1)

	local var_3_4 = ClientView.createScale9ShaderButton("img_com_bg_5", nil, ClientView.CRECT_COM_BG5, 180, 56)
	local var_3_5 = ClientView.createTTF("", ClientView.FontSize.S1)

	lc.addChildToPos(var_3_4, var_3_5, cc.p(lc.w(var_3_4) / 2, lc.h(var_3_4) / 2 + 1))
	lc.addChildToPos(var_3_2, var_3_4, cc.p(lc.w(var_3_4) / 2 + 30, lc.y(var_3_3)))
	var_3_5:setString(Str(STR.UNION_NAME))

	var_3_4._label = var_3_5
	var_3_4._filter = var_0_2.name

	function var_3_4._callback()
		local function var_5_0(arg_6_0, arg_6_1)
			return {
				_str = arg_6_0,
				_handler = function()
					var_3_4._filter = arg_6_1

					var_3_4._label:setString(arg_6_0)
				end
			}
		end

		local var_5_1 = {
			var_5_0(Str(STR.UNION_NAME), var_0_2.name),
			var_5_0(Str(STR.UNION) .. " ID", var_0_2.id)
		}

		arg_3_0:popSelectPanel(var_3_4, var_5_1)
	end

	arg_3_0._btnFilter = var_3_4

	local var_3_6 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(lc.left(var_3_3) - 10 - lc.w(var_3_4), 56), nil, true)

	lc.addChildToPos(var_3_2, var_3_6, cc.p(lc.right(var_3_4) + lc.w(var_3_6) / 2, lc.y(var_3_3)))

	arg_3_0._iptSearch = var_3_6

	local var_3_7 = lc.List.createV(cc.size(var_3_0 - 12, lc.bottom(var_3_2) + 8), 6, 0)

	lc.addChildToPos(arg_3_0, var_3_7, cc.p(10, 0))

	arg_3_0._unionList = var_3_7
end

function var_0_0.popSelectPanel(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = require("TopMostPanel").ButtonList.create(cc.size(200, lc.h(arg_8_0)))

	if var_8_0 then
		local var_8_1 = lc.convertPos(cc.p(lc.w(arg_8_1) / 2, lc.h(arg_8_1) / 2), arg_8_1)

		var_8_0:setButtonDefs(arg_8_2)
		var_8_0:setPosition(var_8_1.x, var_8_1.y - lc.h(var_8_0) / 2 - 24)
		var_8_0:linkNode(arg_8_1)
		var_8_0:show()
	end
end

function var_0_0.updateUnionList(arg_9_0, arg_9_1)
	if arg_9_0._indicator then
		arg_9_0._indicator:removeFromParent()

		arg_9_0._indicator = nil
	end

	local var_9_0 = arg_9_0._unionList

	var_9_0:removeAllItems()
	var_9_0:bindData(arg_9_1, function(arg_10_0, arg_10_1)
		arg_9_0:setOrCreateUnionItem(arg_10_0, arg_10_1)
	end, math.min(6, #arg_9_1))

	for iter_9_0 = 1, var_9_0._cacheCount do
		local var_9_1 = arg_9_0:setOrCreateUnionItem(nil, arg_9_1[iter_9_0])

		var_9_0:pushBackCustomItem(var_9_1)
	end

	var_9_0:checkEmpty(Str(STR.LIST_EMPTY_SEARCH))
	var_9_0:refreshView()
	var_9_0:gotoTop()
end

function var_0_0.setOrCreateUnionItem(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == nil then
		arg_11_1 = ccui.Widget:create()

		arg_11_1:setContentSize(lc.w(arg_11_0._unionList), 140)
		arg_11_1:setTouchEnabled(true)
		arg_11_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

		local var_11_0 = lc.createSprite({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35,
			_size = arg_11_1:getContentSize()
		})

		lc.addChildToCenter(arg_11_1, var_11_0, -1)

		arg_11_1._bg = var_11_0

		local var_11_1 = require("UnionWidget").create(nil, true)

		lc.addChildToPos(arg_11_1, var_11_1, cc.p(lc.w(var_11_1) / 2 + 50, lc.h(arg_11_1) / 2))

		arg_11_1._unionWidget = var_11_1

		local var_11_2 = ClientView.createTTF("", ClientView.FontSize.S2, ClientView.COLOR_LABEL_DARK)

		var_11_2:setAnchorPoint(1, 0.5)
		lc.addChildToPos(arg_11_1, var_11_2, cc.p(lc.w(arg_11_1) - 50, lc.h(arg_11_1) / 2 + 20))

		arg_11_1._joinType = var_11_2

		local var_11_3 = ClientView.createTTF("", ClientView.FontSize.S2, ClientView.COLOR_LABEL_DARK)

		var_11_3:setAnchorPoint(1, 0.5)
		lc.addChildToPos(arg_11_1, var_11_3, cc.p(lc.x(var_11_2), lc.h(arg_11_1) / 2 - 20))

		arg_11_1._level = var_11_3
	end

	arg_11_1:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 == ccui.TouchEventType.ended then
			if P:hasUnion() then
				if arg_11_2._id ~= P._unionId then
					require("UnionDetailForm").create(arg_11_1._union._id):show()
				end
			else
				ClientView.operateUnion(arg_11_1._union, arg_11_1)
			end
		end
	end)

	arg_11_1._union = arg_11_2

	arg_11_1._bg:setColor(arg_11_2._id == P._unionId and ClientView.COLOR_TEXT_GREEN or lc.Color3B.white)
	arg_11_1._unionWidget:setUnion(arg_11_2)
	arg_11_1._joinType:setString(Str(STR.UNION_TYPE_ANY + arg_11_2._joinType - 1))

	if arg_11_2._reqLevel > P._playerCity:getUnionUnlockLevel() then
		arg_11_1._level:setString(string.format("%s %d", Str(STR.LORD_LEVEL), arg_11_2._reqLevel))
	else
		arg_11_1._level:setString("")
	end

	return arg_11_1
end

function var_0_0.searchUnion(arg_13_0)
	local var_13_0 = arg_13_0._iptSearch:getText()

	arg_13_0._iptSearch:setText("")

	if var_13_0 == "" then
		arg_13_0._indicator = ClientView.showPanelActiveIndicator(arg_13_0)

		ClientData.sendGetRecommandUnions()
	else
		local var_13_1 = arg_13_0._btnFilter._filter
		local var_13_2 = {
			"name",
			"id",
			"level"
		}

		if var_13_1 == var_0_2.id or var_13_1 == var_0_2.level then
			var_13_0 = tonumber(var_13_0)

			if var_13_0 == nil then
				ToastManager.push(Str(STR.INVALID_SEARCH))

				return
			end
		end

		arg_13_0._indicator = ClientView.showPanelActiveIndicator(arg_13_0)

		ClientData.sendGetSearchUnions(var_13_2[var_13_1], var_13_0)
	end
end

function var_0_0.onEnter(arg_14_0)
	arg_14_0._listeners = {}

	local var_14_0 = lc.addEventListener(Data.Event.union_search_dirty, function(arg_15_0)
		arg_14_0:updateUnionList(P._playerUnion:getSearchUnions())
	end)

	table.insert(arg_14_0._listeners, var_14_0)

	local var_14_1 = lc.addEventListener(Data.Event.union_recommand_dirty, function(arg_16_0)
		arg_14_0:updateUnionList(P._playerUnion:getRecommandUnions())
	end)

	table.insert(arg_14_0._listeners, var_14_1)

	arg_14_0._indicator = ClientView.showPanelActiveIndicator(arg_14_0)

	ClientData.sendGetRecommandUnions()
end

function var_0_0.onExit(arg_17_0)
	for iter_17_0 = 1, #arg_17_0._listeners do
		lc.Dispatcher:removeEventListener(arg_17_0._listeners[iter_17_0])
	end
end

return var_0_0
