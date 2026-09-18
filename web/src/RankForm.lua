local var_0_0 = class("RankForm", BaseForm)
local var_0_1 = cc.size(1024, 660)
local var_0_2 = 150
local var_0_3 = 120
local var_0_4 = 140
local var_0_5 = cc.p(420, 25)
local var_0_6 = cc.size(280, 34)
local var_0_7 = cc.p(700, 78)
local var_0_8 = cc.p(700, 48)
local var_0_9 = cc.p(700, 20)
local var_0_10 = 100
local var_0_11 = 100
local var_0_12 = 30

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.BILLBOARD), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))
	arg_2_0:initLeftArea()
	arg_2_0:initSelfArea()
	arg_2_0:initMainList()

	arg_2_0._isPre = arg_2_4
	arg_2_0._range = arg_2_1

	arg_2_0:refreshRank()

	arg_2_0._initTabIndex = arg_2_2 or 1
	arg_2_0._initSubTab = arg_2_3

	if arg_2_0._tabs[arg_2_0._initTabIndex] and arg_2_0._tabs[arg_2_0._initTabIndex]._tabs then
		local var_2_0 = arg_2_0._tabs[arg_2_0._initTabIndex]._tabs

		arg_2_0._initSubTab = var_2_0[#var_2_0]._subIndex
	end
end

function var_0_0.initLeftArea(arg_3_0)
	local var_3_0 = ClientView.createVerticalTabListArea(lc.h(arg_3_0._form) - var_0_0.TOP_MARGIN - var_0_0.BOTTOM_MARGIN, nil, function(arg_4_0)
		arg_3_0:showSubTab(arg_4_0)
	end)

	lc.addChildToPos(arg_3_0._form, var_3_0, cc.p(var_0_0.LEFT_MARGIN + lc.w(var_3_0) / 2 - 12, lc.h(arg_3_0._form) / 2))

	arg_3_0._leftArea = var_3_0
end

function var_0_0.initSelfArea(arg_5_0)
	local var_5_0 = ccui.Scale9Sprite:createWithSpriteFrameName("img_com_bg_4", ClientView.CRECT_COM_BG4)

	var_5_0:setContentSize(lc.w(arg_5_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN - lc.w(arg_5_0._leftArea) + 6, var_0_2)
	lc.addChildToPos(arg_5_0._form, var_5_0, cc.p(lc.right(arg_5_0._leftArea) + lc.w(var_5_0) / 2 + 8, lc.top(arg_5_0._leftArea) - lc.h(var_5_0) / 2 - 16), 1)

	local var_5_1 = ccui.Widget:create()

	var_5_1:setAnchorPoint(0.5, 0.5)
	var_5_1:setContentSize(var_5_0:getContentSize())
	lc.addChildToCenter(var_5_0, var_5_1)

	arg_5_0._selfArea = var_5_1

	var_5_1:setVisible(false)

	local var_5_2 = lc.createSprite("img_glow")

	var_5_2:setScale(0.5)
	lc.addChildToPos(var_5_1, var_5_2, cc.p(22 + lc.sw(var_5_2) / 2, lc.h(var_5_1) / 2))

	local var_5_3 = ClientView.createBMFont(ClientView.BMFont.num_48, "0")

	lc.addChildToPos(var_5_1, var_5_3, cc.p(lc.x(var_5_2) - 2, lc.y(var_5_2)))

	var_5_1._rank = var_5_3
end

function var_0_0.initMainList(arg_6_0)
	local var_6_0 = arg_6_0._leftArea
	local var_6_1 = arg_6_0._selfArea
	local var_6_2 = lc.List.createV(cc.size(lc.w(var_6_1) - 8, lc.h(var_6_0) - lc.h(var_6_1) - 14), 6, 0)

	lc.addChildToPos(arg_6_0._form, var_6_2, cc.p(lc.right(var_6_0) + 12, lc.bottom(var_6_0)))

	arg_6_0._list = var_6_2
end

function var_0_0.refreshRank(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._range

	if not arg_7_0._isPre or not SglMsgType_pb.PB_TYPE_RANK_PRE then
		local var_7_1 = SglMsgType_pb.PB_TYPE_RANK_LADDER
	end

	local var_7_2

	if var_7_0 == Data.RankRange.lord then
		local var_7_3 = {
			{
				_subIndex = 29,
				_isSub = true,
				_str = Str(Data._characterInfo[19]._nameSid),
				_userData = {
					_subType = 19,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 28,
				_isSub = true,
				_str = Str(Data._characterInfo[18]._nameSid),
				_userData = {
					_subType = 18,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 27,
				_isSub = true,
				_str = Str(Data._characterInfo[17]._nameSid),
				_userData = {
					_subType = 17,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 26,
				_isSub = true,
				_str = Str(Data._characterInfo[16]._nameSid),
				_userData = {
					_subType = 16,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 25,
				_isSub = true,
				_str = Str(Data._characterInfo[15]._nameSid),
				_userData = {
					_subType = 15,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 21,
				_isSub = true,
				_str = Str(Data._characterInfo[11]._nameSid),
				_userData = {
					_subType = 11,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 24,
				_isSub = true,
				_str = Str(Data._characterInfo[14]._nameSid),
				_userData = {
					_subType = 14,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 17,
				_isSub = true,
				_str = Str(Data._characterInfo[7]._nameSid),
				_userData = {
					_subType = 7,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 19,
				_isSub = true,
				_str = Str(Data._characterInfo[9]._nameSid),
				_userData = {
					_subType = 9,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 20,
				_isSub = true,
				_str = Str(Data._characterInfo[10]._nameSid),
				_userData = {
					_subType = 10,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 23,
				_isSub = true,
				_str = Str(Data._characterInfo[13]._nameSid),
				_userData = {
					_subType = 13,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 14,
				_isSub = true,
				_str = Str(Data._characterInfo[4]._nameSid),
				_userData = {
					_subType = 4,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 22,
				_isSub = true,
				_str = Str(Data._characterInfo[12]._nameSid),
				_userData = {
					_subType = 12,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 15,
				_isSub = true,
				_str = string.sub(Str(Data._characterInfo[5]._nameSid), 1, 9),
				_userData = {
					_subType = 5,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 12,
				_isSub = true,
				_str = Str(Data._characterInfo[2]._nameSid),
				_userData = {
					_subType = 2,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			},
			{
				_subIndex = 13,
				_isSub = true,
				_str = Str(Data._characterInfo[3]._nameSid),
				_userData = {
					_subType = 3,
					_type = SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL
				}
			}
		}
		local var_7_4 = {
			{
				_subIndex = 22,
				_isSub = true,
				_str = Str(STR.TROPHY_RANK_ZONE),
				_userData = {
					_subType = 0,
					_type = SglMsgType_pb.PB_TYPE_RANK_LADDER
				}
			},
			{
				_subIndex = 21,
				_isSub = true,
				_str = Str(STR.TROPHY_RANK_REGION),
				_userData = {
					_type = SglMsgType_pb.PB_TYPE_RANK_TROPHY
				}
			}
		}

		if ClientData.isAppStoreReviewing() then
			var_7_2 = {
				{
					_str = Str(STR.FIND_CLASH_TITLE),
					_tabs = var_7_4
				},
				{
					_str = Str(STR.UNION_RANK),
					_userData = {
						_type = SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY
					}
				}
			}
			arg_7_0._unionIndex = 2
		else
			var_7_2 = {
				{
					_str = Str(STR.FIND_CLASH_TITLE),
					_tabs = var_7_4
				},
				{
					_str = Str(STR.FIND_ARENA_TITLE),
					_userData = {
						_type = SglMsgType_pb.PB_TYPE_RANK_LADDER_EX
					}
				},
				{
					_str = Str(STR.CHARACTER_LEVEL),
					_tabs = var_7_3
				},
				{
					_str = Str(STR.UNION_RANK),
					_userData = {
						_type = SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY
					}
				},
				{
					_str = Str(STR.FIND_CLASH_EX_TITLE),
					_userData = {
						_type = SglMsgType_pb.PB_TYPE_RANK_LEGEND
					}
				}
			}
			arg_7_0._unionIndex = 4

			if ClientData.getValidActivityByType(Data.ActivityType.season_rank) then
				table.insert(var_7_2, 1, {
					_str = Str(STR.SEASON_RANK),
					_userData = {
						_type = 1725
					}
				})

				arg_7_0._unionIndex = arg_7_0._unionIndex + 1
			end

			if ClientData.getValidActivityByType(Data.ActivityType.trophy_activity) then
				table.insert(var_7_2, 1, {
					_str = Str(STR.TROPHY_ACTIVITY_RANK),
					_userData = {
						_type = SglMsgType_pb.PB_TYPE_RANK_TROPHY_ACTIVITY
					}
				})

				arg_7_0._unionIndex = arg_7_0._unionIndex + 1
			end

			if ClientData.getValidActivityByType(Data.ActivityType.rank1) then
				table.insert(var_7_2, 1, {
					_str = Str(STR.ACTIVITY_RANK_1),
					_userData = {
						_type = SglMsgType_pb.PB_TYPE_RANK_TROPHY_YEAR_ACTIVITY
					}
				})

				arg_7_0._unionIndex = arg_7_0._unionIndex + 1
			end
		end
	elseif var_7_0 == Data.RankRange.union then
		var_7_2 = {
			{
				_str = Str(STR.UNION) .. Str(STR.LEVEL),
				_userData = {
					_type = SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL
				}
			}
		}
	elseif var_7_0 == Data.RankRange.dark then
		var_7_2 = {
			{
				_str = Str(STR.DARK_BATTLE),
				_userData = {
					_type = SglMsgType_pb.PB_TYPE_RANK_DARK
				}
			}
		}
	else
		local var_7_5 = arg_7_0._isPre and SglMsgType_pb.PB_TYPE_RANK_PRE or SglMsgType_pb.PB_TYPE_RANK_LADDER
		local var_7_6 = {}
		local var_7_7 = Data._globalInfo._ladderStage

		for iter_7_0 = 1, #var_7_7 - 1 do
			local var_7_8 = string.format("%d%s-%d%s", var_7_7[iter_7_0], Str(STR.LEVEL_S), var_7_7[iter_7_0 + 1] - 1, Str(STR.LEVEL_S))

			table.insert(var_7_6, {
				_isSub = true,
				_str = var_7_8,
				_subIndex = var_0_11 + iter_7_0,
				_userData = {
					_type = var_7_5,
					_subType = iter_7_0
				}
			})
		end

		table.insert(var_7_6, {
			_isSub = true,
			_str = string.format(Str(STR.LEVEL_ABOVE), lc.arrayAt(var_7_7, -1)),
			_subIndex = var_0_11 + #var_7_7,
			_userData = {
				_type = var_7_5,
				_subType = #var_7_7
			}
		})
		table.insert(var_7_6, {
			_isSub = true,
			_str = Str(STR.TOTAL_RANK),
			_subIndex = var_0_11,
			_userData = {
				_subType = 0,
				_type = var_7_5
			}
		})

		var_7_2 = {
			{
				_str = Str(STR.FIND_CLASH_TITLE),
				_tabs = var_7_6
			}
		}
	end

	arg_7_0._tabs = var_7_2

	if not arg_7_1 then
		arg_7_0._leftArea:resetTabs(var_7_2)
	end
end

function var_0_0.onEnter(arg_8_0)
	var_0_0.super.onEnter(arg_8_0)

	local var_8_0 = {}

	table.insert(var_8_0, lc.addEventListener(Data.Event.rank_list_dirty, function(arg_9_0)
		if arg_9_0._type == arg_8_0._list._rankType then
			arg_8_0:refreshItemList()
		end
	end))
	table.insert(var_8_0, lc.addEventListener(Data.Event.union_enter_dirty, function(arg_10_0)
		if arg_8_0._list._rankType == SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL then
			arg_8_0:refreshCurrentTab()
		end
	end))
	table.insert(var_8_0, lc.addEventListener(Data.Event.union_exit_dirty, function(arg_11_0)
		if arg_8_0._list._rankType == SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL then
			arg_8_0:refreshCurrentTab()
		end
	end))

	arg_8_0._listeners = var_8_0
end

function var_0_0.onExit(arg_12_0)
	var_0_0.super.onExit(arg_12_0)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_12_1)
	end
end

function var_0_0.onShowActionFinished(arg_13_0)
	arg_13_0._isShown = true

	arg_13_0._leftArea:showTab(arg_13_0._initTabIndex)

	if arg_13_0._initSubTab then
		arg_13_0._leftArea:showTab(arg_13_0._initSubTab)
	end
end

function var_0_0.showSubTab(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._list

	var_14_0:bindData()
	arg_14_0._selfArea:setVisible(false)
	arg_14_0:refreshSelfArea()

	local var_14_1 = arg_14_1._userData._type

	var_14_0._rankType, var_14_0._rankSubType = var_14_1, arg_14_1._userData._subType

	local function var_14_2(arg_15_0)
		local var_15_0 = arg_14_0._selfArea

		var_15_0:removeChildrenByTag(var_0_10)
		var_15_0:setVisible(true)
		arg_14_0:addSelfRankAreas()
		var_15_0._rank:setString("?")

		local var_15_1 = ClientView.createBoldRichTextMultiLine(arg_15_0, ClientView.RICHTEXT_PARAM_LIGHT_S1, 600)
		local var_15_2 = lc.createNode(var_15_1:getContentSize())

		lc.addChildToCenter(var_15_2, var_15_1)
		var_14_0:checkEmpty(var_15_2)
		var_14_0:refreshView()
		var_14_0:jumpToTop()
	end

	if var_14_1 == SglMsgType_pb.PB_TYPE_RANK_TROPHY then
		if P._playerWorld._curLevel[1] <= 10104 then
			var_14_2(string.format(Str(STR.UNLOCK_RANK_CLASH_TROPHY_TIP, true), Str(Data._chapterInfo[1]._nameSid)))

			return
		end
	elseif var_14_1 == SglMsgType_pb.PB_TYPE_RANK_LADDER then
		if P._playerWorld._curLevel[1] <= 10104 then
			var_14_2(string.format(Str(STR.UNLOCK_RANK_TROPHY_TIP1), Str(Data._chapterInfo[1]._nameSid), var_0_12))

			return
		end

		if P:getMaxCharacterLevel() < var_0_12 then
			var_14_2(string.format(Str(STR.UNLOCK_RANK_TROPHY_TIP2), var_0_12))

			return
		end
	elseif var_14_1 == SglMsgType_pb.PB_TYPE_RANK_LADDER_EX and P:getMaxCharacterLevel() < Data._globalInfo._unlockLadder then
		var_14_2(string.format(Str(STR.UNLOCK_RANK_LADDER_EX_TIP, true), Data._globalInfo._unlockLadder))

		return
	end

	if arg_14_0._indicator then
		arg_14_0._indicator:removeFromParent()

		arg_14_0._indicator = nil
	end

	if P._playerRank:sendRankRequest(var_14_1, var_14_0._rankSubType) then
		arg_14_0._indicator = ClientView.showPanelActiveIndicator(arg_14_0._form, lc.bound(arg_14_0._list))

		lc.offset(arg_14_0._indicator, 0, 20)
	end
end

function var_0_0.refreshCurrentTab(arg_16_0)
	local var_16_0 = arg_16_0._leftArea._focusedTab._index

	arg_16_0:refreshRank()

	if var_16_0 then
		arg_16_0._leftArea:showTab(var_16_0)
	end
end

function var_0_0.refreshSelfArea(arg_17_0)
	local var_17_0 = arg_17_0._selfArea
	local var_17_1 = var_17_0._avatar

	if var_17_1 then
		var_17_1:removeFromParent()
	end

	if arg_17_0._leftArea._focusedTab._index ~= arg_17_0._unionIndex then
		var_17_1 = UserWidget.create(P, UserWidget.Flag.NAME_UNION)
	elseif P:hasUnion() then
		var_17_1 = require("UnionWidget").create(P._playerUnion:getMyUnion(), false)
	else
		var_17_1 = ClientView.createTTF(Str(STR.NOT_JOIN_ANY_UNION), ClientView.FontSize.S1, ClientView.COLOR_TEXT_ORANGE)
	end

	lc.addChildToPos(var_17_0, var_17_1, cc.p(172 + lc.w(var_17_1) / 2 - 6, lc.h(var_17_0) / 2 + (arg_17_0._leftArea._focusedTab._index ~= arg_17_0._unionIndex and 4 or -4)))

	var_17_0._avatar = var_17_1
end

function var_0_0.refreshItemList(arg_18_0)
	if arg_18_0._indicator then
		arg_18_0._indicator:removeFromParent()

		arg_18_0._indicator = nil
	end

	arg_18_0:refreshSelfArea()

	local var_18_0 = arg_18_0._list
	local var_18_1 = P._playerRank:getRanks(var_18_0._rankType, var_18_0._rankSubType)

	if var_18_1 == nil then
		return
	end

	local var_18_2 = arg_18_0._selfArea

	var_18_2:removeChildrenByTag(var_0_10)
	var_18_2:setVisible(true)
	arg_18_0:addSelfRankAreas()
	var_18_0:bindData(var_18_1, function(arg_19_0, arg_19_1)
		arg_18_0:setOrCreateItem(arg_19_0, arg_19_1, var_18_0._rankType)
	end, math.min(10, var_18_1._count or 0))

	for iter_18_0 = 1, var_18_0._cacheCount do
		local var_18_3 = var_18_1[iter_18_0]
		local var_18_4 = arg_18_0:setOrCreateItem(nil, var_18_3, var_18_0._rankType)

		var_18_0:pushBackCustomItem(var_18_4)
	end

	if var_18_0._rankType == SglMsgType_pb.PB_TYPE_RANK_UNION_LEVEL then
		var_18_0:checkEmpty(Str(STR.LIST_EMPTY_UNION))
	elseif var_18_0._rankType == SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE then
		var_18_0:checkEmpty(Str(STR.LIST_EMPTY_BOSS))
	elseif var_18_0._rankType == SglMsgType_pb.PB_TYPE_RANK_UBOSS_TIME then
		var_18_0:checkEmpty(Str(STR.LIST_EMPTY_BOSS_UNION))
	elseif var_18_0._rankType == SglMsgType_pb.PB_TYPE_RANK_LADDER or var_18_0._rankType == SglMsgType_pb.PB_TYPE_RANK_LADDER_EX or var_18_0._rankType == SglMsgType_pb.PB_TYPE_RANK_PRE or var_18_0._rankType == SglMsgType_pb.PB_TYPE_RANK_TROPHY then
		var_18_0:checkEmpty(Str(STR.LIST_EMPTY_RANK))
	elseif var_18_0._rankType == SglMsgType_pb.PB_TYPE_RANK_DARK then
		var_18_0:checkEmpty(Str(STR.LIST_EMPTY_RANK))
	else
		var_18_0:checkEmpty(Str(STR.LIST_EMPTY_RANK))
	end

	var_18_0:refreshView()
	var_18_0:jumpToTop()
end

function var_0_0.setOrCreateItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0._range

	if arg_20_1 == nil then
		arg_20_1 = lc.createImageView({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35
		})

		arg_20_1:setContentSize(lc.w(arg_20_0._list), var_20_0 == Data.RankRange.lord and var_20_0 == Data.RankRange.region and 108 or 108)
		arg_20_1:setTouchEnabled(true)
		arg_20_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

		local var_20_1 = lc.createSprite("img_bg_deco_35")

		lc.addChildToPos(arg_20_1, var_20_1, cc.p(lc.w(var_20_1) / 2, lc.h(arg_20_1) / 2 + 3))

		arg_20_1._bar = var_20_1

		local var_20_2

		if arg_20_0._leftArea._focusedTab._index ~= arg_20_0._unionIndex then
			arg_20_1:addTouchEventListener(function(arg_21_0, arg_21_1)
				if arg_21_1 == ccui.TouchEventType.ended and arg_20_1._rank then
					local targetUser = arg_20_1._rank._user
					local targetId = targetUser and targetUser._id
					if targetId then
						require("VisitForm").create(targetId):show()
					end
				end
			end)

			local var_20_3 = UserWidget.create(arg_20_2._user, UserWidget.Flag.NAME_UNION)

			var_20_3:setScale(0.8)
			lc.addChildToPos(arg_20_1, var_20_3, cc.p(200 + lc.w(var_20_3) / 2 + 10, lc.h(arg_20_1) / 2 + 4))

			arg_20_1._avatarArea = var_20_3

			if arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_POWER then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, "img_icon_power", arg_20_2._value)
			elseif arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_STAR then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, "world_city_star_focus3", arg_20_2._value)
			elseif arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_TROPHY then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, "img_icon_res6_s", arg_20_2._value)
			elseif arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_BOSS or arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, "img_icon_score", arg_20_2._value, 160)
			elseif arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_LADDER or arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_PRE then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, "img_icon_res6_s", arg_20_2._value)
			elseif arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_LADDER_EX then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, "img_icon_res5_s", arg_20_2._value)
			elseif arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_DARK then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, "img_icon_res16_s", arg_20_2._value)
			elseif arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_LEGEND then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, "img_icon_res23_s", arg_20_2._value)
			elseif arg_20_3 == 1725 then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, ClientData.getIconName(Data.ResType.new_server_score), arg_20_2._value)
			elseif arg_20_3 == 1727 then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, ClientData.getIconName(Data.ResType.trophy_activity), arg_20_2._value)
			elseif arg_20_3 == 1728 then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, ClientData.getIconName(Data.ResType.rank1), arg_20_2._value)
			elseif arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL then
				var_20_3._nameArea._level:setVisible(true)
			end
		else
			arg_20_1:addTouchEventListener(function(arg_22_0, arg_22_1)
				if arg_22_1 == ccui.TouchEventType.ended then
					local var_22_0 = arg_20_1._rank._union

					if P:hasUnion() then
						if var_22_0._id ~= P._unionId then
							require("UnionDetailForm").create(var_22_0._id):show()
						end
					else
						ClientView.operateUnion(var_22_0, arg_20_1)
					end
				end
			end)

			local var_20_4 = require("UnionWidget").create(nil, true)

			var_20_4:setScale(0.75)
			lc.addChildToPos(arg_20_1, var_20_4, cc.p(180 + lc.w(var_20_4) / 2, lc.h(arg_20_1) / 2))

			arg_20_1._avatarArea = var_20_4

			if arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_TIME then
				var_20_2 = arg_20_0:addUBossKillValueArea(arg_20_1)
			elseif arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY then
				var_20_2 = arg_20_0:addValueArea(arg_20_1, "img_icon_res6_s", arg_20_2._value)
			end
		end

		if var_20_2 then
			var_20_2:setPosition(lc.w(arg_20_1) - 30 - lc.w(var_20_2) / 2, lc.y(arg_20_1._avatarArea))

			arg_20_1._valueArea = var_20_2

			if arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_LADDER or arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_LADDER_EX or arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_PRE then
				lc.offset(var_20_2, 0, -20)

				local var_20_5 = ClientView.createTTF("0", ClientView.FontSize.S2, ClientView.COLOR_LABEL_DARK)

				lc.addChildToPos(arg_20_1, var_20_5, cc.p(lc.x(var_20_2), lc.top(var_20_2) + 4 + lc.h(var_20_5) / 2))

				var_20_2._region = var_20_5
			end
		end
	end

	arg_20_1:removeChildrenByTag(var_0_10)

	arg_20_1._rank = arg_20_2
	arg_20_1._rankType = arg_20_3

	local var_20_6 = arg_20_2._rank

	if var_20_6 <= 3 then
		local var_20_7 = lc.createSprite(string.format("img_medal_%d", var_20_6))

		var_20_7:setPosition(lc.w(var_20_7) / 2 + 36, lc.h(arg_20_1) / 2 + 5)
		arg_20_1:addChild(var_20_7, 0, var_0_10)
		arg_20_1._bar:setColor(var_20_6 == 1 and cc.c3b(250, 64, 0) or var_20_6 == 2 and cc.c3b(0, 144, 250) or cc.c3b(166, 128, 136))
	else
		local var_20_8 = ClientView.createBMFont(ClientView.BMFont.num_48, string.format("%d", var_20_6))

		var_20_8:setPosition(70, lc.h(arg_20_1) / 2 + 2)
		arg_20_1:addChild(var_20_8, 0, var_0_10)
		arg_20_1._bar:setColor(lc.Color3B.white)
	end

	if arg_20_0._leftArea._focusedTab._index ~= arg_20_0._unionIndex then
		local var_20_9 = arg_20_0._list._data._rankId

		if arg_20_2._id == var_20_9 then
			arg_20_1:setColor(ClientView.COLOR_TEXT_GREEN)
		else
			arg_20_1:setColor(lc.Color3B.white)
		end

		arg_20_1._avatarArea:setUser(arg_20_2._user, true)
		arg_20_1._avatarArea._nameArea._level:setString(arg_20_2._value)
	else
		if arg_20_2._id == P._unionId then
			arg_20_1:setColor(ClientView.COLOR_TEXT_GREEN)
		else
			arg_20_1:setColor(lc.Color3B.white)
		end

		arg_20_1._avatarArea:setUnion(arg_20_2._union)
	end

	local var_20_10 = arg_20_1._valueArea

	if var_20_10 then
		if arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_UBOSS_TIME then
			var_20_10:updateTime(arg_20_2._value)
		elseif arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY then
			var_20_10._label:setString(string.format("%d", arg_20_2._value))
		else
			if arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_LADDER or arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_LADDER_EX or arg_20_3 == SglMsgType_pb.PB_TYPE_RANK_PRE then
				var_20_10._region:setString(ClientData.genChannelRegionName(arg_20_2._user._regionId))
			end

			var_20_10._label:setString(string.format("%d", arg_20_2._value))
		end
	end

	return arg_20_1
end

function var_0_0.addValueArea(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = ClientView.createIconLabelArea(arg_23_2, tostring(arg_23_3), arg_23_4 or 140)

	var_23_0:setAnchorPoint(0.5, 0.5)
	arg_23_1:addChild(var_23_0)

	return var_23_0
end

function var_0_0.addUBossKillValueArea(arg_24_0, arg_24_1)
	local var_24_0 = lc.createNode(cc.size(140, 80))

	arg_24_1:addChild(var_24_0)

	local var_24_1 = ClientView.createTTF(Str(STR.KILL_DURATION), ClientView.FontSize.S2, ClientView.COLOR_LABEL_DARK)

	var_24_1:setAnchorPoint(1, 0.5)
	lc.addChildToPos(var_24_0, var_24_1, cc.p(lc.w(var_24_0) - 2, lc.h(var_24_0) - 10 - lc.h(var_24_1) / 2))

	local var_24_2 = ClientView.createTTF("0", ClientView.FontSize.S1, ClientView.COLOR_TEXT_RED_DARK)

	var_24_2:setAnchorPoint(1, 0.5)
	lc.addChildToPos(var_24_0, var_24_2, cc.p(lc.x(var_24_1), 10 + lc.h(var_24_2) / 2))

	function var_24_0.updateTime(arg_25_0, arg_25_1)
		if arg_25_1 > 0 then
			arg_25_1 = arg_25_1 / 1000

			local var_25_0, var_25_1 = math.floor(arg_25_1 / Data.DAY_SECONDS)

			arg_25_1 = arg_25_1 % Data.DAY_SECONDS

			local var_25_2 = math.floor(arg_25_1 / 3600)
			local var_25_3 = math.floor(arg_25_1 % 3600 / 60)
			local var_25_4 = math.floor(arg_25_1 % 3600 % 60)

			if var_25_0 > 0 then
				var_25_1 = string.format("%d%s %02d:%02d:%02d", var_25_0, Str(STR.DAY), var_25_2, var_25_3, var_25_4)
			else
				var_25_1 = string.format("%02d:%02d:%02d", var_25_2, var_25_3, var_25_4)
			end

			var_24_2:setString(var_25_1)
		else
			var_24_2:setString(Str(STR.VOID))
		end
	end

	return var_24_0
end

function var_0_0.addSelfRankAreas(arg_26_0)
	local var_26_0 = arg_26_0._selfArea
	local var_26_1 = arg_26_0._list
	local var_26_2 = P._playerRank:getRanks(var_26_1._rankType, var_26_1._rankSubType)
	local var_26_3 = var_26_2 and var_26_2._selfRank

	local var_fallback_val = (P and P._playerFindClash and P._playerFindClash._trophy) or (P and P._trophy) or 800
	if var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL then
		var_fallback_val = (P and P:getMaxCharacterLevel()) or (P and P._level) or 1
	end
	local selfVal = (var_26_3 and var_26_3._value) or var_fallback_val

	var_26_0._rank:setString(var_26_3 and tostring(var_26_3._rank) or "?")

	local function var_26_4(arg_27_0, arg_27_1)
		if var_26_0._avatar and var_26_0._avatar._nameArea then
			local var_27_0 = lc.convertPos(cc.p(0, lc.h(var_26_0._avatar._nameArea) / 2), var_26_0._avatar._nameArea, var_26_0)
			local var_27_1 = arg_26_0:addValueArea(var_26_0, arg_27_0, selfVal, arg_27_1)

			var_27_1:setTag(var_0_10)
			var_27_1:setPosition(lc.w(var_26_0) - 24 - lc.w(var_27_1) / 2, var_27_0.y)
		end
	end

	local function var_26_5(arg_28_0, arg_28_1, arg_28_2)
		local var_28_0 = arg_26_0:addValueArea(var_26_0, arg_28_0, selfVal, arg_28_2)

		var_28_0:setTag(var_0_10)
		var_28_0:setPosition(lc.w(var_26_0) - 24 - lc.w(var_28_0) / 2, lc.h(var_26_0) - 24 - lc.h(var_28_0) / 2)

		local var_28_1 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
			if var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_LADDER or var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_LADDER_EX or var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_PRE then
				require("RankBonusForm").createClash(var_26_1._rankType, 0):show()
			else
				require("RankBonusForm").create(arg_28_1, var_26_1._rankType):show()
			end
		end, ClientView.CRECT_BUTTON_S, lc.w(var_28_0) + 6)

		var_28_1:addLabel(Str(STR.BONUS_RULE))
		lc.addChildToPos(var_26_0, var_28_1, cc.p(lc.x(var_28_0), 12 + lc.h(var_28_1) / 2), 0, var_0_10)
	end

	if var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_POWER then
		var_26_4("img_icon_power")
	elseif var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_STAR then
		var_26_4("world_city_star_focus3")
	elseif var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_TROPHY then
		local var_26_6

		if P:getMaxCharacterLevel() >= var_0_12 and var_26_3 then
			var_26_6 = var_26_3._rank
		end

		var_26_5("img_icon_res6_s", var_26_6)
	elseif var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_LADDER or var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_PRE then
		var_26_5("img_icon_res6_s", rank)
	elseif var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_LADDER_EX then
		var_26_5("img_icon_res5_s", rank)
	elseif var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_DARK then
		var_26_5("img_icon_res16_s", rank)
	elseif var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_LEGEND then
		var_26_5("img_icon_res23_s", rank)
	elseif var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_BOSS or var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE then
		var_26_4("img_icon_score", 160)
	elseif var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_UBOSS_TIME then
		local var_26_7 = arg_26_0:addUBossKillValueArea(var_26_0)

		var_26_7:setTag(var_0_10)
		var_26_7:setPosition(lc.w(var_26_0) - 34 - lc.w(var_26_7) / 2, lc.h(var_26_0) / 2)
		var_26_7:updateTime(var_26_3 and var_26_3._value or 0)
	elseif var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_CHAR_LEVEL then
		var_26_0._avatar._nameArea._level:setVisible(true)
		var_26_0._avatar._nameArea._level:setString(selfVal)
	elseif var_26_1._rankType == SglMsgType_pb.PB_TYPE_RANK_UNION_TROPHY then
		var_26_5("img_icon_res6_s", 160)
	elseif var_26_1._rankType == 1725 then
		var_26_4(ClientData.getIconName(Data.ResType.new_server_score), 160)
	elseif var_26_1._rankType == 1727 then
		var_26_4(ClientData.getIconName(Data.ResType.trophy_activity), 160)
	elseif var_26_1._rankType == 1728 then
		var_26_4(ClientData.getIconName(Data.ResType.rank1), 160)
	end
end

return var_0_0
