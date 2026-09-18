local var_0_0 = class("ChapterRankForm", BaseForm)
local var_0_1 = cc.size(800, 600)
local var_0_2 = 100

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local var_2_0 = Data._levelInfo[arg_2_1]
	local var_2_1 = {
		Str(STR.STORY_LINE),
		Str(STR.REBEL),
		Str(STR.CHAOS)
	}
	local var_2_2 = string.format(Str(var_2_0._nameSid))

	var_0_0.super.init(arg_2_0, var_0_1, var_2_2 .. Str(STR.CITY_STRATEGY) .. " - " .. Str(STR.FIGHT_VALUE) .. Str(STR.RANK), bor(BaseForm.FLAG.BASE_TITLE_BG, BaseForm.FLAG.SCROLL_V))

	arg_2_0._levelId = arg_2_1

	arg_2_0._form:setTouchEnabled(false)

	local var_2_3 = lc.List.createV(cc.size(lc.w(arg_2_0._bg) - 8, lc.bottom(arg_2_0._titleFrame) - var_0_0.BOTTOM_MARGIN + 12), 6, 0)

	lc.addChildToPos(arg_2_0._bg, var_2_3, cc.p(4, 0))

	arg_2_0._list = var_2_3
end

function var_0_0.setOrCreateItem(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == nil then
		arg_3_1 = ccui.ImageView:create("img_com_bg_11", ccui.TextureResType.plistType)

		arg_3_1:setScale9Enabled(true)
		arg_3_1:setCapInsets(ClientView.CRECT_COM_BG11)
		arg_3_1:setContentSize(lc.w(arg_3_0._list), 120)
		arg_3_1:setTouchEnabled(true)
		arg_3_1:setTouchEndCancelRange(lc.Gesture.BUDGE_LIMIT)
		arg_3_1:addTouchEventListener(function(arg_4_0, arg_4_1)
			if arg_4_1 == ccui.TouchEventType.ended and arg_3_1._rank then
				ClientView.operateUser(arg_3_1._rank._user, arg_3_1)
			end
		end)

		local var_3_0 = ClientView.createScale9ShaderButton("img_btn_2", nil, ClientView.CRECT_BUTTON, 150)

		var_3_0:addLabel(Str(STR.REPLAY))
		lc.addChildToPos(arg_3_1, var_3_0, cc.p(lc.w(arg_3_1) - lc.w(var_3_0) / 2 - 60, lc.h(var_3_0) / 2 + 20))

		arg_3_1._btnReplay = var_3_0

		local var_3_1 = ClientView.createKeyValueLabel(Str(STR.PASS_CHAPTER_FIGHT_VALUE), "00000", ClientView.FontSize.S2, false)

		var_3_1:addToParent(arg_3_1, cc.p(lc.left(var_3_0) + 4, lc.top(var_3_0) + lc.h(var_3_1) / 2))

		arg_3_1._power = var_3_1
	end

	if arg_3_2._user._id == ClientData._player._id then
		arg_3_1:setColor(ClientView.COLOR_TEXT_GREEN)
	else
		arg_3_1:setColor(lc.Color3B.white)
	end

	arg_3_1:removeChildrenByTag(var_0_2)

	arg_3_1._rank = arg_3_2

	local var_3_2 = arg_3_2._rank

	if var_3_2 <= 3 then
		local var_3_3 = lc.createSprite(string.format("img_medal_%d", var_3_2))

		var_3_3:setPosition(lc.w(var_3_3) / 2 + 40, lc.h(arg_3_1) / 2 + 5)
		arg_3_1:addChild(var_3_3, 0, var_0_2)
		arg_3_1._btnReplay:setVisible(true)
		arg_3_1._power:setPosition(lc.x(arg_3_1._power), lc.top(arg_3_1._btnReplay) + lc.h(arg_3_1._power) / 2)
	else
		local var_3_4 = ClientView.createBMFont(ClientView.BMFont.num_48, string.format("%d", var_3_2))

		var_3_4:setPosition(70, lc.h(arg_3_1) / 2 + 2)
		arg_3_1:addChild(var_3_4, 0, var_0_2)
		arg_3_1._btnReplay:setVisible(false)
		arg_3_1._power:setPosition(lc.x(arg_3_1._power), lc.h(arg_3_1) / 2 + 4)
	end

	function arg_3_1._btnReplay._callback(arg_5_0)
		arg_3_0:onReplay(arg_3_1)
	end

	arg_3_1._power._value:setString(string.format("%d", arg_3_2._power))

	local var_3_5 = UserWidget.create(arg_3_2._user, UserWidget.Flag.NAME_UNION, 0.8)

	lc.addChildToPos(arg_3_1, var_3_5, cc.p(120 + lc.w(var_3_5) / 2 + 10, lc.h(arg_3_1) / 2 + 4), 0, var_0_2)

	return arg_3_1
end

function var_0_0.onEnter(arg_6_0)
	var_0_0.super.onEnter(arg_6_0)

	arg_6_0._listener = lc.addEventListener(Data.Event.invalid_tutorial, function()
		arg_6_0._activeIndicator = ClientView.showPanelActiveIndicator(arg_6_0._bg)

		ClientData.sendRankChapter(arg_6_0._levelId)
	end)

	ClientData.addMsgListener(arg_6_0, function(arg_8_0)
		return arg_6_0:onMsg(arg_8_0)
	end, 0)

	arg_6_0._activeIndicator = ClientView.showPanelActiveIndicator(arg_6_0._bg)

	ClientData.sendRankChapter(arg_6_0._levelId)
end

function var_0_0.onExit(arg_9_0)
	var_0_0.super.onExit(arg_9_0)
	lc.Dispatcher:removeEventListener(arg_9_0._listener)
	ClientData.removeMsgListener(arg_9_0)
end

function var_0_0.onReplay(arg_10_0, arg_10_1)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))

	ClientData._replaySharable = false
	ClientData._replayInBattle = ClientView.isInBattleScene()

	ClientData.sendTutorialReplay(arg_10_1._rank._tutorialId)
	ClientData.sendUserEvent({
		chapterReplayId = arg_10_1._rank._tutorialId
	})
