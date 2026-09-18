local var_0_0 = class("PalaceTaskArea", lc.ExtendCCNode)
local var_0_1 = 800
local var_0_2 = 390
local var_0_3 = 100

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(math.min(arg_1_0, var_0_1), arg_1_1)
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
	arg_3_0._scene = lc._runningScene

	local var_3_0 = lc.List.createV(arg_3_0:getContentSize(), 5, 0)

	lc.addChildToCenter(arg_3_0, var_3_0)

	arg_3_0._list = var_3_0

	arg_3_0:updateTaskList()
end

function var_0_0.createTaskItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ccui.Widget:create()
	local var_4_1 = cc.size(lc.w(arg_4_0._list) - 10, 160)

	var_4_0:setContentSize(var_4_1)

	var_4_0._task = arg_4_1

	local var_4_2 = lc.createImageView({
		_name = "img_com_bg_17",
		_crect = ClientView.CRECT_COM_BG17,
		_size = var_4_1
	})

	var_4_2:setAnchorPoint(0, 0.5)
	lc.addChildToCenter(var_4_0, var_4_2)

	local var_4_3 = ccui.Layout:create()

	var_4_3:setContentSize(var_4_1.width - 100, var_4_1.height)
	var_4_3:setClippingEnabled(true)
	lc.addChildToCenter(var_4_0, var_4_3)

	var_4_0._layout = var_4_3

	local var_4_4 = require("IconWidget").create({
		_infoId = arg_4_1:getHeroInfoId()
	}, 0)

	lc.addChildToPos(var_4_3, var_4_4, cc.p(lc.w(var_4_4) / 2, var_4_1.height / 2 + 2))

	var_4_0._icon = var_4_4

	local var_4_5 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_4_0:onTaskItemDetail(var_4_0)
	end, ClientView.CRECT_BUTTON, 120)

	var_4_5:addLabel(Str(STR.DETAIL))
	lc.addChildToPos(var_4_3, var_4_5, cc.p(lc.w(var_4_3) - lc.w(var_4_5) / 2, 54))

	var_4_0._btnDetail = var_4_5

	function var_4_0.updateView(arg_6_0, arg_6_1)
		arg_6_1 = arg_6_1 or arg_6_0._task
		arg_6_0._task = arg_6_1

		local var_6_0 = arg_6_0._layout
		local var_6_1 = arg_6_0._icon

		var_6_1:setData({
			_infoId = arg_6_1:getHeroInfoId()
		}, 0)
		var_6_0:removeChildrenByTag(var_0_3)

		arg_6_0._btnFunc = nil
		arg_6_0._progress = nil
		arg_6_0._isFinished = nil

		if arg_6_1._timestamp == 0 then
			local var_6_2 = ClientView.createBoldRichText(arg_6_1:getDesc(), {
				_normalClr = ClientView.COLOR_TEXT_DARK,
				_boldClr = ClientView.COLOR_LABEL_DARK,
				_fontSize = ClientView.FontSize.S1,
				_width = var_0_2
			})

			lc.addChildToPos(var_6_0, var_6_2, cc.p(lc.right(var_6_1) + 20 + var_0_2 / 2, lc.y(var_6_1)), 0, var_0_3)

			local var_6_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, ClientData.formatPeriod(arg_6_1:getDuration(), 1))

			lc.addChildToPos(var_6_0, var_6_3, cc.p(lc.x(arg_6_0._btnDetail), 104), 0, var_0_3)
		else
			local var_6_4 = string.splitByChar(arg_6_1:getDesc(), "|")
			local var_6_5 = ClientView.createTTF(var_6_4[#var_6_4], ClientView.FontSize.S2, ClientView.COLOR_TEXT_DARK, cc.size(var_0_2, 0))

			lc.addChildToPos(var_6_0, var_6_5, cc.p(lc.right(var_6_1) + 20 + var_0_2 / 2, lc.top(var_6_1) - lc.h(var_6_5) / 2), 0, var_0_3)

			local var_6_6 = ClientView.createProgressBar(var_0_2)

			lc.addChildToPos(var_6_0, var_6_6, cc.p(lc.x(var_6_5), 50), 0, var_0_3)

			arg_6_0._progress = var_6_6

			local var_6_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, "")

			lc.addChildToCenter(arg_6_0._progress, var_6_7)
			var_6_7:setScale(0.8)

			arg_6_0._progress._label = var_6_7

			local var_6_8 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_7_0)
				if arg_6_0._isFinished then
					arg_4_0:onTaskItemClaim(arg_6_0)
				else
					arg_4_0:onTaskItemGiveup(arg_6_0, false)
				end
			end, ClientView.CRECT_BUTTON, 120)

			var_6_8:addLabel("")
			lc.addChildToPos(var_6_0, var_6_8, cc.p(lc.x(arg_6_0._btnDetail), 110), 0, var_0_3)

			arg_6_0._btnFunc = var_6_8

			arg_6_0:updateProgress()
		end
	end

	function var_4_0.updateProgress(arg_8_0)
		local var_8_0 = arg_8_0._task

		if var_8_0._timestamp == 0 then
			return
		end

		local var_8_1 = var_8_0._timestamp - ClientData.getCurrentTime()
		local var_8_2 = arg_8_0._progress._label
		local var_8_3 = arg_8_0._progress._bar
		local var_8_4 = arg_8_0._btnFunc

		if var_8_1 < 0 then
			if not arg_8_0._isFinished then
				var_8_2:setString(Str(STR.FINISHED))
				var_8_3:setPercent(100)
				var_8_3:setColor(lc.Color3B.green)
				var_8_4._label:setString(Str(STR.CLAIM))

				arg_8_0._isFinished = true

				arg_4_0._scene:showTabFlag(arg_4_0._scene.TAB.task)
			end
		else
			var_8_2:setString(string.format("%s: %s", Str(STR.REMAIN_TIME), ClientData.formatPeriod(var_8_1)))

			local var_8_5 = var_8_0:getDuration()

			var_8_3:setPercent((var_8_5 - var_8_1) / var_8_5 * 100)
			var_8_3:setColor(lc.Color3B.white)
			var_8_4._label:setString(Str(STR.GIVEUP))
		end
	end

	var_4_0:updateView()

	if arg_4_2 >= 0 then
		var_4_2:setContentSize(100, var_4_1.height)
		var_4_3:setContentSize(math.max(0, lc.w(var_4_2) - 100), var_4_1.height)

		arg_4_2 = arg_4_2 or 0

		var_4_2:registerScriptHandler(function(arg_9_0)
			if arg_9_0 == "enter" then
				var_4_2:scheduleUpdateWithPriorityLua(function(arg_10_0)
					arg_4_2 = arg_4_2 - arg_10_0

					if arg_4_2 <= 0 then
						local var_10_0 = var_4_2:getContentSize()

						var_10_0.width = var_10_0.width + 20

						if var_10_0.width > lc.w(var_4_0) then
							var_10_0.width = lc.w(var_4_0)

							var_4_2:unscheduleUpdate()
						end

						var_4_2:setContentSize(var_10_0)
						var_4_3:setContentSize(math.max(0, var_10_0.width - 100), var_10_0.height)
					end
				end, 0)
			elseif arg_9_0 == "exit" then
				var_4_2:unscheduleUpdate()
			end
		end)
	end

	return var_4_0
