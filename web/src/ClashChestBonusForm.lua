local var_0_0 = class("ClashChestBonusForm", BaseForm)
local var_0_1 = cc.size(880, 680)
local var_0_2 = 200
local var_0_3 = cc.size(800, 300)

var_0_0.Tab = {
	season = 2,
	daily = 1
}

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.BONUS), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_0 = lc.createSprite("res/jpg/daily_target_bg.jpg")

	lc.addChildToCenter(arg_2_0._frame, var_2_0, -1)

	arg_2_0._bg = var_2_0

	local var_2_1 = {
		{
			_index = var_0_0.Tab.daily,
			_str = Str(STR.DAILY_TARGET)
		},
		{
			_index = var_0_0.Tab.season,
			_str = Str(STR.SEASON_TARGET)
		}
	}

	ClientView.addVerticalTabButtons(arg_2_0._form, {
		Str(STR.DAILY_TARGET),
		Str(STR.SEASON_TARGET)
	}, lc.h(arg_2_0._frame) - ClientView.FRAME_INNER_TOP - ClientView.FRAME_INNER_BOTTOM, lc.left(arg_2_0._frame) - 124)

	function arg_2_0._form.showTab(arg_3_0, arg_3_1)
		arg_3_0._tabArea:showTab(arg_3_1)

		if arg_3_1 == var_0_0.Tab.daily then
			arg_2_0._bar:setVisible(true)
			arg_2_0._seasonBar:setVisible(false)
			arg_2_0._winNode:setVisible(true)
			arg_2_0._pointNode:setVisible(false)
		elseif arg_3_1 == var_0_0.Tab.season then
			arg_2_0._bar:setVisible(false)
			arg_2_0._seasonBar:setVisible(true)
			arg_2_0._winNode:setVisible(false)
			arg_2_0._pointNode:setVisible(true)
		end

		arg_2_0:addChest()
	end

	local var_2_2 = lc.createNode()

	lc.addChildToPos(arg_2_0._bg, var_2_2, cc.p(lc.cw(arg_2_0._bg), 50))

	arg_2_0._pointNode = var_2_2

	local var_2_3 = ClientView.createTTF(Str(STR.TROPHY_SEASON_MAX) .. ":", ClientView.FontSize.M2)
	local var_2_4 = lc.createSprite(string.format("img_icon_res%d_s", Data.ResType.clash_trophy))
	local var_2_5 = lc.createSprite({
		_name = "img_com_bg_57",
		_crect = ClientView.CRECT_COM_BG57,
		_size = cc.size(80, 40)
	})
	local var_2_6 = ClientView.createTTF(P._playerFindClash._trophy, ClientView.FontSize.M2)

	var_2_6:setAnchorPoint(0, 0.5)
	lc.addChildToCenter(var_2_5, var_2_6)

	arg_2_0._pointLabel = var_2_6

	lc.addNodesToCenter(var_2_2, {
		var_2_3,
		var_2_4,
		var_2_5
	}, 10)

	local var_2_7 = lc.createNode()

	lc.addChildToPos(arg_2_0._bg, var_2_7, cc.p(lc.cw(arg_2_0._bg), 50))

	arg_2_0._winNode = var_2_7

	local var_2_8 = lc.createSprite({
		_name = "img_com_bg_57",
		_crect = ClientView.CRECT_COM_BG57,
		_size = cc.size(80, 40)
	})
	local var_2_9 = ClientView.createTTF(Str(STR.WIN_CONTINOUS_TODAY_MAX) .. ":", ClientView.FontSize.M2)

	lc.addNodesToCenter(var_2_7, {
		var_2_9,
		var_2_8
	}, 0)

	arg_2_0._winTitle = var_2_9

	local var_2_10 = ClientView.createTTF(P._ladderContLose == 1 and 0 or P._dailyClashWin, ClientView.FontSize.M2)

	var_2_10:setAnchorPoint(1, 0.5)
	lc.addChildToCenter(var_2_8, var_2_10)

	arg_2_0._winLabel = var_2_10

	local var_2_11 = P._playerBonus._bonusDailyActive

	arg_2_0:createBar()
	arg_2_0:createSeasonBar()

	local var_2_12 = lc.createNode()

	lc.addChildToPos(arg_2_0._bg, var_2_12, cc.p(lc.cw(arg_2_0._bg) - 5, lc.ch(arg_2_0._bg) + 5), 2)

	arg_2_0._chestNode = var_2_12

	arg_2_0._form:showTab(arg_2_1 or var_0_0.Tab.daily)
	arg_2_0:addChest()
	arg_2_0._form:setContentSize(lc.w(arg_2_0._form) - 130, lc.h(arg_2_0._form))
end

