local var_0_0 = class("LotteryRecordForm", BaseForm)
local var_0_1 = cc.size(600, 500)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._heroId = arg_2_1

	local var_2_0 = IconWidget.create({
		_infoId = arg_2_1
	}, IconWidget.DisplayFlag.ITEM_NO_NAME)

	lc.addChildToPos(arg_2_0._frame, var_2_0, cc.p(lc.w(arg_2_0._frame) / 2, lc.top(arg_2_0._frame)))

	arg_2_0._activeIndicator = ClientView.showPanelActiveIndicator(arg_2_0._form)
end

function var_0_0.initView(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._form
	local var_3_1 = Data._globalInfo._lotteryLegendIngot
	local var_3_2 = arg_3_1.min * var_3_1
	local var_3_3 = arg_3_1.max * var_3_1
	local var_3_4 = arg_3_1.legend == 0 and 0 or math.floor(arg_3_1.total * var_3_1 / arg_3_1.legend)
	local var_3_5 = lc.createSprite("img_name_bg_01")

	var_3_5:setScale(0.8)
	lc.addChildToPos(var_3_0, var_3_5, cc.p(lc.w(var_3_0) / 2, lc.h(var_3_0) - var_0_0.FRAME_THICK_TOP - 30 - math.floor(lc.sh(var_3_5) / 2)), 1)

	local var_3_6 = ClientView.createTTF(Str(STR.RECRUIT_LEGEND_LUCKY), ClientView.FontSize.S2, ClientView.COLOR_TEXT_LIGHT)

	lc.addChildToPos(var_3_0, var_3_6, cc.p(lc.x(var_3_5), lc.y(var_3_5) + 4), 1)

	local var_3_7

	if arg_3_1:HasField("min_info") then
		var_3_7 = require("UserWidget").create(require("User").create(arg_3_1.min_info), UserWidget.Flag.NAME_UNION)
	else
		var_3_7 = require("UserWidget").create(nil)
	end

	lc.addChildToPos(var_3_0, var_3_7, cc.p(lc.w(var_3_5) + 74, math.floor(lc.bottom(var_3_5)) - 6 - lc.h(var_3_7) / 2))

	local var_3_8 = lc.createImageView({
		_name = "img_com_bg_10",
		_crect = ClientView.CRECT_COM_BG10,
		_size = cc.size(450, 190)
	})

	lc.addChildToPos(var_3_0, var_3_8, cc.p(lc.x(var_3_5), lc.bottom(var_3_7) - 30 - lc.h(var_3_8) / 2))

	local function var_3_9(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = ClientView.createKeyValueLabel(arg_4_0, arg_4_1 == 0 and "?????" or tostring(arg_4_1), ClientView.FontSize.S1, false, "img_icon_res3_s")

		var_4_0:addToParent(var_3_8, cc.p(100, arg_4_2 - lc.h(var_4_0) / 2))

		return var_4_0
	end

	local var_3_10 = var_3_9(Str(STR.CONSUME_MIN), var_3_2, lc.h(var_3_8) - 30)
	local var_3_11 = var_3_9(Str(STR.CONSUME_AVERAGE), var_3_4, lc.bottom(var_3_10) - 14)
	local var_3_12 = var_3_9(Str(STR.CONSUME_MAX), var_3_3, lc.bottom(var_3_11) - 14)
end

function var_0_0.onEnter(arg_5_0)
	var_0_0.super.onEnter(arg_5_0)
	ClientData.addMsgListener(arg_5_0, function(arg_6_0)
		return arg_5_0:onMsg(arg_6_0)
	end, 0)
	ClientData.sendCardLotteryRecord(arg_5_0._heroId)
end

function var_0_0.onExit(arg_7_0)
	var_0_0.super.onExit(arg_7_0)
	ClientData.removeMsgListener(arg_7_0)
end

function var_0_0.onMsg(arg_8_0, arg_8_1)
	if arg_8_1.type == SglMsgType_pb.PB_TYPE_CARD_LOTTERY_RECORD then
		if arg_8_0._activeIndicator then
			arg_8_0._activeIndicator:removeFromParent()

			arg_8_0._activeIndicator = nil
		end

		local var_8_0 = arg_8_1.Extensions[Card_pb.SglCardMsg.card_lottery_record_resp]

		arg_8_0:initView(var_8_0)

		return true
	end

	return false
end

return var_0_0
