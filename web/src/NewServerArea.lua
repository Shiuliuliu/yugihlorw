local var_0_0 = class("NewServerArea", lc.ExtendCCNode)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_0)
	var_1_0:init(arg_1_1)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		elseif arg_2_0 == "cleanup" then
			var_1_0:onCleanup()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._actType = arg_3_1
	arg_3_0._actInfo = ClientData.getValidActivityByType(arg_3_1)

	if arg_3_1 == Data.ActivityType.season_rank or arg_3_1 == Data.ActivityType.union_rank or arg_3_1 == Data.ActivityType.trophy_activity or arg_3_1 == Data.ActivityType.rank1 or arg_3_1 == Data.ActivityType.rank2 then
		arg_3_0._isRank = true
		arg_3_0._rankType = Data.RankType[arg_3_1]
		arg_3_0._rankBonusType = arg_3_0._rankType

		if arg_3_1 == Data.ActivityType.season_rank then
			arg_3_0._rankBonusType = 1726
		elseif arg_3_1 == Data.ActivityType.union_rank then
			arg_3_0._rankBonusType = 1725
		elseif arg_3_1 == Data.ActivityType.rank1 then
			arg_3_0._rankBonusType = 1728
		elseif arg_3_1 == Data.ActivityType.rank2 then
			arg_3_0._rankBonusType = 1729
		end
	else
		arg_3_0._isBonus = true
		arg_3_0._bonusCid = arg_3_1 - Data.ActivityType.clash_bonus + Data.BonusCid.new_server_begin
		arg_3_0._bonuses = P._playerBonus._newServerBonuses[arg_3_0._bonusCid]
	end

	local var_3_0 = lc.List.createV(arg_3_0:getContentSize(), 0, -3)

	lc.addChildToCenter(arg_3_0, var_3_0)

	arg_3_0._list = var_3_0
end

function var_0_0.refreshList(arg_4_0)
	local var_4_0 = arg_4_0._list

	var_4_0:removeAllItems()

	local var_4_1 = lc.formatJpg("new_server_ad_" .. arg_4_0._actType)

	lc.TextureCache:addImageWithMask(var_4_1)

	local var_4_2 = lc.createImageView(var_4_1)

	var_4_0:pushBackCustomItem(var_4_2)

	if arg_4_0._actType == Data.ActivityType.trophy_activity or arg_4_0._actType == Data.ActivityType.rank1 or arg_4_0._actType == Data.ActivityType.rank2 then
		local var_4_3, var_4_4 = ClientData.getActivityDurationStr(arg_4_0._actInfo, true, false)
		local var_4_5 = var_4_3 .. "-" .. var_4_4
		local var_4_6 = ClientView.createTTF(var_4_5)

		lc.addChildToPos(var_4_2, var_4_6, cc.p(730, 30))
	else
		local var_4_7 = math.floor((P._serverOpenTime + P._timeOffset) / 86400) * 86400
		local var_4_8 = math.floor((P._serverOpenTime + P._timeOffset) / 86400) * 86400 + 518400
		local var_4_9, var_4_10, var_4_11 = ClientData.getServerDate(var_4_7)
		local var_4_12, var_4_13, var_4_14 = ClientData.getServerDate(var_4_8)
		local var_4_15 = string.format(Str(STR.ACTIVITY_DATE_FORMAT), var_4_11, var_4_10, var_4_14, var_4_13)
		local var_4_16 = ClientView.createTTF(var_4_15)

		lc.addChildToPos(var_4_2, var_4_16, cc.p(730, 30))
	end

	if arg_4_0._isRank then
		local var_4_17 = P._playerRank:getRanks(arg_4_0._rankType)
		local var_4_18

		if var_4_17 then
			var_4_18 = var_4_17._selfRank
		end

		local var_4_19 = arg_4_0:createSelfRankItem(var_4_18)

		arg_4_0._selfRankItem = var_4_19

		var_4_0:pushBackCustomItem(var_4_19)

		local var_4_20 = {}

		for iter_4_0, iter_4_1 in pairs(Data._rankBonusInfo) do
			if iter_4_1._type == arg_4_0._rankBonusType then
				table.insert(var_4_20, iter_4_1)
			end
		end

		table.sort(var_4_20, function(arg_5_0, arg_5_1)
			return arg_5_0._id < arg_5_1._id
		end)

		for iter_4_2 = 1, #var_4_20 do
			local var_4_21 = var_4_20[iter_4_2]
			local var_4_22 = arg_4_0:setOrCreateRankItem(nil, var_4_21)

			var_4_0:pushBackCustomItem(var_4_22)
		end
	else
		local var_4_23 = {}
		local var_4_24, var_4_25, var_4_26 = P._playerBonus.splitBonus(P._playerBonus._newServerBonuses[arg_4_0._bonusCid])

		for iter_4_3, iter_4_4 in ipairs(var_4_24) do
			table.insert(var_4_23, iter_4_4)
		end

		for iter_4_5, iter_4_6 in ipairs(var_4_25) do
			table.insert(var_4_23, iter_4_6)
		end

		for iter_4_7, iter_4_8 in ipairs(var_4_26) do
			table.insert(var_4_23, iter_4_8)
		end

		for iter_4_9, iter_4_10 in ipairs(var_4_23) do
			var_4_0:pushBackCustomItem(arg_4_0:setOrCreateItem(nil, iter_4_10))
		end
	end
