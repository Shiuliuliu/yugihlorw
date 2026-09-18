local var_0_0 = class("FindClashArea", lc.ExtendCCNode)
local var_0_1 = require("PromptForm")

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_NODE)

	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:setContentSize(arg_1_0, arg_1_1)
	var_1_0:init()
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "exit" then
			var_1_0:onExit()
		end
	end)

	return var_1_0
end

function var_0_0.init(arg_3_0)
	if P._playerFindClash._isSyncData then
		arg_3_0:initAreas()
	else
		arg_3_0._indicator = ClientView.showPanelActiveIndicator(arg_3_0)

		ClientData.sendClashSync()
		if P._playerFindClash._isSyncData then
			if arg_3_0._indicator then
				arg_3_0._indicator:removeFromParent()
				arg_3_0._indicator = nil
			end
			arg_3_0:initAreas()
		end
	end
end

function var_0_0.initAreas(arg_4_0)
	arg_4_0:initTopArea()
	arg_4_0:initFieldArea()
	arg_4_0:initChests()
	arg_4_0:initBottomArea()

	if ClientData._isAutoBattle then
		arg_4_0:find(true)
	end
end

function var_0_0.initTopArea(arg_5_0)
	local var_5_0 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(arg_5_0, var_5_0, cc.p(lc.w(arg_5_0) / 2, lc.h(arg_5_0) - lc.h(var_5_0) / 2))

	local var_5_1 = ClientView.createTTF(Str(STR.FIND_CLASH_LAST_CHAMPION), ClientView.FontSize.S1)

	lc.addChildToPos(var_5_0, var_5_1, cc.p(lc.w(var_5_0) / 2, lc.h(var_5_0) / 2 + 5))

	local function var_5_2(arg_6_0)
		local var_6_0 = ccui.Widget:create()

		var_6_0:setContentSize(250, 236)

		local var_6_1 = lc.w(var_6_0) / 2
				local var_6_3 = nil
		local topList = ClientData._cachedLeaderboard
		if not topList or #topList == 0 then
			topList = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_PRE, 0)
		end
		if not topList or #topList == 0 then
			topList = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_LADDER, 0)
		end
		if topList and topList[arg_6_0] then
			local entry = topList[arg_6_0]
			local u = entry._user or entry.user_info or entry
			var_6_3 = {
				_id = u._id or u.id or (1000 + arg_6_0),
				_name = u._name or u.name or "Duelist",
				_avatar = u._avatar or u.avatar or 101,
				_trophy = u._trophy or u.trophy or u.value or 800,
				_vip = u._vip or u.vip or 0
			}
		end
		if not var_6_3 then
			local defaults = {
				{ name = "Seto_Kaiba", avatar = 201, trophy = 3200, vip = 10 },
				{ name = "Yami_Yugi", avatar = 101, trophy = 2950, vip = 8 },
				{ name = "Joey_Wheeler", avatar = 202, trophy = 2700, vip = 6 }
			}
			local def = defaults[arg_6_0] or defaults[1]
			var_6_3 = {
				_id = 1000 + arg_6_0,
				_name = def.name,
				_avatar = def.avatar,
				_trophy = def.trophy,
				_vip = def.vip
			}
		end

		if var_6_3 then
			var_6_0:setTouchEnabled(true)
			var_6_0:addTouchEventListener(function(arg_7_0, arg_7_1)
				if arg_7_1 == ccui.TouchEventType.ended then
					require("ClashUserInfoForm").create(var_6_3._id):show()
				end
			end)
		end

		local var_6_4 = cc.ShaderSprite:createWithFramename("img_stage_gold")

		lc.addChildToPos(var_6_0, var_6_4, cc.p(var_6_1, lc.h(var_6_4) / 2))

		local var_6_5 = cc.ShaderSprite:createWithFramename("img_stage_gold_light")

		var_6_5:setScale(2)
		lc.addChildToPos(var_6_4, var_6_5, cc.p(lc.w(var_6_4) / 2, lc.h(var_6_4) + 40))

		local var_6_6 = require("UserWidget").create()

		lc.addChildToPos(var_6_0, var_6_6, cc.p(var_6_1, lc.h(var_6_0) - lc.h(var_6_6) / 2 - 24))

		var_6_0._avatar = var_6_6

		local var_6_7 = ClientView.createIconLabelArea("img_icon_res6_s", var_6_3 and var_6_3._trophy or 0, 150)

		var_6_7._valBg:setScale(0.84)
		var_6_7._icon:setScale(0.84)
		lc.offset(var_6_7._icon, 10)
		lc.offset(var_6_7._label, -10)
		lc.addChildToPos(var_6_0, var_6_7, cc.p(var_6_1, 88))

		var_6_0._trophy = var_6_7._label

		local var_6_8 = ClientView.createTTF(var_6_3 and var_6_3._name or string.format(Str(STR.LIST_EMPTY_NO_X), Str(STR.LORD)), ClientView.FontSize.S2)

		lc.addChildToPos(var_6_0, var_6_8, cc.p(var_6_1, 24))
		ClientView.fitLabel(var_6_8, lc.w(var_6_0) - 16)

		var_6_0._name = var_6_8

		local var_6_9 = {
			_avatar = var_6_3 and var_6_3._avatar,
			_vip = var_6_3 and var_6_3._vip or 0
		}

		if arg_6_0 == 1 then
			var_6_9._avatarFrameId = 7512
		else
			var_6_4:setScaleY(0.9)
			lc.offset(var_6_6, 0, -4)
			lc.offset(var_6_7, 0, -2)
			lc.offset(var_6_8, 0, 4)

			if arg_6_0 == 2 then
				var_6_9._avatarFrameId = 7510

				var_6_4:setEffect(ClientView.SHADER_COLOR_STAGE_SILVER)
				var_6_5:setEffect(ClientView.SHADER_COLOR_STAGE_SILVER)
			elseif arg_6_0 == 3 then
				var_6_9._avatarFrameId = 7511

				var_6_4:setEffect(ClientView.SHADER_COLOR_STAGE_BRONZE)
				var_6_5:setEffect(ClientView.SHADER_COLOR_STAGE_BRONZE)
			end
		end

		var_6_6:setUser(var_6_9)

		return var_6_0
	end

	local var_5_3 = var_5_2(1)

	lc.addChildToPos(arg_5_0, var_5_3, cc.p(lc.w(arg_5_0) / 2, lc.bottom(var_5_0) + 8 - lc.h(var_5_3) / 2), 1)

	local var_5_4 = var_5_2(2)

	lc.addChildToPos(arg_5_0, var_5_4, cc.p(math.max(lc.left(var_5_3) - 30 - lc.w(var_5_4), 0) + lc.w(var_5_4) / 2, lc.y(var_5_3)))

	local var_5_5 = var_5_2(3)

	lc.addChildToPos(arg_5_0, var_5_5, cc.p(math.min(lc.right(var_5_3) + 30 + lc.w(var_5_4), lc.w(arg_5_0)) - lc.w(var_5_5) / 2, lc.y(var_5_3)))

	arg_5_0._stages = {
		var_5_3,
		var_5_4,
		var_5_5
	}

	local var_5_6 = cc.rect(ClientView.CRECT_COM_BG5.x, 0, ClientView.CRECT_COM_BG5.width, lc.frameSize("img_com_bg_5").height)

	local preRanks = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_PRE, 0)
	if preRanks and (preRanks._count or #preRanks or 0) > 0 then
		local var_5_7 = ClientView.createScale9ShaderButton("img_com_bg_5", function()
			require("RankForm").create(Data.RankRange.region, 1, 100, true):show()
		end, var_5_6, 160)

		var_5_7:addLabel(Str(STR.SEASON_LAST_RANK))
		lc.addChildToPos(arg_5_0, var_5_7, cc.p(lc.right(var_5_5) - lc.w(var_5_7) / 2, lc.y(var_5_0)))
		var_5_7:setVisible(false)
	end
end

function var_0_0.initFieldArea(arg_9_0)
	if ClientData._cfg and ClientData._cfg.testAutoBattle then
		P._monthCardDay2 = 1
	end

	local var_9_0 = P._monthCardDay2
	local var_9_1 = true
	local var_9_2 = ClientView.createClashFieldArea(P._playerFindClash._grade, function()
		arg_9_0:showFields()
	end)

	lc.addChildToPos(arg_9_0, var_9_2, cc.p(lc.w(arg_9_0) / 2, 244), 1)

	arg_9_0._fieldArea = var_9_2

	var_9_2._bones:setPositionY(lc.ch(var_9_2) + 40)
	var_9_2._bones:setScale(0.75)

	local var_9_3 = ClientView.createScale9ShaderButton("img_btn_2", function()
		arg_9_0:find()
	end, ClientView.CRECT_BUTTON, var_9_1 and 150 or 200)

	lc.addChildToPos(var_9_2, var_9_3, cc.p(lc.w(var_9_2) / 2 + (var_9_1 and 30 or 0), 96), 1)

	local var_9_4 = ClientView.createBMFont(ClientView.BMFont.huali_32, Str(STR.BATTLE))

	var_9_4:setColor(lc.Color3B.yellow)
	lc.addChildToPos(var_9_3, var_9_4, cc.p(lc.w(var_9_3) / 2, lc.h(var_9_3) / 2 + 2))
	ClientView.fitLabel(var_9_4, lc.w(var_9_3) - 20)

	local var_9_5 = lc.createSprite({
		_name = "img_com_bg_22",
		_crect = ClientView.CRECT_COM_BG22,
		_size = cc.size(220, 30)
	})

	var_9_5:setColor(lc.Color3B.black)
	var_9_5:setOpacity(150)
	lc.addChildToPos(var_9_2, var_9_5, cc.p(lc.x(var_9_3) + (var_9_1 and 40 or 0), lc.bottom(var_9_3) - lc.ch(var_9_5)))

	arg_9_0._targetBg = var_9_5

	local var_9_6 = ClientView.createTTF(Str(STR.FIND_CLASH_NEXT_TARGET), ClientView.FontSize.S3)

	lc.addChildToPos(var_9_5, var_9_6, cc.p(60, lc.ch(var_9_5)))

	local var_9_7 = lc.createSprite("img_icon_res6_s")

	var_9_7:setScale(0.7)
	lc.addChildToPos(var_9_5, var_9_7, cc.p(lc.right(var_9_6) + 16, lc.y(var_9_6)))

	if var_9_1 then
		local var_9_8 = math.max(0, 100 - P._pvpWinDaily)

		if ClientData._cfg and ClientData._cfg.testAutoBattle then
			var_9_8 = 1
		end

		local var_9_9 = ClientView.createScale9ShaderButton("img_btn_2", function()
			if P._monthCardDay2 > 0 then
				arg_9_0:find(true)
			else
				require("Dialog").showDialog(Str(STR.AUTO_BATTLE_TIP), function()
					lc.pushScene(require("ActivityScene").create(3))
				end)
			end
		end, ClientView.CRECT_BUTTON, 150)

		var_9_9:setDisabledShader(ClientView.SHADER_DISABLE)
		lc.addChildToPos(var_9_2, var_9_9, cc.p(lc.left(var_9_3) - 10 - lc.cw(var_9_9), 96), 1)

		local var_9_10 = ClientView.createTTF(Str(STR.AUTO_BATTLE), ClientView.FontSize.M2)

		var_9_10:setColor(lc.Color3B.yellow)
		lc.addChildToPos(var_9_9, var_9_10, cc.p(lc.w(var_9_9) / 2, lc.h(var_9_9) / 2 + 2))
		ClientView.fitLabel(var_9_10, lc.w(var_9_9) - 20)

		local var_9_11 = lc.createSprite({
			_name = "img_com_bg_22",
			_crect = ClientView.CRECT_COM_BG22,
			_size = cc.size(160, 30)
		})

		var_9_11:setColor(lc.Color3B.black)
		var_9_11:setOpacity(150)
		lc.addChildToPos(var_9_2, var_9_11, cc.p(lc.x(var_9_9), lc.bottom(var_9_9) - lc.ch(var_9_11)))

		arg_9_0._remainBg = var_9_11

		local var_9_12 = string.format(Str(STR.REMAIN_BUY_TIMES), var_9_8)

		if var_9_0 <= 0 then
			var_9_12 = Str(STR.UNLOCK_AUTO_BATTLE)
		end

		local var_9_13 = ClientView.createTTF(var_9_12, ClientView.FontSize.S3)

		lc.addChildToPos(var_9_11, var_9_13, cc.p(lc.cw(var_9_11), lc.ch(var_9_11)))
		var_9_9:setEnabled(var_9_8 > 0)

		if var_9_0 <= 0 or var_9_8 <= 0 then
			ClientData._isAutoBattle = false
			ClientData._autoReloadCount = 0
		end
	end

	arg_9_0:updateClashTarget()

	local var_9_14 = lc.createSprite({
		_name = "img_com_bg_55",
		_crect = ClientView.CRECT_COM_BG55,
		_size = cc.size(200, ClientView.CRECT_COM_BG55.height)
	})

	if ClientData.isIPhoneX() then
		lc.addChildToPos(var_9_2, var_9_14, cc.p(lc.w(var_9_2) / 2 + 242, -42))
	else
		lc.addChildToPos(var_9_2, var_9_14, cc.p(lc.w(var_9_2) / 2, -42))
	end

	local var_9_15 = ClientView.createTTF("0", ClientView.FontSize.S3)

	lc.addChildToPos(var_9_14, var_9_15, cc.p(lc.cw(var_9_14), lc.ch(var_9_14) + 14))

	local var_9_16 = ClientView.createTTF("0", ClientView.FontSize.S3)

	lc.addChildToPos(var_9_14, var_9_16, cc.p(lc.cw(var_9_14), lc.ch(var_9_14) - 20))
	arg_9_0:scheduleUpdateWithPriorityLua(function(arg_14_0)
		local var_14_0 = P._playerFindClash._endTime - ClientData.getCurrentTime()

		if var_14_0 > 0 then
			var_9_15:setString(Str(STR.FIND_CLASH_SEASON_CD))
			var_9_16:setString(ClientData.formatPeriod(var_14_0))
		else
			var_9_15:setString(Str(STR.FIND_CLASH_SEASON_REVIEWING_1))
			var_9_16:setString(Str(STR.FIND_CLASH_SEASON_REVIEWING_2))
		end
	end, 0)

	local var_9_17 = lc.createSprite("img_win_daily_count_bg")

	lc.addChildToPos(var_9_2, var_9_17, cc.p(lc.w(var_9_2) - 10 - lc.w(var_9_17) / 2, lc.h(var_9_2) - lc.h(var_9_17) / 2 - 10))

	local var_9_18 = ClientView.createBMFont(ClientView.BMFont.huali_32, P._ladderContLose == 1 and 0 or P._dailyClashWin)

	var_9_18:setColor(lc.Color3B.yellow)
	lc.addChildToPos(var_9_17, var_9_18, cc.p(lc.w(var_9_17) / 2 + 15, 30))

	arg_9_0._dailyWin = var_9_18

	local var_9_19 = lc.createSprite("img_win_all_count_bg")

	lc.addChildToPos(var_9_2, var_9_19, cc.p(10 + lc.w(var_9_19) / 2, lc.h(var_9_2) - lc.h(var_9_19) / 2 - 10))

	local var_9_20 = ClientView.createBMFont(ClientView.BMFont.huali_32, P._ladderContLose == 1 and 0 or P._ladderContWin)

	var_9_20:setColor(lc.Color3B.yellow)
	lc.addChildToPos(var_9_19, var_9_20, cc.p(lc.w(var_9_19) / 2 - 15, 30))

	arg_9_0._allWin = var_9_20

	local var_9_21 = IconWidget.create({
		_infoId = Data.PropsId.double_exp,
		_count = P:getItemCount(Data.PropsId.double_exp)
	}, IconWidget.DisplayFlag.ITEM_NO_NAME)

	var_9_21:setScale(0.8)
	var_9_21:setGray(P:getItemCount(Data.PropsId.double_exp) <= 0)
	lc.addChildToPos(var_9_2, var_9_21, cc.p(lc.right(var_9_3) + 5 + lc.cw(var_9_21), lc.y(var_9_3)))

	if P._ladderContWin > 0 and P._ladderContLose == 1 then
		arg_9_0:initResetArea()
	end
end

function var_0_0.initResetArea(arg_15_0)
	local var_15_0 = cc.size(388, 96)
	local var_15_1 = Data.PropsId.dimension_bottle
	local var_15_2 = Str(Data._propsInfo[var_15_1]._nameSid)
	local var_15_3 = ClientView.createShaderButton(nil, function(arg_16_0)
		if P._propBag._props[var_15_1]._num == 0 then
			ToastManager.push(string.format(Str(STR.NOT_ENOUGH), var_15_2))
			require("ExchangeResForm").create(var_15_1):show()

			return
		end

		require("Dialog").showDialog(string.format(Str(STR.LADDER_RESET_LOSE_CONFIRM, true), var_15_2, P._propBag._props[var_15_1]._num, P._ladderContWin), function()
			ClientData.sendClashResetLadderLose()

			P._ladderContLose = 0

			P._propBag:changeProps(var_15_1, -1)
			arg_15_0._dailyWin:setString(P._dailyClashWin)
			arg_15_0._allWin:setString(P._ladderContWin)
			ToastManager.push(Str(STR.LADDER_RESET_LOSE_DONE))
			arg_15_0._resetLadderLoseArea:setVisible(false)
		end)
	end)

	var_15_3:setContentSize(var_15_0)
	lc.addChildToPos(arg_15_0, var_15_3, cc.p(lc.w(arg_15_0) / 2, 272), 1)

	local var_15_4 = ClientView.createFramedShadowColorBg(var_15_0, color or cc.c3b(40, 50, 60))

	lc.addChildToCenter(var_15_3, var_15_4)

	local var_15_5 = IconWidget.create({
		_infoId = var_15_1
	}, 0)

	var_15_5:setScale(0.7)
	lc.addChildToPos(var_15_4, var_15_5, cc.p(lc.cw(var_15_5) - 4, lc.ch(var_15_4)))

	local var_15_6 = lc.createSprite("img_light_3")

	var_15_6:setColor(cc.c3b(0, 255, 12))
	var_15_6:setScale(1.5)
	lc.addChildToCenter(var_15_5, var_15_6, -2)

	local var_15_7 = lc.createSprite("img_light_2")

	var_15_7:setColor(cc.c3b(0, 255, 12))
	var_15_7:setScale(3)
	var_15_7:runAction(lc.rep(lc.rotateBy(4, 360)))
	lc.addChildToCenter(var_15_5, var_15_7, -1)

	local var_15_8 = ClientView.createBoldRichTextWithIcons(string.format(Str(STR.LADDER_RESET_LOSE_TIP1), P._ladderContWin), {
		_width = 600,
		_fontSize = ClientView.FontSize.S3,
		_boldClr = ClientView.COLOR_TEXT_GREEN
	})

	lc.addChildToPos(var_15_4, var_15_8, cc.p(lc.cw(var_15_3) + 40, lc.ch(var_15_4) + 18))

	local var_15_9 = ClientView.createBoldRichTextWithIcons(string.format(Str(STR.LADDER_RESET_LOSE_TIP2), var_15_2), {
		_width = 600,
		_fontSize = ClientView.FontSize.S3,
		_boldClr = ClientView.COLOR_TEXT_GREEN
	})

	lc.addChildToPos(var_15_4, var_15_9, cc.p(lc.cw(var_15_3) + 40, lc.ch(var_15_4) - 18))

	arg_15_0._resetLadderLoseArea = var_15_3
end

function var_0_0.initChests(arg_18_0)
	local var_18_0 = arg_18_0._fieldArea

	if not var_18_0 then
		return
	end

	if arg_18_0._chests then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._chests) do
			iter_18_1:removeFromParent()
		end
	end

	local function var_18_1(arg_19_0)
		return P._playerFindClash:getChestGrade(arg_19_0), arg_19_0, Data.CardQuality.UR
	end

	local var_18_2 = #P._playerFindClash._chests
	local var_18_3 = P._playerFindClash._chests[var_18_2]

	for iter_18_2, iter_18_3 in ipairs(P._playerFindClash._chests) do
		if not iter_18_3._prop._isOpened then
			var_18_2 = iter_18_2
			var_18_3 = iter_18_3

			break
		end
	end

	local var_18_4 = lc.createSprite("img_slot")

	var_18_4:setScale(1.3)
	lc.addChildToPos(arg_18_0, var_18_4, cc.p(lc.left(var_18_0) - 8 - lc.cw(var_18_4), 200))

	local var_18_5 = {
		12,
		12,
		12,
		10,
		8
	}
	local var_18_6

	if var_18_2 == 0 or var_18_3._prop._isOpened and var_18_2 < 5 then
		var_18_2 = var_18_2 + 1
		var_18_6 = ClientView.createClashFieldChest(var_18_1(var_18_2))
	else
		var_18_6 = ClientView.createClashFieldChest(var_18_3._grade, var_18_2, Data.CardQuality.UR)
	end

	function var_18_6._callback(arg_20_0)
		require("ClashChestBonusForm").create(1):show()
	end

	lc.addChildToPos(arg_18_0, var_18_6, cc.p(lc.left(var_18_0) - 24 - lc.cw(var_18_6) + var_18_5[var_18_2], 200))

	local var_18_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.DAILY_TARGET))

	lc.addChildToPos(arg_18_0, var_18_7, cc.p(lc.x(var_18_4), lc.bottom(var_18_4) - 16))
	ClientView.fitLabel(var_18_7, 180)

	local var_18_8 = {
		14,
		14,
		14,
		14,
		18,
		18
	}
	local var_18_9 = lc.createSprite("img_slot")

	var_18_9:setScale(1.3)
	lc.addChildToPos(arg_18_0, var_18_9, cc.p(lc.right(var_18_0) + 8 + lc.cw(var_18_9), 200))

	local var_18_10 = P:getClashTargetStep()
	local var_18_11 = ClientView.createClashTargetChest(var_18_10)

	function var_18_11._callback(arg_21_0)
		require("ClashChestBonusForm").create(2):show()
	end

	lc.addChildToPos(arg_18_0, var_18_11, cc.p(lc.right(var_18_0) + 24 + lc.cw(var_18_11) - var_18_8[var_18_10], 200))

	local var_18_12 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.SEASON_TARGET))

	lc.addChildToPos(arg_18_0, var_18_12, cc.p(lc.x(var_18_9), lc.bottom(var_18_9) - 16))
	ClientView.fitLabel(var_18_12, 180)
	arg_18_0:updateClashTarget()

	arg_18_0._chests = {
		var_18_6,
		var_18_11
	}
