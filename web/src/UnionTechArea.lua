local var_0_0 = class("UnionTechArea", lc.ExtendCCNode)
local var_0_1 = require("TechWidget")
local var_0_2 = 490
local var_0_3 = 10
local var_0_4 = var_0_1.ITEM_SIZE

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(cc.size(arg_1_0, arg_1_1))
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
	local var_3_0 = ClientView.createLineSprite("img_divide_line_4", lc.w(arg_3_0))
	local var_3_1 = lc.h(arg_3_0) - 58 - lc.h(var_3_0) / 2

	lc.addChildToPos(arg_3_0, var_3_0, cc.p(lc.w(arg_3_0) / 2, var_3_1), 1)

	arg_3_0._frameTopLine = var_3_0

	ClientView.addVerticalTabButtons(arg_3_0, {
		Str(STR.LORD),
		Str(STR.EQUIP),
		Str(STR.MONSTER)
	}, lc.bottom(var_3_0), 16)
	arg_3_0:createBottomArea()

	local var_3_2 = lc.List.createH(cc.size(lc.w(arg_3_0) - lc.right(arg_3_0._tabArea), var_0_2), 24, 36)

	lc.addChildToPos(arg_3_0, var_3_2, cc.p(lc.right(arg_3_0._tabArea), lc.bottom(arg_3_0._frameTopLine) - var_0_2 + 8))

	arg_3_0._techList = var_3_2

	arg_3_0:showTab(1)
end

function var_0_0.createBottomArea(arg_4_0)
	local var_4_0 = lc.createSprite("img_troop_bg")

	var_4_0:setScaleX(lc.w(arg_4_0) / lc.w(var_4_0) + 0.1)
	var_4_0:setRotation(180)

	local var_4_1 = lc.createNode(cc.size(lc.w(arg_4_0), lc.h(var_4_0)))

	lc.addChildToPos(arg_4_0, var_4_1, cc.p(lc.w(arg_4_0) / 2, lc.h(var_4_1) / 2 - 8))
	lc.addChildToCenter(var_4_1, var_4_0)

	arg_4_0._bottomArea = var_4_1

	local var_4_2 = lc.createSprite({
		_name = "card_label_equiped",
		_crect = cc.rect(0, 44, 58, 1),
		_size = cc.size(58, 140)
	})

	var_4_2:setFlippedX(true)
	var_4_2:setColor(lc.Color3B.yellow)
	lc.addChildToPos(var_4_1, var_4_2, cc.p(lc.w(var_4_2) / 2 + 2, lc.h(var_4_1) / 2 + 1), 1)

	local var_4_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.PERSONAL) .. Str(STR.TECH), cc.TEXT_ALIGNMENT_CENTER, 20)

	var_4_3:setScale(0.8)
	var_4_3:setColor(lc.Color3B.yellow)
	lc.addChildToPos(var_4_1, var_4_3, cc.p(lc.x(var_4_2) - 2, lc.y(var_4_2) + 8), 1)

	local var_4_4 = lc.List.createH(cc.size(lc.w(arg_4_0) - lc.w(var_4_2) + 16, var_0_1.ICON_SIZE.height + 10), 20, 10)

	lc.addChildToPos(var_4_1, var_4_4, cc.p(lc.right(var_4_2) - 20, 10))

	arg_4_0._ownTechList = var_4_4
end

function var_0_0.showTab(arg_5_0, arg_5_1)
	arg_5_0._tabArea:showTab(arg_5_1)
	arg_5_0:updateTabContent()
end

