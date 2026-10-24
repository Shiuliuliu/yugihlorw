local var_0_0 = {}
DeckCodeHelper = var_0_0

local B64_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local XOR_KEY = 0x4A

-- Pure Lua bitwise XOR for numbers <= 255
local function xor_byte(a, b)
	if bit and bit.bxor then
		return bit.bxor(a, b)
	end
	local p, c = 1, 0
	while a > 0 or b > 0 do
		local ra, rb = a % 2, b % 2
		if ra ~= rb then c = c + p end
		a = math.floor(a / 2)
		b = math.floor(b / 2)
		p = p * 2
	end
	return c
end

function var_0_0.base64_encode(data)
	if not data or data == "" then return "" end
	return ((data:gsub('.', function(x) 
		local r, b = '', x:byte()
		for i = 8, 1, -1 do r = r .. (b % 2^i - b % 2^(i - 1) > 0 and '1' or '0') end
		return r
	end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (#x < 6) then return '' end
		local c = 0
		for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2^(6 - i) or 0) end
		return B64_CHARS:sub(c + 1, c + 1)
	end) .. ({ '', '==', '=' })[#data % 3 + 1])
end

function var_0_0.base64_decode(data)
	if not data or data == "" then return "" end
	data = string.gsub(data, '[^' .. B64_CHARS .. '=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r, f = '', (B64_CHARS:find(x, 1, true) - 1)
		for i = 6, 1, -1 do r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0') end
		return r
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c = 0
		for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2^(8 - i) or 0) end
		return string.char(c)
	end))
end

function var_0_0.xor_crypt(str, key)
	key = key or XOR_KEY
	local res = {}
	for i = 1, #str do
		local b = string.byte(str, i)
		table.insert(res, string.char(xor_byte(b, key)))
	end
	return table.concat(res)
end

-- Encode troop to YGODECK:// string
function var_0_0.encodeTroop(troop)
	if not troop then return "" end
	local mainParts = {}
	local extraParts = {}

	for _, entry in ipairs(troop) do
		local id = tonumber(entry._infoId)
		local count = tonumber(entry._num) or 1
		if id and id > 0 and count > 0 then
			local cardType = Data.getType(id)
			if cardType == Data.CardType.rare then
				table.insert(extraParts, string.format("%d*%d", id, count))
			else
				table.insert(mainParts, string.format("%d*%d", id, count))
			end
		end
	end

	local rawStr = "M:" .. table.concat(mainParts, ",") .. "|E:" .. table.concat(extraParts, ",")
	local encrypted = var_0_0.xor_crypt(rawStr, XOR_KEY)
	local b64 = var_0_0.base64_encode(encrypted)
	return "YGODECK://" .. b64
end

-- Decode deck code string to table { main = {{id=..., count=...}}, extra = {{id=..., count=...}} }
function var_0_0.decodeDeckCode(inputStr)
	if not inputStr or type(inputStr) ~= "string" then return nil end

	-- Trim whitespace and markdown quotes
	local str = inputStr:match("^%s*(.-)%s*$") or ""
	str = str:gsub("^`+", ""):gsub("`+$", "")
	str = str:match("^%s*(.-)%s*$") or ""

	local raw = nil

	-- Check for YGODECK:// or YGODECK: prefix
	if str:find("^YGODECK:") then
		local b64 = str:gsub("^YGODECK:/*", "")
		pcall(function()
			local decB64 = var_0_0.base64_decode(b64)
			if decB64 and decB64 ~= "" then
				raw = var_0_0.xor_crypt(decB64, XOR_KEY)
			end
		end)
	end

	-- Try base64 decrypt directly if raw is still nil
	if not raw or (not raw:find("M:") and not raw:find("E:")) then
		pcall(function()
			local decB64 = var_0_0.base64_decode(str)
			if decB64 and decB64 ~= "" then
				local cand = var_0_0.xor_crypt(decB64, XOR_KEY)
				if cand:find("M:") or cand:find("E:") then
					raw = cand
				end
			end
		end)
	end

	-- If still not decrypted, use str directly (plaintext fallback)
	if not raw then
		raw = str
	end

	local mainList = {}
	local extraList = {}

	-- Case 1: M:id*num,id*num...|E:id*num...
	if raw:find("M:") or raw:find("E:") then
		for part in raw:gmatch("[^|]+") do
			part = part:match("^%s*(.-)%s*$") or ""
			local isMain = part:find("^M:")
			local isExtra = part:find("^E:")
			if isMain or isExtra then
				local content = part:sub(3)
				for item in content:gmatch("[^,]+") do
					item = item:match("^%s*(.-)%s*$") or ""
					if item ~= "" then
						local cid, cnt = item:match("^(%d+)%*(%d+)$")
						if cid and cnt then
							local target = isExtra and extraList or mainList
							table.insert(target, { id = tonumber(cid), count = tonumber(cnt) })
						else
							local singleId = item:match("^(%d+)$")
							if singleId then
								local target = isExtra and extraList or mainList
								table.insert(target, { id = tonumber(singleId), count = 1 })
							end
						end
					end
				end
			end
		end
		return { main = mainList, extra = extraList }
	end

	-- Case 2: Raw comma/space/newline separated card IDs
	local counts = {}
	local order = {}
	for num in raw:gmatch("%d%d%d%d+") do
		local cid = tonumber(num)
		if cid then
			if not counts[cid] then
				table.insert(order, cid)
				counts[cid] = 1
			else
				counts[cid] = counts[cid] + 1
			end
		end
	end

	for _, cid in ipairs(order) do
		local cardType = Data.getType(cid)
		if cardType == Data.CardType.rare then
			table.insert(extraList, { id = cid, count = counts[cid] })
		else
			table.insert(mainList, { id = cid, count = counts[cid] })
		end
	end

	return { main = mainList, extra = extraList }
end

-- Copy deck string to clipboard
function var_0_0.copyText(text)
	if not text or text == "" then return false end

	-- Call JS clipboard bridge
	local ok = pcall(function()
		local jsb = jsbridge.object("jdzcDeckBridge")
		if jsb and jsb.copyText then
			jsb:copyText(text)
		end
	end)

	return ok
end

-- Copy current troop of scene
function var_0_0.copyCurrentTroop(scene, customTroop)
	local troop = customTroop
	if not troop and scene and scene._curTroopIndex then
		troop = ClientData._cloneTroops and ClientData._cloneTroops[scene._curTroopIndex] or P._playerCard:getTroop(scene._curTroopIndex, true)
	end

	if not troop or #troop == 0 then
		ToastManager.push("Bộ bài hiện tại đang trống, không thể sao chép!")
		return false
	end

	local code = var_0_0.encodeTroop(troop)
	var_0_0.copyText(code)

	local mainCount = P._playerCard:getTroopCardCountByType(nil, scene and scene._curTroopIndex or 1, true)
	local extraCount = P._playerCard:getTroopCardCountByType(Data.CardType.rare, scene and scene._curTroopIndex or 1, true)

	ToastManager.push(string.format("Đã sao chép mã bộ bài (%d lá chính, %d lá thêm)!", mainCount, extraCount))
	return true, code
end

-- Apply decoded deck to troop
function var_0_0.applyDeckCodeToTroop(scene, troopIndex, deckCodeStr)
	troopIndex = troopIndex or (scene and scene._curTroopIndex) or P._curTroopIndex or 1

	local decoded = var_0_0.decodeDeckCode(deckCodeStr)
	if not decoded or ((#decoded.main == 0) and (#decoded.extra == 0)) then
		ToastManager.push("Mã bộ bài không hợp lệ hoặc không tìm thấy lá bài nào!")
		return false
	end

	local maxMain = Data.MAX_TROOP_CARD_COUNT or 60
	local maxExtra = Data.MAX_RARE_TROOP_CARD_COUNT or 20

	local newTroop = {}
	local totalReqMain = 0
	local totalReqExtra = 0
	local totalAddMain = 0
	local totalAddExtra = 0

	-- Process Main Deck
	for _, it in ipairs(decoded.main) do
		local cid = it.id
		local req = it.count or 1
		totalReqMain = totalReqMain + req

		local owned = P._playerCard:getCardCount(cid) or 0
		local cInfo = Data.getInfo(cid)
		local maxAllowed = (cInfo and cInfo._maxCount) or 3

		local canAdd = math.min(req, owned, maxAllowed)
		if totalAddMain + canAdd > maxMain then
			canAdd = math.max(0, maxMain - totalAddMain)
		end

		if canAdd > 0 then
			table.insert(newTroop, {
				_infoId = cid,
				_num = canAdd
			})
			totalAddMain = totalAddMain + canAdd
		end
	end

	-- Process Extra Deck
	for _, it in ipairs(decoded.extra) do
		local cid = it.id
		local req = it.count or 1
		totalReqExtra = totalReqExtra + req

		local owned = P._playerCard:getCardCount(cid) or 0
		local cInfo = Data.getInfo(cid)
		local maxAllowed = (cInfo and cInfo._maxCount) or 3

		local canAdd = math.min(req, owned, maxAllowed)
		if totalAddExtra + canAdd > maxExtra then
			canAdd = math.max(0, maxExtra - totalAddExtra)
		end

		if canAdd > 0 then
			table.insert(newTroop, {
				_infoId = cid,
				_num = canAdd
			})
			totalAddExtra = totalAddExtra + canAdd
		end
	end

	local totalAdded = totalAddMain + totalAddExtra
	local totalReq = totalReqMain + totalReqExtra

	if totalAdded == 0 then
		ToastManager.push("Bạn không sở hữu lá bài nào trong mã bộ bài này!")
		return false
	end

	-- Save and sync
	ClientData._cloneTroops = ClientData._cloneTroops or {}
	ClientData._cloneTroops[troopIndex] = newTroop
	ClientData._cloneTroops[troopIndex]._isDirty = true

	ClientData.saveTroops(true)
	ClientData.sendTroops(true, troopIndex)

	-- Update Scene UI
	if scene then
		if scene.updateCardList then scene:updateCardList(false) end
		if scene.updateTroopList then scene:updateTroopList() end
		if scene.updateBottomValueAreas then scene:updateBottomValueAreas() end
	end

	if totalAdded == totalReq then
		ToastManager.push(string.format("Đã dán thành công toàn bộ %d lá bài (%d chính, %d thêm)!", totalAdded, totalAddMain, totalAddExtra))
	else
		local missing = totalReq - totalAdded
		ToastManager.push(string.format("Đã dán %d/%d lá sở hữu (%d chính, %d thêm - thiếu %d lá chưa có)!", totalAdded, totalReq, totalAddMain, totalAddExtra, missing))
	end

	return true
end

-- Show Paste Dialog
function var_0_0.showPasteDialog(scene, troopIndex)
	troopIndex = troopIndex or (scene and scene._curTroopIndex) or P._curTroopIndex or 1

	local pasteForm = require("PasteDeckForm").create(scene, troopIndex)
	pasteForm:show()
end

return var_0_0