end

function var_0_0.createSelfRankItem(arg_6_0, arg_6_1)
	local var_6_0 = lc.createImageView({
		_name = "img_com_bg_58",
		_crect = cc.rect(42, 42, 1, 1),
		_size = cc.size(750, 80)
	})
	local var_6_1 = Str(STR.MY) .. Str(STR.RANK) .. ": "
	local var_6_2 = ClientView.createTTF(var_6_1 .. "?")

	var_6_2:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_6_0, var_6_2, cc.p(20, lc.ch(var_6_0)))

	local var_6_3 = Data.ResType.new_server_score

	if arg_6_0._rankType == 1715 then
		var_6_3 = Data.ResType.clash_trophy
	elseif arg_6_0._rankType == 1727 then
		var_6_3 = Data.ResType.trophy_activity
	elseif arg_6_0._rankType == 1728 then
		var_6_3 = Data.ResType.rank1
	end

	local var_6_4 = ClientView.createIconLabelArea(ClientData.getIconName(var_6_3), 0, 140)

	lc.addChildToCenter(var_6_0, var_6_4)

	local var_6_5 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("RankForm").create(Data.RankRange.lord, arg_6_0._rankType == 1715 and 5 or 1):show()
	end, ClientView.CRECT_BUTTON_S, 150)

	lc.addChildToPos(var_6_0, var_6_5, cc.p(lc.w(var_6_0) - 20 - lc.cw(var_6_5), lc.ch(var_6_0)))
	var_6_5:addLabel(Str(STR.LOOK_OVER) .. Str(STR.RANK))

	function var_6_0.update(arg_8_0)
		if not arg_8_0 then
			return
		end

		var_6_2:setString(var_6_1 .. arg_8_0._rank)
		var_6_4._label:setString(arg_8_0._value)
	end

	var_6_0.update(arg_6_1)

	return var_6_0
end

