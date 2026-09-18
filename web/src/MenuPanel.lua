local var_0_0 = class("MenuPanel", lc.ExtendUIWidget)
local var_0_1 = require("UnionWidget")
local var_0_2 = cc.size(130, 30)
local var_0_3 = cc.size(130, 30)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setContentSize(lc.Director:getVisibleSize())
	var_1_0:init()

	return var_1_0
end

function var_0_0.onRelease(arg_2_0)
	arg_2_0:removeAllChildren()

	for iter_2_0 = 1, #arg_2_0._listeners do
		lc.Dispatcher:removeEventListener(arg_2_0._listeners[iter_2_0])
	end

	arg_2_0._listeners = {}
end

function var_0_0.onEvent(arg_3_0, arg_3_1)
	if arg_3_1 == Data.Event.personal_fund_dirty then
		arg_3_0:updateActivityFlag()
	end

	if arg_3_1 == Data.Event.level_dirty or arg_3_1 == Data.Event.login or arg_3_1 == Data.Event.character_dirty then
		arg_3_0._userArea:setLevel(P._characters[P:getCharacterId()]._level)
	end

	if arg_3_1 == Data.Event.vip_dirty or arg_3_1 == Data.Event.login then
		arg_3_0._userArea:setAvatar(P)
		arg_3_0._userArea:setVip(P._vip)
	end

	if arg_3_1 == Data.Event.name_dirty or arg_3_1 == Data.Event.login then
		arg_3_0._userArea:setName(P._name)
	end

	if arg_3_1 == Data.Event.icon_dirty or arg_3_1 == Data.Event.login or arg_3_1 == Data.Event.avatar_frame_dirty or arg_3_1 == Data.Event.crown_dirty then
		arg_3_0._userArea:setAvatar(P)

		if arg_3_1 == Data.Event.avatar_frame_dirty then
			arg_3_0._userArea:setVip(P._vip)
		end
	end

	if arg_3_1 == Data.Event.login then
		arg_3_0:updateButtonFlags()
		arg_3_0:updateButtonNames()
		arg_3_0:checkActScore()
		arg_3_0:checkActivityButtons()
	end
end

function var_0_0.init(arg_4_0)
	arg_4_0:initUser()
	arg_4_0:initButtons()
	arg_4_0:updateButtonFlags()

	arg_4_0._listeners = {}

	local var_4_0 = {
		Data.Event.level_dirty,
		Data.Event.vip_dirty,
		Data.Event.name_dirty,
		Data.Event.exp_dirty,
		Data.Event.icon_dirty,
		Data.Event.avatar_frame_dirty,
		Data.Event.login,
		Data.Event.character_dirty,
		Data.Event.crown_dirty,
		Data.Event.personal_fund_dirty
	}

	for iter_4_0 = 1, #var_4_0 do
		local var_4_1 = lc.addEventListener(var_4_0[iter_4_0], function(arg_5_0)
			arg_4_0:onEvent(var_4_0[iter_4_0])
		end)

		table.insert(arg_4_0._listeners, var_4_1)
	end

	local var_4_2 = lc.addEventListener(Data.Event.mail, function(arg_6_0)
		local var_6_0 = require("PlayerMail")

		if arg_6_0._event == var_6_0.Event.mail_list_dirty then
			arg_4_0:updateMailFlag()
		end
	end)

	table.insert(arg_4_0._listeners, var_4_2)

	local var_4_3 = {
		Data.Event.ghost_dirty,
		Data.Event.blood_jade_dirty
	}

	for iter_4_1, iter_4_2 in ipairs(var_4_3) do
		local var_4_4 = lc.addEventListener(iter_4_2, function(arg_7_0)
			if arg_4_0._actScoreArea then
				local var_7_0 = P._playerActivity._actScore._type % 100

				arg_4_0._actScoreArea._label:setString(P:getItemCount(var_7_0))
			end
		end)

		table.insert(arg_4_0._listeners, var_4_4)
	end

	local var_4_5 = lc.addEventListener(Data.Event.bonus_dirty, function(arg_8_0)
		local var_8_0 = arg_8_0._data
		local var_8_1 = var_8_0._type
		local var_8_2 = var_8_0._info._cid

		if var_8_1 == Data.BonusType.vip_daily or var_8_1 == Data.BonusType.month_card or var_8_1 == Data.BonusType.week_checkin or var_8_1 == Data.BonusType.month_checkin or var_8_1 == Data.BonusType.online or var_8_1 == Data.BonusType.login then
			arg_4_0:updateCheckinBonusFlag()
		elseif var_8_1 == Data.BonusType.fund_level or var_8_1 == Data.BonusType.fund_all or Data.isPersonalFund(var_8_0._infoId) or var_8_2 >= Data.BonusCid.new_server_begin or var_8_2 >= Data.BonusCid.new_server_end then
			arg_4_0:updateActivityFlag()
		elseif var_8_1 == Data.BonusType.fund_task then
			arg_4_0:updateDailyActiveFlag()
		end

		if var_8_0._info._cid >= Data.BonusCid.channel_begin and var_8_0._info._cid <= Data.BonusCid.channel_end then
			arg_4_0:updateChannelFlag()
		end
	end)

	table.insert(arg_4_0._listeners, var_4_5)

	local var_4_6 = lc.addEventListener(Data.Event.server_bonus_list_dirty, function(arg_9_0)
		arg_4_0:updateMailFlag()
	end)

	table.insert(arg_4_0._listeners, var_4_6)

	local var_4_7 = lc.addEventListener(Data.Event.daily_active_dirty, function(arg_10_0)
		arg_4_0:updateDailyActiveFlag()
	end)

	table.insert(arg_4_0._listeners, var_4_7)

	local var_4_8 = lc.addEventListener(Data.Event.fund_task_dirty, function(arg_11_0)
		arg_4_0:updateDailyActiveFlag()
	end)

	table.insert(arg_4_0._listeners, var_4_8)

	local var_4_9 = lc.addEventListener(Data.Event.log_dirty, function(arg_12_0)
		local var_12_0 = require("PlayerLog")

		if arg_12_0._event == var_12_0.Event.defense_log_dirty then
			arg_4_0:updateBattleFlag()
		end
	end)

	table.insert(arg_4_0._listeners, var_4_9)

	local var_4_10 = lc.addEventListener(GuideManager.Event.seek, function(arg_13_0)
		arg_4_0:onGuide(arg_13_0)
	end)

	table.insert(arg_4_0._listeners, var_4_10)
	table.insert(arg_4_0._listeners, lc.addEventListener(Data.Event.time_hour_changed, function(arg_14_0)
		arg_4_0:onTimeHourChanged()
	end))
	table.insert(arg_4_0._listeners, lc.addEventListener(GuideManager.Event.finish, function(arg_15_0)
		arg_4_0:onGuideFinish(arg_15_0)
	end))
	table.insert(arg_4_0._listeners, lc.addEventListener(Data.Event.badge_reward, function()
		arg_4_0:updateBadgeFlag()
	end))
	table.insert(arg_4_0._listeners, lc.addEventListener(Data.Event.badge_reward_ex, function()
		arg_4_0:updateSFBadgeFlag()
	end))
	table.insert(arg_4_0._listeners, lc.addEventListener(Data.Event.badge_reward_ex2, function()
		arg_4_0:updateSFBadge2Flag()
	end))
	arg_4_0:setMode()