end

function var_0_0.initBottomArea(arg_22_0)
	local var_22_0 = lc.createNode(cc.size(lc.w(arg_22_0), 80))

	lc.addChildToPos(arg_22_0, var_22_0, cc.p(lc.w(arg_22_0) / 2, lc.h(var_22_0) / 2))

	arg_22_0._bottomArea = var_22_0

	local var_22_1 = ClientView.createLineSprite("img_bottom_bg", lc.w(var_22_0))

	lc.addChildToPos(var_22_0, var_22_1, cc.p(lc.w(var_22_0) / 2, lc.h(var_22_0) / 2))

	local var_22_2 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("RankForm").create(Data.RankRange.lord):show()
	end, ClientView.CRECT_BUTTON_S, 120)

	var_22_2:addLabel(Str(STR.RANK))
	var_22_2:addIcon("img_icon_res6_s")
	lc.addChildToPos(var_22_0, var_22_2, cc.p(6 + lc.w(var_22_2) / 2, 36))

	local var_22_3 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		lc.pushScene(require("MarketScene").create(Data.MarketBuyType.dragon_flag))
	end, ClientView.CRECT_BUTTON_S, 120)

	var_22_3:addLabel(Str(STR.EXCHANGE))
	var_22_3:addIcon(ClientData.getPropIconName(7131))
	lc.addChildToPos(var_22_0, var_22_3, cc.p(lc.right(var_22_2) + 10 + lc.w(var_22_3) / 2, lc.y(var_22_2)))

	local var_22_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("ClashUserInfoForm").create(P._playerFindClash._clashId):show()
	end, ClientView.CRECT_BUTTON_S, 120)

	var_22_4:addLabel(Str(STR.RANK_HISTORY))
	var_22_4:addIcon("img_icon_rank_history")
	lc.offset(var_22_4._icon, -4, 0)
	lc.addChildToPos(var_22_0, var_22_4, cc.p(lc.right(var_22_2) + 10 + lc.w(var_22_4) / 2, lc.y(var_22_2)))
	var_22_3:setVisible(false)

	local var_22_5 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		require("LogForm").create(Battle_pb.PB_BATTLE_WORLD_LADDER):show()
	end, ClientView.CRECT_BUTTON_S, 120)

	var_22_5:addLabel(Str(STR.LOG))
	lc.addChildToPos(var_22_0, var_22_5, cc.p(lc.w(var_22_0) - 6 - lc.w(var_22_5) / 2 - ClientView.SCR_EDGE, lc.y(var_22_2)))

	local var_22_6 = ClientView.createScale9ShaderButton("img_btn_2_s", function()
		arg_22_0._ignoreSync = true

		lc.pushScene(require("HeroCenterScene").create())
	end, ClientView.CRECT_BUTTON_S, 120)

	var_22_6:addLabel("0")
	lc.addChildToPos(var_22_0, var_22_6, cc.p(lc.left(var_22_5) - 10 - lc.w(var_22_6) / 2, lc.y(var_22_2)))

	arg_22_0._btnTroop = var_22_6
