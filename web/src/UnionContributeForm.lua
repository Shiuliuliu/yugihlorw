local var_0_0 = class("UnionContribute", BaseForm)
local var_0_1 = cc.size(750, 600)
local var_0_2 = cc.size(650, 150)
local var_0_3 = {
	-1,
	Data.ResType.gold,
	Data.ResType.ingot
}

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(resType)

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.UNION_CONTRIBUTION), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	arg_2_0._isShowResourceUI = true

	local var_2_0 = arg_2_0._form

	lc.offset(var_2_0, 0, -20)
	arg_2_0:initTopArea()

	local var_2_1 = lc.bottom(arg_2_0._topArea) - var_0_2.height / 2 - 6

	arg_2_0._acts, arg_2_0._woods = {}, {}

	for iter_2_0 = 1, 6 do
		local var_2_2 = arg_2_0:createItem(iter_2_0)
		local var_2_3 = cc.p(0, var_2_1)

		if iter_2_0 % 2 == 1 then
			var_2_3.x = lc.w(var_2_0) / 2 - var_0_2.width / 2

			table.insert(arg_2_0._acts, var_2_2)
		end

		if var_2_2 then
			var_2_3.x = lc.cw(var_2_0)
			var_2_1 = var_2_1 - var_0_2.height

			lc.addChildToPos(var_2_0, var_2_2, var_2_3)
		end
	end
end

function var_0_0.initTopArea(arg_3_0)
	local var_3_0 = "union_contribute"

	if ClientData.isAnotherSkin() and lc.File:isFileExist(lc.formatJpg(var_3_0 .. "_2")) then
		var_3_0 = var_3_0 .. "_2"
	end

	local var_3_1 = lc.createSprite(lc.formatJpg(var_3_0))

	lc.addChildToPos(arg_3_0._frame, var_3_1, cc.p(lc.w(arg_3_0._form) / 2, lc.h(arg_3_0._form) - var_0_0.FRAME_THICK_TOP - lc.h(var_3_1) / 2), -1)

	arg_3_0._topArea = var_3_1

	local var_3_2 = 32

	arg_3_0._act = ClientView.createBMFont(ClientView.BMFont.huali_26, "")

	arg_3_0._act:setAnchorPoint(cc.p(0, 0.5))
	lc.addChildToPos(var_3_1, arg_3_0._act, cc.p(520, 40))
	arg_3_0:updateContribution()
end

function var_0_0.createItem(arg_4_0, arg_4_1)
	if arg_4_1 % 2 == 0 then
		return
	end

	local var_4_0 = lc.createSprite({
		_name = "img_com_bg_4",
		_crect = ClientView.CRECT_COM_BG4,
		_size = var_0_2
	})
	local var_4_1
	local var_4_2
	local var_4_3
	local var_4_4
	local var_4_5
	local var_4_6

	if arg_4_1 % 2 == 1 then
		var_4_6 = (arg_4_1 + 1) / 2
		var_4_1 = Data.ResType.union_act
		var_4_2 = Data._globalInfo._unionDonateExp[var_4_6]
		var_4_4 = Data._globalInfo._donateCost[var_4_6]
		var_4_5 = Data._globalInfo._donateGetUnionCrystal[var_4_6]

		if var_4_6 == 3 then
			var_4_4 = var_4_4 + P._dailyIngotDonate * Data._globalInfo._donateIngotCostIncremental
		end
	else
		var_4_6 = arg_4_1 / 2
		var_4_1 = Data.ResType.union_wood
		var_4_2 = Data._globalInfo._unionDonateWood[var_4_6]
		var_4_4 = Data._globalInfo._donateWoodCost[var_4_6]
		var_4_5 = Data._globalInfo._donateWoodGain[var_4_6]
	end

	local var_4_7 = var_0_3[var_4_6]

	if P._playerActivity._actContributeYubi2x then
		var_4_5 = var_4_5 * 2
	end

	local var_4_8 = IconWidget.create({
		_infoId = var_4_1,
		_count = var_4_2
	}, IconWidget.DisplayFlag.ITEM)

	lc.addChildToPos(var_4_0, var_4_8, cc.p(86, var_0_2.height / 2 + 2))
	var_4_8._name:setColor(ClientView.COLOR_TEXT_WHITE)

	local var_4_9 = IconWidget.create({
		_infoId = Data.PropsId.yubi,
		_count = var_4_5
	}, IconWidget.DisplayFlag.ITEM)

	lc.addChildToPos(var_4_0, var_4_9, cc.p(lc.right(var_4_8) + lc.cw(var_4_9) + 30, var_0_2.height / 2 + 2))
	var_4_9._name:setColor(ClientView.COLOR_TEXT_WHITE)

	local var_4_10

	if var_4_7 >= 0 then
		var_4_10 = string.format("img_icon_res%d_s", var_4_7)
	end

	local var_4_11 = "img_btn_1_s"
	local var_4_12 = ClientView.createResConsumeButton(200, 100, var_4_10, var_4_4, Str(STR.CONTRIBUTE), var_4_11)

	var_4_12._resNum = var_4_4

	lc.addChildToPos(var_4_0, var_4_12, cc.p(var_0_2.width - 40 - lc.w(var_4_12) / 2, lc.ch(var_4_0)))
	var_4_12:setDisabledShader(ClientView.SHADER_DISABLE)

	if arg_4_1 ~= 3 then
		var_4_12:setEnabled(P._dailyDonate < Data._globalInfo._dailyDonateCount)
	else
		var_4_12:setEnabled(P._dailyIngotDonate < Data._globalInfo._ingotDonateUpLimit)
	end

	var_4_12._resLabel:setColor((var_4_7 == -1 or P:hasResource(var_4_7, var_4_4)) and ClientView.COLOR_TEXT_WHITE or ClientView.COLOR_TEXT_RED)

	function var_4_12._callback()
		arg_4_0:contribute(var_4_6, var_4_1, true)
	end

	if var_4_10 == nil then
		var_4_12._resLabel:setString(Str(STR.FREE))
	end

	var_4_0._btn = var_4_12
	var_4_0._unionResType, var_4_0._unionResNum, var_4_0._resType, var_4_0._resNum, var_4_0._rewardNum = var_4_1, var_4_2, var_4_7, var_4_4, var_4_5

	return var_4_0