end

function var_0_0.initUser(arg_19_0)
	local var_19_0 = UserWidget.create(P, bor(UserWidget.Flag.LEVEL_NAME, UserWidget.Flag.VIP, UserWidget.Flag.CLICKABLE), 1, false, true)

	var_19_0._nameArea._level:setVisible(true)
	var_19_0._nameArea._level:setString(P._characters[P:getCharacterId()]._level)
	lc.addChildToPos(arg_19_0, var_19_0, cc.p(lc.w(var_19_0) / 2 + 12 + ClientView.SCR_EDGE, lc.h(arg_19_0) - lc.h(var_19_0) / 2 - 12))

	arg_19_0._userArea = var_19_0

	arg_19_0:checkActScore()
end

function var_0_0.initButtons(arg_20_0)
	local var_20_0 = ClientView.getResourceUI()
	local var_20_1 = lc.frameSize("img_icon_mail")
	local var_20_2 = lc.bottom(var_20_0) - 12 - var_20_1.height / 2
	local var_20_3 = 0
	local var_20_4 = ClientView.COLOR_BUTTON_TITLE

	arg_20_0._btnCheckin = arg_20_0:addLabelButton("img_icon_checkin", {
		str = Str(STR.CHECKIN),
		clr = var_20_4
	}, cc.p(ClientView.SCR_W - ClientView.SCR_EDGE - var_20_1.width / 2 - 12, var_20_2))

	arg_20_0:updateDateDisplay()

	arg_20_0._btnMail = arg_20_0:addLabelButton("img_icon_mail", {
		str = Str(STR.MAIL),
		clr = var_20_4
	}, cc.p(lc.x(arg_20_0._btnCheckin) - var_20_1.width - 4, var_20_2))
	arg_20_0._btnRank = arg_20_0:addLabelButton("img_icon_rank", {
		str = Str(STR.RANK),
		clr = var_20_4
	}, cc.p(lc.x(arg_20_0._btnMail) - var_20_1.width - 4, var_20_2))
	arg_20_0._btnIllustration = arg_20_0:addLabelButton("img_icon_illustration", {
		str = Str(STR.ILLUSTRATION),
		clr = var_20_4
	}, cc.p(lc.x(arg_20_0._btnRank) - var_20_1.width - 4, var_20_2))
	arg_20_0._btnDailyActive = arg_20_0:addLabelButton("img_icon_task", {
		str = Str(STR.FUND_TASK),
		clr = var_20_4
	}, cc.p(lc.x(arg_20_0._btnIllustration) - var_20_1.width - 4, var_20_2))
	arg_20_0._btnFrameHall = arg_20_0:addLabelButton("img_icon_frame", {
		str = Str(STR.FRAME_HALL),
		clr = var_20_4
	}, cc.p(lc.x(arg_20_0._btnDailyActive) - var_20_1.width - 4, var_20_2))

	arg_20_0._btnFrameHall:setVisible(ClientData.getValidActivityByType(2000) == nil)

	arg_20_0._btnBadge = arg_20_0:addLabelButton("img_icon_badge", {
		str = Str(STR.BADGE),
		clr = var_20_4
	}, cc.p(lc.x(arg_20_0._btnDailyActive) - var_20_1.width - 4, var_20_2))

	arg_20_0._btnBadge:setVisible(ClientData.getValidActivityByType(2000) ~= nil)

	arg_20_0._btnBadgeEx = arg_20_0:addLabelButton("img_icon_badge_ex", {
		str = Str(STR.BADGE_EX),
		clr = var_20_4
	}, cc.p(lc.x(arg_20_0._btnBadge) - var_20_1.width - 4, var_20_2))

	arg_20_0._btnBadgeEx:setVisible(ClientData.getValidActivityByType(1999) ~= nil)

	arg_20_0._btnBadgeEx2 = arg_20_0:addLabelButton("img_icon_badge_ex2", {
		str = Str(STR.BADGE_EX2),
		clr = var_20_4
	}, cc.p(lc.x(arg_20_0._btnBadgeEx) - var_20_1.width - 4, var_20_2))

	arg_20_0._btnBadgeEx2:setVisible(ClientData.getValidActivityByType(1998) ~= nil)

	local var_20_5 = arg_20_0._btnBadgeEx:isVisible() and arg_20_0._btnBadgeEx or arg_20_0._btnFrameHall

	var_20_5 = arg_20_0._btnBadgeEx2:isVisible() and arg_20_0._btnBadgeEx2 or var_20_5

	if ClientData.isYYBNew() then
		arg_20_0._btnQQBBS = arg_20_0:addLabelButton("img_icon_qq_bbs", {
			str = Str(STR.QQ_BBS),
			clr = var_20_4
		}, cc.p(lc.x(var_20_5) - var_20_1.width - 4, var_20_2))
		arg_20_0._btnQQVPLUS = arg_20_0:addLabelButton("img_icon_qq_vplus", {
			str = Str(STR.QQ_VPLUS),
			clr = var_20_4
		}, cc.p(lc.x(arg_20_0._btnQQBBS) - var_20_1.width - 4, var_20_2))
	elseif ClientData.isVivo() then
		arg_20_0._btnQQBBS = arg_20_0:addLabelButton("img_btn_bbs", {
			str = "V" .. Str(STR.QQ_BBS),
			clr = var_20_4
		}, cc.p(lc.x(var_20_5) - var_20_1.width - 4, var_20_2))
	elseif ClientData.isHuya() and lc.App.yybOpenBbs then
		arg_20_0._btnBroadCast = arg_20_0:addLabelButton("img_btn_broadCast", {
			str = "",
			clr = var_20_4
		}, cc.p(lc.x(var_20_5) - var_20_1.width - 4, var_20_2))
	elseif ClientData._subChannelUid then
		ClientData.loadLCRes("res/oppo.lcres")

		arg_20_0._btnChannelActivity = arg_20_0:addLabelButton("img_btn_oppo", {
			str = "",
			clr = var_20_4
		}, cc.p(lc.x(var_20_5) - var_20_1.width - 4, var_20_2))
	elseif (lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD) and ClientData.getAppId() ~= "40003" then
		arg_20_0._btnLive = arg_20_0:addLabelButton("img_icon_live", {
			str = Str(STR.LIVE),
			clr = var_20_4
		}, cc.p(lc.x(var_20_5) - var_20_1.width - 4, var_20_2 + 2))
	end

	local var_20_6 = lc.createSprite("img_btn_travel")

	arg_20_0._btnTask = ClientView.createShaderButton("img_blank", function(arg_21_0)
		arg_20_0:onButtonClick(arg_21_0)
	end)

	arg_20_0._btnTask:setContentSize(var_20_6:getContentSize())
	var_20_6:setFlippedX(true)
	lc.addChildToCenter(arg_20_0._btnTask, var_20_6)
	arg_20_0._btnTask:setAnchorPoint(cc.p(0, 0))
	arg_20_0._btnTask:setPosition(ClientView.SCR_EDGE, 0)
	arg_20_0:addChild(arg_20_0._btnTask)

	local var_20_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.ACHIEVEMENT))

	ClientView.fitLabel(var_20_7, lc.w(arg_20_0._btnTask) - 8, 0.5)

	var_20_7:setPosition(lc.w(arg_20_0._btnTask) / 2 - 4, 16)
	arg_20_0._btnTask:addChild(var_20_7, 1)

	local var_20_8 = lc.createSprite("img_btn_travel")

	arg_20_0._btnBattle = ClientView.createShaderButton("img_blank", function(arg_22_0)
		arg_20_0:onButtonClick(arg_22_0)
	end)

	arg_20_0._btnBattle:setContentSize(var_20_8:getContentSize())
	lc.addChildToCenter(arg_20_0._btnBattle, var_20_8)
	arg_20_0._btnBattle:setAnchorPoint(cc.p(1, 0))
	arg_20_0._btnBattle:setPosition(lc.w(arg_20_0) - ClientView.SCR_EDGE, 0)
	arg_20_0:addChild(arg_20_0._btnBattle)

	local var_20_9 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.TRAVEL))

	ClientView.fitLabel(var_20_9, lc.w(arg_20_0._btnBattle) - 8, 0.5)

	var_20_9:setPosition(lc.w(arg_20_0._btnBattle) / 2 + 4, 16)
	arg_20_0._btnBattle:addChild(var_20_9, 1)

	arg_20_0._btnActivity = ClientView.createShaderButton(nil, function(arg_23_0)
		arg_20_0:onButtonClick(arg_23_0)
	end)

	arg_20_0._btnActivity:setContentSize(cc.size(120, 120))
	lc.addChildToPos(arg_20_0, arg_20_0._btnActivity, cc.p(lc.cw(arg_20_0._btnActivity) + ClientView.SCR_EDGE, ClientView.SCR_H - 110 - lc.ch(arg_20_0._btnActivity)))

	local var_20_10 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.ACTIVITY))

	ClientView.fitLabel(var_20_10, lc.w(arg_20_0._btnActivity) - 8, 0.5)

	lc.addChildToPos(arg_20_0._btnActivity, var_20_10, cc.p(lc.cw(arg_20_0._btnActivity), 20), 1)
	var_20_10:setColor(ClientView.COLOR_BUTTON_TITLE)

	arg_20_0._btnFirstCharge = ClientView.createShaderButton(nil, function(arg_24_0)
		arg_20_0:onButtonClick(arg_24_0)
	end)

	arg_20_0._btnFirstCharge:setContentSize(cc.size(120, 120))
	lc.addChildToPos(arg_20_0, arg_20_0._btnFirstCharge, cc.p(lc.right(arg_20_0._btnActivity) + lc.cw(arg_20_0._btnFirstCharge) + 10, lc.y(arg_20_0._btnActivity)))

	local var_20_11 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.FIRST_RECHARGE_BONUS))

	ClientView.fitLabel(var_20_11, lc.w(arg_20_0._btnFirstCharge) - 8, 0.5)

	lc.addChildToPos(arg_20_0._btnFirstCharge, var_20_11, cc.p(lc.cw(arg_20_0._btnFirstCharge), 20), 1)
	var_20_11:setColor(ClientView.COLOR_BUTTON_TITLE)

	arg_20_0._btnFirstCharge._label = var_20_11
	arg_20_0._btnCumulativeRecharge = ClientView.createShaderButton(nil, function(arg_25_0)
		arg_20_0:onButtonClick(arg_25_0)
	end)

	arg_20_0._btnCumulativeRecharge:setContentSize(cc.size(120, 120))
	lc.addChildToPos(arg_20_0, arg_20_0._btnCumulativeRecharge, cc.p(lc.x(arg_20_0._btnActivity), lc.bottom(arg_20_0._btnActivity) + 10 - lc.ch(arg_20_0._btnCumulativeRecharge)))

	local var_20_12 = ClientData.getValidActivityByType(603)
	local var_20_13 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_20_12 and Str(var_20_12._nameSid) or "")

	ClientView.fitLabel(var_20_13, lc.w(arg_20_0._btnCumulativeRecharge) - 8, 0.5)

	lc.addChildToPos(arg_20_0._btnCumulativeRecharge, var_20_13, cc.p(lc.cw(arg_20_0._btnCumulativeRecharge), 20), 1)
	var_20_13:setColor(ClientView.COLOR_BUTTON_TITLE)

	arg_20_0._btnCumulativeRecharge._label = var_20_13
	arg_20_0._btnCopy = arg_20_0:addLabelButton("img_btn_copy", {
		offY = 10,
		str = Str(STR.COPY)
	})

	arg_20_0._btnCopy:setPosition(lc.left(arg_20_0._btnBattle) - lc.w(arg_20_0._btnCopy) / 2 - var_20_3, lc.h(arg_20_0._btnCopy) / 2 + var_20_3)

	arg_20_0._btnCharacter = arg_20_0:addLabelButton("img_btn_character", {
		offY = 10,
		str = Str(STR.CHARACTER)
	})

	arg_20_0._btnCharacter:setPosition(lc.right(arg_20_0._btnTask) + lc.w(arg_20_0._btnCharacter) / 2 + var_20_3, lc.h(arg_20_0._btnCharacter) / 2 + var_20_3)

	arg_20_0._btnTieba = arg_20_0:addLabelButton("img_btn_tieba", {
		str = "",
		offY = 10
	})

	arg_20_0._btnTieba:setPosition(lc.left(arg_20_0._btnTask) + lc.cw(arg_20_0._btnTieba) + 14, lc.top(arg_20_0._btnTask) + lc.ch(arg_20_0._btnTieba) + var_20_3)

	arg_20_0._btnGuidance = arg_20_0:addLabelButton("img_btn_teach_02", {
		offY = 10,
		str = Str(STR.GUIDANCE)
	})

	arg_20_0._btnGuidance:setPosition(lc.left(arg_20_0._btnCopy) - lc.w(arg_20_0._btnGuidance) / 2 - var_20_3, lc.h(arg_20_0._btnGuidance) / 2 + var_20_3)

	arg_20_0._btnActivityExchange = arg_20_0:addLabelButton("img_btn_exchange1", {
		str = "",
		offY = 10
	})

	arg_20_0._btnActivityExchange:setPosition(lc.left(arg_20_0._btnGuidance) - lc.cw(arg_20_0._btnActivityExchange) - var_20_3, lc.ch(arg_20_0._btnActivityExchange) + var_20_3)

	arg_20_0._btnActivityExchange2 = arg_20_0:addLabelButton("img_btn_exchange2", {
		str = "",
		offY = 10
	})

	arg_20_0._btnActivityExchange2:setPosition(lc.left(arg_20_0._btnGuidance) - lc.cw(arg_20_0._btnActivityExchange2) - var_20_3, lc.ch(arg_20_0._btnActivityExchange2) + var_20_3)

	if P._level < Data._globalInfo._unlockFindMatch then
		-- block empty
	end

	if P._playerActivity._actFestivalTask and Data._activityTaskInfo._pvp then
		local var_20_14 = Data._activityTaskInfo._pvp._param[1][1]
		local var_20_15
		local var_20_16 = {
			offY = 10,
			str = Str(STR.SNOWBALL_FIGHT + var_20_14 - 1)
		}

		if var_20_14 == 1 then
			var_20_15 = arg_20_0:addLabelButton("img_btn_snowball", var_20_16)
		end

		if var_20_15 then
			var_20_15:setPosition(lc.w(arg_20_0) - lc.w(var_20_15) / 2 - 14, lc.top(arg_20_0._btnCopy) + lc.h(var_20_15) / 2 + 6)

			var_20_15._matchType = var_20_14
			arg_20_0._btnActivityPvp = var_20_15
		end
	end