end

function var_0_0.updateLogFlag(arg_28_0)
	return
end

function var_0_0.updateTroopButton(arg_29_0)
	if arg_29_0._btnTroop then
		arg_29_0._btnTroop._label:setString(string.format("%s %d", Str(STR.TROOP), P._curTroopIndex))
	end
end

function var_0_0.showFields(arg_30_0)
	require("FindClashFieldsForm").create(P._playerFindClash._grade):show()
end

function var_0_0.find(arg_31_0, arg_31_1)
	if ClientView._findMatchPanel then
		return
	end

	local var_31_0 = (ClientData.getServerDate() + P._timeOffset / 3600) % 24
	local var_31_1 = P._playerFindClash._period
	local var_31_2

	for iter_31_0 = 1, #var_31_1, 2 do
		if var_31_0 >= var_31_1[iter_31_0] and var_31_0 < var_31_1[iter_31_0 + 1] then
			var_31_2 = true

			break
		end
	end

	if not var_31_2 then
		local var_31_3 = string.format(Str(STR.START_END_TIME), Str(STR.FIND_CLASH_TITLE), var_31_1[1], var_31_1[2])

		for iter_31_1 = 3, #var_31_1, 2 do
			var_31_3 = var_31_3 .. string.format(Str(STR.START_END_TIME_MORE), var_31_1[iter_31_1], var_31_1[iter_31_1 + 1])
		end

		ToastManager.push(var_31_3)

		return
	end

	local var_31_4, var_31_5 = P._playerCard:checkTroop(P._curTroopIndex)

	if not var_31_4 then
		ToastManager.push(var_31_5)

		return
	end

	ClientData._isAutoBattle = arg_31_1

	require("FindMatchPanel").create(Data.FindMatchType.clash):show()
