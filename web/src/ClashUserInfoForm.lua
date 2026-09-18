local var_0_0 = class("ClashUserInfoForm", BaseForm)
local var_0_1 = cc.size(710, 600)
local var_0_2 = cc.size(570, 310)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	arg_2_0._userId = arg_2_1
	arg_2_0._indicator = ClientView.showPanelActiveIndicator(arg_2_0._form)
end

function var_0_0.initVisit(arg_3_0, arg_3_1)
	local var_3_0 = require("User").create(arg_3_1.user_info)
	local var_3_1 = P._playerFindClash:getGrade(var_3_0._trophy)
	local var_3_2 = arg_3_0._form
	local var_3_3 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(var_3_2, var_3_3, cc.p(lc.w(var_3_2) / 2, lc.h(var_3_2) - var_0_0.FRAME_THICK_TOP - lc.h(var_3_3) / 2))

	local var_3_4 = ClientView.createTTF(Str(Data._ladderInfo[var_3_1]._nameSid) .. Str(STR.FIND_CLASH_FIELD), ClientView.FontSize.M2)

	lc.addChildToPos(var_3_3, var_3_4, cc.p(lc.w(var_3_3) / 2, 40))

	local var_3_5 = UserWidget.create(var_3_0, UserWidget.Flag.NAME_UNION, 1, false, true)

	lc.addChildToPos(var_3_2, var_3_5, cc.p(var_0_0.FRAME_THICK_LEFT + 40 + lc.w(var_3_5) / 2, lc.bottom(var_3_3) - 30 - lc.h(var_3_5) / 2))
	var_3_5._unionArea._name:setColor(ClientView.COLOR_TEXT_ORANGE)

	local var_3_6 = lc.createImageView({
		_name = "img_com_bg_11",
		_crect = ClientView.CRECT_COM_BG11,
		_size = var_0_2
	})

	lc.addChildToPos(var_3_2, var_3_6, cc.p(lc.w(var_3_2) / 2, lc.bottom(var_3_5) - lc.h(var_3_6) / 2 - 20))

	local var_3_7 = ClientView.addDecoratedLabel(var_3_6, Str(STR.FIND_CLASH_RECORD), cc.p(lc.w(var_3_6) / 2, lc.h(var_3_6) - 50), 26)
	local var_3_8 = ClientView.createIconLabelArea("img_icon_res6_s", var_3_0._trophy, 160)

	lc.addChildToPos(var_3_6, var_3_8, cc.p(lc.w(var_3_6) - lc.cw(var_3_8) - 20, lc.y(var_3_7:getParent())))

	local var_3_9 = arg_3_0:createLabelValueArea(Str(STR.SEASON_LAST_RANK), arg_3_1.pre_rank)

	lc.addChildToPos(var_3_6, var_3_9, cc.p(lc.left(var_3_7:getParent()) + 13, lc.bottom(var_3_7:getParent()) - 16 - lc.ch(var_3_9)))

	local var_3_10 = arg_3_0:createLabelValueArea(Str(STR.SEASON_BEST_RANK), arg_3_1.best_rank)

	lc.addChildToPos(var_3_6, var_3_10, cc.p(lc.cw(var_3_6) + 20, lc.y(var_3_9)))

	local var_3_11 = lc.createSprite({
		_name = "img_divide_line_8",
		_crect = cc.rect(6, 1, 1, 1),
		_size = cc.size(lc.w(var_3_6) - 16, 5)
	})

	lc.addChildToPos(var_3_6, var_3_11, cc.p(lc.cw(var_3_6), lc.ch(var_3_6)))
	var_3_11:setRotation(180)

	local var_3_12 = ClientView.addDecoratedLabel(var_3_6, Str(STR.FIND_CLASH_LEGEND_RECORD), cc.p(lc.cw(var_3_6), lc.ch(var_3_6) - 45), 26, 1)
	local var_3_13 = ClientView.createIconLabelArea("img_icon_res23_s", arg_3_1.legend_trophy, 160)

	lc.addChildToPos(var_3_6, var_3_13, cc.p(lc.w(var_3_6) - lc.cw(var_3_13) - 20, lc.y(var_3_12:getParent())))

	local var_3_14 = arg_3_0:createLabelValueArea(Str(STR.SEASON_LAST_RANK), arg_3_1.pre_legend_rank)

	lc.addChildToPos(var_3_6, var_3_14, cc.p(lc.left(var_3_12:getParent()) + 13, lc.bottom(var_3_12:getParent()) - 16 - lc.ch(var_3_14)))

	local var_3_15 = arg_3_0:createLabelValueArea(Str(STR.SEASON_BEST_RANK), arg_3_1.best_legend_rank)

	lc.addChildToPos(var_3_6, var_3_15, cc.p(lc.cw(var_3_6) + 20, lc.y(var_3_14)))
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

function var_0_0.onShowActionFinished(arg_8_0)
	ClientData.sendUserVisitRegion(arg_8_0._userId)
end

function var_0_0.onMsg(arg_9_0, arg_9_1)
	if arg_9_1.type == SglMsgType_pb.PB_TYPE_USER_VISIT_EX then
		local var_9_0 = arg_9_1.Extensions[User_pb.SglUserMsg.user_visit_ex_resp]

		arg_9_0:initVisit(var_9_0)

		if arg_9_0._indicator then
			arg_9_0._indicator:removeFromParent()

			arg_9_0._indicator = nil
		end

		return true
	end

	return false
end

return var_0_0
