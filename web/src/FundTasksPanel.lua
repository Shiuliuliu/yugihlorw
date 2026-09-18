local var_0_0 = class("FundTasksPanel", require("BasePanel"))

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.init(arg_2_0, false)

	local var_2_0 = lc.createNode()

	var_2_0:setContentSize(arg_2_0:getContentSize())
	lc.addChildToCenter(arg_2_0, var_2_0)

	arg_2_0._layout = var_2_0

	local var_2_1 = lc.createSprite({
		_name = "img_form_title_bg_1",
		_crect = ClientView.CRECT_FORM_TITLE_BG1_CRECT,
		_size = cc.size(560, ClientView.CRECT_FORM_TITLE_BG1_CRECT.height)
	})

	lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.cw(arg_2_0), lc.ch(arg_2_0) + lc.h(var_2_1) + 120), 10)

	local var_2_2 = lc.createSprite({
		_name = "img_form_title_light_1",
		_crect = ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT,
		_size = cc.size(200, ClientView.CRECT_FORM_TITLE_LIGHT1_CRECT.height)
	})

	lc.addChildToPos(var_2_1, var_2_2, cc.p(lc.w(var_2_1) / 2, lc.h(var_2_1) / 2 + 4))

	local var_2_3 = ClientView.createTTF(arg_2_2, ClientView.FontSize.M1, ClientView.COLOR_TEXT_WHITE)

	var_2_3:setColor(ClientView.COLOR_TEXT_TITLE)
	var_2_3:setPosition(lc.w(var_2_1) / 2, lc.h(var_2_1) / 2 + 4)
	var_2_1:addChild(var_2_3)

	arg_2_0._titleLabel = var_2_3

	local var_2_4 = {}
	local var_2_5 = 1

	for iter_2_0, iter_2_1 in pairs(P._playerBonus._bonusFundTasks) do
		if var_2_5 > 5 then
			break
		end

		if arg_2_1[iter_2_1._info._cid] and not iter_2_1._isClaimed then
			local var_2_6 = ClientView.setOrCreateFundTaskCell(nil, iter_2_1, var_2_5)

			if arg_2_2 ~= Str(STR.FUND_TASK_RESET) then
				function var_2_6._callback(arg_3_0)
					arg_2_0:onItemClick()
				end
			else
				function var_2_6._callback(arg_4_0)
					var_2_0:runAction(lc.sequence(lc.scaleTo(0.2, 0.5), lc.call(function()
						arg_2_0:hide()
					end)))
				end
			end

			table.insert(var_2_4, var_2_6)
		end

		var_2_5 = var_2_5 + 1
	end

	lc.addNodesToCenter(var_2_0, var_2_4, 10)

	arg_2_0._items = var_2_4

	local var_2_7 = ClientView.createTTF(Str(STR.FUND_TASK_TIP), ClientView.FontSize.S1, ClientView.COLOR_TEXT_WHITE)

	var_2_7:setPosition(lc.w(var_2_1) / 2, lc.h(var_2_1) / 2 + 4)
	lc.addChildToPos(var_2_0, var_2_7, cc.p(lc.cw(var_2_0), lc.ch(var_2_0) - 170))

	arg_2_0._tipLabel = var_2_7

	var_2_0:setScale(0.5)
	var_2_0:runAction(lc.sequence(lc.scaleTo(0.2, 1), function()
		lc._runningScene:seenByCamera3D(arg_2_0)

		for iter_6_0, iter_6_1 in ipairs(var_2_4) do
			iter_6_1.hide()
			iter_6_1:runActionHideToShow()
		end
	end))
	arg_2_0:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 == ccui.TouchEventType.ended and not arg_2_0._isForce then
			var_2_0:runAction(lc.sequence(lc.scaleTo(0.2, 0.5), lc.call(function()
				arg_2_0:hide()
			end)))
		end
	end)
end

function var_0_0.onEnter(arg_9_0)
	var_0_0.super.onEnter(arg_9_0)
	arg_9_0:setCameraMask(ClientData.CAMERA_2D_FLAG)
end

function var_0_0.onItemClick(arg_10_0)
	require("DailyActiveForm").create():show()
	arg_10_0:hide()
end

return var_0_0
