local var_0_0 = class("DateBonusItem", lc.ExtendUIWidget)

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setContentSize(arg_1_0)
	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._bonus = arg_2_2

	arg_2_0:setCascadeColorEnabled(true)
	arg_2_0:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 == ccui.TouchEventType.ended and arg_2_0._claimHandler ~= nil then
			arg_2_0._claimHandler(arg_2_2)
		end
	end)

	local var_2_0 = IconWidget.createByBonus(arg_2_2._info, 1)

	var_2_0._name:setColor(lc.Color3B.white)
	lc.addChildToCenter(arg_2_0, var_2_0)

	if arg_2_2._checkinInfo and arg_2_2._checkinInfo._vip > 0 then
		var_2_0._name:setVisible(false)

		local var_2_1 = lc.createSprite({
			_name = "img_com_bg_34",
			_crect = ClientView.CRECT_COM_BG34,
			_size = cc.size(100, ClientView.CRECT_COM_BG34.height)
		})

		lc.addChildToPos(var_2_0, var_2_1, cc.p(var_2_0._name:getPosition()))

		local var_2_2 = ClientView.createTTF(string.format("V%d %s", arg_2_2._checkinInfo._vip, Str(STR.DOUBLE)), ClientView.FontSize.S1, lc.Color3B.yellow)

		var_2_2:setScale(0.7)
		lc.addChildToPos(var_2_1, var_2_2, cc.p(lc.w(var_2_1) / 2, lc.sh(var_2_1) / 2 + 2))
	end

	arg_2_0._icon = var_2_0
end

function var_0_0.onEnter(arg_4_0)
	arg_4_0._listener = lc.addEventListener(Data.Event.bonus_dirty, function(arg_5_0)
		if arg_5_0._data._type == arg_4_0._bonus._type then
			arg_4_0:updateView()
		end
	end)

	arg_4_0:updateView()
end

function var_0_0.onExit(arg_6_0)
	lc.Dispatcher:removeEventListener(arg_6_0._listener)
end

function var_0_0.registerClaimHandler(arg_7_0, arg_7_1)
	arg_7_0._claimHandler = arg_7_1
end

function var_0_0.updateView(arg_8_0)
	local var_8_0

	if arg_8_0._bonus._isClaimed then
		var_8_0 = cc.Sprite:createWithSpriteFrameName("activity5_img_claimed")

		var_8_0:setPosition(lc.w(var_8_0) / 2, lc.h(arg_8_0) - lc.h(var_8_0) / 2)
		arg_8_0:setTouchEnabled(false)
		arg_8_0._icon:setEnabled(false)
	elseif arg_8_0._bonus._value >= arg_8_0._bonus._info._val then
		var_8_0 = cc.Sprite:createWithSpriteFrameName("activity5_rect_claimable")

		var_8_0:setPosition(lc.w(arg_8_0) / 2, lc.h(arg_8_0) / 2 + 15)
		arg_8_0:setTouchEnabled(true)
		arg_8_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
		arg_8_0._icon:setTouchEnabled(false)
	else
		local var_8_1 = false
		local var_8_2 = P._playerBonus._bonusMonthCheckin

		for iter_8_0 = 1, #var_8_2 do
			if var_8_2[iter_8_0]._value >= var_8_2[iter_8_0]._info._val and not var_8_2[iter_8_0]._isClaimed then
				var_8_1 = true

				break
			end
		end

		if P._dayOfMonth >= arg_8_0._bonus._info._val and arg_8_0._bonus._info._val - arg_8_0._bonus._value == 1 and not var_8_1 then
			var_8_0 = lc.createSprite("activity5_img_supply")

			var_8_0:setOpacity(250)
			var_8_0:setPosition(lc.w(arg_8_0) / 2, lc.h(arg_8_0) - 22)

			local var_8_3 = ClientView.createTTF(Str(STR.CHECKIN_RETRY), ClientView.FontSize.S2, lc.Color3B.yellow)

			lc.addChildToCenter(var_8_0, var_8_3)
			arg_8_0:setTouchEnabled(true)
			arg_8_0:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
			arg_8_0._icon:setTouchEnabled(false)
		else
			arg_8_0:setTouchEnabled(false)
			arg_8_0._icon:setTouchEnabled(true)
			arg_8_0._icon:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
		end
	end

	if var_8_0 == nil then
		return
	end

	if arg_8_0._flag ~= nil then
		arg_8_0._flag:removeFromParent()
	end

	arg_8_0._flag = var_8_0

	arg_8_0:addChild(arg_8_0._flag)
