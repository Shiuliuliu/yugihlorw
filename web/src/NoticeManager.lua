local var_0_0 = {}
local var_0_1 = 640
local var_0_2 = 400

var_0_0.Panels = {}
var_0_0.SortedPanels = {}

function var_0_0.init()
	if var_0_0._scheduler == nil then
		var_0_0._scheduler = lc.Scheduler:scheduleScriptFunc(function(arg_2_0)
			var_0_0.scheduler(arg_2_0)
		end, 0, false)
	end

	if var_0_0._listener == nil then
		var_0_0._listener = lc.addEventListener(Data.Event.push_notice, function(arg_3_0)
			local var_3_0 = ccui.RichTextEx:create()

			var_3_0:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_LABEL_LIGHT, 255, string.format(Str(STR.BRACKETS_S), arg_3_0._title), ClientView.TTF_FONT, ClientView.FontSize.S1))
			ClientView.appendBoldRichText(var_3_0, arg_3_0._content, {
				_normalClr = ClientView.COLOR_TEXT_DARK,
				_boldClr = ClientView.COLOR_TEXT_GREEN_DARK,
				_fontSize = ClientView.FontSize.S1
			})
			var_0_0.show(var_3_0, arg_3_0._isImportant and -1 or 5)
		end)
	end

	if var_0_0._bonusListener == nil then
		var_0_0._bonusListener = lc.addEventListener(Data.Event.bonus_dirty, function(arg_4_0)
			local var_4_0 = arg_4_0._data

			if var_4_0._info == nil then
				return
			end

			local var_4_1 = arg_4_0._lastValue
			local var_4_2

			if var_4_1 then
				var_4_2 = var_4_1 < var_4_0._info._val and var_4_0._value >= var_4_0._info._val
			else
				var_4_2 = var_4_0._value == var_4_0._info._val
			end

			if var_4_0._type == Data.BonusType.daily_task then
				if not var_4_0._isClaimed and var_4_2 then
					local var_4_3 = ccui.RichTextEx:create()

					var_4_3:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_LABEL_LIGHT, 255, string.format(Str(STR.BRACKETS_S), Str(STR.DAILY_TASK)), ClientView.TTF_FONT, ClientView.FontSize.S1))
					var_4_3:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(var_4_0._info._nameSid), ClientView.TTF_FONT, ClientView.FontSize.S1))
					var_4_3:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_GREEN_DARK, 255, Str(STR.FINISHED), ClientView.TTF_FONT, ClientView.FontSize.S1))
					var_0_0.show(var_4_3, 5)
				end
			elseif var_4_0._type == Data.BonusType.novice then
				if not var_4_0._isClaimed and var_4_2 then
					local var_4_4 = ccui.RichTextEx:create()

					var_4_4:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_LABEL_LIGHT, 255, string.format(Str(STR.BRACKETS_S), Str(STR.NOVICE_TASK)), ClientView.TTF_FONT, ClientView.FontSize.S1))
					var_4_4:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, Str(var_4_0._info._nameSid), ClientView.TTF_FONT, ClientView.FontSize.S1))
					var_4_4:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_GREEN_DARK, 255, Str(STR.FINISHED), ClientView.TTF_FONT, ClientView.FontSize.S1))
					var_0_0.show(var_4_4, 5)
				end
			else
				for iter_4_0, iter_4_1 in pairs(ClientData._player._playerAchieve._mainTasks) do
					if iter_4_1:isDefaultValid() and iter_4_1._info._bonusId == var_4_0._infoId and not var_4_0._isClaimed and var_4_2 then
						local var_4_5 = ccui.RichTextEx:create()

						var_4_5:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_LABEL_LIGHT, 255, string.format(Str(STR.BRACKETS_S), Str(STR.MAIN_TASK)), ClientView.TTF_FONT, ClientView.FontSize.S1))
						var_4_5:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_LIGHT, 255, iter_4_1:getDesc(), ClientView.TTF_FONT, ClientView.FontSize.S1))
						var_4_5:insertElement(ccui.RichItemText:create(0, ClientView.COLOR_TEXT_GREEN_DARK, 255, Str(STR.FINISHED), ClientView.TTF_FONT, ClientView.FontSize.S1))
						var_0_0.show(var_4_5, 5)

						break
					end
				end
			end
		end)
	end
end

