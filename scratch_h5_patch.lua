-- h5_patch.lua -- the Lua-side adjustments the web client needs.
--
-- Everything here is applied through a `require` hook, so each patch lands
-- the moment the module it touches finishes loading and nothing has to be
-- reordered inside the game's own boot list.
--
-- Three things need patching:
--   * dataparser -- normally a C++ table parser over the .bin files; here the
--     tables come from dumps taken off the running Android client.
--   * ClientData.loadLCRes / unloadLCRes -- container loading moves to JS,
--     which is asynchronous. That is fine: LoadingScene already drives the
--     whole sequence off Data.Event.resource, one container per event.
--   * Socket_pb -- luasocket becomes a WebSocket (see js/net.js).

local M = {}

local jsres = jsbridge.object("jdzcRes")
local jsnet = jsbridge.object("jdzcNet")

-- ---------------------------------------------------------------------------
-- modules with no web counterpart
-- ---------------------------------------------------------------------------

-- luasocket: Socket_pb only touches gettime/dns/tcp at load, and every one of
-- those call sites is replaced below.
-- The PVP socket in jdzc.lua uses socket.tcp() for JSON-framed communication.
-- We provide a WebSocket-based implementation that emulates the luasocket API.
local jsnet = jsbridge.object("jdzcNet")

package.preload["socket"] = function()
	-- WebSocket-based TCP socket emulation for PVP
	local WsSocket = {}
	WsSocket.__index = WsSocket

	function WsSocket.new()
		local self = setmetatable({}, WsSocket)
		self._ws = nil
		self._connected = false
		self._recvBuf = ""
		self._timeout = 5
		return self
	end

	function WsSocket:settimeout(timeout)
		self._timeout = timeout or 5
	end

	function WsSocket:connect(host, port)
		-- Use the same WebSocket endpoint as Socket_pb
		local config = rawget(_G, "JDZC_CONFIG") or {}
		local wsHost = config.wsHost or host
		local wsPort = config.wsPort or port

		local ok, ws = pcall(function()
			return jsnet:open(wsHost, wsPort, function(what, payload)
				if what == "data" then
					self._recvBuf = self._recvBuf .. payload
				elseif what == "open" then
					self._connected = true
				elseif what == "close" or what == "error" then
					self._connected = false
				end
			end)
		end)

		if not ok or not ws then
			return nil, "Cannot create WebSocket"
		end

		self._ws = ws
		-- WebSocket connects asynchronously; mark as connected optimistically
		-- The onopen callback will confirm it. The game's polling loop will
		-- retry if the connection isn't ready yet.
		self._connected = true

		return 1
	end

	function WsSocket:send(data)
		if not self._ws or not self._connected then
			return nil, "Not connected"
		end
		jsbridge.bincall(self._ws, "send", data)
		return #data
	end

	function WsSocket:receive(pattern)
		if not self._connected then
			return nil, "closed"
		end

		-- For "*l" (line) pattern, read until newline
		if pattern == "*l" then
			local newline = self._recvBuf:find("\n")
			if newline then
				local line = self._recvBuf:sub(1, newline - 1)
				self._recvBuf = self._recvBuf:sub(newline + 1)
				return line
			end
			return nil, "timeout"
		end

		-- For numeric pattern, read that many bytes
		local n = tonumber(pattern)
		if n then
			if #self._recvBuf >= n then
				local data = self._recvBuf:sub(1, n)
				self._recvBuf = self._recvBuf:sub(n + 1)
				return data
			end
			return nil, "timeout"
		end

		-- For "*a" (all), return everything
		if pattern == "*a" then
			local data = self._recvBuf
			self._recvBuf = ""
			return data
		end

		return nil, "unknown pattern"
	end

	function WsSocket:close()
		if self._ws then
			self._ws:close()
			self._ws = nil
		end
		self._connected = false
	end

	return {
		_VERSION = "luasocket 3.0 (h5)",
		_DEBUG = false,
		gettime = function()
			return os.time()
		end,
		dns = {
			getaddrinfo = function(host)
				return { { family = "inet", addr = host } }
			end,
		},
		tcp = function()
			return WsSocket.new()
		end,
		tcp6 = function()
			return nil
		end,
	}
end

-- the EmmyLua debug hook exists only in the developer build; TcpDebug
-- connects to it at load, so hand it a module that does nothing
package.preload["emmy_core"] = function()
	return {
		tcpConnect = function() end,
		tcpListen = function() end,
	}
end

-- Monster.lua ships only on the dead hot-update channel and is missing from
-- the recovered source. HireHero requires it; an empty table keeps the boot
-- alive until it is recovered.
package.preload["Monster"] = function()
	return {}
end

-- ---------------------------------------------------------------------------
-- dataparser: served from the dumps
-- ---------------------------------------------------------------------------

