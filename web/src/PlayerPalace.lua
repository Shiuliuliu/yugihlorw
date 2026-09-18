-- ---------------------------------------------------------------------------
-- PlayerPalace -- reconstructed
--
-- PalaceScene, PalaceTaskArea, PalaceVisitArea and PalaceTaskForm all read
-- P._playerPalace, and the class is in none of the recovered artefacts: not in
-- this source tree, not in the 1089 decompile, not in the 1089 LuaJIT bytecode.
-- Player.lua has lost its construction too. class() in base/extern.lua has no
-- __index fallback, so an Android build made from these same sources dies at
-- PalaceTaskArea:214 exactly as the web one did.
--
-- What each method has to do is fixed by its callers, and the numbers come from
-- the game's own tables: palace_task.bin gives a task its reward bonus, how
-- many heroes it takes (_slot), which heroes suit it (_specialHero) and how
-- long it runs (_time, in hours); palace_visit.bin gives a visitor their hero,
-- their recruitment price and what they bring.
--
-- One judgement had to be made, and it is marked where it is made:
-- calcTaskRewardsPercent's curve is not in any table.
-- ---------------------------------------------------------------------------

local var_0_0 = class("PlayerPalace")

--- One task in progress, or offered.
local var_0_1 = class("PalaceTask")

function var_0_1.ctor(arg_1_0, arg_1_1)
	arg_1_0._id = arg_1_1
	arg_1_0._info = Data._palaceTaskInfo and Data._palaceTaskInfo[arg_1_1]
	arg_1_0._monsters = {}
	arg_1_0._timestamp = nil
end

--- Whether the task has been sent out and has not come back yet.
function var_0_1.isRunning(arg_2_0)
	return arg_2_0._timestamp ~= nil and ClientData.getCurrentTime() < arg_2_0._timestamp
end

--- Whether it has run its time and is waiting to be claimed.
function var_0_1.isFinished(arg_3_0)
	return arg_3_0._timestamp ~= nil and ClientData.getCurrentTime() >= arg_3_0._timestamp
end

function var_0_1.getRemainTime(arg_4_0)
	if arg_4_0._timestamp == nil then
		return 0
	end

	return math.max(0, arg_4_0._timestamp - ClientData.getCurrentTime())
end

--- A hero visiting the palace.
local var_0_2 = class("PalaceVisit")

function var_0_2.ctor(arg_5_0, arg_5_1)
	arg_5_0._id = arg_5_1
	arg_5_0._info = Data._palaceVisitInfo and Data._palaceVisitInfo[arg_5_1]
	arg_5_0._timestamp = ClientData.getCurrentTime()
	arg_5_0._grace = 0
end

--- A visitor is finished when their stay has run out; the screen then clears
-- them and draws its empty state.
function var_0_2.isFinished(arg_6_0)
	local var_6_0 = arg_6_0._info and arg_6_0._info._time or 0

	return ClientData.getCurrentTime() >= arg_6_0._timestamp + var_6_0 * 3600
end

function var_0_2.getRemainTime(arg_7_0)
	local var_7_0 = arg_7_0._info and arg_7_0._info._time or 0

	return math.max(0, arg_7_0._timestamp + var_7_0 * 3600 - ClientData.getCurrentTime())
end

var_0_0.Task = var_0_1
var_0_0.Visit = var_0_2

function var_0_0.ctor(arg_8_0)
	arg_8_0:clear()

	ClientData.addMsgListener(arg_8_0, function(arg_9_0)
		return arg_8_0:onMsg(arg_9_0)
	end, 0)
end

function var_0_0.clear(arg_10_0)
	arg_10_0._tasks = {}
	arg_10_0._visit = nil
end

--- The palace's state, as the login payload carries it.
-- A server that sends none leaves the palace empty, which is what a player who
-- has never sent anybody out actually has.
function var_0_0.init(arg_11_0, arg_11_1)
	arg_11_0:clear()

	if type(arg_11_1) ~= "table" then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.procedures or {}) do
		local var_11_0 = var_0_1.new(iter_11_1.info_id)

		var_11_0._timestamp = iter_11_1.timestamp and iter_11_1.timestamp / 1000 or nil

		for iter_11_2, iter_11_3 in ipairs(iter_11_1.hero_ids or {}) do
			local var_11_1 = P._playerCard._monsters[iter_11_3]

			if var_11_1 then
				table.insert(var_11_0._monsters, var_11_1)
			end
		end

		arg_11_0._tasks[var_11_0._id] = var_11_0
	end

	if arg_11_1.visit and arg_11_1.visit.info_id and arg_11_1.visit.info_id > 0 then
		local var_11_2 = var_0_2.new(arg_11_1.visit.info_id)

		var_11_2._timestamp = arg_11_1.visit.timestamp
			and arg_11_1.visit.timestamp / 1000 or var_11_2._timestamp

		arg_11_0._visit = var_11_2
	end
end

-- ---------------------------------------------------------------------------
-- tasks
-- ---------------------------------------------------------------------------

--- Every task, in id order, which is the order the screen lists them in.
function var_0_0.getTasks(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0._tasks) do
		var_12_0[#var_12_0 + 1] = iter_12_1
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		return arg_13_0._id < arg_13_1._id
	end)

	return var_12_0
end

