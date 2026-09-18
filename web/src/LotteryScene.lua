local var_0_0 = class("LotteryScene", require("BaseUIScene"))
local var_0_1 = 12
local var_0_2 = 10

function var_0_0.create(...)
	return lc.createScene(var_0_0, ...)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._type = arg_2_1 or Data.LotteryType.explore

	local var_2_0

	if arg_2_0._type == Data.LotteryType.explore then
		var_2_0 = STR.LOTTERY
		arg_2_0._costOnce = 1
		arg_2_0._tokenId = Data.PropsId.lottery_token
		arg_2_0._ingotCostOnce = Data._globalInfo._expeditionDialCost
	elseif arg_2_0._type == Data.LotteryType.week then
		var_2_0 = STR.WEEK_LOTTERY
		arg_2_0._costOnce = 1
		arg_2_0._tokenId = Data.PropsId.week_lottery_token
	elseif arg_2_0._type == Data.LotteryType.dark then
		var_2_0 = STR.DARK_LOTTERY
		arg_2_0._costOnce = 10
		arg_2_0._tokenId = Data.PropsId.dark_lottery_token
	elseif arg_2_0._type == Data.LotteryType.spring then
		local var_2_1 = ClientData.getValidActivityByType(535)

		var_2_0 = var_2_1._nameSid
		arg_2_0._costOnce = var_2_1._bonusId[2]
		arg_2_0._tokenId = var_2_1._bonusId[1]
	end

	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.lottery, var_2_0, require("BaseUIScene").STYLE_SIMPLE, true) then
		return false
	end

	if arg_2_0._type == Data.LotteryType.explore then
		local var_2_2 = {}

		for iter_2_0, iter_2_1 in pairs(Data._dropInfo) do
			if iter_2_1._type == 1008 then
				var_2_2[#var_2_2 + 1] = iter_2_1
			end
		end

		table.sort(var_2_2, function(arg_3_0, arg_3_1)
			return arg_3_0._value < arg_3_1._value
		end)

		local var_2_3, var_2_4, var_2_5, var_2_6 = ClientData.getServerDate()

		arg_2_0._info = var_2_2[var_2_5]
		arg_2_0._progressStages = {
			Data._globalInfo._expeditionEnergyProgress
		}
	elseif arg_2_0._type == Data.LotteryType.week then
		local var_2_7 = ClientData.getValidActivityByType(Data.ActivityType.week_lottery)

		for iter_2_2, iter_2_3 in pairs(Data._dropInfo) do
			if iter_2_3._type == 1019 and iter_2_3._value == var_2_7._param[1] then
				arg_2_0._info = iter_2_3

				break
			end
		end

		arg_2_0._progressStages = {
			120,
			300
		}
	elseif arg_2_0._type == Data.LotteryType.dark then
		for iter_2_4, iter_2_5 in pairs(Data._dropInfo) do
			if iter_2_5._type == 1015 then
				arg_2_0._info = iter_2_5
			end
		end
	elseif arg_2_0._type == Data.LotteryType.spring then
		for iter_2_6, iter_2_7 in pairs(Data._dropInfo) do
			if iter_2_7._type == 1016 then
				arg_2_0._info = iter_2_7
			end
		end
	end

	arg_2_0._stageIndex = 1

	if arg_2_0._progressStages then
		for iter_2_8, iter_2_9 in ipairs(arg_2_0._progressStages) do
			if iter_2_9 < arg_2_0:getLotteryPower() then
				arg_2_0._stageIndex = math.min(#arg_2_0._progressStages, iter_2_8 + 1)
			end
		end

		arg_2_0._progressStage = arg_2_0._progressStages[arg_2_0._stageIndex]
	end

	arg_2_0._btnMulti = arg_2_0:createBtn("img_wheel_multi", var_0_2, function(arg_4_0)
		arg_2_0:onMulti()
	end)

	lc.addChildToPos(arg_2_0, arg_2_0._btnMulti, cc.p(lc.w(arg_2_0) - lc.cw(arg_2_0._btnMulti) + 42 - ClientView.SCR_EDGE, lc.ch(arg_2_0._btnMulti) - 58))
	arg_2_0:createWheel()

	if arg_2_0._type == Data.LotteryType.explore or arg_2_0._type == Data.LotteryType.week then
		arg_2_0:createBar()
	end

	return true
end

function var_0_0.syncData(arg_5_0)
	var_0_0.super.syncData(arg_5_0)
	ClientView.popScene(true)
end

function var_0_0.onEnter(arg_6_0)
	var_0_0.super.onEnter(arg_6_0)
	ClientData.addMsgListener(arg_6_0, function(arg_7_0)
		return arg_6_0:onMsg(arg_7_0)
	end, 0)
	ClientView.getResourceUI():setMode(arg_6_0._tokenId)

	local var_6_0 = {}

	arg_6_0._listeners = var_6_0
	var_6_0[#var_6_0 + 1] = lc.addEventListener(Data.Event.prop_dirty, function(arg_8_0)
		if arg_8_0._data._infoId == arg_6_0._tokenId then
			arg_6_0:updateUi()
		end
	end)

	arg_6_0:updateUi()
end

function var_0_0.onExit(arg_9_0)
	var_0_0.super.onExit(arg_9_0)
	ClientData.removeMsgListener(arg_9_0)
	ClientView.getResourceUI():setMode(Data.ResType.gold)
end

function var_0_0.onCleanup(arg_10_0)
	var_0_0.super.onCleanup(arg_10_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/lottery_bg.jpg"))
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/wheel_bg.jpg"))
end

function var_0_0.onMsg(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.type
	local var_11_1 = arg_11_1.status

	if var_11_0 == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY or var_11_0 == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_EX or var_11_0 == SglMsgType_pb.PB_TYPE_WORLD_LOTTERY_ACTIVITY or var_11_0 == SglMsgType_pb.PB_TYPE_CARD_LOTTERY_TURNTABLE then
		ClientView.getActiveIndicator():hide()

		local var_11_2

		if var_11_0 == SglMsgType_pb.PB_TYPE_CARD_LOTTERY_TURNTABLE then
			var_11_2 = arg_11_1.Extensions[Card_pb.SglCardMsg.lottery_turn_table_resp]
		else
			var_11_2 = arg_11_1.Extensions[World_pb.SglWorldMsg.world_lottery_resp]
		end

		if ClientData._lotteryTimes == 1 then
			arg_11_0:startStopWheel(var_11_2)

			ClientData._lotteryTimes = 0
		else
			local var_11_3 = {}

			for iter_11_0 = 1, #var_11_2 do
				var_11_3[var_11_2[iter_11_0].info_id] = (var_11_3[var_11_2[iter_11_0].info_id] or 0) + var_11_2[iter_11_0].num
			end

			local var_11_4 = {}

			for iter_11_1, iter_11_2 in pairs(var_11_3) do
				var_11_4[#var_11_4 + 1] = {
					level = 1,
					info_id = iter_11_1,
					num = iter_11_2
				}
			end

			arg_11_0:showLotteryReward(var_11_4)
		end

		return true
	end

	return false
end

function var_0_0.createWheel(arg_12_0)
	arg_12_0._bg:setTexture((arg_12_0._type == Data.LotteryType.explore or arg_12_0._type == Data.LotteryType.week) and "res/jpg/lottery_bg.jpg" or "res/jpg/lottery_bg2.jpg")
	arg_12_0._bg:setLocalZOrder(-2)

	local var_12_0 = lc.createSpriteWithMask("res/jpg/wheel_bg.jpg")

	lc.addChildToPos(arg_12_0, var_12_0, cc.p((arg_12_0._type == Data.LotteryType.explore or arg_12_0._type == Data.LotteryType.week) and ClientView.SCR_CW + 36 or ClientView.SCR_CW, ClientView.SCR_CH - 30))

	arg_12_0._wheel = var_12_0

	local var_12_1 = lc.createSprite("img_lottery_1")

	lc.addChildToPos(arg_12_0, var_12_1, cc.p(lc.x(var_12_0) + 2, lc.y(var_12_0) + lc.ch(var_12_0) + 4))

	local var_12_2 = lc.createSprite("img_lottery_3")

	lc.addChildToPos(arg_12_0, var_12_2, cc.p(lc.x(var_12_0), lc.y(var_12_0) - lc.ch(var_12_0) - 20))

	local var_12_3 = lc.createSprite("img_lottery_2")

	lc.addChildToPos(arg_12_0, var_12_3, cc.p(lc.x(var_12_0) + lc.cw(var_12_0) + 14, lc.y(var_12_0) - 4))

	local var_12_4 = lc.createSprite("img_lottery_2")

	lc.addChildToPos(arg_12_0, var_12_4, cc.p(lc.x(var_12_0) - lc.cw(var_12_0) - 14, lc.y(var_12_0) - 4))
	var_12_4:setFlippedX(true)

	local var_12_5 = DragonBones.create("maoxian")

	lc.addChildToPos(arg_12_0, var_12_5, cc.p(lc.x(var_12_0) - 36, lc.y(var_12_0) + 30))
	var_12_5:gotoAndPlay("effect1")

	arg_12_0._bones = var_12_5
	arg_12_0._btnSingle = arg_12_0:createBtn("img_wheel_start", 1, function(arg_13_0)
		arg_12_0:onSingle()
	end)

	lc.addChildToPos(arg_12_0, arg_12_0._btnSingle, cc.p(lc.x(var_12_0), lc.y(var_12_0) + 30))

	local var_12_6 = cc.Node:create()

	lc.addChildToCenter(var_12_0, var_12_6)

	arg_12_0._rewardNode = var_12_6

	local var_12_7 = cc.Node:create()

	lc.addChildToCenter(arg_12_0._wheel, var_12_7)

	arg_12_0._chestNode = var_12_7

	local var_12_8 = arg_12_0._info._pid[var_0_1 + arg_12_0._stageIndex]

	for iter_12_0 = 1, var_0_1 do
		local var_12_9 = arg_12_0._info._pid[iter_12_0][1]
		local var_12_10 = arg_12_0._info._pid[iter_12_0][2]
		local var_12_11 = 360 / var_0_1 * (iter_12_0 - 0.5)
		local var_12_12 = math.rad(var_12_11)
		local var_12_13 = cc.p(250 * math.sin(var_12_12), 250 * math.cos(var_12_12))
		local var_12_14 = cc.p(190 * math.sin(var_12_12), 190 * math.cos(var_12_12))

		if var_12_9 == Data.ResType.gold or var_12_9 == Data.ResType.ingot or var_12_9 == Data.PropsId.lottery_token or var_12_9 == Data.PropsId.dark_lottery_token then
			local var_12_15 = ""

			if var_12_9 == Data.ResType.gold then
				var_12_15 = "img_wheel_gold_" .. (var_12_10 < 30 and 1 or var_12_10 < 60 and 2 or 3)
			elseif var_12_9 == Data.ResType.ingot then
				var_12_15 = "img_wheel_gem_" .. (var_12_10 < 50 and 1 or 2)
			elseif var_12_9 == Data.PropsId.lottery_token then
				var_12_15 = "img_wheel_lottery"
			elseif var_12_9 == Data.PropsId.dark_lottery_token then
				var_12_15 = "img_wheel_dark_lottery"
			end

			local var_12_16 = lc.createSprite(var_12_15)

			lc.addChildToPos(var_12_6, var_12_16, var_12_13)
			var_12_16:setRotation(var_12_11)
		else
			local var_12_17 = require("IconWidget").createByInfoId(var_12_9, var_12_10, 0)

			lc.addChildToPos(var_12_6, var_12_17, var_12_13)
			var_12_17:setScale(0.8)
			var_12_17:setRotation(var_12_11)
		end

		local var_12_18 = ClientView.createBMFont(ClientView.BMFont.huali_26, "x" .. var_12_10)

		lc.addChildToPos(var_12_6, var_12_18, var_12_14)
		var_12_18:setRotation(var_12_11)

		if arg_12_0._type == Data.LotteryType.explore or arg_12_0._type == Data.LotteryType.week then
			local var_12_19 = require("IconWidget").createByInfoId(var_12_8[1], var_12_8[2], 0)

			lc.addChildToPos(var_12_7, var_12_19, var_12_13)
			var_12_19:setScale(0.8)
			var_12_19:setRotation(var_12_11)
		end
	end
end

function var_0_0.createBar(arg_14_0)
	local var_14_0 = ccui.LoadingBar:create()

	var_14_0:loadTexture("img_expedition_bar_bg", ccui.TextureResType.plistType)
	var_14_0:setAnchorPoint(0.5, 0.5)
	var_14_0:setRotation(-90)
	lc.addChildToPos(arg_14_0, var_14_0, cc.p(ClientView.SCR_CW - 364, ClientView.SCR_CH - 80))

	arg_14_0._lotteryBar = var_14_0

	local var_14_1 = ClientView.createBMFont(ClientView.BMFont.huali_32, arg_14_0._progressStage)

	lc.addChildToPos(arg_14_0, var_14_1, cc.p(lc.x(var_14_0), lc.y(var_14_0) - 20))

	arg_14_0._barTotal = var_14_1

	local var_14_2 = ClientView.createBMFont(ClientView.BMFont.huali_32, "----")

	lc.addChildToPos(arg_14_0, var_14_2, cc.p(lc.x(var_14_0), lc.y(var_14_0)))

	local var_14_3 = ClientView.createBMFont(ClientView.BMFont.huali_32, 0)

	lc.addChildToPos(arg_14_0, var_14_3, cc.p(lc.x(var_14_0), lc.y(var_14_0) + 20))

	arg_14_0._lotteryCount = var_14_3

	local var_14_4 = arg_14_0._info._pid[var_0_1 + arg_14_0._stageIndex]
	local var_14_5 = require("IconWidget").createByInfoId(var_14_4[1], var_14_4[2], 0)

	lc.addChildToPos(arg_14_0, var_14_5, cc.p(lc.x(var_14_0), ClientView.SCR_CH + 246))
	var_14_5:setScale(1.1)

	arg_14_0._urIcon = var_14_5
end

function var_0_0.createBtn(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = ClientView.createShaderButton(arg_15_1, arg_15_3)

	var_15_0:setDisabledShader(ClientView.SHADER_DISABLE)

	local var_15_1 = lc.createSprite(ClientData.getPropIconName(arg_15_0._tokenId))

	lc.addChildToPos(var_15_0, var_15_1, cc.p(lc.cw(var_15_0) - 20, lc.ch(var_15_0) + 10))

	var_15_0._lottery = var_15_1

	local var_15_2 = ClientView.createBMFont(ClientView.BMFont.huali_32, arg_15_0._costOnce * arg_15_2)

	var_15_2:setAnchorPoint(0.5, 0.5)
	lc.addChildToPos(var_15_1, var_15_2, cc.p(lc.w(var_15_1) + 20, lc.ch(var_15_1)))

	var_15_1._label = var_15_2

	local var_15_3 = lc.createSprite("img_icon_res3_s")

	lc.addChildToPos(var_15_0, var_15_3, cc.p(lc.cw(var_15_0) - (arg_15_2 == 1 and 20 or 28), lc.ch(var_15_0) + 10))

	var_15_0._ingot = var_15_3

	local var_15_4 = arg_15_0._ingotCostOnce or 0
	local var_15_5 = ClientView.createBMFont(ClientView.BMFont.huali_32, var_15_4 * arg_15_2)

	var_15_5:setAnchorPoint(0, 0.5)
	lc.addChildToPos(var_15_3, var_15_5, cc.p(lc.w(var_15_3), lc.ch(var_15_3)))

	var_15_3._label = var_15_5

	return var_15_0
end

function var_0_0.updateUi(arg_16_0)
	if P._propBag:hasProps(arg_16_0._tokenId, arg_16_0._costOnce) or arg_16_0._type == Data.LotteryType.dark or arg_16_0._type == Data.LotteryType.spring or arg_16_0._type == Data.LotteryType.week then
		arg_16_0._btnSingle._lottery:setVisible(true)
		arg_16_0._btnSingle._lottery._label:setColor(P._propBag:hasProps(arg_16_0._tokenId, arg_16_0._costOnce) and lc.Color3B.white or lc.Color3B.red)
		arg_16_0._btnSingle._ingot:setVisible(false)
	elseif arg_16_0._type == Data.LotteryType.explore then
		arg_16_0._btnSingle._lottery:setVisible(false)
		arg_16_0._btnSingle._ingot:setVisible(true)
		arg_16_0._btnSingle._ingot._label:setColor(P:hasResource(Data.ResType.ingot, arg_16_0._ingotCostOnce) and lc.Color3B.white or lc.Color3B.red)
	end

	if P._propBag:hasProps(arg_16_0._tokenId, var_0_2 * arg_16_0._costOnce) or arg_16_0._type == Data.LotteryType.dark or arg_16_0._type == Data.LotteryType.spring or arg_16_0._type == Data.LotteryType.week then
		arg_16_0._btnMulti._lottery:setVisible(true)
		arg_16_0._btnMulti._lottery._label:setColor(P._propBag:hasProps(arg_16_0._tokenId, arg_16_0._costOnce * var_0_2) and lc.Color3B.white or lc.Color3B.red)
		arg_16_0._btnMulti._ingot:setVisible(false)
	elseif arg_16_0._type == Data.LotteryType.explore then
		arg_16_0._btnMulti._lottery:setVisible(false)
		arg_16_0._btnMulti._ingot:setVisible(true)
		arg_16_0._btnMulti._ingot._label:setColor(P:hasResource(Data.ResType.ingot, arg_16_0._ingotCostOnce * var_0_2) and lc.Color3B.white or lc.Color3B.red)
	end

	arg_16_0:updateBar()
end

function var_0_0.updateBar(arg_17_0)
	if not arg_17_0._lotteryBar then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._progressStages) do
		if iter_17_1 < arg_17_0:getLotteryPower() then
			arg_17_0._stageIndex = math.min(#arg_17_0._progressStages, iter_17_0 + 1)
		end
	end

	arg_17_0._progressStage = arg_17_0._progressStages[arg_17_0._stageIndex]

	if arg_17_0:getLotteryPower() == arg_17_0._progressStage then
		arg_17_0._rewardNode:setVisible(false)
		arg_17_0._chestNode:setVisible(true)
	else
		arg_17_0._rewardNode:setVisible(true)
		arg_17_0._chestNode:setVisible(false)
	end

	local var_17_0 = math.pow(arg_17_0:getLotteryPower() / arg_17_0._progressStage, 0.5)

	arg_17_0._lotteryBar:setPercent(var_17_0 * 100)
	arg_17_0._lotteryCount:setString(arg_17_0:getLotteryPower())
	arg_17_0._barTotal:setString(arg_17_0._progressStage)

	local var_17_1 = arg_17_0._info._pid[var_0_1 + arg_17_0._stageIndex]

	arg_17_0._urIcon:resetData({
		_infoId = var_17_1[1],
		_num = var_17_1[2]
	})

	if arg_17_0._chestNode then
		for iter_17_2, iter_17_3 in ipairs(arg_17_0._chestNode:getChildren()) do
			iter_17_3:resetData({
				_infoId = var_17_1[1],
				_num = var_17_1[2]
			})
		end
	end
end

function var_0_0.onSingle(arg_18_0)
	if P._propBag:hasProps(arg_18_0._tokenId, arg_18_0._costOnce) or arg_18_0._ingotCostOnce and ClientView.checkIngot(arg_18_0._ingotCostOnce) then
		if not P._propBag:hasProps(arg_18_0._tokenId, arg_18_0._costOnce) then
			local var_18_0 = arg_18_0._type == Data.LotteryType.explore and Str(STR.CONFIRM_LOTTERY_BY_INGOT, true) or string.format(Str(STR.CONFIRM_LOTTERY_BY_INGOT_ACTIVITY, true), ClientData.getNameByInfoId(arg_18_0._tokenId))

			require("Dialog").showDialog(var_18_0, function()
				arg_18_0:startWheel()
				arg_18_0:sendLottery(1)
			end)
		else
			arg_18_0:startWheel()
			arg_18_0:sendLottery(1)
		end
	elseif arg_18_0._type == Data.LotteryType.spring then
		ClientView.showResExchangeForm(7129)
	elseif arg_18_0._type == Data.LotteryType.week then
		ClientView.showResExchangeForm(Data.PropsId.yubi)
	else
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(arg_18_0._tokenId)))
	end
end

function var_0_0.onMulti(arg_20_0)
	if P._propBag:hasProps(arg_20_0._tokenId, var_0_2 * arg_20_0._costOnce) or arg_20_0._ingotCostOnce and ClientView.checkIngot(arg_20_0._ingotCostOnce * var_0_2) then
		if not P._propBag:hasProps(arg_20_0._tokenId, var_0_2 * arg_20_0._costOnce) then
			local var_20_0 = arg_20_0._type == Data.LotteryType.explore and Str(STR.CONFIRM_LOTTERY_BY_INGOT, true) or string.format(Str(STR.CONFIRM_LOTTERY_BY_INGOT_ACTIVITY, true), ClientData.getNameByInfoId(arg_20_0._tokenId))

			require("Dialog").showDialog(var_20_0, function()
				arg_20_0:sendLottery(var_0_2)
			end)
		else
			arg_20_0:sendLottery(var_0_2)
		end
	elseif arg_20_0._type == Data.LotteryType.spring then
		ClientView.showResExchangeForm(7129)
	elseif arg_20_0._type == Data.LotteryType.week then
		ClientView.showResExchangeForm(Data.PropsId.yubi)
	else
		ToastManager.push(string.format(Str(STR.NOT_ENOUGH), ClientData.getNameByInfoId(arg_20_0._tokenId)))
	end
end

function var_0_0.sendLottery(arg_22_0, arg_22_1)
	ClientData._lotteryTimes = arg_22_1

	arg_22_0:enableBtns(false)
	ClientView.getActiveIndicator():show(Str(STR.WAITING))

	if arg_22_0._type == Data.LotteryType.explore then
		ClientData.sendWorldLottery(P._propBag:hasProps(arg_22_0._tokenId, arg_22_0._costOnce * arg_22_1), arg_22_1)
	elseif arg_22_0._type == Data.LotteryType.week then
		ClientData.sendWeekLottery(arg_22_1)
	elseif arg_22_0._type == Data.LotteryType.dark then
		ClientData.sendWorldLotteryEx(arg_22_1)
	elseif arg_22_0._type == Data.LotteryType.spring then
		ClientData.sendWorldLotteryActivity(P._propBag:hasProps(arg_22_0._tokenId, arg_22_0._costOnce * arg_22_1), arg_22_1)
	end
end

function var_0_0.startWheel(arg_23_0)
	arg_23_0._wheel:stopAllActions()
	arg_23_0._wheel:setRotation(0)
	arg_23_0._wheel:runAction(lc.rep(lc.rotateBy(1, 720)))

	if not arg_23_0._wheelParticle then
		local var_23_0 = Particle.create("choujiangtexiao")

		lc.addChildToPos(arg_23_0, var_23_0, cc.p(arg_23_0._bg:getPosition()))

		arg_23_0._wheelParticle = var_23_0
	end

	if arg_23_0._bones then
		arg_23_0._bones:gotoAndPlay("effect2")
	end

	arg_23_0:stopWheelEffect()

	if ClientData._isEffectOn then
		local function var_23_1()
			arg_23_0._effectId = cc.SimpleAudioEngine:getInstance():playEffect("res/audio/e_find_match.wav", false)
		end

		arg_23_0._effectScheduleId = lc.Scheduler:scheduleScriptFunc(var_23_1, 0.95, false)

		var_23_1()
	end
end

function var_0_0.startStopWheel(arg_25_0, arg_25_1)
	local var_25_0 = 0

	for iter_25_0 = 1, #arg_25_0._info._pid do
		local var_25_1 = arg_25_0._info._pid[iter_25_0]

		if arg_25_1[1].info_id == var_25_1[1] and arg_25_1[1].num == var_25_1[2] then
			var_25_0 = iter_25_0

			break
		end
	end

	local var_25_2 = 720 - (var_25_0 - 0.5) * 360 / var_0_1 - arg_25_0._wheel:getRotation() % 360

	arg_25_0._wheel:stopAllActions()
	arg_25_0._wheel:runAction(lc.sequence(lc.ease(lc.rotateBy(2, var_25_2), "O", 1.8), lc.call(function()
		arg_25_0:stopWheel(arg_25_1)
	end)))
	arg_25_0:showCostEffect()
end

function var_0_0.stopWheel(arg_27_0, arg_27_1)
	arg_27_0._wheel:stopAllActions()
	arg_27_0._wheel:runAction(lc.sequence(lc.delay(1), lc.call(function()
		arg_27_0:showLotteryReward(arg_27_1)
	end)))

	if arg_27_0._wheelParticle then
		arg_27_0._wheelParticle:setDuration(0.1)

		arg_27_0._wheelParticle = nil
	end

	if arg_27_0._bones then
		arg_27_0._bones:gotoAndPlay("effect1")
	end

	arg_27_0:stopWheelEffect()
end

function var_0_0.stopWheelEffect(arg_29_0)
	if arg_29_0._effectId then
		cc.SimpleAudioEngine:getInstance():stopEffect(arg_29_0._effectId)
		lc.Audio.stopAudio(AUDIO.E_FIND_MATCH_OVER)

		arg_29_0._effectId = nil
	end

	lc.Audio.stopAudio(AUDIO.E_FIND_MATCH_OVER)

	if arg_29_0._effectScheduleId then
		lc.Scheduler:unscheduleScriptEntry(arg_29_0._effectScheduleId)

		arg_29_0._effectScheduleId = nil
	end
end

function var_0_0.showCostEffect(arg_30_0)
	if arg_30_0._lotteryBar then
		local var_30_0 = ClientView.createBMFont(ClientView.BMFont.huali_32, "+" .. arg_30_0._costOnce)

		lc.addChildToPos(arg_30_0, var_30_0, cc.p(arg_30_0._lotteryBar:getPosition()))
		var_30_0:runAction(lc.sequence(lc.moveBy(1.5, cc.p(0, 75)), lc.remove()))
		arg_30_0:updateBar()
	end

	local var_30_1
	local var_30_2

	if arg_30_0._btnSingle._lottery:isVisible() then
		var_30_1 = lc.createSprite("img_icon_props_s" .. arg_30_0._tokenId)
		var_30_2 = ClientView.createBMFont(ClientView.BMFont.huali_32, "-" .. arg_30_0._costOnce)
	else
		var_30_1 = lc.createSprite("img_icon_res3_s")

		local var_30_3 = -arg_30_0._ingotCostOnce

		var_30_2 = ClientView.createBMFont(ClientView.BMFont.huali_32, var_30_3)
	end

	lc.addChildToPos(arg_30_0, var_30_1, cc.p(lc.x(arg_30_0._btnSingle) - 20, lc.y(arg_30_0._btnSingle) + 30))
	lc.addChildToPos(var_30_1, var_30_2, cc.p(lc.w(var_30_1) + 10, lc.ch(var_30_1)))
	var_30_2:setAnchorPoint(0, 0.5)
	var_30_1:runAction(lc.sequence(lc.moveBy(1.5, cc.p(0, 75)), lc.remove()))
end

function var_0_0.showLotteryReward(arg_31_0, arg_31_1)
	local var_31_0 = require("RewardPanel")

	var_31_0.create(arg_31_1, var_31_0.MODE_LOTTERY):show()
	arg_31_0:updateUi()
	arg_31_0:enableBtns(true)
end

function var_0_0.enableBtns(arg_32_0, arg_32_1)
	arg_32_0._btnSingle:setEnabled(arg_32_1)
	arg_32_0._btnMulti:setEnabled(arg_32_1)
	arg_32_0._titleArea._btnBack:setEnabled(arg_32_1)
end

function var_0_0.getLotteryPower(arg_33_0)
	if arg_33_0._type == Data.LotteryType.explore then
		return ClientData._lotteryPower
	elseif arg_33_0._type == Data.LotteryType.week then
		return ClientData._lotteryWeekPower
	end
end

return var_0_0
