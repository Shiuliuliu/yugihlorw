local var_0_0 = class("CardSprite", function()
	return ccui.Widget:create()
end)

CardSprite = var_0_0
var_0_0.EVENT = "CARD_SPRITE_EVENT"
var_0_0.Status = {
	show = 8,
	info = 6,
	back = 2,
	dead = 4,
	large = 5,
	fight = 3,
	field = 9,
	cover = 7,
	normal = 1
}
var_0_0.TouchStatus = {
	grabbed = 2,
	moved = 3,
	ungrabbed = 1
}
var_0_0.ZOrder = {
	bottom_effect = -1,
	effect = 1,
	shadow = -2,
	skill_label = 2,
	card = 0,
	label = 1,
	efc = 0
}
var_0_0.Scale = {
	show = 0.75,
	hd = 1,
	normal_small = 0.3,
	grave = 0.42,
	cover = 1,
	normal = 0.42
}
var_0_0.EventType = {
	show_rare_list = 15,
	hide_card_info = 13,
	show_grave_list = 14,
	show_card_info = 12,
	show_hand_list = 16
}
var_0_0.TouchCardType = {
	need_show_info = 2,
	self_hand_card = 1,
	grave_card = 6,
	board_card = 4,
	rare_card = 7,
	ground_card = 5
}

local var_0_1 = 1001

function var_0_0.runAction(arg_2_0, arg_2_1)
	local function var_2_0()
		if arg_2_0._card._status == BattleData.CardStatus.hand then
			local var_3_0, var_3_1 = arg_2_0._ownerUi:calHandCardPosAndRot(arg_2_0)

			arg_2_0:setPosition(var_3_0)
			arg_2_0:setRotation3D(var_3_1)
		elseif arg_2_0._card._status == BattleData.CardStatus.board then
			local var_3_2 = arg_2_0._ownerUi:calBoardCardPos(arg_2_0)

			arg_2_0:setPosition(var_3_2)
		end
	end

	if arg_2_1._dontFixPos then
		cc.Node.runAction(arg_2_0, arg_2_1)
	else
		cc.Node.runAction(arg_2_0, lc.sequence(arg_2_1, lc.call(var_2_0)))
	end
end

function var_0_0.efcShieldBegin(arg_4_0, arg_4_1)
	if arg_4_1 and (string.find(arg_4_1, "Oppo") or string.find(arg_4_1, "Destroy")) then
		arg_4_0._statusEfc = arg_4_0._statusEfc or {}
		arg_4_0._statusEfc[arg_4_1] = false
		return
	end
	if arg_4_0._statusEfc[arg_4_1] ~= nil then
		return
	end

	local var_4_0 = cc.Sprite:createWithSpriteFrameName("efc_hudun")

	var_4_0:setOpacity(0)
	var_4_0:runAction(cc.FadeIn:create(0.4))

	if arg_4_0._pEffectArea then
		var_4_0:runAction(cc.Repeat:create(lc.sequence(lc.scaleTo(1, 0.7), lc.scaleTo(1, 0.8)), -1))
		lc.addChildToPos(arg_4_0._pEffectArea, var_4_0, cc.p(lc.cw(arg_4_0._pEffectArea), lc.ch(arg_4_0._pEffectArea) - 10))
	else
		var_4_0:runAction(cc.Repeat:create(lc.sequence(lc.scaleTo(1, 1.3), lc.scaleTo(1, 1.4)), -1))
		lc.addChildToPos(arg_4_0, var_4_0, cc.p(lc.w(arg_4_0) / 2, lc.h(arg_4_0) / 2 + 80))
	end

	if arg_4_0._scene and arg_4_0._scene.seenByCamera3D then
		arg_4_0._scene:seenByCamera3D(var_4_0)
	elseif var_4_0.setCameraMask then
		var_4_0:setCameraMask(ClientData and ClientData.CAMERA_3D_FLAG or 2)
	end
	arg_4_0._battleUi:createParticle(arg_4_1 == "shieldStone" and "par_hd3" or "par_hd2", cc.p(lc.w(var_4_0) / 2, lc.h(var_4_0) / 2), var_4_0, true, 0)

	arg_4_0._statusEfc[arg_4_1] = var_4_0
end

function var_0_0.efcShieldEnd(arg_5_0, arg_5_1)
	if arg_5_0._statusEfc[arg_5_1] == nil then
		return
	end

	local var_5_0 = arg_5_0._statusEfc[arg_5_1]

	arg_5_0._statusEfc[arg_5_1] = nil

	var_5_0:runAction(lc.sequence(lc.fadeOut(0.5), lc.remove()))
end

function var_0_0.efcShieldRemove(arg_6_0, arg_6_1)
	if arg_6_0._statusEfc[arg_6_1] == nil then
		return
	end

	arg_6_0._statusEfc[arg_6_1]:removeFromParent()

	arg_6_0._statusEfc[arg_6_1] = nil
end

function var_0_0.efcShieldReload(arg_7_0, arg_7_1)
	arg_7_0:efcShieldRemove(arg_7_1)
	arg_7_0:efcShieldBegin(arg_7_1)
end

function var_0_0.efcMaskBegin(arg_8_0, arg_8_1)
	return
end

function var_0_0.efcMaskEnd(arg_9_0, arg_9_1)
	return
end

function var_0_0.efcMaskRemove(arg_10_0, arg_10_1)
	return
end

function var_0_0.efcMaskReload(arg_11_0, arg_11_1)
	return
end

function var_0_0.efcMagicMarkBegin(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._card

	if var_12_0._type == Data.CardType.magic or var_12_0._type == Data.CardType.trap then
		return var_0_0.efcIconMarkBegin(arg_12_0, arg_12_1)
	end

	local var_12_1 = var_12_0:getBuffValue(true, arg_12_1 == "magicMark" and BattleData.PositiveType.magicMark or arg_12_1 == "roundMark" and BattleData.PositiveType.roundMark or arg_12_1 == "dinosaurMark" and BattleData.PositiveType.dinosaurMark or arg_12_1 == "sugarMark" and BattleData.PositiveType.sugarMark or arg_12_1 == "deathMark" and BattleData.PositiveType.deathMark or arg_12_1 == "satelliteMark" and BattleData.PositiveType.satelliteMark or arg_12_1 == "oceanMark" and BattleData.PositiveType.oceanMark or arg_12_1 == "snowMark" and BattleData.PositiveType.snowMark or arg_12_1 == "boxMark" and BattleData.PositiveType.boxMark or arg_12_1 == "stormMark" and BattleData.PositiveType.stormMark or arg_12_1 == "shieldMark" and BattleData.PositiveType.shieldMark or arg_12_1 == "phoenixMark" and BattleData.PositiveType.phoenixMark or arg_12_1 == "cjMark" and BattleData.PositiveType.cjMark or arg_12_1 == "techMark" and BattleData.PositiveType.techMark or arg_12_1 == "syncMark" and BattleData.PositiveType.syncMark or arg_12_1 == "sunFlowerMark" and BattleData.PositiveType.sunFlowerMark or arg_12_1 == "featherMark" and BattleData.PositiveType.featherMark or arg_12_1 == "weedingMark" and BattleData.PositiveType.weedingMark or arg_12_1 == "revolverMark" and BattleData.PositiveType.revolverMark or arg_12_1 == "plantMark" and BattleData.PositiveType.plantMark or arg_12_1 == "dMark" and BattleData.PositiveType.dMark or arg_12_1 == "ironMark" and BattleData.PositiveType.ironMark or arg_12_1 == "xyzMark" and BattleData.PositiveType.xyzMark or arg_12_1 == "puppetMark" and BattleData.PositiveType.puppetMark or arg_12_1 == "fateMark" and BattleData.PositiveType.fateMark or arg_12_1 == "potMark" and BattleData.PositiveType.potMark or arg_12_1 == "ylyMark" and BattleData.PositiveType.ylyMark or arg_12_1 == "sideEffectMark" and BattleData.PositiveType.sideEffectMark or arg_12_1 == "lineMark" and BattleData.PositiveType.lineMark or arg_12_1 == "universeMark" and BattleData.PositiveType.universeMark or arg_12_1 == "hsjMark" and BattleData.PositiveType.hsjMark or arg_12_1 == "bigSunMark" and BattleData.PositiveType.bigSunMark or arg_12_1 == "digMark" and BattleData.PositiveType.digMark or arg_12_1 == "allyMark" and BattleData.PositiveType.allyMark or arg_12_1 == "ddMark" and BattleData.PositiveType.ddMark or arg_12_1 == "samuraiMark" and BattleData.PositiveType.samuraiMark or arg_12_1 == "sacriMark" and BattleData.PositiveType.digMark or arg_12_1 == "fireStarMark" and BattleData.PositiveType.fireStarMark or arg_12_1 == "koiMark" and BattleData.PositiveType.koiMark or arg_12_1 == "godMark" and BattleData.PositiveType.godMark or arg_12_1 == "summonMark" and BattleData.PositiveType.summonMark or arg_12_1 == "dessertMark" and BattleData.PositiveType.dessertMark or arg_12_1 == "yiguaiMark" and BattleData.PositiveType.yiguaiMark or arg_12_1 == "crystalMark" and BattleData.PositiveType.crystalMark or arg_12_1 == "magicCardMark" and BattleData.PositiveType.magicCardMark or arg_12_1 == "trapCardMark" and BattleData.PositiveType.trapCardMark or arg_12_1 == "guangboMark" and BattleData.PositiveType.guangboMark or arg_12_1 == "yingyiMark" and BattleData.PositiveType.yingyiMark or arg_12_1 == "bianMark" and BattleData.PositiveType.bianMark or arg_12_1 == "sixFlowerMark" and BattleData.PositiveType.sixFlowerMark or arg_12_1 == "huanmoMark" and BattleData.PositiveType.huanmoMark or arg_12_1 == "gunMark" and BattleData.PositiveType.gunMark or arg_12_1 == "bjjMark" and BattleData.PositiveType.bjjMark or arg_12_1 == "newLiveMark" and BattleData.PositiveType.newLiveMark or BattleData.PositiveType.deedMark)

	if arg_12_0._statusEfc[arg_12_1] == nil then
		local var_12_2 = cc.Node:create()

		lc.addChildToCenter(arg_12_0._pEffectArea, var_12_2)
		arg_12_0._scene:seenByCamera3D(var_12_2)

		arg_12_0._statusEfc[arg_12_1] = var_12_2

		local var_12_3 = arg_12_0._ownerUi:efcDragonBones2(arg_12_1 == "magicMark" and "biaoji" or arg_12_1 == "roundMark" and "biaoji3" or arg_12_1 == "dinosaurMark" and "biaoji2" or arg_12_1 == "sugarMark" and "biaoji4" or arg_12_1 == "deathMark" and "biaoji5" or arg_12_1 == "snowMark" and "biaoji6" or arg_12_1 == "satelliteMark" and "biaoji7" or arg_12_1 == "oceanMark" and "biaoji9" or "biaoji8", "start", 1, false)

		lc.addChildToPos(var_12_2, var_12_3, cc.p(arg_12_1 == "trapCardMark" and -10 or -30, -70))
		arg_12_0._scene:seenByCamera3D(var_12_3)

		local var_12_4 = var_12_3:getAnimationDuration("start")

		var_12_3:runAction(lc.sequence(var_12_4, function()
			if var_12_3 ~= nil then
				var_12_3:gotoAndPlay("cycle")
			end
		end))

		var_12_2._bones = var_12_3

		local var_12_5 = ClientView.createBMFont(ClientView.BMFont.huali_26, var_12_1)

		var_12_5:setScale(0.7)
		lc.addChildToPos(var_12_2, var_12_5, cc.p(var_12_3:getPosition()))
		arg_12_0._scene:seenByCamera3D(var_12_5)

		var_12_2._label = var_12_5
	end

	arg_12_0._statusEfc[arg_12_1]._label:setString(var_12_1)
end

function var_0_0.efcMagicMarkEnd(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._card

	if var_14_0._type == Data.CardType.magic or var_14_0._type == Data.CardType.trap then
		return var_0_0.efcIconMarkEnd(arg_14_0, arg_14_1)
	end

	if arg_14_0._statusEfc[arg_14_1] == nil then
		return
	end

	local var_14_1 = arg_14_0._statusEfc[arg_14_1]

	arg_14_0._statusEfc[arg_14_1] = nil

	local var_14_2 = var_14_1._bones

	var_14_2:gotoAndPlay("end")

	local var_14_3 = var_14_2:getAnimationDuration("end")

	var_14_2:runAction(lc.sequence(var_14_3, lc.remove(), function()
		if i == count then
			var_14_1:removeFromParent()
		end
	end))
end

function var_0_0.efcMagicMarkRemove(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._card

	if var_16_0._type == Data.CardType.magic or var_16_0._type == Data.CardType.trap then
		return var_0_0.efcIconMarkRemove(arg_16_0, arg_16_1)
	end

	if arg_16_0._statusEfc[arg_16_1] == nil then
		return
	end

	arg_16_0._statusEfc[arg_16_1]:removeFromParent()

	arg_16_0._statusEfc[arg_16_1] = nil
end

function var_0_0.efcMagicMarkReload(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._card

	if var_17_0._type == Data.CardType.magic or var_17_0._type == Data.CardType.trap then
		return var_0_0.efcIconMarkReload(arg_17_0, arg_17_1)
	end

	arg_17_0:efcMagicMarkRemove(arg_17_1)
	arg_17_0:efcMagicMarkBegin(arg_17_1)
end

function var_0_0.efcIconMarkBegin(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._card
	local var_18_1 = 0

	if var_18_0:hasSkillFast(4086) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.pumpkinMark)
	elseif var_18_0:hasSkills({
		5137,
		7133,
		7137,
		7205,
		7241,
		8022
	}) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.magicMark)
	elseif var_18_0:hasSkillFast(4138) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.sugarMark2)
	elseif var_18_0:hasSkillFast(4166) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.wasteMark)
	elseif var_18_0:hasSkillFast(4303) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.soulMark)
	elseif var_18_0:hasSkillFast(7096) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.roundMark)
	elseif var_18_0:hasSkills({
		7173,
		7174,
		7176,
		7379,
		8015
	}) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.samuraiMark)
	elseif var_18_0:hasSkillFast(8050) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.foreverFireMark)
	elseif var_18_0:hasSkillFast(7215) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.forestMark)
	elseif var_18_0:hasSkillFast(7223) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.resonateMark)
	elseif var_18_0:hasSkills({
		7226,
		7311
	}) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.gustoMark)
	elseif var_18_0:hasSkillFast(4390) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.weddingMark)
	elseif var_18_0:hasSkillFast(7238) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.plantMark)
	elseif var_18_0:hasSkillFast(7255) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.dMark)
	elseif var_18_0:hasSkillFast(7259) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.ironMark)
	elseif var_18_0:hasSkills({
		5306,
		7298,
		7325
	}) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.puppetMark)
	elseif var_18_0:hasSkillFast(7301) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.potMark)
	elseif var_18_0:hasSkillFast(4570) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.ylyMark)
	elseif var_18_0:hasSkillFast(8076) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.sideEffectMark)
	elseif var_18_0:hasSkillFast(5369) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.universeMark)
	elseif var_18_0:hasSkillFast(4688) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.hsjMark)
	elseif var_18_0:hasSkills({
		4702,
		7345
	}) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.bigSunMark)
	elseif var_18_0:hasSkillFast(4726) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.digMark)
	elseif var_18_0:hasSkillFast(5384) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.allyMark)
	elseif var_18_0:hasSkillFast(5392) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.ddMark)
	elseif var_18_0:hasSkillFast(4778) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.sacriMark)
	elseif var_18_0:hasSkills({
		7400,
		8104
	}) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.fireStarMark)
	elseif var_18_0:hasSkillFast(7425) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.godMark)
	elseif var_18_0:hasSkillFast(7435) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.summonMark)
	elseif var_18_0:hasSkillFast(5471) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.dessertMark)
	elseif var_18_0:hasSkillFast(7528) then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.yingyiMark)
	elseif arg_18_1 == "gunMark" then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.gunMark)
	elseif arg_18_1 == "newLiveMark" then
		var_18_1 = var_18_0:getBuffValue(true, BattleData.PositiveType.newLiveMark)
	end

	if var_18_1 > 0 then
		if arg_18_0._statusEfc[arg_18_1] == nil then
			local var_18_2 = ClientView.createBMFont(ClientView.BMFont.huali_32, var_18_1)

			var_18_2:setScale(1.5)

			if arg_18_0._pFrameIcon then
				lc.addChildToCenter(arg_18_0._pFrameIcon, var_18_2)
			else
				lc.addChildToCenter(arg_18_0, var_18_2)
			end

			arg_18_0._statusEfc[arg_18_1] = var_18_2
		end

		local var_18_3 = arg_18_0._statusEfc[arg_18_1]

		if var_18_3 then
			var_18_3:setString(var_18_1)
			arg_18_0._scene:seenByCamera3D(var_18_3)
		end
	end
end

function var_0_0.efcIconMarkEnd(arg_19_0, arg_19_1)
	if arg_19_0._statusEfc[arg_19_1] == nil then
		return
	end

	local var_19_0 = arg_19_0._statusEfc[arg_19_1]

	arg_19_0._statusEfc[arg_19_1] = nil

	var_19_0:removeFromParent()
end

function var_0_0.efcIconMarkRemove(arg_20_0, arg_20_1)
	if arg_20_0._statusEfc[arg_20_1] == nil then
		return
	end

	arg_20_0._statusEfc[arg_20_1]:removeFromParent()

	arg_20_0._statusEfc[arg_20_1] = nil
end

function var_0_0.efcIconMarkReload(arg_21_0, arg_21_1)
	arg_21_0:efcIconMarkRemove(arg_21_1)
	arg_21_0:efcIconMarkBegin(arg_21_1)
end

function var_0_0.efcXYZMarkBegin(arg_22_0, arg_22_1)
	if not arg_22_0._card then return end
	local var_22_0 = arg_22_0._card:getBuffValue(true, BattleData.PositiveType.xyzMark)

	if arg_22_0._xyzMaterialCount == var_22_0 and arg_22_0._statusEfc and arg_22_0._statusEfc[arg_22_1] ~= nil then
		return
	end

	if arg_22_0._statusEfc and arg_22_0._statusEfc[arg_22_1] ~= nil then
		var_0_0.efcXYZMarkEnd(arg_22_0, arg_22_1)
	end

	if var_22_0 <= 0 then
		arg_22_0._xyzMaterialCount = 0
		arg_22_0._statusEfc = arg_22_0._statusEfc or {}
		arg_22_0._statusEfc[arg_22_1] = false
		return
	end
	if var_22_0 > 0 and (not arg_22_0._statusEfc or arg_22_0._statusEfc[arg_22_1] == nil) then
		arg_22_0._xyzMaterialCount = var_22_0
		local var_22_1 = arg_22_0._ownerUi and arg_22_0._ownerUi:efcDragonBones2("chaoliangsucai" .. math.min(3, var_22_0), "effect", 0.5, false)

		if var_22_1 then
			lc.addChildToPos(arg_22_0._pEffectArea, var_22_1, cc.p(0, 0))
			if arg_22_0._scene and arg_22_0._scene.seenByCamera3D then
				arg_22_0._scene:seenByCamera3D(var_22_1)
			end

			arg_22_0._statusEfc = arg_22_0._statusEfc or {}
			arg_22_0._statusEfc[arg_22_1] = var_22_1
		end
	end
end

function var_0_0.efcXYZMarkEnd(arg_23_0, arg_23_1)
	if not arg_23_0._statusEfc or arg_23_0._statusEfc[arg_23_1] == nil then
		return
	end

	local var_23_0 = arg_23_0._statusEfc[arg_23_1]

	arg_23_0._statusEfc[arg_23_1] = nil
	arg_23_0._xyzMaterialCount = nil

	if var_23_0 then
		if var_23_0.stop then
			var_23_0:stop()
		end
		var_23_0:removeFromParent()
	end
end

function var_0_0.efcXYZMarkRemove(arg_24_0, arg_24_1)
	if not arg_24_0._statusEfc or arg_24_0._statusEfc[arg_24_1] == nil then
		return
	end

	local var_24_0 = arg_24_0._statusEfc[arg_24_1]

	arg_24_0._statusEfc[arg_24_1] = nil
	arg_24_0._xyzMaterialCount = nil

	if var_24_0 then
		if var_24_0.stop then
			var_24_0:stop()
		end
		var_24_0:removeFromParent()
	end
end

function var_0_0.efcXYZMarkReload(arg_25_0, arg_25_1)
	arg_25_0:efcXYZMarkRemove(arg_25_1)
	arg_25_0:efcXYZMarkBegin(arg_25_1)
end

