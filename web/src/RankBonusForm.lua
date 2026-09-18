local var_0_0 = class("RankBonusForm", BaseForm)
local var_0_1 = cc.size(800, 600)
local var_0_2 = cc.size(800, 630)
local var_0_3 = cc.size(800, 450)

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.createClash(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_2_0:initClash(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = P._playerRank

	arg_3_0._type = arg_3_2
	arg_3_0._param = arg_3_3

	var_0_0.super.init(arg_3_0, var_0_1, Str(STR.BONUS_RULE), 0)
	arg_3_0:initBonusList(var_0_1.height - 60, arg_3_2)
end

function var_0_0.initClash(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Str(STR.BONUS_RULE)

	var_0_0.super.init(arg_4_0, var_0_3, var_4_0, 0)

	local var_4_1 = arg_4_0._form
	local var_4_2 = lc.createSprite({
		_name = "img_com_bg_10",
		_crect = ClientView.CRECT_COM_BG10,
		_size = cc.size(lc.w(var_4_1) - var_0_0.FRAME_THICK_H - 40, 340)
	})

	lc.addChildToPos(var_4_1, var_4_2, cc.p(lc.w(var_4_1) / 2, lc.bottom(arg_4_0._titleFrame) - 16 - lc.h(var_4_2) / 2))

	local var_4_3 = Data._globalInfo._ladderStage
	local var_4_4

	if arg_4_2 == 0 then
		var_4_4 = Str(STR.TOTAL_RANK)
	elseif arg_4_2 == #var_4_3 then
		var_4_4 = string.format(Str(STR.LEVEL_ABOVE), lc.arrayAt(var_4_3, -1))
	else
		var_4_4 = string.format("%d%s-%d%s", var_4_3[arg_4_2], Str(STR.LEVEL_S), var_4_3[arg_4_2 + 1] - 1, Str(STR.LEVEL_S))
	end

	ClientView.addDecoratedLabel(var_4_2, var_4_4 .. Str(STR.RANK) .. Str(STR.BONUS), cc.p(lc.w(var_4_2) / 2, lc.h(var_4_2) - 40), 26):setColor(ClientView.COLOR_TEXT_LIGHT)

	local var_4_5 = lc.List.createV(cc.size(lc.w(var_4_2) - 20, lc.h(var_4_2) - 20), 10, 10)

	lc.addChildToCenter(var_4_2, var_4_5)
	lc.offset(var_4_5, 3, 2)

	local var_4_6 = {}

	for iter_4_0, iter_4_1 in pairs(Data._rankBonusInfo) do
		if iter_4_1._type == arg_4_1 then
			table.insert(var_4_6, iter_4_1._bonusId)
		end
	end

	local function var_4_7(arg_5_0)
		local var_5_0 = lc.createNode(cc.size(200, 210))
		local var_5_1 = lc.createSprite(string.format("img_medal_%d", arg_5_0))

		lc.addChildToPos(var_5_0, var_5_1, cc.p(lc.w(var_5_0) / 2, lc.h(var_5_0) - lc.h(var_5_1) / 2))

		if #var_4_6 > 0 then
			local var_5_2 = Data._bonusInfo[var_4_6[arg_5_0]]
			local var_5_3 = {}

			for iter_5_0, iter_5_1 in ipairs(var_5_2._rid) do
				local var_5_4 = IconWidget.create({
					_infoId = iter_5_1,
					_count = var_5_2._count[iter_5_0],
					_isFragment = var_5_2._isFragment[iter_5_0] > 0
				}, IconWidget.DisplayFlag.ITEM)

				var_5_4._name:setColor(ClientView.COLOR_TEXT_LIGHT)
				table.insert(var_5_3, var_5_4)
			end

			lc.addNodesToCenter(var_5_0, var_5_3, 16, 60)
		end

		return var_5_0
	end

	local var_4_8 = var_4_7(1)
	local var_4_9 = var_4_7(2)
	local var_4_10 = var_4_7(3)
	local var_4_11 = lc.createSprite("img_divide_line_5")
	local var_4_12 = lc.createSprite("img_divide_line_5")

	var_4_11:setColor(cc.c3b(170, 150, 100))
	var_4_11:setRotation(90)
	var_4_12:setColor(var_4_11:getColor())
	var_4_12:setRotation(90)
	lc.addChildToPos(var_4_2, var_4_8, cc.p(lc.w(var_4_2) / 2, 30 + lc.h(var_4_8) / 2))
	lc.addChildToPos(var_4_2, var_4_11, cc.p(lc.left(var_4_8) - 10, lc.y(var_4_8)))
	lc.addChildToPos(var_4_2, var_4_9, cc.p(lc.left(var_4_8) - 20 - lc.w(var_4_9) / 2, lc.y(var_4_8)))
	lc.addChildToPos(var_4_2, var_4_12, cc.p(lc.right(var_4_8) + 10, lc.y(var_4_8)))
	lc.addChildToPos(var_4_2, var_4_10, cc.p(lc.right(var_4_8) + 20 + lc.w(var_4_10) / 2, lc.y(var_4_8)))

	if false then
		local var_4_13 = lc.createSprite({
			_name = "img_com_bg_10",
			_crect = ClientView.CRECT_COM_BG10,
			_size = cc.size(lc.w(var_4_2), 226)
		})

		lc.addChildToPos(var_4_1, var_4_13, cc.p(lc.w(var_4_1) / 2, var_0_0.FRAME_THICK_BOTTOM + 20 + lc.h(var_4_13) / 2))
		ClientView.addDecoratedLabel(var_4_13, Str(STR.FIND_CLASH_LEGEND_AVATARS), cc.p(lc.w(var_4_13) / 2, lc.h(var_4_13) - 40), 26):setColor(ClientView.COLOR_TEXT_LIGHT)

		local var_4_14 = {
			Data.PropsId.avatar_frame_clash_4,
			Data.PropsId.avatar_frame_clash_3,
			Data.PropsId.avatar_frame_clash_2,
			Data.PropsId.avatar_frame_clash_1
		}
		local var_4_15 = {}

		for iter_4_2, iter_4_3 in ipairs(var_4_14) do
			local var_4_16 = IconWidget.create({
				_infoId = iter_4_3
			}, IconWidget.DisplayFlag.ITEM)

			var_4_16._name:setColor(ClientView.COLOR_TEXT_LIGHT)
			table.insert(var_4_15, var_4_16)
		end

		lc.addNodesToCenter(var_4_13, var_4_15, 24, 92)
	end
end

function var_0_0.initBonusList(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._form

	arg_6_2 = arg_6_2 or SglMsgType_pb.PB_TYPE_RANK_TROPHY

	local var_6_1 = lc.createImageView({
		_name = "img_com_bg_10",
		_crect = ClientView.CRECT_COM_BG10,
		_size = cc.size(lc.w(var_6_0) - var_0_0.FRAME_THICK_H - 40, arg_6_1 - var_0_0.FRAME_THICK_BOTTOM - 30)
	})

	lc.addChildToPos(var_6_0, var_6_1, cc.p(lc.w(var_6_0) / 2, var_0_0.FRAME_THICK_BOTTOM + 20 + lc.h(var_6_1) / 2))

	local var_6_2 = lc.List.createV(cc.size(lc.w(var_6_1) - 30, lc.h(var_6_1) - 30), 10, 10)

	lc.addChildToPos(var_6_1, var_6_2, cc.p(18, 18))

	arg_6_0._list = var_6_2

	local var_6_3 = {}

	for iter_6_0, iter_6_1 in pairs(Data._rankBonusInfo) do
		if iter_6_1._type == arg_6_2 then
			table.insert(var_6_3, iter_6_1)
		end
	end

	table.sort(var_6_3, function(arg_7_0, arg_7_1)
		return arg_7_0._id < arg_7_1._id
	end)

	if arg_6_0._type == SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE then
		table.insert(var_6_3, {
			_bonusId = 10509,
			_type = 1706
		})
	end

	var_6_2:bindData(var_6_3, function(arg_8_0, arg_8_1)
		arg_6_0:setOrCreateItem(arg_8_0, arg_8_1)
	end, math.min(10, #var_6_3))

	for iter_6_2 = 1, var_6_2._cacheCount do
		local var_6_4 = arg_6_0:setOrCreateItem(nil, var_6_3[iter_6_2])

		var_6_2:pushBackCustomItem(var_6_4)
	end
end

function var_0_0.setOrCreateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 100

	if arg_9_1 == nil then
		arg_9_1 = lc.createImageView({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35
		})

		arg_9_1:setContentSize(lc.w(arg_9_0._list), 108)

		local var_9_1 = lc.createSprite("img_bg_deco_35")

		lc.addChildToPos(arg_9_1, var_9_1, cc.p(lc.w(var_9_1) / 2, lc.h(arg_9_1) / 2 + 3))

		arg_9_1._icons = {}

		function arg_9_1.update(arg_10_0)
			local var_10_0 = Data._bonusInfo[arg_10_0._bonusId]

			var_9_1:setColor(arg_10_0._max == 1 and cc.c3b(250, 64, 0) or arg_10_0._max == 2 and cc.c3b(0, 144, 250) or arg_10_0._max == 3 and cc.c3b(166, 128, 136) or cc.c3b(255, 255, 255))
			arg_9_1:removeChildByTag(var_9_0)

			if arg_10_0._id then
				if arg_10_0._max <= 3 and arg_10_0._min == arg_10_0._max then
					local var_10_1 = lc.createSprite(string.format("img_medal_%d", arg_10_0._max))

					lc.addChildToPos(arg_9_1, var_10_1, cc.p(90, lc.ch(arg_9_1)), 0, var_9_0)
				elseif arg_10_0._min == arg_10_0._max then
					local var_10_2 = ClientView.createBMFont(ClientView.BMFont.num_48, arg_10_0._min)

					lc.addChildToPos(arg_9_1, var_10_2, cc.p(90, lc.ch(arg_9_1)), 0, var_9_0)
				else
					local var_10_3 = ClientView.createBMFont(ClientView.BMFont.num_48, arg_10_0._min .. "-" .. arg_10_0._max)

					lc.addChildToPos(arg_9_1, var_10_3, cc.p(90, lc.ch(arg_9_1)), 0, var_9_0)
				end
			elseif arg_9_0._type == SglMsgType_pb.PB_TYPE_RANK_UBOSS_SCORE then
				local var_10_4 = ClientView.createBMFont(ClientView.BMFont.num_48, Str(STR.NO_CHALLENGE))

				lc.addChildToPos(arg_9_1, var_10_4, cc.p(90, lc.ch(arg_9_1)), 0, var_9_0)
			end

			for iter_10_0, iter_10_1 in ipairs(arg_9_1._icons) do
				iter_10_1:setVisible(false)
			end

			local var_10_5 = #var_10_0._rid

			for iter_10_2, iter_10_3 in ipairs(var_10_0._rid) do
				local var_10_6 = {
					_infoId = var_10_0._rid[iter_10_2],
					_count = var_10_0._count[iter_10_2],
					_level = var_10_0._level[iter_10_2],
					_isFragment = var_10_0._isFragment[iter_10_2] > 0
				}
				local var_10_7 = arg_9_1._icons[iter_10_2]

				if not var_10_7 then
					var_10_7 = IconWidget.create(var_10_6, IconWidget.DisplayFlag.ITEM_NO_NAME)

					var_10_7:setScale(0.95)
					var_10_7:setSwallowTouches(false)
					lc.addChildToPos(arg_9_1, var_10_7, cc.p(lc.cw(arg_9_1) + lc.cw(var_9_1) + (iter_10_2 - var_10_5 / 2 - 0.5) * 140, lc.ch(arg_9_1) + 3))
					table.insert(arg_9_1._icons, var_10_7)
				else
					var_10_7:resetData(var_10_6)
					var_10_7:setVisible(true)
				end
			end

			lc.setNodesToCenter(arg_9_1, arg_9_1._icons, 20, nil, lc.cw(arg_9_1) + 80)
		end
	end

	arg_9_1.update(arg_9_2)

	return arg_9_1
end

return var_0_0
