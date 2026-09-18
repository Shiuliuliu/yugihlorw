local var_0_0 = class("FundForm", BaseForm)
local var_0_1 = cc.size(1000, 720)
local var_0_2 = cc.size(210, 400)

var_0_0.Tab = {
	all = 2,
	level = 1
}

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.FUND), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))
	arg_2_0._form:setTouchEnabled(false)

	local var_2_0 = lc.createNode(cc.size(lc.w(arg_2_0._form) - var_0_0.LEFT_MARGIN - var_0_0.RIGHT_MARGIN, lc.h(arg_2_0._form) - var_0_0.TOP_MARGIN - var_0_0.BOTTOM_MARGIN))

	lc.addChildToCenter(arg_2_0._form, var_2_0)

	arg_2_0._area = var_2_0

	local var_2_1 = {
		{
			_str = Str(STR.FUND_LEVEL)
		},
		{
			_str = Str(STR.FUND_BONUS)
		}
	}
	local var_2_2 = ClientView.createVerticalTabListArea(lc.h(var_2_0), var_2_1, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0:showTab(arg_3_0._index, not arg_3_1, arg_3_2)
	end)

	lc.addChildToPos(var_2_0, var_2_2, cc.p(lc.w(var_2_2) / 2 - 12, lc.h(var_2_0) / 2))

	arg_2_0._tabArea = var_2_2

	arg_2_0:initFundArea()

	local var_2_3 = lc.List.createV(cc.size(lc.w(var_2_0) - lc.right(var_2_2) - 4, lc.h(var_2_0)), 10, 0)

	lc.addChildToPos(var_2_0, var_2_3, cc.p(lc.right(var_2_2), 0))

	arg_2_0._list = var_2_3

	var_2_2:showTab(var_0_0.Tab.level, false)
end

function var_0_0.initFundArea(arg_4_0)
	local var_4_0 = lc.createSprite({
		_name = "img_com_bg_4",
		_crect = ClientView.CRECT_COM_BG4,
		_size = var_0_2
	})

	lc.addChildToPos(arg_4_0._tabArea, var_4_0, cc.p(lc.w(arg_4_0._tabArea) / 2, lc.h(var_4_0) / 2 + 18))

	arg_4_0._fundArea = var_4_0

	local var_4_1 = lc.createSprite({
		_name = "img_com_bg_19",
		_crect = cc.rect(42, 0, 1, 46),
		_size = cc.size(150, 46)
	})

	lc.addChildToPos(var_4_0, var_4_1, cc.p(var_0_2.width / 2, lc.h(var_4_0) - lc.h(var_4_1) / 2 + 4))

	local var_4_2 = ClientView.createTTF(string.format(Str(STR.FUND_TIP), 10), ClientView.FontSize.S1)

	lc.addChildToCenter(var_4_1, var_4_2)
	lc.offset(var_4_2, 0, 2)

	local var_4_3 = string.format(Str(STR.FUND_DESC), ClientData.getIngot(Data.PurchaseType.fund), 8888)
	local var_4_4 = ClientView.createBoldRichText(var_4_3, {
		_normalClr = ClientView.COLOR_TEXT_DARK,
		_boldClr = ClientView.COLOR_TEXT_RED_DARK,
		_width = var_0_2.width - 52
	})

	lc.addChildToPos(var_4_0, var_4_4, cc.p(var_0_2.width / 2, lc.bottom(var_4_1) - 20 - lc.h(var_4_4) / 2))

	local var_4_5 = lc.createSprite("img_glow")

	var_4_5:setScale(0.8)
	lc.addChildToPos(var_4_0, var_4_5, cc.p(var_0_2.width / 2, 120))

	local var_4_6 = ClientView.createTTF(Str(STR.BOUGHT_NUM), ClientView.FontSize.S2, ClientView.COLOR_LABEL_DARK)

	lc.addChildToPos(var_4_0, var_4_6, cc.p(var_0_2.width / 2, 160))

	local var_4_7 = ClientView.createBMFont(ClientView.BMFont.num_48, P._playerBonus._bonusFundAll[1]._value)

	lc.addChildToPos(var_4_0, var_4_7, cc.p(var_0_2.width / 2, 120))

	arg_4_0._buyCount = var_4_7

	arg_4_0:checkBuyFund()
end

function var_0_0.checkBuyFund(arg_5_0)
	local var_5_0 = arg_5_0._fundArea

	if ClientData.isRecharged(Data.PurchaseType.fund) then
		if arg_5_0._btnBuy then
			arg_5_0._btnBuy:removeFromParent()

			arg_5_0._btnBuy = nil
		end

		if arg_5_0._boughtFlag == nil then
			local var_5_1 = ClientView.createStatusLabel(Str(STR.PURCHASED), ClientView.COLOR_TEXT_GREEN)

			lc.addChildToPos(var_5_0, var_5_1, cc.p(var_0_2.width / 2, 56))

			arg_5_0._boughtFlag = var_5_1
		end
	elseif arg_5_0._btnBuy == nil then
		local var_5_2 = ClientView.createScale9ShaderButton("img_btn_3", function()
			lc.pushScene(require("RechargeScene").create())
		end, ClientView.CRECT_BUTTON, 150)

		var_5_2:addLabel(Str(STR.BUY) .. Str(STR.FUND))
		lc.addChildToPos(var_5_0, var_5_2, cc.p(var_0_2.width / 2, 56))

		arg_5_0._btnBuy = var_5_2
	end
