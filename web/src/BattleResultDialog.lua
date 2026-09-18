local var_0_0 = class("BattleResultDialog", lc.ExtendUIWidget)

BattleResultDialog = var_0_0
var_0_0.Type = {
	battle_result = 1,
	guide_result = 4,
	boss_result = 3,
	dark_result = 6,
	world_boss_result = 5,
	replay_result = 2
}

function var_0_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new(lc.EXTEND_LAYOUT_MASK)

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)
	var_1_0:registerScriptHandler(function(arg_2_0)
		if arg_2_0 == "enter" then
			var_1_0:onEnter()
		elseif arg_2_0 == "cleanup" then
			var_1_0:onCleanup()
		end
	end)

	return var_1_0
end

function var_0_0.createTest()
	ClientData.loadLCRes("res/battle.lcres")

	local var_3_0 = {
		isGuideWorldBattle = function(arg_4_0)
			return false
		end
	}

	var_3_0._nameTag = "normal"
	var_3_0._battleType = Data.BattleType.boss
	var_3_0._baseBattleType = math.floor(var_3_0._battleType / 100)
	var_3_0._input = {
		_cityChapterId = 1,
		_opponent = {
			_bossId = 105
		}
	}

	local var_3_1 = {
		isRank = false,
		_isTask = true,
		_isAttacker = true,
		_resultType = Data.BattleResult.draw,
		_cards = {}
	}

	var_3_1._curRank = 10
	var_3_1._exp = 6
	var_3_1._preExp = 380
	var_3_1._curExp = 570
	var_3_1._gold = 678
	var_3_1._score = 234
	var_3_1._trophy = 20
	var_3_1._taskResults = {
		{
			true
		}
	}
	var_3_1._grain = 10
	var_3_1._levelId = 0
	var_3_1._preLevel = 20
	var_3_1._curLevel = 20
	var_3_1._ingot = 10
	var_3_1._rank = -10
	var_3_1._curRank = 22
	var_3_1._tasks = {
		{},
		{}
	}
	var_3_1._taskResults = {
		true,
		true
	}
	var_3_1._bossResult = {
		_damage = 10000,
		_damageGold = 20500,
		_hp = 20,
		_killGold = 15000
	}
	var_3_1._player = P
	var_3_1._opponent = P
	var_3_1._log = {}

	return var_0_0.create(var_3_0, var_0_0.Type.replay_result, var_3_1)
end

function var_0_0.onEnter(arg_5_0)
	if arg_5_0._result._resultType == Data.BattleResult.win then
		lc.Audio.playAudio(AUDIO.M_BATTLE_WIN)
	else
		lc.Audio.playAudio(AUDIO.M_BATTLE_LOSE)
	end
end

function var_0_0.onCleanup(arg_6_0)
	lc.TextureCache:removeTextureForKey("res/jpg/dark_result_bg.jpg")
end

