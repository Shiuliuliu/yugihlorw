local var_0_0 = class("InviteForm", BaseForm)
local var_0_1 = cc.size(900, 640)

function var_0_0.create()
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, var_0_1, Str(STR.INVITE), bor(BaseForm.FLAG.ADVANCE_TITLE_BG))

	local var_2_0

	if P._level >= Data._globalInfo._unlockInvite then
		var_2_0 = 2
	end

	arg_2_0:addTabs({
		Str(STR.ACCEPT) .. Str(STR.INVITE),
		Str(STR.MY) .. Str(STR.INVITE)
	}, var_2_0)
end

function var_0_0.showTab(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = string.find(arg_3_1, Str(STR.MY)) ~= nil

	if var_3_0 and P._level < Data._globalInfo._unlockInvite then
		ToastManager.push(string.format(Str(STR.LORD_UNLOCK_LEVEL), Data._globalInfo._unlockInvite))

		return false
	end

	if not var_0_0.super.showTab(arg_3_0, arg_3_1, arg_3_2) then
		return false
	end

	arg_3_0._isSelfInvite = var_3_0

	arg_3_0:refreshContent()

	return true
end

function var_0_0.refreshContent(arg_4_0)
	local var_4_0 = arg_4_0._contentArea

	if var_4_0 then
		var_4_0:removeAllChildren()
	else
		local var_4_1 = cc.size(var_0_1.width - var_0_0.FRAME_THICK_H, var_0_1.height - var_0_0.FRAME_THICK_V)

		var_4_0 = lc.createNode(var_4_1)

		lc.addChildToPos(arg_4_0._form, var_4_0, cc.p(var_0_0.FRAME_THICK_LEFT + var_4_1.width / 2, var_0_0.FRAME_THICK_BOTTOM + var_4_1.height / 2))

		arg_4_0._contentArea = var_4_0
	end

	local var_4_2 = lc.w(var_4_0) / 2

	if arg_4_0._isSelfInvite then
		if P._inviteCode then
			local var_4_3 = lc.createSprite({
				_name = "img_com_bg_4",
				_crect = ClientView.CRECT_COM_BG4,
				_size = cc.size(lc.w(var_4_0), 160)
			})

			lc.addChildToPos(var_4_0, var_4_3, cc.p(var_4_2, lc.h(var_4_0) - lc.h(var_4_3) / 2 - 4), 1)

			local var_4_4 = ClientView.createKeyValueLabel(Str(STR.MY) .. Str(STR.INVITE_CODE), P._inviteCode, ClientView.FontSize.S1)

			var_4_4:addToParent(var_4_3, cc.p(32, lc.h(var_4_3) - 30 - lc.h(var_4_4) / 2))

			local var_4_5, var_4_6 = ClientView.createKeyValueLabel(Str(STR.INVITE_INGOT), P._inviteIngot, ClientView.FontSize.S1, nil, "img_icon_res3_s")

			var_4_5:addToParent(var_4_3, cc.p(310, lc.y(var_4_4)))

			arg_4_0._ingotVal = var_4_6

			local var_4_7 = ClientView.createScale9ShaderButton("img_btn_1", function()
				arg_4_0:showHelp()
			end, ClientView.CRECT_BUTTON, 150)

			var_4_7:addLabel(Str(STR.INVITE_RULE))
			lc.addChildToPos(var_4_3, var_4_7, cc.p(lc.left(var_4_4) - 4 + lc.w(var_4_7) / 2, 60))

			local var_4_8 = lc.createSprite("img_glow")

			var_4_8:setOpacity(200)
			var_4_8:setScale(0.65)
			lc.addChildToPos(var_4_3, var_4_8, cc.p(lc.w(var_4_3) - 100, lc.h(var_4_3) / 2))

			local var_4_9 = ClientView.createTTF(Str(STR.INVITED), ClientView.FontSize.S3, ClientView.COLOR_LABEL_DARK)

			lc.addChildToPos(var_4_3, var_4_9, cc.p(lc.x(var_4_8), lc.y(var_4_4)))

			local var_4_10 = ClientView.createBMFont(ClientView.BMFont.num_48, P._inviteCount)

			lc.addChildToPos(var_4_3, var_4_10, cc.p(lc.x(var_4_8), 74))

			arg_4_0._inviteCount = var_4_10

			local var_4_11 = lc.List.createV(cc.size(lc.w(var_4_0) - 8, lc.h(var_4_0) - lc.h(var_4_3) + 10), 6, 0)

			lc.addChildToPos(var_4_0, var_4_11, cc.p(4, -4))

			for iter_4_0 = 1, #P._playerBonus._bonusInvite do
				local var_4_12 = P._playerBonus._bonusInvite[iter_4_0]
				local var_4_13 = require("BonusWidget").create(lc.w(var_4_11), var_4_12)

				var_4_13:registerCallback(function(arg_6_0)
					arg_4_0:claimBonus(arg_6_0)
				end)
				var_4_11:pushBackCustomItem(var_4_13)
			end
		else
			arg_4_0._indicator = ClientView.showPanelActiveIndicator(var_4_0)

			ClientData.sendGetInviteCode()
		end
	else
		if P._invitedCode then
			local var_4_14 = arg_4_0._inviteInfo

			if var_4_14 then
				local var_4_15 = ClientView.createTTF(Str(STR.INVITED_WITH_PLAYER), ClientView.FontSize.S1, ClientView.COLOR_TEXT_ORANGE)

				lc.addChildToPos(var_4_0, var_4_15, cc.p(var_4_2, lc.h(var_4_0) - 100 - lc.h(var_4_15) / 2))

				local var_4_16 = UserWidget.create(var_4_14, UserWidget.Flag.REGION_NAME_UNION)

				lc.addChildToPos(var_4_0, var_4_16, cc.p(var_4_2, lc.bottom(var_4_15) - 30 - lc.h(var_4_16) / 2))
				var_4_16._regionArea:setColor(ClientView.COLOR_TEXT_LIGHT)

				if var_4_16._unionArea then
					var_4_16._unionArea._name:setColor(lc.Color3B.yellow)
				end
			else
				arg_4_0._indicator = ClientView.showPanelActiveIndicator(var_4_0)

				ClientData.sendGetInviteInfo(P._invitedCode)
			end
		else
			local var_4_17 = ClientView.createTTF(Str(STR.INVITED_TIP), ClientView.FontSize.S1, nil, cc.size(700, 0))

			lc.addChildToPos(var_4_0, var_4_17, cc.p(var_4_2, lc.h(var_4_0) - 50 - lc.h(var_4_17) / 2))

			local var_4_18 = ClientView.createEditBox("img_com_bg_3", ClientView.CRECT_COM_BG3, cc.size(400, 56), Str(STR.INVITE_CODE), true)

			lc.addChildToPos(var_4_0, var_4_18, cc.p(var_4_2 - 90, lc.bottom(var_4_17) - 30 - lc.h(var_4_18) / 2))

			arg_4_0._editor = var_4_18

			local var_4_19 = ClientView.createScale9ShaderButton("img_btn_2", function()
				arg_4_0:acceptInvite()
			end, ClientView.CRECT_BUTTON, 150)

			var_4_19:addLabel(Str(STR.ACCEPT) .. Str(STR.INVITE))
			lc.addChildToPos(var_4_0, var_4_19, cc.p(lc.right(var_4_18) + 4 + lc.w(var_4_19) / 2, lc.y(var_4_18)))

			local var_4_20 = ClientView.createTTF(Str(STR.INVITED_BONUS), ClientView.FontSize.S1, ClientView.COLOR_TEXT_ORANGE)

			lc.addChildToPos(var_4_0, var_4_20, cc.p(var_4_2, lc.bottom(var_4_18) - 40 - lc.h(var_4_20) / 2))

			local var_4_21 = P._playerBonus._invitedBonus._info
			local var_4_22 = {}

			for iter_4_1 = 1, #var_4_21._rid do
				local var_4_23 = IconWidget.create({
					_infoId = var_4_21._rid[iter_4_1],
					_level = var_4_21._level[iter_4_1],
					_count = var_4_21._count[iter_4_1],
					_isFragment = var_4_21._isFragment[iter_4_1] > 0
				})

				var_4_23._name:setColor(lc.Color3B.white)
				table.insert(var_4_22, var_4_23)
			end

			P:sortResultItems(var_4_22)
			lc.addNodesToCenter(var_4_0, var_4_22, 20, lc.bottom(var_4_20) - 90)
		end

		local var_4_24 = ClientView.createTTF(Str(STR.INVITE_TIP), ClientView.FontSize.S1, nil, cc.size(700, 0))

		var_4_24:setColor(ClientView.COLOR_TEXT_GREEN)
		lc.addChildToPos(var_4_0, var_4_24, cc.p(var_4_2, 50 + lc.h(var_4_24) / 2))
	end
end

function var_0_0.acceptInvite(arg_8_0)
	if P._level >= Data._globalInfo._unlockInvite then
		ToastManager.push(Str(STR.INVITE_LEVEL_OVER))

		return
	end

	ClientView.getActiveIndicator():show()
	ClientData.sendGetInviteInfo(arg_8_0._editor:getText())
end

function var_0_0.claimBonus(arg_9_0, arg_9_1)
	local var_9_0 = 0

	while arg_9_1:canClaim() do
		ClientData.claimBonus(arg_9_1)

		var_9_0 = var_9_0 + 1
	end

	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1._info._rid) do
		local var_9_2 = {
			_infoId = iter_9_1,
			_count = arg_9_1._info._count[iter_9_0] * var_9_0
		}

		table.insert(var_9_1, var_9_2)
	end

	local var_9_3 = require("RewardPanel")

	var_9_3.create(var_9_1, var_9_3.MODE_CLAIM_ALL):show()
	lc.Audio.playAudio(AUDIO.E_CLAIM)
