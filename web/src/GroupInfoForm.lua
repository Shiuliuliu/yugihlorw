local var_0_0 = class("GroupInfoForm", BaseForm)
local var_0_1 = cc.size(710, 600)
local var_0_2 = cc.size(570, 310)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, nil, bor(BaseForm.FLAG.PAPER_BG))

	local var_2_0 = arg_2_0._form
	local var_2_1 = lc.createSprite("img_title_bg_1")

	lc.addChildToPos(var_2_0, var_2_1, cc.p(lc.w(var_2_0) / 2, lc.h(var_2_0) - var_0_0.FRAME_THICK_TOP - lc.h(var_2_1) / 2))

	local var_2_2 = ClientView.createTTF(Str(STR.GROUP_INFO), ClientView.FontSize.M2)

	lc.addChildToPos(var_2_1, var_2_2, cc.p(lc.w(var_2_1) / 2, 40))

	local var_2_3 = require("GroupWidget")
	local var_2_4 = var_2_3.create(arg_2_1, bor(var_2_3.Flag.NAME, var_2_3.Flag.REGION), 1)

	lc.addChildToPos(var_2_0, var_2_4, cc.p(lc.cw(arg_2_0._form), lc.bottom(var_2_1) - 30 - lc.h(var_2_4) / 2))

	local var_2_5 = lc.createSprite({
		_name = "group_avatars_bg",
		_crect = cc.rect(1, 1, 2, 2),
		_size = cc.size(lc.w(var_2_0) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, 200)
	})

	lc.addChildToPos(var_2_0, var_2_5, cc.p(lc.cw(var_2_0), 50 + lc.ch(var_2_5) + ClientView.FRAME_INNER_BOTTOM))

	local var_2_6 = ClientView.createTTF(Str(STR.GROUP) .. Str(STR.UNION_MEMBER), ClientView.FontSize.S1)

	lc.addChildToPos(var_2_0, var_2_6, cc.p(lc.cw(var_2_0), lc.top(var_2_5) + lc.ch(var_2_6) + 10))

	local var_2_7 = 0
	local var_2_8 = arg_2_1._members

	for iter_2_0 = 1, Data.GROUP_NUM do
		local var_2_9 = ClientView.createUnionGroupMemItem(arg_2_1._id, var_2_8[iter_2_0], false, false)

		var_2_9._canOperate = false

		lc.addChildToPos(var_2_5, var_2_9, cc.p(var_2_7 + iter_2_0 * 120 - 30, lc.ch(var_2_5)))
	end

	for iter_2_1 = Data.GROUP_NUM + 1, 5 do
		local var_2_10 = lc.createSprite("group_mem_lock")

		lc.addChildToPos(var_2_5, var_2_10, cc.p(var_2_7 + iter_2_1 * 120 - 30, lc.ch(var_2_5) + 5))
	end
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)
end

function var_0_0.onExit(arg_4_0)
	var_0_0.super.onExit(arg_4_0)
end

return var_0_0