function var_0_0.init(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._battleUi = arg_7_1
	arg_7_0._type = arg_7_2
	arg_7_0._result = arg_7_3
	arg_7_0._rewardItems = {}

	if arg_7_3._cards then
		for iter_7_0, iter_7_1 in ipairs(arg_7_3._cards) do
			if iter_7_1._infoId ~= Data.PropsId.flag and (not (iter_7_1._infoId >= Data.PropsId.clash_chest) or not (iter_7_1._infoId <= Data.PropsId.clash_chest_end)) then
				if Data.getInfo(iter_7_1._infoId)._type == Data.PropsType.artifact then
					for iter_7_2 = 1, iter_7_1._count do
						table.insert(arg_7_0._rewardItems, {
							_count = 1,
							_infoId = iter_7_1._infoId
						})
					end
				elseif iter_7_1._count > 0 then
					table.insert(arg_7_0._rewardItems, iter_7_1)
				end
			end
		end

		P:sortResultItems(arg_7_0._rewardItems)
	end

	if arg_7_2 == var_0_0.Type.battle_result then
		arg_7_0:createBattleResult(arg_7_3)
	elseif arg_7_2 == var_0_0.Type.guide_result then
		arg_7_0:createGuidanceResult(arg_7_3)
	elseif arg_7_2 == var_0_0.Type.replay_result then
		arg_7_0:createReplayResult(arg_7_3)
	elseif arg_7_2 == var_0_0.Type.boss_result then
		arg_7_0:createBossResult(arg_7_3)
	elseif arg_7_2 == var_0_0.Type.world_boss_result then
		arg_7_0:createWorldBossResult(arg_7_3)
	elseif arg_7_2 == var_0_0.Type.dark_result then
		arg_7_0:createDarkResult(arg_7_3)
	end
end

function var_0_0.hide(arg_8_0)
	if arg_8_0._type == var_0_0.Type.dark_result then
		P._playerFindDark:clearScore()
	end

	arg_8_0:removeFromParent()
end

function var_0_0.createBattleResult(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = arg_9_0:createTitle(arg_9_1._resultType, 1)
	local var_9_2 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH)

	lc.addChildToPos(arg_9_0, var_9_0, var_9_2)

	if arg_9_1._resultType == Data.BattleResult.win then
		var_9_2.x = var_9_2.x + 256
		var_9_2.y = var_9_2.y + 120

		if arg_9_1._isTask then
			local var_9_3, var_9_4 = arg_9_0:createTask(arg_9_1._tasks, arg_9_1._taskResults, var_9_1)

			var_9_1 = var_9_4
			var_9_2.y = var_9_2.y - lc.h(var_9_3) / 2

			lc.addChildToPos(arg_9_0, var_9_3, var_9_2)

			var_9_2.y = lc.bottom(var_9_3) - 20
		elseif arg_9_1._isRank and P:getMaxCharacterLevel() >= 30 then
			local var_9_5, var_9_6 = arg_9_0:createRank(arg_9_1._rank, arg_9_1._curRank, Str(STR.BATTLE_CUR_RANK), var_9_1)

			var_9_1 = var_9_6
			var_9_2.y = var_9_2.y - lc.h(var_9_5) / 2

			lc.addChildToPos(arg_9_0, var_9_5, var_9_2)

			var_9_2.y = lc.bottom(var_9_5) - 20
		end

		local var_9_7, var_9_8 = arg_9_0:createResource(arg_9_1, var_9_1)

		var_9_1 = var_9_8
		var_9_2.y = var_9_2.y - lc.h(var_9_7) / 2

		lc.addChildToPos(arg_9_0, var_9_7, var_9_2)

		var_9_2.y = lc.bottom(var_9_7) - 20

		local var_9_9 = arg_9_0:createReward(var_9_1)

		if var_9_9 then
			var_9_2.y = var_9_2.y - lc.h(var_9_9) / 2

			lc.addChildToPos(arg_9_0, var_9_9, var_9_2)
		end
	elseif arg_9_1._resultType == Data.BattleResult.lose then
		var_9_2.x = var_9_2.x + 256
		var_9_2.y = var_9_2.y + 120

		if arg_9_1._trophy ~= nil and arg_9_1._trophy ~= 0 or arg_9_1._gold ~= nil and arg_9_1._gold ~= 0 or arg_9_1._flag ~= nil and arg_9_1._flag ~= 0 or arg_9_1._activePoint ~= nil and arg_9_1._activePoint ~= 0 or arg_9_1._unionBattleTrophy ~= nil and arg_9_1._unionBattleTrophy ~= 0 or arg_9_1.survival_ex_trophy ~= nil and arg_9_1.survival_ex_trophy ~= 0 or arg_9_1._clashExTrophy ~= nil and arg_9_1._clashExTrophy ~= 0 then
			local var_9_10 = arg_9_0:createResource(arg_9_1, var_9_1)

			var_9_2.y = var_9_2.y - lc.h(var_9_10) / 2

			var_9_10:setPosition(var_9_2)
			arg_9_0:addChild(var_9_10)

			var_9_2.y = lc.bottom(var_9_10) - 20
		end

		local var_9_11 = arg_9_0:createReward(var_9_1)

		if var_9_11 then
			var_9_2.y = var_9_2.y - lc.h(var_9_11) / 2

			lc.addChildToPos(arg_9_0, var_9_11, var_9_2)
		elseif arg_9_0._battleUi._battleType ~= Data.BattleType.PVP_ladder and arg_9_0._battleUi._battleType ~= Data.BattleType.PVP_ladder_npc and arg_9_0._battleUi._battleType ~= Data.BattleType.teach and arg_9_0._battleUi._battleType ~= Data.BattleType.PVP_room and arg_9_0._battleUi._battleType ~= Data.BattleType.PVP_group and arg_9_0._battleUi._battleType ~= Data.BattleType.PVP_survival and arg_9_0._battleUi._battleType ~= Data.BattleType.PVP_survival_ex then
			local var_9_12 = arg_9_0:createEnhancePath(var_9_1, var_9_2.y)

			var_9_2.y = var_9_2.y - lc.h(var_9_12) / 2

			var_9_12:setPosition(var_9_2)
			arg_9_0:addChild(var_9_12)
		end
	end

	arg_9_0:createButton()

	if ClientData._isAutoBattle then
		arg_9_0:onButtonEvent(arg_9_0._pBtnExit)
	end
end

function var_0_0.createGuidanceResult(arg_10_0, arg_10_1)
	local var_10_0 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH)
	local var_10_1 = arg_10_0:createTitle(arg_10_1._resultType)

	lc.addChildToPos(arg_10_0, var_10_1, var_10_0)

	if arg_10_0._battleUi._nameTag == "normal" then
		arg_10_0:createButton()
		GuideManager.showSoftGuideFinger(arg_10_0._pBtnExit)
	end
end

