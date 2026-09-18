local var_0_0 = class("BadgeExForm", BaseForm)
local var_0_1 = cc.size(1024, 700)
local var_0_2 = 180
local var_0_3 = cc.size(800, 300)
local var_0_4 = 170
local var_0_5 = 100
local var_0_6 = {
	"Thứ 2",
	"Thứ 3",
	"Thứ 4",
	"Thứ 5",
	"Thứ 6",
	"Thứ 7",
	"Chủ nhật"
}
local var_0_7 = 1
local var_0_8 = 2
local var_0_9 = 7

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	local var_1_1 = SglMsgType_pb.PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS

	ClientData.sendBonusRequest(var_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))
	lc.offset(arg_2_0._form, 0, -30)

	arg_2_0._resNames = ClientData.loadLCRes("res/badge.lcres")

	local var_2_0 = ClientData.getDayOfWeek()

	arg_2_0._weekDay = var_2_0 == 0 and 7 or var_2_0

	local var_2_1 = {
		Str(STR.FREE_BADGE_EX),
		Str(STR.BADGE_TASK_EX),
		Str(STR.BUY),
		Str(STR.HELP)
	}
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_3 = {
			_tag = iter_2_0,
			_labelStr = var_2_1[iter_2_0],
			_width = var_0_4,
			_handler = function(arg_3_0)
				arg_2_0:showTab(arg_3_0)
			end
		}

		table.insert(var_2_2, var_2_3)
	end

	arg_2_0._frame:setVisible(false)

	local var_2_4 = ClientView.createHorizontalContentTab(cc.size(var_0_1.width, var_0_1.height), var_2_2)

	lc.addChildToPos(arg_2_0._form, var_2_4, cc.p(var_0_1.width / 2, lc.h(var_2_4) / 2 - 1))

	arg_2_0._contentBg = var_2_4

	local var_2_5 = lc.createSprite({
		_name = "img_frame_bg",
		_crect = cc.rect(29, 23, 1, 1),
		_size = cc.size(lc.w(arg_2_0._frame) - 40, lc.h(arg_2_0._frame) - 40)
	})

	lc.addChildToCenter(var_2_4, var_2_5, -2)

	arg_2_0._frameBg = var_2_5

	local var_2_6 = lc.createSprite("res/jpg/img_badge_bg_ex.jpg")

	var_2_6:setVisible(false)
	lc.addChildToCenter(var_2_4, var_2_6, -2)

	arg_2_0._frameBgEx = var_2_6

	local var_2_7 = lc.createSprite({
		_name = "img_com_bg_23",
		_crect = ClientView.CRECT_COM_BG23,
		_size = cc.size(lc.w(arg_2_0._frame) - 56, 80)
	})

	lc.addChildToPos(var_2_4, var_2_7, cc.p(lc.cw(var_2_4), lc.ch(var_2_7) + 23), -1)

	arg_2_0._bottom = var_2_7

	if not arg_2_0._indicator then
		arg_2_0._indicator = ClientView.showPanelActiveIndicator(arg_2_0)
	end

	ClientData.addMsgListener(arg_2_0, function(arg_4_0)
		return arg_2_0:onMsg(arg_4_0)
	end, 0)
	arg_2_0:addBadgeArea()
	arg_2_0:addTaskArea()
	arg_2_0:addBuyArea()
	arg_2_0:addHelpArea()
	arg_2_0:hideBottom()
end

