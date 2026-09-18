local var_0_0 = class("DarkUserInfoForm", BaseForm)
local var_0_1 = cc.size(710, 600)
local var_0_2 = cc.size(570, 310)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._userId = userId
	arg_2_0._indicator = ClientView.showPanelActiveIndicator(arg_2_0._form)

	ClientData.sendGetDarkInfo()
end

function var_0_0.initDark(arg_3_0, arg_3_1)
	local var_3_0 = P
	local var_3_1 = arg_3_0._form
	local var_3_2 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(var_3_1, var_3_2, cc.p(lc.w(var_3_1) / 2, lc.h(var_3_1) - var_0_0.FRAME_THICK_TOP - lc.h(var_3_2) / 2))

	local var_3_3 = ClientView.createTTF(Str(STR.DARK_BATTLE), ClientView.FontSize.M2)

	lc.addChildToPos(var_3_2, var_3_3, cc.p(lc.w(var_3_2) / 2, 40))

	local var_3_4 = UserWidget.create(var_3_0, UserWidget.Flag.NAME_UNION, 1, false, true)

	lc.addChildToPos(var_3_1, var_3_4, cc.p(var_0_0.FRAME_THICK_LEFT + 40 + lc.w(var_3_4) / 2, lc.bottom(var_3_2) - 30 - lc.h(var_3_4) / 2))
	var_3_4._unionArea._name:setColor(ClientView.COLOR_TEXT_ORANGE)

	local var_3_5 = lc.createImageView({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = var_0_2
	})

	lc.addChildToPos(var_3_1, var_3_5, cc.p(lc.w(var_3_1) / 2, lc.bottom(var_3_4) - lc.h(var_3_5) / 2 - 20))

	local var_3_6 = ClientView.addDecoratedLabel(var_3_5, Str(STR.FIND_DARK_RECORD), cc.p(lc.w(var_3_5) / 2, lc.h(var_3_5) - 50), 26)
	local var_3_7 = ClientView.createIconLabelArea("img_icon_res16_s", var_3_0._playerFindDark._trophy, 160)

	lc.addChildToPos(var_3_5, var_3_7, cc.p(lc.w(var_3_5) - lc.cw(var_3_7) - 20, lc.y(var_3_6:getParent())))

	local var_3_8 = ClientView.createTTF(Str(STR.BATTLE_WIN) .. "  " .. arg_3_1.total_win, ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE)

	var_3_8:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_3_5, var_3_8, cc.p(lc.left(var_3_6:getParent()) + 13, lc.bottom(var_3_6:getParent()) - 25 - lc.ch(var_3_8)))

	local var_3_9 = ClientView.createTTF(Str(STR.BATTLE_LOSE) .. "  " .. arg_3_1.total_lose, ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE)

	var_3_9:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_3_5, var_3_9, cc.p(lc.w(var_3_5) - lc.w(var_3_9) - 40, lc.y(var_3_8)))

	local var_3_10 = lc.createSprite({
		_name = "img_divide_line_8",
		_crect = cc.rect(6, 1, 1, 1),
		_size = cc.size(lc.w(var_3_5) - 16, 5)
	})

	lc.addChildToPos(var_3_5, var_3_10, cc.p(lc.cw(var_3_5), lc.ch(var_3_5)))
	var_3_10:setRotation(180)

	local var_3_11 = ClientView.createTTF("2:0" .. Str(STR.GET_WIN) .. "  " .. arg_3_1.two_zero_win, ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE)

	var_3_11:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_3_5, var_3_11, cc.p(lc.x(var_3_8), lc.ch(var_3_5) - 30 - lc.ch(var_3_11)))

	local var_3_12 = ClientView.createTTF("0:2" .. Str(STR.GET_LOSE) .. "  " .. arg_3_1.zero_two_lose, ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE)

	var_3_12:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_3_5, var_3_12, cc.p(lc.x(var_3_9), lc.y(var_3_11)))

	local var_3_13 = ClientView.createTTF("2:1" .. Str(STR.GET_WIN) .. "  " .. arg_3_1.two_one_win, ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE)

	var_3_13:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_3_5, var_3_13, cc.p(lc.x(var_3_8), lc.bottom(var_3_11) - 16 - lc.ch(var_3_13)))

	local var_3_14 = ClientView.createTTF("1:2" .. Str(STR.GET_LOSE) .. "  " .. arg_3_1.one_two_lose, ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE)

	var_3_14:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_3_5, var_3_14, cc.p(lc.x(var_3_9), lc.y(var_3_13)))

	local var_3_15 = ClientView.createTTF("1:0" .. Str(STR.GET_WIN) .. "  " .. arg_3_1.one_zero_win, ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE)

	var_3_15:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_3_5, var_3_15, cc.p(lc.x(var_3_8), lc.bottom(var_3_13) - 16 - lc.ch(var_3_15)))

	local var_3_16 = ClientView.createTTF("0:1" .. Str(STR.GET_LOSE) .. "  " .. arg_3_1.zero_one_lose, ClientView.FontSize.S2, ClientView.COLOR_TEXT_WHITE)

	var_3_16:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_3_5, var_3_16, cc.p(lc.x(var_3_9), lc.y(var_3_15)))
end

function var_0_0.createLabelValueArea(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = lc.createNode(cc.size(220, 46))

	var_4_0:setAnchorPoint(cc.p(0, 0.5))

	local var_4_1 = ClientView.createTTF(arg_4_1, ClientView.FontSize.S2, ClientView.COLOR_TEXT_LIGHT)

	lc.addChildToPos(var_4_0, var_4_1, cc.p(lc.cw(var_4_1), lc.ch(var_4_0)))

	local var_4_2 = ClientView.createTTF(arg_4_2 == 0 and Str(STR.VOID_SHORT) or arg_4_2, ClientView.FontSize.M1, ClientView.COLOR_TEXT_LIGHT)

	lc.addChildToPos(var_4_0, var_4_2, cc.p(lc.right(var_4_1) + 40, lc.ch(var_4_0) - lc.ch(var_4_1) + lc.ch(var_4_2) - 2))

	return var_4_0
end

function var_0_0.onEnter(arg_5_0)
	var_0_0.super.onEnter(arg_5_0)
	ClientData.addMsgListener(arg_5_0, function(arg_6_0)
		return arg_5_0:onMsg(arg_6_0)
	end, 0)
end

function var_0_0.onExit(arg_7_0)
	var_0_0.super.onExit(arg_7_0)
	ClientData.removeMsgListener(arg_7_0)
end

function var_0_0.onMsg(arg_8_0, arg_8_1)
	if arg_8_1.type == SglMsgType_pb.PB_TYPE_WORLD_DARK_DUEL_DASHBOARD then
		local var_8_0 = arg_8_1.Extensions[World_pb.SglWorldMsg.dark_duel_dash_board_resp]

		arg_8_0:initDark(var_8_0)

		if arg_8_0._indicator then
			arg_8_0._indicator:removeFromParent()

			arg_8_0._indicator = nil
		end

		return true
	end

	return false
end

return var_0_0