end

local var_0_1 = class("MonthCheckin", lc.ExtendUIWidget)
local var_0_2 = 7
local var_0_3 = 136

function var_0_1.create(arg_9_0, arg_9_1)
	local var_9_0 = var_0_1.new(lc.EXTEND_LAYOUT)

	var_9_0:setContentSize(arg_9_1)
	var_9_0:setAnchorPoint(0.5, 0.5)
	var_9_0:init(arg_9_0)

	return var_9_0
end

function var_0_1.init(arg_10_0, arg_10_1)
	_, _, arg_10_0._month, arg_10_0._year = ClientData.getServerDate()

	local var_10_0 = "activity_top"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_10_0 .. "_2")) then
		var_10_0 = var_10_0 .. "_2"
	end

	if ClientData.isAnotherSkin2() and lc.File:isFileExist(lc.formatJpg(var_10_0 .. "_3")) then
		var_10_0 = var_10_0 .. "_3"
	end

	local var_10_1 = lc.createSprite(lc.formatJpg(var_10_0))

	lc.addChildToPos(arg_10_0, var_10_1, cc.p(lc.w(arg_10_0) / 2, lc.h(arg_10_0) - lc.h(var_10_1) / 2))

	local var_10_2 = ClientView.createCheckinTitle(string.format(Str(STR.MONTH_REGISTER), arg_10_0._month), 0)

	lc.addChildToPos(arg_10_0, var_10_2, cc.p(lc.w(arg_10_0) / 2 + 140, lc.h(arg_10_0) - lc.h(var_10_2) / 2 - 24))

	local var_10_3 = ClientView.createTTF(string.format(Str(STR.MONTH_REGISTER_NUM), 0), ClientView.FontSize.S3, ClientView.COLOR_TEXT_DARK)
	var_10_3:setScale(0.8)

	lc.addChildToPos(arg_10_0, var_10_3, cc.p(lc.x(var_10_2), lc.bottom(var_10_2) - lc.h(var_10_3) / 2 - 12))

	arg_10_0._checkinNum = var_10_3

	local var_10_4 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = cc.size(lc.w(arg_10_0) - 20, 390)
	})

	lc.addChildToPos(arg_10_0, var_10_4, cc.p(lc.w(arg_10_0) / 2, lc.h(var_10_4) / 2))

	local var_10_5 = lc.List.createV(cc.size(lc.w(var_10_4) - 32, lc.h(var_10_4) - 20), 16, 10)

	lc.addChildToPos(var_10_4, var_10_5, cc.p(16, 10))

	arg_10_0._list = var_10_5

	local var_10_6 = math.ceil(arg_10_0:getDaysOfMonth(arg_10_0._month) / var_0_2)

	for iter_10_0 = 1, var_10_6 do
		local var_10_7 = arg_10_0:createItem(cc.size(lc.w(var_10_5), var_0_3), iter_10_0)

		var_10_5:pushBackCustomItem(var_10_7)
	end
end

function var_0_1.createItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = ccui.Widget:create()

	var_11_0:setContentSize(arg_11_1)

	local var_11_1 = P._playerBonus._bonusMonthCheckin

	table.sort(var_11_1, function(arg_12_0, arg_12_1)
		return arg_12_0._infoId < arg_12_1._infoId
	end)

	local var_11_2 = cc.size(arg_11_1.width / var_0_2, arg_11_1.height)

	for iter_11_0 = 1, var_0_2 do
		local var_11_3 = (arg_11_2 - 1) * var_0_2 + iter_11_0

		if var_11_3 > arg_11_0:getDaysOfMonth(arg_11_0._month) then
			break
		end

		local var_11_4 = var_11_1[var_11_3]

		if var_11_4 ~= nil then
			local var_11_5 = var_0_0.create(var_11_2, var_11_3, var_11_4)

			var_11_5:registerClaimHandler(function(arg_13_0)
				arg_11_0:claimBonus(arg_13_0)
			end)
			lc.addChildToPos(var_11_0, var_11_5, cc.p((iter_11_0 - 0.5) * lc.w(var_11_5), lc.h(var_11_0) / 2))
		end
	end

	return var_11_0
