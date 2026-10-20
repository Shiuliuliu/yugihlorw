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

-- Early parse of preloaded language so _G._cachedLanguage is ready BEFORE any module calls Str()
pcall(function()
	local addFn = function(text)
		if not text or text == "" then return end
		local out = {}
		local lines = string.splitByChar(text, "\n")
		for i = 1, #lines do
			local line = lines[i]
			if line and string.sub(line, -1) == "\r" then
				line = string.sub(line, 1, #line - 1)
			end
			local value = line
			if value and string.sub(value, 1, 1) == "\"" then
				local fields = string.splitByChar(line, ",")
				value = fields[1]
				local at = 1
				while string.sub(value, -1) ~= "\"" and at < #fields do
					at = at + 1
					value = value .. "," .. fields[at]
				end
				if string.sub(value, -1) == "\"" then
					value = string.sub(value, 2, #value - 1)
				end
			end
			if value and string.find(value, "\\n") then
				value = string.gsub(value, "\\n", "\n")
			end
			out[#out + 1] = value
		end
		_G._cachedLanguage = out
		if rawget(_G, "ClientData") and type(ClientData) == "table" then
			ClientData._language = out
		end
	end
	if jsres and jsres.setCallbacks then
		jsres:setCallbacks(function() end, addFn)
	end
end)


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
		local wsHost = config.wsHost or host or "127.0.0.1"
		local wsPort = config.wsPort or port or 9192
		if wsHost == "124.222.242.186" then wsHost = "127.0.0.1" end
		if wsPort == 8182 then wsPort = 9192 end

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

		-- Preload teach YGO info so TeachingForm has all 57 levels ready
	local teachDump = jsres:dump("teach_dumps.json")
	if teachDump then
		local ok, parsed = pcall(function() return require("json").decode(teachDump) end)
		if ok and parsed then
			Data._teachYgoInfo = Data._teachYgoInfo or {}
			for k, v in pairs(parsed) do
				Data._teachYgoInfo[tonumber(k)] = v
			end
		end
	end

	local origParseTeach = Data.parseTeach
	Data.parseTeach = function(name, buf)
		if type(name) == "string" and string.hasSuffix(name, ".bin") then
			local id = tonumber(string.sub(name, 1, -5))
			if id and Data._teachYgoInfo and Data._teachYgoInfo[id] then
				return
			end
		end
		if origParseTeach then return origParseTeach(name, buf) end
	end

	Data.parseData = function(name, buf)
		current = tostring(name)

		if JDZC_TRACE then
			print("[h5] parse " .. current)
		end

		local a, b, c = parseData(name, buf)

		if current == "skill.bin" and Data._skillInfo then
			if Data._skillInfo[14655] then
				Data._skillInfo[14655]._modes = { [1] = 2, [2] = 9 }
			end
			if Data._skillInfo[14658] then
				Data._skillInfo[14658]._modes = { [1] = 2, [2] = 9 }
			end
			if Data._skillInfo[14673] then
				Data._skillInfo[14673]._isIgnoreDefend = 8
				Data._skillInfo[14673]._removeMode = { [1] = 42 }
			end
			if Data._skillInfo[14743] then
				Data._skillInfo[14743]._modes = { [1] = 61, [2] = 2 }
				Data._skillInfo[14743]._isIgnoreDefend = 1
			end
			if Data._skillInfo[14749] then
				Data._skillInfo[14749]._modes = { [1] = 61, [2] = 2 }
				Data._skillInfo[14749]._isIgnoreDefend = 0
			end
			if Data._skillInfo[14750] then
				Data._skillInfo[14750]._nameSid = 57220
				Data._skillInfo[14750]._descSid = 57221
			end
			if Data._rareInfo and Data._rareInfo[40737] then
				Data._rareInfo[40737]._skillId = { 3454, 12002, 12003, 12004, 7488, 14754 }
			end
			if Data._rareInfo and Data._rareInfo[40738] then
				Data._rareInfo[40738]._nameSid = 57222
				Data._rareInfo[40738]._descSid = 57223
				Data._rareInfo[40738]._briefNameSid = 57224
			end
			if Data._skillInfo and Data._skillInfo[14763] then
				Data._skillInfo[14763]._nameSid = 57225
				Data._skillInfo[14763]._descSid = 57226
			end
			if Data._skillInfo and Data._skillInfo[14677] then
				Data._skillInfo[14677]._nameSid = 56946
				Data._skillInfo[14677]._descSid = 56947
			end
			if Data._rareInfo and Data._rareInfo[40739] then
				Data._rareInfo[40739]._quality = 5
				Data._rareInfo[40739]._nameSid = 57227
				Data._rareInfo[40739]._descSid = 57228
				Data._rareInfo[40739]._briefNameSid = 57229
				Data._rareInfo[40739]._skillId = { 14677, 3106, 12002, 12003, 12004, 14764 }
			end
			if Data._skillInfo and Data._skillInfo[14764] then
				Data._skillInfo[14764]._nameSid = 57230
				Data._skillInfo[14764]._descSid = 57231
			end
			if Data._rareInfo and Data._rareInfo[40740] then
				Data._rareInfo[40740]._quality = 4
				Data._rareInfo[40740]._nameSid = 57232
				Data._rareInfo[40740]._descSid = 57233
				Data._rareInfo[40740]._briefNameSid = 57234
			end
			if Data._skillInfo and Data._skillInfo[14765] then
				Data._skillInfo[14765]._nameSid = 57235
				Data._skillInfo[14765]._descSid = 57236
			end
			if Data._skillInfo and Data._skillInfo[14766] then
				Data._skillInfo[14766]._nameSid = 57237
				Data._skillInfo[14766]._descSid = 57238
			end
			if Data._monsterInfo and Data._monsterInfo[12335] then
				Data._monsterInfo[12335]._quality = 4
				Data._monsterInfo[12335]._nameSid = 57239
				Data._monsterInfo[12335]._descSid = 57240
				Data._monsterInfo[12335]._briefNameSid = 57241
			end
			if Data._rareInfo and Data._rareInfo[40741] then
				Data._rareInfo[40741]._quality = 4
				Data._rareInfo[40741]._nameSid = 57246
				Data._rareInfo[40741]._descSid = 57247
				Data._rareInfo[40741]._briefNameSid = 57248
			end
			if Data._skillInfo and Data._skillInfo[14767] then
				Data._skillInfo[14767]._nameSid = 57242
				Data._skillInfo[14767]._descSid = 57243
			end
			if Data._skillInfo and Data._skillInfo[14768] then
				Data._skillInfo[14768]._nameSid = 57244
				Data._skillInfo[14768]._descSid = 57245
			end
			if Data._skillInfo and Data._skillInfo[14769] then
				Data._skillInfo[14769]._nameSid = 57249
				Data._skillInfo[14769]._descSid = 57250
			end
			if Data._skillInfo and Data._skillInfo[14770] then
				Data._skillInfo[14770]._nameSid = 57251
				Data._skillInfo[14770]._descSid = 57252
			end
			if Data._skillInfo and Data._skillInfo[14772] then
				Data._skillInfo[14772]._nameSid = 57258
				Data._skillInfo[14772]._descSid = 57259
			end
			if Data._rareInfo and Data._rareInfo[40742] then
				Data._rareInfo[40742]._quality = 4
				Data._rareInfo[40742]._keyword = 6
				Data._rareInfo[40742]._joinComponent = { 10084, 3006 }
				Data._rareInfo[40742]._nameSid = 57260
				Data._rareInfo[40742]._descSid = 57261
				Data._rareInfo[40742]._briefNameSid = 57262
			end
			if Data._skillInfo and Data._skillInfo[14773] then
				Data._skillInfo[14773]._nameSid = 57263
				Data._skillInfo[14773]._descSid = 57264
			end
			if Data._skillInfo and Data._skillInfo[14774] then
				Data._skillInfo[14774]._nameSid = 57265
				Data._skillInfo[14774]._descSid = 57266
			end
			if Data._rareInfo and Data._rareInfo[40743] then
				Data._rareInfo[40743]._quality = 4
				Data._rareInfo[40743]._keyword = 21
				Data._rareInfo[40743]._joinComponent = { 5008, 6008 }
				Data._rareInfo[40743]._syncComponent = { { 0 }, { 10058 } }
				Data._rareInfo[40743]._nameSid = 57267
				Data._rareInfo[40743]._descSid = 57268
				Data._rareInfo[40743]._briefNameSid = 57269
			end
			if Data._skillInfo and Data._skillInfo[14775] then
				Data._skillInfo[14775]._nameSid = 57270
				Data._skillInfo[14775]._descSid = 57271
			end
			if Data._skillInfo and Data._skillInfo[14776] then
				Data._skillInfo[14776]._nameSid = 57272
				Data._skillInfo[14776]._descSid = 57273
			end
			if Data._skillInfo and Data._skillInfo[14777] then
				Data._skillInfo[14777]._nameSid = 57274
				Data._skillInfo[14777]._descSid = 57275
			end
		end

		current = nil

		return a, b, c
	end
end

-- ---------------------------------------------------------------------------
-- resources: containers load in JS, entries arrive as events
-- ---------------------------------------------------------------------------

local function normalizeTroopData(troop)
	if not troop or type(troop) ~= "table" then return troop end
	local counts, order = {}, {}
	for _, item in ipairs(troop) do
		local cid = tonumber(type(item) == "table" and (item._infoId or item.info_id) or item)
		local num = tonumber(type(item) == "table" and (item._num or item.num) or 1) or 1
		if cid and cid > 0 then
			if not counts[cid] then
				counts[cid] = 0
				table.insert(order, cid)
			end
			counts[cid] = counts[cid] + num
		end
	end
	local res = {}
	for _, cid in ipairs(order) do
		table.insert(res, { _infoId = cid, _num = counts[cid] })
	end
	if troop._isDirty then res._isDirty = true end
	return res
end

-- SYNC_DECK_TO_WEB: Save deck changes directly to MySQL via jdzcApi:saveDeck
local _lastSyncTime = 0
local _savedDeckHashes = {}
local function syncPlayerDecksToWeb()
	local now = os.time()
	if now - _lastSyncTime < 2 then return end
	_lastSyncTime = now
	if not P then return end
	local accId = ClientData._account and ClientData._account.id or 1
	local api = jsbridge and jsbridge.object("jdzcApi")
	if not (api and api.saveDeck) then return end

	local jsonMod = require("json")
	local curSlot = (P and P._curTroopIndex) or 1
	for slot = 1, 10 do
		local cloneTroop = ClientData and ClientData._cloneTroops and ClientData._cloneTroops[slot]
		local pTroop = P._playerCard and P._playerCard._troops and P._playerCard._troops[slot]
		local troop = (cloneTroop and #cloneTroop > 0 and cloneTroop) or pTroop
		if troop and #troop > 0 then
			local BANNED_CARD_IDS = { [40657] = true, [40693] = true, [40694] = true }
			local cards = {}
			local extra = {}
			for _, item in ipairs(troop) do
				local cid = type(item) == "table" and (item._infoId or item.info_id) or item
				cid = tonumber(cid)
				local count = type(item) == "table" and (tonumber(item._num) or tonumber(item.num)) or 1
				if cid and cid > 0 and not BANNED_CARD_IDS[cid] then
					local ctype = Data.getType(cid)
					for cIdx = 1, count do
						if ctype == Data.CardType.rare then
							table.insert(extra, cid)
						else
							table.insert(cards, cid)
						end
					end
				end
			end
			local cStr = jsonMod.encode(cards)
			local eStr = jsonMod.encode(extra)
			local deckName = (P and P._troopRemarks and P._troopRemarks[slot] and P._troopRemarks[slot] ~= "") and P._troopRemarks[slot] or ("Bộ Bài " .. tostring(slot))
			local isActive = (slot == curSlot and 1 or 0)
			local deckHash = deckName .. "|" .. cStr .. "|" .. eStr .. "|" .. tostring(isActive)
			if _savedDeckHashes[slot] ~= deckHash then
				_savedDeckHashes[slot] = deckHash
				api:saveDeck(accId, slot, deckName, cStr, eStr, isActive)
			end
		end
	end
	if api and api.post and accId and curSlot then
		pcall(function()
			api:post("set_cur_troop", { account_id = accId, cur_troop = curSlot }, function() end)
		end)
	end
end

-- Ensure player has all PVE bonus and world structures initialized
local function ensurePlayerPveData()
	if not P then return end
	if not P._curTroopIndex or P._curTroopIndex == 0 then
		P._curTroopIndex = 1
	end
	if not P._playerWorld then
		local ok, mod = pcall(require, "PlayerWorld")
		if ok and mod then P._playerWorld = mod.new() end
	end
	if P._playerWorld then
		if not P._playerWorld._curLevel or #P._playerWorld._curLevel == 0 then
			P._playerWorld._curLevel = { 10101, 20101, 30101 }
		end
	end
	if P._playerBonus then
		P._playerBonus._bonusTeach = P._playerBonus._bonusTeach or {}
		if Data and Data._teachInfo then
			for id, info in pairs(Data._teachInfo) do
				if not P._playerBonus._bonusTeach[info._bonusId] then
					local bOk, bMod = pcall(require, "Bonus")
					if bOk and bMod then
						P._playerBonus._bonusTeach[info._bonusId] = bMod.new(info._bonusId)
					else
						P._playerBonus._bonusTeach[info._bonusId] = {
							_infoId = info._bonusId,
							_info = Data._bonusInfo and Data._bonusInfo[info._bonusId] or { _val = 1, _type = Data.BonusType.teach },
							_value = 0,
							_isClaimed = false,
							canClaim = function(s) return s._value >= s._info._val end
						}
					end
				end
			end
		end
	end
	if P._playerExpedition then
		if not P._playerExpedition._chapter or P._playerExpedition._chapter == 0 then
			P._playerExpedition._chapter = 1
		end
		P._playerExpedition._chests = P._playerExpedition._chests or {}
	end
end

function patchClientData()
	ClientData.pollChatHistory = function()
		pcall(function() if _G.flushPendingChatQueue then _G.flushPendingChatQueue() end end)
		pcall(function()
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.loadChatHistory then
				api:loadChatHistory()
			end
		end)
	end
	_G.pollChatHistory = ClientData.pollChatHistory
	ClientData._isWorking = true

	-- DECK REMARK / RENAME SUPPORT (Task 2)
	ClientData.sendTroopRemark = function(slot, name)
		slot = tonumber(slot) or 1
		name = tostring(name or "")
		if P then
			P._troopRemarks = P._troopRemarks or {}
			P._troopRemarks[slot] = name
		end
		lc.UserDefault:setStringForKey("troop_remark_" .. tostring(slot), name)
		lc.UserDefault:flush()

		local accId = tonumber((ClientData._account and ClientData._account.id) or (P and P._id) or 1)
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			local jsonMod = require("json")
			local payload = jsonMod.encode({ account_id = accId, deck_slot = slot, deck_name = name })
			api:post("save_deck_name", payload, function(resp) end)
		end

		local cb = ClientView.getActiveIndicator():hide()
		if cb and type(cb) == "function" then
			cb()
		end

		local runningScene = lc._runningScene
		if runningScene and runningScene.updateTroopTitle then
			runningScene:updateTroopTitle()
		end

		ToastManager.push("Đã đổi tên bộ bài thành công!")
	end

	local _origGetTroopName = ClientData.getTroopName
	ClientData.getTroopName = function(slot, withNumber)
		slot = tonumber(slot) or 1
		local remark = P and P._troopRemarks and P._troopRemarks[slot]
		if withNumber then
			local rName = (remark and remark ~= "") and remark or Str(STR.REMARK_NONE)
			return string.format("%s %d\n|%s|", Str(STR.TROOP), slot, rName)
		else
			if remark and remark ~= "" then
				return remark
			else
				return string.format("%s %d", Str(STR.TROOP), slot)
			end
		end
	end

	-- Arena / Clash / Ladder sync for Web H5
	ClientData.sendClashSync = function()
		if not ClientData._cachedLeaderboard or #ClientData._cachedLeaderboard == 0 then
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.post then
				api:post("leaderboard", {}, function(rawRes)
					local res = rawRes
					if type(res) == "string" then
						local ok, parsed = pcall(function() return require("json").decode(res) end)
						if ok and parsed then res = parsed end
					end
					if res and res.ranks then
						ClientData._cachedLeaderboard = res.ranks
					end
				end)
			end
		end
		if P and P._playerFindClash then
			P._playerFindClash._isSyncData = true
			P._playerFindClash._endTime = (ClientData.getCurrentTime() or os.time()) + 86400 * 30
			if P._playerFindClashEx then
				P._playerFindClashEx._endTime = (ClientData.getCurrentTime() or os.time()) + 86400 * 30
				P._playerFindClashEx._trophy = P._playerFindClashEx._trophy or 1000
			end
			P._playerFindClash._preRank = P._playerFindClash._preRank or 0
			P._playerFindClash._preTrophy = P._playerFindClash._preTrophy or 0
			if not P._playerFindClash._trophy then
				P._playerFindClash._trophy = (P and P._trophy) or (ClientData._account and ClientData._account.trophy) or 800
			end
			P._playerFindClash._grade = P._playerFindClash:getGrade(P._playerFindClash._trophy)
			P._playerFindClash._period = {0, 24}
			P._playerFindClash._isFirst = false
			P._playerFindClash._ladderTrophy = P._playerFindClash._ladderTrophy or 0
			P._playerFindClash._clashId = P._id or 1

			if P._playerRank then
				local ladderStage = (Data and Data._globalInfo and Data._globalInfo._ladderStage) or {}
				for stageIdx = 0, #ladderStage + 1 do
					pcall(function()
						P._playerRank:parseRankData(nil, SglMsgType_pb.PB_TYPE_RANK_PRE, stageIdx)
					end)
				end
			end

			pcall(function() P._playerFindClash:syncChests() end)
		end

		lc.sendEvent(Data.Event.clash_sync_ready)

		local curScene = lc._runningScene or ClientView._scene
		if curScene and curScene.setTabIndicators then
			pcall(function() curScene:setTabIndicators(false) end)
		end
		local ind = ClientView.getActiveIndicator()
		if ind and ind.hide then ind:hide() end
	end

	-- Safe stubs for Arena auxiliary requests
	local function makeProtobufCompatible(tbl)
		if type(tbl) ~= "table" then return tbl end
		rawset(tbl, "HasField", function(self, name)
			return rawget(self, name) ~= nil
		end)
		for k, v in pairs(tbl) do
			if type(v) == "table" and type(k) ~= "function" then
				makeProtobufCompatible(v)
			end
		end
		return tbl
	end

	-- Safe stubs for Arena auxiliary requests & Leaderboard
	ClientData.sendRankRequest = function(rankType, subType)
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("leaderboard", { type = rankType, subType = subType, account_id = (P and P._id) or 0 }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.ranks then
					ClientData._cachedLeaderboard = res.ranks
				end
				local isUnionRank = (rankType == SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY or rankType == SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL)
				local rankList = {}
				local myId = (P and P._id) or 0
				local selfInList = false
				local selfEntry = nil

				if isUnionRank then
					if res and res.ranks then
						for i, r in ipairs(res.ranks) do
							local uInfo = {
								id = r.id or i,
								name = r.name or "Công Hội",
								level = r.level or 1,
								avatar = r.avatar or 1,
								tag = r.tag or "",
								member = r.member or 1,
								max_member = r.max_member or 20,
								required_level = r.required_level or 1,
								type = r.type or 1,
								gold = r.gold or 0,
								wood = r.wood or 0,
								announcement = r.announcement or ""
							}
							table.insert(rankList, {
								rank = r.rank or i,
								value = r.value or r.total_trophy or r.level or 1,
								union_info = uInfo
							})
							if P and P._unionId and r.id == P._unionId then
								selfInList = true
							end
						end
					end
					local myUnion = P and P._playerUnion and P._playerUnion:getMyUnion()
					local sr = (res and res.self_rank) or {}
					local s_uInfo = {
						id = (myUnion and myUnion._id) or sr.id or (P and P._unionId) or 0,
						name = (myUnion and myUnion._name) or sr.name or "",
						level = (myUnion and myUnion._level) or sr.level or 1,
						avatar = (myUnion and myUnion._badge) or sr.avatar or 1,
						tag = (myUnion and myUnion._word) or sr.tag or "",
						member = (myUnion and myUnion._memberNum) or sr.member or (P and P:hasUnion() and 1 or 0),
						max_member = (myUnion and myUnion._memberCapacity) or sr.max_member or 20,
						required_level = (myUnion and myUnion._reqLevel) or sr.required_level or 1,
						type = (myUnion and myUnion._joinType) or sr.type or 1,
						gold = (myUnion and myUnion._gold) or sr.gold or 0,
						wood = (myUnion and myUnion._wood) or sr.wood or 0,
						announcement = (myUnion and myUnion._announce) or sr.announcement or ""
					}
					selfEntry = {
						rank = sr.rank or (P and P:hasUnion() and 1 or 999),
						value = sr.value or (myUnion and (rankType == SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL and myUnion._level or 800)) or 0,
						union_info = s_uInfo
					}
					if not selfInList and P and P:hasUnion() and selfEntry.union_info.id > 0 then
						table.insert(rankList, selfEntry)
					end
				else
					if res and res.ranks then
						for i, r in ipairs(res.ranks) do
							local crownObj = nil
							local r_gc = tonumber(r.gold_cup) or 0
							local r_sc = tonumber(r.silver_cup) or 0
							local r_bc = tonumber(r.bronze_cup) or 0
							if r_gc > 0 then crownObj = { info_id = 7204, num = r_gc }
							elseif r_sc > 0 then crownObj = { info_id = 7205, num = r_sc }
							elseif r_bc > 0 then crownObj = { info_id = 7206, num = r_bc }
							end
							local uInfo = {
								id = r.id or i,
								name = r.name or "Duelist",
								level = r.level or 1,
								avatar = r.avatar or 201,
								trophy = r.trophy or 800,
								gold = r.gold or 100000,
								grain = 0,
								ingot = 1000,
								exp = r.exp or 0,
								vip = r.vip or 0,
								shield = 0,
								union_id = 0,
								union_name = "",
								union_title = 0,
								union_avatar = 0,
								union_tag = "",
								last_login = 0,
								rid = 1,
								privilege = 0,
								month_card = 0
							}
							if crownObj then uInfo.crown = crownObj end
							local val = r.value or r.trophy or 800
							if rankType == SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL then
								val = r.value or r.level or 1
							end
							table.insert(rankList, {
								rank = r.rank or i,
								value = val,
								user_info = uInfo
							})
							if r.id == myId then
								selfInList = true
							end
						end
					end

					local sr = (res and res.self_rank) or {}
					local myRankNum = sr.rank or 999
					local myVal = sr.value or sr.trophy or (P and P._playerFindClash and P._playerFindClash._trophy) or (P and P._trophy) or 800
					if rankType == SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL then
						myVal = sr.value or sr.level or (P and P:getMaxCharacterLevel()) or (P and P._level) or 1
					end
					local myGc = tonumber(sr.gold_cup or (P and P._goldCup) or 0) or 0
					local mySc = tonumber(sr.silver_cup or (P and P._silverCup) or 0) or 0
					local myBc = tonumber(sr.bronze_cup or (P and P._bronzeCup) or 0) or 0
					local myCrown = nil
					if myGc > 0 then myCrown = { info_id = 7204, num = myGc }
					elseif mySc > 0 then myCrown = { info_id = 7205, num = mySc }
					elseif myBc > 0 then myCrown = { info_id = 7206, num = myBc }
					end
					local myUInfo = {
						id = myId,
						name = (P and P._name) or sr.name or "Duelist",
						level = (P and P._level) or sr.level or 1,
						avatar = (P and P._avatar) or sr.avatar or 201,
						trophy = (P and P._trophy) or sr.trophy or 800,
						gold = (P and P._gold) or 100000,
						grain = 0,
						ingot = 1000,
						exp = (P and P._exp) or 0,
						vip = (P and P._vip) or 0,
						shield = 0,
						union_id = 0,
						union_name = "",
						union_title = 0,
						union_avatar = 0,
						union_tag = "",
						last_login = 0,
						rid = 1,
						privilege = 0,
						month_card = 0
					}
					if myCrown then myUInfo.crown = myCrown end

					selfEntry = {
						rank = myRankNum,
						value = myVal,
						user_info = myUInfo
					}

					if not selfInList and myId > 0 then
						table.insert(rankList, selfEntry)
					end
				end

				local rankMsg = {
					season = 1,
					data = rankList,
					self_rank = selfEntry,
					end_time = (ClientData.getCurrentTime() + 315360000) * 1000,
					user_id = myId
				}
				makeProtobufCompatible(rankMsg)
				if P and P._playerRank then
					P._playerRank:parseRankData(rankMsg, rankType or SglMsgType_pb.PB_TYPE_RANK_LADDER, subType)
				end

				if P and P._playerRank then
					local ranksObj = P._playerRank:getRanks(rankType or SglMsgType_pb.PB_TYPE_RANK_LADDER, subType)
					if ranksObj then
						if not ranksObj._selfRank and selfEntry then
							local rankCls = require("Rank")
							local sRankObj = rankCls.new()
							sRankObj:set(selfEntry, rankType or SglMsgType_pb.PB_TYPE_RANK_LADDER, subType)
							ranksObj._selfRank = sRankObj
						elseif ranksObj._selfRank and selfEntry then
							if selfEntry.rank then ranksObj._selfRank._rank = selfEntry.rank end
							if selfEntry.value then ranksObj._selfRank._value = selfEntry.value end
						end
					end
				end
				-- Notify RankForm directly and hide indicator
				local curScene = lc._runningScene
				if curScene and curScene._scene then
					for _, child in ipairs(curScene._scene:getChildren()) do
						if child._indicator then
							pcall(function() child._indicator:removeFromParent(); child._indicator = nil end)
						end
						if child._list and child.refreshItemList then
							pcall(function() child:refreshItemList() end)
						end
					end
				end
			end)
			return true
		end
		return false
	end
	ClientData.sendRank = ClientData.sendRankRequest
	ClientData.sendRankPre = ClientData.sendRankRequest
	ClientData.sendGetPreRanks = function() return true end

	-- PVP Logs / Match Replays
	ClientData.sendGetPvpLogs = function(logType)
		local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("get_replays", { account_id = accId }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				local logList = {}
				if res and res.replays then
					for _, rep in ipairs(res.replays) do
						local oppCrown = nil
						local opp_gc = tonumber(rep.opponent_gold_cup) or 0
						local opp_sc = tonumber(rep.opponent_silver_cup) or 0
						local opp_bc = tonumber(rep.opponent_bronze_cup) or 0
						if opp_gc > 0 then oppCrown = { info_id = 7204, num = opp_gc }
						elseif opp_sc > 0 then oppCrown = { info_id = 7205, num = opp_sc }
						elseif opp_bc > 0 then oppCrown = { info_id = 7206, num = opp_bc }
						end
						local oppInfo = {
							id = 2,
							name = rep.opponent_name or "Seto_Kaiba",
							level = rep.opponent_level or 50,
							avatar = rep.opponent_avatar or 201,
							trophy = 800,
							gold = 10000,
							grain = 10000,
							ingot = 1000,
							exp = 0,
							vip = 0,
							shield = 0,
							union_id = 0,
							union_name = "",
							union_title = 0,
							union_avatar = 0,
							union_tag = "",
							last_login = os.time() * 1000,
							rid = 10001,
							privilege = 0,
							month_card = 0
						}
						if oppCrown then oppInfo.crown = oppCrown end

						local pInfo = {
							id = (P and P._id) or 1,
							name = (P and P._name) or "Duelist",
							level = (P and P._level) or 50,
							avatar = (P and P._avatar) or 101,
							trophy = (P and P._trophy) or 800,
							gold = 10000,
							grain = 10000,
							ingot = 1000,
							exp = 0,
							vip = (P and P._vip) or 0,
							shield = 0,
							union_id = 0,
							union_name = "",
							union_title = 0,
							union_avatar = 0,
							union_tag = "",
							last_login = os.time() * 1000,
							rid = 10001,
							privilege = 0,
							month_card = 0
						}
						if P and P._crown then
							pInfo.crown = { info_id = P._crown._infoId, num = P._crown._num }
						end

						local bResType = (rep.result == 1 and Data.BattleResult.win) or (rep.result == 2 and Data.BattleResult.lose) or Data.BattleResult.draw
						local singleLogData = {
							id = rep.replay_id,
							timestamp = (rep.timestamp or os.time()) * 1000,
							result_type = bResType,
							battle_type = rep.battle_type or 17,
							replay_id = rep.replay_id,
							trophy = rep.trophy_change or 0,
							trophy_ex = 0,
							city = 0,
							creator = 0,
							is_available = true,
							opponent_info = oppInfo,
							player_info = pInfo
						}
						table.insert(logList, singleLogData)

						pcall(function()
							if P and P._playerLog then
								local logObj = require("Log").new(true, singleLogData)
								P._playerLog:addLog(logObj, Battle_pb.PB_BATTLE_WORLD_LADDER)
								P._playerLog:addLog(logObj, Battle_pb.PB_BATTLE_PLAYER)
								P._playerLog:addLog(logObj, Battle_pb.PB_BATTLE_MATCH)
							end
						end)
					end
				end

				local logMsg = {
					logs = logList,
					type = logType or Battle_pb.PB_BATTLE_WORLD_LADDER
				}
				makeProtobufCompatible(logMsg)
				local resp = {
					type = SglMsgType_pb.PB_TYPE_BATTLE_LOG_EX,
					Extensions = {
						[Battle_pb.SglBattleMsg.battle_log_ex_resp] = logMsg
					}
				}
				makeProtobufCompatible(resp)
				ClientData.onMsg(resp)

				pcall(function()
					local ind = ClientView.getActiveIndicator()
					if ind and ind.hide then ind:hide() end
					if P and P._playerLog then
						P._playerLog._isClashLogsReady = true
						P._playerLog._isRoomLogsReady = true
						P._playerLog._isPvpLogsFetched = true
						if logType == Battle_pb.PB_BATTLE_PLAYER then
							P._playerLog:sendLogDirty(require("PlayerLog").Event.attack_log_dirty)
							P._playerLog:sendLogDirty(require("PlayerLog").Event.defense_log_dirty)
						elseif logType == Battle_pb.PB_BATTLE_MATCH then
							P._playerLog:sendLogDirty(require("PlayerLog").Event.room_log_dirty)
						else
							P._playerLog:sendLogDirty(require("PlayerLog").Event.clash_log_dirty)
						end
					end
				end)
			end)
			return true
		end
		return false
	end

	ClientData.sendBattleReplay = function(replayId, isLocal)
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("get_replay_detail", { replay_id = tostring(replayId or "") }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				local ind = ClientView.getActiveIndicator()
				if ind and ind.hide then ind:hide() end
				if res and res.replay_data then
					pcall(function()
						if BaseForm and BaseForm.hideTopMost then BaseForm.hideTopMost() end
						local cp = (ClientView and ClientView.getChatPanel and ClientView.getChatPanel()) or ClientData._chatPanel
						if cp and cp._isPop then cp:push() end
					end)

					local rd = res.replay_data
					local myCards = (P and P._troops and P._troops[1] and P._troops[1]._cards) or {10001, 10002}
					local curTs = (rd.timestamp or (rd.ts and rd.ts * 1000) or (os.time() * 1000))
					if curTs < 10000000000 then curTs = curTs * 1000 end

					local pData = rd.player or { _name = (P and P._name) or "Duelist", _level = (P and P._level) or 50, _avatar = (P and P._avatar) or 101, _troopCards = myCards }
					local oData = rd.opponent or { _name = "Opponent", _level = 50, _avatar = 201, _troopCards = {10001, 10002} }

					local function normalizeUsedCards(uc)
						if type(uc) ~= "table" then return { _hasTime = true } end
						local list = {}
						local n = #uc
						if n > 0 then
							for i = 1, n do
								table.insert(list, tonumber(uc[i]) or 0)
							end
						else
							local maxK = 0
							for k, v in pairs(uc) do
								local nk = tonumber(k)
								if nk and nk > maxK then maxK = nk end
							end
							for i = 1, maxK do
								table.insert(list, tonumber(uc[tostring(i)] or uc[i]) or 0)
							end
						end
						list._hasTime = true
						return list
					end

					pData._level = pData._level or (P and P._level) or 50
					pData._vip = pData._vip or (P and P._vip) or 0
					pData._trophy = pData._trophy or (P and P._trophy) or 800
					pData._cardBackId = (pData._cardBackId and pData._cardBackId >= 7600) and pData._cardBackId or Data.PropsId.card_back
					pData._region = pData._region or 1
					pData._regionId = pData._regionId or 1
					pData._privilege = pData._privilege or 0
					pData._monthCardType = pData._monthCardType or 0
					pData._isNpc = false
					pData._isNewRound = (P and P._isNewRound) or false
					pData._roundTimeInit = 60
					pData._roundTimeMax = 120
					pData._roundTimeDelta = (pData._isNewRound and 6) or 6
					pData._fortressHp = (pData._fortressHp and pData._fortressHp > 0) and pData._fortressHp or 8000
					pData._bossId = 0
					pData._bossLevel = 1
					pData._avatarFrame = pData._avatarFrame or 0
					pData._avatarFrameCount = 0
					pData._idInRoom = 1
					pData._troopCards = (pData._troopCards and #pData._troopCards > 0) and pData._troopCards or myCards
					pData._troopLevels = pData._troopLevels or {}
					pData._usedCards = normalizeUsedCards(pData._usedCards)
					pData._troopSkins = pData._troopSkins or {}
					pData._extraSkills = pData._extraSkills or {}

					oData._level = oData._level or 50
					oData._vip = oData._vip or 0
					oData._trophy = oData._trophy or 800
					oData._cardBackId = (oData._cardBackId and oData._cardBackId >= 7600) and oData._cardBackId or Data.PropsId.card_back
					oData._region = oData._region or 1
					oData._regionId = oData._regionId or 1
					oData._privilege = oData._privilege or 0
					oData._monthCardType = oData._monthCardType or 0
					oData._isNpc = false
					oData._isNewRound = (P and P._isNewRound) or false
					oData._roundTimeInit = 60
					oData._roundTimeMax = 120
					oData._roundTimeDelta = (oData._isNewRound and 6) or 6
					oData._fortressHp = (oData._fortressHp and oData._fortressHp > 0) and oData._fortressHp or 8000
					oData._bossId = 0
					oData._bossLevel = 1
					oData._avatarFrame = oData._avatarFrame or 0
					oData._avatarFrameCount = 0
					oData._idInRoom = 2
					oData._troopCards = (oData._troopCards and #oData._troopCards > 0) and oData._troopCards or {10001, 10002, 10003, 10004, 10005}
					oData._troopLevels = oData._troopLevels or {}
					oData._usedCards = normalizeUsedCards(oData._usedCards)
					oData._troopSkins = oData._troopSkins or {}
					oData._extraSkills = oData._extraSkills or {}

					local repRes = (rd.result == 1 and Data.BattleResult.win) or (rd.result == 2 and Data.BattleResult.lose) or Data.BattleResult.draw

					local isPlayerAttacker = true
					local pCard = nil
					for i = 1, #pData._usedCards do
						local v = pData._usedCards[i]
						if v and v > 10000 then
							local base = v % 10000
							if base >= 1000 and base < 3000 then
								pCard = base
								break
							end
						end
					end
					if pCard then
						isPlayerAttacker = (pCard < 2000)
					else
						for i = 1, #oData._usedCards do
							local v = oData._usedCards[i]
							if v and v > 10000 then
								local base = v % 10000
								if base >= 1000 and base < 3000 then
									isPlayerAttacker = (base >= 2000)
									break
								end
							end
						end
					end

					local repLog = ClientData._replayingLog or {
						_id = replayId,
						_replayId = replayId,
						_resultType = repRes,
						_isAttack = isPlayerAttacker,
						_trophy = rd.trophy_change or 25,
						_oppoTrophy = 800,
						_player = require("User").create({ id = (P and P._id) or 1, name = pData._name or "Duelist", level = pData._level or 50, avatar = pData._avatar or 101, trophy = pData._trophy or 800 }),
						_opponent = require("User").create({ id = 2, name = oData._name or "Opponent", level = oData._level or 50, avatar = oData._avatar or 201, trophy = oData._trophy or 800 })
					}
					repLog._log = repLog

					local input = {
						_battleType = Data.BattleType.replay,
						_replayBattleType = Data.BattleType.PVP_clash,
						_sceneType = 11,
						_clashGrade = 1,
						_clashOppoType = 5,
						_eventIds = {},
						_oppoEventIds = {},
						_conditionIds = {},
						_conditionValues = {},
						_conditions = {},
						_ruleType = 0,
						_timestamp = curTs,
						_isWatcher = false,
						_isAttacker = isPlayerAttacker,
						_isOppoOnline = false,
						_randomSeed = rd.seed or 12345,
						_player = pData,
						_opponent = oData,
						_replayingLog = repLog
					}

					local curSceneId = (lc._runningScene and lc._runningScene._sceneId) or ClientData.SceneId.city
					ClientData._fromSceneId = curSceneId

					local swScene = require("ResSwitchScene").create(curSceneId, ClientData.SceneId.battle, input)
					lc.replaceScene(swScene)
				else
					ToastManager.push((res and res.msg) or "Không tìm thấy dữ liệu trận đấu!")
				end
			end)
		end
		return true
	end
	ClientData.sendBattleShare = function(logId, text)
		local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("share_replay", {
				account_id = accId,
				replay_id = tostring(logId),
				text = tostring(text or "")
			}, function(rawRes)
				local ind = ClientView.getActiveIndicator()
				if ind and ind.hide then ind:hide() end
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 then
					pcall(function()
						local evt = cc.EventCustom:new(Data.Event.log_shared)
						evt._event = require("PlayerLog").Event.log_item_dirty
						evt._logId = logId
						lc.Dispatcher:dispatchEvent(evt)

						if P and P._playerLog then
							P._playerLog:sendLogDirty(require("PlayerLog").Event.log_item_dirty, logId)
						end

						local m = res.message
						local bPayload = res.battle_payload
						if _G.addRawChatMessage and (m or bPayload) then
							local mid = (m and m.id) or os.time()
							local mts = (m and m.timestamp) or (os.time() * 1000)
							local mName = (m and m.name) or (P and P._name) or "Duelist"
							local mLvl = (m and m.level) or (P and P._level) or 50
							local mAvatar = (m and m.avatar) or (P and P._avatar) or 101
							local mContent = bPayload or (m and m.battle_data) or (m and m.content) or text
							local mCId = (m and m.client_msg_id) or string.format("share_%s_%s", tostring(logId), tostring(os.time()))
							_G.addRawChatMessage(mid, mts, accId, mName, mLvl, mAvatar, mContent, 3, 0, mCId)
							local cp = (ClientView and ClientView.getChatPanel and ClientView.getChatPanel()) or ClientData._chatPanel
							if cp and cp._isPop then
								cp:resetList()
							end
						end
					end)
					ToastManager.push(Str(STR.SHARE_SUCCESS))
				else
					local errMsg = (res and res.msg) or "Chia sẻ thất bại"
					ToastManager.push(errMsg)
				end
			end)
			return true
		end
		return false
	end

	ClientData.sendBattleShareReplay = function(replayId)
		pcall(function()
			local cp = (ClientView and ClientView.getChatPanel and ClientView.getChatPanel()) or ClientData._chatPanel
			if cp and cp._isPop then cp:push() end
		end)
		return ClientData.sendBattleReplay(replayId, false)
	end
	ClientData.sendClashResetLadderLose = function() return true end
	ClientData.sendClashExBuyTicket = function(ticketType) return true end
	ClientData.sendClashExQuit = function() return true end
	ClientData.sendBuyTicket = function() return true end

	-- =========================================================================
	-- SURVIVAL & DRAFT (Sinh Tử Chiến / Đấu Trường / Quyết Đấu Đỉnh Cao) OFFLINE H5
	-- =========================================================================
	local CHAR_CARDS_MAP = {
		[2] = { 10001, 10013, 10029, 10212, 10335, 10342, 10343, 10361, 10498, 10502, 10646, 10651, 10703, 10705, 10706, 10720, 10729, 10730, 10731, 10814, 10930, 10968, 10986, 10987, 10988, 10989, 10990, 10991, 10992, 10993, 10994, 10995, 10996, 11040, 11041, 11042, 11048, 11049, 11050, 11051, 11075, 11076, 11079, 11080, 11081, 11091, 11092, 11120, 11289, 11329, 11363, 11402, 11567, 11568, 11613, 11618, 11898, 11899, 11947, 11948, 11969, 12140, 12151, 12177, 12224, 12275, 12291, 12299, 20052, 20275, 20303, 20360, 20412, 20525, 20553, 20959, 20980, 21090, 21093, 21097, 21127, 21132, 30120, 30158, 30357, 30379, 30575, 30578, 40001, 40013, 40033, 40037, 40090, 40091, 40092, 40093, 40102, 40103, 40115, 40133, 40138, 40139, 40148, 40153, 40203, 40250, 40256, 40301, 40354, 40355, 40454, 40478, 40480, 40504, 40531, 40648, 40680, 40686, 40708, 40719, 40722, 20470, 20362, 20746, 20621, 20651, 20260, 20007, 20256, 20015, 20550, 20484, 20021, 20056, 20059, 20063, 20099, 20162, 20227, 20361, 20715, 10115, 10117, 10606, 10699, 40158 },
		[3] = { 10004, 10006, 10048, 10242, 10266, 10477, 10624, 10645, 10702, 10849, 10850, 10867, 10897, 11146, 11147, 11148, 11149, 11150, 11151, 11152, 11153, 11154, 11155, 11156, 11157, 11158, 11159, 11225, 11252, 11297, 11299, 11300, 11301, 11302, 11303, 11309, 11336, 11379, 11510, 11512, 11577, 11594, 11609, 11610, 11615, 11619, 11622, 11632, 11633, 11730, 11797, 11798, 11804, 11875, 11918, 12043, 12051, 12052, 12053, 12093, 12127, 12130, 12181, 12204, 12251, 12265, 12266, 12273, 12282, 12283, 12307, 12310, 20001, 20002, 20003, 20006, 20009, 20010, 20012, 20013, 20014, 20027, 20043, 20160, 20432, 20433, 20456, 20493, 20518, 20519, 20520, 20529, 20543, 20544, 20646, 20664, 20750, 20751, 20760, 20764, 20765, 20815, 20900, 20911, 20913, 20951, 20960, 21045, 21098, 21126, 30022, 30024, 30031, 30161, 30247, 30248, 30383, 30388, 30389, 30479, 30554, 40140, 40141, 40142, 40143, 40150, 40157, 40173, 40199, 40200, 40201, 40202, 40441, 40442, 40494, 40495, 40496, 40617, 40664, 40709, 40712, 20310, 20311, 20316, 20514, 20516, 20517, 20521, 20523, 20566, 20852, 20858, 21073, 21119, 30482, 11921, 11296 },
		[4] = { 10075, 10076, 10077, 10119, 10120, 10121, 10122, 10123, 10284, 10285, 10783, 10784, 10785, 10786, 11121, 11122, 11123, 11124, 11125, 11126, 11127, 11128, 11129, 11130, 11224, 11337, 11694, 12088, 12089, 12192, 20053, 20054, 20117, 20301, 20333, 20425, 20426, 20641, 21051, 21094, 30064, 30065, 30066, 30171, 30238, 30239, 30240, 40047, 40052, 40128, 40129, 40130, 40131, 40476, 40613, 40659, 40662 },
		[5] = { 10086, 10118, 10405, 10620, 10621, 10622, 10787, 10815, 10848, 11013, 11020, 11093, 11221, 11318, 11319, 11320, 11321, 11322, 11323, 11324, 11325, 11326, 11327, 11328, 11365, 11368, 11497, 11498, 11499, 12037, 12039, 12040, 12091, 12092, 12167, 12168, 12312, 20189, 20190, 20197, 20198, 20292, 20380, 20534, 20535, 20536, 20538, 20549, 20551, 20552, 20565, 20840, 21018, 21020, 30036, 30124, 30132, 30138, 30423, 30424, 30425, 30442, 40160, 40194, 40210, 40211, 40212, 40213, 40288, 40431, 40498, 40585, 40616, 40675, 40718 },
		[6] = { 10077, 10274, 10277, 10279, 10281, 20114, 30070, 10286, 20116, 10056, 10084, 40009, 30062, 10272, 10280, 10282, 10284, 10285, 20115, 10075, 20033, 20102, 10275, 10276, 10083, 10055, 10079, 10080, 10183, 10184, 10186, 10187, 10223, 30045, 10205, 10020, 10027, 10040, 10101, 10136, 10137, 10142, 10156, 10164, 10167, 10169, 10173, 10174, 10176, 10179, 10188, 10190, 10192, 10193, 20113, 20016, 20060, 20063, 20078 },
		[7] = { 10868, 10869, 10870, 10871, 10879, 10920, 10925, 10926, 11554, 20317, 30177, 40332, 40333 },
		[8] = { 10109, 10325, 10507, 10508, 10514, 10515, 10669, 10748, 10781, 10782, 10922, 11160, 11286, 11393, 11394, 11395, 11396, 11397, 11398, 11399, 11400, 11401, 11493, 11532, 11533, 11535, 11955, 11956, 11957, 11973, 11974, 11975, 11976, 11977, 11978, 11979, 11996, 11997, 12143, 12144, 12169, 12170, 12189, 12200, 12201, 12202, 12215, 20093, 20153, 20226, 20490, 20584, 20585, 20586, 20989, 20990, 20991, 21078, 21101, 30154, 30322, 30323, 30324, 30515, 30516, 30517, 30518, 30571, 30583, 40144, 40246, 40275, 40282, 40316, 40532, 40533, 40543, 40544, 40545, 40546, 40547, 40548, 40549, 40550, 40627, 40668 },
		[9] = { 10482, 10483, 10484, 10485, 10486, 10487, 10488, 10489, 10490, 10576, 11008, 11356, 11357, 11358, 11359, 11360, 11361, 11362, 11371, 11719, 11720, 11721, 11722, 11723, 11724, 11725, 11726, 11727, 11728, 12047, 12048, 12094, 12095, 12096, 12097, 12098, 12099, 12100, 12101, 12102, 12114, 12199, 12303, 20556, 20557, 20818, 20819, 20820, 21024, 21053, 21064, 21130, 30121, 30428, 30429, 30430, 30431, 30432, 30555, 30556, 30557, 30558, 30559, 30561, 30565, 40094, 40163, 40232, 40402, 40403, 40404, 40405, 40406, 40553, 40588, 40589, 40618, 40619, 40620, 40621, 40622, 40623, 40625, 40626, 40720 },
		[10] = { 12158, 12159, 12160, 12161, 12162, 12163, 12164, 12165, 12171, 12172, 21085, 21086, 21087, 21088, 30576, 40651, 40652, 40653, 40654, 40655, 40656, 40657, 40699 },
		[11] = { 11473, 11474, 11475, 11476, 11477, 11478, 11479, 11480, 11485, 11621, 11679, 20632, 20633, 20634, 30347, 30348, 30349, 30570, 40181, 40184, 40205, 40227, 40241, 40242, 40262, 40270, 40284, 40285, 40286, 40287, 40291, 40296, 40324, 40337, 40338, 40340, 40367, 40382, 40389, 40391, 40397, 40401, 40411, 40412, 40450, 40456, 40469, 40497, 40502, 40522, 40567 },
		[12] = { 10290, 10291, 10683, 10684, 10685, 10686, 10687, 10688, 10689, 10715, 10718, 10726, 10758, 10828, 10938, 10942, 10943, 10944, 10945, 11227, 11245, 11246, 11247, 11248, 11249, 11250, 11251, 11416, 11417, 11461, 11463, 11555, 12008, 12042, 12078, 12173, 40010, 40038, 40039, 40040, 40041, 40042, 40043, 40044, 40045, 40048, 40049, 40050, 40051, 40053, 40055, 40057, 40058, 40060, 40061, 40062, 40063, 40064, 40065, 40066, 40146, 40167, 40168, 40169, 40263, 40272, 40273, 40274, 40276, 40277, 40279, 40280, 40281, 40334, 40335, 40336, 40534, 40606, 40658, 40696, 40697, 40170, 40646, 40558, 40607, 20511, 20486 },
		[13] = { 40071, 40068, 40070, 30206, 40072, 10948, 40069, 10950, 10957, 10947, 10954, 10952, 10951, 10949, 40073, 20062, 10955, 30204, 30207, 10953, 10587, 20102, 20077, 20090, 30061, 20092, 10223, 10041, 10031, 30045, 10048, 10051, 10097, 30013, 20022, 10302, 10303, 10018, 10101, 10136, 10137, 10142, 10156, 10164, 10167, 10169, 10173, 10174, 10176, 10179, 10188, 20157, 20158, 20174, 20125, 20016, 20060, 20063, 20078 },
		[14] = { 11857, 11858, 11859, 11860, 11861, 11862, 11863, 11864, 11865, 11866, 11867, 11868, 11869, 11890, 11891, 11936, 11937, 11938, 11939, 11940, 11941, 11942, 11954, 11987, 12254, 20952, 20953, 20954, 20955, 20956, 20957, 20997, 30505, 30506, 30507, 30521, 40484, 40485, 40486, 40487, 40488, 40489, 40490, 40491, 40526, 40527, 40528, 40529, 40703 },
		[15] = { 10290, 10291, 10683, 10684, 10685, 10686, 10687, 10688, 10689, 10715, 10718, 10726, 10758, 10828, 10938, 10942, 10943, 10944, 10945, 11227, 11245, 11246, 11247, 11248, 11249, 11250, 11251, 11416, 11417, 11461, 11463, 11555, 12008, 12042, 12078, 12173, 40010, 40038, 40039, 40040, 40041, 40042, 40043, 40044, 40045, 40048, 40049, 40050, 40051, 40053, 40055, 40057, 40058, 40060, 40061, 40062, 40063, 40064, 40065, 40066, 40146, 40167, 40168, 40169, 40263, 40272, 40273, 40274, 40276, 40277, 40279, 40280, 40281, 40334, 40335, 40336, 40534, 40606, 40658, 40696, 40697, 40170, 40646, 40558, 40607, 20511, 20486 },
		[16] = { 11085, 11086, 11087, 11088, 11089, 11090, 11254, 11255, 11256, 11257, 11258, 11259, 11260, 11261, 11262, 11432, 11433, 11434, 11435, 11436, 11437, 11440, 11707, 11915, 12041, 12137, 12253, 20406, 20407, 20441, 20494, 20495, 20496, 20924, 21123, 30203, 30226, 30227, 30228, 30229, 30250, 30278, 30279, 30422, 30494, 30590, 40088, 40110, 40111, 40112, 40113, 40114, 40174, 40177, 40178, 40179, 40180, 40399, 40457, 40515, 40704, 40705, 40706 },
		[17] = { 11834, 11835, 11836, 11837, 11838, 11839, 11840, 11841, 12075, 12076, 12193, 12289, 20880, 20881, 20882, 30457, 30458, 30459, 30460, 30461, 30547, 40463, 40464, 40465, 40466, 40663 },
		[18] = { 10246, 10265, 10289, 10420, 10560, 10704, 10766, 11030, 11031, 11032, 11033, 11044, 11045, 11046, 11054, 11059, 11060, 11061, 11062, 11063, 11064, 11065, 11145, 11293, 11294, 11313, 11513, 11552, 11553, 11848, 11883, 11900, 12025, 12026, 12027, 12074, 12264, 12300, 20222, 20240, 20392, 20393, 20395, 20396, 20917, 21084, 30119, 30164, 30191, 30220, 30221, 30222, 30223, 30258, 30366, 30367, 30368, 30369, 30426, 30427, 30467, 30469, 30489, 40104, 40105, 40470, 40471, 40505 },
		[19] = { 11766, 11767, 11768, 11769, 11770, 11771, 11772, 11773, 11774, 11775, 11776, 11777, 12109, 20832, 20833, 20834, 20835, 20836, 20863, 30438, 30439, 40427, 40428, 40429, 40430 },
	}

	local function generateDraftPool(charId)
		local charCards = (charId and CHAR_CARDS_MAP[tonumber(charId)]) or (charId and CHAR_CARDS_MAP[tostring(charId)])
		local charMonsters = {}
		local charSpells = {}

		if charCards and #charCards > 0 then
			for _, cid in ipairs(charCards) do
				cid = tonumber(cid)
				if cid then
					if cid < 20000 then
						table.insert(charMonsters, cid)
					elseif cid < 40000 then
						table.insert(charSpells, cid)
					end
				end
			end
		end

		local fallbackMonsters = { 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010 }
		local fallbackSpells = { 20001, 20002, 20003, 20004, 20005, 30001, 30002, 30003 }

		local monsterPool = {}
		if #charMonsters > 0 then
			while #monsterPool < 60 do
				for _, cid in ipairs(charMonsters) do
					table.insert(monsterPool, cid)
					if #monsterPool >= 60 then break end
				end
			end
		else
			monsterPool = fallbackMonsters
		end

		local spellPool = {}
		if #charSpells > 0 then
			while #spellPool < 40 do
				for _, cid in ipairs(charSpells) do
					table.insert(spellPool, cid)
					if #spellPool >= 40 then break end
				end
			end
		else
			spellPool = fallbackSpells
		end

		-- Shuffle pools
		for i = #monsterPool, 2, -1 do
			local j = math.random(1, i)
			monsterPool[i], monsterPool[j] = monsterPool[j], monsterPool[i]
		end
		for i = #spellPool, 2, -1 do
			local j = math.random(1, i)
			spellPool[i], spellPool[j] = spellPool[j], spellPool[i]
		end

		local pool = {}
		local mIdx, sIdx = 1, 1
		for r = 1, 20 do
			local roundCards = {
				monsterPool[mIdx] or 10001,
				monsterPool[mIdx + 1] or 10002,
				monsterPool[mIdx + 2] or 10003,
				spellPool[sIdx] or 20001,
				spellPool[sIdx + 1] or 20002,
			}
			mIdx = (mIdx + 3 > #monsterPool) and 1 or (mIdx + 3)
			sIdx = (sIdx + 2 > #spellPool) and 1 or (sIdx + 2)
			for i = 5, 2, -1 do
				local j = math.random(1, i)
				roundCards[i], roundCards[j] = roundCards[j], roundCards[i]
			end
			for _, c in ipairs(roundCards) do
				table.insert(pool, c)
			end
		end
		return pool
	end

	local function pickDraftCharacters()
		local allChars = { 2, 3, 4, 5, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
		local validChars = {}
		for _, id in ipairs(allChars) do
			if Data and Data._characterInfo and Data._characterInfo[id] then
				table.insert(validChars, id)
				if P and P._characters and not P._characters[id] then
					P._characters[id] = {
						_level = 1,
						_exp = 0,
						_id = id,
						_avatar = id * 100 + 1,
						_skinId = nil,
						_breakOut = false
					}
				end
			end
		end
		if #validChars < 3 then
			validChars = { 2, 3, 4 }
		end
		for i = #validChars, 2, -1 do
			local j = math.random(1, i)
			validChars[i], validChars[j] = validChars[j], validChars[i]
		end
		return { validChars[1], validChars[2], validChars[3] }
	end



	local function makeDraftSglMsg(msgType, extField, extVal)
		local msg = {
			type = msgType,
			status = SglMsg_pb and SglMsg_pb.PB_STATUS_OK or 0,
			Extensions = {},
			HasField = function(self, f) return rawget(self, f) ~= nil end,
			HasExtension = function(self, ext) return self.Extensions and self.Extensions[ext] ~= nil end
		}
		if extField ~= nil then
			msg.Extensions[extField] = extVal
		end
		return msg
	end

	local function deliverDraftMsg(msg, cb)
		pcall(function()
			if ClientView and ClientView.getActiveIndicator then
				local ind = ClientView.getActiveIndicator()
				if ind and ind.hide then ind:hide() end
			end
		end)
		if lc and lc.Scheduler and lc.Scheduler.scheduleScriptFunc then
			local entry
			entry = lc.Scheduler:scheduleScriptFunc(function()
				if entry and lc.Scheduler.unscheduleScriptEntry then
					pcall(function() lc.Scheduler:unscheduleScriptEntry(entry) end)
				end
				pcall(function()
					if ClientView and ClientView.getActiveIndicator then
						local ind = ClientView.getActiveIndicator()
						if ind and ind.hide then ind:hide() end
					end
				end)
				if ClientData and ClientData.onMsg then
					ClientData.onMsg(msg)
				end
				if cb then pcall(cb) end
			end, 0.05, false)
		else
			if ClientData and ClientData.onMsg then
				ClientData.onMsg(msg)
			end
			if cb then pcall(cb) end
		end
	end

	---------------------------------------------------------------------------
	-- GUILD / UNION FEATURE HOOKS (H5 PROTOCOL BRIDGING)
	---------------------------------------------------------------------------
	local function formatUnionPbPayload(data)
		if not data or not data.union_info then return nil end
		local uInfo = data.union_info
		local mList = data.member_info or {}
		local uDetail = {
			union_info = uInfo,
			member_info = mList
		}
		local payload = {
			info = {
				id = uInfo.id,
				name = uInfo.name,
				avatar = uInfo.avatar,
				tag = uInfo.tag,
				level = uInfo.level,
				exp = uInfo.exp,
				gold = uInfo.gold,
				wood = uInfo.wood,
				announcement = uInfo.announcement,
				member = uInfo.member,
				required_level = uInfo.required_level,
				type = uInfo.type,
				detail = uDetail
			},
			detail = uDetail,
			weekly_donates = data.weekly_donates or {},
			daily_donates = data.daily_donates or {},
			lets = {},
			data = {
				bosses = {},
				techs = {},
				props = {},
				team_info = { masswar_score = 500 }
			},
			impeaches = {}
		}
		makeProtobufCompatible(payload)
		return payload
	end

	local function handleGetMyUnionDetail()
		local accId = (P and P._id) or (ClientData._account and ClientData._account.id) or 0
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_mine", { account_id = accId }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 and res.union_info then
					if res.daily_donate_free ~= nil and P then P._dailyFreeDonate = res.daily_donate_free end
					if res.daily_donate_gold ~= nil and P then P._dailyGoldDonate = res.daily_donate_gold end
					if res.daily_donate_gem ~= nil and P then P._dailyIngotDonate = res.daily_donate_gem end
					local pbData = formatUnionPbPayload(res)
					P._unionId = res.union_info.id
					P._unionName = res.union_info.name
					P._unionBadge = res.union_info.avatar
					P._unionWord = res.union_info.tag
					P._unionType = res.union_info.type
					local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_UNION_MINE, Union_pb.SglUnionMsg.union_mine_resp, pbData)
					deliverDraftMsg(msg, function()
						lc.sendEvent(Data.Event.union_dirty)
					end)
				else
					P._unionId = 0
					P._unionName = ""
					if P._playerUnion then
						P._playerUnion:clear()
					end
					pcall(function()
						local ind = ClientView.getActiveIndicator()
						if ind and ind.hide then ind:hide() end
					end)
					local curScene = lc._runningScene
					if curScene and curScene.updateTabs then
						pcall(function() curScene:updateTabs() end)
					end
				end
			end)
		else
			pcall(function()
				local ind = ClientView.getActiveIndicator()
				if ind and ind.hide then ind:hide() end
			end)
		end
		return true
	end
	ClientData.sendGetMyUnionDetail = handleGetMyUnionDetail
	ClientData.sendGetUnionMine = handleGetMyUnionDetail

	ClientData.sendGetUnionDetail = function(unionId)
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_detail", { union_id = unionId }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 and res.union_info then
					local detailData = {
						union_info = res.union_info,
						member_info = res.member_info or {}
					}
					makeProtobufCompatible(detailData)
					local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_UNION_DETAIL, Union_pb.SglUnionMsg.union_detail_resp, detailData)
					deliverDraftMsg(msg)
				else
					pcall(function()
						local ind = ClientView.getActiveIndicator()
						if ind and ind.hide then ind:hide() end
					end)
				end
			end)
		end
		return true
	end

	ClientData.sendGetRecommandUnions = function()
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_recommend", { account_id = (P and P._id) or 0 }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				local uList = (res and res.unions) or {}
				makeProtobufCompatible(uList)
				local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_UNION_RECOMMEND, Union_pb.SglUnionMsg.union_recommend_resp, uList)
				deliverDraftMsg(msg)
			end)
		end
		return true
	end

	ClientData.sendGetSearchUnions = function(field, query)
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_search", { field = field, query = query }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				local uList = (res and res.unions) or {}
				makeProtobufCompatible(uList)
				local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_UNION_SEARCH, Union_pb.SglUnionMsg.union_search_resp, uList)
				deliverDraftMsg(msg)
			end)
		end
		return true
	end

	ClientData.sendCreateUnion = function(name, announcement, reqLevel, joinType, avatar, tag)
		local accId = (P and P._id) or (ClientData._account and ClientData._account.id) or 0
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_create", {
				account_id = accId,
				name = name,
				announcement = announcement,
				required_level = reqLevel,
				join_type = joinType,
				avatar = avatar,
				tag = tag
			}, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 and res.union_info then
					local pbData = formatUnionPbPayload(res)
					local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_UNION_CREATE, Union_pb.SglUnionMsg.union_create_resp, pbData)
					deliverDraftMsg(msg, function()
						ToastManager.push(res.msg or "Tạo công hội thành công!")
					end)
				else
					pcall(function()
						local ind = ClientView.getActiveIndicator()
						if ind and ind.hide then ind:hide() end
					end)
					ToastManager.push((res and res.msg) or "Tạo công hội thất bại!")
				end
			end)
		end
		return true
	end

	ClientData.sendUnionApply = function(unionId, message)
		local accId = (P and P._id) or (ClientData._account and ClientData._account.id) or 0
		if P and P._unionLeaveCd and os.time() < P._unionLeaveCd then
			local rem = P._unionLeaveCd - os.time()
			local hours = math.floor(rem / 3600)
			local mins = math.floor((rem % 3600) / 60)
			ToastManager.push(string.format("Sau khi rời công hội phải chờ 1 ngày mới có thể tham gia công hội khác! (Còn lại %d giờ %d phút)", hours, mins))
			return true
		end
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_join", {
				account_id = accId,
				union_id = unionId
			}, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 and res.union_info then
					local pbData = formatUnionPbPayload(res)
					local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_UNION_JOIN, Union_pb.SglUnionMsg.union_join_resp, pbData)
					deliverDraftMsg(msg, function()
						ToastManager.push(res.msg or "Gia nhập công hội thành công!")
					end)
				else
					pcall(function()
						local ind = ClientView.getActiveIndicator()
						if ind and ind.hide then ind:hide() end
					end)
					ToastManager.push((res and res.msg) or "Gia nhập công hội thất bại!")
				end
			end)
		end
		return true
	end

	ClientData.sendUnionLeave = function()
		local accId = (P and P._id) or (ClientData._account and ClientData._account.id) or 0
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_leave", { account_id = accId }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 then
					if P then
						P._unionLeaveCd = os.time() + 86400
					end
					local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_UNION_LEAVE, nil, nil)
					deliverDraftMsg(msg, function()
						ToastManager.push(res.msg or "Đã rời công hội!")
					end)
				else
					pcall(function()
						local ind = ClientView.getActiveIndicator()
						if ind and ind.hide then ind:hide() end
					end)
					ToastManager.push((res and res.msg) or "Rời công hội thất bại!")
				end
			end)
		end
		return true
	end

	ClientData.sendUnionKickout = function(targetId)
		local accId = (P and P._id) or (ClientData._account and ClientData._account.id) or 0
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_kick", { account_id = accId, target_id = targetId }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 then
					if P and P._playerUnion then
						P._playerUnion:removeMember(targetId)
					end
					ToastManager.push(res.msg or "Đã trục xuất thành viên!")
					lc.sendEvent(Data.Event.union_member_dirty)
				else
					ToastManager.push((res and res.msg) or "Không thể trục xuất!")
				end
			end)
		end
		return true
	end

	ClientData.sendUnionPromote = function(targetId)
		local accId = (P and P._id) or (ClientData._account and ClientData._account.id) or 0
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_set_job", { account_id = accId, target_id = targetId, job = 2 }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 then
					local myU = P and P._playerUnion and P._playerUnion:getMyUnion()
					if myU then
						local mem = myU:findMember(targetId)
						if mem then mem._unionJob = 2 end
					end
					ToastManager.push(res.msg or "Bổ nhiệm thành công!")
					lc.sendEvent(Data.Event.union_member_dirty)
				else
					ToastManager.push((res and res.msg) or "Bổ nhiệm thất bại!")
				end
			end)
		end
		return true
	end

	ClientData.sendUnionDemote = function(targetId)
		local accId = (P and P._id) or (ClientData._account and ClientData._account.id) or 0
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_set_job", { account_id = accId, target_id = targetId, job = 1 }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 then
					local myU = P and P._playerUnion and P._playerUnion:getMyUnion()
					if myU then
						local mem = myU:findMember(targetId)
						if mem then mem._unionJob = 1 end
					end
					ToastManager.push(res.msg or "Hạ chức thành công!")
					lc.sendEvent(Data.Event.union_member_dirty)
				else
					ToastManager.push((res and res.msg) or "Hạ chức thất bại!")
				end
			end)
		end
		return true
	end

	ClientData.sendUnionGiveLeader = function(targetId)
		local accId = (P and P._id) or (ClientData._account and ClientData._account.id) or 0
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_set_job", { account_id = accId, target_id = targetId, job = 3 }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 then
					P._unionJob = 2
					local myU = P and P._playerUnion and P._playerUnion:getMyUnion()
					if myU then
						local oldLead = myU:findMember(accId)
						if oldLead then oldLead._unionJob = 2 end
						local newLead = myU:findMember(targetId)
						if newLead then newLead._unionJob = 3 end
					end
					ToastManager.push(res.msg or "Chuyển giao quyền bang chủ thành công!")
					lc.sendEvent(Data.Event.union_member_dirty)
				else
					ToastManager.push((res and res.msg) or "Chuyển giao thất bại!")
				end
			end)
		end
		return true
	end

	ClientData.sendChangeUnion = function(name, announcement, reqLevel, joinType, avatar, tag)
		local accId = (P and P._id) or (ClientData._account and ClientData._account.id) or 0
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_edit", {
				account_id = accId,
				name = name,
				announcement = announcement,
				required_level = reqLevel,
				join_type = joinType,
				avatar = avatar,
				tag = tag
			}, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.code == 200 then
					local myU = P and P._playerUnion and P._playerUnion:getMyUnion()
					if myU then
						myU._name = name
						myU._announce = announcement
						myU._reqLevel = reqLevel
						myU._joinType = joinType
						myU._badge = avatar
						myU._word = tag
						P._unionName = name
						P._unionBadge = avatar
						P._unionWord = tag
						P._unionType = joinType
					end
					local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_UNION_EDIT, nil, nil)
					deliverDraftMsg(msg)
				else
					pcall(function()
						local ind = ClientView.getActiveIndicator()
						if ind and ind.hide then ind:hide() end
					end)
					ToastManager.push((res and res.msg) or "Sửa thông tin thất bại!")
				end
			end)
		end
		return true
	end

	ClientData.sendUnionContribute = function(grade, donateType)
		local accId = (P and P._id) or (ClientData._account and ClientData._account.id) or 0
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("union_contribute", {
				account_id = accId,
				res_type = grade
			}, function(rawRes)
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and res.code == 200 then
					if res.daily_donate_free ~= nil and P then P._dailyFreeDonate = res.daily_donate_free end
					if res.daily_donate_gold ~= nil and P then P._dailyGoldDonate = res.daily_donate_gold end
					if res.daily_donate_gem ~= nil and P then P._dailyIngotDonate = res.daily_donate_gem end
					if res.yubi and P and P._propBag then
						P._propBag:setProps(7024, tonumber(res.yubi) or 0)
						if lc and lc.Dispatcher and Data and Data.Event then
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.prop_dirty, { _infoId = 7024 }))
						end
					end
					if res.gold and P then P._gold = res.gold end
					if res.gem and P then P._ingot = res.gem end
					if P and P.sendResourceDirty then P:sendResourceDirty() end
					if lc and lc.sendEvent and Data and Data.Event then
						lc.sendEvent(Data.Event.union_dirty)
					end
				elseif res and res.msg then
					ToastManager.push(res.msg)
				end
			end)
		end
		return true
	end

	ClientData.sendGetUnionLog = function()
		local emptyLogs = {}
		makeProtobufCompatible(emptyLogs)
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_UNION_LOG, Union_pb.SglUnionMsg.union_message_resp, emptyLogs)
		deliverDraftMsg(msg)
		return true
	end

	ClientData.sendStartUnionBattle = function() return true end
	ClientData.sendQuitUnionBattle = function() return true end
	ClientData.sendFindUnionBattle = function() return true end
	ClientData.sendFindUnionBattleCancle = function() return true end
	ClientData.sendUnionWorship = function() return true end
	ClientData.sendUnionAddHire = function() return true end
	ClientData.sendUnionHire = function() return true end
	ClientData.sendUnionHireClaim = function() return true end
	ClientData.sendUnionHireRecall = function() return true end
	ClientData.sendUnionBossUnlock = function() return true end
	ClientData.sendUnionBossChallenge = function() return true end
	ClientData.sendUnionUpgradeTech = function() return true end
	ClientData.sendUnionUpgradeTechSelf = function() return true end
	ClientData.sendUnionImpeach = function() return true end

	-- Safe guard Data.getCharacterBoneName
	if Data and Data.getCharacterBoneName then
		local _origGetBone = Data.getCharacterBoneName
		Data.getCharacterBoneName = function(charId)
			if P and P._characters and not P._characters[charId] then
				P._characters[charId] = {
					_level = 1,
					_exp = 0,
					_id = charId,
					_avatar = charId * 100 + 1,
					_skinId = nil,
					_breakOut = false
				}
			end
			return _origGetBone(charId)
		end
	end

	-- 1. SURVIVAL EX (Sinh Tử Chiến)
	local function saveSurvivalExStateToBackend()
		if not P or not P._playerFindSurvivalEx then return end
		local sEx = P._playerFindSurvivalEx
		local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local api = jsbridge and jsbridge.object("jdzcApi")
		if not (api and api.post) then return end

		local cList = {}
		if sEx._troopCards then
			for _, c in ipairs(sEx._troopCards) do
				local cid = c._infoId or c.info_id or c
				local cnum = c._num or c.num or 1
				table.insert(cList, { info_id = cid, num = cnum })
			end
		end

		local exList = {}
		if sEx._troopCardsEx then
			for _, c in ipairs(sEx._troopCardsEx) do
				local cid = c._infoId or c.info_id or c
				local cnum = c._num or c.num or 1
				table.insert(exList, { info_id = cid, num = cnum })
			end
		end

		local payload = {
			account_id = accId,
			has_ticket = sEx._hasTicket and 1 or 0,
			character_id = sEx._characterId or 2,
			step = sEx._step or 1,
			win_count = sEx._win or 0,
			lose_count = sEx._lose or 0,
			trophy = sEx._trophy or 600,
			cards = cList,
			extra_cards = exList,
			pool = sEx._cardsPool or {},
			selected = sEx._selected or {}
		}
		api:post("survival_save_state", payload)
	end

	local function clearSurvivalExStateInBackend()
		local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local api = jsbridge and jsbridge.object("jdzcApi")
		if not (api and api.post) then return end
		api:post("survival_save_state", {
			account_id = accId,
			has_ticket = 0,
			character_id = 0,
			step = 0,
			win_count = 0,
			lose_count = 0,
			trophy = 600,
			cards = {},
			extra_cards = {},
			pool = {},
			selected = {}
		})
	end

	local function restoreSurvivalExStateFromBackend(callback)
		local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local api = jsbridge and jsbridge.object("jdzcApi")
		if not (api and api.post) then
			if callback then callback(false) end
			return
		end

		api:post("survival_get_state", { account_id = accId }, function(rawRes)
			local res = rawRes
			if type(res) == "string" then
				local ok, parsed = pcall(function() return require("json").decode(res) end)
				if ok and parsed then res = parsed end
			end
			if res and res.code == 200 and res.has_state and res.has_ticket == 1 and P and P._playerFindSurvivalEx then
				local sEx = P._playerFindSurvivalEx
				sEx._hasTicket = true
				sEx._characterId = res.character_id or 2
				sEx._step = res.step or 1
				sEx._win = res.win_count or 0
				sEx._lose = res.lose_count or 0
				sEx._trophy = res.trophy or 600
				sEx._cardsPool = res.pool or {}
				sEx._selected = res.selected or {}

				sEx._troopCards = {}
				sEx._troopCardsEx = {}
				if res.cards and #res.cards > 0 then
					for _, c in ipairs(res.cards) do
						local cid = tonumber(type(c) == "table" and (c.info_id or c._infoId) or c) or 0
						local cnum = tonumber(type(c) == "table" and (c.num or c._num) or 1) or 1
						if cid > 0 then
							sEx:addToCards(sEx._troopCards, cid, cnum)
						end
					end
				end
				if res.extra_cards and #res.extra_cards > 0 then
					for _, c in ipairs(res.extra_cards) do
						local cid = tonumber(type(c) == "table" and (c.info_id or c._infoId) or c) or 0
						local cnum = tonumber(type(c) == "table" and (c.num or c._num) or 1) or 1
						if cid > 0 then
							sEx:addToCards(sEx._troopCardsEx, cid, cnum)
						end
					end
				end
				table.sort(sEx._troopCards, sEx.sortFunc)
				table.sort(sEx._troopCardsEx, sEx.sortFunc)
				pcall(function() lc.sendEvent(Data.Event.survival_privilege_dirty) end)
				if callback then callback(true) end
			else
				if callback then callback(false) end
			end
		end)
	end

	ClientData.saveSurvivalExState = saveSurvivalExStateToBackend
	ClientData.clearSurvivalExState = clearSurvivalExStateInBackend
	ClientData.restoreSurvivalExState = restoreSurvivalExStateFromBackend

	ClientData.sendSurvivalExBuyTicket = function(ticketType)
		local chars = pickDraftCharacters()
		if P and P._playerFindSurvivalEx then
			P._playerFindSurvivalEx._hasTicket = true
			P._playerFindSurvivalEx._step = 0
			P._playerFindSurvivalEx._characterId = 0
			P._playerFindSurvivalEx._characters = chars
			P._playerFindSurvivalEx._troopCards = {}
			P._playerFindSurvivalEx._selected = {}
			P._playerFindSurvivalEx._win = 0
			P._playerFindSurvivalEx._lose = 0
			pcall(function()
				P._playerFindSurvivalEx:setTrophy(Data._globalInfo and Data._globalInfo._SurvivalExInitTrophy or 600)
			end)
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX, World_pb.SglWorldMsg.world_buy_ticket_resp, chars)
		deliverDraftMsg(msg)
		saveSurvivalExStateToBackend()
	end

	ClientData.sendSurvivalReselectCharacter = function()
		if P and P._playerFindSurvivalEx then
			P._playerFindSurvivalEx._rollTimes = (P._playerFindSurvivalEx._rollTimes or 0) + 1
		end
		local chars = pickDraftCharacters()
		if P and P._playerFindSurvivalEx then
			P._playerFindSurvivalEx._characters = chars
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX, World_pb.SglWorldMsg.world_roll_char_resp, chars)
		deliverDraftMsg(msg)
		saveSurvivalExStateToBackend()
	end

	ClientData.sendSurvivalExSelectCharacter = function(charId)
		local pool = generateDraftPool(charId)
		if P and P._playerFindSurvivalEx then
			P._playerFindSurvivalEx._characterId = charId or (P._playerFindSurvivalEx._characters and P._playerFindSurvivalEx._characters[1]) or 2
			P._playerFindSurvivalEx._step = 1
			P._playerFindSurvivalEx._cardsPool = pool
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX, World_pb.SglWorldMsg.world_select_char_resp, pool)
		deliverDraftMsg(msg)
		saveSurvivalExStateToBackend()
	end

	ClientData.sendSurvivalExSelectCard = function(cardIdx)
		local curStep = (P and P._playerFindSurvivalEx and P._playerFindSurvivalEx._step) or 1
		local nextStep = math.min(41, curStep + 1)
		if P and P._playerFindSurvivalEx then
			P._playerFindSurvivalEx._step = nextStep
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL_EX, World_pb.SglWorldMsg.world_select_card_resp, nextStep)
		deliverDraftMsg(msg)
		saveSurvivalExStateToBackend()
	end

	ClientData.sendSurvivalExQuit = function()
		local winCount = (P and P._playerFindSurvivalEx and P._playerFindSurvivalEx._win) or 0
		local rewards = {
			rank = (winCount >= 10) and 1 or (winCount >= 6 and 2 or 3),
			resource = {
				{ info_id = Data.ResType.gold, num = 5000 + winCount * 1000 }
			}
		}
		if P and P._playerFindSurvivalEx then
			P._playerFindSurvivalEx:clear()
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_EX_GAME_OVER, World_pb.SglWorldMsg.world_survival_ex_end_resp, rewards)
		deliverDraftMsg(msg)
		clearSurvivalExStateInBackend()
	end

	-- ==========================================================
	-- EXPEDITION EX (Thám hiểm EX - 10 Opponent Clones from Top 10)
	-- ==========================================================
	ClientData.sendGetExpeditionEx = function()
		local api = jsbridge and jsbridge.object("jdzcApi")
		local function fallbackExpedition()
			local curTs = math.floor(ClientData.getCurrentTime() * 1000)
			local troopsList = {}
			for i = 1, 9 do
				table.insert(troopsList, {
					chanllenge_count = 0,
					level = math.min(3, math.floor((i - 1) / 3)),
					troop_data = {
						info = { id = 3000 + i, name = string.format("Đối thủ Top %d", 11 - i), avatar = 101 + (i % 5) * 100 }
					},
					random_position = i,
					next_refresh = curTs + 86400000
				})
			end
			local bossData = {
				boss = {
					id = 3010,
					info = { id = 3010, name = "Quán Quân Top 1", avatar = 201 }
				},
				chanllenge_count = 0,
				random_position = 10,
				next_refresh = curTs + 86400000
			}
			local resp = {
				type = SglMsgType_pb.PB_TYPE_WORLD_GET_EXPEDITION_EX,
				status = 0,
				Extensions = {
					[World_pb.SglWorldMsg.world_get_expedition_ex_resp] = {
						lottery_power = 100,
						cur_npc = 0,
						troops = troopsList,
						boss = bossData,
						last_npc_update_time = curTs,
						last_boss_update_time = curTs,
						last_lottery_power_update_time = curTs,
						next_refresh = curTs + 86400000
					}
				}
			}
			ClientData.onMsg(resp)
		end

		local accId = (P and P._id) or (ClientData and ClientData._account and ClientData._account.id) or 1
		if api and api.post then
			api:post("expedition_get_opponents", { account_id = accId }, function(rawRes)
				local res = nil
				if type(rawRes) == "string" then
					local ok, parsed = pcall(function()
						if json and json.decode then return json.decode(rawRes) end
						return require("json").decode(rawRes)
					end)
					if ok and parsed then res = parsed end
				elseif type(rawRes) == "table" then
					res = rawRes
				end
				if res and res.code == 200 and res.opponents and #res.opponents > 0 then
					ClientData._expeditionOpponents = res.opponents
					ClientData._lotteryPower = res.lottery_power or 0
					if res.defeated_ids then
						ClientData._defeatedExpeditionIds = res.defeated_ids
					end
					local curTs = math.floor(ClientData.getCurrentTime() * 1000)
					local nextRef = res.next_refresh or (curTs + 86400000)
					local troopsList = {}
					local bossData = nil

					for _, opp in ipairs(res.opponents) do
						local isDef = opp.is_defeated
						if not isDef and ClientData._defeatedExpeditionIds then
							for _, did in ipairs(ClientData._defeatedExpeditionIds) do
								if tostring(did) == tostring(opp.id) or tostring(did) == tostring(opp.rank) then
									isDef = true
									break
								end
							end
						end

						if not isDef then
							if opp.is_boss or opp.rank == 1 then
								bossData = {
									boss = {
										id = opp.id or 1,
										info = {
											id = opp.id or 1,
											name = opp.name or "Quán Quân Top 1",
											avatar = opp.avatar or 201
										}
									},
									chanllenge_count = 0,
									random_position = 10,
									next_refresh = nextRef
								}
							else
								table.insert(troopsList, {
									chanllenge_count = 0,
									level = opp.mark_level or 1,
									troop_data = {
										info = {
											id = opp.id or 2,
											name = opp.name or "Duelist",
											avatar = opp.avatar or 101
										}
									},
									random_position = opp.rank or #troopsList,
									next_refresh = nextRef
								})
							end
						end
					end

					local resp = {
						type = SglMsgType_pb.PB_TYPE_WORLD_GET_EXPEDITION_EX,
						status = 0,
						Extensions = {
							[World_pb.SglWorldMsg.world_get_expedition_ex_resp] = {
								lottery_power = ClientData._lotteryPower,
								cur_npc = 0,
								troops = troopsList,
								boss = bossData,
								last_npc_update_time = curTs,
								last_boss_update_time = curTs,
								last_lottery_power_update_time = curTs,
								next_refresh = nextRef,
								HasField = function(self, fieldName) return rawget(self, fieldName) ~= nil or self[fieldName] ~= nil end
							}
						}
					}
					ClientData.onMsg(resp)

					local oppNpcIdx = 1
					for _, opp in ipairs(res.opponents) do
						local isDef = opp.is_defeated
						if not isDef and ClientData._defeatedExpeditionIds then
							for _, did in ipairs(ClientData._defeatedExpeditionIds) do
								if tostring(did) == tostring(opp.id) or tostring(did) == tostring(opp.rank) then
									isDef = true
									break
								end
							end
						end

						if not isDef then
							if opp.is_boss or opp.rank == 1 then
								if ClientData._expeditionBossInfo then
									ClientData._expeditionBossInfo._rank = 1
									ClientData._expeditionBossInfo._rewardCount = opp.reward_count or 300
								end
							else
								if ClientData._expeditionNpcInfos and ClientData._expeditionNpcInfos[oppNpcIdx] then
									ClientData._expeditionNpcInfos[oppNpcIdx]._rank = opp.rank
									ClientData._expeditionNpcInfos[oppNpcIdx]._rewardCount = opp.reward_count or 100
									oppNpcIdx = oppNpcIdx + 1
								end
							end
						end
					end

					local curScene = lc._runningScene
					if curScene and curScene.updatePlayers then
						pcall(function() curScene:updatePlayers() end)
					end
				else
					fallbackExpedition()
				end
			end)
		else
			fallbackExpedition()
		end
	end

	local function buildSkinEntryForCard(cid)
		cid = tonumber(cid) or 0
		local sId = 0
		local effs = {}
		local sObj = P and P._playerCard and P._playerCard._skins and P._playerCard._skins[cid]
		if sObj then
			sId = sObj:getCurrentId(Data.SkinEffectType.skin) or 0
			for _, effType in ipairs({ Data.SkinEffectType.toBoard, Data.SkinEffectType.onBoard, Data.SkinEffectType.attack }) do
				local eid = sObj:getCurrentId(effType)
				if eid and eid > 0 then
					table.insert(effs, eid)
				end
			end
		end
		if #effs == 0 and cid > 0 and lc and lc.UserDefault and lc.UserDefault.getStringForKey then
			local savedStr = lc.UserDefault:getStringForKey("card_effects_" .. cid, "")
			if savedStr ~= "" then
				local ok, sData = pcall(function() return json.decode(savedStr) end)
				if ok and type(sData) == "table" then
					for _, k in ipairs({ "toBoard", "onBoard", "attack" }) do
						local eid = tonumber(sData[k])
						if eid and eid > 0 then
							table.insert(effs, eid)
						end
					end
				end
			end
		end
		return { skin_id = sId, info_id = cid, effect_ids = effs }
	end

	local function buildOppoSkinEntryForCard(cid)
		cid = tonumber(cid) or 0
		local sId = 0
		local effs = {}
		local cinfo = Data.getInfo(cid)
		local cat = (cinfo and cinfo._category) or 0
		if cat > 0 and Data.getSkinEffectId then
			local toBoardList = Data.getSkinEffectId(cat, Data.SkinEffectType.toBoard)
			if toBoardList and #toBoardList > 1 then
				table.insert(effs, toBoardList[#toBoardList])
			end
			local onBoardList = Data.getSkinEffectId(cat, Data.SkinEffectType.onBoard)
			if onBoardList and #onBoardList > 1 then
				table.insert(effs, onBoardList[#onBoardList])
			end
		end
		return { skin_id = sId, info_id = cid, effect_ids = effs }
	end

	ClientData.sendWorldExpeditionEx = function(troopIndex, npcId, isBoss, infoId, rank)
		local oppInfo = nil
		if ClientData._expeditionOpponents and #ClientData._expeditionOpponents > 0 then
			if infoId then
				for _, op in ipairs(ClientData._expeditionOpponents) do
					if op.id == infoId then oppInfo = op; break end
				end
			end
			if not oppInfo and rank then
				for _, op in ipairs(ClientData._expeditionOpponents) do
					if op.rank == rank then oppInfo = op; break end
				end
			end
			if not oppInfo then
				if isBoss then
					for _, op in ipairs(ClientData._expeditionOpponents) do
						if op.is_boss or op.rank == 1 then oppInfo = op; break end
					end
				else
					local targetRank = (npcId or 0) + 2
					for _, op in ipairs(ClientData._expeditionOpponents) do
						if op.rank == targetRank then oppInfo = op; break end
					end
					if not oppInfo and ClientData._expeditionOpponents[2] then
						oppInfo = ClientData._expeditionOpponents[2]
					end
				end
			end
		end

		local oppName = (oppInfo and oppInfo.name) or (isBoss and "Quán Quân Top 1" or "Đối thủ Top 2")
		local oppAvatar = (oppInfo and oppInfo.avatar) or (isBoss and 201 or 101)
		local oppReward = (oppInfo and oppInfo.reward_count) or (isBoss and 300 or 100)
		ClientData._curExpeditionReward = oppReward
		ClientData._curExpeditionOppId = oppInfo and oppInfo.id
		ClientData._curExpeditionOppRank = oppInfo and oppInfo.rank

		-- Player real deck from P._playerCard._troops
		local curTroopIndex = troopIndex or (P and P._curTroopIndex) or 1
		local troopData = P and P._playerCard and P._playerCard._troops and P._playerCard._troops[curTroopIndex]
		local pCards = {}
		local pLevels = {}
		local pSkins = {}
		if troopData then
			for _, item in ipairs(troopData) do
				local cid = type(item) == "table" and (item._infoId or item.info_id) or item
				local num = type(item) == "table" and (item._num or item.num) or 1
				local lvl = type(item) == "table" and (item._level or item.level) or 1
				if cid and tonumber(cid) then
					cid = tonumber(cid)
					num = math.max(1, tonumber(num) or 1)
					lvl = tonumber(lvl) or 1
					table.insert(pCards, { info_id = cid, num = num })
					table.insert(pLevels, { info_id = cid, level = lvl })
					table.insert(pSkins, buildSkinEntryForCard(cid))
				end
			end
		end
		if #pCards == 0 then
			pCards = { { info_id = 10001, num = 3 }, { info_id = 10002, num = 3 }, { info_id = 20001, num = 3 } }
		end

		local pTroop = {
			id = (P and P._id) or 1,
			info = { id = (P and P._id) or 1, name = (P and P._name) or "Duelist", avatar = (P and P._avatar) or 201, is_npc = false },
			cards = pCards,
			levels = pLevels,
			card_extra_skills = {},
			skins = pSkins,
			troop = { cards = pCards },
			hp = 8000,
			fortress_hp = 8000
		}

		-- Opponent deck
		local oCards = {}
		local oLevels = {}
		local oSkins = {}
		if oppInfo and oppInfo.cards and #oppInfo.cards > 0 then
			local countMap = {}
			for _, c in ipairs(oppInfo.cards) do
				local cid = type(c) == "table" and (c.info_id or c._infoId) or c
				if cid and tonumber(cid) then
					cid = tonumber(cid)
					countMap[cid] = (countMap[cid] or 0) + 1
				end
			end
			for cid, num in pairs(countMap) do
				table.insert(oCards, { info_id = cid, num = num })
				table.insert(oLevels, { info_id = cid, level = 1 })
				table.insert(oSkins, buildOppoSkinEntryForCard(cid))
			end
		end
		if #oCards == 0 then
			oCards = { { info_id = 10001, num = 3 }, { info_id = 10002, num = 3 }, { info_id = 20001, num = 3 } }
		end

		local oTroop = {
			id = (oppInfo and oppInfo.id) or 2000,
			info = { id = (oppInfo and oppInfo.id) or 2000, name = oppName, avatar = oppAvatar, is_npc = true },
			cards = oCards,
			levels = oLevels,
			card_extra_skills = {},
			skins = oSkins,
			troop = { cards = oCards },
			hp = 8000,
			fortress_hp = 8000
		}

		local bType = isBoss and Battle_pb.PB_BATTLE_EXPEDITION_EX_BOSS or Battle_pb.PB_BATTLE_EXPEDITION_EX
		local battleInput = {
			level_id = 0,
			is_watcher = false,
			is_op_online = false,
			copy_id = 0,
			is_attacker = true,
			type = bType,
			timestamp = math.floor(ClientData.getCurrentTime() * 1000),
			player_troop = pTroop,
			opponent_troop = oTroop,
			player_used_cards = {},
			opponent_used_cards = {},
			random_seq = { math.random(1, 65535) },
			rule_type = Data.BattleRuleType.normal,
			_offlineMarker = true,
			_offlineKind = "expedition_ex"
		}

		local sglType = isBoss and SglMsgType_pb.PB_TYPE_WORLD_EXPEDITION_EX_BOSS or SglMsgType_pb.PB_TYPE_WORLD_EXPEDITION_EX
		local resp = {
			type = sglType,
			status = 0,
			Extensions = {
				[World_pb.SglWorldMsg.world_expedition_ex_resp] = battleInput
			},
			HasExtension = function(self, extId)
				return self.Extensions ~= nil and self.Extensions[extId] ~= nil
			end
		}
		ClientData.onMsg(resp)
	end


	-- 2. REGULAR SURVIVAL
	ClientData.sendSurvivalBuyTicket = function(ticketType)
		local chars = pickDraftCharacters()
		if P and P._playerFindSurvival then
			P._playerFindSurvival._hasTicket = true
			P._playerFindSurvival._step = 0
			P._playerFindSurvival._characterId = 0
			P._playerFindSurvival._characters = chars
			P._playerFindSurvival._troopCards = {}
			P._playerFindSurvival._selected = {}
			P._playerFindSurvival._win = 0
			P._playerFindSurvival._lose = 0
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL, World_pb.SglWorldMsg.world_buy_ticket_resp, chars)
		deliverDraftMsg(msg)
	end

	ClientData.sendSurvivalSelectCharacter = function(charId)
		local pool = generateDraftPool(charId)
		if P and P._playerFindSurvival then
			P._playerFindSurvival._characterId = charId or (P._playerFindSurvival._characters and P._playerFindSurvival._characters[1]) or 2
			P._playerFindSurvival._step = 1
			P._playerFindSurvival._cardsPool = pool
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL, World_pb.SglWorldMsg.world_select_char_resp, pool)
		deliverDraftMsg(msg)
	end

	ClientData.sendSurvivalSelectCard = function(cardIdx)
		local curStep = (P and P._playerFindSurvival and P._playerFindSurvival._step) or 1
		local nextStep = math.min(41, curStep + 1)
		if P and P._playerFindSurvival then
			P._playerFindSurvival._step = nextStep
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL, World_pb.SglWorldMsg.world_select_card_resp, nextStep)
		deliverDraftMsg(msg)
	end

	ClientData.sendSurvivalQuit = function()
		local winCount = (P and P._playerFindSurvival and P._playerFindSurvival._win) or 0
		local rewards = {
			rank = (winCount >= 10) and 1 or (winCount >= 6 and 2 or 3),
			resource = {
				{ info_id = Data.ResType.gold, num = 3000 + winCount * 800 }
			}
		}
		if P and P._playerFindSurvival then
			P._playerFindSurvival:clear()
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_SURVIVAL_GAME_OVER, World_pb.SglWorldMsg.world_survival_end_resp, rewards)
		deliverDraftMsg(msg)
	end

	-- 3. LADDER DRAFT (Đấu Trường)
	ClientData.sendLadderBuyTicket = function(ticketType)
		local chars = pickDraftCharacters()
		if P and P._playerFindLadder then
			P._playerFindLadder._hasTicket = true
			P._playerFindLadder._step = 0
			P._playerFindLadder._characterId = 0
			P._playerFindLadder._characters = chars
			P._playerFindLadder._troopCards = {}
			P._playerFindLadder._selected = {}
			P._playerFindLadder._winCount = 0
			P._playerFindLadder._loseCount = 0
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_BUY_TICKET, World_pb.SglWorldMsg.world_buy_ticket_resp, chars)
		deliverDraftMsg(msg)
	end

	ClientData.sendLadderReselectCharacter = function()
		local chars = pickDraftCharacters()
		if P and P._playerFindLadder then
			P._playerFindLadder._characters = chars
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_ROLL_CHAR, World_pb.SglWorldMsg.world_roll_char_resp, chars)
		deliverDraftMsg(msg)
	end

	ClientData.sendLadderSelectCharacter = function(charId)
		local pool = generateDraftPool(charId)
		if P and P._playerFindLadder then
			P._playerFindLadder._characterId = charId or (P._playerFindLadder._characters and P._playerFindLadder._characters[1]) or 2
			P._playerFindLadder._step = 1
			P._playerFindLadder._cardsPool = pool
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_SELECT_CHAR, World_pb.SglWorldMsg.world_select_char_resp, pool)
		deliverDraftMsg(msg)
	end

	ClientData.sendLadderSelectCard = function(cardIdx)
		local curStep = (P and P._playerFindLadder and P._playerFindLadder._step) or 1
		local nextStep = math.min(41, curStep + 1)
		if P and P._playerFindLadder then
			P._playerFindLadder._step = nextStep
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_SELECT_CARD, World_pb.SglWorldMsg.world_select_card_resp, nextStep)
		deliverDraftMsg(msg)
	end

	ClientData.sendLadderQuit = function()
		local winCount = (P and P._playerFindLadder and P._playerFindLadder._winCount) or 0
		local chestId = (Data and Data.PropsId and Data.PropsId.ladder_chest or 7000) + math.min(12, winCount) + 1
		if P and P._playerFindLadder then
			P._playerFindLadder:clear()
		end
		local msg = makeDraftSglMsg(SglMsgType_pb.PB_TYPE_WORLD_QUIT, World_pb.SglWorldMsg.world_quit_resp, {
			{ num = 1, info_id = chestId }
		})
		deliverDraftMsg(msg)
	end



	-- =========================================================================
	-- MAILBOX SYSTEM (Hòm Thư Phần Thưởng)
	-- =========================================================================
	local function loadPlayerMailsFromServer(cb)
		local myId = tonumber((ClientData._account and ClientData._account.id) or (P and P._id) or 1)
		local api = jsbridge and jsbridge.object("jdzcApi")
		if not (api and api.post) then return end
		api:post("get_mails", { account_id = myId }, function(rawRes)
			local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
			if res and res.code == 200 and res.mails then
				if P and P._playerBonus then
					P._playerBonus._serverBonuses = {}
					for _, mail in ipairs(res.mails) do
						local extraBonus = {}
						local r = mail.rewards or {}
						if r.gold and tonumber(r.gold) > 0 then
							table.insert(extraBonus, { _infoId = 1, _count = tonumber(r.gold), _level = 1, _isFragment = false })
						end
						if r.gem and tonumber(r.gem) > 0 then
							table.insert(extraBonus, { _infoId = 3, _count = tonumber(r.gem), _level = 1, _isFragment = false })
						end
						if r.gold_cup and tonumber(r.gold_cup) > 0 then
							table.insert(extraBonus, { _infoId = 7204, _count = tonumber(r.gold_cup), _level = 1, _isFragment = false })
						end
						if r.silver_cup and tonumber(r.silver_cup) > 0 then
							table.insert(extraBonus, { _infoId = 7205, _count = tonumber(r.silver_cup), _level = 1, _isFragment = false })
						end
						if r.bronze_cup and tonumber(r.bronze_cup) > 0 then
							table.insert(extraBonus, { _infoId = 7206, _count = tonumber(r.bronze_cup), _level = 1, _isFragment = false })
						end
						if r.leya_ticket and tonumber(r.leya_ticket) > 0 then
							table.insert(extraBonus, { _infoId = 7143, _count = tonumber(r.leya_ticket), _level = 1, _isFragment = false })
						end
						if (r.yubi and tonumber(r.yubi) > 0) or (r[7024] and tonumber(r[7024]) > 0) or (r["7024"] and tonumber(r["7024"]) > 0) then
							local ycnt = tonumber(r.yubi or r[7024] or r["7024"])
							table.insert(extraBonus, { _infoId = 7024, _count = ycnt, _level = 1, _isFragment = false })
						end
						if r.card_id and tonumber(r.card_id) > 0 then
							local cid = tonumber(r.card_id)
							local cnt = tonumber(r.card_count or r.count or 1)
							table.insert(extraBonus, { _infoId = cid, _count = cnt, _level = 1, _isFragment = false })
						end
						if r.cards and type(r.cards) == "table" then
							for k, v in pairs(r.cards) do
								local cid = tonumber(type(v) == "table" and (v.id or v.card_id) or k)
								local cnt = tonumber(type(v) == "table" and (v.count or v.num) or v)
								if cid and cid > 0 and cnt and cnt > 0 then
									table.insert(extraBonus, { _infoId = cid, _count = cnt, _level = 1, _isFragment = false })
								end
							end
						end
						for k, v in pairs(r) do
							if type(k) == "string" and k:sub(1, 5) == "card_" and k ~= "card_count" then
								local cid = tonumber(k:sub(6))
								local cnt = tonumber(v)
								if cid and cid > 0 and cnt and cnt > 0 then
									table.insert(extraBonus, { _infoId = cid, _count = cnt, _level = 1, _isFragment = false })
								end
							end
						end

						local bItem = {
							_id = mail.id,
							_timestamp = mail.timestamp or os.time(),
							_isClaimed = (mail.claimed == 1),
							_value = 0,
							_title = mail.title,
							_desc = mail.content,
							_extraBonus = extraBonus,
							canClaim = function(self) return not self._isClaimed end,
							sendBonusDirty = function(self)
								local ev = cc.EventCustom:new(Data.Event.server_bonus_list_dirty)
								lc.Dispatcher:dispatchEvent(ev)
							end
						}
						table.insert(P._playerBonus._serverBonuses, bItem)
					end
					table.sort(P._playerBonus._serverBonuses, function(a, b)
						if a._isClaimed ~= b._isClaimed then
							return not a._isClaimed
						end
						return (a._timestamp or 0) > (b._timestamp or 0)
					end)

					local ev = cc.EventCustom:new(Data.Event.server_bonus_list_dirty)
					lc.Dispatcher:dispatchEvent(ev)

					if ClientView and ClientView.getMenuUI then
						local menu = ClientView.getMenuUI()
						if menu and menu.updateMailFlag then
							menu:updateMailFlag()
						end
					end
				end
			end
			if cb then pcall(cb) end
		end)
	end

	_G.loadPlayerMailsFromServer = loadPlayerMailsFromServer

	ClientData.sendClaimServerBonus = function(bonusId)
		local myId = tonumber((ClientData._account and ClientData._account.id) or (P and P._id) or 1)
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("claim_mail_reward", { account_id = myId, mail_id = bonusId }, function(rawRes)
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and res.code == 200 then
					if res.account then
						if P then
							if res.account.gold ~= nil then P._gold = res.account.gold end
							if res.account.gem ~= nil then P._ingot = res.account.gem end
							if res.account.gold_cup ~= nil then P._goldCup = res.account.gold_cup end
							if res.account.yubi ~= nil and P._propBag then
								P._propBag:setProps(7024, tonumber(res.account.yubi) or 0)
								if lc and lc.Dispatcher and Data and Data.Event then
									lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.prop_dirty, { _infoId = 7024 }))
								end
							end
						end
						if ClientData._account then
							for k, v in pairs(res.account) do
								ClientData._account[k] = v
							end
						end
					end
					ToastManager.push(res.msg or "Nhận thưởng thành công!")
					if P and P._playerBonus and P._playerBonus._serverBonuses then
						for _, b in ipairs(P._playerBonus._serverBonuses) do
							if b._id == bonusId then
								b._isClaimed = true
								if b._extraBonus and P and P.addResourcesData then
									pcall(function() P:addResourcesData(b._extraBonus) end)
								end
								b:sendBonusDirty()
								break
							end
						end
					end
					local ev = cc.EventCustom:new(Data.Event.server_bonus_list_dirty)
					lc.Dispatcher:dispatchEvent(ev)
					if ClientView and ClientView.getMenuUI then
						local menu = ClientView.getMenuUI()
						if menu and menu.updateMailFlag then
							menu:updateMailFlag()
						end
					end
				else
					ToastManager.push((res and res.msg) or "Không thể nhận thưởng!")
				end
			end)
		end
	end

	pcall(function()
		local orig_replaceCityScene = ClientData.replaceCityScene
		ClientData.replaceCityScene = function(...)
			pcall(function() loadPlayerMailsFromServer() end)
			return orig_replaceCityScene(...)
		end
	end)

	ClientData.getReputation = function()
		local acc = ClientData._account
		local rep = tonumber((acc and acc.reputation) or (P and P._reputation) or 50)
		local updatedAt = tonumber((acc and acc.reputation_updated_at) or 0)
		if rep >= 55 or updatedAt <= 0 then
			return rep
		end
		local now = math.floor(ClientData.getCurrentTime())
		local elapsed = math.max(0, now - updatedAt)
		local add = math.floor(elapsed / 900)
		if add > 0 then
			rep = math.min(55, rep + add)
			if acc then
				acc.reputation = rep
				if rep >= 55 then
					acc.reputation_updated_at = now
				else
					acc.reputation_updated_at = updatedAt + add * 900
				end
			end
			if P then P._reputation = rep end
		end
		return rep
	end

	ClientData.getNextReputationIn = function()
		local acc = ClientData._account
		local rep = ClientData.getReputation()
		if rep >= 55 then return 0 end
		local updatedAt = tonumber((acc and acc.reputation_updated_at) or math.floor(ClientData.getCurrentTime()))
		local now = math.floor(ClientData.getCurrentTime())
		local elapsed = math.max(0, now - updatedAt)
		return math.max(0, 900 - (elapsed % 900))
	end

	-- Arena Matchmaking
	ClientData.sendWorldFindEx = function(troopIndex, battleType)
		local matchType = Data.FindMatchType.clash
		local offlineKind = "clash"
		local bType = Battle_pb.PB_BATTLE_WORLD_LADDER
		local sType = Data.BattleType.PVP_clash_npc
		if battleType == Battle_pb.PB_BATTLE_WORLD_LADDER_EX then
			matchType = Data.FindMatchType.ladder
			offlineKind = "ladder"
			bType = Battle_pb.PB_BATTLE_WORLD_LADDER_EX
			sType = Data.BattleType.PVP_ladder_npc
		elseif battleType == Battle_pb.PB_BATTLE_WORLD_LADDER then
			matchType = Data.FindMatchType.clash
			offlineKind = "clash"
			bType = Battle_pb.PB_BATTLE_WORLD_LADDER
			sType = Data.BattleType.PVP_clash_npc
		elseif battleType == Battle_pb.PB_BATTLE_SURVIVAL then
			matchType = Data.FindMatchType.survival
			offlineKind = "survival"
			bType = Battle_pb.PB_BATTLE_SURVIVAL
			sType = Data.BattleType.PVP_survival
		elseif battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX then
			matchType = Data.FindMatchType.survival_ex
			offlineKind = "survival_ex"
			bType = Battle_pb.PB_BATTLE_SURVIVAL_EX
			sType = Data.BattleType.PVP_survival_ex
		elseif battleType == Battle_pb.PB_BATTLE_WORLD_LEGEND then
			matchType = Data.FindMatchType.clash_ex
			offlineKind = "clash_ex"
			bType = Battle_pb.PB_BATTLE_WORLD_LEGEND
			sType = Data.BattleType.PVP_clash_npc
		end

		-- Block ranked clash if reputation < 45
		if matchType == Data.FindMatchType.clash or matchType == Data.FindMatchType.clash_ex or matchType == Data.FindMatchType.ladder then
			local myRep = ClientData.getReputation and ClientData.getReputation() or ((P and P._reputation) or 50)
			if myRep < 45 then
				local nextIn = ClientData.getNextReputationIn and ClientData.getNextReputationIn() or 900
				local mins = math.floor(nextIn / 60)
				local secs = nextIn % 60
				ToastManager.push(string.format("Điểm uy tín của bạn là %d/55 (< 45). Bạn bị cấm đấu hạng! Hồi 1 điểm sau %dp%02ds (15 phút/điểm).", myRep, mins, secs))
				local panel = ClientView._findMatchPanel
				if panel and panel.hide then panel:hide() end
				return
			end
		end

		ClientData._battleFromFindIndex = matchType
		ClientData.setBattleFromSceneId(ClientData.SceneId.find)
		ClientData._isOppoOnline = false
		ClientData._usedCardsToAdd = {}
		ClientData._observeUsedCards = {}

		local pTroop
		if battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX and P and P._playerFindSurvivalEx then
			pTroop = P._playerFindSurvivalEx:getTroopCards(nil, true)
		elseif battleType == Battle_pb.PB_BATTLE_SURVIVAL and P and P._playerFindSurvival then
			pTroop = P._playerFindSurvival:getTroopCards(nil, true)
		else
			pTroop = (P and P._playerCard and P._playerCard._troops and P._playerCard._troops[troopIndex or P._curTroopIndex or 1]) or {}
		end
		local playerCards = {}
		local playerLevels = {}
		local playerSkins = {}
		local rawCardIds = {}
		local totalPlayerCards = 0
		local pList = (type(pTroop) == "table" and (pTroop._cards or pTroop)) or {}
		for _, c in ipairs(pList) do
			local cid = (type(c) == "table" and (c._infoId or c.info_id)) or c
			local num = (type(c) == "table" and (c._num or c.num)) or 1
			local lvl = (type(c) == "table" and (c._level or c.level)) or 1
			if cid and tonumber(cid) then
				cid = tonumber(cid)
				num = math.max(1, tonumber(num) or 1)
				lvl = tonumber(lvl) or 1
				table.insert(playerCards, { info_id = cid, num = num })
				table.insert(playerLevels, { info_id = cid, level = lvl })
				table.insert(playerSkins, buildSkinEntryForCard(cid))
				for _ = 1, num do
					table.insert(rawCardIds, cid)
					totalPlayerCards = totalPlayerCards + 1
				end
			end
		end

		local fallbackCids = (Data._troopInfo and Data._troopInfo[1] and Data._troopInfo[1]._infoId) or { 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 20001, 20002, 20003, 20004, 20005, 30001, 30002, 30003 }
		while totalPlayerCards < 40 do
			for _, cid in ipairs(fallbackCids) do
				if totalPlayerCards >= 40 then break end
				table.insert(playerCards, { info_id = cid, num = 1 })
				table.insert(playerLevels, { info_id = cid, level = 1 })
				table.insert(playerSkins, buildSkinEntryForCard(cid))
				table.insert(rawCardIds, cid)
				totalPlayerCards = totalPlayerCards + 1
			end
		end

		if battleType == Battle_pb.PB_BATTLE_SURVIVAL or battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX then
			local myChar = (battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX and P and P._playerFindSurvivalEx and P._playerFindSurvivalEx._characterId) or (battleType == Battle_pb.PB_BATTLE_SURVIVAL and P and P._playerFindSurvival and P._playerFindSurvival._characterId) or 2
			local charCards = (myChar and CHAR_CARDS_MAP[tonumber(myChar)]) or (myChar and CHAR_CARDS_MAP[tostring(myChar)])
			if charCards then
				for _, cid in ipairs(charCards) do
					cid = tonumber(cid)
					if cid and cid >= 40000 then
						table.insert(playerCards, { info_id = cid, num = 1 })
						table.insert(playerLevels, { info_id = cid, level = 1 })
						table.insert(playerSkins, buildSkinEntryForCard(cid))
					end
				end
			end
		end

		local grade = (P and P._playerFindClash and P._playerFindClash._grade) or 1
		local sceneType = 10 + math.max(1, math.min(6, tonumber(grade) or 1))

		local function startWithOppo(oppoName, oppoLevel, oppoAvatar, oppoCardIds, seed, isRealHuman, matchId, isAttacker, isOppoOnline, oppoCrown, oppoTrophy)
			local oppoCards = {}
			local oppoLevels = {}
			local oppoSkins = {}
			local oppoCount = 0
			local rawCardIds = oppoCardIds or {}
			local function addOneOppoCid(cid)
				if cid and tonumber(cid) then
					cid = tonumber(cid)
					table.insert(oppoCards, { info_id = cid, num = 1 })
					table.insert(oppoLevels, { info_id = cid, level = 1 })
					table.insert(oppoSkins, buildOppoSkinEntryForCard(cid))
					oppoCount = oppoCount + 1
				end
			end
			if type(rawCardIds) == "table" then
				local numKeys = {}
				for k in pairs(rawCardIds) do
					if tonumber(k) then table.insert(numKeys, tonumber(k)) end
				end
				if #numKeys > 0 then
					table.sort(numKeys)
					for _, k in ipairs(numKeys) do
						addOneOppoCid(rawCardIds[k] or rawCardIds[tostring(k)])
					end
				else
					for _, v in pairs(rawCardIds) do
						addOneOppoCid(v)
					end
				end
			end
			while oppoCount < 40 do
				for _, cid in ipairs(fallbackCids) do
					if oppoCount >= 40 then break end
					table.insert(oppoCards, { info_id = cid, num = 1 })
					table.insert(oppoLevels, { info_id = cid, level = 1 })
					table.insert(oppoSkins, buildOppoSkinEntryForCard(cid))
					oppoCount = oppoCount + 1
				end
			end

			if battleType == Battle_pb.PB_BATTLE_SURVIVAL or battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX then
				local oppoCharId = math.floor((oppoAvatar or 201) / 100)
				local oCharCards = (oppoCharId and CHAR_CARDS_MAP[tonumber(oppoCharId)]) or (oppoCharId and CHAR_CARDS_MAP[tostring(oppoCharId)])
				if oCharCards then
					for _, cid in ipairs(oCharCards) do
						cid = tonumber(cid)
						if cid and cid >= 40000 then
							table.insert(oppoCards, { info_id = cid, num = 1 })
							table.insert(oppoLevels, { info_id = cid, level = 1 })
							table.insert(oppoSkins, buildOppoSkinEntryForCard(cid))
						end
					end
				end
			end

			local isBotMatch = (not isRealHuman) or (not isOppoOnline) or (matchId == nil) or (string.find(tostring(matchId), "bot_") ~= nil)
			local isOnlinePvp = (isRealHuman == true and isOppoOnline == true and matchId ~= nil and not isBotMatch)
			local myIsAttacker = (isAttacker == true)
			if not isOnlinePvp then
				myIsAttacker = true
			end

			ClientData._isOppoOnline = isOnlinePvp
			ClientData._currentMatchId = isOnlinePvp and matchId or nil
			ClientData._usedCardsToAdd = {}
			ClientData._observeUsedCards = {}

			local battleInput = {
				_levelId = 0,
				_copyId = 0,
				_isTesting = not isOnlinePvp,
				_offlineMode = not isOnlinePvp,
				_isOppoOnline = isOnlinePvp,
				_pvpMatch = isOnlinePvp,
				_matchId = isOnlinePvp and matchId or nil,
				_isAttacker = myIsAttacker,
				_isWatcher = false,
				_speedFactor = 1,
				_type = bType,
				_battleType = sType,
				_sceneType = sceneType,
				_timestamp = math.floor(ClientData.getCurrentTime() * 1000),
				_randomSeed = seed or math.random(1, 65535),
				_ruleType = Data.BattleRuleType.normal,
				_offlineKind = offlineKind,
				_clashGrade = grade,
				_eventIds = {},
				_oppoEventIds = {},
				_player = {
					_region = 1,
					_level = (P and P._level) or 50,
					_monthCardType = 0,
					_roundTimeInit = isOnlinePvp and 60 or 0,
					_roundTimeMax = isOnlinePvp and 120 or 0,
					_roundTimeDelta = isOnlinePvp and ((P and P._isNewRound and 6) or 6) or 0,
					_fortressHp = 8000,
					_avatarFrameId = 0,
					_isNewRound = isOnlinePvp and ((P and P._isNewRound) or false) or false,
					_idInRoom = 0,
					_bossId = 0,
					_privilege = 0,
					_avatarFrameCount = 0,
					_regionId = 1,
					_avatarFrame = 0,
					_vip = (P and P._vip) or 0,
					_id = (P and P._id) or 1,
					_name = (P and P._name) or "Player",
					_avatar = (function()
						local myChar = (battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX and P and P._playerFindSurvivalEx and P._playerFindSurvivalEx._characterId) or (battleType == Battle_pb.PB_BATTLE_SURVIVAL and P and P._playerFindSurvival and P._playerFindSurvival._characterId)
						if myChar and myChar > 0 then
							return myChar * 100 + 1
						end
						local av = (P and P._avatar) or 301
						if av < 100 then av = av * 100 + 1 end
						return av
					end)(),
					_crown = (P and P._crown) or (function()
						if ClientData and ClientData._account then
							local gc = tonumber(ClientData._account.gold_cup) or 0
							local sc = tonumber(ClientData._account.silver_cup) or 0
							local bc = tonumber(ClientData._account.bronze_cup) or 0
							if gc > 0 then return { _infoId = 7204, _num = gc }
							elseif sc > 0 then return { _infoId = 7205, _num = sc }
							elseif bc > 0 then return { _infoId = 7206, _num = bc }
							end
						end
						return nil
					end)(),
					_cardBackId = (P and P._cardBackId) or Data.PropsId.card_back,
					_isNpc = false,
					_troopCards = playerCards,
					_troopLevels = playerLevels,
					_troopSkins = playerSkins,
					_usedCards = {},
					_trophy = (P and P._playerFindClash and P._playerFindClash._trophy) or 800
				},
				_opponent = {
					_region = 1,
					_level = oppoLevel or 50,
					_monthCardType = 0,
					_roundTimeInit = isOnlinePvp and 60 or 0,
					_roundTimeMax = isOnlinePvp and 120 or 0,
					_roundTimeDelta = isOnlinePvp and ((P and P._isNewRound and 6) or 6) or 0,
					_fortressHp = 8000,
					_avatarFrameId = 0,
					_isNewRound = isOnlinePvp and ((P and P._isNewRound) or false) or false,
					_idInRoom = 0,
					_bossId = 0,
					_privilege = 0,
					_avatarFrameCount = 0,
					_regionId = 1,
					_avatarFrame = 0,
					_vip = 0,
					_id = 0,
					_name = oppoName or "Duelist",
					_avatar = oppoAvatar or (math.random(1, 4) * 100 + 1),
					_crown = oppoCrown,
					_cardBackId = 7600,
					_isNpc = not isOnlinePvp,
					_troopCards = oppoCards,
					_troopLevels = oppoLevels,
					_troopSkins = oppoSkins,
					_usedCards = {},
					_trophy = tonumber(oppoTrophy) or ((P and P._playerFindClash and P._playerFindClash._trophy) or 800)
				}
			}

			if isOnlinePvp then
				local pvpNet = jsbridge and jsbridge.object("jdzcPvp")
				if pvpNet then
					local myId = tonumber((ClientData._account and ClientData._account.id) or (P and P._id) or 1)
					pvpNet:connect(matchId, myId, myIsAttacker, function(intsJson, addTime, maxTime, timeLeft)
						local ok, ints = pcall(json.decode, intsJson)
						if ok and type(ints) == "table" and #ints > 0 then
							local card_val = tonumber(ints[1]) or 0
							local isCardAction = (card_val ~= BattleData.UseCardId.round and card_val ~= BattleData.UseCardId.retreat and card_val ~= 0)
							local bonusSec = tonumber(addTime) or (isCardAction and 6 or 0)
							local maxSec = tonumber(maxTime) or 120
							local exactTime = tonumber(timeLeft)

							local scene = lc._runningScene or ClientView._scene
							local bUi = scene and scene._battleUi

							-- Đồng bộ cơ chế tối ưu thời gian: Màn hình đối thủ tăng time ngay lập tức khi nhận action từ server!
							if isCardAction and bUi then
								if exactTime and exactTime > 0 and type(bUi.syncPvpRoundSeconds) == "function" then
									bUi:syncPvpRoundSeconds(exactTime)
								elseif bonusSec > 0 and type(bUi.addPvpRoundSeconds) == "function" then
									bUi:addPvpRoundSeconds(bonusSec, maxSec)
								end
							end

							ClientData._usedCardsToAdd = ClientData._usedCardsToAdd or {}
							for _, val in ipairs(ints) do
								table.insert(ClientData._usedCardsToAdd, tonumber(val) or 0)
							end
							local handled = false
							if bUi and type(bUi.oppoTryUseCard) == "function" then
								handled = bUi:oppoTryUseCard()
							end
						end
					end, function()
						local scene = lc._runningScene or ClientView._scene
						local bUi = scene and scene._battleUi
						if bUi and not bUi._isBattleEndSended then
							bUi._forceResult = Data.BattleResult.win
							bUi:hideThinking()
							if bUi._opponent and type(bUi.retreat) == "function" then
								bUi:retreat(bUi._opponent)
							else
								bUi:sendBattleEnd(false, Data.BattleResult.win)
							end
							ToastManager.push("Đối thủ đã rời trận, bạn đã giành chiến thắng!")
						end
					end, function(peerResult)
						local scene = lc._runningScene or ClientView._scene
						local bUi = scene and scene._battleUi
						if bUi and not bUi._isBattleEndSended then
							local oppoHp = bUi._opponent and bUi._opponent._fortress and bUi._opponent._fortress._hp
							local playerHp = bUi._player and bUi._player._fortress and bUi._player._fortress._hp
							local myRes = (tostring(peerResult) == "1" and Data.BattleResult.win or Data.BattleResult.lose)
							if oppoHp and oppoHp <= 0 and (not playerHp or playerHp > 0) then
								myRes = Data.BattleResult.win
							elseif playerHp and playerHp <= 0 and (not oppoHp or oppoHp > 0) then
								myRes = Data.BattleResult.lose
							end
							bUi._forceResult = myRes
							bUi:sendBattleEnd(false, myRes)
						end
					end, function(chatMsg)
						local scene = lc._runningScene or ClientView._scene
						local bUi = scene and scene._battleUi
						if bUi and bUi._opponent and bUi.addChat then
							bUi:addChat(bUi._opponent, tostring(chatMsg))
						end
					end)
				end
			end

			local panel = ClientView._findMatchPanel
			if panel and type(panel.onFind) == "function" then
				panel:onFind(battleInput)
			elseif lc._runningScene and type(lc._runningScene.onBattleRecover) == "function" then
				lc._runningScene:onBattleRecover(battleInput)
			end
		end

		-- Request real player matchmaking via server
		ClientData._isFindingMatch = true
		ClientData._findMatchSeq = (ClientData._findMatchSeq or 0) + 1
		local curSeq = ClientData._findMatchSeq
		local myAvatar = (function()
			local myChar = (battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX and P and P._playerFindSurvivalEx and P._playerFindSurvivalEx._characterId) or (battleType == Battle_pb.PB_BATTLE_SURVIVAL and P and P._playerFindSurvival and P._playerFindSurvival._characterId)
			if myChar and myChar > 0 then
				return myChar * 100 + 1
			end
			local av = (P and P._avatar) or 301
			if av < 100 then av = av * 100 + 1 end
			return av
		end)()
		local myId = tonumber((ClientData._account and ClientData._account.id) or (P and P._id) or 1)

		local api = jsbridge and jsbridge.object("jdzcApi")
		-- SURVIVAL EX & SURVIVAL (Sinh Tử Chiến - Dedicated Port 8085 Room)
		if battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX or battleType == Battle_pb.PB_BATTLE_SURVIVAL then
			local myId = tonumber((ClientData._account and ClientData._account.id) or (P and P._id) or 1)
			local myChar = (battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX and P and P._playerFindSurvivalEx and P._playerFindSurvivalEx._characterId) or (battleType == Battle_pb.PB_BATTLE_SURVIVAL and P and P._playerFindSurvival and P._playerFindSurvival._characterId) or 2
			local reqPayload = {
				account_id = myId,
				name = (P and P._name) or "Player",
				level = (P and P._level) or 50,
				avatar = myAvatar,
				cards = rawCardIds,
				extra_cards = {},
				character_id = myChar,
				gold_cup = tonumber((ClientData._account and ClientData._account.gold_cup) or 0) or 0,
				silver_cup = tonumber((ClientData._account and ClientData._account.silver_cup) or 0) or 0,
				bronze_cup = tonumber((ClientData._account and ClientData._account.bronze_cup) or 0) or 0
			}

			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.post then
				api:post("survival/join", reqPayload, function(rawRes)
					if not ClientData._isFindingMatch or ClientData._findMatchSeq ~= curSeq then
						return
					end
					local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
					if res and res.code == 200 then
						local roomId = res.room_id
						local curPanel = ClientView._findMatchPanel
						if res.player_count then
							if P and P._playerFindSurvivalEx then P._playerFindSurvivalEx._hallUserNum = res.player_count end
							if P and P._playerFindSurvival then P._playerFindSurvival._hallUserNum = res.player_count end
							if curPanel and curPanel._userCountLabel then
								curPanel._userCountLabel:setString(tostring(res.player_count) .. " / 25")
							end
							pcall(function() lc.sendEvent(Data.Event.survival_ex_info_dirty) end)
							pcall(function() lc.sendEvent(Data.Event.survival_info_dirty) end)
						end

						if res.status == "matched" and res.oppo then
							local oppo = res.oppo
							startWithOppo(oppo.name, oppo.level, oppo.avatar, oppo.cards, res.seed, res.is_real_player, res.match_id, res.is_attacker, res.oppo_online, nil, oppo.trophy)
							return
						end

						local pollEntry
						local isFinished = false
						pollEntry = lc.Scheduler:scheduleScriptFunc(function()
							if not ClientData._isFindingMatch or ClientData._findMatchSeq ~= curSeq or isFinished then
								if pollEntry then lc.Scheduler:unscheduleScriptEntry(pollEntry) end
								return
							end
							api:post("survival/poll", { account_id = myId, room_id = roomId }, function(rawPoll)
								if not ClientData._isFindingMatch or ClientData._findMatchSeq ~= curSeq or isFinished then
									if pollEntry then lc.Scheduler:unscheduleScriptEntry(pollEntry) end
									return
								end
								local pRes = (type(rawPoll) == "string") and json.decode(rawPoll) or rawPoll
								if pRes and pRes.code == 200 then
									local pPanel = ClientView._findMatchPanel
									if pRes.player_count then
										if P and P._playerFindSurvivalEx then P._playerFindSurvivalEx._hallUserNum = pRes.player_count end
										if P and P._playerFindSurvival then P._playerFindSurvival._hallUserNum = pRes.player_count end
										if pPanel and pPanel._userCountLabel then
											pPanel._userCountLabel:setString(tostring(pRes.player_count) .. " / 25")
										end
										pcall(function() lc.sendEvent(Data.Event.survival_ex_info_dirty) end)
										pcall(function() lc.sendEvent(Data.Event.survival_info_dirty) end)
									end
									if pRes.status == "matched" and pRes.oppo then
										isFinished = true
										if pollEntry then lc.Scheduler:unscheduleScriptEntry(pollEntry) end
										local oppo = pRes.oppo
										startWithOppo(oppo.name, oppo.level, oppo.avatar, oppo.cards, pRes.seed, pRes.is_real_player, pRes.match_id, pRes.is_attacker, pRes.oppo_online, nil, oppo.trophy)
									end
								end
							end)
						end, 1.0, false)
						ClientData._survivalPollEntry = pollEntry
						ClientData._currentSurvivalRoomId = roomId
					end
				end)
			end
			return
		end

		local reqPayload = {
			account_id = myId,
			name = (P and P._name) or "Player",
			level = (P and P._level) or 50,
			avatar = myAvatar,
			cards = rawCardIds,
			mode = offlineKind,
			battle_type = battleType,
			find_strong = (ClientData._findStrongOpponent == true)
		}

		if api and api.post then
			api:post("pvp_match", reqPayload, function(rawRes)
				if not ClientData._isFindingMatch or ClientData._findMatchSeq ~= curSeq then
					print("[PVP] Match response ignored because find was cancelled.")
					return
				end
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and (res.code == 403 or res.status == "reputation_low") then
					print("[PVP] Blocked by reputation ban.")
					ClientData._isFindingMatch = false
					local panel = ClientView._findMatchPanel
					if panel and panel.hide then
						panel:hide()
					end
					if res.reputation then
						if P then P._reputation = tonumber(res.reputation) end
						if ClientData._account then ClientData._account.reputation = tonumber(res.reputation) end
					end
					ToastManager.push(res.msg or "Điểm uy tín dưới 45, bạn bị cấm đấu hạng!")
					return
				end
				if res and res.status == "cancelled" then
					print("[PVP] Server confirmed matchmaking cancelled.")
					ClientData._isFindingMatch = false
					local panel = ClientView._findMatchPanel
					if panel and panel.hide then
						panel:hide()
					end
					return
				end
				if res and res.oppo then
					local o = res.oppo
					local oppoCrown = nil
					if o then
						local ogc = tonumber(o.gold_cup) or 0
						local osc = tonumber(o.silver_cup) or 0
						local obc = tonumber(o.bronze_cup) or 0
						if ogc > 0 then oppoCrown = { _infoId = 7204, _num = ogc }
						elseif osc > 0 then oppoCrown = { _infoId = 7205, _num = osc }
						elseif obc > 0 then oppoCrown = { _infoId = 7206, _num = obc }
						end
					end
					startWithOppo(o.name, o.level, o.avatar, o.cards, res.seed, res.is_real_player, res.match_id, res.is_attacker, res.oppo_online, oppoCrown, o.trophy)
				else
					local isSurv = (battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX or battleType == Battle_pb.PB_BATTLE_SURVIVAL)
					local botChars = { 2, 3, 4, 5, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
					local botChar = isSurv and botChars[math.random(1, #botChars)] or 2
					local botAvatar = botChar * 100 + 1
					local botNames = isSurv and { "Đấu Sĩ Sinh Tử", "Thợ Săn Bài", "Kẻ Thách Thức", "Hiệp Sĩ Hoàng Gia", "Chiến Binh Sinh Tồn" } or { "Vua Trò Chơi" }
					local botName = botNames[math.random(1, #botNames)]
					startWithOppo(botName, 50, botAvatar, nil, nil, false, nil, true, false, nil, 800)
				end
			end)
		else
			local isSurv = (battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX or battleType == Battle_pb.PB_BATTLE_SURVIVAL)
			local botChars = { 2, 3, 4, 5, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
			local botChar = isSurv and botChars[math.random(1, #botChars)] or 2
			local botAvatar = botChar * 100 + 1
			local botNames = isSurv and { "Đấu Sĩ Sinh Tử", "Thợ Săn Bài", "Kẻ Thách Thức", "Hiệp Sĩ Hoàng Gia", "Chiến Binh Sinh Tồn" } or { "Vua Trò Chơi" }
			local botName = botNames[math.random(1, #botNames)]
			startWithOppo(botName, 50, botAvatar, nil, nil, false, nil, true, false, nil, 800)
		end
	end

	ClientData.sendWorldFindExCancel = function()
		if ClientData._currentSurvivalRoomId then
			local myId = tonumber((ClientData._account and ClientData._account.id) or (P and P._id) or 1)
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.post then
				api:post("survival/cancel", { account_id = myId, room_id = ClientData._currentSurvivalRoomId })
			end
			if ClientData._survivalPollEntry then
				pcall(function() lc.Scheduler:unscheduleScriptEntry(ClientData._survivalPollEntry) end)
				ClientData._survivalPollEntry = nil
			end
			ClientData._currentSurvivalRoomId = nil
		end
		ClientData._isFindingMatch = false
		ClientData._findMatchSeq = (ClientData._findMatchSeq or 0) + 1
		local myId = tonumber((ClientData._account and ClientData._account.id) or (P and P._id) or 1)
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("cancel_pvp_match", { account_id = myId })
		end
		local panel = ClientView._findMatchPanel
		if panel and panel.hide then
			panel:hide()
		end
	end

	-- PVP REAL-TIME ACTION HOOK & MOVE RECORDER FOR REPLAYS
	local orig_sendBattleUseCard = ClientData.sendBattleUseCard
	ClientData.sendBattleUseCard = function(player, card_id, target_id, choice, extra)
		local isCardAction = (card_id ~= BattleData.UseCardId.round and card_id ~= BattleData.UseCardId.retreat)
		local scene = lc._runningScene or ClientView._scene
		local bUi = scene and scene._battleUi
		if isCardAction and bUi and bUi._isOnlinePvp and type(bUi.addPvpRoundSeconds) == "function" then
			bUi:addPvpRoundSeconds(6, 120)
		elseif isCardAction and player and player._isOnlinePvp and type(player.addRoundDuration) == "function" then
			player:addRoundDuration()
		end

		if (ClientData._isOppoOnline or ClientData._currentMatchId) and ClientData._currentMatchId then
			local pvpNet = jsbridge and jsbridge.object("jdzcPvp")
			if pvpNet then
				local ints = {}
				local card_val = card_id
				if B and type(B.extendId) == "function" and player then
					card_val = B.extendId(player, card_id)
				end
				local target_val = target_id or 0
				if extra ~= nil and B and type(B.tableCount) == "function" then
					target_val = target_val + B.tableCount(extra) * 10000
				end
				table.insert(ints, card_val)
				table.insert(ints, target_val)
				table.insert(ints, choice or 0)
				table.insert(ints, math.floor(ClientData.getCurrentTime() or os.time()))
				if card_id == BattleData.UseCardId.round then
					table.insert(ints, 0)
					table.insert(ints, 0)
					table.insert(ints, 0)
				elseif extra ~= nil and type(extra) == "table" then
					for k, v in pairs(extra) do
						table.insert(ints, k)
						table.insert(ints, (type(v) == "table" and #v) or 0)
						if type(v) == "table" then
							for _, item in ipairs(v) do
								table.insert(ints, item)
							end
						end
					end
				end
				local curTimeLeft = nil
				if bUi and bUi._roundRealStartTime then
					local totalDur = bUi._roundDuration or 60
					curTimeLeft = math.max(0, totalDur - (os.time() - bUi._roundRealStartTime))
				end
				pcall(function()
					pvpNet:sendAction(ClientData._currentMatchId, json.encode(ints), curTimeLeft)
				end)
			end
		end
		if type(orig_sendBattleUseCard) == "function" then
			return orig_sendBattleUseCard(player, card_id, target_id, choice, extra)
		end
	end

	local orig_sendBattleOppoUseCard = ClientData.sendBattleOppoUseCard
	ClientData.sendBattleOppoUseCard = function(oppo, card_id, target_id, choice, extra)
		if type(orig_sendBattleOppoUseCard) == "function" then
			return orig_sendBattleOppoUseCard(oppo, card_id, target_id, choice, extra)
		end
	end




	-- Complete Shop & Tavern functions for Web H5
	local function doBuyShopCard(shopType, productId, count)
		count = count or 1
		pcall(function()
			local cardId = 0
			local cost = 0
			local costType = 1 -- 1 = gold, 3 = gem

			if shopType == "depot" then
				local prod = Data._productsExInfo and (Data._productsExInfo[productId] or (function()
					for _, item in pairs(Data._productsExInfo) do
						if item._id == productId then return item end
					end
				end)())
				cardId = prod and (prod._cardId or prod._infoId) or (productId == 59 and 40209 or 0)
				cost = prod and (prod._price or prod._cost) or (productId == 59 and 200000 or 0)
				costType = prod and prod._resType or 1
				if cardId == 20005 then cost = 5000
				elseif cardId == 20051 or cardId == 20030 then cost = 100000
				elseif cardId == 40209 then cost = 200000
				elseif cardId == 40713 or cardId == 12248 then cost = 500000
				elseif productId and productId >= 64 and cost == 0 then cost = 20000
				end
			elseif shopType == "rare" then
				local prod = Data._rareProductsInfo and (Data._rareProductsInfo[productId] or (function()
					for _, item in pairs(Data._rareProductsInfo) do
						if item._id == productId then return item end
					end
				end)())
				cardId = prod and (prod._cardId or prod._infoId) or 0
				cost = prod and (prod._price or prod._cost) or 0
				costType = prod and prod._resType or 1
				if P and P._playerMarket and P._playerMarket._rareGoodsMap then
					P._playerMarket._rareGoodsMap[productId] = 1
				end
			elseif shopType == "diamond" then
				local prod = Data._diamondProductsInfo and (Data._diamondProductsInfo[productId] or (function()
					for _, item in pairs(Data._diamondProductsInfo) do
						if item._id == productId then return item end
					end
				end)())
				cardId = prod and (prod._cardId or prod._infoId) or 0
				cost = prod and (prod._price or prod._cost) or 0
				costType = prod and prod._resType or 3
				if cardId == 12330 or productId == 546 or productId == 12330 then
					cardId = 12330
					cost = 7000
					costType = 3
				end
			elseif shopType == "union" then
				local prod = Data._unionProductsExInfo and (Data._unionProductsExInfo[productId] or (function()
					for _, item in pairs(Data._unionProductsExInfo) do
						if item._id == productId then return item end
					end
				end)())
				cardId = prod and (prod._cardId or prod._infoId) or 20230
				cost = prod and (prod._price or prod._cost) or 20000
				costType = prod and prod._resType or 7024
			elseif shopType == "collect" then
				local prod = Data._collectProducts and (Data._collectProducts[productId] or (function()
					for _, item in pairs(Data._collectProducts) do
						if item._id == productId then return item end
					end
				end)())
				cardId = prod and (prod._cardId or prod._infoId) or 0
				cost = prod and (prod._price or prod._cost) or 0
				costType = prod and prod._resType or 1
			elseif shopType == "ancient" then
				local prod = Data._ancientProductsInfo and (Data._ancientProductsInfo[productId] or (function()
					for _, item in pairs(Data._ancientProductsInfo) do
						if item._id == productId then return item end
					end
				end)())
				cardId = prod and (prod._cardId or prod._infoId) or 0
				cost = prod and (prod._price or prod._cost) or 0
				costType = prod and prod._resType or 1
			elseif shopType == "vote" then
				local prod = Data._voteProductsInfo and (Data._voteProductsInfo[productId] or (function()
					for _, item in pairs(Data._voteProductsInfo) do
						if item._id == productId then return item end
					end
				end)())
				cardId = prod and (prod._cardId or prod._infoId) or 0
				cost = prod and (prod._price or prod._cost) or 0
				costType = prod and prod._resType or 1
			elseif shopType == "goods" then
				local prod = Data._productsInfo and (Data._productsInfo[productId] or (function()
					for _, item in pairs(Data._productsInfo) do
						if item._id == productId then return item end
					end
				end)())
				cardId = prod and (prod._cardId or prod._infoId) or 0
				cost = prod and (prod._price or prod._cost) or 0
				costType = prod and prod._resType or 1
			elseif shopType == "privilege" or shopType == "month_card5" then
				local prod = Data._monthCard5ProductsInfo and (Data._monthCard5ProductsInfo[productId] or (function()
					for _, item in pairs(Data._monthCard5ProductsInfo) do
						if item._id == productId then return item end
					end
				end)())
				cardId = prod and (prod._cardId or prod._infoId) or 0
				cost = prod and (prod._price or prod._cost) or 0
				costType = prod and prod._resType or 3
				if cardId == 12330 or productId == 15 or productId == 12330 then
					cardId = 12330
					cost = 7000
					costType = 3
				end
			end

			local totalCost = cost * count
			local api = jsbridge and jsbridge.object("jdzcApi")
			local reqFn = api and (api.request or api.post)
			if reqFn then
				local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
				reqFn(api, "buy_card", {
					account_id = accId,
					shop_type = shopType,
					product_id = productId,
					depot_id = productId,
					card_id = cardId,
					cost = totalCost,
					cost_type = costType,
					count = count
				}, function(rawRes)
					local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
					if res and res.code == 200 then
						local retCardId = res.card_id or cardId
						if retCardId and retCardId > 0 and P and P._playerCard and res.count then
							local curC = P._playerCard:getCardCount(retCardId)
							if curC < res.count then
								P._playerCard:addCard(retCardId, res.count - curC)
							end
						end
						if res.gold ~= nil and P then P._gold = res.gold end
						if res.gem ~= nil and P then
							P._gem = res.gem
							P._ingot = res.gem
						end
						if res.yubi ~= nil and P and P._propBag then
							P._propBag:setProps(7024, tonumber(res.yubi) or 0)
							if lc and lc.Dispatcher and Data and Data.Event then
								lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.prop_dirty, { _infoId = 7024 }))
							end
						end
						if lc and lc.Dispatcher and Data and Data.Event then
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.gold_dirty))
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.ingot_dirty))
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.card_dirty))
						end
					end
				end)
			end
		end)
		return true
	end

	ClientData.sendBuyDepot = function(id) return doBuyShopCard("depot", id, 1) end
	ClientData.sendBuyRare = function(id) return doBuyShopCard("rare", id, 1) end
	ClientData.sendBuyDiamond = function(id) return doBuyShopCard("diamond", id, 1) end
	ClientData.sendBuyUnion = function(id) return doBuyShopCard("union", id, 1) end
	ClientData.sendBuyCollect = function(id) return doBuyShopCard("collect", id, 1) end
	ClientData.sendBuyAncient = function(id) return doBuyShopCard("ancient", id, 1) end
	ClientData.sendBuyVote = function(id) return doBuyShopCard("vote", id, 1) end
	ClientData.sendBuyGoods = function(id, count) return doBuyShopCard("goods", id, count) end
	ClientData.sendBuyMonthCard5Product = function(id) return doBuyShopCard("privilege", id, 1) end
	ClientData.sendBuyPrivilege = function(id) return doBuyShopCard("privilege", id, 1) end
	ClientData.sendBuySkin = function(skinId, skinType)
		local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local sid = tonumber(skinId) or 0
		local sInfo = Data._skinInfo and Data._skinInfo[sid]
		local price = (sInfo and sInfo._price) or 100
		local cardId = (sInfo and sInfo._infoId) or 0
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("buy_skin", {
				account_id = myAccId,
				skin_id = sid,
				skin_type = skinType or 0,
				price = price,
				card_id = cardId
			}, function(rawRes)
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and res.code == 200 then
					if res.gem ~= nil and P then
						P._ingot = tonumber(res.gem) or P._ingot
						P:sendIngotDirty()
					end
				end
			end)
		end
		return true
	end
	ClientData.sendBuyPackage = function(packageId, count) return true end

	local PACK_TITLES = {
		[1] = "Gói Bài Rồng Trắng", [10201] = "Gói Bài Rồng Trắng", [10210] = "Gói Bài Rồng Trắng", [10250] = "Gói Bài Rồng Trắng",
		[2] = "Gói Bài Rồng Đen", [10301] = "Gói Bài Rồng Đen", [10310] = "Gói Bài Rồng Đen", [10350] = "Gói Bài Rồng Đen",
		[3] = "Gói Bài Phù Thủy Áo Đen", [10401] = "Gói Bài Phù Thủy Áo Đen", [10410] = "Gói Bài Phù Thủy Áo Đen", [10450] = "Gói Bài Phù Thủy Áo Đen",
		[4] = "Gói Bài Thánh Kỵ", [10501] = "Gói Bài Thánh Kỵ", [10510] = "Gói Bài Thánh Kỵ", [10550] = "Gói Bài Thánh Kỵ",
		[5] = "Gói Bài Anh Hùng Nguyên Tố", [10601] = "Gói Bài Anh Hùng Nguyên Tố", [10610] = "Gói Bài Anh Hùng Nguyên Tố", [10650] = "Gói Bài Anh Hùng Nguyên Tố",
		[6] = "Gói Bài Anh Hùng Định Mệnh", [10701] = "Gói Bài Anh Hùng Định Mệnh", [10710] = "Gói Bài Anh Hùng Định Mệnh", [10750] = "Gói Bài Anh Hùng Định Mệnh",
		[7] = "Gói Bài Đồng Bộ", [10801] = "Gói Bài Đồng Bộ", [10810] = "Gói Bài Đồng Bộ", [10850] = "Gói Bài Đồng Bộ",
		[8] = "Gói Bài Cánh Đen", [10901] = "Gói Bài Cánh Đen", [10910] = "Gói Bài Cánh Đen", [10950] = "Gói Bài Cánh Đen",
		[9] = "Gói Bài Ngân Hà", [11001] = "Gói Bài Ngân Hà", [11010] = "Gói Bài Ngân Hà", [11050] = "Gói Bài Ngân Hà",
		[10] = "Gói Bài Utopia", [11101] = "Gói Bài Utopia", [11110] = "Gói Bài Utopia", [11150] = "Gói Bài Utopia",
		[11] = "Gói Bài Rồng Điện Tử", [11201] = "Gói Bài Rồng Điện Tử", [11210] = "Gói Bài Rồng Điện Tử", [11250] = "Gói Bài Rồng Điện Tử",
		[12] = "Gói Bài Ojama", [11301] = "Gói Bài Ojama", [11310] = "Gói Bài Ojama", [11350] = "Gói Bài Ojama",
		[13] = "Gói Bài Khủng Long", [11401] = "Gói Bài Khủng Long", [11410] = "Gói Bài Khủng Long", [11450] = "Gói Bài Khủng Long",
		[14] = "Gói Bài Thú Có Cánh", [11501] = "Gói Bài Thú Có Cánh", [11510] = "Gói Bài Thú Có Cánh", [11550] = "Gói Bài Thú Có Cánh",
		[15] = "Gói Bài Toon", [11601] = "Gói Bài Toon", [11610] = "Gói Bài Toon", [11650] = "Gói Bài Toon",
		[16] = "Gói Bài Thế Giới Bóng Tối", [11701] = "Gói Bài Thế Giới Bóng Tối", [11710] = "Gói Bài Thế Giới Bóng Tối", [11750] = "Gói Bài Thế Giới Bóng Tối",
		[17] = "Gói Bài Lục Vũ Chúng", [11801] = "Gói Bài Lục Vũ Chúng", [11810] = "Gói Bài Lục Vũ Chúng", [11850] = "Gói Bài Lục Vũ Chúng",
		[18] = "Gói Bài Thiên Thần Sa Ngã", [11901] = "Gói Bài Thiên Thần Sa Ngã", [11910] = "Gói Bài Thiên Thần Sa Ngã", [11950] = "Gói Bài Thiên Thần Sa Ngã",
		[19] = "Gói Bài Cơ Khí Cổ Đại", [12001] = "Gói Bài Cơ Khí Cổ Đại", [12010] = "Gói Bài Cơ Khí Cổ Đại", [12050] = "Gói Bài Cơ Khí Cổ Đại",
		[20] = "Gói Bài Amazoness", [12101] = "Gói Bài Amazoness", [12110] = "Gói Bài Amazoness", [12150] = "Gói Bài Amazoness",
		[1] = "Gói Bài Kết Giới Băng", [101001] = "Gói Bài Kết Giới Băng", [101010] = "Gói Bài Kết Giới Băng", [101050] = "Gói Bài Kết Giới Băng",
		[2] = "Gói Bài Lửa Vĩnh Cửu", [102001] = "Gói Bài Lửa Vĩnh Cửu", [102010] = "Gói Bài Lửa Vĩnh Cửu", [102050] = "Gói Bài Lửa Vĩnh Cửu",
		[3] = "Gói Bài Chiến Thần Bujin", [103001] = "Gói Bài Chiến Thần Bujin", [103010] = "Gói Bài Chiến Thần Bujin", [103050] = "Gói Bài Chiến Thần Bujin",
		[4] = "Gói Bài Vampire", [104001] = "Gói Bài Vampire", [104010] = "Gói Bài Vampire", [104050] = "Gói Bài Vampire",
		[5] = "Gói Bài Rồng Khổng Lồ", [105001] = "Gói Bài Rồng Khổng Lồ", [105010] = "Gói Bài Rồng Khổng Lồ", [105050] = "Gói Bài Rồng Khổng Lồ",
		[6] = "Gói Bài Công Nghệ TG", [106001] = "Gói Bài Công Nghệ TG", [106010] = "Gói Bài Công Nghệ TG", [106050] = "Gói Bài Công Nghệ TG",
		[7] = "Gói Bài Búp Bê Bóng Đêm", [107001] = "Gói Bài Búp Bê Bóng Đêm", [107010] = "Gói Bài Búp Bê Bóng Đêm", [107050] = "Gói Bài Búp Bê Bóng Đêm",
		[8] = "Gói Bài Áo Giáp Bóng Đêm", [108001] = "Gói Bài Áo Giáp Bóng Đêm", [108010] = "Gói Bài Áo Giáp Bóng Đêm", [108050] = "Gói Bài Áo Giáp Bóng Đêm",
		[9] = "Gói Bài Bánh Ngọt", [109001] = "Gói Bài Bánh Ngọt", [109010] = "Gói Bài Bánh Ngọt", [109050] = "Gói Bài Bánh Ngọt",
		[10] = "Gói Bài Chim Săn Mồi", [110001] = "Gói Bài Chim Săn Mồi", [110010] = "Gói Bài Chim Săn Mồi", [110050] = "Gói Bài Chim Săn Mồi",
		[11] = "Gói Bài Hoa Trát", [111001] = "Gói Bài Hoa Trát", [111010] = "Gói Bài Hoa Trát", [111050] = "Gói Bài Hoa Trát",
		[12] = "Gói Bài Đế Vương", [112001] = "Gói Bài Đế Vương", [112010] = "Gói Bài Đế Vương", [112050] = "Gói Bài Đế Vương",
		[13] = "Gói Bài Vylon", [113001] = "Gói Bài Vylon", [113010] = "Gói Bài Vylon", [113050] = "Gói Bài Vylon",
		[14] = "Gói Bài Hỏa Thú Luân Hồi", [114001] = "Gói Bài Hỏa Thú Luân Hồi", [114010] = "Gói Bài Hỏa Thú Luân Hồi", [114050] = "Gói Bài Hỏa Thú Luân Hồi",
		[15] = "Gói Bài Công Chúa Biển", [115001] = "Gói Bài Công Chúa Biển", [115010] = "Gói Bài Công Chúa Biển", [115050] = "Gói Bài Công Chúa Biển",
		[16] = "Gói Bài Cực Tinh", [116001] = "Gói Bài Cực Tinh", [116010] = "Gói Bài Cực Tinh", [116050] = "Gói Bài Cực Tinh",
		[17] = "Gói Bài Quái Thú Huy Hiệu", [117001] = "Gói Bài Quái Thú Huy Hiệu", [117010] = "Gói Bài Quái Thú Huy Hiệu", [117050] = "Gói Bài Quái Thú Huy Hiệu",
		[18] = "Gói Bài Xúc Xắc", [118001] = "Gói Bài Xúc Xắc", [118010] = "Gói Bài Xúc Xắc", [118050] = "Gói Bài Xúc Xắc",
		[19] = "Gói Bài Bất Tri Hỏa", [119001] = "Gói Bài Bất Tri Hỏa", [119010] = "Gói Bài Bất Tri Hỏa", [119050] = "Gói Bài Bất Tri Hỏa",
		[20] = "Gói Bài Siêu Trọng Kiếm Sĩ", [120001] = "Gói Bài Siêu Trọng Kiếm Sĩ", [120010] = "Gói Bài Siêu Trọng Kiếm Sĩ", [120050] = "Gói Bài Siêu Trọng Kiếm Sĩ",
		[1] = "Gói Bài Rồng Sấm Sét", [121001] = "Gói Bài Rồng Sấm Sét", [121010] = "Gói Bài Rồng Sấm Sét", [121050] = "Gói Bài Rồng Sấm Sét",
		[2] = "Gói Bài Hầu Gái Nửa Rồng", [122001] = "Gói Bài Hầu Gái Nửa Rồng", [122010] = "Gói Bài Hầu Gái Nửa Rồng", [122050] = "Gói Bài Hầu Gái Nửa Rồng",
		[3] = "Gói Bài Hoa Tuyết", [123001] = "Gói Bài Hoa Tuyết", [123010] = "Gói Bài Hoa Tuyết", [123050] = "Gói Bài Hoa Tuyết",
		[4] = "Gói Bài Bọ Cánh Cứng", [124001] = "Gói Bài Bọ Cánh Cứng", [124010] = "Gói Bài Bọ Cánh Cứng", [124050] = "Gói Bài Bọ Cánh Cứng",
		[5] = "Gói Bài Cơ Giáp", [125001] = "Gói Bài Cơ Giáp", [125010] = "Gói Bài Cơ Giáp", [125050] = "Gói Bài Cơ Giáp",
		[6] = "Gói Bài Dị Thứ Nguyên", [126001] = "Gói Bài Dị Thứ Nguyên", [126010] = "Gói Bài Dị Thứ Nguyên", [126050] = "Gói Bài Dị Thứ Nguyên",
		[7] = "Gói Bài Con Rối", [127001] = "Gói Bài Con Rối", [127010] = "Gói Bài Con Rối", [127050] = "Gói Bài Con Rối",
		[8] = "Gói Bài Phế Liệu", [128001] = "Gói Bài Phế Liệu", [128010] = "Gói Bài Phế Liệu", [128050] = "Gói Bài Phế Liệu",
		[9] = "Gói Bài Bảo Ngọc", [129001] = "Gói Bài Bảo Ngọc", [129010] = "Gói Bài Bảo Ngọc", [129050] = "Gói Bài Bảo Ngọc",
		[10] = "Gói Bài Tự Nhiên", [130001] = "Gói Bài Tự Nhiên", [130010] = "Gói Bài Tự Nhiên", [130050] = "Gói Bài Tự Nhiên",
		[11] = "Gói Bài Cơ Xảo", [131001] = "Gói Bài Cơ Xảo", [131010] = "Gói Bài Cơ Xảo", [131050] = "Gói Bài Cơ Xảo",
		[12] = "Gói Bài Khung Xương", [132001] = "Gói Bài Khung Xương", [132010] = "Gói Bài Khung Xương", [132050] = "Gói Bài Khung Xương",
		[13] = "Gói Bài Kẻ Trộm Thời Gian", [133001] = "Gói Bài Kẻ Trộm Thời Gian", [133010] = "Gói Bài Kẻ Trộm Thời Gian", [133050] = "Gói Bài Kẻ Trộm Thời Gian",
		[14] = "Gói Bài Quang Ba", [134001] = "Gói Bài Quang Ba", [134010] = "Gói Bài Quang Ba", [134050] = "Gói Bài Quang Ba",
		[15] = "Gói Bài Hải Hoàng", [135001] = "Gói Bài Hải Hoàng", [135010] = "Gói Bài Hải Hoàng", [135050] = "Gói Bài Hải Hoàng",
		[16] = "Gói Bài Nòng Súng", [136001] = "Gói Bài Nòng Súng", [136010] = "Gói Bài Nòng Súng", [136050] = "Gói Bài Nòng Súng",
		[17] = "Gói Bài Cô Gái Vận Mệnh", [137001] = "Gói Bài Cô Gái Vận Mệnh", [137010] = "Gói Bài Cô Gái Vận Mệnh", [137050] = "Gói Bài Cô Gái Vận Mệnh",
		[18] = "Gói Bài Trùng Tộc", [138001] = "Gói Bài Trùng Tộc", [138010] = "Gói Bài Trùng Tộc", [138050] = "Gói Bài Trùng Tộc",
		[19] = "Gói Bài Đoàn Tàu", [139001] = "Gói Bài Đoàn Tàu", [139010] = "Gói Bài Đoàn Tàu", [139050] = "Gói Bài Đoàn Tàu",
		[20] = "Gói Bài Gishki", [140001] = "Gói Bài Gishki", [140010] = "Gói Bài Gishki", [140050] = "Gói Bài Gishki",
		[21] = "Gói Bài ES/CS", [141001] = "Gói Bài ES/CS", [141010] = "Gói Bài ES/CS", [141050] = "Gói Bài ES/CS",
		[22] = "Gói Bài TrickStar", [142001] = "Gói Bài TrickStar", [142010] = "Gói Bài TrickStar", [142050] = "Gói Bài TrickStar",
		[23] = "Gói Bài Quyền Thủ Lửa", [143001] = "Gói Bài Quyền Thủ Lửa", [143010] = "Gói Bài Quyền Thủ Lửa", [143050] = "Gói Bài Quyền Thủ Lửa",
		[24] = "Gói Bài Kiếm Sĩ X", [144001] = "Gói Bài Kiếm Sĩ X", [144010] = "Gói Bài Kiếm Sĩ X", [144050] = "Gói Bài Kiếm Sĩ X",
		[25] = "Gói Bài Số Hiệu No.", [145001] = "Gói Bài Số Hiệu No.", [145010] = "Gói Bài Số Hiệu No.", [145050] = "Gói Bài Số Hiệu No.",
		[26] = "Gói Bài Rồng Hoa Hồng", [146001] = "Gói Bài Rồng Hoa Hồng", [146010] = "Gói Bài Rồng Hoa Hồng", [146050] = "Gói Bài Rồng Hoa Hồng",
		[27] = "Gói Bài Huyễn Thú Cơ", [147001] = "Gói Bài Huyễn Thú Cơ", [147010] = "Gói Bài Huyễn Thú Cơ", [147050] = "Gói Bài Huyễn Thú Cơ",
		[28] = "Gói Bài Tam Quốc Diễn Nghĩa", [148001] = "Gói Bài Tam Quốc Diễn Nghĩa", [148010] = "Gói Bài Tam Quốc Diễn Nghĩa", [148050] = "Gói Bài Tam Quốc Diễn Nghĩa",
		[29] = "Gói Bài Linh Hồn Nhập & Quỷ Xâm Lược", [149001] = "Gói Bài Linh Hồn Nhập & Quỷ Xâm Lược", [149010] = "Gói Bài Linh Hồn Nhập & Quỷ Xâm Lược", [149050] = "Gói Bài Linh Hồn Nhập & Quỷ Xâm Lược",
		[30] = "Gói Bài Hương Thơm Aromage", [150001] = "Gói Bài Hương Thơm Aromage", [150010] = "Gói Bài Hương Thơm Aromage", [150050] = "Gói Bài Hương Thơm Aromage",
		[31] = "Gói Bài Tam Ma Thần & Ác Ma", [151001] = "Gói Bài Tam Ma Thần & Ác Ma", [151010] = "Gói Bài Tam Ma Thần & Ác Ma", [151050] = "Gói Bài Tam Ma Thần & Ác Ma",
		[32] = "Gói Bài Rồng Lửa Đỏ & Cộng Hưởng", [152001] = "Gói Bài Rồng Lửa Đỏ & Cộng Hưởng", [152010] = "Gói Bài Rồng Lửa Đỏ & Cộng Hưởng", [152050] = "Gói Bài Rồng Lửa Đỏ & Cộng Hưởng",
		[33] = "Gói Bài Đạn Pháo & Nòng Súng Borrel", [153001] = "Gói Bài Đạn Pháo & Nòng Súng Borrel", [153010] = "Gói Bài Đạn Pháo & Nòng Súng Borrel", [153050] = "Gói Bài Đạn Pháo & Nòng Súng Borrel",
		[34] = "Gói Bài Cơ Xảo Karakuri", [154001] = "Gói Bài Cơ Xảo Karakuri", [154010] = "Gói Bài Cơ Xảo Karakuri", [154050] = "Gói Bài Cơ Xảo Karakuri",
		[35] = "Gói Bài D/D/D & Khế Ước Tối", [155001] = "Gói Bài D/D/D & Khế Ước Tối", [155010] = "Gói Bài D/D/D & Khế Ước Tối", [155050] = "Gói Bài D/D/D & Khế Ước Tối",
		[36] = "Gói Bài Quái Thú Bò Sát", [156001] = "Gói Bài Quái Thú Bò Sát", [156010] = "Gói Bài Quái Thú Bò Sát", [156050] = "Gói Bài Quái Thú Bò Sát",
		[37] = "Gói Bài Sức Mạnh Bí Thuật", [157001] = "Gói Bài Sức Mạnh Bí Thuật", [157010] = "Gói Bài Sức Mạnh Bí Thuật", [157050] = "Gói Bài Sức Mạnh Bí Thuật",
		[38] = "Gói Bài Anh Hùng Bóng Đêm", [158001] = "Gói Bài Anh Hùng Bóng Đêm", [158010] = "Gói Bài Anh Hùng Bóng Đêm", [158050] = "Gói Bài Anh Hùng Bóng Đêm",
		[39] = "Gói Bài Kiếm Diệt Rồng", [159001] = "Gói Bài Kiếm Diệt Rồng", [159010] = "Gói Bài Kiếm Diệt Rồng", [159050] = "Gói Bài Kiếm Diệt Rồng",
		[40] = "Gói Bài Trẻ Nghịch Ngợm P.U.N.K.", [160001] = "Gói Bài Trẻ Nghịch Ngợm P.U.N.K.", [160010] = "Gói Bài Trẻ Nghịch Ngợm P.U.N.K.", [160050] = "Gói Bài Trẻ Nghịch Ngợm P.U.N.K.",
		[41] = "Gói Bài Chim Săn Mồi Raidraptor", [161001] = "Gói Bài Chim Săn Mồi Raidraptor", [161010] = "Gói Bài Chim Săn Mồi Raidraptor", [161050] = "Gói Bài Chim Săn Mồi Raidraptor",
		[42] = "Gói Bài Công Chúa Biển Marincess", [162001] = "Gói Bài Công Chúa Biển Marincess", [162010] = "Gói Bài Công Chúa Biển Marincess", [162050] = "Gói Bài Công Chúa Biển Marincess",
		[43] = "Gói Bài Triệu Hồi Thú & Ảo Thú", [163001] = "Gói Bài Triệu Hồi Thú & Ảo Thú", [163010] = "Gói Bài Triệu Hồi Thú & Ảo Thú", [163050] = "Gói Bài Triệu Hồi Thú & Ảo Thú",
		[44] = "Gói Bài Thiên Thần & Nghi Thức", [164001] = "Gói Bài Thiên Thần & Nghi Thức", [164010] = "Gói Bài Thiên Thần & Nghi Thức", [164050] = "Gói Bài Thiên Thần & Nghi Thức",
		[45] = "Gói Bài Đoàn Tàu Chiến Hạng Nặng", [165001] = "Gói Bài Đoàn Tàu Chiến Hạng Nặng", [165010] = "Gói Bài Đoàn Tàu Chiến Hạng Nặng", [165050] = "Gói Bài Đoàn Tàu Chiến Hạng Nặng",
		[46] = "Gói Bài Hoa Tuyết Rikka", [166001] = "Gói Bài Hoa Tuyết Rikka", [166010] = "Gói Bài Hoa Tuyết Rikka", [166050] = "Gói Bài Hoa Tuyết Rikka",
		[47] = "Gói Bài Vua Lửa Fire King", [167001] = "Gói Bài Vua Lửa Fire King", [167010] = "Gói Bài Vua Lửa Fire King", [167050] = "Gói Bài Vua Lửa Fire King",
		[48] = "Gói Bài Thánh Nhạc Tự Đàn Orcust", [168001] = "Gói Bài Thánh Nhạc Tự Đàn Orcust", [168010] = "Gói Bài Thánh Nhạc Tự Đàn Orcust", [168050] = "Gói Bài Thánh Nhạc Tự Đàn Orcust",
		[49] = "Gói Bài Gusto & Phù Thủy Gió", [169001] = "Gói Bài Gusto & Phù Thủy Gió", [169010] = "Gói Bài Gusto & Phù Thủy Gió", [169050] = "Gói Bài Gusto & Phù Thủy Gió",
		[50] = "Gói Bài Chiến Hạm Không Gian B.E.S.", [170001] = "Gói Bài Chiến Hạm Không Gian B.E.S.", [170010] = "Gói Bài Chiến Hạm Không Gian B.E.S.", [170050] = "Gói Bài Chiến Hạm Không Gian B.E.S.",
		[51] = "Gói Bài Cổ Điển: Exodia & Hỗn Độn", [171001] = "Gói Bài Cổ Điển: Exodia & Hỗn Độn", [171010] = "Gói Bài Cổ Điển: Exodia & Hỗn Độn", [171050] = "Gói Bài Cổ Điển: Exodia & Hỗn Độn",
		[52] = "Gói Bài Quái Vật Nâng Cấp LV", [172001] = "Gói Bài Quái Vật Nâng Cấp LV", [172010] = "Gói Bài Quái Vật Nâng Cấp LV", [172050] = "Gói Bài Quái Vật Nâng Cấp LV",
		[53] = "Gói Bài Thú Hóa Học & Tiến Hóa", [173001] = "Gói Bài Thú Hóa Học & Tiến Hóa", [173010] = "Gói Bài Thú Hóa Học & Tiến Hóa", [173050] = "Gói Bài Thú Hóa Học & Tiến Hóa",
		[54] = "Gói Bài Xứ Sở Cổ Tích & Yêu Tinh", [174001] = "Gói Bài Xứ Sở Cổ Tích & Yêu Tinh", [174010] = "Gói Bài Xứ Sở Cổ Tích & Yêu Tinh", [174050] = "Gói Bài Xứ Sở Cổ Tích & Yêu Tinh",
		[181001] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn I", [181010] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn I", [181050] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn I",
		[182001] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn II", [182010] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn II", [182050] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn II",
		[183001] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn III", [183010] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn III", [183050] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn III",
		[184001] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn IV", [184010] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn IV", [184050] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn IV",
		[185001] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn V", [185010] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn V", [185050] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn V",
		[186001] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VI", [186010] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VI", [186050] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VI",
		[187001] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VII", [187010] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VII", [187050] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VII",
		[188001] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VIII", [188010] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VIII", [188050] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn VIII",
		[189001] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn IX", [189010] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn IX", [189050] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn IX",
		[190001] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn X", [190010] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn X", [190050] = "Gói Mở Rộng: Quái Thú Tiêu Chuẩn X",
		[191001] = "Gói Mở Rộng: Ma Pháp Toàn Năng I", [191010] = "Gói Mở Rộng: Ma Pháp Toàn Năng I", [191050] = "Gói Mở Rộng: Ma Pháp Toàn Năng I",
		[192001] = "Gói Mở Rộng: Ma Pháp Toàn Năng II", [192010] = "Gói Mở Rộng: Ma Pháp Toàn Năng II", [192050] = "Gói Mở Rộng: Ma Pháp Toàn Năng II",
		[193001] = "Gói Mở Rộng: Ma Pháp Toàn Năng III", [193010] = "Gói Mở Rộng: Ma Pháp Toàn Năng III", [193050] = "Gói Mở Rộng: Ma Pháp Toàn Năng III",
		[194001] = "Gói Mở Rộng: Ma Pháp Toàn Năng IV", [194010] = "Gói Mở Rộng: Ma Pháp Toàn Năng IV", [194050] = "Gói Mở Rộng: Ma Pháp Toàn Năng IV",
		[195001] = "Gói Mở Rộng: Ma Pháp Toàn Năng V", [195010] = "Gói Mở Rộng: Ma Pháp Toàn Năng V", [195050] = "Gói Mở Rộng: Ma Pháp Toàn Năng V",
		[196001] = "Gói Mở Rộng: Ma Pháp Toàn Năng VI", [196010] = "Gói Mở Rộng: Ma Pháp Toàn Năng VI", [196050] = "Gói Mở Rộng: Ma Pháp Toàn Năng VI",
		[197001] = "Gói Mở Rộng: Ma Pháp Toàn Năng VII", [197010] = "Gói Mở Rộng: Ma Pháp Toàn Năng VII", [197050] = "Gói Mở Rộng: Ma Pháp Toàn Năng VII",
		[198001] = "Gói Mở Rộng: Ma Pháp Toàn Năng VIII", [198010] = "Gói Mở Rộng: Ma Pháp Toàn Năng VIII", [198050] = "Gói Mở Rộng: Ma Pháp Toàn Năng VIII",
		[199001] = "Gói Mở Rộng: Ma Pháp Toàn Năng IX", [199010] = "Gói Mở Rộng: Ma Pháp Toàn Năng IX", [199050] = "Gói Mở Rộng: Ma Pháp Toàn Năng IX",
		[200001] = "Gói Mở Rộng: Ma Pháp Toàn Năng X", [200010] = "Gói Mở Rộng: Ma Pháp Toàn Năng X", [200050] = "Gói Mở Rộng: Ma Pháp Toàn Năng X",
		[201001] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược I", [201010] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược I", [201050] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược I",
		[202001] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược II", [202010] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược II", [202050] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược II",
		[203001] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược III", [203010] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược III", [203050] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược III",
		[204001] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược IV", [204010] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược IV", [204050] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược IV",
		[205001] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược V", [205010] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược V", [205050] = "Gói Mở Rộng: Cạm Bẫy Chiến Lược V",
		[206001] = "Gói Mở Rộng: Extra Deck Tổng Hợp I", [206010] = "Gói Mở Rộng: Extra Deck Tổng Hợp I", [206050] = "Gói Mở Rộng: Extra Deck Tổng Hợp I",
		[207001] = "Gói Mở Rộng: Extra Deck Tổng Hợp II", [207010] = "Gói Mở Rộng: Extra Deck Tổng Hợp II", [207050] = "Gói Mở Rộng: Extra Deck Tổng Hợp II",
		[208001] = "Gói Mở Rộng: Extra Deck Tổng Hợp III", [208010] = "Gói Mở Rộng: Extra Deck Tổng Hợp III", [208050] = "Gói Mở Rộng: Extra Deck Tổng Hợp III",
		[209001] = "Gói Mở Rộng: Extra Deck Tổng Hợp IV", [209010] = "Gói Mở Rộng: Extra Deck Tổng Hợp IV", [209050] = "Gói Mở Rộng: Extra Deck Tổng Hợp IV",
		[210001] = "Gói Mở Rộng: Extra Deck Tổng Hợp V", [210010] = "Gói Mở Rộng: Extra Deck Tổng Hợp V", [210050] = "Gói Mở Rộng: Extra Deck Tổng Hợp V",
		[221001] = "Gói bài Tru Tiên", [221010] = "Gói bài Tru Tiên", [221050] = "Gói bài Tru Tiên",
		[222001] = "Gói bài Tiên Nghịch", [222010] = "Gói bài Tiên Nghịch", [222050] = "Gói bài Tiên Nghịch",
		[223001] = "Gói bài Hiệp sĩ mặt nạ", [223010] = "Gói bài Hiệp sĩ mặt nạ", [223050] = "Gói bài Hiệp sĩ mặt nạ",
	}
	ClientData._packTitles = PACK_TITLES
	ClientData.getPackTitle = function(boxId)
		if not boxId then return "" end
		return PACK_TITLES[boxId] or ""
	end

	local PACK_IMAGES = {
		[10201] = "lottery_10201", [10210] = "lottery_10201", [10250] = "lottery_10201",
		[10301] = "lottery_10501", [10310] = "lottery_10501", [10350] = "lottery_10501",
		[10401] = "lottery_10301", [10410] = "lottery_10301", [10450] = "lottery_10301",
		[10501] = "lottery_10401", [10510] = "lottery_10401", [10550] = "lottery_10401",
		[10601] = "lottery_11201", [10610] = "lottery_11201", [10650] = "lottery_11201",
		[10701] = "lottery_11201", [10710] = "lottery_11201", [10750] = "lottery_11201",
		[10801] = "lottery_11301", [10810] = "lottery_11301", [10850] = "lottery_11301",
		[10901] = "lottery_10601", [10910] = "lottery_10601", [10950] = "lottery_10601",
		[11001] = "lottery_10701", [11010] = "lottery_10701", [11050] = "lottery_10701",
		[11101] = "lottery_10801", [11110] = "lottery_10801", [11150] = "lottery_10801",
		[11201] = "lottery_11101", [11210] = "lottery_11101", [11250] = "lottery_11101",
		[11301] = "lottery_10901", [11310] = "lottery_10901", [11350] = "lottery_10901",
		[11401] = "lottery_10801", [11410] = "lottery_10801", [11450] = "lottery_10801",
		[11501] = "lottery_10601", [11510] = "lottery_10601", [11550] = "lottery_10601",
		[11601] = "lottery_10301", [11610] = "lottery_10301", [11650] = "lottery_10301",
		[11701] = "lottery_10701", [11710] = "lottery_10701", [11750] = "lottery_10701",
		[11801] = "lottery_10401", [11810] = "lottery_10401", [11850] = "lottery_10401",
		[11901] = "lottery_10501", [11910] = "lottery_10501", [11950] = "lottery_10501",
		[12001] = "lottery_11101", [12010] = "lottery_11101", [12050] = "lottery_11101",
		[12101] = "lottery_10601", [12110] = "lottery_10601", [12150] = "lottery_10601",
		[101001] = "lottery_101001", [101010] = "lottery_101001", [101050] = "lottery_101001",
		[102001] = "lottery_102001", [102010] = "lottery_102001", [102050] = "lottery_102001",
		[103001] = "lottery_103001", [103010] = "lottery_103001", [103050] = "lottery_103001",
		[104001] = "lottery_104001", [104010] = "lottery_104001", [104050] = "lottery_104001",
		[105001] = "lottery_105001", [105010] = "lottery_105001", [105050] = "lottery_105001",
		[106001] = "lottery_106001", [106010] = "lottery_106001", [106050] = "lottery_106001",
		[107001] = "lottery_107001", [107010] = "lottery_107001", [107050] = "lottery_107001",
		[108001] = "lottery_108001", [108010] = "lottery_108001", [108050] = "lottery_108001",
		[109001] = "lottery_109001", [109010] = "lottery_109001", [109050] = "lottery_109001",
		[110001] = "lottery_110001", [110010] = "lottery_110001", [110050] = "lottery_110001",
		[111001] = "lottery_111001", [111010] = "lottery_111001", [111050] = "lottery_111001",
		[112001] = "lottery_112001", [112010] = "lottery_112001", [112050] = "lottery_112001",
		[113001] = "lottery_113001", [113010] = "lottery_113001", [113050] = "lottery_113001",
		[114001] = "lottery_114001", [114010] = "lottery_114001", [114050] = "lottery_114001",
		[115001] = "lottery_115001", [115010] = "lottery_115001", [115050] = "lottery_115001",
		[116001] = "lottery_116001", [116010] = "lottery_116001", [116050] = "lottery_116001",
		[117001] = "lottery_117001", [117010] = "lottery_117001", [117050] = "lottery_117001",
		[118001] = "lottery_118001", [118010] = "lottery_118001", [118050] = "lottery_118001",
		[119001] = "lottery_119001", [119010] = "lottery_119001", [119050] = "lottery_119001",
		[120001] = "lottery_120001", [120010] = "lottery_120001", [120050] = "lottery_120001",
		[121001] = "lottery_121001", [121010] = "lottery_121001", [121050] = "lottery_121001",
		[122001] = "lottery_122001", [122010] = "lottery_122001", [122050] = "lottery_122001",
		[123001] = "lottery_123001", [123010] = "lottery_123001", [123050] = "lottery_123001",
		[124001] = "lottery_124001", [124010] = "lottery_124001", [124050] = "lottery_124001",
		[125001] = "lottery_125001", [125010] = "lottery_125001", [125050] = "lottery_125001",
		[126001] = "lottery_126001", [126010] = "lottery_126001", [126050] = "lottery_126001",
		[127001] = "lottery_127001", [127010] = "lottery_127001", [127050] = "lottery_127001",
		[128001] = "lottery_128001", [128010] = "lottery_128001", [128050] = "lottery_128001",
		[129001] = "lottery_129001", [129010] = "lottery_129001", [129050] = "lottery_129001",
		[130001] = "lottery_130001", [130010] = "lottery_130001", [130050] = "lottery_130001",
		[131001] = "lottery_131001", [131010] = "lottery_131001", [131050] = "lottery_131001",
		[132001] = "lottery_132001", [132010] = "lottery_132001", [132050] = "lottery_132001",
		[133001] = "lottery_133001", [133010] = "lottery_133001", [133050] = "lottery_133001",
		[134001] = "lottery_134001", [134010] = "lottery_134001", [134050] = "lottery_134001",
		[135001] = "lottery_135001", [135010] = "lottery_135001", [135050] = "lottery_135001",
		[136001] = "lottery_136001", [136010] = "lottery_136001", [136050] = "lottery_136001",
		[137001] = "lottery_101001", [137010] = "lottery_101001", [137050] = "lottery_101001",
		[138001] = "lottery_102001", [138010] = "lottery_102001", [138050] = "lottery_102001",
		[139001] = "lottery_103001", [139010] = "lottery_103001", [139050] = "lottery_103001",
		[140001] = "lottery_104001", [140010] = "lottery_104001", [140050] = "lottery_104001",
		[141001] = "lottery_101001", [141010] = "lottery_101001", [141050] = "lottery_101001",
		[142001] = "lottery_102001", [142010] = "lottery_102001", [142050] = "lottery_102001",
		[143001] = "lottery_102001", [143010] = "lottery_102001", [143050] = "lottery_102001",
		[144001] = "lottery_103001", [144010] = "lottery_103001", [144050] = "lottery_103001",
		[145001] = "lottery_104001", [145010] = "lottery_104001", [145050] = "lottery_104001",
		[146001] = "lottery_105001", [146010] = "lottery_105001", [146050] = "lottery_105001",
		[147001] = "lottery_106001", [147010] = "lottery_106001", [147050] = "lottery_106001",
		[148001] = "lottery_107001", [148010] = "lottery_107001", [148050] = "lottery_107001",
		[149001] = "lottery_108001", [149010] = "lottery_108001", [149050] = "lottery_108001",
		[150001] = "lottery_109001", [150010] = "lottery_109001", [150050] = "lottery_109001",
		[151001] = "lottery_110001", [151010] = "lottery_110001", [151050] = "lottery_110001",
		[152001] = "lottery_111001", [152010] = "lottery_111001", [152050] = "lottery_111001",
		[153001] = "lottery_112001", [153010] = "lottery_112001", [153050] = "lottery_112001",
		[154001] = "lottery_113001", [154010] = "lottery_113001", [154050] = "lottery_113001",
		[155001] = "lottery_114001", [155010] = "lottery_114001", [155050] = "lottery_114001",
		[156001] = "lottery_115001", [156010] = "lottery_115001", [156050] = "lottery_115001",
		[157001] = "lottery_116001", [157010] = "lottery_116001", [157050] = "lottery_116001",
		[158001] = "lottery_117001", [158010] = "lottery_117001", [158050] = "lottery_117001",
		[159001] = "lottery_118001", [159010] = "lottery_118001", [159050] = "lottery_118001",
		[160001] = "lottery_119001", [160010] = "lottery_119001", [160050] = "lottery_119001",
		[161001] = "lottery_120001", [161010] = "lottery_120001", [161050] = "lottery_120001",
		[162001] = "lottery_101001", [162010] = "lottery_101001", [162050] = "lottery_101001",
		[163001] = "lottery_102001", [163010] = "lottery_102001", [163050] = "lottery_102001",
		[164001] = "lottery_103001", [164010] = "lottery_103001", [164050] = "lottery_103001",
		[165001] = "lottery_104001", [165010] = "lottery_104001", [165050] = "lottery_104001",
		[166001] = "lottery_105001", [166010] = "lottery_105001", [166050] = "lottery_105001",
		[167001] = "lottery_106001", [167010] = "lottery_106001", [167050] = "lottery_106001",
		[168001] = "lottery_107001", [168010] = "lottery_107001", [168050] = "lottery_107001",
		[169001] = "lottery_108001", [169010] = "lottery_108001", [169050] = "lottery_108001",
		[170001] = "lottery_109001", [170010] = "lottery_109001", [170050] = "lottery_109001",
		[171001] = "lottery_110001", [171010] = "lottery_110001", [171050] = "lottery_110001",
		[172001] = "lottery_111001", [172010] = "lottery_111001", [172050] = "lottery_111001",
		[173001] = "lottery_112001", [173010] = "lottery_112001", [173050] = "lottery_112001",
		[174001] = "lottery_113001", [174010] = "lottery_113001", [174050] = "lottery_113001",
		[181001] = "lottery_102001", [181010] = "lottery_102001", [181050] = "lottery_102001",
		[182001] = "lottery_103001", [182010] = "lottery_103001", [182050] = "lottery_103001",
		[183001] = "lottery_104001", [183010] = "lottery_104001", [183050] = "lottery_104001",
		[184001] = "lottery_105001", [184010] = "lottery_105001", [184050] = "lottery_105001",
		[185001] = "lottery_106001", [185010] = "lottery_106001", [185050] = "lottery_106001",
		[186001] = "lottery_107001", [186010] = "lottery_107001", [186050] = "lottery_107001",
		[187001] = "lottery_108001", [187010] = "lottery_108001", [187050] = "lottery_108001",
		[188001] = "lottery_109001", [188010] = "lottery_109001", [188050] = "lottery_109001",
		[189001] = "lottery_110001", [189010] = "lottery_110001", [189050] = "lottery_110001",
		[190001] = "lottery_101001", [190010] = "lottery_101001", [190050] = "lottery_101001",
		[191001] = "lottery_102001", [191010] = "lottery_102001", [191050] = "lottery_102001",
		[192001] = "lottery_103001", [192010] = "lottery_103001", [192050] = "lottery_103001",
		[193001] = "lottery_104001", [193010] = "lottery_104001", [193050] = "lottery_104001",
		[194001] = "lottery_105001", [194010] = "lottery_105001", [194050] = "lottery_105001",
		[195001] = "lottery_106001", [195010] = "lottery_106001", [195050] = "lottery_106001",
		[196001] = "lottery_107001", [196010] = "lottery_107001", [196050] = "lottery_107001",
		[197001] = "lottery_108001", [197010] = "lottery_108001", [197050] = "lottery_108001",
		[198001] = "lottery_109001", [198010] = "lottery_109001", [198050] = "lottery_109001",
		[199001] = "lottery_110001", [199010] = "lottery_110001", [199050] = "lottery_110001",
		[200001] = "lottery_101001", [200010] = "lottery_101001", [200050] = "lottery_101001",
		[201001] = "lottery_102001", [201010] = "lottery_102001", [201050] = "lottery_102001",
		[202001] = "lottery_103001", [202010] = "lottery_103001", [202050] = "lottery_103001",
		[203001] = "lottery_104001", [203010] = "lottery_104001", [203050] = "lottery_104001",
		[204001] = "lottery_105001", [204010] = "lottery_105001", [204050] = "lottery_105001",
		[205001] = "lottery_106001", [205010] = "lottery_106001", [205050] = "lottery_106001",
		[206001] = "lottery_107001", [206010] = "lottery_107001", [206050] = "lottery_107001",
		[207001] = "lottery_108001", [207010] = "lottery_108001", [207050] = "lottery_108001",
		[208001] = "lottery_109001", [208010] = "lottery_109001", [208050] = "lottery_109001",
		[209001] = "lottery_110001", [209010] = "lottery_110001", [209050] = "lottery_110001",
		[210001] = "lottery_101001", [210010] = "lottery_101001", [210050] = "lottery_101001",
		[221001] = "lottery_221001", [221010] = "lottery_221001", [221050] = "lottery_221001",
		[222001] = "lottery_222001", [222010] = "lottery_222001", [222050] = "lottery_222001",
		[223001] = "lottery_223001", [223010] = "lottery_223001", [223050] = "lottery_223001",
	}
	ClientData._packImages = PACK_IMAGES
	ClientData.getPackImageName = function(boxId)
		if not boxId then return nil end
		return PACK_IMAGES[boxId]
	end

	local CHAR_CARDS_MAP = {
		[1] = {40250, 10116, 10117, 10606, 10703, 10968, 20412, 40256, 40301, 40354, 40454, 40708, 40719, 40722, 21097, 21132, 30357, 30575, 40001, 40148, 40158, 11618, 11898, 11899, 12151, 12224, 12291, 12299, 20052, 20260, 20275, 20553, 21090, 21093, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 10001, 10115, 10212, 10705, 10706, 10720, 10814, 10930, 11363, 11402, 11567, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 40355, 40686},
		[10201] = {40250, 10116, 10117, 10606, 10703, 10968, 20412, 40256, 40301, 40354, 40454, 40708, 40719, 40722, 21097, 21132, 30357, 30575, 40001, 40148, 40158, 11618, 11898, 11899, 12151, 12224, 12291, 12299, 20052, 20260, 20275, 20553, 21090, 21093, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 10001, 10115, 10212, 10705, 10706, 10720, 10814, 10930, 11363, 11402, 11567, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 40355, 40686}, [10210] = {40250, 10116, 10117, 10606, 10703, 10968, 20412, 40256, 40301, 40354, 40454, 40708, 40719, 40722, 21097, 21132, 30357, 30575, 40001, 40148, 40158, 11618, 11898, 11899, 12151, 12224, 12291, 12299, 20052, 20260, 20275, 20553, 21090, 21093, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 10001, 10115, 10212, 10705, 10706, 10720, 10814, 10930, 11363, 11402, 11567, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 40355, 40686}, [10250] = {40250, 10116, 10117, 10606, 10703, 10968, 20412, 40256, 40301, 40354, 40454, 40708, 40719, 40722, 21097, 21132, 30357, 30575, 40001, 40148, 40158, 11618, 11898, 11899, 12151, 12224, 12291, 12299, 20052, 20260, 20275, 20553, 21090, 21093, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 10001, 10115, 10212, 10705, 10706, 10720, 10814, 10930, 11363, 11402, 11567, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 40355, 40686},
		[2] = {11365, 20549, 20551, 20552, 10405, 10815, 11093, 20197, 30124, 40495, 40288, 40431, 40675, 40718, 20380, 20840, 30036, 30132, 30138, 30442, 40194, 11497, 11498, 11499, 12037, 12167, 12168, 12312, 20134, 20189, 20190, 20198, 20292, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 10086, 10118, 10620, 10621, 10622, 10787, 10848, 11013, 11020, 11228, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 40160, 40585},
		[10301] = {11365, 20549, 20551, 20552, 10405, 10815, 11093, 20197, 30124, 40495, 40288, 40431, 40675, 40718, 20380, 20840, 30036, 30132, 30138, 30442, 40194, 11497, 11498, 11499, 12037, 12167, 12168, 12312, 20134, 20189, 20190, 20198, 20292, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 10086, 10118, 10620, 10621, 10622, 10787, 10848, 11013, 11020, 11228, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 40160, 40585}, [10310] = {11365, 20549, 20551, 20552, 10405, 10815, 11093, 20197, 30124, 40495, 40288, 40431, 40675, 40718, 20380, 20840, 30036, 30132, 30138, 30442, 40194, 11497, 11498, 11499, 12037, 12167, 12168, 12312, 20134, 20189, 20190, 20198, 20292, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 10086, 10118, 10620, 10621, 10622, 10787, 10848, 11013, 11020, 11228, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 40160, 40585}, [10350] = {11365, 20549, 20551, 20552, 10405, 10815, 11093, 20197, 30124, 40495, 40288, 40431, 40675, 40718, 20380, 20840, 30036, 30132, 30138, 30442, 40194, 11497, 11498, 11499, 12037, 12167, 12168, 12312, 20134, 20189, 20190, 20198, 20292, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 10086, 10118, 10620, 10621, 10622, 10787, 10848, 11013, 11020, 11228, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 40160, 40585},
		[3] = {11225, 30383, 20543, 30022, 30024, 30031, 30161, 30479, 20760, 20764, 20765, 20900, 20913, 20951, 21045, 21126, 20003, 20006, 20009, 20010, 20012, 20013, 20014, 20027, 20043, 20160, 20544, 20646, 20750, 20751, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 10004, 10006, 10477, 10624, 11893, 12273, 12282, 12283, 12307, 12310, 20001, 20002, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10048, 10242, 10317, 10702, 10749, 10750, 10751, 10752, 10753, 11338, 11379, 11609, 12169, 12178, 12181, 20529, 20664, 20911, 20960, 30247, 30248, 30388, 40018, 40142, 40143, 40150, 40494, 40617, 40664, 40712},
		[10401] = {11225, 30383, 20543, 30022, 30024, 30031, 30161, 30479, 20760, 20764, 20765, 20900, 20913, 20951, 21045, 21126, 20003, 20006, 20009, 20010, 20012, 20013, 20014, 20027, 20043, 20160, 20544, 20646, 20750, 20751, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 10004, 10006, 10477, 10624, 11893, 12273, 12282, 12283, 12307, 12310, 20001, 20002, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10048, 10242, 10317, 10702, 10749, 10750, 10751, 10752, 10753, 11338, 11379, 11609, 12169, 12178, 12181, 20529, 20664, 20911, 20960, 30247, 30248, 30388, 40018, 40142, 40143, 40150, 40494, 40617, 40664, 40712}, [10410] = {11225, 30383, 20543, 30022, 30024, 30031, 30161, 30479, 20760, 20764, 20765, 20900, 20913, 20951, 21045, 21126, 20003, 20006, 20009, 20010, 20012, 20013, 20014, 20027, 20043, 20160, 20544, 20646, 20750, 20751, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 10004, 10006, 10477, 10624, 11893, 12273, 12282, 12283, 12307, 12310, 20001, 20002, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10048, 10242, 10317, 10702, 10749, 10750, 10751, 10752, 10753, 11338, 11379, 11609, 12169, 12178, 12181, 20529, 20664, 20911, 20960, 30247, 30248, 30388, 40018, 40142, 40143, 40150, 40494, 40617, 40664, 40712}, [10450] = {11225, 30383, 20543, 30022, 30024, 30031, 30161, 30479, 20760, 20764, 20765, 20900, 20913, 20951, 21045, 21126, 20003, 20006, 20009, 20010, 20012, 20013, 20014, 20027, 20043, 20160, 20544, 20646, 20750, 20751, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 10004, 10006, 10477, 10624, 11893, 12273, 12282, 12283, 12307, 12310, 20001, 20002, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10048, 10242, 10317, 10702, 10749, 10750, 10751, 10752, 10753, 11338, 11379, 11609, 12169, 12178, 12181, 20529, 20664, 20911, 20960, 30247, 30248, 30388, 40018, 40142, 40143, 40150, 40494, 40617, 40664, 40712},
		[4] = {20566, 11797, 30482, 40441, 40442, 40496, 40709, 20517, 20521, 20523, 20852, 20858, 21073, 21119, 11921, 12051, 12052, 12053, 12127, 12251, 12265, 20310, 20311, 20316, 20514, 20516, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 10699, 10700, 11296, 11297, 11577, 11594, 11798, 11804, 11875, 11918, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10266, 10568, 10849, 10850, 10867, 10897, 11023, 11025, 11299, 11300, 11301, 11302, 11303, 11336, 11610, 12266, 20518, 20519, 20520, 20815, 40199, 40200, 40201, 40202, 40641},
		[10501] = {20566, 11797, 30482, 40441, 40442, 40496, 40709, 20517, 20521, 20523, 20852, 20858, 21073, 21119, 11921, 12051, 12052, 12053, 12127, 12251, 12265, 20310, 20311, 20316, 20514, 20516, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 10699, 10700, 11296, 11297, 11577, 11594, 11798, 11804, 11875, 11918, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10266, 10568, 10849, 10850, 10867, 10897, 11023, 11025, 11299, 11300, 11301, 11302, 11303, 11336, 11610, 12266, 20518, 20519, 20520, 20815, 40199, 40200, 40201, 40202, 40641}, [10510] = {20566, 11797, 30482, 40441, 40442, 40496, 40709, 20517, 20521, 20523, 20852, 20858, 21073, 21119, 11921, 12051, 12052, 12053, 12127, 12251, 12265, 20310, 20311, 20316, 20514, 20516, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 10699, 10700, 11296, 11297, 11577, 11594, 11798, 11804, 11875, 11918, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10266, 10568, 10849, 10850, 10867, 10897, 11023, 11025, 11299, 11300, 11301, 11302, 11303, 11336, 11610, 12266, 20518, 20519, 20520, 20815, 40199, 40200, 40201, 40202, 40641}, [10550] = {20566, 11797, 30482, 40441, 40442, 40496, 40709, 20517, 20521, 20523, 20852, 20858, 21073, 21119, 11921, 12051, 12052, 12053, 12127, 12251, 12265, 20310, 20311, 20316, 20514, 20516, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 10699, 10700, 11296, 11297, 11577, 11594, 11798, 11804, 11875, 11918, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10266, 10568, 10849, 10850, 10867, 10897, 11023, 11025, 11299, 11300, 11301, 11302, 11303, 11336, 11610, 12266, 20518, 20519, 20520, 20815, 40199, 40200, 40201, 40202, 40641},
		[5] = {40336, 40697, 40696, 40273, 40274, 40276, 40277, 40279, 40280, 40281, 40334, 40335, 40362, 40606, 40051, 40053, 40055, 40057, 40058, 40060, 40061, 40062, 40063, 40064, 40065, 40066, 40146, 40263, 40272, 11461, 11462, 11463, 11555, 12008, 12042, 12173, 20343, 20344, 20349, 20563, 20626, 30342, 30344, 40010, 40038, 40039, 40040, 40041, 40042, 40043, 40044, 40045, 40048, 40049, 40050, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 10290, 10291, 10683, 10684, 10685, 10686, 10687, 10688, 10689, 10715, 10718, 10726, 10758, 10828, 10938, 10942, 10943, 10944, 10945, 11227, 11416, 11417, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10939, 10940, 10941, 11460, 11464, 11465, 11791, 20005, 20028, 20058, 20106, 20224, 20261, 20262, 20300, 20364, 20511, 20522, 20573, 20756, 20757, 20767, 20770, 20872, 20971, 21046, 21076, 21125, 30071, 30276, 30321, 30462, 40059, 40278, 40658},
		[10601] = {40336, 40697, 40696, 40273, 40274, 40276, 40277, 40279, 40280, 40281, 40334, 40335, 40362, 40606, 40051, 40053, 40055, 40057, 40058, 40060, 40061, 40062, 40063, 40064, 40065, 40066, 40146, 40263, 40272, 11461, 11462, 11463, 11555, 12008, 12042, 12173, 20343, 20344, 20349, 20563, 20626, 30342, 30344, 40010, 40038, 40039, 40040, 40041, 40042, 40043, 40044, 40045, 40048, 40049, 40050, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 10290, 10291, 10683, 10684, 10685, 10686, 10687, 10688, 10689, 10715, 10718, 10726, 10758, 10828, 10938, 10942, 10943, 10944, 10945, 11227, 11416, 11417, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10939, 10940, 10941, 11460, 11464, 11465, 11791, 20005, 20028, 20058, 20106, 20224, 20261, 20262, 20300, 20364, 20511, 20522, 20573, 20756, 20757, 20767, 20770, 20872, 20971, 21046, 21076, 21125, 30071, 30276, 30321, 30462, 40059, 40278, 40658}, [10610] = {40336, 40697, 40696, 40273, 40274, 40276, 40277, 40279, 40280, 40281, 40334, 40335, 40362, 40606, 40051, 40053, 40055, 40057, 40058, 40060, 40061, 40062, 40063, 40064, 40065, 40066, 40146, 40263, 40272, 11461, 11462, 11463, 11555, 12008, 12042, 12173, 20343, 20344, 20349, 20563, 20626, 30342, 30344, 40010, 40038, 40039, 40040, 40041, 40042, 40043, 40044, 40045, 40048, 40049, 40050, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 10290, 10291, 10683, 10684, 10685, 10686, 10687, 10688, 10689, 10715, 10718, 10726, 10758, 10828, 10938, 10942, 10943, 10944, 10945, 11227, 11416, 11417, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10939, 10940, 10941, 11460, 11464, 11465, 11791, 20005, 20028, 20058, 20106, 20224, 20261, 20262, 20300, 20364, 20511, 20522, 20573, 20756, 20757, 20767, 20770, 20872, 20971, 21046, 21076, 21125, 30071, 30276, 30321, 30462, 40059, 40278, 40658}, [10650] = {40336, 40697, 40696, 40273, 40274, 40276, 40277, 40279, 40280, 40281, 40334, 40335, 40362, 40606, 40051, 40053, 40055, 40057, 40058, 40060, 40061, 40062, 40063, 40064, 40065, 40066, 40146, 40263, 40272, 11461, 11462, 11463, 11555, 12008, 12042, 12173, 20343, 20344, 20349, 20563, 20626, 30342, 30344, 40010, 40038, 40039, 40040, 40041, 40042, 40043, 40044, 40045, 40048, 40049, 40050, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 10290, 10291, 10683, 10684, 10685, 10686, 10687, 10688, 10689, 10715, 10718, 10726, 10758, 10828, 10938, 10942, 10943, 10944, 10945, 11227, 11416, 11417, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10939, 10940, 10941, 11460, 11464, 11465, 11791, 20005, 20028, 20058, 20106, 20224, 20261, 20262, 20300, 20364, 20511, 20522, 20573, 20756, 20757, 20767, 20770, 20872, 20971, 21046, 21076, 21125, 30071, 30276, 30321, 30462, 40059, 40278, 40658},
		[6] = {40168, 40169, 12078, 40167, 11248, 11249, 11250, 11251, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 11245, 11246, 11247, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 40534, 40646, 10112, 10114, 10119},
		[10701] = {40168, 40169, 12078, 40167, 11248, 11249, 11250, 11251, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 11245, 11246, 11247, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 40534, 40646, 10112, 10114, 10119}, [10710] = {40168, 40169, 12078, 40167, 11248, 11249, 11250, 11251, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 11245, 11246, 11247, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 40534, 40646, 10112, 10114, 10119}, [10750] = {40168, 40169, 12078, 40167, 11248, 11249, 11250, 11251, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 11245, 11246, 11247, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 40534, 40646, 10112, 10114, 10119},
		[7] = {20631, 40069, 40070, 40071, 40072, 40074, 40289, 30205, 30225, 30251, 30288, 30305, 30465, 30562, 40068, 20398, 20400, 20431, 20526, 20628, 20887, 21055, 21056, 21059, 21060, 21061, 21062, 21072, 30201, 30202, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10947, 10948, 10949, 10950, 10957, 10997, 11106, 11171, 11172, 11206, 12106, 12107, 20357, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10039, 10043, 10060, 10271, 10557, 10677, 10951, 10952, 10973, 10977, 11009, 11958, 12129, 40015, 40067, 40073, 40082, 40086, 40095, 40145, 40151, 40271, 40461, 40462, 40530, 40629},
		[10801] = {20631, 40069, 40070, 40071, 40072, 40074, 40289, 30205, 30225, 30251, 30288, 30305, 30465, 30562, 40068, 20398, 20400, 20431, 20526, 20628, 20887, 21055, 21056, 21059, 21060, 21061, 21062, 21072, 30201, 30202, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10947, 10948, 10949, 10950, 10957, 10997, 11106, 11171, 11172, 11206, 12106, 12107, 20357, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10039, 10043, 10060, 10271, 10557, 10677, 10951, 10952, 10973, 10977, 11009, 11958, 12129, 40015, 40067, 40073, 40082, 40086, 40095, 40145, 40151, 40271, 40461, 40462, 40530, 40629}, [10810] = {20631, 40069, 40070, 40071, 40072, 40074, 40289, 30205, 30225, 30251, 30288, 30305, 30465, 30562, 40068, 20398, 20400, 20431, 20526, 20628, 20887, 21055, 21056, 21059, 21060, 21061, 21062, 21072, 30201, 30202, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10947, 10948, 10949, 10950, 10957, 10997, 11106, 11171, 11172, 11206, 12106, 12107, 20357, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10039, 10043, 10060, 10271, 10557, 10677, 10951, 10952, 10973, 10977, 11009, 11958, 12129, 40015, 40067, 40073, 40082, 40086, 40095, 40145, 40151, 40271, 40461, 40462, 40530, 40629}, [10850] = {20631, 40069, 40070, 40071, 40072, 40074, 40289, 30205, 30225, 30251, 30288, 30305, 30465, 30562, 40068, 20398, 20400, 20431, 20526, 20628, 20887, 21055, 21056, 21059, 21060, 21061, 21062, 21072, 30201, 30202, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10947, 10948, 10949, 10950, 10957, 10997, 11106, 11171, 11172, 11206, 12106, 12107, 20357, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10039, 10043, 10060, 10271, 10557, 10677, 10951, 10952, 10973, 10977, 11009, 11958, 12129, 40015, 40067, 40073, 40082, 40086, 40095, 40145, 40151, 40271, 40461, 40462, 40530, 40629},
		[8] = {11156, 40157, 40140, 40141, 40173, 30153, 30267, 30389, 30554, 11151, 11153, 11154, 11157, 11158, 11252, 11632, 20433, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10218, 10656, 11129, 11147, 11148, 11149, 11150, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 10302, 40186, 40207, 40228, 40229, 40311, 40460, 20664, 30388, 40142, 40143, 40664, 40617},
		[10901] = {11156, 40157, 40140, 40141, 40173, 30153, 30267, 30389, 30554, 11151, 11153, 11154, 11157, 11158, 11252, 11632, 20433, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10218, 10656, 11129, 11147, 11148, 11149, 11150, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 10302, 40186, 40207, 40228, 40229, 40311, 40460, 20664, 30388, 40142, 40143, 40664, 40617}, [10910] = {11156, 40157, 40140, 40141, 40173, 30153, 30267, 30389, 30554, 11151, 11153, 11154, 11157, 11158, 11252, 11632, 20433, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10218, 10656, 11129, 11147, 11148, 11149, 11150, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 10302, 40186, 40207, 40228, 40229, 40311, 40460, 20664, 30388, 40142, 40143, 40664, 40617}, [10950] = {11156, 40157, 40140, 40141, 40173, 30153, 30267, 30389, 30554, 11151, 11153, 11154, 11157, 11158, 11252, 11632, 20433, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10218, 10656, 11129, 11147, 11148, 11149, 11150, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 10302, 40186, 40207, 40228, 40229, 40311, 40460, 20664, 30388, 40142, 40143, 40664, 40617},
		[9] = {11558, 11645, 20700, 40669, 40670, 40671, 40672, 40700, 40723, 30380, 30396, 40318, 40319, 40320, 40323, 40345, 40516, 40556, 12207, 12217, 12257, 12293, 20678, 20680, 20682, 20683, 20698, 20699, 20703, 20704, 20759, 20771, 21102, 21104, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10162, 10324, 11536, 11537, 11538, 11539, 11540, 11541, 11542, 11544, 11545, 11647, 11692, 12205, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 40321},
		[11001] = {11558, 11645, 20700, 40669, 40670, 40671, 40672, 40700, 40723, 30380, 30396, 40318, 40319, 40320, 40323, 40345, 40516, 40556, 12207, 12217, 12257, 12293, 20678, 20680, 20682, 20683, 20698, 20699, 20703, 20704, 20759, 20771, 21102, 21104, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10162, 10324, 11536, 11537, 11538, 11539, 11540, 11541, 11542, 11544, 11545, 11647, 11692, 12205, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 40321}, [11010] = {11558, 11645, 20700, 40669, 40670, 40671, 40672, 40700, 40723, 30380, 30396, 40318, 40319, 40320, 40323, 40345, 40516, 40556, 12207, 12217, 12257, 12293, 20678, 20680, 20682, 20683, 20698, 20699, 20703, 20704, 20759, 20771, 21102, 21104, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10162, 10324, 11536, 11537, 11538, 11539, 11540, 11541, 11542, 11544, 11545, 11647, 11692, 12205, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 40321}, [11050] = {11558, 11645, 20700, 40669, 40670, 40671, 40672, 40700, 40723, 30380, 30396, 40318, 40319, 40320, 40323, 40345, 40516, 40556, 12207, 12217, 12257, 12293, 20678, 20680, 20682, 20683, 20698, 20699, 20703, 20704, 20759, 20771, 21102, 21104, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10162, 10324, 11536, 11537, 11538, 11539, 11540, 11541, 11542, 11544, 11545, 11647, 11692, 12205, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 40321},
		[10] = {40523, 40522, 40185, 40188, 40189, 40519, 40520, 40521, 21004, 21095, 21111, 21116, 21117, 30289, 30297, 40181, 11922, 11923, 11924, 11925, 11926, 11927, 11928, 11929, 12238, 12239, 20506, 20507, 20508, 20512, 20717, 30061, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 11277, 11278, 11279, 11280, 11281, 11282, 11283, 11284, 11285, 11570, 11828, 11829, 11830, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060},
		[11101] = {40523, 40522, 40185, 40188, 40189, 40519, 40520, 40521, 21004, 21095, 21111, 21116, 21117, 30289, 30297, 40181, 11922, 11923, 11924, 11925, 11926, 11927, 11928, 11929, 12238, 12239, 20506, 20507, 20508, 20512, 20717, 30061, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 11277, 11278, 11279, 11280, 11281, 11282, 11283, 11284, 11285, 11570, 11828, 11829, 11830, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060}, [11110] = {40523, 40522, 40185, 40188, 40189, 40519, 40520, 40521, 21004, 21095, 21111, 21116, 21117, 30289, 30297, 40181, 11922, 11923, 11924, 11925, 11926, 11927, 11928, 11929, 12238, 12239, 20506, 20507, 20508, 20512, 20717, 30061, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 11277, 11278, 11279, 11280, 11281, 11282, 11283, 11284, 11285, 11570, 11828, 11829, 11830, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060}, [11150] = {40523, 40522, 40185, 40188, 40189, 40519, 40520, 40521, 21004, 21095, 21111, 21116, 21117, 30289, 30297, 40181, 11922, 11923, 11924, 11925, 11926, 11927, 11928, 11929, 12238, 12239, 20506, 20507, 20508, 20512, 20717, 30061, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 11277, 11278, 11279, 11280, 11281, 11282, 11283, 11284, 11285, 11570, 11828, 11829, 11830, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060},
		[11] = {21007, 40237, 40238, 30445, 30446, 30447, 30533, 11377, 20567, 20568, 20569, 20570, 20577, 20581, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 10008, 11372, 11373, 11374, 11375, 11376, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 40571, 40605},
		[11201] = {21007, 40237, 40238, 30445, 30446, 30447, 30533, 11377, 20567, 20568, 20569, 20570, 20577, 20581, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 10008, 11372, 11373, 11374, 11375, 11376, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 40571, 40605}, [11210] = {21007, 40237, 40238, 30445, 30446, 30447, 30533, 11377, 20567, 20568, 20569, 20570, 20577, 20581, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 10008, 11372, 11373, 11374, 11375, 11376, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 40571, 40605}, [11250] = {21007, 40237, 40238, 30445, 30446, 30447, 30533, 11377, 20567, 20568, 20569, 20570, 20577, 20581, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 10008, 11372, 11373, 11374, 11375, 11376, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 10145, 10152, 40571, 40605},
		[12] = {30128, 30083, 20324, 30082, 10312, 10313, 20119, 20220, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 10309, 10310, 10311, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 40025, 40026, 10230, 10237, 10238},
		[11301] = {30128, 30083, 20324, 30082, 10312, 10313, 20119, 20220, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 10309, 10310, 10311, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 40025, 40026, 10230, 10237, 10238}, [11310] = {30128, 30083, 20324, 30082, 10312, 10313, 20119, 20220, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 10309, 10310, 10311, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 40025, 40026, 10230, 10237, 10238}, [11350] = {30128, 30083, 20324, 30082, 10312, 10313, 20119, 20220, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 10309, 10310, 10311, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 40025, 40026, 10230, 10237, 10238},
		[13] = {21028, 40135, 40191, 40242, 40591, 40592, 40593, 40594, 20126, 21026, 21027, 21085, 21086, 21087, 21088, 30576, 40134, 10928, 11011, 11012, 11193, 11418, 12049, 12158, 12159, 12160, 12161, 12162, 12163, 12164, 12165, 12171, 12172, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 10095, 10096, 10364, 10365, 10379, 10394, 10735, 10747, 10764, 10765, 10793, 10873, 10874, 10875, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 40085, 40699},
		[11401] = {21028, 40135, 40191, 40242, 40591, 40592, 40593, 40594, 20126, 21026, 21027, 21085, 21086, 21087, 21088, 30576, 40134, 10928, 11011, 11012, 11193, 11418, 12049, 12158, 12159, 12160, 12161, 12162, 12163, 12164, 12165, 12171, 12172, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 10095, 10096, 10364, 10365, 10379, 10394, 10735, 10747, 10764, 10765, 10793, 10873, 10874, 10875, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 40085, 40699}, [11410] = {21028, 40135, 40191, 40242, 40591, 40592, 40593, 40594, 20126, 21026, 21027, 21085, 21086, 21087, 21088, 30576, 40134, 10928, 11011, 11012, 11193, 11418, 12049, 12158, 12159, 12160, 12161, 12162, 12163, 12164, 12165, 12171, 12172, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 10095, 10096, 10364, 10365, 10379, 10394, 10735, 10747, 10764, 10765, 10793, 10873, 10874, 10875, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 40085, 40699}, [11450] = {21028, 40135, 40191, 40242, 40591, 40592, 40593, 40594, 20126, 21026, 21027, 21085, 21086, 21087, 21088, 30576, 40134, 10928, 11011, 11012, 11193, 11418, 12049, 12158, 12159, 12160, 12161, 12162, 12163, 12164, 12165, 12171, 12172, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 10095, 10096, 10364, 10365, 10379, 10394, 10735, 10747, 10764, 10765, 10793, 10873, 10874, 10875, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 40085, 40699},
		[14] = {20711, 30134, 30313, 30314, 20128, 20149, 20284, 20554, 10497, 10548, 11162, 11354, 11355, 11516, 20042, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 10083, 10084, 10213, 10281, 10282, 10287, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 11364, 11884, 20046, 20116, 21071, 30115, 40230, 40473, 40517, 21145, 21146, 30594, 30595, 40726, 40736},
		[11501] = {20711, 30134, 30313, 30314, 20128, 20149, 20284, 20554, 10497, 10548, 11162, 11354, 11355, 11516, 20042, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 10083, 10084, 10213, 10281, 10282, 10287, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 11364, 11884, 20046, 20116, 21071, 30115, 40230, 40473, 40517, 21145, 21146, 30594, 30595, 40726, 40736}, [11510] = {20711, 30134, 30313, 30314, 20128, 20149, 20284, 20554, 10497, 10548, 11162, 11354, 11355, 11516, 20042, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 10083, 10084, 10213, 10281, 10282, 10287, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 11364, 11884, 20046, 20116, 21071, 30115, 40230, 40473, 40517, 21145, 21146, 30594, 30595, 40726, 40736}, [11550] = {20711, 30134, 30313, 30314, 20128, 20149, 20284, 20554, 10497, 10548, 11162, 11354, 11355, 11516, 20042, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 10083, 10084, 10213, 10281, 10282, 10287, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 11364, 11884, 20046, 20116, 21071, 30115, 40230, 40473, 40517, 21145, 21146, 30594, 30595, 40726, 40736},
		[15] = {20995, 20378, 20996, 30139, 30140, 30141, 11986, 20023, 20202, 20203, 20204, 20205, 10652, 10653, 10654, 11221, 11290, 11291, 11292, 11716, 11717, 11729, 11985, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 10045, 10644, 10645, 10646, 10647, 10648, 10649, 10650, 10651, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180},
		[11601] = {20995, 20378, 20996, 30139, 30140, 30141, 11986, 20023, 20202, 20203, 20204, 20205, 10652, 10653, 10654, 11221, 11290, 11291, 11292, 11716, 11717, 11729, 11985, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 10045, 10644, 10645, 10646, 10647, 10648, 10649, 10650, 10651, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180}, [11610] = {20995, 20378, 20996, 30139, 30140, 30141, 11986, 20023, 20202, 20203, 20204, 20205, 10652, 10653, 10654, 11221, 11290, 11291, 11292, 11716, 11717, 11729, 11985, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 10045, 10644, 10645, 10646, 10647, 10648, 10649, 10650, 10651, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180}, [11650] = {20995, 20378, 20996, 30139, 30140, 30141, 11986, 20023, 20202, 20203, 20204, 20205, 10652, 10653, 10654, 11221, 11290, 11291, 11292, 11716, 11717, 11729, 11985, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 10045, 10644, 10645, 10646, 10647, 10648, 10649, 10650, 10651, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180},
		[16] = {21022, 20235, 20644, 20761, 11488, 20170, 20234, 10348, 10349, 10350, 10351, 11487, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 10344, 10345, 10346, 10347, 11340, 11510, 11512, 11665, 12204, 20016, 20045},
		[11701] = {21022, 20235, 20644, 20761, 11488, 20170, 20234, 10348, 10349, 10350, 10351, 11487, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 10344, 10345, 10346, 10347, 11340, 11510, 11512, 11665, 12204, 20016, 20045}, [11710] = {21022, 20235, 20644, 20761, 11488, 20170, 20234, 10348, 10349, 10350, 10351, 11487, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 10344, 10345, 10346, 10347, 11340, 11510, 11512, 11665, 12204, 20016, 20045}, [11750] = {21022, 20235, 20644, 20761, 11488, 20170, 20234, 10348, 10349, 10350, 10351, 11487, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 10344, 10345, 10346, 10347, 11340, 11510, 11512, 11665, 12204, 20016, 20045},
		[17] = {40388, 40314, 20785, 20786, 20787, 30374, 30403, 40313, 11670, 11671, 11672, 20335, 20672, 20674, 20783, 20784, 10915, 10916, 10917, 10924, 11521, 11522, 11523, 11524, 11525, 11526, 11527, 11667, 11668, 11669, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 10087, 10904, 10905, 10906, 10907, 10908, 10909, 10910, 10911, 10912, 10913, 10914, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199},
		[11801] = {40388, 40314, 20785, 20786, 20787, 30374, 30403, 40313, 11670, 11671, 11672, 20335, 20672, 20674, 20783, 20784, 10915, 10916, 10917, 10924, 11521, 11522, 11523, 11524, 11525, 11526, 11527, 11667, 11668, 11669, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 10087, 10904, 10905, 10906, 10907, 10908, 10909, 10910, 10911, 10912, 10913, 10914, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199}, [11810] = {40388, 40314, 20785, 20786, 20787, 30374, 30403, 40313, 11670, 11671, 11672, 20335, 20672, 20674, 20783, 20784, 10915, 10916, 10917, 10924, 11521, 11522, 11523, 11524, 11525, 11526, 11527, 11667, 11668, 11669, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 10087, 10904, 10905, 10906, 10907, 10908, 10909, 10910, 10911, 10912, 10913, 10914, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199}, [11850] = {40388, 40314, 20785, 20786, 20787, 30374, 30403, 40313, 11670, 11671, 11672, 20335, 20672, 20674, 20783, 20784, 10915, 10916, 10917, 10924, 11521, 11522, 11523, 11524, 11525, 11526, 11527, 11667, 11668, 11669, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 10087, 10904, 10905, 10906, 10907, 10908, 10909, 10910, 10911, 10912, 10913, 10914, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199},
		[18] = {11145, 11513, 10704, 11033, 30426, 30369, 30427, 30467, 30469, 40470, 40471, 30119, 30164, 30191, 30258, 30366, 30367, 30368, 11293, 11294, 11313, 11552, 11553, 11848, 11883, 12074, 12113, 12264, 20222, 20240, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 10085, 10246, 10265, 10289, 10420, 10560, 10766, 11030, 11031, 11032, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033},
		[11901] = {11145, 11513, 10704, 11033, 30426, 30369, 30427, 30467, 30469, 40470, 40471, 30119, 30164, 30191, 30258, 30366, 30367, 30368, 11293, 11294, 11313, 11552, 11553, 11848, 11883, 12074, 12113, 12264, 20222, 20240, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 10085, 10246, 10265, 10289, 10420, 10560, 10766, 11030, 11031, 11032, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033}, [11910] = {11145, 11513, 10704, 11033, 30426, 30369, 30427, 30467, 30469, 40470, 40471, 30119, 30164, 30191, 30258, 30366, 30367, 30368, 11293, 11294, 11313, 11552, 11553, 11848, 11883, 12074, 12113, 12264, 20222, 20240, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 10085, 10246, 10265, 10289, 10420, 10560, 10766, 11030, 11031, 11032, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033}, [11950] = {11145, 11513, 10704, 11033, 30426, 30369, 30427, 30467, 30469, 40470, 40471, 30119, 30164, 30191, 30258, 30366, 30367, 30368, 11293, 11294, 11313, 11552, 11553, 11848, 11883, 12074, 12113, 12264, 20222, 20240, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 10085, 10246, 10265, 10289, 10420, 10560, 10766, 11030, 11031, 11032, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033},
		[19] = {40046, 30152, 20826, 20253, 20254, 20825, 11745, 11746, 11749, 20251, 20252, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10695, 10696, 10697, 10698, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10335, 10336, 10337},
		[12001] = {40046, 30152, 20826, 20253, 20254, 20825, 11745, 11746, 11749, 20251, 20252, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10695, 10696, 10697, 10698, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10335, 10336, 10337}, [12010] = {40046, 30152, 20826, 20253, 20254, 20825, 11745, 11746, 11749, 20251, 20252, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10695, 10696, 10697, 10698, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10335, 10336, 10337}, [12050] = {40046, 30152, 20826, 20253, 20254, 20825, 11745, 11746, 11749, 20251, 20252, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10695, 10696, 10697, 10698, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10335, 10336, 10337},
		[20] = {20054, 20301, 30171, 40047, 30066, 40052, 40659, 40662, 20117, 20333, 21094, 30064, 30065, 10284, 10285, 10783, 10784, 10785, 10786, 11694, 12192, 20053, 10135, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10075, 10076, 10077, 10119, 10120, 10121, 10122, 10123, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 21146, 30594, 30595},
		[12101] = {20054, 20301, 30171, 40047, 30066, 40052, 40659, 40662, 20117, 20333, 21094, 30064, 30065, 10284, 10285, 10783, 10784, 10785, 10786, 11694, 12192, 20053, 10135, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10075, 10076, 10077, 10119, 10120, 10121, 10122, 10123, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 21146, 30594, 30595}, [12110] = {20054, 20301, 30171, 40047, 30066, 40052, 40659, 40662, 20117, 20333, 21094, 30064, 30065, 10284, 10285, 10783, 10784, 10785, 10786, 11694, 12192, 20053, 10135, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10075, 10076, 10077, 10119, 10120, 10121, 10122, 10123, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 21146, 30594, 30595}, [12150] = {20054, 20301, 30171, 40047, 30066, 40052, 40659, 40662, 20117, 20333, 21094, 30064, 30065, 10284, 10285, 10783, 10784, 10785, 10786, 11694, 12192, 20053, 10135, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10075, 10076, 10077, 10119, 10120, 10121, 10122, 10123, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 21146, 30594, 30595},
	}
	ClientData._charCardsMap = CHAR_CARDS_MAP

	local LIYA_CARDS_MAP = {
		[1] = {40588, 20557, 30121, 40232, 40553, 11360, 11361, 11362, 11371, 20556, 10489, 10490, 10576, 11008, 11356, 11357, 11358, 11359, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10482, 10483, 10484, 10485, 10486, 10487, 10488, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 40094, 40163},
		[101001] = {40588, 20557, 30121, 40232, 40553, 11360, 11361, 11362, 11371, 20556, 10489, 10490, 10576, 11008, 11356, 11357, 11358, 11359, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10482, 10483, 10484, 10485, 10486, 10487, 10488, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 40094, 40163}, [101010] = {40588, 20557, 30121, 40232, 40553, 11360, 11361, 11362, 11371, 20556, 10489, 10490, 10576, 11008, 11356, 11357, 11358, 11359, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10482, 10483, 10484, 10485, 10486, 10487, 10488, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 40094, 40163}, [101050] = {40588, 20557, 30121, 40232, 40553, 11360, 11361, 11362, 11371, 20556, 10489, 10490, 10576, 11008, 11356, 11357, 11358, 11359, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10482, 10483, 10484, 10485, 10486, 10487, 10488, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 40094, 40163},
		[2] = {20917, 30222, 30223, 30489, 40505, 20395, 20396, 20571, 21084, 30220, 30221, 11063, 11064, 11065, 11900, 12025, 12026, 12027, 12300, 20392, 20393, 10183, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 11044, 11045, 11046, 11054, 11059, 11060, 11061, 11062, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 40104, 40105},
		[102001] = {20917, 30222, 30223, 30489, 40505, 20395, 20396, 20571, 21084, 30220, 30221, 11063, 11064, 11065, 11900, 12025, 12026, 12027, 12300, 20392, 20393, 10183, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 11044, 11045, 11046, 11054, 11059, 11060, 11061, 11062, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 40104, 40105}, [102010] = {20917, 30222, 30223, 30489, 40505, 20395, 20396, 20571, 21084, 30220, 30221, 11063, 11064, 11065, 11900, 12025, 12026, 12027, 12300, 20392, 20393, 10183, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 11044, 11045, 11046, 11054, 11059, 11060, 11061, 11062, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 40104, 40105}, [102050] = {20917, 30222, 30223, 30489, 40505, 20395, 20396, 20571, 21084, 30220, 30221, 11063, 11064, 11065, 11900, 12025, 12026, 12027, 12300, 20392, 20393, 10183, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 11044, 11045, 11046, 11054, 11059, 11060, 11061, 11062, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 40104, 40105},
		[3] = {20565, 40210, 40211, 40212, 40616, 21018, 21020, 30400, 30423, 30424, 30425, 30551, 11326, 11327, 11328, 11368, 12039, 12040, 12091, 12092, 20534, 20535, 20536, 20538, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 10065, 10797, 11318, 11319, 11320, 11321, 11322, 11323, 11324, 11325, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 40213, 40498},
		[103001] = {20565, 40210, 40211, 40212, 40616, 21018, 21020, 30400, 30423, 30424, 30425, 30551, 11326, 11327, 11328, 11368, 12039, 12040, 12091, 12092, 20534, 20535, 20536, 20538, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 10065, 10797, 11318, 11319, 11320, 11321, 11322, 11323, 11324, 11325, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 40213, 40498}, [103010] = {20565, 40210, 40211, 40212, 40616, 21018, 21020, 30400, 30423, 30424, 30425, 30551, 11326, 11327, 11328, 11368, 12039, 12040, 12091, 12092, 20534, 20535, 20536, 20538, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 10065, 10797, 11318, 11319, 11320, 11321, 11322, 11323, 11324, 11325, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 40213, 40498}, [103050] = {20565, 40210, 40211, 40212, 40616, 21018, 21020, 30400, 30423, 30424, 30425, 30551, 11326, 11327, 11328, 11368, 12039, 12040, 12091, 12092, 20534, 20535, 20536, 20538, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 20057, 20069, 10065, 10797, 11318, 11319, 11320, 11321, 11322, 11323, 11324, 11325, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 40213, 40498},
		[4] = {11399, 30322, 30323, 30324, 40246, 12144, 12215, 20584, 20585, 20586, 11393, 11394, 11395, 11396, 11397, 11398, 11400, 11401, 11493, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 10325, 10514, 10515, 10669, 10748, 10781, 10782, 10922, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 40275, 40282},
		[104001] = {11399, 30322, 30323, 30324, 40246, 12144, 12215, 20584, 20585, 20586, 11393, 11394, 11395, 11396, 11397, 11398, 11400, 11401, 11493, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 10325, 10514, 10515, 10669, 10748, 10781, 10782, 10922, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 40275, 40282}, [104010] = {11399, 30322, 30323, 30324, 40246, 12144, 12215, 20584, 20585, 20586, 11393, 11394, 11395, 11396, 11397, 11398, 11400, 11401, 11493, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 10325, 10514, 10515, 10669, 10748, 10781, 10782, 10922, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 40275, 40282}, [104050] = {11399, 30322, 30323, 30324, 40246, 12144, 12215, 20584, 20585, 20586, 11393, 11394, 11395, 11396, 11397, 11398, 11400, 11401, 11493, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 10325, 10514, 10515, 10669, 10748, 10781, 10782, 10922, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 40275, 40282},
		[5] = {11195, 40115, 30379, 40090, 40091, 40092, 11092, 11947, 11948, 20360, 20959, 10993, 10994, 10995, 10996, 11075, 11079, 11080, 11081, 11091, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10412, 10986, 10987, 10988, 10989, 10990, 10991, 10992, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 40093, 40203, 40478, 40480, 40531},
		[105001] = {11195, 40115, 30379, 40090, 40091, 40092, 11092, 11947, 11948, 20360, 20959, 10993, 10994, 10995, 10996, 11075, 11079, 11080, 11081, 11091, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10412, 10986, 10987, 10988, 10989, 10990, 10991, 10992, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 40093, 40203, 40478, 40480, 40531}, [105010] = {11195, 40115, 30379, 40090, 40091, 40092, 11092, 11947, 11948, 20360, 20959, 10993, 10994, 10995, 10996, 11075, 11079, 11080, 11081, 11091, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10412, 10986, 10987, 10988, 10989, 10990, 10991, 10992, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 40093, 40203, 40478, 40480, 40531}, [105050] = {11195, 40115, 30379, 40090, 40091, 40092, 11092, 11947, 11948, 20360, 20959, 10993, 10994, 10995, 10996, 11075, 11079, 11080, 11081, 11091, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10412, 10986, 10987, 10988, 10989, 10990, 10991, 10992, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 40093, 40203, 40478, 40480, 40531},
		[6] = {11707, 40174, 40114, 40704, 40705, 40706, 30228, 30422, 30590, 40088, 40112, 40113, 11434, 11435, 11436, 11437, 12253, 20406, 20407, 21123, 30226, 30227, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 11085, 11086, 11087, 11088, 11089, 11090, 11432, 11433, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 40110, 40111, 40399, 40457},
		[106001] = {11707, 40174, 40114, 40704, 40705, 40706, 30228, 30422, 30590, 40088, 40112, 40113, 11434, 11435, 11436, 11437, 12253, 20406, 20407, 21123, 30226, 30227, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 11085, 11086, 11087, 11088, 11089, 11090, 11432, 11433, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 40110, 40111, 40399, 40457}, [106010] = {11707, 40174, 40114, 40704, 40705, 40706, 30228, 30422, 30590, 40088, 40112, 40113, 11434, 11435, 11436, 11437, 12253, 20406, 20407, 21123, 30226, 30227, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 11085, 11086, 11087, 11088, 11089, 11090, 11432, 11433, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 40110, 40111, 40399, 40457}, [106050] = {11707, 40174, 40114, 40704, 40705, 40706, 30228, 30422, 30590, 40088, 40112, 40113, 11434, 11435, 11436, 11437, 12253, 20406, 20407, 21123, 30226, 30227, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 11085, 11086, 11087, 11088, 11089, 11090, 11432, 11433, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 40110, 40111, 40399, 40457},
		[7] = {40627, 40550, 30516, 30517, 30518, 20990, 20991, 30515, 11977, 11978, 11979, 12189, 20989, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 11973, 11974, 11975, 11976, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 20449, 20450, 20679, 20706, 20837},
		[107001] = {40627, 40550, 30516, 30517, 30518, 20990, 20991, 30515, 11977, 11978, 11979, 12189, 20989, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 11973, 11974, 11975, 11976, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 20449, 20450, 20679, 20706, 20837}, [107010] = {40627, 40550, 30516, 30517, 30518, 20990, 20991, 30515, 11977, 11978, 11979, 12189, 20989, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 11973, 11974, 11975, 11976, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 20449, 20450, 20679, 20706, 20837}, [107050] = {40627, 40550, 30516, 30517, 30518, 20990, 20991, 30515, 11977, 11978, 11979, 12189, 20989, 12130, 12284, 20004, 20007, 20008, 20017, 20018, 20022, 20033, 11973, 11974, 11975, 11976, 10207, 10209, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 20449, 20450, 20679, 20706, 20837},
		[8] = {20615, 20614, 11595, 20613, 11456, 11457, 11458, 11451, 11452, 11453, 11454, 11455, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 11447, 11448, 11449, 11450, 20045, 20060, 20062, 20063, 20064, 20067, 20078},
		[108001] = {20615, 20614, 11595, 20613, 11456, 11457, 11458, 11451, 11452, 11453, 11454, 11455, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 11447, 11448, 11449, 11450, 20045, 20060, 20062, 20063, 20064, 20067, 20078}, [108010] = {20615, 20614, 11595, 20613, 11456, 11457, 11458, 11451, 11452, 11453, 11454, 11455, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 11447, 11448, 11449, 11450, 20045, 20060, 20062, 20063, 20064, 20067, 20078}, [108050] = {20615, 20614, 11595, 20613, 11456, 11457, 11458, 11451, 11452, 11453, 11454, 11455, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 11447, 11448, 11449, 11450, 20045, 20060, 20062, 20063, 20064, 20067, 20078},
		[9] = {30547, 30461, 30459, 30460, 20881, 20882, 30457, 30458, 11840, 11841, 12075, 12076, 12193, 12289, 20880, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10149, 10150, 11834, 11835, 11836, 11837, 11838, 11839, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 21025, 40417},
		[109001] = {30547, 30461, 30459, 30460, 20881, 20882, 30457, 30458, 11840, 11841, 12075, 12076, 12193, 12289, 20880, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10149, 10150, 11834, 11835, 11836, 11837, 11838, 11839, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 21025, 40417}, [109010] = {30547, 30461, 30459, 30460, 20881, 20882, 30457, 30458, 11840, 11841, 12075, 12076, 12193, 12289, 20880, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10149, 10150, 11834, 11835, 11836, 11837, 11838, 11839, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 21025, 40417}, [109050] = {30547, 30461, 30459, 30460, 20881, 20882, 30457, 30458, 11840, 11841, 12075, 12076, 12193, 12289, 20880, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 10148, 10149, 10150, 11834, 11835, 11836, 11837, 11838, 11839, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 21025, 40417},
		[10] = {40707, 40555, 30531, 30532, 40312, 20667, 20925, 30364, 30486, 11509, 12012, 12190, 12267, 12286, 20659, 20660, 20663, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11502, 11503, 11504, 11505, 11506, 11507, 11508, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198},
		[110001] = {40707, 40555, 30531, 30532, 40312, 20667, 20925, 30364, 30486, 11509, 12012, 12190, 12267, 12286, 20659, 20660, 20663, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11502, 11503, 11504, 11505, 11506, 11507, 11508, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198}, [110010] = {40707, 40555, 30531, 30532, 40312, 20667, 20925, 30364, 30486, 11509, 12012, 12190, 12267, 12286, 20659, 20660, 20663, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11502, 11503, 11504, 11505, 11506, 11507, 11508, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198}, [110050] = {40707, 40555, 30531, 30532, 40312, 20667, 20925, 30364, 30486, 11509, 12012, 12190, 12267, 12286, 20659, 20660, 20663, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11502, 11503, 11504, 11505, 11506, 11507, 11508, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10192, 10193, 10194, 10196, 10197, 10198},
		[11] = {20836, 20863, 30438, 20832, 20833, 20834, 20835, 11772, 11773, 11774, 11775, 11776, 11777, 12109, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 11766, 11767, 11768, 11769, 11770, 11771, 10255, 10256, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11421, 11422, 11423, 11424, 11425, 11426, 11427, 11429, 11430, 40215, 40264, 40265, 40269},
		[111001] = {20836, 20863, 30438, 20832, 20833, 20834, 20835, 11772, 11773, 11774, 11775, 11776, 11777, 12109, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 11766, 11767, 11768, 11769, 11770, 11771, 10255, 10256, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11421, 11422, 11423, 11424, 11425, 11426, 11427, 11429, 11430, 40215, 40264, 40265, 40269}, [111010] = {20836, 20863, 30438, 20832, 20833, 20834, 20835, 11772, 11773, 11774, 11775, 11776, 11777, 12109, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 11766, 11767, 11768, 11769, 11770, 11771, 10255, 10256, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11421, 11422, 11423, 11424, 11425, 11426, 11427, 11429, 11430, 40215, 40264, 40265, 40269}, [111050] = {20836, 20863, 30438, 20832, 20833, 20834, 20835, 11772, 11773, 11774, 11775, 11776, 11777, 12109, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 11766, 11767, 11768, 11769, 11770, 11771, 10255, 10256, 10257, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11421, 11422, 11423, 11424, 11425, 11426, 11427, 11429, 11430, 40215, 40264, 40265, 40269},
		[12] = {20246, 20478, 20789, 30497, 30498, 40005, 40101, 30108, 30137, 30142, 30143, 30358, 20207, 20208, 20386, 20650, 20906, 20930, 20978, 20979, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10074, 11222, 11403, 12066, 20169, 20194, 20206, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018},
		[112001] = {20246, 20478, 20789, 30497, 30498, 40005, 40101, 30108, 30137, 30142, 30143, 30358, 20207, 20208, 20386, 20650, 20906, 20930, 20978, 20979, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10074, 11222, 11403, 12066, 20169, 20194, 20206, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018}, [112010] = {20246, 20478, 20789, 30497, 30498, 40005, 40101, 30108, 30137, 30142, 30143, 30358, 20207, 20208, 20386, 20650, 20906, 20930, 20978, 20979, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10074, 11222, 11403, 12066, 20169, 20194, 20206, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018}, [112050] = {20246, 20478, 20789, 30497, 30498, 40005, 40101, 30108, 30137, 30142, 30143, 30358, 20207, 20208, 20386, 20650, 20906, 20930, 20978, 20979, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10074, 11222, 11403, 12066, 20169, 20194, 20206, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018},
		[13] = {40350, 40353, 40366, 40390, 40423, 40566, 20724, 20725, 20726, 40351, 40352, 11607, 11629, 11761, 11998, 11999, 20720, 20721, 20722, 20723, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 11599, 11600, 11601, 11602, 11603, 11604, 11605, 11606, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10109, 10507, 10508, 11160, 11286, 11532, 11533, 11535, 11955, 11956, 11957, 11996, 11997, 12143, 12170, 12200, 12201, 12202, 20153, 20226, 20490, 21078, 21101, 30154, 30571, 30583, 40144, 40316, 40532, 40533, 40668},
		[113001] = {40350, 40353, 40366, 40390, 40423, 40566, 20724, 20725, 20726, 40351, 40352, 11607, 11629, 11761, 11998, 11999, 20720, 20721, 20722, 20723, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 11599, 11600, 11601, 11602, 11603, 11604, 11605, 11606, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10109, 10507, 10508, 11160, 11286, 11532, 11533, 11535, 11955, 11956, 11957, 11996, 11997, 12143, 12170, 12200, 12201, 12202, 20153, 20226, 20490, 21078, 21101, 30154, 30571, 30583, 40144, 40316, 40532, 40533, 40668}, [113010] = {40350, 40353, 40366, 40390, 40423, 40566, 20724, 20725, 20726, 40351, 40352, 11607, 11629, 11761, 11998, 11999, 20720, 20721, 20722, 20723, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 11599, 11600, 11601, 11602, 11603, 11604, 11605, 11606, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10109, 10507, 10508, 11160, 11286, 11532, 11533, 11535, 11955, 11956, 11957, 11996, 11997, 12143, 12170, 12200, 12201, 12202, 20153, 20226, 20490, 21078, 21101, 30154, 30571, 30583, 40144, 40316, 40532, 40533, 40668}, [113050] = {40350, 40353, 40366, 40390, 40423, 40566, 20724, 20725, 20726, 40351, 40352, 11607, 11629, 11761, 11998, 11999, 20720, 20721, 20722, 20723, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 11599, 11600, 11601, 11602, 11603, 11604, 11605, 11606, 10138, 10141, 10142, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10109, 10507, 10508, 11160, 11286, 11532, 11533, 11535, 11955, 11956, 11957, 11996, 11997, 12143, 12170, 12200, 12201, 12202, 20153, 20226, 20490, 21078, 21101, 30154, 30571, 30583, 40144, 40316, 40532, 40533, 40668},
		[14] = {40685, 40678, 40600, 40601, 40602, 40603, 40612, 21121, 30543, 30550, 40598, 40599, 12246, 21032, 21033, 21034, 21035, 21036, 21037, 21038, 21050, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12057, 12058, 12059, 12060, 12061, 12062, 12063, 12086, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 40463, 40464, 40465, 40466, 40663},
		[114001] = {40685, 40678, 40600, 40601, 40602, 40603, 40612, 21121, 30543, 30550, 40598, 40599, 12246, 21032, 21033, 21034, 21035, 21036, 21037, 21038, 21050, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12057, 12058, 12059, 12060, 12061, 12062, 12063, 12086, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 40463, 40464, 40465, 40466, 40663}, [114010] = {40685, 40678, 40600, 40601, 40602, 40603, 40612, 21121, 30543, 30550, 40598, 40599, 12246, 21032, 21033, 21034, 21035, 21036, 21037, 21038, 21050, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12057, 12058, 12059, 12060, 12061, 12062, 12063, 12086, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 40463, 40464, 40465, 40466, 40663}, [114050] = {40685, 40678, 40600, 40601, 40602, 40603, 40612, 21121, 30543, 30550, 40598, 40599, 12246, 21032, 21033, 21034, 21035, 21036, 21037, 21038, 21050, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 12057, 12058, 12059, 12060, 12061, 12062, 12063, 12086, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 40463, 40464, 40465, 40466, 40663},
		[15] = {11727, 40618, 40619, 40620, 40621, 40622, 40623, 40720, 30430, 30431, 30432, 30555, 30556, 30557, 30558, 30559, 30561, 30565, 12098, 12099, 12100, 12101, 12102, 12114, 12199, 12303, 20818, 20819, 20820, 21024, 21053, 21064, 21130, 30428, 30429, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 30239, 10007, 10012, 11719, 11720, 11721, 11722, 11723, 11724, 11725, 11726, 11728, 12047, 12048, 12094, 12095, 12096, 12097, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 10592},
		[115001] = {11727, 40618, 40619, 40620, 40621, 40622, 40623, 40720, 30430, 30431, 30432, 30555, 30556, 30557, 30558, 30559, 30561, 30565, 12098, 12099, 12100, 12101, 12102, 12114, 12199, 12303, 20818, 20819, 20820, 21024, 21053, 21064, 21130, 30428, 30429, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 30239, 10007, 10012, 11719, 11720, 11721, 11722, 11723, 11724, 11725, 11726, 11728, 12047, 12048, 12094, 12095, 12096, 12097, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 10592}, [115010] = {11727, 40618, 40619, 40620, 40621, 40622, 40623, 40720, 30430, 30431, 30432, 30555, 30556, 30557, 30558, 30559, 30561, 30565, 12098, 12099, 12100, 12101, 12102, 12114, 12199, 12303, 20818, 20819, 20820, 21024, 21053, 21064, 21130, 30428, 30429, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 30239, 10007, 10012, 11719, 11720, 11721, 11722, 11723, 11724, 11725, 11726, 11728, 12047, 12048, 12094, 12095, 12096, 12097, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 10592}, [115050] = {11727, 40618, 40619, 40620, 40621, 40622, 40623, 40720, 30430, 30431, 30432, 30555, 30556, 30557, 30558, 30559, 30561, 30565, 12098, 12099, 12100, 12101, 12102, 12114, 12199, 12303, 20818, 20819, 20820, 21024, 21053, 21064, 21130, 30428, 30429, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 30239, 10007, 10012, 11719, 11720, 11721, 11722, 11723, 11724, 11725, 11726, 11728, 12047, 12048, 12094, 12095, 12096, 12097, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 10592},
		[16] = {40446, 40445, 30579, 40443, 40444, 20868, 30448, 30449, 30454, 11814, 11815, 11816, 11817, 11822, 11823, 20864, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 11808, 11809, 11810, 11811, 11812, 11813, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 11580, 11581, 11582, 11583, 11584, 11585, 11586, 11587, 11588, 11589, 11590, 20712, 20713, 20714, 30386, 30387, 40346, 40347, 40348, 40386, 40554},
		[116001] = {40446, 40445, 30579, 40443, 40444, 20868, 30448, 30449, 30454, 11814, 11815, 11816, 11817, 11822, 11823, 20864, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 11808, 11809, 11810, 11811, 11812, 11813, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 11580, 11581, 11582, 11583, 11584, 11585, 11586, 11587, 11588, 11589, 11590, 20712, 20713, 20714, 30386, 30387, 40346, 40347, 40348, 40386, 40554}, [116010] = {40446, 40445, 30579, 40443, 40444, 20868, 30448, 30449, 30454, 11814, 11815, 11816, 11817, 11822, 11823, 20864, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 11808, 11809, 11810, 11811, 11812, 11813, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 11580, 11581, 11582, 11583, 11584, 11585, 11586, 11587, 11588, 11589, 11590, 20712, 20713, 20714, 30386, 30387, 40346, 40347, 40348, 40386, 40554}, [116050] = {40446, 40445, 30579, 40443, 40444, 20868, 30448, 30449, 30454, 11814, 11815, 11816, 11817, 11822, 11823, 20864, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10079, 10080, 11808, 11809, 11810, 11811, 11812, 11813, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 11580, 11581, 11582, 11583, 11584, 11585, 11586, 11587, 11588, 11589, 11590, 20712, 20713, 20714, 30386, 30387, 40346, 40347, 40348, 40386, 40554},
		[17] = {30521, 40527, 40528, 40529, 30477, 30505, 30506, 30507, 11987, 20952, 20953, 20954, 20955, 20956, 20957, 20997, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 11936, 11937, 11938, 11939, 11940, 11941, 11942, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175},
		[117001] = {30521, 40527, 40528, 40529, 30477, 30505, 30506, 30507, 11987, 20952, 20953, 20954, 20955, 20956, 20957, 20997, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 11936, 11937, 11938, 11939, 11940, 11941, 11942, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175}, [117010] = {30521, 40527, 40528, 40529, 30477, 30505, 30506, 30507, 11987, 20952, 20953, 20954, 20955, 20956, 20957, 20997, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 11936, 11937, 11938, 11939, 11940, 11941, 11942, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175}, [117050] = {30521, 40527, 40528, 40529, 30477, 30505, 30506, 30507, 11987, 20952, 20953, 20954, 20955, 20956, 20957, 20997, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 10223, 10244, 10245, 10247, 11936, 11937, 11938, 11939, 11940, 11941, 11942, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175},
		[18] = {30541, 30540, 21092, 30010, 21030, 21031, 21091, 11196, 11901, 12195, 12196, 20032, 20242, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 10241, 10359, 10360, 10607, 10788, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251},
		[118001] = {30541, 30540, 21092, 30010, 21030, 21031, 21091, 11196, 11901, 12195, 12196, 20032, 20242, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 10241, 10359, 10360, 10607, 10788, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251}, [118010] = {30541, 30540, 21092, 30010, 21030, 21031, 21091, 11196, 11901, 12195, 12196, 20032, 20242, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 10241, 10359, 10360, 10607, 10788, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251}, [118050] = {30541, 30540, 21092, 30010, 21030, 21031, 21091, 11196, 11901, 12195, 12196, 20032, 20242, 11622, 11633, 11730, 11895, 11896, 11946, 12043, 12093, 12130, 10241, 10359, 10360, 10607, 10788, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251},
		[19] = {40285, 40391, 40502, 40284, 40286, 40287, 40340, 30347, 30348, 30349, 30570, 11479, 11480, 11621, 11679, 20632, 20633, 20634, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 11473, 11474, 11475, 11476, 11477, 11478, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125},
		[119001] = {40285, 40391, 40502, 40284, 40286, 40287, 40340, 30347, 30348, 30349, 30570, 11479, 11480, 11621, 11679, 20632, 20633, 20634, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 11473, 11474, 11475, 11476, 11477, 11478, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125}, [119010] = {40285, 40391, 40502, 40284, 40286, 40287, 40340, 30347, 30348, 30349, 30570, 11479, 11480, 11621, 11679, 20632, 20633, 20634, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 11473, 11474, 11475, 11476, 11477, 11478, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125}, [119050] = {40285, 40391, 40502, 40284, 40286, 40287, 40340, 30347, 30348, 30349, 30570, 11479, 11480, 11621, 11679, 20632, 20633, 20634, 20432, 20456, 20493, 20871, 30003, 30006, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 11473, 11474, 11475, 11476, 11477, 11478, 11512, 11665, 12204, 20016, 20045, 20060, 20062, 20063, 20064, 20067, 20078, 20113, 20125},
		[20] = {40703, 40491, 40487, 40488, 40489, 40490, 11891, 11954, 12254, 40484, 40485, 40486, 11865, 11866, 11867, 11868, 11869, 11870, 11871, 11872, 11873, 11890, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 11857, 11858, 11859, 11860, 11861, 11862, 11863, 11864, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 40543, 40544, 40545, 40546, 40547, 40548, 40549},
		[120001] = {40703, 40491, 40487, 40488, 40489, 40490, 11891, 11954, 12254, 40484, 40485, 40486, 11865, 11866, 11867, 11868, 11869, 11870, 11871, 11872, 11873, 11890, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 11857, 11858, 11859, 11860, 11861, 11862, 11863, 11864, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 40543, 40544, 40545, 40546, 40547, 40548, 40549}, [120010] = {40703, 40491, 40487, 40488, 40489, 40490, 11891, 11954, 12254, 40484, 40485, 40486, 11865, 11866, 11867, 11868, 11869, 11870, 11871, 11872, 11873, 11890, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 11857, 11858, 11859, 11860, 11861, 11862, 11863, 11864, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 40543, 40544, 40545, 40546, 40547, 40548, 40549}, [120050] = {40703, 40491, 40487, 40488, 40489, 40490, 11891, 11954, 12254, 40484, 40485, 40486, 11865, 11866, 11867, 11868, 11869, 11870, 11871, 11872, 11873, 11890, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10146, 11857, 11858, 11859, 11860, 11861, 11862, 11863, 11864, 10020, 10027, 10040, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10144, 40543, 40544, 40545, 40546, 40547, 40548, 40549},
	}
	ClientData._liyaCardsMap = LIYA_CARDS_MAP

	local EXTRA_CARDS_MAP = {
		[1] = {12017, 40575, 40721, 30534, 40198, 40574, 12019, 12304, 12306, 21008, 21131, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 12014, 12015, 12016, 12018, 10172, 10173, 10174, 10175, 10176, 10178, 10179},
		[121001] = {12017, 40575, 40721, 30534, 40198, 40574, 12019, 12304, 12306, 21008, 21131, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 12014, 12015, 12016, 12018, 10172, 10173, 10174, 10175, 10176, 10178, 10179}, [121010] = {12017, 40575, 40721, 30534, 40198, 40574, 12019, 12304, 12306, 21008, 21131, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 12014, 12015, 12016, 12018, 10172, 10173, 10174, 10175, 10176, 10178, 10179}, [121050] = {12017, 40575, 40721, 30534, 40198, 40574, 12019, 12304, 12306, 21008, 21131, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 12014, 12015, 12016, 12018, 10172, 10173, 10174, 10175, 10176, 10178, 10179},
		[2] = {30586, 21106, 21103, 12223, 12292, 12211, 12212, 12213, 12214, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 12208, 12209, 12210, 10251, 10252, 10253, 10254, 10255, 10256, 10043, 10056, 10063},
		[122001] = {30586, 21106, 21103, 12223, 12292, 12211, 12212, 12213, 12214, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 12208, 12209, 12210, 10251, 10252, 10253, 10254, 10255, 10256, 10043, 10056, 10063}, [122010] = {30586, 21106, 21103, 12223, 12292, 12211, 12212, 12213, 12214, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 12208, 12209, 12210, 10251, 10252, 10253, 10254, 10255, 10256, 10043, 10056, 10063}, [122050] = {30586, 21106, 21103, 12223, 12292, 12211, 12212, 12213, 12214, 12093, 12130, 12284, 20004, 20007, 20008, 20017, 12208, 12209, 12210, 10251, 10252, 10253, 10254, 10255, 10256, 10043, 10056, 10063},
		[3] = {30523, 30522, 20999, 21074, 12194, 20998, 11992, 11993, 11994, 11995, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 11988, 11989, 11990, 11991, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 10072, 10073, 10081},
		[123001] = {30523, 30522, 20999, 21074, 12194, 20998, 11992, 11993, 11994, 11995, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 11988, 11989, 11990, 11991, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 10072, 10073, 10081}, [123010] = {30523, 30522, 20999, 21074, 12194, 20998, 11992, 11993, 11994, 11995, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 11988, 11989, 11990, 11991, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 10072, 10073, 10081}, [123050] = {30523, 30522, 20999, 21074, 12194, 20998, 11992, 11993, 11994, 11995, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 11988, 11989, 11990, 11991, 20063, 20064, 20067, 20078, 20113, 20125, 20145, 20157, 10072, 10073, 10081},
		[4] = {30177, 20317, 10926, 11554, 10871, 10879, 10920, 10925, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10868, 10869, 10870, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10087, 10091, 10092},
		[124001] = {30177, 20317, 10926, 11554, 10871, 10879, 10920, 10925, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10868, 10869, 10870, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10087, 10091, 10092}, [124010] = {30177, 20317, 10926, 11554, 10871, 10879, 10920, 10925, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10868, 10869, 10870, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10087, 10091, 10092}, [124050] = {30177, 20317, 10926, 11554, 10871, 10879, 10920, 10925, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 10868, 10869, 10870, 10106, 10134, 10136, 10137, 10138, 10141, 10142, 10087, 10091, 10092},
		[5] = {30440, 20838, 20839, 11788, 20176, 11784, 11785, 11786, 11787, 10275, 10276, 10357, 10441, 10504, 10575, 11192, 11781, 11782, 11783, 10180, 10188, 10190, 10191, 10192, 10193, 10096, 10099, 10111},
		[125001] = {30440, 20838, 20839, 11788, 20176, 11784, 11785, 11786, 11787, 10275, 10276, 10357, 10441, 10504, 10575, 11192, 11781, 11782, 11783, 10180, 10188, 10190, 10191, 10192, 10193, 10096, 10099, 10111}, [125010] = {30440, 20838, 20839, 11788, 20176, 11784, 11785, 11786, 11787, 10275, 10276, 10357, 10441, 10504, 10575, 11192, 11781, 11782, 11783, 10180, 10188, 10190, 10191, 10192, 10193, 10096, 10099, 10111}, [125050] = {30440, 20838, 20839, 11788, 20176, 11784, 11785, 11786, 11787, 10275, 10276, 10357, 10441, 10504, 10575, 11192, 11781, 11782, 11783, 10180, 10188, 10190, 10191, 10192, 10193, 10096, 10099, 10111},
		[6] = {40714, 40679, 40378, 40379, 40384, 40424, 40557, 40371, 40372, 40373, 40374, 40375, 40376, 40377, 12064, 12085, 12220, 20547, 30310, 30311, 30574, 40221, 40222, 40223, 40369, 40370, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 11343, 11344, 11345, 11346, 11347, 11348, 11349, 11350, 11351, 11764, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060},
		[126001] = {40714, 40679, 40378, 40379, 40384, 40424, 40557, 40371, 40372, 40373, 40374, 40375, 40376, 40377, 12064, 12085, 12220, 20547, 30310, 30311, 30574, 40221, 40222, 40223, 40369, 40370, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 11343, 11344, 11345, 11346, 11347, 11348, 11349, 11350, 11351, 11764, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060}, [126010] = {40714, 40679, 40378, 40379, 40384, 40424, 40557, 40371, 40372, 40373, 40374, 40375, 40376, 40377, 12064, 12085, 12220, 20547, 30310, 30311, 30574, 40221, 40222, 40223, 40369, 40370, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 11343, 11344, 11345, 11346, 11347, 11348, 11349, 11350, 11351, 11764, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060}, [126050] = {40714, 40679, 40378, 40379, 40384, 40424, 40557, 40371, 40372, 40373, 40374, 40375, 40376, 40377, 12064, 12085, 12220, 20547, 30310, 30311, 30574, 40221, 40222, 40223, 40369, 40370, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 20245, 20432, 20456, 11343, 11344, 11345, 11346, 11347, 11348, 11349, 11350, 11351, 11764, 10258, 10302, 10303, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 20016, 20045, 20060},
		[7] = {20684, 30406, 40252, 40253, 40254, 40255, 40325, 20598, 20599, 20788, 21044, 30325, 30326, 11551, 11673, 11674, 11675, 12077, 12188, 12278, 12279, 20595, 20596, 20597, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10597, 11212, 11404, 11405, 11406, 11407, 11408, 11409, 11411, 11489, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104},
		[127001] = {20684, 30406, 40252, 40253, 40254, 40255, 40325, 20598, 20599, 20788, 21044, 30325, 30326, 11551, 11673, 11674, 11675, 12077, 12188, 12278, 12279, 20595, 20596, 20597, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10597, 11212, 11404, 11405, 11406, 11407, 11408, 11409, 11411, 11489, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104}, [127010] = {20684, 30406, 40252, 40253, 40254, 40255, 40325, 20598, 20599, 20788, 21044, 30325, 30326, 11551, 11673, 11674, 11675, 12077, 12188, 12278, 12279, 20595, 20596, 20597, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10597, 11212, 11404, 11405, 11406, 11407, 11408, 11409, 11411, 11489, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104}, [127050] = {20684, 30406, 40252, 40253, 40254, 40255, 40325, 20598, 20599, 20788, 21044, 30325, 30326, 11551, 11673, 11674, 11675, 12077, 12188, 12278, 12279, 20595, 20596, 20597, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 10067, 10071, 10597, 11212, 11404, 11405, 11406, 11407, 11408, 11409, 11411, 11489, 20157, 20158, 20174, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10101, 10104},
		[8] = {12041, 30229, 30250, 30279, 40178, 40179, 40515, 20924, 30203, 30278, 30494, 40177, 11261, 11262, 11915, 12137, 20441, 20494, 20495, 20496, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 11254, 11255, 11256, 11257, 11258, 11259, 11260, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174},
		[128001] = {12041, 30229, 30250, 30279, 40178, 40179, 40515, 20924, 30203, 30278, 30494, 40177, 11261, 11262, 11915, 12137, 20441, 20494, 20495, 20496, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 11254, 11255, 11256, 11257, 11258, 11259, 11260, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174}, [128010] = {12041, 30229, 30250, 30279, 40178, 40179, 40515, 20924, 30203, 30278, 30494, 40177, 11261, 11262, 11915, 12137, 20441, 20494, 20495, 20496, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 11254, 11255, 11256, 11257, 11258, 11259, 11260, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174}, [128050] = {12041, 30229, 30250, 30279, 40178, 40179, 40515, 20924, 30203, 30278, 30494, 40177, 11261, 11262, 11915, 12137, 20441, 20494, 20495, 20496, 10146, 10148, 10149, 10150, 10151, 10153, 10177, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 11254, 11255, 11256, 11257, 11258, 11259, 11260, 10144, 10145, 10152, 10156, 10164, 10165, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174},
		[9] = {40398, 30418, 30416, 30417, 20800, 20801, 20802, 30415, 11704, 11705, 11706, 11743, 20797, 20798, 20799, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11698, 11699, 11700, 11701, 11702, 11703, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207},
		[129001] = {40398, 30418, 30416, 30417, 20800, 20801, 20802, 30415, 11704, 11705, 11706, 11743, 20797, 20798, 20799, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11698, 11699, 11700, 11701, 11702, 11703, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207}, [129010] = {40398, 30418, 30416, 30417, 20800, 20801, 20802, 30415, 11704, 11705, 11706, 11743, 20797, 20798, 20799, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11698, 11699, 11700, 11701, 11702, 11703, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207}, [129050] = {40398, 30418, 30416, 30417, 20800, 20801, 20802, 30415, 11704, 11705, 11706, 11743, 20797, 20798, 20799, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 11633, 11698, 11699, 11700, 11701, 11702, 11703, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207},
		[10] = {40084, 20430, 11211, 20394, 10794, 10872, 10975, 11070, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 10745, 10746, 10767, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 10155, 10161, 10208},
		[130001] = {40084, 20430, 11211, 20394, 10794, 10872, 10975, 11070, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 10745, 10746, 10767, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 10155, 10161, 10208}, [130010] = {40084, 20430, 11211, 20394, 10794, 10872, 10975, 11070, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 10745, 10746, 10767, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 10155, 10161, 10208}, [130050] = {40084, 20430, 11211, 20394, 10794, 10872, 10975, 11070, 20092, 20093, 20102, 20108, 20130, 20188, 20215, 10745, 10746, 10767, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 10155, 10161, 10208},
		[11] = {20625, 11264, 20561, 11237, 11161, 11217, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 11058, 11117, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10210, 10213, 10222},
		[131001] = {20625, 11264, 20561, 11237, 11161, 11217, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 11058, 11117, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10210, 10213, 10222}, [131010] = {20625, 11264, 20561, 11237, 11161, 11217, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 11058, 11117, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10210, 10213, 10222}, [131050] = {20625, 11264, 20561, 11237, 11161, 11217, 10031, 10034, 10036, 10037, 10041, 10046, 10049, 10051, 10055, 11058, 11117, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10210, 10213, 10222},
		[12] = {30528, 30271, 11235, 20475, 11232, 11233, 11234, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 11230, 11231, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10230, 10237, 10238},
		[132001] = {30528, 30271, 11235, 20475, 11232, 11233, 11234, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 11230, 11231, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10230, 10237, 10238}, [132010] = {30528, 30271, 11235, 20475, 11232, 11233, 11234, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 11230, 11231, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10230, 10237, 10238}, [132050] = {30528, 30271, 11235, 20475, 11232, 11233, 11234, 10181, 10182, 10183, 10184, 10186, 10187, 10204, 10205, 11230, 11231, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10230, 10237, 10238},
		[13] = {40537, 40538, 30512, 30520, 11967, 12270, 20973, 20974, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 11964, 11965, 11966, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10239, 10240, 10241},
		[133001] = {40537, 40538, 30512, 30520, 11967, 12270, 20973, 20974, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 11964, 11965, 11966, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10239, 10240, 10241}, [133010] = {40537, 40538, 30512, 30520, 11967, 12270, 20973, 20974, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 11964, 11965, 11966, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10239, 10240, 10241}, [133050] = {40537, 40538, 30512, 30520, 11967, 12270, 20973, 20974, 11619, 11622, 11633, 11730, 11895, 11896, 11946, 11964, 11965, 11966, 10203, 10207, 10209, 10250, 10251, 10252, 10253, 10239, 10240, 10241},
		[14] = {40541, 40542, 40634, 30514, 40317, 20988, 21065, 21066, 30513, 20245, 20432, 20456, 20493, 20871, 30003, 11970, 11971, 11972, 12116, 20016, 20045, 20060, 20062, 20063, 20064, 10243, 10246, 10262},
		[134001] = {40541, 40542, 40634, 30514, 40317, 20988, 21065, 21066, 30513, 20245, 20432, 20456, 20493, 20871, 30003, 11970, 11971, 11972, 12116, 20016, 20045, 20060, 20062, 20063, 20064, 10243, 10246, 10262}, [134010] = {40541, 40542, 40634, 30514, 40317, 20988, 21065, 21066, 30513, 20245, 20432, 20456, 20493, 20871, 30003, 11970, 11971, 11972, 12116, 20016, 20045, 20060, 20062, 20063, 20064, 10243, 10246, 10262}, [134050] = {40541, 40542, 40634, 30514, 40317, 20988, 21065, 21066, 30513, 20245, 20432, 20456, 20493, 20871, 30003, 11970, 11971, 11972, 12116, 20016, 20045, 20060, 20062, 20063, 20064, 10243, 10246, 10262},
		[15] = {20152, 11623, 11624, 10831, 10619, 10823, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10537, 10543, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10263, 10264, 10272},
		[135001] = {20152, 11623, 11624, 10831, 10619, 10823, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10537, 10543, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10263, 10264, 10272}, [135010] = {20152, 11623, 11624, 10831, 10619, 10823, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10537, 10543, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10263, 10264, 10272}, [135050] = {20152, 11623, 11624, 10831, 10619, 10823, 10051, 10055, 10067, 10071, 10079, 10080, 10088, 10090, 10097, 10537, 10543, 10047, 10082, 10101, 10104, 10106, 10134, 10136, 10137, 10263, 10264, 10272},
		[16] = {30542, 30535, 30536, 21128, 21015, 21016, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 21013, 21014, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10273, 10280, 10282},
		[136001] = {30542, 30535, 30536, 21128, 21015, 21016, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 21013, 21014, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10273, 10280, 10282}, [136010] = {30542, 30535, 30536, 21128, 21015, 21016, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 21013, 21014, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10273, 10280, 10282}, [136050] = {30542, 30535, 30536, 21128, 21015, 21016, 10205, 10223, 10244, 10245, 10247, 10248, 10249, 10261, 10275, 21013, 21014, 10175, 10176, 10178, 10179, 10180, 10188, 10190, 10191, 10273, 10280, 10282},
		[17] = {30210, 30173, 20782, 20356, 20781, 10841, 10842, 10843, 11666, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 10837, 10838, 10840, 10254, 10255, 10256, 10257, 10258, 10302, 10309, 10320, 10321},
		[137001] = {30210, 30173, 20782, 20356, 20781, 10841, 10842, 10843, 11666, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 10837, 10838, 10840, 10254, 10255, 10256, 10257, 10258, 10302, 10309, 10320, 10321}, [137010] = {30210, 30173, 20782, 20356, 20781, 10841, 10842, 10843, 11666, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 10837, 10838, 10840, 10254, 10255, 10256, 10257, 10258, 10302, 10309, 10320, 10321}, [137050] = {30210, 30173, 20782, 20356, 20781, 10841, 10842, 10843, 11666, 12043, 12093, 12130, 12284, 20004, 20007, 20008, 10837, 10838, 10840, 10254, 10255, 10256, 10257, 10258, 10302, 10309, 10320, 10321},
		[18] = {30589, 30433, 30270, 30282, 30320, 30327, 30030, 30062, 30266, 30268, 10856, 10876, 10877, 10878, 11176, 30002, 30023, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 30239, 10007, 10505, 10527, 10737, 10800, 10829, 10830, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098},
		[138001] = {30589, 30433, 30270, 30282, 30320, 30327, 30030, 30062, 30266, 30268, 10856, 10876, 10877, 10878, 11176, 30002, 30023, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 30239, 10007, 10505, 10527, 10737, 10800, 10829, 10830, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098}, [138010] = {30589, 30433, 30270, 30282, 30320, 30327, 30030, 30062, 30266, 30268, 10856, 10876, 10877, 10878, 11176, 30002, 30023, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 30239, 10007, 10505, 10527, 10737, 10800, 10829, 10830, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098}, [138050] = {30589, 30433, 30270, 30282, 30320, 30327, 30030, 30062, 30266, 30268, 10856, 10876, 10877, 10878, 11176, 30002, 30023, 30013, 30014, 30017, 30026, 30041, 30042, 30045, 30061, 30073, 30239, 10007, 10505, 10527, 10737, 10800, 10829, 10830, 20078, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20439, 21098},
		[19] = {30490, 20920, 20921, 11932, 20918, 20919, 11909, 11910, 11911, 11919, 11931, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 11905, 11906, 11907, 11908, 10137, 10138, 10141, 10142, 10144, 10145, 10152},
		[139001] = {30490, 20920, 20921, 11932, 20918, 20919, 11909, 11910, 11911, 11919, 11931, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 11905, 11906, 11907, 11908, 10137, 10138, 10141, 10142, 10144, 10145, 10152}, [139010] = {30490, 20920, 20921, 11932, 20918, 20919, 11909, 11910, 11911, 11919, 11931, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 11905, 11906, 11907, 11908, 10137, 10138, 10141, 10142, 10144, 10145, 10152}, [139050] = {30490, 20920, 20921, 11932, 20918, 20919, 11909, 11910, 11911, 11919, 11931, 10090, 10097, 10098, 10102, 10103, 10107, 10113, 10135, 11905, 11906, 11907, 11908, 10137, 10138, 10141, 10142, 10144, 10145, 10152},
		[20] = {11412, 20635, 21107, 30243, 30487, 40449, 40628, 11887, 11888, 12104, 12218, 20271, 20583, 20909, 11204, 11205, 11381, 11382, 11383, 11384, 11385, 11386, 11387, 11388, 11885, 11886, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 10732, 10796, 10826, 10827, 10918, 10919, 10923, 11142, 11202, 11203, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252},
		[140001] = {11412, 20635, 21107, 30243, 30487, 40449, 40628, 11887, 11888, 12104, 12218, 20271, 20583, 20909, 11204, 11205, 11381, 11382, 11383, 11384, 11385, 11386, 11387, 11388, 11885, 11886, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 10732, 10796, 10826, 10827, 10918, 10919, 10923, 11142, 11202, 11203, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252}, [140010] = {11412, 20635, 21107, 30243, 30487, 40449, 40628, 11887, 11888, 12104, 12218, 20271, 20583, 20909, 11204, 11205, 11381, 11382, 11383, 11384, 11385, 11386, 11387, 11388, 11885, 11886, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 10732, 10796, 10826, 10827, 10918, 10919, 10923, 11142, 11202, 11203, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252}, [140050] = {11412, 20635, 21107, 30243, 30487, 40449, 40628, 11887, 11888, 12104, 12218, 20271, 20583, 20909, 11204, 11205, 11381, 11382, 11383, 11384, 11385, 11386, 11387, 11388, 11885, 11886, 10261, 10275, 10276, 10357, 10441, 10504, 10575, 10587, 10628, 10722, 10777, 10953, 10984, 11072, 11615, 11619, 11622, 10732, 10796, 10826, 10827, 10918, 10919, 10923, 11142, 11202, 11203, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10207, 10209, 10250, 10251, 10252},
		[21] = {40657, 40656, 40653, 40654, 40655, 21088, 30576, 40651, 40652, 12164, 12165, 12171, 12172, 21085, 21086, 21087, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 12158, 12159, 12160, 12161, 12162, 12163, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 10344, 10345, 10346},
		[141001] = {40657, 40656, 40653, 40654, 40655, 21088, 30576, 40651, 40652, 12164, 12165, 12171, 12172, 21085, 21086, 21087, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 12158, 12159, 12160, 12161, 12162, 12163, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 10344, 10345, 10346}, [141010] = {40657, 40656, 40653, 40654, 40655, 21088, 30576, 40651, 40652, 12164, 12165, 12171, 12172, 21085, 21086, 21087, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 12158, 12159, 12160, 12161, 12162, 12163, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 10344, 10345, 10346}, [141050] = {40657, 40656, 40653, 40654, 40655, 21088, 30576, 40651, 40652, 12164, 12165, 12171, 12172, 21085, 21086, 21087, 20017, 20018, 20022, 20033, 20057, 20069, 20077, 20090, 20092, 20093, 20102, 20108, 12158, 12159, 12160, 12161, 12162, 12163, 10510, 10759, 11146, 11152, 11155, 11159, 11340, 11510, 11512, 11665, 12204, 10344, 10345, 10346},
		[22] = {40694, 40693, 40690, 40691, 40692, 30587, 40687, 40688, 40689, 12235, 12236, 12237, 21108, 21109, 21110, 21113, 21114, 30061, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 12228, 12229, 12230, 12231, 12232, 12233, 12234, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10361, 10363, 10366},
		[142001] = {40694, 40693, 40690, 40691, 40692, 30587, 40687, 40688, 40689, 12235, 12236, 12237, 21108, 21109, 21110, 21113, 21114, 30061, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 12228, 12229, 12230, 12231, 12232, 12233, 12234, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10361, 10363, 10366}, [142010] = {40694, 40693, 40690, 40691, 40692, 30587, 40687, 40688, 40689, 12235, 12236, 12237, 21108, 21109, 21110, 21113, 21114, 30061, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 12228, 12229, 12230, 12231, 12232, 12233, 12234, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10361, 10363, 10366}, [142050] = {40694, 40693, 40690, 40691, 40692, 30587, 40687, 40688, 40689, 12235, 12236, 12237, 21108, 21109, 21110, 21113, 21114, 30061, 30073, 30239, 10007, 10012, 10014, 10024, 10030, 10031, 10034, 10036, 10037, 10041, 12228, 12229, 12230, 12231, 12232, 12233, 12234, 20228, 20229, 20439, 21098, 30019, 30033, 30034, 10018, 10020, 10027, 10040, 10047, 10082, 10361, 10363, 10366},
		[23] = {11680, 11681, 11682, 11683, 11684, 11685, 11686, 11687, 11688, 11689, 12131, 12247, 20790, 20791, 30411, 30412, 30539, 40392, 40393, 40394, 40395, 40396, 40590, 10377, 10378, 10379, 11088, 11091, 11092, 11129, 11147, 10624, 10644, 10645, 10646, 10649},
		[143001] = {11680, 11681, 11682, 11683, 11684, 11685, 11686, 11687, 11688, 11689, 12131, 12247, 20790, 20791, 30411, 30412, 30539, 40392, 40393, 40394, 40395, 40396, 40590, 10377, 10378, 10379, 11088, 11091, 11092, 11129, 11147, 10624, 10644, 10645, 10646, 10649}, [143010] = {11680, 11681, 11682, 11683, 11684, 11685, 11686, 11687, 11688, 11689, 12131, 12247, 20790, 20791, 30411, 30412, 30539, 40392, 40393, 40394, 40395, 40396, 40590, 10377, 10378, 10379, 11088, 11091, 11092, 11129, 11147, 10624, 10644, 10645, 10646, 10649}, [143050] = {11680, 11681, 11682, 11683, 11684, 11685, 11686, 11687, 11688, 11689, 12131, 12247, 20790, 20791, 30411, 30412, 30539, 40392, 40393, 40394, 40395, 40396, 40590, 10377, 10378, 10379, 11088, 11091, 11092, 11129, 11147, 10624, 10644, 10645, 10646, 10649},
		[24] = {11003, 11004, 11005, 11006, 11021, 11022, 11024, 11027, 11043, 11052, 11053, 11055, 11220, 20381, 20384, 40096, 40097, 40098, 40099, 40100, 40195, 11148, 11149, 11150, 11161, 11217, 10651, 10652, 10653, 10656, 10669},
		[144001] = {11003, 11004, 11005, 11006, 11021, 11022, 11024, 11027, 11043, 11052, 11053, 11055, 11220, 20381, 20384, 40096, 40097, 40098, 40099, 40100, 40195, 11148, 11149, 11150, 11161, 11217, 10651, 10652, 10653, 10656, 10669}, [144010] = {11003, 11004, 11005, 11006, 11021, 11022, 11024, 11027, 11043, 11052, 11053, 11055, 11220, 20381, 20384, 40096, 40097, 40098, 40099, 40100, 40195, 11148, 11149, 11150, 11161, 11217, 10651, 10652, 10653, 10656, 10669}, [144050] = {11003, 11004, 11005, 11006, 11021, 11022, 11024, 11027, 11043, 11052, 11053, 11055, 11220, 20381, 20384, 40096, 40097, 40098, 40099, 40100, 40195, 11148, 11149, 11150, 11161, 11217, 10651, 10652, 10653, 10656, 10669},
		[25] = {11734, 12111, 20643, 20655, 20656, 20661, 20662, 20669, 20827, 20908, 20916, 20931, 20934, 20936, 21058, 21082, 21118, 30365, 30372, 30435, 30563, 30564, 40011, 40184, 40205, 40227, 40241, 40249, 40259, 40262, 40270, 40291, 40296, 40324, 40326, 40337, 40338, 40367, 40382, 40389, 40397, 40401, 40411, 40412, 40425, 40450, 40456, 40469, 40497, 40509, 40510, 40567, 10397, 10401, 10408, 11222, 11233, 11234, 11235, 11247, 10684, 10685, 10695, 10696, 10697},
		[145001] = {11734, 12111, 20643, 20655, 20656, 20661, 20662, 20669, 20827, 20908, 20916, 20931, 20934, 20936, 21058, 21082, 21118, 30365, 30372, 30435, 30563, 30564, 40011, 40184, 40205, 40227, 40241, 40249, 40259, 40262, 40270, 40291, 40296, 40324, 40326, 40337, 40338, 40367, 40382, 40389, 40397, 40401, 40411, 40412, 40425, 40450, 40456, 40469, 40497, 40509, 40510, 40567, 10397, 10401, 10408, 11222, 11233, 11234, 11235, 11247, 10684, 10685, 10695, 10696, 10697}, [145010] = {11734, 12111, 20643, 20655, 20656, 20661, 20662, 20669, 20827, 20908, 20916, 20931, 20934, 20936, 21058, 21082, 21118, 30365, 30372, 30435, 30563, 30564, 40011, 40184, 40205, 40227, 40241, 40249, 40259, 40262, 40270, 40291, 40296, 40324, 40326, 40337, 40338, 40367, 40382, 40389, 40397, 40401, 40411, 40412, 40425, 40450, 40456, 40469, 40497, 40509, 40510, 40567, 10397, 10401, 10408, 11222, 11233, 11234, 11235, 11247, 10684, 10685, 10695, 10696, 10697}, [145050] = {11734, 12111, 20643, 20655, 20656, 20661, 20662, 20669, 20827, 20908, 20916, 20931, 20934, 20936, 21058, 21082, 21118, 30365, 30372, 30435, 30563, 30564, 40011, 40184, 40205, 40227, 40241, 40249, 40259, 40262, 40270, 40291, 40296, 40324, 40326, 40337, 40338, 40367, 40382, 40389, 40397, 40401, 40411, 40412, 40425, 40450, 40456, 40469, 40497, 40509, 40510, 40567, 10397, 10401, 10408, 11222, 11233, 11234, 11235, 11247, 10684, 10685, 10695, 10696, 10697},
		[26] = {10556, 10862, 11071, 11074, 11213, 11214, 11215, 11660, 11661, 11842, 12244, 20775, 20776, 20883, 20884, 21009, 30402, 30463, 40381, 40383, 40385, 40715, 10411, 10418, 10421, 11248, 11249, 11251, 11254, 11255, 10698, 10699, 10700, 10705, 10706},
		[146001] = {10556, 10862, 11071, 11074, 11213, 11214, 11215, 11660, 11661, 11842, 12244, 20775, 20776, 20883, 20884, 21009, 30402, 30463, 40381, 40383, 40385, 40715, 10411, 10418, 10421, 11248, 11249, 11251, 11254, 11255, 10698, 10699, 10700, 10705, 10706}, [146010] = {10556, 10862, 11071, 11074, 11213, 11214, 11215, 11660, 11661, 11842, 12244, 20775, 20776, 20883, 20884, 21009, 30402, 30463, 40381, 40383, 40385, 40715, 10411, 10418, 10421, 11248, 11249, 11251, 11254, 11255, 10698, 10699, 10700, 10705, 10706}, [146050] = {10556, 10862, 11071, 11074, 11213, 11214, 11215, 11660, 11661, 11842, 12244, 20775, 20776, 20883, 20884, 21009, 30402, 30463, 40381, 40383, 40385, 40715, 10411, 10418, 10421, 11248, 11249, 11251, 11254, 11255, 10698, 10699, 10700, 10705, 10706},
		[27] = {10242, 10259, 10260, 10422, 10426, 10428, 11261, 11262, 11280, 11320, 11321, 10720, 10726, 10735, 10737, 10758},
		[147001] = {10242, 10259, 10260, 10422, 10426, 10428, 11261, 11262, 11280, 11320, 11321, 10720, 10726, 10735, 10737, 10758}, [147010] = {10242, 10259, 10260, 10422, 10426, 10428, 11261, 11262, 11280, 11320, 11321, 10720, 10726, 10735, 10737, 10758}, [147050] = {10242, 10259, 10260, 10422, 10426, 10428, 11261, 11262, 11280, 11320, 11321, 10720, 10726, 10735, 10737, 10758},
		[28] = {12117, 12118, 12119, 12120, 12121, 12122, 12123, 12124, 21067, 21068, 21069, 21070, 30567, 30568, 40635, 40636, 40637, 40638, 40644, 40660, 10430, 10442, 10449, 11322, 11327, 11328, 11360, 11362, 10759, 10764, 10765, 10767, 10781},
		[148001] = {12117, 12118, 12119, 12120, 12121, 12122, 12123, 12124, 21067, 21068, 21069, 21070, 30567, 30568, 40635, 40636, 40637, 40638, 40644, 40660, 10430, 10442, 10449, 11322, 11327, 11328, 11360, 11362, 10759, 10764, 10765, 10767, 10781}, [148010] = {12117, 12118, 12119, 12120, 12121, 12122, 12123, 12124, 21067, 21068, 21069, 21070, 30567, 30568, 40635, 40636, 40637, 40638, 40644, 40660, 10430, 10442, 10449, 11322, 11327, 11328, 11360, 11362, 10759, 10764, 10765, 10767, 10781}, [148050] = {12117, 12118, 12119, 12120, 12121, 12122, 12123, 12124, 21067, 21068, 21069, 21070, 30567, 30568, 40635, 40636, 40637, 40638, 40644, 40660, 10430, 10442, 10449, 11322, 11327, 11328, 11360, 11362, 10759, 10764, 10765, 10767, 10781},
		[29] = {10227, 10727, 10880, 10881, 10883, 10887, 10888, 10889, 10890, 10891, 10892, 10893, 10899, 10900, 10985, 11428, 11431, 40196, 40197, 40266, 10460, 10461, 10463, 11368, 11377, 11398, 11400, 11401, 10782, 10787, 10788, 10793, 10794},
		[149001] = {10227, 10727, 10880, 10881, 10883, 10887, 10888, 10889, 10890, 10891, 10892, 10893, 10899, 10900, 10985, 11428, 11431, 40196, 40197, 40266, 10460, 10461, 10463, 11368, 11377, 11398, 11400, 11401, 10782, 10787, 10788, 10793, 10794}, [149010] = {10227, 10727, 10880, 10881, 10883, 10887, 10888, 10889, 10890, 10891, 10892, 10893, 10899, 10900, 10985, 11428, 11431, 40196, 40197, 40266, 10460, 10461, 10463, 11368, 11377, 11398, 11400, 11401, 10782, 10787, 10788, 10793, 10794}, [149050] = {10227, 10727, 10880, 10881, 10883, 10887, 10888, 10889, 10890, 10891, 10892, 10893, 10899, 10900, 10985, 11428, 11431, 40196, 40197, 40266, 10460, 10461, 10463, 11368, 11377, 11398, 11400, 11401, 10782, 10787, 10788, 10793, 10794},
		[30] = {10539, 10540, 10858, 10859, 10860, 10861, 11413, 11414, 12290, 20313, 20314, 20604, 21129, 30330, 40078, 40260, 40468, 10467, 10468, 10470, 11404, 11405, 11411, 11436, 11437, 10796, 10797, 10814, 10826, 10827},
		[150001] = {10539, 10540, 10858, 10859, 10860, 10861, 11413, 11414, 12290, 20313, 20314, 20604, 21129, 30330, 40078, 40260, 40468, 10467, 10468, 10470, 11404, 11405, 11411, 11436, 11437, 10796, 10797, 10814, 10826, 10827}, [150010] = {10539, 10540, 10858, 10859, 10860, 10861, 11413, 11414, 12290, 20313, 20314, 20604, 21129, 30330, 40078, 40260, 40468, 10467, 10468, 10470, 11404, 11405, 11411, 11436, 11437, 10796, 10797, 10814, 10826, 10827}, [150050] = {10539, 10540, 10858, 10859, 10860, 10861, 11413, 11414, 12290, 20313, 20314, 20604, 21129, 30330, 40078, 40260, 40468, 10467, 10468, 10470, 11404, 11405, 11411, 11436, 11437, 10796, 10797, 10814, 10826, 10827},
		[31] = {10013, 10029, 10342, 10343, 10369, 10401, 10402, 10430, 10432, 10498, 10502, 10551, 10563, 10639, 10680, 10717, 10719, 10729, 10730, 10731, 10790, 10801, 10902, 10967, 11007, 11040, 11041, 11042, 11048, 11049, 11050, 11051, 11076, 11120, 11240, 11289, 11329, 11568, 11613, 11731, 11824, 11825, 11969, 12004, 12005, 12006, 12140, 12177, 12275, 12285, 20011, 20026, 20186, 20192, 20216, 20259, 20303, 20312, 20434, 20468, 20473, 20847, 20848, 20866, 20870, 20873, 20980, 21006, 21127, 30032, 30120, 30127, 30158, 30526, 30527, 30578, 40013, 40016, 40033, 40037, 40102, 40103, 40131, 40133, 40138, 40139, 40153, 40175, 40190, 40452, 40453, 40504, 40568, 40648, 40680, 40701, 11452, 11453, 11454, 11455, 11456, 10840, 10841, 10842, 10848, 10870},
		[151001] = {10013, 10029, 10342, 10343, 10369, 10401, 10402, 10430, 10432, 10498, 10502, 10551, 10563, 10639, 10680, 10717, 10719, 10729, 10730, 10731, 10790, 10801, 10902, 10967, 11007, 11040, 11041, 11042, 11048, 11049, 11050, 11051, 11076, 11120, 11240, 11289, 11329, 11568, 11613, 11731, 11824, 11825, 11969, 12004, 12005, 12006, 12140, 12177, 12275, 12285, 20011, 20026, 20186, 20192, 20216, 20259, 20303, 20312, 20434, 20468, 20473, 20847, 20848, 20866, 20870, 20873, 20980, 21006, 21127, 30032, 30120, 30127, 30158, 30526, 30527, 30578, 40013, 40016, 40033, 40037, 40102, 40103, 40131, 40133, 40138, 40139, 40153, 40175, 40190, 40452, 40453, 40504, 40568, 40648, 40680, 40701, 11452, 11453, 11454, 11455, 11456, 10840, 10841, 10842, 10848, 10870}, [151010] = {10013, 10029, 10342, 10343, 10369, 10401, 10402, 10430, 10432, 10498, 10502, 10551, 10563, 10639, 10680, 10717, 10719, 10729, 10730, 10731, 10790, 10801, 10902, 10967, 11007, 11040, 11041, 11042, 11048, 11049, 11050, 11051, 11076, 11120, 11240, 11289, 11329, 11568, 11613, 11731, 11824, 11825, 11969, 12004, 12005, 12006, 12140, 12177, 12275, 12285, 20011, 20026, 20186, 20192, 20216, 20259, 20303, 20312, 20434, 20468, 20473, 20847, 20848, 20866, 20870, 20873, 20980, 21006, 21127, 30032, 30120, 30127, 30158, 30526, 30527, 30578, 40013, 40016, 40033, 40037, 40102, 40103, 40131, 40133, 40138, 40139, 40153, 40175, 40190, 40452, 40453, 40504, 40568, 40648, 40680, 40701, 11452, 11453, 11454, 11455, 11456, 10840, 10841, 10842, 10848, 10870}, [151050] = {10013, 10029, 10342, 10343, 10369, 10401, 10402, 10430, 10432, 10498, 10502, 10551, 10563, 10639, 10680, 10717, 10719, 10729, 10730, 10731, 10790, 10801, 10902, 10967, 11007, 11040, 11041, 11042, 11048, 11049, 11050, 11051, 11076, 11120, 11240, 11289, 11329, 11568, 11613, 11731, 11824, 11825, 11969, 12004, 12005, 12006, 12140, 12177, 12275, 12285, 20011, 20026, 20186, 20192, 20216, 20259, 20303, 20312, 20434, 20468, 20473, 20847, 20848, 20866, 20870, 20873, 20980, 21006, 21127, 30032, 30120, 30127, 30158, 30526, 30527, 30578, 40013, 40016, 40033, 40037, 40102, 40103, 40131, 40133, 40138, 40139, 40153, 40175, 40190, 40452, 40453, 40504, 40568, 40648, 40680, 40701, 11452, 11453, 11454, 11455, 11456, 10840, 10841, 10842, 10848, 10870},
		[32] = {11110, 11111, 11113, 11114, 11115, 11335, 11529, 11530, 11644, 12082, 12240, 12269, 20414, 20415, 20416, 20417, 20418, 20423, 20869, 21124, 30591, 40122, 40124, 40125, 40127, 40154, 40156, 40216, 40380, 40610, 40710, 10488, 10491, 10492, 11480, 11488, 11493, 11503, 11504, 10871, 10877, 10878, 10905, 10906},
		[152001] = {11110, 11111, 11113, 11114, 11115, 11335, 11529, 11530, 11644, 12082, 12240, 12269, 20414, 20415, 20416, 20417, 20418, 20423, 20869, 21124, 30591, 40122, 40124, 40125, 40127, 40154, 40156, 40216, 40380, 40610, 40710, 10488, 10491, 10492, 11480, 11488, 11493, 11503, 11504, 10871, 10877, 10878, 10905, 10906}, [152010] = {11110, 11111, 11113, 11114, 11115, 11335, 11529, 11530, 11644, 12082, 12240, 12269, 20414, 20415, 20416, 20417, 20418, 20423, 20869, 21124, 30591, 40122, 40124, 40125, 40127, 40154, 40156, 40216, 40380, 40610, 40710, 10488, 10491, 10492, 11480, 11488, 11493, 11503, 11504, 10871, 10877, 10878, 10905, 10906}, [152050] = {11110, 11111, 11113, 11114, 11115, 11335, 11529, 11530, 11644, 12082, 12240, 12269, 20414, 20415, 20416, 20417, 20418, 20423, 20869, 21124, 30591, 40122, 40124, 40125, 40127, 40154, 40156, 40216, 40380, 40610, 40710, 10488, 10491, 10492, 11480, 11488, 11493, 11503, 11504, 10871, 10877, 10878, 10905, 10906},
		[33] = {12028, 12029, 12030, 12031, 12032, 12033, 12034, 12035, 12054, 12055, 12225, 12250, 12276, 12280, 40577, 40578, 40579, 40580, 40581, 40582, 40583, 40584, 40596, 40597, 10493, 10496, 10498, 11509, 11522, 11523, 11524, 11525, 10907, 10908, 10909, 10911, 10912},
		[153001] = {12028, 12029, 12030, 12031, 12032, 12033, 12034, 12035, 12054, 12055, 12225, 12250, 12276, 12280, 40577, 40578, 40579, 40580, 40581, 40582, 40583, 40584, 40596, 40597, 10493, 10496, 10498, 11509, 11522, 11523, 11524, 11525, 10907, 10908, 10909, 10911, 10912}, [153010] = {12028, 12029, 12030, 12031, 12032, 12033, 12034, 12035, 12054, 12055, 12225, 12250, 12276, 12280, 40577, 40578, 40579, 40580, 40581, 40582, 40583, 40584, 40596, 40597, 10493, 10496, 10498, 11509, 11522, 11523, 11524, 11525, 10907, 10908, 10909, 10911, 10912}, [153050] = {12028, 12029, 12030, 12031, 12032, 12033, 12034, 12035, 12054, 12055, 12225, 12250, 12276, 12280, 40577, 40578, 40579, 40580, 40581, 40582, 40583, 40584, 40596, 40597, 10493, 10496, 10498, 11509, 11522, 11523, 11524, 11525, 10907, 10908, 10909, 10911, 10912},
		[34] = {11419, 11420, 11750, 11751, 11752, 40187, 40217, 40231, 40261, 40267, 40295, 40474, 40475, 40564, 40595, 40604, 40611, 40624, 40633, 40647, 40676, 40716, 11526, 11599, 11605, 11606, 11607, 10913, 10914, 10915, 10916, 10918},
		[154001] = {11419, 11420, 11750, 11751, 11752, 40187, 40217, 40231, 40261, 40267, 40295, 40474, 40475, 40564, 40595, 40604, 40611, 40624, 40633, 40647, 40676, 40716, 11526, 11599, 11605, 11606, 11607, 10913, 10914, 10915, 10916, 10918}, [154010] = {11419, 11420, 11750, 11751, 11752, 40187, 40217, 40231, 40261, 40267, 40295, 40474, 40475, 40564, 40595, 40604, 40611, 40624, 40633, 40647, 40676, 40716, 11526, 11599, 11605, 11606, 11607, 10913, 10914, 10915, 10916, 10918}, [154050] = {11419, 11420, 11750, 11751, 11752, 40187, 40217, 40231, 40261, 40267, 40295, 40474, 40475, 40564, 40595, 40604, 40611, 40624, 40633, 40647, 40676, 40716, 11526, 11599, 11605, 11606, 11607, 10913, 10914, 10915, 10916, 10918},
		[35] = {11649, 11650, 11651, 11652, 11653, 11654, 11655, 11904, 12065, 12145, 12152, 20772, 20773, 21039, 30397, 30398, 30399, 30544, 40540, 40586, 10516, 10519, 10521, 11615, 11619, 11621, 11622, 11629, 10919, 10920, 10922, 10930, 10938},
		[155001] = {11649, 11650, 11651, 11652, 11653, 11654, 11655, 11904, 12065, 12145, 12152, 20772, 20773, 21039, 30397, 30398, 30399, 30544, 40540, 40586, 10516, 10519, 10521, 11615, 11619, 11621, 11622, 11629, 10919, 10920, 10922, 10930, 10938}, [155010] = {11649, 11650, 11651, 11652, 11653, 11654, 11655, 11904, 12065, 12145, 12152, 20772, 20773, 21039, 30397, 30398, 30399, 30544, 40540, 40586, 10516, 10519, 10521, 11615, 11619, 11621, 11622, 11629, 10919, 10920, 10922, 10930, 10938}, [155050] = {11649, 11650, 11651, 11652, 11653, 11654, 11655, 11904, 12065, 12145, 12152, 20772, 20773, 21039, 30397, 30398, 30399, 30544, 40540, 40586, 10516, 10519, 10521, 11615, 11619, 11621, 11622, 11629, 10919, 10920, 10922, 10930, 10938},
		[36] = {10002, 10128, 10390, 10431, 10960, 10961, 10962, 10963, 10964, 10965, 10966, 11026, 11352, 11442, 11519, 11742, 11747, 11818, 11945, 11951, 12260, 20256, 20353, 20354, 20355, 20404, 20622, 20823, 20824, 30094, 30186, 30208, 30209, 30437, 40077, 40410, 40524, 11632, 11633, 11670, 11672, 11679, 10942, 10943, 10944, 10945, 10947},
		[156001] = {10002, 10128, 10390, 10431, 10960, 10961, 10962, 10963, 10964, 10965, 10966, 11026, 11352, 11442, 11519, 11742, 11747, 11818, 11945, 11951, 12260, 20256, 20353, 20354, 20355, 20404, 20622, 20823, 20824, 30094, 30186, 30208, 30209, 30437, 40077, 40410, 40524, 11632, 11633, 11670, 11672, 11679, 10942, 10943, 10944, 10945, 10947}, [156010] = {10002, 10128, 10390, 10431, 10960, 10961, 10962, 10963, 10964, 10965, 10966, 11026, 11352, 11442, 11519, 11742, 11747, 11818, 11945, 11951, 12260, 20256, 20353, 20354, 20355, 20404, 20622, 20823, 20824, 30094, 30186, 30208, 30209, 30437, 40077, 40410, 40524, 11632, 11633, 11670, 11672, 11679, 10942, 10943, 10944, 10945, 10947}, [156050] = {10002, 10128, 10390, 10431, 10960, 10961, 10962, 10963, 10964, 10965, 10966, 11026, 11352, 11442, 11519, 11742, 11747, 11818, 11945, 11951, 12260, 20256, 20353, 20354, 20355, 20404, 20622, 20823, 20824, 30094, 30186, 30208, 30209, 30437, 40077, 40410, 40524, 11632, 11633, 11670, 11672, 11679, 10942, 10943, 10944, 10945, 10947},
		[37] = {10449, 10450, 10451, 10452, 10453, 10454, 10455, 10456, 10457, 10969, 11083, 10529, 10530, 10531, 11699, 11719, 11720, 11721, 11730, 10950, 10957, 10986, 10989, 10990},
		[157001] = {10449, 10450, 10451, 10452, 10453, 10454, 10455, 10456, 10457, 10969, 11083, 10529, 10530, 10531, 11699, 11719, 11720, 11721, 11730, 10950, 10957, 10986, 10989, 10990}, [157010] = {10449, 10450, 10451, 10452, 10453, 10454, 10455, 10456, 10457, 10969, 11083, 10529, 10530, 10531, 11699, 11719, 11720, 11721, 11730, 10950, 10957, 10986, 10989, 10990}, [157050] = {10449, 10450, 10451, 10452, 10453, 10454, 10455, 10456, 10457, 10969, 11083, 10529, 10530, 10531, 11699, 11719, 11720, 11721, 11730, 10950, 10957, 10986, 10989, 10990},
		[38] = {11253, 11625, 11626, 11627, 11642, 12311, 40171, 40172, 40327, 40328, 40329, 40330, 40331, 40358, 40359, 40361, 40363, 40364, 40365, 40368, 40587, 40724, 11749, 11761, 11773, 11774, 11775, 10991, 10992, 11011, 11012, 11013},
		[158001] = {11253, 11625, 11626, 11627, 11642, 12311, 40171, 40172, 40327, 40328, 40329, 40330, 40331, 40358, 40359, 40361, 40363, 40364, 40365, 40368, 40587, 40724, 11749, 11761, 11773, 11774, 11775, 10991, 10992, 11011, 11012, 11013}, [158010] = {11253, 11625, 11626, 11627, 11642, 12311, 40171, 40172, 40327, 40328, 40329, 40330, 40331, 40358, 40359, 40361, 40363, 40364, 40365, 40368, 40587, 40724, 11749, 11761, 11773, 11774, 11775, 10991, 10992, 11011, 11012, 11013}, [158050] = {11253, 11625, 11626, 11627, 11642, 12311, 40171, 40172, 40327, 40328, 40329, 40330, 40331, 40358, 40359, 40361, 40363, 40364, 40365, 40368, 40587, 40724, 11749, 11761, 11773, 11774, 11775, 10991, 10992, 11011, 11012, 11013},
		[39] = {10058, 11959, 11960, 11961, 11962, 11963, 20066, 20972, 30509, 30510, 30511, 40056, 40109, 40536, 40539, 10542, 10551, 10553, 11776, 11777, 11784, 11785, 11786, 11020, 11030, 11031, 11032, 11045},
		[159001] = {10058, 11959, 11960, 11961, 11962, 11963, 20066, 20972, 30509, 30510, 30511, 40056, 40109, 40536, 40539, 10542, 10551, 10553, 11776, 11777, 11784, 11785, 11786, 11020, 11030, 11031, 11032, 11045}, [159010] = {10058, 11959, 11960, 11961, 11962, 11963, 20066, 20972, 30509, 30510, 30511, 40056, 40109, 40536, 40539, 10542, 10551, 10553, 11776, 11777, 11784, 11785, 11786, 11020, 11030, 11031, 11032, 11045}, [159050] = {10058, 11959, 11960, 11961, 11962, 11963, 20066, 20972, 30509, 30510, 30511, 40056, 40109, 40536, 40539, 10542, 10551, 10553, 11776, 11777, 11784, 11785, 11786, 11020, 11030, 11031, 11032, 11045},
		[40] = {12185, 12186, 12187, 12197, 12198, 12222, 20994, 21099, 30260, 30285, 30286, 30582, 40161, 40162, 40569, 40665, 40682, 10554, 10555, 10556, 11787, 11810, 11815, 11816, 11817, 11046, 11058, 11060, 11061, 11062},
		[160001] = {12185, 12186, 12187, 12197, 12198, 12222, 20994, 21099, 30260, 30285, 30286, 30582, 40161, 40162, 40569, 40665, 40682, 10554, 10555, 10556, 11787, 11810, 11815, 11816, 11817, 11046, 11058, 11060, 11061, 11062}, [160010] = {12185, 12186, 12187, 12197, 12198, 12222, 20994, 21099, 30260, 30285, 30286, 30582, 40161, 40162, 40569, 40665, 40682, 10554, 10555, 10556, 11787, 11810, 11815, 11816, 11817, 11046, 11058, 11060, 11061, 11062}, [160050] = {12185, 12186, 12187, 12197, 12198, 12222, 20994, 21099, 30260, 30285, 30286, 30582, 40161, 40162, 40569, 40665, 40682, 10554, 10555, 10556, 11787, 11810, 11815, 11816, 11817, 11046, 11058, 11060, 11061, 11062},
		[41] = {40303, 40304, 40305, 40306, 40307, 40308, 40309, 40310, 10561, 10562, 10572, 11822, 11823, 11841, 11857, 11858, 11063, 11065, 11089, 11090, 11106},
		[161001] = {40303, 40304, 40305, 40306, 40307, 40308, 40309, 40310, 10561, 10562, 10572, 11822, 11823, 11841, 11857, 11858, 11063, 11065, 11089, 11090, 11106}, [161010] = {40303, 40304, 40305, 40306, 40307, 40308, 40309, 40310, 10561, 10562, 10572, 11822, 11823, 11841, 11857, 11858, 11063, 11065, 11089, 11090, 11106}, [161050] = {40303, 40304, 40305, 40306, 40307, 40308, 40309, 40310, 10561, 10562, 10572, 11822, 11823, 11841, 11857, 11858, 11063, 11065, 11089, 11090, 11106},
		[42] = {40402, 40403, 40404, 40405, 40406, 40589, 40625, 40626, 10583, 10584, 10588, 11859, 11863, 11864, 11886, 11887, 11117, 11146, 11151, 11152, 11153},
		[162001] = {40402, 40403, 40404, 40405, 40406, 40589, 40625, 40626, 10583, 10584, 10588, 11859, 11863, 11864, 11886, 11887, 11117, 11146, 11151, 11152, 11153}, [162010] = {40402, 40403, 40404, 40405, 40406, 40589, 40625, 40626, 10583, 10584, 10588, 11859, 11863, 11864, 11886, 11887, 11117, 11146, 11151, 11152, 11153}, [162050] = {40402, 40403, 40404, 40405, 40406, 40589, 40625, 40626, 10583, 10584, 10588, 11859, 11863, 11864, 11886, 11887, 11117, 11146, 11151, 11152, 11153},
		[43] = {10016, 10998, 10999, 11000, 11001, 11269, 11410, 20539, 40023, 40054, 40251, 40433, 40434, 40435, 40436, 40437, 40438, 40447, 11888, 11895, 11896, 11898, 11910, 11154, 11155, 11157, 11158, 11159},
		[163001] = {10016, 10998, 10999, 11000, 11001, 11269, 11410, 20539, 40023, 40054, 40251, 40433, 40434, 40435, 40436, 40437, 40438, 40447, 11888, 11895, 11896, 11898, 11910, 11154, 11155, 11157, 11158, 11159}, [163010] = {10016, 10998, 10999, 11000, 11001, 11269, 11410, 20539, 40023, 40054, 40251, 40433, 40434, 40435, 40436, 40437, 40438, 40447, 11888, 11895, 11896, 11898, 11910, 11154, 11155, 11157, 11158, 11159}, [163050] = {10016, 10998, 10999, 11000, 11001, 11269, 11410, 20539, 40023, 40054, 40251, 40433, 40434, 40435, 40436, 40437, 40438, 40447, 11888, 11895, 11896, 11898, 11910, 11154, 11155, 11157, 11158, 11159},
		[44] = {10234, 10791, 10799, 10835, 10836, 10851, 10852, 10854, 10855, 10865, 10866, 10898, 10929, 11173, 11178, 11179, 11180, 11181, 11182, 11334, 11547, 11980, 11981, 11982, 12079, 12080, 12081, 20290, 20933, 21047, 21048, 21049, 30499, 40518, 40609, 11911, 11915, 11919, 11923, 11924, 11171, 11172, 11176, 11192, 11193},
		[164001] = {10234, 10791, 10799, 10835, 10836, 10851, 10852, 10854, 10855, 10865, 10866, 10898, 10929, 11173, 11178, 11179, 11180, 11181, 11182, 11334, 11547, 11980, 11981, 11982, 12079, 12080, 12081, 20290, 20933, 21047, 21048, 21049, 30499, 40518, 40609, 11911, 11915, 11919, 11923, 11924, 11171, 11172, 11176, 11192, 11193}, [164010] = {10234, 10791, 10799, 10835, 10836, 10851, 10852, 10854, 10855, 10865, 10866, 10898, 10929, 11173, 11178, 11179, 11180, 11181, 11182, 11334, 11547, 11980, 11981, 11982, 12079, 12080, 12081, 20290, 20933, 21047, 21048, 21049, 30499, 40518, 40609, 11911, 11915, 11919, 11923, 11924, 11171, 11172, 11176, 11192, 11193}, [164050] = {10234, 10791, 10799, 10835, 10836, 10851, 10852, 10854, 10855, 10865, 10866, 10898, 10929, 11173, 11178, 11179, 11180, 11181, 11182, 11334, 11547, 11980, 11981, 11982, 12079, 12080, 12081, 20290, 20933, 21047, 21048, 21049, 30499, 40518, 40609, 11911, 11915, 11919, 11923, 11924, 11171, 11172, 11176, 11192, 11193},
		[45] = {40507, 40508, 40511, 40525, 10611, 10612, 10613, 11925, 11926, 11931, 11932, 11937, 11196, 11203, 11204, 11205, 11212},
		[165001] = {40507, 40508, 40511, 40525, 10611, 10612, 10613, 11925, 11926, 11931, 11932, 11937, 11196, 11203, 11204, 11205, 11212}, [165010] = {40507, 40508, 40511, 40525, 10611, 10612, 10613, 11925, 11926, 11931, 11932, 11937, 11196, 11203, 11204, 11205, 11212}, [165050] = {40507, 40508, 40511, 40525, 10611, 10612, 10613, 11925, 11926, 11931, 11932, 11937, 11196, 11203, 11204, 11205, 11212},
		[46] = {40559, 40560, 40561, 40562, 40563, 40565, 10614, 10615, 10627, 11938, 11942, 11946, 11947, 11967, 11221, 11227, 11228, 11230, 11231},
		[166001] = {40559, 40560, 40561, 40562, 40563, 40565, 10614, 10615, 10627, 11938, 11942, 11946, 11947, 11967, 11221, 11227, 11228, 11230, 11231}, [166010] = {40559, 40560, 40561, 40562, 40563, 40565, 10614, 10615, 10627, 11938, 11942, 11946, 11947, 11967, 11221, 11227, 11228, 11230, 11231}, [166050] = {40559, 40560, 40561, 40562, 40563, 40565, 10614, 10615, 10627, 11938, 11942, 11946, 11947, 11967, 11221, 11227, 11228, 11230, 11231},
		[47] = {10710, 10711, 10712, 10774, 10946, 12301, 20288, 20471, 20472, 10630, 10648, 10650, 11973, 11974, 11978, 11979, 11985, 11232, 11245, 11246, 11250, 11252},
		[167001] = {10710, 10711, 10712, 10774, 10946, 12301, 20288, 20471, 20472, 10630, 10648, 10650, 11973, 11974, 11978, 11979, 11985, 11232, 11245, 11246, 11250, 11252}, [167010] = {10710, 10711, 10712, 10774, 10946, 12301, 20288, 20471, 20472, 10630, 10648, 10650, 11973, 11974, 11978, 11979, 11985, 11232, 11245, 11246, 11250, 11252}, [167050] = {10710, 10711, 10712, 10774, 10946, 12301, 20288, 20471, 20472, 10630, 10648, 10650, 11973, 11974, 11978, 11979, 11985, 11232, 11245, 11246, 11250, 11252},
		[48] = {12252, 12288, 40683, 40698, 10654, 10658, 10666, 11986, 11987, 11992, 11993, 11994, 11256, 11257, 11258, 11259, 11282},
		[168001] = {12252, 12288, 40683, 40698, 10654, 10658, 10666, 11986, 11987, 11992, 11993, 11994, 11256, 11257, 11258, 11259, 11282}, [168010] = {12252, 12288, 40683, 40698, 10654, 10658, 10666, 11986, 11987, 11992, 11993, 11994, 11256, 11257, 11258, 11259, 11282}, [168050] = {12252, 12288, 40683, 40698, 10654, 10658, 10666, 11986, 11987, 11992, 11993, 11994, 11256, 11257, 11258, 11259, 11282},
		[49] = {10901, 10927, 10976, 11010, 11078, 11121, 11122, 11123, 11124, 11125, 11126, 11127, 11128, 11130, 11138, 11224, 11337, 11380, 11415, 11468, 11492, 11912, 11913, 11914, 12088, 12089, 12302, 12305, 12308, 12309, 20425, 20426, 20578, 20641, 21051, 30238, 30240, 40128, 40129, 40130, 40476, 40513, 40514, 40613, 11995, 11998, 12012, 12014, 12015, 11283, 11284, 11285, 11290, 11291},
		[169001] = {10901, 10927, 10976, 11010, 11078, 11121, 11122, 11123, 11124, 11125, 11126, 11127, 11128, 11130, 11138, 11224, 11337, 11380, 11415, 11468, 11492, 11912, 11913, 11914, 12088, 12089, 12302, 12305, 12308, 12309, 20425, 20426, 20578, 20641, 21051, 30238, 30240, 40128, 40129, 40130, 40476, 40513, 40514, 40613, 11995, 11998, 12012, 12014, 12015, 11283, 11284, 11285, 11290, 11291}, [169010] = {10901, 10927, 10976, 11010, 11078, 11121, 11122, 11123, 11124, 11125, 11126, 11127, 11128, 11130, 11138, 11224, 11337, 11380, 11415, 11468, 11492, 11912, 11913, 11914, 12088, 12089, 12302, 12305, 12308, 12309, 20425, 20426, 20578, 20641, 21051, 30238, 30240, 40128, 40129, 40130, 40476, 40513, 40514, 40613, 11995, 11998, 12012, 12014, 12015, 11283, 11284, 11285, 11290, 11291}, [169050] = {10901, 10927, 10976, 11010, 11078, 11121, 11122, 11123, 11124, 11125, 11126, 11127, 11128, 11130, 11138, 11224, 11337, 11380, 11415, 11468, 11492, 11912, 11913, 11914, 12088, 12089, 12302, 12305, 12308, 12309, 20425, 20426, 20578, 20641, 21051, 30238, 30240, 40128, 40129, 40130, 40476, 40513, 40514, 40613, 11995, 11998, 12012, 12014, 12015, 11283, 11284, 11285, 11290, 11291},
		[50] = {10739, 10807, 10808, 10809, 10810, 10811, 10812, 11015, 11016, 11017, 11018, 11019, 11339, 20297, 20298, 20299, 20323, 10674, 10675, 10677, 12026, 12027, 12037, 12039, 12040, 11292, 11293, 11294, 11296, 11297},
		[170001] = {10739, 10807, 10808, 10809, 10810, 10811, 10812, 11015, 11016, 11017, 11018, 11019, 11339, 20297, 20298, 20299, 20323, 10674, 10675, 10677, 12026, 12027, 12037, 12039, 12040, 11292, 11293, 11294, 11296, 11297}, [170010] = {10739, 10807, 10808, 10809, 10810, 10811, 10812, 11015, 11016, 11017, 11018, 11019, 11339, 20297, 20298, 20299, 20323, 10674, 10675, 10677, 12026, 12027, 12037, 12039, 12040, 11292, 11293, 11294, 11296, 11297}, [170050] = {10739, 10807, 10808, 10809, 10810, 10811, 10812, 11015, 11016, 11017, 11018, 11019, 11339, 20297, 20298, 20299, 20323, 10674, 10675, 10677, 12026, 12027, 12037, 12039, 12040, 11292, 11293, 11294, 11296, 11297},
		[51] = {10021, 10022, 10023, 10038, 10059, 10062, 10318, 10319, 10354, 10355, 10356, 10617, 10666, 10707, 10733, 10771, 10773, 10825, 10834, 11242, 11496, 11514, 11592, 11662, 11793, 11794, 11881, 11882, 11902, 11950, 12150, 40004, 40492, 40512, 12043, 12047, 12048, 12052, 12053, 11313, 11318, 11319, 11323, 11324},
		[171001] = {10021, 10022, 10023, 10038, 10059, 10062, 10318, 10319, 10354, 10355, 10356, 10617, 10666, 10707, 10733, 10771, 10773, 10825, 10834, 11242, 11496, 11514, 11592, 11662, 11793, 11794, 11881, 11882, 11902, 11950, 12150, 40004, 40492, 40512, 12043, 12047, 12048, 12052, 12053, 11313, 11318, 11319, 11323, 11324}, [171010] = {10021, 10022, 10023, 10038, 10059, 10062, 10318, 10319, 10354, 10355, 10356, 10617, 10666, 10707, 10733, 10771, 10773, 10825, 10834, 11242, 11496, 11514, 11592, 11662, 11793, 11794, 11881, 11882, 11902, 11950, 12150, 40004, 40492, 40512, 12043, 12047, 12048, 12052, 12053, 11313, 11318, 11319, 11323, 11324}, [171050] = {10021, 10022, 10023, 10038, 10059, 10062, 10318, 10319, 10354, 10355, 10356, 10617, 10666, 10707, 10733, 10771, 10773, 10825, 10834, 11242, 11496, 11514, 11592, 11662, 11793, 11794, 11881, 11882, 11902, 11950, 12150, 40004, 40492, 40512, 12043, 12047, 12048, 12052, 12053, 11313, 11318, 11319, 11323, 11324},
		[52] = {10723, 10724, 10725, 10775, 10776, 10816, 10817, 10884, 10885, 10886, 10935, 10936, 10937, 10982, 10983, 12057, 12063, 12074, 12075, 12076, 11325, 11326, 11340, 11344, 11345},
		[172001] = {10723, 10724, 10725, 10775, 10776, 10816, 10817, 10884, 10885, 10886, 10935, 10936, 10937, 10982, 10983, 12057, 12063, 12074, 12075, 12076, 11325, 11326, 11340, 11344, 11345}, [172010] = {10723, 10724, 10725, 10775, 10776, 10816, 10817, 10884, 10885, 10886, 10935, 10936, 10937, 10982, 10983, 12057, 12063, 12074, 12075, 12076, 11325, 11326, 11340, 11344, 11345}, [172050] = {10723, 10724, 10725, 10775, 10776, 10816, 10817, 10884, 10885, 10886, 10935, 10936, 10937, 10982, 10983, 12057, 12063, 12074, 12075, 12076, 11325, 11326, 11340, 11344, 11345},
		[53] = {10386, 10387, 10388, 10389, 10391, 10392, 10393, 11740, 11741, 11790, 40439, 10721, 10723, 10734, 12077, 12091, 12092, 12093, 12101, 11346, 11354, 11355, 11363, 11372},
		[173001] = {10386, 10387, 10388, 10389, 10391, 10392, 10393, 11740, 11741, 11790, 40439, 10721, 10723, 10734, 12077, 12091, 12092, 12093, 12101, 11346, 11354, 11355, 11363, 11372}, [173010] = {10386, 10387, 10388, 10389, 10391, 10392, 10393, 11740, 11741, 11790, 40439, 10721, 10723, 10734, 12077, 12091, 12092, 12093, 12101, 11346, 11354, 11355, 11363, 11372}, [173050] = {10386, 10387, 10388, 10389, 10391, 10392, 10393, 11740, 11741, 11790, 40439, 10721, 10723, 10734, 12077, 12091, 12092, 12093, 12101, 11346, 11354, 11355, 11363, 11372},
		[54] = {10259, 10268, 10516, 10517, 10519, 10520, 10605, 10760, 10761, 10762, 10779, 10789, 10795, 10819, 10932, 10980, 11177, 11274, 11287, 11312, 11984, 12007, 12139, 12155, 12296, 20328, 20383, 20410, 20606, 20709, 21120, 30179, 30180, 30214, 30331, 40029, 40427, 40428, 40429, 40430, 40645, 12102, 12104, 12109, 12113, 12114, 11373, 11374, 11375, 11376, 11385},
		[174001] = {10259, 10268, 10516, 10517, 10519, 10520, 10605, 10760, 10761, 10762, 10779, 10789, 10795, 10819, 10932, 10980, 11177, 11274, 11287, 11312, 11984, 12007, 12139, 12155, 12296, 20328, 20383, 20410, 20606, 20709, 21120, 30179, 30180, 30214, 30331, 40029, 40427, 40428, 40429, 40430, 40645, 12102, 12104, 12109, 12113, 12114, 11373, 11374, 11375, 11376, 11385}, [174010] = {10259, 10268, 10516, 10517, 10519, 10520, 10605, 10760, 10761, 10762, 10779, 10789, 10795, 10819, 10932, 10980, 11177, 11274, 11287, 11312, 11984, 12007, 12139, 12155, 12296, 20328, 20383, 20410, 20606, 20709, 21120, 30179, 30180, 30214, 30331, 40029, 40427, 40428, 40429, 40430, 40645, 12102, 12104, 12109, 12113, 12114, 11373, 11374, 11375, 11376, 11385}, [174050] = {10259, 10268, 10516, 10517, 10519, 10520, 10605, 10760, 10761, 10762, 10779, 10789, 10795, 10819, 10932, 10980, 11177, 11274, 11287, 11312, 11984, 12007, 12139, 12155, 12296, 20328, 20383, 20410, 20606, 20709, 21120, 30179, 30180, 30214, 30331, 40029, 40427, 40428, 40429, 40430, 40645, 12102, 12104, 12109, 12113, 12114, 11373, 11374, 11375, 11376, 11385},
	}
	ClientData._extraCardsMap = EXTRA_CARDS_MAP

	local EXPANSION_CARDS_MAP = {
		[1] = {10270, 40032, 40159, 40245, 40407, 40503, 40681, 10069, 10215, 10328, 10410, 10469, 10564, 10625, 10693, 10903, 11131, 11241, 11342, 11500, 11579, 11678, 11789, 11877, 12022, 12133, 12227, 20034, 20105, 20163, 20231, 20330, 20440, 20492, 20579, 20636, 20702, 20803, 20922, 21043, 30035, 30123, 30185, 30249, 30299, 30351, 30414, 30485, 30573, 10397, 10531, 10675, 11067, 11333, 20150, 20296, 20481, 30059, 30207, 10031, 10034, 10036, 10037, 10041, 10020, 10027, 10040, 10047, 10065},
		[181001] = {10270, 40032, 40159, 40245, 40407, 40503, 40681, 10069, 10215, 10328, 10410, 10469, 10564, 10625, 10693, 10903, 11131, 11241, 11342, 11500, 11579, 11678, 11789, 11877, 12022, 12133, 12227, 20034, 20105, 20163, 20231, 20330, 20440, 20492, 20579, 20636, 20702, 20803, 20922, 21043, 30035, 30123, 30185, 30249, 30299, 30351, 30414, 30485, 30573, 10397, 10531, 10675, 11067, 11333, 20150, 20296, 20481, 30059, 30207, 10031, 10034, 10036, 10037, 10041, 10020, 10027, 10040, 10047, 10065}, [181010] = {10270, 40032, 40159, 40245, 40407, 40503, 40681, 10069, 10215, 10328, 10410, 10469, 10564, 10625, 10693, 10903, 11131, 11241, 11342, 11500, 11579, 11678, 11789, 11877, 12022, 12133, 12227, 20034, 20105, 20163, 20231, 20330, 20440, 20492, 20579, 20636, 20702, 20803, 20922, 21043, 30035, 30123, 30185, 30249, 30299, 30351, 30414, 30485, 30573, 10397, 10531, 10675, 11067, 11333, 20150, 20296, 20481, 30059, 30207, 10031, 10034, 10036, 10037, 10041, 10020, 10027, 10040, 10047, 10065}, [181050] = {10270, 40032, 40159, 40245, 40407, 40503, 40681, 10069, 10215, 10328, 10410, 10469, 10564, 10625, 10693, 10903, 11131, 11241, 11342, 11500, 11579, 11678, 11789, 11877, 12022, 12133, 12227, 20034, 20105, 20163, 20231, 20330, 20440, 20492, 20579, 20636, 20702, 20803, 20922, 21043, 30035, 30123, 30185, 30249, 30299, 30351, 30414, 30485, 30573, 10397, 10531, 10675, 11067, 11333, 20150, 20296, 20481, 30059, 30207, 10031, 10034, 10036, 10037, 10041, 10020, 10027, 10040, 10047, 10065},
		[2] = {10293, 40034, 40164, 40247, 40408, 40506, 40684, 10070, 10216, 10330, 10413, 10472, 10565, 10626, 10694, 10921, 11132, 11243, 11367, 11501, 11596, 11691, 11792, 11878, 12023, 12134, 12241, 20035, 20109, 20164, 20232, 20331, 20442, 20500, 20580, 20637, 20705, 20817, 20923, 21052, 30038, 30125, 30187, 30253, 30300, 30352, 30419, 30488, 30577, 10408, 10532, 10690, 11068, 11466, 20155, 20306, 20482, 30060, 30212, 10045, 10046, 10049, 10051, 10055, 10074, 10075, 10076, 10082, 10086},
		[182001] = {10293, 40034, 40164, 40247, 40408, 40506, 40684, 10070, 10216, 10330, 10413, 10472, 10565, 10626, 10694, 10921, 11132, 11243, 11367, 11501, 11596, 11691, 11792, 11878, 12023, 12134, 12241, 20035, 20109, 20164, 20232, 20331, 20442, 20500, 20580, 20637, 20705, 20817, 20923, 21052, 30038, 30125, 30187, 30253, 30300, 30352, 30419, 30488, 30577, 10408, 10532, 10690, 11068, 11466, 20155, 20306, 20482, 30060, 30212, 10045, 10046, 10049, 10051, 10055, 10074, 10075, 10076, 10082, 10086}, [182010] = {10293, 40034, 40164, 40247, 40408, 40506, 40684, 10070, 10216, 10330, 10413, 10472, 10565, 10626, 10694, 10921, 11132, 11243, 11367, 11501, 11596, 11691, 11792, 11878, 12023, 12134, 12241, 20035, 20109, 20164, 20232, 20331, 20442, 20500, 20580, 20637, 20705, 20817, 20923, 21052, 30038, 30125, 30187, 30253, 30300, 30352, 30419, 30488, 30577, 10408, 10532, 10690, 11068, 11466, 20155, 20306, 20482, 30060, 30212, 10045, 10046, 10049, 10051, 10055, 10074, 10075, 10076, 10082, 10086}, [182050] = {10293, 40034, 40164, 40247, 40408, 40506, 40684, 10070, 10216, 10330, 10413, 10472, 10565, 10626, 10694, 10921, 11132, 11243, 11367, 11501, 11596, 11691, 11792, 11878, 12023, 12134, 12241, 20035, 20109, 20164, 20232, 20331, 20442, 20500, 20580, 20637, 20705, 20817, 20923, 21052, 30038, 30125, 30187, 30253, 30300, 30352, 30419, 30488, 30577, 10408, 10532, 10690, 11068, 11466, 20155, 20306, 20482, 30060, 30212, 10045, 10046, 10049, 10051, 10055, 10074, 10075, 10076, 10082, 10086},
		[3] = {10304, 40035, 40165, 40248, 40409, 40526, 40695, 10078, 10219, 10331, 10414, 10473, 10566, 10629, 10716, 10931, 11133, 11244, 11369, 11511, 11597, 11693, 11795, 11879, 12024, 12135, 12242, 20036, 20110, 20165, 20239, 20332, 20443, 20501, 20582, 20638, 20707, 20821, 20926, 21054, 30039, 30126, 30188, 30255, 30301, 30353, 30420, 30491, 30580, 10411, 10534, 10721, 11082, 11467, 20175, 20307, 20483, 30063, 30230, 10067, 10071, 10077, 10079, 10080, 10101, 10104, 10106, 10115, 10118},
		[183001] = {10304, 40035, 40165, 40248, 40409, 40526, 40695, 10078, 10219, 10331, 10414, 10473, 10566, 10629, 10716, 10931, 11133, 11244, 11369, 11511, 11597, 11693, 11795, 11879, 12024, 12135, 12242, 20036, 20110, 20165, 20239, 20332, 20443, 20501, 20582, 20638, 20707, 20821, 20926, 21054, 30039, 30126, 30188, 30255, 30301, 30353, 30420, 30491, 30580, 10411, 10534, 10721, 11082, 11467, 20175, 20307, 20483, 30063, 30230, 10067, 10071, 10077, 10079, 10080, 10101, 10104, 10106, 10115, 10118}, [183010] = {10304, 40035, 40165, 40248, 40409, 40526, 40695, 10078, 10219, 10331, 10414, 10473, 10566, 10629, 10716, 10931, 11133, 11244, 11369, 11511, 11597, 11693, 11795, 11879, 12024, 12135, 12242, 20036, 20110, 20165, 20239, 20332, 20443, 20501, 20582, 20638, 20707, 20821, 20926, 21054, 30039, 30126, 30188, 30255, 30301, 30353, 30420, 30491, 30580, 10411, 10534, 10721, 11082, 11467, 20175, 20307, 20483, 30063, 30230, 10067, 10071, 10077, 10079, 10080, 10101, 10104, 10106, 10115, 10118}, [183050] = {10304, 40035, 40165, 40248, 40409, 40526, 40695, 10078, 10219, 10331, 10414, 10473, 10566, 10629, 10716, 10931, 11133, 11244, 11369, 11511, 11597, 11693, 11795, 11879, 12024, 12135, 12242, 20036, 20110, 20165, 20239, 20332, 20443, 20501, 20582, 20638, 20707, 20821, 20926, 21054, 30039, 30126, 30188, 30255, 30301, 30353, 30420, 30491, 30580, 10411, 10534, 10721, 11082, 11467, 20175, 20307, 20483, 30063, 30230, 10067, 10071, 10077, 10079, 10080, 10101, 10104, 10106, 10115, 10118},
		[4] = {10306, 40036, 40166, 40257, 40413, 40535, 40702, 10093, 10220, 10333, 10415, 10476, 10567, 10631, 10728, 10933, 11140, 11263, 11370, 11517, 11598, 11696, 11796, 11880, 12036, 12136, 12243, 20037, 20114, 20166, 20241, 20334, 20444, 20502, 20587, 20639, 20708, 20828, 20927, 21057, 30047, 30129, 30192, 30256, 30302, 30354, 30421, 30492, 30581, 10418, 10535, 10734, 11095, 11736, 20178, 20308, 20497, 30067, 30241, 10083, 10084, 10085, 10088, 10090, 10122, 10134, 10136, 10137, 10138},
		[184001] = {10306, 40036, 40166, 40257, 40413, 40535, 40702, 10093, 10220, 10333, 10415, 10476, 10567, 10631, 10728, 10933, 11140, 11263, 11370, 11517, 11598, 11696, 11796, 11880, 12036, 12136, 12243, 20037, 20114, 20166, 20241, 20334, 20444, 20502, 20587, 20639, 20708, 20828, 20927, 21057, 30047, 30129, 30192, 30256, 30302, 30354, 30421, 30492, 30581, 10418, 10535, 10734, 11095, 11736, 20178, 20308, 20497, 30067, 30241, 10083, 10084, 10085, 10088, 10090, 10122, 10134, 10136, 10137, 10138}, [184010] = {10306, 40036, 40166, 40257, 40413, 40535, 40702, 10093, 10220, 10333, 10415, 10476, 10567, 10631, 10728, 10933, 11140, 11263, 11370, 11517, 11598, 11696, 11796, 11880, 12036, 12136, 12243, 20037, 20114, 20166, 20241, 20334, 20444, 20502, 20587, 20639, 20708, 20828, 20927, 21057, 30047, 30129, 30192, 30256, 30302, 30354, 30421, 30492, 30581, 10418, 10535, 10734, 11095, 11736, 20178, 20308, 20497, 30067, 30241, 10083, 10084, 10085, 10088, 10090, 10122, 10134, 10136, 10137, 10138}, [184050] = {10306, 40036, 40166, 40257, 40413, 40535, 40702, 10093, 10220, 10333, 10415, 10476, 10567, 10631, 10728, 10933, 11140, 11263, 11370, 11517, 11598, 11696, 11796, 11880, 12036, 12136, 12243, 20037, 20114, 20166, 20241, 20334, 20444, 20502, 20587, 20639, 20708, 20828, 20927, 21057, 30047, 30129, 30192, 30256, 30302, 30354, 30421, 30492, 30581, 10418, 10535, 10734, 11095, 11736, 20178, 20308, 20497, 30067, 30241, 10083, 10084, 10085, 10088, 10090, 10122, 10134, 10136, 10137, 10138},
		[5] = {10307, 40075, 40170, 40258, 40414, 40551, 40711, 10094, 10225, 10339, 10416, 10479, 10569, 10632, 10738, 10956, 11141, 11265, 11378, 11518, 11608, 11708, 11799, 11889, 12038, 12138, 12245, 20038, 20118, 20167, 20247, 20336, 20445, 20503, 20588, 20640, 20710, 20831, 20928, 21063, 30048, 30131, 30194, 30257, 30303, 30355, 30434, 30493, 30584, 10421, 10542, 10736, 11097, 11844, 20179, 20309, 20498, 30068, 30254, 10095, 10097, 10098, 10102, 10103, 10141, 10142, 10144, 10145, 10152},
		[185001] = {10307, 40075, 40170, 40258, 40414, 40551, 40711, 10094, 10225, 10339, 10416, 10479, 10569, 10632, 10738, 10956, 11141, 11265, 11378, 11518, 11608, 11708, 11799, 11889, 12038, 12138, 12245, 20038, 20118, 20167, 20247, 20336, 20445, 20503, 20588, 20640, 20710, 20831, 20928, 21063, 30048, 30131, 30194, 30257, 30303, 30355, 30434, 30493, 30584, 10421, 10542, 10736, 11097, 11844, 20179, 20309, 20498, 30068, 30254, 10095, 10097, 10098, 10102, 10103, 10141, 10142, 10144, 10145, 10152}, [185010] = {10307, 40075, 40170, 40258, 40414, 40551, 40711, 10094, 10225, 10339, 10416, 10479, 10569, 10632, 10738, 10956, 11141, 11265, 11378, 11518, 11608, 11708, 11799, 11889, 12038, 12138, 12245, 20038, 20118, 20167, 20247, 20336, 20445, 20503, 20588, 20640, 20710, 20831, 20928, 21063, 30048, 30131, 30194, 30257, 30303, 30355, 30434, 30493, 30584, 10421, 10542, 10736, 11097, 11844, 20179, 20309, 20498, 30068, 30254, 10095, 10097, 10098, 10102, 10103, 10141, 10142, 10144, 10145, 10152}, [185050] = {10307, 40075, 40170, 40258, 40414, 40551, 40711, 10094, 10225, 10339, 10416, 10479, 10569, 10632, 10738, 10956, 11141, 11265, 11378, 11518, 11608, 11708, 11799, 11889, 12038, 12138, 12245, 20038, 20118, 20167, 20247, 20336, 20445, 20503, 20588, 20640, 20710, 20831, 20928, 21063, 30048, 30131, 30194, 30257, 30303, 30355, 30434, 30493, 30584, 10421, 10542, 10736, 11097, 11844, 20179, 20309, 20498, 30068, 30254, 10095, 10097, 10098, 10102, 10103, 10141, 10142, 10144, 10145, 10152},
		[6] = {10308, 40076, 40176, 40268, 40415, 40552, 40713, 10100, 10226, 10341, 10417, 10480, 10570, 10633, 10741, 10958, 11143, 11266, 11389, 11520, 11611, 11709, 11800, 11892, 12044, 12141, 12248, 20041, 20120, 20168, 20248, 20337, 20446, 20504, 20589, 20642, 20715, 20846, 20929, 21075, 30052, 30133, 30195, 30259, 30304, 30356, 30436, 30495, 30585, 10422, 10553, 10740, 11098, 20019, 20181, 20327, 20499, 30069, 30341, 10107, 10113, 10135, 10146, 10148, 10156, 10164, 10165, 10167, 10168},
		[186001] = {10308, 40076, 40176, 40268, 40415, 40552, 40713, 10100, 10226, 10341, 10417, 10480, 10570, 10633, 10741, 10958, 11143, 11266, 11389, 11520, 11611, 11709, 11800, 11892, 12044, 12141, 12248, 20041, 20120, 20168, 20248, 20337, 20446, 20504, 20589, 20642, 20715, 20846, 20929, 21075, 30052, 30133, 30195, 30259, 30304, 30356, 30436, 30495, 30585, 10422, 10553, 10740, 11098, 20019, 20181, 20327, 20499, 30069, 30341, 10107, 10113, 10135, 10146, 10148, 10156, 10164, 10165, 10167, 10168}, [186010] = {10308, 40076, 40176, 40268, 40415, 40552, 40713, 10100, 10226, 10341, 10417, 10480, 10570, 10633, 10741, 10958, 11143, 11266, 11389, 11520, 11611, 11709, 11800, 11892, 12044, 12141, 12248, 20041, 20120, 20168, 20248, 20337, 20446, 20504, 20589, 20642, 20715, 20846, 20929, 21075, 30052, 30133, 30195, 30259, 30304, 30356, 30436, 30495, 30585, 10422, 10553, 10740, 11098, 20019, 20181, 20327, 20499, 30069, 30341, 10107, 10113, 10135, 10146, 10148, 10156, 10164, 10165, 10167, 10168}, [186050] = {10308, 40076, 40176, 40268, 40415, 40552, 40713, 10100, 10226, 10341, 10417, 10480, 10570, 10633, 10741, 10958, 11143, 11266, 11389, 11520, 11611, 11709, 11800, 11892, 12044, 12141, 12248, 20041, 20120, 20168, 20248, 20337, 20446, 20504, 20589, 20642, 20715, 20846, 20929, 21075, 30052, 30133, 30195, 30259, 30304, 30356, 30436, 30495, 30585, 10422, 10553, 10740, 11098, 20019, 20181, 20327, 20499, 30069, 30341, 10107, 10113, 10135, 10146, 10148, 10156, 10164, 10165, 10167, 10168},
		[7] = {10407, 40079, 40180, 40290, 40416, 40558, 40717, 10105, 10228, 10352, 10419, 10481, 10571, 10634, 10742, 10959, 11144, 11267, 11390, 11528, 11612, 11710, 11801, 11894, 12045, 12146, 12249, 20049, 20121, 20171, 20249, 20338, 20447, 20505, 20590, 20645, 20716, 20849, 20932, 21077, 30070, 30136, 30196, 30261, 30306, 30359, 30441, 30496, 30588, 10426, 10554, 10743, 11101, 20025, 20184, 20351, 20513, 30072, 30343, 10149, 10150, 10151, 10153, 10162, 10169, 10170, 10171, 10172, 10173},
		[187001] = {10407, 40079, 40180, 40290, 40416, 40558, 40717, 10105, 10228, 10352, 10419, 10481, 10571, 10634, 10742, 10959, 11144, 11267, 11390, 11528, 11612, 11710, 11801, 11894, 12045, 12146, 12249, 20049, 20121, 20171, 20249, 20338, 20447, 20505, 20590, 20645, 20716, 20849, 20932, 21077, 30070, 30136, 30196, 30261, 30306, 30359, 30441, 30496, 30588, 10426, 10554, 10743, 11101, 20025, 20184, 20351, 20513, 30072, 30343, 10149, 10150, 10151, 10153, 10162, 10169, 10170, 10171, 10172, 10173}, [187010] = {10407, 40079, 40180, 40290, 40416, 40558, 40717, 10105, 10228, 10352, 10419, 10481, 10571, 10634, 10742, 10959, 11144, 11267, 11390, 11528, 11612, 11710, 11801, 11894, 12045, 12146, 12249, 20049, 20121, 20171, 20249, 20338, 20447, 20505, 20590, 20645, 20716, 20849, 20932, 21077, 30070, 30136, 30196, 30261, 30306, 30359, 30441, 30496, 30588, 10426, 10554, 10743, 11101, 20025, 20184, 20351, 20513, 30072, 30343, 10149, 10150, 10151, 10153, 10162, 10169, 10170, 10171, 10172, 10173}, [187050] = {10407, 40079, 40180, 40290, 40416, 40558, 40717, 10105, 10228, 10352, 10419, 10481, 10571, 10634, 10742, 10959, 11144, 11267, 11390, 11528, 11612, 11710, 11801, 11894, 12045, 12146, 12249, 20049, 20121, 20171, 20249, 20338, 20447, 20505, 20590, 20645, 20716, 20849, 20932, 21077, 30070, 30136, 30196, 30261, 30306, 30359, 30441, 30496, 30588, 10426, 10554, 10743, 11101, 20025, 20184, 20351, 20513, 30072, 30343, 10149, 10150, 10151, 10153, 10162, 10169, 10170, 10171, 10172, 10173},
		[8] = {10446, 40080, 40182, 40292, 40418, 40570, 10003, 10108, 10229, 10353, 10423, 10494, 10573, 10635, 10754, 10971, 11163, 11268, 11391, 11531, 11614, 11711, 11802, 11897, 12046, 12147, 12255, 20050, 20123, 20172, 20250, 20342, 20448, 20509, 20591, 20647, 20718, 20850, 20935, 21079, 30074, 30144, 30197, 30262, 30307, 30360, 30443, 30500, 40006, 10428, 10555, 10744, 11103, 20039, 20187, 20358, 20558, 30084, 30370, 10177, 10181, 10182, 10183, 10184, 10174, 10175, 10176, 10178, 10179},
		[188001] = {10446, 40080, 40182, 40292, 40418, 40570, 10003, 10108, 10229, 10353, 10423, 10494, 10573, 10635, 10754, 10971, 11163, 11268, 11391, 11531, 11614, 11711, 11802, 11897, 12046, 12147, 12255, 20050, 20123, 20172, 20250, 20342, 20448, 20509, 20591, 20647, 20718, 20850, 20935, 21079, 30074, 30144, 30197, 30262, 30307, 30360, 30443, 30500, 40006, 10428, 10555, 10744, 11103, 20039, 20187, 20358, 20558, 30084, 30370, 10177, 10181, 10182, 10183, 10184, 10174, 10175, 10176, 10178, 10179}, [188010] = {10446, 40080, 40182, 40292, 40418, 40570, 10003, 10108, 10229, 10353, 10423, 10494, 10573, 10635, 10754, 10971, 11163, 11268, 11391, 11531, 11614, 11711, 11802, 11897, 12046, 12147, 12255, 20050, 20123, 20172, 20250, 20342, 20448, 20509, 20591, 20647, 20718, 20850, 20935, 21079, 30074, 30144, 30197, 30262, 30307, 30360, 30443, 30500, 40006, 10428, 10555, 10744, 11103, 20039, 20187, 20358, 20558, 30084, 30370, 10177, 10181, 10182, 10183, 10184, 10174, 10175, 10176, 10178, 10179}, [188050] = {10446, 40080, 40182, 40292, 40418, 40570, 10003, 10108, 10229, 10353, 10423, 10494, 10573, 10635, 10754, 10971, 11163, 11268, 11391, 11531, 11614, 11711, 11802, 11897, 12046, 12147, 12255, 20050, 20123, 20172, 20250, 20342, 20448, 20509, 20591, 20647, 20718, 20850, 20935, 21079, 30074, 30144, 30197, 30262, 30307, 30360, 30443, 30500, 40006, 10428, 10555, 10744, 11103, 20039, 20187, 20358, 20558, 30084, 30370, 10177, 10181, 10182, 10183, 10184, 10174, 10175, 10176, 10178, 10179},
		[9] = {10763, 40081, 40183, 40293, 40419, 40572, 10005, 10110, 10231, 10358, 10424, 10495, 10574, 10637, 10755, 10978, 11166, 11270, 11392, 11543, 11616, 11712, 11803, 11903, 12050, 12148, 12256, 20051, 20124, 20173, 20255, 20345, 20451, 20510, 20592, 20648, 20719, 20851, 20937, 21080, 30076, 30146, 30198, 30263, 30308, 30361, 30444, 30501, 40007, 10442, 10561, 10769, 11104, 20040, 20210, 20359, 20559, 30089, 30371, 10186, 10187, 10204, 10205, 10223, 10180, 10188, 10190, 10191, 10192},
		[189001] = {10763, 40081, 40183, 40293, 40419, 40572, 10005, 10110, 10231, 10358, 10424, 10495, 10574, 10637, 10755, 10978, 11166, 11270, 11392, 11543, 11616, 11712, 11803, 11903, 12050, 12148, 12256, 20051, 20124, 20173, 20255, 20345, 20451, 20510, 20592, 20648, 20719, 20851, 20937, 21080, 30076, 30146, 30198, 30263, 30308, 30361, 30444, 30501, 40007, 10442, 10561, 10769, 11104, 20040, 20210, 20359, 20559, 30089, 30371, 10186, 10187, 10204, 10205, 10223, 10180, 10188, 10190, 10191, 10192}, [189010] = {10763, 40081, 40183, 40293, 40419, 40572, 10005, 10110, 10231, 10358, 10424, 10495, 10574, 10637, 10755, 10978, 11166, 11270, 11392, 11543, 11616, 11712, 11803, 11903, 12050, 12148, 12256, 20051, 20124, 20173, 20255, 20345, 20451, 20510, 20592, 20648, 20719, 20851, 20937, 21080, 30076, 30146, 30198, 30263, 30308, 30361, 30444, 30501, 40007, 10442, 10561, 10769, 11104, 20040, 20210, 20359, 20559, 30089, 30371, 10186, 10187, 10204, 10205, 10223, 10180, 10188, 10190, 10191, 10192}, [189050] = {10763, 40081, 40183, 40293, 40419, 40572, 10005, 10110, 10231, 10358, 10424, 10495, 10574, 10637, 10755, 10978, 11166, 11270, 11392, 11543, 11616, 11712, 11803, 11903, 12050, 12148, 12256, 20051, 20124, 20173, 20255, 20345, 20451, 20510, 20592, 20648, 20719, 20851, 20937, 21080, 30076, 30146, 30198, 30263, 30308, 30361, 30444, 30501, 40007, 10442, 10561, 10769, 11104, 20040, 20210, 20359, 20559, 30089, 30371, 10186, 10187, 10204, 10205, 10223, 10180, 10188, 10190, 10191, 10192},
		[10] = {10895, 40083, 40192, 40294, 40420, 40573, 10009, 10126, 10232, 10367, 10425, 10499, 10577, 10638, 10756, 10979, 11167, 11272, 11438, 11548, 11617, 11713, 11805, 11916, 12056, 12149, 12258, 20055, 20129, 20177, 20257, 20346, 20453, 20515, 20600, 20649, 20727, 20853, 20948, 21081, 30085, 30147, 30199, 30264, 30309, 30362, 30450, 30502, 40009, 10460, 10562, 10802, 11105, 20044, 20218, 20379, 20560, 30092, 30375, 10244, 10245, 10247, 10248, 10249, 10193, 10194, 10196, 10197, 10198},
		[190001] = {10895, 40083, 40192, 40294, 40420, 40573, 10009, 10126, 10232, 10367, 10425, 10499, 10577, 10638, 10756, 10979, 11167, 11272, 11438, 11548, 11617, 11713, 11805, 11916, 12056, 12149, 12258, 20055, 20129, 20177, 20257, 20346, 20453, 20515, 20600, 20649, 20727, 20853, 20948, 21081, 30085, 30147, 30199, 30264, 30309, 30362, 30450, 30502, 40009, 10460, 10562, 10802, 11105, 20044, 20218, 20379, 20560, 30092, 30375, 10244, 10245, 10247, 10248, 10249, 10193, 10194, 10196, 10197, 10198}, [190010] = {10895, 40083, 40192, 40294, 40420, 40573, 10009, 10126, 10232, 10367, 10425, 10499, 10577, 10638, 10756, 10979, 11167, 11272, 11438, 11548, 11617, 11713, 11805, 11916, 12056, 12149, 12258, 20055, 20129, 20177, 20257, 20346, 20453, 20515, 20600, 20649, 20727, 20853, 20948, 21081, 30085, 30147, 30199, 30264, 30309, 30362, 30450, 30502, 40009, 10460, 10562, 10802, 11105, 20044, 20218, 20379, 20560, 30092, 30375, 10244, 10245, 10247, 10248, 10249, 10193, 10194, 10196, 10197, 10198}, [190050] = {10895, 40083, 40192, 40294, 40420, 40573, 10009, 10126, 10232, 10367, 10425, 10499, 10577, 10638, 10756, 10979, 11167, 11272, 11438, 11548, 11617, 11713, 11805, 11916, 12056, 12149, 12258, 20055, 20129, 20177, 20257, 20346, 20453, 20515, 20600, 20649, 20727, 20853, 20948, 21081, 30085, 30147, 30199, 30264, 30309, 30362, 30450, 30502, 40009, 10460, 10562, 10802, 11105, 20044, 20218, 20379, 20560, 30092, 30375, 10244, 10245, 10247, 10248, 10249, 10193, 10194, 10196, 10197, 10198},
		[11] = {10896, 40087, 40193, 40297, 40421, 40576, 10010, 10129, 10233, 10368, 10427, 10500, 10578, 10641, 10757, 10981, 11183, 11273, 11439, 11549, 11620, 11714, 11806, 11917, 12067, 12153, 12259, 20056, 20131, 20180, 20258, 20347, 20454, 20527, 20601, 20651, 20728, 20857, 20949, 21083, 30086, 30148, 30200, 30265, 30312, 30373, 30451, 30503, 40014, 10461, 10572, 10803, 11107, 20047, 20221, 20387, 20673, 30095, 30404, 10261, 10275, 10276, 10289, 10290, 10199, 10200, 10201, 10202, 10203},
		[191001] = {10896, 40087, 40193, 40297, 40421, 40576, 10010, 10129, 10233, 10368, 10427, 10500, 10578, 10641, 10757, 10981, 11183, 11273, 11439, 11549, 11620, 11714, 11806, 11917, 12067, 12153, 12259, 20056, 20131, 20180, 20258, 20347, 20454, 20527, 20601, 20651, 20728, 20857, 20949, 21083, 30086, 30148, 30200, 30265, 30312, 30373, 30451, 30503, 40014, 10461, 10572, 10803, 11107, 20047, 20221, 20387, 20673, 30095, 30404, 10261, 10275, 10276, 10289, 10290, 10199, 10200, 10201, 10202, 10203}, [191010] = {10896, 40087, 40193, 40297, 40421, 40576, 10010, 10129, 10233, 10368, 10427, 10500, 10578, 10641, 10757, 10981, 11183, 11273, 11439, 11549, 11620, 11714, 11806, 11917, 12067, 12153, 12259, 20056, 20131, 20180, 20258, 20347, 20454, 20527, 20601, 20651, 20728, 20857, 20949, 21083, 30086, 30148, 30200, 30265, 30312, 30373, 30451, 30503, 40014, 10461, 10572, 10803, 11107, 20047, 20221, 20387, 20673, 30095, 30404, 10261, 10275, 10276, 10289, 10290, 10199, 10200, 10201, 10202, 10203}, [191050] = {10896, 40087, 40193, 40297, 40421, 40576, 10010, 10129, 10233, 10368, 10427, 10500, 10578, 10641, 10757, 10981, 11183, 11273, 11439, 11549, 11620, 11714, 11806, 11917, 12067, 12153, 12259, 20056, 20131, 20180, 20258, 20347, 20454, 20527, 20601, 20651, 20728, 20857, 20949, 21083, 30086, 30148, 30200, 30265, 30312, 30373, 30451, 30503, 40014, 10461, 10572, 10803, 11107, 20047, 20221, 20387, 20673, 30095, 30404, 10261, 10275, 10276, 10289, 10290, 10199, 10200, 10201, 10202, 10203},
		[12] = {11308, 40089, 40204, 40298, 40422, 40607, 10011, 10130, 10235, 10370, 10429, 10506, 10579, 10642, 10768, 11038, 11184, 11275, 11441, 11550, 11628, 11715, 11807, 11920, 12068, 12154, 12261, 20059, 20132, 20182, 20265, 20348, 20455, 20528, 20602, 20652, 20743, 20865, 20950, 21089, 30087, 30151, 30206, 30269, 30315, 30376, 30452, 30504, 40017, 10463, 10583, 10804, 11134, 20048, 20223, 20389, 20753, 30096, 30405, 10291, 10313, 10324, 10347, 10357, 10207, 10209, 10212, 10218, 10250},
		[192001] = {11308, 40089, 40204, 40298, 40422, 40607, 10011, 10130, 10235, 10370, 10429, 10506, 10579, 10642, 10768, 11038, 11184, 11275, 11441, 11550, 11628, 11715, 11807, 11920, 12068, 12154, 12261, 20059, 20132, 20182, 20265, 20348, 20455, 20528, 20602, 20652, 20743, 20865, 20950, 21089, 30087, 30151, 30206, 30269, 30315, 30376, 30452, 30504, 40017, 10463, 10583, 10804, 11134, 20048, 20223, 20389, 20753, 30096, 30405, 10291, 10313, 10324, 10347, 10357, 10207, 10209, 10212, 10218, 10250}, [192010] = {11308, 40089, 40204, 40298, 40422, 40607, 10011, 10130, 10235, 10370, 10429, 10506, 10579, 10642, 10768, 11038, 11184, 11275, 11441, 11550, 11628, 11715, 11807, 11920, 12068, 12154, 12261, 20059, 20132, 20182, 20265, 20348, 20455, 20528, 20602, 20652, 20743, 20865, 20950, 21089, 30087, 30151, 30206, 30269, 30315, 30376, 30452, 30504, 40017, 10463, 10583, 10804, 11134, 20048, 20223, 20389, 20753, 30096, 30405, 10291, 10313, 10324, 10347, 10357, 10207, 10209, 10212, 10218, 10250}, [192050] = {11308, 40089, 40204, 40298, 40422, 40607, 10011, 10130, 10235, 10370, 10429, 10506, 10579, 10642, 10768, 11038, 11184, 11275, 11441, 11550, 11628, 11715, 11807, 11920, 12068, 12154, 12261, 20059, 20132, 20182, 20265, 20348, 20455, 20528, 20602, 20652, 20743, 20865, 20950, 21089, 30087, 30151, 30206, 30269, 30315, 30376, 30452, 30504, 40017, 10463, 10583, 10804, 11134, 20048, 20223, 20389, 20753, 30096, 30405, 10291, 10313, 10324, 10347, 10357, 10207, 10209, 10212, 10218, 10250},
		[13] = {11695, 40106, 40206, 40299, 40426, 40608, 10015, 10131, 10236, 10371, 10433, 10509, 10580, 10643, 10770, 11047, 11185, 11276, 11443, 11556, 11630, 11718, 11819, 11930, 12069, 12156, 12262, 20061, 20133, 20183, 20268, 20350, 20460, 20530, 20603, 20653, 20744, 20867, 20958, 21096, 30088, 30155, 30211, 30272, 30316, 30377, 30453, 30508, 40019, 10467, 10584, 10818, 11135, 20065, 20237, 20390, 20755, 30104, 40002, 10441, 10483, 10504, 10575, 10587, 10251, 10252, 10253, 10254, 10255},
		[193001] = {11695, 40106, 40206, 40299, 40426, 40608, 10015, 10131, 10236, 10371, 10433, 10509, 10580, 10643, 10770, 11047, 11185, 11276, 11443, 11556, 11630, 11718, 11819, 11930, 12069, 12156, 12262, 20061, 20133, 20183, 20268, 20350, 20460, 20530, 20603, 20653, 20744, 20867, 20958, 21096, 30088, 30155, 30211, 30272, 30316, 30377, 30453, 30508, 40019, 10467, 10584, 10818, 11135, 20065, 20237, 20390, 20755, 30104, 40002, 10441, 10483, 10504, 10575, 10587, 10251, 10252, 10253, 10254, 10255}, [193010] = {11695, 40106, 40206, 40299, 40426, 40608, 10015, 10131, 10236, 10371, 10433, 10509, 10580, 10643, 10770, 11047, 11185, 11276, 11443, 11556, 11630, 11718, 11819, 11930, 12069, 12156, 12262, 20061, 20133, 20183, 20268, 20350, 20460, 20530, 20603, 20653, 20744, 20867, 20958, 21096, 30088, 30155, 30211, 30272, 30316, 30377, 30453, 30508, 40019, 10467, 10584, 10818, 11135, 20065, 20237, 20390, 20755, 30104, 40002, 10441, 10483, 10504, 10575, 10587, 10251, 10252, 10253, 10254, 10255}, [193050] = {11695, 40106, 40206, 40299, 40426, 40608, 10015, 10131, 10236, 10371, 10433, 10509, 10580, 10643, 10770, 11047, 11185, 11276, 11443, 11556, 11630, 11718, 11819, 11930, 12069, 12156, 12262, 20061, 20133, 20183, 20268, 20350, 20460, 20530, 20603, 20653, 20744, 20867, 20958, 21096, 30088, 30155, 30211, 30272, 30316, 30377, 30453, 30508, 40019, 10467, 10584, 10818, 11135, 20065, 20237, 20390, 20755, 30104, 40002, 10441, 10483, 10504, 10575, 10587, 10251, 10252, 10253, 10254, 10255},
		[14] = {11853, 40107, 40208, 40300, 40432, 40614, 10017, 10132, 10260, 10372, 10434, 10512, 10581, 10655, 10772, 11056, 11188, 11288, 11444, 11557, 11631, 11735, 11826, 11933, 12070, 12157, 12271, 20068, 20135, 20185, 20269, 20361, 20462, 20531, 20605, 20654, 20745, 20874, 20968, 21105, 30090, 30157, 30213, 30273, 30317, 30378, 30455, 30519, 10025, 10468, 10588, 10821, 11136, 20074, 20238, 20391, 20758, 30106, 40020, 10619, 10628, 10647, 10683, 10686, 10256, 10257, 10258, 10265, 10281},
		[194001] = {11853, 40107, 40208, 40300, 40432, 40614, 10017, 10132, 10260, 10372, 10434, 10512, 10581, 10655, 10772, 11056, 11188, 11288, 11444, 11557, 11631, 11735, 11826, 11933, 12070, 12157, 12271, 20068, 20135, 20185, 20269, 20361, 20462, 20531, 20605, 20654, 20745, 20874, 20968, 21105, 30090, 30157, 30213, 30273, 30317, 30378, 30455, 30519, 10025, 10468, 10588, 10821, 11136, 20074, 20238, 20391, 20758, 30106, 40020, 10619, 10628, 10647, 10683, 10686, 10256, 10257, 10258, 10265, 10281}, [194010] = {11853, 40107, 40208, 40300, 40432, 40614, 10017, 10132, 10260, 10372, 10434, 10512, 10581, 10655, 10772, 11056, 11188, 11288, 11444, 11557, 11631, 11735, 11826, 11933, 12070, 12157, 12271, 20068, 20135, 20185, 20269, 20361, 20462, 20531, 20605, 20654, 20745, 20874, 20968, 21105, 30090, 30157, 30213, 30273, 30317, 30378, 30455, 30519, 10025, 10468, 10588, 10821, 11136, 20074, 20238, 20391, 20758, 30106, 40020, 10619, 10628, 10647, 10683, 10686, 10256, 10257, 10258, 10265, 10281}, [194050] = {11853, 40107, 40208, 40300, 40432, 40614, 10017, 10132, 10260, 10372, 10434, 10512, 10581, 10655, 10772, 11056, 11188, 11288, 11444, 11557, 11631, 11735, 11826, 11933, 12070, 12157, 12271, 20068, 20135, 20185, 20269, 20361, 20462, 20531, 20605, 20654, 20745, 20874, 20968, 21105, 30090, 30157, 30213, 30273, 30317, 30378, 30455, 30519, 10025, 10468, 10588, 10821, 11136, 20074, 20238, 20391, 20758, 30106, 40020, 10619, 10628, 10647, 10683, 10686, 10256, 10257, 10258, 10265, 10281},
		[15] = {11934, 40108, 40209, 40302, 40440, 40615, 10019, 10133, 10267, 10373, 10435, 10513, 10582, 10657, 10778, 11057, 11189, 11295, 11445, 11559, 11634, 11737, 11827, 11943, 12071, 12166, 12272, 20070, 20136, 20191, 20270, 20362, 20466, 20532, 20607, 20657, 20746, 20885, 20969, 21112, 30091, 30162, 30215, 30274, 30318, 30381, 30456, 30524, 10033, 10470, 10589, 10832, 11137, 20076, 20243, 20409, 20822, 30107, 40022, 10687, 10722, 10732, 10745, 10746, 10284, 10285, 10287, 10302, 10303},
		[195001] = {11934, 40108, 40209, 40302, 40440, 40615, 10019, 10133, 10267, 10373, 10435, 10513, 10582, 10657, 10778, 11057, 11189, 11295, 11445, 11559, 11634, 11737, 11827, 11943, 12071, 12166, 12272, 20070, 20136, 20191, 20270, 20362, 20466, 20532, 20607, 20657, 20746, 20885, 20969, 21112, 30091, 30162, 30215, 30274, 30318, 30381, 30456, 30524, 10033, 10470, 10589, 10832, 11137, 20076, 20243, 20409, 20822, 30107, 40022, 10687, 10722, 10732, 10745, 10746, 10284, 10285, 10287, 10302, 10303}, [195010] = {11934, 40108, 40209, 40302, 40440, 40615, 10019, 10133, 10267, 10373, 10435, 10513, 10582, 10657, 10778, 11057, 11189, 11295, 11445, 11559, 11634, 11737, 11827, 11943, 12071, 12166, 12272, 20070, 20136, 20191, 20270, 20362, 20466, 20532, 20607, 20657, 20746, 20885, 20969, 21112, 30091, 30162, 30215, 30274, 30318, 30381, 30456, 30524, 10033, 10470, 10589, 10832, 11137, 20076, 20243, 20409, 20822, 30107, 40022, 10687, 10722, 10732, 10745, 10746, 10284, 10285, 10287, 10302, 10303}, [195050] = {11934, 40108, 40209, 40302, 40440, 40615, 10019, 10133, 10267, 10373, 10435, 10513, 10582, 10657, 10778, 11057, 11189, 11295, 11445, 11559, 11634, 11737, 11827, 11943, 12071, 12166, 12272, 20070, 20136, 20191, 20270, 20362, 20466, 20532, 20607, 20657, 20746, 20885, 20969, 21112, 30091, 30162, 30215, 30274, 30318, 30381, 30456, 30524, 10033, 10470, 10589, 10832, 11137, 20076, 20243, 20409, 20822, 30107, 40022, 10687, 10722, 10732, 10745, 10746, 10284, 10285, 10287, 10302, 10303},
		[16] = {12142, 40116, 40214, 40315, 40448, 40630, 10026, 10139, 10274, 10374, 10436, 10518, 10585, 10659, 10780, 11066, 11191, 11298, 11446, 11560, 11635, 11738, 11831, 11944, 12072, 12174, 12274, 20071, 20138, 20193, 20272, 20363, 20467, 20533, 20609, 20658, 20747, 20886, 20970, 21115, 30093, 30163, 30216, 30275, 30319, 30382, 30464, 30525, 10124, 10471, 10590, 10833, 11139, 20081, 20263, 20420, 30005, 30116, 40499, 10748, 10777, 10823, 10829, 10830, 10312, 10325, 10349, 10350, 10351},
		[196001] = {12142, 40116, 40214, 40315, 40448, 40630, 10026, 10139, 10274, 10374, 10436, 10518, 10585, 10659, 10780, 11066, 11191, 11298, 11446, 11560, 11635, 11738, 11831, 11944, 12072, 12174, 12274, 20071, 20138, 20193, 20272, 20363, 20467, 20533, 20609, 20658, 20747, 20886, 20970, 21115, 30093, 30163, 30216, 30275, 30319, 30382, 30464, 30525, 10124, 10471, 10590, 10833, 11139, 20081, 20263, 20420, 30005, 30116, 40499, 10748, 10777, 10823, 10829, 10830, 10312, 10325, 10349, 10350, 10351}, [196010] = {12142, 40116, 40214, 40315, 40448, 40630, 10026, 10139, 10274, 10374, 10436, 10518, 10585, 10659, 10780, 11066, 11191, 11298, 11446, 11560, 11635, 11738, 11831, 11944, 12072, 12174, 12274, 20071, 20138, 20193, 20272, 20363, 20467, 20533, 20609, 20658, 20747, 20886, 20970, 21115, 30093, 30163, 30216, 30275, 30319, 30382, 30464, 30525, 10124, 10471, 10590, 10833, 11139, 20081, 20263, 20420, 30005, 30116, 40499, 10748, 10777, 10823, 10829, 10830, 10312, 10325, 10349, 10350, 10351}, [196050] = {12142, 40116, 40214, 40315, 40448, 40630, 10026, 10139, 10274, 10374, 10436, 10518, 10585, 10659, 10780, 11066, 11191, 11298, 11446, 11560, 11635, 11738, 11831, 11944, 12072, 12174, 12274, 20071, 20138, 20193, 20272, 20363, 20467, 20533, 20609, 20658, 20747, 20886, 20970, 21115, 30093, 30163, 30216, 30275, 30319, 30382, 30464, 30525, 10124, 10471, 10590, 10833, 11139, 20081, 20263, 20420, 30005, 30116, 40499, 10748, 10777, 10823, 10829, 10830, 10312, 10325, 10349, 10350, 10351},
		[17] = {20142, 40117, 40218, 40322, 40451, 40631, 10028, 10147, 10277, 10375, 10437, 10523, 10586, 10660, 10792, 11069, 11194, 11304, 11459, 11561, 11637, 11739, 11832, 11949, 12073, 12175, 12277, 20072, 20139, 20195, 20273, 20376, 20469, 20537, 20610, 20668, 20748, 20888, 20992, 21122, 30097, 30165, 30217, 30277, 30328, 30384, 30466, 30529, 10125, 10474, 10594, 10844, 11164, 20083, 20264, 20421, 30011, 30117, 10837, 10838, 10868, 10869, 10872, 10359, 10360, 10364, 10365, 10394},
		[197001] = {20142, 40117, 40218, 40322, 40451, 40631, 10028, 10147, 10277, 10375, 10437, 10523, 10586, 10660, 10792, 11069, 11194, 11304, 11459, 11561, 11637, 11739, 11832, 11949, 12073, 12175, 12277, 20072, 20139, 20195, 20273, 20376, 20469, 20537, 20610, 20668, 20748, 20888, 20992, 21122, 30097, 30165, 30217, 30277, 30328, 30384, 30466, 30529, 10125, 10474, 10594, 10844, 11164, 20083, 20264, 20421, 30011, 30117, 10837, 10838, 10868, 10869, 10872, 10359, 10360, 10364, 10365, 10394}, [197010] = {20142, 40117, 40218, 40322, 40451, 40631, 10028, 10147, 10277, 10375, 10437, 10523, 10586, 10660, 10792, 11069, 11194, 11304, 11459, 11561, 11637, 11739, 11832, 11949, 12073, 12175, 12277, 20072, 20139, 20195, 20273, 20376, 20469, 20537, 20610, 20668, 20748, 20888, 20992, 21122, 30097, 30165, 30217, 30277, 30328, 30384, 30466, 30529, 10125, 10474, 10594, 10844, 11164, 20083, 20264, 20421, 30011, 30117, 10837, 10838, 10868, 10869, 10872, 10359, 10360, 10364, 10365, 10394}, [197050] = {20142, 40117, 40218, 40322, 40451, 40631, 10028, 10147, 10277, 10375, 10437, 10523, 10586, 10660, 10792, 11069, 11194, 11304, 11459, 11561, 11637, 11739, 11832, 11949, 12073, 12175, 12277, 20072, 20139, 20195, 20273, 20376, 20469, 20537, 20610, 20668, 20748, 20888, 20992, 21122, 30097, 30165, 30217, 30277, 30328, 30384, 30466, 30529, 10125, 10474, 10594, 10844, 11164, 20083, 20264, 20421, 30011, 30117, 10837, 10838, 10868, 10869, 10872, 10359, 10360, 10364, 10365, 10394},
		[18] = {20352, 40118, 40219, 40332, 40455, 40632, 10032, 10154, 10278, 10376, 10438, 10524, 10591, 10661, 10798, 11073, 11197, 11305, 11469, 11562, 11638, 11744, 11833, 11952, 12083, 12176, 12281, 20073, 20140, 20196, 20274, 20377, 20470, 20540, 20611, 20670, 20749, 20889, 20993, 21133, 30098, 30166, 30218, 30280, 30329, 30385, 30468, 30530, 10127, 10475, 10608, 10847, 11165, 20084, 20266, 20422, 30018, 30118, 10874, 10904, 10910, 10923, 10924, 10412, 10420, 10477, 10482, 10484},
		[198001] = {20352, 40118, 40219, 40332, 40455, 40632, 10032, 10154, 10278, 10376, 10438, 10524, 10591, 10661, 10798, 11073, 11197, 11305, 11469, 11562, 11638, 11744, 11833, 11952, 12083, 12176, 12281, 20073, 20140, 20196, 20274, 20377, 20470, 20540, 20611, 20670, 20749, 20889, 20993, 21133, 30098, 30166, 30218, 30280, 30329, 30385, 30468, 30530, 10127, 10475, 10608, 10847, 11165, 20084, 20266, 20422, 30018, 30118, 10874, 10904, 10910, 10923, 10924, 10412, 10420, 10477, 10482, 10484}, [198010] = {20352, 40118, 40219, 40332, 40455, 40632, 10032, 10154, 10278, 10376, 10438, 10524, 10591, 10661, 10798, 11073, 11197, 11305, 11469, 11562, 11638, 11744, 11833, 11952, 12083, 12176, 12281, 20073, 20140, 20196, 20274, 20377, 20470, 20540, 20611, 20670, 20749, 20889, 20993, 21133, 30098, 30166, 30218, 30280, 30329, 30385, 30468, 30530, 10127, 10475, 10608, 10847, 11165, 20084, 20266, 20422, 30018, 30118, 10874, 10904, 10910, 10923, 10924, 10412, 10420, 10477, 10482, 10484}, [198050] = {20352, 40118, 40219, 40332, 40455, 40632, 10032, 10154, 10278, 10376, 10438, 10524, 10591, 10661, 10798, 11073, 11197, 11305, 11469, 11562, 11638, 11744, 11833, 11952, 12083, 12176, 12281, 20073, 20140, 20196, 20274, 20377, 20470, 20540, 20611, 20670, 20749, 20889, 20993, 21133, 30098, 30166, 30218, 30280, 30329, 30385, 30468, 30530, 10127, 10475, 10608, 10847, 11165, 20084, 20266, 20422, 30018, 30118, 10874, 10904, 10910, 10923, 10924, 10412, 10420, 10477, 10482, 10484},
		[19] = {20742, 40119, 40220, 40333, 40458, 40639, 10035, 10157, 10279, 10382, 10439, 10525, 10593, 10662, 10806, 11077, 11198, 11306, 11470, 11563, 11639, 11748, 11843, 11953, 12084, 12179, 12287, 20075, 20141, 20199, 20283, 20382, 20474, 20541, 20612, 20671, 20752, 20890, 21000, 30001, 30099, 30167, 30219, 30281, 30332, 30390, 30470, 30537, 10140, 10491, 10611, 10853, 11168, 20085, 20267, 20428, 30020, 30130, 10925, 10948, 10949, 10953, 10975, 10485, 10486, 10487, 10489, 10490},
		[199001] = {20742, 40119, 40220, 40333, 40458, 40639, 10035, 10157, 10279, 10382, 10439, 10525, 10593, 10662, 10806, 11077, 11198, 11306, 11470, 11563, 11639, 11748, 11843, 11953, 12084, 12179, 12287, 20075, 20141, 20199, 20283, 20382, 20474, 20541, 20612, 20671, 20752, 20890, 21000, 30001, 30099, 30167, 30219, 30281, 30332, 30390, 30470, 30537, 10140, 10491, 10611, 10853, 11168, 20085, 20267, 20428, 30020, 30130, 10925, 10948, 10949, 10953, 10975, 10485, 10486, 10487, 10489, 10490}, [199010] = {20742, 40119, 40220, 40333, 40458, 40639, 10035, 10157, 10279, 10382, 10439, 10525, 10593, 10662, 10806, 11077, 11198, 11306, 11470, 11563, 11639, 11748, 11843, 11953, 12084, 12179, 12287, 20075, 20141, 20199, 20283, 20382, 20474, 20541, 20612, 20671, 20752, 20890, 21000, 30001, 30099, 30167, 30219, 30281, 30332, 30390, 30470, 30537, 10140, 10491, 10611, 10853, 11168, 20085, 20267, 20428, 30020, 30130, 10925, 10948, 10949, 10953, 10975, 10485, 10486, 10487, 10489, 10490}, [199050] = {20742, 40119, 40220, 40333, 40458, 40639, 10035, 10157, 10279, 10382, 10439, 10525, 10593, 10662, 10806, 11077, 11198, 11306, 11470, 11563, 11639, 11748, 11843, 11953, 12084, 12179, 12287, 20075, 20141, 20199, 20283, 20382, 20474, 20541, 20612, 20671, 20752, 20890, 21000, 30001, 30099, 30167, 30219, 30281, 30332, 30390, 30470, 30537, 10140, 10491, 10611, 10853, 11168, 20085, 20267, 20428, 30020, 30130, 10925, 10948, 10949, 10953, 10975, 10485, 10486, 10487, 10489, 10490},
		[20] = {20778, 40120, 40224, 40339, 40459, 40640, 10042, 10158, 10286, 10383, 10440, 10533, 10595, 10663, 10813, 11084, 11199, 11307, 11471, 11564, 11640, 11755, 11845, 11968, 12087, 12180, 12294, 20079, 20143, 20200, 20286, 20385, 20476, 20542, 20616, 20675, 20754, 20892, 21005, 30004, 30100, 30168, 30224, 30283, 30333, 30391, 30471, 30538, 10143, 10492, 10612, 10864, 11169, 20086, 20276, 20429, 30021, 30135, 10984, 10987, 10988, 10993, 10994, 10497, 10510, 10514, 10515, 10527},
		[200001] = {20778, 40120, 40224, 40339, 40459, 40640, 10042, 10158, 10286, 10383, 10440, 10533, 10595, 10663, 10813, 11084, 11199, 11307, 11471, 11564, 11640, 11755, 11845, 11968, 12087, 12180, 12294, 20079, 20143, 20200, 20286, 20385, 20476, 20542, 20616, 20675, 20754, 20892, 21005, 30004, 30100, 30168, 30224, 30283, 30333, 30391, 30471, 30538, 10143, 10492, 10612, 10864, 11169, 20086, 20276, 20429, 30021, 30135, 10984, 10987, 10988, 10993, 10994, 10497, 10510, 10514, 10515, 10527}, [200010] = {20778, 40120, 40224, 40339, 40459, 40640, 10042, 10158, 10286, 10383, 10440, 10533, 10595, 10663, 10813, 11084, 11199, 11307, 11471, 11564, 11640, 11755, 11845, 11968, 12087, 12180, 12294, 20079, 20143, 20200, 20286, 20385, 20476, 20542, 20616, 20675, 20754, 20892, 21005, 30004, 30100, 30168, 30224, 30283, 30333, 30391, 30471, 30538, 10143, 10492, 10612, 10864, 11169, 20086, 20276, 20429, 30021, 30135, 10984, 10987, 10988, 10993, 10994, 10497, 10510, 10514, 10515, 10527}, [200050] = {20778, 40120, 40224, 40339, 40459, 40640, 10042, 10158, 10286, 10383, 10440, 10533, 10595, 10663, 10813, 11084, 11199, 11307, 11471, 11564, 11640, 11755, 11845, 11968, 12087, 12180, 12294, 20079, 20143, 20200, 20286, 20385, 20476, 20542, 20616, 20675, 20754, 20892, 21005, 30004, 30100, 30168, 30224, 30283, 30333, 30391, 30471, 30538, 10143, 10492, 10612, 10864, 11169, 20086, 20276, 20429, 30021, 30135, 10984, 10987, 10988, 10993, 10994, 10497, 10510, 10514, 10515, 10527},
		[21] = {20779, 40121, 40225, 40341, 40467, 40642, 10044, 10159, 10288, 10384, 10443, 10536, 10596, 10664, 10820, 11094, 11201, 11310, 11472, 11565, 11641, 11756, 11847, 11983, 12090, 12182, 12295, 20080, 20144, 20201, 20287, 20388, 20477, 20545, 20617, 20677, 20766, 20894, 21010, 30007, 30101, 30169, 30231, 30284, 30334, 30392, 30472, 30545, 10329, 10493, 10613, 10934, 11170, 20088, 20277, 20435, 30037, 30145, 10995, 10996, 10997, 11008, 11044, 10537, 10543, 10548, 10560, 10576},
		[201001] = {20779, 40121, 40225, 40341, 40467, 40642, 10044, 10159, 10288, 10384, 10443, 10536, 10596, 10664, 10820, 11094, 11201, 11310, 11472, 11565, 11641, 11756, 11847, 11983, 12090, 12182, 12295, 20080, 20144, 20201, 20287, 20388, 20477, 20545, 20617, 20677, 20766, 20894, 21010, 30007, 30101, 30169, 30231, 30284, 30334, 30392, 30472, 30545, 10329, 10493, 10613, 10934, 11170, 20088, 20277, 20435, 30037, 30145, 10995, 10996, 10997, 11008, 11044, 10537, 10543, 10548, 10560, 10576}, [201010] = {20779, 40121, 40225, 40341, 40467, 40642, 10044, 10159, 10288, 10384, 10443, 10536, 10596, 10664, 10820, 11094, 11201, 11310, 11472, 11565, 11641, 11756, 11847, 11983, 12090, 12182, 12295, 20080, 20144, 20201, 20287, 20388, 20477, 20545, 20617, 20677, 20766, 20894, 21010, 30007, 30101, 30169, 30231, 30284, 30334, 30392, 30472, 30545, 10329, 10493, 10613, 10934, 11170, 20088, 20277, 20435, 30037, 30145, 10995, 10996, 10997, 11008, 11044, 10537, 10543, 10548, 10560, 10576}, [201050] = {20779, 40121, 40225, 40341, 40467, 40642, 10044, 10159, 10288, 10384, 10443, 10536, 10596, 10664, 10820, 11094, 11201, 11310, 11472, 11565, 11641, 11756, 11847, 11983, 12090, 12182, 12295, 20080, 20144, 20201, 20287, 20388, 20477, 20545, 20617, 20677, 20766, 20894, 21010, 30007, 30101, 30169, 30231, 30284, 30334, 30392, 30472, 30545, 10329, 10493, 10613, 10934, 11170, 20088, 20277, 20435, 30037, 30145, 10995, 10996, 10997, 11008, 11044, 10537, 10543, 10548, 10560, 10576},
		[22] = {21011, 40123, 40226, 40342, 40472, 40643, 10050, 10160, 10292, 10385, 10444, 10538, 10598, 10665, 10822, 11096, 11208, 11311, 11481, 11566, 11643, 11758, 11849, 12000, 12103, 12183, 12297, 20082, 20146, 20209, 20289, 20397, 20479, 20546, 20618, 20681, 20768, 20901, 21012, 30008, 30102, 30170, 30233, 30287, 30335, 30393, 30473, 30546, 10332, 10496, 10614, 10954, 11174, 20091, 20278, 20436, 30043, 30149, 11054, 11072, 11085, 11086, 11087, 10597, 10607, 10620, 10621, 10622},
		[202001] = {21011, 40123, 40226, 40342, 40472, 40643, 10050, 10160, 10292, 10385, 10444, 10538, 10598, 10665, 10822, 11096, 11208, 11311, 11481, 11566, 11643, 11758, 11849, 12000, 12103, 12183, 12297, 20082, 20146, 20209, 20289, 20397, 20479, 20546, 20618, 20681, 20768, 20901, 21012, 30008, 30102, 30170, 30233, 30287, 30335, 30393, 30473, 30546, 10332, 10496, 10614, 10954, 11174, 20091, 20278, 20436, 30043, 30149, 11054, 11072, 11085, 11086, 11087, 10597, 10607, 10620, 10621, 10622}, [202010] = {21011, 40123, 40226, 40342, 40472, 40643, 10050, 10160, 10292, 10385, 10444, 10538, 10598, 10665, 10822, 11096, 11208, 11311, 11481, 11566, 11643, 11758, 11849, 12000, 12103, 12183, 12297, 20082, 20146, 20209, 20289, 20397, 20479, 20546, 20618, 20681, 20768, 20901, 21012, 30008, 30102, 30170, 30233, 30287, 30335, 30393, 30473, 30546, 10332, 10496, 10614, 10954, 11174, 20091, 20278, 20436, 30043, 30149, 11054, 11072, 11085, 11086, 11087, 10597, 10607, 10620, 10621, 10622}, [202050] = {21011, 40123, 40226, 40342, 40472, 40643, 10050, 10160, 10292, 10385, 10444, 10538, 10598, 10665, 10822, 11096, 11208, 11311, 11481, 11566, 11643, 11758, 11849, 12000, 12103, 12183, 12297, 20082, 20146, 20209, 20289, 20397, 20479, 20546, 20618, 20681, 20768, 20901, 21012, 30008, 30102, 30170, 30233, 30287, 30335, 30393, 30473, 30546, 10332, 10496, 10614, 10954, 11174, 20091, 20278, 20436, 30043, 30149, 11054, 11072, 11085, 11086, 11087, 10597, 10607, 10620, 10621, 10622},
		[23] = {21100, 40126, 40233, 40343, 40477, 40649, 10052, 10163, 10299, 10395, 10445, 10541, 10602, 10667, 10824, 11099, 11210, 11314, 11482, 11569, 11646, 11759, 11850, 12001, 12105, 12184, 12298, 20087, 20147, 20211, 20295, 20399, 20480, 20550, 20619, 20685, 20769, 20903, 21017, 30009, 30103, 30172, 30234, 30290, 30336, 30394, 30474, 30548, 10334, 10501, 10615, 10955, 11186, 20095, 20279, 20437, 30044, 30150, 11088, 11091, 11092, 11129, 11147, 10624, 10644, 10645, 10646, 10649},
		[203001] = {21100, 40126, 40233, 40343, 40477, 40649, 10052, 10163, 10299, 10395, 10445, 10541, 10602, 10667, 10824, 11099, 11210, 11314, 11482, 11569, 11646, 11759, 11850, 12001, 12105, 12184, 12298, 20087, 20147, 20211, 20295, 20399, 20480, 20550, 20619, 20685, 20769, 20903, 21017, 30009, 30103, 30172, 30234, 30290, 30336, 30394, 30474, 30548, 10334, 10501, 10615, 10955, 11186, 20095, 20279, 20437, 30044, 30150, 11088, 11091, 11092, 11129, 11147, 10624, 10644, 10645, 10646, 10649}, [203010] = {21100, 40126, 40233, 40343, 40477, 40649, 10052, 10163, 10299, 10395, 10445, 10541, 10602, 10667, 10824, 11099, 11210, 11314, 11482, 11569, 11646, 11759, 11850, 12001, 12105, 12184, 12298, 20087, 20147, 20211, 20295, 20399, 20480, 20550, 20619, 20685, 20769, 20903, 21017, 30009, 30103, 30172, 30234, 30290, 30336, 30394, 30474, 30548, 10334, 10501, 10615, 10955, 11186, 20095, 20279, 20437, 30044, 30150, 11088, 11091, 11092, 11129, 11147, 10624, 10644, 10645, 10646, 10649}, [203050] = {21100, 40126, 40233, 40343, 40477, 40649, 10052, 10163, 10299, 10395, 10445, 10541, 10602, 10667, 10824, 11099, 11210, 11314, 11482, 11569, 11646, 11759, 11850, 12001, 12105, 12184, 12298, 20087, 20147, 20211, 20295, 20399, 20480, 20550, 20619, 20685, 20769, 20903, 21017, 30009, 30103, 30172, 30234, 30290, 30336, 30394, 30474, 30548, 10334, 10501, 10615, 10955, 11186, 20095, 20279, 20437, 30044, 30150, 11088, 11091, 11092, 11129, 11147, 10624, 10644, 10645, 10646, 10649},
		[24] = {40008, 40132, 40234, 40344, 40479, 40650, 10053, 10166, 10300, 10398, 10447, 10544, 10603, 10668, 10839, 11100, 11218, 11315, 11483, 11571, 11648, 11760, 11851, 12002, 12110, 12191, 20015, 20089, 20148, 20212, 20302, 20403, 20484, 20555, 20620, 20686, 20774, 20904, 21019, 30012, 30105, 30175, 30235, 30291, 30337, 30395, 30475, 30549, 10338, 10503, 10627, 10972, 11187, 20099, 20280, 20452, 30046, 30156, 11148, 11149, 11150, 11161, 11217, 10651, 10652, 10653, 10656, 10669},
		[204001] = {40008, 40132, 40234, 40344, 40479, 40650, 10053, 10166, 10300, 10398, 10447, 10544, 10603, 10668, 10839, 11100, 11218, 11315, 11483, 11571, 11648, 11760, 11851, 12002, 12110, 12191, 20015, 20089, 20148, 20212, 20302, 20403, 20484, 20555, 20620, 20686, 20774, 20904, 21019, 30012, 30105, 30175, 30235, 30291, 30337, 30395, 30475, 30549, 10338, 10503, 10627, 10972, 11187, 20099, 20280, 20452, 30046, 30156, 11148, 11149, 11150, 11161, 11217, 10651, 10652, 10653, 10656, 10669}, [204010] = {40008, 40132, 40234, 40344, 40479, 40650, 10053, 10166, 10300, 10398, 10447, 10544, 10603, 10668, 10839, 11100, 11218, 11315, 11483, 11571, 11648, 11760, 11851, 12002, 12110, 12191, 20015, 20089, 20148, 20212, 20302, 20403, 20484, 20555, 20620, 20686, 20774, 20904, 21019, 30012, 30105, 30175, 30235, 30291, 30337, 30395, 30475, 30549, 10338, 10503, 10627, 10972, 11187, 20099, 20280, 20452, 30046, 30156, 11148, 11149, 11150, 11161, 11217, 10651, 10652, 10653, 10656, 10669}, [204050] = {40008, 40132, 40234, 40344, 40479, 40650, 10053, 10166, 10300, 10398, 10447, 10544, 10603, 10668, 10839, 11100, 11218, 11315, 11483, 11571, 11648, 11760, 11851, 12002, 12110, 12191, 20015, 20089, 20148, 20212, 20302, 20403, 20484, 20555, 20620, 20686, 20774, 20904, 21019, 30012, 30105, 30175, 30235, 30291, 30337, 30395, 30475, 30549, 10338, 10503, 10627, 10972, 11187, 20099, 20280, 20452, 30046, 30156, 11148, 11149, 11150, 11161, 11217, 10651, 10652, 10653, 10656, 10669},
		[25] = {40012, 40136, 40235, 40349, 40481, 40661, 10054, 10185, 10315, 10399, 10448, 10545, 10604, 10670, 10845, 11102, 11219, 11316, 11484, 11572, 11656, 11762, 11852, 12003, 12112, 12203, 20020, 20094, 20151, 20213, 20304, 20405, 20485, 20562, 20621, 20687, 20777, 20905, 21021, 30015, 30109, 30176, 30236, 30292, 30338, 30401, 30476, 30552, 10340, 10521, 10630, 10974, 11190, 20107, 20281, 20457, 30049, 30159, 11222, 11233, 11234, 11235, 11247, 10684, 10685, 10695, 10696, 10697},
		[205001] = {40012, 40136, 40235, 40349, 40481, 40661, 10054, 10185, 10315, 10399, 10448, 10545, 10604, 10670, 10845, 11102, 11219, 11316, 11484, 11572, 11656, 11762, 11852, 12003, 12112, 12203, 20020, 20094, 20151, 20213, 20304, 20405, 20485, 20562, 20621, 20687, 20777, 20905, 21021, 30015, 30109, 30176, 30236, 30292, 30338, 30401, 30476, 30552, 10340, 10521, 10630, 10974, 11190, 20107, 20281, 20457, 30049, 30159, 11222, 11233, 11234, 11235, 11247, 10684, 10685, 10695, 10696, 10697}, [205010] = {40012, 40136, 40235, 40349, 40481, 40661, 10054, 10185, 10315, 10399, 10448, 10545, 10604, 10670, 10845, 11102, 11219, 11316, 11484, 11572, 11656, 11762, 11852, 12003, 12112, 12203, 20020, 20094, 20151, 20213, 20304, 20405, 20485, 20562, 20621, 20687, 20777, 20905, 21021, 30015, 30109, 30176, 30236, 30292, 30338, 30401, 30476, 30552, 10340, 10521, 10630, 10974, 11190, 20107, 20281, 20457, 30049, 30159, 11222, 11233, 11234, 11235, 11247, 10684, 10685, 10695, 10696, 10697}, [205050] = {40012, 40136, 40235, 40349, 40481, 40661, 10054, 10185, 10315, 10399, 10448, 10545, 10604, 10670, 10845, 11102, 11219, 11316, 11484, 11572, 11656, 11762, 11852, 12003, 12112, 12203, 20020, 20094, 20151, 20213, 20304, 20405, 20485, 20562, 20621, 20687, 20777, 20905, 21021, 30015, 30109, 30176, 30236, 30292, 30338, 30401, 30476, 30552, 10340, 10521, 10630, 10974, 11190, 20107, 20281, 20457, 30049, 30159, 11222, 11233, 11234, 11235, 11247, 10684, 10685, 10695, 10696, 10697},
		[26] = {40021, 40137, 40236, 40356, 40482, 40666, 10057, 10189, 10316, 10400, 10459, 10549, 10609, 10676, 10846, 11108, 11223, 11317, 11486, 11573, 11657, 11763, 11854, 12009, 12115, 12206, 20021, 20096, 20154, 20214, 20305, 20411, 20486, 20564, 20623, 20689, 20792, 20907, 21023, 30016, 30110, 30178, 30237, 30293, 30339, 30407, 30478, 30553, 10377, 10522, 10658, 11002, 11200, 20112, 20282, 20458, 30050, 30174, 11248, 11249, 11251, 11254, 11255, 10698, 10699, 10700, 10705, 10706},
		[206001] = {40021, 40137, 40236, 40356, 40482, 40666, 10057, 10189, 10316, 10400, 10459, 10549, 10609, 10676, 10846, 11108, 11223, 11317, 11486, 11573, 11657, 11763, 11854, 12009, 12115, 12206, 20021, 20096, 20154, 20214, 20305, 20411, 20486, 20564, 20623, 20689, 20792, 20907, 21023, 30016, 30110, 30178, 30237, 30293, 30339, 30407, 30478, 30553, 10377, 10522, 10658, 11002, 11200, 20112, 20282, 20458, 30050, 30174, 11248, 11249, 11251, 11254, 11255, 10698, 10699, 10700, 10705, 10706}, [206010] = {40021, 40137, 40236, 40356, 40482, 40666, 10057, 10189, 10316, 10400, 10459, 10549, 10609, 10676, 10846, 11108, 11223, 11317, 11486, 11573, 11657, 11763, 11854, 12009, 12115, 12206, 20021, 20096, 20154, 20214, 20305, 20411, 20486, 20564, 20623, 20689, 20792, 20907, 21023, 30016, 30110, 30178, 30237, 30293, 30339, 30407, 30478, 30553, 10377, 10522, 10658, 11002, 11200, 20112, 20282, 20458, 30050, 30174, 11248, 11249, 11251, 11254, 11255, 10698, 10699, 10700, 10705, 10706}, [206050] = {40021, 40137, 40236, 40356, 40482, 40666, 10057, 10189, 10316, 10400, 10459, 10549, 10609, 10676, 10846, 11108, 11223, 11317, 11486, 11573, 11657, 11763, 11854, 12009, 12115, 12206, 20021, 20096, 20154, 20214, 20305, 20411, 20486, 20564, 20623, 20689, 20792, 20907, 21023, 30016, 30110, 30178, 30237, 30293, 30339, 30407, 30478, 30553, 10377, 10522, 10658, 11002, 11200, 20112, 20282, 20458, 30050, 30174, 11248, 11249, 11251, 11254, 11255, 10698, 10699, 10700, 10705, 10706},
		[27] = {40024, 40147, 40239, 40357, 40483, 40667, 10061, 10195, 10322, 10403, 10462, 10550, 10610, 10678, 10857, 11109, 11226, 11330, 11490, 11574, 11658, 11765, 11855, 12011, 12125, 12216, 20024, 20098, 20156, 20217, 20315, 20419, 20487, 20572, 20624, 20695, 20793, 20910, 21029, 30025, 30111, 30181, 30242, 30294, 30340, 30408, 30480, 30560, 10378, 10526, 10671, 11028, 11207, 20115, 20285, 20459, 30055, 30189, 11261, 11262, 11280, 11320, 11321, 10720, 10726, 10735, 10737, 10758},
		[207001] = {40024, 40147, 40239, 40357, 40483, 40667, 10061, 10195, 10322, 10403, 10462, 10550, 10610, 10678, 10857, 11109, 11226, 11330, 11490, 11574, 11658, 11765, 11855, 12011, 12125, 12216, 20024, 20098, 20156, 20217, 20315, 20419, 20487, 20572, 20624, 20695, 20793, 20910, 21029, 30025, 30111, 30181, 30242, 30294, 30340, 30408, 30480, 30560, 10378, 10526, 10671, 11028, 11207, 20115, 20285, 20459, 30055, 30189, 11261, 11262, 11280, 11320, 11321, 10720, 10726, 10735, 10737, 10758}, [207010] = {40024, 40147, 40239, 40357, 40483, 40667, 10061, 10195, 10322, 10403, 10462, 10550, 10610, 10678, 10857, 11109, 11226, 11330, 11490, 11574, 11658, 11765, 11855, 12011, 12125, 12216, 20024, 20098, 20156, 20217, 20315, 20419, 20487, 20572, 20624, 20695, 20793, 20910, 21029, 30025, 30111, 30181, 30242, 30294, 30340, 30408, 30480, 30560, 10378, 10526, 10671, 11028, 11207, 20115, 20285, 20459, 30055, 30189, 11261, 11262, 11280, 11320, 11321, 10720, 10726, 10735, 10737, 10758}, [207050] = {40024, 40147, 40239, 40357, 40483, 40667, 10061, 10195, 10322, 10403, 10462, 10550, 10610, 10678, 10857, 11109, 11226, 11330, 11490, 11574, 11658, 11765, 11855, 12011, 12125, 12216, 20024, 20098, 20156, 20217, 20315, 20419, 20487, 20572, 20624, 20695, 20793, 20910, 21029, 30025, 30111, 30181, 30242, 30294, 30340, 30408, 30480, 30560, 10378, 10526, 10671, 11028, 11207, 20115, 20285, 20459, 30055, 30189, 11261, 11262, 11280, 11320, 11321, 10720, 10726, 10735, 10737, 10758},
		[28] = {40027, 40149, 40240, 40360, 40493, 40673, 10064, 10206, 10323, 10404, 10464, 10552, 10616, 10681, 10863, 11112, 11229, 11331, 11491, 11575, 11659, 11778, 11856, 12013, 12126, 12219, 20029, 20101, 20159, 20219, 20325, 20424, 20488, 20574, 20627, 20696, 20794, 20912, 21040, 30027, 30112, 30182, 30244, 30295, 30345, 30409, 30481, 30566, 10380, 10528, 10672, 11029, 11209, 20122, 20291, 20461, 30056, 30190, 11322, 11327, 11328, 11360, 11362, 10759, 10764, 10765, 10767, 10781},
		[208001] = {40027, 40149, 40240, 40360, 40493, 40673, 10064, 10206, 10323, 10404, 10464, 10552, 10616, 10681, 10863, 11112, 11229, 11331, 11491, 11575, 11659, 11778, 11856, 12013, 12126, 12219, 20029, 20101, 20159, 20219, 20325, 20424, 20488, 20574, 20627, 20696, 20794, 20912, 21040, 30027, 30112, 30182, 30244, 30295, 30345, 30409, 30481, 30566, 10380, 10528, 10672, 11029, 11209, 20122, 20291, 20461, 30056, 30190, 11322, 11327, 11328, 11360, 11362, 10759, 10764, 10765, 10767, 10781}, [208010] = {40027, 40149, 40240, 40360, 40493, 40673, 10064, 10206, 10323, 10404, 10464, 10552, 10616, 10681, 10863, 11112, 11229, 11331, 11491, 11575, 11659, 11778, 11856, 12013, 12126, 12219, 20029, 20101, 20159, 20219, 20325, 20424, 20488, 20574, 20627, 20696, 20794, 20912, 21040, 30027, 30112, 30182, 30244, 30295, 30345, 30409, 30481, 30566, 10380, 10528, 10672, 11029, 11209, 20122, 20291, 20461, 30056, 30190, 11322, 11327, 11328, 11360, 11362, 10759, 10764, 10765, 10767, 10781}, [208050] = {40027, 40149, 40240, 40360, 40493, 40673, 10064, 10206, 10323, 10404, 10464, 10552, 10616, 10681, 10863, 11112, 11229, 11331, 11491, 11575, 11659, 11778, 11856, 12013, 12126, 12219, 20029, 20101, 20159, 20219, 20325, 20424, 20488, 20574, 20627, 20696, 20794, 20912, 21040, 30027, 30112, 30182, 30244, 30295, 30345, 30409, 30481, 30566, 10380, 10528, 10672, 11029, 11209, 20122, 20291, 20461, 30056, 30190, 11322, 11327, 11328, 11360, 11362, 10759, 10764, 10765, 10767, 10781},
		[29] = {40030, 40152, 40243, 40387, 40500, 40674, 10066, 10211, 10326, 10406, 10465, 10558, 10618, 10691, 10882, 11116, 11236, 11332, 11494, 11576, 11676, 11779, 11874, 12020, 12128, 12221, 20030, 20103, 20161, 20225, 20326, 20427, 20489, 20575, 20629, 20697, 20795, 20914, 21041, 30028, 30113, 30183, 30245, 30296, 30346, 30410, 30483, 30569, 10381, 10529, 10673, 11037, 11238, 20127, 20293, 20464, 30057, 30193, 11368, 11377, 11398, 11400, 11401, 10782, 10787, 10788, 10793, 10794},
		[209001] = {40030, 40152, 40243, 40387, 40500, 40674, 10066, 10211, 10326, 10406, 10465, 10558, 10618, 10691, 10882, 11116, 11236, 11332, 11494, 11576, 11676, 11779, 11874, 12020, 12128, 12221, 20030, 20103, 20161, 20225, 20326, 20427, 20489, 20575, 20629, 20697, 20795, 20914, 21041, 30028, 30113, 30183, 30245, 30296, 30346, 30410, 30483, 30569, 10381, 10529, 10673, 11037, 11238, 20127, 20293, 20464, 30057, 30193, 11368, 11377, 11398, 11400, 11401, 10782, 10787, 10788, 10793, 10794}, [209010] = {40030, 40152, 40243, 40387, 40500, 40674, 10066, 10211, 10326, 10406, 10465, 10558, 10618, 10691, 10882, 11116, 11236, 11332, 11494, 11576, 11676, 11779, 11874, 12020, 12128, 12221, 20030, 20103, 20161, 20225, 20326, 20427, 20489, 20575, 20629, 20697, 20795, 20914, 21041, 30028, 30113, 30183, 30245, 30296, 30346, 30410, 30483, 30569, 10381, 10529, 10673, 11037, 11238, 20127, 20293, 20464, 30057, 30193, 11368, 11377, 11398, 11400, 11401, 10782, 10787, 10788, 10793, 10794}, [209050] = {40030, 40152, 40243, 40387, 40500, 40674, 10066, 10211, 10326, 10406, 10465, 10558, 10618, 10691, 10882, 11116, 11236, 11332, 11494, 11576, 11676, 11779, 11874, 12020, 12128, 12221, 20030, 20103, 20161, 20225, 20326, 20427, 20489, 20575, 20629, 20697, 20795, 20914, 21041, 30028, 30113, 30183, 30245, 30296, 30346, 30410, 30483, 30569, 10381, 10529, 10673, 11037, 11238, 20127, 20293, 20464, 30057, 30193, 11368, 11377, 11398, 11400, 11401, 10782, 10787, 10788, 10793, 10794},
		[30] = {40031, 40155, 40244, 40400, 40501, 40677, 10068, 10214, 10327, 10409, 10466, 10559, 10623, 10692, 10894, 11118, 11239, 11341, 11495, 11578, 11677, 11780, 11876, 12021, 12132, 12226, 20031, 20104, 20162, 20227, 20329, 20438, 20491, 20576, 20630, 20701, 20796, 20915, 21042, 30029, 30122, 30184, 30246, 30298, 30350, 30413, 30484, 30572, 10396, 10530, 10674, 11039, 11271, 20137, 20294, 20465, 30058, 30204, 11404, 11405, 11411, 11436, 11437, 10796, 10797, 10814, 10826, 10827},
		[210001] = {40031, 40155, 40244, 40400, 40501, 40677, 10068, 10214, 10327, 10409, 10466, 10559, 10623, 10692, 10894, 11118, 11239, 11341, 11495, 11578, 11677, 11780, 11876, 12021, 12132, 12226, 20031, 20104, 20162, 20227, 20329, 20438, 20491, 20576, 20630, 20701, 20796, 20915, 21042, 30029, 30122, 30184, 30246, 30298, 30350, 30413, 30484, 30572, 10396, 10530, 10674, 11039, 11271, 20137, 20294, 20465, 30058, 30204, 11404, 11405, 11411, 11436, 11437, 10796, 10797, 10814, 10826, 10827}, [210010] = {40031, 40155, 40244, 40400, 40501, 40677, 10068, 10214, 10327, 10409, 10466, 10559, 10623, 10692, 10894, 11118, 11239, 11341, 11495, 11578, 11677, 11780, 11876, 12021, 12132, 12226, 20031, 20104, 20162, 20227, 20329, 20438, 20491, 20576, 20630, 20701, 20796, 20915, 21042, 30029, 30122, 30184, 30246, 30298, 30350, 30413, 30484, 30572, 10396, 10530, 10674, 11039, 11271, 20137, 20294, 20465, 30058, 30204, 11404, 11405, 11411, 11436, 11437, 10796, 10797, 10814, 10826, 10827}, [210050] = {40031, 40155, 40244, 40400, 40501, 40677, 10068, 10214, 10327, 10409, 10466, 10559, 10623, 10692, 10894, 11118, 11239, 11341, 11495, 11578, 11677, 11780, 11876, 12021, 12132, 12226, 20031, 20104, 20162, 20227, 20329, 20438, 20491, 20576, 20630, 20701, 20796, 20915, 21042, 30029, 30122, 30184, 30246, 30298, 30350, 30413, 30484, 30572, 10396, 10530, 10674, 11039, 11271, 20137, 20294, 20465, 30058, 30204, 11404, 11405, 11411, 11436, 11437, 10796, 10797, 10814, 10826, 10827},
	}
	ClientData._expansionCardsMap = EXPANSION_CARDS_MAP

	local FAIRY_HERO_CARDS_MAP = {
		[1] = {
			12314, 12315, 12316, 12317, 12318, 12319, 12320,
			21135, 21136, 21137, 21138, 21139,
			30244, 12321, 30593, 40728,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[221001] = {
			12314, 12315, 12316, 12317, 12318, 12319, 12320,
			21135, 21136, 21137, 21138, 21139,
			30244, 12321, 30593, 40728,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[221010] = {
			12314, 12315, 12316, 12317, 12318, 12319, 12320,
			21135, 21136, 21137, 21138, 21139,
			30244, 12321, 30593, 40728,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[221050] = {
			12314, 12315, 12316, 12317, 12318, 12319, 12320,
			21135, 21136, 21137, 21138, 21139,
			30244, 12321, 30593, 40728,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[2] = {
			40730,
			12322, 12323, 12324, 12325, 12326, 12327, 12328, 12329, 12330, 21141, 21134, 40732, 21142, 40733,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[222001] = {
			40730,
			12322, 12323, 12324, 12325, 12326, 12327, 12328, 12329, 12330, 21141, 21134, 40732, 21142, 40733,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[222010] = {
			40730,
			12322, 12323, 12324, 12325, 12326, 12327, 12328, 12329, 12330, 21141, 21134, 40732, 21142, 40733,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[222050] = {
			40730,
			12322, 12323, 12324, 12325, 12326, 12327, 12328, 12329, 12330, 21141, 21134, 40732, 21142, 40733,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[3] = {
			40739,
			12331, 12332, 12333, 12334, 12335,
			21143, 21144,
			40734, 40735, 40737, 40738, 40740, 40741,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[223001] = {
			40739,
			12331, 12332, 12333, 12334, 12335,
			21143, 21144,
			40734, 40735, 40737, 40738, 40740, 40741,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[223010] = {
			40739,
			12331, 12332, 12333, 12334, 12335,
			21143, 21144,
			40734, 40735, 40737, 40738, 40740, 40741,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		},
		[223050] = {
			40739,
			12331, 12332, 12333, 12334, 12335,
			21143, 21144,
			40734, 40735, 40737, 40738, 40740, 40741,
			10034, 10036, 10037, 10041, 10049, 10055, 10077, 10083, 10088, 20004,
			10001, 10004, 10006, 10018, 10020
		}
	}
	ClientData._fairyHeroCardsMap = FAIRY_HERO_CARDS_MAP

	-- Card Box Info & Reset (Tavern / draw)
	local function injectPacks()
		if not rawget(_G, "Data") or not Data._recruitInfo then return end

		-- Helper to ensure pack object exists in Data._recruitInfo and Data._dropInfo
		local function registerPack(pval, cardList, ptype, pcost)
			local pidTbl = {}
			for _, pId in ipairs(cardList) do
				table.insert(pidTbl, { pId })
			end
			local item = Data._recruitInfo[pval] or (Data._dropInfo and Data._dropInfo[pval])
			if not item then
				item = {
					_id = pval,
					_value = pval,
					_type = ptype,
					_isHide = 0,
					_nameSid = 14202,
					_descSid = 14202,
					_param = { [1] = Data.ResType.gold, [2] = pcost, [3] = 0, [4] = 0, [5] = 0 },
					_pid = pidTbl,
					_rid = cardList,
					_cards = cardList,
					_showRes = { 0 }
				}
			else
				item._rid = cardList
				item._cards = cardList
				item._pid = pidTbl
				if not item._showRes then item._showRes = { 0 } end
				if not item._param then item._param = {} end
				item._param[1] = Data.ResType.gold
				item._param[2] = pcost
				item._isHide = 0
			end
			Data._recruitInfo[pval] = item
			if Data._dropInfo then Data._dropInfo[pval] = item end
		end

		-- Inject all 20 Character theme packs (1, 10, 50)
		for i = 1, 20 do
			local baseVal = 10100 + i * 100
			local cList = CHAR_CARDS_MAP[i] or CHAR_CARDS_MAP[baseVal + 1] or {}
			registerPack(baseVal + 1, cList, 1002, 500)
			registerPack(baseVal + 10, cList, 1002, 4500)
			registerPack(baseVal + 50, cList, 1002, 22500)
			registerPack(i, cList, 1002, 500)
		end

		-- Inject all 20 Liya theme packs (1, 10, 50)
		for i = 1, 20 do
			local prefix = 100000 + i * 1000
			local cList = LIYA_CARDS_MAP[i] or LIYA_CARDS_MAP[prefix + 10] or {}
			registerPack(prefix + 1, cList, 1001, 600)
			registerPack(prefix + 10, cList, 1001, 6000)
			registerPack(prefix + 50, cList, 1001, 28500)
			registerPack(i, cList, 1001, 600)
		end

		-- Inject 54 Extra theme packs (1, 10, 50)
		for i = 1, 54 do
			local prefix = 120000 + i * 1000
			local cList = EXTRA_CARDS_MAP[i] or EXTRA_CARDS_MAP[prefix + 10] or {}
			registerPack(prefix + 1, cList, 1001, 600)
			registerPack(prefix + 10, cList, 1001, 6000)
			registerPack(prefix + 50, cList, 1001, 28500)
		end

		-- Inject 30 Expansion theme packs (1, 10, 50)
		for i = 1, 30 do
			local prefix = 180000 + i * 1000
			local cList = EXPANSION_CARDS_MAP[i] or EXPANSION_CARDS_MAP[prefix + 10] or {}
			registerPack(prefix + 1, cList, 1001, 600)
			registerPack(prefix + 10, cList, 1001, 6000)
			registerPack(prefix + 50, cList, 1001, 28500)
		end

		-- Inject Fairy Hero theme pack (Gói bài tiên hiệp)
		local fhList = (FAIRY_HERO_CARDS_MAP and FAIRY_HERO_CARDS_MAP[1]) or {}
		registerPack(221001, fhList, 1001, 600)
		registerPack(221010, fhList, 1001, 6000)
		registerPack(221050, fhList, 1001, 28500)
		registerPack(1, fhList, 1001, 600)

		local tnList = (FAIRY_HERO_CARDS_MAP and FAIRY_HERO_CARDS_MAP[2]) or {}
		registerPack(222001, tnList, 1001, 600)
		registerPack(222010, tnList, 1001, 6000)
		registerPack(222050, tnList, 1001, 28500)
		registerPack(2, tnList, 1001, 600)

		local kmrList = (FAIRY_HERO_CARDS_MAP and FAIRY_HERO_CARDS_MAP[3]) or {}
		registerPack(223001, kmrList, 1001, 600)
		registerPack(223010, kmrList, 1001, 6000)
		registerPack(223050, kmrList, 1001, 28500)
		registerPack(3, kmrList, 1001, 600)

		if rawget(_G, "Data") and Data._magicInfo and Data._magicInfo[21134] then
			Data._magicInfo[21134]._keyword = 301
		end

		-- Amazoness & Harpie Pack & Keyword Synchronizer
		if rawget(_G, "Data") then
			local amazonPids = { 10123, 11694, 12192, 20054, 20301, 21094, 21146, 30171, 30594, 30595, 40047, 40659, 40662 }
			local harpiePids = { 10084, 10287, 20711, 21145, 21146, 30134, 30312, 30594, 30595, 40473, 40517, 40726, 40736 }

			local function appendPidsToDrop(dropId, pids)
				local drop = (Data._dropInfo and Data._dropInfo[dropId]) or (Data._recruitInfo and Data._recruitInfo[dropId])
				if drop and drop._pid then
					local existing = {}
					for _, item in ipairs(drop._pid) do
						if item and item[1] then existing[item[1]] = true end
					end
					for _, cid in ipairs(pids) do
						if not existing[cid] then
							table.insert(drop._pid, { cid })
							existing[cid] = true
						end
					end
				end
			end

			appendPidsToDrop(744, amazonPids)
			appendPidsToDrop(745, amazonPids)
			appendPidsToDrop(760, harpiePids)
			appendPidsToDrop(761, harpiePids)
			for _, bid in ipairs({ 12101, 12110, 12150 }) do
				appendPidsToDrop(bid, amazonPids)
			end
			for _, bid in ipairs({ 11501, 11510, 11550 }) do
				appendPidsToDrop(bid, harpiePids)
			end
			if Data._recruitInfo then
				if Data._recruitInfo[311001] then appendPidsToDrop(311001, amazonPids) end
				if Data._recruitInfo[311301] then appendPidsToDrop(311301, amazonPids) end
				if Data._recruitInfo[319001] then appendPidsToDrop(319001, harpiePids) end
				if Data._recruitInfo[319301] then appendPidsToDrop(319301, harpiePids) end
			end

			local function setPack(t, id, pids)
				if t and t[id] then
					t[id]._packageId = pids
				end
			end
			setPack(Data._magicInfo, 20054, {12101, 311001})
			setPack(Data._magicInfo, 20301, {12101, 311001})
			setPack(Data._magicInfo, 20711, {11501, 319001})
			setPack(Data._magicInfo, 21094, {12101, 311001})
			setPack(Data._magicInfo, 21145, {11501, 319001})
			setPack(Data._magicInfo, 21146, {11501, 12101, 319001, 311001})
			setPack(Data._trapInfo, 30134, {11501, 319001})
			setPack(Data._trapInfo, 30171, {12101, 311001})
			setPack(Data._trapInfo, 30312, {11501, 319001})
			setPack(Data._trapInfo, 30594, {11501, 12101, 311001, 319001})
			setPack(Data._trapInfo, 30595, {11501, 12101, 311001, 319001})
			setPack(Data._monsterInfo, 10084, {11501, 319001, 10601})
			setPack(Data._monsterInfo, 10123, {12101, 311001})
			setPack(Data._monsterInfo, 10287, {11501, 319001})
			setPack(Data._monsterInfo, 11694, {12101, 311001})
			setPack(Data._monsterInfo, 12192, {12101, 311001})
			setPack(Data._rareInfo, 40047, {12101, 311001})
			setPack(Data._rareInfo, 40473, {11501, 319001})
			setPack(Data._rareInfo, 40517, {11501, 319001})
			setPack(Data._rareInfo, 40659, {12101, 311001})
			setPack(Data._rareInfo, 40662, {12101, 311001})
			setPack(Data._rareInfo, 40726, {11501, 319001})
			setPack(Data._rareInfo, 40736, {11501, 319001})

			for _, cid in ipairs({ 12331, 12332, 12333, 12334, 12335 }) do
				setPack(Data._monsterInfo, cid, { 223001 })
			end
			for _, cid in ipairs({ 21143, 21144, 21147 }) do
				setPack(Data._magicInfo, cid, { 223001 })
			end
			for _, cid in ipairs({ 40734, 40735, 40737, 40738, 40739, 40740, 40741 }) do
				setPack(Data._rareInfo, cid, { 223001 })
			end
		end

		if rawget(_G, "Data") and Data._productsExInfo then
			if not Data._productsExInfo[59] then
				Data._productsExInfo[59] = {
					_id = 59,
					_cardId = 40209,
					_cost = 200000,
					_resType = 1,
					_date = "20170101.0"
				}
			end
		end

		if rawget(_G, "Data") and Data._diamondProductsInfo then
			if not Data._diamondProductsInfo[546] then
				Data._diamondProductsInfo[546] = {
					_id = 546,
					_cardId = 12330,
					_cost = 7000,
					_resType = 3,
					_type = 0,
					_date = "20240101.0"
				}
			end
		end

		if rawget(_G, "Data") and Data._monthCard5ProductsInfo then
			if not Data._monthCard5ProductsInfo[15] then
				Data._monthCard5ProductsInfo[15] = {
					_id = 15,
					_cardId = 12330,
					_cost = 7000,
					_resType = 3,
					_date = "20240101.0"
				}
			end
		end
	end
	ClientData.injectPacks = injectPacks
	pcall(injectPacks)

	-- Universal Pack Card Pool Helper
	ClientData.getPackCardPool = function(boxId)
		local pool = {}
		local added = {}
		local cList = nil

		if boxId then
			if boxId >= 221001 and boxId <= 230050 then
				local fhIdx = math.floor((boxId - 220000) / 1000)
				local fhm = ClientData._fairyHeroCardsMap or FAIRY_HERO_CARDS_MAP
				cList = fhm and (fhm[boxId] or fhm[fhIdx])
			elseif boxId >= 181001 and boxId <= 210050 then
				local expIdx = math.floor((boxId - 180000) / 1000)
				local xpm = ClientData._expansionCardsMap or EXPANSION_CARDS_MAP
				cList = xpm and (xpm[boxId] or xpm[expIdx])
			elseif boxId >= 121001 and boxId <= 174050 then
				local eIdx = math.floor((boxId - 120000) / 1000)
				local em = ClientData._extraCardsMap or EXTRA_CARDS_MAP
				cList = em and (em[boxId] or em[eIdx])
			elseif boxId >= 101001 and boxId <= 120050 then
				local lIdx = math.floor((boxId - 100000) / 1000)
				local lm = ClientData._liyaCardsMap or LIYA_CARDS_MAP
				cList = lm and (lm[boxId] or lm[lIdx])
			elseif boxId >= 10201 and boxId <= 12150 then
				local cIdx = math.floor((boxId - 10100) / 100)
				local cm = ClientData._charCardsMap or CHAR_CARDS_MAP
				cList = cm and (cm[boxId] or cm[cIdx])
			elseif FAIRY_HERO_CARDS_MAP and FAIRY_HERO_CARDS_MAP[boxId] then
				cList = FAIRY_HERO_CARDS_MAP[boxId]
			elseif EXPANSION_CARDS_MAP and EXPANSION_CARDS_MAP[boxId] then
				cList = EXPANSION_CARDS_MAP[boxId]
			elseif EXTRA_CARDS_MAP and EXTRA_CARDS_MAP[boxId] then
				cList = EXTRA_CARDS_MAP[boxId]
			elseif LIYA_CARDS_MAP and LIYA_CARDS_MAP[boxId] then
				cList = LIYA_CARDS_MAP[boxId]
			elseif CHAR_CARDS_MAP and CHAR_CARDS_MAP[boxId] then
				cList = CHAR_CARDS_MAP[boxId]
			end
		end

		if cList then
			for _, pId in ipairs(cList) do
				pId = tonumber(pId)
				if pId and pId > 0 and not added[pId] then
					added[pId] = true
					table.insert(pool, pId)
				end
			end
		end

		-- Fallback to recruit._pid / drop._pid if not in custom maps
		if #pool == 0 then
			local recruit = (Data and Data._recruitInfo and Data._recruitInfo[boxId]) or (Data and Data._dropInfo and Data._dropInfo[boxId])
			if recruit and recruit._pid then
				for _, pv in ipairs(recruit._pid) do
					local pId = type(pv) == "table" and (pv[1] or pv.id) or pv
					pId = tonumber(pId)
					if pId and pId > 0 and not added[pId] then
						added[pId] = true
						table.insert(pool, pId)
					end
				end
			end
			if #pool == 0 and recruit and recruit._rid then
				for _, pId in ipairs(recruit._rid) do
					pId = tonumber(pId)
					if pId and pId > 0 and not added[pId] then
						added[pId] = true
						table.insert(pool, pId)
					end
			end
			end
		end

		return pool
	end
	-- Card Box Info & Reset (Tavern / draw)
	ClientData.sendCardBoxInfo = function(boxId)
		pcall(injectPacks)
		ClientView.getActiveIndicator():hide()
		local s = lc._runningScene or ClientView._scene or lc.Director:getRunningScene()
		local curScene = s and (s._layer or s)
		if curScene and curScene._sceneId == ClientData.SceneId.tavern then
			local respCards = {}
			local added = {}

			-- 1. Showcase all cards belonging to this pack (exact drop pool)
			local packList = ClientData.getPackCardPool(boxId)
			if packList and #packList > 0 then
				for _, cardId in ipairs(packList) do
					if not added[cardId] then
						local info = (Data.getInfo and Data.getInfo(cardId)) or (Data._monsterInfo and Data._monsterInfo[cardId]) or (Data._magicInfo and Data._magicInfo[cardId]) or (Data._trapInfo and Data._trapInfo[cardId]) or (Data._rareInfo and Data._rareInfo[cardId])
						if info then
							added[cardId] = true
							local maxCount = (info and info._maxCount) or 3
							local gotCount = 0
							if P and P._playerCard then
								gotCount = math.min(maxCount, P._playerCard:getCardCount(cardId))
							end
							table.insert(respCards, {
								info_id = cardId,
								get_num = gotCount,
								remain_num = math.max(0, maxCount - gotCount)
							})
						end
					end
				end
			end

			-- 2. Fallback if still empty
			if #respCards == 0 then
				local list = {}
				for id, _ in pairs(Data._monsterInfo or {}) do table.insert(list, id) end
				for id, _ in pairs(Data._magicInfo or {}) do table.insert(list, id) end
				for id, _ in pairs(Data._trapInfo or {}) do table.insert(list, id) end
				table.sort(list)
				for i = 1, math.min(60, #list) do
					local cidFallback = list[i]
					table.insert(respCards, {
						info_id = cidFallback,
						get_num = 0,
						remain_num = 1
					})
				end
			end
			local respMsg = {
				type = SglMsgType_pb.PB_TYPE_CARDBOX_INFO,
				status = 0,
				Extensions = {
					[Card_pb.SglCardMsg.card_box_info_resp] = respCards,
					[Card_pb.SglCardMsg.up_pkg_card_id_resp] = {
						card_id = 0,
						timestamp = 0
					},
					[Card_pb.SglCardMsg.remain_pkg_ur_resp] = 100,
					[Card_pb.SglCardMsg.rare_pkg_resource_resp] = {}
				},
				HasExtension = function(self, ext)
					return self.Extensions[ext] ~= nil
				end
			}
			pcall(function()
				if curScene.onMsg then
					curScene:onMsg(respMsg)
				elseif ClientData.onMsg then
					ClientData.onMsg(respMsg)
				end
			end)
		end
		return true
	end

	ClientData.sendCardBoxReset = function(boxId, isFree)
		ClientView.getActiveIndicator():hide()
		local s = lc._runningScene or ClientView._scene or lc.Director:getRunningScene()
		local curScene = s and (s._layer or s)
		if curScene and curScene._sceneId == ClientData.SceneId.tavern then
			ClientData.sendCardBoxInfo(boxId)
		end
		return true
	end

	-- Card lottery (Tavern / draw)
	ClientData.sendCardLottery = function(count, isTen, resType)
		return doBuyPackage and doBuyPackage(count, isTen, resType, nil)
	end

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
		
	-- Offline PVE World / Chapter attack handler
	local _origSendWorldAttack = ClientData.sendWorldAttack
	ClientData.sendWorldAttack = function(troopIndex, levelId)
		local levelInfo = Data._levelInfo and Data._levelInfo[levelId]
		local opponentTroopId = levelInfo and levelInfo._opponentTroopID or 1
		local troopInfo = Data._troopInfo and Data._troopInfo[opponentTroopId]

		local resp = SglMsg_pb.SglRespMsg()
		resp.type = SglMsgType_pb.PB_TYPE_WORLD_ATTACK
		resp.status = SglMsg_pb.PB_STATUS_OK
		local bs = resp.Extensions[World_pb.SglWorldMsg.world_attack_resp]
		bs.type = Battle_pb.PB_BATTLE_NPC
		bs.timestamp = math.floor(ClientData.getCurrentTime() * 1000)
		bs.level_id = levelId
		bs.is_attacker = true
		bs.is_op_online = false
		pcall(function() table.insert(bs.random_seq, math.random(1, 65535)) end)

		-- Player troop
		local pTroop = P._playerCard and P._playerCard._troops and P._playerCard._troops[troopIndex or P._curTroopIndex or 1]
		bs.player_troop.info.name = P._name or "Player"
		bs.player_troop.info.level = P._level or 1
		bs.player_troop.info.avatar = P._avatar or 301
		bs.player_troop.info.card_back = P._cardBackId or Data.PropsId.card_back
		bs.player_troop.hp = 8000
		local myCrown = nil
		if P and P._crown and P._crown._infoId and P._crown._infoId ~= 0 then
			myCrown = P._crown
		elseif ClientData and ClientData._account then
			local gc = tonumber(ClientData._account.gold_cup) or 0
			local sc = tonumber(ClientData._account.silver_cup) or 0
			local bc = tonumber(ClientData._account.bronze_cup) or 0
			if gc > 0 then myCrown = { _infoId = 7204, _num = gc }
			elseif sc > 0 then myCrown = { _infoId = 7205, _num = sc }
			elseif bc > 0 then myCrown = { _infoId = 7206, _num = bc }
			end
		end
		if myCrown then
			pcall(function()
				bs.player_troop.info.crown.info_id = myCrown._infoId
				bs.player_troop.info.crown.num = myCrown._num
			end)
		end
		local cardsList = (pTroop and pTroop._cards) or pTroop
		if cardsList then
			for _, c in ipairs(cardsList) do
				local cid = type(c) == "table" and (c._infoId or c.info_id) or c
				local num = type(c) == "table" and (c._num or c.num or 1) or 1
				local lvl = type(c) == "table" and (c._level or c.level or 1) or 1
				if cid and tonumber(cid) then
					cid = tonumber(cid)
					num = math.max(1, tonumber(num) or 1)
					lvl = tonumber(lvl) or 1
					table.insert(bs.player_troop.cards, { info_id = cid, num = num })
					pcall(function()
						local lItem = bs.player_troop.levels:add()
						lItem.info_id = cid
						lItem.level = lvl
					end)
				end
			end
		end

		-- Opponent troop
		local oppoName = levelInfo and (Str and Str(levelInfo._nameSid) or levelInfo._name) or "Opponent"
		bs.opponent_troop.info.name = oppoName
		bs.opponent_troop.info.level = (levelInfo and levelInfo._level) or 1
		bs.opponent_troop.info.avatar = (levelInfo and levelInfo._avatar) or 201
		bs.opponent_troop.info.is_npc = true
		bs.opponent_troop.info.card_back = Data.PropsId.card_back
		bs.opponent_troop.hp = 8000
		if troopInfo and troopInfo._infoId then
			for i = 1, #troopInfo._infoId do
				local cid = troopInfo._infoId[i]
				local num = (troopInfo._num and troopInfo._num[i]) or 1
				local lvl = (troopInfo._level and troopInfo._level[i]) or 1
				if cid and tonumber(cid) then
					table.insert(bs.opponent_troop.cards, { info_id = tonumber(cid), num = math.max(1, tonumber(num) or 1) })
					pcall(function()
						local lItem = bs.opponent_troop.levels:add()
						lItem.info_id = tonumber(cid)
						lItem.level = tonumber(lvl) or 1
					end)
				end
			end
		end

		rawset(resp, "_offlineKind", "chapter")
		local id
		id = lc.Scheduler:scheduleScriptFunc(function()
			lc.Scheduler:unscheduleScriptEntry(id)
			ClientData.onMsg(resp)
		end, 0.05, false)
	end

	local _origSendTeachingFinish = ClientData.sendTeachingFinish
	ClientData.sendTeachingFinish = function(bonusId)
		if P and P._playerBonus and P._playerBonus._bonusTeach and P._playerBonus._bonusTeach[bonusId] then
			local b = P._playerBonus._bonusTeach[bonusId]
			b._value = (b._info and b._info._val) or 1
		end
		local resp = SglMsg_pb.SglRespMsg()
		resp.type = SglMsgType_pb.PB_TYPE_BONUS_TEACHING_FINISH
		resp.status = SglMsg_pb.PB_STATUS_OK
		pcall(ClientData.onMsg, resp)
	end

	local _origSaveTroops = ClientData.saveTroops
	ClientData.saveTroops = function(forceSave, ...)
		if ClientData._cloneTroops and P and P._playerCard then
			for slot, troopData in pairs(ClientData._cloneTroops) do
				if type(troopData) == "table" and (troopData._isDirty or forceSave) then
					local normalized = normalizeTroopData(troopData)
					P._playerCard:saveTroop(normalized, slot)
				end
			end
		end
		local ret = _origSaveTroops and _origSaveTroops(forceSave, ...)
		return ret
	end

	local _origSendTroops = ClientData.sendTroops
	ClientData.sendTroops = function(...)
		if ClientData._cloneTroops and P and P._playerCard then
			for slot, troopData in pairs(ClientData._cloneTroops) do
				if type(troopData) == "table" and troopData._isDirty then
					P._playerCard:saveTroop(troopData, slot)
				end
			end
		end
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
			local line = lines[i]
			if line and string.sub(line, -1) == "\r" then
				line = string.sub(line, 1, #line - 1)
			end
			local value = line

			if value and string.sub(value, 1, 1) == "\"" then
				local fields = string.splitByChar(line, ",")
				value = fields[1]
				local at = 1

				while string.sub(value, -1) ~= "\"" and at < #fields do
					at = at + 1
					value = value .. "," .. fields[at]
				end

				if string.sub(value, -1) == "\"" then
					value = string.sub(value, 2, #value - 1)
				end
			end

			if value and string.find(value, "\\n") then
				value = string.gsub(value, "\\n", "\n")
			end

			out[#out + 1] = value
		end

		ClientData._language = out
		_G._cachedLanguage = out
	end

	local function addLanguage(text)
		local ok, err = pcall(ClientData.addLanguage, text)

		if not ok then
			print("[h5] addLanguage failed: " .. tostring(err))
		end
	end

	jsres:setCallbacks(announce, addLanguage)

	local function filterCurrencyText(str)
		if type(str) ~= "string" or str == "" then return str end
		if string.find(str, "Gold") or string.find(str, "gold") then
			str = string.gsub(str, "Gold", "Linh Thạch")
			str = string.gsub(str, "gold", "Linh Thạch")
		end
		if string.find(str, "Gem") or string.find(str, "gem") then
			str = string.gsub(str, "Gem", "Linh Thạch Cao Cấp")
			str = string.gsub(str, "gem", "Linh Thạch Cao Cấp")
		end
		if string.find(str, "Kim Cương") or string.find(str, "kim cương") then
			str = string.gsub(str, "Kim Cương", "Linh Thạch Cao Cấp")
			str = string.gsub(str, "kim cương", "Linh Thạch Cao Cấp")
		end
		return str
	end

	local CARD_NAME_OVERRIDES = {
		-- Tuong Chan (12008, 12009, 12010)
		[50082] = "Tường Chắn Quái",
		[50083] = "Bị bài quái đối thủ ảnh hưởng sẽ bỏ qua hiệu quả.",
		[50084] = "Tường Chắn Phép",
		[50085] = "Bị bài phép đối thủ ảnh hưởng sẽ bỏ qua hiệu quả.",
		[50086] = "Tường Chắn Bẫy",
		[50087] = "Bị bài bẫy đối thủ ảnh hưởng sẽ bỏ qua hiệu quả.",
		-- Battle status popups (CardInfoPanel)
		[1777] = "Bị bài quái đối thủ ảnh hưởng sẽ bỏ qua hiệu quả.",
		[1778] = "Bị bài phép đối thủ ảnh hưởng sẽ bỏ qua hiệu quả.",
		[1779] = "Bị bài bẫy đối thủ ảnh hưởng sẽ bỏ qua hiệu quả.",
		-- shieldEx (12002, 12003, 12004)
		[50070] = "Tường Chắn Quái",
		[50071] = "Khi bị ảnh hưởng bởi bài quái đối thủ; hiệu ứng sẽ bị bỏ qua.",
		[50072] = "Tường Chắn Phép",
		[50073] = "Khi bị ảnh hưởng bởi bài phép đối thủ; hiệu ứng sẽ bị bỏ qua.",
		[50074] = "Tường Chắn Bẫy",
		[50075] = "Khi bị ảnh hưởng bởi bài bẫy đối thủ; hiệu ứng sẽ bị bỏ qua.",
		[54724] = "Cửu Thiên Huyền Sát",
		[54727] = "Cửu Thiên Huyền Sát",
		[43192] = "Cửu Thiên Huyền Sát",
		[36383] = "mắt đỏ-Rồng đen toàn thép",
		[36386] = "mắt đỏ-Rồng đen toàn thép",
		[51457] = "Chủ động: Xóa 2 Chỉ Thị XYZ đang có; tất cả quái có từ khóa “Ánh Sáng” và “Ngân Hà” trên sân phe ta nhận được “Khiên Chắn Quái/Phép/Bẫy”. Kỹ năng chỉ kích hoạt 1 lần.",
		[52113] = "Khi có mặt; khiến tất cả quái có từ khóa “Amazon” trên sân phe ta ngoài bản thân bài này nhận được “Khiên Chắn Quái/Phép/Bẫy”/“Khiên Chắn Hiệu Quả”.",
		[46091] = "Khi có mặt; quái có từ khóa “Amazon” phe ta nhận thêm kỹ năng “Tấn Công Tăng Cường”, đồng thời nhận thêm 100 công cho mỗi quái “Amazon” trên sân và trong mộ phe ta.",
		-- Wicked Gods (Ta Than - Hoa Than 12142, Ac Than - Chua Nhap The 10407, Skill 3231)
		[39265] = "Bài này không thể Triệu Hồi Đặc Biệt. Cần có 3 Quái thú hiến tế mới có thể Triệu Hồi Thường.",
		-- Amazoness Balance Update (Kiếm Sĩ Amazoness 10076, Hổ Sư Tử Amazon 40052, Vua Hổ Sư Tử Amazon 40659, Bão Lốc Amazon 30171)
		-- 1. Kiếm Sĩ Amazoness (10076, Skill 2006)
		[22356] = "Kiếm Sĩ Amazoness",
		[22357] = "Sát thương chiến đấu mà bản thân phải chịu từ trận chiến có lá bài này sẽ do đối thủ gánh chịu (nhân đôi x2 sát thương phản đòn nếu LP đối thủ > 10,000).",
		[22358] = "|Mô tả|\nKiếm Sĩ Amazoness sở hữu kỹ năng phản toàn bộ sát thương chiến đấu sang cho đối thủ. Đặc biệt, khi LP của đối phương vượt quá 10,000, lượng sát thương phản lại sẽ được nhân đôi (x2), khắc chế cực mạnh các bộ bài hồi máu hoặc pháo đài LP cao.",
		[36818] = "Phản Sát Thương",
		[36819] = "Sát thương chiến đấu mà bản thân phải chịu từ trận chiến có lá bài này sẽ do đối thủ gánh chịu. Nếu LP của đối thủ lớn hơn 10,000, sát thương phản lại sẽ được nhân đôi (x2).",

		-- 2. Hổ Sư Tử Amazon (40052) & Vua Hổ Sư Tử Amazon (40659)
		[33723] = "Hổ Sư Tử Amazon",
		[33724] = "<Hổ Rừng Amazon> + Quái có từ khóa “Amazon”.\nKhi bị đối thủ tiêu diệt trong chiến đấu, đối thủ không thể tiếp tục tấn công trong lượt đó.",
		[33725] = "|Mô tả|\nHổ Sư Tử Amazon sở hữu sức mạnh chiến đấu uy mãnh và khả năng đoạn hậu hoàn hảo. Khi bị tiêu diệt trong chiến đấu, toàn bộ các đòn tấn công tiếp theo của đối phương trong lượt đó sẽ bị ngắt đứng hoàn toàn.",
		[36147] = "Vua Hổ Sư Tử Amazon",
		[36148] = "Quái có từ khóa “Amazon” x2.\nKhi bị đối thủ tiêu diệt trong chiến đấu, đối thủ không thể tiếp tục tấn công trong lượt đó.",
		[36149] = "|Mô tả|\nVua Hổ Sư Tử Amazon - chúa sơn lâm tối cao của bộ tộc Amazoness. Chốt chặn phòng ngự tuyệt đối: Khi bị đối thủ tiêu diệt trong chiến đấu, đối phương lập tức bị khóa, không thể tiếp tục tấn công trong lượt đó.",

		-- 3. Bão Lốc Amazon (30171, Skills 8007, 5116, 5117)
		[54436] = "Bão Lốc Amazon",
		[54437] = "Cạm bẫy vĩnh cửu Amazon: Chủ động (1 lượt 1 lần): Triệu Hồi Đặc Biệt 1 quái “Amazon” từ bài trên tay. Khi có lá này trên sân, tất cả quái thú mang từ khóa “Amazon” khi giao chiến sẽ triệt tiêu toàn bộ sát thương chiến đấu về 0 (người chơi không bị trừ LP), đồng thời tối ưu cơ chế phản sát thương khi công/thủ. Khi bị phá hủy từ trên sân, Triệu Hồi Đặc Biệt 1 quái “Amazon” từ mộ.",
		[54438] = "|Mô tả|\nBão Lốc Amazon: Cạm bẫy vĩnh cửu cốt lõi của bộ tộc Amazoness. Triệu hồi quái thú từ tay, bảo hộ toàn diện quái thú Amazon khi giao chiến, triệt tiêu toàn bộ sát thương chiến đấu về 0 và tối ưu phản sát thương khi công/thủ.",
		[47768] = "Bảo Hộ Chiến Đấu",
		[47769] = "Khi có lá này trên sân, tất cả quái thú mang từ khóa “Amazon” khi giao chiến sẽ triệt tiêu toàn bộ sát thương chiến đấu về 0 (người chơi không bị trừ LP), đồng thời tối ưu cơ chế phản sát thương khi giao chiến với quái thú đối phương.",
		[42994] = "Bão Lốc Amazon - Triệu Hồi",
		[42995] = "Chủ động: Mỗi lượt 1 lần, Triệu Hồi Đặc Biệt 1 quái có từ khóa “Amazon” từ bài trên tay; quái nhận được “Bóng Ma Đột Kích”.",
		[42996] = "Hồi Sinh Amazon",
		[42997] = "Khi bị phá hủy và đưa vào mộ từ trên sân; Triệu Hồi Đặc Biệt 1 quái có từ khóa “Amazon” từ mộ phe ta.",
		[46379] = "Quái có từ khóa “Amazon” trên sân phe ta tăng 500 tấn công và nhận được “Tường Chắn Quái/Phép/Bẫy”.",
		[18733] = "Tất cả quái “Amazon” trên sân phe ta tăng 500 công và nhận “Tường Chắn Quái/Phép/Bẫy”. Kĩ năng chủ động: 1 lượt 1 lần, lấy 1 quái “Amazon” từ bộ bài lên tay.",
		[56678] = "Bộ Lạc-Chiêu Mộ",
		[56679] = "Kĩ năng chủ động: 1 lượt 1 lần, lấy 1 quái có từ khóa “Amazon” từ bộ bài lên tay.",
		[56680] = "Hổ Con-Tìm Lạc",
		[56681] = "Kĩ năng chủ động tay: 1 lượt 1 lần, đưa bản thân vào mộ, sau đó lấy 1 lá “Bộ lạc Amazon” từ bộ bài lên tay.",
		[25129] = "Kĩ năng chủ động tay: 1 lượt 1 lần, đưa bản thân vào mộ, sau đó lấy 1 lá “Bộ lạc Amazon” từ bộ bài lên tay.",
		[51805] = "Chủ động: Mỗi lượt tối đa 2 lần. Chọn và Triệu Hồi Đặc Biệt 1 quái có từ khóa “CS” từ mộ phe ta. Kỹ năng chỉ kích hoạt 1 lần.",
		[51817] = "Kỹ năng tay chủ động: Mỗi lượt tối đa 1 lần. Loại bỏ bản thân bài này; lấy một lá bài không cùng tên; có từ khóa “CS” từ bộ bài phe ta vào tay.",
		[44025] = "Mỗi lượt chỉ được dùng 1 lá. Hi sinh 2000 LP; Triệu Hồi Đặc Biệt 2 quái không cùng tên; có từ khóa “CS” từ bộ bài phe ta. Sau đó trong lượt này; khi Triệu Hồi Đặc Biệt quái từ ngoài bộ bài thêm; chỉ có thể Triệu Hồi Đặc Biệt quái có từ khóa “CS”.",
		[44023] = "Khi ở trong nghĩa địa; nó được kích hoạt khi đối thủ tấn công; ngoại trừ chính nó. Tất cả quái vật trên sân của đối thủ đều giảm sức tấn công đi 500 điểm (xuyên thủng “lá chắn bẫy”) và người chơi của bạn tăng thêm 800 điểm sinh mệnh. Nếu đòn tấn công của Quái Vật đối phương trên sân trở thành 0 do hiệu ứng này; tất cả Quái Vật của đối thủ chỉ không thể tấn công trong vòng này.",
		[47515] = "Khi bài này có mặt; quái phe ta có từ khóa “CS” lên sân sẽ tăng tấn công bằng tổng số loại quái có từ khóa “CS” đang có trong mộ/mộ bài loại bỏ phe ta x100.",
		[36968] = "Hộ Thể Mắt Đỏ",
		[36969] = "Khi lá bài này trên sân, tất cả quái có từ khóa “Mắt Đỏ” sẽ nhận “Tường Chắn Quái/Phép/Bẫy”.",
		[34292] = "Khi lá bài này trên sân, tất cả quái có từ khóa “Mắt Đỏ” sẽ nhận “Tường Chắn Quái/Phép/Bẫy”.",
		-- Keyword "Tru tiên"
		[2231] = "Tru tiên",
		-- Keyword "Tiên nghịch"
		[2232] = "Tiên nghịch",
		[34087] = "Chim Ánh Sao Nothung",
		-- Harpie 5 Sisters (40726, skills 14624, 14625, 14626)
		[56801] = "5 Chị Em Harpie",
		[56802] = "Quái thú Liên Kết [Link-3]: <3 Chị Em Harpie> + 2 quái thú mang từ khóa “Harpie”.",
		[56803] = "Quái thú Liên Kết [Link-3]: <3 Chị Em Harpie> + 2 quái thú mang từ khóa “Harpie”.",
		[56804] = "5 Chị Em Harpie",
		[56805] = "Harpie-Trừng Phạt Trục Xuất",
		[56806] = "Khi lá bài này ở Vùng Trục Xuất (Mộ Loại Bỏ): Mỗi lượt 1 lần, khi đối phương Triệu Hồi Thường hoặc Triệu Hồi Đặc Biệt quái thú, kích hoạt: Trục xuất quái thú đó khỏi trận đấu (xuyên Tường Chắn Quái, không xuyên Khiên Chắn Hào Quang), sau đó thêm ngẫu nhiên 1 lá bài mang từ khóa “Harpie” từ Bộ Bài lên tay.",
		[56807] = "Harpie-Tụ Hội Tỷ Muội",
		[56808] = "Kỹ năng chủ động: Mỗi lượt 1 lần, chọn tối đa 2 quái thú mang từ khóa “Harpie” từ Mộ phe ta, Triệu Hồi Đặc Biệt lên sân ở Thế Thủ (quái thú không thể đổi tư thế chiến đấu trong lượt này).",
		[56809] = "Harpie-Phong Dực Hộ Mệnh",
		[56810] = "Kỹ năng mộ chủ động: Mỗi lượt 1 lần, trục xuất bản thân lá bài này khỏi Mộ; tất cả quái thú Tộc Thú Có Cánh trên sân phe ta nhận được [Khiên Chắn Quái / Phép / Bẫy (Hào Quang)] trong 1 lượt.",
		-- Custom new cards (A Lương, Lệ Quỷ, Đọa Nhập Ma Đạo, Kỳ Baby, Vua Hổ)
		[56811] = "Cửu Thiên Huyền Sát-Tru Tiên",
		[56812] = "Kĩ năng chủ động mộ: 1 lượt 1 lần, khi trên sân phe ta có <Kỳ Baby>, loại bỏ bản thân khỏi mộ để thêm 1 lá <Cửu Thiên Huyền Sát> từ bộ bài lên tay.",
		[56813] = "A Lương",
		[56814] = "Không thể Triệu Hồi Đặc Biệt. Lá bài này trên sân không thể bị phá hủy bởi bất kỳ hiệu ứng nào. Khi lên sân, nhận [Khiên Chắn Quái]. 1 lượt 1 lần, khi đối phương kích hoạt bài Phép/Bẫy: Vô hiệu hóa và phá hủy lá bài đó. Tăng ATK/DEF bằng [Số Sao x 200]. Bắt đầu mỗi lượt, tăng 1 sao (tối đa 14 sao). [Thập Tam Cảnh]: Khi đạt 13 sao trở lên, đối phương không thể kích hoạt hiệu ứng bài trên sân. [Thập Tứ Cảnh]: Khi đạt 14 sao, đối phương không thể kích hoạt bất kỳ hiệu ứng bài nào.",
		[56815] = "A Lương-Cấm Đoán",
		[56816] = "Không thể Triệu Hồi Đặc Biệt.",
		[56817] = "A Lương-Bất Hoại",
		[56818] = "Lá bài này trên sân không thể bị phá hủy bởi bất kỳ hiệu ứng nào.",
		[56819] = "A Lương-Hộ Thể",
		[56820] = "Khi lên sân nhận [Khiên Chắn Quái].",
		[56821] = "A Lương-Trảm Pháp",
		[56822] = "1 lượt 1 lần, khi đối phương kích hoạt bài Phép/Bẫy: Vô hiệu hóa và phá hủy lá bài đó.",
		[56823] = "A Lương-Vô Thượng Kiếm Đạo",
		[56824] = "Tăng ATK/DEF bằng [Số Sao x 200]. Bắt đầu mỗi lượt, tăng 1 sao (tối đa 14 sao). [Thập Tam Cảnh]: Khi đạt 13 sao trở lên, đối phương không thể kích hoạt hiệu ứng bài trên sân. [Thập Tứ Cảnh]: Khi đạt 14 sao, đối phương không thể kích hoạt bất kỳ hiệu ứng bài nào.",
		[56825] = "Quỷ Lệ",
		[56826] = "Kháng Phật - Kháng Đạo - Kháng Ma: Khi lên sân, nhận [Tường Chắn Quái / Phép / Bẫy]. Đạo Pháp - Thái Cực Huyền Thanh (Kỹ năng chủ động): 1 lượt 1 lần, chọn 1 bài Phép mang từ khóa “Tru tiên” từ Bộ Bài thêm vào tay. Phật Pháp - Kim Cương Bất Hoại: 1 lượt 1 lần, bỏ qua 1 lần lá bài này bị phá hủy. Ma Pháp - Hấp Huyết Vô Tình: 1 lượt 1 lần, khi đối phương kích hoạt bài Phép/Bẫy: Hi sinh 1000 LP, vô hiệu hóa và phá hủy lá bài đó.",
		[56827] = "Quỷ Lệ-Tam Giới Chướng",
		[56828] = "Khi lên sân nhận [Tường Chắn Quái / Phép / Bẫy].",
		[56829] = "Quỷ Lệ-Tìm Kiếm Pháp Bảo",
		[56830] = "Kỹ năng chủ động: 1 lượt 1 lần, chọn 1 bài Phép mang từ khóa “Tru tiên” từ Bộ Bài thêm vào tay.",
		[56831] = "Quỷ Lệ-Kim Cương Bất Hoại",
		[56832] = "1 lượt 1 lần, bỏ qua 1 lần lá bài này bị phá hủy.",
		[56833] = "Quỷ Lệ-Hấp Huyết Vô Tình",
		[56834] = "1 lượt 1 lần, khi đối phương kích hoạt bài Phép/Bẫy: Hi sinh 1000 LP, vô hiệu hóa và phá hủy lá bài đó.",
		[56835] = "Đọa Nhập Ma Đạo",
		[56836] = "Bạn chỉ có thể kích hoạt 1 “Đọa Nhập Ma Đạo” mỗi lượt. Hi sinh 1000 LP và phá hủy 1 quái thú trên sân bạn đang điều khiển: Triệu Hồi Đặc Biệt 1 <Quỷ Lệ> từ Mộ, Bộ Bài hoặc trên tay lên sân. Kỹ năng mộ chủ động: Chọn và phá hủy 1 quái thú Thuộc Tính Ám trên sân phe ta, hồi phục LP cho bản thân bằng ATK của quái thú vừa bị tiêu diệt.",
		[56837] = "Đọa Nhập Ma Đạo",
		[56838] = "Hi sinh 1000 LP và phá hủy 1 quái thú trên sân bạn đang điều khiển: Triệu Hồi Đặc Biệt 1 <Quỷ Lệ> từ Mộ, Bộ Bài hoặc trên tay lên sân.",
		[56839] = "Đọa Nhập Ma Đạo-Hấp Thu",
		[56840] = "Kỹ năng mộ chủ động: Chọn và phá hủy 1 quái thú Thuộc Tính Ám trên sân phe ta, hồi phục LP cho bản thân bằng ATK của quái thú vừa bị tiêu diệt.",
		[56841] = "Kỳ Baby",
		[56842] = "Thiên Gia Thần Kiếm - Hàn Khí: Chừng nào lá bài này còn tồn tại trên sân, mỗi khi đối phương Triệu Hồi Thường hoặc Triệu Hồi Đặc Biệt quái thú, quái thú đó lập tức bị chuyển sang Thế Thủ và bị khóa trong 1 lượt. Chấp Niệm: Khi có <Quỷ Lệ> trên sân phe ta, lá bài này có thể Triệu Hồi Thường mà không cần hiến tế.",
		[56843] = "Kỳ Baby-Khống Chế Trận Địa",
		[56844] = "Chừng nào lá bài này còn tồn tại trên sân, mỗi khi đối phương Triệu Hồi Thường hoặc Triệu Hồi Đặc Biệt quái thú, quái thú đó lập tức bị chuyển sang Thế Thủ và bị khóa trong 1 lượt.",
		[56845] = "Kỳ Baby-Chấp Niệm",
		[56846] = "Khi có <Quỷ Lệ> trên sân phe ta, lá bài này có thể Triệu Hồi Thường mà không cần hiến tế.",
		[56847] = "Khóa Đột Kích",
		[56848] = "Khi bị đối thủ tiêu diệt trong chiến đấu, đối thủ không thể tiếp tục tấn công trong lượt đó.",
		-- 4 La bai moi Tru Tien (Dong vo dong chong, Vao sinh cong tu, Than khien, Bat hoang huyen hoa long)
		[56849] = "Đồng vợ đồng chồng",
		[56850] = "Khi trên sân phe ta có <Quỷ Lệ> và <Kỳ Baby> chưa hành động có thể kích hoạt, phá hủy tất cả quái thú trên sân đối phương (Xuyên qua tường chắn quái thú).",
		[56851] = "Đồng Vợ Đồng Chồng-Phá Diệt",
		[56852] = "Khi trên sân phe ta có <Quỷ Lệ> và <Kỳ Baby> chưa hành động có thể kích hoạt, phá hủy tất cả quái thú trên sân đối phương (Xuyên qua tường chắn quái thú).",
		[56853] = "Đồng sinh cộng tử",
		[56854] = "Khi trên sân phe ta có <Quỷ Lệ> có thể kích hoạt, chọn: Triệu hồi đặc biệt <Kỳ Baby> từ tay/bộ bài/trong mộ lên sân, sau đó chọn 1 bài phép có từ khóa \"Tru tiên\" thêm vào tay.",
		[56855] = "Đồng Sinh Cộng Tử-Triệu Hồi",
		[56856] = "Khi trên sân phe ta có <Quỷ Lệ> có thể kích hoạt, chọn: Triệu hồi đặc biệt <Kỳ Baby> từ tay/bộ bài/trong mộ lên sân, sau đó chọn 1 bài phép có từ khóa \"Tru tiên\" thêm vào tay.",
		[56857] = "Thần khiển",
		[56858] = "Khi trên tay phe ta có <Bát hoang hỏa long>, ngoại trừ <Bát hoang hỏa long> khi tổng số sao quái trên sân / trên tay phe ta có >= 10 (hoặc khi trên sân phe ta có <Thú thần>, không cần hiến tế), có thể kích hoạt: Triệu hồi nghi thức <Bát hoang hỏa long> từ tay.",
		[56859] = "Thần Khiển-Nghi Thức Triệu Hồi",
		[56860] = "Khi trên tay phe ta có <Bát hoang hỏa long>, ngoại trừ <Bát hoang hỏa long> khi tổng số sao quái trên sân / trên tay phe ta có >= 10 (hoặc khi trên sân phe ta có <Thú thần>, không cần hiến tế), có thể kích hoạt: Triệu hồi nghi thức <Bát hoang hỏa long> từ tay.",
		[56861] = "Bát hoang hỏa long",
		[56862] = "Không thể triệu hồi thường, lần đầu triệu hồi đặc biệt cần hiệu ứng của <Thần khiển> để triệu hồi đặc biệt.\nKĩ năng chỉ kích hoạt 1 lần vào lần lá bài này được triệu hồi nghi thức, gây thiệt hại cho đối phương bằng 1 nửa LP hiện tại của họ.\nKhi lên sân, phá hủy tất cả bài phép môi trường trên sân 2 bên.\nKhi lá bài này trên sân, 2 bên không thể sử dụng bài phép môi trường.\nKhi lên sân nhận Khiên chắn quái, phép, bẫy.\nKhi lá bài này trên sân, hiệu quả tăng LP của đối thủ trở thành nhận sát thương.\nMỗi khi đối phương triệu hồi/triệu hồi đặc biệt quái thú, đối phương nhận 200 thiệt hại (tăng lên thành 400 nếu đối phương có trên 8000 LP).\nKhi lá bài này bị phá hủy, phá hủy tất cả bài trên sân phe ta, phe ta chịu thiệt hại bằng số bài bị phá hủy x 500.",
		[56863] = "Bát Hoang-Tường Chắn Tam Giới",
		[56864] = "Khi lên sân nhận Khiên chắn quái, phép, bẫy.",
		[56865] = "Bát Hoang-Huyền Hỏa Phệ Hồn",
		[56866] = "Kĩ năng chỉ kích hoạt 1 lần vào lần lá bài này được triệu hồi nghi thức, gây thiệt hại cho đối phương bằng 1 nửa LP hiện tại của họ.",
		[56867] = "Bát Hoang-Tuyệt Môi Diệt Cảnh",
		[56868] = "Khi lên sân, phá hủy tất cả bài phép môi trường trên sân 2 bên. Khi lá bài này trên sân, 2 bên không thể sử dụng bài phép môi trường.",
		[56869] = "Bát Hoang-Chích Nhiệt Phản Phệ",
		[56870] = "Khi lá bài này trên sân, hiệu quả tăng LP của đối thủ trở thành nhận sát thương. Mỗi khi đối phương triệu hồi/triệu hồi đặc biệt quái thú, đối phương nhận 200 thiệt hại (tăng lên thành 400 nếu đối phương có trên 8000 LP).",
		[56871] = "Bát Hoang-Long Hồn Câu Diệt",
		[56872] = "Khi lá bài này bị phá hủy, phá hủy tất cả bài trên sân phe ta, phe ta chịu thiệt hại bằng số bài bị phá hủy x 500.",
		[56873] = "Bát Hoang-Quy Tắc Nghi Lễ",
		[56874] = "Không thể triệu hồi thường, lần đầu triệu hồi đặc biệt cần hiệu ứng của <Thần khiển> để triệu hồi đặc biệt.",
		-- Ky baby skill (when Le Quy on field)
		[56875] = "Kỳ Baby-Hộ Thể Đạo Lữ",
		[56876] = "Khi có <Quỷ Lệ> trên sân, nhận tường chắn quái, phép và bẫy.",
		-- Huyen hoa giam (30592) & skill (14653)
		[56877] = "Huyền Hỏa Giám",
		[56878] = "Bẫy phản kích: [Khi úp trên sân]: Phe ta chịu thiệt hại LP -> đưa lá bài này vào Mộ, ngăn chặn thiệt hại và bảo vệ LP lượt này. [Khi trên tay]: Sân ta trống và đối thủ gây thiệt hại -> đưa lá bài này vào Mộ, ngăn chặn thiệt hại và bảo vệ LP lượt này.",
		[56879] = "Huyền Hỏa Giám",
		[56880] = "Huyền Hỏa Giám-Trận Pháp Hộ Thể",
		[56881] = "Khi úp trên sân: Phe ta chịu thiệt hại LP sẽ kích hoạt, đưa lá bài này vào Mộ; ngăn chặn thiệt hại đó và trong lượt này phe ta không chịu thêm bất kì thiệt hại nào.",
		[56920] = "Huyền Hỏa Giám-Hộ Mệnh",
		[56921] = "Khi trên tay và trên sân phe ta không có bài: Khi đối phương gây thiệt hại cho phe ta, đưa lá bài này vào Mộ; ngăn chặn thiệt hại đó và trong lượt này phe ta không chịu thêm bất kì thiệt hại nào.",
		-- Tru tien kiem (21139) & skills (14652, 14668, 14669, 14670, 14671)
		[56882] = "Tru Tiên Kiếm",
		[56883] = "Phép trang bị: Trang bị cho quái Chiến Binh/Phù Thủy. Quái trang bị tăng 5000 Công, nhận [Quá Tải], [Liên Trảm], và nhận Tường Chắn Quái/Phép/Bẫy. Sau mỗi lần tấn công: Quái trang bị giảm 1000 Công và Điểm Gốc phe ta chịu 1000 thiệt hại. Hết lượt: quái trang bị tự loại bỏ.",
		[56884] = "Tru Tiên Kiếm",
		[56885] = "Tru Tiên Kiếm-Trảm Tiên Diệt Ma",
		[56886] = "Phép trang bị: Trang bị dành cho quái Chiến Binh hoặc Phù Thủy trên sân phe ta. Quái trang bị tăng 5000 Điểm Tấn Công.",
		[56922] = "Tru Tiên Kiếm-Quá Tải",
		[56923] = "Quái trang bị nhận được kỹ năng [Quá Tải]: Khi tấn công quái thủ có DEF thấp hơn ATK của nó, gây sát thương chênh lệch cho đối thủ. Hết lượt: tự loại bỏ.",
		[56924] = "Tru Tiên Kiếm-Liên Trảm",
		[56925] = "Quái trang bị nhận được kỹ năng [Liên Trảm]: Có thể tấn công mỗi quái trên sân đối thủ 1 lần; không thể tấn công trực tiếp đối thủ.",
		[56926] = "Tru Tiên Kiếm-Kiếm Khí Hộ Thể",
		[56927] = "Quái trang bị nhận được Tường Chắn Quái Thú, Ma Pháp và Cạm Bẫy liên tục trong thời gian trang bị.",
		[56928] = "Tru Tiên Kiếm-Phệ Hồn Phản Phệ",
		[56929] = "Sau mỗi lần quái trang bị tấn công: Giảm 1000 Điểm Tấn Công và Điểm Gốc phe ta chịu 1000 thiệt hại.",
		[39222] = "Quá Tải",
		[39223] = "Khi quái này tấn công quái thủ có DEF thấp hơn ATK của nó, gây sát thương chênh lệch cho đối thủ. Hết lượt: tự loại bỏ.",
		[36638] = "Liên Trảm",
		[36639] = "Có thể tấn công mỗi quái trên sân đối thủ 1 lần; không thể tấn công trực tiếp đối thủ.",
		-- Modified cards
		[38702] = "Chuẩn Bị Liên Trảm",
		[38703] = "Chủ động: Bản thân chưa hành động có thể dùng. Chỉ lượt này; nhận được “Liên Trảm”; sau khi kích hoạt, các quái vật khác ở phe bạn không thể tấn công.",
		[36400] = "Quái Tộc Rồng 8 Sao x3.",
		[53262] = "Mắt Xanh-Tia Sáng",
		[53263] = "Kỹ năng chủ động bộ bài Extra: Mỗi lượt chỉ 1 lần. Hi sinh bản thân và 1 <Rồng Trắng Mắt Xanh> từ bộ bài phe ta; chọn 1 lá bài trên sân đối thủ đưa vào mộ.",
		[49312] = "Mắt Xanh-Tân Sinh",
		[49313] = "Chủ động: Bản thân bài này chưa tấn công sẽ có thể dùng. Hi sinh bản thân; chọn và Triệu Hồi Đặc Biệt 1 quái có từ khóa “Mắt Xanh” từ bộ bài thêm phe ta; sau khi kích hoạt, phe ta chỉ có thể triệu hồi/triệu hồi đặc biệt quái có từ khóa “Mắt Xanh”.",
		[53162] = "Ngân Hà-Chiến Ý",
		[53163] = "Mỗi lượt tối đa 2 lần. Khi bài này nằm trên tay; khi đối thủ Triệu Hồi Đặc Biệt quái sẽ kích hoạt. Hi sinh bản thân; vô hiệu hóa và phá hủy quái đối thủ (xuyên thấu “Tường Chắn Quái”); nếu trên sân phe ta có quái có từ khóa “Ngân Hà”, “Ánh Sáng” hoặc “Sóng Ánh Sáng”, ngẫu nhiên lấy 1 <Rồng Chiến Ngân Hà> hoặc 1 quái có từ khóa “Ngân Hà”·“Ánh Sáng”·“Sóng Ánh Sáng” từ bộ bài phe ta vào tay.",
		[56842] = "Khi có mặt trên sân, quái thú đối phương được Triệu Hồi hoặc Triệu Hồi Đặc Biệt sẽ bị khóa trong thế phòng thủ 1 lượt (không thể đổi tư thế trong lượt đó). Nếu trên sân phe ta có <Quỷ Lệ>, lá bài này có thể Triệu Hồi Thường mà không cần quái tế, đồng thời nhận tường chắn quái/phép/bẫy.",
		[56887] = "Đạo Huyền",
		[56888] = "Không thể Triệu Hồi Thường. Có thể Triệu Hồi Đặc Biệt từ trên tay bằng cách hiến tế 2 quái thú [Phù Thủy] trên sân. Khi lên sân: lấy 1 [Tru Tiên Kiếm] từ Bộ bài lên tay. [Kích hoạt trên sân - 1 lần/lượt]: Trục xuất 1 Ma pháp/Cạm bẫy trong Mộ -> phá hủy 1 lá bài trên sân đối phương (xuyên tường). [Kích hoạt trên sân - 1 lần/lượt, khi trang bị Tru Tiên Kiếm]: Tiêu diệt toàn bộ quái thú đối phương (xuyên tường), đưa bản thân vào Mộ -> Triệu Hồi Đặc Biệt [Đạo Huyền Tâm Ma] từ Bộ bài/Tay/Mộ.",
		[56889] = "Đạo Huyền",
		[56890] = "Đạo Huyền-Chân Nhân Quy Tắc",
		[56891] = "Không thể Triệu Hồi Thường. Hiến tế 2 [Phù Thủy] trên sân để Triệu Hồi Đặc Biệt từ trên tay.",
		[56892] = "Đạo Huyền-Chấp Chưởng Tru Tiên",
		[56893] = "Khi xuất hiện trên sân, lấy 1 [Tru Tiên Kiếm] từ Bộ bài lên tay.",
		[56894] = "Đạo Huyền-Thanh Vân Kiếm Khí",
		[56895] = "1 lần/lượt: Trục xuất 1 Ma pháp/Cạm bẫy trong Mộ để phá hủy 1 lá trên sân đối thủ (xuyên tường quái thú).",
		[56896] = "Đạo Huyền-Tru Tiên Kiếm Trận",
		[56897] = "1 lần/lượt, khi trang bị Tru Tiên Kiếm: Phá hủy toàn bộ quái thú đối thủ (xuyên tường), đưa bản thân vào Mộ để Triệu Hồi Đặc Biệt [Đạo Huyền Tâm Ma] từ Bộ bài, Tay hoặc Mộ.",
		[56898] = "Đạo Huyền Tâm Ma",
		[56899] = "Không thể Triệu Hồi Thường hoặc Triệu Hồi Đặc Biệt trừ hiệu ứng của [Đạo Huyền]. Khi lên sân: Tiêu diệt toàn bộ quái thú khác trên sân ta, đồng thời nhận tường chắn Quái thú. Tối đa 3 lần 1 lượt: Khi đối thủ kích hoạt Ma pháp/Cạm bẫy -> Vô hiệu hóa và phá hủy lá đó, bản thân nhận 500 Công, phe ta nhận 500 sát thương. Bản thân không thể bị phá hủy bởi chiến đấu. Cuối mỗi lượt: Điểm gốc của ta nhận 1000 sát thương; nếu Điểm gốc <= 1000, trục xuất lá này.",
		[56900] = "Đạo Huyền Tâm Ma",
		[56901] = "Tâm Ma-Nhập Ma Tẫn Diệt",
		[56902] = "Khi lên sân: Phá hủy toàn bộ quái thú khác trên sân ta, nhận khiên chắn Quái thú.",
		[56903] = "Tâm Ma-Ma Huyết Thao Thiên",
		[56904] = "Tối đa 3 lần 1 lượt: Khi đối thủ kích hoạt Ma pháp/Cạm bẫy: Vô hiệu và phá hủy lá đó, bản thân nhận 500 Công, phe ta nhận 500 thiệt hại.",
		[56905] = "Tâm Ma-Bất Diệt Ma Thân",
		[56906] = "Bản thân không thể bị tiêu diệt bởi chiến đấu.",
		[56907] = "Tâm Ma-Phệ Hồn Phản Phệ",
		[56908] = "Cuối mỗi lượt, trừ 1000 Điểm gốc của ta. Nếu Điểm gốc <= 1000, trục xuất lá này.",
		[56909] = "Bích Dao",
		[56910] = "[Kích hoạt trên tay - 1 lần/lượt]: Bỏ 1 lá bài trên tay vào Mộ -> Triệu Hồi Đặc Biệt lá này lên sân. [Kích hoạt trên sân - 1 lần/lượt]: Lấy 1 [Đọa Nhập Ma Đạo] từ Bộ bài lên tay. [Hiệu ứng trên tay]: Khi có [Quỷ Lệ] trên sân ta và đối thủ kích hoạt Ma pháp/Cạm bẫy -> đưa lá này từ tay vào Mộ để vô hiệu hóa và phá hủy lá đó. [Kích hoạt trong Mộ - 1 lần/lượt]: Khi có [Quỷ Lệ] trên sân -> trục xuất lá này khỏi Mộ, tất cả [Quỷ Lệ] trên sân tăng 1000 Công.",
		[56911] = "Bích Dao",
		[56912] = "Bích Dao-Si Tình Tương Phùng",
		[56913] = "1 lần/lượt trên tay: Bỏ 1 lá bài trên tay vào Mộ để Triệu Hồi Đặc Biệt lá này lên sân.",
		[56914] = "Bích Dao-Dẫn Đạo Nhập Ma",
		[56915] = "1 lần/lượt trên sân: Lấy 1 lá [Đọa Nhập Ma Đạo] từ Bộ bài lên tay.",
		[56916] = "Bích Dao-Si Tình Chú",
		[56917] = "Trên tay khi có [Quỷ Lệ] trên sân: Đưa vào Mộ để vô hiệu hóa Ma pháp/Cạm bẫy đối phương.",
		[56918] = "Bích Dao-Hồn Về Thương Tâm",
		[56919] = "1 lần/lượt trong Mộ khi có [Quỷ Lệ] trên sân: Trục xuất bản thân để tăng 1000 Công cho tất cả [Quỷ Lệ].",
		-- Thu than (12320) & skills (14676, 14672, 14673, 14674, 14675)
		[56930] = "Thú thần",
		[56931] = "Thú thần",
		[56932] = "Lá bài này không thể triệu hồi đặc biệt, chỉ có thể triệu hồi thường bằng cách hiến tế 3 quái thú.\nKĩ năng chủ động 1: 1 lượt 1 lần, chọn: lấy 1 quái thú nghi lễ có từ khóa “Tru tiên” từ bộ bài lên tay, sau đó lấy thêm 1 lá <Thần khiển> từ mộ bài/bộ bài lên tay.\nKĩ năng chủ động 2 (kĩ năng này và kĩ năng chủ động 1 chỉ có thể dùng 1 loại): Trong lượt này nhận atk bằng số LP của đối thủ hiện có.\nNhận khiên quái, phép, bẫy.\nKhi trên sân phe ta còn quái khác, lá bài này không thể bị chọn làm mục tiêu.",
		[56933] = "Thú Thần-Hiến Tế Thần Thú",
		[56934] = "Lá bài này không thể triệu hồi đặc biệt, chỉ có thể triệu hồi thường bằng cách hiến tế 3 quái thú.",
		[56935] = "Thú Thần-Tru Tiên Nghi Lễ",
		[56936] = "1 lượt 1 lần, chọn: lấy 1 quái thú nghi lễ có từ khóa “Tru tiên” từ bộ bài lên tay, sau đó lấy thêm 1 lá <Thần khiển> từ mộ bài/bộ bài lên tay.",
		[56937] = "Thú Thần-Thần Lực Bất Diệt",
		[56938] = "1 lượt 1 lần (dùng chung lượt với kỹ năng chủ động 1): Trong lượt này nhận ATK bằng số LP của đối thủ hiện có.",
		[56939] = "Thú Thần-Tam Giới Tường Chắn",
		[56940] = "Khi có mặt trên sân: Nhận tường chắn quái, phép và bẫy.",
		[56941] = "Thú Thần-Thần Uy Hộ Thể",
		[56942] = "Khi trên sân phe ta còn quái khác, lá bài này không thể bị chọn làm mục tiêu.",
		-- TrickStar-Divaridis & TrickStar-Xuat Hien (14218)
		[52523] = "Khi bài này được Triệu Hồi Đặc Biệt; khi lên sân; bài này tăng tấn công bằng tổng số quái có từ khóa “TrickStar” đang có mặt trong mộ/mộ bài loại bỏ phe ta x[1] (bỏ qua “Tường Chắn Quái”); giúp phe ta tăng 1/2 mức LP tương ứng.",
		-- TrickStar Rebalance (14200, 14207, 14222, 14235, 14272)
		[52487] = "Khi bài này nằm trong mộ; ngoại trừ giai đoạn rút bài; đối thủ có bài vào tay sẽ có thể dùng; đối thủ chịu [1] LP.",
		[52501] = "Khi bài này nằm trong mộ; khi đối thủ dùng kỹ năng tay chủ động sẽ kích hoạt; khiến đối thủ mất [1] LP.",
		[52531] = "Chủ động: Mỗi lượt chỉ 1 lần. Xóa 1 Chỉ Thị XYZ đang có; mỗi khi đối thủ dùng bài Phép/Bẫy; trừ [1] LP của đối thủ; hiệu quả tồn tại cho đến khi đối thủ kết thúc lượt kế.",
		[52557] = "Khi bài này nằm trong mộ; phe ta bị mất LP từ chiến đấu trực tiếp sẽ có thể dùng. Loại bỏ bản thân bài này; giảm 1 nửa sát thương lần này.",
		[52631] = "1 lần trong một vòng. Khi ở trên sân; khi phe của bạn triệu hồi một Quái Vật liên kết phía trên link[1]; hãy rút một lá bài.",
		-- Kỳ - Phàm (40727) & Kỹ năng (14677, 14678, 14679, 14680, 14681, 14682, 14683)
		[56943] = "Kỳ - Phàm",
		[56944] = "[Quái vật Dung Hợp]\n<Quỷ Lệ> + <Kỳ Baby>\n[Kỹ năng chủ động bộ bài thêm]: Chọn nguyên liệu dung hợp từ bài trên tay/trên sân đưa vào Mộ -> Triệu hồi Dung Hợp lá bài này.\n[Kỹ năng chủ động trên sân - 1 lần/lượt]: Lấy 1 lá bài quái thú có từ khóa \"Tru tiên\" từ Bộ bài lên tay.\nKhi lên sân: Nhận 1 tầng Tường chắn Năng lượng Quái, Phép, Bẫy.\nKhi trên sân: Quái thú đối phương được Triệu Hồi/Triệu Hồi Đặc Biệt sẽ bị khóa trong thế phòng thủ 1 lượt; đồng thời phe ta hồi LP bằng [Số sao quái đó x 100].\nNếu LP phe ta < 8000: Lá bài này nhận Công bằng [8000 - LP hiện tại].\nQuỷ Lệ-Kim Cương Bất Hoại: Không thể bị phá hủy bởi chiến đấu, 1 lượt 1 lần bỏ qua 1 lần phá hủy bởi hiệu ứng thẻ bài.\nQuỷ Lệ-Hấp Huyết Vô Tình: Khi tiêu diệt quái thú hoặc gây sát thương chiến đấu, phe ta hồi LP tương ứng.\nKhi lá bài này bị đối phương phá hủy: Triệu Hồi Đặc Biệt <Quỷ Lệ> và <Kỳ Baby> từ Mộ lên sân.",
		[56945] = "Kỳ - Phàm",
		[56946] = "Dung Hợp Kỳ Linh",
		[56947] = "Kỹ năng chủ động từ Extra Deck chọn nguyên liệu từ tay/sân đưa vào Mộ để Triệu Hồi Dung Hợp.",
		[56948] = "Kỳ Phàm-Triệu Tập Tru Tiên",
		[56949] = "1 lượt 1 lần: Chọn và lấy 1 lá bài quái thú có từ khóa \"Tru tiên\" từ Bộ bài lên tay.",
		[56950] = "Kỳ Phàm-Nghịch Cảnh Huyết Nộ",
		[56951] = "Nếu LP phe ta thấp hơn 8000, lá bài này nhận thêm Công bằng 8000 - LP hiện tại của phe ta.",
		[56952] = "Quỷ Lệ-Kim Cương Bất Hoại",
		[56953] = "Không thể bị phá hủy bởi chiến đấu. 1 lượt 1 lần được bỏ qua 1 lần phá hủy bởi hiệu ứng thẻ bài.",
		[56954] = "Kỳ Phàm-Thiên Linh Hóa Sinh",
		[56955] = "Khi có mặt trên sân: Mỗi khi đối phương Triệu Hồi hoặc Triệu Hồi Đặc Biệt quái thú, phe ta hồi LP bằng số sao của quái thú đó x 100.",
		[56956] = "Quỷ Lệ-Hấp Huyết Vô Tình",
		[56957] = "Khi tiêu diệt quái thú đối phương trong chiến đấu hoặc gây sát thương chiến đấu, phe ta được hồi phục lượng LP tương ứng.",
		[56958] = "Kỳ Phàm-Phục Sinh Tương Ứng",
		[56959] = "Khi lá bài này bị đối phương phá hủy: Triệu Hồi Đặc Biệt <Quỷ Lệ> và <Kỳ Baby> từ Mộ lên sân.",
		-- Bình Phàm (30593) & Kỹ năng (14684, 14685, 14686)
		[56960] = "Bình Phàm",
		[56961] = "[Bẫy Vĩnh Cửu]\n+ Kĩ năng chủ động 1 (kĩ năng này và kĩ năng chủ động 2 chỉ có thể kích hoạt 1 loại mỗi lượt): Lấy 1 lá bài có từ khóa \"Tru tiên\" từ bộ bài lên tay.\n+ Kĩ năng chủ động 2 (kĩ năng này và kĩ năng chủ động 1 chỉ có thể kích hoạt 1 loại mỗi lượt): Chọn và triệu hồi đặc biệt <Quỷ Lệ> hoặc <Kỳ Baby> từ Mộ hoặc bài trên tay lên sân.\n+ Khi lá bài này vào Mộ từ trên sân: Lấy 1 lá [Huyền Hỏa Giám] từ Bộ bài lên tay.",
		[56962] = "Bình Phàm",
		[56963] = "Bình Phàm-Tầm Đạo Tru Tiên",
		[56964] = "1 lượt 1 lần (chỉ có thể chọn 1 trong 2 kĩ năng mỗi lượt): Lấy 1 lá bài có từ khóa \"Tru tiên\" từ bộ bài lên tay.",
		[56965] = "Bình Phàm-Triệu Tập Tiên Ma",
		[56966] = "1 lượt 1 lần (chỉ có thể chọn 1 trong 2 kĩ năng mỗi lượt): Chọn và triệu hồi đặc biệt <Quỷ Lệ> hoặc <Kỳ Baby> từ Mộ hoặc bài trên tay lên sân.",
		[56967] = "Bình Phàm-Truyền Thừa Huyền Hỏa",
		[56968] = "Khi lá bài này vào Mộ từ trên sân: Lấy 1 lá [Huyền Hỏa Giám] từ Bộ bài lên tay.",
		-- Tiểu Bạch (12321) & Kỹ năng (14687, 14688, 14689, 14690)
		[56969] = "Tiểu Bạch",
		[56970] = "[Quái thú Hiệu Ứng]\n+ Kĩ năng chủ động (trên tay hoặc trong mộ - 1 lượt 1 lần): Đưa 1 lá [Huyền Hỏa Giám] từ trên tay hoặc trên sân vào Mộ; Triệu Hồi Đặc Biệt lá bài này lên sân.\n+ Khi lên sân: Nhận 1 tầng Khiên Chắn Quái Thú.\n+ Kĩ năng chủ động (trên sân - 1 lượt 1 lần): Chiếm quyền điều khiển 1 quái thú trên sân đối thủ (xuyên thấu Khiên Chắn Quái).\n+ Khi lá bài này bị phá hủy: Loại bỏ 1 lá [Huyền Hỏa Giám] trong Mộ thay vì bị phá hủy.",
		[56971] = "Tiểu Bạch",
		[56972] = "Tiểu Bạch-Huyền Hỏa Giáng Thế",
		[56973] = "1 lượt 1 lần (trên tay hoặc trong mộ): Đưa 1 lá [Huyền Hỏa Giám] trên tay hoặc trên sân vào Mộ; Triệu Hồi Đặc Biệt lá bài này lên sân.",
		[56974] = "Tiểu Bạch-Cửu Vĩ Hộ Thể",
		[56975] = "Khi lên sân: Nhận 1 tầng Khiên Chắn Quái Thú.",
		[56976] = "Tiểu Bạch-Mị Hoặc Chúng Sinh",
		[56977] = "1 lượt 1 lần: Chiếm quyền điều khiển 1 quái thú trên sân đối phương (xuyên thấu Khiên Chắn Quái).",
		[56978] = "Tiểu Bạch-Huyền Hỏa Thế Thân",
		[56979] = "Khi lá bài này bị phá hủy: Loại bỏ 1 lá [Huyền Hỏa Giám] trong Mộ thay vì bị phá hủy.",
		-- Quỷ Lệ - Sát (40728) & Kỹ năng (14691, 14692, 14693)
		[56980] = "Quỷ Lệ - Sát",
		[56981] = "[Quái thú Xyz / Hiệu Ứng]\n2 quái thú 7 sao có từ khóa \"Tru tiên\"\n+ Huyết Đao: Khi tiêu diệt quái thú trong chiến đấu, bản thân tăng Công.\n+ Đoạt Ý Chí: Khi tiêu diệt quái thú trong chiến đấu, loại bỏ mục tiêu.\n+ Đòn Ảo Ảnh: Tăng sức tấn công khi giao chiến.\n+ Xuyên Phá: Tấn công quái thú ở thế thủ gây sát thương xuyên thấu.\n+ Khi lá bài này bị ảnh hưởng bởi hiệu quả của đối phương: Phe ta nhận 500 thiệt hại, bỏ qua hiệu ứng đó.\n+ Khi lá bài này còn chỉ thị Xyz: Không thể bị phá hủy.\n+ Khi lá bài này bị tấn công và nhận thiệt hại: Tiêu hao 1 chỉ thị Xyz, chuyển toàn bộ thiệt hại thành hồi phục LP x2 lần.",
		[56982] = "Quỷ Lệ - Sát",
		[56983] = "Q.Lệ Sát-Nghịch Mệnh Hộ Thân",
		[56984] = "Khi lá bài này bị ảnh hưởng bởi hiệu quả của đối phương: Phe ta nhận 500 thiệt hại, bỏ qua hiệu ứng đó.",
		[56985] = "Q.Lệ Sát-Bất Diệt Xyz",
		[56986] = "Khi lá bài này còn chỉ thị Xyz: Không thể bị phá hủy.",
		[56987] = "Q.Lệ Sát-Hóa Huyết Hồi Sinh",
		[56988] = "Khi lá bài này bị tấn công và nhận thiệt hại: Tiêu hao 1 chỉ thị Xyz, chuyển toàn bộ thiệt hại thành hồi phục LP x2 lần.",
		-- Lôi Oa (12322) & Kỹ năng (14694, 14695)
		[56989] = "Lôi Oa",
		[56990] = "[Quái thú Hiệu Ứng]\n+ Kĩ năng chủ động (tay - mộ - 1 lượt 1 lần): Khi trên sân phe ta có quái thú có từ khóa \"Tiên nghịch\", có thể kích hoạt: Triệu Hồi Đặc Biệt lá bài này lên sân.\n+ 1 lượt 1 lần: Khi đối phương Triệu Hồi hoặc Triệu Hồi Đặc Biệt quái thú, kích hoạt: Vô hiệu hóa toàn bộ hiệu ứng của quái thú đó trong 1 lượt.",
		[56991] = "Lôi Oa",
		[56992] = "Lôi Oa-Lôi Trạch Triệu Hồi",
		[56993] = "1 lượt 1 lần: Trên sân phe ta có quái có từ khóa \"Tiên nghịch\" có thể kích hoạt, Triệu Hồi Đặc Biệt lá bài này từ tay hoặc mộ lên sân.",
		[56994] = "Lôi Oa-Tê Liệt Định Thân",
		[56995] = "1 lượt 1 lần: Khi đối phương Triệu Hồi/Triệu Hồi Đặc Biệt, kích hoạt: Vô hiệu hiệu ứng của quái đó trong 1 lượt.",
		-- Lôi Thú (12323) & Kỹ năng (14696, 14697, 14698)
		[56996] = "Lôi Thú",
		[56997] = "[Quái thú Hiệu Ứng]\n+ Kĩ năng tay: 1 lượt 1 lần, khi lá bài này nằm trên tay, đối phương sử dụng bài Phép/Bẫy sẽ kích hoạt: Vô hiệu và phá hủy lá bài đó, sau đó Triệu Hồi Đặc Biệt lá bài này lên sân.\n+ Khi trên sân phe ta không có quái thú thuộc tính \"Lôi\", có thể Triệu Hồi Thường lá bài này không cần vật tế.\n+ Kĩ năng chủ động mộ: Lấy 1 quái thú chủng tộc \"Sấm sét\" có phẩm chất UR trở xuống từ Bộ Bài lên tay.",
		[56998] = "Lôi Thú",
		[56999] = "Lôi Thú-Lôi Đình Phản Kích",
		[57000] = "1 lượt 1 lần: Khi trên tay, đối phương dùng Phép/Bẫy sẽ kích hoạt: Vô hiệu và phá hủy lá đó, sau đó Triệu Hồi Đặc Biệt lá bài này lên sân.",
		[57001] = "Lôi Thú-Lôi Giáng Tự Nhiên",
		[57002] = "Khi trên sân phe ta không có quái thuộc tính \"Lôi\", có thể Triệu Hồi Thường không cần vật tế.",
		[57003] = "Lôi Thú-Dẫn Lôi Nhập Thủ",
		[57004] = "Kĩ năng chủ động mộ: Lấy 1 quái thú chủng tộc \"Sấm sét\" có phẩm chất UR trở xuống từ Bộ Bài lên tay.",
		-- Huyết Tổ (12324) & Kỹ năng (14699, 14700, 14701, 14702)
		[57005] = "Huyết Tổ",
		[57006] = "[Quái thú Hiệu Ứng]\n+ Kĩ năng chủ động (tay - mộ): Hi sinh 1 nửa LP, Triệu Hồi Đặc Biệt lá bài này lên sân.\n+ Khi lên sân: Nhận Điểm Tấn Công (ATK) bằng số LP hiện có của phe ta.\n+ Kĩ năng chủ động (trên sân - 1 lượt 1 lần): Chọn hiến tế tối đa 2 quái thú trên sân, phe ta hồi phục LP bằng tổng ATK của các quái thú bị hiến tế.\n+ Kĩ năng chủ động (mộ loại bỏ): Trả lá bài này về Bộ Bài, phe ta rút 1 lá.",
		[57007] = "Huyết Tổ",
		[57008] = "Huyết Tổ-Huyết Tế Trùng Sinh",
		[57009] = "Kĩ năng chủ động tay - mộ: Hi sinh 1 nửa LP, Triệu Hồi Đặc Biệt lá bài này lên sân.",
		[57010] = "Huyết Tổ-Huyết Khí Thao Thiên",
		[57011] = "Khi lên sân: Nhận ATK bằng số LP hiện có của phe ta.",
		[57012] = "Huyết Tổ-Huyết Năng Thôn Phệ",
		[57013] = "Kĩ năng chủ động trên sân: 1 lượt 1 lần, chọn hiến tế tối đa 2 quái trên sân, phe ta nhận LP bằng ATK của quái bị hiến tế.",
		[57014] = "Huyết Tổ-Huyết Hồn Quy Hoàn",
		[57015] = "Kĩ năng chủ động mộ loại bỏ: Trả lá bài này về Bộ Bài, phe ta rút 1 lá.",
		-- Luyện hồn tông (21134) & Kỹ năng (7552, 7834, 7835, 7836)
		[56781] = "Luyện hồn tông",
		[56782] = "[Bài Phép Môi Trường]\n①: Quái tộc Phù Thủy thuộc tính Ám trên sân phe ta tăng ATK bằng số quái trong mộ 2 bên x 100.\n②: Chủ động: 1 lượt 1 lần, chọn 1 quái trên tay hoặc trên sân phe ta đưa vào mộ, sau đó lấy ngẫu nhiên 1 quái tộc Phù Thủy thuộc tính Ám từ bộ bài lên tay.\n③: Khi lá bài này bị phá hủy từ trên sân: Loại bỏ tất cả quái thú trong mộ 2 bên, phe ta và phe địch chịu thiệt hại bằng số quái bị loại bỏ x 100.",
		[56783] = "Bài phép môi trường.",
		[56784] = "Luyện hồn tông",
		[56785] = "Hồn Lực Cường Hóa",
		[56786] = "Quái tộc Phù Thủy thuộc tính Ám trên sân phe ta tăng ATK bằng số quái trong mộ 2 bên x 100.",
		[56787] = "Luyện Hồn Thu Nạp",
		[56788] = "Chủ động: 1 lượt 1 lần, chọn 1 quái trên tay hoặc trên sân phe ta đưa vào mộ, sau đó lấy ngẫu nhiên 1 quái tộc Phù Thủy thuộc tính Ám từ bộ bài lên tay.",
		[56789] = "Luyện Hồn Bộc Phá",
		[56790] = "Khi lá bài này bị phá hủy từ trên sân: Loại bỏ tất cả quái thú trong mộ 2 bên, phe ta và phe địch chịu thiệt hại bằng số quái bị loại bỏ x 100.",
		-- Độn Thiên (12325) & Kỹ năng (14703, 14704, 14705)
		[57016] = "Độn Thiên",
		[57017] = "[Quái thú Hiệu Ứng]\n+ Kĩ năng chủ động trên tay (1 lượt 1 lần): Hiến tế 1 quái thú Phù Thủy thuộc tính Ám trên sân phe ta, Triệu Hồi Đặc Biệt lá bài này lên sân.\n+ Kĩ năng chủ động trên sân (1 lượt 1 lần): Lấy 1 lá <Luyện hồn tông> từ Bộ Bài lên tay.\n+ Khi trên sân phe ta có <Luyện hồn tông>: Nhận Tường Chắn Quái, Phép, Bẫy.",
		[57018] = "Độn Thiên",
		[57019] = "Độn Thiên-Hiến Tế Xuất Thế",
		[57020] = "Kĩ năng chủ động tay: 1 lượt 1 lần, hiến tế 1 quái Phù Thủy thuộc tính Ám trên sân phe ta, Triệu Hồi Đặc Biệt lá bài này lên sân.",
		[57021] = "Độn Thiên-Luyện Hồn Tông Lệnh",
		[57022] = "Kĩ năng chủ động trên sân: 1 lượt 1 lần, lấy 1 lá <Luyện hồn tông> từ Bộ Bài lên tay.",
		[57023] = "Độn Thiên-Luyện Hồn Hộ Thể",
		[57024] = "Khi trên sân phe ta có <Luyện hồn tông>: Nhận Tường Chắn Quái, Phép, Bẫy.",
		-- Vương Lâm - bản tôn cổ thần (12326) & Kỹ năng (14706, 14707, 14708, 14709, 14710)
		[57025] = "Vương Lâm - bản tôn cổ thần",
		[57026] = "[Quái thú Hiệu Ứng]\n+ Khi lên sân: Nhận Tường Chắn Quái, Phép, Bẫy, [Miệt Thị] và 1 \"chỉ thị cổ thần\" (tối đa 9).\n+ Khi trở thành mục tiêu tấn công: Vô hiệu hóa hiệu ứng của quái tấn công.\n+ 1 lượt 1 lần, đối phương kích hoạt bài phép/bẫy sẽ kích hoạt: Vô hiệu và đưa lá bài đó vào mộ phe ta, nhận 1 \"chỉ thị cổ thần\".\n+ Kĩ năng chủ động: 1 lượt 1 lần, đưa 1 bài phép/bẫy trên tay phe ta vào mộ, nhận 1 \"chỉ thị cổ thần\".\n+ Tăng ATK/DEF bằng số \"chỉ thị cổ thần\" x 300.\n+ Nếu có từ 3 \"chỉ thị cổ thần\" trở lên: Nhận Khiên Chắn Quái, Phép, Bẫy.\n+ Nếu có từ 5 \"chỉ thị cổ thần\" trở lên: Nhân đôi giá trị ATK/DEF nhận được từ \"chỉ thị cổ thần\".\n+ Nếu có từ 7 \"chỉ thị cổ thần\" trở lên: Đối phương triệu hồi/triệu hồi đặc biệt quái <= 4 sao sẽ bị mất hiệu quả quái.\n+ Nếu có 9 \"chỉ thị cổ thần\": Đối phương triệu hồi/triệu hồi đặc biệt quái có ATK <= 2000 sẽ lập tức bị tiêu diệt.",
		[57027] = "Vương Lâm - bản tôn cổ thần",
		[57028] = "Bản Tôn-Cổ Thần Hộ Thể",
		[57029] = "Khi lên sân: Nhận Tường Chắn Quái, Phép, Bẫy, 1 \"chỉ thị cổ thần\" (tối đa 9) và [Miệt Thị].",
		[57030] = "Bản Tôn-Cổ Thần Chi Lực",
		[57031] = "Tăng ATK/DEF bằng số \"chỉ thị cổ thần\" x 300 (từ 5 chỉ thị trở lên x2 thành x600). Từ 3 chỉ thị trở lên: Nhận Khiên Chắn Quái, Phép, Bẫy.",
		[57032] = "Bản Tôn-Cổ Thần Nghịch Phạt",
		[57033] = "1 lượt 1 lần, khi đối phương dùng Phép/Bẫy: Vô hiệu và đưa lá đó vào Mộ phe ta, nhận 1 \"chỉ thị cổ thần\". Khi bị tấn công: Vô hiệu hiệu ứng của quái tấn công.",
		[57034] = "Bản Tôn-Tế Thần Nạp Khí",
		[57035] = "Kỹ năng chủ động (1 lượt 1 lần): Đưa 1 bài Phép/Bẫy trên tay phe ta vào Mộ, nhận 1 \"chỉ thị cổ thần\" (tối đa 9).",
		[57036] = "Bản Tôn-Cổ Thần Uy Áp",
		[57037] = "Từ 7 chỉ thị trở lên: Đối phương triệu hồi quái <= 4 sao bị mất hiệu ứng. Có 9 chỉ thị: Đối phương triệu hồi quái ATK <= 2000 lập tức bị tiêu diệt.",
		-- Lăng Thiên Hậu (40729) & Kỹ năng (14711, 14712, 14713, 14714)
		[57038] = "Lăng Thiên Hậu",
		[57039] = "2+ quái thú có từ khóa \"Thánh Kỵ\" (kể cả quái từ Bộ Bài Thêm)",
		[57040] = "Lăng Thiên Hậu",
		[57041] = "Lăng Thiên Hậu",
		[57042] = "Lăng Thiên-Vương Khí",
		[57043] = "Với mỗi bài Phép Trang Bị có từ khóa \"Thánh Kỵ\" được trang bị, tăng 500 ATK.",
		[57044] = "Lăng Thiên-Liên Kích",
		[57045] = "Có thể tấn công thêm 1 lần với mỗi lá Phép Trang Bị \"Thánh Kỵ\" được trang bị.",
		[57046] = "Lăng Thiên-Khát Kiếm",
		[57047] = "Kỹ năng chủ động (1 lượt 1 lần): Chọn tối đa 2 Phép Trang Bị \"Thánh Kỵ\" khác nhau từ bộ bài lên tay.",
		[57048] = "Lăng Thiên-Bản Mệnh Hàng Thế",
		[57049] = "Khi lên sân: Thêm 3 lá <Lăng thiên kiếm khí - bản mệnh> lên tay.",
		-- Lăng Thiên Kiếm Khí - Bản Mệnh (21140) & Kỹ năng (14715, 14716)
		[57050] = "Lăng Thiên Kiếm Khí - Bản Mệnh",
		[57051] = "[Phép Thường]\n+ 1 lượt tối đa 3 lần, khi lá bài này ở trên tay, quái thú có từ khóa \"Thánh Kỵ\" phe ta bị phá hủy sẽ kích hoạt: Đưa lá bài này vào Mộ: Phá hủy 1 quái trên sân đối thủ (xuyên qua Tường Chắn Quái); nếu trên sân đối thủ không có quái: Phá hủy 1 lá trên tay đối thủ; nếu đối thủ không có quái trên sân và không có bài trên tay: Đối thủ chịu 2000 thiệt hại.\n+ 1 lượt tối đa 3 lần: Chọn 1 quái thú có từ khóa \"Thánh Kỵ\" trong Mộ phe ta, triệu hồi đặc biệt lên sân ở tư thế phòng thủ (không thể đổi tư thế trong lượt này).",
		[57052] = "Kiếm Khí-Bản Mệnh",
		[57053] = "Lăng Thiên Kiếm Khí",
		[57054] = "Kiếm Khí-Hộ Mệnh Phản Kích",
		[57055] = "1 lượt tối đa 3 lần, khi quái \"Thánh Kỵ\" bị phá hủy: Đưa lá này vào Mộ, tiêu diệt 1 quái đối phương (xuyên tường) / hủy 1 bài trên tay / gây 2000 sát thương.",
		[57056] = "Kiếm Khí-Trọng Chấn Hồi Quy",
		[57057] = "1 lượt tối đa 3 lần: Triệu hồi đặc biệt 1 quái \"Thánh Kỵ\" từ Mộ ở tư thế thủ (không thể đổi tư thế lượt này).",
		-- Đỗ kiến - tiên vệ (12327) & Kỹ năng (14717, 14718)
		[57058] = "Đỗ kiến - tiên vệ",
		[57059] = "[Quái thú Hiệu Ứng]\n+ Kỹ năng tay chủ động: Khi trên sân phe ta không có quái: Triệu Hồi Đặc Biệt lá bài này từ trên tay.\n+ Khi có mặt trên sân: Đối phương không thể tấn công quái thú khác ngoài lá bài này.\n+ Khi bị phá hủy trong chiến đấu và đưa vào Mộ: Đối phương bỏ ngẫu nhiên 1 lá bài trên tay.\n+ Khi bài này rời sân hoặc rời khỏi bài trên tay và đưa vào Mộ: Lá bài này sẽ bị loại bỏ.\n+ Bỏ qua hiệu ứng từ bài Quái thú, Phép thuật và Bẫy của đối thủ (Kháng Quái, Phép, Bẫy).",
		[57060] = "Đỗ kiến - tiên vệ",
		[57061] = "Tiên Vệ-Hàng Thế",
		[57062] = "Kỹ năng tay chủ động: Khi trên sân phe ta không có quái sẽ có thể dùng; Triệu Hồi Đặc Biệt bài này từ bài trên tay.",
		[57063] = "Tiên Vệ-Trụy Lạc",
		[57064] = "Khi bị phá hủy trong chiến đấu và đưa vào Mộ; đối phương bỏ ngẫu nhiên 1 lá bài trên tay.",
		-- Thác sâm (40730) & Kỹ năng (14719, 14720, 14721)
		[57065] = "Thác sâm",
		[57066] = "[Thần - Hiệu Ứng - XYZ]\n3 quái 8 sao có từ khóa \"Tiên nghịch\"\n+ Lá bài này có \"chỉ thị xyz\": Bị vô hiệu (không thể tấn công và hành động), bị hiệu ứng trói.\n+ Lá bài này không thể bị hiến tế.\n+ Khi vào Mộ sẽ bị loại bỏ.\n+ 1 lượt tối đa 3 lần: Khi trở thành mục tiêu hiệu quả đối phương, xóa 1 \"chỉ thị xyz\" vô hiệu và phá hủy bài phát động của đối phương.\n+ Kỹ năng chủ động (1 lượt 1 lần): Bỏ 1 chỉ thị xyz, đưa toàn bộ bài trên tay vào Mộ.\n+ Khi lá bài này không còn \"chỉ thị xyz\": Nhân đôi ATK/DEF (16000/16000), xóa hiệu ứng trói và nhận Khiên Chắn Quái, Phép, Bẫy.",
		[57067] = "Thác sâm",
		[57068] = "Thác Sâm-Phong Ấn Cổ Thần",
		[57069] = "Có chỉ thị XYZ: Bị vô hiệu (không thể tấn công), nhận hiệu ứng trói. Không thể bị hiến tế. Vào Mộ bị loại bỏ. Khi hết chỉ thị XYZ: x2 ATK/DEF, nhận Khiên Chắn Quái, Phép, Bẫy.",
		[57070] = "Thác Sâm-Nghịch Chuyển Thần Uy",
		[57071] = "1 lượt tối đa 3 lần: Khi trở thành mục tiêu hiệu quả đối phương, bỏ 1 chỉ thị XYZ, vô hiệu và phá hủy bài phát động của đối phương.",
		[57072] = "Thác Sâm-Diệt Thế Táng Lạc",
		[57073] = "Kỹ năng chủ động (1 lượt 1 lần): Bỏ 1 chỉ thị XYZ, đưa toàn bộ bài trên tay vào Mộ.",
		-- Đạo hóa hoàng tuyền (21141) & Kỹ năng (14722, 14738)
		[57074] = "Đạo hóa hoàng tuyền",
		[57075] = "[Phép Vĩnh Cửu]\n+ Khi lá bài này trên sân, và trên sân phe ta có <Vương Lâm - phân thân>: Đối phương không thể kích hoạt hiệu quả quái thú trong Mộ hoặc Mộ loại bỏ.\n+ Kỹ năng chủ động (1 lượt 1 lần): Đưa lá bài này vào Mộ, triệu hồi đặc biệt 1 <12328> từ Mộ lên sân.",
		[57076] = "Đạo hóa hoàng tuyền",
		[57077] = "Đạo Hóa Hoàng Tuyền-Phong Tỏa",
		[57078] = "Khi lá bài này trên sân và trên sân phe ta có Vương Lâm: Đối phương không thể kích hoạt hiệu quả quái thú trong Mộ hoặc Mộ loại bỏ.",
		[57127] = "Đạo Hóa Hoàng Tuyền - Triệu Hồi",
		[57128] = "Kỹ năng chủ động (1 lượt 1 lần): Đưa lá bài này vào Mộ, triệu hồi đặc biệt 1 <12328> từ Mộ lên sân.",
		-- Vương Lâm - phân thân (12328) & Kỹ năng (14723, 14724, 14725)
		[57079] = "Vương Lâm - phân thân",
		[57080] = "[Phù Thủy - Hiệu Ứng]\n+ Khi lên sân: Lấy 1 lá <Đạo hóa hoàng tuyền> từ bộ bài lên tay.\n+ Kỹ năng chủ động 1: Chọn 1 quái trên sân đối phương để loại bỏ (xuyên qua Tường Chắn Quái 12008), đối phương chịu thiệt hại bằng 1/2 điểm ATK của quái bị loại bỏ.\n+ Kỹ năng chủ động 2: Chọn 1 quái trong Mộ phe ta triệu hồi đặc biệt lên sân, phe ta rút 1 lá bài.\n(Kỹ năng chủ động 1 và 2 mỗi lượt chỉ được dùng 1 loại).",
		[57081] = "Vương Lâm - phân thân",
		[57082] = "Cực Cảnh-Tru Diệt Phá Trận",
		[57083] = "Kỹ năng chủ động 1: Chọn 1 quái trên sân đối phương để loại bỏ (xuyên qua Tường Chắn Quái 12008), đối phương chịu thiệt hại bằng 1/2 điểm ATK của quái bị loại bỏ (dùng chung lượt với kỹ năng 2).",
		[57084] = "Hoàng Tuyền-Luân Hồi Tái Sinh",
		[57085] = "Kỹ năng chủ động 2: Chọn 1 quái trong Mộ phe ta triệu hồi đặc biệt lên sân, phe ta rút 1 lá bài (dùng chung lượt với kỹ năng 1).",
		[57086] = "Phân Thân-Hoàng Tuyền Kêu Gọi",
		[57087] = "Khi lên sân: Lấy 1 lá <Đạo hóa hoàng tuyền> từ Bộ bài lên tay.",
		[57088] = "Tiên Nghịch Thần Thông-Hộ Mệnh",
		[57089] = "Tường chắn Quái, Phép, Bẫy đặc biệt của hệ Tiên Nghịch.",
		[36590] = "Cánh Bổ Nhào",
		[36591] = "Khi tấn công; Quái Vật trên sân; tay hoặc mộ của đối thủ không thể kích hoạt hiệu ứng quái vật và đối thủ không thể kích hoạt hiệu ứng phép thuật hoặc bẫy trên sân.",
		[36638] = "Liên Trảm",
		[36639] = "Có thể tấn công mỗi quái trên sân đối thủ 1 lần; không thể tấn công trực tiếp đối thủ.",
		-- Phô Lô Ti Nô (40731) & Kỹ năng (14727, 14728)
		[57090] = "Phô Lô Ti Nô",
		[57091] = "[Chiến Binh - Hiệu Ứng - Link 2]\n2 quái thú bất kì\n+ Khi lên sân: Nhận Tường Chắn Quái, Phép, Bẫy đặc biệt.\n+ Kỹ năng chủ động (1 lượt 1 lần): Tung 1 đồng xu.\n- Mặt ngửa: Nhận Cánh Bổ Nhào, Liên Trảm và tăng 500 ATK cho mỗi quái thú trên sân đối phương.\n- Mặt sấp: Nhận Khiên Chắn.",
		[57092] = "Phô Lô Ti Nô",
		[57093] = "Vũ Điệu Lãng Hoa",
		[57094] = "Khi lên sân: Nhận Tường Chắn Quái, Phép, Bẫy đặc biệt.",
		[57095] = "Thưởng Hoa Tung Xu",
		[57096] = "Kỹ năng chủ động (1 lượt 1 lần): Tung 1 đồng xu.\n- Mặt ngửa: Nhận Cánh Bổ Nhào, Liên Trảm và tăng 500 ATK cho mỗi quái thú trên sân đối phương.\n- Mặt sấp: Nhận Khiên Chắn.",
		-- Vương Lâm - Cổ yêu (40732) & Kỹ năng (14729, 14730)
		[57097] = "Vương Lâm - Cổ yêu",
		[57098] = "[Xác Sống - Hiệu Quả - Đồng Bộ]\n<Vương Lâm - Phân Thân> (12328) + 1 quái điều chỉnh có từ khóa \"Tiên nghịch\" trở lên.\n+ Kỹ năng chủ động bộ bài thêm: 1 lượt 1 lần, chọn 1 quái có từ khóa \"Tiên nghịch\" trên sân phe ta, quái đó nhận \"Nhịp Điệu Synchron\".\n+ Cánh Bổ Nhào: Khi tấn công, quái vật trên sân, tay hoặc mộ của đối thủ không thể kích hoạt hiệu ứng quái vật và đối thủ không thể kích hoạt hiệu ứng phép thuật hoặc bẫy trên sân.\n+ Không bị ảnh hưởng bởi hiệu ứng lá bài khác trong lượt được triệu hồi đồng bộ.\n+ Triệu hồi đồng bộ lá bài này không thể bị vô hiệu hóa.\n+ Khi bị phá hủy: Triệu hồi đặc biệt <Vương Lâm - Phân Thân> từ mộ bài lên sân.",
		[57099] = "Vương Lâm - Cổ yêu",
		[57100] = "Cổ Yêu-Đồng Bộ Kêu Gọi",
		[57101] = "Kỹ năng chủ động bộ bài thêm (1 lượt 1 lần): Chọn 1 quái có từ khóa \"Tiên nghịch\" trên sân phe ta, quái đó nhận \"Nhịp Điệu Synchron\".",
		[57102] = "Cổ Yêu-Phân Thân Trùng Sinh",
		[57103] = "Khi bị phá hủy: Triệu hồi đặc biệt <Vương Lâm - Phân Thân> từ mộ bài lên sân.",
		-- Lý Mộ Uyển (12329) & Kỹ năng (14731, 14732)
		[57104] = "Lý Mộ Uyển",
		[57105] = "[Phù Thủy - Hiệu Ứng - Điều Chỉnh]\n+ Kỹ năng chủ động trên tay: 1 lượt 1 lần, chọn lấy 1 lá <Vương Lâm> (12326) hoặc <Vương Lâm - Phân Thân> (12328) từ bộ bài lên tay, sau đó triệu hồi đặc biệt bản thân lên sân.\n+ Kỹ năng chủ động trong Mộ: 1 lượt 1 lần, loại bỏ bản thân, chọn 1 lá <Vương Lâm> (12326) hoặc <Vương Lâm - Phân Thân> (12328) từ trên tay, triệu hồi đặc biệt lên sân.",
		[57106] = "Lý Mộ Uyển",
		[57107] = "Uyển Nhi-Tương Phùng",
		[57108] = "Kỹ năng chủ động trên tay (1 lượt 1 lần): Chọn lấy 1 lá <Vương Lâm> (12326) hoặc <Vương Lâm - Phân Thân> (12328) từ bộ bài lên tay, sau đó triệu hồi đặc biệt bản thân lên sân.",
		[57109] = "Uyển Nhi-Hồn Quy",
		[57110] = "Kỹ năng chủ động trong Mộ (1 lượt 1 lần): Loại bỏ bản thân, chọn 1 lá <Vương Lâm> (12326) hoặc <Vương Lâm - Phân Thân> (12328) từ trên tay, triệu hồi đặc biệt lên sân.",
		-- Vương Lâm - Hợp Đạo (40733) & Kỹ năng (14736, 14737)
		[57111] = "Vương Lâm - Hợp Đạo",
		[57112] = "[Huyễn Thần - Dung Hợp - Hiệu Ứng]\n<12326> + <12328>\n+ Tường Chắn Quái, Tường Chắn Phép, Tường Chắn Bẫy.\n+ Khi lá bài này bị phá hủy: Phe ta nhận Tường Chắn Sinh Mệnh (1 lượt).\n+ Khiên Chắn Hiệu Quả (không bị hiệu ứng phá hủy).\n+ Khi ở trên sân: Hai bên không thể Triệu Hồi Đặc Biệt quái từ Mộ.\n+ Khi tấn công quái có ATK cao hơn: Nhận Thương Tích, Đòn Ảo Ảnh, Miệt Thị.\n+ Nhận 1 tầng Tường Chắn Chiến Đấu.",
		[57113] = "Vương Lâm - Hợp Đạo",
		[57114] = "Hợp Đạo - Thiên Đạo Trấn Áp",
		[57115] = "Khi ở trên sân: Hai bên không thể triệu hồi đặc biệt quái từ Mộ. Khi tấn công quái có ATK cao hơn: Nhận Thương Tích, Đòn Ảo Ảnh, Miệt Thị. Nhận 1 tầng Tường Chắn Chiến Đấu.",
		[57116] = "Hợp Đạo - Niết Bàn Sinh Mệnh",
		[57117] = "Khi lá bài này bị phá hủy, phe ta nhận Tường Chắn Sinh Mệnh (1 lượt).",
		-- Hợp Đạo (21142) & Kỹ năng (14733, 14734, 14735)
		[57118] = "Hợp Đạo",
		[57119] = "[Ma Pháp Thông Thường]\n(Chỉ được chọn 1 trong các hiệu ứng sau mỗi lượt):\n1. Triệu hồi Dung Hợp 1 quái thú có từ khóa \"Tiên nghịch\" từ Bộ bài thêm bằng cách đưa quái thú từ Tay hoặc Sân vào Mộ.\n2. Loại bỏ lá bài này trong Mộ bài: Triệu hồi Dung Hợp 1 quái thú có từ khóa \"Tiên nghịch\" từ Bộ bài thêm bằng cách đưa quái thú từ Bộ bài vào Mộ.\n3. Gửi lá bài này và 1 quái thú có từ khóa \"Tiên nghịch\" từ Tay vào Mộ: Lấy 1 quái thú có từ khóa \"Tiên nghịch\" từ Bộ bài vào Tay.",
		[57120] = "Hợp Đạo",
		[57121] = "Hợp Đạo - Dung Hợp",
		[57122] = "Triệu hồi Dung Hợp 1 quái thú có từ khóa \"Tiên nghịch\" từ Bộ bài thêm bằng cách đưa quái thú từ Tay hoặc Sân vào Mộ.",
		[57123] = "Hợp Đạo - Mộ Dung Hợp",
		[57124] = "Loại bỏ lá bài này trong Mộ bài: Triệu hồi Dung Hợp 1 quái thú có từ khóa \"Tiên nghịch\" từ Bộ bài thêm bằng cách đưa quái thú từ Bộ bài vào Mộ.",
		[57125] = "Tiên Nghịch - Trao Đổi",
		[57126] = "Gửi lá bài này và 1 quái thú có từ khóa \"Tiên nghịch\" từ Tay vào Mộ: Lấy 1 quái thú có từ khóa \"Tiên nghịch\" từ Bộ bài vào Tay.",
		-- Tuyết Nữ Băng Giá (40648) & Kỹ năng (13838)
		[51763] = "Kỹ năng bộ bài thêm chủ động: Mỗi lượt chỉ 1 lần. Khi trên sân không có quái và trên tay có từ 2 lá bài trở lên có thể dùng: Loại bỏ ngẫu nhiên 2 lá bài trên tay phe ta; Chọn tối đa [1] quái trên sân đối thủ đưa vào mộ bài loại bỏ (bỏ qua “Tường Chắn Quái”), sau đó Triệu Hồi Đặc Biệt bản thân bài này lên sân.",
		-- Thần âm phủ đóng cửa thế giới (40551) & Kỹ năng (14739)
		[35716] = "[Quái Hiệu Quả - Link 5]\nQuái hiệu quả x2 trở lên.\n+ Khi lá bài này trên sân: Phe ta không thể triệu hồi quái từ Bộ bài thêm.",
		[57129] = "Thần Âm Phủ - Phong Tỏa Bài Thêm",
		[57130] = "Khi lá bài này trên sân: Phe ta không thể triệu hồi quái từ Bộ bài thêm.",
		-- Mèo bắt tay (12330) & Kỹ năng (14740)
		[57131] = "Mèo bắt tay",
		[57132] = "[Thú - Hiệu Ứng]\n+ 1 lượt tối đa 3 lần: Khi lá bài này nằm trên tay, đối phương kích hoạt hiệu ứng từ bài trên tay, sẽ kích hoạt: Đưa lá bài này vào Mộ, vô hiệu hiệu ứng đó và đẩy lá bài đó về cuối bộ bài, đối phương rút 1 lá, lấy 1 lá <Mèo bắt tay> từ Bộ bài lên tay.",
		[57133] = "Mèo bắt tay",
		[57134] = "Mèo Bắt Tay - Chặn Tay",
		[57135] = "1 lượt tối đa 3 lần: Khi ở trên tay, đối phương kích hoạt hiệu ứng từ bài trên tay: Đưa lá bài này vào Mộ, vô hiệu hiệu ứng đó và đẩy lá bài đó về cuối bộ bài, đối phương rút 1 lá, lấy 1 lá <Mèo bắt tay> từ Bộ bài lên tay.",
		-- KMR-Zio (12331) & Kỹ năng (14741, 14742)
		[57136] = "KMR-Zio",
		[57137] = "[Chiến Binh - Hiệu Ứng]\n+ 1 lượt 1 lần, khi được triệu hồi/triệu hồi đặc biệt lên sân: Lấy 1 lá [Chuyển dạng] từ Bộ bài lên tay.\n+ Kỹ năng chủ động Mộ (1 lượt 1 lần): Chọn lấy 1 quái thú có từ khóa \"Hiệp sĩ mặt nạ\" từ Bộ bài lên tay.",
		[57138] = "KMR-Zio",
		[57139] = "KMR-Zio - Dẫn Đạo",
		[57140] = "1 lượt 1 lần, khi được triệu hồi hoặc triệu hồi đặc biệt lên sân: Lấy 1 lá [Chuyển dạng] từ Bộ bài lên tay.",
		[57141] = "KMR-Zio - Ký Ức Kỵ Sĩ",
		[57142] = "Kỹ năng chủ động trong Mộ (1 lượt 1 lần): Chọn lấy 1 quái thú có từ khóa \"Hiệp sĩ mặt nạ\" từ Bộ bài lên tay.",
		-- Chuyển dạng (21143) & Kỹ năng (14743)
		[57143] = "Chuyển dạng",
		[57144] = "[Ma Pháp Thông Thường]\nChọn 1 quái Dung Hợp có từ khóa \"Hiệp sĩ mặt nạ\" trong Bộ bài thêm phe ta; hy sinh nguyên liệu dung hợp đang có mặt trên sân/trên tay phe ta; Triệu Hồi Dung Hợp quái đã chọn, sau đó trong lượt này chỉ có thể triệu hồi quái có từ khóa \"Hiệp sĩ mặt nạ\".",
		[57145] = "Chuyển dạng",
		[57146] = "Chuyển dạng - Henshin",
		[57147] = "Chọn 1 quái Dung Hợp có từ khóa \"Hiệp sĩ mặt nạ\" trong Bộ bài thêm phe ta; hy sinh nguyên liệu dung hợp đang có mặt trên sân/trên tay phe ta; Triệu Hồi Dung Hợp quái đã chọn, sau đó trong lượt này chỉ có thể triệu hồi quái có từ khóa \"Hiệp sĩ mặt nạ\".",
		-- KMR-W (12332) & Kỹ năng (14744, 14745)
		[57148] = "KMR-W",
		[57149] = "[Chiến Binh - Hiệu Ứng]\n+ Khi trên sân phe ta không có quái hoặc có quái có từ khóa \"Hiệp sĩ mặt nạ\", có thể triệu hồi thường quái lên sân không cần vật tế.\n+ Kỹ năng chủ động: Hy sinh bản thân, chọn Triệu Hồi Đặc Biệt [KMR-W-Fang] từ Bộ bài thêm lên sân.",
		[57150] = "KMR-W",
		[57151] = "KMR-W - Lộng Gió",
		[57152] = "Khi trên sân phe ta không có quái hoặc có quái có từ khóa \"Hiệp sĩ mặt nạ\", có thể triệu hồi thường quái lên sân không cần vật tế.",
		[57153] = "KMR-W - Fang Biến Thân",
		[57154] = "Kỹ năng chủ động: Hy sinh bản thân, chọn Triệu Hồi Đặc Biệt [KMR-W-Fang] từ Bộ bài thêm lên sân.",
		-- KMR-W-Fang (40734)
		[57155] = "KMR-W-Fang",
		[57156] = "[Chiến Binh - Dung Hợp - Hiệu Ứng]\n+ Phải dùng hiệu quả của KMR-W để triệu hồi.\n+ Thiên Sứ-Xung Kích: 1 lượt 1 lần, chọn 1 lá bài trên sân đối thủ đưa vào Mộ Loại Bỏ (bỏ qua Tường Chắn Quái).\n+ Tường Chắn Quái, Tường Chắn Phép, Tường Chắn Bẫy.",
		[57157] = "KMR-W-Fang",
		-- KMR-Zio-W (40735) & Kỹ năng (14746)
		[57158] = "KMR-Zio-W",
		[57159] = "[Chiến Binh - Dung Hợp - Hiệu Ứng]\n<KMR-Zio> + <KMR-W>\n+ Tấn công nhân đôi khi chiến đấu với quái thuộc tính Quang hoặc Ám (bỏ qua Tường Chắn Quái).\n+ Khiên Chắn Hiệu Quả (không bị hiệu ứng phá hủy).\n+ Khi lá bài này trên sân, quái thuộc tính Quang/Ám trên sân đối phương không thể tấn công.",
		[57160] = "KMR-Zio-W",
		[57161] = "KMR-Zio-W - Vương Quyền Phong Ấn",
		[57162] = "Khi lá bài này trên sân: Quái thuộc tính Quang và Ám trên sân đối phương không thể tấn công.",
		-- KMR-Ozu (12333) & Kỹ năng (14747)
		[57163] = "KMR-Ozu",
		[57164] = "[Chiến Binh - Hiệu Ứng]\n+ Kỹ năng chủ động tay (1 lượt 1 lần): Triệu hồi Đặc Biệt bản thân, sau đó tung 3 đồng xu. Phe ta rút số lá bài bằng số xu mặt ngửa. Sau đó trong lượt này, phe ta chỉ có thể Triệu Hồi/Triệu Hồi Đặc Biệt quái thú có từ khóa \"Hiệp sĩ mặt nạ\".",
		[57165] = "KMR-Ozu",
		[57166] = "KMR-Ozu - Giới Khởi Động",
		[57167] = "Kỹ năng chủ động trên tay (1 lượt 1 lần): Triệu hồi Đặc Biệt bản thân, sau đó tung 3 đồng xu. Phe ta rút số lá bài bằng số xu mặt ngửa. Sau đó trong lượt này, phe ta chỉ có thể Triệu Hồi/Triệu Hồi Đặc Biệt quái thú có từ khóa \"Hiệp sĩ mặt nạ\".",
		[57168] = "KMR-Wizard",
		[57169] = "[Chiến Binh - Hiệu Ứng]\n+ Bỏ 1 lá bài trên tay: Triệu Hồi Đặc Biệt lá bài này từ trên tay.\n+ Kỹ năng chủ động (1 lượt 1 lần): Chọn lấy 1 lá bài Phép có từ khóa \"Hiệp sĩ mặt nạ\" từ Bộ bài hoặc Mộ lên tay.",
		[57170] = "KMR-Wizard",
		[57171] = "KMR-Wizard - Nhẫn Thuật Ma Pháp",
		[57172] = "Kỹ năng chủ động (1 lượt 1 lần): Chọn lấy 1 lá bài Phép có từ khóa \"Hiệp sĩ mặt nạ\" từ Bộ bài hoặc Mộ lên tay.",
		[57173] = "Rider kick",
		[57174] = "[Ma Pháp Thông Thường]\nKhi trên sân phe ta có quái thú có từ khóa \"Hiệp sĩ mặt nạ\": Phá hủy số quái thú trên sân đối phương tương ứng với số lượng quái thú trên sân phe ta (xuyên qua Tường Chắn Quái). Sau đó trong lượt này, quái thú có từ khóa \"Hiệp sĩ mặt nạ\" phe ta không thể tấn công.",
		[57175] = "Rider kick",
		[57176] = "Rider kick - Toàn Lực Tất Sát",
		[57177] = "Khi trên sân phe ta có quái thú có từ khóa \"Hiệp sĩ mặt nạ\": Phá hủy số quái thú trên sân đối phương tương ứng với số lượng quái thú trên sân phe ta (xuyên qua Tường Chắn Quái). Sau đó trong lượt này, quái thú có từ khóa \"Hiệp sĩ mặt nạ\" phe ta không thể tấn công.",
		[57178] = "Chị Em Harpie Lady - Tam Giác Mê Hoặc",
		[57179] = "[Thú Có Cánh - Dung Hợp - Hiệu Ứng]\n3 quái thú \"Harpie Lady\"\nPhải được Triệu hồi Dung hợp trước tiên.\n(1) Tên lá bài này được coi là \"Harpie Lady\" khi ở trên sân hoặc trong Mộ.\n(2) Tăng 500 Công cho mỗi \"Harpie Lady\" trong Mộ của bạn. Nhận Tường Chắn Quái, Tường Chắn Phép, Tường Chắn Bẫy.\n(3) Mỗi lượt 1 lần (Hiệu ứng Nhanh): Bạn có thể phá hủy toàn bộ Ma pháp và Cạm bẫy đối thủ điều khiển.",
		[57180] = "Chị Em Harpie Lady - Tam Giác Mê Hoặc",
		[57181] = "Tam Giác Mê Hoặc - Phong Bão Quét Sạch",
		[57182] = "Mỗi lượt một lần: Phá hủy toàn bộ Ma pháp và Cạm bẫy mà đối thủ điều khiển.",
		[57183] = "Tam Kính Kiều Diễm",
		[57184] = "[Ma Pháp Thông Thường]\nBạn chỉ có thể sử dụng mỗi hiệu ứng (1) và (2) của lá bài này một lần mỗi lượt.\n(1) Thêm 1 quái thú \"Harpie\" từ Bộ bài lên tay, sau đó nếu chỉ có đối thủ điều khiển quái thú, bạn có thể Triệu hồi Đặc biệt 1 \"Harpie Lady\" từ trên tay hoặc Mộ lên sân.\n(2) Kỹ năng chủ động Mộ: Bạn có thể trục xuất lá bài này khỏi Mộ; Triệu hồi Dung hợp 1 quái thú Dung hợp thuộc tính ĐẤT hoặc GIÓ từ Bộ bài Phụ, sử dụng quái thú trên tay hoặc trên sân làm nguyên liệu.",
		[57185] = "Tam Kính Kiều Diễm",
		[57186] = "Tam Kính Kiều Diễm - Gương Kính Triệu Tập",
		[57187] = "Thêm 1 quái thú \"Harpie\" từ Bộ bài lên tay, sau đó nếu chỉ có đối thủ điều khiển quái thú, bạn có thể Triệu hồi Đặc biệt 1 \"Harpie Lady\" từ trên tay hoặc Mộ lên sân.",
		[57188] = "Tam Kính Kiều Diễm - Dung Hợp Kính Soi",
		[57189] = "Kỹ năng chủ động Mộ: Trục xuất lá này khỏi Mộ; Triệu hồi Dung hợp 1 quái thú Dung hợp thuộc tính ĐẤT hoặc GIÓ từ Bộ bài Phụ, sử dụng quái thú trên tay hoặc trên sân làm nguyên liệu.",
		[57190] = "KMR-Zio-Wizard",
		[57191] = "[Chiến Binh - Dung Hợp - Hiệu Ứng]\n\"KMR-Zio\" + \"KMR-Wizard\"\n(1) Đối phương không thể sử dụng bài Phép.\n(2) Tường Chắn Quái, Tường Chắn Phép, Tường Chắn Bẫy.\n(3) Tất cả bài Phép/Bẫy trên sân phe ta không thể bị phá hủy.",
		[57192] = "KMR-Zio-Wizard",
		[57193] = "KMR-Zio-Wizard - Phong Tỏa Ma Thuật",
		[57194] = "Khi có mặt: Đối phương không thể sử dụng bài Phép.",
		[57195] = "Bức Tường Gương Mê Lạc",
		[57196] = "[Cạm Bẫy Vĩnh Cửu]\n(1) Nhận được các hiệu ứng sau trong khi bạn đang điều khiển một quái thú \"Amazoness\" hoặc \"Harpie Lady\":\n• Tất cả quái thú ngửa mặt mà đối thủ đang điều khiển được chuyển sang Thế Tấn công và phải tấn công nếu có thể.\n• Mỗi trận chiến một lần, khi quái thú của đối thủ tuyên bố tấn công: Bạn có thể giảm một nửa chỉ số ATK của quái thú đó.\n(2) Mỗi lượt một lần, trong Chu kỳ Chuẩn bị: Bạn có thể Úp 1 lá Ma pháp/Cạm bẫy từ Mộ hoặc đang bị trục xuất của bạn mà có đề cập đến \"Harpie Lady\", ngoại trừ lá \"Bức Tường Gương Mê Lạc\".",
		[57197] = "Bức Tường Gương Mê Lạc",
		[57198] = "Bức Tường Gương Mê Lạc - Mê Lực Gương Soi",
		[57199] = "Khi điều khiển \"Amazoness\" hoặc \"Harpie Lady\": Toàn bộ quái thú đối thủ chuyển sang Thế Tấn công và bắt buộc tấn công nếu có thể. Mỗi trận chiến một lần khi quái thú đối thủ tấn công, giảm nửa ATK quái thú đó.",
		[57200] = "Bức Tường Gương Mê Lạc - Hồi Phục Kính Vạn Hoa",
		[57201] = "Trong Chu kỳ Chuẩn bị: Bạn có thể Úp 1 lá Ma pháp/Cạm bẫy có đề cập đến \"Harpie Lady\" từ Mộ hoặc đang bị trục xuất lên sân.",
		[57202] = "Trận Hình Harpie & Amazoness Rakshasa",
		[57203] = "[Ma Pháp Tốc Độ Nhanh]\nBạn chỉ có thể kích hoạt 1 lá bài có tên này mỗi lượt.\n(1) Chọn 1 quái thú \"Harpie\" hoặc \"Amazoness\" trong Mộ hoặc đang bị trục xuất của bạn; Triệu hồi Đặc biệt quái thú đó, sau đó kích hoạt hiệu ứng dựa trên tổng số quái thú \"Harpie Lady\" và \"Amazoness\" bạn đang điều khiển:\n• Từ 1 quái thú trở lên: Đặt 1 lá \"Bức Tường Gương Mê Lạc\" từ Bộ bài ở trạng thái ngửa vào Vùng Ma pháp & Cạm bẫy.\n• Từ 2 quái thú trở lên: Giành quyền điều khiển 1 quái thú đối thủ điều khiển.\n• Từ 3 quái thú trở lên: Phá hủy tất cả quái thú đối thủ điều khiển.",
		[57204] = "Trận Hình Rakshasa",
		[57205] = "Trận Hình Harpie & Amazoness Rakshasa",
		[57206] = "Triệu hồi Đặc biệt 1 quái thú \"Harpie\" hoặc \"Amazoness\" từ Mộ hoặc đang bị trục xuất, sau đó áp dụng hiệu ứng 1+, 2+, 3+ dựa trên số quái thú \"Harpie Lady\" và \"Amazoness\" bạn điều khiển.",
		[57207] = "Giải Cứu Kịch Tính Amazoness",
		[57208] = "[Cạm Bẫy Thông Thường]\nBạn chỉ có thể sử dụng mỗi hiệu ứng (1) và (2) của lá bài này một lần mỗi lượt.\n(1) Chọn mục tiêu là 1 quái thú trên sân; Triệu hồi Đặc biệt 1 quái thú \"Harpie\" hoặc \"Amazoness\" từ trên tay hoặc Bộ bài của bạn, và nếu làm vậy, hãy trả quái thú được chọn làm mục tiêu đó về tay.\n(2) Kỹ năng chủ động Mộ: Bạn có thể trục xuất lá bài này khỏi Mộ; thêm 1 quái thú \"Harpie\" hoặc \"Amazoness\" từ Mộ hoặc đang bị trục xuất lên tay.",
		[57209] = "Giải Cứu Amazoness",
		[57210] = "Giải Cứu Kịch Tính Amazoness",
		[57211] = "Chọn 1 quái thú trên sân; Triệu hồi Đặc biệt 1 quái thú \"Harpie\" hoặc \"Amazoness\" từ tay hoặc Bộ bài, sau đó đưa quái thú mục tiêu về tay.",
		[57212] = "Giải Cứu Kịch Tính - Chiêu Mộ Tái Sinh",
		[57213] = "Kỹ năng chủ động Mộ: Trục xuất lá này khỏi Mộ; thêm 1 quái thú \"Harpie\" hoặc \"Amazoness\" từ Mộ hoặc đang bị trục xuất lên tay.",
		[57220] = "Tam Giác Mê Hoặc",
		[57221] = "Tăng 500 Công cho mỗi \"Harpie Lady\" trong Mộ của bạn.",
		[57222] = "KMR-Decade",
		[57223] = "[Chiến Binh - Link - Hiệu Ứng]\n1 quái thú có từ khóa \"Hiệp sĩ mặt nạ\"\n(1) Kỹ năng chủ động (1 lượt 1 lần): Đưa lá bài này vào Mộ; chọn 1 quái thú có từ khóa \"Hiệp sĩ mặt nạ\" từ trên tay hoặc Bộ bài để Triệu hồi Đặc biệt lên sân.",
		[57224] = "KMR-Decade",
		[57225] = "KMR-Decade - Thông Đạo Kỵ Sĩ",
		[57226] = "1 lượt 1 lần, đưa lá bài này vào Mộ; chọn 1 quái thú có từ khóa \"Hiệp sĩ mặt nạ\" từ trên tay hoặc Bộ bài để Triệu hồi Đặc biệt lên sân.",
		[57227] = "KMR-Omazio",
		[57228] = "[Chiến Binh - Dung Hợp - Hiệu Ứng]\n\"KMR-Zio\" + 1 quái thú Dung hợp có từ khóa \"Hiệp sĩ mặt nạ\" + 1 quái thú có từ khóa \"Hiệp sĩ mặt nạ\"\n(1) Mỗi lượt nhận 1 lần Khiên Chiến Đấu.\n(2) Tường Chắn Quái, Tường Chắn Phép, Tường Chắn Bẫy.\n(3) Kỹ năng chủ động (1 lượt 1 lần): Chọn tối đa 3 quái thú không phải Dung hợp có từ khóa \"Hiệp sĩ mặt nạ\" trong Mộ, trên tay hoặc trong Bộ bài của bạn; Triệu hồi Đặc biệt lên sân ở Thế Phòng thủ, và quái thú đó không thể đổi tư thế trong lượt này.",
		[57229] = "KMR-Omazio",
		[57230] = "KMR-Omazio - Ma Vương Khởi Động",
		[57231] = "1 lượt 1 lần: Chọn tối đa 3 quái thú không phải Dung hợp có từ khóa \"Hiệp sĩ mặt nạ\" trong Mộ, trên tay hoặc trong Bộ bài để Triệu hồi Đặc biệt lên sân ở Thế Phòng thủ (không thể đổi tư thế trong lượt này).",
		[57232] = "KMR-Zio-Ozu",
		[57233] = "[Chiến Binh - Dung Hợp - Hiệu Ứng]\n\"KMR-Zio\" + \"KMR-Ozu\"\n(1) Kỹ năng chủ động 1 (kỹ năng này và kỹ năng chủ động 2 chỉ có thể dùng 1 loại 1 lượt): 1 lượt 1 lần, tung 3 đồng xu, đối phương đưa ngẫu nhiên 1 lá bài trên tay vào Mộ ứng với mỗi đồng xu mặt ngửa.\n(2) Kỹ năng chủ động 2 (kỹ năng này và kỹ năng chủ động 1 chỉ có thể dùng 1 loại 1 lượt): 1 lượt 1 lần, tung 3 đồng xu, đối phương đưa ngẫu nhiên 1 lá bài trên sân vào Mộ ứng với mỗi đồng xu mặt ngửa.",
		[57234] = "KMR-Zio-Ozu",
		[57235] = "KMR-Zio-Ozu - Đoạt Thủ Bài",
		[57236] = "1 lượt 1 lần (chỉ dùng 1 trong 2 kỹ năng mỗi lượt): Tung 3 đồng xu, đối phương đưa ngẫu nhiên 1 lá bài trên tay vào Mộ ứng với mỗi đồng xu mặt ngửa.",
		[57237] = "KMR-Zio-Ozu - Đoạt Trường Bài",
		[57238] = "1 lượt 1 lần (chỉ dùng 1 trong 2 kỹ năng mỗi lượt): Tung 3 đồng xu, đối phương đưa ngẫu nhiên 1 lá bài trên sân vào Mộ ứng với mỗi đồng xu mặt ngửa.",
		[57239] = "KMR-Ghost",
		[57240] = "[Chiến Binh - Hiệu Ứng]\n(1) 1 lượt tối đa 2 lần, khi lá bài này nằm trên tay, đối phương rút được quái thú sẽ kích hoạt: đưa lá bài này vào Mộ, loại bỏ lá bài đối phương vừa rút được.\n(2) Kỹ năng chủ động Mộ (1 lượt 1 lần): Triệu hồi Đặc biệt bản thân lên sân và nhận được \"quá tải\" (khi rời sân sẽ bị \"loại bỏ\").",
		[57241] = "KMR-Ghost",
		[57242] = "KMR-Ghost - Đoạt Hồn Rút Bài",
		[57243] = "1 lượt tối đa 2 lần, khi lá bài này nằm trên tay, đối phương rút được quái thú sẽ kích hoạt: đưa lá bài này vào Mộ, loại bỏ lá bài đối phương vừa rút được.",
		[57244] = "KMR-Ghost - Quá Tải Hồi Sinh",
		[57245] = "Kỹ năng chủ động Mộ (1 lượt 1 lần): Triệu hồi Đặc biệt bản thân lên sân và nhận được \"quá tải\" (khi rời sân sẽ bị \"loại bỏ\").",
		[57246] = "KMR-Zio-Ghost",
		[57247] = "[Chiến Binh - Dung Hợp - Hiệu Ứng]\n\"KMR-Zio\" + \"KMR-Ghost\"\n(1) Khi lá bài này trên sân, đối phương triệu hồi quái từ Bộ bài thêm sẽ kích hoạt: loại bỏ bản thân và quái đối phương vừa triệu hồi (xuyên qua tường chắn quái).\n(2) Kỹ năng chủ động (1 lượt 1 lần): Chọn 1 quái trên sân đối phương, loại bỏ bản thân và quái mục tiêu (xuyên qua tường chắn quái).",
		[57248] = "KMR-Zio-Ghost",
		[57249] = "KMR-Zio-Ghost - Linh Hồn Chặn Đứng",
		[57250] = "Khi lá bài này trên sân, đối phương triệu hồi quái từ Bộ bài thêm sẽ kích hoạt: loại bỏ bản thân và quái đối phương vừa triệu hồi (xuyên qua tường chắn quái).",
		[57251] = "KMR-Zio-Ghost - Đồng Quy Loại Bỏ",
		[57252] = "Kỹ năng chủ động (1 lượt 1 lần): Chọn 1 quái trên sân đối phương, loại bỏ bản thân và quái mục tiêu (xuyên qua tường chắn quái).",
		-- Rồng phá giới - Rồng phá hoại (40535) & Kỹ năng (14771)
		[35651] = "Rồng phá giới - Rồng phá hoại",
		[35654] = "Rồng phá giới - Rồng phá hoại",
		[57253] = "Rồng Phá Giới - Che Chở",
		[57254] = "Khi lá bài này còn trên sân; quái có từ khóa \"Kiếm Sĩ Diệt Rồng\" trên sân phe ta nhận Lá chắn quái vật (12008), Khiên ma thuật (12009), Lá chắn bẫy (12010).",
		-- Bó hoa tươi (21147) & Kỹ năng (14772)
		[57255] = "Bó hoa tươi",
		[57256] = "\"Không quan trọng bạn là ai.\nChúc những người phụ nữ trong gia đình bạn\ncó 1 ngày tràn ngập niềm vui, lúc nào cũng tươi trẻ,\nthành công trong công việc và hạnh phúc trong cuộc sống!\".",
		[57257] = "Bó hoa tươi",
		[57258] = "Bó hoa tươi",
		[57259] = "Kĩ năng chủ động (1 lượt 1 lần): Tung 1 đồng xu.\n- Nếu ngửa: phe ta và địch rút 1 lá bài.\n- Nếu úp: phe địch rút 1 lá bài, phe ta nhận 2000 thiệt hại.\n|\\yellow\\Hỏi: \"ủa tại sao phe địch được rút bài mà phe ta bị lại bị trừ LP?\"|\n|\\yellow\\Đáp: \"Bởi vì : 1 là chân thành đổi lấy chân thành.|\n|\\yellow\\2 là chân thành đổi lấy chân tướng sự thật\".|\n|\\yellow\\\"Tỉnh táo lên những người anh em,|\n|\\yellow\\mình đáng được trân trọng hơn thế - đừng làm lốp giống ad\".|",
		-- Chiến binh amazon cưỡi rồng bay harpie (40742) & Kỹ năng (14773, 14774)
		[57260] = "Chiến binh amazon cưỡi rồng bay harpie",
		[57261] = "[Chiến Binh - Dung Hợp - Hiệu Ứng]\n10084 + quái tộc chiến binh có từ khóa \"amazon\".\n(Lá bài này luôn được coi là có từ khóa \"amazon\" và \"harpie\".)\n(1) Dung Hợp Kỳ Linh.\n(2) Tăng 300 Công và Thủ với mỗi quái thú \"amazon\" trên sân phe ta. Tăng 300 Công với mỗi quái thú \"harpie\" trên sân phe ta.\n(3) Khi trên sân phe ta có quái \"harpie\" hoặc \"amazon\", nhận \"Tấn công trực tiếp\".\n(4) Kĩ năng chủ động (1 lượt 1 lần): Hy sinh bản thân, chọn 1 quái dung hợp có từ khóa \"harpie\" hoặc \"amazon\" trong extradeck, triệu hồi vô điều kiện lên sân.",
		[57262] = "Chiến binh amazon cưỡi rồng bay harpie",
		[57263] = "Chiến Binh Cưỡi Rồng - Tấn Công Trực Tiếp",
		[57264] = "Khi trên sân phe ta có quái \"harpie\" hoặc \"amazon\", nhận \"Tấn công trực tiếp\".",
		[57265] = "Chiến Binh Cưỡi Rồng - Triệu Hồi Dung Hợp",
		[57266] = "Kĩ năng chủ động (1 lượt 1 lần): Hy sinh bản thân, chọn 1 quái dung hợp có từ khóa \"harpie\" hoặc \"amazon\" trong extradeck, triệu hồi vô điều kiện lên sân.",
		-- Kiếm sĩ diệt rồng huyền thoại (40743) & Kỹ năng (14775, 14776, 14777)
		[57267] = "Kiếm sĩ diệt rồng huyền thoại",
		[57268] = "[Chiến Binh - Đồng Bộ - Hiệu Ứng]\n10058 + 1 quái điều chỉnh.\n(1) Quái đối phương bị giảm 200 ATK cho mỗi quái tộc Rồng trên sân và trong Mộ 2 bên.\n(2) Kĩ năng chủ động (1 lượt 1 lần): Bỏ 1 lá bài trên tay, Triệu Hồi Đặc Biệt 1 quái có từ khóa \"Kiếm Phá Hủy\" từ bộ bài lên sân.\n(3) Khi lá bài này bị phá hủy bởi chiến đấu hoặc hiệu quả: Phá hủy tất cả quái tộc Rồng trên sân đối phương (xuyên qua khiên bảo vệ).",
		[57269] = "Kiếm sĩ diệt rồng huyền thoại",
		[57270] = "Huyền Thoại Diệt Rồng - Uy Áp",
		[57271] = "Quái đối phương bị giảm 200 ATK cho mỗi quái tộc Rồng trên sân và trong Mộ 2 bên.",
		[57272] = "Kiếm Phá Hủy - Triệu Tập",
		[57273] = "Kĩ năng chủ động: 1 lượt 1 lần, bỏ 1 lá bài trên tay, triệu hồi đặc biệt 1 quái có từ khóa \"Kiếm Phá Hủy\" từ bộ bài lên sân.",
		[57274] = "Diệt Rồng Huyền Thoại - Phản Kích",
		[57275] = "Khi lá bài này bị phá hủy bởi chiến đấu hoặc hiệu quả, phá hủy tất cả quái tộc rồng trên sân đối phương (xuyên qua khiên bảo vệ).",
	}
	_G.CARD_NAME_OVERRIDES = CARD_NAME_OVERRIDES

	-- Ensure Str and ClientData.str always unescape \n to actual newline and use Linh Thach terms
	local _origStr = _G.Str
	_G.Str = function(sid, ...)
		if not sid then return "" end
		local numSid = tonumber(sid)
		if numSid and CARD_NAME_OVERRIDES[numSid] then
			return CARD_NAME_OVERRIDES[numSid]
		end
		if CARD_NAME_OVERRIDES[sid] then
			return CARD_NAME_OVERRIDES[sid]
		end
		local res = _origStr and _origStr(sid, ...)
		if (not res or res == "") and rawget(_G, "ClientData") and ClientData.str then
			res = ClientData.str(sid, ...)
		end
		if type(res) == "string" and string.find(res, "\\n") then
			res = string.gsub(res, "\\n", "\n")
		end
		return filterCurrencyText(res) or tostring(sid)
	end
	if rawget(_G, "ClientData") and ClientData.str then
		local _origCdStr = ClientData.str
		ClientData.str = function(sid, ...)
			if not sid then return "" end
			local numSid = tonumber(sid)
			if numSid and CARD_NAME_OVERRIDES[numSid] then
				return CARD_NAME_OVERRIDES[numSid]
			end
			if CARD_NAME_OVERRIDES[sid] then
				return CARD_NAME_OVERRIDES[sid]
			end
			local res = _origCdStr(sid, ...)
			if type(res) == "string" and string.find(res, "\\n") then
				res = string.gsub(res, "\\n", "\n")
			end
			return filterCurrencyText(res) or tostring(sid)
		end
	end



		-- Ensure all PVE attack/challenge inputs have _offlineMode = true
	local _origGenInputFromResp = ClientData.genInputFromResp
	ClientData.genInputFromResp = function(resp)
		local function ensureHasField(tbl, visited)
			if type(tbl) ~= "table" then return end
			visited = visited or {}
			if visited[tbl] then return end
			visited[tbl] = true
			if rawget(tbl, "HasField") == nil and tbl.HasField == nil then
				rawset(tbl, "HasField", function(self, k)
					return rawget(self, k) ~= nil or self[k] ~= nil
				end)
			end
			for _, v in pairs(tbl) do
				if type(v) == "table" then
					ensureHasField(v, visited)
				end
			end
		end
		ensureHasField(resp)
		local ret = _origGenInputFromResp(resp)
		if ret then
			ret._offlineMode = true
			if ret._player and (ret._player._crown == nil or ret._player._crown._infoId == 0) then
				if P and P._crown and P._crown._infoId and P._crown._infoId ~= 0 then
					ret._player._crown = P._crown
				elseif ClientData and ClientData._account then
					local gc = tonumber(ClientData._account.gold_cup) or 0
					local sc = tonumber(ClientData._account.silver_cup) or 0
					local bc = tonumber(ClientData._account.bronze_cup) or 0
					if gc > 0 then ret._player._crown = { _infoId = 7204, _num = gc }
					elseif sc > 0 then ret._player._crown = { _infoId = 7205, _num = sc }
					elseif bc > 0 then ret._player._crown = { _infoId = 7206, _num = bc }
					end
				end
			end
			if ret._opponent and (ret._opponent._crown == nil or ret._opponent._crown._infoId == 0) then
				local o = resp and (resp.opponent or resp._opponent)
				if o then
					local ogc = tonumber(o.gold_cup) or 0
					local osc = tonumber(o.silver_cup) or 0
					local obc = tonumber(o.bronze_cup) or 0
					if ogc > 0 then ret._opponent._crown = { _infoId = 7204, _num = ogc }
					elseif osc > 0 then ret._opponent._crown = { _infoId = 7205, _num = osc }
					elseif obc > 0 then ret._opponent._crown = { _infoId = 7206, _num = obc }
					end
				end
			end
			ret._offlineKind = rawget(resp, "_offlineKind") or "chapter"
			ret._randomSeed = ret._randomSeed or math.random(1, 65535)
			if ret._player and ret._player._troopCards then
				local curTroopIndex = (P and P._curTroopIndex) or 1
				local pTroop = (P and P._playerCard and P._playerCard._troops and P._playerCard._troops[curTroopIndex]) or {}
				local cardsList = (type(pTroop) == "table" and (pTroop._cards or pTroop)) or {}
				local troopMap = {}
				for _, card in ipairs(cardsList) do
					local cid = type(card) == "table" and (card._infoId or card.info_id) or card
					local num = type(card) == "table" and (card._num or card.num) or 1
					if cid and tonumber(cid) then
						troopMap[tonumber(cid)] = math.max(1, tonumber(num) or 1)
					end
				end

				local safeCards = {}
				local totalCount = 0
				for _, c in ipairs(ret._player._troopCards) do
					local cid = type(c) == "table" and (c.info_id or c._infoId) or c
					local num = type(c) == "table" and (c.num or c._num) or 1
					if cid and tonumber(cid) then
						cid = tonumber(cid)
						num = tonumber(num) or 1
						if (num <= 1) and troopMap[cid] then
							num = troopMap[cid]
						end
						num = math.max(1, num)
						table.insert(safeCards, { info_id = cid, num = num })
						totalCount = totalCount + num
					end
				end

				local fallbackCids = (Data._troopInfo and Data._troopInfo[1] and Data._troopInfo[1]._infoId) or { 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 20001, 20002, 20003, 20004, 20005, 30001, 30002, 30003 }
				while totalCount < 20 do
					for _, fcid in ipairs(fallbackCids) do
						if totalCount >= 20 then break end
						table.insert(safeCards, { info_id = fcid, num = 1 })
						totalCount = totalCount + 1
					end
				end
				ret._player._troopCards = safeCards
			end
			if ret._opponent and ret._opponent._troopCards then
				local safeCards = {}
				local totalOppo = 0
				for _, c in ipairs(ret._opponent._troopCards) do
					local cid = type(c) == "table" and (c.info_id or c._infoId) or c
					local num = type(c) == "table" and (c.num or c._num) or 1
					if cid and tonumber(cid) then
						cid = tonumber(cid)
						num = math.max(1, tonumber(num) or 1)
						table.insert(safeCards, { info_id = cid, num = num })
						totalOppo = totalOppo + num
					end
				end
				local fallbackCids = (Data._troopInfo and Data._troopInfo[1] and Data._troopInfo[1]._infoId) or { 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 20001, 20002, 20003, 20004, 20005, 30001, 30002, 30003 }
				while totalOppo < 20 do
					for _, fcid in ipairs(fallbackCids) do
						if totalOppo >= 20 then break end
						table.insert(safeCards, { info_id = fcid, num = 1 })
						totalOppo = totalOppo + 1
					end
				end
				ret._opponent._troopCards = safeCards
			end
			if ret._player and ret._player._troopLevels then
				local safeLevels = {}
				for _, lvl in ipairs(ret._player._troopLevels) do
					if type(lvl) == "table" and lvl.info_id then
						table.insert(safeLevels, lvl)
					elseif type(lvl) == "number" then
						table.insert(safeLevels, { info_id = lvl, level = 1 })
					end
				end
				ret._player._troopLevels = safeLevels
			end
			if ret._opponent and ret._opponent._troopLevels then
				local safeLevels = {}
				for _, lvl in ipairs(ret._opponent._troopLevels) do
					if type(lvl) == "table" and lvl.info_id then
						table.insert(safeLevels, lvl)
					elseif type(lvl) == "number" then
						table.insert(safeLevels, { info_id = lvl, level = 1 })
					end
				end
				ret._opponent._troopLevels = safeLevels
			end
		end
		return ret
	end

	ClientData.loadLCRes = function(path)
		jsres:load(path)

		return {}
	end

	local RESIDENT_CONTAINERS = {
		["battle.jpm"] = true,
		["battle.png.sfb"] = true,
		["bat_loading.jpm"] = true,
		["bat_loading.png.sfb"] = true,
		["city.jpm"] = true,
		["city.png.sfb"] = true,
		["general.jpm"] = true,
		["general.png.sfb"] = true,
		["avatar.jpm"] = true,
		["avatar.png.sfb"] = true,
		["props.jpm"] = true,
		["props.png.sfb"] = true,
		["find.jpm"] = true,
		["find.png.sfb"] = true,
	}

	ClientData.unloadLCRes = function(names)
		if type(names) ~= "table" then
			return
		end

		for _, name in ipairs(names) do
			if not RESIDENT_CONTAINERS[name] then
				jsres:unloadContainer(name)
				ClientData._lcres[name] = nil
			end
		end
	end

	-- Web Chat, Room, Bonus and Nickname handlers
		-- Gift Code Exchange Hook
	ClientData.sendUserGiftExchange = function(code)
		local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local cleanCode = string.gsub(code or "", "^%s*(.-)%s*$", "%1")
		if cleanCode == "" then
			ClientView.getActiveIndicator():hide()
			ToastManager.push(Str(STR.INPUT_EXCHANGE_CODE))
			return
		end

		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("redeem_gift_code", { account_id = accId, code = cleanCode }, function(rawRes)
				ClientView.getActiveIndicator():hide()
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and res.code == 200 then
					local rewardsList = {}
					if res.rewards and #res.rewards > 0 then
						for _, rw in ipairs(res.rewards) do
							local infoId = rw.info_id or Data.ResType.ingot
							local num = rw.num or 0
							table.insert(rewardsList, {
								info_id = infoId,
								num = num,
								is_fragment = rw.is_fragment or false,
								level = rw.level or 1
							})
							if infoId and infoId >= 10000 and P and P._playerCard then
								pcall(function() P._playerCard:addCard(infoId, num) end)
							end
						end
					else
						table.insert(rewardsList, {
							info_id = Data.ResType.gold,
							num = 1000000,
							is_fragment = false,
							level = 1
						})
					end

					-- Close ExchangeCodeForm if open
					local curScene = lc._runningScene
					if curScene and curScene._scene then
						for _, child in ipairs(curScene._scene:getChildren()) do
							if child.__cname == "ExchangeCodeForm" or child.__cname == "RenameForm" then
								if child._editor and child._onExchange then
									pcall(function() child:removeFromParent() end)
								end
							end
						end
					end

					-- Dispatch message to listener (ExchangeCodeForm:onMsg)
					local giftExt = User_pb and User_pb.SglUserMsg and User_pb.SglUserMsg.user_claim_gift_resp
					local msg = {
						type = SglMsgType_pb and SglMsgType_pb.PB_TYPE_USER_CLAIM_GIFT or 313,
						status = 0,
						Extensions = {}
					}
					if giftExt then
						msg.Extensions[giftExt] = rewardsList
					end
					msg.Extensions["user_claim_gift_resp"] = rewardsList
					msg.Extensions[305] = rewardsList

					local handled = false
					if ClientData.onMsg then
						handled = ClientData.onMsg(msg)
					end
					if not handled then
						require("RewardPanel").create(rewardsList):show()
					end

					-- Ensure player resources in memory match server balances
					if res.new_gem and P then
						P._ingot = res.new_gem
					end
					if res.new_gold and P then
						P._gold = res.new_gold
					end
					lc.sendEvent(Data.Event.resource_dirty)
					lc.sendEvent(Data.Event.card_dirty)
					if ClientView.getMenuUI() then
						ClientView.getMenuUI():updateResource()
					end

					ToastManager.push(res.msg or "Nhập mã quà tặng thành công!")
				else
					local errMsg = (res and res.msg) or "Mã quà tặng không hợp lệ!"
					ToastManager.push(errMsg)
				end
			end)
		else
			ClientView.getActiveIndicator():hide()
			ToastManager.push("Lỗi kết nối máy chủ!")
		end
	end

	ClientData.sendChangeName = function(newName)
		local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("change_nickname", { account_id = accId, name = newName }, function(rawRes)
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				local ind = ClientView.getActiveIndicator()
				if ind and ind.hide then ind:hide() end
				if res and res.code == 200 then
					if P then
						P._name = newName
						P._characterName = newName
						if P.changeName then pcall(function() P:changeName(newName) end) end
						if P._changeNameCount then
							P._changeNameCount = P._changeNameCount + 1
						end
					end
					if ClientData._account then
						ClientData._account.character_name = newName
					end
					if ClientView.getMenuUI() and ClientView.getMenuUI().updateUserName then
						pcall(function() ClientView.getMenuUI():updateUserName() end)
					end
					-- Hide RenameForm or ChangeCharacterPanel safely
					if lc._runningScene then
						local ch = lc._runningScene:getChildren()
						for i = 1, #ch do
							local child = ch[i]
							if child._panelName == "RenameForm" or (child.__cname and child.__cname == "RenameForm") or child._panelName == "ChangeCharacterPanel" then
								pcall(function() child:hide() end)
							end
						end
					end
					pcall(function()
						lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.change_name_dirty))
						lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.name_dirty))
					end)
					ToastManager.push("Đổi tên nhân vật thành công!")
				else
					ToastManager.push((res and res.msg) or "Đổi biệt hiệu thất bại!")
				end
			end)
		else
			local ind = ClientView.getActiveIndicator()
			if ind and ind.hide then ind:hide() end
			ToastManager.push("Lỗi kết nối máy chủ!")
		end
	end
	ClientData.sendChangeNameGuide = ClientData.sendChangeName

	local function recordCheckinClaim(bonus)
		pcall(function()
			local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
			local api = jsbridge and jsbridge.object("jdzcApi")
			if not api or not api.post or not bonus then return end
			local bid = type(bonus) == "table" and (bonus._infoId or bonus._id) or tonumber(bonus)
			if not bid or bid <= 0 then return end

			local binfo = Data._bonusInfo and Data._bonusInfo[bid]
			local btype = (type(bonus) == "table" and bonus._type) or (binfo and binfo._type)
			local ctype = nil
			local dayVal = binfo and binfo._val or 0

			if btype == Data.BonusType.week_checkin or (bid >= 3001 and bid <= 3007) then
				ctype = 2
				if dayVal <= 0 and bid >= 3001 and bid <= 3007 then dayVal = bid - 3000 end
			elseif btype == Data.BonusType.month_checkin or (bid >= 6001 and bid <= 6400) then
				ctype = 1
			end

			-- ONLY record if it is actually a week or month checkin bonus!
			if not ctype then return end

			api:post("checkin", { account_id = accId, checkin_type = ctype, day_index = bid, day_val = dayVal }, function(rawRes)
				local r = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if r and r.code == 200 then
					ClientData._claimedCheckins = ClientData._claimedCheckins or {}
					ClientData._claimedCheckins[bid] = true
					if dayVal > 0 then ClientData._claimedCheckins[dayVal] = true end
					ClientData._claimedCheckinsToday = ClientData._claimedCheckinsToday or {}
					ClientData._claimedCheckinsToday[bid] = { checkin_type = ctype, day_val = dayVal }
					if P and P._playerBonus then
						local ob = require("OnlineBridge")
						if ob and ob.syncCheckinBonuses then
							ob.syncCheckinBonuses(P, ClientData._claimedCheckinsList or {})
						end
					end
				end
			end)
		end)
	end
	local oldClaimBonus = ClientData.claimBonus
	ClientData.claimBonus = function(bonus)
		local res = oldClaimBonus and oldClaimBonus(bonus)
		recordCheckinClaim(bonus)
		return res
	end
	local oldSendClaimBonus = ClientData.sendClaimBonus
	ClientData.sendClaimBonus = function(bonusId)
		recordCheckinClaim(bonusId)
		if oldSendClaimBonus then oldSendClaimBonus(bonusId) end
	end

	-- ==========================================================
	-- CHAT SYSTEM HOOK (Usable from Lv1, GR Announcement Relay)
	-- ==========================================================
	pcall(function()
		if Data and Data._globalInfo then
			Data._globalInfo._unlockChat = 1
			Data._globalInfo._chatCD = 0
		end
	end)

	ClientData.sendChat = function(chatType, targetId, content)
		if not content or content == "" then return end
		local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local myName = (P and P._name) or "Duelist"
		local myLevel = (P and P._level) or 1
		local myAvatar = (P and P._avatar) or 201
		local myVip = (P and P._vip) or 0
		local myUnionId = (P and P._unionId) or (P and P._playerUnion and P._playerUnion:getMyUnion() and P._playerUnion:getMyUnion()._id) or (targetId or 0)

		local localId = "c_" .. tostring(accId) .. "_" .. tostring(os.time()) .. "_" .. tostring(math.random(1000, 9999))
		ClientData._knownMsgIds = ClientData._knownMsgIds or {}
		ClientData._knownMsgIds[localId] = true

		local isUnionChat = (chatType == 4 or chatType == 2 or chatType == (Chat_pb and Chat_pb.PB_CHAT_UNION or 2) or chatType == Data.MsgType.union)
		local msgType = isUnionChat and Data.MsgType.union or Data.MsgType.world

		-- 1. Push directly into local player message queue
		local ok, err = pcall(function()
			if P and P._playerMessage then
				local myGc = (ClientData._account and tonumber(ClientData._account.gold_cup)) or (P and P._goldCup) or 0
				local mySc = (ClientData._account and tonumber(ClientData._account.silver_cup)) or (P and P._silverCup) or 0
				local myBc = (ClientData._account and tonumber(ClientData._account.bronze_cup)) or (P and P._bronzeCup) or 0
				local myCrown = nil
				if myGc > 0 then myCrown = { info_id = 7204, num = myGc }
				elseif mySc > 0 then myCrown = { info_id = 7205, num = mySc }
				elseif myBc > 0 then myCrown = { info_id = 7206, num = myBc }
				elseif P and P._crown and P._crown._infoId and P._crown._infoId > 0 then
					myCrown = { info_id = P._crown._infoId, num = P._crown._num or 1 }
				end

				local uinfo = require("User").create({
					id = accId,
					name = myName,
					level = myLevel,
					avatar = myAvatar,
					vip = myVip,
					crown = myCrown,
					gold_cup = myGc,
					silver_cup = mySc,
					bronze_cup = myBc,
					gold = 0, grain = 0, ingot = 0, exp = 0, trophy = 800, shield = 0,
					union_id = myUnionId, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
					last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
				})
				if myCrown then
					uinfo._crown = { _infoId = myCrown.info_id, _num = myCrown.num }
				end
				local msgObj = {
					_id = localId,
					_clientMsgId = localId,
					_timestamp = os.time(),
					_user = uinfo,
					_type = msgType,
					_content = content,
					_items = {},
					_unionId = myUnionId,
					_goldCup = myGc,
					_silverCup = mySc,
					_bronzeCup = myBc
				}
				local wlist = P._playerMessage._msgAll[msgType]
				if wlist then
					if #wlist >= (ClientData.MAX_MSG_COUNT or 50) then
						table.remove(wlist, #wlist)
					end
					table.insert(wlist, 1, msgObj)
				end
				P._playerMessage:sendMessageEvent(P._playerMessage.Event.msg_new, msgType, 1)
				if msgType == Data.MsgType.union then
					pcall(function()
						if lc and lc.Dispatcher and Data and Data.Event then
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.message, { _event = PlayerMessage.Event.msg_new, _param = 1 }))
						end
					end)
				end
				pcall(function()
					if ClientData._chatPanel and ClientData._chatPanel._isPop then
						ClientData._chatPanel:resetList()
					end
				end)
			end
		end)

		-- 2. Send via api:post (single authoritative request with real player info and client_msg_id)
		pcall(function()
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.post then
				local myGc = (ClientData._account and tonumber(ClientData._account.gold_cup)) or (P and P._goldCup) or 0
				local mySc = (ClientData._account and tonumber(ClientData._account.silver_cup)) or (P and P._silverCup) or 0
				local myBc = (ClientData._account and tonumber(ClientData._account.bronze_cup)) or (P and P._bronzeCup) or 0
				local myCid = (myGc > 0 and 7204) or (mySc > 0 and 7205) or (myBc > 0 and 7206) or 0
				local myCnum = (myGc > 0 and myGc) or (mySc > 0 and mySc) or (myBc > 0 and myBc) or 0
				api:post("chat_send", {
					account_id = accId,
					name = myName,
					level = myLevel,
					avatar = myAvatar,
					gold_cup = myGc,
					silver_cup = mySc,
					bronze_cup = myBc,
					crown_id = myCid,
					crown_num = myCnum,
					content = content,
					client_msg_id = localId,
					union_id = myUnionId,
					type = (msgType == Data.MsgType.union and 4 or 1)
				})
			end
		end)
	end

	-- Event-driven chat & announcements via WebSocket / History
	_G._pendingChatQueue = _G._pendingChatQueue or {}

	local function getChatPanel()
		local cp = (ClientView and ClientView.getChatPanel and ClientView.getChatPanel()) or ClientData._chatPanel
		if cp then ClientData._chatPanel = cp end
		return cp
	end
	ClientData.getChatPanel = getChatPanel

	local function processChatMessage(id, ts, accId, name, level, avatar, content, msgType, cardId, clientMsgId, crownId, crownNum, isBatch, unionId)
		if not content or content == "" then return end

		if not P or not P._playerMessage or not P._playerMessage._msgAll then
			_G._pendingChatQueue = _G._pendingChatQueue or {}
			table.insert(_G._pendingChatQueue, {
				id = id, ts = ts, accId = accId, name = name, level = level, avatar = avatar,
				content = content, msgType = msgType, cardId = cardId, clientMsgId = clientMsgId,
				crownId = crownId, crownNum = crownNum, unionId = unionId
			})
			return
		end

		local isBattle = (msgType == 3 or msgType == Data.MsgType.battle)
		if not isBattle then
			if type(content) == "table" and (content.replay_id or content.battle_data or content.opponent_name) then
				isBattle = true
			elseif type(content) == "string" and (content:find('"replay_id"') or content:find('chia sẻ một trận chiến')) then
				isBattle = true
			end
		end

		-- System announcements / Tin Nhanh: type 2, OR account_id == 0, OR name is 'Hệ Thống', OR system patterns
		local isSystem = not isBattle and (msgType == 2 or msgType == Data.MsgType.bulletin or accId == 0 or name == "Hệ Thống"
			or (type(content) == "string" and (content:find("%[THÔNG BÁO%]") or content:find("%[KẾT TOÁN%]") or content:find("%[Tri ân%]"))))

		-- Guild Chat: type 4, OR (msgType == Data.MsgType.union and not isSystem)
		local isUnion = not isBattle and not isSystem and (msgType == 4 or msgType == Data.MsgType.union or (msgType == 2 and tonumber(unionId or 0) > 0 and accId ~= 0 and name ~= "Hệ Thống"))

		local targetType = isBattle and Data.MsgType.battle or (isSystem and Data.MsgType.bulletin or (isUnion and Data.MsgType.union or Data.MsgType.world))

		local myUnionId = (P and P._unionId) or (P and P._playerUnion and P._playerUnion:getMyUnion() and P._playerUnion:getMyUnion()._id) or 0
		local msgUnionId = tonumber(unionId) or 0

		-- Strict guild chat isolation:
		if targetType == Data.MsgType.union then
			if myUnionId <= 0 or (msgUnionId > 0 and msgUnionId ~= myUnionId) then
				return
			end
		end

		local targetList = P._playerMessage._msgAll[targetType]
		if not targetList then return end

		local bData = nil
		if isBattle then
			if type(content) == "table" then
				bData = content
			elseif type(content) == "string" and (content:sub(1, 1) == "{" or content:find('"replay_id"')) then
				local ok, parsed = pcall(function() return require("json").decode(content) end)
				if ok and type(parsed) == "table" then
					bData = parsed
				end
			end
		end

		local repId = (bData and bData.replay_id) or clientMsgId or tostring(id)
		local idStr = (id and tonumber(id) and tonumber(id) > 0) and tostring(id) or nil
		local cIdStr = (clientMsgId and clientMsgId ~= "") and tostring(clientMsgId) or nil
		local repIdStr = (isBattle and repId and tostring(repId) ~= "") and tostring(repId) or nil

		-- Robust deduplication check
		for _, existing in ipairs(targetList) do
			local exId = existing._id and tostring(existing._id) or nil
			local exCId = (existing._clientMsgId and tostring(existing._clientMsgId)) or nil
			local exRepId = (existing._log and existing._log._id and tostring(existing._log._id)) or (existing._replayId and tostring(existing._replayId)) or nil

			local match = false
			if idStr and exId and exId == idStr then match = true end
			if cIdStr and (exId == cIdStr or exCId == cIdStr) then match = true end
			if repIdStr and (exId == repIdStr or exRepId == repIdStr) then match = true end

			if match then
				if idStr and exId ~= idStr then
					existing._id = idStr
				end
				return
			end
		end

		local realTs = ts or os.time()
		if realTs > 10000000000 then
			realTs = math.floor(realTs / 1000)
		end

		local cid = tonumber(crownId) or 0
		local cnum = tonumber(crownNum) or 1
		local crownObj = nil
		if cid > 0 then
			crownObj = { _infoId = cid, _num = cnum }
		elseif accId and P and P._id and accId == P._id then
			local myGc = (ClientData._account and tonumber(ClientData._account.gold_cup)) or (P and P._goldCup) or 0
			local mySc = (ClientData._account and tonumber(ClientData._account.silver_cup)) or (P and P._silverCup) or 0
			local myBc = (ClientData._account and tonumber(ClientData._account.bronze_cup)) or (P and P._bronzeCup) or 0
			if myGc > 0 then crownObj = { _infoId = 7204, _num = myGc }
			elseif mySc > 0 then crownObj = { _infoId = 7205, _num = mySc }
			elseif myBc > 0 then crownObj = { _infoId = 7206, _num = myBc }
			elseif P._crown and P._crown._infoId and P._crown._infoId > 0 then
				crownObj = { _infoId = P._crown._infoId, _num = P._crown._num or 1 }
			end
		end

		local uinfo = require("User").create({
			id = accId or (isSystem and 0 or 1),
			name = (name and name ~= "") and name or (isSystem and "Hệ Thống" or "Duelist"),
			level = level or (isSystem and 99 or 1),
			avatar = avatar or (isSystem and 101 or 201),
			crown = crownObj and { info_id = crownObj._infoId, num = crownObj._num } or nil,
			gold_cup = (crownObj and crownObj._infoId == 7204 and crownObj._num) or 0,
			silver_cup = (crownObj and crownObj._infoId == 7205 and crownObj._num) or 0,
			bronze_cup = (crownObj and crownObj._infoId == 7206 and crownObj._num) or 0,
			vip = 0, gold = 0, grain = 0, ingot = 0, exp = 0, trophy = 800, shield = 0,
			union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
			last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
		})
		if crownObj then
			uinfo._crown = crownObj
		end

		local msgObj = nil
		if isBattle then
			local oppoName = (bData and bData.opponent_name) or "Opponent"
			local oppoLevel = (bData and bData.opponent_level) or 1
			local oppoAvatar = (bData and bData.opponent_avatar) or 201
			local bResult = (bData and bData.result) or 1
			local bResultType = (bResult == 1) and Data.BattleResult.win or Data.BattleResult.lose
			local shareText = (bData and bData.text) or (not bData and content) or ""
			local roundNum = (bData and bData.round) or 5
			local trophyNum = (bData and bData.trophy_change) or 25

			local opp_gc = (bData and tonumber(bData.opponent_gold_cup)) or 0
			local opp_sc = (bData and tonumber(bData.opponent_silver_cup)) or 0
			local opp_bc = (bData and tonumber(bData.opponent_bronze_cup)) or 0
			local oppCrown = nil
			if opp_gc > 0 then oppCrown = { info_id = 7204, num = opp_gc }
			elseif opp_sc > 0 then oppCrown = { info_id = 7205, num = opp_sc }
			elseif opp_bc > 0 then oppCrown = { info_id = 7206, num = opp_bc }
			end

			local oppoUser = require("User").create({
				id = 9999,
				name = oppoName,
				level = oppoLevel,
				avatar = oppoAvatar,
				crown = oppCrown,
				gold_cup = opp_gc,
				silver_cup = opp_sc,
				bronze_cup = opp_bc,
				vip = 0, gold = 0, grain = 0, ingot = 0, exp = 0, trophy = 800, shield = 0,
				union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
				last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
			})
			if oppCrown then
				oppoUser._crown = { _infoId = oppCrown.info_id, _num = oppCrown.num }
			end

			local logObj = {
				_id = repId,
				_replayId = repId,
				_timestamp = realTs,
				_resultType = bResultType,
				_battleType = Battle_pb.PB_BATTLE_WORLD_LADDER,
				_isAvailable = true,
				_trophy = trophyNum,
				_player = uinfo,
				_opponent = oppoUser,
				isLocal = function() return false end
			}
			logObj._log = logObj

			local formattedText = shareText
			if formattedText == "" or formattedText == "Đã chia sẻ một trận chiến kịch tính!" then
				formattedText = string.format("|%s| đã chia sẻ một trận chiến kịch tính!", name or "Duelist")
			else
				formattedText = string.format("|%s|: %s", name or "Duelist", shareText)
			end

			msgObj = {
				_id = idStr or cIdStr or repIdStr or os.time(),
				_clientMsgId = cIdStr,
				_timestamp = realTs,
				_user = uinfo,
				_sender = uinfo,
				_opponent = oppoUser,
				_log = logObj,
				_replayId = repId,
				_resultType = bResultType,
				_round = roundNum,
				_type = Data.MsgType.battle,
				_content = formattedText,
				_items = {},
				_watchIds = setmetatable({}, { __index = function() return true end }),
				_watchIdsCount = 1,
				_likeIds = {},
				_likeIdsCount = 0
			}
		else
			local items = {}
			if cardId and tonumber(cardId) and tonumber(cardId) > 0 then
				table.insert(items, { _infoId = tonumber(cardId), _num = 1 })
			end

			msgObj = {
				_id = idStr or cIdStr or os.time(),
				_clientMsgId = cIdStr,
				_timestamp = realTs,
				_user = uinfo,
				_type = targetType,
				_content = content,
				_items = items,
				_goldCup = (crownObj and crownObj._infoId == 7204 and crownObj._num) or 0,
				_silverCup = (crownObj and crownObj._infoId == 7205 and crownObj._num) or 0,
				_bronzeCup = (crownObj and crownObj._infoId == 7206 and crownObj._num) or 0
			}
		end

		if #targetList >= (ClientData.MAX_MSG_COUNT or 100) then
			table.remove(targetList, #targetList)
		end
		table.insert(targetList, 1, msgObj)

		if not isBatch then
			P._playerMessage:sendMessageEvent(P._playerMessage.Event.msg_new, targetType, 1)
			if targetType == Data.MsgType.union then
				pcall(function()
					if lc and lc.Dispatcher and Data and Data.Event then
						lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.message, { _event = PlayerMessage.Event.msg_new, _param = 1 }))
					end
				end)
			end
		end

		if not isBatch then
			pcall(function()
				local cp = (ClientView and ClientView.getChatPanel and ClientView.getChatPanel()) or ClientData._chatPanel
				if cp and cp._isPop and cp._contentBg and cp._contentBg._focusTabIndex == targetType then
					cp:resetList()
				end
			end)
		end
	end

	_G.addRawChatMessage = processChatMessage

	local function flushPendingChatQueue()
		if not P or not P._playerMessage or not P._playerMessage._msgAll then return end
		if _G._pendingChatQueue and #_G._pendingChatQueue > 0 then
			local queue = _G._pendingChatQueue
			_G._pendingChatQueue = {}
			for _, it in ipairs(queue) do
				processChatMessage(it.id, it.ts, it.accId, it.name, it.level, it.avatar, it.content, it.msgType, it.cardId, it.clientMsgId, it.crownId, it.crownNum, true, it.unionId or 0)
			end
			pcall(function()
				local cp = getChatPanel()
				if cp and cp._isPop then
					cp:resetList()
				end
			end)
		end
	end
	_G.flushPendingChatQueue = flushPendingChatQueue

	_G.processIncomingChats = function()
		local q = _G._incomingChatQueue
		_G._incomingChatQueue = nil
		if q and #q > 0 then
			for _, m in ipairs(q) do
				local cardId = m.card_id or (m.items and m.items[1] and (m.items[1].info_id or m.items[1]._infoId)) or 0
				local contentVal = m.content or m.msg or (m.battle_data and require("json").encode(m.battle_data)) or ""
				local crownId = m.crown_id or (m.crown and (m.crown.info_id or m.crown._infoId)) or 0
				local crownNum = m.crown_num or (m.crown and (m.crown.num or m.crown._num)) or 0
				processChatMessage(m.id or 0, m.timestamp or os.time(), m.account_id or 1, m.name or "", m.level or 1, m.avatar or 201, contentVal, m.type or 1, cardId, m.client_msg_id or "", crownId, crownNum, false, m.union_id or 0)
			end
			pcall(flushPendingChatQueue)
		end
	end

	_G.processIncomingChatsJson = function(jsonStr)
		if not jsonStr or jsonStr == "" then return end
		local ok, q = pcall(function() return require("json").decode(jsonStr) end)
		if ok and q and #q > 0 then
			for _, m in ipairs(q) do
				local cardId = m.card_id or (m.items and m.items[1] and (m.items[1].info_id or m.items[1]._infoId)) or 0
				local contentVal = m.content or m.msg or (m.battle_data and require("json").encode(m.battle_data)) or ""
				local crownId = m.crown_id or (m.crown and (m.crown.info_id or m.crown._infoId)) or 0
				local crownNum = m.crown_num or (m.crown and (m.crown.num or m.crown._num)) or 0
				processChatMessage(m.id or 0, m.timestamp or os.time(), m.account_id or 1, m.name or "", m.level or 1, m.avatar or 201, contentVal, m.type or 1, cardId, m.client_msg_id or "", crownId, crownNum, false, m.union_id or 0)
			end
			pcall(flushPendingChatQueue)
		end
	end
	local function pollChatHistory()
		pcall(flushPendingChatQueue)
		pcall(function()
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.post then
				api:post("chat_history", {}, function(rawRes)
					local res = rawRes
					if type(res) == "string" then
						local ok, parsed = pcall(function() return require("json").decode(res) end)
						if ok and parsed then res = parsed end
					end
					if res and res.messages and #res.messages > 0 then
						for _, m in ipairs(res.messages) do
							local cardId = m.card_id or (m.items and m.items[1] and (m.items[1].info_id or m.items[1]._infoId)) or 0
							local contentVal = m.content or m.msg or (m.battle_data and require("json").encode(m.battle_data)) or ""
							local crownId = m.crown_id or (m.crown and (m.crown.info_id or m.crown._infoId)) or 0
							local crownNum = m.crown_num or (m.crown and (m.crown.num or m.crown._num)) or 0
							processChatMessage(m.id or 0, m.timestamp or os.time(), m.account_id or 1, m.name or "", m.level or 1, m.avatar or 201, contentVal, m.type or 1, cardId, m.client_msg_id or "", crownId, crownNum, true, m.union_id or 0)
						end
						pcall(flushPendingChatQueue)

						-- Clean sort and deduplicate all msg lists by timestamp DESC
						if P and P._playerMessage and P._playerMessage._msgAll then
							local worldList = P._playerMessage._msgAll[Data.MsgType.world]
							if worldList and type(worldList) == "table" then
								local cleanWorld = {}
								local seen = {}
								for _, m in ipairs(worldList) do
									if m._type ~= Data.MsgType.battle and m._type ~= Data.MsgType.bulletin and m._log == nil and m._replayId == nil
										and not (type(m._content) == "string" and (m._content:find('"replay_id"') or m._content:find('chia sẻ một trận chiến')))
										and not (type(m._content) == "table" and (m._content.replay_id or m._content.battle_data)) then
										local uid = (m._id and tostring(m._id)) or (m._clientMsgId and tostring(m._clientMsgId))
										if not uid or not seen[uid] then
											if uid then seen[uid] = true end
											table.insert(cleanWorld, m)
										end
									end
								end
								for i = #worldList, 1, -1 do worldList[i] = nil end
								for i, m in ipairs(cleanWorld) do worldList[i] = m end
							end

							local unionList = P._playerMessage._msgAll[Data.MsgType.union]
							if unionList and type(unionList) == "table" then
								local myUnionId = (P and P._unionId) or (P and P._playerUnion and P._playerUnion:getMyUnion() and P._playerUnion:getMyUnion()._id) or 0
								local cleanUnion = {}
								local seenUnion = {}
								for _, m in ipairs(unionList) do
									local isSys = (m._user and (m._user._id == 0 or m._user._name == "Hệ Thống"))
										or (type(m._content) == "string" and (m._content:find("%[THÔNG BÁO%]") or m._content:find("%[KẾT TOÁN%]") or m._content:find("%[Tri ân%]")))
									local msgUnionId = (m._unionId and tonumber(m._unionId)) or 0
									local isValidUnion = not isSys and m._type == Data.MsgType.union
									if isValidUnion and myUnionId > 0 and msgUnionId > 0 and msgUnionId ~= myUnionId then
										isValidUnion = false
									end
									if isValidUnion then
										local uid = (m._id and tostring(m._id)) or (m._clientMsgId and tostring(m._clientMsgId))
										if not uid or not seenUnion[uid] then
											if uid then seenUnion[uid] = true end
											table.insert(cleanUnion, m)
										end
									end
								end
								for i = #unionList, 1, -1 do unionList[i] = nil end
								for i, m in ipairs(cleanUnion) do unionList[i] = m end
							end

							local bulletinList = P._playerMessage._msgAll[Data.MsgType.bulletin]
							if bulletinList and type(bulletinList) == "table" then
								local cleanBulletin = {}
								local seenBulletin = {}
								for _, m in ipairs(bulletinList) do
									if m._type == Data.MsgType.bulletin then
										local uid = (m._id and tostring(m._id)) or (m._clientMsgId and tostring(m._clientMsgId))
										if not uid or not seenBulletin[uid] then
											if uid then seenBulletin[uid] = true end
											table.insert(cleanBulletin, m)
										end
									end
								end
								for i = #bulletinList, 1, -1 do bulletinList[i] = nil end
								for i, m in ipairs(cleanBulletin) do bulletinList[i] = m end
							end

							for _, list in pairs(P._playerMessage._msgAll) do
								if type(list) == "table" and #list > 1 then
									table.sort(list, function(a, b)
										local tsA = a._timestamp or 0
										local tsB = b._timestamp or 0
										if tsA ~= tsB then return tsA > tsB end
										return (tonumber(a._id) or 0) > (tonumber(b._id) or 0)
									end)
								end
							end
						end

						local cp = (ClientView and ClientView.getChatPanel and ClientView.getChatPanel()) or ClientData._chatPanel
						if cp and cp._isPop then
							cp:resetList()
						end
					end
				end)
			end
		end)
	end
	ClientData.pollChatHistory = pollChatHistory

	lc.addEventListener(Data.Event.login, function()
		pcall(function()
			if ClientData._account and P then
				P._reputation = tonumber(ClientData._account.reputation) or 50
			end
			if ClientData._account and ClientData._account.props and P and P._propBag then
				for pid, pcount in pairs(ClientData._account.props) do
					local iid = tonumber(pid) or 0
					if iid > 0 then
						local curNum = (P._propBag._props[iid] and P._propBag._props[iid]._num) or 0
						local diff = (tonumber(pcount) or 0) - curNum
						if diff ~= 0 then
							P._propBag:changeProps(iid, diff)
						end
					end
				end
			end
			if ClientData.pollChatHistory then
				ClientData.pollChatHistory()
			end
			if ClientData.restoreSurvivalExState then
				ClientData.restoreSurvivalExState()
			end
		end)
	end)

	local origReplaceCityScene = ClientData.replaceCityScene
	ClientData.replaceCityScene = function(...)
		pcall(flushPendingChatQueue)
		pcall(function()
			if ClientData.pollChatHistory then
				ClientData.pollChatHistory()
			end
			if ClientData.restoreSurvivalExState then
				ClientData.restoreSurvivalExState()
			end
		end)
		if origReplaceCityScene then return origReplaceCityScene(...) end
	end

	_G.onReceiveWsChatMessage = function(rawMsg)
		local m = rawMsg
		if type(m) == "string" then
			local ok, parsed = pcall(function() return require("json").decode(m) end)
			if ok and parsed then m = parsed end
		end
		if type(m) == "table" then
			local cardId = m.card_id or (m.items and m.items[1] and (m.items[1].info_id or m.items[1]._infoId)) or 0
			local contentVal = m.content or m.msg or (m.battle_data and require("json").encode(m.battle_data)) or ""
			local crownId = m.crown_id or (m.crown and (m.crown.info_id or m.crown._infoId)) or 0
			local crownNum = m.crown_num or (m.crown and (m.crown.num or m.crown._num)) or 0
			processChatMessage(m.id or 0, m.timestamp or os.time(), m.account_id or 1, m.name or "", m.level or 1, m.avatar or 201, contentVal, m.type or 1, cardId, m.client_msg_id or "", crownId, crownNum, false, m.union_id or 0)
		end
	end
	-- Flush any pending WS messages queued before Lua boot
	pcall(function()
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.flushPendingChat then
			api:flushPendingChat()
		end
	end)

	-- ==========================================================
	-- CUSTOM DUEL ROOM REAL-TIME NETWORKING
	-- ==========================================================
	local function formatUserInfo(u)
		if not u then return nil end
		local info = {
			id = tonumber(u.id) or 1,
			name = tostring(u.name or "Duelist"),
			level = tonumber(u.level) or 50,
			avatar = tonumber(u.avatar) or 201,
			gold = tonumber(u.gold) or 100000,
			grain = 100000,
			ingot = tonumber(u.ingot) or 10000,
			exp = 0,
			trophy = tonumber(u.trophy) or 800,
			vip = tonumber(u.vip) or 0,
			shield = 0,
			union_id = 0,
			union_name = "",
			union_title = 0,
			union_avatar = 0,
			union_tag = "",
			last_login = os.time() * 1000,
			rid = 10001,
			privilege = 0,
			month_card = 0
		}
		makeProtobufCompatible(info)
		return info
	end

	local function buildRoomMsgFromData(serverRoom)
		local myId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local roomMsg = {
			id = tonumber(serverRoom.code or serverRoom.id) or 100000,
			match_hp = tonumber(serverRoom.match_hp) or 8000,
			type = tonumber(serverRoom.type) or Data.RoomType.normal,
			user_id = myId,
			creator = {
				id = tonumber(serverRoom.creator_id) or 1,
				info = formatUserInfo(serverRoom.creator)
			}
		}
		if serverRoom.playerO then
			roomMsg.playerO = {
				id = tonumber(serverRoom.playerO.id) or 1,
				win = tonumber(serverRoom.playerO.win) or 0,
				is_online = true,
				info = formatUserInfo(serverRoom.playerO)
			}
		end
		if serverRoom.playerA then
			roomMsg.playerA = {
				id = tonumber(serverRoom.playerA.id) or 1,
				win = tonumber(serverRoom.playerA.win) or 0,
				is_online = true,
				info = formatUserInfo(serverRoom.playerA)
			}
		end
		if serverRoom.playerB then
			roomMsg.playerB = {
				id = tonumber(serverRoom.playerB.id) or 1,
				win = tonumber(serverRoom.playerB.win) or 0,
				is_online = true,
				info = formatUserInfo(serverRoom.playerB)
			}
		end
		makeProtobufCompatible(roomMsg)
		return roomMsg
	end

	ClientData.syncRoomData = function(serverRoom)
		if not serverRoom then return end
		local roomMsg = buildRoomMsgFromData(serverRoom)
		if not P._playerRoom:getMyRoom() then
			P._playerRoom:initMyRoom(roomMsg)
		else
			P._playerRoom:updateMyRoom(roomMsg)
			if P._playerRoom._myRoom then
				P._playerRoom._myRoom:sendRoomDirty()
			end
		end
	end

	ClientData.sendCreateRoom = function(roomType)
		local ind = ClientView.getActiveIndicator()
		if ind and ind.show then ind:show(Str(STR.WAITING)) end

		local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local myCards = {}
		local curTroopIndex = (P and P._curTroopIndex) or 1
		local troop = P and P._playerCard and P._playerCard._troops and P._playerCard._troops[curTroopIndex]
		local pList = (troop and (troop._cards or troop)) or {}
		for _, card in ipairs(pList) do
			local cid = type(card) == "table" and (card._infoId or card.info_id) or card
			local num = type(card) == "table" and (card._num or card.num or 1) or 1
			if cid and tonumber(cid) then
				for _ = 1, (tonumber(num) or 1) do
					table.insert(myCards, tonumber(cid))
				end
			end
		end

		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("create_room", {
				account_id = myAccId,
				name = (P and P._name) or "Duelist",
				level = (P and P._level) or 50,
				avatar = (P and P._avatar) or 201,
				cards = myCards,
				room_type = roomType or Data.RoomType.normal,
				match_hp = 8000
			}, function(rawRes)
				local ind2 = ClientView.getActiveIndicator()
				if ind2 and ind2.hide then ind2:hide() end
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and res.code == 200 and res.room then
					local roomMsg = buildRoomMsgFromData(res.room)
					P._playerRoom:initMyRoom(roomMsg)
				else
					ToastManager.push(res and res.msg or "Không thể tạo phòng!")
				end
			end)
		end
		return true
	end

	ClientData.sendQueryRoom = function(roomId)
		local ind = ClientView.getActiveIndicator()
		if ind and ind.show then ind:show(Str(STR.WAITING)) end

		local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local myCards = {}
		local curTroopIndex = (P and P._curTroopIndex) or 1
		local troop = P and P._playerCard and P._playerCard._troops and P._playerCard._troops[curTroopIndex]
		local pList = (troop and (troop._cards or troop)) or {}
		for _, card in ipairs(pList) do
			local cid = type(card) == "table" and (card._infoId or card.info_id) or card
			local num = type(card) == "table" and (card._num or card.num or 1) or 1
			if cid and tonumber(cid) then
				for _ = 1, (tonumber(num) or 1) do
					table.insert(myCards, tonumber(cid))
				end
			end
		end

		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("query_room", {
				room_id = tostring(roomId),
				account_id = myAccId,
				name = (P and P._name) or "Duelist",
				level = (P and P._level) or 50,
				avatar = (P and P._avatar) or 201,
				cards = myCards
			}, function(rawRes)
				local ind2 = ClientView.getActiveIndicator()
				if ind2 and ind2.hide then ind2:hide() end
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and res.code == 200 and res.room then
					local roomMsg = buildRoomMsgFromData(res.room)
					P._playerRoom:initMyRoom(roomMsg)
				else
					ToastManager.push(res and res.msg or "Không thể tham gia phòng!")
				end
			end)
		end
		return true
	end

	ClientData.sendToggleRoomMatch = function()
		local ind = ClientView.getActiveIndicator()
		if ind and ind.show then ind:show(Str(STR.WAITING)) end

		local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post and P._roomId then
			api:post("toggle_room_slot", {
				room_id = tostring(P._roomId),
				account_id = myAccId
			}, function(rawRes)
				local ind2 = ClientView.getActiveIndicator()
				if ind2 and ind2.hide then ind2:hide() end
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and res.code == 200 and res.room then
					ClientData.syncRoomData(res.room)
				else
					ToastManager.push(res and res.msg or "Thao tác thất bại!")
				end
			end)
		else
			if ind and ind.hide then ind:hide() end
		end
		return true
	end

	ClientData.sendStartRoomMatch = function()
		local ind = ClientView.getActiveIndicator()
		if ind and ind.show then ind:show(Str(STR.PREPARE_LIVE_BATTLE)) end

		local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post and P._roomId then
			api:post("start_room_battle", {
				room_id = tostring(P._roomId),
				account_id = myAccId
			}, function(rawRes)
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and res.code == 200 and res.room then
					ClientData.onRoomBattleStart(res.room)
				else
					local ind2 = ClientView.getActiveIndicator()
					if ind2 and ind2.hide then ind2:hide() end
					ToastManager.push(res and res.msg or "Chưa thể bắt đầu trận đấu!")
				end
			end)
		end
		return true
	end

	ClientData.startRoomDuelWithOpponent = function(serverRoom)
		if not serverRoom then return end
		local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local pA = serverRoom.playerA
		local pB = serverRoom.playerB
		if not pA or not pB then return end

		local isWatcher = (myAccId ~= pA.id and myAccId ~= pB.id)
		local oppo
		local isAttacker = true
		if pA.id == myAccId then
			oppo = pB
			isAttacker = true
		elseif pB.id == myAccId then
			oppo = pA
			isAttacker = false
		else
			oppo = pB
			isAttacker = true
		end

		local matchId = serverRoom.match_id or ("m_room_" .. tostring(serverRoom.code))
		local seed = tonumber(serverRoom.seed) or math.random(1, 65535)

		local fallbackCids = (Data._troopInfo and Data._troopInfo[1] and Data._troopInfo[1]._infoId) or { 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 20001, 20002, 20003, 20004, 20005, 30001, 30002, 30003 }

		local function buildCardsFromRaw(rawCards)
			local cards, levels, skins = {}, {}, {}
			local count = 0
			local counts, order = {}, {}
			local function addCid(cid)
				cid = tonumber(cid)
				if cid and cid > 0 then
					if not counts[cid] then
						counts[cid] = 0
						table.insert(order, cid)
					end
					counts[cid] = counts[cid] + 1
				end
			end
			if type(rawCards) == "table" then
				local numKeys = {}
				for k in pairs(rawCards) do
					if tonumber(k) then table.insert(numKeys, tonumber(k)) end
				end
				if #numKeys > 0 then
					table.sort(numKeys)
					for _, k in ipairs(numKeys) do
						addCid(rawCards[k] or rawCards[tostring(k)])
					end
				else
					for _, v in pairs(rawCards) do
						addCid(v)
					end
				end
			end
			for _, cid in ipairs(order) do
				table.insert(cards, { info_id = cid, num = counts[cid] })
				table.insert(levels, { info_id = cid, level = 1 })
				table.insert(skins, buildSkinEntryForCard(cid))
				count = count + counts[cid]
			end
			while count < 40 do
				for _, cid in ipairs(fallbackCids) do
					if count >= 40 then break end
					table.insert(cards, { info_id = cid, num = 1 })
					table.insert(levels, { info_id = cid, level = 1 })
					table.insert(skins, buildSkinEntryForCard(cid))
					count = count + 1
				end
			end
			return cards, levels, skins
		end

		local function parseCrown(userObj)
			if not userObj then return nil end
			if userObj._crown and userObj._crown._infoId and userObj._crown._infoId ~= 0 then
				return { _infoId = userObj._crown._infoId, _num = userObj._crown._num }
			elseif userObj.crown and type(userObj.crown) == "table" and (userObj.crown.info_id or userObj.crown._infoId) then
				local cid = tonumber(userObj.crown.info_id or userObj.crown._infoId) or 7204
				local num = tonumber(userObj.crown.num or userObj.crown._num) or 1
				if cid ~= 0 then return { _infoId = cid, _num = num } end
			else
				local gc = tonumber(userObj.gold_cup) or 0
				local sc = tonumber(userObj.silver_cup) or 0
				local bc = tonumber(userObj.bronze_cup) or 0
				if gc > 0 then return { _infoId = 7204, _num = gc }
				elseif sc > 0 then return { _infoId = 7205, _num = sc }
				elseif bc > 0 then return { _infoId = 7206, _num = bc }
				end
			end
			return nil
		end

		local playerCards, playerLevels, playerSkins
		local oppoCards, oppoLevels, oppoSkins
		local myCrown, oppoCrown

		if isWatcher then
			playerCards, playerLevels, playerSkins = buildCardsFromRaw(pA.cards)
			oppoCards, oppoLevels, oppoSkins = buildCardsFromRaw(pB.cards)
			myCrown = parseCrown(pA)
			oppoCrown = parseCrown(pB)
		else
			playerCards = {}
			playerLevels = {}
			playerSkins = {}
			local totalPlayerCards = 0
			local curTroopIndex = (P and P._curTroopIndex) or 1
			local pTroop = (P and P._playerCard and P._playerCard._troops and P._playerCard._troops[curTroopIndex]) or {}
			local pList = (type(pTroop) == "table" and (pTroop._cards or pTroop)) or {}
			for _, card in ipairs(pList) do
				local cid = type(card) == "table" and (card._infoId or card.info_id) or card
				local num = type(card) == "table" and (card._num or card.num) or 1
				local lvl = type(card) == "table" and ((card._level and card._level > 0) and card._level or 1) or 1
				if cid and tonumber(cid) then
					cid = tonumber(cid)
					num = math.max(1, tonumber(num) or 1)
					lvl = tonumber(lvl) or 1
					table.insert(playerCards, { info_id = cid, num = num })
					table.insert(playerLevels, { info_id = cid, level = lvl })
					table.insert(playerSkins, buildSkinEntryForCard(cid))
					totalPlayerCards = totalPlayerCards + num
				end
			end
			while totalPlayerCards < 40 do
				for _, cid in ipairs(fallbackCids) do
					if totalPlayerCards >= 40 then break end
					table.insert(playerCards, { info_id = cid, num = 1 })
					table.insert(playerLevels, { info_id = cid, level = 1 })
					table.insert(playerSkins, buildSkinEntryForCard(cid))
					totalPlayerCards = totalPlayerCards + 1
				end
			end

			oppoCards, oppoLevels, oppoSkins = buildCardsFromRaw(oppo.cards)
			myCrown = parseCrown(P) or (ClientData and ClientData._account and parseCrown(ClientData._account))
			oppoCrown = parseCrown(oppo)
		end

		ClientData._battleFromFindIndex = Data.FindMatchType.hall
		ClientData.setBattleFromSceneId(ClientData.SceneId.in_room)
		ClientData._isOppoOnline = true
		ClientData._currentMatchId = matchId
		ClientData._usedCardsToAdd = {}
		ClientData._observeUsedCards = {}

		local battleInput = {
			_levelId = 0,
			_copyId = 0,
			_isTesting = false,
			_offlineMode = false,
			_isOppoOnline = true,
			_pvpMatch = true,
			_matchId = matchId,
			_isAttacker = isAttacker,
			_isWatcher = isWatcher,
			_speedFactor = 1,
			_type = Battle_pb.PB_BATTLE_MATCH,
			_battleType = Data.BattleType.PVP_room,
			_sceneType = Data.BattleSceneType.gold_scene or 11,
			_timestamp = math.floor(ClientData.getCurrentTime() * 1000),
			_randomSeed = seed,
			_ruleType = Data.BattleRuleType.normal,
			_offlineKind = "room",
			_clashGrade = 1,
			_eventIds = {},
			_oppoEventIds = {},
			_player = {
				_region = 1,
				_level = isWatcher and (pA.level or 50) or ((P and P._level) or 50),
				_monthCardType = 0,
				_roundTimeInit = 45,
				_roundTimeMax = 45,
				_roundTimeDelta = 0,
				_fortressHp = serverRoom.match_hp or 8000,
				_avatarFrameId = 0,
				_isNewRound = true,
				_idInRoom = 0,
				_bossId = 0,
				_privilege = 0,
				_avatarFrameCount = 0,
				_regionId = 1,
				_avatarFrame = 0,
				_vip = isWatcher and (pA.vip or 0) or ((P and P._vip) or 0),
				_id = isWatcher and (pA.id or 1) or myAccId,
				_name = isWatcher and (pA.name or "Player A") or ((P and P._name) or "Player"),
				_avatar = isWatcher and (pA.avatar or 201) or (function()
					local av = (P and P._avatar) or 301
					if av < 100 then av = av * 100 + 1 end
					return av
				end)(),
				_crown = myCrown,
				_cardBackId = (P and P._cardBackId) or Data.PropsId.card_back,
				_isNpc = false,
				_troopCards = playerCards,
				_troopLevels = playerLevels,
				_troopSkins = playerSkins,
				_usedCards = {},
				_trophy = isWatcher and (tonumber(pA.trophy) or 800) or 800
			},
			_opponent = {
				_region = 1,
				_level = (isWatcher and pB.level or oppo.level) or 50,
				_monthCardType = 0,
				_roundTimeInit = 45,
				_roundTimeMax = 45,
				_roundTimeDelta = 0,
				_fortressHp = serverRoom.match_hp or 8000,
				_avatarFrameId = 0,
				_isNewRound = true,
				_idInRoom = 0,
				_bossId = 0,
				_privilege = 0,
				_avatarFrameCount = 0,
				_regionId = 1,
				_avatarFrame = 0,
				_vip = (isWatcher and pB.vip or oppo.vip) or 0,
				_id = (isWatcher and pB.id or oppo.id) or 0,
				_name = (isWatcher and pB.name or oppo.name) or "Duelist",
				_avatar = (isWatcher and pB.avatar or oppo.avatar) or 201,
				_crown = oppoCrown,
				_cardBackId = 7600,
				_isNpc = false,
				_troopCards = oppoCards,
				_troopLevels = oppoLevels,
				_troopSkins = oppoSkins,
				_usedCards = {},
				_trophy = tonumber(isWatcher and pB.trophy or oppo.trophy) or 800
			}
		}

		local pvpNet = jsbridge and jsbridge.object("jdzcPvp")
		if pvpNet then
			pvpNet:connect(matchId, myAccId, isAttacker, function(intsJson, addTime, maxTime, timeLeft, fromSlot)
				local ok, ints = pcall(json.decode, intsJson)
				if ok and type(ints) == "table" and #ints > 0 then
					local card_val = tonumber(ints[1]) or 0
					local isCardAction = (card_val ~= BattleData.UseCardId.round and card_val ~= BattleData.UseCardId.retreat and card_val ~= 0)
					local bonusSec = tonumber(addTime) or (isCardAction and 6 or 0)
					local maxSec = tonumber(maxTime) or 120
					local exactTime = tonumber(timeLeft)

					local scene = lc._runningScene or ClientView._scene
					local bUi = scene and scene._battleUi

					-- Đồng bộ cơ chế tối ưu thời gian: Màn hình đối thủ tăng time ngay lập tức khi nhận action từ server!
					if isCardAction and bUi then
						if exactTime and exactTime > 0 and type(bUi.syncPvpRoundSeconds) == "function" then
							bUi:syncPvpRoundSeconds(exactTime)
						elseif bonusSec > 0 and type(bUi.addPvpRoundSeconds) == "function" then
							bUi:addPvpRoundSeconds(bonusSec, maxSec)
						end
					end

					if isWatcher then
						local slot = fromSlot
						if not slot or slot == "" then
							if bUi and bUi._player and bUi._player._isUsing then
								slot = "p1"
							else
								slot = "p2"
							end
						end
						if slot == "p1" then
							ClientData._observeUsedCards = ClientData._observeUsedCards or {}
							for _, val in ipairs(ints) do
								table.insert(ClientData._observeUsedCards, tonumber(val) or 0)
							end
							local handled = false
							if bUi and type(bUi.observeTryUseCard) == "function" then
								handled = bUi:observeTryUseCard()
							end
							if card_val == BattleData.UseCardId.round and not handled and bUi and bUi._player and bUi._player._playerType == BattleData.PlayerType.observe then
								pcall(function() bUi._player:startAction() end)
							end
						else
							ClientData._usedCardsToAdd = ClientData._usedCardsToAdd or {}
							for _, val in ipairs(ints) do
								table.insert(ClientData._usedCardsToAdd, tonumber(val) or 0)
							end
							local handled = false
							if bUi and type(bUi.oppoTryUseCard) == "function" then
								handled = bUi:oppoTryUseCard()
							end
							if card_val == BattleData.UseCardId.round and not handled and bUi and type(bUi.forceOppoTurnEnd) == "function" then
								bUi:forceOppoTurnEnd()
							end
						end
					else
						ClientData._usedCardsToAdd = ClientData._usedCardsToAdd or {}
						for _, val in ipairs(ints) do
							table.insert(ClientData._usedCardsToAdd, tonumber(val) or 0)
						end
						local handled = false
						if bUi and type(bUi.oppoTryUseCard) == "function" then
							handled = bUi:oppoTryUseCard()
						end
						if card_val == BattleData.UseCardId.round and not handled and bUi and type(bUi.forceOppoTurnEnd) == "function" then
							bUi:forceOppoTurnEnd()
						end
					end
				end
			end, function()
				local scene = lc._runningScene or ClientView._scene
				local bUi = scene and scene._battleUi
				if bUi and not bUi._isBattleEndSended then
					if isWatcher then
						ToastManager.push("Một đấu thủ đã rời trận đấu!")
						bUi._isBattleEndSended = true
						if type(bUi.showResult) == "function" then
							bUi:showResult()
						end
					else
						bUi._forceResult = Data.BattleResult.win
						bUi:hideThinking()
						if bUi._opponent and type(bUi.retreat) == "function" then
							bUi:retreat(bUi._opponent)
						else
							bUi:sendBattleEnd(false, Data.BattleResult.win)
						end
						ToastManager.push("Đối thủ đã rời trận, bạn đã giành chiến thắng!")
					end
				end
			end, function(peerResult, reason, winnerSlot)
				local scene = lc._runningScene or ClientView._scene
				local bUi = scene and scene._battleUi
				if bUi and not bUi._isBattleEndSended then
					if isWatcher then
						ToastManager.push("Trận đấu đã kết thúc!")
						bUi._isBattleEndSended = true
						if type(bUi.showResult) == "function" then
							bUi:showResult()
						end
					else
						local oppoHp = bUi._opponent and bUi._opponent._fortress and bUi._opponent._fortress._hp
						local playerHp = bUi._player and bUi._player._fortress and bUi._player._fortress._hp
						local myRes = (tostring(peerResult) == "1" and Data.BattleResult.win or Data.BattleResult.lose)
						if oppoHp and oppoHp <= 0 and (not playerHp or playerHp > 0) then
							myRes = Data.BattleResult.win
						elseif playerHp and playerHp <= 0 and (not oppoHp or oppoHp > 0) then
							myRes = Data.BattleResult.lose
						end
						bUi._forceResult = myRes
						bUi:sendBattleEnd(false, myRes)
					end
				end
			end, function(chatMsg)
				local scene = lc._runningScene or ClientView._scene
				local bUi = scene and scene._battleUi
				if bUi and bUi._opponent and bUi.addChat then
					bUi:addChat(bUi._opponent, tostring(chatMsg))
				end
			end, isWatcher)
		end

		local ind = ClientView.getActiveIndicator()
		if ind and ind.hide then ind:hide() end

		if lc._runningScene and type(lc._runningScene.onBattleRecover) == "function" then
			lc._runningScene:onBattleRecover(battleInput)
		end
	end
	ClientData.onRoomBattleStart = ClientData.startRoomDuelWithOpponent

	ClientData.sendQuitRoom = function()
		local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local rId = P and P._roomId
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post and rId then
			api:post("leave_room", {
				room_id = tostring(rId),
				account_id = myAccId
			})
		end
		if P then
			P._roomId = nil
			P._roomJob = nil
			if P._playerRoom then
				pcall(function() P._playerRoom:clear() end)
			end
		end
		if lc._runningScene and lc._runningScene._sceneId == ClientData.SceneId.in_room then
			if not lc._runningScene._isExiting then
				lc._runningScene._isExiting = true
				if lc._runningScene._roomPollSchedule then
					lc.Scheduler:unscheduleScriptEntry(lc._runningScene._roomPollSchedule)
					lc._runningScene._roomPollSchedule = nil
				end
				ClientView.popScene()
			end
		end
		return true
	end


    -- ==========================================================
    -- 6 COMPREHENSIVE WEB EXTENSIONS
    -- ==========================================================
    local function syncPackCardsToData()
        if not rawget(_G, "Data") then return end
        if Data._recruitInfo then
            for boxId, rInfo in pairs(Data._recruitInfo) do
                local pool = ClientData.getPackCardPool and ClientData.getPackCardPool(boxId)
                if pool and #pool > 0 then
                    rInfo._rid = pool
                    rInfo._cards = pool
                    local pidTbl = {}
                    for _, cid in ipairs(pool) do
                        table.insert(pidTbl, { cid })
                    end
                    rInfo._pid = pidTbl
                end
            end
        end
        if Data._dropInfo then
            for boxId, dInfo in pairs(Data._dropInfo) do
                local pool = ClientData.getPackCardPool and ClientData.getPackCardPool(boxId)
                if pool and #pool > 0 then
                    dInfo._rid = pool
                    dInfo._cards = pool
                    local pidTbl = {}
                    for _, cid in ipairs(pool) do
                        table.insert(pidTbl, { cid })
                    end
                    dInfo._pid = pidTbl
                end
            end
        end
    end
    pcall(syncPackCardsToData)

    -- 1. ACHIEVEMENTS: Hook sendBonusRequest & claimBonus
    ClientData.sendBonusRequest = function(reqType)
        if lc and lc.sendEvent and Data and Data.Event then
            lc.sendEvent(Data.Event.achieve_list_dirty)
        end
        return true
    end

    local origClaimBonus = ClientData.claimBonus
    ClientData.claimBonus = function(bonus)
        local res = origClaimBonus and origClaimBonus(bonus)
        local aid = type(bonus) == "table" and (bonus._infoId or bonus._id) or tonumber(bonus)
        if aid and aid > 0 then
            local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
            local api = jsbridge and jsbridge.object("jdzcApi")
            if api and api.post then
                api:post("claim_achievement", {
                    account_id = myAccId,
                    achieve_id = aid,
                    gold = 1000,
                    gem = 50
                }, function(rawRes)
                    local r = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
                    if r and r.code == 200 then
                        if r.gold and P then P._gold = r.gold end
                        if r.gem and P then P._ingot = r.gem end
                        if lc and lc.sendEvent and Data and Data.Event then
                            lc.sendEvent(Data.Event.achieve_list_dirty)
                        end
                    end
                end)
            end
        end
        return res
    end

    -- 2. CUSTOM ZOOM ROOM: Hook sendQueryRoom
    ClientData.sendQueryRoom = function(roomId)
        local ind = ClientView.getActiveIndicator()
        if ind and ind.show then ind:show(Str(STR.WAITING)) end

        local cleanRoomId = tostring(roomId):gsub("%s+", "")
        local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
        local myCards = {}
        local curTroopIndex = (P and P._curTroopIndex) or 1
        local troop = P and P._playerCard and P._playerCard._troops and P._playerCard._troops[curTroopIndex]
        local pList = (troop and (troop._cards or troop)) or {}
        for _, card in ipairs(pList) do
            local cid = type(card) == "table" and (card._infoId or card.info_id) or card
            local num = type(card) == "table" and (card._num or card.num or 1) or 1
            if cid and tonumber(cid) then
                for _ = 1, (tonumber(num) or 1) do
                    table.insert(myCards, tonumber(cid))
                end
            end
        end

        local api = jsbridge and jsbridge.object("jdzcApi")
        if api and api.post then
            api:post("query_room", {
                room_id = cleanRoomId,
                account_id = myAccId,
                name = (P and P._name) or "Duelist",
                level = (P and P._level) or 50,
                avatar = (P and P._avatar) or 201,
                cards = myCards
            }, function(rawRes)
                local ind2 = ClientView.getActiveIndicator()
                if ind2 and ind2.hide then ind2:hide() end
                local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
                if res and res.code == 200 and res.room then
                    if P and P._playerRoom then
                        P._playerRoom:clear()
                    end
                    local roomMsg = buildRoomMsgFromData(res.room)
                    P._playerRoom:initMyRoom(roomMsg)
                    if lc._runningScene and lc._runningScene._sceneId ~= ClientData.SceneId.in_room then
                        lc.pushScene(require("InRoomScene").create())
                    end
                else
                    ToastManager.push(res and res.msg or "Không thể tham gia phòng!")
                end
            end)
        end
        return true
    end

    -- 3. CHIẾN TÍCH (BATTLE REPLAYS & LOGS): Hook sendGetRoomLog & recordMatchResult
    ClientData.sendGetRoomLog = function()
        return ClientData.sendGetPvpLogs(Battle_pb.PB_BATTLE_MATCH)
    end

    if PlayerMessage then
        PlayerMessage.isLogShared = function(self, logId)
            local bList = self._msgAll and self._msgAll[Data.MsgType.battle]
            if bList then
                for _, msg in ipairs(bList) do
                    if msg._log and tostring(msg._log._id) == tostring(logId) then
                        return true
                    end
                end
            end
            return false
        end
    end

    if LogForm then
        local origLogFormOnEnter = LogForm.onEnter
        LogForm.onEnter = function(self)
            if origLogFormOnEnter then origLogFormOnEnter(self) end
            pcall(function()
                if ClientData.sendGetPvpLogs then
                    ClientData.sendGetPvpLogs(self._type)
                end
            end)
        end
    end

    ClientData.recordMatchResult = function(opponentName, opponentLevel, opponentAvatar, result, btype, trophyChange, replayData)
        local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
        local api = jsbridge and jsbridge.object("jdzcApi")
        if api and api.post then
            api:post("save_replay", {
                account_id = myAccId,
                opponent_name = opponentName or "Duelist",
                opponent_level = opponentLevel or 1,
                opponent_avatar = opponentAvatar or 101,
                result = result or 1,
                battle_type = btype or Battle_pb.PB_BATTLE_MATCH,
                trophy_change = trophyChange or 0,
                replay_data = replayData or {}
            }, function()
                if ClientData.sendGetPvpLogs then ClientData.sendGetPvpLogs(btype) end
            end)
        end
    end

    -- 4. CHANGE CHARACTER & AVATAR (DATABASE + SERVER)
    ClientData.sendSetCharacter = function(charId, isGuide)
        local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
        local cid = tonumber(charId) or 3
        local defaultAvatar = cid * 100 + 1
        local api = jsbridge and jsbridge.object("jdzcApi")
        if api and api.post then
            api:post("set_character", {
                account_id = myAccId,
                character_id = cid,
                avatar = defaultAvatar
            }, function(rawRes)
                local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
                if res and res.code == 200 then
                    local newAvatar = res.avatar or defaultAvatar
                    if ClientData._account then
                        ClientData._account.character_id = cid
                        ClientData._account.avatar = newAvatar
                    end
                    if P then
                        P._characterId = cid
                        P:changeIcon(newAvatar)
                        P:sendCharacterDirty()
                        P:sendIconDirty()
                    end
                    ToastManager.push("Đổi nhân vật thành công!")
                end
            end)
        end
        return true
    end

    ClientData.sendSetAvatar = function(avatarId)
        local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
        local aid = tonumber(avatarId) or 301
        local api = jsbridge and jsbridge.object("jdzcApi")
        if api and api.post then
            api:post("set_avatar", {
                account_id = myAccId,
                avatar = aid
            }, function(rawRes)
                local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
                if res and res.code == 200 then
                    if ClientData._account then
                        ClientData._account.avatar = aid
                        if res.character_id then
                            ClientData._account.character_id = res.character_id
                        end
                    end
                    if P then
                        P._avatar = aid
                        if res.character_id then
                            P._characterId = res.character_id
                            P:sendCharacterDirty()
                        end
                        P:sendIconDirty()
                    end
                    ToastManager.push("Đổi avatar thành công!")
                end
            end)
        end
        return true
    end





    -- ACHIEVEMENTS: Proper dispatch on sendBonusRequest
    ClientData.sendBonusRequest = function(reqType)
        if P and P._playerAchieve and P._playerAchieve.sendAchieveListDirty then
            P._playerAchieve:sendAchieveListDirty()
        elseif lc and lc.Dispatcher and Data and Data.Event then
            local ev = cc.EventCustom:new(Data.Event.achieve_list_dirty)
            lc.Dispatcher:dispatchEvent(ev)
        end
        return true
    end

    -- BATTLE LOG / REPLAY SPINNER FIX: Hook sendUserVisitRegion
    ClientData.sendUserVisitRegion = function(userId)
        local uid = tonumber(userId) or (ClientData._account and ClientData._account.id) or (P and P._id) or 1
        local api = jsbridge and jsbridge.object("jdzcApi")
        local function deliverVisit(visitData)
            local msg = {
                type = SglMsgType_pb.PB_TYPE_USER_VISIT_EX,
                Extensions = {
                    [User_pb.SglUserMsg.user_visit_ex_resp] = visitData
                }
            }
            if ClientData.onMsg then
                ClientData.onMsg(msg)
            end
        end

        if api and api.post then
            api:post("user_visit", { user_id = uid }, function(rawRes)
                local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
                if res and res.visit then
                    deliverVisit(res.visit)
                else
                    deliverVisit({
                        user_info = {
                            id = uid, name = "Duelist_" .. tostring(uid), level = 20, trophy = 1500, avatar = 301,
                            gold = 0, grain = 0, ingot = 0, exp = 0, vip = 0, shield = 0,
                            union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
                            last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
                        },
                        pre_rank = 1, best_rank = 1, legend_trophy = 1500, pre_legend_rank = 1, best_legend_rank = 1
                    })
                end
            end)
        else
            deliverVisit({
                user_info = {
                    id = uid, name = "Duelist_" .. tostring(uid), level = 20, trophy = 1500, avatar = 301,
                    gold = 0, grain = 0, ingot = 0, exp = 0, vip = 0, shield = 0,
                    union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
                    last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
                },
                pre_rank = 1, best_rank = 1, legend_trophy = 1500, pre_legend_rank = 1, best_legend_rank = 1
            })
        end
    end

    -- VISIT USER / INSPECT DECK FIX: Hook sendUserVisit
    ClientData.sendUserVisit = function(userId)
        local uid = tonumber(userId) or (ClientData._account and ClientData._account.id) or (P and P._id) or 1
        local api = jsbridge and jsbridge.object("jdzcApi")
        local function deliverVisit(visitData)
            local msg = {
                type = SglMsgType_pb.PB_TYPE_USER_VISIT,
                status = 0,
                Extensions = {
                    [User_pb.SglUserMsg.user_visit_resp] = visitData
                }
            }
            if ClientData.onMsg then
                ClientData.onMsg(msg)
            end
        end

        local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
        local curTroop = (P and P._curTroopIndex) or 1
        if api and api.post then
            api:post("user_visit", { user_id = uid, my_user_id = myAccId, cur_troop = (tonumber(uid) == tonumber(myAccId) and curTroop or nil) }, function(rawRes)
                local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
                if res and res.visit then
                    deliverVisit(res.visit)
                else
                    deliverVisit({
                        user_info = {
                            id = uid, name = "Duelist_" .. tostring(uid), level = 20, trophy = 800, avatar = 301,
                            gold = 0, grain = 0, ingot = 0, exp = 0, vip = 0, shield = 0,
                            union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
                            last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
                        },
                        troop = {},
                        pre_rank = 1, best_rank = 1, legend_trophy = 800, pre_legend_rank = 1, best_legend_rank = 1
                    })
                end
            end)
        else
            deliverVisit({
                user_info = {
                    id = uid, name = "Duelist_" .. tostring(uid), level = 20, trophy = 800, avatar = 301,
                    gold = 0, grain = 0, ingot = 0, exp = 0, vip = 0, shield = 0,
                    union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
                    last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
                },
                troop = {},
                pre_rank = 1, best_rank = 1, legend_trophy = 800, pre_legend_rank = 1, best_legend_rank = 1
            })
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

	api.frameSize = function(name)
		if name == nil then return cc.size(32, 32) end
		local frame = lc.FrameCache and lc.FrameCache:getSpriteFrame(name)
		if frame then
			return frame:getOriginalSize()
		end
		local str = tostring(name)
		if string.find(str, "card_quality") then
			return cc.size(25, 26)
		end
		return cc.size(32, 32)
	end
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
	lc = lc or {}
	lc.performWithDelay = function(...) return performWithDelay(...) end
	if type(performWithDelay) ~= "function" or rawget(_G, "_h5PerformWithDelay") then
		return
	end

	local native = performWithDelay
	_h5PerformWithDelay = native
	performWithDelay = function(target, callback, delay)
		local id
		id = lc.Scheduler:scheduleScriptFunc(function()
			lc.Scheduler:unscheduleScriptEntry(id)
			if callback then callback() end
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

local _staticTouchStartLoc = {x = 0, y = 0}
local function _staticGetStartLocation()
	return _staticTouchStartLoc
end
local function _staticGetTouchId()
	return 0
end

local function patchBattleUiTouch(mod)
	local BattleUi = _G.BattleUi
	if not BattleUi or not BattleUi.onTouchBegan then return end
	local oldTouchBegan = BattleUi.onTouchBegan
	BattleUi.onTouchBegan = function(self, touch)
		if touch and self._playerUi and self._playerUi._initiativeIconCards and #self._playerUi._initiativeIconCards > 0 then
			local touchLoc = touch:getLocation()
			for _, pCard in ipairs(self._playerUi._initiativeIconCards) do
				if pCard and pCard._initiativeSkillIcons and #pCard._initiativeSkillIcons > 0 then
					for iconIdx, iconBtn in ipairs(pCard._initiativeSkillIcons) do
						if iconBtn and iconBtn:isVisible() then
							local iconPos = iconBtn:convertToWorldSpace3D(cc.p(lc.w(iconBtn) / 2, lc.h(iconBtn) / 2), ClientData._camera3D)
							if cc.pGetDistance(touchLoc, iconPos) <= 40 then
								local cardObj = pCard._card
								local skills = cardObj and cardObj:getInitiativeSkill(Data.SkillMode.initiative_bcs)
								local targetSkill = skills and skills[iconIdx]
								if iconBtn:isEnabled() then
									if targetSkill then
										self._playerUi:castInitiativeSkill(cardObj, targetSkill)
									else
										if iconBtn.onTouchBegan then
											iconBtn:onTouchBegan(touch)
											iconBtn:onTouchEnded(touch)
										end
									end
								else
									if targetSkill then
										local skInfo = Data._skillInfo[targetSkill._id]
										local skName = (skInfo and skInfo._nameSid and Str(skInfo._nameSid)) or (skInfo and skInfo._name) or "Kĩ năng"
										local skDesc = (skInfo and skInfo._descSid and Str(skInfo._descSid)) or (skInfo and skInfo._desc) or ""
										ToastManager.push(tostring(skName) .. ": " .. tostring(skDesc))
									end
								end
								return true
							end
						end
					end
				end
			end
		end

		if touch then
			if not touch.getId or touch:getId() == nil then
				touch.getId = _staticGetTouchId
				touch.getID = _staticGetTouchId
			end
			local loc = touch:getLocation()
			self._h5TouchStartLoc = loc
			_staticTouchStartLoc.x = loc.x
			_staticTouchStartLoc.y = loc.y
		end
		return oldTouchBegan(self, touch)
	end

	local oldTouchMoved = BattleUi.onTouchMoved
	if oldTouchMoved then
		BattleUi.onTouchMoved = function(self, touch)
			if self._h5TouchStartLoc and touch then
				local origGetStart = touch.getStartLocation
				touch.getStartLocation = _staticGetStartLocation
				local ret = oldTouchMoved(self, touch)
				touch.getStartLocation = origGetStart
				return ret
			end
			return oldTouchMoved(self, touch)
		end
	end

	local oldTouchEnded = BattleUi.onTouchEnded
	if oldTouchEnded then
		BattleUi.onTouchEnded = function(self, touch)
			local ok, err = pcall(oldTouchEnded, self, touch)
			if not ok then
				print("[h5_patch] BattleUi.onTouchEnded error: " .. tostring(err))
			end
		end
	end
end

local function patchPlayerUi(PlayerUi)
	local oldCalBoardCardPos = PlayerUi.calBoardCardPos
	PlayerUi.calBoardCardPos = function(self, cardSprite)
		if not cardSprite or not cardSprite._card then
			return cc.p(0, 0)
		end

		local ret = oldCalBoardCardPos(self, cardSprite)
		if ret == nil or ret.x == nil or ret.y == nil or ret.x ~= ret.x or ret.y ~= ret.y then
			-- If the card is in a known slot, calculate position directly from its _pos
			local pos = cardSprite._card._pos
			local isBottom = self._isController
			local xs = isBottom and PlayerUi.Pos.attacker_board_x or PlayerUi.Pos.defender_board_x
			local y = isBottom and PlayerUi.Pos.attacker_board_y or PlayerUi.Pos.defender_board_y
			if pos and xs and xs[pos] then
				if cardSprite.isSmall and cardSprite:isSmall() then
					y = y + (isBottom and (pos == 6 and PlayerUi.Pos.board_pos_dy[1] or -PlayerUi.Pos.board_pos_dy[2]) or pos == 6 and -PlayerUi.Pos.board_pos_dy[1] or PlayerUi.Pos.board_pos_dy[2])
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
	if CardSprite.__h5_patched then return end
	CardSprite.__h5_patched = true

	-- __isCard is set directly in CardSprite.lua m.init

	CardSprite.runAction = function(self, action)
		local function onActionComplete()
			if not self._card then return end
			if not self:getParent() then return end
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
				if self._ownerUi and self._ownerUi.getHandCardSprite and self._ownerUi:getHandCardSprite(self._card) == self and self._ownerUi.calHandCardPosAndRot then
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
					if bSprite == self and self._ownerUi.calBoardCardPos then
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
		local ok, err = pcall(function()
			if self._status == CardSprite.Status.large or self._status == CardSprite.Status.info or self._pInfoArea then
				self:hideLargePic()
			end
			if oldTouchEnded then
				oldTouchEnded(self, touch)
			end
		end)
		if not ok then
			print("[h5_patch] CardSprite.onTouchEnded error: " .. tostring(err))
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


	CardSprite.efcXYZMarkBegin = function(self, markName)
		if not self._card then return end
		local count = self._card:getBuffValue(true, BattleData.PositiveType.xyzMark)
		if self._xyzMaterialCount == count and self._statusEfc and self._statusEfc[markName] ~= nil then
			return
		end
		if self._statusEfc and self._statusEfc[markName] ~= nil then
			CardSprite.efcXYZMarkEnd(self, markName)
		end
		if count > 0 and (not self._statusEfc or self._statusEfc[markName] == nil) then
			self._xyzMaterialCount = count
			local efcName = "chaoliangsucai" .. math.min(3, count)
			local db = self._ownerUi and self._ownerUi:efcDragonBones2(efcName, "effect", 0.5, false)
			if db then
				lc.addChildToPos(self._pEffectArea, db, cc.p(0, 0))
				if self._scene and self._scene.seenByCamera3D then
					self._scene:seenByCamera3D(db)
				end
				self._statusEfc = self._statusEfc or {}
				self._statusEfc[markName] = db
			end
		end
	end

	local oldGetNegativeStatus = CardSprite.getNegativeStatus
	CardSprite.getNegativeStatus = function(self)
		local ret = oldGetNegativeStatus and oldGetNegativeStatus(self) or {}
		local card = self._card
		if card and (card._infoId == 40730 or (card.hasSkillFast and card:hasSkillFast(14719))) and card._status == BattleData.CardStatus.board then
			for idx = 1, #(CardSprite.NegativeStatus or {}) do
				if CardSprite.NegativeStatus[idx]._name == "manacle" then
					ret[idx] = not card._tsAwakened
				end
			end
		end
		return ret
	end

	local _CACHED_STR_1777 = nil
	local _CACHED_STR_1778 = nil
	local _CACHED_STR_1779 = nil
	local _CACHED_STR_1771 = nil
	local _CACHED_STR_1772 = nil
	local _CACHED_STR_1773 = nil

	local oldGetPositiveStatus = CardSprite.getPositiveStatus
	CardSprite.getPositiveStatus = function(self)
		local ret = oldGetPositiveStatus and oldGetPositiveStatus(self) or {}
		local card = self._card
		if not card or (card._status ~= BattleData.CardStatus.board and card._status ~= nil) then
			return ret
		end

		local cid = card._infoId
		local has12008 = (card.hasSkillFast and card:hasSkillFast(12008)) or cid == 40734 or cid == 40736
		local has12009 = (card.hasSkillFast and card:hasSkillFast(12009)) or cid == 40734 or cid == 40736
		local has12010 = (card.hasSkillFast and card:hasSkillFast(12010)) or cid == 40734 or cid == 40736
		local has12002 = (card.hasSkillFast and card:hasSkillFast(12002)) or cid == 40737 or cid == 40739
		local has12003 = (card.hasSkillFast and card:hasSkillFast(12003)) or cid == 40737 or cid == 40739
		local has12004 = (card.hasSkillFast and card:hasSkillFast(12004)) or cid == 40737 or cid == 40739

		if not has12008 and not has12009 and not has12010 and not has12002 and not has12003 and not has12004 then
			return ret
		end

		local pStatus = CardSprite.PositiveStatus or {}
		for idx = 1, #pStatus do
			local s = pStatus[idx]
			if s._name == "shieldOppoMonster" and has12008 then
				ret[idx] = true
			elseif s._name == "shieldOppoMagic" and has12009 then
				ret[idx] = true
			elseif s._name == "shieldOppoTrap" and has12010 then
				ret[idx] = true
			elseif s._name == "shieldExMonster" and has12002 then
				ret[idx] = true
			elseif s._name == "shieldExMagic" and has12003 then
				ret[idx] = true
			elseif s._name == "shieldExTrap" and has12004 then
				ret[idx] = true
			end
		end
		return ret
	end

	local oldGetCardStatusStrs = CardSprite.getCardStatusStrs
	CardSprite.getCardStatusStrs = function(self)
		local ret = oldGetCardStatusStrs and oldGetCardStatusStrs(self) or { {}, {} }
		local card = self._card
		if not card or (card._status ~= BattleData.CardStatus.board and card._status ~= nil) then
			return ret
		end

		local cid = card._infoId
		local has12008 = (card.hasSkillFast and card:hasSkillFast(12008)) or cid == 40734 or cid == 40736
		local has12009 = (card.hasSkillFast and card:hasSkillFast(12009)) or cid == 40734 or cid == 40736
		local has12010 = (card.hasSkillFast and card:hasSkillFast(12010)) or cid == 40734 or cid == 40736
		local has12002 = (card.hasSkillFast and card:hasSkillFast(12002)) or cid == 40737 or cid == 40739
		local has12003 = (card.hasSkillFast and card:hasSkillFast(12003)) or cid == 40737 or cid == 40739
		local has12004 = (card.hasSkillFast and card:hasSkillFast(12004)) or cid == 40737 or cid == 40739

		if not has12008 and not has12009 and not has12010 and not has12002 and not has12003 and not has12004 then
			return ret
		end

		if not _CACHED_STR_1777 then
			_CACHED_STR_1777 = Str(1777)
			_CACHED_STR_1778 = Str(1778)
			_CACHED_STR_1779 = Str(1779)
			_CACHED_STR_1771 = string.gsub(string.format(Str(1771), ""), "%s+$", "")
			_CACHED_STR_1772 = string.gsub(string.format(Str(1772), ""), "%s+$", "")
			_CACHED_STR_1773 = string.gsub(string.format(Str(1773), ""), "%s+$", "")
		end

		local posList = ret[1] or {}
		ret[1] = posList

		local function addIfMissing(target)
			for i = 1, #posList do
				if posList[i] == target then return end
			end
			table.insert(posList, target)
		end

		if has12008 then addIfMissing(_CACHED_STR_1777) end
		if has12009 then addIfMissing(_CACHED_STR_1778) end
		if has12010 then addIfMissing(_CACHED_STR_1779) end
		if has12002 then addIfMissing(_CACHED_STR_1771) end
		if has12003 then addIfMissing(_CACHED_STR_1772) end
		if has12004 then addIfMissing(_CACHED_STR_1773) end

		return ret
	end
end

local function patchBattleUi(BattleUi)
	if not BattleUi then return end

	BattleUi.getEventDispatcher = function(self)
		return (cc and cc.eventManager) or { removeEventListenersForTarget = function() end, removeListeners = function() end }
	end

	if not BattleUi then return end


	-- Offline PVE Battle End Handler (Chapter / Elite / Commander / Rob Gold / Expedition)
		if PlayerBattle and not PlayerBattle.setResult then
		PlayerBattle.setResult = function(self, res)
			if self.genResult then
				self:genResult(res)
			else
				self._resultType = res
			end
		end
	end

		-- Ensure P._playerWorld._cities never crashes BattleUi.changeResource
	local oldChangeResource = BattleUi.changeResource
	if oldChangeResource then
		BattleUi.changeResource = function(self, result)
			if P and P._playerWorld and not P._playerWorld._cities then
				P._playerWorld._cities = setmetatable({}, {
					__index = function(t, k)
						return {
							captureSuccess = function() end,
							cityOccupied = function() end,
						}
					end
				})
			end
			return oldChangeResource(self, result)
		end
	end

	local oldInitData = BattleUi.initData
	if oldInitData then
		BattleUi.initData = function(self, input)
			if input then
				input._timestamp = input._timestamp or (os.time() * 1000)
				input._sceneType = input._sceneType or Data.BattleSceneType.stone_scene
				if input._player then
					input._player._level = input._player._level or (P and P._level) or 50
					input._player._vip = input._player._vip or (P and P._vip) or 0
					input._player._trophy = input._player._trophy or (P and P._trophy) or 800
					input._player._troopSkins = input._player._troopSkins or {}
					input._player._extraSkills = input._player._extraSkills or {}
				end
				if input._opponent then
					input._opponent._level = input._opponent._level or 50
					input._opponent._vip = input._opponent._vip or 0
					input._opponent._trophy = input._opponent._trophy or 800
					input._opponent._troopSkins = input._opponent._troopSkins or {}
					input._opponent._extraSkills = input._opponent._extraSkills or {}
				end
			end
			return oldInitData(self, input)
		end
	end

local oldSendBattleEnd = BattleUi.sendBattleEnd
	if oldSendBattleEnd then
		BattleUi.sendBattleEnd = function(self)
			if self._offlineResultShown then return end

			local oppoHp = self._opponent and self._opponent._fortress and self._opponent._fortress._hp
			local playerHp = self._player and self._player._fortress and self._player._fortress._hp
			local isHpDead = (oppoHp and oppoHp <= 0) or (playerHp and playerHp <= 0)
			local isSurrender = (self._forceResult ~= nil) or (self._player and (self._player._isSurrender or self._player._isRetreat)) or (self._opponent and (self._opponent._isSurrender or self._opponent._isRetreat))
			local isExodia = (self._player and self._player._winBy3190) or (self._opponent and self._opponent._winBy3190)
			local isGodWin = (self._player and self._player._winBy3798) or (self._opponent and self._opponent._winBy3798)
			local isDeckOut = (self._player and self._player._macroStatus == BattleData.Status.round_begin and self._player:getIsPileEmpty()) or (self._opponent and self._opponent._macroStatus == BattleData.Status.round_begin and self._opponent:getIsPileEmpty())
			local isRoundExceed = (self._player and self._player:getIsRoundExceed()) or (self._opponent and self._opponent:getIsRoundExceed())

			if not (isHpDead or isSurrender or isExodia or isGodWin or isDeckOut or isRoundExceed) then
				print("[h5_patch:sendBattleEnd] PREVENTED premature end! Player HP:", playerHp, "Oppo HP:", oppoHp)
				self._offlineResultShown = false
				self._isBattleEndSended = false
				return
			end

			local input = self._input
			local isOffline = (input and (input._offlineMode or input._offlineMarker or (not input._isOppoOnline)))
			local isPvp = (input and input._pvpMatch)

			if (isOffline or isPvp) and self._baseBattleType ~= Data.BattleType.base_replay and self._battleType ~= Data.BattleType.replay then
				self._offlineResultShown = true
				self._isBattleEndSended = true

				local res = self._forceResult or (self._player and self._player:getResult()) or Data.BattleResult.win
				local oppoHp = self._opponent and self._opponent._fortress and self._opponent._fortress._hp
				local playerHp = self._player and self._player._fortress and self._player._fortress._hp
				if oppoHp and oppoHp <= 0 and (not playerHp or playerHp > 0) then
					res = Data.BattleResult.win
				elseif playerHp and playerHp <= 0 and (not oppoHp or oppoHp > 0) then
					res = Data.BattleResult.lose
				end
				local levelId = input and (input._levelId or input._copyId) or 0

				local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
				local api = jsbridge and jsbridge.object("jdzcApi")
				local rId = P and P._roomId
				local mId = ClientData._currentMatchId

				if isPvp or rId or mId or self._battleType == Data.BattleType.PVP_room or (input and input._offlineKind == "room") then
					pcall(function()
						local pvpNet = jsbridge and jsbridge.object("jdzcPvp")
						if pvpNet then
							if pvpNet.sendEnd then
								pvpNet:sendEnd(mId or "", tostring(res))
							elseif pvpNet.sendAction then
								pvpNet:sendAction(mId or "", { 999999, tonumber(res) or 1 })
							end
							if pvpNet.leave then
								pvpNet:leave(mId or "")
							end
						end
					end)

					-- HỦY PHÒNG TRÊN GATEWAY SERVER NGAY KHI ĐÃ PHÂN THẮNG BẠI
					pcall(function()
						if api and api.post then
							api:post("destroy_room", {
								room_id = tostring(rId or ""),
								match_id = tostring(mId or ""),
								account_id = accId
							})
						end
					end)

					-- Dọn dẹp sạch sẽ phòng & đối phương online
					if P then
						P._roomId = nil
						P._roomJob = nil
						if P._playerRoom then
							pcall(function() P._playerRoom:clear() end)
						end
					end
					ClientData._currentMatchId = nil
					ClientData._isOppoOnline = false
				end

				self:showWaiting()

				local resp = SglMsg_pb.SglRespMsg()
				resp.type = SglMsgType_pb.PB_TYPE_BATTLE_END
				resp.status = SglMsg_pb.PB_STATUS_OK
				local pb = resp.Extensions[Battle_pb.SglBattleMsg.battle_end_resp]

				-- Pure arrays of used card operations for replay
				local pRecOps = {}
				if self._player and self._player._recordedUsedCards then
					for _, v in ipairs(self._player._recordedUsedCards) do
						table.insert(pRecOps, tonumber(v) or 0)
					end
				end
				local oRecOps = {}
				if self._opponent and self._opponent._recordedUsedCards then
					for _, v in ipairs(self._opponent._recordedUsedCards) do
						table.insert(oRecOps, tonumber(v) or 0)
					end
				end

				local repId = "pvp_" .. tostring(math.floor(ClientData.getCurrentTime() * 1000))
				local oppoName = (input and input._opponent and input._opponent._name) or (self._opponent and self._opponent._name) or "Opponent"
				local oppoLevel = (input and input._opponent and input._opponent._level) or 1
				local oppoAvatar = (input and input._opponent and input._opponent._avatar) or 201
				local myTroopCards = (input and input._player and input._player._troopCards) or (P and P._troops and P._troops[1] and P._troops[1]._cards) or {10001, 10002}
				local oppoTroopCards = (input and input._opponent and input._opponent._troopCards) or {10001, 10002, 10003, 10004, 10005}
				local curRound = (self._player and self._player._round) or 5

				local isClashRank = (self._battleType == Data.BattleType.PVP_clash or self._battleType == Data.BattleType.PVP_clash_npc or self._battleType == 211 or self._battleType == 212 or (Battle_pb and self._battleType == Battle_pb.PB_BATTLE_WORLD_LADDER) or isPvp or (input and (input._isRankLadder or input._clashGrade ~= nil)))

				local function finalizeBattleEnd(deltaTrophy, deltaGold, newTrophy, newGold, customResType, customResNum, rewardItemInfoId)
					local realDelta = tonumber(deltaTrophy) or 0
					local finalTrophy = tonumber(newTrophy) or 0
					local prevTrophy = finalTrophy - realDelta
					if prevTrophy < 0 then prevTrophy = 0 end
					if finalTrophy < 0 then finalTrophy = 0 end

					-- Before BattleUi:changeResource runs, ensure memory holds prevTrophy so changeResource adds realDelta to reach finalTrophy
					if P and P._playerFindClash then
						P._playerFindClash._trophy = prevTrophy
						P._playerFindClash._grade = P._playerFindClash:getGrade(prevTrophy)
					end
					if P then P._trophy = finalTrophy end
					if ClientData._account then ClientData._account.trophy = finalTrophy end

					pb.score = self._player and self._player._damageScore and self._player._damageScore[PlayerBattle.KEY_TOTAL] or 1000
					pb.trophy = math.abs(realDelta)
					pb.rank1 = prevTrophy
					pb.rank2 = finalTrophy
					pb.city = levelId
					pb.type = res
					pb.timestamp = math.floor(ClientData.getCurrentTime() * 1000)

					pcall(function()
						pb.atk_expend.hero = 0
						pb.atk_expend.horse = 0
						pb.atk_expend.book = 0
						pb.def_expend.hero = 0
						pb.def_expend.horse = 0
						pb.def_expend.book = 0
						pb.boss.damage = 0
						pb.boss.hp = 0
						pb.boss.extra_gold = 0
					end)

					if res == Data.BattleResult.win and levelId and levelId > 0 and P and P._playerWorld and P._playerWorld._curLevel then
						P._playerWorld._curLevel[1] = math.max(P._playerWorld._curLevel[1] or 10101, levelId + 1)
					end

					if customResType and customResNum and customResNum > 0 then
						local rItem = pb.resource:add()
						rItem.info_id = customResType
						rItem.num = customResNum
					elseif deltaGold and deltaGold > 0 then
						local gItem = pb.resource:add()
						gItem.info_id = Data.ResType.gold
						gItem.num = deltaGold
					end

					if rewardItemInfoId and customResNum and customResNum > 0 then
						local pItem = pb.resource:add()
						pItem.info_id = rewardItemInfoId
						pItem.num = customResNum
					end

					local eItem = pb.resource:add()
					eItem.info_id = Data.ResType.exp
					eItem.num = (res == Data.BattleResult.win) and 300 or 100

					pcall(function()
						if pb.task_result and pb.task_result.append then
							pb.task_result:append(true)
							pb.task_result:append(true)
							pb.task_result:append(true)
						else
							table.insert(pb.task_result, true)
							table.insert(pb.task_result, true)
							table.insert(pb.task_result, true)
						end
					end)

					-- Save match replay with actual deltaTrophy and recorded operations
					if api and api.post then
						api:post("save_replay", {
							account_id = accId,
							replay_id = repId,
							opponent_name = oppoName,
							opponent_level = oppoLevel,
							opponent_avatar = oppoAvatar,
							result = (res == Data.BattleResult.win) and 1 or 2,
							battle_type = self._battleType or 17,
							trophy_change = deltaTrophy,
							replay_data = {
								seed = (input and input._randomSeed) or 12345,
								round = curRound,
								result = (res == Data.BattleResult.win) and 1 or 2,
								trophy_change = deltaTrophy,
								timestamp = math.floor(ClientData.getCurrentTime() * 1000),
								player = {
									_name = (P and P._name) or "Duelist",
									_level = (P and P._level) or 1,
									_avatar = (P and P._avatar) or 101,
									_troopCards = myTroopCards,
									_troopLevels = (input and input._player and input._player._troopLevels) or {},
									_fortressHp = (input and input._player and input._player._fortressHp) or (self._player and self._player._fortressHp) or 8000,
									_usedCards = pRecOps
								},
								opponent = {
									_name = oppoName,
									_level = oppoLevel,
									_avatar = oppoAvatar,
									_troopCards = oppoTroopCards,
									_troopLevels = (input and input._opponent and input._opponent._troopLevels) or {},
									_fortressHp = (input and input._opponent and input._opponent._fortressHp) or (self._opponent and self._opponent._fortressHp) or 8000,
									_usedCards = oRecOps
								}
							}
						})
					end

					-- Add to local player log
					pcall(function()
						if P and P._playerLog then
							local newLog = require("Log").new(true, {
								id = repId,
								timestamp = os.time() * 1000,
								result_type = (res == Data.BattleResult.win) and Data.BattleResult.win or Data.BattleResult.lose,
								battle_type = self._battleType or Battle_pb.PB_BATTLE_WORLD_LADDER,
								is_available = true,
								replay_id = repId,
								trophy = deltaTrophy,
								trophy_ex = 0,
								player_info = { id = accId, name = (P and P._name) or "Duelist", level = (P and P._level) or 1, avatar = (P and P._avatar) or 101, trophy = pb.rank2 },
								opponent_info = { id = 9999, name = oppoName, level = oppoLevel, avatar = oppoAvatar, trophy = (input and input._opponent and input._opponent._trophy) or 800 }
							})
							P._playerLog:addLog(newLog, Battle_pb.PB_BATTLE_WORLD_LADDER)
							P._playerLog:addLog(newLog, Battle_pb.PB_BATTLE_PLAYER)
							P._playerLog:addLog(newLog, Battle_pb.PB_BATTLE_MATCH)
							P._playerLog._isClashLogsReady = true
							P._playerLog._isRoomLogsReady = true
							P._playerLog:sendLogDirty(require("PlayerLog").Event.clash_log_dirty)
							P._playerLog:sendLogDirty(require("PlayerLog").Event.room_log_dirty)
							P._playerLog:sendLogDirty(require("PlayerLog").Event.attack_log_dirty)
						end
					end)

					local schedId
					schedId = lc.Scheduler:scheduleScriptFunc(function()
						if schedId then
							lc.Scheduler:unscheduleScriptEntry(schedId)
							schedId = nil
						end
						if self.hideWaitting then self:hideWaitting() end
						local ind = ClientView.getActiveIndicator()
						if ind and ind.hide then ind:hide() end
						local ok, err = pcall(ClientData.onMsg, resp)
						if not ok then
							print('[H5_BATTLE_END_ERR] ' .. tostring(err))
							pcall(function() self:onBattleEnd(pb) end)
						else
							print('[H5_BATTLE_END_OK]')
						end
					end, 0.1, false)
				end

				if isClashRank and api and api.post then
					local isBot = not (input and input._isOppoOnline and input._pvpMatch)
					local oppoTrophy = (input and input._opponent and input._opponent._trophy) or (self._opponent and self._opponent._trophy) or 800
					local battleRounds = (self._player and self._player._round) or (input and input._player and input._player._round) or 1
					local isSurrender = (self._isSurrender == true or (self._player and self._player._isRetreat == true))
					api:post("pvp_reward", {
						account_id = accId,
						result = (res == Data.BattleResult.win) and 1 or 2,
						battle_type = "clash",
						is_bot = isBot,
						is_surrender = isSurrender,
						oppo_trophy = oppoTrophy,
						rounds = battleRounds
					}, function(rawRes)
						local cr = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
						if cr and cr.code == 200 then
							local dTrophy = tonumber(cr.delta_trophy) or ((res == Data.BattleResult.win) and 25 or -15)
							local dGold = tonumber(cr.delta_gold) or ((res == Data.BattleResult.win) and (math.max(0, dTrophy) * 200) or (math.abs(dTrophy) * 20))
							local nTrophy = tonumber(cr.trophy) or math.max(0, ((P and P._playerFindClash and P._playerFindClash._trophy) or 800) + dTrophy)
							local nGold = tonumber(cr.gold) or (((P and P._gold) or 0) + dGold)

							if P then P._gold = nGold end
							if cr.level and P then P._level = cr.level end
							if cr.exp and P then P._exp = cr.exp end
							if cr.reputation ~= nil then
								local nRep = tonumber(cr.reputation) or 50
								if P then P._reputation = nRep end
								if ClientData._account then
									ClientData._account.reputation = nRep
									if cr.next_reputation_in then
										ClientData._account.reputation_updated_at = math.floor(ClientData.getCurrentTime()) - (900 - tonumber(cr.next_reputation_in))
									end
								end
								if isSurrender then
									ToastManager.push(string.format("Bạn đã đầu hàng! Điểm uy tín -1 (Còn %d/55).", nRep))
								end
							end
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.gold_dirty))
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.trophy_dirty))

							finalizeBattleEnd(dTrophy, dGold, nTrophy, nGold)
						else
							-- Fallback on API non-200
							local curT = (P and P._playerFindClash and P._playerFindClash._trophy) or 800
							local diff = math.abs(curT - oppoTrophy)
							local ratio = math.min(1.0, diff / 1000.0)
							local dTrophy = 30
							if res == Data.BattleResult.win then
								if curT >= oppoTrophy then
									dTrophy = math.max(5, math.floor(30 - ratio * 25 + 0.5))
								else
									dTrophy = math.min(100, math.floor(30 + ratio * 70 + 0.5))
								end
							else
								if curT >= oppoTrophy then
									dTrophy = -math.min(100, math.floor(25 + ratio * 75 + 0.5))
								else
									dTrophy = -math.max(5, math.floor(25 - ratio * 20 + 0.5))
								end
							end
							local dGold = (res == Data.BattleResult.win) and (math.max(0, dTrophy) * 200) or (math.abs(dTrophy) * 20)
							finalizeBattleEnd(dTrophy, dGold, math.max(0, curT + dTrophy), ((P and P._gold) or 0) + dGold)
						end
					end)
				elseif res == Data.BattleResult.win and levelId > 0 and api then
					local compFn = api.request or api.post
					if compFn then
						compFn(api, "complete_level", {
							account_id = accId,
							level_id = levelId,
							result = 1,
							stars = 3
						}, function(rawRes)
							local cr = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
							if cr and cr.code == 200 then
								if cr.gold and P then P._gold = cr.gold end
								if cr.next_level and P and P._playerWorld then
									local diff = math.max(1, math.min(4, math.floor(levelId / 10000)))
									P._playerWorld._curLevel[diff] = math.max(P._playerWorld._curLevel[diff] or 0, cr.next_level)
								end
							end
							finalizeBattleEnd(1, 1000, ((P and P._playerFindClash and P._playerFindClash._trophy) or 800) + 1, (P and P._gold) or 1000)
						end)
					else
						finalizeBattleEnd(1, 1000, ((P and P._playerFindClash and P._playerFindClash._trophy) or 800) + 1, (P and P._gold) or 1000)
					end
				elseif self._battleType == Data.BattleType.PVP_survival_ex or (input and input._offlineKind == "survival_ex") then
					local sEx = P and P._playerFindSurvivalEx
					local dGold = (res == Data.BattleResult.win) and 3000 or 500
					local dTrophy = (res == Data.BattleResult.win) and 15 or -10
					local curT = (sEx and sEx._trophy) or 1000
					local newT = math.max(0, curT + dTrophy)
					if sEx then
						sEx._trophy = newT
						if res == Data.BattleResult.win then
							sEx._win = (sEx._win or 0) + 1
							-- Gain +120s survival time (up to 480s)
							sEx._dieTimeStamp = math.min(ClientData.getCurrentTime() + 480, (sEx._dieTimeStamp or ClientData.getCurrentTime()) + 120)

							-- Capture 1-2 cards from opponent's deck
							if oppoTroopCards and #oppoTroopCards > 0 then
								local numCap = math.min(2, #oppoTroopCards)
								for _ = 1, numCap do
									local cEntry = oppoTroopCards[math.random(1, #oppoTroopCards)]
									local cid = type(cEntry) == "table" and (cEntry._infoId or cEntry.info_id or cEntry[1]) or cEntry
									if cid and tonumber(cid) and tonumber(cid) > 0 then
										sEx:addToCaptures(tonumber(cid), 1)
									end
								end
							end

							-- Generate 3 monster skill effects for selection
							sEx._skills[0] = {}
							local poolSkills = { 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020 }
							for i = 1, 3 do
								sEx._skills[0][i] = poolSkills[math.random(1, #poolSkills)]
							end

							-- Reduce remaining hall players
							sEx._hallUserNum = math.max(1, (sEx._hallUserNum or 16) - 1)

							-- Check if sole survivor (Rank 1 Champion!)
							if sEx._hallUserNum <= 1 then
								sEx._rank = 1
								ToastManager.push("CHÚC MỪNG! BẠN LÀ NGƯỜI SỐNG SÓT DUY NHẤT - VÔ ĐỊCH GIẢI ĐẤU!")
								local winCount = sEx._win or 12
								ClientData.sendSurvivalExQuit()
							else
								ToastManager.push(string.format("Thắng trận! Bạn cướp được bài, nhận 3 kỹ năng quái thú. Còn lại %d đấu sĩ.", sEx._hallUserNum))
							end
						else
							sEx._lose = (sEx._lose or 0) + 1
							sEx._hallUserNum = math.max(1, (sEx._hallUserNum or 16) - 1)
							if sEx._lose >= 2 then
								ToastManager.push("Bạn đã bị trừ hết 2 mạng và bị loại khỏi giải đấu!")
								sEx._isInHall = false
								ClientData.sendSurvivalExQuit()
							else
								ToastManager.push("Bạn đã thua 1 mạng! Còn 1 mạng sống duy nhất trong giải đấu.")
							end
						end
					end
					lc.sendEvent(Data.Event.survival_ex_explore_end)
					local jdzcMod = _G.jdzc or package.loaded["jdzc"]
					if jdzcMod and jdzcMod.captureSurvivalEx then
						jdzcMod.captureSurvivalEx()
					end
					finalizeBattleEnd(dTrophy, dGold, newT, ((P and P._gold) or 0) + dGold)
				elseif self._battleType == Data.BattleType.PVP_survival or (input and input._offlineKind == "survival") then
					local sArea = P and P._playerFindSurvival
					local dGold = (res == Data.BattleResult.win) and 2000 or 400
					local curT = (P and P._playerFindClash and P._playerFindClash._trophy) or 800
					if sArea then
						if res == Data.BattleResult.win then
							sArea._win = (sArea._win or 0) + 1
							sArea._captures = sArea._captures or {}
							local cardCounts = {}
							if oppoTroopCards and #oppoTroopCards > 0 then
								for _, cEntry in ipairs(oppoTroopCards) do
									local cid = type(cEntry) == "table" and (cEntry._infoId or cEntry.info_id or cEntry[1]) or cEntry
									if cid and tonumber(cid) and tonumber(cid) > 0 then
										cid = tonumber(cid)
										local ctype = Data.getType(cid)
										if ctype == Data.CardType.monster or ctype == Data.CardType.magic or ctype == Data.CardType.trap then
											local num = type(cEntry) == "table" and (cEntry._num or cEntry.num) or 1
											cardCounts[cid] = (cardCounts[cid] or 0) + (tonumber(num) or 1)
										end
									end
								end
							end
							for cid, count in pairs(cardCounts) do
								local found = false
								for _, cap in ipairs(sArea._captures) do
									if cap._infoId == cid then
										cap._num = (cap._num or 0) + count
										found = true
										break
									end
								end
								if not found then
									table.insert(sArea._captures, { _infoId = cid, _num = count })
								end
							end
							if sArea.sortFunc then
								table.sort(sArea._captures, sArea.sortFunc)
							end
							lc.sendEvent(Data.Event.survival_explore_end)
						else
							sArea._lose = (sArea._lose or 0) + 1
						end
					end
					local jdzcMod = _G.jdzc or package.loaded["jdzc"]
					if jdzcMod and jdzcMod.captureSurvival then
						jdzcMod.captureSurvival()
					end
					finalizeBattleEnd(0, dGold, curT, ((P and P._gold) or 0) + dGold)
				elseif input and input._offlineKind == "expedition_ex" then
					local rewardGem = (res == Data.BattleResult.win) and (tonumber(ClientData._curExpeditionReward) or 100) or 0
					local curT = (P and P._playerFindClash and P._playerFindClash._trophy) or 800
					if res == Data.BattleResult.win and rewardGem > 0 then
						if P then
							P._ingot = (P._ingot or 0) + rewardGem
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.ingot_dirty))
						end
						if api and api.post then
							api:post("claim_expedition_reward", {
								account_id = accId,
								count = rewardGem,
								opponent_id = ClientData._curExpeditionOppId,
								opponent_rank = ClientData._curExpeditionOppRank
							}, function(rawRes)
								local cr = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
								if cr and cr.new_gem and P then
									P._ingot = cr.new_gem
									lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.ingot_dirty))
								end
								if cr and cr.defeated_ids then
									ClientData._defeatedExpeditionIds = cr.defeated_ids
								end
							end)
						end
						if not ClientData._defeatedExpeditionIds then ClientData._defeatedExpeditionIds = {} end
						if ClientData._curExpeditionOppId then table.insert(ClientData._defeatedExpeditionIds, ClientData._curExpeditionOppId) end
						if ClientData._curExpeditionOppRank then table.insert(ClientData._defeatedExpeditionIds, ClientData._curExpeditionOppRank) end
						ClientData._needRefreshExpedition = true
						pcall(function()
							ToastManager.push(string.format("Chiến thắng thám hiểm! Nhận được %d Linh thạch cao cấp (Gem)!", rewardGem))
						end)
					end
					finalizeBattleEnd(0, 0, curT, (P and P._gold) or 0, Data.ResType.ingot, rewardGem)
				else
					-- Non-rank or fallback
					local dGold = (res == Data.BattleResult.win) and 1000 or 200
					local curT = (P and P._playerFindClash and P._playerFindClash._trophy) or 800
					finalizeBattleEnd(0, dGold, curT, ((P and P._gold) or 0) + dGold)
				end
				return
			end

			return oldSendBattleEnd(self)
		end
	end


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

	local oldExitScene = BattleUi.exitScene
	if oldExitScene then
		BattleUi.exitScene = function(self, toSceneId)
			if self._battleType == Data.BattleType.PVP_room or (self._input and self._input._offlineKind == "room") then
				toSceneId = ClientData.SceneId.find
				ClientData._battleFromFindIndex = Data.FindMatchType.clash
				if P and P._playerRoom then
					pcall(function() P._playerRoom:clear() end)
				end
				P._roomId = nil
				P._roomJob = nil
				ClientData._currentMatchId = nil
				ClientData._isOppoOnline = false
			end
			return oldExitScene(self, toSceneId)
		end
	end

	local oldBattleUiInit = BattleUi.init
	if oldBattleUiInit then
		BattleUi.init = function(self, scene, input, nameTag)
			if ClientView and ClientView.updateScreenSize then
				pcall(ClientView.updateScreenSize)
			end
			return oldBattleUiInit(self, scene, input, nameTag)
		end
	end
end



local function patchBaseScene(BaseScene)
	BaseScene = BaseScene or _G.BaseScene
	if not BaseScene then return end
	BaseScene.checkWorking = function(self)
		if ClientData._isWorking == false then return false end
		ClientData._isWorking = true
		return true
	end
	BaseScene.onAttack = function(self, input)
		local fromId = self._sceneId or ClientData.SceneId.city
		ClientData._fromSceneId = fromId
		ClientData._lastSceneId = fromId
		local swScene = require("ResSwitchScene").create(fromId, ClientData.SceneId.battle, input)
		lc.replaceScene(swScene)
	end
end

local function patchResSwitchScene(ResSwitchScene)
	ResSwitchScene = ResSwitchScene or _G.ResSwitchScene
	if not ResSwitchScene then return end

	ResSwitchScene.checkWorking = function(self)
		ClientData._isWorking = true
	end

	ResSwitchScene.switchScene = function(self)
		if rawget(self, "_switchedThisScene") then return end
		rawset(self, "_switchedThisScene", true)

		if self._toSceneId == ClientData.SceneId.battle then
			if ClientView and ClientView.updateScreenSize then
				pcall(ClientView.updateScreenSize)
			end
			lc.replaceScene(require("BattleScene").create(self._input))
			ClientData.sendBattleLoadingDone()
		else
			ClientView.getMenuUI()
			ClientView.getChatPanel()
			ClientView.getResourceUI()

			local var_19_0 = false
			local toId = self._toSceneId

			if toId == ClientData.SceneId.world then
				ClientData.replaceCityScene()
				lc.pushScene(require("WorldScene").create())
				var_19_0 = true
			elseif ClientData._isAutoBattle then
				ClientData.replaceCityScene()
				lc.pushScene(require("FindScene").create(Data.FindMatchType.clash))
			elseif toId == ClientData.SceneId.factory_monster or toId == ClientData.SceneId.factory_magic or toId == ClientData.SceneId.factory_trap or toId == ClientData.SceneId.factory_rare then
				ClientData.replaceCityScene()
				lc.pushScene(require("CardBoxScene").create(toId))
			elseif toId == ClientData.SceneId.manage_troop then
				ClientData.replaceCityScene()
				lc.pushScene(require("HeroCenterScene").create())
			elseif toId == ClientData.SceneId.union then
				ClientData.replaceCityScene()
				lc.pushScene(require("UnionScene").create())
			elseif toId == ClientData.SceneId.find then
				ClientData.replaceCityScene()
				lc.pushScene(require("FindScene").create(ClientData._battleFromFindIndex or Data.FindMatchType.clash))
			elseif toId == ClientData.SceneId.in_room then
				ClientData.replaceCityScene()
				lc.pushScene(require("FindScene").create(Data.FindMatchType.clash))
				lc.pushScene(require("InRoomScene").create())
			elseif toId == ClientData.SceneId.survival_hall then
				ClientData.replaceCityScene()
				lc.pushScene(require("FindScene").create(Data.FindMatchType.survival))
				lc.pushScene(require("SurvivalHallScene").create())
			elseif toId == ClientData.SceneId.survival_ex_hall then
				ClientData.replaceCityScene()
				lc.pushScene(require("FindScene").create(Data.FindMatchType.survival_ex))
				lc.pushScene(require("SurvivalExHallScene").create())
			elseif toId == ClientData.SceneId.union_world then
				lc.replaceScene(require("UnionWorldScene").create())
			elseif toId == ClientData.SceneId.union_war then
				lc.replaceScene(require("UnionWorldScene").create())
				if ClientData._savedUnionData then
					lc.pushScene(require("UnionWarScene").create(ClientData._savedUnionData._city, ClientData._savedUnionData._isAttacking))
				end
			elseif toId == ClientData.SceneId.tavern then
				ClientData.replaceCityScene()
				lc.pushScene(require("TavernScene").create())
			else
				ClientData.replaceCityScene()
				var_19_0 = true
			end

			if var_19_0 then
				if GuideManager.isGuideEnabled() then
					if lc._runningScene then lc._runningScene._needGuideStartStep = true end
				elseif ClientData._battleFromCopy then
					lc.pushScene(require("ExpeditionScene").create())
				else
					local var_19_1 = ClientData._battleFromTravel
					if var_19_1 and (GuideManager.getCurDifficultyStepName() ~= "check duel" or not (P._playerWorld._curLevel[1] > 10104)) and (GuideManager.getCurRecruiteStepName() ~= "check union" or not (P:getMaxCharacterLevel() >= P._playerCity:getUnionUnlockLevel())) then
						require("TravelPanel").create(var_19_1._id):show()
					else
						local var_19_2 = ClientData._battleFromTeach
						if var_19_2 and (GuideManager.getCurDifficultyStepName() ~= "check duel" or not (P._playerWorld._curLevel[1] > 10104)) and (GuideManager.getCurRecruiteStepName() ~= "check union" or not (P:getMaxCharacterLevel() >= P._playerCity:getUnionUnlockLevel())) then
							require("TeachingForm").create(var_19_2):show()
						end
					end
				end
			end

			ClientData._battleFromCopy = nil
			ClientData._battleFromTravel = nil
			ClientData._battleFromTeach = nil
		end
	end

	local origLoadBattleRes = ResSwitchScene.loadBattleRes
	ResSwitchScene.loadBattleRes = function(self)
		rawset(self, "_switchedThisScene", false)
		if origLoadBattleRes then pcall(function() origLoadBattleRes(self) end) end
		local id
		id = lc.Scheduler:scheduleScriptFunc(function()
			lc.Scheduler:unscheduleScriptEntry(id)
			if self and not rawget(self, "_switchedThisScene") and self._toSceneId == ClientData.SceneId.battle then
				self._loadingPercentage = 100
				if self.updateLoadingBar then self:updateLoadingBar() end
				pcall(function()
					ClientData.preloadFonts(true)
					self:preloadBattleAudio()
					self:preloadBattleDragonBones()
				end)
				self:switchScene()
			end
		end, 0.1, false)
	end

	local origLoadCityUnionRes = ResSwitchScene.loadCityUnionRes
	ResSwitchScene.loadCityUnionRes = function(self)
		rawset(self, "_switchedThisScene", false)
		if origLoadCityUnionRes then pcall(function() origLoadCityUnionRes(self) end) end
		local id
		id = lc.Scheduler:scheduleScriptFunc(function()
			lc.Scheduler:unscheduleScriptEntry(id)
			if self and not rawget(self, "_switchedThisScene") and self._toSceneId ~= ClientData.SceneId.battle then
				self._loadingPercentage = 100
				if self.updateLoadingBar then self:updateLoadingBar() end
				self:switchScene()
			end
		end, 0.1, false)
	end
end


local function patchHeroCenterScene(HeroCenterScene)
	local target = HeroCenterScene or _G.HeroCenterScene
	if target and target.onExit then
		local _origHeroCenterExit = target.onExit
		target.onExit = function(self)
			pcall(syncPlayerDecksToWeb)
			if _origHeroCenterExit then return _origHeroCenterExit(self) end
		end
	end
end

local function patchPlayerBonus(PlayerBonus)
	local target = PlayerBonus or _G.PlayerBonus
	if target and target.sendBonusRequest then
		local origSendPlayerBonus = target.sendBonusRequest
		target.sendBonusRequest = function(self, ...)
			if origSendPlayerBonus then pcall(origSendPlayerBonus, self, ...) end
			if P and P._playerAchieve and P._playerAchieve.sendAchieveListDirty then
				P._playerAchieve:sendAchieveListDirty()
			elseif lc and lc.Dispatcher and Data and Data.Event then
				local ev = cc.EventCustom:new(Data.Event.achieve_list_dirty)
				lc.Dispatcher:dispatchEvent(ev)
			end
		end
	end
end

local function patchLogForm(LogForm)
	if not LogForm then return end
	local oldRefreshLog = LogForm.refreshLog
	if oldRefreshLog then
		LogForm.refreshLog = function(self, tabName)
			if tabName and (not self._tabs or self._focusTab ~= self._tabs[tabName]) then
				return
			end
			return oldRefreshLog(self, tabName)
		end
	end
	local oldOnEnter = LogForm.onEnter
	LogForm.onEnter = function(self)
		if oldOnEnter then oldOnEnter(self) end
		pcall(function()
			if ClientData.sendGetPvpLogs then
				ClientData.sendGetPvpLogs(self._type)
			end
		end)
	end
	local oldSetOrCreateItem = LogForm.setOrCreateItem
	if oldSetOrCreateItem then
		LogForm.setOrCreateItem = function(self, itemWidget, logData)
			if itemWidget and not itemWidget._item then
				if itemWidget.getChildren then
					local ch = itemWidget:getChildren()
					if ch and #ch > 0 then
						itemWidget._item = ch[1]
					end
				end
			end
			return oldSetOrCreateItem(self, itemWidget, logData)
		end
	end
end

local function patchBattleStep(BattleStep)
	local target = (type(BattleStep) == "table" and BattleStep) or _G.BattleStep
	if not target or not target.resetWhenBattleStart then return end
	local oldReset = target.resetWhenBattleStart
	target.resetWhenBattleStart = function(self, arg_1_0, ...)
		if arg_1_0 then
			arg_1_0._troopSkins = arg_1_0._troopSkins or {}
			arg_1_0._extraSkills = arg_1_0._extraSkills or {}
		end
		return oldReset(self, arg_1_0, ...)
	end
end

local function patchClientView(ClientView)
	local target = (type(ClientView) == "table" and ClientView) or _G.ClientView
	if not target or type(target) ~= "table" then return end

	target.updateScreenSize = function()
		if not lc or not lc.Director or not lc.Director.getVisibleSize then return end
		local visSize = lc.Director:getVisibleSize()
		if not visSize or visSize.width == 0 or visSize.height == 0 then return end

		target.SCR_SIZE = visSize
		target.SCR_W = visSize.width
		target.SCR_CW = visSize.width / 2
		target.SCR_H = visSize.height
		target.SCR_CH = visSize.height / 2
		target.SCR_EDGE = math.max(0, target.SCR_CW - 768)

		local PlayerUi = _G.PlayerUi
		if PlayerUi and PlayerUi.Pos then
			local var_0_1 = target.SCR_CW - 28
			local var_0_2 = 176
			PlayerUi.Pos.boss = cc.p(target.SCR_CW, target.SCR_CH + 180)
			PlayerUi.Pos.attacker_fortress = cc.p(target.SCR_CW, target.SCR_CH - 250)
			PlayerUi.Pos.defender_fortress = cc.p(target.SCR_CW, target.SCR_CH + 250)
			PlayerUi.Pos.attacker_grave = cc.p(target.SCR_CW - 524, target.SCR_CH - 75)
			PlayerUi.Pos.defender_grave = cc.p(target.SCR_CW - 524, target.SCR_CH + 77)
			PlayerUi.Pos.attacker_rare = cc.p(target.SCR_CW - 524, target.SCR_CH - 210)
			PlayerUi.Pos.defender_rare = cc.p(target.SCR_CW - 525, target.SCR_CH + 214)
			PlayerUi.Pos.attacker_cover = cc.p(target.SCR_CW + 460, target.SCR_CH - 60)
			PlayerUi.Pos.defender_cover = cc.p(target.SCR_CW + 458, target.SCR_CH + 58)
			PlayerUi.Pos.attacker_gems = {
				cc.p(target.SCR_CW - 458, target.SCR_CH - 86),
				cc.p(target.SCR_CW - 458, target.SCR_CH - 150),
				cc.p(target.SCR_CW - 458, target.SCR_CH - 218)
			}
			PlayerUi.Pos.defender_gems = {
				cc.p(target.SCR_CW - 458, target.SCR_CH + 86),
				cc.p(target.SCR_CW - 458, target.SCR_CH + 154),
				cc.p(target.SCR_CW - 458, target.SCR_CH + 218)
			}
			PlayerUi.Pos.attacker_hand_y = target.SCR_CH - 370
			PlayerUi.Pos.defender_hand_y = target.SCR_CH + 410
			PlayerUi.Pos.attacker_board_x = {
				var_0_1,
				var_0_1 + var_0_2,
				var_0_1 - var_0_2,
				var_0_1 + var_0_2 * 2,
				var_0_1 - var_0_2 * 2,
				var_0_1 + var_0_2
			}
			PlayerUi.Pos.defender_board_x = {
				var_0_1,
				var_0_1 - var_0_2,
				var_0_1 + var_0_2,
				var_0_1 - var_0_2 * 2,
				var_0_1 + var_0_2 * 2,
				var_0_1 - var_0_2
			}
			PlayerUi.Pos.attacker_board_y = target.SCR_CH - 150
			PlayerUi.Pos.defender_board_y = target.SCR_CH + 150
			PlayerUi.Pos.attacker_area = target.SCR_CH + 70
		end

		local ClientData = _G.ClientData
		if ClientData and ClientData.initCamera3D then
			pcall(function()
				if ClientData._camera3D then
					ClientData._camera3D:release()
					ClientData._camera3D = nil
				end
				ClientData.initCamera3D()
			end)
		end
	end

	pcall(target.updateScreenSize)
end

local patches = {
	BaseScene = patchBaseScene,
	ResSwitchScene = patchResSwitchScene,
	Data = patchData,
	ClientData = patchClientData,
	ClientView = patchClientView,
	Socket_pb = patchSocket,
	extern = patchExtern,
	lcUtils = patchLcUtils,
	TravelPanel = patchTravelPanel,
	BattleUiTouch = patchBattleUiTouch,
	CardSprite = patchCardSprite,
	PlayerUi = patchPlayerUi,
	BattleUi = patchBattleUi,
	BattleStep = patchBattleStep,
	LogForm = patchLogForm,
	HeroCenterScene = patchHeroCenterScene,
	PlayerBonus = patchPlayerBonus,
}

-- h5_boot calls this once more after main.lua because lcUtils is a
-- side-effect module and may be loaded before the require hook can observe
-- its returned value.
M.patchLcUtils = patchLcUtils
M.patchClientData = patchClientData

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
		patches[name] = nil
		local ok, err = pcall(patch, module)

		if not ok then
			print("[h5] patch " .. tostring(name) .. " failed: " .. tostring(err))
		end
	end

	return module
end



function M.patchLateClientData()
	if PlayerBonus then
		local origSendPlayerBonus = PlayerBonus.sendBonusRequest
		PlayerBonus.sendBonusRequest = function(self, ...)
			if origSendPlayerBonus then pcall(origSendPlayerBonus, self, ...) end
			if P and P._playerAchieve and P._playerAchieve.sendAchieveListDirty then
				P._playerAchieve:sendAchieveListDirty()
			elseif lc and lc.Dispatcher and Data and Data.Event then
				local ev = cc.EventCustom:new(Data.Event.achieve_list_dirty)
				lc.Dispatcher:dispatchEvent(ev)
			end
		end
	end

	-- ==========================================================
	-- GEM TO GOLD EXCHANGE (ExchangeResForm)
	-- 100 Gem = 1,000 Gold (x10)
	-- ==========================================================
	local GEM_GOLD_RATES = {
		{ 100, 1000 },
		{ 1000, 10000 },
		{ 5000, 50000 }
	}

	local function setupPlayerBuyGold(target)
		if not target then return end
		target.getExchangeGold = function(self, tier)
			local r = GEM_GOLD_RATES[tier] or { 100, 1000 }
			return r[1], r[2], Data.ResType.ingot
		end
		target.getBuyGoldTimes = function(self)
			return 999
		end
		target.buyGold = function(self, tier)
			local r = GEM_GOLD_RATES[tier] or { 100, 1000 }
			local cost, gain = r[1], r[2]
			if (self._ingot or 0) < cost then
				return Data.ErrorType.need_more_ingot
			end
			self._ingot = self._ingot - cost
			self._gold = (self._gold or 0) + gain
			if lc and lc.Dispatcher and Data and Data.Event then
				lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.gold_dirty))
				lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.ingot_dirty))
			end
			return Data.ErrorType.ok
		end
	end

	if Player then setupPlayerBuyGold(Player) end
	if P then setupPlayerBuyGold(P) end

	if ClientData then
		ClientData.sendBuyGold = function(tier)
			local r = GEM_GOLD_RATES[tier] or { 100, 1000 }
			local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.post then
				api:post("buy_gold", {
					account_id = accId,
					tier = tier,
					gem_cost = r[1],
					gold_gain = r[2]
				}, function(rawRes)
					local res = rawRes
					if type(res) == "string" then
						pcall(function() res = require("json").decode(res) end)
					end
					if res and res.code == 200 then
						if res.gold and P then P._gold = res.gold end
						if res.gem and P then P._ingot = res.gem end
						if lc and lc.Dispatcher and Data and Data.Event then
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.gold_dirty))
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.ingot_dirty))
						end
						ToastManager.push(res.msg or "Đổi vàng thành công!")
					else
						ToastManager.push((res and res.msg) or "Đổi vàng thất bại!")
					end
				end)
			end
			return true
		end

		-- ==========================================================
		-- QUICK CHAT IN BATTLE
		-- ==========================================================
		local QUICK_TAUNTS = {
			"Gà thế này thì về chuồng đi bạn ơi!",
			"Đánh nhanh lên xem nào, ngủ gật rồi đấy!",
			"Có thế thôi á? Tưởng thế nào!",
			"Rút bài kiểu đấy thì thua là đúng rồi!",
			"Tay bài phế quá thì đầu hàng sớm đi!",
			"Run sợ chưa? Chuỗi combo huỷ diệt bắt đầu!",
			"Cảm ơn đã tặng điểm rank nhé, quá dễ!",
			"Bấm nhanh lên bạn ơi, mạng lag hay não lag?",
			"Khóc đi, khóc to lên xem nào!",
			"Thua một ván thôi mà, đừng cay cú thế chứ!"
		}

		ClientData.sendBattleChat = function(msg)
			local matchId = ClientData._currentMatchId or ""
			local isAiMatch = (string.find(tostring(matchId), "m_ai_") ~= nil) or (matchId == "")
			if not isAiMatch and ClientData._isOppoOnline == false then
				isAiMatch = true
			end

			if not isAiMatch and matchId ~= "" then
				pcall(function()
					local pvpNet = jsbridge and jsbridge.object("jdzcPvp")
					if pvpNet and pvpNet.sendChat then
						pvpNet:sendChat(matchId, tostring(msg))
					end
				end)
			end

			-- If current match is vs Bot: reply with a funny taunt after 1.5s
			if isAiMatch then
				local timerHandle
				timerHandle = lc.Scheduler:scheduleScriptFunc(function()
					if timerHandle then
						pcall(function() lc.Scheduler:unscheduleScriptEntry(timerHandle) end)
						timerHandle = nil
					end
					pcall(function()
						local sceneNow = lc._runningScene or ClientView._scene or (lc.Director and lc.Director:getRunningScene())
						local uiNow = sceneNow and (sceneNow._battleUi or BATTLE_UI_INSTANCE)
						if uiNow and uiNow._opponent and uiNow.addChat and not uiNow._isBattleFinished and not uiNow._isIgnoreChat then
							local randTaunt = QUICK_TAUNTS[math.random(1, #QUICK_TAUNTS)]
							uiNow:addChat(uiNow._opponent, randTaunt)
						end
					end)
				end, 1.5, false)
			end
		end

		_G._onPvpChatReceived = function(msg)
			pcall(function()
				local curScene = lc._runningScene or ClientView._scene or (lc.Director and lc.Director:getRunningScene())
				local battleUi = curScene and (curScene._battleUi or BATTLE_UI_INSTANCE)
				if battleUi and battleUi._opponent and battleUi.addChat and not battleUi._isIgnoreChat and not battleUi._isBattleFinished then
					battleUi:addChat(battleUi._opponent, tostring(msg))
				end
			end)
		end

		-- ==========================================================
		-- CARD LOTTERY / BUY PACKAGE (Late hook to overwrite jdzc mock)
		-- ==========================================================
		local function doBuyPackage(count, isTen, resType, packageIdOverride)
			pcall(injectPacks)
			local rawCount = tonumber(count) or 1
			local numPacks = (rawCount > 100) and (rawCount % 100) or rawCount
			if numPacks <= 0 then numPacks = 1 end
			local numCards = numPacks * 3
			local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1

			local s = lc._runningScene or ClientView._scene or (lc.Director and lc.Director:getRunningScene())
			local actualScene = s and (s._layer or s)

			local boxId = packageIdOverride
			if not boxId or boxId <= 0 then
				if rawCount >= 10000 then
					boxId = rawCount
				elseif actualScene and actualScene._detailData and actualScene._detailData[1] then
					local dVal = actualScene._detailData[1]
					boxId = (type(dVal) == "table" and (dVal._value or dVal._id)) or tonumber(dVal) or 1
				elseif actualScene and actualScene._curRecruitInfo then
					local rVal = actualScene._curRecruitInfo
					boxId = (type(rVal) == "table" and (rVal._value or rVal._id)) or tonumber(rVal) or 1
				else
					boxId = 1
				end
			end

			local isLiyaOrExtra = (boxId and boxId >= 101001 and boxId <= 210050)
			local packIdx = nil
			if isLiyaOrExtra then
				if boxId <= 120050 then
					packIdx = math.floor((boxId - 100000) / 1000)
				elseif boxId <= 174050 then
					packIdx = math.floor((boxId - 120000) / 1000)
				else
					packIdx = math.floor((boxId - 180000) / 1000)
				end
			elseif boxId and boxId >= 1 and boxId <= 20 and LIYA_CARDS_MAP and LIYA_CARDS_MAP[boxId] then
				isLiyaOrExtra = true
				packIdx = boxId
			end

			local costType = (resType == Data.ResType.ingot and "gem") or "gold"
			local costVal = 0
			if costType == "gem" then
				if actualScene and actualScene._curRecruitInfo and actualScene._curRecruitInfo._param and actualScene._curRecruitInfo._param[2] then
					costVal = tonumber(actualScene._curRecruitInfo._param[2]) or 0
				end
			else
				if isLiyaOrExtra then
					costVal = (numPacks >= 50 and 28500) or (numPacks >= 10 and 6000) or (600 * numPacks)
				else
					costVal = (numPacks >= 50 and 22500) or (numPacks >= 10 and 4500) or (500 * numPacks)
				end
			end

			local pool = (ClientData.getPackCardPool and ClientData.getPackCardPool(boxId)) or {}

			local api = jsbridge and jsbridge.object("jdzcApi")
			if not api or not api.post then
				local ind = ClientView.getActiveIndicator()
				if ind and ind.hide then ind:hide() end
				ToastManager.push("Lỗi kết nối máy chủ!")
				return false
			end

			api:post("buy_package", {
				account_id = accId,
				cost_type = costType,
				cost_val = costVal,
				count = numCards,
				package_id = boxId,
				card_pool = pool
			}, function(rawRes)
				local ind = ClientView.getActiveIndicator()
				if ind and ind.hide then ind:hide() end

				local jsonMod = require("json")
				local res = (type(rawRes) == "string") and jsonMod.decode(rawRes) or rawRes
				if res and res.code == 200 and res.cards then
					if res.gold and P then P._gold = res.gold end
					if res.gem and P then P._ingot = res.gem end
					if ClientData._account then
						if res.gold then ClientData._account.gold = res.gold end
						if res.gem then ClientData._account.gem = res.gem end
					end

					if lc and lc.Dispatcher and Data and Data.Event then
						lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.gold_dirty))
						lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.ingot_dirty))
					end

					local msg = {
						type = SglMsgType_pb.PB_TYPE_CARD_LOTTERY,
						status = 0,
						Extensions = {
							[Card_pb.SglCardMsg.card_lottery_resp] = res.cards
						}
					}
					local sCur = lc._runningScene or ClientView._scene or (lc.Director and lc.Director:getRunningScene())
					local actualSceneCur = sCur and (sCur._layer or sCur)
					local handled = false

					if actualSceneCur and actualSceneCur.onMsg then
						if not actualSceneCur._curRecruitInfo and Data._recruitInfo then
							actualSceneCur._curRecruitInfo = Data._recruitInfo[boxId]
						end
						if not actualSceneCur._detailData and Data._recruitInfo then
							local rInfo = actualSceneCur._curRecruitInfo or Data._recruitInfo[boxId]
							if rInfo then
								actualSceneCur._detailData = { rInfo }
							end
						end
						local ok, resVal = pcall(actualSceneCur.onMsg, actualSceneCur, msg)
						if ok and resVal then
							handled = true
						end
					end

					if not handled then
						for _, c in ipairs(res.cards) do
							local cid = tonumber(c.info_id or c.id)
							local cnum = tonumber(c.num or 1) or 1
							if cid and P and P._playerCard and P._playerCard.addCard then
								P._playerCard:addCard(cid, cnum)
							end
						end
						if ClientData.onMsg then
							ClientData.onMsg(msg)
						end
					end
				else
					if costType == "gold" and P and P._gold then
						P._gold = P._gold + costVal
					elseif costType == "gem" and P and P._ingot then
						P._ingot = P._ingot + costVal
					end
					if lc and lc.Dispatcher and Data and Data.Event then
						lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.gold_dirty))
						lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.ingot_dirty))
					end
					ToastManager.push((res and res.msg) or "Mua thẻ bài thất bại!")
				end
			end)
			return true
		end

		ClientData.sendCardLottery = function(count, isTen, resType)
			return doBuyPackage(count, isTen, resType, nil)
		end
		ClientData.sendBuyPackage = function(packageId, count)
			return doBuyPackage(count, false, Data.ResType.gold, packageId)
		end
		ClientData.sendWorldLottery = function(hasToken, count)
			local count = tonumber(count) or 1
			local accId = (P and P._id) or (ClientData and ClientData._account and ClientData._account.id) or 1
			local api = (jsbridge and jsbridge.object and jsbridge.object("jdzcApi")) or (jdzc and jdzc.api)
			local tokenId = Data.PropsId.lottery_token or 7104
			local costIngot = (Data._globalInfo and Data._globalInfo._expeditionDialCost) or 20

			if not hasToken then
				local reqGem = count * costIngot
				if P and P.hasResource and not P:hasResource(Data.ResType.ingot, reqGem) then
					ClientView.getActiveIndicator():hide()
					local curScene = lc._runningScene
					if curScene and curScene.enableBtns then curScene:enableBtns(true) end
					ToastManager.push("Không đủ Linh thạch cao cấp (Gem) để quay thưởng!")
					return
				end
			end

			if api and api.post then
				api:post("lottery_spin", {
					account_id = accId,
					count = count,
					use_token = hasToken and true or false,
					token_id = tokenId,
					cost_ingot = costIngot
				}, function(rawRes)
					local res = nil
					if type(rawRes) == "string" then
						local ok, parsed = pcall(function()
							if json and json.decode then return json.decode(rawRes) end
							return require("json").decode(rawRes)
						end)
						if ok and parsed then res = parsed end
					elseif type(rawRes) == "table" then
						res = rawRes
					end

					if res and res.code == 200 and res.items then
						-- Update local resources
						if res.new_gem and P then
							P._ingot = res.new_gem
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.ingot_dirty))
						end
						if res.new_gold and P then
							P._gold = res.new_gold
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.gold_dirty))
						end
						if res.lottery_power ~= nil then
							ClientData._lotteryPower = res.lottery_power
						else
							ClientData._lotteryPower = (ClientData._lotteryPower or 0) + count
						end

						if hasToken and P and P._propBag then
							pcall(function()
								P._propBag:useProps(tokenId, count)
								lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.prop_dirty, { _infoId = tokenId }))
							end)
						end

						-- Add cards or items
						for _, it in ipairs(res.items) do
							local infoId = it.info_id
							local num = it.num
							if infoId and infoId >= 10000 and P and P._playerCard then
								pcall(function() P._playerCard:addCard(infoId, num) end)
							elseif infoId and infoId < 10000 and infoId ~= 1 and infoId ~= 3 and P and P._propBag then
								pcall(function() P._propBag:addProps(infoId, num) end)
							end
						end

						-- Build response
						local respItems = {}
						for _, it in ipairs(res.items) do
							table.insert(respItems, {
								info_id = it.info_id,
								num = it.num,
								slot = it.slot or 1,
								level = 1
							})
						end

						local resp = {
							type = SglMsgType_pb.PB_TYPE_WORLD_LOTTERY,
							status = 0,
							Extensions = {
								[World_pb.SglWorldMsg.world_lottery_resp] = respItems
							}
						}
						ClientData.onMsg(resp)
					else
						ClientView.getActiveIndicator():hide()
						local curScene = lc._runningScene
						if curScene and curScene.enableBtns then curScene:enableBtns(true) end
						local msg = (res and res.msg) or "Quay thưởng thất bại!"
						ToastManager.push(msg)
					end
				end)
			else
				ClientView.getActiveIndicator():hide()
				local curScene = lc._runningScene
				if curScene and curScene.enableBtns then curScene:enableBtns(true) end
				ToastManager.push("Không thể kết nối đến máy chủ!")
			end
		end
		ClientData.sendWorldLotteryEx = ClientData.sendWorldLottery
		ClientData.sendWorldLotteryActivity = ClientData.sendWorldLottery
		ClientData.sendWeekLottery = ClientData.sendWorldLottery

		-- ==========================================================
		-- USER VISIT / INSPECT DECK (Late hook)
		-- ==========================================================
		local function deliverVisitLate(visitData)
			local msg = {
				type = SglMsgType_pb.PB_TYPE_USER_VISIT,
				status = 0,
				Extensions = {
					[User_pb.SglUserMsg.user_visit_resp] = visitData
				}
			}
			if ClientData.onMsg then
				ClientData.onMsg(msg)
			end
		end

		ClientData.sendUserVisit = function(userId)
			local uid = tonumber(userId) or (ClientData._account and ClientData._account.id) or (P and P._id) or 1
			local api = jsbridge and jsbridge.object("jdzcApi")
			local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
			local curTroop = (P and P._curTroopIndex) or 1
			if api and api.post then
				api:post("user_visit", { user_id = uid, my_user_id = myAccId, cur_troop = (tonumber(uid) == tonumber(myAccId) and curTroop or nil) }, function(rawRes)
					local jsonMod = require("json")
					local res = (type(rawRes) == "string") and jsonMod.decode(rawRes) or rawRes
					if res and res.visit then
						deliverVisitLate(res.visit)
					else
						deliverVisitLate({
							user_info = {
								id = uid, name = "Duelist_" .. tostring(uid), level = 20, trophy = 800, avatar = 301,
								gold = 0, grain = 0, ingot = 0, exp = 0, vip = 0, shield = 0,
								union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
								last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
							},
							troop = {},
							pre_rank = 1, best_rank = 1, legend_trophy = 800, pre_legend_rank = 1, best_legend_rank = 1
						})
					end
				end)
			else
				deliverVisitLate({
					user_info = {
						id = uid, name = "Duelist_" .. tostring(uid), level = 20, trophy = 800, avatar = 301,
						gold = 0, grain = 0, ingot = 0, exp = 0, vip = 0, shield = 0,
						union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
						last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
					},
					troop = {},
					pre_rank = 1, best_rank = 1, legend_trophy = 800, pre_legend_rank = 1, best_legend_rank = 1
				})
			end
		end

		-- ==========================================================
		-- CARD DECOMPOSE & BATCH DECOMPOSE (Late hooks)
		-- ==========================================================
		ClientData.sendCardDecompose = function(infoId, count)
			local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.post then
				api:post("decompose_card", { account_id = accId, card_id = tonumber(infoId), count = tonumber(count) or 1 }, function(rawRes)
					local res = rawRes
					if type(res) == "string" then
						local ok, parsed = pcall(function() return require("json").decode(res) end)
						if ok and parsed then res = parsed end
					end
					if res and res.code == 200 and res.gold and P then
						P._gold = res.gold
						if P.sendGoldDirty then
							P:sendGoldDirty()
						end
					end
				end)
			end
		end

		ClientData.sendCardDecomposeBatch = function()
			local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.post then
				api:post("decompose_all", { account_id = accId }, function(rawRes)
					local res = rawRes
					if type(res) == "string" then
						local ok, parsed = pcall(function() return require("json").decode(res) end)
						if ok and parsed then res = parsed end
					end
					if res and res.code == 200 and res.gold and P then
						P._gold = res.gold
						if P.sendGoldDirty then
							P:sendGoldDirty()
						end
					end
				end)
			end
		end

		-- ==========================================================
		-- EFFECT SHOP & BATTLEFIELD / RACIAL EFFECTS SYSTEM (Late hooks)
		-- ==========================================================
		local PlayerCardCls = package.loaded["PlayerCard"] or require("PlayerCard")
		local SkinCls = package.loaded["Skin"] or require("Skin")

		-- 1. Patch PlayerCard:cardHasSkin
		local orig_pc_cardHasSkin = PlayerCardCls.cardHasSkin
		PlayerCardCls.cardHasSkin = function(self, cardId, skinOrEffectId, checkExpire)
			cardId = cardId and Data.removeAdditional(cardId)
			skinOrEffectId = tonumber(skinOrEffectId) or 0
			if skinOrEffectId == 0 then return true end

			if orig_pc_cardHasSkin and orig_pc_cardHasSkin(self, cardId, skinOrEffectId, checkExpire) then
				return true
			end

			local sInfo = Data._skinInfo and Data._skinInfo[skinOrEffectId]
			if sInfo and sInfo._type and sInfo._type >= 2 and sInfo._type <= 4 then
				local isUnlocked = (self._globalUnlockedEffects and self._globalUnlockedEffects[skinOrEffectId])
				if not isUnlocked and self._skins and self._skins[0] then
					isUnlocked = self._skins[0]:isSkinIdAvailable(skinOrEffectId, checkExpire)
				end

				if not isUnlocked and lc and lc.UserDefault and lc.UserDefault.getBoolForKey then
					if lc.UserDefault:getBoolForKey("unlocked_effect_" .. skinOrEffectId, false) then
						isUnlocked = true
					end
				end

				if isUnlocked then
					if cardId and cardId > 0 then
						self._skins = self._skins or {}
						local skinObj = self._skins[cardId] or SkinCls.new(cardId)
						self._skins[cardId] = skinObj
						skinObj:addAvailable(skinOrEffectId, 0)
					end
					return true
				end
			end

			return false
		end

		-- 2. Patch PlayerCard:buySkinId
		local orig_pc_buySkinId = PlayerCardCls.buySkinId
		PlayerCardCls.buySkinId = function(self, skinOrEffectId, expire, cardId)
			cardId = cardId and Data.removeAdditional(cardId)
			skinOrEffectId = tonumber(skinOrEffectId) or 0
			local sInfo = Data._skinInfo and Data._skinInfo[skinOrEffectId]
			if not sInfo then return false end

			if sInfo._type and sInfo._type >= 2 and sInfo._type <= 4 then
				if self:cardHasSkin(cardId, skinOrEffectId, true) then
					return false
				end

				self._skins = self._skins or {}
				local skinObj = self._skins[cardId] or SkinCls.new(cardId)
				self._skins[cardId] = skinObj
				skinObj:addAvailable(skinOrEffectId, expire or 0)

				self._globalUnlockedEffects = self._globalUnlockedEffects or {}
				self._globalUnlockedEffects[skinOrEffectId] = true
				local skinObj0 = self._skins[0] or SkinCls.new(0)
				self._skins[0] = skinObj0
				skinObj0:addAvailable(skinOrEffectId, expire or 0)

				if lc and lc.UserDefault and lc.UserDefault.setBoolForKey then
					lc.UserDefault:setBoolForKey("unlocked_effect_" .. skinOrEffectId, true)
				end

				local effCat = sInfo._category or 0
				for cid, s in pairs(self._skins) do
					if cid > 0 then
						local cinfo = Data.getInfo(cid)
						if cinfo and (effCat == 0 or cinfo._category == effCat) then
							s:addAvailable(skinOrEffectId, 0)
						end
					end
				end

				lc.sendEvent(Data.Event.skin_dirty)
				return true
			end

			return orig_pc_buySkinId and orig_pc_buySkinId(self, skinOrEffectId, expire, cardId)
		end

		-- 3. Patch PlayerCard:setSkinId
		local orig_pc_setSkinId = PlayerCardCls.setSkinId
		PlayerCardCls.setSkinId = function(self, cardId, skinOrEffectId, effectType, ...)
			cardId = cardId and Data.removeAdditional(cardId)
			effectType = effectType or Data.SkinEffectType.skin
			skinOrEffectId = tonumber(skinOrEffectId) or 0

			if effectType >= 2 and effectType <= 4 then
				self._skins = self._skins or {}
				local skinObj = self._skins[cardId] or SkinCls.new(cardId)
				self._skins[cardId] = skinObj

				if skinOrEffectId == 0 then
					skinObj:setCurrentId(0, effectType)
					lc.sendEvent(Data.Event.skin_dirty)
					return true
				end

				if self:cardHasSkin(cardId, skinOrEffectId, true) then
					skinObj:addAvailable(skinOrEffectId, 0)
					skinObj:setCurrentId(skinOrEffectId, effectType)
					lc.sendEvent(Data.Event.skin_dirty)
					return true
				end
				return false
			end

			return orig_pc_setSkinId and orig_pc_setSkinId(self, cardId, skinOrEffectId, effectType, ...)
		end

		if P and P._playerCard then
			P._playerCard.cardHasSkin = PlayerCardCls.cardHasSkin
			P._playerCard.buySkinId = PlayerCardCls.buySkinId
			P._playerCard.setSkinId = PlayerCardCls.setSkinId
		end

		-- 4. Hook ClientData.sendBuyEffect
		ClientData.sendBuyEffect = function(cardInfoId, effectId, effectType)
			cardInfoId = tonumber(cardInfoId) or 0
			effectId = tonumber(effectId) or 0
			local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api then
				if api.buyEffect then
					api:buyEffect(accId, cardInfoId, effectId, function(rawRes)
						local res = rawRes
						if type(res) == "string" then
							local ok, parsed = pcall(function() return require("json").decode(res) end)
							if ok and parsed then res = parsed end
						end
						if res and res.code == 200 then
							if res.gem and P then P._ingot = res.gem end
							if res.crystal and P and P._propBag and P._propBag._props and P._propBag._props[7149] then
								P._propBag._props[7149]._num = res.crystal
							end
							if P and P.sendResourceDirty then
								P:sendResourceDirty()
							end
						end
					end)
				elseif api.post then
					api:post("/api/buy_effect", { account_id = accId, card_id = cardInfoId, effect_id = effectId }, function(rawRes)
						local res = rawRes
						if type(res) == "string" then
							local ok, parsed = pcall(function() return require("json").decode(res) end)
							if ok and parsed then res = parsed end
						end
						if res and res.code == 200 then
							if res.gem and P then P._ingot = res.gem end
							if res.crystal and P and P._propBag and P._propBag._props and P._propBag._props[7149] then
								P._propBag._props[7149]._num = res.crystal
							end
							if P and P.sendResourceDirty then
								P:sendResourceDirty()
							end
						end
					end)
				end
			end
		end

		-- 5. Hook ClientData.sendSetSkin
		ClientData.sendSetSkin = function(cardInfoId, skinOrEffectId)
			cardInfoId = tonumber(cardInfoId) or 0
			skinOrEffectId = tonumber(skinOrEffectId) or 0
			local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1

			local effId = math.abs(skinOrEffectId)
			local effType = 0
			if (53001 <= effId and effId <= 53022) then effType = 2
			elseif (53101 <= effId and effId <= 53122) then effType = 3
			elseif (53201 <= effId and effId <= 53222) then effType = 4
			end

			if effType > 0 and cardInfoId > 0 and lc and lc.UserDefault and lc.UserDefault.setStringForKey then
				local savedStr = lc.UserDefault:getStringForKey("card_effects_" .. cardInfoId, "")
				local sData = {}
				if savedStr ~= "" then
					local ok, d = pcall(function() return require("json").decode(savedStr) end)
					if ok and type(d) == "table" then sData = d end
				end
				local k = effType == 2 and "toBoard" or (effType == 3 and "onBoard" or "attack")
				sData[k] = (skinOrEffectId > 0) and effId or 0
				lc.UserDefault:setStringForKey("card_effects_" .. cardInfoId, require("json").encode(sData))
			end

			local targetEffectId = (skinOrEffectId > 0) and effId or 0
			local api = jsbridge and jsbridge.object("jdzcApi")
			if effType > 0 and api then
				if api.setEffect then
					api:setEffect(accId, cardInfoId, targetEffectId, effType, function() end)
				elseif api.post then
					api:post("/api/set_effect", { account_id = accId, card_id = cardInfoId, effect_id = targetEffectId, effect_type = effType }, function() end)
				end
			end
		end
	end
end


function M.patchAudio()
	if not lc or not lc.Audio then return end
	local origPlayAudio = lc.Audio.playAudio
	if origPlayAudio and not lc.Audio._playAudioProtected then
		lc.Audio._playAudioProtected = true
		lc.Audio.playAudio = function(id, loop, tbl)
			tbl = tbl or "main"
			if lc.Audio._configs and lc.Audio._configs[tbl] then
				if not lc.Audio._configs[tbl][id] then
					if id == 33 or (AUDIO and id == AUDIO.M_BATTLE_FLO) then
						lc.Audio.addAudio("res/audio/m_battle_flo.mp3", lc.Audio.Behavior.music or 0, 228, 2, true, 2, 0, tbl)
					end
				end
			end
			if not lc.Audio._configs or not lc.Audio._configs[tbl] or not lc.Audio._configs[tbl][id] then
				print(string.format("[lc.Audio.playAudio] Warning: audio id '%s' in table '%s' not found! Skipping.", tostring(id), tostring(tbl)))
				return
			end
			return origPlayAudio(id, loop, tbl)
		end
	end
end

pcall(M.patchAudio)

if _G.PlayerBattle and not _G.PlayerBattle.getGraveCards then
	_G.PlayerBattle.getGraveCards = function(self)
		return self._graveCards or {}
	end
end

return M