end

function var_0_0.checkActScore(arg_26_0)
	if arg_26_0._actScoreArea then
		arg_26_0._actScoreArea:getParent():removeFromParent()

		arg_26_0._actScoreArea = nil
	end

	local var_26_0 = P._playerActivity._actScore

	if var_26_0 then
		local var_26_1, var_26_2 = var_26_0:getTypes()
		local var_26_3 = ClientView.createShaderButton(nil, function()
			require("DescForm").create({
				_infoId = var_26_2,
				_count = P:getItemCount(var_26_2)
			}):show()
		end)
		local var_26_4 = ClientView.createResIconLabel(150, string.format("img_icon_res%d_s", var_26_2))

		var_26_4._label:setString(P:getItemCount(var_26_2))

		arg_26_0._actScoreArea = var_26_4

		local var_26_5 = ClientView.createShaderButton("img_btn_squarel_s_1")

		var_26_5:addIcon("img_icon_i")
		var_26_5:setTouchEnabled(false)
		lc.addChildToPos(var_26_4, var_26_5, cc.p(lc.w(var_26_4), lc.h(var_26_4) / 2))
		var_26_3:setContentSize(lc.right(var_26_5), lc.h(var_26_4))
		lc.addChildToPos(var_26_3, var_26_4, cc.p(lc.w(var_26_4) / 2, lc.h(var_26_4) / 2))
		lc.addChildToPos(arg_26_0._userArea, var_26_3, cc.p(lc.right(arg_26_0._userArea._avatar) + 42 + lc.w(var_26_3) / 2, lc.bottom(arg_26_0._userArea._nameArea) - 10 - lc.h(var_26_3) / 2))
	end
