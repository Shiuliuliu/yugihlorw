local var_0_0 = class("Socket_pb")
local var_0_1 = 0.1
local var_0_2 = 10

var_0_0.Status = {
	closed = "closed",
	timeout = "timeout",
	not_connected = "Socket is not connected",
	already_connected = "already connected",
	already_in_progress = "Operation already in progress"
}
var_0_0.Event = {
	connect = "SOCKET_PB_CONNECT",
	connect_fail = "SOCKET_PB_CONNECT_FAIL",
	data = "SOCKET_PB_DATA",
	disconnect = "SOCKET_PB_DISCONNECT"
}

local var_0_3 = require("socket")
local var_0_4 = lc.Scheduler
local var_0_5

var_0_0._VERSION = var_0_3._VERSION
var_0_0._DEBUG = var_0_3._DEBUG

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._host = arg_1_1
	arg_1_0._port = arg_1_2
	arg_1_0._isConnected = false
	arg_1_0._name = arg_1_1 .. ":" .. arg_1_2
	arg_1_0._recvScheduler = nil
	arg_1_0._connectTimeTickScheduler = nil
	arg_1_0._tcp = nil

	arg_1_0:_resetRecvBuf()

	arg_1_0._sSerial = 0
	arg_1_0._sStep = 0
	arg_1_0._cSerial = 0
	arg_1_0._cStep = 0
end

function var_0_0.setName(arg_2_0, arg_2_1)
	arg_2_0._name = arg_2_1
end

function var_0_0.setTickTime(arg_3_0, arg_3_1)
	var_0_1 = arg_3_1

	return arg_3_0
end

function var_0_0.setConnFailTime(arg_4_0, arg_4_1)
	var_0_2 = arg_4_1

	return arg_4_0
end

function var_0_0.getTime()
	return var_0_3.gettime()
end

