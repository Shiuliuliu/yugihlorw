local OnlineBridge = {}

local function pbMock(t)
	t = t or {}
	function t.HasField(self, f) return rawget(self, f) ~= nil end
	function t.HasExtension(self, e) return false end
	return t
end

local function zeroMock(fields_str)
	local t = {}
	for w in fields_str:gmatch("%S+") do t[w] = 0 end
	return pbMock(t)
end

function OnlineBridge.buildLoginData(acc, cards, decks, cur_levels, checkins)
	local now_ms = os.time() * 1000

	-- Build card lists
	local card_list = {}
	local card_levels = {}
	local card_unlocked = {}
	local card_collected = {}

	for _, c in ipairs(cards or {}) do
		table.insert(card_list, pbMock({ info_id = c.card_id, num = c.count }))
		table.insert(card_levels, pbMock({ info_id = c.card_id, level = 1 }))
		table.insert(card_unlocked, c.card_id)
		table.insert(card_collected, c.card_id)
	end

	-- Build troops from decks with aggregated card counts
	local troops_list = {}
	for i = 1, 5 do
		troops_list[i] = pbMock({ troop_item = {} })
	end
	for _, d in ipairs(decks or {}) do
		local slot = tonumber(d.deck_slot) or 1
		if slot >= 1 and slot <= 5 then
			local counts, order = {}, {}
			for _, cid in ipairs(d.cards or {}) do
				cid = tonumber(cid)
				if cid and cid > 0 then
					if not counts[cid] then
						counts[cid] = 0
						table.insert(order, cid)
					end
					counts[cid] = counts[cid] + 1
				end
			end
			local extra_counts, extra_order = {}, {}
			for _, cid in ipairs(d.extra_cards or {}) do
				cid = tonumber(cid)
				if cid and cid > 0 then
					if not extra_counts[cid] then
						extra_counts[cid] = 0
						table.insert(extra_order, cid)
					end
					extra_counts[cid] = extra_counts[cid] + 1
				end
			end
			local items = {}
			for _, cid in ipairs(order) do
				table.insert(items, pbMock({ info_id = cid, num = counts[cid] }))
			end
			for _, cid in ipairs(extra_order) do
				table.insert(items, pbMock({ info_id = cid, num = extra_counts[cid] }))
			end
			troops_list[slot] = pbMock({ troop_item = items })
		end
	end

	-- Resolve avatar and character
	local char_avatar = tonumber(acc.avatar)
	if not char_avatar or char_avatar < 100 then
		local uname = string.lower(tostring(acc.username or ""))
		local cname = string.lower(tostring(acc.character_name or ""))
		if string.find(uname, "yugi") or string.find(cname, "yugi") or uname == "admin" then
			char_avatar = 301 -- Yugi Muto
		elseif string.find(uname, "kaiba") or string.find(cname, "kaiba") then
			char_avatar = 201 -- Seto Kaiba
		elseif string.find(uname, "joey") or string.find(cname, "joey") or string.find(cname, "jonouchi") then
			char_avatar = 501 -- Joey Wheeler / Jonouchi
		else
			char_avatar = 301
		end
	end

	local char_gold_c = tonumber(acc.gold_cup) or 0
	local char_silver_c = tonumber(acc.silver_cup) or 0
	local char_bronze_c = tonumber(acc.bronze_cup) or 0
	local crown_id = nil
	local crown_num = 0
	if char_gold_c > 0 then
		crown_id = 7204
		crown_num = char_gold_c
	elseif char_silver_c > 0 then
		crown_id = 7205
		crown_num = char_silver_c
	elseif char_bronze_c > 0 then
		crown_id = 7206
		crown_num = char_bronze_c
	end

	local user_info_fields = {
		id = acc.id or 1,
		name = acc.character_name or acc.username or "Duelist",
		level = tonumber(acc.level) or 50,
		exp = tonumber(acc.exp) or 0,
		gold = tonumber(acc.gold) or 99999999,
		ingot = tonumber(acc.gem) or 999999,
		grain = 99999999,
		vip = tonumber(acc.vip_level) or 0,
		vip_exp = 0,
		trophy = tonumber(acc.trophy) or 800,
		avatar = char_avatar,
		avatar_frame = 0,
		guide = 20000,
		guide1 = 20000,
		guide2 = 20000,
		union_id = 0,
		union_title = 0,
		room_id = 0,
		room_title = 0,
		privilege = 0,
		last_login = now_ms,
		reg_date = now_ms,
		card_back = (Data and Data.PropsId and Data.PropsId.card_back) or 7600,
		code = ""
	}
	if crown_id then
		user_info_fields.crown = pbMock({
			info_id = crown_id,
			num = crown_num
		})
	end
	local user_info = pbMock(user_info_fields)

	local user_battle = zeroMock("total_pvp_win total_pvp_lose daily_pvp_win daily_pvp_lose daily_ladder_win ladder_cont_win ladder_cont_lose boss_score")

	local user_lottery = pbMock({
		point = 0,
		nchest = 0,
		nchest_ex = 0,
		next_quality = 1,
		next_free = {}
	})

	local user_count = zeroMock("invite_charge invite_count buy_chest1 buy_chest2 buy_chest3 buy_chest4 buy_hero_exp buy_equip_exp buy_horse_exp buy_book_exp buy_stone buy_remedy buy_gold buy_grain buy_refresh buy_refresh_pvp buy_refresh_union buy_refresh_ladder buy_expedition buy_elite buy_rob_exp buy_commander rob_gold donate worship challenge_elite challenge_commander trophy expedition send_mail gold collect_gold atk_boss buy_atk_boss reset_ladder next_sos re_check welfare edit_name next_share next_chat next_find buy_refresh_find atk_player atk_uboss grace month_card month_card_ex charge daily_charge")
	user_count.next_spawn = now_ms

	local card_data = pbMock({
		extra_troop_count = 5,
		levels = card_levels,
		cards = card_list,
		unlocked = card_unlocked,
		collected = card_collected,
		skin = {},
		dark_troops = {},
		room_dark_troops = {},
		troops = troops_list,
		fragments = {},
		slots = {}
	})

	-- Dynamically enumerate valid character IDs from Data._characterInfo
	local char_list = {}
	for cid, cinfo in pairs(Data._characterInfo or {}) do
		local id_num = tonumber(type(cinfo) == "table" and (cinfo._id or cinfo.id) or cid)
		if id_num and id_num > 0 then
			table.insert(char_list, pbMock({
				id = id_num,
				level = tonumber(acc.level) or 50,
				exp = 0,
				skin = 0,
				avatar = id_num * 100 + 1,
				break_out = 0
			}))
		end
	end
	table.sort(char_list, function(a, b) return a.id < b.id end)

	local character_data = pbMock({
		is_dynamic_timeout = false,
		chars = char_list
	})

	local claimed_list = {}
	if checkins and type(checkins) == "table" then
		for _, ck in ipairs(checkins) do
			local did = tonumber(type(ck) == "table" and (ck.day_index or ck._day_index) or ck) or 0
			if did > 0 then
				table.insert(claimed_list, did)
				if did <= 31 then table.insert(claimed_list, 6000 + did) end
				if did <= 7 then table.insert(claimed_list, 3000 + did) end
				if did >= 6001 and did <= 6031 then table.insert(claimed_list, did - 6000) end
				if did >= 3001 and did <= 3007 then table.insert(claimed_list, did - 3000) end
			end
		end
	end

	local attach_data = pbMock({
		character = character_data,
		bonus = pbMock({
			bonuses = {},
			claimed = claimed_list,
			funds = {},
			task_reset_count = 0,
			items = {},
			daily_task = {},
			achieve = {},
			login_days = 1,
			sign_in_days = 1,
			fund_charge = 0
		}),
		activity = pbMock({
			ghost = 0,
			login = 0,
			charge = 0,
			charge_ex = 0,
			last_charge_ex = 0,
			rebate = 0,
			consume = 0,
			privilege_stamp = 0,
			last_ladder_ex_privilege = 0,
			last_survival_ex_privilege = 0,
			double_charge_day_limit_value = 0,
			turn_table_count = 0,
			personal_fund_status = {},
			bundles = {},
			badge_season = 1,
			badge_level = 1,
			badge_exp = 0,
			badge_purchased = false,
			badge_end_timestamp = now_ms + 2592000000,
			spring_badge_season = 1,
			spring_badge_level = 1,
			spring_badge_exp = 0,
			spring_badge_purchased = false,
			spring_badge_end_timestamp = now_ms + 2592000000,
			spring2_badge_season = 1,
			spring2_badge_level = 1,
			spring2_badge_exp = 0,
			spring2_badge_purchased = false,
			spring2_badge_end_timestamp = now_ms + 2592000000
		}),
		ladder = pbMock({
			has_ticket = false,
			char_id = 0,
			step = 0,
			pool = {},
			cards = {},
			win = 0,
			lose = 0,
			chars = {},
			selected = {},
			roll_times = 0,
			used_extra_lose_times = 0,
			legend_ticket = false,
			legend_win = 0,
			legend_lose = 0,
			daily_win = 0,
			records = {}
		}),
		dark = pbMock({
			inning = 0,
			score = 0,
			win = 0,
			opWin = 0,
			daily_win = 0,
			total_win = 0,
			chars = {},
			pool = {},
			cards = {},
			selected = {},
			records = {}
		}),
		survival = pbMock({
			has_ticket = false,
			char_id = 0,
			step = 0,
			pool = {},
			cards = {},
			win = 0,
			lose = 0,
			captures = {},
			chars = {},
			selected = {},
			privilege_stamp = 0,
			records = {}
		}),
		survival_ex = pbMock({
			has_ticket = false,
			char_id = 0,
			trophy = 0,
			roll_times = 0,
			win = 0,
			lose = 0,
			step = 0,
			privilege_stamp = 0,
			pool = {},
			cards = {},
			chars = {},
			selected = {},
			captures = {},
			capture_skills = {},
			records = {}
		}),
		prop = pbMock({
			props = {
				pbMock({ info_id = 7114, num = tonumber(acc.void_stone) or 5000 }), -- void_diamond
				pbMock({ info_id = 7111, num = tonumber(acc.purple_ticket) or 500 }), -- ladder_ticket
				pbMock({ info_id = 7132, num = 500 }), -- survival_ticket
				pbMock({ info_id = 7122, num = 500 }), -- dark_ticket
				pbMock({ info_id = 7040, num = tonumber(acc.leya_ticket) or 500 }), -- lottery_token
				pbMock({ info_id = 7110, num = 5000 }), -- rare_coin
				pbMock({ info_id = 7120, num = 10000 }), -- magic_dust
				pbMock({ info_id = 7117, num = 500 }), -- skin_crystal
				pbMock({ info_id = 7346, num = 100 }) -- skill_item_token
			},
			chests = {},
			crowns = (function()
				local cList = {}
				if char_gold_c > 0 then table.insert(cList, pbMock({ info_id = 7204, num = char_gold_c })) end
				if char_silver_c > 0 then table.insert(cList, pbMock({ info_id = 7205, num = char_silver_c })) end
				if char_bronze_c > 0 then table.insert(cList, pbMock({ info_id = 7206, num = char_bronze_c })) end
				return cList
			end)(),
			legend_crowns = {},
			marks = {}
		}),
		shop = pbMock({
			rare_bundles = {},
			legend_bundles = {},
			exchange_prop_limit = {},
			recycle_card_limit = {},
			rubbing_limit = {},
			shops = {}
		}),
		copy = pbMock({
			copies = {}
		})
	})

	local city_data = pbMock({
		last_collect_grain = now_ms,
		last_collect_gold = now_ms,
		guards = {}
	})

	local world_data = pbMock({
		elite = {},
		boss = {},
		cur_levels = cur_levels or acc.cur_levels or { 10101, 20101, 30101, 40101 }
	})

	local resp = pbMock({
		team_member_uplimit = 2,
		power = 10000,
		time_of_ann = 0,
		time_offset = 0,
		function_switch = 0,
		announcement = "",
		can_bind = false,
		server_open_time = now_ms,
		open_time = now_ms,
		server_version = "1.0",
		user_info = user_info,
		user_battle = user_battle,
		user_lottery = user_lottery,
		user_count = user_count,
		card = card_data,
		city = city_data,
		world = world_data,
		attach = attach_data,
		ban_chat = {}
	})

	return resp