function var_0_0.createTitle(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = 1366
	local var_11_1 = 530
	local var_11_2 = lc.createNode(cc.size(var_11_0, var_11_1))

	var_11_2:setScale(arg_11_2 or 1)

	local var_11_3 = cc.p(var_11_0 / 2, var_11_1 / 2)
	local var_11_4 = arg_11_1 == Data.BattleResult.win and "effect1" or arg_11_1 == Data.BattleResult.lose and "effect3" or "effect5"
	local var_11_5 = arg_11_1 == Data.BattleResult.win and "effect2" or arg_11_1 == Data.BattleResult.lose and "effect4" or "effect6"
	local var_11_6 = DragonBones.create(arg_11_1 == Data.BattleResult.win and "win" or arg_11_1 == Data.BattleResult.lose and "lose" or "draw")

	var_11_6:setPosition(var_11_3)
	var_11_2:addChild(var_11_6, 0)
	var_11_6:gotoAndPlay(var_11_4)

	local var_11_7 = var_11_6:getAnimationDuration(var_11_4)

	var_11_2:runAction(lc.sequence(var_11_7, function()
		var_11_6:gotoAndPlay(var_11_5)
	end))

	local var_11_8 = arg_11_1 == Data.BattleResult.win and "bat_result_battle_win" or arg_11_1 == Data.BattleResult.lose and "bat_result_battle_lose" or "bat_result_battle_draw"
	local var_11_9 = lc.createSprite(var_11_8)

	lc.addChildToPos(var_11_2, var_11_9, cc.p(var_11_0 / 2 + 256, var_11_1 / 2 + 180 + 300))
	var_11_9:runAction(lc.sequence(var_11_7, lc.moveBy(0.1, 0, -300)))

	return var_11_2, var_11_7 + 0.3
end

function var_0_0.createResource(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = lc.createNode()
	local var_13_1 = arg_13_0._type == var_0_0.Type.boss_result
	local var_13_2 = arg_13_0._battleUi._battleType
	local var_13_3 = var_13_2 == Data.BattleType.PVP_clash or var_13_2 == Data.BattleType.PVP_clash_npc
	local var_13_4 = arg_13_1._trophy
	local var_13_5 = arg_13_1._gold
	local var_13_6 = arg_13_1._flag
	local var_13_7 = arg_13_1._ingot
	local var_13_8 = arg_13_1._personalPower
	local var_13_9 = {}

	if arg_13_0._type == var_0_0.Type.boss_result then
		if var_13_5 and var_13_5 ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res1_s",
				_num = var_13_5
			})
		end

		if var_13_7 and var_13_7 ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res3_s",
				_num = var_13_7
			})
		end
	else
		if var_13_4 and var_13_4 ~= 0 then
			table.insert(var_13_9, {
				_num = var_13_4,
				_iconName = var_13_3 and "img_icon_res6_s" or "img_icon_res5_s"
			})
		end

		if var_13_6 and var_13_6 ~= 0 then
			table.insert(var_13_9, {
				_num = var_13_6,
				_iconName = ClientData.getPropIconName(7019)
			})
		end

		if var_13_5 and var_13_5 ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res1_s",
				_num = var_13_5
			})
		end

		if var_13_8 and var_13_8 ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res14_s",
				_num = var_13_8
			})
		end

		if arg_13_1._yubi and arg_13_1._yubi > 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_props_s7024",
				_num = arg_13_1._yubi
			})
		end

		if arg_13_1._activePoint and arg_13_1._activePoint > 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res14_s",
				_num = arg_13_1._activePoint
			})
		end

		if arg_13_1._loseSkinCrystal then
			table.insert(var_13_9, {
				_iconName = "img_icon_props_s7109",
				_num = arg_13_1._loseSkinCrystal
			})
		end

		if arg_13_1._unionBattleTrophy and arg_13_1._unionBattleTrophy ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res15_s",
				_num = arg_13_1._unionBattleTrophy
			})
		end

		if arg_13_1._darkTrophy and arg_13_1._darkTrophy ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res16_s",
				_num = arg_13_1._darkTrophy
			})
		end

		if arg_13_1._newServerScore and arg_13_1._newServerScore ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res18_s",
				_num = arg_13_1._newServerScore
			})
		end

		if arg_13_1.trophy_activity and arg_13_1.trophy_activity ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res19_s",
				_num = arg_13_1.trophy_activity
			})
		end

		if arg_13_1.rank1 and arg_13_1.rank1 ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res20_s",
				_num = arg_13_1.rank1
			})
		end

		if arg_13_1.survival_ex_trophy and arg_13_1.survival_ex_trophy ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res22_s",
				_num = arg_13_1.survival_ex_trophy
			})
		end

		if arg_13_1._clashExTrophy and arg_13_1._clashExTrophy ~= 0 then
			table.insert(var_13_9, {
				_iconName = "img_icon_res23_s",
				_num = arg_13_1._clashExTrophy
			})
		end
	end

	if (var_13_2 == Data.BattleType.PVP_ladder or var_13_2 == Data.BattleType.PVP_ladder_npc) and arg_13_1._resultType == Data.BattleResult.win then
		table.insert(var_13_9, {
			_iconName = "img_icon_res5_s",
			_num = Data._globalInfo._ladderExTrophy[P._playerFindLadder._winCount]
		})
	end

	local var_13_10 = next(var_13_9) ~= nil
	local var_13_11 = var_13_1 or arg_13_1._exp and arg_13_1._exp > 0
	local var_13_12 = 512
	local var_13_13 = var_13_10 and var_13_11 and 90 or 50

	if var_13_4 and var_13_4 ~= 0 then
		var_13_13 = var_13_13 + 40
	end

	var_13_0:setContentSize(var_13_12, var_13_13)

	local var_13_14 = var_13_13 - 10

	if var_13_10 then
		local var_13_15 = 20
		local var_13_16 = 0
		local var_13_17 = 40
		local var_13_18 = cc.p(0, var_13_17 / 2)
		local var_13_19 = lc.createNode(cc.size(var_13_16, var_13_17))

		for iter_13_0, iter_13_1 in ipairs(var_13_9) do
			if iter_13_1._num ~= 0 then
				local var_13_20 = 0
				local var_13_21 = var_13_18.x

				if iter_13_1._label then
					local var_13_22 = ClientView.createBMFont(ClientView.BMFont.huali_26, iter_13_1._label)

					var_13_22:setColor(ClientView.COLOR_TEXT_ORANGE)
					lc.addChildToPos(var_13_19, var_13_22, cc.p(var_13_18.x + lc.w(var_13_22) / 2, var_13_18.y))

					var_13_20, var_13_21 = lc.w(var_13_22) + 6, lc.right(var_13_22) + 6
				end

				local var_13_23 = lc.createSprite(iter_13_1._iconName)

				lc.addChildToPos(var_13_19, var_13_23, cc.p(var_13_21 + lc.w(var_13_23) / 2, var_13_18.y))

				local var_13_24 = iter_13_1._num > 0 and "+" .. iter_13_1._num or tostring(iter_13_1._num)
				local var_13_25 = ClientView.createBMFont(ClientView.BMFont.huali_32, var_13_24)

				lc.addChildToPos(var_13_19, var_13_25, cc.p(lc.right(var_13_23) + 10 + lc.w(var_13_25) / 2, var_13_18.y))

				var_13_16 = var_13_16 + var_13_20 + lc.w(var_13_23) + 10 + lc.w(var_13_25) + var_13_15
				var_13_18.x = var_13_18.x + lc.w(var_13_23) + 10 + lc.w(var_13_25) + var_13_15
			end
		end

		local var_13_26 = var_13_16 - var_13_15

		var_13_19:setContentSize(var_13_26, var_13_17)
		lc.addChildToPos(var_13_0, var_13_19, cc.p(lc.w(var_13_0) / 2, var_13_14 - var_13_17 / 2))

		var_13_14 = var_13_14 - var_13_17 - 20
	end

	if var_13_11 then
		local var_13_27 = arg_13_1._exp
		local var_13_28 = arg_13_1._preExp
		local var_13_29 = arg_13_1._preLevel
		local var_13_30 = arg_13_1._curLevel
		local var_13_31 = ClientView.createLevelExpBar(var_13_29, var_13_28, P:getLevelupExp(var_13_29), 360)

		lc.addChildToPos(var_13_0, var_13_31, cc.p(var_13_12 / 2 + 10, var_13_14 - lc.ch(var_13_31) - 0))

		var_13_14 = var_13_14 - lc.h(var_13_31) - 10

		local var_13_32 = ClientView.createBMFont(ClientView.BMFont.huali_26, "+" .. var_13_27)

		var_13_32:setScale(0.9)
		var_13_32:setAnchorPoint(1, 0.5)
		var_13_32:setColor(ClientView.COLOR_TEXT_GREEN)
		lc.addChildToPos(var_13_31, var_13_32, cc.p(lc.w(var_13_31) - 10, lc.h(var_13_31) / 2 + 1))

		local var_13_33 = var_13_29
		local var_13_34 = math.max(1, math.floor(var_13_27 / 50))

		var_13_31:scheduleUpdateWithPriorityLua(function()
			if var_13_27 < var_13_34 then
				var_13_34 = var_13_27
			end

			var_13_27 = var_13_27 - var_13_34
			var_13_28 = var_13_28 + var_13_34

			local var_14_0 = P:getLevelupExp(var_13_33)

			if var_14_0 <= var_13_28 then
				var_13_33 = var_13_33 + 1
				var_13_28 = var_13_28 - var_14_0

				var_13_31._level:setString(var_13_33)
			end

			var_13_31._bar:setPercent(var_13_28 * 100 / var_14_0)
			var_13_31:setLabel(var_13_28, var_14_0)

			if var_13_33 >= P:getMaxLevel(P:getCharacterId()) then
				var_13_31._level:setString(P:getCharacterId())
				var_13_31._label:setString("MAX")
				var_13_31._bar:setPercent(100)
			end

			if var_13_27 == 0 then
				var_13_31:unscheduleUpdate()
			end
		end, 0)

		if var_13_30 ~= var_13_29 then
			local var_13_35 = require("LevelUpPanel").createLord(var_13_29, var_13_30)

			arg_13_0:addChild(var_13_35, 1)
		end

		arg_13_2 = arg_13_2 + 0.2
	end

	if var_13_4 and var_13_4 ~= 0 then
		local curT = (P and P._playerFindClash and P._playerFindClash._trophy) or (P and P._trophy) or 0
		local newTrophy = arg_13_1._curRank or curT
		local oldTrophy = arg_13_1._preRank or (newTrophy - var_13_4)
		if oldTrophy < 0 then oldTrophy = 0 end
		if newTrophy < 0 then newTrophy = 0 end

		local var_13_36 = ClientView.createTrophyProgressBar(360, oldTrophy)

		lc.addChildToPos(var_13_0, var_13_36, cc.p(var_13_12 / 2, var_13_14 - lc.ch(var_13_36) - 10))

		local delta = newTrophy - oldTrophy
		if delta ~= 0 then
			local animTrophy = oldTrophy
			local step = delta > 0 and math.max(1, math.floor(delta / 25)) or math.min(-1, math.ceil(delta / 25))
			var_13_36:scheduleUpdateWithPriorityLua(function()
				if (delta > 0 and animTrophy >= newTrophy) or (delta < 0 and animTrophy <= newTrophy) then
					var_13_36:unscheduleUpdate()
					var_13_36.update(newTrophy)
					return
				end
				animTrophy = animTrophy + step
				if (delta > 0 and animTrophy > newTrophy) or (delta < 0 and animTrophy < newTrophy) then
					animTrophy = newTrophy
				end
				var_13_36.update(animTrophy)
			end, 0)
		else
			var_13_36.update(newTrophy)
		end
	end

	var_13_0:setVisible(false)
	var_13_0:runAction(lc.sequence(arg_13_2, function()
		var_13_0:setVisible(true)
	end))

	return var_13_0, arg_13_2