function var_0_0.connect(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 then
		arg_6_0._host = arg_6_1
	end

	if arg_6_2 then
		arg_6_0._port = arg_6_2
	end

	assert(arg_6_0._host or arg_6_0._port, "Host and port are necessary!")
	lc.log("[NETWORK] %s connect", arg_6_0._name)

	local var_6_0 = false
	local var_6_1, var_6_2 = var_0_3.dns.getaddrinfo(arg_6_0._host)

	if var_6_1 ~= nil then
		for iter_6_0, iter_6_1 in pairs(var_6_1) do
			lc.log("[NETWORK] %s family: %s", arg_6_0._name, iter_6_1.family)

			if iter_6_1.family == "inet6" then
				var_6_0 = true

				break
			end
		end
	end

	if var_6_0 then
		arg_6_0._tcp = var_0_3.tcp6()
	else
		arg_6_0._tcp = var_0_3.tcp()
	end

	if arg_6_0._tcp == nil then
		arg_6_0:_onConnectFail()

		return
	end

	arg_6_0._tcp:settimeout(0)

	local function var_6_3()
		lc.log("[NETWORK] %s connectTimeTick", arg_6_0._name)

		if arg_6_0:_connect() then
			arg_6_0:_onConnected()
		else
			arg_6_0._waitConnect = arg_6_0._waitConnect or 0
			arg_6_0._waitConnect = arg_6_0._waitConnect + var_0_1

			if arg_6_0._waitConnect >= var_0_2 then
				arg_6_0._waitConnect = nil

				arg_6_0:close()
				arg_6_0:_onConnectFail()
			end
		end
	end

	arg_6_0._connectTimeTickScheduler = var_0_4:scheduleScriptFunc(var_6_3, var_0_1, false)
end

function var_0_0.disconnect(arg_8_0, arg_8_1)
	arg_8_0:_disconnect(arg_8_1)
end

function var_0_0.close(arg_9_0)
	lc.log("[NETWORK] %s close", arg_9_0._name)
	arg_9_0._tcp:close()

	if arg_9_0._connectTimeTickScheduler then
		var_0_4:unscheduleScriptEntry(arg_9_0._connectTimeTickScheduler)

		arg_9_0._connectTimeTickScheduler = nil
	end

	if arg_9_0._recvScheduler then
		var_0_4:unscheduleScriptEntry(arg_9_0._recvScheduler)

		arg_9_0._recvScheduler = nil
	end
end

function var_0_0.sendProtoMsg(arg_10_0, arg_10_1)
	if not arg_10_0._isConnected then
		return
	end

	local var_10_0 = arg_10_1:SerializeToString()
	local var_10_1 = #var_10_0 + 2
	local var_10_2 = string.crc16(var_10_0)
	local var_10_3 = var_10_0 .. string.pack(">H", var_10_2)

	arg_10_0._cSerial = bit.band(arg_10_0._cSerial + arg_10_0._cStep, 4294967295)

	local var_10_4 = string.encrypt(var_10_3, arg_10_0._cSerial)

	if arg_10_0:_send(string.pack(">I", var_10_1) .. var_10_4) == nil then
		arg_10_0:disconnect(true)
		arg_10_0:close()
	end
end

function var_0_0._connect(arg_11_0)
	local var_11_0, var_11_1 = arg_11_0._tcp:connect(arg_11_0._host, arg_11_0._port)

	return var_11_0 == 1 or var_11_1 == var_0_0.Status.already_connected
end

function var_0_0._disconnect(arg_12_0, arg_12_1)
	assert(arg_12_1 ~= nil, "on disconnect isSendEvent can not be nil")

	if not arg_12_0._isConnected then
		return
	end

	arg_12_0._isConnected = false

	arg_12_0._tcp:shutdown()

	if arg_12_1 then
		local var_12_0 = cc.EventCustom:new(var_0_0.Event.disconnect)

		var_12_0._socket = arg_12_0

		lc.Dispatcher:dispatchEvent(var_12_0)
	end
end

function var_0_0._onConnected(arg_13_0)
	lc.log("[NETWORK] %s _onConnected", arg_13_0._name)

	arg_13_0._isConnected = true

	if arg_13_0._connectTimeTickScheduler then
		var_0_4:unscheduleScriptEntry(arg_13_0._connectTimeTickScheduler)
	end

	local var_13_0 = cc.EventCustom:new(var_0_0.Event.connect)

	var_13_0._socket = arg_13_0

	lc.Dispatcher:dispatchEvent(var_13_0)
	arg_13_0:_resetRecvBuf()

	local function var_13_1()
		while true do
			local var_14_0, var_14_1, var_14_2 = arg_13_0._tcp:receive(arg_13_0._remainBytes)

			if var_14_1 == var_0_0.Status.closed or var_14_1 == var_0_0.Status.not_connected then
				arg_13_0:close()

				if arg_13_0._isConnected then
					arg_13_0:_onDisconnect()
				else
					arg_13_0:_onConnectFail(var_14_1)
				end

				return
			end

			var_14_0 = var_14_0 or var_14_2

			local var_14_3 = #var_14_0

			if var_14_3 > 0 then
				arg_13_0._remainBytes = arg_13_0._remainBytes - var_14_3
				arg_13_0._recvBuf = arg_13_0._recvBuf .. var_14_0
			end

			if arg_13_0._remainBytes == 0 then
				if arg_13_0._isRecvSize then
					arg_13_0._isRecvSize = false

					local var_14_4, var_14_5 = string.unpack(arg_13_0._recvBuf, ">I")

					arg_13_0._remainBytes = var_14_5
					arg_13_0._recvBuf = ""
				else
					arg_13_0:_processRecvBuf()
				end
			end

			if var_14_1 == var_0_0.Status.timeout then
				return
			end
		end
	end

	arg_13_0._recvScheduler = var_0_4:scheduleScriptFunc(var_13_1, var_0_1, false)
end

function var_0_0._onDisconnect(arg_15_0)
	lc.log("[NETWORK] %s _onDisConnect", arg_15_0._name)

	arg_15_0._isConnected = false

	if arg_15_0._connectTimeTickScheduler then
		var_0_4:unscheduleScriptEntry(arg_15_0._connectTimeTickScheduler)
	end

	if arg_15_0._recvScheduler then
		var_0_4:unscheduleScriptEntry(arg_15_0._recvScheduler)
	end

	local var_15_0 = cc.EventCustom:new(var_0_0.Event.disconnect)

	var_15_0._socket = arg_15_0

	lc.Dispatcher:dispatchEvent(var_15_0)
end

function var_0_0._onConnectFail(arg_16_0, arg_16_1)
	lc.log("[NETWORK] %s _onConnectFail", arg_16_0._name)

	local var_16_0 = cc.EventCustom:new(var_0_0.Event.connect_fail)

	var_16_0._status = arg_16_1
	var_16_0._socket = arg_16_0

	lc.Dispatcher:dispatchEvent(var_16_0)
end

function var_0_0._send(arg_17_0, arg_17_1)
	if not arg_17_0._isConnected then
		local var_17_0 = cc.EventCustom:new(var_0_0.Event.disconnect)

		var_17_0._socket = arg_17_0

		lc.Dispatcher:dispatchEvent(var_17_0)

		return
	end

	return arg_17_0._tcp:send(arg_17_1)
end

function var_0_0._resetRecvBuf(arg_18_0)
	arg_18_0._isRecvSize = true
	arg_18_0._recvBuf = ""
	arg_18_0._remainBytes = 4
end

function var_0_0._processRecvBuf(arg_19_0)
	if arg_19_0._sStep == 0 then
		lc.log("[NETWORK] %s send authentication", arg_19_0._name)

		local var_19_0 = SglMsg_pb.SglRespMsg()

		var_19_0:ParseFromString(arg_19_0._recvBuf)

		local var_19_1 = var_19_0.Extensions[Auth_pb.SglAuthMsg.challenge]

		arg_19_0._sSerial = arg_19_0:_unpackInt(var_19_1, 1)
		arg_19_0._sStep = arg_19_0:_unpackInt(var_19_1, 2)
		arg_19_0._cSerial = arg_19_0:_unpackInt(var_19_1, 3)
		arg_19_0._cStep = arg_19_0:_unpackInt(var_19_1, 4)

		local var_19_2 = SglMsg_pb.SglReqMsg()

		var_19_2.type = SglMsgType_pb.PB_TYPE_AUTHENTICATION
		var_19_2.Extensions[Auth_pb.SglAuthMsg.authentication] = var_19_1

		arg_19_0:sendProtoMsg(var_19_2)
		arg_19_0:_resetRecvBuf()
	else
		arg_19_0._sSerial = bit.band(arg_19_0._sSerial + arg_19_0._sStep, 4294967295)

		local var_19_3 = string.decrypt(arg_19_0._recvBuf, arg_19_0._sSerial)
		local var_19_4 = #var_19_3
		local var_19_5, var_19_6 = string.unpack(string.sub(var_19_3, var_19_4 - 1), ">H")
		local var_19_7 = string.sub(var_19_3, 1, var_19_4 - 2)
		local var_19_8 = string.crc16(var_19_7)
		local var_19_9 = cc.EventCustom:new(var_0_0.Event.data)

		if var_19_8 ~= var_19_6 then
			var_19_9._hasError = true
		else
			local var_19_10 = SglMsg_pb.SglRespMsg()

			var_19_10:ParseFromString(var_19_7)

			var_19_9._hasError = false
			var_19_9._msg = var_19_10
		end

		var_19_9._socket = arg_19_0

		arg_19_0:_resetRecvBuf()
		lc.Dispatcher:dispatchEvent(var_19_9)
	end
end

function var_0_0._unpackInt(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = string.byte(arg_20_1, arg_20_2)

	if var_20_0 >= 128 then
		var_20_0 = 255 - var_20_0 + 1
	end

	local var_20_1 = bit.lshift(var_20_0 % 16, 3)
	local var_20_2, var_20_3 = string.unpack(string.sub(arg_20_1, var_20_1 + 1, var_20_1 + 5), ">i")

	return var_20_3
end

return var_0_0
