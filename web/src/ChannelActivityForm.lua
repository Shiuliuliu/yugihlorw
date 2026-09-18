local var_0_0 = class("ChannelActivityForm", BaseForm)
local var_0_1 = cc.size(1010, 700)
local var_0_2 = 90
local var_0_3 = {
	login = 2,
	month = 6,
	privilege = 5,
	cumulative = 4,
	launch = 1,
	level = 3
}

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.PRIVILEGE), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))
	arg_2_0._form:setTouchEnabled(false)

	local var_2_0 = {
		{
			_str = Str(STR.OPPO_TAB_1),
			_index = var_0_3.launch
		},
		{
			_str = Str(STR.OPPO_TAB_2),
			_index = var_0_3.login
		},
		{
			_str = Str(STR.OPPO_TAB_6),
			_index = var_0_3.month
		},
		{
			_str = Str(STR.OPPO_TAB_3),
			_index = var_0_3.level
		},
		{
			_str = Str(STR.OPPO_TAB_4),
			_index = var_0_3.cumulative
		},
		{
			_str = Str(STR.OPPO_TAB_5),
			_index = var_0_3.privilege
		}
	}
	local var_2_1 = ClientView.createVerticalTabListArea(lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - var_0_2, var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0:showTab(arg_3_0._index, not arg_3_1, arg_3_2)
	end)

	function var_2_1._subTabExpandCallback(arg_4_0)
		arg_2_0:showTabFlag()
	end

	lc.addChildToPos(arg_2_0._frame, var_2_1, cc.p(ClientView.FRAME_INNER_LEFT + lc.w(var_2_1) / 2, ClientView.FRAME_INNER_BOTTOM + lc.ch(var_2_1)), 0)

	arg_2_0._tabArea = var_2_1

	local var_2_2 = cc.size(lc.w(arg_2_0._frame) - lc.right(var_2_1) - ClientView.FRAME_INNER_RIGHT - 24, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - var_0_2)
	local var_2_3 = lc.List.createV(var_2_2, 10, 10)

	var_2_3:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0._frame, var_2_3, cc.p(lc.right(var_2_1) + 14 + lc.w(var_2_3) / 2, ClientView.FRAME_INNER_BOTTOM + lc.ch(var_2_3)))

	arg_2_0._list = var_2_3

	local var_2_4 = lc.createNode(var_2_2)

	lc.addChildToPos(arg_2_0._frame, var_2_4, cc.p(var_2_3:getPosition()))

	arg_2_0._tipArea = var_2_4

	local var_2_5 = ClientView.createTTF(Str(STR.OPPO_VIP_TIP), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(lc.w(var_2_4), 0), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

	lc.addChildToPos(var_2_4, var_2_5, cc.p(lc.cw(var_2_4), lc.h(var_2_4) - lc.ch(var_2_5) - 30))

	local var_2_6 = lc.createNode()

	lc.addChildToPos(arg_2_0._frame, var_2_6, cc.p(lc.cw(arg_2_0._frame), lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - var_0_2 / 2 - 15))

	local var_2_7 = "oppo_title_bg"
	local var_2_8 = lc.createSprite(var_2_7)

	var_2_6:addChild(var_2_8)

	if not ClientData._subChannelVipLevel then
		arg_2_0._indicator = ClientView.showPanelActiveIndicator(arg_2_0._form, lc.bound(arg_2_0._list))

		lc.offset(arg_2_0._indicator, 0, 20)
	else
		arg_2_0._tabArea:showTab(var_0_3.launch)
	end
end

function var_0_0.showTab(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._focusTabIndex = arg_5_1

	arg_5_0:refreshList()
end

function var_0_0.showTabFlag(arg_6_0)
	local var_6_0 = arg_6_0._tabArea._list:getItems()

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = 0
		local var_6_2 = var_6_0[iter_6_0]._index

		if var_6_2 == var_0_3.launch then
			var_6_1 = P._playerBonus:getCommonBonusFlag(P._playerBonus._channelBonuses[Data.BonusCid.channel_launch])
		elseif var_6_2 == var_0_3.level then
			var_6_1 = P._playerBonus:getCommonBonusFlag(P._playerBonus._channelBonuses[Data.BonusCid.channel_vip_level])
		elseif var_6_2 == var_0_3.login then
			var_6_1 = math.min(1, P._playerBonus:getCommonBonusFlag(P._playerBonus._channelBonuses[Data.BonusCid.channel_login]))
		elseif var_6_2 == var_0_3.month then
			var_6_1 = math.min(1, P._playerBonus:getCommonBonusFlag(P._playerBonus._channelBonuses[Data.BonusCid.channel_month]))
		elseif var_6_2 == var_0_3.cumulative then
			var_6_1 = P._playerBonus:getCommonBonusFlag(P._playerBonus._channelBonuses[Data.BonusCid.channel_cumulative])
		else
			var_6_1 = 0
		end

		local var_6_3 = var_6_0[iter_6_0]

		ClientView.checkNewFlag(var_6_3, var_6_1)
	end
end

function var_0_0.onEnter(arg_7_0)
	var_0_0.super.onEnter(arg_7_0)

	arg_7_0._listeners = {}

	local var_7_0 = lc.addEventListener(Data.Event.channel_bonus_dirty, function(arg_8_0)
		arg_7_0:refreshList()
	end)

	table.insert(arg_7_0._listeners, var_7_0)

	local var_7_1 = lc.addEventListener(Data.Event.channel_level_dirty, function(arg_9_0)
		if arg_7_0._indicator then
			arg_7_0._indicator:removeFromParent()

			arg_7_0._indicator = nil

			arg_7_0._tabArea:showTab(var_0_3.launch)
		end
	end)

	table.insert(arg_7_0._listeners, var_7_1)
end

function var_0_0.onExit(arg_10_0)
	var_0_0.super.onExit(arg_10_0)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_10_1)
	end
end

function var_0_0.onCleanup(arg_11_0)
	ClientView.getMenuUI():updateAchieveFlag()
	var_0_0.super.onCleanup(arg_11_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/task_novice_top.jpg"))
end

function var_0_0.refreshList(arg_12_0)
	local var_12_0 = arg_12_0._list
	local var_12_1 = arg_12_0._focusTabIndex
	local var_12_2

	if var_12_1 == var_0_3.launch then
		var_12_2 = P._playerBonus._channelBonuses[Data.BonusCid.channel_launch]
	elseif var_12_1 == var_0_3.level then
		var_12_2 = P._playerBonus._channelBonuses[Data.BonusCid.channel_vip_level]
	elseif var_12_1 == var_0_3.month then
		var_12_2 = P._playerBonus._channelBonuses[Data.BonusCid.channel_month]
	elseif var_12_1 == var_0_3.login then
		local var_12_3 = P._playerBonus._channelBonuses[Data.BonusCid.channel_login]

		for iter_12_0 = #var_12_3, 1, -1 do
			local var_12_4 = var_12_3[iter_12_0]

			if var_12_4._info._val <= ClientData._subChannelVipLevel then
				var_12_2 = {
					var_12_4
				}

				break
			end
		end

		if not var_12_2 then
			var_12_2 = {
				var_12_3[1]
			}
		end
	elseif var_12_1 == var_0_3.cumulative then
		var_12_2 = P._playerBonus._channelBonuses[Data.BonusCid.channel_cumulative]
	end

	if var_12_2 then
		local var_12_5 = {}
		local var_12_6, var_12_7, var_12_8 = P._playerBonus.splitBonus(var_12_2)

		for iter_12_1, iter_12_2 in ipairs(var_12_6) do
			table.insert(var_12_5, iter_12_2)
		end

		for iter_12_3, iter_12_4 in ipairs(var_12_7) do
			table.insert(var_12_5, iter_12_4)
		end

		for iter_12_5, iter_12_6 in ipairs(var_12_8) do
			table.insert(var_12_5, iter_12_6)
		end

		arg_12_0._tipArea:setVisible(false)
		var_12_0:bindData(var_12_5, function(arg_13_0, arg_13_1)
			arg_12_0:setOrCreateItem(arg_13_0, arg_13_1)
		end, math.min(5, #var_12_5))

		for iter_12_7 = 1, var_12_0._cacheCount do
			var_12_0:pushBackCustomItem(arg_12_0:setOrCreateItem(nil, var_12_5[iter_12_7]))
		end

		var_12_0:forceDoLayout()
		var_12_0:gotoTop()
		arg_12_0:showTabFlag()
	else
		var_12_0:removeAllItems()
		arg_12_0._tipArea:setVisible(true)
	end
end

function var_0_0.setOrCreateItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = Str(arg_14_2._info._nameSid)

	if arg_14_1 == nil then
		arg_14_1 = require("BonusWidget").create(lc.w(arg_14_0._list), arg_14_2, var_14_0)
	else
		arg_14_1:setBonus(arg_14_2, var_14_0)
	end

	arg_14_1:registerCallback(function(arg_15_0)
		arg_14_0:onBtnClaim(arg_15_0)
	end)

	return arg_14_1
end

function var_0_0.onBtnClaim(arg_16_0, arg_16_1)
	local var_16_0 = ClientData.claimBonus(arg_16_1)

	arg_16_0:refreshList()
	ClientView.showClaimBonusResult(arg_16_1, var_16_0)
end

return var_0_0