end

function var_0_1.onEnter(arg_14_0)
	arg_14_0:updateView()
end

function var_0_1.onExit(arg_15_0)
	return
end

function var_0_1.claimBonus(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1._checkinInfo then
		if arg_16_1._checkinInfo._vip > 0 and P._vip >= arg_16_1._checkinInfo._vip then
			arg_16_1._multiple = 2
		else
			arg_16_1._multiple = nil
		end
	end

	local var_16_0 = Data.ErrorType.error

	if not arg_16_1._isClaimed then
		if arg_16_1._value >= arg_16_1._info._val then
			var_16_0 = P._playerBonus:claimBonus(arg_16_1._infoId)

			if var_16_0 == Data.ErrorType.ok then
				ClientData.sendClaimBonus(arg_16_1._infoId)
			end
		elseif P._dayOfMonth >= arg_16_1._info._val and arg_16_1._info._val - arg_16_1._value == 1 then
			if arg_16_2 then
				var_16_0 = P._playerBonus:supplyMonthCheckinBonus(arg_16_1._infoId)

				if var_16_0 == Data.ErrorType.ok then
					ClientData.sendSupplyMonthCheckinBonus(arg_16_1._infoId)
				elseif var_16_0 == Data.ErrorType.need_more_ingot then
					require("PromptForm").ConfirmBuyIngot.create():show()
				end
			else
				local var_16_1 = math.min(10 + P._monthlyRecheck * 10, Data._globalInfo._maxRecheckIngot)

				require("Dialog").showDialog(string.format(Str(STR.SURE_TO_SUPPLY), var_16_1), function()
					arg_16_0:claimBonus(arg_16_1, true)
				end)
			end
		end
	end

	if var_16_0 == Data.ErrorType.ok then
		arg_16_0:updateView()

		local var_16_2 = require("RewardPanel")

		var_16_2.create(arg_16_1, var_16_2.MODE_CLAIM):show()
		lc.Audio.playAudio(AUDIO.E_CLAIM)
	elseif var_16_0 == Data.ErrorType.need_more_ingot then
		require("PromptForm").ConfirmBuyIngot.create():show()
	elseif var_16_0 == Data.ErrorType.claimed then
		ToastManager.push(Str(STR.CLAIMED) .. Str(STR.BONUS))
	elseif var_16_0 == Data.ErrorType.claim_not_support then
		ToastManager.push(Str(STR.CANNOT_CLAIM) .. Str(STR.BONUS))
	end
end

function var_0_1.getDaysOfMonth(arg_18_0, arg_18_1)
	if arg_18_1 == 2 then
		if arg_18_0._year % 400 == 0 or arg_18_0._year % 4 == 0 and arg_18_0._year % 100 ~= 0 then
			return 29
		else
			return 28
		end
	elseif arg_18_1 <= 7 then
		return arg_18_1 % 2 == 0 and 30 or 31
	else
		return arg_18_1 % 2 == 0 and 31 or 30
	end
end

function var_0_1.updateView(arg_19_0)
	local var_19_0 = 0

	for iter_19_0 = 1, #P._playerBonus._bonusMonthCheckin do
		if P._playerBonus._bonusMonthCheckin[iter_19_0]._isClaimed then
			var_19_0 = var_19_0 + 1
		end
	end

	arg_19_0._checkinNum:setString(string.format(Str(STR.MONTH_REGISTER_NUM), var_19_0))

	local var_19_1 = math.floor(var_19_0 / 7) + 1
	local var_19_2 = arg_19_0._list

	var_19_2:forceDoLayout()
	var_19_2:gotoPos(var_19_1 * (var_0_3 + 10) - 370)
end

return var_0_1
