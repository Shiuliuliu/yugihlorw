local var_0_0 = class("ResourcePanel", lc.ExtendCCNode)
local var_0_1 = cc.size(200, 46)
local var_0_2 = cc.size(172, var_0_1.height)
local var_0_3 = 16

var_0_0.PropId = {
	Data.PropsId.yubi,
	Data.ResType.clash_trophy,
	Data.ResType.ladder_trophy,
	Data.ResType.union_battle_trophy,
	Data.ResType.dark_trophy,
	Data.ResType.survival_ex_trophy,
	Data.PropsId.ladder_ticket,
	Data.PropsId.survival_ticket,
	Data.PropsId.lottery_token,
	Data.PropsId.week_lottery_token,
	Data.PropsId.dark_lottery_token,
	Data.PropsId.spring_lottery_token,
	Data.PropsId.rare_package_ticket,
	Data.PropsId.character_package_ticket,
	Data.PropsId.critical_package_ticket,
	Data.PropsId.rare_package_dust,
	Data.PropsId.character_package_dust,
	Data.PropsId.dark_ticket,
	Data.PropsId.skin_crystal,
	Data.PropsId.avatar_skin_crystal,
	Data.PropsId.effect_skin_crystal,
	Data.PropsId.rare_coin,
	Data.PropsId.void_diamond,
	Data.PropsId.obelisk_badge,
	Data.PropsId.common_fragment,
	Data.PropsId.special_common_fragment,
	Data.PropsId.dragon_man,
	Data.PropsId.time_role_package_ticket,
	Data.PropsId.lottery_reset_token,
	7198,
	Data.PropsId.cumulative_exchange_token,
	Data.PropsId.week_lottery_token,
	Data.PropsId.vote_token,
	Data.PropsId.clash_token_1,
	Data.PropsId.clash_token_2,
	Data.PropsId.clash_token_3,
	Data.PropsId.clash_token_4,
	Data.PropsId.clash_token_5,
	Data.PropsId.clash_token_6,
	Data.PropsId.clash_token_7,
	Data.PropsId.collect_shop_token,
	Data.ResType.clash_ex_trophy,
	Data.PropsId.clash_ex_ticket,
	Data.PropsId.new_token,
	Data.PropsId.month_card5_token,
	Data.PropsId.skill_item_token
}
var_0_0.PropId2 = {
	Data.PropsId.rare_silver_coin,
	Data.PropsId.magic_dust,
	Data.PropsId.times_package_ticket,
	Data.PropsId.lottery_package_token,
	Data.PropsId.common_fragment,
	Data.PropsId.vote_shop_token
}
var_0_0.PropId3 = {
	Data.PropsId.winged_dragon,
	Data.PropsId.lottery_reset_token,
	Data.PropsId.void_diamond_2
}

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
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
	local var_3_0 = cc.size(var_0_1.width * 3 + var_0_3 + var_0_3, var_0_1.height)

	arg_3_0:setContentSize(var_3_0)
	arg_3_0:setPosition(ClientView.SCR_W - var_3_0.width / 2 - ClientView.SCR_EDGE, ClientView.SCR_H - var_3_0.height / 2 - 8)

	arg_3_0._areas = {}

	local var_3_1 = var_0_1.width + 10

	arg_3_0._areaXs = {
		var_3_1 / 2,
		var_3_1 * 3 / 2,
		var_3_1 * 5 / 2
	}
	arg_3_0._areaProps = {}

	for iter_3_0 = 1, #var_0_0.PropId do
		local var_3_2 = var_0_0.PropId[iter_3_0]

		arg_3_0._areaProps[var_3_2] = arg_3_0:createArea(var_3_2, var_0_1, arg_3_0._areaXs[1])
	end

	arg_3_0._areaProps2 = {}

	for iter_3_1 = 1, #var_0_0.PropId2 do
		local var_3_3 = var_0_0.PropId2[iter_3_1]

		arg_3_0._areaProps2[var_3_3] = arg_3_0:createArea(var_3_3, var_0_1, arg_3_0._areaXs[2])
	end

	arg_3_0._areaProps3 = {}

	for iter_3_2 = 1, #var_0_0.PropId3 do
		local var_3_4 = var_0_0.PropId3[iter_3_2]

		arg_3_0._areaProps3[var_3_4] = arg_3_0:createArea(var_3_4, var_0_1, arg_3_0._areaXs[3])
	end

	arg_3_0._areasByIndex = {
		arg_3_0._areaProps,
		arg_3_0._areaProps2,
		arg_3_0._areaProps3
	}
	arg_3_0._areaGold = arg_3_0:createArea(Data.ResType.gold, var_0_1, lc.right(arg_3_0._areas[1]) + var_0_3 + var_0_1.width / 2)
	arg_3_0._areaIngot = arg_3_0:createArea(Data.ResType.ingot, var_0_2, lc.right(arg_3_0._areaGold) + var_0_3 + var_0_2.width / 2)

	arg_3_0:setMode(Data.ResType.gold)
