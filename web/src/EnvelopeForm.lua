local var_0_0 = class("EnvelopeForm", BaseForm)
local var_0_1 = cc.size(800, 660)
local var_0_2 = 1000

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.ENVELOPE_RAIN), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_0 = arg_2_0:createTopArea()

	lc.addChildToPos(arg_2_0._frame, var_2_0, cc.p(lc.cw(arg_2_0._form), lc.bottom(arg_2_0._titleFrame) - lc.ch(var_2_0) + 25), -1)

	arg_2_0._topArea = var_2_0

	local var_2_1 = lc.List.createV(cc.size(lc.w(var_2_0), lc.bottom(var_2_0) - ClientView.FRAME_INNER_BOTTOM), 10, 0)

	var_2_1:setAnchorPoint(0.5, 1)
	lc.addChildToPos(arg_2_0._form, var_2_1, cc.p(lc.x(var_2_0), lc.bottom(var_2_0)))

	arg_2_0._list = var_2_1
end

function var_0_0.createTopArea(arg_3_0)
	local var_3_0 = lc.createNode(cc.size(lc.w(arg_3_0._form), 300))
	local var_3_1 = lc.createSpriteWithMask(lc.formatJpg("img_envelope_bg"))

	lc.addChildToPos(var_3_0, var_3_1, cc.p(lc.cw(var_3_0), lc.h(var_3_0) - lc.ch(var_3_1)))

	arg_3_0.isOn = lc.UserDefault:getBoolForKey("envelope_battle", true)

	local var_3_2 = ClientView.createTTF(Str(STR.ENVELOPE_BATTLE), ClientView.FontSize.S1)
	local var_3_3 = ClientView.createScale9ShaderButton(arg_3_0.isOn and "img_btn_1_s" or "img_btn_2_s", function(arg_4_0)
		arg_3_0.isOn = not arg_3_0.isOn

		arg_4_0:loadTextureNormal(arg_3_0.isOn and "img_btn_1_s" or "img_btn_2_s", ccui.TextureResType.plistType)
		arg_4_0._label:setString(arg_3_0.isOn and Str(STR.ON) or Str(STR.OFF))
		lc.UserDefault:setBoolForKey("envelope_battle", arg_3_0.isOn)
	end, ClientView.CRECT_BUTTON_S, 100)

	var_3_3:addLabel(arg_3_0.isOn and Str(STR.ON) or Str(STR.OFF))
	lc.addNodesToCenter(var_3_0, {
		var_3_2,
		var_3_3
	}, 10, lc.bottom(var_3_1) - 35)
	P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_ENVELOPE)

	local var_3_4 = mvpRanks and mvpRanks._selfRank

	if not var_3_4 then
		var_3_4 = {
			_user = P
		}
		var_3_4._value = 0
		var_3_4._rank = 0
	end

	local var_3_5 = arg_3_0:setOrCreateItem(nil, var_3_4)

	var_3_5._bar:setVisible(false)
	var_3_5._rankValueBg:setVisible(true)
	var_3_5:setSpriteFrame("img_com_bg_4")
	lc.addChildToPos(var_3_0, var_3_5, cc.p(lc.cw(var_3_0), lc.ch(var_3_5)))

	arg_3_0._myItem = var_3_5

	local var_3_6 = ClientView.createTTF("", ClientView.FontSize.S1)

	lc.addChildToPos(var_3_1, var_3_6, cc.p(lc.cw(var_3_1) - 110, 45))

	local var_3_7 = ClientView.createTTF("", ClientView.FontSize.S1)

	lc.addChildToPos(var_3_1, var_3_7, cc.p(lc.cw(var_3_1) + 230, lc.y(var_3_6)))
	var_3_6:runAction(lc.rep(lc.sequence(function()
		local var_5_0 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_ENVELOPE)

		if var_5_0 and var_5_0._endTime then
			local var_5_1 = var_5_0._endTime - ClientData.getCurrentTime()

			if var_5_1 > 0 then
				var_3_6:setString(ClientData.formatTime(var_5_1))
			else
				var_3_6:setString(Str(STR.FIND_CLASH_SEASON_REVIEWING_2))
			end
		else
			var_3_6:setString(Str(STR.FIND_CLASH_SEASON_REVIEWING_2))
		end
	end, 1)))

	function var_3_0.update()
		local var_6_0 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_ENVELOPE)
		local var_6_1 = var_6_0._selfRank

		if var_6_1 then
			arg_3_0._myItem.update(var_6_1)
			arg_3_0._myItem:setSpriteFrame("img_com_bg_4")
		end

		local var_6_2 = var_6_0._param

		var_3_7:setString(ClientData.formatNum(var_6_2, 9999))
	end

	return var_3_0
end

function var_0_0.updateList(arg_7_0)
	local var_7_0 = P._playerRank:getRanks(SglMsgType_pb.PB_TYPE_RANK_ENVELOPE)
	local var_7_1 = arg_7_0._list

	var_7_1:bindData(var_7_0, function(arg_8_0, arg_8_1)
		arg_7_0:setOrCreateItem(arg_8_0, arg_8_1)
	end, math.min(10, var_7_0._count))

	for iter_7_0 = 1, var_7_1._cacheCount do
		local var_7_2 = var_7_0[iter_7_0]
		local var_7_3 = arg_7_0:setOrCreateItem(nil, var_7_2)

		var_7_1:pushBackCustomItem(var_7_3)
	end

	var_7_1:checkEmpty(Str(STR.LIST_EMPTY_ENVELOPE))