end

function var_0_0.onShowActionFinished(arg_11_0)
	if not var_0_0._isShowFormTip then
		var_0_0._isShowFormTip = true

		arg_11_0:showFormTip(Str(STR.CHAPTER_RANK_TIP))
	end
end

function var_0_0.onMsg(arg_12_0, arg_12_1)
	if arg_12_1.type == SglMsgType_pb.PB_TYPE_BATTLE_TUTORIAL then
		if arg_12_0._activeIndicator then
			arg_12_0._activeIndicator:removeFromParent()

			arg_12_0._activeIndicator = nil
		end

		arg_12_0._ranks = {}

		local var_12_0 = arg_12_1.Extensions[Battle_pb.SglBattleMsg.battle_tutorial_resp]

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_1 = {
				_rank = iter_12_0,
				_user = require("User").create(iter_12_1.user_info),
				_power = iter_12_1.power,
				_tutorialId = iter_12_1.id,
				_timestamp = iter_12_1.timestamp / 1000
			}

			table.insert(arg_12_0._ranks, var_12_1)
		end

		local var_12_2 = arg_12_0._list

		var_12_2:bindData(arg_12_0._ranks, function(arg_13_0, arg_13_1)
			arg_12_0:setOrCreateItem(arg_13_0, arg_13_1)
		end, math.min(6, #arg_12_0._ranks))

		for iter_12_2 = 1, var_12_2._cacheCount do
			local var_12_3 = arg_12_0:setOrCreateItem(nil, arg_12_0._ranks[iter_12_2])

			var_12_2:pushBackCustomItem(var_12_3)
		end

		return true
	end

	return false
end

ChapterRankForm = var_0_0

return var_0_0