end

function var_0_0.showHelp(arg_10_0)
	ClientView.showHelpForm(Str(STR.INVITE_RULE), Data.HelpType.invite)
end

function var_0_0.hideIndicator(arg_11_0)
	if arg_11_0._indicator then
		arg_11_0._indicator:removeFromParent()

		arg_11_0._indicator = nil
	end

	ClientView.getActiveIndicator():hide()
end

function var_0_0.onEnter(arg_12_0)
	var_0_0.super.onEnter(arg_12_0)
	ClientData.addMsgListener(arg_12_0, function(arg_13_0)
		return arg_12_0:onMsg(arg_13_0)
	end, 0)

	arg_12_0._listeners = {}

	table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.invite_count_dirty, function(arg_14_0)
		if arg_12_0._isSelfInvite then
			arg_12_0._inviteCount:setString(P._inviteCount)
		end
	end))
	table.insert(arg_12_0._listeners, lc.addEventListener(Data.Event.invite_ingot_dirty, function(arg_15_0)
		if arg_12_0._isSelfInvite then
			arg_12_0._ingotVal:setString(P._inviteIngot)
		end
	end))
end

function var_0_0.onExit(arg_16_0)
	var_0_0.super.onExit(arg_16_0)

	for iter_16_0 = 1, #arg_16_0._listeners do
		lc.Dispatcher:removeEventListener(arg_16_0._listeners[iter_16_0])
	end

	ClientData.removeMsgListener(arg_16_0)