local function patchData()
	local Data = rawget(_G, "Data")

	if type(Data) ~= "table" or type(Data.parseData) ~= "function" then
		return
	end

	if type(rawget(_G, "dataparser")) ~= "table" then
		rawset(_G, "dataparser", {})
	end

	local dp = rawget(_G, "dataparser")
	local current

	dp.parseData = function(buf, isTable)
		local name = current or (type(buf) == "string" and buf or nil)

		if name == nil then
			print("[h5] dataparser.parseData with no name")

			return {}
		end

		local src = jsres:dump(name)

		if src == nil then
			print("[h5] no dump for " .. tostring(name))

			return {}
		end

		local chunk, err = loadstring(src, "@dump:" .. tostring(name))

		if not chunk then
			print("[h5] dump " .. tostring(name) .. ": " .. tostring(err))

			return {}
		end

		local ok, res = pcall(chunk)

		if not ok then
			print("[h5] dump " .. tostring(name) .. ": " .. tostring(res))

			return {}
		end

		return res
	end

	local parseData = Data.parseData

	Data.parseData = function(name, buf)
		current = tostring(name)

		if JDZC_TRACE then
			print("[h5] parse " .. current)
		end

		local a, b, c = parseData(name, buf)

		current = nil

		return a, b, c
	end
end

-- ---------------------------------------------------------------------------
-- resources: containers load in JS, entries arrive as events
-- ---------------------------------------------------------------------------

-- SYNC_DECK_TO_WEB: Save deck changes directly to MySQL via jdzcApi:saveDeck
local function syncPlayerDecksToWeb()
	if not (P and P._playerCard and P._playerCard._troops) then return end
	local accId = ClientData._account and ClientData._account.id or 1
	local api = jsbridge and jsbridge.object("jdzcApi")
	if not (api and api.saveDeck) then return end

	local jsonMod = require("json")
	for slot = 1, 5 do
		local troop = P._playerCard._troops[slot]
		if troop and #troop > 0 then
			local cards = {}
			local extra = {}
			for _, item in ipairs(troop) do
				local cid = type(item) == "table" and (item._infoId or item.info_id) or item
				if cid and cid > 0 then
					local ctype = Data.getType(cid)
					if ctype == Data.CardType.rare then
						table.insert(extra, cid)
					else
						table.insert(cards, cid)
					end
				end
			end
			local cStr = jsonMod.encode(cards)
			local eStr = jsonMod.encode(extra)
			api:saveDeck(accId, slot, "Bộ Bài " .. tostring(slot), cStr, eStr)
		end
	end
end

