local var_0_0 = {
	Toasts = {}
}

var_0_0.DURATION_LONG = 4

function var_0_0.push(arg_1_0, arg_1_1)
	if var_0_0.Toasts[arg_1_0] then
		var_0_0.Toasts[arg_1_0]:removeFromParent()
	end

	local var_1_0 = ClientView.createBoldRichText(arg_1_0, {
		_fontSize = ClientView.FontSize.M1,
		_normalClr = ClientView.COLOR_TEXT_LIGHT,
		_boldClr = ClientView.COLOR_TEXT_GREEN
	}, 800)
	local var_1_1 = lc.createSprite({
		_name = "img_toast_bg",
		_crect = ClientView.CRECT_TOAST_BG
	})

	var_1_1:setContentSize(cc.size(lc.w(var_1_0) + 80, lc.h(var_1_0) + 80))
	var_1_0:setPosition(lc.w(var_1_1) / 2, lc.h(var_1_1) / 2)
	var_1_1:addChild(var_1_0)

	var_0_0.Toasts[arg_1_0] = var_1_1

	var_0_0.runBgAction(arg_1_0, arg_1_1)

	return var_1_1
end

function var_0_0.pushArray(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = 0
	local var_2_1 = 0
	local var_2_2 = 5
	local var_2_3 = {}

	for iter_2_0 = 1, #arg_2_0 do
		local var_2_4 = ClientView.createBoldRichText(arg_2_0[iter_2_0], {
			_fontSize = ClientView.FontSize.M1,
			_normalClr = ClientView.COLOR_TEXT_LIGHT,
			_boldClr = ClientView.COLOR_TEXT_GREEN
		}, 800)

		table.insert(var_2_3, var_2_4)

		var_2_0 = math.max(var_2_0, lc.w(var_2_4))
		var_2_1 = var_2_1 + lc.h(var_2_4) + var_2_2
	end

	local var_2_5 = var_2_1 - var_2_2
	local var_2_6 = lc.createSprite({
		_name = "img_toast_bg",
		_crect = ClientView.CRECT_TOAST_BG
	})

	var_2_6:setContentSize(cc.size(var_2_0 + 80, var_2_5 + 80))

	local var_2_7 = 40

	for iter_2_1 = 1, #var_2_3 do
		var_2_3[iter_2_1]:setPosition(lc.w(var_2_6) / 2, lc.h(var_2_6) - var_2_7 - lc.h(var_2_3[iter_2_1]) / 2)
		var_2_6:addChild(var_2_3[iter_2_1])

		var_2_7 = var_2_7 + lc.h(var_2_3[iter_2_1]) + var_2_2
	end

	var_0_0.Toasts[var_2_6] = var_2_6

	var_0_0.runBgAction(var_2_6, arg_2_1)
end

function var_0_0.runBgAction(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0.Toasts[arg_3_0]
	local var_3_1 = lc._runningScene

	var_3_0:setCascadeOpacityEnabled(true)
	var_3_0:setPosition(lc.w(var_3_1) / 2, lc.h(var_3_1) / 2 + 150)
	var_3_0:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "cleanup" then
			var_0_0.Toasts[arg_3_0] = nil
		end
	end)
	var_3_1._scene:addChild(var_3_0, ClientData.ZOrder.toast)

	local var_3_2 = (lc.h(var_3_1) - lc.y(var_3_0)) / 2
	local var_3_3 = lc.sequence(lc.ease(lc.scaleTo(lc.absTime(0.2), 1), "BackO"), lc.absTime(0.3), lc.moveBy(lc.absTime(2), 0, var_3_2), {
		lc.moveBy(lc.absTime(2), 0, var_3_2),
		lc.fadeOut(lc.absTime(1.5))
	})
	local var_3_4 = lc.sequence(lc.absTime(arg_3_1 or var_0_0.DURATION_LONG), lc.remove())

	var_3_0:setScale(0)
	var_3_0:runAction(var_3_3)
	var_3_0:runAction(var_3_4)
end

ToastManager = var_0_0

return var_0_0
