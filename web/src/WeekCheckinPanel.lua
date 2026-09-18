local var_0_0 = class("WeekCheckinPanel", lc.ExtendUIWidget)
local var_0_1 = require("CheckinBonusWidget")

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT)

	var_1_0:setContentSize(arg_1_1)
	var_1_0:setAnchorPoint(0.5, 0.5)
	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local var_2_0 = "activity_top"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_2_0 .. "_2")) then
		var_2_0 = var_2_0 .. "_2"
	end

	if ClientData.isAnotherSkin2() and lc.File:isFileExist(lc.formatJpg(var_2_0 .. "_3")) then
		var_2_0 = var_2_0 .. "_3"
	end

	local var_2_1 = lc.createSprite(lc.formatJpg(var_2_0))

	lc.addChildToPos(arg_2_0, var_2_1, cc.p(lc.w(arg_2_0) / 2, lc.h(arg_2_0) - lc.h(var_2_1) / 2))

	local var_2_2 = ClientView.createCheckinTitle(Str(STR.WEEK_CHECKIN_TITLE), 0)

	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.w(arg_2_0) / 2 + 140, lc.h(arg_2_0) - lc.h(var_2_2) / 2 - 24))

	local var_2_3 = ClientView.createTTF(Str(STR.WEEK_CHECKIN_TIP), ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)

	lc.addChildToPos(arg_2_0, var_2_3, cc.p(lc.x(var_2_2), lc.bottom(var_2_2) - lc.h(var_2_3) / 2 - 12))

	local var_2_4 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = cc.size(lc.w(arg_2_0) - 20, 390)
	})

	lc.addChildToPos(arg_2_0, var_2_4, cc.p(lc.w(arg_2_0) / 2, lc.h(var_2_4) / 2))

	local var_2_5 = lc.List.createV(cc.size(lc.w(var_2_4) - 32, lc.h(var_2_4) - 20), 16, 10)

	lc.addChildToPos(var_2_4, var_2_5, cc.p(16, 10))

	local var_2_6 = {}
	local var_2_7, var_2_8, var_2_9 = P._playerBonus.splitBonus(P._playerBonus._bonusWeekCheckin, function(arg_3_0, arg_3_1)
		return {
			_bonus = arg_3_1,
			_label = string.format(Str(STR.DATE_NUM), arg_3_0)
		}
	end)

	for iter_2_0, iter_2_1 in ipairs(var_2_7) do
		table.insert(var_2_6, iter_2_1)
	end

	for iter_2_2, iter_2_3 in ipairs(var_2_9) do
		table.insert(var_2_6, iter_2_3)
	end

	for iter_2_4, iter_2_5 in ipairs(var_2_8) do
		table.insert(var_2_6, iter_2_5)
	end

	var_2_5:bindData(var_2_6, function(arg_4_0, arg_4_1)
		arg_4_0:updateData(arg_4_1._label, arg_4_1._bonus)
	end, math.min(4, #var_2_6))

	for iter_2_6 = 1, var_2_5._cacheCount do
		local var_2_10 = var_0_1.create(var_2_6[iter_2_6]._label, var_2_6[iter_2_6]._bonus)

		var_2_10:registerClaimHandler(function(arg_5_0)
			local var_5_0 = ClientData.claimBonus(arg_5_0)

			ClientView.showClaimBonusResult(arg_5_0, var_5_0)
		end)
		var_2_5:pushBackCustomItem(var_2_10)
	end
end

return var_0_0
