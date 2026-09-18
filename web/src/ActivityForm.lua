local var_0_0 = class("ActivityForm", BaseForm)
local var_0_1 = cc.size(1000, 660)

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_1

	arg_2_2 = arg_2_2 or 1

	local var_2_1 = arg_2_1[arg_2_2]
	local var_2_2

	if type(var_2_1) == "table" then
		var_2_2 = var_2_1

		if var_2_2._type[1] == Data.ActivityType.yyb then
			ClientData.setActivityShowed(var_2_2._type[1])

			var_2_0 = cc.size(1180, 780)
		end
	else
		ClientData.setActivityShowed(var_2_1)
	end

	var_0_0.super.init(arg_2_0, var_2_0, nil, nil, true)

	local var_2_3 = cc.Node:create()

	var_2_3:setContentSize(cc.size(1116, 708))
	var_2_3:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToCenter(arg_2_0._frame, var_2_3, -1)

	local var_2_4 = require("ActivityScene")

	if var_2_2 then
		if var_2_2._type[1] == Data.ActivityType.yyb then
			var_2_4.initYYB(var_2_3)
		end
	elseif var_2_1 >= Data.PurchaseType.limit_minus_2 and var_2_1 <= Data.PurchaseType.limit_8 then
		var_2_4.createLimitLarge(var_2_1, var_2_3, false)
		var_2_3:setScale((lc.w(arg_2_0._frame) - 40) / lc.w(var_2_3._bg))
	elseif var_2_1 == Data.PurchaseType.return_to_game then
		var_2_4.createReturnPackage(var_2_3, false)
		var_2_3:setScale((lc.w(arg_2_0._frame) - 40) / lc.w(var_2_3._bg))
	elseif var_2_1 == Data.PurchaseType.ad_recharge then
		var_2_4.createAdRecharge(var_2_3)
		var_2_3:setScale((lc.w(arg_2_0._frame) - 40) / lc.w(var_2_3._bg))
	elseif var_2_1 == Data.PurchaseType.ad_package then
		var_2_4.createAdPackage(var_2_3)
		var_2_3:setScale((lc.w(arg_2_0._frame) - 40) / lc.w(var_2_3._bg))
	end

	if not var_2_2 and (not (var_2_1 >= Data.PurchaseType.limit_3) or not (var_2_1 <= Data.PurchaseType.limit_6)) then
		local var_2_5 = ClientView.createShaderButton(nil, function()
			arg_2_0:jumpToBuy(var_2_1)
		end)

		var_2_5:setContentSize(arg_2_0._frame:getContentSize())
		var_2_5:setAnchorPoint(cc.p(0.5, 0.5))
		lc.addChildToCenter(arg_2_0._frame, var_2_5, -1)
	end

	function arg_2_0.onHideActionFinished()
		arg_2_0:jumpToNext(arg_2_1, arg_2_2)
	end
end

function var_0_0.onCleanup(arg_5_0)
	var_0_0.super.onCleanup(arg_5_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_01.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_02.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_03.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_04.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_05.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_06.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_limit_large_07.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_return.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_recharge.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/activity_package.jpg"))
	ClientData.unloadLCRes(arg_5_0._resNames)
end

function var_0_0.jumpToBuy(arg_6_0, arg_6_1)
	local var_6_0 = require("ActivityScene")

	if arg_6_1 == Data.PurchaseType.limit_minus_2 then
		arg_6_0:hide()
		lc.pushScene(var_6_0.create(var_6_0.Tab.limit_large_minus_2))
	elseif arg_6_1 == Data.PurchaseType.limit_minus_1 then
		arg_6_0:hide()
		lc.pushScene(var_6_0.create(var_6_0.Tab.limit_large_minus_1))
	elseif arg_6_1 == Data.PurchaseType.limit_0 then
		arg_6_0:hide()
		lc.pushScene(var_6_0.create(var_6_0.Tab.limit_large_00))
	elseif arg_6_1 == Data.PurchaseType.limit_1 then
		arg_6_0:hide()
		lc.pushScene(var_6_0.create(var_6_0.Tab.limit_large_01))
	elseif arg_6_1 == Data.PurchaseType.limit_2 then
		arg_6_0:hide()
		lc.pushScene(var_6_0.create(var_6_0.Tab.limit_large_02))
	elseif arg_6_1 == Data.PurchaseType.limit_8 then
		arg_6_0:hide()
		lc.pushScene(var_6_0.create(var_6_0.Tab.limit_large_08))
	elseif arg_6_1 == Data.PurchaseType.limit_5 then
		arg_6_0:hide()
		lc.pushScene(var_6_0.create(var_6_0.Tab.personal_fund * 100 + 1))
	elseif arg_6_1 == Data.PurchaseType.limit_7 then
		require("CumulativeForm").create():show()
	elseif arg_6_1 == Data.PurchaseType.return_to_game then
		arg_6_0:hide()
		lc.pushScene(var_6_0.create(var_6_0.Tab.return_to_game))
	elseif arg_6_1 == Data.PurchaseType.ad_recharge then
		arg_6_0:hide()
		lc.pushScene(var_6_0.create(var_6_0.Tab.first_recharge))
	elseif arg_6_1 == Data.PurchaseType.ad_package then
		arg_6_0:hide()
		lc.pushScene(var_6_0.create(var_6_0.Tab.package))
	end
end

function var_0_0.jumpToNext(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:hide()

	if arg_7_2 < #arg_7_1 then
		require("ActivityForm").create(arg_7_1, arg_7_2 + 1):show()
	elseif table.maxn(P._playerBonus._changedFundTasks) > 0 then
		require("FundTasksPanel").create(P._playerBonus._changedFundTasks, Str(STR.FUND_TASKS)):show()

		P._playerBonus._changedFundTasks = {}
	end
end

return var_0_0