function var_0_0.addBadgeArea(arg_5_0)
	local var_5_0 = lc.createNode(var_0_1)

	lc.addChildToCenter(arg_5_0._contentBg, var_5_0, -1)

	arg_5_0._badgeArea = var_5_0

	local var_5_1 = lc.createSprite({
		_name = "img_badge_title",
		_crect = cc.rect(493, 0, 1, 85),
		_size = cc.size(995, 85)
	})

	lc.addChildToPos(var_5_0, var_5_1, cc.p(lc.cw(var_5_0), lc.h(var_5_0) - lc.ch(var_5_1) - 33))

	arg_5_0._titleBg = var_5_1

	local var_5_2 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.BADGE_GRADE) .. P._playerBadgeEx:getGrade())

	var_5_2:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_5_1, var_5_2, cc.p(50, lc.h(var_5_1) - lc.ch(var_5_2) - 5))

	arg_5_0._gradeTxt = var_5_2

	local var_5_3 = ClientData.getIconName(Data.ResType.badge_star_ex, false)
	local var_5_4 = lc.createSprite(var_5_3)

	lc.addChildToPos(var_5_1, var_5_4, cc.p(50, lc.ch(var_5_4)), 1)

	local var_5_5 = (function(arg_6_0)
		local var_6_0 = ClientView.CRECT_PROGRESS_BG.height
		local var_6_1 = lc.createSprite({
			_name = "img_pro_bottom_new",
			_crect = ClientView.CRECT_PROGRESS_BG,
			_size = cc.size(arg_6_0, var_6_0)
		})
		local var_6_2 = ccui.LoadingBar:create()

		var_6_2:loadTexture("img_pro_new", ccui.TextureResType.plistType)
		var_6_2:setDirection(ccui.LoadingBarDirection.LEFT)
		var_6_2:setPosition(arg_6_0 / 2, var_6_0 / 2 + 5)
		var_6_2:setScale9Enabled(true)
		var_6_2:setCapInsets(ClientView.CRECT_PROGRESS_FG)
		var_6_2:setContentSize(arg_6_0 + 6, ClientView.CRECT_PROGRESS_FG.height)
		var_6_2:setColor(barColor or lc.Color3B.yellow)
		var_6_1:addChild(var_6_2)
		var_6_2:setPercent(0)

		var_6_1._bar = var_6_2

		local var_6_3 = ClientView.createTTF("2/10")

		lc.addChildToCenter(var_6_1, var_6_3)
		lc.offset(var_6_3, 0, 7)

		var_6_1._label = var_6_3

		return var_6_1
	end)(200)

	var_5_5:setVisible(not (P._playerBadgeEx:getGrade() >= 100))
	var_5_5:setAnchorPoint(0, 0.5)
	var_5_5._bar:setPercent(P._playerBadgeEx:getCurStarNum() / P._playerBadgeEx:getStarTotal() * 100)
	var_5_5._label:setString(P._playerBadgeEx:getCurStarNum() .. "/" .. P._playerBadgeEx:getStarTotal())
	lc.addChildToPos(var_5_1, var_5_5, cc.p(lc.right(var_5_4) + 15, lc.ch(var_5_4) - 5))

	arg_5_0._proBottom = var_5_5

	local var_5_6 = ClientView.createBMFont(ClientView.BMFont.huali_26, "MAX")

	var_5_6:setVisible(P._playerBadgeEx:getGrade() >= 100)
	lc.addChildToPos(var_5_1, var_5_6, cc.p(lc.right(var_5_4) + 65, lc.ch(var_5_4)))

	arg_5_0._maxTxt = var_5_6

	local var_5_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.STAGE_COUNT_CUR))

	lc.addChildToPos(var_5_1, var_5_7, cc.p(lc.w(var_5_1) - 200, lc.h(var_5_1) - lc.ch(var_5_7) - 5))

	local var_5_8, var_5_9 = P._playerBadgeEx:getCountDown()
	local var_5_10 = string.format(Str(STR.END_TIME_DAY), var_5_8)

	if var_5_8 <= 0 then
		var_5_10 = string.format(Str(STR.END_TIME_HOUR), var_5_9)
	end

	local var_5_11 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_5_10)

	var_5_11:setScale(0.7)
	lc.addChildToPos(var_5_1, var_5_11, cc.p(lc.w(var_5_1) - 200, lc.h(var_5_1) - lc.h(var_5_7) - lc.ch(var_5_11) - 15))

	local var_5_12 = lc.createSprite("img_silverbage_bottom")

	lc.addChildToPos(var_5_0, var_5_12, cc.p(lc.cw(var_5_12) + 30, lc.h(var_5_0) * 0.7 - 15))

	arg_5_0._freeBadgeBottom = var_5_12

	local var_5_13 = lc.createSprite("img_silver_badge_ex")

	lc.addChildToPos(var_5_12, var_5_13, cc.p(lc.cw(var_5_12) - 3, lc.h(var_5_12) - lc.ch(var_5_13) - 3))

	local var_5_14 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.FREE_BADGE_EX))

	var_5_14:setScale(0.8)
	var_5_14:setColor(cc.c3b(148, 226, 255))
	lc.addChildToPos(var_5_12, var_5_14, cc.p(lc.cw(var_5_12) - 3, lc.bottom(var_5_13) - 30))

	local var_5_15 = lc.createSprite("img_goldbadge_bottom")

	lc.addChildToPos(var_5_0, var_5_15, cc.p(lc.cw(var_5_15) + 30, lc.h(var_5_0) * 0.4 - 40))

	arg_5_0._badgeBottom = var_5_15

	local var_5_16 = lc.createSprite("img_gold_badge_ex")

	lc.addChildToPos(var_5_15, var_5_16, cc.p(lc.cw(var_5_15) - 3, lc.h(var_5_15) - lc.ch(var_5_16) - 3))

	local var_5_17 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.BADGE_SPRING))

	var_5_17:setScale(0.8)
	var_5_17:setColor(cc.c3b(255, 254, 198))
	lc.addChildToPos(var_5_15, var_5_17, cc.p(lc.cw(var_5_15) - 3, lc.bottom(var_5_16) - 30))

	local var_5_18 = lc.createSprite("img_lock_1")

	var_5_18:setVisible(not P._playerBadgeEx:IsBuyBadge())
	lc.addChildToPos(var_5_15, var_5_18, cc.p(lc.cw(var_5_15) - 5, lc.bottom(var_5_17) - 30))

	arg_5_0._lock = var_5_18

	local var_5_19 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_7_0)
		arg_5_0._contentBg:showTab(3, true)
	end, ClientView.CRECT_BUTTON_S, 210, 60)

	var_5_19:addLabel(Str(STR.BUY) .. Str(STR.BADGE_SPRING))
	var_5_19:setVisible(not P._playerBadgeEx:IsBuyBadge())
	lc.addChildToPos(var_5_0, var_5_19, cc.p(180, lc.ch(var_5_19) + 30))

	arg_5_0._buyBtn = var_5_19

	local var_5_20 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.BUY_BADGE_TIP_EX))

	var_5_20:setScale(0.9)
	var_5_20:setColor(cc.c3b(148, 226, 255))
	var_5_20:setVisible(not P._playerBadgeEx:IsBuyBadge())
	lc.addChildToPos(var_5_0, var_5_20, cc.p(lc.cw(var_5_0) + 80, lc.h(var_5_20) + 35))

	arg_5_0._tip = var_5_20

	local var_5_21 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_5_0:privilegeShow(arg_5_0._bubble, arg_5_0._privilegeTxt)
	end, ClientView.CRECT_BUTTON_S, 210, 60)

	var_5_21:addLabel(Str(STR.ACTIVATE_THEN_PRIVILEGE))
	var_5_21:setVisible(P._playerBadgeEx:IsBuyBadge())
	lc.addChildToPos(var_5_0, var_5_21, cc.p(lc.w(var_5_0) - lc.cw(var_5_21) - 30, lc.ch(var_5_21) + 30), 1)

	arg_5_0._privilegeBtn = var_5_21

	local var_5_22 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_5_0:onClaimAll()
	end, ClientView.CRECT_BUTTON_S, 210, 60)

	var_5_22:addLabel(Str(STR.CLAIM_ALL))
	var_5_22:setDisabledShader(ClientView.SHADER_DISABLE)
	lc.addChildToPos(var_5_0, var_5_22, cc.p(lc.left(var_5_21) - lc.cw(var_5_22) - 30, lc.ch(var_5_22) + 30), 1)

	arg_5_0._claimAllBtn = var_5_22

	local var_5_23 = lc.createSprite({
		_name = "img_tip_bg",
		_crect = cc.rect(37, 30, 1, 85),
		_size = cc.size(320, 210)
	})

	var_5_23:setVisible(false)
	lc.addChildToPos(var_5_21, var_5_23, cc.p(20, lc.h(var_5_21) + lc.ch(var_5_23)))

	arg_5_0._bubble = var_5_23

	local var_5_24 = ClientView.createTTF(Str(STR.VOID), ClientView.FontSize.S3, ClientView.COLOR_TEXT_DARK)

	lc.addChildToPos(var_5_21, var_5_24, cc.p(lc.cw(var_5_23) - 140, lc.ch(var_5_23) + 90), 1)
	var_5_24:setVisible(false)

	arg_5_0._privilegeTxt = var_5_24
	arg_5_0._freeRewards = {}
	arg_5_0._reward = {}

	for iter_5_0 = 1, #P._playerBonus._bonusBadgeEx do
		local var_5_25 = P._playerBonus._bonusBadgeEx[iter_5_0]

		if var_5_25._type == 57 then
			table.insert(arg_5_0._freeRewards, var_5_25)
		elseif var_5_25._type == 58 then
			table.insert(arg_5_0._reward, var_5_25)
		end
	end

	arg_5_0:createItemList()
	arg_5_0:updateRewardList()
end