function var_0_0.addChest(arg_4_0)
	arg_4_0._chestNode:removeAllChildren()

	local function var_4_0(arg_5_0)
		return P._playerFindClash:getChestGrade(arg_5_0), arg_5_0, Data.CardQuality.UR
	end

	if arg_4_0._bar:isVisible() and not arg_4_0._seasonBar:isVisible() then
		local var_4_1 = #P._playerFindClash._chests
		local var_4_2 = P._playerFindClash._chests[var_4_1]

		for iter_4_0, iter_4_1 in ipairs(P._playerFindClash._chests) do
			if not iter_4_1._prop._isOpened then
				var_4_1 = iter_4_0
				var_4_2 = iter_4_1

				break
			end
		end

		local var_4_3

		if var_4_1 == 0 or var_4_2._prop._isOpened and var_4_1 < 5 then
			var_4_3 = ClientView.createClashFieldChest(var_4_0(var_4_1 + 1))
		else
			var_4_3 = ClientView.createClashFieldChest(var_4_2._grade, var_4_1, Data.CardQuality.UR)
		end

		var_4_3._bones:setScale(0.6)
		arg_4_0._chestNode:addChild(var_4_3)
	else
		local var_4_4 = ClientView.createClashTargetChest(P:getClashTargetStep())

		var_4_4._bones:setScale(0.6)
		arg_4_0._chestNode:addChild(var_4_4)
	end
end

function var_0_0.createBar(arg_6_0)
	local var_6_0 = {}

	for iter_6_0 = 1, 5 do
		table.insert(var_6_0, {
			_lightSpr = "light_point_big",
			_darkSpr = "dark_point_big"
		})
	end

	local var_6_1 = ClientView.createClashChestProgressBar(var_6_0)

	lc.addChildToPos(arg_6_0._bg, var_6_1, cc.p(lc.cw(arg_6_0._bg) - 5, lc.ch(arg_6_0._bg) + 25))

	arg_6_0._bar = var_6_1

	var_6_1.updateWithAni()
end

function var_0_0.createSeasonBar(arg_7_0)
	local var_7_0 = {
		{
			_lightSpr = "light_point_big",
			_darkSpr = "dark_point_big",
			_val = Data._globalInfo._playerTitleTrophy[2]
		}
	}
	local var_7_1 = P._playerBonus._bonusClashTarget

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		table.insert(var_7_0, {
			_lightSpr = "light_point_big",
			_darkSpr = "dark_point_big",
			_val = iter_7_1._info._val
		})
	end

	local var_7_2 = ClientView.createClashSeasonProgressBar(var_7_0, 800)

	lc.addChildToPos(arg_7_0._bg, var_7_2, cc.p(lc.cw(arg_7_0._bg) - 5, lc.ch(arg_7_0._bg) + 25))

	arg_7_0._seasonBar = var_7_2

	var_7_2.updateWithAni(P._playerBonus._bonusClashTarget[1]._value)
end

function var_0_0.refreshView(arg_8_0)
	arg_8_0._pointLabel:setString(P._playerBonus._bonusClashTarget[1]._value)
	arg_8_0._winLabel:setString(#P._playerFindClash._chests)

	if arg_8_0._bar then
		arg_8_0._bar.updateWithAni()
	end

	if arg_8_0._seasonBar then
		arg_8_0._seasonBar.updateWithAni(P._playerBonus._bonusClashTarget[1]._value)
	end

	arg_8_0:addChest()
end

function var_0_0.onMsg(arg_9_0, arg_9_1)
	if arg_9_1.type == SglMsgType_pb.PB_TYPE_USER_OPEN_CHEST then
		local var_9_0 = arg_9_1.Extensions[User_pb.SglUserMsg.user_open_chest_resp]
		local var_9_1 = ClientView.getActiveIndicator():hide()

		P._propBag._props[var_9_1._infoId]._isOpened = true

		var_9_1:update(P._playerFindClash:getChestGrade(var_9_1._infoId % 10))
		P._propBag._props[var_9_1._infoId]:sendPropDirty()

		local var_9_2 = require("RewardPanel")

		var_9_2.create(var_9_0, var_9_2.MODE_CHEST):show()
		arg_9_0:addChest()

		return true
	end

	return false
end

function var_0_0.onEnter(arg_10_0)
	var_0_0.super.onEnter(arg_10_0)
	ClientData.addMsgListener(arg_10_0, function(arg_11_0)
		return arg_10_0:onMsg(arg_11_0)
	end, 0)
	arg_10_0:refreshView()

	arg_10_0._listeners = {}

	table.insert(arg_10_0._listeners, lc.addEventListener(Data.Event.prop_dirty, function(arg_12_0)
		arg_10_0:refreshView()
	end))
	table.insert(arg_10_0._listeners, lc.addEventListener(Data.Event.trophy_dirty, function(arg_13_0)
		arg_10_0:refreshView()
	end))
	table.insert(arg_10_0._listeners, lc.addEventListener(Data.Event.clash_trophy_dirty, function(arg_14_0)
		arg_10_0:refreshView()
	end))
	table.insert(arg_10_0._listeners, lc.addEventListener(Data.Event.bonus_dirty, function(arg_15_0)
		if arg_15_0._data._type == Data.BonusType.clash_target then
			arg_10_0:refreshView()
		end
	end))
end

function var_0_0.onExit(arg_16_0)
	var_0_0.super.onExit(arg_16_0)
	ClientData.removeMsgListener(arg_16_0)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_16_1)
	end
end

function var_0_0.onCleanup(arg_17_0)
	ClientView.getMenuUI():updateDailyActiveFlag()
	var_0_0.super.onCleanup(arg_17_0)
	lc.TextureCache:removeTextureForKey("res/jpg/daily_target_bg.jpg")
	lc.TextureCache:removeTextureForKey("res/jpg/daily_target_progress.jpg")
end

return var_0_0
