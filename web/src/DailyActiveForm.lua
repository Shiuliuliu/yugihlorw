local var_0_0 = class("DailyActiveForm", BaseForm)
local var_0_1 = cc.size(1010, 660)
local var_0_2 = 180
local var_0_3 = cc.size(800, 300)
local var_0_4 = 170

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = {
		Str(STR.FUND_TASK),
		Str(STR.GET)
	}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = {
			_tag = iter_2_0,
			_labelStr = var_2_0[iter_2_0],
			_width = var_0_4,
			_handler = function(arg_3_0)
				arg_2_0:showTab(arg_3_0)
			end
		}

		table.insert(var_2_1, var_2_2)
	end

	arg_2_0._frame:setVisible(false)

	local var_2_3 = ClientView.createHorizontalContentTab(cc.size(var_0_1.width, var_0_1.height), var_2_1)

	lc.addChildToPos(arg_2_0._form, var_2_3, cc.p(var_0_1.width / 2, lc.h(var_2_3) / 2 - 1))

	arg_2_0._contentBg = var_2_3

	arg_2_0:addActivityArea()
	arg_2_0:addGetArea()
	var_2_3:showTab(1, true)
end

function var_0_0.addActivityArea(arg_4_0)
	local var_4_0 = lc.createNode(var_0_1)

	lc.addChildToCenter(arg_4_0._contentBg, var_4_0, -1)

	arg_4_0._activeArea = var_4_0

	local var_4_1 = ccui.Scale9Sprite:createWithSpriteFrameName("img_com_bg_56", cc.rect(0, 0, 8, 240))

	var_4_1:setContentSize(cc.size(lc.w(arg_4_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, var_0_2))
	var_4_1:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_4_0, var_4_1, cc.p(lc.cw(arg_4_0._frame), lc.h(var_4_0) - var_0_2 / 2 - 15), -1)

	arg_4_0._topBg = var_4_1

	local var_4_2 = lc.createSprite("daily_active_bg")

	lc.addChildToPos(var_4_1, var_4_2, cc.p(lc.cw(var_4_2), lc.ch(var_4_1)))

	-- "img_text_active_1" has 当前活跃点 painted into the image, so it can
	-- never follow the language table. Draw the heading instead.
	local var_4_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, "Điểm hoạt động hôm nay")

	var_4_3:setColor(ClientView.COLOR_TEXT_INGOT)

	lc.addChildToPos(var_4_2, var_4_3, cc.p(lc.cw(var_4_2), lc.h(var_4_2) + lc.ch(var_4_3) + 5))

	local var_4_4 = lc.createSprite("img_icon_res14_s")

	lc.addChildToPos(var_4_2, var_4_4, cc.p(45, lc.ch(var_4_2)))

	local var_4_5 = ClientView.createBMFont(ClientView.BMFont.huali_26, P._dailyActive)

	var_4_5:setColor(ClientView.COLOR_TEXT_INGOT)
	var_4_5:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_4_2, var_4_5, cc.p(70, 30))

	arg_4_0._pointLabel = var_4_5

	local var_4_6 = P._playerBonus._bonusDailyActive
	local var_4_7 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_6) do
		table.insert(var_4_7, {
			lightSpr = "light_point",
			_darkSpr = "dark_point",
			_val = iter_4_1._info._val,
			_claimed = iter_4_1._isClaimed
		})
	end

	local var_4_8 = ClientView.createBoxProgressBar(var_4_7, 580, function(arg_5_0)
		local var_5_0 = var_4_6[arg_5_0._index]

		if var_5_0:canClaim() then
			local var_5_1 = ClientData.claimBonus(var_5_0)

			ClientView.showClaimBonusResult(var_5_0, var_5_1)

			arg_5_0._bones._claimed = var_5_0._isClaimed

			arg_4_0._bar.update(P._dailyActive)
		else
			require("ActiveChestForm").create(arg_5_0._index, var_5_0):show()
		end
	end)

	lc.addChildToPos(var_4_1, var_4_8, cc.p(lc.cw(var_4_1) - 45, 30))

	arg_4_0._bar = var_4_8

	var_4_8.update(P._dailyActive)
	arg_4_0:addWeekActiveArea()
	arg_4_0:addGift()
	arg_4_0:createBottomArea()
