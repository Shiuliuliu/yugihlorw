local var_0_0 = class("GiveFundForm", BaseForm)
local var_0_1 = cc.size(740, 570)
local var_0_2 = 140

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._member = arg_2_1

	local var_2_0 = Data.PropsId.union_fund
	local var_2_1, var_2_2 = Data.getInfo(var_2_0)
	local var_2_3 = 1
	local var_2_4 = P:getItemCount(var_2_0)
	local var_2_5 = arg_2_0._form
	local var_2_6 = IconWidget.create({
		_infoId = var_2_0,
		_count = var_2_3
	}, IconWidget.DisplayFlag.COUNT)

	lc.addChildToPos(var_2_5, var_2_6, cc.p(120, lc.h(var_2_5) - lc.h(var_2_6) / 2 - var_0_0.FRAME_THICK_TOP - 30))

	arg_2_0._icon = var_2_6

	local var_2_7 = ClientView.createTTF(ClientData.getNameByInfoId(var_2_0), ClientView.FontSize.S1, ClientView.COLOR_TEXT_LIGHT)
	local var_2_8 = lc.createSprite({
		_name = "img_com_bg_2",
		_crect = ClientView.CRECT_COM_BG2,
		_size = cc.size(400, 40)
	})

	var_2_8:setColor(lc.Color3B.black)
	var_2_8:setOpacity(100)
	lc.addChildToPos(var_2_8, var_2_7, cc.p(30 + lc.w(var_2_7) / 2, lc.h(var_2_8) / 2 - 1))
	lc.addChildToPos(var_2_5, var_2_8, cc.p(lc.right(var_2_6) - 10 + lc.w(var_2_8) / 2, lc.top(var_2_6) - lc.h(var_2_8) / 2 - 10), -1)

	local var_2_9 = ClientView.createTTF(string.format("(%s: %s)", Str(STR.CURRENT_OWN), ClientData.formatNum(var_2_4, 9999)), ClientView.FontSize.S1, ClientView.COLOR_LABEL_DARK)

	lc.addChildToPos(var_2_5, var_2_9, cc.p(lc.w(var_2_5) - lc.w(var_2_9) / 2 - 60, lc.y(var_2_8)))

	local var_2_10 = string.format(Str(STR.UNION_GIVE_FUND_DESC), 200)
	local var_2_11 = ClientView.createBoldRichText(var_2_10, ClientView.RICHTEXT_PARAM_DARK_S1, 440)

	lc.addChildToPos(var_2_5, var_2_11, cc.p(lc.right(var_2_6) + 20 + lc.w(var_2_11) / 2, lc.top(var_2_6) - 60 - lc.h(var_2_11) / 2))

	local var_2_12 = lc.createSprite({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = cc.size(600, 120)
	})

	lc.addChildToPos(var_2_5, var_2_12, cc.p(lc.w(var_2_5) / 2, lc.bottom(var_2_11) - 20 - lc.h(var_2_12) / 2))

	local var_2_13 = ClientView.createTTF(Str(STR.UNION_GIVE_FUND_TO), ClientView.FontSize.S1, ClientView.COLOR_LABEL_DARK)
	local var_2_14 = require("UserWidget").create(arg_2_1, UserWidget.Flag.NAME_UNION, 0.5)

	var_2_14._unionArea._name:setVisible(false)
	var_2_14._unionArea:setAnchorPoint(0, 0.5)
	var_2_14._unionArea:setPosition(math.floor(lc.right(var_2_14._frame) + 10), lc.y(var_2_14._frame))
	var_2_14._nameArea:setPosition(math.floor(lc.right(var_2_14._frame) + 60), lc.y(var_2_14._frame))
	var_2_14:setContentSize(lc.w(var_2_14) + 40, lc.h(var_2_14))
	lc.addNodesToCenter(var_2_12, {
		var_2_13,
		var_2_14
	}, 10, lc.h(var_2_12) / 2 + 2)

	local var_2_15 = ClientView.createBoldRichText(Str(STR.UNION_GIVE_FUND_CONFIRM), ClientView.RICHTEXT_PARAM_DARK_S1, 570)

	lc.addChildToPos(var_2_5, var_2_15, cc.p(lc.w(var_2_5) / 2, lc.bottom(var_2_12) - 20 - lc.h(var_2_15) / 2))

	local var_2_16 = ClientView.createScale9ShaderButton("img_btn_2", function()
		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, var_0_2)

	var_2_16:addLabel(Str(STR.CANCEL))
	lc.addChildToPos(var_2_5, var_2_16, cc.p(lc.left(var_2_12) + lc.w(var_2_16) / 2, lc.bottom(var_2_15) - 20 - lc.h(var_2_16) / 2))

	local var_2_17 = ClientView.createScale9ShaderButton("img_btn_1", function()
		arg_2_0:giveFund()
	end, ClientView.CRECT_BUTTON, var_0_2)

	var_2_17:addLabel(Str(STR.UNION_GIVE_FUND))
	lc.addChildToPos(var_2_5, var_2_17, cc.p(lc.right(var_2_12) - lc.w(var_2_17) / 2, lc.y(var_2_16)))

	local var_2_18 = ClientView.createScale9ShaderButton("img_btn_3", function()
		lc.pushScene(require("RechargeScene").create())
		arg_2_0:hide()
	end, ClientView.CRECT_BUTTON, var_0_2)

	var_2_18:addLabel(Str(STR.BUY))
	lc.addChildToPos(var_2_5, var_2_18, cc.p(lc.left(var_2_17) - 10 - lc.w(var_2_18) / 2, lc.y(var_2_16)))
end

function var_0_0.giveFund(arg_6_0)
	local var_6_0 = Data.PropsId.union_fund

	if P:getItemCount(var_6_0) > 0 then
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
		ClientData.sendGiveFund(arg_6_0._member._id)
	else
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(var_6_0)))
	end
end

function var_0_0.onEnter(arg_7_0)
	var_0_0.super.onEnter(arg_7_0)
	ClientData.addMsgListener(arg_7_0, function(arg_8_0)
		return arg_7_0:onMsg(arg_8_0)
	end, 0)
end

function var_0_0.onExit(arg_9_0)
	var_0_0.super.onExit(arg_9_0)
	ClientData.removeMsgListener(arg_9_0)
end

function var_0_0.onMsg(arg_10_0, arg_10_1)
	if arg_10_1.type == SglMsgType_pb.PB_TYPE_USER_GIVE_FUND then
		ClientView.getActiveIndicator():hide()
		P._propBag:changeProps(Data.PropsId.union_fund, -1)
		ToastManager.push(string.format(Str(STR.UNION_GIVE_FUND_SUCCESS), arg_10_0._member._name))
		arg_10_0:hide()

		return true
	end

	return false
end

return var_0_0
