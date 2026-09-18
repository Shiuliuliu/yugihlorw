local var_0_0 = class("RecommendTroopListForm", BaseForm)
local var_0_1 = cc.size(840, 700)
local var_0_2 = 110

var_0_0.Tab = {
	system = Data.RecommendTroop.system,
	player = Data.RecommendTroop.player
}

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.RECOMMEND_TROOP), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_0
	local var_2_1 = {
		{
			_str = Str(STR.SYSTEM_RECOMMEND),
			_index = var_0_0.Tab.system
		},
		{
			_str = Str(STR.PLAYER_TROOP),
			_index = var_0_0.Tab.player
		}
	}
	local var_2_2 = ClientView.createVerticalTabListArea(lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM, var_2_1, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0:showTab(arg_3_0._index, not arg_3_1, arg_3_2)
	end)

	function var_2_2._subTabExpandCallback(arg_4_0)
		arg_2_0:showTabFlag()
	end

	lc.addChildToPos(arg_2_0._frame, var_2_2, cc.p(ClientView.FRAME_INNER_LEFT + lc.w(var_2_2) / 2, lc.h(arg_2_0._frame) / 2), 0)

	arg_2_0._tabArea = var_2_2

	local var_2_3 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - lc.right(var_2_2) - ClientView.FRAME_INNER_RIGHT - 24, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM - var_0_2), 10, 10)

	var_2_3:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_2_0._frame, var_2_3, cc.p(lc.right(var_2_2) + 14 + lc.w(var_2_3) / 2, lc.h(arg_2_0._frame) / 2 - var_0_2 / 2))

	arg_2_0._list = var_2_3

	local var_2_4 = "recommend_bg"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_2_4 .. "_2")) then
		var_2_4 = var_2_4 .. "_2"
	end

	local var_2_5 = lc.createSprite(lc.formatJpg(var_2_4))

	lc.addChildToPos(arg_2_0._frame, var_2_5, cc.p((lc.w(arg_2_0._frame) + lc.right(var_2_2)) / 2 - 14, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - var_0_2 / 2), -1)

	local var_2_6 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_5_0)
		arg_5_0:setEnabled(false)
		ClientData:sendGetRecommendTroops()
	end, ClientView.CRECT_BUTTON_S, 150)

	var_2_6:addLabel(Str(STR.REFRESH_TROOP))
	var_2_6:setDisabledShader(ClientView.SHADER_DISABLE)
	var_2_6:setEnabled(false)
	lc.addChildToPos(var_2_5, var_2_6, cc.p(lc.w(var_2_5) * 3 / 4, lc.ch(var_2_5)))

	arg_2_0._refreshBtn = var_2_6

	ClientData:sendGetRecommendTroops()
	arg_2_0._tabArea:showTab(var_0_0.Tab.system, false)
end

function var_0_0.showTab(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_2 then
		return
	end

	arg_6_0._focusTabIndex = arg_6_1

	arg_6_0._refreshBtn:setVisible(arg_6_1 == var_0_0.Tab.player)
	arg_6_0:refreshList()
end

function var_0_0.onEnter(arg_7_0)
	var_0_0.super.onEnter(arg_7_0)

	arg_7_0._listeners = {}

	local var_7_0 = lc.addEventListener(Data.Event.recommend_troop_dirty, function(arg_8_0)
		arg_7_0._refreshBtn:setEnabled(true)

		local var_8_0 = P._trophy or 0
		local var_8_1 = math.max(800, var_8_0)
		local var_8_2 = P._playerCard:getRecommendTroops()

		if #var_8_2 > 0 then
			ToastManager.push(string.format(Str(STR.RECOMMEND_TROOP_TIP), #var_8_2, var_8_1 + 100, var_8_1 + 200))
		end

		arg_7_0:refreshList()
	end)

	table.insert(arg_7_0._listeners, var_7_0)
end

function var_0_0.onExit(arg_9_0)
	var_0_0.super.onExit(arg_9_0)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_9_1)
	end
end

function var_0_0.refreshList(arg_10_0)
	local var_10_0 = arg_10_0._list
	local var_10_1 = {}

	if arg_10_0._focusTabIndex == var_0_0.Tab.system then
		var_10_1 = P._playerCard:getSystemRecommendTroops()
	elseif arg_10_0._focusTabIndex == var_0_0.Tab.player then
		var_10_1 = P._playerCard:getRecommendTroops()
	end

	var_10_0:bindData(var_10_1, function(arg_11_0, arg_11_1)
		arg_10_0:setOrCreateItem(arg_11_0, arg_11_1)
	end, math.min(6, #var_10_1))

	for iter_10_0 = 1, var_10_0._cacheCount do
		var_10_0:pushBackCustomItem(arg_10_0:setOrCreateItem(nil, var_10_1[iter_10_0]))
	end

	var_10_0:checkEmpty(Str(STR.LIST_EMPTY_NO_RECOMMEND))
	var_10_0:refreshView()
	var_10_0:gotoTop()
end

function var_0_0.setOrCreateItem(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == nil then
		arg_12_1 = lc.createImageView({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35
		})

		arg_12_1:setContentSize(cc.size(lc.w(arg_12_0._list), 108))

		local var_12_0 = lc.createSprite("img_bg_deco_29")
		local var_12_1 = 100 / lc.h(var_12_0)

		var_12_0:setScale(var_12_1)
		lc.addChildToPos(arg_12_1, var_12_0, cc.p(lc.w(arg_12_1) - lc.w(var_12_0) * var_12_1 / 2, lc.ch(arg_12_1)))
		arg_12_1:setTouchEnabled(true)
		arg_12_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

		local var_12_2 = ClientView.createBMFont(ClientView.BMFont.huali_32, "")

		lc.addChildToPos(arg_12_1, var_12_2, cc.p(64, lc.h(arg_12_1) / 2 + 2))
		arg_12_1:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 == ccui.TouchEventType.ended then
				-- block empty
			end
		end)

		local var_12_3 = UserWidget.Flag.LEVEL_NAME

		if arg_12_0._focusTabIndex == var_0_0.Tab.player then
			var_12_3 = bor(var_12_3, UserWidget.Flag.REGION)
		end

		local var_12_4 = UserWidget.create(nil, var_12_3, 1.2)

		var_12_4:setScale(0.7)
		lc.addChildToPos(arg_12_1, var_12_4, cc.p(lc.w(var_12_4) / 2, lc.h(arg_12_1) / 2 + 4))

		local var_12_5 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_14_0)
			require("VisitForm").create(arg_12_1._info, arg_12_0._focusTabIndex):show()
		end, ClientView.CRECT_BUTTON_S, 120)

		lc.addChildToPos(arg_12_1, var_12_5, cc.p(lc.w(arg_12_1) - lc.cw(var_12_5) - 30, lc.ch(arg_12_1)))
		var_12_5:addLabel(Str(STR.DETAIL))

		function arg_12_1.update(arg_15_0)
			if arg_15_0 then
				arg_12_1._info = arg_15_0

				local var_15_0 = ClientData.getAttackUserFromInput(arg_15_0)

				var_12_4:setUser(var_15_0, true)

				if var_12_4._regionArea then
					lc.offset(var_12_4._regionArea, 20, -100)
				end
			end
		end
	end

	arg_12_1.update(arg_12_2)

	return arg_12_1
end

return var_0_0