end

function var_0_0.onEnter(arg_32_0)
	arg_32_0._listeners = {}

	table.insert(arg_32_0._listeners, lc.addEventListener(Data.Event.clash_sync_ready, function(arg_33_0)
		if arg_32_0._indicator then
			arg_32_0._indicator:removeFromParent()

			arg_32_0._indicator = nil
		end

		if not arg_32_0._fieldArea then
			arg_32_0:initAreas()
		end
		arg_32_0:updateTroopButton()

		if P._playerFindClash._isFirst then
			require("FindClashFirstForm").create():show()
		end
	end))
	if P._playerFindClash._isSyncData then
		if arg_32_0._indicator then
			arg_32_0._indicator:removeFromParent()
			arg_32_0._indicator = nil
		end
		if not arg_32_0._fieldArea then
			arg_32_0:initAreas()
		end
	end
	arg_32_0:updateTroopButton()
	table.insert(arg_32_0._listeners, lc.addEventListener(Data.Event.rematch_again, function(arg_34_0)
		arg_32_0:onRematchEvent(arg_34_0)
	end))
	table.insert(arg_32_0._listeners, lc.addEventListener(Data.Event.rematch_npc, function(arg_35_0)
		arg_32_0:onRematchEvent(arg_35_0)
	end))
	table.insert(arg_32_0._listeners, lc.addEventListener(Data.Event.rematch_hide, function(arg_36_0)
		arg_32_0:onRematchEvent(arg_36_0)
	end))
	table.insert(arg_32_0._listeners, lc.addEventListener(Data.Event.trophy_dirty, function(arg_37_0)
		arg_32_0:initChests()
	end))
	table.insert(arg_32_0._listeners, lc.addEventListener(Data.Event.clash_trophy_dirty, function(arg_38_0)
		arg_32_0:initChests()
	end))
	table.insert(arg_32_0._listeners, lc.addEventListener(Data.Event.prop_dirty, function(arg_39_0)
		arg_32_0:initChests()
	end))
	table.insert(arg_32_0._listeners, lc.addEventListener(Data.Event.bonus_dirty, function(arg_40_0)
		if arg_40_0._data._type == Data.BonusType.clash_target then
			arg_32_0:initChests()
		end
	end))