function var_0_0.createItemList(arg_10_0)
	arg_10_0._tabTable = {}
	arg_10_0._freeItems = {}
	arg_10_0._noFreeItems = {}
	arg_10_0._curPage = P._playerBadgeEx:getGrade() % var_0_9 == 0 and math.floor(P._playerBadgeEx:getGrade() / var_0_9) or math.floor(P._playerBadgeEx:getGrade() / var_0_9) + 1
	arg_10_0._curPage = math.max(1, arg_10_0._curPage)
	arg_10_0._totalPage = math.floor(var_0_5 / var_0_9) + 1

	for iter_10_0 = 1, var_0_9 do
		local var_10_0 = lc.createSprite("img_tab_bottom")
		local var_10_1 = ClientView.createBMFont(ClientView.BMFont.huali_26, grade)

		lc.addChildToCenter(var_10_0, var_10_1)
		lc.offset(var_10_1, 0, 5)

		var_10_0._gradeObj = var_10_1

		table.insert(arg_10_0._tabTable, var_10_0)
	end

	lc.addNodesToCenter(arg_10_0._badgeArea, arg_10_0._tabTable, 8, lc.bottom(arg_10_0._titleBg) - 30, nil, nil, lc.cw(arg_10_0._badgeArea) + lc.cw(arg_10_0._freeBadgeBottom))

	for iter_10_1 = 1, var_0_9 do
		local var_10_2 = lc.createSprite("img_blue_bottom")
		local var_10_3 = IconWidget.createByBonus(arg_10_0._freeRewards[iter_10_1]._info, 1, IconWidget.DisplayFlag.ITEM_NO_NAME)

		var_10_3:setScale(0.6)
		lc.addChildToPos(var_10_2, var_10_3, cc.p(lc.cw(var_10_2), lc.h(var_10_2) - lc.ch(var_10_3)))

		local var_10_4 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_11_0)
			arg_10_0:onClaim(arg_11_0)
		end, ClientView.CRECT_BUTTON_S, 80, 40)

		var_10_4:setDisabledShader(ClientView.SHADER_DISABLE)
		var_10_4:addLabel(Str(STR.CLAIM))
		var_10_4._label:setScale(0.8)
		lc.addChildToPos(var_10_2, var_10_4, cc.p(lc.cw(var_10_2), lc.ch(var_10_4) + 10))

		local var_10_5 = lc.createSprite("img_lock_1")

		var_10_5:setScale(0.9)
		lc.addChildToPos(var_10_2, var_10_5, cc.p(lc.cw(var_10_2), lc.ch(var_10_5) + 10))

		var_10_2._rewardObj = var_10_3
		var_10_2._btn = var_10_4
		var_10_2._lock = var_10_5

		table.insert(arg_10_0._freeItems, var_10_2)
	end

	lc.addNodesToCenter(arg_10_0._badgeArea, arg_10_0._freeItems, 5, lc.y(arg_10_0._freeBadgeBottom) - 20, nil, nil, lc.cw(arg_10_0._badgeArea) + lc.cw(arg_10_0._freeBadgeBottom))

	for iter_10_2 = 1, var_0_9 do
		local var_10_6 = lc.createSprite("img_yellow_bottom")
		local var_10_7 = IconWidget.createByBonus(arg_10_0._reward[iter_10_2]._info, 1, IconWidget.DisplayFlag.ITEM_NO_NAME)

		var_10_7:setScale(0.6)
		lc.addChildToPos(var_10_6, var_10_7, cc.p(lc.cw(var_10_6), lc.h(var_10_6) - lc.ch(var_10_7)))

		local var_10_8 = IconWidget.createByBonus(arg_10_0._reward[iter_10_2]._info, 2, IconWidget.DisplayFlag.ITEM_NO_NAME)

		var_10_8:setScale(0.6)
		lc.addChildToPos(var_10_6, var_10_8, cc.p(lc.cw(var_10_6), lc.h(var_10_6) - lc.h(var_10_8) * 1.5))

		local var_10_9 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_12_0)
			arg_10_0:onClaim(arg_12_0)
		end, ClientView.CRECT_BUTTON_S, 80, 40)

		var_10_9:setDisabledShader(ClientView.SHADER_DISABLE)
		var_10_9:addLabel(Str(STR.CLAIM))
		var_10_9._label:setScale(0.8)
		lc.addChildToPos(var_10_6, var_10_9, cc.p(lc.cw(var_10_6), lc.ch(var_10_9) + 10))

		local var_10_10 = lc.createSprite("img_lock_1")

		var_10_10:setScale(0.9)
		lc.addChildToPos(var_10_6, var_10_10, cc.p(lc.cw(var_10_6), lc.ch(var_10_10) + 10))

		var_10_6._rewardObj1 = var_10_7
		var_10_6._rewardObj2 = var_10_8
		var_10_6._btn = var_10_9
		var_10_6._lock = var_10_10

		table.insert(arg_10_0._noFreeItems, var_10_6)
	end

	lc.addNodesToCenter(arg_10_0._badgeArea, arg_10_0._noFreeItems, 5, lc.y(arg_10_0._badgeBottom), nil, nil, lc.cw(arg_10_0._badgeArea) + lc.cw(arg_10_0._freeBadgeBottom))

	local var_10_11 = cc.p(lc.w(arg_10_0._freeBadgeBottom) + 90, lc.ch(arg_10_0._badgeArea))
	local var_10_12 = cc.p(lc.w(arg_10_0._badgeArea) - 90, lc.ch(arg_10_0._badgeArea))
	local var_10_13 = ClientView.createPageArrow(true, var_10_11, function()
		arg_10_0._curPage = math.max(1, arg_10_0._curPage - 1)

		arg_10_0._leftBtn:float()
		arg_10_0:updateRewardList()
	end)

	var_10_13:float()
	var_10_13:setVisible(arg_10_0._curPage ~= 1)
	lc.addChildToPos(arg_10_0._badgeArea, var_10_13, var_10_11)

	arg_10_0._leftBtn = var_10_13

	local var_10_14 = ClientView.createPageArrow(false, var_10_12, function()
		arg_10_0._curPage = math.min(arg_10_0._totalPage, arg_10_0._curPage + 1)

		arg_10_0._rightBtn:float()
		arg_10_0:updateRewardList()
	end)

	var_10_14:float()
	var_10_14:setVisible(arg_10_0._curPage ~= arg_10_0._totalPage)
	lc.addChildToPos(arg_10_0._badgeArea, var_10_14, var_10_12)

	arg_10_0._rightBtn = var_10_14
end