end

function var_0_0.setOrCreateItem(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == nil then
		arg_9_1 = lc.createImageView({
			_name = "img_com_bg_35",
			_crect = ClientView.CRECT_COM_BG35
		})

		arg_9_1:setContentSize(700, 108)
		arg_9_1:setTouchEnabled(true)
		arg_9_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)

		local var_9_0 = lc.createSprite("img_glow")

		var_9_0:setScale(0.5)
		var_9_0:setPosition(60, lc.h(arg_9_1) / 2 + 2)
		arg_9_1:addChild(var_9_0)
		var_9_0:setVisible(false)

		arg_9_1._rankValueBg = var_9_0

		local var_9_1 = lc.createSprite("img_bg_deco_35")

		lc.addChildToPos(arg_9_1, var_9_1, cc.p(lc.cw(var_9_1), lc.ch(arg_9_1) + 3))

		arg_9_1._bar = var_9_1

		local var_9_2
		local var_9_3 = UserWidget.create(nil, UserWidget.Flag.NAME_UNION, 1.2)

		var_9_3:setScale(0.7)
		lc.addChildToPos(arg_9_1, var_9_3, cc.p(lc.right(var_9_1) + lc.w(var_9_3) / 2 + 10, lc.h(arg_9_1) / 2 + 4))

		arg_9_1._avatarArea = var_9_3

		local var_9_4 = arg_9_0:addValueArea(arg_9_1, "img_icon_res1_s", "")

		if var_9_4 then
			var_9_4:setPosition(lc.w(arg_9_1) - 15 - lc.cw(var_9_4), lc.y(arg_9_1._avatarArea))

			arg_9_1._valueArea = var_9_4
		end

		function arg_9_1.update(arg_10_0)
			if arg_10_0 then
				arg_9_1:removeChildrenByTag(var_0_2)

				arg_9_1._rank = arg_10_0

				local var_10_0 = arg_10_0._rank

				if var_10_0 <= 3 and var_10_0 > 0 then
					local var_10_1 = string.format("img_medal_%d", var_10_0)
					local var_10_2 = lc.createSprite(var_10_1)

					var_10_2:setPosition(lc.x(var_9_1) - 28, lc.h(arg_9_1) / 2 + 5)
					arg_9_1:addChild(var_10_2, 0, var_0_2)
					arg_9_1._bar:setColor(var_10_0 == 1 and cc.c3b(250, 64, 0) or var_10_0 == 2 and cc.c3b(0, 144, 250) or cc.c3b(166, 128, 136))
				elseif var_10_0 == 0 then
					local var_10_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, Str(STR.NOT_IN_RANK))

					var_10_3:setPosition(lc.x(var_9_1) - 28, lc.h(arg_9_1) / 2 + 2)
					arg_9_1:addChild(var_10_3, 0, var_0_2)
					arg_9_1._bar:setColor(lc.Color3B.white)
				else
					local var_10_4 = ClientView.createBMFont(ClientView.BMFont.num_48, tostring(var_10_0))

					var_10_4:setPosition(lc.x(var_9_1) - 28, lc.h(arg_9_1) / 2 + 2)
					arg_9_1._bar:setColor(lc.Color3B.white)
					arg_9_1:addChild(var_10_4, 0, var_0_2)
				end

				if arg_9_0._list and arg_9_0._list._data and arg_9_0._list._data._rankId and arg_10_0._user._id == arg_9_0._list._data._rankId then
					arg_9_1:setSpriteFrame("img_com_bg_4")
				else
					arg_9_1:setSpriteFrame("img_com_bg_35")
				end

				arg_9_1._avatarArea:setUser(arg_10_0._user, true)
				arg_9_1._valueArea._label:setString(arg_10_0._value)
			end
		end
	end

	arg_9_1.update(arg_9_2)

	return arg_9_1
end

function var_0_0.addValueArea(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = ClientView.createIconLabelArea(arg_11_2, tostring(arg_11_3), arg_11_4 or 140)

	var_11_0:setAnchorPoint(0.5, 0.5)
	arg_11_1:addChild(var_11_0)

	return var_11_0
end

function var_0_0.onEnter(arg_12_0)
	var_0_0.super.onEnter(arg_12_0)

	local var_12_0 = {}

	arg_12_0._listeners = var_12_0
	var_12_0[#var_12_0 + 1] = lc.addEventListener(Data.Event.rank_list_dirty, function(arg_13_0)
		if arg_12_0._indicator then
			arg_12_0._indicator:removeFromParent()

			arg_12_0._indicator = nil
		end

		arg_12_0:updateList()
		arg_12_0._topArea.update()
	end)
	arg_12_0._indicator = ClientView.showPanelActiveIndicator(arg_12_0._form, lc.bound(arg_12_0._list))

	P._playerRank:sendRankRequest(SglMsgType_pb.PB_TYPE_RANK_ENVELOPE)
end

function var_0_0.onExit(arg_14_0)
	var_0_0.super.onExit(arg_14_0)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._listeners) do
		lc.Dispatcher:removeEventListener(iter_14_1)
	end
end

function var_0_0.onCleanup(arg_15_0)
	var_0_0.super.onCleanup(arg_15_0)
	lc.TextureCache:removeTextureForKey(lc.formatJpg("img_envelope_bg"))
end

return var_0_0