end

function var_0_0.checkActivityButtons(arg_28_0)
	if ClientData.isAppStoreReviewing() then
		return
	end

	arg_28_0._btnTieba:setVisible(lc.PLATFORM == cc.PLATFORM_OS_IPHONE or lc.PLATFORM == cc.PLATFORM_OS_IPAD or lc.PLATFORM == cc.PLATFORM_OS_ANDROID and P:getMaxCharacterLevel() >= 35)

	local var_28_0 = ClientData.getValidActivityByType(803)
	local var_28_1 = ClientData.getValidActivityByType(804)
	local var_28_2 = ClientData.getValidActivityByType(534)
	local var_28_3 = ClientData.getValidActivityByType(535)

	if var_28_0 and #var_28_0._icon > 0 then
		arg_28_0._btnActivityExchange:loadTextureNormal(var_28_0._icon, ccui.TextureResType.plistType)
	end

	local var_28_4 = lc.right(arg_28_0._btnActivityExchange)
	local var_28_5 = 8

	arg_28_0._btnActivityExchange:setVisible(var_28_0 ~= nil)

	local var_28_6 = var_28_2 or var_28_3

	arg_28_0._btnActivityExchange2._act = var_28_6

	if var_28_6 and #var_28_6._icon > 0 then
		arg_28_0._btnActivityExchange2:loadTextureNormal(var_28_6._icon, ccui.TextureResType.plistType)
	end

	if arg_28_0._btnActivityExchange:isVisible() then
		var_28_4 = var_28_4 - lc.w(arg_28_0._btnActivityExchange) - 8
	end

	arg_28_0._btnActivityExchange2:setVisible(var_28_6 ~= nil)
	arg_28_0._btnActivityExchange2:setPositionX(var_28_4 - lc.cw(arg_28_0._btnActivityExchange2))

	if arg_28_0._btnActivityExchange2:isVisible() then
		local var_28_7 = var_28_4 - lc.w(arg_28_0._btnActivityExchange2) - 8
	end

	arg_28_0._btnBadgeEx:setVisible(ClientData.getValidActivityByType(1999) ~= nil)
	arg_28_0._btnBadgeEx2:setVisible(ClientData.getValidActivityByType(1998) ~= nil)