end

function var_0_0.onMsg(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.type

	if var_17_0 == SglMsgType_pb.PB_TYPE_USER_CHECK_INVITE_CODE then
		arg_17_0:hideIndicator()

		local var_17_1 = arg_17_1.Extensions[User_pb.SglUserMsg.user_check_invite_code_resp]

		arg_17_0._inviteInfo = require("User").create(var_17_1)

		if P._invitedCode then
			if not arg_17_0._isSelfInvite then
				arg_17_0:refreshContent()
			end
		else
			require("PromptForm").ConfirmInvited.create(arg_17_0._inviteInfo, function()
				P._invitedCode = arg_17_0._editor:getText()

				ClientData.sendBindInvite(P._invitedCode)

				local var_18_0 = require("RewardPanel")
				local var_18_1 = P._playerBonus._invitedBonus

				var_18_1._value = var_18_1._info._val

				P._playerBonus:claimBonus(var_18_1._infoId)
				var_18_0.create(var_18_1, var_18_0.MODE_CLAIM):show()
				arg_17_0:refreshContent()
			end):show()
		end

		return true
	elseif var_17_0 == SglMsgType_pb.PB_TYPE_USER_GET_INVITE_CODE then
		arg_17_0:hideIndicator()

		P._inviteCode = arg_17_1.Extensions[User_pb.SglUserMsg.user_get_invite_code_resp]

		if arg_17_0._isSelfInvite then
			arg_17_0:refreshContent()
		end

		return true
	end

	return false
end

return var_0_0
