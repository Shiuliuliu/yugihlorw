#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import json
import os
import re

H5_PATCH_PATH = "web/src/h5_patch.lua"
CHAR_CARDS_MAP_PATH = "char_cards_map.json"

with open(CHAR_CARDS_MAP_PATH, "r", encoding="utf-8") as f:
    char_map = json.load(f)

# Build Lua CHAR_CARDS_MAP
map_lines = ["\tlocal CHAR_CARDS_MAP = {"]
for cid in sorted(char_map.keys(), key=lambda x: int(x) if x.isdigit() else 99999):
    if int(cid) < 100:
        cards = char_map[cid]
        map_lines.append(f"\t\t[{cid}] = {{ " + ", ".join(str(c) for c in cards) + " },")
map_lines.append("\t}")
lua_char_map = "\n".join(map_lines)

with open(H5_PATCH_PATH, "r", encoding="utf-8") as f:
    code = f.read()

# 1. Insert CHAR_CARDS_MAP above pickDraftCharacters
target_draft_start = "\tlocal function pickDraftCharacters()"
new_draft_pool_code = f"""{lua_char_map}

\tlocal function generateDraftPool(charId)
\t\tlocal charCards = (charId and CHAR_CARDS_MAP[tonumber(charId)]) or (charId and CHAR_CARDS_MAP[tostring(charId)])
\t\tlocal charMonsters = {{}}
\t\tlocal charSpells = {{}}

\t\tif charCards and #charCards > 0 then
\t\t\tfor _, cid in ipairs(charCards) do
\t\t\t\tcid = tonumber(cid)
\t\t\t\tif cid then
\t\t\t\t\tif cid < 20000 or cid >= 40000 then
\t\t\t\t\t\ttable.insert(charMonsters, cid)
\t\t\t\t\telse
\t\t\t\t\t\ttable.insert(charSpells, cid)
\t\t\t\t\tend
\t\t\t\tend
\t\t\tend
\t\tend

\t\tlocal fallbackMonsters = {{ 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010 }}
\t\tlocal fallbackSpells = {{ 20001, 20002, 20003, 20004, 20005, 30001, 30002, 30003 }}

\t\tlocal monsterPool = {{}}
\t\tif #charMonsters > 0 then
\t\t\twhile #monsterPool < 60 do
\t\t\t\tfor _, cid in ipairs(charMonsters) do
\t\t\t\t\ttable.insert(monsterPool, cid)
\t\t\t\t\tif #monsterPool >= 60 then break end
\t\t\t\tend
\t\t\tend
\t\telse
\t\t\tmonsterPool = fallbackMonsters
\t\tend

\t\tlocal spellPool = {{}}
\t\tif #charSpells > 0 then
\t\t\twhile #spellPool < 40 do
\t\t\t\tfor _, cid in ipairs(charSpells) do
\t\t\t\t\ttable.insert(spellPool, cid)
\t\t\t\t\tif #spellPool >= 40 then break end
\t\t\t\tend
\t\t\tend
\t\telse
\t\t\tspellPool = fallbackSpells
\t\tend

\t\t-- Shuffle pools
\t\tfor i = #monsterPool, 2, -1 do
\t\t\tlocal j = math.random(1, i)
\t\t\tmonsterPool[i], monsterPool[j] = monsterPool[j], monsterPool[i]
\t\tend
\t\tfor i = #spellPool, 2, -1 do
\t\t\tlocal j = math.random(1, i)
\t\t\tspellPool[i], spellPool[j] = spellPool[j], spellPool[i]
\t\tend

\t\tlocal pool = {{}}
\t\tlocal mIdx, sIdx = 1, 1
\t\tfor r = 1, 20 do
\t\t\tlocal roundCards = {{
\t\t\t\tmonsterPool[mIdx] or 10001,
\t\t\t\tmonsterPool[mIdx + 1] or 10002,
\t\t\t\tmonsterPool[mIdx + 2] or 10003,
\t\t\t\tspellPool[sIdx] or 20001,
\t\t\t\tspellPool[sIdx + 1] or 20002,
\t\t\t}}
\t\t\tmIdx = (mIdx + 3 > #monsterPool) and 1 or (mIdx + 3)
\t\t\tsIdx = (sIdx + 2 > #spellPool) and 1 or (sIdx + 2)
\t\t\tfor i = 5, 2, -1 do
\t\t\t\tlocal j = math.random(1, i)
\t\t\t\troundCards[i], roundCards[j] = roundCards[j], roundCards[i]
\t\t\tend
\t\t\tfor _, c in ipairs(roundCards) do
\t\t\t\ttable.insert(pool, c)
\t\t\tend
\t\tend
\t\treturn pool
\tend

{target_draft_start}"""

