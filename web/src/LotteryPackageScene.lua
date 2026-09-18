local var_0_0 = class("LotteryPackageScene", require("BaseUIScene"))

function var_0_0.create(...)
	return lc.createScene(var_0_0, ...)
end

function var_0_0.init(arg_2_0, arg_2_1)
	local var_2_0
	local var_2_1 = STR.FESTIVAL_LOTTERY

	-- A direct scene entry can omit the festival id while the event data is
	-- still loading. Use the protocol's neutral numeric value instead of nil.
	arg_2_0._value = tonumber(arg_2_1) or 0
	arg_2_0._totalLotteryTimes = 5
	arg_2_0._costOnce = 40
	arg_2_0._firstTokenId = Data.PropsId.times_package_ticket
	arg_2_0._tokenId = Data.PropsId.void_diamond
	arg_2_0._ingotTokenId = Data.PropsId.lottery_package_token
	arg_2_0._ingotCostOnce = 1
	arg_2_0._resetTokenId = Data.PropsId.lottery_reset_token
	arg_2_0._resetCostIngot = 10
	arg_2_0._isIngotLottery = false
	-- Keep the scene renderable while the package response is in flight.
	arg_2_0._lotteryCount = arg_2_0._totalLotteryTimes
	arg_2_0._drops = {}

	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.festival_lottery, var_2_1, require("BaseUIScene").STYLE_SIMPLE, true) then
		return false
	end

	arg_2_0._bg:setTexture("res/jpg/lottery_bg2.jpg")
	arg_2_0._bg:setLocalZOrder(-2)

	local var_2_2 = lc.createSpriteWithMask("res/jpg/wheel_bg2.jpg")

	lc.addChildToPos(arg_2_0, var_2_2, cc.p(ClientView.SCR_CW, ClientView.SCR_CH - 30))

	arg_2_0._wheel = var_2_2

	local var_2_3 = lc.createSprite("img_lottery_1")

	lc.addChildToPos(arg_2_0, var_2_3, cc.p(lc.x(var_2_2) + 2, lc.y(var_2_2) + lc.ch(var_2_2) + 4))

	local var_2_4 = lc.createSprite("img_lottery_3")

	lc.addChildToPos(arg_2_0, var_2_4, cc.p(lc.x(var_2_2), lc.y(var_2_2) - lc.ch(var_2_2) - 20))

	local var_2_5 = lc.createSprite("img_lottery_2")

	lc.addChildToPos(arg_2_0, var_2_5, cc.p(lc.x(var_2_2) + lc.cw(var_2_2) + 14, lc.y(var_2_2) - 4))

	local var_2_6 = lc.createSprite("img_lottery_2")

	lc.addChildToPos(arg_2_0, var_2_6, cc.p(lc.x(var_2_2) - lc.cw(var_2_2) - 14, lc.y(var_2_2) - 4))
	var_2_6:setFlippedX(true)

	local var_2_7 = DragonBones.create("maoxian")

	lc.addChildToPos(arg_2_0, var_2_7, cc.p(lc.x(var_2_2) - 36, lc.y(var_2_2) + 30))
	var_2_7:gotoAndPlay("effect1")

	arg_2_0._bones = var_2_7

	local var_2_8 = lc.createSprite({
		_name = "img_tip_bg2",
		_size = cc.size(190, 51),
		_crect = cc.rect(36, 25, 1, 1)
	})

	lc.addChildToPos(arg_2_0, var_2_8, cc.p(lc.cw(arg_2_0) + 400, lc.h(arg_2_0) - 100))

	local var_2_9 = ClientView.createTTF("", ClientView.FontSize.S1)

	var_2_9:setColor(ClientView.COLOR_TEXT_DARK)
	var_2_9:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_2_8, var_2_9, cc.p(36, lc.ch(var_2_8)))

	arg_2_0._timesLabel = var_2_9
	arg_2_0._btnSingle = arg_2_0:createBtn("img_wheel_start", 1, function(arg_3_0)
		arg_2_0:onSingle(arg_3_0._resType, arg_3_0._resNeed)
	end)

	lc.addChildToPos(arg_2_0, arg_2_0._btnSingle, cc.p(lc.x(var_2_2), lc.y(var_2_2) + 30))

	arg_2_0._btnReset = arg_2_0:createBtn("img_wheel_reset", 1, function(arg_4_0)
		arg_2_0:onReset(arg_4_0._resType, arg_4_0._resNeed)
	end)

	lc.addChildToPos(arg_2_0, arg_2_0._btnReset, cc.p(lc.w(arg_2_0) - lc.cw(arg_2_0._btnReset), lc.ch(arg_2_0._btnReset)))

	arg_2_0._btnSwitch = ClientView.createShaderButton("switch_off", function()
		arg_2_0:onSwitch()
	end)

	arg_2_0._btnSwitch:setZoomScale(0)

	local var_2_10 = ClientView.createTTF(Str(STR.PROP_LOTTERY), ClientView.FontSize.S2)

	lc.addChildToPos(arg_2_0._btnSwitch, var_2_10, cc.p(80, lc.ch(arg_2_0._btnSwitch)))

	local var_2_11 = ClientView.createTTF(Str(STR.INGOT_LOTTERY), ClientView.FontSize.S2)

	lc.addChildToPos(arg_2_0._btnSwitch, var_2_11, cc.p(lc.w(arg_2_0._btnSwitch) - 80, lc.ch(arg_2_0._btnSwitch)))
	lc.addChildToPos(arg_2_0, arg_2_0._btnSwitch, cc.p(lc.x(arg_2_0._wheel), lc.ch(arg_2_0._btnSwitch)))

	local var_2_12 = cc.Node:create()

	lc.addChildToCenter(var_2_2, var_2_12)

	arg_2_0._rewardNode = var_2_12

	local var_2_13 = cc.Node:create()

	lc.addChildToCenter(arg_2_0._wheel, var_2_13)

	arg_2_0._chestNode = var_2_13

	return true