function var_0_0.efcCoverSnowBegin(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._card
	local var_26_1 = var_26_0._owner
	local var_26_2 = var_26_0:getBuffValue(false, BattleData.NegativeType.coverSnow)
	local var_26_3 = arg_26_0._statusEfc[arg_26_1]

	if var_26_3 == nil then
		var_26_3 = lc.createSprite("efc_jx_" .. (var_26_2 == 1 and 1 or 2))

		var_26_3:setOpacity(0)
		var_26_3:runAction(lc.fadeIn(0.5))
		lc.addChildToPos(arg_26_0._pEffectArea, var_26_3, cc.p(lc.w(arg_26_0._pEffectArea) / 2 - 12, lc.h(arg_26_0._pEffectArea) / 2))

		arg_26_0._statusEfc[arg_26_1] = var_26_3
	else
		var_26_3:setSpriteFrame("efc_jx_" .. (var_26_2 == 1 and 1 or 2))
	end
end

function var_0_0.efcCoverSnowEnd(arg_27_0, arg_27_1)
	if arg_27_0._statusEfc[arg_27_1] == nil then
		return
	end

	local var_27_0 = arg_27_0._statusEfc[arg_27_1]

	arg_27_0._statusEfc[arg_27_1] = nil

	var_27_0:runAction(lc.sequence(lc.fadeOut(0.5), lc.remove()))
end

function var_0_0.efcCoverSnowRemove(arg_28_0, arg_28_1)
	if arg_28_0._statusEfc[arg_28_1] == nil then
		return
	end

	arg_28_0._statusEfc[arg_28_1]:removeFromParent()

	arg_28_0._statusEfc[arg_28_1] = nil
end

function var_0_0.efcCoverSnowReload(arg_29_0, arg_29_1)
	arg_29_0:efcCoverSnowRemove(arg_29_1)
	arg_29_0:efcCoverSnowBegin(arg_29_1)
end

function var_0_0.efcDefendPostureBegin(arg_30_0, arg_30_1)
	if arg_30_0._statusEfc[arg_30_1] == nil then
		local var_30_0 = cc.Node:create()

		lc.addChildToCenter(arg_30_0._pEffectArea, var_30_0)

		arg_30_0._statusEfc[arg_30_1] = var_30_0
	end

	arg_30_0:updateDefendPosture(true)
end

function var_0_0.efcDefendPostureEnd(arg_31_0, arg_31_1)
	if arg_31_0._statusEfc[arg_31_1] == nil then
		return
	end

	local var_31_0 = arg_31_0._statusEfc[arg_31_1]

	arg_31_0._statusEfc[arg_31_1] = nil

	arg_31_0:updateDefendPosture(true)
end

function var_0_0.efcDefendPostureRemove(arg_32_0, arg_32_1)
	if arg_32_0._statusEfc[arg_32_1] == nil then
		return
	end

	arg_32_0._statusEfc[arg_32_1]:removeFromParent()

	arg_32_0._statusEfc[arg_32_1] = nil

	arg_32_0:updateDefendPosture(false)
end

function var_0_0.efcDefendPostureReload(arg_33_0, arg_33_1)
	arg_33_0:efcDefendPostureRemove(arg_33_1)
	arg_33_0:efcDefendPostureBegin(arg_33_1)
end

function var_0_0.efcTrapVisibleBegin(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._card

	if arg_34_0._statusEfc[arg_34_1] == nil then
		local var_34_1 = lc.createSprite("efc_trap_visible")

		var_34_1:runAction(lc.rep(lc.sequence(lc.spawn(lc.fadeOut(0.5), lc.scaleTo(0.5, 0.7)), lc.spawn(lc.fadeIn(0.5), lc.scaleTo(0.5, 1)))))
		lc.addChildToPos(arg_34_0, var_34_1, cc.p(lc.w(arg_34_0) / 2, lc.h(arg_34_0) / 2), var_0_1)

		arg_34_0._statusEfc[arg_34_1] = var_34_1

		arg_34_0._scene:seenByCamera3D(var_34_1)
	end
end

function var_0_0.efcTrapVisibleEnd(arg_35_0, arg_35_1)
	if arg_35_0._statusEfc[arg_35_1] == nil then
		return
	end

	local var_35_0 = arg_35_0._statusEfc[arg_35_1]

	arg_35_0._statusEfc[arg_35_1] = nil

	var_35_0:runAction(lc.sequence(lc.fadeOut(0.5), lc.remove()))
end

function var_0_0.efcTrapVisibleRemove(arg_36_0, arg_36_1)
	if arg_36_0._statusEfc[arg_36_1] == nil then
		return
	end

	arg_36_0._statusEfc[arg_36_1]:removeFromParent()

	arg_36_0._statusEfc[arg_36_1] = nil
end

function var_0_0.efcTrapVisibleReload(arg_37_0, arg_37_1)
	arg_37_0:efcTrapVisibleRemove(arg_37_1)
	arg_37_0:efcTrapVisibleBegin(arg_37_1)
end

var_0_0.PositiveStatus = {
	{
		_name = "actionCraze",
		_contain = {
			BattleData.PositiveType.actionCraze
		},
		_descId = STR.BATTLE_CARD_ACTION_CRAZE,
		_particles = {
			{
				_isBottom = true,
				_name = "par_cfugj",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "craze",
		_contain = {
			BattleData.PositiveType.craze
		},
		_descId = STR.BATTLE_CARD_CRAZE,
		_particles = {
			{
				_isBottom = true,
				_name = "par_kuangre",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "siege",
		_contain = {
			BattleData.PositiveType.siege
		},
		_descId = STR.BATTLE_CARD_SIEGE,
		_particles = {
			{
				_isBottom = true,
				_name = "par_gongcheng",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "betray",
		_contain = {
			BattleData.PositiveType.betray
		},
		_descId = STR.BATTLE_CARD_BETRAY,
		_particles = {
			{
				_isBottom = true,
				_name = "par_daoge",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "irony",
		_contain = {
			BattleData.PositiveType.irony
		},
		_descId = STR.BATTLE_CARD_IRONY,
		_dragonBone = {
			_name = "cf",
			_isBottom = true,
			_scale = 0.6,
			_aniBegin = "begin",
			_aniEnd = "",
			_aniLoop = "loop",
			_pos = cc.p(0, 0)
		}
	},
	{
		_name = "invisible",
		_contain = {
			BattleData.PositiveType.invisible
		},
		_descId = STR.BATTLE_CARD_INVISIBLE,
		_dragonBone = {
			_name = "yinshen",
			_isBottom = false,
			_scale = 2.4,
			_aniBegin = "begin",
			_aniEnd = "end",
			_aniLoop = "loop",
			_pos = cc.p(0, -10)
		}
	},
	{
		_name = "magnetic",
		_contain = {
			BattleData.PositiveType.magnetic
		},
		_descId = STR.BATTLE_CARD_MAGNETIC,
		_particles = {
			{
				_isBottom = false,
				_name = "par_cxyl",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "guard",
		_contain = {
			BattleData.PositiveType.guard
		},
		_descId = STR.BATTLE_CARD_GUARD
	},
	{
		_name = "shieldHaloAttack",
		_contain = {
			BattleData.PositiveType.shieldHaloAttack
		},
		_descId = STR.BATTLE_CARD_SHIELD_EX_ATTACK,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldHaloMonster",
		_contain = {
			BattleData.PositiveType.shieldHaloMonster
		},
		_descId = STR.BATTLE_CARD_SHIELD_EX_MONSTER,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldHaloMagic",
		_contain = {
			BattleData.PositiveType.shieldHaloMagic
		},
		_descId = STR.BATTLE_CARD_SHIELD_EX_MAGIC,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldHaloTrap",
		_contain = {
			BattleData.PositiveType.shieldHaloTrap
		},
		_descId = STR.BATTLE_CARD_SHIELD_EX_TRAP,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldHaloHp",
		_contain = {
			BattleData.PositiveType.shieldHaloHp
		},
		_descId = STR.BATTLE_CARD_SHIELD_EX_DARK,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldAttack",
		_contain = {
			BattleData.PositiveType.shieldAttack
		},
		_descId = STR.BATTLE_CARD_SHIELD_ATTACK,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldMonster",
		_contain = {
			BattleData.PositiveType.shieldMonster
		},
		_descId = STR.BATTLE_CARD_SHIELD_MONSTER,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldMagic",
		_contain = {
			BattleData.PositiveType.shieldMagic
		},
		_descId = STR.BATTLE_CARD_SHIELD_MAGIC,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldTrap",
		_contain = {
			BattleData.PositiveType.shieldTrap
		},
		_descId = STR.BATTLE_CARD_SHIELD_TRAP,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldHp",
		_contain = {
			BattleData.PositiveType.shieldHp
		},
		_descId = STR.BATTLE_CARD_SHIELD_DARK,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldExAttack",
		_contain = {
			BattleData.PositiveType.shieldExAttack
		},
		_descId = STR.BATTLE_CARD_SHIELD_EX_ATTACK,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldExMonster",
		_contain = {
			BattleData.PositiveType.shieldExMonster
		},
		_descId = STR.BATTLE_CARD_SHIELD_EX_MONSTER,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldExMagic",
		_contain = {
			BattleData.PositiveType.shieldExMagic
		},
		_descId = STR.BATTLE_CARD_SHIELD_EX_MAGIC,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldExTrap",
		_contain = {
			BattleData.PositiveType.shieldExTrap
		},
		_descId = STR.BATTLE_CARD_SHIELD_EX_TRAP,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "shieldExHp",
		_contain = {
			BattleData.PositiveType.shieldExHp
		},
		_descId = STR.BATTLE_CARD_SHIELD_EX_DARK,
		_function = {
			_begin = var_0_0.efcShieldBegin,
			_end = var_0_0.efcShieldEnd,
			_remove = var_0_0.efcShieldRemove,
			_reload = var_0_0.efcShieldReload
		}
	},
	{
		_name = "mask",
		_contain = {
			BattleData.PositiveType.mask
		},
		_function = {
			_begin = var_0_0.efcMaskBegin,
			_end = var_0_0.efcMaskEnd,
			_remove = var_0_0.efcMaskRemove,
			_reload = var_0_0.efcMaskReload
		}
	},
	{
		_name = "spellMaster",
		_contain = {
			BattleData.PositiveType.spellMaster
		},
		_descId = STR.BATTLE_CARD_SPELLMASTER,
		_particles = {
			{
				_isBottom = true,
				_name = "par_hbxm1",
				_pos = cc.p(0, -20)
			},
			{
				_isBottom = true,
				_name = "par_hbxm2",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "spellMaster2",
		_contain = {
			BattleData.PositiveType.spellMaster2
		},
		_descId = STR.BATTLE_CARD_SPELLMASTER2
	},
	{
		_name = "spellMasterWu",
		_contain = {
			BattleData.PositiveType.spellMasterWu
		},
		_descId = STR.BATTLE_CARD_SPELLMASTER_LINK
	},
	{
		_name = "changeRandom",
		_contain = {
			BattleData.PositiveType.changeRandom
		},
		_descId = STR.BATTLE_CARD_CHANGE_RANDOM,
		_particles = {
			{
				_isBottom = true,
				_name = "yl_6039",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "poisonMaster",
		_contain = {
			BattleData.PositiveType.poisonMaster
		},
		_descId = STR.BATTLE_CARD_POISON_MASTER,
		_particles = {
			{
				_isBottom = true,
				_name = "yl_6039",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "ignoreNegative",
		_contain = {
			BattleData.PositiveType.ignoreNegative
		},
		_descId = STR.BATTLE_CARD_IGNORE_NEGATIVE,
		_particles = {
			{
				_isBottom = true,
				_name = "yl_6039",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "disableDyingSkill",
		_contain = {
			BattleData.PositiveType.disableDyingSkill
		},
		_descId = STR.BATTLE_CARD_DISABLE_DYING_SKILL,
		_particles = {
			{
				_isBottom = true,
				_name = "yl_6039",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "magicMark",
		_contain = {
			BattleData.PositiveType.magicMark
		},
		_descId = STR.BATTLE_CARD_MAGIC_MARK,
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "roundMark",
		_contain = {
			BattleData.PositiveType.roundMark
		},
		_descId = STR.BATTLE_CARD_ROUND_MARK,
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "defendPosture",
		_contain = {
			BattleData.PositiveType.defendPosture
		},
		_function = {
			_begin = var_0_0.efcDefendPostureBegin,
			_end = var_0_0.efcDefendPostureEnd,
			_remove = var_0_0.efcDefendPostureRemove,
			_reload = var_0_0.efcDefendPostureReload
		}
	},
	{
		_name = "pumpkinMark",
		_contain = {
			BattleData.PositiveType.pumpkinMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "dinosaurMark",
		_contain = {
			BattleData.PositiveType.dinosaurMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "sugarMark",
		_contain = {
			BattleData.PositiveType.sugarMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "sugarMark2",
		_contain = {
			BattleData.PositiveType.sugarMark2
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "deathMark",
		_contain = {
			BattleData.PositiveType.deathMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "satelliteMark",
		_contain = {
			BattleData.PositiveType.satelliteMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "oceanMark",
		_contain = {
			BattleData.PositiveType.oceanMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "snowMark",
		_contain = {
			BattleData.PositiveType.snowMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "wasteMark",
		_contain = {
			BattleData.PositiveType.wasteMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "boxMark",
		_contain = {
			BattleData.PositiveType.boxMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "stormMark",
		_contain = {
			BattleData.PositiveType.stormMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "shieldMark",
		_contain = {
			BattleData.PositiveType.shieldMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "samuraiMark",
		_contain = {
			BattleData.PositiveType.samuraiMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "phoenixMark",
		_contain = {
			BattleData.PositiveType.phoenixMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "soulMark",
		_contain = {
			BattleData.PositiveType.soulMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "foreverFireMark",
		_contain = {
			BattleData.PositiveType.foreverFireMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "cjMark",
		_contain = {
			BattleData.PositiveType.cjMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "forestMark",
		_contain = {
			BattleData.PositiveType.forestMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "techMark",
		_contain = {
			BattleData.PositiveType.techMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "syncMark",
		_contain = {
			BattleData.PositiveType.syncMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "resonateMark",
		_contain = {
			BattleData.PositiveType.resonateMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "gustoMark",
		_contain = {
			BattleData.PositiveType.gustoMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "sunFlowerMark",
		_contain = {
			BattleData.PositiveType.sunFlowerMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "deedMark",
		_contain = {
			BattleData.PositiveType.deedMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "featherMark",
		_contain = {
			BattleData.PositiveType.featherMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "weddingMark",
		_contain = {
			BattleData.PositiveType.weddingMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "revolverMark",
		_contain = {
			BattleData.PositiveType.revolverMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "plantMark",
		_contain = {
			BattleData.PositiveType.plantMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "dMark",
		_contain = {
			BattleData.PositiveType.dMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "ironMark",
		_contain = {
			BattleData.PositiveType.ironMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "xyzMark",
		_contain = {
			BattleData.PositiveType.xyzMark
		},
		_function = {
			_begin = var_0_0.efcXYZMarkBegin,
			_end = var_0_0.efcXYZMarkEnd,
			_remove = var_0_0.efcXYZMarkRemove,
			_reload = var_0_0.efcXYZMarkReload
		}
	},
	{
		_name = "puppetMark",
		_contain = {
			BattleData.PositiveType.puppetMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "fateMark",
		_contain = {
			BattleData.PositiveType.fateMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "potMark",
		_contain = {
			BattleData.PositiveType.potMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "ylyMark",
		_contain = {
			BattleData.PositiveType.ylyMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "sideEffectMark",
		_contain = {
			BattleData.PositiveType.sideEffectMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "lineMark",
		_contain = {
			BattleData.PositiveType.lineMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "universeMark",
		_contain = {
			BattleData.PositiveType.universeMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "hsjMark",
		_contain = {
			BattleData.PositiveType.hsjMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "bigSunMark",
		_contain = {
			BattleData.PositiveType.bigSunMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "digMark",
		_contain = {
			BattleData.PositiveType.digMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "allyMark",
		_contain = {
			BattleData.PositiveType.allyMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "ddMark",
		_contain = {
			BattleData.PositiveType.ddMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "sacriMark",
		_contain = {
			BattleData.PositiveType.sacriMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "fireStarMark",
		_contain = {
			BattleData.PositiveType.fireStarMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "koiMark",
		_contain = {
			BattleData.PositiveType.koiMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "godMark",
		_contain = {
			BattleData.PositiveType.godMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "summonMark",
		_contain = {
			BattleData.PositiveType.summonMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "dessertMark",
		_contain = {
			BattleData.PositiveType.dessertMark
		},
		_function = {
			_begin = var_0_0.efcIconMarkBegin,
			_end = var_0_0.efcIconMarkEnd,
			_remove = var_0_0.efcIconMarkRemove,
			_reload = var_0_0.efcIconMarkReload
		}
	},
	{
		_name = "yiguaiMark",
		_contain = {
			BattleData.PositiveType.yiguaiMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "crystalMark",
		_contain = {
			BattleData.PositiveType.crystalMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "magicCardMark",
		_contain = {
			BattleData.PositiveType.magicCardMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "trapCardMark",
		_contain = {
			BattleData.PositiveType.trapCardMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "guangboMark",
		_contain = {
			BattleData.PositiveType.guangboMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "yingyiMark",
		_contain = {
			BattleData.PositiveType.yingyiMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "bianMark",
		_contain = {
			BattleData.PositiveType.bianMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "sixFlowerMark",
		_contain = {
			BattleData.PositiveType.sixFlowerMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "huanmoMark",
		_contain = {
			BattleData.PositiveType.huanmoMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "gunMark",
		_contain = {
			BattleData.PositiveType.gunMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "bjjMark",
		_contain = {
			BattleData.PositiveType.bjjMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "newLiveMark",
		_contain = {
			BattleData.PositiveType.newLiveMark
		},
		_function = {
			_begin = var_0_0.efcMagicMarkBegin,
			_end = var_0_0.efcMagicMarkEnd,
			_remove = var_0_0.efcMagicMarkRemove,
			_reload = var_0_0.efcMagicMarkReload
		}
	},
	{
		_name = "lockAtk",
		_contain = {
			BattleData.PositiveType.lockAtk
		},
		_descId = STR.BATTLE_CARD_LOCK_ATK
	},
	{
		_name = "lockDef",
		_contain = {
			BattleData.PositiveType.lockDef
		},
		_descId = STR.BATTLE_CARD_LOCK_DEF
	},
	{
		_name = "mask2",
		_contain = {
			BattleData.PositiveType.mask2
		}
	},
	{
		_name = "extraStarHalo",
		_contain = {
			BattleData.PositiveType.extraStarHalo
		}
	},
	{
		_name = "extraStar",
		_contain = {
			BattleData.PositiveType.extraStar
		}
	},
	{
		_name = "disable3557",
		_contain = {
			BattleData.PositiveType.disable3557
		},
		_descId = STR.BATTLE_CARD_DISABLE3557
	},
	{
		_name = "shieldDestroy",
		_contain = {
			BattleData.PositiveType.shieldDestroy
		},
		_descId = STR.BATTLE_CARD_SHIELD_DESTROY
	},
	{
		_name = "shieldEffectDestroy",
		_contain = {
			BattleData.PositiveType.shieldEffectDestroy
		},
		_descId = STR.BATTLE_CARD_SHIELD_EFFECT_DESTROY
	},
	{
		_name = "shieldHaloDestroy",
		_contain = {
			BattleData.PositiveType.shieldHaloDestroy
		},
		_descId = STR.BATTLE_CARD_SHIELD_DESTROY
	},
	{
		_name = "shieldHaloEffectDestroy",
		_contain = {
			BattleData.PositiveType.shieldHaloEffectDestroy
		},
		_descId = STR.BATTLE_CARD_SHIELD_EFFECT_DESTROY
	},
	{
		_name = "shieldOppoMonster",
		_contain = {
			BattleData.PositiveType.shieldOppoMonster
		},
		_descId = STR.BATTLE_CARD_SHIELD_OPPO_MONSTER
	},
	{
		_name = "shieldOppoMagic",
		_contain = {
			BattleData.PositiveType.shieldOppoMagic
		},
		_descId = STR.BATTLE_CARD_SHIELD_OPPO_MAGIC
	},
	{
		_name = "shieldOppoTrap",
		_contain = {
			BattleData.PositiveType.shieldOppoTrap
		},
		_descId = STR.BATTLE_CARD_SHIELD_OPPO_TRAP
	},
	{
		_name = "shieldHaloOppoMonster",
		_contain = {
			BattleData.PositiveType.shieldHaloOppoMonster
		},
		_descId = STR.BATTLE_CARD_SHIELD_OPPO_MONSTER
	},
	{
		_name = "shieldHaloOppoMagic",
		_contain = {
			BattleData.PositiveType.shieldHaloOppoMagic
		},
		_descId = STR.BATTLE_CARD_SHIELD_OPPO_MAGIC
	},
	{
		_name = "shieldHaloOppoTrap",
		_contain = {
			BattleData.PositiveType.shieldHaloOppoTrap
		},
		_descId = STR.BATTLE_CARD_SHIELD_OPPO_TRAP
	}
}
var_0_0.NegativeStatus = {
	{
		_name = "atkFrozenHalo",
		_against = {
			6,
			7
		},
		_contain = {
			BattleData.NegativeType.atkFrozenHalo
		},
		_descId = STR.BATTLE_CARD_ATTACK_FROZEN,
		_dragonBone = {
			_name = "fengsuo",
			_isBottom = false,
			_scale = 0.4,
			_aniBegin = "begin",
			_aniEnd = "end",
			_aniLoop = "loop",
			_pos = cc.p(0, 0)
		}
	},
	{
		_name = "spellFrozen",
		_against = {
			5,
			6,
			7
		},
		_contain = {
			BattleData.NegativeType.spellSkillFrozen
		},
		_descId = STR.BATTLE_CARD_SPELL_FROZEN,
		_dragonBone = {
			_name = "jufeng1",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "",
			_aniEnd = "spellEnd",
			_aniLoop = "spellLoop",
			_pos = cc.p(0, -30)
		}
	},
	{
		_name = "haloFrozen",
		_against = {
			7
		},
		_contain = {
			BattleData.NegativeType.haloSkillFrozen
		},
		_descId = STR.BATTLE_CARD_HALO_FROZEN,
		_dragonBone = {
			_name = "jufeng1",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "",
			_aniEnd = "haloEnd",
			_aniLoop = "haloLoop",
			_pos = cc.p(0, -30)
		}
	},
	{
		_name = "atkFrozen",
		_against = {
			6,
			7
		},
		_contain = {
			BattleData.NegativeType.atkFrozen
		},
		_descId = STR.BATTLE_CARD_ATTACK_FROZEN,
		_dragonBone = {
			_name = "fengsuo",
			_isBottom = false,
			_scale = 0.4,
			_aniBegin = "begin",
			_aniEnd = "end",
			_aniLoop = "loop",
			_pos = cc.p(0, 0)
		}
	},
	{
		_name = "skillFrozen",
		_against = {
			6,
			7,
			9
		},
		_contain = BattleData.NEGATIVE_SKILL_FROZEN,
		_descId = STR.BATTLE_CARD_SKILL_FROZEN,
		_dragonBone = {
			_name = "jufeng1",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "",
			_aniEnd = "haloEnd",
			_aniLoop = "haloLoop",
			_pos = cc.p(0, -30)
		}
	},
	{
		_name = "actionFrozen",
		_against = {
			7
		},
		_contain = BattleData.NEGATIVE_ACTION_FROZEN,
		_descId = STR.BATTLE_CARD_ACTION_FROZEN,
		_dragonBone = {
			_name = "xianjing1",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "",
			_aniEnd = "end",
			_aniLoop = "loop",
			_pos = cc.p(0, -10)
		}
	},
	{
		_name = "allFrozen",
		_against = {},
		_contain = BattleData.NEGATIVE_FROZEN,
		_descId = STR.BATTLE_CARD_ALL_FROZEN,
		_dragonBone = {
			_name = "chenmo",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "begin",
			_aniEnd = "end",
			_aniLoop = "loop",
			_pos = cc.p(0, -10)
		}
	},
	{
		_name = "chaos",
		_against = {
			4,
			6,
			7
		},
		_contain = {
			BattleData.NegativeType.chaos
		},
		_descId = STR.BATTLE_CARD_CHAOS,
		_dragonBone = {
			_name = "leibao",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "",
			_aniEnd = "end",
			_aniLoop = "loop",
			_pos = cc.p(0, -10)
		}
	},
	{
		_name = "chaosFortress",
		_against = {
			4,
			6,
			7
		},
		_contain = {
			BattleData.NegativeType.chaosFortress
		},
		_dragonBone = {
			_name = "fanjian",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "begin",
			_aniEnd = "end",
			_aniLoop = "loop",
			_pos = cc.p(0, -10)
		}
	},
	{
		_name = "chaosMonster",
		_against = {
			4,
			6,
			7
		},
		_contain = {
			BattleData.NegativeType.chaosMonster
		},
		_dragonBone = {
			_name = "fanjian",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "begin",
			_aniEnd = "end",
			_aniLoop = "loop",
			_pos = cc.p(0, -10)
		}
	},
	{
		_name = "healFrozen",
		_against = {
			10
		},
		_contain = {
			BattleData.NegativeType.healFrozen
		},
		_descId = STR.BATTLE_CARD_HEAL_FROZEN,
		_dragonBone = {
			_name = "xinshang",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "begin",
			_aniEnd = "end",
			_aniLoop = "loop",
			_pos = cc.p(0, -10)
		}
	},
	{
		_name = "marked",
		_against = {},
		_contain = {
			BattleData.NegativeType.marked
		},
		_descId = STR.BATTLE_CARD_MARKED,
		_dragonBone = {
			_name = "biaoji",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "start",
			_aniEnd = "end",
			_aniLoop = "cycle",
			_pos = cc.p(0, -90)
		}
	},
	{
		_name = "defendFrozen",
		_against = {
			7
		},
		_contain = {
			BattleData.NegativeType.defendSkillFrozen
		},
		_descId = STR.BATTLE_CARD_DEFEND_FROZEN,
		_dragonBone = {
			_name = "wlfy",
			_isBottom = false,
			_scale = 2.4,
			_aniBegin = "pofang_1",
			_aniEnd = "",
			_aniLoop = "pofang_2",
			_pos = cc.p(0, -40)
		}
	},
	{
		_name = "drunk",
		_against = {
			4,
			6,
			7
		},
		_contain = {
			BattleData.NegativeType.drunk
		},
		_descId = STR.BATTLE_CARD_DRUNK,
		_particles = {
			{
				_isBottom = false,
				_name = "par_zuijiu1",
				_pos = cc.p(0, -20)
			},
			{
				_isBottom = false,
				_name = "par_zuijiu2",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "targeted",
		_against = {},
		_contain = {
			BattleData.NegativeType.targeted
		},
		_descId = STR.BATTLE_CARD_TARGETED,
		_dragonBone = {
			_name = "biaoji",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "biaoji_start",
			_aniEnd = "biaoji_end",
			_aniLoop = "biaoji_cycle",
			_pos = cc.p(0, -90)
		}
	},
	{
		_name = "mistrust",
		_against = {
			4,
			6,
			7
		},
		_contain = {
			BattleData.NegativeType.mistrust
		},
		_descId = STR.BATTLE_CARD_MISTRUST,
		_dragonBone = {
			_name = "biaoji",
			_isBottom = false,
			_scale = 1.2,
			_aniBegin = "caiyi_start",
			_aniEnd = "caiyi_end",
			_aniLoop = "caiyi_cycle",
			_pos = cc.p(0, -90)
		}
	},
	{
		_name = "cold",
		_against = {},
		_contain = {
			BattleData.NegativeType.cold
		},
		_descId = STR.BATTLE_CARD_COLD,
		_particles = {
			{
				_isBottom = false,
				_name = "par_binglen",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "corrode",
		_against = {},
		_contain = {
			BattleData.NegativeType.corrode
		},
		_descId = STR.BATTLE_CARD_CORRODE,
		_particles = {
			{
				_isBottom = false,
				_name = "swdl2",
				_pos = cc.p(0, -20)
			},
			{
				_isBottom = false,
				_name = "swdl3",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "link",
		_against = {},
		_contain = {
			BattleData.NegativeType.link
		},
		_descId = STR.BATTLE_CARD_LINK,
		_particles = {
			{
				_isBottom = false,
				_name = "lhlj",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "coverSnow",
		_against = {},
		_contain = {
			BattleData.NegativeType.coverSnow
		},
		_descId = STR.BATTLE_CARD_COVER_SNOW,
		_function = {
			_begin = var_0_0.efcCoverSnowBegin,
			_end = var_0_0.efcCoverSnowEnd,
			_remove = var_0_0.efcCoverSnowRemove,
			_reload = var_0_0.efcCoverSnowReload
		}
	},
	{
		_name = "magicbell",
		_against = {},
		_contain = {
			BattleData.NegativeType.magicbell
		},
		_descId = STR.BATTLE_CARD_MAGIC_BELL,
		_dragonBone = {
			_name = "biaoji",
			_isBottom = false,
			_scale = 0.8,
			_aniBegin = "jfld_start",
			_aniEnd = "jfld_end",
			_aniLoop = "jfld_cycle",
			_pos = cc.p(0, -90)
		}
	},
	{
		_name = "moribund",
		_against = {},
		_contain = {
			BattleData.NegativeType.moribund
		},
		_descId = STR.BATTLE_CARD_MORIBUND,
		_particles = {
			{
				_isBottom = false,
				_name = "swdl2",
				_pos = cc.p(0, -20)
			},
			{
				_isBottom = false,
				_name = "swdl3",
				_pos = cc.p(0, -20)
			}
		}
	},
	{
		_name = "manacle",
		_against = {},
		_contain = {
			BattleData.NegativeType.manacle
		},
		_descId = STR.BATTLE_CARD_MANACLE,
		_dragonBone = {
			_name = "canrao",
			_isBottom = false,
			_scale = 0.8,
			_aniBegin = "effect1",
			_aniEnd = "effect3",
			_aniLoop = "effect2",
			_pos = cc.p(0, -20)
		}
	},
	{
		_name = "defendFrozenEx",
		_against = {
			7
		},
		_contain = {
			BattleData.NegativeType.defendSkillFrozenEx
		},
		_descId = STR.BATTLE_CARD_DEFEND_FROZEN,
		_dragonBone = {
			_name = "wlfy",
			_isBottom = false,
			_scale = 2.4,
			_aniBegin = "pofang_1",
			_aniEnd = "",
			_aniLoop = "pofang_2",
			_pos = cc.p(0, -40)
		}
	},
	{
		_name = "atkFrozenForever",
		_against = {
			6,
			7
		},
		_contain = {
			BattleData.NegativeType.atkFrozenForever
		},
		_descId = STR.BATTLE_CARD_ATTACK_FROZEN,
		_dragonBone = {
			_name = "fengsuo",
			_isBottom = false,
			_scale = 0.4,
			_aniBegin = "begin",
			_aniEnd = "end",
			_aniLoop = "loop",
			_pos = cc.p(0, 0)
		}
	},
	{
		_name = "disablePosture",
		_against = {
			27
		},
		_contain = {
			BattleData.NegativeType.disablePosture
		},
		_descId = STR.BATTLE_CARD_DISABLE_POSTURE,
		_dragonBone = {
			_name = "fengsuo",
			_isBottom = true,
			_scale = 1,
			_aniBegin = "begin1",
			_aniEnd = "end1",
			_aniLoop = "loop1",
			_pos = cc.p(ClientView.CARD_SIZE.width / 2, ClientView.CARD_SIZE.height / 2)
		}
	},
	{
		_name = "disablePostureEx",
		_against = {},
		_contain = {
			BattleData.NegativeType.disablePostureEx
		},
		_descId = STR.BATTLE_CARD_DISABLE_POSTURE,
		_dragonBone = {
			_name = "fengsuo",
			_isBottom = true,
			_scale = 1,
			_aniBegin = "begin1",
			_aniEnd = "end1",
			_aniLoop = "loop1",
			_pos = cc.p(ClientView.CARD_SIZE.width / 2, ClientView.CARD_SIZE.height / 2)
		}
	},
	{
		_name = "disablePostureHalo",
		_against = {},
		_contain = {
			BattleData.NegativeType.disablePostureHalo
		},
		_descId = STR.BATTLE_CARD_DISABLE_POSTURE,
		_dragonBone = {
			_name = "fengsuo",
			_isBottom = true,
			_scale = 1,
			_aniBegin = "begin1",
			_aniEnd = "end1",
			_aniLoop = "loop1",
			_pos = cc.p(ClientView.CARD_SIZE.width / 2, ClientView.CARD_SIZE.height / 2)
		}
	},
	{
		_name = "atkDefSwap",
		_against = {},
		_contain = {
			BattleData.NegativeType.atkDefSwap
		}
	},
	{
		_name = "atkDefSwapHalo",
		_against = {},
		_contain = {
			BattleData.NegativeType.atkDefSwapHalo
		}
	},
	{
		_name = "trapVisible",
		_against = {},
		_contain = {
			BattleData.NegativeType.trapVisible
		},
		_function = {
			_begin = var_0_0.efcTrapVisibleBegin,
			_end = var_0_0.efcTrapVisibleEnd,
			_remove = var_0_0.efcTrapVisibleRemove,
			_reload = var_0_0.efcTrapVisibleReload
		}
	},
	{
		_name = "trapVisibleHalo",
		_against = {},
		_contain = {
			BattleData.NegativeType.trapVisibleHalo
		},
		_function = {
			_begin = var_0_0.efcTrapVisibleBegin,
			_end = var_0_0.efcTrapVisibleEnd,
			_remove = var_0_0.efcTrapVisibleRemove,
			_reload = var_0_0.efcTrapVisibleReload
		}
	}
}

local var_0_2 = 100

function var_0_0.create(...)
	local var_38_0 = var_0_0.new()

	var_38_0:init(...)
	var_38_0:registerScriptHandler(function(arg_39_0)
		if arg_39_0 == "exit" then
			var_38_0:onExit()
		end
	end)

	return var_38_0
end

function var_0_0.onExit(arg_40_0)
	if arg_40_0._touchEvent._focusedScheduler ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_40_0._touchEvent._focusedScheduler)

		arg_40_0._touchEvent._focusedScheduler = nil
	end
end

function var_0_0.init(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0._card = arg_41_1
	arg_41_0._battleUi = arg_41_2._battleUi
	arg_41_0._scene = ClientData._battleScene

	arg_41_0:setPlayerUi(arg_41_2)

	arg_41_0._touchEvent = {}
	arg_41_0._touchEvent._status = var_0_0.TouchStatus.ungrabbed
	arg_41_0._default = {
		_rotation = 0,
		_position = 0
	}
	arg_41_0._default._position = cc.p(0, 0)
	arg_41_0._default._rotation = {
		z = 0,
		y = 0,
		x = arg_41_0._battleUi._battleType == Data.BattleType.layout and 0 or arg_41_0._battleUi._isReverse and -ClientView.BATTLE_ROTATION_X or ClientView.BATTLE_ROTATION_X
	}
	arg_41_0._statusEfc = {}
	arg_41_0._initiativeSkillIcons = {}

	arg_41_0:setCascadeOpacityEnabled(true)

	arg_41_0._isDefence = nil
	arg_41_0._pCardArea = cc.Node:create()

	arg_41_0._pCardArea:setCascadeOpacityEnabled(true)
	arg_41_0:addChild(arg_41_0._pCardArea, var_0_0.ZOrder.card)

	arg_41_0._pShadowArea = cc.Node:create()

	arg_41_0._pShadowArea:setCascadeOpacityEnabled(true)
	arg_41_0:addChild(arg_41_0._pShadowArea, var_0_0.ZOrder.shadow)

	arg_41_0._pMaskParticleArea = cc.Node:create()

	arg_41_0._pMaskParticleArea:setCascadeOpacityEnabled(true)
	arg_41_0:addChild(arg_41_0._pMaskParticleArea, var_0_0.ZOrder.effect)

	if arg_41_0:shouldShowNormal() then
		arg_41_0:initNormal()
	else
		arg_41_0:initBack()
	end
end

function var_0_0.shouldShowNormal(arg_42_0)
	if (arg_42_0._battleUi._isObserver or arg_42_0._battleUi._battleType == Data.BattleType.replay) and arg_42_0._card._status == BattleData.CardStatus.hand then
		return not arg_42_0._ownerUi._hideHandCards
	end

	return arg_42_0._isController
end

function var_0_0.shouldShowCardInfo(arg_43_0)
	if arg_43_0._battleUi._battleType == Data.BattleType.replay then
		return true
	end

	local var_43_0 = arg_43_0._ownerUi
	local var_43_1 = var_43_0._player
	local var_43_2 = var_43_0._opponentUi._player

	return arg_43_0._isController or arg_43_0._battleUi._isObserver
end

function var_0_0.setPlayerUi(arg_44_0, arg_44_1)
	arg_44_0._ownerUi = arg_44_1
	arg_44_0._isAttacker = arg_44_1._isAttacker
	arg_44_0._isController = arg_44_0._isAttacker == arg_44_0._battleUi._isAttacker
end

function var_0_0.initCard(arg_45_0, arg_45_1)
	if arg_45_1 ~= nil then
		arg_45_0._status = arg_45_1
	end

	local var_45_0 = arg_45_0._card._type
	local var_45_1 = arg_45_0._card._originOwner._skins[arg_45_0._card._infoId]
	local var_45_2 = arg_45_0:getEffectByType(Data.SkinEffectType.onBoard)

	if arg_45_0._pFrame == nil then
		arg_45_0._pFrame = ClientView.createCardFrame(arg_45_0._card._srcInfoId, arg_45_0._ownerUi._cardBackId, var_45_1, var_45_2)

		arg_45_0._pCardArea:addChild(arg_45_0._pFrame, 1)

		arg_45_0._pAtkSpr = arg_45_0._pFrame._atkValue
		arg_45_0._pHpSpr = arg_45_0._pFrame._hpValue
		arg_45_0._pCostValue = arg_45_0._pFrame._costValue
		arg_45_0._pEffectArea = cc.Node:create()

		arg_45_0._pEffectArea:setCascadeOpacityEnabled(true)
		arg_45_0._pEffectArea:setScale(1 / var_0_0.Scale.normal)
		lc.addChildToCenter(arg_45_0._pFrame._image, arg_45_0._pEffectArea, 1)

		arg_45_0._pBottomEffectArea = cc.Node:create()

		arg_45_0._pBottomEffectArea:setCascadeOpacityEnabled(true)
		arg_45_0._pBottomEffectArea:setScale(1 / var_0_0.Scale.normal)
		lc.addChildToCenter(arg_45_0._pFrame._image, arg_45_0._pBottomEffectArea, -1)
	end

	if arg_45_0._status == var_0_0.Status.back then
		arg_45_0._pShadow = ClientView.createCardShadow(nil, var_0_0.Scale.normal, 0, 0)

		arg_45_0._pShadowArea:addChild(arg_45_0._pShadow)
	elseif arg_45_0._status == var_0_0.Status.normal or arg_45_0._status == var_0_0.Status.dead then
		if arg_45_0._pShadow == nil then
			arg_45_0._pShadow = ClientView.createCardShadow(arg_45_0._card, var_0_0.Scale.normal, 0, 0)

			arg_45_0._pShadowArea:addChild(arg_45_0._pShadow)
		end
	elseif arg_45_0._status == var_0_0.Status.fight then
		if arg_45_0._pShadow == nil then
			local var_45_3
			local var_45_4

			if var_45_0 == Data.CardType.monster or var_45_0 == Data.CardType.rare then
				var_45_3, var_45_4 = cc.p(-5, -14), "card_shadow"
			elseif var_45_0 == Data.CardType.magic then
				var_45_3, var_45_4 = cc.p(0, -14), "card_shadow"
			end

			arg_45_0._pShadow = lc.createSprite(var_45_4)

			arg_45_0._pShadow:setPosition(var_45_3)
			arg_45_0._pShadow:setScale(4 * var_0_0.Scale.normal)
			arg_45_0._pShadow:setOpacity(120)
			arg_45_0._pShadowArea:addChild(arg_45_0._pShadow)
		end
	elseif arg_45_0._status == var_0_0.Status.show or arg_45_0._status == var_0_0.Status.field then
		if arg_45_0._pFrameIcon == nil then
			if arg_45_0._card._isGold then
				arg_45_0._pFrameIcon = cc.ShaderSprite:createWithFramename("card_icon_quality_gold")

				arg_45_0._pFrameIcon:setEffect(ClientView.getCardShader(arg_45_0._card._infoId))
				arg_45_0._pFrameIcon:setCascadeOpacityEnabled(true)
				arg_45_0._pFrameIcon:setScale(1)
				arg_45_0._pCardArea:addChild(arg_45_0._pFrameIcon, 2)
			else
				arg_45_0._pFrameIcon = cc.ShaderSprite:createWithFramename("card_icon_quality_0" .. arg_45_0._card._info._quality)

				arg_45_0._pFrameIcon:setEffect(ClientView.getCardShader(arg_45_0._card._infoId))
				arg_45_0._pFrameIcon:setCascadeOpacityEnabled(true)
				arg_45_0._pFrameIcon:setScale(1)
				arg_45_0._pCardArea:addChild(arg_45_0._pFrameIcon, 2)
			end

			local var_45_5 = cc.p(arg_45_0._pFrameIcon:getContentSize().width / 2, arg_45_0._pFrameIcon:getContentSize().height / 2)
			local var_45_6 = cc.Sprite:createWithSpriteFrameName(ClientView.getCardIconName(arg_45_0._card._infoId))

			var_45_6:setPosition(var_45_5)

			arg_45_0._pFrameIcon._role = var_45_6

			arg_45_0._pFrameIcon:addChild(var_45_6, -1)

			local var_45_7 = cc.Sprite:createWithSpriteFrameName("img_card_ico_bg")

			var_45_7:setPosition(var_45_5)
			arg_45_0._pFrameIcon:addChild(var_45_7, -2)
		end
	elseif arg_45_0._status == var_0_0.Status.cover then
		-- block empty
	end

	arg_45_0._scene:seenByCamera3D(arg_45_0)
end

function var_0_0.initNormal(arg_46_0)
	local var_46_0 = arg_46_0._status

	arg_46_0._status = var_0_0.Status.normal

	arg_46_0:removeCardActive()
	arg_46_0:removeAllStatus()
	arg_46_0:removeCardProp()

	if var_46_0 == arg_46_0._status then
		return
	elseif var_46_0 ~= nil then
		if arg_46_0._pFrameIcon ~= nil then
			arg_46_0._pFrameIcon:removeFromParent()

			arg_46_0._pFrameIcon = nil
		end

		if arg_46_0._pShadow ~= nil then
			arg_46_0._pShadow:removeFromParent()

			arg_46_0._pShadow = nil
		end

		if arg_46_0._pTimesSpr ~= nil then
			arg_46_0._pTimesSpr:removeFromParent()

			arg_46_0._pTimesSpr = nil
		end
	end

	arg_46_0:initCard()
	arg_46_0._pFrame:setVisible(true)
	arg_46_0._pFrame:setStatus(true, false)
	arg_46_0._pCardArea:setScale(CardSprite.Scale.normal)
	arg_46_0:setRotation3D(arg_46_0._default._rotation)
	arg_46_0:updateDefendPosture(false)
end

function var_0_0.initBack(arg_47_0)
	local var_47_0 = arg_47_0._status

	arg_47_0._status = var_0_0.Status.back

	arg_47_0:removeCardActive()
	arg_47_0:removeAllStatus()
	arg_47_0:removeCardProp()

	if var_47_0 == arg_47_0._status then
		return
	elseif var_47_0 ~= nil then
		if arg_47_0._pFrameIcon ~= nil then
			arg_47_0._pFrameIcon:removeFromParent()

			arg_47_0._pFrameIcon = nil
		end

		if arg_47_0._pTimesSpr ~= nil then
			arg_47_0._pTimesSpr:removeFromParent()

			arg_47_0._pTimesSpr = nil
		end

		if arg_47_0._pShadow ~= nil then
			arg_47_0._pShadow:removeFromParent()

			arg_47_0._pShadow = nil
		end
	end

	arg_47_0:initCard()
	arg_47_0._pFrame:setVisible(true)
	arg_47_0._pFrame:setStatus(false, false)
	arg_47_0:setRotation3D(arg_47_0._default._rotation)
	arg_47_0._pCardArea:setScale(CardSprite.Scale.normal)
	arg_47_0:updateDefendPosture(false)
end

function var_0_0.initFight(arg_48_0)
	local var_48_0 = arg_48_0._status

	arg_48_0._status = var_0_0.Status.fight

	arg_48_0:removeCardActive()
	arg_48_0:removeAllStatus()
	arg_48_0:removeCardProp()

	if var_48_0 == arg_48_0._status then
		return
	elseif var_48_0 ~= nil then
		if arg_48_0._pFrameIcon ~= nil then
			arg_48_0._pFrameIcon:removeFromParent()

			arg_48_0._pFrameIcon = nil
		end

		if arg_48_0._pShadow ~= nil then
			arg_48_0._pShadow:removeFromParent()

			arg_48_0._pShadow = nil
		end
	end

	arg_48_0:initCard()
	arg_48_0._pFrame:setVisible(true)
	arg_48_0._pFrame:setStatus(true, true)
	arg_48_0._pCardArea:setScale(arg_48_0:isSmall() and CardSprite.Scale.normal_small or CardSprite.Scale.normal)
	arg_48_0:setRotation3D({
		z = 0,
		x = 0,
		y = 0
	})
	arg_48_0:reloadAllStatus()
	arg_48_0:updateDefendPosture(false)
end

function var_0_0.initDead(arg_49_0)
	local var_49_0 = arg_49_0._status

	arg_49_0._status = var_0_0.Status.dead

	arg_49_0:removeCardActive()
	arg_49_0:removeAllStatus()
	arg_49_0:removeCardProp()

	if var_49_0 == arg_49_0._status then
		return
	elseif var_49_0 ~= nil then
		if arg_49_0._pFrameIcon ~= nil then
			arg_49_0._pFrameIcon:removeFromParent()

			arg_49_0._pFrameIcon = nil
		end

		if arg_49_0._pShadow ~= nil then
			arg_49_0._pShadow:removeFromParent()

			arg_49_0._pShadow = nil
		end

		if arg_49_0._pTimesSpr ~= nil then
			arg_49_0._pTimesSpr:removeFromParent()

			arg_49_0._pTimesSpr = nil
		end
	end

	arg_49_0:initCard()
	arg_49_0._pFrame:setVisible(true)
	arg_49_0._pFrame:setStatus(true, false)
	arg_49_0._pCardArea:setScale(CardSprite.Scale.grave)
	arg_49_0:setRotation3D({
		z = 0,
		x = 0,
		y = 0
	})
	arg_49_0:updateDefendPosture(false)
end

function var_0_0.initCover(arg_50_0)
	local var_50_0 = arg_50_0._status

	arg_50_0._status = var_0_0.Status.cover

	arg_50_0:removeCardActive()
	arg_50_0:removeAllStatus()
	arg_50_0:removeCardProp()

	if var_50_0 == arg_50_0._status then
		return
	elseif var_50_0 ~= nil then
		if arg_50_0._pFrameIcon ~= nil then
			arg_50_0._pFrameIcon:removeFromParent()

			arg_50_0._pFrameIcon = nil
		end

		if arg_50_0._pTimesSpr ~= nil then
			arg_50_0._pTimesSpr:removeFromParent()

			arg_50_0._pTimesSpr = nil
		end

		if arg_50_0._pShadow ~= nil then
			arg_50_0._pShadow:removeFromParent()

			arg_50_0._pShadow = nil
		end
	end

	arg_50_0:initCard()
	arg_50_0._pFrame:setVisible(true)
	arg_50_0._pFrame:setStatus(false, true)
	arg_50_0._pCardArea:setScale(var_0_0.Scale.cover)
	arg_50_0:setRotation3D({
		z = 0,
		x = 0,
		y = 0
	})
	arg_50_0:updateDefendPosture(false)
end

function var_0_0.initShow(arg_51_0)
	local var_51_0 = arg_51_0._status

	arg_51_0._status = var_0_0.Status.show

	arg_51_0:removeCardActive()
	arg_51_0:removeAllStatus()
	arg_51_0:removeCardProp()

	if var_51_0 == arg_51_0._status then
		return
	elseif var_51_0 ~= nil then
		if arg_51_0._pTimesSpr ~= nil then
			arg_51_0._pTimesSpr:removeFromParent()

			arg_51_0._pTimesSpr = nil
		end

		if arg_51_0._pShadow ~= nil then
			arg_51_0._pShadow:removeFromParent()

			arg_51_0._pShadow = nil
		end
	end

	arg_51_0:initCard()
	arg_51_0._pFrame:setVisible(false)
	arg_51_0._pFrame:setStatus(false, true)
	arg_51_0:setRotation3D({
		z = 0,
		x = 0,
		y = 0
	})
	arg_51_0._pCardArea:setScale(var_0_0.Scale.show)
	arg_51_0:updateDefendPosture(false)
end

function var_0_0.initField(arg_52_0)
	local var_52_0 = arg_52_0._status

	arg_52_0._status = var_0_0.Status.field

	arg_52_0:removeCardActive()
	arg_52_0:removeAllStatus()
	arg_52_0:removeCardProp()

	if var_52_0 == arg_52_0._status then
		return
	elseif var_52_0 ~= nil then
		if arg_52_0._pTimesSpr ~= nil then
			arg_52_0._pTimesSpr:removeFromParent()

			arg_52_0._pTimesSpr = nil
		end

		if arg_52_0._pShadow ~= nil then
			arg_52_0._pShadow:removeFromParent()

			arg_52_0._pShadow = nil
		end
	end

	arg_52_0:initCard()
	arg_52_0._pFrame:setVisible(false)
	arg_52_0._pFrame:setStatus(false, true)
	arg_52_0:setRotation3D({
		z = 0,
		x = 0,
		y = 0
	})
	arg_52_0._pCardArea:setScale(var_0_0.Scale.show)
	arg_52_0:updateDefendPosture(false)
end

function var_0_0.onTouchBegan(arg_53_0, arg_53_1)
	if not arg_53_0._battleUi:isVisible() or arg_53_0._touchEvent._status ~= nil and arg_53_0._touchEvent._status ~= var_0_0.TouchStatus.ungrabbed then
		return false
	end

	arg_53_0._touchEvent._status = var_0_0.TouchStatus.grabbed

	local var_53_0 = cc.Director:getInstance():getScheduler():getTimeScale() * 0.02

	if arg_53_0._touchEvent._focusedScheduler == nil then
		arg_53_0._touchEvent._focusedScheduler = lc.Scheduler:scheduleScriptFunc(function(arg_54_0)
			arg_53_0:onTouchFocused()
		end, var_53_0, false)
	end

	arg_53_0._touchEvent._focusTimes = 0
	arg_53_0._touchEvent._isTapped = true
	arg_53_0._touchEvent._isLongPressed = false

	if arg_53_0:shouldShowCardInfo() and arg_53_0._card._status == BattleData.CardStatus.hand then
		arg_53_0._touchEvent._touchCardType = var_0_0.TouchCardType.self_hand_card
		arg_53_0._touchEvent._startPos = cc.p(arg_53_0:getPosition())

		arg_53_0:showLargePic(arg_53_1 == nil)
	elseif arg_53_0._card._status == BattleData.CardStatus.board then
		arg_53_0._touchEvent._touchCardType = var_0_0.TouchCardType.board_card
		arg_53_0._touchEvent._startPos = cc.p(arg_53_0:getPosition())
	elseif arg_53_0._card._status == BattleData.CardStatus.grave then
		arg_53_0._touchEvent._touchCardType = var_0_0.TouchCardType.grave_card
		arg_53_0._touchEvent._startPos = cc.p(arg_53_0:getPosition())
	elseif arg_53_0._card._status == BattleData.CardStatus.cover or arg_53_0._card._status == BattleData.CardStatus.show or arg_53_0._card._status == BattleData.CardStatus.field then
		arg_53_0._touchEvent._touchCardType = var_0_0.TouchCardType.ground_card
		arg_53_0._touchEvent._startPos = cc.p(arg_53_0:getPosition())
	elseif arg_53_0._card._status == BattleData.CardStatus.rare then
		arg_53_0._touchEvent._touchCardType = var_0_0.TouchCardType.rare_card
		arg_53_0._touchEvent._startPos = cc.p(arg_53_0:getPosition())
	end
end

function var_0_0.onTouchMoved(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0._touchEvent._status

	if var_55_0 == nil or var_55_0 == var_0_0.TouchStatus.ungrabbed then
		return
	end

	arg_55_0._touchEvent._status = var_0_0.TouchStatus.moved

	if var_55_0 == var_0_0.TouchStatus.grabbed then
		if cc.pGetDistance(arg_55_1:getLocation(), arg_55_1:getStartLocation()) <= lc.Gesture.BUDGE_LIMIT then
			arg_55_0._touchEvent._status = var_55_0
		else
			arg_55_0._touchEvent._isTapped = false
			arg_55_0._touchEvent._isLongPressed = false

			arg_55_0._pCardArea:stopAllActions()

			if arg_55_0._touchEvent._touchCardType == var_0_0.TouchCardType.self_hand_card then
				if arg_55_0._status == var_0_0.Status.info then
					arg_55_0:hideCardInfo()
				end
			elseif arg_55_0._touchEvent._touchCardType == var_0_0.TouchCardType.board_card then
				arg_55_0:sendEvent(var_0_0.EventType.hide_card_info)
			end
		end
	elseif var_55_0 == var_0_0.TouchStatus.moved then
		arg_55_0._touchEvent._focusTimes = 0

		if arg_55_0._touchEvent._touchCardType == var_0_0.TouchCardType.self_hand_card then
			local var_55_1 = cc.p(arg_55_0._touchEvent._startPos.x + arg_55_1:getLocation().x - arg_55_1:getStartLocation().x, arg_55_0._touchEvent._startPos.y + arg_55_1:getLocation().y - arg_55_1:getStartLocation().y)

			arg_55_0:setPosition(var_55_1)
			arg_55_0:handCardMove(2, arg_55_1:getLocation().x - arg_55_1:getPreviousLocation().x, arg_55_1:getLocation().y - arg_55_1:getPreviousLocation().y)
		elseif arg_55_0._touchEvent._touchCardType == var_0_0.TouchCardType.board_card then
			-- block empty
		end
	end
end

function var_0_0.onTouchFocused(arg_56_0)
	arg_56_0._touchEvent._focusTimes = arg_56_0._touchEvent._focusTimes + 1

	if arg_56_0._touchEvent._status == var_0_0.TouchStatus.ungrabbed then
		if arg_56_0._touchEvent._focusedScheduler ~= nil then
			lc.Scheduler:unscheduleScriptEntry(arg_56_0._touchEvent._focusedScheduler)

			arg_56_0._touchEvent._focusedScheduler = nil
		end
	elseif arg_56_0._touchEvent._status == var_0_0.TouchStatus.grabbed then
		if not arg_56_0._touchEvent._isLongPressed and arg_56_0._touchEvent._focusTimes > 5 then
			arg_56_0._touchEvent._isLongPressed = true
			arg_56_0._touchEvent._isTapped = false

			if arg_56_0._touchEvent._touchCardType == var_0_0.TouchCardType.self_hand_card then
				if arg_56_0._status == var_0_0.Status.large then
					arg_56_0:showCardInfo()
				end
			elseif arg_56_0._touchEvent._touchCardType == var_0_0.TouchCardType.board_card then
				-- block empty
			end
		end
	elseif arg_56_0._touchEvent._status == var_0_0.TouchStatus.moved and arg_56_0._touchEvent._touchCardType == var_0_0.TouchCardType.self_hand_card and arg_56_0._touchEvent._focusTimes > 1 then
		arg_56_0:handCardMove(1)
	end
end

function var_0_0.onTouchEnded(arg_57_0, arg_57_1)
	if arg_57_0._touchEvent._status == nil or arg_57_0._touchEvent._status == var_0_0.TouchStatus.ungrabbed then
		return
	end

	local var_57_0 = arg_57_0._touchEvent._status

	arg_57_0._touchEvent._status = var_0_0.TouchStatus.ungrabbed

	if var_57_0 == var_0_0.TouchStatus.grabbed then
		if arg_57_0._touchEvent._isTapped then
			if arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.self_hand_card then
				arg_57_0:hideLargePic()
			elseif arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.board_card then
				arg_57_0:sendEvent(var_0_0.EventType.show_card_info)
			elseif arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.grave_card then
				arg_57_0:sendEvent(var_0_0.EventType.show_grave_list)
			elseif arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.rare_card then
				if arg_57_0._ownerUi._isController or arg_57_0._battleUi._isObserver then
					arg_57_0:sendEvent(var_0_0.EventType.show_rare_list)
				end
			elseif arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.ground_card and (arg_57_0._card._status == BattleData.CardStatus.show or arg_57_0._card._status == BattleData.CardStatus.field or arg_57_0._card:hasBuff(false, BattleData.NegativeType.trapVisible) or arg_57_0._card:hasBuff(false, BattleData.NegativeType.trapVisibleHalo) or arg_57_0:shouldShowCardInfo()) then
				if arg_57_0._isController and arg_57_0._ownerUi and arg_57_0._ownerUi._isController and not arg_57_0._battleUi._isAddingBoardCard then
					local canCast, initSkills = arg_57_0._card:canCastInitiativeSkill()
					if canCast and #initSkills > 0 and ClientData.checkBtnClick() then
						arg_57_0._ownerUi:castInitiativeSkill(arg_57_0._card, initSkills[1])
						return
					end
				end
				arg_57_0:sendEvent(var_0_0.EventType.show_card_info)
			end
		elseif arg_57_0._touchEvent._isLongPressed then
			if arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.self_hand_card then
				arg_57_0:hideLargePic()
			elseif arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.board_card then
				arg_57_0:sendEvent(var_0_0.EventType.hide_card_info)
			elseif arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.need_show_info then
				-- block empty
			end
		end
	elseif var_57_0 == var_0_0.TouchStatus.moved then
		if arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.self_hand_card then
			arg_57_0:hideLargePic()
			arg_57_0:handCardMove(0)
		elseif arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.board_card then
			arg_57_0:sendEvent(var_0_0.EventType.hide_card_info)
		elseif arg_57_0._touchEvent._touchCardType == var_0_0.TouchCardType.need_show_info then
			-- block empty
		end
	end
end

function var_0_0.onTouchCanceled(arg_58_0)
	if arg_58_0._touchEvent._status == nil or arg_58_0._touchEvent._status == var_0_0.TouchStatus.ungrabbed then
		return
	end

	local var_58_0 = arg_58_0._touchEvent._status

	arg_58_0._touchEvent._status = var_0_0.TouchStatus.ungrabbed

	if var_58_0 == var_0_0.TouchStatus.grabbed then
		if arg_58_0._touchEvent._isTapped then
			if arg_58_0._touchEvent._touchCardType == var_0_0.TouchCardType.self_hand_card then
				arg_58_0:hideLargePic()
			end
		elseif arg_58_0._touchEvent._isLongPressed then
			if arg_58_0._touchEvent._touchCardType == var_0_0.TouchCardType.self_hand_card then
				arg_58_0:hideLargePic()
			elseif arg_58_0._touchEvent._touchCardType == var_0_0.TouchCardType.board_card then
				arg_58_0:sendEvent(var_0_0.EventType.hide_card_info)
			elseif arg_58_0._touchEvent._touchCardType == var_0_0.TouchCardType.need_show_info then
				-- block empty
			end
		end
	elseif var_58_0 == var_0_0.TouchStatus.moved then
		if arg_58_0._touchEvent._touchCardType == var_0_0.TouchCardType.self_hand_card then
			arg_58_0:hideLargePic()
			arg_58_0:handCardMove(0)
		elseif arg_58_0._touchEvent._touchCardType == var_0_0.TouchCardType.board_card then
			-- block empty
		elseif arg_58_0._touchEvent._touchCardType == var_0_0.TouchCardType.need_show_info then
			-- block empty
		end
	end

	if arg_58_0._status == var_0_0.Status.fight and arg_58_0._card:isMonsterRare() then
		arg_58_0:updateBatCardSelected(false)
	end
end

function var_0_0.sendEvent(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = cc.EventCustom:new(var_0_0.EVENT)

	var_59_0._sender = arg_59_0
	var_59_0._type = arg_59_1
	var_59_0._val = arg_59_2

	lc.Dispatcher:dispatchEvent(var_59_0)
end

function var_0_0.containsTouchLocation(arg_60_0, arg_60_1, arg_60_2)
	if not arg_60_0:isVisible() then
		return false
	end

	local var_60_0 = cc.p(arg_60_0:getPosition())
	local var_60_1
	local var_60_2
	local var_60_3

	if arg_60_0._card._status == BattleData.CardStatus.board then
		local var_60_4 = arg_60_0._pFrame:convertToNodeSpace3D(cc.p(arg_60_1, arg_60_2), ClientData._camera3D)

		var_60_1 = cc.rect(0, 0, lc.w(arg_60_0._pFrame), lc.h(arg_60_0._pFrame) + 100)
		arg_60_1, arg_60_2 = var_60_4.x, var_60_4.y
	elseif arg_60_0._card._status == BattleData.CardStatus.show or arg_60_0._card._status == BattleData.CardStatus.field then
		if arg_60_0._pFrameIcon == nil then
			return false
		end

		local var_60_5 = arg_60_0._pFrameIcon:convertToNodeSpace3D(cc.p(arg_60_1, arg_60_2), ClientData._camera3D)

		var_60_1 = cc.rect(0, 0, lc.w(arg_60_0._pFrameIcon), lc.h(arg_60_0._pFrameIcon))
		arg_60_1, arg_60_2 = var_60_5.x, var_60_5.y
	else
		local var_60_6 = arg_60_0._pFrame._frame:convertToNodeSpace3D(cc.p(arg_60_1, arg_60_2), ClientData._camera3D)

		var_60_1 = cc.rect(0, 0, lc.w(arg_60_0._pFrame._frame), lc.h(arg_60_0._pFrame._frame))
		arg_60_1, arg_60_2 = var_60_6.x, var_60_6.y
	end

	return cc.rectContainsPoint(var_60_1, cc.p(arg_60_1, arg_60_2))
end

function var_0_0.handCardMove(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	if arg_61_1 == 0 then
		local var_61_0 = {
			z = 0,
			x = 0,
			y = 0
		}

		arg_61_0._pCardArea:setRotation3D(var_61_0)
		arg_61_0._pShadowArea:setRotation3D(var_61_0)
		arg_61_0._pShadowArea:setPosition(0, 0)
		arg_61_0._pShadowArea:setScale(1)
	elseif arg_61_1 == 1 then
		local var_61_1 = 2
		local var_61_2 = arg_61_0._pCardArea:getRotation3D()
		local var_61_3 = {
			z = 0,
			x = var_61_2.x < -var_61_1 and var_61_2.x + var_61_1 or var_61_1 < var_61_2.x and var_61_2.x - var_61_1 or 0,
			y = var_61_2.y < -var_61_1 and var_61_2.y + var_61_1 or var_61_1 < var_61_2.y and var_61_2.y - var_61_1 or 0
		}

		arg_61_0._pCardArea:setRotation3D(var_61_3)
		arg_61_0._pShadowArea:setRotation3D(var_61_3)

		local var_61_4 = 4
		local var_61_5 = cc.p(-100, -100)
		local var_61_6 = cc.p(arg_61_0._pShadowArea:getPosition())
		local var_61_7 = cc.p(var_61_6.x - var_61_5.x, var_61_6.y - var_61_5.y)
		local var_61_8 = {
			x = var_61_7.x < -var_61_4 and var_61_7.x + var_61_4 or var_61_4 < var_61_7.x and var_61_7.x - var_61_4 or 0,
			y = var_61_7.y < -var_61_4 and var_61_7.y + var_61_4 or var_61_4 < var_61_7.y and var_61_7.y - var_61_4 or 0
		}

		arg_61_0._pShadowArea:setPosition(var_61_8.x + var_61_5.x, var_61_8.y + var_61_5.y)
		arg_61_0._pShadowArea:setScale(1 / var_0_0.Scale.normal * 0.8)
	elseif arg_61_1 == 2 then
		local var_61_9 = arg_61_0._pCardArea:getRotation3D()
		local var_61_10 = {
			z = 0,
			x = var_61_9.x < -arg_61_3 * 2.5 - 10 and var_61_9.x + 3 or var_61_9.x > -arg_61_3 * 2.5 + 10 and var_61_9.x - 3 or var_61_9.x,
			y = var_61_9.y < arg_61_2 * 2.5 - 10 and var_61_9.y + 3 or var_61_9.y > arg_61_2 * 2.5 + 10 and var_61_9.y - 3 or var_61_9.y
		}

		arg_61_0._pCardArea:setRotation3D(var_61_10)
		arg_61_0._pShadowArea:setRotation3D(var_61_10)

		local var_61_11 = cc.p(-100, -100)
		local var_61_12 = cc.p(arg_61_0._pShadowArea:getPosition())
		local var_61_13 = cc.p(var_61_12.x - var_61_11.x, var_61_12.y - var_61_11.y)
		local var_61_14 = {
			x = var_61_13.x < -arg_61_2 * 5 - 20 and var_61_13.x + 6 or var_61_13.x > -arg_61_2 * 5 + 20 and var_61_13.x - 6 or var_61_13.x,
			y = var_61_13.y < -arg_61_3 * 5 - 20 and var_61_13.y + 6 or var_61_13.y > -arg_61_3 * 5 + 20 and var_61_13.y - 6 or var_61_13.y
		}

		arg_61_0._pShadowArea:setPosition(var_61_14.x + var_61_11.x, var_61_14.y + var_61_11.y)
		arg_61_0._pShadowArea:setScale(1 / var_0_0.Scale.normal * 0.8)
	end
end

function var_0_0.showLargePic(arg_62_0, arg_62_1)
	arg_62_0._tempStatus = arg_62_0._status
	arg_62_0._status = var_0_0.Status.large

	if arg_62_0._touchEvent._showPicScheduler ~= nil then
		lc.Scheduler:unscheduleScriptEntry(arg_62_0._touchEvent._showPicScheduler)

		arg_62_0._touchEvent._showPicScheduler = nil
	end

	local var_62_0 = cc.Director:getInstance():getScheduler():getTimeScale() * 2

	arg_62_0:stopAllActions()
	arg_62_0:setPosition(ClientView.SCR_CW - 300, 380)
	arg_62_0:setScale(1, 1)
	arg_62_0._pShadowArea:stopAllActions()
	arg_62_0._pShadowArea:setPosition(0, 0)
	arg_62_0._pShadowArea:setRotation3D({
		z = 0,
		x = 0,
		y = 0
	})
	arg_62_0._pShadowArea:setScale(1, 1)
	arg_62_0._pCardArea:setScale(var_0_0.Scale.hd)
	arg_62_0._pEffectArea:setVisible(false)
	arg_62_0._pBottomEffectArea:setVisible(false)
	arg_62_0._pMaskParticleArea:setVisible(false)

	if arg_62_0._card:isMonsterRare() then
		arg_62_0:showCardProp()
	end

	if not arg_62_1 then
		arg_62_0._pCardArea:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.EaseOut:create(cc.MoveBy:create(var_62_0, cc.p(5, 10)), 2), cc.EaseIn:create(cc.MoveBy:create(var_62_0, cc.p(-5, -10)), 2), cc.EaseOut:create(cc.MoveBy:create(var_62_0, cc.p(-5, -10)), 2), cc.EaseIn:create(cc.MoveBy:create(var_62_0, cc.p(5, 10)), 2))))
	end

	arg_62_0:updateZOrder()
end

function var_0_0.hideLargePic(arg_63_0)
	if arg_63_0._status ~= var_0_0.Status.large and arg_63_0._status ~= var_0_0.Status.info then
		return
	end

	arg_63_0:hideCardInfo()
	arg_63_0._pEffectArea:setVisible(true)
	arg_63_0._pBottomEffectArea:setVisible(true)
	arg_63_0._pMaskParticleArea:setVisible(true)
	arg_63_0._pCardArea:setScale(var_0_0.Scale.normal)
	arg_63_0._pCardArea:stopAllActions()
	arg_63_0._pCardArea:setPosition(0, 0)

	arg_63_0._status = arg_63_0._tempStatus

	arg_63_0:removeCardProp()
	arg_63_0:updateZOrder()
end

function var_0_0.showCardInfo(arg_64_0, arg_64_1)
	arg_64_0._status = var_0_0.Status.info

	if arg_64_1 == nil then
		arg_64_1 = true
	end

	if arg_64_0._pInfoArea ~= nil then
		arg_64_0._pInfoArea:removeFromParent()
	end

	arg_64_0._pInfoArea = cc.Node:create()

	arg_64_0._pCardArea:addChild(arg_64_0._pInfoArea, 10)

	local var_64_0 = 604
	local var_64_1 = 600
	local var_64_2 = cc.size(var_64_0 - ClientView.FRAME_INNER_LEFT - ClientView.FRAME_INNER_RIGHT, var_64_1)
	local var_64_3 = require("CardInfoWidget").create(arg_64_0._card._infoId, arg_64_0._card._level, var_64_2, true, arg_64_0._card)

	var_64_3:setAnchorPoint(0.5, 0.5)

	if lc.h(var_64_3) ~= 0 then
		local var_64_4 = ClientView.createFrameBox(cc.size(var_64_0, lc.h(var_64_3) + ClientView.FRAME_INNER_TOP + ClientView.FRAME_INNER_BOTTOM))

		var_64_4:setAnchorPoint(0, 1)
		lc.addChildToPos(arg_64_0._pInfoArea, var_64_4, cc.p(140, 220))
		lc.addChildToCenter(var_64_4, var_64_3, -1)
	end

	if not arg_64_1 then
		arg_64_0:setRotation3D({
			z = 0,
			x = 0,
			y = 0
		})
	end

	if arg_64_0._card:isMonsterRare() then
		arg_64_0:showCardProp()
	end

	-- _pInfoArea is built after the card was put on the 3D camera, and
	-- Node::addChild does not pass a camera mask down to a child added later:
	-- the panel would keep the default mask and the camera that draws the
	-- battle field would skip it. showCardProp, the other thing this class
	-- hangs off _pCardArea at run time, hands its node over the same way.
	-- Last, so applyChildren covers the frame box and the props too.
	arg_64_0._scene:seenByCamera3D(arg_64_0._pInfoArea)

	if arg_64_0._battleUi._guideTipVals and arg_64_0._battleUi._guideTipVals.t.touch ~= 1 then
		arg_64_0._battleUi:hideTip()
	end
end

function var_0_0.addSkillItem(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	local var_65_0 = arg_65_0._card
	local var_65_1 = Data.getSkillType(arg_65_1._id)
	local var_65_2 = cc.p(0, 0)

	if arg_65_3 then
		if arg_65_2 <= 2 then
			var_65_2 = cc.p(-310, 280 - arg_65_2 * 174)
		else
			var_65_2 = cc.p(305, 280 - (arg_65_2 - 2) * 174)
		end
	elseif arg_65_2 % 2 == 1 then
		var_65_2 = cc.p(305, 280 - math.floor(arg_65_2 / 2 + 0.5) * 174)
	else
		var_65_2 = cc.p(650, 280 - math.floor(arg_65_2 / 2 + 0.5) * 174)
	end

	local var_65_3 = ClientView.createBattleSkillItem(var_65_0._owner, arg_65_1, var_65_2)

	arg_65_0._pInfoArea:addChild(var_65_3)
	arg_65_0._scene:seenByCamera3D(var_65_3)
	var_65_3:addTouchEventListener(function(arg_66_0, arg_66_1)
		if arg_66_1 == ccui.TouchEventType.ended then
			require("SkillForm").create(arg_65_1._id, arg_65_1._level):show()
		end
	end)

	local var_65_4 = cc.p(var_65_3:getContentSize().width / 2, var_65_3:getContentSize().height / 2)

	if var_65_0._type ~= Data.CardType.monster then
		-- block empty
	elseif (#arg_65_1._modes ~= 1 or arg_65_1._modes[1] ~= Data.SkillMode.bcs2gl and arg_65_1._modes[1] ~= Data.SkillMode.bcs2_ and arg_65_1._modes[1] ~= Data.SkillMode.g2b and arg_65_1._modes[1] ~= Data.SkillMode.using) and (var_65_1 == Data.SkillType.attack and var_65_0._negativeStatus[BattleData.NegativeType.attackSkillFrozen] or var_65_1 == Data.SkillType.defend and var_65_0._negativeStatus[BattleData.NegativeType.defendSkillFrozen] or var_65_1 >= Data.SkillType.monsterSpell and var_65_1 <= Data.SkillType.trapSpell and var_65_0._negativeStatus[BattleData.NegativeType.spellSkillFrozen] or (var_65_1 >= Data.SkillType.monsterHalo and var_65_1 <= Data.SkillType.monster2Halo or var_65_1 == Data.SkillType.monster3Halo or var_65_1 == Data.SkillType.monster4Halo) and var_65_0._negativeStatus[BattleData.NegativeType.haloSkillFrozen]) then
		local var_65_5 = cc.Sprite:createWithSpriteFrameName("card_dl_from_1")

		var_65_5:setPosition(lc.w(var_65_3) - lc.w(var_65_5) / 2 - 16, lc.h(var_65_3) - lc.h(var_65_5) / 2 - 16)
		var_65_3:addChild(var_65_5)
	elseif arg_65_1._provider == BattleData.SkillProvider.copy then
		local var_65_6 = cc.Sprite:createWithSpriteFrameName("card_dl_from_6")

		var_65_6:setPosition(lc.w(var_65_3) - lc.w(var_65_6) / 2 - 16, lc.h(var_65_3) - lc.h(var_65_6) / 2 - 16)
		var_65_3:addChild(var_65_6)
	elseif var_65_0:isMonsterRare() and arg_65_1._id ~= var_65_0._info._skillId[1] and (arg_65_0:getSkillCount() < 2 or arg_65_1._id ~= var_65_0._info._skillId[2]) and (arg_65_0:getSkillCount() < 3 or arg_65_1._id ~= var_65_0._info._skillId[3]) then
		local var_65_7 = cc.Sprite:createWithSpriteFrameName("card_dl_from_2")

		var_65_7:setPosition(lc.w(var_65_3) - lc.w(var_65_7) / 2 - 16, lc.h(var_65_3) - lc.h(var_65_7) / 2 - 16)
		var_65_3:addChild(var_65_7)
	end

	arg_65_0:removeCardProp()
end

function var_0_0.getCardStatusStrs(arg_67_0)
	local var_67_0 = arg_67_0._card
	local var_67_1 = {}
	local var_67_2 = {}
	local var_67_3 = {}
	local var_67_4 = {
		var_67_1,
		var_67_2
	}

	if var_67_0:isMonsterRare() then
		local var_67_5 = {
			cc.c3b(255, 255, 16),
			cc.c3b(26, 254, 7),
			cc.c3b(250, 10, 10)
		}

		if var_67_0:isNewLive1() then
			table.insert(var_67_1, string.format(Str(STR.NEW_LIVE1), val))
		end

		if var_67_0:isNewLive2() then
			table.insert(var_67_1, string.format(Str(STR.NEW_LIVE2), val))
		end

		local var_67_6 = arg_67_0:getPositiveStatus()

		for iter_67_0 = 1, #var_67_6 do
			local var_67_7 = var_0_0.PositiveStatus[iter_67_0]

			if var_67_6[iter_67_0] then
				if var_67_7._name == "irony" then
					local var_67_8 = var_67_0:getBuffValue(true, BattleData.PositiveType.irony)

					if var_67_8 == 0 then
						var_67_8 = ""
					elseif var_67_8 < 65536 then
						var_67_8 = "[" .. Str(STR.CARD_CATEGORY_BEGIN + var_67_8) .. Str(STR.CARD_CATEGORY) .. "]"
					elseif var_67_8 < 131072 then
						local var_67_9 = var_67_8 - 65536

						if var_67_9 < 200 then
							var_67_8 = "[" .. Str(STR.CARD_KEYWORD_BEGIN + var_67_9) .. Str(STR.CARD_KEYWORD) .. "]"
						else
							local var_67_10 = var_67_9 % 200
							local var_67_11 = math.floor(var_67_9 / 200)

							var_67_8 = "[" .. Str(STR.CARD_KEYWORD_BEGIN + var_67_10) .. "," .. Str(STR.CARD_KEYWORD_BEGIN + var_67_11) .. Str(STR.CARD_KEYWORD) .. "]"
						end
					elseif var_67_8 < 196608 then
						var_67_8 = "[" .. Str(STR.CARD_KEYWORD_BEGIN + var_67_8 - 131072) .. Str(STR.CARD_KEYWORD) .. "]"
					else
						var_67_8 = ""
					end

					table.insert(var_67_1, string.format(Str(var_67_7._descId), var_67_8))
				elseif var_67_7._name == "invisible" then
					table.insert(var_67_1, Str(var_67_7._descId))
				elseif var_67_7._descId ~= nil then
					local var_67_12
					local var_67_13

					if var_67_7._name == "guard" then
						-- block empty
					elseif var_67_7._name == "spellMaster" then
						var_67_12 = var_67_0:getBuffValue(true, BattleData.PositiveType.spellMaster)
					elseif var_67_7._name == "spellMaster2" then
						var_67_12 = var_67_0:getBuffValue(true, BattleData.PositiveType.spellMaster2)
					elseif var_67_7._name == "spellMasterWu" then
						var_67_12 = var_67_0:getBuffValue(true, BattleData.PositiveType.spellMasterWu)
					elseif var_67_7._name == "changeRandom" then
						var_67_12 = var_67_0:getBuffValue(true, BattleData.PositiveType.changeRandom)
						var_67_13 = var_67_12
					elseif var_67_7._name == "poisonMaster" then
						var_67_12 = var_67_0:getBuffValue(true, BattleData.PositiveType.poisonMaster)
					elseif var_67_7._name == "magicMark" then
						var_67_12 = var_67_0:getBuffValue(true, BattleData.PositiveType.magicMark)
					elseif var_67_7._name == "roundMark" then
						var_67_12 = var_67_0:getBuffValue(true, BattleData.PositiveType.roundMark)
					elseif var_67_7._name == "lockAtk" then
						var_67_12 = var_67_0._atk
					elseif var_67_7._name == "lockDef" then
						var_67_12 = var_67_0._hp
					else
						for iter_67_1 = 1, #var_0_0.PositiveStatus do
							if string.sub(var_0_0.PositiveStatus[iter_67_1]._name, 1, 6) == "shield" and var_67_7._name == var_0_0.PositiveStatus[iter_67_1]._name then
								local var_67_14, var_67_15 = var_67_0:getShieldValue(var_0_0.PositiveStatus[iter_67_1]._contain[1])

								var_67_12 = var_67_15 and Str(STR.ROUND_ONLY) or ""

								break
							end
						end
					end

					table.insert(var_67_1, string.format(Str(var_67_7._descId), var_67_12, var_67_13))
				end
			end
		end

		local var_67_16 = arg_67_0:getNegativeStatus()

		for iter_67_2 = 1, #var_0_0.NegativeStatus do
			local var_67_17 = var_0_0.NegativeStatus[iter_67_2]

			if var_67_16[iter_67_2] and var_67_17._descId then
				local var_67_18

				if var_67_17._name == "marked" then
					var_67_18 = var_67_0:getBuffValue(false, BattleData.NegativeType.marked)
				elseif var_67_17._name == "drunk" then
					var_67_18 = var_67_0:getBuffValue(false, BattleData.NegativeType.drunk)
				elseif var_67_17._name == "mistrust" then
					var_67_18 = var_67_0:getBuffValue(false, BattleData.NegativeType.mistrust)
				elseif var_67_17._name == "cold" then
					var_67_18 = var_67_0:getBuffValue(false, BattleData.NegativeType.cold)
				elseif var_67_17._name == "corrode" then
					var_67_18 = var_67_0:getBuffValue(false, BattleData.NegativeType.corrode)
				elseif var_67_17._name == "link" then
					var_67_18 = var_67_0:getBuffValue(false, BattleData.NegativeType.link)
				elseif var_67_17._name == "coverSnow" then
					var_67_18 = var_67_0:getBuffValue(false, BattleData.NegativeType.coverSnow)
				end

				table.insert(var_67_2, string.format(Str(var_67_17._descId), var_67_18))
			end
		end
	end

	return var_67_4
end

function var_0_0.hideCardInfo(arg_68_0)
	arg_68_0._status = var_0_0.Status.large

	if arg_68_0._pInfoArea then
		arg_68_0._pInfoArea:removeFromParent()

		arg_68_0._pInfoArea = nil
	end
end

function var_0_0.updateZOrder(arg_69_0, arg_69_1)
	if arg_69_0._status == var_0_0.Status.large or arg_69_0._status == var_0_0.Status.info then
		arg_69_0:setLocalZOrder(BattleUi.ZOrder.card_touch)
	elseif arg_69_1 then
		arg_69_0:setLocalZOrder(BattleUi.ZOrder.card_action)
	elseif arg_69_0._status == var_0_0.Status.normal then
		arg_69_0:setLocalZOrder(BattleUi.ZOrder.card_hand + (arg_69_0._card._pos or 0))
	elseif arg_69_0._status == var_0_0.Status.back then
		arg_69_0:setLocalZOrder(BattleUi.ZOrder.card + (arg_69_0._card._pos or 0))
	elseif arg_69_0._status == var_0_0.Status.fight or arg_69_0._status == var_0_0.Status.cover or arg_69_0._status == var_0_0.Status.show or arg_69_0._status == var_0_0.Status.field then
		local var_69_0

		if arg_69_0._status == var_0_0.Status.fight and arg_69_0._card._pos == 6 then
			var_69_0 = BattleUi.ZOrder.card_board
		else
			var_69_0 = BattleUi.ZOrder.card_board + (arg_69_0._card._pos or 0)
		end

		arg_69_0:setLocalZOrder(var_69_0)
	elseif arg_69_0._status == var_0_0.Status.dead then
		arg_69_0:setLocalZOrder(BattleUi.ZOrder.card)
	end
end

function var_0_0.updateAtkHp(arg_70_0)
	if not arg_70_0._pAtkSpr or not arg_70_0._pHpSpr then
		return
	end

	local var_70_0 = arg_70_0._card:hasBuff(true, BattleData.PositiveType.defendPosture)
	local var_70_1 = arg_70_0._pFrame._starValue
	local var_70_2 = arg_70_0._pFrame._starIcon
	local var_70_3 = ClientData.formatNum(arg_70_0._card._atk, 99999)
	local var_70_4 = ClientData.formatNum(arg_70_0._card._hp, 99999)
	local var_70_5 = arg_70_0._card:getStar()

	if var_70_5 == Data.XYZ_STAR then
		var_70_1:setString(arg_70_0._card._info._star)
		var_70_2:setSpriteFrame("card_quality3")
	else
		var_70_1:setString(var_70_5)
		var_70_2:setSpriteFrame(arg_70_0._card:isAdjust() and "card_quality2" or "card_quality")
	end

	var_70_2:setPositionX((var_70_5 == Data.XYZ_STAR or var_70_5 < 10) and var_70_2._x or var_70_2._x - 30)

	if not arg_70_0._ownerUi._isController and arg_70_0._card:hasBuff(true, BattleData.PositiveType.mask2) then
		arg_70_0._pAtkSpr:setString("?")
		arg_70_0._pHpSpr:setString("?")

		local var_70_6 = Data._skillInfo[3341]._refCards[1]

		arg_70_0._pFrame._image:setTexture(lc.TextureCache:addImage(ClientView.getCardImageName(var_70_6, skinId)))
		var_70_1:setString(Data._monsterInfo[var_70_6]._star)

		arg_70_0._mask2 = true
	elseif not arg_70_0._ownerUi._isController and arg_70_0._card:hasBuff(true, BattleData.PositiveType.mask) then
		arg_70_0._pAtkSpr:setString("?")
		arg_70_0._pHpSpr:setString("?")

		local var_70_7 = Data._skillInfo[9487]._refCards[1]

		arg_70_0._pFrame._image:setTexture(lc.TextureCache:addImage(ClientView.getCardImageName(var_70_7, skinId)))
		var_70_1:setString(Data._rareInfo[var_70_7]._star)

		arg_70_0._mask2 = true
	else
		if arg_70_0._mask2 then
			arg_70_0._mask2 = nil

			local var_70_8 = arg_70_0._card._infoId
			local var_70_9 = arg_70_0._card._originOwner._skins[var_70_8]

			arg_70_0._pFrame:update(var_70_8, var_70_9)
		end

		arg_70_0._pAtkSpr:setString(arg_70_0._card:isAtkHide() and arg_70_0._status ~= var_0_0.Status.fight and "?" or var_70_3)
		arg_70_0._pHpSpr:setString(arg_70_0._card:isDefHide() and arg_70_0._status ~= var_0_0.Status.fight and "?" or arg_70_0._card:isLink() and arg_70_0._card:getLink() or var_70_4)
	end

	local var_70_10 = arg_70_0._status == var_0_0.Status.fight and not var_70_0
	local var_70_11 = arg_70_0._status == var_0_0.Status.fight and var_70_0

	if not var_70_10 and arg_70_0._pAtkSpr._str then
		arg_70_0._pAtkSpr._str:removeFromParent()

		arg_70_0._pAtkSpr._str = nil
	elseif var_70_10 and not arg_70_0._pAtkSpr._str then
		arg_70_0._pAtkSpr._str = ClientView.createBMFont(ClientView.BMFont.huali_32, "ATK")

		lc.addChildToPos(arg_70_0._pFrame._valueNode, arg_70_0._pAtkSpr._str, cc.p(var_70_1._defaultPos.x - 180, var_70_1._defaultPos.y - 60))
		arg_70_0._scene:seenByCamera3D(arg_70_0)
	end

	if not var_70_11 and arg_70_0._pHpSpr._str then
		arg_70_0._pHpSpr._str:removeFromParent()

		arg_70_0._pHpSpr._str = nil
	elseif var_70_11 and not arg_70_0._pHpSpr._str then
		arg_70_0._pHpSpr._str = ClientView.createBMFont(ClientView.BMFont.huali_32, "DEF")

		lc.addChildToPos(arg_70_0._pFrame._valueNode, arg_70_0._pHpSpr._str, cc.p(var_70_1._defaultPos.x - 180, var_70_1._defaultPos.y - 120))
		arg_70_0._scene:seenByCamera3D(arg_70_0)
	end

	local var_70_12 = arg_70_0._ownerUi:getLabelColor(arg_70_0._card._atk, arg_70_0._card._maxAtk)
	local var_70_13 = arg_70_0._ownerUi:getLabelColor(arg_70_0._card._hp, arg_70_0._card._maxHp)
	local var_70_14 = arg_70_0._ownerUi:getLabelColor(arg_70_0._card:getStar(), arg_70_0._card:getBaseStar())

	local card = arg_70_0._card
	if card then
		if (card._infoId == 12326 or card:hasSkillFast(14707)) then
			if card._atk and card._atk > 2000 then var_70_12 = cc.c3b(133, 235, 3) end
			if card._hp and card._hp > 2800 then var_70_13 = cc.c3b(133, 235, 3) end
		end
		if (card._infoId == 12324 or card:hasSkillFast(14700)) then
			if card._atk and card._atk > 0 then var_70_12 = cc.c3b(133, 235, 3) end
		end
		if (card._infoId == 40730 or card:hasSkillFast(14719)) then
			if card._atk and card._atk > 8000 then var_70_12 = cc.c3b(133, 235, 3) end
			if card._hp and card._hp > 8000 then var_70_13 = cc.c3b(133, 235, 3) end
		end
	end

	if arg_70_0._status == var_0_0.Status.fight then
		local var_70_15 = cc.c3b(90, 90, 90)

		if var_70_0 then
			var_70_12 = var_70_15
		else
			var_70_13 = var_70_15
		end
	end

	arg_70_0._pAtkSpr:setColor(var_70_12)
	arg_70_0._pHpSpr:setColor(var_70_13)
	var_70_1:setColor(var_70_14)
	arg_70_0._scene:seenByCamera3D(arg_70_0)
end

function var_0_0.updateDefendPosture(arg_71_0, arg_71_1)
	if not arg_71_0._pAtkSpr or not arg_71_0._pHpSpr then
		return
	end

	local var_71_0 = arg_71_0._pFrame
	local var_71_1 = var_71_0._frame
	local var_71_2 = var_71_0._center
	local var_71_3 = var_71_0._image
	local var_71_4 = var_71_0._valueNode

	if arg_71_0._status == var_0_0.Status.fight then
		local var_71_5 = arg_71_0._card:hasBuff(true, BattleData.PositiveType.defendPosture)

		if var_71_5 == arg_71_0._isDefence then
			return
		end

		arg_71_0._isDefence = var_71_5

		var_71_1:stopAllActions()

		if arg_71_1 then
			local var_71_6 = 0
			local var_71_7 = 20

			var_71_1:runAction(lc.rep(lc.sequence(lc.delay(0.01), lc.call(function()
				var_71_6 = var_71_6 + 1

				local var_72_0 = (var_71_5 and 90 or -90) / var_71_7 * var_71_6

				var_71_1:setRotation((var_71_5 and 0 or -90) - var_72_0)
				var_71_2:setRotation((var_71_5 and 0 or -90) - var_72_0)

				if arg_71_0._pShadow then
					arg_71_0._pShadow:setRotation((var_71_5 and 0 or -90) - var_72_0)
				end
			end)), var_71_7))

			if var_71_5 then
				arg_71_0._battleUi._audioEngine:playEffect("e_posture")
			end
		else
			var_71_1:setRotation(var_71_5 and -90 or 0)
			var_71_2:setRotation(var_71_5 and -90 or 0)

			if arg_71_0._pShadow then
				arg_71_0._pShadow:setRotation(var_71_5 and -90 or 0)
			end
		end

		var_71_4:setPosition(var_71_5 and cc.p(60, 60) or cc.p(0, 0))
	else
		arg_71_0._isDefence = nil

		var_71_1:stopAllActions()
		var_71_1:setRotation(0)
		var_71_2:setRotation(0)
		var_71_4:setPosition(cc.p(0, 0))

		if arg_71_0._pShadow then
			arg_71_0._pShadow:setRotation(0)
		end
	end

	arg_71_0:updateAtkHp()

	if arg_71_1 and arg_71_0._ownerUi._battleUi._btnInitiative then
		if arg_71_0._ownerUi._isController then
			arg_71_0._ownerUi:updateBoardCardsInitialSkills()
		end
	else
		arg_71_0:updateInitiativeSkills()
	end
end

function var_0_0.isDefence(arg_73_0)
	return arg_73_0._isDefence
end

function var_0_0.updateCost(arg_74_0)
	return
end

function var_0_0.updateLevel(arg_75_0, arg_75_1)
	if not arg_75_0._pFrame._levelBg:isVisible() then
		return
	end

	arg_75_1 = arg_75_1 == nil and arg_75_0._card._level or arg_75_1

	arg_75_0._pFrame._levelValue:setString(arg_75_1)
end

function var_0_0.updateTimes(arg_76_0, arg_76_1)
	if arg_76_0._pTimesSpr == nil then
		return
	end

	arg_76_1 = arg_76_1 == nil and (arg_76_0._card._remainRound ~= nil and arg_76_0._card._remainRound or arg_76_0._card._round) or arg_76_1

	local var_76_0 = string.format("%d/%d", arg_76_1, arg_76_0._card._round)
	local var_76_1 = arg_76_0._pTimesSpr:getChildByTag(1)

	if var_76_1 == nil then
		var_76_1 = ClientView.createTTF(var_76_0)

		var_76_1:setPosition(30, 18)
		var_76_1:setTag(1)
		arg_76_0._pTimesSpr:addChild(var_76_1)
	else
		var_76_1:setString(var_76_0)
	end
end

function var_0_0.updateActive(arg_77_0, arg_77_1)
	if arg_77_1 then
		if arg_77_0._handGlow == nil then
			local var_77_0 = lc.createNode()

			lc.addChildToCenter(arg_77_0._pFrame, var_77_0, -1)
			var_77_0:setScale(1.8)
			var_77_0._bones = arg_77_0._battleUi:createDragonBones("xuanzhong", cc.p(5, 8), var_77_0, "effect1", false, 1)
			arg_77_0._ownerUi._scene:seenByCamera3D(var_77_0)

			arg_77_0._handGlow = var_77_0
		end
	elseif arg_77_0._handGlow ~= nil then
		if arg_77_0._handGlow._bones and arg_77_0._handGlow._bones.stop then
			arg_77_0._handGlow._bones:stop()
		end
		arg_77_0._handGlow:removeFromParent()

		arg_77_0._handGlow = nil
	end

	arg_77_0:updateCost()
end

function var_0_0.updateBoardActive(arg_78_0)
	local var_78_0 = arg_78_0._ownerUi and arg_78_0._ownerUi._player
	if not var_78_0 then return end

	if var_78_0:getActionPlayer() == var_78_0 and arg_78_0._card:canAction() then
		local targetAnim = arg_78_0._card:canAttack(true) and "effect1" or "effect2"
		if arg_78_0._boardGlow == nil then
			local var_78_1 = lc.createNode()

			lc.addChildToCenter(arg_78_0._pFrame._center, var_78_1, -1)

			arg_78_0._boardGlow = var_78_1

			var_78_1:setScale(1)

			var_78_1._bones = arg_78_0._battleUi and arg_78_0._battleUi:createDragonBones("szkp", cc.p(5, 8), var_78_1, targetAnim, false, 1)
			var_78_1._curAnim = targetAnim

			if arg_78_0._ownerUi and arg_78_0._ownerUi._scene and arg_78_0._ownerUi._scene.seenByCamera3D then
				arg_78_0._ownerUi._scene:seenByCamera3D(var_78_1)
			end
		else
			if arg_78_0._boardGlow._curAnim ~= targetAnim and arg_78_0._boardGlow._bones and arg_78_0._boardGlow._bones.gotoAndPlay then
				arg_78_0._boardGlow._curAnim = targetAnim
				arg_78_0._boardGlow._bones:gotoAndPlay(targetAnim)
			end
		end
	elseif arg_78_0._boardGlow ~= nil then
		if arg_78_0._boardGlow._bones and arg_78_0._boardGlow._bones.stop then
			arg_78_0._boardGlow._bones:stop()
		end
		arg_78_0._boardGlow:removeFromParent()

		arg_78_0._boardGlow = nil
	end
end

function var_0_0.updateBubble(arg_79_0, arg_79_1)
	if arg_79_0._bubble == nil then
		arg_79_0._bubble = lc.createSprite("bat_story_title_bg")

		lc.addChildToPos(arg_79_0, arg_79_0._bubble, cc.p(lc.cw(arg_79_0), lc.ch(arg_79_0)), 30)

		arg_79_0._bubble._y = lc.y(arg_79_0._bubble)

		local var_79_0 = ClientView.createBMFont(ClientView.BMFont.huali_26, "")

		lc.addChildToCenter(arg_79_0._bubble, var_79_0)

		arg_79_0._bubble._label = var_79_0

		arg_79_0._scene:seenByCamera3D(arg_79_0._bubble)
	end

	if arg_79_1 ~= "" then
		arg_79_0._bubble:setVisible(true)
		arg_79_0._bubble._label:setString(arg_79_1 == "switch_atk" and Str(STR.SWITCH_ATK) or arg_79_1 == "atk" and Str(STR.BUBBLE_ATTACK) .. " " .. arg_79_0._card._atk or Str(STR.BUBBLE_DEFEND) .. " " .. arg_79_0._card._hp)
		arg_79_0._bubble:setPositionY(arg_79_1 == "def" and arg_79_0._bubble._y + 60 or arg_79_0._bubble._y - 60)
	else
		arg_79_0._bubble:setVisible(false)
	end
end

function var_0_0.updateBatCardSelected(arg_80_0, arg_80_1)
	if arg_80_1 == nil then
		arg_80_1 = arg_80_0._boardSelected == nil
	end

	if arg_80_1 then
		if arg_80_0._boardSelected == nil then
			arg_80_0._boardSelected = arg_80_0:efcDragonBones("s_xuanzhong", cc.p(0, -10), false, true, "effect", 1)
		end
	elseif arg_80_0._boardSelected ~= nil then
		arg_80_0._boardSelected:removeFromParent()

		arg_80_0._boardSelected = nil
	end
end

function var_0_0.updatePositiveStatus(arg_81_0)
	local var_81_0 = arg_81_0:getPositiveStatus()

	for iter_81_0 = 1, #var_0_0.PositiveStatus do
		local var_81_1 = var_0_0.PositiveStatus[iter_81_0]

		if var_81_0[iter_81_0] then
			if arg_81_0._statusEfc[var_81_1._name] == nil or var_81_1._name == "magicMark" or var_81_1._name == "roundMark" or var_81_1._name == "dinosaurMark" or var_81_1._name == "pumpkinMark" or var_81_1._name == "sugarMark" or var_81_1._name == "sugarMark2" or var_81_1._name == "deathMark" or var_81_1._name == "satelliteMark" or var_81_1._name == "oceanMark" or var_81_1._name == "snowMark" or var_81_1._name == "wasteMark" or var_81_1._name == "boxMark" or var_81_1._name == "stormMark" or var_81_1._name == "shieldMark" or var_81_1._name == "samuraiMark" or var_81_1._name == "phoenixMark" or var_81_1._name == "soulMark" or var_81_1._name == "foreverFireMark" or var_81_1._name == "cjMark" or var_81_1._name == "techMark" or var_81_1._name == "syncMark" or var_81_1._name == "resonateMark" or var_81_1._name == "gustoMark" or var_81_1._name == "sunFlowerMark" or var_81_1._name == "deedMark" or var_81_1._name == "featherMark" or var_81_1._name == "weddingMark" or var_81_1._name == "revolverMark" or var_81_1._name == "plantMark" or var_81_1._name == "dMark" or var_81_1._name == "ironMark" or var_81_1._name == "xyzMark" or var_81_1._name == "puppetMark" or var_81_1._name == "fateMark" or var_81_1._name == "potMark" or var_81_1._name == "ylyMark" or var_81_1._name == "sideEffectMark" or var_81_1._name == "lineMark" or var_81_1._name == "universeMark" or var_81_1._name == "hsjMark" or var_81_1._name == "bigSunMark" or var_81_1._name == "digMark" or var_81_1._name == "allyMark" or var_81_1._name == "ddMark" or var_81_1._name == "sacriMark" or var_81_1._name == "fireStarMark" or var_81_1._name == "koiMark" or var_81_1._name == "godMark" or var_81_1._name == "summonMark" or var_81_1._name == "dessertMark" or var_81_1._name == "yiguaiMark" or var_81_1._name == "crystalMark" or var_81_1._name == "magicCardMark" or var_81_1._name == "trapCardMark" or var_81_1._name == "guangboMark" or var_81_1._name == "yingyiMark" or var_81_1._name == "bianMark" or var_81_1._name == "sixFlowerMark" or var_81_1._name == "huanmoMark" or var_81_1._name == "gunMark" or var_81_1._name == "bjjMark" or var_81_1._name == "newLiveMark" then
				if var_81_1._dragonBone ~= nil then
					arg_81_0:efcDragonBoneBegin(var_81_1._name, var_81_1._dragonBone)
				elseif var_81_1._particles ~= nil then
					arg_81_0:efcParticleBegin(var_81_1._name, var_81_1._particles)
				elseif var_81_1._function ~= nil then
					var_81_1._function._begin(arg_81_0, var_81_1._name)
				end
			end
		elseif arg_81_0._statusEfc[var_81_1._name] ~= nil or var_81_1._name == "defendPosture" then
			if var_81_1._dragonBone ~= nil then
				arg_81_0:efcDragonBoneEnd(var_81_1._name, var_81_1._dragonBone)
			elseif var_81_1._particles ~= nil then
				arg_81_0:efcParticleEnd(var_81_1._name)
			elseif var_81_1._function ~= nil then
				var_81_1._function._end(arg_81_0, var_81_1._name)
			end
		end
	end

	if arg_81_0._card._status == BattleData.CardStatus.board then
		arg_81_0:updateBoardActive()
	end

	arg_81_0:updateAtkHp()
end

function var_0_0.updateNegativeStatus(arg_82_0)
	local var_82_0 = arg_82_0:getNegativeStatus()

	for iter_82_0 = 1, #var_0_0.NegativeStatus do
		local var_82_1 = var_0_0.NegativeStatus[iter_82_0]

		if var_82_0[iter_82_0] then
			if arg_82_0._statusEfc[var_82_1._name] == nil or var_82_1._name == "coverSnow" then
				if var_82_1._dragonBone ~= nil then
					arg_82_0:efcDragonBoneBegin(var_82_1._name, var_82_1._dragonBone)
				elseif var_82_1._particles ~= nil then
					arg_82_0:efcParticleBegin(var_82_1._name, var_82_1._particles)
				elseif var_82_1._function ~= nil then
					var_82_1._function._begin(arg_82_0, var_82_1._name)
				end
			end
		elseif arg_82_0._statusEfc[var_82_1._name] ~= nil then
			if var_82_1._dragonBone ~= nil then
				arg_82_0:efcDragonBoneEnd(var_82_1._name, var_82_1._dragonBone)
			elseif var_82_1._particles ~= nil then
				arg_82_0:efcParticleEnd(var_82_1._name)
			elseif var_82_1._function ~= nil then
				var_82_1._function._end(arg_82_0, var_82_1._name)
			end
		end
	end

	if arg_82_0._card._status == BattleData.CardStatus.board then
		arg_82_0:updateBoardActive()
	end
end

function var_0_0.reloadAllStatus(arg_83_0)
	local var_83_0 = arg_83_0:getPositiveStatus()

	for iter_83_0 = 1, #var_0_0.PositiveStatus do
		local var_83_1 = var_0_0.PositiveStatus[iter_83_0]

		if var_83_0[iter_83_0] then
			if var_83_1._dragonBone ~= nil then
				arg_83_0:efcDragonBoneReload(var_83_1._name, var_83_1._dragonBone)
			elseif var_83_1._particles ~= nil then
				arg_83_0:efcParticleReload(var_83_1._name, var_83_1._particles)
			elseif var_83_1._function ~= nil then
				var_83_1._function._reload(arg_83_0, var_83_1._name)
			end
		end
	end

	local var_83_2 = arg_83_0:getNegativeStatus()

	for iter_83_1 = 1, #var_0_0.NegativeStatus do
		local var_83_3 = var_0_0.NegativeStatus[iter_83_1]

		if var_83_2[iter_83_1] then
			if var_83_3._dragonBone ~= nil then
				arg_83_0:efcDragonBoneReload(var_83_3._name, var_83_3._dragonBone)
			elseif var_83_3._particles ~= nil then
				arg_83_0:efcParticleReload(var_83_3._name, var_83_3._particles)
			elseif var_83_3._function ~= nil then
				var_83_3._function._reload(arg_83_0, var_83_3._name)
			end
		end
	end
end

function var_0_0.removeAllStatus(arg_84_0)
	for iter_84_0 = 1, #var_0_0.PositiveStatus do
		local var_84_0 = var_0_0.PositiveStatus[iter_84_0]

		if var_84_0._dragonBone ~= nil then
			arg_84_0:efcDragonBoneRemove(var_84_0._name)
		elseif var_84_0._particles ~= nil then
			arg_84_0:efcParticleRemove(var_84_0._name)
		elseif var_84_0._function ~= nil then
			var_84_0._function._remove(arg_84_0, var_84_0._name)
		end
	end

	for iter_84_1 = 1, #var_0_0.NegativeStatus do
		local var_84_1 = var_0_0.NegativeStatus[iter_84_1]

		if var_84_1._dragonBone ~= nil then
			arg_84_0:efcDragonBoneRemove(var_84_1._name)
		elseif var_84_1._particles ~= nil then
			arg_84_0:efcParticleRemove(var_84_1._name)
		elseif var_84_1._function ~= nil then
			var_84_1._function._remove(arg_84_0, var_84_1._name)
		end
	end
end

function var_0_0.removeCardActive(arg_85_0)
	if arg_85_0._handGlow ~= nil then
		arg_85_0._handGlow:removeFromParent()

		arg_85_0._handGlow = nil
	end

	if arg_85_0._bookGlow ~= nil then
		arg_85_0._bookGlow:removeFromParent()

		arg_85_0._bookGlow = nil
	end

	if arg_85_0._bookMask ~= nil then
		arg_85_0._bookMask:removeFromParent()

		arg_85_0._bookMask = nil
	end

	if arg_85_0._boardGlow ~= nil then
		arg_85_0._boardGlow:removeFromParent()

		arg_85_0._boardGlow = nil
	end

	if arg_85_0._boardSelected ~= nil then
		arg_85_0._boardSelected:removeFromParent()

		arg_85_0._boardSelected = nil
	end
end

function var_0_0.showCardProp(arg_86_0)
	if arg_86_0._pPropArea == nil then
		local var_86_0 = arg_86_0:createPropArea()

		lc.addChildToPos(arg_86_0._pCardArea, var_86_0, cc.p(lc.w(arg_86_0._pCardArea) / 2, -ClientView.CARD_SIZE.height / 2 - lc.h(var_86_0) / 2 + 4), 1)
		arg_86_0._scene:seenByCamera3D(var_86_0)

		arg_86_0._pPropArea = var_86_0
	end
end

function var_0_0.removeCardProp(arg_87_0)
	if arg_87_0._pPropArea ~= nil then
		arg_87_0._pPropArea:removeFromParent()

		arg_87_0._pPropArea = nil
	end
end

function var_0_0.getPositiveStatus(arg_88_0)
	local var_88_0 = arg_88_0._card
	local var_88_1 = {}

	for iter_88_0 = 1, #var_0_0.PositiveStatus do
		local var_88_2 = var_0_0.PositiveStatus[iter_88_0]
		local var_88_3 = true

		for iter_88_1 = 1, #var_88_2._contain do
			if not var_88_0._positiveStatus[var_88_2._contain[iter_88_1]] then
				var_88_3 = false

				break
			end
		end

		var_88_1[iter_88_0] = var_88_3
	end

	return var_88_1
end

function var_0_0.getNegativeStatus(arg_89_0)
	local var_89_0 = arg_89_0._card
	local var_89_1 = {}

	for iter_89_0 = 1, #var_0_0.NegativeStatus do
		local var_89_2 = var_0_0.NegativeStatus[iter_89_0]
		local var_89_3 = true

		for iter_89_1 = 1, #var_89_2._contain do
			if not var_89_0._negativeStatus[var_89_2._contain[iter_89_1]] then
				var_89_3 = false

				break
			end
		end

		var_89_1[iter_89_0] = var_89_3
	end

	for iter_89_2 = 1, #var_0_0.NegativeStatus do
		if var_89_1[iter_89_2] then
			local var_89_4 = var_0_0.NegativeStatus[iter_89_2]
			local var_89_5 = false

			for iter_89_3 = 1, #var_89_4._against do
				for iter_89_4 = 1, #var_89_1 do
					if var_89_1[iter_89_4] and var_89_4._against[iter_89_3] == iter_89_4 then
						var_89_5 = true

						break
					end
				end
			end

			if var_89_5 then
				var_89_1[iter_89_2] = false
			end
		end
	end

	return var_89_1
end

function var_0_0.updateInitiativeSkills(arg_90_0, force)
	local var_90_0 = arg_90_0._card
	if not var_90_0 then return end
	local var_90_1 = var_90_0:getInitiativeSkill(Data.SkillMode.initiative_bcs) or {}

	if not arg_90_0._isController or var_90_0._status ~= BattleData.CardStatus.board then
		arg_90_0:removeInitiativeSkills()
		return
	end

	if #var_90_1 == 0 then
		arg_90_0:removeInitiativeSkills()
		return
	end

	-- Re-use existing button widgets when count matches
	if arg_90_0._initiativeSkillIcons and #arg_90_0._initiativeSkillIcons == #var_90_1 then
		local var_90_5 = {
			0,
			6,
			-6,
			10,
			-10,
			6
		}
		local var_90_6 = var_90_5[var_90_0._pos or 1] or 0
		local isDropLayerNil = (arg_90_0._battleUi == nil or arg_90_0._battleUi._dropLayer == nil)
		for iter_90_1 = 1, #var_90_1 do
			local var_90_3 = var_90_1[iter_90_1]
			local btn = arg_90_0._initiativeSkillIcons[iter_90_1]
			if btn then
				local isEnabled = var_90_0._owner and var_90_0._owner:canUseInitiativeSkill(var_90_0, var_90_3) and isDropLayerNil or false
				btn:setEnabled(isEnabled)
				btn:setTouchRect(cc.rect(var_90_6, 0, lc.w(btn) + var_90_6, lc.h(btn)))
				btn:setPosition(cc.p(-60 + iter_90_1 * 30, -100))
			end
		end
		return
	end

	arg_90_0:removeInitiativeSkills()

	for iter_90_1 = 1, #var_90_1 do
		local var_90_3 = var_90_1[iter_90_1]
		local var_90_4 = ClientView.createShaderButton("initiative_icon_s", function(arg_91_0)
			if not arg_90_0._ownerUi._isController then
				return true
			end

			if arg_90_0._battleUi and arg_90_0._battleUi._isAddingBoardCard then
				arg_90_0._ownerUi:sendEvent(PlayerUi.EventType.dialog_adding_board_card)

				return true
			end

			if not ClientData.checkBtnClick() then
				return
			end

			arg_90_0._ownerUi:castInitiativeSkill(var_90_0, var_90_3)
		end)

		var_90_4:setDisabledShader(ClientView.SHADER_DISABLE)
		var_90_4:setEnabled(var_90_0._owner and var_90_0._owner:canUseInitiativeSkill(var_90_0, var_90_3) and (arg_90_0._battleUi == nil or arg_90_0._battleUi._dropLayer == nil) or false)

		local var_90_5 = {
			0,
			6,
			-6,
			10,
			-10,
			6
		}

		local var_90_6 = var_90_5[var_90_0._pos or 1] or 0

		var_90_4:setTouchRect(cc.rect(var_90_6, 0, lc.w(var_90_4) + var_90_6, lc.h(var_90_4)))
		if arg_90_0._scene and arg_90_0._scene.seenByCamera3D then
			arg_90_0._scene:seenByCamera3D(var_90_4)
		end
		lc.addChildToPos(arg_90_0._pEffectArea, var_90_4, cc.p(-60 + iter_90_1 * 30, -100))
		var_90_4:retain()

		arg_90_0._initiativeSkillIcons[iter_90_1] = var_90_4
	end
end

function var_0_0.removeInitiativeSkills(arg_92_0)
	if not arg_92_0._initiativeSkillIcons then return end
	for iter_92_0 = 1, #arg_92_0._initiativeSkillIcons do
		local btn = arg_92_0._initiativeSkillIcons[iter_92_0]
		if btn then
			btn:removeFromParent()
			if btn.release then
				btn:release()
			end
		end
	end

	arg_92_0._initiativeSkillIcons = {}
end

function var_0_0.efcDragonBoneBegin(arg_93_0, arg_93_1, arg_93_2)
	if arg_93_0._statusEfc[arg_93_1] ~= nil then
		return
	end

	if #arg_93_2._aniBegin > 0 then
		arg_93_0._statusEfc[arg_93_1] = arg_93_0:efcDragonBones(arg_93_2._name, arg_93_2._pos, false, arg_93_2._isBottom, arg_93_2._aniBegin, arg_93_2._scale)

		local var_93_0 = arg_93_0._statusEfc[arg_93_1]:getAnimationDuration(arg_93_2._aniBegin)

		arg_93_0._statusEfc[arg_93_1]:runAction(lc.sequence(var_93_0, function()
			if arg_93_0._statusEfc[arg_93_1] ~= nil then
				arg_93_0._statusEfc[arg_93_1]:gotoAndPlay(arg_93_2._aniLoop)
			end
		end))
	else
		arg_93_0._statusEfc[arg_93_1] = arg_93_0:efcDragonBones(arg_93_2._name, arg_93_2._pos, false, arg_93_2._isBottom, arg_93_2._aniLoop, arg_93_2._scale)
	end
end

function var_0_0.efcDragonBoneEnd(arg_95_0, arg_95_1, arg_95_2)
	if arg_95_0._statusEfc[arg_95_1] == nil then
		return
	end

	local var_95_0 = arg_95_0._statusEfc[arg_95_1]

	arg_95_0._statusEfc[arg_95_1] = nil

	if #arg_95_2._aniEnd > 0 then
		var_95_0:gotoAndPlay(arg_95_2._aniEnd)

		local var_95_1 = var_95_0:getAnimationDuration(arg_95_2._aniEnd)

		var_95_0:runAction(lc.sequence(var_95_1, lc.remove()))
	else
		var_95_0:removeFromParent()
	end
end

function var_0_0.efcDragonBoneRemove(arg_96_0, arg_96_1)
	if arg_96_0._statusEfc[arg_96_1] == nil then
		return
	end

	arg_96_0._statusEfc[arg_96_1]:removeFromParent()

	arg_96_0._statusEfc[arg_96_1] = nil
end

function var_0_0.efcDragonBoneReload(arg_97_0, arg_97_1, arg_97_2)
	arg_97_0:efcDragonBoneRemove(arg_97_1)

	arg_97_0._statusEfc[arg_97_1] = arg_97_0:efcDragonBones(arg_97_2._name, arg_97_2._pos, false, arg_97_2._isBottom, arg_97_2._aniLoop, arg_97_2._scale)
end

function var_0_0.efcDragonBones(arg_98_0, arg_98_1, arg_98_2, arg_98_3, arg_98_4, arg_98_5, arg_98_6)
	local var_98_0 = arg_98_2 and arg_98_2 or cc.p(0, 0)

	if arg_98_3 == nil then
		arg_98_3 = true
	end

	local var_98_1 = arg_98_4 and arg_98_0._pBottomEffectArea or arg_98_0._pEffectArea

	if arg_98_1 == "fengsuo" and arg_98_4 == true then
		var_98_1 = arg_98_0._pFrame._frame
	end

	return (arg_98_0._battleUi:createDragonBones(arg_98_1, var_98_0, var_98_1, arg_98_5, arg_98_3, arg_98_6 or 1, 0))
end

function var_0_0.efcDragonBones2(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4, arg_99_5, arg_99_6)
	if arg_99_3 == nil then
		arg_99_3 = true
	end

	local var_99_0 = arg_99_0._pFrame._bones or arg_99_0._pFrame._image
	local var_99_1 = arg_99_2 and arg_99_2 or cc.p(lc.cw(var_99_0), lc.ch(var_99_0))

	return (arg_99_0._battleUi:createDragonBones(arg_99_1, var_99_1, var_99_0, arg_99_5, arg_99_3, arg_99_6 or 1, 0))
end

function var_0_0.efcParticleBegin(arg_100_0, arg_100_1, arg_100_2)
	if arg_100_0._statusEfc[arg_100_1] ~= nil then
		return
	end

	arg_100_0._statusEfc[arg_100_1] = {}

	for iter_100_0 = 1, #arg_100_2 do
		local var_100_0 = arg_100_0:efcParticle(arg_100_2[iter_100_0]._name, arg_100_2[iter_100_0]._pos, arg_100_2[iter_100_0]._isBottom, true)

		var_100_0:setAutoRemoveOnFinish(false)
		table.insert(arg_100_0._statusEfc[arg_100_1], var_100_0)
	end
end

function var_0_0.efcParticleEnd(arg_101_0, arg_101_1)
	if arg_101_0._statusEfc[arg_101_1] == nil then
		return
	end

	for iter_101_0 = 1, #arg_101_0._statusEfc[arg_101_1] do
		arg_101_0._statusEfc[arg_101_1][iter_101_0]:runAction(lc.sequence(0.2, lc.remove()))
	end

	arg_101_0._statusEfc[arg_101_1] = nil
end

function var_0_0.efcParticleRemove(arg_102_0, arg_102_1)
	if arg_102_0._statusEfc[arg_102_1] == nil then
		return
	end

	for iter_102_0 = 1, #arg_102_0._statusEfc[arg_102_1] do
		arg_102_0._statusEfc[arg_102_1][iter_102_0]:removeFromParent()
	end

	arg_102_0._statusEfc[arg_102_1] = nil
end

function var_0_0.efcParticleReload(arg_103_0, arg_103_1, arg_103_2)
	arg_103_0:efcParticleRemove(arg_103_1)
	arg_103_0:efcParticleBegin(arg_103_1, arg_103_2)
end

function var_0_0.efcParticle(arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4, arg_104_5)
	if arg_104_4 == nil then
		arg_104_4 = true
	end

	if arg_104_5 == nil then
		arg_104_5 = arg_104_3 and arg_104_0._pBottomEffectArea or arg_104_0._pEffectArea
	end

	return (arg_104_0._battleUi:createParticle(arg_104_1, arg_104_2, arg_104_5, arg_104_4, 0))
end

function var_0_0.efcSkinEffect(arg_105_0, arg_105_1)
	local var_105_0 = cc.p(0, 0)
	local var_105_1 = true
	local var_105_2 = false
	local var_105_3 = false
	local var_105_4 = "effect"
	local var_105_5 = 1
	local var_105_6 = Data.getEffectNamesById(arg_105_1)

	if var_105_6[1] == "0.0" then
		return
	end

	for iter_105_0 = 1, #var_105_6 do
		local var_105_7 = var_105_6[iter_105_0]

		if var_105_7 == "emozhanchang11" then
			var_105_2 = true
		end

		if tonumber(string.sub(var_105_7, -2, -2)) == 0 then
			arg_105_0:efcParticle(var_105_7, var_105_0, var_105_2, var_105_3)
		else
			var_105_0 = nil

			arg_105_0:efcDragonBones(var_105_7, var_105_0, var_105_1, var_105_2, var_105_4, var_105_5)
		end
	end

	local var_105_8 = Data._skinInfo[arg_105_1]

	if var_105_8._category == 3 and var_105_8._type == Data.SkinEffectType.toBoard then
		(arg_105_0._pFrame._bones or arg_105_0._pFrame._image):runAction(lc.sequence(lc.fadeOut(0), 0.8, lc.fadeIn(0)))
	end
end

function var_0_0.getSkillCount(arg_106_0)
	return #Data.EVO_LV_HERO_UNLOCK_SKILLS
end

function var_0_0.fadeToVisible(arg_107_0, arg_107_1, arg_107_2)
	arg_107_0:areaFadeToVisible(arg_107_0._pCardArea, arg_107_1, arg_107_2)
	arg_107_0:areaFadeToVisible(arg_107_0._pShadowArea, arg_107_1, arg_107_2)
end

function var_0_0.areaFadeToVisible(arg_108_0, arg_108_1, arg_108_2, arg_108_3)
	arg_108_1:stopActionByTag(var_0_2)

	if arg_108_3 ~= 0 then
		local var_108_0 = cc.Sequence:create(arg_108_2 and cc.FadeIn:create(arg_108_3) or cc.FadeOut:create(arg_108_3), cc.CallFunc:create(function()
			arg_108_1:setOpacity(arg_108_2 and 255 or 0)
			arg_108_1:setVisible(arg_108_2)
		end))

		var_108_0:setTag(var_0_2)
		arg_108_1:runAction(var_108_0)
	else
		arg_108_1:setOpacity(arg_108_2 and 255 or 0)
		arg_108_1:setVisible(arg_108_2)
	end
end

function var_0_0.createPropArea(arg_110_0)
	local var_110_0 = lc.createNode()

	var_110_0:setContentSize(ClientView.CARD_SIZE.width, 85)

	local var_110_1 = lc.createSprite({
		_name = "card_dialog_2",
		_crect = cc.rect(14, 0, 2, 85),
		_size = cc.size(ClientView.CARD_SIZE.width, 85)
	})

	lc.addChildToCenter(var_110_0, var_110_1)

	local var_110_2 = lc.createSprite("bat_category")

	lc.addChildToPos(var_110_1, var_110_2, cc.p(lc.w(var_110_1) / 2 - 60, lc.h(var_110_1) - 24))

	local var_110_3 = lc.createSprite("bat_keyword")

	lc.addChildToPos(var_110_1, var_110_3, cc.p(lc.w(var_110_1) / 2 + 60, lc.h(var_110_1) - 24))

	local var_110_4 = lc.createSprite("card_dialog_2_split")

	lc.addChildToPos(var_110_1, var_110_4, cc.p(lc.w(var_110_1) / 2, lc.h(var_110_1) / 2 + 4))

	local var_110_5 = ClientView.createTTF(Str(STR.CARD_CATEGORY_BEGIN + arg_110_0._card._info._category), ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)

	lc.addChildToPos(var_110_1, var_110_5, cc.p(lc.x(var_110_2), 36))
	var_110_5:setScale(0.8)

	local var_110_6 = ClientView.createTTF(Str(STR.CARD_KEYWORD_BEGIN + arg_110_0._card._info._keyword), ClientView.FontSize.S1, ClientView.COLOR_TEXT_DARK)

	lc.addChildToPos(var_110_1, var_110_6, cc.p(lc.x(var_110_3), 36))
	var_110_6:setScale(0.8)

	return var_110_0
end

function var_0_0.playToBoard(arg_111_0, arg_111_1)
	local var_111_0 = arg_111_0._ownerUi
	local var_111_1 = var_111_0._battleUi

	arg_111_0:updateActive(false)

	if arg_111_0:shouldShowNormal() and arg_111_0._status ~= var_0_0.Status.normal then
		arg_111_0:initNormal()
	elseif not arg_111_0:shouldShowNormal() and arg_111_0._status ~= var_0_0.Status.back then
		arg_111_0:initBack()
	end

	if arg_111_0._card._sourceStatus == BattleData.CardStatus.pile then
		arg_111_0:setPosition(cc.p(ClientView.SCR_CW, ClientView.SCR_CH))
	elseif arg_111_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_111_0:replaceHandCards(arg_111_1, arg_111_0._card)

		if arg_111_0._card:hasSkillFast(13190) or arg_111_0._card:hasSkillFast(13191) then
			var_111_0._opponentUi:replaceHandCards(arg_111_1, arg_111_0._card)
		end
	end

	local var_111_2 = cc.p(ClientView.SCR_CW, ClientView.SCR_CH)
	local var_111_3 = cc.p(arg_111_0:getPosition())
	local var_111_4 = arg_111_0._default._position
	local var_111_5 = 1 / var_0_0.Scale.normal
	local var_111_6 = var_111_0:calLengthAndAngle(var_111_2, var_111_3) / 1500
	local var_111_7 = 0.35
	local var_111_8 = arg_111_0._card._statusVal == BattleData.CardStatusVal.g2b_4111
	local var_111_9 = 0.4

	if var_111_8 then
		var_111_9 = 1.2
	elseif arg_111_0._card:isInfoId(10270) or arg_111_0._card:isInfoId(11853) then
		var_111_9 = 4.4
	end

	local var_111_10 = 0

	arg_111_0:runAction(lc.sequence(lc.delay(arg_111_1), lc.call(function()
		arg_111_0:updateZOrder(true)
	end), lc.ease(lc.spawn(lc.moveTo(var_111_6, var_111_8 and var_111_4 or var_111_2), lc.rotateTo(var_111_6, arg_111_0._battleUi._isReverse and -ClientView.BATTLE_ROTATION_X or ClientView.BATTLE_ROTATION_X, 0, 0), lc.scaleTo(var_111_8 and 0 or var_111_6, var_111_8 and 0 or var_111_5)), "BackO"), lc.call(function()
		local var_113_0 = Particle.create("par_kprc01")

		lc.addChildToCenter(arg_111_0, var_113_0, CardSprite.ZOrder.efc)

		local var_113_1 = Particle.create("par_kprc02")

		lc.addChildToCenter(arg_111_0, var_113_1, CardSprite.ZOrder.efc)

		if arg_111_0._card:isInfoId(10006) then
			local var_113_2 = Particle.create("par_kprc03")

			lc.addChildToCenter(arg_111_0, var_113_2, CardSprite.ZOrder.efc)
		elseif arg_111_0._card:isInfoId(10293) then
			local var_113_3 = Particle.create("jsb1")

			lc.addChildToCenter(arg_111_0, var_113_3, CardSprite.ZOrder.efc)

			local var_113_4 = Particle.create("jsb2")

			lc.addChildToCenter(arg_111_0, var_113_4, CardSprite.ZOrder.efc)
		elseif arg_111_0._card:isInfoId(10307) then
			local var_113_5 = Particle.create("v11")

			lc.addChildToCenter(arg_111_0, var_113_5, CardSprite.ZOrder.efc)
		elseif arg_111_0._card:isV12() then
			local var_113_6 = var_111_0:efcDragonBones2("xieshen", "effect", 1, true)

			lc.addChildToPos(var_111_1, var_113_6, var_111_4, BattleUi.ZOrder.effect + 1)

			var_111_10 = var_113_6:getAnimationDuration("effect")
		elseif arg_111_0._card:isV13() then
			local var_113_7 = Particle.create("v13_1")

			lc.addChildToCenter(var_111_1, var_113_7, CardSprite.ZOrder.efc)

			local var_113_8 = Particle.create("v13_2")

			lc.addChildToCenter(var_111_1, var_113_8, CardSprite.ZOrder.efc)
		elseif arg_111_0._card:isInfoId(10270) or arg_111_0._card:isInfoId(11853) then
			local var_113_9 = var_111_0:efcDragonBones2("tkl", "effect", 1, true)

			lc.addChildToPos(var_111_1, var_113_9, cc.p(var_111_4.x, var_111_4.y + 20), BattleUi.ZOrder.effect + 1)

			var_111_10 = var_113_9:getAnimationDuration("effect")
		elseif arg_111_0._card:isInfoId(10896) then
			local var_113_10 = var_111_0:efcDragonBones2("yishenlong", "effect", 1, true)

			lc.addChildToCenter(var_111_1._layer, var_113_10, BattleUi.ZOrder.effect + 1)

			var_111_10 = var_113_10:getAnimationDuration("effect")
		elseif arg_111_0._card:isInfoId(10763) then
			local var_113_11 = var_111_0:efcDragonBones2("yishenlong2", "effect", 1, true)

			lc.addChildToCenter(var_111_1._layer, var_113_11, BattleUi.ZOrder.effect + 1)

			var_111_10 = var_113_11:getAnimationDuration("effect")
		end

		var_111_1._audioEngine:playEffect("e_card_using")
		var_111_1._audioEngine:playHeroAudio(arg_111_0._card._infoId, false)

		if var_111_8 then
			arg_111_0:setVisible(true)

			local var_113_12 = var_111_0:efcDragonBones2("szfs", "effect", 1.3, true)

			lc.addChildToPos(var_111_1, var_113_12, var_111_4, BattleUi.ZOrder.effect + 1)
			lc.offset(var_113_12, 0, 10)

			local var_113_13 = Particle.create("par_szfs")

			arg_111_0._scene:seenByCamera3D(var_113_12)
			lc.addChildToCenter(var_113_12, var_113_13, CardSprite.ZOrder.efc)
		end

		if arg_111_0._status ~= var_0_0.Status.normal then
			arg_111_0:initNormal()
		end
	end), lc.delay(var_111_9), lc.ease(lc.spawn(lc.moveTo(var_111_7, var_111_4), lc.rotateTo(var_111_7, 0, 0, 0), lc.scaleTo(var_111_7, 1)), "O", 0.4), lc.call(function()
		var_111_1._audioEngine:playEffect("e_card_board")

		local var_114_0 = Particle.create("par_yhcx")

		lc.addChildToCenter(arg_111_0, var_114_0, CardSprite.ZOrder.efc)
		arg_111_0:initFight()
		arg_111_0:updateZOrder()
		arg_111_0._pFrame._image:setScale(0.6)
		arg_111_0._pFrame._image:runAction(lc.sequence(lc.scaleTo(0.2, ClientView.getCardBattleScale(arg_111_0._card._infoId) * 1.1), lc.scaleTo(0.1, ClientView.getCardBattleScale(arg_111_0._card._infoId))))

		if ClientData._cfg and ClientData._cfg.testEffects then
			if ClientData._cfg.testEffects == true then
				local var_114_1 = {
					"busiruchang11",
					"emoruchang11",
					"jixieruchang11",
					"longzuruchang11",
					"mofashiruchang11",
					"niandongliruchang11",
					"niaoshouruchang11",
					"tianshiruchang11",
					"yanshiruchang11",
					"yanzuruchang11",
					"shuiruchang11"
				}

				Data._ruchangIndex = Data._ruchangIndex or 0
				Data._ruchangIndex = (Data._ruchangIndex + 1) % #var_114_1 + 1

				local var_114_2 = cc.p(0, 0)
				local var_114_3 = true
				local var_114_4 = false
				local var_114_5 = false
				local var_114_6 = "effect"
				local var_114_7 = 1

				arg_111_0:efcDragonBones(var_114_1[Data._ruchangIndex], var_114_2, var_114_3, var_114_4, var_114_6, var_114_7)
			elseif ClientData._cfg.testEffects.toBoard then
				local var_114_8
				local var_114_9 = true
				local var_114_10 = false
				local var_114_11 = false
				local var_114_12 = "effect"
				local var_114_13 = 1

				arg_111_0:efcDragonBones2(ClientData._cfg.testEffects.toBoard, var_114_8, var_114_9, var_114_10, var_114_12, var_114_13)
			end
		else
			local var_114_14 = arg_111_0:getEffectByType(Data.SkinEffectType.toBoard)

			if var_114_14 then
				arg_111_0:efcSkinEffect(var_114_14)
			end
		end

		var_111_0:updateBoardCardsActive()
	end)))
	arg_111_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_111_1), lc.spawn(lc.moveTo(var_111_6, cc.p(-100, -50)), lc.scaleTo(var_111_6, 0.6), lc.fadeTo(var_111_6, 200)), lc.delay(0.4), lc.spawn(lc.moveTo(var_111_7, cc.p(0, 0)), lc.scaleTo(var_111_7, 1), lc.fadeTo(var_111_7, 255))))

	return arg_111_1 + var_111_6 + (var_111_8 and 1.2 or 0.4) + var_111_7 + 0.3 + 0.1 + var_111_10
end

function var_0_0.playEmptyToBoard(arg_115_0, arg_115_1)
	local var_115_0 = arg_115_0._ownerUi
	local var_115_1 = var_115_0._opponentUi
	local var_115_2 = var_115_0._battleUi

	arg_115_0:updateActive(false)
	arg_115_0:setVisible(false)
	arg_115_0:setPosition(arg_115_0._default._position)

	if arg_115_0._card._statusVal == BattleData.CardStatusVal.e2b_3136 then
		arg_115_1 = arg_115_1 + 1
	end

	arg_115_0:runAction(lc.sequence(lc.delay(arg_115_1), lc.call(function()
		arg_115_0:updateZOrder(true)
		var_115_0:efcParticle("par_cs1", arg_115_0._default._position, false, false)
		var_115_2._audioEngine:playEffect("e_wzsy")
	end), lc.delay(0.3), lc.call(function()
		var_115_0:efcParticle("par_cs2", arg_115_0._default._position, false, false)
	end), lc.delay(0.3), lc.call(function()
		var_115_0:efcParticle("par_cs3", arg_115_0._default._position, false, false)
		arg_115_0:setVisible(true)
		arg_115_0:setOpacity(255)
		arg_115_0:updateZOrder()
		var_115_0:updateBoardCardsActive()
		var_115_2._audioEngine:playHeroAudio(arg_115_0._card._infoId, false)
	end)))

	return arg_115_1 + 0.3 + 0.3
end

function var_0_0.playBoardToBoard(arg_119_0, arg_119_1)
	local var_119_0 = arg_119_0._ownerUi
	local var_119_1 = var_119_0._opponentUi
	local var_119_2 = var_119_0._battleUi

	arg_119_0:updateActive(false)

	local var_119_3 = cc.p(arg_119_0:getPosition())
	local var_119_4 = arg_119_0._default._position
	local var_119_5 = var_119_0:calLengthAndAngle(var_119_3, var_119_4)
	local var_119_6 = math.sqrt(var_119_5) / 30 + 0.02

	arg_119_0:runAction(lc.sequence(lc.delay(arg_119_1), lc.call(function()
		arg_119_0:updateZOrder(true)
	end), lc.moveTo(var_119_6, var_119_4), lc.call(function()
		arg_119_0:updateZOrder()
		arg_119_0:updateAtkHp()
		arg_119_0._pCardArea:setScale(arg_119_0:isSmall() and CardSprite.Scale.normal_small or CardSprite.Scale.normal)
		var_119_0:updateBoardCardsActive()
	end)))

	return arg_119_1 + var_119_6
end

function var_0_0.playBoardToGrave(arg_122_0, arg_122_1)
	local var_122_0 = arg_122_0._ownerUi
	local var_122_1 = var_122_0._battleUi

	arg_122_0:updateActive(false)
	arg_122_0:runAction(lc.sequence(lc.delay(arg_122_1), lc.call(function()
		arg_122_0:updateZOrder(true)
		var_122_0:efcCardDie(arg_122_0)
	end), lc.delay(0.4), lc.call(function()
		var_122_0:addGraveCard(arg_122_0)
		arg_122_0:updateZOrder()
	end)))

	return arg_122_1 + 0.5
end

function var_0_0.playToRare(arg_125_0, arg_125_1)
	local var_125_0 = arg_125_0._ownerUi
	local var_125_1 = var_125_0._battleUi

	arg_125_0:updateActive(false)
	arg_125_0:runAction(lc.sequence(lc.delay(arg_125_1), lc.call(function()
		arg_125_0:updateZOrder(true)
		var_125_0:efcCardDie(arg_125_0)
	end), lc.delay(0.4), lc.call(function()
		var_125_0:addRareCard(arg_125_0)
		arg_125_0:updateZOrder()
	end)))

	return arg_125_1 + 0.5
end

function var_0_0.playToGrave(arg_128_0, arg_128_1)
	local var_128_0 = arg_128_0._ownerUi
	local var_128_1 = var_128_0._opponentUi
	local var_128_2 = var_128_0._battleUi

	arg_128_0:updateActive(false)

	if arg_128_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_128_0:replaceHandCards(arg_128_1, arg_128_0._card)
	end

	local var_128_3 = cc.p(ClientView.SCR_CW - 440, ClientView.SCR_CH)
	local var_128_4 = cc.p(arg_128_0:getPosition())
	local var_128_5 = var_128_0:calLengthAndAngle(var_128_3, var_128_4) / 1500
	local var_128_6 = 1 / var_0_0.Scale.normal

	if arg_128_0._card._triggerCard ~= nil and arg_128_0._card._triggerCard._infoId == 40212 then
		var_128_5 = 0.1
	end

	arg_128_0:runAction(lc.sequence(lc.delay(arg_128_1), lc.call(function()
		arg_128_0:updateZOrder(true)
	end), lc.ease(lc.spawn(lc.moveTo(var_128_5, var_128_3), lc.rotateTo(var_128_5, 0), lc.scaleTo(var_128_5, var_128_6)), "BackO"), lc.call(function()
		var_128_0:efcNormalCardDie(arg_128_0, true)
	end), lc.delay(0.2), lc.call(function()
		var_128_0:addGraveCard(arg_128_0)
		arg_128_0:updateZOrder()
	end)))
	arg_128_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_128_1), lc.spawn(lc.moveTo(var_128_5, cc.p(-100, -50)), lc.scaleTo(var_128_5, 0.6), lc.fadeTo(0.2, 200))))

	return arg_128_1 + var_128_5 + 0.2
end

function var_0_0.fastToGrave(arg_132_0, arg_132_1)
	local var_132_0 = arg_132_0._ownerUi
	local var_132_1 = var_132_0._opponentUi
	local var_132_2 = var_132_0._battleUi

	arg_132_0:updateActive(false)
	arg_132_0:setScale(1 / var_0_0.Scale.normal)
	var_132_0:addGraveCard(arg_132_0)
	arg_132_0:updateZOrder()

	return arg_132_1
end

function var_0_0.playToCover(arg_133_0, arg_133_1)
	local var_133_0 = arg_133_0._ownerUi
	local var_133_1 = var_133_0._opponentUi
	local var_133_2 = var_133_0._battleUi

	arg_133_0:updateActive(false)

	if arg_133_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_133_0:replaceHandCards(arg_133_1, arg_133_0._card)
	end

	local var_133_3 = cc.p(ClientView.SCR_CW + 440, ClientView.SCR_CH)
	local var_133_4 = cc.p(arg_133_0:getPosition())
	local var_133_5 = var_133_0:calLengthAndAngle(var_133_3, var_133_4) / 1500 + 0.1
	local var_133_6 = 1 / var_0_0.Scale.normal

	arg_133_0:runAction(lc.sequence(lc.delay(arg_133_1), lc.call(function()
		arg_133_0:updateZOrder(true)
	end), lc.ease(lc.spawn(lc.moveTo(var_133_5, var_133_3), lc.rotateTo(var_133_5, 0), lc.scaleTo(var_133_5, var_133_6)), "BackO"), lc.delay(0.2), lc.call(function()
		var_133_0:addCoverCard(arg_133_0)
		arg_133_0:updateZOrder()
		var_133_0._audioEngine:playEffect("e_card_cover")
	end)))
	arg_133_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_133_1), lc.spawn(lc.moveTo(var_133_5, cc.p(-100, -50)), lc.scaleTo(var_133_5, 0.6), lc.fadeTo(0.2, 200))))

	return arg_133_1 + var_133_5 + 0.2
end

function var_0_0.playToShow(arg_136_0, arg_136_1)
	local var_136_0 = arg_136_0._ownerUi
	local var_136_1 = var_136_0._opponentUi
	local var_136_2 = var_136_0._battleUi

	arg_136_0:updateActive(false)

	if arg_136_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_136_0:replaceHandCards(arg_136_1, arg_136_0._card)
	end

	local var_136_3 = cc.p(ClientView.SCR_CW + 440, ClientView.SCR_CH)
	local var_136_4 = cc.p(arg_136_0:getPosition())
	local var_136_5 = var_136_0:calLengthAndAngle(var_136_3, var_136_4) / 1500 + 0.1
	local var_136_6 = 1 / var_0_0.Scale.normal

	arg_136_0:runAction(lc.sequence(lc.delay(arg_136_1), lc.call(function()
		arg_136_0:updateZOrder(true)
	end), lc.ease(lc.spawn(lc.moveTo(var_136_5, var_136_3), lc.rotateTo(var_136_5, 0), lc.scaleTo(var_136_5, var_136_6)), "BackO"), lc.call(function()
		var_136_0:efcNormalCardDie(arg_136_0, false)
	end), lc.delay(0.2), lc.call(function()
		var_136_0:addShowCard(arg_136_0)
		arg_136_0:updateZOrder()
	end)))
	arg_136_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_136_1), lc.spawn(lc.moveTo(var_136_5, cc.p(-100, -50)), lc.scaleTo(var_136_5, 0.6), lc.fadeTo(0.2, 200))))

	return arg_136_1 + var_136_5 + 0.2
end

function var_0_0.playCoverToShow(arg_140_0, arg_140_1)
	local var_140_0 = arg_140_0._ownerUi
	local var_140_1 = var_140_0._opponentUi
	local var_140_2 = var_140_0._battleUi

	arg_140_0:updateActive(false)

	local var_140_3 = cc.p(arg_140_0:getPosition())

	arg_140_0:runAction(lc.sequence(lc.delay(arg_140_1), lc.call(function()
		local var_141_0 = Particle.create("par_xjfz")

		lc.addChildToPos(var_140_2, var_141_0, var_140_3, BattleUi.ZOrder.effect)
		var_140_0:efcCardFlip(arg_140_0)
		var_140_2._scene:seenByCamera3D(var_141_0)
	end)))

	return arg_140_1 + 0.9
end

function var_0_0.playToField(arg_142_0, arg_142_1)
	local var_142_0 = arg_142_0._ownerUi
	local var_142_1 = var_142_0._opponentUi
	local var_142_2 = var_142_0._battleUi

	arg_142_0:updateActive(false)

	if arg_142_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_142_0:replaceHandCards(arg_142_1, arg_142_0._card)
	end

	local var_142_3 = cc.p(ClientView.SCR_CW + 440, ClientView.SCR_CH)
	local var_142_4 = cc.p(arg_142_0:getPosition())
	local var_142_5 = var_142_0:calLengthAndAngle(var_142_3, var_142_4) / 1500 + 0.1
	local var_142_6 = 1 / var_0_0.Scale.normal

	arg_142_0:runAction(lc.sequence(lc.delay(arg_142_1), lc.call(function()
		arg_142_0:updateZOrder(true)
	end), lc.ease(lc.spawn(lc.moveTo(var_142_5, var_142_3), lc.rotateTo(var_142_5, 0), lc.scaleTo(var_142_5, var_142_6)), "BackO"), lc.call(function()
		var_142_0:efcNormalCardDie(arg_142_0, false)
	end), lc.delay(0.2), lc.call(function()
		var_142_0:addFieldCard(arg_142_0)
		arg_142_0:updateZOrder()
	end)))
	arg_142_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_142_1), lc.spawn(lc.moveTo(var_142_5, cc.p(-100, -50)), lc.scaleTo(var_142_5, 0.6), lc.fadeTo(0.2, 200))))

	return arg_142_1 + var_142_5 + 0.2
end

function var_0_0.playToPile(arg_146_0, arg_146_1)
	local var_146_0 = arg_146_0._ownerUi
	local var_146_1 = var_146_0._opponentUi
	local var_146_2 = var_146_0._battleUi

	arg_146_0:updateActive(false)

	if arg_146_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_146_0:replaceHandCards(arg_146_1, arg_146_0._card)
	end

	if arg_146_0:shouldShowNormal() and arg_146_0._status ~= var_0_0.Status.normal then
		arg_146_0:initNormal()
	elseif not arg_146_0:shouldShowNormal() and arg_146_0._status ~= var_0_0.Status.back then
		arg_146_0:initBack()
	end

	local var_146_3 = cc.p(ClientView.SCR_CW + 440, ClientView.SCR_CH)
	local var_146_4 = cc.p(ClientView.SCR_W, ClientView.SCR_CH + (var_146_0._isController and -200 or 200))
	local var_146_5 = cc.p(arg_146_0:getPosition())
	local var_146_6 = var_146_0:calLengthAndAngle(var_146_3, var_146_5) / 1500 + 0.1
	local var_146_7 = 0.4
	local var_146_8 = 1 / var_0_0.Scale.normal

	arg_146_0:runAction(lc.sequence(lc.delay(arg_146_1), lc.call(function()
		arg_146_0:updateZOrder(true)
	end), lc.ease(lc.spawn(lc.moveTo(var_146_6, var_146_3), lc.rotateTo(var_146_6, 0), lc.scaleTo(var_146_6, var_146_8)), "BackO"), lc.delay(0.1), lc.ease(lc.spawn(lc.moveTo(var_146_7, var_146_4), lc.rotateTo(var_146_7, 90, 0, 90), lc.scaleTo(var_146_7, 1)), "BackO"), lc.call(function()
		var_146_0:hideCardSprite(arg_146_0)
	end)))
	arg_146_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_146_1), lc.spawn(lc.moveTo(var_146_6, cc.p(-100, -50)), lc.scaleTo(var_146_6, 0.6), lc.fadeTo(0.2, 200)), lc.delay(0.1), lc.ease(lc.rotateTo(var_146_7, 90, 0, 90))))

	return arg_146_1 + 0.1 + var_146_6 + var_146_7
end

function var_0_0.fastToPile(arg_149_0, arg_149_1)
	local var_149_0 = arg_149_0._ownerUi
	local var_149_1 = var_149_0._opponentUi
	local var_149_2 = var_149_0._battleUi

	arg_149_0:updateActive(false)

	if arg_149_0:shouldShowNormal() and arg_149_0._status ~= var_0_0.Status.normal then
		arg_149_0:initNormal()
	elseif not arg_149_0:shouldShowNormal() and arg_149_0._status ~= var_0_0.Status.back then
		arg_149_0:initBack()
	end

	var_149_0:hideCardSprite(arg_149_0)

	return arg_149_1
end

function var_0_0.playToLeave(arg_150_0, arg_150_1, arg_150_2)
	local var_150_0 = arg_150_0._ownerUi
	local var_150_1 = var_150_0._opponentUi
	local var_150_2 = var_150_0._battleUi

	arg_150_0:updateActive(false)

	if arg_150_2 then
		arg_150_0:initNormal()
	end

	if arg_150_0._card._sourceStatus == BattleData.CardStatus.hand then
		var_150_0:replaceHandCards(arg_150_1, arg_150_0._card)
	end

	local var_150_3 = cc.p(ClientView.SCR_CW - 440, ClientView.SCR_CH)
	local var_150_4 = cc.p(-100, ClientView.SCR_CH + (var_150_0._isController and -200 or 200))
	local var_150_5 = cc.p(arg_150_0:getPosition())
	local var_150_6 = var_150_0:calLengthAndAngle(var_150_3, var_150_5) / 1500 + 0.1
	local var_150_7 = 0.4
	local var_150_8 = 1 / var_0_0.Scale.normal

	arg_150_0:runAction(lc.sequence(lc.delay(arg_150_1), lc.call(function()
		arg_150_0:updateZOrder(true)
	end), lc.ease(lc.spawn(lc.moveTo(var_150_6, var_150_3), lc.rotateTo(var_150_6, 0), lc.scaleTo(var_150_6, var_150_8)), "BackO"), lc.delay(0.1), lc.ease(lc.spawn(lc.moveTo(var_150_7, var_150_4), lc.scaleTo(var_150_7, 1)), "BackO"), lc.call(function()
		var_150_0:hideCardSprite(arg_150_0)
	end)))
	arg_150_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_150_1), lc.spawn(lc.moveTo(var_150_6, cc.p(-100, -50)), lc.scaleTo(var_150_6, 0.6), lc.fadeTo(0.2, 200))))

	return arg_150_1 + 0.1 + var_150_6 + var_150_7
end

function var_0_0.playBoardToLeave(arg_153_0, arg_153_1)
	local var_153_0 = arg_153_0._ownerUi
	local var_153_1 = var_153_0._battleUi

	arg_153_0:updateActive(false)
	arg_153_0:runAction(lc.sequence(lc.delay(arg_153_1), lc.call(function()
		arg_153_0:updateZOrder(true)
		var_153_0:efcCardDie(arg_153_0)
	end), lc.delay(0.4), lc.call(function()
		var_153_0:hideCardSprite(arg_153_0)
	end)))

	return arg_153_1 + 0.5
end

function var_0_0.playToHand(arg_156_0, arg_156_1, arg_156_2)
	local var_156_0 = arg_156_0._ownerUi
	local var_156_1 = var_156_0._opponentUi
	local var_156_2 = var_156_0._battleUi

	arg_156_0:updateActive(false)
	var_156_0:replaceHandCards(arg_156_1, arg_156_0._card)

	if arg_156_0._card._statusVal == BattleData.CardStatusVal.h2h_oppo then
		var_156_0._opponentUi:replaceHandCards(arg_156_1, arg_156_0._card)
	end

	if arg_156_2 then
		arg_156_0:initNormal()
	elseif arg_156_0:shouldShowNormal() and arg_156_0._status ~= var_0_0.Status.normal then
		arg_156_0:initNormal()
	elseif not arg_156_0:shouldShowNormal() and arg_156_0._status ~= var_0_0.Status.back then
		arg_156_0:initBack()
	end

	local var_156_3 = cc.p(ClientView.SCR_CW + (arg_156_2 and 0 or 300), ClientView.SCR_CH + (arg_156_2 and 0 or var_156_0._isController and -100 or 200))
	local var_156_4 = var_156_0._isController and 0.25 or 0.15
	local var_156_5 = arg_156_2 and 2 or var_156_0._isController and 1 / var_0_0.Scale.normal or 1
	local var_156_6 = arg_156_0._default._position
	local var_156_7 = arg_156_0._default._rotation
	local var_156_8 = arg_156_2 and 2 or 0

	arg_156_0:runAction(lc.sequence(lc.delay(arg_156_1), lc.call(function()
		arg_156_0:updateZOrder(true)
		var_156_0._audioEngine:playEffect("e_card_deal")
	end), lc.ease(lc.spawn(lc.moveTo(var_156_4, var_156_3), lc.rotateTo(var_156_4, arg_156_0._battleUi._isReverse and -ClientView.BATTLE_ROTATION_X or ClientView.BATTLE_ROTATION_X, 0, 0), lc.scaleTo(var_156_4, var_156_5)), "BackO"), lc.delay(var_156_8), lc.call(function()
		if arg_156_2 and not arg_156_0:shouldShowNormal() then
			arg_156_0:initBack()
		end
	end), lc.ease(lc.spawn(lc.moveTo(0.3, var_156_6), lc.rotateTo(0.3, var_156_7), lc.scaleTo(0.3, 1)), "O", 2.5), lc.call(function()
		arg_156_0:updateZOrder()
	end)))
	arg_156_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_156_1), lc.spawn(lc.moveTo(var_156_4, cc.p(-100, -50)), lc.scaleTo(var_156_4, 0.6), lc.fadeTo(var_156_4, 200)), lc.spawn(lc.moveTo(0.3, cc.p(0, 0)), lc.scaleTo(0.3, 1), lc.fadeTo(0.3, 255))))

	return arg_156_1 + var_156_4 + var_156_8, arg_156_1 + var_156_4 + var_156_8 + 0.3
end

function var_0_0.playRetrievToPile(arg_160_0, arg_160_1)
	local var_160_0 = arg_160_0._ownerUi
	local var_160_1 = var_160_0._opponentUi
	local var_160_2 = var_160_0._battleUi

	arg_160_0:updateActive(false)

	local var_160_3 = cc.p(ClientView.SCR_W, ClientView.SCR_CH + (var_160_0._isController and -200 or 200))
	local var_160_4 = 0.6

	arg_160_0:runAction(lc.sequence(lc.delay(arg_160_1), lc.call(function()
		arg_160_0:updateZOrder(true)
	end), lc.ease(lc.spawn(lc.moveTo(var_160_4, var_160_3), lc.rotateTo(var_160_4, 90, 0, 0), lc.scaleTo(var_160_4, 1)), "BackO"), lc.call(function()
		var_160_0:hideCardSprite(arg_160_0)
	end)))
	arg_160_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_160_1), lc.ease(lc.rotateTo(var_160_4, 90, 0, 0))))

	return arg_160_1 + var_160_4
end

function var_0_0.playRetrievToLeave(arg_163_0, arg_163_1)
	local var_163_0 = arg_163_0._ownerUi
	local var_163_1 = var_163_0._opponentUi
	local var_163_2 = var_163_0._battleUi

	arg_163_0:updateActive(false)

	local var_163_3 = cc.p(-100, ClientView.SCR_CH + (var_163_0._isController and -200 or 200))
	local var_163_4 = 0.4

	arg_163_0:runAction(lc.sequence(lc.delay(arg_163_1), lc.call(function()
		arg_163_0:updateZOrder(true)
	end), lc.ease(lc.spawn(lc.moveTo(var_163_4, var_163_3), lc.rotateTo(var_163_4, 0), lc.scaleTo(var_163_4, 1)), "BackO"), lc.call(function()
		var_163_0:hideCardSprite(arg_163_0)
	end)))
	arg_163_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_163_1), lc.ease(lc.rotateTo(var_163_4, 90, 0, 0))))

	return arg_163_1 + var_163_4
end

function var_0_0.playRetrievToHand(arg_166_0, arg_166_1)
	local var_166_0 = arg_166_0._ownerUi
	local var_166_1 = var_166_0._opponentUi
	local var_166_2 = var_166_0._battleUi

	arg_166_0:updateActive(false)
	var_166_0:replaceHandCards(arg_166_1, arg_166_0._card)

	local var_166_3 = arg_166_0._default._position
	local var_166_4 = arg_166_0._default._rotation

	arg_166_0:runAction(lc.sequence(lc.delay(arg_166_1), lc.call(function()
		arg_166_0:updateZOrder(true)
	end), lc.ease(lc.spawn(lc.moveTo(0.4, var_166_3), lc.rotateTo(0.4, var_166_4), lc.scaleTo(0.4, 1)), "O", 2.5), lc.call(function()
		arg_166_0:updateZOrder()
	end)))
	arg_166_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_166_1), lc.spawn(lc.moveTo(0.4, cc.p(0, 0)), lc.scaleTo(0.4, 1), lc.fadeTo(0.4, 255))))

	return arg_166_1 + 0.4
end

function var_0_0.playCoverRetriev(arg_169_0, arg_169_1)
	local var_169_0 = arg_169_0._ownerUi
	local var_169_1 = var_169_0._opponentUi
	local var_169_2 = var_169_0._battleUi
	local var_169_3 = 1 / CardSprite.Scale.normal
	local var_169_4 = cc.p(arg_169_0:getPosition())
	local var_169_5 = cc.p(ClientView.SCR_CW + 440, ClientView.SCR_CH)

	arg_169_0:runAction(lc.sequence(lc.delay(arg_169_1), lc.call(function()
		arg_169_0:updateZOrder(true)

		local var_170_0 = var_169_0:efcDragonBones2("zh", "effect1", 1, true)

		lc.addChildToPos(var_169_2, var_170_0, var_169_4, BattleUi.ZOrder.card_board + 1)
		var_169_2._scene:seenByCamera3D(var_170_0)
	end), lc.delay(0.6), lc.call(function()
		if arg_169_0:shouldShowNormal() then
			arg_169_0:initNormal()
		else
			arg_169_0:initBack()
		end
	end), lc.ease(lc.spawn(lc.scaleTo(0.2, var_169_3), lc.moveTo(0.2, var_169_5)), "BackO")))
	arg_169_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_169_1 + 0.6), lc.spawn(lc.moveTo(0.2, cc.p(-100, -50)), lc.scaleTo(0.2, 0.6), lc.fadeTo(0.2, 200))))

	return arg_169_1 + 0.8
end

function var_0_0.playGraveRetriev(arg_172_0, arg_172_1)
	local var_172_0 = arg_172_0._ownerUi
	local var_172_1 = var_172_0._opponentUi
	local var_172_2 = var_172_0._battleUi
	local var_172_3 = 1 / CardSprite.Scale.normal
	local var_172_4 = var_172_0._isController and PlayerUi.Pos.attacker_grave or PlayerUi.Pos.defender_grave
	local var_172_5 = cc.p(ClientView.SCR_CW - 440, ClientView.SCR_CH)

	if arg_172_0._card._statusVal == BattleData.CardStatusVal.g2h_oppo then
		var_172_4 = not var_172_0._isController and PlayerUi.Pos.attacker_grave or PlayerUi.Pos.defender_grave
	end

	local var_172_6 = lc.sequence(lc.delay(arg_172_1), lc.call(function()
		arg_172_0:updateZOrder(true)

		local var_173_0 = var_172_0:efcDragonBones2("zh", "effect1", 1, true)

		lc.addChildToPos(var_172_2, var_173_0, var_172_4, BattleUi.ZOrder.card + 1)
		var_172_0._scene:seenByCamera3D(var_173_0)
	end), lc.delay(0.6), lc.call(function()
		if arg_172_0._card._statusVal == BattleData.CardStatusVal.g2b_4111 then
			arg_172_0:setVisible(false)
		else
			arg_172_0:setVisible(true)
		end

		arg_172_0:setOpacity(255)
		arg_172_0:setPosition(var_172_4)

		if arg_172_0:shouldShowNormal() then
			arg_172_0:initNormal()
		else
			arg_172_0:initBack()
		end
	end), lc.ease(lc.spawn(lc.scaleTo(0.4, var_172_3), lc.moveTo(0.4, var_172_5)), "BackO"))

	var_172_6._dontFixPos = true

	arg_172_0:runAction(var_172_6)
	arg_172_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_172_1 + 0.6), lc.spawn(lc.moveTo(0.4, cc.p(-100, -50)), lc.scaleTo(0.4, 0.6), lc.fadeTo(0.4, 200))))

	return arg_172_1 + 1
end

function var_0_0.playBoardRetriev(arg_175_0, arg_175_1)
	local var_175_0 = arg_175_0._ownerUi
	local var_175_1 = 1 / CardSprite.Scale.normal

	arg_175_0:runAction(lc.sequence(lc.delay(arg_175_1), lc.call(function()
		arg_175_0:updateZOrder(true)
		var_175_0:efcDragonBones(arg_175_0, "tuika", cc.p(0, -10), true, false, "effect", 2.4)
	end), lc.ease(lc.scaleTo(0.1, var_175_1 - 0.2), "O", 2.5), lc.call(function()
		if arg_175_0:shouldShowNormal() then
			arg_175_0:initNormal()
		else
			arg_175_0:initBack()
		end
	end), lc.ease(lc.scaleTo(0.1, var_175_1), "BackO")))
	arg_175_0._pShadowArea:runAction(lc.sequence(lc.delay(arg_175_1), lc.spawn(lc.moveTo(0.1, cc.p(-100, -50)), lc.scaleTo(0.3, 0.6), lc.fadeTo(0.3, 200))))

	return arg_175_1 + 0.4
end

function var_0_0.getEffectByType(arg_178_0, arg_178_1)
	local var_178_0
	local var_178_1 = arg_178_0._ownerUi._player._effects[arg_178_0._card._infoId]

	if not var_178_1 then
		return nil
	end

	for iter_178_0, iter_178_1 in ipairs(var_178_1) do
		if Data._skinInfo[iter_178_1]._type == arg_178_1 then
			var_178_0 = iter_178_1

			break
		end
	end

	return var_178_0
end

function var_0_0.isSmall(arg_179_0)
	return arg_179_0._card._owner:hasEx() and (arg_179_0._card._pos == 2 or arg_179_0._card._pos == 6)
end

return var_0_0