function var_0_0.show(arg_5_0, arg_5_1, arg_5_2)
	if lc._runningScene == nil or lc._runningScene._scene == nil then
		return arg_5_2
	end

	if arg_5_2 ~= nil and var_0_0.Panels[arg_5_2] ~= nil then
		return arg_5_2
	end

	if lc.FrameCache:getSpriteFrame("img_btn_close2") == nil then
		return nil
	end

	local var_5_0 = 1

	while var_0_0.Panels[var_5_0] ~= nil do
		var_5_0 = var_5_0 + 1
	end

	arg_5_0:setMaxWidth(var_0_1)
	arg_5_0:formatText()

	local var_5_1 = ClientView.createShaderButton("img_btn_close2", function(arg_6_0)
		var_0_0.hide(var_5_0)
	end)
	local var_5_2 = lc.createImageView({
		_name = "img_com_bg_37",
		_crect = ClientView.CRECT_COM_BG37
	})

	var_5_2:setContentSize(var_0_1 + 90, math.max(lc.h(arg_5_0), lc.h(var_5_1)) + 8)
	var_5_2:setOpacity(192)
	lc.addChildToPos(var_5_2, arg_5_0, cc.p(lc.w(arg_5_0) / 2 + 20, lc.h(var_5_2) / 2))
	lc.addChildToPos(var_5_2, var_5_1, cc.p(lc.w(var_5_2) - lc.w(var_5_1) / 2 - 4, lc.h(var_5_2) / 2))
	lc._runningScene._scene:addChild(var_5_2, ClientData.ZOrder.toast)
	var_0_0.sortPanels()

	if #var_0_0.SortedPanels > 0 then
		var_5_2:setPosition(lc.w(lc._runningScene) / 2, lc.top(var_0_0.SortedPanels[1]) + lc.h(var_5_2) / 2 + 2)
	else
		var_5_2:setPosition(lc.w(lc._runningScene) / 2, lc.h(lc._runningScene) + lc.h(var_5_2) / 2)
	end

	var_0_0.Panels[var_5_0] = var_5_2

	table.insert(var_0_0.SortedPanels, 1, var_5_2)
	var_5_2:retain()

	if arg_5_1 ~= nil then
		var_5_2:runAction(cc.Sequence:create(cc.DelayTime:create(arg_5_1), cc.CallFunc:create(function()
			var_0_0.hide(var_5_0)
		end)))
	end

	return var_5_0, var_5_2
end

function var_0_0.hide(arg_8_0)
	if var_0_0.Panels[arg_8_0] == nil then
		return
	end

	local var_8_0 = var_0_0.Panels[arg_8_0]

	var_8_0:removeFromParent()
	var_8_0:release()

	var_0_0.Panels[arg_8_0] = nil

	var_0_0.sortPanels()
end

function var_0_0.hideAll()
	for iter_9_0, iter_9_1 in pairs(var_0_0.Panels) do
		var_0_0.hide(iter_9_0)
	end
end

function var_0_0.bindToRunningScene()
	for iter_10_0, iter_10_1 in pairs(var_0_0.Panels) do
		if iter_10_1:getParent() == nil then
			lc._runningScene._scene:addChild(iter_10_1, ClientData.ZOrder.toast)
		end
	end
end

function var_0_0.unbindFromRunningScene()
	for iter_11_0, iter_11_1 in pairs(var_0_0.Panels) do
		if iter_11_1:getParent() ~= nil then
			iter_11_1:removeFromParent(false)
		end
	end

	var_0_0.Panels = {}
	var_0_0.SortedPanels = {}
end

function var_0_0.scheduler(arg_12_0)
	if #var_0_0.SortedPanels > 0 then
		for iter_12_0 = 1, #var_0_0.SortedPanels do
			local var_12_0

			if iter_12_0 == 1 then
				var_12_0 = lc.h(lc._runningScene) - lc.h(var_0_0.SortedPanels[iter_12_0]) / 2
			else
				var_12_0 = lc.bottom(var_0_0.SortedPanels[iter_12_0 - 1]) - 2 - lc.h(var_0_0.SortedPanels[iter_12_0]) / 2
			end

			local var_12_1 = lc.y(var_0_0.SortedPanels[iter_12_0])

			if var_12_1 < var_12_0 then
				var_0_0.SortedPanels[iter_12_0]:setPositionY(math.min(var_12_1 + var_0_2 * arg_12_0, var_12_0))
			else
				var_0_0.SortedPanels[iter_12_0]:setPositionY(math.max(var_12_1 - var_0_2 * arg_12_0, var_12_0))
			end
		end
	end
end

function var_0_0.sortPanels()
	var_0_0.SortedPanels = {}

	for iter_13_0, iter_13_1 in pairs(var_0_0.Panels) do
		table.insert(var_0_0.SortedPanels, iter_13_1)
	end

	table.sort(var_0_0.SortedPanels, function(arg_14_0, arg_14_1)
		return lc.y(arg_14_0) > lc.y(arg_14_1)
	end)
end

NoticeManager = var_0_0

return var_0_0
