local var_0_0 = class("SweepForm", require("BaseForm"))
local var_0_1 = cc.size(780, 600)
local var_0_2 = 240

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.SWEEP_RESULT), bor(var_0_0.FLAG.ADVANCE_TITLE_BG, var_0_0.FLAG.PAPER_BG, var_0_0.FLAG.SCROLL_V))

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN, lc.h(arg_2_0._form) - var_0_0.TOP_MARGIN - var_0_0.BOTTOM_MARGIN), 20, 10)

	lc.addChildToCenter(arg_2_0._form, var_2_0)

	arg_2_0._list = var_2_0

	arg_2_0._form:setPosition(lc.x(arg_2_0._form), lc.y(arg_2_0._form) + 10)

	arg_2_0._pbResult = arg_2_1
	arg_2_0._level = arg_2_2
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)

	if P._level > arg_3_0._level then
		local var_3_0 = require("LevelUpPanel").createLord(arg_3_0._level, P._level)

		lc._runningScene._scene:addChild(var_3_0, ClientData.ZOrder.form)

		arg_3_0._level = P._level
	end

	arg_3_0:onScheduler()

	arg_3_0._schedulerId = lc.Scheduler:scheduleScriptFunc(function(arg_4_0)
		arg_3_0:onScheduler(arg_4_0)
	end, 1, false)
end

function var_0_0.onExit(arg_5_0)
	var_0_0.super.onExit(arg_5_0)
	lc.Scheduler:unscheduleScriptEntry(arg_5_0._schedulerId)
end

function var_0_0.hide(arg_6_0, arg_6_1)
	local function var_6_0()
		local var_7_0 = lc._runningScene._sceneId

		if GuideManager._hasNewCityGuide then
			if var_7_0 == ClientData.SceneId.city then
				GuideManager.startStep()
				BaseScene.clearPanels()
			else
				ClientView.popScene(true)

				if ClientView._cityScene then
					ClientView._cityScene._needGuideStartStep = true
					ClientView._cityScene._isGuideOnEnter = true
				end
			end
		elseif GuideManager._hasNewWorldGuide then
			if var_7_0 == ClientData.SceneId.expedition then
				ClientView.popScene()

				if ClientView._crusadePanel then
					ClientView._crusadePanel:hide()
				end

				if ClientView._worldScene then
					ClientView._worldScene._needGuideStartStep = true
					ClientView._worldScene._isGuideOnEnter = true
				end
			else
				GuideManager.startStep()
				BaseScene.clearPanels()

				if lc._runningScene._sceneId == ClientData.SceneId.world then
					ClientView._worldScene:hideTab()
				end
			end
		end
	end

	local var_6_1 = arg_6_0._level

	var_0_0.super.hide(arg_6_0, arg_6_1)

	if var_6_1 < P._level then
		local var_6_2 = require("LevelUpPanel").createLord(var_6_1, P._level)

		lc._runningScene._scene:addChild(var_6_2, ClientData.ZOrder.form)

		function var_6_2._cleanupHandler()
			var_6_0()
		end

		local var_6_3 = P._level
	else
		var_6_0()
	end
end

function var_0_0.onScheduler(arg_9_0, arg_9_1)
	local var_9_0 = #arg_9_0._list:getItems()

	if var_9_0 == #arg_9_0._pbResult then
		lc.Scheduler:unscheduleScriptEntry(arg_9_0._schedulerId)

		return
	end

	local var_9_1 = arg_9_0:createItem(var_9_0 + 1)

	arg_9_0._list:pushBackCustomItem(var_9_1)
	arg_9_0._list:refreshView()
	arg_9_0._list:scrollToBottom(0.5, true)
end

function var_0_0.createItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._pbResult[arg_10_1]
	local var_10_1 = lc.createSprite("img_title_bg")

	var_10_1:setScale(3, 1)

	local var_10_2 = cc.Label:createWithTTF(string.format(Str(STR.ROUND), arg_10_1), ClientView.TTF_FONT, ClientView.FontSize.M1)

	var_10_2:setColor(ClientView.COLOR_TEXT_LIGHT)

	local var_10_3 = lc.sw(var_10_1) - 10
	local var_10_4 = lc.h(var_10_1) + 6
	local var_10_5 = var_10_0.resource
	local var_10_6 = {}

	for iter_10_0 = 1, #var_10_5 do
		local var_10_7 = {
			_infoId = var_10_5[iter_10_0].info_id,
			_count = var_10_5[iter_10_0].num,
			_isFragment = var_10_5[iter_10_0].is_fragment,
			_level = var_10_5[iter_10_0].level
		}

		table.insert(var_10_6, var_10_7)
	end

	P:sortResultItems(var_10_6)

	local var_10_8 = {}
	local var_10_9 = 28

	for iter_10_1 = 1, #var_10_6 do
		local var_10_10 = IconWidget.create(var_10_6[iter_10_1])

		var_10_10:setPositionX(var_10_9 + lc.w(var_10_10) / 2)

		var_10_10._marginTop = var_10_4

		table.insert(var_10_8, var_10_10)

		if iter_10_1 < #var_10_6 then
			if iter_10_1 % 6 == 0 then
				var_10_9 = 30
				var_10_4 = var_10_4 + lc.h(var_10_10) + 6
			else
				var_10_9 = var_10_9 + lc.w(var_10_10) + 10
			end
		else
			var_10_4 = var_10_4 + lc.h(var_10_10)
		end
	end

	local var_10_11 = var_10_4 + 40
	local var_10_12 = ccui.ImageView:create("img_com_bg_10", ccui.TextureResType.plistType)

	var_10_12:setScale9Enabled(true)
	var_10_12:setCapInsets(ClientView.CRECT_COM_BG10)
	var_10_12:setContentSize(var_10_3, var_10_11)
	var_10_1:setPosition(lc.w(var_10_12) / 2, lc.h(var_10_12) - lc.h(var_10_1) / 2 - 16)
	var_10_12:addChild(var_10_1)
	var_10_2:setPosition(var_10_1:getPosition())
	var_10_12:addChild(var_10_2)

	for iter_10_2 = 1, #var_10_8 do
		var_10_8[iter_10_2]:setPositionY(lc.h(var_10_12) - var_10_8[iter_10_2]._marginTop - lc.h(var_10_8[iter_10_2]) / 2 - 16)
		var_10_12:addChild(var_10_8[iter_10_2])
	end

	return var_10_12
end

return var_0_0
