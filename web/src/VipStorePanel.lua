local var_0_0 = class("CardInfoPanel", require("BasePanel"))
local var_0_1 = require("CardInfoPanel")
local var_0_2 = cc.size(280, 600)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	var_0_0.super.init(arg_2_0, false)

	local var_2_0 = lc.createSprite(lc.formatJpg("vip_store_bg"))

	lc.addChildToCenter(arg_2_0, var_2_0)
	arg_2_0:addChild(arg_2_0:createTopArea(), 1)
	arg_2_0:generateData()

	arg_2_0._list = require("ItemList").create(cc.size(lc.w(arg_2_0) - 90, lc.bottom(arg_2_0._topArea)), var_0_2, Str(STR.LIST_EMPTY_NO_GOOD), function()
		return arg_2_0:setOrCreateItem()
	end, function(arg_4_0, arg_4_1)
		return arg_2_0:setOrCreateItem(arg_4_0, arg_4_1)
	end, 1, 3)

	arg_2_0._list:setAnchorPoint(0.5, 0)
	lc.addChildToPos(arg_2_0, arg_2_0._list, cc.p(lc.cw(arg_2_0), 0))
	arg_2_0._list._pageLabel:setPosition(-120, 20)
	arg_2_0._list:setData(arg_2_0._exchanges)

	if #arg_2_0._exchanges == 1 then
		arg_2_0._list._items[1][1]:setPositionX(lc.cw(arg_2_0._list))
	end
end

function var_0_0.generateData(arg_5_0)
	local var_5_0 = {}

	arg_5_0._exchanges = var_5_0

	for iter_5_0, iter_5_1 in pairs(Data._exchangeInfo) do
		if iter_5_1._activityId == 3003 then
			var_5_0[#var_5_0 + 1] = iter_5_1
		end
	end
end

function var_0_0.createTopArea(arg_6_0)
	local var_6_0 = ClientView.createTitleArea(Str(STR.VIP_SHOP), function()
		arg_6_0:hide()
	end)

	arg_6_0._topArea = var_6_0

	return var_6_0
end

function var_0_0.setOrCreateItem(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 then
		arg_8_1 = lc.createNode(var_0_2)

		local var_8_0 = lc.createSprite("vip_store_item")

		lc.addChildToPos(arg_8_1, var_8_0, cc.p(lc.cw(arg_8_1), lc.ch(var_8_0) + 50))

		local var_8_1 = DragonBones.create("sd")

		var_8_1:gotoAndPlay("effect")
		var_8_1:setScale(1.1)
		lc.addChildToPos(var_8_0, var_8_1, cc.p(lc.cw(var_8_0), lc.h(var_8_0) - 60), 1)

		local var_8_2 = 0.8
		local var_8_3 = ClientView.createShaderButton(nil, function()
			var_0_1.create(arg_8_1._cid, 1, var_0_1.OperateType.view):show()
		end)
		local var_8_4 = require("CardThumbnail").create(10001, 1)

		var_8_4:setScale(var_8_2)
		var_8_3:setContentSize(lc.w(var_8_4) * var_8_2, lc.h(var_8_4) * var_8_2)
		lc.addChildToCenter(var_8_3, var_8_4)
		lc.addChildToPos(var_8_0, var_8_3, cc.p(lc.cw(var_8_0), lc.h(var_8_0) + lc.ch(var_8_3) - 50))

		arg_8_1._icons = {}

		for iter_8_0 = 1, 3 do
			arg_8_1._icons[#arg_8_1._icons + 1] = IconWidget.createByInfoId(10001, 1, IconWidget.ITEM)
		end

		lc.addNodesToCenter(var_8_0, arg_8_1._icons, -40, 40)

		local var_8_5 = ClientView.createShaderButton("god_pump_btn", function(arg_10_0)
			arg_8_0:onExchange(arg_8_1._exchangeId)
		end)

		var_8_5:setDisabledShader(ClientView.SHADER_DISABLE)
		lc.addChildToPos(arg_8_1, var_8_5, cc.p(lc.cw(arg_8_1), lc.ch(var_8_5) - 10))
		var_8_5:addLabel(Str(STR.EXCHANGE))

		arg_8_1._exchangeBtn = var_8_5

		function arg_8_1.update(arg_11_0)
			arg_8_1:setVisible(arg_11_0 ~= nil)

			if arg_11_0 then
				arg_8_1._exchange = arg_11_0

				local var_11_0 = arg_11_0._id

				arg_8_1._exchangeId = var_11_0

				local var_11_1 = arg_11_0._item
				local var_11_2 = arg_11_0._number
				local var_11_3 = arg_11_0._reward
				local var_11_4 = Data._bonusInfo[var_11_3]
				local var_11_5 = var_11_4._rid[1]
				local var_11_6 = var_11_4._count[1]

				arg_8_1._cid = var_11_5

				var_8_4:updateComponent(var_11_5)

				for iter_11_0, iter_11_1 in ipairs(arg_8_1._icons) do
					local var_11_7 = var_11_1[iter_11_0]
					local var_11_8 = var_11_2[iter_11_0]

					iter_11_1:setScale(0.6)

					if var_11_7 then
						iter_11_1:setVisible(true)
						iter_11_1:resetData({
							_infoId = var_11_7,
							_count = var_11_8
						})
						arg_8_1._icons[iter_11_0]:setGray(var_11_8 > P:getItemCount(var_11_7))
					else
						iter_11_1:setVisible(false)
					end
				end

				local var_11_9 = P._playerMarket._exchangeMap[var_11_0] or 0

				if arg_11_0._time ~= 0 then
					if arg_11_0._time - var_11_9 <= 0 then
						var_8_5._label:setString(Str(STR.EXCHANGED))
						var_8_5:setEnabled(false)
					else
						var_8_5._label:setString(Str(STR.EXCHANGE))
						var_8_5:setEnabled(true)
					end
				else
					var_8_5._label:setString(Str(STR.EXCHANGE))
				end
			end
		end
	end

	arg_8_1.update(arg_8_2)

	return arg_8_1
end

function var_0_0.onExchange(arg_12_0, arg_12_1)
	require("Dialog").showDialog(Str(STR.CONFIRM_EXCHANGE_VIP), function()
		arg_12_0:doExchange(arg_12_1)
	end)
end

function var_0_0.doExchange(arg_14_0, arg_14_1)
	local var_14_0 = true
	local var_14_1 = Data._exchangeInfo[arg_14_1]
	local var_14_2 = var_14_1._item
	local var_14_3 = var_14_1._reward
	local var_14_4 = Data._bonusInfo[var_14_3]
	local var_14_5 = var_14_4._rid[1]

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		if P:getItemCount(iter_14_1) < var_14_1._number[iter_14_0] then
			var_14_0 = false

			break
		end
	end

	if var_14_0 then
		local var_14_6 = P._playerMarket._exchangeMap[var_14_1._id] or 0

		if var_14_1._time ~= 0 and var_14_1._time - var_14_6 <= 0 then
			return ToastManager.push(Str(STR.EXCHANGED))
		end

		P._playerMarket:exchangeProp(var_14_1)

		local var_14_7 = require("RewardPanel")

		var_14_7.create({
			{
				info_id = var_14_5,
				num = var_14_4._count[1]
			}
		}, var_14_7.MODE_EXCHANGE):show()
		arg_14_0._list:refreshItems()
	else
		return ToastManager.push(Str(STR.EXCHANGE_ITEM_NOT_ENOUGH))
	end
end

return var_0_0