end

function var_0_0.showTab(arg_6_0, arg_6_1)
	arg_6_0._activeArea:setVisible(false)
	arg_6_0._getArea:setVisible(false)

	if arg_6_1 == 1 then
		arg_6_0._activeArea:setVisible(true)
	else
		arg_6_0._getArea:setVisible(true)
	end

	arg_6_0:setCameraMask(ClientData.CAMERA_2D_FLAG)
end

function var_0_0.addWeekActiveArea(arg_7_0)
	local var_7_0 = lc.createNode(arg_7_0._topBg:getContentSize())

	lc.addChildToPos(arg_7_0._activeArea, var_7_0, cc.p(lc.x(arg_7_0._topBg), lc.bottom(arg_7_0._topBg) - lc.ch(var_7_0)))

	arg_7_0._weekArea = var_7_0

	local var_7_1 = lc.createSprite("daily_active_bg")

	lc.addChildToPos(var_7_0, var_7_1, cc.p(lc.cw(var_7_1), lc.ch(var_7_0)))

	local var_7_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, "Điểm hoạt động tuần này")

	var_7_2:setColor(ClientView.COLOR_TEXT_INGOT)

	lc.addChildToPos(var_7_1, var_7_2, cc.p(lc.cw(var_7_1), lc.h(var_7_1) + lc.ch(var_7_2) + 5))

	local var_7_3 = lc.createSprite("img_icon_res14_s")

	lc.addChildToPos(var_7_1, var_7_3, cc.p(45, lc.ch(var_7_1)))

	local var_7_4 = ClientView.createBMFont(ClientView.BMFont.huali_26, P._weekActive)

	var_7_4:setColor(ClientView.COLOR_TEXT_INGOT)
	var_7_4:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_7_1, var_7_4, cc.p(70, 30))

	arg_7_0._weekPointLabel = var_7_4

	local var_7_5 = P._playerBonus._bonusWeekActive
	local var_7_6 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_5) do
		table.insert(var_7_6, {
			lightSpr = "light_point",
			_darkSpr = "dark_point",
			_val = iter_7_1._info._val,
			_claimed = iter_7_1._isClaimed
		})
	end

	local var_7_7 = ClientView.createBoxProgressBar(var_7_6, 580, function(arg_8_0)
		local var_8_0 = var_7_5[arg_8_0._index]

		if var_8_0:canClaim() then
			local var_8_1 = ClientData.claimBonus(var_8_0)

			ClientView.showClaimBonusResult(var_8_0, var_8_1)

			arg_8_0._bones._claimed = var_8_0._isClaimed

			arg_7_0._weekBar.update(P._weekActive)
		else
			require("ActiveChestForm").create(arg_8_0._index + (5 - #var_7_6), var_8_0):show()
		end
	end, 256)

	lc.addChildToPos(var_7_0, var_7_7, cc.p(lc.cw(var_7_0) - 45, 15))

	arg_7_0._weekBar = var_7_7

	var_7_7.update(P._weekActive)
end

function var_0_0.refreshTasks(arg_9_0)
	local var_9_0 = 0
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in pairs(P._playerBonus._bonusFundTasks) do
		if not iter_9_1._isClaimed then
			var_9_0 = var_9_0 + 1

			if var_9_0 > 5 then
				break
			end

			var_9_1 = math.max(arg_9_0._tasks[var_9_0].runActionUpdateBonus(iter_9_1), var_9_1)
		end
	end

	while var_9_0 < 5 do
		var_9_0 = var_9_0 + 1
		var_9_1 = math.max(arg_9_0._tasks[var_9_0].runActionUpdateBonus(nil), var_9_1)
	end

	return var_9_1
end

function var_0_0.addGift(arg_10_0)
	local var_10_0 = lc.createSpriteWithMask("res/jpg/img_active_gift.jpg")

	lc.addChildToPos(arg_10_0._activeArea, var_10_0, cc.p(lc.w(arg_10_0._form) - 30 - lc.cw(var_10_0), lc.h(arg_10_0._form) - ClientView.FRAME_INNER_TOP - lc.ch(var_10_0)), -1)

	arg_10_0._giftArea = var_10_0

	local var_10_1 = ClientView.createShaderButton(nil, function()
		require("ActiveGiftPanel").create():show()
	end)

	var_10_1:setContentSize(90, 100)

	local var_10_2 = DragonBones.create("lihe")

	var_10_2:setScale(0.5)
	lc.addChildToCenter(var_10_1, var_10_2)
	lc.addChildToPos(var_10_0, var_10_1, cc.p(lc.cw(var_10_0), lc.ch(var_10_0) + 25))

	local var_10_3 = ClientView.createTTF("", ClientView.FontSize.S3, ClientView.COLOR_TEXT_WHITE, cc.size(110, 0), cc.TEXT_ALIGNMENT_CENTER)

	lc.addChildToPos(var_10_0, var_10_3, cc.p(lc.cw(var_10_0), lc.ch(var_10_0) - 35))

	function var_10_0.update()
		var_10_0:setVisible(false)

		if P._dailyActive >= Data.ACTIVE_GIFT_1 then
			if P._playerBonus._bonusActiveGift[1]._value < 1 then
				var_10_2:gotoAndPlay("effect2")
				var_10_3:setString(string.format(Str(STR.ACTIVE_GIFT_TIP), Data.ACTIVE_GIFT_1))
				var_10_0:setVisible(true)
			elseif P._playerBonus._bonusActiveGift[2]._value < 1 then
				var_10_2:gotoAndPlay("effect4")
				var_10_3:setString(string.format(Str(STR.ACTIVE_GIFT_TIP), Data.ACTIVE_GIFT_2))
				var_10_0:setVisible(true)
			end
		end
	end

	var_10_0.update()
end

function var_0_0.createBottomArea(arg_13_0)
	local var_13_0 = ccui.Widget:create()
	local var_13_1 = lc.createSprite({
		_name = "img_com_bg_56",
		_crect = cc.rect(0, 0, 8, 240),
		_size = cc.size(lc.w(arg_13_0._form) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, 250)
	})

	var_13_0:setContentSize(var_13_1:getContentSize())
	lc.addChildToCenter(var_13_0, var_13_1)
	lc.addChildToPos(arg_13_0._activeArea, var_13_0, cc.p(lc.cw(arg_13_0._form), ClientView.FRAME_INNER_BOTTOM + lc.ch(var_13_0) - 5), -1)

	local var_13_2 = {}

	for iter_13_0 = 1, 5 do
		local var_13_3 = ClientView.setOrCreateFundTaskCell(nil, nil, iter_13_0, true)

		function var_13_3._claimBtn._callback(arg_14_0)
			arg_13_0:onClaim(var_13_3)
		end

		table.insert(var_13_2, var_13_3)
	end

	lc.addNodesToCenter(var_13_0, var_13_2, 5)

	arg_13_0._tasks = var_13_2
end

function var_0_0.addGetArea(arg_15_0)
	local var_15_0 = lc.List.createV(cc.size(lc.w(arg_15_0._form) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, lc.h(arg_15_0._contentBg) - 60), 5, 10)

	var_15_0:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(arg_15_0._contentBg, var_15_0, cc.p(lc.cw(arg_15_0._form), ClientView.FRAME_INNER_BOTTOM + lc.ch(var_15_0)))

	arg_15_0._getArea = var_15_0

	local function var_15_1(arg_16_0)
		if P._playerWorld._curLevel[1] > 10104 then
			lc.pushScene(require("FindScene").create(Data.FindMatchType.clash))
			arg_15_0:hide()
		else
			ToastManager.push(string.format(Str(STR.FINDSCENE_LOCKED), Str(Data._chapterInfo[1]._nameSid)))
		end
	end

	local function var_15_2(arg_17_0)
		if ClientView.tryGotoFindLadder(true) then
			arg_15_0:hide()
		end
	end

	local function var_15_3(arg_18_0)
		if ClientView.tryGotoExpedition(true) then
			arg_15_0:hide()
		end
	end

	local function var_15_4(arg_19_0)
		if ClientView.tryGotoUnionBattle(true) then
			arg_15_0:hide()
		end
	end

	local function var_15_5(arg_20_0)
		if ClientView.tryGotoDark(true) then
			arg_15_0:hide()
		end
	end

	local var_15_6 = {
		{
			_title = Str(STR.APP_NAME_JDZC) .. Str(STR.FIND_CLASH_TITLE) .. Str(STR.GET) .. Str(STR.WIN),
			_callBack = var_15_1,
			_rewards = {
				{
					_str = Str(STR.TASK),
					_num = Str(STR.MULTIPY) .. Data._globalInfo._ladderPowerGet
				}
			}
		},
		{
			_title = Str(STR.APP_NAME_JDZC) .. Str(STR.FIND_ARENA_TITLE) .. Str(STR.CAPTURE) .. Str(STR.GET),
			_callBack = var_15_2,
			_rewards = {
				{
					_str = Str(STR.TASK),
					_num = Str(STR.MULTIPY) .. Data._globalInfo._ladderExPowerGet
				}
			}
		},
		{
			_title = Str(STR.APP_NAME_JDZC) .. Str(STR.FIND_UNION_BATTLE_TITLE) .. Str(STR.GET) .. Str(STR.WIN),
			_callBack = var_15_4,
			_rewards = {
				{
					_str = Str(STR.TASK),
					_num = Str(STR.MULTIPY) .. Data._globalInfo._masswarPowerGet
				}
			}
		},
		{
			_title = Str(STR.APP_NAME_JDZC) .. Str(STR.DARK_BATTLE) .. Str(STR.CAPTURE) .. Str(STR.GET),
			_callBack = var_15_5,
			_rewards = {
				{
					_str = Str(STR.TASK),
					_num = Str(STR.MULTIPY) .. "1"
				},
				{
					_str = "-",
					_num = Str(STR.MULTIPY) .. "2"
				}
			}
		},
		{
			_title = Str(STR.DEFEAT_CHALLENGER),
			_callBack = var_15_3,
			_rewards = {
				{
					_str = Str(STR.TASK),
					_num = Str(STR.MULTIPY) .. Data._globalInfo._simpleNPCPowerGet
				},
				{
					_str = "-",
					_num = Str(STR.MULTIPY) .. Data._globalInfo._bossPowerGet
				}
			}
		}
	}

	for iter_15_0, iter_15_1 in ipairs(var_15_6) do
		local var_15_7 = arg_15_0:createItem(iter_15_1)

		var_15_0:pushBackCustomItem(var_15_7)
	end
end

function var_0_0.onClaim(arg_21_0, arg_21_1)
	local var_21_0 = ClientData.claimBonus(arg_21_1._bonus)

	ClientView.showClaimBonusResult(arg_21_1._bonus, var_21_0)

	P._playerBonus._bonusFundTasks[arg_21_1._bonus._info._cid] = nil

	arg_21_0:refreshTasks()
end

function var_0_0.createItem(arg_22_0, arg_22_1)
	local var_22_0 = ccui.Widget:create()

	var_22_0:setAnchorPoint(0.5, 0.5)
	var_22_0:setContentSize(cc.size(lc.w(arg_22_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT - 40, 110))

	local var_22_1 = lc.createSprite({
		_name = "img_com_bg_29",
		_size = var_22_0:getContentSize(),
		_crect = ClientView.CRECT_COM_BG29
	})

	lc.addChildToCenter(var_22_0, var_22_1)

	local var_22_2 = lc.createSprite("img_bg_deco_29")

	ClientView.setMaxSize(var_22_2, lc.w(var_22_0), lc.h(var_22_0))
	lc.addChildToPos(var_22_0, var_22_2, cc.p(lc.w(var_22_0) - lc.cw(var_22_2) * var_22_2:getScale(), lc.ch(var_22_0)))

	local var_22_3 = lc.createSprite("img_deco_bar_01")

	lc.addChildToPos(var_22_0, var_22_3, cc.p(lc.cw(var_22_3), lc.h(var_22_0) - lc.ch(var_22_3) - 5))

	local var_22_4 = ClientView.createTTF(arg_22_1._title, ClientView.FontSize.M2, ClientView.COLOR_TEXT_WHITE)

	var_22_4:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_22_3, var_22_4, cc.p(10, lc.ch(var_22_3)))

	local var_22_5 = {}
	local var_22_6 = {}
	local var_22_7 = 10
	local var_22_8 = 180
	local var_22_9 = 40

	for iter_22_0, iter_22_1 in ipairs(arg_22_1._rewards) do
		local var_22_10 = ClientView.createTTF(iter_22_1._str, ClientView.FontSize.M2, ClientView.COLOR_TEXT_DARK)

		var_22_10:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_22_0, var_22_10, cc.p(var_22_7 + (iter_22_0 - 1) * var_22_8, lc.bottom(var_22_3) - 25))

		local var_22_11 = lc.createSprite("img_icon_res14_s")

		lc.addChildToPos(var_22_0, var_22_11, cc.p(var_22_9 + lc.right(var_22_10), lc.bottom(var_22_3) - 25))

		local var_22_12 = ClientView.createTTF(iter_22_1._num, ClientView.FontSize.M2, ClientView.COLOR_TEXT_DARK)

		var_22_12:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_22_0, var_22_12, cc.p(lc.right(var_22_11), lc.bottom(var_22_3) - 25))
		table.insert(var_22_5, var_22_10)
		table.insert(var_22_6, var_22_12)
	end

	local var_22_13 = ClientView.createScale9ShaderButton("img_btn_1_s", arg_22_1._callBack, ClientView.CRECT_BUTTON_S, 100)

	var_22_13:addLabel(Str(STR.GO))
	lc.addChildToPos(var_22_0, var_22_13, cc.p(lc.w(var_22_0) - 70, lc.ch(var_22_0)))

	var_22_0._rewardLabels = var_22_5
	var_22_0._rewardNums = var_22_6

	return var_22_0