end

function var_0_0.createTask(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = 512
	local var_16_1 = #arg_16_1 * 40
	local var_16_2 = lc.createNode(cc.size(var_16_0, var_16_1))
	local var_16_3 = {}
	local var_16_4 = 0

	for iter_16_0 = 1, #arg_16_1 do
		local var_16_5 = cc.Label:createWithTTF(arg_16_1[iter_16_0], ClientView.TTF_FONT, ClientView.FontSize.S1)

		var_16_5:setColor(lc.Color3B.black)

		var_16_3[#var_16_3 + 1] = var_16_5
		var_16_5._icon = lc.createSprite(arg_16_2[iter_16_0] and "img_icon_right" or "img_icon_wrong")

		if var_16_4 < lc.w(var_16_5) then
			var_16_4 = lc.w(var_16_5)
		end
	end

	local var_16_6 = (var_16_0 - var_16_4) / 2

	for iter_16_1 = 1, #var_16_3 do
		local var_16_7 = lc.createSprite(arg_16_2[iter_16_1] and "bat_result_star_02" or "bat_result_star_01")

		lc.addChildToPos(var_16_2, var_16_7, cc.p(var_16_6, var_16_1 + 20 - 40 * iter_16_1))
		lc.addChildToPos(var_16_2, var_16_3[iter_16_1], cc.p(lc.right(var_16_7) + 10 + lc.cw(var_16_3[iter_16_1]), lc.y(var_16_7)))
		lc.addChildToPos(var_16_2, var_16_3[iter_16_1]._icon, cc.p(lc.right(var_16_3[iter_16_1]) + 10 + lc.cw(var_16_3[iter_16_1]._icon), lc.y(var_16_7)))
	end

	var_16_2:setVisible(false)
	var_16_2:runAction(lc.sequence(arg_16_3, function()
		var_16_2:setVisible(true)
	end))

	return var_16_2, arg_16_3 + 0.2
end

function var_0_0.createReward(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._rewardItems

	if var_18_0 == nil or #var_18_0 == 0 then
		return nil
	end

	local var_18_1 = 512
	local var_18_2 = 160
	local var_18_3 = lc.createNode(cc.size(var_18_1, var_18_2))

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_4 = cc.p(math.floor((iter_18_0 - (#var_18_0 + 1) / 2) * 120 + var_18_1 / 2), 40)

		lc.log("Battle result item infoId = %d, delay = %f, pos(%d, %d)", iter_18_1._infoId, arg_18_1 + 0.2 * iter_18_0, var_18_4.x, var_18_4.y)

		local var_18_5 = IconWidget.create(iter_18_1)

		var_18_5._name:setColor(ClientView.COLOR_TEXT_LIGHT)
		var_18_5:setTouchEnabled(false)
		var_18_5:setOpacity(0)
		var_18_5:runAction(lc.sequence(arg_18_1 + 0.2 * iter_18_0, lc.fadeIn(0.2), function()
			var_18_5:setTouchEnabled(true)
		end))
		lc.addChildToPos(var_18_3, var_18_5, var_18_4)
	end

	arg_18_1 = arg_18_1 + 0.2 * #var_18_0

	return var_18_3, arg_18_1
end

function var_0_0.createRank(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = 512
	local var_20_1 = 40
	local var_20_2 = lc.createNode(cc.size(var_20_0, var_20_1))
	local var_20_3 = ClientView.createBMFont(ClientView.BMFont.huali_26, arg_20_3)

	var_20_3:setColor(lc.Color3B.yellow)
	lc.addChildToPos(var_20_2, var_20_3, cc.p(var_20_0 / 2 - 50, var_20_1 / 2))

	local var_20_4 = ClientView.createBMFont(ClientView.BMFont.num_48, tostring(arg_20_2))

	lc.addChildToPos(var_20_2, var_20_4, cc.p(lc.right(var_20_3) + lc.cw(var_20_4) + 2, lc.y(var_20_3)))

	if arg_20_1 ~= 0 then
		local var_20_5 = arg_20_1 > 0 and ClientView.COLOR_TEXT_GREEN or ClientView.COLOR_TEXT_RED
		local var_20_6 = lc.createSprite(arg_20_1 > 0 and "img_arrow_up_1" or "img_arrow_down_1")

		var_20_6:setColor(var_20_5)
		lc.addChildToPos(var_20_2, var_20_6, cc.p(lc.right(var_20_4) + 16, lc.y(var_20_4)))

		local var_20_7 = ClientView.createBMFont(ClientView.BMFont.huali_26, tostring(math.abs(arg_20_1)))

		var_20_7:setColor(var_20_5)
		lc.addChildToPos(var_20_2, var_20_7, cc.p(lc.right(var_20_6) + 4 + lc.w(var_20_7) / 2, lc.y(var_20_6)))
	end

	return var_20_2, arg_20_4 + 0.2
end

function var_0_0.createEnhancePath(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = 512
	local var_21_1 = 248
	local var_21_2 = lc.createNode(cc.size(var_21_0, var_21_1))

	if not arg_21_0._battleUi:isGuideWorldBattle() then
		local var_21_3 = ClientView.createShaderButton(nil, function(arg_22_0)
			lc.pushScene(require("HeroCenterScene").create())
		end)

		var_21_3:setContentSize(174, 220)
		lc.addChildToCenter(var_21_3, lc.createSpriteWithMask("res/jpg/enhance_troop.jpg"))
		lc.addChildToPos(var_21_2, var_21_3, cc.p(var_21_0 / 2 - 120, 112))

		arg_21_0._pBtnTroop = var_21_3

		local var_21_4 = ClientView.createShaderButton(nil, function(arg_23_0)
			arg_21_0:onButtonEvent(arg_23_0)
		end)

		var_21_4:setContentSize(174, 220)
		lc.addChildToCenter(var_21_4, lc.createSpriteWithMask("res/jpg/enhance_tavern.jpg"))
		lc.addChildToPos(var_21_2, var_21_4, cc.p(var_21_0 / 2 + 120, 114))

		arg_21_0._pBtnTavern = var_21_4
	end

	var_21_2:setVisible(false)
	var_21_2:runAction(lc.sequence(arg_21_1, function()
		var_21_2:setVisible(true)
	end))

	return var_21_2, arg_21_1
end

function var_0_0.createButton(arg_25_0)
	local var_25_0 = 160
	local var_25_1 = ClientView.createScale9ShaderButton("img_btn_1", function(arg_26_0)
		arg_25_0:onButtonEvent(arg_26_0)
	end, ClientView.CRECT_BUTTON, var_25_0)

	var_25_1:addLabel(Str(STR.RETURN))
	var_25_1:setPosition(lc.w(arg_25_0) / 2, 70)
	arg_25_0:addChild(var_25_1)

	arg_25_0._pBtnExit = var_25_1

	local var_25_2 = arg_25_0._battleUi._battleType
	local var_25_3 = arg_25_0._battleUi._baseBattleType == Data.BattleType.base_PVE and var_25_2 ~= Data.BattleType.expedition_ex and var_25_2 ~= Data.BattleType.expedition_ex_boss and arg_25_0._result._resultType == Data.BattleResult.lose and var_25_2 ~= Data.BattleType.PVP_dark
	local var_25_4 = arg_25_0._battleUi._battleType == Data.BattleType.replay and var_25_2 ~= Data.BattleType.PVP_dark
	local var_25_5 = false
	local var_25_6 = not P._playerFindDark:isDarkFinished() and var_25_2 == Data.BattleType.PVP_dark and false
	local var_25_7 = not P._playerFindDark:isDarkFinished() and var_25_2 == Data.BattleType.PVP_dark

	if arg_25_0._result._log then
		lc.log("battle type = %d  sharable = %s", arg_25_0._battleUi._battleType, ClientData._replaySharable and "true" or "false")

		if var_25_4 then
			var_25_5 = ClientData._replaySharable
		else
			var_25_5 = true
		end

		var_25_5 = var_25_5 and var_25_2 ~= Data.BattleType.PVP_dark
	end

	if ClientData.getValidActivityByType(Data.ActivityType.sensitive_day) then
		var_25_5 = false
	end

	if var_25_3 then
		local var_25_8 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_27_0)
			arg_25_0:onButtonEvent(arg_27_0)
		end, ClientView.CRECT_BUTTON, var_25_0)

		var_25_8:addLabel(Str(STR.BATTLE_AGAIN))
		lc.addChildToPos(arg_25_0, var_25_8, cc.p(lc.w(arg_25_0) / 2 + 200, lc.y(var_25_1)))
		lc.offset(var_25_1, -200, 0)

		arg_25_0._pBtnRetry = var_25_8
		arg_25_0._isGrainEnough = true

		if false then
			local var_25_9 = P:getBattleCost(nil, false, arg_25_0._battleUi._input._levelId)
			local var_25_10 = ClientView.createResConsumeButtonArea({
				120,
				160
			}, "img_icon_res2_s", lc.Color3B.white, var_25_9, Str(STR.BATTLE_AGAIN), "img_btn_2")

			function var_25_10._btn._callback(arg_28_0)
				arg_25_0:onButtonEvent(arg_28_0)
			end

			lc.addChildToPos(arg_25_0, var_25_10, cc.p(lc.w(arg_25_0) / 2 + 200, lc.y(var_25_1)))
			lc.offset(var_25_1, -200, 0)

			arg_25_0._pBtnRetry = var_25_10._btn

			if var_25_9 > P._grain then
				var_25_10._resLabel:setColor(lc.Color3B.red)
			else
				arg_25_0._isGrainEnough = true
			end
		end
	elseif var_25_4 then
		local var_25_11 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_29_0)
			arg_25_0:onButtonEvent(arg_29_0)
		end, ClientView.CRECT_BUTTON, var_25_0)

		var_25_11:addLabel(Str(STR.REPLAY))
		lc.addChildToPos(arg_25_0, var_25_11, cc.p(lc.w(arg_25_0) / 2 + 200, lc.y(var_25_1)))
		lc.offset(var_25_1, -200, 0)

		arg_25_0._pBtnReplay = var_25_11
	end

	if var_25_5 then
		local var_25_12 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_30_0)
			arg_25_0:onButtonEvent(arg_30_0)
		end, ClientView.CRECT_BUTTON, var_25_0)

		var_25_12:addLabel(Str(STR.SHARE))
		lc.addChildToPos(arg_25_0, var_25_12, cc.p(lc.w(arg_25_0) / 2 + 200, lc.y(var_25_1)))
		lc.offset(var_25_1, -200, 0)

		arg_25_0._pBtnShare = var_25_12
	end

	if var_25_6 then
		local var_25_13 = ClientView.createScale9ShaderButton("img_btn_2", function(arg_31_0)
			arg_25_0:onButtonEvent(arg_31_0)
		end, ClientView.CRECT_BUTTON, var_25_0)

		var_25_13:addLabel(Str(STR.BATTLE_RETREAT))
		lc.addChildToPos(arg_25_0, var_25_13, cc.p(lc.cw(arg_25_0), lc.y(var_25_1)))

		arg_25_0._pBtnRetreat = var_25_13
	end

	if var_25_7 then
		var_25_1:setVisible(false)
	end
end

function var_0_0.createReplayResult(arg_32_0, arg_32_1)
	local var_32_0 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH)
	local var_32_1 = 300

	if arg_32_1._player then
		for iter_32_0 = 1, 2 do
			local var_32_2 = (iter_32_0 == 1 and arg_32_1._resultType or -arg_32_1._resultType) == Data.BattleResult.win
			local var_32_3 = ccui.Scale9Sprite:createWithSpriteFrameName("bat_result_replay_bg", cc.rect(316, 0, 1, 552))

			var_32_3:setContentSize(ClientView.SCR_CW + var_32_1 / 2 + (iter_32_0 == 1 and -20 or 20), 552)
			lc.addChildToPos(arg_32_0, var_32_3, cc.p(iter_32_0 == 1 and lc.cw(var_32_3) or ClientView.SCR_W - lc.cw(var_32_3), ClientView.SCR_CH + 40))

			if iter_32_0 == 1 then
				var_32_3:setFlippedY(true)
				var_32_3:setFlippedX(true)
			end

			local var_32_4 = ClientView.SCR_W / 4 * (iter_32_0 == 1 and 1 or 3)

			if arg_32_1._resultType ~= Data.BattleResult.draw then
				local var_32_5 = lc.createSprite(var_32_2 and "bat_result_win_s" or "bat_result_lose_s")

				lc.addChildToPos(arg_32_0, var_32_5, cc.p(var_32_4, ClientView.SCR_CH + 210))
				var_32_3:setEffect(var_32_2 and ClientView.SHADER_G2Y or ClientView.SHADER_G2B)
			end

			local var_32_6 = iter_32_0 == 1 and arg_32_1._player or arg_32_1._opponent
			local var_32_7 = UserWidget.create(var_32_6, bor(UserWidget.Flag.LEVEL_NAME), 1, false, true)

			lc.addChildToPos(arg_32_0, var_32_7, cc.p(var_32_4, ClientView.SCR_CH + 40))

			if arg_32_1._battleType ~= Data.BattleType.PVP_ladder and arg_32_1._battleType ~= Data.BattleType.PVP_ladder_npc and arg_32_1._battleType ~= Data.BattleType.PVP_room and arg_32_1._battleType ~= Data.BattleType.PVP_group and arg_32_1._battleType ~= Data.BattleType.PVP_dark and arg_32_1._battleType ~= Data.BattleType.PVP_survival and arg_32_1._battleType ~= Data.BattleType.PVP_survival_ex and arg_32_1._trophy and arg_32_1._trophy ~= 0 then
				local var_32_8 = lc.createSprite("img_icon_res6_s")

				lc.addChildToPos(arg_32_0, var_32_8, cc.p(var_32_4 - 80, ClientView.SCR_CH - 100))

				local var_32_9 = (iter_32_0 == 1 and (arg_32_1._trophy or 0) or arg_32_1._oppoTrophy or 0) * (var_32_2 and 1 or -1)
				local var_32_10 = string.format("%d (%s%d)", var_32_6._trophy or 0, var_32_9 >= 0 and "+" or "", var_32_9)
				local var_32_11 = cc.Label:createWithTTF(var_32_10, ClientView.TTF_FONT, ClientView.FontSize.M1)

				var_32_11:setAnchorPoint(0, 0.5)
				var_32_11:enableShadow()
				lc.addChildToPos(arg_32_0, var_32_11, cc.p(lc.x(var_32_8) + 40, lc.y(var_32_8)))
			end
		end

		if arg_32_1._winScore and arg_32_1._loseScore then
			local var_32_12 = ClientView.createBMFont(ClientView.BMFont.huali_32, Str(STR.WIN_S))
			local var_32_13 = ClientView.createBMFont(ClientView.BMFont.num_48, arg_32_1._winScore)

			lc.addChildToPos(arg_32_0, var_32_12, cc.p(ClientView.SCR_W / 4 - 20, ClientView.SCR_CH - 40))
			lc.addChildToPos(arg_32_0, var_32_13, cc.p(ClientView.SCR_W / 4 + 20, ClientView.SCR_CH - 40))

			local var_32_14 = ClientView.createBMFont(ClientView.BMFont.huali_32, Str(STR.WIN_S))
			local var_32_15 = ClientView.createBMFont(ClientView.BMFont.num_48, arg_32_1._loseScore)

			lc.addChildToPos(arg_32_0, var_32_14, cc.p(ClientView.SCR_W / 4 * 3 - 20, ClientView.SCR_CH - 40))
			lc.addChildToPos(arg_32_0, var_32_15, cc.p(ClientView.SCR_W / 4 * 3 + 20, ClientView.SCR_CH - 40))
		end

		if arg_32_1._resultType == Data.BattleResult.draw then
			local var_32_16 = lc.createSprite("bat_result_battle_draw")

			lc.addChildToPos(arg_32_0, var_32_16, cc.p(ClientView.SCR_CW + 30, ClientView.SCR_CH + 210))
		end
	end

	arg_32_0:createButton()
end

function var_0_0.createBossResult(arg_33_0, arg_33_1)
	return arg_33_0:createBattleResult(arg_33_1)
end

function var_0_0.createWorldBossResult(arg_34_0, arg_34_1)
	local var_34_0 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH)
	local var_34_1, var_34_2 = arg_34_0:createTitle(Data.BattleResult.win)

	lc.addChildToPos(arg_34_0, var_34_1, var_34_0)

	var_34_0.y = var_34_0.y - lc.h(var_34_1) / 2 - 20

	local var_34_3 = lc.createNode(cc.size(240, 120))

	lc.addChildToPos(arg_34_0, var_34_3, var_34_0)

	local var_34_4 = lc.createSprite("img_icon_score")

	lc.addChildToPos(var_34_3, var_34_4, cc.p(lc.w(var_34_3) / 2, lc.h(var_34_3) - 36))

	local var_34_5 = ClientView.createBMFont(ClientView.BMFont.huali_32, arg_34_1._score)

	var_34_5:setColor(ClientView.COLOR_TEXT_GREEN)
	lc.addChildToPos(var_34_3, var_34_5, cc.p(lc.w(var_34_3) / 2, 44))

	var_34_0.y = var_34_0.y - lc.h(var_34_3) / 2 - 20

	if arg_34_1._isRank then
		local var_34_6 = arg_34_0:createRank(arg_34_1._rank, arg_34_1._curRank, Str(STR.BATTLE_SCORE_RANK), var_34_2)

		var_34_0.y = var_34_0.y - lc.h(var_34_6) / 2

		lc.addChildToPos(arg_34_0, var_34_6, var_34_0)

		var_34_0.y = lc.bottom(var_34_6) - 20
	end

	local var_34_7 = arg_34_0:createReward(var_34_2)

	if var_34_7 then
		var_34_0.y = var_34_0.y - lc.h(var_34_7) / 2

		lc.addChildToPos(arg_34_0, var_34_7, var_34_0)
	end

	arg_34_0:createButton()
end

function var_0_0.createDarkResult(arg_35_0, arg_35_1)
	local var_35_0 = 335
	local var_35_1 = lc.createSprite("res/jpg/dark_result_bg.jpg")

	lc.addChildToCenter(arg_35_0, var_35_1)

	local var_35_2 = lc.createSprite("win_lose_bg")

	var_35_2:setScale(arg_35_1._resultType == Data.BattleResult.win and 1 or -1, 80 / lc.h(var_35_2))
	lc.addChildToPos(arg_35_0, var_35_2, cc.p(ClientView.SCR_CW, ClientView.SCR_H - 100))

	local var_35_3 = lc.createSprite("img_vs")

	lc.addChildToPos(arg_35_0, var_35_3, cc.p(ClientView.SCR_CW, 545))

	local var_35_4 = lc.createSprite(arg_35_1._resultType == Data.BattleResult.win and "dark_win" or arg_35_1._resultType == Data.BattleResult.lose and "dark_lose" or "dark_draw")
	local var_35_5 = lc.createSprite(arg_35_1._resultType == Data.BattleResult.win and "dark_lose" or arg_35_1._resultType == Data.BattleResult.lose and "dark_win" or "dark_draw")
	local var_35_6 = cc.p(ClientView.SCR_CW / 2, lc.y(var_35_2))
	local var_35_7 = cc.p(ClientView.SCR_W * 3 / 4, lc.y(var_35_2))

	lc.addChildToPos(arg_35_0, var_35_4, var_35_6)
	lc.addChildToPos(arg_35_0, var_35_5, var_35_7)

	local var_35_8 = arg_35_1._winScore
	local var_35_9 = arg_35_1._loseScore
	local var_35_10 = ClientView.createTTF(var_35_8, ClientView.FontSize.B1, ClientView.COLOR_TEXT_WHITE)
	local var_35_11 = ClientView.createTTF(var_35_9, ClientView.FontSize.B1, ClientView.COLOR_TEXT_WHITE)

	var_35_10:setAnchorPoint(1, 0.5)
	var_35_11:setAnchorPoint(0, 0.5)
	lc.addChildToPos(arg_35_0, var_35_10, cc.p(ClientView.SCR_CW - 50, lc.y(var_35_2)))
	lc.addChildToPos(arg_35_0, var_35_11, cc.p(ClientView.SCR_CW + 50, lc.y(var_35_2)))

	local var_35_12 = lc.createSprite({
		_name = "room_left_bg",
		_crect = cc.rect(10, 10, 1, 1)
	})

	var_35_12:setContentSize(cc.size(lc.cw(arg_35_0) - 20, lc.h(var_35_12)))
	var_35_12:setAnchorPoint(0.5, 0.5)

	local var_35_13 = UserWidget.create(arg_35_1._player, bor(UserWidget.Flag.LEVEL_NAME, UserWidget.Flag.UNION, UserWidget.Flag.REGION), 1.2)

	arg_35_0:adjustUserWidget(var_35_13)
	lc.addChildToPos(var_35_12, var_35_13, cc.p(lc.cw(var_35_12) - 10, lc.ch(var_35_12) - 10))
	lc.addChildToPos(arg_35_0, var_35_12, cc.p(lc.cw(var_35_12), var_35_0 + lc.ch(var_35_12)))

	local var_35_14 = lc.createNode()

	lc.addChildToPos(var_35_12, var_35_14, cc.p(lc.cw(var_35_12), lc.h(var_35_12) - 25))

	var_35_13._jobNode = var_35_14

	local var_35_15 = lc.createSprite({
		_name = "room_right_bg",
		_crect = cc.rect(110, 10, 1, 1)
	})

	var_35_15:setContentSize(cc.size(lc.cw(arg_35_0) - 20, lc.h(var_35_15)))
	var_35_15:setAnchorPoint(0.5, 0.5)

	local var_35_16 = UserWidget.create(arg_35_1._opponent, bor(UserWidget.Flag.LEVEL_NAME, UserWidget.Flag.UNION, UserWidget.Flag.REGION), 1.2)

	arg_35_0:adjustUserWidget(var_35_16, true)
	lc.addChildToPos(var_35_15, var_35_16, cc.p(lc.cw(var_35_15) + 10, lc.ch(var_35_15) - 10))
	lc.addChildToPos(arg_35_0, var_35_15, cc.p(lc.w(arg_35_0) - lc.cw(var_35_15), var_35_0 + lc.ch(var_35_15)))

	local var_35_17 = lc.createNode()

	lc.addChildToPos(var_35_15, var_35_17, cc.p(lc.cw(var_35_15), lc.h(var_35_15) - 25))

	var_35_16._jobNode = var_35_17

	local var_35_18 = lc.createSprite({
		_name = "group_avatars_bg",
		_crect = cc.rect(1, 1, 2, 2),
		_size = cc.size(ClientView.SCR_W, 210)
	})
	local var_35_19 = arg_35_0:createResource(arg_35_1, 0)

	lc.addChildToPos(var_35_18, var_35_19, cc.p(ClientView.SCR_CW, 160))
	lc.addChildToPos(arg_35_0, var_35_18, cc.p(ClientView.SCR_CW, var_35_0 - 115))

	if not P._playerFindDark:isDarkFinished() then
		local var_35_20 = string.format(Str(STR.WAIT_FOR_NEXT_BATTLE), P._playerFindDark._inning + 1)
		local var_35_21 = ClientView.createTTF(var_35_20, ClientView.FontSize.M1, ClientView.COLOR_TEXT_WHITE)

		var_35_21:runAction(lc.rep(lc.sequence(1, function()
			var_35_21:setString(var_35_20 .. ".")
		end, 1, function()
			var_35_21:setString(var_35_20 .. "..")
		end, 1, function()
			var_35_21:setString(var_35_20 .. "...")
		end)))
		lc.addChildToCenter(var_35_18, var_35_21)
		arg_35_0:runAction(lc.sequence(3, function()
			P._playerFindDark:find()
		end))
	end

	local var_35_22 = lc.createNode()

	lc.addChildToPos(var_35_18, var_35_22, cc.p(ClientView.SCR_CW, 50))

	local var_35_23 = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_0._rewardItems) do
		local var_35_24 = IconWidget.create(iter_35_1, IconWidget.DisplayFlag.ITEM_NO_NAME)

		table.insert(var_35_23, var_35_24)
	end

	lc.addNodesToCenter(var_35_22, var_35_23, 10)
	arg_35_0:createButton()
