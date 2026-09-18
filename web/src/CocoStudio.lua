require("json")
require("extern")

ccs = ccs or {}

function ccs.sendTriggerEvent(arg_1_0)
	local var_1_0 = ccs.TriggerMng.getInstance():get(arg_1_0)

	if var_1_0 == nil then
		return
	end

	for iter_1_0 = 1, table.getn(var_1_0) do
		local var_1_1 = var_1_0[iter_1_0]

		if var_1_1 ~= nil and var_1_1:detect() then
			var_1_1:done()
		end
	end
end

function ccs.registerTriggerClass(arg_2_0, arg_2_1)
	ccs.TInfo.new(arg_2_0, arg_2_1)
end

ccs.TInfo = class("TInfo")
ccs.TInfo._className = ""
ccs.TInfo._fun = nil

function ccs.TInfo.ctor(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 ~= nil then
		arg_3_0._className = arg_3_1
		arg_3_0._fun = arg_3_2
	else
		arg_3_0._className = arg_3_1._className
		arg_3_0._fun = arg_3_1._fun
	end

	ccs.ObjectFactory.getInstance():registerType(arg_3_0)
end

ccs.ObjectFactory = class("ObjectFactory")
ccs.ObjectFactory._typeMap = nil
ccs.ObjectFactory._instance = nil

function ccs.ObjectFactory.ctor(arg_4_0)
	arg_4_0._typeMap = {}
end

function ccs.ObjectFactory.getInstance()
	if ccs.ObjectFactory._instance == nil then
		ccs.ObjectFactory._instance = ccs.ObjectFactory.new()
	end

	return ccs.ObjectFactory._instance
end

function ccs.ObjectFactory.destroyInstance()
	ccs.ObjectFactory._instance = nil
end

function ccs.ObjectFactory.createObject(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1 = arg_7_0._typeMap[arg_7_1]

	if var_7_1 ~= nil then
		var_7_0 = var_7_1._fun()
	end

	return var_7_0
end

function ccs.ObjectFactory.registerType(arg_8_0, arg_8_1)
	arg_8_0._typeMap[arg_8_1._className] = arg_8_1
end

ccs.TriggerObj = class("TriggerObj")
ccs.TriggerObj._cons = {}
ccs.TriggerObj._acts = {}
ccs.TriggerObj._enable = false
ccs.TriggerObj._id = 0
ccs.TriggerObj._vInt = {}

function ccs.TriggerObj.extend(arg_9_0)
	local var_9_0 = tolua.getpeer(arg_9_0)

	if not var_9_0 then
		var_9_0 = {}

		tolua.setpeer(arg_9_0, var_9_0)
	end

	setmetatable(var_9_0, TriggerObj)

	return arg_9_0
end

function ccs.TriggerObj.ctor(arg_10_0)
	arg_10_0:init()
end

function ccs.TriggerObj.init(arg_11_0)
	arg_11_0._id = 0
	arg_11_0._enable = true
	arg_11_0._cons = {}
	arg_11_0._acts = {}
	arg_11_0._vInt = {}
end

function ccs.TriggerObj.detect(arg_12_0)
	if not arg_12_0._enable or table.getn(arg_12_0._cons) == 0 then
		return true
	end

	local var_12_0 = true
	local var_12_1

	for iter_12_0 = 1, table.getn(arg_12_0._cons) do
		local var_12_2 = arg_12_0._cons[iter_12_0]

		if var_12_2 ~= nil and var_12_2.detect ~= nil then
			var_12_0 = var_12_0 and var_12_2:detect()
		end
	end

	return var_12_0
end

function ccs.TriggerObj.done(arg_13_0)
	if not arg_13_0._enable or table.getn(arg_13_0._acts) == 0 then
		return
	end

	local var_13_0

	for iter_13_0 = 1, table.getn(arg_13_0._acts) do
		local var_13_1 = arg_13_0._acts[iter_13_0]

		if var_13_1 ~= nil and var_13_1.done then
			var_13_1:done()
		end
	end
end

function ccs.TriggerObj.removeAll(arg_14_0)
	local var_14_0

	for iter_14_0 = 1, table.getn(arg_14_0._cons) do
		local var_14_1 = arg_14_0._cons[iter_14_0]

		if var_14_1 ~= nil then
			var_14_1:removeAll()
		end
	end

	arg_14_0._cons = {}

	for iter_14_1 = 1, table.getn(arg_14_0._acts) do
		local var_14_2 = arg_14_0._acts[iter_14_1]

		if var_14_2 ~= nil then
			var_14_2:removeAll()
		end
	end

	arg_14_0._acts = {}
end

function ccs.TriggerObj.serialize(arg_15_0, arg_15_1)
	arg_15_0._id = arg_15_1.id

	local var_15_0 = 0
	local var_15_1 = arg_15_1.conditions

	if var_15_1 ~= nil then
		local var_15_2 = table.getn(var_15_1)

		for iter_15_0 = 1, var_15_2 do
			local var_15_3 = var_15_1[iter_15_0]
			local var_15_4 = var_15_3.classname

			if var_15_4 ~= nil then
				local var_15_5 = ccs.ObjectFactory.getInstance():createObject(var_15_4)

				assert(var_15_5 ~= nil, string.format("class named %s can not implement!", var_15_4))
				var_15_5:serialize(var_15_3)
				var_15_5:init()
				table.insert(arg_15_0._cons, var_15_5)
			end
		end
	end

	local var_15_6 = arg_15_1.actions

	if var_15_6 ~= nil then
		local var_15_7 = table.getn(var_15_6)

		for iter_15_1 = 1, var_15_7 do
			local var_15_8 = var_15_6[iter_15_1]
			local var_15_9 = var_15_8.classname

			if var_15_9 ~= nil then
				local var_15_10 = ccs.ObjectFactory.getInstance():createObject(var_15_9)

				assert(var_15_10 ~= nil, string.format("class named %s can not implement!", var_15_9))
				var_15_10:serialize(var_15_8)
				var_15_10:init()
				table.insert(arg_15_0._acts, var_15_10)
			end
		end
	end

	local var_15_11 = arg_15_1.events

	if var_15_11 ~= nil then
		local var_15_12 = table.getn(var_15_11)

		for iter_15_2 = 1, var_15_12 do
			local var_15_13 = var_15_11[iter_15_2].id

			if var_15_13 >= 0 then
				table.insert(arg_15_0._vInt, var_15_13)
			end
		end
	end
end

function ccs.TriggerObj.getId(arg_16_0)
	return arg_16_0._id
end

function ccs.TriggerObj.setEnable(arg_17_0, arg_17_1)
	arg_17_0._enable = arg_17_1
end

function ccs.TriggerObj.getEvents(arg_18_0)
	return arg_18_0._vInt
end

ccs.TriggerMng = class("TriggerMng")
ccs.TriggerMng._eventTriggers = nil
ccs.TriggerMng._triggerObjs = nil
ccs.TriggerMng._movementDispatches = nil
ccs.TriggerMng._instance = nil

function ccs.TriggerMng.ctor(arg_19_0)
	arg_19_0._triggerObjs = {}
	arg_19_0._movementDispatches = {}
	arg_19_0._eventTriggers = {}
end

function ccs.TriggerMng.getInstance()
	if ccs.TriggerMng._instance == nil then
		ccs.TriggerMng._instance = ccs.TriggerMng.new()
	end

	return ccs.TriggerMng._instance
end

function ccs.TriggerMng.destroyInstance()
	if ccs.TriggerMng._instance ~= nil then
		ccs.TriggerMng._instance:removeAll()

		ccs.TriggerMng._instance = nil
	end
end

function ccs.TriggerMng.triggerMngVersion(arg_22_0)
	return "1.0.0.0"
end

function ccs.TriggerMng.parse(arg_23_0, arg_23_1)
	local var_23_0 = json.decode(arg_23_1, 1)

	if var_23_0 == nil then
		return
	end

	local var_23_1 = table.getn(var_23_0)

	for iter_23_0 = 1, var_23_1 do
		local var_23_2 = var_23_0[iter_23_0]
		local var_23_3 = ccs.TriggerObj.new()

		var_23_3:serialize(var_23_2)

		local var_23_4 = var_23_3:getEvents()

		for iter_23_1 = 1, table.getn(var_23_4) do
			local var_23_5 = var_23_4[iter_23_1]

			arg_23_0:add(var_23_5, var_23_3)
		end

		arg_23_0._triggerObjs[var_23_3:getId()] = var_23_3
	end
end

function ccs.TriggerMng.get(arg_24_0, arg_24_1)
	return arg_24_0._eventTriggers[arg_24_1]
end

function ccs.TriggerMng.getTriggerObj(arg_25_0, arg_25_1)
	return arg_25_0._triggerObjs[arg_25_1]
end

function ccs.TriggerMng.add(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0._eventTriggers[arg_26_1]

	if var_26_0 == nil then
		var_26_0 = {}
	end

	local var_26_1 = false

	for iter_26_0 = 1, table.getn(var_26_0) do
		if var_26_0[iter_26_0] == triggers then
			var_26_1 = true

			break
		end
	end

	if not var_26_1 then
		table.insert(var_26_0, arg_26_2)

		arg_26_0._eventTriggers[arg_26_1] = var_26_0
	end
end

function ccs.TriggerMng.removeAll(arg_27_0)
	for iter_27_0 in pairs(arg_27_0._eventTriggers) do
		local var_27_0 = arg_27_0._eventTriggers[iter_27_0]

		for iter_27_1 = 1, table.getn(var_27_0) do
			var_27_0[iter_27_1]:removeAll()
		end
	end

	arg_27_0._eventTriggers = {}
end

function ccs.TriggerMng.remove(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_2 ~= nil then
		return arg_28_0:removeObjByEvent(arg_28_1, arg_28_2)
	end

	assert(arg_28_1 >= 0, "event must be larger than 0")

	if arg_28_0._eventTriggers == nil then
		return false
	end

	local var_28_0 = arg_28_0._eventTriggers[arg_28_1]

	if var_28_0 == nil then
		return false
	end

	for iter_28_0 = 1, table.getn(var_28_0) do
		local var_28_1 = triggers[iter_28_0]

		if var_28_1 ~= nil then
			var_28_1:remvoeAll()
		end
	end

	arg_28_0._eventTriggers[arg_28_1] = nil

	return true
end

function ccs.TriggerMng.removeObjByEvent(arg_29_0, arg_29_1, arg_29_2)
	assert(arg_29_1 >= 0, "event must be larger than 0")

	if arg_29_0._eventTriggers == nil then
		return false
	end

	local var_29_0 = arg_29_0._eventTriggers[arg_29_1]

	if var_29_0 == nil then
		return false
	end

	for iter_29_0 = 1, table.getn(var_29_0) do
		local var_29_1 = var_29_0[iter_29_0]

		if var_29_1 ~= nil and var_29_1 == arg_29_2 then
			var_29_1:remvoeAll()
			table.remove(var_29_0, iter_29_0)

			return true
		end
	end
end

function ccs.TriggerMng.removeTriggerObj(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.getTriggerObj(arg_30_1)

	if var_30_0 == nil then
		return false
	end

	local var_30_1 = var_30_0:getEvents()

	for iter_30_0 = 1, table.getn(var_30_1) do
		arg_30_0:remove(var_30_1[iter_30_0], var_30_0)
	end

	return true
end

function ccs.TriggerMng.isEmpty(arg_31_0)
	return arg_31_0._eventTriggers ~= nil or table.getn(arg_31_0._eventTriggers) <= 0
end