end

function var_0_0.updateContribution(arg_6_0)
	local var_6_0 = P._playerUnion:getMyUnion():getContribution(P._id)

	arg_6_0._act:setString(var_6_0[Data.ResType.union_act])

	if arg_6_0._acts and #arg_6_0._acts == 3 then
		local var_6_1 = arg_6_0._acts[3]
		local var_6_2 = var_6_1._btn._resLabel
		local var_6_3 = Data._globalInfo._donateCost[3] + P._dailyIngotDonate * Data._globalInfo._donateIngotCostIncremental

		var_6_1._resNum = var_6_3

		var_6_2:setString(var_6_3)

		for iter_6_0 = 1, 3 do
			local var_6_4 = arg_6_0._acts[iter_6_0]
			local var_6_5 = var_6_4._btn
			local var_6_6 = var_6_5._resLabel

			if iter_6_0 ~= 3 then
				var_6_5:setEnabled(P._dailyDonate < Data._globalInfo._dailyDonateCount)
			else
				var_6_5:setEnabled(P._dailyIngotDonate < Data._globalInfo._ingotDonateUpLimit)
			end

			var_6_6:setColor((var_6_4._resType == -1 or P:hasResource(var_6_4._resType, var_6_4._resNum)) and ClientView.COLOR_TEXT_WHITE or ClientView.COLOR_TEXT_RED)
		end
	end
end

function var_0_0.contribute(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if P._dailyDonate >= Data._globalInfo._dailyDonateCount and arg_7_1 ~= 3 or P._dailyIngotDonate >= Data._globalInfo._ingotDonateUpLimit and arg_7_1 == 3 then
		ToastManager.push(Str(STR.CANNOT_UNION_CONTRIBUTE))

		return
	end

	local var_7_0 = arg_7_2 == Data.ResType.union_act and arg_7_0._acts[arg_7_1] or arg_7_0._woods[arg_7_1]

	if var_7_0._resType == Data.ResType.ingot then
		if not ClientView.checkIngot(var_7_0._resNum) then
			return
		end
	elseif var_7_0._resType == Data.ResType.gold and not ClientView.checkGold(var_7_0._resNum) then
		return
	end

	if arg_7_3 and P._playerUnion:isReachMaxResource(arg_7_2, var_7_0._unionResNum) then
		local var_7_1 = arg_7_2 == Data.ResType.union_act and Str(STR.UNION_EXP) or Str(STR.UNION_WOOD)

		require("Dialog").showDialog(string.format(Str(STR.UNION_RES_REACH_MAX_TIP), var_7_1), function()
			arg_7_0:contribute(arg_7_1, arg_7_2)
		end)

		return
	end

	P._playerUnion:getMyUnion():contribute(P._id, arg_7_2, var_7_0._unionResNum)
	P._playerUnion:changeResource(arg_7_2, var_7_0._unionResNum)

	if arg_7_1 == 3 then
		P._dailyIngotDonate = P._dailyIngotDonate + 1
	else
		P._dailyDonate = P._dailyDonate + 1
	end

	P:changeResource(var_7_0._resType, -var_7_0._resNum)
	P._propBag:changeProps(Data.PropsId.yubi, var_7_0._rewardNum)
	ClientData.sendUnionContribute(arg_7_1, arg_7_2)
	arg_7_0:updateContribution()

	local var_7_2 = {}

	table.insert(var_7_2, {
		_level = 1,
		_isFragment = false,
		_infoId = var_7_0._unionResType,
		_count = var_7_0._unionResNum
	})
	table.insert(var_7_2, {
		_level = 1,
		_isFragment = false,
		_infoId = Data.PropsId.yubi,
		_count = var_7_0._rewardNum
	})

	local var_7_3 = require("RewardPanel")

	var_7_3.create(var_7_2, var_7_3.MODE_UNION_CONTRIBUTE):show()
	lc.Audio.playAudio(AUDIO.E_CLAIM)
end

function var_0_0.onEnter(arg_9_0)
	var_0_0.super.onEnter(arg_9_0)
	arg_9_0:updateContribution()

	arg_9_0._listeners = {}

	table.insert(arg_9_0._listeners, lc.addEventListener(Data.Event.gold_dirty, function(arg_10_0)
		arg_9_0:updateContribution()
	end))
	table.insert(arg_9_0._listeners, lc.addEventListener(Data.Event.ingot_dirty, function(arg_11_0)
		arg_9_0:updateContribution()
	end))
end

function var_0_0.onExit(arg_12_0)
	var_0_0.super.onExit(arg_12_0)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_12_1)
	end
end

function var_0_0.onCleanup(arg_13_0)
	var_0_0.super.onCleanup(arg_13_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/union_contribute.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/union_contribute_2.jpg"))
end

return var_0_0