end

function var_0_0.updateView(arg_6_0)
	arg_6_0:createWheel()
	arg_6_0:updateUi()
end

function var_0_0.syncData(arg_7_0)
	var_0_0.super.syncData(arg_7_0)
	if arg_7_0._value > 0 then
		ClientView.getActiveIndicator():show(Str(STR.WATING))
		ClientData.sendGetLotteryPackage(arg_7_0._value)
	else
		arg_7_0:updateView()
	end
end

function var_0_0.onEnter(arg_8_0)
	var_0_0.super.onEnter(arg_8_0)
	ClientData.addMsgListener(arg_8_0, function(arg_9_0)
		return arg_8_0:onMsg(arg_9_0)
	end, 0)
	if arg_8_0._value > 0 then
		ClientView.getActiveIndicator():show(Str(STR.WATING))
		ClientData.sendGetLotteryPackage(arg_8_0._value)
	else
		arg_8_0:updateView()
	end
end

function var_0_0.onExit(arg_10_0)
	var_0_0.super.onExit(arg_10_0)
	ClientData.removeMsgListener(arg_10_0)
	ClientView.getResourceUI():setMode(Data.ResType.gold)
end

function var_0_0.onCleanup(arg_11_0)
	var_0_0.super.onCleanup(arg_11_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/lottery_bg2.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/wheel_bg2.jpg"))
end

function var_0_0.onMsg(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.type
	local var_12_1 = arg_12_1.status

	if var_12_0 == SglMsgType_pb.PB_TYPE_CARD_GET_FESTIVAL or var_12_0 == SglMsgType_pb.PB_TYPE_CARD_RESET_FESTIVAL then
		ClientView.getActiveIndicator():hide()

		local var_12_2 = arg_12_1.Extensions[Card_pb.SglCardMsg.festival_box_resp]
		if not var_12_2 then
			-- Error responses do not carry the festival payload. Keep the wheel
			-- usable and avoid indexing a nil protobuf extension.
			arg_12_0._lotteryCount = tonumber(arg_12_0._lotteryCount) or 0
			arg_12_0._drops = {}
			arg_12_0:updateView()
			return true
		end

		arg_12_0._lotteryCount = tonumber(var_12_2.lottery_count) or 0
		arg_12_0._drops = {}

		for iter_12_0, iter_12_1 in ipairs(var_12_2.drops) do
			arg_12_0._drops[#arg_12_0._drops + 1] = Data.pb2Resource(iter_12_1.resource)
		end

		arg_12_0:updateView()
	elseif var_12_0 == SglMsgType_pb.PB_TYPE_CARD_LOTTERY_FESTIVAL then
		ClientView.getActiveIndicator():hide()

		local var_12_3 = arg_12_1.Extensions[Card_pb.SglCardMsg.lottery_festival_resp]
		if not var_12_3 then
			-- Refusals carry no reward payload. Stop the optimistic animation and
			-- leave the count/currency untouched so the player can retry.
			arg_12_0._wheel:stopAllActions()
			arg_12_0:stopWheelEffect()
			arg_12_0:enableBtns(true)
			arg_12_0:updateUi()
			return true
		end

		P._dailyLotteryPackageCount = (tonumber(P._dailyLotteryPackageCount) or 0) + 1
		arg_12_0._lotteryCount = math.max(0, (tonumber(arg_12_0._lotteryCount) or 0) - 1)

		for iter_12_2, iter_12_3 in ipairs(arg_12_0._drops) do
			if iter_12_3._infoId == var_12_3.info_id and iter_12_3._num == var_12_3.num then
				table.remove(arg_12_0._drops, iter_12_2)

				break
			end
		end

		arg_12_0:startStopWheel({
			var_12_3
		})

		return true
	end

	return false
end

function var_0_0.createWheel(arg_13_0)
	arg_13_0._rewardNode:removeAllChildren()

	arg_13_0._rewardNode._goods = {}

	local var_13_0 = #arg_13_0._drops

	for iter_13_0 = 1, var_13_0 do
		local var_13_1 = arg_13_0._drops[iter_13_0]
		local var_13_2 = var_13_1._infoId
		local var_13_3 = var_13_1._num
		local var_13_4 = Data.getType(var_13_2)
		local var_13_5 = 360 / var_13_0 * (iter_13_0 - 1)
		local var_13_6 = lc.createSprite("lottery_line")

		lc.addChildToCenter(arg_13_0._rewardNode, var_13_6)
		var_13_6:setRotation(var_13_5)

		local var_13_7 = 360 / var_13_0 * (iter_13_0 - 0.5)
		local var_13_8 = math.rad(var_13_7)
		local var_13_9 = cc.p(250 * math.sin(var_13_8), 250 * math.cos(var_13_8))
		local var_13_10 = cc.p(190 * math.sin(var_13_8), 190 * math.cos(var_13_8))
		local var_13_11 = require("IconWidget").create({
			_infoId = var_13_2,
			_num = var_13_3
		})

		lc.addChildToPos(arg_13_0._rewardNode, var_13_11, var_13_9)
		var_13_11:setScale(0.8)
		var_13_11:setRotation(var_13_7)
		table.insert(arg_13_0._rewardNode._goods, var_13_11)
	end
end

function var_0_0.createBar(arg_14_0)
	local var_14_0 = ccui.LoadingBar:create()

	var_14_0:loadTexture("img_expedition_bar_bg", ccui.TextureResType.plistType)
	var_14_0:setAnchorPoint(0.5, 0.5)
	var_14_0:setRotation(-90)
	lc.addChildToPos(arg_14_0, var_14_0, cc.p(ClientView.SCR_CW - 364, ClientView.SCR_CH - 80))

	arg_14_0._lotteryBar = var_14_0

	local var_14_1 = ClientView.createBMFont(ClientView.BMFont.huali_32, Data._globalInfo._expeditionEnergyProgress)

	lc.addChildToPos(arg_14_0, var_14_1, cc.p(lc.x(var_14_0), lc.y(var_14_0) - 20))

	local var_14_2 = ClientView.createBMFont(ClientView.BMFont.huali_32, "----")

	lc.addChildToPos(arg_14_0, var_14_2, cc.p(lc.x(var_14_0), lc.y(var_14_0)))

	local var_14_3 = ClientView.createBMFont(ClientView.BMFont.huali_32, 0)

	lc.addChildToPos(arg_14_0, var_14_3, cc.p(lc.x(var_14_0), lc.y(var_14_0) + 20))

	arg_14_0._lotteryCount = var_14_3
end

function var_0_0.createBtn(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = ClientView.createShaderButton(arg_15_1, arg_15_3)

	var_15_0:setDisabledShader(ClientView.SHADER_DISABLE)

	local var_15_1 = lc.createSprite("img_icon_props_s" .. arg_15_0._tokenId)

	lc.addChildToPos(var_15_0, var_15_1, cc.p(lc.cw(var_15_0) - 20, lc.ch(var_15_0) + 10))

	var_15_0._lottery = var_15_1

	local var_15_2 = ClientView.createBMFont(ClientView.BMFont.huali_32, arg_15_0._costOnce * arg_15_2)

	var_15_2:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_15_1, var_15_2, cc.p(lc.w(var_15_1) + 20, lc.ch(var_15_1)))

	var_15_1._label = var_15_2

	return var_15_0
end

function var_0_0.updateUi(arg_16_0)
	local var_16_0 = arg_16_0._tokenId
	local var_16_1 = arg_16_0._costOnce

	if not arg_16_0._isIngotLottery then
		if P._dailyLotteryPackageCount == 0 and var_16_1 <= P:getItemCount(arg_16_0._firstTokenId) then
			var_16_0 = arg_16_0._firstTokenId
		end
	else
		var_16_0, var_16_1 = arg_16_0._ingotTokenId, arg_16_0._ingotCostOnce
	end

	arg_16_0._btnSingle._resType, arg_16_0._btnSingle._resNeed = var_16_0, var_16_1

	arg_16_0._btnSingle._lottery:setVisible(true)

	local var_16_2 = ClientData.getIconName(var_16_0)

	arg_16_0._btnSingle._lottery:setSpriteFrame(var_16_2)
	arg_16_0._btnSingle._lottery._label:setColor(var_16_1 <= P:getItemCount(var_16_0) and lc.Color3B.white or lc.Color3B.red)
	arg_16_0._btnSingle._lottery._label:setString(var_16_1)
	arg_16_0._timesLabel:setString(string.format(Str(STR.REMAIN_LOTTERY_TIMES), tonumber(arg_16_0._lotteryCount) or 0))

	local var_16_3
	local var_16_4

	if arg_16_0._lotteryCount == 5 then
		if P:getItemCount(arg_16_0._resetTokenId) > 0 then
			var_16_3, var_16_4 = arg_16_0._resetTokenId, 1
		else
			var_16_3, var_16_4 = Data.ResType.ingot, arg_16_0._resetCostIngot
		end
	end

	arg_16_0._btnReset._resType, arg_16_0._btnReset._resNeed = var_16_3, var_16_4

	if not var_16_3 then
		arg_16_0._btnReset._lottery._label:setString(0)
		arg_16_0._btnReset._lottery._label:setColor(ClientView.COLOR_TEXT_WHITE)
	else
		local var_16_5 = ClientData.getIconName(var_16_3)

		arg_16_0._btnReset._lottery:setSpriteFrame(var_16_5)
		arg_16_0._btnReset._lottery._label:setColor(var_16_4 <= P:getItemCount(var_16_3) and lc.Color3B.white or lc.Color3B.red)
		arg_16_0._btnReset._lottery._label:setString(var_16_4)
	end

	arg_16_0._btnSwitch:loadTextureNormal(arg_16_0._isIngotLottery and "switch_on" or "switch_off", ccui.TextureResType.plistType)

	if arg_16_0._isIngotLottery then
		ClientView.getResourceUI():setMode(arg_16_0._ingotTokenId)
	elseif var_16_3 == arg_16_0._resetTokenId then
		ClientView.getResourceUI():setMode(arg_16_0._firstTokenId)
	else
		ClientView.getResourceUI():setMode(arg_16_0._firstTokenId, 1)
	end
end

function var_0_0.onSingle(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 or not arg_17_2 then
		return
	end

	if arg_17_2 <= P:getItemCount(arg_17_1) then
		local var_17_0 = string.format(Str(STR.CONFIRM_LOTTERY), ClientData.getNameByInfoId(arg_17_1) .. Str(STR.MULTIPY) .. arg_17_2)

		require("Dialog").showDialog(var_17_0, function()
			arg_17_0:startWheel()
			arg_17_0:sendLottery(arg_17_1, arg_17_2)
		end)
	else
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(arg_17_1)))
	end
end

function var_0_0.onReset(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 and not arg_19_2 then
		return
	end

	if not arg_19_1 or arg_19_2 <= P:getItemCount(arg_19_1) then
		if arg_19_1 then
			local var_19_0 = string.format(Str(STR.CONFIRM_RESET_LOTTERY), ClientData.getNameByInfoId(arg_19_1) .. Str(STR.MULTIPY) .. arg_19_2)

			require("Dialog").showDialog(var_19_0, function()
				ClientView.getActiveIndicator():show(Str(STR.WATING))
				ClientData.sendResetLotteryPackage(arg_19_0._value)
				P:addResource(arg_19_1, 1, -arg_19_2)
			end)
		else
			require("Dialog").showDialog(Str(STR.CONFIRM_RESET_LOTTERY_FREE), function()
				ClientView.getActiveIndicator():show(Str(STR.WATING))
				ClientData.sendResetLotteryPackage(arg_19_0._value)
			end)
		end
	else
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(arg_19_1)))
	end
end

function var_0_0.onSwitch(arg_22_0)
	arg_22_0._isIngotLottery = not arg_22_0._isIngotLottery

	arg_22_0:updateUi()
end

function var_0_0.sendLottery(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:enableBtns(false)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))
	ClientData.sendLotteryPackage(arg_23_0._value, not arg_23_0._isIngotLottery)
