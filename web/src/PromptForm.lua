local var_0_0 = class("PromptForm", BaseForm)
local var_0_1 = 140
local var_0_2 = 90

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2, 0)

	arg_1_0._hideBg = true

	arg_1_0._btnBack:setVisible(false)
end

function var_0_0.addButton(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = ClientView.createScale9ShaderButton(arg_2_1, arg_2_5, string.sub(arg_2_1, #arg_2_1 - 1, #arg_2_1) == "_s" and ClientView.CRECT_BUTTON_S or ClientView.CRECT_BUTTON, var_0_1)

	var_2_0:addLabel(arg_2_2)
	lc.addChildToPos(arg_2_0._form, var_2_0, cc.p(arg_2_3, arg_2_4 or var_0_2))

	return var_2_0
end

local var_0_3 = class(nil, var_0_0)

var_0_0.ConfirmSweep = var_0_3

function var_0_3.create(arg_3_0, arg_3_1)
	local var_3_0 = var_0_3.new(lc.EXTEND_LAYOUT_MASK)

	var_3_0:init(cc.size(600, 360), Str(STR.NOT_ENOUGH_SWEEP_CARD), arg_3_0, arg_3_1)

	return var_3_0
end

function var_0_3.init(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	var_0_3.super.init(arg_4_0, arg_4_1, arg_4_2)

	arg_4_0._callback = arg_4_4

	local var_4_0 = (arg_4_3 - P._propBag._props[Data.PropsId.sweep_card]._num) * 2

	arg_4_0._ingotNeed = var_4_0

	local var_4_1 = arg_4_0._form
	local var_4_2 = lc.w(arg_4_0._form) / 2
	local var_4_3 = ClientView.createBoldRichText(string.format(Str(STR.CONFIRM_SWEEP_INGOT), var_4_0), ClientView.RICHTEXT_PARAM_LIGHT_S1, 400)

	lc.addChildToPos(var_4_1, var_4_3, cc.p(var_4_2, lc.bottom(arg_4_0._titleFrame) - 30 - lc.h(var_4_3) / 2))
	arg_4_0:addButton("img_btn_2", Str(STR.CANCEL), var_4_2 - var_0_1 / 2 - 10, nil, function()
		arg_4_0:hide()
	end)

	local var_4_4 = ClientView.createResConsumeButtonArea(var_0_1, "img_icon_res3_s", ClientView.COLOR_RES_LABEL_BG_LIGHT, tostring(var_4_0), string.format(Str(STR.CONTINUE_DO), Str(STR.SWEEP)))

	function var_4_4._btn._callback()
		arg_4_0:onButtonTap("ok")
	end

	lc.addChildToPos(var_4_1, var_4_4, cc.p(var_4_2 + var_0_1 / 2 + 10, var_0_2 + (lc.h(var_4_4) - lc.h(var_4_4._btn)) / 2))

	if var_4_0 > P._ingot then
		var_4_4._resLabel:setColor(lc.Color3B.red)
	end
end

function var_0_3.onButtonTap(arg_7_0, arg_7_1)
	if arg_7_1 == "buy" then
		ClientView.popScene(true)
		lc.pushScene(require("MarketScene").create(Data.MarketBuyType.random))
	elseif arg_7_1 == "ok" and ClientView.checkIngot(arg_7_0._ingotNeed) then
		arg_7_0._callback()
		arg_7_0:hide()
	end
end

local var_0_4 = class(nil, var_0_0)

var_0_0.ConfirmBuyIngot = var_0_4

function var_0_4.create()
	local var_8_0 = var_0_4.new(lc.EXTEND_LAYOUT_MASK)

	var_8_0:init(cc.size(560, 320), Str(STR.NOT_ENOUGH_INGOT))

	return var_8_0
end

function var_0_4.init(arg_9_0, arg_9_1, arg_9_2)
	var_0_4.super.init(arg_9_0, arg_9_1, arg_9_2)

	local var_9_0 = lc.w(arg_9_0._form) / 2
	local var_9_1 = ClientView.createTTF(Str(STR.SURE_TO_RECHARGE), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT, cc.size(360, 0))

	lc.addChildToPos(arg_9_0._form, var_9_1, cc.p(var_9_0, lc.bottom(arg_9_0._titleFrame) - 30 - lc.h(var_9_1) / 2))

	if ClientData.isHideCharge() then
		arg_9_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_9_0, nil, function()
			arg_9_0:hide()
		end)
	else
		local var_9_2 = var_9_0 + var_0_1 / 2 + 10

		lc.addChildToPos(arg_9_0._form, ClientView.createChargeButton(var_0_1, arg_9_0), cc.p(var_9_2, var_0_2))
		arg_9_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_9_2 - var_0_1 - 20, nil, function()
			arg_9_0:hide()
		end)
	end
end

local var_0_5 = class(nil, var_0_0)

var_0_0.ConfirmBuyFund = var_0_5

function var_0_5.create(arg_12_0)
	local var_12_0 = var_0_5.new(lc.EXTEND_LAYOUT_MASK)

	var_12_0:init(cc.size(640, 480), Str(STR.BUY) .. ClientData.getNameByInfoId(Data.PropsId.union_fund), arg_12_0)

	return var_12_0
end

function var_0_5.init(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	var_0_5.super.init(arg_13_0, arg_13_1, arg_13_2)

	local var_13_0 = lc.w(arg_13_0._form) / 2
	local var_13_1 = IconWidget.create({
		_count = 1,
		_infoId = Data.PropsId.union_fund
	})

	var_13_1._name:setColor(lc.Color3B.white)
	lc.addChildToPos(arg_13_0._form, var_13_1, cc.p(var_13_0, lc.bottom(arg_13_0._titleFrame) - 24 - lc.h(var_13_1) / 2))

	local var_13_2 = ClientView.createBoldRichText(string.format(Str(STR.SURE_TO_BUY_UNION_FUND), ClientData.getNameByInfoId(Data.PropsId.union_fund)), ClientView.RICHTEXT_PARAM_LIGHT_S1, 500)

	lc.addChildToPos(arg_13_0._form, var_13_2, cc.p(var_13_0, lc.bottom(var_13_1) - 20 - lc.h(var_13_2) / 2))
	arg_13_0:addButton("img_btn_3", Str(STR.BUY), var_13_0 + var_0_1 / 2 + 16, nil, function()
		arg_13_0:hide()
		arg_13_3()
	end)
	arg_13_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_13_0 - var_0_1 / 2 - 16, nil, function()
		arg_13_0:hide()
	end)
end

local var_0_6 = class(nil, var_0_0)

var_0_0.ConfirmEditUnion = var_0_6

function var_0_6.create(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = var_0_6.new(lc.EXTEND_LAYOUT_MASK)

	var_16_0:init(cc.size(560, 340), arg_16_0, arg_16_1, arg_16_2)

	return var_16_0
end

function var_0_6.init(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	var_0_6.super.init(arg_17_0, arg_17_1)

	local var_17_0 = lc.w(arg_17_0._form) / 2
	local var_17_1 = 0

	if arg_17_2 then
		local var_17_2 = Data._globalInfo._editUnionNameIngot
		local var_17_3 = ClientView.createKeyValueLabel(Str(STR.CHANGE) .. Str(STR.UNION_NAME) .. Str(STR.CONSUME), var_17_2, ClientView.FontSize.S1, false, "img_icon_res3_s")

		var_17_3:addToParent(arg_17_0._form, cc.p(120, lc.h(arg_17_0._form) - 110))

		var_17_1 = var_17_1 + var_17_2
		arg_17_0._nameKey = var_17_3
	end

	if arg_17_3 then
		local var_17_4 = Data._globalInfo._editUnionTagIngot
		local var_17_5 = ClientView.createKeyValueLabel(Str(STR.CHANGE) .. Str(STR.UNION_BADGE) .. Str(STR.CONSUME), var_17_4, ClientView.FontSize.S1, false, "img_icon_res3_s")

		if arg_17_2 then
			arg_17_0._nameKey:setPosition(lc.x(arg_17_0._nameKey), lc.h(arg_17_0._form) - 80)
			var_17_5:addToParent(arg_17_0._form, cc.p(120, lc.h(arg_17_0._form) - 130))
		else
			var_17_5:addToParent(arg_17_0._form, cc.p(120, lc.h(arg_17_0._form) - 110))
		end

		var_17_1 = var_17_1 + var_17_4
	end

	arg_17_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_17_0 - var_0_1 + 40, nil, function()
		arg_17_0:hide()
	end)

	local var_17_6 = ClientView.createResConsumeButtonArea(var_0_1, "img_icon_res3_s", ClientView.COLOR_RES_LABEL_BG_LIGHT, tostring(var_17_1), Str(STR.CHANGE))

	function var_17_6._btn._callback()
		if arg_17_4 then
			arg_17_4()
		end

		arg_17_0:hide()
	end

	lc.addChildToPos(arg_17_0._form, var_17_6, cc.p(var_17_0 + var_0_1 - 40, var_0_2 + (lc.h(var_17_6) - lc.h(var_17_6._btn)) / 2))

	if var_17_1 > P._ingot then
		var_17_6._resLabel:setColor(lc.Color3B.red)
	end
end

local var_0_7 = class(nil, var_0_0)

var_0_0.ConfirmBuyProduct = var_0_7

function var_0_7.create(arg_20_0, arg_20_1)
	local var_20_0 = var_0_7.new(lc.EXTEND_LAYOUT_MASK)

	var_20_0:init(cc.size(560, 400), arg_20_0, arg_20_1)

	var_20_0._hideBg = false

	return var_20_0
end

function var_0_7.init(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	var_0_7.super.init(arg_21_0, arg_21_1)

	local var_21_0 = arg_21_0._form
	local var_21_1 = lc.w(arg_21_0._form) / 2
	local var_21_2 = IconWidget.create({
		_infoId = arg_21_2._resType,
		_count = arg_21_2._cost,
		_isFragment = arg_21_2._costFragment
	}, IconWidget.DisplayFlag.ITEM)
	local var_21_3 = IconWidget.create(arg_21_2, IconWidget.DisplayFlag.ITEM)

	var_21_2._name:setColor(lc.Color3B.white)
	var_21_3._name:setColor(lc.Color3B.white)

	local var_21_4 = lc.createSprite("img_arrow_right")

	var_21_4:setColor(ClientView.COLOR_TEXT_GREEN)
	lc.addChildToPos(var_21_0, var_21_4, cc.p(var_21_1, lc.h(var_21_0) - 130))
	lc.addChildToPos(var_21_0, var_21_2, cc.p(var_21_1 - 100, lc.y(var_21_4) - 10))
	lc.addChildToPos(var_21_0, var_21_3, cc.p(var_21_1 + 100, lc.y(var_21_2)))

	local var_21_5 = ClientView.createTTF(Str(STR.SURE_TO_BUY), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)

	lc.addChildToPos(var_21_0, var_21_5, cc.p(var_21_1, lc.bottom(var_21_2) - 40))
	arg_21_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_21_1 - var_0_1 + 40, nil, function()
		arg_21_0:hide()
	end)
	arg_21_0:addButton("img_btn_1_s", Str(STR.BUY), var_21_1 + var_0_1 - 40, nil, function()
		if arg_21_3 then
			arg_21_3()
		end

		arg_21_0:hide()
	end)
end

local var_0_8 = class(nil, var_0_0)

var_0_0.ConfirmMix = var_0_8

local var_0_9 = require("SelectCountWidget")

function var_0_8.create(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = var_0_8.new(lc.EXTEND_LAYOUT_MASK)

	var_24_0:init(arg_24_0, arg_24_1, arg_24_2, arg_24_3)

	var_24_0._hideBg = false

	return var_24_0
end

function var_0_8.init(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = arg_25_4 and cc.size(600, 440 + var_0_9.HEIGHT) or cc.size(560, 420)

	var_0_8.super.init(arg_25_0, var_25_0)

	local var_25_1 = arg_25_0._form
	local var_25_2 = lc.w(arg_25_0._form) / 2

	arg_25_0._data = arg_25_1

	local var_25_3 = IconWidget.create(arg_25_1, IconWidget.DisplayFlag.ITEM)

	lc.addChildToPos(var_25_1, var_25_3, cc.p(var_25_2, lc.h(var_25_1) - 130))

	local var_25_4

	if arg_25_4 then
		var_25_4 = var_0_9.create(nil, 100)

		lc.addChildToPos(var_25_1, var_25_4, cc.p(var_25_2, lc.bottom(var_25_3) - 10 - var_25_4.HEIGHT / 2))
	end

	local var_25_5 = ClientView.createTTF(Str(STR.MIX_COST), ClientView.FontSize.S1, ClientView.COLOR_LABEL_DARK)

	lc.addChildToPos(var_25_1, var_25_5, cc.p(var_25_2, lc.bottom(var_25_4 or var_25_3) - 40))

	local var_25_6, var_25_7, var_25_8 = arg_25_0:getMixCost(arg_25_2, 1)
	local var_25_9
	local var_25_10

	if var_25_6 > 0 then
		var_25_9 = ClientView.createResIconLabel(120, "card_fragment")

		var_25_9._ico:setScale(0.5)
		var_25_9._label:setString(var_25_6)
		lc.addChildToPos(var_25_1, var_25_9, cc.p(var_25_2 - (var_25_7 > 0 and lc.w(var_25_9) / 2 + 4 or -10), lc.bottom(var_25_5) - 30))
	end

	if var_25_7 > 0 then
		var_25_10 = ClientView.createResIconLabel(120, string.format("img_icon_%d", var_25_8))

		var_25_10._label:setString(var_25_7)
		lc.addChildToPos(var_25_1, var_25_10, cc.p(var_25_2 + (var_25_6 > 0 and lc.w(var_25_10) / 2 + 24 or 10), lc.bottom(var_25_5) - 30))
	end

	if var_25_4 then
		function var_25_4._callback(arg_26_0)
			local var_26_0, var_26_1, var_26_2 = arg_25_0:getMixCost(arg_25_2, arg_26_0)

			if var_25_9 then
				var_25_9._label:setString(var_26_0)

				arg_25_0._needMoreFrag = var_26_0 > P._playerCard:getFragmentNum(arg_25_1._infoId)

				var_25_9._label:setColor(arg_25_0._needMoreFrag and lc.Color3B.red or lc.Color3B.white)
			end

			if var_25_10 then
				var_25_10._label:setString(var_26_1)

				arg_25_0._needMoreComFrag = var_26_1 > P:getItemCount(var_26_2)

				var_25_10._label:setColor(arg_25_0._needMoreComFrag and lc.Color3B.red or lc.Color3B.white)
			end
		end
	end

	arg_25_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_25_2 - var_0_1 + 40, nil, function()
		arg_25_0:hide()
	end)
	arg_25_0:addButton("img_btn_1_s", Str(STR.COMPOSE), var_25_2 + var_0_1 - 40, nil, function()
		if arg_25_0._needMoreFrag or arg_25_0._needMoreComFrag then
			ToastManager.push(Str(STR.NEED_FRAGMENTS_MIX))

			return
		end

		if arg_25_3 then
			arg_25_3(var_25_4 and var_25_4:getCount() or 1)
		end

		arg_25_0:hide()
	end)
end

function var_0_8.getMixCost(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0._data
	local var_29_1 = 0
	local var_29_2 = 0
	local var_29_3
	local var_29_4 = var_29_0._info._fragmentCount * arg_29_2

	if arg_29_1 then
		if var_29_4 < var_29_2 then
			var_29_2 = var_29_4
		end

		var_29_1 = var_29_4 - var_29_2
	else
		if var_29_4 < var_29_1 then
			var_29_1 = var_29_4
		end

		var_29_2 = var_29_4 - var_29_1
	end

	return var_29_1, var_29_2, var_29_3
end

local var_0_10 = class(nil, var_0_0)

var_0_0.ConfirmInvited = var_0_10

function var_0_10.create(arg_30_0, arg_30_1)
	local var_30_0 = var_0_10.new(lc.EXTEND_LAYOUT_MASK)

	var_30_0:init(cc.size(600, 420), arg_30_0, arg_30_1)

	var_30_0._hideBg = false

	return var_30_0
end

function var_0_10.init(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	var_0_7.super.init(arg_31_0, arg_31_1)

	local var_31_0 = arg_31_0._form
	local var_31_1 = lc.w(arg_31_0._form) / 2
	local var_31_2 = ClientView.createBoldRichText(Str(STR.INVITED_CONFIRM), ClientView.RICHTEXT_PARAM_LIGHT_S1, 440)

	lc.addChildToPos(var_31_0, var_31_2, cc.p(var_31_1, lc.h(var_31_0) - var_0_0.FRAME_THICK_TOP - 40 - lc.h(var_31_2) / 2))

	local var_31_3 = UserWidget.create(arg_31_2, UserWidget.Flag.REGION_NAME_UNION)

	lc.addChildToPos(var_31_0, var_31_3, cc.p(var_31_1, lc.bottom(var_31_2) - 40 - lc.h(var_31_3) / 2))
	var_31_3._regionArea:setColor(lc.Color3B.white)
	arg_31_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_31_1 - var_0_1 + 40, nil, function()
		arg_31_0:hide()
	end)
	arg_31_0:addButton("img_btn_1_s", Str(STR.OK), var_31_1 + var_0_1 - 40, nil, function()
		if arg_31_3 then
			arg_31_3()
		end

		arg_31_0:hide()
	end)
end

local var_0_11 = class(nil, var_0_0)

var_0_0.SelectRecruitFrag = var_0_11

function var_0_11.create(arg_34_0, arg_34_1)
	local var_34_0 = var_0_11.new(lc.EXTEND_LAYOUT_MASK)

	var_34_0:init(cc.size(600, 480), arg_34_0, arg_34_1)

	var_34_0._hideBg = false

	return var_34_0
end

function var_0_11.init(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	var_0_7.super.init(arg_35_0, arg_35_1)

	local var_35_0 = arg_35_0._form
	local var_35_1 = lc.w(arg_35_0._form) / 2
	local var_35_2 = ClientView.createBoldRichText(Str(STR.LOTTERY_FRAGMENT_TIP), ClientView.RICHTEXT_PARAM_DARK_S1, 440)

	lc.addChildToPos(var_35_0, var_35_2, cc.p(var_35_1, lc.h(var_35_0) - var_0_0.FRAME_THICK_TOP - 40 - lc.h(var_35_2) / 2))

	local var_35_3 = {
		1019,
		1041,
		1294
	}
	local var_35_4 = {}

	for iter_35_0, iter_35_1 in ipairs(var_35_3) do
		local var_35_5 = IconWidget.create({
			_isFragment = true,
			_infoId = iter_35_1
		}, IconWidget.DisplayFlag.ITEM)

		table.insert(var_35_4, var_35_5)
	end

	lc.addNodesToCenter(var_35_0, var_35_4, 50, lc.bottom(var_35_2) - IconWidget.SIZE)

	for iter_35_2, iter_35_3 in ipairs(var_35_4) do
		local var_35_6 = iter_35_3._data._infoId == arg_35_2

		if var_35_6 then
			arg_35_0._selectedIcon = iter_35_3
		end

		local var_35_7 = ClientView.createCheckLabelArea("", function(arg_36_0)
			if arg_36_0 then
				if arg_35_0._selectedIcon then
					arg_35_0._selectedIcon._selector:setCheck(false)
				end

				arg_35_0._selectedIcon = iter_35_3
			elseif arg_35_0._selectedIcon == iter_35_3 then
				arg_35_0._selectedIcon = nil
			end
		end, var_35_6)

		lc.addChildToPos(var_35_0, var_35_7, cc.p(lc.x(iter_35_3), lc.bottom(iter_35_3) - 32))

		iter_35_3._selector = var_35_7
	end

	arg_35_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_35_1 - var_0_1 + 40, nil, function()
		arg_35_0:hide()
	end)
	arg_35_0:addButton("img_btn_1_s", Str(STR.OK), var_35_1 + var_0_1 - 40, nil, function()
		if arg_35_3 then
			arg_35_3(arg_35_0._selectedIcon)
		end

		arg_35_0:hide()
	end)
end

local var_0_12 = class(nil, var_0_0)

var_0_0.ConfirmRematch = var_0_12

function var_0_12.create(arg_39_0)
	local var_39_0 = var_0_12.new(lc.EXTEND_LAYOUT_MASK)

	var_39_0:init(arg_39_0)

	var_39_0._hideBg = false

	return var_39_0
end

function var_0_12.init(arg_40_0, arg_40_1)
	var_0_12.super.init(arg_40_0, cc.size(700, 360), Str(STR.FIND_MATCH_NONE_TITLE))

	local var_40_0 = arg_40_0._form
	local var_40_1 = lc.w(arg_40_0._form) / 2

	arg_40_0:addTouchEventListener(function()
		return
	end)
	arg_40_0._btnBack:setVisible(false)

	local var_40_2 = ClientView.createBoldRichText(Str(STR.FIND_MATCH_NONE), ClientView.RICHTEXT_PARAM_LIGHT_S1, 550)

	lc.addChildToPos(var_40_0, var_40_2, cc.p(var_40_1, lc.h(var_40_0) - var_0_0.FRAME_THICK_TOP - 40 - lc.h(var_40_2) / 2))

	if arg_40_1 == Data.FindMatchType.clash then
		local var_40_3 = P._playerFindClash._grade

		arg_40_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_40_1 - var_0_1 / 2 - 20, var_0_2 + 80, function()
			ClientData.sendWorldFindExCancel()
			arg_40_0:hide()
		end)
		arg_40_0:addButton("img_btn_1_s", Str(STR.FIND_REMATCH), var_40_1 + var_0_1 / 2 + 20, var_0_2 + 80, function()
			lc.sendEvent(Data.Event.rematch_again)
			arg_40_0:hide()
		end)

		if var_0_12._troopIndex == nil then
			arg_40_0._troopDirty = true
		end

		arg_40_0._preTroopIndex = P._curTroopIndex
		arg_40_0._btnTroop = arg_40_0:addButton("img_btn_2", "", var_40_1 - var_0_1 / 2 - 20, nil, function()
			arg_40_0._troopDirty = true

			lc.pushScene(require("HeroCenterScene").create(var_0_12._troopIndex))
		end)

		arg_40_0:addButton("img_btn_1_s", Str(STR.FIND_MATCH_NPC), var_40_1 + var_0_1 / 2 + 20, nil, function()
			lc.sendEvent(Data.Event.rematch_npc)
			arg_40_0:hide()
		end)
	else
		local var_40_4 = ClientView.createBoldRichText(Str(STR.FIND_MATCH_NPC_MELEE), {
			_width = 500,
			_normalClr = ClientView.COLOR_TEXT_RED_DARK,
			_boldClr = ClientView.COLOR_TEXT_BLUE_DARK,
			_fontSize = ClientView.FontSize.S2
		})

		lc.addChildToPos(var_40_0, var_40_4, cc.p(var_40_1, lc.bottom(var_40_2) - 20 - lc.h(var_40_4) / 2))
		arg_40_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_40_1 - var_0_1 - 20, nil, function()
			ClientData.sendWorldFindExCancel()
			arg_40_0:hide()
		end)
		arg_40_0:addButton("img_btn_1_s", Str(STR.FIND_REMATCH), var_40_1, nil, function()
			lc.sendEvent(Data.Event.rematch_again)
			arg_40_0:hide()
		end)
		arg_40_0:addButton("img_btn_1_s", Str(STR.FIND_MATCH_NPC), var_40_1 + var_0_1 + 20, nil, function()
			lc.sendEvent(Data.Event.rematch_npc)
			arg_40_0:hide()
		end)
	end
end

function var_0_12.onEnter(arg_49_0)
	var_0_12.super.onEnter(arg_49_0)

	if arg_49_0._troopDirty then
		var_0_12._troopIndex = P._curTroopIndex
		arg_49_0._troopDirty = false
	end

	if arg_49_0._btnTroop then
		arg_49_0._btnTroop._label:setString(string.format("%s %d", Str(STR.TROOP), var_0_12._troopIndex))
	end
end

function var_0_12.hide(arg_50_0)
	if arg_50_0._preTroopIndex then
		P:setCurrentTroopIndex(arg_50_0._preTroopIndex)
	end

	lc.sendEvent(Data.Event.rematch_hide)
	var_0_12.super.hide(arg_50_0)
end

local var_0_13 = class(nil, var_0_0)

var_0_0.ConfirmCompose = var_0_13

function var_0_13.create(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = var_0_13.new(lc.EXTEND_LAYOUT_MASK)

	var_51_0:init(cc.size(700, 520), arg_51_0, arg_51_1, arg_51_2)

	var_51_0._hideBg = false

	return var_51_0
end

function var_0_13.init(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4)
	var_0_13.super.init(arg_52_0, arg_52_1)

	local var_52_0 = arg_52_0._form
	local var_52_1 = lc.w(arg_52_0._form) / 2
	local var_52_2 = ClientView.createBoldRichText(Str(STR.COMPOSE_WARN), ClientView.RICHTEXT_PARAM_LIGHT_S1, 540)

	lc.addChildToPos(var_52_0, var_52_2, cc.p(var_52_1, lc.h(var_52_0) - var_0_0.FRAME_THICK_TOP - 40 - lc.h(var_52_2) / 2))

	local var_52_3 = 120
	local var_52_4 = {
		cc.p(var_0_0.FRAME_THICK_LEFT + 20 + 0.5 * var_52_3, lc.bottom(var_52_2) - 10 - 0.5 * var_52_3),
		cc.p(var_0_0.FRAME_THICK_LEFT + 20 + 1.5 * var_52_3, lc.bottom(var_52_2) - 10 - 0.5 * var_52_3),
		cc.p(var_0_0.FRAME_THICK_LEFT + 20 + 2.5 * var_52_3, lc.bottom(var_52_2) - 10 - 0.5 * var_52_3),
		cc.p(var_0_0.FRAME_THICK_LEFT + 20 + 0.5 * var_52_3, lc.bottom(var_52_2) - 10 - 1.5 * var_52_3),
		cc.p(var_0_0.FRAME_THICK_LEFT + 20 + 1.5 * var_52_3, lc.bottom(var_52_2) - 10 - 1.5 * var_52_3),
		cc.p(var_0_0.FRAME_THICK_LEFT + 20 + 2.5 * var_52_3, lc.bottom(var_52_2) - 10 - 1.5 * var_52_3)
	}
	local var_52_5 = 1

	for iter_52_0, iter_52_1 in pairs(arg_52_3) do
		for iter_52_2 = 1, iter_52_1 do
			local var_52_6 = IconWidget.createByInfoId(iter_52_0)

			var_52_6:setScale(var_52_3 / lc.w(var_52_6), var_52_3 / lc.h(var_52_6))
			lc.addChildToPos(var_52_0, var_52_6, var_52_4[var_52_5])

			var_52_5 = var_52_5 + 1
		end
	end

	local var_52_7 = lc.createSprite("img_arrow_right_02")

	lc.addChildToPos(var_52_0, var_52_7, cc.p(var_0_0.FRAME_THICK_LEFT + 35 + 3 * var_52_3 + lc.cw(var_52_7), lc.bottom(var_52_2) - 10 - var_52_3))

	local var_52_8 = ClientView.createShaderButton(nil, function(arg_53_0)
		require("CardInfoPanel").create(arg_52_2, 1):show()
	end)

	var_52_8:setContentSize(cc.size(147, 210))
	var_52_8:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(var_52_0, var_52_8, cc.p(lc.right(var_52_7) + 20 + lc.cw(var_52_8), lc.bottom(var_52_2) - 5 - var_52_3))

	local var_52_9 = require("CardThumbnail").create(arg_52_2, 0.7)

	lc.addChildToCenter(var_52_8, var_52_9)
	arg_52_0:addButton("img_btn_2_s", Str(STR.CANCEL), var_52_1 - var_0_1 + 40, nil, function()
		arg_52_0:hide()
	end)
	arg_52_0:addButton("img_btn_1_s", Str(STR.OK), var_52_1 + var_0_1 - 40, nil, function()
		if arg_52_4 then
			arg_52_4()
		end

		arg_52_0:hide()
	end)
end

return var_0_0
