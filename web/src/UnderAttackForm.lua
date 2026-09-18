local var_0_0 = class("UnderAttackForm", BaseForm)
local var_0_1 = cc.size(960, 640)
local var_0_2 = 160

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.onEnter(arg_2_0)
	var_0_0.super.onEnter(arg_2_0)

	ClientView._underAttackForm = arg_2_0

	arg_2_0:refresh()
end

function var_0_0.onExit(arg_3_0)
	var_0_0.super.onExit(arg_3_0)

	ClientView._underAttackForm = nil
end

function var_0_0.init(arg_4_0)
	var_0_0.super.init(arg_4_0, var_0_1, Str(STR.UNDER_ATTACK), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_4_0 = lc.List.createV(cc.size(lc.w(arg_4_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN, lc.h(arg_4_0._form) - var_0_0.TOP_MARGIN - var_0_0.BOTTOM_MARGIN), 6, 0)

	var_4_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_4_0._form, var_4_0)

	arg_4_0._list = var_4_0
end

function var_0_0.refresh(arg_5_0)
	local var_5_0 = arg_5_0._list

	var_5_0:removeAllItems()

	for iter_5_0, iter_5_1 in ipairs(P._underAttack._list) do
		local var_5_1 = arg_5_0:createItem(iter_5_1)

		var_5_0:pushBackCustomItem(var_5_1)
	end
end

function var_0_0.createItem(arg_6_0, arg_6_1)
	local var_6_0 = lc.createImageView({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = cc.size(lc.w(arg_6_0._list), 160)
	})

	var_6_0:setTouchEnabled(true)
	var_6_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
	var_6_0:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 == ccui.TouchEventType.ended and var_6_0._log then
			ClientView.operateUser(var_6_0._log._opponent, var_6_0)
		end
	end)

	local var_6_1 = arg_6_1._user
	local var_6_2 = UserWidget.create(var_6_1, UserWidget.Flag.NAME_UNION)

	lc.addChildToPos(var_6_0, var_6_2, cc.p(30 + lc.w(var_6_2) / 2, lc.h(var_6_0) / 2 + 4))

	var_6_0._userArea = var_6_2

	local var_6_3 = ClientView.createIconLabelArea("img_icon_res5_s", string.format("%d", var_6_1._trophy), 140)

	lc.addChildToPos(var_6_0, var_6_3, cc.p(450, 104))

	var_6_0._trophyArea = var_6_3

	local var_6_4 = ClientView.createTTF(ClientData.getTimeAgo(arg_6_1._timestamp), nil, ClientView.COLOR_LABEL_DARK)

	var_6_4:setAnchorPoint(1, 0.5)
	lc.addChildToPos(var_6_0, var_6_4, cc.p(lc.right(var_6_3) - 10, lc.bottom(var_6_3) - 20))

	var_6_0._timeValue = var_6_4

	local var_6_5 = arg_6_1._troop

	if var_6_5 ~= nil then
		local var_6_6 = lc.createSprite("img_icon_cardnum")

		lc.addChildToPos(var_6_0, var_6_6, cc.p(lc.right(var_6_3) + 40 + lc.w(var_6_6) / 2, lc.y(var_6_2) + 20))

		local var_6_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, tostring(#var_6_5))

		var_6_7:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_6_0, var_6_7, cc.p(lc.right(var_6_6) + 10, lc.y(var_6_6)))

		local var_6_8 = lc.createSprite("img_icon_power")

		lc.addChildToPos(var_6_0, var_6_8, cc.p(lc.x(var_6_6), lc.y(var_6_2) - 20))

		local var_6_9 = 0

		for iter_6_0, iter_6_1 in ipairs(var_6_5) do
			var_6_9 = var_6_9 + iter_6_1:getFightingValue()
		end

		local var_6_10 = ClientView.createBMFont(ClientView.BMFont.huali_26, string.format("%d", var_6_9))

		var_6_10:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_6_0, var_6_10, cc.p(lc.x(var_6_7), lc.y(var_6_8)))
	else
		local var_6_11 = cc.Sprite:createWithSpriteFrameName("img_btn_union_war")

		lc.addChildToPos(var_6_0, var_6_11, cc.p(630, lc.h(var_6_0) / 2 + 4))
	end

	local var_6_12 = ClientView.createShaderButton("img_btn_2", function(arg_8_0)
		arg_6_0:onJoin(arg_6_1)
	end)

	var_6_12:addLabel(Str(STR.JOIN))
	lc.addChildToPos(var_6_0, var_6_12, cc.p(lc.w(var_6_0) - lc.w(var_6_12) / 2 - 40, lc.h(var_6_0) / 2 + 4))

	return var_6_0
end

function var_0_0.onJoin(arg_9_0, arg_9_1)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))

	if arg_9_1._isUnionWar then
		ClientData._savedUnionData._city = ClientData.getActiveUnionWarCity()
		ClientData._savedUnionData._isAttacking = false

		ClientData.sendUnionBattleJoin(arg_9_1._user._id)
	elseif arg_9_1._isRescue then
		ClientData.sendWorldRescueJoin(arg_9_1._user._id)
	else
		ClientData.sendWorldJoin(arg_9_1._user._id)
	end
end

return var_0_0
