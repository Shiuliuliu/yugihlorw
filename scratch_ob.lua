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

	-- Build troops from decks
	local troops_list = {}
	for i = 1, 5 do
		troops_list[i] = pbMock({ troop_item = {} })
	end
	for _, d in ipairs(decks or {}) do
		local slot = tonumber(d.deck_slot) or 1
		if slot >= 1 and slot <= 5 then
			local items = {}
			for _, cid in ipairs(d.cards or {}) do
				table.insert(items, pbMock({ info_id = cid, num = 1 }))
			end
			for _, cid in ipairs(d.extra_cards or {}) do
				table.insert(items, pbMock({ info_id = cid, num = 1 }))
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

	local user_info = pbMock({
		id = acc.id or 1,
		name = acc.character_name or acc.username or "Duelist",
		level = tonumber(acc.level) or 50,
		exp = tonumber(acc.exp) or 0,
		gold = tonumber(acc.gold) or 99999999,
		ingot = tonumber(acc.gem) or 999999,
		grain = 99999999,
		vip = tonumber(acc.vip_level) or 0,
		vip_exp = 0,
		trophy = 0,
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
	})

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

	local attach_data = pbMock({
		character = character_data,
	local claimed_list = {}
	if checkins and type(checkins) == "table" then
		for _, ck in ipairs(checkins) do
			local did = tonumber(ck.day_index) or 0
			if did > 0 then table.insert(claimed_list, did) end
		end
	end

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
			props = {},
			chests = {},
			crowns = {},
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

return OnlineBridge