end

function var_0_0.adjustUserWidget(arg_40_0, arg_40_1, arg_40_2)
	arg_40_1._nameArea._level:setVisible(true)
	arg_40_1._nameArea:setPosition(cc.p(lc.right(arg_40_1._frame) - 5, lc.y(arg_40_1._frame)))
	arg_40_1._unionArea:setPosition(cc.p(lc.right(arg_40_1._frame) + lc.cw(arg_40_1._unionArea) + 5, lc.y(arg_40_1._frame) - lc.ch(arg_40_1._unionArea) - 10))
	arg_40_1._unionArea._name:setColor(ClientView.COLOR_TEXT_WHITE)
	arg_40_1._regionArea:setPositionY(lc.bottom(arg_40_1._frame) - 20)
	arg_40_1._regionArea:setColor(ClientView.COLOR_TEXT_WHITE)

	if arg_40_2 then
		arg_40_1:setScaleX(-arg_40_1:getScaleX())
		arg_40_1._frame:setScaleX(-arg_40_1._frame:getScaleX())
		arg_40_1._nameArea._name:setScaleX(-arg_40_1._nameArea._name:getScaleX())
		arg_40_1._nameArea._name:setAnchorPoint(1, 0.5)
		arg_40_1._nameArea._level._level:setScaleX(-arg_40_1._nameArea._level._level:getScaleX())
		arg_40_1._unionArea._name:setScaleX(-arg_40_1._unionArea._name:getScaleX())
		arg_40_1._unionArea._name:setAnchorPoint(1, 0.5)
		arg_40_1._unionArea._word:setScaleX(-arg_40_1._unionArea._word:getScaleX())
		arg_40_1._regionArea:setScaleX(-arg_40_1._regionArea:getScaleX())
		arg_40_1._regionArea:setAnchorPoint(1, 0)
	end
