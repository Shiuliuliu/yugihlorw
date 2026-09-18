local var_0_0 = class("UnionScene", BaseUIScene)
local var_0_1 = require("UnionCreateArea")
local var_0_2 = require("UnionSearchArea")
local var_0_3 = require("UnionUnionArea")
local var_0_4 = require("UnionChatArea")
local var_0_5 = require("UnionShopArea")
local var_0_6 = require("UnionMemberForm")
local var_0_7 = "res/jpg/union_bg.jpg"
local var_0_8 = 800
local var_0_9 = 80
local var_0_10 = {
	search = 3,
	create = 1,
	chat = 4,
	my_union = 2,
	boss = 6,
	tech = 5,
	shop = 7
}

function var_0_0.create(arg_1_0)
	return lc.createScene(var_0_0, arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.union, STR.SID_FIXITY_NAME_1012, BaseUIScene.STYLE_EMPTY, true) then
		return false
	end

	arg_2_0._initTabIndex = arg_2_1
	P._playerUnion._hasDetailInfo = nil

	function arg_2_0._titleArea._btnBack._callback()
		if arg_2_0._myUnionChatArea and arg_2_0._myUnionChatArea._isBattleWaiting == true then
			return require("Dialog").showDialog(Str(STR.CANCEL_INVITE_1), function()
				arg_2_0._myUnionChatArea:onBattleCancel(true)
				arg_2_0:hide()
			end)
		elseif arg_2_0._shopArea and arg_2_0._shopArea._detailPanel then
			arg_2_0._shopArea:hideCardBox()
		else
			arg_2_0:hide()
		end
	end

	return true
end

function var_0_0.syncData(arg_5_0)
	var_0_0.super.syncData(arg_5_0)

	if P:hasUnion() then
		if not P._playerUnion._hasDetailInfo then
			ClientView.getActiveIndicator():show(Str(STR.WAITING))
			ClientData.sendGetMyUnionDetail()
		else
			arg_5_0:updateTabs()
		end
	else
		arg_5_0:updateTabs()
	end
end

function var_0_0.updateTabs(arg_6_0)
	local var_6_0 = arg_6_0._tabArea
	local var_6_1

	if var_6_0 then
		var_6_1 = var_6_0._focusedTab._index
	else
		var_6_1 = arg_6_0._initTabIndex
		arg_6_0._initTabIndex = nil
	end

	local var_6_2 = P:hasUnion()
	local var_6_3

	if arg_6_0._hasUnion ~= var_6_2 then
		if var_6_2 then
			var_6_3 = {
				{
					_index = var_0_10.chat,
					_str = Str(STR.UNION_CHAT)
				},
				{
					_index = var_0_10.my_union,
					_str = Str(STR.UNION_MY)
				},
				{
					_index = var_0_10.shop,
					_str = Str(STR.UNION_SHOP)
				},
				{
					_index = var_0_10.search,
					_str = Str(STR.SEARCH_UNION)
				}
			}
		else
			var_6_3 = {
				{
					_index = var_0_10.search,
					_str = Str(STR.SEARCH_UNION)
				}
			}

			if not ClientData.getValidActivityByType(Data.ActivityType.sensitive_day) then
				table.insert(var_6_3, {
					_index = var_0_10.create,
					_str = Str(STR.CREATE_UNION)
				})
			end
		end

		if var_6_0 then
			var_6_0:removeFromParent()
		end

		if arg_6_0._hasUnion ~= nil then
			var_6_1 = nil
		end

		arg_6_0._hasUnion = var_6_2
		var_6_0 = ClientView.createVerticalTabListArea(lc.bottom(arg_6_0._titleArea), var_6_3, function(arg_7_0, arg_7_1, arg_7_2)
			if not arg_7_1 or arg_7_2 then
				if arg_7_2 then
					if arg_6_0._myUnionChatArea and arg_6_0._myUnionChatArea._isBattleWaiting == true then
						local var_7_0 = require("Dialog").showDialog(Str(STR.CANCEL_INVITE_2), function()
							arg_6_0._myUnionChatArea:onBattleCancel(true)
							arg_6_0:showTab(arg_7_0)
						end)

						function var_7_0._btnCancel._callback()
							var_7_0:close()
							var_6_0:showTab(var_0_10.chat, false)
						end
					else
						arg_6_0:showTab(arg_7_0)
					end
				else
					arg_6_0:showTab(arg_7_0)
				end
			end
		end, ClientView.SCR_EDGE)

		lc.addChildToPos(arg_6_0, var_6_0, cc.p(lc.w(var_6_0) / 2 - 4 + ClientView.SCR_EDGE, lc.bottom(arg_6_0._titleArea) / 2 + 2), 1)

		arg_6_0._tabArea = var_6_0
	end

	if ClientData._battleFromUnionBoss then
		var_6_1 = var_0_10.boss
		arg_6_0._unionBossIndex = ClientData._battleFromUnionBoss._id - 100
		ClientData._battleFromUnionBoss = nil
	elseif arg_6_0._unionBossIndex == nil then
		arg_6_0._unionBossIndex = 1
	end

	if var_6_1 == nil then
		var_6_1 = var_6_3[1]._index
	end

	if var_6_2 and (var_6_1 == var_0_10.my_union or var_6_1 == var_0_10.boss) then
		ClientView.getResourceUI():setMode(Data.PropsId.yubi)
	else
		ClientView.getResourceUI():setMode(Data.ResType.gold)
	end

	var_6_0:showTab(var_6_1, true)
