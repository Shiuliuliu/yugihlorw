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
local function syncPlayerDecksToWeb()
	local now = os.time()
	if now - _lastSyncTime < 2 then return end
	_lastSyncTime = now
	if not P then return end
	local accId = ClientData._account and ClientData._account.id or 1
	local api = jsbridge and jsbridge.object("jdzcApi")
	if not (api and api.saveDeck) then return end

	local jsonMod = require("json")
	for slot = 1, 5 do
		local cloneTroop = ClientData and ClientData._cloneTroops and ClientData._cloneTroops[slot]
		local pTroop = P._playerCard and P._playerCard._troops and P._playerCard._troops[slot]
		local troop = (cloneTroop and #cloneTroop > 0 and cloneTroop) or pTroop
		if troop and #troop > 0 then
			local cards = {}
			local extra = {}
			for _, item in ipairs(troop) do
				local cid = type(item) == "table" and (item._infoId or item.info_id) or item
				cid = tonumber(cid)
				local count = type(item) == "table" and (tonumber(item._num) or tonumber(item.num)) or 1
				if cid and cid > 0 then
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
			api:saveDeck(accId, slot, "Bộ Bài " .. tostring(slot), cStr, eStr)
		end
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
				local rankList = {}
				local myId = (P and P._id) or 0
				local selfInList = false
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

				local selfEntry = {
					rank = myRankNum,
					value = myVal,
					user_info = myUInfo
				}

				if not selfInList and myId > 0 then
					table.insert(rankList, selfEntry)
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
						if not ranksObj._selfRank then
							local rankCls = require("Rank")
							local sRankObj = rankCls.new()
							sRankObj:set(selfEntry, rankType or SglMsgType_pb.PB_TYPE_RANK_LADDER, subType)
							ranksObj._selfRank = sRankObj
						elseif sr.rank then
							ranksObj._selfRank._rank = sr.rank
							ranksObj._selfRank._value = myVal
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
					pData._cardBackId = pData._cardBackId or 1
					pData._region = pData._region or 1
					pData._regionId = pData._regionId or 1
					pData._privilege = pData._privilege or 0
					pData._monthCardType = pData._monthCardType or 0
					pData._isNpc = false
					pData._isNewRound = false
					pData._roundTimeInit = 30
					pData._roundTimeMax = 45
					pData._roundTimeDelta = 0
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
					oData._cardBackId = oData._cardBackId or 1
					oData._region = oData._region or 1
					oData._regionId = oData._regionId or 1
					oData._privilege = oData._privilege or 0
					oData._monthCardType = oData._monthCardType or 0
					oData._isNpc = false
					oData._isNewRound = false
					oData._roundTimeInit = 30
					oData._roundTimeMax = 45
					oData._roundTimeDelta = 0
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

					local repLog = ClientData._replayingLog or {
						_id = replayId,
						_replayId = replayId,
						_resultType = repRes,
						_isAttack = true,
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
						_isAttacker = true,
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
		elseif battleType == Battle_pb.PB_BATTLE_SURVIVAL or battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX then
			matchType = Data.FindMatchType.survival
			offlineKind = "survival"
			bType = Battle_pb.PB_BATTLE_SURVIVAL
			sType = Data.BattleType.PVP_clash_npc
		elseif battleType == Battle_pb.PB_BATTLE_WORLD_LEGEND then
			matchType = Data.FindMatchType.clash_ex
			offlineKind = "clash_ex"
			bType = Battle_pb.PB_BATTLE_WORLD_LEGEND
			sType = Data.BattleType.PVP_clash_npc
		end

		ClientData._battleFromFindIndex = matchType
		ClientData.setBattleFromSceneId(ClientData.SceneId.find)
		ClientData._isOppoOnline = false
		ClientData._usedCardsToAdd = {}
		ClientData._observeUsedCards = {}

		local pTroop = (P and P._playerCard and P._playerCard._troops and P._playerCard._troops[troopIndex or P._curTroopIndex or 1]) or {}
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
				table.insert(playerSkins, { skin_id = 0, info_id = cid, effect_ids = {} })
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
				table.insert(playerSkins, { skin_id = 0, info_id = cid, effect_ids = {} })
				table.insert(rawCardIds, cid)
				totalPlayerCards = totalPlayerCards + 1
			end
		end

		local grade = (P and P._playerFindClash and P._playerFindClash._grade) or 1
		local sceneType = 10 + math.max(1, math.min(6, tonumber(grade) or 1))

		local function startWithOppo(oppoName, oppoLevel, oppoAvatar, oppoCardIds, seed, isRealHuman, matchId, isAttacker, isOppoOnline, oppoCrown)
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
					table.insert(oppoSkins, { skin_id = 0, info_id = cid, effect_ids = {} })
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
					table.insert(oppoSkins, { skin_id = 0, info_id = cid, effect_ids = {} })
					oppoCount = oppoCount + 1
				end
			end

			local isOnlinePvp = (isRealHuman == true and isOppoOnline == true and matchId ~= nil)
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
				_matchId = matchId,
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
					_roundTimeInit = 90,
					_roundTimeMax = 90,
					_roundTimeDelta = 0,
					_fortressHp = 8000,
					_avatarFrameId = 0,
					_isNewRound = true,
					_idInRoom = 0,
					_bossId = 0,
					_privilege = 0,
					_avatarFrameCount = 0,
					_regionId = 1,
					_avatarFrame = 0,
					_vip = (P and P._vip) or 0,
					_id = (P and P._id) or 1,
					_name = (P and P._name) or "Player",
					_avatar = ((P and P._avatar) or 2) * 100 + 1,
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
					_roundTimeInit = 90,
					_roundTimeMax = 90,
					_roundTimeDelta = 0,
					_fortressHp = 8000,
					_avatarFrameId = 0,
					_isNewRound = true,
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
					_isNpc = not isRealHuman,
					_troopCards = oppoCards,
					_troopLevels = oppoLevels,
					_troopSkins = oppoSkins,
					_usedCards = {},
					_trophy = ((P and P._playerFindClash and P._playerFindClash._trophy) or 800) + math.random(-20, 20)
				}
			}

			if isOnlinePvp then
				local pvpNet = jsbridge and jsbridge.object("jdzcPvp")
				if pvpNet then
					local myId = (P and P._id) or 1
					pvpNet:connect(matchId, myId, function(intsJson)
						local ok, ints = pcall(json.decode, intsJson)
						if ok and type(ints) == "table" and #ints > 0 then
							ClientData._usedCardsToAdd = ClientData._usedCardsToAdd or {}
							for _, val in ipairs(ints) do
								table.insert(ClientData._usedCardsToAdd, tonumber(val) or 0)
							end
							local scene = lc._runningScene or ClientView._scene
							local bUi = scene and scene._battleUi
							if bUi and type(bUi.oppoTryUseCard) == "function" then
								bUi:oppoTryUseCard()
							end
						end
					end, function()
						local scene = lc._runningScene or ClientView._scene
						local bUi = scene and scene._battleUi
						if bUi and not bUi._isBattleEndSended then
							local waitTime = (not bUi._round or bUi._round < 1) and 3.0 or 0.5
							bUi:runAction(lc.sequence(waitTime, function()
								local curScene = lc._runningScene or ClientView._scene
								local curUi = curScene and curScene._battleUi
								if curUi and not curUi._isBattleEndSended then
									curUi._forceResult = Data.BattleResult.win
									curUi:hideThinking()
									if curUi._opponent and type(curUi.retreat) == "function" then
										curUi:retreat(curUi._opponent)
									else
										curUi:sendBattleEnd(false, Data.BattleResult.win)
									end
									ToastManager.push("Đối thủ đã rời trận, bạn đã giành chiến thắng!")
								end
							end))
						end
					end, function(peerResult)
						local scene = lc._runningScene or ClientView._scene
						local bUi = scene and scene._battleUi
						if bUi and not bUi._isBattleEndSended then
							local myRes = (tostring(peerResult) == "1" and Data.BattleResult.win or Data.BattleResult.lose)
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

		local api = jsbridge and jsbridge.object("jdzcApi")
		local reqPayload = {
			account_id = (ClientData._account and ClientData._account.id) or (P and P._id) or 1,
			name = (P and P._name) or "Player",
			level = (P and P._level) or 50,
			avatar = ((P and P._avatar) or 2) * 100 + 1,
			cards = rawCardIds
		}

		if api and api.post then
			api:post("pvp_match", reqPayload, function(rawRes)
				if not ClientData._isFindingMatch or ClientData._findMatchSeq ~= curSeq then
					print("[PVP] Match response ignored because find was cancelled.")
					return
				end
				local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
				if res and res.status == "cancelled" then
					print("[PVP] Server confirmed matchmaking cancelled.")
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
					startWithOppo(o.name, o.level, o.avatar, o.cards, res.seed, res.is_real_player, res.match_id, res.is_attacker, res.oppo_online, oppoCrown)
				else
					-- Fallback to default troop
					startWithOppo("Vua Trò Chơi", 50, 201, nil, nil, false, nil, true, false, nil)
				end
			end)
		else
			startWithOppo("Vua Trò Chơi", 50, 201, nil, nil, false, nil, true, false, nil)
		end
	end

	ClientData.sendWorldFindExCancel = function()
		ClientData._isFindingMatch = false
		ClientData._findMatchSeq = (ClientData._findMatchSeq or 0) + 1
		local myId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
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

		if ClientData._isOppoOnline and ClientData._currentMatchId then
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
				pcall(function()
					pvpNet:sendAction(ClientData._currentMatchId, json.encode(ints))
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
	ClientData.sendBuyDiamond = function(id) return true end
	ClientData.sendBuyRare = function(id) return true end
	local function doBuyDepot(depotId, count)
		pcall(function()
			local prod = Data._productsExInfo and Data._productsExInfo[depotId]
			local cardId = prod and (prod._cardId or prod._infoId) or (depotId == 59 and 40209 or 0)
			local cost = prod and (prod._price or prod._cost) or (depotId == 59 and 100000 or 0)
			if cardId == 40209 then cost = 100000 end
			local totalCost = cost * (count or 1)
			local api = jsbridge and jsbridge.object("jdzcApi")
			local reqFn = api and (api.request or api.post)
			if reqFn then
				local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
				reqFn(api, "buy_depot", {
					account_id = accId,
					depot_id = depotId,
					card_id = cardId,
					cost = totalCost
				}, function(rawRes)
					local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
					if res and res.gold and P then
						P._gold = res.gold
					end
				end)
			end
		end)
		return true
	end

	ClientData.sendBuyDepot = function(id) return doBuyDepot(id, 1) end
	ClientData.sendBuySkin = function(skinId, skinType) return true end
	ClientData.sendBuyGoods = function(id, count) return doBuyDepot(id, count) end
	ClientData.sendProductBuy = function(prod) return true end
	ClientData.sendBuyPackage = function(packageId, count) return true end

	local CHAR_CARDS_MAP = {
		[3] = {10004, 10006, 10048, 10242, 10266, 10477, 10624, 10645, 10702, 10849, 10850, 10867, 10897, 11146, 11147, 11148, 11149, 11150, 11151, 11152, 11153, 11154, 11155, 11156, 11157, 11158, 11159, 11225, 11252, 11297, 11299, 11300, 11301, 11302, 11303, 11309, 11336, 11379, 11510, 11512, 11577, 11594, 11609, 11610, 11615, 11619, 11622, 11632, 11633, 11730, 11797, 11798, 11804, 11875, 11918, 12043, 12051, 12052, 12053, 12093, 12127, 12130, 12181, 12204, 12251, 12265, 12266, 12273, 12282, 12283, 12307, 12310, 20001, 20002, 20003, 20006, 20009, 20010, 20012, 20013, 20014, 20027, 20043, 20160, 20432, 20433, 20456, 20493, 20518, 20519, 20520, 20529, 20543, 20544, 20646, 20664, 20750, 20751, 20760, 20764, 20765, 20815, 20900, 20911, 20913, 20951, 20960, 21045, 21098, 21126, 30022, 30024, 30031, 30161, 30247, 30248, 30383, 30388, 30389, 30479, 30554, 40140, 40141, 40142, 40143, 40150, 40157, 40173, 40199, 40200, 40201, 40202, 40441, 40442, 40494, 40495, 40496, 40617, 40664, 40709, 40712},
		[2] = {10001, 10013, 10029, 10212, 10335, 10342, 10343, 10361, 10498, 10502, 10646, 10651, 10703, 10705, 10706, 10720, 10729, 10730, 10731, 10814, 10930, 10968, 10986, 10987, 10988, 10989, 10990, 10991, 10992, 10993, 10994, 10995, 10996, 11040, 11041, 11042, 11048, 11049, 11050, 11051, 11075, 11076, 11079, 11080, 11081, 11091, 11092, 11120, 11289, 11329, 11363, 11402, 11567, 11568, 11613, 11618, 11898, 11899, 11947, 11948, 11969, 12140, 12151, 12177, 12224, 12275, 12291, 12299, 20052, 20275, 20303, 20360, 20365, 20366, 20367, 20368, 20369, 20370, 20371, 20372, 20373, 20374, 20375, 20401, 20402, 20408, 20412, 20413, 20524, 20525, 20553, 20893, 20899, 20959, 20966, 20967, 20980, 21090, 21093, 21097, 21127, 21132, 30120, 30158, 30357, 30379, 30575, 30578, 40001, 40013, 40033, 40037, 40090, 40091, 40092, 40093, 40102, 40103, 40115, 40133, 40138, 40139, 40148, 40153, 40203, 40250, 40256, 40301, 40354, 40355, 40454, 40478, 40480, 40504, 40531, 40648, 40680, 40686, 40708, 40719, 40722},
		[5] = {10086, 10118, 10405, 10620, 10621, 10622, 10787, 10815, 10848, 11013, 11020, 11093, 11221, 11318, 11319, 11320, 11321, 11322, 11323, 11324, 11325, 11326, 11327, 11328, 11365, 11368, 11497, 11498, 11499, 12037, 12039, 12040, 12091, 12092, 12167, 12168, 12312, 20189, 20190, 20197, 20198, 20292, 20380, 20534, 20535, 20536, 20538, 20549, 20551, 20552, 20565, 20840, 21018, 21020, 30036, 30124, 30132, 30138, 30423, 30424, 30425, 30442, 40160, 40194, 40210, 40211, 40212, 40213, 40288, 40431, 40498, 40585, 40616, 40675, 40718},
		[4] = {10075, 10076, 10077, 10119, 10120, 10121, 10122, 10123, 10284, 10285, 10783, 10784, 10785, 10786, 11121, 11122, 11123, 11124, 11125, 11126, 11127, 11128, 11129, 11130, 11224, 11337, 11694, 12088, 12089, 12192, 20053, 20054, 20117, 20301, 20333, 20425, 20426, 20641, 21051, 21094, 30064, 30065, 30066, 30171, 30238, 30239, 30240, 40047, 40052, 40128, 40129, 40130, 40131, 40476, 40613, 40659, 40662},
		[15] = {10290, 10291, 10683, 10684, 10685, 10686, 10687, 10688, 10689, 10715, 10718, 10726, 10758, 10828, 10938, 10942, 10943, 10944, 10945, 11227, 11416, 11417, 11461, 11463, 11555, 12008, 12042, 12173, 40010, 40038, 40039, 40040, 40041, 40042, 40043, 40044, 40045, 40048, 40049, 40050, 40051, 40053, 40055, 40057, 40058, 40060, 40061, 40062, 40063, 40064, 40065, 40066, 40146, 40263, 40272, 40273, 40274, 40276, 40277, 40279, 40280, 40281, 40334, 40335, 40336, 40606, 40658, 40697},
		[16] = {11085, 11086, 11087, 11088, 11089, 11090, 11254, 11255, 11256, 11257, 11258, 11259, 11260, 11261, 11262, 11432, 11433, 11434, 11435, 11436, 11437, 11440, 11707, 11915, 12041, 12137, 12253, 20406, 20407, 20441, 20494, 20495, 20496, 20924, 21123, 30203, 30226, 30227, 30228, 30229, 30250, 30278, 30279, 30422, 30494, 30590, 40088, 40110, 40111, 40112, 40113, 40114, 40174, 40177, 40178, 40179, 40180, 40399, 40457, 40515, 40704, 40705, 40706},
		[7] = {10868, 10869, 10870, 10871, 10879, 10920, 10925, 10926, 11554, 20317, 20318, 20319, 20320, 20321, 20322, 20339, 20340, 20341, 20690, 20691, 20692, 30177, 40332, 40333},
		[10] = {12158, 12159, 12160, 12161, 12162, 12163, 12164, 12165, 12171, 12172, 21085, 21086, 21087, 21088, 30576, 40651, 40652, 40653, 40654, 40655, 40656, 40657, 40699},
		[8] = {10109, 10325, 10507, 10508, 10514, 10515, 10669, 10748, 10781, 10782, 10922, 11160, 11286, 11393, 11394, 11395, 11396, 11397, 11398, 11399, 11400, 11401, 11493, 11532, 11533, 11535, 11955, 11956, 11957, 11973, 11974, 11975, 11976, 11977, 11978, 11979, 11996, 11997, 12143, 12144, 12169, 12170, 12189, 12200, 12201, 12202, 12215, 20093, 20153, 20226, 20490, 20584, 20585, 20586, 20989, 20990, 20991, 21078, 21101, 30154, 30322, 30323, 30324, 30515, 30516, 30517, 30518, 30571, 30583, 40144, 40246, 40275, 40282, 40316, 40532, 40533, 40543, 40544, 40545, 40546, 40547, 40548, 40549, 40550, 40627, 40668},
		[9] = {10482, 10483, 10484, 10485, 10486, 10487, 10488, 10489, 10490, 10576, 11008, 11356, 11357, 11358, 11359, 11360, 11361, 11362, 11371, 11719, 11720, 11721, 11722, 11723, 11724, 11725, 11726, 11727, 11728, 12047, 12048, 12094, 12095, 12096, 12097, 12098, 12099, 12100, 12101, 12102, 12114, 12199, 12303, 20556, 20557, 20818, 20819, 20820, 21024, 21053, 21064, 21130, 30121, 30428, 30429, 30430, 30431, 30432, 30555, 30556, 30557, 30558, 30559, 30561, 30565, 40094, 40163, 40232, 40402, 40403, 40404, 40405, 40406, 40553, 40588, 40589, 40618, 40619, 40620, 40621, 40622, 40623, 40625, 40626, 40720},
		[18] = {10246, 10265, 10289, 10420, 10560, 10704, 10766, 11030, 11031, 11032, 11033, 11044, 11045, 11046, 11054, 11059, 11060, 11061, 11062, 11063, 11064, 11065, 11145, 11293, 11294, 11313, 11513, 11552, 11553, 11848, 11883, 11900, 12025, 12026, 12027, 12074, 12264, 12300, 20222, 20240, 20392, 20393, 20395, 20396, 20665, 20666, 20917, 21084, 30119, 30164, 30191, 30220, 30221, 30222, 30223, 30258, 30366, 30367, 30368, 30369, 30426, 30427, 30467, 30469, 30489, 40104, 40105, 40470, 40471, 40505},
		[17] = {11834, 11835, 11836, 11837, 11838, 11839, 11840, 11841, 12075, 12076, 12193, 12289, 20880, 20881, 20882, 30457, 30458, 30459, 30460, 30461, 30547, 40463, 40464, 40465, 40466, 40663},
		[11] = {11473, 11474, 11475, 11476, 11477, 11478, 11479, 11480, 11485, 11621, 11679, 20632, 20633, 20634, 30347, 30348, 30349, 30570, 40181, 40184, 40205, 40227, 40241, 40242, 40262, 40270, 40284, 40285, 40286, 40287, 40291, 40296, 40324, 40337, 40338, 40340, 40367, 40382, 40389, 40391, 40397, 40401, 40411, 40412, 40450, 40456, 40469, 40497, 40502, 40522, 40567},
		[14] = {11857, 11858, 11859, 11860, 11861, 11862, 11863, 11864, 11865, 11866, 11867, 11868, 11869, 11890, 11891, 11936, 11937, 11938, 11939, 11940, 11941, 11942, 11954, 11987, 12254, 20952, 20953, 20954, 20955, 20956, 20957, 20997, 30505, 30506, 30507, 30521, 40484, 40485, 40486, 40487, 40488, 40489, 40490, 40491, 40526, 40527, 40528, 40529, 40703},
		[19] = {11766, 11767, 11768, 11769, 11770, 11771, 11772, 11773, 11774, 11775, 11776, 11777, 12109, 20832, 20833, 20834, 20835, 20836, 20863, 30438, 30439, 40427, 40428, 40429, 40430},
	}
	ClientData._charCardsMap = CHAR_CARDS_MAP

	local LIYA_CARDS_MAP = {
		[1] = {10293, 10270, 10735, 10747, 10764, 10765, 10793, 10805, 10873, 10874, 10875, 10928, 11011, 11012, 11599, 11600, 11601, 11602, 11603, 11604, 11605, 11606, 11607, 11629, 11761, 11998, 11999, 12158, 12159, 12160, 12161, 12162, 12163, 12164, 12165, 12171, 12172, 20720, 20721, 20722, 20723, 20724, 20725, 20726, 20729, 20730, 20731, 20732, 20733, 20734, 20735, 20736, 20737, 20738, 20739, 20740, 20741, 20762, 20763, 20816, 20829, 20830, 21001, 21002, 21003, 21085, 21086, 21087, 21088, 30576, 40085, 40134, 40135, 40350, 40351, 40352, 40353, 40366, 40390, 40423, 40566, 40651, 40652, 40653, 40654, 40655, 40656, 40657, 40699, 10056, 10063, 10067, 10071, 10072, 10073, 10079, 10080, 10081, 10082, 10085, 10088, 10089, 10090, 10091, 10092, 10095, 10096, 10097, 10098},
		[2] = {10305, 10304, 11502, 11503, 11504, 11505, 11506, 11507, 11508, 11509, 12012, 12190, 12267, 12286, 20659, 20660, 20663, 20667, 20925, 30364, 30486, 30531, 30532, 40186, 40207, 40228, 40229, 40303, 40304, 40305, 40306, 40307, 40308, 40309, 40310, 40311, 40312, 40460, 40555, 40707, 10099, 10101, 10102, 10103, 10104, 10106, 10107, 10111, 10112, 10113, 10114, 10124, 10125, 10127, 10128, 10134, 10135, 10136, 10137, 10138},
		[3] = {10307, 10306, 10241, 10359, 10360, 10607, 10788, 10901, 10927, 10976, 11010, 11078, 11138, 11196, 11380, 11415, 11468, 11492, 11901, 11912, 11913, 11914, 12195, 12196, 12302, 12305, 12308, 12309, 20032, 20242, 20578, 21030, 21031, 21091, 21092, 30010, 30540, 30541, 40513, 40514, 10140, 10141, 10142, 10143, 10144, 10145, 10146, 10148, 10149, 10150, 10151, 10152, 10153, 10155, 10156, 10161, 10162, 10164, 10167, 10168},
		[4] = {10407, 10308, 10585, 10652, 11178, 11179, 11180, 11181, 11182, 11372, 11373, 11374, 11375, 11376, 11377, 11547, 20567, 20568, 20569, 20570, 20577, 20581, 21007, 30445, 30446, 30447, 30533, 40237, 40238, 40571, 40605, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10177, 10178, 10179, 10180, 10181, 10182, 10183, 10184, 10186, 10187, 10188, 10190},
		[5] = {10639, 10446, 10309, 10310, 10311, 10312, 10313, 10314, 11290, 11291, 11292, 11404, 11405, 11406, 11407, 11408, 11409, 11411, 11489, 11551, 11673, 11674, 11675, 11729, 11985, 11986, 12077, 12188, 12278, 12279, 20119, 20202, 20203, 20204, 20205, 20220, 20324, 20378, 20595, 20596, 20597, 20598, 20599, 20684, 20788, 20995, 20996, 21044, 30082, 30083, 30128, 30139, 30140, 30141, 30325, 30326, 30406, 40025, 40026, 40252, 40253, 40254, 40255, 40267, 40325, 40326, 40475, 40716, 10191, 10192, 10193, 10194, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10204, 10205, 10207, 10208, 10209, 10221, 10222, 10223},
		[6] = {10790, 10763, 11318, 11319, 11320, 11321, 11322, 11323, 11324, 11325, 11326, 11327, 11328, 11368, 11680, 11681, 11682, 11683, 11684, 11685, 11686, 11687, 11688, 11689, 12039, 12040, 12091, 12092, 12117, 12118, 12119, 12120, 12121, 12122, 12123, 12124, 12247, 20534, 20535, 20536, 20538, 20565, 20790, 20791, 21018, 21020, 21025, 21067, 21068, 21069, 21070, 30411, 30412, 30423, 30424, 30425, 30539, 30567, 30568, 40210, 40211, 40212, 40213, 40392, 40393, 40394, 40395, 40396, 40498, 40590, 40616, 40635, 40636, 40637, 40638, 40644, 40660, 10230, 10237, 10238, 10239, 10240, 10243, 10244, 10245, 10247, 10248, 10249, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 10257, 10258},
		[7] = {10896, 10895, 10695, 10696, 10697, 10698, 10701, 11745, 11746, 11749, 11881, 11882, 12150, 20169, 20194, 20206, 20207, 20208, 20246, 20251, 20252, 20253, 20254, 20386, 20478, 20650, 20789, 20825, 20826, 20906, 20930, 20978, 20979, 30108, 30137, 30142, 30143, 30152, 30358, 30497, 30498, 40046, 10261, 10262, 10263, 10264, 10269, 10272, 10273, 10275, 10276, 10280, 10302, 10303, 10317, 10320, 10321, 10329, 10332, 10334, 10336, 10337},
		[8] = {10967, 10902, 10710, 10711, 10712, 10774, 10946, 12057, 12058, 12059, 12060, 12061, 12062, 12063, 12086, 12246, 12301, 20288, 20471, 20472, 21012, 21032, 21033, 21034, 21035, 21036, 21037, 21038, 21050, 21121, 30185, 30537, 30543, 30550, 40598, 40599, 40600, 40601, 40602, 40603, 40612, 40678, 40685, 10338, 10340, 10357, 10362, 10363, 10366, 10377, 10378, 10379, 10380, 10381, 10396, 10397, 10401, 10408, 10411, 10418, 10421, 10422, 10426},
		[9] = {11083, 10969, 10038, 10266, 10617, 10733, 10773, 10849, 10850, 10867, 10897, 11003, 11004, 11005, 11006, 11021, 11022, 11023, 11024, 11025, 11027, 11043, 11052, 11053, 11055, 11220, 11242, 11297, 11299, 11300, 11301, 11302, 11303, 11309, 11336, 11514, 11577, 11594, 11610, 11797, 11798, 11804, 11875, 11918, 12051, 12052, 12053, 12127, 12251, 12265, 12266, 20381, 20384, 20518, 20519, 20520, 20815, 40096, 40097, 40098, 40099, 40100, 40195, 40199, 40200, 40201, 40202, 40441, 40442, 40492, 40496, 40512, 40709, 10428, 10441, 10458, 10460, 10461, 10467, 10468, 10470, 10471, 10474, 10475, 10478, 10491, 10492, 10493, 10501, 10503, 10504, 10510, 10521},
		[10] = {11225, 11145, 10324, 11536, 11537, 11538, 11539, 11540, 11541, 11542, 11544, 11545, 11546, 11558, 11645, 11647, 11692, 11970, 11971, 11972, 12116, 12205, 12207, 12217, 12257, 12293, 20678, 20680, 20682, 20683, 20698, 20699, 20700, 20703, 20704, 20759, 20771, 20988, 21065, 21066, 21102, 21104, 30380, 30396, 30513, 30514, 40317, 40318, 40319, 40320, 40321, 40323, 40345, 40541, 40542, 40556, 40634, 40669, 40670, 40671, 40672, 40700, 40723, 10522, 10526, 10528, 10529, 10530, 10531, 10532, 10534, 10535, 10542, 10553, 10554, 10555, 10561, 10562, 10572, 10575, 10583, 10584, 10587},
		[11] = {11338, 11308, 10732, 10796, 10826, 10827, 10918, 10919, 10923, 11142, 11202, 11203, 11204, 11205, 11381, 11382, 11383, 11384, 11385, 11386, 11387, 11388, 11412, 11885, 11886, 11887, 11888, 12104, 12218, 12252, 12285, 12288, 20271, 20583, 20635, 20909, 21107, 30243, 30487, 40433, 40434, 40435, 40436, 40437, 40438, 40447, 40449, 40628, 40683, 40698, 10588, 10589, 10590, 10594, 10608, 10611, 10612, 10613, 10614, 10615, 10627, 10628, 10630, 10647, 10648, 10650, 10654, 10658, 10671, 10672},
		[12] = {11513, 11365, 10087, 10904, 10905, 10906, 10907, 10908, 10909, 10910, 10911, 10912, 10913, 10914, 10915, 10916, 10917, 10924, 11521, 11522, 11523, 11524, 11525, 11526, 11527, 11667, 11668, 11669, 11670, 11671, 11672, 20335, 20672, 20674, 20784, 20785, 20786, 20787, 30374, 30403, 40313, 40314, 40388, 10673, 10674, 10675, 10679, 10682, 10690, 10721, 10734, 10736, 10740, 10743, 10744, 10769, 10801, 10802, 10803, 10804, 10818, 10821, 10832},
		[13] = {11695, 11662, 10109, 10325, 10507, 10508, 10514, 10515, 10669, 10748, 10781, 10782, 10922, 11160, 11286, 11393, 11394, 11395, 11396, 11397, 11398, 11399, 11400, 11401, 11493, 11532, 11533, 11535, 11955, 11956, 11957, 11973, 11974, 11975, 11976, 11977, 11978, 11979, 11996, 11997, 12143, 12144, 12169, 12170, 12189, 12200, 12201, 12202, 12215, 20093, 20153, 20226, 20490, 20584, 20585, 20586, 20989, 20990, 20991, 21078, 21101, 30154, 30322, 30323, 30324, 30515, 30516, 30517, 30518, 30571, 30583, 40144, 40246, 40275, 40282, 40316, 40532, 40533, 40543, 40544, 40545, 40546, 40547, 40548, 40549, 40550, 40627, 40668, 10833, 10844, 10847, 10853, 10864, 10934, 10953, 10954, 10955, 10972, 10974, 11002, 11014, 11034, 11037, 11039, 11067, 11068, 11082, 11095},
		[14] = {11934, 11853, 11343, 11344, 11345, 11346, 11347, 11348, 11349, 11350, 11351, 11649, 11650, 11651, 11652, 11653, 11654, 11655, 11764, 12064, 12065, 12085, 12145, 12152, 12220, 20547, 20772, 20773, 21039, 30310, 30311, 30397, 30398, 30399, 30400, 30544, 30551, 30574, 40221, 40222, 40223, 40369, 40370, 40371, 40372, 40373, 40374, 40375, 40376, 40377, 40378, 40379, 40384, 40424, 40540, 40557, 40586, 40679, 40714, 11097, 11098, 11101, 11103, 11104, 11105, 11107, 11119, 11134, 11135, 11136, 11137, 11139, 11164, 11165, 11168, 11169, 11170, 11174, 11175},
		[15] = {12142, 12006, 11058, 11117, 11161, 11192, 11217, 11237, 11264, 11366, 11419, 11420, 11750, 11751, 11752, 11781, 11782, 11783, 11784, 11785, 11786, 11787, 11788, 11905, 11906, 11907, 11908, 11909, 11910, 11911, 11919, 11931, 11932, 20176, 20561, 20625, 20838, 20839, 20918, 20919, 20920, 20921, 30440, 30490, 40187, 40217, 40231, 40261, 40295, 40474, 40507, 40508, 40509, 40510, 40511, 40525, 40564, 40595, 40604, 40611, 40624, 40633, 40647, 40676, 11186, 11187, 11190, 11200, 11207, 11209, 11238, 11271, 11333, 11340, 11353, 11466, 11467, 11515, 11534, 11636, 11663, 11690, 11733, 11736},
		[16] = {20142, 12181, 10084, 10539, 10540, 10556, 10858, 10859, 10860, 10861, 10862, 11071, 11074, 11162, 11213, 11214, 11215, 11354, 11355, 11364, 11413, 11414, 11516, 11660, 11661, 11664, 11842, 11884, 11988, 11989, 11990, 11991, 11992, 11993, 11994, 11995, 12194, 12244, 12290, 20046, 20116, 20284, 20313, 20314, 20604, 20711, 20775, 20776, 20883, 20884, 20998, 20999, 21009, 21071, 21074, 21129, 30115, 30313, 30314, 30330, 30402, 30463, 30522, 30523, 40078, 40230, 40260, 40381, 40383, 40385, 40468, 40473, 40517, 40559, 40560, 40561, 40562, 40563, 40565, 40715, 11753, 11757, 11844, 11895, 11896, 11935, 20004, 20007, 20008, 20011, 20016, 20017, 20018, 20019, 20022, 20025, 20033, 20039, 20040, 20044},
		[17] = {20352, 20233, 10482, 10483, 10484, 10485, 10486, 10487, 10488, 10489, 10490, 10576, 10865, 10866, 10898, 11008, 11356, 11357, 11358, 11359, 11360, 11361, 11362, 11371, 11447, 11448, 11449, 11450, 11451, 11452, 11453, 11454, 11455, 11456, 11457, 11458, 11595, 11980, 11981, 11982, 20556, 20557, 20613, 20614, 20615, 30121, 40094, 40163, 40232, 40553, 40588, 20045, 20047, 20048, 20057, 20060, 20063, 20064, 20065, 20067, 20069, 20074, 20076, 20077, 20078, 20081, 20083, 20084, 20085, 20086, 20088},
		[18] = {20551, 20549, 12014, 12015, 12016, 12017, 12018, 12019, 12208, 12209, 12210, 12211, 12212, 12213, 12214, 12223, 12292, 12304, 12306, 20416, 20417, 20423, 21008, 21013, 21014, 21015, 21016, 21103, 21106, 21124, 21128, 21131, 30534, 30535, 30536, 30542, 30586, 30591, 40122, 40124, 40125, 40127, 40154, 40156, 40216, 40380, 40574, 40575, 40577, 40578, 40579, 40580, 40581, 40582, 40583, 40584, 40596, 40597, 40610, 40674, 40677, 40701, 40710, 40721, 20090, 20091, 20092, 20095, 20099, 20102, 20107, 20108, 20112, 20113, 20115, 20122, 20125, 20127, 20130, 20137, 20145, 20150, 20155, 20157},
		[19] = {20566, 20552, 10779, 10819, 10837, 10838, 10840, 10841, 10842, 10843, 10932, 10980, 11666, 12155, 12228, 12229, 12230, 12231, 12232, 12233, 12234, 12235, 12236, 12237, 20356, 20781, 20782, 21108, 21109, 21110, 21113, 21114, 21120, 30173, 30210, 30587, 40387, 40687, 40688, 40689, 40690, 40691, 40692, 40693, 40694, 20158, 20174, 20175, 20178, 20179, 20181, 20184, 20186, 20187, 20210, 20215, 20216, 20218, 20221, 20223, 20228, 20229, 20237, 20238, 20243},
		[20] = {20711, 20641, 10957, 11110, 11111, 11113, 11114, 11115, 11335, 11529, 11530, 11644, 11808, 11809, 11810, 11811, 11812, 11813, 11814, 11815, 11816, 11817, 11820, 11821, 11822, 12082, 12106, 12107, 12108, 12240, 12269, 20414, 20415, 20418, 20864, 20868, 20869, 21055, 21056, 21059, 21060, 21061, 21062, 30201, 30202, 30448, 30449, 30454, 30465, 30562, 30579, 40074, 40151, 40271, 40443, 40444, 40445, 40446, 40461, 40629, 20244, 20245, 20256, 20263, 20264, 20266, 20267, 20276, 20277, 20278, 20279, 20280, 20281, 20282, 20285, 20291, 20293, 20294, 20296, 20306},
		[21] = {20324, 11011, 40095, 30215, 40094, 40097, 11007, 20377, 11012, 11003, 20896, 30165, 20842, 40183, 20898, 20893, 30308, 20948, 20816, 20589, 20530, 20859, 20860, 20895, 20967, 20910, 30022, 20854, 11002, 11010, 10997, 40096, 11004, 11005, 11006, 11008, 11009, 30191, 20482, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20813, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[22] = {11042, 11040, 11041, 11047, 20388, 11043, 11044, 11045, 11046, 30217, 20764, 20740, 30105, 20274, 30377, 40587, 20981, 30192, 20591, 20965, 40335, 20339, 20692, 20734, 20690, 11052, 11053, 11051, 11048, 11049, 11050, 20387, 20389, 11054, 11055, 20644, 20319, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 30026, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20463, 20814, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[23] = {11069, 20398, 20399, 11071, 20400, 11072, 11073, 11074, 11076, 11077, 30225, 20735, 20371, 40185, 20741, 20987, 20255, 20792, 20295, 20254, 20963, 20164, 20532, 20949, 40573, 20574, 20984, 20915, 20234, 40536, 11067, 11068, 11070, 11075, 11078, 11079, 11080, 11081, 11082, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20676, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[24] = {11102, 40121, 11096, 20411, 11100, 11099, 11094, 40119, 40120, 40116, 20942, 20370, 20841, 20336, 20737, 20946, 20675, 20830, 20531, 20829, 20968, 20366, 20173, 20156, 20941, 20992, 20665, 20489, 11101, 20409, 11095, 11104, 11097, 11098, 11103, 20410, 11105, 30230, 20556, 20179, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[25] = {30242, 30243, 11131, 11132, 11140, 40134, 11133, 40133, 40137, 40136, 20856, 20875, 30152, 20878, 20731, 20985, 20372, 20982, 30257, 20430, 20983, 20716, 40034, 20691, 30508, 11142, 30241, 11134, 11138, 20428, 20429, 11136, 11137, 40135, 11139, 20464, 30138, 20296, 20391, 20318, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[26] = {11166, 20442, 11172, 20094, 20441, 11167, 30256, 30251, 40138, 20029, 20413, 20736, 20810, 21122, 20368, 20738, 30178, 40420, 20916, 20588, 30338, 20733, 20320, 30366, 20439, 11174, 11168, 11162, 11169, 11170, 11164, 11165, 30254, 11135, 20809, 20498, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 30042, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20780, 20594, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[27] = {20142, 30259, 30262, 11203, 11205, 11212, 40151, 11204, 11213, 11214, 11215, 20375, 20977, 20763, 20440, 20196, 30367, 30469, 20845, 20855, 30484, 20861, 20134, 20717, 20474, 20457, 11206, 11209, 20461, 11211, 11207, 20458, 20459, 11200, 11202, 20499, 20481, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 30041, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 30033, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[28] = {20512, 11280, 11285, 20510, 20509, 40189, 20506, 11283, 40181, 11284, 20962, 20739, 20897, 20899, 20199, 20653, 20774, 20986, 20654, 30444, 20743, 40417, 20236, 21124, 20508, 11281, 11278, 11282, 30297, 11277, 30289, 11279, 20507, 40188, 20808, 20807, 20351, 20806, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20593, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[29] = {20551, 11354, 11364, 30313, 40232, 40230, 11355, 11360, 11362, 30314, 20557, 20947, 20195, 20970, 20369, 20165, 30591, 20862, 20944, 21116, 20198, 20975, 20523, 30427, 20853, 20580, 20251, 20762, 20554, 11361, 11357, 11356, 11358, 11359, 11371, 20558, 20559, 20560, 20390, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[30] = {20552, 11387, 30322, 20585, 20584, 11385, 30324, 11393, 20586, 11396, 11397, 20732, 21017, 20938, 20961, 20525, 20367, 30519, 20253, 20851, 20843, 20876, 30194, 20879, 20587, 11395, 11382, 11394, 11381, 20583, 11383, 11384, 11386, 11388, 30323, 20341, 20465, 20497, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 30034, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[31] = {40265, 11424, 40266, 11427, 11423, 11429, 11431, 11433, 11436, 11437, 20976, 20844, 30039, 40180, 40334, 20590, 20939, 20966, 20683, 20232, 20455, 20321, 20365, 20730, 20912, 20877, 11421, 11422, 11425, 11426, 11430, 11428, 20606, 11432, 11434, 11435, 20513, 20435, 20483, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
		[32] = {20233, 11463, 30342, 30344, 11462, 20623, 20624, 40277, 30345, 40281, 20626, 20694, 20374, 20964, 20666, 20945, 30272, 30368, 20693, 20765, 20940, 20943, 20373, 40182, 40262, 11466, 30341, 40280, 30343, 40278, 40276, 11464, 11467, 40279, 11465, 20340, 30369, 20245, 30073, 30003, 20108, 10261, 10357, 10441, 10504, 10575, 10244, 10628, 20033, 20069, 20092, 20130, 20016, 20045, 20113, 20125, 20145, 20157, 20158, 20174, 20228, 20229, 30019, 20608, 20057, 30017, 20018, 20077, 20102, 20064, 20060, 20063, 20078, 10759},
	}
	ClientData._liyaCardsMap = LIYA_CARDS_MAP


	-- Card Box Info & Reset (Tavern / draw)
	local function injectPacks()
		if not rawget(_G, "Data") or not Data._recruitInfo then return end
		if CHAR_CARDS_MAP then
			for cid, cardList in pairs(CHAR_CARDS_MAP) do
				local baseVal = 10000 + cid * 100
				for _, suffix in ipairs({1, 10, 50}) do
					local pval = baseVal + suffix
					if Data._recruitInfo[pval] then
						Data._recruitInfo[pval]._rid = cardList
						Data._recruitInfo[pval]._cards = cardList
					end
				end
				if Data._recruitInfo[cid] then
					Data._recruitInfo[cid]._rid = cardList
					Data._recruitInfo[cid]._cards = cardList
				end
			end
		end
		if rawget(_G, "Data") and Data._productsExInfo then
			if not Data._productsExInfo[59] then
				Data._productsExInfo[59] = {
					_id = 59,
					_cardId = 40209,
					_cost = 100000,
					_resType = 1,
					_date = "20170101.0"
				}
			end
		end
		if LIYA_CARDS_MAP then
			for liyaIdx, cardList in pairs(LIYA_CARDS_MAP) do
				local baseVal = 100000 + liyaIdx * 1000
				for _, suffix in ipairs({1, 10, 50}) do
					local pval = baseVal + suffix
					if Data._recruitInfo[pval] then
						Data._recruitInfo[pval]._rid = cardList
						Data._recruitInfo[pval]._cards = cardList
					end
				end
				if Data._recruitInfo[liyaIdx] then
					Data._recruitInfo[liyaIdx]._rid = cardList
					Data._recruitInfo[liyaIdx]._cards = cardList
				end
			end
		end
	end
	pcall(injectPacks)

	-- Card Box Info & Reset (Tavern / draw)
	ClientData.sendCardBoxInfo = function(boxId)
		pcall(injectPacks)
		ClientView.getActiveIndicator():hide()
		local s = lc._runningScene or ClientView._scene or lc.Director:getRunningScene()
		local curScene = s and (s._layer or s)
		if curScene and curScene._sceneId == ClientData.SceneId.tavern then
			local recruit = (Data._recruitInfo and Data._recruitInfo[boxId]) or (Data._dropInfo and Data._dropInfo[boxId])
			local respCards = {}
			local added = {}

			-- 1. Showcase all cards belonging to this pack (Liya or Character)
			local isLiya = (boxId and boxId >= 101001 and boxId <= 135050)
			local packList = nil
			if isLiya then
				local liyaIdx = math.floor((boxId - 100000) / 1000)
				packList = LIYA_CARDS_MAP and LIYA_CARDS_MAP[liyaIdx]
			elseif boxId and boxId >= 1 and boxId <= 32 and LIYA_CARDS_MAP and LIYA_CARDS_MAP[boxId] then
				isLiya = true
				packList = LIYA_CARDS_MAP[boxId]
			else
				local cid = (boxId and boxId >= 10000 and boxId < 20000) and math.floor((boxId - 10000) / 100) or nil
				packList = (cid and CHAR_CARDS_MAP and CHAR_CARDS_MAP[cid]) or (CHAR_CARDS_MAP and CHAR_CARDS_MAP[boxId])
			end

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

			-- 2. If not a character pack or charList empty, check recruit._rid or recruit._pid
			if #respCards == 0 and recruit then
				local rids = recruit._rid or {}
				if #rids == 0 and recruit._pid then
					for _, pv in ipairs(recruit._pid) do
						local pId = type(pv) == "table" and (pv[1] or pv.id) or pv
						if pId and tonumber(pId) then
							table.insert(rids, tonumber(pId))
						end
					end
				end
				for i = 1, #rids do
					local cardId = rids[i]
					if not added[cardId] then
						local info = (Data.getInfo and Data.getInfo(cardId)) or (Data._monsterInfo and Data._monsterInfo[cardId]) or (Data._magicInfo and Data._magicInfo[cardId]) or (Data._trapInfo and Data._trapInfo[cardId]) or (Data._rareInfo and Data._rareInfo[cardId])
						if info then
							added[cardId] = true
							local totalCount = (recruit._count and recruit._count[i]) or 1
							local gotCount = 0
							if P and P._playerCard then
								gotCount = math.min(totalCount, P._playerCard:getCardCount(cardId))
							end
							table.insert(respCards, {
								info_id = cardId,
								get_num = gotCount,
								remain_num = math.max(0, totalCount - gotCount)
							})
						end
					end
				end
			end

			-- 3. Fallback if still empty
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

	-- Ensure Str and ClientData.str always unescape \n to actual newline
	local _origStr = _G.Str
	_G.Str = function(sid, ...)
		local res = _origStr and _origStr(sid, ...)
		if not res and rawget(_G, "ClientData") and ClientData.str then
			res = ClientData.str(sid, ...)
		end
		if type(res) == "string" and string.find(res, "\\n") then
			res = string.gsub(res, "\\n", "\n")
		end
		return res
	end
	if rawget(_G, "ClientData") and ClientData.str then
		local _origCdStr = ClientData.str
		ClientData.str = function(sid, ...)
			local res = _origCdStr(sid, ...)
			if type(res) == "string" and string.find(res, "\\n") then
				res = string.gsub(res, "\\n", "\n")
			end
			return res
		end
	end

		-- Ensure all PVE attack/challenge inputs have _offlineMode = true
	local _origGenInputFromResp = ClientData.genInputFromResp
	ClientData.genInputFromResp = function(resp)
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
				while totalCount < 40 do
					for _, fcid in ipairs(fallbackCids) do
						if totalCount >= 40 then break end
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
				while totalOppo < 40 do
					for _, fcid in ipairs(fallbackCids) do
						if totalOppo >= 40 then break end
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

	ClientData.unloadLCRes = function(names)
		if type(names) ~= "table" then
			return
		end

		for _, name in ipairs(names) do
			jsres:unloadContainer(name)

			ClientData._lcres[name] = nil
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
							table.insert(rewardsList, {
								info_id = rw.info_id or Data.ResType.ingot,
								num = rw.num or 0,
								is_fragment = rw.is_fragment or false,
								level = rw.level or 1
							})
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
				ClientView.getActiveIndicator():hide()
				if res and res.code == 200 then
					if P then
						P._name = newName
						P._characterName = newName
					end
					if ClientView.getMenuUI() then ClientView.getMenuUI():updateUserName() end
					ToastManager.push("Đổi biệt hiệu thành công!")
					if lc._runningScene and lc._runningScene._lordForm then
						lc._runningScene._lordForm:updateName()
					end
				else
					ToastManager.push((res and res.msg) or "Đổi biệt hiệu thất bại!")
				end
			end)
		end
	end

	local function recordCheckinClaim(bonus)
		pcall(function()
			local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.post and bonus then
				local bid = type(bonus) == "table" and (bonus._infoId or bonus._id) or tonumber(bonus)
				if bid and bid > 0 then
					api:post("checkin", { account_id = accId, checkin_type = 1, day_index = bid })
					ClientData._claimedCheckins = ClientData._claimedCheckins or {}
					ClientData._claimedCheckins[bid] = true
				end
			end
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

		local localId = "c_" .. tostring(accId) .. "_" .. tostring(os.time()) .. "_" .. tostring(math.random(1000, 9999))
		ClientData._knownMsgIds = ClientData._knownMsgIds or {}
		ClientData._knownMsgIds[localId] = true

		local msgType = (chatType == 1 or chatType == (Chat_pb and Chat_pb.PB_CHAT_WORLD or 1)) and Data.MsgType.world or Data.MsgType.union

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
					union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
					last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
				})
				if myCrown then
					uinfo._crown = { _infoId = myCrown.info_id, _num = myCrown.num }
				end
				local msgObj = {
					_id = localId,
					_timestamp = os.time(),
					_user = uinfo,
					_type = msgType,
					_content = content,
					_items = {},
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
					type = (msgType == Data.MsgType.world and 1 or 2)
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

	local function processChatMessage(id, ts, accId, name, level, avatar, content, msgType, cardId, clientMsgId, crownId, crownNum)
		if not content or content == "" then return end

		if not P or not P._playerMessage or not P._playerMessage._msgAll then
			_G._pendingChatQueue = _G._pendingChatQueue or {}
			table.insert(_G._pendingChatQueue, {
				id = id, ts = ts, accId = accId, name = name, level = level, avatar = avatar,
				content = content, msgType = msgType, cardId = cardId, clientMsgId = clientMsgId,
				crownId = crownId, crownNum = crownNum
			})
			return
		end

		local isBattle = (msgType == 3 or msgType == Data.MsgType.battle)
		local isSystem = not isBattle and (msgType == 2 or accId == 0)
		local targetType = isBattle and Data.MsgType.battle or (isSystem and Data.MsgType.bulletin or Data.MsgType.world)
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
		local key = (isBattle and repId) or (id and tonumber(id) and tonumber(id) > 0 and tostring(id)) or (clientMsgId and clientMsgId ~= "" and clientMsgId)
		if key then
			for _, existing in ipairs(targetList) do
				if existing._id and tostring(existing._id) == tostring(key) then
					return
				end
				if existing._log and existing._log._id and tostring(existing._log._id) == tostring(key) then
					return
				end
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
				_id = key or repId or os.time(),
				_timestamp = realTs,
				_user = uinfo,
				_sender = uinfo,
				_opponent = oppoUser,
				_log = logObj,
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
				_id = key or os.time(),
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

		P._playerMessage:sendMessageEvent(P._playerMessage.Event.msg_new, targetType, 1)

		pcall(function()
			local cp = (ClientView and ClientView.getChatPanel and ClientView.getChatPanel()) or ClientData._chatPanel
			if cp and cp._isPop then
				cp:resetList()
			end
		end)
	end

	_G.addRawChatMessage = processChatMessage

	local function flushPendingChatQueue()
		if not P or not P._playerMessage or not P._playerMessage._msgAll then return end
		if _G._pendingChatQueue and #_G._pendingChatQueue > 0 then
			local queue = _G._pendingChatQueue
			_G._pendingChatQueue = {}
			for _, it in ipairs(queue) do
				processChatMessage(it.id, it.ts, it.accId, it.name, it.level, it.avatar, it.content, it.msgType, it.cardId, it.clientMsgId, it.crownId, it.crownNum)
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
				processChatMessage(m.id or 0, m.timestamp or os.time(), m.account_id or 1, m.name or "", m.level or 1, m.avatar or 201, contentVal, m.type or 1, cardId, m.client_msg_id or "", crownId, crownNum)
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
				processChatMessage(m.id or 0, m.timestamp or os.time(), m.account_id or 1, m.name or "", m.level or 1, m.avatar or 201, contentVal, m.type or 1, cardId, m.client_msg_id or "", crownId, crownNum)
			end
			pcall(flushPendingChatQueue)
		end
	end
	local function pollChatHistory()
		pcall(flushPendingChatQueue)
		pcall(function()
			local api = jsbridge and jsbridge.object("jdzcApi")
			if api and api.loadChatHistory then
				api:loadChatHistory()
			end
		end)
	end
	ClientData.pollChatHistory = pollChatHistory

	lc.addEventListener(Data.Event.login, function()
		pcall(function()
			if ClientData.pollChatHistory then
				ClientData.pollChatHistory()
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
			processChatMessage(m.id or 0, m.timestamp or os.time(), m.account_id or 1, m.name or "", m.level or 1, m.avatar or 201, contentVal, m.type or 1, cardId, m.client_msg_id or "", crownId, crownNum)
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
			isAttacker = false
		end

		local matchId = serverRoom.match_id or ("m_room_" .. tostring(serverRoom.code))
		local seed = tonumber(serverRoom.seed) or math.random(1, 65535)

		local playerCards = {}
		local playerLevels = {}
		local playerSkins = {}
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
				table.insert(playerSkins, { skin_id = 0, info_id = cid, effect_ids = {} })
				totalPlayerCards = totalPlayerCards + num
			end
		end
		local fallbackCids = (Data._troopInfo and Data._troopInfo[1] and Data._troopInfo[1]._infoId) or { 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 20001, 20002, 20003, 20004, 20005, 30001, 30002, 30003 }
		while totalPlayerCards < 40 do
			for _, cid in ipairs(fallbackCids) do
				if totalPlayerCards >= 40 then break end
				table.insert(playerCards, { info_id = cid, num = 1 })
				table.insert(playerLevels, { info_id = cid, level = 1 })
				table.insert(playerSkins, { skin_id = 0, info_id = cid, effect_ids = {} })
				totalPlayerCards = totalPlayerCards + 1
			end
		end

		local oppoCards = {}
		local oppoLevels = {}
		local oppoSkins = {}
		local oppoCount = 0
		local oppoCounts, oppoOrder = {}, {}
		local rawCards = oppo.cards or {}
		local function addOppoCid(cid)
			cid = tonumber(cid)
			if cid and cid > 0 then
				if not oppoCounts[cid] then
					oppoCounts[cid] = 0
					table.insert(oppoOrder, cid)
				end
				oppoCounts[cid] = oppoCounts[cid] + 1
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
					addOppoCid(rawCards[k] or rawCards[tostring(k)])
				end
			else
				for _, v in pairs(rawCards) do
					addOppoCid(v)
				end
			end
		end
		for _, cid in ipairs(oppoOrder) do
			table.insert(oppoCards, { info_id = cid, num = oppoCounts[cid] })
			table.insert(oppoLevels, { info_id = cid, level = 1 })
			table.insert(oppoSkins, { skin_id = 0, info_id = cid, effect_ids = {} })
			oppoCount = oppoCount + oppoCounts[cid]
		end
		while oppoCount < 40 do
			for _, cid in ipairs(fallbackCids) do
				if oppoCount >= 40 then break end
				table.insert(oppoCards, { info_id = cid, num = 1 })
				table.insert(oppoLevels, { info_id = cid, level = 1 })
				table.insert(oppoSkins, { skin_id = 0, info_id = cid, effect_ids = {} })
				oppoCount = oppoCount + 1
			end
		end

		ClientData._battleFromFindIndex = Data.FindMatchType.hall
		ClientData.setBattleFromSceneId(ClientData.SceneId.in_room)
		ClientData._isOppoOnline = true
		ClientData._currentMatchId = matchId
		ClientData._usedCardsToAdd = {}
		ClientData._observeUsedCards = {}

		local myCrown = nil
		if P and P._crown and P._crown._infoId and P._crown._infoId ~= 0 then
			myCrown = { _infoId = P._crown._infoId, _num = P._crown._num }
		elseif ClientData and ClientData._account then
			local gc = tonumber(ClientData._account.gold_cup) or 0
			local sc = tonumber(ClientData._account.silver_cup) or 0
			local bc = tonumber(ClientData._account.bronze_cup) or 0
			if gc > 0 then myCrown = { _infoId = 7204, _num = gc }
			elseif sc > 0 then myCrown = { _infoId = 7205, _num = sc }
			elseif bc > 0 then myCrown = { _infoId = 7206, _num = bc }
			end
		end

		local oppoCrown = nil
		if oppo then
			if oppo._crown and oppo._crown._infoId and oppo._crown._infoId ~= 0 then
				oppoCrown = { _infoId = oppo._crown._infoId, _num = oppo._crown._num }
			elseif oppo.crown and type(oppo.crown) == "table" and (oppo.crown.info_id or oppo.crown._infoId) then
				local cid = tonumber(oppo.crown.info_id or oppo.crown._infoId) or 7204
				local num = tonumber(oppo.crown.num or oppo.crown._num) or 1
				if cid ~= 0 then oppoCrown = { _infoId = cid, _num = num } end
			else
				local ogc = tonumber(oppo.gold_cup) or 0
				local osc = tonumber(oppo.silver_cup) or 0
				local obc = tonumber(oppo.bronze_cup) or 0
				if ogc > 0 then oppoCrown = { _infoId = 7204, _num = ogc }
				elseif osc > 0 then oppoCrown = { _infoId = 7205, _num = osc }
				elseif obc > 0 then oppoCrown = { _infoId = 7206, _num = obc }
				end
			end
		end

		local battleInput = {
			_levelId = 0,
			_copyId = 0,
			_isTesting = false,
			_offlineMode = false,
			_isOppoOnline = true,
			_pvpMatch = true,
			_matchId = matchId,
			_isAttacker = isAttacker,
			_isWatcher = false,
			_speedFactor = 1,
			_type = Battle_pb.PB_BATTLE_MATCH,
			_battleType = Data.BattleType.PVP_room,
			_pvpMatch = true,
			_isOppoOnline = true,
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
				_level = (P and P._level) or 50,
				_monthCardType = 0,
				_roundTimeInit = 90,
				_roundTimeMax = 90,
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
				_vip = (P and P._vip) or 0,
				_id = myAccId,
				_name = (P and P._name) or "Player",
				_avatar = ((P and P._avatar) or 2) * 100 + 1,
				_crown = myCrown,
				_cardBackId = (P and P._cardBackId) or Data.PropsId.card_back,
				_isNpc = false,
				_troopCards = playerCards,
				_troopLevels = playerLevels,
				_troopSkins = playerSkins,
				_usedCards = {},
				_trophy = 800
			},
			_opponent = {
				_region = 1,
				_level = oppo.level or 50,
				_monthCardType = 0,
				_roundTimeInit = 90,
				_roundTimeMax = 90,
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
				_vip = 0,
				_id = oppo.id or 0,
				_name = oppo.name or "Duelist",
				_avatar = oppo.avatar or 201,
				_crown = oppoCrown,
				_cardBackId = 7600,
				_isNpc = false,
				_troopCards = oppoCards,
				_troopLevels = oppoLevels,
				_troopSkins = oppoSkins,
				_usedCards = {},
				_trophy = tonumber(oppo.trophy) or 800
			}
		}

		local pvpNet = jsbridge and jsbridge.object("jdzcPvp")
		if pvpNet then
			pvpNet:connect(matchId, myAccId, function(intsJson)
				local ok, ints = pcall(json.decode, intsJson)
				if ok and type(ints) == "table" and #ints > 0 then
					ClientData._usedCardsToAdd = ClientData._usedCardsToAdd or {}
					for _, val in ipairs(ints) do
						table.insert(ClientData._usedCardsToAdd, tonumber(val) or 0)
					end
					local scene = lc._runningScene or ClientView._scene
					local bUi = scene and scene._battleUi
					if bUi and type(bUi.oppoTryUseCard) == "function" then
						bUi:oppoTryUseCard()
					end
				end
			end, function()
				local scene = lc._runningScene or ClientView._scene
				local bUi = scene and scene._battleUi
				if bUi and not bUi._isBattleEndSended then
					local waitTime = (not bUi._round or bUi._round < 1) and 3.0 or 0.5
					bUi:runAction(lc.sequence(waitTime, function()
						local curScene = lc._runningScene or ClientView._scene
						local curUi = curScene and curScene._battleUi
						if curUi and not curUi._isBattleEndSended then
							curUi._forceResult = Data.BattleResult.win
							curUi:hideThinking()
							if curUi._opponent and type(curUi.retreat) == "function" then
								curUi:retreat(curUi._opponent)
							else
								curUi:sendBattleEnd(false, Data.BattleResult.win)
							end
							ToastManager.push("Đối thủ đã rời trận, bạn đã giành chiến thắng!")
						end
					end))
				end
			end, function(peerResult)
				local scene = lc._runningScene or ClientView._scene
				local bUi = scene and scene._battleUi
				if bUi and not bUi._isBattleEndSended then
					local myRes = (tostring(peerResult) == "1" and Data.BattleResult.win or Data.BattleResult.lose)
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

		local ind = ClientView.getActiveIndicator()
		if ind and ind.hide then ind:hide() end

		if lc._runningScene and type(lc._runningScene.onBattleRecover) == "function" then
			lc._runningScene:onBattleRecover(battleInput)
		end
	end
	ClientData.onRoomBattleStart = ClientData.startRoomDuelWithOpponent

	ClientData.sendQuitRoom = function()
		local myAccId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
		local rId = P._roomId
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post and rId then
			api:post("leave_room", {
				room_id = tostring(rId),
				account_id = myAccId
			})
		end
		local resp = {
			type = SglMsgType_pb.PB_TYPE_WORLD_CLOSE_MATCH,
			status = 0
		}
		makeProtobufCompatible(resp)
		ClientData.onMsg(resp)
		if lc._runningScene and lc._runningScene._sceneId == ClientData.SceneId.in_room then
			ClientView.popScene()
		end
		return true
	end


    -- ==========================================================
    -- 6 COMPREHENSIVE WEB EXTENSIONS
    -- ==========================================================
    local CHAR_CARDS_MAP = {
    [3] = {10004, 10006, 10048, 10242, 10266, 10477, 10624, 10645, 10702, 10849, 10850, 10867, 10897, 11146, 11147, 11148, 11149, 11150, 11151, 11152, 11153, 11154, 11155, 11156, 11157, 11158, 11159, 11225, 11252, 11297, 11299, 11300, 11301, 11302, 11303, 11309, 11336, 11379, 11510, 11512, 11577, 11594, 11609, 11610, 11615, 11619, 11622, 11632, 11633, 11730, 11797, 11798, 11804, 11875, 11918, 12043, 12051, 12052, 12053, 12093, 12127, 12130, 12181, 12204, 12251, 12265, 12266, 12273, 12282, 12283, 12307, 12310, 20001, 20002, 20003, 20006, 20009, 20010, 20012, 20013, 20014, 20027, 20043, 20160, 20432, 20433, 20456, 20493, 20518, 20519, 20520, 20529, 20543, 20544, 20646, 20664, 20750, 20751, 20760, 20764, 20765, 20815, 20900, 20911, 20913, 20951, 20960, 21045, 21098, 21126, 30022, 30024, 30031, 30161, 30247, 30248, 30383, 30388, 30389, 30479, 30554, 40140, 40141, 40142, 40143, 40150, 40157, 40173, 40199, 40200, 40201, 40202, 40441, 40442, 40494, 40495, 40496, 40617, 40664, 40709, 40712},
    [2] = {10001, 10013, 10029, 10212, 10335, 10342, 10343, 10361, 10498, 10502, 10646, 10651, 10703, 10705, 10706, 10720, 10729, 10730, 10731, 10814, 10930, 10968, 10986, 10987, 10988, 10989, 10990, 10991, 10992, 10993, 10994, 10995, 10996, 11040, 11041, 11042, 11048, 11049, 11050, 11051, 11075, 11076, 11079, 11080, 11081, 11091, 11092, 11120, 11289, 11329, 11363, 11402, 11567, 11568, 11613, 11618, 11898, 11899, 11947, 11948, 11969, 12140, 12151, 12177, 12224, 12275, 12291, 12299, 20052, 20275, 20303, 20360, 20365, 20366, 20367, 20368, 20369, 20370, 20371, 20372, 20373, 20374, 20375, 20401, 20402, 20408, 20412, 20413, 20524, 20525, 20553, 20893, 20899, 20959, 20966, 20967, 20980, 21090, 21093, 21097, 21127, 21132, 30120, 30158, 30357, 30379, 30575, 30578, 40001, 40013, 40033, 40037, 40090, 40091, 40092, 40093, 40102, 40103, 40115, 40133, 40138, 40139, 40148, 40153, 40203, 40250, 40256, 40301, 40354, 40355, 40454, 40478, 40480, 40504, 40531, 40648, 40680, 40686, 40708, 40719, 40722},
    [5] = {10086, 10118, 10405, 10620, 10621, 10622, 10787, 10815, 10848, 11013, 11020, 11093, 11221, 11318, 11319, 11320, 11321, 11322, 11323, 11324, 11325, 11326, 11327, 11328, 11365, 11368, 11497, 11498, 11499, 12037, 12039, 12040, 12091, 12092, 12167, 12168, 12312, 20189, 20190, 20197, 20198, 20292, 20380, 20534, 20535, 20536, 20538, 20549, 20551, 20552, 20565, 20840, 21018, 21020, 30036, 30124, 30132, 30138, 30423, 30424, 30425, 30442, 40160, 40194, 40210, 40211, 40212, 40213, 40288, 40431, 40498, 40585, 40616, 40675, 40718},
    [4] = {10075, 10076, 10077, 10119, 10120, 10121, 10122, 10123, 10284, 10285, 10783, 10784, 10785, 10786, 11121, 11122, 11123, 11124, 11125, 11126, 11127, 11128, 11129, 11130, 11224, 11337, 11694, 12088, 12089, 12192, 20053, 20054, 20117, 20301, 20333, 20425, 20426, 20641, 21051, 21094, 30064, 30065, 30066, 30171, 30238, 30239, 30240, 40047, 40052, 40128, 40129, 40130, 40131, 40476, 40613, 40659, 40662},
    [15] = {10290, 10291, 10683, 10684, 10685, 10686, 10687, 10688, 10689, 10715, 10718, 10726, 10758, 10828, 10938, 10942, 10943, 10944, 10945, 11227, 11416, 11417, 11461, 11463, 11555, 12008, 12042, 12173, 40010, 40038, 40039, 40040, 40041, 40042, 40043, 40044, 40045, 40048, 40049, 40050, 40051, 40053, 40055, 40057, 40058, 40060, 40061, 40062, 40063, 40064, 40065, 40066, 40146, 40263, 40272, 40273, 40274, 40276, 40277, 40279, 40280, 40281, 40334, 40335, 40336, 40606, 40658, 40697},
    [16] = {11085, 11086, 11087, 11088, 11089, 11090, 11254, 11255, 11256, 11257, 11258, 11259, 11260, 11261, 11262, 11432, 11433, 11434, 11435, 11436, 11437, 11440, 11707, 11915, 12041, 12137, 12253, 20406, 20407, 20441, 20494, 20495, 20496, 20924, 21123, 30203, 30226, 30227, 30228, 30229, 30250, 30278, 30279, 30422, 30494, 30590, 40088, 40110, 40111, 40112, 40113, 40114, 40174, 40177, 40178, 40179, 40180, 40399, 40457, 40515, 40704, 40705, 40706},
    [7] = {10868, 10869, 10870, 10871, 10879, 10920, 10925, 10926, 11554, 20317, 20318, 20319, 20320, 20321, 20322, 20339, 20340, 20341, 20690, 20691, 20692, 30177, 40332, 40333},
    [10] = {12158, 12159, 12160, 12161, 12162, 12163, 12164, 12165, 12171, 12172, 21085, 21086, 21087, 21088, 30576, 40651, 40652, 40653, 40654, 40655, 40656, 40657, 40699},
    [8] = {10109, 10325, 10507, 10508, 10514, 10515, 10669, 10748, 10781, 10782, 10922, 11160, 11286, 11393, 11394, 11395, 11396, 11397, 11398, 11399, 11400, 11401, 11493, 11532, 11533, 11535, 11955, 11956, 11957, 11973, 11974, 11975, 11976, 11977, 11978, 11979, 11996, 11997, 12143, 12144, 12169, 12170, 12189, 12200, 12201, 12202, 12215, 20093, 20153, 20226, 20490, 20584, 20585, 20586, 20989, 20990, 20991, 21078, 21101, 30154, 30322, 30323, 30324, 30515, 30516, 30517, 30518, 30571, 30583, 40144, 40246, 40275, 40282, 40316, 40532, 40533, 40543, 40544, 40545, 40546, 40547, 40548, 40549, 40550, 40627, 40668},
    [9] = {10482, 10483, 10484, 10485, 10486, 10487, 10488, 10489, 10490, 10576, 11008, 11356, 11357, 11358, 11359, 11360, 11361, 11362, 11371, 11719, 11720, 11721, 11722, 11723, 11724, 11725, 11726, 11727, 11728, 12047, 12048, 12094, 12095, 12096, 12097, 12098, 12099, 12100, 12101, 12102, 12114, 12199, 12303, 20556, 20557, 20818, 20819, 20820, 21024, 21053, 21064, 21130, 30121, 30428, 30429, 30430, 30431, 30432, 30555, 30556, 30557, 30558, 30559, 30561, 30565, 40094, 40163, 40232, 40402, 40403, 40404, 40405, 40406, 40553, 40588, 40589, 40618, 40619, 40620, 40621, 40622, 40623, 40625, 40626, 40720},
    [18] = {10246, 10265, 10289, 10420, 10560, 10704, 10766, 11030, 11031, 11032, 11033, 11044, 11045, 11046, 11054, 11059, 11060, 11061, 11062, 11063, 11064, 11065, 11145, 11293, 11294, 11313, 11513, 11552, 11553, 11848, 11883, 11900, 12025, 12026, 12027, 12074, 12264, 12300, 20222, 20240, 20392, 20393, 20395, 20396, 20665, 20666, 20917, 21084, 30119, 30164, 30191, 30220, 30221, 30222, 30223, 30258, 30366, 30367, 30368, 30369, 30426, 30427, 30467, 30469, 30489, 40104, 40105, 40470, 40471, 40505},
    [17] = {11834, 11835, 11836, 11837, 11838, 11839, 11840, 11841, 12075, 12076, 12193, 12289, 20880, 20881, 20882, 30457, 30458, 30459, 30460, 30461, 30547, 40463, 40464, 40465, 40466, 40663},
    [11] = {11473, 11474, 11475, 11476, 11477, 11478, 11479, 11480, 11485, 11621, 11679, 20632, 20633, 20634, 30347, 30348, 30349, 30570, 40181, 40184, 40205, 40227, 40241, 40242, 40262, 40270, 40284, 40285, 40286, 40287, 40291, 40296, 40324, 40337, 40338, 40340, 40367, 40382, 40389, 40391, 40397, 40401, 40411, 40412, 40450, 40456, 40469, 40497, 40502, 40522, 40567},
    [14] = {11857, 11858, 11859, 11860, 11861, 11862, 11863, 11864, 11865, 11866, 11867, 11868, 11869, 11890, 11891, 11936, 11937, 11938, 11939, 11940, 11941, 11942, 11954, 11987, 12254, 20952, 20953, 20954, 20955, 20956, 20957, 20997, 30505, 30506, 30507, 30521, 40484, 40485, 40486, 40487, 40488, 40489, 40490, 40491, 40526, 40527, 40528, 40529, 40703},
    [19] = {11766, 11767, 11768, 11769, 11770, 11771, 11772, 11773, 11774, 11775, 11776, 11777, 12109, 20832, 20833, 20834, 20835, 20836, 20863, 30438, 30439, 40427, 40428, 40429, 40430},
}


    local function injectKeywordPacks()
        if not rawget(_G, "Data") or not Data._recruitInfo then return end
        for cid, cardList in pairs(CHAR_CARDS_MAP) do
            local baseVal = 10000 + cid * 100
            for _, suffix in ipairs({1, 10, 50}) do
                local pval = baseVal + suffix
                if Data._recruitInfo[pval] then
                    Data._recruitInfo[pval]._rid = cardList
                    Data._recruitInfo[pval]._cards = cardList
                end
            end
            if Data._recruitInfo[cid] then
                Data._recruitInfo[cid]._rid = cardList
                Data._recruitInfo[cid]._cards = cardList
            end
        end
    end
    pcall(injectKeywordPacks)

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
        local api = jsbridge and jsbridge.object("jdzcApi")
        if api and api.post then
            api:post("set_character", {
                account_id = myAccId,
                character_id = cid
            }, function(rawRes)
                local res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
                if res and res.code == 200 then
                    if P then
                        P._characterId = cid
                        P:changeIcon(cid * 100 + 1)
                        P:sendCharacterDirty()
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
                    if P then
                        P._avatar = aid
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

        if api and api.post then
            api:post("user_visit", { user_id = uid }, function(rawRes)
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

local function patchBattleUiTouch(mod)
	local BattleUi = _G.BattleUi
	if not BattleUi or not BattleUi.onTouchBegan then return end
	local oldTouchBegan = BattleUi.onTouchBegan
	BattleUi.onTouchBegan = function(self, touch)

		-- Check active skill icon touches beneath board cards
		if touch and self._playerUi and self._playerUi._pBoardCards then
			local touchLoc = touch:getLocation()
			for iter = 1, Data.MAX_CARD_COUNT_ON_BOARD do
				local pCard = self._playerUi._pBoardCards[iter]
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
			touch.getId = function() return 0 end
			touch.getID = function() return 0 end
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
			if touch then
				touch.getId = function() return 0 end
			touch.getID = function() return 0 end
			end
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

	local oldTouchEnded = BattleUi.onTouchEnded
	if oldTouchEnded then
		BattleUi.onTouchEnded = function(self, touch)
			if touch then
				touch.getId = function() return 0 end
				touch.getID = function() return 0 end
			end
			return oldTouchEnded(self, touch)
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
			-- Native condition check in PlayerUi.lua determines enabled state and particle glow
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
	if not BattleUi then return end
	BattleUi.getEventDispatcher = function(self)
		local ed = cc and cc.eventManager
		if ed and not ed.removeEventListenersForTarget then
			ed.removeEventListenersForTarget = function() end
		end
		return ed or { removeEventListenersForTarget = function() end }
	end

	-- Safeguard removeEventListenersForTarget on node event dispatcher
	if cc and cc.Node and cc.Node.getEventDispatcher then
		local _origGED = cc.Node.getEventDispatcher
		cc.Node.getEventDispatcher = function(self)
			local ed = _origGED(self)
			if ed and not ed.removeEventListenersForTarget then
				ed.removeEventListenersForTarget = function() end
			end
			return ed or { removeEventListenersForTarget = function() end }
		end
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

			local input = self._input
			local isOffline = (input and (input._offlineMode or input._offlineMarker or (not input._isOppoOnline)))
			local isPvp = (input and input._pvpMatch)

			if (isOffline or isPvp) and self._baseBattleType ~= Data.BattleType.base_replay and self._battleType ~= Data.BattleType.replay then
				self._offlineResultShown = true
				self._isBattleEndSended = true

				local res = self._forceResult or (self._player and self._player:getResult()) or Data.BattleResult.win
				local levelId = input and (input._levelId or input._copyId) or 0

				if isPvp then
					pcall(function()
						local pvpNet = jsbridge and jsbridge.object("jdzcPvp")
						if pvpNet then
							if pvpNet.sendEnd then
								pvpNet:sendEnd(ClientData._currentMatchId or "", tostring(res))
							elseif pvpNet.sendAction then
								pvpNet:sendAction(ClientData._currentMatchId or "", { 999999, tonumber(res) or 1 })
							end
						end
					end)
				end

				self:showWaiting()

				local resp = SglMsg_pb.SglRespMsg()
				resp.type = SglMsgType_pb.PB_TYPE_BATTLE_END
				resp.status = SglMsg_pb.PB_STATUS_OK
				local pb = resp.Extensions[Battle_pb.SglBattleMsg.battle_end_resp]

				local accId = (ClientData._account and ClientData._account.id) or (P and P._id) or 1
				local api = jsbridge and jsbridge.object("jdzcApi")

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

				local function finalizeBattleEnd(deltaTrophy, deltaGold, newTrophy, newGold)
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

					local gItem = pb.resource:add()
					gItem.info_id = Data.ResType.gold
					gItem.num = deltaGold

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
					api:post("pvp_reward", {
						account_id = accId,
						result = (res == Data.BattleResult.win) and 1 or 2,
						battle_type = "clash",
						is_bot = isBot,
						oppo_trophy = oppoTrophy
					}, function(rawRes)
						local cr = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
						if cr and cr.code == 200 then
							local dGold = tonumber(cr.delta_gold) or ((res == Data.BattleResult.win) and 10000 or 500)
							local dTrophy = tonumber(cr.delta_trophy) or ((res == Data.BattleResult.win) and 25 or -15)
							local nTrophy = tonumber(cr.trophy) or math.max(0, ((P and P._playerFindClash and P._playerFindClash._trophy) or 800) + dTrophy)
							local nGold = tonumber(cr.gold) or (((P and P._gold) or 0) + dGold)

							if P then P._gold = nGold end
							if cr.level and P then P._level = cr.level end
							if cr.exp and P then P._exp = cr.exp end
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.gold_dirty))
							lc.Dispatcher:dispatchEvent(cc.EventCustom:new(Data.Event.trophy_dirty))

							finalizeBattleEnd(dTrophy, dGold, nTrophy, nGold)
						else
							-- Fallback on API non-200
							local dGold = (res == Data.BattleResult.win) and 5000 or 500
							local dTrophy = (res == Data.BattleResult.win) and 25 or -10
							local curT = (P and P._playerFindClash and P._playerFindClash._trophy) or 800
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
			lc.replaceScene(require("BattleScene").create(self._input))
			ClientData.sendBattleLoadingDone()
		else
			ClientData.replaceCityScene()
		end
	end

	local origLoadBattleRes = ResSwitchScene.loadBattleRes
	ResSwitchScene.loadBattleRes = function(self)
		rawset(self, "_switchedThisScene", false)
		if origLoadBattleRes then origLoadBattleRes(self) end
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
		if origLoadCityUnionRes then origLoadCityUnionRes(self) end
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

local patches = {
	BaseScene = patchBaseScene,
	ResSwitchScene = patchResSwitchScene,
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

			local isLiya = (boxId and boxId >= 101001 and boxId <= 135050)
			local liyaIdx = nil
			if isLiya then
				liyaIdx = math.floor((boxId - 100000) / 1000)
			elseif boxId and boxId >= 1 and boxId <= 32 and LIYA_CARDS_MAP and LIYA_CARDS_MAP[boxId] then
				isLiya = true
				liyaIdx = boxId
			end

			local costVal = 0
			if actualScene and actualScene._curRecruitInfo and actualScene._curRecruitInfo._param and actualScene._curRecruitInfo._param[2] then
				costVal = tonumber(actualScene._curRecruitInfo._param[2]) or 0
			end
			if costVal <= 0 then
				if isLiya then
					costVal = (numPacks >= 50 and 28500) or (numPacks >= 10 and 6000) or (600 * numPacks)
				else
					costVal = (numPacks >= 50 and 22500) or (numPacks >= 10 and 4500) or (500 * numPacks)
				end
			end
			local costType = (resType == Data.ResType.ingot and "gem") or "gold"

			local recruit = (Data._recruitInfo and Data._recruitInfo[boxId]) or (Data._dropInfo and Data._dropInfo[boxId])
			local pool = {}
			if isLiya and liyaIdx then
				local lCards = LIYA_CARDS_MAP and LIYA_CARDS_MAP[liyaIdx]
				if lCards then
					for _, cidVal in ipairs(lCards) do
						table.insert(pool, cidVal)
					end
				end
			else
				local cid = (boxId and boxId >= 10000 and boxId < 20000) and math.floor((boxId - 10000) / 100) or nil
				local charCards = (cid and CHAR_CARDS_MAP and CHAR_CARDS_MAP[cid]) or (CHAR_CARDS_MAP and CHAR_CARDS_MAP[boxId])
				if charCards and #charCards > 0 then
					for _, cidVal in ipairs(charCards) do
						table.insert(pool, cidVal)
					end
				end
			end
			if #pool == 0 and recruit then
				if recruit._rid and #recruit._rid > 0 then
					for i = 1, #recruit._rid do
						table.insert(pool, recruit._rid[i])
					end
				elseif recruit._pid then
					for _, pv in ipairs(recruit._pid) do
						local pId = type(pv) == "table" and (pv[1] or pv.id) or pv
						if pId and tonumber(pId) then
							table.insert(pool, tonumber(pId))
						end
					end
				end
			end

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
		ClientData.sendWorldLottery = ClientData.sendCardLottery
		ClientData.sendWorldLotteryEx = ClientData.sendCardLottery
		ClientData.sendWorldLotteryActivity = ClientData.sendCardLottery
		ClientData.sendWeekLottery = ClientData.sendCardLottery

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
			if api and api.post then
				api:post("user_visit", { user_id = uid }, function(rawRes)
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
	end
end

return M