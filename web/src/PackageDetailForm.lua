local var_0_0 = class("PackageDetailForm", BaseForm)
local var_0_1 = cc.size(700, 360)
local var_0_2 = cc.size(560, 180)

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_0.super.init(arg_2_0, var_0_1, arg_2_2, bor(BaseForm.FLAG.ADVANCE_TITLE_BG, BaseForm.FLAG.PAPER_BG))

	local var_2_0 = {}

	for iter_2_0 = 1, #arg_2_1._rid do
		local var_2_1 = IconWidget.create({
			_infoId = arg_2_1._rid[iter_2_0],
			_count = arg_2_1._count[iter_2_0]
		})

		var_2_1._name:setColor(ClientView.COLOR_TEXT_LIGHT)
		table.insert(var_2_0, var_2_1)
	end

	P:sortResultItems(var_2_0)

	local var_2_2 = 20
	local var_2_3 = (104 + var_2_2) * #var_2_0 - var_2_2
	local var_2_4 = lc.w(arg_2_0._frame) - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT
	local var_2_5 = lc.List.createH(cc.size(var_2_4, 130), (var_2_4 - var_2_3) / 2, var_2_2)

	var_2_5:setAnchorPoint(0.5, 0.5)
	lc.addChildToCenter(arg_2_0._frame, var_2_5)

	for iter_2_1, iter_2_2 in ipairs(var_2_0) do
		var_2_5:pushBackCustomItem(iter_2_2)
	end
end

return var_0_0