function var_0_0.updateRewardList(arg_15_0)
	arg_15_0._leftBtn:setVisible(arg_15_0._curPage ~= 1)
	arg_15_0._rightBtn:setVisible(arg_15_0._curPage ~= arg_15_0._totalPage)
	arg_15_0._gradeTxt:setString(Str(STR.BADGE_GRADE_EX) .. P._playerBadgeEx:getGrade())
	arg_15_0._buyBtn:setVisible(not P._playerBadgeEx:IsBuyBadge())
	arg_15_0._tip:setVisible(not P._playerBadgeEx:IsBuyBadge())
	arg_15_0._privilegeBtn:setVisible(P._playerBadgeEx:IsBuyBadge())
	arg_15_0._proBottom._bar:setPercent(P._playerBadgeEx:getCurStarNum() / P._playerBadgeEx:getStarTotal() * 100)
	arg_15_0._proBottom._label:setString(P._playerBadgeEx:getCurStarNum() .. "/" .. P._playerBadgeEx:getStarTotal())
	arg_15_0._proBottom:setVisible(not (P._playerBadgeEx:getGrade() >= 100))
	arg_15_0._maxTxt:setVisible(P._playerBadgeEx:getGrade() >= 100)
	arg_15_0._claimAllBtn:setVisible(P._playerBadgeEx:IsBuyBadge())
	arg_15_0._claimAllBtn:setEnabled(P._playerBadgeEx:getBadgeClaimFlag())

	for iter_15_0 = 1, #arg_15_0._tabTable do
		local var_15_0 = (arg_15_0._curPage - 1) * var_0_9 + iter_15_0
		local var_15_1 = arg_15_0._tabTable[iter_15_0]

		var_15_1._gradeObj:setString(var_15_0)

		if var_15_0 == P._playerBadgeEx:getGrade() then
			var_15_1:setSpriteFrame("img_tab")
		else
			var_15_1:setSpriteFrame("img_tab_bottom")
		end

		if var_15_0 > 100 then
			var_15_1:setVisible(false)
		else
			var_15_1:setVisible(true)
		end
	end

	for iter_15_1 = 1, #arg_15_0._freeItems do
		local var_15_2 = (arg_15_0._curPage - 1) * var_0_9 + iter_15_1
		local var_15_3 = arg_15_0._freeItems[iter_15_1]

		if var_15_2 > 100 then
			var_15_3:setVisible(false)
		else
			var_15_3:setVisible(true)
			var_15_3._rewardObj:resetDataByBonus(arg_15_0._freeRewards[var_15_2]._info, 1)

			if var_15_2 > P._playerBadgeEx:getGrade() then
				var_15_3._lock:setVisible(true)
				var_15_3._btn:setVisible(false)
			else
				var_15_3._lock:setVisible(false)
				var_15_3._btn:setVisible(true)
			end

			local var_15_4 = arg_15_0._freeRewards[var_15_2]

			var_15_3._btn._bonus = var_15_4

			if var_15_4 and var_15_4._isClaimed then
				var_15_3._btn:setEnabled(false)
				var_15_3._btn._label:setString(Str(STR.CLAIMED))
			else
				var_15_3._btn:setEnabled(true)
				var_15_3._btn._label:setString(Str(STR.CLAIM))
			end
		end
	end

	for iter_15_2 = 1, #arg_15_0._noFreeItems do
		local var_15_5 = (arg_15_0._curPage - 1) * var_0_9 + iter_15_2
		local var_15_6 = arg_15_0._noFreeItems[iter_15_2]

		if var_15_5 > 100 then
			var_15_6:setVisible(false)
		else
			var_15_6:setVisible(true)
			var_15_6._rewardObj1:resetDataByBonus(arg_15_0._reward[var_15_5]._info, 1)
			var_15_6._rewardObj2:resetDataByBonus(arg_15_0._reward[var_15_5]._info, 2)

			if P._playerBadgeEx:IsBuyBadge() then
				if var_15_5 > P._playerBadgeEx:getGrade() then
					var_15_6._lock:setVisible(true)
					var_15_6._btn:setVisible(false)
				else
					var_15_6._lock:setVisible(false)
					var_15_6._btn:setVisible(true)
				end
			else
				var_15_6._lock:setVisible(true)
				var_15_6._btn:setVisible(false)
			end

			local var_15_7 = arg_15_0._reward[var_15_5]

			var_15_6._btn._bonus = var_15_7

			if var_15_7 and var_15_7._isClaimed then
				var_15_6._btn:setEnabled(false)
				var_15_6._btn._label:setString(Str(STR.CLAIMED))
			else
				var_15_6._btn:setEnabled(true)
				var_15_6._btn._label:setString(Str(STR.CLAIM))
			end
		end
	end
end