--- How many tasks are waiting to be claimed. PalaceScene turns this into the
-- "new" flag on the task tab, so it counts only what the player can act on.
function var_0_0.getFinishedTaskNumber(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0._tasks) do
		if iter_14_1:isFinished() then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0
end

--- The share of a task's reward the chosen heroes will bring back.
--
-- PalaceTaskForm multiplies every count in the task's bonus row by this, so
-- with nobody assigned it must be zero and with the task's full complement it
-- must be one.
--
-- The curve itself is the one thing here that no table states. Each hero is
-- worth an equal share of the task's slots, and a hero the task names in
-- _specialHero is worth two of those shares - which is what naming them is
-- for, and which makes a full slate of the right heroes worth twice a full
-- slate of any others. If the original's numbers ever turn up, this is the
-- function to correct.
function var_0_0.calcTaskRewardsPercent(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1 and arg_15_1._info

	if var_15_0 == nil or arg_15_2 == nil or #arg_15_2 == 0 then
		return 0
	end

	local var_15_1 = math.max(1, var_15_0._slot or 1)
	local var_15_2 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0._specialHero or {}) do
		var_15_2[iter_15_1] = true
	end

	local var_15_3 = 0

	for iter_15_2, iter_15_3 in ipairs(arg_15_2) do
		var_15_3 = var_15_3 + (var_15_2[iter_15_3._infoId] and 2 or 1)
	end

	return var_15_3 / var_15_1
end

--- Send the chosen heroes out on a task.
-- The heroes are marked as busy the way the guard house marks them, so the
-- rest of the game stops offering them elsewhere.
function var_0_0.confirmTask(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == nil or arg_16_2 == nil or #arg_16_2 == 0 then
		return Data.ErrorType.error
	end

	local var_16_0 = arg_16_1._info

	if var_16_0 == nil then
		return Data.ErrorType.error
	end

	arg_16_1._monsters = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_2) do
		iter_16_1._taskId = arg_16_1._id

		table.insert(arg_16_1._monsters, iter_16_1)
	end

	arg_16_1._timestamp = ClientData.getCurrentTime() + (var_16_0._time or 0) * 3600
	arg_16_0._tasks[arg_16_1._id] = arg_16_1

	arg_16_0:sendPalaceTaskListDirty()

	return Data.ErrorType.ok
end

--- Take a finished task's reward and free its heroes.
function var_0_0.claimTask(arg_17_0, arg_17_1)
	if arg_17_1 == nil or not arg_17_1:isFinished() then
		return Data.ErrorType.error
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_1._monsters) do
		iter_17_1._taskId = nil
	end

	arg_17_1._monsters = {}
	arg_17_1._timestamp = nil
	arg_17_0._tasks[arg_17_1._id] = nil

	arg_17_0:sendPalaceTaskDone(arg_17_1)
	arg_17_0:sendPalaceTaskListDirty()

	return Data.ErrorType.ok
end

function var_0_0.sendPalaceTaskListDirty(arg_18_0)
	lc.sendEvent(Data.Event.palace_task_dirty, {})
end

function var_0_0.sendPalaceTaskDone(arg_19_0, arg_19_1)
	lc.sendEvent(Data.Event.palace_task_done, {
		_data = arg_19_1
	})
end

-- ---------------------------------------------------------------------------
-- the visitor
-- ---------------------------------------------------------------------------

--- Accept whatever the visitor brought and see them out.
function var_0_0.confirmVisit(arg_20_0)
	local var_20_0 = arg_20_0._visit

	if var_20_0 == nil or var_20_0._info == nil then
		return Data.ErrorType.error
	end

	local var_20_1 = var_20_0._info._item or {}
	local var_20_2 = var_20_0._info._number or {}

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		-- addResource(infoId, level, count, isFragment, silent)
		P:addResource(iter_20_1, 0, var_20_2[iter_20_0] or 1, false, true)
	end

	ClientData.sendConfirmPalaceVisit(var_20_0._id)
	arg_20_0:sendVisitDirty(var_20_0)

	return Data.ErrorType.ok
end

--- Pay to keep the visiting hero.
function var_0_0.recruitVisit(arg_21_0)
	local var_21_0 = arg_21_0._visit

	if var_21_0 == nil or var_21_0._info == nil then
		return Data.ErrorType.error
	end

	local var_21_1 = var_21_0._info._ingot or 0

	if not P:hasResource(Data.ResType.ingot, var_21_1) then
		return Data.ErrorType.need_more_ingot
	end

	P:changeResource(Data.ResType.ingot, -var_21_1)
	P:addResource(var_21_0._info._heroId, 0, 1, false, true)
	ClientData.sendRecruitPalaceVisit(var_21_0._id)
	arg_21_0:sendVisitDirty(var_21_0)

	return Data.ErrorType.ok
end

--- Ask the visitor to stay a while longer.
function var_0_0.stayVisit(arg_22_0)
	local var_22_0 = arg_22_0._visit

	if var_22_0 == nil then
		return Data.ErrorType.error
	end

	ClientData.sendStayPalaceVisit(var_22_0._id)
	arg_22_0:sendVisitDirty(var_22_0)

	return Data.ErrorType.ok
end

function var_0_0.sendVisitDirty(arg_23_0, arg_23_1)
	lc.sendEvent(Data.Event.palace_visit_dirty, {
		_data = arg_23_1
	})
end

-- ---------------------------------------------------------------------------

function var_0_0.onMsg(arg_24_0, arg_24_1)
	return false
end

return var_0_0