function var_0_0.setOrCreateRankItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 100

	if arg_9_1 == nil then
		arg_9_1 = lc.createImageView({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35
		})

		arg_9_1:setContentSize(750, 108)

		local var_9_1 = lc.createImageView("img_bg_deco_35")

		lc.addChildToPos(arg_9_1, var_9_1, cc.p(lc.w(var_9_1) / 2, lc.h(arg_9_1) / 2 + 3))

		arg_9_1._icons = {}

		function arg_9_1.update(arg_10_0)
			local var_10_0 = Data._bonusInfo[arg_10_0._bonusId]

			var_9_1:setColor(arg_10_0._max == 1 and cc.c3b(250, 64, 0) or arg_10_0._max == 2 and cc.c3b(0, 144, 250) or arg_10_0._max == 3 and cc.c3b(166, 128, 136) or cc.c3b(255, 255, 255))
			arg_9_1:removeChildByTag(var_9_0)

			if arg_10_0._id then
				if arg_10_0._max <= 3 and arg_10_0._min == arg_10_0._max then
					local var_10_1 = lc.createSprite(string.format("img_medal_%d", arg_10_0._max))

					lc.addChildToPos(arg_9_1, var_10_1, cc.p(90, lc.ch(arg_9_1)), 0, var_9_0)
				elseif arg_10_0._min == arg_10_0._max then
					local var_10_2 = ClientView.createBMFont(ClientView.BMFont.num_48, arg_10_0._min)

					lc.addChildToPos(arg_9_1, var_10_2, cc.p(90, lc.ch(arg_9_1)), 0, var_9_0)
				else
					local var_10_3 = ClientView.createBMFont(ClientView.BMFont.num_48, arg_10_0._min .. "-" .. arg_10_0._max)

					lc.addChildToPos(arg_9_1, var_10_3, cc.p(90, lc.ch(arg_9_1)), 0, var_9_0)
				end
			elseif arg_9_0._type == SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE then
				local var_10_4 = ClientView.createBMFont(ClientView.BMFont.num_48, Str(STR.NO_CHALLENGE))

				lc.addChildToPos(arg_9_1, var_10_4, cc.p(90, lc.ch(arg_9_1)), 0, var_9_0)
			end

			for iter_10_0, iter_10_1 in ipairs(arg_9_1._icons) do
				iter_10_1:setVisible(false)
			end

			local var_10_5 = #var_10_0._rid

			for iter_10_2, iter_10_3 in ipairs(var_10_0._rid) do
				local var_10_6 = {
					_infoId = var_10_0._rid[iter_10_2],
					_count = var_10_0._count[iter_10_2],
					_level = var_10_0._level[iter_10_2],
					_isFragment = var_10_0._isFragment[iter_10_2] > 0
				}
				local var_10_7 = arg_9_1._icons[iter_10_2]

				if not var_10_7 then
					var_10_7 = IconWidget.create(var_10_6, IconWidget.DisplayFlag.ITEM_NO_NAME)

					var_10_7:setScale(0.95)
					lc.addChildToPos(arg_9_1, var_10_7, cc.p(lc.cw(arg_9_1) + lc.cw(var_9_1) + (iter_10_2 - var_10_5 / 2 - 0.5) * 140, lc.ch(arg_9_1) + 3))
					table.insert(arg_9_1._icons, var_10_7)
				else
					var_10_7:resetData(var_10_6)
					bonusItem:setVisible(true)
				end
			end
		end
	end

	arg_9_1.update(arg_9_2)

	return arg_9_1
end

function var_0_0.setOrCreateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = string.format(Str(arg_11_2._info._nameSid), arg_11_2._info._val)

	if arg_11_1 == nil then
		arg_11_1 = require("BonusWidget").create(750, arg_11_2, var_11_0)

		if (arg_11_2._info._cid == Data.BonusCid.new_server_travel or arg_11_2._info._cid == Data.BonusCid.new_server_travel_2 or arg_11_2._info._cid == Data.BonusCid.new_server_travel_3) and arg_11_1._progBar then
			arg_11_1._progBar:setVisible(false)
		end

		arg_11_1:registerCallback(function(arg_12_0)
			local var_12_0 = ClientData.claimBonus(arg_12_0)

			if var_12_0 == Data.ErrorType.ok then
				ClientView.showClaimBonusResult(arg_12_0, var_12_0)
			elseif arg_11_0._actType == Data.ActivityType.clash_bonus then
				lc.pushScene(require("FindScene").create())
			elseif arg_11_0._actType == Data.ActivityType.arena_bonus then
				lc.pushScene(require("FindScene").create(Data.FindMatchType.ladder))
			elseif arg_11_0._actType == Data.ActivityType.travel_bonus then
				require("TravelPanel").create():show()
			end
		end)
	else
		arg_11_1:setBonus(arg_11_2, var_11_0)
	end

	return arg_11_1
end

function var_0_0.onEnter(arg_13_0)
	arg_13_0._listeners = {}

	if arg_13_0._isRank then
		table.insert(arg_13_0._listeners, lc.addEventListener(Data.Event.rank_list_dirty, function(arg_14_0)
			if arg_14_0._type == arg_13_0._rankType then
				local var_14_0 = P._playerRank:getRanks(arg_13_0._rankType)._selfRank

				if arg_13_0._selfRankItem then
					arg_13_0._selfRankItem.update(var_14_0)
				end
			end
		end))
		P._playerRank:sendRankRequest(arg_13_0._rankType)
	end

	arg_13_0:refreshList()
end

function var_0_0.onExit(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_15_1)
	end
end

function var_0_0.onCleanup(arg_16_0)
	return
end

return var_0_0
