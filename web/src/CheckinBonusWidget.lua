local var_0_0 = class("CheckinBonusWidget", lc.ExtendUIWidget)
local var_0_1 = cc.size(850, 152)
local var_0_2 = 1000

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setContentSize(var_0_1)
	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._label = arg_2_1
	arg_2_0._bonus = arg_2_2

	local var_2_0 = lc.createSprite({
		_name = "img_com_bg_33",
		_crect = ClientView.CRECT_COM_BG33,
		_size = var_0_1
	})

	lc.addChildToCenter(arg_2_0, var_2_0)

	local var_2_1 = lc.createSprite("img_bg_deco_33")

	var_2_1:setColor(cc.c3b(72, 134, 232))
	lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.w(var_2_1) / 2, lc.h(var_2_0) / 2 + 4))

	local var_2_2 = lc.createSprite("img_bg_deco_29")

	var_2_2:setScale(lc.h(arg_2_0) / lc.h(var_2_2))
	var_2_2:setPosition(cc.p(lc.w(var_2_0) - lc.sw(var_2_2) / 2, lc.h(arg_2_0) / 2))
	var_2_0:addChild(var_2_2)

	local var_2_3 = ClientView.createBMFont(ClientView.BMFont.huali_32, arg_2_1)

	lc.addChildToPos(arg_2_0, var_2_3, cc.p(lc.w(var_2_3) / 2 + 34, var_0_1.height / 2))

	arg_2_0._dateLabel = var_2_3

	local var_2_4 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_3_0)
		if arg_2_0._claimHandler then
			arg_2_0._claimHandler(arg_2_0._bonus)
		end
	end, ClientView.CRECT_BUTTON, 140)

	var_2_4:addLabel(Str(STR.CLAIM))
	var_2_4:setDisabledShader(ClientView.SHADER_DISABLE)
	lc.addChildToPos(arg_2_0, var_2_4, cc.p(var_0_1.width - 90, var_0_1.height / 2))

	arg_2_0._btnClaim = var_2_4

	local var_2_5 = ClientView.createStatusLabel(Str(STR.CLAIMED), ClientView.COLOR_TEXT_GREEN)

	lc.addChildToPos(arg_2_0, var_2_5, cc.p(var_0_1.width - 90, var_0_1.height / 2))

	arg_2_0._claimedFlag = var_2_5

	if arg_2_2._info._type == Data.BonusType.online then
		local var_2_6 = ClientView.createTTF("", ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)

		var_2_6:setScale(0.8)
		var_2_6:setAnchorPoint(1, 1)
		lc.addChildToPos(arg_2_0, var_2_6, cc.p(lc.right(var_2_4), lc.bottom(var_2_4)))

		arg_2_0._tip = var_2_6
	end
end

function var_0_0.onEnter(arg_4_0)
	arg_4_0._listener = lc.addEventListener(Data.Event.bonus_dirty, function(arg_5_0)
		if arg_5_0._data == arg_4_0._bonus then
			arg_4_0:updateView()
		end
	end)

	arg_4_0:updateData(arg_4_0._label, arg_4_0._bonus)
	arg_4_0:scheduleUpdateWithPriorityLua(function(arg_6_0)
		arg_4_0:onSchedule(arg_6_0)
	end, 0)
end

function var_0_0.onExit(arg_7_0)
	lc.Dispatcher:removeEventListener(arg_7_0._listener)
	arg_7_0:unscheduleUpdate()
end

function var_0_0.updateData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._label = arg_8_1
	arg_8_0._bonus = arg_8_2

	arg_8_0._dateLabel:setString(arg_8_1)
	arg_8_0:removeChildrenByTag(var_0_2)

	local var_8_0 = arg_8_2._info
	local var_8_1 = {}
	local var_8_2 = var_8_0._rid
	local var_8_3 = var_8_0._level
	local var_8_4 = var_8_0._count
	local var_8_5 = var_8_0._isFragment

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_6 = IconWidget.create({
			_infoId = iter_8_1,
			_level = var_8_3[iter_8_0],
			_isFragment = var_8_5[iter_8_0] > 0,
			_count = var_8_4[iter_8_0]
		})

		var_8_6._name:setColor(ClientView.COLOR_TEXT_DARK)
		table.insert(var_8_1, var_8_6)
	end

	P:sortResultItems(var_8_1)

	local var_8_7 = 180
	local var_8_8 = var_0_1.height / 2

	for iter_8_2, iter_8_3 in ipairs(var_8_1) do
		lc.addChildToPos(arg_8_0, iter_8_3, cc.p(var_8_7 + lc.w(iter_8_3) / 2, var_8_8), 0, var_0_2)

		var_8_7 = var_8_7 + lc.w(iter_8_3) + 18

		iter_8_3:checkHighlight()
	end

	arg_8_0:updateView()
end

function var_0_0.registerClaimHandler(arg_9_0, arg_9_1)
	arg_9_0._claimHandler = arg_9_1
end

function var_0_0.updateView(arg_10_0)
	local var_10_0 = arg_10_0._bonus
	local var_10_1 = arg_10_0._bonus._value >= arg_10_0._bonus._info._val

	arg_10_0._btnClaim:setVisible(not var_10_0._isClaimed)
	arg_10_0._btnClaim:setEnabled(var_10_1)
	arg_10_0._btnClaim:setTouchSwallow(var_10_1)
	arg_10_0._claimedFlag:setVisible(var_10_0._isClaimed)
end

function var_0_0.onSchedule(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._bonus._info

	if var_11_0 and var_11_0._type == Data.BonusType.online then
		arg_11_0:updateOnlineBonusTip()
	end
end

function var_0_0.updateOnlineBonusTip(arg_12_0)
	local var_12_0 = arg_12_0._bonus
	local var_12_1 = arg_12_0._bonus._info
	local var_12_2 = var_12_0:getPrevBonus()

	if var_12_2 == nil or var_12_2._isClaimed then
		if var_12_0._isClaimed or var_12_0:canClaim() then
			arg_12_0._tip:setString("")
		else
			local var_12_3 = math.ceil(var_12_1._val - var_12_0._value)

			if var_12_3 < 0 then
				var_12_3 = 0
			end

			arg_12_0._tip:setString(string.format(Str(STR.CLAIM_AFTER1), ClientData.formatPeriod(var_12_3)))
		end
	else
		local var_12_4 = var_12_1._val - (var_12_2 and var_12_2._info._val or 0)

		if var_12_4 < 0 then
			var_12_4 = 0
		end

		arg_12_0._tip:setString(string.format(Str(STR.CLAIM_AFTER2), ClientData.formatPeriod(var_12_4, 1)))
	end
end

return var_0_0