end

function var_0_0.updateTaskList(arg_11_0)
	local var_11_0 = P._playerPalace:getTasks()
	local var_11_1 = arg_11_0._list

	var_11_1:bindData(var_11_0, function(arg_12_0, arg_12_1)
		arg_12_0:updateView(arg_12_1)
	end, math.min(6, #var_11_0))

	for iter_11_0 = 1, var_11_1._cacheCount do
		local var_11_2 = arg_11_0:createTaskItem(var_11_0[iter_11_0], arg_11_0._isOpenActionDone and -1 or 0)

		var_11_1:pushBackCustomItem(var_11_2)
	end

	arg_11_0._isOpenActionDone = true

	arg_11_0._scene:showTabFlag(arg_11_0._scene.TAB.task)
end

function var_0_0.onEnter(arg_13_0)
	arg_13_0._listeners = {}

	local var_13_0 = lc.addEventListener(Data.Event.palace_task_list_dirty, function(arg_14_0)
		arg_13_0:updateTaskList()
	end)

	table.insert(arg_13_0._listeners, var_13_0)

	local var_13_1 = lc.addEventListener(Data.Event.palace_task_dirty, function(arg_15_0)
		if arg_15_0._data:isRunning() then
			local var_15_0 = arg_13_0._list:getItems()

			for iter_15_0, iter_15_1 in ipairs(var_15_0) do
				if iter_15_1._task == arg_15_0._data then
					iter_15_1:updateView()
				end
			end
		elseif arg_15_0._data:isFinished() then
			arg_13_0._scene:showTabFlag(arg_13_0._scene.TAB.task)
		end
	end)

	table.insert(arg_13_0._listeners, var_13_1)
	arg_13_0:scheduleUpdateWithPriorityLua(function(arg_16_0)
		arg_13_0:onSchedule(arg_16_0)
	end, 0)
end

function var_0_0.onExit(arg_17_0)
	for iter_17_0 = 1, #arg_17_0._listeners do
		lc.Dispatcher:removeEventListener(arg_17_0._listeners[iter_17_0])
	end

	arg_17_0:unscheduleUpdate()
end

function var_0_0.onSchedule(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._list:getItems()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		iter_18_1:updateProgress()
	end
end

function var_0_0.onTaskItemGiveup(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1._isFinished then
		ToastManager.push(Str(STR.PALACE_REVIEW_DONE))

		return
	end

	if not arg_19_2 then
		require("Dialog").showDialog(Str(STR.SURE_TO_GIVEUP), function()
			arg_19_0:onTaskItemGiveup(arg_19_1, true)
		end)

		return
	end

	arg_19_1._task._timestamp = 0

	for iter_19_0 = 1, #arg_19_1._task._monsters do
		arg_19_1._task._monsters[iter_19_0]._taskId = nil
	end

	arg_19_1._task._monsters = {}

	arg_19_1:updateView()
	ClientData.sendCancelPalaceTask(arg_19_1._task._id)
end

function var_0_0.onTaskItemDetail(arg_21_0, arg_21_1)
	require("PalaceTaskForm").create(arg_21_1._task):show()
end

function var_0_0.onTaskItemClaim(arg_22_0, arg_22_1)
	local var_22_0, var_22_1 = P._playerPalace:claimTask(arg_22_1._task)

	if var_22_0 == Data.ErrorType.ok then
		require("RewardPanel").create(var_22_1):show()
		lc.Audio.playAudio(AUDIO.E_CLAIM)
		ClientData.sendClaimPalaceTask(arg_22_1._task._id)

		P._playerPalace._tasks[arg_22_1._task._id] = nil

		P._playerPalace:sendPalaceTaskDone()
	end
end

return var_0_0