assert target_draft_start in code
code = code.replace(target_draft_start, new_draft_pool_code, 1)

# Remove the old generateDraftPool() function
old_draft_pattern = r"\tlocal function generateDraftPool\(\)[\s\S]*?\treturn pool\n\tend"
match = re.search(old_draft_pattern, code)
if match:
    code = code[:match.start()] + code[match.end():]
    print("[PATCH] Removed old generateDraftPool")

# Update select character calls to pass charId
code = code.replace("local pool = generateDraftPool()\n\t\tif P and P._playerFindSurvivalEx then", "local pool = generateDraftPool(charId)\n\t\tif P and P._playerFindSurvivalEx then")
code = code.replace("local pool = generateDraftPool()\n\t\tif P and P._playerFindSurvival then", "local pool = generateDraftPool(charId)\n\t\tif P and P._playerFindSurvival then")
code = code.replace("local pool = generateDraftPool()\n\t\tif P and P._playerFindLadder then", "local pool = generateDraftPool(charId)\n\t\tif P and P._playerFindLadder then")

# Mail loading and claim hooks
mail_system_code = """
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
								local ev = cc.EventCustom:new(Data.Event.bonus_dirty)
								ev._data = self
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

	pcall(function()
		local MailForm = require("MailForm")
		if MailForm and MailForm.onEnter then
			local orig_onEnter = MailForm.onEnter
			MailForm.onEnter = function(self, ...)
				pcall(function() loadPlayerMailsFromServer() end)
				return orig_onEnter(self, ...)
			end
		end
	end)
"""

# Insert mail system code before sendWorldFindEx
target_find_ex = "\t-- Arena Matchmaking\n\tClientData.sendWorldFindEx = function(troopIndex, battleType)"
assert target_find_ex in code
code = code.replace(target_find_ex, mail_system_code + "\n" + target_find_ex, 1)