end

function var_0_0.startWheel(arg_24_0)
	arg_24_0._wheel:stopAllActions()
	arg_24_0._wheel:setRotation(0)
	arg_24_0._wheel:runAction(lc.rep(lc.rotateBy(1, 720)))

	if not arg_24_0._wheelParticle then
		local var_24_0 = Particle.create("choujiangtexiao")

		lc.addChildToPos(arg_24_0, var_24_0, cc.p(arg_24_0._bg:getPosition()))

		arg_24_0._wheelParticle = var_24_0
	end

	if arg_24_0._bones then
		arg_24_0._bones:gotoAndPlay("effect2")
	end

	arg_24_0:stopWheelEffect()

	if ClientData._isEffectOn then
		local function var_24_1()
			arg_24_0._effectId = cc.SimpleAudioEngine:getInstance():playEffect("res/audio/e_find_match.wav", false)
		end

		arg_24_0._effectScheduleId = lc.Scheduler:scheduleScriptFunc(var_24_1, 0.95, false)

		var_24_1()
	end
end

function var_0_0.startStopWheel(arg_26_0, arg_26_1)
	if #arg_26_0._rewardNode._goods == 0 then
		arg_26_0:stopWheel(arg_26_1)
		return
	end

	local var_26_0 = 0

	for iter_26_0 = 1, #arg_26_0._rewardNode._goods do
		local var_26_1 = arg_26_0._rewardNode._goods[iter_26_0]

		if arg_26_1[1].info_id == var_26_1._data._infoId and arg_26_1[1].num == var_26_1._data._count then
			var_26_0 = iter_26_0

			break
		end
	end

	local var_26_2 = 720 - (var_26_0 - 0.5) * 360 / #arg_26_0._rewardNode._goods - arg_26_0._wheel:getRotation() % 360

	arg_26_0._wheel:stopAllActions()
	arg_26_0._wheel:runAction(lc.sequence(lc.ease(lc.rotateBy(2, var_26_2), "O", 1.8), lc.call(function()
		arg_26_0:stopWheel(arg_26_1)
	end)))
	arg_26_0:showCostEffect()