end

function var_0_0.showTab(arg_10_0, arg_10_1)
	ClientView.getResourceUI():setVisible(arg_10_1._index ~= var_0_10.chat)

	if arg_10_0._myUnionArea then
		arg_10_0._myUnionArea:setVisible(false)
	end

	if arg_10_0._myUnionChatArea then
		arg_10_0._myUnionChatArea:setVisible(false)
	end

	if arg_10_0._shopArea then
		arg_10_0._shopArea:hideCardBox()
		arg_10_0._shopArea:setVisible(false)
	end

	local var_10_0 = arg_10_0._contentArea

	if var_10_0 and var_10_0 ~= arg_10_0._myUnionArea and var_10_0 ~= arg_10_0._myUnionChatArea and var_10_0 ~= arg_10_0._shopArea then
		if var_10_0._linkObjs then
			for iter_10_0, iter_10_1 in ipairs(var_10_0._linkObjs) do
				iter_10_1:removeFromParent()
			end
		end

		var_10_0:removeFromParent()

		arg_10_0._contentArea = nil
	end

	local var_10_1 = lc.w(arg_10_0) - lc.right(arg_10_0._tabArea)
	local var_10_2, var_10_3, var_10_4 = lc.bottom(arg_10_0._titleArea)

	if arg_10_1._index == var_0_10.my_union then
		if arg_10_0._myUnionArea == nil then
			var_10_3 = var_0_3.create(P._unionId, var_10_1, var_10_2 - var_0_9)
			var_10_4 = var_10_2 - lc.h(var_10_3) / 2
			arg_10_0._myUnionArea = var_10_3
		else
			arg_10_0._myUnionArea:setVisible(true)
		end

		arg_10_0:addMyUnionButtonArea(var_10_1)
		ClientView.getResourceUI():setMode(Data.PropsId.yubi)
	elseif arg_10_1._index == var_0_10.hire then
		var_10_3 = HireArea.create(var_10_1 + 10, var_10_2)

		ClientView.getResourceUI():setMode(Data.PropsId.yubi)
	elseif arg_10_1._index == var_0_10.tech then
		var_10_3 = TechArea.create(var_10_1 + 10, var_10_2)

		ClientView.getResourceUI():setMode(Data.PropsId.yubi)
	elseif arg_10_1._index == var_0_10.boss then
		var_10_3 = BossArea.create(arg_10_0._unionBossIndex, var_10_1 + 10, var_10_2)

		ClientView.getResourceUI():setMode(Data.PropsId.yubi)
	elseif arg_10_1._index == var_0_10.create then
		var_10_3 = var_0_1.create(var_0_1.Mode.create, var_10_1)

		ClientView.getResourceUI():setMode(Data.ResType.gold)
	elseif arg_10_1._index == var_0_10.search then
		var_10_3 = var_0_2.create(var_10_1, var_10_2)

		ClientView.getResourceUI():setMode(Data.ResType.gold)
	elseif arg_10_1._index == var_0_10.shop then
		if not arg_10_0._shopArea then
			var_10_3 = var_0_5.create(var_10_1, var_10_2)
			arg_10_0._shopArea = var_10_3
		else
			arg_10_0._shopArea:setVisible(true)
		end

		ClientView.getResourceUI():setMode(Data.PropsId.yubi)
	elseif arg_10_1._index == var_0_10.chat then
		if not arg_10_0._myUnionChatArea then
			var_10_3 = var_0_4.create(P._unionId, var_10_1, var_10_2)

			ClientView.getResourceUI():setMode(Data.PropsId.yubi)

			arg_10_0._myUnionChatArea = var_10_3
		else
			arg_10_0._myUnionChatArea:setVisible(true)
		end
	end

	if var_10_3 then
		lc.addChildToPos(arg_10_0, var_10_3, cc.p((lc.w(arg_10_0) + lc.right(arg_10_0._tabArea)) / 2, var_10_4 or lc.h(var_10_3) / 2))

		arg_10_0._contentArea = var_10_3
	end