end

function var_0_0.onExit(arg_41_0)
	for iter_41_0 = 1, #arg_41_0._listeners do
		lc.Dispatcher:removeEventListener(arg_41_0._listeners[iter_41_0])
	end

	ClientData.removeMsgListener(arg_41_0)
end

function var_0_0.onMsg(arg_42_0, arg_42_1)
	return false
end

function var_0_0.onOpponentNotFound(arg_43_0, arg_43_1)
	if ClientView._findMatchPanel then
		ClientView._findMatchPanel:hide()
	end

	var_0_1.ConfirmRematch.create(Data.FindMatchType.clash):show()

	if #arg_43_1 > 0 then
		local var_43_0 = require("RewardPanel")

		var_43_0.create(arg_43_1, var_43_0.MODE_MATCH_REWARD):show()
	end
end

function var_0_0.onRematchEvent(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1:getEventName()

	if var_44_0 == Data.Event.rematch_npc then
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
		ClientData.sendWorldFindNpc(var_0_1.ConfirmRematch._troopIndex)
	elseif var_44_0 == Data.Event.rematch_again then
		arg_44_0:find(ClientData._isAutoBattle)
	elseif var_44_0 == Data.Event.rematch_hide then
		arg_44_0:updateTroopButton()
	end
end

function var_0_0.updateClashTarget(arg_45_0)
	if arg_45_0._targetCount then
		arg_45_0._targetCount:removeFromParent()

		arg_45_0._targetCount = nil
	end

	local var_45_0 = P:getClashTargetStep()

	if var_45_0 >= 1 and var_45_0 <= #P._playerBonus._bonusClashTarget then
		arg_45_0._targetBg:setVisible(true)

		local var_45_1 = ClientView.createTTF(P._playerBonus._bonusClashTarget[var_45_0]._info._val, ClientView.FontSize.S3)

		var_45_1:setAnchorPoint(0, 0.5)
		lc.addChildToPos(arg_45_0._targetBg, var_45_1, cc.p(156, lc.ch(arg_45_0._targetBg)))

		arg_45_0._targetCount = var_45_1
	else
		arg_45_0._targetBg:setVisible(false)
	end

	local function var_45_2(arg_46_0)
		return P._playerFindClash:getChestGrade(arg_46_0), arg_46_0, Data.CardQuality.UR, true
	end
end

return var_0_0