end

function var_0_0.showTab(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_2 then
		return
	end

	arg_7_0._focusTabIndex = arg_7_1

	arg_7_0:refreshList()
end

function var_0_0.showTabFlag(arg_8_0)
	local var_8_0 = arg_8_0._tabArea._list:getItems()

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1 = 0

		if iter_8_0 == var_0_0.Tab.level then
			var_8_1 = P._playerBonus:getFundLevelBonusFlag()
		elseif iter_8_0 == var_0_0.Tab.all then
			var_8_1 = P._playerBonus:getFundAllBonusFlag()
		end

		local var_8_2 = var_8_0[iter_8_0]

		ClientView.checkNewFlag(var_8_2, var_8_1)
	end
end

function var_0_0.show(arg_9_0)
	var_0_0.super.show(arg_9_0)

	ClientView._fundForm = arg_9_0
end

function var_0_0.hide(arg_10_0)
	var_0_0.super.hide(arg_10_0)

	ClientView._fundForm = nil
end

function var_0_0.onEnter(arg_11_0)
	var_0_0.super.onEnter(arg_11_0)

	arg_11_0._listeners = {}

	local var_11_0 = lc.addEventListener(Data.Event.level_dirty, function(arg_12_0)
		arg_11_0:refreshList()
	end)

	table.insert(arg_11_0._listeners, var_11_0)

	local var_11_1 = lc.addEventListener(Data.Event.bonus_dirty, function(arg_13_0)
		if arg_13_0._data._info._type == Data.BonusType.fund_all then
			arg_11_0._buyCount:setString(P._playerBonus._bonusFundAll[1]._value)
			arg_11_0:checkBuyFund()
		end
	end)

	table.insert(arg_11_0._listeners, var_11_1)
end

function var_0_0.onExit(arg_14_0)
	var_0_0.super.onExit(arg_14_0)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_14_1)
	end

	if not ClientView.isInBattleScene() then
		-- block empty
	end
end

function var_0_0.onCleanup(arg_15_0)
	var_0_0.super.onCleanup(arg_15_0)
end

function var_0_0.refreshList(arg_16_0)
	local var_16_0 = arg_16_0._list
	local var_16_1

	if arg_16_0._focusTabIndex == var_0_0.Tab.level then
		var_16_1 = P._playerBonus._bonusFundLevel
	elseif arg_16_0._focusTabIndex == var_0_0.Tab.all then
		var_16_1 = P._playerBonus._bonusFundAll
	end

	local var_16_2 = {}
	local var_16_3, var_16_4, var_16_5 = P._playerBonus.splitBonus(var_16_1)

	for iter_16_0, iter_16_1 in ipairs(var_16_3) do
		table.insert(var_16_2, iter_16_1)
	end

	for iter_16_2, iter_16_3 in ipairs(var_16_4) do
		table.insert(var_16_2, iter_16_3)
	end

	for iter_16_4, iter_16_5 in ipairs(var_16_5) do
		table.insert(var_16_2, iter_16_5)
	end

	var_16_0:bindData(var_16_2, function(arg_17_0, arg_17_1)
		arg_16_0:setOrCreateItem(arg_17_0, arg_17_1)
	end, math.min(5, #var_16_2))

	for iter_16_6 = 1, var_16_0._cacheCount do
		var_16_0:pushBackCustomItem(arg_16_0:setOrCreateItem(nil, var_16_2[iter_16_6]))
	end

	var_16_0:setContentSize(lc.w(var_16_0), lc.h(arg_16_0._area))
	var_16_0:forceDoLayout()
	var_16_0:gotoTop()
	arg_16_0:showTabFlag()
end

function var_0_0.setOrCreateItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = string.format(Str(arg_18_2._info._nameSid), arg_18_2._info._val)

	if arg_18_1 == nil then
		arg_18_1 = require("BonusWidget").create(lc.w(arg_18_0._list), arg_18_2, var_18_0)
	else
		arg_18_1:setBonus(arg_18_2, var_18_0)
	end

	arg_18_1:registerCallback(function(arg_19_0)
		arg_18_0:claim(arg_19_0)
	end)

	return arg_18_1
end

function var_0_0.claim(arg_20_0, arg_20_1)
	if arg_20_1._value >= arg_20_1._info._val and not arg_20_1._isClaimed then
		local var_20_0 = ClientData.claimBonus(arg_20_1)

		arg_20_0:refreshList()
		ClientView.showClaimBonusResult(arg_20_1, var_20_0)
	end
end

return var_0_0