end

function var_0_0.addMyUnionButtonArea(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._myUnionArea
	local var_11_1 = lc.createNode(cc.size(arg_11_1, var_0_9))

	lc.addChildToPos(var_11_0, var_11_1, cc.p(lc.w(var_11_0) / 2, -lc.h(var_11_1) / 2))

	local var_11_2 = ClientView.createLineSprite("img_bottom_bg", arg_11_1 + 10)

	var_11_2:setAnchorPoint(0, 0)
	lc.addChildToPos(var_11_1, var_11_2, cc.p(0, 0))

	arg_11_0._bottomArea = var_11_2

	local var_11_3 = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_11_0:quitUnion()
	end, ClientView.CRECT_BUTTON_S, 120)

	var_11_3:addLabel(Str(STR.EXIT))
	lc.addChildToPos(var_11_1, var_11_3, cc.p(6 + lc.w(var_11_3) / 2, 42))

	local var_11_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_13_0)
		arg_11_0:popInfoItems(arg_13_0)
	end, ClientView.CRECT_BUTTON_S, 120)

	var_11_4:addLabel(Str(STR.INFO))
	lc.addChildToPos(var_11_1, var_11_4, cc.p(lc.right(var_11_3) + 10 + lc.w(var_11_4) / 2, lc.y(var_11_3)))

	if P._unionJob ~= Data.UnionJob.rookie and not ClientData.getValidActivityByType(Data.ActivityType.sensitive_day) then
		local var_11_5 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_14_0)
			arg_11_0:popManageItems(arg_14_0)
		end, ClientView.CRECT_BUTTON_S, 120)

		var_11_5:addLabel(Str(STR.MANAGE))
		lc.addChildToPos(var_11_1, var_11_5, cc.p(lc.right(var_11_4) + 10 + lc.w(var_11_5) / 2, lc.y(var_11_3)))
	end

	local var_11_6 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("UnionContributeForm").create(Data.ResType.union_gold):show()
	end, ClientView.CRECT_BUTTON_S, 140)

	var_11_6:addLabel(Str(STR.CONTRIBUTE))
	var_11_6:addIcon("img_icon_props_s7024")
	lc.addChildToPos(var_11_1, var_11_6, cc.p(lc.right(arg_11_0._bottomArea) - 10 - lc.w(var_11_6) / 2 - ClientView.SCR_EDGE, lc.y(var_11_3)))
end

function var_0_0.quitUnion(arg_16_0, arg_16_1)
	if P._playerUnion._groupId then
		return ToastManager.push(Str(STR.EXIT_GROUP_FIRST))
	end

	if not arg_16_1 then
		local var_16_0

		if P._unionJob == Data.UnionJob.leader then
			if P._playerUnion:getMyUnion():getMembersNum() == 1 then
				var_16_0 = Str(STR.SURE_TO_EXIT_UNION_ONLY_LEADER)
			else
				var_16_0 = Str(STR.SURE_TO_EXIT_UNION_LEADER)

				require("Dialog").showDialog(var_16_0, nil, true)

				return
			end
		else
			var_16_0 = Str(STR.SURE_TO_EXIT_UNION)
		end

		require("Dialog").showDialog(var_16_0, function()
			arg_16_0:quitUnion(true)
		end)

		return
	end

	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendUnionLeave()