function var_0_0.addTaskArea(arg_16_0)
	local var_16_0 = lc.createNode(var_0_1)

	lc.addChildToCenter(arg_16_0._contentBg, var_16_0, -1)

	arg_16_0._taskArea = var_16_0

	local var_16_1 = lc.createSprite({
		_name = "img_com_bg_23",
		_crect = ClientView.CRECT_COM_BG23,
		_size = cc.size(lc.w(arg_16_0._frame) - 56, 85)
	})

	lc.addChildToPos(var_16_0, var_16_1, cc.p(lc.cw(var_16_0), lc.h(var_16_0) - lc.ch(var_16_1) - 30), -1)

	arg_16_0._days = {}

	for iter_16_0 = 1, 7 do
		local var_16_2 = ClientView.createScale9ShaderButton("img_blank", function()
			arg_16_0:updateTask(iter_16_0)
		end, ClientView.CRECT_BUTTON, 146, 70)
		local var_16_3 = lc.createSprite("img_day")

		lc.addChildToCenter(var_16_2, var_16_3)

		var_16_2._item = var_16_3

		local var_16_4 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_0_6[iter_16_0])

		lc.addChildToPos(var_16_3, var_16_4, cc.p(lc.cw(var_16_3), lc.h(var_16_3) - lc.ch(var_16_4) - 2))

		local var_16_5 = ClientData.getIconName(Data.ResType.badge_star_ex, false)
		local var_16_6 = lc.createSprite(var_16_5)

		var_16_6:setScale(0.6)
		lc.addChildToPos(var_16_3, var_16_6, cc.p(lc.cw(var_16_3) - 35, lc.sh(var_16_6) / 2 + 10))

		local var_16_7, var_16_8 = P._playerBadgeEx:getDayStar(iter_16_0)
		local var_16_9 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_16_7 .. "/" .. var_16_8)

		var_16_9:setAnchorPoint(0, 0.5)
		var_16_9:setScale(0.8)
		var_16_9:setColor(cc.c3b(255, 144, 0))
		lc.addChildToPos(var_16_3, var_16_9, cc.p(lc.cw(var_16_3) - 15, lc.sh(var_16_6) / 2 + 10))

		var_16_2._txtObj = var_16_9

		table.insert(arg_16_0._days, var_16_2)
	end

	lc.addNodesToCenter(var_16_1, arg_16_0._days, -10, lc.ch(var_16_1))

	local var_16_10 = lc.createSprite("img_silverbage_bottom")

	lc.addChildToPos(var_16_0, var_16_10, cc.p(lc.cw(var_16_10) + 30, lc.h(var_16_0) * 0.7 - 15))

	local var_16_11 = lc.createSprite("img_silver_badge_ex")

	lc.addChildToPos(var_16_10, var_16_11, cc.p(lc.cw(var_16_10) - 3, lc.h(var_16_10) - lc.ch(var_16_11) - 3))

	local var_16_12 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.FREE_BADGE_EX))

	var_16_12:setScale(0.8)
	var_16_12:setColor(cc.c3b(148, 226, 255))
	lc.addChildToPos(var_16_10, var_16_12, cc.p(lc.cw(var_16_10) - 3, lc.bottom(var_16_11) - 30))

	local var_16_13 = lc.createSprite("img_goldbadge_bottom")

	lc.addChildToPos(var_16_0, var_16_13, cc.p(lc.cw(var_16_13) + 30, lc.h(var_16_0) * 0.4 - 40))

	local var_16_14 = lc.createSprite("img_gold_badge_ex")

	lc.addChildToPos(var_16_13, var_16_14, cc.p(lc.cw(var_16_13) - 3, lc.h(var_16_13) - lc.ch(var_16_14) - 3))

	local var_16_15 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.BADGE_SPRING))

	var_16_15:setScale(0.8)
	var_16_15:setColor(cc.c3b(255, 254, 198))
	lc.addChildToPos(var_16_13, var_16_15, cc.p(lc.cw(var_16_13) - 3, lc.bottom(var_16_14) - 30))

	local var_16_16 = lc.createSprite("img_lock_1")

	var_16_16:setVisible(not P._playerBadgeEx:IsBuyBadge())
	lc.addChildToPos(var_16_13, var_16_16, cc.p(lc.cw(var_16_13) - 5, lc.bottom(var_16_15) - 30))

	arg_16_0._taskBadgeLock = var_16_16

	local var_16_17 = ClientView.createScale9ShaderButton("img_btn_2_s", function(arg_18_0)
		arg_16_0._contentBg:showTab(3, true)
	end, ClientView.CRECT_BUTTON_S, 210, 60)

	var_16_17:addLabel(Str(STR.BUY) .. Str(STR.BADGE_SPRING))
	var_16_17:setVisible(not P._playerBadgeEx:IsBuyBadge())
	lc.addChildToPos(var_16_0, var_16_17, cc.p(180, lc.ch(var_16_17) + 30))

	arg_16_0._buyBtn1 = var_16_17

	local var_16_18 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.TASK_BADGE_TIP_EX))

	var_16_18:setScale(0.9)
	var_16_18:setColor(cc.c3b(148, 226, 255))
	var_16_18:setVisible(not P._playerBadgeEx:IsBuyBadge())
	lc.addChildToPos(var_16_0, var_16_18, cc.p(lc.cw(var_16_0) + 80, lc.h(var_16_18) + 35))

	arg_16_0._tip1 = var_16_18

	local var_16_19 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
		arg_16_0:privilegeShow(arg_16_0._bubble1, arg_16_0._privilegeTxt1)
	end, ClientView.CRECT_BUTTON_S, 210, 60)

	var_16_19:addLabel(Str(STR.ACTIVATE_THEN_PRIVILEGE))
	var_16_19:setVisible(P._playerBadgeEx:IsBuyBadge())
	lc.addChildToPos(var_16_0, var_16_19, cc.p(lc.w(var_16_0) - lc.cw(var_16_19) - 30, lc.ch(var_16_19) + 30), 1)

	arg_16_0._privilegeBtn1 = var_16_19

	local var_16_20 = lc.createSprite({
		_name = "img_tip_bg",
		_crect = cc.rect(37, 30, 1, 85),
		_size = cc.size(320, 210)
	})

	var_16_20:setVisible(false)
	lc.addChildToPos(var_16_19, var_16_20, cc.p(20, lc.h(var_16_19) + lc.ch(var_16_20)))

	arg_16_0._bubble1 = var_16_20

	local var_16_21 = ClientView.createTTF(Str(STR.VOID), ClientView.FontSize.S3, ClientView.COLOR_TEXT_DARK)

	var_16_21:setVisible(false)
	lc.addChildToPos(var_16_19, var_16_21, cc.p(lc.cw(var_16_20) - 140, lc.ch(var_16_20) + 90), 1)

	arg_16_0._privilegeTxt1 = var_16_21
	arg_16_0._freeTaskTable = {}
	arg_16_0._TaskTable = {}

	local function var_16_22(arg_20_0)
		for iter_20_0, iter_20_1 in pairs(Data._battlepassTaskEx) do
			if iter_20_1._period == arg_20_0 and iter_20_1._type == 1 then
				if not arg_16_0._freeTaskTable[tonumber(iter_20_1._releaseDay)] then
					arg_16_0._freeTaskTable[tonumber(iter_20_1._releaseDay)] = {}
				end

				table.insert(arg_16_0._freeTaskTable[tonumber(iter_20_1._releaseDay)], iter_20_1)
			elseif iter_20_1._period == arg_20_0 and iter_20_1._type == 2 then
				if not arg_16_0._TaskTable[tonumber(iter_20_1._releaseDay)] then
					arg_16_0._TaskTable[tonumber(iter_20_1._releaseDay)] = {}
				end

				table.insert(arg_16_0._TaskTable[tonumber(iter_20_1._releaseDay)], iter_20_1)
			end
		end
	end

	var_16_22(P._playerBadgeEx:getCurStage())

	if next(arg_16_0._freeTaskTable) == nil or next(arg_16_0._TaskTable) == nil then
		var_16_22(1)
	end

	arg_16_0._freeTask = {}

	for iter_16_1 = 1, 2 do
		local var_16_23 = lc.createSprite({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35,
			_size = cc.size(860, 80)
		})

		lc.addChildToPos(var_16_0, var_16_23, cc.p(lc.cw(var_16_0) + lc.cw(var_16_10), lc.y(var_16_10) + lc.ch(var_16_23) - 5 - (iter_16_1 - 1) * (lc.h(var_16_23) + 5)))

		local var_16_24 = ClientView.createTTF(Str(arg_16_0._freeTaskTable[1][1]._desSid), nil, cc.c3b(0, 0, 0))

		var_16_24:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_16_23, var_16_24, cc.p(10, lc.h(var_16_23) - lc.sh(var_16_24) / 2 - 5))

		local var_16_25 = ClientView.createLabelProgressBar(200)

		var_16_25:setAnchorPoint(0, 0.5)
		var_16_25._bar:setPercent(33)
		var_16_25._label:setString("1/3")
		lc.addChildToPos(var_16_23, var_16_25, cc.p(10, lc.ch(var_16_25) + 10))

		local var_16_26 = IconWidget.create({
			_count = 50,
			_infoId = Data.ResType.badge_star_ex
		}, IconWidget.DisplayFlag.ITEM_NO_NAME)

		var_16_26:setScale(0.68)
		lc.addChildToPos(var_16_23, var_16_26, cc.p(lc.w(var_16_23) * 0.7, lc.ch(var_16_23) + 3))

		local var_16_27 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_21_0)
			arg_16_0:onClaimStar(arg_21_0)
		end, ClientView.CRECT_BUTTON, 120, 70)

		var_16_27:setDisabledShader(ClientView.SHADER_DISABLE)
		var_16_27:addLabel(Str(STR.CLAIM))
		var_16_27:setVisible(false)
		lc.offset(var_16_27._label, 0, -3)
		lc.addChildToPos(var_16_23, var_16_27, cc.p(lc.w(var_16_23) - lc.cw(var_16_27) - 20, lc.ch(var_16_23) + 7))

		local var_16_28 = lc.createSprite("img_lock_1")

		lc.addChildToPos(var_16_23, var_16_28, cc.p(lc.w(var_16_23) - lc.cw(var_16_27) - 20, lc.ch(var_16_23) + 4))

		var_16_23._taskObj = var_16_24
		var_16_23._pro = var_16_25
		var_16_23._btn = var_16_27
		var_16_23._lock = var_16_28

		table.insert(arg_16_0._freeTask, var_16_23)
	end

	arg_16_0._task = {}

	for iter_16_2 = 1, 3 do
		local var_16_29 = lc.createSprite({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35,
			_size = cc.size(860, 80)
		})

		lc.addChildToPos(var_16_0, var_16_29, cc.p(lc.cw(var_16_0) + lc.cw(var_16_13), lc.y(var_16_13) + lc.h(var_16_29) - (iter_16_2 - 1) * (lc.h(var_16_29) + 5)))

		local var_16_30 = ClientView.createTTF(Str(arg_16_0._TaskTable[1][1]._desSid), nil, cc.c3b(0, 0, 0))

		var_16_30:setAnchorPoint(0, 0.5)
		lc.addChildToPos(var_16_29, var_16_30, cc.p(10, lc.h(var_16_29) - lc.sh(var_16_30) / 2 - 5))

		local var_16_31 = ClientView.createLabelProgressBar(200)

		var_16_31:setAnchorPoint(0, 0.5)
		var_16_31._bar:setPercent(33)
		var_16_31._label:setString("1/3")
		lc.addChildToPos(var_16_29, var_16_31, cc.p(10, lc.ch(var_16_31) + 10))

		local var_16_32 = IconWidget.create({
			_count = 50,
			_infoId = Data.ResType.badge_star_ex
		}, IconWidget.DisplayFlag.ITEM_NO_NAME)

		var_16_32:setScale(0.68)
		lc.addChildToPos(var_16_29, var_16_32, cc.p(lc.w(var_16_29) * 0.7, lc.ch(var_16_29) + 3))

		local var_16_33 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_22_0)
			arg_16_0:onClaimStar(arg_22_0)
		end, ClientView.CRECT_BUTTON, 120, 70)

		var_16_33:setDisabledShader(ClientView.SHADER_DISABLE)
		var_16_33:addLabel(Str(STR.CLAIM))
		lc.offset(var_16_33._label, 0, -3)
		lc.addChildToPos(var_16_29, var_16_33, cc.p(lc.w(var_16_29) - lc.cw(var_16_33) - 20, lc.ch(var_16_29) + 7))
		var_16_33:setVisible(false)

		local var_16_34 = lc.createSprite("img_lock_1")

		lc.addChildToPos(var_16_29, var_16_34, cc.p(lc.w(var_16_29) - lc.cw(var_16_33) - 20, lc.ch(var_16_29) + 4))

		var_16_29._taskObj = var_16_30
		var_16_29._pro = var_16_31
		var_16_29._btn = var_16_33
		var_16_29._lock = var_16_34

		table.insert(arg_16_0._task, var_16_29)
	end

	arg_16_0:updateTask(arg_16_0._weekDay)