end

function var_0_0.stopWheel(arg_28_0, arg_28_1)
	arg_28_0._wheel:stopAllActions()
	arg_28_0._wheel:runAction(lc.sequence(lc.delay(1), lc.call(function()
		arg_28_0:showLotteryReward(arg_28_1)

		if arg_28_0._lotteryCount == 0 then
			if arg_28_0._value > 0 then
				ClientView.getActiveIndicator():show(Str(STR.WATING))
				ClientData.sendGetLotteryPackage(arg_28_0._value)
			else
				arg_28_0:updateView()
			end
		else
			arg_28_0:updateView()
		end
	end)))

	if arg_28_0._wheelParticle then
		arg_28_0._wheelParticle:setDuration(0.1)

		arg_28_0._wheelParticle = nil
	end

	if arg_28_0._bones then
		arg_28_0._bones:gotoAndPlay("effect1")
	end

	arg_28_0:stopWheelEffect()
end

function var_0_0.stopWheelEffect(arg_30_0)
	if arg_30_0._effectId then
		cc.SimpleAudioEngine:getInstance():stopEffect(arg_30_0._effectId)
		lc.Audio.stopAudio(AUDIO.E_FIND_MATCH_OVER)

		arg_30_0._effectId = nil
	end

	lc.Audio.stopAudio(AUDIO.E_FIND_MATCH_OVER)

	if arg_30_0._effectScheduleId then
		lc.Scheduler:unscheduleScriptEntry(arg_30_0._effectScheduleId)

		arg_30_0._effectScheduleId = nil
	end