end

function var_0_0.popInfoItems(arg_18_0, arg_18_1)
	local var_18_0 = cc.size(200, 320)
	local var_18_1 = {}
	local var_18_2 = P._playerUnion:getMyUnion()

	table.insert(var_18_1, {
		_str = Str(STR.UNION) .. Str(STR.UNION_LOG),
		_handler = function()
			require("UnionLogForm").create():show()
		end
	})
	table.insert(var_18_1, {
		_str = Str(STR.MEMBER_CONTRIBUTE),
		_handler = function()
			var_0_6.createContribute():show()
		end
	})

	local var_18_3 = require("TopMostPanel").ButtonList.create(var_18_0)

	if var_18_3 then
		local var_18_4 = lc.convertPos(cc.p(0, lc.h(arg_18_1)), arg_18_1)

		var_18_3:setButtonDefs(var_18_1)
		var_18_3:setPosition(var_18_4.x + lc.w(var_18_3) / 2, var_18_4.y + lc.h(var_18_3) / 2 + 6)
		var_18_3:linkNode(arg_18_1)
		var_18_3:show()
	end
end

function var_0_0.popManageItems(arg_21_0, arg_21_1)
	local var_21_0 = cc.size(200, 320)
	local var_21_1 = {}
	local var_21_2 = P._playerUnion:getMyUnion()

	table.insert(var_21_1, {
		_str = Str(STR.SEND_GROUP) .. Str(STR.MAIL),
		_handler = function()
			require("SendMailForm").create():show()
		end
	})
	table.insert(var_21_1, {
		_isSeparator = true
	})
	table.insert(var_21_1, {
		_str = Str(STR.CHANGE) .. Str(STR.INFO),
		_handler = function()
			require("UnionEditForm").create():show()
		end
	})

	local var_21_3 = require("TopMostPanel").ButtonList.create(var_21_0)

	if var_21_3 then
		local var_21_4 = lc.convertPos(cc.p(0, lc.h(arg_21_1)), arg_21_1)

		var_21_3:setButtonDefs(var_21_1)
		var_21_3:setPosition(var_21_4.x + lc.w(var_21_3) / 2, var_21_4.y + lc.h(var_21_3) / 2 + 6)
		var_21_3:linkNode(arg_21_1)
		var_21_3:show()
	end
end

function var_0_0.onEnter(arg_24_0)
	var_0_0.super.onEnter(arg_24_0)

	local var_24_0 = {}

	table.insert(var_24_0, lc.addEventListener(Data.Event.union_dirty, function()
		ClientView.getActiveIndicator():hide()
		arg_24_0:updateTabs()
	end))
	table.insert(var_24_0, lc.addEventListener(Data.Event.union_enter_dirty, function()
		ClientView.getActiveIndicator():hide()
		arg_24_0:syncData()
	end))
	table.insert(var_24_0, lc.addEventListener(Data.Event.union_exit_dirty, function()
		if arg_24_0._myUnionArea then
			if arg_24_0._contentArea == arg_24_0._myUnionArea then
				arg_24_0._contentArea = nil
			end

			arg_24_0._myUnionArea:removeFromParent()

			arg_24_0._myUnionArea = nil
		end

		arg_24_0:clearPanels()
		ClientView.getActiveIndicator():hide()
		arg_24_0:syncData()
	end))
	table.insert(var_24_0, lc.addEventListener(Data.Event.union_edit_dirty, function()
		ClientView.getActiveIndicator():hide()
		arg_24_0:syncData()
	end))

	arg_24_0._listeners = var_24_0

	arg_24_0:syncData()
end

function var_0_0.onExit(arg_29_0)
	var_0_0.super.onExit(arg_29_0)

	for iter_29_0 = 1, #arg_29_0._listeners do
		lc.Dispatcher:removeEventListener(arg_29_0._listeners[iter_29_0])
	end
end

function var_0_0.onCleanup(arg_30_0)
	var_0_0.super.onCleanup(arg_30_0)
	ClientView.getResourceUI():setVisible(true)
end

return var_0_0