end

function var_0_0.updateTask(arg_23_0, arg_23_1)
	arg_23_0._buyBtn1:setVisible(not P._playerBadgeEx:IsBuyBadge())
	arg_23_0._tip1:setVisible(not P._playerBadgeEx:IsBuyBadge())
	arg_23_0._privilegeBtn1:setVisible(P._playerBadgeEx:IsBuyBadge())

	for iter_23_0 = 1, #arg_23_0._days do
		local var_23_0 = arg_23_0._days[iter_23_0]._item

		if iter_23_0 == arg_23_1 then
			var_23_0:setSpriteFrame("img_day_select")
		else
			var_23_0:setSpriteFrame("img_day")
		end
	end

	local var_23_1 = string.format(Str(STR.SHOW_TASK), var_0_6[arg_23_1])

	for iter_23_1 = 1, #arg_23_0._freeTask do
		local var_23_2 = arg_23_0._freeTask[iter_23_1]

		if arg_23_1 > arg_23_0._weekDay then
			var_23_2._taskObj:setString(var_23_1)
			var_23_2._pro:setVisible(false)
			var_23_2._btn:setVisible(false)
			var_23_2._lock:setVisible(true)
		else
			local var_23_3 = arg_23_0._freeTaskTable[arg_23_1][iter_23_1]
			local var_23_4 = P._playerBadgeEx._badgeTask[var_23_3._id]:getValue()

			var_23_2._taskObj:setString(Str(var_23_3._desSid))
			var_23_2._pro._bar:setPercent(var_23_4 / var_23_3._value * 100)
			var_23_2._pro._label:setString(var_23_4 .. "/" .. var_23_3._value)
			var_23_2._pro:setVisible(true)

			var_23_2._btn._taskId = var_23_3._id
			var_23_2._btn._day = arg_23_1

			if var_23_4 >= var_23_3._value then
				var_23_2._btn:setVisible(true)
				var_23_2._lock:setVisible(false)

				if P._playerBadgeEx._badgeTask[var_23_3._id]:isClaim() then
					var_23_2._btn:setEnabled(false)
					var_23_2._btn._label:setString(Str(STR.CLAIMED))
				else
					var_23_2._btn:setEnabled(true)
					var_23_2._btn._label:setString(Str(STR.CLAIM))
				end
			else
				var_23_2._btn:setVisible(false)
				var_23_2._lock:setVisible(true)
			end
		end
	end

	for iter_23_2 = 1, #arg_23_0._task do
		local var_23_5 = arg_23_0._task[iter_23_2]

		if arg_23_1 > arg_23_0._weekDay then
			var_23_5._taskObj:setString(var_23_1)
			var_23_5._pro:setVisible(false)
			var_23_5._btn:setVisible(false)
			var_23_5._lock:setVisible(true)
		else
			local var_23_6 = arg_23_0._TaskTable[arg_23_1][iter_23_2]
			local var_23_7 = P._playerBadgeEx._badgeTask[var_23_6._id]:getValue()

			var_23_5._taskObj:setString(Str(var_23_6._desSid))
			var_23_5._pro._bar:setPercent(var_23_7 / var_23_6._value * 100)
			var_23_5._pro._label:setString(var_23_7 .. "/" .. var_23_6._value)
			var_23_5._pro:setVisible(true)

			var_23_5._btn._taskId = var_23_6._id
			var_23_5._btn._day = arg_23_1

			if P._playerBadgeEx:IsBuyBadge() then
				if var_23_7 >= var_23_6._value then
					var_23_5._btn:setVisible(true)
					var_23_5._lock:setVisible(false)

					if P._playerBadgeEx._badgeTask[var_23_6._id]:isClaim() then
						var_23_5._btn:setEnabled(false)
						var_23_5._btn._label:setString(Str(STR.CLAIMED))
					else
						var_23_5._btn:setEnabled(true)
						var_23_5._btn._label:setString(Str(STR.CLAIM))
					end
				else
					var_23_5._btn:setVisible(false)
					var_23_5._lock:setVisible(true)
				end
			else
				var_23_5._btn:setVisible(false)
				var_23_5._lock:setVisible(true)
			end
		end
	end
end

