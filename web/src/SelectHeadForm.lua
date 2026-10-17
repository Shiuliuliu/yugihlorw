local var_0_0 = class("SelectHeadForm", BaseForm)
local var_0_1 = cc.size(840, 640)
local var_0_2 = 6

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.CHANGE_ICON), 0)

	local var_2_0 = lc.List.createV(cc.size(lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 32, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM), 20, 20)

	var_2_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0._frame, var_2_0)

	arg_2_0._list = var_2_0

	-- 1. Duelist Avatars
	local duelist_list = {}
	local curChar = (P and P:getCharacterId()) or 3
	local curCharAv = curChar * 100 + 1
	table.insert(duelist_list, curCharAv)

	local standard_duelists = {
		301, 201, 501, 401, 1201, 1101, 1301, 1401, 1501, 1601, 1701, 1801, 1901, 701, 901, 1001, 5101
	}
	local seen_duelists = { [curCharAv] = true }
	for _, aid in ipairs(standard_duelists) do
		if not seen_duelists[aid] then
			table.insert(duelist_list, aid)
			seen_duelists[aid] = true
		end
	end

	-- Also include any other characters from Data._characterInfo
	if Data and Data._characterInfo then
		for cid, _ in pairs(Data._characterInfo) do
			local c_num = tonumber(cid)
			if c_num and c_num > 0 then
				local aid = c_num * 100 + 1
				if not seen_duelists[aid] then
					local avName = ClientData.getAvatarName(aid)
					if lc.FrameCache and lc.FrameCache:getSpriteFrame(avName) then
						table.insert(duelist_list, aid)
						seen_duelists[aid] = true
					end
				end
			end
		end
	end

	-- 2. Monster Skins (52001 - 52072)
	local monster_skins = {}
	for sid = 52001, 52072 do
		table.insert(monster_skins, sid)
	end

	arg_2_0._duelistAvatars = duelist_list
	arg_2_0._monsterSkins = monster_skins

	arg_2_0:updateAvatarList()
end

function var_0_0.updateAvatarList(arg_3_0)
	local var_3_0 = {}

	-- Section 1: Duelist Avatars
	table.insert(var_3_0, Str(STR.CHANGE_CHARACTER) or "Avatar Đấu Thủ")
	local cur_row = nil
	for _, aid in ipairs(arg_3_0._duelistAvatars or {}) do
		if cur_row == nil or #cur_row == var_0_2 then
			cur_row = {}
			table.insert(var_3_0, cur_row)
		end
		table.insert(cur_row, aid)
	end

	-- Section 2: Monster Skins
	table.insert(var_3_0, Str(STR.AVATAR_CARD_TIP) or "Avatar Quái Thú Đặc Biệt")
	cur_row = nil
	for _, sid in ipairs(arg_3_0._monsterSkins or {}) do
		if cur_row == nil or #cur_row == var_0_2 then
			cur_row = {}
			table.insert(var_3_0, cur_row)
		end
		table.insert(cur_row, sid)
	end

	local var_3_2 = arg_3_0._list

	var_3_2:bindData(var_3_0, function(arg_4_0, arg_4_1)
		arg_3_0:setOrCreateItem(arg_4_0, arg_4_1)
	end, math.min(8, #var_3_0), 1)

	for iter_3_1 = 1, var_3_2._cacheCount do
		local var_3_3 = var_3_0[iter_3_1]
		local var_3_4 = arg_3_0:setOrCreateItem(nil, var_3_3)

		var_3_2:pushBackCustomItem(var_3_4)
	end

	var_3_2:jumpToTop()
end

function var_0_0.setOrCreateItem(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == nil then
		arg_5_1 = ccui.Widget:create()
	end

	arg_5_1:removeAllChildren()

	if type(arg_5_2) == "string" then
		local var_5_0 = 66

		arg_5_1:setContentSize(lc.w(arg_5_0._list), var_5_0)
		ClientView.addDecoratedLabel(arg_5_1, arg_5_2, cc.p(lc.w(arg_5_1) / 2, var_5_0 / 2), 26)
	else
		local var_5_1 = 104
		local var_5_2 = 20
		local var_5_3 = (var_5_1 + var_5_2) * var_0_2 - var_5_2

		arg_5_1:setContentSize(var_5_3, 100)

		local var_5_4 = cc.p(var_5_1 / 2, lc.h(arg_5_1) / 2)

		for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
			local var_5_5 = ClientView.createShaderButton("avatar_frame_001", function()
				if ClientData._player:changeIcon(iter_5_1) then
					ClientData.sendSetAvatar(iter_5_1)
					arg_5_0:hide()
				else
					ClientData.sendSetAvatar(iter_5_1)
					arg_5_0:hide()
				end
			end)

			lc.addChildToPos(arg_5_1, var_5_5, var_5_4)

			local var_5_6 = lc.createSprite("img_card_ico_bg")
			lc.addChildToCenter(var_5_5, var_5_6, -1)

			local avName = ClientData.getAvatarName(iter_5_1)
			local var_5_7 = nil
			if avName and lc.FrameCache and lc.FrameCache:getSpriteFrame(avName) then
				var_5_7 = lc.createSprite(avName)
			else
				var_5_7 = lc.createSprite("avatar_03")
			end

			if var_5_7 then
				var_5_7:setScale(0.8)
				lc.addChildToCenter(var_5_5, var_5_7, -1)
			end

			-- Highlight equipped avatar
			if P and P._avatar == iter_5_1 then
				local selFrame = lc.createSprite("avatar_frame_vip_bg")
				if not selFrame then selFrame = lc.createSprite("avatar_frame_001") end
				if selFrame then
					selFrame:setScale(1.06)
					lc.addChildToCenter(var_5_5, selFrame, 2)
				end
			end

			var_5_4.x = var_5_4.x + lc.w(var_5_5) + var_5_2
		end
	end

	return arg_5_1
end

return var_0_0