end


function OnlineBridge.syncCheckinBonuses(player, checkins)
	if not player or not player._playerBonus then return end
	local pb = player._playerBonus
	local claimed_map = {}
	if checkins and type(checkins) == "table" then
		for _, ck in ipairs(checkins) do
			local did = tonumber(type(ck) == "table" and (ck.day_index or ck._day_index) or ck) or 0
			if did > 0 then
				claimed_map[did] = true
				if did <= 31 then claimed_map[6000 + did] = true end
				if did <= 7 then claimed_map[3000 + did] = true end
				if did >= 6001 and did <= 6031 then claimed_map[did - 6000] = true end
				if did >= 3001 and did <= 3007 then claimed_map[did - 3000] = true end
			end
		end
	end
	if ClientData._claimedCheckins then
		for did, _ in pairs(ClientData._claimedCheckins) do
			claimed_map[did] = true
			local ndid = tonumber(did) or 0
			if ndid <= 31 then claimed_map[6000 + ndid] = true end
			if ndid <= 7 then claimed_map[3000 + ndid] = true end
			if ndid >= 6001 and ndid <= 6031 then claimed_map[ndid - 6000] = true end
		end
	end

	local function syncList(list, offset)
		if not list then return end
		local maxClaimed = 0
		for _, b in ipairs(list) do
			local val = b._info and b._info._val or 0
			local isClaimed = claimed_map[b._infoId] or (val > 0 and claimed_map[val]) or (val > 0 and claimed_map[offset + val])
			if isClaimed then
				b._isClaimed = true
				b._value = val > 0 and val or 1
				if val > maxClaimed then maxClaimed = val end
			end
		end
		local nextVal = maxClaimed + 1
		for _, b in ipairs(list) do
			if not b._isClaimed then
				local val = b._info and b._info._val or 0
				if val == nextVal then
					b._value = val
					b._isDefaultClaimable = true
				else
					b._value = 0
					b._isDefaultClaimable = false
				end
			end
		end
	end

	syncList(pb._bonusWeekCheckin, 3000)
	syncList(pb._bonusMonthCheckin, 6000)

	-- Sync player trophy
	local accTrophy = (acc and acc.trophy) or (ClientData._account and ClientData._account.trophy) or 800
	player._trophy = tonumber(accTrophy) or 0
	local my_gc = (ClientData._account and tonumber(ClientData._account.gold_cup)) or 0
	local my_sc = (ClientData._account and tonumber(ClientData._account.silver_cup)) or 0
	local my_bc = (ClientData._account and tonumber(ClientData._account.bronze_cup)) or 0
	player._goldCup = my_gc
	player._silverCup = my_sc
	player._bronzeCup = my_bc
	if my_gc > 0 then
		player._crown = { _infoId = 7204, _num = my_gc }
	elseif my_sc > 0 then
		player._crown = { _infoId = 7205, _num = my_sc }
	elseif my_bc > 0 then
		player._crown = { _infoId = 7206, _num = my_bc }
	end
	if player._playerFindClash then
		player._playerFindClash._trophy = player._trophy
		player._playerFindClash._grade = player._playerFindClash:getGrade(player._trophy)
	end

	-- Unlock chat globally
	if Data and Data._globalInfo then
		Data._globalInfo._unlockChat = 1
	end

	-- Pre-fetch leaderboard for Arena
	pcall(function()
		local api = jsbridge and jsbridge.object("jdzcApi")
		if api and api.post then
			api:post("leaderboard", { type = 0, account_id = (player and player._id) or (P and P._id) or 0 }, function(rawRes)
				local res = rawRes
				if type(res) == "string" then
					local ok, parsed = pcall(function() return require("json").decode(res) end)
					if ok and parsed then res = parsed end
				end
				if res and res.ranks and player and player._playerRank then
					ClientData._cachedLeaderboard = {}
					local rankList = {}
					for i, r in ipairs(res.ranks) do
						local crownObj = nil
						local r_gc = tonumber(r.gold_cup) or 0
						local r_sc = tonumber(r.silver_cup) or 0
						local r_bc = tonumber(r.bronze_cup) or 0
						if r_gc > 0 then crownObj = { info_id = 7204, num = r_gc }
						elseif r_sc > 0 then crownObj = { info_id = 7205, num = r_sc }
						elseif r_bc > 0 then crownObj = { info_id = 7206, num = r_bc }
						end
						local uinfo = {
							id = r.id or i,
							name = r.name or ("Duelist_" .. i),
							level = r.level or 50,
							avatar = r.avatar or 201,
							trophy = r.trophy or 800,
							vip = r.vip or 0,
							gold = 0, grain = 0, ingot = 0, exp = 0, shield = 0,
							union_id = 0, union_name = "", union_title = 0, union_avatar = 0, union_tag = "",
							last_login = os.time() * 1000, rid = 10001, privilege = 0, month_card = 0
						}
						if crownObj then uinfo.crown = pbMock(crownObj) end
						local uObj = require("User").create(uinfo)
						local rankItem = {
							_user = uObj,
							_rank = r.rank or i,
							_value = r.trophy or 800
						}
						table.insert(rankList, rankItem)
						table.insert(ClientData._cachedLeaderboard, rankItem)
					end
					rankList._count = #rankList
					player._playerRank._ranks = player._playerRank._ranks or {}
					player._playerRank._ranks[SglMsgType_pb.PB_TYPE_RANK_PRE] = rankList
					player._playerRank._ranks[SglMsgType_pb.PB_TYPE_RANK_LADDER] = rankList
				end
			end)
		end
	end)
end

return OnlineBridge