function var_0_0.addBuyArea(arg_24_0)
	arg_24_0._buyBadgeArea = lc.createNode(var_0_1)

	arg_24_0._buyBadgeArea:setVisible(false)
	lc.addChildToCenter(arg_24_0._contentBg, arg_24_0._buyBadgeArea, -1)

	local var_24_0 = ClientView.createTTF(Str(STR.SELECT_BUY_BADGE, true))

	lc.addChildToCenter(arg_24_0._buyBadgeArea, var_24_0)

	local var_24_1 = lc.createSprite({
		_name = "img_buybadge_bottom",
		_crect = cc.rect(48, 0, 1, 603),
		_size = cc.size(400, 603)
	})
	local var_24_2 = cc.p(lc.cw(arg_24_0._buyBadgeArea), lc.ch(arg_24_0._buyBadgeArea))

	lc.addChildToPos(arg_24_0._buyBadgeArea, var_24_1, var_24_2)

	local var_24_3 = lc.createSprite({
		_name = "img_star_bottom",
		_crect = cc.rect(29, 0, 1, 193),
		_size = cc.size(350, 193)
	})

	lc.addChildToPos(var_24_1, var_24_3, cc.p(lc.cw(var_24_1), lc.h(var_24_1) - lc.ch(var_24_3) - 25))

	local var_24_4 = lc.createSprite("img_gold_badge_ex")

	lc.addChildToPos(var_24_3, var_24_4, cc.p(lc.w(var_24_3) / 2, lc.h(var_24_3) - lc.ch(var_24_4)))

	local var_24_5 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.BADGE_SPRING))

	var_24_5:setScale(0.8)
	var_24_5:setColor(cc.c3b(255, 254, 198))
	lc.addChildToPos(var_24_3, var_24_5, cc.p(lc.w(var_24_3) / 2, lc.ch(var_24_5) + 10))

	local var_24_6 = Str(STR.BUY_BADGE_DESC_3, true)
	local var_24_7 = ClientView.createTTF(var_24_6, ClientView.FontSize.S3)

	var_24_7:setAnchorPoint(cc.p(0, 0.5))
	lc.addChildToPos(var_24_1, var_24_7, cc.p(40, lc.ch(var_24_1) - 60))

	local var_24_8 = ClientView.createScale9ShaderButton("img_btn_1_s", function(arg_25_0)
		ClientView.startIAP(Data.PurchaseType.badge_ex)
	end, ClientView.CRECT_BUTTON, 220, 70)

	var_24_8:addLabel(Str(STR.BUY) .. " " .. Str(STR.RMB) .. ClientData.getPrice(Data.PurchaseType.badge_ex))
	lc.offset(var_24_8._label, 0, -5)
	lc.addChildToPos(var_24_1, var_24_8, cc.p(lc.cw(var_24_1), lc.ch(var_24_8) + 30))

	arg_24_0._buyStarArea = lc.createNode(var_0_1)

	arg_24_0._buyStarArea:setVisible(true)
	lc.addChildToCenter(arg_24_0._contentBg, arg_24_0._buyStarArea, -1)

	for iter_24_0 = 1, 3 do
		local var_24_9 = lc.createSprite({
			_name = "img_buybadge_bottom",
			_crect = cc.rect(48, 0, 1, 603),
			_size = cc.size(310, 603)
		})

		lc.addChildToPos(arg_24_0._buyStarArea, var_24_9, cc.p(lc.w(arg_24_0._buyStarArea) / 5 - 18 + (iter_24_0 - 1) * (lc.w(var_24_9) + 15), lc.ch(arg_24_0._buyStarArea)))

		local var_24_10 = lc.createSprite({
			_name = "img_star_bottom",
			_crect = cc.rect(29, 0, 1, 193),
			_size = cc.size(250, 193)
		})

		lc.addChildToPos(var_24_9, var_24_10, cc.p(lc.cw(var_24_9), lc.h(var_24_9) - lc.ch(var_24_10) - 25))

		local var_24_11 = "img_little_star_ex"

		if iter_24_0 == 2 then
			var_24_11 = "img_mid_star_ex"
		elseif iter_24_0 == 3 then
			var_24_11 = "img_big_star_ex"
		end

		local var_24_12 = lc.createSprite(var_24_11)

		lc.addChildToPos(var_24_10, var_24_12, cc.p(lc.cw(var_24_10), lc.ch(var_24_10) + 10))

		local var_24_13 = ClientView.createBMFont(ClientView.BMFont.huali_26, string.format(Str(STR.BADGE_EX_STAR), 30 * Data._globalInfo._springBadgeUpgradeLevel[iter_24_0]))

		var_24_13:setScale(0.8)
		var_24_13:setColor(cc.c3b(255, 254, 198))
		lc.addChildToPos(var_24_10, var_24_13, cc.p(lc.cw(var_24_10), lc.ch(var_24_13) + 10))

		local var_24_14 = Str(STR.BUY_STAR_DESC_4, true)

		if iter_24_0 == 2 then
			var_24_14 = Str(STR.BUY_STAR_DESC_5, true)
		elseif iter_24_0 == 3 then
			var_24_14 = Str(STR.BUY_STAR_DESC_6, true)
		end

		local var_24_15 = ClientView.createTTF(var_24_14, ClientView.FontSize.S3)

		var_24_15:setAnchorPoint(cc.p(0, 0.5))
		lc.addChildToPos(var_24_9, var_24_15, cc.p(30, lc.ch(var_24_9) - 60))

		local var_24_16 = ClientView.createScale9ShaderButton("img_btn_1_s", function()
			arg_24_0:onBuyBadgeStar(iter_24_0)
		end, ClientView.CRECT_BUTTON, 220, 70)

		var_24_16:addLabel(Str(STR.BUY))
		lc.addChildToPos(var_24_9, var_24_16, cc.p(lc.cw(var_24_9), lc.ch(var_24_16) + 30))
		ClientView.addPriceToBtn(var_24_16, Data._globalInfo._springBadgeUpgradeIngot[iter_24_0], Data.ResType.ingot, 100, 30)
		lc.offset(var_24_16._label, -60, -3)
		lc.offset(var_24_16._resNumLabel, 30, -3)
		lc.offset(var_24_16._resIcon, 30, -3)
	end
end

function var_0_0.addHelpArea(arg_27_0)
	local var_27_0 = Data.getHelpStrsByType(Data.HelpType.badge_ex)
	local var_27_1 = arg_27_0:createTextsList(cc.size(1000, 650), var_27_0)

	lc.addChildToCenter(arg_27_0._contentBg, var_27_1)

	arg_27_0._ruleList = var_27_1
end

