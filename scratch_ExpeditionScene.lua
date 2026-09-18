local var_0_0 = class("ExpeditionScene", require("BaseUIScene"))

var_0_0.PlayerType = {
	boss = 2,
	npc = 1
}

function var_0_0.create(...)
	return lc.createScene(var_0_0, ...)
end

function var_0_0.init(arg_2_0)
	if not var_0_0.super.init(arg_2_0, ClientData.SceneId.expedition, STR.COPY_EXPEDITION, require("BaseUIScene").STYLE_SIMPLE, true) then
		return false
	end

	arg_2_0._bg:setTexture("res/jpg/copy_bg.jpg")
	arg_2_0._bg:setPosition(cc.p(ClientView.SCR_CW, lc.ch(arg_2_0._bg)))

	local var_2_0 = ClientView.createShaderButton(nil, function()
		arg_2_0:hideInfo()
	end)

	var_2_0:setContentSize(ClientView.SCR_SIZE)
	lc.addChildToCenter(arg_2_0, var_2_0, -1)

	local var_2_1 = cc.size(ClientView.SCR_W - 200, ClientView.SCR_H - 310)
	local var_2_2 = lc.createNode()

	var_2_2:setContentSize(var_2_1)
	var_2_2:setAnchorPoint(cc.p(0.5, 0.5))
	lc.addChildToPos(arg_2_0, var_2_2, cc.p(ClientView.SCR_CW, var_2_1.height / 2 + 70))

	arg_2_0._playerLayer = var_2_2

	local var_2_3 = ClientView.createShaderButton("img_btn_wheel", function()
		lc.pushScene(require("LotteryScene").create())
	end)

	lc.addChildToPos(arg_2_0, var_2_3, cc.p(ClientView.SCR_W - lc.cw(var_2_3) - 16 - ClientView.SCR_EDGE, lc.ch(var_2_3) + 16))

	arg_2_0._btnLottery = var_2_3

	local var_2_4 = ClientView.createBMFont(ClientView.BMFont.huali_26, lc.str(STR.LOTTERY))

	lc.addChildToPos(var_2_3, var_2_4, cc.p(lc.cw(var_2_3), 10), 10)

	local var_2_5 = ClientView.createBMFont(ClientView.BMFont.huali_26, lc.str(STR.REFRESH_COUNTDOWN))

	lc.addChildToPos(arg_2_0, var_2_5, cc.p(ClientView.SCR_CW, lc.ch(var_2_5) + 16))

	arg_2_0._countDownLabel = var_2_5
	ClientData._expeditionNpcInfos = {}
	ClientData._expeditionBossInfo = {}
	ClientData._lotteryPower = 0
	arg_2_0._lastNpcUpdate = 0
	arg_2_0._lastBossUpdate = 0
	arg_2_0._lastLotteryUpdate = 0
	arg_2_0._nextRefresh = 0
	arg_2_0._dropInfos = {}

	for iter_2_0, iter_2_1 in pairs(Data._dropInfo) do
		if iter_2_1._type == 1009 then
			arg_2_0._dropInfos[#arg_2_0._dropInfos + 1] = iter_2_1
		end
	end

	table.sort(arg_2_0._dropInfos, function(arg_5_0, arg_5_1)
		return arg_5_0._value < arg_5_1._value
	end)

	return true
end

function var_0_0.syncData(arg_6_0)
	var_0_0.super.syncData(arg_6_0)
	ClientView.popScene()
end

function var_0_0.onEnter(arg_7_0)
	var_0_0.super.onEnter(arg_7_0)
	ClientData.addMsgListener(arg_7_0, function(arg_8_0)
		return arg_7_0:onMsg(arg_8_0)
	end, 0)

	if arg_7_0._lastNpcUpdate ~= 0 then
		arg_7_0:updateCountDown()
	end

	if not arg_7_0._effectBones then
		local var_7_0 = DragonBones.create("maoxianditu")

		lc.addChildToCenter(arg_7_0, var_7_0)
		var_7_0:gotoAndPlay("effect1")

		arg_7_0._effectBones = var_7_0
	end

	if not arg_7_0._btnLottery._bones then
		local var_7_1 = DragonBones.create("choujiang")

		lc.addChildToCenter(arg_7_0._btnLottery, var_7_1)
		var_7_1:gotoAndPlay("effect1")

		arg_7_0._btnLottery._bones = var_7_1
	end

	if arg_7_0._nextRefresh == 0 then
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
		ClientData.sendGetExpeditionEx()
	end
end

function var_0_0.onExit(arg_9_0)
	var_0_0.super.onExit(arg_9_0)
	ClientData.removeMsgListener(arg_9_0)
	arg_9_0:clearCountDown()

	if arg_9_0._effectBones then
		arg_9_0._effectBones:removeFromParent()

		arg_9_0._effectBones = nil
	end

	if arg_9_0._btnLottery._bones then
		arg_9_0._btnLottery._bones:removeFromParent()

		arg_9_0._btnLottery._bones = nil
	end
end

function var_0_0.onCleanup(arg_10_0)
	var_0_0.super.onCleanup(arg_10_0)
	lc.TextureCache:removeTextureForKey(lc.File:fullPathForFilename("res/jpg/copy_bg.jpg"))
end

function var_0_0.updatePlayers(arg_11_0)
	arg_11_0._playerLayer:removeAllChildren()

	arg_11_0._playerItems = {}

	for iter_11_0 = 1, #ClientData._expeditionNpcInfos do
		local var_11_0 = ClientData._expeditionNpcInfos[iter_11_0]

		table.insert(arg_11_0._playerItems, arg_11_0:createPlayerItem(var_11_0))
	end

	if ClientData._expeditionBossInfo._type then
		local var_11_1 = ClientData._expeditionBossInfo

		table.insert(arg_11_0._playerItems, arg_11_0:createPlayerItem(var_11_1))
	end
end

function var_0_0.createPlayerItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:calRandomPos(arg_12_1._randomSeed)
	local var_12_1 = ClientView.SCR_H - var_12_0.y
	local var_12_2 = string.format("img_expedition_avatar_%02d", arg_12_1._avatar)

	if ClientData.isAnotherSkin() and lc.FrameCache:getSpriteFrame(var_12_2 .. "_2") then
		var_12_2 = var_12_2 .. "_2"
	elseif ClientData.isAnotherCardImageSkin() and lc.FrameCache:getSpriteFrame(var_12_2 .. "_3") then
		var_12_2 = var_12_2 .. "_3"
	end

	local var_12_3 = string.format("img_expedition_mark_%02d", arg_12_1._level or 3)
	local var_12_4 = string.format("img_expedition_bottom_%02d", arg_12_1._level or 3)
	local var_12_5 = ClientView.createShaderButton(nil)

	function var_12_5._callback()
		return arg_12_0:showInfo(arg_12_1, var_12_5)
	end

	var_12_5:setPosition(var_12_0)
	var_12_5:setLocalZOrder(var_12_1)
	arg_12_0._playerLayer:addChild(var_12_5)

	var_12_5._position = var_12_0

	local var_12_6 = lc.createSprite(var_12_3)

	var_12_5:setContentSize(cc.size(lc.w(var_12_6) + 16, lc.h(var_12_6) + 16))
	var_12_5:setAnchorPoint(cc.p(0.5, 0))
	lc.addChildToCenter(var_12_5, var_12_6)

	var_12_6._pos = cc.p(var_12_6:getPosition())

	local var_12_7 = lc.createSprite(var_12_2)
	local var_12_8 = cc.p(lc.cw(var_12_6) + 2, lc.h(var_12_6) - lc.ch(var_12_7) + 6)

	if arg_12_1._type == var_0_0.PlayerType.boss then
		var_12_8.y = var_12_8.y - 32
	end

	lc.addChildToPos(var_12_6, var_12_7, var_12_8)

	var_12_7._posY = var_12_7:getPositionY()

	var_12_6:runAction(lc.rep(lc.sequence(lc.moveTo(0.5, cc.p(var_12_6._pos.x, var_12_6._pos.y - 5)), lc.moveTo(0.5, cc.p(var_12_6._pos.x, var_12_6._pos.y + 5)))))

	local var_12_9 = lc.createSprite(var_12_4)

	lc.addChildToPos(var_12_5, var_12_9, cc.p(lc.cw(var_12_5), -10), -1)

	return var_12_5
end

function var_0_0.onSelectPlayer(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getCost(arg_14_1)

	if arg_14_1._challengeCount == 0 and not ClientView.checkGold(var_14_0) then
		return
	end

	arg_14_0:hideInfo()

	ClientData._battleFromCopy = {
		_type = Data.CopyType.expedition_ex
	}

	ClientView.getActiveIndicator():show(Str(STR.WAITING))

	ClientData._expeditionCurNpc = arg_14_1._id + 1

	ClientData.sendWorldExpeditionEx(P._curTroopIndex, arg_14_1._id, arg_14_1._type == var_0_0.PlayerType.boss)
end

function var_0_0.onMsg(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.type
	local var_15_1 = arg_15_1.status

	if var_15_0 == SglMsgType_pb.PB_TYPE_WORLD_GET_EXPEDITION_EX then
		ClientView.getActiveIndicator():hide()

		local var_15_2 = arg_15_1.Extensions[World_pb.SglWorldMsg.world_get_expedition_ex_resp]

		ClientData._expeditionNpcInfos = {}

		for iter_15_0 = 1, #var_15_2.troops do
			local var_15_3 = var_15_2.troops[iter_15_0]
			local var_15_4 = {}

			table.insert(ClientData._expeditionNpcInfos, var_15_4)

			var_15_4._type = var_0_0.PlayerType.npc
			var_15_4._level = var_15_3.level
			var_15_4._randomSeed = var_15_3.random_position
			var_15_4._id = iter_15_0 - 1
			var_15_4._infoId = var_15_3.troop_data.info.id
			var_15_4._avatar = var_15_3.troop_data.info.avatar
			var_15_4._name = var_15_3.troop_data.info.name
			var_15_4._challengeCount = var_15_3.chanllenge_count
			var_15_4._nextRefresh = math.floor(var_15_3.next_refresh / 1000)
			var_15_4._avatar = P.getCharacterId(var_15_4)
		end

		ClientData._expeditionBossInfo = {}

		if var_15_2:HasField("boss") then
			local var_15_5 = var_15_2.boss

			if var_15_5.boss.info.avatar ~= 0 then
				local var_15_6 = ClientData._expeditionBossInfo

				var_15_6._type = var_0_0.PlayerType.boss
				var_15_6._challengeCount = var_15_5.chanllenge_count
				var_15_6._randomSeed = var_15_5.random_position
				var_15_6._id = var_15_5.boss.id
				var_15_6._infoId = var_15_5.boss.info.id
				var_15_6._name = var_15_5.boss.info.name
				var_15_6._avatar = var_15_5.boss.info.avatar
				var_15_6._nextRefresh = math.floor(var_15_5.next_refresh / 1000)
			end
		end

		ClientData._expeditionCurNpc = var_15_2.cur_npc
		ClientData._lotteryPower = var_15_2.lottery_power
		arg_15_0._lastNpcUpdate = var_15_2.last_npc_update_time
		arg_15_0._lastBossUpdate = var_15_2.last_boss_update_time
		arg_15_0._lastLotteryUpdate = var_15_2.last_lottery_power_update_time
		arg_15_0._nextRefresh = var_15_2.next_refresh

		arg_15_0:updatePlayers()
		arg_15_0:updateCountDown(true)

		return true
	end
end

function var_0_0.calRandomPos(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or 0

	local function var_16_0()
		arg_16_1 = (arg_16_1 * 1103515245 + 12345) % 65536

		return arg_16_1 / 65536
	end

	local var_16_1 = var_16_0() * lc.w(arg_16_0._playerLayer)
	local var_16_2 = var_16_0() * lc.h(arg_16_0._playerLayer)

	if arg_16_2 > 50 then
		return cc.p(var_16_1, var_16_2)
	end

	for iter_16_0 = 1, #arg_16_0._playerItems do
		local var_16_3 = arg_16_0._playerItems[iter_16_0]._position

		if math.abs(var_16_3.x - var_16_1) < 50 and math.abs(var_16_3.y - var_16_2) < 50 then
			return arg_16_0:calRandomPos(arg_16_1, arg_16_2 + 1)
		end
	end

	return cc.p(var_16_1, var_16_2)
end

function var_0_0.showInfo(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:convertToWorldSpace(cc.p(lc.cw(arg_18_2), lc.ch(arg_18_2)))
	local var_18_1 = cc.p(var_18_0.x, var_18_0.y)
	local var_18_2 = cc.size(370, 420)

	var_18_1.x = var_18_1.x + (var_18_1.x + var_18_2.width + lc.cw(arg_18_2) < ClientView.SCR_W and 1 or -1) * (var_18_2.width / 2 + lc.cw(arg_18_2))

	if var_18_1.y - var_18_2.height / 2 < 50 then
		var_18_1.y = 50 + var_18_2.height / 2
	elseif var_18_1.y + var_18_2.height / 2 > ClientView.SCR_H - 60 then
		var_18_1.y = ClientView.SCR_H - 60 - var_18_2.height / 2
	end

	arg_18_0:hideInfo()

	local var_18_3 = ccui.Layout:create()

	var_18_3:setContentSize(var_18_2)
	var_18_3:setAnchorPoint(0.5, 0.5)
	var_18_3:setTouchEnabled(true)
	lc.addChildToPos(arg_18_0, var_18_3, var_18_1)

	arg_18_0._infoLayer = var_18_3

	local var_18_4 = lc.createSprite({
		_name = "img_com_bg_50",
		_crect = cc.rect(42, 40, 1, 1),
		_size = var_18_2
	})

	lc.addChildToCenter(var_18_3, var_18_4)

	local var_18_5 = lc.createSprite("img_com_bg_51")
	local var_18_6 = cc.p(var_18_1.x > var_18_0.x and 2 - lc.cw(var_18_5) or lc.w(var_18_4) + lc.cw(var_18_5) - 2, lc.ch(var_18_4) + var_18_0.y - var_18_1.y + 10)

	lc.addChildToPos(var_18_4, var_18_5, var_18_6)
	var_18_5:setFlippedX(var_18_1.x < var_18_0.x)

	local var_18_7 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_19_0)
		arg_18_0:onSelectPlayer(arg_18_1)
	end, ClientView.CRECT_BUTTON, 180)

	lc.addChildToPos(var_18_3, var_18_7, cc.p(lc.cw(var_18_3), 0))
	var_18_7:addLabel(lc.str(STR.CHALLENGE))

	local var_18_8 = lc.createSprite("img_divide_line_5")

	lc.addChildToPos(var_18_4, var_18_8, cc.p(lc.cw(var_18_4), lc.h(var_18_4) - 60))
	var_18_8:setScale(1.8, 0.5)

	local var_18_9 = lc.createSprite("img_divide_line_5")

	lc.addChildToPos(var_18_4, var_18_9, cc.p(lc.cw(var_18_4), 150))
	var_18_9:setScale(1.8, 0.5)

	local var_18_10 = Data._characterDescInfo[arg_18_1._avatar]

	if var_18_10 then
		local var_18_11 = ClientView.createTTF(arg_18_1._name, ClientView.FontSize.M2, ClientView.COLOR_GLOW_BLUE)

		lc.addChildToPos(var_18_4, var_18_11, cc.p(lc.cw(var_18_4), lc.h(var_18_4) - 34))

		local var_18_12 = ClientView.createTTF(lc.str(var_18_10._descSid), ClientView.FontSize.S2, nil, cc.size(var_18_2.width - 60, 0))

		lc.addChildToPos(var_18_4, var_18_12, cc.p(lc.cw(var_18_4), lc.h(var_18_4) - 90 - lc.ch(var_18_12)))
	end

	local var_18_13 = arg_18_0._dropInfos[(arg_18_1._level or 3) + 1]

	if var_18_13 then
		local var_18_14 = ClientView.createBMFont(ClientView.BMFont.huali_26, lc.str(STR.TASK))

		lc.addChildToPos(var_18_4, var_18_14, cc.p(lc.cw(var_18_14) + 30, 120))
		var_18_14:setColor(ClientView.COLOR_LABEL_LIGHT)

		local var_18_15 = IconWidget.createByInfoId(var_18_13._pid[1][1], var_18_13._pid[1][2])

		lc.addChildToPos(var_18_4, var_18_15, cc.p(lc.cw(var_18_4), lc.y(var_18_14) - 20))
		var_18_15:setScale(0.8)
		var_18_15._countBg:setVisible(true)
	end

	if arg_18_1._challengeCount then
		local var_18_16 = ClientView.createTTF(lc.str(STR.REMAIN_CHALLENGE_TIMES) .. ": " .. arg_18_1._challengeCount, ClientView.FontSize.S2)

		lc.addChildToPos(var_18_4, var_18_16, cc.p(lc.cw(var_18_16) + 30, 150 + lc.ch(var_18_16) + 10))

		if arg_18_1._challengeCount == 0 then
			var_18_7._label:setPosition(lc.cw(var_18_7) - 44, lc.ch(var_18_7))

			local var_18_17 = lc.createSprite("img_icon_res1_s")

			lc.addChildToPos(var_18_7, var_18_17, cc.p(lc.cw(var_18_7) + 4, lc.ch(var_18_7)))

			local var_18_18 = arg_18_0:getCost(arg_18_1)
			local var_18_19 = ClientView.createBMFont(ClientView.BMFont.huali_26, -var_18_18)

			lc.addChildToPos(var_18_7, var_18_19, cc.p(lc.cw(var_18_7) + 50, lc.ch(var_18_7)))
		end
	end

	local var_18_20 = arg_18_1._nextRefresh - ClientData.getCurrentTime()
	local var_18_21 = ClientView.createTTF(lc.str(STR.LEAVE_COUNTDOWN) .. ": " .. arg_18_0:getRemainSecondsStr(var_18_20), ClientView.FontSize.S2)

	var_18_21:setAnchorPoint(0, 0.5)

	var_18_21._seconds = var_18_20

	var_18_21:runAction(lc.rep(lc.sequence(lc.delay(1), function()
		var_18_21._seconds = math.max(0, var_18_21._seconds - 1)

		var_18_21:setString(lc.str(STR.LEAVE_COUNTDOWN) .. ": " .. arg_18_0:getRemainSecondsStr(var_18_21._seconds))
	end)))
	lc.addChildToPos(var_18_4, var_18_21, cc.p(30, 150 + lc.ch(var_18_21) + 34))
end

function var_0_0.hideInfo(arg_21_0)
	if arg_21_0._infoLayer then
		arg_21_0._infoLayer:removeFromParent()

		arg_21_0._infoLayer = nil
	end
end

function var_0_0.updateCountDown(arg_22_0, arg_22_1)
	if not arg_22_1 and arg_22_0._countDown and arg_22_0._countDown <= 0 then
		arg_22_0:clearCountDown()
		ClientView.getActiveIndicator():show(Str(STR.WAITING))
		ClientData.sendGetExpeditionEx()

		return
	end

	if arg_22_1 or not arg_22_0._countDown then
		arg_22_0._countDown = math.floor(arg_22_0._nextRefresh / 1000 - ClientData.getCurrentTime())

		arg_22_0._countDownLabel:stopAllActions()
		arg_22_0._countDownLabel:runAction(lc.rep(lc.sequence(lc.delay(1), function()
			arg_22_0._countDown = arg_22_0._countDown - 1

			arg_22_0:updateCountDown()
		end)))
	end

	arg_22_0._countDownLabel:setString(lc.str(STR.REFRESH_COUNTDOWN) .. " " .. arg_22_0:getRemainSecondsStr(arg_22_0._countDown))
end

function var_0_0.clearCountDown(arg_24_0)
	arg_24_0._countDown = nil

	arg_24_0._countDownLabel:stopAllActions()
end

function var_0_0.getCost(arg_25_0, arg_25_1)
	local var_25_0 = 0

	if arg_25_1._type == var_0_0.PlayerType.boss then
		var_25_0 = Data._globalInfo._expeditionBossCost
	else
		var_25_0 = ({
			Data._globalInfo._expeditionSimpleNPCCost,
			Data._globalInfo._expeditionMediumNPCCost,
			Data._globalInfo._expeditionHardNPCCost
		})[arg_25_1._level + 1]
	end

	return var_25_0
end

function var_0_0.getRemainSecondsStr(arg_26_0, arg_26_1)
	local var_26_0 = math.floor(arg_26_1 / 3600)
	local var_26_1 = math.floor((arg_26_1 - var_26_0 * 3600) / 60)
	local var_26_2 = math.floor(arg_26_1 % 60)

	return (string.format("%d:%02d:%02d", var_26_0, var_26_1, var_26_2))
end

return var_0_0