end

function var_0_0.onEnter(arg_29_0)
	local var_29_0 = DragonBones.create("lvxjiangli")

	var_29_0:gotoAndPlay("effect1")
	lc.addChildToPos(arg_29_0._btnBattle, var_29_0, cc.p(lc.w(arg_29_0._btnBattle) / 2 + 2, lc.h(arg_29_0._btnTask) / 2 - 6))

	arg_29_0._btnBattle._bones = var_29_0

	local var_29_1 = DragonBones.create("lvxjiangli")

	var_29_1:gotoAndPlay("effect2")
	lc.addChildToPos(arg_29_0._btnTask, var_29_1, cc.p(lc.w(arg_29_0._btnTask) / 2, lc.h(arg_29_0._btnTask) / 2 - 6))

	arg_29_0._btnTask._bones = var_29_1

	local var_29_2 = cc.DragonBonesNode:createWithDecrypt("res/effects/huodong.lcres", "huodong", "huodong")

	var_29_2:gotoAndPlay("effect1")
	lc.addChildToCenter(arg_29_0._btnActivity, var_29_2)

	arg_29_0._btnActivity._bones = var_29_2

	local var_29_3 = cc.DragonBonesNode:createWithDecrypt("res/effects/huodong.lcres", "huodong", "huodong")

	var_29_3:gotoAndPlay("effect1")
	lc.addChildToCenter(arg_29_0._btnFirstCharge, var_29_3)

	arg_29_0._btnFirstCharge._bones = var_29_3

	local var_29_4 = cc.DragonBonesNode:createWithDecrypt("res/effects/huodong.lcres", "huodong", "huodong")

	var_29_4:gotoAndPlay("effect4")
	lc.addChildToCenter(arg_29_0._btnCumulativeRecharge, var_29_4)

	arg_29_0._btnCumulativeRecharge._bones = var_29_4

	arg_29_0._btnCumulativeRecharge:setVisible(ClientData.getValidActivityByType(603) ~= nil)
	arg_29_0:checkActivityButtons()
	arg_29_0:updateActivityFlag()
	arg_29_0:updateBadgeFlag()
	arg_29_0:updateSFBadgeFlag()

	local var_29_5 = SglMsgType_pb.PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS

	ClientData.sendBonusRequest(var_29_5)

	if arg_29_0._btnCardBonus then
		arg_29_0._btnCardBonus:createBones()
	end

	if arg_29_0._btnGift then
		arg_29_0._btnGift:createBones()
	end
end

function var_0_0.onExit(arg_30_0)
	arg_30_0._btnBattle._bones:removeFromParent()
	arg_30_0._btnTask._bones:removeFromParent()
	arg_30_0._btnActivity._bones:removeFromParent()
	arg_30_0._btnFirstCharge._bones:removeFromParent()

	arg_30_0._btnFirstCharge._bones = nil

	arg_30_0._btnCumulativeRecharge._bones:removeFromParent()

	arg_30_0._btnCumulativeRecharge._bones = nil

	if arg_30_0._btnCardBonus then
		arg_30_0._btnCardBonus:removeBones()
	end

	if arg_30_0._btnGift then
		arg_30_0._btnGift:removeBones()
	end
end