function var_0_0.privilegeShow(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = not arg_28_1:isVisible()

	arg_28_1:setVisible(var_28_0)
	arg_28_1:removeAllChildren()

	local var_28_1 = {}

	local function var_28_2(arg_29_0)
		return (ClientView.createTTF(arg_29_0, ClientView.FontSize.S3, ClientView.COLOR_TEXT_DARK))
	end

	if P:getItemCount(Data.PropsId.badge_extend_task_ex) > 0 then
		table.insert(var_28_1, var_28_2(Str(STR.PRIVILEGE_DESC_5)))
	end

	if P:getItemCount(Data.PropsId.hall_star_ex) > 0 then
		table.insert(var_28_1, var_28_2(Str(STR.PRIVILEGE_DESC_6)))
	end

	if P:getItemCount(Data.PropsId.union_star_ex) > 0 then
		table.insert(var_28_1, var_28_2(Str(STR.PRIVILEGE_DESC_7)))
	end

	if #var_28_1 > 0 then
		arg_28_2:setVisible(false)
	else
		arg_28_2:setVisible(var_28_0)
	end

	lc.addNodesToCenterByVertical(arg_28_1, var_28_1, 5, nil, nil, nil, lc.ch(arg_28_1) + 30)
end

function var_0_0.createTextsList(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = lc.List.createV(arg_30_1, 40, 30)

	var_30_0:setAnchorPoint(0.5, 0.5)

	for iter_30_0 = 1, #arg_30_2 do
		local var_30_1 = ccui.Widget:create()

		var_30_1:setContentSize(lc.w(var_30_0) - 80, 0)

		local var_30_2 = ClientView.createTTF(arg_30_2[iter_30_0] .. "\n", ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(lc.w(var_30_1) - 60, 0))

		var_30_1:addChild(var_30_2)
		var_30_1:setContentSize(lc.w(var_30_1), lc.h(var_30_2))
		var_30_2:setPosition(lc.w(var_30_2) / 2 + 40, lc.h(var_30_1) / 2)

		if iter_30_0 < #arg_30_2 then
			local var_30_3 = ClientView.createDividingLine(lc.w(var_30_1), ClientView.COLOR_DIVIDING_LINE_LIGHT)

			var_30_3:setPosition(lc.w(var_30_1) / 2, -12)
			var_30_3:setOpacity(128)
			var_30_1:addChild(var_30_3)
		end

		var_30_0:pushBackCustomItem(var_30_1)
	end

	return var_30_0
end

function var_0_0.hideBottom(arg_31_0)
	arg_31_0._bottom:setVisible(false)
	arg_31_0._badgeArea:setVisible(false)
	arg_31_0._taskArea:setVisible(false)
	arg_31_0._buyBadgeArea:setVisible(false)
	arg_31_0._buyStarArea:setVisible(false)
	arg_31_0._ruleList:setVisible(false)
end

function var_0_0.showTab(arg_32_0, arg_32_1)
	arg_32_0:hideBottom()
	arg_32_0._frameBgEx:setVisible(false)

	if arg_32_1 == 1 then
		arg_32_0._badgeArea:setVisible(true)
		arg_32_0._frameBg:setVisible(true)
		arg_32_0._bottom:setVisible(true)
		arg_32_0:updateRewardList()
	elseif arg_32_1 == 2 then
		arg_32_0._taskArea:setVisible(true)
		arg_32_0._frameBg:setVisible(true)
		arg_32_0._bottom:setVisible(true)
		arg_32_0:updateTask(arg_32_0._weekDay)
	elseif arg_32_1 == 3 then
		arg_32_0._frameBgEx:setVisible(true)
		arg_32_0._buyStarArea:setVisible(P._playerBadgeEx:IsBuyBadge())
		arg_32_0._buyBadgeArea:setVisible(not P._playerBadgeEx:IsBuyBadge())
	elseif arg_32_1 == 4 then
		arg_32_0._ruleList:setVisible(true)
	end

	arg_32_0:setCameraMask(ClientData.CAMERA_2D_FLAG)
end

function var_0_0.onClaim(arg_33_0, arg_33_1)
	local var_33_0 = ClientData.claimBonus(arg_33_1._bonus)

	if var_33_0 == Data.ErrorType.ok then
		arg_33_1:setEnabled(false)
		arg_33_1._label:setString(Str(STR.CLAIMED))
		ClientView.showClaimBonusResult(arg_33_1._bonus, var_33_0)
		lc.sendEvent(Data.Event.badge_reward_ex)
	end
end

function var_0_0.onClaimAll(arg_34_0)
	local var_34_0 = P._playerBonus._bonusBadgeEx
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		if ClientData.claimBonus(iter_34_1) == Data.ErrorType.ok then
			local var_34_2 = iter_34_1._info

			for iter_34_2, iter_34_3 in ipairs(var_34_2._rid) do
				var_34_1[iter_34_3] = (var_34_1[iter_34_3] or 0) + var_34_2._count[iter_34_2]
			end
		end
	end

	if next(var_34_1) then
		local var_34_3 = {}

		for iter_34_4, iter_34_5 in pairs(var_34_1) do
			var_34_3[#var_34_3 + 1] = {
				_infoId = iter_34_4,
				_count = iter_34_5
			}
		end

		local var_34_4 = require("RewardPanel")

		var_34_4.create(var_34_3, var_34_4.MODE_CLAIM_ALL):show()
		lc.sendEvent(Data.Event.badge_reward_ex)
		arg_34_0:updateRewardList()
	else
		ToastManager.push(Str(STR.NOTHING_TO_CLAIM))
	end
end

function var_0_0.onClaimStar(arg_35_0, arg_35_1)
	arg_35_1:setEnabled(false)
	arg_35_1._label:setString(Str(STR.CLAIMED))
	P._playerBadgeEx._badgeTask[arg_35_1._taskId]:setClaim(true)

	local var_35_0, var_35_1 = P._playerBadgeEx:getDayStar(arg_35_1._day)

	arg_35_0._days[arg_35_1._day]._txtObj:setString(var_35_0 .. "/" .. var_35_1)
	ClientData.sendClaimActivityBonus(arg_35_1._taskId)

	local var_35_2 = Data._battlepassTaskEx[arg_35_1._taskId]._num + P:getItemCount(Data.PropsId.badge_extend_task_ex) * 6

	require("RewardPanel").create({
		{
			_infoId = Data.ResType.badge_star_ex,
			_num = var_35_2
		}
	}):show()
	lc.sendEvent(Data.Event.badge_reward_ex)
end

function var_0_0.onBuyBadgeStar(arg_36_0, arg_36_1)
	if P._playerBadgeEx:getGrade() >= 100 then
		return ToastManager.push(Str(STR.MAX_BADGE_GRADE))
	end

	if P:hasResource(Data.ResType.ingot, Data._globalInfo._springBadgeUpgradeIngot[arg_36_1]) then
		P:addResource(Data.ResType.ingot, 0, -Data._globalInfo._springBadgeUpgradeIngot[arg_36_1])
		ClientData.sendBuyBadgeExStar(arg_36_1)
		ToastManager.push(Str(STR.BUYSUCCESS))

		local var_36_0 = Data._globalInfo._springBadgeUpgradeLevel[arg_36_1] * P._playerBadgeEx:getStarTotal()

		require("RewardPanel").create({
			{
				_infoId = Data.ResType.badge_star_ex,
				_num = var_36_0
			}
		}):show()
		lc.sendEvent(Data.Event.badge_reward_ex)
	else
		ToastManager.push(Str(STR.NOT_ENOUGH_INGOT))
	end
end

function var_0_0.onEnter(arg_37_0)
	var_0_0.super.onEnter(arg_37_0)
	arg_37_0:setCameraMask(ClientData.CAMERA_2D_FLAG)
	arg_37_0:updateBadgeFlag()
	arg_37_0:updateTaskFlag()
	arg_37_0:updateTaskTabFlag()

	arg_37_0._listeners = {}

	table.insert(arg_37_0._listeners, lc.addEventListener(Data.Event.badge_reward_ex, function(arg_38_0)
		if arg_38_0._param then
			arg_37_0._contentBg:showTab(1, true)
			arg_37_0._lock:setVisible(false)
			arg_37_0._taskBadgeLock:setVisible(false)
		end

		arg_37_0:updateBadgeFlag()
		arg_37_0:updateTaskFlag()
		arg_37_0:updateTaskTabFlag()
	end))
end

function var_0_0.onExit(arg_39_0)
	var_0_0.super.onExit(arg_39_0)

	for iter_39_0, iter_39_1 in ipairs(arg_39_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_39_1)
	end

	ClientData.removeMsgListener(arg_39_0)
end

function var_0_0.hide(arg_40_0)
	var_0_0.super.hide(arg_40_0)
end

function var_0_0.onCleanup(arg_41_0)
	var_0_0.super.onCleanup(arg_41_0)
	ClientData.unloadLCRes(arg_41_0._resNames)
	lc.TextureCache:removeTextureForKey("res/jpg/img_badge_bg_ex.jpg")
end

function var_0_0.updateBadgeFlag(arg_42_0)
	local var_42_0 = P._playerBadgeEx:getBadgeClaimFlag()

	ClientView.checkNewFlag(arg_42_0._contentBg._tabs[1], var_42_0, 15, -15)
end

function var_0_0.updateTaskFlag(arg_43_0)
	local var_43_0 = P._playerBadgeEx:getTaskClaimFlag()

	ClientView.checkNewFlag(arg_43_0._contentBg._tabs[2], var_43_0, 15, -15)
end

function var_0_0.updateTaskTabFlag(arg_44_0)
	for iter_44_0 = 1, #arg_44_0._days do
		local var_44_0 = arg_44_0._days[iter_44_0]
		local var_44_1 = P._playerBadgeEx:getOneDayTaskClaimFlag(iter_44_0)

		ClientView.checkNewFlag(var_44_0, var_44_1, 15, -5)
	end
end

function var_0_0.onMsg(arg_45_0, arg_45_1)
	if arg_45_1.type == SglMsgType_pb.PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS then
		if arg_45_0._indicator then
			arg_45_0._indicator:removeFromParent()

			arg_45_0._indicator = nil
		end

		arg_45_0._contentBg:showTab(1, true)
	end

	return false
end

return var_0_0
