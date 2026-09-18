local var_0_0 = class("OnlinePanel", lc.ExtendUIWidget)
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

	local var_2_2 = ClientView.createCheckinTitle(Str(STR.CHECKIN_ONLINE), 0)

	lc.addChildToPos(arg_2_0, var_2_2, cc.p(lc.w(arg_2_0) / 2 + 140, lc.h(arg_2_0) - lc.h(var_2_2) / 2 - 24))

	local var_2_3 = ClientView.createTTF(Str(STR.ONLINE_CHECKIN_TIP), ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)

	lc.addChildToPos(arg_2_0, var_2_3, cc.p(lc.x(var_2_2), lc.bottom(var_2_2) - lc.h(var_2_3) / 2 - 12))

	local var_2_4 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = cc.size(lc.w(arg_2_0) - 20, 390)
	})

	lc.addChildToPos(arg_2_0, var_2_4, cc.p(lc.w(arg_2_0) / 2, lc.h(var_2_4) / 2))

	arg_2_0._bonusList = lc.List.createV(cc.size(lc.w(var_2_4) - 32, lc.h(var_2_4) - 20), 16, 10)

	lc.addChildToPos(var_2_4, arg_2_0._bonusList, cc.p(16, 10))
	arg_2_0:refreshList()
end

function var_0_0.refreshList(arg_3_0)
	local var_3_0 = {}
	local var_3_1, var_3_2, var_3_3 = P._playerBonus.splitBonus(P._playerBonus._bonusOnlineTask)

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		table.insert(var_3_0, iter_3_1)
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_2) do
		table.insert(var_3_0, iter_3_3)
	end

	for iter_3_4, iter_3_5 in ipairs(var_3_3) do
		table.insert(var_3_0, iter_3_5)
	end

	arg_3_0._bonusList:bindData(var_3_0, function(arg_4_0, arg_4_1)
		arg_3_0:setOrCreateItem(arg_4_0, arg_4_1)
	end, math.min(5, #var_3_0))

	for iter_3_6 = 1, arg_3_0._bonusList._cacheCount do
		arg_3_0._bonusList:pushBackCustomItem(arg_3_0:setOrCreateItem(nil, var_3_0[iter_3_6]))
	end
end

function var_0_0.setOrCreateItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = string.sub(Str(arg_5_2._info._nameSid), -7)
	local var_5_1 = var_0_1.create(var_5_0, arg_5_2)

	var_5_1:registerClaimHandler(function(arg_6_0)
		if arg_6_0._value >= arg_6_0._info._val and not arg_6_0._isClaimed then
			local var_6_0 = ClientData.claimBonus(arg_6_0)

			arg_5_0:refreshList()
			ClientView.showClaimBonusResult(arg_6_0, var_6_0)
		end
	end)

	return var_5_1
end

return var_0_0