function var_0_0.addLabelButton(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = ClientView.createLabelButton(arg_31_1, arg_31_2, function(arg_32_0)
		arg_31_0:onButtonClick(arg_32_0)
	end, arg_31_3)

	arg_31_0:addChild(var_31_0)

	return var_31_0
end

function var_0_0.updateButtonFlags(arg_33_0)
	arg_33_0:updateMailFlag()
	arg_33_0:updateAchieveFlag(P._playerBonus._bonusCount)
	arg_33_0:updateBattleFlag()
	arg_33_0:updateActivityFlag()
	arg_33_0:updateCheckinBonusFlag()
	arg_33_0:updateDailyActiveFlag()
	arg_33_0:updateTeachFlag()
	arg_33_0:updateBadgeFlag()
	arg_33_0:updateSFBadgeFlag()
	arg_33_0:updateChannelFlag()
end

function var_0_0.updateButtonNames(arg_34_0)
	arg_34_0:updateCumulativeName()
end

function var_0_0.updateCumulativeName(arg_35_0)
	if not arg_35_0._btnCumulativeRecharge then
		return
	end

	local var_35_0 = ClientData.getValidActivityByType(603)

	if var_35_0 ~= nil then
		arg_35_0._btnCumulativeRecharge._label:setString(Str(var_35_0._nameSid))
	end
end

function var_0_0.updateChannelFlag(arg_36_0)
	if not arg_36_0._btnChannelActivity then
		return
	end

	local var_36_0 = P._playerBonus:getChannelFlag()

	ClientView.checkNewFlag(arg_36_0._btnChannelActivity, var_36_0, 30)
end

function var_0_0.updateMailFlag(arg_37_0)
	local var_37_0 = P._playerMail:getNewMsgMails() + P._playerMail:getNewSystemMails() + P._playerMail:getNewUnionMails()

	if var_37_0 > 0 then
		if arg_37_0._btnMail._flag == nil then
			arg_37_0._btnMail._flag = cc.Sprite:createWithSpriteFrameName("img_new")

			arg_37_0._btnMail._flag:setPosition(lc.w(arg_37_0._btnMail) - 10, lc.h(arg_37_0._btnMail) - 10)
			arg_37_0._btnMail:addChild(arg_37_0._btnMail._flag)

			arg_37_0._btnMail._flag._value = ClientView.createBMFont(ClientView.BMFont.huali_20, "")

			arg_37_0._btnMail._flag._value:setScale(0.8)
			lc.addChildToCenter(arg_37_0._btnMail._flag, arg_37_0._btnMail._flag._value)
		end

		arg_37_0._btnMail._flag._value:setString(string.format("%d", var_37_0))
	elseif arg_37_0._btnMail._flag ~= nil then
		arg_37_0._btnMail._flag:removeFromParent()

		arg_37_0._btnMail._flag = nil
	end
end

function var_0_0.updateBadgeFlag(arg_38_0)
	local var_38_0 = P._playerBadge:getBadgeBonusFlag() and 1 or 0

	ClientView.checkNewFlag(arg_38_0._btnBadge, var_38_0, 30)
end

function var_0_0.updateSFBadgeFlag(arg_39_0)
	local var_39_0 = P._playerBadgeEx:getBadgeBonusFlag() and 1 or 0

	ClientView.checkNewFlag(arg_39_0._btnBadgeEx, var_39_0, 30)
end

function var_0_0.updateSFBadge2Flag(arg_40_0)
	local var_40_0 = P._playerBadgeEx2:getBadgeBonusFlag() and 1 or 0

	ClientView.checkNewFlag(arg_40_0._btnBadgeEx2, var_40_0, 30)
end

function var_0_0.updateDailyActiveFlag(arg_41_0)
	local var_41_0 = P._playerBonus:getDailyActiveBonusFlag() + P._playerBonus:getWeekActiveBonusFlag() + P._playerBonus:getFundTasksFlag()

	ClientView.checkNewFlag(arg_41_0._btnDailyActive, var_41_0, 30)
end

function var_0_0.updateAchieveFlag(arg_42_0, arg_42_1)
	local var_42_0 = P._playerBonus:getChannelFlag()

	ClientView.checkNewFlag(arg_42_0._btnTask, var_42_0, -2, -124)
end

function var_0_0.updateBattleFlag(arg_43_0)
	local var_43_0 = P._playerLog:getNewDefenseLogCount()

	ClientView.checkNewFlag(arg_43_0._btnBattle, var_43_0, -8, -30)
end

function var_0_0.updateActivityFlag(arg_44_0)
	local var_44_0 = P._playerBonus:getFirstRechargeFlag() + P._playerBonus:getRecharge7Flag()
	local var_44_1 = var_44_0 + P._playerBonus:getFundBonusFlag() + P._playerBonus:getFund2BonusFlag() + P._playerBonus:getInviteBonusFlag() + P._playerBonus:getReturnPackageFlag() + P._playerBonus:getPersonalFundFlag() + P._playerBonus:getNewServerBonusFlag()

	ClientView.checkNewFlag(arg_44_0._btnActivity, var_44_1, 20, -20)

	if not ClientData.isGemRecharged() or P._playerBonus:getFirstRechargeFlag() > 0 then
		arg_44_0._btnFirstCharge._label:setString(Str(STR.FIRST_RECHARGE_BONUS))

		if arg_44_0._btnFirstCharge._bones then
			arg_44_0._btnFirstCharge._bones:gotoAndPlay("effect2")
		end

		ClientView.checkNewFlag(arg_44_0._btnFirstCharge, var_44_0, 20, -20)
	elseif not ClientData.isPackageRecharged() then
		arg_44_0._btnFirstCharge._label:setString(Str(STR.RECHARGE_PACKAGE))

		if arg_44_0._btnFirstCharge._bones then
			arg_44_0._btnFirstCharge._bones:gotoAndPlay("effect3")
		end

		ClientView.checkNewFlag(arg_44_0._btnFirstCharge, 0, 20, -20)
	else
		arg_44_0._btnFirstCharge:setVisible(false)
	end
end

function var_0_0.updateCheckinBonusFlag(arg_45_0)
	local var_45_0 = P._playerBonus:getCheckinBonusFlag()

	ClientView.checkNewFlag(arg_45_0._btnCheckin, var_45_0, 30)
end

function var_0_0.updateDateDisplay(arg_46_0)
	return
end

function var_0_0.updateTeachFlag(arg_47_0)
	local var_47_0 = 0

	for iter_47_0 = 1, 4 do
		var_47_0 = var_47_0 + ClientData.getUnpassTeachCount(iter_47_0)
	end

	local var_47_1 = ClientView.checkNewFlag(arg_47_0._btnGuidance, var_47_0, 20, -92)

	if var_47_1 ~= nil then
		var_47_1:setSpriteFrame("img_new_g")
	end
end

function var_0_0.setMode(arg_48_0, arg_48_1)
	arg_48_0._mode = arg_48_1

	if ClientData.isAppStoreReviewing() then
		arg_48_0._btnCharacter:setVisible(false)
		arg_48_0._btnBattle:setVisible(false)
		arg_48_0._btnGuidance:setVisible(false)
		arg_48_0._btnIllustration:setVisible(false)
		arg_48_0._btnActivity:setVisible(false)
		arg_48_0._btnFirstCharge:setVisible(false)
		arg_48_0._btnCumulativeRecharge:setVisible(false)
		arg_48_0._btnCheckin:setVisible(false)
		arg_48_0._btnCopy:setVisible(false)
		arg_48_0._btnTask:setVisible(false)
		arg_48_0._btnDailyActive:setVisible(false)

		if arg_48_0._btnLive then
			arg_48_0._btnLive:setVisible(false)
		end

		if arg_48_0._btnLeague then
			arg_48_0._btnLeague:setVisible(false)
		end

		arg_48_0._btnRank:setPosition(arg_48_0._btnCheckin:getPosition())
	end

	if ClientData.isAnotherSkin2Locked() then
		arg_48_0._btnIllustration:setVisible(false)
	end
end

function var_0_0.onButtonClick(arg_49_0, arg_49_1)
	if P._guideID < 103 then
		return
	end

	if not ClientData.checkBtnClick() then
		return
	end

	if arg_49_1 == arg_49_0._btnMail then
		require("MailForm").create():show()
	elseif arg_49_1 == arg_49_0._btnDailyActive then
		require("DailyActiveForm").create():show()
	elseif arg_49_1 == arg_49_0._btnBadge then
		require("BadgeForm").create():show()
	elseif arg_49_1 == arg_49_0._btnBadgeEx then
		require("BadgeExForm").create():show()
	elseif arg_49_1 == arg_49_0._btnBadgeEx2 then
		require("BadgeExForm2").create():show()
	elseif arg_49_1 == arg_49_0._btnBattle then
		require("TravelPanel").create():show()
	elseif arg_49_1 == arg_49_0._btnCity then
		if lc._runningScene._sceneId == ClientData.SceneId.union_world then
			lc.replaceScene(require("ResSwitchScene").create(arg_49_0._sceneId, ClientData.SceneId.union))
		else
			ClientData._worldDisplay = ClientData._worldDisplayCity

			ClientView.popScene()
		end
	elseif arg_49_1 == arg_49_0._btnCrusade then
		-- block empty
	elseif arg_49_1 == arg_49_0._btnCopy then
		ClientView.tryGotoExpedition(true)
	elseif arg_49_1 == arg_49_0._btnGuidance then
		require("TeachingForm").create():show()
	elseif arg_49_1 == arg_49_0._btnFrameHall then
		local var_49_0, var_49_1, var_49_2, var_49_3 = ClientData.getServerDate()

		if var_49_3 * 10000 + var_49_2 * 100 + var_49_1 >= 20180108 then
			require("FrameHallPanel").create():show()
		else
			ToastManager.push(Str(STR.FRAME_HALL_LOCKED))
		end
	elseif arg_49_1 == arg_49_0._btnActivityExchange then
		require("ActivityExchangeForm").create():show()
	elseif arg_49_1 == arg_49_0._btnActivityExchange2 then
		if arg_49_1._act and arg_49_1._act._type[1] == 534 then
			require("EnvelopeForm").create():show()
		else
			lc.pushScene(require("LotteryScene").create(Data.LotteryType.spring))
		end
	elseif arg_49_1 == arg_49_0._btnChannelActivity then
		require("ChannelActivityForm").create():show()
	elseif arg_49_1 == arg_49_0._btnTask then
		if lc._runningScene._sceneId == ClientData.SceneId.world then
			lc._runningScene:hideTab()
		end

		require("AchieveForm").create():show()
	elseif arg_49_1 == arg_49_0._btnCharacter then
		require("ChangeCharacterPanel").create(false):show()
	elseif arg_49_1 == arg_49_0._btnActivity then
		lc.pushScene(require("ActivityScene").create())
	elseif arg_49_1 == arg_49_0._btnFirstCharge then
		local var_49_4 = require("ActivityScene")

		if not ClientData.isGemRecharged() or P._playerBonus:getFirstRechargeFlag() > 0 then
			lc.pushScene(var_49_4.create(var_49_4.Tab.first_recharge))
		elseif not ClientData.isPackageRecharged() then
			lc.pushScene(var_49_4.create(var_49_4.Tab.package))
		else
			lc.pushScene(var_49_4.create(var_49_4.Tab.first_recharge))
		end
	elseif arg_49_1 == arg_49_0._btnCheckin then
		require("CheckinForm").create():show()
	elseif arg_49_1 == arg_49_0._btnRank then
		require("RankForm").create(Data.RankRange.lord):show()
	elseif arg_49_1 == arg_49_0._btnIllustration then
		require("IllustrationForm").create():show()
	elseif arg_49_1 == arg_49_0._btnCardBonus then
		local var_49_5 = P._playerBonus._cardBonus
		local var_49_6 = var_49_5._value >= var_49_5._info._val
		local var_49_7

		if not var_49_6 then
			var_49_7 = ""
		end

		local var_49_8 = require("ClaimForm").create(var_49_5, Str(var_49_5._info._nameSid), var_49_7, function()
			local var_50_0 = ClientData.claimBonus(var_49_5)

			ClientView.showClaimBonusResult(var_49_5, var_50_0)
		end)

		var_49_8._btnClaim:setEnabled(var_49_6)

		if not var_49_6 then
			var_49_8:scheduleUpdateWithPriorityLua(function(arg_51_0)
				local var_51_0 = var_49_5._info._val * 3600 - (ClientData.getCurrentTime() - P._regTime)

				if var_51_0 < 0 then
					var_49_8:updateTip("")
					var_49_8._btnClaim:setEnabled(true)
					var_49_8:unscheduleUpdate()
				else
					local var_51_1 = string.format(Str(STR.CLAIM_AFTER1), ClientData.formatPeriod(var_51_0, 3))

					var_49_8:updateTip(var_51_1)
				end
			end, 0)
		end

		var_49_8:show()
	elseif arg_49_1 == arg_49_0._btnGift then
		local var_49_9 = P._playerMarket._gifts
		local var_49_10 = require("BuyGiftForm").create(var_49_9, Str(STR.GIFT_SUPER), "", function()
			return
		end)

		var_49_10:scheduleUpdateWithPriorityLua(function(arg_53_0)
			if P._playerMarket:isGiftsClosed() then
				var_49_10:updateTip(Str(STR.GIFT_INVALID))
				var_49_10._btnBuy:setEnabled(false)
				var_49_10:unscheduleUpdate()
			else
				local var_53_0 = string.format(Str(STR.GIFT_SUPER_COUNTDOWN), ClientData.formatPeriod(timeRemain, 3))

				var_49_10:updateTip(var_53_0)
			end
		end, 0)
		var_49_10:show()
	elseif arg_49_1 == arg_49_0._btnActivityPvp then
		if P._level < Data._globalInfo._unlockFindMatch then
			ClientView.showHelpForm(Str(STR.SNOWBALL_FIGHT) .. string.format(Str(STR.BRACKETS_S), string.format(Str(STR.UNLOCK_LEVEL), Data._globalInfo._unlockFindMatch)), Data.HelpType.activity_pvp)

			return
		end

		require("FindMatchForm").create(arg_49_1._matchType):show()
	elseif arg_49_1 == arg_49_0._btnTeach then
		local var_49_11 = {
			_isAttacker = true,
			_sceneType = Data.BattleSceneType.country_scene_shu,
			_battleType = Data.BattleType.guidance_train,
			_player = {},
			_opponent = {}
		}

		ClientView.popScene(true)
		lc.replaceScene(require("ResSwitchScene").create(lc._runningScene._sceneId, ClientData.SceneId.battle, var_49_11))
	elseif arg_49_1 == arg_49_0._btnQQBBS then
		if lc.App.yybOpenBbs then
			lc.App:yybOpenBbs()
		end
	elseif arg_49_1 == arg_49_0._btnBroadCast then
		if lc.App.yybOpenBbs then
			lc.App:yybOpenBbs()
		end
	elseif arg_49_1 == arg_49_0._btnQQVIP then
		if lc.App.yybOpenVip then
			lc.App:yybOpenVip()
		end
	elseif arg_49_1 == arg_49_0._btnQQVPLUS then
		if lc.App.yybOpenVplus then
			lc.App:yybOpenVplus()
		end
	elseif arg_49_1 == arg_49_0._btnQQTest then
		lc.App:openUrl("https://imgcache.qq.com/club/themes/mobile/middle_page/index.html?url=https%3A%2F%2Fqzs.qq.com%2Fopen%2Fbaymax%2F22%2F10947_1e9d0f8e91ec91a95e6ce627da4cd12c_1.html%3Ffrom%3Djdzc")
	elseif arg_49_1 == arg_49_0._btnLive then
		lc.App:openUrl("http://jdzc.smbbgo.com/jddy/index.html")
	elseif arg_49_1 == arg_49_0._btnLeague then
		lc.App:openUrl("http://jdzc.smbbgo.com/jddy/index.html")
	elseif arg_49_1 == arg_49_0._btnTieba then
		lc.App:openUrl("https://tieba.baidu.com/f?kw=%BE%F6%B6%B7%D6%AE%B3%C7&fr=ala0&tpl=5")
	elseif arg_49_1 == arg_49_0._btnCumulativeRecharge then
		local var_49_12 = ClientData.getValidActivityByType(Data.ActivityType.cumulative)

		if var_49_12 and var_49_12._bonusId[1] ~= 0 then
			require("CumulativeForm").create():show()
		else
			require("CumulativeRechargeForm").create():show()
		end
	end

	if arg_49_1._softGuideFinger then
		GuideManager.releaseFinger()
	end
end

function var_0_0.onTimeHourChanged(arg_54_0)
	if arg_54_0._btnCheckin then
		arg_54_0:updateDateDisplay()
	end
end

function var_0_0.onGuideFinish(arg_55_0, arg_55_1)
	if P._guideID == 500 then
		arg_55_0:checkActivityButtons()
	end
end

function var_0_0.onGuide(arg_56_0, arg_56_1)
	local var_56_0 = GuideManager.getCurStepName()

	if var_56_0 == "enter world" or var_56_0 == "enter world first" then
		GuideManager.setOperateLayer(arg_56_0._btnCrusade)
	elseif var_56_0 == "leave world" then
		GuideManager.setOperateLayer(arg_56_0._btnCity)
	elseif var_56_0 == "enter select copy" then
		GuideManager.setOperateLayer(arg_56_0._btnCopy)
	elseif string.find(var_56_0, "enter crusade") then
		local var_56_1 = tonumber(var_56_0:split(" ")[3])

		arg_56_0._btnBattle._index = var_56_1

		GuideManager.setOperateLayer(arg_56_0._btnBattle)
	elseif var_56_0 == "enter giftcenter" then
		GuideManager.setOperateLayer(arg_56_0._btnCheckin)
	elseif var_56_0 == "enter task" then
		GuideManager.setOperateLayer(arg_56_0._btnTask)
	else
		return
	end

	arg_56_1:stopPropagation()
end

return var_0_0