# Now update sendWorldFindEx for SurvivalEx (port 8085 integration)
survival_match_code = """\t\t-- SURVIVAL EX (Sinh Tử Chiến - Dedicated Port 8085 Room)
\t\tif battleType == Battle_pb.PB_BATTLE_SURVIVAL_EX then
\t\t\tlocal myId = tonumber((ClientData._account and ClientData._account.id) or (P and P._id) or 1)
\t\t\tlocal myChar = (P and P._playerFindSurvivalEx and P._playerFindSurvivalEx._characterId) or 2
\t\t\tlocal reqPayload = {
\t\t\t\taccount_id = myId,
\t\t\t\tname = (P and P._name) or "Player",
\t\t\t\tlevel = (P and P._level) or 50,
\t\t\t\tavatar = (myChar > 0 and (myChar * 100 + 1)) or (((P and P._avatar) or 2) * 100 + 1),
\t\t\t\tcards = rawCardIds,
\t\t\t\textra_cards = {},
\t\t\t\tcharacter_id = myChar,
\t\t\t\tgold_cup = tonumber((ClientData._account and ClientData._account.gold_cup) or 0) or 0,
\t\t\t\tsilver_cup = tonumber((ClientData._account and ClientData._account.silver_cup) or 0) or 0,
\t\t\t\tbronze_cup = tonumber((ClientData._account and ClientData._account.bronze_cup) or 0) or 0
\t\t\t}

\t\t\tlocal api = jsbridge and jsbridge.object("jdzcApi")
\t\t\tif api and api.post then
\t\t\t\tapi:post("survival/join", reqPayload, function(rawRes)
\t\t\t\t\tif not ClientData._isFindingMatch or ClientData._findMatchSeq ~= curSeq then
\t\t\t\t\t\treturn
\t\t\t\t\tend
\t\t\t\t\tlocal res = (type(rawRes) == "string") and json.decode(rawRes) or rawRes
\t\t\t\t\tif res and res.code == 200 then
\t\t\t\t\t\tlocal roomId = res.room_id
\t\t\t\t\t\tlocal curPanel = ClientView._findMatchPanel
\t\t\t\t\t\tif curPanel and curPanel._userCountLabel then
\t\t\t\t\t\t\tcurPanel._userCountLabel:setString(tostring(res.player_count or 11) .. " / 25")
\t\t\t\t\t\tend

\t\t\t\t\t\tif res.status == "matched" and res.oppo then
\t\t\t\t\t\t\tlocal oppo = res.oppo
\t\t\t\t\t\t\tstartWithOppo(oppo.name, oppo.level, oppo.avatar, oppo.cards, res.seed, res.is_real_player, res.match_id, res.is_attacker, res.oppo_online, nil)
\t\t\t\t\t\t\treturn
\t\t\t\t\t\tend

\t\t\t\t\t\tlocal pollEntry
\t\t\t\t\t\tlocal isFinished = false
\t\t\t\t\t\tpollEntry = lc.Scheduler:scheduleScriptFunc(function()
\t\t\t\t\t\t\tif not ClientData._isFindingMatch or ClientData._findMatchSeq ~= curSeq or isFinished then
\t\t\t\t\t\t\t\tif pollEntry then lc.Scheduler:unscheduleScriptEntry(pollEntry) end
\t\t\t\t\t\t\t\treturn
\t\t\t\t\t\tend
\t\t\t\t\t\t\tapi:post("survival/poll", { account_id = myId, room_id = roomId }, function(rawPoll)
\t\t\t\t\t\t\t\tif not ClientData._isFindingMatch or ClientData._findMatchSeq ~= curSeq or isFinished then
\t\t\t\t\t\t\t\t\tif pollEntry then lc.Scheduler:unscheduleScriptEntry(pollEntry) end
\t\t\t\t\t\t\t\t\treturn
\t\t\t\t\t\t\t\tend
\t\t\t\t\t\t\t\tlocal pRes = (type(rawPoll) == "string") and json.decode(rawPoll) or rawPoll
\t\t\t\t\t\t\t\tif pRes and pRes.code == 200 then
\t\t\t\t\t\t\t\t\tlocal pPanel = ClientView._findMatchPanel
\t\t\t\t\t\t\t\t\tif pPanel and pPanel._userCountLabel and pRes.player_count then
\t\t\t\t\t\t\t\t\t\tpPanel._userCountLabel:setString(tostring(pRes.player_count) .. " / 25")
\t\t\t\t\t\t\t\t\tend
\t\t\t\t\t\t\t\t\tif pRes.status == "matched" and pRes.oppo then
\t\t\t\t\t\t\t\t\t\tisFinished = true
\t\t\t\t\t\t\t\t\t\tif pollEntry then lc.Scheduler:unscheduleScriptEntry(pollEntry) end
\t\t\t\t\t\t\t\t\t\tlocal oppo = pRes.oppo
\t\t\t\t\t\t\t\t\t\tstartWithOppo(oppo.name, oppo.level, oppo.avatar, oppo.cards, pRes.seed, pRes.is_real_player, pRes.match_id, pRes.is_attacker, pRes.oppo_online, nil)
\t\t\t\t\t\t\t\t\tend
\t\t\t\t\t\t\t\tend
\t\t\t\t\t\t\tend)
\t\t\t\t\t\tend, 1.0, false)
\t\t\t\t\t\tClientData._survivalPollEntry = pollEntry
\t\t\t\t\t\tClientData._currentSurvivalRoomId = roomId
\t\t\t\t\tend
\t\t\t\tend)
\t\t\tend
\t\t\treturn
\t\tend
"""

target_req_payload = "\t\tlocal reqPayload = {"
assert target_req_payload in code
code = code.replace(target_req_payload, survival_match_code + "\n" + target_req_payload, 1)

# In ClientData.sendWorldFindExCancel, handle survival cancel
target_cancel = "\tClientData.sendWorldFindExCancel = function()"
cancel_patch = """\tClientData.sendWorldFindExCancel = function()
\t\tif ClientData._currentSurvivalRoomId then
\t\t\tlocal myId = tonumber((ClientData._account and ClientData._account.id) or (P and P._id) or 1)
\t\t\tlocal api = jsbridge and jsbridge.object("jdzcApi")
\t\t\tif api and api.post then
\t\t\t\tapi:post("survival/cancel", { account_id = myId, room_id = ClientData._currentSurvivalRoomId })
\t\t\tend
\t\t\tif ClientData._survivalPollEntry then
\t\t\t\tpcall(function() lc.Scheduler:unscheduleScriptEntry(ClientData._survivalPollEntry) end)
\t\t\t\tClientData._survivalPollEntry = nil
\t\t\tend
\t\t\tClientData._currentSurvivalRoomId = nil
\t\tend"""
assert target_cancel in code
code = code.replace(target_cancel, cancel_patch, 1)

with open(H5_PATCH_PATH, "w", encoding="utf-8") as f:
    f.write(code)

print(f"[SUCCESS] Updated {H5_PATCH_PATH} successfully! File size: {len(code)} bytes.")