function var_0_0.updateTabContent(arg_6_0)
	local var_6_0 = arg_6_0._tabArea._focusTabIndex
	local var_6_1 = arg_6_0._techList
	local var_6_2 = arg_6_0._ownTechList
	local var_6_3 = P._playerUnion:getMyUnion()
	local var_6_4 = var_6_0 - 1
	local var_6_5 = {}
	local var_6_6 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_3._techs) do
		if iter_6_1._info._type == var_6_4 then
			table.insert(var_6_5, iter_6_1)
		end
	end

	for iter_6_2, iter_6_3 in pairs(P._playerUnion._techs) do
		if iter_6_3._info._type == var_6_4 then
			table.insert(var_6_6, iter_6_3)
		end
	end

	local function var_6_7(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0._info
		local var_7_1 = arg_7_1._info

		if var_7_0._unlockLevel == var_7_1._unlockLevel then
			return var_7_0._id < var_7_1._id
		else
			return var_7_0._unlockLevel < var_7_1._unlockLevel
		end
	end

	table.sort(var_6_5, var_6_7)
	table.sort(var_6_6, var_6_7)

	local var_6_8 = lc.arrayToTable(var_6_5, 2)

	var_6_1:bindData(var_6_8, function(arg_8_0, arg_8_1)
		arg_6_0:setOrCreateTechItem(arg_8_0, arg_8_1)
	end, math.min(7, #var_6_8))

	for iter_6_4 = 1, var_6_1._cacheCount do
		local var_6_9 = arg_6_0:setOrCreateTechItem(nil, var_6_8[iter_6_4])

		var_6_1:pushBackCustomItem(var_6_9)
	end

	var_6_1:jumpToLeft()
	var_6_2:bindData(var_6_6, function(arg_9_0, arg_9_1)
		arg_6_0:setOrCreateOwnTechItem(arg_9_0, arg_9_1)
	end, math.min(12, #var_6_6))

	for iter_6_5 = 1, var_6_2._cacheCount do
		local var_6_10 = arg_6_0:setOrCreateOwnTechItem(nil, var_6_6[iter_6_5])

		var_6_2:pushBackCustomItem(var_6_10)
	end

	var_6_2:jumpToLeft()

	if var_6_4 == Data.UnionTechType.equip then
		var_6_1:checkEmpty(Str(STR.LIST_EMPTY_UNION_TECH_EQUIP))
	elseif var_6_4 == Data.UnionTechType.hero then
		var_6_1:checkEmpty(Str(STR.LIST_EMPTY_UNION_TECH_HERO))
	end
end

function var_0_0.setOrCreateTechItem(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == nil then
		local var_10_0 = var_0_4.width
		local var_10_1 = var_0_4.height + var_0_3 + var_0_4.height

		arg_10_1 = ccui.Widget:create()

		arg_10_1:setContentSize(var_10_0, var_10_1)

		arg_10_1._techItems = {}

		local var_10_2 = var_10_0 / 2
		local var_10_3 = var_10_1 - var_0_4.height / 2

		arg_10_1._pos = {
			cc.p(var_10_2, var_10_3),
			cc.p(var_10_2, var_10_3 - var_0_4.height - var_0_3)
		}
	end

	local var_10_4 = arg_10_1._techItems

	for iter_10_0 = 1, 2 do
		local var_10_5 = var_10_4[iter_10_0]
		local var_10_6 = arg_10_2[iter_10_0]

		if iter_10_0 <= #arg_10_2 then
			local var_10_7 = var_10_6._level == 0

			if var_10_5 == nil then
				var_10_5 = var_0_1.create(var_10_6, var_10_7)

				lc.addChildToPos(arg_10_1, var_10_5, arg_10_1._pos[iter_10_0])

				var_10_4[iter_10_0] = var_10_5
			else
				var_10_5:updateTech(var_10_6, var_10_7)
			end

			var_10_5:setGray(var_10_7)
			var_10_5:setVisible(true)

			function var_10_5._callback()
				require("UnionTechForm").create(var_10_6, true):show()
			end
		elseif var_10_5 then
			var_10_5:setVisible(false)
		end
	end

	return arg_10_1
end

function var_0_0.setOrCreateOwnTechItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0, var_12_1 = P._playerUnion:getTech(arg_12_2._infoId)
	local var_12_2 = var_12_1 == 0

	if arg_12_1 == nil then
		arg_12_1 = var_0_1.createIcon(arg_12_2, var_12_2)
	else
		arg_12_1:updateTech(arg_12_2, var_12_2)
	end

	arg_12_1:setGray(var_12_2)

	function arg_12_1._callback()
		require("UnionTechForm").create(arg_12_2):show()
	end

	return arg_12_1
end

function var_0_0.onEnter(arg_14_0)
	ClientData.addMsgListener(arg_14_0, function(arg_15_0)
		return arg_14_0:onMsg(arg_15_0)
	end, 0)

	arg_14_0._listeners = {}

	table.insert(arg_14_0._listeners, lc.addEventListener(Data.Event.union_level_upgrade, function()
		arg_14_0:updateTabContent()
	end))
end

function var_0_0.onExit(arg_17_0)
	for iter_17_0 = 1, #arg_17_0._listeners do
		lc.Dispatcher:removeEventListener(arg_17_0._listeners[iter_17_0])
	end

	ClientData.removeMsgListener(arg_17_0)
end

function var_0_0.onMsg(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.type

	return false
end

return var_0_0