end

function var_0_0.createArea(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0:getContentSize()
	local var_4_1
	local var_4_2 = Data.getType(arg_4_1)

	if arg_4_1 == Data.PropsId.skin_crystal or arg_4_1 == Data.PropsId.times_package_ticket or arg_4_1 == Data.PropsId.void_diamond_2 or arg_4_1 == Data.PropsId.lottery_token or arg_4_1 == 7158 then
		var_4_1 = ClientView.createIconLabelArea(ClientData.getPropIconName(arg_4_1), nil, arg_4_2.width, function(arg_5_0)
			ClientView.showResExchangeForm(arg_4_1)
		end, "img_icon_add")
	elseif arg_4_1 == Data.PropsId.skill_item_token then
		var_4_1 = ClientView.createIconLabelArea(ClientData.getPropIconName(arg_4_1), nil, arg_4_2.width, function(arg_6_0)
			lc.pushScene(require("RechargeSkillTokenScene").create())
		end, "img_icon_add")
	elseif arg_4_1 == 7198 then
		var_4_1 = ClientView.createIconLabelArea(ClientData.getPropIconName(arg_4_1), nil, arg_4_2.width, function(arg_7_0)
			ClientView.showResExchangeForm(7129)
		end, "img_icon_add")
	elseif arg_4_1 == Data.PropsId.clash_ex_ticket then
		var_4_1 = ClientView.createIconLabelArea(ClientData.getPropIconName(arg_4_1), nil, arg_4_2.width, function(arg_8_0)
			ClientView.showResExchangeForm(Data.PropsId.lottery_token)
		end, "img_icon_add")
	elseif arg_4_1 >= Data.PropsId.clash_token_begin and arg_4_1 <= Data.PropsId.clash_token_end then
		var_4_1 = ClientView.createIconLabelArea(ClientData.getPropIconName(arg_4_1), nil, arg_4_2.width, function(arg_9_0)
			require("ActivityExchangeForm").create(3002):show()
		end, "img_icon_add")

		var_4_1:setTouchRect(cc.rect(0, -5, lc.w(var_4_1), lc.h(var_4_1) + 20))
	elseif arg_4_1 == Data.PropsId.lottery_package_token then
		var_4_1 = ClientView.createIconLabelArea(ClientData.getPropIconName(arg_4_1), nil, arg_4_2.width, function(arg_10_0)
			ClientView.showResExchangeForm(Data.PropsId.avatar_skin_crystal)
		end, "img_icon_add")
	elseif arg_4_1 == Data.PropsId.week_lottery_token then
		var_4_1 = ClientView.createIconLabelArea(ClientData.getPropIconName(arg_4_1), nil, arg_4_2.width, function(arg_11_0)
			ClientView.showResExchangeForm(Data.PropsId.yubi)
		end, "img_icon_add")

		var_4_1:setTouchRect(cc.rect(0, -5, lc.w(var_4_1), lc.h(var_4_1) + 20))
	elseif arg_4_1 == Data.PropsId.effect_skin_crystal then
		var_4_1 = ClientView.createIconLabelArea(ClientData.getPropIconName(arg_4_1), nil, arg_4_2.width, function(arg_12_0)
			lc.pushScene(require("CardOperateScene").create())
		end, "img_icon_add")

		var_4_1:setTouchRect(cc.rect(0, -5, lc.w(var_4_1), lc.h(var_4_1) + 20))
	elseif arg_4_1 == Data.ResType.clash_trophy or arg_4_1 == Data.ResType.ladder_trophy or arg_4_1 == Data.ResType.union_battle_trophy or arg_4_1 == Data.ResType.dark_trophy or arg_4_1 == Data.ResType.survival_ex_trophy or arg_4_1 == Data.ResType.clash_ex_trophy then
		var_4_1 = ClientView.createItemCountArea(arg_4_1, string.format("img_icon_res%d_s", arg_4_1), arg_4_2.width)
	elseif var_4_2 == Data.CardType.props and arg_4_1 ~= Data.PropsId.cumulative_exchange_token then
		var_4_1 = ClientView.createItemCountArea(arg_4_1, ClientData.getPropIconName(arg_4_1), arg_4_2.width)
	else
		local var_4_3 = ClientData.getIconName(arg_4_1)

		var_4_1 = ClientView.createIconLabelArea(var_4_3, nil, arg_4_2.width, function(arg_13_0)
			ClientView.showResExchangeForm(arg_4_1)
		end, "img_icon_add")

		var_4_1:setTouchRect(cc.rect(0, -5, lc.w(var_4_1), lc.h(var_4_1) + 20))
	end

	var_4_1._resType = arg_4_1

	var_4_1:setAnchorPoint(0.5, 0.5)
	var_4_1:setPosition(arg_4_3, var_4_0.height / 2)
	arg_4_0:addChild(var_4_1)

	local var_4_4 = var_4_1._label

	var_4_4._value = -1

	if arg_4_1 == Data.ResType.ingot or arg_4_1 == Data.PropsId.cumulative_exchange_token then
		lc.offset(var_4_4, 8)

		local var_4_5 = cc.Sprite:createWithSpriteFrameName("img_btn_squarel_s_2")
		local var_4_6 = var_4_1._btnAdd

		var_4_6:setColor(lc.Color3B.white)
		var_4_6:setPosition(lc.w(var_4_5) / 2, lc.h(var_4_5) / 2)
		lc.changeParent(var_4_6, nil, var_4_5)
		var_4_5:setPosition(lc.w(var_4_1) - 14, lc.h(var_4_1) / 2)
		var_4_1:addChild(var_4_5)

		var_4_1._btnAdd = var_4_5

		var_4_1:setTouchRect(cc.rect(0, -5, lc.w(var_4_1) + lc.w(var_4_5), lc.h(var_4_1) + 20))
		var_4_5:setVisible(not ClientData.isHideCharge())
	end

	table.insert(arg_4_0._areas, var_4_1)

	return var_4_1
end

function var_0_0.setMode(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0._mode = arg_14_1
	arg_14_0._param = arg_14_2
	arg_14_0._ids = arg_14_3

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._areas) do
		iter_14_1:setVisible(false)
	end

	for iter_14_2, iter_14_3 in ipairs(arg_14_0._areaProps) do
		iter_14_3:setPositionX(arg_14_0._areaXs[1])
	end

	for iter_14_4, iter_14_5 in ipairs(arg_14_0._areaProps2) do
		iter_14_5:setPositionX(arg_14_0._areaXs[2])
	end

	for iter_14_6, iter_14_7 in ipairs(arg_14_0._areaProps3) do
		iter_14_7:setPositionX(arg_14_0._areaXs[3])
	end

	arg_14_0._areaGold:setPositionX(arg_14_0._areaXs[2])
	arg_14_0._areaIngot:setPositionX(arg_14_0._areaXs[3])

	if arg_14_3 then
		for iter_14_8 = 1, 3 do
			local var_14_0 = arg_14_3[iter_14_8]

			if var_14_0 and var_14_0 > 0 then
				local var_14_1 = arg_14_0._areasByIndex[iter_14_8]

				if not var_14_1[var_14_0] then
					var_14_1[var_14_0] = arg_14_0:createArea(var_14_0, var_0_1, arg_14_0._areaXs[iter_14_8])
				else
					var_14_1[var_14_0]:setVisible(true)
				end
			end
		end
	elseif arg_14_1 == Data.PropsId.rare_silver_coin then
		arg_14_0._areaProps[Data.PropsId.rare_coin]:setVisible(true)
		arg_14_0._areaProps2[arg_14_1]:setVisible(true)
		arg_14_0._areaIngot:setVisible(true)
	elseif arg_14_1 == Data.PropsId.times_package_ticket then
		arg_14_0._areaProps[Data.PropsId.void_diamond]:setVisible(true)
		arg_14_0._areaProps2[arg_14_1]:setVisible(true)

		if arg_14_2 == 1 then
			arg_14_0._areaProps3[Data.PropsId.lottery_reset_token]:setVisible(true)
		elseif arg_14_2 == 2 then
			arg_14_0._areaProps3[Data.PropsId.void_diamond_2]:setVisible(true)
		else
			arg_14_0._areaIngot:setVisible(true)
		end
	elseif arg_14_1 == Data.PropsId.lottery_package_token then
		arg_14_0._areaProps[Data.PropsId.lottery_reset_token]:setVisible(true)
		arg_14_0._areaProps2[arg_14_1]:setVisible(true)
		arg_14_0._areaIngot:setVisible(true)
	elseif arg_14_1 == Data.PropsId.vote_shop_token then
		arg_14_0._areaProps[Data.PropsId.vote_token]:setVisible(true)
		arg_14_0._areaProps2[arg_14_1]:setVisible(true)
		arg_14_0._areaGold:setVisible(true)
		arg_14_0._areaGold:setPositionX(arg_14_0._areaXs[3])
	elseif arg_14_1 == Data.PropsId.winged_dragon then
		arg_14_0._areaProps3[arg_14_1]:setVisible(true)
		arg_14_0._areaProps2[Data.PropsId.magic_dust]:setVisible(true)
		arg_14_0._areaProps[Data.PropsId.obelisk_badge]:setVisible(true)
	elseif arg_14_1 == Data.PropsId.special_common_fragment then
		arg_14_0._areaProps[arg_14_1]:setVisible(true)
		arg_14_0._areaProps2[Data.PropsId.common_fragment]:setVisible(true)
	elseif arg_14_1 ~= Data.ResType.gold then
		arg_14_0._areaGold:setVisible(true)
		arg_14_0._areaProps[arg_14_1]:setVisible(true)
		arg_14_0._areaIngot:setVisible(true)
	else
		arg_14_0._areaGold:setVisible(true)
		arg_14_0._areaIngot:setVisible(true)
	end

	arg_14_0:updateValues()
end

function var_0_0.onEnter(arg_15_0)
	arg_15_0._listeners = {}

	local var_15_0
	local var_15_1 = {
		Data.Event.login,
		Data.Event.prop_dirty,
		Data.Event.union_res_dirty,
		Data.Event.gold_dirty,
		Data.Event.ingot_dirty,
		Data.Event.trophy_dirty,
		Data.Event.clash_trophy_dirty,
		Data.Event.union_battle_trophy_dirty,
		Data.Event.dark_trophy_dirty,
		Data.Event.survial_ex_trophy_dirty
	}

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		local var_15_2 = lc.addEventListener(iter_15_1, function()
			arg_15_0:updateValues()
		end)

		table.insert(arg_15_0._listeners, var_15_2)
	end

	arg_15_0._bones = {}

	local var_15_3 = {
		arg_15_0._areaGold,
		arg_15_0._areaIngot
	}

	-- The native build uses the DragonBones stamina animation here.  The H5
	-- DragonBones bridge cannot decode this encrypted effect reliably and
	-- renders the same crystal for both currencies, so retain the atlas icons
	-- on Emscripten instead.
	if ClientData.isAppStoreReviewing() or lc.PLATFORM == cc.PLATFORM_OS_EMSCRIPTEN then
		var_15_3 = {}
	end

	for iter_15_2 = 1, #var_15_3 do
		local var_15_4 = cc.DragonBonesNode:createWithDecrypt("res/effects/tili.lcres", "tili", "tili")

		var_15_4:gotoAndPlay("effect" .. iter_15_2 + 1)
		lc.addChildToPos(var_15_3[iter_15_2], var_15_4, cc.p(var_15_3[iter_15_2]._icon:getPosition()))

		arg_15_0._bones[#arg_15_0._bones + 1] = var_15_4

		var_15_3[iter_15_2]._icon:setVisible(false)
	end

	arg_15_0:updateValues()
end

function var_0_0.onExit(arg_17_0)
	for iter_17_0 = 1, #arg_17_0._listeners do
		lc.Dispatcher:removeEventListener(arg_17_0._listeners[iter_17_0])
	end

	for iter_17_1 = 1, #arg_17_0._bones do
		arg_17_0._bones[iter_17_1]:removeFromParent()
	end

	arg_17_0._bones = {}
end

function var_0_0.onRelease(arg_18_0)
	arg_18_0:removeAllChildren()

	if arg_18_0._schedulerID ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_18_0._schedulerID)

		arg_18_0._schedulerID = nil
	end
end

function var_0_0.updateValues(arg_19_0)
	if arg_19_0._notupdate then
		arg_19_0._notupdate = false

		return
	end

	arg_19_0:runUpdateAction()
end

function var_0_0.runResAction(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0
	local var_20_1 = arg_20_0:convertToNodeSpace(arg_20_3)
	local var_20_2

	if arg_20_1 == Data.ResType.gold then
		var_20_0 = Particle.create("feijb")
		var_20_2 = cc.p(lc.left(arg_20_0._areaGold) + 26, lc.y(arg_20_0._areaGold))
	end

	if var_20_0 then
		var_20_0:setPosition(var_20_1)

		local var_20_3 = cc.p(var_20_1.x, var_20_1.y + 200)
		local var_20_4 = cc.p(var_20_1.x, var_20_1.y + 200)
		local var_20_5 = cc.p(var_20_2.x, var_20_2.y)

		var_20_0:runAction(cc.Sequence:create(cc.EaseSineInOut:create(cc.BezierToEx:create(0.75, {
			var_20_3,
			var_20_4,
			var_20_5
		})), cc.CallFunc:create(function()
			var_20_0:removeFromParent()

			local var_21_0 = Particle.create("par_res_collect3")

			var_21_0:setPosition(var_20_2)
			arg_20_0:addChild(var_21_0)
			arg_20_0:updateValues()
		end)))
		arg_20_0:addChild(var_20_0)
	end
end

function var_0_0.runUpdateAction(arg_22_0)
	local var_22_0 = {}
	local var_22_1 = {}
	local var_22_2 = {}
	local var_22_3 = {}

	local function var_22_4(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0._label._value ~= arg_23_1 and arg_23_1 ~= nil then
			table.insert(var_22_0, arg_23_0._icon)
			table.insert(var_22_1, arg_23_0._label)
			table.insert(var_22_2, arg_23_1)
			table.insert(var_22_3, arg_23_2 or 0)
		end
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0._areaProps) do
		if iter_22_1:isVisible() then
			var_22_4(iter_22_1, P:getItemCount(iter_22_1._resType))
		end
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0._areaProps2) do
		if iter_22_3:isVisible() then
			var_22_4(iter_22_3, P:getItemCount(iter_22_3._resType))
		end
	end

	for iter_22_4, iter_22_5 in pairs(arg_22_0._areaProps3) do
		if iter_22_5:isVisible() then
			var_22_4(iter_22_5, P:getItemCount(iter_22_5._resType))
		end
	end

	var_22_4(arg_22_0._areaGold, P._gold)
	var_22_4(arg_22_0._areaIngot, P._ingot)

	if #var_22_1 == 0 then
		return
	end

	if arg_22_0._schedulerID then
		lc.Scheduler:unscheduleScriptEntry(arg_22_0._schedulerID)
	end

	local var_22_5 = 0.05

	arg_22_0._schedulerID = lc.Scheduler:scheduleScriptFunc(function(arg_24_0)
		local var_24_0 = true

		for iter_24_0, iter_24_1 in ipairs(var_22_1) do
			if var_22_2[iter_24_0] ~= iter_24_1._value then
				var_24_0 = false

				local var_24_1 = (var_22_2[iter_24_0] - iter_24_1._value) / 2

				if var_24_1 > 0 then
					var_24_1 = math.ceil(var_24_1)
				else
					var_24_1 = math.floor(var_24_1)
				end

				iter_24_1._value = iter_24_1._value + var_24_1

				if (var_22_2[iter_24_0] - iter_24_1._value) * var_24_1 < 0 then
					iter_24_1._value = var_22_2[iter_24_0]
				end

				if var_22_3[iter_24_0] > 0 then
					iter_24_1:setString(string.format("%d/%d", iter_24_1._value, var_22_3[iter_24_0]))

					local var_24_2 = iter_24_1._value > var_22_3[iter_24_0] and ClientView.COLOR_TEXT_GREEN or ClientView.COLOR_TEXT_LIGHT

					iter_24_1:setColor(var_24_2)
				else
					iter_24_1:setString(ClientData.formatNum(iter_24_1._value, 99999))
				end

				if iter_24_1:getNumberOfRunningActions() == 0 then
					local var_24_3 = cc.EaseSineInOut:create(cc.ScaleBy:create(0.1, 1.2))

					iter_24_1:runAction(cc.Sequence:create(var_24_3, var_24_3:reverse()))
				end

				if var_22_0[iter_24_0]:getNumberOfRunningActions() == 0 then
					local var_24_4 = cc.EaseSineInOut:create(cc.ScaleBy:create(0.1, 1.2))

					var_22_0[iter_24_0]:runAction(cc.Sequence:create(var_24_4, var_24_4:reverse()))
				end
			end
		end

		if var_24_0 and arg_22_0._schedulerID then
			lc.Scheduler:unscheduleScriptEntry(arg_22_0._schedulerID)

			arg_22_0._schedulerID = nil
		end
	end, var_22_5, false)
end

ResPanel = var_0_0

return var_0_0