end

function var_0_0.refreshView(arg_23_0)
	arg_23_0._pointLabel:setString(P._dailyActive)
	arg_23_0._bar.update(P._dailyActive)
	arg_23_0._weekPointLabel:setString(P._weekActive)
	arg_23_0._weekBar.update(P._weekActive)
	arg_23_0._giftArea.update()
end

function var_0_0.onShowActionFinished(arg_24_0)
	lc._runningScene:seenByCamera3D(arg_24_0)
	arg_24_0:refreshTasks()
end

function var_0_0.onEnter(arg_25_0)
	var_0_0.super.onEnter(arg_25_0)
	arg_25_0:setCameraMask(ClientData.CAMERA_2D_FLAG)
	arg_25_0:refreshView()

	arg_25_0._listeners = {}

	table.insert(arg_25_0._listeners, lc.addEventListener(Data.Event.daily_active_dirty, function(arg_26_0)
		arg_25_0:refreshView()
	end))
	table.insert(arg_25_0._listeners, lc.addEventListener(Data.Event.fund_task_dirty, function(arg_27_0)
		local var_27_0 = clone(P._playerBonus._changedFundTasks)

		P._playerBonus._changedFundTasks = {}

		local var_27_1 = arg_25_0:refreshTasks() + 0.1

		arg_25_0:runAction(lc.sequence(var_27_1, function()
			if table.maxn(var_27_0) > 0 then
				require("FundTasksPanel").create(var_27_0, Str(STR.FUND_TASK_RESET)):show()
			end
		end))
	end))
	table.insert(arg_25_0._listeners, lc.addEventListener(Data.Event.package_dirty, function(arg_29_0)
		arg_25_0._giftArea.update()
	end))
end

function var_0_0.onExit(arg_30_0)
	var_0_0.super.onExit(arg_30_0)

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_30_1)
	end
end

function var_0_0.hide(arg_31_0)
	var_0_0.super.hide(arg_31_0)
end

function var_0_0.onCleanup(arg_32_0)
	lc.TextureCache:removeTextureForKey("res/jpg/img_active_gift.jpg")
	ClientView.getMenuUI():updateDailyActiveFlag()
	var_0_0.super.onCleanup(arg_32_0)
end

return var_0_0
