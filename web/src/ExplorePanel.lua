local var_0_0 = class("ExplorePanel", BasePanel)

var_0_0.PlayerType = {
	boss = 2,
	npc = 1
}

local var_0_1 = Data._globalInfo._SurvivalExploreMaxTime

function var_0_0.create(...)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(...)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, true)

	arg_2_0._isEx = arg_2_1

	local var_2_0 = lc.createSprite("res/jpg/copy_bg.jpg")

	lc.addChildToCenter(arg_2_0, var_2_0)

	local var_2_1 = ClientView.createLabelProgressBar(300)

	lc.addChildToPos(arg_2_0, var_2_1, cc.p(lc.cw(arg_2_0), lc.ch(var_2_1)))

	var_2_1._seconds = Data._globalInfo._SurvivalExploreMaxTime

	var_2_1:runAction(lc.rep(lc.sequence(function()
		local var_3_0 = var_2_1._seconds / Data._globalInfo._SurvivalExploreMaxTime * 100

		var_2_1._bar:setPercent(var_3_0)
		var_2_1._label:setString(var_2_1._seconds .. "S")

		var_2_1._seconds = var_2_1._seconds - 1

		if var_2_1._seconds < 0 then
			var_2_1:stopAllActions()
		end
	end, 1)))

	local var_2_2 = ClientView.createTTF("", ClientView.FontSize.S1)
	local var_2_3 = Str(STR.EXPORE_TIP)

	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.cw(arg_2_0), lc.top(var_2_1) + 30))
	var_2_2:runAction(lc.rep(lc.sequence(function()
		var_2_2:setString(var_2_3 .. ".")
	end, 1, function()
		var_2_2:setString(var_2_3 .. "..")
	end, 1, function()
		var_2_2:setString(var_2_3 .. "...")
	end, 1)))
	arg_2_0:updatePlayers()

	if arg_2_0._isEx then
		ClientData.sendSurvivalExExploreStart()
	else
		ClientData.sendSurvivalExploreStart()
	end
end

function var_0_0.updatePlayers(arg_7_0)
	local var_7_0 = {
		2,
		3,
		4,
		5,
		7,
		10,
		12,
		14
	}

	arg_7_0._playerInfos = {}

	local var_7_1 = arg_7_0._isEx and P._playerFindSurvivalEx._hallUserNum or P._playerFindSurvival._hallUserNum

	for iter_7_0 = 1, var_7_1 do
		arg_7_0._playerInfos[iter_7_0] = {
			_type = 1,
			_avatar = var_7_0[math.random(1, #var_7_0)],
			_level = 3 - math.min(math.max(math.log(var_7_1) / math.log(2) - 2, 0), 3),
			_randomSeed = ClientData.getCurrentTime()
		}
	end

	arg_7_0._playerItems = {}

	for iter_7_1 = 1, #arg_7_0._playerInfos do
		local var_7_2 = arg_7_0._playerInfos[iter_7_1]

		table.insert(arg_7_0._playerItems, arg_7_0:createPlayerItem(var_7_2))
	end
end

function var_0_0.calRandomPos(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2 = arg_8_2 or 0

	local function var_8_0()
		arg_8_1 = (arg_8_1 * 1103515245 + 12345) % 65536

		return arg_8_1 / 65536
	end

	local var_8_1 = var_8_0() * lc.w(arg_8_0)
	local var_8_2 = math.max(var_8_0() * lc.h(arg_8_0) - 150, 90)

	if arg_8_2 > 50 then
		return cc.p(var_8_1, var_8_2)
	end

	for iter_8_0 = 1, #arg_8_0._playerItems do
		local var_8_3 = arg_8_0._playerItems[iter_8_0]._position

		if math.abs(var_8_3.x - var_8_1) < 50 and math.abs(var_8_3.y - var_8_2) < 50 then
			return arg_8_0:calRandomPos(arg_8_1, arg_8_2 + 1)
		end
	end

	return cc.p(var_8_1, var_8_2)
end

function var_0_0.createPlayerItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:calRandomPos(arg_10_1._randomSeed)
	local var_10_1 = ClientView.SCR_H - var_10_0.y
	local var_10_2 = string.format("img_expedition_avatar_%02d", arg_10_1._avatar)

	if ClientData.isAnotherSkin() and lc.FrameCache:getSpriteFrame(var_10_2 .. "_2") then
		var_10_2 = var_10_2 .. "_2"
	elseif ClientData.isAnotherCardImageSkin() and lc.FrameCache:getSpriteFrame(var_10_2 .. "_3") then
		var_10_2 = var_10_2 .. "_3"
	end

	local var_10_3 = string.format("img_expedition_mark_%02d", arg_10_1._level or 3)
	local var_10_4 = string.format("img_expedition_bottom_%02d", arg_10_1._level or 3)
	local var_10_5 = ClientView.createShaderButton(nil)

	var_10_5:setZoomScale(0)
	var_10_5:setPosition(var_10_0)
	var_10_5:setLocalZOrder(var_10_1)
	arg_10_0:addChild(var_10_5)

	var_10_5._position = var_10_0

	local var_10_6 = lc.createSprite(var_10_3)

	var_10_5:setContentSize(cc.size(lc.w(var_10_6) + 16, lc.h(var_10_6) + 16))
	var_10_5:setAnchorPoint(cc.p(0.5, 0))
	lc.addChildToCenter(var_10_5, var_10_6)

	var_10_6._pos = cc.p(var_10_6:getPosition())

	local var_10_7 = lc.createSprite(var_10_2)
	local var_10_8 = cc.p(lc.cw(var_10_6) + 2, lc.h(var_10_6) - lc.ch(var_10_7) + 6)

	if arg_10_1._type == var_0_0.PlayerType.boss then
		var_10_8.y = var_10_8.y - 32
	end

	lc.addChildToPos(var_10_6, var_10_7, var_10_8)

	var_10_7._posY = var_10_7:getPositionY()

	var_10_6:runAction(lc.rep(lc.sequence(lc.moveTo(0.5, cc.p(var_10_6._pos.x, var_10_6._pos.y - 5)), lc.moveTo(0.5, cc.p(var_10_6._pos.x, var_10_6._pos.y + 5)))))

	local var_10_9 = lc.createSprite(var_10_4)

	lc.addChildToPos(var_10_5, var_10_9, cc.p(lc.cw(var_10_5), -10), -1)

	return var_10_5
end

function var_0_0.onEnter(arg_11_0)
	var_0_0.super.onEnter(arg_11_0)

	local var_11_0 = {}

	arg_11_0._listeners = var_11_0

	if arg_11_0._isEx then
		var_11_0[#var_11_0 + 1] = lc.addEventListener(Data.Event.survival_ex_explore_end, function()
			arg_11_0:hide()
		end)
	else
		var_11_0[#var_11_0 + 1] = lc.addEventListener(Data.Event.survival_explore_end, function()
			arg_11_0:hide()
		end)
	end

	ClientView._explorePanel = arg_11_0
end

function var_0_0.onExit(arg_14_0)
	var_0_0.super.onExit(arg_14_0)
	ClientData.removeMsgListener(arg_14_0)

	ClientView._explorePanel = nil

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_14_1)
	end
end

function var_0_0.hide(arg_15_0)
	var_0_0.super.hide(arg_15_0)
end

return var_0_0