end

function var_0_0.onButtonEvent(arg_41_0, arg_41_1)
	if arg_41_1 == arg_41_0._pBtnTroop then
		arg_41_0._battleUi:exitScene(ClientData.SceneId.manage_troop)
	elseif arg_41_1 == arg_41_0._pBtnTavern then
		arg_41_0._battleUi:exitScene(ClientData.SceneId.tavern)
	elseif arg_41_1 == arg_41_0._pBtnExit then
		arg_41_0._battleUi:hideTip()
		arg_41_0._battleUi:tryExitScene()
		arg_41_0:hide()
	elseif arg_41_1 == arg_41_0._pBtnRetry then
		if arg_41_0._isGrainEnough then
			arg_41_0._battleUi:retry()
		else
			ToastManager.push(Str(STR.NOT_ENOUGH_GRAIN))
		end
	elseif arg_41_1 == arg_41_0._pBtnReplay then
		arg_41_0._battleUi:replay()
	elseif arg_41_1 == arg_41_0._pBtnShare then
		arg_41_0._battleUi:showShare(arg_41_0._result._log._id)
	elseif arg_41_1 == arg_41_0._pBtnRetreat then
		require("Dialog").showDialog(Str(STR.DARK_BATTLE_WARNING), function()
			P._playerFindDark:retreat()
			ClientView.getActiveIndicator():show(Str(STR.WAIT_BATTLE_RESULT))
		end)
	end
end

return var_0_0