function patchClientData()
	local ClientData = rawget(_G, "ClientData")

	if type(ClientData) ~= "table" then
		return
	end

	ClientData._lcres = ClientData._lcres or {}
	-- The native expedition/activity response initializes these counters before
	-- LotteryScene is reachable. A direct H5 scene driver can open it earlier;
	-- zero is the same empty-state value and keeps its progress math numeric.
	ClientData._lotteryPower = tonumber(ClientData._lotteryPower) or 0
	ClientData._lotteryWeekPower = tonumber(ClientData._lotteryWeekPower) or 0

	-- Auto sync deck to web server on troop save
	local _origSaveTroops = ClientData.saveTroops
	ClientData.saveTroops = function(...)
		local ret = _origSaveTroops and _origSaveTroops(...)
		pcall(syncPlayerDecksToWeb)
		return ret
	end

	local _origSendTroops = ClientData.sendTroops
	ClientData.sendTroops = function(...)
		pcall(syncPlayerDecksToWeb)
		if _origSendTroops then return _origSendTroops(...) end
	end


	-- On the device the language table is loaded synchronously, so nothing can
	-- ask for a string before it exists. Here the container arrives over the
	-- network and a Str() during boot indexes a nil field -- one error per run,
	-- from ClientData:389. An empty table reads as "no translation yet", which
	-- is what the caller already handles.
	ClientData._language = ClientData._language or {}

	-- The content version normally comes out of the "md5" stamp the hot
	-- updater writes. The web client is always served the current tree, so
	-- there is no stamp and no updater; report the version it was built from.
	ClientData.getVersion = function()
		return JDZC_VERSION or "1.0.0.1089"
	end

	ClientData.getDisplayVersion = function()
		return "1.5.0-h5"
	end

	-- loadUserRegion picks the endpoint per platform, and the web is not one
	-- of the platforms it knows. The page says which server it belongs to, so
	-- apply that after the original has run.
	local loadUserRegion = ClientData.loadUserRegion

	ClientData.loadUserRegion = function(...)
		if loadUserRegion then
			loadUserRegion(...)
		end

		if type(JDZC_REGION) == "table" then
			local region = ClientData._userRegion or {}

			region._id = JDZC_REGION.id or region._id
			region._ip = JDZC_REGION.ip or region._ip
			region._port = JDZC_REGION.port or region._port
			region._name = JDZC_REGION.name or region._name

			ClientData._userRegion = region
		end
	end

	local function announce(name)
		ClientData._lcres[name] = ClientData._lcres[name] or true

		local Data = rawget(_G, "Data")

		if not (Data and Data.Event and lc and lc.Dispatcher) then
			return
		end

		local event = cc.EventCustom:new(Data.Event.resource)

		event:setUserString(name)
		lc.Dispatcher:dispatchEvent(event)
	end

	-- ClientData.addLanguage walks a quoted field until it finds the closing
	-- quote, and never stops if there is not one. The Vietnamese extend.lan
	-- has nine lines that open with a quote they never close (plus CRLF
	-- endings, stripped in js/res.js), and on the web an endless loop wedges
	-- the whole tab. Same parse, but it gives up at the end of the line.
	ClientData.addLanguage = function(text)
		local out = {}
		local lines = string.splitByChar(text, "\n")

		for i = 1, #lines do
			local fields = string.splitByChar(lines[i], ",")
			local value = fields[1]

			if value and string.sub(value, 1, 1) == "\"" then
				local at = 1

				while string.sub(value, -1) ~= "\"" and at < #fields do
					at = at + 1
					value = value .. fields[at]
				end

				if string.sub(value, -1) == "\"" then
					value = string.sub(value, 2, #value - 1)
				end
			end

			out[#out + 1] = value
		end

		ClientData._language = out
	end

	local function addLanguage(text)
		local ok, err = pcall(ClientData.addLanguage, text)

		if not ok then
			print("[h5] addLanguage failed: " .. tostring(err))
		end
	end

	jsres:setCallbacks(announce, addLanguage)

	ClientData.loadLCRes = function(path)
		jsres:load(path)

		return {}
	end

	ClientData.unloadLCRes = function(names)
		if type(names) ~= "table" then
			return
		end

		for _, name in ipairs(names) do
			jsres:unloadContainer(name)

			ClientData._lcres[name] = nil
		end
	end
end

-- cocos2d-html5 widgets can report a nil axis scale even though the native
-- cocos2d-x binding always returns 1.  lcUtils.sw/sh multiply that value when
-- centring card overlays; one nil value otherwise tears down CardBoxScene.
local function patchLcUtils(lcUtils)
	-- lcUtils is a side-effect module and returns no table; its API lives on
	-- the global `lc` namespace.
	local api = type(lc) == "table" and lc or lcUtils
	if type(api) ~= "table" then return end
	local sw, sh, ax, ay = api.sw, api.sh, api.ax, api.ay
	if api.formatJpg then
		local formatJpg = api.formatJpg
		api.formatJpg = function(name)
			if type(name) == "string" then
				name = name:gsub("^res/jpg/", ""):gsub("%.jpg$", ""):gsub("%.jpm$", "")
				return string.format("res/jpg/%s.jpg", name)
			end
			return formatJpg(name)
		end
	end
	if ax then
		api.ax = function(node)
			local ok, value = pcall(ax, node)
			return ok and value ~= nil and value or 0.5
		end
	end
	if ay then
		api.ay = function(node)
			local ok, value = pcall(ay, node)
			return ok and value ~= nil and value or 0.5
		end
	end
	if sw then
		api.sw = function(node, parents)
			local ok, value = pcall(sw, node, parents)
			if ok and value ~= nil then return value end
			local size = node and node.getContentSize and node:getContentSize() or { width = 0 }
			return (size.width or 0) * 1
		end
	end
	if sh then
		api.sh = function(node, parents)
			local ok, value = pcall(sh, node, parents)
			if ok and value ~= nil then return value end
			local size = node and node.getContentSize and node:getContentSize() or { height = 0 }
			return (size.height or 0) * 1
		end
	end
	local animate = api.animate
	if animate then
		-- lc.animate stops at a nil FrameCache lookup on native. Keep that
		-- contract on H5 so optional animation frames terminate the sequence.
		api.animate = function(prefix, delay, loops)
			local out, i = {}, 1
			while true do
				local name = string.format("%s_%02d", prefix, i)
				local frame = lc.FrameCache:getSpriteFrame(name)
				if frame == nil then break end
				out[#out + 1] = name
				i = i + 1
			end
			return out
		end
	end

	-- On H5, JS proxy objects are Lua tables ({__h = handle, __cls = ...}),
	-- so type(action) is "table". Distinguish plain nested action tables
	-- from live Action proxies so actions are not converted to empty spawns.
	api.sequence = function(...)
		local var_91_0 = { ... }
		local var_91_1 = {}
		for iter_91_0 = 1, #var_91_0 do
			local var_91_2 = var_91_0[iter_91_0]
			if type(var_91_2) == "function" then
				var_91_2 = lc.call(var_91_2)
			elseif type(var_91_2) == "number" then
				var_91_2 = lc.delay(var_91_2)
			elseif type(var_91_2) == "table" and rawget(var_91_2, "__h") == nil then
				var_91_2 = lc.spawn(unpack(var_91_2))
			end
			table.insert(var_91_1, var_91_2)
		end
		return cc.Sequence:create(var_91_1)
	end

	api.spawn = function(...)
		local var_92_0 = { ... }
		local var_92_1 = {}
		for iter_92_0 = 1, #var_92_0 do
			local var_92_2 = var_92_0[iter_92_0]
			if type(var_92_2) == "function" then
				var_92_2 = lc.call(var_92_2)
			elseif type(var_92_2) == "number" then
				var_92_2 = lc.delay(var_92_2)
			elseif type(var_92_2) == "table" and rawget(var_92_2, "__h") == nil then
				var_92_2 = lc.sequence(unpack(var_92_2))
			end
			table.insert(var_92_1, var_92_2)
		end
		return cc.Spawn:create(var_92_1)
	end
end

-- extern.lua's native performWithDelay assumes a running scene is already
-- available. H5 starts Lua during the first scene transition, so the initial
-- progress callback can briefly pass nil and otherwise produce a boot error.
local function patchExtern()
	if type(performWithDelay) ~= "function" or rawget(_G, "_h5PerformWithDelay") then
		return
	end

	local native = performWithDelay
	_h5PerformWithDelay = native
	performWithDelay = function(target, callback, delay)
		target = target or (lc.Director and lc.Director:getRunningScene())
		if target then
			return native(target, callback, delay)
		end

		local id
		id = lc.Scheduler:scheduleScriptFunc(function()
			lc.Scheduler:unscheduleScriptEntry(id)
			callback()
		end, delay or 0, false)
		return id
	end
end

-- ---------------------------------------------------------------------------
-- network: luasocket -> WebSocket
--
-- The framing above the socket (4-byte length, LCCrypt rolling serial, CRC16,
-- protobuf SglMsg) is pure Lua and stays exactly as it is; only the transport
-- underneath is replaced.
-- ---------------------------------------------------------------------------

-- Socket_pb is a class table returned by the module, not a global, so the
-- patch takes the module require() just produced.
local function patchSocket(Socket_pb)
	if type(Socket_pb) ~= "table" then
		Socket_pb = rawget(_G, "Socket_pb")
	end

	if type(Socket_pb) ~= "table" then
		print("[h5] Socket_pb patch: no class table")

		return
	end

	-- The original reads luasocket's wall clock in seconds; the heartbeat
	-- timeout is measured against it, and os.clock's CPU time would drift
	-- and hang up a perfectly healthy connection.
	function Socket_pb.getTime()
		return lc.Director:getCurrentTime()
	end

	function Socket_pb.connect(self, host, port)
		if self._isConnected then
			return
		end

		self._host = host or self._host
		self._port = port or self._port
		self._name = tostring(self._host) .. ":" .. tostring(self._port)

		self:_resetRecvBuf()

		self._stream = ""
		self._ws = jsnet:open(self._host, self._port, function(what, payload)
			if what == "open" then
				self:_onConnected()
			elseif what == "data" then
				self:_onData(payload)
			elseif what == "close" then
				if self._isConnected then
					self:_onDisconnect()
				else
					self:_onConnectFail("closed")
				end
			elseif what == "error" then
				if self._isConnected then
					self:_onDisconnect()
				else
					self:_onConnectFail(tostring(payload))
				end
			end
		end)
	end

	-- Same as the original minus the polling loop: there is no socket to
	-- read from, the bytes arrive by themselves.
	function Socket_pb._onConnected(self)
		lc.log("[NETWORK] %s _onConnected", self._name)

		self._isConnected = true

		if self._connectTimeTickScheduler then
			lc.Scheduler:unscheduleScriptEntry(self._connectTimeTickScheduler)

			self._connectTimeTickScheduler = nil
		end

		local event = cc.EventCustom:new(Socket_pb.Event.connect)

		event._socket = self

		lc.Dispatcher:dispatchEvent(event)
		self:_resetRecvBuf()

		self._stream = ""
	end

	-- The framing the polling loop used to do: a 4-byte big-endian length,
	-- then that many bytes of message. A WebSocket frame is not a message,
	-- so whatever arrives is appended to the stream and taken apart here.
	function Socket_pb._onData(self, data)
		self._stream = (self._stream or "") .. data

		while true do
			if self._remainBytes == nil then
				self:_resetRecvBuf()
			end

			local need = self._remainBytes

			if #self._stream < need then
				return
			end

			self._recvBuf = self._recvBuf .. string.sub(self._stream, 1, need)
			self._stream = string.sub(self._stream, need + 1)
			self._remainBytes = 0

			if self._isRecvSize then
				self._isRecvSize = false

				local _, size = string.unpack(self._recvBuf, ">I")

				self._recvBuf = ""
				self._remainBytes = size

				if size == 0 then
					self:_resetRecvBuf()
				end
			else
				self:_processRecvBuf()
			end
		end
	end

	function Socket_pb._send(self, data)
		if self._ws then
			jsbridge.bincall(self._ws, "send", data)
		end

		return #data
	end

	function Socket_pb.close(self)
		lc.log("[NETWORK] %s close", tostring(self._name))

		if self._ws then
			self._ws:close()

			self._ws = nil
		end

		if self._connectTimeTickScheduler then
			lc.Scheduler:unscheduleScriptEntry(self._connectTimeTickScheduler)

			self._connectTimeTickScheduler = nil
		end

		self._isConnected = false
		self._stream = ""
	end

	-- _disconnect shuts the TCP socket down for writing and leaves it to the
	-- read loop to notice. A WebSocket has no half-close and no read loop, so
	-- the connection simply goes.
	function Socket_pb._disconnect(self, isSendEvent)
		assert(isSendEvent ~= nil, "on disconnect isSendEvent can not be nil")

		if not self._isConnected then
			return
		end

		self._isConnected = false

		if self._ws then
			self._ws:close()

			self._ws = nil
		end

		if isSendEvent then
			local event = cc.EventCustom:new(Socket_pb.Event.disconnect)

			event._socket = self

			lc.Dispatcher:dispatchEvent(event)
		end
	end

	function Socket_pb._connect(self)
		return self._ws ~= nil
	end
end

-- ---------------------------------------------------------------------------
-- TravelPanel: ensure chapters are iterated in numeric order 1..10
-- ---------------------------------------------------------------------------

local function patchTravelPanel(TravelPanel)
	if type(TravelPanel) ~= "table" then return end
	TravelPanel.updateChapterList = function(self)
		self._chapterList:removeAllItems()
		self._chapterItems = {}

		local chapters = {}
		for _, info in pairs(Data._chapterInfo) do
			table.insert(chapters, info)
		end
		table.sort(chapters, function(a, b) return a._id < b._id end)

		for i, info in ipairs(chapters) do
			local item = self:createChapterItem(info, #self._chapterItems + 1, cc.size(224, lc.h(self._chapterList)), false)
			self._chapterItems[#self._chapterItems + 1] = item
			self._chapterList:pushBackCustomItem(item)
		end

		self._chapterList:scrollToLeft(0.3, true)
	end
end

-- ---------------------------------------------------------------------------
-- the require hook
-- ---------------------------------------------------------------------------

local function patchBattleUiTouch(mod)
	local BattleUi = _G.BattleUi
	if not BattleUi or not BattleUi.onTouchBegan then return end
	local oldTouchBegan = BattleUi.onTouchBegan
	BattleUi.onTouchBegan = function(self, touch)
		if touch and touch.getId then
			local id = touch:getId()
			if id == nil then
				touch.getId = function() return 0 end
			end
		end
		-- Save the BattleUi-level start location so onTouchMoved's budge
		-- check never relies on touch:getStartLocation().
		if touch then
			local loc = touch:getLocation()
			self._h5TouchStartLoc = cc.p(loc.x, loc.y)
		end
		return oldTouchBegan(self, touch)
	end

	local oldTouchMoved = BattleUi.onTouchMoved
	if oldTouchMoved then
		BattleUi.onTouchMoved = function(self, touch)
			-- The original BattleUiTouch.onTouchMoved uses
			-- touch:getStartLocation() for the budge-limit check.
			-- On H5 this can return (0,0) on reused Touch objects.
			-- Patch getStartLocation on this touch to return our saved value.
			if self._h5TouchStartLoc and touch then
				local origGetStart = touch.getStartLocation
				touch.getStartLocation = function()
					return {x = self._h5TouchStartLoc.x, y = self._h5TouchStartLoc.y}
				end
				local ret = oldTouchMoved(self, touch)
				touch.getStartLocation = origGetStart
				return ret
			end
			return oldTouchMoved(self, touch)
		end
	end

	-- Handle the initiative skill buttons (_btnInitiative and _btnRare2)
	-- so they always open BattleInitiativeSkillsDialog to display monster skills/effects.
	local oldOnButtonEvent = BattleUi.onButtonEvent
	if oldOnButtonEvent then
		BattleUi.onButtonEvent = function(self, btn)
			if btn == self._btnInitiative or btn == self._btnRare or btn == self._btnRare2 then
				if not self._playerUi or not self._playerUi._isController or self._isObserver then
					return true
				end
				if self._isAddingBoardCard then
					self._playerUi:sendEvent(PlayerUi.EventType.dialog_adding_board_card)
					return true
				end

				local mode = (btn == self._btnInitiative) and "BSDGHL" or "R"
				local _, skillList = self._playerUi._player:getBattleCardsByCanCastInitiativeSkill(mode)
				skillList = skillList or {}

				-- If no skills can be cast right now, collect all initiative skills from cards
				-- in those zones so the dialog still displays them for the player to inspect!
				if #skillList == 0 then
					local allCards = self._playerUi._player:getBattleCards(mode)
					for _, c in ipairs(allCards) do
						local skills = c:getInitiativeSkill(Data.SkillMode.initiative_bcs)
							or c:getInitiativeSkill(Data.SkillMode.initiative_grave)
							or c:getInitiativeSkill(Data.SkillMode.initiative_rare)
							or c:getInitiativeSkill(Data.SkillMode.initiative_hand)
							or c:getInitiativeSkill(Data.SkillMode.initiative_leave)
						if skills then
							for _, s in ipairs(skills) do
								table.insert(skillList, s)
							end
						end
					end
				end

				local title = (btn == self._btnInitiative) and Str(STR.INITIATIVE_SKILL) or Str(STR.RARE_INITIATIVE_SKILL)
				local dlg = require("BattleInitiativeSkillsDialog").create(skillList, title, 6)

				dlg:registerItemTouchHandles(function()
					self._isMoved = false
				end, function(touch)
					if cc.pGetDistance(touch:getTouchMovePosition(), touch:getTouchBeganPosition()) > lc.Gesture.BUDGE_LIMIT then
						self._isMoved = true
					end
				end, function(item, sender)
					if dlg._isHiding then return end
					if self._skillArea then
						self._skillArea:removeFromParent()
						self._skillArea = nil
						self._isMoved = false
						return
					end
					if self._isMoved then
						self._isMoved = false
						return
					end
					dlg:hide()
					local skill = item and item._skill
					if skill and skill._owner then
						self._playerUi:castInitiativeSkill(skill._owner, skill)
					end
				end, function(item, sender)
					self:showSkill(item, sender)
				end)
				dlg:show()
				return true
			end
			return oldOnButtonEvent(self, btn)
		end
	end
end

local function patchPlayerUi(PlayerUi)
	local oldUpdateSkills = PlayerUi.updateBoardCardsInitialSkills
	if oldUpdateSkills then
		PlayerUi.updateBoardCardsInitialSkills = function(self)
			oldUpdateSkills(self)
			-- During player's turn, always keep the initiative buttons enabled
			-- so the player can click them to view monster skills and effects.
			if self._isController and self._player == self._player:getActionPlayer() and not self._battleUi._isAuto then
				if self._battleUi._btnInitiative then
					self._battleUi._btnInitiative:setEnabled(true)
				end
				if self._battleUi._btnRare2 then
					self._battleUi._btnRare2:setEnabled(true)
				end
			end
		end
	end
	local oldCalBoardCardPos = PlayerUi.calBoardCardPos
	PlayerUi.calBoardCardPos = function(self, cardSprite)
		if not cardSprite or not cardSprite._card then
			return cc.p(0, 0)
		end

		local ret = oldCalBoardCardPos(self, cardSprite)
		if ret == nil or ret.x == nil or ret.y == nil or ret.x ~= ret.x or ret.y ~= ret.y then
			-- If the card is in a known slot, calculate position directly from its _pos
			local pos = cardSprite._card._pos
			local xs = self._isController and PlayerUi.Pos.attacker_board_x or PlayerUi.Pos.defender_board_x
			local y = self._isController and PlayerUi.Pos.attacker_board_y or PlayerUi.Pos.defender_board_y
			if pos and xs and xs[pos] then
				if cardSprite.isSmall and cardSprite:isSmall() then
					y = y + (self._isController and (pos == 6 and PlayerUi.Pos.board_pos_dy[1] or -PlayerUi.Pos.board_pos_dy[2]) or pos == 6 and -PlayerUi.Pos.board_pos_dy[1] or PlayerUi.Pos.board_pos_dy[2])
				end
				local defaultPos = cc.p(xs[pos], y)
				return defaultPos
			end
			return (cardSprite._default and cardSprite._default._position) or cc.p(cardSprite:getPosition())
		end
		return ret
	end

	local oldCalHandCardPosAndRot = PlayerUi.calHandCardPosAndRot
	if oldCalHandCardPosAndRot then
		PlayerUi.calHandCardPosAndRot = function(self, cardSprite)
			if not cardSprite or not cardSprite._card then
				return cc.p(0, 0), {x = 0, y = 0, z = 0}
			end
			local pos, rot = oldCalHandCardPosAndRot(self, cardSprite)
			if pos == nil or pos.x == nil or pos.y == nil or pos.x ~= pos.x or pos.y ~= pos.y then
				pos = (cardSprite._default and cardSprite._default._position) or cc.p(cardSprite:getPosition())
			end
			return pos, rot
		end
	end
end

local function patchCardSprite(CardSprite)
	local oldInit = CardSprite.init
	if oldInit then
		CardSprite.init = function(self, ...)
			local ret = oldInit(self, ...)
			self.__isCard = true
			-- ponytail: only the CardSprite itself is the upright root;
			-- marking _pCardArea/_pShadowArea as __isCard made each area
			-- project around its own center (shadow at -100,-100) so the
			-- gray shadow stayed at the cursor while the frame drifted right.
			return ret
		end
	end

	CardSprite.runAction = function(self, action)
		local function onActionComplete()
			if not self._card then return end
			if self._touchEvent and (self._touchEvent._status == CardSprite.TouchStatus.grabbed or self._touchEvent._status == CardSprite.TouchStatus.moved) then return end
			-- ponytail: skip repositioning for cards no longer on hand/board
			local cStatus = self._card._status
			if self._status == CardSprite.Status.dead
				or cStatus == BattleData.CardStatus.grave
				or cStatus == BattleData.CardStatus.leave
				or cStatus == BattleData.CardStatus.dead then
				return
			end
			if cStatus == BattleData.CardStatus.hand then
				if self._ownerUi and self._ownerUi.calHandCardPosAndRot then
					local pos, rot = self._ownerUi:calHandCardPosAndRot(self)
					if pos and pos.x and pos.y then
						self:setPosition(pos)
					end
					if rot then
						self:setRotation3D(rot)
					end
				end
			elseif cStatus == BattleData.CardStatus.board then
				if self._ownerUi and self._ownerUi.getBoardCardSprite then
					local bSprite = self._ownerUi:getBoardCardSprite(self._card)
					if bSprite ~= nil then
						local pos = self._ownerUi:calBoardCardPos(self)
						if pos and pos.x and pos.y then
							self:setPosition(pos)
						end
					end
				end
			end
		end

		if action and action._dontFixPos then
			cc.Node.runAction(self, action)
		else
			cc.Node.runAction(self, lc.sequence(action, lc.call(onActionComplete)))
		end
	end

	local oldPlayBoardToGrave = CardSprite.playBoardToGrave
	if oldPlayBoardToGrave then
		CardSprite.playBoardToGrave = function(self, delay)
			local ownerUi = self._ownerUi
			self:updateActive(false)
			local act = lc.sequence(lc.delay(delay), lc.call(function()
				self:updateZOrder(true)
				if ownerUi and ownerUi.efcCardDie then
					ownerUi:efcCardDie(self)
				end
			end), lc.delay(0.4), lc.call(function()
				if ownerUi and ownerUi.addGraveCard then
					ownerUi:addGraveCard(self)
				end
				self:updateZOrder()
			end))
			act._dontFixPos = true
			self:runAction(act)
			return delay + 0.5
		end
	end

	-- Match native APK drag behavior:
	-- Hand cards follow the cursor 1:1 with startPos + delta.
	-- Board cards NEVER move on drag (only the attack arrow directs).
	local oldTouchBegan = CardSprite.onTouchBegan
	CardSprite.onTouchBegan = function(self, touch)
		if self._card and self._card._status == BattleData.CardStatus.board then
			self._touchEvent._status = CardSprite.TouchStatus.ungrabbed
			self._touchEvent._touchCardType = CardSprite.TouchCardType.board_card
		end

		-- Capture the card's screen centre BEFORE oldTouchBegan runs:
		-- native grabs _startPos before showLargePic too (CardSprite.lua
		-- 2904 before 2906). showLargePic teleports the card to the preview
		-- slot (SCR_CW-300, 380) synchronously, so reading the position
		-- after it makes every drag frame offset by exactly the preview
		-- displacement -- the card trails the cursor and lands shifted.
		if touch and self._touchEvent then
			pcall(function()
				self._touchEvent._h5StartScreen = self:convertToWorldSpace3D(cc.p(0, 0))
			end)
		end

		oldTouchBegan(self, touch)

		if touch and self._touchEvent then
			local loc = touch:getLocation()
			self._touchEvent._touchStartLoc = cc.p(loc.x, loc.y)
		end
	end

	-- Full reproduction of native CardSprite.onTouchMoved:
	CardSprite.onTouchMoved = function(self, touch)
		local oldStatus = self._touchEvent._status

		if oldStatus == nil or oldStatus == CardSprite.TouchStatus.ungrabbed then
			return
		end

		self._touchEvent._status = CardSprite.TouchStatus.moved

		local startLoc = self._touchEvent._touchStartLoc or touch:getStartLocation()
		local curLoc = touch:getLocation()

		if oldStatus == CardSprite.TouchStatus.grabbed then
			if cc.pGetDistance(curLoc, startLoc) <= lc.Gesture.BUDGE_LIMIT then
				self._touchEvent._status = oldStatus
			else
				self._touchEvent._isTapped = false
				self._touchEvent._isLongPressed = false
				pcall(function() if self._pCardArea then self._pCardArea:stopAllActions() end end)

				if self._touchEvent._touchCardType == CardSprite.TouchCardType.self_hand_card then
					self:hideLargePic()
				elseif self._touchEvent._touchCardType == CardSprite.TouchCardType.board_card then
					self:sendEvent(CardSprite.EventType.hide_card_info)
				end
			end
		elseif oldStatus == CardSprite.TouchStatus.moved then
			self._touchEvent._focusTimes = 0

			if self._touchEvent._touchCardType == CardSprite.TouchCardType.self_hand_card then
				-- native keeps the enlarged preview (Status.large) up for the
				-- whole drag -- the card follows the cursor at full size and
				-- hideLargePic only runs on touch end. Hiding it here made the
				-- H5 drag shrink the card to hand scale, unlike the APK.
				pcall(function() if self._pCardArea then self._pCardArea:stopAllActions() self._pCardArea:setPosition(0,0) end end)

				local didPlace = false
				pcall(function()
					local s0 = self._touchEvent._h5StartScreen
					if not s0 or not s0.x then
						s0=self:convertToWorldSpace3D(cc.p(0, 0))
						self._touchEvent._h5StartScreen = s0
					end
					local sx = s0.x + (curLoc.x - startLoc.x)
					local sy = s0.y + (curLoc.y - startLoc.y)
					if self.setPositionFromScreen3D then
						self:setPositionFromScreen3D(sx, sy)
					else
						self:setPosition(self:convertToNodeSpace3D(cc.p(sx, sy)))
					end
					didPlace = true
				end)
				if not didPlace then
					self:setPosition(cc.p(
						self._touchEvent._startPos.x + curLoc.x - startLoc.x,
						self._touchEvent._startPos.y + curLoc.y - startLoc.y))
				end

				local prevLoc = touch:getPreviousLocation()
				self:handCardMove(2, curLoc.x - prevLoc.x, curLoc.y - prevLoc.y)

			elseif self._touchEvent._touchCardType == CardSprite.TouchCardType.board_card then
				-- Native APK: empty block (board cards NEVER move when dragged)
			end
		end
	end

	local oldTouchEnded = CardSprite.onTouchEnded
	CardSprite.onTouchEnded = function(self, touch)
		if self._status == CardSprite.Status.large or self._status == CardSprite.Status.info or self._pInfoArea then
			self:hideLargePic()
		end
		if oldTouchEnded then
			oldTouchEnded(self, touch)
		end
	end

	local oldTouchCanceled = CardSprite.onTouchCanceled
	CardSprite.onTouchCanceled = function(self)
		if self._status == CardSprite.Status.large or self._status == CardSprite.Status.info or self._pInfoArea then
			self:hideLargePic()
		end
		if oldTouchCanceled then
			oldTouchCanceled(self)
		end
	end

	local oldHideLargePic = CardSprite.hideLargePic
	CardSprite.hideLargePic = function(self, ...)
		local ret
		if oldHideLargePic then ret = oldHideLargePic(self, ...) end
		-- ponytail: native hideLargePic does not reset _pShadowArea; if drag
		-- was interrupted by a summon (no onTouchEnded), the shadow offset
		-- (-100,-100 + drift) persists into board/grave and keeps the card
		-- shifted right. Reset here so every exit from large/info is clean.
		if self._pShadowArea then
			pcall(function()
				self._pShadowArea:setPosition(0, 0)
				self._pShadowArea:setRotation3D({x=0,y=0,z=0})
				self._pShadowArea:setScale(1)
			end)
		end
		if self._pCardArea then
			pcall(function()
				self._pCardArea:setPosition(0, 0)
				self._pCardArea:setRotation3D({x=0,y=0,z=0})
				self._pCardArea:stopAllActions()
			end)
		end
		return ret
	end

	local oldInitCard = CardSprite.initCard
	if oldInitCard then
		CardSprite.initCard = function(self, ...)
				local ret = oldInitCard(self, ...)
			pcall(function()
				if self._pCardArea then self._pCardArea:setPosition(0,0) self._pCardArea:setRotation3D({x=0,y=0,z=0}) self._pCardArea:stopAllActions() end
				if self._pShadowArea then self._pShadowArea:setPosition(0,0) self._pShadowArea:setRotation3D({x=0,y=0,z=0}) self._pShadowArea:setScale(1) end
			end)
			return ret
		end
	end
end
-- ---------------------------------------------------------------------------
-- BaseForm: the web widget stack rebuilds every widget's position from a
-- percent bookkeeping that goes stale (see engine.js transform sync), which
-- used to drag whole forms into the bottom-left corner. The fix lives in
-- engine.js (sync at transform time); nothing to patch on this side.
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- BattleUi: the recovered build's result screen sends PB_TYPE_BATTLE_AGAIN
-- for "play again" but carries no handler for the reply, so the WAITING
-- overlay it raises never leaves. A client-simulated battle (no relayed
-- opponent) can simply replay locally with a fresh seed; a relayed PvP duel
-- has nothing to rejoin this way, so drop the overlay and leave instead of
-- hanging forever.
-- ---------------------------------------------------------------------------
local function patchBattleUi(BattleUi)
	if not BattleUi or not BattleUi.retry then return end
	local oldRetry = BattleUi.retry
	BattleUi.retry = function(self)
		local input = self._input
		if input ~= nil and input._isOppoOnline == false
				and input._randomSeed ~= nil and _G.PlayerBattle ~= nil then
			local seed = math.random(1, 65535)
			input._randomSeed = seed
			_G.PlayerBattle._originRandomSeed = seed
			return self:replay()
		end
		local ret = oldRetry(self)
		if input ~= nil and input._isOppoOnline ~= false then
			local indicator = ClientView.getActiveIndicator()
			if indicator and indicator.hide then indicator:hide() end
			pcall(function() self:tryExitScene() end)
		end
		return ret
	end
end

local patches = {
	Data = patchData,
	ClientData = patchClientData,
	Socket_pb = patchSocket,
	extern = patchExtern,
	lcUtils = patchLcUtils,
	TravelPanel = patchTravelPanel,
	BattleUiTouch = patchBattleUiTouch,
	CardSprite = patchCardSprite,
	PlayerUi = patchPlayerUi,
	BattleUi = patchBattleUi,
}

-- h5_boot calls this once more after main.lua because lcUtils is a
-- side-effect module and may be loaded before the require hook can observe
-- its returned value.
M.patchLcUtils = patchLcUtils

local baseRequire = require
local reported = false

-- The game boots inside its own xpcall, whose handler needs ClientData to
-- report anything; a failure earlier than that would vanish. Report here
-- instead, where the failing module is still known.
function _G.require(name, ...)
	local args = { ... }

	local ok, module = xpcall(function()
		return baseRequire(name, unpack(args))
	end, function(e)
		return debug.traceback(tostring(e), 2)
	end)

	if not ok then
		-- only the innermost failure is interesting; the outer requires
		-- would each re-report the same traceback on the way up
		if not reported then
			reported = true

			print("[h5] require " .. tostring(name) .. " failed: " .. tostring(module))
		end

		error(module, 0)
	end

	local patch = patches[name]

	if patch then
		local ok, err = pcall(patch, module)

		if not ok then
			print("[h5] patch " .. tostring(name) .. " failed: " .. tostring(err))
		end
	end

	return module
end

return M