end

function var_0_0.showCostEffect(arg_31_0)
	local var_31_0 = arg_31_0._btnSingle._resType
	local var_31_1 = arg_31_0._btnSingle._resNeed

	P:addResource(var_31_0, 1, -var_31_1)

	local var_31_2
	local var_31_3
	local var_31_4 = ClientData.getIconName(var_31_0)
	local var_31_5 = lc.createSprite(var_31_4)
	local var_31_6 = ClientView.createBMFont(ClientView.BMFont.huali_32, "-" .. var_31_1)

	lc.addChildToPos(arg_31_0, var_31_5, cc.p(lc.x(arg_31_0._btnSingle) - 20, lc.y(arg_31_0._btnSingle) + 30))
	lc.addChildToPos(var_31_5, var_31_6, cc.p(lc.w(var_31_5) + 10, lc.ch(var_31_5)))
	var_31_6:setAnchorPoint(0, 0.5)
	var_31_5:runAction(lc.sequence(lc.moveBy(1.5, cc.p(0, 75)), lc.remove()))
end

function var_0_0.showLotteryReward(arg_32_0, arg_32_1)
	local var_32_0 = require("RewardPanel")

	var_32_0.create(arg_32_1, var_32_0.MODE_LOTTERY):show()
	arg_32_0:updateUi()
	arg_32_0:enableBtns(true)
end

function var_0_0.enableBtns(arg_33_0, arg_33_1)
	arg_33_0._btnSingle:setEnabled(arg_33_1)
	arg_33_0._btnReset:setEnabled(arg_33_1)
	arg_33_0._btnSwitch:setEnabled(arg_33_1)
	arg_33_0._titleArea._btnBack:setEnabled(arg_33_1)
end

return var_0_0
